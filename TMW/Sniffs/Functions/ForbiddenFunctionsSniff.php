<?php
/**
 * Generic_Sniffs_PHP_ForbiddenFunctionsSniff.
 *
 * PHP version 5
 *
 * @category  PHP
 * @package   PHP_CodeSniffer
 * @author    Greg Sherwood <gsherwood@squiz.net>
 * @author    Marc McIntyre <mmcintyre@squiz.net>
 * @copyright 2006-2014 Squiz Pty Ltd (ABN 77 084 670 600)
 * @license   https://github.com/squizlabs/PHP_CodeSniffer/blob/master/licence.txt BSD Licence
 * @link      http://pear.php.net/package/PHP_CodeSniffer
 */

/**
 * Generic_Sniffs_PHP_ForbiddenFunctionsSniff.
 *
 * Discourages the use of alias functions that are kept in PHP for compatibility
 * with older versions. Can be used to forbid the use of any function.
 *
 * @category  PHP
 * @package   PHP_CodeSniffer
 * @author    Greg Sherwood <gsherwood@squiz.net>
 * @author    Marc McIntyre <mmcintyre@squiz.net>
 * @copyright 2006-2014 Squiz Pty Ltd (ABN 77 084 670 600)
 * @license   https://github.com/squizlabs/PHP_CodeSniffer/blob/master/licence.txt BSD Licence
 * @version   Release: 2.3.4
 * @link      http://pear.php.net/package/PHP_CodeSniffer
 */
class TMW_Sniffs_Functions_ForbiddenFunctionsSniff implements PHP_CodeSniffer_Sniff
{

    /**
     * A list of forbidden functions with their alternatives.
     *
     * The value is NULL if no alternative exists. IE, the
     * function should just not be used.
     *
     * @var array(string => string|null)
     */
    public $forbiddenFunctions = array(
		'eval' => null,
		'range' => 'Iterator',
		'mysql_affected_rows' => 'PDO',
		'mysql_client_encoding' => 'PDO',
		'mysql_close' => 'PDO',
		'mysql_connect' => 'PDO',
		'mysql_create_db' => 'PDO',
		'mysql_data_seek' => 'PDO',
		'mysql_db_name' => 'PDO',
		'mysql_db_query' => 'PDO',
		'mysql_drop_db' => 'PDO',
		'mysql_errno' => 'PDO',
		'mysql_error' => 'PDO',
		'mysql_escape_string' => 'PDO',
		'mysql_fetch_array' => 'PDO',
		'mysql_fetch_assoc' => 'PDO',
		'mysql_fetch_field' => 'PDO',
		'mysql_fetch_lengths' => 'PDO',
		'mysql_fetch_object' => 'PDO',
		'mysql_fetch_row' => 'PDO',
		'mysql_field_flags' => 'PDO',
		'mysql_field_len' => 'PDO',
		'mysql_field_name' => 'PDO',
		'mysql_field_seek' => 'PDO',
		'mysql_field_table' => 'PDO',
		'mysql_field_type' => 'PDO',
		'mysql_free_result' => 'PDO',
		'mysql_get_client_info' => 'PDO',
		'mysql_get_host_info' => 'PDO',
		'mysql_get_proto_info' => 'PDO',
		'mysql_get_server_info' => 'PDO',
		'mysql_info' => 'PDO',
		'mysql_insert_id' => 'PDO',
		'mysql_list_dbs' => 'PDO',
		'mysql_list_fields' => 'PDO',
		'mysql_list_processes' => 'PDO',
		'mysql_list_tables' => 'PDO',
		'mysql_num_fields' => 'PDO',
		'mysql_num_rows' => 'PDO',
		'mysql_pconnect' => 'PDO',
		'mysql_ping' => 'PDO',
		'mysql_query' => 'PDO',
		'mysql_real_escape_string' => 'PDO',
		'mysql_result' => 'PDO',
		'mysql_select_db' => 'PDO',
		'mysql_set_charset' => 'PDO',
		'mysql_stat' => 'PDO',
		'mysql_tablename' => 'PDO',
		'mysql_thread_id' => 'PDO',
		'mysql_unbuffered_query' => 'PDO',
		'stripslashes' => 'filter_var()',
		'addslashes' => 'filter_var()',
		'ereg' => 'preg_match()',
		'ereg_replace' => 'preg_replace()',
		'eregi_replace' => 'preg_replace()',
		'quotemeta' => 'filter_var()',
		'phpinfo' => null
	);

    /**
     * A cache of forbidden function names, for faster lookups.
     *
     * @var array(string)
     */
    protected $forbiddenFunctionNames = array();

    /**
     * If true, forbidden functions will be considered regular expressions.
     *
     * @var bool
     */
    protected $patternMatch = false;

    /**
     * If true, an error will be thrown; otherwise a warning.
     *
     * @var bool
     */
    public $error = true;


    /**
     * Returns an array of tokens this test wants to listen for.
     *
     * @return array
     */
    public function register()
    {
        // Everyone has had a chance to figure out what forbidden functions
        // they want to check for, so now we can cache out the list.
        $this->forbiddenFunctionNames = array_keys($this->forbiddenFunctions);

        if ($this->patternMatch === true) {
            foreach ($this->forbiddenFunctionNames as $i => $name) {
                $this->forbiddenFunctionNames[$i] = '/'.$name.'/i';
            }

            return array(T_STRING);
        }

        // If we are not pattern matching, we need to work out what
        // tokens to listen for.
        $string = '<?php ';
        foreach ($this->forbiddenFunctionNames as $name) {
            $string .= $name.'();';
        }

        $register = array();

        $tokens = token_get_all($string);
        array_shift($tokens);
        foreach ($tokens as $token) {
            if (is_array($token) === true) {
                $register[] = $token[0];
            }
        }

        return array_unique($register);

    }//end register()


    /**
     * Processes this test, when one of its tokens is encountered.
     *
     * @param PHP_CodeSniffer_File $phpcsFile The file being scanned.
     * @param int                  $stackPtr  The position of the current token in
     *                                        the stack passed in $tokens.
     *
     * @return void
     */
    public function process(PHP_CodeSniffer_File $phpcsFile, $stackPtr)
    {
        $tokens = $phpcsFile->getTokens();

        $ignore = array(
                   T_DOUBLE_COLON    => true,
                   T_OBJECT_OPERATOR => true,
                   T_FUNCTION        => true,
                   T_CONST           => true,
                   T_PUBLIC          => true,
                   T_PRIVATE         => true,
                   T_PROTECTED       => true,
                   T_AS              => true,
                   T_NEW             => true,
                   T_INSTEADOF       => true,
                   T_NS_SEPARATOR    => true,
                   T_IMPLEMENTS      => true,
                  );

        $prevToken = $phpcsFile->findPrevious(T_WHITESPACE, ($stackPtr - 1), null, true);

        // If function call is directly preceded by a NS_SEPARATOR it points to the
        // global namespace, so we should still catch it.
        if ($tokens[$prevToken]['code'] === T_NS_SEPARATOR) {
            $prevToken = $phpcsFile->findPrevious(T_WHITESPACE, ($prevToken - 1), null, true);
            if ($tokens[$prevToken]['code'] === T_STRING) {
                // Not in the global namespace.
                return;
            }
        }

        if (isset($ignore[$tokens[$prevToken]['code']]) === true) {
            // Not a call to a PHP function.
            return;
        }

        $nextToken = $phpcsFile->findNext(T_WHITESPACE, ($stackPtr + 1), null, true);
        if (isset($ignore[$tokens[$nextToken]['code']]) === true) {
            // Not a call to a PHP function.
            return;
        }

        if ($tokens[$stackPtr]['code'] === T_STRING && $tokens[$nextToken]['code'] !== T_OPEN_PARENTHESIS) {
            // Not a call to a PHP function.
            return;
        }

        $function = strtolower($tokens[$stackPtr]['content']);
        $pattern  = null;

        if ($this->patternMatch === true) {
            $count   = 0;
            $pattern = preg_replace(
                $this->forbiddenFunctionNames,
                $this->forbiddenFunctionNames,
                $function,
                1,
                $count
            );

            if ($count === 0) {
                return;
            }

            // Remove the pattern delimiters and modifier.
            $pattern = substr($pattern, 1, -2);
        } else {
            if (in_array($function, $this->forbiddenFunctionNames) === false) {
                return;
            }
        }//end if

        $this->addError($phpcsFile, $stackPtr, $function, $pattern);

    }//end process()


    /**
     * Generates the error or warning for this sniff.
     *
     * @param PHP_CodeSniffer_File $phpcsFile The file being scanned.
     * @param int                  $stackPtr  The position of the forbidden function
     *                                        in the token array.
     * @param string               $function  The name of the forbidden function.
     * @param string               $pattern   The pattern used for the match.
     *
     * @return void
     */
    protected function addError($phpcsFile, $stackPtr, $function, $pattern=null)
    {
        $data  = array($function);
        $error = 'The use of function %s() is ';
        if ($this->error === true) {
            $type   = 'Found';
            $error .= 'forbidden';
        } else {
            $type   = 'Discouraged';
            $error .= 'discouraged';
        }

        if ($pattern === null) {
            $pattern = $function;
        }

        if ($this->forbiddenFunctions[$pattern] !== null
            && $this->forbiddenFunctions[$pattern] !== 'null'
        ) {
            $type  .= 'WithAlternative';
            $data[] = $this->forbiddenFunctions[$pattern];
            $error .= '; use %s instead';
        }

        if ($this->error === true) {
            $phpcsFile->addError($error, $stackPtr, $type, $data);
        } else {
            $phpcsFile->addWarning($error, $stackPtr, $type, $data);
        }

    }//end addError()


}//end class

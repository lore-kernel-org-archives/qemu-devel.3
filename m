Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1656DC88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5qqr-0007G4-B4; Sun, 13 Sep 2026 16:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x5qqo-0007Ff-4V
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 16:30:58 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x5qqi-0004Xp-8V
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 16:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=snW5qyl+pje3IeX2lWBpwx0C5hDKvaRCJ5dSEubn920=; b=TL++ftbJ34YDThKa
 Nq9oXAtOQtqokfWvoBfyrryBeBqPNs+VyISqjQXMiEpip9ek4YiVnVUFcPjuhCWeZjSVJk9+TqSYY
 LtEz9lxMlBGADL/3dooaiK2G2crmiGqHjjhUZb4+/raZcc5QY7hkMABjJsoup6e6G0WcOdhFp1FSL
 5/LBlK2ocft07qoBtdoljXfEG75Y+acujfDTzGZ1Cx4iyU8Re5vjMX+JlEtUTPlT461q7Oe/aZ3AH
 NUwZA8A5CwgvviOQRt0P2fwVszfQSdHxXcRf8CFK95pPAiGq2ml1TvP75thlzq6MUEKPnsLPDcAYY
 Zn4Zu6APS/Ly0h3+Mg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1x5qqd-00000000Auw-2Rhb;
 Sun, 13 Sep 2026 20:30:47 +0000
Date: Sun, 13 Sep 2026 20:30:47 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 09/18] tests/qtest/migration: Add a test for HMP
Message-ID: <aqcH9wn2ElBqlFB9@gallifrey>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260909214509.237309-10-farosas@suse.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.107+deb13-amd64 (x86_64)
X-Uptime: 20:29:07 up 1 day,  8:14,  2 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

* Fabiano Rosas (farosas@suse.de) wrote:
> The following patches will change how parameters are set and shown in
> HMP, add a test for it.
> 
> The test issues HMP migrate_set_parameters for each of the existing
> migration parameters and queries them back with the info command. A
> list is kept with the expected strings. A substring match function
> inspired by glib's g_str_match_string is implemented for this test so
> the test can produce a decent error output instead of just assert
> failure. E.g:
> 
>  # HMP output mismatch for entry at line 55:
>  # expected vs. found:
>  #
>  # max-bandwidth: 10356305952768 bytes/hour
>  # ---
>  # max-bandwidth: 10356305952768 bytes/second
> 
> (note that line 55 above is the source line where the test case for
> max-bandwith is, which helps find the failing test in the list)
> 
> Usage:
> QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> ./tests/qtest/migration-test --full -p /x86_64/migration/hmp/parameters
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

Two minor thoughts:
  a) You might try a numeric out of range test?
  b) 'input1' and 'input2' seem odd names for something that oculd be .name and .value ?
    (But only if you need to rework anyway).

Dave

> ---
>  tests/qtest/migration/misc-tests.c | 201 +++++++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
> 
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 4e0deb7f18..533cf3d55d 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -22,6 +22,203 @@
>  
>  static char *tmpfs;
>  
> +#ifdef CONFIG_HMP
> +static int test_case_line;
> +
> +#define TEST(i1, i2, e) { i1, i2, e , .line = __LINE__, }
> +#define SKIP(i1, i2, e) { i1, i2, e , .skip = true, }
> +#define BG_SNAP_MSG ("Error: Background-snapshot is not compatible with " \
> +                     "currently set capabilities")
> +
> +typedef struct HMPTestData {
> +    const char *input1;
> +    const char *input2;
> +    const char *output1;
> +    bool skip;
> +    int line;
> +} HMPTestData;
> +
> +/*
> + * .input1: string to be used as parameter name
> + * .input2: string to be used as parameter value
> + * .output1: expected output of migrate_set_parameters
> + * E.g:
> + * (qemu) migrate_set_parameters .input1 .input2
> + * .output1
> + */
> +HMPTestData test_cases[] = {
> +    TEST("", "", "migrate_set_parameter: string expected"),
> +    TEST("foo", "", "migrate_set_parameter: string expected"),
> +    TEST("foo", "on", "Error: invalid parameter value: foo"),
> +
> +    /* bool */
> +    TEST("cpu-throttle-tailslow", "on", "on"),
> +    TEST("direct-io", "on", "on"),
> +
> +    /* uint64_t */
> +    TEST("announce-initial", "60", "60 ms"),
> +    TEST("announce-max", "600", "600 ms"),
> +    TEST("announce-rounds", "6", "6"),
> +    TEST("announce-step", "15", "15 ms"),
> +    TEST("downtime-limit", "400", "400 ms"),
> +    TEST("avail-switchover-bandwidth", "2097152", "2199023255552 bytes/second"),
> +    TEST("max-bandwidth", "9876543", "10356305952768 bytes/second"),
> +    TEST("max-postcopy-bandwidth", "1048576", "1048576 bytes/second"),
> +    TEST("vcpu-dirty-limit", "20", "20 MB/s"),
> +    TEST("x-rdma-chunk-size", "1048576", "1048576 bytes"),
> +    TEST("x-vcpu-dirty-limit-period", "750", "750 ms"),
> +    TEST("xbzrle-cache-size", "67108864", "67108864 bytes"),
> +
> +    /* uint32_t */
> +    TEST("x-checkpoint-delay", "5000", "5000 ms"),
> +
> +    /* uint8_t */
> +    TEST("cpu-throttle-increment", "15", "15"),
> +    TEST("cpu-throttle-initial", "25", "25"),
> +    TEST("max-cpu-throttle", "85", "85"),
> +    TEST("multifd-channels", "8", "8"),
> +    TEST("throttle-trigger-threshold", "65", "65"),
> +
> +    /* complex types */
> +    TEST("mode", "cpr-exec", "cpr-exec"),
> +    TEST("multifd-compression", "zlib", "zlib"),
> +    TEST("zero-page-detection", "none", "none"),
> +    TEST("tls-authz", "my_authz", "'my_authz'"),
> +    TEST("tls-creds", "null", "'null'"),
> +    TEST("tls-hostname", "localhost", "'localhost'"),
> +    TEST("cpr-exec-command", "/bin/true foobar", "/bin/true foobar"),
> +
> +    /* can be set but are currently missing in the query output */
> +    SKIP("multifd-qatzip-level", "5", "5"),
> +    SKIP("multifd-zlib-level", "4", "4"),
> +    SKIP("multifd-zstd-level", "6", "6"),
> +
> +    /* cannot be set */
> +    TEST("block-bitmap-mapping", "[]",
> +         "Error: The block-bitmap-mapping parameter "
> +         "can only be set through QMP"),
> +};
> +
> +/*
> + * Find a contiguous run of tokens in @larger that match the sequence
> + * of tokens in @smaller, ignoring mismatches due to sequences of
> + * empty tokens.
> + *
> + * Returns whether a match was found. @last is set if at least one
> + * token has matched.
> + */
> +static bool token_list_is_substr(char **smaller, char **larger, int *last)
> +{
> +    int i, j, k = 0;
> +    bool match = false;
> +
> +    for (i = 0; smaller[i]; i++) {
> +        for (j = k; larger[j]; j++) {
> +            if (!*larger[j]) {
> +                continue;
> +            }
> +
> +            /* readline adds several escape sequences */
> +            if (*larger[j] == '\033') {
> +                continue;
> +            }
> +
> +            if (g_str_equal(larger[j], smaller[i])) {
> +                match = true;
> +                *last = j;
> +                k = j + 1;
> +                break;
> +            }
> +
> +            if (match) {
> +                return false;
> +            } else {
> +                match = false;
> +            }
> +        }
> +    }
> +
> +    return match;
> +}
> +
> +static void assert_hmp_match_line(const char *str, const char *text)
> +{
> +    g_auto(GStrv) tok_str = g_strsplit_set(str, " ", -1);
> +    g_auto(GStrv) lines = g_strsplit_set(text, " \r\n", -1);
> +    int i, idx = -1;
> +
> +    /*
> +     * Note that the reason the 'str' above is split is to allow
> +     * token_list_is_substr() to first match on the parameter name so
> +     * matching can stop immediately after a mismatched value is
> +     * found. This provides a better output for failing test cases
> +     * than simply "str != line".
> +     */
> +
> +    for (i = 0; lines[i]; i++) {
> +        if (token_list_is_substr(tok_str, (char **)&lines[i], &idx)) {
> +            return;
> +        }
> +
> +        if (idx >= 0) {
> +            break;
> +        }
> +    }
> +
> +    g_test_message("HMP output mismatch for entry at line %d:", test_case_line);
> +    g_test_message("expected vs. found:\n\n%s\n---\n%s %s", str, lines[idx],
> +                   lines[idx + 1]);
> +    g_assert_not_reached();
> +}
> +
> +static void assert_hmp_success(const char *str)
> +{
> +    if (!g_str_equal(str, "")) {
> +        g_test_message("HMP command failed:\n\n%s", str);
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void test_hmp_migration_parameters(char *name, MigrateCommon *args)
> +{
> +    QTestState *qts;
> +
> +    /* force TCG so it can run in all targets */
> +    qts = qtest_init("-accel tcg -nodefaults -S");
> +
> +    for (int i = 0; i < G_N_ELEMENTS(test_cases); i++) {
> +        g_autofree char *resp = NULL;
> +        g_autofree char *line = NULL;
> +        struct HMPTestData *t = &test_cases[i];
> +
> +        if (t->skip) {
> +            continue;
> +        }
> +
> +        test_case_line = t->line;
> +
> +        resp = qtest_hmp(qts, "migrate_set_parameter %s %s", t->input1,
> +                         t->input2);
> +
> +        if (g_str_has_prefix(t->output1, "Error:") ||
> +            g_str_has_prefix(resp, "migrate_set_parameter:")) {
> +
> +            assert_hmp_match_line(t->output1, resp);
> +            continue;
> +        }
> +        assert_hmp_success(resp);
> +        g_free(resp);
> +
> +        resp = qtest_hmp(qts, "info migrate_parameters");
> +
> +        line = g_strconcat(t->input1, ": ", t->output1, NULL);
> +        assert_hmp_match_line(line, resp);
> +    }
> +
> +    qtest_quit(qts);
> +}
> +#endif /* CONFIG_HMP */
> +
>  static void test_baddest(char *name, MigrateCommon *args)
>  {
>      QTestState *from, *to;
> @@ -260,4 +457,8 @@ void migration_test_add_misc(MigrationTestEnv *env)
>                         test_validate_uri_channels_both_set);
>      migration_test_add("/migration/validate_uri/channels/none_set",
>                         test_validate_uri_channels_none_set);
> +#ifdef CONFIG_HMP
> +    migration_test_add("/migration/hmp/parameters",
> +                       test_hmp_migration_parameters);
> +#endif
>  }
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


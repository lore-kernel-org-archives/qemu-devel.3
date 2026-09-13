Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A19C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5rHx-0001dP-9L; Sun, 13 Sep 2026 16:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x5rHt-0001dB-R1
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 16:58:57 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x5rHr-0001K5-JC
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 16:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=RfAESy2CaeSmDb+j0WYkWAVYEIjEVFY5w9IODKLc5qY=; b=ocFjmEVL2MdwETWB
 EVw36nJWnzjeuHqYbn8XoqdZvkU6+2sV65S7a32Dib8DJaBlGOlPcHo//pynPmXnlvN88/xjMkzHn
 +7HmUQ2H/82sGqDltqJ1DKLPvN3cBr6+Ss91iWtEkFZ9cd/SU97YjCdjEv1ADLznSa4fiDFQ1b+XY
 YeWX/DMrgLkSUroAFCngxlsagEhTNIxZXWrSxrV6uAPGlwvgEUwo8B96WHklDyZ93iNKvTL9rETIZ
 55yjdkrXbXgw1YPWu5J6dg+Kqy8WWZ51tFA+RGJ7SjWYU1/+i9rZ+CALbedXLhlA/48O6V9GB4D7X
 CjYj2rC06ltNZavppA==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1x5rHp-00000000B9F-32PD;
 Sun, 13 Sep 2026 20:58:53 +0000
Date: Sun, 13 Sep 2026 20:58:53 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 10/18] tests/qtest/migration: Add a test for HMP
 completion
Message-ID: <aqcOjb1jV_UJlBwx@gallifrey>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260909214509.237309-11-farosas@suse.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.107+deb13-amd64 (x86_64)
X-Uptime: 20:37:52 up 1 day,  8:23,  2 users,  load average: 0.00, 0.01, 0.00
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
> The following patches will touch HMP readline completion for migration
> parameters, add a test case.
> 
> The test puts the monitor on a chardev via socket and bypasses qtest
> facilities because it needs to emit raw codes to readline. It
> therefore requires a couple of new helpers to read/write to the
> monitor socket.
> 
> Usage:
> QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> ./tests/qtest/migration-test --full -p /x86_64/migration/hmp/completion
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---

> +static void hmp_sock_read(int fd, char *buf, size_t buf_sz)
> +{
> +    char *p = buf;
> +    size_t sz = buf_sz - 1;
> +
> +    assert(fd >= 0);
> +    memset(buf, 0, buf_sz);
> +
> +    while (sz > 0) {
> +        ssize_t r = read(fd, p, sz);
> +        char *prompt;
> +
> +        if (!r) {
> +            break;
> +        } else if (r < 0) {
> +            if (errno == EINTR) {
> +                continue;
> +            }
> +            g_assert_not_reached();
> +        }
> +
> +        p += r;
> +        sz -= r;
> +
> +        prompt = strstr(buf, "(qemu) ");
> +        if (prompt) {
> +            *prompt = '\0';

I'm a bit confused by what you want the output to look like after this,
are you assuming this is the end of the string you're reading so truncation
is OK?

> +            break;
> +        }
> +    }
> +}
> +
> +static int comp(const void *a, const void *b)
> +{
> +    return strcmp(*(const char **) a, *(const char **) b);
> +}

Can you use qemu_pstrcmp0 there? (Maybe with g_ptr_array and g_ptr_array_sort is
what adds to some of the other questions below?)

> +static void get_migration_opts_sorted(GString *exp, const char * const *lookup, int n)
> +{
> +    g_autofree char **opts_array = g_new0(char *, n);
> +    uint8_t i;
> +
> +    for (i = 0; i < n; i++) {
> +        opts_array[i] = g_strdup(lookup[i]);
> +    }

If you made opts_array one element larger, and added a NULL at the end could you...

> +    qsort(opts_array, n, sizeof(char *), comp);
> +
> +    for (i = 0; i < n; i++) {
> +        g_string_append(exp, opts_array[i]);
> +        if (i + 1 != n) {
> +            g_string_append(exp, " ");
> +        }
> +    }

Use g_strjoinv here?

> +    for (i = 0; i < n; i++) {
> +        g_free(opts_array[i]);
> +    }
> +}

Dave

> +static void hmp_completion_single(int fd, const struct HMPTestData *t)
> +{
> +    g_autoptr(GString) exp = g_string_new("");
> +    char buf[8192];
> +    char *output;
> +
> +    test_case_line = t->line;
> +
> +    if (g_str_equal(t->output1, "@caps@")) {
> +        g_string_append(exp, "migrate_set_capability ");
> +        get_migration_opts_sorted(exp, MigrationCapability_lookup.array,
> +                                  MIGRATION_CAPABILITY__MAX);
> +    } else if (g_str_equal(t->output1, "@params@")) {
> +        g_string_append(exp, "migrate_set_parameter ");
> +        get_migration_opts_sorted(exp, MigrationParameter_lookup.array,
> +                                  MIGRATION_PARAMETER__MAX);
> +    } else {
> +        g_string_append(exp, t->output1);
> +    }
> +
> +    hmp_sock_write(fd, t->input1);
> +    hmp_sock_read(fd, buf, sizeof(buf));
> +
> +    /*
> +     * readline first rewrites the input to the common root of the
> +     * completions, then outputs the completion suggestions:
> +     *
> +     * (qemu) info migr<TAB>
> +     * (qemu) migrate migrate_parameters
> +     * migrate_capabilities ...
> +     */
> +    output = strstr(buf, t->input2);
> +    assert_hmp_match_text(exp->str, output);
> +
> +    /* ^U backward kill line */
> +    hmp_sock_write(fd, "\x15");
> +}
> +
> +static void test_hmp_completion(char *name, MigrateCommon *args)
> +{
> +    g_autofree char *cmdline;
> +    char buf[1024];
> +    QTestState *qts;
> +    int sockfds[2];
> +
> +    assert(!qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, sockfds));
> +    qemu_clear_cloexec(sockfds[1]);
> +
> +    cmdline = g_strdup_printf("-chardev socket,id=mon0,fd=%d "
> +                              "-mon chardev=mon0,mode=readline -S",
> +                              sockfds[1]);
> +    qts = qtest_init(cmdline);
> +    close(sockfds[1]);
> +
> +    /* read HMP banner */
> +    hmp_sock_read(sockfds[0], buf, sizeof(buf));
> +
> +    for (int i = 0; i < G_N_ELEMENTS(completion_cases); i++) {
> +        hmp_completion_single(sockfds[0], &completion_cases[i]);
> +    }
> +
> +    close(sockfds[0]);
> +    qtest_quit(qts);
> +}
>  #endif /* CONFIG_HMP */
>  
>  static void test_baddest(char *name, MigrateCommon *args)
> @@ -460,5 +650,7 @@ void migration_test_add_misc(MigrationTestEnv *env)
>  #ifdef CONFIG_HMP
>      migration_test_add("/migration/hmp/parameters",
>                         test_hmp_migration_parameters);
> +    migration_test_add("/migration/hmp/completion",
> +                       test_hmp_completion);
>  #endif
>  }
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


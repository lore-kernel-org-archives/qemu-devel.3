Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD36103E2E9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 22:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RoD-0000vc-78; Wed, 11 Mar 2026 18:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RoB-0000us-6u
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:13:39 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0Ro7-0004zu-NS
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:13:37 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B51D44D642;
 Wed, 11 Mar 2026 22:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773267206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXKCgnqGyH/v/Xg2Zt+YIbaZeNFOItL55qSzGq0aF5w=;
 b=k+KXuRzUyd3XzkXm+e1RoZSMpJqx/sywaLVIkx+g+11T0L+Thk2gcfZSQ3Z16P6yfb5R3k
 OEt3cJ+6Jaqr9hjZ8AkHxuFZES9lIduOiRuIsIKd1gAF25IZJ9KyirryzyxrkXXD2fnVqp
 miJ6FQA+qTWwbB/LocrPOxSSCO7qpUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773267206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXKCgnqGyH/v/Xg2Zt+YIbaZeNFOItL55qSzGq0aF5w=;
 b=NrFZBqBosCFBwzs2wd8Js9Y2A3TxmtuWoSO56ZH4pBxxf6Len7QgdItD//5XmUFz5IS3el
 gB0/Wpr0FzC42RBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k+KXuRzU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NrFZBqBo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773267206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXKCgnqGyH/v/Xg2Zt+YIbaZeNFOItL55qSzGq0aF5w=;
 b=k+KXuRzUyd3XzkXm+e1RoZSMpJqx/sywaLVIkx+g+11T0L+Thk2gcfZSQ3Z16P6yfb5R3k
 OEt3cJ+6Jaqr9hjZ8AkHxuFZES9lIduOiRuIsIKd1gAF25IZJ9KyirryzyxrkXXD2fnVqp
 miJ6FQA+qTWwbB/LocrPOxSSCO7qpUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773267206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXKCgnqGyH/v/Xg2Zt+YIbaZeNFOItL55qSzGq0aF5w=;
 b=NrFZBqBosCFBwzs2wd8Js9Y2A3TxmtuWoSO56ZH4pBxxf6Len7QgdItD//5XmUFz5IS3el
 gB0/Wpr0FzC42RBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5BC43FC44;
 Wed, 11 Mar 2026 22:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QLO8IgXpsWnCeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Mar 2026 22:13:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/3] tests/qtest/test-x86-cpuid-compat: Switch test_cpuid_prop
 to data-driven
Date: Wed, 11 Mar 2026 19:13:19 -0300
Message-ID: <20260311221320.22112-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311221320.22112-1-farosas@suse.de>
References: <20260311221320.22112-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,linaro.org:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B51D44D642
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In test-x86-cpuid-compat, we allocate memory in add_cpuid_test()
which is then freed in the test function test_cpuid_prop().  This
means that this memory is leaked if the test is never run, which
happens in several cases:
 * user asks to list tests with -l option
 * user asks to run only some tests with -p or similar option
 * we are running a "subprocess" test and glib re-invokes the
   test binary telling it to run a specific single test

As noted in the commit message of commit 93ed7d330321dc, we cannot
deal with this by using g_test_add_data_func_full() and passing a
free-function, because glib doesn't call that if the test is not
executed.

Instead, move all the data allocations into test_cpuid_prop(),
and pass it a pointer to a struct with the necessary parameters
which is a compile-time constant.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/test-x86-cpuid-compat.c | 278 ++++++++++++++++------------
 1 file changed, 164 insertions(+), 114 deletions(-)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index be67631a85..fc90a46d37 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -44,19 +44,43 @@ static bool qom_get_bool(const char *path, const char *prop)
 }
 
 typedef struct CpuidTestArgs {
-    const char *cmdline;
+    /* test name */
+    const char *name;
+    /* CPU type */
+    const char *cpu;
+    /* CPU features (may be NULL) */
+    const char *cpufeat;
+    /* machine type (may be NULL to use default machine) */
+    const char *machine;
+    /* CPU property to read */
     const char *property;
+    /* expected value of the property */
     int64_t expected_value;
 } CpuidTestArgs;
 
 static void test_cpuid_prop(const void *data)
 {
     const CpuidTestArgs *args = data;
+    char *cmdline;
+    char *save;
     char *path;
     QNum *value;
     int64_t val;
 
-    qtest_start(args->cmdline);
+    cmdline = g_strdup_printf("-cpu %s", args->cpu);
+
+    if (args->cpufeat) {
+        save = cmdline;
+        cmdline = g_strdup_printf("%s,%s", cmdline, args->cpufeat);
+        g_free(save);
+    }
+    if (args->machine) {
+        save = cmdline;
+        cmdline = g_strdup_printf("-machine %s %s", args->machine, cmdline);
+        g_free(save);
+    }
+
+    qtest_start(cmdline);
     path = get_cpu0_qom_path();
     value = qobject_to(QNum, qom_get(path, args->property));
     g_assert(qnum_get_try_int(value, &val));
@@ -65,40 +89,9 @@ static void test_cpuid_prop(const void *data)
 
     qobject_unref(value);
     g_free(path);
-    g_free((void *)args->cmdline);
-    g_free((void *)data);
+    g_free(cmdline);
 }
 
-static void add_cpuid_test(const char *name, const char *cpu,
-                           const char *cpufeat, const char *machine,
-                           const char *property, int64_t expected_value)
-{
-    CpuidTestArgs *args = g_new0(CpuidTestArgs, 1);
-    char *cmdline;
-    char *save;
-
-    if (!qtest_has_cpu_model(cpu)) {
-        return;
-    }
-    cmdline = g_strdup_printf("-cpu %s", cpu);
-
-    if (cpufeat) {
-        save = cmdline;
-        cmdline = g_strdup_printf("%s,%s", cmdline, cpufeat);
-        g_free(save);
-    }
-    if (machine) {
-        save = cmdline;
-        cmdline = g_strdup_printf("-machine %s %s", machine, cmdline);
-        g_free(save);
-    }
-    args->cmdline = cmdline;
-    args->property = property;
-    args->expected_value = expected_value;
-    qtest_add_data_func(name, args, test_cpuid_prop);
-}
-
-
 /* Parameters to a add_feature_test() test case */
 typedef struct FeatureTestArgs {
     /* cmdline to start QEMU */
@@ -249,103 +242,160 @@ static void test_plus_minus(void)
     g_test_trap_assert_stdout("");
 }
 
-int main(int argc, char **argv)
-{
-    g_test_init(&argc, &argv, NULL);
-
-    g_test_add_func("/x86/cpuid/parsing-plus-minus/subprocess",
-                    test_plus_minus_subprocess);
-    g_test_add_func("/x86/cpuid/parsing-plus-minus", test_plus_minus);
-
+static const CpuidTestArgs cpuid_tests[] = {
     /* Original level values for CPU models: */
-    add_cpuid_test("x86/cpuid/phenom/level",
-                   "phenom", NULL, NULL, "level", 5);
-    add_cpuid_test("x86/cpuid/Conroe/level",
-                   "Conroe", NULL, NULL, "level", 10);
-    add_cpuid_test("x86/cpuid/SandyBridge/level",
-                   "SandyBridge", NULL, NULL, "level", 0xd);
-    add_cpuid_test("x86/cpuid/486/xlevel",
-                   "486", NULL, NULL, "xlevel", 0);
-    add_cpuid_test("x86/cpuid/core2duo/xlevel",
-                   "core2duo", NULL, NULL, "xlevel", 0x80000008);
-    add_cpuid_test("x86/cpuid/phenom/xlevel",
-                   "phenom", NULL, NULL, "xlevel", 0x8000001A);
-    add_cpuid_test("x86/cpuid/athlon/xlevel",
-                   "athlon", NULL, NULL, "xlevel", 0x80000008);
-
+    {
+        "x86/cpuid/phenom/level",
+        "phenom", NULL, NULL, "level", 5,
+    },
+    {
+        "x86/cpuid/Conroe/level",
+        "Conroe", NULL, NULL, "level", 10,
+    },
+    {
+        "x86/cpuid/SandyBridge/level",
+        "SandyBridge", NULL, NULL, "level", 0xd,
+    },
+    {
+        "x86/cpuid/486/xlevel",
+        "486", NULL, NULL, "xlevel", 0,
+    },
+    {
+        "x86/cpuid/core2duo/xlevel",
+        "core2duo", NULL, NULL, "xlevel", 0x80000008,
+    },
+    {
+        "x86/cpuid/phenom/xlevel",
+        "phenom", NULL, NULL, "xlevel", 0x8000001A,
+    },
+    {
+        "x86/cpuid/athlon/xlevel",
+        "athlon", NULL, NULL, "xlevel", 0x80000008,
+    },
     /* If level is not large enough, it should increase automatically: */
     /* CPUID[6].EAX: */
-    add_cpuid_test("x86/cpuid/auto-level/486/arat",
-                   "486", "arat=on", NULL, "level", 6);
+    {
+        "x86/cpuid/auto-level/486/arat",
+        "486", "arat=on", NULL, "level", 6,
+    },
     /* CPUID[EAX=7,ECX=0].EBX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/fsgsbase",
-                   "phenom", "fsgsbase=on", NULL, "level", 7);
+    {
+        "x86/cpuid/auto-level/phenom/fsgsbase",
+        "phenom", "fsgsbase=on", NULL, "level", 7,
+    },
     /* CPUID[EAX=7,ECX=0].ECX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/avx512vbmi",
-                   "phenom", "avx512vbmi=on", NULL, "level", 7);
+    {
+        "x86/cpuid/auto-level/phenom/avx512vbmi",
+        "phenom", "avx512vbmi=on", NULL, "level", 7,
+    },
     /* CPUID[EAX=0xd,ECX=1].EAX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/xsaveopt",
-                   "phenom", "xsaveopt=on", NULL, "level", 0xd);
+    {
+        "x86/cpuid/auto-level/phenom/xsaveopt",
+        "phenom", "xsaveopt=on", NULL, "level", 0xd,
+    },
     /* CPUID[8000_0001].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/3dnow",
-                   "486", "3dnow=on", NULL, "xlevel", 0x80000001);
+    {
+        "x86/cpuid/auto-xlevel/486/3dnow",
+        "486", "3dnow=on", NULL, "xlevel", 0x80000001,
+    },
     /* CPUID[8000_0001].ECX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/sse4a",
-                   "486", "sse4a=on", NULL, "xlevel", 0x80000001);
+    {
+        "x86/cpuid/auto-xlevel/486/sse4a",
+        "486", "sse4a=on", NULL, "xlevel", 0x80000001,
+    },
     /* CPUID[8000_0007].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/invtsc",
-                   "486", "invtsc=on", NULL, "xlevel", 0x80000007);
+    {
+        "x86/cpuid/auto-xlevel/486/invtsc",
+        "486", "invtsc=on", NULL, "xlevel", 0x80000007,
+    },
     /* CPUID[8000_000A].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
-                   "486", "svm=on,npt=on", NULL, "xlevel", 0x8000000A);
+    {
+        "x86/cpuid/auto-xlevel/486/npt",
+        "486", "svm=on,npt=on", NULL, "xlevel", 0x8000000A,
+    },
     /* CPUID[C000_0001].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
-                   "phenom", "xstore=on", NULL, "xlevel2", 0xC0000001);
+    {
+        "x86/cpuid/auto-xlevel2/phenom/xstore",
+        "phenom", "xstore=on", NULL, "xlevel2", 0xC0000001,
+    },
     /* SVM needs CPUID[0x8000000A] */
-    add_cpuid_test("x86/cpuid/auto-xlevel/athlon/svm",
-                   "athlon", "svm=on", NULL, "xlevel", 0x8000000A);
-
-
+    {
+        "x86/cpuid/auto-xlevel/athlon/svm",
+        "athlon", "svm=on", NULL, "xlevel", 0x8000000A,
+    },
     /* If level is already large enough, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-level/SandyBridge/multiple",
-                   "SandyBridge", "arat=on,fsgsbase=on,avx512vbmi=on",
-                   NULL, "level", 0xd);
+    {
+        "x86/cpuid/auto-level/SandyBridge/multiple",
+        "SandyBridge", "arat=on,fsgsbase=on,avx512vbmi=on",
+        NULL, "level", 0xd,
+    },
     /* If level is explicitly set, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-level/486/fixed/0xF",
-                   "486",
-                   "level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   NULL, "level", 0xF);
-    add_cpuid_test("x86/cpuid/auto-level/486/fixed/2",
-                   "486",
-                   "level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   NULL, "level", 2);
-    add_cpuid_test("x86/cpuid/auto-level/486/fixed/0",
-                   "486",
-                   "level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   NULL, "level", 0);
-
+    {
+        "x86/cpuid/auto-level/486/fixed/0xF",
+        "486",
+        "level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+        NULL, "level", 0xF,
+    },
+    {
+        "x86/cpuid/auto-level/486/fixed/2",
+        "486",
+        "level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+        NULL, "level", 2,
+    },
+    {
+        "x86/cpuid/auto-level/486/fixed/0",
+        "486",
+        "level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+        NULL, "level", 0,
+    },
     /* if xlevel is already large enough, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/phenom/3dnow",
-                   "phenom", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   NULL, "xlevel", 0x8000001A);
+    {
+        "x86/cpuid/auto-xlevel/phenom/3dnow",
+        "phenom", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+        NULL, "xlevel", 0x8000001A,
+    },
     /* If xlevel is explicitly set, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/80000002",
-                   "486",
-                   "xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   NULL, "xlevel", 0x80000002);
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/8000001A",
-                   "486",
-                   "xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   NULL, "xlevel", 0x8000001A);
-    add_cpuid_test("x86/cpuid/auto-xlevel/phenom/fixed/0",
-                   "486",
-                   "xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   NULL, "xlevel", 0);
-
+    {
+        "x86/cpuid/auto-xlevel/486/fixed/80000002",
+        "486",
+        "xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+        NULL, "xlevel", 0x80000002,
+    },
+    {
+        "x86/cpuid/auto-xlevel/486/fixed/8000001A",
+        "486",
+        "xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+        NULL, "xlevel", 0x8000001A,
+    },
+    {
+        "x86/cpuid/auto-xlevel/phenom/fixed/0",
+        "486",
+        "xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+        NULL, "xlevel", 0,
+    },
     /* if xlevel2 is already large enough, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-xlevel2/486/fixed",
-                   "486", "xlevel2=0xC0000002,xstore=on",
-                   NULL, "xlevel2", 0xC0000002);
+    {
+        "x86/cpuid/auto-xlevel2/486/fixed",
+        "486", "xlevel2=0xC0000002,xstore=on",
+        NULL, "xlevel2", 0xC0000002,
+    },
+};
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/x86/cpuid/parsing-plus-minus/subprocess",
+                    test_plus_minus_subprocess);
+    g_test_add_func("/x86/cpuid/parsing-plus-minus", test_plus_minus);
+
+    for (int i = 0; i < ARRAY_SIZE(cpuid_tests); i++) {
+        if (!qtest_has_cpu_model(cpuid_tests[i].cpu)) {
+            continue;
+        }
+        qtest_add_data_func(cpuid_tests[i].name,
+                            &cpuid_tests[i], test_cpuid_prop);
+    }
 
     /* Test feature parsing */
     add_feature_test("x86/cpuid/features/plus",
-- 
2.51.0



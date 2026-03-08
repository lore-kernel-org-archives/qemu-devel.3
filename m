Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDD5EA853D
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 18:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzJGv-0006Hj-AO; Sun, 08 Mar 2026 14:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzJGn-0006Cy-Kw
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 14:54:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzJGj-0007Wp-IH
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 14:54:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4853c3c2fe7so303205e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 11:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772996064; x=1773600864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wmw72b+TCcC7k6KVbhH37HzP+xy+Ezk8zXo8ahe0vLk=;
 b=fwqB8myQkD/P/dRVB416IfzzZx+yba84aAYLnGIQ/+BsgyGpBQIZfAHqt1DSfJktfZ
 tAB4N6J/haPKBI+oHa9EwTlflw+Sphwhd2b99rcYsFj1HKquS1RF7uEOM9E/fDm24K07
 bvCDclDNlNkeMf4MPi69BlSvpeD9Q3ruLzK3Ee+qyYvPePvqnEacleVxWLhr2BzdxbKZ
 0eT3zWBpvX68ky63qTKmjURJUvUhXU6NNedPKELWUAXQtop1cauNNxwTGkd9WSNQTXYr
 EU4vycAcoxsDh2CExtxNb6fZiGzkEhJ8GWhygbWp9gY6ppqE9nmuYw/EoRmKl7rUy97e
 bFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772996064; x=1773600864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wmw72b+TCcC7k6KVbhH37HzP+xy+Ezk8zXo8ahe0vLk=;
 b=lG8YmS4u27zb/OozCgVm3CjltoOWD5R2SoW1A/ADy43uI9Uwevc8nxkSqcOAk1f6eC
 fMwpycY5kGxiJC19Jm15Y+TH+0Vz+nRwW8TTOqIe5YQDPUN2S7S3+9zcofxvl/Jt1lau
 zj6Mhtx7V0LTgt8i9Wc+eC8KnpxO0rT6+hbmcQ9vCIILmzDQkHaljZDiTslUnvDGn9qE
 yKcams4f6SgUkTR39RYV3/ExmOOAgfJ+WOQyR5BcMmuzRwE0Dr6pSOlVkpZ5Sq4O4TwT
 E8Y4zM6WmhYrlp0p29P0IXwc49r7+ToxO6Knm9uK1v9PhgT2g4q1R75rLz5MFIII1Pje
 xX/A==
X-Gm-Message-State: AOJu0YzwKrrMV1RxpYvpQyVJL7UTMI6anMpHygyjHHlSeab8f1mPIIV8
 mmtnYo3EAQxrLcvnWGjqcMKO3G9mBt83lS3i1P0p8b7W1xhZuO/nMK3WySM837KzGrqozCoP5Ap
 u+Jf9
X-Gm-Gg: ATEYQzz+nAvLjgZ00I0y01QjadN7oQPE8qbNsevthBK02EX8KXASCNUYqheKlsiWN8O
 6N1Tb4UdYo0TEX9Q77E0g+sqkcjj9/1/GoHT1ucVw3Nmqkel0isz1sC9Y9PrrgpigpiGSKsGUwY
 eBnONVRLobLmpDn3EFG+epQTLurfPTZ7uw4kPXVUJsIeG7v4G1lJ0Iug/XRSl80Gz45f8GfetTO
 zFJ6IKVbXROiLEm2S+nTLeJbCL6fk5BC5IWuvjzwTrvs2mSTQxHTdviq1QZVKIDizta/lLbu2oQ
 QpCXWm9LubvOzRQsPFWLD6lDz0TF98WVO+FmZ6XHlLXGygPWtRYay5mIXIqOF8QHbCa0Y28v1bo
 kaeWbtv51z9gW4aSqLB6F7g+Nl6xB9XMH4d25dPiYWIFMBcxozdNhRaro9VE+9qn1/iOTfHsa8k
 FKrK4c5HDY+FDwW63MhhVApb+dcDKS8fmxUiIOCbl7qldIm3yDr6LkA/4IgiLv0SQI4Jx/fkSWG
 rYRNlPcDLOiFS7B11d5w6H7WVEwj3/4JWMS2zU52A==
X-Received: by 2002:a05:600c:8b5b:b0:480:4ae2:def1 with SMTP id
 5b1f17b1804b1-485269305e5mr139412005e9.13.1772996063911; 
 Sun, 08 Mar 2026 11:54:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb29fdsm20451324f8f.16.2026.03.08.11.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 11:54:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 1/2] tests/qtest/test-x86-cpuid-compat: Switch test_cpuid_prop
 to data-driven
Date: Sun,  8 Mar 2026 18:54:20 +0000
Message-ID: <20260308185421.972734-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260308185421.972734-1-peter.maydell@linaro.org>
References: <20260308185421.972734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 tests/qtest/test-x86-cpuid-compat.c | 296 ++++++++++++++++------------
 1 file changed, 173 insertions(+), 123 deletions(-)

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
@@ -249,6 +242,145 @@ static void test_plus_minus(void)
     g_test_trap_assert_stdout("");
 }
 
+static const CpuidTestArgs cpuid_tests[] = {
+    /* Original level values for CPU models: */
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
+    /* If level is not large enough, it should increase automatically: */
+    /* CPUID[6].EAX: */
+    {
+        "x86/cpuid/auto-level/486/arat",
+        "486", "arat=on", NULL, "level", 6,
+    },
+    /* CPUID[EAX=7,ECX=0].EBX: */
+    {
+        "x86/cpuid/auto-level/phenom/fsgsbase",
+        "phenom", "fsgsbase=on", NULL, "level", 7,
+    },
+    /* CPUID[EAX=7,ECX=0].ECX: */
+    {
+        "x86/cpuid/auto-level/phenom/avx512vbmi",
+        "phenom", "avx512vbmi=on", NULL, "level", 7,
+    },
+    /* CPUID[EAX=0xd,ECX=1].EAX: */
+    {
+        "x86/cpuid/auto-level/phenom/xsaveopt",
+        "phenom", "xsaveopt=on", NULL, "level", 0xd,
+    },
+    /* CPUID[8000_0001].EDX: */
+    {
+        "x86/cpuid/auto-xlevel/486/3dnow",
+        "486", "3dnow=on", NULL, "xlevel", 0x80000001,
+    },
+    /* CPUID[8000_0001].ECX: */
+    {
+        "x86/cpuid/auto-xlevel/486/sse4a",
+        "486", "sse4a=on", NULL, "xlevel", 0x80000001,
+    },
+    /* CPUID[8000_0007].EDX: */
+    {
+        "x86/cpuid/auto-xlevel/486/invtsc",
+        "486", "invtsc=on", NULL, "xlevel", 0x80000007,
+    },
+    /* CPUID[8000_000A].EDX: */
+    {
+        "x86/cpuid/auto-xlevel/486/npt",
+        "486", "svm=on,npt=on", NULL, "xlevel", 0x8000000A,
+    },
+    /* CPUID[C000_0001].EDX: */
+    {
+        "x86/cpuid/auto-xlevel2/phenom/xstore",
+        "phenom", "xstore=on", NULL, "xlevel2", 0xC0000001,
+    },
+    /* SVM needs CPUID[0x8000000A] */
+    {
+        "x86/cpuid/auto-xlevel/athlon/svm",
+        "athlon", "svm=on", NULL, "xlevel", 0x8000000A,
+    },
+    /* If level is already large enough, it shouldn't change: */
+    {
+        "x86/cpuid/auto-level/SandyBridge/multiple",
+        "SandyBridge", "arat=on,fsgsbase=on,avx512vbmi=on",
+        NULL, "level", 0xd,
+    },
+    /* If level is explicitly set, it shouldn't change: */
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
+    /* if xlevel is already large enough, it shouldn't change: */
+    {
+        "x86/cpuid/auto-xlevel/phenom/3dnow",
+        "phenom", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+        NULL, "xlevel", 0x8000001A,
+    },
+    /* If xlevel is explicitly set, it shouldn't change: */
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
+    /* if xlevel2 is already large enough, it shouldn't change: */
+    {
+        "x86/cpuid/auto-xlevel2/486/fixed",
+        "486", "xlevel2=0xC0000002,xstore=on",
+        NULL, "xlevel2", 0xC0000002,
+    },
+};
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -257,95 +389,13 @@ int main(int argc, char **argv)
                     test_plus_minus_subprocess);
     g_test_add_func("/x86/cpuid/parsing-plus-minus", test_plus_minus);
 
-    /* Original level values for CPU models: */
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
-    /* If level is not large enough, it should increase automatically: */
-    /* CPUID[6].EAX: */
-    add_cpuid_test("x86/cpuid/auto-level/486/arat",
-                   "486", "arat=on", NULL, "level", 6);
-    /* CPUID[EAX=7,ECX=0].EBX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/fsgsbase",
-                   "phenom", "fsgsbase=on", NULL, "level", 7);
-    /* CPUID[EAX=7,ECX=0].ECX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/avx512vbmi",
-                   "phenom", "avx512vbmi=on", NULL, "level", 7);
-    /* CPUID[EAX=0xd,ECX=1].EAX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/xsaveopt",
-                   "phenom", "xsaveopt=on", NULL, "level", 0xd);
-    /* CPUID[8000_0001].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/3dnow",
-                   "486", "3dnow=on", NULL, "xlevel", 0x80000001);
-    /* CPUID[8000_0001].ECX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/sse4a",
-                   "486", "sse4a=on", NULL, "xlevel", 0x80000001);
-    /* CPUID[8000_0007].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/invtsc",
-                   "486", "invtsc=on", NULL, "xlevel", 0x80000007);
-    /* CPUID[8000_000A].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
-                   "486", "svm=on,npt=on", NULL, "xlevel", 0x8000000A);
-    /* CPUID[C000_0001].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
-                   "phenom", "xstore=on", NULL, "xlevel2", 0xC0000001);
-    /* SVM needs CPUID[0x8000000A] */
-    add_cpuid_test("x86/cpuid/auto-xlevel/athlon/svm",
-                   "athlon", "svm=on", NULL, "xlevel", 0x8000000A);
-
-
-    /* If level is already large enough, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-level/SandyBridge/multiple",
-                   "SandyBridge", "arat=on,fsgsbase=on,avx512vbmi=on",
-                   NULL, "level", 0xd);
-    /* If level is explicitly set, it shouldn't change: */
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
-    /* if xlevel is already large enough, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/phenom/3dnow",
-                   "phenom", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   NULL, "xlevel", 0x8000001A);
-    /* If xlevel is explicitly set, it shouldn't change: */
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
-    /* if xlevel2 is already large enough, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-xlevel2/486/fixed",
-                   "486", "xlevel2=0xC0000002,xstore=on",
-                   NULL, "xlevel2", 0xC0000002);
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
2.43.0



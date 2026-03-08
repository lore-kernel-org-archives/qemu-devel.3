Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2B7EA8540
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 18:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzJGp-0006EB-PB; Sun, 08 Mar 2026 14:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzJGo-0006DC-6E
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 14:54:30 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzJGk-0007Wx-HH
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 14:54:27 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so3296031f8f.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772996065; x=1773600865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOiVIOXoAhu6KP/nLdpVXUtXhOZfE1GyQyXet/UgrKw=;
 b=j092//gsuuJ6Ujgdssx6E95Uw16NP3BhriTcnBY+nMyGAdb+3IyJm9ijNp+fAIQFb5
 ID+hkpNBjDB1tHvpmCq2U0zA23eVhpfCoMBZlv2ESNVHW1xMyZ3/xAwHmbmu843ngjhZ
 5y85dxZZ1iXVViMCoPNtQpONidU2/K/32C3gJdYBQRgUzOW9dtrRNUYyQM/h64pGfnW3
 WOfrbZCspRBeagGGSKfuiGIJD1br56CGHx+n2zACTJJ4ziaT+aoADzwWADL/zC4d/s+2
 ZSt/gt0nNX04oKG5UHeldyCVLRWKj6J3rcHiZJwMLTW0+p2FTF6C/DGOmKhfeNDJ8CjT
 XXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772996065; x=1773600865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NOiVIOXoAhu6KP/nLdpVXUtXhOZfE1GyQyXet/UgrKw=;
 b=abPRYQ/YqwjlhQ8cl/skaFQwUG4/er/0bOG/H7+rN2CmF2TE8byPtVO4y8417xgmzX
 bb4ghbtun7VFYP60BdW6ILViqrchUXeOd0om2pKENVgLLDmiEVUyb9KkdyzM2tIkk00c
 /dXIznqDR7VvoegcXEPcmQ/jD7RYccgoa/vEZ+qmTsZZl12GTMoy0lTfUNlLoSMpTvYr
 8wFSZeOSzfAW6m1TOMV+ZuUYB8Y0GxlM4VWt35w3xFE2LaoC8PuwErQRBczpg1uZ7fUF
 Sap9Bv6ge9FnmUp6a77MQh/yD7tMgnHvsM3cnAqSy0XxXQYahR/C3Ih7OfpSG5x+SBRe
 iGTA==
X-Gm-Message-State: AOJu0Yy+qr1DpIFYqfpMlGYu7u2b7vWNSYPEgt/ogV8crKosK+neqIJC
 u/gWEaIgfYFtaTW9HjbZ1BBP6Cg2v6o34e3B8QToFIvy3raVsd9KUep6pJqkwaUsp5AxYDGRajc
 7xEp+
X-Gm-Gg: ATEYQzwXOJWuBHRkMuzV+ZwdCF+hG4iX4sS5FVr5LoCqbpK9JETPwFcTHdlOfGN5TBu
 eNZ36hsN510nzZL+XugKTmp8Jln6O57SkpG8/OyRE6jpYpawiybzisihM2UcvPfc1FAoM6PL4K6
 o8dnMcQusszRT23USPSAG/VC7Ddlxkzs98CM1NtjbPQ0VX5+eV1A3VGP7Mn459LL1FN9/Fy2ldy
 MuS9QPSZ+beOrHrXo2WJYyHCUWwx1CvlnxvNkSsX+ktWrQGIBw9sLPv1tOWF/pq/zVyAxSBNxZw
 J8gcSb+GLeghwgEtlOaFUNUy20411G1N9aD09fokLOFWVUGwcg614hx15uZkLFBu3Vs5bZIjfKo
 1dmbhZaQMSZ1sllTCu+vFt96689wbaNaEYyS47NJPPzOnqzku41AWotJLyOpt6B8Munu7ptTYgy
 /GM2bqaEJeypR2jE2xwzcS2oDmxcpwaNze176F6stxwRPwMmzflsad8rnmKCERmOZH9i4Vh61db
 zpZcEd8GIjvpo81iU8vdiPYkNKSbto=
X-Received: by 2002:a05:6000:1a8d:b0:439:ae7b:4b1d with SMTP id
 ffacd0b85a97d-439da685980mr14809912f8f.51.1772996064995; 
 Sun, 08 Mar 2026 11:54:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dadb29fdsm20451324f8f.16.2026.03.08.11.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 11:54:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 2/2] tests/qtest/test-x86-cpuid-compat: Switch
 test_feature_flag to data-driven
Date: Sun,  8 Mar 2026 18:54:21 +0000
Message-ID: <20260308185421.972734-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260308185421.972734-1-peter.maydell@linaro.org>
References: <20260308185421.972734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

As with add_cpuid_test(), the add_feature_test() function also
allocates memory that is leaked if the test case is not run.  Fix
this in the same way, by moving all the allocations into
test_feature_flag() and passing it a pointer to a struct with the
necessary parameters which is a compile-time constant.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/test-x86-cpuid-compat.c | 134 +++++++++++++++-------------
 1 file changed, 72 insertions(+), 62 deletions(-)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index fc90a46d37..17c0965827 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -94,8 +94,12 @@ static void test_cpuid_prop(const void *data)
 
 /* Parameters to a add_feature_test() test case */
 typedef struct FeatureTestArgs {
-    /* cmdline to start QEMU */
-    const char *cmdline;
+    /* Test name */
+    const char *name;
+    /* CPU type */
+    const char *cpu;
+    /* CPU features, may be NULL */
+    const char *cpufeat;
     /*
      * cpuid-input-eax and cpuid-input-ecx values to look for,
      * in "feature-words" and "filtered-features" properties.
@@ -140,10 +144,17 @@ static void test_feature_flag(const void *data)
 {
     const FeatureTestArgs *args = data;
     char *path;
+    char *cmdline;
     QList *present, *filtered;
     uint32_t value;
 
-    qtest_start(args->cmdline);
+    if (args->cpufeat) {
+        cmdline = g_strdup_printf("-cpu %s,%s", args->cpu, args->cpufeat);
+    } else {
+        cmdline = g_strdup_printf("-cpu %s", args->cpu);
+    }
+
+    qtest_start(cmdline);
     path = get_cpu0_qom_path();
     present = qobject_to(QList, qom_get(path, "feature-words"));
     filtered = qobject_to(QList, qom_get(path, "filtered-features"));
@@ -156,40 +167,7 @@ static void test_feature_flag(const void *data)
     qobject_unref(present);
     qobject_unref(filtered);
     g_free(path);
-    g_free((void *)args->cmdline);
-    g_free((void *)data);
-}
-
-/*
- * Add test case to ensure that a given feature flag is set in
- * either "feature-words" or "filtered-features", when running QEMU
- * using cmdline
- */
-static void add_feature_test(const char *name, const char *cpu,
-                             const char *cpufeat, uint32_t eax,
-                             uint32_t ecx, const char *reg,
-                             int bitnr, bool expected_value)
-{
-    FeatureTestArgs *args = g_new0(FeatureTestArgs, 1);
-    char *cmdline;
-
-    if (!qtest_has_cpu_model(cpu)) {
-        return;
-    }
-
-    if (cpufeat) {
-        cmdline = g_strdup_printf("-cpu %s,%s", cpu, cpufeat);
-    } else {
-        cmdline = g_strdup_printf("-cpu %s", cpu);
-    }
-
-    args->cmdline = cmdline;
-    args->in_eax = eax;
-    args->in_ecx = ecx;
-    args->reg = reg;
-    args->bitnr = bitnr;
-    args->expected_value = expected_value;
-    qtest_add_data_func(name, args, test_feature_flag);
+    g_free(cmdline);
 }
 
 static void test_plus_minus_subprocess(void)
@@ -381,6 +359,56 @@ static const CpuidTestArgs cpuid_tests[] = {
     },
 };
 
+/*
+ * Test cases to ensure that a given feature flag is set in
+ * either "feature-words" or "filtered-features", when running QEMU
+ * using cmdline
+ */
+static const FeatureTestArgs feature_tests[] = {
+    /* Test feature parsing */
+    {
+        "x86/cpuid/features/plus",
+        "486", "+arat",
+        6, 0, "EAX", 2, true,
+    },
+    {
+        "x86/cpuid/features/minus",
+        "pentium", "-mmx",
+        1, 0, "EDX", 23, false,
+    },
+    {
+        "x86/cpuid/features/on",
+        "486", "arat=on",
+        6, 0, "EAX", 2, true,
+    },
+    {
+        "x86/cpuid/features/off",
+        "pentium", "mmx=off",
+        1, 0, "EDX", 23, false,
+    },
+
+    {
+        "x86/cpuid/features/max-plus-invtsc",
+        "max" , "+invtsc",
+        0x80000007, 0, "EDX", 8, true,
+    },
+    {
+        "x86/cpuid/features/max-invtsc-on",
+        "max", "invtsc=on",
+        0x80000007, 0, "EDX", 8, true,
+    },
+    {
+        "x86/cpuid/features/max-minus-mmx",
+        "max", "-mmx",
+        1, 0, "EDX", 23, false,
+    },
+    {
+        "x86/cpuid/features/max-invtsc-on,mmx=off",
+        "max", "mmx=off",
+        1, 0, "EDX", 23, false,
+    },
+};
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -397,32 +425,14 @@ int main(int argc, char **argv)
                             &cpuid_tests[i], test_cpuid_prop);
     }
 
-    /* Test feature parsing */
-    add_feature_test("x86/cpuid/features/plus",
-                     "486", "+arat",
-                     6, 0, "EAX", 2, true);
-    add_feature_test("x86/cpuid/features/minus",
-                     "pentium", "-mmx",
-                     1, 0, "EDX", 23, false);
-    add_feature_test("x86/cpuid/features/on",
-                     "486", "arat=on",
-                     6, 0, "EAX", 2, true);
-    add_feature_test("x86/cpuid/features/off",
-                     "pentium", "mmx=off",
-                     1, 0, "EDX", 23, false);
 
-    add_feature_test("x86/cpuid/features/max-plus-invtsc",
-                     "max" , "+invtsc",
-                     0x80000007, 0, "EDX", 8, true);
-    add_feature_test("x86/cpuid/features/max-invtsc-on",
-                     "max", "invtsc=on",
-                     0x80000007, 0, "EDX", 8, true);
-    add_feature_test("x86/cpuid/features/max-minus-mmx",
-                     "max", "-mmx",
-                     1, 0, "EDX", 23, false);
-    add_feature_test("x86/cpuid/features/max-invtsc-on,mmx=off",
-                     "max", "mmx=off",
-                     1, 0, "EDX", 23, false);
+    for (int i = 0; i < ARRAY_SIZE(feature_tests); i++) {
+        if (!qtest_has_cpu_model(feature_tests[i].cpu)) {
+            continue;
+        }
+        qtest_add_data_func(feature_tests[i].name,
+                            &feature_tests[i], test_feature_flag);
+    }
 
     return g_test_run();
 }
-- 
2.43.0



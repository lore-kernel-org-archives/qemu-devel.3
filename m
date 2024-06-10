Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDB6C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 15:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGhLO-0002IX-4J; Mon, 10 Jun 2024 11:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sGhLL-0002I4-RJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sGhLJ-0005y8-PF
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718034836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTiWV60Yw5YHcmL5cLv5wWfs1CoY7BJX7S0VToe0aU4=;
 b=SDD61N1mv7bS2Hr4uH3oivbsntAjHvnlXZCMzjrBBq/sKhedeeosZzi2C2oU6b6YOHv7Eb
 7uNF6MMQ0rLQQe7srjwmK9J80OF4RXCcMFOHcG8f6vc8WTLUPHfk+criSetspRLIOdTOfC
 SqZD8ojqKa16iNEh38dtZ5BHrYvo6/M=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-VFVA6lFaNgGm00UTYrlDMA-1; Mon, 10 Jun 2024 11:53:54 -0400
X-MC-Unique: VFVA6lFaNgGm00UTYrlDMA-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-375a31f4251so12230085ab.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 08:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718034833; x=1718639633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTiWV60Yw5YHcmL5cLv5wWfs1CoY7BJX7S0VToe0aU4=;
 b=EoS38ex04drQl/rbW4q83DPxNlad/4370w8pmGDHaU4F4p0JK6TQxoCCnKIeNA2KuK
 HoEl2IRA4YraYLNq1dkHe9krP/ig3oD98g1LaJGtFIB+4M2afuXr8lJVdrInIGO/sm3w
 zPWCSlDrvQ5LxTszGwVdlJDGc7/mY4itOfTAUAPx7SVBbrzbQ+6/xM3DtM2XJ2DNcohu
 XuuKI1gvufnjVA1bQYs4XnzvnLOgauuDx6u9gdNY7ABRuy85dWsl0OfebSJrdx0pdnIA
 vWrls0rfqNPDOxw4C4TSTldGaUPBJmVWGndxe6H6L1+eQOGNM8fqgScxYRMTIWZuhpZ9
 EQXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxOp65OWEoU+tkNBwwHgMDhxmmu2J/RVgbSSx0ujCgxraazL5Oq7VoaU/jVOcbwlytG3ReUh8Iw4jzEwA6a1xsBXteC+o=
X-Gm-Message-State: AOJu0Yy3kSAtbh57DuMN2Q0EQ3HRVCOJevuVuQx+HeoNuX4leFhYaRpX
 vVmT7775PP7258uPw4ACY7/kNzbogVyMt3g7Yhoh8rr175oXJPBV3G9xKVXsbZuY3hEqgEfC481
 qwSXEwxsBms0V8dPStImHDsYLzttGUBe8eoAxnInEmciuv/O1Cgua
X-Received: by 2002:a05:6e02:144a:b0:375:ab32:8f0 with SMTP id
 e9e14a558f8ab-375ab322623mr23859305ab.14.1718034832892; 
 Mon, 10 Jun 2024 08:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaExKluA3Rvt6JuOILzBUOwxkdxt3YsHkWnG49oBIvMx6jA+Z0EzSj5Xc2lZQPvbVXGzCMbg==
X-Received: by 2002:a05:6e02:144a:b0:375:ab32:8f0 with SMTP id
 e9e14a558f8ab-375ab322623mr23858955ab.14.1718034832303; 
 Mon, 10 Jun 2024 08:53:52 -0700 (PDT)
Received: from localhost.localdomain ([115.96.118.89])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-6e3819ffa94sm5155290a12.85.2024.06.10.08.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 08:53:51 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 3/3] tests/qtest/x86: check for availability of older cpu
 models before running tests
Date: Mon, 10 Jun 2024 21:23:00 +0530
Message-ID: <20240610155303.7933-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240610155303.7933-1-anisinha@redhat.com>
References: <20240610155303.7933-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It is better to check if some older cpu models like 486, athlon, pentium,
penryn, phenom, core2duo etc are available before running their corresponding
tests. Some downstream distributions may no longer support these older cpu
models.

Signature of add_feature_test() has been modified to return void as
FeatureTestArgs* was not used by the caller.

One minor correction. Replaced 'phenom' with '486' in the test
'x86/cpuid/auto-level/phenom/arat' matching the cpu used.

CC: thuth@redhat.com
CC: imammedo@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/test-x86-cpuid-compat.c | 170 ++++++++++++++++++----------
 1 file changed, 108 insertions(+), 62 deletions(-)

changelog:
v2: reworked as per suggestion from danpb.
v3: reworked as_feature_test() same way as add_cpuid_test()
v4: phil's suggestion. tags added.

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 6a39454fce..b9e7e5ef7b 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -67,10 +67,29 @@ static void test_cpuid_prop(const void *data)
     g_free(path);
 }
 
-static void add_cpuid_test(const char *name, const char *cmdline,
+static void add_cpuid_test(const char *name, const char *cpu,
+                           const char *cpufeat, const char *machine,
                            const char *property, int64_t expected_value)
 {
     CpuidTestArgs *args = g_new0(CpuidTestArgs, 1);
+    char *cmdline;
+    char *save;
+
+    if (!qtest_has_cpu_model(cpu)) {
+        return;
+    }
+    cmdline = g_strdup_printf("-cpu %s", cpu);
+
+    if (cpufeat) {
+        save = cmdline;
+        cmdline = g_strdup_printf("%s,%s", cmdline, cpufeat);
+        g_free(save);
+    }
+    if (machine) {
+        save = cmdline;
+        cmdline = g_strdup_printf("-machine %s %s", machine, cmdline);
+        g_free(save);
+    }
     args->cmdline = cmdline;
     args->property = property;
     args->expected_value = expected_value;
@@ -149,12 +168,24 @@ static void test_feature_flag(const void *data)
  * either "feature-words" or "filtered-features", when running QEMU
  * using cmdline
  */
-static FeatureTestArgs *add_feature_test(const char *name, const char *cmdline,
-                                         uint32_t eax, uint32_t ecx,
-                                         const char *reg, int bitnr,
-                                         bool expected_value)
+static void add_feature_test(const char *name, const char *cpu,
+                             const char *cpufeat, uint32_t eax,
+                             uint32_t ecx, const char *reg,
+                             int bitnr, bool expected_value)
 {
     FeatureTestArgs *args = g_new0(FeatureTestArgs, 1);
+    char *cmdline;
+
+    if (!qtest_has_cpu_model(cpu)) {
+        return;
+    }
+
+    if (cpufeat) {
+        cmdline = g_strdup_printf("-cpu %s,%s", cpu, cpufeat);
+    } else {
+        cmdline = g_strdup_printf("-cpu %s", cpu);
+    }
+
     args->cmdline = cmdline;
     args->in_eax = eax;
     args->in_ecx = ecx;
@@ -162,13 +193,17 @@ static FeatureTestArgs *add_feature_test(const char *name, const char *cmdline,
     args->bitnr = bitnr;
     args->expected_value = expected_value;
     qtest_add_data_func(name, args, test_feature_flag);
-    return args;
+    return;
 }
 
 static void test_plus_minus_subprocess(void)
 {
     char *path;
 
+    if (!qtest_has_cpu_model("pentium")) {
+        return;
+    }
+
     /* Rules:
      * 1)"-foo" overrides "+foo"
      * 2) "[+-]foo" overrides "foo=..."
@@ -198,6 +233,10 @@ static void test_plus_minus_subprocess(void)
 
 static void test_plus_minus(void)
 {
+    if (!qtest_has_cpu_model("pentium")) {
+        return;
+    }
+
     g_test_trap_subprocess("/x86/cpuid/parsing-plus-minus/subprocess", 0, 0);
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr("*Ambiguous CPU model string. "
@@ -217,99 +256,105 @@ int main(int argc, char **argv)
 
     /* Original level values for CPU models: */
     add_cpuid_test("x86/cpuid/phenom/level",
-                   "-cpu phenom", "level", 5);
+                   "phenom", NULL, NULL, "level", 5);
     add_cpuid_test("x86/cpuid/Conroe/level",
-                   "-cpu Conroe", "level", 10);
+                   "Conroe", NULL, NULL, "level", 10);
     add_cpuid_test("x86/cpuid/SandyBridge/level",
-                   "-cpu SandyBridge", "level", 0xd);
+                   "SandyBridge", NULL, NULL, "level", 0xd);
     add_cpuid_test("x86/cpuid/486/xlevel",
-                   "-cpu 486", "xlevel", 0);
+                   "486", NULL, NULL, "xlevel", 0);
     add_cpuid_test("x86/cpuid/core2duo/xlevel",
-                   "-cpu core2duo", "xlevel", 0x80000008);
+                   "core2duo", NULL, NULL, "xlevel", 0x80000008);
     add_cpuid_test("x86/cpuid/phenom/xlevel",
-                   "-cpu phenom", "xlevel", 0x8000001A);
+                   "phenom", NULL, NULL, "xlevel", 0x8000001A);
     add_cpuid_test("x86/cpuid/athlon/xlevel",
-                   "-cpu athlon", "xlevel", 0x80000008);
+                   "athlon", NULL, NULL, "xlevel", 0x80000008);
 
     /* If level is not large enough, it should increase automatically: */
     /* CPUID[6].EAX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/arat",
-                   "-cpu 486,arat=on", "level", 6);
+    add_cpuid_test("x86/cpuid/auto-level/486/arat",
+                   "486", "arat=on", NULL, "level", 6);
     /* CPUID[EAX=7,ECX=0].EBX: */
     add_cpuid_test("x86/cpuid/auto-level/phenom/fsgsbase",
-                   "-cpu phenom,fsgsbase=on", "level", 7);
+                   "phenom", "fsgsbase=on", NULL, "level", 7);
     /* CPUID[EAX=7,ECX=0].ECX: */
     add_cpuid_test("x86/cpuid/auto-level/phenom/avx512vbmi",
-                   "-cpu phenom,avx512vbmi=on", "level", 7);
+                   "phenom", "avx512vbmi=on", NULL, "level", 7);
     /* CPUID[EAX=0xd,ECX=1].EAX: */
     add_cpuid_test("x86/cpuid/auto-level/phenom/xsaveopt",
-                   "-cpu phenom,xsaveopt=on", "level", 0xd);
+                   "phenom", "xsaveopt=on", NULL, "level", 0xd);
     /* CPUID[8000_0001].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/3dnow",
-                   "-cpu 486,3dnow=on", "xlevel", 0x80000001);
+                   "486", "3dnow=on", NULL, "xlevel", 0x80000001);
     /* CPUID[8000_0001].ECX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/sse4a",
-                   "-cpu 486,sse4a=on", "xlevel", 0x80000001);
+                   "486", "sse4a=on", NULL, "xlevel", 0x80000001);
     /* CPUID[8000_0007].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/invtsc",
-                   "-cpu 486,invtsc=on", "xlevel", 0x80000007);
+                   "486", "invtsc=on", NULL, "xlevel", 0x80000007);
     /* CPUID[8000_000A].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
-                   "-cpu 486,svm=on,npt=on", "xlevel", 0x8000000A);
+                   "486", "svm=on,npt=on", NULL, "xlevel", 0x8000000A);
     /* CPUID[C000_0001].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
-                   "-cpu phenom,xstore=on", "xlevel2", 0xC0000001);
+                   "phenom", "xstore=on", NULL, "xlevel2", 0xC0000001);
     /* SVM needs CPUID[0x8000000A] */
     add_cpuid_test("x86/cpuid/auto-xlevel/athlon/svm",
-                   "-cpu athlon,svm=on", "xlevel", 0x8000000A);
+                   "athlon", "svm=on", NULL, "xlevel", 0x8000000A);
 
 
     /* If level is already large enough, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-level/SandyBridge/multiple",
-                   "-cpu SandyBridge,arat=on,fsgsbase=on,avx512vbmi=on",
-                   "level", 0xd);
+                   "SandyBridge", "arat=on,fsgsbase=on,avx512vbmi=on",
+                   NULL, "level", 0xd);
     /* If level is explicitly set, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-level/486/fixed/0xF",
-                   "-cpu 486,level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 0xF);
+                   "486",
+                   "level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                   NULL, "level", 0xF);
     add_cpuid_test("x86/cpuid/auto-level/486/fixed/2",
-                   "-cpu 486,level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 2);
+                   "486",
+                   "level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                   NULL, "level", 2);
     add_cpuid_test("x86/cpuid/auto-level/486/fixed/0",
-                   "-cpu 486,level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 0);
+                   "486",
+                   "level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                   NULL, "level", 0);
 
     /* if xlevel is already large enough, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-xlevel/phenom/3dnow",
-                   "-cpu phenom,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x8000001A);
+                   "phenom", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0x8000001A);
     /* If xlevel is explicitly set, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/80000002",
-                   "-cpu 486,xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x80000002);
+                   "486",
+                   "xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0x80000002);
     add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/8000001A",
-                   "-cpu 486,xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x8000001A);
+                   "486",
+                   "xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0x8000001A);
     add_cpuid_test("x86/cpuid/auto-xlevel/phenom/fixed/0",
-                   "-cpu 486,xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0);
+                   "486",
+                   "xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0);
 
     /* if xlevel2 is already large enough, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-xlevel2/486/fixed",
-                   "-cpu 486,xlevel2=0xC0000002,xstore=on",
-                   "xlevel2", 0xC0000002);
+                   "486", "xlevel2=0xC0000002,xstore=on",
+                   NULL, "xlevel2", 0xC0000002);
 
     /* Check compatibility of old machine-types that didn't
      * auto-increase level/xlevel/xlevel2: */
     if (qtest_has_machine("pc-i440fx-2.7")) {
         add_cpuid_test("x86/cpuid/auto-level/pc-2.7",
-                       "-machine pc-i440fx-2.7 -cpu 486,arat=on,avx512vbmi=on,xsaveopt=on",
-                       "level", 1);
+                       "486", "arat=on,avx512vbmi=on,xsaveopt=on",
+                       "pc-i440fx-2.7", "level", 1);
         add_cpuid_test("x86/cpuid/auto-xlevel/pc-2.7",
-                       "-machine pc-i440fx-2.7 -cpu 486,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                       "xlevel", 0);
+                       "486", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                       "pc-i440fx-2.7", "xlevel", 0);
         add_cpuid_test("x86/cpuid/auto-xlevel2/pc-2.7",
-                       "-machine pc-i440fx-2.7 -cpu 486,xstore=on",
+                       "486", "xstore=on", "pc-i440fx-2.7",
                        "xlevel2", 0);
     }
     /*
@@ -319,18 +364,18 @@ int main(int argc, char **argv)
      */
     if (qtest_has_machine("pc-i440fx-2.3")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/off",
-                       "-machine pc-i440fx-2.3 -cpu Penryn",
+                       "Penryn", NULL, "pc-i440fx-2.3",
                        "level", 4);
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/on",
-                       "-machine pc-i440fx-2.3 -cpu Penryn,erms=on",
+                       "Penryn", "erms=on", "pc-i440fx-2.3",
                        "level", 7);
     }
     if (qtest_has_machine("pc-i440fx-2.9")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
-                       "-machine pc-i440fx-2.9 -cpu Conroe",
+                       "Conroe", NULL, "pc-i440fx-2.9",
                        "level", 10);
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/on",
-                       "-machine pc-i440fx-2.9 -cpu Conroe,erms=on",
+                       "Conroe", "erms=on", "pc-i440fx-2.9",
                        "level", 10);
     }
 
@@ -341,42 +386,43 @@ int main(int argc, char **argv)
      */
     if (qtest_has_machine("pc-i440fx-2.3")) {
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.3",
-                       "-machine pc-i440fx-2.3 -cpu SandyBridge",
+                       "SandyBridge", NULL, "pc-i440fx-2.3",
                        "xlevel", 0x8000000a);
     }
     if (qtest_has_machine("pc-i440fx-2.4")) {
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
-                       "-machine pc-i440fx-2.4 -cpu SandyBridge,",
+                       "SandyBridge", NULL, "pc-i440fx-2.4",
                        "xlevel", 0x80000008);
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
-                       "-machine pc-i440fx-2.4 -cpu SandyBridge,svm=on,npt=on",
+                       "SandyBridge", "svm=on,npt=on", "pc-i440fx-2.4",
                        "xlevel", 0x80000008);
     }
 
     /* Test feature parsing */
     add_feature_test("x86/cpuid/features/plus",
-                     "-cpu 486,+arat",
+                     "486", "+arat",
                      6, 0, "EAX", 2, true);
     add_feature_test("x86/cpuid/features/minus",
-                     "-cpu pentium,-mmx",
+                     "pentium", "-mmx",
                      1, 0, "EDX", 23, false);
     add_feature_test("x86/cpuid/features/on",
-                     "-cpu 486,arat=on",
+                     "486", "arat=on",
                      6, 0, "EAX", 2, true);
     add_feature_test("x86/cpuid/features/off",
-                     "-cpu pentium,mmx=off",
+                     "pentium", "mmx=off",
                      1, 0, "EDX", 23, false);
+
     add_feature_test("x86/cpuid/features/max-plus-invtsc",
-                     "-cpu max,+invtsc",
+                     "max" , "+invtsc",
                      0x80000007, 0, "EDX", 8, true);
     add_feature_test("x86/cpuid/features/max-invtsc-on",
-                     "-cpu max,invtsc=on",
+                     "max", "invtsc=on",
                      0x80000007, 0, "EDX", 8, true);
     add_feature_test("x86/cpuid/features/max-minus-mmx",
-                     "-cpu max,-mmx",
+                     "max", "-mmx",
                      1, 0, "EDX", 23, false);
     add_feature_test("x86/cpuid/features/max-invtsc-on,mmx=off",
-                     "-cpu max,mmx=off",
+                     "max", "mmx=off",
                      1, 0, "EDX", 23, false);
 
     return g_test_run();
-- 
2.42.0



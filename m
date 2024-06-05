Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1214C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEl1t-0007Rp-LM; Wed, 05 Jun 2024 03:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sEl1s-0007RI-2T
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sEl1q-0004ai-00
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717572348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fiVJUtIQgCNlR10lRRAGnZcdMQyFwt7Yf0bpSkUpQr8=;
 b=LgYQihj9gJ9Wfx4iPfa20JYLAYuyPoAS9ckY1eH49WkXZZR0Oy8V8tMJmDKHryl1vakbGU
 P9Ea2GydmhZrW8Vsb1BdhmUqvihWsPWgCPnBeq124AW8KkPc4IhqmTncWpJF6oEhmgkqD0
 iPmR1R4v0aH5ok4rxenXxjgp7ITJFYM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-nAyHQEnmP7KoxuEhqxBG_w-1; Wed, 05 Jun 2024 03:25:46 -0400
X-MC-Unique: nAyHQEnmP7KoxuEhqxBG_w-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1f61b9823cbso65402585ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717572345; x=1718177145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fiVJUtIQgCNlR10lRRAGnZcdMQyFwt7Yf0bpSkUpQr8=;
 b=CszTP6zR7jCf9BbicR7WUVibxFYu3OZ1JDtRZ1J+m5hwyd78rSAiPM7oJUpLkdgLbd
 1Npqde9WREcRPf5kXt7wFwLrPpJf5wZQCjFcHhfi+8SJw2eUBeGLI7NI/jAbVNZDHOoM
 0wSUVsDRlJWtHPxvTs+erO8sj8+G00w8IngtOQBw1wFDkb8lGlRPnLafPwgYq+ShX5IQ
 VmGDrh70dDD7Xajsx9ZcHB+BAlj57ePkCioqWWX7GUS+JXPSlVL5ul3Psh6CvlGWVD03
 UKPyrEdO5/kAdvKSlhvXaq6BzHIoqeauCG6coSuxeE9sPBzl0Pd8o1D+I616uHVxhYzq
 7pow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw8//Q2NsqCmqzvHWXxxMH65PA0NQvc+bYr+sj6K73iZQy1qUrYXRAuAvAeKn7v5YtgG94jD5M26LajhheZzqwhRrf53g=
X-Gm-Message-State: AOJu0Yx6RieLG3vzD0VNXXG/HJwhC+ZS/56eqQOaC4SOfSiCr+e/te23
 JR79k3QF4JRpnf/TBnCWBc8fwkB3dcvWpUglOvm6LakQQmpKq4jFQUf6Spv6vhT4Nj74gDiOkYE
 LPfyauCJr5fCIgYWC0HV1bWslzLBqDlarJuHadNe3NZcAhg7U20r6
X-Received: by 2002:a17:902:ceca:b0:1f6:850c:3c5f with SMTP id
 d9443c01a7336-1f6a5a879c2mr23912375ad.69.1717572345043; 
 Wed, 05 Jun 2024 00:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhPvemlzt2pvD8gLlIaI4OsKiYczgRWOj2BAoUCErNcn96Drl9ZFAr4LTIVoRDJOIXriRszg==
X-Received: by 2002:a17:902:ceca:b0:1f6:850c:3c5f with SMTP id
 d9443c01a7336-1f6a5a879c2mr23912195ad.69.1717572344616; 
 Wed, 05 Jun 2024 00:25:44 -0700 (PDT)
Received: from localhost.localdomain ([203.163.232.78])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6703f7673sm56329335ad.210.2024.06.05.00.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 00:25:44 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/qtest/x86: check for availability of older cpu
 models before running tests
Date: Wed,  5 Jun 2024 12:55:11 +0530
Message-ID: <20240605072512.67692-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240605072512.67692-1-anisinha@redhat.com>
References: <20240605072512.67692-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Some older cpu models like 486, athlon, pentium, penryn, phenom, core2duo etc
may not be available in all builds. Check for their availability in qemu before
running the corresponding tests.

The order of the tests has been altered so that all tests for similar checks
under a specific cpu is placed together.

One minor correction. Replaced 'phenom' with '486' in the test
'x86/cpuid/auto-level/phenom/arat' matching the cpu used.

CC: thuth@redhat.com
CC: imammedo@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/test-x86-cpuid-compat.c | 214 +++++++++++++++++-----------
 1 file changed, 127 insertions(+), 87 deletions(-)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 6a39454fce..054f9eae47 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -209,99 +209,135 @@ static void test_plus_minus(void)
 
 int main(int argc, char **argv)
 {
+    bool has_486, has_athlon, has_conroe;
+    bool has_core2duo, has_penryn, has_pentium, has_phenom;
+
     g_test_init(&argc, &argv, NULL);
 
-    g_test_add_func("/x86/cpuid/parsing-plus-minus/subprocess",
-                    test_plus_minus_subprocess);
-    g_test_add_func("/x86/cpuid/parsing-plus-minus", test_plus_minus);
+    has_486 = qtest_has_cpu("486");
+    has_athlon = qtest_has_cpu("athlon");
+    has_conroe = qtest_has_cpu("Conroe");
+    has_core2duo = qtest_has_cpu("core2duo");
+    has_penryn = qtest_has_cpu("Penryn");
+    has_pentium = qtest_has_cpu("pentium");
+    has_phenom = qtest_has_cpu("phenom");
+
+    if (has_pentium) {
+        g_test_add_func("/x86/cpuid/parsing-plus-minus/subprocess",
+                        test_plus_minus_subprocess);
+        g_test_add_func("/x86/cpuid/parsing-plus-minus", test_plus_minus);
+    }
 
     /* Original level values for CPU models: */
-    add_cpuid_test("x86/cpuid/phenom/level",
-                   "-cpu phenom", "level", 5);
-    add_cpuid_test("x86/cpuid/Conroe/level",
-                   "-cpu Conroe", "level", 10);
+    if (has_486) {
+        add_cpuid_test("x86/cpuid/486/xlevel",
+                       "-cpu 486", "xlevel", 0);
+    }
+    if (has_phenom) {
+        add_cpuid_test("x86/cpuid/phenom/level",
+                       "-cpu phenom", "level", 5);
+        add_cpuid_test("x86/cpuid/phenom/xlevel",
+                       "-cpu phenom", "xlevel", 0x8000001A);
+    }
+    if (has_athlon) {
+        add_cpuid_test("x86/cpuid/athlon/xlevel",
+                       "-cpu athlon", "xlevel", 0x80000008);
+    }
+    if (has_core2duo) {
+        add_cpuid_test("x86/cpuid/core2duo/xlevel",
+                       "-cpu core2duo", "xlevel", 0x80000008);
+    }
+    if (has_conroe) {
+        add_cpuid_test("x86/cpuid/Conroe/level",
+                       "-cpu Conroe", "level", 10);
+    }
     add_cpuid_test("x86/cpuid/SandyBridge/level",
                    "-cpu SandyBridge", "level", 0xd);
-    add_cpuid_test("x86/cpuid/486/xlevel",
-                   "-cpu 486", "xlevel", 0);
-    add_cpuid_test("x86/cpuid/core2duo/xlevel",
-                   "-cpu core2duo", "xlevel", 0x80000008);
-    add_cpuid_test("x86/cpuid/phenom/xlevel",
-                   "-cpu phenom", "xlevel", 0x8000001A);
-    add_cpuid_test("x86/cpuid/athlon/xlevel",
-                   "-cpu athlon", "xlevel", 0x80000008);
 
     /* If level is not large enough, it should increase automatically: */
-    /* CPUID[6].EAX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/arat",
-                   "-cpu 486,arat=on", "level", 6);
-    /* CPUID[EAX=7,ECX=0].EBX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/fsgsbase",
-                   "-cpu phenom,fsgsbase=on", "level", 7);
-    /* CPUID[EAX=7,ECX=0].ECX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/avx512vbmi",
-                   "-cpu phenom,avx512vbmi=on", "level", 7);
-    /* CPUID[EAX=0xd,ECX=1].EAX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/xsaveopt",
-                   "-cpu phenom,xsaveopt=on", "level", 0xd);
-    /* CPUID[8000_0001].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/3dnow",
-                   "-cpu 486,3dnow=on", "xlevel", 0x80000001);
-    /* CPUID[8000_0001].ECX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/sse4a",
-                   "-cpu 486,sse4a=on", "xlevel", 0x80000001);
-    /* CPUID[8000_0007].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/invtsc",
-                   "-cpu 486,invtsc=on", "xlevel", 0x80000007);
-    /* CPUID[8000_000A].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
-                   "-cpu 486,svm=on,npt=on", "xlevel", 0x8000000A);
-    /* CPUID[C000_0001].EDX: */
-    add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
-                   "-cpu phenom,xstore=on", "xlevel2", 0xC0000001);
-    /* SVM needs CPUID[0x8000000A] */
-    add_cpuid_test("x86/cpuid/auto-xlevel/athlon/svm",
-                   "-cpu athlon,svm=on", "xlevel", 0x8000000A);
-
+    if (has_486) {
+        /* CPUID[6].EAX: */
+        add_cpuid_test("x86/cpuid/auto-level/486/arat",
+                       "-cpu 486,arat=on", "level", 6);
+        /* CPUID[8000_0001].EDX: */
+        add_cpuid_test("x86/cpuid/auto-xlevel/486/3dnow",
+                       "-cpu 486,3dnow=on", "xlevel", 0x80000001);
+        /* CPUID[8000_0001].ECX: */
+        add_cpuid_test("x86/cpuid/auto-xlevel/486/sse4a",
+                       "-cpu 486,sse4a=on", "xlevel", 0x80000001);
+        /* CPUID[8000_0007].EDX: */
+        add_cpuid_test("x86/cpuid/auto-xlevel/486/invtsc",
+                       "-cpu 486,invtsc=on", "xlevel", 0x80000007);
+        /* CPUID[8000_000A].EDX: */
+        add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
+                       "-cpu 486,svm=on,npt=on", "xlevel", 0x8000000A);
+    }
+    if (has_phenom) {
+        /* CPUID[EAX=7,ECX=0].EBX: */
+        add_cpuid_test("x86/cpuid/auto-level/phenom/fsgsbase",
+                       "-cpu phenom,fsgsbase=on", "level", 7);
+        /* CPUID[EAX=7,ECX=0].ECX: */
+        add_cpuid_test("x86/cpuid/auto-level/phenom/avx512vbmi",
+                       "-cpu phenom,avx512vbmi=on", "level", 7);
+        /* CPUID[EAX=0xd,ECX=1].EAX: */
+        add_cpuid_test("x86/cpuid/auto-level/phenom/xsaveopt",
+                       "-cpu phenom,xsaveopt=on", "level", 0xd);
+        /* CPUID[C000_0001].EDX: */
+        add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
+                       "-cpu phenom,xstore=on", "xlevel2", 0xC0000001);
+    }
+    if (has_athlon) {
+        /* SVM needs CPUID[0x8000000A] */
+        add_cpuid_test("x86/cpuid/auto-xlevel/athlon/svm",
+                       "-cpu athlon,svm=on", "xlevel", 0x8000000A);
+    }
 
     /* If level is already large enough, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-level/SandyBridge/multiple",
                    "-cpu SandyBridge,arat=on,fsgsbase=on,avx512vbmi=on",
                    "level", 0xd);
     /* If level is explicitly set, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-level/486/fixed/0xF",
-                   "-cpu 486,level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 0xF);
-    add_cpuid_test("x86/cpuid/auto-level/486/fixed/2",
-                   "-cpu 486,level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 2);
-    add_cpuid_test("x86/cpuid/auto-level/486/fixed/0",
-                   "-cpu 486,level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 0);
+    if (has_486) {
+        add_cpuid_test("x86/cpuid/auto-level/486/fixed/0xF",
+                       "-cpu 486,level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                       "level", 0xF);
+        add_cpuid_test("x86/cpuid/auto-level/486/fixed/2",
+                       "-cpu 486,level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                       "level", 2);
+        add_cpuid_test("x86/cpuid/auto-level/486/fixed/0",
+                       "-cpu 486,level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                       "level", 0);
+    }
 
     /* if xlevel is already large enough, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/phenom/3dnow",
-                   "-cpu phenom,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x8000001A);
+    if (has_phenom) {
+        add_cpuid_test("x86/cpuid/auto-xlevel/phenom/3dnow",
+                       "-cpu phenom,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                       "xlevel", 0x8000001A);
+    }
+
     /* If xlevel is explicitly set, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/80000002",
-                   "-cpu 486,xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x80000002);
-    add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/8000001A",
-                   "-cpu 486,xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x8000001A);
-    add_cpuid_test("x86/cpuid/auto-xlevel/phenom/fixed/0",
-                   "-cpu 486,xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0);
-
-    /* if xlevel2 is already large enough, it shouldn't change: */
-    add_cpuid_test("x86/cpuid/auto-xlevel2/486/fixed",
-                   "-cpu 486,xlevel2=0xC0000002,xstore=on",
-                   "xlevel2", 0xC0000002);
+    if (has_486) {
+        add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/80000002",
+                       "-cpu 486,xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                       "xlevel", 0x80000002);
+        add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/8000001A",
+                       "-cpu 486,xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                       "xlevel", 0x8000001A);
+        add_cpuid_test("x86/cpuid/auto-xlevel/phenom/fixed/0",
+                       "-cpu 486,xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                       "xlevel", 0);
+
+        /* if xlevel2 is already large enough, it shouldn't change: */
+        add_cpuid_test("x86/cpuid/auto-xlevel2/486/fixed",
+                       "-cpu 486,xlevel2=0xC0000002,xstore=on",
+                       "xlevel2", 0xC0000002);
+    }
+
 
     /* Check compatibility of old machine-types that didn't
      * auto-increase level/xlevel/xlevel2: */
-    if (qtest_has_machine("pc-i440fx-2.7")) {
+    if (qtest_has_machine("pc-i440fx-2.7") && has_486) {
         add_cpuid_test("x86/cpuid/auto-level/pc-2.7",
                        "-machine pc-i440fx-2.7 -cpu 486,arat=on,avx512vbmi=on,xsaveopt=on",
                        "level", 1);
@@ -317,7 +353,7 @@ int main(int argc, char **argv)
      * and the compat code that sets default level shouldn't
      * disable the auto-level=7 code:
      */
-    if (qtest_has_machine("pc-i440fx-2.3")) {
+    if (qtest_has_machine("pc-i440fx-2.3") && has_penryn) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/off",
                        "-machine pc-i440fx-2.3 -cpu Penryn",
                        "level", 4);
@@ -325,7 +361,7 @@ int main(int argc, char **argv)
                        "-machine pc-i440fx-2.3 -cpu Penryn,erms=on",
                        "level", 7);
     }
-    if (qtest_has_machine("pc-i440fx-2.9")) {
+    if (qtest_has_machine("pc-i440fx-2.9") && has_conroe) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
                        "-machine pc-i440fx-2.9 -cpu Conroe",
                        "level", 10);
@@ -354,18 +390,22 @@ int main(int argc, char **argv)
     }
 
     /* Test feature parsing */
-    add_feature_test("x86/cpuid/features/plus",
-                     "-cpu 486,+arat",
-                     6, 0, "EAX", 2, true);
-    add_feature_test("x86/cpuid/features/minus",
-                     "-cpu pentium,-mmx",
-                     1, 0, "EDX", 23, false);
-    add_feature_test("x86/cpuid/features/on",
-                     "-cpu 486,arat=on",
-                     6, 0, "EAX", 2, true);
-    add_feature_test("x86/cpuid/features/off",
-                     "-cpu pentium,mmx=off",
-                     1, 0, "EDX", 23, false);
+    if (has_486) {
+        add_feature_test("x86/cpuid/features/plus",
+                         "-cpu 486,+arat",
+                         6, 0, "EAX", 2, true);
+        add_feature_test("x86/cpuid/features/on",
+                         "-cpu 486,arat=on",
+                         6, 0, "EAX", 2, true);
+    }
+    if (has_pentium) {
+        add_feature_test("x86/cpuid/features/minus",
+                         "-cpu pentium,-mmx",
+                         1, 0, "EDX", 23, false);
+        add_feature_test("x86/cpuid/features/off",
+                         "-cpu pentium,mmx=off",
+                         1, 0, "EDX", 23, false);
+    }
     add_feature_test("x86/cpuid/features/max-plus-invtsc",
                      "-cpu max,+invtsc",
                      0x80000007, 0, "EDX", 8, true);
-- 
2.42.0



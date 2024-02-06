Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E22C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLow-00079s-Rr; Tue, 06 Feb 2024 08:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rXLou-00078G-GJ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:49:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1rXLor-0004Gn-JZ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707227340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EzHoY01nX7x4wZvLeW5STW/aF4elch2TluNHonG0RU=;
 b=NNb0/y8rvncKX0o46RJ/IGnOQDRxMW6T0AF9W/fTaFF70IT+mhcGXxxKjewZyBVehtLrKl
 rjn8BkcNDwmRT6fAWPo29UkjEoaDIEE8BrMViYqbFbKDMztM+jBVxdQB4v8Vzw+Ypr0sGf
 6OJWjCdTUie5xYT9H1KVftcNfsxEHDU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-DM-a9X7QNUSj3cuyQVgCzA-1; Tue,
 06 Feb 2024 08:47:45 -0500
X-MC-Unique: DM-a9X7QNUSj3cuyQVgCzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FCB838212C8;
 Tue,  6 Feb 2024 13:47:45 +0000 (UTC)
Received: from work.fritz.box (unknown [10.39.195.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E92B2026D06;
 Tue,  6 Feb 2024 13:47:44 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH v3 3/5] target/i386: Remove comments from
 feature_word_info.c.inc
Date: Tue,  6 Feb 2024 14:47:37 +0100
Message-ID: <20240206134739.15345-4-twiederh@redhat.com>
In-Reply-To: <20240206134739.15345-1-twiederh@redhat.com>
References: <20240206134739.15345-1-twiederh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The comments are preserved in the yaml file.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 target/i386/feature_word_info.c.inc | 56 ++++++++---------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/target/i386/feature_word_info.c.inc b/target/i386/feature_word_info.c.inc
index 4c6a1613ae..152d4b45a9 100644
--- a/target/i386/feature_word_info.c.inc
+++ b/target/i386/feature_word_info.c.inc
@@ -6,10 +6,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "tsc", "msr", "pae", "mce",
             "cx8", "apic", NULL, "sep",
             "mtrr", "pge", "mca", "cmov",
-            "pat", "pse36", "pn" /* Intel psn */, "clflush" /* Intel clfsh */,
-            NULL, "ds" /* Intel dts */, "acpi", "mmx",
+            "pat", "pse36", "pn", "clflush",
+            NULL, "ds", "acpi", "mmx",
             "fxsr", "sse", "sse2", "ss",
-            "ht" /* Intel htt */, "tm", "ia64", "pbe",
+            "ht", "tm", "ia64", "pbe",
         },
         .cpuid = {.eax = 1, .reg = R_EDX, },
         .tcg_features = TCG_FEATURES,
@@ -18,33 +18,28 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_ECX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "pni" /* Intel,AMD sse3 */, "pclmulqdq", "dtes64", "monitor",
+            "pni", "pclmulqdq", "dtes64", "monitor",
             "ds-cpl", "vmx", "smx", "est",
             "tm2", "ssse3", "cid", NULL,
             "fma", "cx16", "xtpr", "pdcm",
             NULL, "pcid", "dca", "sse4.1",
             "sse4.2", "x2apic", "movbe", "popcnt",
-            "tsc-deadline", "aes", "xsave", NULL /* osxsave */,
+            "tsc-deadline", "aes", "xsave", NULL,
             "avx", "f16c", "rdrand", "hypervisor",
         },
         .cpuid = { .eax = 1, .reg = R_ECX, },
         .tcg_features = TCG_EXT_FEATURES,
     },
-    /* Feature names that are already defined on feature_name[] but
-     * are set on CPUID[8000_0001].EDX on AMD CPUs don't have their
-     * names on feat_names below. They are copied automatically
-     * to features[FEAT_8000_0001_EDX] if and only if CPU vendor is AMD.
-     */
     [FEAT_8000_0001_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL /* fpu */, NULL /* vme */, NULL /* de */, NULL /* pse */,
-            NULL /* tsc */, NULL /* msr */, NULL /* pae */, NULL /* mce */,
-            NULL /* cx8 */, NULL /* apic */, NULL, "syscall",
-            NULL /* mtrr */, NULL /* pge */, NULL /* mca */, NULL /* cmov */,
-            NULL /* pat */, NULL /* pse36 */, NULL, NULL /* Linux mp */,
-            "nx", NULL, "mmxext", NULL /* mmx */,
-            NULL /* fxsr */, "fxsr-opt", "pdpe1gb", "rdtscp",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "syscall",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "nx", NULL, "mmxext", NULL,
+            NULL, "fxsr-opt", "pdpe1gb", "rdtscp",
             NULL, "lm", "3dnowext", "3dnow",
         },
         .cpuid = { .eax = 0x80000001, .reg = R_EDX, },
@@ -64,11 +59,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = { .eax = 0x80000001, .reg = R_ECX, },
         .tcg_features = TCG_EXT3_FEATURES,
-        /*
-         * TOPOEXT is always allowed but can't be enabled blindly by
-         * "-cpu host", as it requires consistent cache topology info
-         * to be provided so it doesn't confuse guests.
-         */
         .no_autoenable_flags = CPUID_EXT3_TOPOEXT,
     },
     [FEAT_C000_0001_EDX] = {
@@ -115,10 +105,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EDX, },
         .tcg_features = TCG_KVM_FEATURES,
-        /*
-         * KVM hints aren't auto-enabled by -cpu host, they need to be
-         * explicitly enabled in the command-line.
-         */
         .no_autoenable_flags = ~0U,
     },
     [FEAT_SVM] = {
@@ -159,7 +145,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
+            NULL, "waitpkg", "avx512vbmi2", NULL,
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
@@ -181,7 +167,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fsrm", NULL, NULL, NULL,
             "avx512-vp2intersect", NULL, "md-clear", NULL,
             NULL, NULL, "serialize", NULL,
-            "tsx-ldtrk", NULL, NULL /* pconfig */, "arch-lbr",
+            "tsx-ldtrk", NULL, NULL, "arch-lbr",
             NULL, NULL, "amx-bf16", "avx512-fp16",
             "amx-tile", "amx-int8", "spec-ctrl", "stibp",
             "flush-l1d", "arch-capabilities", "core-capability", "ssbd",
@@ -382,7 +368,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = ~0U,
     },
-    /*Below are MSR exposed features*/
     [FEAT_ARCH_CAPABILITIES] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -398,12 +383,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,
         },
-        /*
-         * FEAT_ARCH_CAPABILITIES only affects a read-only MSR, which
-         * cannot be read from user mode.  Therefore, it has no impact
-         > on any user-mode operation, and warnings about unsupported
-         * features do not matter.
-         */
         .tcg_features = ~0U,
     },
     [FEAT_CORE_CAPABILITY] = {
@@ -492,14 +471,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
 
     [FEAT_VMX_EXIT_CTLS] = {
         .type = MSR_FEATURE_WORD,
-        /*
-         * VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE is copied from
-         * the LM CPUID bit.
-         */
         .feat_names = {
             NULL, NULL, "vmx-exit-nosave-debugctl", NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL /* vmx-exit-host-addr-space-size */, NULL, NULL,
+            NULL, NULL, NULL, NULL,
             "vmx-exit-load-perf-global-ctrl", NULL, NULL, "vmx-exit-ack-intr",
             NULL, NULL, "vmx-exit-save-pat", "vmx-exit-load-pat",
             "vmx-exit-save-efer", "vmx-exit-load-efer",
@@ -582,7 +557,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .msr = {
             .index = MSR_IA32_VMX_BASIC,
         },
-        /* Just to be safe - we don't support setting the MSEG version field.  */
         .no_autoenable_flags = MSR_VMX_BASIC_DUAL_MONITOR,
     },
 
-- 
2.43.0



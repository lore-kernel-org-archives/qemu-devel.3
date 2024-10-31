Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB206D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNz-00067F-G7; Thu, 31 Oct 2024 13:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMs-0002ft-8U
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMq-0007TY-KB
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyVI+E9OoZNc0zNxyyEyBemH/gL2SNeii0sXkMz3sOQ=;
 b=SXhBOiRwndXMWmJhOcMMcGbhtOVYOdBeUQRFiSK65ThCfEnylZB5wePu4/V5/8f/GKdcxp
 B4s+tFcsogHeKUUsQOVg/46US6qHyTDJu95yxxURSCd+2jbzWk+fHUcPFmkpv18pkDVgJn
 Wfe5faSYB8pvLB/i+N+CIsF2pYlHUZU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-M0RyiqFyOO27nTAyyaipHw-1; Thu, 31 Oct 2024 13:53:54 -0400
X-MC-Unique: M0RyiqFyOO27nTAyyaipHw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43159603c92so7515495e9.2
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397233; x=1731002033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyVI+E9OoZNc0zNxyyEyBemH/gL2SNeii0sXkMz3sOQ=;
 b=vmnUJ5ldPdO4AJJ0EOTwtib7FhO8QysNI9D7b0Gdn8KP/SFzU7Kj1Yp/9B0JZGwBR0
 /789UhqLBRXZAzVQ+f4W7VCzbnvQmHYQ/6h34ZYytSkVOmlKmcIQbLNVzOXSiRcCWTHu
 rII91IUiAdqEP6MbBQBsiW7aUVYqW8vbWmw6ZPV7uBbCf395uL0M24/2yNg1ohWHoouH
 XBHjnHDTqd70obhXfioT9TA6z3UhGbWmAsPbo2d6imCBYEQJ8uFZWbIRBA4rTDOzixGm
 vq3J5I8PrBN9cDvknIVyqn/Jc2QHYwH9UBBsJEmGVh1/EkvpLMuKaacl8eoxMLYbyzKb
 njtw==
X-Gm-Message-State: AOJu0Ywey6m73wv/ZL+jqwD2bpGLLBViN34dHAlD/ilImJN/LS4Z2bqN
 emEFy55TgIW9BDC7hGCJsOwv4QIRU77MMS4fEVMh/z8SgsTs9NqibSBTQz4sc0BL/6rOj6+nBxn
 Vadp/hgm0sZgz3qaAbXabJjIMvkxPraMxuR/gXToT0l9lkg18XWg7JsAO5414khCgIUUmHS2Q7U
 yUfgS6uZfFRnMoH7GKs5eBaCv+gGkea25R+8VIQAk=
X-Received: by 2002:a05:600c:3b8c:b0:431:52f5:f497 with SMTP id
 5b1f17b1804b1-43284aedac9mr2533635e9.9.1730397232764; 
 Thu, 31 Oct 2024 10:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXNEqpxy/v6pTWM4GxAuG8yFF8pLCfXox0URanKdGEepJzYIYqWfKG6oi5T0MyqfxDThnN0g==
X-Received: by 2002:a05:600c:3b8c:b0:431:52f5:f497 with SMTP id
 5b1f17b1804b1-43284aedac9mr2533395e9.9.1730397232324; 
 Thu, 31 Oct 2024 10:53:52 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd910357sm66974135e9.11.2024.10.31.10.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 43/49] target/i386: do not rely on ExtSaveArea for
 accelerator-supported XCR0 bits
Date: Thu, 31 Oct 2024 18:52:07 +0100
Message-ID: <20241031175214.214455-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Right now, QEMU is using the "feature" and "bits" fields of ExtSaveArea
to query the accelerator for the support status of extended save areas.
This is a problem for AVX10, which attaches two feature bits (AVX512F
and AVX10) to the same extended save states.

To keep the AVX10 hacks to the minimum, limit usage of esa->features
and esa->bits.  Instead, just query the accelerator for the 0xD leaf.
Do it in common code and clear esa->size if an extended save state is
unsupported.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241031085233.425388-3-tao1.su@linux.intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c         | 33 +++++++++++++++++++++++++++++++--
 target/i386/kvm/kvm-cpu.c |  4 ----
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f08e9b8f1bc..1ee4d988caf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7102,6 +7102,15 @@ static void x86_cpu_set_sgxlepubkeyhash(CPUX86State *env)
 #endif
 }
 
+static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
+{
+    if (!esa->size) {
+        return false;
+    }
+
+    return (env->features[esa->feature] & esa->bits);
+}
+
 static void x86_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -7210,7 +7219,7 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
         if (!((1 << i) & CPUID_XSTATE_XCR0_MASK)) {
             continue;
         }
-        if (env->features[esa->feature] & esa->bits) {
+        if (cpuid_has_xsave_feature(env, esa)) {
             xcr0 |= 1ull << i;
         }
     }
@@ -7348,7 +7357,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
     mask = 0;
     for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
         const ExtSaveArea *esa = &x86_ext_save_areas[i];
-        if (env->features[esa->feature] & esa->bits) {
+        if (cpuid_has_xsave_feature(env, esa)) {
             mask |= (1ULL << i);
         }
     }
@@ -8020,6 +8029,26 @@ static void x86_cpu_register_feature_bit_props(X86CPUClass *xcc,
 
 static void x86_cpu_post_initfn(Object *obj)
 {
+    static bool first = true;
+    uint64_t supported_xcr0;
+    int i;
+
+    if (first) {
+        first = false;
+
+        supported_xcr0 =
+            ((uint64_t) x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_HI) << 32) |
+            x86_cpu_get_supported_feature_word(NULL, FEAT_XSAVE_XCR0_LO);
+
+        for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
+            ExtSaveArea *esa = &x86_ext_save_areas[i];
+
+            if (!(supported_xcr0 & (1 << i))) {
+                esa->size = 0;
+            }
+        }
+    }
+
     accel_cpu_instance_init(CPU(obj));
 }
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 6bf8dcfc607..99d1941cf51 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -143,10 +143,6 @@ static void kvm_cpu_xsave_init(void)
         if (!esa->size) {
             continue;
         }
-        if ((x86_cpu_get_supported_feature_word(NULL, esa->feature) & esa->bits)
-            != esa->bits) {
-            continue;
-        }
         host_cpuid(0xd, i, &eax, &ebx, &ecx, &edx);
         if (eax != 0) {
             assert(esa->size == eax);
-- 
2.47.0



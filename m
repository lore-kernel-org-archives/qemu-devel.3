Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9470CD3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o0f-0007AO-Ur; Tue, 29 Oct 2024 11:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o03-0005i7-RR
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5o01-0000QD-6L
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730215151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amEgcXJo78hmVv3iLaeffdJ13havQoo81JneMSxeI2g=;
 b=M58uAfeP0z9mSs6ub+ZHGMh8GL7DqZ8Jxk/mmCZ9kMa7e9S/U2x4nbrp53vy1L0UagjU9L
 O798a4+s7CQXzLH3aCxU/RcMiLxoZY1Y7iQXkk7H6SpGeg1KbV2siBxR8z9WROx6egCqpU
 UeyjkFfNOFx/uolznPDp1Y1eqp+Kawc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-hOjrdwQfPrujzYkpgL2VnQ-1; Tue, 29 Oct 2024 11:19:08 -0400
X-MC-Unique: hOjrdwQfPrujzYkpgL2VnQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2fb4c08c02cso30770951fa.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215145; x=1730819945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amEgcXJo78hmVv3iLaeffdJ13havQoo81JneMSxeI2g=;
 b=D/22erS67sHfDkvkdrePjk38gXv5qyayuirpXeFY+9rbFhQhRfxE3nerGmn2NrSKal
 S7OjTgjqSRlXyVfwtqmEG2WZWAgMvF827KoGiHY/Z13IsF3lbgWcW2+5VleN5TvrCQPn
 wWUcFKjgjgKDDpR5sHr0QdIQRpa1a1mBriWsXFq+H1MPHjvbKA2ILFO6yy4i2Phv+AK6
 n0Z8TyfDFvT+Ds8qgnbRZQh1NmU9Q8MhRaT4nkVe9OAUVlB1I87Sq72PEs84+nX5j9Pq
 YkXmuoC4txzfXXC0VKz6BIkzS3z75K661po5euEwNt2kc+v8KSYU24YvjyVrrQEYgKjF
 t3xw==
X-Gm-Message-State: AOJu0Ywc33nTwAinY80oCAg4FwFhM6dxctoxBC6hKT2sPr7Y+EEBYmyH
 3TSG5DiMZySDZu61voFpbktKU2vwUlHqwPKSDgzL4L6P8v/uXvxpLorW6gRsl8HoCGspSsBPpol
 4Aa7armw9Kvq8khQj7xsrBxAg0qNkdugYtdRF5MnscjGvaf/Nl3zkgtgbEXKzkuP1eUxUGA6r9q
 pEmERaicsqN27KhG5BwRE+u3C/6P5uCU4w4Ap7578=
X-Received: by 2002:a05:6512:12d1:b0:539:fcba:cc6d with SMTP id
 2adb3069b0e04-53b34a19019mr5150159e87.42.1730215145184; 
 Tue, 29 Oct 2024 08:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4saYzE0tgf9mYzcF9FdC3vqsQk/xuOLBYideCq6dfXxsx0z+qYlzuVvewOADuaXryxD8bbg==
X-Received: by 2002:a05:6512:12d1:b0:539:fcba:cc6d with SMTP id
 2adb3069b0e04-53b34a19019mr5150137e87.42.1730215144603; 
 Tue, 29 Oct 2024 08:19:04 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b5707e8sm177909125e9.36.2024.10.29.08.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:19:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tao1.su@linux.intel.com,
	zhao1.liu@intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH 2/8] target/i386: do not rely on ExtSaveArea for
 accelerator-supported XCR0 bits
Date: Tue, 29 Oct 2024 16:18:52 +0100
Message-ID: <20241029151858.550269-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029151858.550269-1-pbonzini@redhat.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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
index 6bf8dcfc607..d9306418490 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -133,10 +133,6 @@ static void kvm_cpu_xsave_init(void)
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



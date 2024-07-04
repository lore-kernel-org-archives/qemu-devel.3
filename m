Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99387C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 10:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJEd-0006dL-Cy; Thu, 04 Jul 2024 05:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEa-0006Yy-1C
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sPJEX-00087O-CJ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720087112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfZ2gFIZh1S09Ups+9rXVB9WcHJZ9HitC1LvQrZFclA=;
 b=i/+4LkISHEj+opPmudgwEI47PBpeBNgw9qhTh3iGVSBcGC9P3xJApM1Xm2Txd1Emb0/p45
 7Ne2YL1VAOyqTJ4rNCZLG4EAFdIpfPKr54u179qWUk7EBajEARFwqBC0ob2ztDTGJ27T4Y
 L7rcfVeF8HBUj2g14Y3yKmZrnS04eCA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-u2LzLw-5PGWxaQqbLdBdww-1; Thu, 04 Jul 2024 05:58:27 -0400
X-MC-Unique: u2LzLw-5PGWxaQqbLdBdww-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52e9d91ec1bso487769e87.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720087105; x=1720691905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfZ2gFIZh1S09Ups+9rXVB9WcHJZ9HitC1LvQrZFclA=;
 b=qDKDtbhcl82VIgvC7TdFZAs5HWCL8BUfY97sE/fZQYgCary5rjawWrKEdVJU8Zco1I
 eu0yOb+DR50cukB+mJSNx8uOuKcmlld0esNLbk5ZyuDyeVIlsvmfhBilcAm0pHlCcS8H
 u16JwTM1+d3wHx0XHbczEthvnQdIoTN7EPdx8pnKODduHZ5oV/sEKqBjAMiQ7bZzjzCb
 PJsnOd9SeBgfdx6lD0IDH4sojAqi4bKG/0wEAdVLrw+R2CpDGL5AIIcSpPmkkNrKP1dk
 D6JHZztSIcVHCrzmmVTpGLSklTBlPYrO7comA6pbyH1pEQRsazD5PM8VqDrqVlS8ERUo
 xUQw==
X-Gm-Message-State: AOJu0YxPV5S7ftPf7Fj3Q8J1l6uqQ0QRvGOwJrd3GdOd/TeTrm3PEDDC
 W9mblVOwiVYU/VkD+Rp5I6Nrm6t1L/KkLTc/xQw/G63DaZ1+7Ny4bUu03/FWCzqo9yHOGN7GJtI
 LvUB7A0X+9NOjK+Fq5LamMfg6ONd+R6UMF1yo3i/HiunWeIA06K2bBOTm8EuI26S9Vsw42Ki12K
 r8zK0lpuuXlnJFshPwmN77MkIFvBuKWxA6STBX
X-Received: by 2002:ac2:4989:0:b0:52c:d56f:b2cc with SMTP id
 2adb3069b0e04-52ea06d30d0mr766943e87.58.1720087104848; 
 Thu, 04 Jul 2024 02:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3bmQY33yW7swpFbJJSb20ZXaYGeQclin5q1WsVn9Ns0+1S6l52VFMFdImicXPMxM3cAs/JA==
X-Received: by 2002:ac2:4989:0:b0:52c:d56f:b2cc with SMTP id
 2adb3069b0e04-52ea06d30d0mr766929e87.58.1720087104484; 
 Thu, 04 Jul 2024 02:58:24 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d0b24sm17477465e9.3.2024.07.04.02.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 02:58:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	John Allen <john.allen@amd.com>
Subject: [PULL 07/16] target/i386: pass X86CPU to
 x86_cpu_get_supported_feature_word
Date: Thu,  4 Jul 2024 11:57:57 +0200
Message-ID: <20240704095806.1780273-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704095806.1780273-1-pbonzini@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This allows modifying the bits in "-cpu max"/"-cpu host" depending on
the guest CPU vendor (which, at least by default, is the host vendor in
the case of KVM).

For example, machine check architecture differs between Intel and AMD,
and bits from AMD should be dropped when configuring the guest for
an Intel model.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: John Allen <john.allen@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h         |  3 +--
 target/i386/cpu.c         | 11 +++++------
 target/i386/kvm/kvm-cpu.c |  2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 29daf370485..9bea7142bf4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -666,8 +666,7 @@ typedef enum FeatureWord {
 } FeatureWord;
 
 typedef uint64_t FeatureWordArray[FEATURE_WORDS];
-uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
-                                            bool migratable_only);
+uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 
 /* cpuid_features bits */
 #define CPUID_FP87 (1U << 0)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4c2e6f3a71e..4364cb0f8e3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6035,8 +6035,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 
 #endif /* !CONFIG_USER_ONLY */
 
-uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
-                                            bool migratable_only)
+uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
     uint64_t r = 0;
@@ -6078,7 +6077,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
         r &= ~unavail;
     }
 #endif
-    if (migratable_only) {
+    if (cpu && cpu->migratable) {
         r &= x86_cpu_get_migratable_flags(w);
     }
     return r;
@@ -7371,7 +7370,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
              * by the user.
              */
             env->features[w] |=
-                x86_cpu_get_supported_feature_word(w, cpu->migratable) &
+                x86_cpu_get_supported_feature_word(cpu, w) &
                 ~env->user_features[w] &
                 ~feature_word_info[w].no_autoenable_flags;
         }
@@ -7497,7 +7496,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
 
     for (w = 0; w < FEATURE_WORDS; w++) {
         uint64_t host_feat =
-            x86_cpu_get_supported_feature_word(w, false);
+            x86_cpu_get_supported_feature_word(NULL, w);
         uint64_t requested_features = env->features[w];
         uint64_t unavailable_features = requested_features & ~host_feat;
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
@@ -7617,7 +7616,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
     if (requested_lbr_fmt && kvm_enabled()) {
         uint64_t host_perf_cap =
-            x86_cpu_get_supported_feature_word(FEAT_PERF_CAPABILITIES, false);
+            x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
         unsigned host_lbr_fmt = host_perf_cap & PERF_CAP_LBR_FMT;
 
         if (!cpu->enable_pmu) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index d57a68a301e..6bf8dcfc607 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -143,7 +143,7 @@ static void kvm_cpu_xsave_init(void)
         if (!esa->size) {
             continue;
         }
-        if ((x86_cpu_get_supported_feature_word(esa->feature, false) & esa->bits)
+        if ((x86_cpu_get_supported_feature_word(NULL, esa->feature) & esa->bits)
             != esa->bits) {
             continue;
         }
-- 
2.45.2



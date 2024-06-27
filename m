Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DF1C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMplz-000210-Ta; Thu, 27 Jun 2024 10:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMplt-0001yV-2S
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMplo-0003gH-Cv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719497199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dM6O63wcC2cMMhdnQlAbeBUAGlSZvYq8QRIEZnd0eDU=;
 b=BAU6OfTxuA5cwF/Q9TJe+A/uU2MOICiq1/+//XkEvyYzUSBq7VlElHzm77ondyooI/OK9R
 PCGNVT6HnTyIRIUdYBiAIjcXKCPXMMS1aS3ycBCoEdVQfLcT1Twk4n3D9DODgxs4tjBv6F
 D+sFZB0DIb2qg0jQwcSp40x3wiDgrrE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-ddf_m7o_MnuK1zfLHctLGg-1; Thu, 27 Jun 2024 10:06:37 -0400
X-MC-Unique: ddf_m7o_MnuK1zfLHctLGg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57c93227bbeso1060430a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719497195; x=1720101995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dM6O63wcC2cMMhdnQlAbeBUAGlSZvYq8QRIEZnd0eDU=;
 b=f0qNiRLp7pNVDnObYDK8S2n00xidQQu4Fg5WQsD1abXmOAi3KB3kD6GxTmdJTxqPh8
 kaO1PmO9V0viSy8QxEWJh9qjgMMwqHjdYQmJVmqdeSN/ycqJdhpQ27Um9483QIfBAyf9
 RkGlyCXtYQzIYEDt1aaj0lYaQwrAX1nAsjl6lH+k74uL99Kd4SOD7CJv3r8p+lu9mQQr
 a0BSnL5QpAuUQ/jrQ6x99lJaJQfrCcROCqkD34xwrm2ksPHcq7HsP8wDRBlilh4Qp/zH
 hIVhnCgav+cWil7CGzMLlXTe/cFWiPTKh4JfO1834ZffR5ALtsshfVdA1RvfZYT6RbVn
 03vA==
X-Gm-Message-State: AOJu0YzvKxHBNlauUSCfVB35vsWtIP4HkUYZQYFoi3/jM5FFHcQyK7bT
 zkfwNPpQV3R49km6R8/kf4h/fC4hx081ZqKsUfI0fwcz0AaQPyfIJdG4m9s8eRHjoHLvPaelsmb
 5EDjq+Dg0q28+e72cDhHsugdvKQ6rWY1AtjAjYVFegdfBkwTgUPeM9so1fudId8ZIdYG0JAXm9V
 f6oSCwiMQ4AqnwuI1NDgvkD83rIQUkdGBtXXW8
X-Received: by 2002:a50:ab1d:0:b0:57d:4d12:61bd with SMTP id
 4fb4d7f45d1cf-57d4d1264b8mr8615784a12.37.1719497194416; 
 Thu, 27 Jun 2024 07:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu5gxcoCnHti2Yx+Utb4tAhIx1qwVFo88w7kRp3p3VqxlDk0YrMqeQEfTFx6tQbsdWKqLy+A==
X-Received: by 2002:a50:ab1d:0:b0:57d:4d12:61bd with SMTP id
 4fb4d7f45d1cf-57d4d1264b8mr8615746a12.37.1719497193723; 
 Thu, 27 Jun 2024 07:06:33 -0700 (PDT)
Received: from avogadro.local ([151.48.235.205])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-584d278167esm922397a12.73.2024.06.27.07.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:06:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	John Allen <john.allen@amd.com>
Subject: [PATCH 1/2] target/i386: pass X86CPU to
 x86_cpu_get_supported_feature_word
Date: Thu, 27 Jun 2024 16:06:27 +0200
Message-ID: <20240627140628.1025317-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627140628.1025317-1-pbonzini@redhat.com>
References: <20240627140628.1025317-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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
 target/i386/cpu.c         | 13 ++++++-------
 target/i386/kvm/kvm-cpu.c |  2 +-
 3 files changed, 8 insertions(+), 10 deletions(-)

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
index 4c2e6f3a71e..deb58670651 100644
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
@@ -6076,9 +6075,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
             ? CPUID_EXT2_LM & ~CPUID_EXT2_KERNEL_FEATURES
             : CPUID_EXT2_LM;
         r &= ~unavail;
-    }
+        break;
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
index f9b99b5f50d..b2735d6efee 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -136,7 +136,7 @@ static void kvm_cpu_xsave_init(void)
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A728D216B1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iN5-0005ro-B1; Tue, 15 Oct 2024 10:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iN1-0005mg-O8
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iMv-0003J9-Fs
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+2mCvLyMdyKwVjTtmM/ECYzEJ3zejSSBH8w1MErSlc=;
 b=i53kQw6JMD/gBEqDd0+Xzm9rGlN8OzwvxDPcaGtlEyUHCvhd1gb5RuOKFSQZtROhl/awPF
 3fBBIOEYVliHYEhrwqWjwbbnVgA0oaaz2iI7ng9pdHcBNgN8Fk087fcPoSgASytgeKSiuq
 lr9xN/BeWWKYPLf/IBJVF6k3skY30zc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-m1QVjJdGPue8kFUOuGHlmw-1; Tue, 15 Oct 2024 10:17:40 -0400
X-MC-Unique: m1QVjJdGPue8kFUOuGHlmw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4311407ae76so28462285e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001857; x=1729606657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+2mCvLyMdyKwVjTtmM/ECYzEJ3zejSSBH8w1MErSlc=;
 b=uVZa+8CmvSFZ1voolEkTCVvJz5yHAk6Bw09R5nBMBxD11RFQrkuG9vIcDGNoRUvNK0
 op30duWP14xa83tyui/xd02tF+bSwujHxzb15j4dC/DjsqsUXY3jA4Ez4UYgItInsY3W
 qU04NbE9Reoo621yAygNLZN0YcWwiKkimDoFo+TGXdGBWE5pDqp8fYcg4QA/ijAj0l8I
 BdGyegSQWInUps+aklBEi7wyYHNtO4N2HlhBy3fuwYUPhPPL0BD9/BTnXNa+12buo0eI
 L2rvlmtBWIVdYqcZTnLtn433TuCETepORBTaUIVdv7PDywfjY9I/mNoGqHASoEXG5D8q
 ce5Q==
X-Gm-Message-State: AOJu0Yy6mV0ZVB8/TrXwkIat+3/SMIgDvV+IAHW/X5BWAOQMIgIqDxBN
 QuErMstTmjttpoAMYvniDiRYj2Hw7Eo3oHy/hjRcp0bFqJK92X7D95ikmJrHq7AQ/nT+E441Xy4
 zg8YLJ5zFGz0ZBWzu/NKKUOtHYbOVb58I0y6u3mMjo2kAMCUMrfL/nlvaWb7cZstnd/ibMyDZNN
 16xZoS5p7Tciryt5dC/xZOWC3H44Edzc3xG6k9fqU=
X-Received: by 2002:a05:600c:1994:b0:428:ec2a:8c94 with SMTP id
 5b1f17b1804b1-4314a2b646emr6071825e9.10.1729001857578; 
 Tue, 15 Oct 2024 07:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyMdQSHpl9kFwupoWpAEn43ouGmKfdlaX3oz7uIhj4O7nYBJVO+Ptp+POE3tLQDwWOYYYcgw==
X-Received: by 2002:a05:600c:1994:b0:428:ec2a:8c94 with SMTP id
 5b1f17b1804b1-4314a2b646emr6071655e9.10.1729001857058; 
 Tue, 15 Oct 2024 07:17:37 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87b51sm1700653f8f.34.2024.10.15.07.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PULL 07/25] target/i386: Fix conditional CONFIG_SYNDBG enablement
Date: Tue, 15 Oct 2024 16:16:53 +0200
Message-ID: <20241015141711.528342-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Putting HYPERV_FEAT_SYNDBG entry under "#ifdef CONFIG_SYNDBG" in
'kvm_hyperv_properties' array is wrong: as HYPERV_FEAT_SYNDBG is not
the highest feature number, the result is an empty (zeroed) entry in
the array (and not a skipped entry!). hyperv_feature_supported() is
designed to check that all CPUID bits are set but for a zeroed
feature in 'kvm_hyperv_properties' it returns 'true' so QEMU considers
HYPERV_FEAT_SYNDBG as always supported, regardless of whether KVM host
actually supports it.

To fix the issue, leave HYPERV_FEAT_SYNDBG's definition in
'kvm_hyperv_properties' array, there's nothing wrong in having it defined
even when 'CONFIG_SYNDBG' is not set. Instead, put "hv-syndbg" CPU property
under '#ifdef CONFIG_SYNDBG' to alter the existing behavior when the flag
is silently skipped in !CONFIG_SYNDBG builds.

Leave an 'assert' sentinel in hyperv_feature_supported() making sure there
are no 'holes' or improperly defined features in 'kvm_hyperv_properties'.

Fixes: d8701185f40c ("hw: hyperv: Initial commit for Synthetic Debugging device")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20240917160051.2637594-2-vkuznets@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c     |  2 ++
 target/i386/kvm/kvm.c | 11 +++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9a6b9e9e51b..565aad02ea6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8299,8 +8299,10 @@ static Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
+#ifdef CONFIG_SYNDBG
     DEFINE_PROP_BIT64("hv-syndbg", X86CPU, hyperv_features,
                       HYPERV_FEAT_SYNDBG, 0),
+#endif
     DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
     DEFINE_PROP_BOOL("hv-enforce-cpuid", X86CPU, hyperv_enforce_cpuid, false),
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7c3fcb8698f..1ec4977a8e9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1056,7 +1056,6 @@ static struct {
              .bits = HV_DEPRECATING_AEOI_RECOMMENDED}
         }
     },
-#ifdef CONFIG_SYNDBG
     [HYPERV_FEAT_SYNDBG] = {
         .desc = "Enable synthetic kernel debugger channel (hv-syndbg)",
         .flags = {
@@ -1065,7 +1064,6 @@ static struct {
         },
         .dependencies = BIT(HYPERV_FEAT_SYNIC) | BIT(HYPERV_FEAT_RELAXED)
     },
-#endif
     [HYPERV_FEAT_MSR_BITMAP] = {
         .desc = "enlightened MSR-Bitmap (hv-emsr-bitmap)",
         .flags = {
@@ -1317,6 +1315,13 @@ static bool hyperv_feature_supported(CPUState *cs, int feature)
     uint32_t func, bits;
     int i, reg;
 
+    /*
+     * kvm_hyperv_properties needs to define at least one CPUID flag which
+     * must be used to detect the feature, it's hard to say whether it is
+     * supported or not otherwise.
+     */
+    assert(kvm_hyperv_properties[feature].flags[0].func);
+
     for (i = 0; i < ARRAY_SIZE(kvm_hyperv_properties[feature].flags); i++) {
 
         func = kvm_hyperv_properties[feature].flags[i].func;
@@ -4025,13 +4030,11 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                 kvm_msr_entry_add(cpu, HV_X64_MSR_TSC_EMULATION_STATUS,
                                   env->msr_hv_tsc_emulation_status);
             }
-#ifdef CONFIG_SYNDBG
             if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNDBG) &&
                 has_msr_hv_syndbg_options) {
                 kvm_msr_entry_add(cpu, HV_X64_MSR_SYNDBG_OPTIONS,
                                   hyperv_syndbg_query_options());
             }
-#endif
         }
         if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VAPIC)) {
             kvm_msr_entry_add(cpu, HV_X64_MSR_APIC_ASSIST_PAGE,
-- 
2.46.2



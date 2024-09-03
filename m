Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC446CD3438
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUB3-0002S6-BH; Tue, 03 Sep 2024 10:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slUB1-0002Qv-Bo
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:06:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1slUAb-0007HD-Fi
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725372241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=51dTN7MmTiEpTD17LoLSRBqs9+ZPE1zu8h5Dd7a9Uh4=;
 b=XrRt1eLoU/h8Pdc/e9a+DIqRXjADMi7ldthBBVsgZtT4ebEhSsJG7W3+h7cCAUfH6oN8dA
 Ihkrr4uttW7q7OOedKNBoCBD/2Zbqqd6OF73xfbQ2Odj4PjFPd2QzoXDhwqzH7wOMTtTF8
 rcYB1+RV2A0YL69YKC6Q5Uamv/Ku4hA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-aQIiQYxiPsiQMZNcTfj00w-1; Tue, 03 Sep 2024 09:44:56 -0400
X-MC-Unique: aQIiQYxiPsiQMZNcTfj00w-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-205428e6facso37645545ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 06:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725371095; x=1725975895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=51dTN7MmTiEpTD17LoLSRBqs9+ZPE1zu8h5Dd7a9Uh4=;
 b=Fv71dqTd4fqNTmQHutVEW4myoHhzbPulFmur2Y4RRq1ZXtZoZkxrvrTKQr4kCpvD+W
 RcUuthAdnJpt8l81wagFbo0XfRZG2ge089vvBn4andIPcKXhKOu/iBw2TtPrnYNpqBZn
 YzR8zvpRBG90YX1mXctafGvPHeTkvnmod5msw2xsTEaHVOaX/Obai7PtoB+MBnK7o5iI
 PwgDsH9UmJ0kHU13+l+xJ6BzgmFi3gVw4GsSPFmpUfcFb1SXtbZ3M/UKZ5eKD/ip4ecb
 +avhOf5IBQwzlHLuGPnztFT4GlToUfynjVLxZ4uXf1c1vJoXog2JZz1pGdUg+ZF3pBvv
 qlWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUM7rtHcjdgHtteQo2Vc3qgyPmn55MAU6AYpy4cYs8acsR0oOf6dm+mQDypeJCt2xqBZGfTmM9F79h@nongnu.org
X-Gm-Message-State: AOJu0Yx48svWAtnMApVzBHUgREhDp5m5DQC9Q66AIazHUfU4agTIM183
 gF8LJVrvXuVFjJY9R2t8ttkV34CcO9IxDbBVsdTQUMRsrSlT+B0nTNHaMSbml9ZQbAFju/LybM4
 bJvhPPUrzN0mMKibS8D+RzDQCfPYPK5a3CYhjzu9HkZqETmlTEGfp
X-Received: by 2002:a17:902:dacb:b0:205:5136:b2fb with SMTP id
 d9443c01a7336-205841a4376mr63797755ad.23.1725371095172; 
 Tue, 03 Sep 2024 06:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkgI5zV7G/OfX9mZdLAgTTnOsa1DlSYl0W1zMp7fZyMcYyBFePdiPohhZh6ka7KNNAEWdSZA==
X-Received: by 2002:a17:902:dacb:b0:205:5136:b2fb with SMTP id
 d9443c01a7336-205841a4376mr63797535ad.23.1725371094763; 
 Tue, 03 Sep 2024 06:44:54 -0700 (PDT)
Received: from localhost.localdomain ([115.96.207.26])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2051554407bsm81030575ad.217.2024.09.03.06.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 06:44:54 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, philmd@linaro.org, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2] kvm/i386: make kvm_filter_msr() and related definitions
 private to kvm module
Date: Tue,  3 Sep 2024 19:14:41 +0530
Message-ID: <20240903134441.40549-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

kvm_filer_msr() is only used from i386 kvm module. Make it static so that its
easy for developers to understand that its not used anywhere else.
Same for QEMURDMSRHandler, QEMUWRMSRHandler and KVMMSRHandlers defintions.

CC: philmd@linaro.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c      | 12 +++++++++++-
 target/i386/kvm/kvm_i386.h | 11 -----------
 2 files changed, 11 insertions(+), 12 deletions(-)

changelog:
v2: make QEMURDMSRHandler, QEMUWRMSRHandler and KVMMSRHandlers private
to kvm.c

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 2fa88ef1e3..d714f54ee4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -92,7 +92,17 @@
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
 
+typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
+typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
+typedef struct kvm_msr_handlers {
+    uint32_t msr;
+    QEMURDMSRHandler *rdmsr;
+    QEMUWRMSRHandler *wrmsr;
+} KVMMSRHandlers;
+
 static void kvm_init_msrs(X86CPU *cpu);
+static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+                           QEMUWRMSRHandler *wrmsr);
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -5728,7 +5738,7 @@ static bool kvm_install_msr_filters(KVMState *s)
     return true;
 }
 
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                     QEMUWRMSRHandler *wrmsr)
 {
     int i;
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 34fc60774b..9de9c0d303 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -66,17 +66,6 @@ uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
 void kvm_update_msi_routes_all(void *private, bool global,
                                uint32_t index, uint32_t mask);
 
-typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
-typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
-typedef struct kvm_msr_handlers {
-    uint32_t msr;
-    QEMURDMSRHandler *rdmsr;
-    QEMUWRMSRHandler *wrmsr;
-} KVMMSRHandlers;
-
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
-                    QEMUWRMSRHandler *wrmsr);
-
 #endif /* CONFIG_KVM */
 
 void kvm_pc_setup_irq_routing(bool pci_enabled);
-- 
2.42.0



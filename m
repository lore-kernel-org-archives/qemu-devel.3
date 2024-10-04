Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6719CF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlGv-0007nr-MY; Fri, 04 Oct 2024 12:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGR-0006XO-EW
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGO-0006AR-MP
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4IdWVGMHabiHgz1aIuLkjvE3ZhQKjrK2DgTvqsGpxX0=;
 b=H9MaVGn3VSe7CQUeOqiTMoHNc2bbPHyk6MbgJHR+fmc8+hjkwZAWblD7XXdiYLXhX7QHpb
 cg2Oh+gPwbtnmyop02Voxr9gjqdcj+5OLXAR7akyHBGIrHPgJdV10OyQw3Mzof8lzQwSiN
 SttZNXtotyxRdedTTeSo5Z0Q84Ueadc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-R-9gs2gnOC-TS_8CNF4nvQ-1; Fri, 04 Oct 2024 12:34:41 -0400
X-MC-Unique: R-9gs2gnOC-TS_8CNF4nvQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42cb808e9fcso13979385e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059680; x=1728664480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4IdWVGMHabiHgz1aIuLkjvE3ZhQKjrK2DgTvqsGpxX0=;
 b=qaDIrZ829OrMwz+lh5kxZNNr74draJLnNNuWWoiGVgxpxBSAHvjncxUyHEmJozafgN
 xkU2paGIbvW2On6hRpS6IymvrpDTmVcKtsGOF9Otg89TU6J2oYjiMvBV2BdSogZpRnRs
 LTAf6hY+Oo5oeUQ8vm1fILDHp+klATB8Z9L8pgnaSWfGe0CD1UqglZ2fc+FsIN8qhQNh
 hoDVRno/XpCFHNZu10ViTGYTT0GO7NFgkuKDqcQbblZaUWlCGp0fauyPTHfp5BQfJp+z
 f0/cMg+Lhcw/AzHaOZIJWVrxmggGYP8Aa5cODoceCeCmp2O8R4FeGXkT1MufjPll492W
 GNgw==
X-Gm-Message-State: AOJu0Yz93SeBo/WJnxgZroqkGKAzNVCPcLljhJk9vhUkHkLi1NWsdNlI
 sHvlQLuqjjjZUZrRL2Z2peGW80godREHJ9dgZpLtqAhu0f/jq4Y0jLJ1VkYEQQRUwGU/eKvo0z9
 Z17dSCUnBfovPaupWNshjMBlmzuvwVeejzlj2dSoXDNBc84rLzozfAYEJvhAHACOrpek6DX8VVL
 kJgwzdfOZlBPs5DhAuUvR+4Pl22/k2UbSNXfDmI84=
X-Received: by 2002:a05:600c:3794:b0:42f:8287:c235 with SMTP id
 5b1f17b1804b1-42f89c23242mr4351945e9.1.1728059678201; 
 Fri, 04 Oct 2024 09:34:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPMPM4hkqXKlD5Y1qCfRioogHKieMmhkpcmY9Z9Z4due+MEgsGsu6rfnWvuV9IQDYMVYt6GA==
X-Received: by 2002:a05:600c:3794:b0:42f:8287:c235 with SMTP id
 5b1f17b1804b1-42f89c23242mr4351235e9.1.1728059676357; 
 Fri, 04 Oct 2024 09:34:36 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89e8a568sm1580075e9.20.2024.10.04.09.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:34:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
	philmd@linaro.org
Subject: [PULL 06/23] kvm/i386: make kvm_filter_msr() and related definitions
 private to kvm module
Date: Fri,  4 Oct 2024 18:33:58 +0200
Message-ID: <20241004163415.951106-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
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

From: Ani Sinha <anisinha@redhat.com>

kvm_filer_msr() is only used from i386 kvm module. Make it static so that its
easy for developers to understand that its not used anywhere else.
Same for QEMURDMSRHandler, QEMUWRMSRHandler and KVMMSRHandlers definitions.

CC: philmd@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20240903140045.41167-1-anisinha@redhat.com
[Make struct unnamed. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm_i386.h | 11 -----------
 target/i386/kvm/kvm.c      | 12 +++++++++++-
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 34fc60774b8..9de9c0d3038 100644
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
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 27a3d7626cf..94fdf3cb304 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -92,7 +92,17 @@
  * 255 kvm_msr_entry structs */
 #define MSR_BUF_SIZE 4096
 
+typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
+typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
+typedef struct {
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
@@ -5736,7 +5746,7 @@ static bool kvm_install_msr_filters(KVMState *s)
     return true;
 }
 
-bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
+static bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                     QEMUWRMSRHandler *wrmsr)
 {
     int i;
-- 
2.46.1



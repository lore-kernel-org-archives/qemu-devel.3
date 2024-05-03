Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60464C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 13:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2tI0-000063-UL; Fri, 03 May 2024 09:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2tHy-00005q-I0
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2tHv-00005y-NG
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714744162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=irmtTqct8A65MzBRfGfL65/eckdbEHDoF5RjwLqL9+Y=;
 b=DOxufUfxy6I1fTemPBvdTX1JiEHPE6YO5GQNrutLpufJshIiLj8GacWDOgvgmvqFjPHWEj
 tNz4htUmzYnVKws+EDdQ+aK4prRgUWfB4a2d/e0OhGMkoRIrIz3Okuo/K5PTys5ov/EhTn
 UkT6fjZciunjg2+MmECvxrPc52Rem7o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-A4JmnTQQN_iscBzGuMJ0aQ-1; Fri, 03 May 2024 09:49:21 -0400
X-MC-Unique: A4JmnTQQN_iscBzGuMJ0aQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a55709e5254so427976166b.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 06:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714744159; x=1715348959;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=irmtTqct8A65MzBRfGfL65/eckdbEHDoF5RjwLqL9+Y=;
 b=uVu2+1lsbV0/Cdf3laKMAgydY3onBBxVR74Hs06iU3Ez3yEFOFdRx74/58tRp7sI/M
 dWMvKg+9wosO9jdfD6GmvJ0+bBNt0N2czQDnY3GWaSdjqu/FGT/lNRV/uA6E8jRvBg0l
 9r8y95Kg6rlYGMQEZuWQwgUHqE/eLYgtfn4LKG6TzFWzTv7dSpNqta2lx9x0nRJ3ycfF
 kpEO+k/aMoW9x00dsCczCnYD7fSHn1lnhE1345l2LgIpYEWSQ8FWPfEG5cL3+H6hdLx5
 V+/MCMc9XWIxQLiNSNUxvRYAy0FZomRHtFq1kSIxi4m6QIbtPuAptNxPUT4N9SRtuiYA
 /mww==
X-Gm-Message-State: AOJu0YxM+RtxWU7uxlgF1bK9eJMKI8ZNhmDgj8K/kxRNgjsPNdNK6xKQ
 vzsZm3R7rsvJ3YLtpa1OvY0gTUd/RtWqRUk671fxC+aAG6wwDCVx8a7BxmbDcoWGCOjosYVoKUY
 DSJI/z2MfnIaDI15ypoWe94P5YenbqZh8bj7CD/cgsaytHz4SSb0ozQ0PT6wOMmyUTYvNIsoo8z
 6TcZKTjaLeU58hWLLeEMWeNvcsYj91kPgQOFXL
X-Received: by 2002:a17:906:d10d:b0:a59:9fbd:fc3b with SMTP id
 b13-20020a170906d10d00b00a599fbdfc3bmr71715ejz.39.1714744159732; 
 Fri, 03 May 2024 06:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3+V3modLX6u74KBrk/IXJOO0DHKDosy/L4g3hTYk0gcxiHkaMIcnkx2fPDynvETpTgazXaw==
X-Received: by 2002:a17:906:d10d:b0:a59:9fbd:fc3b with SMTP id
 b13-20020a170906d10d00b00a599fbdfc3bmr71703ejz.39.1714744159308; 
 Fri, 03 May 2024 06:49:19 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 t32-20020a170906c3a000b00a59878704d4sm1031812ejz.72.2024.05.03.06.49.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 06:49:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] kvm: ppc: disable sPAPR code if CONFIG_PSERIES is disabled
Date: Fri,  3 May 2024 15:49:18 +0200
Message-ID: <20240503134918.232633-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

target/ppc/kvm.c calls out to code in hw/ppc/spapr*.c; that code is
not present and fails to link if CONFIG_PSERIES is not enabled.
Adjust kvm.c to depend on CONFIG_PSERIES instead of TARGET_PPC64,
and compile out anything that requires cap_papr, because only
the pseries machine will call kvmppc_set_papr().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/kvm.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 63930d4a77d..46fccff7865 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -49,6 +49,8 @@
 #include "elf.h"
 #include "sysemu/kvm_int.h"
 
+#include CONFIG_DEVICES
+
 #define PROC_DEVTREE_CPU      "/proc/device-tree/cpus/"
 
 #define DEBUG_RETURN_GUEST 0
@@ -71,7 +73,6 @@ static int cap_hior;
 static int cap_one_reg;
 static int cap_epr;
 static int cap_ppc_watchdog;
-static int cap_papr;
 static int cap_htab_fd;
 static int cap_fixup_hcalls;
 static int cap_htm;             /* Hardware transactional memory support */
@@ -90,6 +91,12 @@ static int cap_fwnmi;
 static int cap_rpt_invalidate;
 static int cap_ail_mode_3;
 
+#ifdef CONFIG_PSERIES
+static int cap_papr;
+#else
+#define cap_papr (0)
+#endif
+
 static uint32_t debug_inst_opcode;
 
 /*
@@ -1668,7 +1675,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         trace_kvm_handle_halt();
         ret = kvmppc_handle_halt(cpu);
         break;
-#if defined(TARGET_PPC64)
+#if defined(CONFIG_PSERIES)
     case KVM_EXIT_PAPR_HCALL:
         trace_kvm_handle_papr_hcall(run->papr_hcall.nr);
         run->papr_hcall.ret = spapr_hypercall(cpu,
@@ -1698,7 +1705,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = 0;
         break;
 
-#if defined(TARGET_PPC64)
+#if defined(CONFIG_PSERIES)
     case KVM_EXIT_NMI:
         trace_kvm_handle_nmi_exception();
         ret = kvm_handle_nmi(cpu, run);
@@ -2054,6 +2061,7 @@ void kvmppc_enable_h_rpt_invalidate(void)
     kvmppc_enable_hcall(kvm_state, H_RPT_INVALIDATE);
 }
 
+#ifdef CONFIG_PSERIES
 void kvmppc_set_papr(PowerPCCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -2075,6 +2083,7 @@ void kvmppc_set_papr(PowerPCCPU *cpu)
      */
     cap_papr = 1;
 }
+#endif
 
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr)
 {
@@ -2837,7 +2846,7 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     return data & 0xffff;
 }
 
-#if defined(TARGET_PPC64)
+#if defined(CONFIG_PSERIES)
 int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
 {
     uint16_t flags = run->flags & KVM_RUN_PPC_NMI_DISP_MASK;
-- 
2.44.0



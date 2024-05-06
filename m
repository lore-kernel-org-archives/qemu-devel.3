Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237DBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t99-0005wJ-9e; Mon, 06 May 2024 03:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8c-0005jL-KH
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t8Y-0001XT-Nl
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=irmtTqct8A65MzBRfGfL65/eckdbEHDoF5RjwLqL9+Y=;
 b=XAk+aLvx5C4WSDeQK7j9W9AJngGSDTrCp1+NXWZcwVelOGFRcZJChhKUvKMWPmXzAUDMWr
 tibwevePaq9qMkX1TwnvJ1XbgqQdmx+64syANHpG2aaUn1YADVKvSVa9XbzkgLFiwyTXoz
 B3wdCEet3Z0sooDvIaBugsDVg03wobE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-49zWmaTQNh2OrRntU9dcZQ-1; Mon, 06 May 2024 03:51:42 -0400
X-MC-Unique: 49zWmaTQNh2OrRntU9dcZQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56e645a8762so1133198a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981901; x=1715586701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=irmtTqct8A65MzBRfGfL65/eckdbEHDoF5RjwLqL9+Y=;
 b=Sz/IC8Il3ZHhX+38MLQzuc/ZixS43Yp28J7Qtqv2l1AysG8SK6oQ/VEQ9cHT/bSK4C
 eIvIOehxA69PtYsaAGS8BLxkv76lsGbYN1S2cU1GeHLY+2dT+Be6kDLJLx0Od72J0g0l
 nc7xrIHP4wNAK77vve2Tyg5BMFYJ8hu1smQvQq5Rs2np5NVi3PSXgoxamb9VLsCloFnz
 MK6Xr/KR08RFuY2PhOJBkYJ/9XXosEhVCHAk339yCZk8AH5yTiEXTNPVYv3nyQhdu5Cq
 DYgMawatASuJHB73sRSr0g4c8xwkrbakyxmUt0whMx+NZgan6Tw0Xx8VPfPEwQl5htQT
 3b6A==
X-Gm-Message-State: AOJu0Yy5BB2B88626yjf/b7LbvMlFabKdCnsoEw/fFdtI/oWGB5D+vCv
 dD7t7lz4a8p1QAa3azz3VSgPH0YK3QGpB9xiqRaIaIyBAw5tTEMCMgnqyVx3M+UdDfoAFyDHPSi
 BYbHGOIk37W2ennw1NZodZIivRuZcg/A6m827KGUnl513Vds4FojpfEYFa91bRgCn+KTWTZsgKy
 jllWiMz0bFHE6W16xAi02qJTgcc0IFD8NYBorG
X-Received: by 2002:a50:c30e:0:b0:56e:34e0:4699 with SMTP id
 a14-20020a50c30e000000b0056e34e04699mr6082475edb.30.1714981900843; 
 Mon, 06 May 2024 00:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLTRoTBQLzuLNGHU08YJmbHYP1FJ1way6/iCEXZeCL8ZvYDH/kcyUTirM+pnjNcre8OVAWwQ==
X-Received: by 2002:a50:c30e:0:b0:56e:34e0:4699 with SMTP id
 a14-20020a50c30e000000b0056e34e04699mr6082458edb.30.1714981900502; 
 Mon, 06 May 2024 00:51:40 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a056402414200b00572cf08369asm4090322eda.23.2024.05.06.00.51.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:51:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/46] kvm: ppc: disable sPAPR code if CONFIG_PSERIES is
 disabled
Date: Mon,  6 May 2024 09:50:44 +0200
Message-ID: <20240506075125.8238-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



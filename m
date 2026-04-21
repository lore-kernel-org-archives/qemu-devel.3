Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F20EF8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDzE-0000Mq-6i; Tue, 21 Apr 2026 12:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFDz4-00005P-3i
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:30:01 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFDyw-0005jR-50
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:29:55 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso3204140a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776788982; x=1777393782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++ZGjXwMqfSingAg7xdviV4c5zJjqE5XGviD8tj3+/Q=;
 b=PkFTKG8xDuDmPDC9/CB01/h7Deu793FTb+rcmCbAj1r87Q6LjnTWjUAcOx45KA/d6P
 /JFxdmgec9TLPchquSLFD6jSfAg09rvpOxPUGjQgvxLQKSO8JbmNwltrr9GVfGBdyaAX
 4Jvi6o/8oeapX8PGVeVoHRExSG6c+CzNqOdWgMRgX7jdAj+bH3FYWrE8fy5Vmaz5jgCR
 9HMOiEBVhsnyWbB7A0kT2xlcgxkjmqQ1j7jXLA2eZmLJq4U5dPTRVeUCb8EVhI3UHP1f
 WP5k3yoWnM7WlPc/PCHQLaWdSl0Z1YKak23mPSPkK2KWo166oQBHl8uudSibBsW/DBQd
 mUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776788982; x=1777393782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=++ZGjXwMqfSingAg7xdviV4c5zJjqE5XGviD8tj3+/Q=;
 b=lhKJsfO4YhT4b2QXflGfAkOkxjgU5pBMY6o6uYCk/7ylMz0VT2nqacCdvywjNNXkxZ
 h7slJOh+obPs9IJNl8VcaXVT1R2WwcnGwJrU+BEddr6UUqIHwY9eFm1He7mA8eKuoiK9
 rx2epKUosiZFBCojQiXeQoyYGeqBykd2p/WgGV2dX/DmIHFzMjiwCAuWs0G1lOZgkPZQ
 DCero46IgEtbfJgCWNr/V2ylqCx3eZrvpbAswK7+ciPMVn8/e2vjNti/IqvamEyCbY6E
 ULT725539WIGEYwsszoiqwL6lp89KuWqipiEVeexLf7II0ngtyjebClG/rbZM+oCAZSP
 eGJw==
X-Gm-Message-State: AOJu0YwJyV3rctfX3k4PMnKiGqSYA1aS5lwzUoemqah52SZflgQVNt4a
 IWAgTTh5emW6oo8nbrTNoLyY/EPXlC9ysRZ5hg5MS14J3cywqdfi0Xv/b7cGnCbPrsrQuU51WUn
 5Tmx4nJ5UkAOK1L3sXPT6Ob8zDp2y5pGyL4/fypS+tYz/zfWiL2Wq+sda2aYCnFpZpQC341wwOq
 KtRJafaOrSbYr0zQpXBLP/achDmPiMcz+CxUoLgFF8
X-Gm-Gg: AeBDieuaTNQ55stklJvaHRMdfM538xjJZnscTVhvjP1cMzva9IV4zKZgOuhjIADrmHA
 0zmU4q6QqM4COh4QuR9f9zxYuRBbWfcbImGXeRCp/xT4ZV+qt1uODIsvRydFlWIw93+HB/rt2R/
 vymeNCGyTG8lPSpvJB4xc1ySOv8Jrr0BJVAc5d8KnwBRGWNHyFMZhSqXn0/Rizj3glZ1W37NcwV
 LF1d0LvBdtsO+TrSgxxY2SINaC4XwFtZeLnS41g3jHpJQ4UUa8ETrClqTJ/2lNlR2/hql1NGPAy
 JPWPpTyPAIjK6lqzoHG3nJAX+J5MtxK9qJ4fXNN+7sKOnNqhSYs1Tmdhin6LgffsHCBcRMqrsYQ
 aq5Z3Ofv0loGxNZQnmtdYii5Kt2/JgCIyxR+bzFZzM0Nzb94oKs2mCSzLDuoLB1Mst54oQCN3o9
 gSD3r7c2NbPky6Cl/E8ujnD2TPev9NtFv6IKXy9SRSh4Wrqm7vMTPpToQ=
X-Received: by 2002:a17:90b:3f8f:b0:35c:30a8:341 with SMTP id
 98e67ed59e1d1-3614046cd3amr19271795a91.13.1776788982053; 
 Tue, 21 Apr 2026 09:29:42 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140ff2e1esm13529470a91.8.2026.04.21.09.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:29:41 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 3/5] accel/tcg: Provide early AS translate function
Date: Wed, 22 Apr 2026 00:29:10 +0800
Message-ID: <20260421162912.3295598-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421162912.3295598-1-jim.shu@sifive.com>
References: <20260421162912.3295598-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

New early AS translate function will skip IOMMU translation. It will
return IOMMU region if finding it. Original function is renamed to the
late translate function.

It is preparation commit of IOMMU lazy translation.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 accel/tcg/cputlb.c        |  6 ++---
 include/accel/tcg/iommu.h | 13 +++++++----
 system/physmem.c          | 46 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 4ca4152579b..f0c049e1551 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1049,9 +1049,9 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
     prot = full->prot;
     asidx = cpu_asidx_from_attrs(cpu, full->attrs);
-    section = address_space_translate_for_iotlb(cpu, asidx, paddr_page,
-                                                &xlat, &sz, full->attrs, &prot,
-                                                access_type);
+    section = address_space_translate_for_iotlb_late(cpu, asidx, paddr_page,
+                                                     &xlat, &sz, full->attrs,
+                                                     &prot);
     assert(sz >= TARGET_PAGE_SIZE);
 
     tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
index 30655aab4ba..11e3d63d798 100644
--- a/include/accel/tcg/iommu.h
+++ b/include/accel/tcg/iommu.h
@@ -15,10 +15,15 @@
 #include "exec/memattrs.h"
 
 MemoryRegionSection *
-address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
-                                  hwaddr *xlat, hwaddr *plen,
-                                  MemTxAttrs attrs, int *prot,
-                                  MMUAccessType access_type);
+address_space_translate_for_iotlb_early(CPUState *cpu, int asidx, hwaddr addr,
+                                        hwaddr *xlat, hwaddr *plen,
+                                        MemTxAttrs attrs, int *prot);
+
+MemoryRegionSection *
+address_space_translate_for_iotlb_late(CPUState *cpu, int asidx, hwaddr addr,
+                                       hwaddr *xlat, hwaddr *plen,
+                                       MemTxAttrs attrs, int *prot,
+                                       MMUAccessType access_type);
 
 #endif
 
diff --git a/system/physmem.c b/system/physmem.c
index d3d111392c1..72c564b94a5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -682,11 +682,11 @@ void tcg_iommu_init_notifier_list(CPUState *cpu)
 }
 
 /* Called from RCU critical section */
-MemoryRegionSection *
+static MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
                                   hwaddr *xlat, hwaddr *plen,
                                   MemTxAttrs attrs, int *prot,
-                                  MMUAccessType access_type)
+                                  MMUAccessType access_type, bool early_trans)
 {
     MemoryRegionSection *section;
     IOMMUMemoryRegion *iommu_mr;
@@ -710,6 +710,11 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
         iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
         tcg_register_iommu_notifier(cpu, iommu_mr, iommu_idx);
 
+        /* Defer the iommu translation */
+        if (early_trans) {
+            break;
+        }
+
         if (access_type == MMU_DATA_STORE) {
             iommu_flags = IOMMU_WO;
         } else {
@@ -737,7 +742,8 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
         d = flatview_to_dispatch(address_space_to_flatview(iotlb.target_as));
     }
 
-    assert(!memory_region_is_iommu(section->mr));
+    /* For late translation, IOMMU region translation should be finished */
+    assert(early_trans || !memory_region_is_iommu(section->mr));
     *xlat = addr;
     return section;
 
@@ -755,6 +761,40 @@ translate_fail:
     return &d->map.sections[PHYS_SECTION_UNASSIGNED];
 }
 
+/*
+ * address_space_translate_for_iotlb_early: translate address without
+ * performing IOMMU translation. This is used for CPU TLB setup.
+ *
+ * Called from RCU critical section.
+ */
+MemoryRegionSection *
+address_space_translate_for_iotlb_early(CPUState *cpu, int asidx,
+                                        hwaddr orig_addr,
+                                        hwaddr *xlat, hwaddr *plen,
+                                        MemTxAttrs attrs, int *prot)
+{
+    /* access_type doesn't matter for early translation */
+    return address_space_translate_for_iotlb(cpu, asidx, orig_addr, xlat, plen,
+                                             attrs, prot, MMU_DATA_LOAD, true);
+}
+
+/*
+ * address_space_translate_for_iotlb_late: translate address with
+ * performing IOMMU translation. This is used for lazy IOMMU translation.
+ *
+ * Called from RCU critical section.
+ */
+MemoryRegionSection *
+address_space_translate_for_iotlb_late(CPUState *cpu, int asidx,
+                                       hwaddr orig_addr,
+                                       hwaddr *xlat, hwaddr *plen,
+                                       MemTxAttrs attrs, int *prot,
+                                       MMUAccessType access_type)
+{
+    return address_space_translate_for_iotlb(cpu, asidx, orig_addr, xlat, plen,
+                                             attrs, prot, access_type, false);
+}
+
 #endif /* CONFIG_TCG */
 
 void cpu_address_space_init(CPUState *cpu, int asidx,
-- 
2.43.0



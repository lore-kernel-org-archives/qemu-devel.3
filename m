Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EDECD342F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKT4e-0001tP-RF; Tue, 05 May 2026 23:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4a-0001r4-Dl
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4X-0006SC-Dt
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b24fcc2b5dso34836285ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 20:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778038635; x=1778643435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79rPXiP3/6QDU0TrDtJD4kbRuSJaUuXqGAi28uS9FeI=;
 b=LcS/rs5FCbATr1nXxCOl+UhzIpPbQw0gn7W0h1uyIzR1fgUiEcsvJtccOh/iqKFHa0
 xr3alo7q7ne9dAxGO347YmR98xrenPgwfUt1SOYSCzqpHEnw3J0X4O/yr6tS07pf/D4k
 KO+sIXPIDdiYq74dNrb4cgEf7+OYy/M8+TS6DoMQ15VvZhZwxgXMv6FK8LLjJmSnQJQZ
 xGV/eAuw4htOq1+SVxMO17gxJe4sbGqM/NIWqB5p9Vq+rf1h90ENvEEvnKVLBCrtW6m/
 /BSGx9G6SH2BvsSW4fRYt7kQYIiliKzDP6unT/q0WjGQvJYCj0TzojUcVT02utoA46Sj
 tqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778038635; x=1778643435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=79rPXiP3/6QDU0TrDtJD4kbRuSJaUuXqGAi28uS9FeI=;
 b=XMIPJSe3PVmUE5BYl7Qoo326oN0HFsVOGRf3dFFs4y8FJ3gK70jtip+1PaiL17aGW8
 1cpR1bMiOp/CeUBvKFpErPWSqffjrGc7nmoU2RVJ6y6/OTYePALsR3fGTAxvDrAaH0rI
 dGqmylNIsF0nqEaxNxdbgHeldk62oJQBNMGLmhUx0z+PFWQ+dsRcG2+v2by2N/E7k/ln
 jeRMfI78SdZSFdnhglkjahPrhf8sHRre7tCS++KiuWdhLV+5lNr9iFwF9T/Cjqu8VPjR
 AxXeUhtxurs2+rGbSJ/AHsMfxcIni27tK9oIlTwImavjPqWKYiLc3BGH0WG64W3d90lk
 XD3w==
X-Gm-Message-State: AOJu0YwW1XQdnS0rMwT/VJolkMo+9h316qcctTcFVjAQkUAKkzUSAuSF
 3SQ8TBpDQVFCWGDwKoiHtvNUvJT8kUQ13M1mFFNzn1PT32LxUPT++qoa66A941hTtG7e8yGmniq
 xLjQ+jW4Ub6KCvaqhhcKpgUuwjMZTVmIIdxNBpXbDXTrDVNG5K1tfCd6bDzMEre7jtG8Hl5ck7b
 w1fH3g+mFyUkfo2fnXOHjcIEN/BaVOA/NZ8JCfuzDD
X-Gm-Gg: AeBDies/gIIsdsEDpMYz/WIZIsgaXWnxDnDmnQJleQRh0dBv4H0eTeu9RdCCtm1OjVh
 /g3Aff6Oq4Ln8lEaZJ6f5HM3FZV+ptAnJf9tv9Xc6PiEHS+6p3BEO7ljSfllfICBy0iP4MDfci8
 nT/xzKKVyoV14t0wzSaFT4Xf7dvc/dPx1LyQnCs7dih6MKwFAooXP1WDoFFhNi3qxY5YUtPxZc9
 kWXgbOpHZslbbcI8UpHuj5uyHMhOFICzd8hB6BJuE+CUsvdrq69kIZhNwfZOeheOA4wolShrupt
 bErCrMJ2sOVHvqSTd1UNISudkxyoORWM8YR/qWi3L0AEMMlhNXFXIYn60xXiAxLwRi+7pZJDnEJ
 FC5WweBAFympVo10Qx3JjiUJKYng1ZA4MSH/Bvclk9QZmedlN1HrJjNcMRofQuQ2vayhWwU1s9Q
 4a/HBW5HqSIZ1Gmkd0Y0PwQh3wpN0FBJfRhkmdZStgF84rsKJEatCrGtE=
X-Received: by 2002:a17:903:17cb:b0:2b9:59ea:7eba with SMTP id
 d9443c01a7336-2ba78f54626mr14967615ad.13.1778038635050; 
 Tue, 05 May 2026 20:37:15 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca34cfdsm7666265ad.79.2026.05.05.20.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 20:37:14 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Song Gao <gaosong@loongson.cn>,
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
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 3/5] accel/tcg: Provide early AS translate function
Date: Wed,  6 May 2026 11:36:40 +0800
Message-ID: <20260506033642.3641390-4-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506033642.3641390-1-jim.shu@sifive.com>
References: <20260506033642.3641390-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x629.google.com
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
Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
index 564d2c6a648..6e2d43e850f 100644
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



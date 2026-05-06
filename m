Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB98CD3427
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 03:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKT4b-0001rA-7U; Tue, 05 May 2026 23:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4S-0001mx-Os
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wKT4Q-0006Pw-K6
 for qemu-devel@nongnu.org; Tue, 05 May 2026 23:37:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ba4efedbeaso11844795ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 20:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1778038628; x=1778643428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haLdbYReulSG787oT0TvQmadTM0DjT1GmGXLzNAI/Ws=;
 b=JsXINOtiDULLuHstH1jV76UVGVOoOOtqvkTKHQGxd7xOnbJUe77K28OMA65HX7BpiC
 fzezY30gSFk8EHy36qp9HU/vAjdyfkT5ju8r55gOOTicnTVJ9pgW5WHMgcHEoiCIoAEU
 YVz8yZDpJoQQWxAs9MBtoZsGVe8baonMBfK5gYc7dJ8qQAGjSIYaErvsDVMhLUNNjRkP
 EUTKS3vPYCFux2eFo7JEHz23e0AHHooS+ilLYb20gNJPjaoZ4J2lcM+zJppkr9db0tyR
 f3/YTSuyQuY2afBTwHU3s6N4FnulhLawnFJn4gpmyfylul0Pn0CoIYLggPhZ1ZISs7wr
 /xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778038628; x=1778643428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=haLdbYReulSG787oT0TvQmadTM0DjT1GmGXLzNAI/Ws=;
 b=VLQXFSQCcFJwCavzPMphV1K5+XvR8H9TACT6h0tVJIs6nz1PaHdqRviR5Dr/y2juq2
 GoI1aJ43K6jiWtUlWqlhvS2LRR1ZYnjJM9SJNkNRKPYc3LTSApk8x/BCYtksDfWg6cDU
 3APQzZDWVNGJIbnTv9FKUpiqBpBkwzguGM7V1ljsH0/XSK3QeaO2XIzuhSosx0fRPIZC
 JbjkjjPXJq/8pCZEO5iNQ/8GMvBwF03FvvE5sa2IA+jCr0VyFFwsVrmMyhTaNQzh/+cC
 95l2xeCHi+jBrZ2VbEuiM5zv1PAZFlL1iUDWCi/XW1wfEjM3FS3QpQuwqI0W/6DV6SUU
 SbDQ==
X-Gm-Message-State: AOJu0YzGqWCa8RVlilGSnAHJLvO8NvJsc4VdMHHtBMoe78yMO0uRCpwY
 ZB4cytWiUFs87hUeASX4qwlemyNGH0r+BHhwWlGqtHJs7iVo5OCZ6GqxWfykJxcegXTTRqkPhkL
 x6gpd+OBOLGT8fctcTKcNhKZDmJOhi3CVWcl21UKBofKuAaEiy+Evw5pYUZCZoemp/0Hw1DidRB
 bOtsb/wVPYWeuPalr4wJHgPNB6lYiy7xpEUyj5+MNu
X-Gm-Gg: AeBDievXOTeKs4AffJF8BcYFgXs1/M4mMYKl/PCfRAv3ow4xZqtHCKWsjSjw9MtPXg8
 HaX6flEtVpaMIQpmM9TmqNqCH5tz23eJnHAgalotI9dLianlCM3hZrJDt824ln5ZW32IvvJb12q
 YlpRy1Ho9mV6b8TuXlV9/l4OW5ZT/vxnR/s13Iw0Sh0v5xUIAMJzPlbsj5OzxLTP6vqNN69vhI9
 Z3/3T3c0gqEGnP+oyj0cwZL6m05Lsxe35ooxkh37Rse8Pn/pcsEYJJj75M+MvEpEu57/Atmipm7
 viqzgjI0LTgdbhkA63f4y7acdGjlpFuv7KFk/sNjGiSjJ/uCaF63wTKy4t9sKDTJBEfKkRF4L1X
 eLN0XD9e6NetEGPQy1yrHhSQHF8uLw9mQ1jkKL8ZWHvUqzF+xDT8hXKiVKFMVvQ57Xd2weVRm7p
 4/K7mBTS5pgI0Hpbo+pj+GU6CLGfFIl0KyKm/+LsmhVsvVMWw9HUxsxWcAfdDvzJJlyA==
X-Received: by 2002:a17:902:e54e:b0:2ba:4e84:966 with SMTP id
 d9443c01a7336-2ba7a358d4amr17259845ad.36.1778038628094; 
 Tue, 05 May 2026 20:37:08 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca34cfdsm7666265ad.79.2026.05.05.20.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 20:37:07 -0700 (PDT)
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
Subject: [PATCH v3 2/5] accel/tcg: address_space_translate*() will pass the
 correct iommu_flags
Date: Wed,  6 May 2026 11:36:39 +0800
Message-ID: <20260506033642.3641390-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506033642.3641390-1-jim.shu@sifive.com>
References: <20260506033642.3641390-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x630.google.com
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

Instead of IOMMU_NONE, address_space_translate_for_iotlb() now can pass
the correct iommu_flags to the IOMMU translate function from the
access_type.

Since RISC-V wgChecker [1] could permit access in RO or WO permission
only, the IOMMUMemoryRegion could return different section for
read and write access. To support this kind of IOMMUMemoryRegion
in the path of CPU access, we should pass correct iommu_flags here.

[1] RISC-V WG:
https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/tcg/cputlb.c        |  3 ++-
 include/accel/tcg/iommu.h | 12 +++++-------
 system/physmem.c          | 16 +++++++++++-----
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3bc951603dc..4ca4152579b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1050,7 +1050,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     prot = full->prot;
     asidx = cpu_asidx_from_attrs(cpu, full->attrs);
     section = address_space_translate_for_iotlb(cpu, asidx, paddr_page,
-                                                &xlat, &sz, full->attrs, &prot);
+                                                &xlat, &sz, full->attrs, &prot,
+                                                access_type);
     assert(sz >= TARGET_PAGE_SIZE);
 
     tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
index 547f8ea0ef0..30655aab4ba 100644
--- a/include/accel/tcg/iommu.h
+++ b/include/accel/tcg/iommu.h
@@ -14,13 +14,11 @@
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
 
-MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
-                                                       int asidx,
-                                                       hwaddr addr,
-                                                       hwaddr *xlat,
-                                                       hwaddr *plen,
-                                                       MemTxAttrs attrs,
-                                                       int *prot);
+MemoryRegionSection *
+address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
+                                  hwaddr *xlat, hwaddr *plen,
+                                  MemTxAttrs attrs, int *prot,
+                                  MMUAccessType access_type);
 
 #endif
 
diff --git a/system/physmem.c b/system/physmem.c
index c58d940e807..564d2c6a648 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -685,12 +685,14 @@ void tcg_iommu_init_notifier_list(CPUState *cpu)
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
                                   hwaddr *xlat, hwaddr *plen,
-                                  MemTxAttrs attrs, int *prot)
+                                  MemTxAttrs attrs, int *prot,
+                                  MMUAccessType access_type)
 {
     MemoryRegionSection *section;
     IOMMUMemoryRegion *iommu_mr;
     IOMMUMemoryRegionClass *imrc;
     IOMMUTLBEntry iotlb;
+    IOMMUAccessFlags iommu_flags;
     int iommu_idx;
     hwaddr addr = orig_addr;
     AddressSpaceDispatch *d = address_space_to_dispatch(cpu->cpu_ases[asidx].as);
@@ -707,10 +709,14 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
 
         iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
         tcg_register_iommu_notifier(cpu, iommu_mr, iommu_idx);
-        /* We need all the permissions, so pass IOMMU_NONE so the IOMMU
-         * doesn't short-cut its translation table walk.
-         */
-        iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE, iommu_idx);
+
+        if (access_type == MMU_DATA_STORE) {
+            iommu_flags = IOMMU_WO;
+        } else {
+            iommu_flags = IOMMU_RO;
+        }
+
+        iotlb = imrc->translate(iommu_mr, addr, iommu_flags, iommu_idx);
         addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
                 | (addr & iotlb.addr_mask));
         /* Update the caller's prot bits to remove permissions the IOMMU
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06635F8FA9B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDzC-0000Fo-M8; Tue, 21 Apr 2026 12:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFDyv-0008Vm-UN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:29:55 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wFDyk-0005ig-Pi
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:29:43 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35fc258aaa4so2857781a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776788976; x=1777393776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hp611hD/fc7KenUYYrcLNqv5irQqbGpyxYBnGHFQNeU=;
 b=IbfLGVPnELUUEgrvbuxaicS0JS1dE/lOi0wY9IWU8/laiI/qHkQ5MzEcEd1fJfc27J
 NzMp4kj8mpdNTNGcZZiplgWxxXJxmWO22jJ+wxfUXwI+a4H4CSFnMWqDfl1EbPZEzyaI
 Tq7UiIHI6OVRHmzlXZ5I2vlh9OAkAtvBWVOxFVXDKgWjC8WHAjfa6qHAYBvJpHsK2HL6
 iHSsPqlyUBzSsAy/3NujVJDq/Iv3TcluqQlpg9mzSE9TctK6wUs3bODWkJFxaIGRo1zx
 mvjXoRFY6RthIFei3D7mX08+YPvYKexWJsM5LTvegw13fnpcunY9AjBmYMPdzW+/MK4o
 eRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776788976; x=1777393776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hp611hD/fc7KenUYYrcLNqv5irQqbGpyxYBnGHFQNeU=;
 b=INGJCKYZ2X+5ntF+P4YOJ1oMDdqM8KVz2tXd1ALcIAKLecawWT3fU6thL0fy7aKVWR
 SkHtjOc812/Ey+/qaGdvmVp54BvKmB+hCfOvFwHs0A5sKvcRIXGkN5xD5hMYvbxKcuOl
 PhrOEH8qLbPG9Wi6GEju1BMbmrKW8f/nNB2XhSvlvhsPLa8MRJbQZGKa6XAbz91rSjSZ
 tNzA70QpVXlE+Lp5isTVehQwXSXCuBz0ErXK7J1O3wAJgdOsq9sxUMWif+ue1rtGhMzd
 awuFKX/DeHlZAuheFjpf5cGJ0heW6631wLxBEeyP0HgFfqJ4zK+zJInrc+Xj3mlXLJnq
 ofPg==
X-Gm-Message-State: AOJu0YyLXrFMQG3KCU3OfGq+gpLHAfM8KS0Tch4Ppbi0ZH5ZkTH3Vy6s
 JlOC2ZpMrtW0OnwG4WBOpLQKcYwv+Uzu36A2UMAtUxsSqz0AUP0HlWh7duxZsAbyXMx37DrEss8
 AUcTQwGa9LazpYlxJRU6Szsj8+U79EBQ3mH2YMVqJGzYi+fZHYX5rrseOrz/biPEO8SN6p1gGsy
 l6ABXGmLYJYLU7tvvfhB7titpMpE40f2P1IxAw8Dqw
X-Gm-Gg: AeBDieu9JMlPyBMXAnfMoNdwOaZvaloUA+8bftRwjRL/0C6RVJEx9Y4oGN5e3QY3BLT
 AP/kK7mkT0YUN+fvdg76MtE2Dh9xlsWNenK79sSRFKPtO5ZLedzc1yrYrfFeJienu6nxafbMvq5
 ITZ8W112XoMPfrIHA0oqXUkL9k/bhcQBxa6PHHWjciBizZi2VKjfSOLeqNmnEDnKDfr6OPCrsV/
 e1O8YOzlnWUQlFkIHZSCwUGi55x601emgxTPxJqpF9xqe8ElBf+TxQi4rtUYIfjdzO5OuyElrdu
 ks+TQWmustGcaUYGQTd49DdPgmmT2zmJv5qRLKRz2PnojIfx2ZNJcd7Q5tySPxGJcbu/Gwnzt6q
 8TFO1S5ASUz+X/B4wKlHs690homHNRZwaz0qVzhTkO4c8SA9O11EcNXBN7iIPzTW5flzLiP2V+9
 d4V0+J92TnzSS98DqZ8s/YozsTC/ondtCAbCF0BM2qzPxMxZ7bdPIoSbI=
X-Received: by 2002:a17:90b:55cc:b0:35e:30bc:804d with SMTP id
 98e67ed59e1d1-3614048adcdmr18348774a91.15.1776788975797; 
 Tue, 21 Apr 2026 09:29:35 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140ff2e1esm13529470a91.8.2026.04.21.09.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 09:29:35 -0700 (PDT)
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
Subject: [PATCH v2 2/5] accel/tcg: address_space_translate*() will pass the
 correct iommu_flags
Date: Wed, 22 Apr 2026 00:29:09 +0800
Message-ID: <20260421162912.3295598-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421162912.3295598-1-jim.shu@sifive.com>
References: <20260421162912.3295598-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x102c.google.com
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
index 4e26f1a1d42..d3d111392c1 100644
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BEFE73141
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 07:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmolp-0008MT-Ui; Mon, 02 Feb 2026 02:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vmolO-0007fS-RT
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:54:29 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vmolI-0001io-MR
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 02:54:25 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-81f4e36512aso3891943b3a.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 23:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770018859; x=1770623659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggP3+AmhC/yKoErBtMmPsYF4F4YOJYoGtVxGzzrme9A=;
 b=YVdno/NIex7ltCbtzmQ8myopK6bp7GlNGCYq5n9o47zs7bS0U66utzvK66Jbgwh9ko
 sSH7UX8krbynRZhg7wSPzEYFj4PSdDTTfM0YEyjPCCMhhCuMHOXl7+z/TufuBf+XcAek
 8bcfN287Il4EuZ3OAT0EcFIpXufGHzaqeOJ57sVZEgzXgY5DV9Un9dTZ6GPHD3oiPe9j
 GWPZ4Z2hskJTwDQTxYShfM3VwmnoLDMiNgVDw/RRUkvAYK+Vu1fm1S39HUHsYAPM/mQf
 Pt0x5XEK5WFWA0Wc4HD1rqfTque5CQQvyTUmgj9cdSw2Xlwr+ter/1HBFK92pU2eF9a3
 MNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770018859; x=1770623659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ggP3+AmhC/yKoErBtMmPsYF4F4YOJYoGtVxGzzrme9A=;
 b=hlMxs3kUg6rr9PsLt15i786c3tqcnIng7h/inBbxaBZ1nJBODUxe6QHB4frLBq+yow
 7m5RrZS6FLtYVrlXecgSeH7qk4JOM3oNWjBHxx8xHBPGnIyLxjC3cgQWtfWI/R1x/YhB
 4eF9FPMqCRQSxDGA2eUadwdI3SMv6Nx6/Do/7u8gcnPRaVq9HLavz0pKI45UCO+IXRpb
 T2jd2yZl3GHlL11MyzIQ6XavmT556BE7fEDTwH0LiNQVztVw19gJ/IIzVIGv8uTwhXuU
 dmF76hyA2lYJPCZ6qZer6Kpb0UYBTwK6RlSyMLt/ZHw/IgqYa7RbEUOLD9NVylPaFqNp
 ttiA==
X-Gm-Message-State: AOJu0YxvZsf8B4uGcwdredJTw/4uiZiD/LRNFvaZCP1mVOeO4WZIU3lI
 zg6Y4VEeevRo1qSNURabPvqZ+InCJ8W9IbKu6M0YwpX3E43LPWS4KTlx5cYqx4zZrnoe0/3qoBf
 jT2IjSrOvWSAOaCBIRFt+zvLTVSVUL0pyJKaHTFTrY+/E2XifhYmjqDPR5FCqtTZ2MsQqVKUpOo
 y8Bgrkls40uTF7JUsTqHt4dgwy7aXiKeZGQxza7uMG
X-Gm-Gg: AZuq6aIDWP5JRRNb+Cfvhz7XjtXl119DNMd0LEWiJQ09DKVLI5ls9giI2b8w8HhNjC2
 Jj+aOEqrFw10MPuAGWKGp4ec21uxtXb6eLsktmWbLRlhFIJ6C8Vxk+XgZPkjzvNKAOUEa7YqgW6
 JgiYSL9YlrPX5VOzS34i51TITtxkr0rbO4pTprZ5I8MVrIlTU2umhNWYRwhyLZVKjWrGdKwrPSl
 dAh4iUmmrsqDrg+feGYHYlKNq/jpguMBtjjdGgacZA8oWdfMzW2lRGG8NplQj7buAkurTdoGG8p
 v9Vo8360icY0O7chRRyXI3zoSVTydiINXtCq3ddT7O9owfNThMGgUJSQLD3mwzj9y92ruBvndTt
 6Vw0eZxu10Fq7Y413K/rV2kQxB0kC6Q9tHIJ8Dr/Lpov3tMCcTPjmALzn1OpnV33OwRZ64BQRY2
 5EEAlT+TEqY8kYN7GkhccKWDdcV+YhR7/C
X-Received: by 2002:a05:6a00:124b:b0:806:12ff:3877 with SMTP id
 d2e1a72fcca58-823ab63f440mr10059208b3a.4.1770018858457; 
 Sun, 01 Feb 2026 23:54:18 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379bfd7a2sm14507439b3a.39.2026.02.01.23.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 23:54:17 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 2/2] accel/tcg: address_space_translate*() will pass the
 correct iommu_flags
Date: Mon,  2 Feb 2026 15:53:58 +0800
Message-ID: <20260202075358.2137740-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202075358.2137740-1-jim.shu@sifive.com>
References: <20260202075358.2137740-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
 include/accel/tcg/iommu.h |  3 ++-
 system/physmem.c          | 16 +++++++++++-----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2a0f4cfff62..404a8607b9b 100644
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
index 547f8ea0ef0..2a79f859834 100644
--- a/include/accel/tcg/iommu.h
+++ b/include/accel/tcg/iommu.h
@@ -20,7 +20,8 @@ MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
                                                        hwaddr *xlat,
                                                        hwaddr *plen,
                                                        MemTxAttrs attrs,
-                                                       int *prot);
+                                                       int *prot,
+                                                       MMUAccessType access_type);
 
 #endif
 
diff --git a/system/physmem.c b/system/physmem.c
index 2fb0c25c93b..337137489de 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -683,12 +683,14 @@ void tcg_iommu_init_notifier_list(CPUState *cpu)
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
@@ -705,10 +707,14 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
 
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



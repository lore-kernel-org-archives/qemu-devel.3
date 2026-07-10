Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8349DC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1P7-0007Hf-FY; Thu, 09 Jul 2026 22:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1P6-0007HR-7D
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:52 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1P4-0008L6-8h
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:51 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso286930a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652149; x=1784256949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gk4K18b/+1tfW8oHDRiVnbS5BQb8acvh7+kjO3qQK9I=;
 b=jZv9LoUeEFODt5uZ1vKLVMtjvWRXQb0V5txLUmXlJ5AkkwkyT+d3bZrNtbRgKRSyw/
 MM3LEV5yKVs4XXNrTkjB8k7Ejds12ZnlPkKa2z1+UEphgFMSqBBiAotXxYUcHI8k4xdK
 17K3feI6JoWehICaqifpsqnnUIzLDuHa2H2Us/2HPU6/aluZ0KKQj8wewqYPj+XRDJsB
 FjOEeToYg9vIMU78s6fwi5BgaSWjqztgH5lJq2r/bdW1ruz4dDlA3yrnrbg9jkTPelfX
 93hZ7vhhKQpqxjB+74VQXMTiE7Qypxp+Oh8Vswx3Tud9cem81Gst6fB7QLfhSkNU7KJK
 kNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652149; x=1784256949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gk4K18b/+1tfW8oHDRiVnbS5BQb8acvh7+kjO3qQK9I=;
 b=f6bn2Jk7H/o5DvcBxMmk4tEkOhWI1XfO48XUWOFSJEJLMiR+lVq7lQ0XnpZD8f7gTA
 0cUaw0SLnBKHXHGQZ0KSPfyKL7pH1rH6d7EV+rjOI/lNxILCGj1kKT4/m1pSFPJBgihv
 6U4g3f54hSDFmZumAoAsumSx9uNbjq8GiwZPRhvF138R4iQy+QPnL+KHSDXoDr0H036f
 oX5i1qQ1v0m4gCDObJzlBBM7wia+oKVeAeGg1QUAocxEA5xa0dIIMQUVNWGL5B/8fA7W
 kxBrlA21pLEjDRR9o3F3498ttNy0FmOlCN01YESW5q3JFc0nRwBnjGQ9p7+8+y/9UUzY
 mNpw==
X-Gm-Message-State: AOJu0YwQ1MgSmxJws8Sbp8bF+tbCei5HZpx/jB3UwYnb7/S+w5U3qxMG
 attoHnDf8BrqcrUlw+oj+BXc13olfRA3LgGcpC38ZlhzZ76PcjG1O2mTIJxFyg==
X-Gm-Gg: AfdE7cnpkfHZZZ1F8SapGHMQbtIcjJ2BIfbSjUG07jCKvTENMuQQkdGzvVcOl8LqDZG
 yQInJ3s379Sm4orL30wduoWg/boFso51QrAR8023H8lRfRw0neH+ROtfi3fgHuTL9FpGp8T7xCJ
 QiYf8qkmG6os3r6E8sB8s1+VvtHFzPaMJNRKGZ1qUouYfm5XsoInQUy9OM4qf6aGfvQanYUuP4O
 TBjkFg8Aqx72bXseJBpnXP642sW1XhKz/NWkNPcArz9CGae7FDsjAnBXTGhFsEBJVkEoTY49zCl
 chUbEpZrqYS1iroorgCxneF0F7W1uEQeYuGWhq7/cUzERo1q8Jsf2MVpegPdZKy4EsTBA5oCbVV
 deAMfljzAwbn1qi4a2/nzQe71K3CoG2rEulFwAGFAtFeZAWDpDzqXCgnkCpOhxjmKqlFhaCU3aL
 UkcYKkyuE5wc9UbdYRpoaad6iKHJWHALw=
X-Received: by 2002:a05:6a20:3282:b0:3bf:a638:4376 with SMTP id
 adf61e73a8af0-3c0bcebc910mr12390825637.21.1783652148764; 
 Thu, 09 Jul 2026 19:55:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:55:48 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/40] hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv
 access
Date: Fri, 10 Jul 2026 12:54:48 +1000
Message-ID: <20260710025525.1704417-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

All IOMMU accesses are assumed to be user mode unless told otherwise,
i.e. we have a process_id.  In case we have a non-user mode leaf PTE
(PTE_U isn't set) and we are running in user mode, we need to throw a
fault.

This also reflects on qos-riscv-iommu tests: the tests always run in
user mode so our PTEs must have PTE_U (bit 0x10) set.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3553
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260701121111.537654-3-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/libqos/qos-riscv-iommu.h | 4 ++--
 hw/riscv/riscv-iommu.c               | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/qos-riscv-iommu.h b/tests/qtest/libqos/qos-riscv-iommu.h
index 90e69a5d73..c218e9d66d 100644
--- a/tests/qtest/libqos/qos-riscv-iommu.h
+++ b/tests/qtest/libqos/qos-riscv-iommu.h
@@ -54,8 +54,8 @@
  * PTE masks for RISC-V IOMMU page tables.
  * Values match PTE_V, PTE_R, PTE_W, PTE_A, PTE_D in target/riscv/cpu_bits.h
  */
-#define QRIOMMU_NON_LEAF_PTE_MASK   0x001  /* PTE_V */
-#define QRIOMMU_LEAF_PTE_RW_MASK    0x0c7  /* V|R|W|A|D */
+#define QRIOMMU_NON_LEAF_PTE_MASK   0x011  /* PTE_V | PTE_U */
+#define QRIOMMU_LEAF_PTE_RW_MASK    0x0d7  /* V | R | W | A | D | PTE_U */
 #define QRIOMMU_PTE_PPN_MASK        0x003ffffffffffc00ull
 
 /* Address-space base offset for test tables */
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 6665ad9f7c..c35e9f0119 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -298,6 +298,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         G_STAGE = 1,
     } pass;
     MemTxResult ret;
+    bool pv = !!ctx->process_id;
 
     satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
     gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
@@ -471,6 +472,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Invalid PTE */
         } else if (pte & PTE_RESERVED(false)) {
             break;                /* Reserved PTE bits set */
+        } else if (!(pte & PTE_U) && !pv) {
+            /*
+             * All accesses are assumed to be User mode unless
+             * process_id is valid (pv).  In case we have a
+             * non-user mode PTE and !pv we need to fault.
+             */
+            break;
         } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
             base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
         } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
-- 
2.54.0



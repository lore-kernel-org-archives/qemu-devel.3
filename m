Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C49DC30658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 13:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM67W-0000Br-D2; Tue, 25 Jun 2024 09:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pykfirst@gmail.com>)
 id 1sM4Lg-00016P-6H
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:28:32 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pykfirst@gmail.com>)
 id 1sM4Le-0005c7-Bh
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:28:31 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f9cd92b146so42033985ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719314907; x=1719919707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uBaSheNEI17XWmXxdX9yRTMBkPWOO88fG/ISELWu8bk=;
 b=Zdgbs/wj+BQaCqPailsHmqlgrs8IiTlLNi+6kwjn6wN2QSfYVyiOioc+9lWvnP9sv0
 EQe2A9q5c7Sk2lkOaWz488tdp3J9e4S5x2tlujP5gjend7uvEC1VoUL2JOTwd441bEcP
 01tvT24R9Dnc8luZCAfTXV8Y1Yl+Ke98O380OJXcJ8V+qNE2KNYpM15eJY2vTPZl2yXS
 dv1rK6O6uh6LeoHYDBhFkLVMS5pZ5emx9uxlYxpaMIp4mYLKucr6nYmY6BGjEf9nk1G8
 CEq9jTzmHF4T2XALmh9AaIY8qiu3PMW1jKjrZFYEShqugdYbDmd09jLVsTQGy9Hpv9wO
 SQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719314907; x=1719919707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uBaSheNEI17XWmXxdX9yRTMBkPWOO88fG/ISELWu8bk=;
 b=vp8xVyx2o2m0Z1R/hIUd/cD3XJWpwLi0ju1wDMBy0NHXrvy4O4B4CB3x51kfwMMNUV
 vE4t8gxvmohfu0LJHCQyiOXMDX40hd4d+cjItRzmKtQ1SFbzSjd6VmRosU9Ee0ODO8DR
 gxlnQeeyVBH4LltNXlr/jrda6mw1N3CBtWJxiO53vGhioafEdIqJebzIUnrTjk7zVplK
 JiTYpskbZaRHSm9d3ZRFb5Ec0ooI1ivc1IOsaa3MpLXe3LgOPJthRhmzdghn37eJptAo
 qqM+hKleaMkjYimFnpICXi7W45qdJYk8fFnjvAUW+mqxQAALQDSGGMH4tVVbYB7hvsbc
 stBQ==
X-Gm-Message-State: AOJu0Yzqgjk/W9YCoMKBJK2uf7IVkdQA4Ij0ta9f0GoCfxW8OWn7TKlo
 RjbXccVlvC9/UMOGF6tBd8T06Pyt6tJ0cTlkVXQ+mEMxLuj0Kou8rh6tIo03IPM=
X-Google-Smtp-Source: AGHT+IHqUwRJFUoCz3qbjNJ+CVqW/avNyaw7XogtfvaL3OLauEv8OnVL1WH4He+7BQQ+X8daubb57g==
X-Received: by 2002:a17:902:f685:b0:1f7:2050:9a76 with SMTP id
 d9443c01a7336-1fa1d3de5bcmr104365535ad.8.1719314906934; 
 Tue, 25 Jun 2024 04:28:26 -0700 (PDT)
Received: from waoa-XPS-8940.. ([103.172.41.204])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ec6595ebsm78466885ad.25.2024.06.25.04.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 04:28:26 -0700 (PDT)
From: Yuke Peng <pykfirst@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH] hw/i386/intel_iommu: Block CFI when necessary
Date: Tue, 25 Jun 2024 19:28:19 +0800
Message-Id: <20240625112819.862282-1-pykfirst@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pykfirst@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Jun 2024 09:22:01 -0400
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

According to Intel VT-d specification 5.1.4, CFI must be blocked when
Extended Interrupt Mode is enabled or Compatibility format interrupts
are disabled.

Signed-off-by: Yuke Peng <pykfirst@gmail.com>
---
 hw/i386/intel_iommu.c         | 28 ++++++++++++++++++++++++++++
 hw/i386/trace-events          |  1 +
 include/hw/i386/intel_iommu.h |  1 +
 3 files changed, 30 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5085a6fee3..dfa2f979e7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2410,6 +2410,22 @@ static void vtd_handle_gcmd_ire(IntelIOMMUState *s, bool en)
     }
 }
 
+/* Handle Compatibility Format Interrupts Enable/Disable */
+static void vtd_handle_gcmd_cfi(IntelIOMMUState *s, bool en)
+{
+    trace_vtd_cfi_enable(en);
+
+    if (en) {
+        s->cfi_enabled = true;
+        /* Ok - report back to driver */
+        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_CFIS);
+    } else {
+        s->cfi_enabled = false;
+        /* Ok - report back to driver */
+        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_CFIS, 0);
+    }
+}
+
 /* Handle write to Global Command Register */
 static void vtd_handle_gcmd_write(IntelIOMMUState *s)
 {
@@ -2440,6 +2456,10 @@ static void vtd_handle_gcmd_write(IntelIOMMUState *s)
         /* Interrupt remap enable/disable */
         vtd_handle_gcmd_ire(s, val & VTD_GCMD_IRE);
     }
+    if (changed & VTD_GCMD_CFI) {
+        /* Compatibility format interrupts enable/disable */
+        vtd_handle_gcmd_cfi(s, val & VTD_GCMD_CFI);
+    }
 }
 
 /* Handle write to Context Command Register */
@@ -3304,6 +3324,7 @@ static const VMStateDescription vtd_vmstate = {
         VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
         VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
         VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
+        VMSTATE_BOOL(cfi_enabled, IntelIOMMUState),
         VMSTATE_BOOL(intr_eime, IntelIOMMUState),
         VMSTATE_END_OF_LIST()
     }
@@ -3525,6 +3546,12 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
 
     /* This is compatible mode. */
     if (addr.addr.int_mode != VTD_IR_INT_FORMAT_REMAP) {
+        if (iommu->intr_eime || !iommu->cfi_enabled) {
+            if (do_fault) {
+                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_COMPAT, 0);
+            }
+            return -EINVAL;
+        }
         memcpy(translated, origin, sizeof(*origin));
         goto out;
     }
@@ -3950,6 +3977,7 @@ static void vtd_init(IntelIOMMUState *s)
     s->root_scalable = false;
     s->dmar_enabled = false;
     s->intr_enabled = false;
+    s->cfi_enabled = false;
     s->iq_head = 0;
     s->iq_tail = 0;
     s->iq = 0;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 53c02d7ac8..ffd87db65f 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -57,6 +57,7 @@ vtd_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova, uint6
 vtd_dmar_enable(bool en) "enable %d"
 vtd_dmar_fault(uint16_t sid, int fault, uint64_t addr, bool is_write) "sid 0x%"PRIx16" fault %d addr 0x%"PRIx64" write %d"
 vtd_ir_enable(bool en) "enable %d"
+vtd_cfi_enable(bool en) "enable %d"
 vtd_ir_irte_get(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
 vtd_ir_remap(int index, int tri, int vec, int deliver, uint32_t dest, int dest_mode) "index %d trigger %d vector %d deliver %d dest 0x%"PRIx32" mode %d"
 vtd_ir_remap_type(const char *type) "%s"
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 7fa0a695c8..38e20d0f2c 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -294,6 +294,7 @@ struct IntelIOMMUState {
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
+    bool cfi_enabled;               /* Whether CFI is enabled */
     dma_addr_t intr_root;           /* Interrupt remapping table pointer */
     uint32_t intr_size;             /* Number of IR table entries */
     bool intr_eime;                 /* Extended interrupt mode enabled */
-- 
2.34.1



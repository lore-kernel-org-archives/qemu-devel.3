Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027C9CFC5FA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syyS6-00063W-RG; Thu, 10 Oct 2024 15:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyS4-00062o-V2
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:03:56 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyS2-0004j2-7K
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:03:56 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7db1f13b14aso1071396a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728587032; x=1729191832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPrzIa4nG4f+V6JITUP+rCk9SaYCtpeZ5a6iOcrm8J4=;
 b=D7/K7meimqsm/J68pPk8g5p8mibRQE6vbwofzEZuNTpaJBemgy7PXHG0zqVnAJZGu3
 +hCfixR/7yKfH0zCOYpNcmX7fFYIxIg8p/3jKP3akjFsNClj2mEOj8SGzC6iWtPpkkAc
 cjqPVXjK4FpOw/CjrttrB2EhLp6rv3CjtzZwac4CXE4xciX8R8Xq88tonQ+VzqxGy1YE
 94nj5OWAA7MyhZaXpv0uuwJu2upFqsXgH8vlAaY6S16btCrpiHc5AH57ow2qT9u6P5i4
 lLUFPkIBdqo5BhxnodABhZZzLRNm76+bhD2VXs6Xw8h2jyP+MvmO7s1NT83YY2N2dEg/
 RLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728587032; x=1729191832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPrzIa4nG4f+V6JITUP+rCk9SaYCtpeZ5a6iOcrm8J4=;
 b=dJjmra/gV2IT29rX3oqzC+Vv3FCQu7l7tdOW3XfI5iiYtv63GLer1Vvfn05dsE5DmP
 gZm5tJT1lA/aacX8lzF6WZr/dQNnv+Vi1flaZDSZRwOSOori1cnXV+MLYC68eZfikCkS
 sAbUo/kbXDyUuHKrR2YZAmZMm+UWC9wZAm2EwRSbyVrPNJT9lKzJNNQBqzuYJ+i5tpIk
 0i+Xwrx5K7L4nCWw/w53AbEPhdzznGqyPY+F8qz7Id5URvmswSTJ35KYeSiZHuejE6Ls
 ZeEQF8dJoYMCB771sbHKtEF74ntyYVb/JMZ2rzVIGJ/zqxThQobp0LBzrOzSvR2SjJHx
 xILQ==
X-Gm-Message-State: AOJu0Yz8rvVsR8/SJCF0cjI8uLc84XlRrR4DWMTkfn1nYYJbo2ruaSyQ
 VRhXqWIQ7ikaJlnt53nZ75J3oSXJoJRl3mp5L/W+pXwH+YRi1IqgPoQeffJ9iZaS2PxELAZRtnx
 F
X-Google-Smtp-Source: AGHT+IFzONBhwFvPP2XjphuuwdTbYOp0vQX1CQzxBPTu/J+Pt4eK8dna3JP6075OmmzDVVTIOc9PhA==
X-Received: by 2002:a05:6a20:e18a:b0:1d3:b30:44a2 with SMTP id
 adf61e73a8af0-1d8bcefa643mr28802637.7.1728587032575; 
 Thu, 10 Oct 2024 12:03:52 -0700 (PDT)
Received: from grind.. (201-68-240-198.dsl.telesp.net.br. [201.68.240.198])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2a9f5263sm1354532b3a.62.2024.10.10.12.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 12:03:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/8] hw/riscv/virt.c: rename helper to
 virt_use_kvm_aia_aplic_imsic()
Date: Thu, 10 Oct 2024 16:03:32 -0300
Message-ID: <20241010190337.376987-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010190337.376987-1-dbarboza@ventanamicro.com>
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52b.google.com
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

Similar to the riscv_is_kvm_aia_aplic_imsic() helper from riscv_aplic.c,
the existing virt_use_kvm_aia() is testing for KVM aia=aplic-imsic with
in-kernel irqchip enabled. It is not checking for a generic AIA support.

Rename the helper to virt_use_kvm_aia_aplic_imsic() to reflect what the
helper is doing, and use the existing riscv_is_kvm_aia_aplic_imsic() to
obscure details such as the presence of the in-kernel irqchip.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/virt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b5bdbb34e0..f1bdc1c535 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -57,9 +57,11 @@
 #include "hw/virtio/virtio-iommu.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
-static bool virt_use_kvm_aia(RISCVVirtState *s)
+static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
 {
-    return kvm_irqchip_in_kernel() && s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
+    bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
+
+    return riscv_is_kvm_aia_aplic_imsic(msimode);
 }
 
 static bool virt_aclint_allowed(void)
@@ -774,8 +776,8 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
         *msi_pcie_phandle = msi_s_phandle;
     }
 
-    /* KVM AIA only has one APLIC instance */
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
+    /* KVM AIA aplic-imsic only has one APLIC instance */
+    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         create_fdt_socket_aplic(s, memmap, 0,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
@@ -1540,7 +1542,7 @@ static void virt_machine_init(MachineState *machine)
         }
     }
 
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
+    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
                              VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
                              memmap[VIRT_APLIC_S].base,
-- 
2.45.2



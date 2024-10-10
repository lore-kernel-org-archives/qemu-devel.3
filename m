Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6394CFC5F8
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syySF-00067y-0C; Thu, 10 Oct 2024 15:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syySA-00065M-IQ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:04:02 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyS8-0004jn-W0
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:04:02 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71dfe07489dso1088341b3a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728587039; x=1729191839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oJigOA3pUwrJKDXI/ZEnIGISLXhzd47ZD58adw0TrQ=;
 b=Wi5XB0aOPgjCnVAecnFmakABOsdmgNgsWIlKdmO0awu211kcPWZPKxl0QKd7AtJrMK
 g2RvCmMmCKoNAx49dF7Y/wXNeFiysdIgJ4fed3Cv6rVcCygYDLlzWUTkRnvGNbLrtfAt
 yb2T2KKouZtATAQmbkT8m4IVskwHPJObIk6gugG5ZK098djKi+kTPHEdB31vbGKB/7q2
 qQiosS5QC3LKiMGOo8ZqIqvwus2Bvsdq4CQ6pHHazKkekOVHhfJy7DjoXJP/0heAQFxi
 iZS7x3fsl1C90H7uBdJscTMhALKycfx+oDxo3AK7C9a+dVDAjRDJM9ot0V9gHrXkaGgP
 L9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728587039; x=1729191839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oJigOA3pUwrJKDXI/ZEnIGISLXhzd47ZD58adw0TrQ=;
 b=Tfs/Z2eV9LmZE0Tzd5yn/0mS5CtoXmZlS6H1kEp4ZaUPLgoE8O0ZkOhMFW3PG8daWY
 q6pWQLPNjZG9rQwGrB4p7IkK80zz+S2t/MYobYDzpSNtBx3RXGqWEGgotC1RuknKi9hE
 dkRjS5h6FNNXwQhk+/rs0LGjb009seoOqzPt7LYKbbkl4PefGz88UvTL3Q3QfTshQW6Q
 XB9yDoHuvZ95AMbhuOk4ek46hE1SaYgIQl7lm3D51my9ZLDq967t9jvel9t3TRemgWBD
 4nzyY/tYbSRuySINB3Znzbr9hwcmMABbZ5eZpT5X1E5kCKKiW0UuUEE6vn7PK0zu7RKO
 pyow==
X-Gm-Message-State: AOJu0YzVXXAllZv86PjzNjWjj1gdmkYGh9/V9VjIlUXMIAvXISTgJU0d
 7LZn/GjbGOMxn2JMM7dBJ6sPkZY0TPc47XDllDj6N6a4+aIA3d8kurgeNKrx5pHkwcn9CawuQ/U
 y
X-Google-Smtp-Source: AGHT+IFaDjFT1RnxUpKKLlSvKLUUl/IyfpdfHC8Oe5CZB8ExWqKPHz6sNY6MaHq3kyjcDaRAHP443A==
X-Received: by 2002:a05:6a00:14c3:b0:70d:2a88:a483 with SMTP id
 d2e1a72fcca58-71e37c78e82mr178815b3a.0.1728587039229; 
 Thu, 10 Oct 2024 12:03:59 -0700 (PDT)
Received: from grind.. (201-68-240-198.dsl.telesp.net.br. [201.68.240.198])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2a9f5263sm1354532b3a.62.2024.10.10.12.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 12:03:58 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 5/8] hw/riscv/virt.c,
 riscv_aplic.c: add 'emulated_aplic' helpers
Date: Thu, 10 Oct 2024 16:03:34 -0300
Message-ID: <20241010190337.376987-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010190337.376987-1-dbarboza@ventanamicro.com>
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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

The current logic to determine if we don't need an emulated APLIC
controller, i.e. KVM will provide for us, is to determine if we're
running KVM, with in-kernel irqchip support, and running
aia=aplic-imsic. This is modelled by riscv_is_kvm_aia_aplic_imsic() and
virt_use_kvm_aia_aplic_imsic().

This won't suffice to support irqchip_split() mode: it will match
exactly the same conditions as the one above, but setting the irqchip to
'split' mode will now require us to emulate an APLIC s-mode controller,
like we're doing with 'aia=aplic'.

Create a new riscv_use_emulated_aplic() helper that will encapsulate
this logic. Replace the uses of "riscv_is_kvm_aia_aplic_imsic()" with
this helper every time we're taking a decision on emulate an APLIC
controller or not. Do the same in virt.c with virt_use_emulated_aplic().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/intc/riscv_aplic.c         | 24 +++++++++++++++++++++---
 hw/riscv/virt.c               | 14 ++++++++++++--
 include/hw/intc/riscv_aplic.h |  1 +
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 20de8c63a2..0696e20ddf 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -32,6 +32,7 @@
 #include "target/riscv/cpu.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
 
@@ -159,6 +160,23 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode)
     return kvm_irqchip_in_kernel() && msimode;
 }
 
+bool riscv_use_emulated_aplic(bool msimode)
+{
+#ifdef CONFIG_KVM
+    if (tcg_enabled()) {
+        return true;
+    }
+
+    if (!riscv_is_kvm_aia_aplic_imsic(msimode)) {
+        return true;
+    }
+
+    return kvm_kernel_irqchip_split();
+#else
+    return true;
+#endif
+}
+
 static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
                                           uint32_t irq)
 {
@@ -853,7 +871,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
     uint32_t i;
     RISCVAPLICState *aplic = RISCV_APLIC(dev);
 
-    if (!riscv_is_kvm_aia_aplic_imsic(aplic->msimode)) {
+    if (riscv_use_emulated_aplic(aplic->msimode)) {
         aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
         aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
         aplic->state = g_new0(uint32_t, aplic->num_irqs);
@@ -877,7 +895,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
      * have IRQ lines delegated by their parent APLIC.
      */
     if (!aplic->parent) {
-        if (kvm_enabled() && riscv_is_kvm_aia_aplic_imsic(aplic->msimode)) {
+        if (kvm_enabled() && !riscv_use_emulated_aplic(aplic->msimode)) {
             qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
         } else {
             qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
@@ -1021,7 +1039,7 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    if (!riscv_is_kvm_aia_aplic_imsic(msimode)) {
+    if (riscv_use_emulated_aplic(msimode)) {
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     }
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f1bdc1c535..39fd9b7c3e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -64,6 +64,13 @@ static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
     return riscv_is_kvm_aia_aplic_imsic(msimode);
 }
 
+static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
+{
+    bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
+
+    return riscv_use_emulated_aplic(msimode);
+}
+
 static bool virt_aclint_allowed(void)
 {
     return tcg_enabled() || qtest_enabled();
@@ -776,8 +783,11 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
         *msi_pcie_phandle = msi_s_phandle;
     }
 
-    /* KVM AIA aplic-imsic only has one APLIC instance */
-    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
+    /*
+     * With KVM AIA aplic-imsic, using an irqchip without split
+     * mode, we'll use only one APLIC instance.
+     */
+    if (!virt_use_emulated_aplic(s->aia_type)) {
         create_fdt_socket_aplic(s, memmap, 0,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index fd0e6427d9..74ae5d87b5 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -72,6 +72,7 @@ struct RISCVAPLICState {
 
 void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
 bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
+bool riscv_use_emulated_aplic(bool msimode);
 
 DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3908E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSF2-0006Pv-Gi; Thu, 19 Dec 2024 20:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEp-0006ER-NO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:36 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEn-0004TJ-Vr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:35 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-72909c459c4so1143153b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659732; x=1735264532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9kGRz8yBDn3xNhaRpjl5eLNif1NBmGaYms609zt52g=;
 b=Gc9AVkuvO0Nvwbnj7VmkPJH3WBMhnivl1FWS3MkBVv2J7180Ugn9tiDPel0KwmpZ4d
 M4oTt+rHAMFzRFytEAxmr9XhWGM7H6aiUUhHgya4BLxaysY6nuK5xeADirsirtI5nn04
 PfvzQld5hBCA9RfLqwKksaPyC4tbUBZXPv4zlqU7iB/Psp+dMfNX8KRNRfv+eIpibmfL
 VjtaR8nxYSYnd/Ri3LOKLth22N65bpJ7MdIkLjDVpymg7YAsV6gnXDXEG1Et74CJ/aMU
 k/smU7ymWOT5vsJnIJYyOmaoQQW/S0mY1jLTSJlgcl5CYAWb4qJGhm8i0bLWe51mWgXl
 bmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659732; x=1735264532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9kGRz8yBDn3xNhaRpjl5eLNif1NBmGaYms609zt52g=;
 b=vEtMCeK5eDR+1211icUB01wVwIgzM0C75NTfEeqhtRQ0ftOqTMcuLQEnVrl1jO2u2R
 +p7GOtdqoVtwj6GucgLcUHoSgc20DUfFgk6BYfLkTytaVPcukKSwCiTDMFG3AO8JjZSn
 qel6uiUScZ7FKZfS9FIRZSIJF2UUlkdxtZ+n6FOYkoxEWnkWJtu5Zc+cDFWBgLs/B/pE
 5R+CWyDIpTN3icSnWCuZDmsjgzOssfrwff0NuOSkQP2CwyhbKHQOIL7GDQlrjtwCGwxC
 6OYeAC45BX1BNxs1al//+RmZX9zkDfe3shg4EpwRJal6PhjbtyOmCChA99PY6DJ3HfOA
 XO+Q==
X-Gm-Message-State: AOJu0YyTgPbW8T3No7zIO7yy7OL/Tx0g4e6/v2dagg87QF/x76bF5Bm6
 IOgIQdQVvb5un3nPMU6L5TA89A31OHTcDSkbHopf4sySEXRlNYUuZNQNQCI5
X-Gm-Gg: ASbGncvNyXsMRYKTJH+KykF5oCLjuR+qkjK2RE1IbXROs2m3Hlv/qf/VkeuH+xRlweb
 Je7fSHbnDlx1UDamM0BgocrI/XUttEEQ32nctIlirLBrL4vHkvBE+DT74pitBbWCUMRQWrkC6vi
 oCTuGQVnzpd7oTsHI/iJi57Ges/+ULSJTR8yon7faDpzCS82AVt8FSHmkAIpvJKuN3J6BiRWzzR
 pZvizGCRgRRTMHxvMaBzPhlWr4y4Oj5Rvej8W9FqqacrPblaEdQGEpyJLildunP7/QclU0eLbJD
 ZhhK9KLGSovEi1kRzKl8HThwkls+xMeNYSkJQRQR/iQ1uuD+zXflPk3BmnlafT8=
X-Google-Smtp-Source: AGHT+IHj4EHL8uaRue+oZwGrmAUyqYPzjtLwRYsfpGCWDK36aFwib77I5FT8OiuGCv+8XNyaKwnOAw==
X-Received: by 2002:a05:6a00:430d:b0:728:e906:e466 with SMTP id
 d2e1a72fcca58-72abdeb4793mr1289742b3a.21.1734659732244; 
 Thu, 19 Dec 2024 17:55:32 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 13/39] hw/riscv/virt.c: rename helper to
 virt_use_kvm_aia_aplic_imsic()
Date: Fri, 20 Dec 2024 11:54:13 +1000
Message-ID: <20241220015441.317236-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Similar to the riscv_is_kvm_aia_aplic_imsic() helper from riscv_aplic.c,
the existing virt_use_kvm_aia() is testing for KVM aia=aplic-imsic with
in-kernel irqchip enabled. It is not checking for a generic AIA support.

Rename the helper to virt_use_kvm_aia_aplic_imsic() to reflect what the
helper is doing, and use the existing riscv_is_kvm_aia_aplic_imsic() to
obscure details such as the presence of the in-kernel irqchip.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241119191706.718860-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e54e1257c0..a67ab80b16 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -59,9 +59,11 @@
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
@@ -777,8 +779,8 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
         *msi_pcie_phandle = msi_s_phandle;
     }
 
-    /* KVM AIA only has one APLIC instance */
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
+    /* KVM AIA aplic-imsic only has one APLIC instance */
+    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         create_fdt_socket_aplic(s, memmap, 0,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
@@ -1619,7 +1621,7 @@ static void virt_machine_init(MachineState *machine)
         }
     }
 
-    if (kvm_enabled() && virt_use_kvm_aia(s)) {
+    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
         kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
                              VIRT_IRQCHIP_NUM_SOURCES, VIRT_IRQCHIP_NUM_MSIS,
                              memmap[VIRT_APLIC_S].base,
-- 
2.47.1



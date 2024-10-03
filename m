Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F1ECF34BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swR0s-0000nH-3C; Thu, 03 Oct 2024 14:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swR0n-0000mN-8U; Thu, 03 Oct 2024 14:57:17 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swR0l-0003Jz-2U; Thu, 03 Oct 2024 14:57:16 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fac63abf63so15452061fa.1; 
 Thu, 03 Oct 2024 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727981832; x=1728586632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NqZgDSIdmym8k9v4wrElx9POiJdcsjS85l4BMSFw2Y=;
 b=NSgjaM1edaz9MFceqbDunFyA+WRG+jmdv2EvgYiw16oexOHKrK5/0N5jyjomGEG3eq
 DOFEda1ucm0BUBzA7mByyq3Idha9hINZlqs0lsOCWbBcSPsWNskuQSfdEc+b2OVu/dbJ
 CJQzwPj6RRi89g5NbEHCp13v9Rzhy0C4gYRuOwb6WBQOhwOQKq0JSCyeEh/sI18adegu
 nHJbodaNmCGLA7EXhxLRokFhgGZPCsakmxNV8jrtaM9ni/RuBm1ZxfszS3ELwQE1TZGu
 pXtisFxkAbvrq9pk6jZ8cB65p66dzxYfMPibKmc8RmpRGBzJeZTPvkLbaK3CSjWtCu3F
 dhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727981832; x=1728586632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NqZgDSIdmym8k9v4wrElx9POiJdcsjS85l4BMSFw2Y=;
 b=DDdDC2eI0UwdLjdAnVHxRJHLub6fEx0u56MdT9F2SyFgrcMUTcP830WdoQhy6FaBOR
 hxzFESimcmo4IoQB9Tl//WpQW1WVDKIO3BNrvVSv3jRUGWW1hndBTzpE889RbO1Mb+lS
 FVqC9GR2AbtriZ+9GJUlcpRf7SlW7TPZPAfJwdQLKdbfFwP6oI1iv608+/dDJKvMnwXd
 Ee3/+T6td/NeKxlSIweFHjzbCOMdxFe//GNfJfi6DMIR+z6hkcHPZpP+e+WwGl/Y5Z8P
 ZL2LpYye6OgjU2xjSgJcyMUphDFWD/t7bSd8lwceBA0we+/gIJbsj2LyV6DCFDsFDoXi
 qwSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrv70LIPwtZrbVh+tnUf4U0OsjqKzojwprtiOCkEi33MyaRxDsE6syjspy7gY2+xt52/3j8jnzxg==@nongnu.org
X-Gm-Message-State: AOJu0YzY7ahEstiIUy1wME1aWBQMoMFjYPydDsZ5SFFTyJOO+nl+y/gp
 KjwlPf54YLsi1hVzxwz63+y0H94NVZud/i1xRRd53HQvyt/S6kvYd95Q4bYF
X-Google-Smtp-Source: AGHT+IGdtsrhdXwp14pMpvdvc+CdpPcIPMIZgK2C81T/sez5hURdlMZpHD5usN8FxM0Nz2NV9uyp/Q==
X-Received: by 2002:a2e:be20:0:b0:2f5:2ba:2c99 with SMTP id
 38308e7fff4ca-2faf3c1400cmr307781fa.9.1727981832153; 
 Thu, 03 Oct 2024 11:57:12 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faecc13b2asm2706361fa.69.2024.10.03.11.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:57:11 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PULL v2 5/5] hw/arm: xenpvh: Enable PCI for ARM PVH
Date: Thu,  3 Oct 2024 20:56:54 +0200
Message-ID: <20241003185655.1480819-6-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
References: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Enable PCI support for the ARM Xen PVH machine.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xen-pvh.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 28af3910ea..33f0dd5982 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -39,6 +39,16 @@ static void xen_arm_instance_init(Object *obj)
                                          VIRTIO_MMIO_DEV_SIZE };
 }
 
+static void xen_pvh_set_pci_intx_irq(void *opaque, int intx_irq, int level)
+{
+    XenPVHMachineState *s = XEN_PVH_MACHINE(opaque);
+    int irq = s->cfg.pci_intx_irq_base + intx_irq;
+
+    if (xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level)) {
+        error_report("xendevicemodel_set_pci_intx_level failed");
+    }
+}
+
 static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
 {
     XenPVHMachineClass *xpc = XEN_PVH_MACHINE_CLASS(oc);
@@ -69,7 +79,11 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
     /* Xen/ARM does not use buffered IOREQs.  */
     xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
 
+    /* PCI INTX delivery.  */
+    xpc->set_pci_intx_irq = xen_pvh_set_pci_intx_irq;
+
     /* List of supported features known to work on PVH ARM.  */
+    xpc->has_pci = true;
     xpc->has_tpm = true;
     xpc->has_virtio_mmio = true;
 
-- 
2.43.0



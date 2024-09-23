Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D12CF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 14:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sskTq-00007i-9I; Mon, 23 Sep 2024 10:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sskTo-0008Ro-9s; Mon, 23 Sep 2024 10:56:01 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sskTU-0006w9-3Z; Mon, 23 Sep 2024 10:55:59 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-503f943f115so517348e0c.0; 
 Mon, 23 Sep 2024 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727103332; x=1727708132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NqZgDSIdmym8k9v4wrElx9POiJdcsjS85l4BMSFw2Y=;
 b=WadERRgOp9bzeeL/8J69pJtZmjCBaYbkAw3K7F7mE50IN8jY4oe354wqhFm1s1CoQU
 O9D2VhXXxJVJMVupUu63Bbipt52HCGUsZAmIJzInb5c7HBps6NL2VSfd+uLD/PA2ug6i
 bj8BUrM4yadGTlPBJ77cCbe3Eh3PYtZMBLZonSI9X35UWwzen5FQ5xoz4S//rpI4qIk8
 PrLpMa7xDW/aoR+idym6TuGGAaemJ04ivdefx5e+ZjDZ+Wjx4t1BBiM64qtfkJpjOA/9
 AwNMpyaIF+78mWmFFJanB32ERjbZTsjOOtj0l1faIc265/xUK+TTF+gx/9lAHbrvKq7h
 FA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727103332; x=1727708132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NqZgDSIdmym8k9v4wrElx9POiJdcsjS85l4BMSFw2Y=;
 b=RcQI1Q5K61qqR1cI04U1+Q8Jce+jQyXTRxhm+dXLOYzF6Ym5RfZkAKlHjopZnDp7p5
 RxuL1DJoCWWO8WqPI9VOOLdAC5lNFyhT+epuhytoIrpG+IWPPC46EPp21Kcp4kTdHWmp
 5Nps69XPLdtSBRi5yzLBxRTyw48YB/LzxawJ5id1HQIFEz0w6q2q3X2nz5l0zL+M/ZMo
 w/T18RyhCNW2DSz4GGwTbscLgGxVkJmAj+i7nf6bJ9dFO0RxCIgEFe0jXzUMxbQQmFw0
 nUT0+DYwh+camPjb3dSsu59MekBAXF1XeNI6ZJp+EODg3FNLhvIoIYQbGbG1Px0tfHBC
 ICvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1yQEEU/cWaciNPfN80CJS5SgPA63g28Pu4ayAoZhM7nKDdFctCKCNyuNlQCwrIsZImFGU3L11Gw==@nongnu.org
X-Gm-Message-State: AOJu0YyxLcsy+E3qI/4U2HWFK5IZVvOwCj5Mti2Y/W+TNP9ARDUy5FKW
 vDuKculGbVG4kTVi9EILWQgoimwJSCUNI1/DygXNAOUVkXke7zDPjhC6YnL2
X-Google-Smtp-Source: AGHT+IG6dbA1Qoykmc5DxVHIT6I9aGC0+8n371MVri28ok0pj3/lLGZ93yQkgFm3m0GB4zJqdCuIOQ==
X-Received: by 2002:a05:6122:3c91:b0:4f6:e87d:5160 with SMTP id
 71dfb90a1353d-503e04cc2ffmr6905503e0c.9.1727103332294; 
 Mon, 23 Sep 2024 07:55:32 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-503d7e9ea08sm1784841e0c.31.2024.09.23.07.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 07:55:31 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v2 4/4] hw/arm: xenpvh: Enable PCI for ARM PVH
Date: Mon, 23 Sep 2024 16:55:20 +0200
Message-ID: <20240923145520.1323504-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923145520.1323504-1-edgar.iglesias@gmail.com>
References: <20240923145520.1323504-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa31.google.com
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



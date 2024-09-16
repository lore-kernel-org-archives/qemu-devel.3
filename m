Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1ECC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqDLn-00056e-WE; Mon, 16 Sep 2024 11:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sqDLl-0004xG-I4; Mon, 16 Sep 2024 11:09:13 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sqDLk-00049S-0H; Mon, 16 Sep 2024 11:09:13 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39f54ab8e69so17853595ab.1; 
 Mon, 16 Sep 2024 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726499349; x=1727104149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIDS2BgSDN2sYeAiwQv8u9Oegpn8pHfzCYrmX62ewXA=;
 b=nIkpclEsIgGOjCSYa2bRLF0AQhYQ/L9WpgWXPPMGUa/2ExnR/Bu21VThvQmnx7ErZJ
 eZQyMzZlL63vD3LFPDfJr4/WE1d8aFuK2cI79edpC/hLX7Uzdgdb0g7ZMRMug4ESwAZ5
 B8SpAhvl/xamYhTWIogPQyXf8fxb4k58Zgyxv+0vH4jdjArxyCahIxH4G/EJHb3Zj/5j
 a3dh51Ct12KC9SO/Mcm0mxC5prkID+0m0tX5ojirVxB99v/aeZZTz+RHuWiaydssrCax
 JsnkYBlBzSyI3CA24CH3SBKb+cK8p6h2VSVhnqE6wqOeLQFk6H221gvKfIMoGLznlTUV
 7msg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726499349; x=1727104149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tIDS2BgSDN2sYeAiwQv8u9Oegpn8pHfzCYrmX62ewXA=;
 b=pfnwRUhF0Eg0PoBdDGkNy17fe3XxUUwvdWDMWXPm7cr/9L6lLVnDm/2eumIZeHKeVE
 IoubFhQRx9fPfaSqvL1hK0IyiKwgmV6BbYHbZA8gXb7Upf1080F8R2m8+v8zHRFWiWZ8
 J3j9x1Soqh4OLR5UaANToKkqxwQITbnQ12h9DWu7OpBfAkdqbc1nfN/VduzHrLaee/gB
 smZjKBSecQ9V5++Dx65nOIrndT4RADxt6DnCkvIhyNCAnLxd53C+uKOFXNPJcIOv1vwz
 Jbb9EJeMAtryO6GNlHjtBc9Redh5PW5WjqmGCntgwK/bu5N2lupN4aP9SZlrMz3DY9Uk
 PJFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEbhVUxx/FZu16eIpHCdLP8BDtQH/CjlBqvfHXvZE3F2ofSp8G0hS6SeP9CMgU1uDA0o+9E9lKqQ==@nongnu.org
X-Gm-Message-State: AOJu0YxbGKaZ/axh7sD8imC+X5dcTzlDFeOCxt3CLTjPgA/R0zpjiVny
 QT7A7ZzQC7XhTck50c7fCF7wcwhDtyWW0A46eLql6Red75QKNfocXxlFN492
X-Google-Smtp-Source: AGHT+IE86ZuS/7NQzNvR5tLVOdqaKbQKcpupAoW/xUcVW9ix1XY+RyPuORlI+lKWYit0Zg+iCQOwZg==
X-Received: by 2002:a05:6e02:12c5:b0:39f:325f:78e6 with SMTP id
 e9e14a558f8ab-3a0845a0d55mr130717185ab.0.1726499349478; 
 Mon, 16 Sep 2024 08:09:09 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a092e9005csm16897935ab.79.2024.09.16.08.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:09:08 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v1 4/4] hw/arm: xenpvh: Enable PCI for ARM PVH
Date: Mon, 16 Sep 2024 17:08:52 +0200
Message-ID: <20240916150853.1216703-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
References: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-il1-x136.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



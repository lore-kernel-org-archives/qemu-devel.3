Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBDFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 17:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZvnf-00046F-58; Fri, 02 Aug 2024 13:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvne-00045i-4u
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 13:10:42 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvnc-0001BW-Fn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 13:10:41 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7a8553db90so1129367866b.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722618638; x=1723223438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TqUjxIdKSvsizFNHQdJuvAS4tLUxFNJv4u/cmIrhrNI=;
 b=DuCGy1vlwfsPf0eSIcv2XM1vlUDYCHmv+tCaM+f0wHDZ+dEQzZSKTJ6opoBB3cDb4P
 pQ1CFGhNnPfejw1By3FX8EnBdClHVrXO3slMU0n2C5oUYYciyoq2XcKEizo2bvAxjb6T
 AlhXUhIHTiLerT677lUKNC2gQ3EZ+x2fG4WYaoA0mSMNfYNJizWGJtVa+SUT26rN6vgb
 KqepgVv4EJj8zk/v2q4IycB4XpM9eJPTt6yaLYaw7rcbIJFEzgsPQE1DFUk61bSHBVCM
 yQFm7v0ZO7KNafdU/+6C8zk3SAFD70jfme5kjPTL3qmBc2X5x4nQtnjjDmycRGsHokVv
 OZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722618638; x=1723223438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TqUjxIdKSvsizFNHQdJuvAS4tLUxFNJv4u/cmIrhrNI=;
 b=gW/3eKaHhMBuGQN6wzn8usqRgvYKl9VtkT+Vl/W17/3hFJrgrkzewZpeI2zzSKmZSD
 H47VRiqb17uh0m51Imu8BnE4EhbBPyvso5lqP1oWW5ILRaMNgbvPE6ii24TTJOlps4UP
 3dJ3+tCvUQn9k2DEzmutvLPoSimyWUUv97LiF+SHUtNusCpfMNOGXIxg/2UpRHiCrEL9
 MgyCOW9Nsfb2HWmcBFeA4TiY+acfiiFr7gJa0S6Bh+UZ2CMbYnNhle60lvGJuTo4ZtX0
 7lTEgvJak3TUGcNi0wZNWwsjZJdaqrAjKsZOJBng7AX8UhO/Y1i4d17nL7HX7YSPieVv
 vSSg==
X-Gm-Message-State: AOJu0YzJwFFCiLmSyT5O80yXldqSBXRe2lH6pHFK8joUFVK3/cdQSj9D
 OLOHHT/2hx+7U0xyJyBcbEs84HK17Y0r7YhrZBbqs2HeU4jhkeZwtRNV2gkERegPy322p+SbXFW
 s
X-Google-Smtp-Source: AGHT+IFOhKRtHxXj5TN8ktdKH0fL24vgJN6s0FXmBpQiOUaHdfrt1HCbGtkazKBBXOlliImibe5SjA==
X-Received: by 2002:a17:907:7f8d:b0:a72:5598:f03d with SMTP id
 a640c23a62f3a-a7dc5157d5bmr313693566b.59.1722618638036; 
 Fri, 02 Aug 2024 10:10:38 -0700 (PDT)
Received: from m1x-phil.lan (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d55ab8sm119274166b.131.2024.08.02.10.10.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Aug 2024 10:10:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-9.1 v4 2/2] hw/pci-host/gt64120: Reset config registers
 during RESET phase
Date: Fri,  2 Aug 2024 19:10:23 +0200
Message-ID: <20240802171023.85719-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802171023.85719-1-philmd@linaro.org>
References: <20240802171023.85719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reset config values in the device RESET phase, not only once
when the device is realized, because otherwise the device can
use unknown values at reset.

Since we are adding a new reset method, use the preferred
Resettable API (for a simple leaf device reset, a
DeviceClass::reset method and a ResettableClass::reset_hold
method are essentially identical).

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/gt64120.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 7df2855f32..b0d05db577 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1217,17 +1217,24 @@ static void gt64120_pci_realize(PCIDevice *d, Error **errp)
 {
     /* Values from chapter 17.16 "PCI Configuration" */
 
-    pci_set_word(d->config + PCI_COMMAND, 0);
-    pci_set_word(d->config + PCI_STATUS,
-                 PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
-    pci_config_set_prog_interface(d->config, 0);
-
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff009);
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff009);
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff009);
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff009);
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff009);
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001);
+}
+
+static void gt64120_pci_reset_hold(Object *obj, ResetType type)
+{
+    PCIDevice *d = PCI_DEVICE(obj);
+
+    /* Values from chapter 17.16 "PCI Configuration" */
+
+    pci_set_word(d->config + PCI_COMMAND, 0);
+    pci_set_word(d->config + PCI_STATUS,
+                 PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
+    pci_config_set_prog_interface(d->config, 0);
 
     pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
     pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
@@ -1243,7 +1250,9 @@ static void gt64120_pci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.hold = gt64120_pci_reset_hold;
     k->realize = gt64120_pci_realize;
     k->vendor_id = PCI_VENDOR_ID_MARVELL;
     k->device_id = PCI_DEVICE_ID_MARVELL_GT6412X;
-- 
2.45.2



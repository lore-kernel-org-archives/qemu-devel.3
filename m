Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72EE606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iOWe1IPg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX4XZ-0000U8-1z; Fri, 27 Nov 2026 17:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xX4XX-0000PY-BY
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:35:35 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xX4XV-0000R0-S3
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:35:35 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3b41188c8b9so5811839a91.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 14:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795818932; x=1796423732; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kytycHaD29E8KpBA+lbPjFPnP3pSaxDLMMUKrr4o4U4=;
 b=iOWe1IPg5R0P+kLNUn6fTxcdE0f+zfryJ9YhDTMmi76SWbJMf+anKmOxfW9cME2FbW
 LRoMJaFFvsj92D+fZBSZEM4XcyVx0Pc+Kbkghq7hnE3WLDkSdwI829uMZmoYEfv2Kl8g
 iYn8prH683nFmzVR7qrlhylmMZtzK+sSk6OSqkEdxLirt/pNNO3OT2RfORm77oVoGua8
 uVcXK3L8sXswDStmmMt5iIQs46j2+xq1QFGhlbKL8SUYCa3pZG5a7oJeu4Dj6K0KRQ5M
 BxH9o7QGPvNOoUvf/pfAED2RgB4k1yefVi9SEoD99KbLZJmiy1FIxz9a2AWxeHvCdlNE
 Y2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795818932; x=1796423732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kytycHaD29E8KpBA+lbPjFPnP3pSaxDLMMUKrr4o4U4=;
 b=i449mIJDrxGEcIYdE41NC8dWESC8mX/Ru25cVYkcYeRa5GSlqRzwc9wqAJCxHrJqvE
 dALSkV5mK0qTZNEiFkAcSGAmYInMAsgOYSv/Pg6VJv37/95EL95pvxtja6yV4Ptccozo
 dnNuM2HuvQg8ytPOmwlUtzO4kH/q3kMvxuXUyDNIJoHVDVJuOx1+XoE+tI3LdQK2Tr9V
 GZSMQsp4F30ryJKw2RIhtT29rSV2lKv6cJmmZ4YkK2qw7TbznLbnzp9JFcptWkv2tf1r
 zG5cdue0t3o3+B738GaUCPwiawl/IWmtks9Wyi1fPIVdwD30Y0cGPWnG2ZA4jzo+XJKi
 pYvQ==
X-Gm-Message-State: APuU4Z/tmAGUJfGtXexPXP1K77b5k3sqSsTTeSX9ERBswqzX/4jHr9aW
 CTwoZrcXEGgtgr2b71RzW7D0dY6Apipta4MlUO+g5dV5flBxW92buJrqjT+0CQ==
X-Gm-Gg: AZFdTZf0En+qdkg+fN06yJEjJrrVSlGMfSLVaIxuD2vzXdvcdddrAO+C+UvMrCIKhcR
 TDNw7iklEutchTGF66db9XFyxtlKSNBPuIV35LX2DOjcyw/Khqrm906wIJcrhV5a5vUtyjbSfPG
 bBis0PE58r0ifVeFIk5fCRIFltEm/1HWY0q+8vfWbpUHrOUmWonkZfrMYycpzJWWuH3JqHL56uU
 3pJnSD+plHJLs4rcECQUp8SuFHwiWpjZYIZHoTS/kIc6iXWez5KNSRu4UlPNXmoVH47tyIB9hAM
 5mkccVnYNDmSfKJhEzMmIxsXUxX78fhKM5b/sz64KqLkg+PpZMJ/oAU9mdQ7AAk1vZstu9i6kOe
 gD68hKN76YIuSabb0oTBb069OP9NMWzNHLagLsnMhbF926HOAmDWASfGpMsKlhjMPu+cVPorsA4
 hBfMkgAYbCmS9dajnyPVpFoURIHLYKmQpagi2D90La4fsf/+GBtUdjWUW2zH1ei2IwuCWu2TTAR
 nWuwMdawSTXsOEgP34kaQD2o38Mwd4V7YDNd08Oue6Vubcx2hH9WUZbM3fsBdTs1Q1cR5TgAZPy
 /fhY2754EvhfnhOEPbBFCqiZQ3ihvXr0Bn9EPA0gSh0GAEAJXbSvxUrHB6hCxq7xCYJResy6tkb
 Ue4feAqWL5eyT0m/hNqzZxcTBQ0Jv/zJShCRzAzuPkEsXQI5LQf88
X-Received: by 2002:a17:90a:d607:b0:3a4:ad5c:d48a with SMTP id
 98e67ed59e1d1-3b41c97c8acmr26765818a91.67.1795818932380; 
 Fri, 27 Nov 2026 14:35:32 -0800 (PST)
Received: from cfarm136.osuosl.org (cfarm136.osuosl.org.
 [2605:bc80:3010:104:21e:67ff:fefd:7034])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0b2c4sm39880831a91.4.2026.11.27.14.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 14:35:30 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Fri, 27 Nov 2026 22:35:18 +0000
Subject: [PATCH 4/4] hw/pci-bridge: Convert xio3130_upstream to Resettable
 interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-pci-bridge-resettable-v1-4-cdf15c9252c5@gmail.com>
References: <20261127-pci-bridge-resettable-v1-0-cdf15c9252c5@gmail.com>
In-Reply-To: <20261127-pci-bridge-resettable-v1-0-cdf15c9252c5@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=aleszlucero@gmail.com; helo=mail-pj1-x1031.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the deprecated device_class_set_legacy_reset() in
xio3130_upstream.c with the ResettableClass hold phase.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
 hw/pci-bridge/xio3130_upstream.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 9d58105..149db12 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -24,6 +24,7 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/core/resettable.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 
@@ -46,11 +47,11 @@ static void xio3130_upstream_write_config(PCIDevice *d, uint32_t address,
     pcie_aer_write_config(d, address, val, len);
 }
 
-static void xio3130_upstream_reset(DeviceState *qdev)
+static void xio3130_upstream_reset_hold(Object *obj, ResetType type)
 {
-    PCIDevice *d = PCI_DEVICE(qdev);
+    PCIDevice *d = PCI_DEVICE(obj);
 
-    pci_bridge_reset(qdev);
+    pci_bridge_reset(DEVICE(obj));
     pcie_cap_deverr_reset(d);
 }
 
@@ -127,6 +128,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->config_write = xio3130_upstream_write_config;
     k->realize = xio3130_upstream_realize;
@@ -136,7 +138,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
     k->revision = XIO3130_REVISION;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "TI X3130 Upstream Port of PCI Express Switch";
-    device_class_set_legacy_reset(dc, xio3130_upstream_reset);
+    rc->phases.hold = xio3130_upstream_reset_hold;
     dc->vmsd = &vmstate_xio3130_upstream;
 }
 

-- 
2.53.0



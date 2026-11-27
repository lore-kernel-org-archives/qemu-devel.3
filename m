Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A51606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rh+sInSS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX4XU-0000KK-GH; Fri, 27 Nov 2026 17:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xX4XT-0000JT-AR
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:35:31 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleszlucero@gmail.com>)
 id 1xX4XR-00089R-NZ
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 17:35:31 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cdd9d0c9bbdso4989786a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 14:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795818928; x=1796423728; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q+T0GT8vhpia/aIgQqXGu4HlhgAA94U6cmsUTCaWDog=;
 b=Rh+sInSSFUloIr/u3ZDOUrixSlVPt4GutETmtg1MezASGrAAQJevv2V5tD/YnjsXqH
 2hJI1z2KcePiff7jUTrhO+p0PCnhDTqyF/DG61dPuXRDo28bevBdpVrt6m/61KUO49oU
 889LCc5IX9S/B3SDH3Yq2dmjRMX9BjbcvSv+LSwI3UV0Q5VdgYUI55P940SwOuJOz3KF
 R/l2XWtvi6uL59j3478T9bV6xI7WKq3com0gDGXZTT0sK/1qhj3X1yIZV37X+X/soGVs
 RSzNSEl6lJykReaWr5qNlML24DxG3XB+AvRkXVMEGIvDuVFanVpwexS+lBtR/MHTUJya
 Ag5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795818928; x=1796423728;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q+T0GT8vhpia/aIgQqXGu4HlhgAA94U6cmsUTCaWDog=;
 b=ohiU1XhRVlyOaDnCnl+8ifeG0ovTM7jsThJXVFvIUcZpWP1m8KZmpoqkA5pMQTzX4c
 8MIrYCxWaXoVbccpn7fz7ejH6LXhA4DogPrme6UGwFWaUQuJEXh8iqlFVczfDMw5FAvJ
 kzuYc1My+Sr/8IOeJy1ntnEM2Ej+UeMDRR60Ys52+XhhOHMt0f6F8NXxXnn2UPfU1jgE
 A627L+cwHDX2QGxLnonP+9UtbE8/z5WeoOVQU0aRQALN2xLL4QEINS5nyKi1YuJevbMd
 obrwI27bZExcDbb1a7cOCF/CbEXrIo2iUiTxNp8xFs1Tv9lCApqziiVqQKIui6Jiltj6
 gvxg==
X-Gm-Message-State: APuU4Z8QL3kBbOrXGC9OoTNdYnASaS5sCwO1ULjDueWFR1PZ2q9HpoSt
 Cg9D/MYPveYmAKqyuppdlGrZlHh802Vj0JpWHOgv5ZvqTu8N1PjRSAK8
X-Gm-Gg: AZFdTZfqbIRRHOAula1uvUQvN/H/hi0v0kqAaxxSzLX+RONsAfOXytVODMtMfAdfbvi
 nByCFI5a76plgq4Pja9LMAGTos1VNbvQWM8rAllsOE/B6XPHma9oO41B3CXT1DmO6LUZFWza/lD
 VzkVRnHgjw6X6cu2GaIE26dPivYFPY/ur9ZEWA2/uZe3pFaOzJMlYCCueEKFRXK1oZdVjY55UJq
 krzyHhWMzQpl91NTDgyUx8oPLv/rD3vQsq0E6ph+8qOUCt74J1v3EHfSVmdnTdqHdv44BjGoh2o
 DUsCGC8yDYTZ/+9yrYwb6P1+Df3c0e5yy3uB19d1LRfr3v4GhBNxJL12f4qjZ5M4nl/7mRHRdHp
 YG+gDxnJe4OGk2tI6VJzaHkXJUBFp0lVaTRPCYf2kpgRcoRKOp7k3O0ycKIY0dOWXQPlopfYJ16
 bCf6Haa6IhhAOs/UlupHbRj52rRiZAMRknH9gStB2JrKLYQfp/uJqnvQKQOW3VLY+WMYDuDDg5H
 bo05Uo2QlP8G2W/O6ZYD0eupK94mLTvHgDENDpQZTPZDn6yHWf08uXdMsvo9+4BNz8mtQ4yUaTx
 ZOiZe9jsBCOsskNf0GTWuM2ouW25alGLbXgb8ZLz8GRpORaCCbXw9Uw14MPipqyGH9DLq0soOCk
 OPLIKD181MLmF+nprGECHLlgvTWFYzp4=
X-Received: by 2002:a17:90a:e70c:b0:3ab:4f1:4f7e with SMTP id
 98e67ed59e1d1-3b41c92a182mr26641033a91.28.1795818927897; 
 Fri, 27 Nov 2026 14:35:27 -0800 (PST)
Received: from cfarm136.osuosl.org (cfarm136.osuosl.org.
 [2605:bc80:3010:104:21e:67ff:fefd:7034])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0b2c4sm39880831a91.4.2026.11.27.14.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 14:35:26 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Fri, 27 Nov 2026 22:35:16 +0000
Subject: [PATCH 2/4] hw/pci-bridge: Convert gen_pcie_upstream_port to
 Resettable interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-pci-bridge-resettable-v1-2-cdf15c9252c5@gmail.com>
References: <20261127-pci-bridge-resettable-v1-0-cdf15c9252c5@gmail.com>
In-Reply-To: <20261127-pci-bridge-resettable-v1-0-cdf15c9252c5@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=aleszlucero@gmail.com; helo=mail-pg1-x52a.google.com
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
gen_pcie_upstream_port.c with the ResettableClass hold phase.

Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
 hw/pci-bridge/gen_pcie_upstream_port.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/pci-bridge/gen_pcie_upstream_port.c b/hw/pci-bridge/gen_pcie_upstream_port.c
index da3e9e2..c95cf33 100644
--- a/hw/pci-bridge/gen_pcie_upstream_port.c
+++ b/hw/pci-bridge/gen_pcie_upstream_port.c
@@ -21,6 +21,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
+#include "hw/core/resettable.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
@@ -65,12 +66,12 @@ static void gen_upstream_write_config(PCIDevice *d, uint32_t address,
     pcie_aer_write_config(d, address, val, len);
 }
 
-static void gen_upstream_reset(DeviceState *qdev)
+static void gen_upstream_reset_hold(Object *obj, ResetType type)
 {
-    PCIDevice *d = PCI_DEVICE(qdev);
+    PCIDevice *d = PCI_DEVICE(obj);
     GenPCIEUpstreamPort *usp = GEN_PCIE_UPSTREAM_PORT(d);
 
-    pci_bridge_reset(qdev);
+    pci_bridge_reset(DEVICE(obj));
     pcie_cap_deverr_reset(d);
     pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, false);
 }
@@ -145,6 +146,7 @@ static void gen_pcie_upstream_port_class_init(ObjectClass *klass,
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->config_write = gen_upstream_write_config;
     k->realize = gen_upstream_realize;
@@ -153,7 +155,7 @@ static void gen_pcie_upstream_port_class_init(ObjectClass *klass,
     k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_USP;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "PCI Express Upstream Port";
-    device_class_set_legacy_reset(dc, gen_upstream_reset);
+    rc->phases.hold = gen_upstream_reset_hold;
     dc->vmsd = &vmstate_gen_pcie_upstream_port;
     device_class_set_props(dc, gen_pcie_upstream_port_props);
 }

-- 
2.53.0



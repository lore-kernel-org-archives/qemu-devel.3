Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195F9EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni9w-0006fJ-3l; Wed, 04 Feb 2026 14:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9s-0006LE-8X
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9q-0007kZ-9k
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7oJwB+/MR7DB60Rv9oamUAujf6sHA9qp5RSISJ/HXw=;
 b=N4MhTRDzGMxytRl0+BmjvvmBPoSCNKUZsG4EGnfi89XvUa+UqsFGC2RdgPmdiFz6gbiSjj
 ud0DMcVzKxwtVYSP32VMSkG2FDgIxDLNzBdSwZT2GqspYk6F0Pv7LQda7Sml8mqLikHPBD
 rmEZERpqHxynRs6NepkyNfz1Ipp6OwQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-jPoPeFwGPVqUplD-7tdZOQ-1; Wed, 04 Feb 2026 14:03:19 -0500
X-MC-Unique: jPoPeFwGPVqUplD-7tdZOQ-1
X-Mimecast-MFC-AGG-ID: jPoPeFwGPVqUplD-7tdZOQ_1770231798
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-435ab9ed85dso133031f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231798; x=1770836598; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o7oJwB+/MR7DB60Rv9oamUAujf6sHA9qp5RSISJ/HXw=;
 b=VJRQVE/YPZcpjosM6qc8gYfG3Q/qMPnG2Eh2fL8p8kHL/+qk9mZ1wyIKAtCxW364bx
 L2wwE2msQywB9sb5FYFWANAOVmn+Pex8+LhHsvB4THYqv1l0+0S8G4l20NLvnikzh01N
 +Ooc8ymUVEnLOF4kVT7fXDyyoQdAWZuFu0ngVHiicE1Wc5Si/vcIkztd1Av5QW7yaT2i
 zZQHi9UxKP8zlXGolkzwzSYQA59OiqyBsoQXvYISD3n3x+HpbcIU7BwYA0jcMjeUjOXP
 86GoY0IAne+JO4WBNBUneYueEdKFSwyPK9FKh2J95m/QFqmt+c/RbYQxdLm8y7X4mco0
 JqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231798; x=1770836598;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o7oJwB+/MR7DB60Rv9oamUAujf6sHA9qp5RSISJ/HXw=;
 b=M86wRkpM4pQ+9bhnKHe4HCjE1bxuKArjLaCBxi/L/ilzTNnoOJu7fsWXpM5AZLLIBH
 cmEysXygpgLeujAyYT4fkyEsuB/7zJJ0lCkJDuETjGz2VCfC7lvzTwWy27JtWu5/i8rf
 2d4S6dipxBZg9IFuI9aTpAQgT0Q/ODIAfFm13CbOvSS8DP63mf11hKr4KX/6JkzUgFBi
 iwa3DZvC0AxeZsHQz3Cejxg6n59g69o406fOwH8cQbcfB8z7FiqYzWk50DHwWLlk7bsx
 2/VmisUNF7T7np8tIXScS95tZY69EyRUXY8dpsnZKljFwRoTuAvFxPu6t/4q3f1qA1jZ
 rIZA==
X-Gm-Message-State: AOJu0YwoFpRb4wkhvXbn9JYED8VSsv+qbagB3LbKXJnzt6JImkE/YzuC
 ERNrGVJ3SzgFb8F97gaNW2nkZLfghnFJi5IC6vEQLXhUbTeo4qpUDMR83bQ1RZQYgRQpqISNh4d
 Xs1MmN6TdMhHNoytwCZ6VZoNPktG24X5DNBxNl1yStteEdbfwA+T07qgGrW1MTwhBajoc/kuFOS
 knJaOnLKAWx9p7ApamKnpZgsAAol4XOtHEuA==
X-Gm-Gg: AZuq6aJvRMDV13TWmIeLzpQpkkcLrAYoVjImILN9CxoT5PExxKd9mGVzhCCgE2CsWNS
 riaQYjNdeQmjavdvK5VEFJ5wKbG/51OGg39PDLhWaY0+xQ+fqkx0ezkBsqfMyfeoiVCaMwsVuSg
 exjbY7yS991D/u+1cqFOQFB4NZH+W5hBKNMfaSStikJLAJPO4/jGpIQhDerkLPXenOpdktAFDp2
 /vspS9eBJiS6/erMKTQQDkUmE7vpxyFo/8sGkB9nluSy37L4hGyIMY64OuHut/uriCr2QW/xvan
 crcliGLYNz+ePDaQLcLQvAX4f46+QEVLjjbp5hZcor3ztrayEKxKkk4vzKWPbZTivUW9v34Qmv5
 gV61GwxyxnVaigwaHH8+l60JnuW/uUJTLSg==
X-Received: by 2002:a05:6000:2c08:b0:432:dfa8:e1b6 with SMTP id
 ffacd0b85a97d-43618053ae7mr5702188f8f.39.1770231797695; 
 Wed, 04 Feb 2026 11:03:17 -0800 (PST)
X-Received: by 2002:a05:6000:2c08:b0:432:dfa8:e1b6 with SMTP id
 ffacd0b85a97d-43618053ae7mr5702086f8f.39.1770231796962; 
 Wed, 04 Feb 2026 11:03:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e25e8csm7558641f8f.1.2026.02.04.11.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:16 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aurelien Jarno <aurelien@aurel32.net>, Nicholas Piggin <npiggin@gmail.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org
Subject: [PULL 11/51] hw/pci-host: Set DEVICE_CATEGORY_BRIDGE once in parent
 class_init()
Message-ID: <f6258e47396663e06468f971433044521311c233.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

No need to set DEVICE_CATEGORY_BRIDGE for each device
implementing TYPE_PCI_HOST_BRIDGE: set it once in the
parent.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20251027112306.57634-1-philmd@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251027112306.57634-1-philmd@linaro.org>
---
 hw/pci-host/articia.c     | 1 -
 hw/pci-host/aspeed_pcie.c | 1 -
 hw/pci-host/designware.c  | 3 ---
 hw/pci-host/gpex.c        | 2 --
 hw/pci-host/grackle.c     | 1 -
 hw/pci-host/gt64120.c     | 1 -
 hw/pci-host/mv64361.c     | 1 -
 hw/pci-host/pnv_phb.c     | 1 -
 hw/pci-host/ppce500.c     | 1 -
 hw/pci-host/q35.c         | 1 -
 hw/pci-host/raven.c       | 1 -
 hw/pci-host/remote.c      | 1 -
 hw/pci-host/sabre.c       | 1 -
 hw/pci-host/uninorth.c    | 4 ----
 hw/pci-host/xilinx-pcie.c | 2 --
 hw/pci/pci_host.c         | 1 +
 16 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index 1881e03d58..04623dfd84 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -200,7 +200,6 @@ static void articia_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = articia_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 /* TYPE_ARTICIA_PCI_HOST */
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index 83a1c7075c..8eeba1f9f3 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -350,7 +350,6 @@ static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
     dc->desc = "ASPEED PCIe RC";
     dc->realize = aspeed_pcie_rc_realize;
     dc->fw_name = "pci";
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 
     hc->root_bus_path = aspeed_pcie_rc_root_bus_path;
     device_class_set_props(dc, aspeed_pcie_rc_props);
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 019e025382..00c9449c4d 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -593,8 +593,6 @@ static void designware_pcie_root_class_init(ObjectClass *klass,
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-
     k->vendor_id = PCI_VENDOR_ID_SYNOPSYS;
     k->device_id = 0xABCD;
     k->revision = 0;
@@ -736,7 +734,6 @@ static void designware_pcie_host_class_init(ObjectClass *klass,
 
     hc->root_bus_path = designware_pcie_host_root_bus_path;
     dc->realize = designware_pcie_host_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     dc->vmsd = &vmstate_designware_pcie_host;
 }
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index b5074c05c0..e66784ce51 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -200,7 +200,6 @@ static void gpex_host_class_init(ObjectClass *klass, const void *data)
     hc->root_bus_path = gpex_host_root_bus_path;
     dc->realize = gpex_host_realize;
     dc->unrealize = gpex_host_unrealize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     device_class_set_props(dc, gpex_host_properties);
 }
@@ -242,7 +241,6 @@ static void gpex_root_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "QEMU generic PCIe host bridge";
     dc->vmsd = &vmstate_gpex_root;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 9a58f0e9b5..b0db7870b0 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -140,7 +140,6 @@ static void grackle_class_init(ObjectClass *klass, const void *data)
 
     dc->realize = grackle_realize;
     device_class_set_props(dc, grackle_properties);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     sbc->explicit_ofw_unit_address = grackle_ofw_unit_address;
 }
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index d361c457ed..566f928304 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1298,7 +1298,6 @@ static void gt64120_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_props(dc, gt64120_properties);
     dc->realize = gt64120_realize;
     device_class_set_legacy_reset(dc, gt64120_reset);
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index ef1c77563e..495a82befd 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -108,7 +108,6 @@ static void mv64361_pcihost_class_init(ObjectClass *klass, const void *data)
 
     dc->realize = mv64361_pcihost_realize;
     device_class_set_props(dc, mv64361_pcihost_props);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo mv64361_pcihost_info = {
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 85fcc3b686..0b556d1bf5 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -202,7 +202,6 @@ static void pnv_phb_class_init(ObjectClass *klass, const void *data)
     hc->root_bus_path = pnv_phb_root_bus_path;
     dc->realize = pnv_phb_realize;
     device_class_set_props(dc, pnv_phb_properties);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->user_creatable = true;
 }
 
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 76623f78c4..67180ba5f0 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -516,7 +516,6 @@ static void e500_pcihost_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = e500_pcihost_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_props(dc, pcihost_properties);
     dc->vmsd = &vmstate_ppce500_pci;
 }
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index bf56229051..b353d3e1e6 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -194,7 +194,6 @@ static void q35_host_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, q35_host_props);
     /* Reason: needs to be wired up by pc_q35_init */
     dc->user_creatable = false;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
 }
 
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index c50061996c..b3c2678667 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -296,7 +296,6 @@ static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->realize = raven_pcihost_realizefn;
     dc->fw_name = "pci";
 }
diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
index feaaa9adaa..9ea95fac6e 100644
--- a/hw/pci-host/remote.c
+++ b/hw/pci-host/remote.c
@@ -55,7 +55,6 @@ static void remote_pcihost_class_init(ObjectClass *klass, const void *data)
     dc->realize = remote_pcihost_realize;
 
     dc->user_creatable = false;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
 }
 
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index b3f57dca7d..cd2328ad53 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -505,7 +505,6 @@ static void sabre_class_init(ObjectClass *klass, const void *data)
     dc->realize = sabre_realize;
     device_class_set_legacy_reset(dc, sabre_reset);
     device_class_set_props(dc, sabre_properties);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     sbc->explicit_ofw_unit_address = sabre_ofw_unit_address;
 }
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index d39546b6f4..10972de694 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -435,7 +435,6 @@ static void pci_unin_main_class_init(ObjectClass *klass, const void *data)
 
     dc->realize = pci_unin_main_realize;
     device_class_set_props(dc, pci_unin_main_pci_host_props);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     sbc->explicit_ofw_unit_address = pci_unin_main_ofw_unit_address;
 }
@@ -453,7 +452,6 @@ static void pci_u3_agp_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_u3_agp_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo pci_u3_agp_info = {
@@ -469,7 +467,6 @@ static void pci_unin_agp_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_unin_agp_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo pci_unin_agp_info = {
@@ -485,7 +482,6 @@ static void pci_unin_internal_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_unin_internal_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo pci_unin_internal_info = {
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 86c20377d1..40f625b61d 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -172,7 +172,6 @@ static void xilinx_pcie_host_class_init(ObjectClass *klass, const void *data)
 
     hc->root_bus_path = xilinx_pcie_host_root_bus_path;
     dc->realize = xilinx_pcie_host_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     device_class_set_props(dc, xilinx_pcie_host_props);
 }
@@ -291,7 +290,6 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "Xilinx AXI-PCIe Host Bridge";
     k->vendor_id = PCI_VENDOR_ID_XILINX;
     k->device_id = 0x7021;
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 05f1475dc7..91e3885c7f 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -245,6 +245,7 @@ static void pci_host_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     device_class_set_props(dc, pci_host_properties_common);
     dc->vmsd = &vmstate_pcihost;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo pci_host_type_info = {
-- 
MST



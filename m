Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9E6C54E51
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf5sG-0006vR-W4; Tue, 27 Feb 2024 17:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3G2HeZQcKCow04214tyw44w1u.s426u2A-tuBu1343w3A.47w@flex--komlodi.bounces.google.com>)
 id 1rf5sE-0006u8-Me
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:30 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3G2HeZQcKCow04214tyw44w1u.s426u2A-tuBu1343w3A.47w@flex--komlodi.bounces.google.com>)
 id 1rf5sD-0008JF-9H
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:24:30 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc6dbdcfd39so8052068276.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 14:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709072668; x=1709677468; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=eqE7f5CT/axcKSnjnqXh+oEiq+xgWFDINsdVlLdZAO0=;
 b=tqJSWTSEBmxO9B9kVJfM/EjZcY57LNsaW4jcaBxv0gI03tviPLYY1Xh4iDv9p8RUZZ
 CQLlKfbQaaRs1f4OGN74Ow1L8vuHhvWyo4u2wiGIwvH9q3P9ff2QhwVDffa8m8wy3jxU
 ezxYnOQLH/X0epCCrJ/PJqx8ayK2msqLfnm0zs5iZgW/tEsV8jBO2prv83C4Uh+iwltZ
 d6QGVtyogkJvGW2qnM/R4Nc8QCTTMoMVMLvoTmVjRGJdaDXePLNssG+ss1MR5p27r6bO
 AB3r5ZTeVX58b6UW50dVtDPrcnBJvEZ+n606n0L5xR3D58L0cyBVUrv90qUPeU53GUzW
 q9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709072668; x=1709677468;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqE7f5CT/axcKSnjnqXh+oEiq+xgWFDINsdVlLdZAO0=;
 b=WQgdgwj5bE2C/Jm0aGpU7em44TdIpbXNbdCStGt0XL3Uezc5XsuJYCj/K/+yOF3y35
 HP4mKEsZTytrhpNDGxltk5VgKzPSVGkinjM3lO1XlMY+zAJf2imC4a0tkVMxvf2jPzHU
 a6duwdGynsf7nG2Vc+hbleD94rHq54pe3G83Ud8l32CFvJiYpUEedHBMQUr9QHnSog7X
 WZshKs5DNbTm9kjURZrYQy9j2afmz/KA9wbmSMutnNWw/S2bmjEgnsrkrrlMaPVugzdZ
 dTsW+cQauukAqxW/ryf9Ob2paRlsnN6KH6zgGtmNerkNudN4Yo850g9d15m5GcbLKQIN
 BClQ==
X-Gm-Message-State: AOJu0YyD56FS2+VDVRYsfkV+mYLiirRTGP01+FPWeN71dDTDHPsSU2zM
 Gnc2Wv12AmGhMv9+kGOsryzIl8H5s5vnVK3whNFmoJ3HYZGbJy48xzspTsdUcyYDsCjaW46Wg6O
 4hgp1jansbyLaYDw2pVDulFeN3kzqT/Leb+egoxzNo1ZsxLJW0r9fhCZGUpmXOVM0DCbJ3VPoJe
 0QN6Cx2oBPtJDRowcSy0uvHatyAWCRNzNCRCsW
X-Google-Smtp-Source: AGHT+IGn8xeDtsxlzFfkZsipK7Q4BJjVVn30bQg6uNhnnTAJNNSV/H7eVfzag0aNkbEs1rdp8NFljlAxZfCo
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a05:6902:1896:b0:dcc:54d0:85e0 with SMTP
 id cj22-20020a056902189600b00dcc54d085e0mr213592ybb.11.1709072667824; Tue, 27
 Feb 2024 14:24:27 -0800 (PST)
Date: Tue, 27 Feb 2024 22:24:17 +0000
In-Reply-To: <20240227222417.929367-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240227222417.929367-1-komlodi@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227222417.929367-6-komlodi@google.com>
Subject: [RFC PATCH 5/5] hw/pci: Add user-defined memattrs
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 peter.maydell@linaro.org, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, roqueh@google.com, slongfield@google.com, 
 komlodi@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3G2HeZQcKCow04214tyw44w1u.s426u2A-tuBu1343w3A.47w@flex--komlodi.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This adds user-defined bits, which users can set and use on transactions
that involve memory attributes.

We add it in the MSI function, since the attributes are initialized in
that function.
We do not add it in pci_dma_rw because the attributes are passed in.
Some users might pass in MEMTXATTRS_UNSPECIFIED, and we should respect
that instead of injecting user-defined attributes in the function.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/pci/pci.c                | 3 +++
 include/hw/pci/pci_device.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6496d027ca..b0bb682f15 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,6 +85,8 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    DEFINE_PROP_UINT8("memattr-user-defined", PCIDevice, memattr_user_defined,
+                      0),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -361,6 +363,7 @@ static void pci_msi_trigger(PCIDevice *dev, MSIMessage msg)
         return;
     }
     attrs.requester_id = pci_requester_id(dev);
+    attrs.user_defined = dev->memattr_user_defined;
     address_space_stl_le(&dev->bus_master_as, msg.address, msg.data,
                          attrs, NULL);
 }
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b2..99be6d72b1 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -84,6 +84,7 @@ struct PCIDevice {
      * conventional PCI root complex, this field is meaningless.
      */
     PCIReqIDCache requester_id_cache;
+    uint8_t memattr_user_defined;
     char name[64];
     PCIIORegion io_regions[PCI_NUM_REGIONS];
     AddressSpace bus_master_as;
-- 
2.44.0.rc0.258.g7320e95886-goog



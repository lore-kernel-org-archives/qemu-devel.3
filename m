Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FC5C48BC1
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 10:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYkXW-00071J-6E; Sat, 10 Feb 2024 05:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkXS-00070o-1e
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:24:50 -0500
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkXQ-0002dQ-Ia
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:24:49 -0500
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-363b8429f03so5212045ab.1
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 02:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707560687; x=1708165487;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Zrx+cM9JnBC8UHWhVfp2cUkKCiTKN/0k3qIHo/fadQ=;
 b=OPks0v+5nLxVFRcJlPwTmBlFpIpSEHqWgEClNtDnryErBEbg17zkkpRqqNPncYxXnj
 ugojUKuG2FMHaWXwQ2yIOklkEKy9W1lnoHr0QqJndFJVPGHtQ7QNXAI6ba9ENnq0Q03i
 sGRkXAbzCAoF6lzUscswF9JdjJj2NNOyzl+WIDs2Wdff882c5PsBkt9pTgqBRkrUcXeY
 sc4YgFEJ/mdzWEGGwEExZNa6hHuJ90S5a/am7HZ0vt4gf9y+iCSaJpMcdf9hL2oRy8gp
 5xdfkqS4FjRzllGP2I4K7wMX6nwLceRU4XKx1wj3CXObrimVSqM2j3GL2wEjpCOjt7qz
 08gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707560687; x=1708165487;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Zrx+cM9JnBC8UHWhVfp2cUkKCiTKN/0k3qIHo/fadQ=;
 b=JZPflCWA1kzU8y3w8au8J3arpaVyqeoXFLNAOjqpPxzNOW7UGb2wckyAJd/IBZob8z
 JdFooqlk03FBh0XNZ+uzxE2OlJXZBP9GDLcPdzJxriiRVZRJhW3+k4A4vUHANFoUdJUT
 Epr4EOJP7HMMCA2ll5lJa8FKNVggvq1BAIOuH1nerYIiotmYcZS4y9OsvwbAFqT8vc5L
 8K0m1xazb894aamtRS7eGsXd+o2FJAceBOW7rvWud48GRaSts7EKo0E1edqWFewmA1rp
 KTkT8GRG1twH65464XzrLGF2Cf5LU4ihYlc8eycrHcxQTALPjeoQqGnwqlXodMYldvb+
 Sr5A==
X-Gm-Message-State: AOJu0Yz/Smo60hmoWwU0FNRbVQCW5oyb7mPFerarvpyeEj8GESPwj6n2
 ULIkHMZuwYDmKnBJCYJhNOCq8LJFzxtR9dL0yvFr3CMNR1qLYsqhhMXx4tZrH6M=
X-Google-Smtp-Source: AGHT+IE1lc9r25BsOY+Z2jeAgQ5GjB8B8DA2HxTmpf25vF8iwcp9wVmNAdK7kDrM14MT5WxNcJbrrQ==
X-Received: by 2002:a92:dc51:0:b0:363:dd7a:f62a with SMTP id
 x17-20020a92dc51000000b00363dd7af62amr1985694ilq.26.1707560687653; 
 Sat, 10 Feb 2024 02:24:47 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUUMtqcYsm8qnzeD4tEo9eijVeifmE4Ms3oj0tTBgpu9zAmASWFARHBBwuAd8uJfNS30eu2HWX5c/gFkU9uTwVqRe9D52BdyJgdDVN7oWxyth72ELs/LY034xxAGQynYbZ75v4FgUP0aEJmchCSdoKPH88wvQJnaCqgBCHujDKQZhqKu65v21vt47W76XOHLZXiQiF/Hyn+QINrR7+Jaga/xSZsx+8OE6ItYz9jOfiFOqSDRiTWhoN7HAFiXNZz/t6xysAeVyRf0Az64qUsrQslqRIfX2qUuwq1QK2ZrdV5PQ83JX5MPCUe3fOScyymeOSEC+kGC4ZuPfkUQLs6o7HkhwLBwr72C2AKBQCaHvMbCKY+pvzN3K3BEu/+01e31Ay2pPlJOzuzUidnyEEE5xlqAbCXSMwMg2cuy2rWYQ==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 a15-20020a63d40f000000b005ceeeea1816sm3288273pgh.77.2024.02.10.02.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 02:24:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 Feb 2024 19:24:36 +0900
Subject: [PATCH v2 1/6] hw/pci: Determine if rombar is explicitly enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-reuse-v2-1-24ba2a502692@daynix.com>
References: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
In-Reply-To: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::129;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

vfio determines if rombar is explicitly enabled by inspecting QDict.
Inspecting QDict is not nice because QDict is untyped and depends on the
details on the external interface. Add an infrastructure to determine if
rombar is explicitly enabled to hw/pci. PCIDevice::rom_bar is changed to
have -1 by the default to tell rombar is explicitly enabled. It is
consistent with other properties like addr and romsize.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 5 +++++
 hw/pci/pci.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b273..54fa0676abf1 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
+{
+    return dev->rom_bar && dev->rom_bar != -1;
+}
+
 uint16_t pci_requester_id(PCIDevice *dev);
 
 /* DMA access functions */
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 76080af580d7..d08548d8ffe9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -71,7 +71,7 @@ static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, -1),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, -1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,

-- 
2.43.0



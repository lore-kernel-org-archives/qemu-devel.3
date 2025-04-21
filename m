Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B50C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u61-0001EA-98; Mon, 21 Apr 2025 12:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4W-0008EO-8p
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:42 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u4U-0003L8-Ht
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:39 -0400
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so3842477a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253157; x=1745857957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dawidxz5JOBtoT8mh7yE8JxkLIKJJsZ8Tuvx/W3HyYY=;
 b=Ex2JAm9LZK+j/CK5EAa6xzR39dSfFD8y/jPVeVV0U5GA6IjpFoEySnmkfheoakIq+0
 rt+E/VycggWmGbBGGWbBlptLJQBn1sjrowRg0TgyeE6/0PBVvmRrn48A5FCXgAJtdbgf
 cK0QJ7CjUpSmWCM5k0oHVNsejaPTPCagekNExRF4g3PT826GETufvPlNuLEw31ElA9fI
 esHr7yxKjhqy4XIY7z4fwwLKe3nE0tnLkeJZYvZ7TX22RUvhRxGVpMd/8DdIarJeJOIU
 xwUWKE/aETssYD+lq8HHMJqmEWqlQlNFJrmSVYX/dEvCrnBLaS+wtopZDEY295SlQo7K
 ws3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253157; x=1745857957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dawidxz5JOBtoT8mh7yE8JxkLIKJJsZ8Tuvx/W3HyYY=;
 b=Inw0KaZfqf8zj42qwA64H2BA1/CAHbc1K2bfc6Duf6ZS6+nR10IAIF87nJQMoVwFPe
 sYqbtUUZ2C8NJmmQoIE3vSjA4M/YSWPfUTH2sld2bdnjoCmjhbd/ehhkcTQQ1w2cUkq/
 wqOwJqf50H4uYV+AvlFOz90L6jrVcScwR2H3xlK8rlp69XBsejcy7S2OK7lwk3uDjYWA
 p+hVIePfk85rqfdg9h5IVy+0EJKQpvRxJ9xN01DC98ha6TVKmslhKihzxzgM0eM7LjdF
 P16Z7HzSaLRsL8xSfpmWBMlYKitZC5JxmqJC0KhmTb1nTePTK+qds1cBmto6SUrfodYA
 JwBg==
X-Gm-Message-State: AOJu0Yy/fawGM6wUVs8w/nSmAirA4JTBKhpDVcc4MJCo3aTLOeav/IzN
 P+HYfJLNtdGtnQXDnMQDC76oYFlFh4iKLgf58uW/a/VbnkqQa5We5JSC4alSpQ==
X-Gm-Gg: ASbGncv12KQdrSEWHAf7YGWxBYpCHqWE+DowZ16hMS4DWlqF4rdcPEVpdYOnREF6ohL
 KsHcYn87jKvK/w2eU5YFVI/99K3i6NiTqe9RI7q7cvlwAOgNp+ipI9Y+exMpp5D0o4n8s7j/73V
 fRQGkvM5rTEP73JMhDyy37JR+IIhbGawQDhAen4bBjxvlG/+Af4+L3grOQEuM3Er9xLY1TamTAS
 /FY3/xroWOj+d9YCsSDI34GOaJ6oQTUnctA8cYPVSDx8aP7DbCAQsfP/eqNuDgBQVH4WXEIJJr3
 b7Mqq0qcYj8NjzWhXrR+XB4ULx/u+aeIhKG1JO1vBTpLsyUz+Xg8hfMPK2IRQ8gB
X-Google-Smtp-Source: AGHT+IHw9g2Y7sjwEzZUw4WOY1k7Uu/+E3UELtlX+ZkqOwVQ6vdhZVbtzl6Jhi7BuHGW5vk/nGph5A==
X-Received: by 2002:a17:90b:520f:b0:2ff:4a8d:74f8 with SMTP id
 98e67ed59e1d1-3087bb3e870mr15918226a91.6.1745253156980; 
 Mon, 21 Apr 2025 09:32:36 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:36 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 11/11] vfio/igd: Update IGD passthrough documentation
Date: Tue, 22 Apr 2025 00:31:11 +0800
Message-ID: <20250421163112.21316-12-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421163112.21316-1-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1042.google.com
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

In previous commits, several changes were made to IGD passthrough:
* Legacy mode now requires the IGD to be Gen6–Gen9.
* OpRegion quirk is enabled by default.
* "etc/igd-bdsm-size" is set to 0 when guest firmware does not need to
  allocate Data Stolen Memory and write BDSM register.
Update the documentation to reflect these changes.

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 docs/igd-assign.txt | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index 3aed7956d5..eac31ea3dd 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -47,6 +47,7 @@ Intel document [1] shows how to dump VBIOS to file. For UEFI Option ROM, see
 
 QEMU also provides a "Legacy" mode that implicitly enables full functionality
 on IGD, it is automatically enabled when
+* IGD generation is 6 to 9 (Sandy Bridge to Comet Lake) 
 * Machine type is i440fx
 * IGD is assigned to guest BDF 00:02.0
 * ROM BAR or romfile is present
@@ -101,7 +102,7 @@ digital formats work well.
 
 Options
 =======
-* x-igd-opregion=[on|*off*]
+* x-igd-opregion=[*on*|off]
   Copy host IGD OpRegion and expose it to guest with fw_cfg
 
 * x-igd-lpc=[on|*off*]
@@ -123,7 +124,7 @@ Examples
 
 * Adding IGD with OpRegion and LPC ID hack, but without VGA ranges
   (For UEFI guests)
-  -device vfio-pci,host=00:02.0,id=hostdev0,addr=2.0,x-igd-legacy-mode=off,x-igd-opregion=on,x-igd-lpc=on,romfile=efi_oprom.rom
+  -device vfio-pci,host=00:02.0,id=hostdev0,addr=2.0,x-igd-legacy-mode=off,x-igd-lpc=on,romfile=efi_oprom.rom
 
 
 Guest firmware
@@ -156,6 +157,12 @@ fw_cfg requirements on the VM firmware:
    it's expected that this fw_cfg file is only relevant to a single PCI
    class VGA device with Intel vendor ID, appearing at PCI bus address 00:02.0.
 
+   Starting from Meteor Lake, IGD devices access stolen memory via its MMIO
+   BAR2 (LMEMBAR) and removed the BDSM register in config space. There is
+   no need for guest firmware to allocate data stolen memory in guest address
+   space and write it to BDSM register. Value of this fw_cfg file is 0 in
+   such case.
+
 Upstream Seabios has OpRegion and BDSM (pre-Gen11 device only) support.
 However, the support is not accepted by upstream EDK2/OVMF. A recommended
 solution is to create a virtual OpRom with following DXE drivers:
-- 
2.47.2



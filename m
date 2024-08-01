Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33537C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZT9y-0002Cx-HC; Thu, 01 Aug 2024 06:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZT9v-00025v-8u
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:35:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZT9t-0001VE-H6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZgChYS2EG1AkwtZ9ETv9vrNAjIozgjlnHtqpWXnDf8=;
 b=As56rv7Gwj8o2pW2JsqDxaxyvr5skwHWpofUD1qAXSxPA6gYugkZhMToGcpNUTG5dWEEdN
 nEi/AQjWzCSrexREvtHVqDu1REGq12tHis7x2WTjsnkApcZcG49W2dt6+ekBN1BKDyzvTb
 v+ZS5aoYdi8VC8WGYQK4XQckSHnpJLA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-xG6tBF_dPwymtTgK6VLRrA-1; Thu, 01 Aug 2024 06:35:43 -0400
X-MC-Unique: xG6tBF_dPwymtTgK6VLRrA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52f00bde210so7587398e87.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508541; x=1723113341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZgChYS2EG1AkwtZ9ETv9vrNAjIozgjlnHtqpWXnDf8=;
 b=Oo7F5w0pDe9bfwAPOvg7sDJDNfslXgCLycOspGVm+giS6iGO30pRfewJmhURpajOlh
 nBPxh0byEGSDUOIGU2RA+AINh6/91EbiMJCncVhqYrEBIAAg8/RxpiCmu1c+APWmlzun
 hTaYcggGGLU0/jM2E5c/URfs0o0md5SEdjvoukJV3g+lKouCc6SBWz/LBgdZVEkv6Z1m
 +6KDbPWIfOLMFRJBrqRkYGK3/c4kTIcuT5vA1EuqIBWL2/GfmKeipCqkH4XbPM9DDISr
 VNSGz6+5ubseZ6OiUME9iOTvoJ7dP2/9w2Q5sKALSKrc0IXl+0RLVEbUEmErYyMA8KqS
 mBIQ==
X-Gm-Message-State: AOJu0Ywnf93xqmokI5PCBCn5iWMi51PPnhXS8GPMfb63ALm9DVsrMC8J
 AZox+yQJZf4+r43/Y6UuyeFi49HRTglckv3jiJ/5yxv7yG3x8GFSmmHxU0aTbVk6EAJmMCxdu/r
 jXQPYXecRG8rXMuxho7/Tf1iCJh/DNJHNFQZIwlCkgXSbclCfWPtM6UDiGFtCta5/Pw3J22suB/
 7aflhGA4abgm2phlPbTJddjCQfuUWS8Q==
X-Received: by 2002:a05:6512:1c9:b0:52c:d905:9645 with SMTP id
 2adb3069b0e04-530b61b1939mr1309701e87.13.1722508541296; 
 Thu, 01 Aug 2024 03:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE48tr90YUYBu4ys1STKcxPdicKbn+GBwJwau630qyTfzaNLYg/jZ5l1LKdEnl+3qg0ss3Wqg==
X-Received: by 2002:a05:6512:1c9:b0:52c:d905:9645 with SMTP id
 2adb3069b0e04-530b61b1939mr1309656e87.13.1722508540409; 
 Thu, 01 Aug 2024 03:35:40 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac65783621sm10105717a12.89.2024.08.01.03.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:35:33 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:35:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 02/19] Revert "docs: Document composable SR-IOV device"
Message-ID: <e57030e8dc071424b0fc35c0e0cf2898e53d5e81.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit d6f40c95b35bd380340b698e4306704fe22a5d68.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS           |  1 -
 docs/system/index.rst |  1 -
 docs/system/sriov.rst | 36 ------------------------------------
 3 files changed, 38 deletions(-)
 delete mode 100644 docs/system/sriov.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 72b3c67360..e34c2bd4cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2011,7 +2011,6 @@ F: hw/pci-bridge/*
 F: qapi/pci.json
 F: docs/pci*
 F: docs/specs/*pci*
-F: docs/system/sriov.rst
 
 PCIE DOE
 M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
diff --git a/docs/system/index.rst b/docs/system/index.rst
index 718e9d3c56..c21065e519 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -39,4 +39,3 @@ or Hypervisor.Framework.
    multi-process
    confidential-guest-support
    vm-templating
-   sriov
diff --git a/docs/system/sriov.rst b/docs/system/sriov.rst
deleted file mode 100644
index a851a66a4b..0000000000
--- a/docs/system/sriov.rst
+++ /dev/null
@@ -1,36 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0-or-later
-
-Compsable SR-IOV device
-=======================
-
-SR-IOV (Single Root I/O Virtualization) is an optional extended capability of a
-PCI Express device. It allows a single physical function (PF) to appear as
-multiple virtual functions (VFs) for the main purpose of eliminating software
-overhead in I/O from virtual machines.
-
-There are devices with predefined SR-IOV configurations, but it is also possible
-to compose an SR-IOV device yourself. Composing an SR-IOV device is currently
-only supported by virtio-net-pci.
-
-Users can configure an SR-IOV-capable virtio-net device by adding
-virtio-net-pci functions to a bus. Below is a command line example:
-
-.. code-block:: shell
-
-    -netdev user,id=n -netdev user,id=o
-    -netdev user,id=p -netdev user,id=q
-    -device pcie-root-port,id=b
-    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
-    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
-    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
-    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
-
-The VFs specify the paired PF with ``sriov-pf`` property. The PF must be
-added after all VFs. It is the user's responsibility to ensure that VFs have
-function numbers larger than one of the PF, and that the function numbers
-have a consistent stride.
-
-You may also need to perform additional steps to activate the SR-IOV feature on
-your guest. For Linux, refer to [1]_.
-
-.. [1] https://docs.kernel.org/PCI/pci-iov-howto.html
-- 
MST



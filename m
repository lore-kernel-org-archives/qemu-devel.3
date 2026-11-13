Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E65606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packetfive-com.20260707.gappssmtp.com header.i=@packetfive-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EHlcTAlZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRpdj-0002Gy-3e; Fri, 13 Nov 2026 06:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xRpdh-0002Fy-QZ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 06:40:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xRpdf-0006Ag-Ab
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 06:40:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so6267265e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 03:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20260707.gappssmtp.com; s=20260707; t=1794570013; x=1795174813;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l1DUBVpv1ibaPiCtKUFZlfZA+mz+/aPxuc98DTQde80=;
 b=EHlcTAlZFwAWnqd9yfXIg3wJiwNE618B3m20tAOwKBdhV21vJZ4jNQohOJUeed94j2
 GbIYYnSsRPmVQ7YJO6dit1VWozBWDKqGjhNjPGb2f/Uq6u6/p7WvZ8UpFRZA9VcFmVtj
 zDsmYhC++KUU+0JLfpXiCDMg9i9iAYyRa+x2V7P1vLt5VGEfVmrdojtaeSMcKYd2Ezr/
 FVhMtAxO6J+DkEGVap7KaOIDXplnmPKCmqIeE2DcSAtvYAQ5cZuLgWXDDxyN+KUbLYtx
 mJupoPb1Uip9TvIetgQeaaoDiGRg7SyIln0YoUa3gZ/2QlSwPD1p+lwnSMp3xwtyw7Af
 5IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794570013; x=1795174813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l1DUBVpv1ibaPiCtKUFZlfZA+mz+/aPxuc98DTQde80=;
 b=Ad3Q381He4PvkCn5kQua0A6xQoDeYYla+uKbyRJxlTwl8diEETjxm46saiS3LNe3Bq
 G1Iho37VsuY96Weu4nxnYWhD2DlcWIFFF1DCjJFWXEaVoLC8aitDzG3zl1kZKZFos0hJ
 ru+GZZRfkLbGmnwZFbObFnGiqcrkyp3BINQp2sXXYpyg0b1wiEKbklMiJD/zJRCCYfsI
 3K3dnW4AmUGbWT31J3SZXzNtONnHavOxIWNzMkAsCVvgMMtHaSbCe3WUFM2MMIXmrejP
 dapXjsrn1EyeVeglTiOsd+XtdiXH8I13H/05LwS0J8436LcaKIt63EqeDQkzI2qyr8hU
 5Vhg==
X-Gm-Message-State: APuU4Z8IJcIi+HnVwA/N6H90HHOcIMXFmY8/1kUkLKU0tVkcQGi7onBf
 yMyGNF8p2zdXSGhgNZoygVMeq7u47co3dDpg9mTkfGJP/nlDcHZ18d/i/NjIVIE3gAegV41UpmM
 N+Rp+EeT5eQ==
X-Gm-Gg: AYBFou0Lg+5XFcOG0XVgHbzvuhEl3Op1BmUv029YaldRmdAvSZPs9ZCY1THJE/QzQeS
 ShVFS2WX4QzVXVNJv2JGcUeO8eYrJJPM9cm4R6bRpWZXKYMJs6WNbnrSxnCYM6nTavMEphlFeRp
 cP/OU/+c/HpRkcvAoDDu7qWtlHdwWV0RccGpjCAXNcvcQBnCT1zlhKN8dNPb72Wme45q9NJQ8Yy
 vF7ScUM2fHtx7aflgthLzQkm7F5vL2pZhKPsMhMMSsEUObvo9hdecK0xxrH9y3Q567XzzOvpOGw
 5w9LBiYc6qR0siufJDGLj9gb+S+BeLoODMKm2Rsy/VARp0WHMhNertUsQdBDOsWB3Xyvy2il9dg
 zsHkhBceWb1l1gvD3lBFOHmL2xG+1/weeCioxefnmbGwgAo+XOsfvK0oi4swyuTYlHA3AtquUEn
 gYfO1JJjAQWfJYdsczLFQw+WisRw77cldmrzr5pomPgEdkMwxIw+a/LeTmNkt01jzC6ZDcSqbZw
 1bQ4RKK8CG6N7vBuoFoW6kGtjNKbkMMJsjABSCRYG9YPGzQODs+XWJaCtwsynr0Z6AiHeL+rHA8
 i99A7k1KSyLhUYJdOaPITO3eDLhAHla9v/fvE7hrwAzpjw==
X-Received: by 2002:a05:600c:c0c5:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4bb55a6602amr35392955e9.9.1794570012900; 
 Fri, 13 Nov 2026 03:40:12 -0800 (PST)
Received: from node-dev.home ([2001:bb6:1895:f400:ddc3:8ff5:cdac:cae])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae4414sm58637495e9.9.2026.11.13.03.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 03:40:12 -0800 (PST)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Weqaar Janjua <weqaar.janjua@packetfive.com>
Subject: [PATCH v4] docs/specs/pci-ids: Reserve IDs for Cnuas vfio-user devices
Date: Fri, 13 Nov 2026 11:39:39 +0000
Message-ID: <20261113113939.3687534-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::329;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reserve 1b36:0017 for the Cnuas virtual RDMA network adapter and
1b36:0018 for the CnuasGPU virtual accelerator. Both are PCIe devices
implemented outside QEMU as vfio-user servers and attached with
"-device vfio-user-pci". Their register interfaces are documented at
the links in the table.

Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
---
v4:
- Dropped the CnuasNIC and CnuasGPU device models and their qtests
  (v3 patches 2, 3, 5 and 6). As Akihiko suggested, the devices move
  out of tree as vfio-user servers in the Cnuas project.
- Merged the two ID patches (v3 patches 1 and 4) into this one
  documentation patch and dropped the include/hw/pci/pci.h defines,
  since no QEMU code uses them now.
- Linked the device specifications instead of in-tree docs.

v3: https://lore.kernel.org/qemu-devel/20260929202358.725310-1-weqaar.janjua@packetfive.com/

 docs/specs/pci-ids.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 74460bb19e..26137b11bf 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -109,6 +109,12 @@ PCI devices (other than virtio):
   PCIe Upstream Switch Port (``-device pcie-upstream-port``)
 1b36:0016
   PCIe Downstream Switch Port (``-device pcie-downstream-port``)
+1b36:0017
+  Cnuas virtual RDMA network adapter (vfio-user device, out of tree),
+  https://cnuas.io/cnuas/docs/datasheets/CnuasNIC_Datasheet/
+1b36:0018
+  CnuasGPU virtual accelerator (vfio-user device, out of tree),
+  https://cnuas.io/cnuas/docs/datasheets/CnuasGPU_Datasheet/
 
 All these devices are documented in :doc:`index`.
 
-- 
2.43.0



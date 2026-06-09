Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D28DCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWw0y-0001Cb-8b; Tue, 09 Jun 2026 08:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wWtxj-000664-In
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:45:42 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wWtxh-0005pM-Hi
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:45:39 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260609104535epoutp0223f1950da2416e52877d51475161a610~3Y9LqxAFk2725327253epoutp02C
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 10:45:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260609104535epoutp0223f1950da2416e52877d51475161a610~3Y9LqxAFk2725327253epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1781001935;
 bh=jIahGxVrHix7BsYtz5UoC9vsS7ivK+HEKtPzcVjyb0o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P8wvDtyoVTVifaa0peeZc3a2YbUZyI1UoU0okqfQdKAYBSdu4fCvKJQVpF5cC54Rj
 Zl4cgm79GoQZY0wVVNb1MaOicc9g7ufurIOl1+HbLAuHH+JcL96oa5FkWqbNOawkGn
 uDjGBkPhhKaj2sq+9MpM/tAqIGfAnUVNXcazUlKQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20260609104534epcas5p3030dfc01d01081fc1a4863f303080048~3Y9LVaxB_1375213752epcas5p3o;
 Tue,  9 Jun 2026 10:45:34 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4gZQYB13wbz6B9m7; Tue,  9 Jun
 2026 10:45:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20260609104533epcas5p2b80ad53ed807018b3bb4316e4984f89a~3Y9KNcdAB0412104121epcas5p2h;
 Tue,  9 Jun 2026 10:45:33 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260609104531epsmtip128242981e16a2a3d2eb67e16690c8c80~3Y9IqBKnV2355923559epsmtip1o;
 Tue,  9 Jun 2026 10:45:31 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com
Cc: arun.george@samsung.com, vikash.k5@samsung.com, s.neeraj@samsung.com,
 shrihari.s@samsung.com, dongjoo.seo1@samsung.com, dave@stgolabs.net,
 gost.dev@samsung.com
Subject: [RFC 8/8] cxl: Add documentation for UIO-enabled CXL devices
Date: Tue,  9 Jun 2026 16:28:36 +0530
Message-Id: <20260609105836.3702787-9-shrihari.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609105836.3702787-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260609104533epcas5p2b80ad53ed807018b3bb4316e4984f89a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104533epcas5p2b80ad53ed807018b3bb4316e4984f89a
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104533epcas5p2b80ad53ed807018b3bb4316e4984f89a@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=shrihari.s@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Jun 2026 08:56:47 -0400
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

Add a command-line example demonstrating a topology with three CXL Type-3
devices connected via a switch. This example enables Unordered I/O (UIO) on
all ports and endpoints to illustrate the correct usage of UIO-related
properties.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 docs/system/devices/cxl.rst | 50 +++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 32b1b5d773..c39721b3f9 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -407,6 +407,56 @@ use HDM-DB for coherence, which requires operating in Flit mode::
   -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+Unordered I/O (UIO) Support
+---------------------------
+
+CXL 3.2 and PCIe 6.1 introduce Unordered I/O (UIO), which allows memory
+transactions to bypass strict ordering requirements, potentially improving
+performance for certain workloads. UIO support requires:
+
+1. **256-byte Flit Mode**: Enabled via ``x-256b-flit=on`` on all ports and devices
+2. **Streamlined Virtual Channel (SVC)**: A PCIe 6.1 extended capability that
+   provides dedicated virtual channels for UIO traffic
+
+The SVC capability defines two paths for UIO traffic:
+
+- **SVC3 (Mandatory)**: Dedicated VC for UIO traffic only (``x-uio-svc=on``)
+- **SVC4 (Optional)**: Shared VC for both UIO and non-UIO traffic
+  (``x-uio-svc-opt=on``)
+
+Both paths require 256B flit mode. The CXL Type 3 device uses the ``x-uio=on``
+property to advertise UIO capability, which is then reflected in the HDM decoder
+capability registers.
+
+**Note**: Per the CXL specification, downstream switch ports do not track UIO
+capability separately; only root ports and upstream ports maintain the UIO
+capability.
+
+An example of 3 type3 devices with volatile memory below a switch. All the devices
+and ports support Unordered IO (UIO) feature which requires Streamlined Virtual Channel
+(SVC) capability and Flit mode::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
+  ...
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=rp13,chassis=0,slot=2,x-uio-svc=on,
+   x-uio-svc-opt=on,x-256b-flit=on,x-speed=64,x-width=32 \
+  -device cxl-upstream,port=2,sn=1234,bus=rp13,id=us0,x-uio-svc=on,
+   x-uio-svc-opt=on,x-256b-flit=on,x-speed=64,x-width=32 \
+  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4,
+   x-uio-svc=on,x-uio-svc-opt=on,x-256b-flit=on,x-speed=64,x-width=32 \
+  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5,
+   x-uio-svc=on,x-uio-svc-opt=on,x-256b-flit=on,x-speed=64,x-width=32  \
+  -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6,
+   x-uio-svc=on,x-uio-svc-opt=on,x-256b-flit=on,x-speed=64,x-width=32  \
+  -object memory-backend-ram,id=target-mem1,size=512M \
+  -object memory-backend-ram,id=target-mem2,size=512M \
+  -object memory-backend-ram,id=target-mem3,size=512M \
+  -device cxl-type3,id=mem1,bus=swport0,volatile-memdev=target-mem1,x-uio=on,x-256b-flit=on,sn=1233 \
+  -device cxl-type3,id=mem2,bus=swport1,volatile-memdev=target-mem2,x-uio=on,x-256b-flit=on,sn=1234 \
+  -device cxl-type3,id=mem3,bus=swport2,volatile-memdev=target-mem3,x-uio=on,x-256b-flit=on,sn=1235 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
+
 A simple arm/virt example featuring a single direct connected CXL Type 3
 Volatile Memory device::
 
-- 
2.34.1



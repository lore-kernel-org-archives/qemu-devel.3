Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75EBC61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz8pl-0003zV-3N; Wed, 26 Aug 2026 04:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8pj-0003z2-Vl
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:18:07 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wz8ph-0003B5-W1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:18:07 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260826081803epoutp017f5de66179fb1944f9384955a21405e5~PTQo0vsh60680206802epoutp01a
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 08:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260826081803epoutp017f5de66179fb1944f9384955a21405e5~PTQo0vsh60680206802epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787732283;
 bh=XrfOd5I7yYuwIENwq0UACxZdyXsSMFVFj/pme2+Sch0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rSzDSm3cM8SYgbXZjIt4n9Qa/7hguBYwEeECfH6H04YhvLTQyQFGpXXzNS/IeTsjw
 6Lo+BdR7kRVFD62vLoVq3vZltGRSf6LazlY2kc10fOxnB1n4U69SXjyTJVioyTyMkI
 RQ4aFYDEv0FJbQ8kO+IS86PMkHRG8G3feS2Ry/Tg=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
 20260826081803epcas5p457ed91f467aaf7b7d456d970e0346e54~PTQoiHH181534315343epcas5p4Y;
 Wed, 26 Aug 2026 08:18:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4hVHZy6vwpz2SSKX; Wed, 26 Aug
 2026 08:18:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20260826052057epcas5p258d55156d7a23470f3b03941d90c5784~PQ2Aoai3T1272412724epcas5p2D;
 Wed, 26 Aug 2026 05:20:57 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260826052055epsmtip2b9df838429493c35d5759eeca1368ee7~PQ1-BAa5X1196711967epsmtip2D;
 Wed, 26 Aug 2026 05:20:55 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com
Subject: [RFC V2 10/10] cxl: Add documentation for CXL UIO support.
Date: Wed, 26 Aug 2026 11:04:10 +0530
Message-Id: <124323713.61787732282965.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826053410.1322176-1-shrihari.s@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260826052057epcas5p258d55156d7a23470f3b03941d90c5784
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260826052057epcas5p258d55156d7a23470f3b03941d90c5784
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
 <CGME20260826052057epcas5p258d55156d7a23470f3b03941d90c5784@epcas5p2.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=shrihari.s@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add a command-line example demonstrating a topology with three CXL Type-3
devices connected via a switch. This example enables Unordered I/O (UIO) on
all ports and endpoints to illustrate the correct usage of UIO-related
properties.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 docs/system/devices/cxl.rst | 47 +++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 32b1b5d773..378fb5b2c1 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -407,6 +407,53 @@ use HDM-DB for coherence, which requires operating in Flit mode::
   -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+Unordered I/O (UIO) Support
+---------------------------
+CXL 3.2 and PCIe 6.1 introduce Unordered I/O (UIO), which allows memory
+transactions to bypass strict ordering requirements, potentially improving
+performance for certain workloads. UIO support requires three coordinated
+features:
+
+1. **256-byte Flit Mode**: Enabled via ``x-256b-flit=on`` on all ports
+   and devices in the UIO path
+2. **Streamlined Virtual Channel (SVC)**: Enabled via ``x-svc`` on all ports
+   and CXL type3 device. SVC is a PCIe 6.1 extended capability
+   (PCIe 6.4 section 7.9.29) that provides dedicated virtual channels for
+   UIO traffic.
+3. **Device 3 Extended Capability**: Enabled via ``x-uio`` on CXL type3
+   device. Device3 is a PCIe 6.4 extended capability (PCIe 6.4 section 7.7.9)
+   that advertises a device's UIO requester/completer support.
+
+An example of 3 type3 devices with volatile memory below a switch. All the devices
+and ports support Unordered IO (UIO) feature which requires Streamlined Virtual Channel
+(SVC) capability, Device3 capability and requires operating in Flit mode::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
+  ...
+  -object memory-backend-ram,id=target-mem1,size=512M \
+  -object memory-backend-ram,id=target-mem2,size=512M \
+  -object memory-backend-ram,id=target-mem3,size=512M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=rp13,chassis=0,slot=0,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-upstream,port=2,sn=1234,bus=rp13,id=us0,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-downstream,port=3,bus=us0,id=swport2,chassis=0,slot=6,\
+         x-svc=on,x-256b-flit=on,x-speed=64,x-width=16 \
+  -device cxl-type3,id=mem1,bus=swport0,volatile-memdev=target-mem1,\
+         x-uio=on,x-svc=on,x-256b-flit=on,sn=1233 \
+  -device cxl-type3,id=mem2,bus=swport1,volatile-memdev=target-mem2,\
+         x-uio=on,x-svc=on,x-256b-flit=on,sn=1234 \
+  -device cxl-type3,id=mem3,bus=swport2,volatile-memdev=target-mem3,\
+         x-uio=on,x-svc=on,x-256b-flit=on,sn=1235 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
+
 A simple arm/virt example featuring a single direct connected CXL Type 3
 Volatile Memory device::
 
-- 
2.34.1




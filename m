Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4D606D802
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OAPrPy3U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOZSD-0007lf-8O; Wed, 04 Nov 2026 06:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1xOZS3-0007kS-70
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:46:47 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1xOZRy-000617-E1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:46:46 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20261104113804epoutp01da75b331863b115d991bd8558fa99fb4~k1JQTix8F3027130271epoutp01G
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20261104113804epoutp01da75b331863b115d991bd8558fa99fb4~k1JQTix8F3027130271epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793792284;
 bh=zmRKQpwya0WeDnkSLxH41WMnOGAOdo1z/9sxMtTqa8s=;
 h=From:To:Cc:Subject:Date:References:From;
 b=OAPrPy3U9DD/q4Zmn4QgcYU0ya99z9eegJ3uA442BIQaMIf1yIvyr/cnMFz2Lseho
 7ioRjNf5FeUerelLsFgO8uLm0+jzoO5Jy9on0tnUcgGFnljuNQT9vQs3dN9nfnZU5+
 n53yUJrbSHtGenjYqLcfxgrxk4Q4xP6YX7SARNh8=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20261104113803epcas5p2341017fcd80d69eead253b606b64cbb0~k1JPqDB111368413684epcas5p2e;
 Wed,  4 Nov 2026 11:38:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4jKNjR2Ftdz3hhT3; Wed,  4 Nov
 2026 11:38:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20261104113003epcas5p43fd57f95a6f4b1a0c6ee2a8b1ab8cad5~k1CQXdYBE1209212092epcas5p4P;
 Wed,  4 Nov 2026 11:30:03 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
 by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261104113000epsmtip1897ed5d551fbd717aefacc52fc6e28b6~k1CODHj-72358823588epsmtip14;
 Wed,  4 Nov 2026 11:30:00 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
 dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
 junjie.cao@intel.com
Subject: [PATCH qemu v1 0/8] hw/pci: hw/cxl: Add UIO support in CXL and PCIe
 stack.
Date: Wed,  4 Nov 2026 17:22:34 +0530
Message-Id: <1582071873.61793792283310.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261104113003epcas5p43fd57f95a6f4b1a0c6ee2a8b1ab8cad5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113003epcas5p43fd57f95a6f4b1a0c6ee2a8b1ab8cad5
References: <CGME20261104113003epcas5p43fd57f95a6f4b1a0c6ee2a8b1ab8cad5@epcas5p4.samsung.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=shrihari.s@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi All,

This is the v1 of the "UIO feature enablement in Qemu" series, a
follow up of RFC V2 [1] with the review comments addressed. The
series adds enumeration and configuration support
for the PCIe Unordered I/O (UIO) feature across the standard PCIe
and the CXL stack of QEMU, and establishes the foundation for the
OS to discover, negotiate and configure UIO capabilities on CXL
ports and devices.

UIO is a transaction layer enhancement that relaxes the strict
transaction ordering rules of PCIe and moves the ordering control
from the fabric to the requester. UIO, introduced from PCIe 6.1,
in CXL follows the CXL.io protocol, where a device sends read and
write requests directly to the HDM decoder of a peer .mem device
at the switch level and the host is bypassed in the data path. For
that, the requester, the completer and the intermediate ports of
the topology carry the UIO dependent capabilities:

    - 256-byte flit mode
    - Streamlined Virtual Channel (SVC) Extended Capability
    - PCIe Device 3 Extended Capability

In the example topology below, Dev A is the requester, Dev B and
Dev C are the completers, and the root port and the switch ports
sit in the data path as the intermediate ports:

      __________________________________________
     |                                          |
     |              CXL Host Bridge             |
     |              (Root Port/RC)              |
     |__________________________________________|
                         |
      ___________________|______________________
     |                                          |
     |               CXL Switch                 |
     |__________________________________________|
        |                  |                 |
     ___|____           ___|_____         ___|____
    |        |         |         |       |        |
    | Dev A  |         | Dev B   |       | Dev C  |
    | (Req)  |         |(Target) |       |(Target)|
    |________|         |_________|       |________|

With all the dependent capabilities enabled on Dev A and Dev B and
on the ports of the path between them, Dev A issues its CXL.io
read and write requests to the HDM decoder of Dev B on the UIO
virtual channel: the switch routes the requests from the
downstream port of Dev A to the downstream port of Dev B, and the
root port and the host bridge are bypassed in the data path.

V1:

    - x-256b-flit defaults to off on all port types, keeping the
      config space and migration state compatible.
    - x-uio is moved to the pxb-cxl host bridge; the CXL type 3
      device warns and leaves UIO disabled at realize time when
      x-uio is set without x-svc and x-256b-flit.
    - SVC validates the Protocol Selected field of a guest's
      Resource Control writes against the resource capability.
    - The Flit Status bit of the Link Status 2 register is derived
      again after a device reset, so it stays consistent with the
      Flit Disable bit of the Link Control register.
    - Series reduced from 10 to 8 patches; properties are defined
       in the patches that use them.

RFC V2:

    - The Device 3 capability is added to the PCIe stack and wired
      to the CXL type 3 device.
    - The UIO related DVSEC registers are added to the CXL stack.
    - UIO becomes a generic capability instead of being tied to the
      type 3 device.
    - The SVC capability is extended to the CXL type 3 device, and
      the x-svc and x-uio properties are added.

Contents
--------

New properties:

    - x-256b-flit: enables 256-byte flit mode signaling (Flit
                   Mode Supported, Flit Status), as an extension
                   of the implementation from Davidlohr Bueso's
                   patch series [2]. Accepted by all the ports
                   derived from PCIEPort and by the CXL type 3
                   device. Defaults to off.
    - x-svc: adds the SVC capability to a port or to the CXL
             type 3 device.
    - x-uio: carries the UIO capability. On the pxb-cxl host
             bridge it marks the root ports within the host
             bridge as UIO capable; a CXL root port advertises
             UIO when its parent host bridge carries x-uio and
             its own x-svc and x-256b-flit are set; the CXL
             type 3 device carries the UIO capability, with the
             Device 3 capability, when x-uio, x-svc and
             x-256b-flit are all set.

Patches:

1) Refactor the flitmode field from PCIESlot to PCIEPort and
   default the x-256b-flit property to off.
2) Move the x-256b-flit property from cxl_root_port to
   pcie_root_port.
3) Wire the UIO capability into the HDM decoder and DVSEC
   registers, and add the x-uio property to the pxb-cxl host
   bridge.
4) Add the PCIe Streamlined Virtual Channel (SVC) extended
   capability.
5) Wire the SVC initialization into the port realize functions.
6) Add the PCIe Device 3 extended capability.
7) Wire the SVC and Device 3 capabilities to the CXL Type 3
   device.
8) Add documentation for the UIO options with an example
   topology.

Testing:

Linux kernel enumeration on a q35 topology with a CXL switch and
three type 3 devices: SVC and Dev3 capability discovery, HDM
decoder UIO bits, flit mode status and the per-VC state of the
UIO enablement path.

Linux kernel series for this work is maintained separately and
follows later.

This series has been written on top of:

Base commit: 3c99db7705c1a885c795b7c14f751c7a3ba29ed8
Repository: https://gitlab.com/jic23/qemu
Branch: cxl-2026-01-09-draft

Future work:

Provide UIO requester capability to the CXL Type 2 device for E2E testing.

Thanks!

References
[1] https://lore.kernel.org/qemu-devel/1212772528.01787732102473.JavaMail.epsvc@epcpadp1new/
[2] https://lore.kernel.org/all/20251103195209.1319917-2-dave@stgolabs.net/

Shrihari E S and Dongjoo Seo (8):
      hw/pci: Refactor flitmode from PCIESlot to PCIEPort
      hw/pci: Move 'x-256b-flit' property from cxl_root_port to pcie_root_port
      hw/cxl: Wire UIO capability into HDM decoder and DVSEC registers
      hw/pci: Add PCIe Streamlined Virtual Channel (SVC) capability
      hw/pci: Wire SVC initialization into port realize functions
      hw/pci: Add PCIe Device3 capability support
      hw/cxl: Wire SVC and Dev3 capabilities to CXL Type 3 device
      cxl: Add documentation for CXL UIO support


 docs/system/devices/cxl.rst               |  54 +++++++-
 hw/cxl/cxl-component-utils.c              |  55 ++++++++-
 hw/mem/cxl_type3.c                        |  36 +++++-
 hw/pci-bridge/cxl_downstream.c            |  18 ++-
 hw/pci-bridge/cxl_root_port.c             |  37 +++++-
 hw/pci-bridge/cxl_upstream.c              |  26 ++++-
 hw/pci-bridge/gen_pcie_root_port.c        |   3 +
 hw/pci-bridge/pci_expander_bridge.c       |  17 ++-
 hw/pci-bridge/pcie_root_port.c            |  15 +++
 hw/pci-bridge/xio3130_downstream.c        |   6 +
 hw/pci-bridge/xio3130_upstream.c          |  19 +++
 hw/pci/meson.build                        |   2 +-
 hw/pci/pci.c                              |   7 ++
 hw/pci/pcie.c                             | 105 ++++++++++++++++-
 hw/pci/pcie_dev3.c                        | 111 ++++++++++++++++++
 hw/pci/pcie_svc.c                         | 185 ++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_component.h            |   2 +-
 include/hw/cxl/cxl_device.h               |   2 +
 include/hw/pci-bridge/cxl_upstream_port.h |   2 +-
 include/hw/pci/pci_bridge.h               |   1 +
 include/hw/pci/pcie.h                     |  11 ++
 include/hw/pci/pcie_dev3.h                |  26 +++++
 include/hw/pci/pcie_port.h                |   6 +-
 include/hw/pci/pcie_regs.h                | 100 ++++++++++++++++
 include/hw/pci/pcie_svc.h                 |  20 ++++
 25 files changed, 832 insertions(+), 34 deletions(-)
-- 
2.34.1



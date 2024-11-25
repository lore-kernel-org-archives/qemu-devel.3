Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD3ED3B7F5
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 09:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFVXW-0003bc-Ur; Mon, 25 Nov 2024 04:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1tFVXP-0003aa-Ah; Mon, 25 Nov 2024 04:37:47 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1tFVXK-0003uL-3L; Mon, 25 Nov 2024 04:37:47 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnbNxZRURnxoU1BA--.51636S2;
 Mon, 25 Nov 2024 17:37:29 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCH23dTRURnT9pZAA--.7191S3;
 Mon, 25 Nov 2024 17:37:24 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, jonathan.cameron@huawei.com,
 fan.ni@samsung.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 chenbaozi@phytium.com.cn, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v3 0/1] Sbsa-ref CXL Enablement
Date: Mon, 25 Nov 2024 17:37:08 +0800
Message-Id: <20241125093709.57204-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCH23dTRURnT9pZAA--.7191S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWdDg3QEXwABsJ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxtw43ZF1xtFy5tw15JryfCrg_yoWxCw4UpF
 1DK34SkFWkWry2krn3uw1UWr15uw1kAa98Jrn7G34jkFnFgrWvvrykt3WYva47Wr1UAFyU
 Xr1Dta40g3W2vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

v2 -> v3:
- create a new host bridge type: TYPE_SBSA_CXL_HOST
- CXL exclusive ECAM, PIO, MMIO32 & MMIO64 space in sbsa-ref
- combine all cxl infrastructure creating into one function

v1 -> v2:
- provide CXL exclusive MMIO32 & MMIO64 space
- hard coded two cxl root ports

RFC because
- Many contents are ported from Jonathan' patch on qemu virt design

- Less experience and not particularly confident in sbsa-ref address space design
  so this might be stupidly broken in a way I've not considered.

Background
==========
Currently the base CXL support for arm platforms is only on Jonathan's patches[1]
which have not yet merged into upstream. SBSA-REF can be more like a real machine,
thus the support of cxl could be meaningful.

This series leverages Jonathan's patches[1] to design [SBSA_CXL_CHBCR] and
[SBSA_CXL_FIXED_WINDOW] spaces for sbsa-ref layout. 

Regard to the burden of edk2 firmware, I try to build a static CEDT table and add
acpi0016, acpi0017 and other cxl relevant contents into acpi tables[2][3]. Hence it
doesn't need to communicate cxl contents via DT to edk2. 

CXL HOST design
===============
In previous version, the pxb-cxl-host with any cxl root ports and cxl endpoint devices
would occupy the BDF number of the original pcie domain resulting in the max available
pcie devices on sbsa-ref would decrease, which seems to bring a series of trouble. 

In this version, to avoid that problems, the new host bridge type is defined
(TYPE_SBSA_CXL_HOST). Actually, this new device could be considered as a prototype of
an independent cxl host bridge which combines gpex features(mmio windows & irq) and
pxb-cxl features(CHBCR) at meanwhile. If this could be work, we can just remove the
prefix of 'SBSA' and introduce it as a general qemu object on other boards.

For [SBSA_CXL_CHBCR], since this creates a default cxl host bridge (0001:00)
with two cxl root ports on sbsa-ref, the new memory layout places 64K space for
one hard coded cxl host bridge register regions in the sbsa-ref memmap. (Meaning
for now only two cxl type3 devices could be added on the cxl host)

And the memory layout provides separate space windows for the cxl host bridge in the
sbsa-ref memmap:
- 64K  CXL Host Bridge Component Registers (CHBCR)
- 64K  CXL_PIO
- 128M CXL_MMIO
- 256M CXL_ECAM
- 4G   CXL_MMIO_HIGH

CXL FIXED WINDOW design
=======================
For [SBSA_CXL_FIXED_WINDOW], in order to provide CFMWs on sbsa-ref, this extends 1TB
space from the hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory Window. 
- 1T   CXL_FIXED_WINDOW

0xA0000000000 is chosen as the base address of this space because of 3 reasons:
1) It is more suitable to choose a static address instead of that
implementation in virt, since a dynamic address space layout of
sbsa-ref is not appropriate for its original purpose as a reference
platform.

2) The Hotplug Memory address range should in the range of maximum
addressable range of sbsa-ref platform(0x10000000000-0x80ffffffffff).
It is satisfied the requirements of memory hotplug in linux kernel.

3) The start pfn of CFMW should exceed the reserved_pfn_range for
onlined numa node.

Usage of cxl on sbsa-ref
========================
With the 'create_cxl' and 'create_cxl_fixed_window', users don't need to input
'-device pxb-cxl' , '-device cxl-rp' and '-M cxl-fmw' parameters.

Thus, to run sbsa-ref with a cxl device could use:
qemu-system-aarch64 \
-object memory-backend-file,id=mem2,mem-path=/tmp/mem2,size=256M,share=true \
-device cxl-type3,bus=cxl.0,volatile-memdev=mem2,id=cxl-mem1 \

Incompatibility problem
=======================
Although the new cxl host bridge has been separated from the original pcie host, the
incompatibility problem of "-device qemu-xhci" is not resolved. Because the new device
to plug by qemu command would be enumerated at the largest domain(0001), for example,
if we add "-device qemu-xhci" to boot sbsa-ref with cxl, the lspci would show:

    root@ubuntu-jammy-arm64:~# lspci
    0000:00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
    0000:00:01.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
    0000:00:02.0 Display controller: Device 1234:1111 (rev 02)
    0001:00:00.0 PCI bridge: Intel Corporation Device 7075
    0001:00:01.0 PCI bridge: Intel Corporation Device 7075
    0001:00:02.0 USB controller: Red Hat, Inc. QEMU XHCI Host Controller (rev 01)
    0001:01:00.0 CXL: Intel Corporation Device 0d93 (rev 01)

    root@ubuntu-jammy-arm64:~# lspci -tv
    -+-[0001:00]-+-00.0-[01]----00.0  Intel Corporation Device 0d93
    |           +-01.0-[02]--
    |           \-02.0  Red Hat, Inc. QEMU XHCI Host Controller
    \-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
                +-01.0  Intel Corporation 82574L Gigabit Network Connection
                \-02.0  Device 1234:1111

Hence we should add "bus=pcie.0" when we want to plug some devices on the original
pcie bus, for example:
-device qemu-xhci,bus=pcie.0 \
or
-device nvme,serial=deadbeef,bus=pcie.0,drive=hdd \
-drive file=../disk/hdd.qcow2,format=qcow2,id=hdd,if=none \

So the result is:
    root@ubuntu-jammy-arm64:~# lspci
    0000:00:00.0 Host bridge: Red Hat, Inc. QEMU PCIe Host bridge
    0000:00:01.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
    0000:00:02.0 Display controller: Device 1234:1111 (rev 02)
    0000:00:03.0 USB controller: Red Hat, Inc. QEMU XHCI Host Controller (rev 01)
    0001:00:00.0 PCI bridge: Intel Corporation Device 7075
    0001:00:01.0 PCI bridge: Intel Corporation Device 7075
    0001:01:00.0 CXL: Intel Corporation Device 0d93 (rev 01)

    root@ubuntu-jammy-arm64:~# lspci -tv
    -+-[0001:00]-+-00.0-[01]----00.0  Intel Corporation Device 0d93
    |           \-01.0-[02]--
    \-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
                +-01.0  Intel Corporation 82574L Gigabit Network Connection
                +-02.0  Device 1234:1111
                \-03.0  Red Hat, Inc. QEMU XHCI Host Controller

I am looking for suggestions on if there are better ways to do it.

This series patches are here to hopefully some comments to guide me!

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
[2]: https://edk2.groups.io/g/devel/topic/rfc_edk2_patch_v3_0_1/109403423#
[3]: https://edk2.groups.io/g/devel/topic/rfc_patch_edk2_platforms_v3/109768222

Yuquan Wang (1):
  hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW

 docs/system/arm/sbsa.rst  |   4 +
 hw/arm/sbsa-ref.c         | 139 ++++++++++++++++++++++++++++++-
 hw/cxl/cxl-host-stubs.c   |   2 +
 hw/cxl/cxl-host.c         | 169 +++++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl.h      |  22 +++++
 include/hw/cxl/cxl_host.h |   5 ++
 6 files changed, 339 insertions(+), 2 deletions(-)

-- 
2.34.1



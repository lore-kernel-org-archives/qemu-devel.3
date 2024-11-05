Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241FED1267E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8H3L-0005FP-Tk; Tue, 05 Nov 2024 05:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1t8H31-0004sy-Hp; Tue, 05 Nov 2024 05:44:36 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1t8H2z-0003Tc-5a; Tue, 05 Nov 2024 05:44:31 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3l_D29iln3PM3AA--.5413S2;
 Tue, 05 Nov 2024 18:44:06 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3SXb09ilnmo9HAA--.23086S3;
 Tue, 05 Nov 2024 18:44:05 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com, marcin.juszkiewicz@linaro.org,
 ardb+tianocore@kernel.org, quic_llindhol@quicinc.com,
 peter.maydell@linaro.org
Cc: chenbaozi@phytium.com.cn, devel@edk2.groups.io, linux-cxl@vger.kernel.org,
 asa-dev@op-lists.linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v2 0/1] Sbsa-ref CXL Enablement
Date: Tue,  5 Nov 2024 18:43:45 +0800
Message-Id: <20241105104346.417102-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3SXb09ilnmo9HAA--.23086S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWcpJZAFkgAIsk
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZFW7GrWxZw1DJw17tFy7Jrb_yoWrWrWfpF
 s0kr43CF48Gw1akws3Z3W8Xr1rCwn5uayUCrn7Cryvkay5GrnYvrZ7Ka1Y9a47JryxGFy3
 AF1qywn5u3W5Z3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

v1 -> v2:
- provide CXL exclusive MMIO32 & MMIO64 space
- hard coded two cxl root ports

RFC because
- Many contents are ported from Jonathan' patch on qemu virt design

- Less experience and not particularly confident in sbsa-ref address space design
  so this might be stupidly broken in a way I've not considered.

Currently the base CXL support for arm platforms is only on Jonathan's patches[1]
which have not yet merged into upstream. SBSA-REF can be more like a real machine,
thus the support of cxl could be meaningful.

This series leverages Jonathan's patches[1] to design [SBSA_CXL_HOST] and
[SBSA_CXL_FIXED_WINDOW] spaces for sbsa-ref layout. 

For [SBSA_CXL_HOST], since this creates a default pxb-cxl (bus_nr=0xc0) bridge
with two cxl root ports on sbsa-ref, the new memory layout places 64K space for
one hard coded cxl host bridge register regions in the sbsa-ref memmap. 

According to above design, for now only two cxl type3 devices could be added on
the cxl host. 

With the 'create_pxb_cxl', users don't need to input '-device pxb-cxl' and 
'-device cxl-rp' parameters.

In addition, this support indepentent mmio32(32M) & mmio64(1M) space which are
enough for cxl components, because in this way the previous pcie mmio32/64 space
would not be divided and affected. 

However, with the pxb-cxl-host, any cxl root ports and cxl endpoint devices would
occupy the BDF number of the original pcie domain. Hence, the max available pcie
devices on sbsa-ref would decrease, which seems to bring a series of trouble. 
I'm looking for some comments on the problems and suggestions on if there are better
ways to do it.

For [SBSA_CXL_FIXED_WINDOW], in order to provide CFMWs on sbsa-ref, this extends 1TB
space from the hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory Window. 
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

Based on 'cxl_fmws_link_targets', this adds a new function
'sbsa_cxl_fmws_link_targets' for binding cfmws.target with the default
pxb-cxl-bus on sbsa-ref.

In addition, this also adds 'create_cxl_fixed_window_region' to support 
creating a static cfmw region on sbsa-ref, so users don't need to input
'-M cxl-fmw' parameter.

Thus, to run sbsa-ref with a cxl device could use:
qemu-system-aarch64 \
-object memory-backend-file,id=mem2,mem-path=/tmp/mem2,size=256M,share=true \
-device cxl-type3,bus=cxl.0,volatile-memdev=mem2,id=cxl-mem1 \

By the way, since the matched firmware correspond to this patch would allocate
pcie bus 0xc0 ~ 0xff to pxb-cxl-host, we should add "bus=pcie.0" when we want 
to plug some devices on the original pcie bus, for example:
-device qemu-xhci,bus=pcie.0 \
or
-device nvme,serial=deadbeef,bus=pcie.0,drive=hdd \
-drive file=../disk/hdd.qcow2,format=qcow2,id=hdd,if=none \

This series patches are here to hopefully some comments to guide me!

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
[2]: https://edk2.groups.io/g/devel/topic/rfc_edk2_patch_v3_0_1/109403423#
[3]: https://edk2.groups.io/g/devel/topic/rfc_patch_edk2_platforms_v2/109403456

Yuquan Wang (1):
  hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW

 docs/system/arm/sbsa.rst  |   4 ++
 hw/arm/sbsa-ref.c         | 122 +++++++++++++++++++++++++++++++++++++-
 hw/cxl/cxl-host-stubs.c   |   2 +
 hw/cxl/cxl-host.c         |   2 +-
 include/hw/cxl/cxl_host.h |   2 +
 5 files changed, 130 insertions(+), 2 deletions(-)

-- 
2.34.1



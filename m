Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E472C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 11:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujyNk-0001mm-41; Thu, 07 Aug 2025 07:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1ujyNh-0001ZT-Ao
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:01:57 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1ujyNf-0001N0-3R
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 07:01:57 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDHwDgbh5RoZQwRBQ--.94S2;
 Thu, 07 Aug 2025 18:59:39 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDHTwcSh5RoT_kKAA--.12934S3;
 Thu, 07 Aug 2025 18:59:30 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, rad@semihalf.com, peter.maydell@linaro.org,
 leif.lindholm@oss.qualcomm.com, graf@amazon.com,
 claudio.fontana@huawei.com, philmd@linaro.org, richard.henderson@linaro.org
Cc: chenbaozi@phytium.com.cn, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC QEMU PATCH v4 0/2] cxl: Support creation of a new CXL Host Bridge
Date: Thu,  7 Aug 2025 18:59:08 +0800
Message-Id: <20250807105910.240070-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHTwcSh5RoT_kKAA--.12934S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAPAWiTrgAFhgAAsZ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF4fuw1UCF4kCry5Xw48Xrb_yoW5Gr15pa
 1DKrWfCF4DKry3G3yfA3y7GF1rA395Ga15ur1xXw40yr92vF4DZrs7Ca1YvFyUWFWUCr18
 J3W7J3Z5W3W5Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

v3 -> v4:
- Simplify variable definitions (Jonathan)
- Fix some alignment and space problems (Jonathan)
- Include the header file for MemoryRegion (Jonathan)
- Rebased on 'Make the CXL fixed memory windows devices'
- Keep cxl_fixed_memory_window_config() static and remove its declaration in the header file
v2 -> v3:
- Update the commit message
- Fix some alignment and space problems
- Add a SPDX header for the new file
- Remove unnecessary comments
- Add CXL_HOST_BRIDGE config
v1 -> v2:
- Move the code of new bridge to hw/pci-host/cxl.c
- Fix and simplify some logic on handling the different bridge types

Background
==========
Currently the base CXL support for arm platforms is only on Jonathan's
patches[1]. Some platform like SBSA-REF can be more like a real machine,
thus the support of CXL could be meaningful. However, the pxb-cxl-host
realization on this platform seems not satisfying their requirements[2].

New CXL HOST design
===================
Defines a new CXL host bridge type (TYPE_CXL_HOST). This is an
independent CXL host bridge which combined GPEX features (ECAM, MMIO
windows and irq) and CXL Host Bridge Component Registers (CHBCR).

The root bus path of CXL_HOST is "0001:00", that would not affect the
original pcie host topology. In the previous, the pxb-cxl-host with
any CXL root ports and CXL endpoint devices would occupy the BDF
number of the original pcie domain. This new type provide a solution
to resolve the problem.

Remaining problems
==================
I tried to use 'object_resolve_path' but it could not work in
'cxl_fmws_link', so I used 'TYPE_DEVICE' to match that.

Reviewing
=========
Welcome more PCI folks to review this patch, thanks a lot!

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
[2]: https://lists.nongnu.org/archive/html/qemu-arm/2024-11/msg00522.html

Yuquan Wang (2):
  pci-host/cxl: Support creation of a new CXL Host Bridge
  hw/pxb-cxl: Rename the pxb cxl host bridge

 hw/cxl/cxl-host.c                     |  56 +++++++---
 hw/pci-bridge/pci_expander_bridge.c   |   8 +-
 hw/pci-host/Kconfig                   |   4 +
 hw/pci-host/cxl.c                     | 146 ++++++++++++++++++++++++++
 hw/pci-host/meson.build               |   1 +
 include/hw/cxl/cxl.h                  |   7 +-
 include/hw/pci-host/cxl_host_bridge.h |  24 +++++
 7 files changed, 229 insertions(+), 17 deletions(-)
 create mode 100644 hw/pci-host/cxl.c
 create mode 100644 include/hw/pci-host/cxl_host_bridge.h

-- 
2.34.1



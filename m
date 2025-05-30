Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AADC5B552
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 10:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKx3k-0004jk-Nm; Fri, 30 May 2025 06:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1uKx3h-0004iw-TP
 for qemu-devel@nongnu.org; Fri, 30 May 2025 06:33:53 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1uKx3f-0003FV-EB
 for qemu-devel@nongnu.org; Fri, 30 May 2025 06:33:53 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBHzRSBiTloQXbZAg--.22163S2;
 Fri, 30 May 2025 18:33:37 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3iyWAiTlo1VtFAA--.9604S3;
 Fri, 30 May 2025 18:33:36 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: chenbaozi@phytium.com.cn, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 wangyuquan <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v2 0/2] cxl: Support creation of a new CXL Host Bridge
Date: Fri, 30 May 2025 18:33:18 +0800
Message-Id: <20250530103320.534173-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3iyWAiTlo1VtFAA--.9604S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAGAWg4uXAE3gAFsA
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tw15AF47XF15tF1Uury8Krg_yoW8AFWUp3
 WqgryfAr4kKry2ya1fA3y7JF4rArs5Wa15CF1xuw10yryUtF4DJrn7Ca1YvFyUCayUZr13
 J3Z8JF1kW3WUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

v1 -> v2:
- Move the code of new bridge to hw/pci-host/cxl.c
- Fix and simplify some logic on handling the different bridge types

Background
==========
Currently the base CXL support for arm platforms is only on Jonathan's
patches[1]. Some platform like SBSA-REF can be more like a real machine,
thus the support of cxl could be meaningful. However, the pxb-cxl-host
realization on this platform seems not satisfying their requirements[2].

New CXL HOST design
===================
This work defines a new cxl host bridge type (TYPE_CXL_HOST). This
could be considered as a prototype of an independent cxl host bridge
which combines gpex features (ecam, mmio windows & irq) and CXL features.

The root bus path of CXL_HOST is "0001:00", that would not affect the
original pcie host topology. In the previous, the pxb-cxl-host with
any cxl root ports and cxl endpoint devices would occupy the BDF
number of the original pcie domain. This new type provide a solution
to resolve the problem.

Remaining problems
==================
I tried to use 'object_resolve_path' but it could not work in
'cxl_fmws_link_targets', so I used 'TYPE_DEVICE' to match that.

Yuquan Wang (2):
  hw/pxb-cxl: Rename the pxb cxl host bridge
  pci-host/cxl: Support creation of a new CXL Host Bridge

 hw/cxl/cxl-host-stubs.c               |   2 +
 hw/cxl/cxl-host.c                     |  66 +++++++++---
 hw/pci-bridge/pci_expander_bridge.c   |   8 +-
 hw/pci-host/cxl.c                     | 145 ++++++++++++++++++++++++++
 hw/pci-host/meson.build               |   1 +
 include/hw/cxl/cxl.h                  |   7 +-
 include/hw/cxl/cxl_host.h             |   2 +
 include/hw/pci-host/cxl_host_bridge.h |  25 +++++
 8 files changed, 234 insertions(+), 22 deletions(-)
 create mode 100644 hw/pci-host/cxl.c
 create mode 100644 include/hw/pci-host/cxl_host_bridge.h

-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FECCA0ED2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 03:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjs7h-00062F-45; Thu, 29 Aug 2024 23:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1sjs7c-00061l-6E
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 23:16:24 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1sjs7X-0002HZ-Kx
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 23:16:23 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBXN+h6OdFmXJ2AAg--.18065S2;
 Fri, 30 Aug 2024 11:16:10 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAnVLRyOdFmhaMpAA--.16473S3;
 Fri, 30 Aug 2024 11:16:03 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com, ardb+tianocore@kernel.org,
 quic_llindhol@quicinc.com, peter.maydell@linaro.org
Cc: devel@edk2.groups.io, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 chenbaozi@phytium.com.cn, wangyinfeng@phytium.com.cn,
 shuyiqi@phytium.com.cn, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH edk2-platforms 0/2] add basic support for CXL on sbsa-ref
Date: Fri, 30 Aug 2024 11:15:43 +0800
Message-Id: <20240830031545.548789-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAnVLRyOdFmhaMpAA--.16473S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWbQ2MkCDAAAsk
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kr1DZFy8urWfuw4fWFWDCFg_yoW8Cw4UpF
 Wa93WYkFWUCryIkw4fGa4Fvr4rCa1fZr4DCrsFqw18ua43tFn8Xr4ftF1xtF13JF93W39r
 WF18t34rCa1F93DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

RFC because
- Many contents are ported from Jonathan' patch on qemu virt design

- Bring plenty of PCDs values and modifying the original PCIE values

- Less experience and not particularly confident in ACPI area so this might be
  stupidly broken in a way I've not considered.

This series leverages Jonathan's patches[1] to add acpi0016 & acpi0017 objects into the
previous DSDT table of sbsa-ref. Since the acpi0016 implementation model on qemu side is
the pxb-cxl, this cxl Bus would share the MMIO space and ECAM sapce of PCIE Bus. Thus I
divide some space from PciMmio32、PciMmio64、PciExpressBar to support cxl-related values.

Based on the new CEDT definitions patch on edk2[2], this series adds a static Cedt.aslc to
support the [SBSA_CXL_HOST] & [SBSA_CXL_FIXED_WINDOW] space on sbsa-ref.

Since I was first developing this platform design for cxl, at the initial stage I only reserved 
one cxl host bridge (Bus: 0000:fe) and a cxl root port underneath (fe:00.0), therefore, only one
cxl device(ff:00.0)could be added by user on this cxl Bus.

Link:
[1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-2-Jonathan.Cameron@huawei.com/
[2]: https://edk2.groups.io/g/devel/topic/rfc_patch_0_1/108173029

Yuquan Wang (2):
  SbsaQemu: Add acpi0016 & acpi0017 objects into DSDT
  SbsaQemu: AcpiTables: Add CEDT Table

 Platform/Qemu/SbsaQemu/SbsaQemu.dsc           |  30 +-
 .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  20 +-
 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    |  70 +++
 Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl     | 410 +++++++++++++++++-
 Silicon/Qemu/SbsaQemu/AcpiTables/Mcfg.aslc    |   2 +-
 .../SbsaQemuPciHostBridgeLib.c                |   4 +-
 .../SbsaQemuPciHostBridgeLib.inf              |   3 +
 Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  34 +-
 8 files changed, 555 insertions(+), 18 deletions(-)
 create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc

-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CE3CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 02:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjr74-0006tg-Kf; Thu, 29 Aug 2024 22:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1sjr72-0006hS-Tn
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 22:11:44 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1sjr6x-0003Jw-II
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 22:11:44 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHySFQKtFmWVB+Ag--.18238S2;
 Fri, 30 Aug 2024 10:11:28 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3IbJOKtFmc50pAA--.1107S3;
 Fri, 30 Aug 2024 10:11:26 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com, marcin.juszkiewicz@linaro.org,
 gaoliming@byosoft.com.cn, michael.d.kinney@intel.com,
 ardb+tianocore@kernel.org
Cc: chenbaozi@phytium.com.cn, wangyinfeng@phytium.com.cn,
 shuyiqi@phytium.com.cn, qemu-devel@nongnu.org, devel@edk2.groups.io,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH 0/1] MdePkg/IndustryStandard: add definitions for ACPI 6.4
 CEDT
Date: Fri, 30 Aug 2024 10:11:16 +0800
Message-Id: <20240830021117.538954-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3IbJOKtFmc50pAA--.1107S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAMAWbQ2MkABwAFsp
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrtw4kWF4UWFWDCFWUZF45GFg_yoW3Arc_C3
 y29rykGw4IvFWaqayakF43trWxGFWUKr10yayrXF12gr98trsIgw18JayDZF1UuFyxtFs3
 Xw4DZrWSyr97ujkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
- Less experience and not particularly confident in edk2 area so this might be
  stupidly broken in a way I've not considered.

I am trying to support cxl on Qemu sbsa-ref platform, but it relies on CXL ACPI elements
within compiled UEFI flash instead of virt/i386 using qemu-build-Acpi tables. Thus I
create the header file CXLEarlyDiscoveryTable.h as the fundamental format for CEDT building
in edk2-platforms.

Yuquan Wang (1):
  MdePkg/IndustryStandard: add definitions for ACPI 6.4 CEDT

 MdePkg/Include/IndustryStandard/Acpi64.h      |  5 ++
 .../IndustryStandard/CXLEarlyDiscoveryTable.h | 69 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h

-- 
2.34.1



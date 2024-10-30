Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE4AD5CC8C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 10:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t665w-0000di-Jr; Wed, 30 Oct 2024 06:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1t665r-0000dK-8z
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:38:27 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1t665o-0007Zx-28
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:38:27 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwA3ioWQDCJn+r4fAg--.28158S2;
 Wed, 30 Oct 2024 18:38:08 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAXbXmODCJnZStAAA--.25600S3;
 Wed, 30 Oct 2024 18:38:07 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com, marcin.juszkiewicz@linaro.org,
 gaoliming@byosoft.com.cn, michael.d.kinney@intel.com,
 ardb+tianocore@kernel.org
Cc: chenbaozi@phytium.com.cn, qemu-devel@nongnu.org, devel@edk2.groups.io,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC EDK2 PATCH v2 0/1] MdePkg/IndustryStandard: add definitions for
 CXL3.1 CEDT
Date: Wed, 30 Oct 2024 18:37:12 +0800
Message-Id: <20241030103713.415432-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAXbXmODCJnZStAAA--.25600S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAOAWchPJEEcgABsS
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrtF1ftF17Ary8XrW5GryDJrb_yoWfJrb_C3
 yjgrykGw4IyFWSqFZIkF4UtrWxu3yUKr10ka98Xr1jgr98JwsIg3Z7JayDZFy7ZFyxtF4f
 Xw1DZryxtr929jkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
- Change to CXL Spec identification and description
- Add CXIMS, RDPAS and CSDS structures
- Fix code style problems

RFC because
- Less experience and not particularly confident in edk2 area so this might be
  stupidly broken in a way I've not considered.

I am trying to support cxl on Qemu sbsa-ref platform, but it relies on CXL ACPI elements
within compiled UEFI flash instead of virt/i386 using qemu-build-Acpi tables. Thus I
create the header file CxlEarlyDiscoveryTable.h as the fundamental format for CEDT building
in edk2-platforms.

Yuquan Wang (1):
  MdePkg/IndustryStandard: add definitions for CXL3.1 CEDT

 .../IndustryStandard/CxlEarlyDiscoveryTable.h | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 MdePkg/Include/IndustryStandard/CxlEarlyDiscoveryTable.h

-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DECC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 10:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdSAs-0005QQ-Id; Mon, 12 Aug 2024 06:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sdSAq-0005Pl-RA
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:21:12 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sdSAn-0002Eu-DB
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 06:21:12 -0400
X-ASG-Debug-ID: 1723458057-1eb14e31a830690001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id MoibKQUfrqoklLZ4 (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 12 Aug 2024 18:20:57 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 12 Aug
 2024 18:20:57 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e]) by
 ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e%7]) with mapi id
 15.01.2507.039; Mon, 12 Aug 2024 18:20:57 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 Aug
 2024 18:14:35 +0800
From: EwanHai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <xiaoyao.li@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
Subject: [PATCH v3 0/4] Add support for Zhaoxin Yongfeng CPU model and
Date: Mon, 12 Aug 2024 06:14:30 -0400
X-ASG-Orig-Subj: [PATCH v3 0/4] Add support for Zhaoxin Yongfeng CPU model and
Message-ID: <20240812101434.3804790-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 8/12/2024 6:20:56 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1723458057
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2295
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.128930
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=203.110.167.99;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch series introduces support for the Zhaoxin Yongfeng CPU model and
includes improvements and updates specific to Zhaoxin CPUs (including vendo=
r
"Centaurhauls" and "Shanghai"). The changes ensure that QEMU can correctly
identify and emulate Zhaoxin CPUs, accurately reflecting their functionalit=
y
and performance characteristics.

### Summary of changes

EwanHai (4):
  target/i386: Add support for Zhaoxin CPU vendor identification
  target/i386: Add CPUID leaf 0xC000_0001 EDX definitions
  target/i386: Introduce Zhaoxin Yongfeng CPU model
  target/i386: Mask CMPLegacy bit in CPUID[0x80000001].ECX for Zhaoxin
    CPUs

 target/i386/cpu.c | 131 ++++++++++++++++++++++++++++++++++++++++++++--
 target/i386/cpu.h |  41 ++++++++++++++-
 2 files changed, 167 insertions(+), 5 deletions(-)

v4 -> v3:
1. Added "For the kernel before v6.9 ..." for more accurately describe the
patch's impact on Linux Guests.

v3 link: https://lore.kernel.org/all/20240809094259.119221-1-ewanhai-
oc@zhaoxin.com/

v3 -> v2:
1. Added a more detailed description of the CPUID[0x80000001].ECX.CMPLegacy
bit masking.

v2 link:
https://lore.kernel.org/all/20240704112511.184257-1-ewanhai-oc@zhaoxin.com/


v2 -> v1:
1. Removed VIA-related information from the patch description to avoid
misunderstanding.
2. Replaced CPUID_VENDOR_VIA with CPUID_VENDOR_ZHAOXIN1 because the
"Centaurhauls" vendor ID now belongs to Zhaoxin.The previous CPUID_VENDOR_V=
IA
macro was only defined but never used in QEMU, making this change
straightforward.

v1 link:
https://lore.kernel.org/qemu-devel/20240625091905.1325205-1-ewanhai-
oc@zhaoxin.com/

### Known Issues
1. Issue with VMX Preemption Timer Rate on Yongfeng CPU:
   - Description: On Yongfeng CPUs, the VMX preemption timer rate is 128,
     meaning that bits 4:0 of MSR_IA32_VMX_MISC_CTLS should be set to 7.
     However, due to Intel's rate being 5, the Linux kernel has hardcoded
     this value as 5: `#define VMX_MISC_EMULATED_PREEMPTION_TIMER_RATE 5`.
   - Impact: This discrepancy can cause incorrect behavior in the VMX
     preemption timer on Yongfeng CPUs.
   - Workaround: A patch to correct this issue in the Linux kernel is
     currently being prepared and will be submitted soon.

--=20
2.34.1



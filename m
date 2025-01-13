Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D113EE7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 07:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXFDJ-0005jp-CY; Mon, 13 Jan 2025 02:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tXFCu-0005bq-S4
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 02:49:58 -0500
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1tXFCr-0003Wq-Ew
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 02:49:56 -0500
X-ASG-Debug-ID: 1736754577-086e2312d6ae3b0001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id izh1ZS6vXZDFl0hh (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 13 Jan 2025 15:49:37 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 15:49:37 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::1f6:1739:ec6a:3d64]) by
 ZXSHMBX1.zhaoxin.com ([fe80::1f6:1739:ec6a:3d64%7]) with mapi id
 15.01.2507.039; Mon, 13 Jan 2025 15:49:37 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 15:44:13 +0800
From: EwanHai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
Subject: [PATCH v5 0/4] Add support for Zhaoxin YongFeng CPU model and other
Date: Mon, 13 Jan 2025 02:44:09 -0500
X-ASG-Orig-Subj: [PATCH v5 0/4] Add support for Zhaoxin YongFeng CPU model and
 other
Message-ID: <20250113074413.297793-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 1/13/2025 3:49:35 PM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1736754577
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2394
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.135768
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

This patch series introduces a new CPU model, Zhaoxin YongFeng, which is
Zhaoxin's latest server processor. Additionally, it consolidates vendor nam=
ing
within QEMU: since both "  Shanghai  " and "Centaurhauls" now belong to
Zhaoxin, the logic has been updated to treat "Centaurhauls" as part of the
Zhaoxin vendor framework. Finally, the series addresses a CPUID compatibili=
ty
issue, ensuring correct detection of the CMPLegacy feature.

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


### Version History

v5 -> v4:
Removed the Known Issues section in the cover letter.The discrepancy betwee=
n
the Zhaoxin VMX Preemption Timer Rate and the value set by KVM was due to a
misunderstanding of the nested L2 preemption timer simulation logic on my p=
art.
In fact, since the preemption timer in nested L2 is entirely simulated in
software, the L1 Preemption Timer Rate does not need to match the hardware
value.

v4 link: https://lore.kernel.org/all/20241122062135.479200-1-ewanhai-
oc@zhaoxin.com/

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

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

--=20
2.34.1



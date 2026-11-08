Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CBB606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=Db48m5j4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1aI-0006eW-81; Sun, 08 Nov 2026 07:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1a8-0006dG-LW; Sun, 08 Nov 2026 07:01:10 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1a7-0000V3-0k; Sun, 08 Nov 2026 07:01:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A07QXDT0G6jB517Z3qfAOOeJ/NbMZ0ulpj3gsEmYcut3lJyq0qNYaWE5dtM1GLZRRbciyX1Rvieli+XjEXbaVr5pSeigHAFGAp88087BZ1OsZQQsWJNQejpCLf7BxZiDkvnZ+mqUeXivq3R5aM+XICWBp+KO0PwhtBqIbee26WPTMC6GPCaYYCAAobwbo0E1vVxrPuLBYooTxfUxDDOpHl/YMoBbGoRx29Hif8tmROezJ4/DRGwI2hSymQKLOH1sFMEHly1zHcR3BDaRTWRwcRQht6Yxva7npXgg/9g4XBG4KKuNC6UYR7v49gkiNrcsT1NRA9fgXh37FIiMVThDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te9DEJrWvQjPQxxcO1aWYCl4bBYuC9f/ahqP6LLwCy0=;
 b=JqZc8RhzPAxwYlyvDtJPJCXni0lmtgrpcpFvLGgBV8+zoEip++dEY0+wFGcV1ODQu5VT4NlM7yNAGafxJGVLDkxyU0cAf/rqya5ZOXetlLHi+F2LZITkFLYVtV1txK1aWfX/A96eQ6x05yzoBgWOSDuio2XMue3vXbMPr8NUp4L3E26M2jtxuL0oZKipooI+c0Lxs8n8H6J+EcO4I/x36XXfRrDBO1YHfuJaVwwbVYdTIlv9FyzsJc3yf1XgqLNZYutF6XISvy8q4+L2Zhj0Nwdeeyl6EpvLcyiQxt16gW0Zf5YtkqUCCEfvlVrMV7etI6BTz2fEtAc1YbKiTApNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te9DEJrWvQjPQxxcO1aWYCl4bBYuC9f/ahqP6LLwCy0=;
 b=Db48m5j4iCW02sZK4vNhkxfBhD69vqIkh6yxT8NTBFBckGipd1ifQY2nwUh3L5JFaRTALe37QZINbRYiC8ElwiCxsm4YFxOd/RdLCXc7Dj0LIXZLar3r2DMsspgYUjqZLWIvl30jNekgFwpoBIPcFbTgqBJHBFrF1gxTRWL12EEfuu3Gh2yKbY887yxg0V/CW4Fl+hJliXeS9hqVvFyAWPhbhpqREVyOJMq0dlMK/ymF4/kX9TFyBVVRUiqX+Y6ifcqZY29nPcRqdwMe0/Tb9+N5Z3dh1c9IWBAJVBIPK01BeYgtYBteBx90oZjSvZ12xYWAJV+Q6gn5RJfS7W9LPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:00:55 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:00:55 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 01/23] target/ppc: Correct PIR write access on e500 cores
Date: Sun,  8 Nov 2026 20:00:00 +0800
Message-ID: <20261108120034.1755008-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108120034.1755008-1-bin.meng@processmission.com>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To KL1PR02MB7144.apcprd02.prod.outlook.com
 (2603:1096:820:116::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|KUZPR02MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: dea1ae1e-de86-4e76-1aa2-08df3d8ff1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|261102123227099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Dgv9Yj+X+HU9lHO7DD+1+/VojGWCGIaaw4lei7K+xGnDGEP64JHgc5OpVTA/f0z0UJqLq1x3ChMRKD99hIqhFeyc/a0N5KJ81uOKfLutCeb2pCx2Y3pdofzZC7UijwXWlRHRnRQ+lsyiv8PuusReW3gySADJkHl1kEfAcCOoKqgBwTIG5VskX2RXP0kUlJ0SgzNy1UPuitIgf1v/BNzLKuntq/T/Ypc/H4iOYRwoLtzbAqVWWatAc6kSPtRwsaaXPNmls5ZNuG97YhkXOlLhFxPZQD4goXsIcbuUp/HB+MCIxv73LapPfnpd4RI70bzBdhmg/NdIlBsqv11zNAxxzfpihGepCazuOEZDGhCoiXuYPvCpatYIyKpQ5GdHyRiMRhYI/QU6C39cSSWsmEplTVhiF/PeViBnp5I/nxIv0fs7gfHn8GudWpBS9ntQ8bJET3YKHGmdwDpIJAv5qfKvBQ4VcqkRgsM/y1gVhBgn5zZe0qJoZlIOOB4t5qTi0ArGdxACsHayNdE9jkcboOSsaDeYnS7o8ZaUy/iZI2Gk4aIvRdrmvT+UBnwAi5HKGbtZ/vl3MyuLWGWYKivOZWBPnUI0vCcM+j4Bosj4EVOVLYvmsojAh/i3WMzH9Y9qp+9BZM8UrdeSWmvd0Wsb/iZGkqoR8EXA0FCwLvH64uOhDHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(261102123227099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v+Sre3QMfKGPh4dev/mrG2wMPvxSmUswpl2OjH47kittnF8RH4dWiHt+HVyF?=
 =?us-ascii?Q?XNphEeULrXnCVauXvfrY23bx9JiDQugyqu1lI59qBA06aJ3zX/mCSNNvL88q?=
 =?us-ascii?Q?Vb4mSU5se79N/cWiIi/tfpB4QI2pKyTl0Il3MGsYPlA4FMJdPEwQY+DeS4pI?=
 =?us-ascii?Q?AfMBPtCSjYIcx5wZbJfw1svKekjdBwaZ/x0Vrnzr0e3Rk8vnegJtIg78wJCj?=
 =?us-ascii?Q?AxNHtyC4FdQvUsKNJlVnJG/7tb6DiU/2uDBJttGNBFP2cYGk8WrEIYCp2cSn?=
 =?us-ascii?Q?cEluc0X7ALQF6Qkz2ii0t1jGKtOeOR27lS9w1gQfdtQICDtZF0CQOBuQDtB2?=
 =?us-ascii?Q?Xn8t0iqECvtceHvgh9lP7JpEusqwQkaeoM1JMXCm+9dvGaoxnF+DquKfKCJz?=
 =?us-ascii?Q?N5m4hZEf9+IyYJzrlp+QnQOi2QVxHLRaczQX4TVjQBwRKWUz/GPNBO1uczOQ?=
 =?us-ascii?Q?s5WLX55LP4f4JHr3C+Mwx/NbiAi3XDNKzWcXMX788ZZP7kGUlyr+zm9YnTzw?=
 =?us-ascii?Q?NPP5Dd4TT3lcLTcZCd2rxiBY4HCA9yffg88L8TASdnjRRSMsvl/aHEKpoRzF?=
 =?us-ascii?Q?ggmX3n5mR3EhVFP7sCnZfUQWd0xbPV5/AxihwGjAaJ8PoRXVC/VQdbKZ9S5k?=
 =?us-ascii?Q?WzCfg/aLZDq/UqEp+gT6XK4XsAiJc3gwTFheZZKIu/lPeO3Z4pGKpgr827p9?=
 =?us-ascii?Q?dAC58wMKYw3Un6Mu51wpWsGs7oQEqgRvfiSzJfqx7QTZkoKDcQUX1a62yAS8?=
 =?us-ascii?Q?L87owwDyZhpEpv7uz0lnINoJTBYgeiPO8TKhGZWJB/A4ZSmSkk5YwKL6Uec2?=
 =?us-ascii?Q?pYmY9w/3bbGCF4Ei88XCoxIO2tYEG6WqwmzReZGc+8DHU1lTY5A2I5TK0X/V?=
 =?us-ascii?Q?6j4ErK/3NjuVCbhWGE0ZBkLsV8C5h3E8gMGA5SvxuLlP0E2dZZu9BoPaJUP0?=
 =?us-ascii?Q?I5E/54f/vA9noFwA8Wy13NwLnyuN5SY/p1PF38sVOuXktYJR8J5dFYQ/jgWG?=
 =?us-ascii?Q?P4KzwkysV41pbexVs2ePq2X3dpwPULnrSqLrIjF7ldQhVGTVihjdpzhH97zt?=
 =?us-ascii?Q?Mt3KmZXPZ4zOrqWNENRSEglnwpE0cUDrfxUIAIvMYO2PODf4uMnGLkoU81LB?=
 =?us-ascii?Q?m34J9nq1pD8JwtFUTMFVgA96VKPqfkZAlZrZ5Kt9OR1F4cIyaLJZ715ghfQj?=
 =?us-ascii?Q?k7E/kl18RLTgkEf6Pu3BjnlhgEvlQUtcMBXnIFETEerfly/LZ+f2b1AScJzD?=
 =?us-ascii?Q?b+4Uaq/AeIF3JuIb3yDN+VBUoLzS97EN9YWX68mJzTemIcDJ9sC1A7Yhsx3s?=
 =?us-ascii?Q?1uMA9HxgsaW1dPPOYV1WjfXkR+ibltefjD9+Iy58MQXrBPF0SnV/gy2B6Wza?=
 =?us-ascii?Q?7J6vYyPR0Muggd8BOnwKAC/hXgUTaiag5eSCNe+uJy1r6WQyAtK57L5qSdc3?=
 =?us-ascii?Q?mBkzyUDiSz1fJcE7j5O3Q2U1tHsT34WxtqdHikQT9Z+Y5Wxl4XWxIm5XdL7W?=
 =?us-ascii?Q?E+hO1xQl5qOHe7medSfoctLXmD4H9QvVHaLw8nojulu2vPlARcHWWeHAVW3T?=
 =?us-ascii?Q?Rwi8JVV5SkC5gm/GMRRbn5cTz4kxunImEimMcaBMeBbOge+miLttk33MHyeN?=
 =?us-ascii?Q?xf4Bc32CYTsedr7RYO3peJi/k5reRILV1XjYhQsCjIY01aaswDhr7hkhdbzk?=
 =?us-ascii?Q?VgRPY0LFlN1Vdn230YwQiqJteXkdTD5OyZEAg0kIytBnnz1JPOIePlu+ZO+4?=
 =?us-ascii?Q?S/wSU4zd9F+vllm6RtmJrf61DY88Dc8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea1ae1e-de86-4e76-1aa2-08df3d8ff1a7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:00:55.5248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8QyS0QMJgIWza4OaJbf0gNMdlEurSzhzMn1E0U7ff/wp1Y4JavjpsH5CWwPU0p1p4H22tONq4K2pofvXBRjXk886nMMqgejIO6XRYVqtC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB9138
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The BookE PIR registration reuses the classic PowerPC 604 write
callback, which writes SPR 1023 and masks the value to four bits.
BookE PIR is SPR 286; on e500, SPR 1023 is SVR, so a PIR write can
corrupt SVR while leaving PIR unchanged.

The e500v1/e500v2 manual defines PIR as read-only. The e500mc, e5500
and e6500 manuals allow hypervisor software to write PIR after reset.
Reject writes on e500v1/e500v2 and use the generic 32-bit SPR write
callback on the other three cores to update the correct register
without the four-bit restriction.

Fixes: 76a66253e5e4 ("Great PowerPC emulation code resynchronisation and improvments")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference:
- E500CORERM (Rev.1), section 2.5.2
  https://www.nxp.com/docs/en/reference-manual/E500CORERM.pdf
- E500MCRM (Rev.3), section 2.9.7
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.9.7
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.9.8
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

(no changes since v1)

 target/ppc/cpu_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7f3036d903..9731bc0bfa 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2837,7 +2837,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
     /* Processor identification */
     spr_register(env, SPR_BOOKE_PIR, "PIR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_pir,
+                 &spr_read_generic,
+                 (version == fsl_e500v1 || version == fsl_e500v2) ?
+                     SPR_NOACCESS : &spr_write_generic32,
                  0x00000000);
 
     spr_register(env, SPR_BOOKE_SPEFSCR, "SPEFSCR",
-- 
2.53.0



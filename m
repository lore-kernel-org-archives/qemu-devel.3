Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D29C44509
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFNV-000769-49; Mon, 13 Jul 2026 08:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wjFNS-00075l-MJ; Mon, 13 Jul 2026 08:03:14 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wjFNR-0005bn-1D; Mon, 13 Jul 2026 08:03:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zsg7xe1obnD1/1WgwT6UPUzlYZgIIl/P9olPFcPpIHweEJmfSR/aWu8zE2/lOkySWLx8yJegauR/gROuFp2D18jtHohPLxnHQnS+riauMa8HTKwAY9n6oJHROxMLDd4sNdR79xLMEPUrepBAkQIa5ezWEEyHs5BrP6ftHjovyxaRjTdDm/Hpj9QEcjbnsDLTntfPljdIS4aHgEwQrTaCAZSdj/wAIDK4pOCHzJBI88OEke0AePXWRwc9uFq0nx/gK3Uz0p+03sdgPRGEdvOcNGEUyQF2eK8hD8bylxgfbtw6E5+4dmqlehfkGFMeqeeaZFhzaM9j03CNyYnQMdT5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltYObs53du3reAhlAkewgRUST/IgwpzhJT/qTN66TkI=;
 b=wrCubOcrJpidt3yZGjvcGoBIV1wCB9Z4aAD/sBpjSNyXQpn63f1zKcHZ6FW0c/JnkMDckx6eya/Nd7P9rE4aoWGrXzf+Rs830KhA4aEs1i2irU/IVc03pOObQqiEBUUpAX6+yDR92xN6QZL6haPoBgW4DS1FzDxQq74xOTECCffBYarfN0maK4Q2GBDbWpNHe9N9on6xnYm0Vl/FFA8vFPQja5Wc1zzmAtMTrOYx7pysHwOEQNgJlS2gynErC6iSO1jUzpNWCR+FJGsnkdKxw/L990LS6h1mhCtO1iGfyYyqSR25bM+8N2NS4WMy5C0nQyvjdY2Ju85uGyYzdF8HTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltYObs53du3reAhlAkewgRUST/IgwpzhJT/qTN66TkI=;
 b=QlPblmKNrpdp7BQ5STM+xg3pDP1WMp5ONzcmXA6/sRRHMwe3A4TodN+wV30Tu9i6GK5PIEK78Smb/IyPpVrtJQBxkBC5d6v6v6QaW/mlSRH1ooaD6BWUmwfR7rk9+7TL1zioExdwlJiEkRb+7hpOKQmMTHNgUe2XlJsHAaehzGV7znL/YKT+vxtZa7WLu6R6b97lGAeu4y3T2OVAC1twGmVrp/GWrx6DUOYHxT08YHcNpRd6/AzZ2PUKYkO1cwVcs4vlPeglyAMG7miOGlieYy8xPM7xjDIX6uJnTg5d0RlLU6lliOj5e6jPoObv6eg9dqYPE3q0y+2Qn1LbNpkOHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB6411.apcprd02.prod.outlook.com (2603:1096:101:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 12:03:02 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 12:03:02 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH] tests/functional/riscv64: sifive_u: Fix kernel command line
Date: Mon, 13 Jul 2026 20:02:44 +0800
Message-ID: <20260713120245.781959-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0073.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::6)
 To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e59cb10-f6db-422a-af4f-08dee0d6b05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|366016|376014|56012099006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: T39CVyvYXmEBWvskgmDSx2/Awfi0vC5kXHizL2y71Aa+2YiewixvaWXghrR6lqk1GslngOylvZQ9v1A6b3rk4per8b3ByrOPsPOP/gwedClW1zxtAclm7iFiEU32ggLFI0CIwG6tZNXeZD8F/n6ZwVEYBEBjIkVWBH95U+j1G/zs32Y+aiKacLz3F954Cf3D8G+pVUIbCLAbUfRRr02h+qmg9wwfvbUEcY3cOMxFSKjlrv6VKcwR+3xTRzoVjZf75dHI/2tdjgbMNIv7B2YvVRCYnUKkBg42FzfsUB2uX+d9mmhpk29+bt2b0RHs0qf/3QhYvtAEHXJuMTVbQV0YsGL1e3vYEIjk5TLlCdEsJW2UG+EmpGpPxJ0uxWBMkQjQxxfU90q0LMZB7Le5tu5ycpGuzfTYQg/rrHzPC+Owax/Ewr7AcEW3mb9sFCyPJdFTXOIZySso+jQwIJL8urd1NVMTKUVi6rrdnH0UrkEl753Uz4Y7LjI1+PQeMXzQwn6WrWSOyyRR5+nLrRte+cA69b/oMN6njUAg46yi6Lea3nykJbQKq/iRuBOLx0BstFzqj8GuI+jLA7Bdg72+pZV4xhvZrV3bWpIjf+269RyNe7D3PSaoYqk+SmWtSeTfmgkjrmT0VYqReNJJfZShH/1g6ZqqdBFc9+k32406zXKDRXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(366016)(376014)(56012099006)(5023799004)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rUNcFBO3HlUM7hRnBwBGxJp2cb6SPdlA5kOafCgnwBy5YTmp4+w6N7KG/zch?=
 =?us-ascii?Q?3KMwD+aIwoUZyLKO3SGNQwOnjC3juZEez4NmwuJFkWrxoWHhiPgyJVR0EtlK?=
 =?us-ascii?Q?flmoAQvgQzlXTPGkiQkBsI6/6IiRhgv5yekkjqvPESO2tD7FXZX1jYx5fRXm?=
 =?us-ascii?Q?RNHggeHtRqCcHKEL+l58DnWnapNt+4KQAscnUtcmRAYDJLYtXBzBo7WNG4dB?=
 =?us-ascii?Q?SiYA07/zNPdjQlwH2CElLwzGeZOwDaEi7SfI1zP3JFYxIZ8ZMKcjW+jXT4gf?=
 =?us-ascii?Q?py/raO2LIyyws8AyH/DZaNZQ1O776jqPrfXmc4lWYdJzy0FJdObwn2kjuqji?=
 =?us-ascii?Q?XlELBakwRsExSep6nJwa9IraYWze1mZ+bOiVWRjAjpHvzlRQh0FSfGH9T3tW?=
 =?us-ascii?Q?jt/9koX4ylp77cswrlm6tt6k1wYug7RHU2WOpQRA1NOL83RamJN9FlPbgY5C?=
 =?us-ascii?Q?g5f+S4ojY9XlnsYXB/BNAFm6mBe5BWEgYGeB+MNV6FaO8srsCKhCoTGKypkD?=
 =?us-ascii?Q?5stU5TeSul1BVUFo5oXukk7MEvTSMAgq17t0B0Rceei6kk3rtOYDFTHg0cw8?=
 =?us-ascii?Q?5iyJa1Hlivfob6Hgpv4FCRwBRWnj5W8UVkLsRhbKSufoRYXKs9urfc9ZuEGQ?=
 =?us-ascii?Q?nnBwbX51S7AEFg2FoAab/pNC5iZFcoDHIsmMLXT3yI4aHRidewW9iu5izCfi?=
 =?us-ascii?Q?17EpEynRT2G84oFN4ZaFGOSeGf8OhVlwQjY9UkAmeYLk7ma9zu1wb7VZwFvs?=
 =?us-ascii?Q?BUaLi3bjxB/5SLkpnAy6XDsbOTK8wvgu9HBPDeTaeUC3xcyiGV6IiMbqCES3?=
 =?us-ascii?Q?5F12SLpqT3oYjMKph96Kb5EfaS/OZN5BippziaeNuzX5Wm4XWL0H8D6actNw?=
 =?us-ascii?Q?shbrL1146Xbp4HikmexIA4U+a4f5y/8mVuIvYiGtnol/plKzFfYvQJm8NXGQ?=
 =?us-ascii?Q?aSlB8VLib2vUhoN440PiwmmfYzH8eta45OaLG+Ogj2psa0yPcNSdvUjvWAv0?=
 =?us-ascii?Q?IM13o8rsV6HUE5yvloaihjK4gshwzzPO0Q0PYf71DikiBkZEVCGs2YLJTDp+?=
 =?us-ascii?Q?1iVg/S8VIpexdn/NO+ZDuG6gOsWyHHsZsWWalEAOU8h4qY3EbFk99J8xfYpx?=
 =?us-ascii?Q?b4+0qF/P5fqhC4wrLQEsJ9+rqg3Rviu93h2bHaB1ZYpKCRBE6VtTTjQGQcEX?=
 =?us-ascii?Q?vOPpFMe8j+NSuLkF7usVF8vZF17rml+71KwcsMd5WwIL6g9PM2BTaMC8yX1k?=
 =?us-ascii?Q?2Kh7DQagbclpCQ4SA8CIwl9qV7++M7eE26WOJQjAgAZJOX4lj51YAsFWzfNR?=
 =?us-ascii?Q?cNjUU7zFzO1G7xStL341ZAiOYjWKnLUWXcGloiJoGkcUn+bEQHmG8AzpZ1Om?=
 =?us-ascii?Q?kG70B/KVKimc/yDAHrSFZHW6yABIDYUcKEqsFsHEGVo7i11DXx6NwOBLB1Sj?=
 =?us-ascii?Q?oDAEsSj6W50gc1U01rbnjhiiMKOt4MeLKn642bOoao50NpV4M7XdU68nEGSD?=
 =?us-ascii?Q?QjJIy5xjLs9wQlxePXiy98VV6zcr4PSTCUpqoGqqkt/yGAb2qqwuZaF8/yTe?=
 =?us-ascii?Q?rYgqVsLJ7E1eu83txhDQwkw3oGKA9N/QXqJey+Thw2wkiUhIKJnBdJpN16Hg?=
 =?us-ascii?Q?vi7mrS/FjNYk9CDSeD1XA5AStIhy0CiO2M17LKcJ9hRpY81atVyeXwUIYZyp?=
 =?us-ascii?Q?LHY8Q0UtDHFaDXsdV74lbRsjBMkMLG/6zL6HtYy9eOoB+nqBwwXt/IPheIQD?=
 =?us-ascii?Q?IrAHKPC8RU8ohROFmIT7tawuVBvAAAw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e59cb10-f6db-422a-af4f-08dee0d6b05b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:03:02.2174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOjzL3ixovO04/XkD3nXLHU+Fmw0aRxgo37hOEMXMqnIa8McJzeuff0DBY47HbPhEwTjuEFLtaTUEr1WgBb0dp1EPDUphcm5htzppALA74c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6411
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Build the complete kernel command line before adding it to the QEMU
arguments. This ensures the panic, noreboot and rootwait options are
passed to the guest.

Fixes: 7db162fa0138 ("tests/functional: Test SPI-SD adapter without SD card connected")
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 tests/functional/riscv64/test_sifive_u.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/riscv64/test_sifive_u.py b/tests/functional/riscv64/test_sifive_u.py
index 847f709da1..54a0f9c648 100755
--- a/tests/functional/riscv64/test_sifive_u.py
+++ b/tests/functional/riscv64/test_sifive_u.py
@@ -35,9 +35,6 @@ def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'earlycon=sbi console=ttySIF0 '
                                'root=/dev/mmcblk0 ')
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', kernel_command_line,
-                         '-no-reboot')
         if connect_card:
             kernel_command_line += 'panic=-1 noreboot rootwait '
             self.vm.add_args('-drive', f'file={rootfs_path},if=sd,format=raw')
@@ -46,6 +43,9 @@ def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
             kernel_command_line += 'panic=0 noreboot '
             pattern = 'Cannot open root device "mmcblk0" or unknown-block(0,0)'
 
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
         self.vm.launch()
         self.wait_for_console_pattern(pattern)
 
---
base-commit: a759542a2c62f0fd3b65f5a66ad9868201014669
branch: sifive_u

-- 
2.53.0



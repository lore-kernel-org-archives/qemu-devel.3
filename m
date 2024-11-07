Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6702AD5AE67
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 06:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8vrC-00030a-5I; Thu, 07 Nov 2024 01:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t8vr4-00030G-NV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 01:18:54 -0500
Received: from mail-me3aus01olkn2055.outbound.protection.outlook.com
 ([40.92.63.55] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1t8vr3-0005pQ-3v
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 01:18:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI3hIXeuZJ1uHoNe1wKqqKTx920Ru5CNgpf3ztvzbf29Vdh7Gc5DvAtJWowp6eIRJ39ZhLGgDFbfKXLavWItGMuqMNC9kBZG0IoqG/NFIAyBFDcFeeV0xAiuoaiZ2QESs//fvEfG1bZXXi2nT6xf7Vc7/fXg3fV8RgL4rAIRNCyUajiev8QoB6asF96Xetb/QCvqB4TeJM7EJcNC9nlHEypD1TZBG3tMxHrkZQpbwNe+QcOm4AogRY+LZynSz9QT3VQJdV7NXBui+m4YR5v0syO2vzjojfx8WVS6gPNSekCC0+nLxBMxSgs53lkQuBlSaN6GvQDaoqbgg1VvgP9noQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZW6/8nAN+mVmljO7sMbKac8QVuSaZP+8nzheJNdr8A=;
 b=tE7edk7AHLC04E8XG1oJmfyIk7Z1orD2eEZNdtowOsz0x1jBFWpjcNEah0FK3BfNkcGUt5I4QOk1A1kraxwLR4hWIzdAtu0U+R/WlxcE2r/59Y9vLTgGtVqeH5uY31u1yfYnEcAU6lWN/UYSMNT51GY12CvESOQ7c41LqUh0eBGPsvbQdR4mVylwZj4QSZBOoqSVSaOwglnHwZ7nci+eK3EoE9rxZTfOqWQ4HGO5mklY2pE6FIz1iALIq1SbQw7E9MecxUFyHDa5JUN5ZDY0Z9R5LF7ensGWEWPYdomCmV4sBgDSrHIOq4RH2LSluMwEGDCCaKAtuJWWkkfhjWiKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZW6/8nAN+mVmljO7sMbKac8QVuSaZP+8nzheJNdr8A=;
 b=KWTV47EaqwrRggqmtaWly65XBfKKHK/R3+6GjDgFTJjRJCCniTydFRzbm2V+BVJu6PuHpolrR7U6sO9az/WtcA4Pu92EBXUQ4fVTczBddHes4Zz9D5+WVEHojISWbH3VWRJj6crsGlLNo6l1NK+hQb621FYe/zs7xpJkieRsnbwfDCA4OCnVUt61o/4Uc8idIYNWUrqLjui1fBGZvGG2uJ5FOqnC7l7KSOk2TgmjFBH74zLMhtXtOpq2iw6p54VC3sCwBPWg3iV83viCnp0kW1D6Ob80Akll6ldKDtHw13pFBfMyKxOJgpkY7F0zGUi3D4Y/uYCZ9ttD07nWik0hkw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0308.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:260::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 06:13:41 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 06:13:40 +0000
From: Junjie Mao <junjie.mao@hotmail.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Junjie Mao <junjie.mao@hotmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] rust/pl011: Fix range checks for device ID accesses
Date: Thu,  7 Nov 2024 14:13:07 +0800
Message-ID: <SY0P300MB102644C4AC34A3AAD75DC4D5955C2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <20241107061307.13276-1-junjie.mao@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0308:EE_
X-MS-Office365-Filtering-Correlation-Id: b64e253b-9851-4874-6fbe-08dcfef352ef
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7092599003|8060799006|461199028|5062599005|5072599009|19110799003|15080799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UHEC4N6FcSkwZM+L00i503ypPugZmjOs7u/0mRS9SQD2M6y1bTveqddSZuql?=
 =?us-ascii?Q?5fg58R3gYwRdn2zR000kCwZj5zCWSEW/29eJy9sWrCIi0lWtFTJdxbZHQ8Kk?=
 =?us-ascii?Q?lM0vn8nA0kDoA9UxqrTmc7XCvXZX6XJsCCWhyk6+OPs90iMEF/7OR3LoLh+p?=
 =?us-ascii?Q?eAW5p/GkXAp/pGak4T2hMaYmfrDzWBTLYBzazbZ0XQdUdMS8NeE2Q1xjLMlB?=
 =?us-ascii?Q?rZPbjgR+Mot/NysCOGWFmPc4Q4F8LWMihLN7Xwcp6aJano36lS2hsCOw7KJ1?=
 =?us-ascii?Q?/V7ZVBvUTtEi39WSQKTW+lJq8NN1YqxzUy1veDCGEmY4j5tAy6/1dsk7iQSB?=
 =?us-ascii?Q?n/TZJV1dh9Zkx5ADjl5f6fP3oFgm6XeySknmxyWKRZs459+WM/wzKYGOAYNz?=
 =?us-ascii?Q?C6+KewJpFteR8WC2r14vAOX+5i/cZi5AGB57U127ul10ft1Jma1FDv5TE4/V?=
 =?us-ascii?Q?6iKLAheOISOFa0dLFm21bOL4yLXE3eXTCOgtHou3C+kgNU9smshyVsiYGZsQ?=
 =?us-ascii?Q?LRl4Kh8CYaBdOEVk52YAL2wW9grsxMNmO4aFWnsRKr5ZCDm4wADHjnV9A5VY?=
 =?us-ascii?Q?Q0hcRycRR+eGFyP0HnEyps17bgDc3SIldmcRlfrh6k8tmmnp2ZeY2vwMPUPy?=
 =?us-ascii?Q?pv6F6sEy0QKIBO2DtouBG3/w3Y86/8xIVpYpDAO2KQLUDEU+s62xrXrE3XLY?=
 =?us-ascii?Q?Qkz2PSE9Zlta9K2pGfrYHm0/CsQFxxF+yKAY7624tGUCPi3A031c84y1w1pw?=
 =?us-ascii?Q?SHyH6kOk7gVL0/SjlfvL3/LlapuN/BY3MMUnT3jKOF0/NDU4t/5zm7eoJ7Rr?=
 =?us-ascii?Q?waFt2pDyA1PZ1OIb/jjwdgfIGHCN0k57wWYh9HqA8uQwVO/BDXPvlOg8noeT?=
 =?us-ascii?Q?EFQ95oN8eKVUxl2+DAJsYctDSjeS4m/b4q6o6AnqzofxfoyVs2H8sn16e6gm?=
 =?us-ascii?Q?JA6t1RNA5hjeuBkhWRX/JOBTkG9GnE7DdMJGzO7xtnwbKlkIqZyJhgGN4KJu?=
 =?us-ascii?Q?eR+ew8IYvodIuRWe0YBO2wjYa1Q1K7U2S95IoEOU88b6Rbc6lzy5ir7W3ZP7?=
 =?us-ascii?Q?Rth48gZnIVMVcJfRATl7KE6xl/QGFrQVr+yqWJKy1tUpSxVNEFI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S2LmWA7ZzFXADv1HrwLIofOyHT2FDsELoY2jiQmExwqPTqV2aXuJUpcXluaf?=
 =?us-ascii?Q?CCoThyBsBsksVKDPmpEd6t1ObQGA4++LXGQzakO3fidxIR69y4/Ol4lHFWRo?=
 =?us-ascii?Q?PpMPalB3BBaWg4QQhSimZFrLwZwrtrxGcXq3ZpCt3IMQTvTL31t5eXxwSvrs?=
 =?us-ascii?Q?1CQcpWDtzRratfhrkTMA+dPMIV5R40AD7RNuYAaE4PFnGZH13YDnbENO5bzX?=
 =?us-ascii?Q?P40Az1ixHYJkSOIEULGCKXgForLr0SAGkdRiwbRoHseVKlgiQz/hpx5SqkLO?=
 =?us-ascii?Q?tDgnMYDHMIKRvRuSeqEEvvgjFgGJL0ukCMHcOYbCLTSWG8UHZVoQukD86Hqa?=
 =?us-ascii?Q?BI9iJZwfpKGEHwx7gv8DaabSJrm6R/YOm2OAlW0H3LBWkZSDBXiXAHhefAvN?=
 =?us-ascii?Q?e5LfEd519R7W5p73HQYja4momJDpaQRRskLRYAvBLQK5VdtGS26elWxxX/Ds?=
 =?us-ascii?Q?zanIWL+uquBC+WT/l12HfUD0zuIJhk7T9/ID4Hiw1yNBtgkUQrWZy0njRw7Y?=
 =?us-ascii?Q?J8mA+HhbuLm+Yst5M615mYBkOVqH+H9IUEgid9e+nILSqYt9iydBKSC88opF?=
 =?us-ascii?Q?LDZ3umrkmFYp02ee0CmmRY1HHnbRMp62BFYm4vkIJljhn+N+/UZ1Goobl2nQ?=
 =?us-ascii?Q?N7lcAp/AdNRtxDzpTI/0C8tT0+H5JmTM7fyYl6HTrPnZOyfilAQulTmBUtFg?=
 =?us-ascii?Q?ikZhbEqBHluhClVqFh8+9i5k6pYKdKmFf6c4RHJzlhc4YYmlWrcXvYD8045O?=
 =?us-ascii?Q?y0E2sApdmSX4F6NtDs7/W4DlGmJWDrGBdWPCMpMu1hRYux66jF/E7IX7yOpZ?=
 =?us-ascii?Q?1LdxIcaLM+yXFo7ChlrW3s/lGVTCvYLGP4cZzWD0w63DSPKXaJere9mVMrR1?=
 =?us-ascii?Q?i5yQBdvP3VabxM63DabCeLR1qN6hDNt1eTU5Lnj5dvDEwLTbBehjpZPOZRlj?=
 =?us-ascii?Q?mJhEwRnWC0uM7524l4vRCrYwNgJDsGDHulOcmA/gx+DmGKuivCjMA4z0vfvh?=
 =?us-ascii?Q?2UxiAzHChTTBmrsNKaJAEBGZ1Uw60BKSO5tJyWxKVgnPSmiV+B5vOjEpqXMM?=
 =?us-ascii?Q?k3+ivB0eF5Xg6dCtfIA2S5ZWKuUMoDv7w09yFf9jwmH2TZDdLALaiDRKr+f4?=
 =?us-ascii?Q?NJ4eHIs2jVf1bGwDDY4QC0iHCoTxXjx6o+2XSJr91+5sjShJfz/muvu4Vkig?=
 =?us-ascii?Q?/B+705eDTciPUKMhXv+QgKyLI+2lPgpzGLe4uFbX6nTmG3vg0sGD2+eXVww?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b64e253b-9851-4874-6fbe-08dcfef352ef
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 06:13:40.4255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0308
Received-SPF: pass client-ip=40.92.63.55; envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The peripheral and PrimeCell identification registers of pl011 are located at
offset 0xFE0 - 0xFFC. To check if a read falls to such registers, the C
implementation checks if the offset-shifted-by-2 (not the offset itself) is in
the range 0x3F8 - 0x3FF.

Use the same check in the Rust implementation.

This fixes the timeout of the following avocado tests:

  * tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_virt
  * tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_virt
  * tests/avocado/replay_kernel.py:ReplayKernelNormal.test_arm_vexpressa9

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
---
 rust/hw/char/pl011/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2a85960b81..476cacc844 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -182,7 +182,7 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
         use RegisterOffset::*;
 
         std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
-            Err(v) if (0x3f8..0x400).contains(&v) => {
+            Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
                 u64::from(self.device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
-- 
2.34.1



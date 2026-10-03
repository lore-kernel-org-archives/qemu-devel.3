Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8145ACA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3Ax-0000zn-KW; Sat, 03 Oct 2026 13:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39m-0007dn-Ap
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 13:04:20 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39k-0007NA-SB
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 13:04:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRTZozbqGUnGS5zLsrOd5PXeN1DLwPcp7xmFXA1K/27xjehlX+BEb0zbFd2aSODYJX66Ya+iXeXfiZ2ZemZvdTxuyadMviik6HcBOH3FSiQW/J42fJdOkiy/bgi46OxpoE3w7+GpXzYU5Gs0dhBLYzQSd8mDmaE16yDosJpnlrRdcWj4P8EhIT6Z4NCX4I0U0SBr1EEu9G59j0G3gCzY/tQzmCD9poMViapkiRD4ipMwiyHUI0E27hWxlBHoWBWEop5EgwVNk5VF4US5Wj/Miq8nCWYZMuQbmoylyH9llxG1YnZfW6z930F61hk9Vm7keKWUpdfRnbQz8hX382NNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnZAlERhgYWkU6102CJfsTPod2vCtjBfSIXTariJ8d0=;
 b=djH6oAKgFG8CoxORUWUfcKo3U/WnVPmlpO0Kfcdwx7x2lZxRGXzh/sp/qQme83KitOfnjAvSLYtfPisYj84iLdm6Kd1q2c+JudC4hj5UQ8hG/bbxUMtR1Mwm4qla7VuPuAyQVtEuEfaQGIF4rGzWVKDbg0SYakdk60Y/hDue7XA7SiltjbrDLf2ngsWuGJO2e8dPB0tWE9xaYDlFokXGpsAN6TRV3+Mi81GHWeuVz4o/EjG/4e7WHyF4wwm3rnSMwyaLCV7RIkY1iCRRd6G8YjC7EsuazHjpPjphiWMJPSPUFYhpyI32bhtK3nanvgQSsyqpPHSNg/R4Sh6XZUPE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnZAlERhgYWkU6102CJfsTPod2vCtjBfSIXTariJ8d0=;
 b=L/VB9Z1Lp07R/6mtMM0RHVJTYkwIKuyyLKNZNN9T8zHSgNyZkX8UflrkEPhGUoqhN2qZfVgNPSvgmOEu+qp+m+vNSQxyNO/cXjTr9odBvVTap9TB8MWR7a3L+9yruvHmZylgSspl+GNmc0FuNwvWFJYo1clAFTT93nbR+ZiavXwNG8zTHYg4HwetcYz3V9tzc2kQeaBoTDI+HL0YEyIoXN+8CIwofwCyPaKa9Q95WgFB9UpxPNfhQuNbgi6VLfRbB5GUaCkYmiC6S5Liy9wWCCto5l8uxaV33tr8bW8CTwQ4naUjY7iMHSzXDwFmjgUfrZowpYYo00bW2KqjePVF1A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by PS1PPFF2E6AB00E.apcprd02.prod.outlook.com (2603:1096:308::2b1)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:04:12 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:04:12 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>
Subject: [PATCH v3 27/27] MAINTAINERS: Move Conor Dooley to PolarFire SoC
 reviewer
Date: Sun,  4 Oct 2026 01:02:17 +0800
Message-ID: <20261003170232.2450916-28-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|PS1PPFF2E6AB00E:EE_
X-MS-Office365-Filtering-Correlation-Id: 062ba93c-0333-4542-1f18-08df217058c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IEb9OZm3HE2NBqOH5RWJ5op10EmtaQQNuhqYcyZyrPL8eZXVaQSFFcPhXqIstafKrJX9kw0s5P5G5XZKr+UVIJJUeP4fa+IUeDZczjx96XLZFBYOGhBL8UvkpgcS8SCZh2pAUCZlhiEmQO6FogKh/gU+qjkNolqURhQRTAdUiNnJ6lAMCLUr0Wv9kTuNb8FhrT+p7ftGe28fnqY4OgW/PyjJX6FIXGaCEI6HZK2spteMAlBDfJAEV3OxZ1i3vxFuA31+FTK3rFHS9tLfgIZTBZ3sT8fsfjWpZiGwqjkjhbrK7LdfTjGFSTvT1gZ2+YFbMFBttht9dDkV7SJIrXlB9spLUzdkyn3+8x1sFjwjXihB2xniognS/DMyf6p0llQ1psAKRTujfjaOGYygjeiy5Ovw9WUQeMfzTjSEAEWQBRvaXumhr1H6b2EQz/ZjLzThR2kHEUHxeNGoy+dK2vzCI0SykxFvi3B4ZogGxhBv+UvZ+HW6v7BJpK5Uz6AnsYnpGs+9s7xVHqPsDZ8kjLTaCg6D+p4a3kM1xx0y/FpN7bZ18+e+Tl7WjcWLEc50G6ENixJN5elCb8acrD6kxhNOOSqWLeYw2iLaOb9hRCSU0gDA98TaU3KsWprbXnotT96vayJD/vDJ6lAFo222p25A8r8PPudZeeBe6eXycH4k2gU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jc7nXTyTpJNbrBJ2KadPSyLp0nNIREQAaYis+SAozPR5jyscQl+lLy1g//lb?=
 =?us-ascii?Q?58Z9TbL0AyZzEA+gKkwYFPQ7/THXeSirKHgCA/x3/sVepcIOkrxpp2yH4FYQ?=
 =?us-ascii?Q?kPjJmu34nSWLUvFcMf0keqBI8PlDo/Fdr3FJ+kO+DMSgBqTK3R442LiK8IUW?=
 =?us-ascii?Q?6w12Ag6CMpuFzE8OSUCEJM8L3gNmiK57PjKvDQb+7vKvDMA3yxblUu0yD4PP?=
 =?us-ascii?Q?RrOZBHDaCXTzNFIaDxhGQS7OLIzuC/D7/Ci/alTAn0CuRKEB059snITiqqwb?=
 =?us-ascii?Q?5yrrgQ18fIBnc+ZpQ9HAH1ZKTsmCHocPZnjJ1rESX/MRCk9QRNSxmi0KIgAJ?=
 =?us-ascii?Q?fdfphAiHbz2BucISbYySH834P07KZmVhgmToyx0EL94SY7ha+79OolYpWHRP?=
 =?us-ascii?Q?iYhK3QxyeSRvSEpsgH7t+Dz+3iJoytf1AV90PF7pgu3r2bbDXtUd+ZnkdOmp?=
 =?us-ascii?Q?kGqy9ZiE/+jbkK7A7BZBMPGVVwhNyoBVjdeocHHov9xH1Zp/pRIq6wkM6F3H?=
 =?us-ascii?Q?iTUlIVPFqtUiWfkIwTvScSbwKVJf28Sg4+oXwTf9+NgxGWXmNmE8z1fB7yeC?=
 =?us-ascii?Q?XRxfztUlUA832SxQ8/KF0/7mIv5eezXbFtZrZkPxBrLgV6RfzZRM+JgxoGB1?=
 =?us-ascii?Q?VnIWpAARKgwGXYFWO4OljuOxGIdjTFTbIf0la1UOqzjfhtlfETwpW8J9kgxr?=
 =?us-ascii?Q?OqHC+Pq/Xgyqp650u9oTiFY1HNaZeG+5HFlHRP5oO/Qpq3G0RZws9+M6qm+k?=
 =?us-ascii?Q?101GAGWNMBujBI1V4HrXPiE8wrk5IlZ40mA3qnOmi5MS+jJxic/vSHIGOAQr?=
 =?us-ascii?Q?n536PFhlN5uv3j6ZDiuv/NzparVMtGIw4mnRiWOSHUyyD/PYlmlH9+lZ6yMx?=
 =?us-ascii?Q?Aj7eoIsBZuxi3zXN35OxBWXmp8JPupO0GqD0RnYbAHZgZdUylVv0iWbSdIOt?=
 =?us-ascii?Q?1aycOwF/Azfc0QQ2ggFCw63yGmSa7/ihh23wtijVrFXoE9HBIrxMbW3h6zKz?=
 =?us-ascii?Q?zNI5sDPaQtyo2uRPtz8vHACFM/DF3BZ2DnVO2fPTrTnABoA37tHcg/FjVPY4?=
 =?us-ascii?Q?ca4L/h15cRA3L9uHtwH9nYYyMOKJ28/ABFO+du0yKT20F9SeWSRjCHPrOzzJ?=
 =?us-ascii?Q?22DtMl/WqVMuAv5bwcYLIuwfXkYMKtbiMnrd13EOjvbAt6rG2CRhk0wpCvUw?=
 =?us-ascii?Q?YPdbt+HffAxOHMsqwtJK5Oai/O+glKD0i5opYLbZqOSskBpVIKEQZLN0U15i?=
 =?us-ascii?Q?glmZ6xWzT92+g27do9f5ctq6IdV6hwPJcULPh2O7gCjyqc8SNSXRTQzxmFH/?=
 =?us-ascii?Q?kREMGqGuVKGK/56xY1zf2SIRk283JLllC6oNKm6y0SmCRDWf4fVnQmHiPvn4?=
 =?us-ascii?Q?2BWBlK+eQcf4GdDfRdjKQQrUnsFZt69K3Kau5iEUzgPKV4CjhYW4ySo42Axh?=
 =?us-ascii?Q?P29QjURTlVEupPJTiLJM1reyhFaJSU9K8mLjMUoeu6kW54mJVxpj7dzpciHB?=
 =?us-ascii?Q?bTwkmbKl7pz0E3ozAeXg9fO8Zc+o2ylFFlN2TjoTGXTWDMk+T93S+8Qb9onj?=
 =?us-ascii?Q?XRkfr0PV7vjeQWt+Ap94o+baiWCfH1DqnlRUUOgCcE6fgomGt3drUe6JE/WU?=
 =?us-ascii?Q?34/3Bwm84F2QZFEnkhO+jHMLdZPkBzoE5rZSJ6ybyW7kYBadeKaHGmoPYPFF?=
 =?us-ascii?Q?upCJXIT7LJetzktrvGkVIEmT8k5Vfv05K/p0I97EkMgskKIVzI2ItYw8duvS?=
 =?us-ascii?Q?4WFFOYksqvzIDzPBUjHTiuVc+vjWHh0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062ba93c-0333-4542-1f18-08df217058c1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:04:12.0751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T56Gna3xUXLEpaHMabUISbobsAoNLP6244i1PtGsBDCJQE69J0RDOJBsEsbkVA6Ggg1a5OabrTibNo/1DMO5nEGZTet3w9luYROIZaaiHQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFF2E6AB00E
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

Conor asked not to be listed as a maintainer, since that could imply
that Microchip sponsors his work on the platform.

Keep him listed as a reviewer so he continues to receive relevant
patches without suggesting an active maintenance commitment.

Suggested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Acked-by: Conor Dooley <conor@kernel.org>


---

(no changes since v2)

Changes in v2:
- New

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0edc7385fd..40232cb65e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1794,8 +1794,8 @@ F: tests/tcg/riscv64/test-crc32.S
 
 Microchip PolarFire SoC Icicle Kit
 M: Bin Meng <bin.meng@processmission.com>
-M: Conor Dooley <conor@kernel.org>
 M: Sebastian Huber <sebastian.huber@embedded-brains.de>
+R: Conor Dooley <conor@kernel.org>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
-- 
2.53.0



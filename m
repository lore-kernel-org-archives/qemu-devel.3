Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13946C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtxuC-00087a-Ki; Tue, 11 Aug 2026 21:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu8-00084O-OK; Tue, 11 Aug 2026 21:37:16 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wtxu7-0001Yf-6g; Tue, 11 Aug 2026 21:37:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JP5dtZzdBAboJLCuAE+DLHoqljPvcmwM9/H5MOT2hJpJk7BKl1ahgplz/e4+tfRfP1gDXzU0Kaz5lV0A+Q92XsEZV80OuI/Deg3jo974sjhfPcPfKAtt5Mh+Eihte3VrSjIgCtOOspVYmlYSR5nRn6tMTyNxUucNz4nNv3WFpvUZmiAm5bn1EcJkwBNo/pz4EtoN722tfUq+JlmtMIePf3Kx8pZ7gWglq4oL0dmlnty7Q+CVMn5H1F2dhnvWFoCYQ2jzfwBOGzwzwBVzQy6o6XbUH8KHoErORAuMyRl6/CXgynuGaj16r6izLBZGRDQyomZdM0Hz79rbRX2IlBRx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qyh8sdJAo8tito25CyyZJ6Lk/RMRsiJTYfUKRnpA4c=;
 b=WGAVVKxc6Z/fOmYOxb9CAg6hBmePIIPezeQLgeqHwvP9l9EZ+NGTKDtABcOS7SOQy2bw0HuHi6yeHYdrNibwp4EaNV8k/YT8e9Bk8BjQ/mmeBqULTlmmto5BGLYFGzMHtw77cyhAIOMNz8gYg5X/VJc3/VSn1ZFtrLoTggAmp9J92fdw3Lo32Xk53nUb6jYU6pvzfJphxxLpauNTLjH2sycH+D2YG7zfySzn8nbBDsWue41tfpNTftaVS60TCdLhv4g16q4cujw6+RBRAPckI7OLi1YvDBwONntkdzEPmhPC5KAyl7mv3X0yyY6DELcAIgcdPviK3F9wMPe3d4LWDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qyh8sdJAo8tito25CyyZJ6Lk/RMRsiJTYfUKRnpA4c=;
 b=RDj77pRR2Quox4YIX+N7M3J0N2wyT8vGCZ6paniisIKMy8D1kFyGV/KyP5fiPMYx/DU3ZB4/NTOG+m0m0+RllguEj7rloFdczWnHo9xD4833zn7pdexTrvIrtZjNiQb4yk+SOanTAooaoZJfsB/0iIiubIx78J89UP7CpRy+tJOCU1S/XE5o5A5GQmrrIXd7Z1ZVSq1wgOGnJxycSsXm8LZVd6bix0nJYpXBDm1lIdQQOnWVoLQUr8LaeHreiQjvuTqkLe2Q1GjDLuLV07ey7DRrymA5qV5IfxfKagLee1Iab5ANU02F1WrjzBnOrqJ29A9oOV+tCnD4dnbno9QGtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEZPR02MB7871.apcprd02.prod.outlook.com (2603:1096:101:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 01:37:10 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 01:37:10 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 07/10] hw/sd: sdhci: Preserve uSDHC status enables for U-Boot
Date: Wed, 12 Aug 2026 09:36:10 +0800
Message-ID: <20260812013619.2134092-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812013619.2134092-1-bin.meng@processmission.com>
References: <20260812013619.2134092-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU6P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::22) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEZPR02MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: f56a48ac-6b65-4ba7-060b-08def81239eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: QQGqllRPtn9XzrqG6oVjAKp9hAYs17SOWM93LoKZ/NqV72aCEHioOLs+9REYUDmP9Z+c9PpkcMnkoM/JhMf1T1RN0T9SUEdvhoKqgleXoK5dAbNKJQAG3CKXfykkCE0I/tLLcGd+T9R7A3OoWP12rjGdksUSrSZx1BFUOIBZ7/gvJQaQXguP6ZYjnrFNXxQEhVy2mz0tbQndb9TVf5VlfxBQIPx0HtfeuTK4boO5eRYMllPPQvYRKZq1eO2PjFmei/GFcwOqqm3r5K4W4TS0INIrqk4g5d3ZBf+hxGzcZc2ZMzzC33YFWJBTUpQFw4JxzZqZrhTqLEtxJFQ5WEp7mB5wGRq1ziP3fLobu38RG4sbuW35TBn9Q1DXk5sm0jOGpWspgr+4sUZGqSMWj9Marz3I9182MSmd1a+lEg704zuYfhlRKS+CL/prUqZgiYBcvHRu1spTsRwIMf140yuAxYoyQu8gNVTFwMAJNdsafmlzz+A9RM1GQtsQM0luUN2fCjB6IzO91K6UyhUCz/Ub27rRu4XhuQdKLAHKGAfML51auzLwLnzr9Di3iIziFZVqEcuzqfDYxroopKSe9VVveQ06syWHigaKiuNj8KDboGgtlXV9ZbB3R3C84sIziKbsL6H+P5BnO+nw2KBQBIY4PB1znrfT1hupQ2cuFKcTu0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QneRquPvqNafPaPRoI7BxCax9fMfiiE18Bcd2tfa/3RfGeaowUnWqIxON7wM?=
 =?us-ascii?Q?Molm7eymGu9XoBdDjU7V/VCMpiQjSdpblQXDcUsU5RFXQngnNILwOJGlIN3q?=
 =?us-ascii?Q?vB9cBAHQOfZ5CWNO/8NitcAKQP+aN2fKUhtAcLaXEsto6kpf/6/Q3k+UUfyG?=
 =?us-ascii?Q?YSt6RbaDpERVG+7hsHNACfTROAyW7vHUsfmbhbuuKnLdsGZBYsviWz5bPGrC?=
 =?us-ascii?Q?pfKhXd1hhXR2An3D+qpRbQeywh/E6T28+/iXe92tFg+uUxQN1d9zkH7z29iP?=
 =?us-ascii?Q?mQCbd0n/ba3XM7axlk04ctXzt04SS1tGmCvUfJYYhIWxFCH08M7VT6kMZll4?=
 =?us-ascii?Q?5d57/H7s3XsLVkEkDCGZzibw3PN+CBpniUWzg4ThxPm25lkEp+Hxf1BcavKo?=
 =?us-ascii?Q?YDm4+XDjnrS8uNE3Igqy4Cb8sxFhd12d8qSfrDmbI/1hYSGW4Wsx3zj/jfV9?=
 =?us-ascii?Q?GJ/9gZQ9u9+34+jZWXrcv3rIHC85ErMsTsJcnQ7QX10roh+cXj9OVjBWOeCw?=
 =?us-ascii?Q?2HRkWrCRyGyvxU/iG5xQiMg1GavPHW+GA9OnIQRrb0o8ZWeDTOYev28PPFmy?=
 =?us-ascii?Q?iMmZja7xUtL7UABxkXBMfgS1u2qTPKo9h8sZg7Wly8OiM6qmcAtlgIL/1oC9?=
 =?us-ascii?Q?7qwKrPTOdYhc8XFqs0FiskSMl24RU09iKiYopiilb6+Vrul6oM6F6tbk4GqZ?=
 =?us-ascii?Q?6Mo6yqVcNFUFmlzKhBEo0Pcp2JpOw//3yyPPxqkwvI4iF/+wOVu5po6p2Djb?=
 =?us-ascii?Q?uZ2z+bqGAX8lKxaoaMUqYwJ+ZUlbWhq3vgdHMXX+pVnbyWY5PgojE4wYQ1rU?=
 =?us-ascii?Q?EC0ejk1TdZ/200SUvIPZmUFtzIFys/cD9h+tmt0EfGwbPJArPSL2jInQ5z3B?=
 =?us-ascii?Q?ZHr5pNTU1ln0LhwkR0zlxE3jP80vrwKmL7y19QvVwA6MeYg8jbic3QPAUAeQ?=
 =?us-ascii?Q?EesseMz6zghEGgzCbKm7eDQSxRtgTQpC4ytdiyOQVRpAjDJPtcF8UMpT48Lq?=
 =?us-ascii?Q?W5euQedTV/lIxe4Vzh1e/UOjvVCrzuW76qGbdLYIpUbLR1rQ70pYsR9URolI?=
 =?us-ascii?Q?SQnJ855GF5Ng0PtcvidVWlC/6lWFQzKx+7Ma+HOb0iC76mTqpU+BlxmFj3U6?=
 =?us-ascii?Q?JyPeNha0dmpT0RCQndWSXwaRSUHMsDO+imzPygsffjFaFlO7DyKJZeFUyPmg?=
 =?us-ascii?Q?QC0e6sk9hrgHllxILpvVwS/6/WMA4O9JjT0Z60MxJcWl7oIQ+00DYqyAesyo?=
 =?us-ascii?Q?Fu3p6vCfrhB4YhqPwzdVlEvoro5im6mDbfX9uI77TtPiscNrd6ZwSvDB2y8n?=
 =?us-ascii?Q?tyxtwYveUdu7yAY5f/pBL/4rxXz2iDr9NzdRDcrPW+sYkwpGG8Vluyn3or5Y?=
 =?us-ascii?Q?rivewwSKw13ibLFkMBLgWI7KAE/7mS7/xWpDkH05LS7kM5AxQuRmfs0rKCpq?=
 =?us-ascii?Q?le60pSv2wqIYUMXL6Y6waQghNB9vwWbNicYD0z9slrtlVvHJj1r7lQFidRxN?=
 =?us-ascii?Q?Dy3XuBsjUN4J7gLqgGqLxiJ6q7YBamBoWaGzMte7lcXkZaXlL2lghSi9/G00?=
 =?us-ascii?Q?u3hfby9dNuLtwi1nLlwtSMNncZsZpS1tRPbWI/Bmboq3FWfDMIfOjCgSxhK6?=
 =?us-ascii?Q?dbDfQ3llrgGztdzq7pMgwNg+DE/atd16EjRWPwlyXiIk6471nPegpJ1QNE59?=
 =?us-ascii?Q?1m46nVy4XSKlWuWVcC/45DH26czXKo+abaqNRprEHjs0SPMvTEXmi5UJLwWF?=
 =?us-ascii?Q?6MIiZepKg1lx8yxdeYDXBZNJ2DUm8XA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56a48ac-6b65-4ba7-060b-08def81239eb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 01:37:09.9309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Um0HQvuS5dC/8rkpq3GlmYuq5akzxKhy5pPbH28xDLbfaElCq5eoH5p6frRWOErWpSOq8jaATPk/S1qi+z1Il93PU64B4W8UoyNBOXdI4TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7871
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

U-Boot's i.MX uSDHC probe calls fsl_esdhc_init(), which resets the
controller and programs INT_STATUS_EN. It then calls
esdhc_init_common(), which issues a second RSTA and only clears the
BRR/BWR status enables afterward.

The generic SDHCI reset clears QEMU's normal and error status-enable
fields. Consequently, the second RSTA removes command-complete,
transfer-complete, DMA, and error enables. Commands still reach the
card, but QEMU does not latch completion status, so U-Boot times out
and fails to expose an MMC block device.

Preserve the normal and error status-enable fields around RSTA in the
i.MX uSDHC register path. Signal enables still follow the generic reset
because U-Boot disables interrupt signaling and polls INT_STATUS.

The IMX6ULRM describes RSTA as clearing read-write state and does not
document INT_STATUS_EN as reset-persistent. Treat this as compatibility
with U-Boot's established two-reset initialization sequence rather than
as behavior directly specified by the reference manual.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/sdhci.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 09aea733ba..2ee62847cb 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1625,6 +1625,7 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_TUNING_CTRL               0xcc
 #define ESDHC_TUNE_CTRL_STATUS          0x68
 #define ESDHC_WTMK_LVL                  0x44
+#define ESDHC_SYSCTL_RSTA               BIT(24)
 
 /* Undocumented register used by guests working around erratum ERR004536 */
 #define ESDHC_UNDOCUMENTED_REG27        0x6c
@@ -1920,6 +1921,32 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         sdhci_write(opaque, offset, val | s->trnmod, size);
         break;
 
+    case SDHC_CLKCON:
+        if (value & ESDHC_SYSCTL_RSTA) {
+            uint16_t norintstsen = s->norintstsen;
+            uint16_t errintstsen = s->errintstsen;
+
+            esdhc_write(opaque, offset, val, size);
+
+            /*
+             * U-Boot programs INT_STATUS_EN in fsl_esdhc_init(), then issues
+             * another RSTA from esdhc_init_common(). It only clears BRR/BWR
+             * after that reset and relies on the remaining enables while
+             * polling INT_STATUS for command, transfer, and error completion.
+             *
+             * The generic SDHCI reset clears both status-enable fields,
+             * leaving U-Boot with no completion status. Preserve them across
+             * this uSDHC-specific RSTA path. Signal enables still follow
+             * generic reset semantics because U-Boot disables interrupt
+             * signaling for polling.
+             */
+            s->norintstsen = norintstsen;
+            s->errintstsen = errintstsen;
+        } else {
+            esdhc_write(opaque, offset, val, size);
+        }
+        break;
+
     default:
         esdhc_write(opaque, offset, val, size);
         break;
-- 
2.53.0



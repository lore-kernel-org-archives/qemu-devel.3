Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20343606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=MUk+qjD/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeME-0001dY-NX; Wed, 04 Nov 2026 12:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLA-0001Al-2I; Wed, 04 Nov 2026 12:00:01 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeL8-0002Un-7K; Wed, 04 Nov 2026 11:59:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EATAsihOX0boOzqfMEWSjGZwbHRH7bow9sNBkOZcseYexhY91oZNW8v3NAatEYOyyI/avR8zjNKHmkmVYbERjBy2IUClAnUi/IaPFNYKg9PTBh8ZQBTW4+loXMOG+fSil6RDcI4r1NoL8eCNSH6RShEAakmtkcSTENwIIOXogiiO6m8h1djarQvHpgGMBgw16e8HXkTBcKx0G6MUDcleUcR+akeRq5aZXAy71xtlKRgpyz/NHfNJ7bHXZ5KivIwYR5f0dW3JAgLQrsNAG/+vdjY5IqBnHoIT9pIj9kUg7X3SONOrRkTjwocdNd+XpVv2y1URttt02LrTdOnCZkjq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xRb/vWTDciL49hTa19MjCDNFF2C/iOuOJ9NBZMqRWU=;
 b=wmr+t1VBrLxPD3A9SHbqSE2OVSTtm4WPwMgRtK4cXO4pc5zM6Gd2QAmQ7TYN+dDU3HiLdf6NGeYrIR+a90DX59j549qwuqODbtEpcoX1QIgVLnT84dRl4i9qJcpO2jB+Z2osvWu1jCPwzPAZl0Oru0BbNqJrXcreNnCD5ZY84Y7bHJYb5jHjb/vzk62eS7/nH1QkrQbb6X3WzM/mizCJG3EZPSKFmq34DDuCU5yN3gj9uuSt1Q8kv2IbIbBfURR7FEjNrIELV/to/cNph3cbY2XjBvf6uXyyQT8q1wg6w73LqzhjVwcfM2FEF+UN++2TStxzh0V0MkGH+vtYmsmRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xRb/vWTDciL49hTa19MjCDNFF2C/iOuOJ9NBZMqRWU=;
 b=MUk+qjD/1AP96KCLPjpRgZ0B+sW8iHBFl/jqn9ttyNdsVAOyyG1SrhvWr+O0GQivVCRRuzPkjYWHl+IkC2Lf+5KMBSUOokE8YYUElIK3INxN2TpllEOLXWgZBFu1FsyE2mwSC+cvakOhkkai+ja5qjq+8Dux4tF+wQf5jNTYRCa1cxH7cX37/VzhloiAyTZKL4e26zBMAKWbQcH9q+N0DkALLu55dXq1a+FAWtsSDCE/JU7Q9lLkbCnaAQrLK8pjLVbYUnb+FzYK+L9OxB+QekqB9k+ycLUxfydO4wx+VnnwcyC8jtMjwXSgEFdQZ9tsYJ5Y507NDAq3ut/MqoBLoQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by JH0PR02MB7899.apcprd02.prod.outlook.com (2603:1096:990:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:59:51 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:50 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v5 04/10] hw/arm: fsl-imx6ul: Add a minimal MMDC geometry model
Date: Thu,  5 Nov 2026 00:59:16 +0800
Message-ID: <20261104165927.678833-5-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104165927.678833-1-bin.meng@processmission.com>
References: <20261104165927.678833-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|JH0PR02MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f5304c-ea59-4772-d45f-08df3a9509ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|261021121427099003|261021123027099003|261009223027099003|261026121527099003|261102123227099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: TN1z9RFlTBoOrnq4E2KU/fpqNx/4xGC2YIUZHssY2cNKUUZeeD5NPMb5XPAIdYlShaVjsC2tFN/4Ph15PDP397dsLjNdIY+WIcgORtYReHIJxYHEgTN0hpu5r8dViYigMejnda+Wwldc6Mv2J2+6m2sCZ82Ys3Zbtwtzxi+86mni+btzY4MMZynz4RmNKNZnOeoHI24b1sKLz7tYzPPb3wZ7hdO7DkOLeZUbSHPYl5brjA+emZmSTQJbGTqTUQk6si7qkTbbdg9Hz2mbTm4OMz1FDXRG/+yJDINeS18H7ZDNMMNWrnmdj+04btYiI7K+t4cXquMdknwnlY7WItd6Shq0a1FSNyMzKRD0wDblnfMIfbdY3Lrm7Ih9pjTUNpstN4FZyB+V8+EnWQTXK8REu8oMlrUAJmspCUJuYPK5sffPF7QdLdx/hzeTW/Uv6DQhTLfK/Rd7KuRGixj/FvT951/vqDDE27aWKpYv3iilCGm1UfNcKlK8nPEBdfAurmmV1XR5uYVzi191Y+npfcTdEl78OJC33b9uHo8jFnZx9BiEquNfjHxdOUZb/buFZbgJtCPNVDnd8NLitPlMrKXwkEkMjdJ3BxXMMEbLDYVTGEeHvGLZ0rK0MSa2Kd+wEKnPkCsibqwheEvXa/0GBUHAtiIW9dJRAyl4HXjBEw07mks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261026121527099003)(261102123227099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l7LWwNPaytAKYuFtTe4zuxDzYLxGdIQzFxrfRv86sNCspZYFmpkdHwJw0BU+?=
 =?us-ascii?Q?/Koxbu76HdCAi+oxNigEzJ1aeNJYthGsprTcCd7BLJmLBJWfZOC/KiM4iJoF?=
 =?us-ascii?Q?lXZVbOPezeAF6Av4pWY7pVTVzFRPSal23feSbPGnrdkR2CMDa/vtc9BGn+iu?=
 =?us-ascii?Q?9wTR+jaOrEiN0g8s+VZm0rjhxXfz6Eugm9rNNw4uctJcskUZqFNSQjhwZeFK?=
 =?us-ascii?Q?Q7SbG1uYfwD82q3k94Z4oGdx7t4vCJMwraYi+xbmCNI/ckXrYvtni3gLhYoY?=
 =?us-ascii?Q?yQssX4JXuyJT8k4j++x9rC9rzHxUpj7sVyOZ4iGAy6stI8NOmL8qUhWtMfLF?=
 =?us-ascii?Q?HmUoOXal18P6zqYNlp5Q2XPP1aao7wy6dRCdP3ZaiUGDbkqGrix9iUH96KUQ?=
 =?us-ascii?Q?VyiEI+jgRYjqpW6f6ltxaxohbb0C6B0nDOSAVZtJ6khfN93vN47qEkP2lFiG?=
 =?us-ascii?Q?FR6D1y/OjRFv+1hPpq7a6DsC77L7MHn9yr4a6Fw5uPQKe6B2qTbnqV+wRFrT?=
 =?us-ascii?Q?JwoRD3u65FRReBB44Od29UBhA3XUQcXoP9dsUQFMQrdeTDCzv6l8fRRxPwyT?=
 =?us-ascii?Q?MulrU1QyjPwYXlJVAomsDTh4/jg3YkuGUkRSdG0DV0kARXyc5ur4xcNX7n1p?=
 =?us-ascii?Q?xr+jGUBvt+bULdYPEStnpktjozyakvd52glscHyOwDijS3Wg6ZwqEqJv81zH?=
 =?us-ascii?Q?3ocexX+wjMwa8OynNPwD6qGOhPXHRPFKaWzUmHiT6Qs4VgSacmZJ1TGCAVuz?=
 =?us-ascii?Q?rro6TNRCMCsdLD1cdEoEiRHH1o8xSG/sB53BVIgK8osl+UH2n3gl6LsdEIRf?=
 =?us-ascii?Q?/1gMZMydcyIp9FjtQO3n3pDePQKslR2x+JyFAxa6vZ8IOfSk4NguQOsQ3Lg7?=
 =?us-ascii?Q?0aF9s5uZZCoTPMqnDe+sq4uIRHoeVLWZX7KqMvJha+t7IfCfUoWnOmhKjdxw?=
 =?us-ascii?Q?lHpgc44CjLnQC3BkmQPZxpOxiNtVEoE6tzTsPijxtPY7cU/UkU9MVR1RFeYZ?=
 =?us-ascii?Q?25waw8WHrrlBSHZPJfoUSEh2vfnDw8OKlYegJRQYAg0HxejClEunGF7kESts?=
 =?us-ascii?Q?FHXrSIFxrDyZloeUujsheVhjysO6+10VvLPQ1jMB0G0yWpyTqP97h1GUjaFK?=
 =?us-ascii?Q?/VEhUwYEWy4s/9G5k0b2y4ajCoP/ZK/ir/Yhmz7QQTN3HEgew/vP7qeqlgZg?=
 =?us-ascii?Q?J1pjCKEKcqL/9o0IvTMgCsp9/mOPoa0C3k9Tp0n81wMPH9ANKPnI9T367jhe?=
 =?us-ascii?Q?sox3WoshI/FItO4Z9E89zAhBnaVOLVIaoz2nonTvbv0Y5OInDGJx/p6Q9J8F?=
 =?us-ascii?Q?GUHLLVH8atVw+krZSh2qIEYB/02Xn0kwoQwGJGltv8r/50hL86Bl+b4acGfM?=
 =?us-ascii?Q?LvH0hRmht4Ixj5hnRB4BJoRtus7IS/1RRKVoEqotseH6lpCC4Z1ocKLa8w4V?=
 =?us-ascii?Q?7bFIqzZz9pRwz+EkYoDNMttYd30AeuhIT3tldQNXme7BGS/xdQbHlr5wSjMg?=
 =?us-ascii?Q?6fOvgrr2sGcsv/bxu30+z6QYlClWj38vxiiDtakX/BdlZsvFC6R91wSHlybg?=
 =?us-ascii?Q?9E7BzBCcRqgI5DYOmouQXyuv8wHQbCou6/odUOkeZPnW+DZ5SVjUoLpJsggn?=
 =?us-ascii?Q?bycWkMnmrwol6A3JRjb00VT645xzmwmGgvinMz+JJluHmvHbzQ1OHDoFCfBr?=
 =?us-ascii?Q?/OzE0zAc3CMYH37isRJjgtpPH/OdiDgq1NtzKjLzS+m6Fzn6s+2BTI/CUewb?=
 =?us-ascii?Q?5r00N+INX8ma/I5c2RH3W7ohtNrTskU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f5304c-ea59-4772-d45f-08df3a9509ac
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:49.7706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oqv5TlMgcgHQ5jX5hdQYTiPiU/9uRfHzepsaEfc2hTXE5gVjGs6ZzzwLMHm0hsAmhlOayWFZqtAf51Dgh9q8AzpV9l3UoKhzRckouLjZZOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7899
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot probes DRAM size from the MMDC MDCTL and MDMISC registers.
The existing unimplemented region returns zero, so U-Boot cannot
derive a geometry matching the RAM mapped by the machine.

Replace the placeholder with a small read-only model. Use the
8-bank, 16-bit DDR3 layout of the EVK and derive the row and column
counts from the machine RAM size.

The MMDC permits 11 to 16 row bits; ROW encodings 6 and 7 are reserved.
Preserve the existing layouts through 1 GiB. For 2 GiB, use 16 row
bits and 11 column bits instead of an invalid 17-bit row.

Reference: IMX6ULRM (Rev.2), section 33.12.1
https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v5:
- Rebase RAM-size setup onto sysbus_realize_and_unref()

Changes in v3:
- Reject RAM below 16 MiB instead of advertising unmapped memory
- Keep power-of-two geometry bounded by the configured RAM size
- Use 11 column bits to represent 2 GiB with a valid geometry

 include/hw/arm/fsl-imx6ul.h |  2 ++
 hw/arm/fsl-imx6ul.c         | 72 +++++++++++++++++++++++++++++++++++--
 hw/arm/mcimx6ul-evk.c       |  2 ++
 3 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 9ae0488990..5284643dbb 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -89,9 +89,11 @@ struct FslIMX6ULState {
     MemoryRegion       caam;
     MemoryRegion       ocram;
     MemoryRegion       ocram_alias;
+    MemoryRegion       mmdc;
 
     uint32_t           phy_num[FSL_IMX6UL_NUM_ETHS];
     bool               phy_connected[FSL_IMX6UL_NUM_ETHS];
+    uint64_t           ram_size;
 };
 
 enum FslIMX6ULMemoryMap {
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index c7f7e12341..b456a43ac6 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -25,17 +25,78 @@
 #include "hw/core/boards.h"
 #include "system/system.h"
 #include "qemu/error-report.h"
+#include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "target/arm/cpu-qom.h"
 
 #define NAME_SIZE 20
 
+#define MMDC_MDCTL  0x00
+#define MMDC_MDMISC 0x18
+
+static uint32_t fsl_imx6ul_mmdc_mdctl(uint64_t ram_size)
+{
+    unsigned int size_bits;
+    unsigned int row;
+    unsigned int col;
+
+    /*
+     * Use the EVK's 8-bank, 16-bit DDR3 geometry and vary the row and
+     * column counts so firmware observes no more memory than QEMU mapped
+     */
+    ram_size = pow2floor(ram_size);
+    size_bits = 63 - clz64(ram_size);
+
+    if (size_bits == 24) {
+        return BIT(31) | BIT(19);
+    }
+
+    /* ROW supports up to 16 bits; use 11 column bits for 2 GiB */
+    row = MIN(size_bits - 25, 5);
+    col = size_bits - row - 24;
+    return BIT(31) | (row << 24) | (col << 20) | BIT(19);
+}
+
+static uint64_t fsl_imx6ul_mmdc_read(void *opaque, hwaddr offset,
+                                     unsigned size)
+{
+    FslIMX6ULState *s = opaque;
+
+    switch (offset) {
+    case MMDC_MDCTL:
+        return fsl_imx6ul_mmdc_mdctl(s->ram_size);
+    case MMDC_MDMISC:
+        /* EVK reset geometry: 8 banks, bank interleaving and RALAT 5 */
+        return 0x1740;
+    default:
+        return 0;
+    }
+}
+
+static void fsl_imx6ul_mmdc_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
+{
+}
+
+static const MemoryRegionOps fsl_imx6ul_mmdc_ops = {
+    .read = fsl_imx6ul_mmdc_read,
+    .write = fsl_imx6ul_mmdc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void fsl_imx6ul_init(Object *obj)
 {
     FslIMX6ULState *s = FSL_IMX6UL(obj);
     char name[NAME_SIZE];
     int i;
 
+    memory_region_init_io(&s->mmdc, obj, &fsl_imx6ul_mmdc_ops, s,
+                          "imx6ul.mmdc", FSL_IMX6UL_MMDC_CFG_SIZE);
+
     object_initialize_child(obj, "cpu0", &s->cpu,
                             ARM_CPU_TYPE_NAME("cortex-a7"));
 
@@ -176,6 +237,12 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->ram_size < 16 * MiB) {
+        error_setg(errp, "%s: RAM size must be at least 16 MiB",
+                   TYPE_FSL_IMX6UL);
+        return;
+    }
+
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
 
     /*
@@ -219,8 +286,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * MMDC
      */
-    create_unimplemented_device("a7mpcore-mmdc", FSL_IMX6UL_MMDC_CFG_ADDR,
-                                FSL_IMX6UL_MMDC_CFG_SIZE);
+    memory_region_add_subregion(get_system_memory(),
+                                FSL_IMX6UL_MMDC_CFG_ADDR, &s->mmdc);
 
     /*
      * OCOTP
@@ -738,6 +805,7 @@ static const Property fsl_imx6ul_properties[] = {
                      true),
     DEFINE_PROP_BOOL("fec2-phy-connected", FslIMX6ULState, phy_connected[1],
                      true),
+    DEFINE_PROP_UINT64("ram-size", FslIMX6ULState, ram_size, 128 * MiB),
 };
 
 static void fsl_imx6ul_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 53d221b4a9..9dbf7d24cb 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -44,6 +44,8 @@ static void mcimx6ul_evk_init(MachineState *machine)
     object_property_set_uint(OBJECT(s), "fec2-phy-num", 1, &error_fatal);
     object_property_set_bool(OBJECT(s), "fec1-phy-connected", false,
                              &error_fatal);
+    object_property_set_uint(OBJECT(s), "ram-size", machine->ram_size,
+                             &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
-- 
2.53.0



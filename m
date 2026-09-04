Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D0AC79F8B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WJI-0004DW-LX; Fri, 04 Sep 2026 11:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJH-0004CR-1n; Fri, 04 Sep 2026 11:58:35 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WJF-0004Pg-Fy; Fri, 04 Sep 2026 11:58:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ti4TAwgkQbfQNj/3cmEwjNwaG5g4pilRVDq/+XvT/bRgXpHaHs15ACH7cpLz7NElo7oP/U413upr0lU/uz/4JAFM8nzxpN948m4oIODVVhNf2E5QcOvrcK/QGH5EDRQsfRfzdKDxTqsAZkmVve75RlrjD6lQDNZ7CsFYjOn442JcgwPB+ZNDT3Ug8tok22YzAIKPw1jAGuyo45BjkIIR4XFhfVgqh7mJv13w4kc6OVx5nLq2zTlK/KYC91gYZLyVyUVdqe0iOnp1rw2cedeRVvEgZlDr+GWKR885/wTGw054x/O7pTEM1JLIB0Qq1jTbSksrPQF2WlqVk7ppVdEkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0rhl7GY61g03mQTRcsJ8UabnJ+bj3IidlZgZGOwU+o=;
 b=Fc35ljGtVvTNdaee9h5js5i9kXl/zVA/g0ZG3bE0OXLf+nSunoNYBqrB7BNlWns9hmeP/Nlj5RUz7/Kpldu0hZ3da4zTJ9pqGV5FGCpEoOj6RL62OYbeJtM97t9bPkdbAtydrGvhDzFsLf0eCm4eJ4dkMq7rEqWVgipQC6sCAucfiiBMydrL1Fk8G+09BEd7GJk4etvIVcKYrkvWlloX6VmsRz3jGMugxWpTshs76gAcQECYlQaICipQYOL4VXy0DmfkoDy+0hc0Tvwm/abEfZvIQRgfzGNQsf5sjgDL8tpl4cUqNiZteHVxbnKGniyw0jITk/vl5KTzQSgEqPK0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0rhl7GY61g03mQTRcsJ8UabnJ+bj3IidlZgZGOwU+o=;
 b=kza1/1UMvSOtPPq9FDx8ORnyW+SCKv8Wy9L+MuqcCH5M0O6ztB/pzZFJwkEsU8GMdAYepQk4xIJpo2fsQU0L2pNTzqfGCiKYll9mIS23ahJXN9piIME0Nc4ntQjl/Wj4HB5lu7UQwmP/a8SuwtqPtJwCRXwQMR8iEaEYleHjfwkCslO/zxc7GxnEBkDFRTxvpEoqfzI8E9bwIl8EqfO+G3DHJtO9i7u5EpH8kzUl2xD1iQCEoZQ5Un37aJXS8U+7se6u1Il1i3GGHLun5CWq8oFw43TwVe+KKPtZJZX4z6qyT92ZWY/ONTwkqn/kVckKIxWv0cXYZuGFcw/38cAJ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB9175.apcprd02.prod.outlook.com (2603:1096:405:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 15:58:21 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 15:58:21 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 01/24] hw/riscv: pfsoc: Correct the L2LIM maximum mapped
 size
Date: Fri,  4 Sep 2026 23:57:20 +0800
Message-ID: <20260904155758.3833179-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155758.3833179-1-bin.meng@processmission.com>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d7dc9d-a2b7-4206-1ef3-08df0a9d581d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1v/tzAUEm9H0Nbuc/4pOkAizDn4mg4AHvkJU3EKt6yZYe4nXFk8CynDcmRzj/xRf9GKeJajnmQyFiclRbKB0SKaJc1B21QYeuPKXSD3tIQco5KvSbNF2mR3BghTrvqipmi1h/ziBZvpkOeEG28PRNH5AK1oS3Pd/di2rNVyScj1bwQm/yYS6z5Kj1uCihWqpS3eZOEOD9+iLtFq4YpBs9g1ST//Pg8CDCXcSPJdXbsmjDy6NyzDs/kh4QL4AwvEqPnWQ1y1r93JcS+WVJDArLFm2QByvmVVKTjENcT2a0kPG0X5M98g0U+TLQMb7fbyJouRpawtkxz526h+leZex5osuN6xXzng8WPB/uRVCmP3eK8mQvWmR2s081vM6SECuabLmJsirwzWwlp47RusIjB1h+/AKgG3nUzMlyxno4vpibReG64XzQ76P0XKzXFI2dzo74WaOREvyk4w3gYqSPGeAL6LuAxQC4mlqYAGyWwPBYs3GCwvyRnMxoWNajVmdMHXmpCyRGkjEr27Ggm6s4lSqhFPAZwLBObLi9ykM6SSeMGa8Rg03O3Q+P3kEkI/RA4/coHFPifCg7XwYFv/NwvhDxUWf4v5H3qRbf+A1xWDpNV8JW5FYj9fx1LJNAyMT7WvFfdP4Mat53sOY+PAhO/BjPSav0ngtrQsPqqiKxHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FbC0AYuqVDkLjYEk0C9mjNdHyNfuH79m4wJQi0EMvYnwYD4UlxRe04Z9Dx6e?=
 =?us-ascii?Q?NXUDjfjz3EFE4y9uXBHCgnaLZex/OIhoDbiGAwvQKZZlLyvhu1i7N+LAdrab?=
 =?us-ascii?Q?lZ0gvbglbTX11gBiJ+lfYvN47uhL5zfQLMvILcq+IIgOLIhhu4jcb8wepAaC?=
 =?us-ascii?Q?wz8tdUR7Ym1JLH2lT8kkkJsH06p5KwhgiO1Z/PpO33RiBhNVd4XiLNgmaa44?=
 =?us-ascii?Q?cUqhlV53liaPmSgdeTbYciMK7q8+1WJWWEvPrg1R7l8T5hff92oHqTedUi3/?=
 =?us-ascii?Q?lP3EzDlZAuvcBvMXButUxJMk7VYdq/9odM3RYGqRnvG0hBZPlTGMut2OjnoS?=
 =?us-ascii?Q?4OII0wldS+MKil+6+BvCBp7rD/zp0KiGu38DkXfy7Qfwmm83D8sUgVC48vlO?=
 =?us-ascii?Q?plz7TwO750wKpCkNK8PJBrP55dDMKd4stHI0J633cpijqvaajUXsjmdzSpK4?=
 =?us-ascii?Q?KEkdzIqW39QfR99hJ/XVHgt+iNdDa+l1Ej6UvBcXqzcliYz8YV193LIgs6fj?=
 =?us-ascii?Q?DF1KyY1jNWt2NYfeBN0QcYC1WJ0O3G8JVofKjudQ5O4xTBT7MmVxkqEudmkZ?=
 =?us-ascii?Q?LUP6fkOwVZXUoSmRSNXrjlwXt3wRTU3aqkCKa0GFNXiSt9xaIrT/3S9G9Q6h?=
 =?us-ascii?Q?W+bgrpADxS17DtL/DuaGWzNoY9H3N0utweIhg38c5NMj2Z6MhO91F80oT8oY?=
 =?us-ascii?Q?L3DcbaOQu6nuidWLs5xxyTGaaBu2YBfslano0nWSZWjseAYvu1bTOnx9oXTt?=
 =?us-ascii?Q?18d2WA8N2//lk7kMvCVF+RvC2AGtVKOa8oN+viTRb4Wo/qyotVTb5jIxy5kT?=
 =?us-ascii?Q?pfqanI1Y+MGIy4yetNoR6ciZ+zuP/UQyfWgMHgjr5K40REp3eVs3yrvp1XPr?=
 =?us-ascii?Q?24/urf2ZybERHIntKWgRqX/BLKC7JgpC7z92/FRuKNpAZhpQj1EhwD5yVf5I?=
 =?us-ascii?Q?mvjuqNNzo8ozB+PSWlzK2CR9le28dW8LtsdXfUF29F1T6wRRt3cgXfeNXK/q?=
 =?us-ascii?Q?zovnxNjzOj5ox3zlC1omxNufao+lP0x2G8Qn/t8NZhzqq4pX60Ld2C1h9Glw?=
 =?us-ascii?Q?F+mPmlNHiB6yFlFprGlv1qezq9n69GtEQa+1Yh6XluKdgsXzZKsPpKdW0QTx?=
 =?us-ascii?Q?GkeaS72MS3hWooN/8Gm+1lqzLeZ3Tsfc5vMrHSvX/zElLuQO2wgxHkfRxFtC?=
 =?us-ascii?Q?ZKj5p9dbpjJ9cNkgLkMnYk4fUnYJfybD/EaJF0TmGQP5DSKqfvCKzvCzJMnF?=
 =?us-ascii?Q?R1jb3BM4vUm89aJWHgf53qawS29cD38kL2lbl7bez5VCV73dHj8XokCLeEQJ?=
 =?us-ascii?Q?q54ONzU0iv1SFgXDcDNjc4/yLew8hquDatrwrma07rGo+fII6d+VwTij2zpk?=
 =?us-ascii?Q?0N1Zhj5Ti28W3raaZWPelDEkPXfZrFSxiaAeh/f4PTUjmk/jesy1Ri5JmtLr?=
 =?us-ascii?Q?Vt7mu+tUjUs/QK2vF3sjnSlL6MhwJ0g6iiO0C7RIjlRr2O88yPYRBdf1UmWV?=
 =?us-ascii?Q?1ckqp+t8ay1+E7KQou450OJTznXcip27UJ+AGpV25rxb0Dco4PgEnvUvbKdx?=
 =?us-ascii?Q?9HOuEs5+XXL5ke97DSyevG38dUBZExqKY9PI1gNL156yhe6Q85WSZajhOFS4?=
 =?us-ascii?Q?siy4JtRJAPo7mPNJyHuuzRjahM9bK4nnQExdlElsjAi//U+lkafUWexkMum5?=
 =?us-ascii?Q?X+ddW4g41TxNgU2gML6Hf4KS7ViH3lbjXyQbBioY/fQbi1cUJHIs8yiNl0v+?=
 =?us-ascii?Q?zE1rsromdTDHxm/saa+uvyKRBOu5H8c=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d7dc9d-a2b7-4206-1ef3-08df0a9d581d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 15:58:21.6776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pKs7jJm7INX+MnhaW/b+nlG0x/3f4r+TiA8h0i4b2ytDhAiAeNZLBwSGHAwsPIrbY9vUCasc2ghIf9oY56qVthh784xZ9lAbo5mimHHvow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB9175
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

PolarFire SoC has a 2MiB L2 cache, so the maximum mapped size of
L2LIM should be set to 2MiB too.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 hw/riscv/microchip_pfsoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index edd29626fa..cfba2990b6 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -95,7 +95,7 @@ static const MemMapEntry microchip_pfsoc_memmap[] = {
     [MICROCHIP_PFSOC_CLINT] =           {  0x2000000,      0x10000 },
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,       0x1000 },
     [MICROCHIP_PFSOC_DMA] =             {  0x3000000,     0x100000 },
-    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,    0x2000000 },
+    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,     0x200000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,    0x4000000 },
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,       0x1000 },
     [MICROCHIP_PFSOC_WDOG0] =           { 0x20001000,       0x1000 },
-- 
2.53.0



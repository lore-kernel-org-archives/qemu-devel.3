Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436B606D816
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=GD2e9B3x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8a-0001ge-1N; Wed, 04 Nov 2026 10:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8X-0001dQ-1J; Wed, 04 Nov 2026 10:42:53 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8V-0001E6-0U; Wed, 04 Nov 2026 10:42:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXeECacdQEoB7BVhf2UtY+DWjAxVnIg8Tz0r7iL+NaEpLbLCvuXuMWBGq+ECQxNdxfbkkGzNfAInTXXQVvDgU5rvC59mZgMTOgtQ/OUv0ZfPBCw4ECWOpZ9mwEBIm8O82DHigW1lFXN/YP6ZHwzofNrSAQlrikKXwjZ6W1SLcHR/ZaBfl1Qt4A13Tlw4lY/EQtZ6NHOOFdhGDvOARO/ZH0Gu+hKd2UI/G4fcIMtsuBSf81IxwGG5D1P3ggx1rSq1vgVSwIyOWy2mUPyF/Pb+EYAYThspU1ES7uw5VBvHsniOYjzOzyJEznMj7pnVnfokLiMrHRBRcpqzePXJgx8CuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeYoX+tW+qVVC8wYZhO08q5NeRknCq9PRqe758SbycI=;
 b=nMBOqpZUJLq85uIKVaQ+q4+5bFpfcxPazDMA6PECBzUPUU8JiVGjNsBJd//W3FITyifyjqHaC5pRV31b3s/44Vq/X+Uc0w5ZPAxMGs1vdkhFuuK4S8JVPVAjiXWTtkfKkS31MNWw37Se44kGfK5D16szkEOa04BgdAXcNGyj18L7XsQW+Vf4I0NR6m9k2U/ewd100VvBBr3efMS//P2wWf7/Ll7oMG8K5041i6xlPhncdqp3nTEyAwUpkt2Lg8YNArtNSiGgbDr0fjwmchLB9lra3RMsCHQ4QZQVrxBOCTyTujH1tNishgRE7mvL2bLo9qm5OWb3odfD0Tuszf9QSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeYoX+tW+qVVC8wYZhO08q5NeRknCq9PRqe758SbycI=;
 b=GD2e9B3xSocsFblappza/dKVUu86B6foFyf0K5N/uwazKJ67oRx9k2TnwTK2oO9eSb9DIXfOSdT9a38J+EHAl7XKjUvBGuuiaJxsZzwKERg24V/ATJP9sw2ocv2TLX879c5VzjxlIp8g9FuGoqOaPqmvBh9pafq+zHkPp+jTnHMVP5bgLvI9xNGKcBfnc5M7AkkPxzalf0dNfvMIULa5dR4jW9MlOVafuWfDbOdvDpDjObLrAcI6yxEzB+klRi+VQJZVP9ij9AQ6Wy2+Zzu7ayQC6nr2y+nGcV5TNxQ1qNs4WjHShw6XJ1Iik9Mo6QKRoGZPTDntDxSqTtQqr0c/dQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB9159.apcprd02.prod.outlook.com (2603:1096:101:302::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:42:42 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:42 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v5 09/26] hw/sd: sdhci: Run ADMA independently of MMIO
Date: Wed,  4 Nov 2026 23:41:36 +0800
Message-ID: <20261104154207.641511-10-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e204193-bf9e-4137-a71f-08df3a8a434c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261022115727099003|56012099006|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261021135927099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: tyGpawvf2C9yvixxWtQV4VmAEc6opdoyXPeobWSW5ELCLpJ6udkDDdgr78xHJsRdGBB5tznqqlmmSa+1fDEh4ZJyUYheOcQouG4TFSUdMheOhky3yrPOnFas/F/glLZ3N2mO7YR72yIiPAivyNgSQWXzAczUpTKqfznz7qRAuI9rzYnWb7cxoBSPS5AvWtAXG3nS17K3MbhXD1vYiqgh1ASkMbJCIj482NOrb8LEnuCyM1jzCFTCUxhNI4g7Gx/qdbMk5YLRIiM1gIJzqn/JXbOkcUXSYkbK7e6FGJVaX6quCGH17ZK60P7PiCq90JTShv2Kclpsvtrfl6g/VgyGcxxm1hkAR3nbjpb8QUv+B5TK/wyGxbzPeiM6T8VZus31CQlI/FodZI1hhrwkT37TW4H2ewP9ShC5GSlkS6xEeGPQnDyipmR9v8UMN4AUHrCrxZdB0KjiNB/+pxABV/p/57XqYwjOt9R4Te8LcyWdauEbZe+W4fwA5kpCoGAaNRTT+vIPpM4F+vJmn8EJtTW2MSXwBAsOs+f1w8C2C2KzjLFNbldgr5GzltjOxeNnxClmPwBhLcljU93TFjRx0/fPTj32X0WwdXNCJk4faFrqTydZoWrNkeiq4U/WWGTuSpyhgU8aYsWGb0MD6REnk5qB+pR1f3jNg4aQKjfh2g/yMgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261022115727099003)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261021135927099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dOPqZONpKP2E7BD62cW3s7ydlH6tCcekdCSgP2k0WUyyibm87WHYbID4q9Cz?=
 =?us-ascii?Q?0jU2gX+Al+/3XIgs4ddCYz9tETkP+LUx/0m5VpuPu7zCe3/f9ZSVa92Q2aJy?=
 =?us-ascii?Q?Y0VcLMABmiQufkLJjxCVnmSdR7wrdJ/ZA7X/SuPz6gKZ7/DHc8OXcr5/N59X?=
 =?us-ascii?Q?BM1Kg8Y9EdFkqv5TavIUmcf0YUSY8tpvU1tPsD3AMmYaqJ1nv5eSh9vlWAAE?=
 =?us-ascii?Q?0OamARjqopNckt3aPjmZshxmEfcA9hgIEmxJaSr5l9dBWDWnbD/iy0yrmAcs?=
 =?us-ascii?Q?urANOck6fhEuhkQUH5nCLPjaxAKcAT3C7TPY+wya1Nuyzo7fYZbnZkq5Va6O?=
 =?us-ascii?Q?ns88wh1rq48LFIaFh+zdfF+Z4JUxG1Icc//12QM3kgTuMrRGKBMVo9X0cXI4?=
 =?us-ascii?Q?zrAdJCoJGOuFm9yCZwCZCZ4tRxpub4b8xeztkHrpS/7PMlulZNROTTYs3Uem?=
 =?us-ascii?Q?+tuqUtqZpx3yyT3p8XaQIY8UNQYdW8UqBMqAmbVqc6Wv0f6wCr4GzLWXGUGC?=
 =?us-ascii?Q?i7TzJ3YEwdMvbRXq4eiXXVnW0BZkxz1oX+i0UB4BdJsp8Z7MCijUZ3+zv6Cp?=
 =?us-ascii?Q?4Irwn3Gu1TbDglBpp8OzO26B01ZifCliu4rzpCRZHVg4y+Q2J5DoNn3RyDWv?=
 =?us-ascii?Q?2/5z/pvz1AetXMtCX0XiHQ0Dzd9iqtEC1XLIfRc05kxSoL5Xdo4fC9IH+c7u?=
 =?us-ascii?Q?juacCbw5b9pzuLl7tWOvcLsEw9VzHHsGajxSk5vxIqqzHbAfQ3R60vsCohn8?=
 =?us-ascii?Q?0CAOYgKn2ZSyTg16/93k8NvPv9Y4hn2rO4h04r8kaG/PPEhpoYVx4bjpTNgN?=
 =?us-ascii?Q?y3MYl13lobHW+GU4OxW/zKQBzpYhyL6RLdvN9+5BYYjaSPBu0AgbbUP+z+ln?=
 =?us-ascii?Q?WTjFzX92Qyf9nb7C9qD+JVOUXBOF5Wb4i3iazVPCqkbGkkXtKqMd67niLIFH?=
 =?us-ascii?Q?9iAEe8yk4t/ZQdIPjzWBCxKbNvNEpdSQRwEiX/1WeoUK59/2Sbc1Q0ROdG5H?=
 =?us-ascii?Q?bBxbm5xDQ07urFLjKO8bBo6+WgofDIUNXFnQszM1M9++9skcrRDpIo3HEvd2?=
 =?us-ascii?Q?Sssg3DPEYxShY+hDx00bdU/CKeDrAz/JtZ/oQweGFvmgUOfxCpGzAsdZKFqq?=
 =?us-ascii?Q?Jmd0TuslADRrm7G4EByXj6uNEHA7r9xOX00wQMaKEqHFHmhgbe5/dJSyQG9N?=
 =?us-ascii?Q?k0gblT2F0X6+Z3XvPPf2b23D1HxSuaEs+oGvkWqTIx5nT0qBTSpBVp/14goD?=
 =?us-ascii?Q?WhNgsHZEdmY60wW+XqoNBR+zXiyOEJJv4N/P70goJndacezgmI8Hdr5vkvMd?=
 =?us-ascii?Q?+lcgww/v8tY5gST3sEAKYC1JYMjJfPXrzfOBTLMjh/BVl9W3goBJez5pNswR?=
 =?us-ascii?Q?e7stqfKI3+NN50oGTEEjMD05KlGQpk74Xgri9QbBcR4U86xjakwY3MuKzk8J?=
 =?us-ascii?Q?aOupVCSwCzS0zMe5iGSpTEpyVflNw0Gp8GBZEkqAenqvP64G1qznFFnnwJaf?=
 =?us-ascii?Q?6JqOLabSINRy6v9Ro2E6hZZJwmoxM58L8rLPrszDAeZfInU1/nRQRFu42gJH?=
 =?us-ascii?Q?IBbaPlWF968KSKeP8INO0uiI1/MjPYoNS2lwObbS2+Sn0u0mUJi435qxFBRL?=
 =?us-ascii?Q?R7niK/SEFcGa6kmrLDt+M1Wh/QKwpWxXINb4fomk/bJ1/GpMXOZkDypIIyCu?=
 =?us-ascii?Q?UpSY4c+CzQJ58oa0Lzg7/XE55EuroaV1uDbzG1XuAwkwFvn74skySztTuGsK?=
 =?us-ascii?Q?NRnlr5NsXz0e656zFihfcYNnMkRay5Y=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e204193-bf9e-4137-a71f-08df3a8a434c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:42.0559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgmPxRdkDGOcXNGHli2ZPWQiL0vi44DIyhfuwW98u9yfxB8ZGFiupXlWut4q7U68LmXFfIl1aCSLBIJfHMCrepFquVo21PJlwLDZ6xFNhnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB9159
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

The SDHCI model processes the first ADMA descriptor batch inside the
command MMIO write, then resumes pending batches before every later
SDHCI MMIO read or write. This makes register access perform bulk DMA
work and can delay a status read even when completion bits are set.

On the Icicle Kit, U-Boot uses ADMA2-64 and CMD18 to load a roughly
19 MiB FIT image from SD. It can report:

  Timeout for status update: 00000001 00000001
  Timeout for status update: 00000003 00000001

The status already contains the requested Command Complete bit, and may
also contain Transfer Complete. However, reading the interrupt status
first executes a pending ADMA batch. The MMIO read can therefore return
after U-Boot has reached its one-second polling deadline.

Turn the existing transfer timer into an ADMA-only engine. Starting an
ADMA command arms the engine directly, and each timer callback runs one
bounded batch before yielding. MMIO reads and writes no longer perform
or schedule ADMA work. Keep PIO and SDMA synchronous.

Cancel the engine and clear ADMA activity and error state on DATA or ALL
reset.

Mechanically reorder and inline existing functions per review.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Bernhard Beschow <shentey@gmail.com>

---

(no changes since v4)

Changes in v4:
- Drop the unused ADMA callback forward declaration
- Move helper definitions before the data-transfer declaration
- Merge the ADMA timer callback and batch routine

 hw/sd/sdhci.c | 146 +++++++++++++++++++++++++++++---------------------
 1 file changed, 84 insertions(+), 62 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index bd74c60f72..0c5b0ed984 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -277,6 +277,7 @@ static void sdhci_set_inserted(DeviceState *dev, bool level)
             }
         } else {
             s->prnsts = 0x1fa0000;
+            timer_del(s->transfer_timer);
             s->pwrcon &= ~SDHC_POWER_ON;
             s->clkcon &= ~SDHC_CLOCK_SDCLK_EN;
             if (s->norintstsen & SDHC_NISEN_REMOVE) {
@@ -348,7 +349,33 @@ static void sdhci_poweron_reset(DeviceState *dev)
     }
 }
 
-static void sdhci_data_transfer(void *opaque);
+static void sdhci_set_transfer_active(SDHCIState *s)
+{
+    s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
+    if (s->trnmod & SDHC_TRNS_READ) {
+        s->prnsts |= SDHC_DOING_READ;
+    } else {
+        s->prnsts |= SDHC_DOING_WRITE;
+    }
+}
+
+static void sdhci_schedule_adma(SDHCIState *s)
+{
+    timer_mod(s->transfer_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER_DELAY);
+}
+
+static bool sdhci_adma_transfer_active(SDHCIState *s)
+{
+    return TRANSFERRING_DATA(s->prnsts) &&
+           (s->trnmod & SDHC_TRNS_DMA) &&
+           (s->cmdreg & SDHC_CMD_DATA_PRESENT) &&
+           sdhci_get_dma_type(s) != SDHC_CTRL_SDMA &&
+           !(s->admaerr & SDHC_ADMAERR_STATE_MASK) &&
+           !(s->errintsts & SDHC_EIS_ADMAERR);
+}
+
+static void sdhci_data_transfer(SDHCIState *s);
 
 #define BLOCK_SIZE_MASK (4 * KiB - 1)
 
@@ -405,7 +432,13 @@ static void sdhci_send_command(SDHCIState *s)
     if (!timeout && (s->blksize & BLOCK_SIZE_MASK) &&
         (s->cmdreg & SDHC_CMD_DATA_PRESENT)) {
         s->data_count = 0;
-        sdhci_data_transfer(s);
+        if ((s->trnmod & SDHC_TRNS_DMA) &&
+            sdhci_get_dma_type(s) != SDHC_CTRL_SDMA) {
+            sdhci_set_transfer_active(s);
+            sdhci_schedule_adma(s);
+        } else {
+            sdhci_data_transfer(s);
+        }
     }
 }
 
@@ -848,10 +881,10 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
     }
 }
 
-/* Advanced DMA data transfer */
-
-static void sdhci_do_adma(SDHCIState *s)
+/* Run one independently scheduled, quota-bounded ADMA batch */
+static void sdhci_adma_run_batch(void *opaque)
 {
+    SDHCIState *s = (SDHCIState *)opaque;
     unsigned int begin, length;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     const MemTxAttrs attrs = { .memory = true };
@@ -859,6 +892,35 @@ static void sdhci_do_adma(SDHCIState *s)
     MemTxResult res = MEMTX_ERROR;
     int i;
 
+    if (!sdhci_adma_transfer_active(s)) {
+        return;
+    }
+
+    switch (sdhci_get_dma_type(s)) {
+    case SDHC_CTRL_ADMA1_32:
+        if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
+            trace_sdhci_error("ADMA1 not supported");
+            return;
+        }
+        break;
+    case SDHC_CTRL_ADMA2_32:
+        if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
+            trace_sdhci_error("ADMA2 not supported");
+            return;
+        }
+        break;
+    case SDHC_CTRL_ADMA2_64:
+        if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
+            !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
+            trace_sdhci_error("64 bit ADMA not supported");
+            return;
+        }
+        break;
+    default:
+        trace_sdhci_error("Unsupported ADMA type");
+        return;
+    }
+
     if (s->trnmod & SDHC_TRNS_BLK_CNT_EN && !s->blkcnt) {
         /* Stop Multiple Transfer */
         sdhci_end_transfer(s);
@@ -956,15 +1018,17 @@ static void sdhci_do_adma(SDHCIState *s)
             }
             if (res != MEMTX_OK) {
                 s->data_count = 0;
+                s->admaerr &= ~SDHC_ADMAERR_STATE_MASK;
+                s->admaerr |= SDHC_ADMAERR_STATE_ST_TFR;
                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {
                     trace_sdhci_error("Set ADMA error flag");
                     s->errintsts |= SDHC_EIS_ADMAERR;
                     s->norintsts |= SDHC_NIS_ERR;
                 }
                 sdhci_update_irq(s);
-            } else {
-                s->admasysaddr += dscr.incr;
+                return;
             }
+            s->admasysaddr += dscr.incr;
             break;
         case SDHC_ADMA_ATTR_ACT_LINK:   /* link to next descriptor table */
             s->admasysaddr = dscr.addr;
@@ -1012,50 +1076,15 @@ static void sdhci_do_adma(SDHCIState *s)
     }
 
     /* we have unfinished business - reschedule to continue ADMA */
-    timer_mod(s->transfer_timer,
-                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + SDHC_TRANSFER_DELAY);
+    sdhci_schedule_adma(s);
 }
 
-/* Perform data transfer according to controller configuration */
-
-static void sdhci_data_transfer(void *opaque)
+/* Perform synchronous PIO or SDMA data transfer */
+static void sdhci_data_transfer(SDHCIState *s)
 {
-    SDHCIState *s = (SDHCIState *)opaque;
-
     if (s->trnmod & SDHC_TRNS_DMA) {
-        switch (sdhci_get_dma_type(s)) {
-        case SDHC_CTRL_SDMA:
-            sdhci_sdma_transfer(s);
-            break;
-        case SDHC_CTRL_ADMA1_32:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
-                trace_sdhci_error("ADMA1 not supported");
-                break;
-            }
-
-            sdhci_do_adma(s);
-            break;
-        case SDHC_CTRL_ADMA2_32:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK)) {
-                trace_sdhci_error("ADMA2 not supported");
-                break;
-            }
-
-            sdhci_do_adma(s);
-            break;
-        case SDHC_CTRL_ADMA2_64:
-            if (!(s->capareg & R_SDHC_CAPAB_ADMA2_MASK) ||
-                    !(s->capareg & R_SDHC_CAPAB_BUS64BIT_MASK)) {
-                trace_sdhci_error("64 bit ADMA not supported");
-                break;
-            }
-
-            sdhci_do_adma(s);
-            break;
-        default:
-            trace_sdhci_error("Unsupported DMA type");
-            break;
-        }
+        assert(sdhci_get_dma_type(s) == SDHC_CTRL_SDMA);
+        sdhci_sdma_transfer(s);
     } else {
         if ((s->trnmod & SDHC_TRNS_READ) && sdbus_data_ready(&s->sdbus)) {
             s->prnsts |= SDHC_DOING_READ | SDHC_DATA_INHIBIT |
@@ -1098,21 +1127,11 @@ sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
     return true;
 }
 
-static void sdhci_resume_pending_transfer(SDHCIState *s)
-{
-    timer_del(s->transfer_timer);
-    sdhci_data_transfer(s);
-}
-
 static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = (SDHCIState *)opaque;
     uint32_t ret = 0;
 
-    if (timer_pending(s->transfer_timer)) {
-        sdhci_resume_pending_transfer(s);
-    }
-
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         ret = s->sdmasysad;
@@ -1235,7 +1254,10 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
         s->norintsts &= ~SDHC_NIS_CMDCMP;
         break;
     case SDHC_RESET_DATA:
+        timer_del(s->transfer_timer);
         s->data_count = 0;
+        s->admaerr = 0;
+        s->errintsts &= ~SDHC_EIS_ADMAERR;
         s->prnsts &= ~(SDHC_SPACE_AVAILABLE | SDHC_DATA_AVAILABLE |
                 SDHC_DOING_READ | SDHC_DOING_WRITE |
                 SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
@@ -1244,6 +1266,10 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
         s->sdma_boundary_paused = false;
         s->norintsts &= ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
                 SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
+        if (!s->errintsts) {
+            s->norintsts &= ~SDHC_NIS_ERR;
+        }
+        sdhci_update_irq(s);
         break;
     }
 }
@@ -1257,10 +1283,6 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
     uint32_t value = val;
     value <<= shift;
 
-    if (timer_pending(s->transfer_timer)) {
-        sdhci_resume_pending_transfer(s);
-    }
-
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
         if (!TRANSFERRING_DATA(s->prnsts) ||
@@ -1521,7 +1543,7 @@ void sdhci_initfn(SDHCIState *s)
     s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                    sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                     sdhci_data_transfer, s);
+                                     sdhci_adma_run_batch, s);
 
     s->io_ops = &sdhci_mmio_ops;
 }
-- 
2.53.0



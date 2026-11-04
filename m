Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACD606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=ho/L/5Ag
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8q-0001p0-56; Wed, 04 Nov 2026 10:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8o-0001nw-DX; Wed, 04 Nov 2026 10:43:10 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8m-0001Gk-VV; Wed, 04 Nov 2026 10:43:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZGZ6BxDJXogXrKHuuiMadQi0hQtZzH588D7CPIiVu1N1bDynKUDsHPg8GGJUN1TQSKYmLzCwhHM9jIlrGTasC/pajLOcAkay+/SczcCXNYBHTxhmXFMR7aXI/ZZ2baNU9g3Al+O+15kO1WWaTfaZJUxRf2wGj6yUeFIsk4+BaMA2xL1fMD9b5XV9bq00oW2rmmLuRP9Ilpdqn7Y6pdDdcGD/EkX7rjBuIGnKDxbmdCrEfHjJozzMsUrLxvGsjNmcUCUMxThg6SkcygsYkFy5nS1MAuo7wu8+3hBKSdWJPO5wRHxgbMou8a1pgHAPpLALVE+Hn96EC68wVwp4f3mDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPbYcYb+Ea6brIzLdDAwzjRCiMKtli9g++a9RzhFMtI=;
 b=HTddHCm69uXL6BNRbHVAqBaWxYa7eVHWGfYv65qU1xXF9mq6SgmPNw95AdXEcsxeUkswjtJ7MLXgXsgLeTPbEIMJ4zrq6S7VUmplZ5vZr8OZhp8k2CqiCVnVoGKVb6PcqfBu/FBs6CRj6rSdykwjw4uMeU9ClE0KFmccn/bRhHoSh8n/XVjYA6Mll8BIVxGISt6BdxsNcrrDTA/SIVTfo9Qay3wG9G8C/uIdFrg6NHHl4XNvXtfuCD4ZWCbYLMkSFAXb7egrE9u7Uts6aGZzaLdMUwf5jhncthY/XmscTzOpFNdic4VTtzjeUpPATIKeX2C+W8rCxqUZ9gml6Vl3dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPbYcYb+Ea6brIzLdDAwzjRCiMKtli9g++a9RzhFMtI=;
 b=ho/L/5AgqVk7ZYvIQVZ5RiMdGUfIv5Dfvb1sSzPk+WEtumOl5cdqZI/ehzHY7d055U41v0kg/tzvfwDe06h3VYBQaLdZOPHl2xp6P1TtCHuWGUTnMtsf+C5fWccfEwIHidGxpkE8ZfvJ1n+c0+1esCvV3/MFXyUb4oEkwXjNJXLQXjICtPYvVwjIAxgM4B5kffCwjBTXwlxvRqvHlXZVrB5dRBcm36ysZjk+zMbcss6mqqi8fY0g9dORusdp476P6JPPLWezGenkD38K7xEbjecUcKS4t6aZZ7rItrt0S4INjRXPrlvvZzLAgtZVkKsJJB7DlmqpQ6jAIp8v99ODIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:42:56 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:56 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v5 17/26] hw/misc: pfsoc: Honor service notification requests
Date: Wed,  4 Nov 2026 23:41:44 +0800
Message-ID: <20261104154207.641511-18-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEZPR02MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f93daf-85c0-4af3-7256-08df3a8a4bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L5AG6NK/ObsjRYN3idmsAu0g041e4Rx0nxtHNbJ7F5W0Bz37ypFUlFi3+iVIRDp5ehpB9XT//6WcJc8mtM+eqkmGq0E35oGdQ/l7IjIOBbIQuCcoO6AcTz3uuwAYQ6Qb17KG2TcMsLGi1+4waAWmLX7vigSs0xinHpoMasp1iwaZfIpUDwdEij9/o4upvDAROY7n1HZGpvba4+9QbT3TsAqtDkcGoDGA1KBBk7lDirblX1QQncP7zry+I11SLoF9OROPmCHAZo02P6W3pBfnooI6ptddbEgWrLig27U3sD4BkfjLhLIJb/O16AuZ15xQrxbwtYbnl6oOS7bgmuwUN6rMhLvTYlaaHSnSv38jxQJc+7P9o7+9/mM4mARHkFBGu9IyGhp38De43fu8TUJIZQjVYyR6ctX2oVTIAuhc40OzpxUEkJM25Naxfk+KNOcghB3OqLS+nu9zdYEDKVA9SJnvNMqRIz8E3w8kYCernmjiJp7TiBZ14IcNvTXpEhSUtFBeUbhhiamfh91DQRQ9+jh6n8iOtQa+o4K0xCLCv5vOSpPq+khpu2uGgfjHii16dIv0fTqTdrjQTrDRfOjW81rRRBMATuU/ZPeh4NRnZBaXwwAhm1eVFTIL2XKtskMeSfxKmNBSQtI9cP8dwtUCoZDlZq8Ma5fT/38VzNu4R28=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fugYM2tN2acK90JYS3h3tAacusZBWDjKb4TTCx7Y7nii4AeMEZAWzokHrFXW?=
 =?us-ascii?Q?xy6PxWHyrHoJObKxruZ835xQZ/1omIPy+phIbcYQTMI0zWP4avEGycNYzfWL?=
 =?us-ascii?Q?2IFNT2RxDjXD0Lf/+XqY+lmFsjHunJ0mJEDwHE1UWeGHgdvPYTG9X9fCqdvD?=
 =?us-ascii?Q?d6tM1djUSj1+SpLm/UCAtCdkK96yfZLGShR+aL42+29WJgsn5vxbEO5hzkYP?=
 =?us-ascii?Q?LYQt/7HU8nE2shPE7AtL4SLIIkqyAW1DfyziFvotepfkUhZdkGtngcLoykY7?=
 =?us-ascii?Q?zzq2uZaHKj9ZzUbase+QCdYuiQJznA1P/AE6Hk1kbz2FGItsEyHEKhQEVMX5?=
 =?us-ascii?Q?OPwkD9UBeZ1EBeLvmQyrim4umTE52hZNs2hQbWBMBPvgtkSovxSwfPz37m2Q?=
 =?us-ascii?Q?eqRHX/0eB0X3TV/FrRoprIlDdttGkaOilPlQCk1ht5WRGqqQvCAtBhsR6eDz?=
 =?us-ascii?Q?+GsDL9EZ48uk4ye7T0tjL3iL9ahXQaby+e67J4IVokh8clDH6K1F4ceSorEi?=
 =?us-ascii?Q?GfysOewR+3S/UtYGOLMiPnKcGbhft+MpU2mz9lEyA6Jp1AJEc9HSY18xM06d?=
 =?us-ascii?Q?2x/LppLH+Xc7pTWLwnOfgwWtWayU6exr2q3NOxnnOv8go7BQEXuA3zwD3ySb?=
 =?us-ascii?Q?LbaMJ/ALo8L4jk1RhIPMj8jxZV3XnU6WqdO9AdsBDBhaZ5kJ7U+HkD/Sc3S3?=
 =?us-ascii?Q?0Vj0n/FmbP6vX6oDYIrgODviaJ9CYvkKk/HQdOlL3VQBURrW1Ek4HYA5RUnc?=
 =?us-ascii?Q?xXzQXL1WHYmLVs2k6IRUo9yW5rXAmL0KsErrWsr4XOydqUnUHtixMVurK255?=
 =?us-ascii?Q?Apy80CuGIPZVl6XAMHjCZCoDtzHeprbKWkhjyq85DvbpLCkP7fCSIP8Nqeem?=
 =?us-ascii?Q?8GuSBiXgCfsehh8CB8XYqllwyqwYRClzhbtsLobmeITta1tiUKmc+Hp9X+/8?=
 =?us-ascii?Q?rmvbk6Lm5EB0LzQqCzVKXhtVr4c+5C4M1Pk5o3UX0WIbSk5sIGgH+TcoCAZ9?=
 =?us-ascii?Q?XyGjJrT2Zf0CN2CilQLqz7Pevr5teCq/xhbAehJvOUANxJcyNQIA2+iiIamm?=
 =?us-ascii?Q?Wd9rj3/bmfUrIuz7O2ZxfEPJGVdpRcQkxU8r5r9Orl7Z4/+gHnWXy8kTuhPL?=
 =?us-ascii?Q?ByxX+3SNMq/XPNNt7hPgYZ4loZH/AcNfikhJryfjHUxEgMn/QTq4JguuO6Wx?=
 =?us-ascii?Q?MV46+fwdi5RY9Z8SzbyYDguW5A/aEo0sSodD+ey1S5pPUGdlJ8qDonoPSe7h?=
 =?us-ascii?Q?O/aL05Cal7/0GFRNkh5Qo26xuVkHpStLiFmnaqQbOrTXp6av6dCIY96DHvr5?=
 =?us-ascii?Q?GlZ2gQ53xxd35aiHnmEQMtYIY2ckOta0sjOFYl7owl/zNoDe74P5eO9pOvWP?=
 =?us-ascii?Q?qM4qAIjghqjQq+IHxDhTAhHLxQr6eS4PfPbPLzKbzkTySEdtISJPJfY1xa28?=
 =?us-ascii?Q?kfMif0StiS5nBVqWZuAyf1ipj8IyhRW0moGBbyg6oP/SNgflnjHIQvSwchCt?=
 =?us-ascii?Q?wK4FLHqnFEgey/gyUxVoviTW2tWg7mctTaPsw88vMn2zEBjcxjzJWk9t4qHY?=
 =?us-ascii?Q?JjUueuqm8DlpISLm1BwGg5GjtEwRduaRSoMgPpvnsdrPobo7Rdg8wTcrkdB8?=
 =?us-ascii?Q?W6yQ9X0Aa5xICbSypGWVY43gJLPPV0hPZXcCwy1sHAtq8kWac9Q8PgKMW1Jl?=
 =?us-ascii?Q?VL6qBLDEU6pLqdRpwwqE4z6uyk8NBQkPuf3jhYyP9QcFATtdIGu9zYQBi0l5?=
 =?us-ascii?Q?cQCX9WEkyiiWkvL3J4/QpxrMlsBxm2M=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f93daf-85c0-4af3-7256-08df3a8a4bfd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:56.5481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5K+rkG+Ym1feeVrbWPr1feaG71gzqaIGRfTgjNNEzTsXiaKq73ywztSIupLgFZ9sMzc11Tcn0SaFg2rBq7BsMko1paNHQkPInn8KDRpbDHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7162
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Polling firmware requests system services with REQUEST set and NOTIFY
clear. Raising PLIC source 96 for those requests leaves an interrupt
pending that Linux can receive before submitting its first request.
The mailbox interrupt handler then has no response buffer to fill.

Raise the completion interrupt only for requests with NOTIFY set.
The serial-number service already checks REQUEST before processing a
command.

Fixes: 592f0a9429b9 ("hw/{misc, riscv}: pfsoc: add system controller as unimplemented")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v3)

Changes in v3:
- Split the NOTIFY fix from interrupt acknowledgement wiring

 hw/misc/mchp_pfsoc_ioscb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index 850125c8b4..bde1917c10 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -247,7 +247,9 @@ static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
     }
 
     s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
-    qemu_irq_raise(s->irq);
+    if (value & SERVICES_CR_NOTIFY) {
+        qemu_irq_raise(s->irq);
+    }
 }
 
 static uint64_t mchp_pfsoc_ctrl_read(void *opaque, hwaddr offset,
-- 
2.53.0



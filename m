Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9624CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnlC-0007rK-VV; Tue, 13 Oct 2026 21:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjk-0005q5-He; Tue, 13 Oct 2026 21:25:00 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjj-0006vY-2G; Tue, 13 Oct 2026 21:24:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwCryo3XjgaeuEDcVJfqM+I4RrRwP8JGmBEWDe0qbuLd5nLJcFy0qEoH8hj5+oxIm9ZdJvZfjB5eoo5OVN4FrHUR0dieNGL44Q8ROkjisHFg0GymeQltYx22jRxo8Sd9INQKtDBwBl1ZlGJw3IJjfg1Ry27yQ+7HrS4iG3q+gKULUGFrpuDGmuKUJh2/PurIIiGffhgv7FxUJyVP/a7JvcjOeJKHWYHFUy+ce1p+u/qYWUzBsVqARVAdsIAvWbDGuUV9MMwt5UgyISHl7bZC08YvIsOMnxiTQYMNWZXtP8BeiIXcaJol9I/q684f122CnPyESEU+h62v9QPORoiyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPbYcYb+Ea6brIzLdDAwzjRCiMKtli9g++a9RzhFMtI=;
 b=y9ZzR/CZLostxfBP9mf2wvGj7VKzZpeRnvbaORko65nOnSKTd0DEwisc3doesGEI+mcijO+ncETMDim4rD5bN6WelbBX+lIDn7AOFXwVYxaD21lBnOaMwjvJhK59rmakzHvZAmR3BoIJBHsR4/5tlyIYDPMTCNtXPIHbYpHKpqf7ww9PQz8EkZlwaGT5rOUkkz2PX1qCSGQEEQn+zmdSdL9lc4ld5kap13RrXWzdMkl1WX/z1gfpvxkh0pYgKp21dIFyVEztYrPh+t30/98zzU2Vz5B5AInze/szb1hZ7/pyHku5yOVdQe3NQyADJE5+b2U+Xeh3fa/zNNNaLDzIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPbYcYb+Ea6brIzLdDAwzjRCiMKtli9g++a9RzhFMtI=;
 b=GOAT2IiRkQJSSeRswsZUVflaU6U5LJhteU5iUi6f+RIMrj0SPSIrOBs6zEW0rBE82vQ3alGIHWNFevtvOrCjHSUEEISdU9Xwtl4K810IBT5WFGJRN978QWsYErdTHmP71dvQXDVKiFS9d4NOdKex0FfxFkNDBC4wjM6Xo1sMNpWk/cZkjm0CjtciplztB4Mz52U89wKcR/3hvVicmfKPSUnrnffh/E/7cQ1lLA3LdOfTIcDKmPBmFAV8M+c+8BQ/AEsWa8u6Blg6XKRxTe9ERPsm+mdaXIGzoI9DV87wL+gHGztQWguqQwseQGqhPmLTupOvCsGyA6jIhDwp1JSmJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:34 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:34 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v4 18/27] hw/misc: pfsoc: Honor service notification requests
Date: Wed, 14 Oct 2026 09:22:58 +0800
Message-ID: <20261014012323.322790-19-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: feb50e56-2796-4d5d-32fc-08df2991e761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: J0yHTALZXlxwTdrgwcYx9Gbs21oFAS/icuAIiThGhQvQtAlthOF+0ylONEVf9qJJbH7FkzUqV2GHWjQVUMBO/gMrsi1nJj0XsloUBwNvwZxRmvFZPNqzBeToRwN0AGItrVZczXy/kv3TMhdwch84zyX5tJwpIQ1VZVNOOx9tx/XkywWi1qNcig5z9IcRoFYR3JWm0dk9d7amfn4RfFFDjYRIMLp33DJF30YRc8r9qZa6PA/sdad5NDiVWVrb5iC11mbR4NjeRt4YmMikezpZKiAXbfXXz0HitiKP1hvqLkNtgX4tpBz4AZ9T3JQ6lYwSec9XR+Iy0uqyATwXStCPbnIoOFg4DJDUz6ymPJ4RvxkLq0x1ghinu3976aCb9xFOhLBDqage84jV/pLHSVpZu2IhB0vbpAeks2OW6T8oDOLB7EIQ6B+PuVO2nzC8a1ZlMLiE4QKTyLWKtmOxZQjxubiuwDORNVkOE2TGRJp5GVtYW+qNV6bcMewFBuMvmFPAxlGeP0iGoKI+dKhf+NHrEX/86lw9xMLjVln55zY8A/IeQ+xQg+u1q3nzBaHJDeZYia+5pP2QUHH1/tJwUeJZndeIA8snZYgeMsAfoGiUf4qIRrODs8JQ+bGpnnzG7EtRQNB56iJ8YO5yLBF9WyKTCyUaXNYD1HZy8YVa3AZ3fD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LnSMmw+eGb5xFEIvKEtDlmRuiVr41xVId3n/MyEB0XBGbM1rvni2HF3maV2?=
 =?us-ascii?Q?JrbvTHAQpTv3Qir4G7X2cqEygcuzsBOL/22OeeYAK22AmAFThDKrNm+vttjk?=
 =?us-ascii?Q?RYov6p51MjIn/ZVzbg1KZc4zlPPtrGo9uJMy75PFLV1qvxeRC1c72JjCCZ/u?=
 =?us-ascii?Q?L1nBVf5wS0lxOpEHHHxwm6MNRlJUQeo96gWKApYkqMuaw+cl6zIf/Gn3hvpg?=
 =?us-ascii?Q?uQepnWyH0fgbVFnYbgQOxLt1s3+euxmeYEU/oeH/OxamZktN2uITHaH6FlnS?=
 =?us-ascii?Q?i38+4W5LvjMWa9N597YghuTfYf7f7oF1I1yYVhGBbo4VTS/jK7ygFjuWL7dz?=
 =?us-ascii?Q?JnSHX5p+2v4Kv/b1D3dC3vzluZfOvpvpuu5ldCtqU1pTSXdjWJyARp6++Gmz?=
 =?us-ascii?Q?x9+Vj0e/esShDDk/yjcGY1x0oNwNsRyJv+sj+kGLok4SrFHqfQEWJwwbuQsm?=
 =?us-ascii?Q?qgrfDRFu7Z6uEwI7qBEMLw9yaG8oUb3OKfWmH8i8wYpf4CSB8MeSzoqrXqGW?=
 =?us-ascii?Q?Ns4dO9dJUOp4IuE/u+JOZvdgwyMN0gkB3PzvAQlPNOcLGGznl/Uk7CzQ7i5i?=
 =?us-ascii?Q?C/6Kx8GhIw3LGMC542j+tmJbL7APDL6BfNVDZFjEsWByMb1XhCXVJkBQmPBZ?=
 =?us-ascii?Q?S1j7Yk3LXE4KAsT2BQixQWlROJK7IFeMHBkun1fflQqU5SEqD4WayOpyCEUY?=
 =?us-ascii?Q?l1CSKnGDTA+ueJe62pVfGowpSZZJuj8J7qJ5pyiFd0UtZdFXbweFWwHypFxe?=
 =?us-ascii?Q?ZZtZF+5fCQflChLeJ51p/GKiSY3LLb05/Hri/YyxNZeOxFhByNbAiioS1xVc?=
 =?us-ascii?Q?T0rgmjYOAosP3RqKI7IulPuNidXDR1dsgKtx3QfXeXuJByVT3lCdo5kcyhlR?=
 =?us-ascii?Q?7Q0mkuERBqqTSiz2/ekuDL53k/SlWUpM2IJh5LYPdO7SfwXcb8VAqWoYgNcr?=
 =?us-ascii?Q?dSIzpB4cHDJgIHdPpUtRYtqmysCA7LeK0eQUA6xjNd3NE0SBt3DqPDUgtqEi?=
 =?us-ascii?Q?f/qtx/DeWFU/om03Zx3XLHt44yVRjU7y2wtjPRUd+D0cfwianXgtXw7sCaYL?=
 =?us-ascii?Q?SaxDjHD8hVCx8JZ67qoeEi1d7wyN9WruHu/oO6aqd9Jln4ViFhp4wxYtOSdU?=
 =?us-ascii?Q?TYgZKp5wWY3vLUgYBs4KJ2KN84va/a1qDK3+fZNlmAtAPfjUu29Y+XYOtz7F?=
 =?us-ascii?Q?pLMF2koYO0UdiT/gdnwYHGqrLjAWX2kXo7qUwgiKzQn2n7X31gHGtAuiDA2c?=
 =?us-ascii?Q?QIiSRt7Brv3ou84QFDWzDODD2qBDRc+Ay5HSKx+2GQ5zxZKQF+XhU1GKkUOC?=
 =?us-ascii?Q?TP0jVooJ0WpVx19oHV2je8bmsvKKg9flWCrSWLrWJksyNBvUCMOLHMtnG6Aq?=
 =?us-ascii?Q?ohCwL3S3ZV6+5Q6z8m65roCFCwAtVYNjNM+XVVBnVwR+8XCqFNphYGhca7qE?=
 =?us-ascii?Q?jPxVHESJCIvcpdUokClN2f2TpCdzpEmi6HNwpEE1GHo6JDEo9kDoCCWPVviR?=
 =?us-ascii?Q?2HV2TbFMccj8VyWdL5SpLBrC8LvNGF0trQkq/6mXrIQkxidLOtf1QqbmGP5p?=
 =?us-ascii?Q?km2XwjWDbPAQqoNZy5+bynXyG59GhlcHL3a/XDa1vbZnRltH1gTRfrA0MK1k?=
 =?us-ascii?Q?KLXduRDNezaWn7rmsPbWvP3ff2nQw/+2PocJHDOqIrbV76LNec+u3Okur+R7?=
 =?us-ascii?Q?sz+ZQ102JkC7pogqIPaFIhZDvMBmxHix8NVXuaGcHYyLd5BSizwzlGi5Lqhb?=
 =?us-ascii?Q?VrcW55upqH9UvuxMZrZ33eJ9Yg0TGNE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb50e56-2796-4d5d-32fc-08df2991e761
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:34.0221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dn/+bblnX+GY7XALAjxkanglK0BXrKq204XXd20so1RB+t0re/A6yPSWHse7X1j0R5nGSiMeJiZbQ3PMg1ej97sgGQXpscGHt/UqVTOrQIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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



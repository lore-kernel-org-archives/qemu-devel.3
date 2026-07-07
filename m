Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728FEC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Gx-0003oe-1n; Tue, 07 Jul 2026 04:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gu-0003ng-OX; Tue, 07 Jul 2026 04:35:16 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gt-0008Pe-6X; Tue, 07 Jul 2026 04:35:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC61OGt/Bt/UoQj+XnI4Qy/5Q2JYMjmC5yv1oEaYakZOY3S+6q3L9BG8g7yxBI1dFUGbzP+/SFchgAATgTMcS+MvYVbAGlpQimIYv/Sfukp004CNapbBgn/Um9p8aVrEQsVa9lgyi7MBbZFWXH0+sJPbCefa/Itgmkz5jzjxacjSWYKWtvX1uyTGkve4CeG6pKBmw9xauyWHhqUOMSWRk24jGl0rp7WcCOKKW5sfC0YyIIh/XTjR3M0Le7yY7mxqrmMwxzocvvvBpswQJQ6WYtAqxQkFkC+AIrMNVfMyQ1f3PYK8/rdRvSIAuAjLAtGotW1IIQaRYUiYwGzuYm2Obw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4+AkQtse8RrYY+pb28XYMHEOh01fkHmXnpTmW5xf4o=;
 b=poAIDSrzLO2HoyTsQz8jwbJpwMlcy/gYReVCfF1hJVHCiBJvhiXyxxRHjr+cT2HCzBxTDjOfuFKpL6sgS6IdqW99yL9lgFk5MEiEMr4pA2Qey9f7Y/D+LLp+Wo1Sz/1L+Oc6JB65dphhc9QbwvXueFKoXYsi3IUjkswkqvv/takQghqa6QUxtOHAeodrq9hjkfJUWSyjYSOyGjxhddo36IuTmKWbwOOHwgkbqZoR41Jy+xXPwvnu2t7uTQ5DyO2kV5y55lF+lVfwK/icHWcqsvn7eQVOQ9p9vKzotcB28w9PM0o90MVc5j6arQtSWeISZQ3Hfd6vdWdHqwsFYW0Uog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4+AkQtse8RrYY+pb28XYMHEOh01fkHmXnpTmW5xf4o=;
 b=ZQjYBkA5MkKIPxeRlnG4IaCQGEpRDS4eNiReGZUsuNMZN+enTDGjyppoxqwAAe3tSk44RTYWgHhJEgccMcCLJaZFxRuG9SG1bVhVSk+9JXr5A2i+gRymHxIARypwf0QDwZmSiRl1psCNDxMyWsrAkwQeA6oANOUmJEj7KpQhKmEkg9VMlPQCMQFTRocP+htx9SQLA+Cw0fT6rNq1cEPSGE4HLwD701O5o/MxDGV07E+huadAboZ9lkQ8T818FHmp4bh072DMj9UE/o+Q3VmEEuUn7T2DhnnsC/Kvm440dfnSq1xZ3mK3SzhajAyDjN1w6Zb9Km0Iv/3BrhWcwGH/ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TY1PPF1A8DB1DA4.apcprd02.prod.outlook.com (2603:1096:408::94b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:35:07 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:35:07 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 07/10] hw/ssi: aspeed_smc: Fix direct-read dummy bytes
Date: Tue,  7 Jul 2026 16:34:26 +0800
Message-ID: <20260707083431.219671-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083431.219671-1-bin.meng@processmission.com>
References: <20260707083431.219671-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::6) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TY1PPF1A8DB1DA4:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e339edf-c22b-4321-538c-08dedc02a626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|34096008|7416014|376014|1800799024|23010399003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BMzHgpfurCwiX6rVAOktkBZSiIn7sXHkOi1rkiQk88d+yAqjV7PtRXZ5rZQ11aoURBZ2xZ9XVsLK05v1A3fofO51g1XoBBUEp2SGNAxX0OXXBiIBLmbJBZQUSMjt0EOWYhJQz4LCnz8YoskAk23VyGPe0CXlGmjs0mmGVhJGlbDMEGduLmBCM9Pd93wWB/W9HtiFIGf6bJDB00wwIQRhQq3IEtVhcG+d1GOkcHvd7r7PTfRVIMLMwyDFgrZDRZoWmu9D9+GL7q8atGAXBe/2lyrkroT4O01ugzEBNCnfIxT2Iq2I4ETTl71VEFaxjcHyRFV89ao5SPGxVCYcJEzXbSx+CggBU1+UCPIyZxFVp1DgW/bqk5p1ZCnrMKThDNgE1I++cbK71q8HHh69M95HYGmg2yIG0/AvOMFgHH3WJ1kdL0kIXdwZx0sUucVs+698qO4wivt03PN8MnTyXXF8xTmPs0fKM7U4uI2nAcb8vrc8Vu5SeM0ok2nkWLgypW/pzOJ+kySOqmjSmoikbvhr6ljCqgCgZO+jwBXnUL7Wi2USjY6Ios7eZRqm9IH3NsTQdVFx0cLB1GxicaSlVMQcH+Zfpk2l+RlnMRf78dmTM2ss+Y9BMaCZ75LcEOw7iyab7nLAK2Hw712VUC5YSufO5F/hGFU0dvjyW11YZHFJzZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(34096008)(7416014)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHY0bjN5djZEVmU5NG1obVRHb05IaXM1UTVCQ0pGdWN3TUYwdi82WjA4Skx6?=
 =?utf-8?B?UTZjdEdQYjVTVVVTekNLckFoV2U3N0RxbWppcFI1MlZmQytpcHFuM1Y5YzJz?=
 =?utf-8?B?S1RxZWltQm42RnppQUNONXM5aHRQZEJQcmJ3U2FvYTRrcU0vbkhWUVkzVUFF?=
 =?utf-8?B?ZlVndGQzSTErWXdWeHZtems5RWVVU1J1ZTk1THprVTU0VU1PQVVrb01CcmV6?=
 =?utf-8?B?bW5jeFRhaXBBRmNJQmZxMkU2LzYvYWJJdU8rOHg2SEdFWjNyUmFwUEhMQ2kz?=
 =?utf-8?B?Zzh2L08zalZnZHJVamFNMG9vUGpkcGdjQS9YU2srT2dYSzJ6OUpzQnBnUEtS?=
 =?utf-8?B?MU9oeGpVcTZXQ1lpU2xETytwOTNsS2hwZXUwWmxoTU41bTlibVc1NzV0VDJn?=
 =?utf-8?B?VWIwK3dtaU1hU3QrUGt1Z1J6cU81dXRJOWI5bEVyTzdjZ29nSVBac2RRdWN5?=
 =?utf-8?B?NGJRek41QmxtbXNyR1dTck93MkxwV0U2Tlc0ZVB1NWN2bjAvQkRUZkVURUdG?=
 =?utf-8?B?VUFqZkpJUkJKRHBRVjdNVm5wRGswTWR4d0I3b0psaVgvZ1N5S08waElEdUZy?=
 =?utf-8?B?b016UFRSNW8xR3V4eExlUmtySkpMOWw0Qlp4U1JNR1lrcE9EV2MxZW15TTg0?=
 =?utf-8?B?RjNhTkk5ZEdGMzZsRUNkaUxOaWtXbmQvMk5hMGE1YmdSUjFRTUx5VFhUbHAr?=
 =?utf-8?B?Y0lmMC91a3h0T2ZGUm5uVlhUcFp5VzdZRmMyYkNWYi9mNzAxWXNBQmlaNzF5?=
 =?utf-8?B?WjZXRjU3azAwTWsxcTFDRi9yYnE2RTlPSndmeFBUSkJMdlVVYWdjNlQra1ZL?=
 =?utf-8?B?Q2x1WFFoQmRQVm1JRzM3RU44OXV4OWtjTTRpeFF4YzM0cjQwOTk5UkRncXYr?=
 =?utf-8?B?S0R0SkxCWkJpTExCSjZxSVBMT2VlL0NNQWZnUlRndHVDQkhMRUVqZS8zN0l5?=
 =?utf-8?B?TGloMkF4L3A5ODhzbUkrRVpLNUd0bzI2ZXBNdzVVdVcxTHUvOXROekl5SVAy?=
 =?utf-8?B?U2hmbjEwcUFhRmZyekxNRU5rY29CK0Q0Q2puOUhRYkJ5b3U0V0pGOEp5bEZy?=
 =?utf-8?B?U3piaGoxbklnUzEzUXYxWTg4RUhGN1dGR2YrUlc3YkdpUjYxWlRlOWVmRjRy?=
 =?utf-8?B?MHBwMjhMWm9FSCtleERvQ3hMamtsRU9qbGVuOVF4TmtGL3lQTTloQndtbmY2?=
 =?utf-8?B?TDhheHM0akhjSmxTZlB4T0ZxYWNweFVOYk13RTUvNWxnYjNpTXJKN2VGcWsv?=
 =?utf-8?B?MU5wNk1xb1BZYVdhd2JncjYxMlZ2SVVpRjhmbmhnTVphK0pqQW5FVHdybWw2?=
 =?utf-8?B?TVl6TEc4UU9NUjk5RDY1Zk5KYkhoSVJWZzJHN0lUYVUzL2VuYmdXdTlQU2hD?=
 =?utf-8?B?Y3ZsTmVvOUd2ZG91RnU0YXpSbXViTjFvS29JRGZ5TGZLbStzVDc2eFh1RVJK?=
 =?utf-8?B?ZURhWjI5NnpFbGdVd0RSS25mM3dNL05DVmwwSEZjb2ZzQjBiZWJZQjVDdGdF?=
 =?utf-8?B?cloyNWlUN1FISVlxNGdrdEhzajNhZDYwMW4vOUxKcUFYd2dtUmx1N3NyaHlV?=
 =?utf-8?B?NVExRmlzaGFLK3gxd1lPU0VCaXBKd0hTMGJuWnN4dFQ2SjBUbS9qaWY4V1V4?=
 =?utf-8?B?R2lGNFE1N0NTOCtRMFpPVTczbzB2NlZCOXo3Ryt0RUtBWFlPbzVzRmhmUTJF?=
 =?utf-8?B?OU1IbVpvdkp1Vm5oSloxUWpXYXFuV2ZxY0NsdUNqZHphNW41aFdTWEtmSmt1?=
 =?utf-8?B?Q0E3U0xxU01icm5MdHA4aGgrS2dwODJqQ2FjSjYrZjRIUUsxZ0ZuWUhFSU4w?=
 =?utf-8?B?aDUxYUplZlZEOWRNNG1MRmwzUTJWUzNkZjFjM1JYbWVCSmdXOTAvNW5hcWxE?=
 =?utf-8?B?L0ZKY2c0RTVTdHdBN0J1K3RaU1NsTFpXSGlzeU4wUFFtQWF2cVZJdlgyRHFY?=
 =?utf-8?B?ZFp3VUhMSG9RQjhxWDd2TnB2WnZhU281d3BoQ1NYTzIwUzR5SXU3YUxFMVBw?=
 =?utf-8?B?QXlVZWoyR3VFZHh6K3ZoVlErTkIrWnFBMTBwL3ZyKzFqR3plMk9VZWJrbkls?=
 =?utf-8?B?OEVRc0Vwd3FnWHRqUnlvRHNZSjJwQ2ZTbWV1aWExQ0RSbjlvaHdtcFdnM2dn?=
 =?utf-8?B?K3F0dzhHUHcxL0lLTWpra2FlTXVkRU1HUStrODRDNTlKdERqOTNQWWU4YjhG?=
 =?utf-8?B?a2QvbXJvRk4wWEVvRmtORnFSTHdWM1VjQklTK1ozbU10TmtYVFpXK2tBalkv?=
 =?utf-8?B?UE9GYThFR1RJbUVxbEhlVWpINzBPQWdVN2wwR0tJNkFFMFM1THNveGtJY1Q5?=
 =?utf-8?B?aE8wY2FLVzNuNm1MMU84TVFJWjQ4RTFpdnpMZWZRNklMdzhtbnpmOE9OaHZj?=
 =?utf-8?Q?Hv1NZX/GKUw1Jw4s=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e339edf-c22b-4321-538c-08dedc02a626
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:35:07.0551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8mpL7k+ZfgPWD++q7F481Oucp/nQ2D7RAjHVjOTwELofUtVKARnR6x1regrGUDIVRYK48hqN1e+4Q7sWTHSZcr1Kpgl0425sFGj91hpvK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF1A8DB1DA4
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

m25p80 now consumes fast-read dummy phases as byte counts. The
ASPEED SMC direct-read path still treated the CEx dummy field as
raw cycles and emitted field * 8 SSI transfers. Convert the
ASPEED dummy field to SSI byte transfers using the selected
direct-read data width.

Fixes: ac2810defa9d ("aspeed/smc: handle dummy bytes when doing fast reads in command mode")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
---

(no changes since v1)

 hw/ssi/aspeed_smc.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index d87fbd798c..3f957d153f 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -449,19 +449,28 @@ static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
     return addr;
 }
 
-static int aspeed_smc_flash_dummies(const AspeedSMCFlash *fl)
+static int aspeed_smc_flash_dummy_bytes(const AspeedSMCFlash *fl)
 {
     const AspeedSMCState *s = fl->controller;
     uint32_t r_ctrl0 = s->regs[s->r_ctrl0 + fl->cs];
     uint32_t dummy_high = (r_ctrl0 >> CTRL_DUMMY_HIGH_SHIFT) & 0x1;
     uint32_t dummy_low = (r_ctrl0 >> CTRL_DUMMY_LOW_SHIFT) & 0x3;
-    uint32_t dummies = ((dummy_high << 2) | dummy_low) * 8;
+    uint32_t dummy_bytes = (dummy_high << 2) | dummy_low;
 
-    if (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA) {
-        dummies /= 2;
+    /*
+     * Scale the controller dummy field to SSI byte transfers using the
+     * direct-read dummy/address bus width.
+     */
+    if ((r_ctrl0 & CTRL_IO_QPI) ||
+        ((r_ctrl0 & CTRL_IO_QUAD_DATA) &&
+         (r_ctrl0 & CTRL_IO_QUAD_ADDR_DATA))) {
+        dummy_bytes *= 4;
+    } else if ((r_ctrl0 & CTRL_IO_DUAL_DATA) &&
+               (r_ctrl0 & CTRL_IO_DUAL_ADDR_DATA)) {
+        dummy_bytes *= 2;
     }
 
-    return dummies;
+    return dummy_bytes;
 }
 
 static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
@@ -487,7 +496,7 @@ static void aspeed_smc_flash_setup(AspeedSMCFlash *fl, uint32_t addr)
      * settings, let's check for fast read mode.
      */
     if (aspeed_smc_flash_mode(fl) == CTRL_FREADMODE) {
-        for (i = 0; i < aspeed_smc_flash_dummies(fl); i++) {
+        for (i = 0; i < aspeed_smc_flash_dummy_bytes(fl); i++) {
             ssi_transfer(fl->controller->spi, s->regs[R_DUMMY_DATA] & 0xff);
         }
     }
-- 
2.53.0



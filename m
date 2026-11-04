Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E4606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=nLlJF87V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd8h-0001lg-8H; Wed, 04 Nov 2026 10:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8f-0001k9-CQ; Wed, 04 Nov 2026 10:43:01 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd8d-0001Gk-Fs; Wed, 04 Nov 2026 10:43:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfGkPFZmRaN8cCe4qGdWXPV5Wq38YOw35/pZ2pG8jRJGo+FZrVrf/krg+qlwLlbUOyxh2gZr2uYijfFCAPM1wOQ6ZyF5FG2dytYSk98twBR70gkAXHcVa1rKKr0Q8X5EiwGYrKAVOJ0gh3wKp8be2sGGOooI69norepCi4iW7S0ovrztVJZTDzQnwY+cLA9xmKC+ykU4r8XLyrc6qJj0Ygfnux5qDx76wfbsGbTRSB6mkqVjy5I4xv4qV8L3Dt412VtN/M+VojEWftJkTiixCfY8pNffgc9Lf+cnyND2VtGs/RFpSA3/bqa6bAkUYMzyif41iz3+/0Ks2p+a3O4giA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=636P0fT2Nuwyzb50zoN0p+S5AO/mJmCSBWplAykOw+E=;
 b=XOeSo7QN02oSEOTUujiSdljArLqpJRhktdJy6ampDh9CzmeF3kM+1ZVBXyw1MtF3nE52GeoOb9oIe+EboKHnKsKrPMS4C4vTuCHHQrL/kLD3zFysI9egrzQM10I2/3BdO0KdpcGQfNOOP+1Fe/aarzKTiWuLs4W52RqklZJvTJ4ni81whbfz6gbSD0eHKNl5NsKgxW2as5H8iuGNwbG11f/VnLcA9Mkz4eSmsyE6y6/3YyekvEaJJe0SR8gEi6AQmr3/PaZbM3EsfxZvDsCy69egsk2rSLWg0yVpJ4W/3jIXDjY/w6hwlOErfxw++NdobG9Ynph8G4WcBcEDavDB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=636P0fT2Nuwyzb50zoN0p+S5AO/mJmCSBWplAykOw+E=;
 b=nLlJF87V7AzRe1rq+Vy2i4TdxlUiLTcrTMriKTRe18hUZebbRkne2FKwso6dGeb8+ESG2HMGAlTTvqwQ8imuMVKQRcjbGJBTv30LzIMbx+DRqibPzVyJuwJTA/zZ/TlIPE47A/M3vPCwyd6jhAdVuCY81N8H504RAbNLFoVGlaaE+PhEWhG9hwsUE+tTKH5vPMHMkpKgAKnqM4kql1CUGitlIo9+Ig9SRcOIFdsuIvAa0IubowytJW56WgtP82SNh3C41ZgRlONY6AyVnZHSTw3Cjue71I9KEcfwTbIUSRh558EjhHDVG1w8WdAYxS99p19M4X30oJO+FTW2X/3Opw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:42:51 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:42:51 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Chao Liu <chao.liu@processmission.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v5 14/26] hw/riscv: pfsoc: Add PolarFire SoC RTC to Icicle Kit
Date: Wed,  4 Nov 2026 23:41:41 +0800
Message-ID: <20261104154207.641511-15-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8d29f84c-420a-4203-570d-08df3a8a4923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|5023799004|56012099006|261021121427099003|261009223027099003|261022075727099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: d7Fm92ccAYjpuh1RRJ7p1n3/Kqsx8DgmKJLH9XJm/uTsOpOHuVSY/yKyIbmgVv8LbJSMQ0Ld4hTD5rw2owGOA9X/r1WC47LHGumYmyRvhqKm3kuxzJGMJex8IjDKy1+g4sf5Zr02V+i8/1sPJFFVS0SjsQzjw76PniScrPaWO8v0pCq0aUR2KgKPeZ4ucqTPp090qpX4TI6sJK2JZApPMdbLIsB5Ln+6xo1VFvwZWNM9qcbxgA4acUY3Fy3kYS0+hZ4I91zH/wUIrw1Lev1KNS37JrCmv5grF742MQmir0jmYpAPif1+4MdaqPLCLv4baXXhcempXEWH8njuyIpmcX+t4SQtLJuDRM7HWeWNKItYUqdakzPAN+/r3DKAknLebZ/JR2tfPRH6KcZHdSsg2W1mgPl/hxSEMYs+K9YM1y2/B6ZuKYjd58dgWaVIRLIFUC8vOweQjZje7lvXROeqj9Uwl1Nq+yIsospTCo4Nv65KKiA21d+t+eEM/HdST+RkNOflRmDTmwLL8J/jq3s8NoXBHBGzc6+8XQb5IFuUtst8fZugHtuSalPG4rjY/WYfr0Izt5TjzRpheWR3zzf42nJa/a99pNjsnvoe6UYTJTp+mRTp+pQu0Bu6kquU8qXgRc7nbPzBeHPEx/XKjsbK7+/ppbfWr8Cpe0K4pjf928k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(5023799004)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BvDoCf3I8U+gq9X7hjw6Av71rA4Ry0VuM8uth5uKErTjwMQDG8Iopjexea7s?=
 =?us-ascii?Q?BZmUs8EnV4C7Ydr4iF7OoerY856kOoX+JwXzTi/zHLq027Z0pHo19yHg8zaL?=
 =?us-ascii?Q?FpoKsgVVq1XK6SSnvaVGjVe+d1BG6IoaU4xpaj7siBhwwl2nxlb/sShHniUG?=
 =?us-ascii?Q?ib+hfpWqWeA+NLpe/Ogf+b7nCJbVdla1WYy7RTZXC5WF6z3gpNF8YaWqKcaY?=
 =?us-ascii?Q?kExmWBUOIuCnBtoQ4qjfF1WCm/rEs2nP4OhYqlI6+RA2i3zzRKinWTcbxp0C?=
 =?us-ascii?Q?U8EF5wF4oLLFTQdoZTWuB8eVjowX5pagOkQlq308tpSWQvytU3DlFdj/iRt9?=
 =?us-ascii?Q?cd0VcES3n7mLxD+4ZePyUjTZtmmEm+CHXHmvLVHLrlTp6zzUjbQlwUF5zJ0a?=
 =?us-ascii?Q?36eLBVbtNvlAxqhwQxLjKKbqa6IpJd4JvAyx+LQCAH2wkLLsG7XfNvGFUVfK?=
 =?us-ascii?Q?8J629qLrYfFHUFTvWoTJztRRFIc/CFhrMqYhhhkSo1FjIFENQ6RgvTcb8hfB?=
 =?us-ascii?Q?6kDY5OS+52BV/ylu7ujgkpp0CYcKSHBqqIVQkkZDtE+kM2G2n2N/E5p2xnPH?=
 =?us-ascii?Q?zQKaAstMjywf8jxHXlEYgcATsD3TtCIhVFi3lrPMlRWu26g5J8a6lZhJc9dG?=
 =?us-ascii?Q?wTGXIjYhyP6AMva0U3lX4QWbWVZgKQPlZSu79yL3aT4HBRyyI2RCshETYee+?=
 =?us-ascii?Q?KybE148PuhnrNGlg6WyGyGUCmCWUZCtGl0wnmnPMpqgX0U/y/DZRp3HxkHMn?=
 =?us-ascii?Q?QpvOYdJOAyAKYZ/v503RG/ZIXkfFkTt61P9L9wR+WbX/9PN4YJSE7e2gqVWr?=
 =?us-ascii?Q?e/TROMgiY2NTyHF573avLIPZFRbseKMMA5I1y9gbJz5nIdyj161gp2b3UMC/?=
 =?us-ascii?Q?gmbqsLgUN3VuqnQWcl7Rbg2Xs77BsOufo/HpL4eZMaXGsnYAPXVlI2uEdzuo?=
 =?us-ascii?Q?axgRGpoOg1r3PTtDNBKmBEwG0d/xPhkXZWW//6eKseVEEiEj0slzdjXwbZUO?=
 =?us-ascii?Q?Ve41MpsfS0phgRvppacd5fAaavrLYh2m6liIG0BscTeNdcCMP82Pl2fe/Qe+?=
 =?us-ascii?Q?oTxhqUGrrqupByvg9Ia8wrGe7TBlFFZObf8r6J5PJaOnPRKUM4gtLx+8FdGl?=
 =?us-ascii?Q?cKA1iOJ4t6iHq0FsXQmEeqcLO0gSYLluDxZC62qTPCIk/cN/ZasSfj/WH1ia?=
 =?us-ascii?Q?72A2TSMmVIQMoPHTyFSp8KS2WoiyDU27KRk0j81sH1iFSncOCoITdr05Xn7S?=
 =?us-ascii?Q?eFg38aqjpaMzZXtJ+ZkAxG9OcHhDrSgye0LYgPCgLlzUqOEfgeJG2+LFRQic?=
 =?us-ascii?Q?R3iragTc48EayOEUdvNjVIP53eWK5Va4BK3T7z7gvaiFDq3Xw1+uZ5IVV4Kv?=
 =?us-ascii?Q?GeqVggSBcwVnDUQYACwwrzxh42HkIQQEj/BdzblAz2n3lyYFDEAZuLNqdUSb?=
 =?us-ascii?Q?WijU1CUM411/IJ0n/Ox2Tek0DCxQXoSTmdQWJYcrJzYAgd1tDsBIOFAqGtl+?=
 =?us-ascii?Q?y18ujjWutHH9AOimdiueic3r6MS5QHSMtbphTowjbRcdxbCrSb3D+xY8vX1i?=
 =?us-ascii?Q?url0uOzVCRtElCwl/mFRWPT/vAoWU2kISsR4ArLFD0uLyCQo5WzCO0eX9xUN?=
 =?us-ascii?Q?0bIdbafPJOnPxirQar7vLU9QJW64jkpgBDTLIkuzFoUcGONoVfnz8TxElaYF?=
 =?us-ascii?Q?V73ILMkH5WhUvgOGD8UEwe6LRqnupO6+9bTX80KaJkH7MmZVPlRgch/v/RH7?=
 =?us-ascii?Q?ZyfjqBlB6eM/zJqc3ZLrAr3JKWJ+cU4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d29f84c-420a-4203-570d-08df3a8a4923
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:42:51.7772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UP+yXHZDDZjRRXjuSv+0JorAAURBsG86pR3TzAAwRbpJTe33nyNNY1OE23mwekLR2bHoxN8PYFHBpaLSqd46i878zPzDjIXDJBzHpUe8pk=
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Icicle Kit memory map advertises the PolarFire RTC, but the
machine leaves its MMIO range unmapped. Linux faults when it
programs the RTC prescaler during boot.

Select and instantiate the RTC, map it at the documented address,
and wire its wakeup and match outputs to PLIC interrupts 80 and 81.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
---

(no changes since v1)

 include/hw/riscv/microchip_pfsoc.h |  4 ++++
 hw/riscv/microchip_pfsoc.c         | 11 +++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 16 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 18f5003850..5827d6be2f 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -31,6 +31,7 @@
 #include "hw/misc/mchp_pfsoc_ioscb.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "hw/net/cadence_gem.h"
+#include "hw/rtc/mchp_pfsoc_rtc.h"
 #include "hw/sd/cadence_sdhci.h"
 #include "hw/riscv/riscv_hart.h"
 
@@ -53,6 +54,7 @@ typedef struct MicrochipPFSoCState {
     MchpPfSoCMMUartState *serial2;
     MchpPfSoCMMUartState *serial3;
     MchpPfSoCMMUartState *serial4;
+    MchpPfSoCRtcState rtc;
     MchpPfSoCSysregState sysreg;
     SiFivePDMAState dma;
     CadenceGEMState gem0;
@@ -148,6 +150,8 @@ enum {
     MICROCHIP_PFSOC_DMA_IRQ7 = 12,
     MICROCHIP_PFSOC_GEM0_IRQ = 64,
     MICROCHIP_PFSOC_GEM1_IRQ = 70,
+    MICROCHIP_PFSOC_RTC_WAKEUP_IRQ = 80,
+    MICROCHIP_PFSOC_RTC_MATCH_IRQ = 81,
     MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
     MICROCHIP_PFSOC_MMUART0_IRQ = 90,
     MICROCHIP_PFSOC_MMUART1_IRQ = 91,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 6d943a224b..55ca8a244a 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -184,6 +184,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "sysreg", &s->sysreg,
                             TYPE_MCHP_PFSOC_SYSREG);
 
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_MCHP_PFSOC_RTC);
+
     object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
                             TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
     object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
@@ -294,6 +296,15 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_PLIC].size);
     g_free(plic_hart_config);
 
+    /* RTC */
+    sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0,
+                    memmap[MICROCHIP_PFSOC_RTC].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_RTC_WAKEUP_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 1,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_RTC_MATCH_IRQ));
+
     /* DMA */
     sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0,
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 19c6667ed6..147a02a49f 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -19,6 +19,7 @@ config MICROCHIP_PFSOC
     select MCHP_PFSOC_DMC
     select MCHP_PFSOC_IOSCB
     select MCHP_PFSOC_MMUART
+    select MCHP_PFSOC_RTC
     select MCHP_PFSOC_SYSREG
     select RISCV_ACLINT
     select SIFIVE_L2CC
-- 
2.53.0



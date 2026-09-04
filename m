Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDEEC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WZi-0004EC-GG; Fri, 04 Sep 2026 12:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZf-00049z-VT; Fri, 04 Sep 2026 12:15:32 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZe-0008SI-5t; Fri, 04 Sep 2026 12:15:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgvxoxwYdFeAoU8lKxOnbGGlBlt/3M8LnCmIelZiVDSV9fFu51gMv1CMN5tKeZdzXyY7Xc2tgHUd8tCKbbtlyhCPx7LzxR/TdLfQQG0xxFBtjb6cd1/ntkuRBDk2rvdVLe4jdJq/+Fvzn3n9VAfAk38+NTdXOOPGs5Z2pnco4PRx+sKqxdSRD+9cwYrHF1rdc4kGXvvnmRCyIHOb9vX5y1rmBPwyE5rTluZBQIABze/wl6BOjeO0hblszyberuJFsocHPJFOhhHfrYBrLyLm6Q5z3OwlT8jG5O6R+LAEehekuyjnqoPH379RmYOjdbRzuKXHZBVqWwgd0xNeChesUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jdp9FzqJ1gqvuZW3nQIrtXoN2Ie8KfCKh+VapebI45I=;
 b=yxcxsYO+7dY0WOdVgRzRnHdZCHcTCBskHeN+VE61DFFDuMUMNiH707vuPZbNQFXMuEjynL7JnfclUCua+pR8y2BTjxvjXATUulwj9eO8FMk78HO0cYWE8DTaX/KsrJzP5YQgQDPpFhPZE79g/ZOHe8Ca5EIomgg30xSeWI1OFwksz2Vxu+yu9b5ThiYKOuzmGrtJpOlePgpoi+skj5uQRjhJ308LIdHMUX1NHz9spEQsYSUCTnU1IIVaSpkpRYDngd7qc4p+Yr4vke+bQMA8irDRU9e7fCo2UwR7eXuiwSE42xl5+hBcWAJeuRdJ/+xbgdcrZCxE7mta1rRmne0tDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdp9FzqJ1gqvuZW3nQIrtXoN2Ie8KfCKh+VapebI45I=;
 b=HLZ2K8HsBEEqjJk6+8wd77IIpjcFgF7xw5gZZInr/nzs2rbl1JLRQ59CT/ki4Jopoxaec0FhIz57xDUgYBO+CnIbtQvvLC6RR1Q51VlNrTNj4VYwIesIoNawrU3PiEAM2EegCAW+gnHT06fVLhp7JIUrkbwGIRwp0ERv4Gep59zQ228KmKW/W2r9E4i1MipvDfQu0HEA1BGHsVPhwJ+euixliq8iBqOnq76L2X/yypIcS3aF63TIZWR7FmvjCYG99yFvKzWW0OcIJm7Kl4f3d6n53G2MyzDFLr/sZYOFfXS1scqPNHpwvT333A0MbLNQdE3lCqAee7W+lJChIZTl4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:26 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:26 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v2 07/10] hw/sd: sdhci: Preserve uSDHC status enables for
 U-Boot
Date: Sat,  5 Sep 2026 00:14:30 +0800
Message-ID: <20260904161438.3838261-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904161438.3838261-1-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::19) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KU2PPFE04A6CE19:EE_
X-MS-Office365-Filtering-Correlation-Id: 614459e0-f036-43eb-d215-08df0a9fbac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|3023799007|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8TGshBhye0eeZhnnXVD/p5m/1JsnPvR39EA1qRHRuYrv78cQq1cplrE7Ss4rNs2l0/vmPUW+g07hozEt8UYv03d4PyM467+YfAosbZcMo/lK0MlncZe8xq2cRPC5eiC3dauLm43mXBqw2YFMoyn8BWDwIIvv7SPQvpL97ZBinhjevM3xD9Aq2SDMOrzdimbdIVJwiez0j463yFy7JK4KHp36dCWjmnfY9dxrPmwj2M1F5AUefH/BpojSJsLWmp1BaHmF/f/iGL5pIRCoai7mVerxCFCSrp32ZEY3VY1xl08OuNNhYz97CtOW1S8bY19/MJ0MF8zUqVi4736Rc2zN42Sg0E389QSjPezSkAcAb03mnPVS+0lLSx7Lkm0zmT5+WlYoSlp8maGadBmzgJvkyPDaq+8ibDNQLREAS/sXerVYwIePAZLHYB0unT/CCnJi62USv2C5mxW4epbkSy0/G2P7lzVHfq1/shypA9rcsc3wU41GIEF9UgOJK7E4o+jkQH9GCbr7Qc63TPgFkE8nM+EDpvvEl66F/PZNBDvlOCNR7ylpmd/LkobrX2/ZTY7fcl7dYdW2abrOKemtR53IGQyMES2O/RQw2kUEa0NZgVkv/hAG9UAg82vo5KwSscRIvgNj9UH2BzYUc3deHDNcCunOiQnCVeQ0P7GbCEQIQxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bqWFPnPI+NTewh9Zkv9da84ZL5yianZW8C8TGUE9Ln2Em/CopVvCOMzIVdQl?=
 =?us-ascii?Q?ZwDNaRtQ2hRmA5HXaSGrDXvqnMMkxeZxi2F0hueWCyhDXfcwCxUOJECNs2RO?=
 =?us-ascii?Q?F2S5xLUbw1tudzlNP4jvDMoDcqdZZ99R/F8tGqOLZ2EFq0ro/pG65a2QAXeG?=
 =?us-ascii?Q?tVRBAo7L5zHtUt2qad8bH4+N82WB/wS+YKLsi0kfdonsGA0qY3WHDE5EHh2p?=
 =?us-ascii?Q?PjoxymyXyj9A5JCqS6eoySCUoZLkxXGWc61RLocs/2rCoaroSzp0W3dTLmJk?=
 =?us-ascii?Q?i3rJNb6vcN7GVXBjxFAgCgZouALZyyH9IggtImXhCfxDOIhEvQ4e7fRKXJa0?=
 =?us-ascii?Q?y3n0Kc0brRq11pXGGyOZomf2F7Ux/gfCSROzCH8AbCOpWO49CWgTe8tWrCJ0?=
 =?us-ascii?Q?v4+UdT1u2MeFtUwXhGzcEMh3huVvkOGdNX9Em63+3305rKiggInIdgoz4bkG?=
 =?us-ascii?Q?HMckZvasOhJomZaJKuAfQIQ+N2v613suDe6BSiOcsukbaFNJqUrODk+iv82M?=
 =?us-ascii?Q?iUfQEyWTwYsv6K39qv9wD+jf1OTUGBTRzbecjaOYTqUzTb7f1o1yE6WPTUuU?=
 =?us-ascii?Q?duCetDDPJIrL0cdm7Gc8r9K4Exl+5Qi+hLYS3IH+baWexwqMWe4n00g4AY80?=
 =?us-ascii?Q?kAOQm4d39DFrxXzE099cNtjYO0vaJZA1xMnaLHgt/gbZPuJupfZ84oVs/lkO?=
 =?us-ascii?Q?wky1+skzQRbqrw/RonzzPF0c9RnjbDU1ge64yQp2dCH9Xbr/Boh05pIuwQkF?=
 =?us-ascii?Q?cbpqF52EgzDkpRWUn1IHns5yTYtyHeZFVnwFbzJSsPvV3EDvJt62wgTHxqAs?=
 =?us-ascii?Q?zUegsFjaOh7/bs6XnG+6N8NDWkFCTDhb5NIbTxHef/XNDsO4m+1bwjIWrQQ1?=
 =?us-ascii?Q?NgZL1jjR8XTA5a6AEtxRKm6TKtoLjfGRaUUe2ci4KVE/fIEKOHG4fLO4ZJqz?=
 =?us-ascii?Q?a+nSn5xF2cfS/ms/Kaw43CdMdOKtFeZd5f8rDLhXe8yYMuOeYyd1cSgppv3f?=
 =?us-ascii?Q?CRyYtMx51hXeba7XTXR9ZgMaEkNfJRysNm/nPEP19ppbZNPYCf36VjAvhogF?=
 =?us-ascii?Q?IJX1JLyF5l5PHOqqA4jYO0xEngFYkX+kQIkEhOFsj6x4JtsnMZ4nHq5Drdmm?=
 =?us-ascii?Q?VeZG9LY53JYpU3m118MHlVWTT9KWvlDHxmppfCCYJG2v6JC5nKOBy1i2XMka?=
 =?us-ascii?Q?VCGbTkiLVz6FTf3ABaKcU1JuOSa3swNdB8iAROLY1aWTi2RvieErEKYQHdB0?=
 =?us-ascii?Q?eN4AFbRKzN6Y7jDmoH51CBt3UPqHXUN1I/aw7Cs35rkrF4T5Pz/8E/kmFg7p?=
 =?us-ascii?Q?flJn9bAb69XQUhU5veWXmUK0Tfn7wVFocP95RaF3273WgK9Zej49nSKUoiOJ?=
 =?us-ascii?Q?9Su+bj7AsAigNJEtHWP3Tr9mp2KZYfLD+r1GtkihmkisfeR8rBi/b5m/8rMK?=
 =?us-ascii?Q?iMu/cn4n7eZxiJ/n5lhZN4ncXyvY441ySz9YZyeYyITGNxPxxoZrAiJkIcPL?=
 =?us-ascii?Q?P1hZWNMX40uxjVjyGrEAH70sqxN6qbfoMn9KWGNRCsDvLjDL08s6KDElRqOm?=
 =?us-ascii?Q?0HMIV9mi6hTWDsvZG6S4V5MFz15BJu5x6FBwPcPIJmBR0mlrFrNGPnUdoDoU?=
 =?us-ascii?Q?01qprfXNgflHGua0l+cpGYriY+rBvsJB09+fqMTWBnMknwW26s7VlEEpUfs7?=
 =?us-ascii?Q?D7zzf75lRynBsjDjAoNgeDetVVlCgO0yQgbGCd4FOAFs4g5SF2kwJpEp7gCJ?=
 =?us-ascii?Q?ZHdHSlj1rEp9keu6JRx9y1tSshmmj44=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614459e0-f036-43eb-d215-08df0a9fbac2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:26.0227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8Sw8VIdkcIqWAF7CKvLKZvlMBYTzjkGDCNn+P4se9Y6xzeY6c5Z6XGEqBQsiW6OTjNq2JtHIB38amfEUk1XraReVKNtWhBbAilJc81eqqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE04A6CE19
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

(no changes since v1)

 hw/sd/sdhci.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index b6e447a805..4d7bbdbe7a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1822,6 +1822,7 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_TUNING_CTRL               0xcc
 #define ESDHC_TUNE_CTRL_STATUS          0x68
 #define ESDHC_WTMK_LVL                  0x44
+#define ESDHC_SYSCTL_RSTA               BIT(24)
 
 /* Undocumented register used by guests working around erratum ERR004536 */
 #define ESDHC_UNDOCUMENTED_REG27        0x6c
@@ -2117,6 +2118,32 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
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



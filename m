Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC4EC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weYyk-00022D-Rq; Tue, 30 Jun 2026 09:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyj-00021w-7W; Tue, 30 Jun 2026 09:58:21 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1weYyh-0003om-PI; Tue, 30 Jun 2026 09:58:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDEtARkobSzhErl+EkiQTNQTp1sl+Kn4uFF3pDBF+JjF+bUxIhVnNYSk/VZ2IWCP9ksZG7LOSR5Jzgfu5S8xaB4Ol8+4XVe5qcH1Z3WM7yoCfPuFUHcI1sXYqvSZhHfChFZ96eqxekVgcyao3+QX1//Mq7TVePj3eKspgwrr6r1A6Vh3TRhYz0QqwwbnpfaOa5Cv1wx61YFYgWvlUacd+g6+qcUY1PLpCH6NgbmUG8Vvfj0yhOWrN9OCZ7qeTvmFaULbLsyYp9BkZ6JjQMajkhTcwLePzOszX0Lz9wObbpyCa00tJ7UKW6bHuUIet9KSECKe7PqZzPEwUcZopadktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGmPDBWqCwiArwDhd8Rn3QymfbMVCqJHdwEpowZbNxs=;
 b=GrQuxbbdzfbxVelxRNcGgTDAN5EwdFfQK/PyWmBDKju7W1apFatMkS4jT8XhmDEevuiCV8sU9BcNfBfcGxq/ubqG2chRJebhJHoc59QpgpI48q+oZBLv8rgH4Er9JS6QYgW/f9rcpM2j5H+sVpb29DjPLUkkfwSEICnT6DUKcNoetxKBjfrgkXKNR59zm5C+1KY1sPhswprXRu8olsXdtS5eAZmtZxX6Y0E5j5CVOAgpmo7DaVqXR1gHbIFgRk0H9bM9LTUm/3sOGkNJOKcJxiU6XboNUbyH2lBXfgbcPEHrR9mIWPOz0KE4pJDbMxYlCyQhWSfRfeYPsRo9eKHu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGmPDBWqCwiArwDhd8Rn3QymfbMVCqJHdwEpowZbNxs=;
 b=CeAl0XAMajMCz2oz9PtAwe0/p2zVIRd5/t9oGV4hcgwL26fnNYpCWnpMtGzNb28jB7ZxS7bgWD0XgK/itEwpXfRBWBknYh5fih5RDqSWDTg3Pn+HU9Z7i6pQX7Lm5GQ3pdwQPz9AD1XwJMeXnDZO+41iKaBQrWelHARuXUdLATvBwFigj4eJPgtPVXoEAWGpbIVRWCUWmXk9P7nGOOSTevjbsiDkpXWPsRvdCqtoz2UGzWzhpXadi23ajQlTIcAwVK/Ws7rWXnB8DfzxEPSmJbiNvr7cX42NJisW4N2WKb8Ijrjlj7K8meg2F7Q/KHAWzgGb7RpBOBMpuvFjMuSgkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TYPPR02MB8959.apcprd02.prod.outlook.com (2603:1096:405:382::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:58:06 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:58:06 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hao Wu <wuhaotsh@google.com>,
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Subject: [PATCH 05/10] hw/ssi: npcm7xx_fiu: Correct the dummy cycle emulation
 logic
Date: Tue, 30 Jun 2026 21:57:24 +0800
Message-Id: <20260630135729.466264-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630135729.466264-1-bin.meng@processmission.com>
References: <20260630135729.466264-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0161.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::15) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TYPPR02MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 13435999-98eb-4686-02d3-08ded6af9c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|34096008|23010399003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ku6VAmU0GyN+U0PZYnmQOluAfeUbILWLgfrspmzNiOv17K2X7/XHjopPA2Qe0gZDWJOKYKa6HjpQ1Uog4Lr/T1Kd/cSID/+R+R2DhQAGfgt+fuWlwoXIZKss1/Cl30ksMNnSEKV6Pjg7Tq0NGsXIAT/70r8XvxrZHXzG8ENCefMm7teIOG1i67rYprVph0c8ekl7yW8SLWjXROg0YVdMejpr0j/UE9MQEAUGwRmk4JRLH+vLl9SS2idRT08GBcTI7zdLxKEFmDxTI0uwyeFcannGQF4iOGRWCTZzdS/HkS97l7qmRLFpk/3wlNzS/a7oVjo6PQNAccowjgZoAgcr8Us+DCCYb1CD6r9emTlHrwpFlnaS8KFI5KNg+z2Vjy2xNkHfJd3JRL3zZwq5bHuquSLyT9+FV/EMHmZBLQKlVWFOK4drDRRLBhEX+aXvVkaRt8Rp97MaCo01Uqy6WjcMoaSrfF7Z+lF7foECm7iAbdK4OOZcbALIhLNsqsno8jk0DnTPSFAQl81280MuguMJJTCAlHPaHHM4SlsO/5heboOXtkfCEu6lEXn9ruvvnCFYvO1zMobWcWeIrmH6hAKORB4lp/RXhFeAz8DeWje5pqDDJJ/DPrgcC+s0zTEETYiztZtSlOYzXEErczdNw8Vhy7KfkvVdV+Ul8pxtPDV9tjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(34096008)(23010399003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?06ZNM4lZX+ByFPLic26kIfhWVTFzD8/NK8SSaXDbW0c33ssHW6FO65W18mMM?=
 =?us-ascii?Q?a5S8jXcTfu5cVsbluLQ/G7zOPUU19wGqVpL4dMmdNe57nFClxY5am8FtdacT?=
 =?us-ascii?Q?5ZNVTSA59EJhw8sejrM0hhXbzTlBlb0PvpxXRw5/mGlWG9NtZpTH1r0sKEC7?=
 =?us-ascii?Q?bNI1HuUKb5I2dgNUjizKKbBdvs145WqrGW2aLU65+gMAXnZUSB3n8u2hEmxa?=
 =?us-ascii?Q?649uurxK1XygSoa8z8ExBRXhSxtnl/ArBC70neWazwNmHtMqjWjQPLT1j80X?=
 =?us-ascii?Q?caqab3+qvT2BYOeH0Z6J0m1JwXRrN0unrClAatjZBbNosxHcjVrT1htlheUa?=
 =?us-ascii?Q?ueSBE6W5HwA1mAew76D1zHo6+JXRNmCqVjsH6ayAo+eRGiC4kBxXR+VJIz30?=
 =?us-ascii?Q?BfmoVCzDKYqAgtes02nNA+yzS2TtpRtBJ+d+jevCXHXq90Yba8fDj91pfRec?=
 =?us-ascii?Q?aOJCRZ1rfKnah/K1/8G4tpxr8e+MZ5qoAZ+6k8Frz5+UV5I0jogEzikbXqxC?=
 =?us-ascii?Q?vZw/ZYCWXyMbkQ/ib7p+uPUwm9s9Fcv5/1ZjgST/9UsoRqPKXsbB6HEI7CT+?=
 =?us-ascii?Q?PB688M8H1aORMTIAkiq7V6YMnvMu3k87FekFz9r0m5T7z5qWKmSSqx0qRP+9?=
 =?us-ascii?Q?myuYE1GX2sejETz63F7h633IL6Q0wZpT4Ruh/1pacnZl5ksMNMcOYR0s9/hB?=
 =?us-ascii?Q?ZkHTXWYgFR9KLdfZO405JOjQJYZDTo9QP64dcKj9h4HE3dfZDcqMoNLMTwFL?=
 =?us-ascii?Q?P1Eza56kvQ/4/nkG5ksduKoLBCQ4CjMsC31KGBIoXeI8b8aLK/6ZGHRIcY9P?=
 =?us-ascii?Q?1OzkxOKrdjIE5Nc2FqTcX3b+Dz3n+7GhgJtcqwVhiPEqEnHsl8euIYbzbhNz?=
 =?us-ascii?Q?gaCFqV1+3wpH1dWMFSo/SnjhAoLmtVeRwroFNLUkgkE0yQQtie3Av6I6arKz?=
 =?us-ascii?Q?Je61voQ/s5msV8EEJv5zzjqAAgAaQHvqtoFYPXyOe9TWzPjlYIjSLRcUkLPU?=
 =?us-ascii?Q?J3ui2keQeCrxApj5jO1vIWY0IyeE4sjnMiP387hRBUOIBGXb0TJ/3Iy5xkeo?=
 =?us-ascii?Q?j4Fj57tIqfzb1bDtG4nTJTexpD3WBffLRfsLeL+Y251/7pdQHdaEuBE2yLFN?=
 =?us-ascii?Q?RttY4Rq54Mndgv1UPcjTuQN/yKZYDX6NjYzUwdDQllsH9lDwED0KcBirZDhq?=
 =?us-ascii?Q?vcMnaeiuhv/mO+JMEHuog9+9mjMumngzgAMio1oAvoEWweiYZ5d9rELTVdio?=
 =?us-ascii?Q?r4/g6er2naa3re+bkQSZ1t68FMNsRA0vui729brDtm/6cKqDaGFBMjk78j4S?=
 =?us-ascii?Q?xZJJj7ZLURu4EwQwbLRLmLQcC2KOys+9rxruWdfXXIFdPFz9bxah5oTiKCuh?=
 =?us-ascii?Q?5Nl0+DcR6ETfobjAma428ZgORD9wgh2dME+HkkgsmKNqSYSu0a/UpbEQdbum?=
 =?us-ascii?Q?7RxYHGQNWO++BkT3JMMZEix0Na/MsqTC78E4F7YoeEZU1vv0Jvf+/J1WlUqN?=
 =?us-ascii?Q?3AxQF6AvlIJ84n9nG06MyQKjsxw2/zscSfVabtn2sZozJEAdIT6jA3+oSWbw?=
 =?us-ascii?Q?hbSJfgFQOnMfrV/4h3f8GClfeOmZyyIjVX0DxipF+lfQK4NldQIm6C0z9Pch?=
 =?us-ascii?Q?aSYLMs5IIQcjDFAm4PPJmaj0wlPXoJekb+j08d/3ijFWw3ZKcTsvFLde+8Ld?=
 =?us-ascii?Q?8E60XyDCHJkY2LLZ9B5H8HY4BTrVa7CSzsK/cObcPOJUjj9H2j0YOtgawB3h?=
 =?us-ascii?Q?BAb23WQEufSfVe/CF3gr7EHrYB4mWTo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13435999-98eb-4686-02d3-08ded6af9c6a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:58:06.6391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5HUi3VnCTflhR9PjQ0/OfsEiwLOphqB2hyxJg+mgQyKQHsNghh9QlN8uotPBNsNDNUPy0dx2wVc9sA3d4n9p5KMScVU7CyFQ6mxGaHzPso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8959
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

Change send_dummy_bits() to send_dummy_bytes() as the FIU register
fields are programmed from spi_mem_op.dummy.nbytes, so they already
describe byte transfers.

Verified the changes by booting OpenBMC image on `gbs` machine all
the way to the Linux login shell:

$ qemu-system-arm -machine quanta-gbs-bmc -nographic \
      -drive file=image.mtd,if=mtd,bus=0,unit=0,format=raw

Fixes: b821242c7b3b ("hw/ssi: NPCM7xx Flash Interface Unit device model")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/ssi/npcm7xx_fiu.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 2d5bed005a..31900bbb68 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -150,7 +150,7 @@ static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
     NPCM7xxFIUState *fiu = f->fiu;
     uint64_t value = 0;
     uint32_t drd_cfg;
-    int dummy_cycles;
+    int dummy_bytes;
     int i;
 
     if (fiu->active_cs != -1) {
@@ -180,10 +180,8 @@ static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
         break;
     }
 
-    /* Flash chip model expects one transfer per dummy bit, not byte */
-    dummy_cycles =
-        (FIU_DRD_CFG_DBW(drd_cfg) * 8) >> FIU_DRD_CFG_ACCTYPE(drd_cfg);
-    for (i = 0; i < dummy_cycles; i++) {
+    dummy_bytes = FIU_DRD_CFG_DBW(drd_cfg);
+    for (i = 0; i < dummy_bytes; i++) {
         ssi_transfer(fiu->spi, 0);
     }
 
@@ -305,20 +303,13 @@ static void send_address(SSIBus *spi, unsigned int addsiz, uint32_t addr)
     }
 }
 
-/* Send the number of dummy bits specified in the UMA config register. */
-static void send_dummy_bits(SSIBus *spi, uint32_t uma_cfg, uint32_t uma_cmd)
+/* Send the number of dummy bytes specified in the UMA config register. */
+static void send_dummy_bytes(SSIBus *spi, uint32_t uma_cfg)
 {
-    unsigned int bits_per_clock = 1U << FIU_UMA_CFG_DBPCK(uma_cfg);
     unsigned int i;
 
     for (i = 0; i < FIU_UMA_CFG_DBSIZ(uma_cfg); i++) {
-        /* Use bytes 0 and 1 first, then keep repeating byte 2 */
-        unsigned int field = (i < 2) ? ((i + 1) * 8) : 24;
-        unsigned int j;
-
-        for (j = 0; j < 8; j += bits_per_clock) {
-            ssi_transfer(spi, extract32(uma_cmd, field + j, bits_per_clock));
-        }
+        ssi_transfer(spi, 0);
     }
 }
 
@@ -354,8 +345,8 @@ static void npcm7xx_fiu_uma_transaction(NPCM7xxFIUState *s)
         ssi_transfer(s->spi, extract32(s->regs[reg], field, 8));
     }
 
-    /* Send dummy bits, if present. */
-    send_dummy_bits(s->spi, uma_cfg, s->regs[NPCM7XX_FIU_UMA_CMD]);
+    /* Send dummy bytes, if present. */
+    send_dummy_bytes(s->spi, uma_cfg);
 
     /* Read data, if present. */
     for (i = 0; i < FIU_UMA_CFG_RDATSIZ(uma_cfg); i++) {
-- 
2.34.1



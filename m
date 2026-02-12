Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE3BEE3684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 13:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqWiO-0006sc-O6; Thu, 12 Feb 2026 08:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1vqUE1-0000iV-Am; Thu, 12 Feb 2026 05:47:09 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>)
 id 1vqUDw-0000pX-0j; Thu, 12 Feb 2026 05:47:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aivken2Y9Y5K/cX8CmmlTm99+K1BZCKgAAkelslu041JV3M4qYMGGS1h2w8V0ahb8iN/4lDLQvEcNV3Laj0+TeMCu0AUwM1kNCkEdiBzqZ/l7D/IHd2ZuwEzQCm0UpRoTBfYNEBx98WQUHdzDU1lOIa75rCT2YUj4fnZkRJOrHh4ECJmvJuJ5n7xB1O/hRG/5bWFxof1UBBtguI9OdSkD/6L7pv5wh2xgtKWkjUDV1bTVzDp5B5OSKadptFtcOeJG0I2029nD/MNl57inf22s6Fm1aGojlUM6qaul6FKBSSsn9N7ZaP6j4vkJ3h2dWp/yh7kX0KLAFA2kJeNQ32kGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28qb4oJTlecXhIC2DUF+bvwjDnZCqiF6SjJUV9t8OSg=;
 b=alcW2145QOwEWUe3jFKBaX8aZi5io8xdB3tG4oOqWiiZJ9PtYUpeb8D8iFcDLl4k0vh6O3SvhOsn3/Z9w1jxv1pAnQluA9QZqNGGuaVCmWSYI1EU1sFjTfFzNb/R9NXSwLM8uyFwvMZk3nU2cV/qSwnuXE+2kWGQ4g7ylk2IzgE9aUVyVeBFH0jlw83Va3WBnmLGZ7y8/nmsuxBxInTyO9ZNmK8eKm4ugzrPx6JYI3RJc1jThphw3o/oHStrNxaIw95FgMHMChQ9kEdIK/pShpNOGiKWI/p2SvN/bQK/XHgXMyLFmD6Sn+CAKVd8AhMrg1WPuJGpuSvi5zt8+HFGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28qb4oJTlecXhIC2DUF+bvwjDnZCqiF6SjJUV9t8OSg=;
 b=V02fhAUepe5+CPoxVUzlOPvsdBwxjkCPZR7liowxh6ArrBa2J0pjueTUF6tuU0uvhGiozyEqrYzQJ1csw0HhGeeyCJWKkOCqJ39C4emmp4eC01HE2uSUrFNdfARPawq9aZu1y+tNKvjlYefkcfZbC1vGQ7mnJCVvIImcCBp9X7nwZ2r6aGmSp/Z8AVC3A+U6fGPprs2KiY9L3K1zKEoOkV6pWhwRKf0OFFF2HZldZOtdizR5YEMU+7yut7vtiCbptSZO+pm1ebHo6MkEofXgnIV9qvDnUzgsglVIft9t73D+l/3zN9gdUX3XBN/fgZhaxbc+EqKystm+1RHGZtx2mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by SJ0PR18MB3932.namprd18.prod.outlook.com (2603:10b6:a03:2eb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 10:46:59 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::2bc8:6a5c:b10f:9e21]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::2bc8:6a5c:b10f:9e21%3]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:46:58 +0000
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>, qemu-arm@nongnu.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com
Subject: [PATCH v1] hw/char/cadence_uart: Add BXRS register
Date: Thu, 12 Feb 2026 02:44:32 -0800
Message-Id: <20260212104432.4168886-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::19) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|SJ0PR18MB3932:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb9cdc2-cd9a-486d-25bd-08de6a240c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oDF2VutTcTLTUL0IF1vgaEU/on+E6zh/dp7cRLZ7vAdKTjeQ0k3Rt6me3dBJ?=
 =?us-ascii?Q?qz67ULzwIXDa5TeBMgyMme9Yj/MmfXg+KYQvf/l3OGayCoMWVGy5U70dIbfk?=
 =?us-ascii?Q?2iQrcWuxlkOF+XvsJV9n29IWutXsYRN52nG6myBsQeG80716EF/Y9RoVIc+X?=
 =?us-ascii?Q?C6njaF1mA7merRiTWceB+TsRBc0SQfGr1pyfBdun2vN3DvEGqqz/5Nj89mQh?=
 =?us-ascii?Q?k3f6u2Xh9LKCljiQY790ggRq1K5w8Ks0vlDl6FY++42KyoNudUlThgAjY3x+?=
 =?us-ascii?Q?elDL+yIkxTs41h+8aJTTDldTmXmfjDbo4JN5KFtUa5zvplYMk60YF3xTE8Ue?=
 =?us-ascii?Q?xOeaL6dUeDKLPY7W0+Rh4sV7nk5I4U2WvG0MGHUA4KsZoSJFKRBzL18kmU/N?=
 =?us-ascii?Q?Zjw1FUyG4VRqcv1YpHXsJ0X5DE4dg7AtVv7MdlIcG1s2Y5LyWwpzquQ7P1Bo?=
 =?us-ascii?Q?I+g1pOvS/BYKiBf5wKnan7HH7et0aM4ZJJKNYoQ5GuUyv3UGa8/DAB1c34l1?=
 =?us-ascii?Q?qEQWIlCBHHrIU7aJFVb4XBgUqOhFfFbCrMpOUouMUFwz6utp3sVYQpkds019?=
 =?us-ascii?Q?p3d3pbOkhvgxljkBiZMGt19Wnr7iH3/preOIo7hyfX36IMwDCugP8qCCBijo?=
 =?us-ascii?Q?8CHHlOIHQ+4CnJor68kDdbZkwMWkrRNGKEPjK/vFxQvT2ItNFofFyutCt6+/?=
 =?us-ascii?Q?tuypRAoee6UviGCBFz7327Y3l3PkB0r+EPMNGMPBqOepfRibF4mg8SrutB6B?=
 =?us-ascii?Q?1unRNCiC10NSnc0iZB/+f9Wu/I5GsttZ+jrkX+ToTPTapSE0S25AmaGyyqKq?=
 =?us-ascii?Q?9ysriFL7rDiIRyJt4PcP/LRzl3UqB12hvCkJaQXAFipi7vwEsK0xdRZpSuQp?=
 =?us-ascii?Q?EdKsGOJxueq8Z+BSbdYCGG/NiIw3AyKd04bDFIex71M6nLHK4uWoi6N3iOkG?=
 =?us-ascii?Q?vHdnE46cig6SCNTUbCYlzOYDyox0olVQYbE5W/PNwRl1yXENG8GOJ9q2+PbF?=
 =?us-ascii?Q?MjRW3Hm+29gSarXzG7TI6/65Mhu9v2aXiJJlzz5PxV2xMRMD0hwYtXQrc9WL?=
 =?us-ascii?Q?sjvH2T8HGWafUpN+JGg4Kb93OBh5GKFbGNVwZx+Ht6rt5qq0/7/6Zujb/ZVZ?=
 =?us-ascii?Q?gsiIH/6Y+2LQO02/pex2uHUbpYGj0s8IM6+Iq50qTVFTGE8IY2Z5r/UK+0L8?=
 =?us-ascii?Q?sdcd0takeBQVE7J11DGSrVSb6i4V42TBc3Vm5xX+8gt3YvTYA9Sl5zMm1LVy?=
 =?us-ascii?Q?3s6UR8LHKoFVdLrO0r/tJcHZDDHKRjvdGftwzUKkzO28GCzdX7rtU3d3gffG?=
 =?us-ascii?Q?fgIzoA9ZO3rbQ66BjaS4iWKPJCSh7YDSsP+rpeWF7kf4dGaxr7XJq57nmani?=
 =?us-ascii?Q?g5D5gQIXfBBvar7K5dPPPMnWHcIo1GUkcldoIni4nQrJG0GstP972aQSCyjp?=
 =?us-ascii?Q?+XVsvDlJrk51fAUzI+WNTAgrh2ZGJJaQFl6HMFKmU5/E2BlVcTDQe1th2mt1?=
 =?us-ascii?Q?rBZa/jJtpm1LXnTWGmOdNKqfrh+Xb+STJqh4AJ98TV6KUwHAdRvv59ce+PGv?=
 =?us-ascii?Q?UnESwyVxYkIeZdsFlX33we1/4NKZ/uu58KfdsNxzlAAhFm/s7BBQRz37sF2H?=
 =?us-ascii?Q?rXP43G3vjk592Ae55lCxnZA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TxJxLwqAQbMI/Qfm7kTKZsbXPpAddnfIY/WzaLy4vUR8og2wb27cuHnFNCWW?=
 =?us-ascii?Q?wcHZuVpL1jJesVhxFWb8M1XFt8NpAkoCmJ+oufHFDEbgvHJiJSq+hZjyNSS3?=
 =?us-ascii?Q?br/pxo1106s4H24AEdlQ0Gx3BvYvc2RNDBbu61Vaoo8A8wBusrMqofZ+/Joe?=
 =?us-ascii?Q?FkZWIEY2TQi3Y5hAPnjnQDDp3sG30DrtvBEyEhjT1wiuvu1BvLgU3A7fMcJN?=
 =?us-ascii?Q?5EjY6zmMH5Rkz5Ptt9+wCmeUEqSl0fhJ8ZJLRk1v99X153o2PSuFT3MUEIa7?=
 =?us-ascii?Q?JV21x6FGORzgvVhyuwj1ZnpYTPcig+R+j6gVZvEnOJxxEN3q/osn3/yBTrKY?=
 =?us-ascii?Q?cBUenxkiilscTzfqTHhhVR+2N2RJchK+f8rDcIEdKR/IMKh3Js6rmtVqI5JT?=
 =?us-ascii?Q?6hNkCiYChKR0e+Xnvc2iaGC0ahr9H/uJxW4395W3FSvBDHG6av6eRKksP2+M?=
 =?us-ascii?Q?PByUNOJnBIXVkU5ADmJFFBIKjD/XA8formtRtAAIgiy9H2WB8wH8h4YpQ5Gw?=
 =?us-ascii?Q?JoeCuqzMAUZcxCuKkl5EQgFh29Zwxt3a8EWWCK+G0sLkxEhLiqnwD0W68j1q?=
 =?us-ascii?Q?ktnEqU66N37qHVfLepqQz9pMnzJKwEWX9bMiBW8iIVja6cSOH/ffgoZD+TWZ?=
 =?us-ascii?Q?kIaeTDQmKJ1TaQY+RhHTBzqQAbDq60FxHfeGtr1FdMnMr5+3pYBrnZQ35ov4?=
 =?us-ascii?Q?1k8QOmSy2wyEOZ2sVnH1chSfZ0c8tR7ti/6osNPqe5JkJ1SKDHc9ctS8WAZH?=
 =?us-ascii?Q?6pqI42Tm0INp8FweaMsfz1LL6qlGqRDP7nY6fer+jZvW2kWgcTtXTIoVL8cH?=
 =?us-ascii?Q?cEF8sg9WsAHJU9J5ZBJCZC036ZOnOa2SugvkQrfkY/iy7v9UC99Gk/LH4MMl?=
 =?us-ascii?Q?5q10OW80htv8vvua//XdWK61dbG3Y8YXy1Kygzs90u7emFqExwQRlDh3d7CD?=
 =?us-ascii?Q?53B0mOlWaA1s4zMv2mtXaWl5SfbMkhouS5KP+O8Ay+JYRMa64TF1z6/7nWU9?=
 =?us-ascii?Q?d8xXXHLJL9HGETkBV75c/XLsYh+UH/PhA1/9iqgfoKxiXMgY+MbrNBxkse6a?=
 =?us-ascii?Q?DBciBV9oXOlOgZp+rDXSrY5tw51c/z/AiUttcrJIw7pqMMHkK4Rcp9+FyLk+?=
 =?us-ascii?Q?N0m5rFGeBLqbHYwTEupS8YQmund+3w9gT1qByo3zEcGJm/sUJOPqFoGf3OlD?=
 =?us-ascii?Q?BliNWpKOWhYMDr/M63S/eCK9XU5KuiWOZtC783jxIcbpnTknw4Bx0ZZGkrD6?=
 =?us-ascii?Q?ZVAjTMH7tS2EBFdf5fa3G9Xd6V6y8EPd3TS1olfNLlzsuvn1iJPGvibUdKHB?=
 =?us-ascii?Q?E4+y5O3xhxYMt7kn4/cB3mVWWOYN6+dVikTArkQx6P8JKq3dwtUa6qoC5RYq?=
 =?us-ascii?Q?Me7o0y0SpAmTIkmmoUYF9Ku9jmRIBKVBCCJn+KTE3bnB2abqaTy7dQXuns/N?=
 =?us-ascii?Q?F+uYvJrB6G1pWJpjhZ3ilucBJjSQlr+jhjVUnXqeS+Or3Z2yRGhk+b5gObv5?=
 =?us-ascii?Q?9zy/5JVXRYZ0yzYTl8nNMKk7lTAqblDnz0R4WCEXfMBq5ILM9ortJ3kY8ccH?=
 =?us-ascii?Q?ctz0VkmmxNe2oYRCuA9nTGF/56bg1Yh9w0FKetyi6Mh82y2ONsGz6F9FUxFV?=
 =?us-ascii?Q?GsTqdIOp9n91jElPeclIG9TGAbEur37GvVVGS/1U5G2O7ISLrbqHsrsfUJBJ?=
 =?us-ascii?Q?/cYsLDVOOGktvNjnneg3ZfoAUb0Goj/2q5mqGjCWJs1Lp0bM?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb9cdc2-cd9a-486d-25bd-08de6a240c14
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:46:58.9430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kPqE2Atyz5biFHnF5Ov9MkbIxzJomFih+gGshOGm5/O233kg9UQpDwgMPBvrxj9Z9GtL3VuE+TH5qrpBT9WVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3932
Received-SPF: pass client-ip=2a01:111:f403:c112::5;
 envelope-from=kchiu@axiado.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Feb 2026 08:26:37 -0500
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

The new CADENCE UART driver in upstream kernel access BXRS register
This patch adds BXRS (RX FIFO byte status register) or there would be
kernel panic if user are using the new CADENCE UART driver

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
---
 hw/char/cadence_uart.c         | 2 ++
 include/hw/char/cadence_uart.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index eff6a3c4d1..f57cad57a8 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -120,6 +120,7 @@
 #define R_PMIN     (0x3C/4)
 #define R_PWID     (0x40/4)
 #define R_TTRIG    (0x44/4)
+#define R_RXBS     (0x48/4)
 
 
 static void uart_update_status(CadenceUARTState *s)
@@ -523,6 +524,7 @@ static void cadence_uart_reset_init(Object *obj, ResetType type)
     s->r[R_BRGR] = 0x0000028B;
     s->r[R_BDIV] = 0x0000000F;
     s->r[R_TTRIG] = 0x00000020;
+    s->r[R_RXBS] = 0;
 }
 
 static void cadence_uart_reset_hold(Object *obj, ResetType type)
diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
index 751a751248..0f97e19112 100644
--- a/include/hw/char/cadence_uart.h
+++ b/include/hw/char/cadence_uart.h
@@ -29,7 +29,7 @@
 #define CADENCE_UART_RX_FIFO_SIZE           16
 #define CADENCE_UART_TX_FIFO_SIZE           16
 
-#define CADENCE_UART_R_MAX (0x48/4)
+#define CADENCE_UART_R_MAX (0x4C/4)
 
 #define TYPE_CADENCE_UART "cadence_uart"
 OBJECT_DECLARE_SIMPLE_TYPE(CadenceUARTState, CADENCE_UART)
-- 
2.34.1



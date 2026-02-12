Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6A6EE3683
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 13:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqWiL-0006s9-Fe; Thu, 12 Feb 2026 08:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vqSRo-0007Hr-VA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:53:16 -0500
Received: from mail-eastusazon11021105.outbound.protection.outlook.com
 ([52.101.52.105] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1vqSRn-0001kZ-5x
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 03:53:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLtclmEh8yvduL8PsDLL3sktuC2ArLF1frBqsmW47R6V0dKBXxp9sTQbG6NVXHtSNDztZctWHmTvzIE5Tiql81xOqZdLZx+wTT9/9ShYWlxdLZNnVJ9TZa5TPrV0PG52LNPrMv5uUpTSicX402gdTzdYw5dKGl/YsIBEeWlD8YL3PXyL+QQe7gNOX63B9TLv5auST2CWS3KIapTsEaIB+IxiBtvnDSZYSm8b1G+01+b3glt7y141a2UzRF9/qeQDBE1osmgt8ksy6lK54EriWToqZmIPd3dBB8DLfpHaTmiBYMHksmrMt4DVMaYsIIdlQBpIzY40xfwwREnOeBuhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28qb4oJTlecXhIC2DUF+bvwjDnZCqiF6SjJUV9t8OSg=;
 b=HZD5Pp6ob8SFsA3ft25NgyzVYvtJwsDpQ1fzn7COt8rv6yUG8b0LpQ9gRWHKAz0WKlM5ujHlqLAx0sed45cfObltf6bSgEQ4kFNq97hmhtVL0+/NhqIK+EzEffbZutt5DSPRVo5mQ2zlIC+1ZBDNtnZeyR8RfBMIFj9ry1mFjmLPl183n/14mIRP5hUBEUzX+f3W81jkqL3+3Mt5mGXQOL2eJww3F/SbSjclkl7epI4a5coCL8F43P9NH1vG298rFbsaNV4AHknJ9PeR52UfN3CUWwUL4EPcxU9QPRIcl2Md0qd52Sfj1t1M8JNEJZwtsQ4GscXYyN+g26xwvBzaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28qb4oJTlecXhIC2DUF+bvwjDnZCqiF6SjJUV9t8OSg=;
 b=W/Ox/YQ/8pxd8NZfhJ91Uq0cd3RqYC6LEp+6ckNTku0chwYrfsakrG0yp7ZX9kh0pQY78nOX+Hit13j+/42fOjXH5/RIewzN3IdB8c5ddM3nd5yKsSDWvsjKp7/YkX9Dir0gptQCUKIogkmep1N1XZ4iUcx4OsKTyC7Jk1wkqJh9IwWYurb0Qjg8/k038jgmEaGfTf6BNcbEAaN3mGcd6/RiStXi4uAXS9uzsJR8tC6BXjmO1YLewWFZIeDi8nCpiZHQ1FUHVjzw/F8rUpKV0nVVqxUXl2qIQl2ane7biGf47Re0JSw9SITsAshtcYiHPFGtO9q/nmsjxKoEejUKuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by SJ0PR18MB5040.namprd18.prod.outlook.com (2603:10b6:a03:418::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 12 Feb
 2026 08:48:06 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::2bc8:6a5c:b10f:9e21]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::2bc8:6a5c:b10f:9e21%3]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 08:48:06 +0000
From: Kuan-Jui Chiu <kchiu@axiado.com>
To: qemu-devel@nongnu.org
Cc: Kuan-Jui Chiu <kchiu@axiado.com>
Subject: [PATCH v1] hw/char/cadence_uart: Add BXRS register
Date: Thu, 12 Feb 2026 00:47:46 -0800
Message-Id: <20260212084746.1456927-1-kchiu@axiado.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:510:2da::16) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|SJ0PR18MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b44e3dd-8078-4486-bf88-08de6a1370e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ENSf56nkW/x/nUNJAT4hyX1Ot+Vvrw3h09PKF975DKsdx/uL5Lez4DRzEon8?=
 =?us-ascii?Q?B76Uoo5XXIVGE/RyMfSutotGTe7ovm4IpKKWAllhEQrfgRVNUS53veT0030y?=
 =?us-ascii?Q?IdVYnDB241a3m2/ljwbdofwN2qiI/n6c9xf9QVVnuAPiKOCKAlfVrcy+9t6S?=
 =?us-ascii?Q?QjNF0rMOJaWAO8mEYa24LgVGxkXwk7vtPF32ZxYwItcOaHNkpXquGfViwFAu?=
 =?us-ascii?Q?ZBilsVQsanrYtlY1KTH7s8RWAGLy1iRy7qUX3+RoZ0zkSs6EU1kevwT9Mwu5?=
 =?us-ascii?Q?J7Ms1HLQRQ07isBeUXQiYXpgb3eR00XCX2B5qoIQ2LipVgHDRCmh45YApN4X?=
 =?us-ascii?Q?06uD1F/ZnXruVVxGy6pxHRexapPzDCSQRQpjo3rVMAZCLWmxH9e11W4YCamF?=
 =?us-ascii?Q?ust4ooIreDcaSz+R90iteufU+2W0cQuLfoPuwUxzMRWB7Qec5w9ITG9WXzzJ?=
 =?us-ascii?Q?Q/SyNzGy0RrVK4KbmYbsKgKzusOxADzLSz649L/bt/fSoCVLGUjq0DkUmf0y?=
 =?us-ascii?Q?G/iyZ59xL/jqDhJ28K9tWjP8nlNkfPXAxNkrZbLH37SiO70IjCx4h+SbxaB2?=
 =?us-ascii?Q?j/ZX/2ctGIopxzdKe7d++57hBcP2bCZddqBTUM72DxuFikF5NYEZDAhPKQpR?=
 =?us-ascii?Q?IlekqKmc+VlK7+uO+wipqQFXRd/WMluNl5vbY0VuYZtTI7+Asg/lT52prxxX?=
 =?us-ascii?Q?6Qs6KBPepyr3RjyE1rA0DF0Y6N+TlOwq1dxYU72CBqzIBelaCCFwSI/RwOOA?=
 =?us-ascii?Q?DLNCakOWa0dzGL7Jq690LTKXM9rhS8Xxxvr767cHl64otfPGICqK/j9oBkGz?=
 =?us-ascii?Q?6N7y3+IHuvSyBk5px5KCwwcVhmgTohPDngGeFOfHVB9vdUxGbjg6tmAkY036?=
 =?us-ascii?Q?LlO3BHZJF3+MvEWeGELEkC27hlazFMqsFEzQmrkdXSvpQkhI6hAFaC8cgpmE?=
 =?us-ascii?Q?WE17zgBARvnqkbWTyFTdBsVcDg7e9JbzT/g18E+49tBI/45HahbIiT50U1tO?=
 =?us-ascii?Q?xn4VayyuFnXPaJeGpKI4IViFOSXWOZxrXudNJu1Lh6TQeHRx6wczYkxdPQK5?=
 =?us-ascii?Q?UBozXELedupsewXdhmEhZzUhZPddW/3A6k9o75yHPyv9LX94mZNOBPZQDloz?=
 =?us-ascii?Q?+5J0D7NOS1mdY6gCGOKuKimN4vIEvrYFz6NlgJOSGZbNKduaphj3IxBf72t3?=
 =?us-ascii?Q?nn73nCOUSboLZzkiBknzMfX9v5Pz+Owqd8vDCO1r5IJ0Y0wbDshtd4tV4oc6?=
 =?us-ascii?Q?095w3jg5xd/VesEqjjZ/ZPS05KNH2YCoYq+zH/ahC7+gAeWr5yTCz87MshsJ?=
 =?us-ascii?Q?zBsm9owrDtIYo320Hhfd0xo9jp2I/H9zKWnCi9sblaaSgXRtwfq+JsCN7J7s?=
 =?us-ascii?Q?PQA9iWqGOnYQaKYPSZk4SQS0H1bdbvkqgZjnJksU55ZKuTlBkCUte7/UY552?=
 =?us-ascii?Q?JG2nrX/4GyMCi6cB6DRLKmBKoYkHp0z0rI8sskv8wAPLBWQYywzv0lX96nVg?=
 =?us-ascii?Q?Z2k8nXYatW05dwTbI7fkmDVg+022QWuISCDq3Z/9SSnedw01uv3GVjxa8JHU?=
 =?us-ascii?Q?aQ8lMm2zKeutyd/h0Sn8kI46oCu2Gw6EBht4VZ0bjSKXB0XVdr3aO8VPBLYZ?=
 =?us-ascii?Q?LUtnFZcFOzybo3uzdoeFLTw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mCdhghIIvOD3RowIv2RSSNNy4vvreh+OrNke9azbheE7r4BixHJJtnOpeMcp?=
 =?us-ascii?Q?yc4+tRU2qRRQgJQOSbxqCDrRYvRFIwYmRJlx/DRsntu9rhj7urcsQIjihTtO?=
 =?us-ascii?Q?t2A5uCkfpTNDrjnDYOpervrX/+tc6H9rS7plN/GGIlCMB1SdKEAdr4/4KK/6?=
 =?us-ascii?Q?jcPWKQ79HpxCCJoDaRCIih6mEcmEQjWtFbfyyQ6I5bTfEVZ1C8FcEtUiZ6Sg?=
 =?us-ascii?Q?URJLzCm40BNVKFF+p1Wa6zSErBrmOX88YD+ngjyEGSvc+O5gWq3T8V/LX2Yx?=
 =?us-ascii?Q?GFgEQxAThUif2VOZl5lt7PWSt54v8Uqh5eKXXZ2Ttu6Ieqz5jSqoYh16M16W?=
 =?us-ascii?Q?gv2BErB/zzkojefu2MNeJ2X26larzrd/5lnVmJOXUcmo+AkWGTQIMXqjeOKo?=
 =?us-ascii?Q?bdDwQXiTjJNY54T55XMMWRXb3foKWXhUAcyorfD96fkrWr/cPwYM/v1VKUGQ?=
 =?us-ascii?Q?oaCDXI9RKORczEXL8vKMgPLbk0T1FDExH5EvJM/MKJ34CG36omOqFRDaMdax?=
 =?us-ascii?Q?t03ofMuWmjKnwnO0cX1xDGur1DplACz+4KGKyg+YEulsuDzHwt4k7eHXbcKf?=
 =?us-ascii?Q?xff0phudccFOf54RWYKiF/8eNbtElhvK4qGEDNn9KaWxMBmORgJUroSUm6h/?=
 =?us-ascii?Q?kgcM8M6AlSTM01An7Z38q8gZjSJWh+qFaRGyH81RgJ88speqoPKSh+bF4616?=
 =?us-ascii?Q?Bw4/+5UySt7oiCYnjP7rBhqVwpzvyy5v1xxUv4v2veOLBDlW2cy/sMmYWg8x?=
 =?us-ascii?Q?xAtR56upLfeV38U2p1RJONQJ6z+CPdLG12ISEi/4MvRTJiBhxnrdI7oxMtiL?=
 =?us-ascii?Q?8Y0v1BdJRaTliVDrttO+JFDkvtH3KdyJetl3C/WZGktiLmoSH4kcH+xTHM5r?=
 =?us-ascii?Q?FdyUxJdKHKdYTG8ozznJc9BTItqRk/rABIUuTnCLsjLfi+dhJkyrsa0b3yZE?=
 =?us-ascii?Q?uxG5YDk2lfTKPIW6ucvzo5fsvneW7nnNJttAflGYrx0blR2ukAFcpUY3Lo8/?=
 =?us-ascii?Q?oTKhjZLH02TkQVc0tDZJ+MJ35nOYtKhnFnbC/NghkmUIFnNoVzz+dCR216W+?=
 =?us-ascii?Q?osxaRsuJ1nI7PlaAaHs5EE8VqbhAtrHsj6CnNPygFXb5nAak9uFNV1Ed8xVg?=
 =?us-ascii?Q?69J54qiTEQMB3/vueUUQYFXYr5qaHuvvtNmZ77XPLhrNzBLe8qRNgo3U54Tk?=
 =?us-ascii?Q?cXXdJ4HQ7DGi0zFkOCzAUMCcBV29UtEo91SKhyWz4oRu5p/KW8xHiKgiYBl0?=
 =?us-ascii?Q?fGCL/vN3H/0sEnOQ3L3A5SkymqwbjYaHzZCnHAceciXJ6MLGbqdMDlCn7iwA?=
 =?us-ascii?Q?thy+tdXiBgkZcsBWUFnQbBdZa+ODsyUFlaOxeY1LlsGE2Gk4JpLdm+KwEWRu?=
 =?us-ascii?Q?33w9TEqwuhn6uI86CdMT9OghIv1i0x34SCBLW8ioCEecrXmZeESS1t/XBpVW?=
 =?us-ascii?Q?BgyjgdkDrQcIXGONWegKmoJRagzXyqVyI8WpvrfYJ5mPMnKRlTavP4ZAcF0e?=
 =?us-ascii?Q?YxPxMTI0tInmYrexv5BNEuznSUl/yZpRsjto+VwPEsktnWKEDNVt8Sfgsllg?=
 =?us-ascii?Q?UcTfodylBjv++MhCbwYSH6na6BII1ITEMh/80OdUD47TnahP4ZJjA5wEwTcj?=
 =?us-ascii?Q?z3W6m9laK3/vEh7fmnMGKn4Wd4Uz8+Q3gThfcPeBRuK//YJSUiTQmSFufpTC?=
 =?us-ascii?Q?un3O1ULkJ02gpt66cZTq2Kboe5co4C7rrHwYwXaLa1jnGmYg?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b44e3dd-8078-4486-bf88-08de6a1370e1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 08:48:06.5026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsLDJmnGPOmxL98gA0s8P4Ly8wqkNhRlRYCEO2vfhWStD4PsuyfaAfIRYJrGtEHmUIrGUmzfLM1IKOrl82Jc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB5040
Received-SPF: pass client-ip=52.101.52.105; envelope-from=kchiu@axiado.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Feb 2026 08:26:33 -0500
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



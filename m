Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B77C531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvD3-00049u-U4; Thu, 23 Jul 2026 11:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvD1-00048h-BS; Thu, 23 Jul 2026 11:19:39 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCy-0007zZ-8A; Thu, 23 Jul 2026 11:19:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUxSc4noxhUf+XqvpyY6shmyPGHszbcVbbUgOZYxHIlGTp3JkKl4EA1HqckcztgVGxGkDMAYQJAn1kleeBpO5aBz6O0Nqf27+jrELU9JdwIuDFlmnvbMF91fZJZSq4pBRGfRhvY/xPWVomUY3zG5/FY0czdD7xkM7slK0YB9wfZORK0eR2I+jfIE4KUZpwKDmU7vl07r95DN0+/8S6OVvP0ivStk7r+C6rxcvYQU5C+5gy0bT0LaNcPbtKzRGPXHtx29RyOMVB4Q+I3NKOUsr1CL5/zQj+eXbJWTF6OZEfniIwReDI05aWlaIiEaQzgRITbta57f8HWO/uj8XlW2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHbDntHfemAOFyQzoNIxAdxMhYSCjBbI8BHCzPaQ1sc=;
 b=WABb5x17nt8tmGkmioNZuN8tNXxXJwYH3p/2TF5QTJh7Rrq3V85CAt8HgBPjmcw8vwQ4MGeaAYsJGcJlganY84WVT8NKozAZAqM3iKeMQqPc1zx6HP7G4hhK4H6NJLsfhkmZe1wLvecz6ZWvEOLE5mTj86ekoJP3DIoSEze4DrW0DIE3kmFOT/zsq/fqUS8pXhex7kXXlseuO3FF07AZB0kShAtlE7bpNEMQQuMXp/JcHXg0yptDblwLmaVJQ2FhQpqVHE1pG2Hdvo+Fnf+44F5uTOfyamzbTv9BJzpfVbdIcS1rOVSoSGiIfSgUHvb/YYVcmLBId2nx3Gvre068Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHbDntHfemAOFyQzoNIxAdxMhYSCjBbI8BHCzPaQ1sc=;
 b=IbzN6YV+2lT+nMzeGqxEz85BmAC7ci+d3SYdsfWqetzPiCRezA7xxR5WVsH9uNxte1kJ/No2QIG/oRO6RbRkJZa3mRRrI7CAaa//xlw36Z2QmjITHRZzmcAr18M/FkflSM3EYlm7ga/EP9cnkKB4VRgZjX5McJJIRnSnev/jvQ03GQlCu2ygN4fd3EirAD3LijEHpaRKZhzzOvrIc8xYClHREJWLSOQsFB9Iw65Uyd9EM+JAjFIm4HumzMXMiuDe7M8jfedPoig5jjrnGIf21JbjkDKmDeCxTUsWsagRin1kPvjZ1YyP/i6NgeMZ/Ke7u0v+3jNODGIpfEObvAJFZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:24 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:24 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-stable@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 08/26] hw/sd: sdhci: Accept version 4 enable without UHS-I
Date: Thu, 23 Jul 2026 23:18:35 +0800
Message-Id: <20260723151853.2143177-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KL1PR02MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c34b13-31ac-4f2e-f507-08dee8cdc75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /tgzK+ngpHiSQFbi5IWNqaCpAUgkJj8Irkj2oHcBOQnDiix13UnBG2m1OM+Fn6GjU0c7iXO8DPWiuERSS5pEo4pGbMfmt4/NEmiGZ8DcRuwdIuAwAgjOyOql998qS7nim1yI6oaVflv4G/EqhU3wsiLlXrGdlYTMeFyiwEvSOF6al/gGs9IhFa6jk4jqhBJ1lSmZfJqiVdh0F4hVjYys4NkcCsV7fDh2N263ilgWY+q5GrhfGhGKKZHiaxwKx+cfdxKLu24MN3yfMsD3ynKLtBtGlFquAxtlP3qAQQT2W9lS21jNcUuVI2BH8LQ14bF2l7ARiabfhSj2p7128qsrj/l9aURHW2RHLQy8TjeYCE/2Qx+ftROItn90Cc5bAnF7Fx87y+ZVid9swPgfCALy0jRLCmB+nMSsljIMaVN7Q7L5QyLV96NUh5zufZSbUxKgxKh71sZu5C3Irv9NH8r4dPzL+9wUUcmKYg2HGBG3/njALswLbCzFR4tEVFuLB4Y0cfm6zT9HF4UBqygoH2mlHDxXOZV7/dHQeWOcv7SJ9YUu9Hvomy7p5tLVBfZKD2LsYCghMpmE0s8Vo6i9MvIf6uFnsWNNu5O0gC+1qB6nrANWyis29PK5d+URkZNCiVTOIqZ1olkCuYKVvTbTVCGmPF5JRB+zr4crJ57tGeljTTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LWvm8lGnP4xiVLmSmBsMEap8hKNG0w+1zHmAtnbPB8Tuln3ntEheC/8/uG7D?=
 =?us-ascii?Q?7N9WvdUFyEPsaEfvcwx1ntynmAEDeQ4H+Dfipe+xMYSpKC+Enmn8wQQV1OhX?=
 =?us-ascii?Q?ELRQ6kxG+xxf9qaLEXZkNdY5RV5Fql5ellbPkvtx44uVvCpHBROL01XN2Gem?=
 =?us-ascii?Q?uttteHBo469ZTE15KIH56QR++/kqmH+svSwVtNSNM8EIrzBMzNYEIUGG8PCK?=
 =?us-ascii?Q?XmDLZXUH8pG9wwEnj6UxVSfc6am6AyK6FE7xKEq8bE6jbTyhqSMhC1O7T1Ga?=
 =?us-ascii?Q?lVU0ZM3MQEc0KZX2tHxHh+gQizxo2YHKT/5DlydVirOVUbMc0OLfJbZz22H4?=
 =?us-ascii?Q?rvOr6FknxPBo1SHnPVO+vB9yyoMk6VsMvnMgu+LQ6ZURZsXh87jT2yGuk2gG?=
 =?us-ascii?Q?DO4y9iu20/UvLiNZIVxTU8oB5BEbNAfGi5/P8ZeM027EH9jI3Ldo/iBy98du?=
 =?us-ascii?Q?ISoHH/To3TVV59kyWA1CsztZi5s/rA1B8Rsl+PmPvWS29f4n4XUtu5xAj9vX?=
 =?us-ascii?Q?4rx9CMMmaYjH2l0JawZNHYy3zDJXbwu/Fjr6Xjeg/bRa6dSB3wlsBov3RW34?=
 =?us-ascii?Q?Ky4jV94yFUv+ozepkGE7AaY53jCqjcn/29Fw0TJ7B7l6bABjp3RwNLUF6C5o?=
 =?us-ascii?Q?RR2dsc5VgGtc3y16Ec1ZALpz3X3E5mVWx4WbisdmmGZdJHR6k89XVbFDbqFG?=
 =?us-ascii?Q?7Dz/CAXLQCz49/AD2Akl5VnO6i04zG7mYATWAYfu58tK2O9LXbnKmTLbZU5M?=
 =?us-ascii?Q?aYvSOfEwtBU7MnOzTEUSminwEd7BouCPmPSY3aD34f/n5CWA1vl12cE6dEM0?=
 =?us-ascii?Q?sYHUd8DcFKNrFgLYDkQ2Pxz+JvCxQHfXGZa394Re3zLyvC0psZmnrC3DZwbw?=
 =?us-ascii?Q?uZPViJ3sd3TOuB/KZPKLY58TMIe81Kt6x+g0T1DdSDoxaaeKc2+y8nOKMFmn?=
 =?us-ascii?Q?RpvakWSIkyLR4CzEcvb7vDzVdCmMYG4VjmNW32DqKuewxxQ8OMZ1uX+J3zOm?=
 =?us-ascii?Q?tqG7ZLrBJiDG3MBuYxDSvUWz2q5zMVA2IXfRPNjCCR+dOCs+e33GyCrxkpE6?=
 =?us-ascii?Q?g9nGuVzj4pA67GgQJ6bP7NYPIz9O2KzP7SKjNELP/NqGoZgelgf4KRXgYNsI?=
 =?us-ascii?Q?yskNzb5arzBPdUFhSUPoXYW+lOsmzhqhNb67gaTxVn50MXlvmW0so62dLBKu?=
 =?us-ascii?Q?ElwutHqvoDw1NDlgEbmY8k3WOvB7AEVIwG0UyvN/5DGyMY+b1o3QdC2g6FQ0?=
 =?us-ascii?Q?SBJKtsvehsL4CT5uZo4tWeaFbwd/UwbVo9WV0qr3e5Ou5hene83yuseuve1x?=
 =?us-ascii?Q?S4tP5XSy3LuNQf/YMDgfZqeTpi4m4GI+Lj0K3Sz1lsu0+VV/dvlh2JHbYxWm?=
 =?us-ascii?Q?ONokxK1xnkl/+ohbkA+WDBIDqSamimjhXxkeeqFPxWuPH0PTYFIMiZ00ZdYI?=
 =?us-ascii?Q?BPuqDtcQmMqAzYfkvF4LDlSngMPC6nKdxWwsNOKBnaYuWGbPvdERgxGO70Ii?=
 =?us-ascii?Q?1VvT9zYxpDy5YKM8dSokqGmnvXk0AaMHit72DuQsEHZQB1Vp8NTPBlh/gTiz?=
 =?us-ascii?Q?KxXF08xoQkI+uh+t7zgfAquICl7w4MYJn8Oxx9cQpBCGiaIESgoHMTkoNnEJ?=
 =?us-ascii?Q?S/YtEpjyKes0sSg7L/i3TMTaeB+/HyFY9pvzOuhhtYK/YATBLuu73CEBRQDj?=
 =?us-ascii?Q?xJOOe0cHOu+XoBQH3hQaZdElgOdaUbCtMdceJcTi19bW847GGVkRgy2qR/AJ?=
 =?us-ascii?Q?5fDR2yps7Rb2lIF+akvFgoO6Dru+SIg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c34b13-31ac-4f2e-f507-08dee8cdc75b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:24.6003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oVlmwMLU5QMrcY6jwWZpHKdYfOBVvthhdCxFv4H6hGpF1WKefCskAnM1fbpDP0F+8fnCWjdI3m4iYnbszmZdwySE8xdcGqeI7WZdKXW65A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6215
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Host Control 2 writes have been conditional on modeled UHS-I support
since commit 0034ebe6ee31. Host Version 4 Enable does not control UHS
signaling, so controllers without modeled UHS-I cannot enter version
4 mode.

Retain Host Version 4 Enable independently of UHS-I while continuing
to reject UHS-specific fields and keeping voltage changes UHS-gated.

Fixes: 0034ebe6ee31 ("sdhci: implement UHS-I voltage switch")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/sdhci.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 749de85476..71af1f8c57 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1358,11 +1358,24 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         }
         sdhci_update_irq(s);
         break;
-    case SDHC_ACMD12ERRSTS:
+    case SDHC_ACMD12ERRSTS: {
+        uint16_t hostctl2_mask = mask >> 16;
+        uint16_t hostctl2_value = value >> 16;
+
         MASKED_WRITE(s->acmd12errsts, mask, value & UINT16_MAX);
-        if (s->uhs_mode >= UHS_I) {
-            MASKED_WRITE(s->hostctl2, mask >> 16, value >> 16);
+        if (s->uhs_mode < UHS_I) {
+            /*
+             * VERSION4 is writable even without UHS-I. Preserve all other
+             * Host Control 2 bits when UHS-I is not supported.
+             */
+            uint16_t independent = R_SDHC_HOSTCTL2_VERSION4_MASK;
 
+            hostctl2_mask |= ~independent;
+            hostctl2_value &= independent;
+        }
+        MASKED_WRITE(s->hostctl2, hostctl2_mask, hostctl2_value);
+
+        if (s->uhs_mode >= UHS_I) {
             if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, V18_ENA)) {
                 sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_1_8V);
             } else {
@@ -1370,6 +1383,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
             }
         }
         break;
+    }
 
     case SDHC_CAPAB:
     case SDHC_CAPAB + 4:
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CA6CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDIA4-0005tR-Fi; Sun, 04 Oct 2026 05:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA2-0005sm-UM; Sun, 04 Oct 2026 05:05:34 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xDIA1-0005jQ-5b; Sun, 04 Oct 2026 05:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ne5Fb0bF9oQ8Q37TAdUALEfUH5Eypx4SN6J8Aiv5D0KDJdTV/aVxjxXO/Nr4Z1NS6xYe8CtvVy3xJhOiY4p0NmdUY4lkiUeQDmK3wpuwNtPQ1T5soiDFtJ+P9mV5GOyhZaQbePaiPsGORlVFWa6nl1EoRIaASannSayNgGMgp6mKIvoNzOcRxft0/a/4St4iLp8TqxAR7VrpeQuGTFyBVr0PO0OVyJR0bAjwMi3bX3wZFkw2Eh5huLW/iSab/Gy/RRGeImQ3rqX/qMMIJpqOuTLm86R6SOh6cr+ivOmCGwioyi/jGkPYE6TQTqC80YvNAYx8PrkXIOn1GKd3+6BOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcT2OKzwtOZDlBK4wqXH7URnD869CTKb9O68kQbwqzE=;
 b=fxsxeCZYxO94ty3PASNIz1DBtHmrQcj86vagbmfEB5YGlLV95lTclbhAUp2rdYETZwYvp6QOsjGKgaU8c8Xsz5V9kxlm4+pfxTgupepEZabFJLKWpjpIjX6nXsEPWF31SGB1KcMFuXmejbb0sUDDFrVBKoQxa5X8NxJ/IefcHlV3sX82g3G25Z/CN5nveTWZ4BHMlW3AY4mpwnE8QB76T843cYGdAnI+0uRzuUOTiy6nvaSf2heeArcv3DBX2883TyMiRwlVi4thQ0Cazph7w51tK/PAI/4wZ7buc9+BYrcDTEPH4sDg37pHj1uwA3EDblIvv3PSZfLOWRoAPpbFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcT2OKzwtOZDlBK4wqXH7URnD869CTKb9O68kQbwqzE=;
 b=dcTphlLcdgVA2dp5JOtc90Hhsi1BC14V7GTiLrTTPbVa6RSO/IjiTcY0f4yquwQVKBtSRYPv0slYl62F86oTFgvlejMWLce3Cy/2jkqdacKKOFkbFJcEE/w/NctCtdaoWiZ3JgsXvgLaMAMN9ByhE8yTpPIpUSDAIer1uWtBOrER2BEEVsM9ey2RQMsDwsm7vBvMlQx6NRvuLAUOD+w8zEO833vIV0R0iGa0mRTHKrq1ENZK6eKF+Y9QA7PRZYIYAxZ+HEuZrTs5/xcbE5c/fY33pzufsIvmNO99cQuVA4gQH5YkXRaSMJwHL2OFaDgZXZK7DXmPFdwc8W0GLM1g8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYPPR02MB8958.apcprd02.prod.outlook.com (2603:1096:405:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 09:05:23 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:05:23 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v3 03/10] hw/arm: fsl-imx6ul: Map early firmware register
 placeholders
Date: Sun,  4 Oct 2026 17:04:48 +0800
Message-ID: <20261004090500.3082641-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004090500.3082641-1-bin.meng@processmission.com>
References: <20261004090500.3082641-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYPPR02MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 2106c04a-e6da-4114-d097-08df21f69f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: kfvqVnHwaEk4CE7o7wFp11I6oAGwvYJMP88zBZxM4E0Nk67rQr2DOwy0NYezjSNDI3Z+g8kfC0Vk/wb4Kkg1LE0NJsRT/YXXnfNwiVy5Nt40UTk1gbw1ao+ODauTBN+38eY+cbSQvRXkI/PyEo6u6xb3PPF8FD6DnZ7u9ZXjbkEVhZ8RpygVdRnpzCEnRmZ8+MiOgYvpT09p9Q4wyFloR9XwT9sJ1VSCEomzMns/vAUfvIL6b7WU6MADwbhIjPVSO3y0pM+XnB6bqipmNRdTvYGkvDbQLc6c33O8rlUGPOSzEDBU3Hq+r8hiTy6w2g9LFHpWGyqba4uLzMeE3PGDbFdbiR+t9qQBSpVwPxdNRNTVD+kJZ29jTpPXIc8blEJ40Sin3RxLpAQ8yLs+9ZGyNcNDfyiCZfJhsW3FabNZhRm2Jhb25t0FmN9N/IzIAD+5nN2AkSN0+C510/a6giunff+f/LtdkM0VVnT4lIZUQpHCaVvlMPSCY177M0T4F67bsDjp3MtKJlk46PakpkmD/I+GBC4aw45pXsB99TNqexdHFq9/nv3RdD/R+eC0RIGRP9r8zLj7R5gBhx5abC3W4pggawhxbw4bnIPMfz17mQ7PryIcrU+cpqoyf2X3TmqKelKHeLz4w6AS+cYCz0WnXdcPeQbGnRwYfFK8UM5PT6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3zK4T10Rdcmr7ozvwZThujIQCqcAO4/gMkmBYavzXX6qZoXhme+uS8gOEs+A?=
 =?us-ascii?Q?Md98o++r0BqkUvhh2REN75+jBdikGUdJrzuZW5EZCEbUHs8GCQxJDIHgG26v?=
 =?us-ascii?Q?9YZ8X96DYJNikxBCuqoWSgR8NWOmvE9jDR8dDF1/bfJ1yoi07/qA8PdBOB21?=
 =?us-ascii?Q?2n8iQGKXWLdLVic8yjK7JcvpR8h8paepgpWPU5RwYdl/YpYM7sXoUw7Nwjy1?=
 =?us-ascii?Q?1shNvMYQA5bxqCT7ZO7ugXXWisQ7OXDV3tM5aHLxl0a7NX/kYBz1a7Ue/sFu?=
 =?us-ascii?Q?bXSR2RhpzThb9AtUN7dxIMQuG2LeFMmRa1V+9AlU0OMCNuvRBdTr1WJTWH0l?=
 =?us-ascii?Q?CKbsR9YWgdmVDheCBaliFfd3hc31WSDRRXk7l/9pfZR1urLU8H8KOfgusClQ?=
 =?us-ascii?Q?6lNZf8fRvUg4a+P+GZ8EXIXYSgN0Ltz3nVbFKo/LMW6kVZ0YndU17Qqkm7v2?=
 =?us-ascii?Q?UT3vYsD1GvK5sUTi1myxlzQhf0BUzhhXZ+IAz+VSBvZYAWxQB0NQCoBnBard?=
 =?us-ascii?Q?xu7KOTVQOJ8glWD+m74samaktz0AEi836bxHekFmnGTbAceFa0R/nNEc/duv?=
 =?us-ascii?Q?LuW7o7TRK5XK7SDrfPd7ViqhJkX8G35B+v3xtCNL1ETmxTuFS7hPBbSyX/t0?=
 =?us-ascii?Q?SXJiioDA9uG+FKXDuplvI5NZU+5vxzlGDhOFHZTr7LQXbctZJ1qhOuDBpF7M?=
 =?us-ascii?Q?A+mNNWrgIndMMMs/uErUgQYdIpcPkFYv50Ldf4ZTgtnowpVhaw2z3gu6DVs5?=
 =?us-ascii?Q?BP8EhiiZ5Y6WUMBGISf2FTYhDnsYRg3MHFlg326AxMIjUKUURM9BPwsx3ln0?=
 =?us-ascii?Q?6VPlofeyHez4+HSWpfCBnMggsh1IMD/hl3ztPBJidVo2wEwFh1s5lrGGCHaA?=
 =?us-ascii?Q?HSTx/DEn9EvL3RMQBusD3IDHfX2emPB4vXslN1z3FoP8fs1wJHUZvS9kyHdY?=
 =?us-ascii?Q?vcFDR4vjPiaFNXIyWoh7niMTZ36xbpxQkQJw8etFnVLNs5WktA6vm9mMk50i?=
 =?us-ascii?Q?9lWeSvGscNcjg2K5oOG1B6kORXiyZpRLbwX6KupUBRk3ZEDfNjCnevu4QIjM?=
 =?us-ascii?Q?/ShwKkR9B6jLC8stNPhmWSOoTvi8gyMTZ5Ywgt0HZwP7p+lAV34FGC7pQ2Dy?=
 =?us-ascii?Q?loRmgr0/AEgfUog8JxJffc9NAOGjhLwcEBxqTWBxDgkNwCR7iVXSmaOr5aVo?=
 =?us-ascii?Q?MQqdXLbx/yRyORkGOt0t5xxLKgqv0vyYbSesNim3oN7lWXOuqw8xnavCfBr3?=
 =?us-ascii?Q?4uEfbid+r6O3B0mOXenEv0Hu3b64ai/30Xm+RVsv3K05FZi8KMyzmmd9PXff?=
 =?us-ascii?Q?j5jxseyUkIwyJzcTnoKE9kdkCuVFdZeP7DBj10DNP4uAoaC+WzJ7qbFCSYth?=
 =?us-ascii?Q?vohj/IIY9c5g0gNVRzSgHzPfnReNrExytYVuJF75E2IhnayloAYi3qpPAdFI?=
 =?us-ascii?Q?6XeC3FHlRp3cGBpVEqTwkGxy7+QvZ8R3eWGoZ4MvDy+h74LY25f6duhlqjjV?=
 =?us-ascii?Q?eCQmVTL2TYPlKEeY5INg7onZb/yHmAWGjsC+sVEfoZkrTIsj6DCH0KY2q5pE?=
 =?us-ascii?Q?P1a8nFUcjFsjLGgOFhlH0VaF7HTlWDWSseRgyMPDYUjCMV0q4i3TO+J/yK14?=
 =?us-ascii?Q?TVwLSbLhZ+XUxPtWQOKDtXgTPU2oTYVfl3ptHgTyRf8DJ3wbaV0U12hVAJPh?=
 =?us-ascii?Q?sNfY5ofEf49x/455BSt1KIth9o58lXVs620S6MfCg0AyVt84/0hMQ6b1vQ+0?=
 =?us-ascii?Q?mlpdHYtcPKbIrCMzOIzIrGk+tX3iHTE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2106c04a-e6da-4114-d097-08df21f69f97
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 09:05:23.3617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGSq0I0bh5j7o99omCB7U3SyYaREKefwINxfrJrO55Em4rMOsdfrik5ft3AAJrrmAS2uC+/skAwyNGXfEh2YaLqdNaUgmMbR/mlGKvlOOps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR02MB8958
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

U-Boot configures the AIPS bus access controls and the i.MX6UL SNVS
low-power registers before its console is available. Its timer setup
also enables the system counter through the control window on AIPS2.

These blocks are not modeled yet. Map unimplemented regions at their
documented addresses so early firmware accesses complete without
falling through to unmapped memory.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 hw/arm/fsl-imx6ul.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 1863558a0d..92f8e4b4b2 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -201,6 +201,21 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("a7mpcore-dap", FSL_IMX6UL_A7MPCORE_DAP_ADDR,
                                 FSL_IMX6UL_A7MPCORE_DAP_SIZE);
 
+    /* AIPS bus configuration */
+    create_unimplemented_device("aips1-config", FSL_IMX6UL_AIPS1_CFG_ADDR,
+                                FSL_IMX6UL_AIPS1_CFG_SIZE);
+    create_unimplemented_device("aips2-config", FSL_IMX6UL_AIPS2_CFG_ADDR,
+                                FSL_IMX6UL_AIPS2_CFG_SIZE);
+
+    /* SNVS low-power general-purpose registers */
+    create_unimplemented_device("snvs-lp", FSL_IMX6UL_SNVS_LP_ADDR,
+                                FSL_IMX6UL_SNVS_LP_SIZE);
+
+    /* System counter control */
+    create_unimplemented_device("sys-counter-control",
+                                FSL_IMX6UL_SYS_CNT_CTRL_ADDR,
+                                FSL_IMX6UL_SYS_CNT_CTRL_SIZE);
+
     /*
      * MMDC
      */
-- 
2.53.0



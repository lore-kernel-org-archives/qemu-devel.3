Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C986606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=UKPYqaSn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1bt-0007fn-W8; Sun, 08 Nov 2026 07:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1ac-0006mV-HA; Sun, 08 Nov 2026 07:01:41 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aZ-0000Wc-Iz; Sun, 08 Nov 2026 07:01:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4CYuvdDkx/ml+GQeHAj0jxbnmE+SVWRlLTRqZm5cgYiEC39bmHwPalUUvAObzr49m8kaCMYIr5OG+lXB5nBuCROLifvgUrjaivMqYVJPclPuUyaRo5R0F+/f932nw5LfKPClvrLZCQ/iylvPP9eUAAXzIIeaozSCiFHcfdTjud4aroT4zhjiLtQ5cx3wn09NELFgnP3796U3yvthDvKmpC8qmZ3U8GROBU2cMQ+dlZG4AmdNvHmNtmRwhFmRyz9kagdzniPhinNo6dKKrSE/L8q0xWCI3MN+ygArTmlvWSB9rHOCjaHbopovajn7Jw/6RcHCMCiad3zrhny9ZGwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDvD2fjDlTs5oA/RffG3uXDQjKQRx9runCn5KdBMFDg=;
 b=LzWaYc9LRE5WTix9qwJbXuUMhaARFUUh9jSHnT5trmxknL6qU/mLYmsST0fKN9AaZAyzKik6GxwETolxii6nF97/34pbipCQRRS5+QqXaoY4Vew1cAqwBMdYFRymwtpxAEAEftLUqYWpSWPvlnm9ftWnCMedf4J/VOBtVuu4obPN0IOik/MFRxRu/ynTJFOI7uVPM4jqH5tvD4FilphiDbOsQuVIt70MuWIY4SonhE5j46jsplwngA8XR4O9yJTT7AIPbY384sf/LoH+1srsXXEX4584dpaBUYfaqHA6aH06KpoDuh9DS7UAnCXazmIye29QbgLXbWjdfadRoqtBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDvD2fjDlTs5oA/RffG3uXDQjKQRx9runCn5KdBMFDg=;
 b=UKPYqaSn3Wy/w2m7GfB8j2osex9bghO0QKo2dgdJqmOG5BEsRaLm1Le6TS1yJD3dmj0LBTqJ4sJTZIgdsqNOrU/icwMX59lZ9R6hJsyDKsOFEtCej+Yf0BzvCUKadol+ZbAAOYb/5rAsgr+Js7yQzI8TxeMHGm8p1swVPTsw8Md2ck9AA3EjDrCi3kPYZMEYZsdY9HxuawNdvaRsfxTCdwWj3Va1qWEYnNWbuuPLF24ZMmYS1514N8TB+HGcRfE3L31conpcHCbxPoQIlMdKYc1qjaIZXIU4YNxTId3uBJOmFkh9yCh6JOZOlXsYpadfkQbaK8qVNH2S0gXUf4xqCQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:25 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:25 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 12/23] target/ppc: Split the ISA 2.05 instruction feature
 group
Date: Sun,  8 Nov 2026 20:00:11 +0800
Message-ID: <20261108120034.1755008-13-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108120034.1755008-1-bin.meng@processmission.com>
References: <20261108120034.1755008-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To KL1PR02MB7144.apcprd02.prod.outlook.com
 (2603:1096:820:116::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|KUZPR02MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcb1eb1-ac3a-42db-c80c-08df3d90039e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|10067099003|3023799007|261102123227099003|261022075727099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: PWzTzQW1H48+5Hhm+vOmHGIjYr72l3s45h563YCQJ6chflut676UAncCxtwgDm5uJef2gHUvjff5xf7Ou0Ys6l6xEXe4OVfQEkl+ApbttA0FvUtgIH4AyCbhCsk/Q8DYdSAJSBp0g3IAer+qDLe0KDe4Ga/WxfGAGCBAphko3xH1OtuCCgfemzpgCtKZgCbaCnWqgSb9v0ivkY8vmUv9/8PJVKwcEH5meZKBvDXnco1hD0xMzMvuxiW1jZaRCsX1C/t4vj5hZOnY0+1Y5oBGssquE846gVtKtlMTJjt0NdrU6CH7+C2FFA25NfIHg1sjq7kR1U64Jmjc1OUVwYMjuwIaFFRVz+en0/HvrPkOY7HIyALFJo9JUzIQMY/4sVqTxGcbXrQQIqFMCKa5Q+rh0BExRPqdPiFBpttXkeVnXrSGs12XEihhHNqZmXvZcmFi36kmUIyKK+Bmovx8qZk1LF+meVqb8jxZTIoCoop0s21WqnINdc1oqUBY5rONpIxOy3pDE2afDayiiTQxmajnp/9iS03oBWbcOkUy8Xs4dnlpMqnUpSzK6t/AQK9ashtdeIH/QWaQz1UicFWF8diIXHXGw1k9uNlCkN4gQ7KpD4fHuvk46Jr/68MD2ZPtfeUfvxUumr8hERdrTyV2wHOMA/dOlcSkQ3//eWNDXQglHDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(261102123227099003)(261022075727099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RcbJxuEJSB+YPdsLMhnN2/tK+QrgugC1aIPM9LBa4QTFpIa8rMdgtlBmI0o3?=
 =?us-ascii?Q?SQFQxZIPY+XhgbkC5tb5y6K42AY6W3bzuRAJoBOIiF1fh8sED3cLbrAVC0Jh?=
 =?us-ascii?Q?r0q/xwvP8BKXHM64oBznV36hVjpX3DClTi4Zq+Q1H+Z0o9ZItIsLUKhcdZ5F?=
 =?us-ascii?Q?pxnCgXJWCeQLtWTfH5oy9yvuMjR4+nxk31kLuRxvXPK/x8rqWHrUBVIo06yV?=
 =?us-ascii?Q?Qz5r0Oti7gK+lUYv4HzEYPwxbFKU8wSTxdLnhhZCM2wGiPOtlxIAP+iqbTTA?=
 =?us-ascii?Q?8phFecw6B8oQL6EjeD2BueMTimON6bwjmLbebesiLUXrxnFBo9wxIiNAhM8C?=
 =?us-ascii?Q?S8Usq83lWGlc8p4UDoRqoCrH1FJFsSgRtRaaO8MCKq3SmssxdqTFECVtnIXA?=
 =?us-ascii?Q?BhTe9R6qI98kIhgrzTicwq0ux/f6b+wUTm3Y03tRIwzxYeTsG3eljRqDV30a?=
 =?us-ascii?Q?ByPaS0dHGjSfZImvt72SE6yA/WJCK0ACQSF2QjvcLgVxxlrlm6SxGqLjMqti?=
 =?us-ascii?Q?+OfroXoPliNkZXvl/mXZsgTBoqqMFAzEIQG8dLgjfsYmV4k/NuQ/KnlVLV9O?=
 =?us-ascii?Q?5n6COFiAoM2/0hCEi5w90p3QOIIMTM0ti4PDn/PaQ9vA77KocfxaXZbW7EJs?=
 =?us-ascii?Q?CivZYgCxcibxfazsfACkrb2mCpzeWyv4a9Eye7TIUCmKifH1XB4Q9N4Z/6mo?=
 =?us-ascii?Q?MzJn+jBYIEcersnDet1pB2mY4otPtqdTgaIUuIxxHIBUZBVqRsV3gla+9nYj?=
 =?us-ascii?Q?22L+8TiFrGY5fvHgVr1GOaHIgVmqjPonk+FPdxXib2CcWOMJYZeFWrctRMUp?=
 =?us-ascii?Q?By6KUcojlxpfT+oVK9HbycB9xiffdLzetOoGNgAg0uNnwMcHR8jNczlCJvJO?=
 =?us-ascii?Q?VfTzuLfrvF2yptvoATnrmepX1w6rCygrC8kY2D6aAIMRJbQU2lX88Iw8lPkp?=
 =?us-ascii?Q?xg0QxiII7qBAZBFpwiuiGBgVEr3l5L0eJ0pMtuC1e7gWeIUNXk5Gzd/2eeNI?=
 =?us-ascii?Q?61fSSW/6zWdLbTO13ogD3AAuDeduHEiwAUfnJblZMtKv5nVYrH/5T20JyljS?=
 =?us-ascii?Q?CEeZWuRFPqr6JyOLQvIO3MLVvlpYtkTN0ElQI7BdiIqHtqserlecFBp6Pp+9?=
 =?us-ascii?Q?fCPcz8MusHPeCTudCnMRpkJ42bys3Jm2mgzgO8zJS4/vhNhAr902sB4D8AL0?=
 =?us-ascii?Q?oECqOq5neB9mrCmBPvQc+6F2Y3LsxLknEZIIRaBeYlToQlGLaZLWJqirtmLk?=
 =?us-ascii?Q?A0W8R82L0aLce7xQhfwaVlQ+f2hYH7evdRnQtbaX8kCVT9/du03FaURnRM1Z?=
 =?us-ascii?Q?0t+g/ItFrjlVAr28cd8nA/7DTcgGtQtF66KLrC6DBxgcmDN/bn1Q+TBciLAM?=
 =?us-ascii?Q?Fvv5dY//3EGsk1aDSy7mzqga+K1DgC7oAH1cLG0OPJeEzvkEHnGg19i4asVe?=
 =?us-ascii?Q?NYSPHdloPGwkQbcD3u9a9Exo+zdtT462iO5HvFBEFSt+p05EnWiUk8ZG2e1K?=
 =?us-ascii?Q?y9kAlcPlTUyqLKI+p1KcrVxSssR/NgekY+gj3H0Ygnnx59AI2wVodjm2dVDJ?=
 =?us-ascii?Q?1CM0hXq6nPWQ/3rV9EiVUKsSBWp0iwoFbaIGcKD59xzm6EJl3HvhMQ+NllaS?=
 =?us-ascii?Q?nBxL4nGOi8iOB2eRESGh1pxfF/6GLzy0M1P7RsleMxXuOULLig2VnCEug6Tb?=
 =?us-ascii?Q?PEXyX4BndWsx4KerVusDTMLLWhATCWhz2LxvYXC2FuVuXCEy8W6fLPEikEWJ?=
 =?us-ascii?Q?hGioEwI7HJFAx1XpqAmROvB2uaSOF0c=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcb1eb1-ac3a-42db-c80c-08df3d90039e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:25.6581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3jwfTuB9R/6ZCrDPkofVdh+IlVWujF96PFO1TvmH32iPPzNutUvnHonmj29vvPeqzbibpIS43cpUCNLB+7AUjZHz2seZFhAJa/bhZbO168=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB9138
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

The ISA 2.05 flag couples integer instructions to floating-point
instructions and extended FPSCR access. The e5500 and e6500 implement
cmpb and parity instructions but lack these floating-point features,
so enabling the entire group cannot describe their hardware.

Split the ISA 2.05 instructions into integer and floating-point groups.
Keep the existing capabilities of POWER7 and later models, and include
all new flags in the TCG supported instruction mask.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v2)

Changes in v2:
- Group ISA 2.05 features into integer and floating-point flags
- Use the first free bit for the floating-point group
- Align flag definitions and comment endings

 target/ppc/cpu.h                           | 10 ++++++----
 target/ppc/cpu_init.h                      |  3 ++-
 target/ppc/cpu_init.c                      |  6 ++++--
 target/ppc/translate.c                     | 10 ++++++----
 target/ppc/translate/fixedpoint-impl.c.inc |  6 +++---
 target/ppc/translate/fp-impl.c.inc         |  8 ++++----
 target/ppc/translate/fp-ops.c.inc          |  9 ++++++---
 7 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2bc0e36c5f..4cba527a45 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2570,8 +2570,8 @@ enum {
     PPC2_PRCNTL        = 0x0000000000000008ULL,
     /* Byte-reversed, indexed, double-word load and store                    */
     PPC2_DBRX          = 0x0000000000000010ULL,
-    /* Book I 2.05 PowerPC specification                                     */
-    PPC2_ISA205        = 0x0000000000000020ULL,
+    /* ISA 2.05 integer instructions (cmpb, prtyw and prtyd)                 */
+    PPC2_INT_ISA205    = 0x0000000000000020ULL,
     /* POWER ISA 2.07                                                        */
     PPC2_ISA207        = 0x0000000000000040ULL,
     /* ISA 2.06B bpermd                                                      */
@@ -2604,15 +2604,17 @@ enum {
     PPC2_PPE42X        = 0x0000000000100000ULL,
     /* PPE42XM instructions                                                  */
     PPC2_PPE42XM       = 0x0000000000200000ULL,
+    /* ISA 2.05 floating-point instructions and extended FPSCR access        */
+    PPC2_FP_ISA205     = 0x0000000000400000ULL,
 
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
-                        PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
+                        PPC2_INT_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
                         PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
                         PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
                         PPC2_BCDA_ISA206 | PPC2_PPE42 | PPC2_PPE42X | \
-                        PPC2_PPE42XM)
+                        PPC2_PPE42XM | PPC2_FP_ISA205)
 };
 
 /*****************************************************************************/
diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
index 4ba559d8af..100d406fbd 100644
--- a/target/ppc/cpu_init.h
+++ b/target/ppc/cpu_init.h
@@ -17,7 +17,8 @@
 #define PPC_INSNS_FLAGS2_POWER_COMMON                                \
     (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
      PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
-     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | PPC2_ISA205 |         \
+     PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 |                       \
+     PPC2_INT_ISA205 | PPC2_FP_ISA205 |                              \
      PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |                   \
      PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 224e1ff77b..5fff6d8199 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6220,7 +6220,8 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, const void *data)
                        PPC_SEGMENT_64B | PPC_SLBI |
                        PPC_POPCNTB | PPC_POPCNTWD |
                        PPC_CILDST;
-    pcc->insns_flags2 = PPC2_VSX | PPC2_DFP | PPC2_DBRX | PPC2_ISA205 |
+    pcc->insns_flags2 = PPC2_VSX | PPC2_DFP | PPC2_DBRX |
+                        PPC2_INT_ISA205 | PPC2_FP_ISA205 |
                         PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
                         PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
                         PPC2_FP_TST_ISA206 | PPC2_FP_CVT_S64 |
@@ -6381,7 +6382,8 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
     pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
                         PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
                         PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
-                        PPC2_FP_TST_ISA206 | PPC2_ISA205 | PPC2_FP_CVT_S64 |
+                        PPC2_FP_TST_ISA206 | PPC2_FP_CVT_S64 |
+                        PPC2_INT_ISA205 | PPC2_FP_ISA205 |
                         PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
                         PPC2_BCDA_ISA206;
     pcc->msr_mask = (1ull << MSR_SF) |
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 467b8f3d4e..516a7125c3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4403,7 +4403,7 @@ static bool trans_ICBIEP(DisasContext *ctx, arg_X_ea *a)
 static void gen_dform39(DisasContext *ctx)
 {
     if ((ctx->opcode & 0x3) == 0) {
-        if (ctx->insns_flags2 & PPC2_ISA205) {
+        if (ctx->insns_flags2 & PPC2_FP_ISA205) {
             return gen_lfdp(ctx);
         }
     }
@@ -4415,7 +4415,7 @@ static void gen_dform3D(DisasContext *ctx)
 {
     if ((ctx->opcode & 3) == 0) { /* DS-FORM */
         /* stfdp */
-        if (ctx->insns_flags2 & PPC2_ISA205) {
+        if (ctx->insns_flags2 & PPC2_FP_ISA205) {
             return gen_stfdp(ctx);
         }
     }
@@ -4429,9 +4429,11 @@ GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER_E(paste, 0x1F, 0x06, 0x1C, 0x03C00000, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 /* handles lfdp, lxsd, lxssp */
-GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
+GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000,
+              PPC_NONE, PPC2_FP_ISA205),
 /* handles stfdp, stxsd, stxssp */
-GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
+GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000,
+              PPC_NONE, PPC2_FP_ISA205),
 GEN_HANDLER(mcrxr, 0x1F, 0x00, 0x10, 0x007FF801, PPC_MISC),
 GEN_HANDLER(mfspr, 0x1F, 0x13, 0x0A, 0x00000001, PPC_MISC),
 GEN_HANDLER(mftb, 0x1F, 0x13, 0x0B, 0x00000001, PPC_MFTB),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 5195db4e9a..15afbab32a 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1545,7 +1545,7 @@ static bool trans_XOR(DisasContext *ctx, arg_XOR *a)
 
 static bool trans_CMPB(DisasContext *ctx, arg_CMPB *a)
 {
-    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    REQUIRE_INSNS_FLAGS2(ctx, INT_ISA205);
     gen_helper_CMPB(cpu_gpr[a->ra], cpu_gpr[a->rt], cpu_gpr[a->rb]);
     return true;
 }
@@ -1636,7 +1636,7 @@ static bool trans_PRTYW(DisasContext *ctx, arg_PRTYW *a)
     TCGv rs = cpu_gpr[a->rs];
     TCGv t0 = tcg_temp_new();
 
-    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    REQUIRE_INSNS_FLAGS2(ctx, INT_ISA205);
     tcg_gen_shri_tl(t0, rs, 16);
     tcg_gen_xor_tl(ra, rs, t0);
     tcg_gen_shri_tl(t0, ra, 8);
@@ -1652,7 +1652,7 @@ static bool trans_PRTYD(DisasContext *ctx, arg_PRTYD *a)
     TCGv t0 = tcg_temp_new();
 
     REQUIRE_64BIT(ctx);
-    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    REQUIRE_INSNS_FLAGS2(ctx, INT_ISA205);
     tcg_gen_shri_tl(t0, rs, 32);
     tcg_gen_xor_tl(ra, rs, t0);
     tcg_gen_shri_tl(t0, ra, 16);
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index e0d9fa2e24..5040be632b 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -324,7 +324,7 @@ TRANS(FNABS, do_move_b, 1ULL << 63, tcg_gen_ori_i64);
 static bool trans_FCPSGN(DisasContext *ctx, arg_FCPSGN *a)
 {
     TCGv_i64 t0, t1, t2;
-    REQUIRE_INSNS_FLAGS2(ctx, ISA205);
+    REQUIRE_INSNS_FLAGS2(ctx, FP_ISA205);
     REQUIRE_FPU(ctx);
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
@@ -592,13 +592,13 @@ static void gen_mtfsf(DisasContext *ctx)
     flm = FPFLM(ctx->opcode);
     l = FPL(ctx->opcode);
     w = FPW(ctx->opcode);
-    if (unlikely(w & !(ctx->insns_flags2 & PPC2_ISA205))) {
+    if (unlikely(w & !(ctx->insns_flags2 & PPC2_FP_ISA205))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
     if (!l) {
         t0 = tcg_constant_i32(flm << (w * 8));
-    } else if (ctx->insns_flags2 & PPC2_ISA205) {
+    } else if (ctx->insns_flags2 & PPC2_FP_ISA205) {
         t0 = tcg_constant_i32(0xffff);
     } else {
         t0 = tcg_constant_i32(0xff);
@@ -627,7 +627,7 @@ static void gen_mtfsfi(DisasContext *ctx)
     }
     w = FPW(ctx->opcode);
     bf = FPBF(ctx->opcode);
-    if (unlikely(w & !(ctx->insns_flags2 & PPC2_ISA205))) {
+    if (unlikely(w & !(ctx->insns_flags2 & PPC2_FP_ISA205))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
diff --git a/target/ppc/translate/fp-ops.c.inc b/target/ppc/translate/fp-ops.c.inc
index 9bc9c3a3c3..42dbda3750 100644
--- a/target/ppc/translate/fp-ops.c.inc
+++ b/target/ppc/translate/fp-ops.c.inc
@@ -1,14 +1,17 @@
 GEN_HANDLER_E(lfdepx, 0x1F, 0x1F, 0x12, 0x00000001, PPC_NONE, PPC2_BOOKE206),
-GEN_HANDLER_E(lfiwax, 0x1f, 0x17, 0x1a, 0x00000001, PPC_NONE, PPC2_ISA205),
+GEN_HANDLER_E(lfiwax, 0x1f, 0x17, 0x1a, 0x00000001,
+              PPC_NONE, PPC2_FP_ISA205),
 GEN_HANDLER_E(lfiwzx, 0x1f, 0x17, 0x1b, 0x1, PPC_NONE, PPC2_FP_CVT_ISA206),
-GEN_HANDLER_E(lfdpx, 0x1F, 0x17, 0x18, 0x00200001, PPC_NONE, PPC2_ISA205),
+GEN_HANDLER_E(lfdpx, 0x1F, 0x17, 0x18, 0x00200001,
+              PPC_NONE, PPC2_FP_ISA205),
 
 #define GEN_STXF(name, stop, opc2, opc3, type)                                \
 GEN_HANDLER(name##x, 0x1F, opc2, opc3, 0x00000001, type),
 
 GEN_STXF(stfiw, st32fiw, 0x17, 0x1E, PPC_FLOAT_STFIWX)
 GEN_HANDLER_E(stfdepx, 0x1F, 0x1F, 0x16, 0x00000001, PPC_NONE, PPC2_BOOKE206),
-GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001, PPC_NONE, PPC2_ISA205),
+GEN_HANDLER_E(stfdpx, 0x1F, 0x17, 0x1C, 0x00200001,
+              PPC_NONE, PPC2_FP_ISA205),
 
 GEN_HANDLER(mcrfs, 0x3F, 0x00, 0x02, 0x0063F801, PPC_FLOAT),
 GEN_HANDLER(mtfsb0, 0x3F, 0x06, 0x02, 0x001FF800, PPC_FLOAT),
-- 
2.53.0



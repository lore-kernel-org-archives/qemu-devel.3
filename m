Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FDB606A320
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=DQM1h8vi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1ba-0007JY-Tk; Sun, 08 Nov 2026 07:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1af-0006me-Nb; Sun, 08 Nov 2026 07:01:41 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1ad-0000Wc-IE; Sun, 08 Nov 2026 07:01:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Or61+f3gfzi5DRgOJt3AYwyjunDDXh4ADWK50AfWN/wzanENu5fAUaISSjRXINAmPzpRn0+Z1ZNyW2pNKE9A7hIExsZVP2bKabeDf5dyTm9pzFByYSlzpXCALR9TMQiQIqv3ILtUi5SVrDMnn/9ypjgo+nvEz4qxZqUJnlvpPCP8X4IOeBBbe+fPBAHYiBGbeDdARYEqpuaBAdUuABBJGnhSSQg2oQQvR/J5bi/5epHI0ou+9UOLPtiHLxyEiC+Y0Y26vAUgrZJyta+7F3wTTRH+6Cc7sN3Lh4svRRBIiXMqlJVfVFufCbhBplckPFFPG9GJup4ZBRYXdYJr1Krq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHn53uAAeRzUUbjGX3rzDeCALP5t36etUb+BlIHN6Fc=;
 b=ilKpHDgAHgINHn+L+dTyxfYJyjHlcOfuhIMpZmtRk//Y2eS2G6k/okKAbx2oRYB6hkPfMZ6/SKeDZ6wHJ8uOXMUUzIa4R0qgXYaa9q+oBsXWXVlQV3fb5vtzWQkx0qEgI14vsQ+amWhP+3J83vTHjMvFXp+ochm0RaELp9rocG0ZDg3regzyF+KKnfOk7A5/oDLNIrQzDaD87YumOeBYdLo/tSCG3d1FagsITggMz6uttksrE6xNzc9b8eGGb9BjRBCeQSd18OvG9NfdxTceF6OIhcDMwL47zrLueqb8neqPR9f7dorASl195yi6wInyD1kKy8+XfOLDZygdT6tBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHn53uAAeRzUUbjGX3rzDeCALP5t36etUb+BlIHN6Fc=;
 b=DQM1h8viDB/3HHYektkzNKTGD5M/T3gdN4kBSx2oNFC743J+n7Qi1TZOrvtiqE8w+d5rJ9sraLGeVpJ4PtKeO6DSffZU5m7eTqXA7rl0sxZ0gGZuyKZp50X7gkRzRA6286yQcYwQu/RpDRda4IRuPOdQyiPvhPPzpCU0pF6by2PLE1UftyzV/yATLATXHU7102kTFI83SJxBwmHb2G4YD3rUr2j5neB3QRPm5oj4bEeygLo9XATb3YhS6momakACmEF2uEQnN8q+pduFcsofxLIlUaoYRR6/6XtCyp7uKy7nWPOPkR2izzKfWcZlAp2IWlJiyJrfp7HtNIzCS63Oig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:31 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:30 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 14/23] target/ppc: Ignore FPSCR W/L fields on e500mc,
 e5500 and e6500
Date: Sun,  8 Nov 2026 20:00:13 +0800
Message-ID: <20261108120034.1755008-15-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d330580-6ac6-4d65-3aaa-08df3d9006c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|3023799007|261102123227099003|261022075727099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: srwdh9CxAYY8IRQov26XWAY435lDrdwIPyZh76fFVOzjFVJSmyYsTeVpA7vQS2TRyP+1i1SbKW/OioTSpEU+rr+9cqAkuOX1TrqSnuTgLPIun4vEq3eZeHm6V7Kx5Xynam5gl9MyxW+nnyQQUgctPLbBQxmvlPv6C10Zyg8J06tZXdQLOzK35VSFoUUPpAxBfwokHq69aOe/r9EaO6HcKPnoydsAsTo4qz+upnK/3KVdRbRgHV0iKWbZD2jIJ3iFb3Ty/PbNGz5sXX6puNcKs2BOU2f1aULhdz6a3pRKrsKHgNN0OZE27r0kGm3PXh3Zfy+H3DV1dXosRHM/cCPkFop99C48+50UvT3rtAdM55eP3cPkSjUzbl6QO2TGidRb5GNZJknifKtkzSgrbOaJmfCSJsobGa4cE9Gs8PSlXIBa73DwvoY0Kp4Ycue2bjzIy/qtJ9yIECIy3HI7hipIgTh0WR1fDdxlwxWKKRBV47sHYMsZqgKzYySONOy69XPmqs+xIzX6eI6EGbcVwVylJCob3GhGnevOVQx44lmsGVHgjvwtxfKt1yNxHVuLCG52Cx9G4J0qB810kkj693s9OrDmg5Co6UZd5EdqjiXTocf9uob3qxnPPfbZhvhD1SWyujtv7BnyKRX0SO7Z5irpcVuHgetjcO8UC2zyqWg1B1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(261102123227099003)(261022075727099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ReexaD7ujRuGDbXUe3mE9bIUDtO/VAcjHIiAToyaJe+HycXe+qW1mMEo7gi?=
 =?us-ascii?Q?zDz+npm0sYcfDkcFC5a7scRq+k8dBIafk9VQE8tcEL4HE5h+0oF3hGeXSdtr?=
 =?us-ascii?Q?4+0mIgyaztBkWCqGJ8GOi1d0k2/brAjblGv4dhvqNqYYr7lI6Zr2/qa3kum7?=
 =?us-ascii?Q?2IdmiBWSI7IvE2b+n8i/ec4VL9u+whyW1F9QMPbhVfWQ40zzt7KRkbraLXSz?=
 =?us-ascii?Q?N9Gkcd55bi79sTgag2MKaqtUKTy34yr22LmpTDPfSh5g0nWktWiSpzYGvP6g?=
 =?us-ascii?Q?z2NczNmuuv+pk4rlnSmhv6JkXnqELUb1ym3GoPqwJyS69jBCiFVXkpO+qL7E?=
 =?us-ascii?Q?EIoKe+4I2ZPnZjZZ+QPmW/HdmXUsO6976EylMwWVI13+m1D0AmiiULS9iiLk?=
 =?us-ascii?Q?IcSzsARZBuT4rm6GnNWd6ttAeZh7ESbijIky9VfwJh13RBFgJc7r9ehtpyTE?=
 =?us-ascii?Q?gHxae0LKBwFrXpbAZg4OTwy4decoDlDMTOj42wFgOiYTpEDFlTfADIktBWrS?=
 =?us-ascii?Q?f4PvoRlsEsOZoHbM3GSgBD59QZdmrRD7A/hTF+hsJkBAaW5atiBVTNdoL8vH?=
 =?us-ascii?Q?PPlEh88sNbzcfODb3osnXVgFLkC8qZmVYDsJGo47M9+G2O/JWyI+xscVu29K?=
 =?us-ascii?Q?ST0gEd2LI+YJraFQhYD4LKtZDbbndpVkVr5j4/LFFrkQRGKRnjeuc61YT/mh?=
 =?us-ascii?Q?F1eqm+3AKcoGE3eOGgRADwFjg1w54Vf2LYrN4i3nm2EvILQZbEl5npOricLQ?=
 =?us-ascii?Q?tJ8vd4sCveV3EYdkVyVrd9mwHfJA3JZmIDvMJFxbCrsjrlDIP5YoiVId309j?=
 =?us-ascii?Q?Ot7wxg3zOMna9cRIGDvtlwBCx0G1tW5hsWLe2x+oQO7XBRHK9w96rCgU22wJ?=
 =?us-ascii?Q?UKPKQN8l6qXq/4amJRDKf7Ey9d+BErxM9HxWf2UBf2OCVr+v1K5qcRtAsMvb?=
 =?us-ascii?Q?r4IyiOOyrz5JkxT1GtTr/64YIYWFR7qpz3HJumNcCTQZPajTHrVTMJlxFJvH?=
 =?us-ascii?Q?X8fLXmYQ0tSIo5Z9Nhr/11mjCflsNVa5dWSxCGhWGwYuMIpY2BOymUF3m9wr?=
 =?us-ascii?Q?QkUNJJqUoJOhfQ4GtPwrxX3iaQtxB130splXjvsPoYqYF+qobFK5D7lcq2P8?=
 =?us-ascii?Q?PqqS514Z0kesa24tZkDUp9lIyJVX4ulXCU/J0vLpwBJUYH5qg0vpfUOf/GAV?=
 =?us-ascii?Q?31nSMkJe5+zPuc8Q9yZftH5MWwzf1aO6YAmcxGPf0pHRopLXJ5s+lrmozqqf?=
 =?us-ascii?Q?eFNzabcFRVMjP6F9Z1o2qsSsUvv8um2fLU52DeuXZRJg0UrZaN2aV/lbz7yQ?=
 =?us-ascii?Q?xJx2NtMOEZOvMZ1G20X876q7KlXvZVEurWxdyigAu2lMaTj78cV6RZGh06WT?=
 =?us-ascii?Q?Sq3vAz+C7KYnEASOPJtTr/jes6SumCqoee+5HxfKyFZhYny4Hh3MF7/nJuGo?=
 =?us-ascii?Q?79Awiv04/Za9iPLCk0SX7SuKwi2XcoUMlw21gLcOcBRKIAAzOX8tvwNIKfIg?=
 =?us-ascii?Q?t21BS00rcrmM+jVgeRooT6gf5GpBPWkSKLgUmMIwO7qHBN3HSqX6LgUtbNCu?=
 =?us-ascii?Q?N62d00yjrxl5Uy/Yko4bGdXhsckwOVoTPMqZMhJHF31zPUiay7XZ7F6u9HRW?=
 =?us-ascii?Q?JcUEiRsNU2amn4PliloyqYEvz8Pk6JwUoTBY2sVFa+clxZMdnb1rItq+DNlj?=
 =?us-ascii?Q?46/HnuQu4IKY6GDi37K3dlTXZr3zq6pTG09CV+i45UkNbBqJjXnnjgTMmhxM?=
 =?us-ascii?Q?kdcFqpJFleLeGiRbJZr1R5iSiyDRhEc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d330580-6ac6-4d65-3aaa-08df3d9006c1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:30.9100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIfJEtNo22r6bXcnYNgl+wuxvzRFktX0wm5W36FStWsl21sWgXwDWqdA02vCQRLzKnNFfVhDJSq5TqNJGxsWJiHnaLWLzAFgjBWpD5hTXRk=
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

Table 3-1 of the e500mc, e5500 and e6500 reference manuals specifies
that mtfsfi ignores W and mtfsf ignores W and L, behaving as if these
fields were zero. The existing translation rejects W=1 without
extended FPSCR support and honors L=1, which does not match these
cores.

Add a processor behavior flag to ignore these fields without
advertising extended FPSCR support. Keep the ordinary field mask
and rounding-mode updates effective.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference:
- E500MCRM (Rev.3), section 3.1.1
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 3.1.1
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 3.1.1
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

(no changes since v2)

Changes in v2:
- Align the FPSCR W/L behavior flag comment ending

 target/ppc/cpu.h                   | 2 ++
 target/ppc/cpu_init.c              | 9 ++++++---
 target/ppc/translate/fp-impl.c.inc | 6 ++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 4cba527a45..7fe02887de 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -846,6 +846,8 @@ enum {
     POWERPC_FLAG_BHRB      = 0x01000000,
     /* Use PPE42-specific behavior                                           */
     POWERPC_FLAG_PPE42     = 0x02000000,
+    /* Treat FPSCR instruction W and L fields as zero                        */
+    POWERPC_FLAG_FPSCR_IGNORE_WL = 0x04000000,
 };
 
 /*
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index ffd4930cb5..52340bb84c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -3188,7 +3188,8 @@ POWERPC_FAMILY(e500mc)(ObjectClass *oc, const void *data)
     /* FIXME: figure out the correct flag for e500mc */
     pcc->bfd_mach = bfd_mach_ppc_e500;
     pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
-                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
+                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK |
+                 POWERPC_FLAG_FPSCR_IGNORE_WL;
 }
 
 #ifdef TARGET_PPC64
@@ -3238,7 +3239,8 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, const void *data)
     /* FIXME: figure out the correct flag for e5500 */
     pcc->bfd_mach = bfd_mach_ppc_e500;
     pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
-                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK;
+                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK |
+                 POWERPC_FLAG_FPSCR_IGNORE_WL;
 }
 
 static void init_proc_e6500(CPUPPCState *env)
@@ -3288,7 +3290,8 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, const void *data)
     pcc->bus_model = PPC_FLAGS_INPUT_BookE;
     pcc->bfd_mach = bfd_mach_ppc_e500;
     pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DE |
-                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_VRE;
+                 POWERPC_FLAG_PMM | POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_VRE |
+                 POWERPC_FLAG_FPSCR_IGNORE_WL;
 }
 
 #endif
diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 5040be632b..7e866a876f 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -592,6 +592,9 @@ static void gen_mtfsf(DisasContext *ctx)
     flm = FPFLM(ctx->opcode);
     l = FPL(ctx->opcode);
     w = FPW(ctx->opcode);
+    if (ctx->flags & POWERPC_FLAG_FPSCR_IGNORE_WL) {
+        l = w = 0;
+    }
     if (unlikely(w & !(ctx->insns_flags2 & PPC2_FP_ISA205))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
@@ -627,6 +630,9 @@ static void gen_mtfsfi(DisasContext *ctx)
     }
     w = FPW(ctx->opcode);
     bf = FPBF(ctx->opcode);
+    if (ctx->flags & POWERPC_FLAG_FPSCR_IGNORE_WL) {
+        w = 0;
+    }
     if (unlikely(w & !(ctx->insns_flags2 & PPC2_FP_ISA205))) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
-- 
2.53.0



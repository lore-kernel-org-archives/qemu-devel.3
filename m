Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E51606A333
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=TrR7bUVz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeu0-0005KM-I0; Wed, 04 Nov 2026 12:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesm-0003E8-LX; Wed, 04 Nov 2026 12:34:46 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesk-0006Dv-LJ; Wed, 04 Nov 2026 12:34:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XG7j+Pdn0LMTbBIATh5bMrI2Y+qGDA506qIymIDEzi8mqdRkiqbCupkBuHx1NnIjQ81dlRWHzN+QrhIAu7SFqpX/Exl0pPab+/qzcwY9c7TLtO4XjDj9ZPNbqgQq+SXLGbtUelqNpVPNfS/fd9fzG0eGnuTokLqW8Lrr06Z6GSK5P4aPPjd18pQK16IP/vXsv2ufvoSrSl7wSENbnru6eG+P1t+D8+nwbn7icf9mKF+aipyF7OKBysk2ONPFT4Eti/Dh96eUpN/CIJqA4t3uvDSb+0bajR+yuEPHlY/XoCQRJxA6egdc0ZCc5AcDaq15/F3bP+fwm1tAll4DSOvnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCTZ3tBsYIiF+O3MOFCAUB/iJlHTVcf7NQurxdOcE/0=;
 b=ye33CRKYE8q01aI3cBJI9TT+rT+hEy9jpnDPu9GjaloJS/P1pmQ3JxL7ifJjE1wOWfmbeZGlkaktx0JHV2zp0NtOK3QXrqHZggSjiB9nft138dEKkR34oroP835J9d8o6PB5P8hcnrxd24TcIu185UA3g+VUaXAiRop9N/pBld/bzm/5heH5kehXc3Na3UD2YcsbERMANQRynKbDEHOvOV3TkmafFKDxoKwJrGc0nmLSfRCwF4QQtYclobbJh9o3pgvsinZOt2d24gdJdRrXuCFUtU0HhOLq91WklgZjH3iTdjjePab1JpK2palPa8vi24n0eVkIRMqTDE6a+6dEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCTZ3tBsYIiF+O3MOFCAUB/iJlHTVcf7NQurxdOcE/0=;
 b=TrR7bUVzGxQ5M2G54EQSdTQ3kyRgfk5DgmD7CmGgxLZ47z3YtaUlsiHmVbRS5ydqAa9a1t1f1tsPQblsveM1uHGn8pjzaB6qE8Mw/5RgVCUXoXIBnuMQES1aZsX1UEJBEbgwGSD8Tg5Q9vuY0ZSTRSYXvZFnlyPZXDDt1u8xynIScovnrVX/cirKfpr7iDfo4mzPPAJgwZCmDgSAQLjP98iOtGI4ntWcy1STlwbK1aFkSOoU0DN95ItkBRtO7Y55lxNvh7F/SbOB5a1jB79Ylo4o0f7yLL+/nwct6698OJs+Ku7q/wu3ZKfgUtWyXkOF5ykoYbn50G9mPsMyEEM8sA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:34:08 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:34:07 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 12/17] target/ppc: Split the ISA 2.05 instruction feature
 group
Date: Thu,  5 Nov 2026 01:33:15 +0800
Message-ID: <20261104173329.706635-13-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104173329.706635-1-bin.meng@processmission.com>
References: <20261104173329.706635-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:405:372::17) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KUXPR02MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fbc33e-d224-4675-5dd2-08df3a99d46b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|56012099006|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 4D9O0/C46rPrvAQFG2u/KiFAbJ0qviWtxZxQOYTeOC9hW9L7K3vZEavyRP40cxEvlU+Q4nhC7HnmcyQk3FeGvxvn3vZ0w2qjZ4uS0AasP6+FwmsagxOQEeUHaRi9QYUl32gNuceKv565uZyOAQUCcgNM9+e2/02D0G8vD/RgjJvsAUrz92cgZZhcdLyyiQ28tmSqEthFiK+TUzGVnM5ZzMKDzq4/+KjNLCAL9Yqea7JKDDz73AUnpdR1Sj+sX/6wz4eK9NmCbzktHdDvhP/qCOqYPPATkQ4sGq0y+LeeR3be2/0j4iJPTi20xMfOsQGMqscoIkwS37WV/pw7xuzQyFPdNR9rnWBTWC1uCNRunAGaEAKJPWYeqdejxLz4dmmYOo8PtIupIzT63xF2HEqEzWkvJ3VxKi87OoC41tQSwdX+GvobNaE/gY+xCJBgZH4Hdg/Mg8g2aL9wmvGln7U19g/bok4TtFQLFXR3PscgrMdirawOnuUwJPo9f5Vewm/Nnw0IwmNXvU2G8dTj+MVsUOD32JziNE4ouzr0CFa1hCaEUKynPT/FxuZSOpohi4BQjU6c5jxNh3V08J3ZEqtnh2hbd1pEbYjLZ39yQq3ezAEA9hGtjr0JL6ghWzVVa2bO6PJ6CYhPzPxf60IM82dmX88aCZBB+hb4NP2FGPmUE1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HDt9gCuUjH6/03wXwYEY+qCSLCog7uR8G86xlo0CRr03g0j7m4HVi6miRYGe?=
 =?us-ascii?Q?oqQ9lsipeJPOoaBpabzsmEzjFxOWTbh+cwm9y3t687YQ5MV0T6KTqPDhyWSk?=
 =?us-ascii?Q?y6lTclvRyODwRL4TuLByt7Xz3ujJl2N8UOqZc1AZjGtCrCZ+rfAEdKfqlh2s?=
 =?us-ascii?Q?aZpvC5pL5Dx+i/OyayQ+M3rRJZdhjac7hiuLOoFyejIgyuoSU9zN5vzOMNh4?=
 =?us-ascii?Q?AYuy5OVUIGRI1yjDIzF7pgmx5xh6DVuiZbXTJgMR6hwuwvUO/jus4qmnlaX5?=
 =?us-ascii?Q?SY1A2ujQbaEkQF3AjPWH6i8Q/3/dSIvKpzndBJkLOS9Ug0VZsh/c3xF0D117?=
 =?us-ascii?Q?I+CxBFomrfM8Y4weA241pRoJX2K3SdxtTdw2irZ5wsvjlgqvNwVRf7HRnphv?=
 =?us-ascii?Q?fbdSIBJAmPK3dzuf1aozvoRMkGQpS375qEd7VIswBERsHa02r6zo9GbmcbaA?=
 =?us-ascii?Q?e7SR3ROnzb7aFTxGuZYePsdQuQQRairUrQM1lcTBLEurefzgvH9+iTg9s0TG?=
 =?us-ascii?Q?+0jnV1N8Qx3c/KJZQaNXh/ELwdJN+cC9jUZvywFz6LobFAYpbvFmTIsd9KM3?=
 =?us-ascii?Q?Ebne3uhcLstmYNDRsd33xrAb9mQBiT8vEapQQI5MF9cwRwM3XlH/YVHebz9f?=
 =?us-ascii?Q?s2fjJnD/FMoJ4/b7sKIn0gyDzBzuZg82lhiLd064TasgBXKlgX01DMsvSbRH?=
 =?us-ascii?Q?v8T/oqwpasY177lNdDAg27Ck0wBP6LCkXfbpleXqmbYZLlGWAndA2tah9U7n?=
 =?us-ascii?Q?r25+maQSirCdmSThdXQriALwB9G8Ziv+Jz8EpRNZv5VmONTAiZLTOEs5QWgs?=
 =?us-ascii?Q?kqoXPkjPbjzjhy4cgk4HFbd9lJHQlfU3iozIAAClvplcotZ7D1yvQWaa6rCE?=
 =?us-ascii?Q?16knBirIAtiUjne8TWNyX0a83a0YR2qmDKCeA/87e71CBnqAqq/Ew7bTNrmd?=
 =?us-ascii?Q?IvspdUgQQeS5cIM/tqVLzKA4HXesmFPP1QTkQ9TA5xNUpp+Cy2y4DtYMsGG6?=
 =?us-ascii?Q?BgAzvXdw6erK+fT6Aw6uSpg93ZDpIOqSVfbXCkkWQ9iV3QMISjj+sDFU/to4?=
 =?us-ascii?Q?69phfNip/1g+kadLHcgTtHOTz4p2VNlU/xwpa0WJSn0Cu/jzyVGb4nqemLgi?=
 =?us-ascii?Q?5DoxPCw4lFm/MafyobOvO3Rjgdvo4mDRZ8gLrwzxx9d5tHfwHd7Gu4Z31jje?=
 =?us-ascii?Q?cB97RMuIO+67byDcYuany+ai1FfOMLo2BiuQf3Cr9TjfrZ7hulCSeh8ByMda?=
 =?us-ascii?Q?tAgTJiymnF5zJFVppyokdyiPivkr+TFLYHLMfPY+m7lLLkC/hv+2+h+Vm8hn?=
 =?us-ascii?Q?22dTEbTS4Dmd8tX4QPbDRYp7EI2tUgWlNiqtnALBA5Gg7chSnUWh4lxCMnMz?=
 =?us-ascii?Q?hKuv72/3dDB3PXixhobKbjli40x3/W7qoEEvTEqcbas00TPeTA/iuI2ZC/1q?=
 =?us-ascii?Q?fCgeZ/3clFfW7OhXdvM+Y3sz99Ip1Lz9OhBGtBKEX2azoBu2xvV+8djVet0K?=
 =?us-ascii?Q?UT8yAsTuK47FlKxUs8BwipoWjP6en++O0ddKd83RVLFlz3LSbPMbv31TOnBC?=
 =?us-ascii?Q?L6AYkNhG+v+UWxAa3ujmXta6pK2CTw+7ipFMrJ5LWYzeag5WJHjb0WUwIYng?=
 =?us-ascii?Q?AwVxwXllYx7UnhJk9KOgZXRcMxqLR4wtr1r98nzdRT7r0wXPmcw4hkOAOYAV?=
 =?us-ascii?Q?gukFiQFsUrcYTJT+c0nNlYELlCrbq510ZXpkBQj1rya9rF+EsiS1YfChSWKu?=
 =?us-ascii?Q?x4rY/w5CxAAxCORa59uPQdqxPRJ4pMc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fbc33e-d224-4675-5dd2-08df3a99d46b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:34:07.9453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zESLaBSH/9H9AwzbQc22Ecdj8dfsB/RbWNFnul2V6xRaaOWKTQ3L8Blw/l1n6b+whxdnaqt+LwR8lmNe6S16FtsDoeynhFneoFhJy3sUvyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB8801
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



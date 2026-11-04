Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F79606A336
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=pTOSaRTE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeu2-0005Zw-Eb; Wed, 04 Nov 2026 12:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeso-0003EN-2p; Wed, 04 Nov 2026 12:34:46 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesl-0006Er-Uj; Wed, 04 Nov 2026 12:34:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXcc9aV5yxFOuAPaDZX/pgiPPFD4z5kQH+RFzrBhMrbRaZJ6usHfd4BEUfzfDUCU1JFVLg4c9KbiOw7Uh4sxhQCkSJ+CKxOHFrwdw38pKEXR4DX/1NkL4rLFUv+BMz//4wn87B2OhmkweWLj1jbHib9qDKss17Bw0Y7lIvxyTfY3Xd9nka3kPAwPLUum2GOAp8bNYsZUBZ+QdQV2HtUN83FSTAOeISUQ7xSvhrsaW6IIYBGq1y7XSs2pPLjzjRsBOYTlaKgco49a3bVRIz8WVuKMzG1F4spU/l1aWHQXqiRI+/wF7K5cuM1B6ymSAERs1ySG+2keAORG6x0C4/mhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7LSGjSy7lzPsOgrscWIDYlnUubg6RDKSm6gcJ0Q+hU=;
 b=uGEtEJZyPnGzVIZrN4cQbELQG+HA47ScxISZiFUL088VTZ5LCaadYd68D/fpwKQL/cbqik/JdrSaUPd4G08/l4IOWvmfmappkNJkZduMXV2IE/jYg7txwtKi1foQo2+O8fROjrN946XRkLpkTW4TYfT4wgHmJpZna1yqXR4xHAJ/5V2tfrDlb/ADrRPX3Y0bz7ebAUxBun+T3XuCVMaugK+BGD0fBg2r+9c7JjoUPHWu5Qfg4g7D25eKL1CYqLvhh1wFqTSOXyQ8CiJ1t9Z2ihUFFN9EA2JfmTQApp54RwDyQvckDtGpLmX4eTUxDVBKSbRUWc9k6GJZpbIVrS6pVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7LSGjSy7lzPsOgrscWIDYlnUubg6RDKSm6gcJ0Q+hU=;
 b=pTOSaRTEDUL2USjrpDPkoM9S9y1gWycgzQX0J6L2z8sL0YhdF6WEn/OFiMYlnvS/4WbFoEla6m9aL0rlivImPeqgZwLgCCLTQU7Ku5tbSX74jowl43z61LQCn5uhQF22+C2TXcspVmcS8vV0CJCVKQKb/1hD+FAU/o+/OGGeZ2YzjmUUZ1gKRRNeJaXcHVZW2Zk7atDa22OiE2vHg++XLPNH6WDNPitUxFbf0aZ70LVEhpDEqJyMJCHNxO6XQp6JoHl1VBr9b0CfGD/sHD95LSlpyP3g9ssRKDMAh4zwxMCmQgOrvWJObP2C64DE1ak+W/09AZ0p5vXxhr1PLOG+jg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:34:09 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:34:09 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 13/17] target/ppc: Enable byte comparison and parity on
 e5500 and e6500
Date: Thu,  5 Nov 2026 01:33:16 +0800
Message-ID: <20261104173329.706635-14-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: f01dba01-bb66-4b1d-f092-08df3a99d594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|3023799007|56012099006|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: LnSFHbkUx5xRyRzRJNJTNVFZ3LVkWLCY64a8aqMOUYUm9b0T4PRNGXQ0ekNeFuOIya/sxRbVWkSP9r4hFlMxXSq+k8RexWmYxMZ5Uu8rQq3uY8nFDaOAGMfHc0nywZTF4wkwvrbaz5AJNjAba3zWRH0KTOMU9UxzG5TqOT8IO3FqY2M9nUVMZexi20ARq0VSh6NB0b47t+u54X65LDHl6jk6Ard8T2pTc83gdfXkkmvOCQy9f8Y49UgdkelSBjbPxqAzspyR2G72oEKt75WMJPEw87VbU+n0b48PivSwWeuSU0CWCmyJo0OTqZUBDr2+uD5ckdzwVoS5sj6HrD3QXNxWX/E8cg9rRVhY41v9l0/wf3fLhi1a6DTkCUtsn7mip1dbzcUvkVgx9gLSYReK2fGkW5oLUOKefzy0LonMk4hIwiN6eacA5ffKEWHSpGfrK7BmLc3R3cZFwTp95Dxgkhpi0Q8M4ab7JMiln6CYUkOrrUQ62/9UzEwxXxniKfilL0pifrXHEERmmrYrr7MT56eAIcossp9b2HDPWxHlKfPch3QBuZyYbnduf6zW/kaOcoD7N62lymkr3JutvbmHw5Wo/abwNBtnh4Mcr56TkTqS56VVBAPDIu22qpBtetJECIU5f3y5TbGeeWKavdZIbUS7k9n3X4IvZhNoFjTvuMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sf81TaWp2HWth41q2T9KqHp03cLDotMiITvHtelGQOGG5vdTzs/ipoWiaDmz?=
 =?us-ascii?Q?UPnjioiAQ+ToqDW6cQiXSW2Jc18i9DiVEYWcSiHacGxQjWwdzNY0+vb+EbFl?=
 =?us-ascii?Q?wfDKVh7U6CAMmCRPbOCJlo1VV2lVNnCy+aiCnb/4wWxnprYlUk/f7fvhEpBi?=
 =?us-ascii?Q?ldop8wPNIHz3RwlbUhd+ISoKZOJj2jnFPYLncNuBU2850MRcZGWniNIl03mi?=
 =?us-ascii?Q?/3/N9C8dwW6t4MIc0wVI2mJtOfi020ml5OHW6/i6JSKQ41lFuvzHn0A+fwt5?=
 =?us-ascii?Q?UobTSYPxS+WbzaK/ed2X0IDZsqnNpzDnNELsZLtJCFxfBSIbesX9r+EgLmB3?=
 =?us-ascii?Q?WmfnMOXLr8nPcoHANY1gcvqQVLQ3FfRA1ELiHFeMdo+sIzIENpKFIvsTrtOY?=
 =?us-ascii?Q?bF4GpPKMdly1tEDCqMsFRS3zluSf1AmV9072l8z1iX/1q2j25M3CS/qD+Vi/?=
 =?us-ascii?Q?gByHlxYtq1qVoeLZ763CPNlD2fJot7HeARTziF9FT80juktAUBOeCLISwo8X?=
 =?us-ascii?Q?+q3wBk1WRySYzg6GA3S0Ij2R60PNbRRQyK/zZw4Dxwbc9JRF7m6lhAXuz8/i?=
 =?us-ascii?Q?HEOXUz2w7PzevHfPrb27wziUXwULHSmc75z/4ycK69sJGyTTwQ/3mJeIWaoc?=
 =?us-ascii?Q?EWAfff2++B5zf/gzI6E2nW0fJSvj8kKtaJeGSFp/b8TVdplMdqbIAcLK6tmC?=
 =?us-ascii?Q?5b3sdTHseaviNHpetueZXxZIbCJXH/57/Qrf80rsCiNi60qsDyyLpx3Vz+f3?=
 =?us-ascii?Q?uaBt64P8aSBGo38qPUTEf1fvDGESxp4KQH/wwQ11qo++Yda8V50QlpfRYjhK?=
 =?us-ascii?Q?vPJJwv/9ZaNIJYMuNHv29uFl43GOxS64LcZkMVAyno9/gsHI87y2R6BDC53M?=
 =?us-ascii?Q?+G/3ipy9KOrWrKJPVmcee40Kdw6gXAgEkZejrz8cUNzowpup2J3osfoSq9Ia?=
 =?us-ascii?Q?araDysz+Nl+W1HrF1nmsVYxzrIzhJQdO8jT3aezbu1V+waxuSqJmMBAZVHhY?=
 =?us-ascii?Q?lA8GWUn9vhdzDJ/bZNmZohWIeLAjXk45Cxpc/Jm4ry0SJrSyp6zkbC33gBri?=
 =?us-ascii?Q?IhEqrRt0cwFqDB/1CFmG/SS39u6eu2k3ntcewlF83VLspiMe1qJMN3skD5tj?=
 =?us-ascii?Q?uK4PyRRfnyrEpOX5Ndg58pOmfdc4zb5e564najIWirMlAOhVCACbMGdIrKOm?=
 =?us-ascii?Q?S+mOH3Hzl+ZKeSt323hhm5huqCSl5y6O7B6AvUdS2JpaF83lFJfWgqv3JgqF?=
 =?us-ascii?Q?AauoIx0KCsi9poabTUCHPMyndWtS7Ch2TyePQARhms98UnLE0QPV7DmCU+EO?=
 =?us-ascii?Q?7VZJEQRoBZS7+4PYXqzilQqvOF9pYfSOfehqHfreUEZxvB5+WFKw4B/eHiCN?=
 =?us-ascii?Q?xtTsSAadrSaPvm5dM2JJ6hzwk22//EgqxH110fGpW+wdi5nZydG7OxaEpnqD?=
 =?us-ascii?Q?QOSf1cMI0kB8HYroG/kiQYG555ueWNpZTOgTXq4085/UvzxfTlg8mHlLAjma?=
 =?us-ascii?Q?9xqQtjumkWCSpe3y2StKTytojU7hkb/dWo3RZQHCGONskugtKobaV/ckb/G+?=
 =?us-ascii?Q?fMkd57zkiehqznGNhNDLslN4msQg5wYadFdc6RUKcd8BN1GfzDR8IJ6wlwGo?=
 =?us-ascii?Q?WCHOaHQethdek5ZhJLxZyph2FSYgI+Kjifn0DVlIC4JxbASo0qDw370Wb+Le?=
 =?us-ascii?Q?bzeicy25bUUVwJru6Yh0pltB+zVuwtDwyBU9M7mUC9pZSi11xuWXWtNFc8tu?=
 =?us-ascii?Q?ecjDzZSWX3hKqJWtRm7a9id0VUJ/JbA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01dba01-bb66-4b1d-f092-08df3a99d594
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:34:09.8362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqJF0nl5zEdu2gViaJQcx6BaxU3LiJpdrrV5UfRvyaRwdp5932cUHMyoVLh74XhyWYu/pXV0zZwkL+nYKEb8Hg7AGvzuFgj655gXkPvDYx8=
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

The e5500 and e6500 implement cmpb, prtyw and prtyd, as listed in
table 3-7 of their reference manuals.

Enable only the integer instruction feature flag on these cores.
The e500mc explicitly excludes cmpb and prtyw in table 3-1, so keep
this feature disabled there. Unsupported floating-point
instructions and extended FPSCR access remain disabled.

Reference:
- E500MCRM (Rev.3), section 3.1.1
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 3.1.1 and 3.4.3.1.3
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 3.1.1 and 3.4.3.1.3
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v2:
- Enable the shared ISA 2.05 integer flag on e5500 and e6500

 target/ppc/cpu_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5fff6d8199..ffd4930cb5 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -3216,7 +3216,7 @@ POWERPC_FAMILY(e5500)(ObjectClass *oc, const void *data)
                        PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
                        PPC_64B | PPC_POPCNTB | PPC_POPCNTWD;
     pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |
-                        PPC2_FP_CVT_S64;
+                        PPC2_FP_CVT_S64 | PPC2_INT_ISA205;
     pcc->msr_mask = (1ull << MSR_CM) |
                     (1ull << MSR_GS) |
                     (1ull << MSR_UCLE) |
@@ -3265,7 +3265,8 @@ POWERPC_FAMILY(e6500)(ObjectClass *oc, const void *data)
                        PPC_MEM_TLBSYNC | PPC_TLBIVAX | PPC_MEM_SYNC |
                        PPC_64B | PPC_POPCNTB | PPC_POPCNTWD | PPC_ALTIVEC;
     pcc->insns_flags2 = PPC2_BOOKE206 | PPC2_PRCNTL | PPC2_PERM_ISA206 |
-                        PPC2_FP_CVT_S64 | PPC2_ATOMIC_ISA206;
+                        PPC2_FP_CVT_S64 | PPC2_ATOMIC_ISA206 |
+                        PPC2_INT_ISA205;
     pcc->msr_mask = (1ull << MSR_CM) |
                     (1ull << MSR_GS) |
                     (1ull << MSR_UCLE) |
-- 
2.53.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5249606ECC0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=J14OZIUg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeu3-0005ih-DA; Wed, 04 Nov 2026 12:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesp-0003Ei-9w; Wed, 04 Nov 2026 12:34:48 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesn-0006Dv-LA; Wed, 04 Nov 2026 12:34:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfjoKgrnAHkSmUZTW5fXAC9GIB4ENnejOMzepMs8MvOk3JoaaW6FZAyCo7pPvXVBRmlQVZTgvSqxG0NxLcb9weBCn2R5mZOiwCq8zAnT8gs4drxI81OyAho6U4BKcrnuseK7tTsBX+W56poJ2/Npl0Jc+yCE1t6ccLaJDmtB7a+kpOnGDngb7GtuTUc+24sxUU58W7YUkQnMfTgK9jR6S/oBXrUwZQfUfhT7ajIJ/G5PWXCLT3vorJaoGG+4kz5d4HrmcC9bOJh41PBtSI/PjQorZpmYtsBPvwsoTiFdUMQxv+s9ZQho5SStYDNyzl1qoCn6XSoqlzuDTAsn0n3Eiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThWEo8eZFIsZbdWagtfM5DnaekfHe03AykL1eqEaWw0=;
 b=f/wNdwjY6pSAEZSUVRva86NQwEDGLqMKCe965HS/50Gx/3LOSTj23Quwk+UXo812nOc1S4TYRzCxRwQAcJ5uZiPR0akGmMM6mYR5LFYTvg4PfJPxc20wQ6z1/XNXfsjzj1esxQzpHQrKOjqBB7+x+S9Zv2fkintIhOIjfwrkhoxgiU8459NnlEsBVFqBETX7BO6TrgzMWTAZtqDv1rCpl0l7lWvUdVjDeEzxXZaxPvVIlmlDW2SG8WHH3iWlbBZGd/2u+1ViM7hgKulnMXsVZASxeGmgBKvxn9WUDs5F2YVflyNszUrlhAODbvo8H2XWVNraSOnWHnmQt72so9zvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThWEo8eZFIsZbdWagtfM5DnaekfHe03AykL1eqEaWw0=;
 b=J14OZIUg7HWtDSgEp0hdSm8yQ1COsTwVL8/pd5Iwy4qYyprhOZ7Fu/J2PyOpPf0oblDIGUo4luGusisiHKhfzv7NMDWzviyAFnwELRn+MN3qp1R0o2hDBECsP9ozW7C/WvXuO9ilA6zLtU3w5BIyb7sRHP/3kq0ChpSZmEaSn4/8qv+8/Gi5rE6rJkQeFJtWn9N6n7Xwb2jSbWHdpeB4adiH2DNun9wnx8drRPJ6xO+ZkeqI3Y0NN8ytyTxbcNQCoqOUzgGJ7Oas+ckhN2nMekFVywHHwiePGKHKHUYxw5FjL3mN29VDk25xP7SUwOv/zUPBg40088ss+vngTsQMqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:34:11 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:34:11 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 14/17] target/ppc: Ignore FPSCR W/L fields on e500mc,
 e5500 and e6500
Date: Thu,  5 Nov 2026 01:33:17 +0800
Message-ID: <20261104173329.706635-15-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 076a16cd-589a-433c-a98e-08df3a99d6ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|3023799007|56012099006|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: smEsNQI6+Vee6BKyJbt3L4ZDRxtPNECK/QqJ7ge+DAPbJCSHZSZbS/ue8yCe9ktcZQf0te6sLNmDAiC+e9ggcHVmoaa1VwzLEtzfDe38N4a3g/8K+SEUAPtXFgtmFAtYu9aoWkBk9McSRA1RQGfSghDujnKFXUAuQ5MMd69Bj6kuzwY3FEKzsCs7syYZ/A2A+1qcBda57nFd6zr6dOJG+GXktzkwXoeDZ3RxdcUXBbY2KehsXv5dh0LpPksa8GjM3z+xXAoHvV0zz/5iyvpFlcID0KTJQ19p1xZeIiYLrMgbLFDAz6DJ72hO1ihkqn3U4VXQya7Hm36mHUXg8I+1E6Ioyf1FNkyObmdQyk8UP1PsnQwqj01+6kQ8t5XkDg7zYPLiKs9/JCzMwwCK0Ybi+P4Ix9nYJLaeCwPZ9UFitzNwzNRUFpSYhh2BgUcBXhhiMuN+3y6Bhdt+JvMxyZsonuchvEtoFopPI7Y47QQ5njggmwgtXzSt/4PVFwqCwO/c3xQH85RsnFCdfPU9lGuWIm6jXdNsQdA5GycRxb3GDI9xwjSesFVRnJp1QHlj/OuqGSoz7utSqFu7+ODy6buU2IbI+FSgHmG5LuFZd3g9/Z6aJQHl71VyX8FGmQJvQv5ah/1Pj8AGFrpeRGtkOIBvcvrAHqKL07LAjM9BlSwo5gI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9bqRqYisY7meqWzhm8lOCGlesVJ/WEmhlLALCPavLOyeL+RU2Bq/N17BGlAX?=
 =?us-ascii?Q?l3zH/U1EDcdREIiQU0Vet+U2Y2OiRUN36yzfroyEnPhCygYU5pTk0EPSfw6Q?=
 =?us-ascii?Q?tScNZd55vwtcVHCELRoejchzWqTA5nGm/nrENDJg94Vrjql+wMvQ9ZOX2Y47?=
 =?us-ascii?Q?YDXCFx1KcBs+aiTJjUAF8s8ioJYIKATN+6h9Q7OLMnOYBkLvPWcAfRdfi/VY?=
 =?us-ascii?Q?17UW65v9bTaHb62mxXHg1EU70BOg0Ug96ONogGkTvIaFDw07uMP9W2ffzoUe?=
 =?us-ascii?Q?qtinbkdcpJDBVzp1/0OemBHqO0/vBLmWnnsAIjMRAElQ3ZKD+MJ5e+c+7lbi?=
 =?us-ascii?Q?Czy7JhFG/7i0AilK76TTBOn/tSRCenxBEhVaQmI5JieXsI4WOae1EtIs62UA?=
 =?us-ascii?Q?tQ1hiiblBKSjt2WKiveuAY/XWyYlQnBeLCCHeAd1nNzmUADOrFROw1pDbV9p?=
 =?us-ascii?Q?7+wWgneaNuVC+BBlYOtuiXmhNWwjUAQCPkCwHXMO1yWkR5gi+gglnqS9XQH4?=
 =?us-ascii?Q?VWgTM65c95TtwAy3cDnXOgqsbEEeY8pK5772EDW2fBH+yUNUGclmUoHJ9M9G?=
 =?us-ascii?Q?hX2Xh34FVKI7pMCkqIofdfJXghPlR20lBBAu6w2Kn/nXdLhEDW5Bs5tFp92E?=
 =?us-ascii?Q?kClX4mfmy50R28ejNCiXFFrnERKOfPbsbMBC1rdpf/qDbf/2/WQ00RJF4Gyw?=
 =?us-ascii?Q?Ww57f/ha9RqMOO8houx0nkM9/wrDX9Ix24nf+sJfjjqFESI9uD364+yxLc3/?=
 =?us-ascii?Q?601gW1zgm7W3T6KnEZLwrbfobd0yRhVQ3KS1wxlfq+oR+GwyolpoPr3ZLool?=
 =?us-ascii?Q?wIcZxRuK/HHlz4bmGBjfpCWHTu0zgspLWCQmCqnXa8Q/AKg47yjLs62rosMu?=
 =?us-ascii?Q?uzxVcHPwpZWGggJwKXt+7LzW298G7z17+3tCVFG7H3DtRmP2B+4bOc5fKyUM?=
 =?us-ascii?Q?NaYn5lt8e8N2x4rVWhxbtMh/2mGuEyOkkHvBSxMcpnHQBLBRjTap4CHo0vk6?=
 =?us-ascii?Q?kNijRlhbCsUadG5EwyFcBoT6ux1Xh9toir9TsIDOskUUlBtnZcF9JNbeRROn?=
 =?us-ascii?Q?WviWmI9OoNj3NV9bnj6q0l7dcqn4h3sAo32he+AGpMLvGONZblcdbVS0rgty?=
 =?us-ascii?Q?S39gvMPE8gbKfHhPlpEKTrPi51o80x28tJYbyXTG0RG8t6bdQxEa6uYGlEXo?=
 =?us-ascii?Q?coJoPc1pWb3HUIRlncoFngImQa4A2sPptns40aESEYoAXE3kgZrsgIh/cqha?=
 =?us-ascii?Q?VCfUdtXf1SGTaIkAdNIXC6JojW4uV/wikdI/EXZ5+KRjMtSZgbwEr1cpcKeA?=
 =?us-ascii?Q?AuQp/lFk+Fpv56FsooLVDASFTi3VNbwf/WB0B96lT3EqyCYtESKj/fFpQPs5?=
 =?us-ascii?Q?4mq1NBPqoTGb4B21n0Yr4k/cYOO/9xPWLxOtcoT+iY0PTMFhepT3S1r3QVae?=
 =?us-ascii?Q?pwiNCRYBsHLPgW3kNDhBarD48l4L89Jlu8hdgvE2GBB2C/hWcOzOR0BYMaHx?=
 =?us-ascii?Q?+aKlMX3gV9KAq7znX47VMK6FXCPWySKGqx+ZgrtDyFT+NtmteNIdq8WbMs9d?=
 =?us-ascii?Q?crE6FmQaIcW55+ZzQdKiPyrSzU4Uomy8vHtCqAFE08L8vn6biWz4+BpcRY6y?=
 =?us-ascii?Q?deltbCMmWdQlnT+NHYVsxKDBx/mj4OkV+m47/cSehv64ZvWeqW5uARrzxeon?=
 =?us-ascii?Q?DkFvUetg0K9PtEjB6wej6AtQd3A/wJsetJZ4eH+RN7jkKgpaZjsdfvCTxZWJ?=
 =?us-ascii?Q?WOCB4KOTS7yYDIf+2eHpqUuAfeuuEl0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076a16cd-589a-433c-a98e-08df3a99d6ad
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:34:11.6893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzdHlZY5wkpPNK7k9jAm26ugHC0zr5nk31mpDbA1tbPl41TqdfUnhheYZ52lmdWzzzFhQF6NsLiWkqPadauhhJOOebhzL2un7YTPwk1yKxU=
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

Table 3-1 of the e500mc, e5500 and e6500 reference manuals specifies
that mtfsfi ignores W and mtfsf ignores W and L, behaving as if these
fields were zero. The existing translation rejects W=1 without
extended FPSCR support and honors L=1, which does not match these
cores.

Add a processor behavior flag to ignore these fields without
advertising extended FPSCR support. Keep the ordinary field mask
and rounding-mode updates effective.

Reference:
- E500MCRM (Rev.3), section 3.1.1
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 3.1.1
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 3.1.1
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

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



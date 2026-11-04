Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19936606EEAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=C7+harqk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOete-0004BI-W3; Wed, 04 Nov 2026 12:35:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesL-00037T-Dz; Wed, 04 Nov 2026 12:34:21 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesI-0006Dv-2i; Wed, 04 Nov 2026 12:34:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbCsL0WsyxIEsIzMGnPGROVbuyzO9tFJVgASFkhfFZUUd0LCNKaa7qAPdeslfnG634Y0ipF8l5gx59Q5l8riyw3qzog1g+Tj+7kuIzJRLZLF6DdHXYO8HHQlWWnRB/pjGpb3SKhUeKU5Au+XFZdywyyNpiITFQvm9Cl2sVCnpAqqFFTVKjGgi+OFpnR7zFFOg/ylMvi6eTW+8rAcvNbhPIs9N9qc58XMu74b6YCzbpgWHQGP0Q1ep608xkmnT2tlPDJz6GDcdXr8+WqRp4WYef4VzPXpMqSqe+v1THt8AbWSkit6ijgdLPWChYRU/EyAy3WVeb5bIOQhhQyLhKyp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYcH1Vcuvnvh8ZF2kxGpPDcD9usNmCdQruMzUOcFXcY=;
 b=uax2xsIVH15qZWGZGdLXVqD7mMJV1Rd2cfoKTXdkQ4c7HQh/j3U/3K45PpWx9wn+lWIV2hgoTF4eKnfhWdSSnSPhZWSGHVvMmIpzW5EN9kI72veBldlz/rmInxdY+YpvoXKbAdRoSzx/A6gWcQ3jgnQGS24l4X71lf1/ARurBySDvZ3yX7SUyg9Pc5e4l5kdgQoUb/x6+ljHF95wMMJJSCYFxhkzb1S3oM285dF67n2S8WANz0Gl9zF7fhHb0mAIdwkyBDthEUrfoO2K+Aye+ojWzHEd3lP/Bq0OELCzMUJHZqONJcxGJ9KMxu4R6O6RC/mPC1uM9X+wkT98UqLJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYcH1Vcuvnvh8ZF2kxGpPDcD9usNmCdQruMzUOcFXcY=;
 b=C7+harqkvWaCoqAKAIaFwY0ct/ybr94TVtQ5DQgpfLLmqUEj7iejOKucAmAUYtcYTt9G1sFT5ZI8ScdXVXxJs076FY7n2ZSWCM/LIqNvCGOHU9HRVVGPhV/uWwiNGUwnXBhIGoJHwmZpPoMCwmoLX3l891PBsya87E8YNS2oeDzuY6wjFLW4LLbHMwsXP5oZ8rSePXJz2XhTJAZPsMVB/e1JbVxP6fSXyy+2qBYi1TKBSi3ijayX/j7gC4zuU4r2iTxW2D392WMwEFf4h5S+pC4fQUQrDxDNxS+HJZzf44vvsKBJdDvxN5+QaQV4VuFnOcV+SDfebDFrCcW8lhkWtA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:34:00 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:34:00 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 08/17] target/ppc: Register L2CFG0 and L2CSR1 on e500mc and
 e5500
Date: Thu,  5 Nov 2026 01:33:11 +0800
Message-ID: <20261104173329.706635-9-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: d2afd393-569c-4d06-6fb6-08df3a99cffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: aiZY+TAnZW2K3XvuTVVKyAi34Ql63rxsie7u/rZfhTSshoS4oRHC8eFar0wt91rzK+R9xPSc3AuQ57JLbEq2ByPjXiQ77JIH7yDcUntU2biPjjHyudbnfGKehT6YylhYIFvGXLVg4rZp3pbwEJwUVsdvuIVQSW1UJqd5v4oRzO2RsoD3OiAa24ng9FTAZgPb92ByCsabRlC3j1bquzhNDiKlH+aIb9yA4u+AZDqkB0cd3tInbLWRzSGmoGjMp2CAnNXT4J/UaAkyXKV0hJPpxUs6WZ5y7Jg9MjCBvToS71K/rNETy2deDAa9TvUTRkIRQCdjrsM2EFH19BOZe8KdJHvnfNQyy/5bZ9b3KlFHpJCxgzKHoHgglV2vtL1gpgIjVLMvbVTTJlDdNxzrbrfVP4lCaTcdUsB41gtPj6y5Rez80HOAOwEPXtpXaP9OntKkH3dkFn/kv4Vo5N6x/3LUc26eSNtOKe3/4gnnLPhYzM4jUCpxFY4v57vpn6cg1V+nHZWUGeS3MJZ+REc1OC2r69jUjrfAFUjXeK7THHilBdICiiRu+IraOpl5VPn5jPpqEtwmtkq8xPBTQ40gJifHfJBh/B9gc55OKrdQBfndLxszqeVvVJmZUzkvyfG5nO1LBCGL7UKp0v8K4inA28NhsQE2NWjfkqEju7sI20Ky4jo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ehrAIefTGy5FYlqcu8n9atJOxsPzB2LANSPbSpwibHdt9WXQLv2e6saIL57r?=
 =?us-ascii?Q?SghScI9gL/tCEQm0RSPkh8fpBVdYc0BZTeusZv2SLxsk2sGjk4wpm8wuVLTh?=
 =?us-ascii?Q?YP5JRo1IrSkVOLlibQL+S3dW04uYpGzynjrmrW00zS/QIict1mz8KZGlgber?=
 =?us-ascii?Q?xnSAkhycIsCx0JfcWYvBEobTwcmIZGWgfZC5WOL3pCGUz4jFks9Mk2Fj5WwI?=
 =?us-ascii?Q?7wNFjIO7qLA1KGgM7+LRA/nLpDyhnNzBchUyawwG5M1A4rJHoTniRkvRQ7pt?=
 =?us-ascii?Q?/rRBP0BR6f2d7Ff+bK7Wphyw2R/ffeIlw85PJJtYcr4YmFiMwO6wZI3L+ebT?=
 =?us-ascii?Q?hHFW9w0Ewh/SJY/4q3PaYhaLdRYqkNOGHxpzbrZPMsvp3EnYKPGHxbjH3Jez?=
 =?us-ascii?Q?/LLTFcbb1cmgfOEl8QLwKtrvYkl3Ku1Dl7GtsCHRyj1lWj6VlAQNNEeCKCaQ?=
 =?us-ascii?Q?VlDYU77G8VtUo//f7tDaB/LFlvWy12BxTr63lNrr9v5tafWcNYgInaeIUyWt?=
 =?us-ascii?Q?bnaiKAAkNqiHmLgnkh3JjglJpehaGmdH0yFAT//zg3s2l+n9xwWXtyWFbAyR?=
 =?us-ascii?Q?zULqkjUCHjKfamYr5wteFfR54uQ37S6w9/zsJoyVX+STyvnCGm1txbXBg9Cj?=
 =?us-ascii?Q?8j1rFRsDC16m/YHxebi4eZTzGQSmlMpJ0vmww6P5VeMAGADB0kkwss4xkPO2?=
 =?us-ascii?Q?V2DYQnGwvOsVI1osIkCU7tnOwhtMqR2g5Zp/Bwk//votUExpnTEdaSsxNwPk?=
 =?us-ascii?Q?vmvW6RLY5HCGS6H60jrVHHKDaAb5Yut1Ht79HcQNvcvW/rL9SvPj20orZRVX?=
 =?us-ascii?Q?tz73ezVKiE3MOh7RBkOKSYmfgHOHUnHG6E1AjmTVvResOFUZs/CrOo4AifGa?=
 =?us-ascii?Q?PQGfWXvkaBKIGJmSw5i6F6Sz5DhovCci2mSCGHdj5ogQr7GBhZbNJ7aDw2dK?=
 =?us-ascii?Q?THJy9Wm11PHUmEthNMbKrCKbkIqiTtd/JWKISJbS3+OBX6p3YdoYFW6EcdUo?=
 =?us-ascii?Q?JUHky3n/TE/AyZmZYYvgErrEODQIYUD/M/wqGFxHTWSz1xux2ueFCd5/tYh8?=
 =?us-ascii?Q?HuATW/S4lBkei0lphLYMv0fjRPXvXOHtnaWoqznk8NADRSrQk7eHkKo9Ywy0?=
 =?us-ascii?Q?B8zP9QnSYsY0/32yw4B7fy/KkHHc9N/ePDUKICh7gf1g3L00ZQPavp6gRMge?=
 =?us-ascii?Q?tYsijBEzsp04sQemiKFXElYrzmBu4MuLNaTM6cpqYeAgoe/yLCqrxwM0Bvof?=
 =?us-ascii?Q?zcEIiOikRdz9IfeZm5HTgSLG577aFDTYpcOnn0HltNc96ZI1DzgBoa8hQgLm?=
 =?us-ascii?Q?3jakj6wm6nxf3bYIXki0l6RPLQxUxLTHoyVY8c1Y0NXNDFNAytl2FdDx3Tic?=
 =?us-ascii?Q?U92IRFA7BqTvEjKgF1Qpy7KTo+ciVEQyFdTO+m8+nfYDdG9j5DDYz7IrERzV?=
 =?us-ascii?Q?1UznRqj4dJbVqx5nS/1/Qb42Ct3fPerMgtfjWBKZzHdQ8LzfXvXAe5qe5k+/?=
 =?us-ascii?Q?FUgF3Ta2IKEqMk8WyM9X8rpZ3btaT/i8O0qorcjMVl7gxPBEoMp6vT5k6Wd0?=
 =?us-ascii?Q?LKElHGoNmsG1MeADLMXNAAcfCqXOyl//EHHxfbHn3fmQ9c/CfWig75Mnm1Rn?=
 =?us-ascii?Q?xOOPKjyBErHuKr4cXdfvwHHEF2xp9giaaeoXDXG62mcpNayYv//i8tHH7pBm?=
 =?us-ascii?Q?fPewg1diDwsgJ91vWjCooSDss3hwoFkqdCTiaZt2vEmeO1oj8Pr9aX+ni1bR?=
 =?us-ascii?Q?68HEAv9Z5oBICbV2SxhLHO9wBP3tScI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2afd393-569c-4d06-6fb6-08df3a99cffb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:34:00.4391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV4v60K2VOb1PX9e2ggpx/fryP+WCH8uePLmLXcXRBgh+eE411tzs4rEraTy/txVGCavKbYGKF4BKjDDBFDSb5BkYO+5Dz/ZKyCMUWq+DWo=
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

The e500mc and e5500 core manuals define L2CFG0 as read-only SPR 519
(0x207) and L2CSR1 as writable SPR 1018 (0x3fa). U-Boot reads the
former to discover the private L2 cache and programs the latter to
select its stash ID. Missing registrations leave cache discovery
and stash setup incomplete.

Expose both registers on e500mc and e5500. Use the 128 KiB L2 geometry
specified by the e500mc manual and a 256 KiB default for e5500,
matching T1040/T1024. Other SoC integrations can override the capacity.

Note the e6500 shared L2 uses memory-mapped registers, hence we do not
add these SPRs to that core.

Reference:
- E500MCRM (Rev.3), section 2.15.1 and 2.15.3
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.15.1 and 2.15.3
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.12.1 and 2.12.3
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 target/ppc/cpu.h      |  2 ++
 target/ppc/cpu_init.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0dea3a9d2b..3d76b8a082 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1978,6 +1978,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_Exxx_L1CFG0       (0x203)
 #define SPR_Exxx_L1CFG1       (0x204)
 #define SPR_Exxx_NPIDR        (0x205)
+#define SPR_Exxx_L2CFG0       (0x207)
 #define SPR_ATBL              (0x20E)
 #define SPR_ATBU              (0x20F)
 #define SPR_IBAT0U            (0x210)
@@ -2343,6 +2344,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_750_TDCH          (0x3FA)
 #define SPR_IABR2             (0x3FA)
 #define SPR_40x_DCCR          (0x3FA)
+#define SPR_Exxx_L2CSR1       (0x3FA)
 #define SPR_ICTC              (0x3FB)
 #define SPR_40x_ICCR          (0x3FB)
 #define SPR_THRM1             (0x3FC)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5db9ea8b70..bf535d3081 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2974,6 +2974,20 @@ static void init_proc_e500(CPUPPCState *env, int version)
                      &spr_read_generic, &spr_write_e500_l2csr0,
                      0x00000000);
     }
+    if (version == fsl_e500mc || version == fsl_e5500) {
+        /*
+         * L2CSIZE is in 64 KiB units. Use 128 KiB for e500mc and a
+         * 256 KiB default for e5500, matching the T1040/T1024 SoCs.
+         * Other SoC models can override the e5500 capacity.
+         */
+        spr_register(env, SPR_Exxx_L2CFG0, "L2CFG0",
+                     &spr_read_generic, SPR_NOACCESS,
+                     &spr_read_generic, SPR_NOACCESS,
+                     version == fsl_e500mc ? 0x3cb1c002 : 0x3cb1c004);
+        spr_register(env, SPR_Exxx_L2CSR1, "L2CSR1",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
+    }
     spr_register(env, SPR_BOOKE_MCSRR0, "MCSRR0",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
-- 
2.53.0



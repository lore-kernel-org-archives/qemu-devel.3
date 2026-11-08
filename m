Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B8606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=aEJP8GY1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1b8-00078k-2D; Sun, 08 Nov 2026 07:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aa-0006mO-SI; Sun, 08 Nov 2026 07:01:41 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aY-0000V3-VZ; Sun, 08 Nov 2026 07:01:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gClyzdnPio4lO7tWzlzNBhA6xw+BXGEvuMraiH4ov0p9QAW+nDNJ/Fg6daTn7clKCrk+YJBEmcjkGCz0QUs55M3TpEZcoa/EJH++aJ8qX9rIiL+Kq/YRYx9DRChhFuykCldKbzPVe75Bd1+K+dnPdiTiw8W+0FZoBypO3obcywmzApoSlBF2t7kLU61NOCRdRFl9jZ28IYe7IVe/EZz154cKFhv8a/Hx8syjLi07+Le6J+k6S6hJReGUKEU745q7uMs3KrugOA8EH6dJ/WX/ODBLZSfQniPB2uq+mJuwnPAkYziFrpKFJyHNR1IMlXyY//YOdSPcme3sfTzEUFxpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I6fdiQoSncpc6iP0SAxcIWssG4xN+I30mQaowm2W2k=;
 b=Rrit6US/qhpQqy1MF2nb+zYsTQOk4sOJFq7wvKgn6T4yDpzjitUKPt8arQ53iw9CcdqJmLenY+gp55VK2sOLCkKtn2IoLArKnhlqzJvPP/fUXICPRpp8N+tST6Wg5CALgRNAA1lHlD9QTzc26YG4cecMc3gWpCuhyksphOh8gv+nhvM1ewgJf0oBAdfNrQHDPICLr8klK4CezxmCEe3erimah+GyDUGDD7chTXmVXQp2VR6xeVXj212r3iABxOo0vhw4o97o6efiUQl86MNmI4Nl16eV37n24g0dvYXJD3dtb/e+3oy6QKIg4MpEztlZx64vMoEJwXmG6burZryz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I6fdiQoSncpc6iP0SAxcIWssG4xN+I30mQaowm2W2k=;
 b=aEJP8GY1UoZ+DwcEWEryE+U9vqUEudZzNUZ6TLsS7KRN2qExsKplovuwzQjo1opL/OMpLZuIbdPIaviMoYUiVxmazMONY6yjTo2c5rMDHaYiRXFR1MCrOqFVEYQOOxlfF64WUn0FnpMocLnwc5FiQcQ71myXeb/TGtBG0IejqO4ds0iGHWnrgK7WUTyd4lh2EZhmSgk6M8S9rYqC+odiH4dUIu5+gIjMPjQmHpfmvef13KxtrN+OHibYDc0sTJrLZm49M4tfj///QAvsnyRD7/J90o5PEPGbR+3RW9cxxFZHkNZmb/t/kNE18dcys62e0U1lF3Yr0R3FIkeQACSbFA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:23 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:23 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 11/23] target/ppc: Register IVOR42 on e6500
Date: Sun,  8 Nov 2026 20:00:10 +0800
Message-ID: <20261108120034.1755008-12-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2a3405bf-80cb-4a04-8e05-08df3d9001fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|10067099003|261102123227099003|261022075727099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: cg384FRtGa126ksSgxVc+LoDu57W8htgIyVKrXercIUu/ftK/hI8L0OLHV2NRlsR7AHWbl1HvtAXWd7sj9Em4k09ms8bSCAImOYfxGLRE7p3FWy5ujK6rDu+O43hpXloJR7opcp4Yhr4aRznDKGWoBK3MwaZcxwaAFzYkZ0PKhwn3o09RmTHbe/UM45MHrQP/uTyOn4zT7AMbp3OxjU+EhbFdPy8J+2C2NUGg4r06xsxKyoGsYrwpp8Z2XXMyVfA4xfdaT3NpJ7v3pEAQ/2rOYuRWqS8dzAdkNJROzYfpnc9CFI/J3AyUiJPUVVKiKGSP+gM3YKtB4XuPbY+6qdaz6qyES3H1cR28gjYXOMMSs7o8GZovb3oXeSpJ6wldToMYJTTcY7/t0Kjsiis9vSBoG+clB9hDSrGK477vzy8dtcSD8YAanSRvKnLKSNFFzeYS25oHKcSFI9jkwEDvGyiszeft2B1GxPacxzxaE0msGt4RL015ImUplVYk9SfBitcyHqjizyiTsRRfpbl9+1JS55MLq2+JIoH6drs/gr0THylpOKVzrnEmBgWPAeippGnBEBdWv7oIV2l8SKbjUVxD+1qXj0p8RUToI1+xBcZeHlMw/krjvHEWw6Q3vSmx7ga20IHftTTkza9eYb5iH/acUtieVzn/mORGIYc7bxPZ0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(261102123227099003)(261022075727099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7g0HuGTEPtvLybqJ+FlTNdOkSVxuo/p4mGLbIFPAT+qn1R4k2LmGgWDQsTEg?=
 =?us-ascii?Q?2rQzTG2DEhH16NJSdaIZGl1CariPgabTxzp+evH7MGX4rk7g3mFVCGxjYJvF?=
 =?us-ascii?Q?TX8Eb36sl/F6tygerSBMjrnchrnhIwQ2d1Xne/jtT1VgrPsyLyv6dxVXZRPw?=
 =?us-ascii?Q?LT4puCDIsThtdChXskzJWFjzLEZH7Lr1GpfPxjwQZBLm3VPIALHufQODACYV?=
 =?us-ascii?Q?fSHYjIJ680RejGi5qQdOxkw7A8fakCg2jeqU/NUhYONal3WlIyn1dUUcLzPT?=
 =?us-ascii?Q?MCo11RdcSKYJ6PExdRG39irMCkIkIB9si+iQUI+pTAbJxhyb4IuFarROv+w6?=
 =?us-ascii?Q?dH26lVNdBKPO9YU0VHf3ucEM2vI9GHtVx3y/37GXiKp33TvjRpoUsr9NrmcN?=
 =?us-ascii?Q?MNxaKb/M0kuMREsiljasSCdkNJYGLbSDdO281XIRjWIPHd1cxA006PyhtfBl?=
 =?us-ascii?Q?QzN2GkwxAo4w9cNJvaurUx3LyBY4B6j/+99y7q0GmQfddEcLTesua8ZvFeT+?=
 =?us-ascii?Q?Kv/ZSHCIQtzK1Wexbcs3BF5HRFWLp9EIjmtYHs2Ycpf9dBOpuW3yP6T++9Fr?=
 =?us-ascii?Q?Rs8dYJie8TKCr8LIRLV/2fUftPWCKiIorOuTCfFiu6ht6fOfGGeeB0KIaqmQ?=
 =?us-ascii?Q?YlTxKdiigZn9iRaU7toK1ciHppx1YIIzJBAAzzczyPUkQffZz3aUVi2j1Kao?=
 =?us-ascii?Q?K8ECBixlPZhC3B/e+pbDnYtKh2TMOo8hePQLOMPmtHhU+EP+qZrJzaR1bAGn?=
 =?us-ascii?Q?Su3tMVPVKx7mOmWtDjkz+5nc19NVJXxT7jTBhJbKMjHe5w6DXA1Rhlc96Up0?=
 =?us-ascii?Q?a86UZUBo+9dOQF28DhXgqcSNHzxTua8QZyS5nK+229Pq7eRQuvCPQlswdmqN?=
 =?us-ascii?Q?7nsmzjXOx7cYzhmVycg81ymzTs/hlhJ/sGWneCC+qF/MVT5/ZSp6iufExLTU?=
 =?us-ascii?Q?B5Ep86BrSCRl3BiDgtblZFhgLko9UJ0lwLvg4aPtNfxJD34B4GKMZ7KkIPnC?=
 =?us-ascii?Q?3N+tBYXStbtJ2rxSuHhBtH/dUkbnsjnHZP5ArPfP6POwiG0lHptbMFSE745p?=
 =?us-ascii?Q?8eZPxHeOyglTAtb5DgaudkL/YQ3593IjYZashN/cL+bFVWDx/DDDTpGkUKr0?=
 =?us-ascii?Q?gmfku1KjpRAXfu3nPNHfJ/n27PPUYvMIwyWlJpLVdwSHtOd5qaSafV+QhWal?=
 =?us-ascii?Q?fGtXho2k07qrdcgutMhW171IymncdTy82pIcroDGqO1m3R+27ssJmKwlLmPO?=
 =?us-ascii?Q?uYXwvV4nAO3TBeL2DdqVToLQ/TkXskvMC1FKvl0PHWF7feyvFyCz7RdtZK3H?=
 =?us-ascii?Q?pYjfHG9YLUKhD/J+TosFjh2mB/hup2rXVR/vSGOBBIqWLs3Gw198x81dAoI9?=
 =?us-ascii?Q?jyk+D9sybk4vjufKP0TTx7iADMf8kZELIs09MZWFQ7BWAfvhohUwX1Sr5aq5?=
 =?us-ascii?Q?iytpWoQuy3C8hqZtYj8LTgKdVe+EAYBrpOFBIGINuowCdPdxjGF3myNl2SYV?=
 =?us-ascii?Q?XtfaJloCWTv+sqhz22wGEIiJyk37rhkSh1Xegog92a7vMxygvKpktx/GauV8?=
 =?us-ascii?Q?+O07lSQAbPNKNb06y1HyCC3Ni1v/SlgzHVM8ypF0dUZ63X//h4+GqhENV0Hd?=
 =?us-ascii?Q?poRNwIzFAw9p2VOqitlL/a3+5f29UeTGBRTftP8inPdruVFf/6s+gERwW5hG?=
 =?us-ascii?Q?8Z/XrMMGIulxw7E0gyN66tlSs3pY+7DTwatSv9LEGE6IdeuVY/njp3oj+6Hf?=
 =?us-ascii?Q?5Ofn/LU7JIST7i8uHSI8MNDwDHAqMZ0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3405bf-80cb-4a04-8e05-08df3d9001fe
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:22.9663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXYLhfrghkRKkfAtt//mp1t4MGR+y4OrNu0aB3WOojn0V30rK8fevC1kifpiH5oV02TN8yKJZq+o5mW3nP0O6ji2d8AYtGZ5jQsrzJK38pE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR02MB9138
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

The e6500 core manual defines IVOR42 as the LRAT error interrupt
offset register. U-Boot programs it during interrupt setup, but
currently the QEMU e6500 IVOR mask excludes bit 42.

Include IVOR42 in the mask so the existing BookE SPR registration
exposes its offset. This permits the register accesses without
implementing LRAT translation or LRAT exception delivery.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference: E6500RM (Rev.0), section 2.9.5 and 4.9.22
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Changes in v3:
- Drop the redudent 'currently' in the commit message

 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index cc702d7c7d..224e1ff77b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2824,7 +2824,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
         ivor_mask = 0x000003FE0000FFFFULL;
         break;
     case fsl_e6500:
-        ivor_mask = 0x000003FF0000FFFFULL;
+        ivor_mask = 0x000007FF0000FFFFULL;
         break;
     }
     register_BookE_sprs(env, ivor_mask);
-- 
2.53.0



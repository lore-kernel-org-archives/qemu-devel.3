Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CB606A322
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=KNxB/fMD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1af-0006jL-Vn; Sun, 08 Nov 2026 07:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aM-0006gK-Tr; Sun, 08 Nov 2026 07:01:22 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aK-0000V3-90; Sun, 08 Nov 2026 07:01:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2yv2aNdvvR650/XrmZaRs5yupj29mG4OZFcacU+bgYrog7USMDK8ZavOGlRPf96ljE5bXg9yfFycI/C45og181P773eogEtbXqRGlBYYTFN9yN3eLTuaeSnMyRqJeTdmnjHuRA3Rix30145OAEMb8OOMHhFNw+k/MsoBIlbwhh3+iReC+uzLcuNVlPRbjN6y6HY3S+WC2VYNIkB4cSs05nNfg17M4xBMak9XWZ3BvgxAZNg0Uubg+uG4l20uEGGpl+ITBgWeATy3jh3k0xsqknXDIGDYaWQDJvY0sxqdQFhwfbKkXnzSmgEAyVlXm0sxet7qzVJtqTI4drSleGCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDH4JuF44VeArTktI5gke37ZGBJD/hHycOTXcbJGEbI=;
 b=vkWK5feDjbbwa9ZeGJTvnVVkLS4ZS2UcA4IZZUsn6mrUtK8+OqHlab/w7uQK4r/wOYAIEUTZvoquO7wo3o3CMJA3fsYwBUvs0gn5dhHxx7gUwVX4PthEsPwQojZXPCGseGGt26Jtt0hnyQVP9kd8S5/52wg+72hLapCadl4ijkZknkwBGnJojFNt4+s9CtWrKJCD6Q56bo1Uo5fK1pI4g8eBeAGOowUeEa1MuG4YCKNCvfGvXosWp2M4YDAGgrWm/UCCMe8WUbL9n907ViOXP1ykpuJGYu7ESlkru5QY6MbuuHdM47ytYKao6lLx3DEmTuq8AIxeNopGeaoMdLVebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDH4JuF44VeArTktI5gke37ZGBJD/hHycOTXcbJGEbI=;
 b=KNxB/fMDpO4oOpB3A4FhgNnY26OkRtESgeyO0r4Sp0fYhlz0wZOvn588XcKWGG5aApEcyoxu5NlwHNyDCx4LxYUEQEKxl2NeGieWt3fi96FJJIhSO7olSp8xuWzJSYnNYBzvLSVvMtUUraW/Ib8HwhqRb13JRH6hPsjhaLzfC/zphMewxSBe+2xtzCU4bR4+HgjKIdvN/hhQuxDXzCkE/6AbjQWID9uyKh7KYDrhsZmvEYZjRQQ6K9YzdZ58EXQN6EtTA92yA5B7SL9luaBBAIhHPUIjFSH5okWTwXgS/C4+t64PPB7mO/1Ll9/kAjvw0yv/NewexJfDTvRHVCjXHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:09 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:09 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 06/23] target/ppc: Drop redundant e6500 L1 cache geometry
 bits
Date: Sun,  8 Nov 2026 20:00:05 +0800
Message-ID: <20261108120034.1755008-7-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 738d3e01-fece-486f-ae37-08df3d8ff9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|261102123227099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: /xBLhlQprZ3Wbou//iSpM2b//fAEENeSkK14jeNQgsCPn84xsfCtJ6iAre23UiYEZj5BKEg43B3SSEub+kWb5f/nH7A+MxZkIcUnDmRA1z+Ms3xVOa1hAkNDoj+hTFNRDrry/IJ8269FlZbzKbjM+2cpUN4R5khJADI8uambgLZ/dD/7mdyOajvXeIivjR4G0F9YwLkn6tmaUEoMAdAcU1n2ZNH3IQHuJtAVBZ0yCnDXDojoxeY9KK7Cs3hBuGdFlflTbAb0fiq79jJj4hZo5+CDiM8ylHyZJHB2Mx72WfFFLj+W0IB6vrwJsxFgIMmZisWcFIAjGfanBnaq5buGAQNS8UQfpyUJ74HejAnQgbGwfRdxC93nuac12Jn1+XcwOmyfs+BQpMYgEYf6pCmy428878Mgo83ur670UPjw0YcjTIKycof+AyGYK0V4tsmAimHtm05eBzH29du+6Mu2gFDW9Jrl+Vz2vM1g2k2G+pgvOzFywcaDzXLj4Is+nrxQV49Wdsb840YiLTlNDJpcWts5SDHluovotxXWHF2+pbRYVR8EBxzq6Sd5FRaLHP2e9E+pc7fAph0hJGMCwSGlQbEw/xWTyCDvXaJiEqLmxG0nQuOo9VBCWVoUzOH/EltSLFIAvW5ymYuR67+u0KnAm2wzXYIahJdiEcMyvmUixw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(261102123227099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t7gc9pwKbu2vCIgnArh1UKpx0k60pokuZiNyJhHbo9KDC4WcBRwHOZ/CoKK/?=
 =?us-ascii?Q?GvHC1huIIb+az0gwc9IdwHllhkhfhtPlN5ucyiLZs4TSAR9aIfC2YsmbnAwQ?=
 =?us-ascii?Q?n6AxGO9biSvU7HPN6AjZ+WCOaPJENDCsDNtIf9DP8yI7sxrJRnlrKKDnUdJ4?=
 =?us-ascii?Q?GAaT00D76iocY+5e8+wdJT1F/T6ya4MPTSVffC2BAb71GfixjY0XZUBxFpw6?=
 =?us-ascii?Q?f9rrCrmadpDFdRamTkPPK7MSUoJYD+J15Q/d19QQNWBd3dBp9h1Kta/dlY1b?=
 =?us-ascii?Q?cd7Lf3fb5rK+7q9xcyqPpijNJJLZKdLzYUskgBvBEzbrQBJbxsAdaA3NXjH0?=
 =?us-ascii?Q?WIIaelhoJp55JA8yw5lkxAPdi7xEAZToWf308krHYQzvSpLlzPb8Ci4YdQoY?=
 =?us-ascii?Q?JDtx2shA623gpvv8hPzL//8uWQODqhykK4eNlnZ5Akwt81af8r7Z5/Q0kOpB?=
 =?us-ascii?Q?s0uDil9bp911xruBP2gvkOnSZfg5NPPiwoM7x2lWyVYnNmlBXeWTGDp6RX16?=
 =?us-ascii?Q?EQmY/ir6MuNDcDUM1zx/0eZ8rrU/V/MUTHIImrL2k6rp0BhpsRArbF+vB2Zo?=
 =?us-ascii?Q?8T6EgU+qq1Rpqx2AlTpqIieCEhZHaDAyACOfugQ0slsWjZIFzxgRaf+Xb//h?=
 =?us-ascii?Q?YlArhH7ShxcUEXyiG4kvFYyPb+nBMBTHnYL12GlBTJjuXD+yV5PWCChkW5mc?=
 =?us-ascii?Q?1GvReq0Y+5YFx+I4PoJv9GkqmIuxQ7VKC9lsdcJFgTn7Ujt1up2U2ralFtFt?=
 =?us-ascii?Q?6b/ObsVL2R/qWkuYI1yXlwF3+OpaGAuWok29coEKrAXkH/D1nEZjW0XLA1em?=
 =?us-ascii?Q?eIqIPniIIgmToJQyxOwP+uT/V/8cTE7t2VrwnsIjbboAEbNUzuzUwMP1sIr0?=
 =?us-ascii?Q?qSUK7GDL370EwSdxx9rbHNi+p7qGFO0QT7Ylj/Wvpam3hL0jVKNTVxqwn/9u?=
 =?us-ascii?Q?sHsuxuoP0p0pki1/9ZoeVfi+dmjMUFJBE+H3v3HOy4teKFD/6t6TQIq4CEig?=
 =?us-ascii?Q?719appYMW6NOeyeToYke0OxNif2WFQislPoTbMhROwTYw22nAHGObkrmXER5?=
 =?us-ascii?Q?Tk0LC1umD7D4i+4Ck92H8JFZ/gnf9lqfAsvYojkVglkUubh0yn+dVTuQt4Ea?=
 =?us-ascii?Q?N9QXggVu1pEbhP5/2FKLEhtZfeB7/vswjYA9w3VVBqPGMfeDZYAHtwQE15HR?=
 =?us-ascii?Q?X0UdxZM+RFg/OHa8RMUnmOP9u4AF2jTc5ZWP0ZufTlrWe7XmDyPESMOx1cta?=
 =?us-ascii?Q?ivrbiWg8Y43pGixN1hNGMbfofJfhUyVGMjCeqIEd+jTD3bAhfrEsO9CxkijC?=
 =?us-ascii?Q?8VBPxNDWSwDOvm3xiNsPgA+lq+ujwmwE1RsPc7C4DysQ/aRTs7i1XHAM8v8l?=
 =?us-ascii?Q?D93HUQ4q47npkCsu5cUtDQrTx0wzU7yYRAA1U07g34DHanBicJKHRNHUFeRK?=
 =?us-ascii?Q?6/zGYG108M70LyN9NlaaT2PaqHT9KtUz7eCIjfwW9UH2wtgn9Hcs2xhpwKF+?=
 =?us-ascii?Q?wFzgLmtdQhfW3vxeImnrgI/kzJ3OWQ3IaQ2zd55JpyOuPGSVZpL8gZWI7x6+?=
 =?us-ascii?Q?+Es5GyG7KapTjD51S7zktFXHhR4aP88xZ7aJTSiLh3zSSF6gRKW9kCk8FOdc?=
 =?us-ascii?Q?/0lrUPphr2J7T1kzURfVWedfPIteSVa+/qayEeYU2KJS733B6opop2FuznQn?=
 =?us-ascii?Q?fgCN1WDVP8Tb+wYPXCtrA68m4tjoewyra463MT+5MJzUs0q4rxqpo6qzY/qJ?=
 =?us-ascii?Q?DFG02zgllo4V9aa/1qfoD2MH3E38N0I=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738d3e01-fece-486f-ae37-08df3d8ff9e9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:09.4586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBoKDX0bSdFZnsnng2cLuNaLlwKGCVTvh2Xf/gAoEdOiV4hSmoVPMz2VvpKpAFeB9lJqMk201bsI2ZPchX5TL0C9/j6OI/qAs2wVA9CQNCo=
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

The shared L1CFG0 and L1CFG1 initializers already set 0x3820 for
eight ways and 32 KiB. The e6500 masks repeat those same bits.
Keep only the e6500-specific upper fields in the masks.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference: E6500RM (Rev.0), section 2.11.4 and 2.11.5
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

(no changes since v1)

 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index e2182720a3..7a569970bc 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2893,8 +2893,8 @@ static void init_proc_e500(CPUPPCState *env, int version)
     case fsl_e6500:
         env->dcache_line_size = 64;
         env->icache_line_size = 64;
-        l1cfg0 |= 0x0F83820;
-        l1cfg1 |= 0x0B83820;
+        l1cfg0 |= 0x00F80000;
+        l1cfg1 |= 0x00B80000;
         break;
     default:
         cpu_abort(env_cpu(env), "Unknown CPU: " TARGET_FMT_lx "\n",
-- 
2.53.0



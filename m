Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5A606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=OktGwjpE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1bq-0007MX-2m; Sun, 08 Nov 2026 07:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1ae-0006mb-Rr; Sun, 08 Nov 2026 07:01:41 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1ac-0000V3-SN; Sun, 08 Nov 2026 07:01:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2IqP/qtDuAla39CGUBNz/Bv/0z9HLfGjgLdVBExtMtoNDJA/kEDWlAn3a+7TU7XdDc8h3XwVhIrVQFfXLTBcp++LKUnCiHXqW/63G8TBHAEKGwxz+hR1PYhv/ruk6pcVyJx6JhoNNb6l0hhR5z7pZzu9l6b1cd29g2HQcAergQJyYKP7Pj67VTq7hoWH98nYgPIoqahvb+s2vh9XovMu150Tdz4kplfi9OOMiNjMqe359PJfee3lCpYDzjgI9jTL5Trf6IToegY2L6jYiFYcshv+i+8qBjwO5nAaznvmFl4Z8CTX67QsLqhXNMyYPn+4DlFEEmwbZiHg3pQdGlJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDqpxtGvRNRldDwB0mw8zFO5BbVYvoxKviVJABSBIvM=;
 b=qrGIH/6Uosd5BZxl5M7uvc9O80zPyA155LAwZlna5I8hmzxCoj+V7g6+AhtdRujMDFGjQK6tt1/BviP5kBnF/gA8/PuU68VPfPVy2pvpDok7yB1nLzbhQTDleQJN1MeVuBXrK3pXx/ueGUz1CzC/DmenO3qjvolg4+UlpYVzlZkucd9Ufgw7tZ+WaXI1UtVCFGRzSe0qVxQkgWTp+gUzJX+RUUq+tC1jnnDObXUq+7aVeIog+gLUfdmX+cuIvY0zlMj4JLrkokdk7ON9XiDXcr+CxwhtDanagBlbqSAkVSUb6XLpm3K9CqE9wfkyT1apC+YBkEnEeQwqN3HZ1S0Fpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDqpxtGvRNRldDwB0mw8zFO5BbVYvoxKviVJABSBIvM=;
 b=OktGwjpEGFeAhvkka8L9ZE9gh8hB5hSuzmXtFoGIeGwleISv4UJ90JpCzF1opgZkN9f1bZpPE0ELn3QPhy+XAhgMAC8YbBtjDIr7rkeYhJXsabCGvwOGPJXkUVd88wRt0oQOsxuYE6q7Uhnmm52wkYfJxhJGbvFpdeTZK/saVLBJSoJ2RNMr/uhA/GtqM3mrPqvhbbrhGf1x+DCVhEN72mnf1xpq7K/vWCze2XuJ4FV7UUtTIE3ZIRpXV2XThVOopYD+jsGr6KN+ab2EroH66Smfo66Li96/NIf1es6ms4PTaUfL/qAetYYS8clmLYtfpcJjRohV4Z3KD5kHvvu0dQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by KUZPR02MB9138.apcprd02.prod.outlook.com (2603:1096:d10:61::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:28 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:28 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 13/23] target/ppc: Enable byte comparison and parity on
 e5500 and e6500
Date: Sun,  8 Nov 2026 20:00:12 +0800
Message-ID: <20261108120034.1755008-14-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: d2b830f8-68ac-4a5c-4a73-08df3d900539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|10067099003|3023799007|261028144727099003|261102123227099003|261022105027099003|261022075727099003|56012099006|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ugcgNEk6rFpIK7PMWk8kygeTuZRiECTEInh/PBrEyR1oaVuLaYls+v4PY3y2z9Gh7NQm/PdQcAyrpZKz68LNE/QyfYde3swqq/vayBUnNU3QCvoIQ+0AGus3L3pHmYYil/H5ZXNV7SmFjvup5mc0oNkNueHxJKl+GPG6+U1QM4zRbS/kKN/ecDQPrU7l9tB8glfxoLmWZtGoVePjwCMNiWPXMpxh34gBydqmkRUWypHeyy8XD5Tj/45coBjU6HC4iVz0jS27/l3senl74/Z1VV5UexunFpe3AXwcm9OF1XUw63edRkyt1VAAx3a0lSCjvVOsHFQ1vQxGeubHzDa9+pwy5jrGuh50743nEIqXAAlLv9LjzdK8TAEei2QMgMr2O7GMabnsUPjj1IMSFs5v3a7XHGi9MxzQhGxP24aOagaegyrAZxYXGd54c/msC+RZPDlMcLpSCa/vbcuSWSz6ic+e/Pd+sTHak3O0ozi4/UZ9MsSz90Kl2d4UpTXqLk1JkLkk+hM/L2prlIVtCWuB0eqnutAocOFpQm1Fo0sVVVpzQkNji1Ck+4fjSIKZIaPy8Ct5Zs/vU0IHYkMrM9aqY+dtrFoqfaqxXyEKyJm1K1UoTEwp+OVpBhsnVEPB8ZMiQl2ARFQ/QLLOw3F8yBML15fBB3OfiG3GNxO/y8PYMGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qEGK9g4cvi3pzspCbwYCa3vo5i+zL4v/uspDxTAXGw7Lb+wp5/E1RLCeIl/5?=
 =?us-ascii?Q?3MmTx8RJLRHsRYH/JxTtpkoztjtq2oq7kBmShxt1oNyBIN9bFx5eGkqF3W8j?=
 =?us-ascii?Q?Fmr3Es1AXNgQ9fjoWDM4GLvqmioJ3LPsg8XykAfB0o/RRIYw5G5AAqf9JTGR?=
 =?us-ascii?Q?jzVvmKWj3txUOQfA3Z/iQTrJqAu2zqwdPgv8j1c8VMwJv/fNXtkRM+jozyV8?=
 =?us-ascii?Q?gPnYks2AZW/eN/0DNUtX9CMNO7FmuRDqf9wfhm9ao4Ukh4dOFpBvDXYxm+Zl?=
 =?us-ascii?Q?1U/hNtW6maUd5CkCf4cMan/iaDw6I+SvED5b7/ZQNet7fYZh9Wkka7BreJhT?=
 =?us-ascii?Q?/ote35uVqVbOwUZsDQ+PXnIPrR5/nVmaUzMyMbHORjzlLMLbGfHHNBxMX9W9?=
 =?us-ascii?Q?Mpby11YXFleigP5Gu3zBLKmj498Owb/Rj5T1wDQkNqyjnmAxlFX+VffTyAZr?=
 =?us-ascii?Q?kL7LA2ZWPwwYS9OLHjT4n28bH7Aba8vKRjFHvM6byv03cFzz+cZ5g9tByFB7?=
 =?us-ascii?Q?dW0VnHa6IMddFEn4cvcLu7gvfDNtLLYS8CWih1ahDIefzvu48a92w5Wff0ah?=
 =?us-ascii?Q?YaWdpOdEbjOxusSRrZK33b8R0TGTCGp+zc0tDOIBHvn4d/zBA1O7ryrnzRbn?=
 =?us-ascii?Q?3xvdANBSH8pBuKwwXpyCAJDLc/JZX4BYzgVEjJDahxxX6wsmILVS9iD5CPan?=
 =?us-ascii?Q?2nj2Beg+XFDHP/diAJsjPTf6ktLitjFrT21phXy5TebeM6rmGPC4T+o7nAAI?=
 =?us-ascii?Q?ntkijYtna0AMcdqL0bn55BBuc7wc/qyKR6hVezeWoY3HIAKKhOMofpzzt6Fj?=
 =?us-ascii?Q?kuCAk+NzmbRxYi7H3V7ClMUnwp/I+abFxknRvyHg32N1ywT85S7q5sKYUcAr?=
 =?us-ascii?Q?7ut9tpfwWos32qk6MtElLwtgB4MDLw94Um+HHAeUGuUV6Hv1/dkNrOTFQja2?=
 =?us-ascii?Q?tBx5yzfWejdPu8FqAtMIUB+sbTsVnjuhD4yx+cfa4RW+9lfsEFun6PqmUrkI?=
 =?us-ascii?Q?OK20ZOtTMOufuT//FOqoVGjsb8djTy/U3rKkLiWeB/IYbL6fn/+hI14r7vad?=
 =?us-ascii?Q?naphF4u0HBMKR6lxnW2kO7JRPiVQ3xw/6OkqM0piXgXR0dZxw7TlWof3vT4L?=
 =?us-ascii?Q?/SU4XB147rgPKaSo09V5ykh1uzshtW9XmdKjHKcoph7nwI8yv8LXbvwABLFG?=
 =?us-ascii?Q?xxR0drhEV6sZl1jki6CqrTmnoZSZtzSaz/oPUKjcU2AG4StIDhpv60OLywZ0?=
 =?us-ascii?Q?WhsvqmrDoj42mQ+truEBeNLXpBnoR6mRgnN2A3Oa/TaCsmP7qOGUxxJwdgvu?=
 =?us-ascii?Q?2mGu27VTHKz3yisP48puSLNfOdsDDOcA8/7THOFJxsk6ki+CTelHPl+ONfyX?=
 =?us-ascii?Q?sCL2E14iYJp8jCKluJfc3BurrnJCLMSPviB+le55Sl4jbVGocP1J6oAqRpUJ?=
 =?us-ascii?Q?uWFF7rKX+8NnWhL7zI42GAro1+8v/hb7ekjhLPvpceueeoSTQKS+wjmaXbyj?=
 =?us-ascii?Q?XdnqgrLhFGvTGzkpQ3atqEw+llgqF+JwoNU/Ol0D5HnQkRofN4KBxbXWgcDE?=
 =?us-ascii?Q?kjpZulLvtmHRjus8dV5+FrC+9HNV0mgzgrvRnBH8ZkDzvrqoN/KBGZEHOU2s?=
 =?us-ascii?Q?UY8/chyXdyZshQuoDime3FNkGhcUyiNjYM9xFMz95kzgrciga//eJX0qSPD4?=
 =?us-ascii?Q?dFTyw3UdaTFlbG+eBkCepZtD1FiyINujdIcZXRJM04LOgvXS6skqr799P/4j?=
 =?us-ascii?Q?j5zxz1IByl2+PELcBQAQ4wNCM1/SUAk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b830f8-68ac-4a5c-4a73-08df3d900539
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:28.2720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DXq9hHl+A8PgGPo02m25nBMw97eGcAHh9vHD/0qyaypPjozAnXZkdKYGGriTya0F9blv6rIygCbOQMb4kEf4rZ25+e+UJoaa1CH0XOxN48=
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

The e5500 and e6500 implement cmpb, prtyw and prtyd, as listed in
table 3-7 of their reference manuals.

Enable only the integer instruction feature flag on these cores.
The e500mc explicitly excludes cmpb and prtyw in table 3-1, so keep
this feature disabled there. Unsupported floating-point
instructions and extended FPSCR access remain disabled.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---
Reference:
- E500MCRM (Rev.3), section 3.1.1
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 3.1.1 and 3.4.3.1.3
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 3.1.1 and 3.4.3.1.3
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

(no changes since v2)

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



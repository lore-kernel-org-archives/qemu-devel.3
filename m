Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E811EC531F7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvDo-0005MW-LG; Thu, 23 Jul 2026 11:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDV-0004XT-5j; Thu, 23 Jul 2026 11:20:10 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvDQ-00085x-R3; Thu, 23 Jul 2026 11:20:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVvZY8bl8MIGCLne7Dbs84o5HVAYxCOCRfkRiJKWsP9cTbrGYj8tAb+jd6NAacDg60sZRkKc3c9V46uhCXAM47J6YWGVXtxo2sJGmO2SldmWN++kMHQjJiMAYiqYGSocdF0AAkTef9jbJlaNWSuSdxqfw7D/DencpYS3pDp/kGPIal5N8JPRRCq6F+V/SU0NLb10h0nHQvsogZp/UE2atEiDvU6zCpPbIQXulQcWTloVhg7NqX/07UXlnt+SRkJc+sAwLKvFfU8VATIYIpLWyf9atDDQdmKbc0i26wikBqVqICLuQm4MP+4MjCHsC7dp5tRXsl+wf7KAGGvOK0pUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2OW1fuRVPdUXTcStYsFTbQhFdLSW02RzeZnaqFLt0I=;
 b=mshBp6toujh1VBHqVGF1/LzmZDAMU4EOgFZ++TK+KGTs/1gxUppJoucR2sLjp5aaAkuSBB27HazIE3FmOWZLevoE5g4pgbTwbpwL14CN+ExoRytwjGG5l4pAlOMJTqCZXcWNXGljamPTmfYJ63+01vQXjjuOQ4Zo3DlnCfnr1XlB3tBmJmccS/x3mW1hkJ+qgXZwVCNtx97Ja1GEoIKIsb7cHCgDL603oMeLil6WFc1Yzxzv9n2Q8ajnJQg6VXhg+9jySNOcpCR8ido1sgq4HPEwDcWpshsqxtu2Vdr5xpzMrzYz/Jc4vpuaXTMsgLVE9X1sq/Ai3fmeKUAKNKaY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2OW1fuRVPdUXTcStYsFTbQhFdLSW02RzeZnaqFLt0I=;
 b=Q28sPqc/pqKvkIWku/nZCD8cnoZqjuVEemunpZzBcWRaef624saQkxY8fmASJLJ6FZDBn7CEqvv4JDOLFoOTJUSzq8QndFqO8PvdnTWAD3537PIJQxIUTTys8g+1c5AAwSTJjhNa5+iLwsmjWcfR72TeCafImhpdRK/XTh4GMX7LYrBkycEifyFzZxlWSGwofaK7hPWdLzbmpbvNWQ+Wg4WlhGVKnTR+LyMPeQ2OoXo8NohfOBwAwK5qPD3pe6E3wNSc3UGInn1bAXlQjIheONqVBhm2qK4qLhqOnERVD1R7ii3leOT14lhyYGJIPOZQ8GUIPSdsIguPwoG6tZETqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB7097.apcprd02.prod.outlook.com (2603:1096:101:1a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:19:47 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:47 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH 24/26] docs/system/riscv: pfsoc: Document CLINT topology for
 direct Linux boot
Date: Thu, 23 Jul 2026 23:18:51 +0800
Message-Id: <20260723151853.2143177-25-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: db7c4ac8-01e2-4f1e-a368-08dee8cdd4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|366016|23010399003|1800799024|22082099003|18002099003|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Ob0L+a0Zfq9nMi2wghML4jg4og/N20Ec4yELruRQzbOqLnz19UY0qourT/DUSSOefAHt48R7R5Fj5dt0A2cmtN7cTy7tQ98kIHWXMTk/7X8qvLdoS3otR43/54uFsWml8k30kqNjlDiO3CwMLhewxhk7paR/t4W0t9QBfy3uTtFYCAf51mdCnhOvhZ+kbqwPPP+gyt0W7ekGU+UexDvvVsaHyBpKowMGhhLqC+piD/NtU8H8BrPPYc5d2BK+8JGW3R8uPw1I+WN+VCvzX/E3sbiP31NLKWFSz10rf9bFHitY7j0l7nh1fkUHX9EdKikV9Tw6QCh47Xc/+/hH52ShqDO4ZR2apesg3kaytSkrpzC/hK0/j+0w/KpKWhTPKUsBkxwGrrjZU4TlI8exneSOW19Dj/WFZS6aIWY0tROl3o4g4QTg3Cnb1kwd2+JiThAlc0Zo9IDm+Rw2Tdu0ApmDcHQV7f879Bawuf+KPkmBYTpu1ZhNdVHt5UzUHWUOP7sIpZjNYOqEGaUNPEKQOJVzXF4ayw3OPSmpzm5xW7loaPMCiB2Ww6C0I4vpp4QEIJmbPbNywqWDN39oGiO2ZS1Vl0a9k6h3qdIxrAyitmWmpi6+uyFk0nRdSu8Zq4oxBdWVS5TFvhTZWVCgt/X6eDzL3eidseCrA2fmSBckabfaycw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(5023799004)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EpcKYr8w/cvUKqF/ggBXjkhpczc5Bys1w+uoynPIgczMtVme+jtcBfHZ/g0m?=
 =?us-ascii?Q?sMwmE0UnZq3FUzULKRmmb10pX7INhW/2V0PP5VFBeJ41v5kJnniNQOfJbTCo?=
 =?us-ascii?Q?/QnDanLj63wS0WOiwySCauogxIulRbfukqg+GwiDVqZw95y0B4zpA9Ia73NF?=
 =?us-ascii?Q?fLeweu16SxXmDlJ0vbNEDtcVLpSj0lB25l1a8iCfn73Hc8Z5b7wQE/L3PPiR?=
 =?us-ascii?Q?KTzMULkT1fmoIyPZSgq1XalPaawhtIbzdEuX0v7y/4ikMThWNlC1SM5y0QVq?=
 =?us-ascii?Q?sS5W+fq48ma9SoV7+tWsg1V0utQdHEKT1RbEw8MKz8qg4tahkRJUIJ/tym+F?=
 =?us-ascii?Q?4UVuRi72hlqR+x9c+FPmNhbhDOEz125J06PLjf5m/a9yu+DJudJKy7/hdrCL?=
 =?us-ascii?Q?znR2wfrSU4Mr72dCuegM4EV91aerk1lFgf9tYDr18NPVIFTqEv3nCErehLu8?=
 =?us-ascii?Q?R8G6K5PLElRdQALXyB9lUJfftJjJFO8SRGL/NHzyESBpNkm4SOxjaBh5OI5T?=
 =?us-ascii?Q?gOgSWCn1SVHO064QRLgbuty7AcdVwEpdDeyTpaGP/9JUigmz6KhBBTn512hT?=
 =?us-ascii?Q?0vayIWuOBR5XCkztfueYclX7XFBcnqUEfiA2Qk8eIKK+IaQG0xqFSAKAjJ51?=
 =?us-ascii?Q?l7WoHxEoS2Qued7ZPBhbJd9QY0pkOhAV/VFXXsa6er432XFDPJjAXCY907/M?=
 =?us-ascii?Q?YCVAWHB95HZ9CnzAcUY/wPLbLW3Z4kVBdy9/bxmOWy6nSIJyKxA28O14LbM7?=
 =?us-ascii?Q?0rBxdBv3c+QHOssamjCwL5xeQgMbpgtMlmW344UJ4HD1tYYXRRhzvm1jq5+b?=
 =?us-ascii?Q?qRU7R5h9fpuqI6L8gnINLG8yS7oNo0tVVlCif+z3yySCzmTmTSLmZ+IdHW42?=
 =?us-ascii?Q?Nd5g0uOE9lBvTuYdL4unIWNa0Azh0+sDpPolOLQUfyLxi5EH9Sn+yDwt2WN/?=
 =?us-ascii?Q?GULAAdKkqHP7nOzCD6nD2c+zMCoI+Slucv+E1q7yc2x0vhIO8EOwKXMFd6MZ?=
 =?us-ascii?Q?W0pdYqOGx6dTIHVcas7oCk+EaF9WRtUC4s9X4W8N34oAjV8zyvKeQYs2Wqnm?=
 =?us-ascii?Q?17RFZ/kGRfvmsDUVKpBGly5xz5LvPSRNrXwahcrP3QHmtGbGODiMnTFaEWyL?=
 =?us-ascii?Q?hgQDcU/FomEjy6HjHh8i1DftQh10kvB5ROM41qtQdkZfZU/F6i3+Lhe6IfCv?=
 =?us-ascii?Q?rBmDb99QEycEjNbwZl1Yy6rJZq8gTtx4AKXHEKSgjt12HSshgZeXJG6oC+F/?=
 =?us-ascii?Q?q9wR6rNmLxOT4vjyrGl79ybRv/UfJeZ9gl8/DK1Yey53A/RNVRzG7l9Sy1aA?=
 =?us-ascii?Q?dBOVwX6hwYrtshaclJKC0B+/BDW5uH0IEKIh5qZr17zBdQE9uTZwKuMRTNzt?=
 =?us-ascii?Q?vU9cjfCMRIQbMU3f3nJYXyTIOjkxHjB8l8P/tSeqNwqX3F1cRh2jgzyzmUwQ?=
 =?us-ascii?Q?560LzzCl0NEBTK3C7TySCnjvtIbvl3rj8ktxMyFclmhTn4oTk3RKt0FqBjjg?=
 =?us-ascii?Q?byCPwlmIXRowtlCrdLyDCxtMdH2Ni6A/Z16UknBmQDvOPfMeEQywcjhoHZ59?=
 =?us-ascii?Q?py3qUziXlAmJrHVQqAaczfD0xwP1n9zHshWEv0d2oRsxT3hv4URXu2GzCqh2?=
 =?us-ascii?Q?HOk6GogFfcNoaTxXMAr7bScauWSIt2ScH1/1tQ9Zhdr4+120SGnPQ/Iu37xg?=
 =?us-ascii?Q?xHnKrYGniPymnIQVoMq60EQrek7Ysj/TbrA8rDcbkXsX37sl9ZZ/NNxB9rjt?=
 =?us-ascii?Q?1fTxNS1ZjlFlbkUImWLWaGqmoty/yoo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7c4ac8-01e2-4f1e-a368-08dee8cdd4bf
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:47.0146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ4Kaj+u4093ZrL+QKaQW9phVDqipIL9DvFIf6N5IMQtbr2okoNQ249jxskPSMZGdh6i6hcNrLcpUR2u2FHsEiCrqEpH02dFc0LO84B7lnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7097
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

The generic OpenSBI platform derives the CLINT first hart and register
slot count from interrupts-extended.  Some S-mode-only MPFS device trees
mask the E51 M-mode interrupt entries with 0xffffffff, which shifts the
MSIP and MTIMECMP slots when the same DTB is used for direct boot.

Document the complete five-hart CLINT node. Require interrupts 3 and 7
for hart 0 as well as the U54 harts.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 docs/system/riscv/microchip-icicle-kit.rst | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index eeb4ff938c..af8e984df7 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -65,7 +65,28 @@ should meet the following requirements:
   option.
 
 * It should contain a node for the CLINT device with a compatible string
-  "riscv,clint0".
+  "riscv,clint0" or "sifive,clint0".  Its ``interrupts-extended`` property
+  must describe the M-mode software interrupt (3) and timer interrupt (7) for
+  every hart, including the E51 hart 0.
+
+For example, the five-hart Icicle Kit CLINT node can be described as:
+
+.. code-block:: none
+
+    clint: clint@2000000 {
+        compatible = "sifive,fu540-c000-clint", "sifive,clint0";
+        reg = <0x0 0x2000000 0x0 0xc000>;
+        interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+                              <&cpu1_intc 3>, <&cpu1_intc 7>,
+                              <&cpu2_intc 3>, <&cpu2_intc 7>,
+                              <&cpu3_intc 3>, <&cpu3_intc 7>,
+                              <&cpu4_intc 3>, <&cpu4_intc 7>;
+    };
+
+Do not replace the hart 0 interrupt numbers with ``0xffffffff`` when the same
+DTB is used to initialize the generic OpenSBI platform.  OpenSBI derives the
+first hart and the number of CLINT register slots from these interrupt tuples;
+masking hart 0 would shift the per-hart MSIP and MTIMECMP register mappings.
 
 When ``-bios`` is not specified or set to ``default``, the OpenSBI
 ``fw_dynamic`` BIOS image for the ``generic`` platform is used to boot an
-- 
2.34.1



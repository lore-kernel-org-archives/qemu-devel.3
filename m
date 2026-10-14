Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3219CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr3J-0006rE-Mz; Wed, 14 Oct 2026 00:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2z-0006d7-8K; Wed, 14 Oct 2026 00:57:02 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2x-0008JJ-Ka; Wed, 14 Oct 2026 00:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIi2Okvz+ztB7G9AJNQXhWWxubg5K9lbdVvEU1r1Jg63k0RBBHRgS+QCFvPvBz92vU4fBHwthxQCZHJXeJIVRziaNgW5D2OC31UNV9efTNy9H0lE/v8TLouAYsHMnLEmfRzdhrKod8HB8faIsyOcQYpaDLHo13EFvudMJuoaEOpOqeF9m++0nDU5DHrO4WyXlr7STRbzBRWEANcSSZVVcYO4x3Qe+6OMiwo+L8T6SHZufkb6QyE1WdPG+9KTKABekoXXG2AJP6E5gBalmq+q+U6/s/0mv8YdXKH43N9/uiaPGmNRByZrqRvKdnOcM5esDnwL71A6qaoHuxmZ5GIDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLpekwWsoupPcNUnNKPsHL1cDjX/gJRLeNaLDUinQNk=;
 b=hycZKh6R5uCYIRYxeLg0gWg3VhcsqPkYOJp4XIbE0MB8bbXb+5kmuQrPTBQc0+xhypBCSw74QzJwL4D+fpD+ds2lwgRiPTyz3JRkgEs/L9qVpSr8nj1V0AqGvUBf9YwG62zy6zec1w7P+aaB3Xo+1Zi2gBZOkbH5ndzU1ANKLJhE7rERZ6kUx8QKfCj2SxzArgKhmu8Zg9Ip2Hy63PGLjr1R6nudAmcMxv+Cb6lQByYT+SYcj+lle9hUlLGRxTMMzEEbE+zGpsKUGuBBuXGyUVI12LC6E4XfRv6qS2nR4etPaXjpAbiTgvy4n+hJzITVXuvFoYNesnnoS/gMNaeNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLpekwWsoupPcNUnNKPsHL1cDjX/gJRLeNaLDUinQNk=;
 b=mIw0MrEgUX8R79l8JMmIyBMlbAbGKgTPPyqGRji9lAbd0wZbqn9ZGVCaQ2V3stAwbaxFB0MHz7e2z6E1Nl3DuJexb1o6jRlg7APIrm2e/Trmrrcop3hA1JkmSG0ZYD1lIJ9bqlXBbBRcDnA7BcUKtnBSSfdIdy1nNCTactZd60Trn2zI2awo9iPUbDB1YnLC1srEs3btp+Svmd1oK1OGmi1zNpQ7FL41c0TSW/w5A7dIO5WGWN5ss5E8dpHA8+Wftu0xfgS2tOMxh2i6m85v+J4THO4nkHNr7N1ahlv86kRTmbOjfh6Em2d+bGN4ghC/aM2HFeO9U0gVqaUBD+FvxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:40 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:40 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v4 07/10] hw/sd: sdhci: Preserve uSDHC status enables for
 U-Boot
Date: Wed, 14 Oct 2026 12:55:57 +0800
Message-ID: <20261014045605.399684-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 213f76d4-c6b8-40dc-b093-08df29af8907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|10067099003|22082099003|18002099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Alp50EQc8F7+XnWu2zQakV6NTPCal1bUuYBEC5oH+32t863yTkDayXSLJ7QxvU+Ew0o091JM/EGpTQ4Mn3PzxtsSYJjDf/uMTYOQXZlwmaME+gKvT1Wl2Eu/YYLXuLNi/GXb1Ygb262PEVmNs2Mr/3AkBKra5q1yxpcq133uK2Luq1rX7THGNomZfFkTTOJlUiYulh6eEPcF/v7WWQAHgMkHvOkOXJOc3je5WNP4/wId/piSLABNE/VwxVuO0KSo/ahnXwC5kYdsNSrmZC89SwZ3+4AwfwbIURcsv0dulZsqDy9HP26spz5hz4DCFJcvBSNiZDVViJhNsrxfYmlHXJ5wkiiyHYyrfapzwyoF5ylwgoUfhHEuUu2+Qb7SlJh/HJjyVK9IdKyper650MSWPlAz77kkDtnm3gaGI7TK39k+wO+0HBX5SeNyuNsfRqFw/j7AgOoZWd/Wb1b3ftu09v1Ab0nyhyYQO6fmPuwAue1BFxvf2T6AWeq5jwJv6avxgZcXw7AvQUtLjSjGoUErD0J39HnM5njbkSJf606y3p5E8P4qP34bLdVhAynW3pEv8hQx2hZn8smrx0cFmKPVYYkIuziBLccBOoa9ojMNmwvgJzIN1Efwj7pqpTgb3G3WLUjr0gwc8RWOVu2DW4wv3rCJIheiwmVjLzy1/M3cLfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dBIFVgslEp7TOP7Cd2jtbxd/RqiazixlE62706X72f8mXpJIYNs5Fhfb988p?=
 =?us-ascii?Q?Z1bfab3o5rwgknOZuYWf1xEl9UpP26sCgxHoRcsvQaj5YGW5FZ/HXyPhzP2x?=
 =?us-ascii?Q?207PW9yLSD32mu1t1jInnAVJfRQx6N00ETY/c1YQMNJ5PuAmQfrCPfmhHdAM?=
 =?us-ascii?Q?NjN12V8nLUlnrfgRB2VHXOX7u1Hr5onvpTd/1Z1cQca4QhmcWF8brlGvoc5M?=
 =?us-ascii?Q?yBP/8iTHuI/eBmkpkHz8d3+XyY3/0A2dqcVOpltSh/JyJuYE95/qXQgMM06Y?=
 =?us-ascii?Q?q+9f7Yq9kqjqTs6zc3bDl5juNJQXWQBxE+rTYjMeI4M5xtwfr/LgtirWlpOi?=
 =?us-ascii?Q?KtwUxv2JkTJHSUDiEcNv3AIfJizXxhNXpEhcllyV9IzrlbfFjfphl380xW/V?=
 =?us-ascii?Q?jYTkSG/VFJ+S+GPyIe1Yae2qQqBEEPntcROKRk8xTfl9fpKTVDZB4sDXLXXU?=
 =?us-ascii?Q?WZV/T7b4vZPaVLJLOAhGdGb7iULB9Nue2QIz2r5973OALBYWNT5uSJ6TA0XF?=
 =?us-ascii?Q?9e3B6o6dlD458YZz7ss1IQeYvrOatJ7IxWDR9P6iEgA0e4vGcpoPp7eE51Hf?=
 =?us-ascii?Q?GyFtD1gaPysU5v7mDVBXgq2uQSFsiSagkwnrFO2SRKWNe/QbsvLLaGHPGdfT?=
 =?us-ascii?Q?M80cS74W2dJ0Ybue9c77UF/AQd0uNrhVd2pIHhjjsJLetcRKJYqO+QTM9PG1?=
 =?us-ascii?Q?4gsNOzuJC/B/Q8fYC6LlFFom3h3mulKq4VVPejN+ch0wQMH2Cho50ArxXK4J?=
 =?us-ascii?Q?rsNO+LN43ET1A1jS4q33qVgb+434R8VdJYQNjG85mLjhwCiBAucmyLAiRAFE?=
 =?us-ascii?Q?pNwC1NmvQrJt/TN46oEoRBx43acJNtbVZ4syy2jZ7DosVUJqq/CSTpkw0V2x?=
 =?us-ascii?Q?0GH03PjDxbVsWG/vD3uMVmWIvmJu/RyMHKPusTMPpeyevTZ915FITjNeLr5w?=
 =?us-ascii?Q?HN2ZB5YYVyVSR89kfSp6Y0CT6kiy0RkZN1A+Hz5LTe0lI9+eG/KjYm8AIRW9?=
 =?us-ascii?Q?c3Fck36oaAg2xnSl6IH7UEBkLrsYxy7LMi2+k8ycngIaNDONKHO0F+Ipxfez?=
 =?us-ascii?Q?J98Py0q93XC1WTfGAUhm1j1ul6r8aNH0TzwsaUbcWTvmrHwAN0SjvY/Brmbl?=
 =?us-ascii?Q?B+nfMtgOeqWK9tyR8+OLd+QHU+6VkVdloM8Qz4/XhZQwAxCcdk5UtqEAUOTI?=
 =?us-ascii?Q?0bczaDgHDnO+6A7h/KxZn4xaxQevVIAta4ALK9MVRx41OBTS2pO0s2QOGuCu?=
 =?us-ascii?Q?60eyJJeiQgNhidf2kTqlIW6g1u2qZbwbtxSgeV9g9gaw8miHGs9ppCBpN1qF?=
 =?us-ascii?Q?YyzIjrG3nXqUJRPitwQjEYzB8qFxtXmalzU2flAn/Zk/dY6dyK98MOXDtZjf?=
 =?us-ascii?Q?nMO3FjfgpCtYDP8VS1DyewdXfig4wA5Dn+GEgE72nrtsDBMcQgjkqJkzs6Iz?=
 =?us-ascii?Q?h07A/lmCnayOr5Nxi5lZBTflHQSTbyED2Hg/o2hysRKZ9H70vsclZr2R40R9?=
 =?us-ascii?Q?BAb9wMJVmHF2Z7mxFLLi+E3+45LBOByUWe0MT0PYTnovHFfyyC4HIVWJuger?=
 =?us-ascii?Q?oJWGyY4wrqwjvyGzsEnGpZ0rGRwVSWPG7W+W/rw5xEB+I65TuhKgbH72mtkv?=
 =?us-ascii?Q?NUcKPbCV/9n3nlpECaRqXnFSZVWMqrQNwObvGMuBpeqXHcx+R4cMnB5FFo6r?=
 =?us-ascii?Q?LMDMnj1VoMn65j8boiI9JZ68ulpr/jDsoq63O8NaMiJ6o0njGFC/QWol9cJ+?=
 =?us-ascii?Q?CM0ucps+QtNkrfqdwhOnvbTV4pndDY8=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213f76d4-c6b8-40dc-b093-08df29af8907
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:40.6434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ofDpXir97rIPICQdQj9S2M/ejj2KRL92UUsKTfq8GnUcZRQ2TRSQqvNwWQBUsclS0WoJQ3+/XQWxcqSDLPsH4MALcCX+z59f+125xdOaKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

U-Boot's i.MX uSDHC probe calls fsl_esdhc_init(), which resets the
controller and programs INT_STATUS_EN. esdhc_init_common() is then
called, which issues a second RSTA and only clears the BRR/BWR
status enables afterward.

The generic SDHCI reset clears QEMU's normal and error status-enable
fields. Consequently, the second RSTA removes command-complete,
transfer-complete, DMA, and error enables. Commands still reach the
card, but QEMU does not latch completion status, so U-Boot times out
and fails to expose an MMC block device.

Preserve the normal and error status-enable fields around RSTA in the
i.MX uSDHC register path. Signal enables still follow the generic reset
because U-Boot disables interrupt signaling and polls INT_STATUS.

The IMX6ULRM describes RSTA as clearing read-write state and does not
document INT_STATUS_EN as reset-persistent. Treat this as compatibility
with U-Boot's established two-reset initialization sequence rather than
as behavior directly specified by the reference manual.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v3)

Changes in v3:
- Preserve status enables for byte, halfword and word RSTA writes
- Integrate RSTA handling with the uSDHC clock translation

 hw/sd/sdhci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1831e5e8ff..9a33899b64 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1831,6 +1831,7 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_TUNING_CTRL               0xcc
 #define ESDHC_TUNE_CTRL_STATUS          0x68
 #define ESDHC_WTMK_LVL                  0x44
+#define ESDHC_SYSCTL_RSTA               BIT(24)
 
 /* Undocumented register used by guests working around erratum ERR004536 */
 #define ESDHC_UNDOCUMENTED_REG27        0x6c
@@ -2118,7 +2119,22 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         return;
     }
     if ((offset & ~3) == SDHC_CLKCON) {
+        uint16_t norintstsen = s->norintstsen;
+        uint16_t errintstsen = s->errintstsen;
+        bool reset_all = (val << ((offset & 3) * 8)) & ESDHC_SYSCTL_RSTA;
+
         esdhc_write(opaque, offset, val, size);
+        if (reset_all) {
+            /*
+             * U-Boot programs INT_STATUS_EN before issuing another RSTA.
+             * Preserve status enables for this initialization sequence.
+             * Signal enables and pending status retain generic reset
+             * semantics. This compatibility behavior is not specified
+             * by the reference manual.
+             */
+            s->norintstsen = norintstsen;
+            s->errintstsen = errintstsen;
+        }
         return;
     }
     if ((offset & ~3) == SDHC_TRNMOD) {
-- 
2.53.0



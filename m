Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26263606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=ct927rDG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1cv-0002Rv-8F; Sun, 08 Nov 2026 07:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1b0-000704-Qs; Sun, 08 Nov 2026 07:02:04 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1aw-0000hv-0K; Sun, 08 Nov 2026 07:02:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUvUNaSP39KqFjx2yUEaTlgZJ9gEP0u/Id7kUl0qdmAF848hlDmsetDa+Tc0y+gmAOFMe2ePflSYyN/1BnxXIeDKQ2phwLgCtl5dhtkcxd26HA+aPCCSNxFptVHR48Nw4mtaowT8mcO8NCcihYDbGcd7oOQb/8jKFhVdAJI3MCOUpcdWEarAJBRUp0bynZtRWmUfduxWASI7B+NOf2KYUVkKQjvxRMqXVZ9l0YiadxdkCBNWMTbcVpNsg8z3lAaEdd6nt04UiomsfKkjdCTXXcGxKgIhWPS9to1a3y5lLQEkNHlUuIiVM8oSsH8guzhn5OmLAozHFYwxJEhDyFDICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RabL8qZ9zqYwcVVn4bnrqstRkCI34HwbHobINr3oRbw=;
 b=Agnwjr8YIEHKaYd2/Gb4oBFlN2uu2cDe9S8w2/hcsL38/Kiaj+/PTLSt9Igdh54FUhNjC1PueywXSqjGmm710MT5hBUk/j4kwwDXckqu9I9KwYn3NjUckTT+kBizmEDs54pSxhXH34TeU0tOI3k+yudW8fdAKwSmtHTt+TQbRSKdryJQqKLhCfPOJsc8DkXdFXcsxSFEnTww2mIoWUNuVL28XB8BMsUvLCYbAxWuKF9H2yjqzj3QJm1GHCW8eD8RugowYtYKpYYPRnIFFyLOMKv5ZKPfcRdiUlX25CAqQVwPf/M7Ix8PyvEZ4VCyA4FCa7NspwPtm8aleLEF5ZLI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RabL8qZ9zqYwcVVn4bnrqstRkCI34HwbHobINr3oRbw=;
 b=ct927rDGKtYO2gj3Al3Y2rXs7PkAwEAyWu6gfTNi9A7sFuRKZUvgyok8Ss4PRlqBqIl2xzwGNU9ZfpQ761cU4N8bs8FWcM55ltnUCj+fK0bK5vUmRjqda3zQc6Fp4qxfEeQqdHhb7RAx+6l7Kjip1Rdl1qcGBlDpb1OCLjX/QphrOktkDLfs5V93YdGxYVfV1L+NYWqgRXorOlxqW+EOZ+zN9p3r7p5cG79Ivv6WyKcz+4cVy/u47sizWj23wdtPLkz4i9rvGWk/C6ZUA1o4384QKXbMxjmkVUyVE80bVTnSGTFPw601uGJC3rQUmYLCy8JNAJTnDO2c6bJIpQRyAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by SEZPR02MB6945.apcprd02.prod.outlook.com (2603:1096:101:19b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:48 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:48 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 20/23] target/ppc: Limit e500mc and e5500 to one PID
 register
Date: Sun,  8 Nov 2026 20:00:19 +0800
Message-ID: <20261108120034.1755008-21-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB7144:EE_|SEZPR02MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dbabd7-0dfa-4f99-6a9f-08df3d9010d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|10067099003|261028144727099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 7T3XhI+Wx1sWdKW3PPONc3YonpQEhzkFmVuMTB9PIs7rqHr5pjfgW0K8kfM22ydzcFKkfnpDmmSOjxOFvuQ8eiiPftygHn5DEcGCB4PJboM3A8ZH1Yl/EOJSBeSCnikvQwP0fdMDIE1DamP93S0UVf3qsg1aSPEk7SX/09b1wCdY0FLHeIoQgTd4d5KI7/0ibfI8qgANJF4y21JQcAT91V+5tZ7SKdp/frlaofPQU9SYWI8efCHDfEcHZI6Bg/30CilVYx5SksrQokpcvIWslHUNnJcw/+hDHdZpJGIbT68Zn3NWq8IuK7awxro9kP3F+iyPGjl3a+XXIx4E8W83EyzK4j4NUnFKkAs1jI1bUoDCrvHkXygg8bKs51H3NDCrdVwFpxgZ802He2OT4LX9b5T0ygOgYLS64ZRPet5DKWRWeIW2FainpgWpmlFEiMcTIPcCcZ2OKkUpxuEArznpXy6NL51e2rF5k9+ay5gaRrIf0uL1FinhXKoo8hK7jez+1qEjjq5Yc0q/wekIC/t2OkqrBbeFMYOVW3dAwJzeOBl7r9grMJyVa3czy2zLYcllXrLrR1lQckWuKvskB3cRlT1zJreFyKEHa3J8/r3Xm8kMksJPYhlUEd0Njh6ZeuEwXxYxhlRStO3WUrgqm88UDxIOmVhBdm4YkW/A3raRQWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wsKTyvMXlwgk0fWueHqM5CH+/xxWBRa4ozPz9D0Vpvz8KNWBfQ4tNqIm7eGA?=
 =?us-ascii?Q?wjZGp/UDdquT5rEpxDfbK28XKS5DMcbaqs91nQ1d2pjaHZEui5qRKteJg3D1?=
 =?us-ascii?Q?zleboNvNkBd2cIorL2mVWe40d03Kq3DvuSaVdpndki+LhHnW35BvOdHEvo5U?=
 =?us-ascii?Q?leOXjXMA2+NjmLvsETSLrCOMLRW8Bvpc3iOWDR5ttqdQ3H/4hQZG7GzaAVqX?=
 =?us-ascii?Q?Hpe0UlSSYPwc6q6/LLQkAK3CCpHcGWe5L+ME/2S9dPPFy2/Q1yWusj1XIhI3?=
 =?us-ascii?Q?/2R6SnABhgboPzDjqmGxvOWM4uoRYKA/qrWBv9lMni/Yf5SGThgLBo2jO/pr?=
 =?us-ascii?Q?tNDmpBKIzKkocbOM5s+cxOS1JnJ6PAowsu2Ablket5AvoVyZyIShI1ZVGGPh?=
 =?us-ascii?Q?BwI6QNLvkRezuyk5M+7appI2tkZCdb/2BbVU8/L8u4/JAU8xtYz1npmefJ37?=
 =?us-ascii?Q?rcBfB0ho3vNHU49WxqKKIBCfpAqg+rMiKrlNOjpnVUwY39CQn3cGvPvuNJMA?=
 =?us-ascii?Q?X3R7XLg1nHnn2bZfmByC160SftVglsaA202c5n0LWLNErjHi/gru+QyT7jA6?=
 =?us-ascii?Q?X73iXflZiqeSXO6ylcM6d20f1/m+capgETmst9kX1saPfQ0U08ncuQws/LXH?=
 =?us-ascii?Q?p+3kuQy0E5EAaEcbwAs6uqdmuXvggJAjaqdGnEEsamJ7TGyU4XFF0S0YQLqP?=
 =?us-ascii?Q?PMmL9+KOFta+ZVT0CnIgzN1wJacK3ij231/v32VNJsvOhIpC5x40Q1Db/9yR?=
 =?us-ascii?Q?oB84spnHDZj4u4R/aRDUS7Ne4CW9oXaTS/5ZqrotaW78Rg824btP6Wd0OuGZ?=
 =?us-ascii?Q?FSD09hbesBPmPnUn+ALPSxKGZR9Fj+pI3Kx2NnhGbpFzs235uRcWkNGZijzU?=
 =?us-ascii?Q?63m2ECSxAHOvUnIUCt4/eXhH24iVp+3iAuTccN9GSon+MkTY5BEbEaLNFjuH?=
 =?us-ascii?Q?xHK3ehMRrRKVAPIgxOR+fGaMYWppuCvGWt+QsVI2a/V6r0BwSMFKEvc9bGcj?=
 =?us-ascii?Q?3C/cFyFZRpG5B5XNdl5JtcZI0jDrT1j4nQnnV3zr0uH3r2Rq0negdxO6XOg9?=
 =?us-ascii?Q?J/+0APk+CfYKiNdzzxDg9eT71knGiyBi1m52bKlLDIG30UxcT7INruhhsNJT?=
 =?us-ascii?Q?Rtm452IsELMUE9q4EeH6M4MkY4RjuOCOF5n/uv6jIvOS5u4jGvSDnFLUMVrW?=
 =?us-ascii?Q?ANsmT5PI0ULyVP54QKD1xN+CttlX34aCZw21kvLp3yGV1JNXV4OO3DbtXjuU?=
 =?us-ascii?Q?OYyoSfAkg5Sqjd+u+bPNsQcrIdyuqwvBss8jnL1VctG2Q21RSrQ0lNPOHb8F?=
 =?us-ascii?Q?y08NKo04GSDKlWpNFaicBAHOoGYZuHEY007Ee2bexvWxWTmbkbHOGvyI2gak?=
 =?us-ascii?Q?wmd4y2cPkcuOg4HbT93Up4yySXw1p+rH5zgu/SuawHUYhOvLfrprn37nZZmZ?=
 =?us-ascii?Q?dDCKmgmtxmQ7hMDkaAY8I0uzWiSynbBlP3hcIHzb7p9WYbZlUR0+e5aciiJF?=
 =?us-ascii?Q?yI+RGzAXYomu1sOn1v6UGFhR3VRh2XkPXTq6N8Jv0+/Rx0KWfVaH9Se4+T/z?=
 =?us-ascii?Q?rf5b7Kx02/CFbBIasJCrs1hn/X7Hr45JcgetO75oBGPQyhaH/3+Z4EJ5JXkg?=
 =?us-ascii?Q?kc0vTk1gjhqcfWi+8rsPTTxcX4GdhtFWb8nIwBAb+RlULglpQQ89r3EWLoQQ?=
 =?us-ascii?Q?YsCo5cgIuLYlihQDaqUUxGIhRb7HJ7P2KrnjxnepNNYaWXtweU6kjsnj9311?=
 =?us-ascii?Q?8QY2qqSn0fnHKMUwGXH+vW9u2GXHZBM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dbabd7-0dfa-4f99-6a9f-08df3d9010d6
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:47.8763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1J2A6r03mRgiZ2JVWQ5emjOTQW8IIU02tSy8jvYGTB/AYIic5cLBO8kfsybDw33NnMg9hyI21JnU3b+HQF1I99CCEC1LH5RZZEBbleK6xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6945
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

The e500mc and e5500 implement only PID0, but inherit the default of
three PID registers. This incorrectly exposes PID1 and PID2 through
register_BookE206_sprs().

Set nb_pids to one in their shared initialization, matching
MMUCFG[NPIDS] and the e500mc Core Reference Manual, revision 3, section
2.16.4, and e5500RM revision 4, section 2.16.4.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- New

 target/ppc/cpu_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 72a46d72fd..8cbdd36df4 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2868,6 +2868,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
         mmucfg = MMUCFG_MAVN_V1 | MMUCFG_NTLBS(2) |
                  MMUCFG_NPIDS(1) | MMUCFG_PIDSIZE(8) |
                  MMUCFG_RASIZE(36) | MMUCFG_LPIDSIZE(6);
+        env->nb_pids = 1;
         tlbncfg[0] = register_tlbncfg(4, 1, 1, 0, 512);
         tlbncfg[1] = register_tlbncfg(64, 1, 12, TLBnCFG_AVAIL | TLBnCFG_IPROT, 64);
         break;
-- 
2.53.0



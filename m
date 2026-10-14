Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0AECC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnj6-0005UQ-EX; Tue, 13 Oct 2026 21:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnj3-0005TN-Ug; Tue, 13 Oct 2026 21:24:14 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnj2-0006ql-Cv; Tue, 13 Oct 2026 21:24:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk5/8gONyHPfrJvlM094QDVUYg3QQStenC4fSB37OVarOR1Ew6W/eC5guvSu+HY19ZeoHFbt1k5rSmNSfmqvDYqAvo01BBHyy2+WzNtqCD2VIkZB6JZ1NScfduv3i2rsbBx6Yu/3HynDidf64jU7DwP4371IPk4PzzzFXcGERYuF1VicAEuNZDyYQeS359sYh+4Dzrjpe0BN8RF1IvMUUf7J2oPCx4C9bOTLWdNHuop7b+Al3NEvzsp3hz7SigBOppX6ENS0JM735/Hw3p8TJOBZ9TBndEQwEZR0/NoHw0oo+RFdMDlV/3KqYQkn08TOWBcIpPQGgOT3faX89xXrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKU7hKnCQXQx77DNv2YiglKLWFekUmfmQySPK5dRSG4=;
 b=eNwo5Rs6fSjr0LPFXLgpT99CByXWAiKqbp1u0NZ5VpXIKrgeAaOiCahVycBgk2gqrB0yaV9zu3xIE0zYjDAKV3qk9alRxpbGFLvSUmqltVrN/Uf9JM0cjJXmG68dRoOQx0lc3UfaNQSlUidWn1zimUEDqBLWzjUyDlHWvRBpVprTLUJArKZQ1GYK0Ysh5c2aNrbSJqbfKJpT3djR6TqGja/Eiml0PGgQwUodOm9nCdiFEN215oZM8H4cxjcPwoPSfnJbx0p3nl880Gi5t98UgnMjGyS/+/DUzT224YgzgAfVBH/3i//zaRwfBn9H3vTbTDoVAI2vcm4urE2KgE4/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKU7hKnCQXQx77DNv2YiglKLWFekUmfmQySPK5dRSG4=;
 b=f7HQVa7/VD22WBT4SjakN9MlH5hX9It60EWR/KZUZXWBAR1ERd65bZzJFBKTLv6mtvHi0fsr88BdrfZWSmG6gumsvjPz7P6gZGwv+HAyxnL8pOQjheUkg50T2KDnpc8GFqLWJrKSkJAjKVPPr7gQN1mSDVkIAMe82luSGj+GuTvL+ShfBypZrzacAKMCjMjqGeH5M6W8HRrAD1C+hZqtAcf6WXq2BrFhv2t+3QZi2ODN4MG/lIrkqnUpWRYudB0vVCN6c8uLXSs1Z3j3gvoJc3sqg9iqT47Ldv7873RSSapYEqvm4S4whaD060Gsbg23tQINvEKf1EaBAI6aVElUlA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:02 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:02 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org
Subject: [PATCH v4 06/27] hw/riscv: sifive_u: Correct the L2LIM maximum mapped
 size
Date: Wed, 14 Oct 2026 09:22:46 +0800
Message-ID: <20261014012323.322790-7-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d9c2af-d3e4-42b8-7649-08df2991d481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: WgQ3XCBlgX5LTtM3Xps4/bpBouTjp7nXuvD4Qbv3QFVuhQG01BpOu896y4zwvYKlfI7Rp6mphGOvCdElKv/5UbOcJhQNkgYDYW6UtdaU9ydt5iX/MFSFU5tfADb8uSee2yJg6cmBD9UYF5r+42tv0yssUE8pSu2w10EJ6QDmWeUAFHSAGIJ5BSEpylPZhoR1ZKgpYBKmaVXWlZ2jInaiGWz3fgqa0hDS5b4XRTSHqO4elCeFWAy7gyQ8Vvzjx9ag1ldoIoMeALODLiKM+YWCEYKTvduqCVUSeIp5VtC33xIM1kD1VJ0MNQpIsQTT8cjM89jOP6he3aiK9oA805i6wKmJM5oO5a14Te6uZn7QuJvgMyA1djrwf+qZR+rlXbtHVSYQWiaGWIHoV3UTZMZJKhaMGs9rTVPyzN0N4q7IIBPZZDYYvW8OMgtZoEbi4f5ybCfNuV/js3oXKBNn+L8MkeiSnWz4KMChsXZco5VLktUVUlXbtlkCooBoNj4r4/77V82qVDgca2HneTnFX3PVczBYs5uafEkySe+JqJHRHR4WbWX09MZcY27R6bBP/CX6yU20/9KRnV1KG/TtNiPF5KX/b72TweJ4IYZez+Oe/mKxmc4sw11aYDSKCFOMqZfEngNNFkKO7fYZludiGlDWmwpMSucDA/rnGqfkOKH4sdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jO7Ied80VRNizHaYMe2OKrGV2rJhlNc2XNycoKXvaqNrcyyR+XDITmMIjNJm?=
 =?us-ascii?Q?IvjibjbAysi4q4/9++8D1+Xn0hJGiYz/lXW7ISOgNgBGFJGRyY9dhMfp+NO1?=
 =?us-ascii?Q?p6aH6t8mGnGq+JabLgNuT2bKf9ey3ARXWPB86dewfzB74TTne12/p0pqhlE1?=
 =?us-ascii?Q?O7DbW/SBJ7DlkVF++liuw/gESJgf9Vuy+7c/nRI1OW+UEXoqSTPPkHaiWd0Q?=
 =?us-ascii?Q?242lAfAbanaMI0mDwKNlPKed1/2riaA4SAzujRb90fIZkmjXRpwEaLBKKCAg?=
 =?us-ascii?Q?hsMMgFMRbAb2xT9buMz73ietBWOZJC0P6/zZnpOkBL17sQmie9/wC3VZ2K5d?=
 =?us-ascii?Q?1ZXssnjmFnOiw+9u33OPiXrvTs7A067yLUGaHIt0okAE6n6OrSaNnCvbdibg?=
 =?us-ascii?Q?8LuMTiRsPoJlHtUhdQ2aO6Fo/hs0EypbLRfi2I2iQwL1UqWtEPy1t5c907Ei?=
 =?us-ascii?Q?X0AlaRMcYjYzh1cIg3kHVJktly2xosDeHKVjSQq9j9CtdRtbZqDssNtoMpug?=
 =?us-ascii?Q?kERi9ks1qUVXykoY2BH6J+0wbKfzXo3ZVUftsApGP/o4ZT9hZU8Vo4EOKwzW?=
 =?us-ascii?Q?gwMj5zTi1b5VWwNnYxdVn1vp8HifdTinZNvBpfixkmPt4EDp65F7EFIrGeaZ?=
 =?us-ascii?Q?N8dqUZawhIb0hqrUw0wfb/egVVLWTz5TcII9YJvw+ip/wwz+GreH2h4bDjSf?=
 =?us-ascii?Q?gFIEUqgVgjER+27EzjSJwYHR4vunIrR3qJ1h2cBw7k31dnxFs3zQxfaw5tIE?=
 =?us-ascii?Q?bjglpJEKG21acdE3Qf11otdF1CYNPK3gy3Kmm1bapRRm/8KE+9V4ijQFoTAe?=
 =?us-ascii?Q?kCHrWA3zWs2F2/1mjGvDtY+vqnXxAwJH7Z63oA4RCKJAk8NVv1FjoDt6wOgf?=
 =?us-ascii?Q?KhCiO7H9eE02CYC5HDmE1KxMww3H9VWaM5JpA+fLtKIQEGdZi7IoOfelrnMQ?=
 =?us-ascii?Q?7kx15ivJJwZqaXcc0KchoRmdltrbBNEyWGXTTpzEKWE7DmronKN/IMP+6aYC?=
 =?us-ascii?Q?i5EQyPDKTFWUusxrGzlHFeK/IH4aKqnWU91rvi0Xmgi/0gwpRr6DUFf/H5DE?=
 =?us-ascii?Q?zFwBtWxhtfp83PepTRXfb7VQPTCEvqO2Ra3/xK6a4Vl7jvfclxsNLXBoYrAP?=
 =?us-ascii?Q?uh/R+Me+6JSuQfcwIENHA6s8sLgWtdjUqwXOufCVe+Fcx40NmYgmFiBy+YQ0?=
 =?us-ascii?Q?cayupMijpd1hK1YX+WoszwWt9Vwa/5b5WzEQayNfSkicKv4EdkZfSNU22hSo?=
 =?us-ascii?Q?bDlcseeW+T28xrAqKaGAR+RkZnRhcgQGYorr5oP8Uy18K8qV/qSe8WJHbJ0K?=
 =?us-ascii?Q?FMI2vkjfY/DmqcB28gYRJcjxO+JoEWLXXGDpa5JsLKRP8tc7wSlT9ASjPNNb?=
 =?us-ascii?Q?sGRY2mHkrGQjQxGoVPoWC+TEta2KOkUN/0NIx4gTZYWPDNJLTsppzb3CKud8?=
 =?us-ascii?Q?eI+K9NupuI9nYpHXbj0HKDxdOW3HrpSlioKK3RG8oEJc1zqU5IMCVT+2e0ZW?=
 =?us-ascii?Q?XBr0d0Rgef7GKIYMEGHVr2BbSfl8GxqwUq3vCyRgav0GvvHQix4Ey8rc29YF?=
 =?us-ascii?Q?Scm10k9ylXBKe6EKvBMHbZ89w2UmnJShXu10LpPMZ/u+zcdp0RqV9aLh3k6i?=
 =?us-ascii?Q?OVCCFm1Iyz2AwDTxJSwLQ4JkAgtMmDtj3CwxFSIpGwTelz+EHpPaso93Ttl2?=
 =?us-ascii?Q?E5f4abERLrnY369v6fAb9PWSn0oY0v2YcgJrFT/Q2FCGAmP7KeIccv6OBOFb?=
 =?us-ascii?Q?NAGSoWbPPVg7tDFUxdczRPINcHSNiWk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d9c2af-d3e4-42b8-7649-08df2991d481
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:02.4069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAK6NUsnCjaBOTF0NB/ns3rL+MQ8BeFa6aZ9gc9+sPW8NNS4Am3GvYVcExSpwMx5w7QJ7KrnLe4Ex0GtFhjpodvDvtfXyubt1ryFYqlKK2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

FU540 SoC has a 2MiB L2 cache, so the maximum mapped size of
L2LIM should be set to 2MiB too.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v3)

Changes in v3:
- New

 hw/riscv/sifive_u.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b7d5e7b4da..1ac0d1bbd9 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -72,7 +72,7 @@ static const MemMapEntry sifive_u_memmap[] = {
     [SIFIVE_U_DEV_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_DEV_L2CC] =     {  0x2010000,     0x1000 },
     [SIFIVE_U_DEV_PDMA] =     {  0x3000000,   0x100000 },
-    [SIFIVE_U_DEV_L2LIM] =    {  0x8000000,  0x2000000 },
+    [SIFIVE_U_DEV_L2LIM] =    {  0x8000000,   0x200000 },
     [SIFIVE_U_DEV_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_DEV_PRCI] =     { 0x10000000,     0x1000 },
     [SIFIVE_U_DEV_UART0] =    { 0x10010000,     0x1000 },
-- 
2.53.0



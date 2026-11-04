Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97701606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=e14WemAW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeLy-0001RK-Bj; Wed, 04 Nov 2026 12:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeL6-0001AB-SN; Wed, 04 Nov 2026 11:59:57 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeL4-0002UL-At; Wed, 04 Nov 2026 11:59:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEX7f5wv4Jf+w3FIKFCUxVYrl86qLxq166s8pX9mEwp+ycQEyo/qqruRiTB5TjRFt/GT52UZMI1IqxgUaKXuFnFTlAwvexRMzne6OivLmh8d8blIzfsYaCNj35PyDvax5+qP5RhTTauGcHufXX4LdGBEoiI32QQlAi6hdzSj2LJyw/UFHL30pCxn8zTy5hQ/j872j8t8cg3hgsQGumosfsLT7HGiebHt3T0nkIk3bifZzYx9oN/fs9RgW4UxY5k82zAetFUoxtueLgUYbXLtxIONS6N4AZ/bD6IiXFxs6cUm/BEyXlBiuS5FXYMuqgXH/PN3AV0NSKV13lLgjU5S6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qd1xfl5GjhBPsmQEuaJDG/Rpptq2JZE3KxXyPOGpjss=;
 b=tAk+7+5lunGRckQxZch6konPzs3BUZnWUHOapafp2BFdqKaQulcJHabcnASmomb2vdO+eHGYPH64ob6bBHJNn/kx60qTP3iYnFQ4pQo2WUsOSBD6HReAP3aDf9wNs+Ec2BbXq6e62HnyGeUTXQlEYxVNTVf8mzYvKO8Mbwg6nKHPUYo1sgqlJH+shOYkTfbASCYn2WDYTaSw1ZTxoX3b+WTfUw7737NIUyBPOKV6wMSRluSelwNEFUFQUADEi7AukIuLFIOKq0/NpaM5BZ6pab9grF79GyG9gBWTb3Pmeq1/ATTBvhsvVLbyS1DDytMAI0mEed9uKlnsjLUl/ALUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd1xfl5GjhBPsmQEuaJDG/Rpptq2JZE3KxXyPOGpjss=;
 b=e14WemAWpDeWM/IN5Zc51q2tsGII5/NCBMPtCJw/K+2B8AnKYhUKmnU21rtzMCaQPQbfehtqsaxPMSyBTUdhJ4cLyToqz3jNvDfsf3AY12KKK4Q5RJNyD1iCA5J2yPBceaHHMAbtADExp5p5Qy5zptXBLmtPtu9/u1jrg+Q07ilV/EeMWPBAUbkZtMLO5gAK0hBxRsR4ymv6pUHr1yE4cW0ivSQHwr2/hHdYMIQcElwkbmRLJL8ji+fXalFstdSdpDleQA3lOlVDTkydUqYicrark350149oZI3CUnzWpnWM1WFIjnWgOZhakporFWJx3tTd8vlQ8idg3xZz/0uyAw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUYPR02MB9792.apcprd02.prod.outlook.com (2603:1096:d10:77::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:59:48 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:47 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v5 02/10] hw/misc: imx6ul_ccm: Update PMU_MISC0 reset value
Date: Thu,  5 Nov 2026 00:59:14 +0800
Message-ID: <20261104165927.678833-3-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104165927.678833-1-bin.meng@processmission.com>
References: <20261104165927.678833-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KUYPR02MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: d510cb47-b178-4a75-3c4f-08df3a950810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|22082099003|18002099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|56012099006|261021123027099003;
X-Microsoft-Antispam-Message-Info: lqO+0h8C73c0MKKg29FU8eo6sRSCusmANe+cLIrBY9WNyqsMLR3pSj0yhgmNKEBwdEWyPnN1U2FDbuGL1j8gLSsQVBvJGqJ/NIRh03P2mRblhaCZgfs8aNGqg8sTBbvAzKIadUTf/cOZZvPXKpwcd3zOytBxqWzJe5jaMhoaRP/zXY/5/xc7umgSISiwvo8OsLsh14wiMexbS+QSnt4GrAuBjOD2bdmOsnXaXhlM68U0Me4rbwNO624JZvEyUcaD70FDHRt5/LPnTtmEjyiw7LrrJSRkNZIbiG/UdSEajCM7fSDKs7bNLxYthwxi80gMQUwWSbaum3O3xF8pRG0M8mWnmeeUVJedWo5ow6zdFaZvW4bzmOHGa2+FI+p9iussyd9GfNtaMydZLVCy/2661KNjYU/saKbuaVPbcRBk4R4RwiQT+0QISNAJiW2g9XC4ix++hwd7YssRED402Qkov10ukIaiSrI74elw/xdqCAvZB5KgHlp5RJh5TM83RvfHMXxNZt7rCdYh6jCHfG3YHBX2bYuV6skQDR1zT9r0hTj/R+TP1scs8OwmjCkrMSDNicj8pTHbNMsVDnejOy3Ro6XlVN9Lj9R3uDvpQm3hXjyCmMkWh6YC625e1Mkyt5Txf+SPSKylg01xOXHygZAkIN75rMfn2KOCbsu1xZ4tPsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(56012099006)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jybbWEzHCURF3gnJAEYjNxPUeL/YSr7FagWUKxtivsUuu1e8t+Uc7HBVOwzK?=
 =?us-ascii?Q?aggaa8t4VsJ+ZrK3Hq1/2gX8+8zbv+glLsFkqRMVsHjlg9B+dUnoUvWIzr/n?=
 =?us-ascii?Q?2o48FnOcUH7yQzFf+lJQC6QRLcAdSk2vjmlVXi+esFNTZcoUySfwWbA/KxTI?=
 =?us-ascii?Q?/E1XccQ+lK4D7hBgiat/liByTHF5MKwHDxlMrPuGpxlAq9kOWQbYRD06DANR?=
 =?us-ascii?Q?gl/+tzdNRh3S3T1DhFVa7+B60jgBhyBoi/zysjA+3OoyrtD5GVupwC90hXZq?=
 =?us-ascii?Q?sdAUXbzWJdEk48hvmF13pMmdzclvjx90PjA8T6VOMI3mHwjIZT8oHX+ppjBu?=
 =?us-ascii?Q?VnjINcWSzjkRKXEyIKsoepxDgcm7M4qJVzcrdOHhcdrTUSrxngd7JEJQB4tC?=
 =?us-ascii?Q?tGpUdvUcylcgEzMNdsbRtKGpnT7od60rW7jR4p2fY9RKetrq7fhHspdzy+Dw?=
 =?us-ascii?Q?b6eumDHoEF3xTCaz6jsKVm5Ou5zvxsF9K+LBIQIIptWm+cOs4nRFj7r0YfDB?=
 =?us-ascii?Q?cfjlYcpCZ2yWrxNvl7mPBpDHE+r/kUS3UdzoguLpRZaSgRxAyCuyBdnsn5OD?=
 =?us-ascii?Q?dBQaHFQSmvU4HIt7ircJygaCAr9IcEqqasPIUERx6K/avrJfIy4hfuqbmGAz?=
 =?us-ascii?Q?BaU/x6gZrIR/+7s5JKMlTmQfj/1P35VU4Sgd59zqSc7WF794Y9EVg1NQdQtp?=
 =?us-ascii?Q?/TdDYHEWCk5d36VHLw4mu5oR6jOnZZV8u/OmUqeeWGpO7UVhQ+2lbvFByuUH?=
 =?us-ascii?Q?EtYYRHs4xGzGD8u/TQKAoJ9Kze5bruESewgojTjebPWdrBnQnbELCLGGtsm4?=
 =?us-ascii?Q?fb9vcMKaatwX4EvheptyMmBHFL7VVQbkV2ocmZnvo6VVOCiW826KvZLYML5f?=
 =?us-ascii?Q?NssjCgBxHKLJbqDnyISzhApKsu3aYBCQk2j504RpeJJBbtCeSDf5bvD3yRtm?=
 =?us-ascii?Q?1w5PWnc3ZWl9Iu0Dtd3Vv97M9YvuNRJ6yZMX6gWOWSbDXkC89EPFElBNHov5?=
 =?us-ascii?Q?W+NK61Ftc2VYsh7LP/dyR8UOuv1NmeYklhFJA/zU1Q5VGX628PpicQ7CaLc9?=
 =?us-ascii?Q?jLfxe3b9S1IKYySwaIGJlPamNbdtaZf45AuY5t0pu1EfRwy0pcsg+abLMRXy?=
 =?us-ascii?Q?BWhrRz7uVxzdhDvuXo7iefRncHelsh6yapUU4jqaNaTJsPhnFREOZlD5gdyV?=
 =?us-ascii?Q?cIeFs2nYZ65orHmL7a0rZpOmaNgrVPASvdic9M4rb8trAiqCoJyFmbiqdVL7?=
 =?us-ascii?Q?M7D56bRIutONhsJUN5m0XUYn5cdu8lREe5JvN3TXbUJIlByG2RWMMpni0DgR?=
 =?us-ascii?Q?7wfTIAvFgF1KEK2hVYlL1ZEjZTnIyNqvQbRVUT007TyBjCwcHcf6TX24mVdf?=
 =?us-ascii?Q?Jqu/fN2s30qx6WDvoF2s4GBLp6H/COCyrFoJKpvum1tQxvCHAaMLidWMwT9I?=
 =?us-ascii?Q?ODo2taRJt716R/dWzdaSaTa1eqxzLytvsZ+dPMtQHsfgcMOvIuCS6Ly2/3dB?=
 =?us-ascii?Q?2XN4tLXp8BLxvjQT0H3TGT+PRZI4CKNFHCQLuH43iUayJOFECc0o1dXGa3qG?=
 =?us-ascii?Q?jePVbOTiGhAZsMfw1J4FfAaovZg3YEHV1ML+NIG6b2+qreRLvdntG1dZpmiR?=
 =?us-ascii?Q?pXaObAFMWhtCrl4T1obTYdxSHqQdGFJqpHNXSQILu4auG+ZyUIaOdJ/Dwcfc?=
 =?us-ascii?Q?TlbZTVu3ch4aFyuQDkk6nDfnnirj3To190k24p6rdlVRs/XVk/VQPTSuKtlD?=
 =?us-ascii?Q?KZhnKFocnZirhCs9JbpQPfSDaicYgfI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d510cb47-b178-4a75-3c4f-08df3a950810
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:47.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+Ri/qvl6/hiG5x9bCQsef4Wcn03wj8ZybwQMGAenm6LDRYsDj4Q7gAcLm0z1d3J1c4aaxs8bBCjH/7PTVJ4iZBxCZ8afiiNOLPOH7wngVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR02MB9792
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

Commit 56a11a9b7580 ("hw/misc: imx6_ccm: Update PMU_MISC0 reset value")
updated the i.MX6 CCM model so U-Boot sees PMU_MISC0[REFTOP_VBGUP]
set after reset. The i.MX6UL CCM model still returns this bit clear,
causing U-Boot init_bandgap() to wait for a state that the model
never reaches.

Apply the same reset behavior to the i.MX6UL CCM model so U-Boot
can observe that the bandgap has stabilized.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
---

(no changes since v1)

 hw/misc/imx6ul_ccm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index f12ba6ebe2..53a704997d 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -592,7 +592,7 @@ static void imx6ul_ccm_reset(DeviceState *dev)
     s->analog[PMU_REG_3P0] = 0x00000F74;
     s->analog[PMU_REG_2P5] = 0x00001073;
     s->analog[PMU_REG_CORE] = 0x00482012;
-    s->analog[PMU_MISC0] = 0x04000000;
+    s->analog[PMU_MISC0] = 0x04000080;
     s->analog[PMU_MISC1] = 0x00000000;
     s->analog[PMU_MISC2] = 0x00272727;
     s->analog[PMU_LOWPWR_CTRL] = 0x00004009;
-- 
2.53.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C43606ECCA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=YFN1Aqta
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOet3-0003MF-Rq; Wed, 04 Nov 2026 12:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesH-000364-6g; Wed, 04 Nov 2026 12:34:13 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesE-0006Dv-Uc; Wed, 04 Nov 2026 12:34:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfL4u390LIY88209yR5tGYAQVNT03wWMZ8IMrjOcoKdhfhMNApYJ4sjv9U0nYdn9No6DlML/d3N65IbYS5Lk8LFXXubrWjDJ/rUxWp83vZoELhtvPBLrfAMaT3bOmBMCyXMHHyqE7eltAIA1c/Y6pl23/0Us+4ts6M8bZzCQBCpkkVQ/wsBLTlyQxd8LC09+40GTnz4hEE/nMyGp5/QAhja8ZLfVd3iQ1quWW4kum/88/rWlM7V4hhVeOFCJJzZsAbdwF8MpDe4MhAmMum8GYbp9XbC3whYChTO90LUd/jn+17wgXjC36gCWKMu6ba0NxCU809wxdz9oni/bTnWJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNPEfOlBQ47GglkdVZreStvMUwq76h1GEjju2KJGFts=;
 b=PJTphwX7IZ9ei9BmvkaT4pKLT1vI4kErPWxMGQGXVId+ggdOf2h5NitnuKxy6ha9LTx8tWJ7RnM9HfXWciCrWdA69tEZURmLErQyWeCh+QamTu6pxw3PFrM0XzD9UiFm0j2MpCxnTZHOldJQiXkdWNg6782FE8Gx7Fsn5AwSdXYBG/Jsbio7Eu0GRgUSHyQGorsw4ohFo6Ll7WpHhAfeiHcmfo0SXWo81maEOTomdFJxq5Li0yGftHW8yub4qg1rqoYVJUiQW4GASbA6mlBDMZ3V9jLtC6uMW2ni75HB7ULLA1AR5kYF/QjKApjtMdf3ZPzP0eQHH79qdbYC+N5NNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNPEfOlBQ47GglkdVZreStvMUwq76h1GEjju2KJGFts=;
 b=YFN1AqtamQc+jyAI9Razw+nWpcWWI70sEQsCYTDvKnz+VGsqvUC9Bc97qhEzSi9Sv/ZIbFhDuUmxMKhyJ/3Ygxv4v7nxymAJ3U8874ba+MTcC+S51362FUjCOA1rfyvoSrnvyGtyc/Xt174lcQfLJatujuvoGJpUXwAMOO0sJ0oxrjEvcUcOb+N6BaI7Cs91ljt1a6KmjohFJFHRzEzSp8jRvaM8s6kXDu+uOuiF/vwqtzl91w3xfVW8VNs79EYJYbWLb912XyFbWt3pm8YrgDhpARwPglziT5jCHoGbG23Ln0HRYsNo0cYU4PWqn8U7CHajyfLK8YnELKFxdqlQeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:33:56 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:33:56 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 06/17] target/ppc: Drop redundant e6500 L1 cache geometry
 bits
Date: Thu,  5 Nov 2026 01:33:09 +0800
Message-ID: <20261104173329.706635-7-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: d551a791-6fa3-4cfe-c7da-08df3a99cdc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: HCYMXPOJfGAxaASxg3f7cgL2/FDCLdTvfAbEnTBjACJL96kj+Y6sFGMeVxSYLhIuC1pgKWKoaXl0hXFyyCx8JXpo116OVdO687s4MNN+yEJWs7y4ZxjtMYmi0JS0i83lpCQNQDX81XDQX4t87srS1nBA7L/yYhoI77W+odz7mmYidKIB/D1RgkO4YvXGSH6KXpbFRxwSkmrNzgscPnKQC71DSfJPRvQ8NORUtirXjZgJaac1AS4Hcbf2VuT5F7ByzjJbV61hTNWKuwtWjJQ/9lwqChCVcC3RBaxUrCEpxc4ZlAT7GI5dQqhyeH0E2z9kp0WNUl1TBKmOjknHG0QDrB7C4F70PSNKPC0OmCXJxmw8mCLjOHexkQ5uuwUnqpdyRA1G6YDCb3rGoYpJ+hILTQpeYysX6kcX2x73CfrMadkIm3TZdevJwxtu082KFpwvvmQf/Oovdm/ZQ9gP4by3Km/t3SB2+KZUo7wAef7JKSrqZY1tuK/w2Req3vpbBW4fYe87QTxLw+/XDNWoqUYPmA0Gyrgpa1Nzoq33xMSdyY+h1uE9PfPlw2+AVNC72n2Qt5JkhVpL45mjCjl1XPmgyZnOc8PlPm0gWLK5I1GM58r0QhGhIrX6DhwbcPiqu3HvXzalkZMEsmOIT2Wu4uewdOVONBtA4bSMM5ju/5un+SM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5MpjHkaZMmmjaeceVcXYzs6tQYcsYl5qaqxX4EbAzQZ9mlJd0W5q9wUr+d2W?=
 =?us-ascii?Q?HEC+KFvu4etrr6bb2W9vcgUZfmY7doxqdfx0tibGeV0BHzeAr28HXlPGFn64?=
 =?us-ascii?Q?opLUkb8lAT6GRSIjTcIRECn7utVv3wI9hwr4luJjjJ6afLtWsQnLg827y0cn?=
 =?us-ascii?Q?1ZeOdDriHtIBQ7sC9i72obPx6WskwfmdL73cJUA1fYJV4mMHJcMRMk0ATI1g?=
 =?us-ascii?Q?Q2hiZwg+KXecFM/43eGLsBIxL2HgtCDZs/6G+perhRQLM6IOtfRsJ0jsvCYn?=
 =?us-ascii?Q?2kVVdsrkDPalqKfj6TANbG36k5Gr1GWkV2UgZcM+pOH8GD3S+Y2sKiq3Nel4?=
 =?us-ascii?Q?/N4GKuoYDIJ5ajkMIbRYMTKzSv15zxv2Sw4VzJX3U2sISK7+N+jLo/9qAxJs?=
 =?us-ascii?Q?YQDIPfEuqkDwufIVaEX5vsnwcgwoAqGb6+vBrezQZg7zOUD1r3Ca5Ps7kWU7?=
 =?us-ascii?Q?44DGudvHe1eiKevPOaTR93JoI4RpusJBc2BRYsP9s4gYjEqi1f5c1xX2w5TL?=
 =?us-ascii?Q?prAgFVTs7PBFJkqlgSJffkQJLaDsvjcZCHPU71pcdWKuZJnjPbGSo0KiTe3M?=
 =?us-ascii?Q?hFX7bQ1SOIVrDod+2zn6BuC+yG51vDd3m18yldcUIGSeHJt/iSmBi9CgnXCv?=
 =?us-ascii?Q?+jDVkEcxT+Nh8k6AsbFjWk/l1chf3qZKMH4ki8zEm4hnFD+4tvA+pxuT/gEK?=
 =?us-ascii?Q?eszvUHzSmTRkLU9n1YDRcXNSO210/HKFlnU//IUkNjQljRqEylJHB+YUstne?=
 =?us-ascii?Q?RSsr0doVVTfAbp247ezAbX+JcUSbJPwW1+Y+U5bCaKhlPdMzqR+o5qvqebe4?=
 =?us-ascii?Q?+0/K4DSXd0NkrT2ZZaAEEg6/2Z1lfCgWEjl4dHpZxf86rJfWfmPsKjC2UT+I?=
 =?us-ascii?Q?jYpI9S8v8ciyHblj0NyA019wEMUPmHUCGKPrWceaRqpqBWFobWsWNm3pzyI9?=
 =?us-ascii?Q?Ncr7TdSePEB9NQTiZ0O2Ez1wiPydHjzB2WXS2TyuzpNO+TLp+ka9yDjb5tE6?=
 =?us-ascii?Q?5aes3d1gbSbPZ8LQtX0pZUPs6AxKKC93RzgMA53ob+32RQ3i/Ibj3ggxysqg?=
 =?us-ascii?Q?6Va16S9vOrds6pN0MKScw4Tkivn6kiHOoGdsolWibYsLuEPVx6Ed9egs0HC3?=
 =?us-ascii?Q?ROMGLoVGXcMYdYddMmfw0Hc8Wi2KfvR/svwwhFbL6WdcPvWodey6DQUjJi4Z?=
 =?us-ascii?Q?fX3bUM8SaPL3/7g04AobF4r/39RzZP3RPp0g3z/3zCj3T/gHN82Dw0XSNhgk?=
 =?us-ascii?Q?nxTcxMaF/Aw9OK+3NY8v9KztChPThedlZu+h/yeuzK0G2KIeCM38X+h5OrWl?=
 =?us-ascii?Q?/7e/51qXlSOXj6yXx/qkg9Dwy5pBd6aZk771dCEJlwjRu2qlqXrqdytevHRX?=
 =?us-ascii?Q?sjzze0msNZMVkqqDH4l770i2oYGi1TfJv+cIltZUocDRiKT7bcjQavkO+dxO?=
 =?us-ascii?Q?+IQ/LKoh3ipXdKCvVGRbFgTVp3BlMSAxveNbAyY8MyQywHDsdKsT2qHbM+c2?=
 =?us-ascii?Q?nvuEX+ZJdFPGz1Mg7j67CAxQL8nGSWkordFHLqXYDkHUeMdMZeUjdG9dStC6?=
 =?us-ascii?Q?AsFFlAv7DQi2YHDp331WlRQGS+bl/qp/35coutunM2wcFZyfref9yHbn2KTE?=
 =?us-ascii?Q?wZq3r19QE08G5mH9TYLQO5CSpNwNLXFd8xmBzdt2YiWZTVLIHmqAIYShtcGz?=
 =?us-ascii?Q?27+ruQ725wOmV9nGkNiNItZkikloTYwbOr6fVg28g0JOm6Utn/RJjRlUY7pN?=
 =?us-ascii?Q?/sdqu2TNIpQ0FMKMvuAXp7nWrMRzNgg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d551a791-6fa3-4cfe-c7da-08df3a99cdc7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:33:56.7603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmOH4/KDGGc2sBXcxVCYxOkBHwAlDK+L+7mgrVfXHVvBg7CHT12mYiDjB2u7W+kzMPou0jrxzad48PvSnQnc0xjQIEueSqNe0klsa76CZ8U=
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

The shared L1CFG0 and L1CFG1 initializers already set 0x3820 for
eight ways and 32 KiB. The e6500 masks repeat those same bits.
Keep only the e6500-specific upper fields in the masks.

Reference: E6500RM (Rev.0), section 2.11.4 and 2.11.5
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

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



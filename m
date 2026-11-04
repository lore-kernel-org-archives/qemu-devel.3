Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF9F606A32E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=qETbaORR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOesN-00037L-E3; Wed, 04 Nov 2026 12:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOes3-00034Y-Ec; Wed, 04 Nov 2026 12:34:03 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOes1-0006Dv-Pa; Wed, 04 Nov 2026 12:33:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/8dFCcGEXpX1BokzrKAuBRmbAWb2z8Khhv0xW1IMUJx1ftafnQkmHuzpTquL7AxTEQHO64qT5Fan4MJJQsWvY6GGW/rh7WRQqd5ZKpuutviztiCl+fZ6Eug/iHqU9lAMiHO//QvR/+tHtYnv/QvN/TDV2OfqjDjiTvmYaEXKT85yrHnhOPUsfvA3HY8xIkmlWzCi/+VMjf/THr6/64uQ/xvvD0QgqNShH7J4MGNKwVLcLVhr304WU4+yT48atWJ6IoOmxVCjsT8ZicMDhEUeKIjQk0Zl50IG0kTMKcp5uEHz6qRsmQ11/qclqAajDFvcwlI7eRbQEN1ZjdZuLP6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PO0bseIOVy4IciLjsy+LcW5e5SFL0JtsWA2te/zcQ70=;
 b=zD5+0TnrhVZDx+xYtbg0uEO7SzGwzBAa+5Whyst2zwUZ1GNkYE6a2g+IbNeZu3fJe4rf577cpIGqEqlrft0LGSIHcz+4Ch/I7m3NlHEziRJ2h2TW29msZNmG0rZ+QtiLWLmABxmTHDTQi6vEC320We3LU3FkRZ/gDm+D7zZPT72IGDAR3zGw1Q7WBWoeDmuDFIQ6Py8OVH3Xcvvqlw7ADr27ykh6oFXEo+/RAX03nox2cVM3tbOrJBAfc4WkHuWpEhVzDfuG3rsYBbqmVvshPpu86LIimZtPeurkUIDXl2xEDViidPsxnkKUGJqfMmwZzs7rSQ56CtBZ+LWr1ntkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO0bseIOVy4IciLjsy+LcW5e5SFL0JtsWA2te/zcQ70=;
 b=qETbaORR7+/OG/hYe7o7QfcUSFgP0+xJLF5WlIKG3YZIOnPOYSq7TuTkL22SuCRaCmV910ENrJCutdU5PgBJm6aQA5h/DAUCe/cobFf+VijG0J57I4ygs7rrPJEP6Ya8TzcmgzrF1N/trGCknjWf+I2nyGFpWTNcc4BS9rzzhPSxL84Y37UygyUgg0GP7O39H9B+t+th0+eiRa9THW/BOYYsjsoGyNOs8diR/EeoM75Nks3kpX02mQJoY/QVbVasSbwNOFL81R26145zSOM9fhjcNIBG0yaFVaOEGlp9muGichGLAFVv8Bc1LykHHu/umoAJIvhgj2AEDXk79UjCUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:33:47 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:33:47 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 01/17] target/ppc: Correct PIR write access on e500 cores
Date: Thu,  5 Nov 2026 01:33:04 +0800
Message-ID: <20261104173329.706635-2-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4bfd0bb5-fb7a-42cf-333a-08df3a99c80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: Ad3SYVQtiuPG40greXKQ0hkVdctJmSf4z4zZBopJ+OxmKtZk9oRWlGeMF7kuXLwrwmcf63fnDq+VjeXcshl0Ls43n05tOtZRbfCDgBbM+suRTmjXKD3/DwM0+Dh3VzHzi+VNN8HOFBPEwXHxXqYe6ilZOfMyBlukhvBBmm47eHCWU8PJR9sCMLb8i/rSKDEwH0kUfKtDaQ4anbyMTQwjk4xT/m3/VQFN1ferf5qzq7RbYO9CiKnJuFenRdtH5kOy98CqppBwQ/ZVvcspTRK2TvearJpdMBDVNWFRj1hEJO6WbG8FaN02jSbpRNe6mMo9jDbaeAA04SW39XKlKoQPfC4BRank+ZyyNrkxZWABsc4rC485x7L/D8yGeTY6Ur7cZ0cgeqJHv9VTFN/vRqzW6SNg33ecnhtdACT96NMpFzqh/xUJ4z36riN0lAtg0cSXeHsoZy0KmIhG8V/EeOqDXQpuJI+AySLHVyKXP4XbrqNVYr1ZZj1IJK1v3gblamoN6fI2pnfU0AM6YUbrmvwmA9Qh6+0dKOBPd32QTof02Gw8s63U8qwdv76758SS9OUHj3MGVCaT0vQTsSkbNJNbVqeEYbys0EUPLLqFA9oYaOPZ5JWRQj1JNWms+3de6qvjVBUXSLhaiQO8r9O0CJfQuI/zQcWW5qZLKMkjBSQB25E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1gKBiB8ttzdeHfzs6vavc0eAQOB9AotkpPh94JayfGphdyh2YGKOkdyVwCuF?=
 =?us-ascii?Q?2YAXuZiZFQl6D/6WFjZ8dh3wZpHYUDXHcebn1vcPigUFqIug1zzPicBQJ8ke?=
 =?us-ascii?Q?dk9hVaIyozWe3UNTh8KZQvPOPUHorvOtK/oGH9yuug3WyaOaPhtY3aut92Hr?=
 =?us-ascii?Q?sos6/cOJhym7tJNczZ6g96yUb4R6yQ17A2+Ipdeq+lOXmkn7Is/ANIqMTXz3?=
 =?us-ascii?Q?f+dzJ6y7LHRGDvX5uowdcr8YGITPCbiac+AuGeCJOAIRJL27uBGJQyhLCsR4?=
 =?us-ascii?Q?eX8Wlp6dA/L6WRF2//T96iO5aiZFXv4JS6MObKPNKkQaYaKleiepRMP+74ya?=
 =?us-ascii?Q?c0PdOLZpc/ymK0ZuYIGPiYMMDrDXc89aCLLdDFY3p6mAShWJr0xhsJCf2GvZ?=
 =?us-ascii?Q?2/dyjyE9oJKAoc5nGmXoGw9FEVm0ILYMMtd7CnmfbEWpqB1Qf54mBJdKOLT1?=
 =?us-ascii?Q?Hb1Jg5aNf1GzEGa+u6XVDV+9mEtHgyNfdomZzTLHFgzUuvuuZ7miE9khN49s?=
 =?us-ascii?Q?SzdmxXLxN9kp4HP0J29cz6EX2XPOEjYfsJyzrcoKBJMoeWIDP/CzMebkY/X8?=
 =?us-ascii?Q?SGqw6DbL9WkPNtXlWKT5B9oFNH6JVTm4vcS0dJoIhPQ/7aTdeVcTo/060gtq?=
 =?us-ascii?Q?+a844uXAqcaDRnkwjm2PB9Nx2L584rQMiy1cQwe4JdrcAz1AmHYRd9QD6Hgb?=
 =?us-ascii?Q?GiijChx9RcgJ7iI7zStAiDPAoekosnWCgtVK6p68YTfEAXdcIYaUR7AExl2u?=
 =?us-ascii?Q?dn33nM+CVFA27sa+Tz8FQkyBdqzVn0eZgPcApQ7Sk+6Q1DX2r76jsA+D2R/S?=
 =?us-ascii?Q?tK7N36xFPQ8r9NUjU+DtjySOFagaxGWINcSMAraQIKC87JiaaLPZCAO7uqr7?=
 =?us-ascii?Q?i6ENgwPOZJTUPUmRz2utHDbFf0D0Xh/ycYqdyM8YkCd9Eo5/xp+PtNP6a6Hd?=
 =?us-ascii?Q?hh+LOvaFiN7SSoPwuKXji+2KguYXHV5G+014+E5W00mAWAkXT9bSuHCffqeq?=
 =?us-ascii?Q?I2L5xW4CYTQwTO+bzRb1nhRLfRT7Qz9//pNwcBtULGHihzAVVhQ028Qox32s?=
 =?us-ascii?Q?jrodYxHMCQyEEbYoi307zEHIAAsr6zdCSajdgACZmXgEXnHOijF1rxwM/2Vt?=
 =?us-ascii?Q?pPHftYK99SlS31qjiiiMoJmFJCkApFlpZuUP4LvEkSUJbAxrT/zqzyT1deHS?=
 =?us-ascii?Q?Vsc0hlmG4wjq9sqil2UTdpQ1ezLcamFFk1RWSwCe9DBV+4muJFcjjaHMmCvU?=
 =?us-ascii?Q?CRkG87FjjDUlfk/c7Zump17l/Us7LqnCN77RqOOXPLfVHpXMkTlhQaMQ51Xw?=
 =?us-ascii?Q?BDCpI+DVuwenGYpO4TfajNvCPJ0OBCfjt+AsK+pYGaZhqtd10sXoE24AI2zp?=
 =?us-ascii?Q?wmjLLQ2LlzWPVVkUffd2p1D+fhjeo7Vshdjwudy379t+QeMpoFBh/JXyMz94?=
 =?us-ascii?Q?ey7C+0M1UVElPiuSERieMnXD4B8lzn1zaCnA/Bp5q2RBFRRz6nbzGGrVvBIN?=
 =?us-ascii?Q?9cP+mCLPQvpGb5M5EMX5O9qFihsC3iZtXoGnjkcIhONj/qN075EYtaPci8pj?=
 =?us-ascii?Q?HEp8gNfgHh2Ec6fh85afahjv/06ZU21V0glTdjZL1t6+fFw/8M6WVm7Q9Ssc?=
 =?us-ascii?Q?tbyDUMuTko0EXXLmpN4FUKICkuRZOwAN6Hk7zO5J2IHR60Pqew8K3R+eohkD?=
 =?us-ascii?Q?MAX/R+zkH0q20REpAk0r3gDrSn5/SFybmIuLTdbe7dyAq2tr1WNTkudqHXj6?=
 =?us-ascii?Q?TAf78jNv3pids4CT6qX1Ei+dW4miTEA=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfd0bb5-fb7a-42cf-333a-08df3a99c80e
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:33:47.1504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PJYSfrxaK3hSs2zsVS3/XIry3EzVVFvbz2UXUxSuepZRp4zNSHaNVBzgE1HMEUdPIHB8rFVfkKTEv0xZ3Px262t2GkajMH6vlvKw7dnGWY=
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

The BookE PIR registration reuses the classic PowerPC 604 write
callback, which writes SPR 1023 and masks the value to four bits.
BookE PIR is SPR 286; on e500, SPR 1023 is SVR, so a PIR write can
corrupt SVR while leaving PIR unchanged.

The e500v1/e500v2 manual defines PIR as read-only. The e500mc, e5500
and e6500 manuals allow hypervisor software to write PIR after reset.
Reject writes on e500v1/e500v2 and use the generic 32-bit SPR write
callback on the other three cores to update the correct register
without the four-bit restriction.

Reference:
- E500CORERM (Rev.1), section 2.5.2
  https://www.nxp.com/docs/en/reference-manual/E500CORERM.pdf
- E500MCRM (Rev.3), section 2.9.7
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.9.7
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.9.8
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Fixes: 76a66253e5e4 ("Great PowerPC emulation code resynchronisation and improvments")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 target/ppc/cpu_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7f3036d903..9731bc0bfa 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2837,7 +2837,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
     /* Processor identification */
     spr_register(env, SPR_BOOKE_PIR, "PIR",
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_pir,
+                 &spr_read_generic,
+                 (version == fsl_e500v1 || version == fsl_e500v2) ?
+                     SPR_NOACCESS : &spr_write_generic32,
                  0x00000000);
 
     spr_register(env, SPR_BOOKE_SPEFSCR, "SPEFSCR",
-- 
2.53.0



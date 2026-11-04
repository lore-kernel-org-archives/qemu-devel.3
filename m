Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66052606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=DAPssptz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOd9z-0003Cv-OA; Wed, 04 Nov 2026 10:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9k-0002iB-ED
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 10:44:10 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOd9j-0001Gk-0k
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 10:44:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNyaPzJRM6Pd0mkSwSCN5gNe0ziDsB+M+Pru5Es1vO7b7y2611C6/uiI4CGICknTZUiafuIkEtK8hvxWeSP1u+q80NFz5iuUpdOqBl/+3uvcb1Bs1vde/yBvADv3GjSfebYSQdAnCHwkTjJ/0o+Hth9eBzZQ2sXlIB2sFlrcd44NvSXgIrZKkGAgJKjqbaQTUQWCZw3a5iV/9ykWagk8N/+5kFF7B0ZFHjKGHOpcpu/r7kUP1+BfWiym5+aAyt18lCuasjavHhG+HC0T3cVvwRUhk4faOWSt4s8S/xJnfKHfXsdeVqg71PdikfNK1R+N8RSmzqPFSTtVIMRCcx+lyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCHxWweQ8mZv+V4srjhPOvla1cTJ5Kc4V7vwVIA2pJY=;
 b=WBvh4XjrriRX0ISZu2FEd2zJZz+m5f4eWPtx6VPjAVRmf3o9Muv4nqfC1a4KJuz6zJiZBhS889KEOSwmpncL+f2bsKwRwq+o2v7WwS7twAp6fFRMSX1CEQEQWRKD7sj5Whb4SpPRmEachFlK1Ea76hcRADCtxeGQKaYkwRVNe4qryOZkhCvw6JR1ksrbOkx+5BQwmoVno+GzmuKe2FCXm5bYpbyUZzpmbFDQY9SJI/EDWTjPP7b6BiVWwBWkSE6CW7djz/FOcl9HRPJyhkp4eUZ7sdaMG3jVC2Sus9xHp7R8/nc1tGe5rA8WSgM2XUI+Cz8uLlHYi8hWx2Yo+xfJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCHxWweQ8mZv+V4srjhPOvla1cTJ5Kc4V7vwVIA2pJY=;
 b=DAPssptzv0OrcFeJJiFenPERsXb8+o1GCCKblNQL25xijF9Id3oKW6hBahAiG9TNQW1bJN/i/FjEFlDcqJmJ0Ubbo2MmbFFozAyT4hDoMKcOo7rUprYklVnZR49IrCq5bK21IYzqq5W9rw50QZqU134P7f46bqGJWIHSN6YBaZx9+zbmmDZWpJjJ9OvOI3+1xOEcbLL4jLwUV64XzbhdN74w3+Zou6Aw3z8mFsFdpQI4FoXSyfEiYvkVMMooj6bAjwAlrZUzvd4biA8eli9dAbwrxKb78C/tEsu5upPj+6Vq2ek+iUJTbqIrRtIve42RPGwAGZAMSSb6rpxmm8EGMA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEZPR02MB7162.apcprd02.prod.outlook.com (2603:1096:101:190::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 15:43:14 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:43:14 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 26/26] MAINTAINERS: Move Conor Dooley to PolarFire SoC
 reviewer
Date: Wed,  4 Nov 2026 23:41:53 +0800
Message-ID: <20261104154207.641511-27-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104154207.641511-1-bin.meng@processmission.com>
References: <20261104154207.641511-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEZPR02MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: cb40600a-eb9c-45cc-c124-08df3a8a5676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|261022105027099003|261021121427099003|261009223027099003|261021123027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: o/KBs5cpnLM5hpua5OS0emCpFjy9RgnPsthC6mOiJ/WbZLygaZ8rk4y4Tj0ufkRor0YQGH+wuWq7gO2o1XbUWQjDiQYqk3yFGUPkjnEIQjE4wyOwQzp+/aCfj/usKermupux+z4VOet2M0InsBQRZGcauGx1CA8w8WcYSYgOk6rX7x3NgZn+1ov0qunqycZ6z7o/i1auXSO7ZVNhmTiFUzXHm9abFbmrsJeaNUJuYvbz0+T9EIBJllkFBeJzqTiNF4xL9sTGcKbaEleArLA5CL2V5dXfxKEYRLlGbLSmLtOShbl+jFIm22uFOwUdX0ZAAtT2FPAXU0CvVBd020hxpL/1EqVnptB65AHkLBjcXvAJzhAXAwDIKNNXf8uDJ5hej1SebEQ/TszvBxFyj4/IYDbF8rlRB4c0HUddC7QqAHrucSEWyDs5mZ2JJKHdQ/9MOe7l0BG1fA7KKpBcEJtI+xikEWTwmSK+Ho6cnhaz6EgVAwGqRNd+6mNz05vXUx9zZ9+4yh4NO1AMe3PrcVYDaKSVUeOpne9PpNnt/zE9xcoIqYF/dGXMF8Y+68aQjBKmWWbakAJhsw7LXXDXnb5+UrPxnXkSx4eKKXCH97qf8DvmXdVzC804qWxKdUvdV9w2gJmheyMLvLk40jdtzITD7965bcv+sNUCIIyjUUv+yH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(261022105027099003)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xZvEjIg8jjQjHtYzIY7GPSfg0G8C8JcEh6mhb1wlUUEh4hwR7lQxSYDKXKyW?=
 =?us-ascii?Q?qjqu3J1+PlRWeZUHrndcjOTmbdq+PdyuyQu/B73IhlbBm4FxCjcBCyaevbzs?=
 =?us-ascii?Q?4T3e2YdY2QYDz4Mtrc01Qdw5RuoGoaJemJNs4DioLaBRZNq0vVlkXjgLtIEL?=
 =?us-ascii?Q?YJJPouE1B4OLdnV+q3+2pq0qg8vxjQKUSbpQARL6XofZjY4HNBcRXQTwQTDW?=
 =?us-ascii?Q?6Acd9LfhIDWK5DVG77OAo6gEl2jnKFkCgtTcVlOJNbdnQQVXDj+U1hrl/0vq?=
 =?us-ascii?Q?ArovULqGYYDG8omWRfT/2vzkyFIDIB1uaOll4vAoOd9GH4ahfC1IEzqfRgr/?=
 =?us-ascii?Q?ssv32P1ti+D1b9SBT+HvZeFC+9tGifJObadTHwWIXMYUopz/DnnpzUjA5q3E?=
 =?us-ascii?Q?KemL/NIpdgXtVqnwGs2xSvgsOzOiy7gjRuLGmgzAoCKm/sMNEq8WKXj51Rtd?=
 =?us-ascii?Q?EbEOA6aD5Ay73pMBzPFGLxcb/rHcmsxR8sDoxNC4aCLZn5TQOIl+TVG3MJbv?=
 =?us-ascii?Q?lND3aCxFRqyAiL+Yqj07H9ugQLGYHETFWEdR9ZvI0xER9sjor2h4zfQuEn3Z?=
 =?us-ascii?Q?P697IrAAgkY6VoKfiacBWym0ed4T3ywsUf1fUwcVu+Z5BDnpkcELNk69hdDB?=
 =?us-ascii?Q?SKzUE+uQy7zk8pJdVKpfy+LwAHsVrtZT0zN3syoqaTnq4hIJphRcwv+yXyEZ?=
 =?us-ascii?Q?FIedCIyjdqFjTCoOPdnKukIikjr4Xt3DFCjdfAD81Dt1YTfbYr/3jW062zWd?=
 =?us-ascii?Q?jKTUDz0EJLktSVY5HAXwjIXghB5vnEIUzoBuBHzwvHxkgWmj3Yesc/jFmCNW?=
 =?us-ascii?Q?kKW+GsTDpREB0Rv8+YK1MBRDbbJnJobFn40fpBSO7FmCzy36m/HnPX75IABY?=
 =?us-ascii?Q?popEUKgsfjKF2Zbsqbb4Es2TmqEIyDwKnMibqFqYiY/5aUeKtAG+SYss4yfD?=
 =?us-ascii?Q?D5kkNaCPzJRIL7bgG0/9oUz67HHHvUDR/s2JhNxszT+heBqS0xyB2fMB6RLw?=
 =?us-ascii?Q?1Rjh1Z7WFjkY9DTh33Ut7Bq3pw+uN9ykjr+dR01nMB9ndZXGzojLahkaq5SA?=
 =?us-ascii?Q?52k46gBOJQtp0Ys0j5pFc1K+kmujvzS7KkxZQkrAUcPZxcNRaryhag6cWI5S?=
 =?us-ascii?Q?0OZYmYATVhzsJTG/7MSqfKZF+m1wnsQJdEfvF8bDFF9pm5gKGOK4UWORbGDz?=
 =?us-ascii?Q?l2npujXEVt+x0wbvp8hdeeM/XkYwCe5/HANOBm3RY9pLVqYfqCvTYRmaSB/Y?=
 =?us-ascii?Q?oVXxxpRgJQTMfsla2vGp1ESXgVEmc9Y/jVb4McW/9i7ZX1AVmImsi3C2TEgN?=
 =?us-ascii?Q?nN3362t+7jz2F68hrVZ+NqMstyx7IUY9gvhKMhK+uclS42iIS0gC/KJnnTE0?=
 =?us-ascii?Q?Llr3+yM91i192uIGMobHXPCPwogwJTMXoqp1Sf0ooUsUjqF1J8mt7vCqi7ZA?=
 =?us-ascii?Q?szXc+f+MMvbHOxIj62GJjcK+KR4yh0h3JPMKnCiIGSqVdd2/M3Wpq+uem0X6?=
 =?us-ascii?Q?XvP8A5CVYcq1YlFLPWRDHhRo2GLSuT/RHFjPNf7bHGwE3c02cyHW6k5OsWST?=
 =?us-ascii?Q?2Bb4IUyZHTqxlaSEvj9NBAEb9vQZXy//BfSRYK1tzroEvH3S4VFNbErtDni/?=
 =?us-ascii?Q?mNnk5x9LXxuBzTTinV5pa/EvBG1DT/sufssddGvhVv0WJyJP3RekcMldFb9Y?=
 =?us-ascii?Q?wXoQE2jQzZUCYxLIFz2AdmPDdRjUU89iozlijjFvEYsYb90QmUxeAm5zUYoZ?=
 =?us-ascii?Q?1tA9UwZdIcYedp3sHj55plPALYBKdvg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb40600a-eb9c-45cc-c124-08df3a8a5676
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:43:14.1538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6ZeLKbdVPxcv71EoGFfrKlK2PCeVe1/GS0+CuUU3LztTqJaJdcXGctpgWYXWJpcMyTSdxnsYy7V+vi9QHSs2DNDzbAJ0+Z7EcdM9USPkPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7162
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

Conor asked not to be listed as a maintainer, since that could imply
that Microchip sponsors his work on the platform.

Keep him listed as a reviewer so he continues to receive relevant
patches without suggesting an active maintenance commitment.

Suggested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Acked-by: Conor Dooley <conor@kernel.org>


---

(no changes since v2)

Changes in v2:
- New

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e50ebbe5d2..54bf840cef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1818,8 +1818,8 @@ F: tests/tcg/riscv64/test-crc32.S
 
 Microchip PolarFire SoC Icicle Kit
 M: Bin Meng <bin.meng@processmission.com>
-M: Conor Dooley <conor@kernel.org>
 M: Sebastian Huber <sebastian.huber@embedded-brains.de>
+R: Conor Dooley <conor@kernel.org>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
-- 
2.53.0



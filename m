Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C75606A32A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=DuVftRd0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ1cg-0000by-2X; Sun, 08 Nov 2026 07:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1b7-0007Aq-PH; Sun, 08 Nov 2026 07:02:09 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xQ1b5-0000hv-HX; Sun, 08 Nov 2026 07:02:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVLauxqxUG7J7JId879U1VMVUlIdNnn5kWibL8K8uboImKoj1govxl6gK1BJKAUAd3KQi+OraZGMWA9IP455D4m5zJlvyme8AbyhwHZHpNfYg4HY9NQWAkARTaR4LD3ktFBVcaQyajWy2IHulb8ROROy2opZSk+hlVtvy069qbtuxrGscx/YEMrMQ1Dyy6cs5cmix8Fb3+HZq+zlDaGNBbR/sprt2IlKVYZTVXwKPS47H2df3pCjKAtZTBPNHFoJPaxeg5LP5IHtIpUSCzDPi6GfYCC5PYiCypuJWTXrd0YXomDD/y2fqolXj9KTcNaA4+SY3kExzNPQuM9Cf7WY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2BnlVfCdxjhd2/HsMAmvzQmFrukBTJWSa8GDAnIkCw=;
 b=RbI2CiCD4oRjchsGNkhYv3t8YjcCI5DSbZQnSawyuClcOgB5JN88pHpomPqvGxxSujGgVT3cExBm/PFrlqJB0ddn7asf+AmQnwNQ6nSFELv+Ml3lZiK1pyKmaAnTZPRiX4JiFN0u+8g8YtTKFIMH+RN3Fl5c4txKei8KgWU7QkZBgdL6xDUkcwU2L6JTvc5jYs3Pbf7n4huGoGg1jDjp8KnLmz7HXms2Nmx4BrSoheQ3aLKGiDKkjrHRTtZQAdEWvEcSKPeZJjn6stS4kMae0F0bAjqwuAoN5L9HCxKF9SE9uib7PVWtrDIe575EBWwuRfT9pGrzD/upACc4Fo77UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2BnlVfCdxjhd2/HsMAmvzQmFrukBTJWSa8GDAnIkCw=;
 b=DuVftRd0yArDZg3cNmORobrVdO3HP8lTKyDe0eEP1DgIIfixq5geCA5gRrQMpvKmramoWHw10O1gxMR2o9itUYxdAe+TGcpPf2lsThMXryuL8hefqrhuE1BY7WhQo6ij5bDLrUFA0BI7Z6FcgnNZJb1nu1d8jHq9tDxbdpdOr6yUjC+98U7v9S1Z8sDYsrQJjBNPvkE27Ic4Pq5w3nncEjK1bkVQYMcnu7D4TlZ5f7OlOmNiLt9ogRVJEDHv1RMmbb3fzGvUJcJlWDTdqyopXBHRc2NhmqNHjhAH1Kq9t7RRcld6kI6WKafOMbfPAjAxWajShM1d3CVPLjQ0paPNLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com (2603:1096:820:116::10)
 by SEZPR02MB6945.apcprd02.prod.outlook.com (2603:1096:101:19b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 12:01:53 +0000
Received: from KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c]) by KL1PR02MB7144.apcprd02.prod.outlook.com
 ([fe80::18f7:ed72:e33:ea5c%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 12:01:53 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 22/23] target/ppc: Keep embedded processor control within
 32 bits
Date: Sun,  8 Nov 2026 20:00:21 +0800
Message-ID: <20261108120034.1755008-23-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: db1e9281-1a8f-424f-183f-08df3d901434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|261026121527099003|261102123227099003|56012099006|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 9rniCApyXCtbmvlx0FGwkVbXdpVX5qI6VvxG1QYmHyW1BkomDRH0kQIV+B/9cgwtZ1DlHrh6ZTMRjgpNd+Vz80snaZ203qzfGE1/cMURsnX9ZWE126RMs0jsbOf15kcl8RfhcsVKvfCtwzBAEc3Hmua4kTZozhUFk3a5lehpzGuchinycZtI/yM+xrOQ7ThIUt3b8DKiA52GuFoV+zmKsxWxHNZ0Sbo0T5dTkYIeyBB29iZFWMrV8EdqLbtrvldPqeNd73rSHs7QRAXfb0G6oK8XlFmT69ZV4Pb77+H2YLb9TpTIGigksY2CvNdwL7HQ/p7G/BNK2z1xrC1LwJa0FjEux92KiDCOj8oFqmypItDhQl8exEXM4cqWJ3p3iZyg3HDotIto0H/jI2PcN5h2Z1AdQjbQj4xuQkZxgalOR3KZJ0BgoWZn6tePZAyR6kHW7BC5gS3uFkTUPHaXawyVWAaitMT0X2iHtgznpA4gIXanzP+4U2x+0jYgLm1pZRPXJFGJ96pxzTwGZgH7Kjji7Zwa7ExLsRjyRHjR1bGAQVN7tlP1AOvLy3tn5pxZZOWSUoEntKMhEl89FyPeUu6aIav13NrBKGsd4iswnK1vXIhBIiwkmB82R/Ra/0JZap3+sKhDeLyNU+YIOfn/ReFuzKMk7+U/deH4gJq5llvrIbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB7144.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(261026121527099003)(261102123227099003)(56012099006)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FwOxvhKHvxJ/SGvp3vwccuGwFiRQqHHSkf0iCi/C6OyhuQ7+09Gbb31Xlhca?=
 =?us-ascii?Q?2KeZrjkoU9XhU3jILRBEfKZZwoCEdVtEf3ea+p0mF35QraZTK8bVg9fVio6L?=
 =?us-ascii?Q?LYwsobetMPkF1IHrZoUWyGARyo6tHPLnnREoQBLxocZ5Pmf5FgbGLQOoXAqO?=
 =?us-ascii?Q?gb7ea/YzjE5E3Fw5Wo6Fwu2QYqheeuKTeBgazFSnMxPGGnVCxLbQhm3gZbMN?=
 =?us-ascii?Q?oAoymU5gV5IQNqVYr0hmxiRSN4icLfoA9u1GKQTK8w1D3AkUg/TZPezA8aCi?=
 =?us-ascii?Q?KGXMbRA9VFxtVaprvM3FqMc/9GHNi1SyV4Sqe1zzlGZV46YoaVHxPRDfZPKG?=
 =?us-ascii?Q?g1kFqoHbrx0I43P9r6TaZUwpcJzaK3WQDL6aSIakZ5YFFCGqPMgtEOBTqkCQ?=
 =?us-ascii?Q?QGR31tcilJeCsagxiDWwefE/cFrdv/v5pNcUuIUU860lVvCv0xU46IKNNboA?=
 =?us-ascii?Q?AI+Dcrj9jPSrcZoy2nzzWkbIqqRdaqMpYlZWfAQTTqU6BxMPQ3JBYymHXa0s?=
 =?us-ascii?Q?AvLDO2+RCFoZSV6anuGVO0ZU1gZwZqWV3saG0Pbc0uv4jb0XT1ufbpj+gb/8?=
 =?us-ascii?Q?cqW+Fr3YAyfY02vTmJ/b66J6KFdNerTxURuIJuT9blOCSaDp7gpUTpfuh627?=
 =?us-ascii?Q?DA/mVvSKUfQVzn/94QAhB/WJtYuzGaXkx/euQkPNpf8r4ch43hV1jl+jIywC?=
 =?us-ascii?Q?O/UhFINXYvWr1W/RhjwZAQSb4V3d0kAKmWOYyNUaZlQ5fjJ2XpJ/JFQ/IqT3?=
 =?us-ascii?Q?HFcCO8xllrTM9ZQiXSOOx0UNAJSzIYzfb8maZ5RyM70L9ah22jKz1+tVmtmL?=
 =?us-ascii?Q?h9H0FecVW0Z2QGgoCS0Foj12DsP8LTqSRGm0HcB9HWgOrcoF1qY26XvJk87E?=
 =?us-ascii?Q?finyGuCfYuObX2ygembdmQVujKO9Cbfd9YYYda52x7KQp/VHR+Ih0iUdgLQn?=
 =?us-ascii?Q?GUsD+zVmvwOwhxwFE+DfBpwDurNSuYDph1vf9VEFALrJUcKhe9NbbnN13udJ?=
 =?us-ascii?Q?LpDO6axUbzbEL/Dd7dUSXRCOP6biJTu9Pg4niu6jn5WmmeQLVRvY7QL/0Ewo?=
 =?us-ascii?Q?w6S6Pj7gjk+oK4bpcCRiNHSQnDL2ssRRdstp+M8CsYawEcFDIkCwQDzb0QxV?=
 =?us-ascii?Q?yvHqhuyrnxKdpNbJBcxW2wPP7ph7KoUmX0OgF+Y+2rTedPSvI0V8LLZ9S9i2?=
 =?us-ascii?Q?y6cu1FAOKQVIN54WtAwN+w4kikNVyLmjXRzRRq/2VChQbf8P7qIzoON7nvYm?=
 =?us-ascii?Q?RbCPkw9RPmF6rKcXyvarLibmHFy/V5cMw0z8swsSWtP7WgsV+AVcEvmlysgs?=
 =?us-ascii?Q?oAPJHlmphRozCC8a0kKPf3tzFNBwb7jr83WThhWeznqIPpXtRXHQYBCMFINa?=
 =?us-ascii?Q?NgHWhRlpIS+Pckw40Eiu7MkjhG+E4rWPw5t02BaNWVC+CALXLTOYfEOMUgR6?=
 =?us-ascii?Q?buCkw1+087Dl5Bvnv13XX7BZyl1jE00KO2RCUzxKLhgglYiEq7+Sw8KziXjo?=
 =?us-ascii?Q?cwSaBd5iS22+idkS2cq330dg/fPPd1kLpCtPTwWObuYvSubMIPhTd7Q6H7Uj?=
 =?us-ascii?Q?rEsuVHg7fS37q0dZhrOi72qNM/z9nE/f1YPXXmbOPnLA1pK33n+vGmANCpIz?=
 =?us-ascii?Q?brnptB28NkpAY00T56eDJgGwwmhuHTnSiNidJ/10P3yn7Ii0eHD0YpItaLqf?=
 =?us-ascii?Q?b9T0QkOB6GWO8F0lShM8k2QMnQvmDDcl8wdhsL2LfjNdhyj7KpAhv+V8KgUi?=
 =?us-ascii?Q?lYML77EuXNTsKwzBMDiXrGco2mQl72w=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1e9281-1a8f-424f-183f-08df3d901434
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB7144.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 12:01:53.5206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOmKgAW7Vxe8KgrU5/qvFw4XTXTOcgmUFztXEeM3VFeOuKmPfPtJJ9g6QqYiuRNwVKvnBXEoZa6nyfXFtwm8YygBmVg1i7U9CejGhEwoRQA=
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

EPCR is a 32-bit register documented in EREF section 4.6.3.

Fixes: b81ccf8ae7f1 ("PPC: Add e5500 CPU target")
Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- New

 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b522702e2e..a2da7c509d 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -3030,7 +3030,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
     if ((version == fsl_e5500) || (version == fsl_e6500)) {
         spr_register(env, SPR_BOOKE_EPCR, "EPCR",
                      SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, &spr_write_generic,
+                     &spr_read_generic, &spr_write_generic32,
                      0x00000000);
         spr_register(env, SPR_BOOKE_MAS7_MAS3, "MAS7_MAS3",
                      SPR_NOACCESS, SPR_NOACCESS,
-- 
2.53.0



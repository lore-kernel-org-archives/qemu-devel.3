Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ED2D185F8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqGx-0002ZU-Ve; Thu, 08 Jan 2026 08:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGv-0002Xb-MJ; Thu, 08 Jan 2026 08:41:53 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGt-0005qf-Rn; Thu, 08 Jan 2026 08:41:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjI9LsatUORgd818LnqRjziQ8XGW5h3kxBwhYbkIfHj2YRWa8YITU+Zs/NYQXm81kxGpnX3wpRGSfbo/4JtpwBzSuYMj/6/hRaY16sybBr1BeRh8fRQfCgLpshn9eICpUHR64G9JnQLFWihFO9DQolgzrs/f863bsldmsJ1R1JV0eEc7tvEm+leWjkUjlsOQSQYV1xN5psDif3j2WphS+2lPVY0tfvx3E9F96rN6ZjoOJBPaJ12m7mMayhO8r3bHyrQt74LOgyUcOLRdvoqrHEXacvmJ+Md00Y0CQB42UBFwF6fJMa1IikAaXcc7JveJ+oZR/o4kPrPpeUuHUVVQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YL1Ks+I+yk7kdIr10J0Am221FLTfv4q5XmvafPUklzc=;
 b=nteQxHOPZZIkshTQbtMa66hvQ7+MBIL/iEThsKQOF/eQ0e4FhOxt9MLXL6H2cVGA5Ev7P2LGY1CR8vhtoqt9lx5W59ELJ9gFI2EJYwTOiYv8e/cmS1qyje65pek5AGlzGXN9qvw0AlKBjfrl2mE2Kt5+S82YsLlvMRGG0N43FkZDZEvPldP4zcI7xa+Rr+Iox/5vUuL80BBHsoHOUGlETm7R/8JTdjjC1Q5ASv+JT56LEKiUMXcXFRxKmEOENa31VwspKelgCILcP4g00MVgqHBR5e8PlRYsxgCvvgnhbbDXMlObxu+GTV1avXobA2PfkbAAvpKriIEZJf3cODO0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL1Ks+I+yk7kdIr10J0Am221FLTfv4q5XmvafPUklzc=;
 b=IGi0hBOMhCnw6R5EazqWy3a2yERISaJ51DuL2N5VGRLuQv0YilbZsqu/dv8n01F4oi3QXk5ad2/tCvWwYn0wpzRW3+hodbjxLfy1EFFsOW39XH3WaYWCLpXY2uxEkVs7/0hvQAufb54lY6yX8sp1y4Pnw2hKI0S7P0XoYcSceAa80ctiXkqPz3bjF8BQcyy2s8aQWYCRsOx2sQsL7+cDbaAAL5BKFFcjASkLIofc6rjExIdPY9EeYGtvvlUVQiR1o9j6ag9T+WmYtCYQo4hwnr62B5Q1/kEIXegNI0x3emn25HArXNeHtfezZ+OM6uSI0QrySPNlQLcu4BT5Au0U/w==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:38 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:37 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v16 05/12] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v16 05/12] target/riscv: Add mips.pref instruction
Thread-Index: AQHcgKSDbOjWjYq4vE+U9lDWfCWqnw==
Date: Thu, 8 Jan 2026 13:41:37 +0000
Message-ID: <20260108134128.2218102-6-djordje.todorovic@htecgroup.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM8PR09MB5226:EE_
x-ms-office365-filtering-correlation-id: 4afe588a-d226-4a2c-be9a-08de4ebba5b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nU2Syifjuq1ghEyHVngVENQWICwlfNMTb+88yGWTlB4/I53dryCmmnvmPf?=
 =?iso-8859-1?Q?LIS4nojD6DQ1Fg93PRMB36bSX+H/Dln9KzcNBkHK8aXwTYB0fGvfpY296h?=
 =?iso-8859-1?Q?F7e0UM1N0i13fmMVdcK4SjY+9EIeezMpRLiTl7RA7h/Qfh1L8Uu6FG2u3F?=
 =?iso-8859-1?Q?XaGpSR+cczg9Q/c9cCqA/vlor8l1jWDIxk0o40j7JklBhxQGp/CfCWcoEO?=
 =?iso-8859-1?Q?ouslCL9Q36T/E6ArFpIp/Al2fEBOZKdw4Ql9JB9PBxFuHZQ3VG3kYPKPBi?=
 =?iso-8859-1?Q?SluwzlnCc8QnHQHVRYFFTzGEqcQMmwb4J0TwruAIwC9wWruZ1IkSE+NyoZ?=
 =?iso-8859-1?Q?mxMmmNKACsh3cgKbhFljm7ekseCPjdjcxGn/XBzbYY+CUJRazat6R5/Pav?=
 =?iso-8859-1?Q?trsj+MWRPjxD3L9S4LF9qiy8/wxTvxjVQphczSNQ6axtT4fJfhELZT+Yp2?=
 =?iso-8859-1?Q?kdpSGTDowLa/GJnSikORVu5R5FcnzOWZIJ/yMLrD/oucdY739asqSM1W47?=
 =?iso-8859-1?Q?Dc2cnVMtvWY6V4qZI906ZXbC9Gj2yrUyA3W3rL+jJ/zLo2CD64cH/oHQTL?=
 =?iso-8859-1?Q?xQOL2hqelRMXXVMejBeCIltJb7UL6keWtuzgYYnD7xOGVV1REKeLhE4XXo?=
 =?iso-8859-1?Q?rBuXqSStrgrqtX96iZ7X0wLhVeK0J4WgZS5lrSUMRmapO03vTy4YCBuse/?=
 =?iso-8859-1?Q?Svb3K7md0Te1pX9JZRST3Lj0RchHhXhrQqWJc0pPaprGqWCG9AxYMlzKu6?=
 =?iso-8859-1?Q?q0cZguFXorXJMFQf4os2h660B82OA79cFCveX8vDw1pDqlOnD3bXDWhEv0?=
 =?iso-8859-1?Q?KU+2usDSMytkDDmgDUhwVU3WRssKFflXdhFQh1SkU0vo1seo1K61jt9BPv?=
 =?iso-8859-1?Q?oXNBgo5IEv63FXcU+NvejsM4/YVzorZEbXAPfQxgBqLy6vkn8DnEAOEaF4?=
 =?iso-8859-1?Q?OeH+10jewwSa7u+7RJ/Mdt9qPpTheIFfI23AQUL5SWZJNCHEGzb+hEIsid?=
 =?iso-8859-1?Q?121FjLb1VeL4OxS3GmDBZleW5wnZaVuHSnFbtQkoEzSKnVCq8cOrHU10Ou?=
 =?iso-8859-1?Q?KCR50IsmQ6Wmm65JKK+wJGBwC0PEbOAnXxpGV+teeUeMzicX1yAurUzCGP?=
 =?iso-8859-1?Q?ZrAuTF8HLARqylFxH8XLIs+JBOxsMLUSKipgRG5u/noXvh44yFnxXSk4mK?=
 =?iso-8859-1?Q?YshdevJ9XBaqrAyAah1WRsQEwMCVL7Ym2kBO18Iaxa6a75N9RDj9xSd4QJ?=
 =?iso-8859-1?Q?r4wIpqMiQ+XPIXJS8atPBKXdfhl9y6hsV0/gKFwhsUb+/ZyJihNCihlLez?=
 =?iso-8859-1?Q?Ephez5Eg9cc1b7NCmo6fOo83x1qKtyKkJE6M39BF6Oq9skjF2sryaXBaj/?=
 =?iso-8859-1?Q?DsALRyWywBbcXRttfltlNrd4w7GxaMQRNgUq+kL/TMhIPdTtQcKor3UjKN?=
 =?iso-8859-1?Q?r6iWPDD9odeHu8fTfdOhi0Lx2RHXIWtM6aMR7HVI1+uRtcjggeuPXNY5U2?=
 =?iso-8859-1?Q?vaRivVc2Mbrr5LtBdR3YH+hUfk1+lDfkit1gW153gxskVOfzsTe0YO3y6/?=
 =?iso-8859-1?Q?xWFrGKm5chdXCDM+PeounnpjF95V?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p5dLKf4+Ngd30nhMo42v+nvybpXbwAHTh0MxEId2Oqx7O3mmuMPqqkh+SR?=
 =?iso-8859-1?Q?qLpZ5jhpAz8cWI8tr8GlCvrayGRL2cJ22RHTQind1GTFNLYQMOvANoXv5K?=
 =?iso-8859-1?Q?LsTZ3oGs54U0cmguYOtfjfUOWSHj13sjJobxVnLZfuOZ6O3TXKm4PvxF32?=
 =?iso-8859-1?Q?Z4jwmWa3YeqV5tkJhJLW1zLqpp4z36FEPvCOByZJz1BamuYjmO9w7SGJgw?=
 =?iso-8859-1?Q?nK7biyJWd+FikrRSuGFG6P+LGIx3dDWEqvLv30nZPOXmicq2Y4Mdy9NiQm?=
 =?iso-8859-1?Q?pIM1BME3QbtZJtBQbJxBHzzVLapTz4vBYYrixXarHHqfvZDyhKkzVXFt8N?=
 =?iso-8859-1?Q?t3OEnYZ6A36BdQEcgFZvkHiQakRl+6ifpH//L65zOVYUop4pPFIy4s5+5z?=
 =?iso-8859-1?Q?FJs93nmUDrPuSyp21tz5Am03kaCRNdPjQf/yCKlcPpDtZC7rcLOV2pTjSw?=
 =?iso-8859-1?Q?nn3oKOCj++8euvZvyquS0PmgPJ63XEUGd9Suo1AXuTwYj+4BnFensRm4Lt?=
 =?iso-8859-1?Q?PGFCdQP1B38tvV64Y63gr/yoNPZSyDmAWe6+CEYQxMliyGaKe5OlpfoCBT?=
 =?iso-8859-1?Q?HQtLx+Y3JeNJ58YGiFbOu1b80WXcykoUBDOlFWQkqo8f5LJR0suicaApwE?=
 =?iso-8859-1?Q?KYyJe1nWgzxXccGuhqei0QDOowXqhHObi6/cai9nx3A0EZGvzDnxoNfpfl?=
 =?iso-8859-1?Q?E7lMtFyy+KCvnaWSbQ/Y4Rk2kWE7TCpff+TW11bl90HNJyerI4hkf5w4XG?=
 =?iso-8859-1?Q?4uO7SMaHabqAXhvEBfbku3p7hEtctxa5cfX8HBcNEqdsr3e8Yf0WdncwAS?=
 =?iso-8859-1?Q?dHK6KrYtvCtOIkgJRt6yceU8/ieUO/5lcxA+YABFni6WP6lgbpZt82Xt4J?=
 =?iso-8859-1?Q?xPXew4fMPPt+Ccl4pyYCiKm8IS3ZOr6C75W16/ke7B5hffM37uUQS91O1F?=
 =?iso-8859-1?Q?Exf+3F4PmqhRJdwfdpRCROWNx01r7xtcKmi7GmOmkgAnG7cLS01x0t4JKO?=
 =?iso-8859-1?Q?EauW14SO8ISctZdqK9/t4sra1IxabV97aRcnmh05HdKcmOEMq1vLK3Syfq?=
 =?iso-8859-1?Q?GYDm6S6C8D2eD5gU1iuLeByp5XREdQdlMKChk60RmmD7gUTwsOgvXZ7ZLO?=
 =?iso-8859-1?Q?cFzCmDJfXxv/U+z3X7/RFD06ZBpzEF0o7jKajk2xNpe4zlPNKUQ2PPresZ?=
 =?iso-8859-1?Q?r9cEqR8bJaJC6d8qCYDgBK3nidBNb3rgwTmgGxFdkTO6K12w8539ZGlhxq?=
 =?iso-8859-1?Q?9keAsYH39B9xb4usFOYIVSh+qouR6DkB/1UnLMavIU9dZ8+ohfmhk4RR03?=
 =?iso-8859-1?Q?QTU7sb3D6NeflEY3Bz5XmxnOvh8k8in6KqC42QiUT24TC+LqZVNOS2Pw9h?=
 =?iso-8859-1?Q?j59g/TOtkg5+sNlN5LO1VQWVK8KI3rdVP06FuPalqn1qmqMhxbpr/Smqvx?=
 =?iso-8859-1?Q?w/hugTSMAnVUgyoAfA35IU/ov8Z1QL2ZB6E41Ah8EQJp642Er65VVNwYZ4?=
 =?iso-8859-1?Q?GJvU+JIAfYlnaKnKkVAhXJ3di61xCnBRY9AzbW7X88N0qQPQ0zEnod3trN?=
 =?iso-8859-1?Q?W4SfIIJc8mbH7u+xVtnP/4etO1baABgR/sjpMpVR7zfOqQzq1bRyz1b0SZ?=
 =?iso-8859-1?Q?qMju3iUpKHJ70N1/RrlhymL1CpnVhvCWUVTQkvlF9I8jB3+iEHJcqoc0oe?=
 =?iso-8859-1?Q?4EnytqtWJRlOchfYK4Ktehw1j7VNSTnnMrZBYHrcxX7T+S+klPWmbVe26X?=
 =?iso-8859-1?Q?F4kH9vRLfFiQJFUB68zZt/SGSzIxhOpGGZ1oXtxzi+8khv1hQC0+KmSfm/?=
 =?iso-8859-1?Q?uQAX0dPUOo6L1vKtAvBVGITrvtVZTpAM8IYcDGUd/xOJGEuGle2e?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afe588a-d226-4a2c-be9a-08de4ebba5b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:37.7433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVwuik6XwKlHzVGT2ktWPteeBbKgda86bzpJCOOKzgspmbOcEcj5wdHMLB7PI7E/wNqsD67k3cj4HXbHUPBUb2TlV75PkFrzYWHXgeAh1fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5226
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 15 +++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b4fbcc2f5f..08c345a493 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1383,6 +1384,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3336,6 +3338,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..e4d5039c49 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index e842d46805..7dab84fc07 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 3202fd9cc0..bfe9046153 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -9,6 +9,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -31,3 +37,12 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+/* Move data from memory into cache. */
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index fadcb78470..4215813b32 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1


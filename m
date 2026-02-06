Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C48EEB28C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETq-0003bm-H0; Fri, 06 Feb 2026 00:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETo-0003bF-W7; Fri, 06 Feb 2026 00:34:09 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETm-0007WD-8r; Fri, 06 Feb 2026 00:34:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2OkjoFfHkj+xoe3L1QIShiNF+YgP7KYx4U+o3d0osiWVtHbghypzWYNgl4rHYChlLkAOSAQOJ6KlS56OsawqGi1fGcS4BQHB/SbyhG6ggVH4yip/TUpAMJWTn1CIOS/7qYisY3kjMvuUM6+EcN+eep1NcC6sw4IVBHLvB6bvc6IkR/5hAEX1/etyjBCDYA03aeEKfqVtucuDkSSKbN8QMoK+8M9cJEjWwyXgYCXaOR3OBWHWdA0uuhYdxE1nlIdPaj+v3FlntAuS3/FSOY6NN4hC8Rjfd5HqrBEKCxz8iBwNLJcVwERH5VWkjwTsqmhmX3DOOlEdd4UwouEum+JWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5Y6eSvTJlgN5CaHK6+Rhtq/RPBQMAqs0HoP6vjwolA=;
 b=v3Zi/4Hu+8zUaCGxawqKapXx5IgH/pz4MOV2HAAHQ12/q0haP4zrHx0GhlQy0cs9LaUB2D6hgpVPR4DVf8c6Q+T1TvnqeB3Ki/vX67MVHu+44QUzd2PO6zkPk90DtaaT6/Qs7qOVZiOhmUY7hVO+kMgYyB3oUPbHGdsqzJkTTaB/5ggtelsdHWpte8N535eN0Obs9jLeSqzMCeg99D6FUqTUplVyvP+8JNSHfxKKFZnbHX3SnsY6weorGJqJ6TMpLlpzqY3cF4A3QC8lgLwRjPxN+HLZGW3Ze0giHP0eAWT92jT7lgIeEdme1cDgUYrTzekEVxbxYWAISEG2xNl8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5Y6eSvTJlgN5CaHK6+Rhtq/RPBQMAqs0HoP6vjwolA=;
 b=GvN64lL14ILV/plJ7VpLqxZ4wNgNjRXsiMdWe/43cZism1ZFV9PqHm3dcJi955lIGB3p30gX65THbdmEZnP5fNgX7pfda5gfcSbqlTnmyB734lXgaLyheYUd6EL//8Y4oY88cnU5sCaERXPJcA2Wk4zMVROYxFSc8njoecdqHu95K5Q+iFXLcCZommxxH124MwhkzexKy75Y8CRYExAxGIlMeg2H1OlKNkwYqJJOppTul5nEs0xJI0OuMXWQKzzoE+0uLmKn/PyyUIiw//Rj/TbPdcRcS0BDgCDJa40Q9qrI/SiPMvv2K9WEB9p0MK3xeiOmt7nsB7FRqAPLVgL9iQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI6PR06MB7165.apcprd06.prod.outlook.com (2603:1096:4:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:53 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v1 09/10] hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC machine
 to A2 SoC
Thread-Topic: [PATCH v1 09/10] hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC
 machine to A2 SoC
Thread-Index: AQHclyouwD6aanSPIEaw828nuwlkKw==
Date: Fri, 6 Feb 2026 05:33:53 +0000
Message-ID: <20260206053340.3716041-11-jamin_lin@aspeedtech.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI6PR06MB7165:EE_
x-ms-office365-filtering-correlation-id: 1822b7c1-7667-4a47-28c5-08de654150e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?n30hhFIzCOQ0p6PBHw2ryX8OoNIr2xvmQwiaaxwyJ2Kpb0cVzo4zeMuJZB?=
 =?iso-8859-1?Q?hhzEsBevKOSVWSNaceYZ5iYmX1art/pWLgT8X1m0x6XDYhZn9gsagyC6P9?=
 =?iso-8859-1?Q?oaSEXazaVCKwrfnEF6+CL6e8RZ8+YFj9cQNHdCRPIqfuEn6x/rIorRUEZw?=
 =?iso-8859-1?Q?bvphOigHZh1W3CPy+kxC88eMaxLDBIsZvHejTO0AtgADBUrSHPIMlG0wUv?=
 =?iso-8859-1?Q?8npaos0xnms4WGyNPt7NezUMzNPpvZASXMsrO+7bftpSFy2CKIMB/Zs1du?=
 =?iso-8859-1?Q?IIMG+Ntk4QafotjpBVjezN3fr3RfWMHlQsbMmhaRkWT5Zn4ok5fmFus6sc?=
 =?iso-8859-1?Q?mkidpdLaSND5vMJp4T+2xWtCTuQjP3VFAsQx5Q4S3byo1McQPKF+Gs4A7g?=
 =?iso-8859-1?Q?aH9cBWqDhnLpFWMBNkahOiFciuLZKDqq5EVYnOatKTWIiLnLN5eX/WuFNi?=
 =?iso-8859-1?Q?ho25nPYgzmM9UB+JtfpnXQvRufQr9l4tDONpC0m6Ezi9Ecdj2qMQfgTxI0?=
 =?iso-8859-1?Q?Ba5FiC7Z9hLbTVASMLiS9qenqr2ZsSAXQSt9XO4Kw51AoC1gprRvD4YcZz?=
 =?iso-8859-1?Q?8V2j0LQ7PP7wB49vGy+H1U6QddCz4CdRJmah83aNjFl9h9FsAiBYemldbY?=
 =?iso-8859-1?Q?xqIFwjqdX8RiH4FPeLXKsYCYBGOdoSIwvBQ1UeNAViTxOZ4JdZNP7hMWg2?=
 =?iso-8859-1?Q?vlaG6ZteUwLtlfjeLVUQz3IvZcn1JSySxykScFEdAcrn2IE241LGWtH/FM?=
 =?iso-8859-1?Q?PndUCj6vmPXzIRxyZ+9S6sy7Yhqfq/frsyIj5ORN6PZr/B1E/C88p1yufc?=
 =?iso-8859-1?Q?aUGgNfFfOxY40I/bMZB+hj/K1P+osjgK/S0WG2RPs0tjNHp+nH/dKR2MFJ?=
 =?iso-8859-1?Q?kH8v+pHClsaPIgI9ZI1NuKX0Y4LgbPp2oBKGOfUBNOxxNHhhXVsZGzX0J4?=
 =?iso-8859-1?Q?kV3r0mVz2uHt7B+xoj5rjfWWGD2pc63Sn1eplyLH9wdO612TCS1ReshOw5?=
 =?iso-8859-1?Q?TOv1QTcbGrD1xMbupLren1Bilzq3TGZSo8x1VEtut5UnR4CPhrTmz/smBP?=
 =?iso-8859-1?Q?BODqaFRfLcqlQ4SY0IwIbQOARUa78HJ/ptlYikRFZg6Mxf5qbB1dkX29ft?=
 =?iso-8859-1?Q?3+A8AZtDBKToieL1PBAy6AKtwYY8wO17FcdPzZmLAL3ATAImpTKQ2OeBvG?=
 =?iso-8859-1?Q?8VDtndJN0UvyVjb6cuBFuG1RZB59wtAPoU5YAXicANgkHtOHVxREZ6i0Jm?=
 =?iso-8859-1?Q?socpugttgfr1gPS2cHYM3kZvsv8rHZdTowWxA1kbBjzaXgRIGt5MGsnFnU?=
 =?iso-8859-1?Q?5MfQT7Uo48mbDvlnlhUklj/2J2KAx56/oRdouAuDbs9thtWNCpErB03rug?=
 =?iso-8859-1?Q?OhDhD/hSxaJnWBGKcLkTAmNdPzDv1Q8hz2PhLykKLhY8RbeuRfPmVNtbJO?=
 =?iso-8859-1?Q?ELo+9LUk1czenhBl6YHRWGXu3v1gcBnOUn/QMhMRXVqLid3/WQ3BB8zO5V?=
 =?iso-8859-1?Q?QAz+Jy5e9WDGWtuKTNZnJ4pFs90ZCbL4fpH5VhEB+JVmu94iyT794yWrmJ?=
 =?iso-8859-1?Q?ReeaIZ+0nJujBUGiiumFEjvf6CaP/+i+nQIhSzFys/F3hxyxf3c0NTaP0c?=
 =?iso-8859-1?Q?NSCN7QnFaEFFH+N8dUUd1nW5qAycIVcRUmPz9MZz5gNFekuHi3ypr/jx8r?=
 =?iso-8859-1?Q?eLOwl9rhsjOOwXgQgHIRhM7rcCGhmM+8b2tiv5/2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TlxfiHaDE4+aOZ7IkniPsXENXuFi/tZpIaLOMLPYl3ytr8IFieiUWhzht4?=
 =?iso-8859-1?Q?CZmr4DstoQWPNA3+iNlDyDquvDUn4wbXRsEpv+i5xTU8ExDltBptYgg452?=
 =?iso-8859-1?Q?3u3L3aBTosTTN/E0D+qz38yiqMPOeMMgpr7/v8Pah9iZ44KwG+LRmEzr/U?=
 =?iso-8859-1?Q?gp2PGRW3An2n9pSt7pINH4/AVKBKY2ggp33UTr5zeXIURirJoZPiQqOGO2?=
 =?iso-8859-1?Q?vgyVR0yFzje9c4JIWggI8z0TYjSsSLF1UIZpCCECE+Js5KSoWA6xZCvnkh?=
 =?iso-8859-1?Q?tCxao2S4Sh2x7QFVT+0gD27NfewNUclF98AZ+9E1tulYV0zyCIPaxRSqSf?=
 =?iso-8859-1?Q?TSqed7Rr4DrNP5IhxTWzETAAHxScACrtIry6wggsjZ1nJrVkAZWAZRGIUv?=
 =?iso-8859-1?Q?yeG/l3qnPxbbjiwXB07+PeSpuRgYgdGc2GATa4uWHs2JxQhH2bf9rJoj7P?=
 =?iso-8859-1?Q?76u8VnV3u1vaLoUoeoSrXnEdXB6jMrRiez77Ju23XvtZ5PL4wdeK32bphV?=
 =?iso-8859-1?Q?uo4OA4gAMLFqFWKGh5JFKuA9p6sw/kCkrGlZ0BQdgMqIYfoPHoOPH9Y0tn?=
 =?iso-8859-1?Q?W7Yxy9gwiePzflUtjSbeuNgwlBXSUplOPM6r6ACaUSoEkjaYoyylNkGxYG?=
 =?iso-8859-1?Q?/HwvVczsDvr+dfKwlOlxOFdZCRMp43jrx31IWH2vJD4+QIP+0HuPJnJ+ut?=
 =?iso-8859-1?Q?4egoEF6Q7cMBM8w9rmIZyHSa13VrI7F1oUa2eqqaHHj/SLumddmsB0tUtZ?=
 =?iso-8859-1?Q?yKE/X1TH29ys2qZP4R6V34aJcnAb3jj2d4XN7u42lH9RNyO8exASpUya+p?=
 =?iso-8859-1?Q?tBfuLEgQL/ViC4ngqdCrAuGHDxzKOKK1w6G9PfO2eMOf8fBjQJbcHFF5b+?=
 =?iso-8859-1?Q?REgxd8HzxQQhZjVHku4QKQdS9GyXz7VBdsGqYqO4JX7Ou8V9LZmCNzKgBj?=
 =?iso-8859-1?Q?Q5WPeCGl/MZJrleIFrnXqEJeNNIr7I9LpzVE/Q8ErO+2ESXT5w0zBf/gWm?=
 =?iso-8859-1?Q?+TEXMienX94OL+j3Li7DQCBMv+5hnW4tgr44XS97wDruLfFIWtskNEdqKl?=
 =?iso-8859-1?Q?XoQFAWDlV1mWVVhs8rZTYc5wF89m8vRiAt3r0SNjjS6qDilxB5Sc3JXQYK?=
 =?iso-8859-1?Q?P5uIEXc+GuMsi1Hg9d/PIH9GC7K+Q6i7vqvI72r1HOEDBSLI9Rn4J7yk/U?=
 =?iso-8859-1?Q?O41SRHhiR+5swHFivgBgLXPWIOf4IWlvL/P0cBrT3OUE/P+QOTD/uQfJc/?=
 =?iso-8859-1?Q?Do83OCNl8/m+tLSJS9l7C5ZJCJEfcB1i4mExjCVAsGBkFEIUsPKNm5Swcx?=
 =?iso-8859-1?Q?eaW+XqlMVq/0N4Gu2cFvdzSZPd2aTM20iI6mJFoI6UvPpogbcCsbGKQTMP?=
 =?iso-8859-1?Q?hLUsVDUwH0EOmLs14yEOSbkiwCNkkBv1FRBmdH/oyq//yS8SNcBZMVzWn+?=
 =?iso-8859-1?Q?BuaWZEOKiLzCReT0Bd5tO71oEC52NQTHyCDk0J9UKWYTkw1MbVLRcZMefp?=
 =?iso-8859-1?Q?CQ+42P+ttweuek4jRmTEsrg88Ei39NBhWg2XlKoEwfQEDnWxlZNZdgEDF8?=
 =?iso-8859-1?Q?k4aXKIERXZH1tvaIMip8+8dchWDjRKJcSEYiDWk0+a8fi9zqMoU8tHE6yZ?=
 =?iso-8859-1?Q?1Gpphxj8rT2Q8Srn/QB+XSbnES68fGs9vMyrz6TCU8fiDwKA13hlWuHSLj?=
 =?iso-8859-1?Q?T4SJzlVF9salxvbFSyf+AN0JX7PWj4CVMFeElBljyGgAz1msXfPR6kp1Xl?=
 =?iso-8859-1?Q?NOOK3OWAX1elOLaUnaEifpIyxTa/T+WMGYlb+LYJ+jc9il1ZGfDKA/e9Ey?=
 =?iso-8859-1?Q?whmJn3wlXw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1822b7c1-7667-4a47-28c5-08de654150e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:53.7363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5/v/40/1QfORN4Ob3tIiS/OTBlJD/9P7KfeOKC4X+xpWC6s92Rf2IZzBvW70lx8XWTZrc8ZV7tRb72hPqBcmgMyvxnaJ/Ta/Qf1YZXl++w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7165
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Update the AST2700 FC machine to use the AST2700 A2 SoC model instead of=0A=
the A1-specific variant.=0A=
=0A=
This change removes A1-specific naming and definitions from the FC=0A=
machine and aligns it with the newer AST2700 A2 silicon.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-fc.c | 15 +++++++--------=0A=
 1 file changed, 7 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 0502a137f3..5eb6680da9 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -24,8 +24,8 @@=0A=
 #include "hw/arm/aspeed_coprocessor.h"=0A=
 #include "hw/arm/machines-qom.h"=0A=
 =0A=
-#define TYPE_AST2700A1FC MACHINE_TYPE_NAME("ast2700fc")=0A=
-OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700A1FC);=0A=
+#define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);=0A=
 =0A=
 static struct arm_boot_info ast2700fc_board_info =3D {=0A=
     .board_id =3D -1, /* device-tree-only board */=0A=
@@ -48,8 +48,7 @@ struct Ast2700FCState {=0A=
     Aspeed27x0CoprocessorState tsp;=0A=
 };=0A=
 =0A=
-#define AST2700FC_BMC_RAM_SIZE (1 * GiB)=0A=
-#define AST2700FC_CM4_DRAM_SIZE (32 * MiB)=0A=
+#define AST2700FC_BMC_RAM_SIZE (2 * GiB)=0A=
 =0A=
 #define AST2700FC_HW_STRAP1 0x000000C0=0A=
 #define AST2700FC_HW_STRAP2 0x00000003=0A=
@@ -58,7 +57,7 @@ struct Ast2700FCState {=0A=
 =0A=
 static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700A1FC(machine);=0A=
+    Ast2700FCState *s =3D AST2700FC(machine);=0A=
     AspeedSoCState *soc;=0A=
     AspeedSoCClass *sc;=0A=
     const char *bios_name =3D NULL;=0A=
@@ -66,7 +65,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, Er=
ror **errp)=0A=
     DeviceState *dev =3D NULL;=0A=
     uint64_t rom_size;=0A=
 =0A=
-    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");=0A=
+    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a2");=0A=
     soc =3D ASPEED_SOC(&s->ca35);=0A=
     sc =3D ASPEED_SOC_GET_CLASS(soc);=0A=
 =0A=
@@ -135,7 +134,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, =
Error **errp)=0A=
 =0A=
 static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700A1FC(machine);=0A=
+    Ast2700FCState *s =3D AST2700FC(machine);=0A=
     AspeedSoCState *psp =3D ASPEED_SOC(&s->ca35);=0A=
 =0A=
     s->ssp_sysclk =3D clock_new(OBJECT(s), "SSP_SYSCLK");=0A=
@@ -167,7 +166,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, E=
rror **errp)=0A=
 =0A=
 static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)=0A=
 {=0A=
-    Ast2700FCState *s =3D AST2700A1FC(machine);=0A=
+    Ast2700FCState *s =3D AST2700FC(machine);=0A=
     AspeedSoCState *psp =3D ASPEED_SOC(&s->ca35);=0A=
 =0A=
     s->tsp_sysclk =3D clock_new(OBJECT(s), "TSP_SYSCLK");=0A=
-- =0A=
2.43.0=0A=


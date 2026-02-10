Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A413EA3F05
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1V-0003Ei-Q4; Tue, 10 Feb 2026 00:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1J-00035t-KG; Tue, 10 Feb 2026 00:10:41 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1G-0000Hj-Lb; Tue, 10 Feb 2026 00:10:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBocnLDxX8HA613VzXWKQ0t4SH1a832OJrT2qIyciUA9KSvIpNKbd4173iQLY/X3EIRDOAq9H8agKwX/50SHPt0x/Gm4NXOHkQenbJcq59/a3T7+d+6JLKh5LJh7cI2pSZlQdrTXstsLXyk4rUmxTk4L2/j2lY6/PxIls9LZpffAzNy6TjMBmPfyW2jmJw10g3fOpfACnMQ59fIbAaDzuajc+YLdcauDMg37A5Cr8mHVdNOFCNkx3I72AS53OD5BSbNkp3YLnxy6aFofSR5WvJtHQI/kVSoTPk5/Xu3bdvqwyOe7kSs44ELORzVIoVsczKO+7GSSWP2ReaVXmTNPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLpHf4yHZ1XdyPa+M19Dh9ZH3SlD+iAizYTpcK7m1Ik=;
 b=OxJICYU/TmbNUUPhggqXUw6b7Z+MLAVC4DEwnnOaAJiVxl/L4NeBe9RPGM3ygo0SkKndGg8KAxikpLahNRH6QVWaQAG6pTXZzaWJjdCQup/cV6J9jAo+hlyHN4aolZuunif7OnQo9VvlDZePDF+rmRpZQolf6W3cvQFCqvyif4qn5qeEUlvD0ntWm2F4jdj0gkmeBsRJwlaT10YkLFGnpnjJApdpiJOvnkQcUTPcyDvmo4rlMV7NyBz99lslNBHqEgyROaE8lexfVJEDUZPeSkrPvg9dWGmnS9gnZLMKegB6geQJxoBgg4MTlETmJ/pTj+nGnKSb5R/DLVrLB77jbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLpHf4yHZ1XdyPa+M19Dh9ZH3SlD+iAizYTpcK7m1Ik=;
 b=fE4Nh4qbL+XeqnClizgbA9Ug02cC5xwLBbCGcyaoY22P/GIsarq9Q62dyr9xMP68jvq8wEgUKE6nNIB0sHGJu+359WeRU0OroNll2ghNt15JVtr0X7HLJ0v9vfQMPzDbFS6YhkygghX2FVBKJuniH3dwiyK272LzcxH0h7C9dOTmUGLnHnbcfFVqeXxiK2hNbLhtH7NGYnysDjHypunatwTYogGVJTM8hlQzOC3C8G4TLnBbKX7rakcza/y4ilEKzL4WJ6JU/CB7HUeTqdDkY23SyGmu5JitS2PZJrUNBAqr57JBGpmSJ5TBoLH9qlnx7Rumz/O8grODW8O87mt6xA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY1PPF9851F8D71.apcprd06.prod.outlook.com (2603:1096:408::91f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 05:10:17 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:17 +0000
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
Subject: [PATCH v2 07/11] tests/functional/aarch64/test_aspeed_ast2700: Rename
 AST2700 A1 test to reduce test runtime
Thread-Topic: [PATCH v2 07/11] tests/functional/aarch64/test_aspeed_ast2700:
 Rename AST2700 A1 test to reduce test runtime
Thread-Index: AQHcmkuMK9Z4YnyIDESZCi/+BOrQ9A==
Date: Tue, 10 Feb 2026 05:10:17 +0000
Message-ID: <20260210051008.355149-8-jamin_lin@aspeedtech.com>
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY1PPF9851F8D71:EE_
x-ms-office365-filtering-correlation-id: ceecd058-8864-42c4-3d2d-08de6862ae81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?91cluF1ikCeuRuDF+tcOmv+yruUYwHAHIhIJ+yC6ppGYA71Ya0b9zXEd29?=
 =?iso-8859-1?Q?CsCz8eIs5ogGqXDzmgNYBRgfbECrOn6abB1YPrFyiQ1g6u0q/0EYnYhkX7?=
 =?iso-8859-1?Q?NuElywQLTNVPWPcZq5nS6P6mlIR1siuQCD6A9YTbaMYHQlrvaAmorx5//a?=
 =?iso-8859-1?Q?+dFVeP3i3BDbpBf8FKh9TXknD1SwqfPEhH4unLNK55jaIISlDbd3UEc0X9?=
 =?iso-8859-1?Q?RMSOOGHK2M/XUxrHQIGCiyvMSRGv+OWZtyRMIocHtssgUr54GKSUGSnQTw?=
 =?iso-8859-1?Q?i4AJJ/mZQgM8gHj2YgGJYA045dwHv3dLm4izBfBAPI5m9pJ48EInVqsu1+?=
 =?iso-8859-1?Q?jE54kYRURBfdJ+6Eal7JpPdPCrOskNkRvlEAeK6LIosyySfgQOGwfhw0M0?=
 =?iso-8859-1?Q?qFtdj15nw//k/hRdPRp0Sg9AQOwssSCDnZqIvRm1KgLKuiefOGOgDw5/s+?=
 =?iso-8859-1?Q?pvMIkZ5eZp/0IkZ0h8rENr3theEONSl9SiyifGC/wQ5tM72H5hzKCVQLvW?=
 =?iso-8859-1?Q?O6zz1aRF2Q+GULazavCrMlXwa82ufstyB8P6P6NCM0FTPtiOnRCMIGWy8S?=
 =?iso-8859-1?Q?+vAXXiJxP4AsvubAdhZIWfqHpGnSgLL3FStfjGnNcfBpDz4sk4MLGkafak?=
 =?iso-8859-1?Q?B7kwPPngXo/s9hqSY5eEXTADoqwyMGRs5cxfvx64mqz6UjyBIMVwMP895w?=
 =?iso-8859-1?Q?t/e8iu69XYvxw4UwInpaLt0hFu1xgfPuur8Qg1o9VUNbGyLd47kylg1J5+?=
 =?iso-8859-1?Q?paSLZlFP2bnfMVUqZ28c5wBEp1Rgek1ZKAmQ5ZgoBS3/cmUdwOzC/XX1K5?=
 =?iso-8859-1?Q?N10acFvGNGsRmoszEH2yaFk92PdvHT0EFX4WVYP28vL6h3zlYru90ksVJC?=
 =?iso-8859-1?Q?E0t5sFsEBLZjMpCoiEURdxsey1fzOsQz1QtM+9SgIMc/o68oWmlaogHpdj?=
 =?iso-8859-1?Q?h/fNGRHep2zMkW4qEUcSnkL8asX4XAo8pw6pvEcY1jR/fXR52IXauZ7p6c?=
 =?iso-8859-1?Q?RHDXmLdt6B0P3H76RWfAsjL/OVmOkyOKlIUIBPy2hymnWF7NKmY2gdSnV2?=
 =?iso-8859-1?Q?17QE/WsIZOt4WlKsRdqPZnWzlfdDiGi7N0a17/3Et4wqAryWVoq6ttlQ4F?=
 =?iso-8859-1?Q?7KjypeyltB8W0bJCIgDuqbGm+JfABVuftDiRlA9u21wRcrd290ROakXo23?=
 =?iso-8859-1?Q?Hs6T546Cxhyt/itkAGMYsi4xWkjHXtekmDtxcaAhlR5jXq6XH4+rZp7JpH?=
 =?iso-8859-1?Q?slgWNGrf8ulDiF9tRhae3zBErffdAXHxoEX8HqGjc/0v6GeGNKjJ+r91va?=
 =?iso-8859-1?Q?b+2z7GzHW4ExITIV7u5cuRk/vC3uHA6CgFvL6Mtfp3/CZnuWg3CllQbzjI?=
 =?iso-8859-1?Q?gkP6EaDewc0rkokhrs43n78hMI0TOX511gLLzSlJwrTDv46K46ikUUx4XA?=
 =?iso-8859-1?Q?nVS+AI1R3AK8Q1qDs2MhgskqMGGSjswNpp+GQmTFqWTLmemiD8rkCye5bF?=
 =?iso-8859-1?Q?aEIqN55843eolTM2ilGJX2pkMZe2DgY9Fjvy5CHXOIITNvD1/kLtEJn8L4?=
 =?iso-8859-1?Q?pAYbQyZXbiKGXuNV7FMYBhMahuTZYjGbkGAZdDTvEDaPJEU7RsMXtSRZbi?=
 =?iso-8859-1?Q?vVwuMf/ghF1ypqfXeYgaMraolL3VBby7n4jHDvmC3QlkrytLhVPqWCTc4/?=
 =?iso-8859-1?Q?keDImMp8nb078kOskvsAoDIkGP8H7SQUNOqZLlYg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bEebs+iyMjfQHYlC5dnM/jPcoX1AkQLpVGjoxUV4biLMT83YUiYWMvNY/e?=
 =?iso-8859-1?Q?M8Bfuv6k5MjWzGSQwEZSMySd9LLTKsEV5D/+NbuvjckKQQZaSPvbsjss+C?=
 =?iso-8859-1?Q?5QHXl+IkaGxvJn8p+QS6OATpMw2cKvLqQ+eg6EHLUyDzeJQrTmCgb7XSVe?=
 =?iso-8859-1?Q?IEk7JqXSvx+uFGdAJvjyjRn1ylKSPrFhfgESC16r703L/vmlzPb4bWXmVa?=
 =?iso-8859-1?Q?zCFopM9xLpD68WpZf2QQ7HxNu93cr8TcgA/iikyLIGBoL9J9RxjgEWx9c9?=
 =?iso-8859-1?Q?RU6llkWsgjYi9XLxHzW9oT0iYFMLzqpyml4yKc6CZrixtVWUjrB+JWxji+?=
 =?iso-8859-1?Q?86gX5oaWiqby08Bf2PjREhU3cegroKn+ENFi9YzBBmYwmaV0EuFR54Fhyt?=
 =?iso-8859-1?Q?LBRY+4A1vftE0bZ4nuiPSFew1VPMsWdn2T/cVYeSpWP6VWLluqHvFLgHBe?=
 =?iso-8859-1?Q?tT8epTODJB1ap12eXoBmuZGzPOciqAczSePoKviggfJk+hUi0I1WM51kkA?=
 =?iso-8859-1?Q?5io1MxVGEzQyifTzo8t4IKQDeujdTZlv8H5Dzmp8vtsxAqHlQc314I5sM3?=
 =?iso-8859-1?Q?NFRQ4g67/E1bMBBpKV49/1r5bRzbiF5h2+OSseHQcl4hp7TCprhzJP6Y21?=
 =?iso-8859-1?Q?nMiJYhj/988LMwEpzBO5YKNhWPRpOkZKp/YJJ6HDqVGj5QW8VqKHBEQ/b/?=
 =?iso-8859-1?Q?Y+RW31iWrVaVGUmXhpsx7huAyPhbs+dx9Z1Cbh3DFrS65nclXGBcOgtIAu?=
 =?iso-8859-1?Q?4BnUDPnfSvFFTHfaqkjbIkoeJYxC57OMiKr/qOYqcW8Vv3toVGVWcSFU55?=
 =?iso-8859-1?Q?ivxpAPU012JTEd791wiJMRq4HWEJ4QwK7VmM3Z1qWbnm9D9VxYctdfWDkt?=
 =?iso-8859-1?Q?4qPoxMPk6m0btdxjqVk5v70Klo93SbotOmVxykpnj1mPYoWSArzMapJ9VY?=
 =?iso-8859-1?Q?eI2+bSDSveRKa4XqVJjhJ/Ij+Y6C00L2Dojq85odu/RIRouvxaduwpUB8m?=
 =?iso-8859-1?Q?LwegAqHpH8pteoivj1uZ15QsGOYgB5l6DG28s8m74S9K9sW98XYQ8PSTf3?=
 =?iso-8859-1?Q?oHydxthev8GKK1fgfmC+xB+gywYRSYUFBwHkf97HM0aQXMbP+UyktqA+5B?=
 =?iso-8859-1?Q?5zPbw7JvuG9w43CuqReD6/K/Z1czEb0hO6/GmIuQAY13eZNfnvd2gVAZgK?=
 =?iso-8859-1?Q?iL/zXRZLDnWhf7f7tsK71/upxbtK/NuQltOq5GS69El/qOzVAHK4ngSpWD?=
 =?iso-8859-1?Q?7/wbG3D1LHJ7NnT3JGkCc6Ls5iBJDX/laEp+OgyXHSruCZEMqu7UTd/cI8?=
 =?iso-8859-1?Q?guVFTbZy34yeLbOTxIRDvd93qfI2Lk9dyidJKOghDVrE7M2t7aai48v61N?=
 =?iso-8859-1?Q?vanjgboyMMBejuvLfuqxGh4KTNnqxSDIXn9i5WZfGb7kE5/8A/vF5CCT7I?=
 =?iso-8859-1?Q?vPQ/HIQ3npCeYRKCWwfeBpWddYirJ+LJg23nOyhJULh+T4musimMFxqbQR?=
 =?iso-8859-1?Q?SXh5QovB5+tfW7lXQ+yAoz6TzHIRWeLuqV6WTYoleTnMvF4pF8U2X452Gn?=
 =?iso-8859-1?Q?RDcXHaSzTz3QNnjX7uoYtd2st5Y0vgWCrsZg4Y5QZUIzaG9ybhfGAClaBn?=
 =?iso-8859-1?Q?l/iV4Ue53nBUU7/TZ5llhAoB15QY9hU3TsxPmHbpLsd0gqXy9sD+yoYxCu?=
 =?iso-8859-1?Q?qGGNLIIK4uohILyu+RNyCj4Evg+CpEB+R1vYfyv/3kAOVlN4JY02xJmcDF?=
 =?iso-8859-1?Q?/gwGMmm/R/WIYavylf2LBATfz8EE2CqS0wW5Z/igzYwBP54lAnQiQ26p76?=
 =?iso-8859-1?Q?h1e1P76NbQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceecd058-8864-42c4-3d2d-08de6862ae81
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:17.6956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDgoTCnsZQKnjnS4+fB1/EsrBRYj7KHmqw17Jz8k4obf+wGlyRUfTOPv5frhGRKzntWvq9zk21jXl+bUtj25M+0BqkwEeAfmlaOV1SW2jI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF9851F8D71
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adding additional test cases to test_aspeed_ast2700.py makes the test=0A=
suite significantly larger and increases the overall test runtime.=0A=
=0A=
To keep testing efficient and better scoped, rename the existing test=0A=
to test_aspeed_ast2700a1.py and dedicate it to AST2700 A1 specific tests.=
=0A=
=0A=
A new test_aspeed_ast2700.py will be introduced later to always cover=0A=
the latest revision of the AST2700 SoC.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/meson.build                          | 4 ++--=0A=
 .../{test_aspeed_ast2700.py =3D> test_aspeed_ast2700a1.py}      | 0=0A=
 2 files changed, 2 insertions(+), 2 deletions(-)=0A=
 rename tests/functional/aarch64/{test_aspeed_ast2700.py =3D> test_aspeed_a=
st2700a1.py} (100%)=0A=
=0A=
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch6=
4/meson.build=0A=
index 5ad52f93e1..b5dd674bac 100644=0A=
--- a/tests/functional/aarch64/meson.build=0A=
+++ b/tests/functional/aarch64/meson.build=0A=
@@ -1,7 +1,7 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-or-later=0A=
 =0A=
 test_aarch64_timeouts =3D {=0A=
-  'aspeed_ast2700' : 600,=0A=
+  'aspeed_ast2700a1' : 600,=0A=
   'aspeed_ast2700fc' : 600,=0A=
   'device_passthrough' : 720,=0A=
   'imx8mp_evk' : 240,=0A=
@@ -23,7 +23,7 @@ tests_aarch64_system_quick =3D [=0A=
 ]=0A=
 =0A=
 tests_aarch64_system_thorough =3D [=0A=
-  'aspeed_ast2700',=0A=
+  'aspeed_ast2700a1',=0A=
   'aspeed_ast2700fc',=0A=
   'device_passthrough',=0A=
   'hotplug_pci',=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700a1.py=0A=
similarity index 100%=0A=
rename from tests/functional/aarch64/test_aspeed_ast2700.py=0A=
rename to tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
-- =0A=
2.43.0=0A=


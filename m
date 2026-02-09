Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC1BEF06FC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 01:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGLd-0003ps-H1; Sun, 08 Feb 2026 20:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpGLa-0003pA-GX; Sun, 08 Feb 2026 20:45:54 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpGLX-0001EZ-Q8; Sun, 08 Feb 2026 20:45:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7qmv7mUZE7/UTchKnT7PcTJ/WJQEc9xMG4NZw9weaGrmRg6n74+PewB2WdCH+wdoUXLhgha/BdHFKiQ7eHyypiIdywGr+rOexpk1wOCUAbNP86Dm+Z1mI8UaF4uVvSjPyzI1t5Ay4DMBP33m8tLp64bSFVN6llSjbhRrdiNnSy9CZC/+W8Fp0vvJ+px2BYd3Z5NsKNUomLB/WTOlFclZkrFMIyqaz9foXuljgeiwatF/9JLCTyOFKDvBGqxwTpeyGpEJ86nMWDeQstP3terMeluUf1Ftq9AojpTdW6Eop2Q07jp5UOjG0l1fmUDw+9REdnnMZV5i6beqH0gBqBKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fr/qxde3ZydKElB3sZXn2Z2i6aTbK+RJLcmv6aSzZOs=;
 b=LbzEcOiwp3kJrH+aeNSZIkcdcRbpY4ARa75g/VL8rfqORJKydeyg6QAb8H8eCCCULcLThaHUvEpM9qXMOtkkjHVMUJ4W2uiHXueDOhUI6tZGywkdZMEkKL506dHKa5nY0Xo14YzqqfUVDJnhpqGqdSxHHkf+oM2wlmVdh+0+iUO+VYkkFJsuCNrUGDCmk6SKWJKZndoPrgDlUCBuxnqe5z2sT0HMOSyiRuplIEannXH2TsMFuMS2l09LmVoQmnq61rrF4uop+b5AfgLf+le+1BtE7x2WTmAoHGxeUbez2IVJI33dHzgRnkC7AhrXmFEIRDCbYDA9bstnZgyPwAkGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fr/qxde3ZydKElB3sZXn2Z2i6aTbK+RJLcmv6aSzZOs=;
 b=BVVBYb5utZtz3r5E3Nb24FwSzK2RCaefhUV/FFV2BlLbwbFsG5gL4fklXDnKWZEOtlrVVOf0yr4+0s2HMpOrxk5x7l587urhNEPi2DPDczssoths8BsEBA62Z07OisZ1TEDM0ZPOHhaSyr6NJ+hDcNUCTkvYR7GQbE4FySEB3mh9ahlRphjK7qNhgYU6eF0eNCMnwo7AuqRvi7e03ZYOHKObxpKsjb+Ih8wHLYKysreMUyy3QQcWKUfSSghjfoTu2dSY7rtDyrDJ81v2ROu7F1xxb6RLmUUL4ZA9UXYTUWHn7zJCsM6Hnbey20Cn481AEt7zPcC6tqT3iiXejzpVng==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6042.apcprd06.prod.outlook.com (2603:1096:820:d5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 01:45:42 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 01:45:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1] hw/i2c/aspeed_i2c: Fix Out-of-Bounds access by using
 dynamic register array
Thread-Topic: [PATCH v1] hw/i2c/aspeed_i2c: Fix Out-of-Bounds access by using
 dynamic register array
Thread-Index: AQHcmWXMoUJBn9wsH0SaWe2SvMw7UA==
Date: Mon, 9 Feb 2026 01:45:41 +0000
Message-ID: <20260209014540.823794-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6042:EE_
x-ms-office365-filtering-correlation-id: cb5cfd10-7126-4497-777a-08de677cef25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JX/SkaGMYQxR/bTRZ9c1RiNj8H07YGBgpr9ykqGTqE0jZjk6M9DDFpmxcF?=
 =?iso-8859-1?Q?muhTYjGIjeghNwF0c3paz2uQ/n56ovPSFkTmWaxV/g+wtSqjw/jmkk1xsg?=
 =?iso-8859-1?Q?et7NMZXl2CnQpvjGcQmeO6g04T0Bv3pdzPCtjbPK9a54IKNsMWvGc6JeRU?=
 =?iso-8859-1?Q?PufAYs6oHn9XsGA1La36tN4thLKSQH2x4wLq/+2QQsugBgKDuJ5YXcLB3Q?=
 =?iso-8859-1?Q?vJbuqAoUSh7YiMzioxe1g4TofFEEr28odTv5TFHQD578nuabDispBye9pA?=
 =?iso-8859-1?Q?phHz6SqYLfQIyLK3sz+vNMCN5sEHiE+VCRFdqrJlKWeM/ahAPAdEKywpO5?=
 =?iso-8859-1?Q?auaCl86GOThFC7HoXgSCX6kQaAPdERg/ceRpXCrx+cvq1maxO/zYgzMjCg?=
 =?iso-8859-1?Q?cWT6Q4oXVsxx/J18Kiq4AiXcyOmkTa9yLtxQDN5PQtpSA+nvYXUVLagizu?=
 =?iso-8859-1?Q?/WnhsHrDIKNNORWsf2hsjYh8v5uB1JJMBUaRPqZqC+KMN/h/FPBulzSfHa?=
 =?iso-8859-1?Q?6VuoFfOhC1bJp9tbkLT3s9IZbfXBSHyHuNFvJox79IU8+D8wS9D1fJ0vCZ?=
 =?iso-8859-1?Q?+P2bmYry9gmGcNJoJ7r5Mx8iVLgBcNweNPd3BmnYOXx6ixxwgdj+J9Wjxm?=
 =?iso-8859-1?Q?ahTmXBdy/SGU8Pkp3+txDmL+GsOikwwrZpgXJIlxrPjf3c5NBztbkDnaRk?=
 =?iso-8859-1?Q?aNPSaLjzK/CRpI1DL8tBg8GqwOhBFyAhJWGpmyB0xL2RyYUCpiehGvIjqZ?=
 =?iso-8859-1?Q?hIbaNt6/B6v07Uqh6DQPseKPYQmyiyJ66CHe3cweel0cdn1lIxrnujJtTg?=
 =?iso-8859-1?Q?hR+GeG9GkRM6DW5C29b6lGxxVtfWMycddSILkdS4L90XsS3nDhpcrD9VjI?=
 =?iso-8859-1?Q?h74tS+pdx8k3uVnmWpp636mzEUhf4qviIhgqroNrdApy9czzXvDNBedHho?=
 =?iso-8859-1?Q?i2+8z1Eso2zb0p8TIplq9bWXK7T85tZrUhSoE8UbIrZWKyrP3+s8gQ1xPC?=
 =?iso-8859-1?Q?2syxkJAci/ifsJ6OC4q9Nm09+UmZOQ+gGOX+XFOZd26DnsNsIVFYsbgKI2?=
 =?iso-8859-1?Q?G/gQBKIfEh7sTash/yAAYR4QsSfy+dKCC1fGT6yVVjIFuRvT4ugaGwFT2B?=
 =?iso-8859-1?Q?1rFPTy2Dyvlzt94jsBYzmGwkAFLdMkD4AtpOJFNTaSOFOst0Af+GLqSxuF?=
 =?iso-8859-1?Q?4lCn1pOuX/USi1I4O+K7d+QkQnuIBuALkj5hgAn0/hqocpyUrtm+iF4Q3j?=
 =?iso-8859-1?Q?iE2z9M+LADXg3v2nT0lSZoijYeY3fs4IdQjMiwyWn92X3My6ihnJpXRoaa?=
 =?iso-8859-1?Q?HjTtIi0YxCimOWPzSPIhU0Q/VGj/hvtJPLgtXeu89SiJw4DdA5GcbqjmGq?=
 =?iso-8859-1?Q?L8CnrA2Q0+UnlLUAJCBS7EB9Ccv55pA8CYVXAyZHrN6kVDHCVSrjqF2zMK?=
 =?iso-8859-1?Q?UxLeuyuX/IqNar/qaCOBMTuonUcAlTd11xZ2g2jrs8QNC/wBA7YZ6jT0Oc?=
 =?iso-8859-1?Q?NbG3pRaaq+0XOTEm0DANK++Accs2bkeYo35hLxzqtAiyQu4JYNIDKljj1n?=
 =?iso-8859-1?Q?dtTd59Z4duC7OldDppHti915H/6UakKS7IyH+elI9t9jEJSUDxQHe7479l?=
 =?iso-8859-1?Q?gPZcTNw1h2GEnjDLwrtxHR+ttIwQJKnzmHCicOGkVXPCcuVfs3IBZtkvp1?=
 =?iso-8859-1?Q?OudaZzmAB4ebScCx1rI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QeErq8osUJ8U1Zfg5WGJ2+rbwnLBH8HldE762UgDRh43WRLkoC3ewr+4LU?=
 =?iso-8859-1?Q?KucSepDCmHB5pOT4KA7/a84DgmAJjEU/1tbkxBa446UZtU1naUl1iAUy8T?=
 =?iso-8859-1?Q?uxbUxnhjlQkCLyhkOrrU4lGwQ/vmMVCfa/YKy+3qWaZRLk9ohQE9tdCskJ?=
 =?iso-8859-1?Q?mflwddYPXmQXUomHwzQPpYoQj2RbhWQXNpUh9lUiqL3geJc+2E57PVhpGK?=
 =?iso-8859-1?Q?XaD8Ql8s++m3sV5WSFs4EOA4cQrY2WoipQGTgc3C0o2EWkG2tkyMf1HF4d?=
 =?iso-8859-1?Q?ze1MaAlx41UlrijkIRnAf8h1YDRIkdS6nDnJmvAC/I8M52vQ/LuAITT17T?=
 =?iso-8859-1?Q?iX4wUu1eoItbqV1RDey9dTsjWjbQLTCdbdVQrXsaU/54AkTAeQ6OS0+ud+?=
 =?iso-8859-1?Q?3OQQ6WQrsRkjhM/no8rfAyqa2M1tyOu8LDnck+mFxmdqB4uxF2d1k3sHnH?=
 =?iso-8859-1?Q?1qlE5DTgVF3LaNGvsE4imUR6fUvgU7h0ZPOlo9em/R+QO5HzJIu00r3ta/?=
 =?iso-8859-1?Q?mvh41ylu4vbE8qTlSkFFzOtkfhH+tj3fUs1eXdHW1vNwuWFUYFG2LOM7OX?=
 =?iso-8859-1?Q?dghVBdJ0TQnvVsqbNnbiDfRkeEkH74pAJ7qV01t7RuaM4P57Igz/x0G1Mz?=
 =?iso-8859-1?Q?RkMgSDlQJ6l7Tv1xbw5iI/LcDfGD9uMaOisA9HIDikO1W6Y8Q4mI06x/aX?=
 =?iso-8859-1?Q?wuEUsee2bPHEVRMH4UhN1R83H6qsgJaEuvUeMns1w2Gx6R2nF5d7aAKIyG?=
 =?iso-8859-1?Q?uOwydK3AOeQh9fqAnGqY2uEKSHNAVrreZkybqVopsmz5o16Wehes72vrK4?=
 =?iso-8859-1?Q?R00SbDD0UC92L6rApVHXWHXZy8iXj+bOlosmHF7Hikhc/KFcQ8d/vIkng5?=
 =?iso-8859-1?Q?y6B1YSV/q11buQhf0h+ugPN2xnuDrdc7SD/9ds5rLdR1gDJHoyHA4BnJ9h?=
 =?iso-8859-1?Q?jL9Zcy0PGpRAN4SZj75FkuljZ+fykOk8YTPjumAQGpf+o5b/p7a4p/WiNm?=
 =?iso-8859-1?Q?8YaFNlk1aSeW38jAEpdeEstZnCxUmTNixyH/zR0X1tNj3ufXgVeIQuzzfY?=
 =?iso-8859-1?Q?d9/um5nNMgadoeNQsjbpime1m8Lc7s2J3hbXsN0K25mCnNFiZFj1uzOhOI?=
 =?iso-8859-1?Q?0eCNLx4s90hzohu05soCQpYU5s8kLpDLB9kHgCao+RdJDlqeBfx6oKtJN+?=
 =?iso-8859-1?Q?crVLlwmH/dQsBF2jQnv30K1wRiJcIPuf2h+gdxzry9PiuKJigwi4mW7vst?=
 =?iso-8859-1?Q?iUtlr+gLaHIEpPyX/rN7wewOtMYrov/ZH9tp6e9XV0PUF/nAQtfKKvfGfT?=
 =?iso-8859-1?Q?aF0Exhhz6nvlVXAK7MYGIN5nRe1dpdBJ9qsuB5hftOLV9W1S/qSLetLh4d?=
 =?iso-8859-1?Q?M14pdQW969GX7NmzdiMMAMxxoMMiTehzcFEUPkoXP6bOzxRSv3IKwBibPB?=
 =?iso-8859-1?Q?A9qYM9Zjx/YXSwvJ6bVVWiU4W3fBOBqgorXoBxTqUnghoMkNtMvBTJAtHD?=
 =?iso-8859-1?Q?XFsLmjH8fRNnFiihVpsUyDURceiPp6yCEIlm0nIACfNfzyd8sO4UmNNbFj?=
 =?iso-8859-1?Q?HcC/jQAFtubus5sqlBXyxxwbZmedrtBdy0Ib7GLkmYt7xFNCd7MnNnHksH?=
 =?iso-8859-1?Q?Af26OeogFHLm5ot4MWamQ60eigjjUwb/YTdgwWvBmhsLLQIKUH9F3huj9D?=
 =?iso-8859-1?Q?mfAR84yKCWE5J1L028oMUJ7eXRL3eUQcPiTvnHPIWWFhMbvQOMUqb0vIZn?=
 =?iso-8859-1?Q?3cwnHO/ZobE9zKX9+VL8t5lxZuuPFb3PoJdRPYnmQHq0tLfA7kzio+XtKl?=
 =?iso-8859-1?Q?Fm5+HjEeWw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5cfd10-7126-4497-777a-08de677cef25
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 01:45:41.8474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpGpuEQV7vCynIGdqoB7rn+LTdk47wj3tctxBzVOrx4HcO9WULPh6vQQ1ZHU30vdAKbz1JoO0i5lq5gzkc9LTxgcVqJcUGnKxktxGBLZxu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6042
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ASPEED I2C controller emulation used a fixed-size register array=0A=
(28 dwords) for all SoC variants, while multiple ASPEED SoCs=0A=
(AST2600, AST1030, AST2700) expose a larger MMIO register window=0A=
(e.g. reg_size =3D 0x80).=0A=
=0A=
This mismatch allows MMIO accesses beyond the allocated register=0A=
array, leading to out-of-bounds reads in the I2C controller model.=0A=
=0A=
Fix this by converting the register storage to a dynamically allocated=0A=
array sized according to the controller class reg_size. The register=0A=
array is now allocated during bus realize and free on unrealize,=0A=
ensuring safe access across different ASPEED SoC implementations.=0A=
=0A=
This change eliminates I2C register out-of-bounds access caused by=0A=
SoC-specific register size differences.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3290=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  4 +---=0A=
 hw/i2c/aspeed_i2c.c         | 18 ++++++++++++++----=0A=
 2 files changed, 15 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index 68bd138026..205f0a58d2 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -36,8 +36,6 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEE=
D_I2C)=0A=
 #define ASPEED_I2C_NR_BUSSES 16=0A=
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800=0A=
 #define ASPEED_I2C_BUS_POOL_SIZE 0x20=0A=
-#define ASPEED_I2C_OLD_NUM_REG 11=0A=
-#define ASPEED_I2C_NEW_NUM_REG 28=0A=
 =0A=
 #define A_I2CD_M_STOP_CMD       BIT(5)=0A=
 #define A_I2CD_M_RX_CMD         BIT(3)=0A=
@@ -256,7 +254,7 @@ struct AspeedI2CBus {=0A=
     uint8_t id;=0A=
     qemu_irq irq;=0A=
 =0A=
-    uint32_t regs[ASPEED_I2C_NEW_NUM_REG];=0A=
+    uint32_t *regs;=0A=
     uint8_t pool[ASPEED_I2C_BUS_POOL_SIZE];=0A=
     uint64_t dma_dram_offset;=0A=
 };=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index fb3d6a5600..cf3a003978 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1091,10 +1091,9 @@ static const MemoryRegionOps aspeed_i2c_bus_pool_ops=
 =3D {=0A=
 =0A=
 static const VMStateDescription aspeed_i2c_bus_vmstate =3D {=0A=
     .name =3D TYPE_ASPEED_I2C,=0A=
-    .version_id =3D 6,=0A=
-    .minimum_version_id =3D 6,=0A=
+    .version_id =3D 7,=0A=
+    .minimum_version_id =3D 7,=0A=
     .fields =3D (const VMStateField[]) {=0A=
-        VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),=
=0A=
         VMSTATE_UINT8_ARRAY(pool, AspeedI2CBus, ASPEED_I2C_BUS_POOL_SIZE),=
=0A=
         VMSTATE_UINT64(dma_dram_offset, AspeedI2CBus),=0A=
         VMSTATE_END_OF_LIST()=0A=
@@ -1465,8 +1464,9 @@ static const TypeInfo aspeed_i2c_bus_slave_info =3D {=
=0A=
 static void aspeed_i2c_bus_reset(DeviceState *dev)=0A=
 {=0A=
     AspeedI2CBus *s =3D ASPEED_I2C_BUS(dev);=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(s->controller);=0A=
 =0A=
-    memset(s->regs, 0, sizeof(s->regs));=0A=
+    memset(s->regs, 0, aic->reg_size);=0A=
     i2c_end_transfer(s->bus);=0A=
 }=0A=
 =0A=
@@ -1492,6 +1492,7 @@ static void aspeed_i2c_bus_realize(DeviceState *dev, =
Error **errp)=0A=
     s->slave =3D i2c_slave_create_simple(s->bus, TYPE_ASPEED_I2C_BUS_SLAVE=
,=0A=
                                        0xff);=0A=
 =0A=
+    s->regs =3D g_new(uint32_t, aic->reg_size >> 2);=0A=
     memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i2c_bus_ops,=0A=
                           s, s->name, aic->reg_size);=0A=
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);=0A=
@@ -1501,6 +1502,14 @@ static void aspeed_i2c_bus_realize(DeviceState *dev,=
 Error **errp)=0A=
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr_pool);=0A=
 }=0A=
 =0A=
+static void aspeed_i2c_bus_unrealize(DeviceState *dev)=0A=
+{=0A=
+    AspeedI2CBus *s =3D ASPEED_I2C_BUS(dev);=0A=
+=0A=
+    g_free(s->regs);=0A=
+    s->regs =3D NULL;=0A=
+}=0A=
+=0A=
 static const Property aspeed_i2c_bus_properties[] =3D {=0A=
     DEFINE_PROP_UINT8("bus-id", AspeedI2CBus, id, 0),=0A=
     DEFINE_PROP_LINK("controller", AspeedI2CBus, controller, TYPE_ASPEED_I=
2C,=0A=
@@ -1514,6 +1523,7 @@ static void aspeed_i2c_bus_class_init(ObjectClass *kl=
ass, const void *data)=0A=
 =0A=
     dc->desc =3D "Aspeed I2C Bus";=0A=
     dc->realize =3D aspeed_i2c_bus_realize;=0A=
+    dc->unrealize =3D aspeed_i2c_bus_unrealize;=0A=
     device_class_set_legacy_reset(dc, aspeed_i2c_bus_reset);=0A=
     device_class_set_props(dc, aspeed_i2c_bus_properties);=0A=
 }=0A=
-- =0A=
2.43.0=0A=


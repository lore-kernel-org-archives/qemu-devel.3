Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2BDEA3F2B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpk5d-0003iQ-R8; Tue, 10 Feb 2026 04:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vpk5Y-0003bG-Jp; Tue, 10 Feb 2026 04:31:20 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vpk5S-00041b-2B; Tue, 10 Feb 2026 04:31:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fELo6iVZdCjAvByJ61dTPBGYVRUR7HRIcj31Y3LGB98fEVdYXq8n/GrcC9BwCfsIfw2FAmVnjkynHJuFslRNjQ+JTGLUwx3jNTMXhCNnJfJvGRJ/n5ShJ1DzjdoANe0ygfpkCgoPSgnD/OHapFFWUbMXNvO1/DYfqJ7sJBoCNj4BEhVqDtG5FcDdKBkePsMvX8yBLlJyN0V2pYRAtLOwTz7fvoXGs4q9w9fHrANMmeMuGtMnZS9NdSbUPpcUW31Sh1PI5i8cg6ATyze5a9glYcavl0J5JwRJJjl//v/N81328bjdFr5AWVhhrPTHwov4MmHQq62W6heAP39n9L01+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rnzjaJb0Aosci5HBvCOwSGmySj+eT/JSfy7HZmCzlE=;
 b=Q+sV/2BIRT0OZkWqHfrlYya847i7OAVuN8XQTdfP+LZOaSjmdSUv2R3k8RjXRDl+cngejIjzxWYvt2njcv4RVlATttLPIZdAGubq2rXw6e+8KYYh+z7XBEtwYvyA60mF7/AmAxBkFVxUI+2DxIaj9WrPRlxPpHE0gbscaieNrmuNoHhKy5swry7RhiO0Mp/9Bf0F6697N0n1enfVauxAeq9UiRoDlSwkNrCi3CQa6skUPsqrGUzFMiFSB+o3xA5B5OpTnN2L/6/GJvSjQVKepPpw3Ui2xEWqP+5F4+getrMMhnQVJfUD/oH8S1HSvlJ5OS6BnvdgSaSC/WMuCjaKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rnzjaJb0Aosci5HBvCOwSGmySj+eT/JSfy7HZmCzlE=;
 b=U4K+7Uet3CTAuNAFLbQnrkIngtqfwh0NqGFKKdbiKIv+3TpXqgRR5TqjZIjwcMfx8Qh1bJbhZflOVtfFIeRHkudGis3uc+TsnhoE+Xe9T0je+EiEG2FMVm73gA9fkkuWpLlemDHU2aF/9P/nCYTbntw4TTwL5nlkdpbQM9GhZvYUWzx3LJWJJCpYe51SxIfUIcUDOuOCytq1mBZCrwYAir++zww3FhKWtFdwovWTDVUoUmo0WPw2cc8a28s4t1iBLQIw+y3GU5wHUI+hcUwnVrF+UYFxGQW2XkdXRbkqTQFyNk8PhJzAWfJJ9LMBdczIKuaaEFE0nbk1qCk5a4XY3Q==
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com (2603:1096:101:249::5)
 by PUZPR06MB5585.apcprd06.prod.outlook.com (2603:1096:301:e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:31:00 +0000
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6]) by SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:31:00 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaeluno1@gmail.com"
 <kaeluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 1/1] tests/functional/arm/aspeed_ast2600: Enhance OTP test
 with functional validation
Thread-Topic: [PATCH v1 1/1] tests/functional/arm/aspeed_ast2600: Enhance OTP
 test with functional validation
Thread-Index: AQHcmm/3/5MvMfPdL0OVAhKuBpGqyA==
Date: Tue, 10 Feb 2026 09:31:00 +0000
Message-ID: <20260210093058.1673887-2-kane_chen@aspeedtech.com>
References: <20260210093058.1673887-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260210093058.1673887-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7619:EE_|PUZPR06MB5585:EE_
x-ms-office365-filtering-correlation-id: 1c26d7db-64c7-45f5-1692-08de68871a61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7142099003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DT7TOODhNsmshkUBHnXryrseazlQKu3aqcZpRMNJ38EL5SRGQxbVlzfSWj?=
 =?iso-8859-1?Q?X26hIYqL35m/DhWL98Tc/BsMMsSoO+0WZ+3JWQfBOp3X5baxshAsnfW+we?=
 =?iso-8859-1?Q?cnm958oRZzDDVCchwE7uOunOxvIvkHPKv0wkfijegEXRw+toSXLkIY1YH3?=
 =?iso-8859-1?Q?Nbofe9DoIcxzdiwjmJCPBA/x7I8WVf5uy8F7SrVj3k+/s4Z5XbqbY91kYd?=
 =?iso-8859-1?Q?hlfFrpyuCWk0trwyFPqOafQc6p2O9NDXL+X2ikjWqaaBDNLTfnIBAg4V2M?=
 =?iso-8859-1?Q?Zx1FS+PTaB9lS5jdT3zpCa9GIptJT9gMmvMly0cAtDBp8xJc3oUkZZynZT?=
 =?iso-8859-1?Q?OFxxITkax7NR89Uw3GkJGIbk0UiscNsvbuczAz73HGZ74XpXVecOqwt6Az?=
 =?iso-8859-1?Q?Nd0vX0DSZW27dUYi9N3nt8rEltTUWjI3TAGojRNr4/vwsCRutFCmoDhr1I?=
 =?iso-8859-1?Q?5cZhIBPFAztCcUJrPNDdK6FUyVM9IP10It3wrF17WfxDP2vJdMhEPDnVFd?=
 =?iso-8859-1?Q?SenplQGxR0mGNaJTv4dStFoRJCw4ZjU+Buiwgm2PIf14fI2F1zAymLynYg?=
 =?iso-8859-1?Q?KoGp2th23HoNYgVoelYg7oUG2uXJRv4IQUJq+onSi6f7bcPtSlKWeyqDqV?=
 =?iso-8859-1?Q?Mr48R8HGKTs3kAqguNT0wMfHW1mO4cnJyTRvvJ2X8iiulKJjd1hCUADQ8q?=
 =?iso-8859-1?Q?xaN4VrcG1mQPp2BCLVdC77N2w5Ezcq2PXzJRcB/cXPQ1stOPIR2VYbIUaL?=
 =?iso-8859-1?Q?hGp2AFtEUOTb02ua4eAKx8+/deUNcTiOVIxXDXDgeSqFvA2kbg2SjidYQ3?=
 =?iso-8859-1?Q?rAZMoN88JWQnqFvUt3aOirX0GqfRASqdAV+dO8agAjB2rhu6Wb/44X4eS3?=
 =?iso-8859-1?Q?1ghHRXxJ8ktiAahtMgOjC0IP/fzn1Xutn1vn3zt/fN9fArZGA44oIdrNTW?=
 =?iso-8859-1?Q?6s1AtvXGz1d+h3sC6pd+dMpqfd1bmFBbGWwT20E38jekxJnxDapJXy6M8e?=
 =?iso-8859-1?Q?aTG7uZ7mc6pwDGAsAEJDoJRnYNaiMUSE8d4GA6HbJ2vxaGvbjKDL+2Jke0?=
 =?iso-8859-1?Q?DmIByqK5g8mRtgfGnJIP4AQ8Bn7yyQLYzvWJxtoG7ZCodkdH9MV+hk6LwX?=
 =?iso-8859-1?Q?IPvbpCKYGmwFsvVigc16hzONVvE8LTICWmdu8rHeQycsUgzOkCFn7sDMdb?=
 =?iso-8859-1?Q?hXZwKUL7WcymCI01MNymsXrgB3qmOHyeINW6RjxYZrs94scKrewOVRi7XQ?=
 =?iso-8859-1?Q?DV2Xp8aHR+rZgXXJ0WUGH5HImN4CduKYay6uF7/Tu8gRI3R/6OpFXdlhKG?=
 =?iso-8859-1?Q?7+u5duF7BPMF/zH4GNLmYjN9cam4WUm0cbAGP5A9POkwzeXSlDzM3OrLZP?=
 =?iso-8859-1?Q?K4Ydedjri4RzHa/Q2N1ERmcxAFgAuzY6jNRH5xyEWG/ksOenyW2sd7Qy91?=
 =?iso-8859-1?Q?r3LfPbxExPfPAe7Kpeay1651wq6AWHBJ0AQySyzJ4ow+9tGzfLf9GXQD5M?=
 =?iso-8859-1?Q?V/KHropHur6qfaKw/Wlhe/QmV1kYpkOr8MbyU6Bjv3ya8mA+aZ2F+Hqq8j?=
 =?iso-8859-1?Q?ou2pmSTPGw2VKv4dQ6UmL9wnFKhuc7oIfls7co7G5rAqKOrQIMaWIlCMkk?=
 =?iso-8859-1?Q?YEubIXoxacMJQ3bl3o6+my2OMhcO/iAUZ/9MnsPhakfWblv8syMzDdwwGs?=
 =?iso-8859-1?Q?Al3lQlc2cVZgjl/m+DE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7619.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7142099003); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3iRORG8TuAFmfIhRWOTSQYg+1zI4Ey4tKXpNJ00gyjMVie1Bz9n6iR/Zx5?=
 =?iso-8859-1?Q?empcfF8E1vg7vp8bPouptPVTFhF42xKPIKjP8CqqUb6xC0WcsmazvCarY7?=
 =?iso-8859-1?Q?JzfwOJha+QMHbX1O1XasKV/fqI+oj4fpBjkgEYEroXSN2jKz5e1f5XXu0P?=
 =?iso-8859-1?Q?PDb6RMNXlGx+E/bFxuBKOpg3H6poL5QhySIapt2WnBWXPqzIwydPapfIYV?=
 =?iso-8859-1?Q?SKRRPrG9INzrGo6UpkXAU0kAazr5V63tF//npOvLU5602b56MyyBhafTcc?=
 =?iso-8859-1?Q?Ov4ncYnYPapsMUXanyARKz18kehSX9C2dbVHcdsS9wgMMjV1TNebNsSIif?=
 =?iso-8859-1?Q?EkS9ONnyVvEdmr1Uaq6Lrxuji+AA2RNrwYl5okzftEL2PyNqC0P9ezMC7F?=
 =?iso-8859-1?Q?juYWpQpy8LV/ERG+pG59u+9WtJqg+CeO8Qlmr1uE8l+QIX9EMS28gxGX1Q?=
 =?iso-8859-1?Q?fW0v6uneUGVe4T4EzJUNebQxpY8vEdI00SwArjeTack8s8WG5z9LXzEeSE?=
 =?iso-8859-1?Q?pN/RzjNpzNWfPeDInwt57LwaEcX31iAF647eUbGBcykuSImsRueErrPszB?=
 =?iso-8859-1?Q?S+MORgECihIjGbDpD43REhDV7rKyxapbaZgqffYaijThdG52N2/nfE1MV4?=
 =?iso-8859-1?Q?8+yLugBhy8drlhPWJcXCwidmpA7LmPHAKrv3nGShq7fcL23XvvHpbnQ2wZ?=
 =?iso-8859-1?Q?Z0mjOU61z1NYj/83RUmzZrtNv5Nb6Fi669MBQCqQq7o54Sgizdjk5fk996?=
 =?iso-8859-1?Q?iuS/GlCNnFz7e1/bcX5IZMp49UXmXvssw98Xv+pI48AFZ04rMDeIBtRgjk?=
 =?iso-8859-1?Q?LZtLkWZxjIRStkio+ltdT5Ct7ZKQximcfk5AaQCancQrI3n06FHgLwT9DW?=
 =?iso-8859-1?Q?7ISMKmbnUK9+Zgr1wnD1pggYRgZdzGMiYxEDs5nsPSmp4Yn8aMl6gt3It2?=
 =?iso-8859-1?Q?RCACOB7ZwSNUHivUJhhYMi6xlq5zbgRztxq7usj6GQ5DuHRJZH1a25+pxB?=
 =?iso-8859-1?Q?5ebFfbVjrItQQ+WRWkR+pK4gbFLQ/5vFFgsLAua3Crm4UhHJKjn6243Gx8?=
 =?iso-8859-1?Q?62/BS/0zpJTlDr9WWUegXrfd21ywvbQBwHQLwkpK6DcHinaT133nD6Asgf?=
 =?iso-8859-1?Q?HgIm58/cXmftHimr2isiHjtialgUez0GsXVQ+Fji6rO2evS2OsO8IIdhAJ?=
 =?iso-8859-1?Q?ja01U6X1QIaS7Fqj5wuQAXi9NxW/aHJ7qmLKFMOwyLP3yxrXHUGlAi2bu+?=
 =?iso-8859-1?Q?QyC7aYzpcZJwJ1cm+eJ2am0aML3Ypr8fpV1oIJ+grp76aCwYSrvbg3dFbH?=
 =?iso-8859-1?Q?gNltIxs2gtGNcEojvv93KpvLjLZ2nyhdcz67zMLrs6fEoQ22Kooig0rNOk?=
 =?iso-8859-1?Q?agv7xbEn3U2MptTEA6dn6+0bLWilFkoLuMU3nWYjE6sGoISWJq5j1Et8nY?=
 =?iso-8859-1?Q?Pmifp6Xz6n+UPQR2Myc/6AP5B9r9cv0Qb7jaEcOah4WkIXZqe6+3MerXr0?=
 =?iso-8859-1?Q?oVmepQyxitDPl7ze3XtQ4UOaK4MZEokUJfmOzO3NMs5vE9Jcotbyz/Ilh5?=
 =?iso-8859-1?Q?1+iWDS4kJvM+3/3ZX32F5y/A+AfgZH01GcphIuuf+yLO3yPCuLKiVPHW1G?=
 =?iso-8859-1?Q?zOuHytVS5mF8tA441/8qcU0kSI+1C/UHpOqNLF4i5TIYSDdvMNYmDpUHWT?=
 =?iso-8859-1?Q?S47RlIJ1nKlQuLL6W9WuuxFDBqpeh3NHUkjVcJu/V1zwMlvRveBBdCbgsZ?=
 =?iso-8859-1?Q?UMNpo/1v8RcPCZ9PbIvDd1HHYrRw+KqUG2qjcfWjBL0RfIon4W5fMPminF?=
 =?iso-8859-1?Q?PhkSdLJ07w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7619.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c26d7db-64c7-45f5-1692-08de68871a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:31:00.5589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzsPN6CW4drwjDzmyyDuFjVnWE7fS6PKYxbOLungkshXxauxFiwD4Vn6zNg5e1JfhkWUFR2NPf+ZmQbcAAEIlRF8IlYDAF/uj/cXiuwEtBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5585
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Improve the OTP test script by adding functional verification of OTP=0A=
strap registers. The test now validates that OTP modifications made=0A=
in U-Boot persist through the Linux boot process and survive a=0A=
subsequent reboot.=0A=
=0A=
Key changes:=0A=
- Added interactive console commands for U-Boot and Linux.=0A=
- Implemented verification for OTP register 0x30 across reboots.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 .../arm/test_aspeed_ast2600_sdk_otp.py        | 35 ++++++++++++++++---=0A=
 1 file changed, 31 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/fu=
nctional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
index 4066532d5d..90f283ea09 100644=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
@@ -6,7 +6,8 @@=0A=
 =0A=
 from qemu_test import Asset=0A=
 from aspeed import AspeedTest=0A=
-=0A=
+from qemu_test import wait_for_console_pattern, exec_command=0A=
+from qemu_test import exec_command_and_wait_for_pattern=0A=
 =0A=
 class AST2600Machine(AspeedTest):=0A=
 =0A=
@@ -25,9 +26,35 @@ def test_arm_ast2600_otp_blockdev_device(self):=0A=
             "-blockdev", f"driver=3Dfile,filename=3D{otp_img},node-name=3D=
otp",=0A=
             "-global", "aspeed-otp.drive=3Dotp",=0A=
         )=0A=
-        self.do_test_arm_aspeed_sdk_start(=0A=
-            self.scratch_file("ast2600-default", "image-bmc"))=0A=
-        self.wait_for_console_pattern("ast2600-default login:")=0A=
+        self.require_netdev('user')=0A=
+        self.vm.add_args('-drive', 'file=3D' +=0A=
+                self.scratch_file("ast2600-default", "image-bmc") +=0A=
+                ',if=3Dmtd,format=3Draw',=0A=
+                '-net', 'nic', '-net', 'user', '-snapshot')=0A=
+        self.vm.launch()=0A=
+=0A=
+        # Set OTP value via uboot command=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot:')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', 'ast#')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp pb strap  o 0x30 1', 'ast#')=0A=
+        # Validate OTP value in uboot stage=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp read strap 0x30', '0x30      1')=0A=
+        exec_command_and_wait_for_pattern(self, 'boot',=0A=
+            "ast2600-default login:")=0A=
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
+        exec_command_and_wait_for_pattern(self, '0penBmc',=0A=
+            'root@ast2600-default:~#')=0A=
+        # Validate OTP value in BMC stage=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp read strap 0x30', '0x30      1')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'reboot', 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', 'ast#')=0A=
+        # Validate OTP value in uboot stage=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'otp read strap 0x30', '0x30      1')=0A=
 =0A=
 =0A=
 if __name__ =3D=3D '__main__':=0A=
-- =0A=
2.43.0=0A=


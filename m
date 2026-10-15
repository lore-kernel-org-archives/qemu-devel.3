Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE570CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHET7-00026e-QJ; Thu, 15 Oct 2026 01:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESj-0001su-7a; Thu, 15 Oct 2026 01:57:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESh-0003FR-M7; Thu, 15 Oct 2026 01:57:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v33RVVcLHkRcT5oTe+zCVksdSZRTynDkjpIg1+jJ7/CAo2WHwILkoxcCpp5MxyH1BDChWXz4NAzYeKjVunTEuWCJkDKn4/GMHsOY7sp5XqrOl7DAQI+21ib1/AGsk1G0/8JvNWoZdgKdPFJYcLl8kBq8A/Hoa9ofYH+esMTaGqO3e+Cl0AbqebwIl9Cysdz253y3nl97xu9/tOhOd/6h6OO+VWbJhQMNYCYxVfz+pRZLqGgsGZUP36iOM0jgFEDwlCJ3csYNoP+Z+hLX55zADhW00l7ylUqd7EUvh6m1FViwyj9wEuErWlnWQ4w5koMF9/mXABW1mhQgM0YBRFFnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDQr/YLDxPXEKTQFsFv1XQiSj1hKXfV/CqO4tJVusW0=;
 b=k17iCvsOb+6DTrkNN5egRO3G34uVIA4HhhiIiSo3X2v77c3s7VHAof1bTk3GwTLx7jF89s3vxxsDLutTxHZODq1weaF/yAlJedgTeaybzamM4v5w7P+M9izfeGC+R11U6F/N5IoSHkPi0Z0WspYtR0swajZrJAZd/zVoAuR/2Y5F15DzurZLkvG17eE8cPc1JOz+onGhJLrmDZtX8cnoZ81K7ZTDevCtR45DC5Qke/wNkKD3ZxpfwVIxSyKNyqI6F2KmK6WYwh1vbGZTTeikUh6exk2LFTYZjE/ynb5+koNV4Swih1ELwpwJRNGPUJvEqEMvXSgdyM/k/E0QvR0lHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDQr/YLDxPXEKTQFsFv1XQiSj1hKXfV/CqO4tJVusW0=;
 b=W17RA23LewyXlC1a8OkKM5Pa86HiyJMkWfgACOFm7Ecbog7RC5nbMxV6gVaoPbqE8LB0NuiNYbXQ3mvn8OFCPVcMsH4VEt7omGPWrWnLEQ/6n0aaCOIa02qhcNxBILliDXbfFGd8TWSeVCxhqWqYFipI491UehLoh8DFbnSsdGjmkd2JdlkeRJY443prSqQT1d1MGYaIsFRq1wQR9R8PdlVSJ3J2Grz9qmMaxe7j1QzkDbB1Mf63CvLufLxUyGGEUe0pzoZbFaRp5v8jS9klUMfGBSEvqqOQYomEJ1RCYGvUypV1zAWdtAgqoTcB7OkeGVqxqtHFgUILzITf4F8wrw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPF2322611A7.apcprd06.prod.outlook.com (2603:1096:408::90a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 05:57:02 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:57:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 11/14] hw/arm/aspeed_ast1040: Add I3C as an unimplemented
 device
Thread-Topic: [PATCH v1 11/14] hw/arm/aspeed_ast1040: Add I3C as an
 unimplemented device
Thread-Index: AQHdXGn7Zvg9SfMNO0uhaJ43bMWJsA==
Date: Thu, 15 Oct 2026 05:56:55 +0000
Message-ID: <20261015055642.106204-12-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY1PPF2322611A7:EE_
x-ms-office365-filtering-correlation-id: 5ec7fe01-041d-4a54-399e-08df2a812237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|366016|10067099003|22082099003|18002099003|38070700021|261009221227099003|921020|261009223027099003|56012099006;
x-microsoft-antispam-message-info: Yoa6FZkJAv08C0mAAKLYsW82MgXVH0a7f6AWjpZMGz4G9RvgbqPXwSoGRqo2pI+bqjMLrY++Ev2kfKklcdES1DzVIXdNhOf+NPf3Wv6sp2JSgKeZ+2Db0nM026O4X+k0KRmXiw0S4jZyvMY8j1YmoJ0mwR/2P+n6CLBjYPaWo4k10YJ6Fr0ASpCA+zs8sGR0LSOgzj5roEcmJHw63Isn8q2tfho4OXD/9EbXH4Aa+qfyZFZCiByTAA+LBK/kTCuAvD+h9TpiwNUZJuV0TOe6t2eq/eCf13XhtAw6k2xVtbmmO0d3rJE+XoAI9LYnNp8BVyOLp8vGa91griuqaop2JqG4iWaRAWeCRYw6u94rPRBzvUzZ4qU2AptCJAc3AvVJm1qy7b8vRlnbXsXDT0OfZ1qXWBLRRHKJ1qZ9UWlvp8AgO53kp2GKXKdKqlpe2JdVNJ5JqWlPYqBGuBrIjs91oBvX9PiUeQoBfIyn2nzH5VTPY/W5nODk8tnLxcHev8lk7+5q8VhFLWuOMOsEY8dtrUvkGKBYvduwn5L4LwmtmNHght/0bI3/t/jKyUfAsNWDx+5+uiQ148XeP9C/eyHlaEGovSRxHZsm4A8fRDGfh4ew20m4pa9VmixbIiI40K48AxLKQN33x8gTymHUtlA38btlT2V/o+yzyTRUkx3zT1sS4v4mOmJk6PZflbK+Z9TGNWtMsdQ9xLwv9Q18ZTxbCU+z3nYHGZXMHu0WTa67vaHHKBJk/LB2yYk7DsFMUuew
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(38070700021)(261009221227099003)(921020)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5KRAkb2mNav8oIuMt/5/N0W3oUh18CI6HEma4fzubpazvpSySPW8P9jQPp?=
 =?iso-8859-1?Q?+ghbwE8SqmdAzGC6ok3oDQPsSnMFTRDhPKCPzBQGY3i6UImndaFuwEuPDd?=
 =?iso-8859-1?Q?7RPZeXRJc94tbQfXK8vQdhyslS/YZgrNFO7jTpxvD0SpZhFOQ1Et/9HK3I?=
 =?iso-8859-1?Q?lKjNmniP1unQj3s0fYIUbAM/u6XnCb+8/I5OZ28e/tc8C/b+k7mCoCsGrn?=
 =?iso-8859-1?Q?+SB5DD31sQyTQBSAOgF3weaB+9KFkqPhDklCnOPz6OjDNdh2KUJSaYgwhj?=
 =?iso-8859-1?Q?oEXm1MufYLB1ud8qxNv5YnV3JOUOmDcYxngypILHtXWP+1VL6RZK3lp5Om?=
 =?iso-8859-1?Q?1bUzQj1SV4Zgs4PrxOrVyR9Hp+UFkQP5TjC4WjdyTc3l2XWGSmNJYV9szs?=
 =?iso-8859-1?Q?a7gLXzhy9on4U4GeA3rX7+/aR425+Oz3IQIhhN8E/etYpN/EUdm77H82f9?=
 =?iso-8859-1?Q?G7C+pH9heJ/R7zCIhv9wbNM+MnUTpeZpzLdnsl4hdGJmzTxwMgulcDJNcP?=
 =?iso-8859-1?Q?PWhrfr/EQ8Z6xqgZxuYKNxmr0L6gJEs9tb8QKrOpLPd04iqgqY/uJIM9qf?=
 =?iso-8859-1?Q?OiPb0bOAP6VUCVLe53B0MvWbt4VTzZjAWAUQpNI6cHbX2x5mjlv7fYGr0o?=
 =?iso-8859-1?Q?7b/0abbwz8/e7OPTuce12muVXg0pyrxS/VMo44A/3QIvaepOZZd0Ejx/Zz?=
 =?iso-8859-1?Q?R7pISe8QbxxvGWEdsZfuH6SV9ifuqHIJMW2fmsklztOp2NXPgyJnpleKaD?=
 =?iso-8859-1?Q?80O5rYNoTM9iyWdkH62HRUqmD+VDuZrHnEAOoiO3yYoTgWgJuJ3gQ0VfO3?=
 =?iso-8859-1?Q?Bg7LN4L85YfeEtbmIMwnSUJfoL2lHKfToaEv99GmrickWIGEYCryfz8NCu?=
 =?iso-8859-1?Q?JwCr/Jh+a3DM45GaoMrsgne8RWK8JDfjPhLynkaQXPq/rhtrPS7eW9/XIq?=
 =?iso-8859-1?Q?dh/PFPd768e6c3SnheX4a87hXkdiDqurceHVJd3pTYokLVTNq9XdUeiwtF?=
 =?iso-8859-1?Q?yoc9/HJM2rMufYBjCeBbhnhU+t5wdGrjQ9DiIXKXQ9hKs+RPAJSMFqP8jG?=
 =?iso-8859-1?Q?2ZKkWIZADPcKpCQd/G2Lr8UFYrGlgM/Teo6DFAculKjJ9u6v2WiwUsR+Gf?=
 =?iso-8859-1?Q?RjbbVEr7E3xd7OaevXhWaikxkItYymmRJCe2cVPWm6v+wvwo+BKFMUv5sU?=
 =?iso-8859-1?Q?RyxN710X6cFzrlQ1Vb5zkpfkv8iamzTTUoUSd/Y/pAEmUEJaNn/fZt4xTd?=
 =?iso-8859-1?Q?l2UTIqj8N+o/78ob0JFhrwFWv1+mT9hon6KtJKsY3MZsfUDsLAwUiALo3U?=
 =?iso-8859-1?Q?n0oEHx9YD71HBUDQiI9naG3I6YCMnTpKVveDjlvIJ2Mg+SQZ48EucbERTI?=
 =?iso-8859-1?Q?lIatSEi5a26wdqiDnnk/Mb1SfXWtKWaOBdiJ3FqBFmvSfOrILPaF0nZkZo?=
 =?iso-8859-1?Q?PKm4sVtzueTIBaOmhDFP4pTbf8Py1xPEEV3UfrUHqcB7zKFqga3OrkFtl6?=
 =?iso-8859-1?Q?ZiJPuB+UDSfC8IJT15KNYYeMtiarZMGTc6PEtX5/4cvAgS9Jl1TgTnSVER?=
 =?iso-8859-1?Q?ZIV0+6rGsQgLZmkgCdtbCRiXskXpB7NGxMgcdgJu7fYswPQp4MqakJiuVd?=
 =?iso-8859-1?Q?y5HGv/SWvehK/W9jdzV8TMwQH+pYNKzNmmwZTSd/zg24gqHpRYQZw96BGF?=
 =?iso-8859-1?Q?Lij0CHnTRxBQCIYcZEjuUY31f6puuStwhc1kL6A7w7NzrBFB/UkvKWUdT3?=
 =?iso-8859-1?Q?jHaTGRgLjDpI7Txsm0W9tqmuqEMZzC1zcYfed15HH1/1mEEdpQ1tLrp6pw?=
 =?iso-8859-1?Q?Akudesj4IQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FfSYxYH1q/KkwK08to8P0lWeklgETJqfUOQJBrLashNWBckWsq1/qgWV6Vf65YEDa/gV1coxtnE2qdX0x70ONwZHRk3gSAKT6nXJZZcFWAxOa9oUKrp6LDNNCqu8mzaB/JG5r1O9/crOndYN0dhl6DCu+kVNsVPecTyLe/7ggHu/gmPgYtSmJx6FZRnYPtMXx1AMbk3YRPy+yPbDgTJoqssp6+x/dkJFu3H13PXx+VG0k0uIXA5j4unaLJoYw17JLIhcYyHHi0cHNBrBRudU4UM3gXEGVWzoGZ73pjPedVZqZ40HLjNcPmQ8c70BZRAx6nNM0qyr7ZH3kEUhoIW0Fg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec7fe01-041d-4a54-399e-08df2a812237
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:55.9179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJjzjhzlU7zZ3GhExJMLyOE3naeXeCsEcwDsKF0BnJjcSpUuEVppzgXEUnEkdRLiXqDSxgWY375LjyuxzOalniamKSK2uzGNGdP2enr9maQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF2322611A7
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The AST1040 provides an I3C at 0x74c20000, but the controller is not=0A=
modeled yet.=0A=
=0A=
Add the I3C register region as an unimplemented device to reflect the=0A=
AST1040 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 88f7a2df2c..5f6aa1503a 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -92,6 +92,7 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040=
_unimp_devs[] =3D {=0A=
     { "spi1-filter", "aspeed.spi1-filter", 0x74020400, 0x1000, -1000 },=0A=
     { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
     { "atc", "aspeed.atc", 0x74C35000, 0x100, -1000 },=0A=
+    { "i3c", "aspeed.i3c", 0x74C20000, 0x8000, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=


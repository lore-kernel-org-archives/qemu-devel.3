Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B21E83EE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8y-00060s-Hu; Wed, 04 Feb 2026 02:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZS-0004k4-VB; Wed, 04 Feb 2026 01:41:02 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZQ-0004IG-JF; Wed, 04 Feb 2026 01:41:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUf0U1VSHDQqK5D6N8I8G35dl7ICKAdhjPLf2QD+7AxUKOFbpLwNd8W5St+/Z4zUPsJ7EgCqg24unHZQ424Ru++eZkbxC+3A8etOAYSxMM/aNKpUS7VQU7lBlXGnIERZFStb7oYK8LqgNlw/OeGMSM2Jhld26urjocTuSBHfqJCrIYIqxb41UWDvGxae2bQFYSGyPMtKQ4WdVtwrjzx7gAUYi3+b30/9cqgSbK37+/2E9myzVOW7CoEUYgxFvbTy+iWfv1TIx1oQIXJKFLm9mmzo+j5y54op9rL5lR2VqrtwQ0Kn8jTIZJmV9YAlqRB4ka+vnxp17NnV/X2dEcbljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaATaDJ9RMS+40MZUsvlBfuJuN63BbZOmKJihnxTg8w=;
 b=D7g/xZt8Vo8Kp6OG1c1a62em2P8XXibc8iz4ni5gfYXazgyATTnceXGJRuuZfA5mBSiCqPh2Owc4b+oyb0mjfpo84SPOq3Kq7lKB/8/hDCZbiEiNSAZ3ZfuUp5/oyNEBaCL09ZN3dMw6cchP7RCIEkVUzQP/Bmu6k7qrPBc/ZYhPBzPRhaq5ywKCe55PFbCg5knGfyt5J3SRmYgdSxT5hQZcGhFSEQUG29KwyhHxu0gmTWbj4OSpIeaaL7HqIf+r/jRBwaf8DmN6Vd09Sq21yzbWh++Do4QVsSJuhGT4+ul4oOx1kfX/eMQu4O+A7nh0TTmUzQQc3MWM5av2dQEXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaATaDJ9RMS+40MZUsvlBfuJuN63BbZOmKJihnxTg8w=;
 b=e1zkDgbWqZm+eOF8SmD7/6S15yl3tJf4BZ5ic80BpNbZ9A89S0ArdDSgKcFoqTTDWaWQV0gmaUuT6mwRe8GPJmI5Y+2VmvYZ72KU2wVvcvCOFoyC+myPb0Orks8Vu6/ilMTZb7YLhOIb1mbGE4cqDRMppwUGIROLgvYzaVBZkJgGvcFmMfpFZu/adxlTmFvGXzVCh0VOrBMBz3pFaEclMzYxs1HZs9ASuXrS2ShpuZYH0bn5/Gvf9Aytpr2oBLgdR489+DxPCJwWJXpFMcEGv5Rftj3GJsoctTqNh7+Ak40J6HrzzyFqUXKo8t9VchB4Ngz+zswUDXz8IzCTGlc5Ag==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:47 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:47 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v6 22/22] tests/functional/aarch64: Add I2C test for AST1700
 IO expanders
Thread-Topic: [PATCH v6 22/22] tests/functional/aarch64: Add I2C test for
 AST1700 IO expanders
Thread-Index: AQHclaEyVH1SA3XMfEmdtx+yav+jQw==
Date: Wed, 4 Feb 2026 06:40:47 +0000
Message-ID: <20260204064016.3515639-23-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: b03093ff-073a-4189-846d-08de63b85486
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Fi0IWtbn2LvEOqcGZ7neMvtaPGDFXcDV2gip0g2D/Eu8/dFeqqeyejh8R2?=
 =?iso-8859-1?Q?RkvoN77UNfANnGjavgEbKkjVOcaVJlxnnPkIygYEyx/1x4nDfWu4LkoPNA?=
 =?iso-8859-1?Q?ivCpDPWMBn6ESexH93k5C/sT+hB/KN7+SALsTNU3zbJqf51aIDvoZk/otA?=
 =?iso-8859-1?Q?7udbuIfysaP5nTnUgfOdT6b9dYfQUg0UY0C99DdaPJcScPWv5kaP2+slbV?=
 =?iso-8859-1?Q?S0qoSjmHPAhW30qGWYzK7LnJvFKkyI90uGRc1rKXdIyT8vPyGiK+eCWvQI?=
 =?iso-8859-1?Q?OYB1z83PRRy6v5UU83uwG2TGBH16ogbEl57N2qcyqqIrthHI8WJ34uEfVp?=
 =?iso-8859-1?Q?jcZBzkCNguB8LME53A3MRJ53vjDIWAYswAGuXBPpe4V7ve4LHEDM6eWF1O?=
 =?iso-8859-1?Q?e5ytpFiKc2e8r378ozuZXADXQYNTPRnfA+LNeoClWjsDh95WHLaWtQdym7?=
 =?iso-8859-1?Q?faGG/wr8933ds1YYHV+s+tQIQnmPfx8hX4DwVaK2v1eNDwtc3mT1qQdgsD?=
 =?iso-8859-1?Q?8CDrAScCfJgEdx9k5hscMPo1UsOr1zata87OhF8mticD5jRpIWKqIqRv9v?=
 =?iso-8859-1?Q?9e3Hz765uRexmFLF8abwBsa4F2wKqTlNVLsW381/7qdLFSTeHSPRLTDCrr?=
 =?iso-8859-1?Q?T1yrhhdUtbo4iuAk00Ys+SlhoCZ9bZ3xwOYKiw/jOVl7BsodzsjJycc9Rs?=
 =?iso-8859-1?Q?M40EloUeAMwyqIyODsdXIoxgnFMcu76Xii+OK4dX54wCBkdg7IxlnRYPed?=
 =?iso-8859-1?Q?a9eETBnVWDDMhPq/WYY4LLAjKWC7WHntYuskzarDzvHFPohLfSPwdebGV6?=
 =?iso-8859-1?Q?zuVbLfai2Yr1xuBFFQlMVNN0ksHrR0RPL7jf3UHNBFaV+/VbbS2rgBGfpy?=
 =?iso-8859-1?Q?Hl4ea+oSmmi5eEUevO7BG+HKAWIh32UR85W1O66akuZo52Ywtop3O7xZRO?=
 =?iso-8859-1?Q?GtGtJ/G2MjfdaM41iIaLJiDWLUl4JNJt1ALcGLuE3EKr1ZbQIBSjMfbuKt?=
 =?iso-8859-1?Q?VilSc5oq+Ejm5WKYofDQbMIQ0Gaxznp72KCQI1vH92r+VxOXmY9gMTDylN?=
 =?iso-8859-1?Q?Z0fiKS4l0YYZtUn/56iNlWXh3OCtMgzQ8zWT7yfaWEC2HhKVLIb+Q7HAGK?=
 =?iso-8859-1?Q?h/HuD4YGIzy+bgO0vtF5ZaYc87cCWG3tcdCTGJ/rueBWcnQ30MkbqhrRKq?=
 =?iso-8859-1?Q?I70UO2Atm3IpUjgiOack/New42ZK2OKUZ92/XXmTpizDOkM3UeQzSBmPH4?=
 =?iso-8859-1?Q?JTjqFBes0iZtJY22GUXPXRgz/u6O8Eurm5fjOiaJ0c1bZaZ9js6et5xlAj?=
 =?iso-8859-1?Q?+nSHurt0G0vYXO9RkD/nsvARsVtbwfw4eNMIMBYSlPpr8zV5NYwA2a/7uW?=
 =?iso-8859-1?Q?IyU8q+8IVDmvxPPE5RvxK0V6/PPL0ZF2yAG7uirRE0O3IHqPrf4VCZLn+K?=
 =?iso-8859-1?Q?utf1YGQJ4LCNTPRblz8AEjAJfM855WGb7Vzs/UvDkiOqhSfX0jUApon2Sq?=
 =?iso-8859-1?Q?QFr574gUWvPtPHX6lsuJF1uzgQOlrkTzdfZII/cHWYGu4l1hmJZyCELVYE?=
 =?iso-8859-1?Q?rpx5CP/vL3359LTFIiesAiPf7vTGqRxvYuUbdjR5hO9Jy3cna/tqjTFlrt?=
 =?iso-8859-1?Q?O5GiB3lytHeYgONskeHRxj7TPH4sLstSQ0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZVGoqpShb/q6CO4ur0gDDnxzhtX86l+ehYpVguiLcsFDcdcYBRBXtc1VWL?=
 =?iso-8859-1?Q?LB3g0rg5rEmEsHeCzK/z6qzA5ILENQ3oolJEe78so1vIkIwrXgR4KiHnjK?=
 =?iso-8859-1?Q?8Go/FPJtpv59dKI6uY18sKhfFTMcLRP9hvqdHt+WMd0ZhfqBU2hSYjohdy?=
 =?iso-8859-1?Q?4RJPRRrt5nLmNOAKLtlaud02P6h1CtbvF/abmiT6N/1n2s7czwi9OirnOW?=
 =?iso-8859-1?Q?hsDouJPRmaR7Uxbn76M36Y33IrI+epq2Vx30ysCbi3MISf/FhADqEzc2Bw?=
 =?iso-8859-1?Q?/BA08ROmM+LZM6vdi2KPyESaHkl+8zRPRTzB84H3MOaoo4P9VOA5+LCxsn?=
 =?iso-8859-1?Q?6c2+HwJSnbvzJ/onmVu7NVqZQqGyJ05bTYAnGO/f+Yh2c94jp06qBFdyKu?=
 =?iso-8859-1?Q?XemrI3hXJ9MQfaNskuFEyX54II1gdG1IMZ9/dohrd5Ga/vCRtkMLWzRZ69?=
 =?iso-8859-1?Q?ZoCID80seG2rccGswVb3HYaruCBicNtStderZTeIMmIMTV9odZVc+x4WJO?=
 =?iso-8859-1?Q?CkKQVOO1krsoWgcEBhTTtVqENjrU0Scvxra9OacyBT0CVyB0jXQQ8jhSfW?=
 =?iso-8859-1?Q?19q5CLkiMSwvVlkvo0NWzGelTPygpmbESMJUvdg2zAqR8fJt2MHo4zhEfG?=
 =?iso-8859-1?Q?ZUIvOkKdBZmUn8bskl0SkBRXO0kSSedSNGTJWEFxHWXQtS3vlG75p7kXUK?=
 =?iso-8859-1?Q?dkFe3wtNyfTJLXeu+gyPyomilT4gphHo2+ff/5SWwzNZn8RPo0NTKA6xJF?=
 =?iso-8859-1?Q?BlTquz55YX8x4yidD7k+N4R38HriegFpKgLtG9U0ULdklV+vPOuzyNRnFQ?=
 =?iso-8859-1?Q?Se3zLm9FBNq9FduZKRlTsAX0DPf9Pa1mFZmGcYe8dDvrpdXjKVUPk6y4rr?=
 =?iso-8859-1?Q?eywwVOB/oLseO1Wvfwfvwk9Alf2gaT4V4p8Cx2vEXJnqGpVxnP8Tu1IwkY?=
 =?iso-8859-1?Q?wJ88nPRUjtfs7N+eb8tetZXAHRGl9x1NXyImjlQR/JSRW8S2O5OsFm9KxL?=
 =?iso-8859-1?Q?BaRdbq5CEC9Q7D8x4fuI/1sACZfvzjIygf4/TR5rrvlPzYnekJL/fZXnbO?=
 =?iso-8859-1?Q?ap00WEQa6wlRKCRqv5oqPy6921Y2sDOrPa8ogAdxC3SaopdllJecJVptRZ?=
 =?iso-8859-1?Q?UZTzrer27IwsEUk9+BKToSOqcf3i5xTTL0af/MTrlSloKsNsrEwOJLiZOn?=
 =?iso-8859-1?Q?UBlVAw4aQ4zSX5UGEVVvus2xt/aprgKjA9Q9p+jOPguewf11BsseMcpWbb?=
 =?iso-8859-1?Q?MSj47IllBLLoD7irkCXT+LMJk+1y0cJqztjP4fp7KBUqsejDQ/omrkjBDU?=
 =?iso-8859-1?Q?6hd7N9+xe2VKDTTqYpMisjexG8pIoMGJz2KDp/UMeMluC6rjAvH86V/20X?=
 =?iso-8859-1?Q?Na+Qg+CPFrdBMgEv9NmNFUVLAPUnYZEEES21lNOvTWwu4gncHbOpxkGzeg?=
 =?iso-8859-1?Q?rMobXYLEgmzOLIgWJfDadxl4/QdKuuFNgW14YPx6lTM92IvLIjKH9y17U3?=
 =?iso-8859-1?Q?Y0eVzh6hk2w2jA2JmP1JKv3A5RyTYN1WPJTij57+o9O5KmuVsIlhZG+6AU?=
 =?iso-8859-1?Q?40up9YDmQFELdURWFO9fPCzNN5AeCHexillUjmO8TBZGDE9fNYrBBex4Ps?=
 =?iso-8859-1?Q?exjbtXaQ6qfJaCGnwmliLL/pBcgmOed6oT4iWkkyO8SpQ6WA99qLNS+2Ah?=
 =?iso-8859-1?Q?qpSMvz1zbMFgdOvUiusAdEe/ycacsefS27SofLR0okXHHJJFHGFq5A6Mmq?=
 =?iso-8859-1?Q?St5ebgY0MuMeKLhA8Wq64p74d4nvYbeHV5NhmdDKbv19CbXw9P6ZnHBHUq?=
 =?iso-8859-1?Q?RgsYKL/C0Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03093ff-073a-4189-846d-08de63b85486
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:47.5942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89t1OFevvwpu79KvIDScmN0Glwq7WaSwCIAEip/FXj5jBAbh01GMES883g7rogtynXSGSabwDJZTwMtd7DZGt2tWBoasqTjVey4Igv009y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
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

Extend the AST2700 test suite to verify I2C connectivity on AST1700=0A=
IO expanders using the DCSCM image. This validates the new bus-label=0A=
naming scheme by testing communication on both primary and=0A=
expander-attached I2C buses.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700.py | 17 +++++++++++++++++=0A=
 1 file changed, 17 insertions(+)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index cb1aafeb99..61373ffe5b 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -82,6 +82,10 @@ def verify_openbmc_boot_and_login(self, name, enable_pci=
e=3DTrue):=0A=
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
             'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
 =0A=
+    ASSET_SDK_V1100_AST2700A1_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-dcscm-obmc.tar.gz',=0A=
+            '4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd55=
87f')=0A=
+=0A=
     def do_ast2700_i2c_test(self, bus_id):=0A=
         bus_str =3D str(bus_id)=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -166,5 +170,18 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(sel=
f):=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
+    def test_aarch64_ast2700a1_evb_ioexp_v11_00(self):=0A=
+        self.set_machine('ast2700a1-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1_DCSCM)=0A=
+        self.vm.set_machine('ast2700a1-evb,fmc-model=3Dw25q512jv')=0A=
+        self.vm.add_args('-device',=0A=
+                         'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
+        self.start_ast2700_test('ast2700-a1-dcscm', 8)=0A=
+        self.verify_openbmc_boot_and_login('ast2700-a1-dcscm', False)=0A=
+        self.do_ast2700_i2c_test(8)=0A=
+        self.do_ast2700_i2c_test(16)=0A=
+=0A=
 if __name__ =3D=3D '__main__':=0A=
     QemuSystemTest.main()=0A=
-- =0A=
2.43.0=0A=


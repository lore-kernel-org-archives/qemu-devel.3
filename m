Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608EDEA3F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1Y-0003Hk-2O; Tue, 10 Feb 2026 00:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1M-00037w-CY; Tue, 10 Feb 2026 00:10:44 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1K-0000Hj-Lt; Tue, 10 Feb 2026 00:10:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXYM4rap6//r6v5aiRwjvCuTSxQ90CEBnwzXTcShf1yNzfer7pD3Jz+4f3TZUlXNG9ccK0Z7I6SWQnJ1tkcOwG866wiyFdXRMQDQPicPix6TwmpeNcWw1jEsLPJUd1hMTisM28vIJyAeEX5YKPdkxpr3cbk96pVcZelQu8gFHZwOn2Dty5uBARx7xki963GyD2nhjqJftJeMOp8MLMiJeynGpGWk6RPPqly6KdFDK7ckbyoRvIt7sz/Bt7VpxIaa9CzJugXEXSJOj4HjrShcSN2+z6q3Q7lsjLJOu40TAV9ExP9Li9/PDxL2YMA/CRUjpiErMcmqwNLjMa7O1s6i/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeTHWSskSyGNS2CXZF9s+q2SrqrqAzurj1QDwDpgv4w=;
 b=nZlwz+kLRAC0t744qQjoTTILiSQ4Ywr0vO4Va/x4Cj3o1NFs8+qT1nv36JmE4nRNb3WqkqETbfqp+g6tVFYectuN2DLcLL+IWAT4lvip78GdJZ9zTEvAiwl3vf8GgZh3J3QiHDeU0dT9iEdrYV16gwqb14BSHOOdGExWbFhrwiE5tUOrcQak6y2yyOsIil4X0boMcIrRr/SMGn4nfQ066QqW5/WdDoLDDuHerJEoYBJf0PkmG6FPcVA0DpWzk9QTl/EHH9Q4uMnbBIRV0nr2wmy7Xpt81pWCUnD/x5jGEuKTPBr+6xQtdsL5Yl1QWy/nlnn7EhSFkd/RBU2C9vss8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeTHWSskSyGNS2CXZF9s+q2SrqrqAzurj1QDwDpgv4w=;
 b=dswX0sv0DTGPGbHiOxgmelKEFVl7/1ggqTpj/tgKPW1NgwKOsHDZFy4t96apc1FYnJ/CJOBCArBwx7H/msZ6m7x9VWKZ/K0xHz3ApsMWaQfWxgd3Kn3k/PjtQgydvmrpQHN3X3Lv7JUtNglOxxmKAH1fpVR97OLvHV5C07+ufv4XLm8wjG2/3dU4wxinykqri5UkWhWlTMpsgY0CS7GWSNkkA/IbGwIhBC+5i3dVxObhcvz+JYQgKGEb/9W2Mp3+gpGBg1+qp2ZgisASzcimFRjJXmblkKRw3w1NvwhaC2rH8r5RPWNlWS3ybdymwCUiNdY3Igmk2DvtMKd897I4QA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY1PPF9851F8D71.apcprd06.prod.outlook.com (2603:1096:408::91f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 05:10:21 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:19 +0000
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
Subject: [PATCH v2 09/11] hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC machine
 to A2 SoC
Thread-Topic: [PATCH v2 09/11] hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC
 machine to A2 SoC
Thread-Index: AQHcmkuNChoLPve49USpW1ABgsXg6w==
Date: Tue, 10 Feb 2026 05:10:19 +0000
Message-ID: <20260210051008.355149-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: e62b9579-bb6a-46d9-1952-08de6862afd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Q1pfbmaRR7+lljLX+StuHZs+cwfB9tOBjGmR98FwGFa1ha6xTC4+GdW83P?=
 =?iso-8859-1?Q?Ao3PeR7RlrmV46vpJFOsGkFg7qIYr/2pzhzYTDFmqOmqKz/zmKIxvjWupw?=
 =?iso-8859-1?Q?p+QJyTjT8hKCUVSw0affNxnCn5G1ZgH17uM2IonzKHioiDhcdP1kFoORQq?=
 =?iso-8859-1?Q?GGMvS3OxN9VARVheRStHTkDJYnSWe551vSIkVk/QZSAdGYjM25KRGCItOP?=
 =?iso-8859-1?Q?zP/V7cqmWSh0NjHHIqrMKsHyoBj5kWnk8eClu5STTJPeryTzU2tt2r6Jbl?=
 =?iso-8859-1?Q?+N3046I+8zZCw8R4tVMCtEvNEZsrgKUGj7Dl3XMutKW2wbtndL+AYfQynP?=
 =?iso-8859-1?Q?zn7B8xD+pgutnWqMtQ3ttA5LOBAGCq9NpT7kxxIeUwA9V+2etQFLuhymcR?=
 =?iso-8859-1?Q?kjysO/CvGpNHkmvSjStzYkD2Kd70Ycs9WVm+Pu0bTcDu1Zl2fI2nKfP2YS?=
 =?iso-8859-1?Q?mp46/9eWX18Z4NaZJW4ZggbRpihKyFx08Pvg8CK+fH+J3lGGZT7nuzuS5o?=
 =?iso-8859-1?Q?R7yA27hkD3+Ov7GC+PulEGoMJeXyEQdDER0m/gB/MI0X2eo4wafBs+YMLd?=
 =?iso-8859-1?Q?DuXd6AY/L0ZGr6JKtsdxcTdMC/Z53LlFndrRgo4AkIbRjbQjANgoBRrnqo?=
 =?iso-8859-1?Q?JbJ0YL1FmnqTxCVUM5yf2I8DpRK9MJqDbd9Up7LfA6AU8pMazFhN0XxNng?=
 =?iso-8859-1?Q?VBgQPqVTCLS8/sxDzdYfKKY03jeB7YYJJwLaRn3Wgg9ef2qne88/+bLfvu?=
 =?iso-8859-1?Q?6NsU6A1gUzCcymj087Stmo1IZHdK4niW8+PEoqz7QQYC7KeTR3MEOXkdn/?=
 =?iso-8859-1?Q?ZqOHnbQlE0gK0LiOKUIwCjN2oMj0VnL1Dq4z3hdcReH5qEiD4/3MAiz9Z6?=
 =?iso-8859-1?Q?H2ms0RE2GYeWxeQ4+NU6JwY1Aczo/ijyl06K/D7xo0zs6rRaopVsCJrByX?=
 =?iso-8859-1?Q?CUmm6eXfQyEeTlhdM5shhmFRZViBHM33YH8z4eQYAHrjLTMsU1Rhmm4k11?=
 =?iso-8859-1?Q?O5m+AZRVTP36/+sXvit4PrhzlX7rxMVScxzdDa+9lsqZ07weHMRfQ/NwAx?=
 =?iso-8859-1?Q?9J1ZDxl9rtWTqLRjd4XuIgnFxZgl2Hp7hQDSJVUx2PiD/9gLWVXu+0JRb4?=
 =?iso-8859-1?Q?39cVtLpmWi5JLSJVu+dMM6+mG3c8/7FUsfJksSJhbV8aXNKT11vW5tKxKJ?=
 =?iso-8859-1?Q?eCWJlacMLqFOBxFK9oqp0W45Awqrjv/asW1ug1szguZrNwbel5Yyc4/Mtr?=
 =?iso-8859-1?Q?gMcrsZghLzNVWvD6saP4nQeZALklWYoZnphMMlf0QSRjB7RXyToFRZW3li?=
 =?iso-8859-1?Q?7C8EFZ4jhZqKzQeedU5MTqnT1AAV2oJv2VVxihdnXjLPCjCcnkdUzGpRJ4?=
 =?iso-8859-1?Q?HjDMJH9HMLAqrtNI4Ur1Ey2lrv8u2JinusMvOdmlRs0nWFzhlafcT1+cDf?=
 =?iso-8859-1?Q?JlenWNDBFIIiCT+WEytIVacSRkwgcef+b/AGWOmpGN7KFEPPQ4ARZKNZ7O?=
 =?iso-8859-1?Q?+qa0OXjxIbjnaGMdFNPQBxXl9mDUU1so5IIqyhnNHpGR2UCaABUAkkWsLi?=
 =?iso-8859-1?Q?ycdc5yPQnlP/g7L0nGVvrT/v2OyP2u7cq/qZdkTiV93fljLH4GPZMIgfYM?=
 =?iso-8859-1?Q?e+aKegb5rtVVPZiLWMaXGSVn2ktjHcWk8XAu/nxrBESredelkhXM6YF9jo?=
 =?iso-8859-1?Q?1qlYF1SZHUhKOkc52+WmPOgeC8Qt1o/E7oPbvRpc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dQ3rIIRUkfkfKUGk+vEJRMGoh/wWbUDyIAxnNPa9iMVA4fE87sYF2d3oVG?=
 =?iso-8859-1?Q?KQTtXQ7Corfs1B92C+R7X1sxi/Jea0A3mg8UsyAlChG2VaAsrLl6iYQ40K?=
 =?iso-8859-1?Q?rcpYcjkIUURgnUvFF63802j++kqhBZThq4wzj5vYiGquxh4loyP+GJWaCG?=
 =?iso-8859-1?Q?fy35uH7Jt+aFaQwuXQqcFIxlupLnDpbu4FdgQy1VfbcB61EYoARVW8ltPi?=
 =?iso-8859-1?Q?+jwxHWNjUyYL6EQchMhGBzV6N1FWUzIuatsq5f9gqIoQKjHnzCuCteDWQT?=
 =?iso-8859-1?Q?iOeqXeIXXzswTUan81jv59tBEm0HbZ1zQbWTPPqQKdIBBtRqyxD04y9PNt?=
 =?iso-8859-1?Q?KsTnB1q0jDmasq/crH5SVYLBOvM3lF6liPtYr+g5CkbPPmfDB8//Pz4pYb?=
 =?iso-8859-1?Q?d2ChPwsD2cglPDAjts9ICssSO/MuVovVasj+roEK/7oBFdYiW4I+ESoCMk?=
 =?iso-8859-1?Q?3lxZCz4ctS/lPsyRC2SyqUElMp1oM44Eimkt3jah1dwbWgOAZmlOO/4VwS?=
 =?iso-8859-1?Q?Z3OYJqdPCoiSeCN77mASooXU3WxZP4W7epYbdlo4oJ5Fes90XTPxI2mOwa?=
 =?iso-8859-1?Q?sBMibApI6kXaW213/NzhSMZkSejO1yVASjOu+y64pdcxaJ50lObwMboEVV?=
 =?iso-8859-1?Q?AoKCRfUgsP5Ko0WMMLwmlh4xrpwFi+QRJkBe9397PHQNGlIvV/gB4YWz5Z?=
 =?iso-8859-1?Q?qKslrSwc5s73MZ/Pgnz7iiZYdF4/ORDP+aZTASDiVMHUhr1khS9Gfa8bk2?=
 =?iso-8859-1?Q?/wxSTyW3YMTA+EsoiZ3vl/CZZbgTGM/lsb4HE3qE3tzW7fg0lIkN1YJDmA?=
 =?iso-8859-1?Q?litLL+GseXlnrBoFEzY79TWMd+KS/54zFZhjIsXQF17vFtyyW6HdaZofll?=
 =?iso-8859-1?Q?PCPQ43PnyrcRHOwTxwMJfixQ4q/Ty7BP06CQqp+vS2anoNoz6WkQ0xm7eL?=
 =?iso-8859-1?Q?qfnMpHpxLIBHwxr8VSIo2SZ3lufiaKsOlzNGNJkvce1z3PywzH8kg3ZGiY?=
 =?iso-8859-1?Q?ASbWcW/ETue0anZDCCU19+vnreUvSGFAdrIrY/0LZJNMQg+TQ5CH9kX+nb?=
 =?iso-8859-1?Q?5bIfHWYil4ogjEoCOjHNOE51hr1qsW9jnOXOE3Xl2NbrEp1WeFTGFA66nh?=
 =?iso-8859-1?Q?JUGDPtR/N8KUk+/WJmSLXkn87IUW6soAvgTmg9AEwJumm1FFkDZk0S5G+3?=
 =?iso-8859-1?Q?YM2R5Rq5dgwkoopl35+zH0Bj0LfyQCxnlwycWTU+5V4NWDyBbMhm5ffHJR?=
 =?iso-8859-1?Q?5O1Qg7Y4inC0Y4bsN5GYoCcH6/PfjjMRttVrOa8Rxy2MaU2lnXIBHt8Ybj?=
 =?iso-8859-1?Q?0HVlbHJGqn6+Q7taTZ0apg1QehaX41AhKAVZ7Ao10KQiYaCxBlK9SGzieV?=
 =?iso-8859-1?Q?1YeDMGmu+bHOO8SEsMfPz8CHtif7PpX96WSwcMlf9Ugctl+G/XwhTSKcfv?=
 =?iso-8859-1?Q?lActXS32QLCuZleyYDbGcpkhMQargREiPWaTlvTmuQI5GgseNxB2bdbRY7?=
 =?iso-8859-1?Q?jJK56zA0LxRcz8V2WPvUOKh8W4icRNmI07cTL0oAA2H2KRFz8F6Z7PnXiB?=
 =?iso-8859-1?Q?57e0Wl+1K0f3sS5HdOBWqUoxW+R8yx6YR6qXoGFR9j/zA8isn9WlAr02Ey?=
 =?iso-8859-1?Q?kPPxEKWh27HAaYQ/xKZMA2owb1YwrntPktIo/mY7Ctn7OzrQY+Iikx2kzf?=
 =?iso-8859-1?Q?K3D300ZgbbRR9+av+H3pVnj8inemkIkpALWU1Lo8flXnW5BqjCKp/4v3VJ?=
 =?iso-8859-1?Q?Pj5MB0avWjl8d/0ydj687OoNEvmaMWKX0xUSoODtXWgktWY5sj9jLKjYor?=
 =?iso-8859-1?Q?8oBNG0bANw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62b9579-bb6a-46d9-1952-08de6862afd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:19.9281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWqof/PRd/XH3H3oBA3fIkVQ9TsZ2PGO59rHVfR9UlqFVluB9Rt94DcOLbFflv6NbiCEAnuDRu2STD5RCFCd8GxO+SjfJfSFe/RFAKmMa14=
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

Update the AST2700 FC machine to use the AST2700 A2 SoC model instead of=0A=
the A1-specific variant.=0A=
=0A=
This change removes A1-specific naming and definitions from the FC=0A=
machine and aligns it with the newer AST2700 A2 silicon.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-fc.c | 13 ++++++-------=0A=
 1 file changed, 6 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 0502a137f3..9b9bb2df75 100644=0A=
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
@@ -49,7 +49,6 @@ struct Ast2700FCState {=0A=
 };=0A=
 =0A=
 #define AST2700FC_BMC_RAM_SIZE (1 * GiB)=0A=
-#define AST2700FC_CM4_DRAM_SIZE (32 * MiB)=0A=
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


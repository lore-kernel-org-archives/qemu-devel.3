Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C72EA3F05
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1Y-0003Ix-Fx; Tue, 10 Feb 2026 00:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1P-0003Ax-TA; Tue, 10 Feb 2026 00:10:47 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg1N-0000Hj-O2; Tue, 10 Feb 2026 00:10:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7SKEqSosxNz95YEGZ3bUcVqEUVBdRhen3iAeipQaeh07x1Pb8lUyxZ8MT69SwEcYuwJAhrt4yqo3NNif+kpoaRl1J2xB4xqihnEtZZEHfDFTq620kmI2V7LIJ2+Secbe9mipy8oOj7XGLa1QKUZaGDYJJ/JBGlE2z1rGN2+A2Ujj9ksefw2mZjDKhu82kI9yDPDrsMGL5KGr/dVqWLtnFTvgDfiZt1M6m4CoWinFihWIUlDNa7376WMacCOpe9WMVIVBJi6Xbk9C96zuk/Iz8wisU3VHigTL79A1d2pWH/j8KGaLIgHfCwJ3Yef+ygkHhbabQA9ZMiQADqdI6/z7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07EAgOjzdZTNW9LZ+Xu7cUQ7snaN16ZT/XRVu6ks0WQ=;
 b=uVNyz171w+WWiucaNOZ31njNCkuuolQQ/hMWnXIPRAP4xfrSfhwS7Unu1Hx3bDq+S0dsmZLe8BFLeT/8TYhyGSMlNOPn5WEDSKT+nPsr5TOsdTc1auO9SbV/0Z9ikuJlzjOZFLz3dDmiz3XaT7zp13X+T+xQ1F0rGOWOBKGzVqf8pdByk1O8zlt1b8+VpgfhQQ8MQz7MWHALK/5nIJHnjQssio0APEHGhGTA66E5z/d/nJhlbrQ7UVfWlwe2nZSVYNzrzyodKrfZQS1ROiA0fWBJdShuraeh2dX2CsCPR2UeBRvS5CfBByPW2t4cfipyipkWQ+MmC1jaA2wBdA6OaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07EAgOjzdZTNW9LZ+Xu7cUQ7snaN16ZT/XRVu6ks0WQ=;
 b=eevCCT6cghyXXubBF7SrB7fHTsT7w7ZuCdaTf4QMqnuJ1pFiEPIfTO/g8m/MzQRuCgOdNvKroURcYxbtIZPt/FaqU9GIHtUZEyUGw9enK+VdFbGj9iaOSmj+sKIRwZX20LlhxuJEcyGWbX6Law9F97A55d68823tI0fh+a5PIL6z4WdE3COIS3bNgHV1QAW6IxUkA7EHAbetsUha9qpJFo5m0Em4QdJDDJFHNi11tt46EnkHvSh+JozOHw5rRvD0sAKGFiBkwMADxVR0PjKmeow7OjNnQj87KDfvYibyEv3K0eGOkO1chfw55lalM0fXlTiRSv2s4GWkgigwecvNyw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY1PPF9851F8D71.apcprd06.prod.outlook.com (2603:1096:408::91f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 05:10:22 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:22 +0000
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
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v2 11/11] tests/functional/aarch64/test_aspeed_ast2700fc: Use
 AST2700 A2 SDK image for FC tests
Thread-Topic: [PATCH v2 11/11] tests/functional/aarch64/test_aspeed_ast2700fc:
 Use AST2700 A2 SDK image for FC tests
Thread-Index: AQHcmkuOYQWUUK9eYkGXgFVuuqJyVw==
Date: Tue, 10 Feb 2026 05:10:22 +0000
Message-ID: <20260210051008.355149-12-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 3003226f-1e77-4b75-17f6-08de6862b187
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mkuKwqj4v3iSyDsszA6WSBrrXQngFLb6w/AIVhGObXbBud9rqEBOOTWhKm?=
 =?iso-8859-1?Q?w7UtqBwDJa7bMQ6rsN4AnC9YhJLbLA5UpvHyrkxowjUbaeDUeHcyAkbGbf?=
 =?iso-8859-1?Q?Gfn6Xi3l2EoCQYwt1ZoTVQGsRjelUYs1XeVeLSCFVFxG6D0YF0d+x57Q4E?=
 =?iso-8859-1?Q?ztJtAw4DmWdaW1ioztCdZLHpu8slpUTXR0DlYob11KhoBiIgwOo8XQ2QoE?=
 =?iso-8859-1?Q?WGZTtl8obT8YA4OVTHomr+fudpEEP6FfO0gg1dKQ0zebuf1d76U2U9Gjxq?=
 =?iso-8859-1?Q?0zPVeaxNyIuWWoCgejURwXvxft5jzasVMkNBrwlf5l1PpW46uBYqPekbAp?=
 =?iso-8859-1?Q?6LT5JN/5tTKuhscMAPuV2vWKP6M6f698ewmPyMu/pZ3myKZ37KbOj9MaYe?=
 =?iso-8859-1?Q?3dE8zeJwPqn9GrOWSiT8LRCOOanjHkZGP8dLxZo/vI9HCqSCmHFD1e1uYr?=
 =?iso-8859-1?Q?dROyYtEULg4e2rQarnzAT0Nc8Zc7D11ErqZiHj0wDeMljmm83qjSOUbWGm?=
 =?iso-8859-1?Q?TORen2BnKfAOQv7s1e6fguWqSCvyA8qN6aItJeEwspK2PM93XtgnjUPHnK?=
 =?iso-8859-1?Q?qIkGGEuWH/HBnVu6pZtoNjHLAPimOcCd96AIq3WRLQ/oo/DL1c0VcTSj62?=
 =?iso-8859-1?Q?kVJOh4VJ58jm/rnxKJsWoIZ5iITjIrt/3L7zonUuYHCyBEV2zkQygX4RZ+?=
 =?iso-8859-1?Q?iNQbPZ3QCdfKnUuWqKCA4RXDOiw5Ljv+djo1LEM9tVRXfvmnP2nI+Vo1bN?=
 =?iso-8859-1?Q?nd0Gr04kGjv3VXnj512mkNPLaVd7uDAMi2uZ+OwnjmAapyyqjkTXeFDaBR?=
 =?iso-8859-1?Q?pSQB3x6k2dtXLiGM5LjKql4d83bxqfNzOkPY5AUEWiS+lXT63/jlk6M8Xi?=
 =?iso-8859-1?Q?irHw0jUffJje81MIRGyjKHpJHVpoh/WsrkgmH+g/YzV03296EMBXTicapj?=
 =?iso-8859-1?Q?a05Hiqsb+4kIcaLGq4geQZ9Tes0u5fWkCy3HsnIs5DueFFsOYL9NE8YbDt?=
 =?iso-8859-1?Q?v6u0VNhIwGtG9blusuPSeNHCOxK9NnqH4cAntqT4AuQIatVzY64XvWwNLp?=
 =?iso-8859-1?Q?TtxHymRK/NvM5JI7jLFq7+YK7vu4Bf/+Nud0Ru5d5tDSh9eRA2ltXneqLC?=
 =?iso-8859-1?Q?tuWvfRj1wlHCjKbYuoxAvdkOnqymr91RM0BhUm9ysov4IT5gmrjpCZHICc?=
 =?iso-8859-1?Q?hz22881CqRBQZFGblFY7Z7TbUgnQOysrBbbE70HiZNOsqjS68KTr90nV/R?=
 =?iso-8859-1?Q?zZRbuQCx85H4wSZw/rrbuliVqKlTD0AeX3JdY7lLkFcw5VC7kq3wtc+LMe?=
 =?iso-8859-1?Q?mHIkVjAPlIaE20FFJhx1DUtUwyKisYG3RbEW7KBhIei6M1XKszyRKBmP5m?=
 =?iso-8859-1?Q?qbv7T8d77XS9ZGexa0fuAM2U3hlcr97Ow0UsTxKHAj30VOWPRTMjmG6h1B?=
 =?iso-8859-1?Q?1Z6K5MQB7Wnvqxx3+Ndfhs2RY4Dk00n5DaznJTlu2LFTweclhvVT2iQUiW?=
 =?iso-8859-1?Q?UGJoZoA2mtAYYSdaUi8tjsGWe80+dhAhgi4dogIE5eHBk7Waufe9ZlXC3v?=
 =?iso-8859-1?Q?GRpsHwzmPdB1Jkd0IGqYkdbz0ZUC3eUGoRdvmslN53+bJiIFPhduyl50xc?=
 =?iso-8859-1?Q?7W0am76+ceLalClrfL0j/ngDRdRCj+P0TjpGHvliDD7Rk57USphMOnjA?=
 =?iso-8859-1?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G3j8OrbGGRK1KVSjutMXZ8xJ62/OiFLZ/jAQnTfR0zZGw4rJzAJJsme0kE?=
 =?iso-8859-1?Q?C+WIrvdmZ7kt7IHo8E/7ovGUwWQ28SNunTxIHrMbUMUNASGOL3kJBiNZ28?=
 =?iso-8859-1?Q?RB2/uSVpt7SlMQXykqH2lXO9xGd19EGktaduVezUuILP5lQg0jxBNmszr0?=
 =?iso-8859-1?Q?fHjhGxIEmv0V6yRGRbpMrgKblqsKIboNCs4SlpPpaY5LGDEWrY9VLAHSFc?=
 =?iso-8859-1?Q?YsWHHgknpo6SBmkNNDQC3y3E25APDHP2RgCs3EAKXyAv+sDK+G7HiKC1gy?=
 =?iso-8859-1?Q?OFMcW6c0Ewj9IKDRENl0V4ufptISWfg4eqN9qyc+c7KvpN1yJYTpm31MMi?=
 =?iso-8859-1?Q?OsTLuQPeGMojLJfq+wml5S79MuEzqh/HSFuyaM3AWDiV0nNIO+N7hpjuKS?=
 =?iso-8859-1?Q?xyEwVhyfdBcHu0HTE/vUbJhVRLVbFyGkiKWz7QzoEZIYGY17/VBjCDFaFw?=
 =?iso-8859-1?Q?WI7+a36fGYcWM1DBxsgzPwUaUhx3RApv0DpxXC4yKEMvGzyVifAxk+3YQm?=
 =?iso-8859-1?Q?IiHdCOztjd/3E81EoSZKzUMVeLYSMluToxo+9Jkt2uOuRg0OPA4Ji9DK46?=
 =?iso-8859-1?Q?6IavO0s2HYUPTCK9n4ZcYE0hvmCxIDfFS5Q7A54RsrjiG6M6XBImizFL86?=
 =?iso-8859-1?Q?HC1kylL6Et59489sRhrg33K2xx4Me+0oRCTg2Q2vZVOoRxUtbgDEJx6Zxi?=
 =?iso-8859-1?Q?VPew/uBxlVXYHb20iHDnuT42wuY4Cgpu+UI3hAu+2zBYtYw6SpujJUPoOz?=
 =?iso-8859-1?Q?iv6Y2f66bPmA0UfRoQSDcMLKDsANnj4O8EjKlQI+ZjzxTk0AMV/2d1j8N8?=
 =?iso-8859-1?Q?F+ctPJZChK0A0GoOEBCiyN9N0XRDnVaU2XWbtGC/qnuP+2qsCWvW0D20Qa?=
 =?iso-8859-1?Q?7PfCiZPpk4EsEoPF/9QIF+6Zo0KNCWVYRnuYoCo71PbS464jEiGCcvGfoN?=
 =?iso-8859-1?Q?dey3y+7Hz4WXuRduNzvvLLLgRuE/qK68J1nLtsVj7/+WvPD2EhRc10fca0?=
 =?iso-8859-1?Q?qyd84Yst548+6AWjfdwekxAv6oIspE8n67HMKaoUKORk/F9ZXvpP/GuxU5?=
 =?iso-8859-1?Q?Oz2478FpUrKHZe/0ToyiU/WjmOxfYc1U83buzZtPyUxBrQos9z3ypeNZB9?=
 =?iso-8859-1?Q?CDpKReztrrTTW5916PiHOl/8y3pLiYMKM3fMhT9zvEu/eLItSwJgOCEQbl?=
 =?iso-8859-1?Q?OK5h8BC2WVcP9p0EBInVb4nMHg5R/VW7eNxsgAsApi7HZ1vMCPoiaPdxA8?=
 =?iso-8859-1?Q?5Yt7JDvK1hZ5oTloC33mlfWzq1hjWNkcJv6AXDcot6mGR+qvkbTfNrqRKs?=
 =?iso-8859-1?Q?fNxeJTlmb5ZSZ8mD10aZ7eBz+S+J+gEPnH/zz6GJUPByJL1LZ+0DR3PpwN?=
 =?iso-8859-1?Q?DSZPz+ftSbs0eAiOsRf7W+RAu2lg1V40Ec3TIbfJjQxe2EgQjXrM7DGCNN?=
 =?iso-8859-1?Q?RnEpZPNG75e1mHjhZZmLkQD2jbLRG+P7GD2U1ed9I3vDn1REEwWjEvRDXR?=
 =?iso-8859-1?Q?iPU6P4YgGZ5NTbQsQVThSGDe3JYOR0pX+3R+dWQDC2wQKNO7skjA/amyeE?=
 =?iso-8859-1?Q?L4PWLUykqTXIjB6s9cDgYda1bZFVJgXnd+Kzzfc/R9N8d/Cv3kbtJXHJxw?=
 =?iso-8859-1?Q?6evdpv+/FVnGqkwauUmHKPV1rdhQ/NVciuT5GFZBk8W928GkKVBdlNvWXe?=
 =?iso-8859-1?Q?mgvn7M7f2DwwFNqyok+r2YFSHFcgFTnIDa1q01td6y1bxD9IsTm0MzuSkr?=
 =?iso-8859-1?Q?vnCtfX58/WHqgD/PwtbPfFO6Wqq74zl1USZnBBnz2qNa4c6u92pT692TE7?=
 =?iso-8859-1?Q?Eis3ce2eCA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3003226f-1e77-4b75-17f6-08de6862b187
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:22.2732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32OEfil9KQ3szEcaN5yiMRLfZB1FQXXRojCrQw7dmevOVghXXqsg6SYNmiIGckg1PVwOrRsdzAhsfp8J+ly6W06gyJB4eNCc137oyZKwf8w=
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

Update AST2700 FC functional tests to use the AST2700 A2 SDK v11.00 image.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700fc.py  | 16 ++++++++--------=0A=
 1 file changed, 8 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index 47e56dcfc5..51ee8bc787 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -62,8 +62,8 @@ def load_ast2700fc_coprocessor(self, name):=0A=
                              f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
     ASSET_SDK_V1100_AST2700 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
-            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-default-obmc.tar.gz',=0A=
+            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de=
4dc')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -98,7 +98,7 @@ def do_ast2700fc_ssp_test(self):=0A=
         exec_command_and_wait_for_pattern(self, 'version',=0A=
                                           'Zephyr version 3.7.1')=0A=
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',=0A=
-                                          '[72c02000] 06010103')=0A=
+                                          '[72c02000] 06020103')=0A=
 =0A=
     def do_ast2700fc_tsp_test(self):=0A=
         self.vm.shutdown()=0A=
@@ -109,7 +109,7 @@ def do_ast2700fc_tsp_test(self):=0A=
         exec_command_and_wait_for_pattern(self, 'version',=0A=
                                           'Zephyr version 3.7.1')=0A=
         exec_command_and_wait_for_pattern(self, 'md 72c02000 1',=0A=
-                                          '[72c02000] 06010103')=0A=
+                                          '[72c02000] 06020103')=0A=
 =0A=
     def start_ast2700fc_test(self, name):=0A=
         ca35_core =3D 4=0A=
@@ -153,8 +153,8 @@ def test_aarch64_ast2700fc_sdk_v11_00(self):=0A=
         self.require_netdev('user')=0A=
 =0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test('ast2700-a1')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
+        self.start_ast2700fc_test('ast2700-default')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test()=0A=
         self.do_ast2700_pcie_test()=0A=
         self.do_ast2700fc_ssp_test()=0A=
@@ -164,8 +164,8 @@ def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):=
=0A=
         self.set_machine('ast2700fc')=0A=
 =0A=
         self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
-        self.start_ast2700fc_test_vbootrom('ast2700-a1')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
+        self.start_ast2700fc_test_vbootrom('ast2700-default')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-- =0A=
2.43.0=0A=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E62AE78D70
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNNz-0004cG-EG; Mon, 09 Feb 2026 04:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNx-0004be-UO; Mon, 09 Feb 2026 04:16:49 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNNw-0007H3-CK; Mon, 09 Feb 2026 04:16:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKs68KbZ6/WYBaJ5Fi9mhHdSRO59W3ulmUlWPqertw6JYqOgNGM1L3rsVZfzicm6JxBWlGN5R5pluiSgpcEOOxKCegV7gyyOU82LJRQNbBZt1DDnHWeUK5/MZVwrk8rSVrOuDzoGJ/6QfRct5uZQHAn/n8tfAYv51SpZDF1DxKjMnFRUZUYi7lkY/qzkPFGgvwBJlFvYqCALL5fp9tjYWoYqCpGP5VRHiTdK+sJ1tmoFNNesiT/lmVJvvpC0dcbHvSr+SbnXY6or/lXWJoiYHdUHPU3rhdM5iEoJgaweup4R2gL+SjzKXhDXi+dLKL6ATRZcuLlBcGqS2K8hxciRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqgm0l5TS5W5Hsa+mU2xsOU/LydnwheEDnx/vL1HOCY=;
 b=JKe11OBwwmgdKOnTY3AJPT77KK4GXq+c/r+vRqggCpMD7m3xK7wOMzfUJL8nDsRukG9oaY8OSdme1XLeSASSfTL2qHH0xk7drvH+drnvGhvYbEoZMZB+qdUprIy6SbZhP3Y37yhvrCOFKR064TyV8/5ku8OAZQKs9WGLA+L7A4cTr+lFXiGfhSUKpXnGZD4hVZyAT1+2+JpJbrFGpkY6gvqTd1ER0KKnhd7t3SPIXkmftRFlzzKizHieXMH6OpxsY0WEqHDxkHg3mg7ad1PeKF+dPLDsxrLTFciULg9D1zLqDRmaWWXTDLcH7JOPjB7Cy8nGqwvbrcAK8BfeYcdV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqgm0l5TS5W5Hsa+mU2xsOU/LydnwheEDnx/vL1HOCY=;
 b=VecppiemKhPBjIOMOi0Zf+7oqmvC60He9yUM4dXbz0zxaImIGeaNbU/GJMY4T410NMKSk/9iSLu/ssSNMnVyvx/L7daItwP2B2imLvVD3yW1yRsQq9JmxjSkXMNPik2+ag9TD+r380nq5AFV/y74Q/Qudbq3FrUmxVI47usHOKzezuXBLFykkAlrlm9lxEm5YvI+eBcZLLZsWlqhiWPk2eP7O3ZoEPAsoU/0s5cABbBzMhCcKCFc+P+6ZfL4JiR2ZiEJkPzUiaUQO2nHLlUfcEzHz2zIz7h68+VE4Me2gMs3B3auSSdwD68nF2OwbXRiB4PUkrS1TJGZutgJ/UdFGw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5784.apcprd06.prod.outlook.com (2603:1096:400:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v4 06/20] hw/i3c/dw-i3c: Add more reset values
Thread-Topic: [PATCH v4 06/20] hw/i3c/dw-i3c: Add more reset values
Thread-Index: AQHcmaTM+BAXvBpaEkmfVcGOyLIaZw==
Date: Mon, 9 Feb 2026 09:16:39 +0000
Message-ID: <20260209091629.823457-7-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5784:EE_
x-ms-office365-filtering-correlation-id: 2d5df622-dd42-4325-82dc-08de67bbee8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?X+Jc1hidPt2SID85OxdMpdsqJOjey2nBqnLGpe8faaL387ZoKODOUl43Y0?=
 =?iso-8859-1?Q?7Q6Bnbq/Dot/Suh2sSirLuqHEbH+L5+Hyx943ezyghS3f5PQ9NEat56d9N?=
 =?iso-8859-1?Q?1qcfmlhA6FhzfK5B5i20ET4Zu3TD4KlI0+88SYLWt+o1i3xxq5xIg9aNBh?=
 =?iso-8859-1?Q?QdrXR/Mb+PgPW/LbEasWbyl0IKRY7hm0yI+i5nLoNsaGrIaf54KswE4gx6?=
 =?iso-8859-1?Q?dHh0m/ck1fdAHL1vrUgIRUoLQqnPySnXTt3ruUSAWaRoKdf65qkaCULa1u?=
 =?iso-8859-1?Q?6c9CgXsc3apnpNq/VWvifbEL2EPXF8oSsSx4sJ4z0iCrBrHpOhymZY3P2S?=
 =?iso-8859-1?Q?ugf6y40Kx+ZG9oGJlbSuB9jqzj3Jx3/zX2EB7elrm++87QyFmYllDUBThM?=
 =?iso-8859-1?Q?Z59Pu5GqbZW5/oKApgEsHH9grNMYEA91DD4MjLsCWd0gM6PkX15yEqt2LV?=
 =?iso-8859-1?Q?sRI2cfgiUT4wZng137UyEupOt1VqVl2eO2VvEPJJAVF/0tVLk6XrZ/w1sl?=
 =?iso-8859-1?Q?76GueAIaLiRCYFNEQz7zjqwJMecH1J4CCMoCcteTeBk7OQ7dW7IwlnEeam?=
 =?iso-8859-1?Q?DoEnIAuDtobeBeYbw/PRcQ7JlWRD+Cw8ObImxFoVmY+3qhhChUmw+HqztZ?=
 =?iso-8859-1?Q?3nPOVyqtfgjVNQlWUwNp5lXOhfJ6I69wK23v8BVsvCIzcj8Ap1iLML8us1?=
 =?iso-8859-1?Q?eSTq9YWPZ3WGjajdUWOL6AMQaiN4iDgORrn2plz6P0hFdje4WJDEgBZxqW?=
 =?iso-8859-1?Q?BedcBJ31m02/V3I0XciMfPhAm8/YvGEdNh9kR0OxecN8PwutW34r3g+Ujd?=
 =?iso-8859-1?Q?HD2mis2Gv5nzTqzgr6MOa1iyV0oVMGj+Fh+7Fc2czJSjn3axTnjEWv5bm6?=
 =?iso-8859-1?Q?zS6IJy3+SHeqzgW6Y4drlHYH+Xi11QtMLGcIwqXn7nkc4Q8II/wmCdzLc+?=
 =?iso-8859-1?Q?dHL1MbyeRUMShGVu71wrfaMs6n+H6msiWfPCPPM5VP4tuSMT2Evf/KoCsk?=
 =?iso-8859-1?Q?9Fhj9Tuaxg4TTFP8qR/KPRc2ZRENzd1CV19ZAG8OERFs1fhh9VIhkA8Dey?=
 =?iso-8859-1?Q?NpPMm2SEsI6bFxjOtFFWSW/TJ1lpeEc2DPRLtdULEDyBdwPA7Xlc6PMpz2?=
 =?iso-8859-1?Q?hKFjNShmUC1UzGw3G/4OE2dry3i7MokrNT6yQFXkyAX/GuY9C1CXuWGp1O?=
 =?iso-8859-1?Q?VeUAyBA6aoKmdHB05c1aqmVHnDbm3pDjma/AghsRsGA9qkgr2uRgsY1zFz?=
 =?iso-8859-1?Q?7OXFAp1n3Xm/GKJ66tHGBK/TX/8+8e+EG9IyAfs3E495GrULTpYheu+2np?=
 =?iso-8859-1?Q?Z+16di3mHF1LeeEHToqecDmtV+yDra6QfV0rv+s1RinBg02c3XW5XEXad5?=
 =?iso-8859-1?Q?yc+ZIISlea3Obo4qpSUgz+SWPLm4Yve1eZLiRR7dHB79AkBY/AHYz3Ud0w?=
 =?iso-8859-1?Q?2hFzxRt/tJP/WC+f0nbhBqhSoEO22OyA69vTtqT57bB2PTw7wPJ/nCWAD6?=
 =?iso-8859-1?Q?0+XgLT5WngqPYZDucIRLL6YPMkPGPH0Ty+5Nugx3GlrXmBqe1TjzsEGb9/?=
 =?iso-8859-1?Q?Ru5wJ+gY7TIt21HC9W70vIVJ+2I2MJneGIw26341X7uBnN7Pc9m0Q9nOqj?=
 =?iso-8859-1?Q?s4K6BKHmyUDYqJlx6E2bezzvDOrHbW1BzeowcrK+qrde++IWikYfH9nNNC?=
 =?iso-8859-1?Q?rMn349YZ1xAQGlWyqgqQguCAbWVV+qUr4bw59MVX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8iFFH9I3v/1/IayGHBO5UIGGDiIpg2kUoVIa1/Oil0PDEmJRho85qXKULu?=
 =?iso-8859-1?Q?iUIN0bYqfxfAv/p80g42kBtSDtMbzScf71t+Q5OZHvABHde2ybXUrkVm2l?=
 =?iso-8859-1?Q?86EmSn2vDzEAY5BGpEi8F/QEgx9ei8wc4h3C6OBTr89S92rxV0E8GCv5iE?=
 =?iso-8859-1?Q?WdTwkM3SzNO2/2MH9pgLKz+/2DTGNBnsee4C+ORHVYO9X03wCenQMhEaQ9?=
 =?iso-8859-1?Q?Dham9rnrvol/Mp1wEdGLX9M1w9bswb81LF4+3Y67Qu6We7hYfCpFhSBXuf?=
 =?iso-8859-1?Q?mp8kLtE26G6qwMi1dRwh0TxsvbvjMFaefVyIzr1fyZQEDzAbpj5vxsWBjp?=
 =?iso-8859-1?Q?lekASwtlmL3crtC1edh5dmrcKZQIEbFsXZyK+/ujOd6oaMz/9iZkTWELR8?=
 =?iso-8859-1?Q?W8xGJLqfwaupKpXZfv9mGeajAGxd/fdhFtMNQOJuPklHzE1i4xIHO+krxD?=
 =?iso-8859-1?Q?VAkpb53sO+h5sdPvkgAzygvZYbYmNCjjQaWWC/m5VeEPvYsSrNuIQaGyrk?=
 =?iso-8859-1?Q?TzK8gA/6iq/aD3gGVyIQpv9yod9DuIBI0NxNsFFoFFCJcpf4GiurBvEmPZ?=
 =?iso-8859-1?Q?flIGyac0wMR2EFtF3Gi/1Yr+pf4y4jnl8I2AyJ7qjlNZATYADMR0aMoKP+?=
 =?iso-8859-1?Q?OGjPw6YNMzV/IZ1b6DJqg7m72Z7a5bQDH6sBFWu5AVCIodv6fUipszJcJG?=
 =?iso-8859-1?Q?F8qXLb9Ekl9El2ljs0wvgGE1P2YmK1h3ZrNuhgB1QB60EwugSP44WEzAZi?=
 =?iso-8859-1?Q?z3FqwVP4kxkbmsYe7oz7ft1tHlMcO9h4lIHl2PZzoXCS+/SvghuvxvTQYr?=
 =?iso-8859-1?Q?gbNrV3DShmiT8sNjBwMh/YIKlpdatXfIwU9eOFNoJYI5qbcw2J5Y8aeatl?=
 =?iso-8859-1?Q?+Z4iOSumKA9OnJkbavWm7UwWok0sh0Ar9pSpR1duzxjLKjTsvKH3IPms+t?=
 =?iso-8859-1?Q?qjC4hi2EOFn6Nn/SNgceo1F8DZmrdjkQ7J5upRLFvyphR6JDNRJ02azlG3?=
 =?iso-8859-1?Q?qzjwG3nnaksQfFsLd3LIb5S6AL4O+xLTJmI665d00+vyhFw5D4R7gt/KUe?=
 =?iso-8859-1?Q?I9vHoQ8dPLw/iQGcfnDsSiiQquEYmQ2cp5BdmrnmBfUisB2x6DYN69/36Y?=
 =?iso-8859-1?Q?z3Rzb+GNLBICGXRTpB/5Zkk2zC6NmBS9IeGL06Ydey1q7N7zxjViNeKAkT?=
 =?iso-8859-1?Q?58OrLskrhBMB/u2wx/D9PwJyjkawk8ttmF+lPhlJ1ca3Sy2NmX+4+/PwVU?=
 =?iso-8859-1?Q?qKvz54IROzC+8dINcVZK5GzrGPhUX+e0e7AHHKvDMfGv7W7wKiovQwEwWj?=
 =?iso-8859-1?Q?LO7Z9u5Qtna/kNK3X2YZRlkiN9lhak56f4TLw2vOwcnmE5TcMwRuGT88ZV?=
 =?iso-8859-1?Q?AMpSMNF1/6pUHSudd/1au0zmZQPBvpRLSGT6KxWCEF6UFbLY6QAcj1DuJ+?=
 =?iso-8859-1?Q?vEPlC0plLehoDPSbDncF0Tb8kul6A51HLpxdR+/2MTDYOguM0XziHUZqBH?=
 =?iso-8859-1?Q?VgbMDrhArN/Rcfku+n4gBaYXr5l+ZwcdxmBCqQuF7xugUuYGdQSwamqYn6?=
 =?iso-8859-1?Q?vilJ1pPYuhkoOjOeZt5SOvn5uCETYdMYB8iTi4vtsAktzJEQOK8o7lLZrN?=
 =?iso-8859-1?Q?WBaHwT5qb5dgexvKFM1FnOYhckILa8SB2k/KRxnoX13MJu0TCHydBbu9q7?=
 =?iso-8859-1?Q?f8BBgoaNqM6t8Bq5tmDE94j7VmNlz3q8fKkvuc4IDadyazka++BbkZ33l+?=
 =?iso-8859-1?Q?7NB8ro8wLX9pTtVMxGv0ppoj+V3qR/+piAWRlCJjCYDmrvETG+xclzhjEJ?=
 =?iso-8859-1?Q?K4IwQTYPOQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5df622-dd42-4325-82dc-08de67bbee8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:39.1268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3Iq0YdYosB2XnXLaL23YxEtlzgfB7Zik1GP2z7d0Et0W3kZJGxguL/w+yD+XmFFJ2EXlcw6BDgTjBC1Q2oPknHcu9fJ+4ISsfSjpa9w6X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5784
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

Adds reset values for the new registers added.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 20 +++++++++++++++++++-=0A=
 1 file changed, 19 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 2f04c69320..7bb33c7a9e 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -268,14 +268,32 @@ REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)=0A=
     FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)=0A=
 =0A=
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
-    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
+    /* Target mode is not supported, don't advertise it for now. */=0A=
+    [R_HW_CAPABILITY]               =3D 0x000e00b9,=0A=
     [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
+    [R_DATA_BUFFER_THLD_CTRL]       =3D 0x01010100,=0A=
+    [R_SLV_EVENT_CTRL]              =3D 0x0000000b,=0A=
+    [R_QUEUE_STATUS_LEVEL]          =3D 0x00000002,=0A=
+    [R_DATA_BUFFER_STATUS_LEVEL]    =3D 0x00000010,=0A=
+    [R_PRESENT_STATE]               =3D 0x00000003,=0A=
     [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
     [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
     [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
     [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
+    [R_SLV_CHAR_CTRL]               =3D 0x00010000,=0A=
     [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
     [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
+    [R_SLV_TSX_SYMBL_TIMING]        =3D 0x0000003f,=0A=
+    [R_SCL_I3C_OD_TIMING]           =3D 0x000a0010,=0A=
+    [R_SCL_I3C_PP_TIMING]           =3D 0x000a000a,=0A=
+    [R_SCL_I2C_FM_TIMING]           =3D 0x00100010,=0A=
+    [R_SCL_I2C_FMP_TIMING]          =3D 0x00100010,=0A=
+    [R_SCL_EXT_LCNT_TIMING]         =3D 0x20202020,=0A=
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   =3D 0x00300000,=0A=
+    [R_BUS_FREE_TIMING]             =3D 0x00200020,=0A=
+    [R_BUS_IDLE_TIMING]             =3D 0x00000020,=0A=
+    [R_EXTENDED_CAPABILITY]         =3D 0x00000239,=0A=
+    [R_SLAVE_CONFIG]                =3D 0x00000023,=0A=
 };=0A=
 =0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
-- =0A=
2.43.0=0A=


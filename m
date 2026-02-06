Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF58EECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOZ-0001Cp-94; Thu, 05 Feb 2026 22:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO9-0000Vc-4C; Thu, 05 Feb 2026 22:20:19 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO4-0008F6-Bl; Thu, 05 Feb 2026 22:20:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uc5+vSygHa7IjnMIWntT6SfPRbOwRqeGNWgxpgr//HYH2OxN9IV/IUrIVzwke06Ep8y8lw+hkoM/5w/fKvj6PLs40EAfOB5yhCzklyfyiXqd8BaOaGhbg9vPJbE+FujTX0lDuSWktcVSSmi4RHuA3azzmug2582fW0GdRltD9aoMHDZuy1Z7Y0JzkRT2jR+Q4A+OXf+c0DhjBPkWh59PmZGeUfU7LE5wA789EN3C0ShE1f7ljRfUb2FD9F8+HDRWJkA/F9CYVyHHgGe7ruqP2noHsK/yol9l6bYhntxCPk3UG283MuyRt1jaTAyf2Xl/RFbLToTBikng3asIWwGJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WJzMmOcxPfFvwAIvyyub8B6uQ8ju2pVXPiWEeJvoq8=;
 b=xPEQfuF6/stHevY6zYhZmv+hQIfSjnFHOhpu2bpk/XZxDzi7UovGMwYYHTiVz775GhTmSWmms27KpS6Czl4qGwmtRNqyBXkT0SQO8U4zTN5MCbuZU+t2slbISlmAWk/JOR/dG3KXSPs+bU4mMqhkT07fitQ7m6+44ul2jI14ue2Brp6QLQgNJHdqc2vNkTpYga+0J5P3bNMttyaULxD8ZRW5389FcV31F4JfsVJZM2EXp2io3EFjyWzQt9tXqH1yPYfrTxnD012slTfGWvMGgIGKLZltu/2CqazYAhvqzE8QqMLYqoL+XjitOX5bRk04CzcUWS57QQq9JF0H00ciCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WJzMmOcxPfFvwAIvyyub8B6uQ8ju2pVXPiWEeJvoq8=;
 b=QwoIHvEFL8fu4i7GhQvUJ2oC8dTshPr0KMtu7S/FFvgbsVcmySiSh/Z6+aKQLRaspqv20K9pkAbcYGDcaJT3I5uBHEAvrMut+ya0XBKfblqGuX3g25ceZbZLTJqAop7D5RGPEHaw3rZLft1BgvmAy3ARS+Pxu7D+ubhrjl0/u9twwTXM1tS+Xt6SJXlbhd43ifojrlEHwRsiwsFV/xIro8ahRDgUPqrrPmU0jiHvKaopSln8galyUN66CF5TSHJ8jfoiIRj/sZwBcdMb0AWe+xYr3e1iWy5gOW6dxi8/t7td4Unhqh8gDoLAUyt3ah/un8r4t1JcnLCg2/HwYJHmvg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:45 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:45 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Stephen Longfield <slongfield@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v3 12/20] hw/i3c/dw-i3c: Add data TX and RX
Thread-Topic: [PATCH v3 12/20] hw/i3c/dw-i3c: Add data TX and RX
Thread-Index: AQHclxdxB5wtJiDg0k+msWFo+SqH7A==
Date: Fri, 6 Feb 2026 03:19:45 +0000
Message-ID: <20260206031926.3227848-13-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: 07e92114-a6b1-4ef1-e4d8-08de652e938e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nH2JJc/2D8g0nEEy2HiLF7vPz7VJkw6dyp5JtI5yzdxBhVomeGXgl0l1i6?=
 =?iso-8859-1?Q?MvwuZKGnaPYzHjCzkDYos+yIHC5pWn6XdUhjS9fm+IAUljviDaHYNGVzsM?=
 =?iso-8859-1?Q?iqfsymOmJXzibqrgWhZlpPT34gVd9DbzkniApC6Hy5YIgkRIUY80xWAKc+?=
 =?iso-8859-1?Q?f2giMZFMout5h5vbINteNTp3NtwBlWvPpGBNVOKBxFc6llpF4E+8Cqr6i7?=
 =?iso-8859-1?Q?in73e25JERAZWjMowuv9tmaTSHrYk7bB/YQN4ScFAMEvvH1EBgTKFQ5G+q?=
 =?iso-8859-1?Q?Cz4NkN9ADavuKoty+pA3Qv/ad+DHgkJJ9lgy6caiCpSKl6A7C/iR17HRgX?=
 =?iso-8859-1?Q?xfi11/vUa6f2JqNugODLipTDcI2JqIFMbYvHP3W6GxIUDpwSYg4eJOM04/?=
 =?iso-8859-1?Q?Z3xlNzMpldHp6XxlbsNFmKQhTVfb1y/VGkXXnuchyrQe3WKPKJZnp3CioN?=
 =?iso-8859-1?Q?/JK4Soy4EZPhVpgt92oBEu22cK7spD+9y/X80r/QXw3MbvAlVwXkoY6yF8?=
 =?iso-8859-1?Q?oHAPXE00Uwkutx1M/RBXEXjg0ld1Q7wQU3Fx3ntE0ueRUv7am7tb3oTd6E?=
 =?iso-8859-1?Q?eLPMBFWaZxBK7AOzo/SI4F7NlY3wbxGXQ//KR2iG91oOouB9iCbnGFTCIa?=
 =?iso-8859-1?Q?j+GWF8iEPuwGogvGWeXR4lP0vA6fdw4RsEj78B6gINCS2Ur3ftlIeaZdVw?=
 =?iso-8859-1?Q?K9G9wZAjMguUoZ6Sd+4WwlScPhwI8tPY2Dw/RrKr4cKJpjN61w0s/smMxw?=
 =?iso-8859-1?Q?BjriZZB8EC74SEyrHO7BA7uCgiRPrgM4xjN61QVY4F2fx/z6G4ma2BOrUC?=
 =?iso-8859-1?Q?Mx7DeTuaVp4fc+ZwH0gRs9vzMO0FLwHGodTD7web9jN8EgmbXGSKnuz4gs?=
 =?iso-8859-1?Q?6CLxJdTIZYtmjfkYjB89NrpydgVNvfsLejPmasYdBJ8IDiS59+Xk5mm0Zc?=
 =?iso-8859-1?Q?LgfZvKICfFacyBW7Ly8Sgdyzt9Zx7FDLtulyTZg88/MCmOEZzQgQQPHC3G?=
 =?iso-8859-1?Q?WrmHZCSBD52miye1S/nPL6oovrQ1hZyVaVC0/0RtImPcyyxRB4juczDcvs?=
 =?iso-8859-1?Q?BfXpzgNA7yVkFyvj2oKLqXbO4OPEJ9bCy9edUh3l/GrIAKzKse7g8cc8Np?=
 =?iso-8859-1?Q?pXZD/siyrosuhujtC7cC6jmjnxaNK/KL2u8m9pz4VIuLA0ry7rgALGMfu3?=
 =?iso-8859-1?Q?XCTZ+IdOqml5fYC9dvRytsao9ml5CA+U0Yt0BXaFrZ+HepoWPlbijIt57n?=
 =?iso-8859-1?Q?pvB3DMrjnqtqTYgqHnd5T688wso3zRFuSyRfljueXAeSBnkpe8AHOpBny1?=
 =?iso-8859-1?Q?PmrVJx06paHx2QIxthsRtHkh7uyIHPOrKrF/Tr69aOJIM5e6Cc+5NMzwTd?=
 =?iso-8859-1?Q?Ham8/nCcZXHQnLg85cxOmtJuNevkAPkFbqWVD1nYbW5aIDK34qHn+3Ph0J?=
 =?iso-8859-1?Q?N9qWlMwWPWe+danUA+5v5oNlkw9AuOtImeTqnLvogREYA0NHs8XUdkSECK?=
 =?iso-8859-1?Q?fg6MU37ZFeAqGh513yHpTHxfzGNg/6EFCN6ZkjJ9iyBnA22PNgve2q/QJk?=
 =?iso-8859-1?Q?n8JYLHdQUjsXKiDzNwOYQ88r4vIuMBeQr6c3nIEdGVo9VeVAU6WmQVVD3U?=
 =?iso-8859-1?Q?HfaiLdkW0UnRYTuFQSighj6jResgLmIkoITGrxabOASxrP30jwMXDm1xu0?=
 =?iso-8859-1?Q?m502mdBXPQm2PqfePo4tRPNmJJ8vpz+9AhAG0BSq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YBOjAgScVjNc1ZMsmZR+B8vuuvbMEswa9XC0jL+vvzGXO9Fm8g4x0z/7cN?=
 =?iso-8859-1?Q?9PZHbyJe984BhvhHkbIgXwlAJbXuXhdxfmieIacYtJMaX3tuxlp5r2QxO8?=
 =?iso-8859-1?Q?ftqgFXVZVsb078I0WkQTAhEB4nd4dqQnPKZgT+8jLt3l7SckLm0XrTkpHt?=
 =?iso-8859-1?Q?kYXMaR8uHcjxDiLBu/bQGT/pUsPseTiUY8Lz5cA105YJlqHsTEH+oO5Ef4?=
 =?iso-8859-1?Q?ENObGoVvn1LXRbAemV561wZm9+WKz47AecHXAsdiyqEJ+K/9TZHCShyJTd?=
 =?iso-8859-1?Q?I+3ut+WTbMrbPvPGVl80fiRTcIDJ9dnWu4hzNBsuhFGnKM9ZUGQDV+RWRu?=
 =?iso-8859-1?Q?D166BDaeah2+d+2JI582L5t/ySnluv8OIL+5WXdj2LojJfdF2B262Q/Wja?=
 =?iso-8859-1?Q?PSw+bHxHPJNq+y37Gf4RFPCnTDbWyTCfQ5A9uigEkPd5u0RV9fKeJEjT90?=
 =?iso-8859-1?Q?z3vLMIDL03QqXL5l+hdKZnzsC9GjQU/WqL+gSwEBe0bHG5hHfKvlf8tRIr?=
 =?iso-8859-1?Q?C8xCTHrTrOWJtei155B8gIOg7Nx+0cDVr49gB6wO7fx/iL2D3MtEPDTm8J?=
 =?iso-8859-1?Q?8GlOUB8LftYjhkj2JRTvI2Cj+8HXXar/szH7OCo2hm/L3NeJ05qdBtRAPZ?=
 =?iso-8859-1?Q?8l/C1gY7cvNS5cbBdNSI3J13Lnq/bjwCQ14dZGUes8SiPB5rFMBliplPhM?=
 =?iso-8859-1?Q?xMIScwhZCZbsFkOhwdcHRS4VuJaHc0IFJTmuQz1nGF1Tp1mRyqjvsp4EuU?=
 =?iso-8859-1?Q?AaonyZiEoylYV9N4xKqKa4ZmrDF6/0MdI/zo5wVNJs/jjKCqrQazMDMSol?=
 =?iso-8859-1?Q?mmHr0bPZjvuaGZ5t+pQTXUFoitwjyT2P89KilO7v/jMg4JCKErHUhCRucS?=
 =?iso-8859-1?Q?OZph9AihhqIPQSsaAURKmrDjdhFG+qv70jVa1YIv1kQg2ohaKizcSe58sa?=
 =?iso-8859-1?Q?xZJSDX8+/7vSzSidJQq67A7znJeVajHdBaoMDpVK8JmGyLysnYLp0rCABt?=
 =?iso-8859-1?Q?qJdiNhUC5iceREVGsd0iFJRGl9JyBeIja27LVANVyUI3KGNl4uyDLQXaAl?=
 =?iso-8859-1?Q?IvCCRLAFmjvL9kqr5rh4EVHRGpX2FAryBYhpAewl7NlVGudOti7LRq4J8t?=
 =?iso-8859-1?Q?VsrgkGv658tqrhiOB3USBS7UbIr0vHsLAqtJvsSqa32fsIiC7bcmrFDsQ9?=
 =?iso-8859-1?Q?wEuicIlehSqX4xER9YLFH+/JsXMVTwcHK5bh6GS27ldrM+adzZgAegoXtQ?=
 =?iso-8859-1?Q?rx8l48E24sznq/KSChYGP+IEWFPChtS8JFJeJK51dVmoL6MC88BH0W3ZG2?=
 =?iso-8859-1?Q?oZHjBWiU40vqH78MWsRrzMtWDrYLEVgINOdSqb5mTqyXuBSijsphTlTiYl?=
 =?iso-8859-1?Q?kPQX2/UV0GWrbUtn/tgknSOrrsYyDWlg8jWmpeLJ0FckDc9RrvFanX+H2/?=
 =?iso-8859-1?Q?15p2okQzFboYPnnoiNLKW6FWrNVac3wVMp5+a5PEESX9qAwibdEzmZpNpo?=
 =?iso-8859-1?Q?IVaAeXyHKNl8wjQ0SwLlsbsTt/Px7hajpjCuAn1YMiTVr2RpIJR9Wqvomu?=
 =?iso-8859-1?Q?62Yl+Um3sixSzhE3VODlL0X1DyqTnXcLFNUaUyqpTlrd/+rlZhDW9Az6vz?=
 =?iso-8859-1?Q?6uyepDsVV9yrDtpN14ZTpeO+mUGZzWeiuv3ZbS+uedUuaks4o7wb5Mh5dc?=
 =?iso-8859-1?Q?JVzKeYQuOpo9ekHAKawDhJ4OnnCNGkUiH8Mp5B2Z14jhzTfKA09+X444iY?=
 =?iso-8859-1?Q?v7Y4jWd7QacMiTCSnMx+v34JcwRN2zk3CIX03JyKkPl6+XtoBvvJd/Gi9u?=
 =?iso-8859-1?Q?en3NDO1IOA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e92114-a6b1-4ef1-e4d8-08de652e938e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:45.1644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfb5oGgkw7SrsY/TH0mTWh+Vod+TaZ2I4YJR1IZOmApFmSQ2G8mO4/wxHr5/dOZEBycqXAyOS16jzusNhX54YABv1k2gs3p9reSg+hT2Gho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
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

This adds data and CCC transmission, reception, and the associated=0A=
queues required for data transmission and reception to happen.=0A=
=0A=
The I3C controller transmits data by the user writing into a command=0A=
queue. When the queue has a command and an argument in it, the=0A=
controller starts executing the command.=0A=
=0A=
The controller can execute 1 of 3 ways:=0A=
1. A larger data transfer that involves using the TX and RX queues. This=0A=
   is the most common way the controller does transactions.=0A=
=0A=
2. A small data transfer that involves sending a couple bytes passed=0A=
   into the command queue argument.=0A=
=0A=
3. An address assignment command. This is how the controller does=0A=
   ENTDAA. When ENTDAA succeeds in assigning an address to a target, it=0A=
   updates the controller's char table with the target's PID, BCR, and=0A=
   DCR.=0A=
=0A=
The controller determines what addresses to send by looking at the index=0A=
in the device address table specified by the argument in the command=0A=
queue. ENTDAA also uses these addresses to assign to targets on the bus.=0A=
=0A=
When the controller is done executing a command, it puts a response in=0A=
the response queue indicating how command execution went.=0A=
=0A=
In order for the user to send and receive data to/from the controller,=0A=
the user reads/writes to a bidirectional TX/RX port.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Stephen Longfield <slongfield@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h |   1 +=0A=
 include/hw/i3c/dw-i3c.h     | 143 +++++-=0A=
 hw/i3c/dw-i3c.c             | 882 +++++++++++++++++++++++++++++++++++-=0A=
 hw/i3c/trace-events         |  10 +=0A=
 4 files changed, 1030 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index f8e13b6fab..436fb532b9 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -2,6 +2,7 @@=0A=
  * ASPEED I3C Controller=0A=
  *=0A=
  * Copyright (C) 2021 ASPEED Technology Inc.=0A=
+ * Copyright (C) 2023 Google, LLC=0A=
  *=0A=
  * This code is licensed under the GPL version 2 or later.  See=0A=
  * the COPYING file in the top-level directory.=0A=
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h=0A=
index 4550ea45fe..4b592552b4 100644=0A=
--- a/include/hw/i3c/dw-i3c.h=0A=
+++ b/include/hw/i3c/dw-i3c.h=0A=
@@ -10,12 +10,136 @@=0A=
 #ifndef DW_I3C_H=0A=
 #define DW_I3C_H=0A=
 =0A=
+#include "qemu/fifo32.h"=0A=
+#include "hw/i3c/i3c.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 =0A=
 #define TYPE_DW_I3C "dw.i3c"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)=0A=
 =0A=
-#define DW_I3C_NR_REGS (0x300 >> 2)=0A=
+/*=0A=
+ * Sufficiently large enough to handle configurations with large device ad=
dress=0A=
+ * tables.=0A=
+ */=0A=
+#define DW_I3C_NR_REGS (0x1000 >> 2)=0A=
+=0A=
+/* From datasheet. */=0A=
+#define DW_I3C_CMD_ATTR_TRANSFER_CMD 0=0A=
+#define DW_I3C_CMD_ATTR_TRANSFER_ARG 1=0A=
+#define DW_I3C_CMD_ATTR_SHORT_DATA_ARG 2=0A=
+#define DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD 3=0A=
+=0A=
+/* Enum values from datasheet. */=0A=
+typedef enum DWI3CRespQueueErr {=0A=
+    DW_I3C_RESP_QUEUE_ERR_NONE =3D 0,=0A=
+    DW_I3C_RESP_QUEUE_ERR_CRC =3D 1,=0A=
+    DW_I3C_RESP_QUEUE_ERR_PARITY =3D 2,=0A=
+    DW_I3C_RESP_QUEUE_ERR_FRAME =3D 3,=0A=
+    DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK =3D 4,=0A=
+    DW_I3C_RESP_QUEUE_ERR_DAA_NACK =3D 5,=0A=
+    DW_I3C_RESP_QUEUE_ERR_OVERFLOW =3D 6,=0A=
+    DW_I3C_RESP_QUEUE_ERR_ABORTED =3D 8,=0A=
+    DW_I3C_RESP_QUEUE_ERR_I2C_NACK =3D 9,=0A=
+} DWI3CRespQueueErr;=0A=
+=0A=
+typedef enum DWI3CTransferState {=0A=
+    DW_I3C_TRANSFER_STATE_IDLE =3D 0x00,=0A=
+    DW_I3C_TRANSFER_STATE_START =3D 0x01,=0A=
+    DW_I3C_TRANSFER_STATE_RESTART =3D 0x02,=0A=
+    DW_I3C_TRANSFER_STATE_STOP =3D 0x03,=0A=
+    DW_I3C_TRANSFER_STATE_START_HOLD =3D 0x04,=0A=
+    DW_I3C_TRANSFER_STATE_BROADCAST_W =3D 0x05,=0A=
+    DW_I3C_TRANSFER_STATE_BROADCAST_R =3D 0x06,=0A=
+    DW_I3C_TRANSFER_STATE_DAA =3D 0x07,=0A=
+    DW_I3C_TRANSFER_STATE_DAA_GEN =3D 0x08,=0A=
+    DW_I3C_TRANSFER_STATE_CCC_BYTE =3D 0x0b,=0A=
+    DW_I3C_TRANSFER_STATE_HDR_CMD =3D 0x0c,=0A=
+    DW_I3C_TRANSFER_STATE_WRITE =3D 0x0d,=0A=
+    DW_I3C_TRANSFER_STATE_READ =3D 0x0e,=0A=
+    DW_I3C_TRANSFER_STATE_IBI_READ =3D 0x0f,=0A=
+    DW_I3C_TRANSFER_STATE_IBI_DIS =3D 0x10,=0A=
+    DW_I3C_TRANSFER_STATE_HDR_DDR_CRC =3D 0x11,=0A=
+    DW_I3C_TRANSFER_STATE_CLK_STRETCH =3D 0x12,=0A=
+    DW_I3C_TRANSFER_STATE_HALT =3D 0x13,=0A=
+} DWI3CTransferState;=0A=
+=0A=
+typedef enum DWI3CTransferStatus {=0A=
+    DW_I3C_TRANSFER_STATUS_IDLE =3D 0x00,=0A=
+    DW_I3C_TRANSFER_STATUS_BROACAST_CCC =3D 0x01,=0A=
+    DW_I3C_TRANSFER_STATUS_DIRECT_CCC_W =3D 0x02,=0A=
+    DW_I3C_TRANSFER_STATUS_DIRECT_CCC_R =3D 0x03,=0A=
+    DW_I3C_TRANSFER_STATUS_ENTDAA =3D 0x04,=0A=
+    DW_I3C_TRANSFER_STATUS_SETDASA =3D 0x05,=0A=
+    DW_I3C_TRANSFER_STATUS_I3C_SDR_W =3D 0x06,=0A=
+    DW_I3C_TRANSFER_STATUS_I3C_SDR_R =3D 0x07,=0A=
+    DW_I3C_TRANSFER_STATUS_I2C_SDR_W =3D 0x08,=0A=
+    DW_I3C_TRANSFER_STATUS_I2C_SDR_R =3D 0x09,=0A=
+    DW_I3C_TRANSFER_STATUS_HDR_TS_W =3D 0x0a,=0A=
+    DW_I3C_TRANSFER_STATUS_HDR_TS_R =3D 0x0b,=0A=
+    DW_I3C_TRANSFER_STATUS_HDR_DDR_W =3D 0x0c,=0A=
+    DW_I3C_TRANSFER_STATUS_HDR_DDR_R =3D 0x0d,=0A=
+    DW_I3C_TRANSFER_STATUS_IBI =3D 0x0e,=0A=
+    DW_I3C_TRANSFER_STATUS_HALT =3D 0x0f,=0A=
+} DWI3CTransferStatus;=0A=
+=0A=
+/*=0A=
+ * Transfer commands and arguments are 32-bit wide values that the user pa=
sses=0A=
+ * into the command queue. We interpret each 32-bit word based on the cmd_=
attr=0A=
+ * field.=0A=
+ */=0A=
+typedef struct DWI3CTransferCmd {=0A=
+    uint8_t cmd_attr:3;=0A=
+    uint8_t tid:4; /* Transaction ID */=0A=
+    uint16_t cmd:8;=0A=
+    uint8_t cp:1; /* Command present */=0A=
+    uint8_t dev_index:5;=0A=
+    uint8_t speed:3;=0A=
+    uint8_t resv0:1;=0A=
+    uint8_t dbp:1; /* Defining byte present */=0A=
+    uint8_t roc:1; /* Response on completion */=0A=
+    uint8_t sdap:1; /* Short data argument present */=0A=
+    uint8_t rnw:1; /* Read not write */=0A=
+    uint8_t resv1:1;=0A=
+    uint8_t toc:1; /* Termination (I3C STOP) on completion */=0A=
+    uint8_t pec:1; /* Parity error check enabled */=0A=
+} DWI3CTransferCmd;=0A=
+=0A=
+typedef struct DWI3CTransferArg {=0A=
+    uint8_t cmd_attr:3;=0A=
+    uint8_t resv:5;=0A=
+    uint8_t db; /* Defining byte */=0A=
+    uint16_t data_len;=0A=
+} DWI3CTransferArg;=0A=
+=0A=
+typedef struct DWI3CShortArg {=0A=
+    uint8_t cmd_attr:3;=0A=
+    uint8_t byte_strb:3;=0A=
+    uint8_t resv:2;=0A=
+    uint8_t byte0;=0A=
+    uint8_t byte1;=0A=
+    uint8_t byte2;=0A=
+} DWI3CShortArg;=0A=
+=0A=
+typedef struct DWI3CAddrAssignCmd {=0A=
+    uint8_t cmd_attr:3;=0A=
+    uint8_t tid:4; /* Transaction ID */=0A=
+    uint16_t cmd:8;=0A=
+    uint8_t resv0:1;=0A=
+    uint8_t dev_index:5;=0A=
+    uint16_t dev_count:5;=0A=
+    uint8_t roc:1; /* Response on completion */=0A=
+    uint8_t resv1:3;=0A=
+    uint8_t toc:1; /* Termination (I3C STOP) on completion */=0A=
+    uint8_t resv2:1;=0A=
+} DWI3CAddrAssignCmd;=0A=
+=0A=
+typedef union DWI3CCmdQueueData {=0A=
+    uint32_t word;=0A=
+    DWI3CTransferCmd transfer_cmd;=0A=
+    DWI3CTransferArg transfer_arg;=0A=
+    DWI3CShortArg short_arg;=0A=
+    DWI3CAddrAssignCmd addr_assign_cmd;=0A=
+} DWI3CCmdQueueData;=0A=
 =0A=
 typedef struct DWI3C {=0A=
     /* <private> */=0A=
@@ -24,8 +148,23 @@ typedef struct DWI3C {=0A=
     /* <public> */=0A=
     MemoryRegion mr;=0A=
     qemu_irq irq;=0A=
+    I3CBus *bus;=0A=
+=0A=
+    Fifo32 cmd_queue;=0A=
+    Fifo32 resp_queue;=0A=
+    Fifo32 tx_queue;=0A=
+    Fifo32 rx_queue;=0A=
 =0A=
-    uint8_t id;=0A=
+    struct {=0A=
+        uint8_t id;=0A=
+        uint8_t cmd_resp_queue_capacity_bytes;=0A=
+        uint16_t tx_rx_queue_capacity_bytes;=0A=
+        uint8_t num_addressable_devices;=0A=
+        uint16_t dev_addr_table_pointer;=0A=
+        uint16_t dev_addr_table_depth;=0A=
+        uint16_t dev_char_table_pointer;=0A=
+        uint16_t dev_char_table_depth;=0A=
+    } cfg;=0A=
     uint32_t regs[DW_I3C_NR_REGS];=0A=
 } DWI3C;=0A=
 =0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index bda8ab5d51..dd10230da8 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -336,12 +336,179 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D =
{=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static inline bool dw_i3c_has_hdr_ts(DWI3C *s)=0A=
+{=0A=
+    return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_TS);=0A=
+}=0A=
+=0A=
+static inline bool dw_i3c_has_hdr_ddr(DWI3C *s)=0A=
+{=0A=
+    return ARRAY_FIELD_EX32(s->regs, HW_CAPABILITY, HDR_DDR);=0A=
+}=0A=
+=0A=
+static inline bool dw_i3c_can_transmit(DWI3C *s)=0A=
+{=0A=
+    /*=0A=
+     * We can only transmit if we're enabled and the resume bit is cleared=
.=0A=
+     * The resume bit is set on a transaction error, and software must cle=
ar it.=0A=
+     */=0A=
+    return ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_EN) &&=0A=
+           !ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_RESUME);=0A=
+}=0A=
+=0A=
+static inline uint8_t dw_i3c_fifo_threshold_from_reg(uint8_t regval)=0A=
+{=0A=
+    return regval =3D regval ? (2 << regval) : 1;=0A=
+}=0A=
+=0A=
 static void dw_i3c_update_irq(DWI3C *s)=0A=
 {=0A=
     bool level =3D !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);=
=0A=
     qemu_set_irq(s->irq, level);=0A=
 }=0A=
 =0A=
+static void dw_i3c_end_transfer(DWI3C *s, bool is_i2c)=0A=
+{=0A=
+    if (is_i2c) {=0A=
+        legacy_i2c_end_transfer(s->bus);=0A=
+    } else {=0A=
+        i3c_end_transfer(s->bus);=0A=
+    }=0A=
+}=0A=
+=0A=
+static int dw_i3c_send_start(DWI3C *s, uint8_t addr, bool is_recv, bool is=
_i2c)=0A=
+{=0A=
+    int ret;=0A=
+=0A=
+    if (is_i2c) {=0A=
+        ret =3D legacy_i2c_start_transfer(s->bus, addr, is_recv);=0A=
+    } else {=0A=
+        ret =3D i3c_start_transfer(s->bus, addr, is_recv);=0A=
+    }=0A=
+    if (ret) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed on TX with addr 0x%.2x\=
n",=0A=
+                      path, addr);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATUS_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);=0A=
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);=0A=
+    }=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int dw_i3c_send(DWI3C *s, const uint8_t *data, uint32_t num_to_send=
,=0A=
+                       uint32_t *num_sent, bool is_i2c)=0A=
+{=0A=
+    int ret;=0A=
+    uint32_t i;=0A=
+=0A=
+    *num_sent =3D 0;=0A=
+    if (is_i2c) {=0A=
+        /* Legacy I2C must be byte-by-byte. */=0A=
+        for (i =3D 0; i < num_to_send; i++) {=0A=
+            ret =3D legacy_i2c_send(s->bus, data[i]);=0A=
+            if (ret) {=0A=
+                break;=0A=
+            }=0A=
+            (*num_sent)++;=0A=
+        }=0A=
+    } else {=0A=
+        ret =3D i3c_send(s->bus, data, num_to_send, num_sent);=0A=
+    }=0A=
+    if (ret) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed sending byte 0x%.2x\n",=
=0A=
+                      path, data[*num_sent]);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATUS_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);=0A=
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_send(s->cfg.id, *num_sent);=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int dw_i3c_send_byte(DWI3C *s, uint8_t byte, bool is_i2c)=0A=
+{=0A=
+    /*=0A=
+     * Ignored, the caller will know if we sent 0 or 1 bytes depending on =
if=0A=
+     * we were ACKed/NACKed.=0A=
+     */=0A=
+    uint32_t num_sent;=0A=
+    return dw_i3c_send(s, &byte, 1, &num_sent, is_i2c);=0A=
+}=0A=
+=0A=
+static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uint8_t *data,=0A=
+                            uint16_t num_to_read, uint32_t *num_read)=0A=
+{=0A=
+    int ret;=0A=
+=0A=
+    if (is_i2c) {=0A=
+        for (uint16_t i =3D 0; i < num_to_read; i++) {=0A=
+            data[i] =3D legacy_i2c_recv(s->bus);=0A=
+        }=0A=
+        /* I2C devices can neither NACK a read, nor end transfers early. *=
/=0A=
+        *num_read =3D num_to_read;=0A=
+        trace_dw_i3c_recv_data(s->cfg.id, *num_read);=0A=
+        return 0;=0A=
+    }=0A=
+    /* I3C devices can NACK if the controller sends an unsupported CCC. */=
=0A=
+    ret =3D i3c_recv(s->bus, data, num_to_read, num_read);=0A=
+    if (ret) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed receiving byte\n",=0A=
+                      object_get_canonical_path(OBJECT(s)));=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATUS_HALT);=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TRANSFER_ERR, 1);=0A=
+        ARRAY_FIELD_DP32(s->regs, DEVICE_CTRL, I3C_RESUME, 1);=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_recv_data(s->cfg.id, *num_read);=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static inline bool dw_i3c_target_is_i2c(DWI3C *s, uint16_t offset)=0A=
+{=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    uint16_t dev_index =3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_PO=
INTER,=0A=
+                                          ADDR) / sizeof(uint32_t)) + offs=
et;=0A=
+    return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,=0A=
+                   LEGACY_I2C_DEVICE);=0A=
+}=0A=
+=0A=
+static uint8_t dw_i3c_target_addr(DWI3C *s, uint16_t offset)=0A=
+{=0A=
+    if (offset > s->cfg.num_addressable_devices) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Device addr table offset %d ou=
t of "=0A=
+                      "bounds\n", path, offset);=0A=
+        /* If we're out of bounds, return an address of 0. */=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /* / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
. */=0A=
+    uint16_t dev_index =3D (ARRAY_FIELD_EX32(s->regs, DEVICE_ADDR_TABLE_PO=
INTER,=0A=
+                                          ADDR) / sizeof(uint32_t)) + offs=
et;=0A=
+    /* I2C devices use a static address. */=0A=
+    if (dw_i3c_target_is_i2c(s, offset)) {=0A=
+        return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,=0A=
+                          DEV_STATIC_ADDR);=0A=
+    }=0A=
+    return FIELD_EX32(s->regs[dev_index], DEVICE_ADDR_TABLE_LOC1,=0A=
+                      DEV_DYNAMIC_ADDR);=0A=
+}=0A=
+=0A=
 static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
 {=0A=
     /* Only return the status whose corresponding EN bits are set. */=0A=
@@ -376,6 +543,56 @@ static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val=
)=0A=
     dw_i3c_update_irq(s);=0A=
 }=0A=
 =0A=
+static uint32_t dw_i3c_pop_rx(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->rx_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to read RX FIFO when emp=
ty\n",=0A=
+                      path);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    uint32_t val =3D fifo32_pop(&s->rx_queue);=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,=0A=
+                     fifo32_num_used(&s->rx_queue));=0A=
+=0A=
+    /* Threshold is 2^RX_BUF_THLD. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,=
=0A=
+                                         RX_BUF_THLD);=0A=
+    threshold =3D dw_i3c_fifo_threshold_from_reg(threshold);=0A=
+    if (fifo32_num_used(&s->rx_queue) < threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_pop_rx(s->cfg.id, val);=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_resp_queue_port_r(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->resp_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to read response FIFO wh=
en "=0A=
+                      "empty\n", path);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    uint32_t val =3D fifo32_pop(&s->resp_queue);=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         RESP_BUF_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->resp_queue) < threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+=0A=
+    return val;=0A=
+}=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -392,16 +609,635 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr off=
set, unsigned size)=0A=
     case R_INTR_STATUS:=0A=
         value =3D dw_i3c_intr_status_r(s);=0A=
         break;=0A=
+    case R_RX_TX_DATA_PORT:=0A=
+        value =3D dw_i3c_pop_rx(s);=0A=
+        break;=0A=
+    case R_RESPONSE_QUEUE_PORT:=0A=
+        value =3D dw_i3c_resp_queue_port_r(s);=0A=
+        break;=0A=
     default:=0A=
         value =3D s->regs[addr];=0A=
         break;=0A=
     }=0A=
 =0A=
-    trace_dw_i3c_read(s->id, offset, value);=0A=
+    trace_dw_i3c_read(s->cfg.id, offset, value);=0A=
 =0A=
     return value;=0A=
 }=0A=
 =0A=
+static void dw_i3c_resp_queue_push(DWI3C *s, uint8_t err, uint8_t tid,=0A=
+                                   uint8_t ccc_type, uint16_t data_len)=0A=
+{=0A=
+    uint32_t val =3D 0;=0A=
+    val =3D FIELD_DP32(val, RESPONSE_QUEUE_PORT, ERR_STATUS, err);=0A=
+    val =3D FIELD_DP32(val, RESPONSE_QUEUE_PORT, TID, tid);=0A=
+    val =3D FIELD_DP32(val, RESPONSE_QUEUE_PORT, CCCT, ccc_type);=0A=
+    val =3D FIELD_DP32(val, RESPONSE_QUEUE_PORT, DL, data_len);=0A=
+    if (!fifo32_is_full(&s->resp_queue)) {=0A=
+        trace_dw_i3c_resp_queue_push(s->cfg.id, val);=0A=
+        fifo32_push(&s->resp_queue, val);=0A=
+    }=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, RESP_BUF_BLR,=0A=
+                     fifo32_num_used(&s->resp_queue));=0A=
+    /* Threshold is the register value + 1. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=0A=
+                                         RESP_BUF_THLD) + 1;=0A=
+    if (fifo32_num_used(&s->resp_queue) >=3D threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RESP_RDY, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void dw_i3c_push_tx(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    if (fifo32_is_full(&s->tx_queue)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to push to TX FIFO when =
"=0A=
+                      "full\n", object_get_canonical_path(OBJECT(s)));=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_dw_i3c_push_tx(s->cfg.id, val);=0A=
+    fifo32_push(&s->tx_queue, val);=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,=
=0A=
+                     fifo32_num_free(&s->tx_queue));=0A=
+=0A=
+    /* Threshold is 2^TX_BUF_THLD. */=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD=
_CTRL,=0A=
+                                               TX_BUF_THLD);=0A=
+    empty_threshold =3D=0A=
+        dw_i3c_fifo_threshold_from_reg(empty_threshold);=0A=
+    if (fifo32_num_free(&s->tx_queue) < empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_pop_tx(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->tx_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to pop from TX FIFO when=
 "=0A=
+                      "empty\n", path);=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    uint32_t val =3D fifo32_pop(&s->tx_queue);=0A=
+    trace_dw_i3c_pop_tx(s->cfg.id, val);=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC,=
=0A=
+                     fifo32_num_free(&s->tx_queue));=0A=
+=0A=
+    /* Threshold is 2^TX_BUF_THLD. */=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD=
_CTRL,=0A=
+                                               TX_BUF_THLD);=0A=
+    empty_threshold =3D=0A=
+        dw_i3c_fifo_threshold_from_reg(empty_threshold);=0A=
+    if (fifo32_num_free(&s->tx_queue) >=3D empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, TX_THLD, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void dw_i3c_push_rx(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    if (fifo32_is_full(&s->rx_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to push to RX FIFO when =
"=0A=
+                      "full\n", path);=0A=
+        return;=0A=
+    }=0A=
+    trace_dw_i3c_push_rx(s->cfg.id, val);=0A=
+    fifo32_push(&s->rx_queue, val);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,=0A=
+                     fifo32_num_used(&s->rx_queue));=0A=
+    /* Threshold is 2^RX_BUF_THLD. */=0A=
+    uint8_t threshold =3D ARRAY_FIELD_EX32(s->regs, DATA_BUFFER_THLD_CTRL,=
=0A=
+                                         RX_BUF_THLD);=0A=
+    threshold =3D dw_i3c_fifo_threshold_from_reg(threshold);=0A=
+    if (fifo32_num_used(&s->rx_queue) >=3D threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, RX_THLD, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void dw_i3c_short_transfer(DWI3C *s, DWI3CTransferCmd cmd,=0A=
+                                  DWI3CShortArg arg)=0A=
+{=0A=
+    uint8_t err =3D DW_I3C_RESP_QUEUE_ERR_NONE;=0A=
+    uint8_t addr =3D dw_i3c_target_addr(s, cmd.dev_index);=0A=
+    bool is_i2c =3D dw_i3c_target_is_i2c(s, cmd.dev_index);=0A=
+    uint8_t data[4]; /* Max we can send on a short transfer is 4 bytes. */=
=0A=
+    uint8_t len =3D 0;=0A=
+    uint32_t bytes_sent; /* Ignored on short transfers. */=0A=
+=0A=
+    /* Can't do reads on a short transfer. */=0A=
+    if (cmd.rnw) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Cannot do a read on a short "=
=0A=
+                      "transfer\n", path);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (dw_i3c_send_start(s, addr, /*is_recv=3D*/false, is_i2c)) {=0A=
+        err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+        goto transfer_done;=0A=
+    }=0A=
+=0A=
+    /* Are we sending a command? */=0A=
+    if (cmd.cp) {=0A=
+        data[len] =3D cmd.cmd;=0A=
+        len++;=0A=
+        /*=0A=
+         * byte0 is the defining byte for a command, and is only sent if a=
=0A=
+         * command is present and if the command has a defining byte prese=
nt.=0A=
+         * (byte_strb & 0x01) is always treated as set by the controller, =
and is=0A=
+         * ignored.=0A=
+         */=0A=
+        if (cmd.dbp) {=0A=
+            data[len] +=3D arg.byte0;=0A=
+            len++;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    /* Send the bytes passed in the argument. */=0A=
+    if (arg.byte_strb & 0x02) {=0A=
+        data[len] =3D arg.byte1;=0A=
+        len++;=0A=
+    }=0A=
+    if (arg.byte_strb & 0x04) {=0A=
+        data[len] =3D arg.byte2;=0A=
+        len++;=0A=
+    }=0A=
+=0A=
+    if (dw_i3c_send(s, data, len, &bytes_sent, is_i2c)) {=0A=
+        err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+    } else {=0A=
+        /* Only go to an idle state on a successful transfer. */=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    }=0A=
+=0A=
+transfer_done:=0A=
+    if (cmd.toc) {=0A=
+        dw_i3c_end_transfer(s, is_i2c);=0A=
+    }=0A=
+    if (cmd.roc) {=0A=
+        /*=0A=
+         * ccc_type is always 0 in controller mode, data_len is 0 in short=
=0A=
+         * transfers.=0A=
+         */=0A=
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=3D*/0,=0A=
+                                          /*data_len=3D*/0);=0A=
+    }=0A=
+}=0A=
+=0A=
+/* Returns number of bytes transmitted. */=0A=
+static uint16_t dw_i3c_tx(DWI3C *s, uint16_t num, bool is_i2c)=0A=
+{=0A=
+    uint16_t bytes_sent =3D 0;=0A=
+    union {=0A=
+        uint8_t b[sizeof(uint32_t)];=0A=
+        uint32_t val;=0A=
+    } val32;=0A=
+=0A=
+    while (bytes_sent < num) {=0A=
+        val32.val =3D dw_i3c_pop_tx(s);=0A=
+        for (uint8_t i =3D 0; i < sizeof(val32.val); i++) {=0A=
+            if (dw_i3c_send_byte(s, val32.b[i], is_i2c)) {=0A=
+                return bytes_sent;=0A=
+            }=0A=
+            bytes_sent++;=0A=
+=0A=
+            /* We're not sending the full 32-bits, break early. */=0A=
+            if (bytes_sent >=3D num) {=0A=
+                break;=0A=
+            }=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return bytes_sent;=0A=
+}=0A=
+=0A=
+/* Returns number of bytes received. */=0A=
+static uint16_t dw_i3c_rx(DWI3C *s, uint16_t num, bool is_i2c)=0A=
+{=0A=
+    /*=0A=
+     * Allocate a temporary buffer to read data from the target.=0A=
+     * Zero it and word-align it as well in case we're reading unaligned d=
ata.=0A=
+     */=0A=
+    g_autofree uint8_t *data =3D g_new0(uint8_t, num + (4 - (num & 0x03)))=
;=0A=
+    uint32_t *data32 =3D (uint32_t *)data;=0A=
+    /*=0A=
+     * 32-bits since the I3C API wants a 32-bit number, even though the=0A=
+     * controller can only do 16-bit transfers.=0A=
+     */=0A=
+    uint32_t num_read =3D 0;=0A=
+=0A=
+    /* Can NACK if the target receives an unsupported CCC. */=0A=
+    if (dw_i3c_recv_data(s, is_i2c, data, num, &num_read)) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    for (uint16_t i =3D 0; i < num_read / 4; i++) {=0A=
+        dw_i3c_push_rx(s, *data32);=0A=
+        data32++;=0A=
+    }=0A=
+    /*=0A=
+     * If we're pushing data that isn't 32-bit aligned, push what's left.=
=0A=
+     * It's software's responsibility to know what bits are valid in the p=
artial=0A=
+     * data.=0A=
+     */=0A=
+    if (num_read & 0x03) {=0A=
+        dw_i3c_push_rx(s, *data32);=0A=
+    }=0A=
+=0A=
+    return num_read;=0A=
+}=0A=
+=0A=
+static int dw_i3c_transfer_ccc(DWI3C *s, DWI3CTransferCmd cmd,=0A=
+                               DWI3CTransferArg arg)=0A=
+{=0A=
+    /* CCC start is always a write. CCCs cannot be done on I2C devices. */=
=0A=
+    if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=3D*/false,=0A=
+                                     /*is_i2c=3D*/false)) {=0A=
+        return DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;=0A=
+    }=0A=
+    trace_dw_i3c_transfer_ccc(s->cfg.id, cmd.cmd);=0A=
+    if (dw_i3c_send_byte(s, cmd.cmd, /*is_i2c=3D*/false)) {=0A=
+        return DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+    }=0A=
+=0A=
+    /* On a direct CCC, we do a restart and then send the target's address=
. */=0A=
+    if (CCC_IS_DIRECT(cmd.cmd)) {=0A=
+        bool is_recv =3D cmd.rnw;=0A=
+        uint8_t addr =3D dw_i3c_target_addr(s, cmd.dev_index);=0A=
+        if (dw_i3c_send_start(s, addr, is_recv, /*is_i2c=3D*/false)) {=0A=
+            return DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return DW_I3C_RESP_QUEUE_ERR_NONE;=0A=
+}=0A=
+=0A=
+static void dw_i3c_transfer(DWI3C *s, DWI3CTransferCmd cmd,=0A=
+                            DWI3CTransferArg arg)=0A=
+{=0A=
+    bool is_recv =3D cmd.rnw;=0A=
+    uint8_t err =3D DW_I3C_RESP_QUEUE_ERR_NONE;=0A=
+    uint8_t addr =3D dw_i3c_target_addr(s, cmd.dev_index);=0A=
+    bool is_i2c =3D dw_i3c_target_is_i2c(s, cmd.dev_index);=0A=
+    uint16_t bytes_transferred =3D 0;=0A=
+=0A=
+    if (cmd.cp) {=0A=
+        /* We're sending a CCC. */=0A=
+        err =3D dw_i3c_transfer_ccc(s, cmd, arg);=0A=
+        if (err !=3D DW_I3C_RESP_QUEUE_ERR_NONE) {=0A=
+            goto transfer_done;=0A=
+        }=0A=
+    } else {=0A=
+        if (ARRAY_FIELD_EX32(s->regs, DEVICE_CTRL, I3C_BROADCAST_ADDR_INC)=
 &&=0A=
+            is_i2c =3D=3D false) {=0A=
+            if (dw_i3c_send_start(s, I3C_BROADCAST,=0A=
+                                             /*is_recv=3D*/false, is_i2c))=
 {=0A=
+                err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+                goto transfer_done;=0A=
+            }=0A=
+        }=0A=
+        /* Otherwise we're doing a private transfer. */=0A=
+        if (dw_i3c_send_start(s, addr, is_recv, is_i2c)) {=0A=
+            err =3D DW_I3C_RESP_QUEUE_ERR_I2C_NACK;=0A=
+            goto transfer_done;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    if (is_recv) {=0A=
+        bytes_transferred =3D dw_i3c_rx(s, arg.data_len, is_i2c);=0A=
+    } else {=0A=
+        bytes_transferred =3D dw_i3c_tx(s, arg.data_len, is_i2c);=0A=
+    }=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+=0A=
+transfer_done:=0A=
+    if (cmd.toc) {=0A=
+        dw_i3c_end_transfer(s, is_i2c);=0A=
+    }=0A=
+    if (cmd.roc) {=0A=
+        /*=0A=
+         * data_len is the number of bytes that still need to be TX'd, or =
the=0A=
+         * number of bytes RX'd.=0A=
+         */=0A=
+        uint16_t data_len =3D is_recv ? bytes_transferred : arg.data_len -=
=0A=
+                                                          bytes_transferre=
d;=0A=
+        /* CCCT is always 0 in controller mode. */=0A=
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=3D*/0,=0A=
+                                          data_len);=0A=
+    }=0A=
+=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_transfer_cmd(DWI3C *s, DWI3CTransferCmd cmd,=0A=
+                                DWI3CCmdQueueData arg)=0A=
+{=0A=
+    uint8_t arg_attr =3D FIELD_EX32(arg.word, COMMAND_QUEUE_PORT, CMD_ATTR=
);=0A=
+=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CMD_TID, cmd.tid);=0A=
+=0A=
+    /* User is trying to do HDR transfers, see if we can do them. */=0A=
+    if (cmd.speed =3D=3D 0x06 && !dw_i3c_has_hdr_ddr(s)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: HDR DDR is not supported\n", p=
ath);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+        return;=0A=
+    }=0A=
+    if (cmd.speed =3D=3D 0x05 && !dw_i3c_has_hdr_ts(s)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: HDR TS is not supported\n", pa=
th);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (arg_attr =3D=3D DW_I3C_CMD_ATTR_TRANSFER_ARG) {=0A=
+        dw_i3c_transfer(s, cmd, arg.transfer_arg);=0A=
+    } else if (arg_attr =3D=3D DW_I3C_CMD_ATTR_SHORT_DATA_ARG) {=0A=
+        dw_i3c_short_transfer(s, cmd, arg.short_arg);=0A=
+    } else {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Unknown command queue cmd_attr=
 0x%x"=0A=
+                      "\n", path, arg_attr);=0A=
+        ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                         DW_I3C_TRANSFER_STATE_HALT);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void dw_i3c_update_char_table(DWI3C *s, uint8_t offset, uint64_t pi=
d,=0A=
+                                     uint8_t bcr, uint8_t dcr, uint8_t add=
r)=0A=
+{=0A=
+    if (offset > s->cfg.num_addressable_devices) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Device char table offset %d ou=
t of "=0A=
+                      "bounds\n", path, offset);=0A=
+        /* If we're out of bounds, do nothing. */=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * Each device offset is 128 bits apart in the table, since each devic=
e gets=0A=
+     * 4 * 32-bits of entries in the table.=0A=
+     * / sizeof(uint32_t) because we're indexing into our 32-bit reg array=
.=0A=
+     */=0A=
+    uint16_t dev_index =3D (ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINT=
ER,=0A=
+                                          P_DEV_CHAR_TABLE_START_ADDR) /=
=0A=
+                                          sizeof(uint32_t)) +=0A=
+                                          (offset * sizeof(uint32_t));=0A=
+    s->regs[dev_index] =3D pid & 0xffffffff;=0A=
+    pid >>=3D 32;=0A=
+    s->regs[dev_index + 1] =3D FIELD_DP32(s->regs[dev_index + 1],=0A=
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC2,=
=0A=
+                                        MSB_PID, pid);=0A=
+    s->regs[dev_index + 2] =3D FIELD_DP32(s->regs[dev_index + 2],=0A=
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC3, =
DCR,=0A=
+                                        dcr);=0A=
+    s->regs[dev_index + 2] =3D FIELD_DP32(s->regs[dev_index + 2],=0A=
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC3, =
BCR,=0A=
+                                        bcr);=0A=
+    s->regs[dev_index + 3] =3D FIELD_DP32(s->regs[dev_index + 3],=0A=
+                                        DEVICE_CHARACTERISTIC_TABLE_LOC4,=
=0A=
+                                        DEV_DYNAMIC_ADDR, addr);=0A=
+=0A=
+    /* Increment PRESENT_DEV_CHAR_TABLE_INDEX. */=0A=
+    uint8_t idx =3D ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                     PRESENT_DEV_CHAR_TABLE_INDEX);=0A=
+    /* Increment and rollover. */=0A=
+    idx++;=0A=
+    if (idx >=3D ARRAY_FIELD_EX32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                               DEV_CHAR_TABLE_DEPTH) / 4) {=0A=
+        idx =3D 0;=0A=
+    }=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                     PRESENT_DEV_CHAR_TABLE_INDEX, idx);=0A=
+}=0A=
+=0A=
+static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)=0A=
+{=0A=
+    uint8_t i =3D 0;=0A=
+    uint8_t err =3D DW_I3C_RESP_QUEUE_ERR_NONE;=0A=
+=0A=
+    /* Tell everyone to ENTDAA. If these error, no one is on the bus. */=
=0A=
+    if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=3D*/false,=0A=
+                                     /*is_i2c=3D*/false)) {=0A=
+        err =3D DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;=0A=
+        goto transfer_done;=0A=
+    }=0A=
+    if (dw_i3c_send_byte(s, cmd.cmd, /*is_i2c=3D*/false)) {=0A=
+        err =3D DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;=0A=
+        goto transfer_done;=0A=
+    }=0A=
+=0A=
+    /* Go through each device in the table and assign it an address. */=0A=
+    for (i =3D 0; i < cmd.dev_count; i++) {=0A=
+        uint8_t addr =3D dw_i3c_target_addr(s, cmd.dev_index + i);=0A=
+        union {=0A=
+            uint64_t pid:48;=0A=
+            uint8_t bcr;=0A=
+            uint8_t dcr;=0A=
+            uint32_t w[2];=0A=
+            uint8_t b[8];=0A=
+        } target_info;=0A=
+=0A=
+        /* If this fails, there was no one left to ENTDAA. */=0A=
+        if (dw_i3c_send_start(s, I3C_BROADCAST, /*is_recv=3D*/false,=0A=
+                                         /*is_i2c=3D*/false)) {=0A=
+            err =3D DW_I3C_RESP_QUEUE_ERR_BROADCAST_NACK;=0A=
+            break;=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * In ENTDAA, we read 8 bytes from the target, which will be the=
=0A=
+         * target's PID, BCR, and DCR. After that, we send it the dynamic=
=0A=
+         * address.=0A=
+         * Don't bother checking the number of bytes received, it must sen=
d 8=0A=
+         * bytes during ENTDAA.=0A=
+         */=0A=
+        uint32_t num_read;=0A=
+        if (dw_i3c_recv_data(s, /*is_i2c=3D*/false, target_info.b,=0A=
+                                        I3C_ENTDAA_SIZE, &num_read)) {=0A=
+            g_autofree char *path =3D object_get_canonical_path(OBJECT(s))=
;=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Target NACKed ENTDAA CCC\n=
",=0A=
+                          path);=0A=
+            err =3D DW_I3C_RESP_QUEUE_ERR_DAA_NACK;=0A=
+            goto transfer_done;=0A=
+        }=0A=
+        if (dw_i3c_send_byte(s, addr, /*is_i2c=3D*/false)) {=0A=
+            g_autofree char *path =3D object_get_canonical_path(OBJECT(s))=
;=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Target NACKed addr 0x%.2x =
"=0A=
+                          "during ENTDAA\n", path, addr);=0A=
+            err =3D DW_I3C_RESP_QUEUE_ERR_DAA_NACK;=0A=
+            break;=0A=
+        }=0A=
+        dw_i3c_update_char_table(s, cmd.dev_index + i,=0A=
+                                            target_info.pid, target_info.b=
cr,=0A=
+                                            target_info.dcr, addr);=0A=
+=0A=
+        /* Push the PID, BCR, and DCR to the RX queue. */=0A=
+        dw_i3c_push_rx(s, target_info.w[0]);=0A=
+        dw_i3c_push_rx(s, target_info.w[1]);=0A=
+    }=0A=
+=0A=
+transfer_done:=0A=
+    /* Do we send a STOP? */=0A=
+    if (cmd.toc) {=0A=
+        dw_i3c_end_transfer(s, /*is_i2c=3D*/false);=0A=
+    }=0A=
+    /*=0A=
+     * For addr assign commands, the length field is the number of devices=
=0A=
+     * left to assign. CCCT is always 0 in controller mode.=0A=
+     */=0A=
+    if (cmd.roc) {=0A=
+        dw_i3c_resp_queue_push(s, err, cmd.tid, /*ccc_type=3D*/0,=0A=
+                                         cmd.dev_count - i);=0A=
+    }=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_cmd_queue_pop(DWI3C *s)=0A=
+{=0A=
+    if (fifo32_is_empty(&s->cmd_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to dequeue command queue=
 "=0A=
+                      "when it was empty\n", path);=0A=
+        return 0;=0A=
+    }=0A=
+    uint32_t val =3D fifo32_pop(&s->cmd_queue);=0A=
+=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                               CMD_BUF_EMPTY_THLD);=0A=
+    uint8_t cmd_queue_empty_loc =3D ARRAY_FIELD_EX32(s->regs,=0A=
+                                                   QUEUE_STATUS_LEVEL,=0A=
+                                                   CMD_QUEUE_EMPTY_LOC);=
=0A=
+    cmd_queue_empty_loc++;=0A=
+    ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,=0A=
+                     cmd_queue_empty_loc);=0A=
+    if (cmd_queue_empty_loc >=3D empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 1);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void dw_i3c_cmd_queue_execute(DWI3C *s)=0A=
+{=0A=
+    ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,=0A=
+                     DW_I3C_TRANSFER_STATE_IDLE);=0A=
+    if (!dw_i3c_can_transmit(s)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * We only start executing when a command is passed into the FIFO.=0A=
+     * We expect there to be a multiple of 2 items in the queue. The first=
 item=0A=
+     * should be an argument to a command, and the command should be the s=
econd=0A=
+     * item.=0A=
+     */=0A=
+    if (fifo32_num_used(&s->cmd_queue) & 1) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    while (!fifo32_is_empty(&s->cmd_queue)) {=0A=
+        DWI3CCmdQueueData arg;=0A=
+        arg.word =3D dw_i3c_cmd_queue_pop(s);=0A=
+        DWI3CCmdQueueData cmd;=0A=
+        cmd.word =3D dw_i3c_cmd_queue_pop(s);=0A=
+        trace_dw_i3c_cmd_queue_execute(s->cfg.id, cmd.word, arg.word);=0A=
+=0A=
+        uint8_t cmd_attr =3D FIELD_EX32(cmd.word, COMMAND_QUEUE_PORT, CMD_=
ATTR);=0A=
+        switch (cmd_attr) {=0A=
+        case DW_I3C_CMD_ATTR_TRANSFER_CMD:=0A=
+            dw_i3c_transfer_cmd(s, cmd.transfer_cmd, arg);=0A=
+            break;=0A=
+        case DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD:=0A=
+            /* Arg is discarded for addr assign commands. */=0A=
+            dw_i3c_addr_assign_cmd(s, cmd.addr_assign_cmd);=0A=
+            break;=0A=
+        case DW_I3C_CMD_ATTR_TRANSFER_ARG:=0A=
+        case DW_I3C_CMD_ATTR_SHORT_DATA_ARG:=0A=
+            {=0A=
+                g_autofree char *path =3D object_get_canonical_path(OBJECT=
(s));=0A=
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received=
 "=0A=
+                              "argument packet when it expected a command =
"=0A=
+                              "packet\n", path);=0A=
+            }=0A=
+            break;=0A=
+        default:=0A=
+            /*=0A=
+             * The caller's check before queueing an item should prevent t=
his=0A=
+             * from happening.=0A=
+             */=0A=
+            g_assert_not_reached();=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+static void dw_i3c_cmd_queue_push(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    if (fifo32_is_full(&s->cmd_queue)) {=0A=
+        g_autofree char *path =3D object_get_canonical_path(OBJECT(s));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received packet =
when "=0A=
+                      "already full\n", path);=0A=
+        return;=0A=
+    }=0A=
+    trace_dw_i3c_cmd_queue_push(s->cfg.id, val);=0A=
+    fifo32_push(&s->cmd_queue, val);=0A=
+=0A=
+    uint8_t empty_threshold =3D ARRAY_FIELD_EX32(s->regs, QUEUE_THLD_CTRL,=
=0A=
+                                               CMD_BUF_EMPTY_THLD);=0A=
+    uint8_t cmd_queue_empty_loc =3D ARRAY_FIELD_EX32(s->regs,=0A=
+                                                   QUEUE_STATUS_LEVEL,=0A=
+                                                   CMD_QUEUE_EMPTY_LOC);=
=0A=
+    if (cmd_queue_empty_loc) {=0A=
+        cmd_queue_empty_loc--;=0A=
+        ARRAY_FIELD_DP32(s->regs, QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,=
=0A=
+                         cmd_queue_empty_loc);=0A=
+    }=0A=
+    if (cmd_queue_empty_loc < empty_threshold) {=0A=
+        ARRAY_FIELD_DP32(s->regs, INTR_STATUS, CMD_QUEUE_RDY, 0);=0A=
+        dw_i3c_update_irq(s);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void dw_i3c_cmd_queue_port_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    uint8_t cmd_attr =3D FIELD_EX32(val, COMMAND_QUEUE_PORT, CMD_ATTR);=0A=
+=0A=
+    switch (cmd_attr) {=0A=
+    /* If a command is received we can start executing it. */=0A=
+    case DW_I3C_CMD_ATTR_TRANSFER_CMD:=0A=
+    case DW_I3C_CMD_ATTR_ADDR_ASSIGN_CMD:=0A=
+        dw_i3c_cmd_queue_push(s, val);=0A=
+        dw_i3c_cmd_queue_execute(s);=0A=
+        break;=0A=
+    /* If we get an argument just push it. */=0A=
+    case DW_I3C_CMD_ATTR_TRANSFER_ARG:=0A=
+    case DW_I3C_CMD_ATTR_SHORT_DATA_ARG:=0A=
+        dw_i3c_cmd_queue_push(s, val);=0A=
+        break;=0A=
+    default:=0A=
+        {=0A=
+            g_autofree char *path =3D object_get_canonical_path(OBJECT(s))=
;=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Command queue received pac=
ket "=0A=
+                          "with unknown cmd attr 0x%x\n", path, cmd_attr);=
=0A=
+        }=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,=0A=
                          unsigned size)=0A=
 {=0A=
@@ -409,7 +1245,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, =
uint64_t value,=0A=
     uint32_t addr =3D offset >> 2;=0A=
     uint32_t val32 =3D (uint32_t)value;=0A=
 =0A=
-    trace_dw_i3c_write(s->id, offset, value);=0A=
+    trace_dw_i3c_write(s->cfg.id, offset, value);=0A=
 =0A=
     val32 &=3D ~dw_i3c_ro[addr];=0A=
     switch (addr) {=0A=
@@ -433,6 +1269,10 @@ static void dw_i3c_write(void *opaque, hwaddr offset,=
 uint64_t value,=0A=
                       __func__, offset, value);=0A=
         break;=0A=
     case R_RX_TX_DATA_PORT:=0A=
+        dw_i3c_push_tx(s, val32);=0A=
+        break;=0A=
+    case R_COMMAND_QUEUE_PORT:=0A=
+        dw_i3c_cmd_queue_port_w(s, val32);=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
@@ -475,22 +1315,56 @@ static void dw_i3c_reset_enter(Object *obj, ResetTyp=
e type)=0A=
     DWI3C *s =3D DW_I3C(obj);=0A=
 =0A=
     memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));=0A=
+    /*=0A=
+     * The user config for these may differ from our resets array, set the=
m=0A=
+     * manually.=0A=
+     */=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, ADDR,=0A=
+                     s->cfg.dev_addr_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEVICE_ADDR_TABLE_POINTER, DEPTH,=0A=
+                     s->cfg.dev_addr_table_depth);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER,=0A=
+                     P_DEV_CHAR_TABLE_START_ADDR,=0A=
+                     s->cfg.dev_char_table_pointer);=0A=
+    ARRAY_FIELD_DP32(s->regs, DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH=
,=0A=
+                     s->cfg.dev_char_table_depth);=0A=
 }=0A=
 =0A=
 static void dw_i3c_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(dev);=0A=
-    g_autofree char *name =3D g_strdup_printf(TYPE_DW_I3C ".%d", s->id);=
=0A=
+    g_autofree char *name =3D g_strdup_printf(TYPE_DW_I3C ".%d", s->cfg.id=
);=0A=
 =0A=
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);=0A=
 =0A=
     memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,=0A=
                           DW_I3C_NR_REGS << 2);=0A=
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);=0A=
+=0A=
+    fifo32_create(&s->cmd_queue, s->cfg.cmd_resp_queue_capacity_bytes);=0A=
+    fifo32_create(&s->resp_queue, s->cfg.cmd_resp_queue_capacity_bytes);=
=0A=
+    fifo32_create(&s->tx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
+    fifo32_create(&s->rx_queue, s->cfg.tx_rx_queue_capacity_bytes);=0A=
+=0A=
+    s->bus =3D i3c_init_bus(DEVICE(s), name);=0A=
 }=0A=
 =0A=
 static const Property dw_i3c_properties[] =3D {=0A=
-    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),=0A=
+    DEFINE_PROP_UINT8("device-id", DWI3C, cfg.id, 0),=0A=
+    DEFINE_PROP_UINT8("command-response-queue-capacity-bytes", DWI3C,=0A=
+                      cfg.cmd_resp_queue_capacity_bytes, 0x10),=0A=
+    DEFINE_PROP_UINT16("tx-rx-queue-capacity-bytes", DWI3C,=0A=
+                      cfg.tx_rx_queue_capacity_bytes, 0x40),=0A=
+    DEFINE_PROP_UINT8("num-addressable-devices", DWI3C,=0A=
+                      cfg.num_addressable_devices, 8),=0A=
+    DEFINE_PROP_UINT16("dev-addr-table-pointer", DWI3C,=0A=
+                       cfg.dev_addr_table_pointer, 0x280),=0A=
+    DEFINE_PROP_UINT16("dev-addr-table-depth", DWI3C,=0A=
+                       cfg.dev_addr_table_depth, 0x08),=0A=
+    DEFINE_PROP_UINT16("dev-char-table-pointer", DWI3C,=0A=
+                       cfg.dev_char_table_pointer, 0x200),=0A=
+    DEFINE_PROP_UINT16("dev-char-table-depth", DWI3C,=0A=
+                       cfg.dev_char_table_depth, 0x20),=0A=
 };=0A=
 =0A=
 static void dw_i3c_class_init(ObjectClass *klass, const void *data)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
index 2d944387db..044ff06a01 100644=0A=
--- a/hw/i3c/trace-events=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -7,6 +7,16 @@ aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C writ=
e: offset 0x%" PRIx64=0A=
 # dw-i3c,c=0A=
 dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u=
] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
 dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%=
u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+dw_i3c_send(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] send %" PR=
Id32 " bytes to bus"=0A=
+dw_i3c_recv_data(uint32_t deviceid, uint32_t num_bytes) "I3C Dev[%u] recv =
%" PRId32 " bytes from bus"=0A=
+dw_i3c_pop_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from RX FIFO"=0A=
+dw_i3c_resp_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push=
 0x%" PRIx32 " to response queue"=0A=
+dw_i3c_push_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to TX FIFO"=0A=
+dw_i3c_pop_tx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] pop 0x%" PRIx=
32 " from TX FIFO"=0A=
+dw_i3c_push_rx(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push 0x%" PR=
Ix32 " to RX FIFO"=0A=
+dw_i3c_transfer_ccc(uint32_t deviceid, uint8_t ccc) "I3C Dev[%u] transfer =
CCC 0x%" PRIx8=0A=
+dw_i3c_cmd_queue_execute(uint32_t deviceid, uint32_t cmd, uint32_t arg) "I=
3C Dev[%u] execute command 0x%" PRIx32 " arg 0x%" PRIx32=0A=
+dw_i3c_cmd_queue_push(uint32_t deviceid, uint32_t data) "I3C Dev[%u] push =
0x%" PRIx32 " to cmd queue"=0A=
 =0A=
 # core.c=0A=
 i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " =
event 0x%" PRIx8=0A=
-- =0A=
2.43.0=0A=


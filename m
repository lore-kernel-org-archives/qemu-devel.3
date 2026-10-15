Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B42CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHETS-0002Yd-Ki; Thu, 15 Oct 2026 01:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESh-0001se-HW; Thu, 15 Oct 2026 01:57:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESg-0003El-2l; Thu, 15 Oct 2026 01:57:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwqIvytNrCRmUMGGOXb0169ihoZBi4ukuHUKbnLYf+yctHmLgQpCOA9MkV2Q+5xGEV4AVZF7Qz8hH6gZUteLiPADAvqSqthU/VzyCKeuB+VlzlbCNaZRyfSc291Od8J21uddt2i//MpizgZYs9STaq8uU5wabh7KjCzdE0ggj8PzawsycEudYEZzkrpbWnKFYCJzeV0PDPIGyxu2hJhQ0absWOoEv5Aix7Lkc8MX67MoVNOFoRl0SkFOBzzkAllf4BxWK7eVInN7348IPWcmGUOQfAXda3sX6r40i8OXmm9ITutbTdUjcYQqBwv8zmkujerzZVlsp4XSq5VhukPeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbnCJnJ3NGjsSakrkRHS0/NKUpyIaexSkcbqDcKuiHA=;
 b=XsqKGF5zOFplJyJNJMqhPImUWU1L+fbtGun2d8AHTDbYOWydBiPAMze7kgQD8YbG+keqzCt7PfspInT46wNGTbG/2te4V7YuoOkms37PRl5r6sLYEENTUz4OdeztqMPX7EhfX/O7Ea0IZVyTIpMgGQyrlIqi9EI589xiQ8DaSIlsuwIdR+NdCFDp5HkFjC9QhO6jBeYeos5GQZu6cRMlV7w3CmzXU9sMJbHbubqMwabZxaemO9fBs3wBEpIu1I4uPvUYZlIhm6Mmy/yGlYkduaSPqQi0clpduPpZgu8RhLaTFrlKESUEmU/DhGL1919A0Hzh36qEBLMKkeYqRC1Mcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbnCJnJ3NGjsSakrkRHS0/NKUpyIaexSkcbqDcKuiHA=;
 b=i8GNLNZw/6Mliqz8NID+WzvoFL+EIUPQUoFMnnqWYO23qqnfPZUdlP1eDNvtufyvadr+7ImktQYdC93pfPhtbwjLsZCweuMYr6+75hPfXMnik0KO5AXUHz1VPvA1dIC9pvEldeFj+DXeBAbVCtV25bpNEsg7TE3vs3WF82VKG9YszwA+LVKgWi+QRQ8rbKWBUpPZ79x7d+zi/jjRi9Kf+q8l9a3p2J0E1LN5PkSV7ECGaK3Wgjjjyb4ajEOO4aZla9veyNp9IzFi9lktzDB2aUKFY2CSEnyC8QxnzVpWjV9/dIQRfcWvn+kP9mAx8gFU9cZXvEfIzoBF4RNQVA6vzA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by PUZPR06MB6185.apcprd06.prod.outlook.com (2603:1096:301:11b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:56:59 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:58 +0000
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
Subject: [PATCH v1 09/14] hw/arm/aspeed_ast1040: Add OTP as an unimplemented
 device
Thread-Topic: [PATCH v1 09/14] hw/arm/aspeed_ast1040: Add OTP as an
 unimplemented device
Thread-Index: AQHdXGn6+2sU4mJwTUWMMar/pjDXwQ==
Date: Thu, 15 Oct 2026 05:56:53 +0000
Message-ID: <20261015055642.106204-10-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|PUZPR06MB6185:EE_
x-ms-office365-filtering-correlation-id: 004fadb5-6d54-427c-ad31-08df2a812023
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|366016|376014|261009223027099003|10067099003|261009221227099003|921020|38070700021|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: irUzfQqhJHZNNlwsmiRI3OJFxIi3Wu9mjkM9Y8uSkoFKlYIqoC4nsKpIgAtiVl08udrpqS2j8oH2wkdLi9oKK7r4liYoLlyZ8VT6S8367xCLyPVAmDZx6HVzrbkFfE/0ukza3hnVlwsBREzfoizP/pMYljfl2uRLYamslG/uOgEwArg2rQpy2jdsAiDovQ4GyaN3FgaaEVpePt4BgiiXUnt71lOHoVwjAl+XmGsuLP1ZQ+4aTGEi+uoR6xlfV8bUNbXO1UXM85lqlCKervqNpwqeuPOuDjnnZtQJbYgmylDV5eUD3cPLlb/zwreRpkbIr2bzxdMr98eTNVsmaSEdBLq3CzX1tuvRw/+oFgUZ27NVCe37sYVSPyjgk+YOX49t7sreDVdbwCSm7wjTKAaddkGPewZj4cuWf61omI2ydycdyjSuAgm3Oy1FvAd74K1e4ccPwS+d8j19ZrydlLuwfhQFQoJeLqd/vpVnn+ykwJopY2uX8smPpKDjFTminR1KQqblQs7s74XFK1MSJH0KGJM8oIbB6Kal1tR84ztLzB6IMJwEWw41FP4tekA7y3PS8V80Oa879Kqm0s8lFkwRzsGirpI4AXnc2TXt2S/+gD9i6d0kym8wDlsDhD2JR594utBYGd0vTgBwrztfYHCzZFFXGUYf3+sBr9UTKvgOolsW5aCppGWFkkMKG+j5iWmUiXdOjGWUthH4okFSgDJTYGNvs817oPilyHfwtYEbyhQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(261009223027099003)(10067099003)(261009221227099003)(921020)(38070700021)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3Ww6TtiNX/9I52jF/m+DdVKzjW0Sz9iSGVYFq6tB6dAk0xmgylEulB8dD8?=
 =?iso-8859-1?Q?a0Hos8/Ujt2mhyFF39rPye03M22kPp7bqYQ6rkCPOUYeVBukQVItU5bgeP?=
 =?iso-8859-1?Q?/iMMQaGpmbjBLWdM+CFBfyaC5S16l+Z/WEtC2wTiqeLIaiKFssxsSDHl7Y?=
 =?iso-8859-1?Q?wOChrswvskpcAgykRZElDaO5+o6RW2frvVEVUGhJH+ck00NKWZzVGTxaLM?=
 =?iso-8859-1?Q?dN701O6KuwEiZSe9SePeJHtMqOtxD0GQVvmX8tpyZdWqkEqbDvETRZu+XR?=
 =?iso-8859-1?Q?B7BcC/mHCHreMdeb1TROJ1c54NgfV6KQLVY46S327MkSiASJ4tg578BoyQ?=
 =?iso-8859-1?Q?wGUAfQE3Aj5KCNYAiObQKzNhA00wwSRyeeaAxzoOq0xJqveej0wm9BFjo+?=
 =?iso-8859-1?Q?/WGFDGk2nMRRf7fPi7VGlOcBEV4Hvf6C6u2Cq95G51niCxtAdtFBFq/kjp?=
 =?iso-8859-1?Q?1Aje4btPYnJ6DHJY3BkQeexvSOxw1sssPwvicTwKDqp5dwDZwexyQ0XZUF?=
 =?iso-8859-1?Q?gan31rdn/BrF+hYlhYJObSIVL1oQVgmvjCjYeriozh71US9hCAVtZiBcGR?=
 =?iso-8859-1?Q?/ikyd7ilNDO7AvsgzwfrgtpH91f0GvrYkPXCMq1dSnaMSTz4Rg1ks3oNdU?=
 =?iso-8859-1?Q?xHnsWsTCZ0SBojTU3gTgV4LcRSw++ivfqtXZmOuVJ997HhKfrdU4Mq+Jyu?=
 =?iso-8859-1?Q?BsihR1t3hAj0n4Hdw/F4K4FqZNmbWqv5pd4JxKiak/eeQLQZHczJK3cF5Q?=
 =?iso-8859-1?Q?bdly3x+iHaz13mLSgflRr+2W8YuCCby3ila7Qbsc074h8vyHFsviVBFVE+?=
 =?iso-8859-1?Q?1Srjhy4lgxEu3KJHlHKD7RQMNGownvIS9/tetUPbyaSzUWIwh29Wdwu8kB?=
 =?iso-8859-1?Q?WuVrCGlTQWuSILK9DKvutsuCh9KmvyhXeQOnXuqeDXZbsVEiDAqo7U4pE9?=
 =?iso-8859-1?Q?3lZqYEezb3LBRDKEAZWNmlu+5AIQ42BWT6KvUt/pmUDiXL7RCGFluexm5F?=
 =?iso-8859-1?Q?LN1DsCX0n2eet4GuYCzqYfvcbmIqWrmbiYDKn+Nflf1wfLmIC9z0XjeDoI?=
 =?iso-8859-1?Q?41T5rY9FRTkM+VibHgpK3boSLxk7x4/FYyC8ztB/4DMZBekk79+Tph1Q3V?=
 =?iso-8859-1?Q?5YJdiytMlZTrcgJcQ+gaucU63iv2owpsr1y0W5Z7IJG/wV8n1c9pxrVF3l?=
 =?iso-8859-1?Q?ClN7uDwgXa4gO8Hc6JwsK9VnB2GnNUNHPOc1Uat5e2jMnjYfqeIgdBeaa6?=
 =?iso-8859-1?Q?eQ3cpYUeFWoUN0KDrcYYxYRAlw16reM4V1lstGJPcvNC9fPDkdsMmdhxnm?=
 =?iso-8859-1?Q?ZynPBiINpcTq1rNrcOCyAPO9/X0024OLEWFioIkn2ZkTxjWomuvpmkSOJC?=
 =?iso-8859-1?Q?c/Z7GPvSsGF1L6cH4dHCHeWkMEfQDl9VJsLUsnEm+g+VHbKN88CNdyRFsa?=
 =?iso-8859-1?Q?9kO6nbbjbe4WCnif1urH4u1VdUybF2cHB5b1BQK2KJfUzZGp6Bl6OX7M2C?=
 =?iso-8859-1?Q?nwxmaELtENCjAAS5oMsaTR4OD6+vNIdAEv4w3rrItK+lO6S7O4a/+aly65?=
 =?iso-8859-1?Q?9Ir3lNIlEaDULKOMd5iA1k2XDWY/PdpJ4kmSxGDZAoTyhDNK+wCnlX+qvZ?=
 =?iso-8859-1?Q?EbQqonOwYlHT0a9NWvb3RJFegf0i/RM+qB0wrvVGuxCfqM6bC83I4vj4Gb?=
 =?iso-8859-1?Q?sH2pa8I6L6PGw2jzM6pdZf54x7dg5zac32gjxgjqZ/SXXvnkBOS0vN3Lg/?=
 =?iso-8859-1?Q?Yv0Jze9CMnqkZcZeFwGAMulVWYXqQe91jqVGzx2Hm69AETKFLsYpzuZwU3?=
 =?iso-8859-1?Q?r2vBhM8P9Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yJTNcZKxH2Jx8P4ykZbizFWiaOj0wWC4Rgzz4wbOm2tR45uvo4z6wGao455Z92b4EHM9Tu4rTT25U304MlszMUvxPvOIbRdL5bh1Kt+Af8NgSmJwCwEyumDjFZsgFZmk0CDT52o8yQ3quGbZv9V7w6kS0Py+gZSO5j7uPXCxqLKLXmzLHgHeK2/ytWeaicGw8tgWAaN/wUDyduoCtt5IPxXoQu3j9rLH5xsGu3Lq+plwLv1C1WkbuL+XZXTCuY5fJ8hvplR2OwXbIBvGDi/+rf0rmYVVFNxdQ84LE0QOJ/iLStNq/8FbqT0vwlmwN0oWWkZrpwlV9M8TQQxvuZfHzQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004fadb5-6d54-427c-ad31-08df2a812023
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:53.6261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9ub72rzXS9YpayUZ9lTp3LipvdHFv54J4IpIs+Lzff9qQUw4qRON7nI9GCJgTdXVAkmGYI80KaIR95Mwe9yZRuolCG+63+lzw2YybcTRSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6185
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

The AST1040 provides an OTP controller at 0x74c07000, but the controller=0A=
is not modeled yet.=0A=
=0A=
Add the OTP register region as an unimplemented device to reflect the=0A=
AST1040 memory map.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index 5eb091e675..48eda35ffe 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -90,6 +90,7 @@ static const UnimplementedDeviceConfig aspeed_soc_ast1040=
_unimp_devs[] =3D {=0A=
     { "fmc-filter",  "aspeed.fmc-filter", 0x74000400, 0x1000, -1000 },=0A=
     { "spi0-filter", "aspeed.spi0-filter", 0x74010400, 0x1000, -1000 },=0A=
     { "spi1-filter", "aspeed.spi1-filter", 0x74020400, 0x1000, -1000 },=0A=
+    { "otp", "aspeed.otp", 0x74C07000, 0x800, -1000 },=0A=
     { }=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=


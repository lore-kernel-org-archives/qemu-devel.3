Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CB4F55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4Nr-00039r-2u; Tue, 24 Feb 2026 21:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4Np-00037j-93; Tue, 24 Feb 2026 21:12:13 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4Nl-0008Ty-KT; Tue, 24 Feb 2026 21:12:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOzhzGRCye37vIMR06+5qBGl8HyYHTjFjoPWw+bvXQdWZKeQEJyDRuATthXH308OexA7hfLYRJfLDntUSFaLuL8w1kU3UoFzQJA762jzaJ127NZSBUdN7SDdJ5As80NN7yYkTVGA9UW/NmWlI1esYxdcMt/MZMJSamGprUNshP+1GesHBgdrftW+qHMVHIiEa4CrbFrgJfVpfmEjpKyZe33q2RmP5lsxMS/T2hi8ouOwe9jTQ0hWawIics2F+F8yW/LuY9OsUdBIwsTgCoLXi0SVIFu9wRQLtfVlMMcwmLQsq2PrtTEPOVd6C8XDb+tyGgATS2Zc3fu01fK6o7tUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znLJTTXOnrV4vAr/FdrJeMBRQ5ZZDcp9pvGohSa33Y8=;
 b=K3B4FTcisYo+cxa0h1ZVoFSshAsTrtA6GjSXuyH+ubQq8hJHcYvMB5i7TLjL7ta6JxNFQ1Y8WAkcGILODaBxWSTJxGL/QpcKDtLtljtfRMbjfQVZZyIXJPp4kdgYPPYTNO1izFnb5L2VZbYih0P2ep9DDjZcVlsxCRn5B4APiRakWpAT8uwHBUXA2bypTrMOFoCXyEj+jWw2nMWIEa/sHsuK0LVNS9/TQdtRe7waVOboxFR5sKAN9fd4P3wTWYqu+dfGzMyN4dzHBhRDjkuWh8PwQ/8t9reC+3AcPiCTBTL+HddV69iuj+JJNP4NxjXDUyEK8TnO7qKtplc84CQn4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znLJTTXOnrV4vAr/FdrJeMBRQ5ZZDcp9pvGohSa33Y8=;
 b=SUGpPMZdT23snFZh9pi7hsQPZtiR1gSY81nTN+uie+yS/8IGpCg3/qDUzWrekldMH7rDVT1p1rc1xT6D8UYktH/zbl47XYaGHgu+MQfjOsKhSNz+RNsHuGU1m/QZ3orhNeKnfw90+cMzHAsTa7V4mcWTUa5vHDy9Z7sB86xWD1ddosQB1J5v+6FPZjBe6cR9z1jM7eQ8tNBcgwVexOBOJ+WyK/ARIAxmkXLssFy9HbyFuGWGRJU4w85D+v51E9a7td2ASb1rEi57f/AwbbYGtjZ6T+Z3Y99iKhmcpkFVi3d2Y5Af0fwBac60yuNcZfdX1YtNoitDWUOmp5q1XFRh6w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8468.apcprd06.prod.outlook.com (2603:1096:604:487::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:01 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:01 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>, Titus Rwantare <titusr@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v7 01/22] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Topic: [PATCH v7 01/22] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Index: AQHcpfwgdmma+nhVCEmB+QFRIzN1PA==
Date: Wed, 25 Feb 2026 02:12:01 +0000
Message-ID: <20260225021158.1586584-2-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8468:EE_
x-ms-office365-filtering-correlation-id: c39e9afb-1c48-4927-cf05-08de741342ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JoLvpM5KOIDIJrPoLYfYpY9kmYcUJ12i4AS5G+5/K64L9XNwCoc6udXlL8?=
 =?iso-8859-1?Q?VAFbzTFX1b2mbNntPfMtOaQSa49rBWgvKopx/qZkyIIGGceTQL6E7tfKKk?=
 =?iso-8859-1?Q?WNfZ/BK7XTwYaQJwGzW33REG/FpiSF6hgMUG1va8xlYwG0S+WTC6h7+s84?=
 =?iso-8859-1?Q?wTqRjbbw4nBWBTOh3p8J4P6f8d1HzyBG165Gi9caQd+6qRZj9A1TqzXmn5?=
 =?iso-8859-1?Q?eFTbDJ/sTKaQ8ba4g6EhaW8mNnCKp6ucjn5ZgN8zn51zz0UQr8W23K4ni2?=
 =?iso-8859-1?Q?Dw5H7IXQukuvHRm3bz5stxK1IXwqa6ehJlwhcJ6odjvZT2/VFk7Uw/NxKJ?=
 =?iso-8859-1?Q?YrtANheXkHE9lhrQqpbpX/bVWh+CxUPNvwvCbBtvW8UvBpCsHckFUcpQf1?=
 =?iso-8859-1?Q?cz1tqrwRgWpDXuRTZ66Odi7nQ3I2SUsCZWKZZ5ktFciKebpWvjMOOPpCzB?=
 =?iso-8859-1?Q?Xp9U38mBr+DQ3yxInwrWOEVydBdhJJMXzhWOz14W95NQZVAren4u1GqPng?=
 =?iso-8859-1?Q?/ivTJLzblmBdFi7gpjExLm3OLAP2SdLEldgO0Rf+gv4NcmWukz9ijhEDiS?=
 =?iso-8859-1?Q?vEdUmgwREyLGFzB2CbPRJXj4NbHNYL0XDeXx7BLudTzrMHm6y2M/pJlNq3?=
 =?iso-8859-1?Q?GN2b2LTK8rMBigwxjXwKn0D4nVmBIWwVTa7yCnZI7iSkO0lCyA7ZMMQQD3?=
 =?iso-8859-1?Q?EDxSUaCgDkq2YdYvNRcwRgZh8v6G4tJo/HP596YkLDqe20tA3LZMSDHQZW?=
 =?iso-8859-1?Q?ezJDOeLSMobmhxBoyXOCFuxNu9vFqA2e0aJHw6Uaw9qItGTVc99aaAYZnU?=
 =?iso-8859-1?Q?/QamrTEQlpIWwtuKhcerFtzidordohn6tSV8Q4UPs4f43M8JlVfibKfHDB?=
 =?iso-8859-1?Q?tZ39qPGHx7vL1O2R0SdgQNeNrIHiODBLWR+IT1kkTvheiPUVrERhDIKi2o?=
 =?iso-8859-1?Q?2wUaydljC5akxSEx/czgkfVMdP7wAF3qpvVCN2EbwvGhKULw5VVFw/XhgW?=
 =?iso-8859-1?Q?trMZ7cpnvCH4WoqnFhlRdYYMl3nZljmN0y6yp3aj8SPS3jvh72U0p08TSN?=
 =?iso-8859-1?Q?x/Affe8dJ0Hq7rqtrMz80yXUHC7c81sNTfoUh3wia+MKmRUem1BBdEV4cv?=
 =?iso-8859-1?Q?CdxQARDaCqfY64IErt7mHZUGogMElHYJSdRMAy57rKpDL15QnUzveY+Edm?=
 =?iso-8859-1?Q?7C4jZJwBaI3aJuWVkS6ysRCS6yizl2IhkpmHOS2YSXhUOMOUZ7x5ou4Q0n?=
 =?iso-8859-1?Q?44uzkuf+CBJgNCqgC7wwaTNHp1/mI7qh2AkY8PIGAI/kOKz444g6ZlDDiF?=
 =?iso-8859-1?Q?BWRf2XRJS8Q+ZHQdrl9VKoF2Gd8iMWZM9i8LLQfftnul/+nvuuR0j+A5X6?=
 =?iso-8859-1?Q?SF4p8NDpM5qxouZpyy37rhKdb+yP8Z/qiNay1gT8bwTLPT7A5pTSyTjo53?=
 =?iso-8859-1?Q?td0Gbi1My0Pz8qLgvj5O+9Q8LX/FyR6Do775nwO42Vs9F1Pd3wLoWyC+0Q?=
 =?iso-8859-1?Q?PZgA97CqpLbdTKTgSet44F3mkIVrswSZWjNVSaTpYEOYEPfTT5MMajckjh?=
 =?iso-8859-1?Q?4MBgUUZTfdsdMIp67ikKSjkP5UcXS42NPv6e1dUhpdtAzBeKAtJTaWwYG8?=
 =?iso-8859-1?Q?GFwX1HMIZcllgYeB+XW6CTEwLbndNYYd7AgVjhz8+BMFb4wPrEwl0Suyu/?=
 =?iso-8859-1?Q?XglOPhoGsN1SXKv8UA+8WKZgcvHUSLHed5X5WcrI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X300l/S9RvIBwlLADfKmCY0rV34AHdqGEZahybiK2nlZ+fExRp0GYngqxn?=
 =?iso-8859-1?Q?nvVWQMpKvknL3MCXslqYQ95qDJr2kKL3K4qraNGXPyibwfuIIYoqpIOU70?=
 =?iso-8859-1?Q?se+SpkrrCXBlnz1BkGow+i9JiBSgu81tzudmx0RRL5p88VkreYexRMudBd?=
 =?iso-8859-1?Q?VQm3KOKJQrEnIn5UfSHtUB9mqxRtSALIdzWAsK05WlNtEvvUgQ/yCHacvO?=
 =?iso-8859-1?Q?C8wEPABr0n3Yo/vWhSAVM/e6laem3R5lSr2D5dPw2y47aMRLiRS3rcocDS?=
 =?iso-8859-1?Q?3F4REX1aV1R1WXsWnWOdWiYXAUrEPFVrhSLjpy2Cj6dRdPMjMv8mZeY33A?=
 =?iso-8859-1?Q?g87nk46WlR/IUwILuM+xLG4iXdmQh4JTjSfnFHBtID1M3GzHn7eP1d8M47?=
 =?iso-8859-1?Q?DZE9sxGcNSZ8GL0qAO+1iZEz3Nw0WL5Ws4ZTftT3vwE8oowM5y9zPfZ/kG?=
 =?iso-8859-1?Q?q+2MK9e5O3NYDAvotCZrDTSEPZur/lD9T6Pzpvlvl/1PeA3A8pE1QMncK+?=
 =?iso-8859-1?Q?oWbZdWppDtUt/WxuE4O771nwThM+vBajMlFCYzz123AtIDZDmZb+fXotkv?=
 =?iso-8859-1?Q?Sxg8aCdUCARspSDd+iPuZYtJ+IxSd1FmJuzwFTBDEYXxN6DI8kM4SCo6N0?=
 =?iso-8859-1?Q?mUWajhvwiCOA0rQv9JQ3a3CHQOq50d62c0qRIs3KdkB6PXNNK/P6L8LELp?=
 =?iso-8859-1?Q?Kns9rlQCl5MMmRchApX4IRp6835KKldhcHLOGNtj39UuDGXAdYLWQrcE47?=
 =?iso-8859-1?Q?gKUtWuIbs7bzF0ypq2h2giRfYCdaGwNc7gxmsWxsr17lAOtxnJQZ8vadqe?=
 =?iso-8859-1?Q?tSNChmfmrzgUcZjjXu+zHPF3wP938jHXYFE5MnDzdF9okxr+jenywn9slQ?=
 =?iso-8859-1?Q?OUNtXcglxYaO069OlGAkKpaHkZiA/XwDP5MrXFaEzPwE5dvLIpT5YEK1ej?=
 =?iso-8859-1?Q?g5lq9vkbrTwxEn7IhGh/uHbQ9IERRZcBn7fDigJL8qA2+Z2pGzlbsJ5yHW?=
 =?iso-8859-1?Q?ckNH2xsjvfeJz92O7ZeWA8iFzPl3zHemBAkRXnfEkgfSetu0bxut+TVh7k?=
 =?iso-8859-1?Q?fPtYgKdgFWgOCORmwClUg4s9UbcQoq7u7h7AqV8Kdc+k7OM2WSGUCLcJ0x?=
 =?iso-8859-1?Q?eRIw1uG+Ud3MwCC+wDCpHpBhYdH9ngIsS3q9II6LvSOzZOZKeURg6xF1UZ?=
 =?iso-8859-1?Q?4usXleQ/cPsHHMrb/MRSXKBpxbrEck85AkqY9jHdF1BFP0L5l3UD7vv7PP?=
 =?iso-8859-1?Q?Vy34NvX5/fxqf7BnJAXw+rps2u0uEIi0wLG/oH/0dgho554XkS94gyseOp?=
 =?iso-8859-1?Q?/GeGxQFKwvX5VLpyJfaT1OikV0XyTF1U3JOI43fOWvnM3jZ/9pAhXf6YTz?=
 =?iso-8859-1?Q?82d0RCxBzYpRYwZYb1JFJt5y8UT7fpGZIrA9Y/6tEERRQiDOlUMmwyrVNj?=
 =?iso-8859-1?Q?/9GXOi5GRvapyVPs8GHMRdkcKzuQnVsCr3Vp/jWn+PhyaY9mZHDPuMaYpi?=
 =?iso-8859-1?Q?V5+183AK/4MqzwLOIEToywTrFiSnDt6ewTRaG+a6ZB3ACsTNBrF8vumYXd?=
 =?iso-8859-1?Q?XzDvE4T+DVKU/uUICbmHWWWJVsmM5t1AhXSZ8K0nAyIxo4JCT0DfMbECng?=
 =?iso-8859-1?Q?qJmXJ76+RBte7JKo1uqhCzGW31FMIRm69s3t6tx/C0qrcAdIQm1khrSYNQ?=
 =?iso-8859-1?Q?w949OlQCwP02fKmdO1LAdqhLR63g1F4RnzM453AyQJSrJeDFG4vZHLi2sq?=
 =?iso-8859-1?Q?tYmjIeBEm4rmGaahhcHsiy8gdBertqBtRyhT1+j6BvDTzvcJW4I7JovnPG?=
 =?iso-8859-1?Q?EAthpelkEw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39e9afb-1c48-4927-cf05-08de741342ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:01.0380 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3r8clHBE/jBj8UwoOBoAvJfAXxLkjw9gXCZakY4M19/w5AVv7lrRBHMFHTdChfI2FbHuxoCP8+zrBFReC5NJRymnnO22a0ToTpZr1hk3Mu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8468
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
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

Moves the Aspeed I3C model and traces into hw/i3c and creates I3C build=0A=
files.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 meson.build                           | 1 +=0A=
 hw/i3c/trace.h                        | 2 ++=0A=
 include/hw/arm/aspeed_soc.h           | 2 +-=0A=
 include/hw/{misc =3D> i3c}/aspeed_i3c.h | 0=0A=
 hw/{misc =3D> i3c}/aspeed_i3c.c         | 2 +-=0A=
 hw/Kconfig                            | 1 +=0A=
 hw/arm/Kconfig                        | 1 +=0A=
 hw/i3c/Kconfig                        | 2 ++=0A=
 hw/i3c/meson.build                    | 3 +++=0A=
 hw/i3c/trace-events                   | 7 +++++++=0A=
 hw/meson.build                        | 1 +=0A=
 hw/misc/meson.build                   | 1 -=0A=
 hw/misc/trace-events                  | 6 ------=0A=
 13 files changed, 20 insertions(+), 9 deletions(-)=0A=
 create mode 100644 hw/i3c/trace.h=0A=
 rename include/hw/{misc =3D> i3c}/aspeed_i3c.h (100%)=0A=
 rename hw/{misc =3D> i3c}/aspeed_i3c.c (99%)=0A=
 create mode 100644 hw/i3c/Kconfig=0A=
 create mode 100644 hw/i3c/meson.build=0A=
 create mode 100644 hw/i3c/trace-events=0A=
=0A=
diff --git a/meson.build b/meson.build=0A=
index 414c8ea7e2..41c5e2ebea 100644=0A=
--- a/meson.build=0A=
+++ b/meson.build=0A=
@@ -3610,6 +3610,7 @@ if have_system=0A=
     'hw/fsi',=0A=
     'hw/hyperv',=0A=
     'hw/i2c',=0A=
+    'hw/i3c',=0A=
     'hw/i386',=0A=
     'hw/i386/xen',=0A=
     'hw/i386/kvm',=0A=
diff --git a/hw/i3c/trace.h b/hw/i3c/trace.h=0A=
new file mode 100644=0A=
index 0000000000..1e0c4eadf0=0A=
--- /dev/null=0A=
+++ b/hw/i3c/trace.h=0A=
@@ -0,0 +1,2 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
+#include "trace/trace-hw_i3c.h"=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index b185b04186..d7b3647ca1 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -23,7 +23,7 @@=0A=
 #include "hw/timer/aspeed_timer.h"=0A=
 #include "hw/rtc/aspeed_rtc.h"=0A=
 #include "hw/i2c/aspeed_i2c.h"=0A=
-#include "hw/misc/aspeed_i3c.h"=0A=
+#include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/misc/aspeed_hace.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
diff --git a/include/hw/misc/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
similarity index 100%=0A=
rename from include/hw/misc/aspeed_i3c.h=0A=
rename to include/hw/i3c/aspeed_i3c.h=0A=
diff --git a/hw/misc/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
similarity index 99%=0A=
rename from hw/misc/aspeed_i3c.c=0A=
rename to hw/i3c/aspeed_i3c.c=0A=
index ac6db214ee..fff259ff66 100644=0A=
--- a/hw/misc/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -10,7 +10,7 @@=0A=
 #include "qemu/osdep.h"=0A=
 #include "qemu/log.h"=0A=
 #include "qemu/error-report.h"=0A=
-#include "hw/misc/aspeed_i3c.h"=0A=
+#include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/core/registerfields.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "qapi/error.h"=0A=
diff --git a/hw/Kconfig b/hw/Kconfig=0A=
index f8f92b5d03..1b17b7b446 100644=0A=
--- a/hw/Kconfig=0A=
+++ b/hw/Kconfig=0A=
@@ -13,6 +13,7 @@ source fsi/Kconfig=0A=
 source gpio/Kconfig=0A=
 source hyperv/Kconfig=0A=
 source i2c/Kconfig=0A=
+source i3c/Kconfig=0A=
 source ide/Kconfig=0A=
 source input/Kconfig=0A=
 source intc/Kconfig=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index c66c452737..8344b9769f 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -545,6 +545,7 @@ config ASPEED_SOC=0A=
     select DS1338=0A=
     select FTGMAC100=0A=
     select I2C=0A=
+    select I3C=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
new file mode 100644=0A=
index 0000000000..e07fe445c6=0A=
--- /dev/null=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -0,0 +1,2 @@=0A=
+config I3C=0A=
+    bool=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
new file mode 100644=0A=
index 0000000000..ebf20325cb=0A=
--- /dev/null=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -0,0 +1,3 @@=0A=
+i3c_ss =3D ss.source_set()=0A=
+i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
+system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
new file mode 100644=0A=
index 0000000000..3ead84eb45=0A=
--- /dev/null=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -0,0 +1,7 @@=0A=
+# See docs/devel/tracing.rst for syntax documentation.=0A=
+=0A=
+# aspeed_i3c.c=0A=
+aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
+aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
+aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
diff --git a/hw/meson.build b/hw/meson.build=0A=
index 66e46b8090..91552a646d 100644=0A=
--- a/hw/meson.build=0A=
+++ b/hw/meson.build=0A=
@@ -35,6 +35,7 @@ subdir('dma')=0A=
 subdir('gpio')=0A=
 subdir('hyperv')=0A=
 subdir('i2c')=0A=
+subdir('i3c')=0A=
 subdir('ide')=0A=
 subdir('input')=0A=
 subdir('intc')=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index d304a98498..96b6705b7d 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -135,7 +135,6 @@ system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: fil=
es('pvpanic-mmio.c'))=0A=
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))=0A=
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
   'aspeed_hace.c',=0A=
-  'aspeed_i3c.c',=0A=
   'aspeed_lpc.c',=0A=
   'aspeed_ltpi.c',=0A=
   'aspeed_pwm.c',=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index d6af2fcf85..b88accc437 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -293,12 +293,6 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsig=
ned size) "SSE-200 MHU wri=0A=
 # aspeed_xdma.c=0A=
 aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%"=
 PRIx64 " data 0x%" PRIx64=0A=
 =0A=
-# aspeed_i3c.c=0A=
-aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
-aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-=0A=
 # aspeed_pwm.c=0A=
 aspeed_pwm_read(uint64_t offset, uint64_t data) "read: offset 0x%" PRIx64 =
" data 0x%" PRIx64=0A=
 aspeed_pwm_write(uint64_t offset, uint64_t data) "write: offset 0x%" PRIx6=
4 " data 0x%" PRIx64=0A=
-- =0A=
2.43.0=0A=


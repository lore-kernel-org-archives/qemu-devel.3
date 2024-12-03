Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8131AE6C5E5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 02:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIIIB-0003xH-Pg; Mon, 02 Dec 2024 21:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tIII7-0003wd-Va; Mon, 02 Dec 2024 21:05:32 -0500
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tIII6-0001m6-50; Mon, 02 Dec 2024 21:05:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ8x9rRl4uvn+3Vkn6uSX+RFqIGyEV+Zw8537b7zvpMyJCZ29yIH1+6bZbAYI0UScvrSN97+A2eu3ffaH/gLc6BGYbDald2Xd5MSdWuNGCeWLPrCUoOlIHRtuB41ZTknG6Fi8KSPhpwk9eHcfTltcmqwvtda8bjFOG2nsGKqzTEGDvJdPw15LnO3YZAnJZCRk6aiNK3SNuerxJisW8QHAggo4MIKNwt/IyWnqns68wccRLvNv6eOP7Tw2ho/MRaVKUvizH74LSMaabCXl1FVQNIxoNM2qjGmyZfnszKdNgzxUa/TGBqEqtpLb8Dkc24Pf40VUHbJs92EBPSPLnCK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu8o3OaCUKHo0o2czKIwgqLbAXIY4RBbtea1OMKVpfM=;
 b=uvuxixfK++fezo8LU/AocQfdewkHd9vCk059eKF9UiXr44KfzQY8n6R9OYpwaxZort6cEhOzuHHV1Pdf67IpVlQJkTvR7yf3jHS2Gp0/jyffitLFKfh8LU4QNSfwOwtFocTZr1O4xRhPbSeA6eWPcI8mqUUZkIBbZh2fRYfvwA/fPyjtzVsw1VvSbiVMGxbNSAhF98Ps7XjqfKKac71dQ6qEjqdpc2q/D+gGhXqNsSb4HeiOhtVj1/zVgmi4QqKnbi8aFK6ARnsw/UbAoUcP3wfdPf+ECg8xMYoDVykQEb8ubOi/56QEHyz87xONQbjocQPjK30tfW/kW1qanZafJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu8o3OaCUKHo0o2czKIwgqLbAXIY4RBbtea1OMKVpfM=;
 b=S/XA3TWCvUUH6kZ8o8Xdj13nmtJPJKsfzYJqOAHxe55K52xWZ0vxa6BP2+2CFMdMzPqP7capamESwhflWgIhrvOmbARPxYkANcFTxfA4ZWld+VECW3mDpK+yKGJZQ4F0/+5nbD69obSnXum341VjY+HPwEv2udTgzTWPT4rLUuRkzad3YB35ZhzvTNpHkk4uotPdevRnbljredyYxcwxFCIvRaSUzsSagOqXZrqu3zH9LpDnMh/CTXj4LKcQu3Cd36C6ZREtH+jQEGPV2vl6yRuUvHkXnEQvBmcrfhEOLuE224UA7+1IDIexBwiGjrWHhz6S/p92ccx4KGcYcXtmYQ==
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com (2603:1096:101:51::5)
 by TY0PR06MB5008.apcprd06.prod.outlook.com (2603:1096:400:1bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.8; Tue, 3 Dec
 2024 02:05:18 +0000
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196]) by SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196%4]) with mapi id 15.20.8230.008; Tue, 3 Dec 2024
 02:05:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 0/5] Support SDHCI and eMMC for ast2700
Thread-Topic: [PATCH v1 0/5] Support SDHCI and eMMC for ast2700
Thread-Index: AQHbRSYF0Uuc0Bs1m0mTxMc9GCJKu7LTxNPQ
Date: Tue, 3 Dec 2024 02:05:17 +0000
Message-ID: <SEYPR06MB5037AEAF6AB59E2A6E3452A4FC362@SEYPR06MB5037.apcprd06.prod.outlook.com>
References: <20241203015224.3985820-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20241203015224.3985820-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5037:EE_|TY0PR06MB5008:EE_
x-ms-office365-filtering-correlation-id: ae1b0317-6826-430d-2437-08dd133eef55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AlHKLM7+tglTfZylX1dgcQ7pfLDbf+Ew4oosqKdqbazbCv8WPKYSrRfOLv?=
 =?iso-8859-1?Q?KbOOQr8Am5xKgWxlE16iaQZvateOtW5O0KrMPweSt5/U2NPKc06K89oyuM?=
 =?iso-8859-1?Q?pu3aWrFBg8+dtJRyETBItGIZlqkLdLhctp/rOe4oF+rSTD6TW+mrSxv3Zb?=
 =?iso-8859-1?Q?DavTzqFIqlEUqm/g+lRsIhHu53LzaHqmb9RfEVU3Z49ZZg7ykg/8I6xyT5?=
 =?iso-8859-1?Q?EouiieRdOcyU9X2+YMhANcIKVCzKKVvqbo7ZPdqvxCfnUm+A3dqy6cLAaP?=
 =?iso-8859-1?Q?JVe8+OO+bSHwuAXepmkzYjAMUckpgJmIYgKENUzpZ8DewwqQ4USxZj7m3E?=
 =?iso-8859-1?Q?h2lSuf2jQeFBAzMY/mi3DWfBq/ZfTbqbpCaUcsa0LnCku3yzIpLCuvoOXQ?=
 =?iso-8859-1?Q?4wEJK53VGCoXvezj8wxp2OOmSqBPYkWX5ZlasTfZMGK/AIJOrUq5DcrE04?=
 =?iso-8859-1?Q?Bs5YDhJL7yPuIZ8/pYtkyhSEB7kuAuvwwaohaVQTRQXQjNq3FXW1bUQbf9?=
 =?iso-8859-1?Q?XtSo05mEmZg5bd38OVbjHdO9/0An7eqQ8vMSemMTv3uSmXK7507cSmN2M+?=
 =?iso-8859-1?Q?ojrH8wBgM/Ew+n8I7co13f0TvvwKHg/AFVCefpyqxILfx+iLCEtgElNqek?=
 =?iso-8859-1?Q?qTZUvtLsR8435nFN1q4Oahv26hWKNuzZZSpoSARN8sCYLgqfcgDfXNRwVt?=
 =?iso-8859-1?Q?Kan48IovfZ0IPKRYmzehXVzzU+ToQfcD4Lnx50zg226jizFGJcNTALYhnD?=
 =?iso-8859-1?Q?KOCxymdPAc4pzBpZ9MsBrvk6JMa0Du0OTRdyavrNeuKDzPu44QShtCFCNo?=
 =?iso-8859-1?Q?jAXbf5Lv5F1uEYV3RKsbfDQUr0N+ireYqXAFctKYtPNm0KGaLXw9gdsLUT?=
 =?iso-8859-1?Q?I24AVPFROFOnVhklATbsSZzvHa331xda5BbU79tH/uEy2pyFNyyQXbZQAX?=
 =?iso-8859-1?Q?e/eFMiO8YWuWQSxJy2RKXurPffj6sIwHn5kZJjuK6XAoY96wPMx9jf3WSz?=
 =?iso-8859-1?Q?E80cpvNcd7bvjhlQdqjryvOBnVkHwuaRwGc8aQwrnRCCnBmCTCEGVDiQBe?=
 =?iso-8859-1?Q?/zvq1muSDDL6rT0PeUFbShwiBH15uxXitZCYb+UJHrxLLQrQcouZCVRdS+?=
 =?iso-8859-1?Q?qH7l0w1mQdzYocxCBcoyYRmx9i8/Yq51y53ewgd7uakeLbaiZ2MPJhwz+J?=
 =?iso-8859-1?Q?lRNujTdNncUIml+FJYXA/kqTupS1EQi82NHlyr/+owUEZBu2CQymrjbAd7?=
 =?iso-8859-1?Q?dr2XD0eqNpnMkmZJxGTQeVN7KIGbgc/SJ4MXxfNBK/Dz7qDonn6DEgeajm?=
 =?iso-8859-1?Q?FDQZN+qLYKOaWuHMEOYPb3tXFLo+4A3VGJqeyXfU4Y+7YcKbMk9tdqbD1q?=
 =?iso-8859-1?Q?iE49xRgChJy/Ysk8C3TkDLvRL8JEmGNxMVILI32dRoKt0vHar2nUNMAPDV?=
 =?iso-8859-1?Q?Rk8+J/Si6ZpEEsfZVdC6udqJxRhfgn9xrqUuSw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB5037.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ir6D7Dxbm33mnZ/OWJdNK9YGl+KfH9Hmx9Y4VBv3N+soYXW7TqoX6UPT+l?=
 =?iso-8859-1?Q?tHzoULKrIwMZmA/yoUmEKbzumspL5iiLBetjmRq8wSzO+wRsdtP8+GY/hs?=
 =?iso-8859-1?Q?5yXsJYzxQ+pOzq6P1chCZkwU2hfL4S9UCfkGuLdmJhFDZHg2XCVI6YzpkC?=
 =?iso-8859-1?Q?65KMCZSWIj8ULhY5AsubaSnueUwuIidTdmlMP76lVDgMctBTpgquCvIGrE?=
 =?iso-8859-1?Q?9WVNRCkertTlOumw/ikvPEqvnhftOAUBdCcjtLm3V0VnNbTPeUmecjhShc?=
 =?iso-8859-1?Q?etj+eY1kVAqEZyi7bEQevcHAYywR7EDtY29miwq7YEPDJCuQ9ugLDJVVCA?=
 =?iso-8859-1?Q?wotn5trcJnYkQtZ1URlMQgroe0q9TX1o+YTrVeSJPU22ULUIt/+WkH2vCx?=
 =?iso-8859-1?Q?Y21U3pcIJ8IUKzQTqvN3kWPTVndU53PO2WdWMCDLfBB2//20c+sTfCEmaP?=
 =?iso-8859-1?Q?jh2qwq9/EVlnCKXb6/EUUEn5LhgybshaBY39/0C+o+lqzrruvdoyNVaJQz?=
 =?iso-8859-1?Q?UJsRH3kSiMJ84n5u2QuRzeKf08m4Q1R0s52cHzT/66/sSpGrJT4AEUIWPs?=
 =?iso-8859-1?Q?puyuLw6tu5zNIqMr1KVFJmae5ysDby4fc5deRZgCjr/N2yPIRstKHTPdVB?=
 =?iso-8859-1?Q?R0vTw+ydoqXIU7jVBwcWk7GDy9S9EgWuLmpsxyVVqhG1bwbqnHqNl+0HU/?=
 =?iso-8859-1?Q?a8SQ4B2dUhM6d7l4tSuBSlO5iKIuRo5Frel4lL2Go3A0DuiorN16ZG9TWh?=
 =?iso-8859-1?Q?FvVGBhlr16ykQcWkNk1N2ptiUw0Si/qSjjMplbKF2HtsWig6TX5oG8PrY5?=
 =?iso-8859-1?Q?/gl9+fYfBCvKuPHiPXhWVovrKMPZHP3m/OZjO7YoHGHQcuUwOB6mgVi8Uq?=
 =?iso-8859-1?Q?1Qo5qEbDNzKrEer2R267YVfcnzfGhbPzeLPCk7gWMhxXR6y9O2qIi7n8f1?=
 =?iso-8859-1?Q?NI/4rWVRoSYOxqApujIuiqfwl09UnLTX19ktIQE4EJUp22IMeIm59X7yu7?=
 =?iso-8859-1?Q?FX9oKFtXTVlqj1Gmb820JtfvFAUIFTu1NYCrlOssXKH8E7ki8N2nj8M+GT?=
 =?iso-8859-1?Q?EmgwaABma1uV1V8eSffggGRCQRaAiLbD3gdHKbvqXSMQjLoPgd6vzcFL0p?=
 =?iso-8859-1?Q?ooXV0qf2GYdysRjnvs4f43KiY5cgB1P2Lwq7e8hxNH/HgbPwvMxc4KZt70?=
 =?iso-8859-1?Q?TFGrqVNVvIzN0fyyhCZePP7vGrmdXLhCfh18oQfrYGwUhBXHgNtxjtN8OF?=
 =?iso-8859-1?Q?YT/i6JwnO1PKaZbJlOsqe8cQV2o0tcy5FuvqcqYWqYpILpMtDDu+tE0OWp?=
 =?iso-8859-1?Q?hV6n4oPLCvlytlck2V+kQ3O8bGg9HqjlyWxk+vEg8C3ieRcoWFE78cgzjM?=
 =?iso-8859-1?Q?o62Ih4+933UWe34Sq8/YbfzGtyZXZTX2xQMfpRE3g21GoZbuG0fUPBAFl5?=
 =?iso-8859-1?Q?M7OVax5aGuV6Rn5rujp/Hb6E4ZHlMtuO2sd/+up8fsw/9XcHIJsv1WoqpK?=
 =?iso-8859-1?Q?Juy9LGT5idYnN0oP6d8lo7tA/dbCZ8E5OykYwCxLp+2Jb2YkWbXi8GkacV?=
 =?iso-8859-1?Q?8jNyItcHdUNyNNbemzQFgw0fIqH/bzd83uFL4V0mXfkz3X6uFj3Q8kiKGP?=
 =?iso-8859-1?Q?3kGaJBoKxuIV1Nda++WmsiEf2JxtyyfA0D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5037.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1b0317-6826-430d-2437-08dd133eef55
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 02:05:18.0206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mv53l85urHJylE61eOe/U4NzUgWK0KKWAJPh1MV2HJ/N9UxTo1rKpf6D5sEFrOcpOq8RDAWReR4Joa+t7FhvjJTqAFcx0VOUpQpFz8tk0rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5008
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all
> Subject: [PATCH v1 0/5] Support SDHCI and eMMC for ast2700
>=20
> change from v1:
> This patch series do not support boot from an eMMC.
> Only support eMMC and SD Slot 0 as storages.
>=20
> Jamin Lin (5):
>   hw/arm/aspeed: Fix coding style
>   hw:sdhci: Introduce a new "capareg" class member to set the different
>     Capability Registers.
>   hw/sd/aspeed_sdhci: Add AST2700 Support
>   aspeed/soc: Support SDHCI for AST2700
>   aspeed/soc: Support eMMC for AST2700
>=20
>  hw/arm/aspeed_ast2400.c      |  3 +-
>  hw/arm/aspeed_ast2600.c      | 10 ++--
>  hw/arm/aspeed_ast27x0.c      | 35 ++++++++++++++
>  hw/sd/aspeed_sdhci.c         | 88
> ++++++++++++++++++++++++++++++++----
>  include/hw/sd/aspeed_sdhci.h | 13 +++++-
>  5 files changed, 132 insertions(+), 17 deletions(-)
>=20
Sorry, I lost to send one patch and will re-send v2 patch
Please ignore this patch series.
Thanks-Jamin

> --
> 2.34.1



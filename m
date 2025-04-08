Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6384C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 06:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u22YZ-0006wn-QU; Tue, 08 Apr 2025 02:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1u22YK-0006v1-RE; Tue, 08 Apr 2025 02:35:21 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1u22YG-0004gf-EA; Tue, 08 Apr 2025 02:35:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlpixeDuHK5oK73Kg9oVOmLgjNSKTVaAc+tJBds/p+GJ/sW9e0pK6ma57a3m1G2QVFXxEwC93ZZcA7aWTXf+jMecQnAfELbM5jK/+hobfyfrVJGG4jlKHWnYH8W6Mpnlt26tqQy8GNlP7OIYcoWpvYxVjp5vVYf5DjDwdHIz/PWCvcRzWdbn+Eu0pywcS2J6bNj+6njxGfQ0lZ+o1EIs/P1rtbzdQBhbsb4B3sZV3MVGO9VhBt3BzrZU9b5RykeIK07+h6a2F6LiQ/oGZ6i9VXBY40IFmTua/zepRw/r49a5HdmDcVVciu6/y8Z/ZsjicaKl1tn36sE49EZYXcL7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jm8z+y+hlewB7pQgJLoX5y3pVxTGTE9vtB87+u3shs8=;
 b=Vbz3zzV7STDjfulaIJEp2/ElBVyVuezjiP+M6TQRQpIvghU1SnOEb17lO4DhSWqwVzHd1LZTyDIDnOZlF0hAQbe0CjtyJiI0fw/7fmBDDdmXorY02OT1an3jLmqQB13MdYc5JeY0at6318oiGTySfXGHEGYM+vcB+QKO38tmz3ynXoBJ/xsZ54T9gD++WDj/2lzTNyg0+nYd/Op8axmTUO8COBwZNqdB3g/qnzOfFtdwLpyqfYUwGSnDUnzYj9+WAs036WX7HxZeKyd72vS4CSGsfs6FU7Fnv6WPUpPEempFkyhFHIJLHX71iGtGSA9rrjSeHXy1NMAgXIUuIcGjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm8z+y+hlewB7pQgJLoX5y3pVxTGTE9vtB87+u3shs8=;
 b=PYY7Z2uQtNsnQtwHRUwkKJ9mLeP1kDaLHr1ALT51FCqVrdpZEgt7jsUNEUBld7UQRXvOViXph4Hu/V2ILgasxOKvJmNDCfYjS57deZTWd03bWH+sa+lBrxwObgU3ffqWdDa41BRWFvr9xKLIJs/RuYKQ0CrGbQnTL5H/N2GuzEYAYq+S92N4Byx0ZNxJFLyvCoUNf7ZgII8xN5cWAs35MeuJ9IoES4v2wd7Qdh2rf9dQTVjtf1NDljZWf5PTVf6NUgAScpy6Git1YIi94D07i15rQimT8vp8mw62EQMOIc22Ese37qDK1vnSNPx4VzIfj58OChdlie/iAbOr285EEA==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by PUZPR06MB5887.apcprd06.prod.outlook.com
 (2603:1096:301:117::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Tue, 8 Apr
 2025 06:35:05 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%3]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 06:35:05 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 00/13] Introduce AST27x0 multi-SoC machine
Thread-Topic: [PATCH v2 00/13] Introduce AST27x0 multi-SoC machine
Thread-Index: AQHbnawV1QUrJuodHEOa0FF12E1LW7OZZIAg
Date: Tue, 8 Apr 2025 06:35:05 +0000
Message-ID: <KL1PR0601MB4180B751F27DD46E378825E885B52@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250313054020.2583556-1-steven_lee@aspeedtech.com>
 <5e3c1b62-2a1c-4e99-8842-d5a06a80d2f1@kaod.org>
In-Reply-To: <5e3c1b62-2a1c-4e99-8842-d5a06a80d2f1@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|PUZPR06MB5887:EE_
x-ms-office365-filtering-correlation-id: 0304bb88-5dfe-4b4d-d219-08dd76677fc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MTVFbUVXVmNZMmRCOHlpaWs3Zzh3SzFLZ3dYdGFIODlicTVDVzRSNlZIVnJ1?=
 =?utf-8?B?dnRWOVgwUHNhUUpxR0RlM1pzeHptcVEwazJnSUdQS2N0RXVvVFZsVXhQTGFs?=
 =?utf-8?B?Vk9qLzFEOXJRa0xWTk1HaW1Vc2pBamwzYXZ3cVlhOGVlbG1WMERnSGlwRXZn?=
 =?utf-8?B?bGdoZTlzMmJmaFhaempPRXkxb25BNnZrcXhGTytZVE5XNllRa01FUG55dDJh?=
 =?utf-8?B?UXl0a2tZclRVZ3FLbklpRHQ2M3ZtL3g0ei90aHA3YUVCYjVObzhFc1YvTXMx?=
 =?utf-8?B?cXVJZ0ZpaFgxSW5EcFJTWVhwQk4reVg2SXA0WExUS2VLM3FuY0VTa2xFNkN2?=
 =?utf-8?B?Z0hUNDJUSEs3U2pjR0JHYXdXUE9qWFgwa3RZMVZBV0J3Vk0vUXFDM1FyZ3Fm?=
 =?utf-8?B?VjFLS1ZzYUU3UW1GRE1MdDVvSDdkYytUMGJ6clM2L3g5dnZSbUYzeEgxMU96?=
 =?utf-8?B?ck1SRVZMcy9wZ2dMNzd2b2RnT0tCcjVxOGJFbHh2UHh6WnRJR1ZsU3hsc3hW?=
 =?utf-8?B?VUtpNnphYkljWDM3NjRuRmIwdzdBa1BJR2VheSszT2x5NnZ1VFFXRUJoa285?=
 =?utf-8?B?VXgxc3NyUFhQWElxL3dPUDIwbW5Ob0NRaTl5N0lIaVV4NnVaVWovWDJuWDZ1?=
 =?utf-8?B?UUQzajh5Q0ROcVlSRlNoMy9VVUF2eTE4SkszL0NKenp3d2thK3hQK0xweUlL?=
 =?utf-8?B?K1Avckc4dXkzZUhLeExOSmhTQXlva3hzakJNNEhwS2ZzZE1MRUUwSkRWVnBF?=
 =?utf-8?B?YUpFWFNWYWp3dmIxVnR6RTRPZE4vSHQ5SS9FbURGd1BLZDZGU3JIeGRjbitW?=
 =?utf-8?B?alRvU1pTV1FXSDhScUNnM3lVa1dTMEl1UVpZSnRqSFMybnp3MDduMlFwdi9q?=
 =?utf-8?B?WUZldmIwbmk1dUNnaEZiMFVNTk5jdE5oUGV0aEtXM29VUWRuV0VPdE1TeXFE?=
 =?utf-8?B?M2tYSVFvWThkMGozckl2UUVSb01ZTTU3WUhNK1pDRDdSbDFMeUI2b0xybEJT?=
 =?utf-8?B?dUhRUkZWd3BpR0UzbisxcHgwVWUvRldwYkZ6Y1l6ZW1WaXNFRGxxTHN2bWgy?=
 =?utf-8?B?RTFQZlY1TVRGUUNyS2xOVTlibk1jMXcvV0lrbVpZeWY4MEVlQXY5aHh2NE81?=
 =?utf-8?B?UFkxbDVGcmppZTJWUitYRXZCa2RFbTY0TU5nTEpGVmZ0bm1NQzJiTnN0eGNw?=
 =?utf-8?B?SS9WOFY4enRIU2RSYzFQVHowck5wK0tseTZLeFFNU0Z2Nk1RTUN1Z1cvQlNR?=
 =?utf-8?B?eWl0R0pHRUo3MXB4cG9aMVNObUYzbHprYjNQUGsvS1pEbCtHQjdCWTdIWUZ2?=
 =?utf-8?B?NkJZS1lzTURJUlBsL3hjZzl4RjlmT1hDOE5sS3JBbDZqZ2dVR1VFRlY1ak8r?=
 =?utf-8?B?TWl3SjFpcGV1dk9YOWhwWm03TEZZbTRFOHhncmNHelNVenR0TlBqd3RFc2Y0?=
 =?utf-8?B?WVdPYUZiT1NVSnVuY0poakhRWFl3RVQrS3hrSUlzcXZhZDR6bnNoZXlTbU9Y?=
 =?utf-8?B?ZG1haTNiUlFRV0NnRUl4YkxKWkhKNEFKSkpkdExhSUxWY1lrck5tS1gyMFZq?=
 =?utf-8?B?UVpmRk1HUHp1RjFkOVhtRkhNdkxnUXBWOExLMU1Vbm02VFRZNXJXcldGMEw1?=
 =?utf-8?B?M0JFSHBZalN1ZmRYNERYV2xMclRHWENrckxBbGhHYXd0cTZaU09saWxUSm5J?=
 =?utf-8?B?K05mekhjVmJXZklnOTJ3NGgzZnk4TXRxYlN6U29tOW0zZUowNGJyOXc0L05G?=
 =?utf-8?B?Sm9adWFxY0tQRTdWcGJBbXQ3K0U4UHJibkwvaXRFc0pCcUsvZE01L0pyU3pK?=
 =?utf-8?B?MUFUS0MrMC9Tb3diY1UwRlIwQzJocTlkT1MyaHRCTUwvenUzNDlmL0luNTUr?=
 =?utf-8?B?TTU3aFdmUHJtL0lIeDJiVUJvS2UyZmNFZXRrMTZWd3phMThYeE53eTB4bVM1?=
 =?utf-8?Q?8cqAtMyB1c4iTtaIiPcdyCNeSnrvgn9r?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUVBalNYRzIxMHROMU16RWh3VG9hRXFwbkZ3TnBxMXF5VHJ6TmRWRlUyeVZI?=
 =?utf-8?B?ZVREMFR0bzRHNjd2aXdxUTcrVEZHcFRHNXdNK2NLSUNZMk1hbkJYYnJQS2tF?=
 =?utf-8?B?SjEzbHE2N1MyVUVHWER0bzI0K0I1elUzaXRQeFJqcUxBd1l5ajV3NVlQN2Vz?=
 =?utf-8?B?UEpaa0FxU3p4eDRCQW53am9ROXVXNUZ2bVo4dE5MR2hzc1h4eWZQNDVmVkRk?=
 =?utf-8?B?TFJlMy8vSzREK0NyZGxndm03QlFURHoveC9QY09MVUl1N1FpV0JRbXNWNTV0?=
 =?utf-8?B?NitRS2tCek5SSWU2czhLM3hRNnVCdFZLdk9TRVFMd1lSd3RWYlQwWmo3eE9J?=
 =?utf-8?B?Qk82cCtNZDZTdHVpYlA5djREZXN0cjEyWTJxWmV6MWZ0eVFBYy9wYW9USGxW?=
 =?utf-8?B?ZWRJbU10ckYyYk1wSkowL3ZtUmpWOXQ0dCtiVk9pSTEwVnp0Mm94aDhSbXN3?=
 =?utf-8?B?cm9hMjRmSHZOeEtnSmJ4a29HNnJ1VFd6UkFhK0o1SlJhTkZ1d3FiTVY0TGIz?=
 =?utf-8?B?Z000S3dZSHZyR2Z4M0hGSVZyb29LRUhQUjR4U2FBUWdiSW1hK1ZtcVRjTXBx?=
 =?utf-8?B?dk9ZVGV0M2x6OGxhTHZnTmpXcTJqVjQwQUowZEZDMVdLZldsd1RnZ0RVUW0x?=
 =?utf-8?B?OWdhOXkwdVdnRkY1MW4zMy9MNUlsRWFlUkhGM0xpRit4VjdKOXNhaXM2M09Y?=
 =?utf-8?B?eTNTNUFtbllnZnR5bWFyOTFYSGpZS2Nvekk2R2hDWFhOaS9BZTdMekx5V3dl?=
 =?utf-8?B?TlRwdWFXcHAzamdLRmMrbjR6MklhazBYQkRKYjdpOVY5TURSQzlsWnB5ZDk5?=
 =?utf-8?B?Y2RESi8xK1FUeGdYMENoQnVHNEcxbEpJbWFyQUJwblRJbm1YU1Y2TVJRWEk3?=
 =?utf-8?B?K0hmUHovUTRSekVaMzJKdmZKYVZVOFBmQXIrL21GNy94RWs0WFAxZFduQmh5?=
 =?utf-8?B?MlhRRng2VXMxcElqUFh0WWZsUTR6WHcvZlVTRk5CUVlIUGFPUUFyakhhYjV3?=
 =?utf-8?B?djgyeG5KT2lQWWdvcHE5bGVDOFhwZjYxa3F0T2ZISU1IUDRXNHBjWitSUlcy?=
 =?utf-8?B?SGo0VEp5UzdTOUVSWnFYbmsxREcyR1JnK3htdlVEOEUzTDhDMWJWSVlkMnV4?=
 =?utf-8?B?U3h1aUEwMGJqZm5YUXhCZ2RJNU1WclBtS2pqOHJwRlBEZUVFT09DT01zYVlR?=
 =?utf-8?B?MVlPRTZSdEczK0tPanJraUl6eUlFN0hTNURkM3JobXhCM3d1UndLRjJ5V1c3?=
 =?utf-8?B?UHVjRzQyY1JabjBjTkhPTDMwaUpVS3JqNTBRdkZoWEZpbUdaaThHSUxUKzY0?=
 =?utf-8?B?NnFZaWhibjhXaklld281azNOVkRaM3RvU29QZ2MvR3BYazR5YWVjVXIwcWZ5?=
 =?utf-8?B?WlgxTC91WGNLS05zQTF5R1J2RkI4UHJ0WkxEektOOWFjM1R4c3ozOE1XbWJz?=
 =?utf-8?B?V0pUeitraHREUVNGMlhWWUZmQ3g3ZWVZbXpBSzhYQ3doZENLVUppeW12N05q?=
 =?utf-8?B?dmxVTzhKRjl3UWJWYTluY0lESGxnZDI1MUZEYTVWNWhvTXowdFhGTkg2UWps?=
 =?utf-8?B?NzF0V1FTb2FDaTVqQlAreDRjaDY3RlNteWsvb1VMMXNaYmM0S3J4eW8yazky?=
 =?utf-8?B?ZW9wOHhrTDNJYTRMdFZJNFlnYXROZ3lESzM0TXVsUEcrQW9WWW5WMWtNRzNJ?=
 =?utf-8?B?TWRZWkhDR0N0SGhoRmpJVHlhZHRhdmRrNzBOU1Z4b2c4VTF6RW0yWXZ0YU1u?=
 =?utf-8?B?Q3NVZGthNGpBVU5FNlVnZkRxR1RPY3BBWGNRMFFSbm1ZZ3gxaWxQQTZKWHVy?=
 =?utf-8?B?Q2MvUFNNQWZCZHJDN3pRMW1WSGtzTGtEVnczUUVYYzVrTnNwR2FaN280Tld4?=
 =?utf-8?B?OG5ZbVlEVEM0S2RyRXpoNUhCSDZYU2NROElKSDZDOWtZNnRuc05YeDI1V00z?=
 =?utf-8?B?cXp0UkVjV2J6NE5RbENoNk5YUHkwdmJWRGNpVjNvSDc4aWVhN2lrZEJVUjd0?=
 =?utf-8?B?eUtZaTZ4Rkg0Ulp4aElYRXo4V0p1b3RQMjJQZDg3bmZPUm1aRXhmKzQwNUxw?=
 =?utf-8?B?b0MvTUY1QjhNWGJkQlNBaDhibUdYTDgxWUZERHk5NjhyUDBETGFubkdLa3Bj?=
 =?utf-8?Q?/xD9djw3ypKM6SfNCKM5tDHRQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0304bb88-5dfe-4b4d-d219-08dd76677fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 06:35:05.3746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVIT5nI6rIzHGq1M6fHdjApwLXp/Pt8yunQ0e8bMolpQ6d/fmO9tlXY2KWakHs7xqj6209NJeg4bGZOVZTrxOAFzRl7BvFV6OlS9ZAw4HVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5887
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=steven_lee@aspeedtech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDI2LCAyMDI1IDE6MzQgQU0N
Cj4gVG86IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlk
ZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBUcm95IExlZSA8bGVldHJveUBnbWFp
bC5jb20+OyBKYW1pbiBMaW4NCj4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldyBK
ZWZmZXJ5DQo+IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpv
ZWxAam1zLmlkLmF1Pjsgb3Blbg0KPiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUu
b3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47IFl1bmxpbiBU
YW5nDQo+IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAwMC8xM10gSW50cm9kdWNlIEFTVDI3eDAgbXVsdGktU29DIG1hY2hpbmUNCj4gDQo+IEhl
bGxvIFN0ZXZlbiwNCj4gDQo+IE9uIDMvMTMvMjUgMDY6NDAsIFN0ZXZlbiBMZWUgd3JvdGU6DQo+
ID4gVGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyBmdWxsIGNvcmUgc3VwcG9ydCBmb3IgdGhl
IEFTVDI3eDAgU29DLCBhbG9uZyB3aXRoDQo+IG5lY2Vzc2FyeSB1cGRhdGVzIHRvIHRoZSBBU1BF
RUQgQVNUMjd4MCBTT0MuDQo+ID4gVGhlIEFTVDI3eDAgU29DIGlzIGEgbmV3IGZhbWlseSBvZiBB
U1BFRUQgU29DcyBmZWF0dXJpbmcgNCBDb3J0ZXgtQTM1DQo+IGNvcmVzIGFuZCAyIENvcnRleC1N
NCBjb3Jlcy4NCj4gPg0KPiA+IHYxOg0KPiA+ICAgIC0gTWFwIHVuaW1wbGVtZW50ZWQgZGV2aWNl
cyBpbiBTb0MgbWVtb3J5DQo+ID4gICAgLSBJbnRydWR1Y2UgQVNUMjcwMCBDTTQgU29DDQo+ID4g
ICAgLSBJbnRyb2R1Y2UgQVNUMjd4MEZDIE1hY2hpbmUNCj4gPg0KPiA+IHYyOg0KPiA+ICAgIC0g
UmVtb3ZlIHVudXNlZCBmdW5jdGlvbnMNCj4gPiAgICAtIENvcnJlY3QgaGV4IG5vdGF0aW9uIGZv
ciBkZXZpY2UgYWRkcmVzc2VzIGluIEFTVDI3eDAgU29DDQo+ID4gICAgLSBBZGQgQVNUMjcwMCBT
U1AgSU5UQyBhbmQgQVNUMjcwMCBUU1AgSU5UQw0KPiA+ICAgIC0gU3BsaXQgQVNUMjd4MCBDTTQg
U29DIHRvIEFTVDI3eDAgU1NQIFNvQyBhbmQgQVNUMjd4MCBUU1AgU29DDQo+ID4gICAgLSBBZGQg
QVNUMjd4MCBBMCBTU1AgU29DIGFuZCBBU1QyN3gwIEExIFNTUCBTb0MNCj4gPiAgICAtIEFkZCBB
U1QyN3gwIEEwIFRTUCBTb0MgYW5kIEFTVDI3eDAgQTEgVFNQIFNvQw0KPiA+ICAgIC0gQWRkIGZ1
bmN0aW9uYWwgdGVzdHMgZm9yIEFTVDI3MDBGQyBBMCBhbmQgQVNUMjcwMEZDIEExDQo+ID4gICAg
LSBBZGQgRG9jdW1lbnRhdGlvbiBmb3IgQVNUMjcwMEZDDQo+IA0KPiBQbGVhc2UgdHJ5IHRvIGxh
YmVsIGFsbCBwYXRjaGVzIGFzIHYyLiBTZWUgJ2dpdCBmb3JtYXQtcGF0Y2ggLXYgLi4uJw0KPiAN
Cg0KSGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciB0aGUgcmVtaW5kZXIuIEkgd2lsbCBsYWJlbCB0
aGUgcGF0Y2hlcyBhcyB2MyBpbiB0aGUgbmV4dCBzdWJtaXNzaW9uLg0KDQpSZWdhcmRzLA0KU3Rl
dmVuDQoNCj4gPiBTdGV2ZW4gTGVlICgxMyk6DQo+ID4gICAgYXNwZWVkOiBhc3QyN3gwOiBNYXAg
dW5pbXBsZW1lbnRlZCBkZXZpY2VzIGluIFNvQyBtZW1vcnkNCj4gPiAgICBhc3BlZWQ6IGFzdDI3
eDA6IENvcnJlY3QgaGV4IG5vdGF0aW9uIGZvciBkZXZpY2UgYWRkcmVzc2VzDQo+ID4gICAgaHcv
aW50Yy9hc3BlZWQ6IEFkZCBzdXBwb3J0IGZvciBBU1QyNzAwIFNTUCBJTlRDDQo+ID4gICAgaHcv
aW50Yy9hc3BlZWQ6IEFkZCBzdXBwb3J0IGZvciBBU1QyNzAwIFRTUCBJTlRDDQo+ID4gICAgaHcv
YXJtL2FzcGVlZF9hc3QyN3gwLXNzcDogSW50cm9kdWNlIEFTVDI3eDAgQTAgU1NQIFNvQw0KPiA+
ICAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3A6IEludHJvZHVjZSBBU1QyN3gwIEExIFNTUCBT
b0MNCj4gPiAgICBody9hcm0vYXNwZWVkX2FzdDI3eDAtdHNwOiBJbnRyb2R1Y2UgQVNUMjd4MCBB
MCBUU1AgU29DDQo+ID4gICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXRzcDogSW50cm9kdWNlIEFT
VDI3eDAgQTEgVFNQIFNvQw0KPiA+ICAgIGh3L2FybTogSW50cm9kdWNlIEFTUEVFRCBBU1QyNzAw
IGEwIGZ1bGwgY29yZSBtYWNoaW5lDQo+ID4gICAgaHcvYXJtOiBJbnRyb2R1Y2UgQVNQRUVEIEFT
VDI3MDAgYTEgZnVsbCBjb3JlIG1hY2hpbmUNCj4gPiAgICB0ZXN0cy9mdW5jdGlvbi9hc3BlZWQ6
IEFkZCBmdW5jdGlvbmFsIHRlc3QgZm9yIEFTVDI3MDBGQw0KPiA+ICAgIHRlc3RzL2Z1bmN0aW9u
L2FzcGVlZDogQWRkIGZ1bmN0aW9uYWwgdGVzdCBmb3IgQVNUMjcwMEZDIEExDQo+ID4gICAgZG9j
czogQWRkIHN1cHBvcnQgZm9yIGFzdDI3MDBmYyBtYWNoaW5lDQo+IA0KPiBEbyB3ZSBuZWVkIHRv
IGFkZCBzdXBwb3J0IGZvciB0aGUgQTAgYW5kIEExID8gV291bGQgQTEgYmUgZW5vdWdoID8NCj4g
DQoNCkkgd2lsbCByZW1vdmUgQTAgaW4gdjMgdGhlIHBhdGNoIHNlcmllcy4NCg0KPiANCj4gDQo+
IA0KPiANCj4gPiAgIGRvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0ICAgICAgICAgICAgICAgICB8
ICA2MSArKy0NCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCAgICAgICAgICAgICAg
ICB8ICAzMiArKw0KPiA+ICAgaW5jbHVkZS9ody9pbnRjL2FzcGVlZF9pbnRjLmggICAgICAgICAg
ICAgIHwgICA1ICsNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jICAgICAgICAgICAg
ICAgICB8IDM0MA0KPiArKysrKysrKysrKysrKysrKw0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLXNzcC5jICAgICAgICAgICAgICAgIHwgNDAwDQo+ICsrKysrKysrKysrKysrKysrKysNCj4g
PiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC10c3AuYyAgICAgICAgICAgICAgICB8IDQwMA0KPiAr
KysrKysrKysrKysrKysrKysrDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAg
ICAgICAgICAgICAgfCAgNzkgKysrLQ0KPiA+ICAgaHcvaW50Yy9hc3BlZWRfaW50Yy5jICAgICAg
ICAgICAgICAgICAgICAgIHwgNDI0DQo+ICsrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaHcv
YXJtL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstDQo+ID4gICB0
ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3QyNzAwZmMucHkgfCAxNjEgKysrKysrKysN
Cj4gPiAgIDEwIGZpbGVzIGNoYW5nZWQsIDE4ODQgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25z
KC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMN
Cj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2FzdDI3eDAtc3NwLmMNCj4g
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vYXNwZWVkX2FzdDI3eDAtdHNwLmMNCj4gPiAg
IGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYWFyY2g2NF9hc3QyNzAw
ZmMucHkNCj4gPg0KDQo=


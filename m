Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC82C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwqyp-0006vW-01; Wed, 19 Aug 2026 20:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwqym-0006v8-F2; Wed, 19 Aug 2026 20:50:00 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwqyk-0005mE-1J; Wed, 19 Aug 2026 20:50:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHKVp6+keZMOUxtRDqFv/Rm8pZQToJT88MfLD9Y6SLyNkXCffLe25fgdRZU9nNXj/OY/zOKRzilnKG5Ll25szqY97HQ7jjEimmJPZKbJHJFNO0clOhK7/n2xGc/YU7ClCXeQW2xDXzCOruqTrOaZrDEwXxdYZn6+DjeXTDbnaMD7LwQ6C024aIglG0Ys0ECQ2TegnOUbiRVUY3EGAwH2bIQTEvUz/2WWjgcol5Gbq9d1oZdAUf9BuiNTO9gyyoUMOznuj7jG/S1z8XmFSY6jtZQUoQVPY6Cc+kM3KgCmhg+kfv681BBeAInUpMPfbVAU2BDKKE6jlMmaAxSYhq5uOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa07KuvzHgmv5dT2JTv4iC5OZy91lIxMbn2O9BykZks=;
 b=EvrywiobuqSlIJVGB3NAN4lJVWuuUr2xMvLUrsnZx2zPsHExEIvrxu21vKv1cwOHtKMdzrchGsjdO8Ki+tkEGwzf7EDEl8yVgBFO6LDu8qWQmW3L2zLfq1JW0WmhWpd8b2Klx7ZfKG8LiOlJHgh6WEGyT+SHbDR5SZ5WFh55NujGnjfoDxO8Uj3MUtWUHm68DNw7GZNEMsd4kdocswKYFoGYQhBYbwPKMCLKXh3bZDcr6I0sycZe3/zcLWG7xGPilqZf2Tga5ySQVxO1892N3JB/9VO92reR/k6xuo1Rq4PjwCWcOOaHup5Kf/SqUWk2DE6vpEbtlvH1fmyn0Ie07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa07KuvzHgmv5dT2JTv4iC5OZy91lIxMbn2O9BykZks=;
 b=e/DiZ9TW+kU10OHeObUMa3IW90ouY3Bq9YoH9hwMacdxMR3ezVOKHjt6j9yNODm3Wu4ifahsKoO+ZzPM9xs6wVT4J1zgZLuvL+g6zDaTbYKvWZAAZQjQ4kIXAL/oTtdXAk7xof6Y723uXjYvrFGy2yEvOK2MddqcGzXaf5EmqEVg+RA/j0oGQcFxU2xFwFV6P+ewX6LmHddCvbXLKFYZa6tBHXIMzImQ49t2Ea3iJQgH8lnuMJ8fhf5CMNMhfRnP8fFr2W9Q6ZS8CfpT+CrKHZd8uajq3D0VkW06w/E5+gttg/8hZTiHHq2DHJ0RZ4Gf1Ql98VPYnjSpGm4P9Ul+yQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE3PR06MB8128.apcprd06.prod.outlook.com (2603:1096:101:2ee::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 00:49:47 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 00:49:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 5/8] hw/misc/aspeed_sbc: Support the ECDSA verify
 command
Thread-Topic: [PATCH v1 5/8] hw/misc/aspeed_sbc: Support the ECDSA verify
 command
Thread-Index: AQHdLvMpP0UtlcWcvUW1KH8tz518gLalzaAAgABOrEA=
Date: Thu, 20 Aug 2026 00:49:46 +0000
Message-ID: <TYZPR06MB49809B379389625AE463517AFCA42@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
 <20260818092249.602137-6-jamin_lin@aspeedtech.com>
 <5cc43599-6134-40ad-bc32-fadfbfaf9e16@kaod.org>
In-Reply-To: <5cc43599-6134-40ad-bc32-fadfbfaf9e16@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE3PR06MB8128:EE_
x-ms-office365-filtering-correlation-id: 8fbd3abf-969e-4928-75b4-08defe54eeaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|56012099006|18002099003|22082099003|4143699003|921020|38070700021;
x-microsoft-antispam-message-info: BnWc/QJEkYvmri+OlFl85pAnxSbAWqo5zJmHeS4p2Oc5JL6k2f93n5WLewFkWjLfnslA/SyPcJIibcpPxObVWS6nXJ8/HCkEhPhY6+BJFk3h+GoiFYERdkxFnl/T1Kw1ifGXeTQY5y8cV8+4zsq7LGHiefe5mr1+3jZbOA7Gz4Spwdo7hdVVE2JGGdsaVU2nfq7u5IHlScR+IZ9M9KfMcnXbGZEBY4lwVo5/+V8fVza6TocMHfnFmBOzaqxwE7u0IJgSAuo9iiwBNjGRKP6SqCWTi9r1jqHcLKQbgdMxPAqba/FOJqpDIDlS2Q8liYl6cVD6yZ9lV5qZM49Iib7jnDVXqydCahW728q8XWrG45IYOnNxtKULvqIj/ApT1atDsLTMTbch5nzNsA0XDtgFoZiFIbOeGS4TmDiuwNz6ZV5YccHOU3rvC4fmKsk8BDIx83IG/FbM9oR17bQo4FwB0QV0ZKJ96ZfVmstkIfTqVHxr1Jl5CZdY9jD4uW/M01eSmUgZ6TlCCfRv1OTRX6qSzZNzQodFJSMVwLQbuoPHzNvZPOgpf0z3XWRcqppf5/ndYqTNT2v1lYhdhdO+a2I+b7ty/C71s/OHadzG/jAwWNs7Pk53MEoJRdqVn0NvFO2+E/kzjm5KQV3wdsGk62Kw1db0Hij/YVgOpddph3DZBV/RT0gxYu9hZoqIT9aLX9XuiFLHbFyAIgjt9X7tvD9bWRdx3oK6BzxesxUl+Ol/AvHQcP3So3iGMKNBIKa+/Kpr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekhBTmNMQUR0QmVWc2YvaW9VS1RQNjlhM3VGY0VUVXp6QUNtOFlmU21ZeTNj?=
 =?utf-8?B?d1ZRL1FxMkxMR3o1azU5aWJCWStray9vaHNueUFGSFA3YTkwVFhpMi9reFBq?=
 =?utf-8?B?S3gwL1ZidWlJWjgyTyszQVlxVUpzbXE0d0wzL3hGdFNMTDhsRjF3bWlSK3Bl?=
 =?utf-8?B?eCtBTW5PSWJnZFZuM012cDdjZUdEVnV2U3pKNFJWaEVJMDNaK3ZDNzZvTHlT?=
 =?utf-8?B?aXhwTnlybmtnMm01RlVwOW5KMThvN3JFeXZRaGFmZXYzUGNJeDlCNWlqNkxY?=
 =?utf-8?B?Y1V6S0t6SVBqWHNHRW5LclpyLzdrbzF1WUJpWGFwN1AxaUlCYkxZTVpnWExw?=
 =?utf-8?B?VmVOMXpXWlJXbmx0RHVEMmY3TlJXdHplYmZsdFJPQkpvQ1VwTlB1Wi9WZGxK?=
 =?utf-8?B?U1ZlSFk1Qk9RMVFUaTlpMnp2OHlWdjFJeXdDU3U3VFN4UWpxZVNLNGJQaG16?=
 =?utf-8?B?b1JMZW1lV3o3ZVQ4bDlLb0tRN0lKK3BBYWhvNGhaSEI2WmhkODdHTUJYOEVL?=
 =?utf-8?B?dFJYSFlucTA1WnJJMnZMR3RGa1JwUGwwRi9QemNDYlpUZFVqSko4SnVYZjBS?=
 =?utf-8?B?QnBzMjM3empQYUdSUU9VTHdnanFQNFBKSWUvdlN3TkxTQTNYamoybnVwcTR5?=
 =?utf-8?B?N1FJY1JGTHpZUWFlQ0dibjloUmswL3RGbEhScndYYzNQcmgwSkJpb1p1bXVY?=
 =?utf-8?B?UWkvdDZXVjFSeDVoRkc3aXJoSHNFbTV1a24zdDlrTldBeDB3NUN3UkNZUUZa?=
 =?utf-8?B?QzE1am9MWGUwMTd4UjhkZnJXYTNMMUt5UEtPSVE2cnpaclo5aXdBSnVWZHUw?=
 =?utf-8?B?SVJmTGVONzNOVXFmeEdzcVFQN25aYUxJeUlmbW1oWFIzdXphcFlDUk1lZTZC?=
 =?utf-8?B?c1ptWHFnRzFXcWxUcWVrVUZMc291WHgySE1ZRWltdnhFOUpEQTNtelFlTit0?=
 =?utf-8?B?NUVJVDZJMkhkYTI0UHpHa054bVRNcHZmZi8wNlgybDdDOGRjR09WRGVDc1pL?=
 =?utf-8?B?TGcvek9ONHM0MGlHRG9JdkNjQUE4bTFVUlc5S1A2MXI0R2gvbGlOSVhzWGNj?=
 =?utf-8?B?blhSRGxXOC9ZSDVMM2dwMHFabWN3dW81KytHZzNDT3hzS3hadjVvOWFxdk1Q?=
 =?utf-8?B?bFJ4SE1IaDJabGxtUkxkd0l6dEhVdHJBRFZDZnRtcEJmL3ZWUGp4d004Tzhu?=
 =?utf-8?B?OEM0UjBzRU1VQUNFSW1vK0V0MzZTbzRqUDJTOWMrQS83cHp3d1RSdjlEa2NL?=
 =?utf-8?B?cHBPS1pxeko2S0VhREdyMEpCbXp6eXV0M1NTNnl4anNzRVU5YzlqWHFCbGtq?=
 =?utf-8?B?TjlTdEpuRmg5YXFlQ01yUEtJcWkwaEtBZ1dtNlZkZVpmMUFOcUt0ZVlmRllI?=
 =?utf-8?B?Z25hcjRnTmxxTkhjTE1TYmcwaUt3c05PK3NWZmROZndaMVNUMEh3QmJRRFdQ?=
 =?utf-8?B?T0R0UHpiYlRHc2ZWWEx5YWFCenU4c09mQzNUNmxzQU91NFUrS2k3dlY0ZEsy?=
 =?utf-8?B?NHVMK3lMZEdtZGN6bzJMNXpPc1VSZzBJLy9DTXZ3ZjJ2dDlmc0phY3J0OWZp?=
 =?utf-8?B?VzBXaTVQeE52Yy83V1d2T3BERGI4SjBBYWY4NGhMaWFWZTVMWXFJRXdrYVBB?=
 =?utf-8?B?c0pPM01ZTGwwbVZuMVRrNFU0S0d6SmphNTk5L2JuQ3ZiUnh4THZNbUN1NU5n?=
 =?utf-8?B?S3dtR0NXdzJFTC9SOHh5S3BaSW5pQWpEZ0E4eGs0UHlPYzBldGloUmd2Z3VN?=
 =?utf-8?B?NlFVNU5nZFA1S0x2SCtzYkl4dS9TQjgzT1JnODMweE1vWUVxcEMzSEdXR3hn?=
 =?utf-8?B?cnpKQ1dKVHlTc0NWOXE1OG90cHowaHBERlI4NkY0QlphVHR0UHVaQ1FQOEVn?=
 =?utf-8?B?RDBRQUZYSDZSOUtKRUdBY2xMK1lZazJ5WTJJZ2hBbVY5Uk83QWN4U2lvbnFG?=
 =?utf-8?B?L1RVb3ZidzdqWExjYjRmQWlkdk5nVlZ3NGdXRWZUY3oxQUVYMHhyTGd1Q3VU?=
 =?utf-8?B?TjMrazVJRWdBNEl5bGNxOStxR3RSZWRhZm1TOUZhbEdrWmxaZ3ZkRzdnczVB?=
 =?utf-8?B?MUZsZFpkMWJtTk5PTlhWY0FBZUdVendabGIxSkpPallwcXpTeTFxOFR4dFVj?=
 =?utf-8?B?Wlc4WDJ3WHpMdnlnWHFsdzZ4dURwUFBCQlBRNW4zTENmd0tNbzAvOUJvRXJy?=
 =?utf-8?B?Z1JSM3pCamh4VlovSE9UOEI2bmduUkNObFIxR3JHQlRERy90VUNYRW16LzF4?=
 =?utf-8?B?TmFQbUd3WHF3cXhGMGdsQ2FiYzlUdlprRTlyUk1hSG0rSGt3RTVEcVRmU2Vs?=
 =?utf-8?B?ZWxwbTdTKy9YeHFFRUU3bFVwOUUyVDBEOTRHczhkVVAvUkFqOWlnUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n2IjScYCxOw9lLbA/PYmo3UPbnbQSb0MdTK/0cSYxjgnQsSRwfrJJc5aGPnLV3ns9frO4BEsr07f5GnKYopsD4V14heibWf6RZTmFrGp/glMXqQ8CzA9YYB/XdSjT51Jf+xkNyIQhggWgsYORQXeN9H2juGCbejsgOOvEytcdXbTawx5QXu95kmOBPwQmPjNCFgEHG7sJSGbGDjQccIgZXUEzBGiF69jgTYestJkhtL8Xre9vs1ZAg+HrcvuLlnWGbHU3LOX/en9zEiAWtRmyy2sMQ6DocOIFe7ap47gqNIcDabjKHgqP7A/BfE1uTSGAKu+R5KBTkX7mMQSxsswDQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbd3abf-969e-4928-75b4-08defe54eeaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 00:49:46.8239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZsQCUJam5f8da2EUWkBYTjlZxjn1M5OyMcKkFG3L6oCG5tPT6c2hwH4olSpOVV/2d5+50KI0bz1+aL3IzsjFK8rFm5oIGOzKM23IIHgnGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8128
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

SGkgQ8OpZHJpYw0KDQo+ID4gYS9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX3NiYy5oIGIvaW5jbHVk
ZS9ody9taXNjL2FzcGVlZF9zYmMuaCBpbmRleA0KPiA+IDA3YzdjMjJhODYuLjliMDRhMTBhZWQg
MTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9ody9taXNjL2FzcGVlZF9zYmMuaA0KPiA+ICsrKyBi
L2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2JjLmgNCj4gDQo+IFBsZWFzZSBhZGQgdG8geW91ciAu
Z2l0L2NvbmZpZyA6DQo+IA0KPiAgICBbZGlmZl0NCj4gCSAgb3JkZXJGaWxlID0gL3BhdGgvdG8v
cWVtdS9zY3JpcHRzL2dpdC5vcmRlcmZpbGUNCj4gDQo+IA0KPiANCg0KUmVjZW50bHkgcmVpbnN0
YWxsZWQgbXkgVWJ1bnR1IHdvcmtpbmcgZW52aXJvbm1lbnQgYW5kIGZvcmdvdCB0byBhZGQgdGhp
cyBzZXR0aW5nIGJhY2sgdG8gbXkgR2l0IGNvbmZpZy4NClNvcnJ5IHRoYXQgeW91IGhhZCB0byBy
ZW1pbmQgbWUgYWJvdXQgdGhpcyByZXZpZXcgcnVsZSBzZXZlcmFsIHRpbWVzLg0KDQpUaGFua3Ms
DQpKYW1pbi4NCg0KPiA+IEBAIC00MCwxMiArNDAsMTcgQEAgc3RydWN0IEFzcGVlZFNCQ1N0YXRl
IHsNCj4gPiAgICAgICB1aW50MzJfdCByZWdzW0FTUEVFRF9TQkNfTlJfUkVHU107DQo+ID4NCj4g
PiAgICAgICBBc3BlZWRPVFBTdGF0ZSBvdHA7DQo+ID4gKw0KPiA+ICsgICAgTWVtb3J5UmVnaW9u
ICpzcmFtOw0KPiA+ICsgICAgQWRkcmVzc1NwYWNlIHNyYW1fYXM7DQo+ID4gKyAgICB1aW50NjRf
dCBzcmFtX2Jhc2U7DQo+IA0KPiBTZWUgY29tbWVudCBvbg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDgxMzA2MjM1OS40MjUyNjgtMi1qYW1pbl9saW5AYXNw
DQo+IGVlZHRlY2guY29tLyN0DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+ID4g
ICB9Ow0KPiA+DQo+ID4gICBzdHJ1Y3QgQXNwZWVkU0JDQ2xhc3Mgew0KPiA+ICAgICAgIFN5c0J1
c0RldmljZUNsYXNzIHBhcmVudF9jbGFzczsNCj4gPg0KPiA+ICAgICAgIGJvb2wgaGFzX290cDsN
Cj4gPiArICAgIGJvb2wgaGFzX2VjZHNhOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgI2VuZGlmIC8q
IEFTUEVFRF9TQkNfSCAqLw0KDQo=


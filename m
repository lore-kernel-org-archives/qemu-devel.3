Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120B7C54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 01:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHukU-00044n-Pk; Wed, 21 May 2025 21:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uHukR-00043w-62; Wed, 21 May 2025 21:29:27 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uHukN-0002Wx-8o; Wed, 21 May 2025 21:29:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbuzgGfowl5VUiGqB5l3VV1ny/S8WzbyEtL3zC5cb+PM8heWSq2AZowpNEvxAwGJs1JD4KHfR87BTJ40pH+RcvRn7Dm+mQvvksqqGUxD5UA7KSHYzKe+GCUuccM7q3xcL1+ICXUrSP41Gy4vaJbicn/9SVK4c1Mjjj6dAO9D/VO3AUDK/w2DlhrdNmL5RnWwP2vIb1q6WL+mU3IkLiS36cmvIXFiK1OP8ScSHyrQDTDQ8TtYI0nlZ35aXFnuBojTowYBruZgBTFXQPT5XbmyAnc/q8EwRmiUCMIfOoXrLcoEk3PurTboYq8HFSlDdoGXEhKvZK5xTTHX5xeUnH4gfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0I0/lFvIpI812QxMR5Fn6DPDkHdtMHwSnTLsmhPjVOI=;
 b=PyD6BUcv+ciIoGlUfAMMhdONfZ7xqG13dBQLnkyFe3CNf/TdB02cv/gvx1eoeu61kHNJ7x6PrygYqMqffDDyl1pDB7JLqnACSlOsfWO/p5VIK/nbXYxnAisOa0jlLBTwX8TW233ggrUa5h2nUzJDNcDG1HHxYe+iUV+hnjSsW1lq/yoJ4imBpz4uSMqSxwoWRicnybJhhyrY/tmq/4IumF+jnRhgl3crjzI8eSYAW4cIfJYnzIQNtix+w300nT8DfVNJpTiVpTAfO57vITC2R4vJdFoJr7lVTMY0iAkSiMMfCZORkx5QG24mYihjs6VAr6L3yKKmPWgkncTgqHtVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I0/lFvIpI812QxMR5Fn6DPDkHdtMHwSnTLsmhPjVOI=;
 b=MqHh4cW3uL76gYAhWtkdAu4IL1aGZUlQSjs5dv0IxCaBwrgENesEA/DW8EzmSGVc7E2HtYO+QtIHWKutSgGqHDUbuTnkECVAmz4eFHf6DIA5/FbGNekXsSviWFmKqKMMgU/2JB0piL+bf4g3NRV5F0beZhlOny4ZvIRAzp7d3tKNgZsQobDDGRTXu4deqlbloGOhe+7nDZL75gYGDC+9ePGws2t5kwFn5Gl0EZBDCptp1/aIvh9T/p5zPkTYF+xyofupM/2ZAaECoH5SBsp0NkNjLc4oBXnkTMqv+ACQ8VsNuhsVzcx7/SC/kJl+7lMg2SZj+Z2ztDj5191QVceLog==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6912.apcprd06.prod.outlook.com (2603:1096:101:1ec::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.21; Thu, 22 May 2025 01:28:40 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 01:28:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 3/3] hw/arm/aspeed_ast27x0: Fix RAM size detection
 failure on BE hosts
Thread-Topic: [PATCH v1 3/3] hw/arm/aspeed_ast27x0: Fix RAM size detection
 failure on BE hosts
Thread-Index: AQHbyVnQnu2lJW4zMkyCp5i7RK+cNbPdPvYAgACfzwA=
Date: Thu, 22 May 2025 01:28:39 +0000
Message-ID: <SI2PR06MB5041A9B67CB614F2EB87C529FC99A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250520073540.2014240-1-jamin_lin@aspeedtech.com>
 <20250520073540.2014240-4-jamin_lin@aspeedtech.com>
 <55f9f007-44c5-4a27-b3a5-9c4a939d1c6b@kaod.org>
In-Reply-To: <55f9f007-44c5-4a27-b3a5-9c4a939d1c6b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6912:EE_
x-ms-office365-filtering-correlation-id: d40f2fe6-eddc-431f-1616-08dd98cffb53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NXFvUHlTcUVoeFo0MW0xbTdBUHFpZGtzbVZWTFBCWWdLeDZablZzS1lLL2FO?=
 =?utf-8?B?dmZDYUE0RU5sMFZvRytmcExHK29RcnVjWGY5VnFuR1F5WUQyTDQ4QStNa21P?=
 =?utf-8?B?eGRPQkp6TVdSYWczcVAzaVU0OHJhT1lpSVhYUUVEYkpxdDBUWDlHYWkzdnBy?=
 =?utf-8?B?M045elJISXUwMXVXaVMyTHYxUTFvdDBVSXRQTncvZEgybjVTbng3QmR3bnFR?=
 =?utf-8?B?OWJyZlorZnpmcnpEKzFpVDZVeTR3ZE12aHR6QzE1QXR0U21qV29HdFErd2E4?=
 =?utf-8?B?cHlkbS9IcDl0LzNHZGE3ZzgrSCthZkhReldrTVdGcTdGT2FLNkxqVlU2bWdh?=
 =?utf-8?B?ZXd1VXU4bXRib0JuVEZmZ3oyUUU2bit4Y3B3MVJMMEdLSlllWmxGK0Z6YUlJ?=
 =?utf-8?B?bmhOTnloSjhlbjh4VHNaam5iSVlPUkdvYTNSUUFVM2xTeSswcDhOM2JtcStj?=
 =?utf-8?B?NFFEU1NMcFVuOVBUeWxXRlBBT0pkM2xQWUlKT2tGRWRQcElTTm8xVCtmYjdv?=
 =?utf-8?B?SUFackJFV0VrM2pjRnFFYk1TV1J6SXg5eWJKM3ZLK3RuZG9WU1hoSTJSbmhx?=
 =?utf-8?B?dWUyNld2QnU2d29FbnNEQzJqMno3R2djblBGaWxYbGlIZW5TZS93Y25hdVJS?=
 =?utf-8?B?WnY5SG5oRk5uNTNqN3hna2Z6VFdMVVUrZEN4SXJ6MldPbHpTNGxlZERZcm1n?=
 =?utf-8?B?WkJQTDJWMFVmNTZrdUtzOHhSRHFka3lsRGs5ZTRoQlJNL1FqSUNhbDlUZnFW?=
 =?utf-8?B?dFdsYlphN3pBa0FzcFJ5b1ZSYmNkMlE2eFRCamxKUFRhRTdwN0FsOVRzZ1oy?=
 =?utf-8?B?WUJBZzc1d2pNTXB2c0s5WDBHSFE5ZHk3U1IyQmFhRURZMzROUEV4ZnpHdHVi?=
 =?utf-8?B?MkRhejZLUVY5aEQ0Z0NNTk5OOFNIY1dxNitKQm9aWnNUR292dWc0SDJRa2lQ?=
 =?utf-8?B?T3VCQmtITmFYdG41a2F0OEN5L0w4WGFOTHRBRytER2x0cERJQitRenF4a3Ri?=
 =?utf-8?B?U3E5M1BTNWViQXpZY2wyV3RzeUZDSjFMdk5DTzBTUXI2bkcyWFZWanVVdi83?=
 =?utf-8?B?QUJVc2ZFbisreHUyd1VRYmsvdS9HWHQrK29ydmoyZFpRR0E1eTg1Zk9TTDNH?=
 =?utf-8?B?Nms5MUYrWjZwNndHbjdRUWJVVkFja0pXejFsdmQxVFVsMUdpOE0xZlcybWpx?=
 =?utf-8?B?bW1kajF0Rmg4UWRhcDBEa3cwVld2ZmJwMWZJTkZ5YStEYU52RksyaHNqK3M2?=
 =?utf-8?B?UXIvWTd6VXA3M1NZNFVuNERWS2kzc3NXY1ZONEtOMjdybGtyUldIdi9YcmJx?=
 =?utf-8?B?dUw2VjZzMmxYTHdHckdzNFlHU2hTdWttaXZseHNPL04rV2JWR1IyUTlNdG9L?=
 =?utf-8?B?b3RrRGtyemtuWkZnY3BzRWFwaXYxeTZ1SGo4am1oSVcyYlF2NnJpZFpjQ1J5?=
 =?utf-8?B?NEl4RDQ3WjMzVnBSYzBSbHBSZXB2Q0R3MlkzU3R3a2Y0U2pJekhGTllRb0hG?=
 =?utf-8?B?WXZYdWQ2Q0NJdy93MVVIZlIzMXdwb3FWMjdWNFRORk5OQlllc1IwQnpWcEZ5?=
 =?utf-8?B?Z0wzOURIcTczeUx6MEZIdTBaL2RFU1lGK0hiTGpXRmJ1VlMzRTlkeWQ1V3NS?=
 =?utf-8?B?S2JHd1lKQm9mZDVSakhPUkxOR1ByQVBGUUVLVFpaSGxuTitDbTFvNStOb0dy?=
 =?utf-8?B?QllLbHNGUXFmY1hRMTRpNWtvS0F2aEpLdWQ2L1kvUjcxNFltVmJYVWN3VWRM?=
 =?utf-8?B?K080R1FUMThERmMrSloydURQVHN2akhpaEVFUUJyWWQyMG5JckF2RTN3WW9U?=
 =?utf-8?B?bFZ2bml5SGsrZWphYUs2c0ZvVy9mZlFFL3BJNG9tOW1GWDZyWEpMZkFHcVNy?=
 =?utf-8?B?Yno5S2dYOGJPY2xqbTdiQnNNUlc3a3ZLZndzQUU2djMvTCtCd3hNUXlvSkow?=
 =?utf-8?B?OWN6MXZ1QUx1MlZwZE8vVGlKSEdIYUNCU3ZpTHFMbE8wa0tFbkRHTVhlS1BV?=
 =?utf-8?Q?kWVnKh7SsRPHBlFQ01mtB451F+ru6s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHdjeXZUUE41VjgwRUFYcTdjNmF2OFp4d000TnFrZEJkTXJPWk55S0tHSDg2?=
 =?utf-8?B?ZG0yUndwNG5PWTBWcytFRitja1RJQlVnQU9iREduV2JjZEZQWkdLR1VMbGs3?=
 =?utf-8?B?NHJIZGFJTGltRUtkM0UrSG9lbHg5ZXNhMDdLOVRCaWgyWHFJRDgxUUxuUElC?=
 =?utf-8?B?dENMTlo5d1BRRFYvUytFQzA5ODZtQ255TjJmSWtpSzQvS0lkRjh2czFJM2Ra?=
 =?utf-8?B?RW1mU0hFT3BVM0Z5N0QyMmNMVW5WM3AreU1PRmtVV3BkYmExWTFFdHp1WTJl?=
 =?utf-8?B?ei9TRzFDUExLbnNuZC9xNDNFWEx1ZXkvMENSdzJ0SW5YSW5hZ0hTZGwvNGty?=
 =?utf-8?B?Y0hjMEVHalU1NmgwbG4xeW15MkpqVjh1ckh3MGJVU3I2SnZGa05DZmJnSkxJ?=
 =?utf-8?B?VXJGVEFmWWVaZ3Q3akUrUXZkNWlaK0NLTjc4WmhOVVdLdk94V21MSCtSeWdS?=
 =?utf-8?B?ZktrbXZEZkx4SjBscmF5dmoyYVVxU0RpZjFqYzZPSG9icUVNVGE5SDJ1TXdX?=
 =?utf-8?B?SE1VaWtrQ2Q3TFFuekk5cFRFZkltZkdSOHVBcUVRM1l6K3VRYWZyTElxdWpM?=
 =?utf-8?B?YzF4RFBaL1FEZmY2VnpxL0M2RlVVWi9tODNaRGViYUpmOEFTSlZnUWY4VlpQ?=
 =?utf-8?B?cUIvSVZTVjhVQTVqclBnTEQ1U2RxemlLQlAvT1h1QkI2eXVOeWxHVVR5OUR5?=
 =?utf-8?B?dUhsV2p3RnhhSTlkSEtTUnR3RGpuYmNQcjNVa0FQeU5qbmZxNXpsMktEQTB5?=
 =?utf-8?B?TzRNeFFsVEtFTW5VSHV3YnVnd1NnWjYzSDlxMi9uaFdlV2ZRL3ZycWZ0U2tP?=
 =?utf-8?B?bHl0QXN6TFdUN29aU2F6Z0FncUlrMG91SFA2K0FUQ3NuK3BkNGQycjZoemk4?=
 =?utf-8?B?NDZESjNwQ1RWK0RIRUlsaVN2SjFyZDZNNHg3YVIxd3hvREZaK2xWN2lOTnJL?=
 =?utf-8?B?OTRnUHJlODB5d3lVaFBzK0ZrRCt0UktLejhidWlXZlhISHcxNXUzakd5MXlF?=
 =?utf-8?B?Z2xVb3hqcXJkbkZmcU56KzFOR1RPdXNpcEhqa1czNFIxQ2x5UzdQNkp1MktP?=
 =?utf-8?B?dm9CaUs2L2hvckIvdHVOZ1NXcHZ5UjJYOVozZWdiQU1aS0IzcG5XZUZwODdC?=
 =?utf-8?B?eGRYZndjVUJyTFlmVzJ3SHlPc3lxaU82bmlnRFVnV2c4aTF4dDU5ZWtWYlAx?=
 =?utf-8?B?NUtEUW1lMXJ6Yk5vSTAyN3ZkbnRucUFlUjV3SSs5eDI1SENwQS9Sd0Z2Y3l5?=
 =?utf-8?B?V1k4Qjc5UlpUNUpmVDNRQlRicHZxREdUS05EczR0RjJBNTJJMkduN2d4T0lh?=
 =?utf-8?B?OFNwU2dvRkJFOG5sRWI2RjNtRm1vQ2pwTDNDYjR4OHdFeSswM1RLb2NPd3BX?=
 =?utf-8?B?ck1RMnRnR0dxRGhDeEEyVTczdThHK2ZmeUVQWm9yL0pFU3ZlSkxuY0EzTmFa?=
 =?utf-8?B?OGd2b3lvY3hxaXVtMk80WTVVZGlPZGdacHhKVmxUSUNBL2I3S0NQeXNHODlV?=
 =?utf-8?B?elRpSWZnekZiZ2xHdjgzenMrNnplS2x5d2pkelBmV2QxZVFncm9UczBHZkd2?=
 =?utf-8?B?UTdXTGRMVEpNMnNaOGRnazNvNjdjd1pjZFNLZENXNVU5anBvSTFXb2hpeE1i?=
 =?utf-8?B?WmF6UXhCTmhkWEM2cHdLN2RNQkRUMFNRWElHK09IZStYSG1CUXV0d29Yb3ZE?=
 =?utf-8?B?dG5WbWJCMUZrODlUNzlzcGk2dE94VmltZWxIczJnT0ZiVkw1YVZRdkxjK2Yz?=
 =?utf-8?B?cy91TEZoeVRscWFzQmNsMFplYVJHMTNXRW1ZNzFjRGJaWTY3NEd6d0tzZExK?=
 =?utf-8?B?OEw1VGRIUFhQOGpINmV2bzZlckRzdmMvaHRyR05oWSs1WnY3WW03ckNKcDJW?=
 =?utf-8?B?SmdqODdpbVIvTGZURldvYkpENU1TNVFJR1krb08zcE4vS3ZMcmcxTTg1MlBv?=
 =?utf-8?B?MjVFSXFWanZlYWFQUEFZT3RhUTA0VnRJV01SOFlpbTRSMmQ0N0YxY0lpc205?=
 =?utf-8?B?b3Q4K2ZYT3lydzNBZTV5aHRaSndTUlplTlp1OCtINDB0clovSWM0ZStCWEJJ?=
 =?utf-8?B?TTZoODJ6YUtlTHlEaWlGU0Q5Wm9qWTVJdUV6OFJ0SXdIT0JaTVVVRGQxcnFH?=
 =?utf-8?Q?QN2gySzqHmSjE6SSvHCBnHC7v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40f2fe6-eddc-431f-1616-08dd98cffb53
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 01:28:39.8163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWES4FjVHOGEXO2TZ3tJnKPElA2a8Ggf88gWB4lU80vBRlRZ7+zj9UVK2GBl3bTA/b8CrpzG0+zYC9329Kufo2UNYAB8ZE5yDII+8i7Vro4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6912
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMy8zXSBody9hcm0vYXNwZWVk
X2FzdDI3eDA6IEZpeCBSQU0gc2l6ZSBkZXRlY3Rpb24NCj4gZmFpbHVyZSBvbiBCRSBob3N0cw0K
PiANCj4gT24gNS8yMC8yNSAwOTozNSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IE9uIGJpZy1lbmRp
YW4gaG9zdHMsIHRoZSBhc3BlZWRfcmFtX2NhcGFjaXR5X3dyaXRlKCkgZnVuY3Rpb24NCj4gPiBw
cmV2aW91c2x5IHBhc3NlZCB0aGUgYWRkcmVzcyBvZiBhIDY0LWJpdCAiZGF0YSIgdmFyaWFibGUg
ZGlyZWN0bHkgdG8NCj4gPiBhZGRyZXNzX3NwYWNlX3dyaXRlKCksIGFzc3VtaW5nIGhvc3QgYW5k
IGd1ZXN0IGVuZGlhbm5lc3MgbWF0Y2hlZC4NCj4gPg0KPiA+IEhvd2V2ZXIsIHRoZSBkYXRhIGlz
IGV4cGVjdGVkIHRvIGJlIHdyaXR0ZW4gaW4gbGl0dGxlLWVuZGlhbiBmb3JtYXQgdG8gRFJBTS4N
Cj4gPiBPbiBiaWctZW5kaWFuIGhvc3RzLCB0aGlzIGxlZCB0byBpbmNvcnJlY3QgZGF0YSBiZWlu
ZyB3cml0dGVuIGludG8NCj4gPiBEUkFNLCB3aGljaCBjYXVzZWQgdGhlIGd1ZXN0IGZpcm13YXJl
IHRvIG1pc2RldGVjdCB0aGUgRFJBTSBzaXplLg0KPiA+DQo+ID4gQXMgYSByZXN1bHQsIFUtQm9v
dCBmYWlscyB0byBib290IGFuZCBoYW5ncy4NCj4gPg0KPiA+IC0gRXhwbGljaXRseSBjb252ZXJ0
aW5nIHRoZSAzMi1iaXQgcG9ydGlvbiBvZiAiZGF0YSIgdG8gbGl0dGxlLWVuZGlhbiBmb3JtYXQN
Cj4gPiAgICB1c2luZyBjcHVfdG9fbGUzMigpLCBzdG9yaW5nIGl0IGluIGEgdGVtcG9yYXJ5ICJ1
aW50MzJfdCBsZV9kYXRhIi4NCj4gPiAtIFVwZGF0aW5nIHRoZSBNZW1vcnlSZWdpb25PcHMgdG8g
cmVzdHJpY3QgYWNjZXNzIHRvIGV4YWN0bHkgNCBieXRlcw0KPiA+ICAgIHVzaW5nIC52YWxpZC57
bWluLG1heH1fYWNjZXNzX3NpemUgPSA0IGFuZCAuaW1wbC5taW5fYWNjZXNzX3NpemUgPSA0Lg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5j
b20+DQo+ID4gRml4ZXM6IDc0MzZkYjEgKCJhc3BlZWQvc29jOiBmaXggaW5jb3JyZWN0IGRyYW0g
c2l6ZSBmb3IgQVNUMjcwMCIpDQo+ID4gLS0tDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAu
YyB8IDIxICsrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE2IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJt
L2FzcGVlZF9hc3QyN3gwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBpbmRleA0KPiA+IDE5
NzRhMjU3NjYuLjdlZDA5MTliM2YgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwLmMNCj4gPiArKysgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiA+IEBAIC0zMzUsMjQg
KzMzNSwzNCBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfcmFtX2NhcGFjaXR5X3dyaXRlKHZvaWQNCj4g
Km9wYXF1ZSwgaHdhZGRyIGFkZHIsIHVpbnQ2NF90IGRhdGEsDQo+ID4gICAgICAgQXNwZWVkU29D
U3RhdGUgKnMgPSBBU1BFRURfU09DKG9wYXF1ZSk7DQo+ID4gICAgICAgcmFtX2FkZHJfdCByYW1f
c2l6ZTsNCj4gPiAgICAgICBNZW1UeFJlc3VsdCByZXN1bHQ7DQo+ID4gKyAgICB1aW50MzJfdCBs
ZV9kYXRhOw0KPiA+DQo+ID4gICAgICAgcmFtX3NpemUgPSBvYmplY3RfcHJvcGVydHlfZ2V0X3Vp
bnQoT0JKRUNUKCZzLT5zZG1jKSwgInJhbS1zaXplIiwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpOw0KPiA+DQo+ID4gICAgICAgYXNz
ZXJ0KHJhbV9zaXplID4gMCk7DQo+ID4NCj4gPiArICAgIGlmIChzaXplICE9IDQpIHsNCj4gPiAr
ICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICIlczogVW5zdXBwb3J0ZWQgd3JpdGUgc2l6ZTogJWQgKG9ubHkgNC1ieXRlDQo+
IGFsbG93ZWQpXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIHNpemUp
Ow0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gDQo+IFRoZSBjb3JlIG1lbW9y
eSBzdWJzeXN0ZW0gc2hvdWxkIGZpbmQgc3VjaCBpc3N1ZXMgaWYgdGhlIHZhbGlkIGF0dHJpYnV0
ZXMgb2YNCj4gTWVtb3J5UmVnaW9uT3BzIGFyZSBzZXQgY29ycmVjdGx5Lg0KPiANCj4gPiArICAg
IGxlX2RhdGEgPSBjcHVfdG9fbGUzMigodWludDMyX3QpZGF0YSk7DQo+ID4gKw0KPiA+ICAgICAg
IC8qDQo+ID4gICAgICAgICogRW11bGF0ZSBkZHIgY2FwYWNpdHkgaGFyZHdhcmUgYmVoYXZpb3Iu
DQo+ID4gICAgICAgICogSWYgd3JpdGVzIHRoZSBkYXRhIHRvIHRoZSBhZGRyZXNzIHdoaWNoIGlz
IGJleW9uZCB0aGUgcmFtIHNpemUsDQo+ID4gICAgICAgICogaXQgd291bGQgd3JpdGUgdGhlIGRh
dGEgdG8gdGhlICJhZGRyZXNzICUgcmFtX3NpemUiLg0KPiA+ICAgICAgICAqLw0KPiA+ICAgICAg
IHJlc3VsdCA9IGFkZHJlc3Nfc3BhY2Vfd3JpdGUoJnMtPmRyYW1fYXMsIGFkZHIgJSByYW1fc2l6
ZSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVNVFhBVFRSU19VTlNQ
RUNJRklFRCwgJmRhdGEsDQo+IDQpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELA0KPiAmbGVfZGF0YSwNCj4gPiArIDQpOw0KPiAN
Cj4gDQo+IFRoaXMgc2hvdWxkIGJlIGVub3VnaCA6DQo+IA0KPiAgICAgIGFkZHJlc3Nfc3BhY2Vf
c3RsX2xlKCZzLT5kcmFtX2FzLCBhZGRyICUgcmFtX3NpemUsIGRhdGEsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgTUVNVFhBVFRSU19VTlNQRUNJRklFRCwgJnJlc3VsdCk7DQo+IA0KPiBT
b3JyeSBmb3Igbm90IHNwb3R0aW5nIHRoaXMgZWFybGllci4gRmluZGluZyBhIEJFIGhvc3QgaXMg
ZGlmZmljdWx0Lg0KPiBUaGFua3MgZm9yIHRoZSB0aW1lIHlvdSBzcGVudCBvbiBmaXhpbmcgdGhp
cyBpc3N1ZS4NCj4gDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpXaWxs
IHVwZGF0ZSBpdC4NCkphbWluDQo+IEMuDQo+IA0KPiANCj4gPiAgICAgICBpZiAocmVzdWx0ICE9
IE1FTVRYX09LKSB7DQo+ID4gICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9S
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICIlczogRFJBTSB3cml0ZSBmYWlsZWQsIGFk
ZHI6MHglIg0KPiBIV0FERFJfUFJJeA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIiwgZGF0
YSA6MHglIiBQUkl4NjQgICJcbiIsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNf
XywgYWRkciAlIHJhbV9zaXplLCBkYXRhKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICIs
IGRhdGEgOjB4JXhcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgYWRk
ciAlIHJhbV9zaXplLCBsZV9kYXRhKTsNCj4gPiAgICAgICB9DQo+ID4gICB9DQo+ID4NCj4gPiBA
QCAtMzYwLDkgKzM3MCwxMCBAQCBzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzDQo+IGFzcGVl
ZF9yYW1fY2FwYWNpdHlfb3BzID0gew0KPiA+ICAgICAgIC5yZWFkID0gYXNwZWVkX3JhbV9jYXBh
Y2l0eV9yZWFkLA0KPiA+ICAgICAgIC53cml0ZSA9IGFzcGVlZF9yYW1fY2FwYWNpdHlfd3JpdGUs
DQo+ID4gICAgICAgLmVuZGlhbm5lc3MgPSBERVZJQ0VfTElUVExFX0VORElBTiwNCj4gPiArICAg
IC5pbXBsLm1pbl9hY2Nlc3Nfc2l6ZSA9IDQsDQo+ID4gICAgICAgLnZhbGlkID0gew0KPiA+IC0g
ICAgICAgIC5taW5fYWNjZXNzX3NpemUgPSAxLA0KPiA+IC0gICAgICAgIC5tYXhfYWNjZXNzX3Np
emUgPSA4LA0KPiA+ICsgICAgICAgIC5taW5fYWNjZXNzX3NpemUgPSA0LA0KPiA+ICsgICAgICAg
IC5tYXhfYWNjZXNzX3NpemUgPSA0LA0KPiA+ICAgICAgIH0sDQo+ID4gICB9Ow0KPiA+DQoNCg==


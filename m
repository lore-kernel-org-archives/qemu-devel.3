Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBAFC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 01:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whdB1-0000vK-KT; Wed, 08 Jul 2026 21:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whdAx-0000uY-E8; Wed, 08 Jul 2026 21:03:40 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whdAu-0006rq-BC; Wed, 08 Jul 2026 21:03:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNkwzAsPhwWyah05BCY9+z37HtZDzI9aCMpvdGmqmwlIt0pkmkN0jDp19c6OEtXELPRuVmHiMobNbCyE+dGx6XFE0yQuJ9dlEhmC9NRdYdWpu1Kcszo/eUbxsRR5br1Q9sSeaPklhXUvDZ+I5A65zDb1XT24IpjlLfyQEfEhkkGwlQhey9LG5RMSDYvqvDN+reJy5NRQZpe/VbiN9zidGgEDNOprD7v+sQQ1XWSu0htLwoKTmvo3R3c545sUwKddx8SwpJ4GXsN2ukwJ1iWTAPDCRMCSpeU+29F/yckgbioXf7fT8tHC3Zafd+RJlfNj6WZZwKuDSUjG1IQ6g9mOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGSkFl4itlZU+nreTKNWWEougAHe7pFjPFf6vblbiBw=;
 b=gURDjymfJixXWsASmUyLrCDgv9CdkUOEqNSDoErngvw9sK0fqh7/wLJe/+nGppkQvbehRHrBtH6S+8Q8Bk1YOpPGL9R4gfp9NMLlZrCqSvZWlRsS800/f+257OOBAP0vD1mDjbqcQZfx6YyLUWNCjUtMEwz46d4ljxRHUsndQm8dxwJ7O90Mnq2wqqfRkZicyrjXj/z0rFVuGlKAbC25YEs3Uk6VKV+qHQVP+QXvtDRjOBRzEuFbiaLtilePHZn9ELrktI72vH/t5hZVAL9OBy0ku5YDlhbG7FmBeR7XBxZqNtY7dMnJ9VyCwA6yHUl6XyMwWIg14e5eqCsyoaBOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGSkFl4itlZU+nreTKNWWEougAHe7pFjPFf6vblbiBw=;
 b=a6qFwwRAzQRmbmotAavbzT9M7yyVtKHS8Wu+gN+GxeBqwvqewjQquEdIr/Ut+lzGpEnmWszFGb02Rq5nTMm8YEyLDPQUKpei9eV3eXRj+tSE7YkiZMMqOiLWZS7woySJqmFMdjggrSkeVyAMK882+vgqrd5i2/awg966j7nCiD024RapDgpsDEQMxg2gEHm3cIded6Dq13xjGBs8bQzs4pDepu+4S18mV2xfp7VKzoV+qBnpfXGdal2Ib3mAVhGHwRT2/4njjc1BM1egXhO7/HfoeUNi76SP23moP6ohNkAO55KX+PAePFOju46ZqrKKzxjV4D+kuhpOxPe2VEjpaw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE3PR06MB8453.apcprd06.prod.outlook.com (2603:1096:101:329::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 01:03:29 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 01:03:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap support
 for AST2700
Thread-Topic: [PATCH v5 00/10] Add SSP/TSP power control and DRAM remap
 support for AST2700
Thread-Index: AQHdDrsB0PfBWMtPU0KIoukeQI21FLZkPUyAgAAhSYA=
Date: Thu, 9 Jul 2026 01:03:28 +0000
Message-ID: <TYZPR06MB4980E558390882926C5263ABFCFE2@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
 <3d2d869c-d1a0-40d1-83c2-755c080bd17d@oss.qualcomm.com>
In-Reply-To: <3d2d869c-d1a0-40d1-83c2-755c080bd17d@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE3PR06MB8453:EE_
x-ms-office365-filtering-correlation-id: 6370ebc4-9ef6-4b82-021a-08dedd55e364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|38070700021|22082099003|18002099003|4143699003|56012099006|921020;
x-microsoft-antispam-message-info: kOj6n55aP2thwTB++6CyR4Ca0dXuhINfl+NRT3zgLeNj7GtwrbyP755dzsPEDTS9atNygSIOqsbFxioEIl7Gbljz3btzTNUw8J/k5zwPCYSVu4LkryKh/kl92uo2n8QmmynqtLImDwStsuhnlPp+Nco5zT3JHP/1nNTsorU2HqLIpQxyOzgq8YWQtCrXW4yai7q1BH8mU95KoTKvbIHbZ8lX1lOpO1AsCfJJk3LGVEl5uM2VlrcYLy1gOyxUWJf9s4YLKYA5q7N1oowXcpnw8FBIh49OAYOTlIu4ayvOkFzt3VB1az4Z6HxqzxbAP8MNXcmIlO8uuPIhB5x2wWRPKAPZZTv91Sk7+3lxANIB0+AKazx/aCdOzWhYGLr5tj2QC5HGf15ckh6S0xubikQoRdTGzlbmDCu5xMKaBN6HIE2R9E4QBpO23U+nUl1YQwDWxWGqoUPWbyqkPBQkCywzQAiucw5bchBgm2RWMY/0fcIOk99bIx+pl7UzNkHz8VEN2++xi/SKo9LXxHOFaGUN+SV+J7nJudNCPJ+5iPwpdVxqY4eFG0jthNx2428KAL4elRY29MVLuBxzBrIDnIwlwhv04/hA39o3l+/XZTekKOBqOaIotAlCfkOCbZZe60eDg0Ta+3eU7oUvquxqC/5BzSlGhar/2wWn1BCwAldq1s88/02/cDNFNp/XRJgZwYyLO9AqcZTXj6IXMpMSDPpbhQbgky9Pk0oMOomzSqcLtIeeReAa+ijzZTlNmc8TMqdM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(38070700021)(22082099003)(18002099003)(4143699003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3ZyNndYWWNWd1MwelluMTd0MFRZNGlBQnpYNVN5bklZWHdWa3VlRHdwWDdM?=
 =?utf-8?B?Y0ZxeFkrSU81dVBKMUlxRFJKVUVrL1Q3MVVVV3pNVm9vKysrYlRKRTk0MkJa?=
 =?utf-8?B?VHA4VGd1RlB5Y1d1N1JqaWpnN1VSelZ0VFpYK1VodXNhZDd5ODgvbnljR25L?=
 =?utf-8?B?RWk4ZjhCSkhsbE9XYXBaWWxVSUtua1UyVGU4M1piMmFYNlRQOTdxZFVtWDZm?=
 =?utf-8?B?Z1orRndoVkYwTGRnTEVvUmxEdDBPSW5Ga1ZqdUFjZmhEUVlGRExMcDVaZXhl?=
 =?utf-8?B?aFQ0cTA2Um1pK1ZmQVU3TlVjSFVEbFhFckYrYng3b3ZwbFN2VWtZR09DeDNH?=
 =?utf-8?B?OWF2cjV2YU1WMXJ5K0k2S1NyZkJHTE9zNzYyNlJiYlhld1c1enBRYStIUCtu?=
 =?utf-8?B?d3BqN0l5OXJIWlVkamsyVXVTVm9rUjR2Y0VYZHIzRlRkaWdmSzFlNldWd2ll?=
 =?utf-8?B?bzhlWnQreUJkQU1NUzNXQ2s2cHNramgrS1o2NXQ5WnBHUUJjOEtuMG1CWitZ?=
 =?utf-8?B?a0puK0l6dGw2UW1BaHZDTklnN29hYVBFZkxEWUdqTFBKMGpJNDcwSlFaZVRE?=
 =?utf-8?B?cXdUcTE2eWhCTld0NDBsdnhGOG9iZGVudUNsYXVUaE5pUWhpVDQ1eXc0SjRP?=
 =?utf-8?B?Tmd4V29Tb295RE82Tkp6d0RpMFNmSzhzZG5pNE8wYllvQ3JKRlYycHNTOUJj?=
 =?utf-8?B?dU5EZFZWOFdoVDBqanVyNnBVM1dEMCsxait1d3ZwVlVyK3pEMlFaNGw2SkVw?=
 =?utf-8?B?WWJQb3JvZzFzVkJuQzZubzRsN3UxTnlUSzFNY00ycVl5L3pRTTJmUThMWjJw?=
 =?utf-8?B?SWI3MDBBSmZPODVvbFYvR2k3WUpmcEtwdGsyMXBwZk5ScHJ5S2hDLzNyZ3c5?=
 =?utf-8?B?UVdiMzVSVmV5elM3enpXNFpTM0lKTkhiMGZGUVBiZktxSmpKV2JMOWZvU1RV?=
 =?utf-8?B?b3hXMkNvY1hRd1FOcjEyZzh3YnlXdjliNkxQTS9zY2doeG1ocGVlT3NQSEdE?=
 =?utf-8?B?eUVxY09zenpxZ2VZVnd0R3Z4RkVFVXpuSFR0WitRU21LWlNZSTE2amtEenYz?=
 =?utf-8?B?T3Z6cENJYjZlN3VjS2ZtZ2ZRdnRHSjJtS0FkYmNxemZKeGs1RTZzODIveE1N?=
 =?utf-8?B?dmdsVG5DWGR4R2I5Y2N0N2ROc1NQK0owdCswL3RDNEM5UzQwdUZ2V0ZGaDdR?=
 =?utf-8?B?QktGQmw5MVZkcTNyZkZWU1NjQ0VYUmF1Tkl6QURXUlJRVGk3TmtIZE1OdXJ1?=
 =?utf-8?B?Qk9tcGN0SUxOTTBRQm9TTEJ5NGQ0SkdFdWJaajlRd1dtbjRrUGVpNUNwWDhQ?=
 =?utf-8?B?a3dtTmV0aEZQbzZoMlFXUG00cEpyRENBQjQxT0RmKzN4eTlMZ0laR0tkNnpq?=
 =?utf-8?B?bi9ZVjQzZ3M4dHArYzA5VEs4bDBZU2duYnczOTZXOFoxM0x6VERrbithQzgx?=
 =?utf-8?B?ZEh5V3ZFSGJobWZhQVZaMUVFK2xUbjUxakRHcTM1ekVDakF5RFQrS3k4UEw4?=
 =?utf-8?B?RjE1aWlEUCt1Z0kzVGZ5aEFQdU1DWlhoeE9UZlZxT3RQTmF2M3dabUJoWFRD?=
 =?utf-8?B?UlBKdTNYaGpSTTdITkxVV3hUZXZVT21PN0tSb3lWc1VPZXFKYndOSHBuZVdT?=
 =?utf-8?B?VDl2c0ZEK3dTZDV4R3N5dWZ2Ny9PYzMvY1FFcHo0YTI1RGFTc1dLcmE0RU1i?=
 =?utf-8?B?bmNabkxoeDhwUnhKQ3NsOVFYalRSK2lHc3VWWFZ5bUxkaVQxMlZicWlHU2xp?=
 =?utf-8?B?Y0lxTmczNDFKZDdHVEtnYkxHQURZMzdBcGZlNlAxVFdHb0NEZFFPU3ZlMjZy?=
 =?utf-8?B?elFZZFluNmhrbFNudGFTTkNETUJFTTAxaUkwenJIbnp2akNZb3ZZYXk0Q0R6?=
 =?utf-8?B?UEdlZDZVUmtTZlB4MU5ENkgzdVY3THV3V0NXVDdLYVVVcjVBWTBoMmU3ZjBJ?=
 =?utf-8?B?SE8rQnhDN2lyMFJqSmlwTGczSUlJMFBXWmY3Zlp3VVRWR2Q2dVkyakhjRWdR?=
 =?utf-8?B?WUsrZXJoS1dFWmoxYjRTN3NlNEwxd3hLOUg4aXM2NHZ3L1lZV3RMOXVNN0Ja?=
 =?utf-8?B?UldaUkx6ZTVPaHBRM0RZNHBkcXptSTM4amtEdGZEZXN1T0I5QklKUTU0WVlI?=
 =?utf-8?B?T29sbnMrRmFFSG9ueUxjY0RDWXpKb2xsNW9NZW1ja0ZIUDMxRXpjOHpQSito?=
 =?utf-8?B?RCswVXNDc29WcEQ4bktKSzZFSVhteGR5ZWdOOU8veDArR2ZLaE9RbWFETjcz?=
 =?utf-8?B?NFVjMm1iU29DazBpNk1mRTBpdVBmRExvTEo3QWc2em1Yb1lsemV3WjNJdHFk?=
 =?utf-8?B?TXJtZmFEanMyazI5THh1eDl3dHhLWUNCSmdZelo2VXo3c2phSHlSQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FR+bRiWJXujKns+nnV1EZlCfGubprP0/hzPufyesUCCOKtj2Es8TMD0R3uLjfjeqErCXM5uVcw2Ur1jLi2OX5pVjzx4ibj1IPyjLrlcoSGLWHBDhhQFVm7b8z+PE2QoWzaBAEanve8gRYSzb1ReW+STwr/r7RMvic7h3WUjt82nGyph0BvpdBREsSA8/ECaJUleYcUv3t6wyN0za9q0k6cxdGpXS+XWBWBHfWUb4r6j0cUEnShbEc4XtwieY21YDvpjLfdn90O/RysaVUOYMyNpjVwufv9i133VTzfCZxyUvfubnmZ4qKfgIZjbDTjhdTfRbwNbOeR8Ud7fdU5xY4Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6370ebc4-9ef6-4b82-021a-08dedd55e364
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 01:03:28.9517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rsf8TecWXBClBEzA2dtdCfvXOMul2FzmoiT4az/ymwaWB084s5P8azi94NmFGumIuehxo0C/2/Z/tcVCk+j26GawkSr7gx1K2rjwZCQO00c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8453
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUNCg0KPiBPbiA4LzcvMjYgMTE6MjAsIEphbWluIExpbiB3cm90ZToNCj4gPiBU
aGlzIHNlcmllcyBpbXByb3ZlcyBBU1QyNzAwIHBsYXRmb3JtIHN1cHBvcnQgYnkgYWxpZ25pbmcg
U1NQL1RTUA0KPiA+IHBvd2VyIGFuZCByZXNldCBiZWhhdmlvciB3aXRoIGhhcmR3YXJlLCBhbmQg
ZW5hYmxpbmcgRFJBTSByZW1hcHBpbmcNCj4gPiByZXF1aXJlZCBmb3IgcHJvcGVyIGZpcm13YXJl
IGJvb3QgZmxvdy4NCj4gDQo+IA0KPiA+IEphbWluIExpbiAoMTApOg0KPiA+ICAgIGh3L2FybS9h
c3QyN3gwOiBTdGFydCBTU1AgaW4gcG93ZXJlZC1vZmYgc3RhdGUgdG8gbWF0Y2ggaGFyZHdhcmUN
Cj4gPiAgICAgIGJlaGF2aW9yDQo+ID4gICAgaHcvYXJtL2FzdDI3eDA6IFN0YXJ0IFRTUCBpbiBw
b3dlcmVkLW9mZiBzdGF0ZSB0byBtYXRjaCBoYXJkd2FyZQ0KPiA+ICAgICAgYmVoYXZpb3INCj4g
PiAgICBody9hcm0vYXN0Mjd4MDogQWRkIERSQU0gYWxpYXMgZm9yIFNTUCBTRFJBTSByZW1hcA0K
PiA+ICAgIGh3L2FybS9hc3QyN3gwOiBBZGQgRFJBTSBhbGlhcyBmb3IgVFNQIFNEUkFNIHJlbWFw
DQo+ID4gICAgaHcvbWlzYy9hc3BlZWRfc2N1OiBJbXBsZW1lbnQgU1NQIHJlc2V0IGFuZCBwb3dl
ci1vbiBjb250cm9sIHZpYSBTQ1UNCj4gPiAgICAgIHJlZ2lzdGVycw0KPiA+ICAgIGh3L21pc2Mv
YXNwZWVkX3NjdTogSW1wbGVtZW50IFRTUCByZXNldCBhbmQgcG93ZXItb24gY29udHJvbCB2aWEN
Cj4gU0NVDQo+ID4gICAgICByZWdpc3RlcnMNCj4gPiAgICBody9taXNjL2FzcGVlZF9zY3U6IEFk
ZCBTQ1Ugc3VwcG9ydCBmb3IgU1NQIFNEUkFNIHJlbWFwDQo+ID4gICAgaHcvbWlzYy9hc3BlZWRf
c2N1OiBBZGQgU0NVIHN1cHBvcnQgZm9yIFRTUCBTRFJBTSByZW1hcA0KPiA+ICAgIHRlc3RzL2Z1
bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2FzcGVlZF9hc3QyNzAwZmM6IEJvb3QgU1NQL1RTUCB2aWEg
UFNQDQo+ID4gICAgICBhbmQgbG9hZCBiaW5hcmllcyBmcm9tIERSQU0NCj4gPiAgICBkb2NzOiBB
ZGQgc3VwcG9ydCB2Ym9vdHJvbSBhbmQgdXBkYXRlIE1hbnVhbCBib290IGZvciBhc3QyNzAwZmMN
Cj4gDQo+IFNlcmllczoNCj4gVGVzdGVkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQG9zcy5xdWFsY29tbS5jb20+DQo+IA0KPiAyIG5vdGVzOg0KPiANCj4gMS8gSTNDIGVycm9y
cyBpbiBkbWVzZzoNCj4gDQo+IFsgICAgOC4xNTEyMzBdICAxNGMyMDAwMC5pM2MwOiBNSVBJIEkz
QyBIQ0kgdjAuMCByMDANCj4gWyAgICA4LjE1MTQ5OF0gIDE0YzIwMDAwLmkzYzA6IHVuc3VwcG9y
dGVkIEhDSSB2ZXJzaW9uDQo+IFsgICAgOC4xNTE3NjFdIG1pcGktaTNjLWhjaSAxNGMyMDAwMC5p
M2MwOiBwcm9iZSB3aXRoIGRyaXZlcg0KPiBtaXBpLWkzYy1oY2kgZmFpbGVkIHdpdGggZXJyb3Ig
LTkzDQo+IFsgICAgOC4xNTIyNTBdICAxNGMyMTAwMC5pM2MxOiBNSVBJIEkzQyBIQ0kgdjAuMCBy
MDANCj4gWyAgICA4LjE1MjUxOF0gIDE0YzIxMDAwLmkzYzE6IHVuc3VwcG9ydGVkIEhDSSB2ZXJz
aW9uDQo+IFsgICAgOC4xNTI3NzldIG1pcGktaTNjLWhjaSAxNGMyMTAwMC5pM2MxOiBwcm9iZSB3
aXRoIGRyaXZlcg0KPiBtaXBpLWkzYy1oY2kgZmFpbGVkIHdpdGggZXJyb3IgLTkzDQo+IFsgICAg
OC4xNTMzMjJdICAxNGMyMjAwMC5pM2MyOiBNSVBJIEkzQyBIQ0kgdjAuMCByMDANCj4gWyAgICA4
LjE1MzU4OF0gIDE0YzIyMDAwLmkzYzI6IHVuc3VwcG9ydGVkIEhDSSB2ZXJzaW9uDQo+IFsgICAg
OC4xNTM4NTNdIG1pcGktaTNjLWhjaSAxNGMyMjAwMC5pM2MyOiBwcm9iZSB3aXRoIGRyaXZlcg0K
PiBtaXBpLWkzYy1oY2kgZmFpbGVkIHdpdGggZXJyb3IgLTkzDQo+IC4uLg0KDQpUaGUgQVNUMjcw
MCBJM0MgY29udHJvbGxlciBpbXBsZW1lbnRzIHRoZSBNSVBJIEkzQyBIQ0kgc3BlY2lmaWNhdGlv
biwgd2hpY2ggaXMgbm90IHlldCBzdXBwb3J0ZWQgYnkgUUVNVS4NCkN1cnJlbnRseSwgUUVNVSBv
bmx5IHByb3ZpZGVzIGFuIEkzQyBtb2RlbCBmb3IgdGhlIERlc2lnbldhcmUgY29udHJvbGxlciB1
c2VkIG9uIHRoZSBBU1QyNjAwLg0KDQo+IA0KPiAyLyBzaHV0ZG93biBub3Qgd29ya2luZw0KPiAN
Cj4gWyAgMjQ2LjQwNTI5N10gc3lzdGVtZC1zaHV0ZG93blsxXTogRW50ZXJpbmcgZXhpdHJkLi4u
DQo+IHNodXRkb3duOiBwb3dlcm9mZiAtLXRpbWVvdXQ9OTAwMDAwMDB1cyAtLWxvZy1sZXZlbCBp
bmZvIC0tbG9nLXRhcmdldD1rbXNnDQo+IC0tbG9nLWNvbG9yIC0tZXhpdC1jb2RlPTANCj4gL3No
dXRkb3duOiBsaW5lIDk3OiBwb3dlcm9mZjogbm90IGZvdW5kDQo+IEV4ZWN1dGUgcG93ZXJvZmYg
LWYgaWYgYWxsIHVubW91bnRlZCBvaywgb3IgZXhlYyAvaW5pdCBzaHV0ZG93bi1zaCMNCg0KT3Bl
bkJNQyBjdXJyZW50bHkgb25seSBzdXBwb3J0cyByZWJvb3QuDQpJbnZva2luZyBzaHV0ZG93biBj
YXVzZXMgdGhlIHN5c3RlbSB0byByZXR1cm4gdG8gdGhlIExpbnV4IGluaXRyYW1mcyBpbnN0ZWFk
IG9mIHBvd2VyaW5nIG9mZi4NCg0KVGhhbmtzLA0KSmFtaW4NCg0K


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEEDE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 09:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ0sS-0008Sb-2Q; Tue, 24 Dec 2024 04:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tQ0sP-0008Rw-Dy; Tue, 24 Dec 2024 04:06:53 -0500
Received: from mail-tyzapc01on2072a.outbound.protection.outlook.com
 ([2a01:111:f403:2011::72a]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tQ0sL-0006Qf-Mt; Tue, 24 Dec 2024 04:06:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm2r2BLjIAjJQ6Tmclu0gDVFXaaSKKYCHPUqCHvTCi3HCf+RCSeBJPMHNWKpFvdnxCPeOGp4oFVr+3Vj5xeIG595wPf5pGLpThVDOPu0YQ+nEoc/zDvj78pz+pSl1NNv04tzU/gIedee25Bu7kM8y9oeKtXqRTInt9/lzVrfqhTJy4NA2RMuHU2rJWgIDI7hZ0z/kyt5CAOk4D7Z2JGu2GjT4coy0FY1O1r0JN1MJKV8w7uIvOEhLqn7iVn9sbkWvwXEhoxHBiU0RB4A/tqW+qwQ6MLqSVgZhM64az+b0ffVVe53dVA+UCWYApeGdBKEhRwZQN1eD0P0JJUfkZkAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ovnf3UfXna/HHih5z1v7oaeg6GJysjWky+yb9F7rMA=;
 b=ViJ/uKgTcdFgu5JKbZWmSZAhQXxV7qnBiMi8DiiXUZLvTShnLX4jslKkEIJaqHmmejtuOflts5F41Iq7mswwogFsdVCUqvbw6hAR/v2aD6sr9eruGQGP9yGeW+ug+u+Wj3K2h1uhkTygE4aQy5tN2lj/JoyGFoF5gIgfCps9aPdgHWEkrKOeLgwAyHVCfht/djicB8gzxcGtXH7cMpOdCuKi+hS4vTYhNZM6ZmqQN1eTrn1Dg7lxBpF/zA1hX0ck0p+oBmBemgqUCzV50ZagRHDNuEGv8p7ZLgLkcSf4rWA7Kc8uldwA1jLaUiXknfxPp8S59gkM6P/YW54cCu5wlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ovnf3UfXna/HHih5z1v7oaeg6GJysjWky+yb9F7rMA=;
 b=flGl3dMhrU/IPUE/rJWy7yLwS6/2aPEuW8qECFNzfSh5tffxwonEQ1zl69nUhSdZCFUoWhISja13OPvZVax8IDgrpCoyzZXe0RQdof1FdXpd/6FdkmrT74pgrSPwO5qLksJzRfFNswhkoMGqPSQNYzY/N4MSgXYaalasqQjEQx4sOd4SlmIzzRlHMKYt1xY+H+0Uxq8hc2X14uGlIm3GjJhJovZxyPYRx1T0MJE1pCk4zNwvCgoj+3TRZwZ9xdRiXSUl4cMuk0ZA1YQJ/4lO1oAxkhOviIZFDqRF6TJThhCGb0j6va888x/S8N9GItNAuYbRoasCltwC/oafs5sdhg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB6856.apcprd06.prod.outlook.com (2603:1096:405:17::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.12; Tue, 24 Dec 2024 09:06:41 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8293.000; Tue, 24 Dec 2024
 09:06:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 1/3] hw/timer/aspeed: Support different memory region
 ops
Thread-Topic: [PATCH v1 1/3] hw/timer/aspeed: Support different memory region
 ops
Thread-Index: AQHbT4+qBOUi6dL7pkClZmlFP1QYnrL1JnQAgAAAiPA=
Date: Tue, 24 Dec 2024 09:06:40 +0000
Message-ID: <SI2PR06MB5041755E493F5AB6F736438EFC032@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241216075353.1308043-1-jamin_lin@aspeedtech.com>
 <20241216075353.1308043-2-jamin_lin@aspeedtech.com>
 <61cff220-b0f9-4924-80f1-13e6eccbf465@linaro.org>
In-Reply-To: <61cff220-b0f9-4924-80f1-13e6eccbf465@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB6856:EE_
x-ms-office365-filtering-correlation-id: 886b1702-0a3f-4179-6fc2-08dd23fa479f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c0pRRjNlYlhhZDIvTk96MTZDQTloSGcxaUFNWVZnVnR2WFZFYUVmWjlrSGN4?=
 =?utf-8?B?c2thRjhGY256MHhsSzJ0bEFZbXlOTFF1NHZDWmFHYzFyR2JIYUo1MmhvS3F1?=
 =?utf-8?B?NzdmSXJJZVNiUXQrREp2WHl6VERJNDRTemcxcVNzdmZ6a1BXQ28rdjlpeHMy?=
 =?utf-8?B?MkxuN0c5Wnpta2o3VUx4bmY2TjM2SXFRVnpDVlZsSVVvWThyMk41SUwweGxk?=
 =?utf-8?B?MHBjSGNwYVVQUlU1eWQ2c2xxK1JDRHpWUDVDK0FpbU12V3VHMTk5UWo2MVhI?=
 =?utf-8?B?SmViZ3pNNmZRRE10eXVFM0ZNRnEyM3V6cXVqdEh0UHA1aHJCSFppbmU1ckF5?=
 =?utf-8?B?Y3RFNkc2MEovYTM4dTc0UWN0UlZ6dGVMOTdtc0l1bDRTTUtLTDJQZE5DejNy?=
 =?utf-8?B?ZDVubWM2U1BhU1hjSXVscXRMbUFraWdod2VNK29TblFobi94TlFNMjdScWs4?=
 =?utf-8?B?cU1OeXBRd1MwM2d5L2ZMVXk4SnMyTlBrbEdaNkUzYWlnNDUvSmRCa0syemNv?=
 =?utf-8?B?a2JvQ2x4MC9xbXdoeEZoT1NpeEtlaEhVWUgzMWV0cUtVbWw5bTRVdjRMSStG?=
 =?utf-8?B?R2tmWlZsSElrSDMxYnRxV1ZGSEtzOVA1dmNoSHdRc2RBV3QxZ01nZDIvU09y?=
 =?utf-8?B?RVJHWXB4S3dnY0N1Z2lkYjcvNHk3UW56K1RXeUQ1d2kzeFBqS05TdXE2L2lo?=
 =?utf-8?B?OFRyMWdZVGQ4ZzFpc2VuRlZ3RWpSa2tPU2RuRmxiclVVU3krUUU4bU1jQ1Vu?=
 =?utf-8?B?QWxxVEF6ZVlqTUk5MEhYRjNDUk9BajJ4RFFjVUdRY1Bjc2s4bjM0aVgrUUhP?=
 =?utf-8?B?c00rUXZXVlBhOVNHMmxYZzcxRFpNZmFvd1d3b24xVkZLTjJZeUo0QkRELzlF?=
 =?utf-8?B?Um16eC9qSkFjL0xZQ0pNbStrWGI2ZFhoVmlCazBRSmNiTG1EaXdEM2lOSWpX?=
 =?utf-8?B?YkVHaFV4K0llcHBrMFFyZkRHTFcxYTFrKyt4TG8xYVRqdjdpMW9aV1NqQUFw?=
 =?utf-8?B?K1JRLzFRblVDWEFxb294OTVWUTdiZldWR1lMQWp0UmhROUdMYThUMUtiejBr?=
 =?utf-8?B?Y3RVRm9BM09iZktabmlLMGgzbUNQN1g4Ymo0RlVwMUZhNXl6bExtbjNVRmhq?=
 =?utf-8?B?R3FSYU1BTVRJRVVUS0FTZXg3SnF5eWx3VG9HYXVubUZnZHZsaTluZVZHSlpE?=
 =?utf-8?B?dDUrQ2Fqc0JqaXNCM0w4dktOQ0hxMExUeHBFUkcvaVZGbEYyU09mUm56Zm5n?=
 =?utf-8?B?ek1oRFlaaVlEM2o3TTlaN2ZWN1N2MDFzSTZnSVRrMXZpL2hTTW4wZE9iNFli?=
 =?utf-8?B?bnBmdVZlTDNQUWVxQ01BUlk4bmhJamwvdWJPajJxc3hUNmhibkR2UEtkeE9l?=
 =?utf-8?B?OXlYbUVNRnphNmhzMm4xNk91STQveCt2TEFybHJSYWhSeGI1UTRyY2Jibkhh?=
 =?utf-8?B?V0tLYUVLeGcvTms1bjQwQnRCNktLK1FpajlxYUtaaUZpd092c29teW1kRmJ0?=
 =?utf-8?B?ZHVXTDRTL3I1ay85WUpGKytvWnVad3V2cklZaEdZb0ZiZjZrMHR5eERta2lG?=
 =?utf-8?B?VFgxVmNNdjZVQzMvZ0NaczBxS00yS0xEL0RRL2dPWk1NT2hLQnhBV2dCNDQ2?=
 =?utf-8?B?enhiTTEwMjQ5WHd3NjVZYWYxd3Yvdll4T2cwaUhQV1lNRUVUeHg2NlJmYWdr?=
 =?utf-8?B?NEo3MWlTd2U2SEcxcmd1T3pMTEgxR3BsNlRIWjJ2cHV2aFQ3R2I4WWN0a0pL?=
 =?utf-8?B?Y1BFb05tOHp3Rm1WMGhpKzBVdHMwUHFITnhITmNiTXE4RGszdzZiSjJma1F1?=
 =?utf-8?B?SUNoVGVpY1MwbFlGM3hJaHdKWmU0MUlBc2llMkRwUVY2Qy9wajY3RG9mdjlz?=
 =?utf-8?B?VVYzRWpHS0xYTHBlOEVycU5MTm93aHE4ZTYrYVh0ZUhqLzFQNitleHlHSStM?=
 =?utf-8?Q?0HghGEQkYp3MAAeBWEVcQlk0V3+7C29n?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckVTU05PWm0ybFE4V084ZDEyaUJSWUZ0a0NjTFhsNldWeEIwV2VPc2Q0ZzUx?=
 =?utf-8?B?R1NHazZqdGlGMUEzZ3MvUE9XWW95dkFqdjcwS2taK2R3WjVvdGxESlJCMmQ5?=
 =?utf-8?B?MTJ0V2RsSm1QdUlDanRCYzMvWGp2N1dobnZkbFZaZWpscFJZS005MlJYeVdG?=
 =?utf-8?B?Q0pxM0FwVjNVVnRoM2ZJdXZxRStRbUlDdERLTWdkSXNFa2lDanAzRWlrSXN3?=
 =?utf-8?B?QzRBdU5HYTFxa3Z0MzJzSU8xbFAzL1h2SFdrWHVoYUgyVm9tcWFBQlJyaEly?=
 =?utf-8?B?UUJlbTNHVmRyZlFUbW8vem1JUDU1OHdXYUMycGxBQ1l0OVRLMGtOQllReVc4?=
 =?utf-8?B?WVc0ZFRrbFl4RmZqa3hoRjJYeWtrQlV2L05oa0F2L0NKUXVPWWg4QllCVTlj?=
 =?utf-8?B?MG1DOGZFN0tWTjJ5WG81Y3AwTE9FVEJFVlU3YnE2V21WZllTbkJmeHI2ZVB5?=
 =?utf-8?B?K3ZnRHg0RVlkNngzRHJOcklPU2lkeEtjN3Z0Rk5abUZIN202b1cvYURBbzFR?=
 =?utf-8?B?NW8yUmxXdHFXVjRGTmFCU1RzOEpwT0lwUUxYSXdKV09lNkNTVzRoY2J3WWIw?=
 =?utf-8?B?ZHd1WTNCVHJVTElGb2JSOXcwbWFvWE10WHdRanhhYUV6RzJ3NTIzMVc0VmY5?=
 =?utf-8?B?dEZMbFhXRnB5a1NYR3BOYkhWaGd0c2cyQmpSWE9lQXkwQ05aTDUzUkRncjNk?=
 =?utf-8?B?TitBYUYzOE9uM1lmb0cxRW5FTElqbC9pUUx3V1FVdFBhaGJScDlubkpNbTFY?=
 =?utf-8?B?TTc5RzVuSHNTZGlzd0liamtFeWZDL3BiSCs3MG5vVW5obnNob1RCQnBuaWow?=
 =?utf-8?B?UUIrRjQ3OE1HaEptODhjUXNpbEZ3OU9EVzViU1RDMGtoZVZaeVZiNTVXUG5E?=
 =?utf-8?B?NTduYmlyQlQzV2FTZFVudW50MUE0QjlxTGd1RjlBUndFTUpsSWxIWlY4ZS9K?=
 =?utf-8?B?cVNyejBMUmkzbUJyK2hPVS8xK1NlNW5rWm1XdC93V1NlYmJ1SS92cFRja2dN?=
 =?utf-8?B?endtTkRPZWhESjQzck5DM25KNi91VjdpNUZFeSt1R1lYWmQ1N3A3SHNCOUVp?=
 =?utf-8?B?Yjg0K2pNaUIzRGYwdHhtb3JZYytML2w4MUhuanVaMjgraEhPM0Zkais0RWxH?=
 =?utf-8?B?RlpMYjNhdkFjalVhbERaeVBHY0tsUEsvS2Rob2JiWXRCRnBJYnp6V1VnczBY?=
 =?utf-8?B?ZGcwU2NNL0FZTHUzRW5ZbjJYbG81Y3E0ZjBZUXoxWVpvNG94Vy8reFNKK2hN?=
 =?utf-8?B?eEp4NnZiKy81WE5adjdpRDlQMHNRUFVPTmlCc1VhcHMyZHZJOWs2U3ZLVmtN?=
 =?utf-8?B?NUVGeXpGaE52KzhuMUZFOXRWNUJkSE9kblVXdTRDR05Sc1RaZS9pRytyblVp?=
 =?utf-8?B?UDFMays4UCtpMHlnL3VEbWcyeHQ4WW8zd1NGTS9Ma0lKNlAxc01oUFFpWWtL?=
 =?utf-8?B?QmErdUlrTHRHL1RVZDhqazBlNFNwdmZUK2lHcm9yWWo3Y05TSU9nTkdhSldn?=
 =?utf-8?B?WG1BVmRQVy9tRi81UDNlbTdrSjBTMjc4dWlOS1BJbWJPNEFINVF6c0xrVkd2?=
 =?utf-8?B?UVNTQzhVRkxqTGF6NGhWM1lncldVTE1EcXZlSzBCcVRUbGczS1hlTEZkQ2FS?=
 =?utf-8?B?K09CYUNyaHdSdURjMXRyN09sazhjMlJ4ellKT1BIS3J3alA5YlBQd21wWnU3?=
 =?utf-8?B?d0EzeUYwOVJYOS9MRE90WHJqbDdJZHdWay82Nko0TnF2aFJ6UkppY1BlVHJZ?=
 =?utf-8?B?UVJDM2ZNMjVsRG44aWpBVS93RGFySnR0VFRFMVAxQjVvZzZwRU0rS0R6dWFx?=
 =?utf-8?B?WlEvMnF1amdvUHBxNFFBVkNQMnhVRVR5VVVPaHE3UW9uR0N2b3lBVzVMMGpx?=
 =?utf-8?B?ODJYUmU0UG0xeFlMQ1FZazVSNW5CdVl4aUxTYStDeHZUMTZOTTVOS2R5MmNh?=
 =?utf-8?B?eTNDVXlCRGpxd1Vxd3dMSDc0eUhjL0k0QmU3R3lZM0lxN2dYSnN6N1VkS0Q5?=
 =?utf-8?B?TFlhK2UzdUhNcUNraXFSdWVOS0VoZ24yUDlKYmxiN3hxNlB1NThEelFuZndv?=
 =?utf-8?B?dzRLSzVVQUY5ODNLRzNIZlc0U1ZpWkJxVWdFbWh6RlZyb2xBVWxWdTM0elFo?=
 =?utf-8?Q?PwXryIRHPc6Ghj/KmqlisjoIZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886b1702-0a3f-4179-6fc2-08dd23fa479f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 09:06:40.6694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUg6zMRkB1SSOzwsP5aHS/hkNVM356ev/U3qR9y2moChCnqW3w7j8V54EOGCxYwnGizvIGZ5q5/CfMM0PITKFcapKBWD15jZT4C2UvhvOzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6856
Received-SPF: pass client-ip=2a01:111:f403:2011::72a;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzNdIGh3L3RpbWVyL2Fz
cGVlZDogU3VwcG9ydCBkaWZmZXJlbnQgbWVtb3J5IHJlZ2lvbg0KPiBvcHMNCj4gDQo+IEhpIEph
bWluLA0KPiANCj4gT24gMTYvMTIvMjQgMDg6NTMsIEphbWluIExpbiB2aWEgd3JvdGU6DQo+ID4g
SXQgc2V0ICJhc3BlZWRfdGltZXJfb3BzIiBzdHJ1Y3Qgd2hpY2ggY29udGFpbmluZyByZWFkIGFu
ZCB3cml0ZQ0KPiA+IGNhbGxiYWNrcyB0byBiZSB1c2VkIHdoZW4gSS9PIGlzIHBlcmZvcm1lZCBv
biB0aGUgVElNRVIgcmVnaW9uLg0KPiA+DQo+ID4gQmVzaWRlcywgaW4gdGhlIHByZXZpb3VzIGRl
c2lnbiBvZiBBU1BFRUQgU09DcywgdGhlIHRpbWVyIHJlZ2lzdGVycw0KPiA+IGFkZHJlc3Mgc3Bh
Y2UgYXJlIGNvbnRpZ3VvdXMuDQo+ID4NCj4gPiBleDogVE1DMDAtVE1DMEMgYXJlIHVzZWQgZm9y
IFRJTUVSMC4NCj4gPiBleDogVE1DMTAtVE1DMUMgYXJlIHVzZWQgZm9yIFRJTUVSMS4NCj4gPiBl
eDogVE1DODAtVE1DOEMgYXJlIHVzZWQgZm9yIFRJTUVSNy4NCj4gPg0KPiA+IFRoZSBUTUMzMCBp
cyBhIGNvbnRyb2wgcmVnaXN0ZXIgYW5kIFRNQzM0IGlzIGFuIGludGVycnVwdCBzdGF0dXMNCj4g
PiByZWdpc3RlciBmb3IgVElNRVIwLVRJTUVSNy4NCj4gPg0KPiA+IEhvd2V2ZXIsIHRoZSByZWdp
c3RlciBzZXQgaGF2ZSBhIHNpZ25pZmljYW50IGNoYW5nZSBpbiBBU1QyNzAwLiBUaGUNCj4gPiBU
TUMwMC1UTUMzQyBhcmUgdXNlZCBmb3IgVElNRVIwIGFuZCBUTUM0MC1UTUM3QyBhcmUgdXNlZCBm
b3INCj4gVElNRVIxLg0KPiA+IEluIGFkZGl0aW9uYWwsIFRNQzIwLVRNQzNDIGFuZCBUTUM2MC1U
TUM3QyBhcmUgcmVzZXJ2ZWQgcmVnaXN0ZXJzIGZvcg0KPiA+IFRJTUVSMCBhbmQgVElNRVIxLCBy
ZXNwZWN0aXZlbHkuDQo+ID4NCj4gPiBCZXNpZGVzLCBlYWNoIFRJTUVSIGhhcyB0aGVpciBvd24g
Y29udHJvbCBhbmQgaW50ZXJydXB0IHN0YXR1cyByZWdpc3Rlci4NCj4gPiBJbiBvdGhlciB3b3Jk
cywgdXNlcnMgYXJlIGFibGUgdG8gc2V0IGNvbnRyb2wgYW5kIGludGVycnVwdCBzdGF0dXMgZm9y
DQo+ID4gVElNRVIwIGluIG9uZSByZWdpc3Rlci4gQm90aCBhc3BlZWRfdGltZXJfcmVhZCBhbmQg
YXNwZWVkX3RpbWVyX3dyaXRlDQo+ID4gY2FsbGJhY2sgZnVuY3Rpb25zIGFyZSBub3QgY29tcGF0
aWJsZSBBU1QyNzAwLg0KPiA+DQo+ID4gSW50cm9kdWNlIGEgbmV3ICJjb25zdCBNZW1vcnlSZWdp
b25PcHMgKiIgYXR0cmlidXRlIGluDQo+ID4gQXNwZWVkVElNRVJDbGFzcyBhbmQgdXNlIGl0IGlu
IGFzcGVlZF90aW1lcl9yZWFsaXplIGZ1bmN0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
SmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody90
aW1lci9hc3BlZWRfdGltZXIuYyAgICAgICAgIHwgNyArKysrKystDQo+ID4gICBpbmNsdWRlL2h3
L3RpbWVyL2FzcGVlZF90aW1lci5oIHwgMSArDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3RpbWVy
L2FzcGVlZF90aW1lci5jIGIvaHcvdGltZXIvYXNwZWVkX3RpbWVyLmMgaW5kZXgNCj4gPiAxNDlm
N2NjNWE2Li45NzBiZjFkNzlkIDEwMDY0NA0KPiA+IC0tLSBhL2h3L3RpbWVyL2FzcGVlZF90aW1l
ci5jDQo+ID4gKysrIGIvaHcvdGltZXIvYXNwZWVkX3RpbWVyLmMNCj4gPiBAQCAtNjA2LDYgKzYw
Niw3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF90aW1lcl9yZWFsaXplKERldmljZVN0YXRlICpkZXYs
DQo+IEVycm9yICoqZXJycCkNCj4gPiAgICAgICBpbnQgaTsNCj4gPiAgICAgICBTeXNCdXNEZXZp
Y2UgKnNiZCA9IFNZU19CVVNfREVWSUNFKGRldik7DQo+ID4gICAgICAgQXNwZWVkVGltZXJDdHJs
U3RhdGUgKnMgPSBBU1BFRURfVElNRVIoZGV2KTsNCj4gPiArICAgIEFzcGVlZFRpbWVyQ2xhc3Mg
KmF0YyA9IEFTUEVFRF9USU1FUl9HRVRfQ0xBU1Mocyk7DQo+ID4NCj4gPiAgICAgICBhc3NlcnQo
cy0+c2N1KTsNCj4gPg0KPiA+IEBAIC02MTMsNyArNjE0LDcgQEAgc3RhdGljIHZvaWQgYXNwZWVk
X3RpbWVyX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwNCj4gRXJyb3IgKiplcnJwKQ0KPiA+ICAg
ICAgICAgICBhc3BlZWRfaW5pdF9vbmVfdGltZXIocywgaSk7DQo+ID4gICAgICAgICAgIHN5c2J1
c19pbml0X2lycShzYmQsICZzLT50aW1lcnNbaV0uaXJxKTsNCj4gPiAgICAgICB9DQo+ID4gLSAg
ICBtZW1vcnlfcmVnaW9uX2luaXRfaW8oJnMtPmlvbWVtLCBPQkpFQ1QocyksICZhc3BlZWRfdGlt
ZXJfb3BzLA0KPiBzLA0KPiA+ICsgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZzLT5pb21lbSwg
T0JKRUNUKHMpLCBhdGMtPnJlZ19vcHMsIHMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFRZUEVfQVNQRUVEX1RJTUVSLCAweDEwMDApOw0KPiA+ICAgICAgIHN5c2J1c19pbml0X21t
aW8oc2JkLCAmcy0+aW9tZW0pOw0KPiA+ICAgfQ0KPiA+IEBAIC03MDgsNiArNzA5LDcgQEAgc3Rh
dGljIHZvaWQNCj4gYXNwZWVkXzI0MDBfdGltZXJfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xh
c3MsIHZvaWQgKmRhdGEpDQo+ID4gICAgICAgZGMtPmRlc2MgPSAiQVNQRUVEIDI0MDAgVGltZXIi
Ow0KPiA+ICAgICAgIGF3Yy0+cmVhZCA9IGFzcGVlZF8yNDAwX3RpbWVyX3JlYWQ7DQo+ID4gICAg
ICAgYXdjLT53cml0ZSA9IGFzcGVlZF8yNDAwX3RpbWVyX3dyaXRlOw0KPiA+ICsgICAgYXdjLT5y
ZWdfb3BzID0gJmFzcGVlZF90aW1lcl9vcHM7DQo+IA0KPiBTaW1wbGVyIChhbmQgc2FmZXIpIHRv
IGluaXRpYWxpemUgYSBjb21tb24gZmllbGQgb25jZSwgaW4gdGhlIHBhcmVudCBjbGFzcywNCj4g
dGltZXJfY2xhc3NfaW5pdCgpLiBPdGhlcndpc2UsDQo+IA0KVGhhbmtzIGZvciByZXZpZXcgYW5k
IHN1Z2dlc3Rpb24uDQpXaWxsIGZpeCBpdC4NCg0KSmFtaW4NCg0KPiBSZXZpZXdlZC1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiANCj4gPiAgIH0NCj4g
Pg0KPiA+ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF8yNDAwX3RpbWVyX2luZm8gPSB7
IEBAIC03MjQsNiArNzI2LDcgQEANCj4gPiBzdGF0aWMgdm9pZCBhc3BlZWRfMjUwMF90aW1lcl9j
bGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCj4gPiAgICAgICBkYy0+
ZGVzYyA9ICJBU1BFRUQgMjUwMCBUaW1lciI7DQo+ID4gICAgICAgYXdjLT5yZWFkID0gYXNwZWVk
XzI1MDBfdGltZXJfcmVhZDsNCj4gPiAgICAgICBhd2MtPndyaXRlID0gYXNwZWVkXzI1MDBfdGlt
ZXJfd3JpdGU7DQo+ID4gKyAgICBhd2MtPnJlZ19vcHMgPSAmYXNwZWVkX3RpbWVyX29wczsNCj4g
PiAgIH0NCg0K


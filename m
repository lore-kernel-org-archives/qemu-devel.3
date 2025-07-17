Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAFBC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 05:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucH4i-0008TT-Ak; Thu, 17 Jul 2025 01:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucH4T-0008L7-Bt; Thu, 17 Jul 2025 01:22:20 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucH4Q-0007MT-Jj; Thu, 17 Jul 2025 01:22:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jF+bmq2BnS7AfCUHdGd9abCrw7z9jsok8I6X0tQcH7YUerDElldU5Dx4pptURN+RqQWQbiCWGPMiOSakrs4xRLmYs3KDkNNjI1P4Ae09J4YoO8rPEAjuzV6CdnvidX8UmiOgHS7Ie3XS/3gXzqng9oh2C+1OZKCGQy/uv1JwhtCZXSL6zOQ+8HuhOon4A19+Ylg7Jn1Iv8jD2z4fdGCatCx9wlufbSDjxHYLaTg03BMkYQfCSgjTJmR6auk97c6+g3saXyto8RxWGHNj16qjWrmvWvcIjS/GTnE98KdiYwmdU54LULrLyAmX+ufE1aYzqL0NeBC9uXz2xxRVDNWRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ7SnFQuIk7GtaBkmNW85bUnSkYYzQUf1XbI8RzBtgI=;
 b=p0WGxOD/J2wPr4Fikqq3+wOdROP/Fseewv29wUUvM1xLdi/edaody98dbwMmS1f/L9I0ojyCQ0/j4Rxg/oOfu7fTVBLKW8idnpMn6kLaeUa2KUAce4XZXQst6RiU1VlqDnLfjnuUo5Qh0UJoWkr77QI6x92VJSZTNNdbBCVKtZEP7oJphxw8Sotp5ha+0cIZOI+0f3MIJYsFK8Dl39x6YxrHJBce1Vn/Mho8gbAxH9DyuLf4HyoHQMoXiDvXIQBq79SQ+h8fjF+zXoeC9343tehMFft2KegJ1YkeG/yMt6hc/TBzz0LQW2I+Ojtppv6/BDyq0JQq4vwLXCxTwqk2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ7SnFQuIk7GtaBkmNW85bUnSkYYzQUf1XbI8RzBtgI=;
 b=Fy5/WLrj0EzyFAgxEFRAtmhwL8KHVcz/i4aMhnjAXkR2BuBhMOP288cTF1P4nvWR/j++ZAzSQFcBHGhms7YZ0X1zKp4EFTXYVbyyBKGighUBGskKq1qECxOa8csdSKzIpAo1OSJuLPjKe+NRDTsodPNi3W84VQA37Lh7TFrA7NM3uNTHimysffsD2wURKcDS5lGnoVEKTirD9dByvICOfj2fGsLfMAGiluTan+iYstyDMXfWz9S7/+vhc2BnBusp7o7vprI38j7gBW1hi3NKkSzgpbE8IFTukpeQUXgdxJ6c+Dldz0mTda9/qlK22D0iO+r+45tLx6uxsQ9Dpj8t4Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6933.apcprd06.prod.outlook.com (2603:1096:405:3d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Thu, 17 Jul 2025 05:22:01 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%7]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 05:22:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 00/21] Control coprocessor reset for AST2700
Thread-Topic: [PATCH v1 00/21] Control coprocessor reset for AST2700
Thread-Index: AQHb9syffCgYMZVyM0y3Vig/XB6jBrQ1xuqg
Date: Thu, 17 Jul 2025 05:22:00 +0000
Message-ID: <SI2PR06MB5041EF8157EC8B272FD67E83FC51A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6933:EE_
x-ms-office365-filtering-correlation-id: 1903052f-a396-4da7-5692-08ddc4f1dbbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N1VrYlNobzJCUEUyNHZpazNXZXhGOEdBZ2RXVmJhbTlKUExNNENRZzJ5aGlR?=
 =?utf-8?B?Um5wTmN0Q0FSM2R1dnhqWUhvK1dZOVRpSzNnT1MzSXpIUEZ6Lzg4cUQwdnA4?=
 =?utf-8?B?QjA0M2RWZlRwVFpmQTl4L1ZXU05POFFHeTBhMWJOanF4VkRZNlJuZFhiQ3B4?=
 =?utf-8?B?a3ZuOElSWm5mSDd1bElZcmpoTkIxRlF1UDR4MGJ6WjlWTy9zZzYrSXdWeXBw?=
 =?utf-8?B?ZUE0ZnA3WUFSakZ1emQ5OHlhUE9vbnZWYmtkdlhsbjZyMDBrNHlYeWdNM0RN?=
 =?utf-8?B?L0dxWi9SWURhNWdJdSt4VnJLRUU5WnVXWVM2ZGJ4R29DZlpzS1BBS3E3K2lK?=
 =?utf-8?B?cDdROFQ3d0hEYlN1NWgvU1BWWFR4cjh5R1AyUzExTS80aDNwQVg0djUvUlVE?=
 =?utf-8?B?cEF3MlJYMzVUK3BwbGFBRzErUzhuOFB4VXNJSnBQYnZEOU8wYmV3ME5IN0pC?=
 =?utf-8?B?WWtIU2ZsSC96WXJVaFBWWHRSQTVzMkNaaHAra0wvYnIxQzBBYWFBRlBBUS9I?=
 =?utf-8?B?Mlcva3d3Ly9jaDlsWC9zUDd4c3BMSm1zR2pqeDdwZEc1cWRzTk5pbDM0VjZw?=
 =?utf-8?B?Y3Q3R3JkU0hycnprR2NTMkNYSWVtc0NDZFNiM0tjUVBrb2RzR1JMeVVNcEl6?=
 =?utf-8?B?NjM3VHRZbUw3aTBmS0QranU0MkViWnNJMmpveENaNUEzdnEyemk2dWNNMDBN?=
 =?utf-8?B?WTVwcWRTSENzY1MxbGhtcE51L2dYL3lISjFSY3FRM0hWZDMvQnc3ZGxwdUdE?=
 =?utf-8?B?eURjMFBxZExYVHpRbm12dlptUk9PbWk5NjMva255SnN0THpNcnhNM1B2Mm5v?=
 =?utf-8?B?NGlKLzVKbExzTVcxbjlvcEUyT3hEcDd0QWJLQkRhR1NHbjhtUStVRFNEK3RF?=
 =?utf-8?B?WnQ3NG55N2szTjNlN0gwS2VjZkVEY2RCSmx2VTRDeWllMmI1a0crQ2g4ejAz?=
 =?utf-8?B?Q0tyWCtIZHVQbDc0SloxQVFKQk1KN0YzMEE0azdBUVdVekhqL0RvVGZpR1Fl?=
 =?utf-8?B?V3dLWVBBdEFLQVRhbzFvSW9RZUROOGlnT0F4bGFGdDkybGZzaGxkUFl0d2dU?=
 =?utf-8?B?a2dNRFRzMFBwZndXQWFYSlExUXhlQ09ibEkreFdWQk1PM0FiNC9NR2FHLy9x?=
 =?utf-8?B?U3dLVWRNUkU3Y2d0bUZxMVJuL3oraXQydFIvN0EzSTBaL0kwN1NNSFllbFJZ?=
 =?utf-8?B?dFFjczJkUWFPTmdSdWJFQzU1Z0lyYWw3SjYxMTRkaFp3eUJPaG8vZFZoYlh4?=
 =?utf-8?B?Q1ZWN1FCeHVCN1BqNXozdExOREJSRGxLdWQwSEM2eC9wQ1VhNGpjdG40akVN?=
 =?utf-8?B?c2V4REErb0hidmxyOHA4UE0wekk2NS9TSlBwZVdaR3R3MW9wd0dNbmx1RG1n?=
 =?utf-8?B?RWoyVzAwTFg1WXZFQ0VocXBMWkZtRnc0bmppRUxqMzBndEk4SHNNUzRqNS9w?=
 =?utf-8?B?Vkt5enVwcy9SaDR0Mm1NcHJoejJwZkJLVUpDbTg0OG9LakwzdkFUemVRR3R2?=
 =?utf-8?B?bUkvc2FLZ0NMNmNDUEU1MzA1Z2Zsd1hsZThyeUp5SjRXeDZGc3pscnNMZ2ZS?=
 =?utf-8?B?Wkl1Tktvd2RsMkM3ZWFnUnlPdzg1QjZJSjJKcm1lTzJVT0p4c2U2d0ZDaFNV?=
 =?utf-8?B?ZUpGeVhJNENKVmMzVVN2MDB6WDVKd3FqajllS0Vxc0Q0cGMzWHpLS1BTZGFC?=
 =?utf-8?B?SWRvbzNJZWVwOElHSEtqTUN3KzhubzJCR3pTS2t0S0dMQUV1cXdmZ1o0ZDAy?=
 =?utf-8?B?RjBiMzQ4WTlDamMwcWV1QVpuZ0hWRTJGR3JDV3llSlJtNWFTZHgxUFBKUlIy?=
 =?utf-8?B?WlJsbUFJanNITlVzeHFxRXlObU9FdmprN25XUlJ2Y01KeGNnVVptSm1TLzVX?=
 =?utf-8?B?WW9odktRdktKdm5xUmJKY0VkK09tdkRwa1NBaHpqRVBSSkRSc2d6TTNpVWc1?=
 =?utf-8?B?dG9YUFdmWEF1L3JESlBrTlV0Vkh6YnAvaXVIVU1mT0ptaGFGRzNkaWRmUDJZ?=
 =?utf-8?B?aG5xOFF0cjR3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUlKa2V6Zmk5VVpDdDdWblU3Y2RQSlBhaWFsS29UcHhGYTYraHcrcU4yeURh?=
 =?utf-8?B?aW9uZEZWWG9LdklOTjN3Q3pqVndkNFloT1lLWW1iY0NIUVhzazJBWmh0azdX?=
 =?utf-8?B?YXBLRTZKc0lVUlFrRDlONTh5TTc5RU85MkJmbUIxakZxa1hjdjV5bUptTE1p?=
 =?utf-8?B?TnIxejdBOUcvQVk4R25SRmtOQk0wQ2czTFl5eFh1Yjk3S25lb3RpVWlrdHJF?=
 =?utf-8?B?L25OMHRVUGc5VVU3cWFtbmFtQWJkQnBubXNNQy9wSUR4ZU1sa1IxRm1vK1RY?=
 =?utf-8?B?REs2OE9CcjJnZk9CUi9aTHNwNk1kUjFwa1ptaUpoT21aMTl3cm42WFlHM0RR?=
 =?utf-8?B?VW90bzJCTnhhVG5GRFg2NG8zY01pdVBoQzEza1UrNU5HNDVhSjVxVTN0NVp3?=
 =?utf-8?B?YjUyZU5zejZ0bmRIRHlndzBmZDNnZVJyNGN5am4rNS9UTGw5VkRKTHBKem0r?=
 =?utf-8?B?K2dhV2owMlBWTzRRQ3luY1p3TGxiN09MQmZkQnFtZUUzNnIvdndnWDNwZUNM?=
 =?utf-8?B?eUppS0JEL2RqQWRVK2d3NG4rb0tjMHl0cmMyMG9kRWlEWGlhUXZ4TXFBOE9i?=
 =?utf-8?B?bjZmd2NOc1lzNWwwVEIxZXNLTGNaMnZ0aVN0aHU3eTdWWmwrR282M1plZVov?=
 =?utf-8?B?REJMY1hPOUhqVytnU1NLWW51RG90WUtQNFVCMW1sMDFVVkd3bDViVE4zanZG?=
 =?utf-8?B?V2JKZnpIQXZIQkZqNEVFK3JqVldBbUxrSTJqVVlBaUhrcmUzNlJkYTgvNW8y?=
 =?utf-8?B?TXFOakY3a1dCSlNqN3JMMTA4SlMySldXdnA1a1ZNSDZ4Tys0NUlZc3BVSlFx?=
 =?utf-8?B?TjNReGlpUzllWTFyS0ZPUThTR21HUVRiODY5RlBUOTM4b0tzSEE0eFNvODJN?=
 =?utf-8?B?a0NTMWJnd1FDRlFGK1QrcTc5Q0FKSjdSSXpNQlJuamdSTFJFNEdpbUlTeXVl?=
 =?utf-8?B?cEJSakhYbDZyNHNGTTVTeGxlYWZxZGJhOVM0Uzhmb1REcy8xVmZ2cnUyMmdi?=
 =?utf-8?B?d1UwTGVzVHZFMWs0TGYzbTNaQm12UWMyWGJJVHB6WDFXWWIrU2lFVkQwR3lK?=
 =?utf-8?B?K0lvc0N2OVBTaFJIcTJtZndFMFBkTVp4bXMreEJWMjZyOFEybUJ4WWtjZFEz?=
 =?utf-8?B?cm9DNVo2LzlDaUluZFQ3anVxWkFhNEhnOHlCKzVnK0Y5ODZxQnlQeVFxSDN5?=
 =?utf-8?B?b0FJNHE4Ry9veHEzNmNrcmo3U2dyYllXK1hVSzMvaTBqS1dRMmt0RStyenFB?=
 =?utf-8?B?MFV3b0NXODdJVU5ycVFPSUttNHM5aEdMdDRXWFRYaUY2WGpFZWlNaEJsMGlt?=
 =?utf-8?B?NjRpb0dwTFRxYzZieDduaFRoUXU2eWRaSjlGTWlFWk5GQU9hRDBEYksxaFgv?=
 =?utf-8?B?Wkhva1JGVEZCMkNKUUtSY0hEdjZWL1FHd1BPS3hEMyt3UXFmMkJnWElqTi9C?=
 =?utf-8?B?VTBwR1dpZ2hEc3JKSTVBN05pb3k2bVJEZ2xvL0d0ZVF2aWJ1eDhXRUhEcjJn?=
 =?utf-8?B?WXFiM2Z3ZkNFQ3BEZWUyR2cwVjFiaDRvdVp6U0NHekJOdGR0Vys2eTBrUVlL?=
 =?utf-8?B?WGlFeXhRcWNKZUN5emxrYXorMnJFUzJTeU1jUy9FVk5GL3I1SEhsL3g5cEFS?=
 =?utf-8?B?SHpHWkx4RmhrbGtpZHFDRWxYR0JDbUtYNlp0bDZhc3ZVc3VwQUpHcWlDVVNm?=
 =?utf-8?B?dzUrZXVDRU9Cb3VPZnBWU04yUXBGUjh2L2ovMkltVGFIWElMU1l4Y3VES3Yr?=
 =?utf-8?B?alRlOW5mUnZzV0FqMm8xdUhjL0tISzRxVlhVTHNPd3Q0b1U2RGtSODk4TGlz?=
 =?utf-8?B?Q0lEY0ZKaWh2Z05tQ1dOdG1Hb2p3dERBSFBVeklibUM1Qm5yamRZTE5ZcHJJ?=
 =?utf-8?B?L0hLNHF6Y0ZDNlZ2Y2JoN0lqVEdEV0lia0NXNUhvVmNkQ1JMWWNyblRhb0xt?=
 =?utf-8?B?eUZ0TEh3eGp5anZpMHp2MzA2QVZUM0FtYzJXVmhwc2xEb1I2aHM1Ti82NUpi?=
 =?utf-8?B?UmpNUWpIVVA0UW5PendQaWFXdWNVQUoxZEpBc2M0MEJtYVNwdDBuTjEvRjNk?=
 =?utf-8?B?WlpKaG5QK0laZVA0bnB4ZGhTbTJXRjVTWitrSk8vMlBjTXNpY2dpOXVPclll?=
 =?utf-8?Q?OHRZOpThQ/WzIHZ/yfU1EC1Om?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1903052f-a396-4da7-5692-08ddc4f1dbbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 05:22:00.9070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yjQFztyBQgKuQ1upW5zzIFr5WS+/cvilLxOCNOutt6c25gUraFnkkd9doDVA9WSW0OVYeR3vI0sxRdJYEZsmJ/c0b+gsS7BxWw6jqyHzk4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6933
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

QWxsLA0KDQo+IFN1YmplY3Q6IFtQQVRDSCB2MSAwMC8yMV0gQ29udHJvbCBjb3Byb2Nlc3NvciBy
ZXNldCBmb3IgQVNUMjcwMA0KPiANCj4gdjENCj4gIC0gQWRkZWQgc3VwcG9ydCBmb3IgVmJvb3Qg
Uk9NLg0KPiAgLSBNb3ZlZCBjb3Byb2Nlc3NvciBpbml0aWFsaXphdGlvbiBmcm9tIG1hY2hpbmUg
bGV2ZWwgdG8gU29DIGxldmVsDQo+ICAtIFVuaWZpZWQgU0NVIGNvbnRyb2xsZXJzIGJldHdlZW4g
UFNQIGFuZCBjb3Byb2Nlc3NvcnMNCj4gIC0gU2hhcmVkIHRoZSBzYW1lIFNSQU0gYmV0d2VlbiBQ
U1AgYW5kIGNvcHJvY2Vzc29ycw0KPiAgLSBTdXBwb3J0IFBTUCBEUkFNIHJlbWFwcyBjb3Byb2Nl
c3NvciBTRFJBTQ0KPiAgLSBBZGRlZCBzdXBwb3J0IGZvciBjb250cm9sbGluZyBjb3Byb2Nlc3Nv
ciByZXNldCB2aWEgU0NVIHJlZ2lzdGVycy4NCj4gDQoNCkxvc3QgdG8gYWRkIHRoZSBmb2xsb3dp
bmcgaW5mbzoNCg0KVGhpcyBwYXRjaCBzZXJpZXMgZGVwZW5kcyBvbiB0aGlzIHBhdGgsIA0KaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAyNTA3
MTUwNjE5MDQuOTc1NDAtMS1jbGdAcmVkaGF0LmNvbS8NCg0KUUVNVSB2ZXJzaW9uOg0KaHR0cHM6
Ly9naXRodWIuY29tL3FlbXUvcWVtdS9jb21taXQvZjk2YjE1N2ViYjkzZjk0Y2Q1NmViYmM5OWJj
MjA5ODJiOGZkODZlZg0KDQpKYW1pbg0KPiBKYW1pbiBMaW4gKDIxKToNCj4gICBody9hcm0vYXNw
ZWVkX2FzdDI3eDAtZmM6IFN1cHBvcnQgVkJvb3RSb20NCj4gICBody9hcm0vYXN0Mjd4MDogTW92
ZSBTU1AgY29wcm9jZXNzb3IgaW5pdGlhbGl6YXRpb24gZnJvbSBtYWNoaW5lIHRvDQo+ICAgICBT
b0MgbGV2ZQ0KPiAgIGh3L2FybS9hc3QyN3gwOiBNb3ZlIFRTUCBjb3Byb2Nlc3NvciBpbml0aWFs
aXphdGlvbiBmcm9tIG1hY2hpbmUgdG8NCj4gICAgIFNvQyBsZXZlDQo+ICAgaHcvYXJtL2FzcGVl
ZF9hc3QyN3gwLXNzcDogU3dpdGNoIFNTUCBtZW1vcnkgdG8gU0RSQU0gYW5kIHVzZQ0KPiAgICAg
ZHJhbV9jb250YWluZXIgZm9yIHJlbWFwIHN1cHBvcnQNCj4gICBody9hcm0vYXNwZWVkX2FzdDI3
eDAtdHNwOiBTd2l0Y2ggVFNQIG1lbW9yeSB0byBTRFJBTSBhbmQgdXNlDQo+ICAgICBkcmFtX2Nv
bnRhaW5lciBmb3IgcmVtYXAgc3VwcG9ydA0KPiAgIGh3L2FybS9hc3QyN3gwOiBBZGQgU1JBTSBh
bGlhcyBmb3IgU1NQIGFuZCBlbnN1cmUgY29ycmVjdCBkZXZpY2UNCj4gICAgIHJlYWxpemF0aW9u
IG9yZGVyDQo+ICAgaHcvYXJtL2FzdDI3eDA6IEFkZCBTUkFNIGFsaWFzIGZvciBUU1AgYW5kIGVu
c3VyZSBjb3JyZWN0IGRldmljZQ0KPiAgICAgcmVhbGl6YXRpb24gb3JkZXINCj4gICBody9hcm0v
YXN0Mjd4MDogQWRkIFNDVSBhbGlhcyBmb3IgU1NQIGFuZCBlbnN1cmUgY29ycmVjdCBkZXZpY2UN
Cj4gICAgIHJlYWxpemF0aW9uIG9yZGVyDQo+ICAgaHcvYXJtL2FzdDI3eDA6IEFkZCBTQ1UgYWxp
YXMgZm9yIFRTUCBhbmQgZW5zdXJlIGNvcnJlY3QgZGV2aWNlDQo+ICAgICByZWFsaXphdGlvbiBv
cmRlcg0KPiAgIGh3L2FybS9hc3QyN3gwOiBNb3ZlIERSQU0gYW5kIFNETUMgaW5pdGlhbGl6YXRp
b24gZWFybGllciB0byBzdXBwb3J0DQo+ICAgICBtZW1vcnkgYWxpYXNpbmcNCj4gICBody9hcm0v
YXN0Mjd4MDogQWRkIERSQU0gYWxpYXMgZm9yIFNTUCBTRFJBTSByZW1hcCBhbmQgdXBkYXRlDQo+
ICAgICByZWFsaXphdGlvbiBvcmRlcg0KPiAgIGh3L2FybS9hc3QyN3gwOiBBZGQgRFJBTSBhbGlh
cyBmb3IgVFNQIFNEUkFNIHJlbWFwIGFuZCB1cGRhdGUNCj4gICAgIHJlYWxpemF0aW9uIG9yZGVy
DQo+ICAgaHcvYXJtL2FzdDI3eDA6IFN0YXJ0IFNTUCBpbiBwb3dlcmVkLW9mZiBzdGF0ZSB0byBt
YXRjaCBoYXJkd2FyZQ0KPiAgICAgYmVoYXZpb3INCj4gICBody9hcm0vYXN0Mjd4MDogU3RhcnQg
VFNQIGluIHBvd2VyZWQtb2ZmIHN0YXRlIHRvIG1hdGNoIGhhcmR3YXJlDQo+ICAgICBiZWhhdmlv
cg0KPiAgIGh3L21pc2MvYXNwZWVkX3NjdTogQWRkIFNDVSBzdXBwb3J0IGZvciBTU1AgU0RSQU0g
cmVtYXANCj4gICBody9taXNjL2FzcGVlZF9zY3U6IEFkZCBTQ1Ugc3VwcG9ydCBmb3IgVFNQIFNE
UkFNIHJlbWFwDQo+ICAgaHcvbWlzYy9hc3BlZWRfc2N1OiBJbXBsZW1lbnQgU1NQIHJlc2V0IGFu
ZCBwb3dlci1vbiBjb250cm9sIHZpYSBTQ1UNCj4gICAgIHJlZ2lzdGVycw0KPiAgIGh3L21pc2Mv
YXNwZWVkX3NjdTogSW1wbGVtZW50IFRTUCByZXNldCBhbmQgcG93ZXItb24gY29udHJvbCB2aWEg
U0NVDQo+ICAgICByZWdpc3RlcnMNCj4gICBwYy1iaW9zOiBVcGRhdGUgQVNUMjd4MCB2Qm9vdHJv
bSB3aXRoIFNTUC9UU1AgU0NVIGluaXRpYWxpemF0aW9uDQo+ICAgICBzdXBwb3J0DQo+ICAgdGVz
dHMvZnVuY3Rpb24vYXNwZWVkOiBSZXBsYWNlIG1hbnVhbCBsb2FkZXIgd2l0aCB2Ym9vdHJvbSBm
b3INCj4gICAgIGFzdDI3MDBmYyB0ZXN0DQo+ICAgZG9jczogQWRkIHN1cHBvcnQgdmJvb3Ryb20g
Zm9yIGFzdDI3MDBmYw0KPiANCj4gIGRvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0ICAgICAgICAg
ICAgICAgICAgICB8ICA0MSArKystDQo+ICBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmggICAg
ICAgICAgICAgICAgICAgfCAgNDggKysrLS0NCj4gIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2N1
LmggICAgICAgICAgICAgICAgICB8ICAgNCArDQo+ICBody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMu
YyAgICAgICAgICAgICAgICAgICAgfCAxMzMgKysrKysrKy0tLS0tDQo+ICBody9hcm0vYXNwZWVk
X2FzdDI3eDAtc3NwLmMgICAgICAgICAgICAgICAgICAgfCAgNDYgKysrLS0NCj4gIGh3L2FybS9h
c3BlZWRfYXN0Mjd4MC10c3AuYyAgICAgICAgICAgICAgICAgICB8ICA0MyArKy0tDQo+ICBody9h
cm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAgICAgICAgICAgICAgICAgfCAxODgNCj4gKysrKysr
KysrKysrKysrLS0NCj4gIGh3L21pc2MvYXNwZWVkX3NjdS5jICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDE5NA0KPiArKysrKysrKysrKysrKysrKy0NCj4gIHBjLWJpb3MvYXN0Mjd4MF9ib290
cm9tLmJpbiAgICAgICAgICAgICAgICAgICB8IEJpbiAxNTU1MiAtPiAxNzE5Mg0KPiBieXRlcw0K
PiAgLi4uL3Rlc3RfYWFyY2g2NF9hc3BlZWRfYXN0MjcwMGZjLnB5ICAgICAgICAgIHwgIDQ3ICst
LS0tDQo+ICAxMCBmaWxlcyBjaGFuZ2VkLCA1NjIgaW5zZXJ0aW9ucygrKSwgMTgyIGRlbGV0aW9u
cygtKQ0KPiANCj4gLS0NCj4gMi40My4wDQoNCg==


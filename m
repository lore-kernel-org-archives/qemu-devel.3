Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A484C282D1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 02:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqNNt-0002aM-3r; Thu, 06 Mar 2025 21:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqNNp-0002a4-6R; Thu, 06 Mar 2025 21:24:17 -0500
Received: from mail-sg2apc01on2071e.outbound.protection.outlook.com
 ([2a01:111:f403:200f::71e]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tqNNm-0002nt-5r; Thu, 06 Mar 2025 21:24:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoKB6itmf/WNm0jcmN3HJw6OQA8bkYG+1Z8pvwz9OS1bZzi1IWGH4a6A/oVSlPvPHAa9BpWc5lSC2HHiJqkuYmzeuqxZW44cZTyxUSZVoPbXGd76U5H649hJ8wgiwyPf+vxNrAfoQvyc0UJoBXv5iFC1GqSaq77iOhKpXyMCnGZAlhT7HX7kY6kS9vXTHFoyfVovcxqxNs3NWro/YvJhzDJ2oc0C/AsE0ZVxODUZgrn5bYXLCBl3OubPlf5i6j8iNasbVZd5x6GN3o60yec56d9CQqDemQidJAokredEM3MtNrgm/SEqdMsLsGNNoJ8vtKcj3JDBhyCodqe/8hOnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/SbK+hu4imH7jHxDZy2BcPH6pDmrukinpkT7BhQfwI=;
 b=wAh8NYcyPjAueoQnhkAZSx/KYREZrbMKOHlihUBp6OQHwkBkHYEM1YjGy/aqS/ri69qmQZzH5hez1N62S+Wfpr3q1fVhcPHIpxrSOMvM3yUlKdLIygi93Je6fm9fGZyFXn6gc6HXeT8b7SfcBPvo0cHjjiEJoaSoqlukpyNHlfOi0KkbsWE0o7yc6AcZle802rsMEAU1yWs/077aTLqPyFZbMoDjpTe1dkNsKbnlEsLVftkzKwL7PPPmt6TQquOJjtWLhqYNvW2zRGDv35tWklblSiEFIHQzg+Z88rSFNvgLEHsrwBw6zvpMo6wPIlXGLm+FcbmijHa6LiyQr9g3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/SbK+hu4imH7jHxDZy2BcPH6pDmrukinpkT7BhQfwI=;
 b=b6x61q9KFVBBBwj51Peesvetx7sNtlE+9P96x6K5NqCRXwsgoWzDwPU+lGIl5msfAVsJkcjAvAB2ce+az0uOba+6+esrflOxeXWXcwFPkk1Se16qXtxQlCbbmmWkf0jbvp6m9CVUghKDA82r4+kqxHhfeFVbNK+uFKAaSx8JnKvC4gJuP6L9e0GxdnOAl+94+EwFMw/tZEcCZDl7jOSctNQIjBJB93a1j/pXDFk0A8AwoZ/e4hat+i0ZO74/EVF3i1rE9OdJufAJjGWy5Ulo6SjRigFFuRQJXcaVlCxQi/hEmFlLDFHp6rW5jm9+Eznmno/rtcanfpLFBYWiSFndXQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5271.apcprd06.prod.outlook.com (2603:1096:101:7a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 02:24:00 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:23:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v5 03/29] hw/intc/aspeed: Introduce dynamic allocation for
 regs array
Thread-Topic: [PATCH v5 03/29] hw/intc/aspeed: Introduce dynamic allocation
 for regs array
Thread-Index: AQHbjoP2Ig3bO+uZ9kaSEF6HNWvNQLNmOj6AgAC4LUA=
Date: Fri, 7 Mar 2025 02:23:59 +0000
Message-ID: <SI2PR06MB50418AFD6A6EAEC67FB84993FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250306103846.429221-1-jamin_lin@aspeedtech.com>
 <20250306103846.429221-4-jamin_lin@aspeedtech.com>
 <30a760c0-db9e-4d5b-a41c-f11ad1451f3c@kaod.org>
In-Reply-To: <30a760c0-db9e-4d5b-a41c-f11ad1451f3c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5271:EE_
x-ms-office365-filtering-correlation-id: 6e2289f4-63f9-48c6-c075-08dd5d1f1eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3djU2xOQzI3TVJMOTFTaUVEZ1AzNVhvTllZbFJsV1E2QU8xaXlrVmlrNjJo?=
 =?utf-8?B?L2FXYjZtN3JYbnBFTmY1REw4TnJXNWNXM2dyU0ZXdEZmNUxyMlE5NHV5eDMy?=
 =?utf-8?B?TlBXV2dRUFViYzVPcnVvMkxITkhQc2xMdTVkVVNqUEpPNTEzVUIwSHdYRlgx?=
 =?utf-8?B?WCtzNSt1U3NRRmZsYXF3QXRqMHdyR283dkIxVnJ3clVKcmVQRUZSbFdOMW5N?=
 =?utf-8?B?YkFaYWdQUzNreHhSSjdXWTRCYlZyT2haY0hzbXhPZlU5MnM4S01vSm9qZDdS?=
 =?utf-8?B?NS9KeW93Ym1yOEhIQS9RdGNUcFlxTk5xNkdMK1dkbmlCZWxqM1oyTnlEc3A5?=
 =?utf-8?B?UGtycHlzKzJ6bVhpMlhvZnIrSzJmVVdPOVhCeDFjZEVJTGpBcGpEWThuajBZ?=
 =?utf-8?B?K1hveFRNZExuMWgvRy9oRFJMYTdZMU1qY3MzeXB4QUk4dk1JR1dhSkNYOGRl?=
 =?utf-8?B?WFQwMWdaNnRZb3JBanJ6MkFpakQzUHh4T1J0ZlZ2RWdrbithSmtLeTYvcStQ?=
 =?utf-8?B?R0RGQmZrNVhGeFdFWTlIV1JRYU1XWEwyM2ROMm9QeEZRbldEMDBJUFd5cm5a?=
 =?utf-8?B?Q0hMOGFOUmE3VE1jL1gzZ0xrcWRVWERjdk9hbXBheUYrZjlJOWdiMlJYTkJY?=
 =?utf-8?B?U2U5d3hzYXQ2dDlwSHlGbHBUcDZzYVB5R2JsTHBqbUFaRUdFN2FZTHo3T2NN?=
 =?utf-8?B?UkQ4WFFmK2JiUzdGQUFNNk5sak5NWU9xcnpvRk8yUnN0eUhvaDRtTTcxaW5t?=
 =?utf-8?B?VEJsNEc2bW1UL0J5Z2l5a0szaFBwdWJ4WC8ybVNGc2I3NDVGdnVybFUxdGhV?=
 =?utf-8?B?ditUNXNvS3ZWamZWMXptelROYWFqMlhuTnE4SEtSY0xwRXIzS1A0QW9GeFM5?=
 =?utf-8?B?VlBTMUJVYnFlWmlnV1k3Sld1eVpvZWtaU29uWU1qVGV4TjBuVnAxbHJ6emkw?=
 =?utf-8?B?MENOSmRtYzk2SGdGekhHSzZCZmtzZytMZEVsSUNwZjQ5VVRiaGFWSmZJSGdX?=
 =?utf-8?B?K3ozd3ZKbDBOWFdrVGtscHJnTXVGaVhyc0draWFEckpXNXYvMTYwUmxmN2NL?=
 =?utf-8?B?ZXV6ME0yUGdwK0RpWXc4b0VQMktKVDQ5UTQ5amM0TXd3OTlWMkVOc3RwcmxG?=
 =?utf-8?B?WUhNckdDZk9KNUo0eVRaZFY3WHhkVmVMbzdaTXNsdDBXbUg4MkFrUVk5YzZ0?=
 =?utf-8?B?d2FIK0k3KzMwZXFLaEpIRzFFZnAxZzN3Y3hjaDFPNVlHc25PMTdRYUdSUjMv?=
 =?utf-8?B?R2VCb1llckxSTkJRZTgvUmprOFpDSXBra1ZKTzJKRUZDd2o4YkN6R3NRZjRu?=
 =?utf-8?B?SkFFdmxkQkRZaS9nL3V2ZXRsakhHZTZsMTcyWWxNWGM2Q05xRDMvZ3dqc0dV?=
 =?utf-8?B?eEM5NTVmb1lrTFg0L3RNZC9mdTEyL0lLa2VtQ2tPT080VUxTN1JyWFJ6RExx?=
 =?utf-8?B?OGxzNGM2eXdQU0lkeG9ZMDlQSDR6bThsZGl3WFp3RS9IZGZlaTRSYU1idEdh?=
 =?utf-8?B?UTZuczdncllhb1dMV3BzbmFnckV6NkxRZ0ZJMGVGeGNzaTEzM1BGNGNFdUdx?=
 =?utf-8?B?d1cvK096VEZhNkJEVVdQNlorc05zWUJzY29CbzJuNVFmMWlyamwzN3cxaVgx?=
 =?utf-8?B?OFU0cVRQMk5CRzVPdHpPdU1ra1Qwa1Y4MjJjbnA1eGtzdnNnMHN6YUdMcFBR?=
 =?utf-8?B?ZGorMlFCa3B0dW1HUFUvcUdSYmp6a2NidTN2ZlpBeVhiR3JjRkxnWFdPYnkz?=
 =?utf-8?B?ZFZvRDgxWHdCYnNZYW51NE0zSkZIVUN5cVNqbnJtZUNpNExhK2tGWFo5RVRG?=
 =?utf-8?B?enFKbnYySm0wcHlPOUlZR0FGaG53OGtVcTk1aDRub3hYaVVqdWYxSzA1U1pM?=
 =?utf-8?B?MjR4ZFJCL25PaFZyRWNpMWFIZ0U3RHdVNU9xWkt5MStnY3ZaYjJMQWs1Mmoz?=
 =?utf-8?Q?U8TBcJaomZP3vm/utwCL7bH6W/5N9lOd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elQya1NHd0pvaG9YWWJENjdFdEkybm5jNk1ncForeWE0UTREQVVFaGxja2V3?=
 =?utf-8?B?UVF4TXRtWXdzU2RxeThVT1JGT0oxMmVjQlMzcnFTUStaT3VsTG9qelpYcTZS?=
 =?utf-8?B?bVUxSng2blJOeFZNbGhsVnIza1VsVWhsWVlocWc0eTdxay83T3UyRWNjejlZ?=
 =?utf-8?B?Ny9OTHJTb2cyeGdmL3dsbnpVQkhvU2kzS21oTGJVY25hcFZsK0JZc0dqNE9o?=
 =?utf-8?B?aWlEdlYxeUlpYUNFekNZOE5peGthMm5oUnl5T1JsclV1S3hSc0xNTWQ4SkdC?=
 =?utf-8?B?U1VxN0xHcVNHaG44TGVNM21OZDVSai9yeW4wY1N6NUlTeHNZSnpQZUZxSmd1?=
 =?utf-8?B?Sk12dWZ6L0RRUjErYTBmUU41dnBkOEpMODdoZFU3YVovdFpDakJldDRPTGRN?=
 =?utf-8?B?a0NsUlV1VEpiVm5yYWNLQlFYSWlRc01DTFhndlQyYnRnUkkvZmwvcWJ0SGtY?=
 =?utf-8?B?NFhFVGR0SXRmZmJXR3NpcXEvell0RkNwaFRlREVoTW9oSmdGZ0IwZVRmU2x2?=
 =?utf-8?B?aW0zdVJSdXE1ay9JYm1IT1FoTnN3ZXlHWlpRemdSNDB1eG5oWitZYzhSUExz?=
 =?utf-8?B?M0xQVlQ4aTBKK0xFM0UxK1NKRHJmRC9ScVJOL1J6dmtCcit3RndiNzZUL3Av?=
 =?utf-8?B?VG5kK0tJTmxLT0xFcm1qUjdkK3g1RU9NTk03aTc2ZjF5RzVwUXJMRlRTNTBh?=
 =?utf-8?B?VjBGdjc0bGViRjlPQmduaUsxT3JiZ000QVdMejF5Wmttd0hFVkxKTml5SEFi?=
 =?utf-8?B?a2R5SmszQTJ1cy9LTHA5K1lQTGFCbUhLNVlQVE9KREJIeTFQMDY4Rnp5eFRQ?=
 =?utf-8?B?WFVUekUrYXNRQll4R2g5RTJQNFZ4aXJaWmFtakV0UVhkTnUvVmt0Ri9ualJF?=
 =?utf-8?B?S1JYaVRMeHJteEs1M1FvREIvakU3b1c2MWZ1ai9TaUNGaEx0WllUOW9hN2Mv?=
 =?utf-8?B?dEkyVDVzb0hRdm5qOXI5SDllTTRYZFU0OFpOTHNreDlUSlFGdW9BUmVBYndz?=
 =?utf-8?B?QkZhTHo1am1xV0xTeDZ3dlU3T3VMYUxvMXFwTnBpVER1Yng5ZkNGd0w1a1VL?=
 =?utf-8?B?MXB2WEhodk44MWdqRHV4c2dHOWFRWmI0TzJTV1hxNGJTcWZDNEo2dHB4ZGIv?=
 =?utf-8?B?bUF5YlJMWENuOEwyOU5nbDhTK0s0ZmowUGVIc0RQd2YvZ1BJV1RyMXJ6SlIx?=
 =?utf-8?B?Q0h1VnJvcStlMzh5bGxKN0dPZnRjUCs4bVJVV0dQN241Mm83WUpkTlM4Sjhz?=
 =?utf-8?B?MnlsdHpEU2VzODErbTFzeHhJYThYY1VhU2FWck9ScGkvNzc2Nll0eVF5U3VV?=
 =?utf-8?B?VEpZZFJ0eWRIN3hueENTUlJQNkFQeUJRVG9EZUFtSkhwc0t3b3N2b1hLTXFM?=
 =?utf-8?B?dXhBUDZvaVFoY0FZaTBKYmpyVzEvMklwWjVCU1VkSTc3MkxiUkRVWWppRVZ4?=
 =?utf-8?B?REpDc1JBRkw5a21vWFBSdloxNlJ3eDNzdnVSWm11M3A1dFIwQ0dIMG9XaFBw?=
 =?utf-8?B?R21BVk9Sd29FbVJKV0tzTkFtVzQ4UzhtemdhTTBWeU9XZktaYmVRVVNZZVdV?=
 =?utf-8?B?Z3ZqbnZ4blMxWDAvSU9lVXZaZmY2RXNhU1hCcTZNcGV2OGNOY2RpVWdlRkh1?=
 =?utf-8?B?WGMxNHF2Mk9PUDh1ejN4L0xUSmx6bWRoeVJnMUROOXBLREY1YmxzTTdqMmph?=
 =?utf-8?B?QlVpQ3BkSmtUb1lnRFAzOCtJdDg0WVJHV3VDY1A3WFNFeitEby9iVmlMSmZ0?=
 =?utf-8?B?R0NoQ2hrbTNOZHJUMkNFOEs4Uld0NktjWFFncHAzNXdHcStMVHFIdENDUC8w?=
 =?utf-8?B?aTNVUkF1UnNnVmV1NitnV053WWN1d1BXMXJIazlWV2Q0LysxalhMSzNJbHds?=
 =?utf-8?B?K2hiV0xIeFQvcWN0ZG93VVpxTjNFTXRQNWVCeWNXQXhERVRlcmZiVHFNVi9Z?=
 =?utf-8?B?dlZPZHprZjJlNlVzNkRuUDhXVS9EUHkxOE5XU1c2NWErOG5udEdkZ05mS2p3?=
 =?utf-8?B?eisvdFhOeGJtWXdKaTJGUU5PWWpKNUJlUzIrTHAvRXA3dmp0dXhyYzVmMkJr?=
 =?utf-8?B?aUJTb2h3dGlmVjk4ZU9QUEJQNmJBOXJ2Z05HUWRUdGM5ak1YT245WW9XWU5x?=
 =?utf-8?Q?TOHVShuZCW/rhWA6dMtsJze0V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2289f4-63f9-48c6-c075-08dd5d1f1eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 02:23:59.6818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orzn5DFIoYecKP06v/Z/G2SaDvZqjda+etO2gOR+soNWzoS1gpClLiGHXmy5Kz4s7ehDFBG3Yo1usRRObVffMAMNVR5W+pLcxHtXoYNxLps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5271
Received-SPF: pass client-ip=2a01:111:f403:200f::71e;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAwMy8yOV0gaHcvaW50Yy9hc3Bl
ZWQ6IEludHJvZHVjZSBkeW5hbWljIGFsbG9jYXRpb24NCj4gZm9yIHJlZ3MgYXJyYXkNCj4gDQo+
IE9uIDMvNi8yNSAxMTozOCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEN1cnJlbnRseSwgdGhlIHNp
emUgb2YgdGhlICJyZWdzIiBhcnJheSBpcyAweDIwMDAsIHdoaWNoIGlzIHRvbyBsYXJnZS4NCj4g
PiBUbyBzYXZlIGNvZGUgc2l6ZSBhbmQgYXZvaWQgbWFwcGluZyBsYXJnZSB1bnVzZWQgZ2Fwcywg
d2lsbCB1cGRhdGUgaXQNCj4gPiB0byBvbmx5IG1hcCB0aGUgdXNlZnVsIHNldCBvZiByZWdpc3Rl
cnMuIFRoaXMgdXBkYXRlIHdpbGwgc3VwcG9ydA0KPiA+IG11bHRpcGxlIHN1Yi1yZWdpb25zIHdp
dGggZGlmZmVyZW50IHNpemVzLg0KPiA+DQo+ID4gVG8gYWRkcmVzcyB0aGUgcmVkdW5kYW50IHNp
emUgaXNzdWUsIHJlcGxhY2UgdGhlIHN0YXRpYyAicmVncyIgYXJyYXkNCj4gPiB3aXRoIGEgZHlu
YW1pY2FsbHkgYWxsb2NhdGVkICJyZWdzIiBtZW1vcnkuDQo+ID4NCj4gPiBJbnRyb2R1Y2UgYSBu
ZXcgImFzcGVlZF9pbnRjX3VucmVhbGl6ZSIgZnVuY3Rpb24gdG8gZnJlZSB0aGUgYWxsb2NhdGVk
ICJyZWdzIg0KPiA+IG1lbW9yeS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaW5jbHVkZS9ody9pbnRj
L2FzcGVlZF9pbnRjLmggfCAgMiArLQ0KPiA+ICAgaHcvaW50Yy9hc3BlZWRfaW50Yy5jICAgICAg
ICAgfCAxMiArKysrKysrKysrKy0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2lu
dGMvYXNwZWVkX2ludGMuaA0KPiA+IGIvaW5jbHVkZS9ody9pbnRjL2FzcGVlZF9pbnRjLmggaW5k
ZXggMDMzMjRmMDVhYi4uNDdlYTA1MjBiNSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2h3L2lu
dGMvYXNwZWVkX2ludGMuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvaW50Yy9hc3BlZWRfaW50Yy5o
DQo+ID4gQEAgLTI3LDcgKzI3LDcgQEAgc3RydWN0IEFzcGVlZElOVENTdGF0ZSB7DQo+ID4gICAg
ICAgTWVtb3J5UmVnaW9uIGlvbWVtOw0KPiA+ICAgICAgIE1lbW9yeVJlZ2lvbiBpb21lbV9jb250
YWluZXI7DQo+ID4NCj4gPiAtICAgIHVpbnQzMl90IHJlZ3NbQVNQRUVEX0lOVENfTlJfUkVHU107
DQo+ID4gKyAgICB1aW50MzJfdCAqcmVnczsNCj4gPiAgICAgICBPcklSUVN0YXRlIG9yZ2F0ZXNb
QVNQRUVEX0lOVENfTlJfSU5UU107DQo+ID4gICAgICAgcWVtdV9pcnEgb3V0cHV0X3BpbnNbQVNQ
RUVEX0lOVENfTlJfSU5UU107DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvaW50Yy9hc3BlZWRf
aW50Yy5jIGIvaHcvaW50Yy9hc3BlZWRfaW50Yy5jIGluZGV4DQo+ID4gNDY1ZjQxZTRmZC4uZmVi
MmM1MjQ0MSAxMDA2NDQNCj4gPiAtLS0gYS9ody9pbnRjL2FzcGVlZF9pbnRjLmMNCj4gPiArKysg
Yi9ody9pbnRjL2FzcGVlZF9pbnRjLmMNCj4gPiBAQCAtMjg5LDcgKzI4OSw3IEBAIHN0YXRpYyB2
b2lkIGFzcGVlZF9pbnRjX3Jlc2V0KERldmljZVN0YXRlICpkZXYpDQo+ID4gICB7DQo+ID4gICAg
ICAgQXNwZWVkSU5UQ1N0YXRlICpzID0gQVNQRUVEX0lOVEMoZGV2KTsNCj4gPg0KPiA+IC0gICAg
bWVtc2V0KHMtPnJlZ3MsIDAsIHNpemVvZihzLT5yZWdzKSk7DQo+ID4gKyAgICBtZW1zZXQocy0+
cmVncywgMCwgQVNQRUVEX0lOVENfTlJfUkVHUyk7DQo+IA0KPiB0aGlzIGlzIG5vdCB0aGUgc2Ft
ZSBzaXplLiBzLT5yZWdzIGlzIGxhcmdlciB0aGFuIEFTUEVFRF9JTlRDX05SX1JFR1MuDQpXaWxs
IGZpeCBpdC4NCj4gDQo+ID4gICAgICAgbWVtc2V0KHMtPmVuYWJsZSwgMCwgc2l6ZW9mKHMtPmVu
YWJsZSkpOw0KPiA+ICAgICAgIG1lbXNldChzLT5tYXNrLCAwLCBzaXplb2Yocy0+bWFzaykpOw0K
PiA+ICAgICAgIG1lbXNldChzLT5wZW5kaW5nLCAwLCBzaXplb2Yocy0+cGVuZGluZykpOyBAQCAt
MzA3LDYgKzMwNyw3IEBADQo+ID4gc3RhdGljIHZvaWQgYXNwZWVkX2ludGNfcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ID4NCj4gPiAgICAgICBzeXNidXNfaW5pdF9t
bWlvKHNiZCwgJnMtPmlvbWVtX2NvbnRhaW5lcik7DQo+ID4NCj4gPiArICAgIHMtPnJlZ3MgPSBn
X21hbGxvYzAoQVNQRUVEX0lOVENfTlJfUkVHUyk7DQo+IA0KPiBwbGVhc2UgdXNlIGdfbmV3KC4u
Li4pDQoNCldpbGwgZG8NCg0KVGhhbmtzIGZvciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpKYW1p
bg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPiAgICAgICBtZW1vcnlf
cmVnaW9uX2luaXRfaW8oJnMtPmlvbWVtLCBPQkpFQ1QocyksICZhc3BlZWRfaW50Y19vcHMsDQo+
IHMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfQVNQRUVEX0lOVEMgIi5y
ZWdzIiwNCj4gPiBBU1BFRURfSU5UQ19OUl9SRUdTIDw8IDIpOw0KPiA+DQo+ID4gQEAgLTMyMiwx
MiArMzIzLDIxIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9pbnRjX3JlYWxpemUoRGV2aWNlU3RhdGUg
KmRldiwNCj4gRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgIH0NCj4gPiAgIH0NCj4gPg0KPiA+ICtz
dGF0aWMgdm9pZCBhc3BlZWRfaW50Y191bnJlYWxpemUoRGV2aWNlU3RhdGUgKmRldikgew0KPiA+
ICsgICAgQXNwZWVkSU5UQ1N0YXRlICpzID0gQVNQRUVEX0lOVEMoZGV2KTsNCj4gPiArDQo+ID4g
KyAgICBnX2ZyZWUocy0+cmVncyk7DQo+ID4gKyAgICBzLT5yZWdzID0gTlVMTDsNCj4gPiArfQ0K
PiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIGFzcGVlZF9pbnRjX2NsYXNzX2luaXQoT2JqZWN0Q2xh
c3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPiA+ICAgew0KPiA+ICAgICAgIERldmljZUNsYXNzICpk
YyA9IERFVklDRV9DTEFTUyhrbGFzcyk7DQo+ID4NCj4gPiAgICAgICBkYy0+ZGVzYyA9ICJBU1BF
RUQgSU5UQyBDb250cm9sbGVyIjsNCj4gPiAgICAgICBkYy0+cmVhbGl6ZSA9IGFzcGVlZF9pbnRj
X3JlYWxpemU7DQo+ID4gKyAgICBkYy0+dW5yZWFsaXplID0gYXNwZWVkX2ludGNfdW5yZWFsaXpl
Ow0KPiA+ICAgICAgIGRldmljZV9jbGFzc19zZXRfbGVnYWN5X3Jlc2V0KGRjLCBhc3BlZWRfaW50
Y19yZXNldCk7DQo+ID4gICAgICAgZGMtPnZtc2QgPSBOVUxMOw0KPiA+ICAgfQ0KDQo=


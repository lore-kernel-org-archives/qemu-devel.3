Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144BBCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszxJ-0002vy-Ft; Mon, 01 Sep 2025 04:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uszxH-0002vd-BI; Mon, 01 Sep 2025 04:31:59 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uszxA-0003Xs-OW; Mon, 01 Sep 2025 04:31:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZCis7f+5KvrO14yvnmZr7WX+nSkqOmVT7EqF0wlGlVZxo74Gb3+Lyt8RAHsUgYWZmH/vivNjzANuV3OrLRZ4X7St8leOrlXkUwUIuITmHtHbonc2zOEeMgmOMMMs9iH5H5uVE5aR08v3JlZwEWM9Obb/8AQmB/scwND3Y1mzj2ClvzLhZ5b1L8pgiAmk4Jdro0e7nzQ01KWT51/VsnAp4atBFshKzOOhYtJnlOy1l6lhC52F16SGthyqre+/tgoODXEzUJUyv+7PqseU4GSFqtwpPZ90xshg/nYbQ0/68eCY755im2DI8Da3o6s28eZNetKkGrm+RI1ROCGUYoFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI4ZerTIe48tiHkJslxYT5CJPUe8BPWIh5oNncvEKl4=;
 b=XyqQFaTx+uSB7CAOwuQfcXO+RYjdtPuz4rlNEydy/3ZGPPTWgUyVGVj6mOLtHrzbRPEzmkjbG6hULbZarOGvWFzq2Sh4MLvHEFXb0lFFF/vYwPkS745OQTgycWF0SPjBcbin9ShcYNyP3QTbhOguJgbfR41sGaFWRiJiW8oUWHBoRTEs0/EmpjGoUFi+v1N60NQUzRVsqJsDnQmRSLL/Szsl4BLMAq+czRGUn3+F7sGvlcCh9i9NGANhCGpqCusLIULDrDX1kxe1ZKOF10nL/PPt9KRBwbmCuWPOhdYSwIvt6lAAOeqBEAcLmceBSmjyXNgZU5GKHlAZoSubAqYf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI4ZerTIe48tiHkJslxYT5CJPUe8BPWIh5oNncvEKl4=;
 b=YNM8fhcx/ZTDCYah1MhbL22W3XBtMyXcYSmjcawR6P5aj8GZxyd2xwt/TUSINPTjAnwmrtlj6Cb+kfgheXjC5RS1CDN7bCxzNYBRJJHh8qjEThjXB4fmKtFgowBvyVf0HjORp7oCgbnlUduMS+KtlEJKTiAyK85ZK4s77kbrJAVzAK+Ho/wlWUAc5+tI+UfJBia3NrMWz/sH0JSz1WriH3nGmjECEYtqhrYz+a5ojDdayD4dGm4JrSST0gLec6a2ilvk8snw33CdqhIiK9achu6X49Z8c8voQwrAUMX+32sn1eVa6H82eYex6Auoi1az1JVuC9OFSg6jQEutTUpdkw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6282.apcprd06.prod.outlook.com (2603:1096:400:429::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.26; Mon, 1 Sep
 2025 08:31:39 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 08:31:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "reviewer:Incompatible changes" <devel@lists.libvirt.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 1/4] hw/arm: Remove ast2700a0-evb machine
Thread-Topic: [SPAM] [PATCH v1 1/4] hw/arm: Remove ast2700a0-evb machine
Thread-Index: AQHcGvYKNV0nep3MIEq1vnVqt4wgfLR9/skAgAAAkDA=
Date: Mon, 1 Sep 2025 08:31:39 +0000
Message-ID: <SI2PR06MB50414E9A2DB62809B5887DE1FC07A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250901040808.1454742-1-jamin_lin@aspeedtech.com>
 <20250901040808.1454742-2-jamin_lin@aspeedtech.com>
 <a735659a-5a1c-460d-826c-4978dc22a865@kaod.org>
In-Reply-To: <a735659a-5a1c-460d-826c-4978dc22a865@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6282:EE_
x-ms-office365-filtering-correlation-id: 185c3da6-cac5-4d1b-420b-08dde931f8e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|13003099007|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?MDBaaExHVi82aTU5ZGVReHVwTEhuOTFpZURXclV5d1VKYXpmOGFlY1psWlVR?=
 =?utf-8?B?d20zY1c4MzNiVE5kbXo1cTd0djBkamQwKzJhcjBlWFhCYVpjQmZaZ081SWxa?=
 =?utf-8?B?YUEyNlVoalhwL2tlMEFIeUMxQnE3SWFxWHBnRzVFVTVXcEovcEpFQjMxMDdS?=
 =?utf-8?B?VkRpRFhvc3FrZEM3Sm9QNGU2LzVqNXIwQ29ZVUVkRDQwUjF3eU1EaU9NTlhp?=
 =?utf-8?B?VlJjK2JVMS9ybk4yNkRBM1Y4ZjhLV0g4cEhDcWtLMG05bFZWT2FSbWNRQVN6?=
 =?utf-8?B?bzc3a2Yyem9ySnJwR0tZdXErN3hsU3pkNk02ZVViNVo3VUo5NGsyWFB5bjVX?=
 =?utf-8?B?dmlHdi9aNlBkdlA2d0IzSlN2LzRpdkpYTE44anE5NlQ0TWlablNhOFdXVGM2?=
 =?utf-8?B?V0pMQXF1cSt4SUx4KzdLbThEOXN1MGswYWhSZ2lYMlFlbVA3WDN5bEhYVTgr?=
 =?utf-8?B?c25LYzV3Y254ZTkyNEZNMDU5eU9qZ3MrcnBKT2xnN1Jxb2N2RjVkU2JYakFZ?=
 =?utf-8?B?dDh5OS9PWEFLS3JqZXMxOC9uc2RGaTIwU3MwcXdUN0pMd2xLcldxRWxNWXU1?=
 =?utf-8?B?S29UbzZtME91S2VaaERCc0pXa0pCdTNvR3BKWXg2Y05IRURKWXRBa1dSaXBW?=
 =?utf-8?B?OEg3b2d2N0ltcTZBVVNkWnpidk5yd0cvaFpqSkdOcmRJR3BxaDRmSFhQTUx6?=
 =?utf-8?B?b3pDWkNpcUE3a2J0QzVHM3ZWTFpmOWhvZ20vUUthUXdBc0dGenpudnRzdHNy?=
 =?utf-8?B?dHZ2NzZZaW9hYmxQSDlseStBWGFMcE9WK2tZSUh5d0VWWnBqZTBBVHE4L1JS?=
 =?utf-8?B?U2VVMWtVaVM3WU4rTU1saXhkSm40K0NDZFlDKytXdWRFU1d1R0hyV0tRTVBp?=
 =?utf-8?B?N3FKTktab2VCbENFTFp0bi92MnppelloTlVCb1c2SzhGT3c5RDVPaUx3R3BT?=
 =?utf-8?B?Uzc5Yjc0MUFUZUhTUUp1ZDViQzRIVTV6RTNzM2k4MTh1RWVFYVN4OGMzaFpx?=
 =?utf-8?B?YmI5cFBYOGlndFZMcWdWR0JORUNrNFA4VGVGNXR3Vm13NnBuUlFXOU9ISU9G?=
 =?utf-8?B?VHN2bm5qeUhrS2U1NGlEZ2FMZmhNNnBCakJjellEQXByUlBFNVdJY0FUODlL?=
 =?utf-8?B?dTVKNGQybUgyWWFvQ1NMUVlIL095QUx4cHppSmEzd3Fyb0hOSkpYVCtKdm1Z?=
 =?utf-8?B?VjJvZFdBRjRZbjZDSm53N3VielZaTldzWkpseEovTXlwNllTVDhrZXpMTHBk?=
 =?utf-8?B?RFBEdFIxZGxkQmVEaEdxNEMvdTdoK0RQa094STA4aExZMXRDRDFPL0lrZUkv?=
 =?utf-8?B?MmhaVm8rMHkrTnFJdjl3L2ZIbjFhcGNhK2Y4VUFWRm42dGdTUVl6VFJxNXRz?=
 =?utf-8?B?K1NYN242c1NVNU5KcGxLYmFoSFA4ZS9pUThXa0xjdmhZK0RPSkhJdlh1R3lQ?=
 =?utf-8?B?Q2c3Q3BnYXZQclQ1bEFkeW9IQXVScHBIYVQ2K1FVeG44Um5ldkFrS2JPUDla?=
 =?utf-8?B?c0lXREF2R2U0cHQrUWM2S0p1VDlMZFVRSUdUNitBMjlCMCtsczZmWjl4Yk0x?=
 =?utf-8?B?Wk4yaUpLWlJWUkY3NmYxQ2k0dnVGa1JHYUo3ci9oV2JoUFE1ZWlDQll0LzlJ?=
 =?utf-8?B?TW9VTGlQdFZKSTQxUG9NaXdzNVJUVENjK3R5RkZjdTFQdlNSS2dXdDdTVllp?=
 =?utf-8?B?YUZXeXVQOUVmeDN3bGtya1NsTlVBVUZWSGhKQjNmVmx2NjI2Z1ZxQzU0YUtB?=
 =?utf-8?B?aHRHOGxzTXBLOWV4endEc3R4Mm9IWUduc1QyZHRlcHQ5bUJBZENJZUZUdXdY?=
 =?utf-8?B?MExaVWFSN3pZYlZQRllGMlVhNXpBNENLbUx0ajg3UEQrdG12U242aTFaQ3lN?=
 =?utf-8?B?U245WGgwRkprR1o4OE1rUUVSbTVBd245YjFUTEQ2U2lrZ0hVdEswUno3OUhJ?=
 =?utf-8?B?cEdhRzl6NWhsMVRHb3F4anF1S1ZwSDhnNndTSDVaUC9hQ3h3VnFWdTJKVkFm?=
 =?utf-8?B?c3FKeUFtNFMwWUNoMUoxREdPdlRqK0FDTWI1Um05eFVOaG9QYmFjamVnejVx?=
 =?utf-8?Q?YPDeYB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(13003099007)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkpxd1c1WE0yTXNjQy9VVGYwVHl4MFp5dzJmc3JtcWVjME1GakVzcDQrQmxI?=
 =?utf-8?B?dDFhTFRoWmRuM2pBSDZmS24xZ2hrOWRwOEloU1YyeTBrS2YwTjVPREEwZlVo?=
 =?utf-8?B?SS9FSVNzVURXaG9CWnJHU0ZFNW9nd1pkZGwzVUZ4U1oyWjdXNjFmdHA5aUdw?=
 =?utf-8?B?aThvbjk3ZytLOThqcHM2aG94cmlEQ0h6QXRNZVdFTi9mRHordFdJMjJJNU83?=
 =?utf-8?B?eVU5Qzh1UlNPbjFyOG9BaUdvOXppMFpKK2JBSFpaMmtOR1d2QnBnZTZEdHd4?=
 =?utf-8?B?eUwvUjl1L1U2R3l2Q1J2Rm9HRDFmMkF2d296WmdxZVV2aDUyWXlpSzdJckRD?=
 =?utf-8?B?cUJFZ1BUMGFNVjVmcXlPbmd1d3o4ZW9yVmtCSFpiTUhvMTNHamtqWmdmQVpY?=
 =?utf-8?B?d243QjlPNUpMQ3czTlk2Sk9Fc1hUY3BsVzUxSXEwYUNvRndPZENRNlI0WE5C?=
 =?utf-8?B?RFJxMk5LUTJpYklEc1lqSXZUcDBCUGdRTVJoNnMwS3IwUjluclY5NGxIQXdT?=
 =?utf-8?B?eFR3STJWSEVaUDBTb2ZDSGJvdTJWUWt0eE1oNzZ4TTdvZXk5TkdiYXZDTGNl?=
 =?utf-8?B?MERIN3l4OCtSUmxtYisyRnRReFVsY0lSalR1TmFqT3lsQXdpeHN6VENTRUVJ?=
 =?utf-8?B?YUtnZmNDNFRyMk9DSFgyb1NPYUxUZjlreUhSN1BCSEhXajBlVEV6UzRjQnBn?=
 =?utf-8?B?bWdWK0dhN2JuTFRDeE1SWEZpR2d4S1IxWi92aldabjJKU2lxNVdmOXkzd0JI?=
 =?utf-8?B?RTdVRkNtWUFNNWFJcEVMVVY5ZDY4N0dNUlhtbE1xK085aWxYaldmeEE2U2Vy?=
 =?utf-8?B?UUxqc3IwV255UHBHMjQya2xBSWRsUVYxNkZzV1J4bVlGR1VTcWtFVnI5YmtK?=
 =?utf-8?B?UVNzSm9jQkxzV2ovZHZ3ZWdXSWN3Ni95NWZ2R011Yk9kUFRVUWVuMFA4c2lu?=
 =?utf-8?B?OXlWOVNNMElkRUo3VFp2ZDdidjVUWjJ6OHVkODBYZ0htd2dMdXRLQjF4NDQ2?=
 =?utf-8?B?MlJUSnNFSHJYWW51SlZVSzJEZ0pxN0k3TENwajQ1b0NNRDlnYmF5eU82eDB5?=
 =?utf-8?B?QzVRaFM5R0pGK3NyN0pFSlZlMnJFRUhrYlhWSGhGNG53WnB1WWx6QXJmMXIw?=
 =?utf-8?B?dC9Zc3hjTzF1c0xORnBWckQxMXozYjFDVUJjZ1I3Vnh5ZHlxKzVlVFU1Qit5?=
 =?utf-8?B?L3J5cWs5SWgwd09HUlYvSWlUdTZaY05ZNytha1lCOFVXZ3NSeWJVVlRtekph?=
 =?utf-8?B?azY0RlhRZ1dxdnd3dzJtejJqRzBQRWg2NkxpaVBScDNEYUg1YWZRcEh4MC9r?=
 =?utf-8?B?dHNsdWJ6eWhTUlQrV1BtOUowOEh0MkZ4VzczaCthUWR5d1E4RUUyZjhrYmV2?=
 =?utf-8?B?VExvaWJLclEwZHErZG9PZ0dVUngreEJCdkNVUnNZOHZGSmxHa3NWZjNOR2Q0?=
 =?utf-8?B?MFVTNXBDUzJwZFRqRXI0SlkxTmMxYjBiSFhKUVd2b1JvZC9xdmdXYUM2QzF4?=
 =?utf-8?B?TEU1V2ZSQ3M1ajVZZ2tGUXAvekxHNmNSQnc4VG5rUzlLK1I1aThkWGVWVTI3?=
 =?utf-8?B?alZuMStLNDJSRDErMjBVZlNOUEhZaEZzRVc1ZmRoVk5kdlBHcytxSHpCT1dw?=
 =?utf-8?B?bkZPTmFVQkttbmc5RUFucTl1aldhdXZhMi9Vai95cXVDV21sUTl4VWxMY0Ev?=
 =?utf-8?B?SjlRdG9xSXUyQk9KbWxiUWFZNkxsbitodVJmVlc1UVpqMWpTaWZhZjVzWWt1?=
 =?utf-8?B?aVVyZ3NRY1ZPQ3FMcHE4MXlzZEtRek82b3hoZ0djWDYzV2FYWjh4RllqS1Fh?=
 =?utf-8?B?T2RQeDRHdXlnZlVWZXY0SkpNa2d1MFlYQjl6NHBxODNJb1VXaGJXaElqY2FW?=
 =?utf-8?B?clN6M1ZIYTVlbEpIUHl4NWMxbzZ2bTNRZXFJRGdKOHNrY2dWdVJjZldsRlQz?=
 =?utf-8?B?bnJnRHdZZTJ3MTlvczdFcjFpZ094Rm5Vdi9zdUpNSTRYRmxuMU1WeXU2ZFY3?=
 =?utf-8?B?cEcrOWVmeGZxbi9TZ05JcHY1K0VPcTlaTmVCejRKTUFSaXMxVDdMUmQzdkNy?=
 =?utf-8?B?OFNRQUxHQjg5QVhOQ0xDV1lwbjE3Zm1LZFdqOW9kYjJOa3ZMTzhFVWk2Vk5l?=
 =?utf-8?Q?Yy89zepUdgpqUyzGGzUdus1dy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185c3da6-cac5-4d1b-420b-08dde931f8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:31:39.4373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRodGjDnsasLNSYvh4BhMMvaXGr4lEXGb0RQwP3aTiSbMc426kn7dDyoCZOtSGDxAcqIaFhK3oYunSVxntV7xBHwAr0D6ZVAl9KCuX97Ueo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6282
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

SGkgQ8OpZHJpYw0KDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+
IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDEsIDIwMjUgNDoyOCBQTQ0KPiBUbzogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyByZXZpZXdlcjpJbmNvbXBhdGlibGUgY2hhbmdl
cw0KPiA8ZGV2ZWxAbGlzdHMubGlidmlydC5vcmc+OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4NCj4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29t
PjsgVHJveSBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgQW5kcmV3DQo+IEplZmZlcnkgPGFuZHJl
d0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBv
cGVuDQo+IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsg
b3BlbiBsaXN0OkFTUEVFRCBCTUNzDQo+IDxxZW11LWFybUBub25nbnUub3JnPg0KPiBDYzogVHJv
eSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgS2FuZSBDaGVuDQo+IDxrYW5lX2NoZW5A
YXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDEvNF0gaHcv
YXJtOiBSZW1vdmUgYXN0MjcwMGEwLWV2YiBtYWNoaW5lDQo+IA0KPiBIZWxsbyBKYW1pbiwNCj4g
DQo+IE9uIDkvMS8yNSAwNjowOCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFRoZSBhc3QyNzAwYTAt
ZXZiIG1hY2hpbmUgcmVwcmVzZW50cyB0aGUgZmlyc3QgcmV2aXNpb24gb2YgdGhlIEFTVDI3MDAN
Cj4gPiBhbmQgc2VydmVzIGFzIHRoZSBpbml0aWFsIGVuZ2luZWVyaW5nIHNhbXBsZSByYXRoZXIg
dGhhbiBhIHByb2R1Y3Rpb24NCj4gdmVyc2lvbi4NCj4gPiBBIG5ld2VyIHJldmlzaW9uLCBBMSwg
aXMgbm93IHN1cHBvcnRlZCwgYW5kIHRoZSBhc3QyNzAwYTEtZXZiIHNob3VsZA0KPiA+IHJlcGxh
Y2UgdGhlIG9sZGVyIEEwIHZlcnNpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRvY3MvYWJvdXQv
ZGVwcmVjYXRlZC5yc3QgICAgICAgICAgICAgICAgICAgICB8ICA4IC0tLS0tLQ0KPiA+ICAgaHcv
YXJtL2FzcGVlZC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjgNCj4gKy0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ICAgLi4uL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2FzcGVlZF9h
c3QyNzAwLnB5IHwgMTIgLS0tLS0tLS0NCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDQ3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RvY3MvYWJvdXQv
ZGVwcmVjYXRlZC5yc3QgYi9kb2NzL2Fib3V0L2RlcHJlY2F0ZWQucnN0DQo+ID4gaW5kZXggNWQx
NTc5ZGNmOC4uOGEyNzNlMDE5YSAxMDA2NDQNCj4gPiAtLS0gYS9kb2NzL2Fib3V0L2RlcHJlY2F0
ZWQucnN0DQo+ID4gKysrIGIvZG9jcy9hYm91dC9kZXByZWNhdGVkLnJzdA0KPiA+IEBAIC0zMDUs
MTQgKzMwNSw2IEBAIGRlcHJlY2F0ZWQ7IHVzZSB0aGUgbmV3IG5hbWUgYGBkdGItcmFuZG9tbmVz
c2BgDQo+IGluc3RlYWQuIFRoZSBuZXcgbmFtZQ0KPiA+ICAgYmV0dGVyIHJlZmxlY3RzIHRoZSB3
YXkgdGhpcyBwcm9wZXJ0eSBhZmZlY3RzIGFsbCByYW5kb20gZGF0YSB3aXRoaW4NCj4gPiAgIHRo
ZSBkZXZpY2UgdHJlZSBibG9iLCBub3QganVzdCB0aGUgYGBrYXNsci1zZWVkYGAgbm9kZS4NCj4g
Pg0KPiA+IC1Bcm0gYGBhc3QyNzAwYTAtZXZiYGAgbWFjaGluZSAoc2luY2UgMTAuMSkNCj4gPiAt
JycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnDQo+IA0KPiBXZSBuZWVk
IHRvIHdhaXQgKnR3byogcmVsZWFzZXMgYWZ0ZXIgZGVwcmVjYXRpb24gYmVmb3JlIHJlbW92aW5n
IGEgbWFjaGluZQ0KPiBvciBhbnkgb3RoZXIgZmVhdHVyZS4gU28gcmVtb3ZhbCBvZiB0aGUgYXN0
MjcwMGEwLWV2YiBtYWNoaW5lIHdpbGwgYmUNCj4gcG9zc2libGUgZm9yIFFFTVUgMTEuMCAobmV4
dCBhZnRlciBRRU1VIDEwLjIpLg0KPiANCg0KR290IGl0Lg0KVGhhbmtzIGZvciByZXZpZXcuDQoN
Cj4gPiAtDQo+ID4gLVRoZSBgYGFzdDI3MDBhMC1ldmJgYCBtYWNoaW5lIHJlcHJlc2VudHMgdGhl
IGZpcnN0IHJldmlzaW9uIG9mIHRoZQ0KPiA+IEFTVDI3MDAgLWFuZCBzZXJ2ZXMgYXMgdGhlIGlu
aXRpYWwgZW5naW5lZXJpbmcgc2FtcGxlIHJhdGhlciB0aGFuIGENCj4gcHJvZHVjdGlvbiB2ZXJz
aW9uLg0KPiA+IC1BIG5ld2VyIHJldmlzaW9uLCBBMSwgaXMgbm93IHN1cHBvcnRlZCwgYW5kIHRo
ZSBgYGFzdDI3MDBhMS1ldmJgYA0KPiA+IHNob3VsZCAtcmVwbGFjZSB0aGUgb2xkZXIgQTAgdmVy
c2lvbi4NCj4gPiAtDQo+IA0KPiBGaWxlIGRvY3MvYWJvdXQvcmVtb3ZlZC1mZWF0dXJlcy5yc3Qg
c2hvdWxkIGJlIHVwZGF0ZWQgdG9vLg0KPiANCj4gPiAgIE1pcHMgYGBtaXBzc2ltYGAgbWFjaGlu
ZSAoc2luY2UgMTAuMCkNCj4gPiAgICcnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycnJycn
JycNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9hcm0vYXNwZWVk
LmMgaW5kZXgNCj4gPiBjMzFiYmU3NzAxLi5lNzI5ZWRmZTEzIDEwMDY0NA0KPiA+IC0tLSBhL2h3
L2FybS9hc3BlZWQuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiA+IEBAIC0xOTg5LDM1
ICsxOTg5LDEzIEBAIHN0YXRpYyB2b2lkDQo+IGFzdDI3MDBfZXZiX2kyY19pbml0KEFzcGVlZE1h
Y2hpbmVTdGF0ZSAqYm1jKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVf
VE1QMTA1LCAweDRkKTsNCj4gPiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZCBhc3BlZWRfbWFj
aGluZV9hc3QyNzAwYTBfZXZiX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLA0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgdm9p
ZA0KPiAqZGF0YSkNCj4gPiAtew0KPiA+IC0gICAgTWFjaGluZUNsYXNzICptYyA9IE1BQ0hJTkVf
Q0xBU1Mob2MpOw0KPiA+IC0gICAgQXNwZWVkTWFjaGluZUNsYXNzICphbWMgPSBBU1BFRURfTUFD
SElORV9DTEFTUyhvYyk7DQo+ID4gLQ0KPiA+IC0gICAgbWMtPmFsaWFzID0gImFzdDI3MDAtZXZi
IjsNCj4gDQo+IFRoZSAiYXN0MjcwMC1ldmIiIGFsaWFzIHNob3VsZCBiZSBtb3ZlZCBmaXJzdCB0
byB0aGUgYXN0MjcwMGExX2V2YiBtYWNoaW5lLg0KPiBUaGlzIGNhbiBiZSBkb25lIGluIHRoaXMg
UUVNVSBjeWNsZQ0KPiANCg0KV2lsbCBkby4NClRoYW5rcy1KYW1pbg0KDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiANCj4gPiAtICAgIG1jLT5kZXNjID0gIkFzcGVlZCBB
U1QyNzAwIEEwIEVWQiAoQ29ydGV4LUEzNSkiOw0KPiA+IC0gICAgYW1jLT5zb2NfbmFtZSAgPSAi
YXN0MjcwMC1hMCI7DQo+ID4gLSAgICBhbWMtPmh3X3N0cmFwMSA9IEFTVDI3MDBfRVZCX0hXX1NU
UkFQMTsNCj4gPiAtICAgIGFtYy0+aHdfc3RyYXAyID0gQVNUMjcwMF9FVkJfSFdfU1RSQVAyOw0K
PiA+IC0gICAgYW1jLT5mbWNfbW9kZWwgPSAidzI1cTAxanZxIjsNCj4gPiAtICAgIGFtYy0+c3Bp
X21vZGVsID0gIncyNXE1MTJqdiI7DQo+ID4gLSAgICBhbWMtPm51bV9jcyAgICA9IDI7DQo+ID4g
LSAgICBhbWMtPm1hY3NfbWFzayA9IEFTUEVFRF9NQUMwX09OIHwgQVNQRUVEX01BQzFfT04gfA0K
PiBBU1BFRURfTUFDMl9PTjsNCj4gPiAtICAgIGFtYy0+dWFydF9kZWZhdWx0ID0gQVNQRUVEX0RF
Vl9VQVJUMTI7DQo+ID4gLSAgICBhbWMtPmkyY19pbml0ICA9IGFzdDI3MDBfZXZiX2kyY19pbml0
Ow0KPiA+IC0gICAgYW1jLT52Ym9vdHJvbSA9IHRydWU7DQo+ID4gLSAgICBtYy0+YXV0b19jcmVh
dGVfc2RjYXJkID0gdHJ1ZTsNCj4gPiAtICAgIG1jLT5kZWZhdWx0X3JhbV9zaXplID0gMSAqIEdp
QjsNCj4gPiAtICAgIGFzcGVlZF9tYWNoaW5lX2NsYXNzX2luaXRfY3B1c19kZWZhdWx0cyhtYyk7
DQo+ID4gLX0NCj4gPiAtDQo+ID4gICBzdGF0aWMgdm9pZCBhc3BlZWRfbWFjaGluZV9hc3QyNzAw
YTFfZXZiX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHZvaWQNCj4gKmRhdGEp
DQo+ID4gICB7DQo+ID4gICAgICAgTWFjaGluZUNsYXNzICptYyA9IE1BQ0hJTkVfQ0xBU1Mob2Mp
Ow0KPiA+ICAgICAgIEFzcGVlZE1hY2hpbmVDbGFzcyAqYW1jID0gQVNQRUVEX01BQ0hJTkVfQ0xB
U1Mob2MpOw0KPiA+DQo+ID4gKyAgICBtYy0+YWxpYXMgPSAiYXN0MjcwMC1ldmIiOw0KPiA+ICAg
ICAgIG1jLT5kZXNjID0gIkFzcGVlZCBBU1QyNzAwIEExIEVWQiAoQ29ydGV4LUEzNSkiOw0KPiA+
ICAgICAgIGFtYy0+c29jX25hbWUgID0gImFzdDI3MDAtYTEiOw0KPiA+ICAgICAgIGFtYy0+aHdf
c3RyYXAxID0gQVNUMjcwMF9FVkJfSFdfU1RSQVAxOyBAQCAtMjE2NiwxMA0KPiArMjE0NCw2IEBA
DQo+ID4gc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9tYWNoaW5lX3R5cGVzW10gPSB7DQo+
ID4gICAgICAgICAgIC5jbGFzc19pbml0ICAgICA9DQo+IGFzcGVlZF9taW5pYm1jX21hY2hpbmVf
YXN0MTAzMF9ldmJfY2xhc3NfaW5pdCwNCj4gPiAgICNpZmRlZiBUQVJHRVRfQUFSQ0g2NA0KPiA+
ICAgICAgIH0sIHsNCj4gPiAtICAgICAgICAubmFtZSAgICAgICAgICA9IE1BQ0hJTkVfVFlQRV9O
QU1FKCJhc3QyNzAwYTAtZXZiIiksDQo+ID4gLSAgICAgICAgLnBhcmVudCAgICAgICAgPSBUWVBF
X0FTUEVFRF9NQUNISU5FLA0KPiA+IC0gICAgICAgIC5jbGFzc19pbml0ICAgID0gYXNwZWVkX21h
Y2hpbmVfYXN0MjcwMGEwX2V2Yl9jbGFzc19pbml0LA0KPiA+IC0gICAgICAgIH0sIHsNCj4gPiAg
ICAgICAgICAgLm5hbWUgICAgICAgICAgPSBNQUNISU5FX1RZUEVfTkFNRSgiYXN0MjcwMGExLWV2
YiIpLA0KPiA+ICAgICAgICAgICAucGFyZW50ICAgICAgICA9IFRZUEVfQVNQRUVEX01BQ0hJTkUs
DQo+ID4gICAgICAgICAgIC5jbGFzc19pbml0ICAgID0gYXNwZWVkX21hY2hpbmVfYXN0MjcwMGEx
X2V2Yl9jbGFzc19pbml0LA0KPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2FhcmNo
NjQvdGVzdF9hc3BlZWRfYXN0MjcwMC5weQ0KPiA+IGIvdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0
L3Rlc3RfYXNwZWVkX2FzdDI3MDAucHkNCj4gPiBpbmRleCBkMDJkYzc5OTFjLi4wNjNkOWU1NzJj
IDEwMDc1NQ0KPiA+IC0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2FzcGVlZF9h
c3QyNzAwLnB5DQo+ID4gKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3RfYXNwZWVk
X2FzdDI3MDAucHkNCj4gPiBAQCAtNDYsMTAgKzQ2LDYgQEAgZGVmIHZlcmlmeV9vcGVuYm1jX2Jv
b3RfYW5kX2xvZ2luKHNlbGYsIG5hbWUpOg0KPiA+ICAgICAgICAgICBleGVjX2NvbW1hbmRfYW5k
X3dhaXRfZm9yX3BhdHRlcm4oc2VsZiwgJ3Jvb3QnLCAnUGFzc3dvcmQ6JykNCj4gPiAgICAgICAg
ICAgZXhlY19jb21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0ZXJuKHNlbGYsICcwcGVuQm1jJywNCj4g
PiBmJ3Jvb3RAe25hbWV9On4jJykNCj4gPg0KPiA+IC0gICAgQVNTRVRfU0RLX1Y5MDZfQVNUMjcw
MCA9IEFzc2V0KA0KPiA+IC0NCj4gJ2h0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9v
cGVuYm1jL3JlbGVhc2VzL2Rvd25sb2FkL3YwOS4wNi9hc3QNCj4gMjcwMC1hMC1kZWZhdWx0LW9i
bWMudGFyLmd6JywNCj4gPiAtDQo+ICc3MjQ3YjZmMTlkYmZiNzAwNjg2ZjhkOWY3MjNhYzIzZjNl
YjIyOTIyNmMwNTg5Y2I5YjA2YjgwZDFiNjFmM2NiJykNCj4gPiAtDQo+ID4gICAgICAgQVNTRVRf
U0RLX1Y5MDZfQVNUMjcwMEExID0gQXNzZXQoDQo+ID4NCj4gJ2h0dHBzOi8vZ2l0aHViLmNvbS9B
c3BlZWRUZWNoLUJNQy9vcGVuYm1jL3JlbGVhc2VzL2Rvd25sb2FkL3YwOS4wNi9hc3QNCj4gMjcw
MC1kZWZhdWx0LW9ibWMudGFyLmd6JywNCj4gPg0KPiA+DQo+ICdmMWQ1M2UwYmU4YTQwNGVjY2Uz
ZTEwNWY3MmJjNTBmYTRlMDkwYWQxMzE2MGZmYTkxYjEwYTZlMDIzM2E5ZGM2JykNCj4gPiBAQCAt
MTExLDE0ICsxMDcsNiBAQCBkZWYgc3RhcnRfYXN0MjcwMF90ZXN0X3Zib290cm9tKHNlbGYsIG5h
bWUpOg0KPiA+ICAgICAgICAgICBzZWxmLmRvX3Rlc3RfYWFyY2g2NF9hc3BlZWRfc2RrX3N0YXJ0
KA0KPiA+ICAgICAgICAgICAgICAgICAgIHNlbGYuc2NyYXRjaF9maWxlKG5hbWUsICdpbWFnZS1i
bWMnKSkNCj4gPg0KPiA+IC0gICAgZGVmIHRlc3RfYWFyY2g2NF9hc3QyNzAwX2V2Yl9zZGtfdjA5
XzA2KHNlbGYpOg0KPiA+IC0gICAgICAgIHNlbGYuc2V0X21hY2hpbmUoJ2FzdDI3MDAtZXZiJykN
Cj4gPiAtDQo+ID4gLSAgICAgICAgc2VsZi5hcmNoaXZlX2V4dHJhY3Qoc2VsZi5BU1NFVF9TREtf
VjkwNl9BU1QyNzAwKQ0KPiA+IC0gICAgICAgIHNlbGYuc3RhcnRfYXN0MjcwMF90ZXN0KCdhc3Qy
NzAwLWEwLWRlZmF1bHQnKQ0KPiA+IC0gICAgICAgIHNlbGYudmVyaWZ5X29wZW5ibWNfYm9vdF9h
bmRfbG9naW4oJ2FzdDI3MDAtYTAtZGVmYXVsdCcpDQo+ID4gLSAgICAgICAgc2VsZi5kb19hc3Qy
NzAwX2kyY190ZXN0KCkNCj4gPiAtDQo+ID4gICAgICAgZGVmIHRlc3RfYWFyY2g2NF9hc3QyNzAw
YTFfZXZiX3Nka192MDlfMDYoc2VsZik6DQo+ID4gICAgICAgICAgIHNlbGYuc2V0X21hY2hpbmUo
J2FzdDI3MDBhMS1ldmInKQ0KPiA+DQoNCg==


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE46C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 09:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF8cf-0004EY-Gs; Wed, 14 May 2025 05:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uF8cc-0004Bb-HM; Wed, 14 May 2025 05:41:54 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uF8cZ-0006HX-43; Wed, 14 May 2025 05:41:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEmf5d98TyGUGZTikOeyLYQihOsAKApg/lTeXCR9S8PBlGhQzBMGjCKz1uPyJg1hd/0+NliSqlmqOiH36VNlGgau4XNu60mGdHQBIfr8sIa+XnbMWB1nHOe2plMkFOm11lbO2+4ZAzhGRSoPhfOCnMXVv0//1C+QOHv+6hfeu1grzOlxNpkIx7505vjb6OhEkqKxHwjNNziQNg9qOPYI2zbDKp7OZx/dGPFBZ9U2Ns63LYmzouloYNnAEcyShWyNilt5H3Y0Gb9btHEo/ATKr3wHt4z7WAUwDoqxrJuomCfK69BhQattNTeEKjy3ySpT9niJuh6I3FAEvx+bKX+gwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsRIHC0tCWeCA0moNm2b2zU02GrWHjA/ySWVyjdSEZ4=;
 b=F7I4WwdJKja7a4hAGes5MWlq0w3IvNnhJA68dTJ1q6XOUdKhTLI0NUaXBLSHP0UPGF7v2sFefNjRJYFL17QCMYi76Pt/zJbClgMv9U8unZEnnVk5S+eHSM51KIFYl9znwN2wqFVt4lI1fD6gZ0HCwry9iK6HLFVtxgueRKDHAL3iyWo+nIl2J9CG1hhYumoisBJcOS+nW7t33x8S9lWIcYWLJa/kZEHeGyVBsV/J7H0KTNyEAOKLYr5LpxoQKstdK3MQeAx1dkUieXvXQwQQO4GJHYTO6sRXcQjzHyDbmUz2nC0LWIKLtUcOGukJo0f+YjWigxv6JyA7x7YYi7cxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsRIHC0tCWeCA0moNm2b2zU02GrWHjA/ySWVyjdSEZ4=;
 b=hHkWN+N8zBP12DlI0ATVvgqeocbJtMg+iSF6s+naGJy/2J13U2K8f/PkUTLq4pDqCND2cHT72fS8+H55DXlQLuMfG2f2F60Naa/eKKVLayxNDkUkmTw+Sb27HaYj1bRiP49vCMSQ/NX5vZtM5buvZXnVtSZ7P0gne/8VyI6TN3qifnXfr8wV8wGRpVSaB2lLCXQiOKTsIE2fykUfUOg645UQ3/Ie5gKe+CCLy0Nu4rOGXhKtcB4c92jOGLv2yV3QRDgP8f/ffNUevLiDWaJ0n+N6S/X99bcTJoJtxmna4Qsg8XAxMT5l+JtrHdcngG6sRb4hEWVyPrq03BP+46aysw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 09:41:39 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 09:41:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 05/25] hw/misc/aspeed_hace: Split hash execution into
 helper functions for clarity
Thread-Topic: [PATCH v2 05/25] hw/misc/aspeed_hace: Split hash execution into
 helper functions for clarity
Thread-Index: AQHbw9BYykb4gvGr5E2Vs5jtHDVswbPQh4eAgADgk4CAAAPcUIAAc4UAgAABAOA=
Date: Wed, 14 May 2025 09:41:39 +0000
Message-ID: <SI2PR06MB5041EABBCD377E27B93E6DE8FC91A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250513062901.2256865-1-jamin_lin@aspeedtech.com>
 <20250513062901.2256865-6-jamin_lin@aspeedtech.com>
 <e05b8809-3e64-456e-8b88-0026b0e14588@kaod.org>
 <SI2PR06MB50417B9694B1462E3772FDB0FC91A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <SI2PR06MB50412C3C9EA79C28A07629E6FC91A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <0eeb5138-cccc-425a-b9cb-8b38581bc1b1@kaod.org>
In-Reply-To: <0eeb5138-cccc-425a-b9cb-8b38581bc1b1@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR0601MB5510:EE_
x-ms-office365-filtering-correlation-id: fb16ac28-a404-4b39-8ec1-08dd92cb86d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?K3p5SkNwMjJZQjBlSVpNVnlrcXlUZDNrQzVTcXJNUElrVE1YOE96SmdKTkFJ?=
 =?utf-8?B?L2NhSitkVlMyYm55cXNPbi9TdTdRblVyZG5IUjNTbkREWHlvN0QwNDdTNHFH?=
 =?utf-8?B?RTVLYkJYU2NtRnB6d21kTE82UytVT0c1UEFDTWk1NStZdEJiTVY1dnYyRWs1?=
 =?utf-8?B?dnMzaDVxZVpVdHlVU1JOUGNCVUxUMlhpQ3phaW11ZnRPR2pLWHkvaTNKS1RK?=
 =?utf-8?B?ektUYVdMQmpYMVJtRndWMm1WYStqQ2huZ2kxWHpycm5RRlMzakR6WUMyTzE2?=
 =?utf-8?B?TDAvWnZHMmJpdC9ockk5OW1OQ0ZWYlJJdlQvclBFeVhMOWZlSzByb3VMMTZL?=
 =?utf-8?B?emNPQ1UvcTF4MVVJQnYyK3E5UVArenNpeTVKNDNEQ0ZQdExIQVRjUC8vU21G?=
 =?utf-8?B?MjU1TWZvN2lveUgxMTBGUDJXQnlsZFhVZmw0Q0FQWm5YMTNKSEhZVGhpcHd3?=
 =?utf-8?B?VUJNWGE4bWtXcmpwQlA0dDhpTFJ2Um91a2FXN2c3eENzenFwcnhsd2syLzlM?=
 =?utf-8?B?V2podmRydnBkYThOMzc2U2N5U3JhcCtIbDFxV0dsSzI0bnN0Sng0VHI0NWw0?=
 =?utf-8?B?bTBuZGdjR2ErYnZoVDdpQ0puMjdJamNTbG5ONzltdG1PTThtLzk0ckgwZ2M3?=
 =?utf-8?B?aEFrbHM3KzJOamg0WDFMeWF4dHdwMzVUd1RzSzA5R3p6dmNVR3h2WGJnMFp0?=
 =?utf-8?B?bzh3RUJVZXRRVUx2Vmo0QTRhUFJoNWNSQUVZbTU3RU5FcVRwMXh0L21heXNn?=
 =?utf-8?B?T3Nma3VGS0RqY0JvcFJlRjRneUhxcXkwY1FtVm1QR2N3WHBhenhnYUNLME9V?=
 =?utf-8?B?L0UzWU1YK0tweXYrRWV3aUZVNW04TzhVSld6UHJOUVBqRGVJK2IzUlMxc3hr?=
 =?utf-8?B?Ty90eFFJZHRZc0xlclF0RjhWa2kyZkY2VGxVL0NvVjRZaFN6MWxGT1lOTFZu?=
 =?utf-8?B?RmU3cXhUVzFUa1ZkOVBvSlgyb0JLSFR6c1pwdlVLL044Z1FHMGdrdVFFYmJX?=
 =?utf-8?B?RHRTZkx5cHVraGZVN2lXM1NmTHhEWkhxZlhqODJ6K292UjhMZ0dWYkIzNGw3?=
 =?utf-8?B?WitDbUliYlNQNW4xZEtydlBKeE1zd1crN2JYSHlNS0NrK1pwazVTTGpkRlZV?=
 =?utf-8?B?WXhIVS9NS0VtU0lkWGN0VFp6czh1Q3RzNWlteFZJdVNpSUZkV2thSDRJUzEz?=
 =?utf-8?B?Q3VMbjRQeXY4NUxiZ2lJMVpnNHNnMUlsTnFzWS8vZGhRdnNlRTdGREZNYkpE?=
 =?utf-8?B?RmN2d25SUytsSldEaWR6M2dsYm8rUE5sNjRUdlc5UDdEUW5DSDdsaDAxSXI4?=
 =?utf-8?B?TzkyUW9aMW5RZEV6M0VNMzh2aGFSdThRSUcrcFlYbUNwSENHZzR1ZTJpMjN5?=
 =?utf-8?B?Tk9rbVBiemt0Z2cyR1FxU1V2RWVhbW4zOXQzVVRxOG1VRXlTSlJkVWFsaEFV?=
 =?utf-8?B?Q1krOS8zUkJ3WG16djg3MGZFaVEzNGJKY25wYVZtSi9BcHRieTJBU2QxNXhQ?=
 =?utf-8?B?ajlzSWtOc1YvNDArTHdpQzhkSWVLRVNlT2E2ZUZwUXJ1TUhWaTZyY0lzRUwz?=
 =?utf-8?B?WmVJM1pEVXRubEFpUGNDNXgxUFRvL21qZk1NR055bzhkMFh3Ly9QS2NuZTBz?=
 =?utf-8?B?ZTZtMnorMHNjWEVaUGVxTEVQUlhXU1N6b21scDB1TkhXWVgrcU80Z0JGbXEx?=
 =?utf-8?B?aHl3TVRZMDVQNGJ3aEpSdVJMNmkzUCswTHJSYzh5WjBUbUJIbGYvZDNpclc5?=
 =?utf-8?B?YjF6QkdHUnUxREVmbmt6ZlVzaDFjWGJBY2RGL3JxaVZuOFI4Y3VJZUs2QkFr?=
 =?utf-8?B?cnRuRlU2bm1DRktvdVU5aTlwZUg0U2lkeVBYOGxmWU9lNUtQcWt5RWpadXBm?=
 =?utf-8?B?bVdsTExTeGQ3N24vVUVyck5oR05pLzJBNjZrUStmUXg4UG0zNVlmc0VGZnVB?=
 =?utf-8?B?LzFZVDhNMlNnaWtnYkpUbjNOZ3NTOU4wcERzM21xQXlPaVhrZEtWemN6cUt0?=
 =?utf-8?Q?iQH4S5582ggAys4s/Ww0D7dnYLplOQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bENyV3JIcjg4M3BzelFlLzMwVG53cjZNdVhNR2QzRC8xQzJyYTRlV1RoWW0z?=
 =?utf-8?B?ZEEwZDlZWFlYSXVlOVVtNXFyaFluWENMUkZvZHlaMjJrazBydFBGRHJ5WXM4?=
 =?utf-8?B?UUNpT01jdkNSR1ZESWVEaDl2eEF4bW1XMEdqS01FbXNvcUZ4QVlaZTVzOUt3?=
 =?utf-8?B?ZDRKTm5mU2V0Nmd0R0NBWXJLdDd6V25EZVJod3ZCQ1ZXY3lEUEF4REIzazdJ?=
 =?utf-8?B?ZTY1TGtFUkRxNjJMSnMwZWJaSVpxMTNncXpHc1BvYU5ZTE92dzA3UGtmQjE4?=
 =?utf-8?B?SSt5R3VuMkxGeDRSbDhOUnBGcXpiQmM4dHdYTy83SnBraTZnejFXS2dlM0Rk?=
 =?utf-8?B?cXFWLzl0NlI1eDZpZGR2MTlIU25kVFRCbzZWdHM5OWtxYmFaMUpjdUg1T1pl?=
 =?utf-8?B?ODNjSkZwQjFDZHdieXoxN3E3Ukl0eCtCMlNZazBSWWdxQTBuQUsrSDRWSitx?=
 =?utf-8?B?MlI1TEZrcGxZaUxSbHBKc0pTUUR5VnkybFJGbUJwV24rdWhlMmtJRzYxSHRH?=
 =?utf-8?B?NVhCYThScjVrWkpMczhNTk1yaDd1OWtWS1NqVHUyak91WVNiK2VQZmM1TE0w?=
 =?utf-8?B?N1EzQktrZ09lKzdvQU9GalZQU1VLWHFiOE5CVGNSUWVOVnAwZmRzdmxFeTV3?=
 =?utf-8?B?YWxKa21SNVZlSjI5dmRFVk9XRkc2Si9mZkh5K1VQdkZiYUhWMlV5Mys2UHl4?=
 =?utf-8?B?NDRNWmRraXIrTUZkV2I5dUg3ZXVkYlhFYkNMclFPdDg5cFFENWRIMmFMUzM5?=
 =?utf-8?B?MDNhN2xETHpKWU92dmNqOG9hMGVsNzA5U21SaGdGOEZTUlR2bnQ0NHVQSDFC?=
 =?utf-8?B?elJFc2NWSWJVeWJRWjRScjJTL1FXN2l4NHQvUTFsUEhFeW41dzJraDd4T29V?=
 =?utf-8?B?U0JEdVd1QjduWGt6Uk9renRxei9vajd3Q3A5REQzQ0xSWHhDdWJ6SFUxaG94?=
 =?utf-8?B?ZHBRNEZlVWZwa1I4NWpLTzQrMUFEcU9pNlYxd2dER1Q1YS84R2U2QVpQclJ2?=
 =?utf-8?B?cFZISEppcUt6d20xR0RTWDlNT1NMQU4vdE1xVXpTRkZkVXlDZDl2QkJOTVFj?=
 =?utf-8?B?VXl3WVFHTThNMVpoMnkyWFFaZzZLNlAyYnpyWUsvaDl6V2hOZU1pUHBNVlNq?=
 =?utf-8?B?eUhISVY1aHpDYzZUY0daT3NLdGg1QXdqREgvaE8rd0Fyb05xUC9ZYlN6Q1lR?=
 =?utf-8?B?S0xBakNHV0Y4cWl5Mm5aYlZ1R3Q4RmFXVWdOQ3BSOUU5dC9LQ3N3MEVRSUkr?=
 =?utf-8?B?WlF2Q0o5L1psdUVNeW5ZRnE2K29xMUhjeEduNWNlSVFaOXhxS2FHdmRnbUNL?=
 =?utf-8?B?QlhvcTQxS1gwYjJ4cEd1VTZvUzVmekN1L0V2N05zUUJOK2ZWTFdoQ3Y4TXBL?=
 =?utf-8?B?WE9lSXhhYzRseFRIY3hPZ0kzOFlMcG8wRFZHN0R0SnFyMFIwMkhlc2RqMXEx?=
 =?utf-8?B?YUdiTjVjaGxmS2ljTEgvY1BxMWRKZjgyS2VaMVc0MTJ4cGpMZjdoVHNLOU5v?=
 =?utf-8?B?MXA2QTFPWnVEYWNuSWZoQVdsNktUR0RGSk1CL2lUa1NYc3dWdENxT0FVRXd2?=
 =?utf-8?B?UFNuYkptSDJpeHFFSW1udE9rV1o5L2RCU2Z1Z21aWU5xTW9jTy96dkhUS1Vi?=
 =?utf-8?B?L1R4L1FhaURFWFl2NFRRaklhcXlKc1NaVnJMVFhybUg4WXRvLzI1bTVFRUU1?=
 =?utf-8?B?dmNwMlJRenR5cXJ2OGtmSXdEWmVwbzNNUWlyUERsRmJPOC9Vei8xOVdQSXZi?=
 =?utf-8?B?TCtuN05nMHdvMVhOc2N5ZzRNandxQ2pwWFRPTkdYdEcrSkxEQjA2dXVwSUQ4?=
 =?utf-8?B?dlZRVDMwZjV1cmk5VzBvWGJld2xHNUx1eW1KRUtTY2FLRnVvU0hxQk9PNlpV?=
 =?utf-8?B?SllTU2V3dDFvdENzNXdsOVlKV25EbExtaWY0TG5RZU1Fb3AxTkhhTFRxa1Nz?=
 =?utf-8?B?K2VQUmFoM2w5Q3ArNkhpNmVnNDA1aG9ZK1VCRktvQ3p3TGJLTVlUTm5KdFRj?=
 =?utf-8?B?aG05UEtMVVJFZy93Vi91RkR4YjFuOW40ZG9adVp6M2U2ZTBCVWtpNFBBQWho?=
 =?utf-8?B?R3YxdllRQ0JDSXNWVG45YWtrYnY4N1pUL3d0b0FqS2NzVjBvTGE1aXZRVmFW?=
 =?utf-8?Q?9AiDrcO+2nuYAwjTZBu/nbyqy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb16ac28-a404-4b39-8ec1-08dd92cb86d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 09:41:39.4654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edOOA68Fywz71TS+7cqThN3Cd+N2oMY3jSfMfjmMJAc3kC9UyX5N4TDKDxAUVVtmzahGdb0KeMgSdXV2rPQU8rA1tfqZ43/sPs1eVLVQxtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDUvMjVdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IFNwbGl0IGhhc2ggZXhlY3V0aW9uIGludG8NCj4gaGVscGVyIGZ1bmN0aW9ucyBm
b3IgY2xhcml0eQ0KPiANCj4gSGVsbG8gSmFtaW4sDQo+IA0KPiBPbiA1LzE0LzI1IDA0OjQ4LCBK
YW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgQ8OpZHJpYywNCj4gPg0KPiA+PiBTdWJqZWN0OiBSRTog
W1BBVENIIHYyIDA1LzI1XSBody9taXNjL2FzcGVlZF9oYWNlOiBTcGxpdCBoYXNoDQo+ID4+IGV4
ZWN1dGlvbiBpbnRvIGhlbHBlciBmdW5jdGlvbnMgZm9yIGNsYXJpdHkNCj4gPj4NCj4gPj4gSGkg
Q8OpZHJpYw0KPiA+Pg0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNS8yNV0gaHcvbWlz
Yy9hc3BlZWRfaGFjZTogU3BsaXQgaGFzaA0KPiA+Pj4gZXhlY3V0aW9uIGludG8gaGVscGVyIGZ1
bmN0aW9ucyBmb3IgY2xhcml0eQ0KPiA+Pj4NCj4gPj4+IEhlbGxvIEphbWluDQo+ID4+Pg0KPiA+
Pj4gT24gNS8xMy8yNSAwODoyOCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+Pj4+IFJlZmFjdG9yICJk
b19oYXNoX29wZXJhdGlvbigpIiBieSBleHRyYWN0aW5nIGhhc2ggZXhlY3V0aW9uIGFuZA0KPiA+
Pj4+IHJlc3VsdCBoYW5kbGluZyBpbnRvIGRlZGljYXRlZCBoZWxwZXIgZnVuY3Rpb25zOg0KPiA+
Pj4+DQo+ID4+Pj4gLSAiaGFzaF93cml0ZV9kaWdlc3RfYW5kX3VubWFwX2lvdigpIjogV3JpdGVz
IHRoZSBkaWdlc3QgcmVzdWx0IHRvDQo+ID4+Pj4gbWVtb3J5DQo+ID4+PiBhbmQNCj4gPj4+PiAg
ICAgdW5tYXBzIElPVnMgYWZ0ZXIgcHJvY2Vzc2luZy4NCj4gPj4+PiAtICJoYXNoX2V4ZWN1dGVf
bm9uX2FjY19tb2RlKCkiOiBIYW5kbGVzIG9uZS1zaG90IChub24tYWNjdW11bGF0ZWQpDQo+ID4+
PiBoYXNoDQo+ID4+Pj4gICAgIG9wZXJhdGlvbnMuDQo+ID4+Pj4gLSAiaGFzaF9leGVjdXRlX2Fj
Y19tb2RlKCkiOiBIYW5kbGVzIGFjY3VtdWxhdGVkIGhhc2hpbmcsIGluY2x1ZGluZw0KPiA+Pj4g
dXBkYXRlIGFuZA0KPiA+Pj4+ICAgICBmaW5hbGl6ZSBsb2dpYy4NCj4gPj4+Pg0KPiA+Pj4+IE5v
IGZ1bmN0aW9uYWwgY2hhbmdlcyBpbnRyb2R1Y2VkLg0KPiA+Pj4NCj4gPj4+IFRoaXMgcGF0Y2gg
aXMgYnJlYWtpbmcgJ2NoZWNrLXF0ZXN0LWFybScNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gICAgIHN0
ZGVycjoNCj4gPj4+ICAgICAqKg0KPiA+Pj4gICAgIEVSUk9SOi4uL3Rlc3RzL3F0ZXN0L2FzcGVl
ZF9oYWNlLXRlc3QuYzoyNTQ6dGVzdF9zaGE1MTI6DQo+ID4+PiBhc3NlcnRpb24gZmFpbGVkIChk
aWdlc3QgPT0gdGVzdF9yZXN1bHRfc2hhNTEyKQ0KPiA+Pj4NCj4gPj4NCj4gPg0KPiA+IEnigJlk
IGxpa2UgdG8gcHJvdmlkZSBzb21lIGFkZGl0aW9uYWwgaW5mb3JtYXRpb246DQo+ID4NCj4gPiBN
eSB0ZXN0IGVudmlyb25tZW50IGlzIFVidW50dSAyNC4wNCwgYW5kIHRoZSBnbGliYyB2ZXJzaW9u
IGlzIDIuMzkuDQo+ID4gSSBwcmV2aW91c2x5IGVuY291bnRlcmVkIGlzc3VlcyB3aGVyZSB2ZXJ5
IHZlcnkgb2xkZXIgdmVyc2lvbnMgb2YgZ2xpYmMgKHN1Y2gNCj4gYXMgdGhvc2Ugb24gVWJ1bnR1
IDE4LjA0KSBkaWQgbm90IHN1cHBvcnQgU0hBLTUxMiBwcm9wZXJseS4NCj4gPiBJbiB0aG9zZSBj
YXNlcywgSSBzd2l0Y2hlZCB0byB1c2luZyBsaWJnY3J5cHQgdG8gcGVyZm9ybSBTSEEtNTEyIHRl
c3RpbmcNCj4gaW5zdGVhZC4NCj4gPg0KPiA+IElmIHlvdSdyZSBzdGlsbCBleHBlcmllbmNpbmcg
ZmFpbHVyZXMgd2hlbiB0ZXN0aW5nIFNIQS01MTIsIHBsZWFzZSB0cnkgYnVpbGRpbmcNCj4gd2l0
aCBlaXRoZXIgdGhlICItLWVuYWJsZS1nY3J5cHQiIG9yICItLWVuYWJsZS1uZXR0bGUiIG9wdGlv
biBlbmFibGVkLg0KPiANCj4gVGhlIHRlc3QgZmFpbHMgb24gUkhFTDkgYW5kIFVidW50dSAyMi4w
NCBhbmQgaXQgZG9lc24ndCBvbiBGNDIuIE1vc3QgbGlrZWx5LCBpdA0KPiBpcyBhIGNvbXBpbGVy
IGJlaGF2aW9yIGRpZmZlcmVuY2UuDQo+IA0KSSB3aWxsIHRlc3QgaXMgb24gVWJ1bnR1IDIyLjA0
LiBXaWxsIGNyZWF0ZSBhIG5ldyBwYXRjaCB0byBzZXQgbG9jYWwgc2l6ZV90IGRpZ2VzdF9sZW4g
MC4NCg0KPiANCj4gVGhlIHByb2JsZW0gaXMgZHVlIHRvIHRoZSBsb2NhbCAnc2l6ZV90IGRpZ2Vz
dF9sZW4nIHZhcmlhYmxlIG5vdCBiZWluZyBpbml0aWFsaXplZA0KPiB0byB6ZXJvLiBXaXRoIHRo
YXQgZml4ZWQsIHRoZSB0ZXN0IHBhc3NlcyBvbiBhbGwgZGlzdHJvcy4NCj4gDQo+IFBsZWFzZSBz
cGxpdCBwYXRjaCA1IHRvIGludHJvZHVjZSB0aGVzZSByb3V0aW5lcyBvbmUgYnkgb25lIDoNCj4g
DQo+ICAgIGhhc2hfcHJlcGFyZV9zZ19pb3YNCj4gICAgaGFzaF9wcmVwYXJlX2RpcmVjdF9pb3YN
Cj4gICAgaGFzaF9leGVjdXRlX2FjY19tb2RlDQo+ICAgIGhhc2hfZXhlY3V0ZV9ub25fYWNjX21v
ZGUNCj4gDQpXaWxsIGRvDQoNClRoYW5rcy1KYW1pbg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiAN
Cg0K


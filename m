Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE079C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 03:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBmW1-0000rJ-Bo; Sun, 04 May 2025 23:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uBmVz-0000qM-14; Sun, 04 May 2025 23:29:11 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uBmVu-0004pA-An; Sun, 04 May 2025 23:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGkXbxeLZBCxmBSmE1eJpuuYTFJY7w1zhv9kp/vLlRg8tZSTg96VY6biRLtIp7HRQmtZvOtuyYPaP23NRVIBoUbIDIkF/TjLE/zdykiYi/rGL0DojwQv8HQXDEXgeTpc1GeL3AclJW2iOgXawjVka5ZvmZneQEBmXqNA223HESvJ+Xh3U+VPjGHgTri8SBjVGofM+98oiBhWNi89g2QSmb97F7u7XdcT/hCIQPbX9ybal1UzLY23M7V/00ieNcF514PoERB+si5pUCWxaoVDDE0d6jJpIdhRsndkrKDDZ4OB55yKCfKRbWrbjqN7AYdnSRE4hLEBTVpf3cfaH0QayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVXTsCnk/AxkUxRnoHwoj9hmmrNhV//nbAzIHvKbSsQ=;
 b=EiwDHnyeQqnea8bcVWsjtNBNHVqt9l2KituQcj6VRPdQKYD4B0KyLUnW3DBmqioYh6D2OvIJyLWup7WNS+xKjPbYIOMBVCEkQwK+h6npMdgmsbfHMEmWXHitHAq1EeRbcMK/xVEyf7ARdGU4QKV25UtWfIpKUzFH0XDRDYF7Y0XbZj1xmME0DDfriTJ9pxqanb5FGWssLUm7KdukA09Zd8CikTDUPnl9rAPmjOyOzcpDhgIHl4qySSMwciLKj9PXb5sJQISvNsuDAXP/98V+Ynui0Ogmcn77oWRi7gfPi7+EnaGrl1gP4SavoI1jRwi+B6XUhJN9flVLYDbpIn8Yqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVXTsCnk/AxkUxRnoHwoj9hmmrNhV//nbAzIHvKbSsQ=;
 b=JLwQI3hjF/uDqVyi9+GMz76y/UkEfgNnI0XQEbgaWOUIa/ZgVHPKPSlJ3LJ9xoZ+4grB1VjZWRsKG0jfE0WkOm7i/WrybOf0TwObDgLsC9Tju/KGcFKrvPjPOqRkHpAd7aU6Q97GlteDetQVq0k8qU0LIpUY/BI6+QoYc2f0Phf7oF3ZloEgUigslckcNEPyAUHqfpG00wrlvTteO4ZfCERjLQ9fkl2vjrU6T4CoYhpY+TR3hrzwuHKPlvzGYhFtCFVk+3MjGuuIGnNxeR4l3cBJs/ADyYtVzeUQYiZgSHmxZ5wLCTvdJVLAf9mymoDUG3QYzGkT7qaVcmbdl5+cfw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Mon, 5 May 2025 03:28:53 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8699.021; Mon, 5 May 2025
 03:28:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 01/22] hw/misc/aspeed_hace: Remove unused code for
 better readability
Thread-Topic: [PATCH v1 01/22] hw/misc/aspeed_hace: Remove unused code for
 better readability
Thread-Index: AQHbmkNU6PhP4weuZ06FqDNttNTPq7OO2cuAgDTNBuA=
Date: Mon, 5 May 2025 03:28:53 +0000
Message-ID: <SI2PR06MB5041C4C35CD83984D7A7FC5DFC8E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-2-jamin_lin@aspeedtech.com>
 <1c4176c4-6077-4260-b96d-69ab5b920afb@kaod.org>
In-Reply-To: <1c4176c4-6077-4260-b96d-69ab5b920afb@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: c9da61e2-d534-48a1-fd72-08dd8b84f5ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MWNRangvZFQ1cEhiVWExUm56MXlPRTUvS2k0M3pWQm9zTzljeXdHbE9wQyth?=
 =?utf-8?B?UnZsR1VSUlN5NUtEOFdJRUhXcVNBeGprOTRIMXpyRVU0V3VObXhmMWJyeklH?=
 =?utf-8?B?RGFBcFI3ZGNQMTRja2dvQkVJTUM3dkhuNjh1Y0ZtdlBjUEVGempucFBSSFg3?=
 =?utf-8?B?Uy9vajNyMVFmSXczcmdIMU82ZlRjOEtHdzZ3NEE5eGNwZDhWd1FIZDRzTHpC?=
 =?utf-8?B?ZHNQZEZ0RGFuT3RNbkZxU2RabDZQV1JoOXZMbENzdi91WUVDMHJvaUNiWm0v?=
 =?utf-8?B?ZXNqbE5aQWlwR3hsTDRJZ3FndDdPdytGcjB0czl2R0cwbEIzditYa1RoVGRn?=
 =?utf-8?B?L0VnNFg1a0lmN01DdWppMzRaU0JsTE9hS1Q2c2g0YUxLTmlPZ2Fya2RTdTdE?=
 =?utf-8?B?eGxMWHZMWUkwUmltcmUrNkdxeENqMU9pbHZFOFdkRE8xbHFNNjAxcHB5REU4?=
 =?utf-8?B?aHdxSlBzSzMvQnpMcGRSdjBOaHl2T25OdFpGaUpaN24rVXBsOU9YL1MxcmJ2?=
 =?utf-8?B?clZXR05LbStrK3Z3VmszUWE2OEo3UWt2RWJQdW1EbXBabm14Wkk4d2FBOVN4?=
 =?utf-8?B?dXQ1Zkdxa2dKWFpxOVcyVGZ0TllqcU5tNzZRNndVTXZ0TklndWQzTEV2NjZW?=
 =?utf-8?B?cFZ2MjV1dUZjeVRVeHA4d2hZc1I3blRTamgzalpLekE2V1dIYnNxOG42RHZT?=
 =?utf-8?B?OEM4aktEM1JPVThMUExZK3Vlcy9oSnpDQkhOY3gvWXBoVzQ0L0FQVmE0aGhp?=
 =?utf-8?B?NGE5dms3eUxqVno3cko2aTVQemQwdXAxZkJld0JsNjJXRjN4alpZQUJLU25z?=
 =?utf-8?B?MXNsME1QUTg1Yk5iM3dIckZGdUxHQlY0SzhVeGN2cUhpalo1UDRKZEt3VU5i?=
 =?utf-8?B?L2JIVTVMOFJaNEdJZkJ3L1RwTzUwQTlVbllZQ1ZxeHhkNzdRSWFJOTBId1dz?=
 =?utf-8?B?MUYzN0FYV2twZG9SakQ4OVRndXMzeUZpYWx5VVZlZHBRSkZzb3J1YXRzTk1V?=
 =?utf-8?B?WS9ndnlxdURoRWpMQWNYV0pkcjJMWUEvWEhJK1VoOGtNL3lvK3g1bWxKMDRz?=
 =?utf-8?B?aHh3eld6N2tUbndiUG9Kbmx6V25DajQ1UnUvS3BKanlzZktudWlxdnIwbkt3?=
 =?utf-8?B?ZlFxUVZSUldodzYrQ0plVTlvYXNVdERhdHhQRFJ1eUJOa0hHTHJvVlNZNjRV?=
 =?utf-8?B?NXc0eVBzRzhMaEFFZHRZN3VHeHNaZmNCVGRnam9WNHlHN1dVUDBnZlhNTGR2?=
 =?utf-8?B?bEhrMURCTFRFbVAyalNJK3NLa0lCSlpCYkhhYmwwR3J1eDBsK3pTWVdkZjFQ?=
 =?utf-8?B?MSttZXE4MEtXVHhWbE9MNkxlekZVSDdLeElWRzIyaVdyeEtrQ1BoVzk5KzM3?=
 =?utf-8?B?NmR1alVXWXNNdm0zSmlCeTRHOTJOR1pDMVAzNkFkc3puMzV0a0FwU1c5VmIr?=
 =?utf-8?B?dGQ3K3dINHRqeG0zTy9SRlIraVFZTTBCVHg3RDN4R2NqSnpEdVJGdGZ5UCt1?=
 =?utf-8?B?WUZ4WVAvTkNWUFlvci9PUlBFUUppRHBWWlF2Z281UVVjNThVQmVZcExQNXpU?=
 =?utf-8?B?SVZFQTBRQnZGZHdSYkFBM2Z4Y3VlTHExMjROaGtxUVBoWlltWS80VzVIQUhN?=
 =?utf-8?B?RVBhbFd0SVFhbDB5R2xlOGEvU2FTZHRteHFtTnFtRmhDNkRKbEFuK2Y3cHFV?=
 =?utf-8?B?bEFma0ttWjErV2hNZXBSZ2Npa1pFcGhJRWR2SVJCaEM3TFZ4RkFMaHlIdFZ0?=
 =?utf-8?B?Z2IyV3VTa0FHMXZTRWdkRDYwMkxVeVY0Rm5JdzkrRkFTTy9WZ2dGTlAxU29s?=
 =?utf-8?B?QS9HQVdDdUx4K0U1ejJKSTMxT2R6T1pNTzdLK1pKcExXMnJOT1dzS3AvMnhm?=
 =?utf-8?B?YldoZnJvOENwYy9Ud1hSR0Y1a24zRjg3aDZDeWN4Y0pxSUdEKy9LWGNTRXVn?=
 =?utf-8?Q?kxMAiRpfNjOOkj44MvwwKmokWpNlFL15?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlA3OHUzOVBvMmhITm5QRVBueGdYWGRsYVppUUQwZ2hyYzBlelpzRW1oVTJn?=
 =?utf-8?B?MXFCbzhXcitaa2VyTWlhRUZRb2l4Lzk1YnpFa2F1SFBNelE0YWsrajFmV0ds?=
 =?utf-8?B?YTJNYW5XcndwTGp6cENSUlEzNTVpNFcwTFp1bTFkaVJ5ckorL1pMRVVLaE54?=
 =?utf-8?B?TlRUVmRIRXpxOE9UWTJhOVB6ZVd2d1REVi9RalZXNFpjS0J3Szc5NFhpbFdP?=
 =?utf-8?B?QnEwNmdpMytGdllDZVE0ZGRaZVZWL2wyenRwMGZPNjJtNitYZU1sU2RIdTl1?=
 =?utf-8?B?YlZoU0ZNdVJoVlB1ajhJTkxJaUNVNWpQaXgzNnVXcFEvQ1BrSVd4QUFPZDlV?=
 =?utf-8?B?MGFyeWsrdURPM2l5czVPZXNXL29RT0pSOTVtbUdXdGxyTUs4b0h6YWUvOGdD?=
 =?utf-8?B?c1RncHcrK2QyUFlueXNIRFRkdVJQNkJHRWNpS0R5bGgvQ3N3bmZIYmJGdW95?=
 =?utf-8?B?a3k3em1vTGRRd2IrNTdPQ2dwSWVXaDdWaTJzQ3REZFh3ZEx5RjRmQ0VUYzNw?=
 =?utf-8?B?VGZ1enNCOGZQVDM2clBwbXNlaHJsZURVOGE4M08xRXdpa1ZVU0Jra014QzRM?=
 =?utf-8?B?RmZLcVpGOG5zWWtHK1BzcDROWFlaSDVRclh6ZWdUVHdQS2pOdGhmWmVBa2hW?=
 =?utf-8?B?a0V3ckhnbmJkNjVVVEM1ZkptRTZvWklIQkVmZHBQVkZqSUZNWnlFMU1qdzBF?=
 =?utf-8?B?L1FPNWdRQzFlUXhqU2JLNWVlYXJwOXduWE1TSldhSStTdVpEblg0WGJkZVMz?=
 =?utf-8?B?Ly9YRnlmRUJTNlZpMEJ6N1pzRUVKOHMwN3FpM0UwTEk4cjJHdCtxY2U4WHpt?=
 =?utf-8?B?OGs3b1g1L2tOeGFCY1Ryb3M0SmFhamIvOHY4ZVBVZmpaODlmbW1nV0Z2b0E1?=
 =?utf-8?B?TkJqdk5kSFMrS3BYOHFWc1VzWjBvTVIxbU1RR0FPSmJ5c2VTczdmZ3Jiby9p?=
 =?utf-8?B?cXA2enVTOUg0dEJrOEZnenRualNiTFp6dzF6dUdEK01mbk55REJmUk04Nzdv?=
 =?utf-8?B?QjhxTzErYmU4SnlqZktlVUVxWDFTdjZaaUdaWXZzcVBPRVRwQUhWOWVrczBi?=
 =?utf-8?B?UU1OKzdpNVlDVUY0dU1ZOHIvL3dLNUhOc0JFMHA3TDlDTE5QRERxTE1QTnN4?=
 =?utf-8?B?TVQxdmIwNXVadFJOM1JWWW4wZU4yNjRRMTRlUmtNVytkNytab3VWK3J2MERI?=
 =?utf-8?B?dXdiVmt3TkpXb21zQ3BsT09PNW9FMHZ6azkzZVBGUXJENHh3eU9ha3dIbmVU?=
 =?utf-8?B?RnYxdVk0aEgzMEhWYmxmekZMN0k0bmNia0tYWWxLOUpBYUllenpvVHN3OHZX?=
 =?utf-8?B?WXYrZ0F2NnNKTVFvUjdhZ0lYTE5Cb3ZwY01RUWx2UGlLZ1ozMjF4bTh1OUVr?=
 =?utf-8?B?TGYzd2pBTHV6Z3NyQThjd3V6NkI1RmlIeXZKSEFSZ2s4Z2Z0UnZnaS92SVBM?=
 =?utf-8?B?UDlOMElpSzc5V1BXT3pyN0dZa0hBei94dDVyaWp5TUhjSXgvdUxmdjl4MU1i?=
 =?utf-8?B?V1FrTTVsS3BxWWt0aWpsOG81aStaZ0E0dDNMaWMrc05QRUdqSUloMnF1WUN3?=
 =?utf-8?B?K1JneHc1dVd5SXZEMEp5bHdpZEsxcVJZT293L2dRNlJhc2RkZXM2TGEyVHVv?=
 =?utf-8?B?dkw4dnpXa0JRMWNyTWh6c0hXaTZxRlBHaWxuTUs2VU05UWZCUHNyNkppb2RT?=
 =?utf-8?B?dW5NejFVRVVvdGFLb3RuOHFBV1A3NjczL2lBYTYyVENVaDRHRnZGbTBiNHd3?=
 =?utf-8?B?azhSYW9MSkxVcGxRZ1hWNE1wMzJIWkduMS9XNzgrdFZjR2VPLytKVUxaaU9k?=
 =?utf-8?B?dDZGQlpzMElZbFdXLzA0ZFE2TVdFcVFpWW40SXZQY1VNZHhWUnhJQnVKNnhO?=
 =?utf-8?B?aFUrWFdoSW4zYkUzTmJuYU5zVUcrSk5aeU5tN0JrL0tyTkVXeFp5L1hRYkNC?=
 =?utf-8?B?SlRiay9xV3FBNFRYbDJQbDltbUkzeHJPV1RpQWUzVkhTNCs2b1U2KzVuN1Ja?=
 =?utf-8?B?NnN4cCt0NjFpMFp5TWVOcWttQmVFUS9TTHVnTEUrMHVla1lBUzJ1WitkY1ZD?=
 =?utf-8?B?Z3U5Rnc1a3ZKZDZIWXQzREFqTUhTVEt4ZU9vWE8vMGl4WnFES1FHd2pHREor?=
 =?utf-8?Q?EgtSkMEEz6ZxRUUlplI3Nd1bg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9da61e2-d534-48a1-fd72-08dd8b84f5ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 03:28:53.3882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VS8s/XFw81RbmEoXES98/yR7ludoT4Ny8ZRGTeAGK44op3M9ysPU2R1QU9QUi/3Cz2hYQ3RTS1aSncvN1jE2+3zoXjGgyg84D91Yv/ak4Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDEvMjJdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IFJlbW92ZSB1bnVzZWQgY29kZSBmb3INCj4gYmV0dGVyIHJlYWRhYmlsaXR5DQo+
IA0KPiBPbiAzLzIxLzI1IDEwOjI1LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gVGhpcyBjbGVhbnVw
IGZvbGxvd3Mgc2lnbmlmaWNhbnQgY2hhbmdlcyBpbiBjb21taXQgNGMxZDBhZjRhMjhkLA0KPiA+
IG1ha2luZyB0aGUgbW9kZWwgbW9yZSByZWFkYWJsZS4NCj4gPg0KPiA+IC0gRGVsZXRlZCAiaW92
X2NhY2hlIiBhbmQgImlvdl9jb3VudCIgZnJvbSAiQXNwZWVkSEFDRVN0YXRlIi4NCj4gDQo+IEl0
IHdvdWxkIGJlIGdvb2QgdG8gc2F5IHdoeSB3ZSBjYW4gcmVtb3ZlIHRoZXNlLiBJIHRoaW5rIHRo
aXMgaXMgYmVjYXVzZQ0KPiBzLT5pb3ZfY291bnQgaXMgYWx3YXlzIHplcm8sIHJpZ2h0ID8NCj4g
DQo+ID4gLSBSZW1vdmVkICJyZWNvbnN0cnVjdF9pb3YiIGZ1bmN0aW9uIGFuZCByZWxhdGVkIGxv
Z2ljLg0KPiA+IC0gU2ltcGxpZmllZCAiZG9faGFzaF9vcGVyYXRpb24iIGJ5IGVsaW1pbmF0aW5n
IHJlZHVuZGFudCBjaGVja3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGph
bWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvbWlzYy9h
c3BlZWRfaGFjZS5oIHwgIDIgLS0NCj4gPiAgIGh3L21pc2MvYXNwZWVkX2hhY2UuYyAgICAgICAg
IHwgMzUgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMzcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9o
dy9taXNjL2FzcGVlZF9oYWNlLmgNCj4gPiBiL2luY2x1ZGUvaHcvbWlzYy9hc3BlZWRfaGFjZS5o
IGluZGV4IDVkNGFhMTljZmUuLmI2OWEwMzhkMzUgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9o
dy9taXNjL2FzcGVlZF9oYWNlLmgNCj4gPiArKysgYi9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX2hh
Y2UuaA0KPiA+IEBAIC0zMSwxMCArMzEsOCBAQCBzdHJ1Y3QgQXNwZWVkSEFDRVN0YXRlIHsNCj4g
PiAgICAgICBNZW1vcnlSZWdpb24gaW9tZW07DQo+ID4gICAgICAgcWVtdV9pcnEgaXJxOw0KPiA+
DQo+ID4gLSAgICBzdHJ1Y3QgaW92ZWMgaW92X2NhY2hlW0FTUEVFRF9IQUNFX01BWF9TR107DQo+
ID4gICAgICAgdWludDMyX3QgcmVnc1tBU1BFRURfSEFDRV9OUl9SRUdTXTsNCj4gPiAgICAgICB1
aW50MzJfdCB0b3RhbF9yZXFfbGVuOw0KPiA+IC0gICAgdWludDMyX3QgaW92X2NvdW50Ow0KPiA+
DQo+ID4gICAgICAgTWVtb3J5UmVnaW9uICpkcmFtX21yOw0KPiA+ICAgICAgIEFkZHJlc3NTcGFj
ZSBkcmFtX2FzOw0KPiA+IGRpZmYgLS1naXQgYS9ody9taXNjL2FzcGVlZF9oYWNlLmMgYi9ody9t
aXNjL2FzcGVlZF9oYWNlLmMgaW5kZXgNCj4gPiAzMmE1ZGJkZWQzLi44ZTdlODExM2E1IDEwMDY0
NA0KPiA+IC0tLSBhL2h3L21pc2MvYXNwZWVkX2hhY2UuYw0KPiA+ICsrKyBiL2h3L21pc2MvYXNw
ZWVkX2hhY2UuYw0KPiA+IEBAIC0xMzcsMjUgKzEzNyw2IEBAIHN0YXRpYyBib29sIGhhc19wYWRk
aW5nKEFzcGVlZEhBQ0VTdGF0ZSAqcywNCj4gc3RydWN0IGlvdmVjICppb3YsDQo+ID4gICAgICAg
cmV0dXJuIGZhbHNlOw0KPiA+ICAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBpbnQgcmVjb25zdHJ1Y3Rf
aW92KEFzcGVlZEhBQ0VTdGF0ZSAqcywgc3RydWN0IGlvdmVjICppb3YsIGludCBpZCwNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKnBhZF9vZmZzZXQpDQo+ID4gLXsN
Cj4gPiAtICAgIGludCBpLCBpb3ZfY291bnQ7DQo+ID4gLSAgICBpZiAoKnBhZF9vZmZzZXQgIT0g
MCkgew0KPiA+IC0gICAgICAgIHMtPmlvdl9jYWNoZVtzLT5pb3ZfY291bnRdLmlvdl9iYXNlID0g
aW92W2lkXS5pb3ZfYmFzZTsNCj4gPiAtICAgICAgICBzLT5pb3ZfY2FjaGVbcy0+aW92X2NvdW50
XS5pb3ZfbGVuID0gKnBhZF9vZmZzZXQ7DQo+ID4gLSAgICAgICAgKytzLT5pb3ZfY291bnQ7DQo+
ID4gLSAgICB9DQo+ID4gLSAgICBmb3IgKGkgPSAwOyBpIDwgcy0+aW92X2NvdW50OyBpKyspIHsN
Cj4gPiAtICAgICAgICBpb3ZbaV0uaW92X2Jhc2UgPSBzLT5pb3ZfY2FjaGVbaV0uaW92X2Jhc2U7
DQo+ID4gLSAgICAgICAgaW92W2ldLmlvdl9sZW4gPSBzLT5pb3ZfY2FjaGVbaV0uaW92X2xlbjsN
Cj4gPiAtICAgIH0NCj4gPiAtICAgIGlvdl9jb3VudCA9IHMtPmlvdl9jb3VudDsNCj4gPiAtICAg
IHMtPmlvdl9jb3VudCA9IDA7DQo+ID4gLSAgICBzLT50b3RhbF9yZXFfbGVuID0gMDsNCj4gPiAt
ICAgIHJldHVybiBpb3ZfY291bnQ7DQo+ID4gLX0NCj4gPiAtDQo+ID4gICBzdGF0aWMgdm9pZCBk
b19oYXNoX29wZXJhdGlvbihBc3BlZWRIQUNFU3RhdGUgKnMsIGludCBhbGdvLCBib29sDQo+IHNn
X21vZGUsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGFjY19tb2Rl
KQ0KPiA+ICAgew0KPiA+IEBAIC0yMzcsMTkgKzIxOCw2IEBAIHN0YXRpYyB2b2lkIGRvX2hhc2hf
b3BlcmF0aW9uKEFzcGVlZEhBQ0VTdGF0ZSAqcywNCj4gaW50IGFsZ28sIGJvb2wgc2dfbW9kZSwN
Cj4gPiAgICAgICAgICAgaW92WzBdLmlvdl9iYXNlID0gaGFkZHI7DQo+ID4gICAgICAgICAgIGlv
dlswXS5pb3ZfbGVuID0gbGVuOw0KPiA+ICAgICAgICAgICBpID0gMTsNCj4gPiAtDQo+ID4gLSAg
ICAgICAgaWYgKHMtPmlvdl9jb3VudCkgew0KPiA+IC0gICAgICAgICAgICAvKg0KPiA+IC0gICAg
ICAgICAgICAgKiBJbiBhc3BlZWQgc2RrIGtlcm5lbCBkcml2ZXIsIHNnX21vZGUgaXMgZGlzYWJs
ZWQgaW4NCj4gaGFzaF9maW5hbCgpLg0KPiA+IC0gICAgICAgICAgICAgKiBUaHVzIGlmIHdlIHJl
Y2VpdmVkIGEgcmVxdWVzdCB3aXRoIHNnX21vZGUgZGlzYWJsZWQsIGl0IGlzDQo+ID4gLSAgICAg
ICAgICAgICAqIHJlcXVpcmVkIHRvIGNoZWNrIHdoZXRoZXIgY2FjaGUgaXMgZW1wdHkuIElmIG5v
LCB3ZSBzaG91bGQNCj4gPiAtICAgICAgICAgICAgICogY29tYmluZSBjYWNoZWQgaW92IGFuZCB0
aGUgY3VycmVudCBpb3YuDQo+ID4gLSAgICAgICAgICAgICAqLw0KPiA+IC0gICAgICAgICAgICBz
LT50b3RhbF9yZXFfbGVuICs9IGxlbjsNCj4gPiAtICAgICAgICAgICAgaWYgKGhhc19wYWRkaW5n
KHMsIGlvdiwgbGVuLCAmdG90YWxfbXNnX2xlbiwgJnBhZF9vZmZzZXQpKSB7DQo+ID4gLSAgICAg
ICAgICAgICAgICBpID0gcmVjb25zdHJ1Y3RfaW92KHMsIGlvdiwgMCwgJnBhZF9vZmZzZXQpOw0K
PiA+IC0gICAgICAgICAgICB9DQo+ID4gLSAgICAgICAgfQ0KPiA+ICAgICAgIH0NCj4gPg0KPiA+
ICAgICAgIGlmIChhY2NfbW9kZSkgew0KPiA+IEBAIC0yNzMsNyArMjQxLDYgQEAgc3RhdGljIHZv
aWQgZG9faGFzaF9vcGVyYXRpb24oQXNwZWVkSEFDRVN0YXRlICpzLA0KPiBpbnQgYWxnbywgYm9v
bCBzZ19tb2RlLA0KPiA+ICAgICAgICAgICAgICAgcWNyeXB0b19oYXNoX2ZyZWUocy0+aGFzaF9j
dHgpOw0KPiA+DQo+ID4gICAgICAgICAgICAgICBzLT5oYXNoX2N0eCA9IE5VTEw7DQo+ID4gLSAg
ICAgICAgICAgIHMtPmlvdl9jb3VudCA9IDA7DQo+ID4gICAgICAgICAgICAgICBzLT50b3RhbF9y
ZXFfbGVuID0gMDsNCj4gPiAgICAgICAgICAgfQ0KPiA+ICAgICAgIH0gZWxzZSBpZiAocWNyeXB0
b19oYXNoX2J5dGVzdihhbGdvLCBpb3YsIGksICZkaWdlc3RfYnVmLCBAQA0KPiA+IC00MzIsNyAr
Mzk5LDYgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2hhY2VfcmVzZXQoRGV2aWNlU3RhdGUgKmRldikN
Cj4gPiAgICAgICB9DQo+ID4NCj4gPiAgICAgICBtZW1zZXQocy0+cmVncywgMCwgc2l6ZW9mKHMt
PnJlZ3MpKTsNCj4gPiAtICAgIHMtPmlvdl9jb3VudCA9IDA7DQo+ID4gICAgICAgcy0+dG90YWxf
cmVxX2xlbiA9IDA7DQo+ID4gICB9DQo+ID4NCj4gPiBAQCAtNDY5LDcgKzQzNSw2IEBAIHN0YXRp
YyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24NCj4gdm1zdGF0ZV9hc3BlZWRfaGFjZSA9IHsNCj4g
PiAgICAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7DQo+ID4gICAgICAgICAg
IFZNU1RBVEVfVUlOVDMyX0FSUkFZKHJlZ3MsIEFzcGVlZEhBQ0VTdGF0ZSwNCj4gQVNQRUVEX0hB
Q0VfTlJfUkVHUyksDQo+ID4gICAgICAgICAgIFZNU1RBVEVfVUlOVDMyKHRvdGFsX3JlcV9sZW4s
IEFzcGVlZEhBQ0VTdGF0ZSksDQo+ID4gLSAgICAgICAgVk1TVEFURV9VSU5UMzIoaW92X2NvdW50
LCBBc3BlZWRIQUNFU3RhdGUpLA0KPiANCj4gVGhpcyBpcyBhIHZtc3RhdGUgY2hhbmdlIHdoaWNo
IGlzIGJyZWFraW5nIG1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5Lg0KPiBXZSBjb3VsZCBwcmVzZXJ2
ZSBjb21wYXRpYmlsaXR5IFsxXSBidXQgSSB0aGluayB0aGlzIGlzIG92ZXJraWxsLg0KPiBIb3dl
dmVyLCB3ZSBzaG91bGQgc2F5IHNvLiBQbGVhc2UgYWRkIGEgY29tbWVudCBpbiB0aGUgY29tbWl0
IGxvZy4NCj4gDQoNCkhvdyBhYm91dCB0aGUgZm9sbG93aW5nIGNvbW1pdCBsb2c6DQoNCmBgYA0K
aHcvbWlzYy9hc3BlZWRfaGFjZTogUmVtb3ZlIHVudXNlZCBjb2RlIGZvciBiZXR0ZXIgcmVhZGFi
aWxpdHkNCg0KSW4gdGhlIHByZXZpb3VzIGRlc2lnbiBvZiB0aGUgaGFzaCBmcmFtZXdvcmssIGFj
Y3VtdWxhdGl2ZSBoYXNoaW5nIHdhcyBub3QNCnN1cHBvcnRlZC4gVG8gd29yayBhcm91bmQgdGhp
cyBsaW1pdGF0aW9uLCBjb21taXQgNWNkN2Q4NSBpbnRyb2R1Y2VkIGFuDQppb3ZfY2FjaGUgYXJy
YXkgdG8gc3RvcmUgYWxsIHRoZSBoYXNoIGRhdGEgZnJvbSBmaXJtd2FyZS4NCk9uY2UgdGhlIEFT
UEVFRCBIQUNFIG1vZGVsIGNvbGxlY3RlZCBhbGwgdGhlIGRhdGEsIGl0IHBhc3NlZCB0aGUgaW92
X2NhY2hlIHRvDQp0aGUgaGFzaCBBUEkgdG8gY2FsY3VsYXRlIHRoZSBmaW5hbCBkaWdlc3QuDQoN
Ckhvd2V2ZXIsIHdpdGggY29tbWl0IGUzYzA3NTIsIHRoZSBoYXNoIGZyYW1ld29yayBub3cgc3Vw
cG9ydHMgYWNjdW11bGF0aXZlDQpoYXNoaW5nLiBUaGlzIGFsbG93cyB1cyB0byByZWZhY3RvciB0
aGUgQVNQRUVEIEhBQ0UgbW9kZWwsIHJlbW92aW5nIHJlZHVuZGFudA0KbG9naWMgYW5kIHNpbXBs
aWZ5aW5nIHRoZSBpbXBsZW1lbnRhdGlvbiBmb3IgYmV0dGVyIHJlYWRhYmlsaXR5IGFuZA0KbWFp
bnRhaW5hYmlsaXR5Lg0KDQpBcyBhIHJlc3VsdCwgdGhlIGlvdl9jb3VudCB2YXJpYWJsZSBpcyBu
byBsb25nZXIgbmVlZGVk4oCUaXQgd2FzIHByZXZpb3VzbHkgdXNlZA0KdG8gdHJhY2sgaG93IG1h
bnkgY2FjaGVkIGVudHJpZXMgd2VyZSB1c2VkIGZvciBoYXNoaW5nLg0KVG8gbWFpbnRhaW4gVk1T
VEFURSBjb21wYXRpYmlsaXR5IGFmdGVyIHJlbW92aW5nIHRoaXMgZmllbGQsIHRoZSBWTVNUQVRF
X1ZFUlNJT04NCmlzIGJ1bXBlZCB0byAyDQoNClRoaXMgY2xlYW51cCBmb2xsb3dzIHNpZ25pZmlj
YW50IGNoYW5nZXMgaW4gY29tbWl0IDRjMWQwYWY0YTI4ZCwgbWFraW5nIHRoZQ0KbW9kZWwgbW9y
ZSByZWFkYWJsZS4NCg0KLSBEZWxldGVkICJpb3ZfY2FjaGUiIGFuZCAiaW92X2NvdW50IiBmcm9t
ICJBc3BlZWRIQUNFU3RhdGUiLg0KLSBSZW1vdmVkICJyZWNvbnN0cnVjdF9pb3YiIGZ1bmN0aW9u
IGFuZCByZWxhdGVkIGxvZ2ljLg0KLSBTaW1wbGlmaWVkICJkb19oYXNoX29wZXJhdGlvbiIgYnkg
ZWxpbWluYXRpbmcgcmVkdW5kYW50IGNoZWNrcy4NCmBgYA0KDQpUaGFucy1KYW1pbg0KDQo+IFRo
YW5rcywNCj4gDQo+IEMuDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9xZW11LnJlYWR0aGVkb2NzLmlv
L2VuL3Y5LjIuMC9kZXZlbC9taWdyYXRpb24vbWFpbi5odG1sI3Ztc3RhdGUNCj4gDQo+ID4gICAg
ICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKSwNCj4gPiAgICAgICB9DQo+ID4gICB9Ow0KDQo=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE71C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 04:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDEvn-0002zX-VU; Fri, 09 May 2025 00:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uDEvk-0002rK-1x; Fri, 09 May 2025 00:01:49 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uDEvf-0006Eb-35; Fri, 09 May 2025 00:01:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyvUvu59DG8FhyF4I2O6MenTGXEtWJgldVqG/HUAOC9S6Y7jVfPEzEseXGFfl2K9ZBRfE2ptf9O3nI+2cX100lTDtR1cZLUtgwOmJooT4Ngn1QKylN2XIWqptLdkV2dfPpR66UGo6au0sEcU5QtbCt6kJKslYplEIdor7XZcKnYdSf0y8eGQBCeHfvdW/WSm3KP4DHseGMaHudJQwuW7TFztaVshNR0HHD8UPNHnE/8DODA5a0WyciLBdXXKqmYW8aW0ps0X9l4/Y8PnaPz9QZVwwRq5rw4d/o93irj1shi20Cfx9UxHL1d+DCPrEx8IeK/BJFT9w2S2e8I6RY/N7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TH+UBgcMDbxk0mQkBnw1cXzm77zoG/Yb8VZ6wIpDCFI=;
 b=nViMZGYwi6Ht4NsbP73DYEqYWZ//OAyCL1l02T6tT0RyCDK4EPzDIVyQiMaj8lyUKKo3BspZtbC/saBf2Un7IYKTbHLIccSoSX/CZFepnzQy2SgJMFEkt/UsZsCGLdvpvHpmIcrk+zwIsUzTPhRQuJSFsIw7KirpJCiPj1ayS/9kqRP07CMwzgbvdOwC3iA5EvHRaEWUxVYX1KhAazbY2C6+FSNttO9V+ULnMlzQy9zeAgopLzu6qNLkyO98U5q/7hPIuewIWVR+dakVp+dUAIHdHKHPRwQVzPNIAEBFdH0R9fGY14KaOK+TLcBn/92b0boex80a7rukC4mr27zX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH+UBgcMDbxk0mQkBnw1cXzm77zoG/Yb8VZ6wIpDCFI=;
 b=CJltD8MCKwJPQe6OrnlrzYr2JpTom6KTors74VO9dfSfTk17iDBaosVCfjeVzM/U7Q+IVrJcSvCTHf8Oz/qsNlCAhUfoWdPhRcpEdBfzIBaLjiHZ5XxxLWrHbnVea6Aznmr2n2GA+e3SuONJH6XPHmgGyH5OSyXYelAK0RGVMgLGK/JU0LO/1E0eWYzeC7gAPcjXypF74teaCgwbzVrZLbI2CQmyb6E0dbklZBhP0yqreH0GRbC4cgO2hd5GkCoeCdFmFL17ryLEkRJPCFy3bapUntMmxtDBbZBdIXRXEQbNVe+ZrTRw62nTG4hERvgSgnVv9P1tKVoxqkUcBYx+Ew==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB5896.apcprd06.prod.outlook.com (2603:1096:820:db::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.23; Fri, 9 May 2025 04:01:30 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 04:01:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 05/22] hw/misc/aspeed_hace: Introduce 64-bit
 digest_addr variable for AST2700
Thread-Topic: [PATCH v1 05/22] hw/misc/aspeed_hace: Introduce 64-bit
 digest_addr variable for AST2700
Thread-Index: AQHbmkNUI3zeJooYqEWd3yBkDzo/0LOO5s8AgDsPjWA=
Date: Fri, 9 May 2025 04:01:29 +0000
Message-ID: <SI2PR06MB5041EF9B6F778B3BC466F38AFC8AA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250321092623.2097234-1-jamin_lin@aspeedtech.com>
 <20250321092623.2097234-6-jamin_lin@aspeedtech.com>
 <2731580b-f20e-44cf-beed-e61e5b792e9f@kaod.org>
In-Reply-To: <2731580b-f20e-44cf-beed-e61e5b792e9f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB5896:EE_
x-ms-office365-filtering-correlation-id: 2fe2f3e6-5089-4243-f61a-08dd8eae2db7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RDYvNVp0Znl3cyt0ZEJIekZTZjk0ZndVeUZMZUVJRTRsVURVZGlMVlExOU4w?=
 =?utf-8?B?MUo0anRUbjU3TG5OZE4wZ2pqdEhkNnpWWWtDUThOWTErajlTdWlaZDVXeDlJ?=
 =?utf-8?B?R0VySW5NNE5aUXFuMnA1ZVE4L3FmYmJQMVkxSDM5RG0rcWFsbnFicHRJaWtu?=
 =?utf-8?B?RFZqM004akZJQjE5eHU2SDhjQnhzV2tVd1BJMW10TjBDclUvaFJQcXo3N3Mw?=
 =?utf-8?B?cVM5UytDZFFwa2RPTUtVNzFkeHRMUUcxNHc1aXdSVlQ2Z0RZaVprWW1OYnVt?=
 =?utf-8?B?MVRvaEVKNExhT0c0bStMUHZPc0FxL3lhU3FTcHN1SER1Nlo4M0orZEJGMmFI?=
 =?utf-8?B?V01Tdlo4Y094amhxMTZBWTF3L05zeVJITHNHRnpROWlLNVpkSjBieGVOdW1F?=
 =?utf-8?B?QlRpSDBsSU94YVRDQkJZbHF5NzhCUGgxZlFlNEhPNy9VWXZpdFJDdWcrU1pU?=
 =?utf-8?B?c1VDZXNwRG9PcS9qWkxaeDQvMndIYUluQTF3UThXK0FKSGpkM1FkSTZJZ0s2?=
 =?utf-8?B?TjBvNXViY0Y5WThvOTYvRm11cyszVk95cjFpSldkRkhVU3VxRnM5aXRrZ05n?=
 =?utf-8?B?SnRjN2dNM1F6ZktBREkrSXMvOUNEQUJndHFtTyt6azlmVXRhcjl0WVN3WW9m?=
 =?utf-8?B?b09Gd3A4aVBOOFdDS3FJRURaamUxYk1uYlpNNmVmdnlETXk0eDZIdWo2YkJL?=
 =?utf-8?B?WE5Da1l1VldDdm5IUFVCUStqMURCUnczcUMvUFBVMkNCdHlpZm5MSHFDZ3Ey?=
 =?utf-8?B?V1N3RnptbWNaRCthRitEV2hBRXQwSjVYeWZHNGNCWWx5dEF5enhmSlRPbnRK?=
 =?utf-8?B?bDJGVGYwTEVvZTQ3OE9zcEtTMG9xZ0VBemZDSEtFNjhKbVQ3Q0lhSm1NR0kv?=
 =?utf-8?B?Z05nVmg4d2VRNllKMm1GbTdRUENyWmVKWTdPUW5QeStSUGs1d2xxT2RZcE5k?=
 =?utf-8?B?eVRxQkZHOEdLUllMY0NiS0xjRllHMjNmc2Q0NUxkSGhrN2s4ZGJ4YUoxRHl0?=
 =?utf-8?B?L0dwazZWaGFSN0g4YWhLc0tQRWRYdzVKeGpPSDNsYlg4Nm1SWXJ4byt4L1V5?=
 =?utf-8?B?S2xWdm1xZ3pOd3hoblpkVzMvd3NKRkVNUHlISXBVUWV4NjZ6VmFIUVlyUUhr?=
 =?utf-8?B?MEtucDNzOUZwekZmeldmRGJ6WXp3bFM1WUtIK2F3NUdkaCtDSHlOOU9mOFN6?=
 =?utf-8?B?U216WmRlOXp4UjY5Nzc0WVB6dHJpbnBCbFZmT01vM1dONWhWTENMYkRwdm9l?=
 =?utf-8?B?NGtibFpCaGpKTmVMSjZiUjM0K3l0NW02eVNWUFYvd1VsZm1VWFhQWmtmcm15?=
 =?utf-8?B?RURXbmRvZFVXZlVEODl3K1JTNDUyVzliK3pZYkl5a0hUd1FPMWR5QlZyL3pn?=
 =?utf-8?B?Q0xNcUFuUVYvT1lQTkwvV3NsdW9HeEFTOFJjRFdwQzdGOWdnTE4zYW5ZdmQ4?=
 =?utf-8?B?ejlmL0JZQ1Z2SkZBeThzcHRId1BvQWNhSW5OdmlUUWw3K0w5VnU2ajI1V0VI?=
 =?utf-8?B?cGFTbXB0ZzRCSWI5cUE3NUs0OFVTVXQxR0I0QUdGKzJJZE5yLytrYmlLZnht?=
 =?utf-8?B?U2FFNVZrR1NOMUx3MEtnMkRIYWJyYzZ5ZngwTUJocjIrNDExdGRSREp3SllR?=
 =?utf-8?B?UjM4WHo3K3kvV2JwY1J0c1NTbitKdFJ3SUFmellGVFNVSFNySEQzYnhPeVFU?=
 =?utf-8?B?ZDNST1RDUTJiMjRsdFJXZHducUZEN292NmVITDJFYnJxNGFpOEVpbEpRRW5V?=
 =?utf-8?B?THhSOGZueEVqQlB6aE9iS1R1NDdZekRJdGN1Q1hjMlNQMzNxejlZWlNod2NG?=
 =?utf-8?B?YWNmYVR5Um1lSWZaWERYREErSmU4V1IvZjV4VHpaaDhFdloyUlpLd1I1NlMy?=
 =?utf-8?B?cm5JZ29aVWkyR0VuY2JYVmRpams4Wnh4MkxzR3dDUTRpS21CejZKNklLUXhB?=
 =?utf-8?B?LzdRb3NPS0VMWFo2S045bTQyZjVGQTJ5eWhXQWdBd25kOTUzOCtxZWZZQytw?=
 =?utf-8?B?c3RiWDZvcEF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QS93YmFqVGxEbHFLempoQ1ZuUkNPMTRmTzBzRmd1U1pxRk5kcFB4Sm5obCs0?=
 =?utf-8?B?TEUwMWhNUFZod0FscFJhamhRYis1UzNtNUVRcmFSdWI1ODZaTDdoV2ZrYkVH?=
 =?utf-8?B?aEtBdkNlSUVkREVScUZQWHR6YWFSTUtmaDh4aGtQNFRNY2FWZzk0bGFhNmU5?=
 =?utf-8?B?eWFUdEkxamFPUGpxMjAzOXhKWTNyRldiU3pZeXhxSXQ5cHhFNmwwUy9mTEFy?=
 =?utf-8?B?SWZpWWJNWDRGVi94SVdYVmR1cXczSENxekd5OXhtcmlJa3NQZml5bVFQY0Ir?=
 =?utf-8?B?WVdRa0ZGOG9zSklRQmh2bzliRVJ5QXRGdHVQeWF1MU00bmIrMnZkdkhVNDlB?=
 =?utf-8?B?WndpanpIQXF4RlVMZ2h4cDYzN01md28wNkJQMkNVcEwvSkpDcXpXSlpaVnh3?=
 =?utf-8?B?QW5EeXVtR0tjL3BOcldMWEdkZkE1Ukd3clJlZlQwNFZFL2tVbEJSUngvdDJS?=
 =?utf-8?B?OVlJRDloK3pHem15eVhqLzVlenlYTkVqbDNWQ3h4RkN5NGdqMVd5eHBuWE40?=
 =?utf-8?B?SDVJZFBqRjhZb0tNMkEyc0wvd2xrQ1o1aXMycktpZ2pVRWZsS3lMNDVObFNO?=
 =?utf-8?B?U2FnN1lmeXZCaXI3ZGl2N3B4T3I4SmZ6cjNET1RmTFY4L2tiQ25mY1lkWE5J?=
 =?utf-8?B?ZVlNUituUVBoY2hqREd6NTJHZVNHWW5yb0Zndi9iYzY5S1drcms5RnBESVpX?=
 =?utf-8?B?OC9VRkg5dFlHczc2d0pxQjNNOXN1S09hK0tZNlU1MnVwM3ljK0h2Wkt5bGdq?=
 =?utf-8?B?bFZIWWwveDYxMWNRTFhwQWhaU3Q2NE9ZR3VibHZGRXVMejQ4MnJFaWhlRktj?=
 =?utf-8?B?QnNzVmhHUmtOcVNUMkF1OGxVa0hJNFBXbGEramtHeXdFTTh2a096MUN1YnVr?=
 =?utf-8?B?dmtweXRSbXhoeTlXNmlCSkhYT1NuMGVvYnpZc0l5dnFyQ2lJWWdXOURUN0lh?=
 =?utf-8?B?LytxNE42c2FUN1JscTVIayt5YkhFS2x0M3VxTkhEekpYMWtySGRoM2I4TC9O?=
 =?utf-8?B?R2V1UGY4aE8wdC9uQ0MrQjFwd2l1Q280OFFvbWgwZDQraHFjLzE5N2hKc0ZR?=
 =?utf-8?B?S1Qxa2tFSGY4ME9ITVpEL3NHZEpRQ0ROa25lZG1JNlJrYUM2TURFdHRVa2hU?=
 =?utf-8?B?aTJ0ampZQUZXRi96VkZacFVvYTUwQlhEelJhS1ZZWGJTbHdFK1p1ZjRlMXRX?=
 =?utf-8?B?aDc0VW5nUWhjYjVYaTJkdkN6cmJyNWc5bVFtSUJlSjBvWUo1a285RGFVanRR?=
 =?utf-8?B?bTJmL0tKSGhkQS9tMVUvVXB2dVh6LzdTUHg2UWlFTWJsZFhlTTNRaGFLSzBs?=
 =?utf-8?B?K09qdGtPVzFmMURDM08yNlBTR1JmWEhkUWNXNlFBazlXblM5M1hXWHF5dE54?=
 =?utf-8?B?NFJqVWV5Sis4Wjc0NzIveUtBLzhaZ3dXNWtvRGZ2bGlYeGI3S0xIOHRHR0My?=
 =?utf-8?B?R3ZkdU9QdTZOQnhwVUhwSDJidDBiZ0ZlNkZqTk85ajBtOWh1d2lVL2x0OFBF?=
 =?utf-8?B?VUZUaWczaHJZam9nVWhpMDFlSUIxTmhyaFRTVDNSRGZwc0lRWmFpMWRjM012?=
 =?utf-8?B?KytXak5HZWI2RFFJSjdTMzBTYWtkdWg5NExCUXdRZjhDbzB1V2haTmpJY0JI?=
 =?utf-8?B?SythbWpxc0R5aUIrWHBoVW1RYldpRHZBOXVZeFlFaG1Xa3B0bGc0RXZKSjVU?=
 =?utf-8?B?ZTJReUFmelZpS2wreGZEb3NYS2dwWGRvM0NYSjg0N21RSDN1aFNYUlJxY28w?=
 =?utf-8?B?YWxNR1FEUXdMZDVOSFprcTRxSGZGUFlYeWtzVjY5VUtIVkFKd2hDV2NIOVRI?=
 =?utf-8?B?aUptY0l1WWtJZzlYcmVjK3cramNXaFREWDg1bnFRd1NzUUJuVHNNOEJ4SG5h?=
 =?utf-8?B?cnRwRzZwV0tiN3BWdU93bGRtRmpkbnJCbVR5SytOVE9JdTJ5UmEzQ3k2VWUx?=
 =?utf-8?B?dTNiWGR4QmQzM3o1WC8rWTlJNUNGL0lNWG95MWZmK2YxQ2hacHlGUElaWTYv?=
 =?utf-8?B?bitUdFFtQjRCQXZGdE5zbFRLVnpRSUNnQ2ZzWjNLNlliaW0rdnJVZ2RxWmQ1?=
 =?utf-8?B?NndReFRjWFZFSitRYk5vTDJJRDFsc0Z4K1VudmY2L1lFNDM3WnF1OVcvWGlq?=
 =?utf-8?Q?5+2bjWrITcb9tpshLj6kqBLhU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe2f3e6-5089-4243-f61a-08dd8eae2db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 04:01:29.8750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dJhwfQfKfv3cSpQQ93USrlBQmtN69vLz/fq6nwgGpFcQl1uXk2DVkYvp7066cC3noE4bHGqnGtyUYpX5Pl6habdl32ud4kuSv+uH1ZwGP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5896
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDUvMjJdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IEludHJvZHVjZSA2NC1iaXQNCj4gZGlnZXN0X2FkZHIgdmFyaWFibGUgZm9yIEFT
VDI3MDANCj4gDQo+IE9uIDMvMjEvMjUgMTA6MjYsIEphbWluIExpbiB3cm90ZToNCj4gPiBUaGUg
QVNUMjcwMCBDUFUsIGJhc2VkIG9uIHRoZSBDb3J0ZXgtQTM1LCBpcyBhIDY0LWJpdCBwcm9jZXNz
b3Igd2l0aCBhDQo+ID4gNjQtYml0IERSQU0gYWRkcmVzcyBzcGFjZS4gVG8gc3VwcG9ydCBmdXR1
cmUgQVNUMjcwMCB1cGRhdGVzLCBhIG5ldw0KPiAiZGlnZXN0X2FkZHIiDQo+ID4gdmFyaWFibGUg
aXMgaW50cm9kdWNlZCB3aXRoIGEgNjQtYml0IGRhdGEgdHlwZS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+
ICAgaHcvbWlzYy9hc3BlZWRfaGFjZS5jIHwgNCArKystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcv
bWlzYy9hc3BlZWRfaGFjZS5jIGIvaHcvbWlzYy9hc3BlZWRfaGFjZS5jIGluZGV4DQo+ID4gOTc3
MWQ2ZTQ5MC4uOGNmM2YxOTRhNSAxMDA2NDQNCj4gPiAtLS0gYS9ody9taXNjL2FzcGVlZF9oYWNl
LmMNCj4gPiArKysgYi9ody9taXNjL2FzcGVlZF9oYWNlLmMNCj4gPiBAQCAtMTQ4LDYgKzE0OCw3
IEBAIHN0YXRpYyB2b2lkIGRvX2hhc2hfb3BlcmF0aW9uKEFzcGVlZEhBQ0VTdGF0ZSAqcywNCj4g
aW50IGFsZ28sIGJvb2wgc2dfbW9kZSwNCj4gPiAgICAgICBib29sIHNnX2FjY19tb2RlX2ZpbmFs
X3JlcXVlc3QgPSBmYWxzZTsNCj4gPiAgICAgICBnX2F1dG9mcmVlIHVpbnQ4X3QgKmRpZ2VzdF9i
dWYgPSBOVUxMOw0KPiA+ICAgICAgIHN0cnVjdCBpb3ZlYyBpb3ZbQVNQRUVEX0hBQ0VfTUFYX1NH
XTsNCj4gPiArICAgIHVpbnQ2NF90IGRpZ2VzdF9hZGRyID0gMDsNCj4gPiAgICAgICBFcnJvciAq
bG9jYWxfZXJyID0gTlVMTDsNCj4gPiAgICAgICB1aW50MzJfdCB0b3RhbF9tc2dfbGVuOw0KPiA+
ICAgICAgIHNpemVfdCBkaWdlc3RfbGVuID0gMDsNCj4gPiBAQCAtMjU3LDcgKzI1OCw4IEBAIHN0
YXRpYyB2b2lkIGRvX2hhc2hfb3BlcmF0aW9uKEFzcGVlZEhBQ0VTdGF0ZSAqcywNCj4gaW50IGFs
Z28sIGJvb2wgc2dfbW9kZSwNCj4gPiAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgIH0NCj4g
Pg0KPiA+IC0gICAgaWYgKGFkZHJlc3Nfc3BhY2Vfd3JpdGUoJnMtPmRyYW1fYXMsIHMtPnJlZ3Nb
Ul9IQVNIX0RFU1RdLA0KPiA+ICsgICAgZGlnZXN0X2FkZHIgPSBkZXBvc2l0NjQoZGlnZXN0X2Fk
ZHIsIDAsIDMyLA0KPiA+ICsgcy0+cmVnc1tSX0hBU0hfREVTVF0pOw0KPiANCj4gQXMgb24gdGhl
IHByZXZpb3VzIHBhdGNoLCBhbiBoZWxwZXIgd291bGQgYmUgdXNlZnVsIGFuZCBpcyB0aGVyZSBh
biBhbGlnbm1lbnQNCj4gY29uc3RyYWludCA/DQo+IA0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IGFu
ZCBzdWdnZXN0aW9uLg0KSSB3aWxsIGFkZCB0aGUgaGFzaF9nZXRfZGlnZXN0X2FkZHIgaGVscGVy
IGZ1bmN0aW9uIHRvIHJldHJpZXZlIHRoZSBoYXNoIGRpZ2VzdCBhZGRyZXNzLg0KVGhlIGRpZ2Vz
dCBhZGRyZXNzIG11c3QgYmUgOC1ieXRlIGFsaWduZWQuDQpUbyBlbmZvcmNlIHRoaXMsIHdlIGFs
cmVhZHkgZGVmaW5lIGEgImRlc3RfbWFzayIgY2xhc3MgYXR0cmlidXRlIGFuZCBzZXQgaXQgdG8g
MHg3RkZGRkZGOCwgd2hpY2ggZW5zdXJlcyBwcm9wZXIgOC1ieXRlIGFsaWdubWVudCBvZiBkaWdl
c3RfYWRkci4NCg0KUmVmZXJlbmNlDQpodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2Jsb2Iv
bWFzdGVyL2h3L21pc2MvYXNwZWVkX2hhY2UuYyNMMzY1DQpjYXNlIFJfSEFTSF9ERVNUOg0KICAg
ICAgICBkYXRhICY9IGFoYy0+ZGVzdF9tYXNrOw0KaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVt
dS9ibG9iL21hc3Rlci9ody9taXNjL2FzcGVlZF9oYWNlLmMjTDU4NA0KICAgIGFoYy0+ZGVzdF9t
YXNrID0gMHg3RkZGRkZGODsNCg0KRm9yIG1vcmUgZGV0YWlscywgcGxlYXNlIHJlZmVyIHRvIHRo
ZSBIYXNoICYgQ3J5cHRvIEVuZ2luZSBzZWN0aW9uKEhBQ0UyNCkgaW4gdGhlIGRhdGFzaGVldC4N
ClRoYW5rcy1KYW1pbg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiA+
ICsgICAgaWYgKGFkZHJlc3Nfc3BhY2Vfd3JpdGUoJnMtPmRyYW1fYXMsIGRpZ2VzdF9hZGRyLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGlnZXN0X2J1ZiwgZGlnZXN0X2xl
bikpIHsNCj4gPiAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsDQoNCg==


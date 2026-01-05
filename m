Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32988C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 07:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcfFB-0004RB-TP; Mon, 05 Jan 2026 02:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcfF5-0004QX-W1; Mon, 05 Jan 2026 02:43:08 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcfF4-0007Tl-A2; Mon, 05 Jan 2026 02:43:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1e7ZnhT3T2g5isEWpSWQZQU7SXbBBxLu8yENhM18zw1jcXGD7oReaN2RRvholjtIxWZCxQF3seSFIGX56y7x92F93Z/Sos44/1kJr2Du3+xGQycCmDLWugIxluxwvXllDfxpS8cn9iq9lhd1Ra3qWQgjXcmkT1k3LZMu3iJVrt2CUP66JWWxYc4L87KSJTLE/1dj77U4fbjGwzI4drBkMvXQQabjSDs0NWTGwqoZ0WkN+jILERAlnOrnFDFQi1gMA/dpEy2hN6pN1vrnZ8ncHCICjnDhbdGIEPbW9WVQ+dx/ss7qqBV+UAP0SZjDREt8XMCxs6Goc22eS/peRkIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkYxI4+M6gs1aTev2h8DovG6dzCsjDymJqa+7CVgWEI=;
 b=jeCa5Xh3UZyE0ka1YfN4VaifFNocx9fs7XzPy677k/GtFLIzDbmXAtvihz0V+9Vbrf8OuF74SDOZqrOA5qsyzhty1P18iAL7TXe4WvSEy3iqM0BHHSAUhWaTxjd7OYVKXj46OFB1Re9dZEu2G6YqHooeTsqnpdPR7EBSkPLjemgEvvn5A7kIMOQZsVF0pBZ56Q8awJ+ZzWEuG4f4NjyUGC8cnV290pkCSDFUPs5bR0+0LMP3vXAWW8O5RVo31BRgejzDs9H1oXOZh06KNy16bKOyVXBBaLzYSzx4OsbbhNw99lUxs3R4shRVizCLfeeRtsMG1AaweYs7qFnB2z5PpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkYxI4+M6gs1aTev2h8DovG6dzCsjDymJqa+7CVgWEI=;
 b=bCKw+RMYUnaE7OzojvYCojJiiIfiTPrPhhtElXJQB7U7m+fu8w7eBqq8jLMxzFzXINJpK784CsXH+kt6t9S8wbQlRkuex7HT0PW7vd4MH4RU6s0l1glOLWTIG9E+HBo+l9Tobtj52m9NplQvDqJ4IZXFA1hLfB+lUrPzxowl6HfObJbh9Wljkw+XRVaIcAAkwtC6zkAl9btEeX5FmSFZdgEfYl+098rEPxT01OHf2FBaEG0hjPAzDl7of17BbuQJQkfP6F9gZLlKH5KnrC1l0SWN7Xbzrb3Y6F6j/i5jAhjkeLh6kxIMqa5HNKXmv2mrOy4Gm4Lgu95Kbb5A3x3qWA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB7137.apcprd06.prod.outlook.com (2603:1096:101:232::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 07:43:01 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 07:43:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 11/19] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Topic: [PATCH 11/19] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Index: AQHb2/a+fuaDGeq1KEyLPkKVImFc87VEddNw
Date: Mon, 5 Jan 2026 07:43:00 +0000
Message-ID: <TYPPR06MB8206F2E68E6C130459184703FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-12-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-12-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB7137:EE_
x-ms-office365-filtering-correlation-id: a0ff2337-9b17-45b1-8efb-08de4c2e0d57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?V0FzWEN2MzBlREVndGZ1NFVPV3dobDczeWtTdlowOTVCUmFPSnhNQzhHQk82?=
 =?utf-8?B?U05OL3lYa0ZFdEJ2ajNxYWdKcG1KUGs4ZThCTEVweVJHcmF3dDU4U3VMNlFm?=
 =?utf-8?B?RlBoNm1vTTA2R1d6azVvMFZUVUx6YWk0ZTNYcWRhN1Vjc2JLSTVoN0lyYjFz?=
 =?utf-8?B?dFJnakpXTlJ5SGlMQ2dsVFhVZ1loQVI3cnptUDVPN2ZZQzdBQnFFanBEenYw?=
 =?utf-8?B?RTlMTmJncXpzWEdpcTl5bVZZWE45UUs5WXVGWlBJYW1qUWNCc3NUTksxS3h6?=
 =?utf-8?B?V3dJSDk1clVXZlpHZmhiQVV4YXIwc2JwNTRsYXFacDJob1dNZDU4RUl3T09S?=
 =?utf-8?B?Q1NuYWZJMzN0d1lzZ2JyLzVrMVlGL2tENXoxckJmVHl5bHFyZ1BPQ0JKbGxR?=
 =?utf-8?B?YUVUTDNxNGVwN2ZuQUpCcEJ6WjZLUzRlVDRFUWJNV0hlUHB6Qm5iRjJYV1Uw?=
 =?utf-8?B?N2p3MldUOTBBZFVlUEh1Y3JNeisvaXlsUFdjZEQ2cmN1RSt5VzR3QWx2N3RW?=
 =?utf-8?B?aDFhNjJrT0ExRHJuQ3F1RnJxNVJmWTdwYVhQV3BtaFBFSmZyU3A5VWRMNCt5?=
 =?utf-8?B?N1ZmV1k5SDcrT2ZGZHJ1cjZ0S1FUYkJ6ZU83TGduV1phYkgrY0ZxdlhCMkov?=
 =?utf-8?B?QXVLZmVMMzVacElJMW5SbU04bkorNSszVVFLTVA3N1VDYjdQa0sraW5SYlMz?=
 =?utf-8?B?RzFWMStpc0hGMndsRkg1TnRXbkpjTXpMVEh4cHc3aUxSZUJJT2dML0h5WWRr?=
 =?utf-8?B?WkQ3bmtZclV2VU5jY2s2d1Y3RWozWkw4cHRRb2lsMDlndkduL3BwVGVqOWFu?=
 =?utf-8?B?UjlSSS9YR3JYRU1zZnhSNCtmZ05hWXNxQnlxeG9uT0VJWncrNjVWcmxxbkpV?=
 =?utf-8?B?NmwrL21YcGNWZFM0Q05ZeGVESEw4TVhiRVNxVGRZSFVKbUJEOTEyaTd2VDNW?=
 =?utf-8?B?NjlMWXpFRlJkb0hYcUtGdXovZWIwK29zK1hWMTFhSjhqTHl1Q2V4WDRubDBV?=
 =?utf-8?B?aWR6WkZZVGpITGZqc25jeTNmR1Q4eERINTZOUjlIeGw5Nm80TWU0d2pDK2Ft?=
 =?utf-8?B?RlZKeU9ZYTdyVUZycmExaTN5V040eTZtYzh0eTlGallxT01FeWpWejJMTE0z?=
 =?utf-8?B?VTNjZGNFUWpPZ0psalRzeHcxbzNjL0MvTVFwTktrMUF2bCtodFA2MEZ0UWFv?=
 =?utf-8?B?YzFnbmZMRmd1eGVRa3FQQ0hHTmw2T3l2cmp1LzI2R3F1ZEtVNW9SS3ZMaTlT?=
 =?utf-8?B?b3lmcXVmNnpwNkx0L1ZMdUFWcENhVW5KcHMvZ3NNRGNOVmlYT2JUSEVydEtr?=
 =?utf-8?B?ZTBodVBrMERxaUtSYXdKUzRHTzJUZ3QxUzFLa0pGeXNGOE1jSWJ6L08yazhp?=
 =?utf-8?B?MzhyanB0enRHWTRsbDU3QW4vbHlkMnEyYWdtS29hNVJsbnM4N3ZuSytGbE00?=
 =?utf-8?B?RHdkalZ0UUg1SHloM3U3cUpWSVFjZjRhV0hSdnlXSEJEcTVDWGxScXExM0wx?=
 =?utf-8?B?Y1BPN1BkM0ZTbE9XWFFNbVFUQUtlUXRxVDRPZmYxbURaSW5Uak93K0UvempK?=
 =?utf-8?B?L3FqQk9NMmxoQ1FyQ3RpaVVmbGxIQjNiZkNYak5aMUxsMW56VTNUVDl2c01o?=
 =?utf-8?B?N1NGZDNYT0I3emRSWlRGU2l0NFdPSEpyQnlTQ3ZjY0hheGhGUkYwODNBWURN?=
 =?utf-8?B?L0hLckJVRndDZklPZTFLV3V4ZkhxQUkzMTFmWE4rVU8rUGJ0WSt2dXdsQlBT?=
 =?utf-8?B?Uy90RXpFUnNNSFZudGdHck1IVWNGQm14TlN6T3MyVkdLNjhWVGlmNk5QeDNk?=
 =?utf-8?B?a3RCOCtNWlp2ODRCTzB3QXI1bjc4M0ZvclpwYTRicGtjK0w5N3J5MmMyRWxL?=
 =?utf-8?B?WDd3aXVUTjdpdmlVTUdHRzluMURRRzlwTk1WdzBxc2FXb0dFbXBrL3BBRDJK?=
 =?utf-8?B?aExDQko1cXFwaEU5Y0hNM1VGaEp6bnE0TXN5Smo2OXRBRVVwWEpmOGN5U3oz?=
 =?utf-8?B?T3VNWlZBMHNGRFBUTThUVEE4cDg5bmhFMVBJejQ5RThRM1ZGYkdlYnFObFlM?=
 =?utf-8?Q?PP/3x2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDBRQnBiR0hGbURzamxQSEptL2RiUzl6bzhaZFRmWGI5S2psRzZBWndXWEJi?=
 =?utf-8?B?Q2JnZFNCcFZhUUlUVVo3YVNwUXdYRnpaV1BtcU1JbnV1Ui9ieVpmelBSbnZJ?=
 =?utf-8?B?L2JKTFBNRmNUdTRETXNUeG1yT2w5U3hXcFBUUWptcG1Nejgvd0NPOGV3ckxX?=
 =?utf-8?B?V05CK3ZHdnB6V2FpbGJSdFVyL0s2ZUM0VkZpZTRnRHZ3YUpJZVVST3d1bmZR?=
 =?utf-8?B?S2pjY0tjWkVSSWVFWmlGRm5INlgvM0pMOUpnaVcxT0lUR2VDT0hYYllmVUJN?=
 =?utf-8?B?RVZDZnp6MDNpcVBHdG1PZkVoQ1RhOGlGQUUrVUo5WUt0K1hRSStvTTFCZzR2?=
 =?utf-8?B?MGUzUGRaMUtCbTJza00yS0VBZUR2NUNhVEZDbWxIZzdDQzJpSVRnVVpFNTNF?=
 =?utf-8?B?T2VJKzMzZEx4NHhxRlpoN0pwYkk5azZuTWxiK0JCVk9VNytJN25ERWZiNkF6?=
 =?utf-8?B?LzBnVURNY0dmZFZNdVVzcS9xT09CelVZY09SSytMdEdTcW9kQUFxd3d2VWpX?=
 =?utf-8?B?MWtYajFONkg3R1NOSDZndzZmY2J4Mzk1SVF4MGtOUCszVkVGNUxmc2N1enYr?=
 =?utf-8?B?N3k1WFdFVE9nL2NCK2J1Nm9aaUlvdmEwUUk2d1h6VzFnQmRGY3ErNUlWZlMx?=
 =?utf-8?B?U1Rwby9TVW4wS2NGdklTWi91ZlFIMFRNK1VZWDdTQlZSYnl0TFQ0dy9WamFC?=
 =?utf-8?B?czJUSGQ0TEYwZVR5Q1IzeGZUY3dTNWVTQmtERFBkeDc3dndZbWNaRW5VSjFG?=
 =?utf-8?B?UkdmU21ETXBKellpNkV6NEowcnkzSnQ1UE1qS2pkc2l1OEF4VHBMd0JjRGRq?=
 =?utf-8?B?RXRYUHc2UzFVVmFDbzYvRG9GWTdGUk5VWGhiYjNWelhpR2tUUzVVVVRCMnRT?=
 =?utf-8?B?c2J4bXVCUWJKVXUzM1UydFowc2tLbHdrQXRxUENZS1lXWVFNSTRySzdTYjZ1?=
 =?utf-8?B?cUdpVld2V01xSy8reHJPd0M5am9pdzVIbmlabXl0RjBhaWFIRk5VMjYrS2Vy?=
 =?utf-8?B?aHo5ekZEdE5mQ1JMVVJySFJSSW9KZFpXei8yeEowSTNSUXRlMDNMNUlxcWEv?=
 =?utf-8?B?Q25NYmZTb0lBcUd2Zzlnd2U2QmNvT2g0VzRWdTArNGg4ajQreXlrRVB1KzhE?=
 =?utf-8?B?MXRyUmZyb0oyM0ExUkNTM3hXNzVRV2hKN2tzVmtEVExzSGsvZENtTjBhOGYx?=
 =?utf-8?B?WXpJVVpZZDZDY2U2TzZNS3VkMFBJNk9FdXI3bU5GZVVwekZkWHorRzFZUjJ2?=
 =?utf-8?B?ekJMczQzcDkxUC95Rkg0eC9mOUxqWlNiaUpWL1A0OTRGU0hsaW5IQmRtRjIw?=
 =?utf-8?B?MDE3WkxLUWRtbTc5WWpRM3JsZVg5R0hsTFpiNnJlekxQSjdrL3dMR203bGc0?=
 =?utf-8?B?UHhkZG5BaDQydERKRzVjUDBCUkNhdVhNcnFYSDV1T0dlRWVVWStFSk9VTnRy?=
 =?utf-8?B?SEovVVduUjJDSzFRbXllbGlIWVNUZGJ4SnVhV2RxSEFVL3ZRbjVuY2hibkYw?=
 =?utf-8?B?dzg4UzNCdUsvY1ZESHV3eG5vQVZjTGxBb2c4WkR1TERqVWhNaHpOcm0xSzM5?=
 =?utf-8?B?MGY2TFdlZVh5bHBnb0l6TU40ZVlIUEJOV2Z4VWhQQnN4d2NyYWtLMy92bGRX?=
 =?utf-8?B?cmc0UklDMzVwSENmNitYVnRxTnBuUGkzaDVCc0c1SkdFQWM0SVRNTlRiVk1Y?=
 =?utf-8?B?SXp3UnhhMXk4U2QyYUtXNW1Vbm12amdsY1hINlRSb2h6SjYxN25iYXkvZ0dR?=
 =?utf-8?B?Q0ZWaFExT2szN2wybFFUbWtFZ3ZoOUwrYXRXUXgyZkFVeG94cTRKeW9ETlY4?=
 =?utf-8?B?MjdTR1ZXV3lzYlYwejVyeVp1U1YrSDFTU3Zla0ZIT1RtYk9tWXo1Zm1ySzg1?=
 =?utf-8?B?c3lod0R2V2pmbmM3Q0duQ3JtTWF0SUhzRVV2QlZ1TzZReWRndHJEbFlZRFpk?=
 =?utf-8?B?V1R5MG11MndzKzE2eHhGQXh6aGRMcDl2SU9WTFVqbDdsY0RHcHVyNjZwWWQv?=
 =?utf-8?B?ODI2cWQwUDFndW8zUnF3VVdwUDZIMjdTazFLVi90WGlUU2xKUldrQVc1U05E?=
 =?utf-8?B?cC81WHh2VW45WGRVQzVucTg3czdLVjQvNmo2ajV2U2NMV1BrZUxSQlpOU3NI?=
 =?utf-8?B?eVdWVmtEVWhwK0dMcVk2UzlSY0Yvd1NrTDBXSG93WlVOUkhibWZvYnBrdGdJ?=
 =?utf-8?B?R2xOUWlyNTFVNkpqeTZjSWI2emFvQjV1NldwL0ZvTmtMOXNuS0kwN1pmbFN5?=
 =?utf-8?B?Wm1ZSGFxZkp0ZkpQTlphT3dvY0VHTVpCdTRIUFZOMHdUd3dnaitkQVY3Yk1F?=
 =?utf-8?B?R1pDKys1aGN1ZS9wL3dxaGU3NUQ4L2dKaCtBNGZQS21KKzJKKzJ6dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ff2337-9b17-45b1-8efb-08de4c2e0d57
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 07:43:00.9119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yEIiqflc7cSMZ34kPNgGXwQ6OtNlRnkySGUp6MHHPUXAT8+6/puixG1+SFG3wyDgMq31fWEic/nrZiUpTW0JimwgwhXx4K5GslE9+/j/rA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7137
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

PiBTdWJqZWN0OiBbUEFUQ0ggMTEvMTldIGh3L2kzYy9kdy1pM2M6IEFkZCBJUlEgTU1JTyBiZWhh
dmlvcg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9lIEtvbWxvZGkgPGtvbWxvZGlAZ29vZ2xlLmNv
bT4NCj4gDQo+IFJldmlld2VkLWJ5OiBQYXRyaWNrIFZlbnR1cmUgPHZlbnR1cmVAZ29vZ2xlLmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IEhhbyBXdSA8d3VoYW90c2hAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+
ICBody9pM2MvZHctaTNjLmMgfCA1Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2h3L2kzYy9kdy1pM2MuYyBiL2h3L2kzYy9kdy1pM2MuYyBpbmRl
eCBlY2Q3OWFiYThjLi5jNThlMTI5NjRjDQo+IDEwMDY0NA0KPiAtLS0gYS9ody9pM2MvZHctaTNj
LmMNCj4gKysrIGIvaHcvaTNjL2R3LWkzYy5jDQo+IEBAIC0xNyw2ICsxNyw3IEBADQo+ICAjaW5j
bHVkZSAicWFwaS9lcnJvci5oIg0KPiAgI2luY2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgiDQo+
ICAjaW5jbHVkZSAidHJhY2UuaCINCj4gKyNpbmNsdWRlICJody9pcnEuaCINCj4gDQo+ICBSRUcz
MihERVZJQ0VfQ1RSTCwgICAgICAgICAgICAgICAgICAweDAwKQ0KPiAgICAgIEZJRUxEKERFVklD
RV9DVFJMLCBJM0NfQlJPQURDQVNUX0FERFJfSU5DLCAgICAwLCAxKQ0KPiBAQCAtMzUyLDYgKzM1
Myw0NiBAQCBzdGF0aWMgY29uc3QgdWludDMyX3QgZHdfaTNjX3JvW0RXX0kzQ19OUl9SRUdTXSA9
DQo+IHsNCj4gICAgICBbUl9TTEFWRV9DT05GSUddICAgICAgICAgICAgICAgID0gMHhmZmZmZmZm
ZiwNCj4gIH07DQo+IA0KPiArc3RhdGljIHZvaWQgZHdfaTNjX3VwZGF0ZV9pcnEoRFdJM0MgKnMp
IHsNCj4gKyAgICBib29sIGxldmVsID0gISEocy0+cmVnc1tSX0lOVFJfU0lHTkFMX0VOXSAmIHMt
PnJlZ3NbUl9JTlRSX1NUQVRVU10pOw0KPiArICAgIHFlbXVfc2V0X2lycShzLT5pcnEsIGxldmVs
KTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHVpbnQzMl90IGR3X2kzY19pbnRyX3N0YXR1c19yKERX
STNDICpzKSB7DQo+ICsgICAgLyogT25seSByZXR1cm4gdGhlIHN0YXR1cyB3aG9zZSBjb3JyZXNw
b25kaW5nIEVOIGJpdHMgYXJlIHNldC4gKi8NCj4gKyAgICByZXR1cm4gcy0+cmVnc1tSX0lOVFJf
U1RBVFVTXSAmIHMtPnJlZ3NbUl9JTlRSX1NUQVRVU19FTl07IH0NCj4gKw0KPiArc3RhdGljIHZv
aWQgZHdfaTNjX2ludHJfc3RhdHVzX3coRFdJM0MgKnMsIHVpbnQzMl90IHZhbCkgew0KPiArICAg
IC8qIElOVFJfU1RBVFVTWzEzOjVdIGlzIHcxYywgb3RoZXIgYml0cyBhcmUgUk8uICovDQo+ICsg
ICAgdmFsICY9IDB4M2ZlMDsNCj4gKyAgICBzLT5yZWdzW1JfSU5UUl9TVEFUVVNdICY9IH52YWw7
DQo+ICsNCj4gKyAgICBkd19pM2NfdXBkYXRlX2lycShzKTsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IHZvaWQgZHdfaTNjX2ludHJfc3RhdHVzX2VuX3coRFdJM0MgKnMsIHVpbnQzMl90IHZhbCkgew0K
PiArICAgIHMtPnJlZ3NbUl9JTlRSX1NUQVRVU19FTl0gPSB2YWw7DQo+ICsgICAgZHdfaTNjX3Vw
ZGF0ZV9pcnEocyk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGR3X2kzY19pbnRyX3NpZ25h
bF9lbl93KERXSTNDICpzLCB1aW50MzJfdCB2YWwpIHsNCj4gKyAgICBzLT5yZWdzW1JfSU5UUl9T
SUdOQUxfRU5dID0gdmFsOw0KPiArICAgIGR3X2kzY191cGRhdGVfaXJxKHMpOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgdm9pZCBkd19pM2NfaW50cl9mb3JjZV93KERXSTNDICpzLCB1aW50MzJfdCB2
YWwpIHsNCj4gKyAgICAvKiBJTlRSX0ZPUkNFIGlzIFdPLCBqdXN0IHNldCB0aGUgY29ycmVzcG9u
ZGluZyBJTlRSX1NUQVRVUyBiaXRzLiAqLw0KPiArICAgIHMtPnJlZ3NbUl9JTlRSX1NUQVRVU10g
PSB2YWw7DQo+ICsgICAgZHdfaTNjX3VwZGF0ZV9pcnEocyk7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyB1aW50NjRfdCBkd19pM2NfcmVhZCh2b2lkICpvcGFxdWUsIGh3YWRkciBvZmZzZXQsIHVuc2ln
bmVkIHNpemUpICB7DQo+ICAgICAgRFdJM0MgKnMgPSBEV19JM0Mob3BhcXVlKTsNCj4gQEAgLTM2
NSw2ICs0MDYsOSBAQCBzdGF0aWMgdWludDY0X3QgZHdfaTNjX3JlYWQodm9pZCAqb3BhcXVlLCBo
d2FkZHINCj4gb2Zmc2V0LCB1bnNpZ25lZCBzaXplKQ0KPiAgICAgIGNhc2UgUl9JTlRSX0ZPUkNF
Og0KPiAgICAgICAgICB2YWx1ZSA9IDA7DQo+ICAgICAgICAgIGJyZWFrOw0KPiArICAgIGNhc2Ug
Ul9JTlRSX1NUQVRVUzoNCj4gKyAgICAgICAgdmFsdWUgPSBkd19pM2NfaW50cl9zdGF0dXNfcihz
KTsNCj4gKyAgICAgICAgYnJlYWs7DQo+ICAgICAgZGVmYXVsdDoNCj4gICAgICAgICAgdmFsdWUg
PSBzLT5yZWdzW2FkZHJdOw0KPiAgICAgICAgICBicmVhazsNCj4gQEAgLTQwOSw2ICs0NTMsMTgg
QEAgc3RhdGljIHZvaWQgZHdfaTNjX3dyaXRlKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwN
Cj4gdWludDY0X3QgdmFsdWUsDQo+ICAgICAgICAgIGJyZWFrOw0KPiAgICAgIGNhc2UgUl9SRVNF
VF9DVFJMOg0KPiAgICAgICAgICBicmVhazsNCj4gKyAgICBjYXNlIFJfSU5UUl9TVEFUVVM6DQo+
ICsgICAgICAgIGR3X2kzY19pbnRyX3N0YXR1c193KHMsIHZhbDMyKTsNCj4gKyAgICAgICAgYnJl
YWs7DQo+ICsgICAgY2FzZSBSX0lOVFJfU1RBVFVTX0VOOg0KPiArICAgICAgICBkd19pM2NfaW50
cl9zdGF0dXNfZW5fdyhzLCB2YWwzMik7DQo+ICsgICAgICAgIGJyZWFrOw0KPiArICAgIGNhc2Ug
Ul9JTlRSX1NJR05BTF9FTjoNCj4gKyAgICAgICAgZHdfaTNjX2ludHJfc2lnbmFsX2VuX3cocywg
dmFsMzIpOw0KPiArICAgICAgICBicmVhazsNCj4gKyAgICBjYXNlIFJfSU5UUl9GT1JDRToNCj4g
KyAgICAgICAgZHdfaTNjX2ludHJfZm9yY2VfdyhzLCB2YWwzMik7DQo+ICsgICAgICAgIGJyZWFr
Ow0KPiAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgIHMtPnJlZ3NbYWRkcl0gPSB2YWwzMjsNCj4g
ICAgICAgICAgYnJlYWs7DQo+IC0tDQo+IDIuNTAuMC5yYzEuNTkxLmc5Yzk1ZjE3ZjY0LWdvb2cN
Cg0KUmV2aWV3ZWQtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KDQpU
aGFua3MsDQpKYW1pbg0KDQo=


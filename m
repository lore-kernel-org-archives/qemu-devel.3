Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A8BC02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 08:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tesEx-0000Yn-CL; Mon, 03 Feb 2025 03:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tesEl-0000WS-N8; Mon, 03 Feb 2025 03:55:24 -0500
Received: from mail-psaapc01on20710.outbound.protection.outlook.com
 ([2a01:111:f403:200e::710]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tesEj-00041N-3m; Mon, 03 Feb 2025 03:55:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfrDbvmCmTlv65OubuIy43Rbiew4nAB39eoc1D04c9k8GLoSxkk/b6+bg/QCewpNP3SWiQPNCpPd2KE9OfkzXcul2+NbF5yINMxfWzHgnDWS8nI2zlChpKDfnAmd2B43g26br7mIIFDDMRdYH0OVNf+e6Q+rxJVGto8jhcshjly90miuTfQIZdCKUdZrtbnZGlWkIAsQaSebwB+sFcwxvM7S4g3/wEojC5u6RUkA+yRHPIbZbII6r0QC0kPaKdLfB6IXzQ9qAvVQ+2VC6ZtmJlGRScoXTrK/G+nWEUU2eH3oa467IaAnkm3x2EWufYWBmO9jMhEy6BqQ/kqQ1cAFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfTm8pYhnGAO1zYbzaCF8jWC5VhkHXVUbA4Zl6pJxWQ=;
 b=f9LM38n7lAm48VMNs0BzAuXCM8ce8BwIYCafYrHkA96lMWfYPu/XPEfAJpjXS7zYASBx0UMaXOdbYJAGEA9pnr9biiQWKt+WnDzSmmE6u7h0EkrIm1v7b3GMT/dcO/AzwMc8BMW2FjGB5oK8bzOio0I4i+grip5QRHqkOkvdjqMrGyt79RqFFHbf8j2LtpBgQexKuIz4ZiuhVGVWItT2sKUGOFn8FXxv3IWLZ9IcEo9jv0MiJfJL0Phg52PUipgrU9ld8RS2MdqU0qqokER2iQhTMU2hSokXVDZSmmKMFe9cc7HkNpUuUawECGUSnqL4YpBj5dWX+Fm47KKRfcdEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfTm8pYhnGAO1zYbzaCF8jWC5VhkHXVUbA4Zl6pJxWQ=;
 b=RtMlT0BdcG4AiTf16i3xKYzXfrKHCegwuePx+hIJqsdmxmHetLWEes4UptQi9F5FXDc09Tpu2fYhyBAeKV4j5yiqd62FT85HcjFM42EeZUltDs3jh6n9PmD9IqvHm0vkInBYCAB8mT5VnO3YhALPiwqOD5cZWKZHS9t9eE7HegdEiii5U+jrPSAF6Bg1RwQi1zx4P2MLQGLKGYW6qmqCIbPB7Uu4gdJ7wuu8B5+02f+lzLDYfEC0u+bgS+dRbz0+jSlBOwpeHcmZVl4HvqUa0c3wMceIDinu3L1iYK3b4Wi6+8Sowg4HMfGrFiJK8r2nvfEaIRShBpTaC4iBktNt0Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB7134.apcprd06.prod.outlook.com (2603:1096:405:8b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.8; Mon, 3 Feb 2025 08:55:11 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 08:55:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 14/18] hw/arm/aspeed: Add SoC and Machine Support for
 AST2700 A1
Thread-Topic: [PATCH v1 14/18] hw/arm/aspeed: Add SoC and Machine Support for
 AST2700 A1
Thread-Index: AQHba9LA5igUOGI2wE6hyKlUgvLEmbMuxXoAgAaVNfA=
Date: Mon, 3 Feb 2025 08:55:10 +0000
Message-ID: <SI2PR06MB50416A4917944D0A0E49EB97FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
 <20250121070424.2465942-15-jamin_lin@aspeedtech.com>
 <ac91ace7ce8ef2e77cccb9b0f25c6a99969b6ebb.camel@codeconstruct.com.au>
In-Reply-To: <ac91ace7ce8ef2e77cccb9b0f25c6a99969b6ebb.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB7134:EE_
x-ms-office365-filtering-correlation-id: 47c90ac5-dd6c-457b-0883-08dd4430776f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RVlMNDFFQ1JicDlYTW02a1ZFSC8zcmRRN2EwaDRRZGRmbU1zMWMxdXdNRkdJ?=
 =?utf-8?B?ZVV4cXBsNmMyaXUwQjFNQVpYMUpPQWVQNEhxSnFZUW9HbkYrWXRBUW85Y2o3?=
 =?utf-8?B?Q3dyeVJmUHdnWlJkVTA0L1IvaU1JalZLN3RuRGNJL3NSZ3dSL3lQOFkyWGs5?=
 =?utf-8?B?eG9ob3NpM2xnWTBQZEtCQXBvVkdIc2c1Q21yQ214WkJ1OHd2OGVVNktyeis4?=
 =?utf-8?B?NnM0bTZsMWN0dXc4citsOXR5ODhISEYzWjJXN3ZGUGlIV0UwV0VtS3ZkNTFa?=
 =?utf-8?B?TlJBZlVrckVpUGZ2ZkxIWldCaVJjeDUxcVNmc2RVRlAwMEdveUlSLzJ5UEIx?=
 =?utf-8?B?aVQrZFdCK20weDRmRHdhVXBQbENMc2MyOCsvNkZ4SllGdlZTSCtNOTkzaGF1?=
 =?utf-8?B?bk0ybkIvMVRDbzBOZ01qaStFdG5aK1VNSm1sYTJic0wrRUtlREdONWhKVUtz?=
 =?utf-8?B?NTdrWXlOZklSbklQbXdEL2p1aGFuUXhES2VGU09vYlVvcW90ZUt5NkZyZkpV?=
 =?utf-8?B?SGllZDk2bXZiSzlwNWJZZWtOYmJyRGttNjlsL0FJN0pocDFqSVJoRk82QkZx?=
 =?utf-8?B?bmRFcHlmMS9QNDJqN29JVGo1VnFoc2RrK1dqVFAwYzVmblVvM29pTkdrK1Iv?=
 =?utf-8?B?a1R4MlBKeDFncm5GaTNYNk1RaytPenBjcGVXV0pmajdObG5RazRubVFlN1Jx?=
 =?utf-8?B?dGhTZkZUVEVNYWFYY2Q0YXRUL2RVbXVwWG5wMmVPck54K1lpblhRODEzcHJP?=
 =?utf-8?B?cWJBMmE0N0JMeUxxdDhYWGlGN0JUek40STdmN1dhN1gwT2t6S25ZTGtwUm0z?=
 =?utf-8?B?aTc4NW1yK09kVUdrVXJIdlhDdTVPdmhxZXdPTXNVYXlDVTQ1ejNhQysvU1FS?=
 =?utf-8?B?TkZxZEU4TE9Yc2s3bnhsSmRFaFc3VzBKamVsZWtjNFk2SWpCV0lUZnBPdk9I?=
 =?utf-8?B?VXhITW12T241Q1cwN3ljNy9WWVh3bVRBQkJyZmd0L0MvcWdEd0NIM0E1VERu?=
 =?utf-8?B?UktyVzFZMU9DcEZiSlh4eXdWVmVTM2VldGcxdTlhVjF5R1l3WS9HSUtOdXJk?=
 =?utf-8?B?RS8rQ2FYVEU4VWJscG5PcFFFbXhMd3VlYkJzLzc1cndCSFM4WE9TVTRYNHht?=
 =?utf-8?B?ZmhhQ2YwOGFUSHc0Q20xeUNteFduVDNtM1c1S1I1SGVHRkdSMURBdzFVenNM?=
 =?utf-8?B?OVVHckxLNjhnZkNNZ2libHhKNUxLMW8yRUF5YzVWSjhaazlwUWZKUVFlOEU4?=
 =?utf-8?B?K0tPc0hyNDJ0SWw5QTVaK09LcHFhMGhtbHZXMU1uZG1GZStIUk11MUJZTlJL?=
 =?utf-8?B?Zk96eDB5azZscENncnF2dWtHRlZNNEE4U3VCRzVKdTd6UkFsaHM4OGxsMkRH?=
 =?utf-8?B?ZnJsM3V4cTNFeVFubXJhQ0hsbUVsbWp4bGcrMFZESWYzYm9HLzRIVndhZG9L?=
 =?utf-8?B?c1Q2SWYvVjZXZGxiUHAyZlFXTktQTE9Fa3NvZlhVRW5pbmFMMmpId2dpY0o0?=
 =?utf-8?B?djd2Z3B2YVZnbmhJWjdKS2VNWVg0SXp1OE1aRE1XVGZTSDVTTzR4Zk92cHE3?=
 =?utf-8?B?ZE9WWjFPSGRuWG0rKytQS3N0Rnkya2ZNQ3ZBOE5odGJEelhKclRUWlNKa0VL?=
 =?utf-8?B?T0R3M0d4d0IyMTFRTDM2amgwNzhPcTNCZmFZOHFhWlVsdEIrTFFRYUs4Mldo?=
 =?utf-8?B?S2dRM0xJeXVTaXpaeHRtWDIveFMxV1B4RWU2Ym4wN0lKSkZVaEpnYzJkVndL?=
 =?utf-8?B?ckpsb1dyTytuZjYvcWgweXJJTWUvZlBtYnFoRS9lUStOY2xoRWRFQ2Q3aEZO?=
 =?utf-8?B?aVczVjdaaGthSUtvNjYxdUQyaUgwT2k2c29RdU16eEwvMTlUMXJGSDVkQ3NC?=
 =?utf-8?B?VHRrcU1vdDFOL0FQZE16dXg0OEpoR3k3RXcrdFFWZTRXRmJUK1RqNjdyMVhF?=
 =?utf-8?Q?mQfhVIqHBrCKRVAtvhZcw3+A6Pvlpzkd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjBDWFNhMXJLM1Mzbk5EUExQZ1l5UTBTc08xS3dYQ21oYWFPMTVaTXNQdU5F?=
 =?utf-8?B?THl0bWxjRXNtckFaMUc4TElHcDRtQkpyYnJCV0xKYlh0ZTNPbnp6QmxpV2lE?=
 =?utf-8?B?cTJzd3FkbU1lR09XOEcweEVEVUlCdVorQzVhdW9mL1l6b3ZXbmMwZExBUjVS?=
 =?utf-8?B?NWt0ZjR6b1FYTlJOQVdkWEdFNGxKdkZQbjR2Tm5EMmQ5L1FBTzFsSk91L2J5?=
 =?utf-8?B?NEJWb04zNjdURm5TS0tlQlFNSHFVQXhSaWkrWklQaTVSbjI3ZE9BL0dXS2lp?=
 =?utf-8?B?U0c4bUZFbU1wVGxKUWxjVEwrSjZpK2R3RWRPdG1kNXBSdmhYVXpKWHJVYXo2?=
 =?utf-8?B?NkFVL1I3QzNYL1BRQ0J6R1FJQ281Q1c0OThwSEprVWdwRGdSeDFPeHgzN0g4?=
 =?utf-8?B?cjNudWlKbjE0VndIbEhieVJiRGUyV2tQYmM4LzN0bGppc2JIMElDazd2bHlI?=
 =?utf-8?B?Y2xsdHBMVFkyaERZS2lGRW9yL0R2NzNuc0FjY2F0ZHNpZTdYajFJa2N0WXEr?=
 =?utf-8?B?K0UzcDVvdGhDY2RFT2JvV1VDVVV2TjZ3Y01KaktWM1AxMVlXZE55Qzdlbmhi?=
 =?utf-8?B?ODlSUENuMnRQSlQwODY3cFFsL05GOGRiOFVNR0FIOVlsWmxsMzkxb0pQcENL?=
 =?utf-8?B?T0lvVDN5Y01SZW0rcGswUnFzd0tHelZjR0poenM3aFNJNStVU0FoWlVQbkIr?=
 =?utf-8?B?UWFxcE5NdzExays0Y3Q1OURQQkpPRGdqdDhCaTErcUNENzQzWkxXS0paRVdm?=
 =?utf-8?B?QkZ0aFg2NE1SckhxYUVzU2RqQ21sTVBtVVYxN0xGNWhKYlh0WFpJMXQ3V0tB?=
 =?utf-8?B?OEhNSkZEMzkvVFI5NlgvWThVZnZzbGozdlp0ZWJOMHMxYlRwRjBqQXhVUENa?=
 =?utf-8?B?TGZXME1hbFpSRkRRMDIvWE9XcGVwQ2xOR0pxeXNiZXBpZGVIYVBzZ0J1bmV5?=
 =?utf-8?B?dzkzdThscmRQTmhNd1JLRXhkYlRQTHNCS21OVnJSd3c2VzZJL01lMldJNk12?=
 =?utf-8?B?cVBSbWtBOE5pSXpFTGFyYUpEMFRvUDZPQ2pWbXNLR2lDNFZYRjd3b3FmbnBE?=
 =?utf-8?B?L0o1Z1J4eDQ2bDc2M25rMzJ0bmtXZmJTNHoxOU9HM1BwRkxlMkpwWmdvVnA0?=
 =?utf-8?B?eFVUbXpyNkw5cCtHTkFsR05NaC9MQ3BDQnhDSWdUY011Z2dDTkpiclB1TW1N?=
 =?utf-8?B?ZDFnNjF3aEgvOWxFZmZFMEMrcnVzUldwejdBSmwxRlV0MVRnWHVOekpCaHI3?=
 =?utf-8?B?MHlpTzRUK0phbUZIaXY1cll4TEtFaWk1dzk5UUVHbC9yOXZMUmU3cVYwUW51?=
 =?utf-8?B?OGczemtGcFJWZjhBaHFJU1p6RDhseHZEc2tpWSs4SUFTRThSdENhRFN5UlJ3?=
 =?utf-8?B?TXNQREFrdUpQbTlkemc1VjhuQTN2bUZGcjFndnEyV3ZsOGtKd1J6Ti9WcWp3?=
 =?utf-8?B?blhEaGRsZjFLUVZ0Uk1wUnNtYmpmVEpoa0J3cXgrNjd6UmR6YUNQQUFoYVRT?=
 =?utf-8?B?UnM4NURjSFlud0t5cW52MHlLUHZTVGFLQWxnZ0RBWFRxOUFGWFdsdE95UitB?=
 =?utf-8?B?M0hQazVDMXpEM2hhNzAwVE1CeVZaMEZjWFF3TnZLYzdrdWNTbmhHeEtNbk5D?=
 =?utf-8?B?VDZ4aThwMWNDVlNXZWNDTDFLMnlTU09NT25ZNkFrYTJmWGNxenphaytiQ2dn?=
 =?utf-8?B?amw5UkJLd2dGUHNOVW81WWpwNVlsdWVFRThJRHVhWE1oUFZxSDhPRnVmVlZ6?=
 =?utf-8?B?SjJYbFlBZno5ZWZmMklvV21iVUNyYmxFemh2S0FkeTJSTC93Z21LbWJZM0g1?=
 =?utf-8?B?SncwUWFsVjNKenk2VVZDV2FiWDV6QzZOV0p5c29NdS9DWkVyb3FnK3pzS2pB?=
 =?utf-8?B?c0ZRK1RxUTNsR0JDeWhoSyswUGlMcUs0NElydXVXbnRBZFVSNzVuVHdTWEVX?=
 =?utf-8?B?VVd3THQwdUFMbXhTbXBCd0FvTVZMNENpdlJBWVB6VmNFOHdldWxsZG5tY0tp?=
 =?utf-8?B?TkZpVUV3bUQrU2pnUlRMQ2x1cVBMUytMK2N1VkorZ3JpVlFudS9oSkZmelZQ?=
 =?utf-8?B?V2Q1S3JIQmNZbmFLL2l3bEpnaWExYmRPWWd6d1kzNnJXMlpzV2NUcEtoSjE4?=
 =?utf-8?Q?7ZFntVV5Mm6v0ZigJbzjMbvua?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c90ac5-dd6c-457b-0883-08dd4430776f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 08:55:10.8960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bf7KyUjtuz37wXBzpkrTnKUmquhopNrdiygzCDM6eyr4EpUvno87TZeTtGODuYq0P4BO/xSOzicFnk4DIikQ6JGxWK4gGhZPGd3UHJBX+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7134
Received-SPF: pass client-ip=2a01:111:f403:200e::710;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgQW5kcmV3LA0KDQo+IEZyb206IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVj
dC5jb20uYXU+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDMwLCAyMDI1IDEyOjIyIFBNDQo+
IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEPDqWRyaWMgTGUgR29h
dGVyIDxjbGdAa2FvZC5vcmc+Ow0KPiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFy
by5vcmc+OyBTdGV2ZW4gTGVlDQo+IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveSBM
ZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSm9lbCBTdGFubGV5DQo+IDxqb2VsQGptcy5pZC5hdT47
IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4NCj4gbGlz
dDpBbGwgcGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95
IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBZdW5saW4gVGFuZw0KPiA8eXVubGluLnRh
bmdAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTQvMThdIGh3L2Fy
bS9hc3BlZWQ6IEFkZCBTb0MgYW5kIE1hY2hpbmUgU3VwcG9ydA0KPiBmb3IgQVNUMjcwMCBBMQ0K
PiANCj4gT24gVHVlLCAyMDI1LTAxLTIxIGF0IDE1OjA0ICswODAwLCBKYW1pbiBMaW4gd3JvdGU6
DQo+ID4gVGhlIG1lbW9yeSBtYXAgZm9yIEFTVDI3MDAgQTEgcmVtYWlucyBjb21wYXRpYmxlIHdp
dGggQVNUMjcwMCBBMC4NCj4gPiBIb3dldmVyLCB0aGUgSVJRIG1hcHBpbmcgaGFzIGJlZW4gdXBk
YXRlZCBmb3IgQVNUMjcwMCBBMSwgd2l0aCBHSUMNCj4gPiBpbnRlcnJ1cHRzIG5vdyByYW5naW5n
IGZyb20gMTkyIHRvIDIwMS4gQWRkIGEgbmV3IElSUSBtYXAgdGFibGUgZm9yDQo+ID4gQVNUMjcw
MCBBMS4NCj4gPg0KPiA+IEludHJvZHVjZSAiYXNwZWVkX21hY2hpbmVfYXN0MjcwMF9ldmJfY2xh
c3NfaW5pdCIgdG8gaW5pdGlhbGl6ZSB0aGUNCj4gPiBBU1QyNzAwIEVWQg0KPiA+IG1hY2hpbmUu
IEFkZCAiYXNwZWVkX3NvY19hc3QyNzAwX2NsYXNzX2luaXQiIHRvIGluaXRpYWxpemUgdGhlDQo+
ID4gQVNUMjcwMCBBMSBTb0MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGph
bWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGh3L2FybS9hc3BlZWQuY8Kg
wqDCoMKgwqDCoMKgwqAgfCAyNCArKysrKysrKysrKysrDQo+ID4gwqBody9hcm0vYXNwZWVkX2Fz
dDI3eDAuYyB8IDgwDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgMTA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9hcm0vYXNwZWVkLmMgaW5kZXgNCj4gPiA0
MDJkNTVjNTU2Li4yNTRmYTUzMTZkIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWQuYw0K
PiA+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiA+IEBAIC0xNjcyLDYgKzE2NzIsMjYgQEAgc3Rh
dGljIHZvaWQNCj4gPiBhc3BlZWRfbWFjaGluZV9hc3QyNzAwYTBfZXZiX2NsYXNzX2luaXQoT2Jq
ZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0KPiA+IMKgwqDCoMKgIG1jLT5kZWZhdWx0X3JhbV9z
aXplID0gMSAqIEdpQjsNCj4gPiDCoMKgwqDCoCBhc3BlZWRfbWFjaGluZV9jbGFzc19pbml0X2Nw
dXNfZGVmYXVsdHMobWMpOw0KPiA+IMKgfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVk
X21hY2hpbmVfYXN0MjcwMF9ldmJfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsDQo+ID4gdm9p
ZCAqZGF0YSkNCj4gPiArew0KPiA+ICvCoMKgwqAgTWFjaGluZUNsYXNzICptYyA9IE1BQ0hJTkVf
Q0xBU1Mob2MpOw0KPiA+ICvCoMKgwqAgQXNwZWVkTWFjaGluZUNsYXNzICphbWMgPSBBU1BFRURf
TUFDSElORV9DTEFTUyhvYyk7DQo+ID4gKw0KPiA+ICvCoMKgwqAgbWMtPmRlc2MgPSAiQXNwZWVk
IEFTVDI3MDAgRVZCIChDb3J0ZXgtQTM1KSI7DQo+ID4gK8KgwqDCoCBhbWMtPnNvY19uYW1lwqAg
PSAiYXN0MjcwMC1hMSI7DQo+ID4gK8KgwqDCoCBhbWMtPmh3X3N0cmFwMSA9IEFTVDI3MDBfRVZC
X0hXX1NUUkFQMTsNCj4gPiArwqDCoMKgIGFtYy0+aHdfc3RyYXAyID0gQVNUMjcwMF9FVkJfSFdf
U1RSQVAyOw0KPiA+ICvCoMKgwqAgYW1jLT5mbWNfbW9kZWwgPSAidzI1cTAxanZxIjsNCj4gPiAr
wqDCoMKgIGFtYy0+c3BpX21vZGVsID0gIncyNXE1MTJqdiI7DQo+ID4gK8KgwqDCoCBhbWMtPm51
bV9jc8KgwqDCoCA9IDI7DQo+ID4gK8KgwqDCoCBhbWMtPm1hY3NfbWFzayA9IEFTUEVFRF9NQUMw
X09OIHwgQVNQRUVEX01BQzFfT04gfA0KPiA+IEFTUEVFRF9NQUMyX09OOw0KPiA+ICvCoMKgwqAg
YW1jLT51YXJ0X2RlZmF1bHQgPSBBU1BFRURfREVWX1VBUlQxMjsNCj4gPiArwqDCoMKgIGFtYy0+
aTJjX2luaXTCoCA9IGFzdDI3MDBfZXZiX2kyY19pbml0Ow0KPiA+ICvCoMKgwqAgbWMtPmRlZmF1
bHRfcmFtX3NpemUgPSAxICogR2lCOw0KPiA+ICvCoMKgwqAgYXNwZWVkX21hY2hpbmVfY2xhc3Nf
aW5pdF9jcHVzX2RlZmF1bHRzKG1jKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiDCoCNlbmRpZg0KPiA+
DQo+ID4gwqBzdGF0aWMgdm9pZCBhc3BlZWRfbWFjaGluZV9xY29tX2RjX3NjbV92MV9jbGFzc19p
bml0KE9iamVjdENsYXNzDQo+ID4gKm9jLA0KPiA+IEBAIC0xNzk4LDYgKzE4MTgsMTAgQEAgc3Rh
dGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF9tYWNoaW5lX3R5cGVzW10gPQ0KPiA+IHsNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgIC5uYW1lwqDCoMKgwqDCoMKgwqDCoMKgID0NCj4gTUFDSElORV9UWVBF
X05BTUUoImFzdDI3MDBhMC1ldmIiKSwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIC5wYXJlbnTCoMKg
wqDCoMKgwqDCoCA9IFRZUEVfQVNQRUVEX01BQ0hJTkUsDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCAu
Y2xhc3NfaW5pdMKgwqDCoCA9IGFzcGVlZF9tYWNoaW5lX2FzdDI3MDBhMF9ldmJfY2xhc3NfaW5p
dCwNCj4gPiArwqDCoMKgwqAgfSwgew0KPiA+ICvCoMKgwqDCoMKgwqDCoCAubmFtZcKgwqDCoMKg
wqDCoMKgwqDCoCA9IE1BQ0hJTkVfVFlQRV9OQU1FKCJhc3QyNzAwLWV2YiIpLA0KPiA+ICvCoMKg
wqDCoMKgwqDCoCAucGFyZW50wqDCoMKgwqDCoMKgwqAgPSBUWVBFX0FTUEVFRF9NQUNISU5FLA0K
PiA+ICvCoMKgwqDCoMKgwqDCoCAuY2xhc3NfaW5pdMKgwqDCoCA9IGFzcGVlZF9tYWNoaW5lX2Fz
dDI3MDBfZXZiX2NsYXNzX2luaXQsDQo+ID4gwqAjZW5kaWYNCj4gPiDCoMKgwqDCoCB9LCB7DQo+
ID4gwqDCoMKgwqDCoMKgwqDCoCAubmFtZcKgwqDCoMKgwqDCoMKgwqDCoCA9IFRZUEVfQVNQRUVE
X01BQ0hJTkUsIGRpZmYgLS1naXQNCj4gPiBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jIGIvaHcv
YXJtL2FzcGVlZF9hc3QyN3gwLmMgaW5kZXgNCj4gPiBiMzJjNGZjYzM1Li5lMGEyOWM5MDUzIDEw
MDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4gKysrIGIvaHcvYXJt
L2FzcGVlZF9hc3QyN3gwLmMNCj4gPiBAQCAtMTE5LDYgKzExOSw1MiBAQCBzdGF0aWMgY29uc3Qg
aW50IGFzcGVlZF9zb2NfYXN0MjcwMGEwX2lycW1hcFtdID0NCj4gPiB7DQo+ID4gwqDCoMKgwqAg
W0FTUEVFRF9ERVZfU0RIQ0ldwqDCoMKgwqAgPSAxMzMsDQo+ID4gwqB9Ow0KPiA+DQo+ID4gK3N0
YXRpYyBjb25zdCBpbnQgYXNwZWVkX3NvY19hc3QyNzAwX2lycW1hcFtdID0gew0KPiA+ICvCoMKg
wqAgW0FTUEVFRF9ERVZfVUFSVDBdwqDCoMKgwqAgPSAxOTYsDQo+ID4gK8KgwqDCoCBbQVNQRUVE
X0RFVl9VQVJUMV3CoMKgwqDCoCA9IDE5NiwNCj4gPiArwqDCoMKgIFtBU1BFRURfREVWX1VBUlQy
XcKgwqDCoMKgID0gMTk2LA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfVUFSVDNdwqDCoMKgwqAg
PSAxOTYsDQo+ID4gK8KgwqDCoCBbQVNQRUVEX0RFVl9VQVJUNF3CoMKgwqDCoCA9IDgsDQo+ID4g
K8KgwqDCoCBbQVNQRUVEX0RFVl9VQVJUNV3CoMKgwqDCoCA9IDE5NiwNCj4gPiArwqDCoMKgIFtB
U1BFRURfREVWX1VBUlQ2XcKgwqDCoMKgID0gMTk2LA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZf
VUFSVDddwqDCoMKgwqAgPSAxOTYsDQo+ID4gK8KgwqDCoCBbQVNQRUVEX0RFVl9VQVJUOF3CoMKg
wqDCoCA9IDE5NiwNCj4gPiArwqDCoMKgIFtBU1BFRURfREVWX1VBUlQ5XcKgwqDCoMKgID0gMTk2
LA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfVUFSVDEwXcKgwqDCoCA9IDE5NiwNCj4gPiArwqDC
oMKgIFtBU1BFRURfREVWX1VBUlQxMV3CoMKgwqAgPSAxOTYsDQo+ID4gK8KgwqDCoCBbQVNQRUVE
X0RFVl9VQVJUMTJdwqDCoMKgID0gMTk2LA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfRk1DXcKg
wqDCoMKgwqDCoCA9IDE5NSwNCj4gPiArwqDCoMKgIFtBU1BFRURfREVWX1NETUNdwqDCoMKgwqDC
oCA9IDAsDQo+ID4gK8KgwqDCoCBbQVNQRUVEX0RFVl9TQ1VdwqDCoMKgwqDCoMKgID0gMTIsDQo+
ID4gK8KgwqDCoCBbQVNQRUVEX0RFVl9BRENdwqDCoMKgwqDCoMKgID0gMTk0LA0KPiA+ICvCoMKg
wqAgW0FTUEVFRF9ERVZfWERNQV3CoMKgwqDCoMKgID0gNSwNCj4gPiArwqDCoMKgIFtBU1BFRURf
REVWX0VNTUNdwqDCoMKgwqDCoCA9IDE1LA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfR1BJT13C
oMKgwqDCoMKgID0gMTk0LA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfUlRDXcKgwqDCoMKgwqDC
oCA9IDEzLA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfVElNRVIxXcKgwqDCoCA9IDE2LA0KPiA+
ICvCoMKgwqAgW0FTUEVFRF9ERVZfVElNRVIyXcKgwqDCoCA9IDE3LA0KPiA+ICvCoMKgwqAgW0FT
UEVFRF9ERVZfVElNRVIzXcKgwqDCoCA9IDE4LA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfVElN
RVI0XcKgwqDCoCA9IDE5LA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfVElNRVI1XcKgwqDCoCA9
IDIwLA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfVElNRVI2XcKgwqDCoCA9IDIxLA0KPiA+ICvC
oMKgwqAgW0FTUEVFRF9ERVZfVElNRVI3XcKgwqDCoCA9IDIyLA0KPiA+ICvCoMKgwqAgW0FTUEVF
RF9ERVZfVElNRVI4XcKgwqDCoCA9IDIzLA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfV0RUXcKg
wqDCoMKgwqDCoCA9IDE5NSwNCj4gPiArwqDCoMKgIFtBU1BFRURfREVWX1BXTV3CoMKgwqDCoMKg
wqAgPSAxOTUsDQo+ID4gK8KgwqDCoCBbQVNQRUVEX0RFVl9MUENdwqDCoMKgwqDCoMKgID0gMTky
LA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfSUJUXcKgwqDCoMKgwqDCoCA9IDE5MiwNCj4gPiAr
wqDCoMKgIFtBU1BFRURfREVWX0kyQ13CoMKgwqDCoMKgwqAgPSAxOTQsDQo+ID4gK8KgwqDCoCBb
QVNQRUVEX0RFVl9QRUNJXcKgwqDCoMKgwqAgPSAxOTcsDQo+ID4gK8KgwqDCoCBbQVNQRUVEX0RF
Vl9FVEgxXcKgwqDCoMKgwqAgPSAxOTYsDQo+ID4gK8KgwqDCoCBbQVNQRUVEX0RFVl9FVEgyXcKg
wqDCoMKgwqAgPSAxOTYsDQo+ID4gK8KgwqDCoCBbQVNQRUVEX0RFVl9FVEgzXcKgwqDCoMKgwqAg
PSAxOTYsDQo+ID4gK8KgwqDCoCBbQVNQRUVEX0RFVl9IQUNFXcKgwqDCoMKgwqAgPSA0LA0KPiA+
ICvCoMKgwqAgW0FTUEVFRF9ERVZfS0NTXcKgwqDCoMKgwqDCoCA9IDE5MiwNCj4gPiArwqDCoMKg
IFtBU1BFRURfREVWX0RQXcKgwqDCoMKgwqDCoMKgID0gMjgsDQo+ID4gK8KgwqDCoCBbQVNQRUVE
X0RFVl9JM0NdwqDCoMKgwqDCoMKgID0gMTk1LA0KPiA+ICvCoMKgwqAgW0FTUEVFRF9ERVZfU0RI
Q0ldwqDCoMKgwqAgPSAxOTcsDQo+ID4gK307DQo+IA0KPiBCaXQgb2YgYSBuaXQsIGJ1dCBjYW4g
d2Ugc29ydCB0aGlzIHRhYmxlPyBQZXJoYXBzIGJ5IGludGVycnVwdCB2YWx1ZT8NCg0KVGhhbmtz
IGZvciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpXaWxsIHVwZGF0ZSB0aGlzIHRhYmxlDQoNCkph
bWluDQoNCj4gDQo+IEFuZHJldw0K


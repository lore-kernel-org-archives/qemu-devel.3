Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44D8C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eBr-0007nZ-43; Tue, 29 Apr 2025 02:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u9eBZ-0007dE-G9
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:11:17 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u9eBV-0005Jx-7P
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:11:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4U4EnjEZo2MlgMtjM/wP5yw3MIiPO3FqxfXB1WioKccYGh9exBaYm7pcPWqM2X2ls9DugdaPG9BnY9O8DjVwmOBdO/jJuCphAqRGJZfv1RJDJx3tEpfqZ1ThrOW2aWYUG3FOHAXZ+TgjlBchB+y5I4KABJ0BEWTx7SC1CwTa9zh5VHounJaDuhkj+Apeb+nO8boHjDyS1ZnbxUH0xflQ5dgwQj5J4VGnbkGrH/JY/EbeEoBABedgybubXYOSQxv71uEBfJlW/IUPO2K5T9yGzoF/a1mMjWP+3OCVg/1M0kqL8sJ0TxfFRZ+nIheUwSQSXs54oHzRyttvL0G/1fTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sngmJqJ7ucPhZnzMLFPwva6IwAr9q9g4zCCNURafWgI=;
 b=Y/6sV74l2lkbaV7lIckx4rQ2CSX54M/sNodYVDw+3IGyAkornd1zcVUXEKV0ufw/ZOl4Fjk0vjOPBk2dh4Yj3iK47WyqKKwgfFTjf7gNFzE4WfP1orHRFXQseetypIwVRri9WX1ctjcfGTiEZwgwhYAM21f6QP4U/tnixPyhnohCcWqkU+aTuELn8NYgrOfcZBVGWDZYGUXIaJoqjhFSNOLXr6htX1GyjGcIrhIjeW0jz0cEZXnxLcDYrPJzB3U74avlBk/Ox1BYsSmh6MDAfOb92MjGszau8HF3ctY7bsjVIfxQP2znvUF7Uo1JjdCNtTKnMJXkMJZ5nfgavm7xDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sngmJqJ7ucPhZnzMLFPwva6IwAr9q9g4zCCNURafWgI=;
 b=BJ1ML/5nLHWNEeux3cRTlek4/PQZlrO3kjUlof6heQIfUxwP3iyIR3zT1Z9ueB7xh4YDqlw7irJht3vUnWCIPVSOiZTwLp1GyCIT89mxITrvhaHEsC4kh659TvsJSSAseOENOF8VtJw0qqxzlVs1Q/imwsLFiQ2piOMMGjH4h8od9oyJjDP+Rqaj59NkdD6awQPFL6945dNS324dO7HZeEtHIGuxZrYR3lJFEXsVIlltaD7OWW/b98ZVa9zApJabvZxPNSAGkmyoTIlV7c/FfLdiPExauDjoOfwW6BZ8bE2Wx0ZzF0+PfYy4ExAVQjv8wyE3fh+d4BVzaPSllsol1Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.34; Tue, 29 Apr 2025 06:11:05 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 06:11:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Thomas Huth
 <thuth@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, Alexey
 Kardashevskiy <aik@ozlabs.ru>, Hao Wu <wuhaotsh@google.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, Igor Mammedov
 <imammedo@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v7 1/1] pc-bios: Add AST27x0 vBootrom
Thread-Topic: [PATCH v7 1/1] pc-bios: Add AST27x0 vBootrom
Thread-Index: AQHbuKpi3iYWBsHEj02kq9qi+1jyXLO6KVsAgAAAKbA=
Date: Tue, 29 Apr 2025 06:11:05 +0000
Message-ID: <SI2PR06MB5041E7D589DC599CE54D8041FC802@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250429015938.74359-1-jamin_lin@aspeedtech.com>
 <20250429015938.74359-2-jamin_lin@aspeedtech.com>
 <9efdd5d7-c552-451f-a32c-fae2bc6553ce@redhat.com>
In-Reply-To: <9efdd5d7-c552-451f-a32c-fae2bc6553ce@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: b14e4737-12a2-41fe-29e1-08dd86e4a05b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?cm9tOWhFWHFFM0xJa2l4U25JcUNCOW02Z00vcGNSanRxTVp5T0djSWJtbEVl?=
 =?utf-8?B?aVNPYWtRNzJBdTVZYTVkbC9tL0hQWXZSVG5QaWlPbEJIMGN3ZEFpNC81OWhR?=
 =?utf-8?B?dklwa0Z4Zm9CVm9WOHJpdHB4c2Y2bENLaVczdVorSTZRU3VEQ21Xa2hURUxq?=
 =?utf-8?B?dGdNOTN2ODYrQUlrRDdiQy9ObjdxbWEwcmcyTHVCeWFNMmRaWFhsVUEzS1h0?=
 =?utf-8?B?TUVNSUZxWWQrWGM0L1orSU95YzFvejZWZlFoNUdHNDNmRlIyQzlvRVYxUmZk?=
 =?utf-8?B?R0NrT2JIZndZcUY2MUNBTW1tTG85bU9FL2tSbUNVR3ExYWJEdnREYnZrWHhj?=
 =?utf-8?B?cHVwVzAvS0dEM3gzUHdacWFxODJ6WVBUVmRtL1RIUW85eWFybFNvRWVhd20r?=
 =?utf-8?B?aFVzR0cyTUlRZlRFNDNxVEFxQU9wbUliM1ZoRTVzYWV5NEJNWG9qaFJmN2Zw?=
 =?utf-8?B?UTh1RVF4S004N1Z6bStKZkl6NWpSRXNtTS9OZ0t1TVk1NjdCVW5sL2QwNTJP?=
 =?utf-8?B?V3pMSmFZRCtaVWZTWDI4YjdWQk5VZ05tTkdzYnFHaWFXVnB1aTJpNm9jQ2kv?=
 =?utf-8?B?czdXNlp4V3BKZmRqQ0NLTEVjb3l2dFo5bWJ3YUFxN0RZNmE4d0paTFduQ21j?=
 =?utf-8?B?dU9lWmpFREJEcnRkODRCcG5sKzBqbEVYQ2xVNGNjS1Y4bWc4dG1MT3hSWUh0?=
 =?utf-8?B?eFp2a2o4U2x5dnYxYjNjaWczeVVTbFZCbkY2eEIvMEM4NVk3ZkVFMDlUdS92?=
 =?utf-8?B?MlQzb2pSbm1OWHRPeUloQ29iNDQ5K0g5UG9qTzNyYVpIWTJkUktCR1JSNnI2?=
 =?utf-8?B?eS82VjVjUktBYUh5QzRtRzgvVlZSUFdSOGlvdzRYKzBMTjkxeXI1T0RhVEhw?=
 =?utf-8?B?dmpyd05zYlpBQ21IRWJncGNxaUZwd3I4ekdFbk9odG42YWUvQUhaV1BBcWNE?=
 =?utf-8?B?RWt5YVM4V2RaMEJrUldOMkFLZ2dtbEQvb0IvcmUxK2ViSVBwc2pTcVMrN3Fr?=
 =?utf-8?B?ZFZRSkJWMERubG5FUGZxYnliYWZzRGl0VTI5dCtxbWpndVlDL0pyMFRackFP?=
 =?utf-8?B?azVycjZoczdsNEVOVkVnaTFYL0Z4RThWYjcvcHJ1S2FCM3JtbkRkNjFidXVI?=
 =?utf-8?B?NnBVUTgxdW1Oc3BwMTVmbTEyTi9kMWswTFpsWFVFZVBETmJVRFAzaTQxY29t?=
 =?utf-8?B?YnBKSjRHK3RmTlgzUEFsOG1wZmFtb0trbmVDaGFQM010MG5uQmovUUR1UjVJ?=
 =?utf-8?B?dDZ2NEdPb0hrQ0ZCWDlYTDc5bVVTdHVCQ2t1d1U2QTZHMlNrV1R4V0lsK0Jo?=
 =?utf-8?B?MXUzbzFHNnRBbUFUUUxMcjkyWmxhU3c3TlhNejJlS1lUYTk5UkhDTnZORW9q?=
 =?utf-8?B?bDQxcWZ0YUdaUFpIbFN3ZHlHODJZL0hMN0NZQ0J0UExXQU9tb2h6UUF6YWxl?=
 =?utf-8?B?YVhUMHdQd2xMY0lYK1FNSFhvajJsRUpFZWlIQzJFQkRycnVGTERESXdKMEhz?=
 =?utf-8?B?SVNTQ3NxQUtVaFRoKzFuSG9rckxkTXVYcXlTU1RWWU42VkxtRkI0cktMVXFJ?=
 =?utf-8?B?NGwzcTcvUkdxQnpsUWtXU1RMM2ZGWFNmVzlmOWZWSmpHc0UwQ0YzVXY5eDhv?=
 =?utf-8?B?OWNxR2NPUUQyMGRZaVEvT1ViYlpLTmdjUUhXMzVWeXdYS0FmQzZITGc5SEIw?=
 =?utf-8?B?ejdWUDEzdmMwamZMZitTZVB5WE02TnU3TFhHbjQ5ODdGVnF5Zmd3Tldmb3ht?=
 =?utf-8?B?K0JmMnF4T2JiUnVRczlrR3hTWGlEWUkvN3NiZkxZdDZNTWlseExoTEx3bVpm?=
 =?utf-8?B?a2YzdnhOdlBaNVFOa0M3T2svWGdFSEJYMjJDQXdiOG5lZFc1NkpvQWg2cy9s?=
 =?utf-8?B?RU9PdVdXQllnaGIzY1N4a1RaYkcrRmNhdzdiVG9ybHVLWmRrL2dwSVhHU1J1?=
 =?utf-8?B?YU96RXFTa1N2ZVdXNzg4dE9aNFc3MG5udk5HbmZ4eDdxRXRRNndtdUJncXNZ?=
 =?utf-8?B?dXY0T0ZEZ1VUOUp0dnF1RjRWWkQ3b25YamRrRy91cUd5NWdtU0MrbnpXc1lr?=
 =?utf-8?Q?4+TQ0h?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjM1VTJrNm9KSWdEWUVOTk5VcjdJNWJhanl2Ylg4c0x3cnhOVHJmci9oME1i?=
 =?utf-8?B?eHpWN3J5QkdHN0ZRUnFvVnZBVW5Fb3RDQ1V6bkFvT294QlpQSXRMSk1RMUpM?=
 =?utf-8?B?aXdVMElPZThUelV3NTQ3OTNxZzVTK1JtcE9WWHM3VER6OXlacTUvVm9Bb3Uv?=
 =?utf-8?B?RDF2MTVkUFVBcW9TdURnWVVOdFcybjhiOEZ1ODJybkFVeXg2UHQ5Ynl0NXI0?=
 =?utf-8?B?eUdmNHF3NEs5S3VPQ2t1YmxrNHM3eTRLbGFZSmRaMCtPVFNGMkRMTDdYdVRs?=
 =?utf-8?B?YXMvOWRYS1A0VUg2ZnQ0bnZ4allwTlI2V1NkL0Zva1RDNmNmOUJjK3RzZjF0?=
 =?utf-8?B?Zld4ODBqdzUyUnQzZkZoaTFIWG04K0RUMStZVk1SL0JoNkV3VXZHVWZuQWJV?=
 =?utf-8?B?T29ydHJPQ010WUNjZytmMUlxTWZiZmZVQW1oZ3dGM1Q5VXJobVc3bW5Vb3pS?=
 =?utf-8?B?bERPMy9JMjNrM2V6R1FPclFxR2ZUQTVMbStkK3VLTjk1YldWaWxGL0FnTitO?=
 =?utf-8?B?dzdJUUZ5OFloYzZ3MkxaK1pJYjcySktTZ0xhNC84cHRBUWRNR3pwdHJsYXNT?=
 =?utf-8?B?bnhBaHcrSTdmWWhiQkNWWGJ2SDI1eFNsMjJaaUgrUG9jU0F6eCtCWHRzYVU1?=
 =?utf-8?B?eEVVTGdXNFZIZlFmRitLdmVqaEExRTZnMjhVTDlybmhjM2FhaU12M2E1MmFH?=
 =?utf-8?B?R3B1WldoZWp3Y2k5OW12cFlPYSt5cmoyT2NaQkVyZFd1ZUhsazV6YUdNRkQ2?=
 =?utf-8?B?VlFRaE0wZ0h2QlppL3JoWFRFYjVFRjFLd0tMSjVoV29tbjVzWERBZGxYTm9T?=
 =?utf-8?B?ajd4enpWQTl6UEhvbjZGRDRKZVo2bmUyeXNwQzhiU2pBZTQwaWwvTCtVWGkz?=
 =?utf-8?B?NWFvcTI1SU1GRGdEWkdUTEdJUklJSjB1VThBY3hUaXNaL2FCSGp6bW9ob2FB?=
 =?utf-8?B?UVdoWXk1d3lFVkxiOFRPT2JIVmJibG5oNGxCVjUxN2JkcUgvVDdMV3ozdm9H?=
 =?utf-8?B?LzhpbFR6TVNCTDk4OXcvaGY3Y3BoQmdwd0FYVDdLaUN2V1VVRCsrb2g0ZEpQ?=
 =?utf-8?B?eVZ6RGFQOFFuUW8zQkFJdGduVWRZd0U0NzRTMTZkb0xnTVVTeWd1bzZoQVBx?=
 =?utf-8?B?TDljS1ZMZWdySVpteEpXbFFMWmlieTJuekcycXMzVWJEYm02UmEvYkMrdkRo?=
 =?utf-8?B?QjlWWUJsTGs5TXRDa2kvNzVYdEpSMVZZMlNtMUpFZSttYUV4ZXZiRGxTNWdX?=
 =?utf-8?B?M2JPdUZ6WGU1Q3JVWFBUeTVyMUdvYjFyUy8zMFBQRDJGSFh2Z0kzaHJYN1or?=
 =?utf-8?B?ZXVWQTgvZWhwQVNpamdRVzdERlZsU3RWY3dJb1N2UXFyUHNnd2xGYTBjdHB1?=
 =?utf-8?B?RzlSYVZ4UG55U1lxL3Bvd3oxUmpmUzNLRjBuWWtBSmFvS2NPWmVoQ3FoRWEv?=
 =?utf-8?B?TVFpQllNNlZ1MXZ2a0UvaVN6dE1nWWVmMDRFM2xXWXM4cXhxK2lQVTdDQUVT?=
 =?utf-8?B?UXlwS09FQzlZd3JqSSt5OXVsU2d2VnBNRGQzYmtyZXNNT2s5Vm85RFE1UVRz?=
 =?utf-8?B?T1paU1g0dDJGM2l1dStmR01waEo3T1BXamtNM0pJNGszdVhnWHFUZ1RXYklE?=
 =?utf-8?B?UHpCcjYrck1MSGh0dXJBNVk5Ym4vcTFZbWoxQW9OMnF3MUptQ2JMYnYxcmRq?=
 =?utf-8?B?cjN0QXBwQUNNcEVJd3luNWJYOUxQR1R0bjVHTEdnaE56d3dWQkRYYXo2Zk9Z?=
 =?utf-8?B?OVkvZFlTd1NtekF4TTUzQnJhQUZGMFRXby9vanRTcTk4elBBekhsdFNlaFd2?=
 =?utf-8?B?ZlREUkovRFBZeHlrSm1HRjdLdndNeGdoSVVjOTVsM0pseUZNYThjVk1YaTdl?=
 =?utf-8?B?amtYMkFpTE8yRUVYMlpNT3F6SG9SQ2wrd1h5clJMNlBFUW1aY0Vvc1VWUFA0?=
 =?utf-8?B?T2ovYmhQL3RWMVZ4UEp1QUJBUkl5Rm1RTm5MMUtndCtCaHYxQ3U0Uy82MCt3?=
 =?utf-8?B?NG9SNUY0eVdFdElYbHFaMUc1T1k1MEdqSitLT0lkdTFxaGJ6b0dwa3YzMjRM?=
 =?utf-8?B?cEFtQUR1bkhmTDhSY0FKNklDb2FoejdSajY4aW13Qnl5SFdvQ1lQSU5VZW9I?=
 =?utf-8?Q?ka1IXmrdbUT9SLz+ewUk8jBaJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14e4737-12a2-41fe-29e1-08dd86e4a05b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 06:11:05.7164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fEkrWoNHyru0HqOh1KJPT5f658Q//St5o/x95o1KEq2WgG38ia6eb6j0il+S87x8zQdfMFH12Ro6qqTVmH1b65CO5huUx34Fb/5cY+2aHC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
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

SGkgQ2VkcmljLCANCg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsg
bmFiaWhlc3RlZmFuQGdvb2dsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAxLzFdIHBj
LWJpb3M6IEFkZCBBU1QyN3gwIHZCb290cm9tDQo+IA0KPiBIZWxsbyBKYW1pbiwNCj4gDQo+IE9u
IDQvMjkvMjUgMDM6NTksIEphbWluIExpbiB3cm90ZToNCj4gPiBUaGUgYm9vdCBST00gaXMgYSBt
aW5pbWFsIGltcGxlbWVudGF0aW9uIGRlc2lnbmVkIHRvIGxvYWQgYW4gQVNUMjd4MA0KPiBib290
IGltYWdlLg0KPiA+IEl0cyBzb3VyY2UgY29kZSBpcyBhdmFpbGFibGUgYXQ6DQo+ID4gaHR0cHM6
Ly9naXRodWIuY29tL2dvb2dsZS92Ym9vdHJvbQ0KPiA+IENvbW1pdCBpZDogZDZlMzM4NjcwOWIz
ZTQ5MzIyYTk0ZmZhZGMyYWFhYjk5NDRhYjc3Yg0KPiA+IEJ1aWxkIEluZm9ybWF0aW9uOg0KPiA+
IGBgYA0KPiA+IEJ1aWxkIERhdGUgOiBBcHIgMjkgMjAyNSAwMToyMzoxOA0KPiA+IEZXIFZlcnNp
b24gOiBnaXQtZDZlMzM4Ng0KPiA+IGBgYA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4g
TGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE5hYmloIEVz
dGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBDw6lkcmlj
IExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4gVGVzdGVkLWJ5OiBOYWJpaCBFc3RlZmFu
IDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAgIE1BSU5UQUlORVJTICAg
ICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gICBwYy1iaW9zL1JFQURNRSAgICAgICAgICAgICAg
fCAgIDYgKysrKysrDQo+ID4gICBwYy1iaW9zL2FzdDI3eDBfYm9vdHJvbS5iaW4gfCBCaW4gMCAt
PiAxNTU1MiBieXRlcw0KPiA+ICAgcGMtYmlvcy9tZXNvbi5idWlsZCAgICAgICAgIHwgICAxICsN
Cj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgcGMtYmlvcy9hc3QyN3gwX2Jvb3Ryb20uYmluDQo+IA0KPiBbIC4uLiBdDQo+IA0K
PiA+IGluZGV4IDM0ZDY2MTZjMzIuLjgzOTk4ZjYwNzEgMTAwNjQ0DQo+ID4gLS0tIGEvcGMtYmlv
cy9tZXNvbi5idWlsZA0KPiA+ICsrKyBiL3BjLWJpb3MvbWVzb24uYnVpbGQNCj4gPiBAQCAtODQs
NiArODQsNyBAQCBibG9icyA9IFsNCj4gPiAgICAgJ25wY204eHhfYm9vdHJvbS5iaW4nLA0KPiA+
ICAgICAndm9mLmJpbicsDQo+ID4gICAgICd2b2YtbnZyYW0uYmluJywNCj4gPiArICAnYXN0Mjd4
MF9ib290cm9tLmJpbicsDQo+IA0KPiBJIHRoaW5rIHRoaXMgbGlzdCBzaG91bGQgYmUga2VwdCBp
biBhbHBoYWJldGljIG9yZGVyLiBDb3VsZCB5b3UgcmVzZW5kIHBsZWFzZSA/DQo+IA0KT0sNCg0K
PiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0KPiANCj4gPiAgIF0NCj4gPg0KPiA+ICAg
ZHRjID0gZmluZF9wcm9ncmFtKCdkdGMnLCByZXF1aXJlZDogZmFsc2UpDQoNCg==


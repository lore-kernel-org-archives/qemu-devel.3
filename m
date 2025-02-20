Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFA0C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 05:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkyrG-0004xT-3t; Thu, 20 Feb 2025 00:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tkyrE-0004x7-4h; Thu, 20 Feb 2025 00:12:20 -0500
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tkyr8-0002Lm-Nq; Thu, 20 Feb 2025 00:12:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHBBRcaf01f8gjOAK/faV5OCxpFKEik+6R7n3nN36Mu+rsOZTRxU4lpj8Vms0VsaL75GbU4iu1BXKs5+v83eT5hSbnSNwLAfIseM7N+xG8ywIor3fowJ8p7HzSx39oF1ByFO7k42liOewkEXp+U9n70C7kFz7XQrUOWNTrTW8S0ewA1zRv515YOHjp+1zzpAP+lS4iTko+NshkMCmMC3W4PiBdiTiwzlVFY101KXlFeYqZNWu+FV305LrzmpnKowDBYadrNeJnq4sY65qi1McgyJcg0J0AiKDGPrmWWX9QDgqBQeMjwQ/o+Rf/mcBd5IidO4n9lUz9bn3CzI3q0MiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW5f3HR2ucZeS+UbGkWlJkft6PKYM1lg8+sTSujjSQI=;
 b=Gcto7lSkiKXdHaZZYL+elu04wuboNh5PdihNYDpTKNJ02KyANBqC64xHT1wZIP3qJ4KjdJZNN/qS/RvEsV/G59GWKUc/IfPKFw5y8pXYh6d/xf5+8wCYFI/NOu7Pxl8OmMqn36gmWXXkqblGLdBlkOXzp2etaaIecPL0guqUVMdv6cbUu5OkZt7anpjLLDm3mS0VNarzNoBySDZmHRfOiZtyajynjDVm15ryqmWf401Q4ZgRQagtbR4xSeBgON6xTNkpZX16Ux2KSFsYZAwjd7VlOsAJv6K/A48KFrEDW2xeretRqehJucKHUGPxwVAvIx6re5r6zqtSNSncdJHvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW5f3HR2ucZeS+UbGkWlJkft6PKYM1lg8+sTSujjSQI=;
 b=XiARR9PmVwLHLs/qToUC8zPq5SdXtDiNWoyatmEXN1xaqTdvh9UsCOrGXQN2lbcUCbUQ65qKmk9LmlDAG9DhkHu67/cv+cz6MyGmhIYkmTopO/dDIl92TeMoO59GPPWR35FH50x0r1rpCC7smjwl1Z+a0HK84nPkprUKN9Pu2EXuBW4xb2FKP6s07MuDx2SMX0gjyErzGG+9qB0xGxbjj7fbp5uE58sm9grFp8Jk2GfHfGSQmvhsv7REQPcyFYHmXtYw9G+2r3L+Tpm5sT0azt/AGAqjZRCk2IvHFmi9QG36RNfKoF/LasxPOdK/wFxT3hsl9Sq4hCPL4hCHm9l4ZA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB4994.apcprd06.prod.outlook.com (2603:1096:4:1a1::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Thu, 20 Feb 2025 05:11:53 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8466.009; Thu, 20 Feb 2025
 05:11:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 00/28] Support AST2700 A1
Thread-Topic: [PATCH v3 00/28] Support AST2700 A1
Thread-Index: AQHbfchZ2DVXsd5AV0G4GwgEpHk/17NM0p0AgALZSbA=
Date: Thu, 20 Feb 2025 05:11:50 +0000
Message-ID: <SI2PR06MB5041D7BFF0F491FFA7CE3159FCC42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <4bbd5a9e-934e-4535-b829-1d4fe070d63d@kaod.org>
In-Reply-To: <4bbd5a9e-934e-4535-b829-1d4fe070d63d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB4994:EE_
x-ms-office365-filtering-correlation-id: c04b2987-9774-4e1e-2268-08dd516d155c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NzgweVlYMEt2V3lzSWNadWtiV2RzWU1jM0lodkdZQ3pHcjRtRUI2V2I1UVI5?=
 =?utf-8?B?SzFLZTIxeU5KU1JJQXVFUkRYWXRzb2ZWM1h5UWxIcGN6eGZHNFZEdVhrWmoy?=
 =?utf-8?B?d2w5ZmxkTW55MkNBY1F4bUhXVnZZNisvTEp4aUphNlVOcEl2OXRQMUFqNzNB?=
 =?utf-8?B?Wk9QemJmMG51QXhUUEFqdThDYjl2Q0JXaU9YdzJVZG1uSXlURUJ5UWRIVjdI?=
 =?utf-8?B?QWVXNFc0ODkzSm9TOUVVcFY0b0I1OHRwcDkyYUs1MWpRYkRXekNaVTVVL0ll?=
 =?utf-8?B?bUQ4bU5sVEhMWnVhcm8xUjZNVitjS3ViVXBndEVpT0V6K29qSm4yZVZLVGo2?=
 =?utf-8?B?WVhiaHhUVVZybVNrY1RTclA4ZW96cGVocHU4RU51cHp3cVB1dWY2MjVBcVVU?=
 =?utf-8?B?eDdMTjdBVzVoNTA1S3dPQkh3aWdWMUdCNkw2N0d3Y3IyUlh6bFZMalFuVkNz?=
 =?utf-8?B?ZEdhZlJzU0hCWGgwS2RRbzJaeVVYUEo1NTJpRTJudmgvcWxCN0JWR1ZmY3dj?=
 =?utf-8?B?Q3JxWGdtRnV2UmZuUUhPTTlmcDVNVFhaa2Erd1doQU10VWRITkN4NTFKcm81?=
 =?utf-8?B?aTEzbmxEME5ZamJ4QUZ2a2duRE1GbjlPZTNscnpKcWYzYWlMdUk5YkF4b0w1?=
 =?utf-8?B?SXdFM2QvT2xYOU9GNWVIajZNbWJJSGl6enJyUWtGamJrZDNydG4vMktpbURY?=
 =?utf-8?B?MjA0WXNCSjM1MUtmVHBEbnNMb1BlTXEyYXdhOFZCc0pwdUlUZ2NpTkdod1Jq?=
 =?utf-8?B?MG5TUWRvKzloeFAzWVlFc3RwQW5RUnZQTkhuQVRLdUFXT2ZkcmlxVTVyajJn?=
 =?utf-8?B?ZEgrZExSTURodDlzK2VmYngzSlZ0dEVKc3ArazJmMlVXclNlUWpUQSt1Yllm?=
 =?utf-8?B?NzRMdndPNkl5VzdJaUM4Y3JuckRYdDc1aUNnbUtGaDVYeEtpN290Zld3TWdW?=
 =?utf-8?B?OHlvQ3JDMHUrRy9EcFYrUGtNU2wzaFZmOEk5OE0wbndSd2tablQ4YTB0K1I0?=
 =?utf-8?B?K21pNGhwN0wybUt5S09VN05FSEVoZGdTOU54UjFHMmkyVUN3dWlDNUdFSUpM?=
 =?utf-8?B?NmlnL1RzYjlFNmhkcVNGa0EyUlREMHlacDhOM1AyTzBSK2tXN0dpbjZ5SnJX?=
 =?utf-8?B?YVpydlFzbDl6VGZyTEJIUHZJd2g4QmRUOHY4WW4yLzR6NktwZkpPaFdSU255?=
 =?utf-8?B?TVZMbWFzUDFYcGVFVkFTWFY5TlloTkdFMytjeHZ4eWF4aUZrQS9vZXFMNk1n?=
 =?utf-8?B?eElwTzRNSlBubGoxcllsKzl6Szd4c2ZCeHlCeWdEaTJ4ZGl1OHF0OXhvampy?=
 =?utf-8?B?b0RDdFJZS1JuQStmN0UrMTlad2RhcU1yalhTVzJpU0Z4czJESDJSL3ZhdWVG?=
 =?utf-8?B?cUtGd2didG9obVdVRHN2MVVZRVFDQlJsV3RtUEdSbU5uNjgzSmdtM2VsQ2x0?=
 =?utf-8?B?Y3kwd1hKQWQ2WnBYdm1wbnhXQ1FsVGovWjdtR3hJVzdLWlYvaUpDZnk0Ymh0?=
 =?utf-8?B?b0tjVmQvVXJlNDVnYnh0cEczQWIyaVZCS2lYaVl3OXpVb1JBZ1VLSjZ0U2hh?=
 =?utf-8?B?UU15azVmUzMrcUJZMUZPVjlNb2JiUXlOR0p2L1lpNGNHOGhvL2VWL1VVam9H?=
 =?utf-8?B?Rm1KNitXVG5xZE9zUEZ0YU5ERWpYZU5meGp5QlJsZDRncHlPb2IycHRzTlFZ?=
 =?utf-8?B?MkswbUtYWk9EUHpObDZnYXNNRnZhbE5sRlE3ZEI0aWY5SHF2bUphZExqcnVu?=
 =?utf-8?B?OTQ0TXhyRmJiRitzRFBPTmZsdUZ2ZEVtV2J0QUNTSFgxSllON3I1YXdCYVVF?=
 =?utf-8?B?SXovWFgrZnV5YXNENkEwNVBvOGlEQmQwK2E4Q2lCSU9OSWZta3lnVkV4bDQ1?=
 =?utf-8?B?ZVVLaGZDcmFFQjR6RWlzeTZkZk1vd3M1dFpjbHYyS0lVd0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bldSY096VTR6U3NHei9JZ1hpcm5OVWxkbXNpNldjeTFSU2l2OHNubk5zN3hi?=
 =?utf-8?B?ZTlBWGl5VFF5d2daYjdCZ3pOSld3MjBtcG5YWlhyeXZuRFh4VVF0VERGYVZa?=
 =?utf-8?B?eXYzaFVzNFgyUjVwaG0zWjE0RWxPd3k4T1MvdWxuV3hUYWVaejBVM0M4WG5F?=
 =?utf-8?B?UmhQZEpZcUNEaWxLUVRMVmRyNXgvaVk4b2QxOHNMcys2dDR1czdmdmJXYytz?=
 =?utf-8?B?cnFma0x0a2VqWXRaaDRXbG5CTjhxSnR3Q29NRGRNQnhHZkYzZXJvcGd1bjQz?=
 =?utf-8?B?ZFZ0emJBb2FpTEdGVnZJV0NkMGlWb3ZWbUl6SkV5MlFSSWl6Y0JQMXg4Qk1s?=
 =?utf-8?B?VU1sUnZQa1YxRDlEa0hDOUhXSmR6UkdKc2lpRUYvYXVtUlVLMDQvdy9GTXFp?=
 =?utf-8?B?TGJxVlVCYTNBWHFQSGlCVWRmQ3FzS21YNUxDRzRrZVZxR2xDWFM1SmI0MEVH?=
 =?utf-8?B?ZDNsSzZ2Zkh1ZkhnN2JBUi9kcEV5ZkRWb1YzYjZnV3VYWGpDMVI1NlZ4ZzM0?=
 =?utf-8?B?RXVsMDhYbUozWFRzV3EzSDZhb2ZmaXJuZ1hQRCtRNHRhaVpXUzlUWWx4UGpy?=
 =?utf-8?B?YVNDd3lweVBqL2ZEUVAzLzBJdWpjODVJdmFqOFIvUWZDQjN0VUJPd0s2SkRi?=
 =?utf-8?B?SXltQmZhaUliYlRsNVpPWFlyNEpQTGdTRXpBKy9xQ0I0aDRaQ2VnZGo1bzFR?=
 =?utf-8?B?K0pIMC9DOUdGL2NDOHFaczRoZGMwU1ZEemRSbWRSbmt6TUc1QnlGNm5iZUxQ?=
 =?utf-8?B?cCtTN3BZUzEzNldLZTJoTVQvanhXc3ZGZHN3ZUVLWFA3NlAzR2dFSXJZL01N?=
 =?utf-8?B?dG1PcHpVY0FIaDg0cVNLZHNjL2w2NW8rbFlPWXNTbVI0VW1oMDVjTjIwTENH?=
 =?utf-8?B?UUNZaVNHclp2T1Q1SURTMjYyWlFITTJwZTFWV3l5MmZ1Vm9KNVlDeWdzdkxQ?=
 =?utf-8?B?RjRlbUxoV3ZpQ3ExYlBiYjBrZ3RXdnFka3lGUTR1MjZXeG12aFBKY2Z1Tmc5?=
 =?utf-8?B?K0ZpTEJ0M2Z4WWNSOUh4ZGVPUlhMRjU0TDNGbTJFYU81SmxwekNqVG02MmhN?=
 =?utf-8?B?TU5xNHBwd3JoSHY3aGJ5RW5LWjZJdm93Z05iekljc3FxdEVSd3QwZVI3dWsr?=
 =?utf-8?B?d1NxUDFiNVJBdGlsL0VjdGtBYms4eEZRZUM1eWVZSDBwYmU4RFN4MGxVNEJy?=
 =?utf-8?B?RXhNSTBjUThWL3Y0bEtQYW56RGVYb1crVXVZQVdVcTBYSnZzY3djMzgxeFpP?=
 =?utf-8?B?V2tiRWxVaFFQQ2VZOUxGVkF0T3puV1JobWpoQU55d3c2dENVaW1HWFpOT1hC?=
 =?utf-8?B?UnB5MDIzc0FQay9ORU13U2VCTFFCVndDRW9kT2N1ZDVmYXVPR3pzcjRCaG53?=
 =?utf-8?B?OEVQM3lGNDRub3ZQOWpVK2g2R1hJZTdGVk84Nm9EcWNtTlRoVWJ5SlhYQlFp?=
 =?utf-8?B?Z0J2VXFoeHkwQi8zMFB6TmJGblJxOXhFeDhySCsyWXlLTXJzd1dxb0RvdGl4?=
 =?utf-8?B?dkVRQ3lkN05yMk1DNTkxKzJkS0xLRXJKWVpuTkl6dGNEcnBISEsrdGF2Nmgy?=
 =?utf-8?B?TkhJQzdOcm9EQjh1enNkVStKeVVoWld0MWJ1Tk9YdnI1K21mb1plRnkxWlF1?=
 =?utf-8?B?VitldEFLU29IZlhFZ2FubnNiWE14dFFRcVlYR2FhOVY5UWtIUGZLQnVsVEUy?=
 =?utf-8?B?ZUpKYTlwR1lNUVprcGpic2JCRkRzTGx5VzVSb1BVV2k0VnNCS3d3Z3M3b2VU?=
 =?utf-8?B?eGM5WVNJVmJMdnFTN2o5eEJQWVVPSmphU1NQU2YzVENMUldTNnVkb09TcEE1?=
 =?utf-8?B?UWcydWtvaUkrS2RrbnFwaEN3NnVrc3NDZlBCZU5DUU5CUXhoU1BCSnB3MzEr?=
 =?utf-8?B?WjBQZWJWb0kzQ3FRVUVoZ1dyVDZ5bFczVW51YytwRnA5SjdVbDVBbVhxVkRR?=
 =?utf-8?B?VHA0aWFKd0NIZDZ3dlpzRFFpRE9Ga2xqa0IvS3pveVZ3WExneFhrZDJsQWFL?=
 =?utf-8?B?ZU52SnJHNkFxOHlzVCt4endxNUQ1bllaMzV0cW00R3dDVmJKdWs2U204UUtO?=
 =?utf-8?B?alFTcHl3S2Q3WUlpZDd2RTVTWjVldHkxOWdoUThLTGFiMnh6S2MyWDJiWWJW?=
 =?utf-8?Q?KbMqMHqWTdt4hrABl0K7daUEq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04b2987-9774-4e1e-2268-08dd516d155c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 05:11:50.7907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5LRfaG8RYhkY/w6eiMlu2oLr1z7AeMURy/ncHfmrUXkePzYo4Tj7TTr7l/QZ9YHYmrXqkFw85TebQTULC2c5uZaCnAhEFiYOwa9Q02ND4Fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4994
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDAvMjhdIFN1cHBvcnQgQVNU
MjcwMCBBMQ0KPiANCj4gSGVsbG8gSmFtaW4sDQo+IA0KPiANCj4gT24gMi8xMy8yNSAwNDozNSwg
SmFtaW4gTGluIHdyb3RlOg0KPiA+IHYxOg0KPiA+ICAgMS4gUmVmYWN0b3IgSU5UQyBtb2RlbCB0
byBzdXBwb3J0IGJvdGggSU5UQzAgYW5kIElOVEMxLg0KPiA+ICAgMi4gU3VwcG9ydCBBU1QyNzAw
IEExLg0KPiA+ICAgMy4gQ3JlYXRlIGFzdDI3MDBhMC1ldmIgbWFjaGluZS4NCj4gPg0KPiA+IHYy
Og0KPiA+ICAgIFRvIHN0cmVhbWxpbmUgdGhlIHJldmlldyBwcm9jZXNzLCBzcGxpdCB0aGUgZm9s
bG93aW5nIHBhdGNoIHNlcmllcyBpbnRvDQo+ID4gICAgdGhyZWUgcGFydHMuDQo+ID4NCj4gaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvY292ZXIvMjAyNTAx
MjEwNzA0MjQuMjQ2DQo+IDU5NDItMS1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20vDQo+ID4gICAg
VGhpcyBwYXRjaCBzZXJpZXMgZm9jdXNlcyBvbiBjbGVhbmluZyB1cCB0aGUgSU5UQyBtb2RlbCB0
bw0KPiA+ICAgIGZhY2lsaXRhdGUgZnV0dXJlIHN1cHBvcnQgZm9yIHRoZSBJTlRDX0lPIG1vZGVs
Lg0KPiA+DQo+ID4gdjM6DQo+ID4gICAxLiBVcGRhdGUgYW5kIGFkZCBmdW5jdGlvbmFsIHRlc3Qg
Zm9yIEFTVDI3MDANCj4gPiAgIDIuIEFkZCBBU1QyNzAwIElOVEMgZGVzaWduIGd1aWRhbmNlIGFu
ZCBpdHMgYmxvY2sgZGlhZ3JhbS4NCj4gPiAgIDMuIFJldGFpbmluZyB0aGUgSU5UQyBuYW1pbmcg
YW5kIGludHJvZHVjaW5nIGEgbmV3IElOVENJTyBtb2RlbCB0bw0KPiBzdXBwb3J0IHRoZSBBU1Qy
NzAwIEExLg0KPiA+ICAgNC4gQ3JlYXRlIGFzdDI3MDBhMS1ldmIgbWFjaGluZSBhbmQgcmVuYW1l
IGFzdDI3MDBhMC1ldmIgbWFjaGluZQ0KPiA+ICAgNS4gRml4IHNpbGljb24gcmV2aXNpb24gaXNz
dWUgYW5kIHN1cHBvcnQgQVNUMjcwMCBBMS4NCj4gPg0KPiA+IFdpdGggdGhlIHBhdGNoIGFwcGxp
ZWQsIFFFTVUgbm93IHN1cHBvcnRzIHR3byBtYWNoaW5lcyBmb3IgcnVubmluZw0KPiBBU1QyNzAw
IFNvQ3M6DQo+ID4gYXN0MjcwMGEwLWV2YjogRGVzaWduZWQgZm9yIEFTVDI3MDAgQTANCj4gPiBh
c3QyNzAwYTEtZXZiOiBEZXNpZ25lZCBmb3IgQVNUMjcwMCBBMQ0KPiA+DQo+ID4gVGVzdCBpbmZv
cm1hdGlvbg0KPiA+IDEuIFFFTVUgdmVyc2lvbjoNCj4gPg0KPiBodHRwczovL2dpdGh1Yi5jb20v
cWVtdS9xZW11L2NvbW1pdC9mZmFmN2YwMzc2ZjgwNDBjZTkwNjhkNzFhZTlhZTg3Mg0KPiAyNQ0K
PiA+IDA1YzQyZQ0KPiA+IDIuIEFTUEVFRCBTREsgdjA5LjA1IHByZS1idWlsdCBpbWFnZQ0KPiA+
ICAgICBodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy90
YWcvdjA5LjA1DQo+ID4gICAgIGFzdDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neiAoQVNUMjcwMCBB
MSkNCj4gPg0KPiBodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxl
YXNlcy9kb3dubG9hZC92MDkuMDUvYXN0DQo+IDI3MDAtZGVmYXVsdC1vYm1jLnRhci5neg0KPiA+
ICAgICBhc3QyNzAwLWEwLWRlZmF1bHQtb2JtYy50YXIuZ3ogKEFTVDI3MDAgQTApDQo+ID4NCj4g
Pg0KPiBodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy9k
b3dubG9hZC92MDkuMDUvYXN0DQo+ID4gMjcwMC1hMC1kZWZhdWx0LW9ibWMudGFyLmd6DQo+IA0K
PiBUaGUgcGFydCBhZGRpbmcgbmV3IGZ1bmN0aW9uYWwgdGVzdHMgbmVlZHMgYSByZXdvcmsuIFNl
ZSBjb21tZW50Lg0KPiANCj4gPiBLbm93biBJc3N1ZToNCj4gPiBUaGUgSEFDRSBjcnlwdG8gYW5k
IGhhc2ggZW5naW5lIGlzIGVuYWJsZSBieSBkZWZhdWx0IHNpbmNlIEFTVDI3MDAgQTEuDQo+ID4g
SG93ZXZlciwgYXNwZWVkX2hhY2UuYyhIQUNFIG1vZGVsKSBjdXJyZW50bHkgZG9lcyBub3Qgc3Vw
cG9ydCB0aGUNCj4gQ1JZUFRPIGNvbW1hbmQuDQo+ID4gVG8gYm9vdCBBU1QyNzAwIEExLCBJIGhh
dmUgY3JlYXRlZCBhIFBhdGNoIDIxIHdoaWNoIHRlbXBvcmFyaWx5DQo+ID4gcmVzb2x2ZXMgdGhl
IGlzc3VlIGJ5IHNlbmRpbmcgYW4gaW50ZXJydXB0IHRvIG5vdGlmeSB0aGUgZmlybXdhcmUgdGhh
dA0KPiA+IHRoZSBjcnlwdG9ncmFwaGljIGNvbW1hbmQgaGFzIGNvbXBsZXRlZC4gSXQgaXMgYSB0
ZW1wb3Jhcnkgd29ya2Fyb3VuZA0KPiA+IHRvIHJlc29sdmUgdGhlIGJvb3QgaXNzdWUgaW4gdGhl
IENyeXB0byBNYW5hZ2VyIFNlbGZUZXN0Lg0KPiA+DQo+ID4gQXMgYSByZXN1bHQsIHlvdSB3aWxs
IGVuY291bnRlciB0aGUgZm9sbG93aW5nIGtlcm5lbCB3YXJuaW5nIGR1ZSB0bw0KPiA+IHRoZSBD
cnlwdG8gTWFuYWdlciB0ZXN0IGZhaWx1cmUuIElmIHlvdSBkb24ndCB3YW50IHRvIHNlZSB0aGVz
ZSBrZXJuZWwNCj4gPiB3YXJuaW5nLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcgc2V0dGluZ3Mg
aW4geW91ciBrZXJuZWwgY29uZmlnLg0KPiA+DQo+ID4gYGBgDQo+ID4gQ09ORklHX0NSWVBUT19N
QU5BR0VSX0RJU0FCTEVfVEVTVFM9eQ0KPiA+IGBgYA0KPiANCj4gV291bGQgaXQgYmUgcG9zc2li
bGUgdG8gc2VuZCB0aGUgaGFjZSBjaGFuZ2VzIGluIGl0cyBvd24gc2VyaWVzID8NCj4gDQo+IA0K
Q3VycmVudGx5LCB0aGUgSEFDRSBIVyBlbmdpbmUgYW5kIGNyeXB0byBzZWxmLXRlc3RzIGFyZSBl
bmFibGVkIGJ5IGRlZmF1bHQgaW4NClNESyB2MDkuMDUgRlcuIFRvIGJvb3QgUUVNVSBmb3IgQVNU
MjcwMCBBMSB3aXRoIHRoZSBTREsgdjA5LjA1IHByZS1idWlsdCBpbWFnZSwNCmEgQ1JZUFRPIHdv
cmthcm91bmQgcGF0Y2ggaXMgcmVxdWlyZWQuDQoNClRoZSBBU1QyNzAwIEExIHBhdGNoIHNlcmll
cyBpbmNsdWRlcyBmdW5jdGlvbmFsIHRlc3RzLiBUbyBtYWtlIHRoZSBmdW5jdGlvbmFsIHRlc3Rz
DQpwYXNzIGZvciBBU1QyNzAwIEExLCBJIGhhdmUgaW5jbHVkZWQgdGhlIEhBQ0UgcGF0Y2ggaW4g
dGhlIHNhbWUgcGF0Y2ggc2VyaWVzLg0KDQpUaGVyZSBhcmUgdHdvIHdheXMgdG8gc3BsaXQgdGhp
cyBwYXRjaCBzZXJpZXM6DQoNClNvbHV0aW9uIEE6DQoNCjEuIENyZWF0ZSBzZXJpZXMgMSB0byBz
dXBwb3J0IEFTVDI3MDAgQTEuDQoyLiBDcmVhdGUgc2VyaWVzIDIgdG8gc3VwcG9ydCBIQUNFLg0K
My4gQ3JlYXRlIHNlcmllcyAzIHRvIHN1cHBvcnQgQVNUMjcwMCBBMSBmdW5jdGlvbmFsIHRlc3Rz
Lg0KDQpTZXJpZXMgMyBzaG91bGQgZGVwZW5kIG9uIHNlcmllcyAxIGFuZCAyLg0KDQpTb2x1dGlv
biBCOg0KDQoxLiBQbGFjZSBhIHByZS1idWlsdCBpbWFnZSBjYWxsZWQgImFzdDI3MDAtYTEtcWVt
dS1kaXNhYmxlLXNlbGYtdGVzdCIgaW4gdGhlIFNESyB2MDkuMDUgR2l0aHViIHJlcG9zaXRvcnku
DQpodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvb3BlbmJtYy9yZWxlYXNlcy90YWcv
djA5LjA1DQoyLiBDcmVhdGUgb25lIHBhdGNoIHNlcmllcyB0byBzdXBwb3J0IEFTVDI3MDAgQTEg
d2l0aCBpdHMgZnVuY3Rpb25hbCB0ZXN0cy4NCjMuIENyZWF0ZSBzZXJpZXMgMiB0byBzdXBwb3J0
IEhBQ0UuDQoNCkNvdWxkIHlvdSB0ZWxsIG1lIHdoaWNoIHNvbHV0aW9uIHlvdSBwcmVmZXIgb3Ig
Y291bGQgeW91IHBsZWFzZSBnaXZlIG1lIGFueSBzdWdnZXN0aW9uPw0KDQpUaGFua3MtSmFtaW4N
Cg0KPiA+DQo+ID4gSmFtaW4gTGluICgyOCk6DQo+ID4gICAgaHcvaW50Yy9hc3BlZWQ6IFN1cHBv
cnQgc2V0dGluZyBkaWZmZXJlbnQgbWVtb3J5IGFuZCByZWdpc3RlciBzaXplDQo+ID4gICAgaHcv
aW50Yy9hc3BlZWQ6IEludHJvZHVjZSBoZWxwZXIgZnVuY3Rpb25zIGZvciBlbmFibGUgYW5kIHN0
YXR1cw0KPiA+ICAgICAgcmVnaXN0ZXJzDQo+ID4gICAgaHcvaW50Yy9hc3BlZWQ6IEFkZCBvYmpl
Y3QgdHlwZSBuYW1lIHRvIHRyYWNlIGV2ZW50cyBmb3IgYmV0dGVyDQo+ID4gICAgICBkZWJ1Z2dp
bmcNCj4gPiAgICBody9hcm0vYXNwZWVkOiBSZW5hbWUgSVJRIHRhYmxlIGFuZCBtYWNoaW5lIG5h
bWUgZm9yIEFTVDI3MDAgQTANCj4gPiAgICBody9hcm0vYXNwZWVkX2FzdDI3eDA6IFNvcnQgdGhl
IElSUSB0YWJsZSBieSBJUlEgbnVtYmVyDQo+ID4gICAgaHcvaW50Yy9hc3BlZWQ6IFN1cHBvcnQg
ZGlmZmVyZW50IG1lbW9yeSByZWdpb24gb3BzDQo+ID4gICAgaHcvaW50Yy9hc3BlZWQ6IFJlbmFt
ZSBudW1faW50cyB0byBudW1faW5waW5zIGZvciBjbGFyaXR5DQo+ID4gICAgaHcvaW50Yy9hc3Bl
ZWQ6IEFkZCBzdXBwb3J0IGZvciBtdWx0aXBsZSBvdXRwdXQgcGlucyBpbiBJTlRDDQo+ID4gICAg
aHcvaW50Yy9hc3BlZWQ6IFJlZmFjdG9yIElOVEMgdG8gc3VwcG9ydCBzZXBhcmF0ZSBpbnB1dCBh
bmQgb3V0cHV0IHBpbg0KPiA+ICAgICAgaW5kaWNlcw0KPiA+ICAgIGh3L2ludGMvYXNwZWVkOiBJ
bnRyb2R1Y2UgQXNwZWVkSU5UQ0lSUSBzdHJ1Y3R1cmUgdG8gc2F2ZSB0aGUgaXJxDQo+ID4gICAg
ICBpbmRleCBhbmQgcmVnaXN0ZXIgYWRkcmVzcw0KPiA+ICAgIGh3L2ludGMvYXNwZWVkOiBJbnRy
b2R1Y2UgSVJRIGhhbmRsZXIgZnVuY3Rpb24gdG8gcmVkdWNlIGNvZGUNCj4gPiAgICAgIGR1cGxp
Y2F0aW9uDQo+ID4gICAgaHcvaW50Yy9hc3BlZWQ6IEFkZCBTdXBwb3J0IGZvciBNdWx0aS1PdXRw
dXQgSVJRIEhhbmRsaW5nDQo+ID4gICAgaHcvaW50Yy9hc3BlZWQ6IEFkZCBTdXBwb3J0IGZvciBB
U1QyNzAwIElOVENJTyBDb250cm9sbGVyDQo+ID4gICAgaHcvbWlzYy9hc3BlZWRfc2N1OiBBZGQg
U3VwcG9ydCBmb3IgQVNUMjcwMC9BU1QyNzUwIEExIFNpbGljb24NCj4gPiAgICAgIFJldmlzaW9u
cw0KPiA+ICAgIGh3L21pc2MvYXNwZWVkX3NjdTogRml4IHRoZSByZXZpc2lvbiBJRCBjYW5ub3Qg
YmUgc2V0IGluIHRoZSBTT0MgbGF5ZXINCj4gPiAgICAgIGZvciBBU1QyNzAwDQo+ID4gICAgaHcv
YXJtL2FzcGVlZF9hc3QyN3gwLmMgU3VwcG9ydCBBU1QyNzAwIEExIEdJQyBJbnRlcnJ1cHQgTWFw
cGluZw0KPiA+ICAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MDogU3VwcG9ydCB0d28gbGV2ZWxzIG9m
IElOVEMgY29udHJvbGxlcnMgZm9yDQo+ID4gICAgICBBU1QyNzAwIEExDQo+ID4gICAgaHcvYXJt
L2FzcGVlZDogQWRkIFNvQyBhbmQgTWFjaGluZSBTdXBwb3J0IGZvciBBU1QyNzAwIEExDQo+ID4g
ICAgaHcvbWlzYy9hc3BlZWRfaGFjZTogRml4IGNvZGluZyBzdHlsZQ0KPiA+ICAgIGh3L21pc2Mv
YXNwZWVkX2hhY2U6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4gPiAgICBody9taXNjL2FzcGVlZF9o
YWNlOiBGaXggYm9vdCBpc3N1ZSBpbiB0aGUgQ3J5cHRvIE1hbmFnZXIgU2VsZiBUZXN0DQo+ID4g
ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwOiBBZGQgSEFDRSBzdXBwb3J0IGZvciBBU1QyNzAwDQo+
ID4gICAgdGVzdC9mdW5jdGlvbmFsL2FzcGVlZDogSW50cm9kdWNlIG5ldyBmdW5jdGlvbiB0byBm
ZXRjaCBhc3NldHMNCj4gPiAgICB0ZXN0cy9mdW5jdGlvbmFsL2FzcGVlZDogSW50cm9kdWNlIHN0
YXJ0X2FzdDI3MDBfdGVzdCBBUEkgYW5kIHVwZGF0ZQ0KPiA+ICAgICAgaHdtb24gcGF0aA0KPiA+
ICAgIHRlc3RzL2Z1bmN0aW9uYWwvYXNwZWVkOiBVcGRhdGUgdGVzdCBBU1BFRUQgU0RLIHYwOS4w
NQ0KPiA+ICAgIHRlc3RzL2Z1bmN0aW9uYWwvYXNwZWVkOiBSZW5hbWVkIHRlc3QgY2FzZSBhbmQg
bWFjaGluZSBmb3IgQVNUMjcwMA0KPiBBMA0KPiA+ICAgIHRlc3RzL2Z1bmN0aW9uYWwvYXNwZWVk
OiBBZGQgdGVzdCBjYXNlIGZvciBBU1QyNzAwIEExDQo+ID4gICAgZG9jcy9zcGVjczogYWRkIGFz
cGVlZC1pbnRjDQo+ID4NCj4gPiAgIGRvY3Mvc3BlY3MvYXNwZWVkLWludGMucnN0ICAgICAgICAg
ICAgICB8IDEzNiArKysrKysNCj4gPiAgIGRvY3Mvc3BlY3MvaW5kZXgucnN0ICAgICAgICAgICAg
ICAgICAgICB8ICAgMSArDQo+ID4gICBody9hcm0vYXNwZWVkLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMjEgKy0NCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jICAgICAgICAgICAg
ICAgICB8IDI5MSArKysrKysrKystLS0NCj4gPiAgIGh3L2ludGMvYXNwZWVkX2ludGMuYyAgICAg
ICAgICAgICAgICAgICB8IDU5Mw0KPiArKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAgIGh3
L2ludGMvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICAgICB8ICAyNSArLQ0KPiA+ICAgaHcv
bWlzYy9hc3BlZWRfaGFjZS5jICAgICAgICAgICAgICAgICAgIHwgIDQ0ICstDQo+ID4gICBody9t
aXNjL2FzcGVlZF9zY3UuYyAgICAgICAgICAgICAgICAgICAgfCAgIDUgKy0NCj4gPiAgIGluY2x1
ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCAgICAgICAgICAgICB8ICAgMyArLQ0KPiA+ICAgaW5jbHVk
ZS9ody9pbnRjL2FzcGVlZF9pbnRjLmggICAgICAgICAgIHwgIDMyICstDQo+ID4gICBpbmNsdWRl
L2h3L21pc2MvYXNwZWVkX2hhY2UuaCAgICAgICAgICAgfCAgIDEgKw0KPiA+ICAgaW5jbHVkZS9o
dy9taXNjL2FzcGVlZF9zY3UuaCAgICAgICAgICAgIHwgICAyICsNCj4gPiAgIHRlc3RzL2Z1bmN0
aW9uYWwvdGVzdF9hYXJjaDY0X2FzcGVlZC5weSB8ICA0NyArLQ0KPiA+ICAgMTMgZmlsZXMgY2hh
bmdlZCwgOTYzIGluc2VydGlvbnMoKyksIDIzOCBkZWxldGlvbnMoLSkNCj4gPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkb2NzL3NwZWNzL2FzcGVlZC1pbnRjLnJzdA0KPiA+DQo+IA0KPiBQYXRjaCAx
LTkgYW5kIHRoZSBoYWNlIGNoYW5nZXMgY291bGQgYmUgbWVyZ2VkIHF1aWNrbHkuDQo+IA0KPiAN
Cj4gSSBuZWVkICBzb21lIGhlbHAgb24gcGF0Y2ggMTAsMTIsMTYsMTcuDQo+IA0KPiBBbmRyZXcs
DQo+IA0KPiBXb3VsZCB5b3UgaGF2ZSB0aW1lIHBsZWFzZSA/DQo+IA0KPiBUaGFua3MsDQo+IA0K
PiBDLg0KDQo=


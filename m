Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3E3CF9C71
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 02:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stIC6-0007iq-NU; Tue, 24 Sep 2024 22:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1stIC5-0007bX-C7; Tue, 24 Sep 2024 22:55:57 -0400
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1stIC3-0003no-GM; Tue, 24 Sep 2024 22:55:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoO/UKoUeIxZrRkZkJjQZS8CvHtW2ttiTwkxHTknwPdVw63kJm11GjZvTaaoQnbcmuCo1L7YKjiqGJVsrGYCsjuM1F0Mr+peT4Lf/2zgQAWdqSskKmqME5NqdFsfc4I+7+HQ946Dl2Uapa6u6h68v0bFId6oHHnD/zh19tV1Hmc+udOEu46V/pkG1t8GqPzFBeHVJA9g3+RKSFU4B4n7VHNXawJS/GiO4sTPq1zUfGMhvhGmxxphmoZgB6kNL4avQ6Az1HiV6ZSqWdis2KQGQewHgFputUdAo3NXWE3dvdsSZYIvOyWdE0TTuuJtGYQfOBLepUU4Glbxhp5JVb5itg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxTN+HLFC8tn+Uyif7ZUGaZiPhnLKG8swV4zH+xRsm8=;
 b=I7pybR1By/4iGLBWZdiYXCVq5UJNd2cOVjHgahtwzTZhI3hHWdCh55QB05Rhom4ZJYiuBUbJyqLx81uCNAEmeVhVRmYYWwddmnGLdXAWm6t3j+K+7qYiPSVovt0EJDdgXW6MpSBlkiokqlADwL+RrLBiZbB3Na58YAJmFQnCNUevCLAeg3tp2zgiFBaUcvQl6ZiIRgqSghI3857bQdWsTEaz2UVV+2wJ2uxtbwqyeuZQRq2FT5uj+8AuRzlBXCFTyKyJlUBSZreT8JG8V+yutUkc2hclW9VbqE094K9NIWQkgrjCGJRhmyXC4isUZYSsJ9tT39zzqad5rDCh7BYEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxTN+HLFC8tn+Uyif7ZUGaZiPhnLKG8swV4zH+xRsm8=;
 b=i9UtCk615cNKXHaAETR35ZLqGp7IjdyMLB2GuSoDyy++a9IiCXlNk7GwckA2IcrW0qjjDBpdPfFecPTZP3bZKg1uc3+WdLvjMw7512ZdKjyFp6wxWIJD9GEbZug6SONqYn05zpSU2XtaT00bEOodDsBVhWKSioldflpqTLlPryDMT2dq69hPu9HboqtrupQmrJUIhkb0q9CcVrgHwMr+Fd6v9c3Z+Amxx4mPQCBaQu+iNYdNFDSaPbLgT/PM9pg44uaKmchkPGHeGrkaf/eY4/20yiCvI9sCR4dr+gx8gxDCA17UC9BN/fC4XGFxT1RxH3u6O8t4M3NuZcDk1OeM3g==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6725.apcprd06.prod.outlook.com (2603:1096:400:45a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Wed, 25 Sep 2024 02:55:46 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 02:55:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH 4/5] hw/gpio/aspeed: Add AST2700 support
Thread-Topic: [PATCH 4/5] hw/gpio/aspeed: Add AST2700 support
Thread-Index: AQHbDZzixYX779jCY06UyzfEbXKCm7JmIjCAgAAanMCAAWKRAIAAMf5g
Date: Wed, 25 Sep 2024 02:55:46 +0000
Message-ID: <SI2PR06MB5041B25BA29259D3E414D45DFC692@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240923094206.1455783-1-jamin_lin@aspeedtech.com>
 <20240923094206.1455783-5-jamin_lin@aspeedtech.com>
 <e5d149765b338d4754054691cb83eacdf3e2642f.camel@codeconstruct.com.au>
 <SI2PR06MB50413C10FCB429361E467246FC682@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <8571cf04692ded193b2d82d9592faabacc561f01.camel@codeconstruct.com.au>
In-Reply-To: <8571cf04692ded193b2d82d9592faabacc561f01.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6725:EE_
x-ms-office365-filtering-correlation-id: bb9e7486-5f54-4ff1-32a4-08dcdd0d8dfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFJkTWhibFZha3hTcW4zL094T3phWWh0N1J6UTFYQkRZaVkyMXB0YjRzVGxD?=
 =?utf-8?B?Nm1qdnRUWjFJaE45eUtCcVBkT3BqSG05cnpqaEhEYWM5Q003Ni9LSE5Ma1FR?=
 =?utf-8?B?dmJQdDdvSUxNOEVDTnZGRVdTTXc0Uk5rc1V1Zlk0ZTB4d3Y4YjdHMjBCYVh2?=
 =?utf-8?B?Vk1xVEhORTI3ZEF4dVZrakg1anJ4ekJXWXVJNFpWWXZGOWlQbldmMmFOS3ZF?=
 =?utf-8?B?SWN5QWJvcHlZYUdrb1IydndieFNWOUV4YlJFTk1DQjZqcjBrZHpCYlpPbHZ1?=
 =?utf-8?B?S1Btd1ozWG5NcHJhWXB2TjFrd21PbkZEWVQ0c1VDN290dWErNXlFOWJLVmw5?=
 =?utf-8?B?SERCaW02Z3UwS1NPang3MDdXSmlOQ2JWQnFObndCb2hLblViK0Q5SHR6UmpK?=
 =?utf-8?B?QkJRekl5SlVxZEF3akVLd0N0ZW8rQUJaY1Uwb0xEVTg4enJtNnI2TytTeFJN?=
 =?utf-8?B?SzBWNk9ubUlYWkZPZ0ovaU5QaGZwOXpFU3Uzdy9seGp3bG1hZWVTOGQrSWx4?=
 =?utf-8?B?Q3lENDZwQUd5SmNXamNnM0tldzYzU0l4bUxnMmRhYjkzQzhhTTd3cWJUaDlH?=
 =?utf-8?B?S21OZW4rK0ROR1E0ZitCZjdhZHMydFl3YWNMQ1hFcGQvUVpndVh2S1laanVr?=
 =?utf-8?B?bmVpWGh0ckxTc1d5YVV5SklyaldqMVFUZGtVYW1PTHpFelhFOTk0RWd0RDRa?=
 =?utf-8?B?OGhUK3pjRFJUWC83dEo5RzFQalRrTk5ZdFdWS05rZmtTM1BON0x0YTNFWkVC?=
 =?utf-8?B?Ny9LZE1XMUFhMmVTbUQwWm1xSEN2dlR6TWNKMmR1OG95WmY2aE5MUXFRWHla?=
 =?utf-8?B?WU1PdHpoTnJpUGRXeE5DZm9kNWhUS2M2d0ZWUGtaR0VCM1Z0SEZaUExlTUN4?=
 =?utf-8?B?R2libFJQeTZ5cGtOOCtkWjJPZHAvT0c3R1pTcGFhTSsvbTAxYittaHk5OXRu?=
 =?utf-8?B?RUZFeUFLbWlQREFRR216clJONjFObFB0cFcxbTlhS09GQWxSNFQ1a1BGYWxm?=
 =?utf-8?B?cStSUmRsUUpaMllSTmZUTVhFcUUvU3pEN3Z3VHIweDVhOHFSdDZPZ0UwZHJI?=
 =?utf-8?B?U3pQQjRmV1htNjRCSjZOSWczL0ZHL1lYRHR1NUM1L05QZ3FwS0pFN0tsaVM2?=
 =?utf-8?B?aUQxbFg3eEs1QjV5RkZsdlZnL0FjUC9CWC9RZkZzNis2WTZjVjNya1hlMjQv?=
 =?utf-8?B?VE01KzYyYUorWGhKMVNlTFgxcEtyQkw3bzdpTCtDbC8zWGR1R2t0bG1hNHVM?=
 =?utf-8?B?cTFEQ1I2S3dhdkMyTTdxKzhXMWZSTVVFOGJYK0dlcXlqUXovaUswaXF1UFVx?=
 =?utf-8?B?REFIVjJXcjNXTEFSR2kvSWRMWEpQeDNqUHZWUjQ0M3Q1WGVsNDRQMmpTbHlP?=
 =?utf-8?B?VElmL1lvR2tJN3oxYnJxdGVtMFI2K21YZ0VuSzcvSmcvK0VMWlpyWk1vQ0dG?=
 =?utf-8?B?KzJQaUswNEE2cGhJanZsRUJqS0JQTFIzRVh1SjBCZnJHbm9rZjY4dTJKNXJ3?=
 =?utf-8?B?WUtqaEszR3FJYmhFOGNNcHpOSFVlTEh1enM1UG1uU2ZxYVFwOC9QTm5YZUhu?=
 =?utf-8?B?T0x5RG9aMWl1bUZMcTFkR0JnOUpsNVpiV3ZHWHhQMmdxVDd0UVVPRUZENUtY?=
 =?utf-8?B?V0QzVm9uVEtuR3E4bUpTQjFEaDZ0Y3pMUU9odnA0VUl2Z2VoMFcxVGVuMHFY?=
 =?utf-8?B?cGhxc092dFhqc0RtazJ0M3MyMTJ5cGpxWTRhUmhWUFRWb2Y4NTV6VTEzTjEr?=
 =?utf-8?B?bCtSZktWSzBSVlNlazRpWW5DZFR0ZlIxOWNrOHE1d2xvbVVySWhYVE0yem9C?=
 =?utf-8?B?cURtQmVYSEEwWTRFaWs1QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGlUMjR0dENUb1g0NDNJOHdVOTIrMW1pdTFmTVdCNkJSKzN4WExsVTQyRXQz?=
 =?utf-8?B?R2NZZG5uSmJZN293dnNDeW9nTnVIQVZPbXJNRWRXaWtkSmFPSHo1UWtWd0pa?=
 =?utf-8?B?UEE3Z29CMTFGWUw1LzJ1ak9aVksvSGtCdHhZREJpOEQ1N1FZU1pDOXdSNnVS?=
 =?utf-8?B?M0hucHIyVk5Yc3NNbkljNnZURUE3RUFDTFNnKy8wMmVBdHFJWlJFaVhLOXZn?=
 =?utf-8?B?eFRQOURzMzZtYmh6bmlkYytNejdzdEhpN3BkOHdwV29iemJWZURCUDFqVE5U?=
 =?utf-8?B?U25nYVl5NS9welNrd2VKTGRrNVJqc0xuZkRWZkZPTVo0YldjbS9UeVI5azZD?=
 =?utf-8?B?RHNRTnRxYVBmSTBYcDZuNUt6d2hZRkliVkYvdmlLTUFxcmVQSEROSjdEZ3Bk?=
 =?utf-8?B?cVZtMWpQck9iOS95SXJGaWJleGtCTmRHeFJzdVR4emI2bnJrOUZnQ3lwWkhC?=
 =?utf-8?B?NStjYlU4b04vM0JzV3A5M0t5US9jV1hjTEVMaG5JUERVRjluSHZ0Z3g0NCt3?=
 =?utf-8?B?L3d3YUlGV3F6NHZ2ZHdtTFRBbS8wUmdyRytPM2IzOWJlRjRCUHFGSFVkL1g4?=
 =?utf-8?B?L205a093NFJrMkgyeHEyYi84T25zUjN4empUOXk0WW14eTRIaThpNjlpQlJS?=
 =?utf-8?B?QnRDZ1duSXM4bmhSTm5KZ0QxRGh2eUphSkV1NXdFQlBHZFlESmJTSElReEkz?=
 =?utf-8?B?N0hwZk9rVVZVL3JlSndjK3B5ZjVWcU82ZVNNUHZsRmxDdWp5Sm1iVTh4R1M3?=
 =?utf-8?B?OHAvd0laS3d4aHVaUjFPay91Tlpaa0tpQ1pNY2FJN2RZUWJPR0plcnc3UVlJ?=
 =?utf-8?B?T1lEb25rYTRaVjdvWjNlTitCajlpUEdjbytQMVBIOHkwbkoyWmhvU1dCM0FE?=
 =?utf-8?B?ZU5DNUlQUGFXOFJvVHE1MnE5Q0RreWd2Um5xejJPSWFUa214UlRNajZMTzlu?=
 =?utf-8?B?UFFoTzk0Uno3azlMWkJqWTJhTExjWmxwVGwrc1VUZTQ3TVY5R0pOR3pVeWZW?=
 =?utf-8?B?Y2xENEh4OS9qRmxOcEg0TWZyTlNtV1pzU0Q2NGU0c1V0MFVYMmp2Z3hCS0p5?=
 =?utf-8?B?allNQTNZTm5vaSttS3BURFVNN0dYTGdYdzJNSUJkSTM3U2J4U2o2Yml5eHBY?=
 =?utf-8?B?L3BsRnppZjB6bS9zcWNIN0NrOUpjQjVEdmxOT3Q2cHprQnkzWmhPOGl3M1pm?=
 =?utf-8?B?TGJqMEpaV0Q5clF3eFM1UXJRamFnUkVpYjZzYmJ0NjEzWnpGWTNNWGN5WDNJ?=
 =?utf-8?B?UGNiaEY4dmQvVmJaM24wZmpadzZRdkRlS0pmOVZveWJEN09QblcwTGZDVThB?=
 =?utf-8?B?U2ZPbTVkb3NWcnBWcEsvbCsxNHpNcVIrSlRWVjhyYXpBZzdEbG16bWJ5WVlw?=
 =?utf-8?B?QTU4NVJrMjJBVDBJZkRwWThlMXpUNW9nNmtxVXIrdVdzVWI3OHNyNS9wcFhB?=
 =?utf-8?B?Mnh2SkF5Y0FEeWtnbThhMzU0NWQ3OGYrNkdDa3JBN1Rhd3dGYWptRlFwRkNz?=
 =?utf-8?B?SXhqWXVXRzJpZWdmQVoxVjVBV3pkYzZkS25RR0RaMUpVaW1OSDJRZ2s3VlEy?=
 =?utf-8?B?TWR6MkEyNkgyeXFnMEFBVEdMZDJoSThFb1hreUxpcVlVZDhwVjJpcjFYeEdT?=
 =?utf-8?B?ZEthb0VvMVNjS0V1dCtMT1dYeDNsNmt0ZjZEc2hjK0FGRFB2bm5yUG9GaWcy?=
 =?utf-8?B?Ti8rWHd0WnNrblBKVUJjMUpScERuTGVUMFh4RDZnOEU4N2Z1ZDN0M01zNlFU?=
 =?utf-8?B?TWZmQVYydGsvSzd3N2xPTldsSmdmNm9ZMTdXQi85NGxEd2NQbU9Tanl4WTZy?=
 =?utf-8?B?dTIwTy9ibTdncXhpRW1ldkNMb0k5VjM5WThxWFVUWFZ6ZXpNVWVhU3ZESXNG?=
 =?utf-8?B?VWVCd00xRk9pSlV0MC9STjVBUkdBRGdKTUhUeEdIQVdQWHRMNEdMdDk0Q3Y5?=
 =?utf-8?B?YnVmMU5PUTI5eVlXOXQrM2ZURVVselNNZ2IvaDF6K0NUOWo2RFY4TTFoeWtD?=
 =?utf-8?B?UldyWnYvNlB1WXJwdzRUVTE0UitjaGRETXVyT3JHaUxDOFFnYkI0U1hJeGs2?=
 =?utf-8?B?UnhhM3pDN3hMZldWUXhxWXBSVzBYUEdoSk9PcUhERFhvb0wrOFpPeER3WGts?=
 =?utf-8?Q?uoCFsty3q0XxZ1iTY9qCakd60?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9e7486-5f54-4ff1-32a4-08dcdd0d8dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 02:55:46.5632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAseW40R4RLHMCvrSWDmksJllbC8mYZL5/VP1UZ0/aGXtOHE2eI2oXHbmTEeHgzP0KOjYDxOJwr1d4f1glwhxv+dB44WJTn0tyEcZte+q/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6725
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGkgQW5kcmV3LCANCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gaHcvZ3Bpby9hc3BlZWQ6
IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgMjAyNC0wOS0yNCBhdCAwMzowMyAr
MDAwMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIEFuZHJldywNCj4gPg0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCA0LzVdIGh3L2dwaW8vYXNwZWVkOiBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+
ID4gPg0KPiA+ID4gSGkgSmFtaW4sDQo+ID4gPg0KPiA+ID4gT24gTW9uLCAyMDI0LTA5LTIzIGF0
IDE3OjQyICswODAwLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+
ICsgICAgLyogaW50ZXJydXB0IHN0YXR1cyAqLw0KPiA+ID4gPiArICAgIGdyb3VwX3ZhbHVlID0g
c2V0LT5pbnRfc3RhdHVzOw0KPiA+ID4gPiArICAgIGdyb3VwX3ZhbHVlID0gZGVwb3NpdDMyKGdy
b3VwX3ZhbHVlLCBwaW5faWR4LCAxLA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFNIQVJFRF9GSUVMRF9FWDMyKGRhdGEsDQo+ID4gPiA+ICsgR1BJT19DT05UUk9MX0lOVF9T
VEFUVVMpKTsNCj4gPiA+DQo+ID4gPiBUaGlzIG1ha2VzIG1lIGEgYml0IHdhcnkuDQo+ID4gPg0K
PiA+ID4gVGhlIGludGVycnVwdCBzdGF0dXMgZmllbGQgaXMgVzFDLCB3aGVyZSBhIHNldCBiaXQg
b24gcmVhZCBpbmRpY2F0ZXMNCj4gPiA+IGFuIGludGVycnVwdCBpcyBwZW5kaW5nLiBJZiB0aGUg
Yml0IGV4dHJhY3RlZCBmcm9tIGRhdGEgaXMgc2V0IGl0DQo+ID4gPiBzaG91bGQgY2xlYXIgdGhl
IGNvcnJlc3BvbmRpbmcgYml0IGluIGdyb3VwX3ZhbHVlLiBIb3dldmVyLCBpZiB0aGUNCj4gPiA+
IGV4dHJhY3RlZCBiaXQgaXMgY2xlYXIgdGhlbiB0aGUgdmFsdWUgb2YgdGhlIGNvcnJlc3BvbmRp
bmcgYml0IGluIGdyb3VwX3ZhbHVlDQo+IHNob3VsZCBiZSB1bmNoYW5nZWQuDQo+ID4gPg0KPiA+
ID4gU0hBUkVEX0ZJRUxEX0VYMzIoKSBleHRyYWN0cyB0aGUgaW50ZXJydXB0IHN0YXR1cyBiaXQg
ZnJvbSB0aGUgd3JpdGUNCj4gKGRhdGEpLg0KPiA+ID4gZ3JvdXBfdmFsdWUgaXMgc2V0IHRvIHRo
ZSBzZXQncyBpbnRlcnJ1cHQgc3RhdHVzLCB3aGljaCBtZWFucyB0aGF0DQo+ID4gPiBmb3IgYW55
IHBpbiB3aXRoIGFuIGludGVycnVwdCBwZW5kaW5nLCB0aGUgY29ycmVzcG9uZGluZyBiaXQgaXMg
c2V0Lg0KPiA+ID4gVGhlIGRlcG9zaXQzMigpIGNhbGwgdXBkYXRlcyB0aGUgYml0IGF0IHBpbl9p
ZHggaW4gdGhlIGdyb3VwLCB1c2luZw0KPiA+ID4gdGhlIHZhbHVlIGV4dHJhY3RlZCBmcm9tIHRo
ZSB3cml0ZSAoZGF0YSkuDQo+ID4gPg0KPiA+ID4gSG93ZXZlciwgdGhlIHJlc3VsdCBpcyB0aGF0
IGlmIHRoZSBpbnRlcnJ1cHQgd2FzIHBlbmRpbmcgYW5kIHRoZQ0KPiA+ID4gd3JpdGUgd2FzIGFj
a25vd2xlZGdpbmcgaXQsIHRoZW4gdGhlIHVwZGF0ZSBoYXMgbm8gZWZmZWN0Lg0KPiA+ID4gQWx0
ZXJuYXRpdmVseSwgaWYgdGhlIGludGVycnVwdCB3YXMgcGVuZGluZyBidXQgdGhlIHdyaXRlIHdh
cw0KPiA+ID4gYWNrbm93bGVkZ2luZyBpdCwgdGhlbiB0aGUgdXBkYXRlIHdpbGwgbWFyayB0aGUg
aW50ZXJydXB0IGFzDQo+ID4gPiBwZW5kaW5nLiBPciwgaWYgdGhlIGludGVycnVwdCB3YXMgcGVu
ZGluZyBidXQgdGhlIHdyaXRlIHdhcyBfbm90Xw0KPiA+ID4gYWNrbm93bGVkZ2luZyBpdCwgdGhl
biB0aGUgaW50ZXJydXB0IHdpbGwgX25vIGxvbmdlcl8gYmUgbWFya2VkIHBlbmRpbmcuIElmDQo+
IHRoaXMgaXMgaW50ZW50aW9uYWwgaXQgZmVlbHMgYSBiaXQgaGFyZCB0byBmb2xsb3cuDQo+ID4g
Pg0KPiA+ID4gPiArICAgIGNsZWFyZWQgPSBjdHBvcDMyKGdyb3VwX3ZhbHVlICYgc2V0LT5pbnRf
c3RhdHVzKTsNCj4gPiA+DQo+ID4gPiBDYW4gdGhpcyByYXRoZXIgYmUgZXhwcmVzc2VkIGFzDQo+
ID4gPg0KPiA+ID4gYGBgDQo+ID4gPiBjbGVhcmVkID0gU0hBUkVEX0ZJRUxEX0VYMzIoZGF0YSwg
R1BJT19DT05UUk9MX0lOVF9TVEFUVVMpOyBgYGANCj4gPiA+DQo+ID4gPiA+ICsgICAgaWYgKHMt
PnBlbmRpbmcgJiYgY2xlYXJlZCkgew0KPiA+ID4gPiArICAgICAgICBhc3NlcnQocy0+cGVuZGlu
ZyA+PSBjbGVhcmVkKTsNCj4gPiA+ID4gKyAgICAgICAgcy0+cGVuZGluZyAtPSBjbGVhcmVkOw0K
PiA+ID4NCj4gPiA+IFdlJ3JlIG9ubHkgZXZlciBnb2luZyB0byBiZSBzdWJ0cmFjdGluZyAxLCBh
cyBlYWNoIEdQSU8gaGFzIGl0cyBvd24NCj4gcmVnaXN0ZXIuDQo+ID4gPiBUaGlzIGZlZWxzIG92
ZXJseSBhYnN0cmFjdC4NCj4gPiA+DQo+ID4gPiA+ICsgICAgfQ0KPiA+ID4gPiArICAgIHNldC0+
aW50X3N0YXR1cyAmPSB+Z3JvdXBfdmFsdWU7DQo+ID4gPg0KPiA+ID4gVGhpcyBmZWVscyBsaWtl
IGl0IG1pc2JlaGF2ZXMgaW4gdGhlIGZhY2Ugb2YgbXVsdGlwbGUgcGVuZGluZyBpbnRlcnJ1cHRz
Lg0KPiA+ID4NCj4gPiA+IEZvciBleGFtcGxlLCBzYXkgd2UgaGF2ZSBhbiBpbnRlcnJ1cHQgcGVu
ZGluZyBmb3IgR1BJT0EwLCB3aGVyZSB0aGUNCj4gPiA+IGZvbGxvd2luZyBzdGF0ZW1lbnRzIGFy
ZSB0cnVlOg0KPiA+ID4NCj4gPiA+ICAgIHNldC0+aW50X3N0YXR1cyA9PSAwYjAxDQo+ID4gPiAg
ICBzLT5wZW5kaW5nID09IDENCj4gPiA+DQo+ID4gPiBCZWZvcmUgaXQgaXMgYWNrbm93bGVkZ2Vk
LCBhbiBpbnRlcnJ1cHQgYmVjb21lcyBwZW5kaW5nIGZvciBHUElPQTE6DQo+ID4gPg0KPiA+ID4g
ICAgc2V0LT5pbnRfc3RhdHVzID09IDBiMTENCj4gPiA+ICAgIHMtPnBlbmRpbmcgPT0gMg0KPiA+
ID4NCj4gPiA+IEEgd3JpdGUgaXMgaXNzdWVkIHRvIGFja25vd2xlZGdlIHRoZSBpbnRlcnJ1cHQg
Zm9yIEdQSU9BMC4gVGhpcw0KPiA+ID4gY2F1c2VzIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2U6DQo+
ID4gPg0KPiA+ID4gICAgZ3JvdXBfdmFsdWUgPT0gMGIxMQ0KPiA+ID4gICAgY2xlYXJlZCA9PSAy
DQo+ID4gPiAgICBzLT5wZW5kaW5nID0gMA0KPiA+ID4gICAgc2V0LT5pbnRfc3RhdHVzID09IDBi
MDANCj4gPiA+DQo+ID4gPiBJdCBzZWVtcyB0aGUgcGVuZGluZyBpbnRlcnJ1cHQgZm9yIEdQSU9B
MSBpcyBsb3N0Pw0KPiA+ID4NCj4gPiBUaGFua3MgZm9yIHJldmlldyBhbmQgaW5wdXQuDQo+ID4g
SSBzaG91bGQgY2hlY2sgImludF9zdGF0dXMiIGJpdCBvZiB3cml0ZSBkYXRhIGluIHdyaXRlIGNh
bGxiYWNrIGZ1bmN0aW9uLiBJZiAxDQo+IGNsZWFyIHN0YXR1cyBmbGFnKGdyb3VwIHZhbHVlKSwg
ZWxzZSBzaG91bGQgbm90IGNoYW5nZSBncm91cCB2YWx1ZS4NCj4gPiBJIGFtIGNoZWNraW5nIGFu
ZCB0ZXN0aW5nIHRoaXMgaXNzdWUgYW5kIHdpbGwgdXBkYXRlIHRvIHlvdSBvciBkaXJlY3RseSBy
ZXNlbmQNCj4gdGhlIG5ldyBwYXRjaCBzZXJpZXMuDQo+IA0KPiBIYXBweSB0byB0YWtlIGEgbG9v
ayBpbiBhIHYyIG9mIHRoZSBzZXJpZXMgOikNCj4gDQo+ID4gPiA+ICsNCj4gPiA+ID4gIC8qKioq
KioqKioqKioqKioqKiogU2V0dXAgZnVuY3Rpb25zICoqKioqKioqKioqKioqKioqKi8NCj4gPiA+
DQo+ID4gPiBCaXQgb2YgYSBuaXRwaWNrLCBidXQgSSdtIG5vdCBwZXJzb25hbGx5IGEgZmFuIG9m
IGJhbm5lciBjb21tZW50cyBsaWtlIHRoaXMuDQo+ID4gPg0KPiA+IERpZCB5b3UgbWVhbiBjaGFu
Z2UgYXMgZm9sbG93aW5nPw0KPiA+DQo+ID4gQS4NCj4gPg0KPiA+IC8qKioqKioqKioqKiogU2V0
dXAgZnVuY3Rpb25zICoqKioqKioqKioqKioqKioqLw0KPiA+DQo+ID4gMS4gLyogU2V0dXAgZnVu
Y3Rpb25zICovDQo+ID4gMi4gLyoNCj4gPiAgICAqIFNldHVwIGZ1bmN0aW9ucw0KPiA+ICAgICov
DQo+IA0KPiBFaXRoZXIgaXMgZmluZSwgYnV0IEkgcHJlZmVyIDEuDQo+IA0KVGhhbmtzIGZvciBz
dWdnZXN0aW9uLg0KV2lsbCB1cGRhdGUgaXQgaW4gVjINCg0KVGhhbmtzLUphbWluDQoNCj4gQ2hl
ZXJzLA0KPiANCj4gQW5kcmV3DQoNCg==


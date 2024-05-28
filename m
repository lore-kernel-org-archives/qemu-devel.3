Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E4CC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 09:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBtXu-00087Q-AJ; Tue, 28 May 2024 05:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBtXp-00086M-7X; Tue, 28 May 2024 05:55:01 -0400
Received: from mail-sgaapc01on2071d.outbound.protection.outlook.com
 ([2a01:111:f400:feab::71d]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBtXn-0001Ft-81; Tue, 28 May 2024 05:55:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdaW9/hKv1L/vGTbBGlTSXgrfppLJhA5BbWzWq8wGhoGXNF9Xve3lRPwBKhQ29PqIADKtfUBJj+A/YqKQYJMm7kNtpw1v5d3fmrtTaYAAvgRAsdWrz+eNhgzmz2BcbUQcOyqJAr8oLEA9/w8K1k5scjg4sJtpB1UhpgeAMKLF8z2Do/z/tZD2p7aqIm0LoDex9yt6y6bceR0HB3r+5MP+YHihzPWzRC5wUBpgIT6CSr491a5xc3Wl4EWZ7x/5WggOj/0cl88YSd22jGHHt76QIFHnk1wzxlsAuu7BDPasB9MyUfLsBLFaSjKBfSK9U2J4BQSCy+PLiWLhAPoq6F3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbNZKNFzMv12UzV0Ynusi1HFFv8SrSe5+XYSnZN4Ny4=;
 b=GTVWJSDGA3WaSWSjDOtzcsW/VYZSF6bg0as2H6jeHEu26eYwSOP+yuh4P+MU2YV2XFGsswJLZnNyoG48fjWKt4WSpPDKIXS8S1o8XVYJ2Wpq3dLNfBP49sgn2ATQvL/MBp+OP7Mk3TPovht410XZvFxXI+FPZbbKdBoC7DJu3LyDqGzmR5d1d+aGH4wWDIbEWmc/qrq3VGQu3/BatRkWKU6dbhgnS2dC6BOVaE+JHHefTPc7aRQEe0GGmcheqMnhrrJnjyE4PyuZSOwuY2Hia5vOHlZ003iEXFE+FOcCeKrUYYFb5jn7+ftqLA2KjKY5ePEwgUahjesOvdIIVhnoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbNZKNFzMv12UzV0Ynusi1HFFv8SrSe5+XYSnZN4Ny4=;
 b=qfDTFpWZAqyrcYrwovYDqhJ29u3q3q5VFVRPYM42TtgM/uoIwYjkEmTVGnz+kmOhIja6uF8UtQNyqXQZB9YSZ8Pcfq+7CGKr8P6NQ4vxVsqzWdNMxEix9ShPlcXr42K6ZH5Xd0NnmKMAHU5noHtPIz31GZvRIZi6x04CAMfR391uNGfm7dQcL9tr/KUwaJdnA4+5gVjrHyzlXSUrR/aAwAIVQMKbf4AhwvKl/tzFNcdLxDwdmm5cY8ye1U0bCNpB+2V3ELzCcEtEpoN3FHYz41/YE3EGVrs6QbI8foF5KZDGqG+uOVEVxyIxwgFc6O+BYRyeyYlmHx6AWGCyzQiA6Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5331.apcprd06.prod.outlook.com (2603:1096:400:214::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Tue, 28 May 2024 09:54:48 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 09:54:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v4 05/16] aspeed/sdmc: Add AST2700 support
Thread-Topic: [PATCH v4 05/16] aspeed/sdmc: Add AST2700 support
Thread-Index: AQHasAxBoT342ZIDJkuMa+uwhNwqLrGq4AwAgAAPGoCAABcLgIAA1T4AgABWlQCAADQcoIAAA0OAgAAAZTA=
Date: Tue, 28 May 2024 09:54:47 +0000
Message-ID: <SI2PR06MB504104507C01CB3B723DBBC9FCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <20240527080231.1576609-6-jamin_lin@aspeedtech.com>
 <9476cfcc-5a7c-4b76-a684-1361463bd161@linaro.org>
 <b01604af-5fa7-469f-98e9-c23b3a668a2e@kaod.org>
 <933822dc-de0e-4180-90f9-d951aed30aec@linaro.org>
 <SI2PR06MB5041CD54D31762371A757C48FCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <9dfa5ca2-56a9-49c4-a651-044dc952f67b@kaod.org>
 <SI2PR06MB5041A8BD40F5BEC60A4A3A76FCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <1d927a59-8bd5-4407-b3bc-b50bfa0fe93d@kaod.org>
In-Reply-To: <1d927a59-8bd5-4407-b3bc-b50bfa0fe93d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5331:EE_
x-ms-office365-filtering-correlation-id: 1fbec97c-1d63-4c4a-d259-08dc7efc35d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009|921011; 
x-microsoft-antispam-message-info: =?utf-8?B?cVJ3TmRNNUFGbThoYU5xN0g5SzRrNU1uSmlCVFFKRFlhVVN0T2tITFBWOUhj?=
 =?utf-8?B?U29NVGhlYkMwb3FKRldyZW9UcWQ1QmZxMHV5S0l1Zi9ITXNENmYvV3Q3Q3Nq?=
 =?utf-8?B?NWtLRTJRYmJ5UlFMZDRySnZkNjQrVHZVbHVmdXRzWnI2TFZ1OVFhTnovZnc1?=
 =?utf-8?B?TVhkSFdHb0k1TGEzVmI5bmVVTGhRZWRIdTIzNWovUmNrOWdSYzMxZzVpNDB5?=
 =?utf-8?B?d0NDU3haRWMxQ09TeVlnNkJsRTBpSHQzWjIxODZoaThHVzRqRm9aSVdvQVFk?=
 =?utf-8?B?SklUUjJOem5lV1BZenhOV01LVFNrdDFZMDlpVFJIYzhDWXZlWVVOU21Mclhh?=
 =?utf-8?B?OHFmeXNucnExcWtjRVQrWnllRzBLNXNxdW1qSS9IU3d4aGo1MXRDTTZ0Z3lM?=
 =?utf-8?B?blZjQWp6SE4wbXUzaVJPNW53eGkwUnVFRE1aMG0zNFByenRwU3IwSXJqSnVK?=
 =?utf-8?B?VUpIM1pUNkF6cWE2bXByTTQ1Vmc1c1JVSWNsclNjeE1aWk50bzRKbzdtMVNI?=
 =?utf-8?B?dktXUS82YzNFWWpPNm5SWkt1WEJQM2FYVmxGRnduN3pOOGxyaktuQXA4U2tS?=
 =?utf-8?B?RWNHVzNmbmRBMktFeUpYT0V3MGNmVU5uRFBoMUtOTEJOSjlycTErMHJ1WGpX?=
 =?utf-8?B?Zy9WazBEcjc2d2luQ3JHbzFkYUZNTllMNktDTkgrdEpWZENTVHVPMTNkLzVU?=
 =?utf-8?B?NTlObno1dUgrVFY5Y1dYRVJESmFtRXErdDlpSGhaWWw5V2Q1Z0dkYTN3YU5j?=
 =?utf-8?B?TitsTVlucGtZTFBudDJlYmFpQ3dzQUN0RHJPUUJHaytXQ2pXa3dFa2pMMG95?=
 =?utf-8?B?ZkY3U0U3L045RFQrYVBOMVF3SytXTWd3eldIS0dHaXgrQWtyOVZjd0E1RHBs?=
 =?utf-8?B?TmhpQjVsOFYwWWRyODdrWVVCMnFKM3NFZVJmTmVFcnA2T1pDU1JITFZWb25w?=
 =?utf-8?B?STRrbnlEMzV1eEplYUd6N1JCTDBVaW8wMWpUREE1V3NLQ1dBR21CMEo2bEFD?=
 =?utf-8?B?NnlWTlNqRlNFbHoxVmpEUUJqY2xCOFNwWHFIQUVWYVd5UEFzbmQzVkcraitu?=
 =?utf-8?B?ZFI1QW5OdVJyanlYZ0JVNy9JNERPZzNxVlhSS0ZHRGpkazQvZ0plcXhUSGg3?=
 =?utf-8?B?TnRmdDBUZVdpNVZoeWM4cVFBdjRYdGxvZWo0SkNrTEczbmJJdkY0MXpNRXBD?=
 =?utf-8?B?V3pEcTVSd1Z3TG8xL3Q4NnNRS2FlQWFTa04zdjdkMHdNc3FRcWppM0Zldkxl?=
 =?utf-8?B?Y25Gdk9RQ3pyNVFQRnJKWit0eFNTaEE4ZTlUdy9pNmFCOWF2RnZyelBJOFZm?=
 =?utf-8?B?WEFoQnFrMlNNWVNKT254eHhQdDQ4aW9NY3JUK254Q3dLZFIyQmlIOXlRTmJh?=
 =?utf-8?B?WXBBdU5BNjFVb1QwcTVtSWY4Q0wzUDJIVXJ0cDRqUmR5blNPdGcvcVM3SVIr?=
 =?utf-8?B?ZTlQOWJUcFlKUXNaaklNUFVNRldLaklxWjRqSmc5cmtFNnY1ZHUrMDUxajBZ?=
 =?utf-8?B?enRRNkRzTmV5ZmwvdXdSbFBGMGVrOGJqbStZRzFHZXB5M3Z5NFBHaXJYbW1S?=
 =?utf-8?B?UDJvRXBFdEdVTEFTTk45c3k5ak5EYUlrREdFQmp5OFNHRWdhZzdCRHNFUW1p?=
 =?utf-8?B?V1dEeXVtd2lDQ0ZnV1ZZdWRHVnRTTzJCQmlnMHgyeWlObXRiaHBlbzlMUFl3?=
 =?utf-8?B?aVIwR2RzTkFwV1FvOHAwN2ZCL2NPWEJnMGJWNXhJWEdpWEN6MTBPcnlCWmha?=
 =?utf-8?B?bmxwQjZvTTd2dFRhWkM1cjRObVp6cXR4QmNPKzF3YTZrQTlCdU9YaFNKa0Fw?=
 =?utf-8?Q?N1QmKAgnxegdXJtUnpa+w+TveyLdxWH9FzdZw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009)(921011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmtzRlExTVJaTExuVGl6SWxYTnp1OVpEYk1mZHhpSUN2cDJHWEdwTW5sQ2Nm?=
 =?utf-8?B?eG9oWVllWFQ3RFM0TzRxVTB0MVREdlZ2OVFZbE5LV3A3cWFMUG1pRXJGd3pR?=
 =?utf-8?B?dzJXL0gvZHZLQ1JGVDhjSWpERmluWlZyVnNFa1VKNE1LVys4ZzYyYUdwSjMz?=
 =?utf-8?B?OVhyMWdWL2xhSmltK3AyTnpUTzFMbHpNcHRZdGZOUzBnSDJjOW1PdGt1UUUx?=
 =?utf-8?B?eUFJZTFxcXc3U3lyT0NSbnQzTVVJVm1jb1dKVTAvZFFQQzYyVXZnTkJMYVUr?=
 =?utf-8?B?NC95UkpDM2dWNnp4RVhSc2xxdE1Wcnk3RzA1V0Q2SGJtUGxOQ2lncUdtUVJ0?=
 =?utf-8?B?bk5ITlp1UXJMQVo4OXByM3V0ZUY2ZEpWMHBqMUtVOCtDRFFZUU82bjBmMGVK?=
 =?utf-8?B?RE1uakxJQUxwMGhuMWgzZmNyRml5dWZLeVhmVmpvcXB6OFUrMzJac0RvK1hI?=
 =?utf-8?B?VG4vQ29raGNRdDJTYlY5b1pmNmEwS2h0aDlxSG8xUExKbkdNa0kwY1k1a3U1?=
 =?utf-8?B?Q25MYjg3eThuRXNsa1hNWFYwUmEzT3hCaGFZVmt5NHpsMktYaFphRjhjNEpL?=
 =?utf-8?B?TUNhVUxMSkxWZ0xmdzV6Nk5uVkdwMHlvVzVYWFAycUJMTXVpcVp6SEl0ZDNx?=
 =?utf-8?B?RG8yajdTQzUyWE5leWlUY2pYTGNJQ3NyTmt4NWl6K1FIMk9KV0ZOM3JtQWJp?=
 =?utf-8?B?cVRydmtMOEFWR3JsRGxiQ24rVTltNCtZTC9Vd2J3RElNQ1QxYkVEdHJDR1Q4?=
 =?utf-8?B?WEJwbTJuY0VhNnh4ZGJ5anNNN0EwV3dLT1BwNEVsUlM5MHY4MjJSR0xBVUVp?=
 =?utf-8?B?UmFFM0JRV1dNTzBKc2FwYW1ubnFpVk1UYVEyaERlRkwzb2dXenMyZnVoc3FN?=
 =?utf-8?B?N2RSQVQ5V3h2TktLNnVGVDN2S0FUbHpMQkZ5MDZCTWdCSEJPSUNwTmNyZXBU?=
 =?utf-8?B?ZjFxVjF4bVZGd2lqMGhBTzFBR3NWL3k4MytvWnhweFQ5QmdSL05RQXA4cGFi?=
 =?utf-8?B?SUJpVjBOc1AwRDdtMEpvNDByTU9YbmFxZXN3NThibFdvVjVhUmFyNzVlQXU5?=
 =?utf-8?B?SFVZUVdLVUNNdVRmdENTL1c0ZytoN2lSWjBXQ1dJUjhOZVB4bkJCQTFLRXdo?=
 =?utf-8?B?UGlVVlVlaHQ3dWo5ay9OM1l3RTVzQ0hxYXFlTm5kMkdKSDkwYWViOVl4Mnhn?=
 =?utf-8?B?dkQ3WGVXOFprenNJTGRqUU4wYjhJU2JTdW5DK3hpaGp0WmV4MmMwbUR0QVdM?=
 =?utf-8?B?US9DeUh1L2JZMXRHbkNpYUFISFZJZnQwbmtRSG5XN0R2eDFGZ3ZreHRqcmYr?=
 =?utf-8?B?d1RMemlzMDArbk1QaFFZVXg1WDVyanRDbWprMitOMzBkOGVqWFFyaTVRSFhC?=
 =?utf-8?B?RG1SSHdkVlRuMEFWSGVSSW1udHNza0l2RXhweGRvQkVKTW5GOVFyNnQ0SlB5?=
 =?utf-8?B?Z05YanZXaThkMzF2c2pBd3FDdzBmazNHSEl1aUlaUnRFSzl1Y1RjcDVWRStP?=
 =?utf-8?B?MS9HYnFHeEZqL2tRQk9SQkxMZUlUNUE3cDBVQ2I4UW1BMVZjNVAwQ1B3bG9M?=
 =?utf-8?B?bENCejFGSG5rOE9td3A1SVF2V3BDOVlVZzN1RElTNk9uejhvQWZPdFZPTzJq?=
 =?utf-8?B?Wm9UY3RUN1F5eFhUbE5LVjZZS3oxTXBCK1hxTGx5dThpNUxNb0kzWHB0WlI2?=
 =?utf-8?B?WHdQbXF3Q0E1UlY5eGhlVFJpd29wVEY2TVZxZXFuN2xqVzhmV0RnY1pyWnlH?=
 =?utf-8?B?SER6M1pscjBQQXBuOWxDMTg5cTFrQTM5RDgrYm1XQWh1eklMcndqc3pIVzVx?=
 =?utf-8?B?bE4vQkRDcW44bFF0NUxxN3pNSXovTkIyblBLTXVPb0d2T2p3QVBpQUhHU2Q0?=
 =?utf-8?B?MXN0bGUxMHFJU3FLc01nOE5WVTVlMXFTTGVmR3VsQXpxN25QcENTRllzZG0z?=
 =?utf-8?B?K1Q1dFJUREp2UWw4N2YzNllaQmUrcTNVQ2crZk4vOVZQNitCaXZtaFBIQkVH?=
 =?utf-8?B?cWtiVkZOWnlvNTIxUHhyRHVvbktuRUlFUDcyb0ROUEIyYnBxNXIyOTJnVFE3?=
 =?utf-8?B?cWRwdythNnZQaE5tK0JCU01nZE11L21nZElBem1XOVEzMHdVWVhKNXlERHlC?=
 =?utf-8?Q?R8IevnQ0rxo+Nz6bg3p8uFRRa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbec97c-1d63-4c4a-d259-08dc7efc35d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 09:54:47.9522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1N+EWTk6hIgyliIHbf8LaYpfZReo80P5dJfAaE4FH5bxfnsfksObaWyyntElsGB9oA2O2BJBmEAIZ+CROKIZYOURF6i2JtoVlKgNYZKR8Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5331
Received-SPF: pass client-ip=2a01:111:f400:feab::71d;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBb
IC4uLiBdDQo+IA0KPiA+PiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgbmVjZXNzYXJ5IHRvIGRvIHNv
IG5vdy4gUG9zc2libHksIGluY3JlYXNlIHRoZQ0KPiA+PiB2ZXJzaW9uIG51bWJlciBpbiB0aGUg
dm1zdGF0ZSB3aGVuIHJlc2VuZGluZyBhIHY1Lg0KPiA+Pg0KPiA+IElmIEkgdW5kZXJzdGFuZCB5
b3VyIHJlcXVlc3QsIGRvIHlvdSBtZWFuIHRvIGNoYW5nZSBhcyBmb2xsb3dpbmcgaW4gdGhpcw0K
PiBwYXRjaD8NCj4gPg0KPiA+IHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0
ZV9hc3BlZWRfc2RtYyA9IHsNCj4gPiAgICAgIC5uYW1lID0gImFzcGVlZC5zZG1jIiwNCj4gPiAg
ICAgIC52ZXJzaW9uX2lkID0gMSwgIC0tLT4gQ2hhbmdlIDINCj4gPiAgICAgIC5taW5pbXVtX3Zl
cnNpb25faWQgPSAxLCAtLS0+IENoYW5nZSAyIH07DQo+IA0KPiB5ZXMuDQo+IA0KPiANCj4gPj4g
QWxzbywgYWxsIEFzcGVlZCBtb2RlbHMgc2hvdWxkIGJlIGFkZHJlc3NlZCBhbmQgdGhhdCdzIGJl
eW9uZCB0aGUNCj4gPj4gc2NvcGUgb2YgdGhpcyBzZXJpZXMuDQo+ID4+DQo+ID4NCj4gPiBBbmQg
Y3JlYXRlIGEgbmV3IHBhdGNoIHNlcmllcyB0byB1cGRhdGUgYWxsIHZtc3RhdGUgdmVyc2lvbiBm
b3IgYWxsIEFTUEVFRA0KPiBtb2RlbHM/DQo+IA0KPiBUaGF0IHdvdWxkIGJlIHRvIHJlbW92ZSBt
aWdyYXRpb24gc3VwcG9ydCBmb3IgQXNwZWVkIG1hY2hpbmVzLiBGb3IgbGF0ZXIuDQo+IExldCdz
IGFkZHJlc3MgQVNUMjcwMCBmaXJzdC4NCj4gDQo+IFRoYW5rcywNCj4NCj4gQy4NCldpbGwgZml4
IGl0IGluIHY1Lg0KVGhhbmtzLUphbWluDQo=


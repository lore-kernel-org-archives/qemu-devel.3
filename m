Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE223CCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 05:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stgiw-0003NU-W6; Thu, 26 Sep 2024 01:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1stgis-0003Km-ST; Thu, 26 Sep 2024 01:07:27 -0400
Received: from mail-psaapc01on20702.outbound.protection.outlook.com
 ([2a01:111:f400:feae::702]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1stgip-0004F2-RM; Thu, 26 Sep 2024 01:07:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNs0WUnPr11cZOa1GThqZS01mG0IVMDw9l4Ftr2gHQV4DpozwiE4HpEBVqBLlmWrBOBJu+dHj23s7xaGEoeIl3l3wXPl2Jtzu+CMlP0topFly1WZf1ts/yOLjVBzEONeRn5qEeFnm2aNqgLjSbcaWm8/nB4F/nT5dM04olZOJEVmvIv2DeR/XeyjJy2AZmipPWKgFhhcnRpKTetkdbt6LU5qVY64Fncrk9i9Me3XILxRlD3Je8FctPacmH/63UsmOKzEQ14ZG7JXuI3EwJXe1MH5kf6arE/J3tPTlvjgq28hNKSfvPGWWq/Xxc7iJR4v9H1O1O/JRUAexTZIcQxjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmcEZ9f1SO4Z8LSJnW4vqf/fRhGQQCYJtrOi9xddXq8=;
 b=x/nFX+enUVVJTYavZF6ylitussauU2E8KRwgCJ84tVfMvlr1wC0fi7cDXRLPaH8AZWX5qXCRfUEjUrf31yB0+KScHt78wmv8CXV5ZPo6y/EBDyKY58F7USYSedcndIlSpQmJwM0XMzHn+fuNZl3l99+hm/o2ZCpCzpwmeum0MZeCR9rb5fQq6Q7zLB6OyJlcNzbpJsBVcs+pFS3CzR+r9Wkrepm5gVGUsik9Lj6xZ7NT+TE76e52BfMzxNgeD9wCwEm4ljWGN/wOKCqXYowCSXvqJFtKdmiQsi9DebfNUssX05PdPum3gy5GAZJvaP3wL1LILIhBMKdAAH8eJvK8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmcEZ9f1SO4Z8LSJnW4vqf/fRhGQQCYJtrOi9xddXq8=;
 b=PunRCBbOS1ydksoGIRmyK+Pe+R5/Ny4cfnXO1xCDr+oILFH4KDKnpgtujOOYdxOJlHRCsF59Ub9QNdWHcJOVPwcqnCMj4Wn5YQqnAhfUBahDnk/urIybYiCsxZM760k32WIkVSjyu7leIxSFWPmfabKpZnyqZ9+LwJPGj+JiZa+WOc1RQDvnFNfC/xj10wZZWto6fTR+HFdkkJpIyX7qRAMeVnkNDecSEeammWczRsq1LROAkeL4B/we9VbefwQ+UrUu7mvc2M30j0tNj5TUDW2jUOp8BWEtJn9OIBgy1T8zx/sAPCFgIxg3TN2O+fg/FwUg6H++ebDkiZHkoEFnaQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6834.apcprd06.prod.outlook.com (2603:1096:990:4b::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Thu, 26 Sep 2024 05:06:45 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Thu, 26 Sep 2024
 05:06:45 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 5/6] hw/gpio/aspeed: Add AST2700 support
Thread-Topic: [PATCH v2 5/6] hw/gpio/aspeed: Add AST2700 support
Thread-Index: AQHbDvvp55fpDPfOKUWUOi5YOIJAUrJpdYoAgAAP/7A=
Date: Thu, 26 Sep 2024 05:06:45 +0000
Message-ID: <SI2PR06MB50418EE6690EC5ABA80B00F6FC6A2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240925033454.4117445-1-jamin_lin@aspeedtech.com>
 <20240925033454.4117445-6-jamin_lin@aspeedtech.com>
 <7ee6367997fa5f56d14f653b2ac90863f52f1b2f.camel@codeconstruct.com.au>
In-Reply-To: <7ee6367997fa5f56d14f653b2ac90863f52f1b2f.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6834:EE_
x-ms-office365-filtering-correlation-id: 50e7082c-517a-47ec-8be3-08dcdde904b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGY0NExQYXM3UlREZFF0SmRZN0Nscm55WFVTTnhWcFQ0dW1JTkhmaStHRFRj?=
 =?utf-8?B?a3VReE0rREJVU1JCWTdJQ3h1c2VlYml5L0psRmlFZUIxSU9MYjBjeXIvc0Ji?=
 =?utf-8?B?Q2VEZlhJS3hCQXlzb054SSthQ3pVTXlhWHFUZlVXZ3JTK0UyVWNKTTExYUJo?=
 =?utf-8?B?RCtlaTFiVlBDL3h2VGRqeHNsVGIzQkJKTS9hNGZUMnVxUTNISjJxNjk1QlZJ?=
 =?utf-8?B?b3dvYjJZZndjZE00SHpNdC9rWm5JNUJyZU43bHZEemhhS0VMNmh6ZWFjOWVV?=
 =?utf-8?B?Yzh5TGRMcFFXN25Pc2xFWmFVNlFXd1RPbkZDdTVYWjBHakJ6b21ONmdQQTBy?=
 =?utf-8?B?N2tUdnQrRlFGeWJEREZKc2tZR242S2NqR2VacWRVMHdYamZJNWdnYWhWVkFZ?=
 =?utf-8?B?QTlBZ29heWs3NjhrSmZKWWVLZTJGOTNhU3dQU29CanRTRWtVVnF0aHhYeDlr?=
 =?utf-8?B?OWRLNjVyKzJ3c2c4MlRLLzIvRmNsRnBsaGhwK0hYdUV0R0R3RXVXR0JQSno5?=
 =?utf-8?B?QUxjTUY5emwvMHhMemdOZ1YvZWdJUzlNMjBEdDJxaG9XdVlSUmtmZ1NBY21p?=
 =?utf-8?B?TmhwanlIbzBHREZyNHgwZWNaMnNyZWNXbzFscllEbE9KaWFWSFFXZjM1OS9Q?=
 =?utf-8?B?ZVRuZythTTRkZWppSlgzN01paGVwTnZ1c1BNQ2tVYjZFbEdlVmhrbVhMR3JJ?=
 =?utf-8?B?cHNnSDJOY1FxSjVKUjBvbGRDR09NMmx5b0lNSFVHbGp5ZzA3bUlNY1hXYzVN?=
 =?utf-8?B?LzI4c1U5dkMxQSs4Yk5jUTdTNkdmS1dsSnJoaXVPTUQrUUdUKzA2dXNLYlY5?=
 =?utf-8?B?YldReHRWeFVwcFR6RHR4RW1OREcyK0kwNUh0bHNkdVpLQ0NrZFR1Z2ZkdFZF?=
 =?utf-8?B?WFdqOUs0RlRKR3gvTWlpb0Y0NTMwU0lEVG5tSXFjQXQzUW1zcHMwT1M1MUJu?=
 =?utf-8?B?cTNSMHZFNmRxRHRHSGNReDQzNFFBdlJ1TWF2RkpPenFxbUJBVnU1Q1J5SXRz?=
 =?utf-8?B?anJCVlltMjJxMVFlcklxVENYQis0Q29qbjBybmlzdlN2bjVLQjJYOUxGNGQ3?=
 =?utf-8?B?VGw2WHhOUzN4VHFkaTdwb1ZOZXdqdmZXVjlMYlpZMGkrMXZyTEpCYS93a3R1?=
 =?utf-8?B?cHdqNGhiQi9iYXpPVjRZcUpSOEVFajVsSURRSlBld3NrRElaVFFhbzVTZldo?=
 =?utf-8?B?eWphNDBLZjhhSFhzT3BTN3E5RnRJU1Y0T09lSlNwNU52Unh4WXVoZWR3Tm9Z?=
 =?utf-8?B?aHdNOUlYZHl3M1BQZXFvdmpDWUN4Yi9xNTQrMEt3M243ZHN3dkc0N2oyeVRt?=
 =?utf-8?B?a0laWDh6bSs3V1ZlaktWS1RNMXRyM2FnSDRJRmdLN21sdkZOMlZIbS94b3RX?=
 =?utf-8?B?cFM1SG8zcVQ4OThMSCthK0xPd1BadjZXOG44TnFYbEkzQUw4Z1ArVzNJSGsy?=
 =?utf-8?B?Yy9BdTNSM3lUVVZocVczNWhmejg4czFjQlc0MXNFNDJjVzBERnRsTVp4Q2xk?=
 =?utf-8?B?dnRLa2t0R2FHRXNVNWw1S051Z3dqZ2VoVitSVFVFbG9lOTJET1U4UDE0TkpL?=
 =?utf-8?B?VDRDSzhEbFhpcFRrcmpLR3R0R3lsYjJsanptRXpRQjVKWk82Sm9odVJRNUtC?=
 =?utf-8?B?RHBIZlU5bFF6ejZxS1ExTnU4YzJsaHRFbi80aEM2RDBMeElsaHgvekpxSXhC?=
 =?utf-8?B?U2NCZjRYL3FLL0d5aUduTXR1VFVKZkFUUmJESExUU0NabGk3SGZIZXkwRDV0?=
 =?utf-8?B?SWFHcGhvSklJVlVXMzNYb1d4V1J4ZXFOYlF4NjhZbFl5bGMrMHFhVmQ5b08w?=
 =?utf-8?B?TFA5TmRKU25US3pTV1Y3UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEwzOEJnKzhoeHAzWmJubUNQSU1TdkhFZkw3RFYweHJwK0tTZjNwcVRMZWtp?=
 =?utf-8?B?NTlFNHZMNmNpbGgxUkVuRFhDVFV1VUFxT0tsaktNaEFBbW9ZVnFSenhKalNG?=
 =?utf-8?B?dllZMmwzaUFsa1Y4NW1JTG5ySFMzZWR6Zmo0OVZyNnVtbXJZTC9JYUM5aC8z?=
 =?utf-8?B?VWJOb2VpOWhqRWJNYllGcEJWc2pCVzdmNTl3Mnc2Y1VYNlpoamMwMCt3dVMy?=
 =?utf-8?B?UVRONFpobmNqOXBRcHZlcEFwV1RMNkU0RTRNVDA1TWpXOTZyMEtLazdkZ1Zw?=
 =?utf-8?B?ekN1dUxGWk5laXRtNlNMYzQ1SWNsMWdPbFFBcUZuTTlBaXlnQzdMUzRJeHRn?=
 =?utf-8?B?VUpFMGNVUXltOVQ1cFhuOHZvS1o4L201SXRSZTlwMlhEUVZjaEJnOEQ4Mk5q?=
 =?utf-8?B?R0RybFVWV2JscFlIaUJ4d1FrcFpNbU9KNGp4bHJHeFhTOGFKZnFFRFZtQm93?=
 =?utf-8?B?WWpDQjgvWHVzWmlhY1VTdHlFVTdwNDBUNzA1M2I4VDVaZnZNRXJabmNDSlVW?=
 =?utf-8?B?MEw2cnlJcXhOanRaNEtNNEQvTjZnbzFYczhMUjFBZm9heitXVlRIMlAwSWl6?=
 =?utf-8?B?d1E0RmZXNHZpWkhZc1I5UUVZdXlHYzZEU2Z4Sm1oSXBmNmx4VXZHdnNMU2FG?=
 =?utf-8?B?Y3RCSFZNamNlbE41YTZRRnlQbzAxdUZ0QWxPZ1JNVFVkTkJNbEVEaUtMZko5?=
 =?utf-8?B?TVpCZ0VybHRNZjRyUFJvSTJUd01DdUpaM3pnVitLbWJnN285b081OHVIV0hV?=
 =?utf-8?B?ZTFmVUl4QjNjZ01raCsvbkk2SEZ4czVVazN4OFI0azdZTEdvY0RDM3JsK1JQ?=
 =?utf-8?B?ZnRIemxYRy9ZMmNGbWt3dFpkNzZmcmZJSWNpWGNHS3ZCMklhMTFtVnJ6UFNR?=
 =?utf-8?B?Wmx2RlVQdjFiZHU3d2NYTWhOZ1djb29veSsxclBvYmIzL2ZsbUFJa2FGVkxS?=
 =?utf-8?B?V2g1OG9qMHhZeElCaFpqREdRMHlpYlI0TDdoYjRmVE5XSVpMeGZZWUhKRGJa?=
 =?utf-8?B?N1h5VkdJeE9QbFlSa0oxZ2FTUWttRHN3ZkZ0YnkxSTdnYXM4Z0V5UnRybXpi?=
 =?utf-8?B?M3JPaFRaaDVxcGd3b0tmUnVOTmdscHB0cjlHK0V6QldXbThvdHRFemloVjNT?=
 =?utf-8?B?b3pnUVl5SlJqbnBidFFPREdJdm95T0xYZVo4M1k2c0lmZ2twRm4rTzhRTUdB?=
 =?utf-8?B?RTlMUXdvK2YwTHhheDkrdUp1dUxudjBkWEJBWHNLZ1YzVmRta3ZSVEVTZ0FN?=
 =?utf-8?B?MWVHeHM2WGZ6anBFa0J4bFVLVWU4ODEzMklsUFVWeTN6dXNlNE9PY1FRa1Ex?=
 =?utf-8?B?M0FoU0EycmY2cGtqM0lQdW5kS3RicEhpTlhnUHREUGtaNFpvSWFGaXllb1h1?=
 =?utf-8?B?TEdHUEtMSlJGWWMwOU05YktuSkYvVFUvYnV0emdZZi9LRExHTUNCQzhCZkU4?=
 =?utf-8?B?dmZDRk1XM292bEtpQWVUY2pSRjZBbFFaaklQNG45UWlHQVVXb2ZYanRJdWZu?=
 =?utf-8?B?SDRhMzVObWRJc0Nnd3UwOGVpdE9XbVI3Q3pPNGRmT2p5T2orZEQ5eG1XMmVD?=
 =?utf-8?B?NThMdnV0Q0s4Y1JnRFdGd2JHL1cvMzdBUldvazE1U2hJeEtsaFpBQkRjQnFR?=
 =?utf-8?B?SnRqbjFXUmN0Q0lRbXJWRzVOQm1jdWxoSnI4NVdYZ0g1V0Z3Q3J5NTI2TlNy?=
 =?utf-8?B?aVVpamRSS2xnMTBvVlJxNXpZcUZRU2V6WEtmUmNaS0RBNEU0UThhdW1tV0Ns?=
 =?utf-8?B?MlNsZFVsS0N4TkhreDN6bzFpZVM3VTBTbllPcW8vTkVPL0VWdStNZTZMN0dT?=
 =?utf-8?B?anNxcFpGY2hLeVJOd3VaK2ZMUGxIdzFTNkUrOUVsc0hNcVBEZGpEdDkxOWJn?=
 =?utf-8?B?MFF6bFdrcG8rMXpmNEw0RFpsSDNRUWVWdkVhR2JDNWJ2Y3FUUlJ1YWpDQTcv?=
 =?utf-8?B?U1FHTlg5N3lDUEtTWlNOakoxa2JvUVJnQlRZN3M2WlhqUGk5K3Y1MGdYN3J0?=
 =?utf-8?B?SUpTeUQxSnBZNWpyOVRVR3J3cHc4azR4OTVXREdLUkFaaXBURlk1L3dxWHox?=
 =?utf-8?B?L3k4aGxISHl0L0FBQ3F4bjFQTXl4YmxCazlFcE90Y05qWVBKZVRTZXRyU3Bn?=
 =?utf-8?Q?ELDa9/3O13vFXLWX7puQutlqs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e7082c-517a-47ec-8be3-08dcdde904b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 05:06:45.5356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gj52JLei3oeCITHYwL4QlBT/3JOzJr5OxgOWCdfJ8A1y6A7aDCX9bv3CZ0jW9o23UoRK6ZWaSYZzao1GKjxp4fG1HPC5kHGPXwpxBEgdhII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6834
Received-SPF: pass client-ip=2a01:111:f400:feae::702;
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

SGkgQW5kcmV3LA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNS82XSBody9ncGlvL2FzcGVl
ZDogQWRkIEFTVDI3MDAgc3VwcG9ydA0KPiANCj4gT24gV2VkLCAyMDI0LTA5LTI1IGF0IDExOjM0
ICswODAwLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4NCj4gPiArICAgIC8qIGludGVycnVwdCBzdGF0
dXMgKi8NCj4gPiArICAgIGlmIChTSEFSRURfRklFTERfRVgzMihkYXRhLCBHUElPX0NPTlRST0xf
SU5UX1NUQVRVUykpIHsNCj4gPiArICAgICAgICBwZW5kaW5nID0gZXh0cmFjdDMyKHNldC0+aW50
X3N0YXR1cywgcGluX2lkeCwgMSk7DQo+ID4gKyAgICAgICAgaWYgKHBlbmRpbmcpIHsNCj4gPiAr
ICAgICAgICAgICAgaWYgKHMtPnBlbmRpbmcpIHsNCj4gPiArICAgICAgICAgICAgICAgIGFzc2Vy
dChzLT5wZW5kaW5nID49IHBlbmRpbmcpOw0KPiA+ICsgICAgICAgICAgICAgICAgcy0+cGVuZGlu
ZyAtPSBwZW5kaW5nOw0KPiA+ICsgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgIHNldC0+
aW50X3N0YXR1cyA9IGRlcG9zaXQzMihzZXQtPmludF9zdGF0dXMsIHBpbl9pZHgsIDEsIDApOw0K
PiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0NCj4gDQo+IEkgdGhpbmsgeW91IGNhbiBhcHBseSB0
aGUgc2FtZSByZWFzb25pbmcgaGVyZSBhcyBvbiB0aGUgcHJldmlvdXMgcGF0Y2guDQo+IA0KVGhh
bmtzIGZvciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpJIGFtIGhhcHB5IHRvIHVwZGF0ZSB0aGVt
IGluIFYzLg0KDQpUaGFua3MtSmFtaW4NCj4gQW5kcmV3DQo=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A015FD6CFDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAbA-0007A2-M0; Fri, 23 Jan 2026 01:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vjAai-0006v4-Rn; Fri, 23 Jan 2026 01:24:24 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vjAag-0001EN-5A; Fri, 23 Jan 2026 01:24:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sL53nq6lzNmQvtCPMqLOh/VM8hwDjBKvigBCgQBlixfc5ZrLFRzV9+t0UUl/IcbVmsOaKc7ST3wHwYQUBxHl1WXousBnLXmG+R4kp71z62M2uXqQOWhgT3yu73/qd616Ajv+u1gHHc/tpl0hcgqRX9mi6lU19tnrGUA4/9i9AFgQSU+sVJ03UQFahh9NKPxIlX4iwb7y1fXqT/A1mhd5Zy67vIfX5ddclrP0Y+EHL3oFhqFqgr96r5n4u6GpovtNarmaoXLsFzNhXVvnRXi5ak2JtZmPveyegGpogoVbg6PD/UV1X+G+9RQAOiWE8Zw2L8AgEwkSn3FEPjBROhRmqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qkbg8G5BsPUElU6ktKNSniR3vpRuWiBg1QwO3aMWzQ=;
 b=peaDax6sEUyEgg8KnED9M0vLGMG947dYuKZypg9FOco+4YIdijsWiz/SCrMMp18gLlS0cyDOzAdjOcN+pVk3fR8BsiFmuThNWams2a9IzJD/kUwWJHJ1/KnWT77g/uPcTA6/Anzm4jzYc0qkcuSO/N0+HfdMmFWwCMlzSQd1Lhr4Vxnu3CepMuiFnzi8kf0i5ie6z1PKvi6gUhbMtHk55bFoGaoYw5S8rvsjP2SZmWfs4E97a75CxdtqSjP1vVhWAIKQ3cl+GZ8eso571UeJvc9XvqN8+q4yjfeth74q30d01z4Z+cMOtgOgZBcfD6mC1n9Hq1x9Y337KeOHqje1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qkbg8G5BsPUElU6ktKNSniR3vpRuWiBg1QwO3aMWzQ=;
 b=d5yFP1NsoW2v9CdVJgL6IpVyCEjMXwQ5I/tU5inK/W89rVSgcvXvCvTkVeMVah+H2LXpGuWgV0sIV1oqVetMakGMhJNdH22Sm9IDek+C/iA/No5YjkedbdklCqorhZGRaAo6b2F5LdoCmO2i0eJJEQkLTVmrwFCz0V23SnfeiodejpAtmKeFlr8iYfN7H6d8C2uM5mJ5VKpmzkzu/qCDToC3JRm2aJnXLz7XA4JSFyBUW8eycmS5+J2jTDSwTtj4IgUAO2Bc3hmPkoE8LA72WLRLrAw6DbhFUq/eUr8PhmyiVS4FCc9Uvdw9/lF7lMoIBlYAzq1C4fQBoUd50KclFA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE3PR06MB8045.apcprd06.prod.outlook.com (2603:1096:101:2de::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 23 Jan
 2026 06:24:09 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 06:24:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: RE: [PATCH v5 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Topic: [PATCH v5 00/22] hw/arm/aspeed: AST1700 LTPI support and device
 hookups
Thread-Index: AQHcicxLj69gtQDV7UaGII1il83Fe7VbOqAAgACSMECAA3ulgIAABE0A
Date: Fri, 23 Jan 2026 06:24:08 +0000
Message-ID: <TYPPR06MB8206E096C66EF9C504F79146FC94A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260120051859.1920565-1-kane_chen@aspeedtech.com>
 <1433fb86-bb1b-41f7-b7ec-45560e52146a@kaod.org>
 <SE3PR06MB81997150B11579509E3B31C1FC96A@SE3PR06MB8199.apcprd06.prod.outlook.com>
 <ccf7e1e6-f7fb-483e-b69c-32ab15a9ce0a@kaod.org>
In-Reply-To: <ccf7e1e6-f7fb-483e-b69c-32ab15a9ce0a@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE3PR06MB8045:EE_
x-ms-office365-filtering-correlation-id: 9102e749-c262-46d4-1ba3-08de5a480458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UDhIbWdNZHd5MnZJUlJiUEsrTnJXcDIxR0VWUFdyRTFydTZTak1reFJyMm54?=
 =?utf-8?B?b2F1cnpxVitpZklUWjg4YWNCTXVhOHh5QUlQb1hLMWxYaDlLRno4cjJMOWd4?=
 =?utf-8?B?aDhDS3RBbFRyeDZLZ2pObWJNOVhYeDJZZk5KdUxaenMxZ0s1RGwrMDl0NDYr?=
 =?utf-8?B?QW9aZS84U3JPeUN2dGxORXlJVVdVVlFtMzJURnBCQXEwVTlIaWpiR1lMSzYr?=
 =?utf-8?B?SkxrUFVSNHljV2xnV200UXNTbnpQY3RZUDRzcVN3MHI2S0xIdXE4eU9hdXpn?=
 =?utf-8?B?dE1Rek5yZUVLYTcva3JvT2h6VWVxdzZCWllTOGkrT2Npck9ZWkhtR0lWb1F0?=
 =?utf-8?B?aVJPWC9aYTFWSEJoVzRubkNDRDV6QytqNWtKNk56aVhwUUJBSHV4M2JhK3o4?=
 =?utf-8?B?c1Y0ZEF0R2lKNVg0MFpteDhXMHJHTXBkV3lKSWYrL1g4Nkc1QjBPZlJldm5h?=
 =?utf-8?B?K2hxRXY2Q0lsamdjMlpaT0RHU3B5bHlRNmROZnliWEJJYTJiaUFhUjF6Ukt1?=
 =?utf-8?B?TmswbGduWXdiVFlyVzRZMWlCdmZPREFrTWUvYSt5cXByUzBqcVpBZllZelNV?=
 =?utf-8?B?WS9PNDBrQ0VWamR6U2N6aEk0MjNNcUxrRWduZ3Y3WmRHQ2lTMXdzcEZ5eVZj?=
 =?utf-8?B?R0lnN3BIT1J5VmZXUFFQdzM3QWlmcTZGbGQ5VWppc05GTS8vd2lmeVpCNDRR?=
 =?utf-8?B?SXFqblNhME11dlpheG15N1RNcWI5Z1k0ZGdyMTE2YzJoV1RvczI0cGd2Q0da?=
 =?utf-8?B?cEx3bGJ2bjZUTVpWVHJKcEdvdEhkazJXejB0U2g5bVJoTlF1S3ZqVnEyM0JX?=
 =?utf-8?B?d1U4UjFSNGdWWDg3YytLSzEvRFB1NkV2eU1BQm1pMGZZRDh6akN3NkZnN3JY?=
 =?utf-8?B?LzNjRGd6d3RPaVBuSDQycEJVL2tyTnFwL0gwYmpwR1JYb3hHYkcwSDgwcENL?=
 =?utf-8?B?L2VoK2JCaWNXejkzMjh0cEhBdzJDb0E5NUVIZlVidHBwcDFvSW1abmtGMGhN?=
 =?utf-8?B?cmxxVmRJNTJHUEJqenZISGFiTndRT25ad08zTy83QkZqVWl4cGpjZHRLUmNU?=
 =?utf-8?B?NktXZmxtak1lKytjVTg4ZXc5Y1JZYTl2Y1A4M1dxYkhlMy9DZitIaS9tUi9T?=
 =?utf-8?B?YnU3Z1BoamdzVjJUd2dWYkhZN1kvYTl6QUN3OTlDUUMxZitWaUtuNFgySC83?=
 =?utf-8?B?WW5YVlBIa1NMbVRWWnFOb1J4dC9SL2tVYVJGVmh3Q0hQWFFVOTJsL1g5YjF2?=
 =?utf-8?B?YnBwTEwyMzd2Z3pNRHhocE9FQlNLY01NbUQwR3pVWjVVOUVyQThkWXNxSDZO?=
 =?utf-8?B?M1pmOGR2L2xUN0hKcS83YUxKNUt6TWExd1JjRzVEQU9jR2FGRzYvUEQ4K0Qx?=
 =?utf-8?B?V0NkdDZPNk5JdDZqV2VGNW9UT1ZHdmR0MFdXM0VSdkNzbllrRVJ4L25oa0lX?=
 =?utf-8?B?aTkvUG9JWWNLbHFpTkc2ZnVsUXMrdU9rUm5JNEdSelJNampTRms2cXhLS1BV?=
 =?utf-8?B?Y1EvZU5sY0JvVE5oN0xwbjBGZjRSQ0VtaXArdWpuY0tTRDJuOFZOM3Ewd3VM?=
 =?utf-8?B?a2MzMWRNTStBSnJCUW5ZWEMyM3U2TjJDM3Z2MmxxQWdmb255d3NQODZUenB6?=
 =?utf-8?B?ZDNkd1luR05sMzRLajVkeW0wdlNDcmhhTG9CY2JwSjNDM0VTa0pMSG4wMCta?=
 =?utf-8?B?S05nTnVwbkJOcFNUaDQwdGVYdlozQXhDM0twOTBhdCtlWWpabUVYUldJcmQy?=
 =?utf-8?B?MzJ2TE4zYjRyWWU0WEVkeXFVeUxoVEFmVzFFUkhiRm9xUDJYc0FLZ1JqNlhX?=
 =?utf-8?B?d0t2TEtielNUeXhvNGRGNHkwOGJlU1FWN08xSjl4eDBqb3J2UjNtSkRoTndF?=
 =?utf-8?B?VUFMcVJuZEFmUnpRYjJPUjBFajBSSmJjVnRJM3VMb1B3bko0Q0N0clBjaFls?=
 =?utf-8?B?RG90U3FqdlVTcmUvYzdZN0VucitINEh4QXF0V0h0WGdxRGZKOTRneHA4MjJT?=
 =?utf-8?B?UndwQzFJK1NOVWNqbWp5TTA5VHlKd2hzRXRYQjAyUk1vSzAxS2d1cTBpV2Jo?=
 =?utf-8?B?YkdyaUpoenR4aXJ1WW9mRTBjUkJqeTZHVGU5cWVHV2dBZXNQUWV6djVWMEtH?=
 =?utf-8?B?WW5XUTE5ZXJaTDVhWDFJczZpZzhiWTUxTlVKdG1SZG1SWlVsMDBUWE1VQlFG?=
 =?utf-8?Q?1Oha6py9Ow1FP/qUWj3TJWU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFZ0N2JzbzV1ek1DVWNMTy9vOFpHZGNGRXRFdFkxSGtJb3BwM1NvcWltOFc5?=
 =?utf-8?B?aXkraTliUWJaM0E2SUpOMTBWNlpxQmpCTGJBdW9kQVljYTBVQjVwUmlwc1l3?=
 =?utf-8?B?cCtnenZGcFJaRXBZVEVJYjZ4SjE5T0dpTUcxT2RUSlhja3hubkZaYzgvYW9P?=
 =?utf-8?B?cjBzaDBweTZudEsyZkJueGsvYWdNbXFSZkJ3OXRmdSt0VDVWZEovTWlGaGFN?=
 =?utf-8?B?cTFqdWNTUWxuNjNsVDBoTWFHZ2U3YlIxdUxVVUtOSldrdUZBNVpBaC9OeHVl?=
 =?utf-8?B?OVRLaUtheSsyL2h4VUM1N1VvMlJ4QlBvL3B5NlBTK2dvdFM4Z0wzclVQMmF1?=
 =?utf-8?B?RHVrUk9iKzkwRllNZEFCZ0F6T2twS3Zadi85QVNCMjkwMW41NDkyZWFjMVEy?=
 =?utf-8?B?V2dmK0FUa1liamxEb05uczE0QWdTSi9KS1Fwdysvby9PSFhqbGlJbDdUNmtn?=
 =?utf-8?B?QkxFc3RNSzhOM2svUTVFRjBmOS9OV2ZJcUN2NWd3Q1E3TFdKUDBreFJEZTFv?=
 =?utf-8?B?ZTMyU1VRRStrTXVhZXVWdUM0a2hsaUk5MUlsQmZkckhBWDc2S3dEOVR5Zjdv?=
 =?utf-8?B?UkxSdmtUUjhKKzFQV1hRSEIyUmRvZ0VETmdCSy9WTUJVQ1gxNkRHa09JMVZK?=
 =?utf-8?B?TGxzRmJMR2xubU1uVzlLdGhyWW5KVHAwaCt2OE84ZDY3RkFqRnJjSGUxclYr?=
 =?utf-8?B?WVRhcU11bzFOc0JZVEp2N0YrUmE3MElLUTE0aitYR1dNbFpjc2JIUkRtaytY?=
 =?utf-8?B?RmJnWXIrblNXcXNiYzBPWHV3NXBVajBrdlAxSWtjeEJFNkEvY09xVFRpMURx?=
 =?utf-8?B?dEZOeUdiRFoyVWpNZTZrbmYwaVl1ZlBzakVnL2RNeXNtVVhsckx3ck0rMTk2?=
 =?utf-8?B?SGN1WnJub0FxOG9ZYTBWUllQcnFRSTRFOTRHeU5oczdmT25SS21jM3VWTitL?=
 =?utf-8?B?WDhSRTdqcDNJRU14Q1BxaHp6cGlsUDFqTFd4TUErTlZUeEd5ZGdtbjlET2gv?=
 =?utf-8?B?bExRNXY4dGRFSE8yb3lTeTRTYytBeFJMSFBKb2FOcXUrbVhRY3dreC9oTWFj?=
 =?utf-8?B?OWNqL2VSQWhLS3VzL3VWUmtRNE5Kd1UvazRJTTBtbEtMK2RYd0lvR2t5ZVFK?=
 =?utf-8?B?MnR0Qk1abGs2S0tsd1BiaGM0TmlUdTJzdjhtNVI4cWZBS0ZnSi8rVHJya0xO?=
 =?utf-8?B?NCtPZXdSWUdrS2pwdkNZNjZ4bG1rYksvL25oaTJmejJBdG1XVWlwZjhhbXVT?=
 =?utf-8?B?bE1wTXdGQWJYbnhRYTEwbi9USnozcFpoVmZmdVZOampvZlB3N21lVEdUaEM2?=
 =?utf-8?B?MTJFV1h5R09sNFJ6a0R0TXlaM0F4c3VHWEp4eWVxSEo0TjdnclRJUm9XTDFX?=
 =?utf-8?B?NmNxWGhnbkFxSmZTV0orRzVtVmgyS0YweDgxUWNnYjRyRmdNaCsrY2ZkaFJC?=
 =?utf-8?B?Kzl6MDdadGJZQ05BS3lGYW1ObW4rWUhncFN6cEllZ3k0dXhWU2dFS2VuYyt3?=
 =?utf-8?B?SVFSU1NQdzVockUxUlFKeUxpc0dnbmlKT2kzb1N5SWZZanoyV1lDU2w4NWxm?=
 =?utf-8?B?Z2hIVlJFdGQ0ZCtLM1QzRWlFdTdTV1dYMmZyZi9HRW4xR0lzV0xxUUJyVkRj?=
 =?utf-8?B?M2xIVUpCOFRlakVYb3lKUTVwNWVHSVMwdjY2Wk5CODdwOXJxb3hXWk5hZUV1?=
 =?utf-8?B?d1dsUmZOSFRwbHFDaUUzWUZpWmg3MXhkYUpJWkR6NnAzYmwzVzFBdE9jNjhW?=
 =?utf-8?B?dkFpb0Y0SjkzRlIzRmsyZGE3aWczQnRRTWpvNHlITk10ck1KajVHV2p6VnJm?=
 =?utf-8?B?Y1plRVltV3g0OHZzczQ2Vy9NaU44RmlpWllITlpzVy8xcGZCYXNCczMvNWUy?=
 =?utf-8?B?S1Q2RDN3enNSaStqLzJLQU8rZGwrWkFSOHcwSlRsMlhDSUM5cVd3b2pzUUJq?=
 =?utf-8?B?d1hDVUdqVElEQTJSUkZDUTRrUEJnMGJtb2xMM3hBYmhTdVhBbG5jRDYxWkVK?=
 =?utf-8?B?UTFVUTh0bXJBR3g4MnpCbU9IdVpIYVRsUlI0SnV1QXdGdUY4bWlPWlBhQWNk?=
 =?utf-8?B?eldOYlpDaDFIZlpnY0ZJcEE1M0c0WUNMZG02ampRbzA5cXN2S01mTklUT1Br?=
 =?utf-8?B?VkpoMFpFZVNzT2hxOVpZdEo0QW1tODF6Z3UwTjJDYXlNNklIUFA0TmNkWnJH?=
 =?utf-8?B?SXBrb3RRS1BjbmN3V2J1MElWUHE4ampLSDRlUmMrUnZVVG9UWmloUnUrd1dC?=
 =?utf-8?B?MmNaUFNCaTFtdnE5dFpVTzBneGlVdld5Ukg5LzZGQ3lVelVYdEFoTkJkZmlp?=
 =?utf-8?B?WGphRXlLV0dqM3FYNnNWOFlyUUFWb0VXa0ZtTTh4dThvTFJFdW13QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9102e749-c262-46d4-1ba3-08de5a480458
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:24:08.9546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0zFEAzI4SGmuvFCTrtN7u5n/jCC6y52sQr+U5XyZcQGj392iQLSmug2jky7vtdfHe20oYyZPz5gdFI6FtLHSaBnwn/2Xe4WSAuh5Rknv8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8045
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

KyBOYWJpaCwgSm9lDQoNCkhpIEPDqWRyaWMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gU2VudDogRnJp
ZGF5LCBKYW51YXJ5IDIzLCAyMDI2IDI6MDQgUE0NCj4gVG86IEphbWluIExpbiA8amFtaW5fbGlu
QGFzcGVlZHRlY2guY29tPjsgS2FuZSBDaGVuDQo+IDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+
OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+Ow0KPiBTdGV2ZW4gTGVl
IDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveSBMZWUgPGxlZXRyb3lAZ21haWwuY29t
PjsNCj4gQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwg
U3RhbmxleQ0KPiA8am9lbEBqbXMuaWQuYXU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUt
YXJtQG5vbmdudS5vcmc+OyBvcGVuDQo+IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1k
ZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAwLzIyXSBody9hcm0vYXNwZWVkOiBBU1QxNzAw
IExUUEkgc3VwcG9ydCBhbmQNCj4gZGV2aWNlIGhvb2t1cHMNCj4gDQo+IEhlbGxvIEphbWluLA0K
PiANCj4gT24gMS8yMS8yNiAwMTo1NiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIEPDqWRyaWMN
Cj4gPg0KPiA+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiA+PiBT
ZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjEsIDIwMjYgMTI6MDkgQU0NCj4gPj4gVG86IEthbmUg
Q2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA+PiA8cGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNo
LmNvbT47DQo+ID4+IFRyb3kgTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExpbiA8amFt
aW5fbGluQGFzcGVlZHRlY2guY29tPjsNCj4gPj4gQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2Rl
Y29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleQ0KPiA+PiA8am9lbEBqbXMuaWQuYXU+OyBv
cGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuDQo+ID4+IGxp
c3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiA+PiBDYzog
VHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDAwLzIyXSBody9hcm0vYXNwZWVkOiBBU1QxNzAwIExUUEkgc3VwcG9ydCBhbmQNCj4g
Pj4gZGV2aWNlIGhvb2t1cHMNCj4gPj4NCj4gPj4gS2FuZSwgSmFtaW4sDQo+ID4+DQo+ID4+IEZv
ciBzb21lIHJlYXNvbiwgSSBkb24ndCByZWNlaXZlIHlvdXIgcHJvcG9zYWxzIGFueW1vcmUuIE15
IHByb3ZpZGVyDQo+ID4+IHNlZW1zIHRvIGRyb3Agc2lsZW50bHkgdGhlc2UgZW1haWxzLiBIYXZl
IHlvdSBjaGFuZ2VkIGFueXRoaW5nIHJlY2VudGx5ID8NCj4gPj4NCj4gDQo+IFRoYW5rcyBmb3Ig
dGhlIGluZm8uDQo+IA0KPiA+IFRoZSBmb2xsb3dpbmcgcGF0Y2ggc2VyaWVzIGFyZSByZWFkeSBm
b3IgcmV2aWV3Lg0KPiA+IFt2MSwwMC8xMV0gQWRkIFNTUC9UU1AgcG93ZXIgY29udHJvbCBhbmQg
RFJBTSByZW1hcCBzdXBwb3J0IGZvcg0KPiA+IEFTVDI3MDANCj4gPiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9jb3Zlci8yMDI2MDEyMDA5MjkzOS4yDQo+
ID4gNzA4MzAyLTEtamFtaW5fbGluQGFzcGVlZHRlY2guY29tLw0KPiANCj4gSSBhbSBzZWVpbmcg
YSAnbWFrZSBjaGVjaycgaXNzdWUgd2l0aCB0aGlzIG9uZS4gQSAnZHJhbScgcHJvcGVydHkgbGlu
ayBpcw0KPiBtaXNzaW5nLg0KPiANCj4gPiBbdjUsMDAvMjJdIGh3L2FybS9hc3BlZWQ6IEFTVDE3
MDAgTFRQSSBzdXBwb3J0IGFuZCBkZXZpY2UgaG9va3Vwcw0KPiA+IGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVsL2NvdmVyLzIwMjYwMTIwMDUxODU5LjENCj4g
PiA5MjA1NjUtMS1rYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20vDQo+IA0KPiBUaGVyZSBpcyBhIGRp
c2N1c3Npb24gaW4gcHJvZ3Jlc3MgYWJvdXQgdGhlIGJ1cyBuYW1pbmcuIE5vdCBhIGJsb2NrZXIg
YnV0IGl0J3MNCj4gd29ydGggYSBiaXQgb2YgdGhpbmtpbmcuDQo+IA0KPiA+IFtQVUxMLFNVQlNZ
U1RFTSx2Ym9vdHJvbSx2MywwLzFdIFVwZGF0ZSB2Ym9vdHJvbSBpbWFnZSB0byBjb21taXQNCj4g
PiAxYzhlOTUxMGIyMmMNCj4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
cWVtdS1kZXZlbC9wYXRjaC8yMDI2MDExNjA5MzI0OS40DQo+ID4gNDMzMDctMS1qYW1pbl9saW5A
YXNwZWVkdGVjaC5jb20vIFtQVUxMLDEvMV0gcGMtYmlvczogVXBkYXRlIHZib290cm9tDQo+ID4g
aW1hZ2UgdG8gY29tbWl0IDFjOGU5NTEwYjIyYw0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9xZW11LWRldmVsL3BhdGNoLzIwMjYwMTE2MDkzMjQ5LjQNCj4gPiA0MzMw
Ny0yLWphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbS8NCj4gDQo+IFRoZSBhYm92ZSAzIHNlcmllcyBJ
IHBsYW4gdG8gaW5jbHVkZSBpbiB0aGUgbmV4dCBBc3BlZWQgUFIuDQo+IA0KPiBXaGF0IGFib3V0
IHRoZSBJM0Mgc2VyaWVzID8gQ291bGQgeW91IHRha2Ugb3duZXJzaGlwID8NCj4gDQoNCkkgd2ls
bCBkaXNjdXNzIHRoaXMgd2l0aCBKb2UgYW5kIE5hYmloIGZpcnN0Lg0KSWYgdGhleSBhZ3JlZSwg
SSBhbSB3aWxsaW5nIHRvIHRha2Ugb3duZXJzaGlwIG9mIHRoZSBJM0MgdXBzdHJlYW0gd29yayBz
dGFydGluZyBmcm9tIHYyLg0KDQpUaGFua3MsDQpKYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMu
DQo=


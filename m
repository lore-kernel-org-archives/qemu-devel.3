Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAF3C83000
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 06:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW7wD-0004FB-NQ; Mon, 30 Jun 2025 02:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uW7wB-0004Eg-AT; Mon, 30 Jun 2025 02:24:19 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uW7w7-0005C2-DD; Mon, 30 Jun 2025 02:24:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQIppi/eQ2G02zev3uv780v3X0Kdlra1DsCo8Bno8CjemlKJ95uB6Rc6I8+PkUoD1JJJxq4OnyIcNjVuu3b8OgcYhCqxXuraycqfFuC/dVbxFAaaiB3Htb0mQ7/FrDkF5qS8Vu3pSWSvy0/KOc4aAZdaI4Xdc6FL7IfmIzYgVHqNRaY1UFlHSDe76wxbeUroEpr48HSXMcJBcM/HqQ/+HZQ6mmMc4VBjpXTZkyy7cWAGYdZMxCXFQhvxs7/DEN3A1xrEHPlIQdfZGf/fW1Y+bfUxWOM5QtKNhATR9AiG+20NJN+04Aj6FIeJ+FSPWy8O3fMh4gvTSDgSpdnreXe7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiVImFVyZdw2e5lPXYzrr81+iuZpZwP3abLNtNJ2a4E=;
 b=xHNBG3xQNfeEQIrOGA8/blZDXuJ2P34FI0COommdqQesHjvOk0k7Wob+HrVY7tbWhyjmjdpmR0p+vpzdl7mcQuwXb8r7YL4yZDynbrbjxPZgezs5KCcr1QHNbth8+4Y3sPmsGeaX8htAUOKhKbvElO50CrqJ7VfPOHDavoj7DdGmJ7UwMffsUKteK27yrqgx+s8MWB/4Oh1SpqfSUWkpeJJVq3KJuE9FQo3eT6aQG7zdiiICtEQ80ImPgCKPbmhJwk8pJ1nLAzKNVcIUAHgp51f/EaIXu7yVo+dB1ypRsuzH1ML9NDzKuOkhgncABoNOjfKq8OAYe4xstZcN0FvpFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiVImFVyZdw2e5lPXYzrr81+iuZpZwP3abLNtNJ2a4E=;
 b=VXtr/8NUoJJ+NcBHYp9bXZFGuwtcVxXqSRbERm2nDRVlk+gB/D6ECB1bmw8j+9Au1Y6l1LhIPSEzlJiUpJPy2ummK0KcycFxXgaToiw+3cFEH1UtGCZ+2f5DwZWswUmOwd1341XF2Dar1n8nwnajbxNiADg+A30eqL2ARbeVM40yrJsLRYRr0eDdUtFm2qIpyswb4djC+aJWPubI/BwQKsz3g01UyrS+RdYGnDl+9ciqbTekAEBqbYRIhx6vbZoeh5eXjxMcBVORPYI4esTdFqwMOZmHyYFrTDyx8htSfwEZc0xJpCBiKcMmRp2ZOKevJ1HHVH9FKEjEzqaByxScqQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYUPR06MB6272.apcprd06.prod.outlook.com (2603:1096:400:35c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 06:24:03 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8880.023; Mon, 30 Jun 2025
 06:24:02 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 1/3] hw/misc/aspeed_otp: Add OTP device model with
 fallback RAM storage
Thread-Topic: [PATCH v3 1/3] hw/misc/aspeed_otp: Add OTP device model with
 fallback RAM storage
Thread-Index: AQHb6X5FnFJEyCK3h0ifr8AB7BPVWrQbOlyAgAAAStA=
Date: Mon, 30 Jun 2025 06:24:02 +0000
Message-ID: <SI6PR06MB7631363A82F88F8F1E3F6CBAF746A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250630051721.254207-1-kane_chen@aspeedtech.com>
 <20250630051721.254207-2-kane_chen@aspeedtech.com>
 <4ee5bd2c-fd15-4947-88ee-30a28946d805@kaod.org>
In-Reply-To: <4ee5bd2c-fd15-4947-88ee-30a28946d805@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYUPR06MB6272:EE_
x-ms-office365-filtering-correlation-id: 96a2aabe-e31a-444c-088c-08ddb79eb509
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UStKM1dwS1YrR0NBUmhlbTRId3NJNjRVZkorSHdLcVV5amluSnd3S3VHTmls?=
 =?utf-8?B?dlNDRE92aTlvcmVvbSsyY3Z3d2FleUNYWmZsQXdpck1qZktpMkdOc3JpVmxw?=
 =?utf-8?B?dmJZTFBMUFZrL2tqV3luQkhDUkcxYS9pYjVEYkxPREFPT1ozc1Vmay8zN0Nn?=
 =?utf-8?B?UEduZHZteU0veldlVG9SVnN4aG1rZVpFYkQrbStjTDVYMWx0anAvcGgvUDQ3?=
 =?utf-8?B?VkdKVzZWWlpVT28rTGR4d1FVSHpQVktXTng3R0xyMUZBbmJNMDlRQlZuRWZ5?=
 =?utf-8?B?SXAvT0dmTmRiWExkRjNkWXRuc29rVElsSDczWlF3bVdEbE9TUHZHeTgzcU5m?=
 =?utf-8?B?dnBTSVZjV3BUTTZCWFcxeERTeDM0SmRuNXFXRjc0YXJCR0tvS2RTN25Pb09i?=
 =?utf-8?B?dGhEWDYweXljNEVWOCtkYXNjcE9zZFphTGpub2NwVU9wUzdNRFlteE00VWFm?=
 =?utf-8?B?ZjF3c2VzS0orN1B2Q1RsQnpNWlJCSy9iM1VrRjJpbk9xVy9wN3BYMzlGVlJL?=
 =?utf-8?B?OUJXSVVzSllmS2VsclRuRHpvUWErd1pSc2ZrSDRnRzQxTVBzM3JZVWovUnNo?=
 =?utf-8?B?S2hzOTlDTFo5TEEwYVNhVlI1LzJuMTBOVE5hZmxmaWdISVlDUWx5eEp4emNp?=
 =?utf-8?B?cElEMFpzaXhBcnZTRDcrOHZsUWJtR0pVL0c5RWZTWisyc0hEdU03QU1OYVNQ?=
 =?utf-8?B?c3hON2FReStYRy9Idm1tYTNzanFnaEJrQmhOek5nNndZT0Z5enR6eURLRHNJ?=
 =?utf-8?B?eXhPNzAyTlRxczUzUUd3NEhKV1MzZEorMzhsVCt4SXU4MWJrYXZYNGZvQ2kr?=
 =?utf-8?B?dGppVW9Ka1BQNzcxMFphRml5anZveWIrSE9oRGIwUUVkblEwRXZIaUhTUTlG?=
 =?utf-8?B?dzVSYTdNUWdGSEFYd1BEK1U2UHd6Sm5Xa2xtSDJKS29nYytJdkl6RXFtbUZU?=
 =?utf-8?B?cVhvaHVGcUIvb29EdXBCd0RHSUpiOXVycU5KK2ExRFJPbHQweXIwT2VTRGho?=
 =?utf-8?B?SEVZakc1bVk2cEpyRkNIQkw5VXQvcFZNUlo5dngvUHZrL01qKzZaZU1nYVEv?=
 =?utf-8?B?THFBY3RsSzQ5ME5uaTlGSEpXYU1Fc1QrUlo5bk1NOFN4UUpJQTNLK1hxdVNV?=
 =?utf-8?B?cHhzS3FFVTZ2cU1hVlZYS3VhL0pDNmRXbnBQeFlPRlY0cGFlTnkxZjN0NXBE?=
 =?utf-8?B?OGtITDFmdTNJQzNxWERtOXRlL0VmUDIyVFA5emxJMFZoTlVraCtwR3NoTnlm?=
 =?utf-8?B?aG9iMk5WOXhaMlU1NTNaZHRIUm56WHFHeEE3TlVpblJaZVB2RkV4WDVHVmZw?=
 =?utf-8?B?aU1uU1FNSi9PZDgrd3pPbTBtQUJ3L0tXWVIzOFpjZUdVK0x5aituN2RRVjNx?=
 =?utf-8?B?dmJuTzFPbXNsRTY2N2dmS3pmVVV3Wkd2NFNoSE94a09JNjBDODU1VDdhVExx?=
 =?utf-8?B?VGkzYW9md2RhWnJ0alZLbmltY2d3Q1FSSC9lTGNxQnRpSGcwNmZSVGN6Umd1?=
 =?utf-8?B?TjVZMk5rVmhGT3N2aDllV0xjcSs4V0lIMXY4aGxhWnNONU1UZ1ZReThKUW03?=
 =?utf-8?B?WkxaVUNpUmdncXJ3RWJURDNVWnhqY1Y2UC9yTlFvd0M5aVlWQzhnejIyKzRx?=
 =?utf-8?B?WlVFcElsV2Y4ZnYxc1lFTi9YUVlWMFlhMXNia1gyQnVlQ2JoV3RJZmpnTnFU?=
 =?utf-8?B?Nm5QSGVaMFlLOTdOYVdRSFovdW1jR3B2QTNhWU5JQzI1QUVQU1E0VlVoSkk3?=
 =?utf-8?B?YVcxRmgwVDROdnJKdHgrVmVobkZsZHNFKzdpbXBObHNrRUtyNWJBNFV1OTJZ?=
 =?utf-8?B?TC9MOGYzWHBvZDFnYkdLY2t3RStkMDBvYzdUdFE1OFh3L2o5RjR5SVljZ3Nv?=
 =?utf-8?B?anJDT1Y1bURtbEtiTFVrSFo0ZzZVTEE1N2pZblpHY2ZpWVB3RVNlSXJaN3Fh?=
 =?utf-8?B?QzQvM0lZQnFLM1diN1A1cTJkQ2NDQ21MRUJlVFBpRUhCRGlSVWJydFVCUytN?=
 =?utf-8?Q?X0/cadwZLQYIEVjunSBkEhPnW5ohw4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekdoNXpxN2l1OWxOWVhsUStrcVRnb0dKeG5KZFpUL1MrdER3OG1aQy8wN1Uz?=
 =?utf-8?B?U1dNWXlkL1dCbkhIR1pDMk8zZDJpT1ZOVEJtcG1aeXpETU1XcVV2R0lDNXFx?=
 =?utf-8?B?QUdNWWlOTzNBbXhGVElrMmNFVHpIbG5Nd2huOVFOTjBVUG43OSs1V2dmSXNJ?=
 =?utf-8?B?TDRjdnRMQi92ZkpwQldhWGNQS1dncTFUbFBPMk9NTWhYNmUremdjalFXTCtt?=
 =?utf-8?B?VTZoNUFXbHpqTTR6SFVTcXhWU09Ka0tFUFk1R2JZNnBTeUNZa2RHMEgyT095?=
 =?utf-8?B?aG42Ni8wVElNN2xPOFZ2NWVVUkZUQiswai8zOStGK21PbjM4NVB6TVN1anRO?=
 =?utf-8?B?TUlxRm1JVnZVemo1eEx1eTlSMXN5eEtCRXdxNDNsWEJXZHh5eEduWXlnbU1M?=
 =?utf-8?B?OHI3TS9uYVNGZTBYQysyRGRRTFp5dUZBWmRaK0JONGJVNUwwaHAvQ1J6WVBx?=
 =?utf-8?B?WThCZTRHKzgxZGRpSm1HRjNtYk1adDlGMEZrREJWMXFHekhnWmF3TVo4a3Iz?=
 =?utf-8?B?VktiaGx3UXRTVzdYNE9DWVJWaCtYTFhZQ3ZPczVhUzI0dEQwa1hqd0svbHlR?=
 =?utf-8?B?S1RsUEZNbi9XaFBaK1A3TVN2VExiZzQyc2g3R3NGUGxHTjFnS1plNVY2bnc5?=
 =?utf-8?B?dU5PRkJjaDh2MWx6NVNHNW5ETllGSWlDWUdMcmM0QzZFcHhBcVRoaEwrVHZ5?=
 =?utf-8?B?aitlKytET09xZ3dybGJRRkxZanU2d1lYU05SeUVKdWl3RklKNnR3NGJXdUZu?=
 =?utf-8?B?MFVNN0U1ME5nUTZuekZoRUw4ZE81a0NLU3pLVFZMUTRHTVRhdENhSUVJc1Fl?=
 =?utf-8?B?OW1hTktDOXl0bS84TzdCeCtpb1NiWDlhbzFkd092cU14NDFiS24yWHlHNjNz?=
 =?utf-8?B?OTg5SDdLM2Q1VElxNTZtMmVvMG9VZ0ExMXZXOElTbWdQNUZvNG56U0lhMjAy?=
 =?utf-8?B?bk15ZjJSaXMyMis4d1Y1OHZCOXJyL08yc0MzMEdnbjA1N1dueG5tdmpqK2xQ?=
 =?utf-8?B?OW5HNTg0NktNWU1QWTNibXI2NGE5UUpWTTVZdG9zbUg3dTNrYzZEMHVBUVJn?=
 =?utf-8?B?MkE3VnhEUkFHbzZub0dacFpVNkQ4bndkUkxiYjMxamhYQ0hURDlrdlc2L2Vi?=
 =?utf-8?B?WHdDRjdlYk5xTS9kdGRkaUZoVnU3Zld2S3pNTXMraVRCV0ZTK1M0NXBiN0Yz?=
 =?utf-8?B?NXNNSVk5bGVGNVVKbE1vMjYxaUZIV0lOc3Q4dytMaXJaR09KYk45T3FjMXd0?=
 =?utf-8?B?RDdkTkVZR01sYmZuNmdRNERGQmZiUkFRZmE5SE1LN083RjNoYWhMNjVQK2lB?=
 =?utf-8?B?eDRFVGZHdFV6d09zSzFTTm9hUEtJTmJFNk1DVmIyUWFqQ3JzNFpxYUh1bnFD?=
 =?utf-8?B?VEpicnZacW1YcTRFMkNZM0pXS3gwZVZ4SVBtNzFaZVdPK0NZNU9uY1JkSnRm?=
 =?utf-8?B?dktjN00vYzQ3ZWJkR0FNdWZZSXJkem8yRU9DK0FnTVhjYTFHU0ZxZjV5NWJR?=
 =?utf-8?B?L2ZmMG56NjVvSU5KS3RubExqY29LRmxrZWY3WVpmOWpEc08zN2c3YkJZSEhw?=
 =?utf-8?B?Ynk5V0FqWjEvY0ZtaVREczN1RG1QMkkrODJDMWFvVnYrWm9TSWZ6UjVmR0N5?=
 =?utf-8?B?RThCZmcwUzZWaVQvOERxeE1HVmtQdTFqRDRQWHNaZkhMb3UvVmtTQ3hnZVhq?=
 =?utf-8?B?cXRWZDZUREtNVTE5MjZyZTRhZU51RmN4Y3lzdENXYTNLM09yLzl0SjAwd01S?=
 =?utf-8?B?eHJoNzdMU2VWMS9ud1BlNlFFcUZWWmg0UDkxVEJsdkdnVlpaazUxUFgrMC9C?=
 =?utf-8?B?RGxoQW1CVUhYRGVsbUZ5MWZlc090STRsOVlxeTRVUDFwaFpibksxanZSd00x?=
 =?utf-8?B?aVRiMDJSTHNhamVsZkp4Uktoc29NVWlVT3JrckdmKzJkYXRSRyt4bEw3cTR3?=
 =?utf-8?B?ZnRJMVI1b2pDN0tudFV0QU02bEhXazV4MERCNTI0c084NW9NYnlqenVDczZm?=
 =?utf-8?B?WkpSY1M2dXQrenpBa3FiRDB4VFdvd243cEI0Q3o2U21zenU5QlVhTUgvcFNh?=
 =?utf-8?B?TE9uWWp0Ym50THcvMDJtNjRYekN2S0xidFcraUIrcWRteER3TG00ZmZhdFdW?=
 =?utf-8?Q?NdRm0gmTkIU6JgffObVFnGZXB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a2aabe-e31a-444c-088c-08ddb79eb509
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 06:24:02.6139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mU/j9Fbh+Cy6xqbVI/RVXiqTRvrJW57PYag6fsoAYacicrYXhYE9IJHwy6yU2T/LSz5swd4yjfr6Ci9jeKYWl3YEbqRMuvA7I7ye8AAQvWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6272
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=kane_chen@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KVGhhbmtzIGZvciBwb2ludGluZyB0aGF0IG91dCDigJQgc29ycnkgZm9y
IG1pc3NpbmcgeW91ciBlYXJsaWVyIGNvbW1lbnQuDQoNCkknbGwgcm9sbCBiYWNrIHRoZSBCbG9j
a0JhY2tlbmQgYW5kIGRyaXZlIHBhcnQsIGFuZCBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRo
YXQgYXMgc3VnZ2VzdGVkLg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+
IFNlbnQ6IE1vbmRheSwgSnVuZSAzMCwgMjAyNSAyOjE4IFBNDQo+IFRvOiBLYW5lIENoZW4gPGth
bmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95
DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+
OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gb3BlbiBsaXN0OkFTUEVFRCBCTUNz
IDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDDQo+IGhlcmUg
PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0
ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzNdIGh3L21pc2MvYXNwZWVkX290
cDogQWRkIE9UUCBkZXZpY2UgbW9kZWwgd2l0aA0KPiBmYWxsYmFjayBSQU0gc3RvcmFnZQ0KPiAN
Cj4gT24gNi8zMC8yNSAwNzoxNywgS2FuZSBDaGVuIHdyb3RlOg0KPiA+IEZyb206IEthbmUtQ2hl
bi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpbnRy
b2R1Y2VzIGEgUUVNVSBtb2RlbCBvZiB0aGUgQVNQRUVEIE9uZS1UaW1lDQo+IFByb2dyYW1tYWJs
ZQ0KPiA+IChPVFApIG1lbW9yeSwgdXNlZCBmb3Igc2VjdXJlIGZ1c2Ugc3RvcmFnZS4gVGhlIG1v
ZGVsIHNpbXVsYXRlcyBhDQo+ID4gd29yZC1hZGRyZXNzYWJsZSBPVFAgcmVnaW9uIHdpdGggYSBt
ZW1vcnktbGlrZSBpbnRlcmZhY2UgdmlhIGENCj4gPiBkZWRpY2F0ZWQgQWRkcmVzc1NwYWNlLg0K
PiA+DQo+ID4gSWYgbm8gZXh0ZXJuYWwgYmxvY2sgYmFja2VuZCBpcyBwcm92aWRlZCB2aWEgdGhl
ICJkcml2ZSIgcHJvcGVydHksIHRoZQ0KPiA+IG1vZGVsIGF1dG9tYXRpY2FsbHkgYWxsb2NhdGVz
IGFuIGludGVybmFsIFJBTS1iYWNrZWQgc3RvcmFnZSBidWZmZXIgdG8NCj4gPiBob2xkIE9UUCBk
YXRhLCBlbmFibGluZyBzaW1wbGlmaWVkIHVzYWdlIHdpdGhvdXQgQ0xJIGNvbmZpZ3VyYXRpb24u
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGluY2x1ZGUvaHcvbnZyYW0vYXNwZWVkX290cC5oIHwg
IDMzICsrKysrKysrKysNCj4gPiAgIGh3L252cmFtL2FzcGVlZF9vdHAuYyAgICAgICAgIHwgMTEz
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIGh3L252cmFtL21l
c29uLmJ1aWxkICAgICAgICAgIHwgICA0ICsrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDE1MCBp
bnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9udnJhbS9h
c3BlZWRfb3RwLmgNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9udnJhbS9hc3BlZWRfb3Rw
LmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L252cmFtL2FzcGVlZF9vdHAuaA0K
PiA+IGIvaW5jbHVkZS9ody9udnJhbS9hc3BlZWRfb3RwLmggbmV3IGZpbGUgbW9kZSAxMDA2NDQg
aW5kZXgNCj4gPiAwMDAwMDAwMDAwLi4yMmIyMTk1YTAwDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL2luY2x1ZGUvaHcvbnZyYW0vYXNwZWVkX290cC5oDQo+ID4gQEAgLTAsMCArMSwzMyBA
QA0KPiA+ICsvKg0KPiA+ICsgKiAgQVNQRUVEIE9UUCAoT25lLVRpbWUgUHJvZ3JhbW1hYmxlKSBt
ZW1vcnkNCj4gPiArICoNCj4gPiArICogIENvcHlyaWdodCAoQykgMjAyNSBBc3BlZWQNCj4gPiAr
ICoNCj4gPiArICogIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICAq
Lw0KPiA+ICsNCj4gPiArI2lmbmRlZiBBU1BFRURfT1RQX0gNCj4gPiArI2RlZmluZSBBU1BFRURf
T1RQX0gNCj4gPiArDQo+ID4gKyNpbmNsdWRlICJzeXN0ZW0vbWVtb3J5LmgiDQo+ID4gKyNpbmNs
dWRlICJody9ibG9jay9ibG9jay5oIg0KPiA+ICsjaW5jbHVkZSAic3lzdGVtL2FkZHJlc3Mtc3Bh
Y2VzLmgiDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFRZUEVfQVNQRUVEX09UUCAiYXNwZWVkLm90cCIN
Cj4gPiArT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoQXNwZWVkT1RQU3RhdGUsIEFTUEVFRF9P
VFApDQo+ID4gKw0KPiA+ICt0eXBlZGVmIHN0cnVjdCBBc3BlZWRPVFBTdGF0ZSB7DQo+ID4gKyAg
ICBEZXZpY2VTdGF0ZSBwYXJlbnRfb2JqOw0KPiA+ICsNCj4gPiArICAgIEJsb2NrQmFja2VuZCAq
YmxrOw0KPiA+ICsNCj4gPiArICAgIHVpbnQ2NF90IHNpemU7DQo+ID4gKw0KPiA+ICsgICAgQWRk
cmVzc1NwYWNlIGFzOw0KPiA+ICsNCj4gPiArICAgIE1lbW9yeVJlZ2lvbiBtbWlvOw0KPiA+ICsN
Cj4gPiArICAgIHVpbnQ4X3QgKnN0b3JhZ2U7DQo+ID4gK30gQXNwZWVkT1RQU3RhdGU7DQo+ID4g
Kw0KPiA+ICsjZW5kaWYgLyogQVNQRUVEX09UUF9IICovDQo+ID4gZGlmZiAtLWdpdCBhL2h3L252
cmFtL2FzcGVlZF9vdHAuYyBiL2h3L252cmFtL2FzcGVlZF9vdHAuYyBuZXcgZmlsZQ0KPiA+IG1v
ZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAuLmYwMThjNTg3MTMNCj4gPiAtLS0gL2Rldi9udWxs
DQo+ID4gKysrIGIvaHcvbnZyYW0vYXNwZWVkX290cC5jDQo+ID4gQEAgLTAsMCArMSwxMTMgQEAN
Cj4gPiArLyoNCj4gPiArICogIEFTUEVFRCBPVFAgKE9uZS1UaW1lIFByb2dyYW1tYWJsZSkgbWVt
b3J5DQo+ID4gKyAqDQo+ID4gKyAqICBDb3B5cmlnaHQgKEMpIDIwMjUgQXNwZWVkDQo+ID4gKyAq
DQo+ID4gKyAqICBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAgKi8N
Cj4gPiArDQo+ID4gKyNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+ID4gKyNpbmNsdWRlICJxZW11
L2xvZy5oIg0KPiA+ICsjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiA+ICsjaW5jbHVkZSAic3lz
dGVtL2Jsb2NrLWJhY2tlbmQtZ2xvYmFsLXN0YXRlLmgiDQo+ID4gKyNpbmNsdWRlICJzeXN0ZW0v
YmxvY2stYmFja2VuZC1pby5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgi
DQo+ID4gKyNpbmNsdWRlICJody9udnJhbS9hc3BlZWRfb3RwLmgiDQo+ID4gKw0KPiA+ICtzdGF0
aWMgdWludDY0X3QgYXNwZWVkX290cF9yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwg
dW5zaWduZWQNCj4gPiArc2l6ZSkgew0KPiA+ICsgICAgQXNwZWVkT1RQU3RhdGUgKnMgPSBvcGFx
dWU7DQo+ID4gKyAgICB1aW50NjRfdCB2YWwgPSAwOw0KPiA+ICsNCj4gPiArICAgIG1lbWNweSgm
dmFsLCBzLT5zdG9yYWdlICsgb2Zmc2V0LCBzaXplKTsNCj4gPiArDQo+ID4gKyAgICByZXR1cm4g
dmFsOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfb3RwX3dyaXRlKHZv
aWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50NjRfdCB2YWwsIHVuc2lnbmVkIHNpemUpIHsNCj4gPiArICAgIEFzcGVlZE9U
UFN0YXRlICpzID0gb3BhcXVlOw0KPiA+ICsNCj4gPiArICAgIG1lbWNweShzLT5zdG9yYWdlICsg
b2Zmc2V0LCAmdmFsLCBzaXplKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGljIGJvb2wgYXNwZWVkX290
cF9pbml0X3N0b3JhZ2UoQXNwZWVkT1RQU3RhdGUgKnMsIEVycm9yICoqZXJycCkNCj4gPiArew0K
PiA+ICsgICAgdWludDMyX3QgKnA7DQo+ID4gKyAgICBpbnQgaSwgbnVtOw0KPiA+ICsgICAgdWlu
dDY0X3QgcGVybTsNCj4gPiArDQo+ID4gKyAgICBpZiAocy0+YmxrKSB7DQo+ID4gKyAgICAgICAg
cGVybSA9IEJMS19QRVJNX0NPTlNJU1RFTlRfUkVBRCB8DQo+ID4gKyAgICAgICAgICAgICAgIChi
bGtfc3VwcG9ydHNfd3JpdGVfcGVybShzLT5ibGspID8gQkxLX1BFUk1fV1JJVEUgOg0KPiAwKTsN
Cj4gPiArICAgICAgICBpZiAoYmxrX3NldF9wZXJtKHMtPmJsaywgcGVybSwgQkxLX1BFUk1fQUxM
LCBlcnJwKSA8IDApIHsNCj4gPiArICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAg
ICAgIH0NCj4gPiArICAgICAgICBpZiAoYmxrX3ByZWFkKHMtPmJsaywgMCwgcy0+c2l6ZSwgcy0+
c3RvcmFnZSwgMCkgPCAwKSB7DQo+ID4gKyAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkZh
aWxlZCB0byByZWFkIHRoZSBpbml0aWFsIGZsYXNoIGNvbnRlbnQiKTsNCj4gPiArICAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0gZWxzZSB7DQo+ID4g
KyAgICAgICAgbnVtID0gcy0+c2l6ZSAvIHNpemVvZih1aW50MzJfdCk7DQo+ID4gKyAgICAgICAg
cCA9ICh1aW50MzJfdCAqKXMtPnN0b3JhZ2U7DQo+ID4gKyAgICAgICAgZm9yIChpID0gMDsgaSA8
IG51bTsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgIHBbaV0gPSAoaSAlIDIgPT0gMCkgPyAweDAw
MDAwMDAwIDogMHhGRkZGRkZGRjsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICB9DQo+ID4gKyAg
ICByZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IE1lbW9yeVJl
Z2lvbk9wcyBhc3BlZWRfb3RwX29wcyA9IHsNCj4gPiArICAgIC5yZWFkID0gYXNwZWVkX290cF9y
ZWFkLA0KPiA+ICsgICAgLndyaXRlID0gYXNwZWVkX290cF93cml0ZSwNCj4gPiArICAgIC5lbmRp
YW5uZXNzID0gREVWSUNFX0xJVFRMRV9FTkRJQU4sDQo+ID4gKyAgICAudmFsaWQubWluX2FjY2Vz
c19zaXplID0gMSwNCj4gPiArICAgIC52YWxpZC5tYXhfYWNjZXNzX3NpemUgPSA0LA0KPiA+ICt9
Ow0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgYXNwZWVkX290cF9yZWFsaXplKERldmljZVN0YXRl
ICpkZXYsIEVycm9yICoqZXJycCkgew0KPiA+ICsgICAgQXNwZWVkT1RQU3RhdGUgKnMgPSBBU1BF
RURfT1RQKGRldik7DQo+ID4gKw0KPiA+ICsgICAgaWYgKHMtPnNpemUgPT0gMCkgew0KPiA+ICsg
ICAgICAgIGVycm9yX3NldGcoZXJycCwgImFzcGVlZC5vdHA6ICdzaXplJyBwcm9wZXJ0eSBtdXN0
IGJlIHNldCIpOw0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4g
KyAgICBzLT5zdG9yYWdlID0gYmxrX2Jsb2NrYWxpZ24ocy0+YmxrLCBzLT5zaXplKTsNCj4gPiAr
DQo+ID4gKyAgICBpZiAoIWFzcGVlZF9vdHBfaW5pdF9zdG9yYWdlKHMsIGVycnApKSB7DQo+ID4g
KyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIG1lbW9yeV9yZWdp
b25faW5pdF9pbygmcy0+bW1pbywgT0JKRUNUKGRldiksICZhc3BlZWRfb3RwX29wcywNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICBzLCAiYXNwZWVkLm90cCIsIHMtPnNpemUpOw0KPiA+
ICsgICAgYWRkcmVzc19zcGFjZV9pbml0KCZzLT5hcywgJnMtPm1taW8sIE5VTEwpOyB9DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgY29uc3QgUHJvcGVydHkgYXNwZWVkX290cF9wcm9wZXJ0aWVzW10gPSB7
DQo+ID4gKyAgICBERUZJTkVfUFJPUF9VSU5UNjQoInNpemUiLCBBc3BlZWRPVFBTdGF0ZSwgc2l6
ZSwgMCksDQo+ID4gKyAgICBERUZJTkVfUFJPUF9EUklWRSgiZHJpdmUiLCBBc3BlZWRPVFBTdGF0
ZSwgYmxrKSwgfTsNCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9vdHBfY2xhc3NfaW5p
dChPYmplY3RDbGFzcyAqa2xhc3MsIGNvbnN0IHZvaWQNCj4gPiArKmRhdGEpIHsNCj4gPiArICAg
IERldmljZUNsYXNzICpkYyA9IERFVklDRV9DTEFTUyhrbGFzcyk7DQo+ID4gKyAgICBkYy0+cmVh
bGl6ZSA9IGFzcGVlZF9vdHBfcmVhbGl6ZTsNCj4gPiArICAgIGRldmljZV9jbGFzc19zZXRfcHJv
cHMoZGMsIGFzcGVlZF9vdHBfcHJvcGVydGllcyk7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25z
dCBUeXBlSW5mbyBhc3BlZWRfb3RwX2luZm8gPSB7DQo+ID4gKyAgICAubmFtZSAgICAgICAgICA9
IFRZUEVfQVNQRUVEX09UUCwNCj4gPiArICAgIC5wYXJlbnQgICAgICAgID0gVFlQRV9ERVZJQ0Us
DQo+ID4gKyAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihBc3BlZWRPVFBTdGF0ZSksDQo+ID4g
KyAgICAuY2xhc3NfaW5pdCAgICA9IGFzcGVlZF9vdHBfY2xhc3NfaW5pdCwNCj4gPiArfTsNCj4g
PiArDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9vdHBfcmVnaXN0ZXJfdHlwZXModm9pZCkgew0K
PiA+ICsgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmFzcGVlZF9vdHBfaW5mbyk7DQo+ID4gK30N
Cj4gPiArDQo+ID4gK3R5cGVfaW5pdChhc3BlZWRfb3RwX3JlZ2lzdGVyX3R5cGVzKQ0KPiA+IGRp
ZmYgLS1naXQgYS9ody9udnJhbS9tZXNvbi5idWlsZCBiL2h3L252cmFtL21lc29uLmJ1aWxkIGlu
ZGV4DQo+ID4gMTBmMzYzOWRiNi4uYjY2ZjIzNjA1YiAxMDA2NDQNCj4gPiAtLS0gYS9ody9udnJh
bS9tZXNvbi5idWlsZA0KPiA+ICsrKyBiL2h3L252cmFtL21lc29uLmJ1aWxkDQo+ID4gQEAgLTE5
LDMgKzE5LDcgQEAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1hMTlhfQkJSQU0nLA0KPiBp
Zl90cnVlOg0KPiA+IGZpbGVzKCd4bG54LWJicmFtLmMnKSkNCj4gPg0KPiA+ICAgc3BlY2lmaWNf
c3MuYWRkKHdoZW46ICdDT05GSUdfUFNFUklFUycsIGlmX3RydWU6IGZpbGVzKCdzcGFwcl9udnJh
bS5jJykpDQo+ID4gICBzcGVjaWZpY19zcy5hZGQod2hlbjogJ0NPTkZJR19BQ1BJJywgaWZfdHJ1
ZToNCj4gPiBmaWxlcygnZndfY2ZnLWFjcGkuYycpKQ0KPiA+ICsNCj4gPiArc3lzdGVtX3NzLmFk
ZCh3aGVuOiAnQ09ORklHX0FTUEVFRF9TT0MnLCBpZl90cnVlOiBmaWxlcygNCj4gPiArICAnYXNw
ZWVkX290cC5jJywNCj4gPiArICApKQ0KPiA+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0K
PiANCj4gDQo+IFRoZSBwYXRjaCBsb29rcyBPSyBidXQsIGluIHRoZSBwcmV2aW91cyByb3VuZCwg
SSBhc2tlZCB0byBhZGQgdGhlDQo+IEJsb2NrQmFja2VuZCBhbmQgZHJpdmUgaW4gYSBuZXcgcGF0
Y2guIE1heSBiZSBJIHdhc24ndCBjbGVhciA/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiAN
Cj4gDQo+IA0KDQo=


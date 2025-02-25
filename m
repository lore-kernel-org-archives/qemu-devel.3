Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA70C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 07:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmpZk-0007Fo-LJ; Tue, 25 Feb 2025 02:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tmpZd-0007Dg-IR; Tue, 25 Feb 2025 02:41:50 -0500
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tmpZb-0000Ln-F9; Tue, 25 Feb 2025 02:41:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAGz236KMxcReQMJ4XIlKCP+Q9V2jALCbn+P8TAB8fEulJUu+4UJVAsRJuyOOTCbmWtBKThJZ1etf32Xmrj0X7jCrKOiilQGqNU8YcWb5B3Kfzoe/5YO1+Ca6q/vfApLuzFvxKUJMxJ1MkrB4/OvJscCLSsQgKUjHJw5RIr7R1xQzRBvgHdJgRjNEvjKmy5t243ffxDjuBVZR+6TpwPl2jXKPN/Zl2V4RApFvRxaIwXjy+hXdSWF6zcx4CWW+/xMlnhUkHa6h/sBsy5pFS/Z9QHZRhgMD+s/dcdiSlAOPXuuc5uv8JKkJqpy4ocnMqB3DvS/Bx4pbQAZqTmYhPfY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT2rs6Yn3z5CcPndC/4UKnrxvYDaN+2icTiIXkUM/Hg=;
 b=VfLAn5c183/fK6OI3b4r1QoL98fGxZmKpCwBCYm08mOC/lYG7H9zqHXReTq+aGucSBzrxHRx22xFLDKzVLPVQKtwkovx/K/r5IRiFIlRVihMeoJA85G/7bGQV1Lo3YvyF+Y/4Q4aHlUmwypWU858/W1tQoeBwIMUAYBGmeZRPGEB29h0FdR57NkHvh2whJ3wGMUytvfAG1+zi4VyCpQo3td1WEZCr5kD36yH4krEpD6T/imfr9JSELvcuVvJgXfKXJUfi+Q8GYtnXBmO9VkGhZj60Yy/NaamsUzZW8JPH0ecRrq8K4q4ZizYroqKLVRxdzifyUXIuMlaw43QiYAmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT2rs6Yn3z5CcPndC/4UKnrxvYDaN+2icTiIXkUM/Hg=;
 b=PVBKC283sKHy9dTJztETEFc4L6S/2P5yjwEUCMQgGUe4+vDqJF6VytQVojJwxqGvYVn6eeZaKLrqDHKA2TKU7whcxEvodoP65daOJDplNoTxtZvZ15MOO4p6J/k68vQelSWSFEvuiCE0DZZJgGEShr4RyfpF2zTj0+cRV0HeVNsnfw9LugojvS3XtxBIMbictlx5gXSKUGYMDSUAfMbkUNKiAQImWwOGSPVR9vb41D5tl2FcAPzkVPDQGLqlclitE5XlcaBnRg1wD6tE8KfS8d9PQvRT5yczyzSs6BjBX2/dhHse3b8kCfBzZBpm7LaOAJt++qWBA/jBwgweqk7uEA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYSPR06MB7205.apcprd06.prod.outlook.com (2603:1096:405:93::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 07:41:36 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 07:41:35 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: CY Liu <cy_liu@aspeedtech.com>, cyliu0926 <cyliu0926@gmail.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4 0/4] Support HACE to AST2700
Thread-Topic: [PATCH v4 0/4] Support HACE to AST2700
Thread-Index: AQHbh1eckQmBwT7c1U2/i9sMRzxFf7NXoecA
Date: Tue, 25 Feb 2025 07:41:34 +0000
Message-ID: <SI2PR06MB50419305B23737962723639BFCC32@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250225073342.2960966-1-cy_liu@aspeedtech.com>
In-Reply-To: <20250225073342.2960966-1-cy_liu@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYSPR06MB7205:EE_
x-ms-office365-filtering-correlation-id: a5df40e9-7d85-4d72-25ef-08dd556fd475
x-ld-processed: 43d4aa98-e35b-4575-8939-080e90d5a249,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SERzdTVZbnQwNnNVZUVOODVJcWVMRE9BZUtja2FDTmNyMzVxZVVjN0pjNnEy?=
 =?utf-8?B?UmZrQTZ6bDFBR0lDZkNEZmxiWEhFUlZtYzBqMmFPWWVWeHVqalp3NTQ3M1JL?=
 =?utf-8?B?MFM2ZTJjSERVQU5IQllFTDF3aWQ0VGFtRlhHa0U4dHdQY0E2RUl1VS9ZdkVH?=
 =?utf-8?B?UHJMMmJ5cXQrNGRxTW1TRjFiR1hwVW5aVFBMcHN4cDJUMUJ5a29kQmhFblZS?=
 =?utf-8?B?NVI1T0NpQWlYK0ptellrcHdqajd5d3RGdmJocDVUL0VxT3k4N0VkUm9Qek1H?=
 =?utf-8?B?OUU4ZW8yL25Ka01leW5aMDJzdXduTGZWdkNsbm16SFJPR3h0UDhqNjFBaUR0?=
 =?utf-8?B?WHNUU0R0cmJEanVvdVVzSWNGdkprZWRKK2czOUVCekkyNzQwZWlvVHpZUHVI?=
 =?utf-8?B?bW1yamkyc09vVm1GaCt6Y3JZSXpmT1BHVWppcWFjTGJzUHFGYlFoV0prR3pP?=
 =?utf-8?B?UlpreXRGM3hrdFREZFkzMjVXZzY5T3VwM2ZFQmJVd000NTU5MUJOMzNLQmdp?=
 =?utf-8?B?L2drcngyR3VvcmlEM2hSZS8rWVE3MXlDNkZ0S2d4RFQ5V1VnUVdtbVpEaDZF?=
 =?utf-8?B?N2dpK0wzb05hT1RiZ25ocGRCM240aURLVEdSRldibDFIRnlzT3loY3V1Nnpi?=
 =?utf-8?B?bmszbVJYcTcxUzZBZm5CT3I2Tk8xd2tUQzJ0bFNxZHJPQ3lUd0luQWhrSDVT?=
 =?utf-8?B?b1JrWDgxRjBrVk9Gc2Frb0Zxa1NDRjVoaXNZdVBwR0pyeTdWMXYxQTNNaytt?=
 =?utf-8?B?Ry9jRUJqL3AvdU5yVXcvajBxUnEvcXNYZUkwUlg3WDNMeWozUklSWUhxOWxM?=
 =?utf-8?B?OXhsejQxZEVDcUhHRmt6V2ErQmRwTkhIWXl6R3oreTlFZEpXOERYVERiaHpJ?=
 =?utf-8?B?QTdCRUk0UVZKSXpyMHBDQnM5WDF6Qml0amhpeHJpR1ZmeEs3WDBLWGJiUzcz?=
 =?utf-8?B?SHJaYkpkRUlPRnhXdGRuTzd0TVJ6QjBnT1VxWGtwMVl6S1BxUnU5NlVpRndN?=
 =?utf-8?B?TERVL3V4Vk1DREUrL2xqRlpMTW8yZDBvN1RRTEVySVVaaW5qMHF2bFFITnEv?=
 =?utf-8?B?bDJwbUdXeExOdDcvbWRZV0xnNExOOTJLUmROSnlHQ3l4WFpiVGJyRTdYc1VI?=
 =?utf-8?B?TzdyK0J2UnNYUmliKzJHWjFKWFpOWUNDS2t4cEloZXBtaVRSVzVEamlGbCsw?=
 =?utf-8?B?cU9DQ1NRTEdTcEQxTkh0bDdZa0Q5a21IY3FoajJXVDFPcDRZd2p5RzlxREtW?=
 =?utf-8?B?UUVkaTZYeGNiSVNSSTFpQW5PbkI4OFErdzNsSTZHdm5IY2hyQVk5bmg0anVY?=
 =?utf-8?B?NzVTL04yekY4azVoTmdBWEgzb0lYeGxKOVhrbEYrOENEc1pmdGtIVE5sTVFs?=
 =?utf-8?B?OUd4TlNxdks3YTlNTHBIU09scjBVU2VmTmtBSzVlbnc0ME5LVzdwb0tSd3pv?=
 =?utf-8?B?MTRoZ1czdllvQk9qSGVhSEt0d1d0ZjE4NjIvazdadFlrUGdqRmpkTW96QkhC?=
 =?utf-8?B?SGRlMHN3Nkw2WXRZdFN1eU5CNlVzdFNmR1dQUFYwSit4QXo3VzRrRzBmOWhW?=
 =?utf-8?B?SmE4VndGbWwrOUkreVV6ZVZOaFlHTzNPcVpnR0hJdlc3SUhpZzdLRm9zZ2lG?=
 =?utf-8?B?bC9BcXhEcnNKWXE1RiswR09HYlZhbkdlNVFISjlROEFYTEQzMEoyM2hjZDVv?=
 =?utf-8?B?aDRzOEdGZy9QSkFGMVgzYnQzNmpzYkgwWDdnb3JvZFdQeTFwSUEwQXZwVGNM?=
 =?utf-8?B?aWdYTEpHQWs5OW5kWHpXNG14bzduRGdEdzFZZEQ5cXF1dDMxVVZwaWIxYTBP?=
 =?utf-8?B?WjFMRDNkU2hWbXlMekI4MThjUTV6TE5jK2RBWE9PbkpKQ0FJKytwYzZCdzVO?=
 =?utf-8?B?K0hWYVBlMDdQK1dnR3lJSTlsRnRVREQ5RzM4ajB0N1JEWjdNa2pwbmYzVDg5?=
 =?utf-8?B?WFdZczg1eG01N3c0ZVh5bEU5aEd5WlhqNUVMZEFWY1h1aDlsWG5aa04rMlQv?=
 =?utf-8?B?WGFEdGt5QSt3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blN6VWhCeUZib2FwMmZsL1NFTjFrOXRzOE41NFRTYlp4UkF4VEVkcTVIMFdZ?=
 =?utf-8?B?RnhZMllycEk5ellCSDMySGpUUkV6U21RVmE2THpkcUk1Q083a2QrTHZnbmJU?=
 =?utf-8?B?NjVWWlVSdmhNQzZTanJTNGI2YzNwcjdZcFBMMjZoOEVUeGUzTzRLa0FGMmpw?=
 =?utf-8?B?Z2FOSU5ZbUExYkhJaTZQaHlMMlp3djlNRmg1Uk9QcnRtd1VXa1RmZmZKV1NT?=
 =?utf-8?B?djcvMlpLSGd2N0lNRVdHTEtPd2tDcGd0WEU4ZnQwUXAzdFRBV2dUWFpPSWh1?=
 =?utf-8?B?bE5Ua0NidHY5QzRkTEFHMVZIVmZDMFc5OW5SZ1Y2NWkwdGpNZ1N3MnIyY0xR?=
 =?utf-8?B?dzJray9ZQi9lYjYyUHFObUtXaUFtWDZEbFZXNVhxSDhURVBLMWdQam9GeXg5?=
 =?utf-8?B?SWN2NU5mQ1ZNdkNidnZVTTZ6cGllRHpkUGdQSmZLb2JDdk1MZTNvM3kzM0g3?=
 =?utf-8?B?VUpJaDg5ZlNHWTA1cEx1ZlBFRXV2b0FQUkR2TTZJUFFWU3dUeDRDT2ZjWGdQ?=
 =?utf-8?B?NHhuMkEzVzllZkFoTU9GajlycXEzd21KMUV4MEZXMjhsV3ArdFl3eGhEMU9i?=
 =?utf-8?B?Vk14ZEhBZHRudmlkL002djVpaVZQK3VKbmNtOVh3QTNMSm9qUzhwSjI2eGxU?=
 =?utf-8?B?TWFRZlZwckx3cWxXZkxFVlRoN0tickNQY1hERElFb0NCTFpVRGtYL05LeWJZ?=
 =?utf-8?B?OVEvNC8yZzFQWEZMRGd4ZkxWOHIrQTlXajRNTCtoRlNacnNYRmNRbm9VQWli?=
 =?utf-8?B?anp2MldMaEhrb09QRmVsVEoxMWl3dzJiNnNIa2xtRkw2WDhibCtTVEFCZlg1?=
 =?utf-8?B?NmpxakIvN3prSXJBZWVESmdDc0Nkd1JhSi9YaHR6L3FqMk10enVwVDEzZXlL?=
 =?utf-8?B?aHowaHdOMTJZMUc2cHladU56ZzdvK1hsb21sQ3ZNRWY4blZicXBMTWdicUhv?=
 =?utf-8?B?Z1pjcG9OM0RuWGdwMVErbHQ0YkVIU2hPRCtTNm9IWko1TnpWanlrNkpVdlJ3?=
 =?utf-8?B?Sm1PNHJMY1JqWGZESnlxZmlrMUhya0xndTJBbUxaeHprMDBaL1BrR3d3ajdG?=
 =?utf-8?B?RTJnRndQbGRUcnRBcGVNektXZVgyQVpkaFIrQndheVdsSzhhOHBPWEFCem1J?=
 =?utf-8?B?ZUd0QVlpM2tLRmtmZzlTSDJjaWh1bGhkcUxpMlVhK24yRFFKWm1VekxZeUtI?=
 =?utf-8?B?WjNxQTRPMWhkZ3BwNlVIQVlhNFg5RW9rNE1LVkpFSnAyeWVRRURteDJnTWFE?=
 =?utf-8?B?d0NtUnJJc2tPZExZSUQyTkNoMXJjSlJKWmZjeDRqaWl3UWE1SnB5TWx3MTg5?=
 =?utf-8?B?aHh6UTh3bjdiSk8vVU8zU1Jmcjk4MVRVUnprRXh2SnN1Q3UrMkFVaXhsRElC?=
 =?utf-8?B?alkrUVFYZG1aWjRyaEptSlFCWWhIM09LRUZSME9vWk9LNHhSRW1MTVppOFBK?=
 =?utf-8?B?c3FjcUdCOEIzcHQyK01KMXVpSEFJcFZYTFNCcDZiYkNydERYcllOMG1mK2gy?=
 =?utf-8?B?QXMzYUpLcGlFTTJrUkxDaGFuMC8yc0RFQkNPQ1ovOHI2N1REUDRDZEY1KzFG?=
 =?utf-8?B?UE1xbGdJZ1lqZ05FYVRvMlJXWUQrUm9EWTBBNGc4Z2MrLy8rL2Qrbk1DZ0FR?=
 =?utf-8?B?MXB2dEZOMXJLakZNczdXbDkrbE9nWHp5L1dlOGZlY01XcVNGME1vVm5XRTQ2?=
 =?utf-8?B?bk1vVC9xVm1Ka0JFQlNud0hkK1lGb0w4NEFaVWJNQmhDbEd4eVM4L3FKOGJz?=
 =?utf-8?B?ei8zL3AwRk9raVQzUU5TMjhsNSszUWtySE9JVnM5b1JheWpWU1VMMFpxT0di?=
 =?utf-8?B?OHAvVWRhb0RVb25YUDltTEdTQitCclpWM3lXYzRnRzNVU3FGektZbzJxbGNk?=
 =?utf-8?B?TDhFck8wOEJmRGpiR0E2UjRMVzA3S2NuNGFOSStlS3o1ZTVpZStUYVdEQzVY?=
 =?utf-8?B?TWFzUzBEd0VEdnV5eWc3dXp3eFMwbjJrbmFOQ0lyTEZzNUxHNTNId3ZJVXZK?=
 =?utf-8?B?azJDZHZkMzJhRFI3SXZxakN6ckVaK25kb0lRczJMQU1TbnQrWG9VdCt1VUVD?=
 =?utf-8?B?QWk0S0NsY05Ua2VBNURmRHVIREV0YXlhUzdMTWtKS2hwM0xnYjhHNTYyem4x?=
 =?utf-8?Q?9MRb3c9xpf7+evRTqZW6uKwd9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5df40e9-7d85-4d72-25ef-08dd556fd475
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 07:41:35.0592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CkERk0gBigPAhQfnWKRXAlhTsEL7xicE5LHLwrlXnufQabZovrfPgZ9x5a6a5AUYQ/eCy0H73hlJyDbNAjhFo9IVCVvxZpwKMsUG7PjUbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7205
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgQWxsLA0KDQo+IEZyb206IGN5X2xpdSA8Y3lfbGl1QGFzcGVlZHRlY2guY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBGZWJydWFyeSAyNSwgMjAyNSAzOjM0IFBNDQo+IFRvOiBjeWxpdTA5MjYgPGN5
bGl1MDkyNkBnbWFpbC5jb20+OyBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPjsNCj4g
UGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZQ0KPiA8
c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47
IEphbWluIExpbg0KPiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3IEplZmZlcnkN
Cj4gPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMu
aWQuYXU+OyBvcGVuDQo+IGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBv
cGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggdjQgMC80XSBTdXBwb3J0IEhBQ0UgdG8gQVNUMjcwMA0KPiANCj4g
RnJvbTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+IA0KPiBUaGlzIHBh
dGNoIHNlcmllcyBpcyBmcm9tDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9xZW11LWRldmVsL2NvdmVyLzIwMjUwMjEzMDMzNTMxLjMzNg0KPiA3Njk3LTEtamFtaW5fbGlu
QGFzcGVlZHRlY2guY29tLy4NCj4gVG8gZXhwZWRpdGUgdGhlIHJldmlldyBwcm9jZXNzLCBJIGhh
dmUgc2VwYXJhdGVkIHRoZSBIQUNFIHBhdGNoZXMgcG9ydGlvbg0KPiBmcm9tIHRoZQ0KPiBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvcWVtdS1kZXZlbC9jb3Zlci8yMDI1MDIx
MzAzMzUzMS4zMzYNCj4gNzY5Ny0xLWphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbS8gcGF0Y2ggc2Vy
aWVzIGludG8gdGhpcyBuZXcgcGF0Y2ggc2VyaWVzLg0KPiANCj4gdjQ6IFN1cHBvcnQgSEFDRSB0
byBBU1QyNzAwDQo+IA0KPiBKYW1pbiBMaW4gKDQpOg0KPiAgIGh3L21pc2MvYXNwZWVkX2hhY2U6
IEZpeCBjb2Rpbmcgc3R5bGUNCj4gICBody9taXNjL2FzcGVlZF9oYWNlOiBBZGQgQVNUMjcwMCBz
dXBwb3J0DQo+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwOiBBZGQgSEFDRSBzdXBwb3J0IGZvciBB
U1QyNzAwDQo+ICAgaHcvbWlzYy9hc3BlZWRfaGFjZTogRml4IGJvb3QgaXNzdWUgaW4gdGhlIENy
eXB0byBNYW5hZ2VyIFNlbGYgVGVzdA0KPiANCj4gIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfaGFj
ZS5oIHwgIDIgKysNCj4gIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jICAgICAgIHwgMTUgKysrKysr
KysrKw0KPiAgaHcvbWlzYy9hc3BlZWRfaGFjZS5jICAgICAgICAgfCA1NQ0KPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCg0KSGkgYWxsLA0KDQpBU1BFRUQgVEkgYW5kIEkg
YXJlIHdvcmtpbmcgb24gZml4aW5nIHRoZSBpc3N1ZSB3aXRoIHNlbmRpbmcgcGF0Y2hlcyB2aWEg
dGhlIEFTUEVFRCBTTVRQIHNlcnZlci4NCkkgd2lsbCByZXNlbmQgdGhpcyBwYXRjaCBzZXJpZXMg
YmVjYXVzZSB0aGUgb3JpZ2luYWwgc2VuZGVyLCBDeSBMaW4sIHdhcyBub3QgcmVnaXN0ZXJlZCBv
biB0aGUgUUVNVSBkZXZlbG9wbWVudCBtYWlsaW5nIGxpc3QuDQpBcG9sb2dpZXMgZm9yIGFueSBp
bmNvbnZlbmllbmNlIGNhdXNlZC4NCg0KSmFtaW4NCg0KPiAtLQ0KPiAyLjM0LjENCg0K


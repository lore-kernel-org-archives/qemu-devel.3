Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1868CCFA18
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 01:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIzYa-0002TT-VM; Tue, 11 Nov 2025 20:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vIzYY-0002SR-SI; Tue, 11 Nov 2025 20:21:54 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vIzYW-0003N2-EV; Tue, 11 Nov 2025 20:21:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QE9RoKtnjtrGIIplJPf6+eBM6jqFOnJ3Wdwb+V8r10SfCw2booS9kJCjTAiEaGO8YhCqJGD+OruRrlRs0o3LeBrg1KQJptuOSA0sfE6y/FV1kniaNcmS3NX2mclGYT3K2uWTL7OH03g8gj1gIiGyaVzwSJlUai5fUR0FQIvDFwgYRpB4jlC+weIJ5Vw45X3vIM48v8hXlIHfrq002QfCbro4hPx/+YULeFZcZU4bDptNRG5DPxk59c430AihtD/YZlu3zNGUqRWz4xLXTffTbKPy78ig5t2BXvaP5n5VZI7gFHVyn60xwuULwyPbyMaRtJeniwYsmI9eISLDK088HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhW7CqbvksEzbiJBY8yN6koNjbyxR8cuF+02AUTNb9c=;
 b=m0iUmAhPWJ0EO8lxhCAy2C1tHwhOwFeJe9HRabWfBmdXpheG1bsq483HeTJIriseArJOSAi2B1IFZMFb8ItUCcgFEDKtt0CWyuk9bJkB0RssJo2O/ZHKWGWVVHFGYqO+S8cwgGNzuDe5oMll45NtBfYveQ2gZMOX4nqD5ju+DFuLy+ou2jVY82e+StcYLTgix2ECh+nj8x8JpbHDFkK+pMpn0T77Nd/3a/qMnAdyjCl/6wVOH0+CaHJE3k6IixdH0428Fx7iS6GAo/ZWaJfP8f1jrkLenyiJbSwuDq0SwKJkLC5w7tIwqloB+KTS8jxzeN7M51lW/90kKHZD0oBjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhW7CqbvksEzbiJBY8yN6koNjbyxR8cuF+02AUTNb9c=;
 b=fSBfnlbQVlA4dwUabcQUvBXmferZ6wCzCFSr18WYzC9eQDPbAO+Q57ZnqmlvD8E3KdHsLlQaNANifdKhePjizqy5mzhmlnUtitThg9uuaiAJ40L4qPiBaeX5r78FBqHgsoNH9uvCwaaZiyQB/z7Zsw5mGqLq7yAq0rXcLQIGWJg3Jvxa+9V8yoiAdSmFDT1F1rDxVw1vT4V/xlhMKkE/2ySczIhICPExjphmcMqI5/tSpYegKwLnRLKav/JfjowE05Cvo+OubYyv4kuo2alBYeyP5CMnlsL4Fjm6JZVC2iayKvej4ihZmezkL2pfh8QIwxyaMu1bhl6s71vb25U51A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB6530.apcprd06.prod.outlook.com (2603:1096:101:182::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 01:21:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9298.010; Wed, 12 Nov 2025
 01:21:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 07/12] hw/arm/aspeed_ast10x0: Pass SoC name to common
 init for AST10x0 family reuse
Thread-Topic: [PATCH v1 07/12] hw/arm/aspeed_ast10x0: Pass SoC name to common
 init for AST10x0 family reuse
Thread-Index: AQHcTvpJDyKhLsAdmEWK8NdI91uLurTt0YeAgAB1u/A=
Date: Wed, 12 Nov 2025 01:21:44 +0000
Message-ID: <TYPPR06MB8206FCC3DAC3BC99B98A176FFCCCA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-8-jamin_lin@aspeedtech.com>
 <b66d5044-cd8a-4f5d-aad4-c685dcd34e3f@kaod.org>
In-Reply-To: <b66d5044-cd8a-4f5d-aad4-c685dcd34e3f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB6530:EE_
x-ms-office365-filtering-correlation-id: 9075f1ab-b7fc-4156-2978-08de2189d778
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bytLaFdrU2p2Z0ZXc2MvdGk4Q2NsYlFJb3lhSEsvbGV3UkpzZFdoUUwvSlNE?=
 =?utf-8?B?WWFZM2ZOcmVNYXNWRWMyWGRYczhiRmVvbTlTb2cyV2VTVUV4NDRNellORVc2?=
 =?utf-8?B?RWwrZ2hyU21FSFFmcXRITmZMcXN6bVhGZ29Mc2JQdkVZT04ra2hlamxDcXly?=
 =?utf-8?B?SGcvTGhXdjVGN3JlMlZ4NFRMWkNJYnFicFBpRmJLMWtmcFNJUmRkQ0FyMFZr?=
 =?utf-8?B?d1JYZDhnTHBiTE5oY2IwQUw3WnFNZXcxTzJjcmRNU2xTQWx5cnJGRHNJV3Fu?=
 =?utf-8?B?R3VySTJZZE5ZWnVld3kxR0R5OHRGb3ZDK3ZIVFgyY0FWM0NaN2Z2N2dKNE5u?=
 =?utf-8?B?ekh4ZzZCZEx1OWU5di8yQkZObjMvWS95MjM5Z1AvQVZyQWdybVE5YURidFNF?=
 =?utf-8?B?TWlUeXlnSTZpaWRVWG96QTZtd056bTJWYlVtb1loZ29ielZPVTE0NXl5elZL?=
 =?utf-8?B?ZE5DeDhBZ2ZRVC9xL0Fjd1dNUTFLMWxuUTJTUG42ejUzb09WQ0lGNVBxam9N?=
 =?utf-8?B?NGFMTnpFWm5mNS9FckFTVHR1WHRaallGd2Z0bjhFSlVZZE9CTWNxcU9MWnFa?=
 =?utf-8?B?STZxRHgzdHI0ajI2bVBQYkV3TmxMSE9Remh5RkFDWDhEem1zWVBXdWphME1x?=
 =?utf-8?B?aE5KWkR2UGd0V1NuR2dqNTR5Z0NBMDRvZ0pRUXVTSE5DeG5wYVlJMHpxd2x1?=
 =?utf-8?B?dWtUWnd3TnBSOVZKWFhTVmZDQ3Vra2liaXNvdWJzd1lrMTM4MkxLMlhiM3VR?=
 =?utf-8?B?clE3Q1VxT0NkNkp3YjJQWTJtT1FCd0RGRFNzL1RaVXpCc2YzQTFlQjU2dzY0?=
 =?utf-8?B?cWRreElhQmlPSitUTjNHSDNNc2ErUnB6RE5taWlFcUQ4TjRvRzU0K1BrRHIy?=
 =?utf-8?B?d1pNdHVWWVdEWUFsZHNhajJUYkxWbWNPSlExZ3ZuTU5EdzhLemxRTkpsODJY?=
 =?utf-8?B?dHp1TmVjdVFpT25zeGJ3MnlvT1c0RU9PMThsOHpNVXVmUFJTZncxemxpZFRU?=
 =?utf-8?B?Tm1iNnEyZjNzZE56d0hwVWx5SjdEVDFvVWRhK281K1dXL2VyK2FMUGVkbExo?=
 =?utf-8?B?TGdhNWx4S0UrVEVadDZ1MmdsRDR2L1BDNHBUa3p6c3FTUXlrSFBsTU45TzZv?=
 =?utf-8?B?Q0JiSWZZZ1g3bDVFL1NBazRLYUREU0JzKy9BRjllTFdZTTVINm1aYVNKOU9O?=
 =?utf-8?B?WHVpMCs3MjdOa3l2V1ZybVRrR2RwdzlGNW5sN2FMV3RwVFZNQnoxZGRUaDdN?=
 =?utf-8?B?YW1yMjNTTGxOZ3NKdjJYZXdFVW9rQlkrZkJPeGdvdGgvNENMUHlMZnFxblFJ?=
 =?utf-8?B?Qm1FWk1mS09Ud2U0YTE4QjZWdTQ4N2NEbHllYUxYTWxtM0dzSHF2dkx3Y3BT?=
 =?utf-8?B?THlVc2ZQcGJUeUtVQ2VrVVJ4dk0zdFBnU2VLSUNsNlZwc0IvUng3YWtWUTNH?=
 =?utf-8?B?dnV5OXZiOXB0SVNEak9jNXVkbHFIcHhnbFFUTUVudENNODcyT3BpUEh0N3RS?=
 =?utf-8?B?TllFNU1LcWw0S2N5YWFtaUN3aklycHY1UVVGSWs2SE03S2lMaGE5cUd6LytM?=
 =?utf-8?B?UDhKdXdzYUlyOGJLWlR2eVgxOWdqN3lVOWZsVGU4WStTalBWeGkrb2JpSDQy?=
 =?utf-8?B?bFNkQk9SbWFEeGpYNHdGYnpsWXVsdldQUmdvam1rQndxSmdncWRmU1JYM3A1?=
 =?utf-8?B?NFlnMklBQ0JYOTcyMUdDVWJ0dUVLNm13Y2ZGMDdIdmc3VHZJV3hzOVJLTHhL?=
 =?utf-8?B?TkN6MzlmWjBSdmtnZzU5SVBEbFJtTzNsYThEVGdzbDFGNFpIMS9HdlF1K1Zw?=
 =?utf-8?B?R2d6THFhbmdSb3ZXbFFueFZyL0tNU2M3Unpyd2tVbHdzaXAwdWttUHJQdkJI?=
 =?utf-8?B?NEhGa2xTbGkwWDROR0RYMG40c0krcHRFenBXYlkzYU00SFZjdVNnWkNKcWkz?=
 =?utf-8?B?d2d6K1E1blhDK0xDYVlTdmZ6eWJ3ai9oUjdzREp1THYyL0tEREluNnU0Mmds?=
 =?utf-8?B?YUFld1IwMElOd3JZTVN5Q1FBU2JKUnRvZURBVlN2YTlzc1dBR2ViM3U1SFZn?=
 =?utf-8?B?Qk9NV1QwRkpYaUZsOTkvQkxiQzlad2oyUjlwUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEFsMDBYNGZseFdIdjdLcUhYbnZjejJEaUtURUlQa3ZOQnRTYlRmMzBsTEJI?=
 =?utf-8?B?bGlCNWpCaDB3WGNJRExmY2c3clV5UTFtQVc5WGRUVldQK0RvZVpXaC80ZGx0?=
 =?utf-8?B?VkdRN203Z2lEUXBWU0NzM2pFT2JFZzNwTktoNVJyc1FnQU9MOW9naTgrTFZK?=
 =?utf-8?B?bVliQ3dJV3d6OEQ5S0EzZmZ4bWFacW9OTzZRSk96Q0h4a2Y0YzAyVW5rcU5J?=
 =?utf-8?B?ZHVwOWRWdTRHVVU0SjJqS3I2eVlUdnJNMHBydjh4WWlGV3Vtc29ydE8vekhW?=
 =?utf-8?B?V3o3bTcvREpoMm1OZmpzY1ZtQnhkWFpDNFRsc20xWFgyZmcxeHZBd1prUTkv?=
 =?utf-8?B?SGw1MnU4cWpKYy9yY2hwOWdIRVR5dmFIOXFDSnFNYkdZdnpJWDBlaU15ZHpx?=
 =?utf-8?B?U29PaW93TGdjYkdQVERXTlJySVJUY0hxWDgrcDQrY2UxbnVTQU5lcUw5K3d3?=
 =?utf-8?B?RDRCRmhUYWRiYkFuTzlXZnNkbEVLT1NXbnRnVkUvV0V2Yjg2bFdFUE5HQy80?=
 =?utf-8?B?WllKTnBFYWFaV2QwNmdnTFlxbWEzZ0pTMGgyTzFTWGJGRDhvSjBqWnZraGdT?=
 =?utf-8?B?QjdqU20vQ0p2QkU1eHAwSW43MU9GM3J2REFCS0FLbHNwaWNzV0NteDhLWnN2?=
 =?utf-8?B?YkpXWEY0K2xjVGw4RUJsZ1ErKzVGTEYwRUROZnJjNXFjOEp4TUM4eldOcFhM?=
 =?utf-8?B?anNDUG1OWEtabUxIdmE0RHhXS1JNN0trNGFuYTR0MHphL29wd2t2cEpCK05y?=
 =?utf-8?B?ejZRQmd5SzMvd3NQRjZYbE54alRKcW5IbXMrMmpPQm5Xa1ordmNndk5QMVhS?=
 =?utf-8?B?aVBGL0V0L2Zxcmh2UGx3QjhUZDk2WTkwWXBVcllaeW0zWEVWaFJHdU1CVTJP?=
 =?utf-8?B?UVJlbXRGNnAxWjlzSGZTMXBwZm9GVlplZTg4TVc1VDRoR3B2aWdZaGZzZDhD?=
 =?utf-8?B?SXZCN2VPRjkwMFlEUU5odHdnMWdXaGhHdHpsY3RxVWo5dks5V1RhbHVGb3BE?=
 =?utf-8?B?czJReUVYbkRvZjlILzJBUFlhYS9OcjExQWdYTWhpVUIwV2ZoTWRGQ1IwZzQ4?=
 =?utf-8?B?WVZoTlpvN0NOWHZzcnpDUU5kSTZnMTBzSkJQdlVIbHJ1dCs4RHkvQThwRjdG?=
 =?utf-8?B?Zy9YZUxVUVJueXpWaEpGMkhDRU16ZTJCMW94b0NEb1lLTG5KUmV4cENkR29z?=
 =?utf-8?B?UGYvN3g5TmZnQUhadjRUcFFPbzc5RC91dEQ0OWU1UmpGMXJVVXlWYVA5MWlp?=
 =?utf-8?B?YStzM1BtcGVqRDMzamdtSWxORWFqaW5odjJYMmNVVEliWncvK01RdUErSXV5?=
 =?utf-8?B?Y3R1VElkWVVSalVSRVJFSENNcW9wOGFkc1BjUHJFYm80RUs0clhnRkRCMGxs?=
 =?utf-8?B?K3QxR05mM0Vhb1pjdU5KWFBrRHQxRHBzZlRKRFQ4ekFwSmQyL2VwV0l6c3R6?=
 =?utf-8?B?MURaZ3Z0QjZrLzBlVVphajhLRy9SMFlOME92V1NpanJHUS9yMUNQdTZnQnZk?=
 =?utf-8?B?eEpJTXdqZ0EvR3U0MnNLTEFjaDY1bEtRV0lyY1JTMWpUTWtRTkcwYVhtZklF?=
 =?utf-8?B?cnZ6bDFnOTRQbG54M3pCNjJTRWJBMDUycStiSUlCUTlHQzBKdkE1bENleUxB?=
 =?utf-8?B?b2Y2VGxaRHVydHFFNElDS3FJSUI1SFdLMU1YNi9PNDhMWDJhcmRhYWVta3Jw?=
 =?utf-8?B?dDI5djVvYmFKK0p0TStLZHprWVhwMkl1UzhuNDk5SXBNdC9oeUx6NzhZakkv?=
 =?utf-8?B?d2xqRklISFZBSmJ6Y2VsVlFLNCt0dG1zY1JvV1dXcW9XOGF1SHJ3YWJQcnVB?=
 =?utf-8?B?YmNvOWxxS2xZRnhxclduQkZwS1N1Wnk0aVZ1bzlUWnFyVzE2Z0JaTmpKRjZO?=
 =?utf-8?B?dmc5aE1ndUUreHFBYnFEQ3lPcmlEdjFmeENGUUl3NFJTYUZrOWdJMnNiZkJq?=
 =?utf-8?B?eW90ZjhGeW4xVWtvWEdaQ3RrY0wyU3RFN0ozeko0WVgzYm5uRUJYTTNFSlZz?=
 =?utf-8?B?YnlIaGFhTUFqcEhMNGxzMHZoUnIvejJ6RnhTcUhGQTJSU2FwcmpWN3dFZXdG?=
 =?utf-8?B?R2VSZ0toNGk1TkY1RGEvb0IxR3Vna2NpTEVoQ21kMGNBbnZiVm5aN0ZXRFg5?=
 =?utf-8?Q?qxfjM+uiFs2lME/V1aaCQcwHD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9075f1ab-b7fc-4156-2978-08de2189d778
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 01:21:44.2178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bbd80i1gYVjfaAjxXnW3BY9V9dD8Z65SLMeUh/fbqdSY6SstrosyIlkNcheDVjg0tFmEUkQC8pwXvOiAlIdO36WRnFfGYA5As3NZ1v6phgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6530
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDcvMTJdIGh3L2FybS9hc3Bl
ZWRfYXN0MTB4MDogUGFzcyBTb0MgbmFtZSB0bw0KPiBjb21tb24gaW5pdCBmb3IgQVNUMTB4MCBm
YW1pbHkgcmV1c2UNCj4gDQo+IE9uIDExLzYvMjUgMDk6NDksIEphbWluIExpbiB3cm90ZToNCj4g
PiBSZWZhY3RvciB0aGUgQVNUMTB4MCBjb21tb24gaW5pdGlhbGl6YXRpb24gdG8gYWNjZXB0IGEg
c29jbmFtZQ0KPiA+IHBhcmFtZXRlci4NCj4gPg0KPiA+IFRoZSBBU1QxMDMwIG1vZGVsIGNhbiBi
ZSByZXVzZWQgYnkgQVNUMTA2MCBzaW5jZSB0aGV5IHNoYXJlIG1vc3Qgb2YNCj4gPiB0aGUgc2Ft
ZSBjb250cm9sbGVycy4gVGhpcyBhcHByb2FjaCBhbGxvd3MgQVNUMTA2MCB0byBsZXZlcmFnZSB0
aGUNCj4gPiBleGlzdGluZw0KPiA+IEFTVDEwMzAgaW5pdGlhbGl6YXRpb24gZmxvdyB3aGlsZSBr
ZWVwaW5nIHNlcGFyYXRlIFNvQy1zcGVjaWZpYyBpbml0DQo+ID4gZnVuY3Rpb25zIGZvciBjb21w
b25lbnRzIHRoYXQgZGlmZmVyLg0KPiA+DQo+ID4gVGhpcyBwcmVwYXJlcyB0aGUgZnJhbWV3b3Jr
IGZvciBBU1QxMDYwIHN1cHBvcnQsIGFsbG93aW5nIGl0IHRvIHJldXNlDQo+ID4gQVNUMTAzMCBk
ZXZpY2UgbW9kZWxzIGFuZCBpbml0aWFsaXphdGlvbiBmbG93IHdpdGhvdXQgY29kZSBkdXBsaWNh
dGlvbi4NCj4gPg0KPiA+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+
ICAgaHcvYXJtL2FzcGVlZF9hc3QxMHgwLmMgfCAxNCArKysrKysrLS0tLS0tLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkX2FzdDEweDAuYyBiL2h3L2FybS9hc3BlZWRfYXN0MTB4
MC5jIGluZGV4DQo+ID4gNWJiZTE2YWYyNC4uYzg1YzIxYjE0OSAxMDA2NDQNCj4gPiAtLS0gYS9o
dy9hcm0vYXNwZWVkX2FzdDEweDAuYw0KPiA+ICsrKyBiL2h3L2FybS9hc3BlZWRfYXN0MTB4MC5j
DQo+ID4gQEAgLTEwNywxOSArMTA3LDE0IEBAIHN0YXRpYyBxZW11X2lycQ0KPiBhc3BlZWRfc29j
X2FzdDEwMzBfZ2V0X2lycShBc3BlZWRTb0NTdGF0ZSAqcywgaW50IGRldikNCj4gPiAgICAgICBy
ZXR1cm4gcWRldl9nZXRfZ3Bpb19pbihERVZJQ0UoJmEtPmFybXY3bSksIHNjLT5pcnFtYXBbZGV2
XSk7DQo+ID4gICB9DQo+ID4NCj4gPiAtc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3QxMHgwX2lu
aXQoT2JqZWN0ICpvYmopDQo+ID4gK3N0YXRpYyB2b2lkIGFzcGVlZF9zb2NfYXN0MTB4MF9pbml0
KE9iamVjdCAqb2JqLCBjb25zdCBjaGFyICpzb2NuYW1lKQ0KPiA+ICAgew0KPiA+ICAgICAgIEFz
cGVlZDEweDBTb0NTdGF0ZSAqYSA9IEFTUEVFRDEwWDBfU09DKG9iaik7DQo+ID4gICAgICAgQXNw
ZWVkU29DU3RhdGUgKnMgPSBBU1BFRURfU09DKG9iaik7DQo+ID4gICAgICAgQXNwZWVkU29DQ2xh
c3MgKnNjID0gQVNQRUVEX1NPQ19HRVRfQ0xBU1Mocyk7DQo+ID4gLSAgICBjaGFyIHNvY25hbWVb
OF07DQo+ID4gICAgICAgY2hhciB0eXBlbmFtZVs2NF07DQo+ID4gICAgICAgaW50IGk7DQo+ID4N
Cj4gPiAtICAgIGlmIChzc2NhbmYob2JqZWN0X2dldF90eXBlbmFtZShvYmopLCAiJTdzIiwgc29j
bmFtZSkgIT0gMSkgew0KPiA+IC0gICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+ID4g
LSAgICB9DQo+ID4gLQ0KPiA+ICAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgImFy
bXY3bSIsICZhLT5hcm12N20sDQo+IFRZUEVfQVJNVjdNKTsNCj4gPg0KPiA+ICAgICAgIHMtPnN5
c2NsayA9IHFkZXZfaW5pdF9jbG9ja19pbihERVZJQ0UocyksICJzeXNjbGsiLCBOVUxMLCBOVUxM
LA0KPiA+IDApOyBAQCAtMTg0LDggKzE3OSwxMyBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc29jX2Fz
dDEweDBfaW5pdChPYmplY3QNCj4gKm9iaikNCj4gPiAgIHN0YXRpYyB2b2lkIGFzcGVlZF9zb2Nf
YXN0MTAzMF9pbml0KE9iamVjdCAqb2JqKQ0KPiA+ICAgew0KPiA+ICAgICAgIEFzcGVlZFNvQ1N0
YXRlICpzID0gQVNQRUVEX1NPQyhvYmopOw0KPiA+ICsgICAgY2hhciBzb2NuYW1lWzhdOw0KPiA+
ICsNCj4gPiArICAgIGlmIChzc2NhbmYob2JqZWN0X2dldF90eXBlbmFtZShvYmopLCAiJTdzIiwg
c29jbmFtZSkgIT0gMSkgew0KPiA+ICsgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7DQo+
ID4gKyAgICB9DQo+ID4NCj4gPiAtICAgIGFzcGVlZF9zb2NfYXN0MTB4MF9pbml0KG9iaik7DQo+
ID4gKyAgICBhc3BlZWRfc29jX2FzdDEweDBfaW5pdChvYmosIHNvY25hbWUpOw0KPiANCj4gDQo+
IEFzIFBoaWxpcHBlIHN1Z2dlc3RlZCwgd2h5IG5vdCB1c2UgZGlyZWN0bHkgOg0KPiANCj4gICAg
ICAgICBhc3BlZWRfc29jX2FzdDEweDBfaW5pdChvYmosICJhc3QxMDMwIik7DQo+IA0KVGhhbmtz
IGZvciB0aGUgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KV2lsbCB1cGRhdGUgaXQuDQoNClRoYW5r
cy1KYW1pbg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gPiAgICAgICBv
YmplY3RfaW5pdGlhbGl6ZV9jaGlsZChvYmosICJscGMiLCAmcy0+bHBjLCBUWVBFX0FTUEVFRF9M
UEMpOw0KPiA+ICAgICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKG9iaiwgInBlY2kiLCAmcy0+
cGVjaSwgVFlQRV9BU1BFRURfUEVDSSk7DQo+ID4gICB9DQoNCg==


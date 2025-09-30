Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CEACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 01:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3PHO-0003j9-0y; Mon, 29 Sep 2025 21:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PGy-0003aG-D4; Mon, 29 Sep 2025 21:35:21 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1v3PGm-00030R-2c; Mon, 29 Sep 2025 21:35:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8F05SMO0WszThz7BKrmE96FzjtPh9W/iuYag+NwgvXUMHmMXYXMHDxLFqU24bNzGrOaCHqxJgSZSeIP5MqUTyY2DIz2KvuGbbsWxKPvjL3o/caHm/fxuWxCsRO9657eX+B/0dsPMI5IR9+7YKHUXit09eGS86sI26qbVrt0lZU1JxcddMlKQbUbND3rnM8Ob7jIOib/BfKxjPleMUcLlkPZS4g4OWMC0d8kkCgyzBO09GxAZ3pv58hKYrx73xdCFaEGPDPhy5/Z/whUAbtBna9T36aVGUP8nUNIjYMpw6siwp6tUeoNL7oIBd54fdVvL9L718QFWKoh4VD8xr35cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXFiNe8BvyxfvZ5rLvpgwYvWWngD3FG3zufFMY9dth0=;
 b=SWcHgCxriKt+fOk0awEgjssYzt2TYVR0zUcZ7h4zin8X0ypZLWMfSaCvOmmQu5EK+pHHrxzgAYt4Y2KlkLTFhjaL2Whovec4dECm/IOXHOBFeqYsTyKZ/lqje/c67FlmFjoGVFjmCbjY4RejQLOC5DmGznI/ULHb6y6fN2o9S2nwvT4ckve6UmNvp9eRQJmSxtQ3ihKplW2JI1CCasw8/oscSglJwhyJbsLOUJw6Uf/RIn7w0t+YYdGhf3tsvOlkH51h1GUW6dWdW7uGsREy0u3FCerhjK4X5tua9wtpoLMCxOa4PGXs0pctVMcSsuCgQF6oCUO4gCIr1oMBf23WwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXFiNe8BvyxfvZ5rLvpgwYvWWngD3FG3zufFMY9dth0=;
 b=HVFdkXIknRFSNHFbbGIOyFcjDZ1rNRsAgFy0/HmNJr78fBOQqPhbr1zqRGKD3c7XEt2AGaMpH11qxyfYLMFZ6rqVQJX6NMf0h0309/5rsXQy0rP/H3boQOXTVZT46lu/QmJ5RzaISxHS6wY+tefmAgfOJftkhHv5NvHBUP9qEdTFoILG8Pb96zx69wHV4oJugNyolg7pXh4esGdRVDItfwJvy8STIvhs1i1sNWoT7/4MVnugQ4P67WYPY4inBOfxFFSTwPLfLKKezwdPWUAFAyPV7JrbuAXBMtmtn/0iv7iCoAKI6bhXTa3An82XGncKdJSc5z3ZyVAXGeMpfRRSpw==
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com (2603:1096:405:319::8)
 by TYQPR03MB9459.apcprd03.prod.outlook.com (2603:1096:405:2ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 01:34:59 +0000
Received: from TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956]) by TYPPR03MB9497.apcprd03.prod.outlook.com
 ([fe80::b1e1:e93d:d3bd:3956%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 01:34:59 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Peter Maydell <peter.maydell@linaro.org>, Yubin Zou <yubinz@google.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Hao Wu <wuhaotsh@google.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Titus Rwantare <titusr@google.com>,
 "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>, "CHLI30@nuvoton.com"
 <CHLI30@nuvoton.com>, "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "tali.perry@nuvoton.com" <tali.perry@nuvoton.com>
Subject: RE: [PATCH 6/7] hw/pci-host: rework Nuvoton PCIe windowing and memory
 regions
Thread-Topic: [PATCH 6/7] hw/pci-host: rework Nuvoton PCIe windowing and
 memory regions
Thread-Index: AQHcIda2rfib8UplCkOzn1V1NpEj+7SkMoMAgAbeneA=
Date: Tue, 30 Sep 2025 01:34:59 +0000
Message-ID: <TYPPR03MB9497BB74CA70A8C935E1CDE4DB1AA@TYPPR03MB9497.apcprd03.prod.outlook.com>
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
 <20250909-pcie-root-upstream-v1-6-d85883b2688d@google.com>
 <CAFEAcA_Lp0hv_b726pSZg9CbPZrxEZ1gShOz+kJZuE2x3TG+Mg@mail.gmail.com>
In-Reply-To: <CAFEAcA_Lp0hv_b726pSZg9CbPZrxEZ1gShOz+kJZuE2x3TG+Mg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR03MB9497:EE_|TYQPR03MB9459:EE_
x-ms-office365-filtering-correlation-id: b07e7ec3-7de8-43c2-0ea0-08ddffc191e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TkJTNFJtUUhKOGpQSG15OEtnOTlYeVBpK1hzYjI5L2ZJdDNnbEJHRGVjc2dk?=
 =?utf-8?B?K2JxVEFiQ21RRFVOS2FRUW0vTnBaR2dUbnM4VHpHY2Q0dmk4bG1SMmlqTkdF?=
 =?utf-8?B?U2NudWoxTWQ3Z0pmczlzTFlsTk1hWnhCWUM1a3A0WjJkZVpiRVo5QnNnWWJt?=
 =?utf-8?B?ZHBMYU1tZkI0OEdiVFU1TFJzY21VeWh6K1VLNHlpNzVLWFRMbVBSN3dVdUph?=
 =?utf-8?B?VWpZZi9waDM2eDhJZFVqMVNsV3I0SEVJT3VqMThlV0ZVN2RPeGZIOFFJU2tT?=
 =?utf-8?B?Y3UzOTM3WE1QSGE4eWNzVWU1ejRMeWNuYlhkaWdrN3dsSlI4NkFiRFJDL1c0?=
 =?utf-8?B?b2dwTnFxWE5xaCszOUhJL2YwdkVNKzRhZnNaMENydzJwcm1vMUtxU3RyajJv?=
 =?utf-8?B?clB6WHpUaG1IQStpaDBWRGVJYVFGdG5JZzZ2N29qdW9maWJXWDN0VXE5TUZZ?=
 =?utf-8?B?c21EaGhlSVFxR3g5cFRHZVplKzZrRnRlcWRDQWR3QWdWa3gzMktqNHZ4cFMx?=
 =?utf-8?B?ZzNPYmVHV2kxN3FVVTlCUkh2OGN4NVVoM1VKaVlZUGI5QTdGRmYrTHJpamdT?=
 =?utf-8?B?aUlwWlhFT2dSN2ZRaVpNc0xjUTc0dlBkUzNPVFBDQTBucVc5RFY1L3pXRGQx?=
 =?utf-8?B?NytSMnJVY1Y4OFFpQjJaS2RDT3FmWkRMRlBId2hHM2V4bWg2am96dU4wQnEx?=
 =?utf-8?B?ai9UZU56N3hDVXhnVEZEOVNiTmNOanZzT1B2NWJ3QURPODQ1Tld3OXBLRGth?=
 =?utf-8?B?d2o4ZkVtY0czbDYzcXFZdk5jOG52aFN4WTU0S1dwVXBPclBqRXIzd3JWS2I0?=
 =?utf-8?B?N2RGNDB6Y3c1cUo4cGpwWVFpd09zaC9KeDBzVENnekhIdnZXbVhUZVRGUWcx?=
 =?utf-8?B?dmozL01pTS95azBvRkpnTjRHRmtCSldMaXlVMGtLTU9FV050MFVMYXh0WVVZ?=
 =?utf-8?B?eVIrbmdsRTN4NVBkdkhIYjAwVGRuUlprQk5IaW9nUVJVblhYY1ZRWnEwc3dr?=
 =?utf-8?B?bzYyUk1KZDNzdS9EREFSTXlGVlRsMDliaDNkeFhUMUJQU0c5VkttRHIvUXFj?=
 =?utf-8?B?RWhiR3RHK0VrNFN0SUxpOGlDSWVmVkR0K1NZU0QvOEMvSFBOT0dkbVcyeHlJ?=
 =?utf-8?B?SHo0cU84UjFwRWtqckFJM2ljdmxkeGFRd3g4STJLYW1HWWRaN3BJNUcwWUFh?=
 =?utf-8?B?TTZqM2YzZUIzZk1TSjhCMDl6RUs4NnVtTXhHZjlma09Qb2dPcElnZEhqZmxX?=
 =?utf-8?B?M2RlQlNXbysrTERsRGdidVNrcW1jaE04WkxlWHZBQ3VCaW5uRjdJMEw5N3hW?=
 =?utf-8?B?ZHRURllnTjFoWlA2UUdZTnRFdGJiSnVNenhDYUtJNnFHdmc1bU83TjgxeDFq?=
 =?utf-8?B?MjdVRi9HWi9zNWZyWVJXWWlmY2dWakpnNDI2NG1mWTZWWkNhbHJaQnU3WUNw?=
 =?utf-8?B?Mm9BQUNLdjhDcGNodHZRVnRUTWhlZDhvcm00S2QxcGZYYnpmMzdQT1N5a2Mz?=
 =?utf-8?B?THJGZWtFcUVOTHo0YmFQZFZJSWF1OTJkdkhQNXRacGRkUUl1TVhMZWtJRHFv?=
 =?utf-8?B?OFVPNnN3YnRmaW1qZE5mZEMwaGZFc0ovWmxEbGVvMCtMNE5mK2NMOXNSOXFW?=
 =?utf-8?B?bHAwczFaQ1VlNHVkQ3FHOW9aSkNhNjN2YTZEbzlOYmxhbk4wWDB5UDk1YnYy?=
 =?utf-8?B?bFhhSGNmTHJ3UWg1NWJuajlsSE5JdnNzSzJPQUFHeGRVUnBRNmhNQUNmRmFH?=
 =?utf-8?B?a2N1MWZBaVNLRlBEcG1PTWtaZ0VJdnBrR3plb1JHaXo1VVNjVDlWSXpPVThY?=
 =?utf-8?B?Q0JkOGN2WlhmYWRraytyS1dCVmNFQzJvRHFEL0tHZDFKY2JWSXJ0L2VDd2JO?=
 =?utf-8?B?MmUrT3haUSsyNUx5Qk05UjZUWUxCSmw2NVl3Vys5Z1RqRnV6MzRnMWxFU2g3?=
 =?utf-8?B?eHdBQ3REZUF5eEt6Q1lFSDBGZ0FaS282bzBrTEpHQm44cEV0QW8rMm5lK3Rs?=
 =?utf-8?B?UHR5WHRCd2YzUFFOeVVmOFk5MXhDZDYrTHlzbkRVV0FHR2pUbjdPU09SY1Zl?=
 =?utf-8?Q?EBSRPV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR03MB9497.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QU5yNmZROWpJTFRxV3RCVEd0S2V3a0toWUlEWDdqZVVGWFdMdkhlUHl0aDNM?=
 =?utf-8?B?YzJPOHJEVmd3MGtZR3BEWWh5TVloS0RZZlhVb2lzYWsrcWF2Ym4rT0U2K2hq?=
 =?utf-8?B?WHlieVNlTXdNWFBzRzdMTmhvV2h2Mi9EcTZZQzEyTFV6RUc0UEhmS1lMd3RI?=
 =?utf-8?B?NDRnTEgxNFlhQzFTa1pZQ2ZPK0VVV05OMWp2VW9MY1ZmdGRneE9iT3p4dUJR?=
 =?utf-8?B?OGJTQ29oN3g0TEs5OU4rVUxwZFJ1RVNSMnk4cTdWNEVMbk5yQWFPajVoTFJR?=
 =?utf-8?B?eGdFV2FXVzRaUVIrQmlpb2E3MEJIYmN4bkVWSjhEYnMxWU1HZGZPNkowWERL?=
 =?utf-8?B?NmxhaWVOYWFpaTZLL1dJWGJZUi9TV01zSDlaSTZsQ2pweW9zcU9sbjFVYXpM?=
 =?utf-8?B?N0tTMlBPdlRSN3dvWFdVYjFXeCtENWNvNjhiYmVoU0x1WUpwaVQzSjhmZ01P?=
 =?utf-8?B?dGozUmZxem8xcGl1Q2lWdC8zMWh5T2t1V3cwQ3p5ek93bDllRCtIWDhnMWhP?=
 =?utf-8?B?d1g4emdqN0hoSVUwQ0xsV3Yyd1RlVXFONFF1WGhaejZJbnVXQkxsakt6a2lZ?=
 =?utf-8?B?bWRySVQ1b3pHb1ZCNFpGNi9Eb1kyaFgrL0FUTWlGZ1hTUDlpZWxMdVBVaG9K?=
 =?utf-8?B?NFdZNmFPOUpsZHkrbnJKK3A1WjExMitnelhTalBsOUFoU2Nxc3U1aU1BekxE?=
 =?utf-8?B?ZjF5bFVwSmp6eU85SGt4bFFNaUhHT3R6YmlQTk5WMVJyUzFqcmczMnIrVnkw?=
 =?utf-8?B?ckFJeE13cVQ2dG1Qem5KY3VXZ0xpVjhIYkNKSG45S3BZUFV2QTJqaVlLRU05?=
 =?utf-8?B?WlNGc2tpMGQvTlJxelhkQkgvRGg5WGJEb2RmMHNzQUEvR3lYdCtSRklmTGNO?=
 =?utf-8?B?cWJqcm9TeTFvQVlCc2JOSDFzakFpUGJPWUpzVXhPMVQzVTVOWTFPdEEvU0Zu?=
 =?utf-8?B?TkpYQ1RWakxjcDdRb3FJeTUySk1adWZZVGh0ekJxcDJKYityTGFzVkVZUmtq?=
 =?utf-8?B?YndML1M5Nmd2TWRpdDRtT0pqNmIrZUJjOEdWTTk0bWZDSjFGQi8xUkFQc3dj?=
 =?utf-8?B?UlBKVmkwK3FBL0xhaHNhRkZTYWFNU04ybjhVcjlhUmpRRDVPVmlDLzRKc3U5?=
 =?utf-8?B?Z0VSY1Vzazl2YnB0YmxuUGMvQmFBemdFNVZXU3IvY2dKemIxd3A3U1gyYXpS?=
 =?utf-8?B?VDVuUHViZ1psVmxGRERLNXUwMldoaDRZOFI0RXdIM2pUM3pxSlBMMitDc2da?=
 =?utf-8?B?NjRTS1dtNlc4MjE1M0R1V1ptQWpydHZrenVYcWxNTDluditpOXhJN0hGeHpP?=
 =?utf-8?B?Z0djdlFkR2hOZG5NT2svc2E2MzBCMk9EUitlK1Yva1F4SFNiYVEwRkI1eWpp?=
 =?utf-8?B?TmVTcmpIODhyK2tQeUxvWXdWMUNXYXJiTDNQLzRhOUFlOW1iZzlac1UvdFNF?=
 =?utf-8?B?SnZGL21XbzNtbWF6MldlVXFzYmpkUVRGWldtSUFYTjU1bm5wTEtUMTdLZHdT?=
 =?utf-8?B?R3RJd2V1Z2YwV2tTWFhsTC9Xa3M5M2o1NDN5ZnBwY3B5c3dKTGtVb1ZqWFZ0?=
 =?utf-8?B?ck1xdlRzRnNUYkIzOXUvR0cwOTdvQWZkUHJOajdvL2RHak4rRlhzaHBwdEdT?=
 =?utf-8?B?ZkNna2JGbUhIK1Rtazg1VHlVVnhLSmZPMzB2d2VRUnQxQTZNdHJMa1NzcnlJ?=
 =?utf-8?B?cy9yVGtzSmtIV2NlVVJjVFEvejd6OUFSR1BORFpCVUdWbWgrLys2Z1FQbDJa?=
 =?utf-8?B?eDRrT3B2MjU2YXNZVFB4Rys0MDNvZlVOYTgvQ3RBWndycmdPNitFc0dxbDN1?=
 =?utf-8?B?bVNVOUJMVGliMFZDb0E2ZitVWWFkbVBIeEFZeVZvTExrcllodVpOQkFKYjFQ?=
 =?utf-8?B?c0VJZWwvYkFvME5lSFR5MCtHaDA3N2lVVGliM0owdS9CdDRxZFZ0Vjlkdkl2?=
 =?utf-8?B?WWNOeEVrNVovUm1pRmpzU0lhVGhVMU9oS25MZE0xcU13Z3laWHJlek9OUlBJ?=
 =?utf-8?B?TnRoZkFHZEdOWkJmMld0U2NaWk9PZ1lWYW12MEtDSTRseTl3SGZkVEVlS20w?=
 =?utf-8?B?em13a3RyRmR4RWZEU3FMWXVaRm16Tklaa0ZQSmtXK2V6cTRIOWlqTGRpN0V6?=
 =?utf-8?Q?ZkEVeZa5pk5esWY6PbYjw/Am7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR03MB9497.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07e7ec3-7de8-43c2-0ea0-08ddffc191e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:34:59.7468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/zAXbGSnUt6+YYwnLa/5+yY9YfuReIbnkLI9yss90Ax/MLrRL6/G3thHT7iRd29w/tBDApdNb4ByEvfvxYYNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9459
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=KFTING@nuvoton.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

TG9vcCBpbiBtb3JlIE51dm90b24gZm9sa3MuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQpTZW50OiBG
cmlkYXksIFNlcHRlbWJlciAyNiwgMjAyNSAxMjo0MCBBTQ0KVG86IFl1YmluIFpvdSA8eXViaW56
QGdvb2dsZS5jb20+DQpDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBQYW9sbyBCb256aW5pIDxw
Ym9uemluaUByZWRoYXQuY29tPjsgQ1MyMCBLRlRpbmcgPEtGVElOR0BudXZvdG9uLmNvbT47IEhh
byBXdSA8d3VoYW90c2hAZ29vZ2xlLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7IFRpdHVzIFJ3
YW50YXJlIDx0aXR1c3JAZ29vZ2xlLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggNi83XSBody9w
Y2ktaG9zdDogcmV3b3JrIE51dm90b24gUENJZSB3aW5kb3dpbmcgYW5kIG1lbW9yeSByZWdpb25z
DQoNCkNBVVRJT04gLSBFeHRlcm5hbCBFbWFpbDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSBhY2tub3dsZWRnZSB0aGUgc2VuZGVyIGFuZCBjb250ZW50
Lg0KDQoNCk9uIFR1ZSwgOSBTZXB0IDIwMjUgYXQgMjM6MTEsIFl1YmluIFpvdSA8eXViaW56QGdv
b2dsZS5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBUaXR1cyBSd2FudGFyZSA8dGl0dXNyQGdvb2ds
ZS5jb20+DQo+DQo+ICBUaGlzIHN3aXRjaGVzIHRvIGEgdXNpbmcgYSBmdWxseSBzaXplZCBQQ0kg
bWVtb3J5IHJlZ2lvbiB0aGF0J3MNCj4gc2VwYXJhdGUgZnJvbSBzeXN0ZW0gbWVtb3J5LiBBY2Nl
c3NlcyB0byB0aGlzIFBDSSBtZW1vcnkgcmVnaW9uIGFyZQ0KPiBnYXRlZCBieSB0aGUgQVhJIHRv
IFBDSWUgd2luZG93cyB3aG9zZSBzaXplIGFuZCBvZmZzZXRzIGFyZSB2YWxpZGF0ZWQuDQo+DQo+
ICAtIFBDSWUgY29uZmlnIHNwYWNlIGlzIG5vdCBuZWNlc3NhcmlseSBhbGlhc2VkIHdpdGggUENJ
ZSBtbWlvIHNwYWNlLg0KPiAgICBJZ25vcmUgdHJhbnNsYXRpb24gYWRkcmVzc2VzIGZvciBjb25m
aWcgc3BhY2Ugd2luZG93cy4NCj4gIC0gTWFrZSB3aW5kb3cgY29uZmlndXJhdGlvbiByZWdpc3Rl
ciB3cml0ZXMgb3JkZXIgaW5kZXBlbmRlbnQuDQo+DQo+ICBUZXN0ZWQgd2l0aCBwY2ktdGVzdGRl
di4NCg0KSSdtIGluIGdlbmVyYWwgbm90IGEgZmFuIG9mIGludHJvZHVjaW5nIHNvbWV0aGluZyBp
biBvbmUgcGF0Y2ggYW5kIHRoZW4gInJld29ya2luZyIgaXQgaW4gYSBsYXRlciBwYXRjaCBpbiB0
aGUgc2FtZSBzZXJpZXMuIEl0J3MgdXN1YWxseSBlYXNpZXIgdG8gdW5kZXJzdGFuZCBhbmQgcmV2
aWV3IGlmIHlvdSBpbXBsZW1lbnQgaXQgdGhlIHJpZ2h0IHdheSB0aGUgZmlyc3QgdGltZS4NCg0K
dGhhbmtzDQotLSBQTU0NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXw0KIFRoZSBwcml2aWxlZ2VkIGNvbmZpZGVudGlhbCBp
bmZvcm1hdGlvbiBjb250YWluZWQgaW4gdGhpcyBlbWFpbCBpcyBpbnRlbmRlZCBmb3IgdXNlIG9u
bHkgYnkgdGhlIGFkZHJlc3NlZXMgYXMgaW5kaWNhdGVkIGJ5IHRoZSBvcmlnaW5hbCBzZW5kZXIg
b2YgdGhpcyBlbWFpbC4gSWYgeW91IGFyZSBub3QgdGhlIGFkZHJlc3NlZSBpbmRpY2F0ZWQgaW4g
dGhpcyBlbWFpbCBvciBhcmUgbm90IHJlc3BvbnNpYmxlIGZvciBkZWxpdmVyeSBvZiB0aGUgZW1h
aWwgdG8gc3VjaCBhIHBlcnNvbiwgcGxlYXNlIGtpbmRseSByZXBseSB0byB0aGUgc2VuZGVyIGlu
ZGljYXRpbmcgdGhpcyBmYWN0IGFuZCBkZWxldGUgYWxsIGNvcGllcyBvZiBpdCBmcm9tIHlvdXIg
Y29tcHV0ZXIgYW5kIG5ldHdvcmsgc2VydmVyIGltbWVkaWF0ZWx5LiBZb3VyIGNvb3BlcmF0aW9u
IGlzIGhpZ2hseSBhcHByZWNpYXRlZC4gSXQgaXMgYWR2aXNlZCB0aGF0IGFueSB1bmF1dGhvcml6
ZWQgdXNlIG9mIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBvZiBOdXZvdG9uIGlzIHN0cmljdGx5
IHByb2hpYml0ZWQ7IGFuZCBhbnkgaW5mb3JtYXRpb24gaW4gdGhpcyBlbWFpbCBpcnJlbGV2YW50
IHRvIHRoZSBvZmZpY2lhbCBidXNpbmVzcyBvZiBOdXZvdG9uIHNoYWxsIGJlIGRlZW1lZCBhcyBu
ZWl0aGVyIGdpdmVuIG5vciBlbmRvcnNlZCBieSBOdXZvdG9uLg0K


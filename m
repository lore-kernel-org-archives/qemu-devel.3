Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C19DCFD2F6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 05:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPD6y-0004fm-Pd; Sat, 29 Nov 2025 00:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vPD6v-0004eh-H6; Sat, 29 Nov 2025 00:03:06 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1vPD6r-0005Fp-ET; Sat, 29 Nov 2025 00:03:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiFruveAwhPjnuZ6y+ekbLNBk0GW5yW5222Q8p9yEaYB6NTwMNq7BaXmJdk3qBCJ4t2foDxjF8ovi6shM5vauCkbiOFYxdBo4yhJ8oT39dYPMo1u0KOX/BBFxPWNdEd0wqU2pGVaeeNtPWFfy+pXEfOuz90yKhBGsJT9kg0vZ4i4+3hv+yGi91EjMlW+jxiqv3GecjN64Su2HH5RknOh8MCKGm7v7QYrfgySa75aB2A2vkAcQd01pNHreZOX/yVos4iHVq7Rq3+pQadAsxZhiA7gJ0Y/XmIzLJRzRzwqTcSUC7iwiam9/ZhRyur23RjtzwO+qeJNMwIXh0VcGHsCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UGV2xUx7qp9fk8oOiq3j/dIn1AdkjATtYAjhlagXnc=;
 b=KoztHbb5E6UqITyOAVnp6fPvo51GWHOAu9IclIsbYf+zy7SLqCWjLbQOx4DtLGWPnPjBvrbEm1QuVuLe2cW31GVBdf+WfT1utkHVAYCiQr+ckuYcwu28eFGybN2Im9Z9HoHmoV6vj8FwdrX8usrY8I+aYmKrceUhAUNRS77TO//MRa5BZO7WNoSAd+kZKBNzCR8rCKeH+BijU10jONMtnQ/HK9npaANEO3KHijtg8xAEt22QJ08S7UtYFFjXCxr8gOq2qLe7Gh0bZBhRzLa3+zhMIipJLLpcpbbAYnzAcWw3MCryNHumiPt+tKSN8o8KUWzaVk0crPzrOetUM809fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UGV2xUx7qp9fk8oOiq3j/dIn1AdkjATtYAjhlagXnc=;
 b=Q7v1dUOqzG1Tk2h8f3ZFGjRZIr42mQd6sT1pIQFG+fdW5G7X30lh/H8JO7TyhIyn3CpcFt2pY+dsnIa2MiiglDBH7p4cw4RTOVDNbo5xqpTLeV/iLaSxeln+x4/1s6Ff9EzcrpDj+v0duf9jGmKcdsUmt+ccNud5ugCDltuptV65Cl8tL/P8vgJEWCaSPR1wm0wv38K8x21iBfZAsrclLBF3zxjCeId3W2wSMFg1EelH+7N9yMM0gQj3HwLLz3Wr7HbSvl9alFrlT7+pYmTS7sBVqyAES7WCGF7Ds71GbCvHk+rlVSpp+T7P7bILmSZFe6hDGeZ6T6ljC5eT9lvt8g==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by JH0PR03MB7343.apcprd03.prod.outlook.com (2603:1096:990:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Sat, 29 Nov
 2025 05:02:52 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e%4]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 05:02:52 +0000
From: =?big5?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmcosWmt9bnFKQ==?=
 <alvinga@andestech.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>,
 =?big5?B?WXVtaW5nIFl1LU1pbmcgQ2hhbmcosWmofLvKKQ==?= <yumin686@andestech.com>
Subject: =?big5?B?pl7C0DogW1BBVENIIDEvMl0gdGFyZ2V0L3Jpc2N2OiBBZGQgJ2RlYnVnX3Zlcicg?=
 =?big5?Q?to_set_version_of_debug_specification?=
Thread-Topic: [PATCH 1/2] target/riscv: Add 'debug_ver' to set version of
 debug specification
Thread-Index: AQHcXqQkGa1btNOfx0GCFRJIXRykf7UE1NcAgAAqG1CAAv1HAIABIDt4
Date: Sat, 29 Nov 2025 05:02:51 +0000
Message-ID: <SEYPR03MB670038CD1CA1A481F4D78C93A8DDA@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20251126071258.4132239-1-alvinga@andestech.com>
 <20251126071258.4132239-2-alvinga@andestech.com>
 <641f8940-968f-423e-86af-c0faed18ff43@ventanamicro.com>
 <SEYPR03MB67009F0B6E81F45D55D6605BA8DEA@SEYPR03MB6700.apcprd03.prod.outlook.com>
 <c29ad506-5c5a-4bd3-816f-ce1617e38fbb@ventanamicro.com>
In-Reply-To: <c29ad506-5c5a-4bd3-816f-ce1617e38fbb@ventanamicro.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|JH0PR03MB7343:EE_
x-ms-office365-filtering-correlation-id: 94fe8f96-8a6b-441a-010d-08de2f048cae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|38070700021|8096899003|7053199007;
x-microsoft-antispam-message-info: =?big5?B?UFl5TVdWeFYxYTR0Z2YxK1YvLzI1ZVZ1TTZzMk82MDdGQ2hjUU9FTkNFT1FKb2hx?=
 =?big5?B?eGJCZHNvLyt5V2hDUUZDN3hWeWV3YVRkYlpHamRHVDdYNUJZMXk0OTJTUkVYK3Ar?=
 =?big5?B?bGFOYm5ERTltbVd0ODlVK3lLUktGcEEweEEzbGxtRG9YUFBOYStXTVZZZytRcHVN?=
 =?big5?B?dllZTTdYQ3VIUWpwNldETlRwenQ3dUdIeFQ4OTZ6VnBSZWhPUG1LeFFVd1FlS3dP?=
 =?big5?B?Y29MZFdkRnpOdWlyQlFjZW9QSUtWRnRYN1psOGFJRCtKTUpWT2ZySWQxRHRYYUQ0?=
 =?big5?B?dG4wMVlyblVQK0x0MlpSbUlJM2VsbTU1Z2dBVmxUYytYUmVDbnMvU1BFd0s5cXcy?=
 =?big5?B?eGlTdHZibEtjUFVYU0lqckFOWHV6MmZqRW1URXcwOGllQTNwT2RudjlxVFduMXdR?=
 =?big5?B?VjltMHhtcFdVdDE2Zy9LcmJTd1FwYzBZNkZrcHpYK1NYNVIvQ0p4UHM3dTJjSk9w?=
 =?big5?B?bXVaTUJRZ0U2TWx6dWVsRkxtRjJDZ2FFTUM2NiszM0JSNWF1TmtTQ0NZVi9GM2RY?=
 =?big5?B?eDRSTGFpdDZ6bHhRRkdYeXFweExLTFEya2doelczQktQLy9oR09Zc2llalpIN0lj?=
 =?big5?B?WmFIb0kxQmtuZFppY0V1SFNwWDJuSTlyQTVMM25jMFowdlJGRE9SS3docE1DNkYv?=
 =?big5?B?MTd0UC9Cb1Q4SkxGODJUOElqcVNZMEQrOGtkeC93dWhvQzRGRmFNVHhwQ3pkL1Mr?=
 =?big5?B?cEp2dHF0UnJtbHY4UzVBa1hGeFNKcTNTM2ZkYUNzV3ZldWp3eWtzRVhnOFFjTVll?=
 =?big5?B?SUlMakU4QUR5K0hyM0dHa0VBOXAwNXZHZnBZZDdxd1ZkME9WSTF1VXBnQ0d5NDR6?=
 =?big5?B?QmFrV1A3d0tiNDBSeWdabXk1d1pOaWtqNkdiMWVEMlJwU09jU3Jkd09XZmdUUWNo?=
 =?big5?B?OTMyVE93a2tzVUxNQTh3clJ3UGZNdmdROVVCc0hGVXF5WTFxeHdlMDhqSWtpV2RJ?=
 =?big5?B?YzFEQjNWY0gvWHBjdGFpSjJucjNlekVlYkxBbjVTZDZxZ00yc3g0Zllhemg3NmRw?=
 =?big5?B?QjFRZ3lMVEtpTGI2VjRPeWtkb3RRV09BWFNZbE9YQUZFMG00VjdDV2ZUZnZpTVl1?=
 =?big5?B?YWxYbXhtcHV6TmxCTEwybHJ5bmo0WVdzblF2blpjLy8wR0MyUUlYTExEWko3R0JF?=
 =?big5?B?b2trLzQxNnpqcGx2b3Bnb2I4NW9jeEhRS3BlbGtLbUE2SzBBbFVtcysxRS9jM2No?=
 =?big5?B?M0JrcVdLUG82blk1bTR6S2ZaaTRpUFkyd0lOMWY1cm0rUWgvZU5jbnoydFN5azNY?=
 =?big5?B?dXpVYm5zTGF4SVFYdi9Kc2xNL1Z2c3FiekdtT0pMV0YvSis5clNvelhoQnFxbTM2?=
 =?big5?B?TEZ1MW5kSzE1V2RNNFN1Q05SSmRjQzQ5OVFpU252SXdXSitxUFhYT0VxUnBQdXhh?=
 =?big5?B?OTBZMDgvVjU0YThnYmZZMmk0eWNZVUl4a3g2ZzVXZU81aDR3bVdlejJjbTdGYlEr?=
 =?big5?B?R1hLK2U2YTBlY3NtZEpqWGtIbXVZNzI2Sk5uWDVDS3ZxT1czOTNlUUxGZFRodkFP?=
 =?big5?B?eWZCV2VtR3cxK2NCQUp6NHJuQzVML3Y3U2ZDbHp1QmdsU1dXdGlTUmxyM04vM2o3?=
 =?big5?B?czBNRmlXNVgwRkQ3Skt4OGFaVE5QZEZxUGp6ZXdzSGgwRFVuRlZLcjZuTHA2eEZ5?=
 =?big5?B?M05uYStNUWI1S0J3UUFjMFMrbGkvZUh5U1Iwbm5Vc3hPSnM3dDdtNllIekZUSm4w?=
 =?big5?B?QlZ4QmcwRmZwMUsyKzFWN2hIeHdiUUhoZG1tVmcwUWM3a2RIbjFIN0tmOTBwV2JR?=
 =?big5?B?aUFlSFFFWDZxaHlac2N6bjN2NTQ3T1BxVUJzWTdnNGk0YksvUThCTjA4ZFVMcUMz?=
 =?big5?B?RjludFkxMHRYVE9KTTR2aktSa0s0Y3VLL3VGaUE0ejQrWkxsTWVudEJEMWs2T2lK?=
 =?big5?Q?J6KaU6XNb+2baTxqvii+T1u/mQdWnFZU6aZPbcToamwHajV9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?NlpIaGpGSTJKWXdmMTRIeGo4enpNZkF2My90eE9QVDZLUnhJdkx3NXlJNEJyZzJw?=
 =?big5?B?Z1U1OUZaQzgrbVZTU2ZNbDYyMGR1ME0yMlloREMzVHR4T3lVTGtld2hHbDZDTGZh?=
 =?big5?B?UlR4U3krNHd1bllFanhHY3dhbmcwQmUyNHBqSUloOG5yZE9LV1JldVBnajkvSE1B?=
 =?big5?B?aWhtS0FMdmNaOFQ3WS9mSjZTK25JZG9CNnR0SEM1TFFOdkRUeGw0OTdQK1FWNXVD?=
 =?big5?B?bzE5eW9iVlUzdXZJYVV0UmlRdkYzNm9kWmtDUFNUZEpONmdaT1Z3TExPNlBEVC8w?=
 =?big5?B?YnBxQmJ5Y0FzTWY0aUVqWjY0Tmt2UlQwdzJPcDZXa2ZNbGRhRkxoUWd0aElTRy9Y?=
 =?big5?B?YWJ6VEduMDBuQlNraVViQW9rT3daTCs3YlJyZVh3R0JtYmRKSzZhdmpOa3RiV0pS?=
 =?big5?B?RFZUYXN2TXVqMk9UTWRxZlBTNjZFaHpoNFV4KzlFdnNLTC9JWWFVd1l6WWt4NS84?=
 =?big5?B?QnpFeGtYVnY4TThQSC9qQ2MvUGhiczZaSWYrT1JjQ0xscjRPUXQzT3dRbWFXczM4?=
 =?big5?B?ekdRSGdWajRXYkVWdkNiL3k5WHgzTDYzNXVqVTkyaU04NXZINGpXcHEzdXNRWVpY?=
 =?big5?B?Q29zRklobmRibmI0a1ZEc3pTVTZLY2xpamFGRUxQakZwU21tSkFJZTR3UlRoeVg2?=
 =?big5?B?T0ZPVDFpZk5NaDNRa005YkZFUVJoOG42WmZXMUttTjFhaEpwaE84djVmMmxxYUlD?=
 =?big5?B?NGhUckQxdy9ORm1KMktDcnB0UVBiQlAzQk9FUmpsZjVhcGt3SFFIaDdKbFNKenFK?=
 =?big5?B?S3d6NGNJNS9iL25LcjJ5NEtZV0xVaWFhcmRZYm03aWlHNVhPbFExQ1Y0WEk1UWts?=
 =?big5?B?STFvektINytBaDBLbFNjbnA3Q1hVT245ME5wOFYyeEJiNnNucHN6WWhGWVMza0pu?=
 =?big5?B?RWNBSkN2QUNvTzl1aU1zS292dnJGcG04TGd2dTR2SVNnbEZDa1lOWk5JOTNvOFZZ?=
 =?big5?B?bDRHK3FmdjlzNnNWaGNBY0RwL1NmOXoyMWNIaUNhbnBWVHV6eEd6eXNpRXdJWUV0?=
 =?big5?B?TmN4UUtQbm9GYnlYSS9rOHowTjZQdVQyeXpORG16RnBIclRFcys4Y1FkSldhQVlY?=
 =?big5?B?SVpvRjhEL2ZubXNNU0xXKzJPcXBFL3M0MUxBdmxqZTV2bysvSVFTVUVJUUJNek9q?=
 =?big5?B?UnBPV0g4RkFDNzA0OUFpcUZmRXlSWDNsUVpzWnFyNGZ4cnV3dFRKdVZ2T3JTVkRu?=
 =?big5?B?Tkd5dms2K3JJc214S3FGNG9wbFpzeDlRenRhR2ZISERicFBRTWVNdVZtSXJHbHJv?=
 =?big5?B?N2c5Z3pRWXdNejFVcHpTOEFqVWs3eWNFSkJwMUZvT1RLakRvaHlERFhNRkMvZEIr?=
 =?big5?B?WVIzQ1p4c3Fpa255cEtEbDRaSXBRbmVqRmh6SG1vRzlwdlkvNUw3V0QvVkg1bE5s?=
 =?big5?B?bUp1YU5CM1d0Tlo2Qy8rbW5IVk5qU0J2V2Y4ZTJzenVpMFdCSUFOaDI4RzVsSG04?=
 =?big5?B?eVN0OUI0T0FaU2dUUS9OWk5wYkg1TmhiN3h4UVBjbWxLdkI4QVZEVktFazkwSmxS?=
 =?big5?B?dWJDZ3N0ZUZYUnFmQ01xU1V6T0dUcGh5Q3ViSm9SeFhmcXBwcUVucndORnhrU1ky?=
 =?big5?B?dWR5dGFoVnl2dzkzU1VMZ1JBOHArS0dEVUFYaG81WnBJT1VQZUtxQ04ramtialNK?=
 =?big5?B?cGJHQXhZWkNBbHp6bDQycStWdGFiVmo5NGE4bVZPc1dnbmozU2NKMmVtaGFxVlhH?=
 =?big5?B?U2JWUUhxbEU3VmNKQmlVV2NjRjlKdmNnWUZHMTBjN1huVXBHUmVHSWhod0RPYURa?=
 =?big5?B?TDltMUZBVktydFZvNlltL2FGQzh2M0xrMDNrYzlsSVNuZlMyVUQ3Z1VVUmJVUlJH?=
 =?big5?B?alVEcVowNDVJYnk0WlNaVEhvcnpUWFdGT3Z6N25xZVpuSys3MDNJRXpOOHZjN0Za?=
 =?big5?B?R1pRUTg5NklFVEVOc3NHL044Q2tBY3gwNXppUkwwMnBOdjF6a2t2S0lqWEJFMDEz?=
 =?big5?B?V1lKVnFkUmVBTjJmeFl0dTZMSDF0aVpEcUUwM21OUVpVRzA3UE5ZQkhLay9tZHA0?=
 =?big5?B?eUhjYWJrT3pIZW1VSFQrbEU3aGdjd3hXSUJyN3I5dlVhOUU0SnZnS2VDZ0RrK2Jn?=
 =?big5?Q?iC2jDKC7Z1g5D0LbmSMMk23IjteNYlCX?=
Content-Type: multipart/alternative;
 boundary="_000_SEYPR03MB670038CD1CA1A481F4D78C93A8DDASEYPR03MB6700apcp_"
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fe8f96-8a6b-441a-010d-08de2f048cae
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2025 05:02:51.9447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXF53DY4ecuuAMHAtYghcLgL+mp970bVlhTHGk68skI3sBZEPz7tNRh9gR0P8BS9CwN+iyf5pWrKLaTr8MTZtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7343
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=alvinga@andestech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: 35
X-Spam_score: 3.5
X-Spam_bar: +++
X-Spam_report: (3.5 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, SPF_HELO_PASS=-0.001,
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

--_000_SEYPR03MB670038CD1CA1A481F4D78C93A8DDASEYPR03MB6700apcp_
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

W0VYVEVSTkFMIE1BSUxdDQoNCk9uIDExLzI2LzI1IDExOjIwIEFNLCBBbHZpbiBDaGUtQ2hpYSBD
aGFuZyixaa31ucUpIHdyb3RlOg0KPiBIaSBEYW5pZWwsDQo+DQo+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPj4gRnJvbTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemEgPGRiYXJib3phQHZl
bnRhbmFtaWNyby5jb20+DQo+PiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDI2LCAyMDI1IDc6
MzggUE0NCj4+IFRvOiBBbHZpbiBDaGUtQ2hpYSBDaGFuZyixaa31ucUpIDxhbHZpbmdhQGFuZGVz
dGVjaC5jb20+Ow0KPj4gcWVtdS1yaXNjdkBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5v
cmcNCj4+IENjOiBhbGlzdGFpci5mcmFuY2lzQHdkYy5jb207IGJpbi5tZW5nQHdpbmRyaXZlci5j
b207DQo+PiBsaXdlaTE1MThAZ21haWwuY29tOyB6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29t
OyBZdW1pbmcgWXUtTWluZw0KPj4gQ2hhbmcosWmofLvKKSA8eXVtaW42ODZAYW5kZXN0ZWNoLmNv
bT4NCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSB0YXJnZXQvcmlzY3Y6IEFkZCAnZGVidWdf
dmVyJyB0byBzZXQgdmVyc2lvbiBvZiBkZWJ1Zw0KPj4gc3BlY2lmaWNhdGlvbg0KPj4NCj4+IFtF
WFRFUk5BTCBNQUlMXQ0KPj4NCj4+IEhpLA0KPj4NCj4+DQo+PiBUaGVyZSBhcmUgMiBwb2ludHMg
SSB3b3VsZCBsaWtlIHRvIGJyaW5nIGhlcmUuIEZpcnN0IGlzIHRoZSBhZGRpdGlvbiBvZiBhIG5l
dw0KPj4gc3RyaW5nIHByb3BlcnR5Lg0KPj4NCj4+IEFsdGhvdWdoIGl0J3Mgbm90IGZvcmJpZGRl
biwgYW5kIGluIGZhY3Qgd2UgaGF2ZSBzdHJpbmcgcHJvcGVydGllcyBpbiBSSVNDLVYgQ1BVDQo+
PiBjb2RlICh3aGljaCBJJ2xsIGJlIGRlYWxpbmcgd2l0aCBpbiB0aGUgbmV4dCBRRU1VIGN5Y2xl
KSwgd2Ugd291bGQgbGlrZSB0bw0KPj4gYXZvaWQgYWRkaW5nIG5ldyBzdHIgcHJvcHMuIFRoZSBy
ZWFzb24gaXMgdGhhdCBzdHIgcHJvcHMgYXJlIGhhcmRlciB0byB3b3JrIHdpdGgNCj4+IGluIG1h
bmFnZW1lbnQgbGF5ZXJzIChlLmcuIGxpYnZpcnQpIGFuZCB0byBleHBvc2UgaW4gUU1QLg0KPj4N
Cj4+IEkgc3VnZ2VzdCB1c2luZyBib29sZWFucyBpbnN0ZWFkLiBUaGV5IGFyZSB3YXkgZWFzaWVy
IHRvIHdvcmsgd2l0aCBpbiB0aGUgdXBwZXINCj4+IGxheWVycyBhbmQgd2UgZG9uJ3QgaGF2ZSB0
byBtYWludGFpbiBzdHJpbmcgcGFyc2luZyBjb2RlIGFzIHdlbGwuIEluc3RlYWQgb2YNCj4+IGFk
ZGluZyBhICdkZWJ1Z192ZXInIHN0cmluZyBwcm9wIGFuZCBwYXJzZSB2YWx1ZXMsIGFkZCB0d28g
Ym9vbCBwcm9wZXJ0aWVzOg0KPj4gZGVidWctMC4xMyBhbmQgZGVidWctMS4wLg0KPg0KPiBVc2lu
ZyB0d28gYm9vbCBwcm9wZXJ0aWVzIGluc3RlYWQgb2Ygc3RyaW5nIHByb3BlcnRpZXMgaXMgb2th
eSB0byB1cy4NCj4gVGhhbmsgeW91IGZvciBndWlkaW5nIHVzIHRoaXMgY29uY2Vybi4NCj4NCj4+
DQo+PiBTZWNvbmQsIHdlIGhhdmUgYSAnZGVidWcnIGZsYWcgdGhhdCBpcyBzZXQgdG8gZGVmYXVs
dCAndHJ1ZScuIEZyb20gd2hhdCBJJ20NCj4+IHJlYWRpbmcgaW4gdGhpcyBwYXRjaCB0aGUgZXhp
c3RpbmcgZmxhZyB3b3VsZCBiZSBlcXVpdmFsZW50IHRvICdkZWJ1Zy0wLjEzJw0KPj4gSSBwcm9w
b3NlZCBhYm92ZS4gSW4gdGhpcyBjYXNlIHdlIGNhbiBrZWVwIHRoZSBleGlzdGluZyBmbGFnIGFu
ZCBhZGQgYSBzaW5nbGUNCj4+ICdkZWJ1Zy0xLjAnIGZsYWcgdG8gaW5kaWNhdGUgdGhhdCB0aGUg
dXNlciB3YW50cyB0byB1c2UgdjEuMCBpbnN0ZWFkIG9mIHYwLjEzLg0KPg0KPiBJIHdvdWxkIHBy
ZWZlciByZW5hbWluZyBleGlzdGluZyAnZGVidWcnIGZsYWcgdG8gJ2RlYnVnLXYwLjEzJyBhbmQg
YWRkaW5nIG5ldyBmbGFnICdkZWJ1Zy12MS4wJyBpbiBvcmRlciBub3QgdG8gY29uZnVzZSB1c2Vy
cy4NCj4gSG93IHNob3VsZCB3ZSBoYW5kbGUgdGhlIHNpdHVhdGlvbiBpZiB1c2VyIHByb3ZpZGVz
IGJvdGggZGVidWctdjAuMTM9dHJ1ZSxkZWJ1Zy12MS4wPXRydWUgPw0KPiBTaG91bGQgd2UgdGhy
b3cgYW4gZXJyb3Igb3IgdHJlYXQgdGhpcyBzaXR1YXRpb24gYXMgaWYgb25seSBkZWJ1Zy12MS4w
PXRydWUgPw0KDQpXaGF0IHlvdSBkaWQgaW4gdjIgd29ya3MgZm9yIG1lLiBUaGUgaGFuZGxpbmcg
b2YgYm90aCAnZGVidWcnIGFuZCAnZGVidWctMS4wJyBpcw0KbW9zdGx5IGEgYmFja2VuZCBkZWNp
c2lvbiB0aGF0IHdlJ3JlIGZyZWUgdG8gbWFrZSwgYXMgbG9uZyBhcyB3ZSdyZSBoYXZpbmcNCmNv
bW1vbiBzZW5zZSBpbiBob3cgdGhlIGZsYWcgZGlzYWJsZS9lbmFibGUgZmVhdHVyZXMuDQoNCkFz
IGZvciByZW5hbWluZy9yZW1vdmluZyBleGlzdGluZyBmbGFncyBhbmQgcHJvcGVydGllcywgd2Ug
Y2FuJ3QgcmVuYW1lL2RlbGV0ZQ0KZXhpc3Rpbmcgc3R1ZmYgdW5sZXNzIHdlIGdvIHRocm91Z2gg
YSBkZXByZWNhdGlvbiBjeWNsZSAoYWRkIHRoZSBmbGFncyBpbg0KZGVwcmVjYXRlZC5yc3QsIGZs
YWcgaXMgcmVtb3ZlZCBvbmUgeWVhciBsYXRlcikuIFdlIGRvIHRoaXMgYmVjYXVzZSB0aGVyZQ0K
YXJlIGV4aXN0aW5nIHVzZXJzIGFuZCBhcHBzIHRoYXQgY2FuIGJlIGNvbXByb21pc2VkIHdoZW4g
d2UgZGVsZXRlL2NoYW5nZQ0Kb3B0aW9ucyBmcm9tIHRoZSBjb21tYW5kIGxpbmUuDQpZb3UncmUg
cmlnaHQuIEkgcmVjb25zaWRlcmVkIGl0IGFuZCBkZWNpZGVkIG5vdCB0byByZW5hbWUgJ2RlYnVn
Jy4NCg0KUmVnYXJkcywNCkFsdmluDQoNCg0KVGhhbmtzLA0KDQpEYW5pZWwNCg0KPg0KPg0KPiBT
aW5jZXJlbHksDQo+IEFsdmluIENoYW5nDQo+DQo+Pg0KPj4NCj4+IFRoYW5rcywNCj4+DQo+PiBE
YW5pZWwNCj4+DQo+Pg0KPj4NCj4+IE9uIDExLzI2LzI1IDQ6MTIgQU0sIEFsdmluIENoYW5nIHdy
b3RlOg0KPj4+IFRoZSBzaW1pbGFyIGNvbnRyb2wgZGlkIGluICdwcml2X3NwZWMnIGFuZCAndmV4
dF9zcGVjJyBub3cgaXMNCj4+PiBhdmFpbGFibGUgZm9yIHZlcnNpb24gb2YgZGVidWcgc3BlY2lm
aWNhdGlvbi4gQ3VycmVudGx5IHdlIGFjY2VwdA0KPj4+ICJ2MC4xMyIgYW5kICJ2MS4wIiB2ZXJz
aW9ucy4gVXNlcnMgY2FuIHByb3ZpZGUgJ2RlYnVnX3NwZWMnIGludG8gQ1BVDQo+Pj4gb3B0aW9u
IHRvIHNldCBpbnRlbmRlZCB2ZXJzaW9uIG9mIHRoZSBkZWJ1ZyBzcGVjaWZpY2F0aW9uLg0KPj4+
DQo+Pj4gRm9yIGV4YW1wbGVzOg0KPj4+IDEuIC1jcHUgbWF4LGRlYnVnX3NwZWM9djAuMTMNCj4+
PiAyLiAtY3B1IG1heCxkZWJ1Z19zcGVjPXYxLjANCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFs
dmluIENoYW5nIDxhbHZpbmdhQGFuZGVzdGVjaC5jb20+DQo+Pj4gUmV2aWV3ZWQtYnk6IFl1LU1p
bmcgQ2hhbmcgPHl1bWluNjg2QGFuZGVzdGVjaC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgdGFyZ2V0
L3Jpc2N2L2NwdS5jICAgICAgICAgfCA2OQ0KPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4+PiAgICB0YXJnZXQvcmlzY3YvY3B1LmggICAgICAgICB8IDEzICsrKysr
KysNCj4+PiAgICB0YXJnZXQvcmlzY3YvbWFjaGluZS5jICAgICB8ICA1ICstLQ0KPj4+ICAgIHRh
cmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jIHwgIDMgKysNCj4+PiAgICA0IGZpbGVzIGNoYW5nZWQs
IDg4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L3Jpc2N2L2NwdS5jIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jIGluZGV4DQo+Pj4gNzNkNDI4
MC4uZGJjZGZjZCAxMDA2NDQNCj4+PiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMNCj4+PiArKysg
Yi90YXJnZXQvcmlzY3YvY3B1LmMNCj4+PiBAQCAtMTEyMyw2ICsxMTIzLDcgQEAgc3RhdGljIHZv
aWQgcmlzY3ZfY3B1X2luaXQoT2JqZWN0ICpvYmopDQo+Pj4gICAgICAgIGNwdS0+Y2ZnLnBtcF9y
ZWdpb25zID0gMTY7DQo+Pj4gICAgICAgIGNwdS0+Y2ZnLnBtcF9ncmFudWxhcml0eSA9IE1JTl9S
SVNDVl9QTVBfR1JBTlVMQVJJVFk7DQo+Pj4gICAgICAgIGNwdS0+ZW52LnZleHRfdmVyID0gVkVY
VF9WRVJTSU9OXzFfMDBfMDsNCj4+PiArICAgIGNwdS0+ZW52LmRlYnVnX3ZlciA9IERFQlVHX1ZF
UlNJT05fMF8xM18wOw0KPj4+ICAgICAgICBjcHUtPmNmZy5tYXhfc2F0cF9tb2RlID0gLTE7DQo+
Pj4NCj4+PiAgICAgICAgaWYgKG1jYy0+ZGVmLT5wcm9maWxlKSB7DQo+Pj4gQEAgLTExMzgsNiAr
MTEzOSw5IEBAIHN0YXRpYyB2b2lkIHJpc2N2X2NwdV9pbml0KE9iamVjdCAqb2JqKQ0KPj4+ICAg
ICAgICBpZiAobWNjLT5kZWYtPnZleHRfc3BlYyAhPSBSSVNDVl9QUk9GSUxFX0FUVFJfVU5VU0VE
KSB7DQo+Pj4gICAgICAgICAgICBjcHUtPmVudi52ZXh0X3ZlciA9IG1jYy0+ZGVmLT52ZXh0X3Nw
ZWM7DQo+Pj4gICAgICAgIH0NCj4+PiArICAgIGlmIChtY2MtPmRlZi0+ZGVidWdfc3BlYyAhPSBS
SVNDVl9QUk9GSUxFX0FUVFJfVU5VU0VEKSB7DQo+Pj4gKyAgICAgICAgY3B1LT5lbnYuZGVidWdf
dmVyID0gbWNjLT5kZWYtPmRlYnVnX3NwZWM7DQo+Pj4gKyAgICB9DQo+Pj4gICAgI2lmbmRlZiBD
T05GSUdfVVNFUl9PTkxZDQo+Pj4gICAgICAgIGlmIChtY2MtPmRlZi0+Y3VzdG9tX2NzcnMpIHsN
Cj4+PiAgICAgICAgICAgIHJpc2N2X3JlZ2lzdGVyX2N1c3RvbV9jc3JzKGNwdSwgbWNjLT5kZWYt
PmN1c3RvbV9jc3JzKTsgQEANCj4+PiAtMTcyMCw2ICsxNzI0LDY2IEBAIHN0YXRpYyBjb25zdCBQ
cm9wZXJ0eUluZm8gcHJvcF9wcml2X3NwZWMgPSB7DQo+Pj4gICAgICAgIC5zZXQgPSBwcm9wX3By
aXZfc3BlY19zZXQsDQo+Pj4gICAgfTsNCj4+Pg0KPj4+ICtzdGF0aWMgaW50IGRlYnVnX3NwZWNf
ZnJvbV9zdHIoY29uc3QgY2hhciAqZGVidWdfc3BlY19zdHIpIHsNCj4+PiArICAgIGludCBkZWJ1
Z192ZXJzaW9uID0gLTE7DQo+Pj4gKw0KPj4+ICsgICAgaWYgKCFnX3N0cmNtcDAoZGVidWdfc3Bl
Y19zdHIsIERFQlVHX1ZFUl8wXzEzXzBfU1RSKSkgew0KPj4+ICsgICAgICAgIGRlYnVnX3ZlcnNp
b24gPSBERUJVR19WRVJTSU9OXzBfMTNfMDsNCj4+PiArICAgIH0gZWxzZSBpZiAoIWdfc3RyY21w
MChkZWJ1Z19zcGVjX3N0ciwgREVCVUdfVkVSXzFfMDBfMF9TVFIpKSB7DQo+Pj4gKyAgICAgICAg
ZGVidWdfdmVyc2lvbiA9IERFQlVHX1ZFUlNJT05fMV8wMF8wOw0KPj4+ICsgICAgfQ0KPj4+ICsN
Cj4+PiArICAgIHJldHVybiBkZWJ1Z192ZXJzaW9uOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtzdGF0
aWMgY29uc3QgY2hhciAqZGVidWdfc3BlY190b19zdHIoaW50IGRlYnVnX3ZlcnNpb24pIHsNCj4+
PiArICAgIHN3aXRjaCAoZGVidWdfdmVyc2lvbikgew0KPj4+ICsgICAgY2FzZSBERUJVR19WRVJT
SU9OXzBfMTNfMDoNCj4+PiArICAgICAgICByZXR1cm4gREVCVUdfVkVSXzBfMTNfMF9TVFI7DQo+
Pj4gKyAgICBjYXNlIERFQlVHX1ZFUlNJT05fMV8wMF8wOg0KPj4+ICsgICAgICAgIHJldHVybiBE
RUJVR19WRVJfMV8wMF8wX1NUUjsNCj4+PiArICAgIGRlZmF1bHQ6DQo+Pj4gKyAgICAgICAgcmV0
dXJuIE5VTEw7DQo+Pj4gKyAgICB9DQo+Pj4gK30NCj4+PiArDQo+Pj4gK3N0YXRpYyB2b2lkIHBy
b3BfZGVidWdfc3BlY19zZXQoT2JqZWN0ICpvYmosIFZpc2l0b3IgKnYsIGNvbnN0IGNoYXIgKm5h
bWUsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLCBF
cnJvciAqKmVycnApIHsNCj4+PiArICAgIFJJU0NWQ1BVICpjcHUgPSBSSVNDVl9DUFUob2JqKTsN
Cj4+PiArICAgIGdfYXV0b2ZyZWUgY2hhciAqdmFsdWUgPSBOVUxMOw0KPj4+ICsgICAgaW50IGRl
YnVnX3ZlcnNpb24gPSAtMTsNCj4+PiArDQo+Pj4gKyAgICB2aXNpdF90eXBlX3N0cih2LCBuYW1l
LCAmdmFsdWUsIGVycnApOw0KPj4+ICsNCj4+PiArICAgIGRlYnVnX3ZlcnNpb24gPSBkZWJ1Z19z
cGVjX2Zyb21fc3RyKHZhbHVlKTsNCj4+PiArICAgIGlmIChkZWJ1Z192ZXJzaW9uIDwgMCkgew0K
Pj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlVuc3VwcG9ydGVkIGRlYnVnIHNwZWMgdmVy
c2lvbiAnJXMnIiwgdmFsdWUpOw0KPj4+ICsgICAgICAgIHJldHVybjsNCj4+PiArICAgIH0NCj4+
PiArDQo+Pj4gKyAgICBjcHVfb3B0aW9uX2FkZF91c2VyX3NldHRpbmcobmFtZSwgZGVidWdfdmVy
c2lvbik7DQo+Pj4gKyAgICBjcHUtPmVudi5kZWJ1Z192ZXIgPSBkZWJ1Z192ZXJzaW9uOyB9DQo+
Pj4gKw0KPj4+ICtzdGF0aWMgdm9pZCBwcm9wX2RlYnVnX3NwZWNfZ2V0KE9iamVjdCAqb2JqLCBW
aXNpdG9yICp2LCBjb25zdCBjaGFyICpuYW1lLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQgKm9wYXF1ZSwgRXJyb3IgKiplcnJwKSB7DQo+Pj4gKyAgICBSSVNDVkNQ
VSAqY3B1ID0gUklTQ1ZfQ1BVKG9iaik7DQo+Pj4gKyAgICBjb25zdCBjaGFyICp2YWx1ZSA9IGRl
YnVnX3NwZWNfdG9fc3RyKGNwdS0+ZW52LmRlYnVnX3Zlcik7DQo+Pj4gKw0KPj4+ICsgICAgdmlz
aXRfdHlwZV9zdHIodiwgbmFtZSwgKGNoYXIgKiopJnZhbHVlLCBlcnJwKTsgfQ0KPj4+ICsNCj4+
PiArc3RhdGljIGNvbnN0IFByb3BlcnR5SW5mbyBwcm9wX2RlYnVnX3NwZWMgPSB7DQo+Pj4gKyAg
ICAudHlwZSA9ICJzdHIiLA0KPj4+ICsgICAgLmRlc2NyaXB0aW9uID0gImRlYnVnX3NwZWMiLA0K
Pj4+ICsgICAgLmdldCA9IHByb3BfZGVidWdfc3BlY19nZXQsDQo+Pj4gKyAgICAuc2V0ID0gcHJv
cF9kZWJ1Z19zcGVjX3NldCwNCj4+PiArfTsNCj4+PiArDQo+Pj4gICAgc3RhdGljIHZvaWQgcHJv
cF92ZXh0X3NwZWNfc2V0KE9iamVjdCAqb2JqLCBWaXNpdG9yICp2LCBjb25zdCBjaGFyICpuYW1l
LA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpvcGFxdWUsIEVy
cm9yICoqZXJycCkNCj4+PiAgICB7DQo+Pj4gQEAgLTI2NDgsNiArMjcxMiw3IEBAIHN0YXRpYyBj
b25zdCBQcm9wZXJ0eSByaXNjdl9jcHVfcHJvcGVydGllc1tdID0gew0KPj4+DQo+Pj4gICAgICAg
IHsubmFtZSA9ICJwcml2X3NwZWMiLCAuaW5mbyA9ICZwcm9wX3ByaXZfc3BlY30sDQo+Pj4gICAg
ICAgIHsubmFtZSA9ICJ2ZXh0X3NwZWMiLCAuaW5mbyA9ICZwcm9wX3ZleHRfc3BlY30sDQo+Pj4g
KyAgICB7Lm5hbWUgPSAiZGVidWdfc3BlYyIsIC5pbmZvID0gJnByb3BfZGVidWdfc3BlY30sDQo+
Pj4NCj4+PiAgICAgICAgey5uYW1lID0gInZsZW4iLCAuaW5mbyA9ICZwcm9wX3ZsZW59LA0KPj4+
ICAgICAgICB7Lm5hbWUgPSAiZWxlbiIsIC5pbmZvID0gJnByb3BfZWxlbn0sIEBAIC0yODE4LDYg
KzI4ODMsMTAgQEANCj4+PiBzdGF0aWMgdm9pZCByaXNjdl9jcHVfY2xhc3NfYmFzZV9pbml0KE9i
amVjdENsYXNzICpjLCBjb25zdCB2b2lkICpkYXRhKQ0KPj4+ICAgICAgICAgICAgICAgIGFzc2Vy
dChkZWYtPnZleHRfc3BlYyAhPSAwKTsNCj4+PiAgICAgICAgICAgICAgICBtY2MtPmRlZi0+dmV4
dF9zcGVjID0gZGVmLT52ZXh0X3NwZWM7DQo+Pj4gICAgICAgICAgICB9DQo+Pj4gKyAgICAgICAg
aWYgKGRlZi0+ZGVidWdfc3BlYyAhPSBSSVNDVl9QUk9GSUxFX0FUVFJfVU5VU0VEKSB7DQo+Pj4g
KyAgICAgICAgICAgIGFzc2VydChkZWYtPmRlYnVnX3NwZWMgPD0gREVCVUdfVkVSU0lPTl9MQVRF
U1QpOw0KPj4+ICsgICAgICAgICAgICBtY2MtPmRlZi0+ZGVidWdfc3BlYyA9IGRlZi0+ZGVidWdf
c3BlYzsNCj4+PiArICAgICAgICB9DQo+Pj4gICAgICAgICAgICBtY2MtPmRlZi0+bWlzYV9leHQg
fD0gZGVmLT5taXNhX2V4dDsNCj4+Pg0KPj4+ICAgICAgICAgICAgcmlzY3ZfY3B1X2NmZ19tZXJn
ZSgmbWNjLT5kZWYtPmNmZywgJmRlZi0+Y2ZnKTsgZGlmZiAtLWdpdA0KPj4+IGEvdGFyZ2V0L3Jp
c2N2L2NwdS5oIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oIGluZGV4IDM2ZTdmMTAuLmZjMWFlN2MNCj4+
PiAxMDA2NDQNCj4+PiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmgNCj4+PiArKysgYi90YXJnZXQv
cmlzY3YvY3B1LmgNCj4+PiBAQCAtMTAwLDYgKzEwMCw3IEBAIHR5cGVkZWYgc3RydWN0IHJpc2N2
X2NwdV9wcm9maWxlIHsNCj4+PiAgICAgICAgYm9vbCBwcmVzZW50Ow0KPj4+ICAgICAgICBib29s
IHVzZXJfc2V0Ow0KPj4+ICAgICAgICBpbnQgcHJpdl9zcGVjOw0KPj4+ICsgICAgaW50IGRlYnVn
X3NwZWM7DQo+Pj4gICAgICAgIGludCBzYXRwX21vZGU7DQo+Pj4gICAgICAgIGNvbnN0IGludDMy
X3QgZXh0X29mZnNldHNbXTsNCj4+PiAgICB9IFJJU0NWQ1BVUHJvZmlsZTsNCj4+PiBAQCAtMTIz
LDYgKzEyNCwxNiBAQCBlbnVtIHsNCj4+PiAgICAgICAgUFJJVl9WRVJTSU9OX0xBVEVTVCA9IFBS
SVZfVkVSU0lPTl8xXzEzXzAsDQo+Pj4gICAgfTsNCj4+Pg0KPj4+ICsvKiBEZWJ1ZyBzcGVjaWZp
Y2F0aW9uIHZlcnNpb24gKi8NCj4+PiArI2RlZmluZSBERUJVR19WRVJfMF8xM18wX1NUUiAidjAu
MTMiDQo+Pj4gKyNkZWZpbmUgREVCVUdfVkVSXzFfMDBfMF9TVFIgInYxLjAiDQo+Pj4gK2VudW0g
ew0KPj4+ICsgICAgREVCVUdfVkVSU0lPTl8wXzEzXzAgPSAwLA0KPj4+ICsgICAgREVCVUdfVkVS
U0lPTl8xXzAwXzAsDQo+Pj4gKw0KPj4+ICsgICAgREVCVUdfVkVSU0lPTl9MQVRFU1QgPSBERUJV
R19WRVJTSU9OXzFfMDBfMCwgfTsNCj4+PiArDQo+Pj4gICAgI2RlZmluZSBWRVhUX1ZFUlNJT05f
MV8wMF8wIDB4MDAwMTAwMDANCj4+PiAgICAjZGVmaW5lIFZFWFRfVkVSXzFfMDBfMF9TVFIgInYx
LjAiDQo+Pj4NCj4+PiBAQCAtMjQ1LDYgKzI1Niw3IEBAIHN0cnVjdCBDUFVBcmNoU3RhdGUgew0K
Pj4+DQo+Pj4gICAgICAgIHRhcmdldF91bG9uZyBwcml2X3ZlcjsNCj4+PiAgICAgICAgdGFyZ2V0
X3Vsb25nIHZleHRfdmVyOw0KPj4+ICsgICAgdGFyZ2V0X3Vsb25nIGRlYnVnX3ZlcjsNCj4+Pg0K
Pj4+ICAgICAgICAvKiBSSVNDVk1YTCwgYnV0IHVpbnQzMl90IGZvciB2bXN0YXRlIG1pZ3JhdGlv
biAqLw0KPj4+ICAgICAgICB1aW50MzJfdCBtaXNhX214bDsgICAgICAvKiBjdXJyZW50IG14bCAq
Lw0KPj4+IEBAIC01NjMsNiArNTc1LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgUklTQ1ZDUFVEZWYgew0K
Pj4+ICAgICAgICB1aW50MzJfdCBtaXNhX2V4dDsNCj4+PiAgICAgICAgaW50IHByaXZfc3BlYzsN
Cj4+PiAgICAgICAgaW50MzJfdCB2ZXh0X3NwZWM7DQo+Pj4gKyAgICBpbnQgZGVidWdfc3BlYzsN
Cj4+PiAgICAgICAgUklTQ1ZDUFVDb25maWcgY2ZnOw0KPj4+ICAgICAgICBib29sIGJhcmU7DQo+
Pj4gICAgICAgIGNvbnN0IFJJU0NWQ1NSICpjdXN0b21fY3NyczsNCj4+PiBkaWZmIC0tZ2l0IGEv
dGFyZ2V0L3Jpc2N2L21hY2hpbmUuYyBiL3RhcmdldC9yaXNjdi9tYWNoaW5lLmMgaW5kZXgNCj4+
PiAxOGQ3OTBhLi44NjU4ZjU1IDEwMDY0NA0KPj4+IC0tLSBhL3RhcmdldC9yaXNjdi9tYWNoaW5l
LmMNCj4+PiArKysgYi90YXJnZXQvcmlzY3YvbWFjaGluZS5jDQo+Pj4gQEAgLTQyNyw4ICs0Mjcs
OCBAQCBzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfc3N0YyA9IHsNCj4+
Pg0KPj4+ICAgIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX3Jpc2N2X2NwdSA9IHsN
Cj4+PiAgICAgICAgLm5hbWUgPSAiY3B1IiwNCj4+PiAtICAgIC52ZXJzaW9uX2lkID0gMTAsDQo+
Pj4gLSAgICAubWluaW11bV92ZXJzaW9uX2lkID0gMTAsDQo+Pj4gKyAgICAudmVyc2lvbl9pZCA9
IDExLA0KPj4+ICsgICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDExLA0KPj4+ICAgICAgICAucG9z
dF9sb2FkID0gcmlzY3ZfY3B1X3Bvc3RfbG9hZCwNCj4+PiAgICAgICAgLmZpZWxkcyA9IChjb25z
dCBWTVN0YXRlRmllbGRbXSkgew0KPj4+ICAgICAgICAgICAgVk1TVEFURV9VSU5UVExfQVJSQVko
ZW52LmdwciwgUklTQ1ZDUFUsIDMyKSwgQEAgLTQ0Myw2DQo+Pj4gKzQ0Myw3IEBAIGNvbnN0IFZN
U3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX3Jpc2N2X2NwdSA9IHsNCj4+PiAgICAgICAgICAgIFZN
U1RBVEVfVUlOVFRMKGVudi5ndWVzdF9waHlzX2ZhdWx0X2FkZHIsIFJJU0NWQ1BVKSwNCj4+PiAg
ICAgICAgICAgIFZNU1RBVEVfVUlOVFRMKGVudi5wcml2X3ZlciwgUklTQ1ZDUFUpLA0KPj4+ICAg
ICAgICAgICAgVk1TVEFURV9VSU5UVEwoZW52LnZleHRfdmVyLCBSSVNDVkNQVSksDQo+Pj4gKyAg
ICAgICAgVk1TVEFURV9VSU5UVEwoZW52LmRlYnVnX3ZlciwgUklTQ1ZDUFUpLA0KPj4+ICAgICAg
ICAgICAgVk1TVEFURV9VSU5UMzIoZW52Lm1pc2FfbXhsLCBSSVNDVkNQVSksDQo+Pj4gICAgICAg
ICAgICBWTVNUQVRFX1VJTlQzMihlbnYubWlzYV9leHQsIFJJU0NWQ1BVKSwNCj4+PiAgICAgICAg
ICAgIFZNU1RBVEVfVU5VU0VEKDQpLA0KPj4+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNn
L3RjZy1jcHUuYyBiL3RhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jDQo+Pj4gaW5kZXggZDM5Njgy
NS4uMTYwZmNmMSAxMDA2NDQNCj4+PiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuYw0K
Pj4+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jDQo+Pj4gQEAgLTE1OTgsNiArMTU5
OCw5IEBAIHN0YXRpYyB2b2lkIHJpc2N2X2luaXRfbWF4X2NwdV9leHRlbnNpb25zKE9iamVjdA0K
Pj4gKm9iaikNCj4+PiAgICAgICAgLyogc2V0IHZlY3RvciB2ZXJzaW9uICovDQo+Pj4gICAgICAg
IGVudi0+dmV4dF92ZXIgPSBWRVhUX1ZFUlNJT05fMV8wMF8wOw0KPj4+DQo+Pj4gKyAgICAvKiBT
ZXQgZGVidWcgdmVyc2lvbiAqLw0KPj4+ICsgICAgZW52LT5kZWJ1Z192ZXIgPSBERUJVR19WRVJT
SU9OXzBfMTNfMDsNCj4+PiArDQo+Pj4gICAgICAgIC8qIFpmaW54IGlzIG5vdCBjb21wYXRpYmxl
IHdpdGggRi4gRGlzYWJsZSBpdCAqLw0KPj4+ICAgICAgICBpc2FfZXh0X3VwZGF0ZV9lbmFibGVk
KGNwdSwgQ1BVX0NGR19PRkZTRVQoZXh0X3pmaW54KSwgZmFsc2UpOw0KPj4+ICAgICAgICBpc2Ff
ZXh0X3VwZGF0ZV9lbmFibGVkKGNwdSwgQ1BVX0NGR19PRkZTRVQoZXh0X3pkaW54KSwgZmFsc2Up
Ow0KPg0KPiBDT05GSURFTlRJQUxJVFkgTk9USUNFOg0KPg0KPiBUaGlzIGUtbWFpbCAoYW5kIGl0
cyBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZCBsZWdhbGx5IHByaXZp
bGVnZWQgaW5mb3JtYXRpb24gb3IgaW5mb3JtYXRpb24gcHJvdGVjdGVkIGZyb20gZGlzY2xvc3Vy
ZS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBoZXJlYnkg
bm90aWZpZWQgdGhhdCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0aW9uLCBvciB1
c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaXMgc3RyaWN0bHkgcHJvaGli
aXRlZC4gSW4gdGhpcyBjYXNlLCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIg
YnkgcmV0dXJuIGUtbWFpbCwgZGVsZXRlIHRoZSBtZXNzYWdlIChhbmQgYW55IGFjY29tcGFueWlu
ZyBkb2N1bWVudHMpIGFuZCBkZXN0cm95IGFsbCBwcmludGVkIGhhcmQgY29waWVzLiBUaGFuayB5
b3UgZm9yIHlvdXIgY29vcGVyYXRpb24uDQo+DQo+IENvcHlyaWdodCBBTkRFUyBURUNITk9MT0dZ
IENPUlBPUkFUSU9OIC0gQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCg0KDQpDT05GSURFTlRJQUxJVFkg
Tk9USUNFOg0KDQpUaGlzIGUtbWFpbCAoYW5kIGl0cyBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4g
Y29uZmlkZW50aWFsIGFuZCBsZWdhbGx5IHByaXZpbGVnZWQgaW5mb3JtYXRpb24gb3IgaW5mb3Jt
YXRpb24gcHJvdGVjdGVkIGZyb20gZGlzY2xvc3VyZS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVu
ZGVkIHJlY2lwaWVudCwgeW91IGFyZSBoZXJlYnkgbm90aWZpZWQgdGhhdCBhbnkgZGlzY2xvc3Vy
ZSwgY29weWluZywgZGlzdHJpYnV0aW9uLCBvciB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRh
aW5lZCBoZXJlaW4gaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSW4gdGhpcyBjYXNlLCBwbGVhc2Ug
aW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmV0dXJuIGUtbWFpbCwgZGVsZXRlIHRo
ZSBtZXNzYWdlIChhbmQgYW55IGFjY29tcGFueWluZyBkb2N1bWVudHMpIGFuZCBkZXN0cm95IGFs
bCBwcmludGVkIGhhcmQgY29waWVzLiBUaGFuayB5b3UgZm9yIHlvdXIgY29vcGVyYXRpb24uDQoN
CkNvcHlyaWdodCBBTkRFUyBURUNITk9MT0dZIENPUlBPUkFUSU9OIC0gQWxsIFJpZ2h0cyBSZXNl
cnZlZC4NCg==

--_000_SEYPR03MB670038CD1CA1A481F4D78C93A8DDASEYPR03MB6700apcp_
Content-Type: text/html; charset="big5"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">[EXTERNAL MAIL]</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof"><br>
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">On 11/26/25 11:20 AM, Alvin Che-Chia Chang(=B1i=AD=F5=B9=C5) wrote=
:</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; Hi Daniel,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; -----Original Message-----</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; From: Daniel Henrique Barboza &lt;dbarboza@ventanamicro.c=
om&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; Sent: Wednesday, November 26, 2025 7:38 PM</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; To: Alvin Che-Chia Chang(=B1i=AD=F5=B9=C5) &lt;alvinga@an=
destech.com&gt;;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; qemu-riscv@nongnu.org; qemu-devel@nongnu.org</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; Cc: alistair.francis@wdc.com; bin.meng@windriver.com;</di=
v>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; liwei1518@gmail.com; zhiwei_liu@linux.alibaba.com; Yuming=
 Yu-Ming</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; Chang(=B1i=A8|=BB=CA) &lt;yumin686@andestech.com&gt;</div=
>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; Subject: Re: [PATCH 1/2] target/riscv: Add 'debug_ver' to=
 set version of debug</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; specification</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; [EXTERNAL MAIL]</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; Hi,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; There are 2 points I would like to bring here. First is t=
he addition of a new</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; string property.</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; Although it's not forbidden, and in fact we have string p=
roperties in RISC-V CPU</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; code (which I'll be dealing with in the next QEMU cycle),=
 we would like to</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; avoid adding new str props. The reason is that str props =
are harder to work with</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; in management layers (e.g. libvirt) and to expose in QMP.=
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; I suggest using booleans instead. They are way easier to =
work with in the upper</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; layers and we don't have to maintain string parsing code =
as well. Instead of</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; adding a 'debug_ver' string prop and parse values, add tw=
o bool properties:</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; debug-0.13 and debug-1.0.</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; Using two bool properties instead of string properties is oka=
y to us.</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; Thank you for guiding us this concern.</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; Second, we have a 'debug' flag that is set to default 'tr=
ue'. From what I'm</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; reading in this patch the existing flag would be equivale=
nt to 'debug-0.13'</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; I proposed above. In this case we can keep the existing f=
lag and add a single</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; 'debug-1.0' flag to indicate that the user wants to use v=
1.0 instead of v0.13.</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; I would prefer renaming existing 'debug' flag to 'debug-v0.13=
' and adding new flag 'debug-v1.0' in order not to confuse users.</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; How should we handle the situation if user provides both debu=
g-v0.13=3Dtrue,debug-v1.0=3Dtrue ?</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; Should we throw an error or treat this situation as if only d=
ebug-v1.0=3Dtrue ?</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof"><br>
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">What you did in v2 works for me. The handling of both 'debug' and =
'debug-1.0' is</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">mostly a backend decision that we're free to make, as long as we'r=
e having</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">common sense in how the flag disable/enable features.</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof"><br>
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">As for renaming/removing existing flags and properties, we can't r=
ename/delete</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">existing stuff unless we go through a deprecation cycle (add the f=
lags in</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">deprecated.rst, flag is removed one year later). We do this becaus=
e there</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">are existing users and apps that can be compromised when we delete=
/change</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">options from the command line.</div>
</blockquote>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">You're right. I reconsidered it and decided not to rename 'debug'.=
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof"><br>
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">Regards,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">Alvin</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof"><br>
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof"><br>
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">Thanks,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof"><br>
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">Daniel</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof"><br>
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; Sincerely,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; Alvin Chang</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; Thanks,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; Daniel</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; On 11/26/25 4:12 AM, Alvin Chang wrote:</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; The similar control did in 'priv_spec' and 'vext_spec=
' now is</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; available for version of debug specification. Current=
ly we accept</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; &quot;v0.13&quot; and &quot;v1.0&quot; versions. User=
s can provide 'debug_spec' into CPU</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; option to set intended version of the debug specifica=
tion.</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; For examples:</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; 1. -cpu max,debug_spec=3Dv0.13</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; 2. -cpu max,debug_spec=3Dv1.0</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; Signed-off-by: Alvin Chang &lt;alvinga@andestech.com&=
gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; Reviewed-by: Yu-Ming Chang &lt;yumin686@andestech.com=
&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; ---</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; target/riscv/cpu.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 69</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; ++++++++++++++++++++++++++++++++++++++</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; target/riscv/cpu.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 13 +++++++</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; target/riscv/machine.c&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 5 +--</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; target/riscv/tcg/tcg-cpu.c |&nbsp; =
3 ++</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; 4 files changed, 88 insertions(+), =
2 deletions(-)</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c =
index</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; 73d4280..dbcdfcd 100644</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; --- a/target/riscv/cpu.c</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +++ b/target/riscv/cpu.c</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; @@ -1123,6 +1123,7 @@ static void riscv_cpu_init(Obje=
ct *obj)</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu-&gt;cfg=
.pmp_regions =3D 16;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu-&gt;cfg=
.pmp_granularity =3D MIN_RISCV_PMP_GRANULARITY;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu-&gt;env=
.vext_ver =3D VEXT_VERSION_1_00_0;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; cpu-&gt;env.debug_ver =3D DEBUG_V=
ERSION_0_13_0;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu-&gt;cfg=
.max_satp_mode =3D -1;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mcc-&gt=
;def-&gt;profile) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; @@ -1138,6 +1139,9 @@ static void riscv_cpu_init(Obje=
ct *obj)</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mcc-&gt=
;def-&gt;vext_spec !=3D RISCV_PROFILE_ATTR_UNUSED) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; cpu-&gt;env.vext_ver =3D mcc-&gt;def-&gt;vext_spec;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (mcc-&gt;def-&gt;debug_spec !=
=3D RISCV_PROFILE_ATTR_UNUSED) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu-&gt;e=
nv.debug_ver =3D mcc-&gt;def-&gt;debug_spec;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #ifndef CONFIG_USER_ONLY</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mcc-&gt=
;def-&gt;custom_csrs) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; riscv_register_custom_csrs(cpu, mcc-&gt;def-&gt;custom_csrs); =
@@</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; -1720,6 +1724,66 @@ static const PropertyInfo prop_pr=
iv_spec =3D {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D pr=
op_priv_spec_set,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +static int debug_spec_from_str(const char *debug_spe=
c_str) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int debug_version =3D -1;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (!g_strcmp0(debug_spec_str, DE=
BUG_VER_0_13_0_STR)) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debug_ver=
sion =3D DEBUG_VERSION_0_13_0;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; } else if (!g_strcmp0(debug_spec_=
str, DEBUG_VER_1_00_0_STR)) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debug_ver=
sion =3D DEBUG_VERSION_1_00_0;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; return debug_version;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +}</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +static const char *debug_spec_to_str(int debug_versi=
on) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; switch (debug_version) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; case DEBUG_VERSION_0_13_0:</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return DE=
BUG_VER_0_13_0_STR;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; case DEBUG_VERSION_1_00_0:</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return DE=
BUG_VER_1_00_0_STR;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; default:</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NU=
LL;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +}</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +static void prop_debug_spec_set(Object *obj, Visitor=
 *v, const char *name,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *opaque, E=
rror **errp) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; RISCVCPU *cpu =3D RISCV_CPU(obj);=
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; g_autofree char *value =3D NULL;<=
/div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int debug_version =3D -1;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; visit_type_str(v, name, &amp;valu=
e, errp);</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; debug_version =3D debug_spec_from=
_str(value);</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; if (debug_version &lt; 0) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_set=
g(errp, &quot;Unsupported debug spec version '%s'&quot;, value);</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;</=
div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; cpu_option_add_user_setting(name,=
 debug_version);</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; cpu-&gt;env.debug_ver =3D debug_v=
ersion; }</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +static void prop_debug_spec_get(Object *obj, Visitor=
 *v, const char *name,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *opaque, E=
rror **errp) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; RISCVCPU *cpu =3D RISCV_CPU(obj);=
</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; const char *value =3D debug_spec_=
to_str(cpu-&gt;env.debug_ver);</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; visit_type_str(v, name, (char **)=
&amp;value, errp); }</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +static const PropertyInfo prop_debug_spec =3D {</div=
>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; .type =3D &quot;str&quot;,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; .description =3D &quot;debug_spec=
&quot;,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; .get =3D prop_debug_spec_get,</di=
v>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; .set =3D prop_debug_spec_set,</di=
v>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +};</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; static void prop_vext_spec_set(Obje=
ct *obj, Visitor *v, const char *name,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 void *opaque, Error **errp)</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; @@ -2648,6 +2712,7 @@ static const Property riscv_cpu=
_properties[] =3D {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.name =3D =
&quot;priv_spec&quot;, .info =3D &amp;prop_priv_spec},</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.name =3D =
&quot;vext_spec&quot;, .info =3D &amp;prop_vext_spec},</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; {.name =3D &quot;debug_spec&quot;=
, .info =3D &amp;prop_debug_spec},</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.name =3D =
&quot;vlen&quot;, .info =3D &amp;prop_vlen},</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.name =3D =
&quot;elen&quot;, .info =3D &amp;prop_elen}, @@ -2818,6 +2883,10 @@</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; static void riscv_cpu_class_base_init(ObjectClass *c,=
 const void *data)</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; assert(def-&gt;vext_spec !=3D 0);</div=
>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mcc-&gt;def-&gt;vext_spec =3D def-&gt;=
vext_spec;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (def-&=
gt;debug_spec !=3D RISCV_PROFILE_ATTR_UNUSED) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; assert(def-&gt;debug_spec &lt;=3D DEBUG_VERSION_LATEST);</di=
v>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mcc-&gt;def-&gt;debug_spec =3D def-&gt;debug_spec;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; mcc-&gt;def-&gt;misa_ext |=3D def-&gt;misa_ext;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; riscv_cpu_cfg_merge(&amp;mcc-&gt;def-&gt;cfg, &amp;def-&gt;cfg=
); diff --git</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; a/target/riscv/cpu.h b/target/riscv/cpu.h index 36e7f=
10..fc1ae7c</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; 100644</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; --- a/target/riscv/cpu.h</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +++ b/target/riscv/cpu.h</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; @@ -100,6 +100,7 @@ typedef struct riscv_cpu_profile =
{</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool presen=
t;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool user_s=
et;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int priv_sp=
ec;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int debug_spec;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int satp_mo=
de;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const int32=
_t ext_offsets[];</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; } RISCVCPUProfile;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; @@ -123,6 +124,16 @@ enum {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PRIV_VERSIO=
N_LATEST =3D PRIV_VERSION_1_13_0,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; };</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +/* Debug specification version */</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +#define DEBUG_VER_0_13_0_STR &quot;v0.13&quot;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +#define DEBUG_VER_1_00_0_STR &quot;v1.0&quot;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +enum {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; DEBUG_VERSION_0_13_0 =3D 0,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; DEBUG_VERSION_1_00_0,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; DEBUG_VERSION_LATEST =3D DEBUG_VE=
RSION_1_00_0, };</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define VEXT_VERSION_1_00_0 0x00010=
000</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; #define VEXT_VER_1_00_0_STR &quot;v=
1.0&quot;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; @@ -245,6 +256,7 @@ struct CPUArchState {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; target_ulon=
g priv_ver;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; target_ulon=
g vext_ver;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; target_ulong debug_ver;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* RISCVMXL=
, but uint32_t for vmstate migration */</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mi=
sa_mxl;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* current mxl */</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; @@ -563,6 +575,7 @@ typedef struct RISCVCPUDef {</div=
>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mi=
sa_ext;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int priv_sp=
ec;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t vex=
t_spec;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; int debug_spec;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RISCVCPUCon=
fig cfg;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool bare;<=
/div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const RISCV=
CSR *custom_csrs;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; diff --git a/target/riscv/machine.c b/target/riscv/ma=
chine.c index</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; 18d790a..8658f55 100644</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; --- a/target/riscv/machine.c</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +++ b/target/riscv/machine.c</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; @@ -427,8 +427,8 @@ static const VMStateDescription v=
mstate_sstc =3D {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; const VMStateDescription vmstate_ri=
scv_cpu =3D {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &=
quot;cpu&quot;,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; .version_id =3D 10,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp; .minimum_version_id =3D 10,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; .version_id =3D 11,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; .minimum_version_id =3D 11,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .post_load =
=3D riscv_cpu_post_load,</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fields =3D=
 (const VMStateField[]) {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32), @@ -443,6</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +443,7 @@ const VMStateDescription vmstate_riscv_cpu =
=3D {</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VMSTATE_UINTTL(env.priv_ver, RISCVCPU),</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VMSTATE_UINTTL(env.vext_ver, RISCVCPU),</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VMSTATE_U=
INTTL(env.debug_ver, RISCVCPU),</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VMSTATE_UINT32(env.misa_mxl, RISCVCPU),</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VMSTATE_UINT32(env.misa_ext, RISCVCPU),</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; VMSTATE_UNUSED(4),</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; diff --git a/target/riscv/tcg/tcg-cpu.c b/target/risc=
v/tcg/tcg-cpu.c</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; index d396825..160fcf1 100644</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; --- a/target/riscv/tcg/tcg-cpu.c</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +++ b/target/riscv/tcg/tcg-cpu.c</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; @@ -1598,6 +1598,9 @@ static void riscv_init_max_cpu_=
extensions(Object</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt; *obj)</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set vect=
or version */</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; env-&gt;vex=
t_ver =3D VEXT_VERSION_1_00_0;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; /* Set debug version */</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp; env-&gt;debug_ver =3D DEBUG_VERSI=
ON_0_13_0;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt; +</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Zfinx is=
 not compatible with F. Disable it */</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; isa_ext_upd=
ate_enabled(cpu, CPU_CFG_OFFSET(ext_zfinx), false);</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; isa_ext_upd=
ate_enabled(cpu, CPU_CFG_OFFSET(ext_zdinx), false);</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; CONFIDENTIALITY NOTICE:</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; This e-mail (and its attachments) may contain confidential an=
d legally privileged information or information protected from disclosure. =
If you are not the intended recipient,
 you are hereby notified that any disclosure, copying, distribution, or use=
 of the information contained herein is strictly prohibited. In this case, =
please immediately notify the sender by return e-mail, delete the message (=
and any accompanying documents)
 and destroy all printed hard copies. Thank you for your cooperation.</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(102, 102, 102);" class=3D"element=
ToProof">&gt; Copyright ANDES TECHNOLOGY CORPORATION - All Rights Reserved.=
</div>
</blockquote>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"background-color:#D5EAFF; border:1px dotted #003333; padding:=
.8em; ">
<span style=3D"font-size:12pt;  font-family: 'Cambria','times new roman','g=
aramond',serif; color:#ff0000;">CONFIDENTIALITY NOTICE:</span><br>
<p style=3D"font-size:11pt; line-height:10pt; font-family: 'Cambria','times=
 roman',serif;">
This e-mail (and its attachments) may contain confidential and legally priv=
ileged information or information protected from disclosure. If you are not=
 the intended recipient, you are hereby notified that any disclosure, copyi=
ng, distribution, or use of the
 information contained herein is strictly prohibited. In this case, please =
immediately notify the sender by return e-mail, delete the message (and any=
 accompanying documents) and destroy all printed hard copies. Thank you for=
 your cooperation.
</p>
<span style=3D"font-size:12pt;  font-family: 'Cambria','times new roman','g=
aramond',serif; color:#ff0000;">Copyright ANDES TECHNOLOGY CORPORATION - Al=
l Rights Reserved.</span>
</div>
</body>
</html>

--_000_SEYPR03MB670038CD1CA1A481F4D78C93A8DDASEYPR03MB6700apcp_--


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F9BCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXaW-0006H0-Qu; Fri, 19 Sep 2025 05:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzXaT-0006GH-1u; Fri, 19 Sep 2025 05:39:30 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uzXaM-0003oR-R6; Fri, 19 Sep 2025 05:39:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QY32bZxg8jMjbTG2K2OHF854oEJL2MozsJJQptXNVlop5VjmsMJaKgwvasFWMV8VHQE1Wn1V9jgNVH+d12Uma1M3DNa3NoEuFJD8WsQFfaBcV4gW3SV9AUWdJ7BmcnN/8YvoLcddod73UjZibuP4G8ERZPx2poXSCzlmv64JGZNIyK8eKvYDUXqSiW6jbtq6EzU8dWIlBRXmThW9eNs92dOaqAexzV/N/v1vjhyIrVOx2fI3YIuoANvHELdwbDrcAYNE/Ak6OebaQIzCUEAZtvJ7lNubBdx+9FLIWJmnQNMwQ3cPMxkZxBJadFi1ZszOC4J3mHUxieQULdcwp86FcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRdMDvIxBhmoMQCdQKof4ueOYcXWjeIN+B7CCITELMI=;
 b=wDG8aTK7UUISJ3G4VP/s/rftL+Gw+hD7ZqaTXfUHX/EGxMTsQqW98RRviS9ePSe3NJtN1EIK9b4rXX6iQKiM1oTnZg2hsuil57G6k50xz1/5dAnHyzLF7c+9VmysrxHIymemTa+4jehGGPTjj94ZRHhtqUs4m1Vvu/4zOsyz9PVUeoBK62kCQdO8iPX0xGogfOSBofRo53gsz39E60qonCHD/aWgBTzIFEHBq5lMm3hxjzv4r/spzj364ks2RJ/KvdHlMxLENuIBme6aV5noR1FzYmnBJ7Lsjt+mR1ymt8eDabT6hx/j1uA4lABRXZC9IFqzx98ACP8B5qVXBBAzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRdMDvIxBhmoMQCdQKof4ueOYcXWjeIN+B7CCITELMI=;
 b=UpK8LKO+WHTMzwpxBjbaLyQfNazcLThzyuMsWtFSRtR45V4Nk1TlJl0nlAlOfNGHSEXKc7z4IN1dTdqNEebAcnhGhu5pzrRL77Sn3KllWfRabGpd6aR0IlIecBzi/qRkxkZ38nMKtwE4mIf76rqMp1L0DrH3IV1kIpae6PpoV/GolQUSsA5kUo6HdEH+YwUY36RI+glSRSnarNUcWlLG6eoxIv/QTEuDSIxDK19kWj+SQ0dq2Q2OviizFHN6zJ7iN/Y8zAe7IIAnmCa2f6XehZ7cr+AO8AOlUfaUm3OPNCqo5trvBgQiLs8h0MhQ1wJ0p2VVDKzISoXFjhWFFL+U1Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB5828.apcprd06.prod.outlook.com (2603:1096:301:e8::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.16; Fri, 19 Sep 2025 09:39:14 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Fri, 19 Sep 2025
 09:39:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "titusr@google.com" <titusr@google.com>
Subject: RE: Aspeed backlog (was Re: [SPAM] [PATCH v3 00/14] Support PCIe RC
 to AST2600 and AST2700)
Thread-Topic: Aspeed backlog (was Re: [SPAM] [PATCH v3 00/14] Support PCIe RC
 to AST2600 and AST2700)
Thread-Index: AQHcKT8+f5LkJt2IXkeRPNfwjfpR0bSaPgUw
Date: Fri, 19 Sep 2025 09:39:14 +0000
Message-ID: <SI2PR06MB504147B4AA57E46DA1F1D2BAFC11A@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250918031348.3991681-1-jamin_lin@aspeedtech.com>
 <2e5f260b-dafa-42ab-953d-f0781cd3601f@kaod.org>
 <SI2PR06MB5041C7EE49F5A61C6E8B2DE3FC16A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <ef4f4cd4-6efc-4176-9043-4bca04e5da4f@kaod.org>
 <SI2PR06MB5041840F757BD2DED8342164FC11A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <e77f8aa9-8c19-41f5-b8b3-073c02092180@redhat.com>
In-Reply-To: <e77f8aa9-8c19-41f5-b8b3-073c02092180@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB5828:EE_
x-ms-office365-filtering-correlation-id: a7f20003-06ad-4638-8b28-08ddf760654c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?V0kycHVqNGtidnhOWDZtSnltZXV4K1I3eWUvbHU0VDZXM2FINE1UdUZ3M05R?=
 =?utf-8?B?eWtCNnBjZFJNTEtxeXR5L0VseUN6dG9jNWh4RlhXN2RtNEIvUzFHVS95L1Nx?=
 =?utf-8?B?WjVoeW1NMlFveWN0c2tTR2cvYkpsYi9pc0JXamZzMjJyMWttNUE5MkkwN01G?=
 =?utf-8?B?UVNFWGhtL2g5MEFNOHJ6bUQxVWdRV3hlem9KRDdSTWF6UVJydTlNaTdzZ1M5?=
 =?utf-8?B?ZkxtUHpZZ0NzWjFyR1d1NlY4a3pTRXZmeFU3UklodnVhL3ozNGV4Wmw0UlZ1?=
 =?utf-8?B?UTNKdDRHQTZDaXgzMXNDb1lmejFPcUZhbWJjcTFIWFMvbUdmUG50TnhCbDdN?=
 =?utf-8?B?NUFnSWhHaHU3bHZyTHl6Z2swbTBIdXJ6ZHlxRlA0ZzlEMXdINW9ocjZna0Ra?=
 =?utf-8?B?VmJQQTRTZFc3TWJpSkFaWUM3dThRWDBvVHZtRVRsbUkzM1kyQ09sWFdNQllr?=
 =?utf-8?B?OCt6ejZiRUl2ZDFyVmY3cDBKNDNKZTM2UldPek0wNjRBZXprSFpUdDBUckxO?=
 =?utf-8?B?VTVWa3Q1azNaUUsxZ3BZb3lrVk9qakltakNrTDMvWnFYSjlxekxFQ1kreVNR?=
 =?utf-8?B?NWl5Mkc5VlBGdWM1d3laQ3IzVXVUVERpcmxwenlldUZlSWtwSW40eTRjS0lm?=
 =?utf-8?B?dnVsMlB3aU5IV0tJR255SGRqdU9ya1ZmdTZoZFpHUWxqTmUzQ1hWQUxXaTFq?=
 =?utf-8?B?Z0c2eGc0OW5KVzU3NXdyMVVTMkswTG5jeVgwbFRNVVJTdGVEdzdkb21jNyts?=
 =?utf-8?B?amY1REtjKzZGZUNUYXFXZUEyK0diMnozN0tuWk9WSjB2TmJSMElmY3BBbDFX?=
 =?utf-8?B?eThUSGRocGpXVktObEQ5SFZGSVM3OE1YU2VVeWVzUEl6WDdyYWh0em1jODZO?=
 =?utf-8?B?ekF2WmFpZ1BLQlRLM1dGanJRcnZtMVN1akNRM1ZxdVhLTENyQXYybHhhR0oy?=
 =?utf-8?B?ZmJ3MFBjSFVqV29SZ3FRVjVwRk1rRWdsK1FRVnZOd2NwVmNLdzgvUVNFNEdU?=
 =?utf-8?B?OG5MTjdKZmVkdVhLOHA0czdKL1QyVWF5dFg4RlRsMmE1RkZIWVVrVkJzTnBv?=
 =?utf-8?B?ckZEekFuRlltbkhTMENKT3UrS1RsWDg2Z0t4ZDZ2SFNGSk5lL25icG00dVdm?=
 =?utf-8?B?cFZ6K2FMVThwZ21Qcjl5QVpzZUptUDNlT3hDUzFQTWJkVmxoTEpic014bWxh?=
 =?utf-8?B?M2pnS2tDekxaV09EYk5KN3dobDFRUmlUR255M1pRUlVXbThucHFEaTNFL0NG?=
 =?utf-8?B?MXJ2WTZnblhzUG9MYmd1YkF2TFRrRjRZMUJLeUdrWFltUmdwNWRDalcycU5V?=
 =?utf-8?B?bmQzQzVGU1kxZEFjZHRCOWMydDZWSFJ1UE85NFUrdHNodXpWelFVV0VVZzB4?=
 =?utf-8?B?VGloZDJTZ0dLUVNSYXVNVzBmQmpCVFFQdGZzb3hNek14TEgxYWpiSHVqeHgw?=
 =?utf-8?B?LzZCaGl5Z3p2bXpGWkd1Q21VbjRRbWVVbzFpZ2svUzd3Vi8xR0NiR1FKZGxx?=
 =?utf-8?B?WS9PUFhIcTd5WVU3WGJ5RXNEUjArUndmOXRSZWZaRndHUkF4QndIQlpTV0ZC?=
 =?utf-8?B?TkxPWmx5L1pkOVVVZlpjNlFsQUl4SmQ3ckd3MkFEWjhIMnZFTnN5cTkwRTFm?=
 =?utf-8?B?bThhYlVkSVUzOVlqRnJLY0Vrd2JPOWMwczlBK3hrRDYwc1FVV0NvQWVjQklr?=
 =?utf-8?B?WTFGTlRjQ1JEeitDRE5FZWVPR2ZsamdaMTN6WTJiZXpyZU9uN3VrbFlyL041?=
 =?utf-8?B?Z1ZnYWtyUnZRK3JieE1RMk5pU3YvU2U5TlIvQU02bGlVZTNhYjZqUHdFMHhO?=
 =?utf-8?B?cVhGYUczMndaK2hSQ01lSkNKcGw5VUtzMHVOeFoxczBMd3l5N01ITS9WWHlK?=
 =?utf-8?B?TGpxYmlza2tSS1RPKzUwbFhmVUxOSlpUYjdvaXlzcm9leUp2NWYwK3JMdnFz?=
 =?utf-8?B?NU9ETDNjWVQ1Q2VRV0FCcXZnU0RsQ0xwU0RHYjNJaHdic252ZnRrdnhhcG9O?=
 =?utf-8?B?UTN0NndKVEpnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFKb3E2YzNrV0N4U3dkMDRtK2lhdnhkVmpvVWNrdHYyK3ZBTEpDT2ZZYlVY?=
 =?utf-8?B?TUMvZlRhRE1KcStRUHZiOUVyTXpBYzdjeTd0RnE0N1JqODczRStqeWFZb0Iy?=
 =?utf-8?B?bC9sZ3dyRnhvOTFYNklWSGl0SHd6Z2ZBTk1qbEZud1VycUloUlZyQ0UvcEpI?=
 =?utf-8?B?S2VIeXdGZmxIdFp1UFdaeDN3VFM3bmZsRmwwSUhrMWdTRFM0dFFvODVNVy9U?=
 =?utf-8?B?Tk1LWjdUcUdDZHl6cDBpTW9NR29aNlhpQTE2SjFwRGZjQzZ4SWU1YnhKc1p5?=
 =?utf-8?B?eVkyVHphdWM4STNQSHZQdHB0VVgzanBwRStvWGEwa21IZ3cvYWhoZ0RUcWJ0?=
 =?utf-8?B?ME5JUy9GZEVEYVhXWjF6MEZaMDJtK05sdHJiS2crVG5PcE9DSzRCVkh4SG1Y?=
 =?utf-8?B?Q0hxL0FhNXNWWVJsQ25XeUhzOWRmZjJSa21nTVNKejlnZUsxeHFQMzNnU2tu?=
 =?utf-8?B?T0hCdzhHL2x1dWtvdTcwaEMydEhmT2RPbGJoZDhkc2ZmRzFITlgzeTlsYTdR?=
 =?utf-8?B?SkpmL2xJY3RhR0U5VGxCNEF1UUR0b04wNDVmN1pUWWZabkdDcUhLQzRkWEFI?=
 =?utf-8?B?OW53UUhsZkRVbWFKdE1VUlVDNW5UNng4SDNlbnU4by9YK3R4b0dCWjlFYlNO?=
 =?utf-8?B?dS9kTGJnVEV3VkozSDdLYUhOeTdIcEw3NklwYllmeFZlRGJQRGNDelJvUUgw?=
 =?utf-8?B?S0hiV3JnWUp4VkRrbE5vNG1SOHhwZmhMMXZQeGZaVDNSdmxKckNSUmZmM1hC?=
 =?utf-8?B?WG1MMUpmMlhXK2VKRGx0STkvRXJRMXplN3B3Mit2Y3BkVFRyWXV3OFBBakh1?=
 =?utf-8?B?akwwZDNHTkJob3pWNHNsMkQ5RVBVNGMvREp6OXNiNk0zbUVRY0FJRlhJUlpU?=
 =?utf-8?B?NUI0Tk5XOVN3SUgwQXIwTzBXRzJ5VGxJNW55OCtnNnRpUkMrVVQ5Y3JDZjJr?=
 =?utf-8?B?L2VsRzg5azdzWFJ4ZHVVOEhCL2UxK0VFY294VkU5ZnJNWFYxMUxFUlZjQ0hh?=
 =?utf-8?B?QlQ3bC9BRG15RmVFWUhzSm9FaW9CeFhMTDQ1RmtaNXlMdVB6a0lCb2xTU1F4?=
 =?utf-8?B?clVkMHhLQ3BUTlhCZ25ha2FJMzltWWQzYlhYZXF1UzZrYS9IMVk2bVlyMlNh?=
 =?utf-8?B?cCtNVS9qWkxOTitRQ2ZoSjQ1d29jdEZ0SURCNDk3SFlGZHhYeThURVV1Z3c2?=
 =?utf-8?B?Q1BEbmNjUGM2d2NheWVqODQvSkZqVGswdVIyQkl4a3Y1Z1c0KzhrS1czWWwr?=
 =?utf-8?B?dE9PYTJPY3VKZkhGTFVOSDJtSFVPRGU5MlNVQjJ6OWtiUEROdnlxbVB3eHpm?=
 =?utf-8?B?a055dzdNcnhiWFRqZm85T01VTUZlejgyUDJEQTkwL05rUUV0dEFtVk4xTzFz?=
 =?utf-8?B?VGdpWjFaVG5TVXRMNHhXcWdpUEh5eVBISHEwVjlvcXE2KzNISlllSlRJOHVE?=
 =?utf-8?B?bGpXTWM4cmxJa05zUmlHTVhYRTB3TE84aTdvRWViNGRVb2ZOU3VRSjZYdG5V?=
 =?utf-8?B?bDlOVHB5RUtnM0kyK0czSXZmK2Z4WTExOGsya254RW9mMkc2NTROVlhMMnlr?=
 =?utf-8?B?Z2hnbERRbmxQMnFyVFkxQUtjNURlcGdsRUhzUW53ZWQvYmNnY05QSlRNUGxW?=
 =?utf-8?B?eEVQNFIwMEp2UjlOaGJHSTdldzVBV1F0Q01WZ1dYUzBEM2Q4bWN6V0VSRkFS?=
 =?utf-8?B?ZEtqK1Y3VmtWM3hvT1ZyVTduaUtlQnNHN2VIYXdpcWVxa29LWEJRdlRqT250?=
 =?utf-8?B?VEt4YUZ3dGFncVdIU3FVcXFjRVBhYno4R1ByMU5zTkhCbkFsZXNaYWZjQ2Vx?=
 =?utf-8?B?Si9OY2QzR3ZwTnZRSEZMa1YwekRYaWZoNlB4VmIvTFhBSFV0OVM2dk9WckF6?=
 =?utf-8?B?T25mU1ZiRGJlcU9RdVRNc2hEVUVNRlpzN0FFcXBYaEM3bG1ua2RQTzFMQmcr?=
 =?utf-8?B?Z0laeTJtMzBZdFplTGlpZ0hkY0lVZ3hleUM1Y1BuZldtSTBGTi83ZUIweC9K?=
 =?utf-8?B?NzlNcWREZTNiRURmdDgzWkJjZjVrVE0zNytYTU0venZ4ZWdaR1RidWtWc1Uv?=
 =?utf-8?B?Nm5maThmNnREOS9NVmh4VmFWb2gwa0VjNlZjWU45T3AxdTRldENiN0tqOUZL?=
 =?utf-8?Q?QWf9qyNnN0PEhVWJkyLKNrueA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f20003-06ad-4638-8b28-08ddf760654c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 09:39:14.4608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aK9OHgQh7//qu+4U+dXENSXXyF2+BXeACNL18UUdKJoh+124+4tiUxnHGEXRYTkMs/QtmwDEcfFay8PlW7rECweycT/tkaVpSa2I5pOZtsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5828
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IEFzcGVlZCBiYWNrbG9nICh3YXMgUmU6IFtTUEFNXSBb
UEFUQ0ggdjMgMDAvMTRdIFN1cHBvcnQgUENJZSBSQyB0bw0KPiBBU1QyNjAwIGFuZCBBU1QyNzAw
KQ0KPiANCj4gSGVsbG8gSmFtaW4sDQo+IA0KPiA+PiBPbmUgbGFzdCB0aGluZywgdGhlIGxpc3Qg
b2YgUENJIGNhcGFiaWxpdGllcyByZXBvcnRlZCBvbiByZWFsIEhXIGlzIGENCj4gPj4gbGl0dGxl
IGRpZmZlcmVudC4gU2VlIGJlbG93LiBXaGVuIHlvdSBoYXZlIHRpbWUsIGl0IHdvdWxkIGJlIGdv
b2QgdG8NCj4gPj4gYWRqdXN0IHRoZSBtb2RlbCBpZiBwb3NzaWJsZS4gSXQgY2FuIGNvbWUgbGF0
ZXIuDQo+ID4+DQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uIGFuZCBmb3IgcmVw
b3J0aW5nIHRoaXMgaXNzdWUuIEnigJlsbCBhZGQgaXQgdG8gbXkNCj4gd29ya2luZyBxdWV1ZS4N
Cj4gPiBIZXJlIGFyZSB0aGUgdGFza3MgY3VycmVudGx5IGluIG15IHF1ZXVlOg0KPiA+DQo+ID4g
MS4gQ29udHJvbCBjb3Byb2Nlc3NvciByZXNldCBmb3IgQVNUMjcwMA0KPiA+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVsL2NvdmVyLzIwMjUwNzE3MDM0MDU0
LjENCj4gPiA5MDM5OTEtMS1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20vDQo+IA0KPiBUaGlzIG5l
ZWRzIGEgcmV3b3JrIG9mIHRoZSBjbyBwcm9jZXNzb3IgbW9kZWxzLiBUaGlzIHNob3VsZCBiZSBR
RU1VIDEwLjINCj4gbWF0ZXJpYWwgSU1PLg0KDQpZZXMsIEkgYW0gcmV3b3JraW5nIGl0LCBhbmQg
SSB3aWxsIGRpc2N1c3Mgd2l0aCB5b3Ugd2l0aGluIHRoaXMgcGF0Y2ggc2VyaWVzIGlmIEkgaGF2
ZSBhbnkgcXVlc3Rpb25zIGR1cmluZyB0aGUgcmV3b3JrLg0KDQo+IA0KPiA+IDIuIEFuYWx5emUg
aXNzdWUgImZ1bmMtYXJtLWFzcGVlZF9hc3QyNTAwIHRlc3Qgb2NjYXNpb25hbGx5IHRpbWVzIG91
dCINCj4gPiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMzEx
Nw0KPiA+IDMuIEFkanVzdCBQQ0llIGNhcGFiaWxpdGllcw0KPiA+IDMuIFN1cHBvcnQgQVNUMjcw
MCBJUEMgbW9kZWwobWF5IHJlcXVpcmUgcmVmYWN0b3JpbmcgdGhlIElOVEMgbW9kZWwgaWYNCj4g
PiBuZWVkZWQpIDQuIFN1cHBvcnQgQVNUMjcwMCBBMiAocGxhbm5lZCBmb3IgZW5kIG9mIHRoaXMg
eWVhciBvciBRMSBuZXh0DQo+ID4geWVhcikgNS4gU3VwcG9ydCBBU1QyNzAwIGJvb3QgZnJvbSBC
b290TUNVKFJJU0MtVikgaW5zdGVhZCBvZiB2Ym9vdHJvbSwNCj4gaWYgYSBzaW5nbGUgYmluYXJ5
IHJlYWR5Lg0KPiANCj4gSXQgd291bGQgYmUgZ3JlYXQgaWYgVHJveSAoPykgY291bGQgcmVzZW5k
IHRoZSBtb2RlbHMsIGl0J3MgZ29vZCB0byBoYXZlIHNpbmNlDQo+IHNpbmdsZSBiaW5hcnkgaXMg
bWFraW5nIHByb2dyZXNzLg0KPiANCg0KSSB3aWxsIG9yZ2FuaXplIGFuZCBzZW5kIG91dCBUcm95
4oCZcyBwYXRjaCBmb3IgdGhlIEFTVDI3MDAgQm9vdE1DVS4NClNvIGZhciwgd2UgaGF2ZSBvbmx5
IHRlc3RlZCBpdCB1cCB0byBydW5uaW5nIFNQTCB3aXRoIHFlbXUtc3lzdGVtLXJpc2N2MzIuDQoN
ClRoYW5rcy1KYW1pbg0KPiANCj4gDQo+IEFsc28sIHRoZXNlIGNoYW5nZXMgbWF5IGJlIG9mIGlu
dGVyZXN0LCB0aGV5IG5lZWQgcmV2aWV3IDoNCj4gDQo+ICAgIC0gdXNiL3VoY2k6IEFkZCBVSENJ
IHN5c2J1cyBzdXBwb3J0LCBhbmQgZW5hYmxlIGZvciBBU1QgKEd1ZW50ZXIgUm9lY2spDQo+IA0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy8vcWVtdS1kZXZlbC8yMDI0MTExMjE3MDE1Mi4yMTc2
NjQtMS1saW51eEByb2Vjay11DQo+IHMubmV0DQo+IA0KPiAgICAgIExvb2tzIHJlYWxseSBnb29k
LiBOZWVkcyByZXZpZXdlcnMgYW5kIHN0YWtlaG9sZGVycy4NCj4gDQo+ICAgIC0gaTNjOiBhc3Bl
ZWQ6IEFkZCBJM0Mgc3VwcG9ydCAoSm9lIEtvbWxvZGkpDQo+IA0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy8vcWVtdS1kZXZlbC8yMDI1MDYxMzAwMDQxMS4xNTE2NTIxLTEta29tbG9kaUBnbw0K
PiBvZ2xlLmNvbQ0KPiANCj4gICAgICBMb29rcyBnb29kIG92ZXJhbGwuIE5lZWRzIHJldmlld2Vy
cyBhbmQgc3Rha2Vob2xkZXJzLg0KPiANCj4gICAgLSBBZGQgQXNwZWVkIEdQSU8gdGVzdCBhbmQg
U3VwcG9ydCBOdXZvdG9uIFNlcmlhbCBHUElPIChDb2NvIExpKQ0KPiANCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvL3FlbXUtZGV2ZWwvMjAyNTA5MDMyMTM4MDkuMzc3OTg2MC0xLWxpeGlhb3lh
bkBnDQo+IG9vZ2xlLmNvbQ0KPiANCj4gICAgICBOZWVkcyByZXZpZXdlcnMNCj4gDQo+ICAgIC0g
aHcvYXJtL2FzcGVlZDogQVNUMTcwMCBJTyBleHBhbmRlciBzdXBwb3J0IGZvciAoS2FuZS1DaGVu
LUFTKQ0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvL3FlbXUtZGV2ZWwvMjAyNTA5MTcw
MTMxNDMuMTYwMDM3Ny0xLWthbmVfY2hlbkANCj4gYXNwZWVkdGVjaC5jb20NCj4gDQo+ICAgICAg
TmVlZHMgcmV3b3JrLiBJIHdpbGwgY29tbWVudCBtb3JlIHdoZW4gdGltZSBwZXJtaXRzDQo+IA0K
PiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCg0K


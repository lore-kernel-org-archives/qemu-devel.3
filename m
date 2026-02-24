Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C92FE9B248
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 09:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vupBm-0002dp-Rm; Tue, 24 Feb 2026 04:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vupBj-0002dP-07; Tue, 24 Feb 2026 04:58:43 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vupBg-0003zf-Px; Tue, 24 Feb 2026 04:58:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiGX86LoG9VETfdVbIqyH0G7mn1ge8iedCty8LwKBW4/fwqUZC5jw+DSC7Vf4EwS1pejLN5m7SLW2++Vm4J+ireu0NUCqOx/sh5SaOm36bFTZCViXcgeUIdv6bpvgFmrjxOHPQfA5h/K+wdlH/j0oqhhMwVdIXMVNcWXoyz68fI+AxpVElH4mg7ERgQOdZCHbEJ67MLOqgIrO376hJ5UgEfAWXjxqnk8h20+gXpvlsXxnEGBq/tyWy70si/xtC4PsKwbEOnN5jf4kEKREtiFbq4GoEl4qf/v5Uofn7ZBFv2PyHXSuzL60swNZHqcLlqi5ayig07RdSvxUj2ow75NGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZkH+Nt9RjTudvvk/jpmb2+UpQG/hqsFzwA7k6HxvUY=;
 b=NqqEiaJDaMKULoJO7GvugCdB38gQ259rUP7CpMFmJSzvfVpI0noUNyVlQskxWT2u8qoslJkAozUGnSRRu+S5FckC7fFigvegJighOKOe4d1gVraAdOqOcVINZBcg4Obo9P0stGMD+ckOjtxlOWz4iY7TbqdRY8yla9kc9g7oFCKORNhm7iNMlwGB6qzyHW89zVFtm18JOSzbAzuxTKk2KrNCTxavBdv3oTlPhibjdWf+K4ky7ZwbcWGCpDH1V/m8QrYXeS7Z4Q8jWVHt0co9V1/UUScKxap0Sgq/nZ6ToK6gUIBNcH0sMsaovnFiO7vsdsQO+Q+EyRAz9Gc5Mo+cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZkH+Nt9RjTudvvk/jpmb2+UpQG/hqsFzwA7k6HxvUY=;
 b=PentrFp8lL9RyRKStKbNOG87NwoN6zCb+rtyOfNlm/Jygf4hdewPKmeqSzha8Fwe1wFLc83GXsc8qr1bIIx9VL11RHtt6EawtYbUTlS/UqmD8DZ/ggKYWq30AzmXHq9JiqBaODX8Yt+aJ2JffOlitBPsqS3kv4ql6PEmMUWJa3V/kjAjo5Vt7ig//Ek+QLQAP3UXKFfBBlJrssyJTIdW2ChstcMddUFY+H7uLKf8QgzGxR4MVN5MNiaRoCAElp1ba+VZVfhqAjFz8b1svvLSxKz3wf5wnXJFkzhjCnvvJhQSNpGQX+ZctgYrmsCoy9lhoLmuSK7MNpU0tH7bHOLM0w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5737.apcprd06.prod.outlook.com (2603:1096:101:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 09:58:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 09:58:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
Subject: RE: [PATCH v5 00/21] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v5 00/21] i3c: aspeed: Add I3C support
Thread-Index: AQHcmm0UcQRs4EPMvkyppE8BhlWZ87WAmiyAgBCI2OCAAIZzAIAAAJQQgAAIeBA=
Date: Tue, 24 Feb 2026 09:58:30 +0000
Message-ID: <TYPPR06MB820647A351FA8D23BA10BA71FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
 <b6ad55df-e6ef-443b-a075-ab6959cefd46@kaod.org>
 <TYPPR06MB82061ECF268DE4C88A7641B4FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <7c6d421b-413a-4908-8e02-a9ccec4e42e5@kaod.org>
 <TYPPR06MB8206BD446615A0062DC0A462FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
In-Reply-To: <TYPPR06MB8206BD446615A0062DC0A462FC74A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5737:EE_
x-ms-office365-filtering-correlation-id: 2122653f-2a10-4aa8-1556-08de738b4378
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?YUFkZDlTVWVndUJJRUZ6d0tvUWp5VTJqNzFpckw2WXFqT0hmaFh3Ky9xdm1I?=
 =?utf-8?B?SWJGUlBUSG40MTFpQW9KMnRZdkFNNmNXVnoyZ1p6dWQxVnFCdkRtMjB3Vkoz?=
 =?utf-8?B?dTBqTkxXUWFBSjRRUDZ1RjdrQW9ZOWd2OEZpd0lvZThodk0rOU5QdzlrSzFm?=
 =?utf-8?B?RVR5N3IvWGZPYWdkY1VDTmN1U3MrMTZQaE9BVko3ejdSb3BHaXVPUEsrVlJ1?=
 =?utf-8?B?enA0TWluVitMUk1TckdsUWhsa2lJa1p2MVdTREFqcXBsTm43NnYwKzlHeE1I?=
 =?utf-8?B?RXdvQ1lGZ2JGNmRqK0JNWkZSWTdVZzZNMi9vMmhpdWRqUjdKRUF2MDlsTGtM?=
 =?utf-8?B?bUJqT3A3RTh0d3BGTWhPeHJLVjIyZyt0SEpwRWJyeS91SGk0YmlTOXV5MEhH?=
 =?utf-8?B?Uk1qZDlTWG9XNlp4U3M0N29wZUQ4emJKanA4eXJMTXpzaVhXdWxaNW1Jd28v?=
 =?utf-8?B?TW96QUU4K3JNYWw4bTVEK08xUXk3U2FNQ2xsQWtWTEZZK1UwaVIyZjloNXZl?=
 =?utf-8?B?Y2JGZVVqWWcwcXNCNmRObDNwZUluV3k1OHNTSjUxaURUOUFwZThHOTliaHg3?=
 =?utf-8?B?YzFqeHJ0WmczVURNNWk1TDNsWDRDMFhxVHJkUTVzdzhibGFaRmZ0ZEw2cERB?=
 =?utf-8?B?YVpBUk1PNkRCcWpBYUZiTTc5cDMwMlc3OFlxRjRqY3MzSEkwR2VsNlMyMGRR?=
 =?utf-8?B?NEVyb243NXlIdWtwVUorMUk2cnBRUzZTclY2NWhTNjNLaWFHSVk5QmJOS1Mv?=
 =?utf-8?B?VVBqNzR5ZVFYN2JYcEFtQXVhQUIxTUNxWDdyOUcrY1RkMEJwT3JjdEtZemxa?=
 =?utf-8?B?WUNHQ01ZRW5vMEpJOVpwWm1PMGxkREFuamZSWWh3QUN3b1RVanp2WVMxZFZP?=
 =?utf-8?B?ZmZmaFhITmtZdER1empsS20rSmp5NURsRTVhSUNnR3lJWjVtZ200c1R1Q24r?=
 =?utf-8?B?dUxscnlQRlVjUXhjQXFUcGNRWkI3cFVUZEtuZnM5dFRQdlQ5MDRSTThmNHA3?=
 =?utf-8?B?dGpvY2RRVkVIVEt1a2g3Y3pGcHowZ3FTNmhKeEY4dWN5enBxTE5LVnF1OWxL?=
 =?utf-8?B?Q3NSclU4UzAwdVVGQ1liRVBOU2FrQXVFeWxuZzhUei9EU2F2aDkyVmlOQWtz?=
 =?utf-8?B?RWJzaE5NbnJFQzJCeHA1YmJPVkRsdXlPNGw3OU9iWk51SDNjQ1VLZ2QrMGlL?=
 =?utf-8?B?bUgrUjZPcGxaKzJLZ20va1RxaDhES2xNM0RUcmV6VVZDWCthdFBxRzg0UFVa?=
 =?utf-8?B?dXVtUjdKUXZvRktobm9KUFBUUm9EdWVZdEQzdUN2UEpUMFRFOW9PQ01iVUwx?=
 =?utf-8?B?ZlA2RGVBRmFnTEJnalhMME02cWxBaERGbW5uYnQvYkx3OWFiYzVoSisxSHZs?=
 =?utf-8?B?dFJtTGFBc3BvektiNEZVZXFSZms4TU5mb3Zqai9zd0VUK0c5YjVlZG9KNVFB?=
 =?utf-8?B?VXRDYlg3cjB6cU5hdmxsSkJvaTM1ajEveUFQekxHNGlZWmk0SzRVR1UvOFZm?=
 =?utf-8?B?T09sQnZRWHplMFJaQW9tRllkL2p0L2JOdjhOQ2FGUm9IZW93ZkxiR0ZkZ1VM?=
 =?utf-8?B?UDRpU2lOUE1Pbm5xZHYrS1JONkJHQ1BXT1h0RkxBUzJQeXNaak16bUlIeXl4?=
 =?utf-8?B?K0tjKy9VeXRzUE9GZFF5Y0RTb0l1amNDUm1YOVdackwvWSt6aS8wT0Y1S0Mw?=
 =?utf-8?B?bW5sZW1XTllyWWxJSTRWa3krazEvNzBlYWlycHpQTWVlNUpISnZ2M2tOZ1A2?=
 =?utf-8?B?dHdhNEtYK091VnAxREhYQ0ZpYlNqd0xhbjlTSHNQUmp5VjREWmJRdm5iWFVo?=
 =?utf-8?B?bXFzcXowaW9lRjQweGQxbVlMZ3dCQWp6My9qK1NEcGJscVRXbGl6bk03bHdQ?=
 =?utf-8?B?NUZaRHdQc3crYlE2WUxzUVhxUXBzekVWSkxIK21nT0t4VjlpRk9BMlkyZkdw?=
 =?utf-8?B?eEw4M3phTmN4NWlyK1FYYXdpa2lrdzF3b2Q1SVlHZzFoR2FST3ZuWkNHU2Uw?=
 =?utf-8?B?RjV6YkZLWHlwUlVBVmo5UXVnN1k5RnFXN1VRbklqRTE0dWFuN2duSGFNN0VL?=
 =?utf-8?B?bVpZWWgzMmFibnJrY3RmY1F4aDdBZ2JHOXZiREE1bkVydE5VUE5jU0NieSs1?=
 =?utf-8?B?WG5XUDk0Q2M2REpjbVFYVStoeHREREI3Z0h0Z0JQcm1VT2tRaHJoRndRbm45?=
 =?utf-8?Q?0B91dDdZfVqn++Zv/Cx1ElCJAfmsAwC4E+6ndVksBMC8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1ZhaEpjSFFXTFEwc2RNRU94bzd3N3hYc0pjVFRNcTNqSWlKTWFEMmFyM1Za?=
 =?utf-8?B?WGhwMnhMNmI2K1dPYUdvVmlQYlhpVWFGZG5XWTl4ZjBtSkY0OTd3WS9pN3Ew?=
 =?utf-8?B?SGFKcExqR0p3Q1JjTXRzWjlFQi9PQk9lMmlRRXU5OW5BNUdKRDlETWZYOWl5?=
 =?utf-8?B?bStGVkwyR2RjNFI3Z0xLSDhSb2FPRUtscllLSDVTRUJwbUNraVZ3T0RYNWRh?=
 =?utf-8?B?TVlxeUtkUDN1SjdOOG9EUUVOR1NBSmJmakJCSmYvL3pGclJkZUIyTWVLcmlk?=
 =?utf-8?B?bG0zallYN2RQUHN2eHhzbHRJZXJiUW9hVElmRXJTcStoT2lPelRnKy9MN3Aw?=
 =?utf-8?B?RSsxRTIwZThZZXNPczFuVEFkNXRHNmtHTWpNUndZanNTK0FRcXU3eEFQZkRy?=
 =?utf-8?B?N1ZwdFRXbkp5eWdJaHJDY20wckRzVEZuNTJaaFVRWE12RStHWC83ekwydnBX?=
 =?utf-8?B?dHlHL2tFRmF2eTlsYnI0ZExzWkZZa3ZJQVdCWGVvRTdnMmRXVFJlN3Vhc3dK?=
 =?utf-8?B?MWFFcWtkNmcvQnVMd3RMZkNaakxLVnVjU25Uay9zZWpHcUVSY2VyOUYyTll3?=
 =?utf-8?B?TU9Yc04zaUIyR1FVV0JwTjZVb0RqN1pqQ3VyWXd6MUM2bVl6TE9LSEc2eXJE?=
 =?utf-8?B?VkJVSmxGSDdwbWExMUlpWlRqTElMRFZBajR3cVhSc0lQbm80RWlvRksxN2NN?=
 =?utf-8?B?MmNCVDNnUEcxTENiczV5NVg0dTZmZHV2RUlXeGtnMkVDcytlSUZrSVJlQUMz?=
 =?utf-8?B?cHZOeTYzblN1RXUrcVEwMmJEMDhjamxPQmpmVDUzSFExb3d0TGVXbnQ5Q0o4?=
 =?utf-8?B?SDh2amR1UUZPRVZrbTVlZ25Wc2JXWXpiUmZuZkZkNmtpTWxMWWVZNVRGWnZk?=
 =?utf-8?B?M296cXVKVU14MUdmOTBoQW1neHAvai9oYjUvWlhpbTBzSVdGN09kZENFRFYy?=
 =?utf-8?B?V3dDTzZMUjEzWGtzanRJdW9aWFlHVDRnZ252TllRY05hNjM5SFdXVlFReUVC?=
 =?utf-8?B?ODJJOXJzQVlJM2hoKzR1V00rcm5CSFoxRURmVStsRXNkRlFoYmV5Vm5Ua1lO?=
 =?utf-8?B?TTJ4NVpuVUhIbW5SY3ZQZDNPUUd0alFZNjFyOWhvd0Y5RDdWdTdMK2hWenZ5?=
 =?utf-8?B?Sm4rM0JyL0YrK2FIUlVqeXZZQkdqMHlrMjBLTThobTRuZ0JEbXA1TXM2T0tp?=
 =?utf-8?B?T0dDZVVTQnppanBJVThvelFyNEVJYXRXMWdOdVFYZHhTdTVnMnZLdldZWmdM?=
 =?utf-8?B?SUxnVUt4dmVQSGlJOHBOVFUxd1NpMCtvUTRJSENsQmxmaVdLV3lwQkpyemhy?=
 =?utf-8?B?TkJ4MExzVk9tMHdFcVdLRHRtVm9NWmk3d2pLZG5qNXV4UkdBeTh2bnQxdk5i?=
 =?utf-8?B?K0RnZ2lxWUlOakE2K3VFak0zb0paTEhTSEVMUUVRSm02MlBIL1RYaXJLOVZK?=
 =?utf-8?B?cWN2T1FCR0FuQ1dLazBiajhnUEJ5M2xESkhqSEY2Z3dobHh0cFYxK0E3SG0z?=
 =?utf-8?B?dmlZZmUwNW81b0tFQUR4Ty9VWnl3NHMxT1gzcllpOC9VNXJBd3AyMGZGNDl1?=
 =?utf-8?B?UGFnajlxTXZCTkMwZ3hob0JybmZ5WXJwV1N5VFhGZ2l4WjNSZ3hBRElqS0o3?=
 =?utf-8?B?a0hocllENW8vWks0ME56VW1zYUJueUgyanpOUWJlLy9hSDQxTUkzcWl4amtF?=
 =?utf-8?B?RWIvU3BlME1ndWNMK3B5V05iZXN2VENXS1BhSFFBUENKOGlqa1Y0STFYVnBy?=
 =?utf-8?B?NVh2M3V5WFFYZitHbnoycEZidWtoYUNKdjVDSEJTVXJYdWdXNzhjY2Q4YzRh?=
 =?utf-8?B?cStqYVJxZFMzaldFWFhUZlI1eGtTTHZuUDFmdDFiNW0vUHZuQXNwdFdhNndj?=
 =?utf-8?B?aTNmSFROeE12NzlaQWtQcUxFaW04VmRaNElJaUdQODZxbmFDN0kraXJRMUdX?=
 =?utf-8?B?MmNidkN3MU03UlRNdUpQRjByU2FJNzFFaUVhZjRBd0Zna29NMC9zQll6Wmt5?=
 =?utf-8?B?WC9sQUQrKzRsWWh3d0gvbk1aY0svS1lsSGtsT0J3Q1V6N2RNdEJFVkQrVmFX?=
 =?utf-8?B?T01CdElWNDFoa2NZenBwUzZaRnZjK1BhekF6QU53YWY3bC95Nk5PUHJSVlh5?=
 =?utf-8?B?OEtSdFh4bGVsZTdiek82a3p4YTNScXhySjBobTBhZVJTaHIzQXgwV1hYVzdx?=
 =?utf-8?B?Wks0T3FVd0FLV25xQTZ5ZndzaEUyK0RJbzQzM0ZSSmk1UFlCUDg2amVIUjk3?=
 =?utf-8?B?RXBsTElQQU03ZXp0T3dnZG11cHIxNDJGSW9ZK1hhdDZWV3pCRTVTbnVZeDU4?=
 =?utf-8?B?RGFFcXhST2dITEZXYVplaS9POW1FQVdRTm0ydzlJOSt6a0E0aFRTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2122653f-2a10-4aa8-1556-08de738b4378
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 09:58:30.2334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8W4Jca9XCa9iJwKbJDIFkp8K43tHfOciH69KHTYXdMfk54l51jqQv29nbK6fTfPsks2xus1/GnhWM7eN1WcSgI33fvNI0J8vVNbh9F6iyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5737
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

SGkgQ8OpZHJpYywNCg0KPiA+ID4+IFdobyB3aWxsIGJlIHRoZSBtYWludGFpbmVycyBhbmQgcmV2
aWV3ZXJzID8NCj4gPiA+Pg0KPiA+ID4NCj4gPiA+IEkgd2lsbCBhZGQgbXlzZWxmIChKYW1pbiBM
aW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4pIGFuZCBKb2UNCj4gPiA+IEtvbWxvZGkgKDxr
b21sb2RpQGdvb2dsZS5jb20+KSBhcyBNYWludGFpbmVycyBhbmQgTmFiaWggRXN0ZWZhbg0KPiA+
IDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4gYXMgYSBSZXZpZXdlciBmb3IgSTNDIGluIHRoZSBN
QUlOVEFJTkVSUw0KPiA+IGZpbGUgaW4gdjYuDQo+ID4NCj4gPiBPSy4gSSBjYW4gYmUgdGhlIHNw
b25zb3IgdGhlbg0KPiA+DQo+ID4gPiBXb3VsZCBhbnlvbmUgZnJvbSB0aGUgUUVNVSBjb21tdW5p
dHkgYmUgd2lsbGluZyB0byBzZXJ2ZSBhcyBhDQo+ID4gTWFpbnRhaW5lciBvciBSZXZpZXdlciBm
b3IgSTNDPw0KPiA+DQo+ID4gQXMgSTNDIGlzIGN1cnJlbnRseSBvbmx5IGF2YWlsYWJsZSBmb3Ig
QXNwZWVkIG1hY2hpbmVzLCBwbGVhc2UgYWRkIG1lDQo+ID4gYXMgYSBNYWludGFpbmVyLiBJIHdp
bGwgaGFuZGxlIHRoZSBwdWxsIHJlcXVlc3RzLg0KPiA+DQpDb3VsZCB5b3UgcGxlYXNlIGxldCBt
ZSBrbm93IHdoaWNoIGVtYWlsIGFkZHJlc3MgeW91IHdvdWxkIHByZWZlciB0byBoYXZlIGxpc3Rl
ZCBpbiB0aGUgTUFJTlRBSU5FUlMgZmlsZT8NCjEuIGNsZ0BrYW9kLm9yZw0KMi4gY2xnQHJlZGhh
dC5jb20NCg0KVGhhbmtzLA0KSmFtaW4NCg0KPiA+IFRoYW5rcywNCj4gPg0KPiA+IEMuDQo+IA0K
PiBPa2F5LCB3aWxsIHJlc2VuZCB2Nw0K


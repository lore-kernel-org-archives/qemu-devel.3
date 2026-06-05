Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C8CCD6E7E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 22:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVctE-0007TI-NT; Fri, 05 Jun 2026 18:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=0616459cdd=quan.sun@windriver.com>)
 id 1wVctD-0007Ss-B8
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:19:43 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=0616459cdd=quan.sun@windriver.com>)
 id 1wVctA-0006dv-O6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 18:19:43 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 655KCpTI1370735; Fri, 5 Jun 2026 22:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 PPS06212021; bh=S8fLONGomXTZmWv6nHAFHD9b71h8Z8ZO2kff0CqFT+M=; b=
 XZ03c3gA6KSEPhCJgJPH/0/hrmAJXyZbEhiylkh2b/uBKS37s5Qa6i3Kk1gnLzX5
 4ZX4jeYTD1L3Lw95Z7Ag9ACXd1XFnJcR5NhTklyA+5SYMe1XWj+1vLEaJPhaQ5s9
 /M0YPmZBjLfG9JO5NdrjjW816U7K9w1oFIaRxt5k2Lj20H4HbNdEZzfeCMeEHQMX
 bhx98wSaP/0M+h9fDtS9hjEMLLcu9CUzyZoFgwplt+KtHFEnBYVaeI6VlUWqwvUh
 b5PjpVo376SnpDdQmH18vrYs389FaPLQYU8gCfH//VgNsmSm/PfQfwLzcoJYKPYE
 im3Dxx5+lPko3nKHhlLmgA==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012057.outbound.protection.outlook.com
 [40.107.200.57])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eku44h4ds-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 22:18:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3nw8ovOPS2Nl+4Yud+oC+R2/ld5S6/QaiJVoglK7ZoK9P6FNxO/75XzxbuaafJMYoe1HEHspCXvkQhh3zeK7YhPJFkXdH8U+yMMO64ex204i68n7pvv73HUEem3czWyBeGkBdmRnU6k9CqE3OJSYkAKPwYqqiAw4f9N2poK1owMrtPv601iF1O8v4X6ed6ZcuMNA15+6wKDvlQHtBzM5w+gq8a9ix7rWtv7/kllEdbbmld1P3lm0nECRUYs713JrumNTZHKvf4B3xw2edg9liVDUCX9Wn3pb7WH2Wf0OVBHoLMMHq4o1Z/sQoIdaIV+5NijES6HIgxgC+hk+OebSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8fLONGomXTZmWv6nHAFHD9b71h8Z8ZO2kff0CqFT+M=;
 b=c3j4wy+u/ZIQ0k8BIvyJx53DDVmFhoUGmh2CpQ5CQvzzlMsLNwm4uluTTkTjmNGe4/orzOQ9F4q8S1NzFWlmNfZoiKX61aZbLG7CR6I7hbP2maV1dBaIvDUYEJ2gTiUIixbYJnEi22b0cZUZWsB9wFEgmu645EiAyC8M7S4bdr8I1Yr3gO6bV3FAnfOGgHwDjyy0xH9WNNpftKhWgqQ6Pftjh60pSxkNiJpSlFz0d1zFozJDoe22xdTeRbGbBHoP5I6Y0lIBuKwEODZYlnYBaY46hCO60Cuhl+kqwk88vHr+OphruXpMP7gyGBwoEizvJQZy16VTyOl2HiL1UlhuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Fri, 5 Jun 2026
 22:18:54 +0000
Received: from IA0PR11MB7283.namprd11.prod.outlook.com
 ([fe80::6e41:656f:120e:8e8]) by IA0PR11MB7283.namprd11.prod.outlook.com
 ([fe80::6e41:656f:120e:8e8%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 22:18:54 +0000
Message-ID: <adb1f2be-18a6-4229-a363-b6c8cb48b518@windriver.com>
Date: Fri, 5 Jun 2026 18:18:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [OE-core] ui: Regression calling eglInitialize() since v11.0.0
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 openembedded-core@lists.openembedded.org,
 QEMU Developers <qemu-devel@nongnu.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Randy MacLeod <randy.macleod@windriver.com>
References: <20260528202639.4097815-1-Quan.Sun@windriver.com>
 <DIV636CRY5LQ.2KV03HIYY2WKI@bootlin.com>
 <be287797-1941-4afa-8aef-b015ca194476@windriver.com>
 <CANNYZj8gMc8PdWMse=g1J7goZC5Ga=nwN5hA+uX02-G+LNHEwQ@mail.gmail.com>
 <7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org>
 <3bde2ef8-5565-4495-9904-dd3db839de1d@windriver.com>
 <CANNYZj8St8Foj7C1RZnGPFmzsAFyCEjvXVZa9DD5Wv6YQ8u1TQ@mail.gmail.com>
 <237df978-b1f2-4c66-ab4c-5894f7a44a02@mailo.com>
 <aiKEeH2UZgdePzjX@redhat.com>
 <CANNYZj-x8efUVB9Z5d2T9Ye4so6v3zamHVTexRCGmzOmkB6EuA@mail.gmail.com>
 <dd1729c6-f6e8-4790-b166-a635e34b3b1c@rsg.ci.i.u-tokyo.ac.jp>
 <c091222b-6df5-4a88-92e1-15ec986046df@windriver.com>
 <CANNYZj-S4ZEqttMv55rF8dcv6K+Spje1beXjgm5N-DWUGMh1oQ@mail.gmail.com>
Content-Language: en-US
From: Quan Sun <Quan.Sun@windriver.com>
In-Reply-To: <CANNYZj-S4ZEqttMv55rF8dcv6K+Spje1beXjgm5N-DWUGMh1oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0326.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::25) To IA0PR11MB7283.namprd11.prod.outlook.com
 (2603:10b6:208:439::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7283:EE_|DS0PR11MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 65113192-3a70-4a72-d9dc-08dec3506d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jOZe4xTxeQEiDs6HEbIy10ad0vf03zTSrEcRvI6FfbMvWxq8aC5Vj1pFRU24Uc7OzdubKQ9TiJjJyBNEL0SooENVOJbU+AzczbhehI7yK+2/LxDJwLNhE4E4G9bPN2Znd19KG1C2BUtvJ8PUWHRA1eUIBtlcEZbdaUqAlwimtWpINxcOllAfOoZJjr0E90LJp3AQszfeZjRr8pFq4rAZ7CVwuhyWiX6wXNbu4cfGgg1WngbCJqkwq1i7s79WuMFKE63NAqm0m0jTRTS/bYcMbyAMLKPfiJG52AG1SZbrS/3H1BTg/l04XlRLDPADkiSi3AzXwIt8TdvMM/yeH+bUr2k+j3SPnrpRRpxsjnYmUF0GDrtizMc/9TFN0B+bGhgtZ+Ptj/o0ZkbjEhOjopYGCVeMeHxBZpMiXSOyro8C4bqDeEidyIC2cquUxECA1pvZfc14Ldz1sUJHt2syflj9dWr+gxm8g+YKt263mPe8OhwAKn45LT8FZt5crd8HHSXRRViYh5VXt/vk32iLpy4DXLMEIJsfHbEigxwKx52tlMvru+PF1MNkfX6+DuPva2hYIOIL50eGnthMB4noTNu0DFEqOJ2do4NCPpa2nAWrLZCclWhA0HOX3VcwDkYQvRF6X5QlsODfA9SvqvZ1MsNaUMdoIcnM+bJ9xO2KQ2TQAC7Hn8oMLXdlocVmmAmCbv3t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7283.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czFzT2lUV3dPdi92dUcxZXU2R3pRQ2V0Z2dET09Vd1QxcGEwQTZvb0ZQbVVi?=
 =?utf-8?B?QWJacUMwTFRZNkI4ZFFEOGpKUTNiMTJaWjJUdlVyYVpaQUpCWVA5czNHaklS?=
 =?utf-8?B?MUJMMk9qRHJwMllWRnI5UUQvODFYREVSVU93WGdoYjZNN1ZmVFBsTG9yUnpI?=
 =?utf-8?B?MHpKV2UxYzlzNndyYkw1MmVvVWUySUNIS1dKcmw3UDZJQURvWDhrZ2J5Qlp5?=
 =?utf-8?B?b0gyZi9mald2V1ZCSGpyUnFhNmJpcTNjZlVacDJ1dkhjaTVlWDIrbTFPeXJE?=
 =?utf-8?B?U0UvdkdhcXVLbm16TnNQY25tdXkyWUJxZ0d2aFA5ckpiZThiZW9GZFZXY3BD?=
 =?utf-8?B?UEpSZGtqYlNLUWNOV24xek93UnFPL2FSVE10cmVPQ0V2YitsRUNqWG8wQytH?=
 =?utf-8?B?SENQUnkwek81OUVteWFLZjBXUnNxY21wWGp0ZDdDWVpHa0JJM0ZOSkxTWG9Q?=
 =?utf-8?B?NUJxMHZDS1VZUy93aUdaVHRadlhjNGhOTGgxTnBsYUZBT21IY0hQckxEd2xH?=
 =?utf-8?B?RFJrazB2ZEx0a2ZhQW9wVm1SVFJRREh4L3JCMVc3a1FodGNOeldkWUR6c0FM?=
 =?utf-8?B?N2xxcGhweUR3Vzk5SkVBdE5Ya05IbGViRlZ0WkxIbmRyUmp2d1g3Wnd6a0Zl?=
 =?utf-8?B?ZnZ5akNReWFuVFlXdFpYRjFYQTY3Y1lCa3J4cExySmsrcFJwRmtOUUVlVnlB?=
 =?utf-8?B?NklaRGFDMnQ2azdmcm4vQ29xZzVrVzhqaStUZXIrY1VlTldSa0xXd0xEWGNo?=
 =?utf-8?B?MUdLamZ2SXQzQm9FRVdaU0NZTkJtM2lhbCtIeXdxM21aWGRwSmhNUGVrdDg1?=
 =?utf-8?B?VEFDMUMrTlpLeHFwMmNMVGRCOHJXcHVScW5WUjk2TU9zcUkrL2p1M3JLTFJE?=
 =?utf-8?B?dVlJL2VEdzN6L3puMEQyQ2hYMDhrdFRneHExZ3R1ZWtjc1Uxc1NKTjhYay9Q?=
 =?utf-8?B?NXJ4M1ltbDJSN3l5bDVYcUFia3VkZTBoa3hHWStjOVh6YzdXeEpBbU85VFBp?=
 =?utf-8?B?Zm5tNWt5Y0pORjd1UGxMblowM0laWHcxcXJOeE53N3NMMnhqaGZWWjBwR3FU?=
 =?utf-8?B?Z2RUdzNJQW9tUUROa3Z0U0NNN1hsa3hhb1BOdDFUYldYcVlFMlIzbDRnYTI5?=
 =?utf-8?B?amc2RnV1VEJ0YjZvSUdpNmVVcUhHYmx4czNNb0oxSXViOTlBcFkrRFd4UVlC?=
 =?utf-8?B?TDVucEdGZUhzdEdNZlQ4QW84Z0Q3NVFnMm0xQTRkdWZyQ2tDbWI0WWpzTndN?=
 =?utf-8?B?cXZEamxzeUFKV2M4NDNPWFh1UHlNVWlISmYwTDRNcHI4RmRMZ3lwdVJRZk5H?=
 =?utf-8?B?SmdCYkp0OE96M2UyVTBKWkp4VHBybDJ0aTNGZFFNZTBoVUk3TTUyaXpKS0Uy?=
 =?utf-8?B?OVNUZDRKNHRQV29teWNLSW1nT0xnYUxGLy9zc01xNjFZLzYyTWhaQ2FLYmFQ?=
 =?utf-8?B?Mkd6b0JNUUQzdUd5bm9iSUswQXozTCthRnNXbUppYk1HS2ZmSEh5U2VXdXFW?=
 =?utf-8?B?eXZwV290eUREc0JXYW1yQWJTOE1wWXVFMStqTFdCaWdra05XcEtxc1hwaUNk?=
 =?utf-8?B?M1p4R3pQSSs1ZDhZOWcvbUFxZGVGYnl5T2VGc1BrY3pNNDJubWJNWk5yYkdn?=
 =?utf-8?B?NU1OWXhyYUZMRUt2c21EY2x0RU5lWHBhWTBlMlVNdHRETnhYZVJYUHN1MFlo?=
 =?utf-8?B?N2RIUjhYeW4zZStaaEV5N0h5ZDRmTVdCVVR6bU9vbjhNdlkvcU1UdG1DYjdJ?=
 =?utf-8?B?ZHk2WlBtOU5aaFVIZmxGN2xad1ArN09LSlBuVWJabmMrY1pIcWVSU0pUeTMw?=
 =?utf-8?B?bmY3VmxENENPcUFXU2Fud3dzaFkyeTZUcGdIQkYxU1ZTa3YxLzFxM1UxQ1Mw?=
 =?utf-8?B?L1pDN05EenB2WTBEc2FRM2I4Y0xKcm5XVzdTWjI2dmhocHZqOVEvV0t2LzJi?=
 =?utf-8?B?cFJCd3BvZmJGQk5neFlnVUZTc2c1bDBaVjM5OCt3QTJRTlEwQ2dCOWprVDhW?=
 =?utf-8?B?cWVEbWI3VmVzUmhDaHJqWmgvWWJvZ0t0bGNHU3VaUEhGMGYyOWxPd3M5OVkz?=
 =?utf-8?B?UEZoQmJMLzlIU2kyY00vb3VNUlNvZC9iL1c4QW1XMTFvb1EydUI3b09NMjYv?=
 =?utf-8?B?eDd2TzR5dWhqSFY0Njk2WTdlc2h1WnZMM0N4QXFuL2UwVnBQd3A3M1BUbEsw?=
 =?utf-8?B?aFRITHdqWGJkeFlLMCtjVWNzZFdyc3F3alVSZjBLUGJDWmFRNmNFS3JrRXg5?=
 =?utf-8?B?Ym5WVkhJQ3lxOFQ2MEx1NWxRN0txZEoyS21ZekhVaTdQaFhyY29SYXloeUVk?=
 =?utf-8?B?K0N6MmlGZmFSZzUzdFJ4Q3pjRjdkcmRmakgwWEs5OG5ybzhkUWRCZz09?=
X-Exchange-RoutingPolicyChecked: ou30JWmhY3rnMNOCHSWGabDq8a1kn6Z9z/ONT2XEvRjcqLhk6Z50p2qIkTujv4dGeFSPy22Hs5I8jwJUD3jKpPk1Kpy5hbXUMZc6D3Ik021t0Btsl36WZfuvOSoZ0SuG72lXIGAW1FO9OCspFKyWMLc74bO4IfTZ6A5kqAuYoHJepnHDWAK30HzgKIGY3GfoDkxjyzlMt5TqzBzSgSSgcXmyTQqVY6PjeWrt0txTCYzYdDbABFE0N8+GFzk6uNWY9ntGeKTQsWNifJTXXCI4AgfKHaAenrTe8fxIXJBHLw+tUTxZ1nzpwzLgV42wd48+gUbVReapihyr9zAXw+wqIg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65113192-3a70-4a72-d9dc-08dec3506d8e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7283.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 22:18:53.8152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDSKuc5v80SUqKm4nxEydHrnlHwvAnmcF06J9keL5eD65ClSvzL3/ykzclmHXw07UFRH0rCM3Hv4PvQl0sUJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDIyMCBTYWx0ZWRfX5WluXwqlol8A
 YNlxhpHxhuzmd9AFZpJcfgpGKUWJUFtv1SkuOILBnUdB1QIjCNSGtSwM21Ptgnl7OgU+EQ/8nJJ
 CErQkFDWl+G8bsqawzu2/9mmvGyfdVf65uKNjiz3LDwproGPNdpOaiIkRoxSBLsBIu2VufysdW2
 td1T1Dz0KYBU+xK4jgY1/WwJ2xxzMLOrsD3hW7JJtYiJqnl3z/DLPPTDsnopXePtpcL1NHUjEPa
 5bWfYhyqZ6whB91yTKvAP7bJRCFZHIB+zh9qXra8yn1kgF10evV3uKQJsUQrALAKNa8+Q7mH3Pa
 W9almFrRQctTv24YAHOE+cHIZzT/y5vEjxOWgKcrk3Y/tIflmoCCU7haUPXFIZuBlR6k4gA97XV
 q/jKpqfJDqJY+sOi/mCTe+uF29BwMS6C2mjVBRFj7cXR7NLJHfdrCx6OtjhV9yKB5RTD5L8yBQz
 UuLehe50q7qaJs0wNMA==
X-Proofpoint-ORIG-GUID: 0MbKHkx5RfG-S5X0RYvkrw0GYqXNhtr1
X-Proofpoint-GUID: El7nj5wucnCzTI488KDqUnvt8VtF4y3Z
X-Authority-Analysis: v=2.4 cv=Co6PtH4D c=1 sm=1 tr=0 ts=6a234b51 cx=c_pps
 a=sWN/8n6q3Grq+dQ3JdI7kA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=Q4-j1AaZAAAA:8 a=4BZjeTlFFzG9f9GVCtYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050220
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=0616459cdd=quan.sun@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 6/5/26 3:55 PM, Alexander Kanavin wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, 5 Jun 2026 at 17:21, Quan Sun via lists.openembedded.org
> <Quan.Sun=windriver.com@lists.openembedded.org> wrote:
>> I think I mentioned also in another email that this commit 52053b7e0a
>> ("ui/sdl2: Implement dpy dmabuf functions") may have caused the issue,
>> which added the sdl2_set_hint_x11_force_egl() function:
>>
>> static void sdl2_set_hint_x11_force_egl(void)
> This is correct; I've confirmed it by adding a revert and re-running the test.
>
>> The above function probes whether EGL is available on the X display. If
>> eglGetDisplay() returns EGL_NO_DISPLAY (which can happen with llvmpipe on
>> certain VNC configurations, for example), the hint is never set, and SDL
>> falls back to GLX.
>> GLX then tries DRI3, finds only the vgem driver (no real GPU), and crashes.
>> In QEMU 10.2.0, this function didn't exist — SDL would use whatever GL
>> backend
>> was available (GLX with software rendering via llvmpipe worked fine because
>> it didn't attempt DRI3).
>> Possible Fixes could be: Setting the EGL hint unconditionally when on
>> X11 (remove the probe):
>>
>> static void sdl2_set_hint_x11_force_egl(void)
>> {
>> #if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL) &&
>> defined(CONFIG_X11)
>>       SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
>> #endif
>>
>> }
> All of this is yet more AI-generated nonsense, and none of it is true.
>
> Quan, I appreciate you want to help, but please do not copy paste AI
> slop without carefully checking its claims first. And if you do, make
> it clear that you are providing 'AI advice'.
>
> Otherwise it only multiplies confusion, and damages your own reputation.
>
> Alex

Hi Alex,

I think one of the purposes of this kind of email exchanges is for 
technical discussions and exchanges of ideas to resolve any possible 
technical issues in the communities, and there is no need to have any 
bias on the way how other people work or dictate what tools they use.

Based on my past years of working experiences on virtio-gpu/mesa/drm, 
I'm pointing out a possible scenario in the following call in the 
function of "void sdl2_set_hint_x11_force_egl(void)":

egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);

It could occur that the above call returns EGL_NO_DISPLAY or it crashes 
before it even returns for the specific setup.

Thanks,

Quan



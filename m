Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37D6EC1E86
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 09:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnvwj-0003mn-87; Thu, 05 Feb 2026 04:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vnvwh-0003mO-QQ; Thu, 05 Feb 2026 04:46:43 -0500
Received: from mail-norwayeastazon11023138.outbound.protection.outlook.com
 ([40.107.159.138] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vnvwB-00028E-Nt; Thu, 05 Feb 2026 04:46:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig9cK+f5XIM3KnQ4WDbhE3NGtpWvuImomgAYK5F34iAJVFVeSDtEaYd+js/VyVOIRamVGTe0g/mbMmAoAxi/4o1R3SAXBW3ZPtW2t9/ic6Mhwf1yT9/nGfzINAi7OVJzqnYj3Y1G5UoyvZGQYk/UDZVnwt8ohMnCubiH8gMJKz1wj2lUsilnyD3nFDz925UhFxJDRK7d1FF91GcA8ZdqBzBXtbspMVhYTpWl2EO3Hmhgd3e6rfHKpLJrTnvw0UQ0HvWtUm6TFG7TNQokMKjZCnCwi9r/1tjOc0kWkTU5ksZtRnQOWwksQ+HFmzUkkFEv2IggqmOvBJ6cIN3bOKF5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFUvVpA51+RiCrD07c9pPgHw2A+x9t4qWEvY2tlsshE=;
 b=qHSNeuJ4gosRnsnLC5TNMpf/0xxlRqJTL/7HIrx7esv+5VHSB1LKjwGEEEuMQ4LTVsCVpdPl7RelBCzZy3CXsrS4TLAMSlEBKGlbT1tG/1XMx4T3zZVWJXr4ihMFtrH2u+c83IPOp9lqzC3c/0cdN6uhUr4XlTY/6fJ0Lh+7N31XMIS6o8mxSctuiKmACiRDu69y1RYiTTst64aD11z9/kDJAmSCEA8swT6Lqes9e7vKjPHEaPBTtPImAwDaABxLrrGdltEfZXax4VN6qY8qRSalAzCwLZTiH9rtWGijZMES99sMXKvhCvTeOZHTQ0KXU89b9PcTXvvcXHsyz1lzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFUvVpA51+RiCrD07c9pPgHw2A+x9t4qWEvY2tlsshE=;
 b=G8pcLMLjTVB2RzS7blE0iu5+PIKC5cEgXGWZFoSlEVbklSgZMDg4s5D8c5ChFJwyto3Qn3rv37nn9lpXKUC/rthDAZOKxwIpnFu68XIPx5+oYajT7EQV3dSKGE1EMwWjw5EHN7b2TlPFw9Z0iafLhoIJmKX8Dnm6WaSP/PmEoONXQrIAyZoPUkjF/pI1gluYXDAzJrNB+7UCmCFPiQDs7uxFodtNxLynjD3Otac/FFc3dNwOy7EK+pyRGMDdIejXRD5RpqCUH8+Ajl/4+4AdlK1jRGuJspfkD1/L5xxJw7l6XINp0xLZlycRSq2420FPSB55I33zlYJsCtFXfHFCow==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by AS8PR09MB6188.eurprd09.prod.outlook.com (2603:10a6:20b:5b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 09:40:31 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 09:40:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH] riscv64/test_boston.py: fix intermitent test timeout
Thread-Topic: [PATCH] riscv64/test_boston.py: fix intermitent test timeout
Thread-Index: AQHcjuubdhWgVupRzUKjz1WcHacsLLVz6RcA
Date: Thu, 5 Feb 2026 09:40:31 +0000
Message-ID: <f9cd765a-1cb6-44be-92d9-236db10ac3f4@htecgroup.com>
References: <20260126174534.9860-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260126174534.9860-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|AS8PR09MB6188:EE_
x-ms-office365-filtering-correlation-id: 4464f738-2b1d-4d2b-a86e-08de649a9a5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?b1B1MDBqK3kzaXpkRUxxb2xydFhiR3ZFTnpJaUl0dUc5Tk80NWJnTTZnOUNl?=
 =?utf-8?B?UmFJMkdUOWxsSHZGNWFnOVZQZTNnMnNKeTR5cENCcWJtR2xvWWlTMWNYQ2o5?=
 =?utf-8?B?a3Q3UXJsR25uZWxEdW1qY0FkMFpUSkhGdVhaSlVLOXhVNTVRTjhuTXVhaFY1?=
 =?utf-8?B?b0VkbGwwZHRIZk1MV2RxVDBvT1IyNC9IcVVjNmxYbkxoYzk5Z1E4ZFNWcVBQ?=
 =?utf-8?B?QVQyZk9JQUFlNVNaNGxPUmxVNGhFcXVkUjdjSk93VGMzK0hvK1VqUXM2aWVr?=
 =?utf-8?B?czB4V3BYNWtMcGtVa3pFSFNmNnFZdm5Rc1J4Z2pMVlNKcjYxRlFkaXNuYW1s?=
 =?utf-8?B?YVBLSXZQQlNvNEltTWpZZnF6RE1ONTM0MStpdW5TdkZpWmcwMFhHeklxaml1?=
 =?utf-8?B?R0U3K3NGTDJCL0hVVmpBWi90cU9qNUpsWkVlbFpSWk9sR2syMVZDSWI3QmlO?=
 =?utf-8?B?VjVLZ2hyT0IxcFdQSGJiUDhPNjBUejE0am91WktHN3lFRlVIMUhmOTVzeDYw?=
 =?utf-8?B?UmhQaGFIUGt2aWtwY2NGWHZXNUZKNmRrZlZTcE1IMURnWCtmZXJscmhXZER2?=
 =?utf-8?B?dWY4UVhBWkFrRTBtTzl5ZWlodkxNNUM5REhwNFRrOVBTNWxqazNWZDlMY2wy?=
 =?utf-8?B?d3hvUUJYWEQ5VmpOUktpK0I2MU1la2tsYk5pQW1QOUxnczU4Y1RuSlIyZEpQ?=
 =?utf-8?B?VDIzRVVLazFhU1UvelRtTCsyVVJYVkZ6MlUvR1pTRnRQNmRoVitweUdtMVFC?=
 =?utf-8?B?eXBWdmI4YXJsK2dCSzBFNnhaQURxRWk2amNPTWZzZFZ3MS9uemU0MzN6Z2s2?=
 =?utf-8?B?bFFxOWhnVjAyK0xpVUF3bjgyZGNsSnJMRkhlejI5eFl5c1RtVElZSlgzcHNT?=
 =?utf-8?B?S0R2UEhrNEdpRVdqWjdldHNCbHAxZVZkZFU2V2tzV0RpMElPUVY2NkhXTWNY?=
 =?utf-8?B?MCthUnl1OEdsVUpnOVN1YlBpM01BelNUdFhJZE9qRS9qSlR3L2x5SEdoUzh0?=
 =?utf-8?B?V0xmc1FDZG5ZQWZlczVnQzNKUlNCaVdRSmpsUllvdTdYUlg0ekJYeVBlb2xn?=
 =?utf-8?B?aVdZQ1p3U0FzTmF2UDFnbnArd1QydElIZGJrT0hSWWd1cERJUXJ4VFZvdmJM?=
 =?utf-8?B?NkNqelY1YkRaRlhyVEF6QkgvR3FPNklFWTVYTytmUTN4a2NPQlgrWUE5Sm1R?=
 =?utf-8?B?bmd0OE9ZSjFzVUxRNFFGbUJWYzI0OUNjYUxMd1IvM3VFa2tqQmEzNkJTUjJL?=
 =?utf-8?B?VDlOUldaK2dJV242STF6UlZnYlI3ZkJHMUV5NllUa2ZpdVZGTjlCQW02K0ZB?=
 =?utf-8?B?M0JMVTlUaml5MVdHamdINCtyTnlmQWJVU1lucnJjbXJKdlZqTXpzN1FJby9a?=
 =?utf-8?B?U2dYMHdSWDhvUUNEejRYcFJsd1RaUHh1WFBlRlJ0YTVGeXJ2Zkh4ZEdYT2Jj?=
 =?utf-8?B?SHJ0ZXVqUldUMTVtVU5mbVRuN3d3Q1VkQUFYaTBmZ3RVUTVSRlZCNnA0cVVt?=
 =?utf-8?B?enUzaVYwS0NwaDFxZTVDQUZrbmJCL0pjZFRwK1VjcnBURlBWWjFzMy96Unhu?=
 =?utf-8?B?NitjL3ZtZ2lJampFcDNFSUNpOVhlcXNmOHByRExwejRnbGZxeFA0em1MOFN0?=
 =?utf-8?B?UitrZW5maGFVZ0xmeVJvL1FxYWlkTzNzTEE3aElVcSs0UFpobnA0ZWY3Um40?=
 =?utf-8?B?UncvMGh2SktGbnNjZGhBN1UyY3dIZ0ZZcStEYUhPSTRVVUZvckQrUmNWTm4z?=
 =?utf-8?B?SVl1VHdDT05OQmRDMXlub1RRMnZOOGZuOU1YSW93TVE0ODc5THpwOU5mVFhv?=
 =?utf-8?B?UThSY1U1NVlJaEo5TEIwdE9vZHkwWEtpdWk0MHlrNzZ1UUxGakdJM0w1L2Fp?=
 =?utf-8?B?OW9Cbmp3Z09TYnRld1RjNGNUcjRReE52QlJoNllWZjRkVHhjOG9RS2NKZmpB?=
 =?utf-8?B?QkZmMWRFemhZbkg3UDE0Z1FQYTF3dUZDQ1pOSTl6RkFoVlZRMTNDUEd5c2NU?=
 =?utf-8?B?THVmbUw3REMwbWUrUmJ3Y3RES2xXYUJwblI1QTQ0Mm1IS3IvdUM1NC9HMjRQ?=
 =?utf-8?B?TlVVbGQweUlYcUxUM2FCWjluRHFUTnlUejZBeDk1VVJHQ0RnZllUdnNEQ0RO?=
 =?utf-8?B?TnNhZyttdnhzeCt2b1A2S2lDTkMzTG5veG12d3liYUZ6NjAwd1B4YW90aUJJ?=
 =?utf-8?Q?f9iMNWDYekS5QRTRTnefSg0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak9nWVJXYWtQSXZrSTRIVm1reWR5cWZSdFlqeElhNTFsTU9tSEw5R3MxMXpk?=
 =?utf-8?B?WlhESUhWRmpsTC9JLzQxQVljaVNtRnBRbHRqV0tMdCtsV1MxWkdZdmhnUGU4?=
 =?utf-8?B?dXRoUXRUdGQrckoxRjVYQWxYdmdIcVVMZSsrNCtYaDR2bStZYzZVbmJYQmdr?=
 =?utf-8?B?N2xKZXU5OXYxNWhRekMyUmRBSUl2eTkrZHpzb3NDZUdxdEVyMkdzdEdNajRG?=
 =?utf-8?B?RzIwNGIxQ0xoR083VE1LdlVzOWpSMWloZkxsQkZadURhY1VML2hjVFlLaXM3?=
 =?utf-8?B?U0xTQ0hwSVR5RzE4aWE0Tlg2bFYwOUpuOEtLM1dJVkJ3T2kwempBZk1KV3NN?=
 =?utf-8?B?MHR3dlpwd3RPK09rbG1OK1MwbW83LzRDdmJPWkVYTUlGWGJtb0kvUGM0NnQ3?=
 =?utf-8?B?YVVBMTVvS2M3YzVRUkdvdWZWeWhLUTVxR3h3VXl6OWFkcy9aTy9idXdNd3FI?=
 =?utf-8?B?OW5QNHVYZmY1VnpaVXZYay8wMjFEOEk1cDdralBsdUFZWCtXNUtxUGxab3lC?=
 =?utf-8?B?TCtGemQ5NEdRbG8zV0FxMUlzVlBYNTZqYWEyV2JmcFYzVXllcVF6MG4yYi84?=
 =?utf-8?B?TzZJZnR2ZFhwejVjcGZzclhTUm9Ha1kwRzMzTEJoRmN3d2FzYktMZ1VyQUtG?=
 =?utf-8?B?RzJ5U2c3U1Y5VVlvZHlxZHZSS1VteThBa3lDbDQ4OU1FYWRodjU1cDVPbkxo?=
 =?utf-8?B?cFFub2RwUnN0TWtDSFVXaURabGhIY0dpSFByVWIyVS83ZGRqSHNveHJjVmRt?=
 =?utf-8?B?ZlhjcC9ocURHUUNOMEgxckZKSjYyVUVaRVMxdk8yMVJCVTRrVlN1N1hISjhp?=
 =?utf-8?B?VU1ZN01PSVNTdExOOTlmbDdUNFhiWWVvdGNLQndxMDExWHVnT2Y0M1N0Ujcv?=
 =?utf-8?B?bXQvSTliV2ZpTFptME1xZTNIRkFidXBXQ0JUOXJiUXJ0ayszN1RUaTJBbnlh?=
 =?utf-8?B?ejI3cGkzVWxobHk4NlErNm9IaHJpampweUxzWUFCV0tmQjh6bTVsNXZ4N3NL?=
 =?utf-8?B?NEFnaUdyOFlsL3dWeHVQQlhLc0o3M0tqTFJvUnJvM3lvVWtTVVgwZVhKQUZp?=
 =?utf-8?B?UmE5OHNSejF6bzN1TklKSzB1M2Q3TFo4ZmJTelhEelA0RmE1RGdlbXdyV1Fo?=
 =?utf-8?B?UFZZSldOalB3WTQzMGJlV29HTWVPb0Q0Rm1PUHlLQlF4dDJNdUVIRnZjR2lk?=
 =?utf-8?B?dVlFbnFybGVjcFNyaDdMQXRaY05ZWGV4bzVybStNbVFwNjNuekNlT2ZBRmdY?=
 =?utf-8?B?RW4zOXdTaFR4dGRIUndhNmdkY1RWd08xL1ZUR01IUWlXdEpZL0NCV09HNG9z?=
 =?utf-8?B?QmRRZVhUVW5lZFQyeGZMTHFIMzA4dDEwV0pDRFI2clJXYUlIUHVQcmNTa1R4?=
 =?utf-8?B?cWNDdW8zZGpOU1hUbnhNZkNST0hrNFYyTS9NVXY3UjBVUHRVZG1neS8vejhV?=
 =?utf-8?B?TEZqZHh1VVZHaEowNzlyK28zMjdjODc3MlFoaVN0UUZEREp1WU9zTURCSHBI?=
 =?utf-8?B?WVZTOVZyUzJZbmZ5dmJ5VzRTUnRKWUdjTGh0NXJLRENqVmxvTXlMdW90S1B6?=
 =?utf-8?B?RXNmN2ZoR2g2SStSZlFtK0k5K3VxVW1vOVVBMUlZZkRuNFcvTFh6S3ZpZUlz?=
 =?utf-8?B?UVJEZ0d6OHlKQ1d1UlBZNElSR3ZCUlJLdElRR1ZZOTZXbWtoQjAzWStlZEl3?=
 =?utf-8?B?Q0ZKSmUxanJxSGc5Rkw5UDFHV1ZlL1kvSzEyUnhXSTlpQUJycjBHZUNmWWdN?=
 =?utf-8?B?OThYZXhYUmh5dEgrZ0hlL3pWVFhPWnNaT0dKbVJaTTJTbTFGbWZvNXA5TnZ6?=
 =?utf-8?B?V3M4MnNaN1FBVW5LRVJiNzFnN1NXbGNtalAzQ1Njam9zREFVLzY1MStmakN6?=
 =?utf-8?B?Nkt0Wk41c2dJNy80MVNSdkJpM3RlM1hNZWNpOE4vUUdWVjJZR3VIQm1nWEZ1?=
 =?utf-8?B?ajhoWWx0enlzZ1dSZ2JTV2t1UFJETVg0c0lrejFYNTBUQWk5bHlmbUJRdzAx?=
 =?utf-8?B?UmdUYktsM1F0K0JjM1ZpazEvTDVPUE1qNWovVXBJVmpwSXI4T1hUeXZ6UzdZ?=
 =?utf-8?B?TTFna1RPNlB5cDdveG9UalVMbWQ1bXMxQVdkTjdIRUxCZ1FFb09JS29sMHA4?=
 =?utf-8?B?amlNQmFlcm52d0VDbm5oMjlwZnNWUEtMamF0WkZseHppMHBXamNPMXpwZ3Ar?=
 =?utf-8?B?MFAwY3k2VXdDT1ZXaSs5K25HNlgxdzVGTkNIcG5HN0xxUnd4Uzh0QUR4WWd2?=
 =?utf-8?B?NDZheVoyYzVId0xOanZRWFQ2T0MxZldEaCtSaUxYdy8xUkJBSHF5RmJmOXhU?=
 =?utf-8?B?aGx4YVBnMytLUlRlcU1GTEZXOHdlR0FNekwwczNjbEEzREN1OXpmRVV1SnlR?=
 =?utf-8?Q?Xv0qHe8o4ZqTwpZ3nfc9PbEeqUT2bubzbLrE4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8087EEFBA0E5848B92EDA51D0B15F5B@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4464f738-2b1d-4d2b-a86e-08de649a9a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 09:40:31.0854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujwkUHs6SSHGMQPxYd3ncziV2HeoG0cldeOABxwO8c0LLOIm0sfzp8ji8Tk0MXdxtlxFnv/cwnMo05PafsEzmlF9Sz/5d+b+GTzBiAGk4WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6188
Received-SPF: pass client-ip=40.107.159.138;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

DQpPbiAxLzI2LzI2IDE4OjQ1LCBEYW5pZWwgSGVucmlxdWUgQmFyYm96YSB3cm90ZToNCj4gW1lv
dSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0u
Y29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5B
Ym91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmln
aW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFu
ZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IFRoZSByZWNlbnRseSBhZGRlZCBC
b3N0b24gTUlQUyBib2FyZCBzZWxmdGVzdCB0aW1lcyBvdXQgY29uc2lzdGVudGx5IGluIGENCj4g
bWFjaGluZSBydW5uaW5nICdtYWtlIGNoZWNrLWZ1bmN0aW9uYWwnIHdpdGggLWogMTY6DQo+DQo+
IDE4LzE4IGZ1bmMtdGhvcm91Z2grZnVuYy1yaXNjdjY0LXRob3JvdWdoK3Rob3JvdWdoIC0gcWVt
dTpmdW5jLXJpc2N2NjQtYm9zdG9uDQo+ICAgICAgICBUSU1FT1VUICAgICAgICAxMjAuMDlzICAg
a2lsbGVkIGJ5IHNpZ25hbCAxNSBTSUdURVJNDQo+DQo+IFRoZSByZWFzb24gaXMgcXVpdGUgYm9y
aW5nOiBpdCBpcyB0ZXN0aW5nIHRvbyBtdWNoIHN0dWZmLg0KPg0KPiBOb3RlIHRoYXQgZnVuY3Rp
b25hbCB0ZXN0cyBhcmVuJ3Qgc3VwcG9zZWQgdG8gYmUgdXNlZCBhcyBzdHJlc3MgdGVzdHMsDQo+
IGUuZy4gaXQgZG9lc24ndCBoYXZlIHRvIHRlc3QgZXZlcnkgc2luZ2xlIGNvcm5lciBjYXNlIHRo
YXQgbWlnaHQgaGl0IHRoZQ0KPiBib2FyZC4gSXQgaXMgc3VwcG9zZWQgdG8gY2F0Y2ggbW9zdCBj
b21tb24gdXNlciBvb29wc2llcy4gQSB0aW1lb3V0LCBpbg0KPiB0aGlzIGNvbnRleHQsIGlzIG1v
c3QgbGlrZWx5IHRvIGJlIGNvbnNpZGVyZWQgc29tZXRoaW5nIGFibm9ybWFsIHNsb3dpbmcNCj4g
ZG93biB0aGUgZW11bGF0aW9uLCBub3QgYSBsYWNrIG9mIENQVSBob3JzZXBvd2VyIHRvIHJ1biBh
bGwgdGhlIHRlc3RzDQo+IGJlZm9yZSB0aW1lb3V0Lg0KPg0KPiBTb21lIG9mIHRoZSB0ZXN0cyBj
bGFpbSB0byB0ZXN0IG9kZCBDUFUgU01QIG51bWJlcnMgdG8gZWl0aGVyICJlbnN1cmVzDQo+IHBy
b3BlciBjb3JlIGRpc3RyaWJ1dGlvbiBhY3Jvc3MgY2x1c3RlcnMiIG9yICJ2YWxpZGF0aW5nIHBy
b3BlciBoYW5kbGluZw0KPiBvZiBsYXJnZXIgYXN5bW1ldHJpYyBTTVAgY29uZmlndXJhdGlvbnMi
LiBCdXQgdGhlcmUncyBubyBTTVAvTlVNQSBjaGVjaw0KPiBtYWRlIGFueXdoZXJlIGFmdGVyIGJv
b3QsIHNvIGluIHRoZSBlbmQgd2UncmUganVzdCB0ZXN0aW5nIHdoZXRoZXIgdGhlDQo+IGJvYXJk
IGlzIGFibGUgdG8gYm9vdCB3aXRoIDcvMzUgQ1BVcy4gQXMgZmFyIGFzIHRoZXNlIHRlc3RzIGFy
ZSBjb25jZXJuZWQNCj4gd2UgY291bGQgaGF2ZSBhIGNvbXBsZXRlbHkgYnJva2VuLCBidXQgYm9v
dGFibGUsIFNNUCB0b3BvbG9neSB3aXRoIDcvMzUNCj4gQ1BVUywgYW5kIHdlJ3JlIG9ibGl2aW91
cyBhYm91dCBpdC4NCj4NCj4gUmVtb3ZlIHRoZSA3IGFuZCAzNSBTTVAgdGVzdHMsIGtlZXBpbmcg
dGhlIG1pbmltYWwgQ1BVcyAoMikgYW5kIG1heGltdW0NCj4gKDY0KSB0ZXN0cy4gV2l0aCB0aGVz
ZSBjaGFuZ2VzIHdlJ3JlIG5vdyBhYmxlIHRvIHJ1biB0aGUgdGVzdCB3aXRoIGENCj4gZ29vZCBU
SU1FT1VUIG1hcmdpbjoNCj4NCj4gMTcvMTggZnVuYy10aG9yb3VnaCtmdW5jLXJpc2N2NjQtdGhv
cm91Z2grdGhvcm91Z2ggLSBxZW11OmZ1bmMtcmlzY3Y2NC1ib3N0b24NCj4gICAgICAgIE9LICAg
ICAgICAgICAgICA2MS4yOHMgICAzIHN1YnRlc3RzIHBhc3NlZA0KPg0KPiBGaXhlczogZTcxMTEx
ZTI2YiAoInRlc3QvZnVuY3Rpb25hbDogQWRkIHRlc3QgZm9yIGJvc3Rvbi1haWEgYm9hcmQiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YSA8ZGFuaWVsLmJhcmJvemFA
b3NzLnF1YWxjb21tLmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rl
c3RfYm9zdG9uLnB5IHwgMTkgLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxOSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvcmlz
Y3Y2NC90ZXN0X2Jvc3Rvbi5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X2Jvc3Rv
bi5weQ0KPiBpbmRleCAzODVkZTZhNjFkLi4xM2M0NGNhM2UzIDEwMDc1NQ0KPiAtLS0gYS90ZXN0
cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9ib3N0b24ucHkNCj4gKysrIGIvdGVzdHMvZnVuY3Rp
b25hbC9yaXNjdjY0L3Rlc3RfYm9zdG9uLnB5DQo+IEBAIC02MywyNSArNjMsNiBAQCBkZWYgdGVz
dF9ib3N0b25fYm9vdF9saW51eF9taW5fY3B1cyhzZWxmKToNCj4gICAgICAgICAgICIiIg0KPiAg
ICAgICAgICAgc2VsZi5fYm9vdF9saW51eF90ZXN0KHNtcF9jb3VudD0yKQ0KPg0KPiAtICAgIGRl
ZiB0ZXN0X2Jvc3Rvbl9ib290X2xpbnV4XzdfY3B1cyhzZWxmKToNCj4gLSAgICAgICAgIiIiDQo+
IC0gICAgICAgIFRlc3QgTGludXgga2VybmVsIGJvb3Qgd2l0aCA3IENQVXMNCj4gLQ0KPiAtICAg
ICAgICA3IENQVXMgaXMgYSBzcGVjaWFsIGNvbmZpZ3VyYXRpb24gdGhhdCB0ZXN0cyBvZGQgQ1BV
IGNvdW50DQo+IC0gICAgICAgIGhhbmRsaW5nIGFuZCBlbnN1cmVzIHByb3BlciBjb3JlIGRpc3Ry
aWJ1dGlvbiBhY3Jvc3MgY2x1c3RlcnMuDQo+IC0gICAgICAgICIiIg0KPiAtICAgICAgICBzZWxm
Ll9ib290X2xpbnV4X3Rlc3Qoc21wX2NvdW50PTcpDQo+IC0NCj4gLSAgICBkZWYgdGVzdF9ib3N0
b25fYm9vdF9saW51eF8zNV9jcHVzKHNlbGYpOg0KPiAtICAgICAgICAiIiINCj4gLSAgICAgICAg
VGVzdCBMaW51eCBrZXJuZWwgYm9vdCB3aXRoIDM1IENQVXMNCj4gLQ0KPiAtICAgICAgICAzNSBD
UFVzIGlzIGEgc3BlY2lhbCBjb25maWd1cmF0aW9uIHRoYXQgdGVzdHMgYSBub24tcG93ZXItb2Yt
Mg0KPiAtICAgICAgICBDUFUgY291bnQgYWJvdmUgMzIsIHZhbGlkYXRpbmcgcHJvcGVyIGhhbmRs
aW5nIG9mIGxhcmdlcg0KPiAtICAgICAgICBhc3ltbWV0cmljIFNNUCBjb25maWd1cmF0aW9ucy4N
Cj4gLSAgICAgICAgIiIiDQo+IC0gICAgICAgIHNlbGYuX2Jvb3RfbGludXhfdGVzdChzbXBfY291
bnQ9MzUpDQo+IC0NCj4gICAgICAgZGVmIHRlc3RfYm9zdG9uX2Jvb3RfbGludXhfbWF4X2NwdXMo
c2VsZik6DQo+ICAgICAgICAgICAiIiINCj4gICAgICAgICAgIFRlc3QgTGludXgga2VybmVsIGJv
b3Qgd2l0aCBtYXhpbXVtIHN1cHBvcnRlZCBDUFUgY291bnQgKDY0KQ0KPiAtLQ0KPiAyLjQzLjAN
Cg0KTEdUTSwgdGhhbmsgeW91IQ0KDQpSZXZpZXdlZC1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPERq
b3JkamUuVG9kb3JvdmljQGh0ZWNncm91cC5jb20+DQo=


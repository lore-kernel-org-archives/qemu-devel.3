Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0A8C3DA40
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PIB-0000Dn-77; Tue, 21 May 2024 09:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHX-0007it-4P
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:56 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHV-0001Zh-5D
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297113; x=1747833113;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=l9bNcp34tf8qesLcsVgJklrBtutAApnNrmDyzOeqyZY=;
 b=EUKVoQUzNQA4x6xcY9Wh/WidqfQ9cO69YQ41EzgtEKWwtJaux5u6/VTo
 bAGH+/CbJZ3QLHUliW5QWBToWzAAHZ/mPTpJR9H2u8vhzvJ32uQxIjp6e
 dWtwsyPbq/+01/Jp1bLXoaAbtm4ROHlK93ct3kPbIRhfIla1Bti9lraX/
 pK051gNSYXmbA4Fa6FT0EUSlFlFHVzUgyZrJu2pXYZCsUWOaSfz7ewKgM
 6sIZOF+OFPYO7iA4iT5O8K41+riennEdw8qYItF1lenLM5z2TO9cyvo1n
 ltGjnLQQRvR/gFyrxph9BbDbNEv0fgsip2H2aO8GXgYum7PHNJDkvYKkV A==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13061509"
X-MGA-submission: =?us-ascii?q?MDGeQrvyXfxkoQAnmOavVki1omy8P4Vl5LuINw?=
 =?us-ascii?q?ww29b7lYci8Q5FI5c0OttXmyDIaCBkv9cXkOaUtQFRs+HLpQ1udkhNMK?=
 =?us-ascii?q?lSwke1zlAqGWDEJXEJMN/nbzgNb6i5ayjCTW8g5anPPJ3XzjUUsGqOxs?=
 =?us-ascii?q?ADE+8zWELpOjnMo5woW4mVYQ=3D=3D?=
Received: from mail-dbaeur03lp2168.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.168])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDHyqTfPNULPPy8jS2GVsibyubxSVtWgtMqbhmC+1SDZZECQSN+Epb0vecMvhE65smEq/9KN/hmCi53HtiWTBK7QuQMvIgtCGceH3NA449QMgA27n3Adw5S8fKDzFYl/U2bFC+lG7Xf4Q9U5NXetr8wF5ZqUaj35gccvCfQsHAPxR/OEaqPg722EuY697Gnlhp6R5/LcGA0nPbCHOMpH2dxVvK8AIs7rSc15NBDQWMYEN8Cm4WH+glApbzvEGcndP9m6RHfxUIGB1q5A17K1tWL3zQ4Ni2IZqnuBycirAX6TgHBKXCol7bsYHUwFsVrrCB847044BR3OXIEhkNvsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9bNcp34tf8qesLcsVgJklrBtutAApnNrmDyzOeqyZY=;
 b=NVKT+ym8oIro7p4ZJ+Xp283UDcZDOyUl/boqrhb8i8UqC6y8ifyGgnvr19koG0Cy16HojO0h/oEyNYr05HMcF8M/pwj4ICm9Wu49OSNbbCTntxQiOCn3rXhiXyr5sT1GNsi9F+kSGOb0JWVTYV2aeZOBwrJ8+KfAdGkZZHGQHFYdmkp5eeAqdpIFtk/2J2HQRVOw4xkeXXd5kVkLVULXpuI06IR+zT3pkxwmlhLHKisu9hcjQgzHgOX5F6rQJbs4NYMl5XrMkeiJSQvbqaFtw1JHf8FFjYplxGSJyshRDnfglzz8F0GFsXd6kmFS2cEIhGkhBl3Cp+KDOmsB7Dhp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:48 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:48 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 15/22] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd 15/22] memory: Allow to store the PASID in
 IOMMUTLBEntry
Thread-Index: AQHaq4BwMKxyUNJbN02mJJyi62Xrcg==
Date: Tue, 21 May 2024 13:11:48 +0000
Message-ID: <20240521130946.117849-16-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6249:EE_
x-ms-office365-filtering-correlation-id: 39a9c922-5dc4-490c-79c9-08dc799792ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Sk1OV2VpMGJjN2YyQWwvd28xOW5KY3FsREJZc1hNN0ZIQkJOOU9Za0FzSWZn?=
 =?utf-8?B?djJsRGw0N3FmTmd6a2RUSGFrcjZ6T1FWVGtpUDhEM1pKdkx6YzlmZkpRa1ha?=
 =?utf-8?B?RDYwTW9xc2kycVVRdng5WWsyNHhEUkl2ditYMUdwMEhldHVpclBXUnVhOE5m?=
 =?utf-8?B?YjhNSHJ4WHdwQThjMUI5bnN2ekVZU0Z2YmVkS1V0Q09QajdCU1JNVk43d3FU?=
 =?utf-8?B?dnBKYXhGVlVmSitkSld5Q0RIcUc2RFI4dmF6WjB6MFdQVnMzNDdFcU11ZnhO?=
 =?utf-8?B?aENKMGdsZmUwMUkyTTFOYVpHeit1K0hsak1NUkZyZ21ZaFh5cWRLaUNoOERC?=
 =?utf-8?B?Y3BhcVp6c1lwQ0NvU0dEY01yeTdSZy9HcWcxTW9ERGFaQlhZeHowV2FZN0VP?=
 =?utf-8?B?bjlSSFV6Y2h6eDZZeEEwb3NyOE85SCtDaEtaMlhwRUo0ZlNuaU9hRnMrMXZB?=
 =?utf-8?B?ZjRZZ1JiM1B0OHNSd0lNS0h3b3ZkaVRuZFpuQnBEQ2pybUE1UjVkbmxXYVpm?=
 =?utf-8?B?S2E4b0RZd040VVlGYnRrOGNVV05vUEZBcUpvSjJ1TVdHeUtLSWJab2RzSldw?=
 =?utf-8?B?TDVxUHAzenk2cENaM1BORUwrbDZiU2hkR0FueVNqQWNLekR6bVBvbjZqS0Fk?=
 =?utf-8?B?ZzRGNWcwcTE1SUlvNVFEcnZETTdsUVFXb2lXVTBFMDF1TVJDQTVtazllRjdh?=
 =?utf-8?B?aXVLMFJPUEVCeE40TmMrak1ubVNCbzAxbUhxeThmc1lDQTdYeHNZdHRVTXFC?=
 =?utf-8?B?bHQ0M28vRCtDWGtmUEhSNEtoalpZRzY0VWMyalVWNnVOOXQ3VlFpQ09WVGEz?=
 =?utf-8?B?dEpFRlM0dGEvQVZLRGZ4dlVIcW9uQm5QM1c1aDdHWEdqRVVrZE96MEJYYUpQ?=
 =?utf-8?B?OXFEbHpmeFFLSm1FSHBNR0UxRi82R09ZcWJjUmRaVjRNWkR2aVlTNVZ2cVV0?=
 =?utf-8?B?czBoYkJET0Y5QVAvU1M5b2FMN1FvZ3JzYldFLzhWNENnQnFBSEFQQko2U3dL?=
 =?utf-8?B?TlFwOVNxWGE4d05mMmVENGlRQ0ZnVWVVcEdScG1naEtlT3FrUklxVHdnbDJr?=
 =?utf-8?B?cEJhelVHT241M3lUVlhWWEI4eHFZWjBFRXU1aUF3L0lZak5nTTIyaTBtTVIy?=
 =?utf-8?B?TFp1ZFZGT2E3ZXExdXpvOHJOMmhsSTBoWFNMdUlGZi9kNzFFYllVbUErL0xI?=
 =?utf-8?B?Sk1TZW5NYzVwK2hIelVSNDFITjlKYzF5WE1ReHVycFAxM0w4Q2NyNFgzYk9O?=
 =?utf-8?B?SG5KV0V5bDl5dHRnVE9udlpWVlZQV1ZJbENZMElSS1E2Nnl4dEZYMTM1M0VF?=
 =?utf-8?B?dG5Lbm03T3F6Y21CczdFb1N5RGZrU2tFb1ZHSkcvbFhONzdJeWZvS1pFUkNN?=
 =?utf-8?B?andsTTJubjFHNzk0MUQxTlBlQmtXTXBUbUZWejdUMEl5MElYMU5nNGwxa1dI?=
 =?utf-8?B?SDNIeU9MNDZ3WkJVcXRwM281WC9FVlJVSjNwdFRrdi9FVGhYSkYzQk1JUEJZ?=
 =?utf-8?B?UlF5SXFnMGoxUnIrRXNMZWJIWXNnUG9uaGhxMmVUcTBUQ01PZGhKL3VkKzNV?=
 =?utf-8?B?SlFaWk45L2UwMHFQeWdwTEN6eElyRFQyaE91enNnNTRvUFZGUDI0ci9kYWth?=
 =?utf-8?B?VTNuSW9NdCtMK0xlWWltUWFzSjZRK2ZndEt4Szk1WDEvcERFeW9hRE9KM3ZP?=
 =?utf-8?B?Z0ZJSExtQWYzS1o3dXVCNXhBRnlJT0p0NnZHRmwyL0tRWnBJQWpKYmJpYnF6?=
 =?utf-8?B?R2VVWmtZTms4T0NvR01qejQyM2dtbVlMRXYwWStOZllQczhvVTFwbEk1RXpI?=
 =?utf-8?B?SWJvcFpKeSsremZjMmVsdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFg0aXc5RDVWamh5WExGT09jZkZnekwwdzcxWFNZSTVtT1JFY2VFaW8ydWkw?=
 =?utf-8?B?bm1pcWlLQkR6bjBEd1NNM1JxeWJiVEhsUHZOY2FEdjhUYmFpMzJKN3hPU0c5?=
 =?utf-8?B?Z1NJendmNmlsNm91RHBxbHJjRjZBZi9FS29wbWZ2VTFRamIxRHY5WkpCQ3Zv?=
 =?utf-8?B?WWREUndKZmFObDBQdmVXdTZxaGUycVN0dW9MK3N3MUl2QUZYSTBERlphZ2lG?=
 =?utf-8?B?b1BXazR3SDBiTVhIdklKT2Rxb1FNY0phTzROOXlodDdteHRmYUx3bTVUM3pI?=
 =?utf-8?B?eWM3cFhmYWJ5MmJaOHluZDZ3ZUdlVG1sR2tnK1k4SHlHbm9FUnQxSXB2Y3dm?=
 =?utf-8?B?ZGtqeHJhYVRmL0lKSXhqQnBjWWxxSlJhbUdsenFwUXlsUlNUbS8zdjVDNFJ1?=
 =?utf-8?B?aENQNGlkRmRETjl4d1VGWHZLY05ZTFZZU3dPb1FuTmFjVFI3ZzZkVVM0TGVr?=
 =?utf-8?B?OXFnS1RjTXBOZDdjKzRIUE9FZVNzL09taVZnYWRXSTFnYXpBMDlEWlJiNWFv?=
 =?utf-8?B?TWo2NTNwbzdTTGpuR2h1Q1dINE5kekJnc0NKYXoyQXl5SjBOL3FWcCtTZzVN?=
 =?utf-8?B?djdYSUdybVI4Q0t3RURDR0w2Y2Z5aGIrUVhnR2tuVk5Rc2dEVWw2SzlONDI4?=
 =?utf-8?B?dnJSTFBBK1BJZkhtblVYVW5MUmhCazMybTdvU3BHVFRXenhPU2dma2d2bDNK?=
 =?utf-8?B?ZlRGR3J3ZUxWN1E5aThQazZQTmthL2lRVWpQWkdGUmxnZUhHNFRuRlp4OVRX?=
 =?utf-8?B?NzVFa2xjSzlpdlRyVGRzeGw0dDExVktEWkRXWGNGTWNLd3QrWlpRanA4TWlG?=
 =?utf-8?B?RnhEMEpEbEVpL0hKOVAydW1yYTdqNHY0dW1LRVRkTUpmeUg1RHpOempycUdX?=
 =?utf-8?B?ZjNGalhPbmxhQXQwOTFQVDhnTnJnNFZzYW9ZMUF5c3YreGt2TGFvaWkxSVBt?=
 =?utf-8?B?ZUhTTnVBc1RFTXFHalYxeklIK2VxZTMwdHd2Z2YrdGl5WTN2cU96S0tuWHJC?=
 =?utf-8?B?b3BQRWE4ZWdlWEl5Wmh3Rzl1eEMzTW0vY3NWTGQrS0RNWCtZeVd2N0RwWGgw?=
 =?utf-8?B?dEthSEczcFBMZ2NqU0N3S2pSWlZFWndQcTJma2ZCK2xtL0RWSCt2eU1NcEZW?=
 =?utf-8?B?NXc5VE13S1JnUlkxK2ZzZUJsMWZhaWZ2WDhHL3V5SVJRcENsRlpCbGlKTnIy?=
 =?utf-8?B?R0J0czhiVVZmOC9uTENoMTFsRXU0YjMwcmxlVlpHa3FlSmV0aHEwMVZCVmg5?=
 =?utf-8?B?SE1hY1hFbGJtVGxCNlhlVStiK1phd2s5RUx6YUdUaHowazNMczUvV2xtNzRI?=
 =?utf-8?B?Rmg0S3ZzY2ZXR3hUTlltTTA3YVNicy9MRjM5N2FYRzlJOWFxV3h2eVlqQWZq?=
 =?utf-8?B?eHdmM2Ywa0tUcUt1U2dxc0xCSzhNWjI2RzhnREd0T1cvMGdGTW9CVXhHSlVj?=
 =?utf-8?B?K0Q2aXIzSWNJbS9UV0FBRFJ3Z0d6KzRSOWNVLzVuTC9MM1NWZkxKNFlBWjZI?=
 =?utf-8?B?bDI2Nm9oQVk3cU8rZFZwNnRXdzBFdEQ4c1FDaFljZ3hvTFJnN2FNeTJqeS9i?=
 =?utf-8?B?aG9qUnhLN0Rrcmp2bkMzTFl3bjBMbEh5Ky9PTGdQQXkzYUF1SHRxZ0xEQmpi?=
 =?utf-8?B?TUpmQktQdEozREt5ZWRuU0ZRYlVSV05NNjBFU0lyd0FZZTVaeU16UmpsRC9I?=
 =?utf-8?B?YXhaQnRlVlkrSmorL0k1cHhNcWp0bk5GUHdaWHdONkpzRnJ4d1AwcEpaVDhH?=
 =?utf-8?B?aWJKQkVHV0xZYWlrR2oxSk1ZY3luT20vWTk1dUZwaEdWNGN1Yyt0ckVJeU1K?=
 =?utf-8?B?NmxwQzYwRFg5aE9yVk1QZHdZaWZiV1dmZUxCbUo2REl5d3dBNzlyNEFrTTZX?=
 =?utf-8?B?cWVrRDhDNVpRa2xMNkJabkFScmhuSFBvRzNBVlBoZjBhN1lRMG9pSThGWmw4?=
 =?utf-8?B?RkdtZXFqaDQvaitkdlR4aDd6dnRDdGhETjdvMndTdllNZ2xJYWRTMVdZK0Rq?=
 =?utf-8?B?N082azlUYW5zVmZDQklYMGVMU2s0RXMwSzNrbzRGM0hJeVBkN0lFZW4xd1Rl?=
 =?utf-8?B?Y3F6RCtJV1R4RzVaUGZzUzJBY3VSL2JDOWorNXY3TEFSS2dVNGJOeEs3KzVF?=
 =?utf-8?B?TVFLbXBYSFFHV212TUhKbTkyeGhwbU9zbG96YkI2UHFsR3kyL2hLR1F3UWJJ?=
 =?utf-8?Q?IgIF4SiiQ5w7G9rRugsccvY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C99E2DA041A9A47ABCBBCDAF3FE3086@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a9c922-5dc4-490c-79c9-08dc799792ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:48.7370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5svMXyfaNE7HXrffuymmBBxkwrw4mqQIvp1Ikxf5uZKPbwR2rexHMFjy+XWgwYNLPJ1Hur1ten5mjr1wOi2elNoSwoU1owG9TeYavOc0K7sBot3GSDyBrOAQr1cR5My1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

VGhpcyB3aWxsIGJlIHVzZWZ1bCBmb3IgZGV2aWNlcyB0aGF0IHN1cHBvcnQgQVRTDQoNClNpZ25l
ZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBl
dmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9yeS5oIHwgMSArDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvbWVtb3J5
LmggYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCmluZGV4IDM1OWJjYTJhZTIuLjU2ZWY0ODc4MGYg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCisrKyBiL2luY2x1ZGUvZXhlYy9t
ZW1vcnkuaA0KQEAgLTE0NSw2ICsxNDUsNyBAQCBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7DQogICAg
IGh3YWRkciAgICAgICAgICAgdHJhbnNsYXRlZF9hZGRyOw0KICAgICBod2FkZHIgICAgICAgICAg
IGFkZHJfbWFzazsgIC8qIDB4ZmZmID0gNGsgdHJhbnNsYXRpb24gKi8NCiAgICAgSU9NTVVBY2Nl
c3NGbGFncyBwZXJtOw0KKyAgICB1aW50MzJfdCAgICAgICAgIHBhc2lkOw0KIH07DQogDQogLyoN
Ci0tIA0KMi40NC4wDQo=


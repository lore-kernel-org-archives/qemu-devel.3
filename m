Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C66DC25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PHj-0007tv-5Z; Tue, 21 May 2024 09:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHP-0007e3-RW
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:53 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHN-0001Zh-0e
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297105; x=1747833105;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tIM0BHg6yThMkhqORC+BUeZDUMynoBvXIlaRATWvIhM=;
 b=pBCyUZDKY+cZf0lC2wb6xMSA5lE359V9+m1OBL3beIPWmxL8A0e2jNjY
 Xc3SgEze72xFyyrWQowfW1s8Hbh4x2bUfEXZneBpQeDCQCTQTj5wQXhu9
 RrXGY3Po+cwEdMc0zqdndpk/GaFppb31bHqfBjDdcbvwE/AVptYzf7MVa
 i3sgx5s+P1f8e754PxjKpV7So40zgQaGKCeBcNF1AFjl5GyDQm2a1ZM1D
 Y40BhT9okFcZOot4VdLSpE3DandUL4Te8KW4kIY+O1BU44z6ck2w74Uqm
 qslZszSl7lbfGtHDENmOFJodxkotEfV35j1287k2L8vj96LlqFZIQArk9 w==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13061498"
X-MGA-submission: =?us-ascii?q?MDFGfMax9gt4oByEnWpuEkg42rartscyw/UmjY?=
 =?us-ascii?q?0gNUmz2r+/bL+YQ1/N4t2yjzgyAEG3gj8sq63hw0x2TtUk0reLJAl2Kz?=
 =?us-ascii?q?XVT5hKsQpyyk0FFEfibearhyRzZVZXX95PDQ7xXfTXQyMCvgUHAaYcPU?=
 =?us-ascii?q?e/vvTjwHwrD8FjfCDUBHhW7g=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:42 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcRr4R8KOh7ZxfL50Re3DE3ckW78jo7yQsrtUeFc54C7BDcBpVGC/92/EHUASSuHqfowzmU3rT0+ThITVME5WkrwMVscmiEU99s9KN+01aEtIaV1OjelTlvT1oG6P/MtgD1UXguu6XYWSDTIMmssvFPREbEwnIKohYnxLCjFT7a17rzY7/NF5/wv5Zbl8cEzXoUXs/by/MRUjdu2ON9Woirm2PoCZyel0CdWCh26p0AycziYAkm1S+87JCHH/zN5KOXyDYSuLBVJBQI2FIPgSBzCEAJwR5K8+jg1t2kul+dqua9jjbGg2v0FSFIbvcYwVRB0r7vhz76vbRmzMMWM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIM0BHg6yThMkhqORC+BUeZDUMynoBvXIlaRATWvIhM=;
 b=T3Q7s2g7x4F1riGiMADAuMVuaZo1ws3h/kLcsk4ZtarjY72Ob3Tm1tGGCdQCPMZNiH4a5o+h4N7Y0WpL3ca9/Va+EC2h0ky6Lfnoo7gc07VnJvIn6RPyucBwjEiPV/SQc9Izcj3LdzXWndiPt+UAN3QAPca17vkTEqWFCGjLMMLaEgRWBafi5nMMdwmoxL/EnhLIopSmkKKHSYkepYaQ8iqDfdm/J/fp7Mn4DLqGJ7BIH5mte3+XMgr+AOXjEq93AYGkaZnHjXRHK5kpfzdT92sQwaf7x393ew8eDvIna96A5JoRjmveJmPV4NaB4KtGKVZE1ufzgNOuITa27F0naA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8148.eurprd07.prod.outlook.com (2603:10a6:20b:323::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:11:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:41 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 05/22] memory: add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH ats_vtd 05/22] memory: add permissions in IOMMUAccessFlags
Thread-Index: AQHaq4BrjVcZ9I524kuvkvI+pg0RuQ==
Date: Tue, 21 May 2024 13:11:41 +0000
Message-ID: <20240521130946.117849-6-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8148:EE_
x-ms-office365-filtering-correlation-id: c1b4feb5-3167-4bb7-d694-08dc79978e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Z0YrUkRkNlhxUm5MY2VIVWljbU5FYWgzZFlHWTArQTBKb0wvMzZ5MzhkSTBa?=
 =?utf-8?B?SGV6c0ZiTTBEKzJHbVVwNWpXL1BJS2EvY2JPdFJZZWVPdXlweTFsVCt6UXo4?=
 =?utf-8?B?aEViZGJHb3BMNjUwQVppUCthYmk2R1VYT2Ztck1GbTkydFhtaGdpNkduODQ4?=
 =?utf-8?B?dCtBL0Q4MzhuejIxQzFmeEJjWjY1VzdqY3dVNG1lMWduU2VCY0pkMTd6QTVr?=
 =?utf-8?B?UGcrM0U1enVLUXBiNTM1TVhaeXRSUVFJQUdmMGc4TUdVWmliZ1dkbEFEekdr?=
 =?utf-8?B?VWIzbXFmcVpxdUM0c0EwUFhMNlY1V3ExUmJqc0pETzZiVmZGRHlGT3BHdkFQ?=
 =?utf-8?B?QkZIc1pHVmwybTU2ZW43aUxNTmczd1ZLT3B6N05TV2tIVCtEbDYvU1dWVEFC?=
 =?utf-8?B?RDdYdG1KUGhVVmZyRW8rd29VeXFDUmlFZ24xamdGNVlDbDZNSnJMSnJyUVRv?=
 =?utf-8?B?VVp5UGlQNFI1ZmhTalduT1Y5NEtxdkVrQ2pyYjhndUt3aWg4ZGJ4M0ZXSFpI?=
 =?utf-8?B?dG1GbVI5NVJjQitPUjRaUkhsYUQ4QXVINXVMN01MeGQvbTA5eHpvOTdzYSt6?=
 =?utf-8?B?QTJkQzNQeGI0RXkrcUl4TTc0OHJLd0tOMHJseWN5VEJGNUpSdWFKKythRVox?=
 =?utf-8?B?MXp6MVlKc3o4dnJaVlJSSmVBcWVmWnZ1N2tNNXdGVjhvZDg1RVREc3NwT0hx?=
 =?utf-8?B?aDNFMmI0TVBxcmxkYzdXbHd2YnRhTEh3cFFNNnNYbFRUcDIwbEZneThIdEd5?=
 =?utf-8?B?RHRvelZIRmlBZkd3bFMvaXNEZEJUWWQ0MmFJbVpVMHJDYmxOTnExRTV2ZjRZ?=
 =?utf-8?B?RHE2cW1pelgzeXFqZCs2K25rYjUwS2VXTFcva2xxaldsM1p5a1c2ZS9OSSth?=
 =?utf-8?B?Smh5dkE0LzRxRFJDWkU5alBLNkVFSWlma3lOVmxFa3FNbE5oblVVaVBDd3Va?=
 =?utf-8?B?dnJNQ290dHRLeHZFOERwL2swTCtpbTFaQy90SDN6bWsyMlBCbmV1MkNGdmwy?=
 =?utf-8?B?eC9oV2R0S1ZuRWxHWVNZb1BKRHVtQ295NnQwcElNMzBwRzErK2gxUGZseFdZ?=
 =?utf-8?B?bmYwVEJQa2Zua1R1SmZUeEQxSDZVcitlaHdhNDhHTG0xZHhhbmRnYjViaEV6?=
 =?utf-8?B?V0VmS3lWTjZncUFtMnVXcTlDT29TcVFaTEJhS3BoWTFyaDBPYkJ6VDFHRG9N?=
 =?utf-8?B?SWVobklRcU9lNkVWYkNQZEdXekdIZSsxYUJXRjIxcEpJUjhaRngzWkRJbUxP?=
 =?utf-8?B?TXFNcHB4OXRjdkZuZWcyQVBlamMxb1pMYUVoc0xENDNBUEE3ZUFITm1BcS9Z?=
 =?utf-8?B?cmJOc2xHRmxQMGphSzd0eHZ2M3RGQ2RmZlVVb2RhNWJ4dVpXdkEyUGZmWWVn?=
 =?utf-8?B?alMrRXZXbXdtNG5RcXJGbXZld3REK3ZXalJ3Z1UwSWpLMnpYckd6dWVKazJ4?=
 =?utf-8?B?aThUWHFCYWlYVzdPcEdmMTJ6dEtFekp2OFRVbE1hSCtzRElKSkQwUGZKU0JO?=
 =?utf-8?B?cU9jU1lyNVlTcnVTa0hzdGMyZDVsdzFzMTQ0R1BmYWtZaC9jYkt6Ym1hbTNS?=
 =?utf-8?B?T3BHSzlaNHNpdDVYc3MvTWdMWlZ1bzErWnp2TTVYenoyVU01M3VjQTZVbFpp?=
 =?utf-8?B?MTYwaWhVYjk3clRiWlpIdGl5aWZsUk8yM0I4ZmF4dEUrVjh0MGpJNjhnOXdF?=
 =?utf-8?B?Sm9TYnhJQ0NSUnVUV3laczUzaDN0ZWtsSUJZU3o0ODJ1NjloYzJZTXI4REhC?=
 =?utf-8?B?TXdRZjB6VFQ4dHVlUVJ5MnBaWm9SS3duQVpVSCtXWmRBVmNLcis2TktkNDl3?=
 =?utf-8?B?WEEzNUdPcjdFOE5peE1Bdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTlBcGIwREFQbENqQWo1Yjk5YmtkS3FoZ001S28zRUdIZzRXM2NLNFkvckY4?=
 =?utf-8?B?MHVReU43Y0g0bDd1S2g4dU9jT0VYYmZjQ3NibFo0ejJrVWcyZXRSemx2L1hi?=
 =?utf-8?B?dWlmZWJjTUFrQXN4OTU1cWZnS0dhR3dHSzQ0RlpqTnFsa0VpWjhPSGFxd3J3?=
 =?utf-8?B?TGFQdWhYb0V2c1RPMlNyL0czQVl4bWRYNjJoVU9SYW05VERPSDdUOFkyZHJG?=
 =?utf-8?B?TEExT1VORk5GTHloYWFLZ1FOc21wQ1hYdmthazNTWnhRTmwzaGdFa1JtYjUz?=
 =?utf-8?B?R1oraXIyQnllajcxN21sNU81aCswdTdkd1R6dUZXa0czTXRxb0trdzFGTmUv?=
 =?utf-8?B?d2Z0RGdyb3hNeEh5VC9HcW1ucWY2WXVjelU3aXMyTFdySUU5LytsMjVjSUU4?=
 =?utf-8?B?czQ4WUN2Wkp0TFI5S2ZLWElKdVRNRE1ESHBESmxYMHlWNEN6SjIzTERGakJt?=
 =?utf-8?B?aG0zcnh0YVJxcVdGd21EWVFCeXpIT0ZJM3hYL0g3TWRlQTVoNmNUQzduWlRR?=
 =?utf-8?B?UC9tQXZxZUoyMXFNUjFKZjI2ZkZtRUNxcXQ0UXZZcEpnYVdNQ3p0RmVDT0l0?=
 =?utf-8?B?WXB4cjhleFlQald6TjlObVhLT1BERjFiMzdKUFpTbXJWT25LN0ZPZnluZDhk?=
 =?utf-8?B?dklRTWxKcWd6M3lXR1NMc25mWG9Vanp6WE9SOHlWU2FLdjh1NTQ0Zmh2MWhs?=
 =?utf-8?B?ZkxEdXUzM1YvbkVoa0VxdUlaNHIyOVhLR2JEREhsZHBPL1gzdEEvOWp6Q05L?=
 =?utf-8?B?b3E5QlNLYk1tVDRyVGpQZTFNaXo2Uzc3Zlpta09ia3NJZE5OZGpTMkFCTFh2?=
 =?utf-8?B?c2hOUnZHU1NhOFpjQVM3OVI5SmFzcVNWcDhScEhPSmNJWHVGYXk0Q0ZGOCsx?=
 =?utf-8?B?NVA5d1VpV3dLMlBwYWcyblE1MmdWa0w3UjhYWUk5RVFkQXBIckFPN0NobmtG?=
 =?utf-8?B?bU00Mk1ZRHFNdlFTNE43YlFyYmtsbm5odm1vS2NkZUxRelFkY3kzNER3RnU2?=
 =?utf-8?B?d05NSlJwVHRWd0thUEc4SWkxSVJRN1NFQmQranhXdlRhemxhZUN4eGUzVVVz?=
 =?utf-8?B?Y3hKNHFIbFhXOEFLamFUY1B6a1g2WmdsdURXSG90bTRLaGJZd0Fla0RmRVgw?=
 =?utf-8?B?MFUzSzdSbHcwVURIbHJJVzdYdTVaTlpmR1lJbFAyWEx4dVFsQVh2aEdMNFZq?=
 =?utf-8?B?djJDYnlqbDZnOE5rNUR4WVR1V3IrcWQ0TUtZTEJVUEhXV0NJZ2h0RXQ1OVk1?=
 =?utf-8?B?YlIwYU44KytzblhPYnZMMkFTNEd6ZWJCOTJ2bTdKMlcwNHR2dFVPV3Z0RWZv?=
 =?utf-8?B?M1RZTGo3RzY0WU9JYlJBOTFLTGlSUjVlZWl5ZEhXTGJ6OG15L2NQa2l6Tzl2?=
 =?utf-8?B?RFJVeWNRNHlvNG0zOEZ5VHpWcytkV09YSFlhWnplWUptM0RiaWc4Z3NTTWRZ?=
 =?utf-8?B?dGZNeXF1ajVsenVSOFFpdThSeEFxYlpVN29uSzBFQXRwejZSWFEybmN3RktL?=
 =?utf-8?B?QmtwNHlVL0UwaGFNM09OTThOUTZlUzR2cUpYRHFSLy9iNmw3bENQVE9uNFAv?=
 =?utf-8?B?UUNwcENpT2d3ZTBGZmVLM21CcktRc0xraVFDQkpuRWdYaWtYeVFXd2lKaWty?=
 =?utf-8?B?TmwvR0ZCY1hCSk16S1ErZDhZNzd4R0V1RXVVSk1VMGlIU1N2enZpTXA5WnJM?=
 =?utf-8?B?UEpwOS95YlR6cUR1c2dlSHV6QW9mSEljTUV4ZG5hZlhUdHphR3gxUytPU2JV?=
 =?utf-8?B?R1ZiMS9CWi9JUy9rcVFnMkhrSi93eGtHZStvM1NZMWJUQUM5SmwyNTIwYW54?=
 =?utf-8?B?OThldjdTUndYblhGbzkrZ0twZjFzR29Pc0dwUFc2bm8wS3ovaE56QmNHcFlP?=
 =?utf-8?B?OWlQOXdqY2psaVlvMk16eWFpbFlMSE5hY084Nk1nZWkyTjhUZmtMdzV0Vkh6?=
 =?utf-8?B?bmlLbm1FSk5NWG9wa0duWVZJcHhneUJYMEx6ZDJBUXRXdDg3d0VWaUR6WEVt?=
 =?utf-8?B?cU1LUlhoRHpjSDJHRGlJbkVCRXRWTkUvYmxSazBtbllMT0tRRlNra0pYRDZx?=
 =?utf-8?B?NGZRcm1mSWNsSnJ2ME5qOEZRQVZPRlZ2S2lvaFlubkVYZVYrb1NTQXRVbURZ?=
 =?utf-8?B?bTdWQUhSM0FIQkpBMUVXNlpqUmMyRGxjMjRsQ2dZek8zYURCZ2xvMHFKWmNB?=
 =?utf-8?Q?LmVFn9RiULIMMWb8EbGbCkQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DED61B897366F44B800F3F344ADF684@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b4feb5-3167-4bb7-d694-08dc79978e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:41.0279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4k+VeVuaX/iox+dSqEsKZdW87htQWFTYPItV+5Q1pjETRgDTcYKVRul+uedavD/lB36Y0exdSmY1UkKLTErEsx2VnCienD3GdboRqDCTPKpaA/uv0mAu9hvZN8Z9qdcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8148
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

VGhpcyB3aWxsIGJlIG5lY2Vzc2FyeSBmb3IgZGV2aWNlcyBpbXBsZW1lbnRpbmcgQVRTLg0KV2Ug
YWxzbyBkZWZpbmUgYSBuZXcgbWFjcm8gSU9NTVVfQUNDRVNTX0ZMQUdfRlVMTCBpbiBhZGRpdGlv
biB0bw0KSU9NTVVfQUNDRVNTX0ZMQUcgdG8gc3VwcG9ydCBtb3JlIGFjY2VzcyBmbGFncy4NCklP
TU1VX0FDQ0VTU19GTEFHIGlzIGtlcHQgZm9yIGNvbnZlbmllbmNlIGFuZCBiYWNrd2FyZCBjb21w
YXRpYmlsaXR5Lg0KDQpIZXJlIGFyZSB0aGUgZmxhZ3MgYWRkZWQgKGRlZmluZWQgYnkgdGhlIFBD
SWUgNSBzcGVjaWZpY2F0aW9uKSA6DQogICAgLSBFeGVjdXRlIFJlcXVlc3RlZA0KICAgIC0gUHJp
dmlsZWdlZCBNb2RlIFJlcXVlc3RlZA0KICAgIC0gR2xvYmFsDQogICAgLSBVbnRyYW5zbGF0ZWQg
T25seQ0KDQpJT01NVV9BQ0NFU1NfRkxBRyBzZXRzIHRoZSBhZGRpdGlvbmFsIGZsYWdzIHRvIDAN
Cg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1
LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBpbmNsdWRlL2V4ZWMvbWVtb3J5LmggfCAyMyArKysr
KysrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5j
bHVkZS9leGVjL21lbW9yeS5oDQppbmRleCBkYWRiNWNkNjVhLi4wMDY3YjIyNjZhIDEwMDY0NA0K
LS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5oDQorKysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgN
CkBAIC0xMTAsMTUgKzExMCwzNCBAQCBzdHJ1Y3QgTWVtb3J5UmVnaW9uU2VjdGlvbiB7DQogDQog
dHlwZWRlZiBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSBJT01NVVRMQkVudHJ5Ow0KIA0KLS8qIFNlZSBh
ZGRyZXNzX3NwYWNlX3RyYW5zbGF0ZTogYml0IDAgaXMgcmVhZCwgYml0IDEgaXMgd3JpdGUuICAq
Lw0KKy8qDQorICogU2VlIGFkZHJlc3Nfc3BhY2VfdHJhbnNsYXRlOg0KKyAqICAgICAgLSBiaXQg
MCA6IHJlYWQNCisgKiAgICAgIC0gYml0IDEgOiB3cml0ZQ0KKyAqICAgICAgLSBiaXQgMiA6IGV4
ZWMNCisgKiAgICAgIC0gYml0IDMgOiBwcml2DQorICogICAgICAtIGJpdCA0IDogZ2xvYmFsDQor
ICogICAgICAtIGJpdCA1IDogdW50cmFuc2xhdGVkIG9ubHkNCisgKi8NCiB0eXBlZGVmIGVudW0g
ew0KICAgICBJT01NVV9OT05FID0gMCwNCiAgICAgSU9NTVVfUk8gICA9IDEsDQogICAgIElPTU1V
X1dPICAgPSAyLA0KICAgICBJT01NVV9SVyAgID0gMywNCisgICAgSU9NTVVfRVhFQyA9IDQsDQor
ICAgIElPTU1VX1BSSVYgPSA4LA0KKyAgICBJT01NVV9HTE9CQUwgPSAxNiwNCisgICAgSU9NTVVf
VU5UUkFOU0xBVEVEX09OTFkgPSAzMiwNCiB9IElPTU1VQWNjZXNzRmxhZ3M7DQogDQotI2RlZmlu
ZSBJT01NVV9BQ0NFU1NfRkxBRyhyLCB3KSAoKChyKSA/IElPTU1VX1JPIDogMCkgfCAoKHcpID8g
SU9NTVVfV08gOiAwKSkNCisjZGVmaW5lIElPTU1VX0FDQ0VTU19GTEFHKHIsIHcpICAgICAoKChy
KSA/IElPTU1VX1JPIDogMCkgfCBcDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKCh3KSA/IElPTU1VX1dPIDogMCkpDQorI2RlZmluZSBJT01NVV9BQ0NFU1NfRkxBR19GVUxM
KHIsIHcsIHgsIHAsIGcsIHVvKSBcDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKElPTU1VX0FDQ0VTU19GTEFHKHIsIHcpIHwgXA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICgoeCkgPyBJT01NVV9FWEVDIDogMCkgfCBcDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKChwKSA/IElPTU1VX1BSSVYgOiAwKSB8IFwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKGcpID8gSU9NTVVfR0xPQkFMIDogMCkgfCBc
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCh1bykgPyBJT01NVV9VTlRS
QU5TTEFURURfT05MWSA6IDApKQ0KIA0KIHN0cnVjdCBJT01NVVRMQkVudHJ5IHsNCiAgICAgQWRk
cmVzc1NwYWNlICAgICp0YXJnZXRfYXM7DQotLSANCjIuNDQuMA0K


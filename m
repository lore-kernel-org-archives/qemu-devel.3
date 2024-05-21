Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BD4C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PHo-00081T-3N; Tue, 21 May 2024 09:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHX-0007j4-Il
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:56 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHV-0001ZU-9j
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297113; x=1747833113;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8GU03lMLg26o1svETtJlIBqEUa69Gidx+p5JjCEJw4o=;
 b=pNYY1y+svE8M0v3ADhYd3OoSBY9IaXGN1ZNgVkpr11v/Nk2Z8ACgo1+6
 uxjjOWmWh5YI2DevxVbcq28UfAu9g8wUUabakvhiktg/qWaHzdqFOtXqW
 2jmaI1P26x0xt17MxSL5KML3Mwo3WnAH95si7H0ENs9BaH9ZQeA9m22HK
 E7RYXLhIlDBhyham9BEwkcOLd2TOpmV6KxaxS7SrQNH6DJueBbh1d1clS
 Cb2Ent2Zl2FZTbwWCQfWG8Oqv26OyfW3Sg2TEVxHmpNk1w9dtBRJQw7JN
 +FVH1E8+xskNPx4NMjdKxpVjyzeoydHzFkfAgNdEMGVbR3lT8jNZYMSZK g==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13008001"
X-MGA-submission: =?us-ascii?q?MDG9qdn3Uyn/Y7UYQZwolynDeoy6s57ew4fIME?=
 =?us-ascii?q?rye0JCeA64twQk2W96vDNTdcaBh5X5e/C521o3x6/8j1UlEoeZ4tNz4q?=
 =?us-ascii?q?yqbebNeBsADuFBkgkQ3+xVsaApJjpNnfOYV1+dJYlrSl1FCY85yd3aNo?=
 =?us-ascii?q?kIwxQk2JSMVnpyzFUZKgYjyg=3D=3D?=
Received: from mail-dbaeur03lp2168.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.168])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:47 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XONUUh3ILGm9RX0Fq6QAv2u4BKP5VIbl/zqY82nijyZJyjVq9kMLgANPuaEgqn+a5aC3n3IYuKaCxx9ylTpaqxZNBFistEF8chFhCEY91S8npzGha72c0q4JqYXu/NKKKqa4rzgC+NA9Ov+ME+caQyQYy8viOfHI53iYHeYkfcEPbXGl8vqapjc/vhjfxqG5cMdHoyXjKJgRmppiyUnDccSsWASYahSRLdFQUt2skyi7JEm9pgHmyEN9izSIPr/21FQSy/ohUDOfZispv03Cvj/jtsTHqTcSnLIiuRDhJ1j2KuFKediZcoM3pFFjhWRhE+xS5sCbimTbvbWghN1jkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GU03lMLg26o1svETtJlIBqEUa69Gidx+p5JjCEJw4o=;
 b=f6js85/VWNiG164qr4NV0QxstjR5ftbav/Yxztd7l+BqSwGCLcaGfRUe+WuU0hdBik9gfH/NJQ9NDB2es5GY47grUnDKT/uS3+U2h3FinoQIXBSNttnr17mafZre6V7vc6H4P4aLQ4sWwSxThwJ2M5V+8EdRK8fvqYqCGUsUiCRTQ0liMATZBh+K3ktd2zGL0BKzSBqWurKYncztwmgCfUnP7F0bEBFIE9ZqZ+ojjePHRUWP8owBbC4y7UeRLNchRGHWMjS2YXM5O85Xw5VQzRBSHZUyBjTuVswPOAK8TKLKg0MgvAwEbRiUaffwDs5yE0mxmcH/3JPsxEFCcv2S2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 12/22] pci: add a pci-level initialization function
 for iommu notifiers
Thread-Topic: [PATCH ats_vtd 12/22] pci: add a pci-level initialization
 function for iommu notifiers
Thread-Index: AQHaq4BuIH0I4A4DJUyHT8GkQmNaSw==
Date: Tue, 21 May 2024 13:11:46 +0000
Message-ID: <20240521130946.117849-13-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 74c113ac-ce04-4578-13e8-08dc79979122
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YTRsZTJlWEMrUER0NUowQzQ5SSsySXM5MUdhNXlJU3M5Zm9SS3FjdktJdjFI?=
 =?utf-8?B?RlVoRFd1MkFLOWVuTjFNcHpVWlZ6d2lTVVA3Y2FrRml3VWIwaUNaNTNlOVNa?=
 =?utf-8?B?dmIvVGpIdTdsaEREeXRiUTF2aXB5UTdEMTA3NVJocEF0TDRDVGFURFh1Y1dv?=
 =?utf-8?B?ZzdmVjd5dXV2WkQwcmQyWGNTV084Tm5yQjVVbVMvNVlGdHR3N2oveUlGZHR4?=
 =?utf-8?B?OTk3UFpncGtRcGNtMlhKNEVLRFZWY3JpSGswR2Q1KzBwSjJEcktiWGJ3VkJk?=
 =?utf-8?B?VVlaU2puQ0dEQnNjRnc5WTdJMk9CSUdsTVBVaVlWd2pPMUZZL3Faa0dId1Zm?=
 =?utf-8?B?U3Vmd21jc2Q2dnZjL0FpNGZIWThVdzVzK2Fqam1rSVp3MzBBY0F1blZQWVN5?=
 =?utf-8?B?MDkrZVFKSU1tQmlUbTM1NGRkNUhsbjVsdm5VbVpVOXkyRTFlaTRzT2ZCQklE?=
 =?utf-8?B?NWM4YUxtTXdwNERBTGN6TUN5c0VCdXBLMld6OXRLMm00YkxQZG1lYVhud2RM?=
 =?utf-8?B?KzEzaDNaYWNRcXdUY0NhVWEvMGp1UDdERThrcVBwSmg5SlRrbWh6S0ZoNkNT?=
 =?utf-8?B?TEg0OXk3T3pBUWNKbEJCa3UyQVQ1K1pKV2VHd29PNTFIZE5laXF1UjdTSXhq?=
 =?utf-8?B?Q3lhY1V6TjNBNVROaHgzOE5JK1pzQ2xHQkhYT3lHcGNGVUd3VmRDeUtkNk1W?=
 =?utf-8?B?OXo3dyt1RWpSWm5Bc2svOEhGUXpkSUlrZmxzdTRvSHFyV1NKMzBGdzNnbUJS?=
 =?utf-8?B?cHBEb3FpZmFtNkZ3YmVKdEttbVZmOGNSU3YvdTJqbjV5ak82WkNyeUNudFhs?=
 =?utf-8?B?bmdkZFRIazBVcTNMQXZhN2tYMXpzRnNCR3hyaE9Fd2d2ZmtlNzU2ekxqbnlH?=
 =?utf-8?B?MCtpTVZReEJGd2Zrc09odG02N3pPSmtJZk50MmZ5Sjh0RmJ4ejhTVzF1TDQ3?=
 =?utf-8?B?RjVydmk0Vm9LK0IzbnRscE9WM1VDdGRYZUM4eUlsYk92RHFpUytZTGh0ZWli?=
 =?utf-8?B?OGJGODNmb2tBV3J5WDhqeDBqMjMxVU1rMXZXYnI1Yyt3Uk5TUnJvM0dZVlVa?=
 =?utf-8?B?N2FkYU9nZWs3WVI2aHFLWDl5eU8rR2hFWUthNzRna1RaUlAyZnZRNFhRZFJX?=
 =?utf-8?B?WklFZStJa1pSLzZMb1Y2TTBydjZ0VjA0UlJ6cFoyNzB5Y1JoOHdLTXFiRW92?=
 =?utf-8?B?bVkxOHh2UnNQeS90T2JxNlI0SmIvUHVkbmFmK2ZCaDM4aENrUzN0WGpTMzBQ?=
 =?utf-8?B?VlBWM0c5U0RKSHgzK1JWTW4zcUxTOHdmSTJxOGtnSHl0WEM2cnJoK3BaVEJE?=
 =?utf-8?B?NlB0UFIxOExCcWxscTlFZndzQ2NPMHZXQ1ZRZlMxblM2QUtTditqcEZobWQr?=
 =?utf-8?B?MCtwbUkrc2NVelZkODBoa2FyTkdJRDZkc2ZvUUdGZ2FGK3dtNW9MK3R6MjBK?=
 =?utf-8?B?aGJpVi95SXZ4QVVyS3dxaEtYQ3BxcFpzUXJZVXlzeHNKL2NvRHJEaE5NMlZD?=
 =?utf-8?B?cldteVByOXZncHdITzlqRldvWFpQdEo4ZHNiYVAvRzNWMVlqR1VsZTI3cTZR?=
 =?utf-8?B?K21xYzZ3OFNEbzA5aFJvb3JrQnlrTkFlU2c3YzRDYVFIck9RdjZaRjNLNGxT?=
 =?utf-8?B?aHF4VDV3cHdQNktPR0RkNWVZVGs4bUY1YnR5Nkx3VEx4ZW1XMGpNZ1dkcGtp?=
 =?utf-8?B?WE1PRnl2b2VYVklkTUVZUHpCQUo1SlpqRGUyenQxTGQzek9Yc2loUmJwQzFs?=
 =?utf-8?B?cTh0RUM4VzBydHFIenNINEdpTTdydmpsS2lGTWxMNWtZV2NhMTZweHFGeVhj?=
 =?utf-8?B?TGZKVTdVbnZ5cCtkVCsrZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWdRMmx6TENVb056TVFySGVFYldPZkI2b2hvL2RkcTl6YXFiOWh1aWlRaW9t?=
 =?utf-8?B?KzJSWjBhSktPZTNoMThBTlRTcFNWU0tUaitvN2JWaGlTWlNEeTl3YTBkY0xo?=
 =?utf-8?B?VHg3dUQrQnd1cSthbkNSN2VNTE4rb3JEakdUVWJ1MEVSdDIxNWNyV09IbFc5?=
 =?utf-8?B?UkJKV1d1V1N5YXpHTHlwVjRBdkhyR3R0bStxekVDV0NSMjN4S01tai9GMnZ5?=
 =?utf-8?B?TGEyYVYzcFROZnhmdkUzRkVVVHJJdVN0NFJNNW9YRXAraE9vUHFScTd4azVp?=
 =?utf-8?B?NjlDb1VFY2V6SjQ5UW9CVGFFVENUNVJtMDVoK1FGeHhLTFNiSkZVTS9Nc0o2?=
 =?utf-8?B?ZExCZzkrZGRMYzE0QVJVcjZjejd4NGVGQTNsL2hxckxqb0dzM28vMDl1UkpY?=
 =?utf-8?B?cjdCbEFGSXZBbGEvT1hCRHpyL2ZGLzFDb2hMVm5kVEVuZlFsYWxlVW9rVzRj?=
 =?utf-8?B?Z2xWOW4rZkg4MWc4ZUVBdEEwZnl0emRpTkhRMUtPUm5menBrdWEvV1ExNjZP?=
 =?utf-8?B?ZlRZRUVBMUZkNnlGV3NIMGxyZDJOZ3ZGSEZaNno1YWpMUnlTWVVzNEU3V0xh?=
 =?utf-8?B?WUYxN1VoYWdpNlVXd3pqU3RhOU44U2xFc3BVa3F2R1VGa004UGNVLzExUVdh?=
 =?utf-8?B?NU51MVA0bWRvd01uRU9qNW5qL25PZU1OaVdXQXQxOFp3YzN5cGJPc0oxRTQ3?=
 =?utf-8?B?MjNmU1V0QWkyT1VlLzhJZlBQRS9SbUhtRGMvNmt2UUlIbTNsZlpNMHJQbWRD?=
 =?utf-8?B?MVdtWDhuTFZxK1ppRFZOcVRZMU0yWll3d01CODdtOUhYNnNFYmhzczBTYVlY?=
 =?utf-8?B?VjV6cEZQak5uRzBXaFU2TmNNcE5BQ0ptZE9oY0p4ZWlRMERzcmJ4S0tNM0NE?=
 =?utf-8?B?OXU2Z2pJK3pLUllNR1hWcnFLbHA2ZWtuSEVPYXo5S3JRRDZwNld4VExZYTNm?=
 =?utf-8?B?TndUTlNLdk02bXNWQjZMTzRqbUVmbFJtZm5VcTgvWURSK0VKTERicUZpQWZ6?=
 =?utf-8?B?VzdTUmp0Mk5TazhQT2dkbnp0SUFBbC9STjR0dkZ1Q3ZQY2F6RGUvamJTeUZs?=
 =?utf-8?B?V1NrTTVDbTVGNnl5RjRKKzV5ZVgxL2hydjR0SndhajlFSEU5WkdiVWxwa3p0?=
 =?utf-8?B?ZGJXd1IrV3QzY2hiNGRvc25NZkQ3RVIwcEYwMVRRczRjT0lQeFpHKzZIekkv?=
 =?utf-8?B?Y29selgwd3E5cWtKYlBWSGJNb1lDelRwOXNSemlSdE1mUVdiNXZhZXhOVzkr?=
 =?utf-8?B?eVp3VVN4RWNCTWNVMjZSMStVbFNMS05jcXcwaHl2LzFzNFh6aThRU09vWHds?=
 =?utf-8?B?RzJOSjJtLzh5Slh3VmMyUVJUa0U2Z0s2QUx1TFFFUlhsU0VPYTNPUTd6c3N4?=
 =?utf-8?B?MnpuRjJ4N0M4VzlmS2ZLT0VhUjI1Z0MydDRZdC9reWF3OFRZNzlBQUpzWW8x?=
 =?utf-8?B?RVpxdHpDZlkxaGFCTDVBc2pCWnEwbUpEajBtWHFJMDdTV3YwMFllcEFmc2N1?=
 =?utf-8?B?endCY2NObVNPSUp2QWNNSExLUXI0THIwQzVvSDhtUVVub001MVd6eVlZcXc3?=
 =?utf-8?B?Mkl3Uy9yZnRramlNMy9peWlvdUFRMVpKbWlFZTlLNk5aNDVrMGF4Q1c1bklW?=
 =?utf-8?B?eC9PV0hzTG5qa0FMKzFVNE9rMVl3RmxFeFE3U0RsOENuTzdWMTY4T0RncVBB?=
 =?utf-8?B?S01nR1JWYlF1dmJxMlFRNjFSemdaYWtCVTNWVENlM2crUE8weWR1eFdUZUZ6?=
 =?utf-8?B?K1RzamsxVzRxakJnM1FsMjVTNEM4TVdaSEVOQUhmYUVmWlArV2FUSzJxZTFw?=
 =?utf-8?B?bndaM0JxME45MnE4ZkIybnVCTVhBVHJibDltWFU3cTB5N1gwTFRFdWxwQ1Av?=
 =?utf-8?B?d25oa2NzaVNZYm45OWRNRVJFYVlnUS9QbkJvK2haMEFQYTNqdUZ0UWN2RlFr?=
 =?utf-8?B?MlV0Tm1SZmt5OE9WQXFDSDhQaXB0NFV5L0ZmcEgxdERyaGppa2NvM2RmTE9i?=
 =?utf-8?B?RDBqbDRRRWVtOXZ2Vk0yRHFsem42WXBSWWI5N21leXJkenNpL21xeDZFcTF2?=
 =?utf-8?B?bzBPVTNhT0gzaitkVDd0bC9rdUkraytkYmhvTnBDcElDODZuQVhKSTY3cVNl?=
 =?utf-8?B?MndNcjNOQmtnUGphckFUKzJqMmtjU2ovOHh3WDVGMmd6YXd3aWIvSWZSaU9y?=
 =?utf-8?Q?DWlnJG5NAd5z0lGv5aalqXE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81569FAB2078DC4D84B676C8B7C99CFA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c113ac-ce04-4578-13e8-08dc79979122
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:46.1263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wVz3ykZjwVZRfeQli12TkNPKeKzWlyc2pN8GWYnaARcYjCJy8xJQcXqNtvmPKH2aEm9MDWB22+2duFHXNJz/FiVdkGVRlHf587rbNj//AikAkTwuHuzmWYkW09phvDq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

V2UgYWRkIGEgY29udmVuaWVudCB3YXkgdG8gaW5pdGlhbGl6ZSBhbiBkZXZpY2UtaW90bGIgbm90
aWZpZXIuDQpUaGlzIGlzIG1lYW50IHRvIGJlIHVzZWQgYnkgQVRTLWNhcGFibGUgZGV2aWNlcy4N
Cg0KcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkIGlzIGludHJvZHVjZXMgaW4g
dGhpcyBjb21taXQgYW5kDQp3aWxsIGJlIHVzZWQgaW4gc2V2ZXJhbCBvdGhlciBTVk0tcmVsYXRl
ZCBmdW5jdGlvbnMgZXhwb3NlZCBpbg0KdGhlIFBDSSBBUEkuDQoNClNpZ25lZC1vZmYtYnk6IENs
w6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0K
LS0tDQogaHcvcGNpL3BjaS5jICAgICAgICAgfCA0MCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpLmggfCAxNSArKysrKysrKysrKysr
KysNCiAyIGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2h3
L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KaW5kZXggM2ZlNDdkNDAwMi4uMGUxNGVmNGFiMiAx
MDA2NDQNCi0tLSBhL2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNpL3BjaS5jDQpAQCAtMjc0Nyw2
ICsyNzQ3LDQ2IEBAIEFkZHJlc3NTcGFjZSAqcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNl
KFBDSURldmljZSAqZGV2KQ0KICAgICByZXR1cm4gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5Ow0KIH0N
CiANCitzdGF0aWMgSU9NTVVNZW1vcnlSZWdpb24gKnBjaV9kZXZpY2VfaW9tbXVfbWVtb3J5X3Jl
Z2lvbl9wYXNpZChQQ0lEZXZpY2UgKmRldiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCkNCit7DQor
ICAgIFBDSUJ1cyAqYnVzOw0KKyAgICBQQ0lCdXMgKmlvbW11X2J1czsNCisgICAgaW50IGRldmZu
Ow0KKw0KKyAgICAvKg0KKyAgICAgKiBUaGlzIGZ1bmN0aW9uIGlzIGZvciBpbnRlcm5hbCB1c2Ug
aW4gdGhlIG1vZHVsZSwNCisgICAgICogd2UgY2FuIGNhbGwgaXQgd2l0aCBQQ0lfTk9fUEFTSUQN
CisgICAgICovDQorICAgIGlmICghZGV2LT5pc19tYXN0ZXIgfHwNCisgICAgICAgICAgICAoKHBh
c2lkICE9IFBDSV9OT19QQVNJRCkgJiYgIXBjaWVfcGFzaWRfZW5hYmxlZChkZXYpKSkgew0KKyAg
ICAgICAgcmV0dXJuIE5VTEw7DQorICAgIH0NCisNCisgICAgcGNpX2RldmljZV9nZXRfaW9tbXVf
YnVzX2RldmZuKGRldiwgJmJ1cywgJmlvbW11X2J1cywgJmRldmZuKTsNCisgICAgaWYgKGlvbW11
X2J1cyAmJiBpb21tdV9idXMtPmlvbW11X29wcy0+Z2V0X21lbW9yeV9yZWdpb25fcGFzaWQpIHsN
CisgICAgICAgIHJldHVybiBpb21tdV9idXMtPmlvbW11X29wcy0+Z2V0X21lbW9yeV9yZWdpb25f
cGFzaWQoYnVzLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvbW11X2J1cy0+
aW9tbXVfb3BhcXVlLCBkZXZmbiwgcGFzaWQpOw0KKyAgICB9DQorICAgIHJldHVybiBOVUxMOw0K
K30NCisNCitib29sIHBjaV9pb21tdV9pbml0X2lvdGxiX25vdGlmaWVyKFBDSURldmljZSAqZGV2
LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElP
TU1VTm90aWZpZXIgKm4sIElPTU1VTm90aWZ5IGZuLA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdm9pZCogb3BhcXVlKQ0KK3sNCisgICAgSU9NTVVNZW1vcnlSZWdpb24gKmlv
bW11X21yID0gcGNpX2RldmljZV9pb21tdV9tZW1vcnlfcmVnaW9uX3Bhc2lkKGRldiwNCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBwYXNpZCk7DQorICAgIGlmICghaW9tbXVfbXIpIHsNCisgICAgICAgIHJldHVy
biBmYWxzZTsNCisgICAgfQ0KKyAgICBpb21tdV9ub3RpZmllcl9pbml0KG4sIGZuLCBJT01NVV9O
T1RJRklFUl9ERVZJT1RMQl9FVkVOVFMsIDAsIEhXQUREUl9NQVgsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgbWVtb3J5X3JlZ2lvbl9pb21tdV9hdHRyc190b19pbmRleChpb21tdV9tciwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUVN
VFhBVFRSU19VTlNQRUNJRklFRCkpOw0KKyAgICBuLT5vcGFxdWUgPSBvcGFxdWU7DQorICAgIHJl
dHVybiB0cnVlOw0KK30NCisNCiBBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVz
c19zcGFjZV9wYXNpZChQQ0lEZXZpY2UgKmRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCkNCiB7DQpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9wY2kvcGNpLmggYi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KaW5kZXggNmM2
MGY3YTdjNS4uMjE0Nzk4MTQyMyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQor
KysgYi9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KQEAgLTQ1OCw2ICs0NTgsMjEgQEAgYm9vbCBwY2lf
ZGV2aWNlX3NldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYsIEhvc3RJT01NVURldmljZSAq
aGlvZCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0K
IHZvaWQgcGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYpOw0KIA0K
Ky8qKg0KKyAqIHBjaV9pb21tdV9pbml0X2lvdGxiX25vdGlmaWVyOiBpbml0aWFsaXplIGFuIElP
TU1VIG5vdGlmaWVyDQorICoNCisgKiBUaGlzIGZ1bmN0aW9uIGlzIHVzZWQgYnkgZGV2aWNlcyBi
ZWZvcmUgcmVnaXN0ZXJpbmcgYW4gSU9UTEIgbm90aWZpZXINCisgKg0KKyAqIEBkZXY6IHRoZSBk
ZXZpY2UNCisgKiBAcGFzaWQ6IHRoZSBwYXNpZCBvZiB0aGUgYWRkcmVzcyBzcGFjZSB0byB3YXRj
aA0KKyAqIEBuOiB0aGUgbm90aWZpZXIgdG8gaW5pdGlhbGl6ZQ0KKyAqIEBmbjogdGhlIGNhbGxi
YWNrIHRvIGJlIGluc3RhbGxlZA0KKyAqIEBvcGFxdWU6IHVzZXIgcG9pbnRlciB0aGF0IGNhbiBi
ZSB1c2VkIHRvIHN0b3JlIGEgc3RhdGUNCisgKi8NCitib29sIHBjaV9pb21tdV9pbml0X2lvdGxi
X25vdGlmaWVyKFBDSURldmljZSAqZGV2LCB1aW50MzJfdCBwYXNpZCwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIElPTU1VTm90aWZpZXIgKm4sIElPTU1VTm90aWZ5IGZuLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCogb3BhcXVlKTsNCisNCiAv
KioNCiAgKiBwY2lfc2V0dXBfaW9tbXU6IEluaXRpYWxpemUgc3BlY2lmaWMgSU9NTVUgaGFuZGxl
cnMgZm9yIGEgUENJQnVzDQogICoNCi0tIA0KMi40NC4wDQo=


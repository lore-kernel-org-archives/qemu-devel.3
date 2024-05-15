Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E4DC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qI-0004XF-8d; Wed, 15 May 2024 03:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qF-0004Vs-52
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:23 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qD-0000oW-B6
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757261; x=1747293261;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oYY4iC6hjphMuWFvN9OX+COHJCqK87uXfmgSAcUtRSw=;
 b=u/ur5GVlhXnJORysqrHKHlDcgcV3PZXJ8j3JXgRmyF5QaxAsUwxEtEfa
 0GyDhtdYuUZDtsiEI25KWm/7qAB6sXzekjeUiX96/YMNfh5bjs0LgXyif
 9ElZFh/G75f4VCVActDAc9i1CqdDYgjxY2XRsJ14BXFAxnKd8Ajfrzl6c
 Q7Mlv8kbX2pP+Uq0v3keiXbC6LcX95gpBxGW0B1O3MMQUx8gr4742jOk8
 Ns0vbjUmu54+6YXttGJFOMvQP8ceUvVVFZhUDvjnCDv2P4rtyH8GfG2fJ
 ZOxpk3jnK582MAa0TlJq4iE1cl5EdIl3JUFvDp+lbIlZf07WTDyACNbLO Q==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581791"
X-MGA-submission: =?us-ascii?q?MDHLic8GIb8P44XQJMd5iXMUqrMQcUO+B2t9Xu?=
 =?us-ascii?q?DVFk/vKpfgR9fSFfoqlh84Gsr0eE0Lf+9HBCBKmm9/Huao4ZpNjjsp+0?=
 =?us-ascii?q?uQlvx4/mFekoy/aH8Sq66viOoBkh26w9jLuzgAH+XFIHlHC4cHTHvD8f?=
 =?us-ascii?q?CF+E1JGMkQC27ErL2CRnXRng=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:15 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+9TDeDtX0qg2c1RdU3ct72eZ4ixxKxPQq+q+nsBqk+F/dYM1Qnufisa5J6EwIrAGw1rq/KkLCRdrHDRSeNUHJu9HfJSUgfNcqkIe86FIAVBNivYBOrDZ6J/3yj4GH4NV3cK8JUPkw7wGFXaiPwzCoVGqw7QY2cE7IxEVT2UrLH8oY6bWtKrRUg0O1tNLwL1ytrLkVqOlFKvaGcDnuYAjk8T2yMVFwEBfdxmlHjQCylxcek7y2WXBMw613js9WClUaXMRLTpDG/epsscmkfTfzRzS9+0Bz6rAUFM/2mOp9o48x7ejINwQ3vlzAwfmMuSGHwesUOjX6f1AQLtvHqJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYY4iC6hjphMuWFvN9OX+COHJCqK87uXfmgSAcUtRSw=;
 b=H4QLhS6MBQCh6d6IHxM4IcHoFws8Xeaz+FPtZVisV90dJ0ZMLJxWntypu3KtaDfSFsYSHLKGnNGSoCNrN4MVd3Vg/rP65FhAQm80UyGw30GNkpyYRnYZaPrhUQbJuRfTMF/x8kgp3SKIYbghIN+NiVPGXhAI2J1uPsWhF2KI9I2ombjGAbX5LkiJOJP8VSp8xTUSYRDx5ZKaRsEo2GVmdE2XXeobchLe30x1xrH53aYnZA1EQ7OJ9FWdgTkjnEptpVsbTOrSrmlNy+Zgemz1QjXgWXBlYkO4AXTm4GlbsAjsJvzr1dpHwg78vvQy7IDlQS6SWV/OKBVRsynsRszH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:14 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:13 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 01/25] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH ats_vtd v2 01/25] intel_iommu: fix FRCD construction
 macro.
Thread-Index: AQHappd9IJaBN0w6+0yo/6p5M8k7GQ==
Date: Wed, 15 May 2024 07:14:13 +0000
Message-ID: <20240515071057.33990-2-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: 460be09f-431f-4ca4-29a7-08dc74aea026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RGtKemR6R3JmcWVlZHRtYnZXUmJQYnYyemY5ZFJzV1VFVTFCUVVlR2s1ei8y?=
 =?utf-8?B?ZTJIUVJVWmplS1hSVTRtcXhpRW1lOWxTOTQwNkRORlF6OU4yb1BmaFAvU1FS?=
 =?utf-8?B?am5NNzh3aC8zSFppR3dLSGF1UVVXOVVFbUNvMHdreW96a0djUmY3NTgwK1RD?=
 =?utf-8?B?aHpTVkJpUTRjOG1yaEV1MUwyR1UxR3VLYmoyQmU5c2tuaStyaG5DbXR1YWo5?=
 =?utf-8?B?QjJTd3FjbGhYajFmenZtK2RFNUFLWm9UQWN3NzlkUHpyZlJlQVJRQldjdUhu?=
 =?utf-8?B?cW5YVTdjWmdNcHh6ZExsbk9MUGJXOVBmT0RWQ1pjOFhINVdqUjdWQjk5SkRh?=
 =?utf-8?B?WFJZamhBYSt5Y0dETXJ0ZzNqaXN1bmlQRTFsbVphaXZ6cXNmUnFTeWtqcDdy?=
 =?utf-8?B?MERnekJVaDE0NXdScU5Jc2NiNWMwWkFpT3V0ZnY5a0pTNWJrcW9jeTVSY1hL?=
 =?utf-8?B?ay9OY25hVFJkdGVseDFVdmRET2ZXa0FXL3M2UmtuOFppYTgxZ0FTbGcwcURF?=
 =?utf-8?B?cGxvYXBLL2htMGUvOTQwZ2FyNFZBbm0zck1PYnFDVi92Vll6dlIwcTFzZ1l0?=
 =?utf-8?B?MzZmQ1ZZaE5BVU5RUE1vMHRYQ0R1QWFjS3libWFwZ1N4WGpsaXNidXVtejdm?=
 =?utf-8?B?WGtndXdva3BxdU82bDc1MFFOekZXbkZEWFl4SjlpMFdCekVYOGpDck1SbmVm?=
 =?utf-8?B?QmJYS25tNXlJNXhnb3pGRGMzeHRFeUl0R09FSXFLVjJKMU1JRk1pTzFodWxE?=
 =?utf-8?B?RjdEN2g2Z2FGUG1ZbStGUElyZzUvSEtzNWY0Y2RjWEVybnMyS3R5aWhvb0FH?=
 =?utf-8?B?RmQ5UnhtcHI5NXNCWEYxOXRQRjRmUEdQYk9VV2Nhd2x4c0pEMWN1NUdUWlpa?=
 =?utf-8?B?MzZQZUpVL1F6R1FaaWRpS3haZHloUDcwK3NRYkFMMVl0NTRGOFI4ZDMzOTRv?=
 =?utf-8?B?KzUrWG5WUkhlb0dPUVU5eWd4OGY1WURORmU4aGhTM1lkNHdidWdRajc3dmU1?=
 =?utf-8?B?MEFOaVQ3VEVCbkpOdEpqcWxFcDZCZlFCa1VPNnZ0dlFQY2xlZTBKbXBROEFS?=
 =?utf-8?B?dnRBUHZjWDFMQ2ZQOTJxZXg1NGpyb011MUhmbzNNSUxHYkNZM0ZSQUVmUUNj?=
 =?utf-8?B?R0lsdnhiWDZYamlOTFdEQ1hTVzB1aW53NE5sZXlrWjFDZFA1bkxsYzZTTDZi?=
 =?utf-8?B?dFpCcFVsQXZnTUpicWJGZjA3TXVyRk9vVHpWbU43YlV4ZjdTenlGbWdpWHY3?=
 =?utf-8?B?bXAvM2xUcStWTDFqR1hPSkVUdjllMktVbnFWcGk5N08xUFBBRFZTcWJKc1lq?=
 =?utf-8?B?WW9hcnNlMkxlempkakh0cmljcHNlSjE4QVJPbDcvUm9JNXo4bWtkdXgrQVZF?=
 =?utf-8?B?M1J6YmdTVlRzQWs2bGlsMHB1VnpqNnFYM3FHWUdXaGhnUDFIZEdEWU5HWkty?=
 =?utf-8?B?MEVEOTZNVitGbFRZejlwV2J0dkZ0MVFVYjdUNUwvNWNTUmVuQ3VlczJpQVYx?=
 =?utf-8?B?WjdFVzh2Yjk3OWJJSzJMeE1TMjZsL0ZrQUI4UisxNkJqS240UEJxT1QxQm9t?=
 =?utf-8?B?MTUzYlBRdnlvcmRCQXRRbUpmdFJZQk84dHJHTjZhdTBMQlJuNlEwaDBBc2xV?=
 =?utf-8?B?NFhLS1FMbzF0YVhDU2VmaS9jSlFHNVN3ck8yN2RRZWVUUDZDemZmajBmMXVu?=
 =?utf-8?B?K3pmTjZ1cVREQW1qcmxjRVNwRjJUb0xGT0tOWXYwV0pWZC9tb09WQXI0V252?=
 =?utf-8?B?dEpvTzJhUEFISDQ4TlZYYzlIb2V0ZmFDUE5BTXZDekk5djZnOUNPR1hBb1lm?=
 =?utf-8?B?Q3Z0V3dMTmhqSnI4ZlRjUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW56MVpuUEQwZ2N0QWxCTFBRK0h0a2ZJbTlmWHY2WEhTVS9JRWJFL2N1SkRp?=
 =?utf-8?B?d2lLMjVybGdkVWtLTkFqdE9NU1lMa0ZiVXBOMlJiTGFsYU85QmcwNnhqZVA5?=
 =?utf-8?B?V0VuanZqOWlxcHFEeFNMUmJrcGNYdjIvTWVTbXVoRjh1K3pNTnJIMDBrVlZR?=
 =?utf-8?B?NFZoeXAwVlRGd2owRXhkMjhyWVdwa2p3QXR1aWZKN3hXZDVsSGpISUthOWpn?=
 =?utf-8?B?SWx0Y0F2TVVuREZGdnZYMGltc1E0d0E5UVczMEFEN2VTZ2JOMXVBZE9ZbEl0?=
 =?utf-8?B?OEhUUU1XdmNFMGZicEYxb3prd3NEUTlyV0FsbG1iSVdtdEIrL3RBQkFzSm5B?=
 =?utf-8?B?LzVpREl5K2RBV05XaENobHd6VEFlL3RzMTJwdThsRU50VVUxNEtpc3dxY3Js?=
 =?utf-8?B?dXB0ZXFJbTVkQ2EvVVNnN1oxSlZmUFVDNUIrYVNqQ056SGZMelRoVC9oZUVa?=
 =?utf-8?B?cmJRWWR1bnpFN1ltaDQ3WkMwM29UWkg5d0NVK0xLV1l1OWw3ZVU3OUp5Q0ZT?=
 =?utf-8?B?Vzh0UWdxRDlIRnNlRElTSUxhanNhUlhXcVpHSFM5dWJsZkJicmVoQ0RHYmRV?=
 =?utf-8?B?WkJ1MUI2a3NpcUlsdTB4dnNScktOYnJuZUtBTkI5NEpBR1lqc2RuZXFpZWkw?=
 =?utf-8?B?VUJhY3BuL2JuZWpaNmRTemdSUkJEQ0lkQmxmTTRiRy9XMDV3VHN0dC9HV3Zo?=
 =?utf-8?B?TmhBUWFkN3h1WU1EMHBvcXUwWE83YkNzeUJUb3lJaGxBRUxoR0QxZFJXNkdj?=
 =?utf-8?B?aG55Tmd4NGtFd1grME5Tck9DVEwwV29uYkl2MElCV0Fnc01teVJUZ2x5SGo3?=
 =?utf-8?B?dndZdHVNNkQwWGJVbk9mNTNCc0trNXVQNm5NN0lGdlRBWU4yNVRDTEtqMDRm?=
 =?utf-8?B?L2tFb2xPQ3RsSDBTVTJ2S094U1dsSzU3M21zUFNFRElVZFMxQ05UWlEwejJN?=
 =?utf-8?B?ZVovRTZ5ZDdqZTRhbGw1a0t5RTNGVjNWN0ZFMkFTZEtCUGNnTHM4a3BlZkQ3?=
 =?utf-8?B?ZEk3L2ZHWTAzcWI0NTlwWFBLVmpIZDZBUDJodXFxbGdPSThzL1YvdlhaUHBG?=
 =?utf-8?B?cWhpbVUxT1pTMzFPYVR3ckZmenV4dWlJOC9DK2J3aUE3dUZGRU16OG8yQkUr?=
 =?utf-8?B?RmhYczJYbU1sSjNhYWdOTWFNSnR4aEN0WjZTelJ0Sm03TS8xVE5WSHg3RFJ6?=
 =?utf-8?B?ekEzQ010eWlKNklIanZFanI4RGt4M3ltdi94KzJyQmFyWDlnM251ajEybXhu?=
 =?utf-8?B?Z05MdC9jMTJMSWRZY3YzbDVRZmFpNzJJUDkybmNjTWdXTEtUTmh1aElYRjRH?=
 =?utf-8?B?UGpjR0s4bUVISWxBakJkUXhtOFFQQnZGOWM1OFlHWk9sbHBXNzRQT0YwczFO?=
 =?utf-8?B?c05Lek1LaGdqYTVOTEd0azg2aHpyb3g0Q3hQNkxTOEFKRnZaNzZsWkkzamo1?=
 =?utf-8?B?amFHMmpEYkwyOEE3YnFjVXFUMENKRjhSNXhaRW8wdlhTZTNoU0pKcHNJQlhX?=
 =?utf-8?B?aFhJSDR5SVpVV2pWcThFcWZjNmk2aDRrSW9RZGhqbTdvNVE0UStIenNMWWVC?=
 =?utf-8?B?eWp6Q0VReHJLbk0xQ3VZNzBXQUNkMTBQR3IxNVYwN3p5YjlYRHJLcGV2SGRK?=
 =?utf-8?B?Ky9ybjJBZzNabmJ0SVVRTGkrS1E3QVpudmRiM3lzUzE2Nmh6QmFtbzEvS2xr?=
 =?utf-8?B?R1c3MTlkdnJFT1dkZ3plRkVtZG1MVDc2NDNJY1RLVE5wRmliNDVwQXk2Y2NI?=
 =?utf-8?B?MDZDenVobDRNNkliOUgya0NzaEVCOGFNR0o3aW85TTRsa3pnUVBwK0lUSEpU?=
 =?utf-8?B?cFc2ZHp0Sy9ZSi9hNjd2dGZ1MlhrWHNQbThwQkw3ejdCakRSc2Z4eEliNkhn?=
 =?utf-8?B?b0ZTVFZiK3NpQzRDTjFpaGZQbUQya1NTbnhDTnFRRkMza3l5cFlXMXpRckx6?=
 =?utf-8?B?Ylpuc1FiM2VpV3ZoVzRhdmJEZnR1UnhIbjhiQnpjd21wWnBibnREMHhzUFpG?=
 =?utf-8?B?Yy9vdnFaTmEzeW0zcEV2TzNLdytyZUdRRDlUUWNkRVFxV1FtS2hCZ2NLcVN3?=
 =?utf-8?B?MnRnSVpmWHNNbGJmRG5TeXJXREdmdEtpalIwYmNlSHJpaFpLVEVBTVlBaXVu?=
 =?utf-8?B?d3FEYVZIdU0xamtpWnN0djZQbmpZaUw0U2VSNGRzamgxSlVKWncwdll5YjZE?=
 =?utf-8?Q?9smEvf9qIUYafMMPwmd79H0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B6B8BC14EE7344AB84FF1068C64F457@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460be09f-431f-4ca4-29a7-08dc74aea026
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:13.9268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OuSB1LSPvE2v7FmlZiJgeO6C/6jiagrFJ/chlSGutNRQtVLd+2NDo9wX0rlAG9B3Bb58ku3N4JO/c8mVvNDUzO1p4cNTWagLSA83RlvZvc+OoeEjZVdaIRYV3Uka445
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
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

VGhlIGNvbnN0YW50IG11c3QgYmUgdW5zaWduZWQsIG90aGVyd2lzZSB0aGUgdHdvJ3MgY29tcGxl
bWVudA0Kb3ZlcnJpZGVzIHRoZSBvdGhlciBmaWVsZHMgd2hlbiBhIFBBU0lEIGlzIHByZXNlbnQN
Cg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1
LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
fCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IGM1ZWZjZmY5ZmQuLjRmNmIwMTU0YjUgMTAwNjQ0
DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTI3MSw3ICsyNzEsNyBAQA0KIC8qIEZvciB0aGUgbG93
IDY0LWJpdCBvZiAxMjgtYml0ICovDQogI2RlZmluZSBWVERfRlJDRF9GSSh2YWwpICAgICAgICAo
KHZhbCkgJiB+MHhmZmZVTEwpDQogI2RlZmluZSBWVERfRlJDRF9QVih2YWwpICAgICAgICAoKCh2
YWwpICYgMHhmZmZmVUxMKSA8PCA0MCkNCi0jZGVmaW5lIFZURF9GUkNEX1BQKHZhbCkgICAgICAg
ICgoKHZhbCkgJiAweDEpIDw8IDMxKQ0KKyNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAg
KCgodmFsKSAmIDB4MVVMTCkgPDwgMzEpDQogI2RlZmluZSBWVERfRlJDRF9JUl9JRFgodmFsKSAg
ICAoKCh2YWwpICYgMHhmZmZmVUxMKSA8PCA0OCkNCiANCiAvKiBETUEgUmVtYXBwaW5nIEZhdWx0
IENvbmRpdGlvbnMgKi8NCi0tIA0KMi40NC4wDQo=


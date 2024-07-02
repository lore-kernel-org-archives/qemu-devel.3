Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F94C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRl-00083T-Mf; Tue, 02 Jul 2024 01:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRg-00082J-VU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:53 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRf-0006b9-1k
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899571; x=1751435571;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Muq8pnfZbNY4iEecuK0xCGQ8mJotLYw5kLEyQZ2VRlA=;
 b=G9RQi1gnyGYNmD8mV8zhUWreTcKGOTUvY38EC4iMmroPfwjx6v/WeB6P
 j8BLNifpQOvYV4/X2G0tDktoljNTAsoqC2g250WEq4a5MpWlkPkOIF5ja
 iXcW91HUNigdVqevUrCoJKbG74p3wy41WoO+/1biAjMj5d4JJhvVR0eGu
 zYUehKjaf4i8WQCK1lz/FtVmZqUYxJIYaTnGZ3G3LcO+XweJj0hHoaQrm
 /Wm7hfUnicCN/AGxbRBGnd7amyONRVOAOOXeqlCo7pw++pEMyhe1YWBw+
 5e41e04YcFZymTSbyXWfepgBXwv46cj6a9aTmFjETmduhkOmoPljBM4iP g==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721604"
X-MGA-submission: =?us-ascii?q?MDE8uOvL7HiLQCJeWpq41Y52wCRztqtV3QZrEj?=
 =?us-ascii?q?lrVHxhJFBRtbVcQA21HjRAql0nU9eo2GCJklIJhktVESdqKr5fPTgUdx?=
 =?us-ascii?q?AouURGTJg+xJq1CRY8Jt6ZrmT6A2cwm2rGq8CAuGT+OWsBuwTBKVGdmG?=
 =?us-ascii?q?iJvVIE3ZR+j2fwpS7F5w8Ctg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:48 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LErkWcOe78z5n1pxJf0m8oVfCiXGDqOeQtut4ntByWVtx9yDaT206KS5Hh1RiIERpC/jBbVHiOm+PB5gDxhblNVekan4mNwu2LEprhIRxQcoFJv2AEczk9VOjsZ0LWyiqf9fTwtIlwLbrRNYgwl1Efwnu3++9+uCYu6nnvZkGsPeVBa+Pby/nsARnwNgY0W7Tp/NktOHwmJ/clc2ThTgWPsIanAA6GwPO/OKYpCYC9JUBCQ1dPlSfDsXKBBTNuiZ+HG06V/7dsiNnEO+e4rFhLvsdgKLvyXhzw90UPa1uOfx5ULwmDiBdqZxCkeMfAdoWuP1LdV0CG/3/5jTeP7AAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Muq8pnfZbNY4iEecuK0xCGQ8mJotLYw5kLEyQZ2VRlA=;
 b=bORTjWXuOybvyyp2MsUE5MDjobCtfOx6g1Gkn1CS157SHqi7pxRcos5m0+/MB57jRiZCEqD+QkFc21JF/91MIHlb+7VElT84k2hi0XVO2IUpv6EISpU8gCqMnnDYOL49ENzisYfRT9t7dAmo9baAklWHhrFA8PXj1ahBcLj7RJATQQRH9pVYn48VJZDxHZTBFjF6fVpsTJWeRz/MfZGLxexpR1+iWFrNtF9f1/gEIozg5JX4+se33D6dPN5zzp+JJbJSXgzGsPKDJiauT/73D9AI0eRehZn6dpRugMJMw2mRHVD6YeErIlIFUcLkFktyR5y5BnEwNgVXOlAZ8GtMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Muq8pnfZbNY4iEecuK0xCGQ8mJotLYw5kLEyQZ2VRlA=;
 b=fNCqRCqmHI9zXgmJeEPZ7+3djtCgbcU571L5/6c1yJt26E4x6z86daTAiS7cUn95kFh9dFu6iE+jocc23o2v+x0CRzF/8C+ze8GWdceeXW1Dyosz6cA0DWyuWhZwer0uf6wCQz/RKS2ibf03N1GutLMNbq6Y/DFWHN1WYwFgu4FSClrkXGZE1YXHsz62oz61PupQqsLhcyjDm5qMDqRUGXjTG8pDQMwaQs9hXa6oJ6vNPhE9We+5U0mnB/ECgBX0AkkOTXVA56d4hwvm7/QQefZwk6cthikJehCyVFtoxV2ryFHBDwrqOnol+KoVfgVB56lIwampmOSQex23FnKNpg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6215.eurprd07.prod.outlook.com (2603:10a6:20b:13d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 21/22] intel_iommu: set the address mask even when
 a translation fails
Thread-Topic: [PATCH ats_vtd v5 21/22] intel_iommu: set the address mask even
 when a translation fails
Thread-Index: AQHazEQQOKgkVaNcZUe4tah2aD0JqQ==
Date: Tue, 2 Jul 2024 05:52:46 +0000
Message-ID: <20240702055221.1337035-22-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6215:EE_
x-ms-office365-filtering-correlation-id: 7496a2c4-4d47-443d-8be3-08dc9a5b328a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZlFPdGE2dVRrdU1tcHZ3RXZsYTltL0J6VEd0RGVQOWNRZ2ZDZWwzZTFMNnBR?=
 =?utf-8?B?ajZ3Z0JCQkZxdDJ5UVJQYUx6aC80OUJjdGxHQWE4d3NScThyczBHdG9NTEsw?=
 =?utf-8?B?VHcyZzZzRCtOYnVIelFqeHdrUmlVTU1XcjBEaUx1NEU4alYxNFJEcjB2aDdl?=
 =?utf-8?B?ZzkxRDhOV3VNeHZMRDF1UjVtcFcybHdYNkhIUllOTHVXRXBMUUZuNEl6M0JW?=
 =?utf-8?B?U0M2K0RIUFFvUVY2bnlQMUpPYnVpOGlKVmxsQlIvQlVKRHYramQ1SktRMGlL?=
 =?utf-8?B?UnB3WVZpR0xLY3NTNzlWdFYzM3NyS3lmdWVVWWlyM0VHeGVvS0FmbWRPODZN?=
 =?utf-8?B?VFY1SmhWUEUrTm82MmV4TW1QZ3NUOFZOYjUweS85ZUgwallWaVBtMkFta1JU?=
 =?utf-8?B?Wk1OYmwvMXB3bWVyUmhqS3U0WnRSTlh0ZVMydHdMRFJJSzJhaEtIdHdKU1dl?=
 =?utf-8?B?YmpzWjNHN0gwL29qZkROam9rcUk2YmdHcnFCRmMxUzlFTTdCejZuS3pLR1JV?=
 =?utf-8?B?Q1BVUTdvNlI3dlZzM1pJcUk2TDBRR1M5YVRQelNaNnBEcjdKeit3MkhVR0Zq?=
 =?utf-8?B?Z0JoMy9LSzVBcHZqenh5YVpSMXJmVEo1QXU2N0tJWTh5UlNubnYvK0ZvUmw0?=
 =?utf-8?B?QlV4K3ZhZ0JBV1VWZFN0R3U2djQ0SUEyd3ZMYzJVTjllc3Y2ZHdzRkpzNzJJ?=
 =?utf-8?B?Q1oyU2E2anF1MFp4UkFjQVVMdlpnRkpsVEdkUTl1SjBOc3h5Si9XY1d5K1do?=
 =?utf-8?B?RjhGWkFUaUtKMWxIL090WFMvVWVid2ppeHViT0VYZXl4bGV6d0p3Tkp1c0F3?=
 =?utf-8?B?bWwxa1VmeTJ0ajBFdDl0ejBxNnJrVEZNeVhpUWpYV09wWWpkdk1aUW5HUm9O?=
 =?utf-8?B?T05ZaFUrTGFPTDVLaS93NkFDNmNOUWR3S1pVNGt5MEFybEwzaGl3dmhEbjRr?=
 =?utf-8?B?aXZqUlhFOHVrbEFEVktaZ1U1WW1lbHRWakwva2s4SCtvWk9qbFpMNVl5SWhN?=
 =?utf-8?B?WGtzd2lXdjllNHVIa0dEc1ZiYVRKV21GSzRSSmhseDdUU093cExJKzBSTTJR?=
 =?utf-8?B?cXIzK1dRMFhMQVRVMmhzNTJERVRmTjVtVmRHWTY4NzcyYm5LNlBSK1NEaE1C?=
 =?utf-8?B?ZDBMY1dlY3p5K2szOWRRcjFKYkpjbzdQV09lTmwwK2dySkNXeFNDbTVyNDN6?=
 =?utf-8?B?T0F2ZGM1SnE2cXpZTUd0dVdTNmNublBWcG9oYWhvaG5QcnZUK2RYOU5sMjY2?=
 =?utf-8?B?ZTNVQndaMHA1OEdMK0RkUnBKb1pwajNVUHFnQ0NnaXAzRjYybFZOb2Y4OEtE?=
 =?utf-8?B?cVYxSzNUZkVlTnpTeTNFM2dpYXQ1WWZBQW4yRDdhcTA1SGRDMUhmUTFFbE0y?=
 =?utf-8?B?U3g3VXBIWjBYRUQ5MHBhOW9BUDJNOG1XOE93SkhaSVFZWGQ5cTJNU3NpT1Zj?=
 =?utf-8?B?anl3NllEdndFWXFwSjk5clJwY0NaK0Y5dWM4d21lcWxJd2lCVXBPZkV1UjZZ?=
 =?utf-8?B?aHQ3SVVMaEY2U2xIeXBtNTZJdzFpZmdYRnd5RGJ6WDRrQlZ5VmRRZHBCdkRn?=
 =?utf-8?B?WTNVY2l3UXNTb2NPWTllRkVsbU9jUFExMkk3ZU9HNmdjTlcwb1VnanhLMXI3?=
 =?utf-8?B?OW9idDh4NElubWlGYVRsVUJlcU92eFVqeUQxVGttL1VXdmdoN1cvK3M5Z1ds?=
 =?utf-8?B?cyt2WU9mWnpDMnBKZzc4ZFNRUExlTW1QemxHTmk2RlNYSmNsSkhpY3ZZSGht?=
 =?utf-8?B?VFp5ZU5sRi9xNzBtVmpNVXk4bktNUVUxRnJwNlZGYzhreXQyRXRWZmdMVG5p?=
 =?utf-8?B?dFB4OFJUamFjNUlnZnVBek54a2tydjlTSFJKQXBEZ3BBL0l1Y083dTlReHBU?=
 =?utf-8?B?K2FRa2JZc2lzUHV6OXprSWU3L0hJQVI4OFpYRDlrSldoOWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUVjbisxR0FUMUNSbjNaU1VEVHlmdnNOZEI3NWNvUzE5VDJuVE1PQWo5ZmIr?=
 =?utf-8?B?blJONkI2NVVGbHFMZ3IwZ0RMMjFPMXlhZERFNU5kaVgzd2ZDVWw1RTd5QkVQ?=
 =?utf-8?B?R05sNGs3eGtuTG5GbEFaRjFCMU4wQTVNanorTDlZZE4yZGFpMzArUmhNemtM?=
 =?utf-8?B?M0dPRHVZUE9MNTlWZ0Nvc1pFdUlGRDZmZlh0MjJCUE90cFN1Z1lXTTRQSm1O?=
 =?utf-8?B?WXJEQVRTZndIcDR1VU5YNTNJeGRzSlFFdFFBMHR0bWpKRkZydzF1SlpMRnQx?=
 =?utf-8?B?NUpZZFVXbUFlOHcyNnpqRE9CaEt6S0JxS0hMWHV5R2kwMTM3OWNxUTduUVdn?=
 =?utf-8?B?TVdmSWFrZzAxZVVIOWQ5QW4xYUdsdW5jcEtIRHJwb3FEUXdpSkFwcDBiaW1G?=
 =?utf-8?B?Tlp6K3hlRU1jVjg5TldBRzlwUGo0Vkdieml2TlNjVVZLZ3MvQzc3V1dEb2JB?=
 =?utf-8?B?alJGMHNXWXlIYWdKenA4SDFtbmphR3k4K2xhSjV0aFBXKzRBcFNDRGRmQVFx?=
 =?utf-8?B?K1l0alZPc2RIenRZQWxZaFRpMTljSy92YWlFVk0zYnMzNDRrZ3Y1bG96OHFN?=
 =?utf-8?B?MkZMMjdJNjZZU0EwYno2TlNlQURWQ0xmS0phZys0OGlOQWRNVzFpcGJpcmQr?=
 =?utf-8?B?VkNDNmlMcDh0cXcwTkxRTDJic3Q1cHdvSHgyMktaaStMYU5TeDkzWTRMQnlG?=
 =?utf-8?B?WmhIcmhTd3c1aDZ3NjQ0NGpyN25zTUxyR1VjM3psYUVYT0JJdlpMNkpJSm9O?=
 =?utf-8?B?bUZhMXNabmJ1cWpFakUvc1AySUFEblVrbzlYaWRWSW5oNHh0ejhLc0N1cEtl?=
 =?utf-8?B?ZUJxVzY2RnZ0T1JpTWp4U0lKK0lYL21TaWNxK0FldVFXNW5ILzVUZ3A0c1BM?=
 =?utf-8?B?VWY2SkphZkJWNzZkaVBTOVZwejQrM1ZSWXNTUXFYY1NGaFNuNEFNQldrVnBZ?=
 =?utf-8?B?cmZOclVGN0lDTE4xSElyenBQN1ZxWjQ3bGtPUFhyQ2s5anQvUjdiWGNtM2tN?=
 =?utf-8?B?Q1VpTHUvaWhtNXdvQXJJa2RVZ2ZUOFVxN09MYUJnNEFrZktkVEs4T0xQNW9u?=
 =?utf-8?B?bW5zSWRpbnFIQnFNN2tDSFBiZldGcTFSdS9WcG03OWVvQXNjSDFKS3drVUR1?=
 =?utf-8?B?ZDFkeDBTa0lMMWFQVDh1aGJvVFdvbWpwNzNTSmJDV0l4TzcrQm8zSFUxZHNl?=
 =?utf-8?B?SU8zWVRaclgwTzRmbWI1TWJPalcrMm5VVjd3RDR0Y1BuZ0N1TUMwd1VSV2sv?=
 =?utf-8?B?TVh6akYxQ056RFpBTDEySUN2OU5tRjVCWUFqMmhyb1hoaElRRlZ0UDZyYWNW?=
 =?utf-8?B?VCtHK05UTGNOL2NrVk1zZER5U3JsbmVsL3JuVkt5SEZaNXNHWFRjSFdMcFYy?=
 =?utf-8?B?cFJLM0VDYzU2N2RhanRXVUFsOGhGUmJNS1gwMTIyeE5vTU5qNTJhVzJhS1pl?=
 =?utf-8?B?cTBISWxvUEVYQ0RlVEkrR0V6ZmZ4YWlpQnd1THdrZHFpWXV1T3d5UFN6WlZ5?=
 =?utf-8?B?T0NqeUViTjVUa1Q5c2RjbmVrWXlES0dSL1hXeS9yUEpNc1hGWm1oa1FHMjN1?=
 =?utf-8?B?TlZrdmZuV3Q1cnRDRFdPTXViUXllUFdQOHVJMUowU0Y4b3UvaWZ0TlRUdXpN?=
 =?utf-8?B?a2NNV2wyTFphb05sYm41NEU4RUgwbGxBYzFHUTVpOFpoUUtXYzg1dHBpdVFD?=
 =?utf-8?B?YjhlL3RiN3I0Y05vZ09Tc3dmb0k3Ujc5R0UydUdOcXFabDc0ajdsM2RYRCtx?=
 =?utf-8?B?YVI1OUR0aVE5OGtVVCt4elZUZi9uZThaYkE2YlhjVjkwVWl1MUNOcUhDWm5X?=
 =?utf-8?B?UGZZZmlBZ2Q1dStwVlo3VGN6cENQU3QxOS9kSHprRHVGdGVSZVpmcVdkeklp?=
 =?utf-8?B?TVZlUldnWlNaQkh4SnpPZi9CQWRQeXhwTCtwL2pBKytOSzFNZzhiMU5GNmli?=
 =?utf-8?B?MWdqWVVBeXQ2Sk5Bdncya3lyanZ4WEVvRDRldjBWMTIwSUtzSVZTZnM1dVk4?=
 =?utf-8?B?M2tLT0pGMXdnaGZPNWZvSXE3d08yNkFjMElkZHpyT29Ydy8wNnBNUmR2MG9D?=
 =?utf-8?B?TFpqT1l3UllGVGZtQUk3Yk9lL1RwN3RESUFrTWp4cHN4M1lDZjZYRjcrdFFj?=
 =?utf-8?B?YjBYNDlOaFNMOWhvVU8vZTdPaERFLzJFMjBsSS9FaHFYcnJBbUVxczV2ZTJq?=
 =?utf-8?Q?VFE8y8b172k1NYAlNLscOTg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5A258D6656EC4438DE6B42B5D594EB2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7496a2c4-4d47-443d-8be3-08dc9a5b328a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:46.0308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eV2lYw/OiW+JutQ2/aTZEIfD/Q5PRVckHSYOugq8hRx+Vz/U5KkQCTPI1UQ4NN/6H4vZur5ePQhordCEU+t4eTlPRBBjDQ/G95y08XCu14eZ87pZ9qj+Orf7bVRb/gDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6215
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNCkltcGxlbWVudHMgdGhlIGJlaGF2aW9yIGRlZmluZWQgaW4gc2VjdGlvbiAxMC4y
LjMuNSBvZiBQQ0llIHNwZWMgcmV2IDUuDQpUaGlzIGlzIG5lZWRlZCBieSBkZXZpY2VzIHRoYXQg
c3VwcG9ydCBBVFMuDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNs
ZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21t
dS5jIHwgMTAgKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCmluZGV4IGY3Nzk3MjEzMGYuLjlhMWJjZTlhZTIgMTAwNjQ0DQot
LS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
QEAgLTIxOTIsNyArMjE5Miw4IEBAIHN0YXRpYyBib29sIHZ0ZF9kb19pb21tdV90cmFuc2xhdGUo
VlREQWRkcmVzc1NwYWNlICp2dGRfYXMsIFBDSUJ1cyAqYnVzLA0KICAgICB1aW50OF90IGJ1c19u
dW0gPSBwY2lfYnVzX251bShidXMpOw0KICAgICBWVERDb250ZXh0Q2FjaGVFbnRyeSAqY2NfZW50
cnk7DQogICAgIHVpbnQ2NF90IHB0ZSwgcGFnZV9tYXNrOw0KLSAgICB1aW50MzJfdCBsZXZlbCwg
cGFzaWQgPSB2dGRfYXMtPnBhc2lkOw0KKyAgICB1aW50MzJfdCBsZXZlbCA9IFVJTlQzMl9NQVg7
DQorICAgIHVpbnQzMl90IHBhc2lkID0gdnRkX2FzLT5wYXNpZDsNCiAgICAgdWludDE2X3Qgc291
cmNlX2lkID0gUENJX0JVSUxEX0JERihidXNfbnVtLCBkZXZmbik7DQogICAgIGludCByZXRfZnI7
DQogICAgIGJvb2wgaXNfZnBkX3NldCA9IGZhbHNlOw0KQEAgLTIzMzgsNyArMjMzOSwxMiBAQCBl
cnJvcjoNCiAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCiAgICAgZW50cnktPmlvdmEgPSAwOw0K
ICAgICBlbnRyeS0+dHJhbnNsYXRlZF9hZGRyID0gMDsNCi0gICAgZW50cnktPmFkZHJfbWFzayA9
IDA7DQorICAgIC8qDQorICAgICAqIFNldCB0aGUgbWFzayBmb3IgQVRTICh0aGUgcmFuZ2UgbXVz
dCBiZSBwcmVzZW50IGV2ZW4gd2hlbiB0aGUNCisgICAgICogdHJhbnNsYXRpb24gZmFpbHMgOiBQ
Q0llIHJldiA1IDEwLjIuMy41KQ0KKyAgICAgKi8NCisgICAgZW50cnktPmFkZHJfbWFzayA9IChs
ZXZlbCAhPSBVSU5UMzJfTUFYKSA/DQorICAgICAgICAgICAgICAgICAgICAgICAofnZ0ZF9wdF9s
ZXZlbF9wYWdlX21hc2sobGV2ZWwpKSA6ICh+VlREX1BBR0VfTUFTS180Syk7DQogICAgIGVudHJ5
LT5wZXJtID0gSU9NTVVfTk9ORTsNCiAgICAgZW50cnktPnBhc2lkID0gUENJX05PX1BBU0lEOw0K
ICAgICByZXR1cm4gZmFsc2U7DQotLSANCjIuNDUuMg==


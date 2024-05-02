Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D439BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNU-0003lv-2R; Thu, 02 May 2024 11:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNR-0003jP-Bu
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:41 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNP-0005yW-9i
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663779; x=1746199779;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yH5QD3XjZARI9NR7JHkHrpYtjXbw3x4j6DHe+Uk9p34=;
 b=toMgdF567XjLkFcqXXqv+aabqQrkWROcv71vGfroQ7f84jdPi3zxs4WB
 Hj+LKn7uoKB42roLCXe/tX2f4/akQFXEdnePAVM1SOhaRFXbEiLmrqPlg
 IYOORXuuDM5Hl80nfI38cku4h1jixAz7kKEU/0kPdHy0nNJ0i2PnOIcRf
 UceCYs7j0ykX3NbQKK+808JkSx5ubmqjjDmxpfnsnyPSWfOflqTomqw4I
 NQHvNNwq36P597RwyZ0+m+7htSyoKpUBYJgsZ8qnv6LSwoB6L8Vjf4F/f
 3vj6kOVBLpKKnSghRhbn1YtvnMooWrgEZQ51XhkMwvkA4fgtSZtsUCT56 g==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785878"
X-MGA-submission: =?us-ascii?q?MDHxsaKT8oGbN/KCLq7J2z77+Md6gV85rvSIof?=
 =?us-ascii?q?eX0HwGZWvHc30MwDGwm4Rlzio5nuJ1wkOBkTKuuvn3M0H1IWgJZWqbCU?=
 =?us-ascii?q?Ur+yGVt1VBUj61zYhoxlCH4Rg2l5VVRLruYN00vmSZRDmlIXYp3s+pN8?=
 =?us-ascii?q?4yqSl4MheiYEsWOP5HjswBvg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKAoig41CblaGdZvQWnJThAYrtNea6rYTWfuOSZqZC9w2Ywai3hoIfFUqUS0k4DS6gQ0Yz+ELkvjKvpgRHhQyl1pJGmkyk9eEBdG9l0qLnw6X0Zc1NKPKfOEbYhNY+1w4bLoG6G7JO9tcVZ1f+u2jG8bblLJP8laiRQZPcnoeYVyeRHcX6+6pcXaAVCPMdjwVHDu9nGlcxgGA2QeHJOeuGfY8+qanKjz6fU1MwRPnuybyES2HVjzvrEcg3BA+8VHdOwN37TjizxTz+1d9TtOReqcYFD+y4fxcVWbhknEnxKM9Cir3+7Do64p3WjH91jjBHSZivfzRZFBe4Mb+nkJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH5QD3XjZARI9NR7JHkHrpYtjXbw3x4j6DHe+Uk9p34=;
 b=CeyVWycabrc67TsChfBm2C44Ap6MogDqU3GITJogJdf+ztTaj27FA7SfsrZbUzZjGxa0cklhIdj7zoDDO7DoQ3mD/TznJ5E6CRO/H/XzVxzHA9oXbHV2QiXr/tUl/rLcOrsT6GyfvlFe4eoOckt5PcAll6Yvj2gmuQGPivgViI9NlvPiRsKzXSCkTFE0UQPeQY9q1IQx1C2lUP+tDsy4268QALfnOnubFnB1X980ktaPVif+HKrP94xmbJeKsdlLn2UWpkFNOAU1iyJzZzjTKCgHAsu/en0YnUWEDVAIiIsjpsZujKjIjdngXqwGV9d1qJJezmkUr5B1BClqM4VKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: [PATCH ats_vtd v1 05/24] intel_iommu: extract device IOTLB
 invalidation logic
Thread-Topic: [PATCH ats_vtd v1 05/24] intel_iommu: extract device IOTLB
 invalidation logic
Thread-Index: AQHanKV/BbmNxN7x/kOFdRktKrBWGg==
Date: Thu, 2 May 2024 15:29:17 +0000
Message-ID: <20240502152810.187492-6-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: cc74c998-6551-46c2-83dd-08dc6abca1a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MitGZ1BUTkdyaGZvcGI1NnRiVGxDalIrVC84alhnaEtaRnNSNnJLMzhiVlJH?=
 =?utf-8?B?SWFmMkxRUDM4SUdmUTNNcFZqM0lyenJKWk16TUhlb25XVm1TZUxpY0ZObjFr?=
 =?utf-8?B?dVRKaDIxd1NDVGxCMnZTUVJQZ3VxbE42YVZGbkNJakRYL2kyMTN3dGpscnNK?=
 =?utf-8?B?dWgrakI5RFhpSFdNSHdCTUxuRDdDdmlKb3FVQVdtNzFzK2JVWHBxWVBuanI4?=
 =?utf-8?B?ME5hOWF1TVNkcGQvMTRQMzQvUUR4NFFXMnVaZGpXV2t1eVlkcFVFQnBvQ01S?=
 =?utf-8?B?M1F2OUJtQ3Z1UUNpc21kMDFhVjlOUGtzRy8vTnZZdmxMSmNnNk9hQ1ZibjFY?=
 =?utf-8?B?Z3lMb1FGTkdJY1pocTRVTnFPL2FtUTBjZHdYUXNySGVyZzZObzdZV2xwdDVQ?=
 =?utf-8?B?ai9hOUVDNDVHbjBjK3YxOFBlaUFmSklCYlFTTWdrNE5NZVdjdXFRUVo2MG9F?=
 =?utf-8?B?R0pYcEs1dHhoWENBcTZtOWZHT3B4ZW1HOGRycVJGRlNxbUVrenl4Ty83T1B4?=
 =?utf-8?B?aVVIRUFZMXluenlsbGdlb3E3Mlg0cUk3ay9IQ00zT1BSbmRBV3VYaDJHSWFJ?=
 =?utf-8?B?VXlwb3djNk52SXR6a1JWdk15aUZMVEwyZzdqMHJPcTBsT0h6bU5lR1V4Lyt6?=
 =?utf-8?B?OTNDeDlld3NCTjF2Z3l6djJIWU04d1pMeUs1VHdZNEpqMXU3SmNTT1ZGOUp5?=
 =?utf-8?B?K0t1Ui9yVTgrZlRIdmNvbDV3RjZFYzJPN002MGRzSnNNYmdxbVNxZVpFN1h2?=
 =?utf-8?B?QTlPbDVuYTAya3lyK2JxcTNhUHlndnAwVEtPazdLN05kaVVQUGp2dVhrOTd4?=
 =?utf-8?B?V0VMUWVSWWRvTStiS2NlY2VpTktUd3BTTHJDZEQxN1FNVzZxVXRDT2Rnallm?=
 =?utf-8?B?cVJTS0x4WmFvN0RmMkc3alQxYW1oZlZnaGNEcjhxTXNiTXlIRm1yODJmS0Jr?=
 =?utf-8?B?cllvOGJSMlVyazg3ZmUzNUxBdjBnOHJVVmFaSkQ4bzVaZ2h5ZDdFQ0pkWGZL?=
 =?utf-8?B?SUI3TFBlWDhteEc5RzNocXMxK3YvRFNwSXNBeGVISDY5UHZCdEtKdysvajVo?=
 =?utf-8?B?aTdDd3poVDZ5VjdTM0huNkJnUGZlNW9HdG9xcEpPZ2RualdFc0tBOHhSNUhB?=
 =?utf-8?B?YVhlT2tncS9BYWxEa1AySGpybFBtZkZkMjBHeGJDNlVRU2NuUys1cFpTSUdH?=
 =?utf-8?B?eC91b0pzTHdWWktpZEJvUWxLR0VOMmlIdWJodGxrUTdvSDkrd2hiSUMvNXRB?=
 =?utf-8?B?TlhEdzE3OE54eFpVcGxZSzVWbDB1OUtJUm1KSi9hRjRjUU9raG1zK3RHNmU4?=
 =?utf-8?B?SEJncWEyYW1MZVZwMlZFMy8xSWVEOWJlajU0cTlaK00zWng5eUFaeWIrZDRG?=
 =?utf-8?B?UWF6NWtyNTYvcGRJK2hYMmFVS0RNbDVFaGhZWXJyV1BqWktmWmhGQWxLMGRw?=
 =?utf-8?B?Q1EvbENhdHBhS1pRN3E2eDBiSU1DNlJFa1pjMmFKaFlza1ZDKyt1UnpJZkd4?=
 =?utf-8?B?eXhaaDd6eEkwM0IzKy9QUnlEUllrYndyZkpsSnppaklNY29HbVpGU095TWh1?=
 =?utf-8?B?WTRBRC9CVHh5aDYySlpZSS9LMkhLaVFHaWZCR204OXVrd2hhZnp0Zkpiek9U?=
 =?utf-8?B?K3Z5SGtJVXE5SDFma3VmeGZFWWJMR1VjMUs1WCtPSTh4YnpoNXZzVVpKVFV5?=
 =?utf-8?B?UDBRWVBKb3JFdDF1YW1nbWgxQzJIQXRTMTIwbWxGZkpOOG1ZVVR5OGRNb1Ja?=
 =?utf-8?B?NjVTQ1R1aWNoblNLVjNBeWt0Yk9uU0tRT256anQrU0kyRXRmRDNWeU1jU2lY?=
 =?utf-8?B?RFJmajFVcG1xWHovYkY3UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3B1YjgrNXdyQlFBZjRTT25VUEdwcWEwMmJOcjQzNW9RSVJmZnl0QUVxMkky?=
 =?utf-8?B?aUV1SWhVMGJQRGRPc1NaSG5XVkM0d3lOaUkzL1p6TlpJYVZPRmNNOFVJazMx?=
 =?utf-8?B?T2RhV0hLTXBMMXY0YXF0Y3UyZWxqKzdQaitjT2h3dnBxTGdFa0pxS0hBaXhJ?=
 =?utf-8?B?ZVRDWXZxOWFhSWZxRnhydUlaTnllaTNmZmdtMGcrL0luNTQrM1lSdVF3dytB?=
 =?utf-8?B?MVZHUjRkVFNYRURoTVZaYmhuN1JlaUhYTFhQdjFMNnRGWUo5eFdaUlVYdGJY?=
 =?utf-8?B?V1haaFE2dzRONnVzR1cvaUVyMlpSQmpYZ2RQdUNDRGxXUzJvSUc4aGllT2lB?=
 =?utf-8?B?dEVOTkEyYnNhclNONVh3QWgwWktwYmVqQmlCMXVxMmNKWTlKL094a09aWkl1?=
 =?utf-8?B?T3FuVXFqeVJwM1JHTTRUc01JcktsZDg1QW5rY21aSVVxbGI0cld4Z2VNK3Vl?=
 =?utf-8?B?UVE1cEE1NkhnUFYrRGpwUkE5b01EcDZ5NG41STloeDZBVjIrOTVQQ0lXeHRT?=
 =?utf-8?B?SnVuWUo3SWp3V0VmN20yYm1JSSsxS1M5L01ZVWg0eUxJd2pLK2htOCswSWhF?=
 =?utf-8?B?b1dqYUk2SG9oVGJRdjdTcVhSTitVZzc4SnAwYWEwNk05YURuek0vZTE0QURt?=
 =?utf-8?B?clEyVysvYjNQZ2xnUlc2Y2FoRGFmL3A2R2trQ0NkQmFqTUFaRnhFWUZjTmFs?=
 =?utf-8?B?NmhZSVFFT3BidXpjeFJvYWM5c2tFR0V5U0crVGVCZ1Fkay9MZXl3UWFXRSt0?=
 =?utf-8?B?eTBIbjZjT1lYYi96TzhPa3RmZHdFc0N2ZElIaVZFWWY2L0xZRTRhak1qb1ox?=
 =?utf-8?B?M0tKTTg1eUJadEd5YmV5Q3AvMCtlak02WitMR3E4NzNtZlFoM3FtdlZtMzRp?=
 =?utf-8?B?Nk53K3AzRHhBUXpvZGFaMjNRK3hMWU1abUVsWkRaSk9WeHR0cmZqTlV0dTNm?=
 =?utf-8?B?bWJ3SVMzclNuK3BGcTBVSkhidXJQcHNhUXlZUytYZkJsM2hOZTExN3RUMmJ5?=
 =?utf-8?B?d1grYUZmQ0xPcks0QTdtSFU3c0hGUHhHQTVDcllzZTk4a3JlWDI0N3cyUDcy?=
 =?utf-8?B?WmVmb0ZJZStxSTlCUWFsWCtUbVBlNEVreDZtZE1BUkp6ZzVPYjVyTm1odVd4?=
 =?utf-8?B?Y3lMbkJkbVVEMXJOQUZyUkVwQ3FVWnZ4STdvaHdEeUR1MmhhMmIwclpYRkdT?=
 =?utf-8?B?ekNMeTc5LzNQeitHVVVReXQwN0xGcU1NYWt2VWxTeVZ6SjFKTXd0bzFBMG5U?=
 =?utf-8?B?Z1FvSXRKcnBrZDJxdnNPRFB6eFA4blppb0I1bnZjQnZ3M3VLY2JjeUdxZlFi?=
 =?utf-8?B?Y1dMTm1TMkROcUN6Unh1QU5QVS9nS25qbGtlVnhCWjVVYThSSDUvcVJkTkpl?=
 =?utf-8?B?QjB1OXNUNU01WndhTU9IbEtZUGswazBmZHgwektENitrQ1hQOTVPS1FnS3ZN?=
 =?utf-8?B?bDM3eGk4cnJiY3JTOHlFdU5FT3FVT1l6QzZvTVZFek5wNGpwK2Zia3VGcENP?=
 =?utf-8?B?STYzbklrOXZBd2daNG5GOXNzeVZaTHFLbjMwNi9iS3ZCUHF4WVoxZ2ROeHhI?=
 =?utf-8?B?cnFDTi9ncTE3c1BMMFBsUE8wcndGTlZGSEpIUGV6VzFqam9iSE1ZVk9sdHp1?=
 =?utf-8?B?ZWVzRk44Zm9PbFQza1RLdHJ1M1MyL0F3bnhiT2diOTdkeHJSK0lqejZOMWZT?=
 =?utf-8?B?MW50WXVaRGJEdFNTZjJkMjdlaFo4RjRVNUJvMTBOdkNzdUx0YVZMdnJtb3NC?=
 =?utf-8?B?akY1eXUxSDZqaWhkQVEwWjd2WnpMTGxFY09WRC9TVDZiNythYWNaSndyNElq?=
 =?utf-8?B?MnlmREF3OWtZalVuUHFpTnpIdG00V1R1TFJjU2FOa0lwdFNHdDJWenNVVm0w?=
 =?utf-8?B?SDNobStCRDZ5WGdUY21sZ01teTdrZktVWWRKbjNFemhLSjhVM1hZQWdYRHJC?=
 =?utf-8?B?VTBaOG9mRHBMYk9qVG9qSDNZeVpXWGNycDV3QjhZVnRvM0FUdE1JS2hNWkR5?=
 =?utf-8?B?VkR2MVJHdkR1dE5zZHRDQi8xVHlLVXNoVjJhaTdCTkxOM3l6Y0puYW11RDlh?=
 =?utf-8?B?cmx6b0tFczBkcmJyWURMM1lBdVNNUEZhbnhLRldFdVhWR2tZbjFDRGJyeElx?=
 =?utf-8?B?b2JURjE1TVM1TnJvdzRZVjVvR1VQbzlnRWp0dWJydEw1YUtOSHpMZEdqU3Vq?=
 =?utf-8?Q?E61oMiu1VcFNBSgF1pru9MY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EE70DEDE65071488448D2A2E2150190@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc74c998-6551-46c2-83dd-08dc6abca1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:17.8023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNm2E0Yw/7BCmVM0/dJCqEN1fNbwR8vh6/Ysws4ba10XueKBgFDeZKBrpawj5yo9esvcu9zhD6re6Aql3xHnXMNpMZLBtGIhSJVPrFjvJXeCdqVxChk5POsDK9gjczMs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
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

VGhpcyBwaWVjZSBvZiBjb2RlIGNhbiBiZSBzaGFyZWQgYnkgYm90aCBJT1RMQiBpbnZhbGlkYXRp
b24gYW5kDQpQQVNJRC1iYXNlZCBJT1RMQiBpbnZhbGlkYXRpb24NCg0KUmV2aWV3ZWQtYnk6IFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NClNpZ25lZC1vZmYtYnk6
IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29t
Pg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNTcgKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCsp
LCAyNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBi
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggY2FkNzBlMGQwNS4uODVhN2ViYWM2NyAxMDA2
NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQpAQCAtNDI5NSw2ICs0Mjk1LDM4IEBAIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX2ludl9p
ZWNfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQogICAgIHJldHVybiB0cnVlOw0KIH0NCiANCitz
dGF0aWMgdm9pZCBkb19pbnZhbGlkYXRlX2RldmljZV90bGIoVlREQWRkcmVzc1NwYWNlICp2dGRf
ZGV2X2FzLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHNpemUs
IGh3YWRkciBhZGRyKQ0KK3sNCisgICAgLyoNCisgICAgICogQWNjb3JkaW5nIHRvIEFUUyBzcGVj
IHRhYmxlIDIuNDoNCisgICAgICogUyA9IDAsIGJpdHMgMTU6MTIgPSB4eHh4ICAgICByYW5nZSBz
aXplOiA0Sw0KKyAgICAgKiBTID0gMSwgYml0cyAxNToxMiA9IHh4eDAgICAgIHJhbmdlIHNpemU6
IDhLDQorICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0geHgwMSAgICAgcmFuZ2Ugc2l6ZTogMTZL
DQorICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0geDAxMSAgICAgcmFuZ2Ugc2l6ZTogMzJLDQor
ICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0gMDExMSAgICAgcmFuZ2Ugc2l6ZTogNjRLDQorICAg
ICAqIC4uLg0KKyAgICAgKi8NCisNCisgICAgSU9NTVVUTEJFdmVudCBldmVudDsNCisgICAgdWlu
dDY0X3Qgc3o7DQorDQorICAgIGlmIChzaXplKSB7DQorICAgICAgICBzeiA9IChWVERfUEFHRV9T
SVpFICogMikgPDwgY3RvNjQoYWRkciA+PiBWVERfUEFHRV9TSElGVCk7DQorICAgICAgICBhZGRy
ICY9IH4oc3ogLSAxKTsNCisgICAgfSBlbHNlIHsNCisgICAgICAgIHN6ID0gVlREX1BBR0VfU0la
RTsNCisgICAgfQ0KKw0KKyAgICBldmVudC50eXBlID0gSU9NTVVfTk9USUZJRVJfREVWSU9UTEJf
VU5NQVA7DQorICAgIGV2ZW50LmVudHJ5LnRhcmdldF9hcyA9ICZ2dGRfZGV2X2FzLT5hczsNCisg
ICAgZXZlbnQuZW50cnkuYWRkcl9tYXNrID0gc3ogLSAxOw0KKyAgICBldmVudC5lbnRyeS5pb3Zh
ID0gYWRkcjsNCisgICAgZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQorICAgIGV2ZW50
LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IDA7DQorICAgIG1lbW9yeV9yZWdpb25fbm90aWZ5X2lv
bW11KCZ2dGRfZGV2X2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KK30NCisNCiBzdGF0aWMgYm9vbCB2
dGRfcHJvY2Vzc19kZXZpY2VfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERJbnZEZXNjICppbnZfZGVz
YykNCiB7DQpAQCAtNDMxMCw5ICs0MzQyLDcgQEAgc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfZGV2
aWNlX2lvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFZUREludkRlc2MgKmludl9kZXNjKQ0KIHsNCiAgICAgVlRE
QWRkcmVzc1NwYWNlICp2dGRfZGV2X2FzOw0KLSAgICBJT01NVVRMQkV2ZW50IGV2ZW50Ow0KICAg
ICBod2FkZHIgYWRkcjsNCi0gICAgdWludDY0X3Qgc3o7DQogICAgIHVpbnQxNl90IHNpZDsNCiAg
ICAgYm9vbCBzaXplOw0KIA0KQEAgLTQzMzcsMjggKzQzNjcsNyBAQCBzdGF0aWMgYm9vbCB2dGRf
cHJvY2Vzc19kZXZpY2VfaW90bGJfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQogICAgICAgICBn
b3RvIGRvbmU7DQogICAgIH0NCiANCi0gICAgLyogQWNjb3JkaW5nIHRvIEFUUyBzcGVjIHRhYmxl
IDIuNDoNCi0gICAgICogUyA9IDAsIGJpdHMgMTU6MTIgPSB4eHh4ICAgICByYW5nZSBzaXplOiA0
Sw0KLSAgICAgKiBTID0gMSwgYml0cyAxNToxMiA9IHh4eDAgICAgIHJhbmdlIHNpemU6IDhLDQot
ICAgICAqIFMgPSAxLCBiaXRzIDE1OjEyID0geHgwMSAgICAgcmFuZ2Ugc2l6ZTogMTZLDQotICAg
ICAqIFMgPSAxLCBiaXRzIDE1OjEyID0geDAxMSAgICAgcmFuZ2Ugc2l6ZTogMzJLDQotICAgICAq
IFMgPSAxLCBiaXRzIDE1OjEyID0gMDExMSAgICAgcmFuZ2Ugc2l6ZTogNjRLDQotICAgICAqIC4u
Lg0KLSAgICAgKi8NCi0gICAgaWYgKHNpemUpIHsNCi0gICAgICAgIHN6ID0gKFZURF9QQUdFX1NJ
WkUgKiAyKSA8PCBjdG82NChhZGRyID4+IFZURF9QQUdFX1NISUZUKTsNCi0gICAgICAgIGFkZHIg
Jj0gfihzeiAtIDEpOw0KLSAgICB9IGVsc2Ugew0KLSAgICAgICAgc3ogPSBWVERfUEFHRV9TSVpF
Ow0KLSAgICB9DQotDQotICAgIGV2ZW50LnR5cGUgPSBJT01NVV9OT1RJRklFUl9ERVZJT1RMQl9V
Tk1BUDsNCi0gICAgZXZlbnQuZW50cnkudGFyZ2V0X2FzID0gJnZ0ZF9kZXZfYXMtPmFzOw0KLSAg
ICBldmVudC5lbnRyeS5hZGRyX21hc2sgPSBzeiAtIDE7DQotICAgIGV2ZW50LmVudHJ5LmlvdmEg
PSBhZGRyOw0KLSAgICBldmVudC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCi0gICAgZXZlbnQu
ZW50cnkudHJhbnNsYXRlZF9hZGRyID0gMDsNCi0gICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9t
bXUoJnZ0ZF9kZXZfYXMtPmlvbW11LCAwLCBldmVudCk7DQorICAgIGRvX2ludmFsaWRhdGVfZGV2
aWNlX3RsYih2dGRfZGV2X2FzLCBzaXplLCBhZGRyKTsNCiANCiBkb25lOg0KICAgICByZXR1cm4g
dHJ1ZTsNCi0tIA0KMi40NC4wDQo=


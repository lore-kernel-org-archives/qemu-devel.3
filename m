Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4225C25B5C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNJ-0003fw-AZ; Thu, 02 May 2024 11:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNH-0003dy-8Z
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:31 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNE-0005zh-GF
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663768; x=1746199768;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=3fG8vUdx571SSHY7CyRXK67viHVvSthpg//jIoJ+WGo=;
 b=cP93zFOhdzxlON0jM4waCuWF15ITU9mv1Zhw25D7GOhyIgEXC7IpZxIL
 yAYdF1LRaA++Z1CEfiDTK7t1LCVZ0mV7p4DmjBDOE/+6ilCYELLXanJ2r
 680STcDwuL0bz3TeAKMLg71x5LbppAzTKCf35/aVHlnOwErmJF+Ards1Z
 BLDq478ze4Od8jsyO2VtAT+osfRmNbcM/rGQpi2haU7n9ZFjPyiQ3cVPq
 OsQkdr1lsH0pJoyVpj1zxtp1LqdEKNESAAOoDLAkTPqizBaiNr+jAmZYx
 y5psEQglF5fd9KKsTrN/5akiVspha/QIoB4Amgu7RtNKm/uUohD3M73iV g==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11730668"
X-MGA-submission: =?us-ascii?q?MDGDJ/kIyvLiZqS/QC9Pr4FSPUFUO9lU20yQWO?=
 =?us-ascii?q?Hbc6fAqMY225E57m0n8jJ9VINrvIEnCxhj/LhFCdpwqMcmhcnIMeGWlI?=
 =?us-ascii?q?/QOpUmMh2yNCtFcsaLVyl/Jf2R8YQzWEGWeFzkAl4luoJcvOPguDxQCW?=
 =?us-ascii?q?xfQo68fTkWvobUDHkgzsbgjQ=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUVj7YfnNfTBzC5lRjMYGYHE592nOnnoyNZKLWN1gWmD17lRHPj5b6+lbUNh/3BTVz2VrlXXnOkcvttd6vLHjPbtugjxXKnh1HEnhRAjp4XQcnLk7uEzOyjTXxa83BwfwEQcCCUKDP3MgWFnSc7xFDz6vA1rzcqXHWEow1t5qVZyehkMb3mqW8miyr66wlKQIdVxp2jnCH1F56Ii3nTd1ufS6uVDTKuLve5gJGsYmfYXXikicjM9IMMG9Z1nE5NyVr5Zky+tBaP2Xc2enRFVRlBsBhHxl4dpl5LQrJ5bVAvrHeko0yOl8TUP3AldwpUSNvgM67SSvkvE8fVPGCOLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fG8vUdx571SSHY7CyRXK67viHVvSthpg//jIoJ+WGo=;
 b=Ir3nlOrEeJIB4Ywou01ieq02Eal1B340ikLVIq5dDEjeQMjespjS+GRyWeafchpY8D5Fp6l5krUYsOpt0+FwepO2rqSUb3ID4C6bxYT1zTGkGI3GN+M/Kt6zXcTXTuyugwjyzBZU4eMqIWddlRAnUlwdGebrrlS47ng86jceVkOK8uibMY6duOcoccrWbhTSHbbbm8bcYN3m0k45PCa33DKfArTDxyCppV/WEFj3TgCRMVILt2hGrWp0s8CdOwT2g8MJBCiUT0NDRaCk8K/a654WBgFZWgysdnRYhtLdg8LgQXY0VfNCr13pJjUoEbj4OgbgtLmdnVjbMg458aplHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7768.eurprd07.prod.outlook.com (2603:10a6:20b:351::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:20 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:20 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 17/24] intel_iommu: implement the
 get_memory_region_pasid iommu operation
Thread-Topic: [PATCH ats_vtd v1 17/24] intel_iommu: implement the
 get_memory_region_pasid iommu operation
Thread-Index: AQHanKWAb5rqVJmyfkWBpMIvcWYxIw==
Date: Thu, 2 May 2024 15:29:20 +0000
Message-ID: <20240502152810.187492-18-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7768:EE_
x-ms-office365-filtering-correlation-id: 48620919-e592-4271-ad83-08dc6abca353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?djljY0M2NHQvU2FyL2JzWGJBREV2ZmpZR29Vc0F2ZjMycXRnZXFJdjRDNnBQ?=
 =?utf-8?B?NzlPaEorZHR5TWxoSkhGWWt2dHc4WHhXVTFaRnNneWNiREw0R1g4MjdFa0pl?=
 =?utf-8?B?MlNiaG5wbzNnK2pJQkNsWFRiV3J3eFVTY1BXV2tpT2o0S2gyV3E4QnJXa3cw?=
 =?utf-8?B?dXdzU1p0VDYwdkQ2QnZVRG8wZkh2K1dtL09qZUZCSFhiNHJsMXBRNzVoRjcy?=
 =?utf-8?B?Nnh4eXR4MmZjcmtLWUJ0T1FFUkNSSVBzM2h2c1VRUjdSTktVZkg1UWxMZW1o?=
 =?utf-8?B?MlgxM21qTDkydnV1dS9Zc1Jpa244TStrMENweVMvU3pTOEx5Wkp4ejJBa3dm?=
 =?utf-8?B?VzJoc2wvWnU3MWpTemZoR1FzS00xZUNQR1p3Q0tWd2dHaUIreUd2Y2kzZm8v?=
 =?utf-8?B?d2xBNFlkemdhMm5taGUyNEs4amV5R1RtSE9GTmtiVkJ4Z21hZGwzS0xFdmoy?=
 =?utf-8?B?dnBMN294cHBHY2VZUmRWYjQ1d1FQR1Iyb2VPMyt2STlJRTdiZ2c4NVNlUVdR?=
 =?utf-8?B?Y284V2pQeW1aTjE4bTJsNXg1MGlvdTFCZkhlcVMydkxubDBRbCs5NEtUNVMw?=
 =?utf-8?B?Y1VNMUFqdE1hOXVBUzhQWEIwdkhwb29QMDlUYVZHdTBpUWdVTFF2Nnc1VEx6?=
 =?utf-8?B?QzNNWVpOSjltUDM0eGlQZXFkalNmWTh1Wk1TQnQvWWlaL2FoMjRsS0tHMkdo?=
 =?utf-8?B?eXNHVzBPRGgvK005dFRMNmVtRXN6RFVhejJ4bFRDVHhIQzVZbGJmdDNnSEVL?=
 =?utf-8?B?NG1WOE53WjZNWEw5anNCemU0QXNSbjNhODlaYXUvL0xEK1JpSHFPckhVYU4z?=
 =?utf-8?B?c0FuTGlmREJzc1AvNW5ocjBkcWFZdzUyRW15RGZleUtYNWRESDFqYkxzbG1X?=
 =?utf-8?B?QzhkTE1YeVF5dTFWSDErNk9xZHBYZVV3ZXJ3c3hZVzNlOWRKOFFiZnhkdXhH?=
 =?utf-8?B?aGdHUDdmM09kNmkwSnZ3cHIxaURHWHA2L0tsamRZVStudWo2UUV6UjdndXBx?=
 =?utf-8?B?ME9DUnIvYzB5ODF5N1hjcWY0dSs0QTIrOGIwN0hYVlpCK3hLSGozU24yYmxM?=
 =?utf-8?B?MHg2eHFCaUhxcW1ha3lUa1VzdzVCdU1NMDZoU2QxOVFmaXpDbzEycEtpbS9u?=
 =?utf-8?B?c1JmZVloRkRJMWFRSE5zNmxQbThJdEM2UjRrWXBjYmJXazZKTmZuWGh0UFVX?=
 =?utf-8?B?d2lXbW51UVR3b2lXaWtPMzF2My9WbGFUVXcrV0N6cFZiYis1VGhxa20vM09w?=
 =?utf-8?B?V3N4d0FhZ0NKOEJ4NW1WaHJwSC80Z2xFSXpHL0UyaGlnd0piU3dvREZDOGJ2?=
 =?utf-8?B?MjMxK0NlaWxPczVOdlRPYjJhV2RwbTNVSTBUUzNHZGVNRDh0WW5qckRHTVNn?=
 =?utf-8?B?Z3l4dysyWTJhRW90bWdkdWFBdmZQNTRDS0NlUExHUzdWOVVkVTcrZHM4MWIv?=
 =?utf-8?B?YkI3V3BPV25MR1cwOUh0N1hDZVFlYXA1Z2xrL2dtYVNUUlo2V1FhaHFtdzhU?=
 =?utf-8?B?eXVHNWUxUTlwQStJV2JrYjMzMjRQVk1LblVYZzBvMERhNjlCdHgrYmJnWHJU?=
 =?utf-8?B?L21IQ3dpZTZvOTJIbFcrbFBGdUEyNDgyL2NJOUVTVWZrWW1jd3B3dU5qcFVP?=
 =?utf-8?B?VzBDejcvbnRDWVIvMlZ1QmdTdHNxYnBZNW9nY0JhNXFJNmI3N0ZsUzFsTnl6?=
 =?utf-8?B?d2VQOWRtanEzRklFcFdNa0hLcHJ2aS9tQmNpNnQyYzE0bWZaS1c2ei91cVM2?=
 =?utf-8?B?NnRsYzZuZXVVa05nSkM1ak1qbEhwZ3JNWStBTjVQUGdCZnFaVUwxL2JtNThj?=
 =?utf-8?B?cG12eEUyeURoN3pyY1RqZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blc4djhFSG81SU1pVGUrM0lnbkU4Ukl1bENCOXVkM3JiNnVWbUF4cmhSNUFh?=
 =?utf-8?B?UVhYWmI5L1c0VTh5dHh3UWJQT0pNdzlPNFdKYTNYeEZ5bWcrb040MnVpaWhy?=
 =?utf-8?B?SlAxeTdqSmd0d20rTWpTbzBNR041N1pxaVVZbURCbFVLSUphNnR4OHlzVjRX?=
 =?utf-8?B?d25CbDJVNGRCSUdxZmN2TnNpMzg4S2szekk0aUtacGNaTjBqTytPQVhtcmhK?=
 =?utf-8?B?ejdhTmovN2FZSEwzS0dnc0YveWtaVSs0QXhHaktTSUtOck1UN2xra1lpZXdr?=
 =?utf-8?B?ZmxhYnNId2xlOElvWmE3Tnd2ZXV2TlhBdWV1NGZkd3J4dkRRTC9uVDM0NGhy?=
 =?utf-8?B?MUNaRjk4c1o0K0Q5ZTBlSGtxVHdLMFllV2hUMlJTWTlsTHFvclg4SmFlMFJO?=
 =?utf-8?B?V2ErOVpkSFVLM3FpYzFLK0xkQThMS2luSmwrTmlpV1oyM2hubG9vZlhhWFJ6?=
 =?utf-8?B?ajg2dHpKaTFGWEllOENUS0pRMVQzZno0K0RsRWt6WXBDTkxGK0RTMmFkeVc5?=
 =?utf-8?B?eXRjWE5VSkN1NjVHUXFZVVpqaEFDSEVHb3B6aDBCRkdjUXJyZ3ZndzlhZjZM?=
 =?utf-8?B?UjJVSlo4bWhJcGh4OGQzcXF6UEVJLzFubHRJZ1lwMWo0a1QyV0h3eFY1ay9N?=
 =?utf-8?B?WnlOTERoOVVGZ0cyNlZoNzFmUGkySVhkdy90M3NXQVBoZXpDSzdjd1BKcksy?=
 =?utf-8?B?WTZMS0hqZHpNZDluVERhT3ZFVlE5ZFA4SVJrb1FuLzdJN0R5dEMyNml0bTVE?=
 =?utf-8?B?NVZ2WXBjQk1CUUxoLy8waDc2ckozcVdOUitkSkZ1bmZMWHkzZUZueGZDdDZ6?=
 =?utf-8?B?RWJZZ2U5ZnNlTVkvNWNRMUJkZFFWNjFsTFJJQXVrY2Z3Ry91WHBPR1B3aXYz?=
 =?utf-8?B?QTMvQnN4d2hEWW54ejFndFJlZlhFbzI3Tm5yQ0xoZDQxZ0d4NVVpVWVVcHQ2?=
 =?utf-8?B?UmdUTVhMcjZUUFZWa0w5S2xBYUxmQlJDR1JEM1hjZzZUTmJST2FNNzVBaEFx?=
 =?utf-8?B?bDk1ZUE3aWRJYUs5WnpTUm14WVZyTFpIZXhtVk5NNjRjUVN6T2hjRDYwNWpv?=
 =?utf-8?B?S2ppL0FvMzlhbXZhYndRcmJrWFJaSTJpQWxOcEJaZnRFNEhZTXJZM1RWN3hQ?=
 =?utf-8?B?N2tnUGVXOW1laXVHdE1LU0E3UFZadFd6cnhQaVVoM2NrakVMOTJ2MTJQbXFB?=
 =?utf-8?B?TFQzZnpkdXQ1TVRUTzlwTnZYL0VkTnBVUWZQZnR2OXBERHFjN3FYcm1IT1pK?=
 =?utf-8?B?NzRWLzZmZFJwTjdpdnZHSWdJckFTOXFsWmRQb2lKMFFXWFFpbmdtZnJBb0VE?=
 =?utf-8?B?UXdUc0VyVnlxcGN1ZmdtT0pQOUxwMUg2SUJMdDZSUC83TC9sVm5kZmQzeGdD?=
 =?utf-8?B?dmIyZ1ZWUk43RFhDalZRYnNDM091Z1hJRWRwOENNbVF0dnlDZVNZZk42ZEt4?=
 =?utf-8?B?TUhEWk5VTitUWGtoV0JaZmhva0dpaFJwVk1kQXBlTDhMUkVHajB3eTFBM0VB?=
 =?utf-8?B?K1hBa0NZcUtsZnVhQWViMlFLV2ltT3E1SFhKSUlJYjJvNVhYcHhNTUlLZXZo?=
 =?utf-8?B?aW8yMmZsZHFQMHNQaVVQcjViZWZsRGNnM3A1QkczSEVwb1ZCd1Z5ZkhmWVdE?=
 =?utf-8?B?czhPSVpuQXNSQzFwZm01R2ZFQ2daRnpxdnRYZzF2b3JMVXNybTVKSlJHSTJP?=
 =?utf-8?B?Z3dOcFowZlJNNWlYQnJFSWtBcmJiS3ZobGxvejZ1bnNET2U3TUs5YWNydS83?=
 =?utf-8?B?ZjUvRThPKzExWFdPcmF3RGs0U0RoVWhUSXhvekhHeStZZ0dHN3BLY2VBaWNZ?=
 =?utf-8?B?WlJFM2RkckRyWnI2eFJzeE1XSHVzVlUrVVV4bmxqNmVCdWppYlFYMFhoSVB5?=
 =?utf-8?B?OFRJUk9UNkUzMWRFUS9QcFhuN0p6UDdQMDlpWWl3dmg5UXNMRE1oN2lxd2RF?=
 =?utf-8?B?Z1AwODdJNVhVRDhTanZjN2hDdGVlT1RRT0RFZTQrOXhVaTlUMms5NnQ1cUor?=
 =?utf-8?B?ZUl1b29oNVp0cjFUM0d2QVprRjR5OEdFeEs3WEYrRmtPTHYwS3dkT1NjZGM0?=
 =?utf-8?B?WGlYcUFZU0h1SmJsVnBPSVRTWmJDTWtEQ0ZVMUg1YUpsWXJJMjIrNU9FcWww?=
 =?utf-8?B?b1hXNUlJNGM5M0xLajlucnJmQzRHbVQydWE0cEVyWmtzU0pCTEx0U3ZIQVp6?=
 =?utf-8?Q?Ip/HR2AkA6vLKgUbuHbzcQU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16231E084BCB4745B636E4BC4B098ECF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48620919-e592-4271-ad83-08dc6abca353
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:20.6083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBgjQdvRoQS9KQId5npK1U0gH5BMD5Yq/9THqOBxqWpXspDCB/VoAvo5We+HC4xzanpZot1XiGRK+YOsMXcm5AUuUi8qVFheN+XTNSlEfl2mjEawqUHnOE1ms53CXyFF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7768
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCAxNSArKysrKysr
KysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCBl
OWZhNDhiMzc4Li5hNjJjYmYzMDNkIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC02MDAwLDkgKzYwMDAsMjQgQEAgc3Rh
dGljIEFkZHJlc3NTcGFjZSAqdnRkX2hvc3RfZG1hX2lvbW11KFBDSUJ1cyAqYnVzLCB2b2lkICpv
cGFxdWUsIGludCBkZXZmbikNCiAgICAgcmV0dXJuIHZ0ZF9ob3N0X2RtYV9pb21tdV9wYXNpZChi
dXMsIG9wYXF1ZSwgZGV2Zm4sIFBDSV9OT19QQVNJRCk7DQogfQ0KIA0KK3N0YXRpYyBJT01NVU1l
bW9yeVJlZ2lvbiAqdnRkX2dldF9tZW1vcnlfcmVnaW9uX3Bhc2lkKFBDSUJ1cyAqYnVzLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQg
Km9wYXF1ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQgZGV2Zm4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQorew0KKyAgICBJbnRlbElPTU1VU3Rh
dGUgKnMgPSBvcGFxdWU7DQorICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KKw0KKyAgICBh
c3NlcnQoMCA8PSBkZXZmbiAmJiBkZXZmbiA8IFBDSV9ERVZGTl9NQVgpOw0KKw0KKyAgICB2dGRf
YXMgPSB2dGRfZmluZF9hZGRfYXMocywgYnVzLCBkZXZmbiwgcGFzaWQpOw0KKyAgICByZXR1cm4g
JnZ0ZF9hcy0+aW9tbXU7DQorfQ0KKw0KIHN0YXRpYyBQQ0lJT01NVU9wcyB2dGRfaW9tbXVfb3Bz
ID0gew0KICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2UgPSB2dGRfaG9zdF9kbWFfaW9tbXUsDQogICAg
IC5nZXRfYWRkcmVzc19zcGFjZV9wYXNpZCA9IHZ0ZF9ob3N0X2RtYV9pb21tdV9wYXNpZCwNCisg
ICAgLmdldF9tZW1vcnlfcmVnaW9uX3Bhc2lkID0gdnRkX2dldF9tZW1vcnlfcmVnaW9uX3Bhc2lk
LA0KICAgICAuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZSwNCiAg
ICAgLnVuc2V0X2lvbW11X2RldmljZSA9IHZ0ZF9kZXZfdW5zZXRfaW9tbXVfZGV2aWNlLA0KIH07
DQotLSANCjIuNDQuMA0K


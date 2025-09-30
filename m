Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00775CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VLe-0008Bw-7Y; Tue, 30 Sep 2025 04:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3VLD-0007qR-Nk; Tue, 30 Sep 2025 04:04:09 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3VL3-0002Mv-QN; Tue, 30 Sep 2025 04:04:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8SENFFV66YmCq8nvCY/0dJ78BD+Ofdx4FAXGTSZQQwRJI8xTFndxLV4AM3GHcnU5txO1rEIpjh1biTZ95fyyZXuT2Pl87du6GHIu+iHx9NIylgBBMi2p4OGnAC9r2U52E/oP8x165nswNZtXTMfrjIbNHZfr0v2xwu3MfLRwCDK2K40CZr6VFkIIkPaJY5RL+bXVE9Cz6rfwguJcpC/B95bzha7T0I4ac99dAYwJa5/R3zR1Sg8ZnTRdPjGz6lW8o0Zq1ZcCUY1usPSAsupiSv+ujiUlze3KORtQAi9i5PjZeqM9WrGLfKF/U31vhy3wSA5UOKn8MFeiY7gXFFKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjbyMUWFgHU4w61v41i+AsNeHmCGdjpD6zpz+8x+05c=;
 b=vZ+fNetQyCZkT7Lnt6XBKYVjh6dmYGjF1MY0IDyFw2QWgFPcvhmeN3x7Ttqm3/xVsYGcJM75vAiKhCeY2+UJgsJOIL09Gg8x7WjaWJ1b+CNmS4wgDz03/UIbCTHTbe8OsAxcMRZBcf7q2Rh3nEcFbfakWAoWjWvUQCpgcAkl+iiI5WRvvpRn9bsRUr0LJqvhzquc+A2U9tUQhVPSi8XnhyPsnLHRGG+ZIGw0uRd8EuNnWBLG6sJG2THu/TZwI/WdW0WIudDEyYXLxrvhv3AlE0uZ1o9hUuIQfkhaeuvu0QmXJvymftBRw/FTwAFa/2wHraFtWOUmPf0rMj3AH8J8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjbyMUWFgHU4w61v41i+AsNeHmCGdjpD6zpz+8x+05c=;
 b=EQjYj1cAWgXh/DxU9ivNh19l0aAcfYP11GQZ3V4vX/w7nxSMkCjFmvXYIv0tuK3rhwahqZMkaH1lV5UmyviaAcDbpX2N4F39qdO92mY9BiPAaGYmPag7fXdIcaKDub/DLCveaZoYh0xGbfDSj3Av/nSwmrAPVLxd2AlewVDfSBphPr8ViT8iR/XY/l1UALq/jfDCxhiMfB334fVR1aLNOZMLxdB6ZFa0a5fppHb3HP2qtxtcYzjjenoMeKfha4IFTPP3lG3OJSKHrXi++Zk27V6ODnvGFSS60aUL6IC2gLP7ulPY896+KBrVQoFkp+RQZXnRhL+OB4M2rioHg9ChJw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 08:03:46 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 08:03:46 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3
 to vfio-pci endpoints with iommufd
Thread-Topic: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcMVtWHNFvMFbT2kCFLixXDfUlObSrW3YQ
Date: Tue, 30 Sep 2025 08:03:45 +0000
Message-ID: <CH3PR12MB7548CD6223A90CD41D216353AB1AA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
 <20250929170839.00002db9@huawei.com>
In-Reply-To: <20250929170839.00002db9@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN0PR12MB6032:EE_
x-ms-office365-filtering-correlation-id: 16145696-4a0d-4831-3217-08ddfff7e157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eG90ZE82d2lmZy9VSlI3QmhmdER5RnZCTG92MUJaQkZEN1dXYkxCbmhDbDNU?=
 =?utf-8?B?OVJzQ1ZXUDhhVEcwcUUwRjczTzIrRTUxNkw5MFk0djBlVFduZnpnMUVGN295?=
 =?utf-8?B?R0Yva3dIcXpoM1JFSnlFdUNVK1ZmVXZaYk1DWWsxR3VWUFZEMXhCdXhHWHh5?=
 =?utf-8?B?RjdSOTVSbitDUlNHMzJnVUl3K1dBQThwaktRaUtDUUhOSU5JZGIyYlE3Uk56?=
 =?utf-8?B?Sm9ITnArbVFXUkFBdWppU1pJOThpdVlRV1loQTM2YnhJNHM2N1FlZlpKdkRu?=
 =?utf-8?B?eUoxYUpMTGVZS0VMSkFLRFJIZ2w1TkVwVDNVaDFQWmJtazJrUTY3UnpScktK?=
 =?utf-8?B?M3ZuZ1VKNTl5Rzgrc1BBL3VCNjQ2ZmZxcnAxbjRPNnJXKzdDOFZWK015UEhj?=
 =?utf-8?B?TzdXU3NHZzE2WldiNDdJNms3S0J6ekZXVW04bXVEWDFNWWZWZENTQXNBZmtU?=
 =?utf-8?B?azV4NGtrb0l0Lzh4QmhJVEprUGI2ck42b0E4UDFKMVRpblVnb2ZNQ1Mrc0R2?=
 =?utf-8?B?SFRiT3daTmJMSjMzNzB4KzA2Q3d1TEltbzd2VHc1bXUyaUxkbGVMVzFFRWxF?=
 =?utf-8?B?Y2V6cU1UWnVzOXg2cHMrSjJpWFNEZE1QWDRBSTVvaXlxUlBaVFI4a2tNSFRM?=
 =?utf-8?B?L2oyRXR1a0lJUEVCR0NpU3NheUxGUlBYc2RNRWtnNkVkRTdwVHdOdFhKY2dv?=
 =?utf-8?B?UHhWYTJGRGZaaUpaZkRPejV0Ym9aaEV0dEN1U0NHejRNWVE0RmFWeTBka2hm?=
 =?utf-8?B?aE5pWTJMK3R5Nkh0cExUM0wwU3VDL3RQYm5YR3NBNnMzdXNySURIOE1mRzdX?=
 =?utf-8?B?MkM5UEVGTHJXUytwbWdzQnVHbFFUTkFrbVJtWmYwQVB4cmVlYlU5YzAzTmEy?=
 =?utf-8?B?SkJTOFRrWmMyK2s5MFZpSnhmQzVGdXZLOFVsZ2Q4NndGOEhuaDlDTlBWYlBL?=
 =?utf-8?B?ODFIZWd2U0ZsMzNRZWN4TTNzQnFKQWREdUcwY2dMcCtZVUE2OEZjZnRBYUhS?=
 =?utf-8?B?UmZrU3JzV0RNRnpzN0I0OUFFWXhyeFo1NS9VY2NMazNUWUUxYzliUXVFdTZ0?=
 =?utf-8?B?M3c5RThmTFBCMTA1OHdOZjBCdWlpQXNFSkt1eWRTQVY5ZGltOTcvMnY2MFlq?=
 =?utf-8?B?aEN0bDlWNTFsMGdOYktIZ2JmakdMYkxzM3dsVm5UZThOakllK0grekJ2VkRS?=
 =?utf-8?B?d2tEZ2lHeFExbkFTd0lZa3kyVUl2YnhlazdMdldWYjBUWUN1ekxSZW9FVE1o?=
 =?utf-8?B?SXV1OFV5ZXJYUmhsbmdlRUt6aTVKTkFNU09UU3lFMGQ2eDh0OXpEU2pCbGZJ?=
 =?utf-8?B?Tzk3ZlMyOHM4NUtSWW5hdElFYVlrS1NOUTVZQi9ZY1FIQTBOQ3A3a3VlbEZ0?=
 =?utf-8?B?V1JBeWdoUkVYVlJxaWZvSFg3c1ZiemQwTWNkaldCVXJ4bE9VZm1qK0Y3dmdz?=
 =?utf-8?B?M1o1Q2xvMDNIVFNEdTFPckgwOUNaWWt4ZUo5ZXpzbnpIdFBLbkY0UTgrOVhx?=
 =?utf-8?B?bXduMGRCdWJUbVpjR1JMTVVkRmpxQjMzZjNJZGE2WWgrRDFjVWxGZUZzSDY5?=
 =?utf-8?B?dlg4WExKbWhZbnZpV2pPM3dNZGZZS3ZNTU8wSVRPWVdsVjJ3U1FjYlV6aFFJ?=
 =?utf-8?B?SDQ2ZFNwL3JQZXhkeVBJMjBSMjIwMVVndEZlZGQ3YktDNzdkQXVBUWF1MHlV?=
 =?utf-8?B?S0grMldWazRxM1BRaWRYNmFxT1M1L0VZUFk1elI0UjROaURiR0tDZGUxeEVo?=
 =?utf-8?B?SXJXVTJyU3ZoVUpRUHlqMGpBd1hwQVFMdkJRalFzbUxZTGQ4dXoxYW5UR1RZ?=
 =?utf-8?B?OVprcFQwRmN0bHVRVGw1QnlSQ2oxblRMbG1Dem82ZjN3WDlXMTQ1cnc2V1lJ?=
 =?utf-8?B?WFZyeDNQMmkxeFh4RWh0d0FEVXI2VVdZd2JkeC9kczNUbCtNQ2JIVWtyeVV5?=
 =?utf-8?B?Z3BUOGZkZUN0TnFQV2hGeXVrdnVzejcySTl6L0laeXY2MEZUbzdoSGdZQldh?=
 =?utf-8?B?bWpBOEpZL0pRakFudkdoWitXQzB0Q2paQW9PZ0VZaVZRTzNrcUVzYXNmc0hX?=
 =?utf-8?Q?LbtWIt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGNhcGRwUElhRGFIZzk3QjdSL1BOUXRpQTI4YlNKamRQSFdoV0hDNFRDdkVa?=
 =?utf-8?B?YnRpVjlqb1QrUVp4S2FuNWdLbEw1MUx0R3BuajhnUmhsVDJQNlhDWmlpVVZF?=
 =?utf-8?B?eXpFaWhucEZhanlxN2NJNXZSWldYbzFPWmxaNU9wbzJUMEpORnFYVXZVSWhX?=
 =?utf-8?B?d1RGMmJtM0NZdzJJYXgzc0NNMUt1Um1jSWZkWENGblV3b0UyRWlNMndLbXJD?=
 =?utf-8?B?WGVQRkMxdDNGZm5PaW9EOEwvRzJvNnlZZ1lUS09PVUFJTEwyeXNuaEtVOURr?=
 =?utf-8?B?QlJnYUI3UjAxL2pjWmcwUHQwU0pvT2JpdHpoUmViUFBmamp6Sm5pL3ZIQVIz?=
 =?utf-8?B?Nk5HcDBZeW55YnFFSlk5Q1pRYW5ZMFBhRjEvVUl1K0VScnUwOWRwQjUyNDQw?=
 =?utf-8?B?UmVmVEh2aCtKeXowWm00eTJZajR4N3YwV3lTb2tMdFQwbnByYWFWU3c2NU01?=
 =?utf-8?B?UXphWTgzQkdkT2hKR0w4S1g3UkRucmRTODFycU9YUkoxUWJ0WURDNUxoT1Vp?=
 =?utf-8?B?R0R5dTVuaSswdzhJVGdjZ3g2KzJwbWhqa1E3WDg5L3FHUXhqR1IxNkxQNmx3?=
 =?utf-8?B?aG5Xc2x4dHJNc2NtRE9RQ2ljRVUyczJEWVFrUXhPUXVrZTAzQUErWVpDSlpO?=
 =?utf-8?B?SUNYOHZFWG1KWHpIUFM1aS82b1N0dU5yMGJleEtjUGZVN0JWZ0JtdnR4TEwy?=
 =?utf-8?B?OTJlc1hWYW5zekRsd0J4WE5kY3RMY1ZXbXpTaWZzYnF1S29WcDg5V3JlbTJh?=
 =?utf-8?B?MWlPbG44aHhuSGgvNnI2Nm1oTnd3QlFrTWVFVm81ZytuSzk5S2NiaFJia0V5?=
 =?utf-8?B?aWxBVzA0R2M2K1RROUcrMDdETC9BS0FOVXR4TllqTENuNnFZNDdDd3BZVDAz?=
 =?utf-8?B?ZlVKMVJQRnNuRHA1SlBBVC9zOU5YV0tHOUdEUWtFWEpWMWJyRTJFd0xQZEpn?=
 =?utf-8?B?MEkyQVZTRU9IWlN4Z1ZydTJPbkwwcS9BYUJBWGVpcVFHb1Vsb3BrN2lyd1d5?=
 =?utf-8?B?bmIyd2toRkl6YXFoR2VXbHdnelFBdEJ1aS9Vd0NYNnAzcmpVeU9ZeGdTcjdi?=
 =?utf-8?B?RWoyU0RHb1NLMUo4dS9XVS96VEI1T3lRUzhEOHpQK3pmY0FWajA3UjRIV3cr?=
 =?utf-8?B?U0tKYkcwVWx4MlY3T09QbHVvK1Z4cUt4eVc3UEZoUjdxUDNNbEZ1NTg3L04x?=
 =?utf-8?B?OGU2THBkaHB0RndHZGVTQytUd3g1NDBJNFVETlNLY0NpdWVMZVQ5a0h5Nno4?=
 =?utf-8?B?RWpMS2VDU0xGMnd5bW5IM0xiNXdLMVRTNXlQUzN4N2JvUzk2dW5sNU1BT1JT?=
 =?utf-8?B?ZGhsQWEyYnRLZVdjNExGWGE2Vm91b0FTMnAxdmdiL3kzMUxXemhVOFFEZ2lp?=
 =?utf-8?B?NDhWUDhDRkJnMnZ6ZjFPQjhkYVNIcHNRWmlNMEtPUFJmZW5JdzhDdTd5NzEz?=
 =?utf-8?B?NkloSXVKVVZURTlhOFZUVXV5WFkra05sVzRlWldpNCtNNmJOTnZ3aHBxS3ZB?=
 =?utf-8?B?eXJPb2UrL01EMFk3bG53MElOS0NDNyswOWRTM3VjVXJ5b0k3aXd0ekpENUNk?=
 =?utf-8?B?a2RhNXd5UWM4Szk3WjIxM2VyNDAxRm8zQnFlUlh0WmNnNFlYem9sdXlWbWhW?=
 =?utf-8?B?bjRBdzlacmNjcWdOZWVzUmRCQnFkc3RFZlVpNWhjNGZlWVZlQ3ZsNXQ2TUJx?=
 =?utf-8?B?TGMrZE9jamVXRk1hUFRBUVhJQkVqeSt1TDlBRDFreFFodWs5eUNKS3RMZmUv?=
 =?utf-8?B?L1lXR2ErSy83TkZpMk5RNnE3OTAzR1UxNGlmd1BiQnZ1MklJMEtkYm0rUWxu?=
 =?utf-8?B?VzR2bGJLMEJLOWhsYjU1c1JjS2RIZjh3MDB2dmhrWkxBekNyeGdFeG9GeGo4?=
 =?utf-8?B?Uy9qRUtEVW5hTlBsSkI4cHo4ZjRtSHErWUxKSnRTajVUbHBNWGlLKzMrdTFh?=
 =?utf-8?B?elUzRlhyMkl2WDFEVDltcGVTdGNZQ0JVYVArRUJQdGZEeWpENXEwK3UvODFP?=
 =?utf-8?B?NHlLNzRpTU56S2U0Y1N0Sy9JTmhxQ3hVYkI0MkNWMnlKOXlRMHphRUdHT0Jl?=
 =?utf-8?B?WnFxWUx3Q3N0QlVEb2ZNR0dVa1UyQmlNdXRIVmt6eGpneC9wTG8vbEpXcTBl?=
 =?utf-8?Q?kqCeY9JIDJZjdy9tBiR8cPMiy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16145696-4a0d-4831-3217-08ddfff7e157
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:03:45.8676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPLbQZfC9DqnvYL7dQp/3VZ4bdVkOEQdxtpTjB55n3E/TpdWU8LgVs029VfxDLRC9c7g4fD+jWcoOaqnnOMsqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBTZW50OiAyOSBTZXB0ZW1iZXIgMjAy
NSAxNzowOQ0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+
DQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGVy
aWMuYXVnZXJAcmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50
aG9ycGUNCj4gPGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEu
Y29tPjsgZGR1dGlsZUByZWRoYXQuY29tOw0KPiBiZXJyYW5nZUByZWRoYXQuY29tOyBOYXRoYW4g
Q2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzDQo+IDxtb2Noc0BudmlkaWEuY29t
Pjsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5n
a3Vua3VuQGh1YXdlaS5jb207IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOw0KPiB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsNCj4gc2hhbWVlcmtvbG90aHVtQGdt
YWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA2LzI3XSBody9hcm0vc21tdXYzLWFj
Y2VsOiBSZXN0cmljdCBhY2NlbGVyYXRlZA0KPiBTTU1VdjMgdG8gdmZpby1wY2kgZW5kcG9pbnRz
IHdpdGggaW9tbXVmZA0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiBNb24sIDI5IFNlcCAyMDI1IDE0OjM2
OjIyICswMTAwDQo+IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPiB3
cm90ZToNCj4gDQo+ID4gQWNjZWxlcmF0ZWQgU01NVXYzIGlzIG9ubHkgdXNlZnVsIHdoZW4gdGhl
IGRldmljZSBjYW4gdGFrZSBhZHZhbnRhZ2Ugb2YNCj4gPiB0aGUgaG9zdCdzIFNNTVV2MyBpbiBu
ZXN0ZWQgbW9kZS4gVG8ga2VlcCB0aGluZ3Mgc2ltcGxlIGFuZCBjb3JyZWN0LCB3ZQ0KPiA+IG9u
bHkgYWxsb3cgdGhpcyBmZWF0dXJlIGZvciB2ZmlvLXBjaSBlbmRwb2ludCBkZXZpY2VzIHRoYXQg
dXNlIHRoZSBpb21tdWZkDQo+ID4gYmFja2VuZC4gV2UgYWxzbyBhbGxvdyBub24tZW5kcG9pbnQg
ZW11bGF0ZWQgZGV2aWNlcyBsaWtlIFBDSSBicmlkZ2VzIGFuZA0KPiA+IHJvb3QgcG9ydHMsIHNv
IHRoYXQgdXNlcnMgY2FuIHBsdWcgaW4gdGhlc2UgdmZpby1wY2kgZGV2aWNlcy4gV2UgY2FuIG9u
bHkNCj4gPiBlbmZvcmNlIHRoaXMgaWYgZGV2aWNlcyBhcmUgY29sZCBwbHVnZ2VkLiBGb3IgaG90
cGx1ZyBjYXNlcywgZ2l2ZSBhcHByb3ByaWF0ZQ0KPiA+IHdhcm5pbmdzLg0KPiA+DQo+ID4gQW5v
dGhlciByZWFzb24gZm9yIHRoaXMgbGltaXQgaXMgdG8gYXZvaWQgcHJvYmxlbXMgd2l0aCBJT1RM
Qg0KPiA+IGludmFsaWRhdGlvbnMuIFNvbWUgY29tbWFuZHMgKGUuZy4sIENNRF9UTEJJX05IX0FT
SUQpIGxhY2sgYW4NCj4gYXNzb2NpYXRlZA0KPiA+IFNJRCwgbWFraW5nIGl0IGRpZmZpY3VsdCB0
byB0cmFjZSB0aGUgb3JpZ2luYXRpbmcgZGV2aWNlLiBJZiB3ZSBhbGxvd2VkDQo+ID4gZW11bGF0
ZWQgZW5kcG9pbnQgZGV2aWNlcywgUUVNVSB3b3VsZCBoYXZlIHRvIGludmFsaWRhdGUgYm90aCBp
dHMgb3duDQo+ID4gc29mdHdhcmUgSU9UTEIgYW5kIHRoZSBob3N0J3MgaGFyZHdhcmUgSU9UTEIs
IHdoaWNoIGNvdWxkIHNsb3cgdGhpbmdzDQo+ID4gZG93bi4NCj4gPg0KPiA+IFNpbmNlIHZmaW8t
cGNpIGRldmljZXMgaW4gbmVzdGVkIG1vZGUgcmVseSBvbiB0aGUgaG9zdCBTTU1VdjMncyBuZXN0
ZWQNCj4gPiB0cmFuc2xhdGlvbiAoUzErUzIpLCB0aGVpciBnZXRfYWRkcmVzc19zcGFjZSgpIGNh
bGxiYWNrIG11c3QgcmV0dXJuIHRoZQ0KPiA+IHN5c3RlbSBhZGRyZXNzIHNwYWNlIHNvIHRoYXQg
VkZJTyBjb3JlIGNhbiBzZXR1cCBjb3JyZWN0IFMyIG1hcHBpbmdzDQo+ID4gZm9yIGd1ZXN0IFJB
TS4NCj4gPg0KPiA+IFNvIGluIHNob3J0Og0KPiA+ICAtIHZmaW8tcGNpIGRldmljZXMod2l0aCBp
b21tdWZkIGFzIGJhY2tlbmQpIHJldHVybiB0aGUgc3lzdGVtIGFkZHJlc3MNCj4gPiAgICBzcGFj
ZS4NCj4gPiAgLSBicmlkZ2VzIGFuZCByb290IHBvcnRzIHJldHVybiB0aGUgSU9NTVUgYWRkcmVz
cyBzcGFjZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xv
dGh1bXRob0BudmlkaWEuY29tPg0KPiBPbmUgcXVlc3Rpb24gdGhhdCByZWFsbHkgYXBwbGllcyB0
byBlYXJsaWVyIHBhdGNoIGFuZCBhbiBldmVuIG1vcmUgdHJpdmlhbA0KPiBjb21tZW50IG9uIGEg
Y29tbWVudCB0aGFuIHRoZSBlYXJsaWVyIG9uZXMgOykNCj4gDQo+IFJldmlld2VkLWJ5OiBKb25h
dGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+DQo+IA0KPiA+IC0tLQ0K
PiA+ICBody9hcm0vc21tdXYzLWFjY2VsLmMgICAgICAgICAgICAgICB8IDY4ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKystDQo+ID4gIGh3L3BjaS1icmlkZ2UvcGNpX2V4cGFuZGVyX2JyaWRn
ZS5jIHwgIDEgLQ0KPiA+ICBpbmNsdWRlL2h3L3BjaS9wY2lfYnJpZGdlLmggICAgICAgICB8ICAx
ICsNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMtYWNjZWwuYyBiL2h3L2FybS9z
bW11djMtYWNjZWwuYw0KPiA+IGluZGV4IDc5ZjE3MTNiZTYuLjQ0NDEwY2ZiMmEgMTAwNjQ0DQo+
ID4gLS0tIGEvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4gKysrIGIvaHcvYXJtL3NtbXV2My1h
Y2NlbC5jDQo+IA0KPiA+ICBzdGF0aWMgQWRkcmVzc1NwYWNlICpzbW11djNfYWNjZWxfZmluZF9h
ZGRfYXMoUENJQnVzICpidXMsIHZvaWQNCj4gKm9wYXF1ZSwNCj4gDQo+IEkgc2hvdWxkIGhhdmUg
bm90aWNlZCB0aGlzIGluIHByZXZpb3VzIHBhdGNoLi4uDQo+IFdoYXQgZG9lcyBhZGQgc3RhbmQg
Zm9yIGhlcmU/ICBUaGlzIG5hbWUgaXMgbm90IHBhcnRpY3VsYXJseSBjbGVhciB0byBtZS4NCg0K
R29vZCBxdWVzdGlvbiDwn5iKLg0KDQpJIGJlbGlldmUgdGhlIG5hbWUgY29tZXMgZnJvbSB0aGUg
c21tdS1jb21tb24uYyBpbXBsZW1lbnRhdGlvbiBvZg0KZ2V0X2FkZHJlc3Nfc3BhY2U6DQoNCnN0
YXRpYyBjb25zdCBQQ0lJT01NVU9wcyBzbW11X29wcyA9IHsNCiAgICAuZ2V0X2FkZHJlc3Nfc3Bh
Y2UgPSBzbW11X2ZpbmRfYWRkX2FzLA0KfTsNCkxvb2tpbmcgYXQgaXQgYWdhaW4sIHRoYXQgdmVy
c2lvbiBhbGxvY2F0ZXMgYSBuZXcgTVIgYW5kIGNyZWF0ZXMgYQ0KbmV3IGFkZHJlc3Mgc3BhY2Ug
cGVyIHNkZXYsIHNvIHBlcmhhcHMgImFkZCIgcmVmZXJyZWQgdG8gdGhlIGFkZHJlc3MNCnNwYWNl
IGNyZWF0aW9uLg0KDQpUaGlzIGNhbGxiYWNrIGhlcmUgb3JpZ2luYWxseSBkaWQgc29tZXRoaW5n
IHNpbWlsYXIgYnV0IG5vIGxvbmdlciBkb2VzLiANClNvLCBJIHRoaW5rIGl04oCZcyBiZXR0ZXIg
dG8ganVzdCByZW5hbWUgaXQgdG8gc21tdXYzX2FjY2VsX2dldF9hcygpDQoNClRoYW5rcywNClNo
YW1lZXINCg==


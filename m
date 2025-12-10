Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4A4D3C54A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKYv-0000xy-4I; Wed, 10 Dec 2025 08:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKYk-0000we-35; Wed, 10 Dec 2025 08:48:51 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTKYi-0003Pu-2A; Wed, 10 Dec 2025 08:48:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAGVlVRdUKkIsslW0i8nv2gJTToWem0YXmsDjkWQuU5NVvt3Vlx49okSgu+B+kajw3cMbBHw17Pau+kZN7/YShh6AyOz7mV2pw+jTyHXJdQ5upbc70VYTuSg8h8+zPoaeikd6iyyKknzTB0QvZgmYv2GX32WWkkJy3R6RtWfxFzZna+XwO4JKUwucTiid9I4zuKJKfqS+/H6GkDUNqfQ5/SKZsOIlLsApVASmG2bOB+lqAX6XoY80Qsw8u94idqCyUKFOLtkV1Z8H+MCcu2NUzGlLTCrwuXAThtz6BBk1z7wrQDj0PSSf+SQvKpw7RAwMt0AU0599kClkQElY9LI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P4hm0yy8KYktAWTEJOt+Ecaupi6f5KKvxMRLqq3mwI=;
 b=vvTkyxCo8o1E+ce4uAwdYomqCPmv4TOQluLVUJDjZqQH9E8i/IOJaOjKz6WxOGWYSPVs/YN/k1z2T23E92G1xTbpeTXdigu7qfz5U5mUdxJQL+zrh5SOeEO4fbUQx9RoXyTKAe/c+pv/5URFor7ttnQkz+aoF45vSDxu9Zksg0rLwBQGqWzZaCwfKxK+B2zyjkEyzIltNG3wl+vhrz9EBX1tyG8l2RLwr3yW8RGsWNpN9BVtsrI1GgMv249RobbGEEi3yb4gxcpvrD9FHedvXcpoByiJhH02HqQkHQE5dLUkszhT8VOtVMwQX6IY2jY1ILsWjjtNIFjcCK0B0FuzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P4hm0yy8KYktAWTEJOt+Ecaupi6f5KKvxMRLqq3mwI=;
 b=qp2ypuS0PzTxH2lWMyK10+JL9iauBft9oSmta/By/orZr0iLb+1hm0sl6kohACfSdSzr5BwNRPSAKGQ/OCmbb0K2NWznkNY2U2RYeYOdxIrMaTdI5BJAN8OWipoyzth7o0QKKB/WUghdSF0wrRWO+r6DDsSFIukbf5icGoIXw0tRuChh1dPaBYdtvfe8ZW1to0l+iuyx+tUpEU66+sy5yXIRKj4hq5d5YVQwQOXxJuq52UGTf6WWGboWb7YaW9rn7pe8+N/YNV9xJNDgYqb8mx42k0icryg0KMKNHLYLW0PEw9EsKR0nXfgqEfYIsIWxMOitks72UNnEjwbLYrMfzA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Wed, 10 Dec
 2025 13:48:40 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 13:48:40 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 00/32] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v5 00/32] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHcaPOv+oKn4gBc1kywPP7dufn4yLUa5Kqg
Date: Wed, 10 Dec 2025 13:48:40 +0000
Message-ID: <CH3PR12MB7548F7B95D55F9233E30B09DABA0A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <553c8bdc-2eb4-440c-b712-bf1f3443a0ed@redhat.com>
In-Reply-To: <553c8bdc-2eb4-440c-b712-bf1f3443a0ed@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB6554:EE_
x-ms-office365-filtering-correlation-id: 48d4f414-9384-4579-11b5-08de37f2d397
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?YUkvaXBFSDZXVlBUM3oyUVlBNDVya2lycFJpbmlFM3JTRk52QXU0WkpVb0dZ?=
 =?utf-8?B?eVc4K3dJV3dTK0Zxa2JoZFBlSUFhL1lRR1VDalMyT01hL29hYmovdDFyczZs?=
 =?utf-8?B?TkJ5SEJvUlhjeFNFU3grVDFvOXBIWW02bXQ1TXpia2VTL2ZlL01OWTBiR082?=
 =?utf-8?B?c0ZUNklDdTltUWp6cWJMK2g4QzdCc042Z0kvWENNNDdNblJnVWMxTWVYZEJZ?=
 =?utf-8?B?dWpxMFU1VnVYVWgxMyt5TGF6dU9JbzBxRmtQMGozNUpob0xqT3RadWtucGh5?=
 =?utf-8?B?MlVhUzNJSktsWXBXem5Cb3djdXdaaWM5VENhY1VGNXpZZUlQS045c283cWw4?=
 =?utf-8?B?T0xlVDNQRG1pT0l0NEwrNytBWERVOWR5RW1BcTBFMmo0WFNzLzc2V05LWXdx?=
 =?utf-8?B?VlhSeHNvUURJdFJPSXBEanB6WEw1bHQwcjE4djBHWHRqQlRhUGlWdmEzMjBT?=
 =?utf-8?B?V1ROU3hqSUlTTGlFUGpUZkc3R2tTaGw5dllLdVVsQUx6ZGxyZEtKL0pEU2Nt?=
 =?utf-8?B?dFVaTDkxUGRqaVY5Yjg4T3ZsS3h2VWxncCs2RTB2QmlrVWUzNXJkS2RlTVhF?=
 =?utf-8?B?OTJwM25tK21EZ1pDTmF4NXJTRkRtbStVNU1vMGQwcnhFT0w2WHoyemZ5dmMr?=
 =?utf-8?B?ZCs3UFVudGxKZk9TUk1lQm1TME54bmkxem9wczlDVnF3THlBR3E0WkFIbkcw?=
 =?utf-8?B?eFRuUFpaL1JCUkFlbm1CUUFIQXg5ZGx0TUZyU2s5clQ4YjQ4VnhseHpFdWFx?=
 =?utf-8?B?dTQ4azdyUzVyZlVyTjBwSHNlanljRGtTekVKZVRFMEwzSWNxNU4rYm5BSGk4?=
 =?utf-8?B?eEMwMEwxM2s2NkxuL1pKaURVYUxOa0ZqQjVTT0JDQ1RRVlYvaWVxTjd6SlBn?=
 =?utf-8?B?emZxTm10ZGVNdHpFM2VVb05ON2Era0JJWklBQVN5aWZiZW9MMTlEMldmRjMy?=
 =?utf-8?B?ODJON0RDODMvU2ljelRKMTFqL1ZLbmdYV0hqODFseFZnTmUwU3NyM0E4LzF2?=
 =?utf-8?B?R1dlZTdMU250SWxMeTc0OVFNVmxURDFCWEFKeU14ZGhRMU11VWNNc09MOUdk?=
 =?utf-8?B?Q21LR1RPZlM5U0d4cUNqMkFZcTNMVFhsY3o3Ui9QbDRjem9PM1BpSm5naHpD?=
 =?utf-8?B?OG5oajRMMlk4MWVWREgzMlJuZnl5OWY5eFF3cERCbWxZc0JJYkcrWThwU2li?=
 =?utf-8?B?RG5Udjc2QzY0ZFpFUkIvV2oxdUQ1L1VWb2F5cXNiVFR3eVZHUjFLdHdORHF4?=
 =?utf-8?B?bGxWSndxQ1BRYlQ4N3NDVVVRRFB5NWM1SUZNaDlJY3M5TUcxVU1OMWRoNUFH?=
 =?utf-8?B?ZUFNL1lHNFY3QzNtSzBTY2xyakF5SGF2S21lQU9Vakpid1p0YUp6RnpvVkF1?=
 =?utf-8?B?TzZFT0tiQ0N1eHN5NXF4V3lrQlZCZ2FaK0dETlpoNFYycFpiME5BSEp1WG5N?=
 =?utf-8?B?c212SkpkamJaTm1ERmtuWHVUaXJudnc3b1dHNWlzZ3Fxalp6M1ZtRndReVhI?=
 =?utf-8?B?bmxjTU9KNUpWOHpHdXYvZTYzb3M0VUc0RXZVYWVEZEFnK3pTWnE2K2JmUVVO?=
 =?utf-8?B?Ri9DNG9wQy9MaFpjSTQ5VTVoYURGeEVLWWZ3MUZtVXVlQi9GamdmcWJsYk96?=
 =?utf-8?B?a0k1dEFiMHdpcFpraGZjNnd3OFNqdUJURCtqSWxVWVZ0Z3AxZWhLYWJpTE9Z?=
 =?utf-8?B?K3hIVkdSbTBFdzBzNEJRZTZ1S2lVYUhQTVY5b3h0UGRKRHdVbHg4YkZ6RmpV?=
 =?utf-8?B?SnBkSjNBMWdCd0R0Y0dXZnZhUk1RT0d3aUZlNHltUXdBWlhVb0hqYUl0Z2cv?=
 =?utf-8?B?akJrZm54Z2xFSXVTaEtnckZUUjMxVUNIa3ZNeXpOSkwzUFFQNEhEdU9meFBo?=
 =?utf-8?B?Nk1CMFNrRWdFTS91aTJmaGNhT3NodWNnUVJIbFJtQk5MeUlzQ1R4R1JJWjRM?=
 =?utf-8?B?WFNIaFd2Ty91dVVaWDNMZEdtWDJyS0pHMHZQRFk1eXlWdm10TlpOWHB5STZ5?=
 =?utf-8?B?RllqSTNzRG0zTDlZVDJtNkJXSG1acUs2ajNoMFpsR3ZIMjJFVzVDNzhxdW5z?=
 =?utf-8?Q?NN5BbE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDRJT1RNUDV3cTlTZStva0RBME5EMU1MNWxSNUh3aXg4RElyVHJSb3FhbFhz?=
 =?utf-8?B?cjdnOW5kWTB2MWZKdUk3V3FiU2NzQkNRaUlKbkpyU0s1NFIxYlM4cXZIYVA4?=
 =?utf-8?B?dW1mYzdtWnRxNURoVXphU2pqS3RJSjhvWDdQN3lYT2tTdE9HS0M0N0VHSmpX?=
 =?utf-8?B?NlVOK0o1VTJFNy9NOU5OUm5UcFdBNXNDVk5RdUJiWnRERU04N3NGUGY3YVRv?=
 =?utf-8?B?QjJMdnpTa29yZW5UZW1ld0t6Z3hmeDROVGFjNVlWeXgzK3pWMGNTMk9sU2N6?=
 =?utf-8?B?dDBzckZHazljRjc0blZzVklIVEt6M1hES2FxQmp1V1I0K0lsN084eUI4cVBk?=
 =?utf-8?B?UWIrZzFOYUcxNUtmSWRPZTFUazZWeWYzeThnTkplQ1lXcWxCV2JFNHVML1JT?=
 =?utf-8?B?M3Z5NFRhMC9sdThXcXBYNnBsUUhwVjgwYmc2NTZyY3dybDAwaXcwTFpWODVo?=
 =?utf-8?B?Lys1cXJQc1AxRStmdng0WXBUd05EeTRCZTN2S3lpY3A2UUhnWHlpZkkwRlg2?=
 =?utf-8?B?Y201WHdRWTF5MW1nQytsK1dZMEpWeXVpUGsvMUJVOXQ5U1g3a2Vqc2VMWEdV?=
 =?utf-8?B?RTZrYlhsQlNvQTRrZ0VPNCtyZjRwdkoyS2dacUkzdEVON21yRlhpZHEzUUpY?=
 =?utf-8?B?OHE4Q2pBNVNaSldHMVRRUXBrUXd1TDdVcUVZQm03b0tmQWpqZlR6cGhZRDdh?=
 =?utf-8?B?S2FHRFRBV2kzakpWYVZKakIvRCt3T3l1M3I0TFBYRFpPQTd1d1NhUnZTSjVX?=
 =?utf-8?B?YW1kTWpPYTJYNUZkdEtDY1ptVmZNN2QwZ2szNVpEcE5LNkFrV3NJYnV3SEdU?=
 =?utf-8?B?blduRy9FalF5czNtNVNvdFpPbndvRFdDak94bVpmRUdaeVlyVVdnWnBuWXdT?=
 =?utf-8?B?RTljUjJXWml0WCtEYmJKcnMyb2N0cHN4azhDZ3JTckV4SEpiODFnVGFQdEFu?=
 =?utf-8?B?SmdMTitiaS9wQlhIRWNaenhIVWhZYUJSZEpybDRTYWZKYmd1MUI0eGhPdm41?=
 =?utf-8?B?LzQ3L3p3LzJQNE0vcG9jS1A1UXJzRGx5ZUNSWEJ4cG9Wc0FhWjN6SFFyay9P?=
 =?utf-8?B?dzZHTmM2M293ZmFoVkdzK3crSStINHBZRHRmRjl5b3FLMmRLNVpraGxVNzNL?=
 =?utf-8?B?ODhheno4RTJRcXpBNHpHZ0IxS2J1eHJBQVp1MW5OMWFxeXIzQWlRYWkrUkt0?=
 =?utf-8?B?c0QzTzZCSkFZMjdGcUQ5SWRaMXh5bENSTUlyV2JsZGxvMExDT3lrVGJSYXlW?=
 =?utf-8?B?a1ZHNThXekdUa2Z6RGg4ZnlZd1krQS93ZWQ3R0UwU1JtYmVqVXdGTVJIQVdr?=
 =?utf-8?B?U0RWenJ0dDZ2RDU1TERqTWYrUERleWVwUG41ZlpzanU4bEFwRnpucW1nSzB5?=
 =?utf-8?B?K3NWcllXQndicldlM1BRZGZMSFpHOHIvWkNyMzVDUGk3WVgvMlh4M3R2R2Q3?=
 =?utf-8?B?Z3pQS0VoMHlOR3ZxM2lKSHA1VVIybmxDYVV2VEIySjVkU0JLVXJwdFdZTC9H?=
 =?utf-8?B?eGpLWHVvWUZ1UXdGRUloV2MvN1JWM0hsRkpFVlEwcXU1R29pZ0xKbUVVU0Ja?=
 =?utf-8?B?REJaQlIvS21kcmdhY2cwdmZBenV5NW05VUFqRkNvTUI3OTJrdU5uTStlU2pt?=
 =?utf-8?B?N0dwc0crVVBmdzRYNklBVkkwL0NlMGVQY1hmRXJxcjBwd0xXRTFTQ3Z6NzF3?=
 =?utf-8?B?WUxWblV0QlQrOWQ5VFZiNVhvT0Q3UkhuY3V1Z2FsUGJDRERzc2Y4SGpMR201?=
 =?utf-8?B?cmw3bjFXQzBNdHc3NEdYcERoMnhFejJQUFIwN1RGQzVqeHFPS0U2ZVdFaExh?=
 =?utf-8?B?UkpaRDkwQVk5S2Zxb3BaTXRPajVvT3cyZVIybEhpYi96Ym9SU0NOcXF1MFll?=
 =?utf-8?B?RE9zOXZuVUlNd1J3c1ZRNkFNc0NYVVVqa3VUL0kwajhaUXdWTnk0NW1zNUJN?=
 =?utf-8?B?ZnV1NlA2YkJ0RVFoVlhlcDQwQThtTU9ZRFhWaitkQVZIWUFTMWlDKzNTM1g2?=
 =?utf-8?B?UVprTTJXZDBYSzNQRE5jV0tCZlNNL2ZNcDZjUDRJbC8rUmJJV0l6d3hZRjFj?=
 =?utf-8?B?ODB2VEtsSFMwWlV5UytrWDh0RTlyVTZnTStmK1NjaWZhNXhYMDJsNFFScEpy?=
 =?utf-8?Q?w3+vfs94urXzK0M47P4EpiHQ3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d4f414-9384-4579-11b5-08de37f2d397
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 13:48:40.4147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mdJPsjB/we21JDtznVVgpStZCzDCVvLEZB/ZJMopcnQmtxf3Jk+aEvwkKpYogqQMgTaM+0cEz4MQ57SCLKfXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554
Received-SPF: softfail client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA5IERlY2VtYmVyIDIwMjUg
MTA6MDgNCj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsg
cWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogZXJp
Yy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRo
b3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5j
b20+Ow0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207IE5hdGhhbiBD
aGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+
Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlh
bmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFu
Z2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBp
bnRlbC5jb207DQo+IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjUgMDAvMzJdIGh3L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNl
ci1jcmVhdGFibGUNCj4gYWNjZWxlcmF0ZWQgU01NVXYzDQo+IA0KDQpbLi4uXQ0KDQo+ID4gICBo
dy92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDcgKy0NCj4g
PiAgIGh3L3ZmaW8vcGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzNyAr
DQo+IA0KTXkgYmFkLCBzb3JyeSBmb3IgbWlzc2luZyB0aGF0LiBXaWxsIGRvLg0KDQpUaGFua3Ms
DQpTaGFtZWVyDQo=


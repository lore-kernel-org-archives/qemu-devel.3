Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C71C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 10:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdoWT-0002Om-Pw; Fri, 31 Jan 2025 05:45:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tdoWO-0002OP-08
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 05:45:13 -0500
Received: from mail-sn1nam02on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2406::616]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tdoWL-0003Az-J7
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 05:45:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLkeb6+pEVMjclSL8ptjiHW9QWGoaem//E1FTk58uZMtmhBbox3D1C6/lULjh1Tdu8g0qgRiqXugBb9gbmd+nwQKX3Tu47CfJjG4pRR1sGtmoWgOT1eDpgc9Us2uheKf3lauryralCZbzSz+k6b8CR5vhB8xc7+OVCr8Z8iSw0PPXAu8pLisR2U0tVZjsWosdVoxw3RcaR52PNaKrcpIozMkbmfLBo1XDcOPOfBcUQASOHCf9uD2C52dxcXZ1dvHZ2qmrdXHmKbYzlMr7thUjEaXXnRfE0G2RcO7ZIRnR1dA7p8O7KE2VYqiBaYHRERybwXhn8OuMUJv66S4pmC3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTTYOFoy3a/1e8M4nuTf/hdwJMxqBOm1DKJSmNU/imo=;
 b=eCeDSUpJ9SN6J8ROlu4+clJZjNkvkMdjtTfnJnI//wce8qT/w9JJXI6ja4NVSv8eWA5TPJr5KaCoEix+F/3mmk2XkDpT7Nsxy8Ko0dHvVHflmP50gchvixYt2C/z6a9KZrSsoIatCXF4FZIFuUvx1il7kuSgHsjAJyif3oD3zfGQ7uOQz9AZRidggWKG67kBthBu8HAy9E78yomY4EsvNvRN8GLt98ugOKr2xecIOCSJyrXhcKqx1TIb4TLaQFcr7cRDhGARyYTjlB/NJfF9Vyh1pkpru/9KXnkq6jY7T0bRGG6SbEfdRjn9u9euPRXCqWoFnTdQ51F9iOaOwo3sOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTTYOFoy3a/1e8M4nuTf/hdwJMxqBOm1DKJSmNU/imo=;
 b=k7UHnTgax+7f/M9U133ivFNu7uRUchhFgyBBJohuDeP8p82tF89n926NXMa1b6GJjzC+edzMNVpRZ5geBmASs3YOAPrZPf/p82ct0C2u5bsIlN7Mws5Sy2SB56WGWNDh/17WwhueOcoBxo1CWxWXTkD8Wnb6pTH8UOovnT7B+EGE6XMjGcSnjcxlV3NbuWw+dceKV6ry3Wv9A+CamqvL0A8s9tksxB6eLl+3NwzWRQv7DRh+WBeisGytMCJYmidCygahU1/B+O6VDOMS3OPCr2b7Glc0QA/2b1pITKl1wW4s+nelq+RdwJlANuWYY/3uUK4rnZEOezZNW09naDI8oQ==
Received: from DS7PR12MB9502.namprd12.prod.outlook.com (2603:10b6:8:250::19)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 10:45:03 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by DS7PR12MB9502.namprd12.prod.outlook.com (2603:10b6:8:250::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 10:45:02 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%6]) with mapi id 15.20.8377.021; Fri, 31 Jan 2025
 10:45:02 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
 <dave.jiang@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "alucerop@amd.com" <alucerop@amd.com>,
 "clg@redhat.com" <clg@redhat.com>, Andy Currid <ACurrid@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Surath Mitra <smitra@nvidia.com>, Ankit Agrawal
 <ankita@nvidia.com>, Aniket Agashe <aniketa@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 "zhiwang@kernel.org" <zhiwang@kernel.org>
Subject: Re: [PATCH 3/3] hw/cxl: introduce CXL type-2 device emulation
Thread-Topic: [PATCH 3/3] hw/cxl: introduce CXL type-2 device emulation
Thread-Index: AQHbTJZ3R1UZKPi5ukqqLDemJlvzP7MhpmMAgA9a0IA=
Date: Fri, 31 Jan 2025 10:45:02 +0000
Message-ID: <8d08ab33-d989-4209-b137-a6991c7af415@nvidia.com>
References: <20241212130422.69380-1-zhiw@nvidia.com>
 <20241212130422.69380-4-zhiw@nvidia.com> <20250121161610.000025af@huawei.com>
In-Reply-To: <20250121161610.000025af@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|DS7PR12MB9502:EE_|MN0PR12MB6318:EE_
x-ms-office365-filtering-correlation-id: 29cf3491-4459-4842-bbde-08dd41e450ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UmtadnJ6ak1nb0hWNVFPSFhVWC9sWEt0OU1ZaGxwelA1UWZFdTlCNmFUdHhL?=
 =?utf-8?B?NzBWcGU2WlJKMU5ZM3B3clEyY1diaUgwMEVxNm1vMjZHRVZGTk12SlBCbG8v?=
 =?utf-8?B?b2YwSHZJQ2Y3U05nMnlTWUJhMVFaMFgvalcyeFhqMXhqbStsTUJlRklJaUd0?=
 =?utf-8?B?eGpFUkRTUGd2eWlkaG4xS1JSVnUxcXp4VDdHTUt5VDRXS2x4N2VNdlp1S0JF?=
 =?utf-8?B?UUd6QStPN2lXRURWNVVKRlpFN3RzOW9SUjI4ZkdkUEtONzQ3R2RVTGZWVW5R?=
 =?utf-8?B?SUQ1MzRtbTRFWHdDOEJmbFZmc2RyR3Q3YTdPUkJFS1BnTklsSzd3M1o3bStw?=
 =?utf-8?B?VTdXaVhkTUpHczZwbzBpV1o1bXZYVlc4TUNlelI0ZHFFUUNNK2pTUE1OSnY4?=
 =?utf-8?B?WURrcXgwUWM1ZlVCS0M0a09Qc2hMNFM0L0Rka1IwT1J2V0xjT0ZnVmEvd1J1?=
 =?utf-8?B?L1hLVEdpWmhoTy9sVnBZTldBTXBTcXNxbzJoaEZvNzVKYXlGVmRNMjVUdTV6?=
 =?utf-8?B?aGlvWE9mUi9QWDJuSk02blFTT0FlY216aHZEckI1Nm1HbW5nMjN1SFRjL2R3?=
 =?utf-8?B?aXBvQ2VYVTcrZEN3aXBSMklPaHoyK1pGaEhKRFRjeExzQ2M1bjlheUQvclUv?=
 =?utf-8?B?TVRPUGdzUTFPNS9rOW43ckdIT3Fpc0RDcE5qNWpxRFl1NTBlbUMxczhKTXdw?=
 =?utf-8?B?TlFjYWNwdkw4eDB3U0wzeXJ6bE5OTXdDdkpMSHNRVUpWMVRSclhlak1EcEpT?=
 =?utf-8?B?THJlaElkQVVCWFJ3TUlPakNaRWJKQW02dEhaOWRYOUZUQzVBZkg1YjZKTTQy?=
 =?utf-8?B?OTdVaktOZjFuajVxQ0xPV3Y1YnJTSGdmYStUTTNLR3JOZitXKzZUVjNneEJK?=
 =?utf-8?B?NGtoM2V3WHhZOHI1S1hGUEZEVjkvZXFwTWtHU2M2cG1nQWh3aVJKRkRiK3R3?=
 =?utf-8?B?UWxQbFl6Ukt5OFZBTXZvcWNRQnZWN3lPZkh3aEI2cHRiaVhLcS9WMHIxaW5s?=
 =?utf-8?B?cjNqNzBRdVdRR3dWYVQzMEFZK0xyczh3VlVmb0hhSGtPV1hpUDZrSTVJTXNT?=
 =?utf-8?B?UldaV1A4WEJSY05uSFk5cEdxN0gzU2VQMkZ4TFJlZDFvaFg3dlN3Y2d3SjdY?=
 =?utf-8?B?Y1ppTzl6TDg2Y3NOUU92MjZCRlB3SlBYdXVwb2F4bjNyUGZtRzUvdDk1THM5?=
 =?utf-8?B?Z2d6dzZGRzluNmhSVnF0dzMwbkI1NW9xd0VRQUtuS1ZiSlg4OFBnQUIyWEtP?=
 =?utf-8?B?YklXNDFhRkNCK0ZDS2UwRmw2WU1NVUhtM1lwTlhBUkxqcE0xTUNYMXdUWlFE?=
 =?utf-8?B?KzZRQ1FKeWxyZnJWOHlRK084OTZRVXh0S3BBaEFjZzY1eTNSTWlOOXZRVVFx?=
 =?utf-8?B?ZlEyU0VrTGwwU0w5R1pyNHVJOFcra1puZ2pTQXRpOS9Jb2FEOW1TTURUOWVt?=
 =?utf-8?B?K2dkVWZCSWFPWGNNREgxRndJc2tBQ3Nwc0RoTy9PT3FkY0Q3VjRvUUNoaGsr?=
 =?utf-8?B?S3ZUNStZT3J1MFFFalFOK2owWER3Z2xpTm51Uyt0WFdJTXhKTndQeTB4WjZz?=
 =?utf-8?B?RGNVdExWdVo0aHN3aUs0Uys5c3V0VFE1L2JHRkU3Y0RoSitwOWFBalVOazV0?=
 =?utf-8?B?eFFEMTZ0UnZQclpuK25jUnBCd01oNW5vNnMrZkJydGRKOVVobXZaWUVDL3Fx?=
 =?utf-8?B?QmFZaHI3ZnNGelNFVTJNMXpHVXVmblV4TVhjeElzSWtpZmptUXdhWElRU0dU?=
 =?utf-8?B?ZGNaM3JWNlg2OXF4SWo4elNpNHZHSWpWZllqTFBObWYxVUlvQW5PMG5oY3pK?=
 =?utf-8?B?UkdHM0lXTHlCTUU2ZHBrWjVvK3N4aDk3VFE2REVzNHk4a3BPbDJXUHZLTWlF?=
 =?utf-8?Q?VmzW2e7bzZmEB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9502.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDBxclZ4M3k0elFSRGdtZDV5dzdzT2dnV2lmUFNxN0FYQmNtRGlPVmVTU0g4?=
 =?utf-8?B?YjdhVU1KdktwUEdveGFubG1LZ3JjdXhHaFN3SXJhNGpKai9QaStnZUY0Zzd5?=
 =?utf-8?B?UVdWOGZFeDhPRTQ2d1cybzJMd0pmYjZSSzhBYkJrVE01QWZ4Q1ptWUQ2VFVX?=
 =?utf-8?B?NUM4UTg0NEpWcjBSNFE3VW8yL2YwRlE0UGxHS1pLTHdpbk1Zb0RNcTQ2Wm1t?=
 =?utf-8?B?d3djbWpydFQ0M25YNmlURkhhQkdiVUVKY0d2R25aVkR1TnczeUdsaFl5b3VD?=
 =?utf-8?B?ZnZGTThKcDNESE90aDEzV2hPUk93Q3VvdWZUSFB0Y3l0RDk0ZGtNdXdpRE9i?=
 =?utf-8?B?OFljbnl1cjdTR1N1OS94U3JmK1c4MTNkUW93VlpuR3NzYXlWNkFJT3FPYWY5?=
 =?utf-8?B?bzBUeThrK3pqM2tEdEZkMlFMY3Jjd1hyMGZQcElDMWhSU1dCeUJXYStudU9D?=
 =?utf-8?B?WGlQU2gxaVBDSDNkTU5MTVVHK1R5QlY1SUd5QVQ1ajNmZUFjQ2hwNXQvRldn?=
 =?utf-8?B?NFJDM0xFN3FWWlUvcjU4SUIyRElLU0NHeUdjMmJJUnY2Z2VWVHJUMytXZlNw?=
 =?utf-8?B?Q3N5d1VxYU0rVHNXZFZ6UG1LV3dmYnNVWmVRZjJ6NjJkYzVsN2FDczZJaDNq?=
 =?utf-8?B?aXQ0N1Nzd3JoQnF1eXFmMjEvMTdyalBjQlU3dUpFOUU5NktqRVVtZFU1MUFw?=
 =?utf-8?B?aDF2M0dEMllJNWxzNzc2SWY0S09QME9QSmtOVjRkdnNVcXlZd21hNEZtWngw?=
 =?utf-8?B?THVhZmsvL0NKVW9odWRHZ0ErdFJLMWphTXk5MDVVbFNUaEF6MmE4VkwzSUlC?=
 =?utf-8?B?U0FjSzJIUlhOMkhOTDZxQTdPaHJsMlhHN3luS01sc3Vid2VXTzN2dHpKWG0y?=
 =?utf-8?B?bGJSaUxNQ2FUZjNMa00rdDM2N1IxYmcvNjZ3QlduR0EvQmY4Vjc4U3l5dzZw?=
 =?utf-8?B?TVNiVkxOTm1pNnhmbk02TjBBY3J2czlqaC9Wb2hGd3c2Y3BUQWZtL0dJNG9V?=
 =?utf-8?B?QzZyeGtVekVWa2FxZk9yMWFXYUYwNWptcGd4M0ozV1NxcmE2S01iam9yMjlH?=
 =?utf-8?B?cEVEWWNEQy9CWXZiVEhMVXNWbExPYUViTExqVVo3WTdXKzZMZ3VBUHlCMU95?=
 =?utf-8?B?cGdHQ25BVDlMc2YrWnJDNFZRKyswN09tVFQySkFVQ1ZvcXdnVS9jZDAycFo4?=
 =?utf-8?B?ei9LWDdaNFlPMkU5eEMvcDZaa0FocVNRa0RpRkFrWVowamNTUmlxVmZwS0Za?=
 =?utf-8?B?UnBLcVNaSmtvSVlPVGpESmEyd1JNMmlaV1gzZUJCSGE3cFEwYll2VElGVFRz?=
 =?utf-8?B?eW83aGhMM1BtbnNjMWZ4YnBJbE5qc1JjRG5qVHU1S3huczVuSk9vMTJJTXRV?=
 =?utf-8?B?MjdQSTRIby9EdUJjVnk4cU0yZ0I0R1FCa1hrM3NMVGY3dTh1dnhzQVZ3c1l1?=
 =?utf-8?B?VkwzUlZGakc0eVF3SHUvL3huajBmaGdiTk5KN1hGdVYyTUp1ZEY4cm9Ddm51?=
 =?utf-8?B?Nkc5UHpraHk1MEJzZE5MRURZVHhJcC9pektBVEpPUExpOTN0WE90V2owMlcw?=
 =?utf-8?B?T3RlZGhDWTVrTGxVWFExTnFXaUUxQXBxRkIxYURFZGkvV0lPSXh5WWpQdjFm?=
 =?utf-8?B?QnlDOEl5SkVXbE1iYjRTcDJtRG84WXg0YWRCM01RYnQ5bE9GbndIMVBaVnBO?=
 =?utf-8?B?cDdDUnB6Y3BkT29LTHhiOGRQOEY0dVlkOXhubnIyL2wvM3M0ZFN5WGJpam52?=
 =?utf-8?B?MGt1ZGVuY1ZHMVp4SXREUlBJV0Q3Vnd5L1VhS21naElHbnk0R1BiV0gyYlky?=
 =?utf-8?B?MjBCbk1nUHVMcC9PS01wNWs4dGNacFNxR0lzMStCNXJ5UnBEOUIxamwxMzlP?=
 =?utf-8?B?ZHZFcEtHclQ5Tk1DTWtpd2FUN2pJeUJvbmI3Q2VPV3ZJbkFwLzJSTjhXMU80?=
 =?utf-8?B?V3FQMW1zZjJqQW9VZFk3UDdJTGtkcWR0ZDJXTXJOOS9WQTR4cUpqTTFDWVoy?=
 =?utf-8?B?S0FRc1ZDRDZVRkhQa3dHVU1lOUVCc2JtRkhDVG9mSHZKVGI4YkhUTWZzU2Yx?=
 =?utf-8?B?Um9PZWNBanJpTWordng4YW0xSE9SSVBsY3FJV3Q3TlJDeGtSM0JnU3JtSmZL?=
 =?utf-8?Q?bmvk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7438A171991BAC478B86A21673BE3DE3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cf3491-4459-4842-bbde-08dd41e450ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 10:45:02.2326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CW0b2gnxX45KwYxUzmcas0AshBSJyP914tOPG0w8zzFcugOs7cas0TsXBKBlM2y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
Received-SPF: softfail client-ip=2a01:111:f403:2406::616;
 envelope-from=zhiw@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gMjEvMDEvMjAyNSAxOC4xNiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gVGh1LCAx
MiBEZWMgMjAyNCAwNTowNDoyMiAtMDgwMA0KPiBaaGkgV2FuZyA8emhpd0BudmlkaWEuY29tPiB3
cm90ZToNCj4NCj4+IEZyb206IFpoaSBXYW5nIDx6aGl3YW5nQGtlcm5lbC5vcmc+DQo+Pg0KPj4g
SW50cm9kdWNlIGEgQ1hMIHR5cGUtMiBkZXZpY2UgZW11bGF0aW9uIHRoYXQgcHJvdmlkZXMgYSBt
aW5pbXVtIGJhc2UgZm9yDQo+PiB0ZXN0aW5nIGtlcm5lbCBDWEwgY29yZSB0eXBlLTIgc3VwcG9y
dCBhbmQgQ1hMIHR5cGUtMiB2aXJ0dWFsaXphdGlvbi4gSXQNCj4+IGlzIGFsc28gYSBnb29kIGJh
c2UgZm9yIGludHJvZHVjaW5nIHRoZSBtb3JlIGVtdWxhdGVkIGZlYXR1cmVzLg0KPj4NCj4+IEN1
cnJlbnRseSwgaXQgb25seSBzdXBwb3J0czoNCj4+DQo+PiAtIEVtdWxhdGluZyBjb21wb25lbnQg
cmVnaXN0ZXJzIHdpdGggSERNIGRlY29kZXJzLg0KPj4gLSBWb2xhdGlsZSBtZW1vcnkgYmFja2Vu
ZCBhbmQgZW11YWx0aW9uIG9mIHJlZ2lvbiBhY2Nlc3MuDQo+Pg0KPj4gVGhlIGVtdWxhdGlvbiBp
cyBhaW1lZCB0byBub3QgdGlnaHRseSBjb3VwbGVkIHdpdGggdGhlIGN1cnJlbnQgQ1hMIHR5cGUt
Mw0KPj4gZW11bGF0aW9uIHNpbmNlIG1hbnkgYWR2YW5jZWQgQ1hMIHR5cGUtMyBlbXVsYXRpb24g
ZmVhdHVyZXMgYXJlIG5vdA0KPj4gaW1wbGVtZW50ZWQgaW4gYSBDWEwgdHlwZS0yIGRldmljZS4N
Cj4+DQo+PiBDby1kZXZlbG9wZWQtYnk6IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFpoaSBXYW5nIDx6aGl3YW5nQGtlcm5lbC5vcmc+DQo+DQo+IEhp
IFpoaSwNCj4NCj4gQSBmZXcgcGFzc2luZyBjb21tZW50cy4NCj4NCj4gSm9uYXRoYW4NCj4NCj4+
IGRpZmYgLS1naXQgYS9ody9tZW0vY3hsX2FjY2VsLmMgYi9ody9tZW0vY3hsX2FjY2VsLmMNCj4+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi43NzAwNzIxMjZkDQo+
PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9ody9tZW0vY3hsX2FjY2VsLmMNCj4+IEBAIC0wLDAg
KzEsMzE5IEBADQo+DQo+PiArDQo+PiArc3RhdGljIHZvaWQgdXBkYXRlX2R2c2VjcyhDWExBY2Nl
bERldiAqYWNjZWxkKQ0KPg0KPiBKdXN0IHRvIG1ha2UgdGhlbSBlYXNpZXIgdG8gc2VhcmNoIGZv
ciBhbmQgdm9pZCBjbGFzaGVzLCBnb29kIHRvIHByZWZpeA0KPiBhbGwgZnVuY3Rpb25zIHdpdGgg
Y3hsYWNjIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+DQo+PiArew0KPg0KPiAvLi4uDQo+DQo+
DQo+PiArc3RhdGljIFByb3BlcnR5IGN4bF9hY2NlbF9wcm9wc1tdID0gew0KPj4gKyAgICBERUZJ
TkVfUFJPUF9MSU5LKCJ2b2xhdGlsZS1tZW1kZXYiLCBDWExBY2NlbERldiwgaG9zdHZtZW0sDQo+
PiArICAgICAgICAgICAgICAgICAgICAgVFlQRV9NRU1PUllfQkFDS0VORCwgSG9zdE1lbW9yeUJh
Y2tlbmQgKiksDQo+DQo+IERvZXMgYmFja2luZyBhIHR5cGUgMiBkZXZpY2Ugd2l0aCBhIG1lbWRl
diBwcm92aWRlIGFueSBhZHZhbnRhZ2VzPw0KPiBJJ2QgaGF2ZSB0aG91Z2h0IGEgZGV2aWNlIHNw
ZWNpZmljIG1lbW9yeSBhbGxvY2F0aW9uIHdvdWxkIG1ha2UgbW9yZQ0KPiBzZW5zZSwgbGlrZSB3
ZSdkIGRvIGZvciBhIG1lbW9yeSBCQVIgb24gYSBQQ0kgZGV2aWNlLiAgVGhhdCBtaWdodA0KPiBj
b21wbGljYXRlIHRoZSBjeGwtaG9zdCBoYW5kbGluZyB0aG91Z2ggc28gcGVyaGFwcyB0aGlzIGlz
IGEgZ29vZA0KPiB3YXkgdG8gZ28gZm9yIG5vdy4NCg0KV2FzIHRoaW5raW5nIHRoZSBzYW1lLiBB
cyBteSBjdXJyZW50IGlkZWEgaXMgZm9yIGdldHRpbmcgYSBlbXVsYXRlZA0KZGV2aWNlIHRoZSBw
ZW9wbGUgY2FuIHRlc3QgQ1hMIFQyIGNvcmUgaW4gdGhlIGtlcm5lbCBhbmQga2VlcCB0aGluZ3MN
CmFzIG1pbmltdW0gYXMgdGhleSBjYW4gYmUgaW4gdjEsIHRoaXMgd2FzIHRoZSBzaW1wbGVzdCBp
ZGVhIEkgY2FuDQpvZmZlci4gSSBhbSBvcGVuIGZvciBzdWdnZXN0aW9ucy46KQ0KDQo+DQo+DQo+
PiArICAgIERFRklORV9QUk9QX0VORF9PRl9MSVNUKCksDQo+DQo+IFdoZW4geW91IGdldCB0aW1l
LCByZWJhc2UgYXMgdGhlc2UgaGF2ZSBnb25lIGF3YXkgcmVjZW50bHkuDQo+IEkgYWltIHRvIGdl
dCBhIGZyZXNoZXIgc3RhZ2luZyB0cmVlIG91dCBzaG9ydGx5Lg0KPg0KDQpXaWxsIGRvLg0KDQo+
PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBjeGxfYWNjZWxfY2xhc3NfaW5pdChPYmplY3RD
bGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+PiArew0KPj4gKyAgICBEZXZpY2VDbGFzcyAqZGMgPSBE
RVZJQ0VfQ0xBU1Mob2MpOw0KPj4gKyAgICBQQ0lEZXZpY2VDbGFzcyAqcGMgPSBQQ0lfREVWSUNF
X0NMQVNTKG9jKTsNCj4+ICsNCj4+ICsgICAgcGMtPnJlYWxpemUgPSBjeGxfYWNjZWxfcmVhbGl6
ZTsNCj4+ICsgICAgcGMtPmV4aXQgPSBjeGxfYWNjZWxfZXhpdDsNCj4+ICsNCj4+ICsgICAgcGMt
PmNsYXNzX2lkID0gUENJX0NMQVNTX0NYTF9RRU1VX0FDQ0VMOw0KPj4gKyAgICBwYy0+dmVuZG9y
X2lkID0gUENJX1ZFTkRPUl9JRF9JTlRFTDsNCj4+ICsgICAgcGMtPmRldmljZV9pZCA9IDB4ZDk0
Ow0KPg0KDQpUaGUgSURzIGFyZSBtb3N0bHkgZnJvbSBJcmEncyBvcmlnaW5hbCBUMiBlbXVsYXRl
ZCBkZXZpY2UgcGF0Y2hlcy4NCkkgd2lsbCB0YWtlIGEgbG9vayB0byBzZWUgaWYgdGhlcmUgaXMg
YSBiZXR0ZXIgb3B0aW9uIGZvciB0aGlzLg0KDQo+IElmIHlvdSBhcmUgcG9zdGluZyB0aGVzZSBJ
IGhvcGUgeW91IGhhdmUgdGhvc2UgSURzIHJlc2VydmVkDQo+ICh3aGljaCBzZWVtcyB1bmxpa2Vs
eSA7KQ0KPiBXZSBuZWVkIHRvIGJlIGFic29sdXRlbHkgc3VyZSB3ZSBuZXZlciBoaXQgYW4gZXhp
c3RpbmcgSUQgd2hpY2ggZ2VuZXJhbGx5DQo+IG1lYW5zIHlvdSBuZWVkIHRvIGZpbmQgd2hvZXZl
ciBjb250cm9scyB0aG9zZSBhbGxvY2F0aW9ucyBpbiB5b3VyIGNvbXBhbnkNCj4gYW5kIGdldCB0
aGVtIHRvIGdpdmUgeW91IGFuIElEIGZvciB0aGlzLg0KPg0KPj4gKyAgICBwYy0+cmV2aXNpb24g
PSAxOw0KPj4gKw0KPj4gKyAgICBzZXRfYml0KERFVklDRV9DQVRFR09SWV9TVE9SQUdFLCBkYy0+
Y2F0ZWdvcmllcyk7DQo+PiArICAgIGRjLT5kZXNjID0gIkNYTCBBY2NlbGVyYXRvciBEZXZpY2Ug
KFR5cGUgMikiOw0KPj4gKyAgICBkZXZpY2VfY2xhc3Nfc2V0X2xlZ2FjeV9yZXNldChkYywgY3hs
X2FjY2VsX3Jlc2V0KTsNCj4+ICsgICAgZGV2aWNlX2NsYXNzX3NldF9wcm9wcyhkYywgY3hsX2Fj
Y2VsX3Byb3BzKTsNCj4+ICt9DQo+DQo+PiAgIHZvaWQgY3hsX2V2ZW50X2luaXQoQ1hMRGV2aWNl
U3RhdGUgKmN4bGRzLCBpbnQgc3RhcnRfbXNnX251bSk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9wY2kvcGNpX2lkcy5oIGIvaW5jbHVkZS9ody9wY2kvcGNpX2lkcy5oDQo+PiBpbmRleCBm
MWE1M2ZlYThkLi4wOGJjNDY5MzE2IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNp
X2lkcy5oDQo+PiArKysgYi9pbmNsdWRlL2h3L3BjaS9wY2lfaWRzLmgNCj4+IEBAIC01NSw2ICs1
NSw3IEBADQo+PiAgICNkZWZpbmUgUENJX0NMQVNTX01FTU9SWV9SQU0gICAgICAgICAgICAgMHgw
NTAwDQo+PiAgICNkZWZpbmUgUENJX0NMQVNTX01FTU9SWV9GTEFTSCAgICAgICAgICAgMHgwNTAx
DQo+PiAgICNkZWZpbmUgUENJX0NMQVNTX01FTU9SWV9DWEwgICAgICAgICAgICAgMHgwNTAyDQo+
PiArI2RlZmluZSBQQ0lfQ0xBU1NfQ1hMX1FFTVVfQUNDRUwgICAgICAgICAweDA1MDMNCj4NCj4g
RWl0aGVyIHRoaXMgaXMgYSByZWFsIGRldmljZSBjbGFzcyAod2hpY2ggc2VlbXMgdW5saWtlbHkg
Z2l2ZW4gdGhlIG5hbWUpDQo+IG9yIHlvdSBuZWVkIHRvIGNob29zZSBzb21ldGhpbmcgZWxzZS4g
IFBDSSBtYWludGFpbnMgYSBiaWcgbGlzdCBvZg0KPiBjbGFzcyBjb2RlcyBhbmQgY3VycmVudGx5
IDB4MDUwMiBpcyB0aGUgaGlnaGVzdCBvbmUgZGVmaW5lIGluIGJhc2VjbGFzcyAwNWgNCj4gKG1l
bW9yeSBjb250cm9sbGVycykNCj4NCj4gaHR0cHM6Ly9tZW1iZXJzLnBjaXNpZy5jb20vd2cvUENJ
LVNJRy9kb2N1bWVudC8yMDExMw0KPiAoYmVoaW5kIGEgcGNpc2lnIGxvZ2luKQ0KPg0KPj4gICAj
ZGVmaW5lIFBDSV9DTEFTU19NRU1PUllfT1RIRVIgICAgICAgICAgIDB4MDU4MA0KPj4NCj4+ICAg
I2RlZmluZSBQQ0lfQkFTRV9DTEFTU19CUklER0UgICAgICAgICAgICAweDA2DQo+DQoNCg==


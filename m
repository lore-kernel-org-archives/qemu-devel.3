Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E322CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 16:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFx0r-0002zo-Dj; Mon, 03 Nov 2025 11:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFx0h-0002ye-UG; Mon, 03 Nov 2025 11:02:24 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFx0X-0007Yy-B0; Mon, 03 Nov 2025 11:02:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITEvcQuUNtO8hdyas/JhVS9BkHXlySQ9FzTA/YjmlvER/gtY3DR1Gsu7prfBI3lOXHmWTCS/mofe5gvIxj9Y1sCMKcrK7zzvYC3ykJ7pBTJWB009AVCSHQ8wEHWQB0hOqcd1emMgK0qeORMRLnUQvS9HRglJ+R//2ygpLc0K0Rjd7SZFzz+ChKL4MbijZkVaVaZ/vcF15nGSQdBXU6iPNGcX7yJh+j3SzSMkyqOmma4Y9qyi0QpsPQrSNX0dv4LO6Htc3IjPneA2Np5xR/g2ADUQHUZAgN2w6Hy9QQQq8QuAyWoA7oQ0wgUVPmcRNbz0ED6XZiyAnz6NlsLbytY2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDgjAlyMwg0N5wG00FAug+V0dDo91g1TIvUGxjhOQRQ=;
 b=CfRU7z8fG3wHXRuFAToqX8vUkjGemc1BxofdytH02wMnqg51BaDYKHh+GKsVkzzT6v1NkGooc+pByLsX4nqzIVuT9QFvxUs60bqavY0QDRUP0R6YWvHzxjFiWMHN3zfIFsNjQ8YRH4IYZErwwox/k7jTxJ65mmnIs2zC8s1SPYlx9SJSm86L1BNtfHDRXtkcMwjXhFHvY8/142A2r1wgy1s57Ps0lCShkmGLe8tI2LLYF4cr1WvSFHbParafLSJYAVYbblLW6BP1i7skCcRaER1s1bd5I3LICLIjYSJD4PklY1bo50Pgq//t8jbAi8iAMlP15JNCjs3xclBt7wu07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDgjAlyMwg0N5wG00FAug+V0dDo91g1TIvUGxjhOQRQ=;
 b=nC9Jonz2krY33RUpb/VI8BLgN7f+NEeaQKEEcit/rYLO+Hk1mMYr0a/N7+gt0JaKrqYsiwmjyHk6qWJkL9Lm8eJdCCF0DzoDsYGZo61N7Pu2621HSCSQVArucZGag05ROz06WYd1qIKPne06HUJd2FXCVIJetL7BmnQFf1a80uGjgXD6Y/6ReOzv6sv15cpmWy3sr5uZQsfyZpA+nImK7gxuzdM8ShfnKHsbs/DY+4jpXGpGyZg2QldaWxwoNmRwTsydhRa+HhSVjaqk+CsTIsEyn+3CI4ug46TBrNKpOOkmcpecfHkWSpf9WOZ8+ZY+xkFl2U4iqg5PM1XcQpgR6Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 16:01:51 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 16:01:51 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 21/32] hw/arm/virt: Set PCI preserve_config for accel
 SMMUv3
Thread-Topic: [PATCH v5 21/32] hw/arm/virt: Set PCI preserve_config for accel
 SMMUv3
Thread-Index: AQHcTNJHSrXTfRrwAkKTjDCVJFPwHrThGtGw
Date: Mon, 3 Nov 2025 16:01:51 +0000
Message-ID: <CH3PR12MB75482767ABD0E4DBDA3BFF18ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-22-skolothumtho@nvidia.com>
 <28dd6856-71ce-445c-9b9c-d4b6502a92bb@redhat.com>
In-Reply-To: <28dd6856-71ce-445c-9b9c-d4b6502a92bb@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB8581:EE_
x-ms-office365-filtering-correlation-id: d0c03ed2-48a3-484c-8d02-08de1af24d75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WWdLWFJWUUU0OHB2ekc0NXNlRyt4U3lxeDZXOUI4YXlvVEhDc1JDN0ViMnRP?=
 =?utf-8?B?Z1N3eXJiMmlYMm5lREhESmhuMkgxSDh3RWgzejdmOWQzSGhXNnpHemcydVhS?=
 =?utf-8?B?Zk1icWJpTTdXcy9Wdjk5YTNES3crdWk0TUNCWUdCRGlVRjZRVkgxRFgrbDEy?=
 =?utf-8?B?dkV0MmhyQWZJdlB2SDZieWdpZ0hwVXZ6ZEQ5Tk1FeE53WElqOWF0NTdBVjg1?=
 =?utf-8?B?VXA1akVMd2Q1UVhwUmNqUG9PampPSys4bVZicWQ5RTQ3MWl2MjJpajY0YjFa?=
 =?utf-8?B?UTFaN01iRUJLWU1JVmlzNkMrVlprUDA1dmZqalZXZFpneGZxK2pkUmhHMFZh?=
 =?utf-8?B?V0k0d3BhWlFBTkhrK09pbWQ4REsxL3VxSTZQaUFoazVLeUJLUUJRSlFuK1c5?=
 =?utf-8?B?ZllHeFcvMVRyeGxCNTBqRjV1aVVTUy80WFN2RUxzcWhzVzhCaXNkR0laallG?=
 =?utf-8?B?U09qSCtsVjVnc0FhZEM2RExyZ2hQTHBMTk15M2t2WGIzZlFyRldDVEltaVhT?=
 =?utf-8?B?V2MvMWJxbWRPSFg3NGw5YlIzMGpoWkNSOEd1NFg0dC9iS3Rncmw4eThYdU5S?=
 =?utf-8?B?QmdzbStKZThOMlYyM1hUUjZ3MzJ3aG1qWndpQVMwVmZKMVQ5RFBJTkFTRS9O?=
 =?utf-8?B?a1g4VXdreGVpYkFkcTFyWTB1TGNMRmFhZXk2dXFiYjVoeDFPZjVVUnRyTnNy?=
 =?utf-8?B?bWhQbVFtMzA3ekZzUFlJNkR3NEczelF1czhJVExVRGpRUlRSQ1pwSEM4aEVE?=
 =?utf-8?B?aUhzNUpRRWFVdlB0NkZNQ2dOQWJ0eVZIL1lIK1RHNVJGemh0VWJQMU9kak4x?=
 =?utf-8?B?RjdLVWFzUE1sSDNKRDQ2YlBveDNuYXgwQlZiVk5Qd0M3NDFOMUI5bE4rUndt?=
 =?utf-8?B?eW84WUdrYU83clE3VE1LbG51b0dkeHphSlhqK1JVc01BQXhzWlhQMXhhZkIx?=
 =?utf-8?B?RWNQL1ppZlpHWWhiMFdDZ05yRFk1Y1ZtbENmZWppNDR5Ky9TYmZta1I5aGRs?=
 =?utf-8?B?SVFSK0NHOW5yaHZoS0JKVGpwWnJxK0QzQVI3S1ZPYUdHKzh0b1djbWlxRkNm?=
 =?utf-8?B?Nmd4dllIV0Flbk9tc1RtNE4xN0FwRXozQ080bFdIMUpDN3lyMXN0NTllZExm?=
 =?utf-8?B?YjA0cVpSamVZNG9sSE5yNXJ5S3ZUOGovWElweEdmdDRqS3RFdE1HWUxuMzFx?=
 =?utf-8?B?SmFRV3VMRHBKYy85V0JEMmJVeHprOEwwYnRheTNQdFY5NXB5MHB4aGxUQU1y?=
 =?utf-8?B?cU52U1NjeWxEc3RETWtPenp5T05sMnB2Mk54SE5VTGF5LzlRL2tSR3JXUHRB?=
 =?utf-8?B?d1k3Vk8xM0w1NmRncE4zZ3ZPNGs2RjM5cXg1ODRrYkk2VTlPaHNuMTAxcGN4?=
 =?utf-8?B?TzFpa1lIT1ppSUg2UlFENkVQdEdSR1Rod0VMcWk4a2VXaGJEbzFnRXdLdU1L?=
 =?utf-8?B?aWJoNjdaL3dtNjFpekl1NnprSzUxR2pra1ZvSkxXUW42RzFBQkhMSVVBN09o?=
 =?utf-8?B?TmwzT2VzeFRCVHdaTlpweUdzTGR3YlQyT1Q1cklWTWRJYkNIQUpvaE4wTzVR?=
 =?utf-8?B?bmNTK1hoV3lKSHYyT05YVUtNZE9laUg0WHNva2cySnFjanJSZSsyZDUrUlpK?=
 =?utf-8?B?d3o3djdzZE12NG9DTVR2YmFXV29PTGJjTXJGQ0tYbHUzRTluZ0lCckhOS2tI?=
 =?utf-8?B?OGwweU9DOWs3cUFydU4wQkFXM1A5NkFORGZzdkRiV3ZQTWlvQmpXY1Qwb08z?=
 =?utf-8?B?ck5MVDVhckJua2VzMjRvMlFxazNTNlNJR09VN1owZUY2RUJscEk4MzRQa0JR?=
 =?utf-8?B?Szhzc2RDTFlXbjNtRXpNZHgwcExZazFKRTllVzFjMVR4bFRoOEx3bnlCdTBr?=
 =?utf-8?B?SVZLMzhUU20yYzBkZVNua1MwRWJGUDhrc1BXa29ud0E0WGpzVU1kY0JHTEc2?=
 =?utf-8?B?VlBlYXMzdjduNmRwa2FvYVM0MlhPK0FqTGg5K1ZtZE9MUURYai90MjVKZUpn?=
 =?utf-8?B?MGJTMktJbFlqclFDY0lUTzZ3YUZLbWFIendXVFNMMmNxU0Z2dzRPVDJ6Ri9i?=
 =?utf-8?Q?Zfs2ZS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGtBM08zcWlSSC8wYkFBVTdHa1Ztd1dOUWtVdEgrNm1CUHcxUGFKZk5WU0xZ?=
 =?utf-8?B?UThLNWZnSGhqZGxQWjMxQTZTK3g4cDJaYmd5LzJWNlJrTWVHM09MVFJ0dldO?=
 =?utf-8?B?NnptZ2lFK0pxR2ZsL1FvRGJXMU8rc1JETzBGMy9TMTE3TVBIQytmcURiSU1v?=
 =?utf-8?B?VGlJNVZSenZuNE9oMkw4ODNEYVBMU1JFMVVDVGRabE5wTWI4OTZ1VXlsSnhz?=
 =?utf-8?B?endJSElKazBzN05EbVQ0QnJlb1B2cFI0a3NOTlhMUW9oUHlEZSs5MnF4TVpz?=
 =?utf-8?B?TVpITXpoTlUvdkwxdjNLNWRDbCtnRHgxU0kvOGRnbGdOS2JCYjZFcjJDVmQv?=
 =?utf-8?B?cStBaEtxczc2QmdvWENWSDl4V3REOWV3ckhZT2kzOFJ4dFg2U2xsVUJYLzVH?=
 =?utf-8?B?VXg0dEIzdlM5T2RnL2pNbFM4WUlJVTNBWDE2T2J0VE5nSFZmZXo0dmhnbVVj?=
 =?utf-8?B?eU9IdzdHRW5WZXBuRmFESjA3YWtXQi9xMDJIbk9DRnBYRjdHbjBzd0d2UW5I?=
 =?utf-8?B?Z0MzL1BFMHU2YmVtbnhKaDVCSk1HNUxlMzlvR0xBY1d4Y3dSajRlZUlJSzRB?=
 =?utf-8?B?SVB5MmovR0ZuN09CdCtRajUwdGJreE94aUtuTVdXY28vMWYzdEVkcWJJZlZ4?=
 =?utf-8?B?by9NRXVtMXAwbTBnVkZlMnRPVU5nVEtheTlNSzk2U1VrblFOZ3VrOGhQd0Nk?=
 =?utf-8?B?bjBQSys3NEdNN2xZWG1mUkhWd3dwSVR2U3dwekFNVFhsNng5b2JKM1Y4dWdi?=
 =?utf-8?B?M1ptUWs1czZPc1RLKzN1OHVRRkNBUEJ5dE1WclVpUnk3NUdLSHV5N2dpMEll?=
 =?utf-8?B?NFZkRkkxL2IrclBsdGp5Y0gzMGZtOEt1RFppOVE2SlJsalFrU25STlVsUkds?=
 =?utf-8?B?VlpBOEIrbWYwWXhuUmhvWElXWTU0ZUoyc3VPSTB3dGpsbU9SbUVuNVZSd2M0?=
 =?utf-8?B?bXpOQ1BycW1NNk0rVXdkZ05USERYRUt1ZVQ5RXZKdWUvdk8ydnFWeFI5MTU2?=
 =?utf-8?B?MldpaUFLZFgva3J0Z3AySGZEY0xOVWtyVGRxSm1TL01CeHIzRE03MG83VFov?=
 =?utf-8?B?WXlRaHZaa2ZKMDNKNkNkVXN1bmdNSmZqU3ZIUTliOXBPZUpRa1EwbTRVTkx6?=
 =?utf-8?B?Q3c4OUozbWdCYlpidks5d0ExdVpHcWN2RDdqdHdVbnkzaU5IU2dicWtLQVFl?=
 =?utf-8?B?V0tXTmlFVU5qajFOZVE3TlR4ZGFQUkpNZEJoVE4rZlJWVWRMK0xNR0JaeXc5?=
 =?utf-8?B?NUtDWDlJbi9MdnFMc0FNckVJd3BqT2F2VlUrMldBVmhyd04vZ2h2aG1icUJL?=
 =?utf-8?B?VkluVW9LUUlLdGx2L05QbEFwTVQ1QkZQZmZWL3NIZTI3dGJHUzNZaTNnakhw?=
 =?utf-8?B?Z25qWDRMeWtLMDZ4MmYvSWVGQU43MTBkUFJIS3Q2LzJjK3hVVHJtdzJxWnp6?=
 =?utf-8?B?RWpkSEFmaDJCL2prQ1hESXdoSFU4Zi9pdVF4OHd1UWdxOHQ5N3lHZ3hjYVNm?=
 =?utf-8?B?ZkQ0ZThKeVRCOWFWOUNNcUt1cWljMUk3NVVKY0ZDdVlTNzhUQkRLQjl5WFUy?=
 =?utf-8?B?Rk54dlJ6OGxleUJBbHoybExwYVkyT0puTFQ3TmNIZWQrRFRZcHVnRVlpcGVO?=
 =?utf-8?B?SW45N054UFlWeWY4YjZYSmhuS0pXOTNqWWtsbmdIYXVwbUJ6cXhpeEkwYSt6?=
 =?utf-8?B?YUpEdUp6TmQ5ME5oUXQ3T3FOWVM3dDJGemNnclNkRHh4Q3p6ZzZaTWgwZnRz?=
 =?utf-8?B?Wmo4THk4RUxhRm95SFRPREZ3a3pTQXdUR3lTOGZ3aklnZGtxL3pCNTd2eHo5?=
 =?utf-8?B?S1lSRDRVS3ljdjAzQnI2QWk0bXJnL2pndjVOajJ1TWV6Z1hyOW1JbHV0R214?=
 =?utf-8?B?TEJNWUNYYWc4WXVYMGhjMEprZ3loRUg4eDB0OEdqQUFSQ2R5b2JFcHdJWU9i?=
 =?utf-8?B?cUtGYUwxcFYxTzRYK3VQMFE3RUtRRVBpRmdqcmRXY2Y5TFBaRzRHc25UUktn?=
 =?utf-8?B?ZmFCQWxZRUNUU3FHYmsrZEk1dlloN0VWM3pncmpsWXREZWF4aGpxbUFSK3dl?=
 =?utf-8?B?VGFpK0FNOEV2TVE3SG80U1A0R25tMnJDanVWOFpFQ3RYNXRjTnZ5cXNSeHBa?=
 =?utf-8?Q?ihUArwN1n70cSAAsebTi/T6xr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c03ed2-48a3-484c-8d02-08de1af24d75
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 16:01:51.6547 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kSohxGJN+nWMkVgzhecgMTTDuQ4uyKef88WyBaK5k6aZzVH55VIi3eFrOgbbJOjK0YtA07imk9DhNMD5iFUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwMyBOb3ZlbWJlciAyMDI1IDE0OjU4DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFy
bUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE5pY29saW4NCj4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsNCj4gTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2No
cyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IHdhbmd6aG91MUBo
aXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3ZWkuY29tOyBqb25hdGhhbi5jYW1lcm9u
QGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsNCj4gS3Jpc2huYWthbnQgSmFqdSA8a2phanVA
bnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAyMS8zMl0gaHcvYXJtL3ZpcnQ6
IFNldCBQQ0kgcHJlc2VydmVfY29uZmlnIGZvciBhY2NlbA0KPiBTTU1VdjMNCj4gDQo+IEV4dGVy
bmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0K
PiANCj4gT24gMTAvMzEvMjUgMTE6NDkgQU0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4g
SW50cm9kdWNlIGEgbmV3IHBjaV9wcmVzZXJ2ZV9jb25maWcgZmllbGQgaW4gdmlydCBtYWNoaW5l
IHN0YXRlIHdoaWNoDQo+ID4gYWxsb3dzICB0aGUgZ2VuZXJhdGlvbiBvZiBEU00gIzUuIFRoaXMg
ZmllbGQgaXMgb25seSBzZXQgaWYgYWNjZWwgU01NVQ0KPiA+IGlzIGluc3RhbnRpYXRlZC4NCj4g
Pg0KPiA+IEluIGEgc3Vic2VxdWVudCBwYXRjaCwgU01NVXYzIGFjY2VsIG1vZGUgd2lsbCBtYWtl
IHVzZSBvZiBJT1JUIFJNUg0KPiA+IG5vZGVzIHRvIGVuYWJsZSBuZXN0ZWQgdHJhbnNsYXRpb24g
b2YgTVNJIGRvb3JiZWxsIGFkZHJlc3Nlcy4gSU9SVCBSTVINCj4gPiByZXF1aXJlcyBfRFNNICM1
IHRvIGJlIHNldCBmb3IgdGhlIFBDSSBob3N0IGJyaWRnZSBzbyB0aGF0IHRoZSBHdWVzdA0KPiA+
IGtlcm5lbCBwcmVzZXJ2ZXMgdGhlIFBDSSBib290IGNvbmZpZ3VyYXRpb24uDQo+ID4NCj4gPiBS
ZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29t
Pg0KPiA+IFRlc3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlh
LmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jIHwgOCArKysrKysr
Kw0KPiA+ICBody9hcm0vdmlydC5jICAgICAgICAgICAgfCA0ICsrKysNCj4gPiAgaW5jbHVkZS9o
dy9hcm0vdmlydC5oICAgIHwgMSArDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LWFjcGktYnVpbGQuYyBiL2h3
L2FybS92aXJ0LWFjcGktYnVpbGQuYyBpbmRleA0KPiA+IDhiYjZiNjA1MTUuLmQ1MWRhNmUyN2Qg
MTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jDQo+ID4gKysrIGIvaHcv
YXJtL3ZpcnQtYWNwaS1idWlsZC5jDQo+ID4gQEAgLTE2Myw2ICsxNjMsMTQgQEAgc3RhdGljIHZv
aWQgYWNwaV9kc2R0X2FkZF9wY2koQW1sICpzY29wZSwgY29uc3QNCj4gTWVtTWFwRW50cnkgKm1l
bW1hcCwNCj4gPiAgICAgICAgICAucGNpX25hdGl2ZV9ob3RwbHVnID0gIWFjcGlfcGNpaHAsDQo+
ID4gICAgICB9Ow0KPiA+DQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogQWNjZWwgU01NVSByZXF1
aXJlcyBSTVJzIGZvciBNU0kgMS0xIG1hcHBpbmcsIHdoaWNoIHJlcXVpcmUgX0RTTQ0KPiBmb3IN
Cj4gPiArICAgICAqIHByZXNlcnZpbmcgUENJIEJvb3QgQ29uZmlndXJhdGlvbnMNCj4gYXMgc3Vn
Z2VzdGVkIGluIHY0IHlvdSBjYW4gYmUgbW9yZSBwcmVjaXNlIGFuZCBleHBsaWN0bHkgc3RhdGUN
Cj4gDQo+IF9EU00gZnVuY3Rpb24gNSAoSWdub3JlIFBDSSBCb290IENvbmZpZ3VyYXRpb24pDQoN
Ck9rLiBXaWxsIHVwZGF0ZS4NCg0KPiANCj4gPiArICAgICAqLw0KPiA+ICsgICAgaWYgKHZtcy0+
cGNpX3ByZXNlcnZlX2NvbmZpZykgew0KPiA+ICsgICAgICAgIGNmZy5wcmVzZXJ2ZV9jb25maWcg
PSB0cnVlOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAgICAgIGlmICh2bXMtPmhpZ2htZW1fbW1p
bykgew0KPiA+ICAgICAgICAgIGNmZy5tbWlvNjQgPSBtZW1tYXBbVklSVF9ISUdIX1BDSUVfTU1J
T107DQo+ID4gICAgICB9DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LmMgYi9ody9hcm0v
dmlydC5jIGluZGV4DQo+ID4gMTc1MDIzODk3YS4uOGEzNDdhNmUzOSAxMDA2NDQNCj4gPiAtLS0g
YS9ody9hcm0vdmlydC5jDQo+ID4gKysrIGIvaHcvYXJtL3ZpcnQuYw0KPiA+IEBAIC0zMDkxLDYg
KzMwOTEsMTAgQEAgc3RhdGljIHZvaWQNCj4gdmlydF9tYWNoaW5lX2RldmljZV9wbHVnX2NiKEhv
dHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwNCj4gPiAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4g
ICAgICAgICAgICAgIGNyZWF0ZV9zbW11djNfZGV2X2R0Yih2bXMsIGRldiwgYnVzKTsNCj4gPiAr
ICAgICAgICAgICAgaWYgKG9iamVjdF9wcm9wZXJ0eV9maW5kKE9CSkVDVChkZXYpLCAiYWNjZWwi
KSAmJg0KPiB3aHkgZG8geW91IG5lZWQgdG8gdGVzdA0KPiANCj4gb2JqZWN0X3Byb3BlcnR5X2Zp
bmQoT0JKRUNUKGRldiksICJhY2NlbCIpPw0KDQpMb29rcyBsaWtlIHlvdSBwcm9iYWJseSBmb3Vu
ZCB0aGUgcmVhc29uIG5vdyDwn5iJLiANCg0KQW55d2F5IGZvciB0aGUgcmVjb3JkLCB3ZSBkb24n
dCBoYXZlIHRoZSAiYWNjZWwiIHByb3BlcnR5IHlldCBhbmQgDQppcyBvbmx5IGludHJvZHVjZWQg
aW4gMjUvMzIuIFdpdGhvdXQgdGhlIGFib3ZlIGNoZWNrIHRoZSAibWFrZSBjaGVjayAiDQp0ZXN0
cyB3aWxsIHJlcG9ydCBlcnJvci4gVGhpcyB3aWxsIGJlIHJlbW92ZWQgb25jZSB3ZSBpbnRyb2R1
Y2UgdGhlDQpwcm9wZXJ0eS4NCg0KPiANCj4gPiArICAgICAgICAgICAgICAgIG9iamVjdF9wcm9w
ZXJ0eV9nZXRfYm9vbChPQkpFQ1QoZGV2KSwgImFjY2VsIiwgJmVycm9yX2Fib3J0KSkgew0KPiA+
ICsgICAgICAgICAgICAgICAgdm1zLT5wY2lfcHJlc2VydmVfY29uZmlnID0gdHJ1ZTsNCj4gPiAr
ICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgIH0NCj4gPiAgICAgIH0NCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2h3L2FybS92aXJ0LmggYi9pbmNsdWRlL2h3L2FybS92aXJ0LmggaW5k
ZXgNCj4gPiAwNGEwOWFmMzU0Li42MGRiNWQ0MGIyIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUv
aHcvYXJtL3ZpcnQuaA0KPiA+ICsrKyBiL2luY2x1ZGUvaHcvYXJtL3ZpcnQuaA0KPiA+IEBAIC0x
ODIsNiArMTgyLDcgQEAgc3RydWN0IFZpcnRNYWNoaW5lU3RhdGUgew0KPiA+ICAgICAgYm9vbCBu
c19lbDJfdmlydF90aW1lcl9pcnE7DQo+ID4gICAgICBDWExTdGF0ZSBjeGxfZGV2aWNlc19zdGF0
ZTsNCj4gPiAgICAgIGJvb2wgbGVnYWN5X3NtbXV2M19wcmVzZW50Ow0KPiA+ICsgICAgYm9vbCBw
Y2lfcHJlc2VydmVfY29uZmlnOw0KPiA+ICB9Ow0KPiA+DQo+ID4gICNkZWZpbmUgVklSVF9FQ0FN
X0lEKGhpZ2gpIChoaWdoID8gVklSVF9ISUdIX1BDSUVfRUNBTSA6DQo+ID4gVklSVF9QQ0lFX0VD
QU0pDQo+IFdpdGggdGhvc2UgY2hhbmdlcyB0YWtpbiBpbnRvIGFjY291bnQNCj4gUmV2aWV3ZWQt
Ynk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCg0KVGhhbmtzLA0KU2hhbWVl
cg0K


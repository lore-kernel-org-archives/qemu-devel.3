Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D81CD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 13:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJXCM-0001LV-RU; Thu, 13 Nov 2025 08:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vJX3T-00082U-Hq; Thu, 13 Nov 2025 08:08:04 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vJX3O-0001IT-JK; Thu, 13 Nov 2025 08:08:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgX/JwY/Bof6CqNW9Q/RJRbRZgsau5ud/aNvoHcdPOoTdmg2pCLd/6JeM2o8eLTcDCC63Cntjc2wUlf13797bCjpS6HY1I5L4MFEY2HrIGri6qkBstZwCNXfF30SW2PmX3obHIHRZSUO8Mln1gqJPJYyDXU0QQZGq33e5iTLjb6HLZRjYWYaQuhm4X3ajt9UHgF/QFgdnp8TSYcIoSzlyG1pdaGa9OwCQz6id0q9FNuIrY8dFTkPzg3ge93FArcmuPFLpaR+mbj0GviKUbgPsYqSh3DQK6un40lfa9Clsp51N5bB/4lYrq4GxdA0vuea6f/zZYCYYl3cpP6iGXgdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GL1XPVh7vpshLmijidX6Su7N8IkKMVj1VMCyvMxyY4=;
 b=pKlm8FisNIBKvsB8OHgi8LGnR8vaWNUNbDdrGo+PG35heMKZZ8/rgb500JBMWZoJ6JcWE/Mv7YXTaThlAubz2sNrrRlzjy1jJ7KuwSxoYb/81mHwOShUZ9BOG55v0HrMO4qP9Ekl6goPNFMixPzL7Yz2yco1N7W5Y281+sa1pI2tl1s28D81Hj5Sy8/DL615nFBNLAOqcrENXY9r/NaWJRqFDmdHdu3HQ78nKJ86aHQoH0M5/uhnPgRqMx4DUFazLaVQRdntlDFRWIGrGKYLB20HW1iNaxuhP/Ig12tWKdZwPd620X3+abEbYCs2QJkT8jTGcbJLYliIF6inyT1EZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GL1XPVh7vpshLmijidX6Su7N8IkKMVj1VMCyvMxyY4=;
 b=iEmgCuPBvLW+JQ2qM3TeO+gft9q/4Ler7S7wUg2rkZ8meNk+pBM+OyoKqH4aZ0AQYS7iADzoh8wS34Z1s7S6GNZGlvOSCBhSz7x/cCRKX+RvGNRmDCDqzVkAsNTLAZxLjEE29SAWrOwWpd/a5UFb7zdGIi6hPbepjNqVULpE1qZBv6YG9aiOLD3pHTIKYLzLG5i8OxAdOhVx44UFqU7B5mm80uFTePcJh/JdcMp3bS+IYVixqlBLRLn1xvDvQTc9HiHMrkCVKu4DRQHD0BsQ9jwTe5liXLklEpy9DjiN1XofVxMS6Nxsk+tu5r9AJonJPYa0e14iVN0QY5AA+0GOkw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 13:07:50 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 13:07:50 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [RFC PATCH 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [RFC PATCH 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHcTmv+D+Tap4vojUiu3uBvQy8ZFbTwjQgAgAALHnA=
Date: Thu, 13 Nov 2025 13:07:50 +0000
Message-ID: <CH3PR12MB75481A1E302DD0C6F5FC195EABCDA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251105154657.37386-1-skolothumtho@nvidia.com>
 <20251105154657.37386-5-skolothumtho@nvidia.com>
 <CABQgh9HzB9yCD_rYjGFX5ZC7RX2e2iVu_FZPU2Vm-kuf3jfm+w@mail.gmail.com>
In-Reply-To: <CABQgh9HzB9yCD_rYjGFX5ZC7RX2e2iVu_FZPU2Vm-kuf3jfm+w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MW4PR12MB5604:EE_
x-ms-office365-filtering-correlation-id: 0075e4c9-9bba-4562-8040-08de22b5a602
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L0hhU01CbE1qbmJlbmhXMEJKT0lZNWI1dmEyZDQ3NXlEMktjZldNTmhwV0Nw?=
 =?utf-8?B?WGNWcHFxZitVeWxLYzdVbFFOR1I2dU1FbUVNbVVYOVU0OS84UjNCQ3VoWmJQ?=
 =?utf-8?B?TzJ4blJiU25DN0lCRmw4aENVTEpwUHQ3akxCUWs1L3BVcjBNd0NXbUZNNVZn?=
 =?utf-8?B?YnFvOEdTZzhtNDl1b0VUS25iRjY0NzZhemNvcjhNdGFDUkYwNXp5S0wweFdJ?=
 =?utf-8?B?SHBtYTRKV0hTajRLcEM0cEhqcSs5Zysxcy8xZXpnS0ovQW9LcC9pa0txZGYz?=
 =?utf-8?B?WnV4YUY0WUZSZWxEOFNXRXlPWldCbHR5VGliM01yM1plV3JtdDNUVHRidWRX?=
 =?utf-8?B?RU5WS0ZIYTZ4VTR2bkl1REpaK3FjellOZjI4YmNXUjRYL2pQUVZDenk2U1Jl?=
 =?utf-8?B?S2RVUEJ6WkphajNtSXlBdlRubVpGRGdGTHR2TUJLQ21PYzYzWjVFRng3NFRu?=
 =?utf-8?B?QUswSmhYa0E3VEJSRTh2Qm53ek1PMzNyL1BxaExDbCt1b0dLRGpCT0lpZHNV?=
 =?utf-8?B?cHliRGZ3Tm5WTm1keVBPblFmUUI5bk93YTAwZnNYWlQ0ZEN3K29VOXB4L3NI?=
 =?utf-8?B?VEtsems0WnhCeGNWRElVY3VHTDFlWGJzUnlwZndZRStwZU1PWkZLNnd0M2dp?=
 =?utf-8?B?SVJRbzEySDJDbDVuQ3BpMUhrQ0hlMGdsemlxVXcxSEV4RE5NKzRmWWdGVkhG?=
 =?utf-8?B?MXFDK2h0Tm94VlN3cWlzbGxhT0RUWm1obTFoTGxZeitVYk5FYlZrcUdreVVp?=
 =?utf-8?B?SWpkT2d4YzJ6K2dDeW5hWlJ3d21qZmFKZUNSdGZ3UVIrSk96STJSZjEzc3Fo?=
 =?utf-8?B?K2Vtb2J6QUVVL0RxS01VRXN5YlE4blZlVW5uYVVlWU0rb3FpZ0ZDdnNXNk1j?=
 =?utf-8?B?RFhSQkJlVDg2NzlOblFRZXdQbWRmdG10akFic2RLdzdjc2pITFZlbUxmS01H?=
 =?utf-8?B?cndxcXNSYlNDNzhwTDh0QVIyemdTN2RWQ2RLcmRIRnhzYW1BWExVTjJYVTBr?=
 =?utf-8?B?dTlIYTN4WDhXQlFJaXJtZm44SUpXUm45dDNMYm5nS04xdFJvM1MrVDVKelVU?=
 =?utf-8?B?dVM0OGVyR1VsaVNKS1ZZYjlzc1dnUE5mdmdzb3Z5OVA3Q2ZCQTA3RW5kYTVk?=
 =?utf-8?B?Qk50Vk5HZzVCZjFWSHNWbTdpQVVXV1JCZ2o1ZEdpVTUwM05kazBvYVJHYWo5?=
 =?utf-8?B?WnhEUHRYeTZaU3NIWThXUk1ETnRHKzlQVnNGRFU0VS9qUFZXRitERVF6L09r?=
 =?utf-8?B?bEYwcmRnOEZFa1B0RlArN0YxVVdvQnhGb2pJTmo0M0tHOHR2WnE3UE5iUkIr?=
 =?utf-8?B?UG41Znk2bU1hcWp1RVlvN1RVZ01Jcytndkg3T1NGVWkvVVpjK2NtK255cmpO?=
 =?utf-8?B?aDU2RkFlVEgvTW9kekVVNkxkc2FKV0ZPdkMvK0JITGk4LzBvRlFiVzVPRldS?=
 =?utf-8?B?Vk42TkpHR3JKajZlRWhKdTUvWGxTMVpLZ2hMVldIOFVjQXE0K05rM1hXVUZv?=
 =?utf-8?B?Z0R0Y0RDRURRVjlFVTlxRy9XakVjZGs4K0xHOFRseHhMUU9qQXBwei9UeGQ3?=
 =?utf-8?B?NEtiejNDOEtqcUlBQVpwQ1ZXdkdKd0lDR1NhM1poTEVlVmY3TTVCcWQ5UU9K?=
 =?utf-8?B?dHpmb3JWQUFXNHc0NzRxTTJtNlE1RDVDUWpYeW9PaHlhWHN4a1lCdjRKc1cr?=
 =?utf-8?B?R2hUWG5ubjdJc2JwbkdlenRHek9xeVlZK1MvSTdIQVVPS0dzSHFzYUloUWFq?=
 =?utf-8?B?ZjdtNUxNRUdVNzVHZVBIMHNsRDcvTS9pVWg1UXE2NVlFTnFqMGhQSEJuTTgw?=
 =?utf-8?B?aGpHVDlvZDdoRVk3RWdHcWY0Mm45WmVCUVo0K1p0aVI0YXowMUVYbDNCZkZv?=
 =?utf-8?B?cFZSMFZPeml6MmxucW53NlJDbWFUdFBYc0E5RGl0OFk2azRaeFpXUzZhWHFK?=
 =?utf-8?B?OHF3MlJaSFozWUVuSFl6MGdISE5BTDE2dU5PODV6eXpQWDZvMWIvbkRHNzhU?=
 =?utf-8?B?SStIaEh6cWhUcm4vbEo2TjVnVUp3L1J1KzRMRGNoczFaNnBuVmpFeXVFMkdM?=
 =?utf-8?Q?SwFg0B?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFRmdnlabWYxdHl5NHNiSXJtVmpNNjBiSnhZT0xOSVg4YnZTMlpsbnBKSWd0?=
 =?utf-8?B?NDRwa1VjMlc5R1dVajJLa1AvbEtBd1FTMXk1dnVCN0IyVnVZOHZ5UnFpSlRy?=
 =?utf-8?B?bTJKdStvM1BGaUllL3hWZ2ZBNGRFLzQyUGdVQkJSbHVQaE96dXBwYUw2dk1q?=
 =?utf-8?B?M1dkSkorUkoxZmc0YUpvVktoZFBUcjRNbWZOa2Q2Slh1UlkrSjVRSWYvdzc5?=
 =?utf-8?B?OVhVQ3B1VTRjQWFxQ1dKNHg0N0J4MmpHSVhFWmNnK3llZ3JsMzlZeHBLNjNm?=
 =?utf-8?B?cUl4MlpXaFRlUnJ0S3NRdCtqL0E5UDVRZ2x4Q1hnWmxBMkZJc01HakEvbnVU?=
 =?utf-8?B?b0VpNXhHS3lSaUdMT05WczNDVVVNM0JFdWJCaWc0c24yOHl2Z3hJL1hLVUph?=
 =?utf-8?B?S0tkOXpKRTN1MWU4bXQwazFpc2t6b0E0c0d1WVFDTlBvSzd3N2lPZkVxS1FD?=
 =?utf-8?B?dXUwY0hTWTRvQyt3ejJ6UytiR0JzcDd4YU9URlhmV2EyVGZ3cy8zZ1doQWgy?=
 =?utf-8?B?SHhzdFlmQlh1aytuOXNGWTAzVGhUK3Q5OFUzbnN2LzY5VXJXd0hsd1paNS9S?=
 =?utf-8?B?UE9scldhR3pzOHczNm1pcVN3Y0xrY250ZmlMNkF4V0dpZndkUE1BVXNKWDNU?=
 =?utf-8?B?VTFaZHQxVWxOaXc5M3lnenZ2aGMvM3A4M1BWcjRUYW9Ydy9PU2dETUtNekdU?=
 =?utf-8?B?YUduUTBMNnlhRWl3TVhqd2hzQlpkaHY0SHU4SkFPWEN4ZGZNM0VwN3RMTCtw?=
 =?utf-8?B?N2Mrdm1jYVZ1N3pLV1pQVEp5c0xzbFVSRUFZdHVoS0pURmRibTg4ZmdSWnEr?=
 =?utf-8?B?MWVhMFdpVTVUcTZ1UW5TL1ExZ2J1VnVEaDdRYkpPMlNjUnZBaE5hQ01WL3F0?=
 =?utf-8?B?R214OHNXdlZXa0ZFdFZ2czVDVDVnelFkK0lETjRFM1VYVksyNWNOVW40WGU4?=
 =?utf-8?B?TThnYURubkNvUUhFRHlXYTRDWC92aWJFek5EbXdnVXlSZDR5WUcxbzF4ZGFl?=
 =?utf-8?B?anVXVEtZblZBZkYzYzF3ZUdFdVRPdzNUWGFOMnp0eklOWlM3M3FqYlhiMUlH?=
 =?utf-8?B?T1AxU2ZhSStCZTFsZXdCeVUrdzRlaWcveEs1U1QyWU5pRU4wd1EvbEhiUytN?=
 =?utf-8?B?OUNNTS9nRXdNOUp4Tk9JTXphTzJXUWkrclVPSm9DR2lIMVpFbmdjMllPbHlK?=
 =?utf-8?B?TXB5cDlRQ29PYklsVU5aeUtoMVVoWVFsQWphRXNZV09oUkRIWkQ3dHBwNWRN?=
 =?utf-8?B?NkJ1NUxXT09GUnlyVlJqUENPMmlTQkw4Z3krOVY3OHR1TmJSN1hGUi9zMWh1?=
 =?utf-8?B?QWtsUmpCNGlYNnErNzhMWUxaQ3NDL3R4TUtoWlc2QnBYdTFKM1hyWGUxZzlP?=
 =?utf-8?B?aWJJNys2TVFvaTlGcHFhY3MwcnVkMFFFbWs0MFZ2Y3pqdS84UGtKdE8zNHRS?=
 =?utf-8?B?M0hiSGE3UEErOFRDckRhOW0xbEJMTUFnNUliVEQxUjBzVG9wVkJVY0tQSFph?=
 =?utf-8?B?em5Obk9oZ0poWThLc1ZHbEU0MzRvdXd4ckdBN0crcnEvQytnbm9mZS9BWU90?=
 =?utf-8?B?NXZNcE5leE50Ti9LM2NSaHpmWkFNa0JaQ3YxM3NSdllXSEhCM0JKcnM2eWNn?=
 =?utf-8?B?THhQaGR2Tzc3amNuNkpLOWw4aGY4K0RTM1BOZ3dlMU83UENhTTluRmE5Zm43?=
 =?utf-8?B?Nmc3blk0MUhOM3NFT24yK0xPdFZSOWdYdVRwRnd4dGtlYVJyeDFkbTlXU2xh?=
 =?utf-8?B?Vkd2OTA4VFVydkZzdzA3UEVLL2tKbVJlcktWQmJqZzEwdjVNQlVFcVZQTHFW?=
 =?utf-8?B?R2I0RW0zVVVoNW5OUVNCSXpqZlNzbFlqbXJVOXB3WklramN4dVN1VDZ2Yjg1?=
 =?utf-8?B?akc1aTgzVExsZDM1Rk4rRURPZS9iUHpsSWEwWm5BckhjelM0ZWZDa1NxRlQ0?=
 =?utf-8?B?dkRMK21FMktKVVB6VW5wVWc0c3RaZUxjZllBVUJ3Lzc0SFNBMjA3ay95SDhB?=
 =?utf-8?B?TXU3cHRFaHNWM3ppTGxFd1ZKOFNCMUxnZVBxZThxb3pydEdSdkMrZlJhcUo3?=
 =?utf-8?B?Y2JKTXFwTUhSVG5vc044WXlFY1ZNQmFncDIzS3N1YnIxYXJXaTdvSGg5OWxK?=
 =?utf-8?Q?vySPkGGMx66LKKBAkoUYM+sG8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0075e4c9-9bba-4562-8040-08de22b5a602
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 13:07:50.2480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wL6WZFZ8SJ0bM9J8nXmCWFNiRHmyPDnuSPri9xejASclcEO757kJcUelCjwFuSc/VtfHibRzcKB/8/U7x335Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SGkgWmhhbmdmZWksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhh
bmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogMTMgTm92ZW1iZXIg
MjAyNSAxMTo1OQ0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5j
b20+DQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+
IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBOaWNvbGlu
IENoZW4NCj4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0Budmlk
aWEuY29tPjsgTWF0dCBPY2hzDQo+IDxtb2Noc0BudmlkaWEuY29tPjsgam9uYXRoYW4uY2FtZXJv
bkBodWF3ZWkuY29tOw0KPiB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IEphc29uIEd1bnRob3Jw
ZSA8amdnQG52aWRpYS5jb20+Ow0KPiBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCA0LzRdIGh3L2FybS9zbW11djMtYWNjZWw6IFJl
YWQgYW5kIHByb3BhZ2F0ZQ0KPiBob3N0IHZJT01NVSBldmVudHMNCj4gDQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
SGksIFNoYW1lZXINCj4gDQo+IE9uIFdlZCwgNSBOb3YgMjAyNSBhdCAyMzo0OSwgU2hhbWVlciBL
b2xvdGh1bQ0KPiA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW5z
dGFsbCBhbiBldmVudCBoYW5kbGVyIG9uIHRoZSB2RVZFTlRRIGZkIHRvIHJlYWQgYW5kIHByb3Bh
Z2F0ZSBob3N0DQo+ID4gZ2VuZXJhdGVkIHZJT01NVSBldmVudHMgdG8gdGhlIGd1ZXN0Lg0KPiA+
DQo+ID4gVGhlIGhhbmRsZXIgcnVucyBpbiBRRU1V4oCZcyBtYWluIGxvb3AsIHVzaW5nIGEgbm9u
LWJsb2NraW5nIGZkIHJlZ2lzdGVyZWQNCj4gPiB2aWEgcWVtdV9zZXRfZmRfaGFuZGxlcigpLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52
aWRpYS5jb20+DQo+IA0KPiBTdGlsbCBkb24ndCB1bmRlcnN0YW5kIGhvdyB0byB1c2UgdGhpcyB2
ZXZlbnQuDQo+IElzIGl0IHRvIHJlcGxhY2UgdGhlIGZhdWx0IHF1ZXVlIChJT01NVV9GQVVMVF9R
VUVVRV9BTExPQyk/DQoNCk5vLiBJSVVDLCBJT01NVV9GQVVMVF9RVUVVRV9BTExPQyBpcyB0byBo
YW5kbGUgSS9PIHBhZ2UgZmF1bHRzDQpmb3IgYW55IEhXUFQgY2FwYWJsZSBvZiBoYW5kbGluZyBw
YWdlIGZhdWx0cy9yZXNwb25zZS4gVGhlIFFFTVUNClNNTVV2MyBzdGlsbCBkb24ndCBzdXBwb3J0
IHBhZ2UgZmF1bHQgaGFuZGxpbmcuDQoNClRoZSBWRVZFTlRRLCBvbiB0aGUgb3RoZXIgaGFuZCwg
cHJvdmlkZXMgYSB3YXkgdG8gcmVwb3J0IGFueQ0Kb3RoZXIgczEgZXZlbnRzIHRvIEd1ZXN0Lg0K
DQpTZWUgaG93IGV2ZW50cyBhcmUgcmVwb3J0ZWQgaW4gIGFybV9zbW11X2hhbmRsZV9ldmVudCgp
Og0KDQppZiAoZXZlbnQtPnN0YWxsKQ0KICAgIHJldCA9IGlvbW11X3JlcG9ydF9kZXZpY2VfZmF1
bHQobWFzdGVyLT5kZXYsICZmYXVsdF9ldnQpOyAvL1BhZ2UgZmF1bHRzDQplbHNlIGlmIChtYXN0
ZXItPnZtYXN0ZXIgJiYgIWV2ZW50LT5zMikNCiAgICByZXQgPSBhcm1fdm1hc3Rlcl9yZXBvcnRf
ZXZlbnQobWFzdGVyLT52bWFzdGVyLCBldnQpOyAvL1RoaXMgc2VyaWVzIGhhbmRsZXMgdGhpcyBj
YXNlLg0KZWxzZQ0KICAgIHJldCA9IC1FT1BOT1RTVVBQOyANCg0KPiBBbmQgb25seSBmaW5kIHJl
YWQsIG5vIHdyaXRlLCBvbmx5IHJlY2VpdmUgZXZlbnRzIGJ1dCBubyByZXNwb25zZQ0KPiAoZnJv
bSBndWVzdCBrZXJuZWwpPw0KDQpZZXMuIEFuZCBJIGFtIG5vdCBzdXJlIHdoYXQgdGhlIGxvbmcg
dGVybSBwbGFuIGlzLiBXZSBjYW4gc3RpbGwgdXNlDQpJT01NVV9GQVVMVF9RVUVVRV9BTExPQyBm
b3IgcGFnZSBmYXVsdCBoYW5kbGluZyBvciBleHRlbmQgdGhpcyANClZFVkVOVFEgIHRvIGhhdmUg
d3JpdGUoKSBzdXBwb3J0IGZvciByZXNwb25zZXMNCg0KVG8gbWUsIGZyb20gYW4gaW1wbGVtZW50
YXRpb24gcGVyc3BlY3RpdmUsIGJvdGggdGhpcyBGQVVMVCBhbmQNClZFVkVOVFEgbG9vayBhbG1v
c3Qgc2ltaWxhci4NCg0KQE5pY29saW4sIGFueSBpZGVhIHdoYXQncyBwbGFuIGZvciBwYWdlIGZh
dWx0IGhhbmRsaW5nPw0KIA0KPiBCeSB0aGUgd2F5LCBjYW4gd2UgdXNlIHZldmVudCBpbiB1c2Vy
IHNwYWNlIGFwcGxpY2F0aW9uPyBub3QgaW4gcWVtdQ0KPiBlbnZpcm9ubWVudC4NCg0KSSBkaWRu
J3QgZ2V0IHRoYXQuIFFlbXUgaXMgdXNlcnNwYWNlLiBPciB5b3UgbWVhbnQganVzdCB0byByZWNl
aXZlIGFueSBldmVudHMNCmZyb20gaG9zdCBTTU1VdjMgaW4gdXNlciBzcGFjZWw/IA0KDQpUaGFu
a3MsDQpTaGFtZWVyDQo=


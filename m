Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D11CE7A8C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 08:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJpay-0003V3-T7; Fri, 14 Nov 2025 03:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vJpaf-0002fK-4p; Fri, 14 Nov 2025 03:55:33 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vJpad-0003a3-34; Fri, 14 Nov 2025 03:55:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/FaTG70O3mRZ0gjdQ/aRNt7r/Thg3wvdKSx20UzZzC8VyGHPOxGqDK7vB6+9FCX8W/Fo9eE+kCn4HUCMOd9AN2ugNAt1graiHzUo7+H+BjVSP4RFHg2dBLyHWF5OdtVsIzWpaDWPWuWoXXx5yiwcu6D8RUvhy8OaiwE3PCsZaJHQPcM+WOVpT1n0gEstG1dRxH1y3QahS3FVL1yVFjk+kZTDmeassacJcUt3k+eYyfeTz3UbPrPTs8CvdvjHWmgUJXTaAFsU6M8xnZer6bbgZ2cRsLYIZ5divslxLcGqJcSWn4vmebC5Erm5stp6EwwAr5ffz2NUbOgeYnzASJ+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xp6dGHAI6dXowtCRP9t+VRmGsj/lERoyoNzJkRgGH/M=;
 b=CAgZ7OQ+q+oPLzV7ghTlj0/B1X3LtKurcHtOvdtncDgvKmoBqAvDBLmHz/GCrVBQwZ40PuHWDu9dzdgbdWZSLnti+A24y4657YSyc5Y86qx/0Zi6BLpWwCgCdXSo2ektv65N/yCpfhLbEBM4Yix0+thTgzBk5sJtGZrm64hh4wIGxo+M84nmpDO9bIOu3LR/hdIrvw4W437acF71VLZQwDQJbZqdI1abdBdj3dgxZaruh7qf/3AGnk+274SX7C/en2rI71M+fZ9+/stG4JzL/hyrrXyxCvuY77hzu15GVkb1ytt9sXoyEyOSZVBhKyW8oMxNkwh7foXAl/awcOJa0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xp6dGHAI6dXowtCRP9t+VRmGsj/lERoyoNzJkRgGH/M=;
 b=KDC+i62JYRG3aed5STUhE0fUxb5TqrVgxJ6ISAU1HhcZwY4MUj9J0Yv/lBbfSql7ROQuT/lxMi7KYztm93cpwS9IbM2M1xInJKvXPO72SG9e+KVTqmzuqWL01RAL7r8CHP0tpeuHlCm1Cbpvrlqdt0YZki1EZm6Vob62gX1ruWB077FN39Hfsqu4j/waRNsfqgqo4dg2hSFOL/ugGOULuOpTnAEaoBDZSqmHLRKZn+4E05ObMt14IRd4zjcugYuRrFe1V9VhAiA0/zKt6+qDtiwXTh5uyFqhbiYoeCbjDbQQi2fLMQx2eEmr6L1v7eVQ8u7BP8o52ZgZ5w/mcZo1tA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 08:55:19 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 08:55:18 +0000
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
Thread-Index: AQHcTmv+D+Tap4vojUiu3uBvQy8ZFbTwjQgAgAALHnCAAFU3gIAA+9YAgAAA15A=
Date: Fri, 14 Nov 2025 08:55:18 +0000
Message-ID: <CH3PR12MB75486EE7C6F8556160D237BEABCAA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251105154657.37386-1-skolothumtho@nvidia.com>
 <20251105154657.37386-5-skolothumtho@nvidia.com>
 <CABQgh9HzB9yCD_rYjGFX5ZC7RX2e2iVu_FZPU2Vm-kuf3jfm+w@mail.gmail.com>
 <CH3PR12MB75481A1E302DD0C6F5FC195EABCDA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aRYY5eBnlw46nt2f@Asurada-Nvidia>
 <CABQgh9FYE6Jfm2iV7xGrydS5Yyk7L-VgArL4jOz=bCSdy5+HiQ@mail.gmail.com>
In-Reply-To: <CABQgh9FYE6Jfm2iV7xGrydS5Yyk7L-VgArL4jOz=bCSdy5+HiQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ1PR12MB6028:EE_
x-ms-office365-filtering-correlation-id: 23557b4e-6b60-4679-bb6f-08de235b8967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OTJrc0l4SEpkZ2U0ZDJseXdFRFE5a1g0aDZSNU1SSHhGaXFCdm8rKytja3pz?=
 =?utf-8?B?TmpyMzlKczUzQUNTZ05QN1NXL2ZYK0k2NGRjb1JwRW5DRVIwdUl6MnZ3UXdO?=
 =?utf-8?B?bVJIZnluaGJ0RmtyV1phQ21lL1MvYWhlRCtaM0o1aENnNXVLZi95SEhrVnUw?=
 =?utf-8?B?SGVsVVRGZkpscWsrVWU0NkVUaldOMXJIb09HL0lMNWFjdVUyT1JVOEZUN3dY?=
 =?utf-8?B?anRKS1k3bEx4Vi83N0pNQ1dlNEZLOGdhTWltMkp5ZTd5d0E5OEhJblhmdGdB?=
 =?utf-8?B?ZU1FclZLazA1M0djWkx5elM2TWQ2UW1ITVhmN3l6b2xyT1Ryd1JPUkFpcmtK?=
 =?utf-8?B?bklWajNTTjBrMkxqdHVhYnFzVm11Q1h1YXJvd2oxdkpBeU5PVlpuZWV3S1FW?=
 =?utf-8?B?ZGM4OTIyK2RJMjVaMWhRQmFGWmIxNUViTkdpU2c1eFAyN2Zpd1ZNcXhKdnI2?=
 =?utf-8?B?Q0hDV3lYQ25vL1JYb2ptQzVuaHd3azFuKzlMSkZDNDVhUFNlTGRqZ21yc2Nt?=
 =?utf-8?B?aDVBSFEybWczakY1Q1RCaGtqMVQ3Wk9PQVRiUWl0MGs1UDVIbWZaL25uOExk?=
 =?utf-8?B?VlIyd1FoTC9wZEREU3ZOclg0TmJoSnVleXE3L3NZYjVwZFc4SGZuMmNQQnVt?=
 =?utf-8?B?YXhhb3czTjZDQUZEL0UyLzdlOUFGSGFYNXJzUjF0eVY4UW5ma1VjK1NCaFNO?=
 =?utf-8?B?ZysvWGQ5UW1zd1NyZ2VRUzRENVlkU3pJZ2drOU1TR1ZXWGdYY2RkcGlRNUt1?=
 =?utf-8?B?UWxRU3oxUXhBcUNlcEQ0OVlsbm5vYkdkYTRQNy82U0JJNWFUMFY0QmdYbjBG?=
 =?utf-8?B?M25RU1pJUkJuQVUzRXJGVC9EdzZiWk10MEFlQ3YzVXBIMGR3K09LbXFHTk1Q?=
 =?utf-8?B?cEVsdVJacVY1NFR1dlQzOVNYMDkzREFZSlU0ZnVsR2w4M2NMbWJZQW9DNDIz?=
 =?utf-8?B?ZnNhY1ZIc2RiR0JtQllWQ2JLYU5zZjkxaTlLUWt2cjU4bzlTZWM3TlVpdCtT?=
 =?utf-8?B?SDBnZytjMjdWRTZITE1uLzJleWlKaUpIUVFaZ08wM3poSEZwSkkyZW5wU3FW?=
 =?utf-8?B?bWZ5RzFHYkgrRzA5L1duMGZXN05tZUNGd1g0Zld4WmtBNzhvUGlQMTJOVEcz?=
 =?utf-8?B?ZlBxb2xDNm1FaXJ1NVhjdXFxck1SSUpqQmZPN3VRcTNhQ29HRWFIK2V5dkI3?=
 =?utf-8?B?YzBKRXU0YmxuS2dlTmszOGgwS1IvbnN5a3JodWJuL1ZybnBLWVp0c1JIOUNt?=
 =?utf-8?B?eU1YUkplczNEUFgrY1NTbllpMHZVVmIwZmpKeHZwOWJRUm1ONmxuNjIxSG9Z?=
 =?utf-8?B?WTlocGNRTjUzMTJEdUo2bWVwSk9GM3ZFZkpwdkk2ek5jTGRMZjFWaXBOZEJD?=
 =?utf-8?B?MHVIWEI1NXdNejAwZmtCc1FJVFd5UjlxaGt3UVdQRXFwd0lxTFV1WTlhS2lP?=
 =?utf-8?B?RC9aWTFCZ2FNellxVkwvT3FjQzE0b0M2cnBRa2NKNUxwZEZTWlUrcEVsbzdK?=
 =?utf-8?B?NFpocFI5Q0RvM3h3K2dQRzlvY1B0NEg0clNxakQxVW81R2dqVmR6Rng1cXBY?=
 =?utf-8?B?cGIvc0ltNzBlRnlMOWZSb2phOS9TS29RMWgySy9zRU95NGJKWFIrSUxabHQw?=
 =?utf-8?B?NHpma0g1alZWM3dKeGZyUTlTWnVwZzBRUG5NV0dZdnpTRWJaekhhSndRMXNm?=
 =?utf-8?B?d1IrY1NPbVplMVZaUmZtUjlVVTJ6UW54T3ZDaXpjUmtkNVVjK2twVW5Udi9n?=
 =?utf-8?B?TWlPK2dJc2pQbllydnRNVG5tL3dSa1pGd1ZOSUdxLzcydVFGZk12Qzg0ZzhB?=
 =?utf-8?B?OERVeW5LOUxDRnBncFppcDVoRktJalZaV0JkdzB5K2llK2JYZHFHRllhazVx?=
 =?utf-8?B?a0xFVnFVMkFoaFdJNXZ5Zm1vMEtlWGQ2cTFaREl6czg2QyszdTVBenZmRjdl?=
 =?utf-8?B?RFM2elUrR1JjOEh0Qnh3Y3hQNGMyY0YxTlhmK3VWaDBOQ3JiUlpKU2pNcFRy?=
 =?utf-8?B?Z2xKMTVVV0ZqbVRVMzNHOFdITUcwSXRIdEFVQWJyQVowSjJ3SVNJWWIrVWx5?=
 =?utf-8?Q?roHB+N?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjhEMG9ET3dhcUgxNmhSd2lkZnZVR25zd09YTGVUUWg5SlV5eWN6QUxiNE00?=
 =?utf-8?B?cnNtRURvVzRCV3NET3FZSUl3Y2ZCR3ZXaS9iTjRtYUZlVFd2RWpEcnFwUzRk?=
 =?utf-8?B?ckVKVHQ3dlV5djVDYlBzV25MMzVRNXBpSFZ5QVRidUw4RWYrMEw4QmVueTdI?=
 =?utf-8?B?dGFlZDhVOWxDSzBVSEFRZ00vcTlsSTV2UThEV3N0RXJVTmU5R2xEbG1JOEpT?=
 =?utf-8?B?RGJlWXFjczhzeEpHK2RwbkR2UzUwNU1OdUZnQVE1SFc2WlczMFNib0lMVVFn?=
 =?utf-8?B?Z01zcjNCbyt4KzBZbllESU9JV3g0N1NKeVFUL0dmaDJ2ZHF1QnFSMjhxMFFV?=
 =?utf-8?B?Rll3dTV6cG5GNGpzSmhnRzNPMGFLYlY5bkEza0E4Q0VGL1NBZXdES1ZpUkNy?=
 =?utf-8?B?aGJxSkhZV3hBVk5INE1BK0FRQkZ3R0Y5em50ZWI1bXJCQ1lzemJpOWxseUJt?=
 =?utf-8?B?a1RJYk9KcVRZV0pRWTRCOXFnenYyUnRsbjJwd3FnZXRqWVZtY25tMDBZRlJE?=
 =?utf-8?B?TU9Jakd1SE1pT3dCRlQyYXZDZ2FwNXJhVHJ5YjRJcG52UHhkQWtsVmxLcnYv?=
 =?utf-8?B?RkUwVW1kd0l0N2JWRnZhNnpraTRYaFJlNm51cVNxM216SjFLNlU4N2s3VTNt?=
 =?utf-8?B?bWxESHBLWnlHYW1tNU02c0dSWlNpVE53T3pjMlNCSnBRSmU5d2RrVXZ2SERt?=
 =?utf-8?B?akVYY3FERVFvaU9ESlVLdWVsSmJRRnBHOHhmY25aMVhuOFZsdnN4OTFEWHND?=
 =?utf-8?B?ZFl1VXdZQ0o5YTdrV3pWdlVlWUgzcFFSQXNkRC9iMURTTHhYTzZMOE1aOHV0?=
 =?utf-8?B?QlA2dWw4ODRCNGRSNWcyNEFneDlQcW5MSGhGS2poQXZKQnBVa0F3Q0IwQVZu?=
 =?utf-8?B?NkxhLzR5Nnp3eWxCdFdKTHBYanFzNHlNQk9oZEJwcmtpdkJ1c3ZrMHNLUTJr?=
 =?utf-8?B?UHB4b0VGQndJZzY3V2FYd3R2REtTb0xwd0ZJVE81NlUveXVXRXEycVBpSUZV?=
 =?utf-8?B?LyszRFcvUTdlenREU1Bmazl6cW04NHNJbkJlMjBRTlNCK1JsdFFrRGhNQ0ox?=
 =?utf-8?B?ZnltTzByKzBxSENVZERFeEF4QWJTdDNiMlh1MksxVkhVWHlPaG13UmIrUmNC?=
 =?utf-8?B?cXF3MXJNQllPdkhaVHlCRHNtZFlxRDRYczJjcW1pOEdmemsvKytBQmJ6ZTZu?=
 =?utf-8?B?K2ppZlNWTEZ5ak9WaFZHWU4xNVhhTjdrOVY5Z3FFZk5pQ0Y0K0dDaXBiRHJs?=
 =?utf-8?B?WXhtZ3pMcmEvMHgreXV1eHJjTXhsODNhM0tBc3NPZWVyV1BKcHFZWTAvY2Ro?=
 =?utf-8?B?SHdMTWdBNkZpYTlhSVdpekhuTGFJaWtFd3BLVHVZS0w4SHlwTGo3SHdmUUdl?=
 =?utf-8?B?MkE3U00yeHh5ZU5RTmluTFRlWGtnQVVmWmNWZnhzTkRDUVBJSC9BRGt2alZi?=
 =?utf-8?B?em9JWVdjdW9pQ3M2RHQzUnJIdFYzMDQ1NTFqV01PK3pOYVAxMElSTVIway84?=
 =?utf-8?B?R09FSWdmeVhPV2Y1b3pvNnFsbzRPNmlVcFZERWE5MHNieGRVMUJ4VGJsZ1RW?=
 =?utf-8?B?YnVNTTBzSXIycjdjS1VHY1dVQWhEWjFPUzR5Vkwzc3FGWi9YWkhRZGJIMTBM?=
 =?utf-8?B?ZmdoTUV0OVlKWGx3MFRaZkJVWDFTOXI4enovUks2MmlPRk10UHZjNktyaHFP?=
 =?utf-8?B?Z3VVOUVqTEZqdVdYcCtIQnJBdzVVeTlRMUN2a2V0MWUxbUJ0VmpjVnh6TlQv?=
 =?utf-8?B?OGM0dVU2MG51SEF6OXo3emtKL1RhZ2pvVnNtQzM4QkFGWi9rVTl6VEpKczVi?=
 =?utf-8?B?Z3FqMHorSGpyK3FZN3o4KzZwMVNCSWZGYkRIUEFWRmwwTXVOdDZ5ZGViVVFC?=
 =?utf-8?B?R0xCdnd2bFlvcXU5aEZDTWdpMGhvVEpyemZrTzVDTkVhUWpxZzNmM1llczAx?=
 =?utf-8?B?cjZHTUxBWDVQTDJtRVpQTktBaWplRnNRRERJSmpFaVFIWkRhL2xMV2MrVWhH?=
 =?utf-8?B?dXNHNlhTdkNObG5uNEpjdURNMDNiV0VJM0trR0JYTkFJQVE0QzBZRjlCSDN5?=
 =?utf-8?B?Zis1MHRGVGtnZFVIMGQ1WlI3a1lCZ2xWTkRCcVFiSEtCdjJyVnJrWU84OENl?=
 =?utf-8?Q?YN5cZ1Wn6MaJKgXWT7iuZuRr7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23557b4e-6b60-4679-bb6f-08de235b8967
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 08:55:18.6828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aZU3LFznWSy8GCM0OiZ24UEccvoLOLJbGH0rptpPrn6v/fdUpevRWk4+aGZ5/Ig0/Kv6fx1OPo4mm0sVqQdT5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhhbmdmZWkgR2FvIDx6
aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogMTQgTm92ZW1iZXIgMjAyNSAwODo0NQ0K
PiBUbzogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiBDYzogU2hhbWVlciBL
b2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBhcm1Abm9uZ251Lm9y
ZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207DQo+IHBldGVy
Lm1heWRlbGxAbGluYXJvLm9yZzsgTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1h
dHQgT2Nocw0KPiA8bW9jaHNAbnZpZGlhLmNvbT47IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNv
bTsNCj4gemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPjsNCj4gS3Jpc2huYWthbnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtSRkMgUEFUQ0ggNC80XSBody9hcm0vc21tdXYzLWFjY2VsOiBSZWFkIGFuZCBwcm9w
YWdhdGUNCj4gaG9zdCB2SU9NTVUgZXZlbnRzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIEZyaSwgMTQg
Tm92IDIwMjUgYXQgMDE6NDQsIE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBPbiBUaHUsIE5vdiAxMywgMjAyNSBhdCAwNTowNzo1MEFNIC0wODAwLCBT
aGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIDUgTm92IDIwMjUgYXQgMjM6
NDksIFNoYW1lZXIgS29sb3RodW0NCj4gPiA+ID4gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPiB3
cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEluc3RhbGwgYW4gZXZlbnQgaGFuZGxlciBvbiB0
aGUgdkVWRU5UUSBmZCB0byByZWFkIGFuZCBwcm9wYWdhdGUgaG9zdA0KPiA+ID4gPiA+IGdlbmVy
YXRlZCB2SU9NTVUgZXZlbnRzIHRvIHRoZSBndWVzdC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRo
ZSBoYW5kbGVyIHJ1bnMgaW4gUUVNVeKAmXMgbWFpbiBsb29wLCB1c2luZyBhIG5vbi1ibG9ja2lu
ZyBmZA0KPiByZWdpc3RlcmVkDQo+ID4gPiA+ID4gdmlhIHFlbXVfc2V0X2ZkX2hhbmRsZXIoKS4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNr
b2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBTdGlsbCBkb24ndCB1bmRl
cnN0YW5kIGhvdyB0byB1c2UgdGhpcyB2ZXZlbnQuDQo+ID4gPiA+IElzIGl0IHRvIHJlcGxhY2Ug
dGhlIGZhdWx0IHF1ZXVlIChJT01NVV9GQVVMVF9RVUVVRV9BTExPQyk/DQo+ID4gPg0KPiA+ID4g
Tm8uIElJVUMsIElPTU1VX0ZBVUxUX1FVRVVFX0FMTE9DIGlzIHRvIGhhbmRsZSBJL08gcGFnZSBm
YXVsdHMNCj4gPiA+IGZvciBhbnkgSFdQVCBjYXBhYmxlIG9mIGhhbmRsaW5nIHBhZ2UgZmF1bHRz
L3Jlc3BvbnNlLiBUaGUgUUVNVQ0KPiA+ID4gU01NVXYzIHN0aWxsIGRvbid0IHN1cHBvcnQgcGFn
ZSBmYXVsdCBoYW5kbGluZy4NCj4gPiA+DQo+ID4gPiBUaGUgVkVWRU5UUSwgb24gdGhlIG90aGVy
IGhhbmQsIHByb3ZpZGVzIGEgd2F5IHRvIHJlcG9ydCBhbnkNCj4gPiA+IG90aGVyIHMxIGV2ZW50
cyB0byBHdWVzdC4NCj4gPiA+DQo+ID4gPiBTZWUgaG93IGV2ZW50cyBhcmUgcmVwb3J0ZWQgaW4g
IGFybV9zbW11X2hhbmRsZV9ldmVudCgpOg0KPiA+ID4NCj4gPiA+IGlmIChldmVudC0+c3RhbGwp
DQo+ID4gPiAgICAgcmV0ID0gaW9tbXVfcmVwb3J0X2RldmljZV9mYXVsdChtYXN0ZXItPmRldiwg
JmZhdWx0X2V2dCk7IC8vUGFnZSBmYXVsdHMNCj4gPiA+IGVsc2UgaWYgKG1hc3Rlci0+dm1hc3Rl
ciAmJiAhZXZlbnQtPnMyKQ0KPiA+ID4gICAgIHJldCA9IGFybV92bWFzdGVyX3JlcG9ydF9ldmVu
dChtYXN0ZXItPnZtYXN0ZXIsIGV2dCk7IC8vVGhpcyBzZXJpZXMNCj4gaGFuZGxlcyB0aGlzIGNh
c2UuDQo+ID4gPiBlbHNlDQo+ID4gPiAgICAgcmV0ID0gLUVPUE5PVFNVUFA7DQo+ID4NCj4gPiBZ
ZXMuIFdlIGNhbiBzYXkgdGhhdCBGQVVMVF9RVUVVRSBpcyBleGNsdXNpdmVseSBmb3IgUFJJIHdo
aWxlIHRoZQ0KPiA+IHZFVkVOVFEgaXMgZm9yIG90aGVyIHR5cGVzIG9mIEhXIGV2ZW50cyAob3Ig
SVJRcykgcmVsYXRlZCB0byB0aGUNCj4gPiBndWVzdCBzdGFnZS0xLiBUaGV5IGNhbiBiZSB1c2Vk
IHRvZ2V0aGVyLg0KPiA+DQo+ID4gPiA+IEFuZCBvbmx5IGZpbmQgcmVhZCwgbm8gd3JpdGUsIG9u
bHkgcmVjZWl2ZSBldmVudHMgYnV0IG5vIHJlc3BvbnNlDQo+ID4gPiA+IChmcm9tIGd1ZXN0IGtl
cm5lbCk/DQo+ID4gPg0KPiA+ID4gWWVzLiBBbmQgSSBhbSBub3Qgc3VyZSB3aGF0IHRoZSBsb25n
IHRlcm0gcGxhbiBpcy4gV2UgY2FuIHN0aWxsIHVzZQ0KPiA+ID4gSU9NTVVfRkFVTFRfUVVFVUVf
QUxMT0MgZm9yIHBhZ2UgZmF1bHQgaGFuZGxpbmcgb3IgZXh0ZW5kIHRoaXMNCj4gPiA+IFZFVkVO
VFEgIHRvIGhhdmUgd3JpdGUoKSBzdXBwb3J0IGZvciByZXNwb25zZXMNCj4gPiA+DQo+ID4gPiBU
byBtZSwgZnJvbSBhbiBpbXBsZW1lbnRhdGlvbiBwZXJzcGVjdGl2ZSwgYm90aCB0aGlzIEZBVUxU
IGFuZA0KPiA+ID4gVkVWRU5UUSBsb29rIGFsbW9zdCBzaW1pbGFyLg0KPiA+ID4NCj4gPiA+IEBO
aWNvbGluLCBhbnkgaWRlYSB3aGF0J3MgcGxhbiBmb3IgcGFnZSBmYXVsdCBoYW5kbGluZz8NCj4g
Pg0KPiA+IE5vLiBJIHRoaW5rIFBSSSBzaG91bGQgYmUgZG9uZSB2aWEgRkFVTFRfUVVFVUUuDQo+
IA0KPiBEb2VzIHRoYXQgbWVhbiBGQVVMVF9RVUVVRSBuZWVkcyBhIHJlc3BvbnNlLCBzbyByZWFk
ICsgd3JpdGUNCj4gVkVWRU5UUSBvbmx5IG5vdGlmeSwgbm8gbmVlZCByZXNwb25zZSwgb25seSBy
ZWFkLg0KDQpPZiBjb3Vyc2UuIFBhZ2UgZmF1bHQgbmVlZHMgYSByZXNwb25zZSBhbHdheXMgd2hl
dGhlciBhYm9ydCBvcg0KcmV0cnkuDQoNClZFVkVOVFEgaXMgZm9yIGV2ZXJ5dGhpbmcgZXhjZXB0
cyBwYWdlIGZhdWx0IGV2ZW50IHRoYXQgZG9lc24ndA0KbmVlZCBhbnkgcmVzcG9uc2UgYmFjay4N
Cg0KSWYgeW91IGFyZSBhZnRlciB0aGUgU1RBTEwgYmFzZWQgcGFnZSBmYXVsdCBoYW5kbGluZyBv
biBEMDYsIHlvdSANCmNvdWxkIHJlYmFzZSB0aGUgb2xkIHBhZ2UgZmF1bHQvcmVzcG9uc2UgcGF0
Y2hlcyBvbiB0b3Agb2YgdGhpcw0KYW5kIGhhbmRsZSBpdCwgSSBndWVzcy4NCg0KVGhhbmtzLA0K
U2hhbWVlcg0K


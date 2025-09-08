Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D9DCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 08:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvXZZ-0000xd-0L; Mon, 08 Sep 2025 04:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvXZ4-0000kI-Gf; Mon, 08 Sep 2025 04:49:33 -0400
Received: from mail-mw2nam12on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:200a::60d]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvXYu-0005lt-O6; Mon, 08 Sep 2025 04:49:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ty6mZ0pN+D3aZcYvWPIbiQt6kCvOs/8rSNLh3VhVxH9S9qIKab6p6S9r3Oxl4lgPNspyr22zfSIKXo0bap3fg/Duxc64N+mwz779D61+yT4UxoHtxOk+0UHQbs7uaivJM+IKKah+4xPTMYjnuey7G31o/XjyPPQninNlBthPsO6DP0+J0zUbm7URA8/QyKnato7lEdwPCAt7mghj1tjC7e/vcfoMz5bMZ9dtnJUkUUdEf737QvM/m1RYFMMNaqpzJpBe5rKgJPqmGVKEfWVeRxmHGppLQfXP7UiCjGdXcPvd31lvwkahCEXKnVJlEnGjfSDZlvT0Sea/PiJvlPolsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq9HIcO8t6TfDvSw004mynMCo7OSAv+iqvqtNPkQcek=;
 b=ueDN7zWAHDmiCgG+wjltPnJbp3Xoa/agPf04acYx+T2qmC2PZFKjROnFSMr1/tYYuZicwl8lEk+LBtL8oR/tAUhFpbQ3QdWNJqXvYD3bXJZHhnsX9AtQE+L9mR0bYU5Zj03lGoCGNqngBIFsCqaSAg2r3DiR0pjqIlmBeTjmuy0RVUOOSa9ZaVDNubeEzjl0+z06RFTPkiJvalKYCfk3OEeNKM1Gfvec56KSJB908KEUS8c8OUjEpz/ALGg+aOo0E3lgH746p2tSJK+OOMD6Ly+EaemoCz+XviaB7CwPlnUHKS4XD9b4IHz8xclpRh5vdw8kJXWaAOxVspKYaneTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq9HIcO8t6TfDvSw004mynMCo7OSAv+iqvqtNPkQcek=;
 b=V+Hr4FF/NAPd4zsRi7i5lf19ttu3TE8glkVB5ShDTeygYD+4fHM3thFNUFo8uSolZQKEZy3tveHFDEq1NWr61R4l9+IYfFnmOONAYF9mcxtoz9Bl3UOcpSVxbHa2u2nSqGxD8u1Edc3daewOqZY1kDisXGqKFLl9f7gEMybq2lNBM9Hev1lNfVa5Yx8tZ5Y5CBa/DiOA76gP4I8wuqEGEY9e64cvQqpIMagpFJWv4J5hRYkRVekqtIrhmggLdbltqJLUqhmf+CT7ml4cl24ti8E9PBgZkUQONi6omBYKYZlIxczWuoSuTCmKalfOt/P9TKYTxKI3wwiTHsOpi8d+/A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:49:03 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 08:49:03 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 08/15] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Thread-Topic: [RFC PATCH v3 08/15] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Thread-Index: AQHcHkdfacBQsY1OVku1Az/3sIZP0rSI+3RQ
Date: Mon, 8 Sep 2025 08:49:03 +0000
Message-ID: <CH3PR12MB7548EB39DA22143E64D6919FAB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-9-shameerali.kolothum.thodi@huawei.com>
 <44b5f066-e419-4ed2-916d-f64b3c003213@redhat.com>
In-Reply-To: <44b5f066-e419-4ed2-916d-f64b3c003213@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ2PR12MB7821:EE_
x-ms-office365-filtering-correlation-id: 66634631-c025-4a3e-57f5-08ddeeb49011
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OHp1dlRQcWdUSGMrV1MxTFZlN0E4TS9qLzFwT2s2VjlFRDZqSGJ5dXprZ1JQ?=
 =?utf-8?B?T3lWT0pXTW5oYmVRN1J1anJiRFhTdndPN1Q2N3hXODU5REdYUm1ZdWlIb3Mx?=
 =?utf-8?B?eGdwSHJodUxtQnduNkFHcVlsSnM5MU0rZUNadXZoc0lzeVZVaEJSUktwWFpr?=
 =?utf-8?B?Z1Z6dTUrQlMzbkw4aWVvTEthSTBLR0ZGVDNZa0VKWlp5T3QrdUJ2QVRPYUt5?=
 =?utf-8?B?ZkZXVzVuRU1ENmhXckJaOHdHWUpMMkdWbUI1TmRjdWQ1QjdTSUxuZWhuK1lS?=
 =?utf-8?B?SWhUdUErY0Q4ZXJQN3ViVGVTL0lHcWtHSmtHT3krWmxMc0pmUkFpWEpVNTIr?=
 =?utf-8?B?cXhKKzB4UGl1L1pYWXlMbzRMT2lKRHQ4bDdKbElFTDRCcE9UTlVUTnFQbzJG?=
 =?utf-8?B?c0xIYytaa0tOOTlMcFJjV2pUNzQxeUZKeFZJRzNLcTMvZ0o5VE8xczlQYjYy?=
 =?utf-8?B?MXJuRFhkSXFBVTlmdVYxeDJCaExwcXg2c3ZkV1VpaDBVYWJxKzVzRllreXlV?=
 =?utf-8?B?LzdCczhvNGR6RW5mWjRzRVNSWUpNYjlORUpMV21TNTlhVkErajhtTk50dG9F?=
 =?utf-8?B?WTZJTU9zc1gzMVo0ODdwUG9GMEJ4S0g1TTZSOGRTV3RBMW5ibmo4alcrZG5h?=
 =?utf-8?B?VjVDYksyUjl6V0swWFlldnMyWkxsMjIxaU1JQXJqZDdtYlUvZnlubmkrZW9h?=
 =?utf-8?B?RS9obzUzQllxcUVFbTNKKytHelN6cXQ5N1dUVjA4cTZOcytpdU5Icm9vMU8y?=
 =?utf-8?B?SjZTNzcrTWJvbkMrUW1ZeTlOVUdxeVhYUEVydFFKb1B3Y3FLSmpMRGIwbE5h?=
 =?utf-8?B?Y1lYN0tNaDVsYnE4ZllaZldaVFFvYUJydS9HWXk2cS9wekZTU2NXRGNsVFVN?=
 =?utf-8?B?QkZvc20rQ2kyNDBHSGRmYytoNjlqRUVWRGpqZmhMSWh2K1pwaEVPSy9ybFh3?=
 =?utf-8?B?TXRULzFOOWVyT3N1MnZGaytkcnYyOHZWMTNxZlJ1Y3VuNjdyR09mK0xDQlRa?=
 =?utf-8?B?cHFHQytOd1YzV1dEVGhtTFl0akxFRXRFZU9WdldNRHhZeDM5QmFIdmV5eDV4?=
 =?utf-8?B?SmJHcGV2cEtwZGJ4eVhnaW1NSTJjejZxNmJlTksxSThpb1R6WWp3M0VqRW5M?=
 =?utf-8?B?NHBYM1IrTkxBQVZOUWJ0UzZrcnlSZm03SnB5dkIrSXViT0ZZbW45RUJLek9S?=
 =?utf-8?B?ODlsKzI0TWRjWWREUWY0Z3I4NHIxaUVOQnU0dFI4N1FWanBpd0xVYkZIUWdH?=
 =?utf-8?B?RXVpSnh6UWg5Z3VMZ2dsSVJqYUJqYXRzdUU4N2x6ZTRnSkdBekVRVmg4ODha?=
 =?utf-8?B?eWh6RklZS2V6MkVBdmdmNTNZK2ZoWHlWQmNrSVNVME9vV2o0bDVlQUF6elZL?=
 =?utf-8?B?TjQ2bklQcUZQWkE2Sk5iYXFZVGN6QlU1clBMdlc0bGtDQ1FVWmx2TXBmOVk3?=
 =?utf-8?B?bDdsczcrM1VkMVZ0b2t6ekJUdmgxb0ZKTW9aS0U1bzVLeXMvS2RNWmhhYzRN?=
 =?utf-8?B?SDRoM0lrVkpVbmxXbGtuSDJ2bUtWZ0xrMS9qM005L2JCa2Myd3hxOEwzV21H?=
 =?utf-8?B?b0xNNE5RWVMzMUI3bTA1TXJrby8wUFZDTXdyT094NnYxL3psdDlnblpZNlBh?=
 =?utf-8?B?c1kvVjB6S0RGMTJVUTRqb1MxZng2a2Z1SHZBR2NrSGFVVzE0WnEzL0ZPMkxz?=
 =?utf-8?B?NGhOZVd6WDhuRDVqYndQLzIxUzc2bXovZkUvZ3dSVmxteEkwL1VaOXVRVktZ?=
 =?utf-8?B?RVZVWlA4V3JETkp1L1RCVDEzM09Fd0pxeWNIWnIwaFR3UUJOWkoxNkFrWWcw?=
 =?utf-8?B?c25HbC9HUVQ5dzJhYnhjemdUK1BNODdRcUZPZWRFaWdUS2hKV3BnUTlnUk5z?=
 =?utf-8?B?T1AvTDdlZ1VLUzgvUFJyV3pSclRFY3Jmc2ROSEZuTkFPTDdhWG1tbVd5V3JP?=
 =?utf-8?B?MkZvKzVwek1jMkNleHdBT2FOeDhkOVQ2MHdnYjh0RHUxcWhqS3lQQUZZMmN5?=
 =?utf-8?B?eGJOb0VpVEF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0hubUNwR0l2OEtjZVhLZzhzQTVscW5RWXp0UDhzREVsWS9OMGxQSFVkd0h3?=
 =?utf-8?B?NWltZEhvYTNHTGZtR0dnaEx4TUJ4L3ZKcFIxMnl5ejV3NVVTM2h6eVNic2xV?=
 =?utf-8?B?Q1lKUXN4L0Zyay9HdjlveHA3MUcxeWpHTTNMODQxVmtxL0gyd08wVTh4cGVR?=
 =?utf-8?B?NnU1d3NpUFRpdU5DejBCODJFcjJ4YVdNK1pvNXBkVGJTT2tSSGVXbm4xd2xN?=
 =?utf-8?B?dFg0eU1UZXhFanZXTUlsazdMZnhoN2lmTkhtMkloK1dFWXVOeExzZTBUR0Vv?=
 =?utf-8?B?Nm5ZdEJ4djlrYzdQY2UvRyt6YmIxQWtCcDBzVGJXUkxQQkFDakZoSStmeDgw?=
 =?utf-8?B?eHgrNGNwbFRTNWdBb3pJcTdIdlR1em5zbm8yOXp4NG5Kd3E2NmNhWHpHRFNU?=
 =?utf-8?B?aFhRT0JNYzJ4TVpLdmVUR0JwVm1MWmxVWGZLaURFMVBxYk14YlE1ejZsaDVO?=
 =?utf-8?B?QlBKUjBFbU4zLy9WaVdRR0x1aDJQdUNxMDJGc3hBRm9aaUJMbnVxTHFLU3Vn?=
 =?utf-8?B?cXlOdmJJazVzL2NPVksybzNQMDVSQ1BFS0w5YjlWU1FaNVNSTGtjRmljZ3Vp?=
 =?utf-8?B?RS9LWE12K1ZST0s2Z0JkOXJJNm43Q1dvWTNkT3VYZjJ4anNCOVRVempLSTdB?=
 =?utf-8?B?eWxVUVRScWNwaWl4YVM5Z2FnTlVZN3lPUStBdHkzYVhIQXZqR28vQmtXbzhM?=
 =?utf-8?B?dDdjZFdSUGQwblRxdEpVODl4NnV2bHEwOXpYOU5VcC9GaWRqUUUvb2NCN1pZ?=
 =?utf-8?B?VUV5VlVubDRGQUVyNndOY1JrdStRSmR4RnlDUkJqNm52S2hvemhrQ0NvZmZE?=
 =?utf-8?B?cHM4TW5sRkV4SWN1bmhpeXVaa29WMFRUbzdHVkt6M3Y3RmVaWndHYkNDQ3JO?=
 =?utf-8?B?RGhQOEZScFJVcGVlU2JWNXcvNzZRa1NvTy9tcThWNUdOMmtjdHFoWmFDQ3Fu?=
 =?utf-8?B?U05WcVZWSUxHdlQ4UUlkMVZJR0FpcmtZZURQRW1vREJ1RDI2VGdCK3RrUUFu?=
 =?utf-8?B?RmpaaHFZSkk0cnpra3Z3QVVDeHg5WEp1K0xWNzdEK2t1djNMUy8zT2xtYjla?=
 =?utf-8?B?ZW1lV2tERVlvcnRlSlBLelB6NlRpOHhSTlloZDdvTGlyY1VucjFCWVpuL1hN?=
 =?utf-8?B?QzlXWnRpMy81UDk3cWxsRUZjcFZxRkhoQ1pqM2phMnVPa1UrT2h3cnE3TDBT?=
 =?utf-8?B?YVJuRTN6RDZRZGtPYnhDYTBvZDRPUWs0R3NhUzI5d3NZN2E2K0VYRlNCRjVT?=
 =?utf-8?B?eG1rZGxxQ0J4cXZTZDQ1ZXA2VVZYNmp1YUd1N0pNaFhIVERpdGhNUzhzQlB4?=
 =?utf-8?B?RTNYNTZxTG92Rnk0NFpMOHpVajVpcHppd0NKNXhMellSNU1Jd2djSDlVVkU4?=
 =?utf-8?B?enpsbktyTlAvYWhUbHp2ZW1YbGs1b2lBN3FsYmVIZHpPM05FanE2QmtjcHlJ?=
 =?utf-8?B?NVlxL1pBbktaUUVmVTh5MDJUREhzUm1YdzFsNjJoRE9uZDhEWVdmL3lwbFdH?=
 =?utf-8?B?eE03WUFtVFRBLy9YQVFzcnFYV3JoT2lzQWFRcFN6cEY2TlVreCtXNFdBZ2Vu?=
 =?utf-8?B?SWgrKzNHYm82bThjdHg3RjNwbTZvQm4vNnlrTVNHcUw0MkxXcCtRQ1lSQmQv?=
 =?utf-8?B?SFFNRFJDUGI2emlmb1NVTktIN2R0RjFOWGp5cFU2OG8zT0NwV0syVzUxaHVo?=
 =?utf-8?B?Z0kyQnh0MVAxamtqVTlrU01haldrTVkrSG5VUDVwY3M0TXdMRUwwSnpOZ0Ey?=
 =?utf-8?B?bjg3RHJ0NjNmYmU4N1QwU25veUIrYWIzdldCZkdtY25Zc3FHYXFQUndRWVRQ?=
 =?utf-8?B?U0lsenBURWc2a3Z4QUFnd2RvUUF4SUppemo1cWZCYUFoYkVmY2g5TFBFdmUy?=
 =?utf-8?B?Yjl3M21ZNVNBWXI4ZEpNV01WV0FXNldCWnkxUkJweURoR2EwM1lFNEx3aUFK?=
 =?utf-8?B?dC9IUlZFTlg2bEVtcXFHQzNubDFOTk1Qd3JsT2hkOXphOEZJTi9XTEVkTW40?=
 =?utf-8?B?UmYrQlpoblI3bVhmYisrL1pVY1RUWjBUcXdLQWZPc0l1b21ZZEJOT2lWd3BC?=
 =?utf-8?B?N0lnYVFmbGRKYjgxbVAvUTdiUmpTUzJaZ3grM1pjeUs5eTNRakREbS9XcCth?=
 =?utf-8?Q?gCvFLMhR97Z1NjQFUG6LKyDi7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66634631-c025-4a3e-57f5-08ddeeb49011
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 08:49:03.4445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tInQN6w0bxJI5qrx5XWjWplKsXmW+wi7penxzYLDVASUmG9/VV2gO5EpzvYyIVTt1I+l6bK5Boua0pTq4WLaxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
Received-SPF: permerror client-ip=2a01:111:f403:200a::60d;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=2.131, SPF_HELO_PASS=-0.001,
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNSBTZXB0ZW1iZXIgMjAyNSAxMDoyOA0KPiBU
bzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBTaGFtZWVyIEtv
bG90aHVtDQo+IDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE5pY29saW4NCj4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsNCj4gTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2No
cyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IGxpbnV4YXJtQGh1
YXdlaS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3ZWku
Y29tOyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8u
b3JnOyB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBnbWFpbC5j
b20NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMDgvMTVdIGh3L2FybS9zbW11djMtYWNj
ZWw6IEFkZA0KPiBzZXQvdW5zZXRfaW9tbXVfZGV2aWNlIGNhbGxiYWNrDQo+IA0KPiBFeHRlcm5h
bCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4g
DQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiA3LzE0LzI1IDU6NTkgUE0sIFNoYW1lZXIgS29sb3Ro
dW0gd3JvdGU6DQo+ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0K
PiA+DQo+ID4gSW1wbGVtZW50IGEgc2V0X2lvbW11X2RldmljZSBjYWxsYmFjazoNCj4gPiAgLUlm
IGZvdW5kIGFuIGV4aXN0aW5nIHZpb21tdSByZXVzZSB0aGF0Lg0KPiA+ICAgIChEZXZpY2VzIGJl
aGluZCB0aGUgc2FtZSBwaHlzaWNhbCBTTU1VIHNob3VsZCBzaGFyZSBhbiBTMiBIV1BUKQ0KPiBJ
IGZhaWxlZCB0byBzZWUgd2hlcmUgdGhpcyBpcyBkb25lIGJlbG93Pw0KDQpSaWdodC4gSSB0aGlu
ayB0aGlzIGlzIGZyb20gdGhlIHByZXZpb3VzIHNlcmllcy4gSSBuZWVkIHRvIHVwZGF0ZSB0aGlz
Lg0KQXQgcHJlc2VudCwgd2Ugb25seSBhbGxvY2F0ZSBhIHZpb21tdSBpZiBvbmUgaXMgbm90IGFs
bG9jYXRlZCBhbHJlYWR5Lg0KQW5kIGR1cmluZyB0aGUgdmlvbW11IGFsbG9jYXRpb24gYSBTMiBo
d3B0X2lkIGlzIHBhc3NlZCB3aGljaCBpcyBhDQpuZXN0ZWQgcGFyZW50IEhXUFQgYWxsb2NhdGVk
IGJ5IHZmaW8vaW9tbXVmZC4gQWxsIHRoZSBkZXZpY2VzIHRoYXQNCmdldHMgYXR0YWNoZWQgdG8g
dGhpcyBhY2NlbCBzbW11djMvdmlvbW11IHdpbGwgc2hhcmUgdGhhdCBwYXJlbnQgUzIuDQoNCj4g
PiAgLUVsc2UsDQo+ID4gICAgIEFsbG9jYXRlIGEgdmlvbW11IHdpdGggdGhlIG5lc3RlZCBwYXJl
bnQgUzIgaHdwdCBhbGxvY2F0ZWQgYnkgVkZJTy4NCj4gPiAgICAgQWxsb2NhdGUgYnlwYXNzIGFu
ZCBhYm9ydCBod3B0Lg0KPiA+ICAtQW5kIGFkZCB0aGUgZGV2IHRvIHZpb21tdSBkZXZpY2UgbGlz
dA0KPiA+DQo+ID4gQWxzbyBhZGQgYW4gdW5zZXRfaW9tbXVfZGV2aWNlIHRvIHVud2luZC9jbGVh
bnVwIGFib3ZlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGlu
Y0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0NCj4gPHNo
YW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJt
L3NtbXV2My1hY2NlbC5jICAgIHwgMTU0DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ICBody9hcm0vc21tdXYzLWFjY2VsLmggICAgfCAgMjAgKysrKysNCj4g
PiAgaHcvYXJtL3RyYWNlLWV2ZW50cyAgICAgIHwgICA0ICsNCj4gPiAgaW5jbHVkZS9zeXN0ZW0v
aW9tbXVmZC5oIHwgICA2ICsrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTg0IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLWFjY2VsLmMgYi9ody9hcm0v
c21tdXYzLWFjY2VsLmMgaW5kZXgNCj4gPiA2NmNkNGY1ZWNlLi5mZTkwZDQ4Njc1IDEwMDY0NA0K
PiA+IC0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+ICsrKyBiL2h3L2FybS9zbW11djMt
YWNjZWwuYw0KPiA+IEBAIC03LDYgKzcsNyBAQA0KPiA+ICAgKi8NCj4gPg0KPiA+ICAjaW5jbHVk
ZSAicWVtdS9vc2RlcC5oIg0KPiA+ICsjaW5jbHVkZSAidHJhY2UuaCINCj4gPiAgI2luY2x1ZGUg
InFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+ID4NCj4gPiAgI2luY2x1ZGUgImh3L2FybS9zbW11djMu
aCINCj4gPiBAQCAtMTcsNiArMTgsOSBAQA0KPiA+DQo+ID4gICNpbmNsdWRlICJzbW11djMtYWNj
ZWwuaCINCj4gPg0KPiA+ICsjZGVmaW5lIFNNTVVfU1RFX1ZBTElEICAgICAgKDFVTEwgPDwgMCkN
Cj4gPiArI2RlZmluZSBTTU1VX1NURV9DRkdfQllQQVNTICgxVUxMIDw8IDMpDQo+ID4gKw0KPiA+
ICBzdGF0aWMgU01NVXYzQWNjZWxEZXZpY2UgKnNtbXV2M19hY2NlbF9nZXRfZGV2KFNNTVVTdGF0
ZSAqYnMsDQo+IFNNTVVQY2lCdXMgKnNidXMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFBDSUJ1cyAqYnVzLCBpbnQNCj4gPiBkZXZmbikgIHsg
QEAgLTM5LDYgKzQzLDE1NCBAQCBzdGF0aWMgU01NVXYzQWNjZWxEZXZpY2UNCj4gPiAqc21tdXYz
X2FjY2VsX2dldF9kZXYoU01NVVN0YXRlICpicywgU01NVVBjaUJ1cyAqc2J1cywNCj4gPiAgICAg
IHJldHVybiBhY2NlbF9kZXY7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgYm9vbA0KPiA+ICtz
bW11djNfYWNjZWxfZGV2X2FsbG9jX3Zpb21tdShTTU1VdjNBY2NlbERldmljZSAqYWNjZWxfZGV2
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSG9zdElPTU1VRGV2aWNlSU9N
TVVGRCAqaWRldiwgRXJyb3INCj4gPiArKiplcnJwKSB7DQo+ID4gKyAgICBzdHJ1Y3QgaW9tbXVf
aHdwdF9hcm1fc21tdXYzIGJ5cGFzc19kYXRhID0gew0KPiA+ICsgICAgICAgIC5zdGUgPSB7IFNN
TVVfU1RFX0NGR19CWVBBU1MgfCBTTU1VX1NURV9WQUxJRCwgMHgwVUxMIH0sDQo+ID4gKyAgICB9
Ow0KPiA+ICsgICAgc3RydWN0IGlvbW11X2h3cHRfYXJtX3NtbXV2MyBhYm9ydF9kYXRhID0gew0K
PiA+ICsgICAgICAgIC5zdGUgPSB7IFNNTVVfU1RFX1ZBTElELCAweDBVTEwgfSwNCj4gPiArICAg
IH07DQo+ID4gKyAgICBTTU1VRGV2aWNlICpzZGV2ID0gJmFjY2VsX2Rldi0+c2RldjsNCj4gPiAr
ICAgIFNNTVVTdGF0ZSAqYnMgPSBzZGV2LT5zbW11Ow0KPiA+ICsgICAgU01NVXYzU3RhdGUgKnMg
PSBBUk1fU01NVVYzKGJzKTsNCj4gPiArICAgIFNNTVV2M0FjY2VsU3RhdGUgKnNfYWNjZWwgPSBz
LT5zX2FjY2VsOw0KPiA+ICsgICAgdWludDMyX3QgczJfaHdwdF9pZCA9IGlkZXYtPmh3cHRfaWQ7
DQo+ID4gKyAgICBTTU1VUzJId3B0ICpzMl9od3B0Ow0KPiA+ICsgICAgU01NVVZpb21tdSAqdmlv
bW11Ow0KPiA+ICsgICAgdWludDMyX3QgdmlvbW11X2lkOw0KPiA+ICsNCj4gPiArICAgIGlmIChz
X2FjY2VsLT52aW9tbXUpIHsNCj4gPiArICAgICAgICBhY2NlbF9kZXYtPnZpb21tdSA9IHNfYWNj
ZWwtPnZpb21tdTsNCj4gPiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiArICAgIH0NCj4gPiAr
DQo+ID4gKyAgICBpZiAoIWlvbW11ZmRfYmFja2VuZF9hbGxvY192aW9tbXUoaWRldi0+aW9tbXVm
ZCwgaWRldi0+ZGV2aWQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgSU9NTVVfVklPTU1VX1RZUEVfQVJNX1NNTVVWMywNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzMl9od3B0X2lkLCAmdmlvbW11X2lkLCBlcnJwKSkgew0KPiA+
ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICB2aW9t
bXUgPSBnX25ldzAoU01NVVZpb21tdSwgMSk7DQo+ID4gKyAgICB2aW9tbXUtPmNvcmUudmlvbW11
X2lkID0gdmlvbW11X2lkOw0KPiA+ICsgICAgdmlvbW11LT5jb3JlLnMyX2h3cHRfaWQgPSBzMl9o
d3B0X2lkOw0KPiA+ICsgICAgdmlvbW11LT5jb3JlLmlvbW11ZmQgPSBpZGV2LT5pb21tdWZkOw0K
PiA+ICsNCj4gPiArICAgIGlmICghaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2h3cHQoaWRldi0+aW9t
bXVmZCwgaWRldi0+ZGV2aWQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZpb21tdS0+Y29yZS52aW9tbXVfaWQsIDAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIElPTU1VX0hXUFRfREFUQV9BUk1fU01NVVYzLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YoYWJvcnRfZGF0YSksICZhYm9ydF9k
YXRhLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdmlvbW11LT5h
Ym9ydF9od3B0X2lkLCBlcnJwKSkgew0KPiA+ICsgICAgICAgIGdvdG8gZnJlZV92aW9tbXU7DQo+
ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgaWYgKCFpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdw
dChpZGV2LT5pb21tdWZkLCBpZGV2LT5kZXZpZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdmlvbW11LT5jb3JlLnZpb21tdV9pZCwgMCwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfSFdQVF9EQVRBX0FSTV9TTU1VVjMsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihieXBhc3NfZGF0
YSksICZieXBhc3NfZGF0YSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJnZpb21tdS0+YnlwYXNzX2h3cHRfaWQsIGVycnApKSB7DQo+ID4gKyAgICAgICAgZ290byBm
cmVlX2Fib3J0X2h3cHQ7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgczJfaHdwdCA9IGdf
bmV3KFNNTVVTMkh3cHQsIDEpOw0KPiA+ICsgICAgczJfaHdwdC0+aW9tbXVmZCA9IGlkZXYtPmlv
bW11ZmQ7DQo+ID4gKyAgICBzMl9od3B0LT5od3B0X2lkID0gczJfaHdwdF9pZDsNCj4gPiArDQo+
ID4gKyAgICB2aW9tbXUtPmlvbW11ZmQgPSBpZGV2LT5pb21tdWZkOw0KPiA+ICsgICAgdmlvbW11
LT5zMl9od3B0ID0gczJfaHdwdDsNCj4gPiArDQo+ID4gKyAgICBzX2FjY2VsLT52aW9tbXUgPSB2
aW9tbXU7DQo+ID4gKyAgICBhY2NlbF9kZXYtPnZpb21tdSA9IHZpb21tdTsNCj4gPiArICAgIHJl
dHVybiB0cnVlOw0KPiA+ICsNCj4gPiArZnJlZV9hYm9ydF9od3B0Og0KPiA+ICsgICAgaW9tbXVm
ZF9iYWNrZW5kX2ZyZWVfaWQoaWRldi0+aW9tbXVmZCwgdmlvbW11LT5hYm9ydF9od3B0X2lkKTsN
Cj4gPiArZnJlZV92aW9tbXU6DQo+ID4gKyAgICBpb21tdWZkX2JhY2tlbmRfZnJlZV9pZChpZGV2
LT5pb21tdWZkLCB2aW9tbXUtPmNvcmUudmlvbW11X2lkKTsNCj4gPiArICAgIGdfZnJlZSh2aW9t
bXUpOw0KPiA+ICsgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
Ym9vbCBzbW11djNfYWNjZWxfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3Bh
cXVlLA0KPiBpbnQgZGV2Zm4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEhvc3RJT01NVURldmljZSAqaGlvZCwNCj4gPiArRXJyb3IgKiplcnJwKSB7DQo+
ID4gKyAgICBIb3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2ID0NCj4gSE9TVF9JT01NVV9ERVZJ
Q0VfSU9NTVVGRChoaW9kKTsNCj4gPiArICAgIFNNTVVTdGF0ZSAqYnMgPSBvcGFxdWU7DQo+ID4g
KyAgICBTTU1VdjNTdGF0ZSAqcyA9IEFSTV9TTU1VVjMoYnMpOw0KPiA+ICsgICAgU01NVXYzQWNj
ZWxTdGF0ZSAqc19hY2NlbCA9IHMtPnNfYWNjZWw7DQo+ID4gKyAgICBTTU1VUGNpQnVzICpzYnVz
ID0gc21tdV9nZXRfc2J1cyhicywgYnVzKTsNCj4gPiArICAgIFNNTVV2M0FjY2VsRGV2aWNlICph
Y2NlbF9kZXYgPSBzbW11djNfYWNjZWxfZ2V0X2Rldihicywgc2J1cywgYnVzLA0KPiBkZXZmbik7
DQo+ID4gKyAgICBTTU1VRGV2aWNlICpzZGV2ID0gJmFjY2VsX2Rldi0+c2RldjsNCj4gPiArDQo+
ID4gKyAgICBpZiAoIWlkZXYpIHsNCj4gPiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiArICAg
IH0NCj4gPiArDQo+ID4gKyAgICBpZiAoYWNjZWxfZGV2LT5pZGV2KSB7DQo+ID4gKyAgICAgICAg
aWYgKGFjY2VsX2Rldi0+aWRldiAhPSBpZGV2KSB7DQo+ID4gKyAgICAgICAgICAgIGVycm9yX3Jl
cG9ydCgiRGV2aWNlIDB4JXggYWxyZWFkeSBoYXMgYW4gYXNzb2NpYXRlZA0KPiA+ICsgaWRldiIs
DQo+IHdvdWxkIG5vdCB1c2UgImlkZXYiIGFzIGVuZC11c2VyIHdpbGwgbm90IGVhc2lseSB1bmRl
cnN0YW5kIHdoYXQgdGhlIGJlYXN0IGlzDQoNCk9rLg0KDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICBzbW11X2dldF9zaWQoc2RldikpOw0KPiA+ICsgICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQo+IGlmIHRoaXMgaXMgY29uc2lkZXJlZCBhcyBhbiBlcnJvciB3aHkgZG9uJ3Qgd2Ugc2V0
IGVycnA/DQo+ID4gKyAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgcmV0dXJuIHRy
dWU7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlmICghc21t
dXYzX2FjY2VsX2Rldl9hbGxvY192aW9tbXUoYWNjZWxfZGV2LCBpZGV2LCBlcnJwKSkgew0KPiA+
ICsgICAgICAgIGVycm9yX3JlcG9ydCgiRGV2aWNlIDB4JXg6IFVuYWJsZSB0byBhbGxvYyB2aW9t
bXUiLA0KPiBzbW11X2dldF9zaWQoc2RldikpOw0KPiA+ICsgICAgICAgIHJldHVybiBmYWxzZTsN
Cj4gc2FtZSBoZXJlDQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgYWNjZWxfZGV2LT5pZGV2
ID0gaWRldjsNCj4gPiArICAgIFFMSVNUX0lOU0VSVF9IRUFEKCZzX2FjY2VsLT52aW9tbXUtPmRl
dmljZV9saXN0LCBhY2NlbF9kZXYsIG5leHQpOw0KPiA+ICsgICAgdHJhY2Vfc21tdXYzX2FjY2Vs
X3NldF9pb21tdV9kZXZpY2UoZGV2Zm4sIHNtbXVfZ2V0X3NpZChzZGV2KSk7DQo+ID4gKyAgICBy
ZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgc21tdXYzX2FjY2Vs
X3Vuc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZA0KPiAqb3BhcXVlLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkZXZmbikgew0K
PiA+ICsgICAgU01NVVN0YXRlICpicyA9IG9wYXF1ZTsNCj4gPiArICAgIFNNTVV2M1N0YXRlICpz
ID0gQVJNX1NNTVVWMyhicyk7DQo+ID4gKyAgICBTTU1VUGNpQnVzICpzYnVzID0gZ19oYXNoX3Rh
YmxlX2xvb2t1cChicy0NCj4gPnNtbXVfcGNpYnVzX2J5X2J1c3B0ciwgYnVzKTsNCj4gPiArICAg
IFNNTVV2M0FjY2VsRGV2aWNlICphY2NlbF9kZXY7DQo+ID4gKyAgICBTTU1VVmlvbW11ICp2aW9t
bXU7DQo+ID4gKyAgICBTTU1VRGV2aWNlICpzZGV2Ow0KPiA+ICsNCj4gPiArICAgIGlmICghc2J1
cykgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBz
ZGV2ID0gc2J1cy0+cGJkZXZbZGV2Zm5dOw0KPiA+ICsgICAgaWYgKCFzZGV2KSB7DQo+ID4gKyAg
ICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGFjY2VsX2RldiA9IGNv
bnRhaW5lcl9vZihzZGV2LCBTTU1VdjNBY2NlbERldmljZSwgc2Rldik7DQo+ID4gKyAgICBpZiAo
IWhvc3RfaW9tbXVfZGV2aWNlX2lvbW11ZmRfYXR0YWNoX2h3cHQoYWNjZWxfZGV2LT5pZGV2LA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFjY2Vs
X2Rldi0+aWRldi0+aHdwdF9pZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBOVUxMKSkgew0KPiA+ICsgICAgICAgIGVycm9yX3JlcG9ydCgiVW5h
YmxlIHRvIGF0dGFjaCBkZXYgdG8gdGhlIGRlZmF1bHQgSFcNCj4gPiArIHBhZ2V0YWJsZSIpOw0K
PiBhbHNvIHRyYWNlIHNtbXVfZ2V0X3NpZChzZGV2KSB0byBiZSBjb25zaXN0ZW50IHdpdGggb3Ro
ZXIgdHJhY2VzPw0KDQpPay4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo=


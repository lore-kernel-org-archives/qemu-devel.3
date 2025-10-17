Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D90CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kK5-0005sv-5n; Fri, 17 Oct 2025 09:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v9kJt-0005jf-OC; Fri, 17 Oct 2025 09:16:37 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v9kJa-0005wH-Hm; Fri, 17 Oct 2025 09:16:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOXQzQcyEL4cdd9jF25d1jIcen+z8GynsTAF30F5ASU+SIbGSpvE4k16w+Q+wTCvmL5CT3DemIbo89DSMQG2Jdda4PKRES4IPLJbFNVG+66/+xzNXZpUZw+2sb59r7e8iFWRr+aBD6qff4aYgk0AqJgrSPcvZLdnC65BmmvrrWOoxY5xYWPu55GcjV9Qmlwq9nebnAeD37LpftASa61sMY09ID/JE/WiLEH12xLxBm4PRpD/+Z9tEYgBQj5jH5L4UU44k4x/cziakd7BNiKhzKONpp8/IdBjZTaXpx45RE3xPcT7F9msyETs03OtX7dV+l6eQ6yNBzXyWkE19sLcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83iNXJwqc95IceSCJWInyhDn9J7Br53ku6Bv53iHAxk=;
 b=aty0CYvVXlibYBiCoY9ew2GjfkpKOMAXkDn8xH9jdZrAy+UoW1TGi7NlVYe7YZobDDv/2iS4jG1fQWV+nxUGhAuHCPlXWrcwenbdpwTFFIRhCLYcxuj5bOTY/mqIj+nn2L+AQeBLugM9uCy3WyZgMbRZlpldXvfATilcPFevxrbAfkkIsBv+AgBBgc7Bb8RpqkqcsTLsCu3CM6em5fCMNLd5Thw4FkBqS/ZE/ulCfJ94YhECDiPEbud/z1OSh0bqZmPC2ooTma247teM9YwCyZt/Dr1Y7E6e4jYaNMOCTA5IAmBoqP9ZS/gp6QdSRLccmXu6pJTR7ARkFMvIn4MfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83iNXJwqc95IceSCJWInyhDn9J7Br53ku6Bv53iHAxk=;
 b=I+aTSlkjSjDWX9sUl738FfNnbcORtMFK23+oDz1Q5nEYs0OKTwlCJl+XrtITcXAcYpOF67jjJoBgfslGu/vlBoUI3oLaQ5L5ZUJGU/3Nt0UFLe7E2id0b7Xb7NOvFgFI6M2gDNOFTdmm7LUtRG5iRpnXDBI2yH9hAc7jzRx7PUSeYDLUV3FMwfuyfvfCaYqLuNYsouXHnEaDkjKduQZ8iGc/OAsEQRUZEEUI7odayN4CN5XswavU8uZyE9n1zxh3sI5gS6q0X2uTAiq4bCnZUhH40tvhHRPOMGYd1mpl34o0ww6IgQfs79q9EhggcDxkp6iqh7ciGX4bulXzjNngog==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 13:15:57 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 13:15:57 +0000
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
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated SMMUv3
 to vfio-pci endpoints with iommufd
Thread-Topic: [PATCH v4 06/27] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcMvlSHNFvMFbT2kCFLixXDfUlObSuhAjggBfeYICAAATDsA==
Date: Fri, 17 Oct 2025 13:15:57 +0000
Message-ID: <CH3PR12MB7548CA7BFC577C90C3876748ABF6A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-7-skolothumtho@nvidia.com>
 <cba0a4c0-9d0c-4137-ae0a-7460da56ac56@redhat.com>
 <CH3PR12MB754822A08B7D9D7317DBECD8ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <646bbedb-cfa4-418c-80b2-f143f6f97544@redhat.com>
In-Reply-To: <646bbedb-cfa4-418c-80b2-f143f6f97544@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB7684:EE_
x-ms-office365-filtering-correlation-id: cebe91f4-8920-4f26-0f00-08de0d7f4f39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Ny9KOEt4TmJvRWdjd3pkMVhIM0tCZTVtS28yMGsrckJQZjZRQm9zVFdMQWNY?=
 =?utf-8?B?SVBZN1NzWll1a3pnTVM5ckV2WC9TKzJvY3ladktDYmhIbXlhbXJCYnZUcmhl?=
 =?utf-8?B?WlhuYThQNEx5c2o3NldqcS9jeU5tY1dkTlhEdmVkYnNzd2NCL1Q5L0xJRFFn?=
 =?utf-8?B?LzBYZU9ONUN2M3JRbGh2L2FxdU5zZmpFODFSYnNYUzlIWXZaaW1DRUp3SlhY?=
 =?utf-8?B?R0xTNzJ0ZUtIY09tVml3d0lnSUN5VmxhdzYxWlovMGV5TzNqdDZiOGJESDhw?=
 =?utf-8?B?MHBNRUdrYTNhWDY1ZW9ITEQ3TEJ6Sy91U0VZN3JCaTEyQXQ1YnRyVmVKZ0Uz?=
 =?utf-8?B?YnlVSzZwc1RicVpmTTJINDNsN3ovUi9pTjB2M2s1Sy9rY1NaelBqY21wMzdY?=
 =?utf-8?B?TzR2YlVNMVlGTFk1Uk9PTVhnaUFRcTNPL1V2SlMyTUplS1VMUjIyZnFDaHN2?=
 =?utf-8?B?dmFjUzJza1ZkT2hWampVVFU0SURxZUg4V283bDJmb2I2Mm5xczN1U1hwV2hI?=
 =?utf-8?B?L1VRRjFtUWVWY2Q3ZWdHQlBzNk1tbWJUeFhTTUVNam4zZnRGMDlHNEYwMzFv?=
 =?utf-8?B?aGdkQW9OaVg0bjkrQ3RUVjNmdGNnWm8xTlllREJENzA2RE9YTFBuaXlMVjFz?=
 =?utf-8?B?amFTV29xZmtjMk9SRjVCVDhQYUNkUzVkak5UbTU1dWtyeDVEdWZtcmhCamE3?=
 =?utf-8?B?cnRVaVBZa2hSd1hTVUlWcnQzR3lVSmlVT3VtZFhMKys1TEowclJ6Nm9yaWtL?=
 =?utf-8?B?YituRlFYTS9Bc1ZLekJRZFdxSkRhMzJUSkJxc29GMXllVlZSQjB1dkE2VGFW?=
 =?utf-8?B?SVhaemhweUtOd0YrQStLakNnbzFzMy95RVphN3pueGtpbGFWbmtPYldsMXRr?=
 =?utf-8?B?V0lQUnRYOGNEVEhpV2FZbVZ3T0tOdm9aQVZwYVA1a3ltQkZ6WTRDTFdDM2Jl?=
 =?utf-8?B?S3M4cHFQVTVHelg3RjBNY0JaVjRucGNpT3lmNU81N081cTZaa3d1VCthMW5j?=
 =?utf-8?B?bU9WVzJLdkp3YTBhbktSa0RkRTRCdkRLOHkzNnFHelcyaHhqRWkrU3dSVkFL?=
 =?utf-8?B?QlVveGp0RmRmbDUvSFRyTFhISGt3WjNKRGR6bWM0OG5pY2x0WTJWZjdncVNG?=
 =?utf-8?B?eDJJOUpuVXkrZkk4SzZPR2o3MUxlNHNZRlFYSDFZVTdpaWp6aFVMbE9UVi9s?=
 =?utf-8?B?bmUwdnRwQ3NQWGlINHdPSVVCaTRISUdqZUYySUN2WFpTM3NCN1htcm53ZCt1?=
 =?utf-8?B?NXNkZ25VLzNmUm1Sc1pEUG5nVWdUVEFFZlY0dC9ENnI3UEdDbDRkOEFacVNx?=
 =?utf-8?B?eWRVaGQ2T01TWnU5UFQ3ZnlqbW1GSWJYMUtjS3I2TkpYMzFLSS9oV1FFTnpz?=
 =?utf-8?B?OGYvNEZQdmRYalBzTXUzZ1lSZXIvNktmTTNnUU9KaFlvQmRXLzBjNlJNZ3gw?=
 =?utf-8?B?dkVtdTErc0g1cGZXbEVuU3dTR0NhTmhBRGpuWGRmSGVzNzFhalE4TlJIZ1VH?=
 =?utf-8?B?Q056aEdVUytiQlZQTGVrRTR0OFNlUVdFektvMnhGUHhzeWhCUWpOM003SWxD?=
 =?utf-8?B?dUEvaXIyV2FxUG5GbnAyOUEzNGFibCtiNm5VQWZuSEpHWitHZ1ZlQkIyeGZJ?=
 =?utf-8?B?c09sZGtZRFUzQ3VpMU05bkJsVTA1Ymx0RzlGQzhDektPU1RzdnlZTkZUSERV?=
 =?utf-8?B?TU5VbEdlQVo3N3hueFZ6RDJ6YWw5UkpMTzhKM0ZCNTZMbVBaM1huczVEVnA4?=
 =?utf-8?B?Z2g4YjZDY1FHTkdDM0trZDQ2NjJGanA1UWhlUldyVXlKZ2NuankzcDJmN2s3?=
 =?utf-8?B?MldLZlR0aXFhQ21tMjlicTVGaHNmTnBQNGFab084K3luOGg0Qkp5Tnltanpv?=
 =?utf-8?B?dU11ZlBjUW1nRkIwVkw2NnNVZFlMUlVXbVhJTTQ1aWxlT1JCdFIwUnIzMEll?=
 =?utf-8?B?aGJwNS92Ymx0bUhVaW9ieWdDdXczVlRnTVA5a0pRMzFwMWxkQmxGT0dDZ2Zv?=
 =?utf-8?B?REJaZk5MSEl3ZlZjUVVrdzUvcjZ2b1JYdENCVG9ibFUvalVaUTFTc0FpdVFt?=
 =?utf-8?Q?o2HnKO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1dwOWNOd3JBSCtITFZzUHJnaFRMbWo3MmROWkdEUVdzTXlmOGtldkZXcytR?=
 =?utf-8?B?SENCSlZTMnFQZlV6d2lUc0Y5RUNXN1hYeUI0QkptWTVpeGd3cXMyUHpZc0Jt?=
 =?utf-8?B?eldrbmJyTkJ4VXk2N3h0T2s5R1BiM1RkMVQ0akVMbjZJandtWk81d0cvTVQ2?=
 =?utf-8?B?bHEreTZDUlNJOXhydy82aUVDVzFRcWlhS2ZsNktnV2lXUkJVdFNGRStwMDBw?=
 =?utf-8?B?OHpPaG94Szh4ckFIQWdUbS9hbWtqMDlVUXRzWGJXcy9UQ1Q0SGNnQVZoUG8z?=
 =?utf-8?B?cEluWWJxTkdpc09YVnJ0YkQ1MDJwbDBlNk00SjUvejNCaXoxTjlxT2ZweXlt?=
 =?utf-8?B?K1VZZUVmV2tPVGI1cndlU0swdzFpaFlkQjZ0dTVoeTA3SWxXb2FkQTU1bkw2?=
 =?utf-8?B?TDNIcGF4VWdGR0QxeWJVMW5MbktwTTR6U2VHbG14MmY1bDBTRGt6MjdNV202?=
 =?utf-8?B?K0lPTXU5UTRZZ1NyajVzbDdTRWphRjFGWEF3NHM0Si9TL3NLK01kb2xVWTZL?=
 =?utf-8?B?QTUwQXQ0eGNDU09YR09vNkdlV3dkZC9RQnZUWHlnU2ZCV3RzL2lLbXFoR0V6?=
 =?utf-8?B?eFpUd3FzWlFwNnkzcmV1NWM1MEdBYlhERnVrYldkT056cmNZQWtYZ1llVHBv?=
 =?utf-8?B?Vlo1akRDRFh6VkZpTlZ0bHYvajM3YTRORi9GOGJFNTBrTFY2ZCsxak56bS9q?=
 =?utf-8?B?eHdVMml5Nk56K2RndkpvcyszNEpYelZxZmlGSG1YQ3VnNE51M3VkZnY3V3hP?=
 =?utf-8?B?dXpaeXVRTjUvcHRZUDJla3V2Ymh1aUhtb3JVWkJwS2wrdVVYTy9SUkFzVE9H?=
 =?utf-8?B?L3oxVDU1WWdXMENjRnN2WWFGalIzQmVXcEJha0RTb0VrM0pMUEJUUGtJVXRF?=
 =?utf-8?B?L3htc0wzRGtjQUxYZlFpVGxSdlQ4aDdDZnlNK2tNWkMzcTNsdUJEbWlEb1lx?=
 =?utf-8?B?aVYrUmowVDg5SFJESlRNQ1JMalVDQVJjSWt5Y0E0cytKZXRMaFdSUzNvZTFU?=
 =?utf-8?B?cE1mWkZzd3ppZzhaQWQ5YTN6bHE5RjFZWUtZUHp4c1g3dTZ6YVBuVU9mZmJy?=
 =?utf-8?B?R1ZickJOZ24rVkg4ZGxBaUhMUUNwbDd5b296NzAyOS9udVV6dG9oc1I3eVYx?=
 =?utf-8?B?QmVTRjZKNFZPaGZoTGg3ajg5bFNuVlk4NGFDN1phUFo2UHY0Z3pOUWw2Mlhp?=
 =?utf-8?B?UHMwRk81Uk9RQVJqV3BRU08zaVNyRjB2b1hFSTlHNVozUTJzLzREUzl0NTNq?=
 =?utf-8?B?bjQxN3lpdWM1b3RDbmd1enNDbVBid1ZDWG94RWZmSUtsMCtoWFhSWGNLVzJ5?=
 =?utf-8?B?WitDU2x2SkVFU0g3ZXdDdlhxOGJITGE4L3hsODdsZExzMFJnVFVyMlZiTDdC?=
 =?utf-8?B?NU95Z2VybGpuMHdLMDdlKzZCbnZuaGpnMWN0VjhuTkpzMDA4RTR2enpVWnBB?=
 =?utf-8?B?TnpUcnNiTFNyNmZUT3Bva0kxUDZUMCtoZUsyOFVQNnkwcHhrMTFEcnE0Umo4?=
 =?utf-8?B?dlZYNFVpNkhEanRDQzMxeUs3cVZiYlRIUDc4dWxUVkdsVjk0YzdIT2tTWDRx?=
 =?utf-8?B?SFpyczkzZENxTTF3a3lxYkpOdzNadjB6aVBCQUZTYTgxQTVpNnNTcGd0Zkkx?=
 =?utf-8?B?RHpYSzBMWG1XUk1IZFlwRXIrbzUzaXgrVGN4MzVCaGxBTEVtNW9xTUJHVnhh?=
 =?utf-8?B?Ui9QWDduZkRWSXRTaFpwekxIajNYVm1ERk1HdjZEQkRGSW9UV3ZqV0crWjU3?=
 =?utf-8?B?YTdDL1VDYXd5TXpPaVNwS2VYNENwOXh2R2JvMk51d2lSQjgwSFdjQWdJeTVB?=
 =?utf-8?B?c3d1MVVuMndQalhQQnRFbzI3SW9CenNSZDRuT0kzbW9CblNXSkRWYUVScG9S?=
 =?utf-8?B?TVM5VU0xaHBtZVNQRU04ZHZlYldKS1ZUbzd5Tzl5dnk2SWlZRWo3ZkdHRkk3?=
 =?utf-8?B?a0hEV2N2bGxmUXhSaDgwRjdEY0RtM2FvZUtyZk1NM2pYTlBWWkplczc1Y3ZQ?=
 =?utf-8?B?cTZaV3orNi9PR2Y3Q1U2RVpNN2hMdzdJRExHVzVWU3hwcmczWEFYS2QzSHd5?=
 =?utf-8?B?Tjh6UWtvSHl3b1h0U2ZMQmsxS1ZxdWdzOENsN21YQWhJWFRsZVBITXNyN0ZH?=
 =?utf-8?Q?u70YMpfmzJC7YyYyaNLRQ7YDr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebe91f4-8920-4f26-0f00-08de0d7f4f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 13:15:57.3917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNVESXM5yPkcOMpa2q3rjfjcONVq7T5Tgb/9qAR+QejrS8Uj4FgRTttJWee7iLQe6scEyLdppMPT1EfDlr9+jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDE3IE9jdG9iZXIgMjAyNSAxMzo0
Nw0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBOaWNv
bGluDQo+IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJl
cnJhbmdlQHJlZGhhdC5jb207DQo+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBN
YXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5n
emhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25n
LmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBn
bWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNi8yN10gaHcvYXJtL3NtbXV2My1h
Y2NlbDogUmVzdHJpY3QgYWNjZWxlcmF0ZWQNCj4gU01NVXYzIHRvIHZmaW8tcGNpIGVuZHBvaW50
cyB3aXRoIGlvbW11ZmQNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5n
IGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGkgU2hhbWVlciwNCj4gDQo+IE9uIDEw
LzIvMjUgMTE6MzAgQU0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gSGkgRXJpYywNCj4g
Pg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBFcmljIEF1Z2Vy
IDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6IDAxIE9jdG9iZXIgMjAyNSAxODoz
Mg0KPiA+PiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBx
ZW11LQ0KPiA+PiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4+IENj
OiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5j
b20+OyBOaWNvbGluDQo+ID4+IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBkZHV0aWxlQHJl
ZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207DQo+ID4+IE5hdGhhbiBDaGVuIDxuYXRoYW5j
QG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiA+PiBzbW9zdGFm
YUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gPj4gamlhbmdrdW5rdW5A
aHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiA+PiB6aGFuZ2ZlaS5n
YW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5j
b207DQo+ID4+IHNoYW1lZXJrb2xvdGh1bUBnbWFpbC5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NCAwNi8yN10gaHcvYXJtL3NtbXV2My1hY2NlbDogUmVzdHJpY3QgYWNjZWxlcmF0ZWQN
Cj4gPj4gU01NVXYzIHRvIHZmaW8tcGNpIGVuZHBvaW50cyB3aXRoIGlvbW11ZmQNCj4gPj4NCj4g
Pj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMNCj4gPj4NCj4gPj4gSGkgU2hhbWVlciwNCj4gPj4NCj4gPj4gT24gOS8yOS8yNSAzOjM2IFBN
LCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+Pj4gQWNjZWxlcmF0ZWQgU01NVXYzIGlzIG9u
bHkgdXNlZnVsIHdoZW4gdGhlIGRldmljZSBjYW4gdGFrZSBhZHZhbnRhZ2UNCj4gPj4+IG9mIHRo
ZSBob3N0J3MgU01NVXYzIGluIG5lc3RlZCBtb2RlLiBUbyBrZWVwIHRoaW5ncyBzaW1wbGUgYW5k
DQo+ID4+PiBjb3JyZWN0LCB3ZSBvbmx5IGFsbG93IHRoaXMgZmVhdHVyZSBmb3IgdmZpby1wY2kg
ZW5kcG9pbnQgZGV2aWNlcyB0aGF0DQo+ID4+PiB1c2UgdGhlIGlvbW11ZmQgYmFja2VuZC4gV2Ug
YWxzbyBhbGxvdyBub24tZW5kcG9pbnQgZW11bGF0ZWQgZGV2aWNlcw0KPiA+Pj4gbGlrZSBQQ0kg
YnJpZGdlcyBhbmQgcm9vdCBwb3J0cywgc28gdGhhdCB1c2VycyBjYW4gcGx1ZyBpbiB0aGVzZQ0K
PiA+Pj4gdmZpby1wY2kgZGV2aWNlcy4gV2UgY2FuIG9ubHkgZW5mb3JjZSB0aGlzIGlmIGRldmlj
ZXMgYXJlIGNvbGQNCj4gPj4+IHBsdWdnZWQuIEZvciBob3RwbHVnIGNhc2VzLCBnaXZlIGFwcHJv
cHJpYXRlDQo+ID4+ICJXZSBjYW4gb25seSBlbmZvcmNlIHRoaXMgaWYgZGV2aWNlcyBhcmUgY29s
ZCBwbHVnZ2VkIjogSSBkb24ndCByZWFsbHkNCj4gPj4gdW5kZXJzdGFuZCB0aGF0IHN0YXRlbWVu
dC4NCj4gPiBCeSAiZW5mb3JjZSIgaGVyZSBJIG1lYW50LCB3ZSBjYW4gcHJldmVudCB1c2VyIGZy
b20gc3RhcnRpbmcgYSBHdWVzdA0KPiA+IHdpdGggYSBub24gInZmaW8tcGNpL2lvbW11ZmQgZGV2
IiB3aXRoIGFjY2VsPW9uZSBjYXNlLg0KPiBBaCBPSyBJIG1pc3JlYWQgdGhlIGNvZGUuIEkgdGhv
dWdodCB5b3Ugd2VyZSBhbHNvIGV4aXRpbmcgaW4gY2FzZSBvZg0KPiBob3RwbHVnIGJ1dCB5b3Ug
b25seSBpc3N1ZSBhIHdhcm5fcmVwb3J0Lg0KPiBGcm9tIGEgdXNlciBwb2ludCBvZiB2aWV3LCB0
aGUgYXNzaWduZWQgZGV2aWNlIHdpbGwgc3VjY2VlZCBhdHRhY2htZW50DQo+IGJ1dCB3b24ndCB3
b3JrLiBXaWxsIHdlIGdldCBzdWJzZXF1ZW50IG1lc3NhZ2VzPyANCg0KSXQgd2lsbCB3b3JrLiBC
dXQgYXMgdGhlIHdhcm5pbmcgc2F5cywgaXQgbWF5IGRlZ3JhZGUgdGhlIHBlcmZvcm1hbmNlIGVz
cGVjaWFsbHkNCklmIHRoZSBTTU1VdjMgaGFzIG90aGVyIHZmaW8tcGNpIGRldmljZXMuIEJlY2F1
c2UgdGhlIFRMQiBpbnZhbGlkYXRpb25zDQpmcm9tIGVtdWxhdGVkIG9uZSB3aWxsIGJlIGlzc3Vl
ZCB0byBob3N0IFNNTVV2MyBhcyB3ZWxsLg0KDQogSSB1bmRlcnN0YW5kIHRoZSBwYWluDQo+IG9m
IHByb3BhZ2F0aW5nIHRoZSBlcnJvciBidXQgaWYgdGhlIHVzZXIgZXhwZXJpZW5jZSBpcyBiYWQg
SSB0aGluayBpdA0KPiBzaG91bGQgd2VpZ2h0IG92ZXIgPw0KDQpJIGFtIG5vdCBhZ2FpbnN0IGl0
LiBCdXQgY2FuIGJlIHRha2VuIHVwIGFzIGEgc2VwYXJhdGUgb25lIGlmIHJlcXVpcmVkLg0KDQo+
ID4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4NCj4gQ2FuJ3QgeW91IG1v
dmUgdGhlIGFzc2lnbm1lbnQgb2YgYnVzLT5kZXZpY2VzW2RldmZuXSBiZWZvcmUgdGhlIGNhbGwg
YW5kDQo+IHVuc2V0IGl0IGluIGNhc2Ugb2YgZmFpbHVyZT8NCj4gDQo+IE9yIGlmIHlvdSBwcm9w
YWdhdGUgZXJyb3JzIGZyb20NCj4gDQo+IGdldF9hZGRyZXNzX3NwYWNlKCkgeW91IGNvdWxkIHJl
dHJ5IHRoZSBjYWxsIGxhdGVyPw0KDQpGb3Igbm93LCBJIGhhdmUgYSBmaXggbGlrZSBiZWxvdyB0
aGF0IHNlZW1zIHRvIGRvIHRoZQ0KSm9iLg0KDQpkaWZmIC0tZ2l0IGEvaHcvcGNpL3BjaS5jIGIv
aHcvcGNpL3BjaS5jDQppbmRleCBjOTkzMmM4N2UzLi45NjkzZDdmMTBjIDEwMDY0NA0KLS0tIGEv
aHcvcGNpL3BjaS5jDQorKysgYi9ody9wY2kvcGNpLmMNCkBAIC0xMzcwLDkgKzEzNzAsNiBAQCBz
dGF0aWMgUENJRGV2aWNlICpkb19wY2lfcmVnaXN0ZXJfZGV2aWNlKFBDSURldmljZSAqcGNpX2Rl
diwNCiAgICAgcGNpX2Rldi0+YnVzX21hc3Rlcl9hcy5tYXhfYm91bmNlX2J1ZmZlcl9zaXplID0N
CiAgICAgICAgIHBjaV9kZXYtPm1heF9ib3VuY2VfYnVmZmVyX3NpemU7DQoNCi0gICAgaWYgKHBo
YXNlX2NoZWNrKFBIQVNFX01BQ0hJTkVfUkVBRFkpKSB7DQotICAgICAgICBwY2lfaW5pdF9idXNf
bWFzdGVyKHBjaV9kZXYpOw0KLSAgICB9DQogICAgIHBjaV9kZXYtPmlycV9zdGF0ZSA9IDA7DQog
ICAgIHBjaV9jb25maWdfYWxsb2MocGNpX2Rldik7DQoNCkBAIC0xNDE2LDYgKzE0MTMsOSBAQCBz
dGF0aWMgUENJRGV2aWNlICpkb19wY2lfcmVnaXN0ZXJfZGV2aWNlKFBDSURldmljZSAqcGNpX2Rl
diwNCiAgICAgcGNpX2Rldi0+Y29uZmlnX3dyaXRlID0gY29uZmlnX3dyaXRlOw0KICAgICBidXMt
PmRldmljZXNbZGV2Zm5dID0gcGNpX2RldjsNCiAgICAgcGNpX2Rldi0+dmVyc2lvbl9pZCA9IDI7
IC8qIEN1cnJlbnQgcGNpIGRldmljZSB2bXN0YXRlIHZlcnNpb24gKi8NCisgICAgaWYgKHBoYXNl
X2NoZWNrKFBIQVNFX01BQ0hJTkVfUkVBRFkpKSB7DQorICAgICAgICBwY2lfaW5pdF9idXNfbWFz
dGVyKHBjaV9kZXYpOw0KKyAgICB9DQogICAgIHJldHVybiBwY2lfZGV2Ow0KIH0NCg0KVGhhbmtz
LA0KU2hhbWVlcg0K


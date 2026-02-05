Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FC5E91290
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 09:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnvII-0000yA-OI; Thu, 05 Feb 2026 04:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vnvIH-0000wj-1o; Thu, 05 Feb 2026 04:04:57 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vnvIF-0004Y0-Al; Thu, 05 Feb 2026 04:04:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJD6/SdX86wTXzKg1LrqtIIq5wrhQMzBq2M8HLsVW21LkNnRJ1YBwYAS9vvOrEyco1uJZXruZ0dK2RduKCJ6Uf/Z2SJGDf75GLsvGHQPfBwY5OxuS3rR9GDyadmxunqzpXqPGhmiUiYNKG+FCS2eJ4+K+mMXRGP04DqsI+6ZavLTNslWoYO0U0Lmk+fjLqpdA1QyRZpLQ74ZZxDvw8oa5ofTCxlQYTStNJXf9m8H5yuCEt7C/LxjognpUUNxOXGGcjwHHu/EdC0Uhr1Vu+IhmBo3sxGn22pJOeL15512Iz04vHHKLI2uiHfnqW4dxcVdOYsA1Ii/eznlf11VgZ5OPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vazrU3hg8GnTemUh0+7TJ0LjUAULn1IHwuQ+D27Zbh0=;
 b=GWmFxmwTem9opK8Og2E5JaVNzvl83lsjSPTSpTjgGQlRRENrBex7Q7ElDvuCd5G8OIBt7YeP2UN6etQ4RuDP51mpSEYyO7jcKk7xXmBxxFgH8TVW8VfNcEsJgiNZwX3QB4aL2d1We5QHeFC5GQXqHbZbWEiHK5/D8A6SjJiQgwv1OKtDPbcBh3IrZURJr/PVVskg+ws5dP0JlrU96aOtuo7LztR8DufCf46wl3QrGK1hn6Oz8aODbLMrBUZWbYZuZZlXB1AmQ4ulLbeuGZ4ZmFz4WVmZClrS2O3k7x13ks3mCk+LfzYyT/UYLqFohrjbQrMXCUkq3GDxGFGWkXjWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vazrU3hg8GnTemUh0+7TJ0LjUAULn1IHwuQ+D27Zbh0=;
 b=hcq85dn6ijs9pvSPpGN/3nGSP0G7yIbYVVSDUSigyP0s7o7Nn1lxUy7sE+NsvWa4x5K0lcz3RHbKMhUtznSCE5VsDJHnBRy3sFGnO3OuoaV3h1T+480XIX2LOuvXCY8BwNA+ZS7RIJSIPwQsJqh3sdC7KOLaOchf3VdE2ETQZvlIIVtRpKgwQm5pvRkIiDpxywA1dG8STc3i4M5oYaFHwIeoCd4adteJ6FwwHQ38NMEr7lITtNtD/3By2dpMePpinGdKmeq1Njpvqsn1s5GlO5wy+AwUdzXfgoslWsQbW9nj+SS7S1ApYki7IuzOeY2fpVS2btuSQatIBCpQiFmVWg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ5PPF6D27E3EA3.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::998) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 5 Feb
 2026 09:04:47 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 09:04:47 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v4 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v4 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHclgipVdHWZsoTDkm9jZaLfut9hrVzyAKAgAAIrPA=
Date: Thu, 5 Feb 2026 09:04:46 +0000
Message-ID: <CH3PR12MB75480C1F1BECF9FF1F55B663AB99A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
 <20260204190008.20070-4-skolothumtho@nvidia.com>
 <c9f00721-d36e-4a76-a5c5-9f23ffa62080@redhat.com>
In-Reply-To: <c9f00721-d36e-4a76-a5c5-9f23ffa62080@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ5PPF6D27E3EA3:EE_
x-ms-office365-filtering-correlation-id: ef5144a9-5861-40a4-bf66-08de64959c64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cXhCVkg0MmVua0ZyYW1BYzljVDgyenUxMkVDcUFrQnNzS08veXhJall4eHdU?=
 =?utf-8?B?UTlkWWFkM21iR3pHdktVM3pYS2FRRzZRZWorVGMwcWp5dFhzaC9hMFJkM0ZR?=
 =?utf-8?B?a3J6SUpwWkRCU2JEb0ZiZjJnN2hVVkppemt6Z1AyRUpITHRoSkFzaTNpM2lY?=
 =?utf-8?B?M2QwQlpXZUcwVkNKR1h1eXFxREdveDEzVkptSTVTQ2NUYnhYZkxvWDk3Q3N5?=
 =?utf-8?B?RUxXY1Iwd2FxTjlnMUpSRy9WaW5mOXE5MnN4M212VkE3a01kQThYa0VIbUJD?=
 =?utf-8?B?UC8yam84bjNkaGdVb3hIalBZTEhsV2dmdHZXR2VwdXBoTVVoalpZd0VXWHF1?=
 =?utf-8?B?cjdrSXdmajNyTG5ROG1kNlJCQ0xDV05qWlFTQ2JHNGpHcFdtMVVxbHFncVpX?=
 =?utf-8?B?K3VyT0ZlQ2lUREZPVzl6NzFnZ2gwbWY3R2laVXNramR3ekRZQnVhMGw0Tmp6?=
 =?utf-8?B?WmEydldjNDRMK2l6dlgySGdoZ01hRC9PVXQ0OCtZNlFFMzZ0MjBuQkhtbG5Q?=
 =?utf-8?B?UFhScDF4N2o3SS83QjR6V05taFp3Wjd4bXA4Uk9aWFdkWFVzWjdrV1cxZUp3?=
 =?utf-8?B?US8wZDZCQU01K21neGRpa3A4dFBEK2QrbFB6UUJwb2EvdEdXejBaVlVMMG5H?=
 =?utf-8?B?OFpLYzZ0Tmw1c2dTVTRpYkNOQ2cyNzVoOSs5a0pZQUExNzVNcmhyRTE4Zy9j?=
 =?utf-8?B?bmVhSmxhSnZ3TFI1Qnk3WW04cW5oQlAwMHdjMFgxRmVyZmk3UnErUWRRaUhr?=
 =?utf-8?B?dVZuUUZJS2ErN05tUWZoRTJyeGx5VDZ1eGpnY2NjZTN1Lzk4cTNGeVVja2NF?=
 =?utf-8?B?a210QWUwV3hSakdYdkV3S2s2SHIwSitGQ3E2Z0JkZkIzWkZMbnpqT3NsWGRm?=
 =?utf-8?B?S0RoWEIwQkV2SjhYQnNENDRCT1g3MnY2bEp5QmNxOHIyQ1B5S3BCZ09KZGYz?=
 =?utf-8?B?c2Rrc25sM0Y4SmE1aHlZTTFMaWllUlIwRlhOeERuSHN4N2NvTWVIbERwZTVP?=
 =?utf-8?B?UWsrWlRjZjkwVXZ4R2ZuSEprSHl6RmlITGVjZDdBQ2pxbmV0WG4wb1VOUldh?=
 =?utf-8?B?SFpOeVBqU1VIR0JtSGJuR1pmVkNJTFhuc050bitaRGVCVllzM1pqYVJCTEls?=
 =?utf-8?B?QndGdUN4ZU1WTk5BbXAyUDhUQ0xCLzRYdUd5c3dhSzhYSnlxM09OT1hBSnJx?=
 =?utf-8?B?aTBWZS95WkFmYktiQW52Ym1yNVRCSUZiYTkrbFVhWmdoczNLdmRPWHh6WCtB?=
 =?utf-8?B?Z05KbFRUSHp2WlNOcGtXb2NrRHhkQ3lEMWpoMWFCUUZSbGhRK2hsUDB6TmpG?=
 =?utf-8?B?RzFQa2F5N21mTGFabUp0WHhzQXpHcVFzRDFXUVZqTGtGLy9yWU5Dd25Zb1c5?=
 =?utf-8?B?Q1VpeHMxcTRteXpKcng0Q0w5bjBGN3pnL0Y0aHNzODA5ZFN4d1lOU1lHcUQ1?=
 =?utf-8?B?MGRVTDZGSVk1dFdjbCtiNzRZazhLVGw3dGc1aWJGK1hyYnpIamY5S3pDRm5R?=
 =?utf-8?B?OE1QTjZHbDAramFVZ2hwaTgzNGsxQkFtWEQ5NmN0UzlnYW05S2VJaG0wdEZr?=
 =?utf-8?B?LzFrcm9MTGNVbkp3UjcrK1pNQUVFMlRpV1RQZ2F3UUpVOG9mQldSeGFTS2JI?=
 =?utf-8?B?RERIRXo1S1kvTDZjVGdVc2dWcmpwSnpvL29rUCtBRFh2RlZmZEZaNHJWS3pt?=
 =?utf-8?B?TGpLNkY2UkZFeXI3dVVFRGVVeTZHSWx0V2FLeUZ2bnlIQUhORmFjc1J6NjA2?=
 =?utf-8?B?em5ZVnI0WFZnK1h6aFE2dGNxZU1tOW02VVJhb1M2VWJ3UmtJUWtRQ2ppY3or?=
 =?utf-8?B?ckhrK1Q1TkhIb3dDaFhqS3NNYS9ERUIvdmtUb1BSUjFoZTREeTk2SzlDQ0lC?=
 =?utf-8?B?R1lZVFBnNjhYbUw2U0tjYmxUcSs4VmNuT2lCTDkvbHJYOFlWRHlaV1RFVGxZ?=
 =?utf-8?B?QTJTYmlJZ2VvVHZhSktoL2QyZHpJbVcwZldBczkvZWI2UUtmczdhbHBVa1gr?=
 =?utf-8?B?UHhPc3JjMzE1Tk5tSjlEUW5lUXlGdjRVYVVwVFNmV1RQNGo1UWVrYVJPVVRx?=
 =?utf-8?B?RWJzb3JHZnpmSzliSmRmdm9aL0xveUwwS3dKeklHdWp6Z3p6RUFWME9QZ2pM?=
 =?utf-8?B?WUdROUJ2U2hHNlFSWW9BOHpuY0Y2SXdLNW9mV3NpcVJmV0FITmhSNXdCcGx3?=
 =?utf-8?Q?AYSfgZmZZjmzv1aRIt9HVE0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzBXK25rZkkzazZPbGxhaWI2V2JlUkJYNXZuaFhaMXhFendoNnArcU14VUE5?=
 =?utf-8?B?SUN2dmlSOWFtNjV2b1pSSDkvUkRRdlhzaDdXWjZMdTZFdENOUytyOWV5Sjhj?=
 =?utf-8?B?Umg4dWhRSkxIM3ErQ1hrcnZVMzBodEYwbG9BckVxTXAwV2FXcE5Bd2NQOEww?=
 =?utf-8?B?LzB5aTZmS0hHbXFZN0FoSWJSb055N3ZnN2ptWTFrVjZRT3NFL2JYYjVxL1Nk?=
 =?utf-8?B?UWxTTnlWRGloVGpFL2dIMnBjcER2U1pwckcvUGt6aWhhak40c3g4REtDQmVX?=
 =?utf-8?B?elNseUQ0Q0RiUlhJdDZnRW1rNk02eGlrNUNzZVFMS1BJVFlMVzNHNVE5WlF0?=
 =?utf-8?B?WWxsUXAraFZsVkxOaExUQTc0M29MdlZQR25WRWRpNGloeGNkOUhTdEVrVmRW?=
 =?utf-8?B?b3NkdS9nNHNJTXV0TlhaUVVHc1dRd0NJUGFHMjdFMjJ6MGVLb2FsUTVSanpK?=
 =?utf-8?B?Z3padVpEUGpxR2k1dUlDNU0yZHFYWmRtNkdSMVJlc2toQTdiVjIvakExRGdH?=
 =?utf-8?B?cG9QajFQTnAySWZYRWE2VUxFcGpVdjVkeHNYUkdoM2wzQTYyWExFOW96YXBs?=
 =?utf-8?B?dCtHdit1ektpajZCdnlHVmxYWkx5a3I2Z2Zmd1ZwNkxNRGx0YTEvanVBVlJv?=
 =?utf-8?B?L2NYSDFzcUJ5L3B6M2gxU0xmK2ZSdWF0VTlsSFJSemNHZUFVeDVOWkFDU2w0?=
 =?utf-8?B?d1ZTdjRIMENWM2FmMG9XSlZPV1BrQ215MnBrQTJuY3BYSjNnL3YzaE0wM2ZK?=
 =?utf-8?B?TksrOTNBMDBqOHFhT2VOT1VoYUR6TVRFRFk4bmlnQThKL2tmdlc0M1FnQVpX?=
 =?utf-8?B?dXIzYndTcG1xeHBOL3FMcEZCbzJTSS9iVXNPcEptTi9xb3UvdjBJdm1vaDZQ?=
 =?utf-8?B?NXpqVDNBbktnd2E1K1hyV2pPMHBvc2hYeGZOTUw5VVJLN1hnUWV0VisxekNM?=
 =?utf-8?B?dEJUSHQ3Uk50bnRYaFlPZnRtSHRHYStsdGxSMWVhZmZwN2Rld0g0NUFQTXlU?=
 =?utf-8?B?aHhSWGNrMTluQnBScWJXMThENFUxdXBOY1d1OThMOTRuZWs2WVpQcmRsYzhi?=
 =?utf-8?B?OGVMNWhpV1RrN3Flb0RMaVBZL1hkRlZzbXd3NFROeVJuejZHdW5oaVFaaTVq?=
 =?utf-8?B?am5KRDJ0UkpHVStyaUZGMnMrazY0bzdQYTJLOWFJYm9xMUNTc2hqbVRsc0dS?=
 =?utf-8?B?b2orWUw0SGMxeEVITzQyS08zY3kvd3pRK1BjMzNpRHRCMS9Fa3FlOG1ROGJs?=
 =?utf-8?B?Ri9obVh3dzFqYVVDb3hrR1hYc2c2WFI4UmFOVThwOW9JQ3BIN0VSUmxhUEpi?=
 =?utf-8?B?ZzVBVnd1NnEwSXhKalpsZE9lZnR4OXBWdGZtbDBGU0c5TUF3d2hyMlVSQk1j?=
 =?utf-8?B?U1piUi8yd1J1SEhzSkhzZklSc3RsbUlQYkUzWXpJc05zaEZDTy9ZK2M4Z0dW?=
 =?utf-8?B?RlNIS2R2NGZIYTRrN2dVVzVCb3FJRTI1NXg3Y05CTXdjNjhaeTJzdVlQS2Ry?=
 =?utf-8?B?WjV3aHIxQkx4V2YzYkcrRFMveEtsKzF3S2oyV1hvb1gyamRCdXBuMEVmWUs1?=
 =?utf-8?B?QWdvT244alJqbUluR1ZYTjIwaGlVSmFRZDc2aGhIbHppRG0yaUJPVmFyM0Jq?=
 =?utf-8?B?K0ZoeHVxNWxPWEt6TFhCYyt2QWR1cDVHckMyTitpcXR4bWZ2YWwvbTM2dThm?=
 =?utf-8?B?NVhOSGdLbVQzUnJ3RUhJSmQrZy9IMkFsTXdxRC93WXRRM3pHNWVXc0xFZ2Vn?=
 =?utf-8?B?aFlwNmVQTW1oaDU0blNDeGk0OVA5bXVuWTMveEFldmtsMFlOSnVlbzc5bjRR?=
 =?utf-8?B?OGFiNWRyUldTZDJ1MCtMeEE1aDdwNnB4TCtFbnlYUHVxTmFiZnNWaTFTVEJE?=
 =?utf-8?B?aXpPUHVJUVcvSW84Y2VHb0hTVXdiYmoyNEF1QjRlaWp0WWJzR0Rsc2lJcUJv?=
 =?utf-8?B?STlidWZVZVZ1bWIxcUgwRit0M3hjQ0wxcVF6aFpDVlFmN0ptbzRIZXhxRWJ0?=
 =?utf-8?B?empXM1dvdlhUWm51NENkWTl3SE1kNElrVk5kRmpNcWZDMUhDaXZwYU5DQk5q?=
 =?utf-8?B?QWhza1JuNzloVmlJaHp3ZndiZml3VTRxaXFuLzY5MmRNVmlqbEt1TXdvMSs2?=
 =?utf-8?B?R3YzRnpMZEJlSUNCekJBRG82ZGZNSHBVWSsvaDF0ZnA0c3M2NldKQ2hQTWxp?=
 =?utf-8?B?eDRTamlKS0FVNElBV2pYbzU4Q2tXempqQmlNZjRFMWF0VFZCcjFrTTkrakJ1?=
 =?utf-8?B?dXUxbnN4QmFJOXA3eVJTVFBxd0gvZDQreGhnUElvT0drWWFKd3g5NmVFYjlj?=
 =?utf-8?B?RWNHNHVodjlQdmdSQ1NPYmx6TXdrdHNJUFRKZU1LMjhDMXlpZGZ4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5144a9-5861-40a4-bf66-08de64959c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 09:04:46.9815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPIYLZd/+s0tMHowoslu6rvggx7am7cOjnzxuz4hrtFniAJ+w6ZcoT/QsA8mgaU/5gzvqVGhj6hi9Q7qzOhwOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6D27E3EA3
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNSBGZWJydWFyeSAyMDI2IDA4OjMzDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUt
DQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0
aGFuDQo+IENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlh
LmNvbT47IEphc29uDQo+IEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5jYW1l
cm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy81XSBody9hcm0vc21tdXYzLWFjY2VsOiBBbGxvY2F0ZSB2
RVZFTlRRIGZvcg0KPiBhY2NlbGVyYXRlZCBTTU1VdjMgZGV2aWNlcw0KPiANCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0K
PiBIaSBTaGFtZWVyLA0KPiANCj4gT24gMi80LzI2IDg6MDAgUE0sIFNoYW1lZXIgS29sb3RodW0g
d3JvdGU6DQo+ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+
DQo+ID4gV2hlbiB0aGUgZ3Vlc3QgZW5hYmxlcyB0aGUgRXZlbnQgUXVldWUgYW5kIGEgdklPTU1V
IGlzIHByZXNlbnQsIGFsbG9jYXRlDQo+IGENCj4gPiB2RVZFTlRRIG9iamVjdCBzbyB0aGF0IGhv
c3Qtc2lkZSBldmVudHMgcmVsYXRlZCB0byB0aGUgdklPTU1VIGNhbiBiZQ0KPiA+IHJlY2VpdmVk
IGFuZCBwcm9wYWdhdGVkIGJhY2sgdG8gdGhlIGd1ZXN0Lg0KPiA+DQo+ID4gRm9yIGNvbGQtcGx1
Z2dlZCBkZXZpY2VzIHVzaW5nIFNNTVV2MyBhY2NlbGVyYXRpb24sIHRoZSB2SU9NTVUgaXMNCj4g
Y3JlYXRlZA0KPiA+IGJlZm9yZSB0aGUgZ3Vlc3QgYm9vdHMuIEluIHRoaXMgY2FzZSwgdGhlIHZF
VkVOVFEgaXMgYWxsb2NhdGVkIHdoZW4gdGhlDQo+ID4gZ3Vlc3Qgd3JpdGVzIHRvIFNNTVVfQ1Iw
IGFuZCBzZXRzIEVWRU5UUUVOID0gMS4NCj4gPg0KPiA+IElmIG5vIGNvbGQtcGx1Z2dlZCBkZXZp
Y2UgZXhpc3RzIGF0IGJvb3QgKGkuZS4gbm8gdklPTU1VIGluaXRpYWxseSksIHRoZQ0KPiA+IHZF
VkVOVFEgaXMgYWxsb2NhdGVkIHdoZW4gYSB2SU9NTVUgaXMgY3JlYXRlZCwgaS5lLiBkdXJpbmcg
dGhlIGZpcnN0DQo+ID4gZGV2aWNlIGhvdC1wbHVnLg0KPiA+DQo+ID4gRXZlbnQgcmVhZCBhbmQg
cHJvcGFnYXRpb24gd2lsbCBiZSBhZGRlZCBpbiBhIGxhdGVyIHBhdGNoLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFRlc3Rl
ZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
U2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4g
IGh3L2FybS9zbW11djMtYWNjZWwuYyB8IDYxDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0NCj4gPiAgaHcvYXJtL3NtbXV2My1hY2NlbC5oIHwgIDYgKysrKysN
Cj4gPiAgaHcvYXJtL3NtbXV2My5jICAgICAgIHwgIDQgKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdl
ZCwgNjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9ody9hcm0vc21tdXYzLWFjY2VsLmMgYi9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiBpbmRl
eCBjMTljNTI2ZmNhLi4yY2EwZDFkZWFjIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11djMt
YWNjZWwuYw0KPiA+ICsrKyBiL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+IEBAIC0zOTAsNiAr
MzkwLDE5IEBAIGJvb2wNCj4gc21tdXYzX2FjY2VsX2lzc3VlX2ludl9jbWQoU01NVXYzU3RhdGUg
KmJzLCB2b2lkICpjbWQsIFNNTVVEZXZpY2UNCj4gKnNkZXYsDQo+ID4gICAgICAgICAgICAgICAg
ICAgICBzaXplb2YoQ21kKSwgJmVudHJ5X251bSwgY21kLCBlcnJwKTsNCj4gPiAgfQ0KPiA+DQo+
ID4gK3N0YXRpYyB2b2lkIHNtbXV2M19hY2NlbF9mcmVlX3ZldmVudHEoU01NVXYzQWNjZWxTdGF0
ZSAqYWNjZWwpDQo+ID4gK3sNCj4gPiArICAgIElPTU1VRkRWZXZlbnRxICp2ZXZlbnRxID0gYWNj
ZWwtPnZldmVudHE7DQo+ID4gKw0KPiA+ICsgICAgaWYgKCF2ZXZlbnRxKSB7DQo+ID4gKyAgICAg
ICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsgICAgY2xvc2UodmV2ZW50cS0+dmV2ZW50cV9m
ZCk7DQo+ID4gKyAgICBpb21tdWZkX2JhY2tlbmRfZnJlZV9pZChhY2NlbC0+dmlvbW11LT5pb21t
dWZkLCB2ZXZlbnRxLQ0KPiA+dmV2ZW50cV9pZCk7DQo+ID4gKyAgICBnX2ZyZWUodmV2ZW50cSk7
DQo+ID4gKyAgICBhY2NlbC0+dmV2ZW50cSA9IE5VTEw7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0
YXRpYyB2b2lkIHNtbXV2M19hY2NlbF9mcmVlX3Zpb21tdShTTU1VdjNBY2NlbFN0YXRlICphY2Nl
bCkNCj4gPiAgew0KPiA+ICAgICAgSU9NTVVGRFZpb21tdSAqdmlvbW11ID0gYWNjZWwtPnZpb21t
dTsNCj4gPiBAQCAtMzk3LDYgKzQxMCw3IEBAIHN0YXRpYyB2b2lkDQo+IHNtbXV2M19hY2NlbF9m
cmVlX3Zpb21tdShTTU1VdjNBY2NlbFN0YXRlICphY2NlbCkNCj4gPiAgICAgIGlmICghdmlvbW11
KSB7DQo+ID4gICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgfQ0KPiA+ICsgICAgc21tdXYzX2Fj
Y2VsX2ZyZWVfdmV2ZW50cShhY2NlbCk7DQo+ID4gICAgICBpb21tdWZkX2JhY2tlbmRfZnJlZV9p
ZCh2aW9tbXUtPmlvbW11ZmQsIGFjY2VsLT5ieXBhc3NfaHdwdF9pZCk7DQo+ID4gICAgICBpb21t
dWZkX2JhY2tlbmRfZnJlZV9pZCh2aW9tbXUtPmlvbW11ZmQsIGFjY2VsLT5hYm9ydF9od3B0X2lk
KTsNCj4gPiAgICAgIGlvbW11ZmRfYmFja2VuZF9mcmVlX2lkKHZpb21tdS0+aW9tbXVmZCwgYWNj
ZWwtPnZpb21tdS0NCj4gPnZpb21tdV9pZCk7DQo+ID4gQEAgLTQwNCw2ICs0MTgsNDEgQEAgc3Rh
dGljIHZvaWQNCj4gc21tdXYzX2FjY2VsX2ZyZWVfdmlvbW11KFNNTVV2M0FjY2VsU3RhdGUgKmFj
Y2VsKQ0KPiA+ICAgICAgYWNjZWwtPnZpb21tdSA9IE5VTEw7DQo+ID4gIH0NCj4gPg0KPiA+ICti
b29sIHNtbXV2M19hY2NlbF9hbGxvY192ZXZlbnRxKFNNTVV2M1N0YXRlICpzLCBFcnJvciAqKmVy
cnApDQo+ID4gK3sNCj4gPiArICAgIFNNTVV2M0FjY2VsU3RhdGUgKmFjY2VsID0gcy0+c19hY2Nl
bDsNCj4gPiArICAgIElPTU1VRkRWZXZlbnRxICp2ZXZlbnRxOw0KPiA+ICsgICAgdWludDMyX3Qg
dmV2ZW50cV9pZDsNCj4gPiArICAgIHVpbnQzMl90IHZldmVudHFfZmQ7DQo+IA0KPiB5b3UgbmVl
ZCB0byBjaGVjayAhYWNjZWwgYmVjYXVzZSBpbiBjYXNlIG9mIG5vbiBhY2NlbGVyYXRlZCBTTU1V
IGl0DQo+IHNpZ3NldnMgaW4gc21tdV93cml0ZWwvc21tdXYzX2FjY2VsX2FsbG9jX3ZldmVudHEg
cGF0aA0KDQpPb3BzLiBSaWdodC4gV2lsbCBhZGQuDQoNClRoYW5rcywNClNoYW1lZXINCg==


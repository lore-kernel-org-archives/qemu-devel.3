Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012E1C71149
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 16:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkQJ-0000Hn-4g; Thu, 12 Jun 2025 12:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uPkQG-0000HM-Dq
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 12:05:00 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uPkQD-000440-Mo
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 12:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1749744299; x=1781280299;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TvwHU5l6KJP+IniROWWQeZUBTtnhs9H3XZDtMbl0GE8=;
 b=leKkfx1OYZpIt1ZWyTAvcybEJANepmyvN97VPC3i7FHrNc68s/50ITLy
 JTMuBgkhniLFgqOkW4wct14KZvgEHMwFyP3ROLNpksO1pgVg6P7l3Wfsk
 fT3mB3Gp7df5iFisDEBTJE20He0291rFb4BJKqLsr8Cgm60LXtNkFHqud
 /xiGQYANZ36LM8xj19X6PtvFaEJzAotqhXSjFtqU2E8xK/c7Nkeev8Qai
 gFKaCFUYGe79UsIHTT+pGQOqBfyuYx1eXv9dfmruJNCjCXcr7fF2re9mP
 V8FLv1HpXpluU+YLeASilYpr4P/BhpT002zVs2Jdy5pLJKijnEOsRgwLL w==;
X-CSE-ConnectionGUID: ktZKIF2NTg6pa7dE7MuLxw==
X-CSE-MsgGUID: JvpbJpLaRGq4ULLP8q8UHg==
X-IronPort-AV: E=Sophos;i="6.16,231,1744063200"; d="scan'208";a="38635987"
X-MGA-submission: =?us-ascii?q?MDHIF/R5RRov0KlYsY1WP9Sa7xm3VJ6rBxHavM?=
 =?us-ascii?q?vbHCLE3NUcHkkiKsFcLODglgCFL7CEZh38ihA2zBE4XrqqRAG+GK6nDl?=
 =?us-ascii?q?MvL0Tw1OLCUxfZzgK4jV7AFqXNJ09dZZ0b354bkr3z3BnCTxqam3lSUu?=
 =?us-ascii?q?oQhcp3Wn073zbB/CU5l/SiDg=3D=3D?=
Received: from mail-northeuropeazon11012065.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.65])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Jun 2025 18:04:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCtrhu2HBGE7/5uTsdKMuoGHDdWesIub9RuAGau77lmYgpy2hDmHuKMsT/d9M6oXkN9W4cSszh2y9XS9FJMfqY7eQXerp2491v+O5z/vTd30qifkDPLN9iCxD02rPh04tV2VXmns2MF3NW6D3AaJZzretdWZErgVrgPAdweD5ug8BTsJxtQW2kSB+plYfIKVOT447MTQC9U2C9cgHnyhmTUkDUOyfpt1eRVgsOHaeICOXp7A5k9UOvwEBLLOTQM0fvLPIjllySbjxRUsPlmohzlBrhN3fPpkb/+IFUQIe5yOmzHuimjJST0IatZLXwg1GrVuLGQ3UpIT9PhtsMMhIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvwHU5l6KJP+IniROWWQeZUBTtnhs9H3XZDtMbl0GE8=;
 b=HVFi30yhUOzt8Q4HOitYSHQLhU+LKhjW14jktctiN4LHEtgBG5b7vSc3cCVELyQG5+JhjDw7RUuQLOFCq5kOAvne9NWFGCWPqr5C/VWv7JtDqRPeJrxjcWqv706NtS71qy9PvEHi1pDEkYZRuAU23k35+Fb3kUoJztRO80ArxfpDZRduhq/R5OGMABw3u7Ru/TXFZbG4y17rqdA+YOjTafR7A2ujCF0ma5SM9aLFnMHiHRSnu/msK0ixoAon3JAL0FsV2SCQjQpN9iVRQ5ihG11lTwJPL3f85hsiG5OQSkpCyDijCQu+lnxa7vCEWyu16oYbR0rn1d1ukZfK9t/Y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvwHU5l6KJP+IniROWWQeZUBTtnhs9H3XZDtMbl0GE8=;
 b=DUODTxSC2jLug2HOBTXMQVO1x2Xng1dgDj4+aaK5SA5K3VI6ecM2BI6dl7eHAhqzwfQKSf4bvMfuSrvTO+SvRtF6LdmHKS1D9xwxb2ak74QHgHyphU6BCpDbQqfeloMLDEW6RZBkk6uiui4AxVwqCanWqc5G4Gy7y/nbQNrcgvlcTI6JtvcXc+43beoCABXr5mlgyfB4td0sTE+q+KRDltS87q9mFwwZZUaj2jgEX86XDTjODSVEpzbXaA4xNEV3/xITu0sKmHgNd6wc1No4+qGhXVL76p4aRLOQVh6pvTN1SS8HNcH6r2SAGiDfRxYJB4qtYVX/mucuC/aB+G7FeA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB8994.eurprd07.prod.outlook.com (2603:10a6:10:40e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Thu, 12 Jun
 2025 16:04:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%3]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 16:04:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 04/15] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Thread-Topic: [PATCH v1 04/15] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Thread-Index: AQHb1sr2J6HvAPDqFkC/O/GhbVo+27P/ucUA
Date: Thu, 12 Jun 2025 16:04:46 +0000
Message-ID: <1cf2ecbe-1f98-452f-8a39-331e7d459969@eviden.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-5-zhenzhong.duan@intel.com>
In-Reply-To: <20250606100416.346132-5-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB8994:EE_
x-ms-office365-filtering-correlation-id: 30b74b6c-e84b-47f0-7a52-08dda9cad9f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WXFoL1NXb1NxeEx0UU04OFNWWnhLVGVMVzFLaTNnTUtOZjhFdTBJWDRSQlZw?=
 =?utf-8?B?QnpOSDRBZVZsRUJmUWluMUVySW94b1QvSFI3Z3I5a1VNMk9ib2FaL3daVE9V?=
 =?utf-8?B?SkkrZ0huaHE4UHVxVTZPNFdsRlBtVlNqNDljbjhmbkMvQ3BTajBHbkZkVlpP?=
 =?utf-8?B?UnhBdGhTMTE4Wk9XQU1adHJ6U29YZUcyVVdwa0lzNkRJbW9LKy9PMzJ4M0JR?=
 =?utf-8?B?U2ppRzR0dXdYZzA4NGtnbW5sTmJudllnN1RJUXJHRkNLczdWNGNYSGl1M0Fo?=
 =?utf-8?B?ZnZSMlRpaVZwWENJYzB3ZTBGMW5KMUlLQlNMYjVuSkVLaEVxL2p5SVd1ODV1?=
 =?utf-8?B?bjVYUXljemlEMlRDK2dWaUNqS1J1R05EdWRPWFJEbkhaTWh1RmFpcUphMEJt?=
 =?utf-8?B?L0EvMlRVNm5XTWxaZEtwZVNsMVlob2ZVS1c1ZFpGajhLTjN6M2o1VDJENUVw?=
 =?utf-8?B?b2ZHQ2dyZmc1cHJtOGRGWElyS1dVLzJLUXYya1RtaWtxSG1wNmpHd3czZkVk?=
 =?utf-8?B?dlBuems1K2l6dm5pTVorNTI0M0MxaG1zU1Z1YjZJWFl5SjRoUURrbzhmMGhL?=
 =?utf-8?B?Z0JxT2NNTUUwTFF2RjFHQVZCTXJDZWZsVGF6NUIwSmlycUZDc2tHV3V6MGxm?=
 =?utf-8?B?Z2NHMDZsNG9sQ2hndVMrU1BxUTlRRVROZ3kvQ1BIODkxK0lyeXZQalZnS2t3?=
 =?utf-8?B?SGplTDJvYWUyZUFGMG5HZ3RNNDNWWkpLMlVJMXlnK0w0ZFZaNzM0ZTdsdnlE?=
 =?utf-8?B?R1pITVBkdWZwZEMyeFVnQTViTStja20wYjRLdExFZEtsNjVLdU9rZjBuU0M4?=
 =?utf-8?B?Y01VbGhGN3NZalFnTGVOUnhkZUROKzZvR2U1L3FBSHcwRDNvRXo4eEtkSG5F?=
 =?utf-8?B?MXVqNzQwYlFKM1h5RkhDbWljNFRQU2poZFRHVDJtaW5GTjN1R3MxcDVWaVVn?=
 =?utf-8?B?STRkdFZqZmJHRWZ4YXFQVnZxdkFNS2FTeTZVR1JWNERSQmdMdENEQUNlc2ZV?=
 =?utf-8?B?bjExaWFiaWpuRjRFL0g0ZXJCeVBqdVMwaUpIM0oyRnI1WjR1L2tBWHlGci9q?=
 =?utf-8?B?QWFDSXdXN09PYUR5Mm1RWVRzTkVnNjdpVzc2dEx3ejN0L08vczVzUTlmeTZH?=
 =?utf-8?B?RithVUc3MU5tVG9rcDBnbjBHV0FLUCswVjF4TDlzMGljMXZ0YjNiYzJFZDda?=
 =?utf-8?B?Z0lBK25uRWJ2SG0rZXl3YUNDN1FDR1ZZSW9WMXg1ZHIvZEM2REFGRFg2WVhu?=
 =?utf-8?B?dGpsL1pneHpmR1VmTm56WVI2aCtRMWNML3JWT2h1MTlCMEgvcTFubDJLcVZV?=
 =?utf-8?B?YjFMeElnc1pkL2dqMW9xL0xxYU9hZHJVaG83WmNiOXJ6dGgzRkhEM0xOMURH?=
 =?utf-8?B?V2ZWRHdjRWZPa0d1aURjNHNaY2lFWklyMnNrMjNxbndQUXNuTWo1V2lvR2FQ?=
 =?utf-8?B?c1d6SWxkeGhyZjRmcjRSTDRlVE1qMUVmbVFZY1diY0I5NW1venB5YWJnSElo?=
 =?utf-8?B?YThuNjdSbEJnMWtzUWlYUm92WHBlU091Q0ZQT2JLdEhJcndlVUZmcjQzWXY3?=
 =?utf-8?B?QzFNSGpzdjhVY3V0SnRrYzNFLy9ZNnhLbXIxZEFpeklBaWVqV1RIbFpiWHoy?=
 =?utf-8?B?ZjhsTk02RlM3K0RSU2ZoQk1XbWcyMXVPb1V1NEdvTGJhNk9jN3NPaFJhdzJN?=
 =?utf-8?B?My82aG4yT0drWVV2L2w5L3BuS0NjZ0E5OXZxd0NTbkVEM1h2ZGhHMFUxRzlL?=
 =?utf-8?B?OUFTWHhtckdFeEoxSkpHQlFpQTRtRytOaXZMdTRjNjZYNmU3bEVlOGRuanRr?=
 =?utf-8?B?SG94a2Yzam9TMDRJMDd2M0YxRFE3QmEzc2h1MEJMQ2puZ0xQRmV0TXRrWWZD?=
 =?utf-8?B?ZzBKWFhxNmwvVW1sdVJTcUU1MU5SWWlNNGJGaDZTUUJDa2hOOVNhbjRIYTYw?=
 =?utf-8?B?OUszd25GUy92M3U0Qll6UWhsTUlMaHc4TGU2eEV2bG9nYmp0TTQ2MkNBWXor?=
 =?utf-8?B?ZWNqZmJwY3lBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2dRT0taTGdoYmtFQkRqTnFKRWdkK1FHVVNLL3Bia0l5YitlRmtxN0lhcnVM?=
 =?utf-8?B?UTFSZkhhVjhDL05pS3pIMVE1TzFwMElNdUQ2UklIN3k2WW5pR3IrbXNJTUpy?=
 =?utf-8?B?KzJyK3NBcWIxTyswOWs0dFVOeGdRd1RiUENWdFZINTZWVWUveDhsaGI2ZUF2?=
 =?utf-8?B?dXZhWWNhU0taMlBiUEVCRXk4ZUdzRWhrMFlnTnFDa3dIT01GbW52QmxiRHhz?=
 =?utf-8?B?WXg5aXdxVUc1cysrQkczSytPTGNGaTIyQWF2MFdCV0c5dnZCQXV2aCtXaE0y?=
 =?utf-8?B?NTVweFBMVmwxU1R0R05ZSFNiUVROODJjbm0zcnoxeTFnY09rMXVwVUFPL0p6?=
 =?utf-8?B?eW5na0xETHk5YXYrNy93c2NlbVJiaWdRV2JreEZtOHNHR3NhOVI1K2lObFQr?=
 =?utf-8?B?b09QY1pweVM2dnhRY29Dajg0NU55cmJINHVoSERwNmI5TGFnM0MvRk1tS3BV?=
 =?utf-8?B?N3Bkelh1U2UzYnIzb2dtU2JOUThYb3E1VHlYZGNMNmRUbEhnVkNhRWJ6Y1ZQ?=
 =?utf-8?B?K1FMdHRRUktyWG5vQmhXNEZuSTBvN1JCQ01jdXVWSjRWVnUyS1hGbG9kaGs3?=
 =?utf-8?B?ZDMyOCtYWnZIUFFTV3g1K3RzUkwxQ0c1RmtTNy9pOGVKSzZzaFhxU1RWaDlE?=
 =?utf-8?B?aURpaHVyeDNiZnBrcVd3akZjK3lDUXFaUWdkT2lxSWV5K2M0azdyV200VHlk?=
 =?utf-8?B?MzAyOEdjY3hXcE1Da3VSVW8zWStaQ1dna0tMK0ppZUc0Z3RhMzRHaTB5eGVJ?=
 =?utf-8?B?KzM3dklDWjBnN3hFWk44eEorNmJXOE13WFJGM0dGKzI3a2h2QkJ3cmt1RUkz?=
 =?utf-8?B?QU1qbS9iNC8rUFQ5ODlMSEI4cnNHdDN0R2pCUjdBRVJXeWtwSUxZbmFWNmdL?=
 =?utf-8?B?Nm84QnNaaEd2TDNaSGZwa052TEhrcHRVSU1HZ0lKbmNBSlVRVHlrNXhjOXpL?=
 =?utf-8?B?MEpnZXdmaU41UnFXTVJOM1VHTXdmN2d1MFkydUdlcENSSkMrRU1xWVhyWWlC?=
 =?utf-8?B?SWNGNnFVSHlReis3MVBKajRIbWptVFZRMkhUY3EzTldoWm5aWjNiNmdYT1FM?=
 =?utf-8?B?Qk5UYXRLY1pkSFRvdm9HNmxhWVdFTFc3V2MrSG5kNHIyOXJEamk4eDZsYXJ2?=
 =?utf-8?B?ZlI0TGxaeGdZVnhBQlRON3d2ZHdQL1E1QVpJZGg1YlFLRGZ3dGQ3SnNHNlR4?=
 =?utf-8?B?UVR1SUN2eWJ2NWwrOW5NQUdUMWZEbUxSU08rNnhOQzZ3ZWdpaWxzblBkVFcz?=
 =?utf-8?B?WmlDd0dsdE1yMmJENEhzOEFkQThBbVZYYUZSY3c3Q2hib2UxQWlBR25salAw?=
 =?utf-8?B?RnR2VUhkQ2JFeEpuS3FWbHY0YkZ4YVJqOGtHQVl0ei9zMHI0NHpmVGFKSGxR?=
 =?utf-8?B?M0xiSDJWSWdXY0RzTWR0QzdydkpLMTdySjVjT1A4aGlKeHJsc3daRERpMmNm?=
 =?utf-8?B?czJlKzdIdHRrYlJ2UnFpS05tSmNHV2JkVkp1c3MvUlpadDc5Njd2R1kwZERn?=
 =?utf-8?B?MUFoZkY4Q2Y4TXA4MzVIbllDMmcwSm5ZT3hSeFM0SGk3aE4vZ0ozRGtNa0xC?=
 =?utf-8?B?MTNHeUhoSnRNNGp0YWcyMnptMU9BR0NFSXVsemFWU3A3aHBORWhPQ0xxMEs5?=
 =?utf-8?B?Ukc0ZUpuU0l5MlV2SjFUSEJqWUNKbFNQWVdqYVVjd0FPekZxak8xU0JOcE1s?=
 =?utf-8?B?OFhNS0t2NDdsN0tOb1k1c1o4bkRVdlZPd2F2TG16YzRQZjFkSlArMzdPUUVB?=
 =?utf-8?B?Z1l6dXQvNVVyUjlvVjM0aWpoVE0yN2hqaC9xZ0VMdEd5ZytyM3NnNmI5alpo?=
 =?utf-8?B?L295WllRdlJIUm1IK0RZcW8wMVlxUzJ3TkQwVzBramtXdDBRUGg1bFZyUzFs?=
 =?utf-8?B?M2huV0ExQkV5NjhvQzhHVkgvQ3B0c05uMnV6cjZFanVNb3kzc0JRRjVyR2Fp?=
 =?utf-8?B?eUlwTHBWdUNNVkV4OENQNU9JSThWSnQyV3lCdDVPdXFJek1CS2NVaTRGbWZh?=
 =?utf-8?B?Z3VQeHFEQ0dlRHZCQXpaVjFMbzd6N1JHb3NlMURFTWtUL2JVajB2Nk16ZnVB?=
 =?utf-8?B?Q1J5V3RzUTVkc01kR3pmS3hQQWJhNEh0S0wyY3E5LzkxZ2tYSnZ2Q1VEU1dD?=
 =?utf-8?B?ek9uT011aFdwTGx3M2lqQ0pVOUNlU3ZvcGNQYXdrQTRibXl6aTQwWTdSQ05I?=
 =?utf-8?Q?0l/LGXfy9NAsQ92U43KPJgs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41F9AFC79D78C84AB6B4C9E37430DE7A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b74b6c-e84b-47f0-7a52-08dda9cad9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 16:04:46.1010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKJ1iSV4PUwrv3msPaAVi/ZX3Yre1Sc0RDeYJgyNcD2pWhLA331vq2UqJNpcbqwAnUVYbtBnDc1tQiAJV8gZsFCnKE8ozGY55XrCLlClx6Zosgc3LCJpbQ8MyjNr9wGx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8994
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SGksDQoNCk9uIDA2LzA2LzIwMjUgMTI6MDQgcG0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBD
YXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sg
bGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gSW50cm9kdWNlIGEgbmV3IHN0
cnVjdHVyZSBWVERIb3N0SU9NTVVEZXZpY2Ugd2hpY2ggcmVwbGFjZXMNCj4gSG9zdElPTU1VRGV2
aWNlIHRvIGJlIHN0b3JlZCBpbiBoYXNoIHRhYmxlLg0KPiANCj4gSXQgaW5jbHVkZXMgYSByZWZl
cmVuY2UgdG8gSG9zdElPTU1VRGV2aWNlIGFuZCBJbnRlbElPTU1VU3RhdGUsDQo+IGFsc28gaW5j
bHVkZXMgQkRGIGluZm9ybWF0aW9uIHdoaWNoIHdpbGwgYmUgdXNlZCBpbiBmdXR1cmUNCj4gcGF0
Y2hlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8
ICA3ICsrKysrKysNCj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgMiArLQ0K
PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDE0ICsrKysrKysrKysrKy0tDQo+
ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPiBpbmRleCAyY2RhNzQ0Nzg2Li4xOGJjMjJmYzcyIDEw
MDY0NA0KPiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+IEBAIC0yOCw2ICsyOCw3IEBADQo+ICAgI2lm
bmRlZiBIV19JMzg2X0lOVEVMX0lPTU1VX0lOVEVSTkFMX0gNCj4gICAjZGVmaW5lIEhXX0kzODZf
SU5URUxfSU9NTVVfSU5URVJOQUxfSA0KPiAgICNpbmNsdWRlICJody9pMzg2L2ludGVsX2lvbW11
LmgiDQo+ICsjaW5jbHVkZSAic3lzdGVtL2hvc3RfaW9tbXVfZGV2aWNlLmgiDQo+IA0KPiAgIC8q
DQo+ICAgICogSW50ZWwgSU9NTVUgcmVnaXN0ZXIgc3BlY2lmaWNhdGlvbg0KPiBAQCAtNjA4LDQg
KzYwOSwxMCBAQCB0eXBlZGVmIHN0cnVjdCBWVERSb290RW50cnkgVlREUm9vdEVudHJ5Ow0KPiAg
IC8qIEJpdHMgdG8gZGVjaWRlIHRoZSBvZmZzZXQgZm9yIGVhY2ggbGV2ZWwgKi8NCj4gICAjZGVm
aW5lIFZURF9MRVZFTF9CSVRTICAgICAgICAgICA5DQo+IA0KPiArdHlwZWRlZiBzdHJ1Y3QgVlRE
SG9zdElPTU1VRGV2aWNlIHsNCj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKmlvbW11X3N0YXRlOw0K
PiArICAgIFBDSUJ1cyAqYnVzOw0KPiArICAgIHVpbnQ4X3QgZGV2Zm47DQo+ICsgICAgSG9zdElP
TU1VRGV2aWNlICpoaW9kOw0KPiArfSBWVERIb3N0SU9NTVVEZXZpY2U7DQo+ICAgI2VuZGlmDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCBiL2luY2x1ZGUvaHcv
aTM4Ni9pbnRlbF9pb21tdS5oDQo+IGluZGV4IGU5NTQ3N2U4NTUuLjUwZjliMjdhNDUgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+ICsrKyBiL2luY2x1ZGUv
aHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+IEBAIC0yOTUsNyArMjk1LDcgQEAgc3RydWN0IEludGVs
SU9NTVVTdGF0ZSB7DQo+ICAgICAgIC8qIGxpc3Qgb2YgcmVnaXN0ZXJlZCBub3RpZmllcnMgKi8N
Cj4gICAgICAgUUxJU1RfSEVBRCgsIFZUREFkZHJlc3NTcGFjZSkgdnRkX2FzX3dpdGhfbm90aWZp
ZXJzOw0KPiANCj4gLSAgICBHSGFzaFRhYmxlICp2dGRfaG9zdF9pb21tdV9kZXY7ICAgICAgICAg
ICAgIC8qIEhvc3RJT01NVURldmljZSAqLw0KPiArICAgIEdIYXNoVGFibGUgKnZ0ZF9ob3N0X2lv
bW11X2RldjsgICAgICAgICAgICAgLyogVlRESG9zdElPTU1VRGV2aWNlICovDQo+IA0KPiAgICAg
ICAvKiBpbnRlcnJ1cHQgcmVtYXBwaW5nICovDQo+ICAgICAgIGJvb2wgaW50cl9lbmFibGVkOyAg
ICAgICAgICAgICAgLyogV2hldGhlciBndWVzdCBlbmFibGVkIElSICovDQo+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5kZXgg
YzQyZWY4M2RkYy4uNzk2YjcxNjA1YyAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiBAQCAtMjgxLDcgKzI4MSwxMCBA
QCBzdGF0aWMgZ2Jvb2xlYW4gdnRkX2hpb2RfZXF1YWwoZ2NvbnN0cG9pbnRlciB2MSwgZ2NvbnN0
cG9pbnRlciB2MikNCj4gDQo+ICAgc3RhdGljIHZvaWQgdnRkX2hpb2RfZGVzdHJveShncG9pbnRl
ciB2KQ0KPiAgIHsNCj4gLSAgICBvYmplY3RfdW5yZWYodik7DQo+ICsgICAgVlRESG9zdElPTU1V
RGV2aWNlICp2dGRfaGlvZCA9IHY7DQo+ICsNCj4gKyAgICBvYmplY3RfdW5yZWYodnRkX2hpb2Qt
Pmhpb2QpOw0KPiArICAgIGdfZnJlZSh2dGRfaGlvZCk7DQo+ICAgfQ0KPiANCj4gICBzdGF0aWMg
Z2Jvb2xlYW4gdnRkX2hhc2hfcmVtb3ZlX2J5X2RvbWFpbihncG9pbnRlciBrZXksIGdwb2ludGVy
IHZhbHVlLA0KPiBAQCAtNDM5Nyw2ICs0NDAwLDcgQEAgc3RhdGljIGJvb2wgdnRkX2Rldl9zZXRf
aW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSG9zdElPTU1VRGV2aWNlICpoaW9k
LCBFcnJvciAqKmVycnApDQo+ICAgew0KPiAgICAgICBJbnRlbElPTU1VU3RhdGUgKnMgPSBvcGFx
dWU7DQo+ICsgICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZDsNCj4gICAgICAgc3RydWN0
IHZ0ZF9hc19rZXkga2V5ID0gew0KPiAgICAgICAgICAgLmJ1cyA9IGJ1cywNCj4gICAgICAgICAg
IC5kZXZmbiA9IGRldmZuLA0KPiBAQCAtNDQxMyw2ICs0NDE3LDEyIEBAIHN0YXRpYyBib29sIHZ0
ZF9kZXZfc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2
Zm4sDQo+ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICAgICAgIH0NCj4gDQo+ICsgICAgdnRk
X2hpb2QgPSBnX21hbGxvYzAoc2l6ZW9mKFZUREhvc3RJT01NVURldmljZSkpOw0KPiArICAgIHZ0
ZF9oaW9kLT5idXMgPSBidXM7DQo+ICsgICAgdnRkX2hpb2QtPmRldmZuID0gKHVpbnQ4X3QpZGV2
Zm47DQo+ICsgICAgdnRkX2hpb2QtPmlvbW11X3N0YXRlID0gczsNCj4gKyAgICB2dGRfaGlvZC0+
aGlvZCA9IGhpb2Q7DQo+ICsNCj4gICAgICAgaWYgKCF2dGRfY2hlY2tfaGlvZChzLCBoaW9kLCBl
cnJwKSkgew0KDQpTaG91bGRuJ3Qgd2UgZnJlZSB2dGRfaGlvZCBoZXJlPw0KDQo+ICAgICAgICAg
ICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiBAQCAt
NDQyMyw3ICs0NDMzLDcgQEAgc3RhdGljIGJvb2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBD
SUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbiwNCj4gICAgICAgbmV3X2tleS0+ZGV2
Zm4gPSBkZXZmbjsNCj4gDQo+ICAgICAgIG9iamVjdF9yZWYoaGlvZCk7DQo+IC0gICAgZ19oYXNo
X3RhYmxlX2luc2VydChzLT52dGRfaG9zdF9pb21tdV9kZXYsIG5ld19rZXksIGhpb2QpOw0KPiAr
ICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocy0+dnRkX2hvc3RfaW9tbXVfZGV2LCBuZXdfa2V5LCB2
dGRfaGlvZCk7DQo+IA0KPiAgICAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPiANCj4gLS0NCj4g
Mi4zNC4xDQo+IA0K


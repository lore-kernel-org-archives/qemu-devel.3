Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D49606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jMyqFKDL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJROw-0004oa-Qt; Wed, 21 Oct 2026 04:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xJROt-0004oL-Ij
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:10:20 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xJROr-00063S-Ax
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792570218; x=1824106218;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EOg3EGaOuRYakRiQRP8gAAF3c0tRNLr6A6fb5RCLONs=;
 b=jMyqFKDL2AjfbJscYpuIHWudAT92xRXl3+B/KV9Da72Icy/qSAFIEw5/
 xdDZ10MGfNonzKCfrNIvD8Khk3UrkgsiN5ydc7UdNMWakieAB9dyvsJy/
 yKwWxjOho8MIPGMwCJP4qAVJG/ogkTRhN5sOZg7iRN6iPXAPuDP6cM449
 WZLr6Odly+uxzCMzJPULC8QOqJ3ACXtxAsYsIdHtJklRIh8JfO9gFBKDy
 BKNuQ9BZhoA5whCdwUz5LcTDV8y1C0ZQyEWGQnPNIimRUBu9nsj1KuAhV
 OSzd39hIkeMxNJMyf2HsMDoitKMYs531u/BJyzJPMOAJmi3ODSARZ9Sy7 w==;
X-CSE-ConnectionGUID: 9qokwsFASraKoPFD8ga4pQ==
X-CSE-MsgGUID: gPAw6kJXQAWjKVF+AG6D5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1303789"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1303789"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:10:15 -0700
X-CSE-ConnectionGUID: 4RlcK579RPSfT0BlJF2wig==
X-CSE-MsgGUID: s8K43tWmSrCAW1FJoV4d8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="4860468"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:10:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 01:10:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 01:10:13 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 01:10:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqTKg7GTwMe4LmJxeZmr9rXymUwhyItTYGW5y8Qq7SKLv7SdstrRaaEwVkvEwga6vZQTn1pdQl5b2JR54fm3ABmHAI9anSg4xHcBhrqRdyhcls5UCfAnHcnD/nTbxhOCgR10CTa+bVkMTARsJnPY8T5wT3NZ3WbMPaD5wjBrfrGsdoBgiL4ZlEj/c0pGIXInK1+QPxaYpnIMTjCWpkIvT/kzBYFz7BRT9yka08UAT8FawX8IJDXBDp8afAJMsx+bbBEvNcgqYBizxcotGSXLjxnB1xSJMxRsZi18pwnUt9ZblmJFFJezQfzWNv/6VNYSU/o9mtlvu0oF+u34fraXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16jIaJeigh0HnLYFwrl/PwCa91d5ZCdHgskHnR9BD1M=;
 b=Tu7ils9KCIwsHN9imgqZBdASi+qq9yfUmyafGRXxPSH/4n5/MX+tQ5Z8Juex1ERdJUrPYbzk8tm+N8y+em4QXXOB6eQ0Td2w8lUHDuELzqgp+xoEYc4WQKWY+Ys5ceP/udv70gADuLtVDi0w+p7M5e88gy1tbd3sj7+4xOOQs3NotmNCzeVGAt5D1MS/eRf33stplvVn5XSWG62JiurDKMwXW2kBNBV2h6CDjiOpa9iTl6ljCQoMyPB54FSMJENRa6EpvzgviNfyPz1S+KjJVrDNtkfV4OhJNoy8LCXgpDIpA0n1NHVh8XZydXc46FsmSIn1x8vTqv3wNnaYM+QJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by CH3PR11MB7771.namprd11.prod.outlook.com (2603:10b6:610:125::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 08:10:10 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 08:10:10 +0000
Message-ID: <5f15a11c-a564-4853-95f2-630405287b62@intel.com>
Date: Wed, 21 Oct 2026 16:18:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: iommu recovery follow-up (was Re: KVM/QEMU Community Call 13/10
 agenda items?)
To: Demi Marie Obenour <demiobenour@gmail.com>, Mohamed Mediouni
 <mohamed@unpredictable.fr>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
CC: QEMU Developers <qemu-devel@nongnu.org>, Eric Auger
 <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Tao Tang
 <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>, "Alistair
 Francis" <alistair.francis@wdc.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
References: <87fqyh79ty.fsf@draig.linaro.org>
 <39ed350d-7324-4bf1-9433-54a0d74855c3@gmail.com>
 <87wlrc1mie.fsf@draig.linaro.org>
 <B7610B3C-5A0E-4429-B8ED-BD3EBE53BB23@unpredictable.fr>
 <32c01083-732f-4a45-95d3-6cffccb7c791@gmail.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <32c01083-732f-4a45-95d3-6cffccb7c791@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PS2PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:300:5a::22) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|CH3PR11MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c448f3-bf89-4871-de7c-08df2f4ab9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|42112799006|23010399003|56012099006|4143699003|11063799006|5023799004|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: /Ks+wj6XHBmYbESpSwxGnF3hx9zPN0X2rf046ih91SSScAJ2pgwcKsNqhgWzN1tQ/MsOs++L8Wp0f2gznX+APeMq9jwHH6BpRJH32hIik2UFAU8ESWCF4ws5QAvihCYsAQyETY8HEfTmHvXpPOaxffdyolIFBnWkR2m1Tr5Sh+hOFcXF/w+bdA37dTQMn18Ao2j3+x+h/ndQBgbUevCD2OcjnanmRvSypn7nHzErhmFn0eWkMXIr9/BF/4J3pJ7/j6iyir84nmWoE4fTvdKtgG0ko2LYVmc2C2cdq5KJQ7MioYAtwmr+H0gZAvBic6cea2r9e1VwvX25DOpT2tt/tep50wyeCjoylE98ju+B4LwNofdeQKMgoJtlzOlGHoJYuxsVTNr5v125DhPILLrXcX3U8KEjjGDX1HINxQyXWPbprOmgjZELgeFTCY8SxAwloBvAtbznF9FppcJQrdp9MoyuVGKxbWIydU4xdqNpo8u9ZJMkb42ocBpCuM/yHIZXwmYI2Y6ZP0xFi3jK4GKFDx9tI7g965WCVOOdYpr8QFyd3ypK+xt3SW4/zhOzhpR9wOkyqOAfiGSKCPNcYxrkZxH2ajNl9pzPDpqZBHNr1YsGHN66NctPfQSTwo/wHXVCf7xkMSuJo8r9OHW2LVWLVhz16ujWnR+mNDULW2H85kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR11MB4527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(42112799006)(23010399003)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUhjQTdMdnEwSGdOYjhNRDJ3dWFTZjZaUWZKcjBpNEhaSnFOdE9nQmY0ZEl5?=
 =?utf-8?B?VHlMRVIvam1jVElkR0dGSEQvMTBCQzlzMmhqdllXbVRmSmFGN1JvbzFJQ2xF?=
 =?utf-8?B?R1VCTTVtak5pQzYxbUR0NXVRZllmNzQ3ekdQaTUydUc1WnVjV1ErM0RyUVp0?=
 =?utf-8?B?THdXeDh1TUxWVUJBOXppOUIrcDlLbjlIdUQ4MG04WVNsdFJkdTIzWFd2a0VF?=
 =?utf-8?B?MnQ1L294MHBFS0RQTml1clB1ZkFVZ2JrMnZLVDBrTFZEWmZGemNFR0RjVDB4?=
 =?utf-8?B?UCsvWTFabmRCR3I1Y25xOFM2Qk5SZlc5VXZYV3lNWXZPRFVad3JjVi8yblMw?=
 =?utf-8?B?VFBZODFEaHA4a1NXOFRPV3hOY3hpU01ZblVnaThTT05IaU83dFllSTZad2M0?=
 =?utf-8?B?aXNBTlB3ODc4RXExc0E5UzFYZ3IrNXppQ1lPMDYyQzh0Q3NBWWhMNWRTRDZ0?=
 =?utf-8?B?cEFJNVI5bG9wZTlEZGJyaFZNRTJRZ25WU0t3ZiswcTFDbXRtdnlQQTFCVk5x?=
 =?utf-8?B?VSt5cXl6dkIyUzk5N3FrTHU1ajFoemdtcVJnT3laTnNYdHRHN0JqY0xrQUdB?=
 =?utf-8?B?WnpBQTJzMGphK3Z3S0RQN0o5a2M2QUcvQjZrcHk3WmNyb1FYSFRmYURua2cz?=
 =?utf-8?B?TjlUbUh3TzJJT0VKZ1dLTmU1cURFU2FwakVHc25FVmtvUS96eGFia0Z4Slcv?=
 =?utf-8?B?Um9xMCs1OSt1djk5d2lxM3NCU29xbFBCR2p4T2NIeHFaRzluTGlOL2ZGV2Zh?=
 =?utf-8?B?Umxxekd1b3phRVlIRGpUUWo2aW1pVmlBbXpZT2FnckZHN2tRQnNBa3RSTUo1?=
 =?utf-8?B?N3A4ZGc2Y2JzaDhKU05ycHVwOWNHRVdtdytxMEZBSlJTYk5DMVh3YXRldlM2?=
 =?utf-8?B?Wmt1RkQxd3hBVnpOUmV2ZWJGWkhTcmRzQmU2UDFnT1lCWlhPd1M5YVBaOWtW?=
 =?utf-8?B?dXRuaGs2aGJDOWNjakFXTURIaE5kazluVmhQWVovOHVaZ0RxS0p1MmFVZHlX?=
 =?utf-8?B?UWVjTzRsbEd1djllK2tpeW0zK0xyajBiekkyQURSVFZ4NnVEem5ubmN6U0Nj?=
 =?utf-8?B?NWg0cjZ0UytIRHhsaHlCQXdQbFpNQXUyTjIxS01jcWluRG5IQXgrallZY1ll?=
 =?utf-8?B?ZS9Yb0E5OVJGZWRIVjZYc1lhaFhRR0hkY3BYbytMdC9qaDFqTWVNdUN6V09r?=
 =?utf-8?B?OC94cXdlWm9CdExuTy9kcy9YalJDTXBqb2dRRVRMQW1NTDNIc0dpZVI0eHBG?=
 =?utf-8?B?N0k2dklDUFhpdUpwWFdtZmIzYXlXUnhKbWY1bWZtUUlHT3hBdEpySWIxcWhi?=
 =?utf-8?B?SWVON0h6cTExQWd6bklQSkkvNVFNRUxwMHVXK1c5V2VOV2NYbUViR1NLb2N1?=
 =?utf-8?B?ODllNnRxV2tJdnpLZGNsN21id0hVd0oyQTh1cTZ6UWJlbVJVVWdDTnc4ZXR3?=
 =?utf-8?B?OUZEZmxTME56MUppV0R1UklDZnI1MkdvOE9sMEw0TEJnSnpNbjZkcTBPN1lz?=
 =?utf-8?B?WnZwYW50MmJrOEZzSGRpcWVPc1dGaGVhcEtnaUEraTdNVzdCVUhLV1RqVWxq?=
 =?utf-8?B?cUVRSE9mMVNlZzN1d1FvMW4vZklndkZudWNnM21ScTQ3dURXM2FpRGJUT05L?=
 =?utf-8?B?RTRnaUluL0liSzZ2YlAydHlsaXRtQmZXMGpxK3JzK01QWU94Nk1rVm9BU2la?=
 =?utf-8?B?WkhwU2w3Wm5OaVFTNDRlVU80dDd6aG5QWVRDSXFHZUgveEVPRHo5cHdKZXd1?=
 =?utf-8?B?WEtLRjBaR20yUjFTWDFTSXIyVWlNK2M3Z3h3QllJc1R5WHl3U2xGemh3UFZE?=
 =?utf-8?B?S1lMUysrTkMxTXNCNmRrbHkyWi9aNWdzaHpvSndySmlLd2REaDhXcTlIai9J?=
 =?utf-8?B?akhjVWhaM0xxV2lPbktaSWRYRXpIVDVpUUY5V3ROcXFEek5LYlgxbURpZWJa?=
 =?utf-8?B?N1FEQTdnUnNMb3BnMlVCSVJGYlRCSUpsT3pxd0NuTXQ3K1FrQjBVYlNpUmhk?=
 =?utf-8?B?RHE0TWR5c2tMdDRBZzRYUGZOdE9oUmt0WnlTQ1RETm5sNVZVSU5ranBJV2pl?=
 =?utf-8?B?eXV0TjFsT25DdWtEV05YY01XWlM4ZENYd2tHdTFiUjJxckVReUpocFlEN0pU?=
 =?utf-8?B?ZnZHbnFQbmxFdDFoZzhJemtsOFMxY2RFQzVURDNiRlJuNE84V0x3QmE3Z2ZW?=
 =?utf-8?B?MmRhYmFoOUdheHN4Z3BEN3RKV1d1b01UYVZSbUNQalU4TUhEVWlvZGR4S1k4?=
 =?utf-8?B?dXIwZnRreFRlcFk2NWcwdDBSVXJibXIydWt1Tk1oK0MzNTlKVisxWEl4aCtB?=
 =?utf-8?B?OEl3UEdQOStPLzE2czVYM0QvN3VPcy9MbEluVnVXQVJocklxY2tjUT09?=
X-Exchange-RoutingPolicyChecked: HGEfzLzbSJsMOlCsIO0WkC/3XRVPcq8uICMwe3HZFHKm08Yp7mUa+OX31PJjGbF/qy6b7XXY2Vj2+Qbp5o9G/aht26s4odYdbjbB1z2JfCjyGo6GemXY701B7K4ShtDr1aNusHCx9LcveNLrBDe7WRKaLEZ8cZ3PlHyPcf7qurcKujpzxl5ZEuvZGxu79K3GT1w39VdApf00UnW0v8FZDPbqE6SIQ+Xa3fTu0BjGNQ0oU5l/zsA4FPZELJpsFHHll4B68o9plqz/5+k7zdSSHTOopXQR/zP7aJ+GB7uRSn0xvR4SV0/XFeBMlzKVymky5pl4Ns0FE13+Rk7T6zC7Mw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c448f3-bf89-4871-de7c-08df2f4ab9b3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:10:10.2711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jod+W86hEgwvmXqeikugagfXx73cDfusEAGejXD5XWZjpGU6Rey0+IuK7209SnxoB+SScSg1Ro/Wyir7Yk6utQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7771
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 04:35, Demi Marie Obenour wrote:
> On 10/20/26 11:06, Mohamed Mediouni wrote:
>>
>>> On 20. Oct 2026, at 16:20, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>> Demi Marie Obenour <demiobenour@gmail.com> writes:
>>>
>>>> On 10/7/26 12:29, Alex Bennée wrote:
>>>
>>> (CC trimmed, IOMMU relevant maintainers added)
>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> The KVM/QEMU community call is at:
>>>>>
>>> <snip>
>>>>
>>>> Is this also for topics related to KVM but not necessarily QEMU?
>>>> If so, and if there will be people who are familiar with device
>>>> passthrough, I'd like to discuss whether IOMMU faults and KVM MMU
>>>> faults are recoverable.  There is a virtio device I am working on
>>>> which requires this to avoid either crashing the guest or allowing
>>>> the guest to hog host memory.
>>>
>>> We didn't get to this at the last community call. Is this something that
>>> can be discussed on list first?
>>
>> It should be I think.
>>
>> Hi,
>>
>> For such a virtio device (and granularly exposing it to user contexts too), is ATS + PRI
>> a good choice? Perhaps even using the host page tables directly, with a per-process
>> abstraction as the security boundary.> > On physical hardware as intended, outside of the ATS + PRI case, IOMMU faults
>> are expected to be something requiring a device/driver reset. On Arm however,
>> there’s an exception for the stall model, which pre-dates ATS + PRI.
>>
>> A PRI PPR reply of not present isn’t equivalent to an IOMMU fault and isn’t expected to
>> result in a crash resulting in a device reset.
> 
> I have two concerns with ATS + PRI:
> 
> 1. ATS allows a device to bypass the IOMMU, and my project relies on
>     the IOMMU to isolate a compromised device.
>     
> 2. I need to support both consumer and enterprise hardware.  I suspect
>     that ATS support is very limited in the consumer space.
> 
> For more context, I'm working on a device that allows a backend VM
> to provide virtio devices to other (frontend) VMs.  The backend VM
> will often have an assigned PCIe device, and there are applications
> where zero-copy I/O would be very helpful for performance.

curious how you let the frontend memory accessible to backend within
a VM?

> However, when the frontend VM exits or unmaps memory, the memory
> also needs to be unmapped from the backend.  If this is cooperative,
> the backend may simply refuse to cooperate, causing a host-side
> memory leak.  If it is preemptive, the backend will take faults when
> it tries to access the memory that has been unmapped from it.
> 
> One can avoid both problems by only letting the backend access a small
> buffer, but this requires a copy in either the frontend or the device.
> This might make the system uncompetitive with host-side vhost-user
> devices in high-performance applications.
> 
> Is there a way around this tradeoff, or is zero copy incompatible
> with protecting both the backend and the host?



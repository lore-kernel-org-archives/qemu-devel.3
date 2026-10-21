Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66626606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iMGZjrwb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRIQ-0003ic-O5; Wed, 21 Oct 2026 04:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xJRIM-0003iR-Pu
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:03:35 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xJRIG-0005Gn-Q7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792569809; x=1824105809;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MHNZa5UjgyV/q3p2HmJ1qUvEwEROjn+vLOoBr63TOfc=;
 b=iMGZjrwbCcUEqqRux5bwFiP31k7DViCioEhRuzFxImG/a3SiAQdWFcw9
 8Zqd/teWdz3mYh9UMKxFgiA5b0lG8qemeV9p7YeMyhFF9y5h3+s2nfW1q
 g81nvm9SoTQPk6nrafmdfysD343FH8JBN3yKOb8Sxh+AnrlznWl7Eej4W
 uscUgOLV7xNyu5KdRmIdsswEP6F+bL5Isnf2NMe6t+TOfxw6zqPZMEOzJ
 W/Hw+BReHvBovrbWUzdyXLdWrRmSOnUSXdjwF26F3xPfz/lmiWQdmWBD1
 mfgRnt441VwRo3pxxpnht+BA03msbccSG/Xx6zzNwc+btm+TGFaoq4jdG g==;
X-CSE-ConnectionGUID: 1cEGxtneQMyb/aC4pNmBEg==
X-CSE-MsgGUID: LbCCqwgjQV+m65VJFr6UFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1185610"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1185610"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:03:22 -0700
X-CSE-ConnectionGUID: SazarhZTSxOMgINyLhsrNg==
X-CSE-MsgGUID: HfImJbqjQ6yin2ytuTg9sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3379884"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 01:03:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 01:03:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 01:03:21 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 01:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoXHdd/rGEk+g3jkJPd8FlNUbesf1vveDLXA+PTgiOXNpan1oCXWbbygJEQ4lknJQyAcbpufzbO3ziyaHbKBDOg3B8qA3Z1SBjA+fRr7qecCToIk5W1qH6z9nMuyq2DIY75ctnbXpojFr6nWlGVt/YI3YDSQwMAJFgdPkfdSmjTUqvZrJdNlDWWjhgDQ8MT0jpI97Sf2TFB9TPJemhsD99BHaeTf3NHpXV5Qnhc7K73LL37tsvq/DaKbqP2Sl1X5yXLf5nbMOTCf+3QgRCFC6RLbsuZ7PYFhRghw7oqVGn6Uu5lP/pKM5heMPwNM2kpDFXT7JyERI895JoKP/xXzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yykzzSlH0lACt2msehkZuyANO4C8BYkMRwipuZVGDF4=;
 b=ckoiamKjYqWq/jevm5+BnBJ29uNiQp9Sr/k6BKdzEj71kXtWy48Y4eKd5FldfAWrts9HP2HVu9CccMeLIVwE8mN1mCEqBTltmukVgCEh7LBu6PWc4XP8iyrbt2/VPHteyiqbFBGdzhFtAFuJ4vjCGA0D1XkZgs/sxtpN8iW/Hv3zMlUjc2ZIXxSPe0XiyZpvd+IcNwVqEBwBv7P8hZWFbdH+HM6kZ098VHVoIfO/cyuQGn/MTsm8oJ0Zn5+4la+pGfz23Gjat8PrJuQAGvVsTfPiZ6gdulO2yByHAzVnsynmOKghOi3Jyr5aTRq5X4VYnmUAdL45cAGhM6a5CahYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 08:03:15 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 08:03:15 +0000
Message-ID: <8d9cf349-30e7-410a-8b68-2690c0a04b6a@intel.com>
Date: Wed, 21 Oct 2026 16:11:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/6] intel_iommu_accel: Add PRQ injection for
 passthrough device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowangio@gmail.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261020091955.1607161-1-zhenzhong.duan@intel.com>
 <20261020091955.1607161-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20261020091955.1607161-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: daea8b59-5026-4dca-1061-08df2f49c252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|42112799006|23010399003|56012099006|260925022911599003|260925021911599003|260925021311599003|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: rNxEg/Dt0Su3agKd0SO7EQ1LXGQ4l92RIV5X27FigRYzmQuaX6D/ozRe1eMQJ7Ob1O6bxFYRRK7lMMjBQe3aYTfZ0klZk8S0QK9EVapyUg0bCS2jGslm5dsTHoD0e3YCZN3Feg0diMDJ8HYhSWMRNzbGxdoZ4iV7pFjPHofXkYKjDFiwkQzAjj0h6pIhL4uuoYn4rfXUugWt+X+hEttCbEFucZsK7HtiXwYCFuxdabiKWvBD41kYNP0cZUZVdmKzw5+16pfGegNLNx3vIaIjlgsICpZyLTgxjK9TFRcjZZbaO04/IeU6yMw9BOXYXc3dZo/GPwtygOBtl2IDDWZd4ZWm34MUOuzdEcPXgKjqpq+/Z4XlYMQPNjp0NgGrRbJsbaxKT/K5+Ymwr+5BWwjc1BGL3gS8LQ9RXSkOJRSo6C7iy0ITSNrYLgZzkqCDYTksKpqKgev/C+owUrPoLGVHizkguUnS10kh5noa7S4PWT+5b7dE7+XlHiA2ZJUBN1qIQoWOpDQOLLFoQQWibvXcpBuINNcS76vx4sfu6UYE/gNVE8mq2Tg+xIS2eealSZ47dMoDMOvHOfILv80+yOI8Fa04I4UmYQGI4jYCUErVmKeanz1m4UF72Yzk9HWNCMvv/qiffiLkE9GMUQuy5ejfOvwfiGdx3UjekV32e04/PPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR11MB4527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(42112799006)(23010399003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk11RXh3WTVkZWQ0b1ZJelFpYWEyNDQ5VGdySFd2ck1PUitUcjRjU2IwRC9v?=
 =?utf-8?B?RnVyNEI3MFZKNEZzYVNGQ1ArTDd3ZjRSUXpuOUFFdUY3aWx1MUpNbmZMblFL?=
 =?utf-8?B?SnJRandORXdtKzNsZjhZMjEvVnVkT2V5bkx0dW5NRWZFLzZwbG5TUS9yWkc0?=
 =?utf-8?B?V1lPUnBiT3gvMHBjOVM0RmJCeStZOTVYSk14eDNYNlJpYTlyeENvaFQwZDRN?=
 =?utf-8?B?Q2FieUtIY1Y3WExZdEN0QnNBcWlDU09GMEpjWWp3THc3K0RzYjJSRmRWWHlJ?=
 =?utf-8?B?Nm8yQVZwTTBUSkVwK0QrTWt1Vk1hWGxGWm0wZWhpSHpOWUthRzBDc2VaaElS?=
 =?utf-8?B?ejByaGpXNjBRZnlUcUdmMjNZMkN1ZEpqbzlSUzR1R3pnemQ0Z0hHT2JZQU5i?=
 =?utf-8?B?WUFnL0RQUnBxOHFvVkRYRWUxMGpkNWF0UXNoWG04eER5K0R0TmJwYnJ1VGVa?=
 =?utf-8?B?aXJ0VGM4aE50VENETHVPenJlbFVSay80bmtubUZ5SUE5ZTJnUjBEcE5kWkh5?=
 =?utf-8?B?VG85OGpqalIvNjV1REtFMHROUWI0bk1IZWpMWFgxOTJ4MXNpY0FqdXUxSGNV?=
 =?utf-8?B?enF4b0lrbTBVWm5YNzd2QnJwMEhhdXNXQ0tsdkRSUlF0SDhnV2pKTmY5dVMr?=
 =?utf-8?B?dlZndHZuR1FyYlFENTk2Y1lKYkdCajM0aEtMenRhQldsWGN4YUhPY0lOSHRW?=
 =?utf-8?B?bWZtejJVNysrS2pONm9sOU1NMWRiTk9qY2FkVU8vU25Damc4VHJjYVlpakxq?=
 =?utf-8?B?cmxKaGNpT0RmMkRha01NTlNkc2F0UTVPZmdhRGVGZXhBcnRvSFEvM3dlSng5?=
 =?utf-8?B?ZzJsKytwaExpU0YrU1Yxbmpoc1FrWEl4V21LVTJwN1pwNmpIMUFSbys5K0FG?=
 =?utf-8?B?UXZWeVU0UGZrRjJMZGxLR2ZLNTA0TVVXTURsYkF6OE5iRFlkU3QvWTJOUnBo?=
 =?utf-8?B?aGVadHZiN1Z0bWFzbkJEYWhzT2NKc0ZNQVFmbUJVS2JPK1FDVXhyNzAvMlpH?=
 =?utf-8?B?endKR2FGNjJ6cS96b0UvbnQrQ1FSQkxUemV3YlEyNWdxa0pmcjJCRmFzdVV6?=
 =?utf-8?B?MGFOekptQVQ1SWRIVWk0MlMrRVFoWkxWaXRQRUFjZi84ZFhVcGZIb1A2dWUz?=
 =?utf-8?B?QjhzbjNZUGZNZXdXV2xKd3dlenpWMkZIeUo0OU1hUmFkdTY4Q0ZQUDZYc3JR?=
 =?utf-8?B?c2ROVDRxdFY2cUJ4RE5IRjVsa2FaK2t2SDc1WkJIQkU2RCtUREJCdHhoZ3cr?=
 =?utf-8?B?NG1vTWIwMWkzdUo2YWROeitPMzlzd29Sbk5pMmlYVjhvdDVFbkxSQ3hkSTRK?=
 =?utf-8?B?cjJrV1EzeUY4Q1hOQ2NTNXZwV1FzQjlpU2hiRExHaE1VdUVoSnBuSk5ycmhp?=
 =?utf-8?B?NEMwQlEvN3ZzL1VmZ3pKaUh4ckVNTFBPQTJmVTdPazJpUFdxS2hiNXdYdTVz?=
 =?utf-8?B?RE9LVU5Ib0d0ck5aREVaUVJ0MENseUtIM0NNSFZNRHliNjZpSU1xSUNEaUFI?=
 =?utf-8?B?U3RqZjNLdk1zRDQ2djN0ais4dUVxZXVBYTdZNE5MclYreEZZemIvak9LT3Vu?=
 =?utf-8?B?QUNsOElKSjdhN2FvT2lCTENHcWdvK1BQQkNlODdPRWdpQjdMcllFbU5oL2Rr?=
 =?utf-8?B?MmJEOHd4Q1NxWEkvUEpNMzZmQWhGbDJvbEJNRXRvVW1EZkVOMU54RTlGVlM5?=
 =?utf-8?B?RktvQ3dvZWM4MGtyVndyRkVrcmRxSDY4RnZiMngyMWplYnVyNVlWYUI1Qnl6?=
 =?utf-8?B?b3FVVysxWTFmUVBVUldzVWNuT3NIdm51T1dRSWZkSE1SK3R3SjFpb2V0QXdI?=
 =?utf-8?B?MlM5MGt6OVNTRGxwQzdBVTZwVzJCc25xeXZoa0VVcFZiOXRjZWVTRDF0Njg3?=
 =?utf-8?B?bXRrb3Q5WEIvdlhWQVJUbDVOUmJEUlpTSzVSSHlQUGcwZUR4clZWVzRXWHg1?=
 =?utf-8?B?L0xuV2k3THpDcmROcVJOTFF0N0ljTnZkNlV5SDNOR2JhQ3h4YldLNy8wRGRS?=
 =?utf-8?B?Qit6Nm1OUFR0R3g1WWM2amt0R1hEdXh3SXBFUlhNSTEzUURzNzVQVXVWMk9M?=
 =?utf-8?B?ZWVsZCtTL0cvb2xkZHVUODkvdDhweCtHKzc2Ym15a3BTMkNkQTRxbWQvaDFl?=
 =?utf-8?B?aHhCNzRVQ3lwOHdQSC8xclRyVXNLT05kVy8xYjBkam9hQzhPNXZsRTJoSkNp?=
 =?utf-8?B?WFJDWVoyaW4wY25EYkF5aFVWT0RBQVdjOWxUSFhMUFEzTEpTUlJ5eXBwWGQx?=
 =?utf-8?B?MWNjbWN4WXV0N2xqdHgwMHNyZG1ZRElTbnhWV1FFb2dybDcwbytueFRmYzBO?=
 =?utf-8?B?RjZQRXI3TUN0c2ZTNFUxcmJwaGxRWVpBYjlMb3FZQjNqeWR1enpzUT09?=
X-Exchange-RoutingPolicyChecked: nNc6gWMbyoshv3sW9akx+IytjtZ5qo1Wt+WlSukO5wwY50sHQFwM01p4PjYf2iBcxqts5djsyfXTngh6zEVkpnMHqBl7wgh9uA0qt8tvGiu1bLStkaPTAe6qmz6YaBV3zCkH+Pcp+iPdHTOXLieKpLRnN+AxiOCiazgKSzijIqRdTDJUSStMpuQKGf2NU6yrqEQ3sfAuJ/KVwEU/Od91tHRwJh3qeKy9dWO0aUuoJt00MVozdp4/buSAb1D3VOsEJCKR/gxT9bfsGAdAdRHvfV9uzWbvQNZUegfLJYm/QrcAuboVuZZJ/8rgJxpMqQds7WG7jJpNj8122CSU1zgdRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: daea8b59-5026-4dca-1061-08df2f49c252
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:03:15.0620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXRyNT4VA8qwFjTDRR8Fyafmt6nRRfI8c+BsAKIemCDpinbsXQ1+rXp+WfVjd8Qfzb5ChwIP0TYfyUs8RojCCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yi.l.liu@intel.com;
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 17:19, Zhenzhong Duan wrote:
> When the guest enables the PRQ in vIOMMU, allocate a FAULTQ object so that
> host-side recoverable fault events can be received and propagated back to
> the guest.
> 
> Install an event handler on the FAULTQ fd to read and propagate host
> generated recoverable fault events to the guest.
> 
> The handler runs in QEMU's main loop, using a non-blocking fd registered
> via qemu_set_fd_handler().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h    |   2 +
>   hw/i386/intel_iommu_internal.h |   3 +
>   hw/i386/intel_iommu.c          |  14 ++-
>   hw/i386/intel_iommu_accel.c    | 168 +++++++++++++++++++++++++++++++--
>   hw/i386/trace-events           |   1 +
>   5 files changed, 177 insertions(+), 11 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index 46c1a29409..e0319749a5 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -18,6 +18,8 @@ typedef struct VTDAccelPASIDCacheEntry {
>       VTDPASIDEntry pasid_entry;
>       uint32_t pasid;
>       uint32_t fs_hwpt_id;
> +    uint32_t fault_id;
> +    int fault_fd;
>       QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>   } VTDAccelPASIDCacheEntry;
>   
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index df7a0efa6e..4792035668 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -787,4 +787,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>   VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid);
>   int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus, uint8_t devfn,
>                                 uint32_t pasid, VTDPASIDEntry *pe);
> +int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn, uint32_t pasid,
> +                         bool priv_req, bool exec_req, hwaddr addr, bool lpig,
> +                         uint16_t prgi, bool is_read, bool is_write);
>   #endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 350d2b7753..81c53c6f5a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -5383,11 +5383,15 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>       return ret;
>   }
>   
> -/* Page Request Descriptor : 7.4.1.1 */
> -static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
> -                                uint32_t pasid, bool priv_req, bool exec_req,
> -                                hwaddr addr, bool lpig, uint16_t prgi,
> -                                bool is_read, bool is_write)
> +/*
> + * Page Request Descriptor : 7.4.1.1
> + *
> + * Because it is facing the emulated device models, so this should be PCI
> + * PASID instead of the pasids used within vIOMMU.
> + */
> +int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn, uint32_t pasid,
> +                         bool priv_req, bool exec_req, hwaddr addr, bool lpig,
> +                         uint16_t prgi, bool is_read, bool is_write)
>   {
>       IntelIOMMUState *s = opaque;
>       VTDAddressSpace *vtd_as;
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index c8f2835204..bcd361bae3 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -9,6 +9,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "system/iommufd.h"
>   #include "intel_iommu_internal.h"
>   #include "intel_iommu_accel.h"
> @@ -83,14 +84,141 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
>       return NULL;
>   }
>   
> -static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
> -                               VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
> -                               Error **errp)
> +static void vtd_propagate_recoverable_faults(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                             struct iommu_hwpt_pgfault *fault,
> +                                             unsigned cnt)
> +{
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
> +    uint32_t pasid =
> +        vtd_pce->pasid == IOMMU_NO_PASID ? PCI_NO_PASID : vtd_pce->pasid;
> +
> +    for (; cnt--; fault++) {
> +        bool last_page = fault->flags & IOMMU_PGFAULT_FLAGS_LAST_PAGE;
> +
> +        vtd_pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
> +                             vtd_hiod->devfn, pasid,
> +                             fault->perm & IOMMU_PGFAULT_PERM_PRIV,
> +                             fault->perm & IOMMU_PGFAULT_PERM_EXEC,
> +                             fault->addr, last_page, fault->grpid,
> +                             fault->perm & IOMMU_PGFAULT_PERM_READ,
> +                             fault->perm & IOMMU_PGFAULT_PERM_WRITE);
> +    }
> +}
> +
> +/* Batch size per read(); remaining faults trigger another callback */
> +#define FAULTQ_BUF_SIZE 2048
> +
> +static void vtd_read_fs_faultq(void *opaque)
> +{
> +    VTDAccelPASIDCacheEntry *vtd_pce = opaque;
> +    struct iommu_hwpt_pgfault faults[FAULTQ_BUF_SIZE];
> +    uint32_t id = vtd_pce->fault_id;
> +    int fd = vtd_pce->fault_fd;
> +    ssize_t bytes, last_bytes;
> +
> +    bytes = read(fd, faults, sizeof(faults));
> +    trace_vtd_read_fs_faultq(id, fd, bytes);
> +    if (bytes < 0) {
> +        if (errno != EAGAIN && errno != EINTR) {
> +            error_report_once("FAULTQ(id %u): read failed (%m)", id);
> +        }
> +        return;
> +    } else if (!bytes) {
> +        error_report_once("FAULTQ(id %u): fault group empty unexpectedly", id);
> +        return;
> +    }
> +
> +    last_bytes = bytes % sizeof(faults[0]);
> +    if (last_bytes) {
> +        error_report_once("FAULTQ(id %u): discard partial fault data: %zd/%zu",
> +                          id, last_bytes, sizeof(faults[0]));
> +    }
> +
> +    vtd_propagate_recoverable_faults(vtd_pce, faults,
> +                                     bytes / sizeof(faults[0]));
> +}
> +
> +static void vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
> +                                  uint32_t fault_id, int fault_fd)
> +{
> +    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +
> +    if (fault_fd < 0) {
> +        return;
> +    }
> +
> +    close(fault_fd);
> +    iommufd_backend_free_id(hiodi->iommufd, fault_id);
> +}
> +
> +static bool vtd_create_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
> +                                 uint32_t *fault_id_p, int *fault_fd_p,
> +                                 Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    uint32_t fault_id, fault_fd;
> +    int flags;
> +
> +    if (!iommufd_backend_alloc_faultq(hiodi->iommufd, &fault_id, &fault_fd,
> +                                      errp)) {
> +        return false;
> +    }
> +
> +    flags = fcntl(fault_fd, F_GETFL);
> +    if (flags < 0) {
> +        error_setg_errno(errp, errno, "Failed to get flags for FAULTQ fd");
> +        goto free_faultq;
> +    }
> +
> +    if (fcntl(fault_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
> +        error_setg_errno(errp, errno, "Failed to set O_NONBLOCK on FAULTQ fd");
> +        goto free_faultq;
> +    }
> +
> +    *fault_id_p = fault_id;
> +    *fault_fd_p = fault_fd;
> +    return true;
> +
> +free_faultq:
> +    vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
> +    return false;
> +}
> +
> +static void vtd_destroy_old_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce)
> +{
> +    if (vtd_pce->fault_fd < 0) {
> +        return;
> +    }
> +
> +    qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
> +    vtd_destroy_fs_faultq(vtd_pce->vtd_hiod, vtd_pce->fault_id,
> +                          vtd_pce->fault_fd);
> +    vtd_pce->fault_id = 0;
> +    vtd_pce->fault_fd = -1;
> +}
> +
> +static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                uint32_t fault_id, int fault_fd)
> +{
> +    if (fault_fd < 0) {
> +        return;
> +    }
> +
> +    vtd_pce->fault_id = fault_id;
> +    vtd_pce->fault_fd = fault_fd;
> +    qemu_set_fd_handler(fault_fd, vtd_read_fs_faultq, NULL, vtd_pce);
> +}
> +
> +static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod, VTDPASIDEntry *pe,
> +                               bool has_fault_id, uint32_t fault_id,
> +                               uint32_t *fs_hwpt_id, Error **errp)
>   {
>       HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       struct iommu_hwpt_vtd_s1 vtd = {};
>       uint32_t flags = vtd_hiod->iommu_state->pasid ? IOMMU_HWPT_ALLOC_PASID : 0;
>   
> +    flags |= has_fault_id ? IOMMU_HWPT_FAULT_ID_VALID : 0;
> +
>       vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
>                   (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
>                   (VTD_SM_PASID_ENTRY_EAFE(pe) ? IOMMU_VTD_S1_EAFE : 0);
> @@ -100,7 +228,7 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
>       return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
>                                         hiodi->hwpt_id, flags,
>                                         IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd), &vtd,
> -                                      0, fs_hwpt_id, errp);
> +                                      fault_id, fs_hwpt_id, errp);
>   }
>   
>   static void vtd_destroy_old_fs_hwpt(VTDAccelPASIDCacheEntry *vtd_pce)
> @@ -121,7 +249,8 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
>       HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
> -    uint32_t hwpt_id = hiodi->hwpt_id, pasid = vtd_pce->pasid;
> +    uint32_t hwpt_id = hiodi->hwpt_id, pasid = vtd_pce->pasid, fault_id = 0;
> +    int fault_fd = -1;
>       bool ret;
>   
>       /*
> @@ -136,7 +265,29 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       }
>   
>       if (vtd_pe_pgtt_is_fst(pe)) {
> -        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
> +        IntelIOMMUState *s = vtd_hiod->iommu_state;
> +        bool is_pre = false;
> +
> +        if (s->svm) {
> +            uint8_t bus_n = pci_bus_num(vtd_hiod->bus);
> +            VTDContextEntry ce;
> +
> +            if (vtd_dev_to_context_entry(s, bus_n, vtd_hiod->devfn, &ce)) {
> +                error_setg(errp, "Failed to fetch context entry");
> +                return false;
> +            }
> +
> +            is_pre = !!VTD_CE_GET_PRE(&ce);
> +
> +            if (is_pre &&
> +                !vtd_create_fs_faultq(vtd_hiod, &fault_id, &fault_fd, errp)) {
> +                return false;
> +            }
> +        }
> +
> +        if (!vtd_create_fs_hwpt(vtd_hiod, pe, is_pre, fault_id, &hwpt_id,
> +                                errp)) {
> +            vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
>               return false;
>           }
>       }
> @@ -146,11 +297,14 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       if (ret) {
>           /* Destroy old fs_hwpt if it's a replacement */
>           vtd_destroy_old_fs_hwpt(vtd_pce);
> +        vtd_destroy_old_fs_faultq(vtd_pce);
>           if (vtd_pe_pgtt_is_fst(pe)) {
>               vtd_pce->fs_hwpt_id = hwpt_id;
> +            vtd_setup_fs_faultq(vtd_pce, fault_id, fault_fd);
>           }
>       } else if (vtd_pe_pgtt_is_fst(pe)) {
>           iommufd_backend_free_id(hiodi->iommufd, hwpt_id);
> +        vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
>       }
>   
>       return ret;
> @@ -183,6 +337,7 @@ static bool vtd_device_detach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>   
>       if (ret) {
>           vtd_destroy_old_fs_hwpt(vtd_pce);
> +        vtd_destroy_old_fs_faultq(vtd_pce);
>       }
>   
>       return ret;
> @@ -282,6 +437,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>       vtd_pce->vtd_hiod = vtd_hiod;
>       vtd_pce->pasid = pasid;
>       vtd_pce->pasid_entry = *pe;
> +    vtd_pce->fault_fd = -1;
>       QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
>   
>       if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index a1a50d0910..ad84d106a4 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -77,6 +77,7 @@ vtd_reset_exit(void) ""
>   vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>   vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
>   vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
> +vtd_read_fs_faultq(uint32_t fault_id, uint32_t fault_fd, ssize_t ret) "fault_id %d fault_fd %d ret: %zd"
>   
>   # amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32



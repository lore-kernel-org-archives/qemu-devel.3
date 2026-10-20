Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E6606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W+dzSmSn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ2yr-0005EH-5z; Tue, 20 Oct 2026 02:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xJ2yp-0005E1-HU
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:05:47 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xJ2yn-0005oJ-Rn
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792476346; x=1824012346;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wkWO4grjzGjH86jy55O5WAe31qlwKQrEkBxnfitUVUc=;
 b=W+dzSmSntEDX0F+H7WiNC3yn+Q1t1QUTbvlQt7ElSNcB9gKNrQWNDiYn
 kfbfADjBOa+kphk/RRJSdwtvI+pz0YUJN94R+oY50AtBSG/VyFZT4Acfh
 WxML1A+Qo8pGF868rrQtIhqpM/UiG00+9Is1QSrS1xG0woTzupxmyNrGH
 1VNyAEg4tcRCrwTpVtdN36NnZABDE01mdDlYTr+EW7px+6mlXbxNoSunA
 ciH4bFeIOWZ+PIQAZM6LsegPyLtnjgLtNRiHasZjw+0h3SmNQlwBwo61E
 kgD6Kiy6eJgu1rNPfbm5EuQIiaADt7SGmTXd5QLm8gf4tRqjIi+1dZS5d w==;
X-CSE-ConnectionGUID: uc9ca+BlRH2cyDyiNuS+gQ==
X-CSE-MsgGUID: 9KfNKu1dSXe6zG7AEPJ+yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1048619"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1048619"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 23:05:45 -0700
X-CSE-ConnectionGUID: LASFoZshSOeCvgJtPn7a9Q==
X-CSE-MsgGUID: DDEWmk4mSaO+mo86QJ9Huw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2685371"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 23:05:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 23:05:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 23:05:44 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 23:05:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu2ruAXxDPUxZQxjRtYwZtd4KogchPNzsBB5Z9bgmZuYv6X+8QBd+pfh7JpBqYHukV0HNLM6/YKGblZ1toJNcoKtpAxHB2a5A9Z+0L58qjHc8U7IA7Yh/3JvRwKpOLyB4RYiODrZW5HAtPmxLvdUug6Vx3XyXgAxoWOFMtiSI6OeyOfUslS0ZFe0moJ1+vFNySblJ7nRafd7QdW37FIZ85tiXKFA7kxmX11MBRQB05uxo7fNmI1rlpbyUWPrAL+WK4qfqQO8lgJNHo3Wb7WUcfTukrvlwCufUyTQo0bLjtkTXLd/YGheAzbm+aMoSUtC+iUJ9Bv/iHcu1EsvR7qhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOvg4jN9IwS95X4hlpaZuSXSFqIE3XqhfO5sHOQS3Pg=;
 b=CVMMmUtznM8wAbgNv0cXnDO9ti8HVR4MqDyckqtoLWytZOGC8XH9W5bbSt+Xfs8rTLy0TxDew6Xp4kHKM5YzqGqMPNzJNzPGmoHGRiS6mCIygcjYQ+p0PPlidq8/7R0TjrwQOMU7lnznjWUItR6nC0d65pPB6wZ6RGaB15hmeNp2Rb1iG7QVOtsZqjPv25h0aK8jTyfO1GBkfeg1GEjiLqbNgbmsS99SNmTSLAVhu6wGCB6ArDTAeNpiCJPEjEzcHx/UTyiUrbFLOi2hA5nT2nqhWFy2ZvBw6imU8wV0f7+zy3bOsli+TWHJGatjBB1zbelq90q3R4Mrp2f/DSW8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by CH3PR11MB012418.namprd11.prod.outlook.com (2603:10b6:610:39e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 06:05:42 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 06:05:40 +0000
Message-ID: <f0600d92-c9de-4dc9-baf3-80e5867efdf3@intel.com>
Date: Tue, 20 Oct 2026 14:14:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/6] intel_iommu_accel: Add PRQ injection for
 passthrough device
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
 <20261009090737.3930000-5-zhenzhong.duan@intel.com>
 <33c9b517-2fec-443e-be4d-c07ab4b65d54@intel.com>
 <IA3PR11MB91360B04A19A36785E58AE9392982@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91360B04A19A36785E58AE9392982@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|CH3PR11MB012418:EE_
X-MS-Office365-Filtering-Correlation-Id: 47fb022c-e3db-40ec-26dc-08df2e702ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|42112799006|23010399003|1800799024|366016|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 461T0NUTjT3L4Nhw2Om3aibk2MqEH79Lgj19vIxyQRWZ0N0xFaj05+LRwBki7MzKUzIydZVjKQmCgNDpsIXyg1SPvMo6xps66QF8h38titbXO7VxcAenW6D2mKVycOWR81eNUMdPSOklnOt4NA757d7LV+Pe+NTHBvoE4IYGyMXlgRPLn5xGleMnkpWFVjwTY3nxhr7pYxdtECL5ouYtMhhAGeHqbDnRYZbNfUfgfdlEMDgunoer3ELaAevCj3lB/d7POHx8A9Dvd98iSO2MchKnCSoIaDURupdmMqoYJbHvsEmegTi2lJNEfy1tMRapBXtvoGAgnioGRaGE6kBu3e8suTJtwgELp7ZF0ZtGvNITX0uF6XZ845sn6HtT6qdrcFd00sgDbg4lSuWC/dLTD9MHuf+HwyjYagvoNOb7fxRHwwYjFxvUbIal/zSantXQCagyCDL4JMeXYvjon6P55UEI7vRkgwo0L4FLKLLJL94aRQSF8DLF2ut6LXw7CV0uGK7y3LbEFKtOmuYqUisr2JbqYpgdWWYHQPRVbwGkLrS9dHtkCWsZ6o6uvAvwpcUOQlZ3FvtMSfu4jclggMuLGs2UUm857Huvq5H4cWSXe1pExwSioTJvUtkNkZ4UhqeFsPCYxxie+Y15IMcTZAs9XWe/tT7t5bvhuppd1Qo2R04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR11MB4527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(42112799006)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTgzK1JMekJaQVdMREttY2hpM0JhZWFLUTk0UWViVVg2Nm1qT2V3Rzg4ZTRL?=
 =?utf-8?B?RnBvSnFERFdZbjNvYTRFUkFRS1R5R3hZYklUVm81ZGJXMUZnaUZHT0Y4eVdN?=
 =?utf-8?B?TmdrcWQ2SGN3RjZSRHFIaEpabHg4Q2NTb0RKODNTOHByWFh0QkF1eDFnam41?=
 =?utf-8?B?YUl0L1o0K3VzTERGMFdvTGErUCtWbDhOVnR0TGJYRTNRbjNvb1p3b1FKUGVL?=
 =?utf-8?B?eFlRaWZuSTB2cWRaTXRLSGhyNnJGNVorL0JLSW5oUWRyREF4VklrNlpWc3NB?=
 =?utf-8?B?RUxRNGMzTnFoQ0M5Tm1zbTRpaXZBQjBsald4dWh6c0ZqUGtsK2VjZXVUS1lq?=
 =?utf-8?B?UkwrUDdxYUlHVWpOZ1luRkJJZm9LWGEvTjA2UUpGaVhmREhSeTd1RnFWbTgz?=
 =?utf-8?B?eHE2MWwxUlhNUVRHbXJyZ2F3N2tWa1hYWmgyM1VPQzl5WXlySExUZlJIL2VC?=
 =?utf-8?B?U3M3bldQTHRkVHNYWHkvQ1ZyYkJOT2k3NWZMQUFYTFBEQ0tXb2o3c0dza3M2?=
 =?utf-8?B?NEcra1lPV2ZLdzF3ZHFYOGN3RVhla3p1RzhDbzRIdzdTRkJOeWhkdFQzSTJn?=
 =?utf-8?B?Zzd5OGNNSG5mb3Z1QkJ1dHhTZGQ0UllvQ3lvd001a2Q4RWtnZUxxdzZqcURH?=
 =?utf-8?B?QkloUmxrcGhldng0OTl1b2paaFBKMTZlZFdtU21sbXIxZXRUOVhsQmx2RkdF?=
 =?utf-8?B?NVUraTRCeXp3VG5oNkxhS1cyL0VGNVYwUDNhSUdOOVJJTkZwcGlQRHgxNklJ?=
 =?utf-8?B?SGM1bHNmTWpNdllqcFhXMkxQNkZmTDZpSXViRnVsTCtoUTFNKzFqNUNDOHJF?=
 =?utf-8?B?RW5yRVBiR0pENk5YVXRnR3g4NlBJdWxwc01kQzIvbWdRdTdxL1JVN0ZZejBm?=
 =?utf-8?B?VHdBblE2VkRUN2hXUWV6aXoyeHRFUFAxUFgvcXNTV3JTUzNIbFcwcjF1Vk82?=
 =?utf-8?B?UHJFODFhUm1HdWNBZnhhbWpiaGsvTmZxZUxSNUh2c0dDUXcyeVhTM2x2N0JV?=
 =?utf-8?B?alNYOWMvVjZNMjhWQmhLY2Ryem40c1ZGNWNFVkU0ZXlxV2F2ZE1mL2c3NGF5?=
 =?utf-8?B?bXhwTW1qc1BjcXhkc2tSWWdUTFZhczNrUnpNMmR4VTJPcDBIdkxEZDJPVUtt?=
 =?utf-8?B?T1FsWE05eVNVOWluc0Zpa1daMWxCSXlqTW1mQ2lDdDhIZ2tqdm82MU95UnVB?=
 =?utf-8?B?bUp5M0xlL3hDUGtlTXZMYjRTSk01WkhqTldJMFcrZFBRcG5yTjdIWWpPWlNY?=
 =?utf-8?B?Qlh0QWxrcVRyRVR6eXZDaVBoNFI4WWNLUHN3ZHQwRnFUUVJlWG5uaytRQSt1?=
 =?utf-8?B?TEhsU2toSHZWdjBxNkpQVkhIVlc5elh1UHkyMjd6c1gxWVEzQW9LdzRDWE5v?=
 =?utf-8?B?MmVCbTdNVTBQWGJFd0NVS290OWNWU001WXEzZzBlb08yQ2s4VUVaelltZWpy?=
 =?utf-8?B?V0VMdlpFWTlVaXoxall0Z1BXWUdsblNPOE9lQURrSmwwZjVHMUphc3ltcW1x?=
 =?utf-8?B?bkhITlN2c042aGJiaElmdGtpek5ZNlBVMEFhSnpCNDNieDZkTURhNFd6cVRQ?=
 =?utf-8?B?VEwzWCtEQ1RJcTl2T1draElCOE1GRU04Zm41YVE2dnpFTHBPa0g1NSt6VXE5?=
 =?utf-8?B?cml6bGdKYjQxYjdqRFlNM3dzeDA4ckhmcDljdWVNbjd4RWJuQ3RTaXNVYTMx?=
 =?utf-8?B?YitkbW04bG5WQyt0eEM4YWhMaHN5SExqZ2YwV0N3bjMxMlBENDVmTWQ5alZT?=
 =?utf-8?B?NklHdTZ2YkdTRWFtUXhYT1lUd0d4TlU5NFlIS0ovSjJmKyt6eGVUd0lqMmd4?=
 =?utf-8?B?QW5SRWQyaGlsbWlUNkFZVFlYMGFUS3BoUGF2VDFUNTlnTk9BZVBXaDlTYksz?=
 =?utf-8?B?WEh3WnN1VjBsM2hoL0NvaFRCQWtVSE0rZDlUVnFqc2MxaWJFMGpLUXBCUFQ5?=
 =?utf-8?B?K0FxR09hNDBQYlh0MnFOZ0VDVnZDVGVoVzFKL1BzQ1BoeEMwMnNtVVNUUTk4?=
 =?utf-8?B?YmUwNWNEN2FXTlBLcVpXVU9Wdzl1V3p3NGRqYU5oMnJJNmlDODA4dXFaRGVv?=
 =?utf-8?B?S1RhV2s1QWxZV0dvY0RRQ3ZaeGlaZTRPUFQ1NWUrNTNEeE9UM3BoVXQya2tV?=
 =?utf-8?B?RjBwR2g5S0hIOXBjYUpPTGtqYmNWQUcrZ1JVNXgyb0tIRDZCcnVMbUNxVVlS?=
 =?utf-8?B?R092ZTl0Mm16cVBUSlNqaUloMnk5VVl4VWt5QmJUdnY2RWJLQVdjQVBlcWxX?=
 =?utf-8?B?a3QxTFFQQ2VXRmhkWVZGR20rTSs5TWVkY0l4dDhTd1czVnQ4enVkb0RER1dD?=
 =?utf-8?B?S0tZQjEycUVWOVpoYWpNQ2xYQy9TcnN3WUI1M0RVaTlMSTdPYXpRdz09?=
X-Exchange-RoutingPolicyChecked: FOkWCKwRPysTwQU8eaiy9bwn1BwDdo5RWwUCzKh03u7ZdViVJtOWZs3KpcUrINoA6Wv8Tcpl0MbrlXLHk3moK64ZfDqCTjKGqjyzZVTSK2/93w67rqGFBkIyYowyRQQ2sV9uJLtJMr8MJBt9sFJMNk/vYs/BWjzvCc8E1D4tuUanTKubBCPdHJjP5pBn4Y/19dDNUOao8M6OceGfD2U9/2RvAzc6NAQ+Q9BN477q36ayhRhi2WbG+cBGegapK5kaHy2hkzdtrT3bMVLTm9E5ovBA+Eg4OXjUhfA+BRm7tidEx5omPvpwaEmJNHws5XHf5gqLwWCYFhNjiNchdxrBLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fb022c-e3db-40ec-26dc-08df2e702ae0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 06:05:40.3324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjzAJc0yJpD0iYroZva8+278jKoft5lgzi+Z8lQULnbfkvCFqSPXk8OLuNQSnyyWp7ImSHSkESXQi9ZRUpRceA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB012418
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
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

On 10/19/26 17:04, Duan, Zhenzhong wrote:
>
>> Also, there is vtd_check_pre_bit() which
>> validates the PRE bit, shall we consolidate with it? Other parts look
>> good to me.
> 
> vtd_check_pre_bit() uses vtd_as as parameter which is totally for emulated
> device, I'm trying best to avoid using vtd_as in intel_iommu_accel.c

sure. seems non-trival to have a common helper since vtd_check_pre_bit()
needs to use ce.


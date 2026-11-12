Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1842606A334
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M7r7O7oo;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=g0mxfpJJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTVI-0005uf-Sy; Thu, 12 Nov 2026 07:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xRTUz-0005nU-6z
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:01:52 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xRTUv-0008Cw-9s
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794484906; x=1826020906;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MPhq+kMXgyTAobOc18JhtAyoHhKCf3zfzR1tTe64Frk=;
 b=M7r7O7oozJIxsm0GJaPk3/DG/4Z4uLHNq4c+SVOl2oOaqZchWUZF3zu9
 wVFikEmIeujB6dSIOUwpUzEYRqeUkybwjCvBlCCRvaeDjehYRxFRYQoQc
 IZ2BiWk3wi8iagOsuzftfpBQuqcRQVvqKDDPEQw8R4efYhQw63qU0qecV
 I8DUl3HVI1pFy475e/NjkNYhMtBnWa7O2DfzUystlN0F71X1ATV6uNkEC
 yKrLLwfb1zvJgGuscdGFquSUBkpZHx3SY5icJKfUgUME+Rox55dVJC5Rt
 Q3+TZsXNX+r+vLmdKziUMZrbpDZx87ByShS9do1wKvLT51uP79VOVwEVf A==;
X-CSE-ConnectionGUID: h3iSz4eOTCuLPkKYfYwmYA==
X-CSE-MsgGUID: 2+TUbZebR82ZkNs48SkGew==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3177580"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3177580"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:01:42 -0800
X-CSE-ConnectionGUID: KtoxWSKeTBqHDJZpYTtHtg==
X-CSE-MsgGUID: gCj1wI1tT+2O3zmi80ef8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8537114"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:01:41 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 04:01:40 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 04:01:40 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 04:01:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC7SknsnD1yxhY9IrA/YEQbzrFftCktP56UGkE4s0Y8ihm+7oGQZ6cYXcT27GV7mPR8ZVRoqDZig0WFgWVD+R7F9vZdTIreLJ9lNAkDYpPg21YI0xWWQ0Kg9SJgAiTLy5hwjjv6HUl/qmb7L4uyMbNu1VOAQBNzJBRQLk7O85d4wVmnIkXp49jXfOOo6JVw8Bi6jLUbi27wbinLu/xpIzdlIFthl/eTjyuVHHxWxU0qgcZp5pjLX1POcey9+ILXru1Og1SaB+4ug2nzrDkj9G8PWuhLPw47wmiYemdY7hwA0QqBAvsHjRuKoB8PYHARN4OXXqVP9PmJ0CHzfs2+sgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qhMBJmRo7VaqFkXUxu43RavkhhAaXgGeMjNOR10y80=;
 b=SFPlYqJz+VDHdGp+EmMvgCVUTnHt7u+0lns0LYyd5nPyu2jc2gc4LdOV8dLpyZm2C/jM9doq2dribUfV7IYTwZk6d2XRwdfcDfcuxz4tbGAiBGOHPLaY9l7Q4WQxpFfBNyYkVomhxEq6O256SQ5d0vP8dQnf/HnBU/iI43ybkjJe7uRYH2srUrTsOw+nqvzI3aBy1a7N176X3mLmYCdxXKk6IG3/RLL7aNkWigMInW1Z4imH57edvWAdKCaZvM7HIn+zMKcaSQTPucjHJ4wg57b8DORnWjLKAz41MqWED6MlkLXcBdzhmvpH6NIVQedLTx8FV55wCHn3C19XiHeGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qhMBJmRo7VaqFkXUxu43RavkhhAaXgGeMjNOR10y80=;
 b=g0mxfpJJ+yVjEEP1eDx0oeLpZmCruYaIYppL6en/WJZP3Hgu1H218sqX+TWbRnacbi3xqLC+CXZGzb1uKCCdYZL1Us9cgwuF0cBpOipnJWDT7c6LbDi0/kFaIG5Ca/MBXdflglV9/cZsebsxu6qQ00Pl5CygU01yrM35rH9uXvA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by DS0PR11MB7970.namprd11.prod.outlook.com (2603:10b6:8:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 12:01:39 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 12:01:39 +0000
Message-ID: <c279d0e3-986a-4978-b0f7-e0fdeb7fc11d@intel.com>
Date: Thu, 12 Nov 2026 20:10:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] intel_iommu: Keep PASID cache consistent with PT fast
 path
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowangio@gmail.com"
 <jasowangio@gmail.com>
References: <20261104070740.1577884-1-zhenzhong.duan@intel.com>
 <86bbbf9ad97d897badc74185ffebc281fa64f1c1.camel@bull.com>
 <IA3PR11MB91364207120A69BBF491522B92772@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91364207120A69BBF491522B92772@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|DS0PR11MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: f36cd366-aedc-4b63-f911-08df40b4b4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|42112799006|10067099003|4143699003|11063799006|56012099006|261022075727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YsVwfpcpyhy59KyREvfJCbqMrIvtL6BapEAbtDhZtdma+C9gT58ojwtXxN7kWL+/+GrDng6Soaczpneq5ExzvQAwB62zJoq+dgkTB6aEgg995cZ6vlljwq12q1KfSTYsP0tz46r41rb4Z5pKR/dGLo6WlmmFIjN3TsSeBoP0zcwUIIKmyXc8E/Beix8bEVDFt5PpOCqFppwlf7J7HHFyZ2uupgX/kCcgciFLaY1CP5NznkumznAcW0/kQ+r3z3aJzTzznF9l2Uofo9S7lPc29Tal0ExXh5iaO2CkvRdjT3xZQi35qpYp7IyGp5eEVnkkcGczKudWMXXjyexXZybIV+fCyYHaDv3agYvgc8Z0ZUflHgl2O/RNzhWtb6T2GhOHEovi1eGR4s+kvDSNu7E9541RLhdxbky1hNsBzNu3JmJYO6PdwbxsVs3BNU8KBma7Qz2l8Xr2wuOCHgH+wO3zmAcsSYtnFouS+sr0DP3skWwPrWnd2Yl+1ueP8qAN41JiTFjRjvuForeqrW/zn3kTV/OirCs8vwldVn+R+Bhcp5RZKC8zlEMJ2MrsTm3xWUVr81J/H4bXtTP11WZfrMAf19raKc456D0YHHVy7PODj8xdJVAtxAzvBkQT0EsCg7u/1a97Eoj3fqsmgw20/OHzOnK2tRTdY3o0ArEhIfoTW+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR11MB4527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(42112799006)(10067099003)(4143699003)(11063799006)(56012099006)(261022075727099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjFZcHQ1WUp2cGF1OE00Z2wrWWIrYXpXa2ZpalQrWHB5MUZEMjB0VTlUVTIv?=
 =?utf-8?B?cWpDcXdLYVk3elVTRXQvVGNNcVAxb3d1eVdzbXN6SjlBSkxsU1pkS2IzNVJM?=
 =?utf-8?B?bTVaV2k4Q284RUhlUGM5ZkJtUEF6U01lRDVRRFRlYnZ2RWl3MjFTdkNvcGxI?=
 =?utf-8?B?YmdSclB6UFBDUkhkR3dJMEp5Z1F0b2R2WlYzMjcwUTl4aTdMWXNZK1JpRUk0?=
 =?utf-8?B?TS8xNWNRV3hvMncxNGI4bnpRUWFhRThUbkxBVzFYTm1adWhXOVN0L21TbWd2?=
 =?utf-8?B?MjRvZG5CTVY2T0dlWmRFSktOY3NNeDk5MFBzMm1qdWN1NTcwdEd6Mnl6MW1S?=
 =?utf-8?B?TmdWSGNrd0hKVkZjR3ZSQ05NN0hBbWQ5VWIxVnRsRGhNWHFPZFNIVERwNWNp?=
 =?utf-8?B?T3hzcHd2QUNUQmhjNGovT1F2MVNNd3ErdEJHU0lkaUdjTUFwb3VKS2RvUXN6?=
 =?utf-8?B?aUZrVklhb1pyZzg0Y2xVRWlaMExkMkx0enBJaWxocmlXRGZ2QXlEeDc3SitG?=
 =?utf-8?B?OWljckg5TC9ucXpXcjd0YXBQem9rQkg2VFNtR0thVGx4NDdZOTdOc3dISll4?=
 =?utf-8?B?TmZjZ2ZRMHpZbGNERFFTMDZ3ZWRDbEc3M2hZWkozSGJSWDJjWEovazllSDFq?=
 =?utf-8?B?MTY2UUZNcXRRcGVLak1Penh4MUxNd1cyRDdqUDlrL1J4M2NIV3dDa2FiVVR0?=
 =?utf-8?B?MGVHaEU5UVVaa2hQczBUZkZWdXpQaDlkZmw1SXhoRFJGc1U2S2YwV0JwVlZr?=
 =?utf-8?B?aVM2UkgyVU9DQy8vcDVDSFJBMkNPcXBkTWdMdGk1bk9VaDBNbzNFSTlpRkE2?=
 =?utf-8?B?VzR0Rk1jMm56ZHJjODFGekxPZ3pPZzV4YTFtT2JuZ0JZS3RYMFQ0NXkxTGpF?=
 =?utf-8?B?RnB2UWEwZFdOVzZTT3A2N1lRYkRSL2EyWjBzSm5DejRoRXRVN1IyVktNYXZz?=
 =?utf-8?B?cG5UWStSLzE5T1M5YW42UGtMR29GdmdJcmd1YnRYRzFnVUpjWmQzYWE4aDdX?=
 =?utf-8?B?SnZYTDF3V1BXM29xcEh0anpaUjUwcG4yN0YzakFyVUpCaVRjSnlYaVpRU3Fi?=
 =?utf-8?B?L3h5czZPcHVyODRKM3haeHhPZmoxUXBEM295UWlwa0dpMzIwUjBhNGYxd3hP?=
 =?utf-8?B?MHV4RmdNY0I4M0xHUFZtdk5rdSsybHZTeFBuY25oc3dIOVhHSnB3L1pyWEFB?=
 =?utf-8?B?U2kveDlzNHd0MVpJU1hWS1Y2OEkvQmY0VVJQL1cyOGFBaHljN2tzdmdzNS9J?=
 =?utf-8?B?blNwbkFKNW9PaXRLVFZYMjRsWnJTMFF0ZTd6Y0tBODVic1QxYXE0UlRvb3pz?=
 =?utf-8?B?T095bk85aFkwRGlCTVd5QTBnVFg5dTRNSVFiMGNWd0swTHZwWGtPUkRkZzdM?=
 =?utf-8?B?ZEN4Zm5KSnIreWt5Q1hGcDNLdXhqUzFIMlhqQm1YaGw5RmJzK0Rvd0RCd3ZX?=
 =?utf-8?B?bVN5ZWIzTlBHTEZxeTgzalV3ekI4UEhHa1llNlZuVkx1NC93L1hiWUdoTUtr?=
 =?utf-8?B?OXgyQ3k4MEJ0M3YrWmpMdVpPSzVQd0xLazI5UEF0VCtDaERGeEswaEFPYlhk?=
 =?utf-8?B?YjJrVW8vdVdGRWcyQmMwWEhqamZ2cFE0TzZUWUNnMWNVWi9wN1RQMmdwNmp2?=
 =?utf-8?B?c3JaV3RVZFh3azR6dG1RUGdWNkErL05QSGkyczR4ajBjMWFLejJXYjFpdE8y?=
 =?utf-8?B?T0tJYkNXbytSeXdZcVFab3J3MU5QL1NtVURkUnFVdVU1ZnNvZnJXVWIva1B4?=
 =?utf-8?B?bG55ZG14Vy9CbzJ4RnhsdFBXbW5MS0FxMk1VMUU3R0JRaFgveUZTOWJya1BU?=
 =?utf-8?B?Qzl2YU1oV2Z2TUYyK3VaL2tJMmYvaTVPQUMzL2FtUFdNZnNXSkNjWUFuTDdZ?=
 =?utf-8?B?dUkrWWRCbldCOW1SRVBVV0pNaFhaNlBTNzFkNGdRTHZ3TExua1VRZGRhTTlY?=
 =?utf-8?B?M0c4emlVMnBNMHh4YlJmakF3VVFlUmtydGFpaHF3MEtRVWJNQVFVMVFQRHpT?=
 =?utf-8?B?cDBDY2NwQms0cVpJSW90SjBzZDhIckw5anljaDFMcWU4TStobTF0c2wvbjhU?=
 =?utf-8?B?MWdJV0FXZHpZeVBTQ2U2cHhwaUhLVlRnMUNVanNoWHAvN0FvUUFBL05weUdz?=
 =?utf-8?B?N0NQa2RWTG5QM29iR0x1UkIzZ3NnZVRXcTdKK2RESDRQMUgxRXJaYmVmNlRw?=
 =?utf-8?B?WkFUczl1ckR1bkFka01DbUh4Q1JxZHhhd3hrZnJrU05CRVlBcmJSTUYwYU1s?=
 =?utf-8?B?R3V6N05URGF3aGZhTGx1Ui9RaVdxWjlocys0OFRWTWRxb0FTTHFnK29IeVg0?=
 =?utf-8?B?THNYcHVTbVYzSHF5cFRWbnBDNEZqcjVaaHdBbnk0ZGVQTHptbGN3QT09?=
X-Exchange-RoutingPolicyChecked: C1QR058CDS0lYYoTuPd7uKO56mY2BDqdeVyNTEVa8B4NCoDUTeLYSWIRpi9AZqz/uydtPFIpsYeqX+I7+zZVD+2Xsew++SGBed899UG2ZoZBy8tyM4c2SmoU/PuZhujwDRPBntD9/0ZT8doxOVu+J1YDz3t5d16eomc5ldCJeaPQIuU0Nrzr7boedMvvkT1Y23HOHL9c+VvcvuBCDovJp24sc7vcxdzhQTKbPEjle5B3nzyN337O2Ir8oWuy0S4UEa9LxAu9dX4Y2eeJZICn/VT8M8Tyo1DWMwKXTRFYDyYK6kh9eD2P0HzaK2Uk/CRTiW06EhADCDSCHI7N22w9JQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f36cd366-aedc-4b63-f911-08df40b4b4f7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:01:38.9383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXWsRT7Y8eknwXqAKsKCg2PnZZYIcJFYRHcpdt6YUWIYofXxl6wz0r8D+pNjqrcYcQO5EJ2P89ElzeWqgbdCGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7970
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 17:07, Duan, Zhenzhong wrote:
> Hi Clement,
> 
> Good finding!
> 
> It looks not easy to refactor all these as
> vtd_switch_address_space() is called in many callsites,
> not only fast path.
> 
> I see in vtd_switch_address_space() vtd_as_pt_enabled()
> is called twice, that's obviously unnecessary.
> 
> I'm not sure if it's possible to cache CE and PE before
> all vtd_switch_address_space() so it only needs to check
> cache for PT.

I had considered it as well during reviewing the prior patches. It might
be worth thinking about caching both CE and PE in the AddressSpace and
gating their life circle by the CC/PC invalidation request from guest.
In other paths, we can just refer to the cached CE and PE. But this
means we rely on guest flushes cache timely when there is CE/PE
modification. This is spec defined behavior, so might be fine?

Regards,
Yi Liu


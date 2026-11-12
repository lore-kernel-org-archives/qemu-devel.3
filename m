Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C4606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f+MYk+TT;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DBfuNrYX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRTRN-0004dm-CP; Thu, 12 Nov 2026 06:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xRTRK-0004cI-5U
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:58:02 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xRTRG-0003K5-Ut
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794484679; x=1826020679;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zjxQPqQcWO/e2308mBP144Vhrqy/OI+fqDv6pgPmbpY=;
 b=f+MYk+TTNKmPZ2IwMbNkYVoa7FvOlF94bT6ucLcOspgY9d5CqeITin2y
 616/BRxlLI3+5tAnK+W4KKB28p+MyAMYreIomM7QsnyvRdNq6TUp5Bql+
 NUAgJi+bXgnsqy1gVF6rU3ioyqRoBCuNdv3D8llM36pEviL0FyT31CAyo
 3x/K9xrODlLCUi143eG521mBZmKBU9yb2MkyIBDQUir5I/t45zR1dngcl
 Pt56GOyuzVl7PrXmz3X4EuEyf6XxY74falAHa0TX4IaPDPgzOuftUlAF7
 Da/tUVyHzj/O5T30mpbtfrGB3ISWyYOM7UG7rYdFZuMoRMb5WXqNAFHRN Q==;
X-CSE-ConnectionGUID: iQyZlM5JSuuX/oG3MsmaXw==
X-CSE-MsgGUID: y+YdSCkfRGGku6VdFGfJOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3177898"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3177898"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 03:57:55 -0800
X-CSE-ConnectionGUID: pxAWSbkzRjeFj+aA3yT3YQ==
X-CSE-MsgGUID: SevXisCnQSGi+y8zF96m4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; d="scan'208";a="10537850"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 03:57:56 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 03:57:54 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 03:57:54 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.57)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 03:57:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elaYF+D62mck4zl0BJFOAYOZ5Fglwe61WZEAGYszv1bd7xK8gr+rcz47YMYCRcporsR59z6khNX5DYFXb1N/xOIEHNDwj5voKI+XJX/gQeO5sOtoPGj8/sEyOxfPUT7qOySRXNyFuTwwlJ/Ns6odg0Oj+JYJAjy0Kv1fK/AA0Tslfyjc+HE6l/t6ZryId6NhCGEACwLLpyEWUUTc1Wvog02vUesCI7ONbAjrCfs71zo3N/3/PMrfppkKESXM+S2RxmlKCs6OFk8oJ58UyG4meCCeZR/f4w/+C7d55lZfSvWp28OPQjxyzVQkfPi+mCjp24wz7baeJWRNrGmzKdfa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DW56SVb0CzTelJnoPnCWHKHh0XPmH6KWGt6J7DA3GU=;
 b=gHSvk0ZLWrb2kSL+zJwSwXU/z+mAV1Xd1DkbWbTqXOJfR0EMW2vruEr8N2tgCTTtoGGl0VJkCCv9RqnribXNwizo+5k/ghnbPI6/2aN2WQRf0lTqXBaMwXISgFyh5PVpwdKIOY0DCebavtb61TOqYOy1DchVZjMAniU4MoGPliqt/sNMZUVX35SUUJT0n0/55zzgqBHff+FlYAxCe9/PuOJOqxE8U6gat8F0YYpJL0EPIqgL5zOb7xxnrZNDupd0FNsPVu1t4dWf+bbagLzHvLsBjDr7Jfp0kDUi1ZSt1p6kjW6hMXoS8YTFRJBKh1ONeigi7YwB1q7OYByE1XpAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DW56SVb0CzTelJnoPnCWHKHh0XPmH6KWGt6J7DA3GU=;
 b=DBfuNrYXJ7Ft7v7Yz4WsDdkaHg6vRubkiG21AdOTBVFhBOpSm19YdLcvcbziOAo0h0ws4FuMy3a+OwJd2lTvI9pkyodFqKURI7+Mi7PKuMLjnwcVwO7oDMWF7s5pp8FMSP2WxTtjQuYZdjoapOSpRE2Yymy3cX8mCfieClUMLlU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by DS0PR11MB7970.namprd11.prod.outlook.com (2603:10b6:8:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 11:57:52 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 11:57:52 +0000
Message-ID: <9dc3e951-9fe5-4f2d-bdba-77ebfe5af82c@intel.com>
Date: Thu, 12 Nov 2026 20:06:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] intel_iommu: Keep PASID cache consistent with PT fast
 path
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <clement.mathieu--drif@bull.com>, <mst@redhat.com>, <jasowangio@gmail.com>
References: <20261112081509.442872-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20261112081509.442872-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|DS0PR11MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: a88573df-99aa-4fa9-c931-08df40b42e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|42112799006|10067099003|5023799004|11063799006|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B2ILUFL8BPQzkLVFlVQa7IdkUMcIUJZZGD3gnWx93JMDRSbTYrfgZrFKz85uWynLngqBx8GuZgJOLiGAMKLvrjBZa6qgiZgoDawTntqP/RlAfLsn/5QF9n5e5dTAgW642vOzTvx9in/h0RXHPVa7AuGkcMGUJQj59jTTBAmV5J7QUDZTraCp5dPdcJdl25BOlCoAqQzOZdeqPgiwxnz+1sgOnD8zSKnpNWp4OS0HHUO7WjBY29OJgKGZmLnfnnKXvEqzJqvsNFP1Rcb0h07ZoEa5kvQK+I22fkeKSJvH9hNirVJ3yYukbqmiLBXluUZ4dhioxV3mDQ2pYha05Rvw4iYnBIzFPo3CErHqdgpmkvoQi4CkuDx6DaQZSMWl/S268MZiB6bJj6zkLYcjrM4YsDy7FyEHBhA66HE9yBKeWCQ3/qLaN6GHzpwx/DMTvqybFfgaiy3on6PJgrEvK0Ijj9AeEbsS3HSxb++MRFBgnYO/qzSJkM6Ged4HGJhKnYu3Upa5s5wEVY7Y8u1RmtBswcprpveNM3YF3T3+vUitCm1pjO4cPpo33Dli19FETwS8buIwApN2y36LsSu7MOcGYFF4SBusXPJOGBzKv08hRV9QUexiZY+NUd6ENrYj+Ckd/oxooBGG/ekOaco6zY+f/eMSHQLJIQ7exrvggld5LiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR11MB4527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(42112799006)(10067099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjROaERRMGdLbUFML1htN3JBNUYwdDNZSVVoaTlBc0hQTWcyd1N2dWVNZEg3?=
 =?utf-8?B?Rm1ZSFhaL0M2cEVrRW1WbUxTcndpSlVoN2c4VVFDZzdnSTlMRytZUGlKT1NR?=
 =?utf-8?B?bVlFdGVXSm9vUGFLN2xuenk0aEFwaWJBUTVFZTZFekxhbGNPU1ZiWmxjTmxt?=
 =?utf-8?B?eEt3T1pHNWlpNDJrWlovNGlpenZ5bHdzMGFGQWM5ZzFLUzBpWlJ6ayt3c1Bm?=
 =?utf-8?B?RGZjb3QybDdlTktCMDVhUlM1clVTVmVIQUJWK1lLYUprbVBDUmdnNmhoUzNT?=
 =?utf-8?B?TUMzbGNmQW13VWNnVFZpeXRFbjArRndRYmNwUEplcFdDUk0wSk9NQUJmbmph?=
 =?utf-8?B?ZUZ3Y3ptZ2d5T1AvM1gvVDc4Vk5NTzNPRHY3ZEt3NUdNRHNXUm1temRseTRY?=
 =?utf-8?B?eHU4V0JubkM3MkV1V2hTZHp3TWxtN084SVk1b3g5VGVDYVQ2cnoyUTBnQjFk?=
 =?utf-8?B?cVFNTEVpZzRTZ0JVZGJzM1B2anpUUFBXUjJuYkRSQXloR1JraXJ4RHdTOUVh?=
 =?utf-8?B?bmtJR2pGQWJrR21ueFIvZWhOcGdwSkM0eGZuQlNxeHNFSDV4K2RpQTJ4Tit5?=
 =?utf-8?B?bmY0QnB0d1NvK1hIcUNSOWVaSHdDTEp0WVBGbDlDcjN3ZkFJNGNZeC9oYmRj?=
 =?utf-8?B?OFBQQi9pNzAwQzV0bEpCMkQ4dWhGdWdOb0JrcTZxUHA3b3NPb0kzMFUzSFI5?=
 =?utf-8?B?Mk9BWkRJNmJxdWFteE5FVHVFVnBadVRwdTJnVVVEZXNLMHQ1aEowOEtXR0d2?=
 =?utf-8?B?RlVIVGJJaGR5bmtDaUw4ZUdrWHZWSlJncktmcTNGQjZScGFLM1h3ZkphQ2RO?=
 =?utf-8?B?czN1VVV2SExvNUM0VHpFRDZmcVJpVDQ1TlJLb2tNNW9rL3BxSmF6T3RuWHFz?=
 =?utf-8?B?enJEYUZodHNUOVVjK3J1dFYxNEYwb1IwWGFiM1RNOGFnZGhvdUpuL0dWVG9V?=
 =?utf-8?B?UzV0OFMzdmxoK2NTVnVabmZUbTcraEhTSmU5U3RDbDdxWUxwS3J6MEJoMm52?=
 =?utf-8?B?eEw2TEdIRXRmMmxocVVMYkpEQWdrYVBwc1VSeDUzbW1uS1A3NWRlSHFhRkNC?=
 =?utf-8?B?aVZlSm40bFBMOTJveWxIV2FaUmNPUlBQQ3oxbjRjSEVsZUZRU1hDczJKcldE?=
 =?utf-8?B?QXJKSXZadVFyTk9wc3AzdkhPRVRjREl3cXQzOGxaaEhtUU0rSnU1STRTTFJR?=
 =?utf-8?B?cEU0VFZnS2czVitDNjYycXEzYkRVNjlqTzRPQ0l5NDZmdW5KU2pUQmh0YWpp?=
 =?utf-8?B?ZS9CYkVzNC9CblA2dVZsQjZudlFDc0M1WkJBTVdTcDJGWHZlbzFxemZYNnZO?=
 =?utf-8?B?WlFjb2ZUWEJCUHpUZ3dpbjk1MFMzSWVLU0pTeVVlWkh3a21oY2I4ZTdncXAv?=
 =?utf-8?B?SlpZaDN4L3hQcktqSDVGTW55bGFGaFBXT1hMdWpZTUViOUR6SXlCclRiZFpl?=
 =?utf-8?B?SUlmM3dJV0NnZUpwN25lbDNuTDdyVkU5VVN2am1pckNvQnZ3ajJia0pERGNT?=
 =?utf-8?B?SmpsODlHZjRzeE9ZSmVSQ2FaMytzZ2tsUlhyS2hvcmlVN0NVaXRxeHo2cXU3?=
 =?utf-8?B?NXk4SEprTTRmejZKVndTcTU1QS84d2UzY1hpT0lDTE52b1E2aDMyUDdmYkVO?=
 =?utf-8?B?ZG9RbHUvZUV0MHVHaStXYkIySkpJQ2RoV0dUWWJucEI4eFJYYnQrT1pTREFT?=
 =?utf-8?B?ZUZLa3lkclFhNi9nYTd1OFRnVlNxTGUwNFVhRlhVOHRYd2dENXhObU03d0cv?=
 =?utf-8?B?RFRiQjVzbUovQlBVVVFucGlvOXB4MDhsdzhXWmloQTkzWXlYdDc5cDJQVDhE?=
 =?utf-8?B?UjhEMTh1MmpBKzRFVlpnbnhtY25Gd1dwNmZvR3M4OEE4RzBHNHJ3NmJpM1B0?=
 =?utf-8?B?RFQ4UHVncFlFaHMrdmljb1M4cThTMFRmdlREeXNhZGRTNU40b1lKQ1JLR2RP?=
 =?utf-8?B?SHRWVEU2T2JrU09QU0NzR01BR0FmcGhLakxVYVhvUTJQdFU2RDdHWlhuQ1Ex?=
 =?utf-8?B?MEZza05xRUlka2g2a1RvNnJ4VjhhOC9sUzJ3SVUyZkJwMUZLYjZGdEdxWEEw?=
 =?utf-8?B?ZzhvYWl3K2JKd2VEYmJSdFZHc1NrLzNZNzBlNmw2Rm1pYno2dXhWRktjYnhh?=
 =?utf-8?B?TDByTlR4VnIzTlNpWWp0RjZMcGhjOFNZSXExVVJpVVExUnNvamNWNmN1T29q?=
 =?utf-8?B?ZHlycHVDOWQ5RTJVK1pIeGxITVR6V3JaK3FrSTliZmFhQ21JTWl4NSt6a1lP?=
 =?utf-8?B?QWJiektMT1VObFBrRVdVeVV0RFhhcDhnTUpUd3Y0RXcxWjFhcHkxRWI4TFY0?=
 =?utf-8?B?UXFRbzN3bU5iUi9RbnF1aVNOTmpYTGtlZ0RCWjZUZUJxRG5rS2Vydz09?=
X-Exchange-RoutingPolicyChecked: 2rXj6M1mTHxLkWhsGI0RfZsnje/UIMUed/cyy4BDbBuH+Mqdh6zcTikN8QOMic8N1cixH6fiuvFPrFQRWz9Xyg+z8+Brz8Xq0C9yP2INwddn35Iu9/1EArENAF6RrdWeH7aBoJZuKsatawUiSg1l8yICzEkeirz/fyPq1DdYjaxMRE097TigY2hpuYg6uHV94FWxtq6J/d/OBm1OXy6n/8VOuRwhYR87yxlbd7L32L3COyunMiXsguZHSssb49LQWgrxIRabFROk7wNYKilW8cCibEdmnct+6a3tSSSG8S5FYp56OCmYLzc0fdx4qGSref0Ggawdv0jkMpzaSiR09Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: a88573df-99aa-4fa9-c931-08df40b42e05
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:57:52.3361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BY2vqGFYd3CpXPybFndj9Spp4DHV1aS8dmM2Gd47+wGgZ40ZC0jV2pRVDQUkp3jHzQ3/25JeLcc7h4CuWP/esQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7970
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yi.l.liu@intel.com;
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 16:15, Zhenzhong Duan wrote:
> With caching mode disabled, a guest can install a scalable-mode
> pass-through PASID entry without issuing a PASID-cache invalidation. The
> first DMA enables the PT fast path, but leaves QEMU's PASID cache invalid.
> 
> When the guest tears down that entry to switch back to a DMA domain, the
> invalidation handler sees both a non-present guest entry and an invalid
> cached entry and returns without re-enabling the IOMMU memory region.
> Subsequent DMA therefore continues to bypass translation.
> 
> The issue can be reproduced with an emulated device in scalable mode
> with caching-mode=off:
> 
> 1. Unbind the guest device driver and change the group's type to
>     identity through /sys/kernel/iommu_groups/<group>/type.
> 2. Rebind the driver and issue a DMA write.
> 3. Unbind the driver, change the group's type back to DMA-FQ, and
>     rebind the driver.
> 4. Issue another DMA write using an IOVA mapped to a different GPA.
> 
> The second write incorrectly bypasses translation instead of reaching
> the mapped GPA.
> 
> Save the PASID entry when enabling the scalable-mode PT fast path so
> teardown invalidation can restore the IOMMU address space. Return after
> handling a non-present entry, and refresh the cached entry when a present
> entry changes, pass vtd_as to vtd_try_enable_pt_fast_path() instead of
> pick it from PASID 0.
> 
> Opportunistically clarify the invalidation modes in the fast-path comment
> and merge trace event vtd_translate_pt and vtd_pt_enable_fast_path into
> vtd_fast_path_translate_pt.
> 
> Fixes: c9cf33075a4c ("intel_iommu: Fix DMA failure when guest switches IOMMU domain")
> Reported-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> ---
> v3:
> - introduce a new helper vtd_try_enable_pt_fast_path (Clement)
> v2:
> - move "VTDPASIDCacheEntry *pc_entry" in the branch it is used (Clement)

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   hw/i386/intel_iommu.c | 62 ++++++++++++++++++++++++-------------------
>   hw/i386/trace-events  |  3 +--
>   2 files changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b7da5d086d..a5ff89a11a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1649,7 +1649,7 @@ static int vtd_address_space_sync(VTDAddressSpace *vtd_as)
>    * or second stage translation, it depends on PGTT setting.
>    */
>   static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
> -                               uint32_t pasid)
> +                               uint32_t pasid, VTDPASIDEntry *pasid_entry)
>   {
>       VTDPASIDEntry pe;
>       int ret;
> @@ -1663,6 +1663,11 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>                */
>               return false;
>           }
> +
> +        if (pasid_entry) {
> +            *pasid_entry = pe;
> +        }
> +
>           return vtd_pe_pgtt_is_pt(&pe);
>       }
>   
> @@ -1689,7 +1694,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
>           return false;
>       }
>   
> -    return vtd_dev_pt_enabled(s, &ce, as->pasid);
> +    return vtd_dev_pt_enabled(s, &ce, as->pasid, NULL);
>   }
>   
>   /* Return whether the device is using IOMMU translation. */
> @@ -1701,8 +1706,8 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
>       assert(as);
>   
>       s = as->iommu_state;
> -    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
>       pt = s->dmar_enabled && vtd_as_pt_enabled(as);
> +    use_iommu = s->dmar_enabled && !pt;
>   
>       /*
>        * When guest enables scalable mode and sets up first stage page table,
> @@ -1887,23 +1892,34 @@ VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
>       return vtd_get_as_by_sid_and_pasid(s, sid, IOMMU_NO_PASID);
>   }
>   
> -static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
> +static bool vtd_try_enable_pt_fast_path(IntelIOMMUState *s,
> +                                        VTDAddressSpace *vtd_as,
> +                                        VTDContextEntry *ce, uint32_t pasid)
>   {
> -    VTDAddressSpace *vtd_as;
> -    bool success = false;
> +    VTDPASIDEntry pe;
>   
> -    vtd_as = vtd_get_as_by_sid(s, source_id);
> -    if (!vtd_as) {
> -        goto out;
> +    if (!vtd_dev_pt_enabled(s, ce, pasid, &pe)) {
> +        return false;
>       }
>   
> -    if (vtd_switch_address_space(vtd_as) == false) {
> -        /* We switched off IOMMU region successfully. */
> -        success = true;
> +    /*
> +     * When this happens, it means firstly caching-mode is not
> +     * enabled, and this is the first passthrough translation for
> +     * the device. Let's enable the fast path for passthrough.
> +     *
> +     * When passthrough is disabled again for the device, we can
> +     * capture it via context-cache invalidation in legacy mode or
> +     * PASID-cache invalidation in scalable mode, then the IOMMU
> +     * region can be swapped back.
> +     */
> +    if (!vtd_switch_address_space(vtd_as) && s->root_scalable) {
> +        VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +
> +        pc_entry->pasid_entry = pe;
> +        pc_entry->valid = true;
>       }
>   
> -out:
> -    trace_vtd_pt_enable_fast_path(source_id, success);
> +    return true;
>   }
>   
>   /*
> @@ -2167,23 +2183,12 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>        * We don't need to translate for pass-through context entries.
>        * Also, let's ignore IOTLB caching as well for PT devices.
>        */
> -    if (vtd_dev_pt_enabled(s, &ce, pasid)) {
> +    if (vtd_try_enable_pt_fast_path(s, vtd_as, &ce, pasid)) {
>           entry->iova = addr & VTD_PAGE_MASK_4K;
>           entry->translated_addr = entry->iova;
>           entry->addr_mask = ~VTD_PAGE_MASK_4K;
>           entry->perm = IOMMU_RW;
> -        trace_vtd_translate_pt(source_id, entry->iova);
> -
> -        /*
> -         * When this happens, it means firstly caching-mode is not
> -         * enabled, and this is the first passthrough translation for
> -         * the device. Let's enable the fast path for passthrough.
> -         *
> -         * When passthrough is disabled again for the device, we can
> -         * capture it via the context entry invalidation, then the
> -         * IOMMU region can be swapped back.
> -         */
> -        vtd_pt_enable_fast_path(s, source_id);
> +        trace_vtd_fast_path_translate_pt(source_id, entry->iova);
>           vtd_iommu_unlock(s);
>           return true;
>       }
> @@ -3133,6 +3138,7 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>               vtd_address_space_unmap(vtd_as, n);
>           }
>           vtd_switch_address_space(vtd_as);
> +        return;
>       }
>   
>       /*
> @@ -3158,11 +3164,11 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       }
>   
>       if (!pc_entry->valid) {
> -        pc_entry->pasid_entry = pe;
>           pc_entry->valid = true;
>       } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
>           return;
>       }
> +    pc_entry->pasid_entry = pe;
>   
>       vtd_switch_address_space(vtd_as);
>       vtd_address_space_sync(vtd_as);
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 7bf4cddd38..3337a7e19c 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -47,8 +47,7 @@ vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"P
>   vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
>   vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
>   vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
> -vtd_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIx16", iova 0x%"PRIx64
> -vtd_pt_enable_fast_path(uint16_t sid, bool success) "sid 0x%"PRIx16" %d"
> +vtd_fast_path_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIx16", iova 0x%"PRIx64
>   vtd_irq_generate(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64
>   vtd_reg_read(uint64_t addr, uint64_t size) "addr 0x%"PRIx64" size 0x%"PRIx64
>   vtd_reg_write(uint64_t addr, uint64_t size, uint64_t val) "addr 0x%"PRIx64" size 0x%"PRIx64" value 0x%"PRIx64



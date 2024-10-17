Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FCAD374A9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 15:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SOl-000349-Pt; Thu, 17 Oct 2024 11:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SOk-000340-H1
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:26:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1SOh-0002jH-42
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:26:46 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBrH7028923;
 Thu, 17 Oct 2024 15:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=0DdyuJxue9symlEWgCamcj3EYq5NE8yFB5YGCRMfXnA=; b=
 WoAHoN7ZulTBFzzV+4d3+o/gupGH+mUlSAABtOgcfN7k7FKkBnxJ1XZ1KKA8c6N1
 vLJmcZYE8u28e0RYL8twKYJts51+A6NLFeHOgKpfOOL0naUZj/vDzhZfxQOLowf9
 SmvA4tVmWN8exrfm0fdGEJKKKlYoIkQmIfr+wf8CslKfYMpm9Pd7d9SUL+4Zvk24
 hT4/KX25lN6FfOp/VBgEFyf5wUMSNxWB4mrmskx9m14vqUeGz862wRx0iqrlRVGO
 fN5rmFGg2ZFWfpdJspmgpsnOzjrfQs63xD4LnkwTndJZvkmyVSmVLIt72Hb02PXU
 dLA/Zv/7oAnwSXchhC85gQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt6qsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:26:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49HESivH036038; Thu, 17 Oct 2024 15:26:29 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjgv7nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Oct 2024 15:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/tGeTRGHIrLCxynpUSJbwOaVkoxAgmb9Mn2+433+tE0Ci4gz+cCGMySJR2920IT5lUErT9g97ALGtr9izNNrqW5igDH3m5Go8ktQFrLzgp6UaOcDXcLKnzYJFXHTUBAK2sMjfKd1Y5PKwyJeiqSCoSHxlErrgwNa7kKF91JFTGVMTpgfxzwHAMPr8vVGBR4NDmx7FdLHtRAfp3nPHsusX4UGBB4grSyoc3z8JxRyZl1mzdLVpDxZlKOjGhkwJ9JQcZ3hgQ1YUoORi127v80pb78sDP9wffv5st4yJMYgaI2CII4ln8bbPsiAAveNaokxEGj/nUDfBRgWUQvYrXQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DdyuJxue9symlEWgCamcj3EYq5NE8yFB5YGCRMfXnA=;
 b=g4udbXHq3mMqDUb7V2G0K6ssYpVqR23lo9i0mSrGApi/a0QZLFwrO5Q3gmrKJgPojlvuE+xs/huLwtiqeSsF/gDUyT4v8RJB8FaI+vU6vzfMM59nMq7Gev3ZhIUL7mHwXGzGTKwr53vkpaP2g+M0UxPQ2Hdbyx0QOPaXa7/GuO+V2zT4XSYhEzpMINTwjKXvd7gH2M8faj9/GZnrkTlH7I7z/KE4JHTLi75BLdfKGBrNtLdwbdMN6AWW1WV5yI9rTMdoJBm05Qx9wQ7FOlam32SQjholSuhwII90q44KsRrOXPZBFnGIsPMYH2kP2/DN5VNBD4z8MH0NopD0BBnL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DdyuJxue9symlEWgCamcj3EYq5NE8yFB5YGCRMfXnA=;
 b=e6himRsT/sUkGr9bcwPuWdF4s/G7uRoCj7VTaFPwGPRm+WX54csVrAe/hHPiUYbaFUihwWry/OHpdKe9G8VjZLSRF/hDHtwVj1gUcEZQvTzrioPSywttAVHcGInkoSSzh6v9MGK4dHCK90Akc8EpWsOVyGJPss0wHw1A/FWE29o=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 15:26:26 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 15:26:25 +0000
Message-ID: <3ce80d5c-0ed7-478a-bc31-24bfe9add98a@oracle.com>
Date: Thu, 17 Oct 2024 11:26:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 02/14] accel: accel preinit function
To: Reinoud Zandijk <reinoud@netbsd.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-3-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1729178055-207271-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013DFE.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BY5PR10MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce2d4f4-4f47-4eee-4b01-08dceec003ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWNqWlFtNldmbkxPUHFOUko4YUNMUmptNytYcE1nS3cyeG1xbE5ORGhuaGVs?=
 =?utf-8?B?MWxXVnl3YkhKNGNDbnRxQzNTOGFHTUFvNHhSN1piMEpUcVlJQlJ4WlZCZmYx?=
 =?utf-8?B?cEVjeTk0QWNJRG9ZV0pnVm1ySzdIUHYvemUxa0tNam4vcTZEY2MzWmJMMURa?=
 =?utf-8?B?cFhIQlBIdC9MemFwQ2Noem11V2xidksvQWpaVHUxL1lxdTIwbUUzYmRlaXFZ?=
 =?utf-8?B?UHZ5ZXVxSWZ6dGZQdVVRbDJCVEJ1cXd3V08yVEFhSWhEamZzN005MllSSlRJ?=
 =?utf-8?B?cU1jc1gvcG1HVnc0cEhpU1pWL2NVSFZWZ2ZHM0RhYVZDR0VOaWhLQnpsRy9p?=
 =?utf-8?B?REhjSDBFS1FKdlFISjQxL0lDRFNQYVo2Rk95VUlqRitralJ1aU1zVTU0NUVy?=
 =?utf-8?B?V21TenBSK3ZEMkUzbjZXZERoQ2N3RHlFdUpMTmMwVEl6bTRtOVhBU05lV1lH?=
 =?utf-8?B?R1JiWkNUNHZVNlVrWEpjZWNlcHJ4aEh5bWVrSGg3elNhcGRGQmxocjg1WjlR?=
 =?utf-8?B?RVJsVzNXWm5Gd0tFYm9zZ0VGMG1sUmQ3ZnV5b3M2blhJYkdSMTNHSUwwcWpY?=
 =?utf-8?B?Q3g2VHI4V2NxR3VTa3N2UW13aW83eDdaL1NOeTJMeUQyeEFNUUxLVzBRaGl0?=
 =?utf-8?B?YnMrOTVwWG9rang5dmNzN1FEd0VoaFZoYmdMWW03ejNZVlV1ZVpUaitvM0lP?=
 =?utf-8?B?QTJKNHN3Rm5SdGZWMlBRVWkzcCs0akxZVEg1K0VxWm5EN0gydy9TMkl3VmhK?=
 =?utf-8?B?MWdmNFUzeEkyTGNoRW96VGZGRjEyMjRneXFqaStuN1RjQldZYVN6aWlWMEs1?=
 =?utf-8?B?blYvM096TmMyVkJVTkl5UjRXaWNiV0ZDQWIzRE5sekNKT0NIenRCU3p3ZUIv?=
 =?utf-8?B?TytzR2FxdFpDakFod3hVY3I3NVJXV21HVkxFVThmQitlVmNoVHV2RmcyWERZ?=
 =?utf-8?B?cmtjK0dnS2lBSHBKb0UyTDBZcXZtRnp6eW1jckZWVDgvRFcvNFZvRHo3WUMz?=
 =?utf-8?B?emZGMFcwbng4aEJsY3FpRHI5M3NMTlRGMzh6STVyOWZOaUI0RUJ6ZW50OFhE?=
 =?utf-8?B?SVRzNFlOUXU4L2V4Z3JzbUxSYjk2OUhOV0VhVGIwZUE2bHd6dW9rZ2JKS0xF?=
 =?utf-8?B?dUg1aDJONE9Oa29pMHNyUUZwajhyOWtSZGRialhNeTE5RTczdVJSVU1IM05W?=
 =?utf-8?B?R2ZrL0ZZb0dzc2Q3Z0MzQnpidmlZVWxqaU9Zb25aZ2hpVFdqc0VudEVlM2Zk?=
 =?utf-8?B?NGQrVnJOV29KNnpSc3QrL2l2WEYwdFZ3bjd0RHp5bDlZdmtrakluT21CYm5q?=
 =?utf-8?B?STdFL1VwNGJMTzlTRVkxQXBsVHo5eHJlaTJLUzBqbElLM1hkSzlaRTdFRVpE?=
 =?utf-8?B?Z1J5cWRENlFTbno2c25yeXc5cmpNYWhpNzhxY1NPNWhPekdnMEIycG11VGkr?=
 =?utf-8?B?Z1FCSW1iZ3BYRU4yVVl0L2NvdXprNVpWb2VoZ1RTUFo4VkZDeUpIUjF3dGtY?=
 =?utf-8?B?bUtjL1RzWGQ0eEg3VC85UC9NUEJMVWRscUVWVkNsVVRTS1BBeFRiZlA3cm5G?=
 =?utf-8?B?QkJVVWVyUi82M29UaWVsYjhPeHByWHdPc3JuTjE4TGRiaGFNKzhoOGR5WWVq?=
 =?utf-8?B?d1lOVXpWZXArUjZXTFdzd0JWRVQveHF5dVBxOWhnS0QxV21QREJlRi93NWVJ?=
 =?utf-8?B?WDBUWWhiMWJ6Y0FhSjV3ckhYbWZ2eE5mRzFLQnNDcjd0cmpNUTNsZ2FPTm91?=
 =?utf-8?Q?spfZNFFC+CpAwr9zSRNb33h7SnCtYwLQMAigqrF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkE5Y2NFZjJTUm1VdjRkNS9XUUpvS3oxQkhOalBIeld2Qmc0aHJDTExyMnAr?=
 =?utf-8?B?Z1hnTjYwQWpVREdhQkZBb3FEM3VHYy8xTE9LVVhGdEpKd1dWVU9yZDhMQXhC?=
 =?utf-8?B?K1dpeSt5QjV2MzhkaG9TWnQ2dzdlSDVsT1IveVQxc2p3eDNYNms0VmozTFpa?=
 =?utf-8?B?cWc2ZWN3WEZpYWJNbTNpMjdycGU5dEZzNzBRdjVrRWQrTWVKYXBGU25JTFBT?=
 =?utf-8?B?SDFzL29MdDMwK25JWGsyaHJ5NTB5L05OQU5CT0dZbWg4RCtybHhrRENVWUtU?=
 =?utf-8?B?WHY2M2R4Nk83enNndmhoelJEZHpLTjI0VmhZc3RSY1lzT01FaFlpdHJqcnhJ?=
 =?utf-8?B?T3BRKys5UUtMcUxTR0dEb3VvMk9NWTNweWNEbCs1dmsyZUZ0b0Z0WVdJU3RI?=
 =?utf-8?B?bGJXeDVIVVNOaVBjT093OFBvMURPTlZMWkRJWnVLNnphY3Z6NGh5STZRbUp1?=
 =?utf-8?B?enZnTGN1WW94V3M3VGkwTjhWbStCSE9ubTN4QkRvR1lZUTVJd211ZzdkOWU1?=
 =?utf-8?B?SGZCaUphS3p4ZEdZcXVSZFR1MDQwZk5oY1BBa25SWENYRkJMa0JZZUxOb015?=
 =?utf-8?B?bjl0RUR3Uk1vMEZwc0pTZmtwRHEwS2oxbkM5ek0yRVdBMFd3VjV4YjJYWEVK?=
 =?utf-8?B?QUpIbFlDNTNpTWY1bkJ4U3h6VlJTeFRvRnlhb1UwaDkrSjZvTnluMVRKRGhP?=
 =?utf-8?B?RFNLVVEwZTQ4Q3FNb3dPdmM0NjFWSDNleE8rb3dZMEMwazNYVTlIdTdnQlJj?=
 =?utf-8?B?SE9EejVSbnRocXlOUDdQNjFYZUdnTTR0MEZYbjk2WXR5Vk4xYngxOGRlaDhW?=
 =?utf-8?B?SlpBbVUxbFNuaE1yQnlUT3pUK3ZoV1ZLZkpUVDRXaS9RYXIrSlRjaHlXTEtz?=
 =?utf-8?B?ZWhWWGthNmpSZE5Nd1VjQzQvV29nMisybER2bzZYTU11aXVDU2RGZFBPV0VZ?=
 =?utf-8?B?eU03QjZ0SUE3RU5WOUlRdWVVamZpMElwamg2dTRvaEtZYVpSYnY5ZlpJcjZC?=
 =?utf-8?B?MUU5TGc3WEk5NWsxTWFEM3ZBWEpuOWRacUlaRVlCeFZvajZROTNHa3QwNXl4?=
 =?utf-8?B?VWNUZEE5b1lrTkpWb2VmZW1hRE1PTlNOVitMbXZyM0JlOHNqS2UrdUJSSDcx?=
 =?utf-8?B?dEpqc2k2aW1hcGdCVjA2ejBNcnJUUlNvSFhqYjN0ZmY3Q21GUytkdFI2UkYv?=
 =?utf-8?B?dFI2aWFEWXVJYWFrSFJBMGdjQlR3K1dzWFBjREhZUmFzbm1VNlhtN1pFME9T?=
 =?utf-8?B?dkJuZmZLRUFMbUtjSUhnbnd3c2VWMDhBL2tjcGZuODM4YjhlQXNneGRKNGJZ?=
 =?utf-8?B?YWdST05yWjBrVDN1UmZQTUxrY1l1N0dOVzhUNmFkMHdRYU8vb1NwWTBwUUVS?=
 =?utf-8?B?V3ZQVG9wbkN5UUUvL0praDdMcFRldDByS2VmdlJOVVBZRy9raVNNRDQzTFRo?=
 =?utf-8?B?dXVBRmcwRUpMQlRoN1VWd1BuKzJuK2JYbS9SN2J4VWRjYVpXVEszTjdUNDlH?=
 =?utf-8?B?eUI2QXN5OGYrU1BqdC83bnBaL0FqYyt2ZW0zUmdPb2lNWDdTdVZNTEpwRnhk?=
 =?utf-8?B?Vm4zOC9ZaGZwRG9BN3R0d3BkS2loMnYrN2cxb1RFVkR2VHV4d1FUV29YNXhL?=
 =?utf-8?B?d1pCbTJWWVdBNkFtQ3R2YjFaT3F4ZmtTQUFIMlBkTDRMVVpUNWIzN2VtNGVJ?=
 =?utf-8?B?SkFBYWJ6eDFQajZFWm0vcWx3aEFzNWZUcktKaWQzb3RZdFk3b2dQZ1R1aFNa?=
 =?utf-8?B?dSt5cjFNVklHL2YwY1ZQQ2ZaZElqdHJSLy9IejdLWUJ5T2FyUmIzYklNY0Ey?=
 =?utf-8?B?OTFkNVo4VTFCeWNGRHBNRSszT3VqdTgyellqL3E2WVpvOXF0cC9EckMvWSsx?=
 =?utf-8?B?WW85c1c4TEpETDltNUZ1RmJUOGhkeEZ4a3poR3MwMTFqWi9UZHdEZDQyMXh6?=
 =?utf-8?B?T2pCTWZPNHdXY1Qrd25iUGR2UkNaQy8yM3VnN0RRVzZCQWs4TWIvS05tTkpG?=
 =?utf-8?B?cTAydlZwOVJYekJhKzRhNUhWa21yTFEzUjJwbXM2SENLZ3doSVRINnhxR0ky?=
 =?utf-8?B?SlNlSGVBb1EyTENVcU5iRm1xWTZtZ3UwYzVWV3E2MlREYVZQUHc0a25YaHVH?=
 =?utf-8?B?eTdBRWlXdytYK3QwUUUvclJ5a2QrbTZDYWZ2b3lhYTZDcmsrVHdhMzJMR1Zy?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q7Pr4Uk0OaLyucUKWBAFZqROUqmRQmqeuAtjkM3zyC16CiSzkvIY/uQDs767pZkDlSRcQ9w620cE62/+983TLu7OvsX7ufQ4Jc9/bOALtEl5o6EnE6WEI91MKf9uzd+UGqnLe7pPb5ko2HzIs4pLjGUl5ESwgsPebQnlFFJo0ZR1C597tvg+QC3EbkPCshhFrf4htWW3jul63Wa7CzLnPbSlN37ZovOTOTGyQScyfrXsEvejLc+XVJZ6z2DTx7Bm2dHCu/SXzHs/tLd/FfwFpTrSq5gNHdF8huZfEW7Led0yzAmou47GR4xGdBNQQeVYOciPmvLMcJ6ITn1A8cyBpX4put4cYNp3tKDJd7uOVFwX1A0MJYG6sdZumQ1UurmZ5ALuP8gpze/OaRzPmpaPn/tlSkoR2i0BoXzyIWs7zJNk5S4sVGRmB3p/x4ogqNXClMkLLzsCgQjR7wkLJ8xi7k+H8RzkeVOgXFZawndiz3UoNKO7EjKULpIETa6qXJMqSQz35d3fdcFtG6FPcDZaSFzp5V3QiI0cEyQ3oZLq7PSJEOiTTB4vXRvMtSiVO5Q7atCaNd5EL8fDx9V20khBkkXk07u19q+Idvcce1Sf4ys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce2d4f4-4f47-4eee-4b01-08dceec003ee
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:26:04.7718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kV0Yg3bBmAf48ebELmq1LSaF7r4ZJ+p3mzJdP+o6RKZOy+VF1fb4ONLl25kM8UbDKNsgca8uZiTl4Dbj2tkYJinAWHljZ4HdwrzLIyl9sQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170106
X-Proofpoint-GUID: pN5A4LWa_7gtJcsLYUtxWNzgwqK_IkVu
X-Proofpoint-ORIG-GUID: pN5A4LWa_7gtJcsLYUtxWNzgwqK_IkVu
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

cc Xen, whpx, and nvmm accelerator maintainers for this accelerator-specific patch.
The cover letter for this series is here:
   https://lore.kernel.org/qemu-devel/1729178055-207271-1-git-send-email-steven.sistare@oracle.com

- Steve

On 10/17/2024 11:14 AM, Steve Sistare wrote:
> Extract the first part of the AccelState init_machine function into
> a new function preinit, which can be called without knowing any
> machine properties.  For now call preinit and init_machine at the
> same place, so no functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   accel/accel-system.c        |  6 +++++
>   accel/kvm/kvm-all.c         | 58 +++++++++++++++++++++++++++++----------------
>   accel/xen/xen-all.c         | 11 ++++++---
>   include/qemu/accel.h        |  1 +
>   target/i386/nvmm/nvmm-all.c | 10 +++++++-
>   target/i386/whpx/whpx-all.c | 14 +++++++----
>   6 files changed, 70 insertions(+), 30 deletions(-)
> 
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index f6c947d..fef6625 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -36,8 +36,14 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>       int ret;
>       ms->accelerator = accel;
>       *(acc->allowed) = true;
> +    ret = acc->preinit(accel);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
>       ret = acc->init_machine(ms);
>       if (ret < 0) {
> +fail:
>           ms->accelerator = NULL;
>           *(acc->allowed) = false;
>           object_unref(OBJECT(accel));
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 905fb84..c7c6001 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2484,6 +2484,42 @@ static int kvm_setup_dirty_ring(KVMState *s)
>       return 0;
>   }
>   
> +static int kvm_preinit(AccelState *accel)
> +{
> +    int ret;
> +    KVMState *s = KVM_STATE(accel);
> +
> +    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
> +    if (s->fd == -1) {
> +        error_report("Could not access KVM kernel module: %m");
> +        ret = -errno;
> +        goto err;
> +    }
> +
> +    ret = kvm_ioctl(s, KVM_GET_API_VERSION, 0);
> +    if (ret < KVM_API_VERSION) {
> +        if (ret >= 0) {
> +            ret = -EINVAL;
> +        }
> +        fprintf(stderr, "kvm version too old\n");
> +        goto err;
> +    }
> +
> +    if (ret > KVM_API_VERSION) {
> +        ret = -EINVAL;
> +        error_report("kvm version not supported");
> +        goto err;
> +    }
> +    return 0;
> +
> +err:
> +    assert(ret < 0);
> +    if (s->fd != -1) {
> +        close(s->fd);
> +    }
> +    return ret;
> +}
> +
>   static int kvm_init(MachineState *ms)
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
> @@ -2523,27 +2559,6 @@ static int kvm_init(MachineState *ms)
>       QTAILQ_INIT(&s->kvm_sw_breakpoints);
>   #endif
>       QLIST_INIT(&s->kvm_parked_vcpus);
> -    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
> -    if (s->fd == -1) {
> -        error_report("Could not access KVM kernel module: %m");
> -        ret = -errno;
> -        goto err;
> -    }
> -
> -    ret = kvm_ioctl(s, KVM_GET_API_VERSION, 0);
> -    if (ret < KVM_API_VERSION) {
> -        if (ret >= 0) {
> -            ret = -EINVAL;
> -        }
> -        error_report("kvm version too old");
> -        goto err;
> -    }
> -
> -    if (ret > KVM_API_VERSION) {
> -        ret = -EINVAL;
> -        error_report("kvm version not supported");
> -        goto err;
> -    }
>   
>       kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
>       kvm_guest_memfd_supported =
> @@ -3891,6 +3906,7 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
>       ac->name = "KVM";
> +    ac->preinit = kvm_preinit;
>       ac->init_machine = kvm_init;
>       ac->has_memory = kvm_accel_has_memory;
>       ac->allowed = &kvm_allowed;
> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
> index 0bdefce..dfcb90c 100644
> --- a/accel/xen/xen-all.c
> +++ b/accel/xen/xen-all.c
> @@ -75,10 +75,8 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
>       }
>   }
>   
> -static int xen_init(MachineState *ms)
> +static int xen_preinit(AccelState *accel)
>   {
> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
> -
>       xen_xc = xc_interface_open(0, 0, 0);
>       if (xen_xc == NULL) {
>           xen_pv_printf(NULL, 0, "can't open xen interface\n");
> @@ -97,6 +95,12 @@ static int xen_init(MachineState *ms)
>           xc_interface_close(xen_xc);
>           return -1;
>       }
> +    return 0;
> +}
> +
> +static int xen_init(MachineState *ms)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>   
>       /*
>        * The XenStore write would fail when running restricted so don't attempt
> @@ -125,6 +129,7 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
>       };
>   
>       ac->name = "Xen";
> +    ac->preinit = xen_preinit;
>       ac->init_machine = xen_init;
>       ac->setup_post = xen_setup_post;
>       ac->allowed = &xen_allowed;
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index 972a849..6b3b1cf 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -37,6 +37,7 @@ typedef struct AccelClass {
>       /*< public >*/
>   
>       const char *name;
> +    int (*preinit)(AccelState *accel);
>       int (*init_machine)(MachineState *ms);
>   #ifndef CONFIG_USER_ONLY
>       void (*setup_post)(MachineState *ms, AccelState *accel);
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index 65768ac..ce858a0 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -1153,7 +1153,7 @@ static struct RAMBlockNotifier nvmm_ram_notifier = {
>   /* -------------------------------------------------------------------------- */
>   
>   static int
> -nvmm_accel_init(MachineState *ms)
> +nvmm_accel_preinit(MachineState *ms)
>   {
>       int ret, err;
>   
> @@ -1178,6 +1178,13 @@ nvmm_accel_init(MachineState *ms)
>           error_report("NVMM: Wrong state size %u", qemu_mach.cap.state_size);
>           return -EPROGMISMATCH;
>       }
> +    return 0;
> +}
> +
> +static int
> +nvmm_accel_init(MachineState *ms)
> +{
> +    int ret, err;
>   
>       ret = nvmm_machine_create(&qemu_mach.mach);
>       if (ret == -1) {
> @@ -1204,6 +1211,7 @@ nvmm_accel_class_init(ObjectClass *oc, void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
>       ac->name = "NVMM";
> +    ac->preinit = nvmm_accel_preinit;
>       ac->init_machine = nvmm_accel_init;
>       ac->allowed = &nvmm_allowed;
>   }
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index a6674a8..50bfc19 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2516,6 +2516,14 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
>    * Partition support
>    */
>   
> +static int whpx_accel_preinit(AccelState *accel)
> +{
> +    if (!init_whp_dispatch()) {
> +        return -ENOSYS;
> +    }
> +    return 0;
> +}
> +
>   static int whpx_accel_init(MachineState *ms)
>   {
>       struct whpx_state *whpx;
> @@ -2529,11 +2537,6 @@ static int whpx_accel_init(MachineState *ms)
>   
>       whpx = &whpx_global;
>   
> -    if (!init_whp_dispatch()) {
> -        ret = -ENOSYS;
> -        goto error;
> -    }
> -
>       whpx->mem_quota = ms->ram_size;
>   
>       hr = whp_dispatch.WHvGetCapability(
> @@ -2713,6 +2716,7 @@ static void whpx_accel_class_init(ObjectClass *oc, void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
>       ac->name = "WHPX";
> +    ac->preinit = whpx_accel_preinit;
>       ac->init_machine = whpx_accel_init;
>       ac->allowed = &whpx_allowed;
>   



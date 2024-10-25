Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BC3D149CD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 18:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Opo-0006Ul-IQ; Fri, 25 Oct 2024 14:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4Opk-0006UN-Ux
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:14:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4Opi-00047F-Ji
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:14:48 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG0aUm002751;
 Fri, 25 Oct 2024 18:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=vm5kt2G9eCHXhcryUKAVlyMB3PgAYJr3ru4M1HFP9m0=; b=
 TgvDm/yeiTlvhqLZ+9nagOy/6kzhp56BlnhZBxz2OmK9VNxNU3g7wCECJZm7q5Mp
 lePKs6AR4iYKjut39LHv3lLaOWDg/hBaH5YoA/vVGcRcOIIWC9dmRgyHpyexZd6a
 GC96Ht3xgYczqwhMeiy03fgSmuDBCZnLOeAVQvMi34kycqnV/Mol1BaWnHXJuQ/w
 918yG+F6DEgfR6ARbuqAr5WYH9TfFVmQJxLtvNuBO+u502LmJRMlCmlVvaJBxjq0
 v36FRZSCPxbRrHfC3tt/HoohKiZ2UXfeFmPZh57Gqesxx9sGcsMTiG01WxHXzbAx
 sv8g+94PZ52VgLtmL9utpQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3mndr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 18:14:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49PHjXg8008750; Fri, 25 Oct 2024 18:14:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42g36atrug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 18:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhPsmpDuPoP9ybXNSpH5lMCkj7E+vXBc0qBQETOSvjpr3sDSY7w7tfwAJg3myiYIUpXLYS3WIkoR2fKc7YoNo5hvqetu1gMIrulUrx5MVG7fNtt1say+YSJ6AQDX294tvU81jhPVcF3iqkitmJfGeZYBu5kbd93mSOaE1/ejbkx238/ckbJUR9J8Sw0M4f+3PIrSK+wIBE/5RioEJPWLbhp1odsujOM4UvcV5v+gkMyorrAGRlgbHV9kHdtXJgNdXd2aqvb92OAhaLdTgxniDAV55MPsRe6D1uBGhbWwECYphNWmNaS6sMRhTlyR4UM5gPrvg0OS1o66KC9cMhYwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm5kt2G9eCHXhcryUKAVlyMB3PgAYJr3ru4M1HFP9m0=;
 b=b0shTsxYs/m/gZmDCdYPe+9INsQUyWLpOb1K1iBFTs4XI1vWOkc4b+ZRlQyj9I+A/7aaxzEUiVR2Nr/YGz+kwe5XuvlZxBKI82InOGlnM561RSBsizVfRzwZ5oH0/H50OdMQaKbDOB6G0lKEBltBI8+cu2/9hexXREB3CNugWuw1/7uUkp4MOWXIIJhzqZD7TEN0agdnyq6O6zbVUH5DKmYR4Uzu2+o4PspPV4ScHUyRrECD2/RD1vteW1hiLC0sPJjWQC7b/MbzL5xDjkneqSGz2/7e8ugpASR0Ia9IiYbw/lmuBV7TaTrOQgh92Eth3Cn7cSMCXF8kaF+onvqkKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm5kt2G9eCHXhcryUKAVlyMB3PgAYJr3ru4M1HFP9m0=;
 b=Dw3WmzMHByNGxctXuarkdMfFOtXJz3RDxcR7bIpEclYbOttYAmZhaFPqv5J0uUCgcVwXgjTns5ndQg3enWbWlJzteQgzCFkNDuvmk8NvurB98Q1YeKXbLjghI/pUrv4/fm6GW98UB9TQQGbpKFrsPmih8aN7k11C9lVoNC+yymM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB8175.namprd10.prod.outlook.com (2603:10b6:8:1f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 18:14:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 18:14:40 +0000
Message-ID: <079ad06d-bd05-4c96-b4bb-c7903932af1d@oracle.com>
Date: Fri, 25 Oct 2024 14:14:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: cpr-transfer with caveats
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, "Daniel P. Berrange"
 <berrange@redhat.com>, qemu-devel@nongnu.org
References: <87b1beba-4e03-45c7-b6ce-2772dcb117d1@oracle.com>
 <Zxu9g_pZo1KdBl3S@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zxu9g_pZo1KdBl3S@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0316.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB8175:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a5742a-3d1e-45d5-12ec-08dcf520e48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjRLNTM2eW8vdkJ1WUxTQmNCek9ycXYzSFlGZWFwYXROODJHVGJGaytodGVC?=
 =?utf-8?B?SkpCdWpzSUdYUERaWVpiN01lVnFSTXZQTitqWGJNbWpGeDZycWxjOUZna2V3?=
 =?utf-8?B?dS9scVh0cHRzZ29TVGUyRkYzYzNEVTQ4ZnljWHdpS3BsSjJVRnVnd25NWVF3?=
 =?utf-8?B?YTNRWmo0SGxvZisweFRFdVNIaEIyWGtKWkVFYVdBOTVJaFZYa1BMaTJNY21F?=
 =?utf-8?B?NS9uaVJVcW10RW5vaTM5UjVxa1F3UTFlUGlXL0lTUUNZNHhBT2RZWmVXOUlE?=
 =?utf-8?B?WDF0SDRWZVZUdXZmK1pPMTlFdStxS0h6SVhwMzhNTjN2cWNPeXRKUnhiZG9V?=
 =?utf-8?B?eTNyMVJJak1xRTBLNVBMTGZjblRWdEdxYTRNV1owZ0Z2YTFsZlRtYitCODhH?=
 =?utf-8?B?UnVNaWV6Q1VSc0hQUlVabDdnWUYwYzdxU3BrcVZYUzRFTWlzVEw1TFNOcVlz?=
 =?utf-8?B?endkNUxHVERRdTJaYURwM1pUUzROOG9wVndHSjVBdXdjS1RXSWFBdnE5SDJn?=
 =?utf-8?B?UXpYTUdrbUU1L09YWWlPRkF2V3lDa2p6YTdJK2tBaHU1cml4QXVhb044SzFU?=
 =?utf-8?B?djJYUUQ1QUJIeTRUR1cvTTlGQkdTaG42WFFuVG8xaFlqQVM3V0MyYWUzMUF0?=
 =?utf-8?B?dW54aXR1MEp3K2MzQ3ZEWFZQZ2tSZUQ2Z3ZxcG1WVStkOENUYWt3Y1hleDRV?=
 =?utf-8?B?UERXcUFUQUF6WVVCRUN5UFVCU3RlQ0lrYStINHFySGxJYU4zcVh6K2FtTUN6?=
 =?utf-8?B?NFpYTDdsT0hiOTJXZng3WG93d2pBNHBGaWhpNlFudCtzZ1Q5WmxjcTczbzFW?=
 =?utf-8?B?YU9ISUhIaU5Pamx6NVZBQ2NvUk9NUzRZMnBVcHpYL0hPQTduNEVoTXJqWjIv?=
 =?utf-8?B?MmMzNDljZktvRTdzREoxekZHQ1BveHlyd0xEVjZycUpkK096cEU5N1lGamNq?=
 =?utf-8?B?dTdMWTVCR042akdGK0c4TFNvR0dXY1dkSDVUa3llZXZ0QmtaaG1KYXBtZnN1?=
 =?utf-8?B?SENPK1JkNWRxZTBVTVNvL1ZhMlY3ZVV0cDhrU3VEL01aaEQ0dVZ3eWZlNG1i?=
 =?utf-8?B?bnppTDZDWndHREtoZVNhcVRDWGdLeW1WVXBKVGgvVkVML2tmTXhMN0xyZlE2?=
 =?utf-8?B?cDBKSEF6UE9wYnYrTmdqODBsNUhiNExKZyttZTAzdnBmaGJxMUJSOW9nRjl5?=
 =?utf-8?B?YVdZZHkzNTlWNGluVWpLWktRUjZJa0JhVVEvUVNLZWRpYjAzamFjM3kvWGlY?=
 =?utf-8?B?dzVBeTExSVZpWHh4WFgwb1hzeEZBK3g5UTA2R1UwM3NSUTRERVVIUzREcU50?=
 =?utf-8?B?QllkWDZXUnRDMGRpNHJ4OFNDOGxGeitXTTcrM2pXV3VGWXkvcmhtVG9ZdENY?=
 =?utf-8?B?QnR2V3NuSjhRcHZkb2NKdnNETm54RkthMDFmbFV2TVhRdXlVMmhQUUIwZlFQ?=
 =?utf-8?B?Y05LWmRBSWJTWmhCQ0pVQzZCWWtCMGVQdUtPZVRWOWxWNHQ3cnpvdVhQQ0FW?=
 =?utf-8?B?Rm1VSUFKdEpRNkdwemZNcWtTdlBqQk1uOVRDTGZmL1RCVVBtWW1lTFZNb2R2?=
 =?utf-8?B?azN5N25PT2hkTEEzSXBsL2lpcWRTc0pPcE14RWIvQ1pNWkcyTFJqVXNDQmt0?=
 =?utf-8?B?cVNPRHJJTjUyNlFHNzNmdzYzWGJrM0VYTElFWk45d2hCRkRURDk5am9iSVh2?=
 =?utf-8?B?eDUyNkZMbXlZVEFYVXR0bWNldDNLSGFWK05vZWc4RDAvMkQvdGhlYzVuakx1?=
 =?utf-8?Q?EnpSlJqRvZzNPNUoTz4nsPWL7K1abQ63ROYKH/m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2ZMN2tkeVM0Z2dCSkZWVWJtTzVXVWdBTTJSRzJwWCt4S1FabGtaQmhUdjkv?=
 =?utf-8?B?NW44WEJBTFpDanBNeXZXei9JVkVDK1VuNXR3ZzJyYWJDeEdXUDQwbWJ3ZlFi?=
 =?utf-8?B?QUY4YThDVTdoSjZ5QWJBS1k3M3JFbHludjlUMlo5aHRMZHgzR0g2RzBvaTk1?=
 =?utf-8?B?N1dqei9Ha2Q5T2V5NVBjTDNOMnNld0RlTXlSL2tjcmNCSHpIaC9PUmNFSnkr?=
 =?utf-8?B?YkVzY1lUbVYrc2JRUS9nTE5FTVlXMy9xNmNqNmFoRkRUdEpoc0UvMGVDWlRt?=
 =?utf-8?B?azFwZGJhbXhueFoxRFpVZTFYUWU3SjZNY1BDV21CYnVVd2lqN1daL1NGdmJ2?=
 =?utf-8?B?YVIrbXNBUjJVYTM1QVozSFp0T1Z3b2F1QWhxSTBGZnpiYVBzcXNha2Q3Qkly?=
 =?utf-8?B?T25ReWVMcUdSUHpoQVpWUGkwZGNCdUFiUHAyazJDdzQralhZMnZQUytMWVhT?=
 =?utf-8?B?bDhlckNScnU3aGlQWEVTcFdkRTM1T0c4bWY0OFNyK3RBNnZrb292cEVWaCtp?=
 =?utf-8?B?bk45RUhyK2hsbkRsWmJaemNQczczY0diUkVoN2NqT01jK1NvcFR2NE5pRk0y?=
 =?utf-8?B?dVN1VHZONDNFRW9zd29ZRFBYV0xkR25IdzkvTlE0L3ordlBWc296Mzk0YjlJ?=
 =?utf-8?B?Q2F2QnluWlVxKzZMeVhrb09kcDljeWFqQjdEMnJuK1ljb3YxMWtiVWpwK2hr?=
 =?utf-8?B?c2RKOVQ0Q1hpSVI4c1IwMGZ3OUJ1OW4wUTZ0QzJHTzc3bC9vcVh6NjBmVW9q?=
 =?utf-8?B?RUpqSTM0U0ZIbklDTXVQYVYvLzBpcSt3d1Q1VXA3QnRySGtrN2RMQ3ptTU9Y?=
 =?utf-8?B?cXplMlpYQWk4UEdDMzRqV1pObmFOR2E3VDlQcm5tU0dUbUIrSHZjdTRrWHBH?=
 =?utf-8?B?dFZ2WHJ5TEo4b3A5WGhMMFppMEdod2pWK1E5dGpySzFzbkovZzI1Z1JPUmRv?=
 =?utf-8?B?eWhQdU1LUE83Ylg5RmVOY1NSQUVQaVpQOHBPbDhSaGNxNmtDQ3VVN1N0TmM1?=
 =?utf-8?B?RWE0ZW9oM2JFbUlzYnhCemhiMDRyOEdHVnZ6WnhYM0VtZXZ4WjdPanpmKzRv?=
 =?utf-8?B?aFpHc2I4cmVLOEZheTVtVEc3OW1hYWpWcEt0QU1veFpzYXU5QlVyVGxYdm1F?=
 =?utf-8?B?dTk0cFBVeHQ1dkszYWs1cFNraVdmNTJKSVFPWnJ3MTJDQkVDVDh1cWlXbVFm?=
 =?utf-8?B?QTdPL2ZvUE9tMHlWSEJKTmNkUkNqMW1WZ3N4R3hIaVhDd3hIN05pRHhNaXUr?=
 =?utf-8?B?OEpMcG9zWGlFMFlPNEE3MjhYdktoeVpBcHNBZnlqT01sdFlnNk1YdkV3cmRL?=
 =?utf-8?B?aStDN0o0YlZ2Mi9xUmJBd0U2TE55Nnhrclc0SFhJMnYzaEkwbGNmei9IMEt2?=
 =?utf-8?B?aVNOVk5uNkJsVjByZXJCSDNBYTZacE1OaWpPMGRsaEM2eE4vYWl6ZE9xQWhR?=
 =?utf-8?B?ZUQrT2NwWnpoK2daMmphN0gzd1U2ZzNiY1EydEJmS3Q1TVFBOXdJNWxNZG5y?=
 =?utf-8?B?SklXbldmVzE0NHVxdkFBQ1AyODZoWWFJZ1l2T1FqL3FETWliZFUvTy8rUkhx?=
 =?utf-8?B?UUthdHNmQTJZYU9wVnhvbVgwdlJrSjlqTkVDaDMwanE2Vng2ekNyYm9IKzQr?=
 =?utf-8?B?c3A3ZjFwL1FER0JROFFBUklEVEE0Z2JrVithdUIwNFYvOXFzTUc2MnEwSkxm?=
 =?utf-8?B?Zlk1QVNQMGJCbUhlajAyZlpzbDMvcGxERjQxeCtUSERaSi9HTFNuQUhyaU43?=
 =?utf-8?B?MFI5TkdOeVdXVm8xb1BrN09GdXU5dFR5cVA4ZkRycDEvMk9DT21hSUM2anJ2?=
 =?utf-8?B?TEtQZHFtc3FZdloyTjZyam1vb1FEWWFtQ3dpelc5VVJ6b1FUZFB1azNzUWxQ?=
 =?utf-8?B?aFl1b1ZpZlA3a283U2dNUGhoK3RiY1luQ3IveThGWEJ3WXJXRVhGYVUvcUxz?=
 =?utf-8?B?UkFPOHM5R0tGdmU5c3ZCbW4yR2VyWlBMY1FGVGlPQ3pwVDFrZFFTNXFkL2Ns?=
 =?utf-8?B?eGs2Vy9abWk5eXBIK09jOHQwd0ZjQTRjSnVUMTBucjgySjJYWUh2dzR4ODdH?=
 =?utf-8?B?cERZZGpva21iZGszenJ3dWZVdTE2aWNqMnhoRStCL2xUbFlOMFNwQ0dSRWJk?=
 =?utf-8?B?N250M0ZGekp2c1ZiajhyQ1I5ZmtGNXBBTEh3TnVSRUZTbHdsVUNiNDJJd3FM?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 80XrfQmaMalkULubPpQK966Wgndtou3bJqo9sgbPd/w2PdWBKs5SPtPhcw3v/xopL0uL/bieeM2twKv40imjhDN5IWepbtRVtkB3yo91a9a65z1Sl1jvanWxj7lMC4i8EDKW3/v+2603cF0wMbIHJVhXEX50I8SC2fsAc35mP8TPGoW+4mj9jzs/PbRc+CV9PPxLclyk+L4mswUQoZJJeSMv1TrmLnY4rf22dEKgvgrfQW6HHKhmCl9QJ2HGqqBS674/V9oG7Seq0WOue/t0ufOdSbbS8/LlZM2mCu6oMva0fluOl8a7vPYWzUlxHcl/RIckBqUbNv6h4vVR2RNKck0AXqK8An4HP3B06xeSSG6v7w1XhlfQHT2DqmC+S4VzlnLttCcxQzCkbOfoCdf6qo/RSCguOb58VEWwWA+BXv19pHpsoQEX60m60yaJR3oOi2umaMaupqp8VJDKuVxc6gfaKkIPQUl+8N+7xD0ytXUwjdrxY+v/CaXHOxxaG4qOTatoj6I3yDZfi+UGwLIhdPm2EFiKk4hBKhT++crdmUrDXFOG8VuRRclTOM+PI/JfnlKFUnxKsFXsHZyeXL323m448wd0OH62X7aM18ZeyR0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a5742a-3d1e-45d5-12ec-08dcf520e48f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 18:14:40.3096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUY1Z9Xsn0LjbqicLxw61sm4/LS8UP0UFqReVOW6VYK0dRFeHib+/EMKhXWwFE8J9Oep2GiUhRvakn+ZHm9I8FBfgswcs0XjPGkUhNmwMKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250139
X-Proofpoint-ORIG-GUID: futrdL7HRjleiuhR1ECfUtPhIDDMjwgB
X-Proofpoint-GUID: futrdL7HRjleiuhR1ECfUtPhIDDMjwgB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/25/2024 11:47 AM, Peter Xu wrote:
> On Fri, Oct 25, 2024 at 11:01:27AM -0400, Steven Sistare wrote:
>> Hi Peter, are you OK if we proceed with cpr-transfer as is, without the
>> precreate phase?  Here are the problems that motivated it:
>>
>> * migration test wants to enable migration events on the dest.
>>    fix: enable on dest qemu using -global.  only for the test.
> 
> If it's to be documented that cpr-transfer allows no migration parameter /
> cap setup, then the test case should follow, IMHO, rather than enabling
> anything from cmdline.
> 
> I hope that's trivial if we can have MigrateCommon.disable_events, for
> example, then only cpr selects it.

Enabling and waiting for events makes the test more robust, and means
the same recipe test_precopy_common() can be used for cpr and migration.
All good things I think, so I would prefer to use -global to enable
events, if you do not object.  With a comment saying "do not do this
outside of the tests".

>> * migration test needs to fetch the dynamically assigned migration
>>      listen port number
>>    Fix: require unix domain socket for cpr-transfer, or a fixed port
>>    number. Document it.
> 
> Fixed port is probably not a good idea.. requires unix sockets looks fine.

Daniel mentioned that libvirt chooses and uses a fixed port.

> But then again the whole point previously having -cpr-uri together with
> -incoming (IIRC, from your previous email) is to have that flexibility to
> use non-unix too.  Now I am not sure whether it is still needed to be
> separate just that you'll still need to rely on SIGHUP just because
> precreate is gone.

My "fix" goes too far.  It should restrict minimally:
   "Disallow dynamic tcp port for cpr transfer"

>> * migration test hangs connecting to the qtest socket.
>>    fix: in the qtest code, defer connection.
> 
> Not sure how much change here, hopefully still manageable.

I already coded that before going on the precreate tangent.
Not a huge change.

- Steve

>  From use case POV shouldn't be a huge issue, if we don't use -qtest in
> production anyway.
> 
>>
>> Document that one cannot set migration caps or params on the dest
>> for cpr-transfer.
> 
> This also needs to be reviewed by Dan, on impact of Libvirt initiating the
> dest QEMU instance with QMP all dead before a "migrate" on src.  I'm not
> sure whether Libvirt will also do early setup like what our qtest does to
> enable events and so on, assuming QMP available since the start.
> 
>>
>> Document that for -incoming defer, mgmt must send the migrate command
>> to the src first (so dest reads cpr state and progresses to start the
>> monitor), then send the hotplug monitor commands to the dest.
>>
>> Daniel, are you OK with that last bit?
>>
>> - Steve
>>
> 



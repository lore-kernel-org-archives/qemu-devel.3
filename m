Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81418C87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uixM8-0008MM-Jj; Mon, 04 Aug 2025 11:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uivuu-0000sy-DQ
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:11:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uivur-0006nO-J8
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 10:11:56 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6WG4026241;
 Mon, 4 Aug 2025 14:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Bs3V/W2keKvgbDrndmIrRKi/hIXrsAjbIX38SWu9ccI=; b=
 eh7MM3JJqkNzfjl+0iwAC9ogg0Dd+ExrPEIhWRrZzEPnI9KPlJPBoxMoFJGRbQTs
 NeOOtVmihWvmFGSvsOkFWLE3AMctemzW7wvgp5Tvep6wwHKZ7csec0MB2vwfXqsR
 wbgObZePwsDEI40Z3SHL8LfPB5+MHb+3/wU8PYnShY9ojFyPLbNfAnUK/jK46+0x
 w+U6HIajl7nvm3wU7IAebsVoKwhZXPpSzVuv6GyyTXsbjdacg+n0iZd68PEfPSLQ
 Ps8zmJqcFPIfN3Gzpub/n6/RRAHqOIJGlzS1jbl2VXfw7W20yDD+Q3BBCmDAhmPc
 3uQrUxvgA0qNTOW7nkkqpA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vtn4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 14:11:48 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 574D2ieE031844; Mon, 4 Aug 2025 14:11:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48a7juntvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 14:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhMR4r33wg1qOJPi1TIiDE0Yl06vnWFplwO3lnNfS9xewd1FY9n748oKKibWlwtvqb/+koSV69IDLMBAqs8mgmv4T5VBiG6HziOeHxM71KBA1hWoQwPY5dLcyIqc9Cvun895U64jfDD/kqSkdPYe6ZSJ9JACmtLMBpUqZjoPvIAltmSakF9jz1uD4lDpPKPGYeq3c4HS4bXCG5L0ci2rZi9vxwTbu5fPi9/YNzED/JYMyGxfNLIABSFFdIMw6tyDaqJS83NdiWruy5quDpYpgGHwNtG0dp70/pgRPV/fA/SSNUyQAPYG/x2QebQFlCur5XcOwUljJVQeZlz0NLMRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs3V/W2keKvgbDrndmIrRKi/hIXrsAjbIX38SWu9ccI=;
 b=RWF1tdFbBWoYU8ZgfKgfYH/YTzEwruNp8gmSbmOAmRLXjgNVJrX7pL26DBi0ebddW6CBfiOC5L824uXuUKhNd1ZH9KaI7Lj3M9cXFMADv22v7ZDfGj0fkfawxDczt1cicS7EPyQBAUzY+7kmHUp4OTpKgDLC+IYh5/ofblCmoqeNge4Ay0FQcbhnux2cd6/j4ssFITgfNflSju9xVkapHqkAKaXkpZPVmDTZbhu3viq4t07qhApGBesHAxUbBuCXxZFpHbS9wuJ4sfVbGiawx2X02yZ4jRPcH7jUZPUnvz1T2SalWwUEpxKcLsGh/p+NTtzsxdUdDUxRaboVaGDNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs3V/W2keKvgbDrndmIrRKi/hIXrsAjbIX38SWu9ccI=;
 b=vJuaxjiNgnfW2ZQFf+OqPSLv6rpH5K9x2F/s/RvkH58vbLS/mnKvogrU8cz5jgwFRm0JUYAEyzDCd67vnriCyGz+v/FdD7gnsnQHCHPo7uuy9w8yvPhFmf82WBncz5Cu1/3onnkQUCwlai3zOmL0/14vTO1qaUWKRVxrZFvPJHM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA4PR10MB8732.namprd10.prod.outlook.com (2603:10b6:208:565::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 14:11:44 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 14:11:43 +0000
Message-ID: <e822b87b-d8cd-440d-b398-d20759f07f31@oracle.com>
Date: Mon, 4 Aug 2025 10:11:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1752689169-233452-1-git-send-email-steven.sistare@oracle.com>
 <1752689169-233452-3-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB91361BAC8208FB1B7C929E9C9251A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <1713856e-232d-4d15-b13b-23c2bcdb3c34@oracle.com>
 <IA3PR11MB9136C681984E6880B270CC04925DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136C681984E6880B270CC04925DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA4PR10MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a86f491-1e97-44de-5d20-08ddd360d707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU0wSGI4ZDYvOWRpZjFuOVV4RThRTWlhSm14Q01raHNqT0FqdzBtVkFxT0VV?=
 =?utf-8?B?bkc3S3gyOWk4NlRiMCtici9ySDRGWUgxdklGeDNhSXAyRkVpcHZrZ1NiMTdT?=
 =?utf-8?B?SUgybG1JdEw3a29HT2NrLzZhbGxZNUYvalppakg2RDl1dXR6T3BpOGFJbWFW?=
 =?utf-8?B?NUxsRWF0ODRlb1ZkNkNrNXBJeWMwY29tRDJpNGVIVU9taVNVSU52SFF4RHVI?=
 =?utf-8?B?WW1nYTN6Q0toK1pKVzNvVmpGOFBhZkFiV0krWEFLWUcxRTVnUkJiM3NzVzFi?=
 =?utf-8?B?NUpCSSt0QkdhKzg4aUxjRFlKWU00ZmFrM214RU5JbTVQa05NVkhTaS9UZzN6?=
 =?utf-8?B?YjJKWDhBTGJxODMwc0Z4VkxTWjR6dzZHQkFJanFLWm1rWkJNNk9ETTZyNHFn?=
 =?utf-8?B?NTJxbkVsY2libC9YNHU4OWpjc3ZTRjJYK2Y4WkJ2OG11ZWtJaEozMkxlSHJT?=
 =?utf-8?B?dERXcW54YUdFd0NLV2dwWTZyOG9HYkhGcUtWbXVXcE1iWWw5eldkRnNIVmR6?=
 =?utf-8?B?VlFKN2RETUJzVGQvT204L1dlN0JNRzNTZFRqaEg5azY4ZzZERnhjUW5ZbE9W?=
 =?utf-8?B?V1gvRUVLdmpibFRrVXUxYi9jcXZSNXEwK2dKK1hkc3hkd0ZSK2VDbFFjOWFX?=
 =?utf-8?B?bnVWcDRPZ0JrRUhRcTA2eWx1NHBaV2xqWXd6VUFMam53SHVyUlpUcklaT3Iv?=
 =?utf-8?B?cVliZkdPM21OWitycTVJZUtGcUgvQzdNODREeFJlMFlpSEdsTW9TOStLNXVs?=
 =?utf-8?B?Q0xwSFB4cm9ibFZkYW82dTVtbnlBQS9xc2t2MHErOGRHZXBibFlvTGlNUTRz?=
 =?utf-8?B?ZVpvclA1azRtZnI2WGFDTkg0SWxvNGQ1RU8yazZKWG1YT2Jxd01NazZZOWg0?=
 =?utf-8?B?bzBlZmFGUUF5UUpOalJkaTdyK1BYNGhOMjBIRk9WVzB3cVI3a0VFZEk2WFlJ?=
 =?utf-8?B?UjJKb2pYRTVQWm5jSDcvRGh0ZUZ0OUFFaFYvaGsxYWNXRS8wNFdybnliUWw3?=
 =?utf-8?B?YlUvWG11cFJBcHZVNnRadS9NSmlGSGRoa09xSWlzV3NtWFlJU3RLajhpeFVa?=
 =?utf-8?B?VE9OaWdpQzNQeFpLVGdQZkd5b1ZSUHZtanNoRTFLbFEvd0RzMnBLcmxBSVhI?=
 =?utf-8?B?RkxlZVFvZDRKeFdhTUlOanZ1d0Vmd0xSWngxK1pKeThwWVlwT0dPeC9lN0tI?=
 =?utf-8?B?NXRzS3lMbUhINkg5cVVrL2d2OGRjTEFWRlY0UEZmbmV1anBoZmZ2SHJ0VWp1?=
 =?utf-8?B?RjVGdlpEUWpRWFNCT0RmNlMrVncvM2M4S1ByME1ieVhOYi9kVWFjbE92bzFx?=
 =?utf-8?B?U09qYzJDcVlQeDZTM241dnYxa0dIWHJTb0Y1bjNKai9LSG1iN1F6YTlDejND?=
 =?utf-8?B?WG5yWXpZalUxQXZSa2tnN0Ftcmh2YUxacnFaNHlPamlxcy9xeXhvTUdLNmRK?=
 =?utf-8?B?ZGtDc3NEL1pDR2x4L3E1YTFVOUF6MWZQUlBEUFZCNmt6QkhkK1drWVR2akdv?=
 =?utf-8?B?RXdPZHBZTm9KeUsraHZ0WGRNdE1wN0RHRkwycTEzTXdNaldveGU3OFRxY3Ir?=
 =?utf-8?B?RGlJa09rUnJiaEkwN2pGWm13bFV5ZEtPWWFFQUFFU01hMUlJNUNXWHlacGpw?=
 =?utf-8?B?TW55U3NJdU5Za3hNU0ZxK1lZVGZ0ams4Q0dTVGIyTG8yQ2dTZHBtR1BZWFdi?=
 =?utf-8?B?VGpDakxmdFIrdEg4Vm5xRnN6QlZnSmhvQk8xcFJ2Zmp0eW9mZnA4UHlDNGxF?=
 =?utf-8?B?MzZJbEI0L29WTWVDSnErbE43c0JVT1lGWWtXMGlva0w1N0l6VjJrN0NiUWtr?=
 =?utf-8?B?OVZQREVOb0hYaDBrbGYycWM0ZUR3V0VxNlhqUDZRZVZRWldMdXRVSmlXZU1r?=
 =?utf-8?B?d2trbEVjRWNBZUM1K000Z0tuQUtwd1ROSzBhNWJRSmpsSTMwM2wvZEJMVUhr?=
 =?utf-8?Q?u+uwgXarrb8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkEweTg2TU5TK054OVNDN0lsdEp2c0VMM2k5SjdVT0FnU0JTcGVKQVJGbTd3?=
 =?utf-8?B?bTlabHl6QTFKQm90UGJ5VURUdVlhZ0w5RkVmWXZEZkE1WjZVNHA4SW5adDQv?=
 =?utf-8?B?bXdPek0zaFU3K2E2NEZPc1dzZHNZV25uQWlYbWRXYlNiNmR1ZkhKUTIweUhW?=
 =?utf-8?B?VjNGY0crbGZQMVh4RW9QWjJtY2gwRVVZRXk0dUZnTWcxTS8xbm9QVjFWeVlT?=
 =?utf-8?B?TkxkN0N3aUVGUVUrNTc1SCtYWE5acXpseWx4TTMrWXQ3ZUdqVk91M21Idm5J?=
 =?utf-8?B?a1hlRkZQMmhiaVdLYVoxTGE1RTNnc3haOXV1bERBdWxTZ1drM2MxU2c3WVRJ?=
 =?utf-8?B?RzdqbjZLUVFIbTZJSDhvVXBxQWp2VEdSSzlPWnVLU3RIREZrZzJiNEVkWU9M?=
 =?utf-8?B?bHNpSkVsOWpSL2w4T3F3dCsxUUVtaVcwZDlydFVaUXhZbzUzd3pxSit0VUI5?=
 =?utf-8?B?czlYWGZSbEUwWUdGSHJZb1dQSmhOME5sTHJ0T3VucXgzODlkWm9wc3VINnlF?=
 =?utf-8?B?Ung0aXNheDBhdlNjdGpicWVVMEcwcU9nUklkQUpjTXk4NEYzdXRGdmVlK2hG?=
 =?utf-8?B?S2dxUk9ZWm1YdFM4M2JwNTVwUHoyeG55NG54TXZYRnE4RzNvUWdTSExEWlJK?=
 =?utf-8?B?SlhyajFNM1VnWTVwQnFLRURXZjhHTG9FcVlNcFJzbmxhRVl5UUpPMzNoUWZ6?=
 =?utf-8?B?eFFuTFZqMGRBY1NMR1hYdHMyWVFSQmh1RUJXVG9QRkFGWTkwMzI5Q0dCTWdG?=
 =?utf-8?B?VTJLMlk5Tm14OEZDVmhReEtWd3p0UkhBNERQMnRqU3RQM1c2dFlPdHlxMDJJ?=
 =?utf-8?B?MDByYVJLS0V6V24yM2dzZVhEM0haVS8vNzczSEVab2YyK0dydGxNeThIbGJy?=
 =?utf-8?B?TlpoenFVY1dyRklyaW1ZelREcHc1ZDdpV3MvS3Nuc2JUQWFyVTFoclpKM3Vp?=
 =?utf-8?B?RHlOSEk5KzYvT2ZMZWlwWmNuWXBFT29YY3BnWnU0YTlyT09qL0tvalNNanUz?=
 =?utf-8?B?dExBU2Vrd09zbGJFOTlzYlFUamFBZm9hN2l5RTgyUmhVQXY4blhiK201T0lJ?=
 =?utf-8?B?U2FCUE1yU1BIam13QWVjNTNmS0ovTmpDV2pXbTFWc3RneFdjUDBGWktYeVhB?=
 =?utf-8?B?YmIvSGxZNEcxUjAraDZhTEtKQ01QYlRCcW9vRGRXVVlHSGd3dU51cDdTMXgz?=
 =?utf-8?B?REVrMmFaUjhNcFdrSGtOMXdPQlk5RUdVWDJVY0RTZnM2dTRVaE9KSldUb3B5?=
 =?utf-8?B?UXVDQUNaK2tSWHNlTktyU0RtL05LemZidGpQcHJIUkJUWlE5SlpIRVRWalRj?=
 =?utf-8?B?cUovd1N2OTdTZW96QnYwQU5CM0lRZ2s2aEtVNXAvaklYYXBaYkhVZitXcDc5?=
 =?utf-8?B?VFBYalI1b3N2VDdUeWkrZ2I2MmxQMlBONmRMSVpaV1I4WlhmVG5VTXNFUVNL?=
 =?utf-8?B?Q0MrQmFhM2FzK3gvaERqaUxub0MwU3FFdG1DTjBXM0J6cVVWM0tKZHJ0TWZ6?=
 =?utf-8?B?SWdsNWc0Z0hxYXZNOFpEdng4ZUxocnNYTFhqTm0vSnhndVM0MkZwWWhXd3pQ?=
 =?utf-8?B?YlErTUFkbERXNnlCRnNxTk1SSWJxWnl1SXFxa3dkSWxlUFBXbWFYZDluTFY4?=
 =?utf-8?B?OXJvR0pzNDRZRm5xamVnWHM1L3haeVk3VTU2ZVFPeTd0MFQ0Z0ZDZmhWMDBE?=
 =?utf-8?B?ZEhNdDBHakZpWkhtRm5xZkZESk1RUU5rOHYydkFXSTBlVnVoei9iZm1NdzBI?=
 =?utf-8?B?Vm11MlFZOFZIVEVDZ2V0T2h5Wnd6MmFxUXo3RStOQmQ3RXljbnVsTkx4RnVW?=
 =?utf-8?B?SUlhZlhiOCs5UGZ6NXlneDJybTc5K1hXTzhrQ01YSzJwRGdnSEwzajBVWm9C?=
 =?utf-8?B?c2ZnVC9yVzV1NkNJRjNENnJlVlczc1BWNGt0YjIyZXp3VGlWbTFkYlVTRUR6?=
 =?utf-8?B?SnoyaEdHYXVaMnVHQSt3bVFkUGRzMVJUVFdyYzdUbDE0T3I1Z2Nqd3lsemUr?=
 =?utf-8?B?cjdnRitzd2ZsUjZSSmtNTGtIR3BRUEJtWlhrQWh2U1gzK3hYRFZXaDVadVVK?=
 =?utf-8?B?V0lyQzY5RU9kQ0VpWnNrRXEweTlHYllHbXFpRXVtY1JPbFVzaSs2b3BhaHNK?=
 =?utf-8?B?eW10NUdmZmZMemNMallwMHpVU3REbXpkSC95K013OWJNUkdpRzkxK1JHL0Ro?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Pm47BKSYgcDlrcWTDxCPmiySCie5Tj+i+SynbbUVjLvNQ1xpTxcwOuHSKqE86UMX0spetINRqclgI9ut8myQNgwZLrLyqpOveYKHrkXPnA6otZsffOn80S048SVDCzqohl7yztYBMQmHmUK0Yq8WjKZynFF65DJezWPjKFJQS4Dr+AN2XMUgKowH23Xzllaq782T04jUUZxKsqrI6t+ktHZCX+tvMvCHaR2udIl4sIHUFjcsAIt8m0ouhix/6IxR5GvAibIN/90ZwdYavIV5PiKBDUKVP25iAolDfYFnRbYGwIk33L3DtdFIy8V0W4E52VepiYXnD2/P48Tysjxvq42o9NzP+tudjVTWTjI48rJD/g/D5PVfEg4i7kmb3PdGfneF/vGdrbOt+OQdF2mkg6x4bPLgziTVwEwGq/HwXfqjHn6x4VNqbmnskvl3ynl1mGOhppZEtrFps5po4o+1rw8xDv9R/tr8B9V3BT+1BGr47M4+NCqrBAOfzR5r3RRZ4+XgzBDz7Js+pvyHrWlfm/X5H1J0/2W6haql32XEQ5+QSKx8BkQG0S9yBakI75ciDBCTjbufatgTkdMRdTU21cy35qovZQigYFxD0cNjlXk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a86f491-1e97-44de-5d20-08ddd360d707
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:11:43.5941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iX+L7QKR2mB+zUVpxlt4NH3kfotbKGLbTWgk/niGmHrnfJiQGv3KtaDKi5hBjyF2Fiwt00cHNAvpE8Sn7i/XktU819q9340HK/Max3i/Q04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040078
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA3OCBTYWx0ZWRfXwe/KzU6W3AMv
 FXgKrF8yIXP3p4Y3Gw6Wk2HrIRbiOsNGiEOk99Rc9gLUZ+9HL8VKNMQSci5DCUJOUYytJfAX7Ar
 Fig8e3DLP3jO3bs7jBunjAMf/0mpDJctzjvMhvdWdJhT0tYyUNGcXmT6qxLEjsQZu9ip41TYItX
 eye8pzyZhuRDoltxJNUu1I7QW+R0w1/ptaWoPZYtZ5Wl2gUjG6UXCkloqSsWf/lZ1NHwilBkSI2
 nGYHPFPT3/ivwpAe0SbsBsI2inbFFvaChbmbtjEFeVEHmW1o1jzdIFMCtyOVDBTnJx/XCL7YIch
 SH6YD+ELZWWwmAn/0/2UVC62xT9koY0fEcWi3fDJbjgXK5jaVHk1CgT4Z+dgZ78Zu1M8IWQ/bpJ
 LQvrK/MfvIg5qizmYaQrlZWDtKEePlZjdyMZpAY6Rmg8BNGNKxlAjBn5XXJdY2yBtJQlV6ov
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=6890bfa4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ai0ZVXUWJqWryCYoUL0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2jhIy7sdj6hXNQ5l7aydXKhOQdMjxQxY
X-Proofpoint-ORIG-GUID: 2jhIy7sdj6hXNQ5l7aydXKhOQdMjxQxY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/21/2025 7:18 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
>>
>> On 7/16/2025 10:43 PM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V2 2/2] vfio/pci: preserve pending interrupts
>>>>
>>>> cpr-transfer may lose a VFIO interrupt because the KVM instance is
>>>> destroyed and recreated.  If an interrupt arrives in the middle, it is
>>>> dropped.  To fix, stop pending new interrupts during cpr save, and pick
>>>> up the pieces.  In more detail:
>>>>
>>>> Stop the VCPUs. Call kvm_irqchip_remove_irqfd_notifier_gsi -->
>> KVM_IRQFD
>>>> to
>>>> deassign the irqfd gsi that routes interrupts directly to the VCPU and KVM.
>>>> After this call, interrupts fall back to the kernel vfio_msihandler, which
>>>> writes to QEMU's kvm_interrupt eventfd.  CPR already preserves that
>>>> eventfd.  When the route is re-established in new QEMU, the kernel tests
>>>> the eventfd and injects an interrupt to KVM if necessary.
>>>
>>> With this patch, producer is detached from the kvm consumer, do we still
>> need to close kvm fd on source QEMU?
>>
>> Good observation!  I tested with this patch, without the kvm close patch,
>> and indeed it works.
> 
> Thanks for confirming.
> 
>> However, I would like to keep the kvm close patch, because it has another
>> benefit:
>> it makes cpr-exec mode faster.  In that mode, old QEMU directly exec's new
>> QEMU,
>> and it is faster because the kernel exec code does not have to traverse and
>> examine
>> kvm page mappings.  That cost is linear with address space size.  I use
>> cpr-exec
>> mode at Oracle, and I plan to submit it for consideration in QEMU 10.2.
> 
> Sure, but I'd like to get clear on the reason.
> What kvm page do you mean, guest memory pages?

KVM has a slots data structure that it uses to track guest memory pages.
During exec, slots is cleared page-by-page in the path
   copy_page_range -> mmu_notifier_invalidate_range_start -> kvm_mmu_notifier_invalidate_range_start

> When exec, old kvm_fd is closed with close_no_exec implicitly, I don't understand
> why faster if kvm_fd is closed explicitly.

The kernel closes close-on-exec fd's after copy_page_range, after the mmu notifier
has done all the per-page work.

- Steve


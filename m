Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032AAC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2o9-0000l2-AP; Mon, 19 May 2025 11:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2o7-0000ea-4j
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:53:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2o4-0000ZU-SK
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:53:38 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JEOH01001157;
 Mon, 19 May 2025 15:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Nc/2mbMcXj3zKXmnl15WkhBG/p8KdGyN/7+OWkmODiQ=; b=
 cwjcYBj2VL1wfUJHhb/hKSjN0OMGqoLgJ8d2+b4gA+e9oErKNzqAeO5WjS9yi4lR
 oFegoAjwPUZkQSFwHrYVkLaus7uBGksJFWRjoKyzLjmxzb0tdw/0Qjodx6uhXF89
 G07Xl4lGwTtKVOjkVlJ5YkxZW9dnTxWNe6fTEkTAEdcvJBRZ/A4E3KHvgeEnrl46
 EUBhT+EeyEHkdaOsU96kke8U3Dlr0GmIzA26GuzJe5IZbM8gJ5YRdIgh5w/ipzGi
 IsQQ1zP2O9IXWLvD0ZdjHR73UoK6XShVIHqH8C291sGOCbIIH7n60XT9VA9bv1Cc
 fIfPMhm7ohuHioPlRYKtSg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjbcuase-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:53:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JF4xWq017447; Mon, 19 May 2025 15:53:32 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw74dux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:53:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xka5qIYtXMFL2+DTfE5QvMyb/Q+mGgDPSZUAE463R2W9i/mRk7Vfm5QQvgFrv13Bo8TM4RmQlda4igNy8JOPFw9jJxun+B+SpqESRriMZgnEj8Xw6FbCEuNQSjZUe+LSwxId592RXDQaALuzy038iK3nQzLXdL5RV/VKhO2Qqor+HIAMBNPz82EJOPbe022WBtSLsi3x1vtjNaMulMaf4t/VA44jmwfUR6djcW2aC8swsNtCjFO1qQ55VMoBsSxOIh+czD5dzbSl55eRAbGxiGC5WB2/BUFVk51QtiVPlqZXakm88j6S3sW/nAHyoUkmj+QNxtOkhJvcECASn7xBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc/2mbMcXj3zKXmnl15WkhBG/p8KdGyN/7+OWkmODiQ=;
 b=ssZnVjVRZQLwJ5DAGsCMecKTX2TD40s05YhlvqlNwjLd5ILhWeVuFl2EAuXGmlmWO0bSGnshLsRtpkYw/CtV20o0HIYbwRh/LcQna8G4Ujko0k1A/Imlvgj6V/VDMgvQHS1Q9tMMSouzoqxbJVXGV6z6JU2hkp+JMPLeEYTdGPICvATT4FmHIME1cd3WZ1ltBGkJml+dQEuw7bVEWFU4h7PS8NwrNtK10dVtBb+UG9AOmZIVMsTX3G072XfcQW0aQHBOYyNKT/MiwWGDFeA0FBkteb2a/IYQTTtig7clJj+PxFmokELDzxUEF7m6781NuKZ3JZAjIPRL9bbB8shJ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc/2mbMcXj3zKXmnl15WkhBG/p8KdGyN/7+OWkmODiQ=;
 b=crbrC7xgMrfXYkuw99pNIDOi7HROq54+iV4hEi0zW9kQ3ToRHSTiCNBTiuG+vVe1wmwWZQ7ikqDvryMAKa5dGJp1uaHnFt5hs/m5aM7ADZJR+3nfe0gseWxmN1MTl8pZlM7DLzSU6BiEH1D0urw3V3cyUyfmDReLS3Nqq6PuEog=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 15:53:17 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:53:17 +0000
Message-ID: <ed11b186-1445-4f1a-8f60-fd446d9e15d3@oracle.com>
Date: Mon, 19 May 2025 11:53:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 37/42] vfio/iommufd: reconstruct device
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-38-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744AF09E9C87B1D9C919E7E9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744AF09E9C87B1D9C919E7E9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:208:239::28) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: ad618d15-1a56-4895-0cc6-08dd96ed4528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm9IUFpZMkNqeENJZFBCWDQzc28vZ2tPdWdVam1TYTlrUDdqWFBTQ0NxNFUv?=
 =?utf-8?B?NHpFVDllZ09YYmJMdDVYUEZwSUhWbTRKV1V6SFh1bDZna2hGazBXQWFEKzJr?=
 =?utf-8?B?UHh6NjJLZ2NuQlBtVFhHSEppUDIvRDRvY0k1SFJGcXNQV3hEK2MrUm5DZHlX?=
 =?utf-8?B?MXRQeDZNaGhvM3hyUE4xYk5IejhFWlRXNzFNMS9TOFNseVZJTGtiNEhWZ0x1?=
 =?utf-8?B?QnpwdlJTamljMVV2Y1NRQ05oL1NOMEZOYVFUbUNobUNhOVN4OGVkMUZjcHBG?=
 =?utf-8?B?YUtLTXpVcG1ReTY3UDh1YTJGdGR3S3VZL213S1MrZUNpWUFiTkxnTHZTMWo3?=
 =?utf-8?B?MHdrekFVV3c5MVJiUTAxMkNOWkNCdDdGaFBGWmRBUWlIU2pKOGR2NTlaNVBH?=
 =?utf-8?B?WmhWdmQ5ekphMTg3Q1hpWVBMVFZPOUw4QUFSUklhSTZ0S2tQT2xXcnNNRWtU?=
 =?utf-8?B?dEdXR0k3KzZSeFJhcGRVd0ZYZzEzaDZjM29qaVRXK2dDbW9FcWF0UVFVYTBV?=
 =?utf-8?B?cUlMY0tTY09PT1VXSyticEoyOThoR01oVUhjclh5ZDhkMXZ6eHUwWHBaMllJ?=
 =?utf-8?B?RTdLWDJPRnBHdzJKVHVidndycXBLbVIvYU9zMVo3KzZEeVV0QmczdEV6ZUx2?=
 =?utf-8?B?TFlyYTZxandiUUc5dG1VSjZsNDRsRGNET3FQK0UwdDR1cGNhVlBCeERrZE92?=
 =?utf-8?B?ditnNlByQzNZeEFyeTYvUlltcVNCNFdpNi9ycm5TZGtXUVNaMFVraGxnWHE2?=
 =?utf-8?B?ZnZNS1QrUGl2aFZRazB3VGxTYjVZZGw1MVFMNk9vc3E3UEFmZ2F4SVduWjJl?=
 =?utf-8?B?K1ZBN2ZoS1ZzcVJ6WmVlL2MyZzFkWFNjQzlpSUgxY1FmVWtubTVvNlJITXc2?=
 =?utf-8?B?TE1xV2tCNGpHWCtac0VwbjNveGpJYzY5QnFmQ0g3OWZuZ2J6RzhNRytud3Iv?=
 =?utf-8?B?WEFDRW8xeXlwRkZqb09WY0pqNktGL2hQMm1nNW9SM1RrTVpXcFAzRjF5OGRa?=
 =?utf-8?B?eTZSRGU1K0xmc21CVTVyM2NRa1JqVlJHNW95K1hRQVJ6MlpwWmZpMzU3WXBO?=
 =?utf-8?B?dTdRTGdRd1ptbmF6Q2V2UkxoQ2JpVGxISFB6S1hweHFUeUt6eVhXWDRJakNL?=
 =?utf-8?B?QXZYM08rVTM2ajBpMUE3YjdUaldsa1IrL2JYbTdJbk5UTVZQSVZRcHRPTmVm?=
 =?utf-8?B?cUYxWXVtUHFRWFB6UXZNbU9HNlArRlpqWmxhYXdEZWJrMFhZMWVBWWI2RGZO?=
 =?utf-8?B?clhnb2k0STJsWjFjL1NBd0FDdTZ1TEVSQ2FhcXF3VGtjU2t0RkFuNjNNcnR3?=
 =?utf-8?B?aWxUWElvdENGK0UvaVRRVGNvTXBUck1RMWJiZ3dUTysyUU5Xa0wvajEra2sy?=
 =?utf-8?B?OWlHKzArWldYbUs5MCt5Y3BHVzBPU0E5MEVVcG4yS3lsLzVXNlh5YlpPQWV0?=
 =?utf-8?B?WXZaMzFvWUVwWG1aNUlmRjZMdzdHK1Vhd21aN3BwTmprL1M0RVRYZTRTcCtF?=
 =?utf-8?B?eWM0aTB1MDF3WlJKOXFnVFRsWmNPblZBZU9ZeFV2SExYT1ZJMVdGK09USVM2?=
 =?utf-8?B?VllxdXVBOGNpa2ZwTkFZNHFaT2RUeURMbTFTQlJWTU9FZ0R0ZmR1bWF0UUdy?=
 =?utf-8?B?RThvRDZSbFhCc1JUL25SZFJQSS9ZSWowbnd3UUlEUDlKQVNpaUxnK0ZxWW1W?=
 =?utf-8?B?MVppUU8xKzFEaFc3R1Z2Sk0ydnlRSEkzb2lHR015TldoeWJSU2FoZGVsNVhF?=
 =?utf-8?B?NHY0ZlcraDd3ZkU4eTBSOWZIY3lNTnFzNlpQOU5UaHZEQmNxTHh1eXROL24x?=
 =?utf-8?B?NW9Ea0phRnRrQkNWM1ViWUdwaE9HajlpVlIrL0RDVXRad3VESDVzaTBTbzFL?=
 =?utf-8?B?RmhTT0FqamU4WDVaa1ZVMVJ4TllIa1pDNnZ2bFQ0S1psNU15ODZ0THpTQ1lG?=
 =?utf-8?Q?15/JVFZACzc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNTMUVtaWd3SW9kOTN0eWpTOEI4RFBFZkdaaml2ZTB1NmRNUS80TUFiUGli?=
 =?utf-8?B?djllRWhRU1huRlg0eG9MNSs1Q01YcExhMTA3WDdnWFhPUHVma0xwdE16U3hJ?=
 =?utf-8?B?R3dVektBYmRuRXV6V1FTd1BJU1BUUXBjL2FVYVdGRjE2VGtLUEUwNHNRTEMy?=
 =?utf-8?B?YUNhejk3N2lWUG5FZmo2ZFlHcW03VU1uZzRmcm9oakQzc05JV0t0RmkycWJK?=
 =?utf-8?B?YmV6RnVkUDkwQ2I1b3NxUHRmRHlyajNNbDhzVkRONFhFVTVWa2VaQ0t0YlVK?=
 =?utf-8?B?VnE4MWtpV0prcGZWZjhaU09UcW9DY1J3bnU5b3lBQ3VEOERxM1hGU01sVkNi?=
 =?utf-8?B?RGw4ZnozcjhRWjB2U05sQjNvS3ZlK0JuR3ZhTXBtcEpqSlA4R2F4bmhYeDV2?=
 =?utf-8?B?bGdkSFdSNFI5cXR0T2NuK3dWVlY2WHh4N3lQbDJYTm01ZlRpNzFFN3Jma3FG?=
 =?utf-8?B?b1QxUk1tTGhaYlVYVlJIZW02ZU5iNVhXeXorbVZEUjBmU1ZwYWVLU1ZUWmVM?=
 =?utf-8?B?a2tkK0FhbzRDalNvY2JPOFNkU2Y5cVlBTDZubEZDcVhJSFF5MjlndHFmVkMw?=
 =?utf-8?B?dWcvSU9NTFdaOEMydzZJN20wRm5OSVFVQmF4b2JNTm53T05zcmVldWJHdzIw?=
 =?utf-8?B?cS9kM2pyUkZOZHhONWQvdzZvOFU0ak9Yc3ZVTW1rQ25TU3gwUm5XVkRMaVIz?=
 =?utf-8?B?YXZJc2xPcm1jazRkTldkRmVXNVZ2QmdVYk9wVWZiK1FyQ3hNQVo4MFkxVU5E?=
 =?utf-8?B?VjZwY1BYRitmOXFZWnE0ZHNIbk9lWDZ2dldGN3FzMmZNZ2tUc0w4UTFJQXVZ?=
 =?utf-8?B?MkFXRU5HQlJQZHgzd1k0YkI3Ym9TNmU4eDZqYkl0aC9QR1ZIaTlrL2tObk1W?=
 =?utf-8?B?aDhSWlg1a1FvTTRqTm1jVk9IMVFsUHFENWEyWkVBRXVBNnArR1dKR3JUNjlD?=
 =?utf-8?B?WEVnRE5pelpaTVNqVHI2ZnQ3Nkw5RFYrbnFNUmtDVkRJbVRFRjl1eE1kVGYy?=
 =?utf-8?B?UXhsVHEzc282RGRnV0oxbjIrMmUveHdFbHRaV3ZiV1BuSnFhNFpiV2JSb1VU?=
 =?utf-8?B?Z0wyaGJOaFQzb1dLWEF0Yk04NWhIaWF5RFU0VkI0MXluNUFCMld6THZIbWpv?=
 =?utf-8?B?RUNQR2NTb2JXNis0eDkzdjR2YTUreUptM3F3bElMY2NNeXprYkVFTDlZTG9Z?=
 =?utf-8?B?SHpDTVRMVGFqZHFKUTZmNDBIQXlJcDkxK1pTNnVDUzduL3AwZERPUmhBZlY2?=
 =?utf-8?B?ak1DbU54d2VsdmE5emdoc21ocHB4NGQyV3k0bGFSZDh2YUlKTTZpZUlJcTdo?=
 =?utf-8?B?cmxWR2lKNmZCY1BaUjFOSFMxNnpMZ3ZTR1Fqb2o1UlB3d0pyaFAxRjVlSERL?=
 =?utf-8?B?enJtMmV0R1cxaVVROXBGRWEyYTNBN1gyNE9PaE1peitqNnBJT2tRNmZWWnkv?=
 =?utf-8?B?bUh5eGhZWkNvUWwwTTBnWXpIVnBlVWxHcGdzMkF1bTB0M05uN2lhNHlMWnYz?=
 =?utf-8?B?ZGkyNmJOMDBSVnMyYkNaSzJyMHFBWlRERWp4QWZZTERGekFsd3Q5UWVUUXM0?=
 =?utf-8?B?Z3Q1L0dRY3IvR2owUWpuTHFCTFRCdE5LSFlQS0pWa3E3bU8wMjVpalZSQThq?=
 =?utf-8?B?YmNzSyszVnVzNU5JMjFIbXJmU1Q3WklsSHFhRytocnpZNUdUMmJ4NndHdGla?=
 =?utf-8?B?Qm5UWDVNZlZpTjF5dlVKaG5wWjVwbGI3a0oxTjc0SUZJbkp5WmtTeWFPZ1oy?=
 =?utf-8?B?WDV4T0RRM2kyT0NHcDJ3cU1HNWszcnpLMUJuWFBSS1RVZWFMNHN3bktSZ25F?=
 =?utf-8?B?QlJFZlRLQndMVzF5dXpHRzQvd2tqWU0zUEIvQ3lZanlDWWIyeGs1bEU4b01q?=
 =?utf-8?B?SytEZFBtUVNOVXlYZ3ZjK3d2c0ptSTVCLy95eVlYTzBuakthdkNxTmlyQzZh?=
 =?utf-8?B?WGtQdTJIWlkyVzUrRWFNYWVRc1RoWHl2d1ZPY1k3TU8zU29Rc0tTYXhrNFRY?=
 =?utf-8?B?QWRpVXRQSnRIUjQ1MSsxQ0F0VVpHak1TM0NvUUhTZVoxVXpEK3ErMEp5Tmxj?=
 =?utf-8?B?ZUEvVjUwZkV1SFRYY3I1OHk3cHE3Q2ZXMEt3TExSWDR1TFJVWFdjSWllcXRM?=
 =?utf-8?B?b0UvOG5HbzVHMDZVSW16Nm40azA1RWl2UkIzT0ROU1B1MFpzQlRDektoRjBY?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VMdXJBPbdu65pIDW4fAzefLMCM2Ze1kU6UXZNln0Z5+NMf/2q3eOlvMML+DVPujEkMIeU6c58sNkRfUwv26pFwnl6dcaPAFoeeIlkznqXgHoyOnRUP0NFt2DAU+wvqm0rVwTsrFuOk0kEYxTPv2nrhizBtHBrHEwQ2yJlN/QSKn6FJgbyDJR5Ba64XYUcFrGkit7Qzt/9Lo/O4vGFnBFPC5YO9GFPD9mcmBW1jhe6FA2CiktJXaloiRYpzBqIKTSRJLusXDe07rqbd36/4Hfpf+0UxJ9ybXYMwHWeRazyNTvBek5Va7quD9PcLyX6xJNqLPgnuXBbHEYkLbMaO+6xeNPPHh0EMSmf5qynrdqA8e4lhoh59NKGEEYatiV/qkqqpxPVviqQzFowl/NT8hYFid2FTq+sv1RYFo5s75mMByZMxBgJYrEU8A9Lv+R/k5OJVtTGwOesrnp2FLDZ1MKul65I47sdNc0/Pznmr3k4yyMGN1FM34c5mVIAzd/tYBD+jZSGrQlo5+5oKBPBYilkQQNEDPdWQrWmHKghCtywi+wcXC1EIOn4IG/FsEBbAPZB+U4pvucxmBpKhsPc59j4pLVEfQYaS3cOhMfjmlZYVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad618d15-1a56-4895-0cc6-08dd96ed4528
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:53:16.9803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu0sylydXQzC8KfPeJzPRrMr6rMtozrqYX7I0DJOiK5N/fi5o9zjrkTrJ9I7OBxXFJKW7Pl+pznFa9mm4klEn4OwGXMAWZyBDTlJD+5Vn3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190148
X-Authority-Analysis: v=2.4 cv=ec09f6EH c=1 sm=1 tr=0 ts=682b53fe b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=ih48mRd1dPup0nnxJxAA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13185
X-Proofpoint-GUID: QjEk_d9ZBa3-Ayv8oYTgm-tEDK4WukaE
X-Proofpoint-ORIG-GUID: QjEk_d9ZBa3-Ayv8oYTgm-tEDK4WukaE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE0OCBTYWx0ZWRfX9E1Yfg+TQ4VF
 WwQqKaKOhS6U8ebnTNEp0FKBdI8rh7WQrqKtuDwXjSBL7e4f/W88ziHEr//NfzZUq1ywWoX3XKX
 +prfZxK/2rGCdRXJnMNZ9EM+rFNjOKRgMVAXs0pW9y9REQzOJ3lq2FUTkcIDGmjbsTNO/CPU/u/
 8VVIOD9KeSABEQTmgCwIjX+C+wV6uYmCIWNQfEIxWN2C1HH8SB13LJATtClWhTwOQqe4VRyUe5F
 3uMHnIm8HIIZfko2MBSHoQGIw9yYe/EBq1eYWPAipeAejpSsQvm+9IT7K9mgENhdWWhtuwMSEl/
 bHp1pfKsfMw0Yz2LOit5DWCMXVvSDU7s0QOvhiBFwFyXGfKX58yTq1pLLhobSIGvOwTXVaRuexO
 54vvHjQG6/X+0KHRSNB+gnO6WsjYwzm39KbvzqnPGtdkGsVof7HQIdBa5G8I3Qvmo0SahUGV
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/16/2025 6:22 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V3 37/42] vfio/iommufd: reconstruct device
>>
>> Reconstruct userland device state after CPR.  During vfio_realize, skip
>> all ioctls that configure the device, as it was already configured in old
>> QEMU.
>>
>> Save the ioas_id in vmstate, and skip its allocation in vfio_realize.
>> Because we skip ioctl's, it is not needed at realize time.  However, we do
>> need the range info, so defer the call to iommufd_cdev_get_info_iova_range
>> to a post_load handler, at which time the ioas_id is known.
>>
>> This reconstruction is not complete.  hwpt_id and devid need special
>> treatment, handled in subsequent patches.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> hw/vfio/cpr-iommufd.c |  8 ++++++++
>> hw/vfio/iommufd.c     | 17 +++++++++++++++++
>> 2 files changed, 25 insertions(+)
>>
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> index b760bd3..3d430f0 100644
>> --- a/hw/vfio/cpr-iommufd.c
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -31,6 +31,13 @@ static int vfio_container_post_load(void *opaque, int
>> version_id)
>>      VFIOIOMMUFDContainer *container = opaque;
>>      VFIOContainerBase *bcontainer = &container->bcontainer;
>>      VFIODevice *vbasedev;
>> +    Error *err = NULL;
>> +    uint32_t ioas_id = container->ioas_id;
>> +
>> +    if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
>> +        error_report_err(err);
>> +        return -1;
>> +    }
>>
>>      QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>>          vbasedev->cpr.reused = false;
>> @@ -47,6 +54,7 @@ static const VMStateDescription vfio_container_vmstate = {
>>      .post_load = vfio_container_post_load,
>>      .needed = cpr_needed_for_reuse,
>>      .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(ioas_id, VFIOIOMMUFDContainer),
>>          VMSTATE_END_OF_LIST()
>>      }
>> };
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 046f601..c49a7e7 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -122,6 +122,10 @@ static bool
>> iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>>          goto err_kvm_device_add;
>>      }
>>
>> +    if (vbasedev->cpr.reused) {
>> +        goto skip_bind;
>> +    }
>> +
>>      /* Bind device to iommufd */
>>      bind.iommufd = iommufd->fd;
>>      if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
>> @@ -133,6 +137,8 @@ static bool
>> iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>>      vbasedev->devid = bind.out_devid;
>>      trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
>>                                          vbasedev->fd, vbasedev->devid);
>> +
>> +skip_bind:
>>      return true;
>> err_bind:
>>      iommufd_cdev_kvm_device_del(vbasedev);
>> @@ -580,6 +586,11 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>          }
>>      }
>>
>> +    if (vbasedev->cpr.reused) {
>> +        ioas_id = -1;           /* ioas_id will be received from vmstate */
>> +        goto skip_ioas_alloc;
>> +    }
>> +
>>      /* Need to allocate a new dedicated container */
>>      if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
>>          goto err_alloc_ioas;
>> @@ -587,6 +598,7 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>
>>      trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
>>
>> +skip_ioas_alloc:
>>      container =
>> VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>>      container->be = vbasedev->iommufd;
>>      container->ioas_id = ioas_id;
>> @@ -605,6 +617,10 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>          goto err_discard_disable;
>>      }
>>
>> +    if (vbasedev->cpr.reused) {
>> +        goto skip_info;
> 
> I suspect this will break virtio-iommu, see virtio_iommu_set_iommu_device().
> When virtio-iommu try to get host_iova_ranges, it's not ready until post load.

Thanks, I'll look into it.
Can you give me a clue or a pointer on command line options to set this up?

- Steve

>> +    }
>> +
>>      if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
>>          error_append_hint(&err,
>>                     "Fallback to default 64bit IOVA range and 4K page size\n");
>> @@ -613,6 +629,7 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>          bcontainer->pgsizes = qemu_real_host_page_size();
>>      }
>>
>> +skip_info:
>>      if (!vfio_listener_register(bcontainer, errp)) {
>>          goto err_listener_register;
>>      }
>> --
>> 1.8.3.1
> 



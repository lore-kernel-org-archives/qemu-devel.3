Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF52C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 09:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVp5X-0005Aa-9l; Mon, 22 Jul 2024 05:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVp5S-00052r-MM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:12:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVp5Q-00063m-7E
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 05:12:06 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7cxn9003143;
 Mon, 22 Jul 2024 09:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=o2qATqGvK3BQoOvumWtKjtXD8PsHbfgtT2O0x8hyfD0=; b=
 AZx1fDc2RP6OV0kKrFe0GlmBbTnL+YDqxxSgNSY5ctMTnKAB2EHzZ19n5hKqQF+c
 J5nEnnfBe7+LF4PzllRpCXDGVcTRMK3KsKMH34km7S0AhOAt1HRJqTH06ZXqNmKt
 2pZ1LP7RVMikS5lM4wV3zHAcReDfCguR1ZxaXRwBisTnjRTy7VZQy+nfzU+FvN2Z
 cOzXtsX1enTmzbgopmAWH1tzF/O19e/SToLPQsNIoIPPE5qG2H4/6zjdyGItbFro
 VpKglZus+tj3ZvdT2z9jKOh4a7cJfJmRX285IC4KCawLNtYyJbetjtXkyuST1pxs
 0lTNL5J4wPvKPBf47X73fQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft091ed-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 09:11:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46M7uFBe022501; Mon, 22 Jul 2024 08:58:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40h267ng95-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 08:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdI3oRrWWPAm6VwwK93fhG1kWARP0GJjwgbLKLiyoMToHEb2KU2hFBPENnLcsL9EMIGitwPjAffpfqzIuODdej47GDtSuu5I10HMYMNxjNHxU7KaY3TKqcmJ/ZHUma2g7BjliQlpbZC5ShZ0BzZwlfQ604DGyZXaZhctLdmHoHj2VpDEboLM681wWncf+wuxLEwiJci3oscZh9witudF6lt5qMSr3C2yJE8FgEVgZoQLFC0fmDDvFS9dcPpYTeIT2hbEqbFRU7NBcIMpX9mvq8FKh/gc0ZuLURXutJdvUDEg+xECNlNsw3zTqT4e/c9WXjGbKL37/XOlJxsjV9k68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2qATqGvK3BQoOvumWtKjtXD8PsHbfgtT2O0x8hyfD0=;
 b=AMQRSVFC39He5ANhTeZM4l48ujk/oDhZeWJYGVDEULV36M20yjXdCWEOqK5o32hvDpwNv9iF/AWvlHfzlu9ULT6d7cYWrXv4G4nn/lC8KyhEbanpanuAnlJIeYRhu8UzQFbv0YiUkW74Ng2QUn33E9CORkyLsQDEWL8OhgZgxsKMNhIMBo94JbaYnRj7NVDuWlw3A2XSpzmKbcWgcgfsQ1D//tPfSg6ZcDoqTfUVMrvlN/WTlg7mBRziwcT+aDpWZdwt76i9IxTh6495Mk74mWBHYFyFvHknLjBwgp4y4FLsKr9aSR8NZs08AgXwOCez4lTMNFKmgome6zruHOBmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2qATqGvK3BQoOvumWtKjtXD8PsHbfgtT2O0x8hyfD0=;
 b=ZJRGgh5OOtqW5eCYGId//KWMAwitQ8VwO6Mdfd3MVODwEIkeuaFUFbVSiy8ZFCbLOJlQEVGKyfkk6kCRkNhgRdUhrqtyFBlJ339Qa9+1gOlLVmQdba2RPLoZ5qv81M5DxjzXg2delgdgtbPo58l4FFTNqBXx8Q2/K97jZraC4VY=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH2PR10MB4359.namprd10.prod.outlook.com (2603:10b6:610:af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 08:58:08 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 08:58:08 +0000
Message-ID: <be585d48-00d3-4a43-b242-fa7dd188e392@oracle.com>
Date: Mon, 22 Jul 2024 09:58:00 +0100
Subject: Re: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-10-joao.m.martins@oracle.com>
 <SJ0PR11MB67446F1658661C5F1542D00C92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67446F1658661C5F1542D00C92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0032.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::19) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH2PR10MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a821554-1f05-4748-8005-08dcaa2c6847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzF2NEFmSDhzTWRQdTNHODE1dUJodG9wMDAwdE9DQzBOMU80dUM1ekRRM0xC?=
 =?utf-8?B?bnRkZ0M1OUdHMjZSblVJNnFwblcycloxWWhaU0R2T3B4WjVDa0NEbnQxTDRR?=
 =?utf-8?B?Ympac3lqVEVmQkUzQWR5Q0hPYlBMNzR4cUhTMk50UDJlNkVOSm5GOG0yRStL?=
 =?utf-8?B?TzF1TDlTa1pHb2RsTFFFSVFaVGdsTEw1ek93Qk9zUVBKT0dEeUZYMmNpOGx3?=
 =?utf-8?B?dXphNGxUUGdneXdlWTViK1ZWK0pQeXdzVVduajhjNTVUdGczc3AyS0JCbUIz?=
 =?utf-8?B?b09tRzRhNGxZV2ZYSlRiSFlnZERPcE9OZ0YwcThuNE5nV1c0YzdFRDJIa05h?=
 =?utf-8?B?WFdBQTJoZlpGdUk1YzlPOWFMK29PNmF3Q1JhOHlxWjh4YTMvNzcrdGcrRGNu?=
 =?utf-8?B?TUJNNWsxQ0UvdStEaXl1TkRjSzlibnlhVHBBNWp0WVduWWlZR005N0YxLy9M?=
 =?utf-8?B?RlNPcy9YNkd1RE8zU0I0ZTlmTUg0a1g4TzR3UDE4L0JqdmtjOWsrK1ZCemJP?=
 =?utf-8?B?ekxHczk5eUt1d091d21mMVJ5OEc2Z3A5Y3licEpFUXVqK2lvN0VQei85Q2lk?=
 =?utf-8?B?RVdqSTVCRjZKR0lVbTNMTFRjSmM5L3BLTlJ1aVJ0cURYZ0RtVDl0VC9mRkI2?=
 =?utf-8?B?QURFOC9kS2RUNXhmczNCRmVPTXlaZnJuck5VWDhRem5nb2R2dnMvS01vS3dX?=
 =?utf-8?B?ZmdqaGlpMGM2YXRCQjR0WTV0S001clFoTU1IRnJiQmxZNGRGNTBBYnVOc2x5?=
 =?utf-8?B?dCs4M2NZcTA0N0JnZ090VFYrbE8rcjFhcll5K09Rc0poajV5aDlHT3RTaExJ?=
 =?utf-8?B?VkRNK2VEOW9Uc2xhWEhhL3lZajZsakRpcjVyTXoxZlhPTDN3UGhxSXVBNFJU?=
 =?utf-8?B?d3IvOXVkQk5mdFErMnlEQVJ6YWhJa1BtMittREt5ei9PbEdWTkw0SE5zMldD?=
 =?utf-8?B?cVhaekhJbzlQQ1ZidC94WmlORWI1LzFYMkhsdzBJajBubkJGMXlJUHVsZUt0?=
 =?utf-8?B?bTIrNEJFVWZ5NS82WURrMFpyeGhYV3lVNzFmcjFSd2xhTjhjOUNOeGVZVmth?=
 =?utf-8?B?ZkxhOU1KcXViTzcxdGdqNGh5ZFZ6YisraEtiSm56OWVUTVZOd1U2ZEJxaW1y?=
 =?utf-8?B?NnhXcXVZcmhVR0UxRlBvTnUyei9NaS9SbzRvTmJFSFpYRXR2dFBqYVhPZ3Za?=
 =?utf-8?B?VzlEeGlWcGpOWXp4ZE5ReWxZMW5EZWExUkdBK3JVRkJzUmxvbUZCb0ZUUGw0?=
 =?utf-8?B?SjVwSWtZZ01La0pMbjJXYndCSlJ3YldXWGtUUVg3aDdkZytMaDFRSUdPOFMr?=
 =?utf-8?B?VzdGSW1rVitUbVkyVVBGZVVMOUV1UktsbVR1Vkx2YVEzSkVvWWd5cnFmYXdG?=
 =?utf-8?B?c20vTW15NjE5QmNMcWREQkJramhnRWFJVmRKemtwdmFQaDN3SldMdEVsTi9s?=
 =?utf-8?B?QVAwL2FPUWJHUGkzWmg5L2tkdGduVVV0VWFHdEZZalNVTy9WUDVRVTBhaXRn?=
 =?utf-8?B?dVVwSWVpTXE0a0JQbDR0R25oTFhzN1VnQlJWa2UyRXJMTTRKTmFqOExHbVll?=
 =?utf-8?B?dXRUbHpUcXVXbSt4MldlTHo0T3hNLzJCRHQ2a0tVUXE5akJXdURPNFNSalVi?=
 =?utf-8?B?UTQvdFU4ckZPajV1S0U4MWhDem5peFlnS2tRbXlFeHlWZnFYaHJrOEFNUlRR?=
 =?utf-8?B?MXhpQmpRaDJTZDBhRFNlNE5PaXF5Nmkramh1ZDc0eVF6VzFJWi9sMSt2TzN0?=
 =?utf-8?B?eDFLOE14TXlhV053SWNocEp5ZzNqdUsvSUcyNjdKd2dQV0hLektPZUQzRXFZ?=
 =?utf-8?B?SE01QXRpZWxnbVNnV2dqdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhpMFAzTjZ2bEtoUGFub3YzREJtOHduOHY2ZG43cGRFOWNRdHp0TG5hMklE?=
 =?utf-8?B?S1pYZ1hVM1o5S0lQMkFlUU02Y2ZiMU1vQ1pEZ0x2OUJ1YnVqL2JDcWJoaFNP?=
 =?utf-8?B?Q2p4dExOMU9lOVpybmdWM0Voam1Ja01OdEFPeldKVjg5MjRUMy9JSlYyZyt0?=
 =?utf-8?B?anRZYXhzeFd3UldtUzVrRytTcW91TWJpNDhDMVcvbmdKRzEyYXZZM2xCY1Jv?=
 =?utf-8?B?TzA5cnZqcXV6cnJOR2pveVY0WStzdGtvNUFNNUEyVnBXQjNKSTQwZzZtdGQw?=
 =?utf-8?B?bjRpbU9KVWFMQ2ZGT3FOeXB6QVhWcmhSQytyK3BTVzk2dGN1aEFXY3JqbFE4?=
 =?utf-8?B?b2JvV00rblFMcWRkTWxKN2Z5ZTR3ZmF5TEduMWVsSHlVTVJGNGxHMFpxdmkv?=
 =?utf-8?B?OHdNZ21odUZlVXl2MnV4Z2JYaWVnbGpHL3JkSGt6N29aRCt1MVFkNXVnNGI5?=
 =?utf-8?B?OGlDNDNaaC9zRGp6OGkza1U1S1N3WnBEaTQvQWQvRkFQT0plbXp6MFpqY0Rs?=
 =?utf-8?B?ckpGeitPU2wwLzlwM2xrdkx4eEZHa1ArNWtVYWZaNWRSVUxTT1R6dXRvaUpj?=
 =?utf-8?B?OEFnUk9oYkw3NzdZbTJYQjA3RUVHczJJcytnRDBpZzNRZHVJTGR1eWRhVXo2?=
 =?utf-8?B?R2hYNWRMSzgrVkR0eG5pV056Yk12RmRURXNKQS9zcjk4akhDdTZOc3JVa291?=
 =?utf-8?B?eFJwVGtMOVhRWXFmNjNUTy9JNkMrS1c0Zk1SWGZnS2J2N0NTalFYa1l1aTQz?=
 =?utf-8?B?Mi9zT21ONUZEeEtJRWFPZ1JpOWhUVTArT0s0cndnZ29pWnlrRFRPMzhCdSt1?=
 =?utf-8?B?OVJLaFFTemlCMGYrbkNWQzI0V21ITTBrWllFdjFkN2pLTjczME92SlB5UWE5?=
 =?utf-8?B?dGt0c2gvNWZwMXBzTUd4YTE1eDBodFpxT1RnVHB0T0hjbFdQYTZOZUl0NU1k?=
 =?utf-8?B?UWhkanAvS3dvNFlENFlyeFZNMlpMemFSUlJ3bHNIRmM5dThiTkRwUnlKSHp5?=
 =?utf-8?B?MTlzV0o0Vk9yWWRhSzV2cmkrMUd4UE02Z2VlLyt0TDVCMGdlOXZibi9sSlAy?=
 =?utf-8?B?bVFMMnZOZTNDY0NHcXVvOVpNb1liVHZBcmJCZ0xpaGJtOGo3RDBmZDBnVnV4?=
 =?utf-8?B?Y1pxSzUyRkRidjRhTXoxN01sQ3Fha25KWmc3QTdYbnc2UitmNHZuNCs0Y0JO?=
 =?utf-8?B?S3FwZHJRM2JOOXZwcDM0MGk1ODkyaGs0dDdKV3FocXQwK1NVSnVRdUJXSjll?=
 =?utf-8?B?MXlKSGczTWJheHV3cE9SY1R5SkV0OE5mYkZKVzVrTllhSHJoUGY3RmlrTEZu?=
 =?utf-8?B?Y0pXbmRhUjJDZHVRdm5IYnZ6NGFYY2lmNnlUTmpDbXBCNEY4bUt3dStLemRs?=
 =?utf-8?B?UVlKdzM4MTRlVnI2Tm5BNms5YWdFZFhkWlNHNGFyZFlXZytVNGtGN2NFZ1ZB?=
 =?utf-8?B?dHB2WjlvVFlmcURVQVd0bUg0ODduV2FzTit2RUtoMnh5NURwcDl1eWs1YVo5?=
 =?utf-8?B?d0VMR2d1T1NBQzZkbGQ0dG5JYldGSVdLaDFTbExwb3dYTjZ3T3RtM3BoTjRK?=
 =?utf-8?B?NXhieWZ3eWNXcTR1SE9Na3Z2YWVNTDIyUU9ZbWpHTzZHTUxkcDNyNGNsd1dJ?=
 =?utf-8?B?VVBiNWpSN0NZTVJnZzZWWWJnOG84NlVTemJxN0ZCdUtGNWJpODU3TU9sNG1y?=
 =?utf-8?B?cVNHZ0xuTjNlMno3SEpYek1jSG5BamI0RjYySVJrS0lCL3k0MFI2clQzVU81?=
 =?utf-8?B?USt6ek9aVno4bUo4QU9mcEZoV3FlOGt1WElyV0xUTWRnV0ExOURMemxOeEFm?=
 =?utf-8?B?OU4vOWdEZDBWTGlGLzc4TG1jZVV3UFdaaXZaK0ZxQ05VRWM4dXZ3UENNdEtJ?=
 =?utf-8?B?cDI3UWVLY0QvTTUvRkF5TkFMOUpKYlA0dzZoM2lIOVgwbTBscE5jQzVxSC9x?=
 =?utf-8?B?Y1R5eFM3ZmhVMU9Hb1pxbnB2V280ck5XTTRSQ0s0N2k1cDJNNURmZjgyZUlK?=
 =?utf-8?B?MWVwNzhPNGZBTnk1ZXY5dU5FYWVwRVpoNWJYWVpOUEQzRktNbjF4NXdCZk9S?=
 =?utf-8?B?SUMwVnZRU1NlbnNhQVpPZzdTZEFXajY0a1pmSVZNdWM0VCtYbFRST29hOVI2?=
 =?utf-8?B?dko4Ylp4T0VYazA1bm0ydkZCdnJaWDBuUEE2aFFuOGVQRjR1Q2Z0Z1RMR2hV?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 91mk1qRbiRzhxrqxwWIW2DYDwe3xpruD4J+gvFnzaBXbxv5bvAos8/k9JkejT/kQLrvzOFD0JnuCmzWc+o44S9oLtq20NcUGnQrcpKYiNBOx88XAnxG8xKyttzzh/jB8N3Brd8Q2sVsbFL3KqQIPRXEHGUN3FZEIT+UEcd92IbtdsYR6ZhV2Mc6LZk2lJJzIEah4WnDBkW/45kaNQ7dbA2igbFQL6PhMLor1cieWE9GimQtg/Sl5ePHhtuOwYDodf7FsRbe0R13p6XWlxOTPSITWW4CAhVMbxshwBWVw+jpOQOmFt2wMHC3tHok07diuO/381nCY6kDCjbYpWJZ3VMNa43rm750d5Xm1VRokO6hTdV0q/8WRnEgCPkUMYPxIPRky9PMSeHvLTBjzboJMupjT5WIRBcl0zBFiG6gmP+T8EeG4XkA4Zb5DngXzPRaqe13U3bP9KSMvDI3xGRKFN22wXvW4BnWG8bxsXtogdxSMjPdhnkAQO2D5PaJUMWvnlnC7S0A48QrhJ5i7ZFYLZExOyKhBugC9lLkWKFUZNj1/mSRyEdXgUvk5HaDA7Ko7YU6ElhHJo2aXO6sMCWRoGYrr3c+iHeI5c7k0LHaO+gY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a821554-1f05-4748-8005-08dcaa2c6847
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 08:58:08.7560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNjnYusPRYWDoLNNFwVwdWhAk7KJsMi2eez4o/gjGfH3onDBNXaNGjjad+SoWNMvyRXG0FRzkkTRHGki2HgsVAklbZ66sUXxUHULpPv+/4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_05,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220069
X-Proofpoint-GUID: xTp3KovFJqWHz3Us3OGkP2pcu1xF-84q
X-Proofpoint-ORIG-GUID: xTp3KovFJqWHz3Us3OGkP2pcu1xF-84q
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/07/2024 07:05, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
>> tracking capability
>>
>> In preparation to using the dirty tracking UAPI, probe whether the IOMMU
>> supports dirty tracking. This is done via the data stored in
>> hiod::caps::hw_caps initialized from GET_HW_INFO.
>>
>> Qemu doesn't know if VF dirty tracking is supported when allocating
>> hardware pagetable in iommufd_cdev_autodomains_get(). This is because
>> VFIODevice migration state hasn't been initialized *yet* hence it can't pick
>> between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
>> dirty tracking it always creates HWPTs with
>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>> even if later on VFIOMigration decides to use VF dirty tracking instead.
> 
> I thought there is no overhead for HWPT with IOMMU_HWPT_ALLOC_DIRTY_TRACKING vs. HWPT without IOMMU_HWPT_ALLOC_DIRTY_TRACKING if we don't enable dirty tracking. Right?
> 

Correct.

>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> include/hw/vfio/vfio-common.h |  1 +
>> hw/vfio/iommufd.c             | 19 +++++++++++++++++++
>> 2 files changed, 20 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>> index 4e44b26d3c45..7e530c7869dc 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>>
>> typedef struct VFIOIOASHwpt {
>>     uint32_t hwpt_id;
>> +    uint32_t hwpt_flags;
>>     QLIST_HEAD(, VFIODevice) device_list;
>>     QLIST_ENTRY(VFIOIOASHwpt) next;
>> } VFIOIOASHwpt;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index bb44d948c735..2e5c207bbca0 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -110,6 +110,11 @@ static void
>> iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>     iommufd_backend_disconnect(vbasedev->iommufd);
>> }
>>
>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>> +{
>> +    return hwpt && hwpt->hwpt_flags &
>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +}
>> +
>> static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>> {
>>     ERRP_GUARD();
>> @@ -246,6 +251,17 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>         }
>>     }
>>
>> +    /*
>> +     * This is quite early and VFIO Migration state isn't yet fully
>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>> +     * whether IOMMU dirty tracking is going to be requested. Later
>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>> +     * instead.
>> +     */
>> +    if (vbasedev->hiod->caps.hw_caps &
>> IOMMU_HW_CAP_DIRTY_TRACKING) {
> 
> Looks there is still reference to hw_caps, then would suggest to bring back the NEW CAP.
> 
Ah, but below helper is checking for GET_HW_INFO stuff, and not hwpt flags
gioven that we haven't allocated a hwpt yet.

While I could place this check into a helper it would only have an user. I will
need below helper iommufd_hwpt_dirty_tracking() in another patch, so this is a
bit of a one off check only (unless we want a new helper for cosmetic purposes)

>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +    }
>> +
>>     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>                                     container->ioas_id, flags,
>>                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
>> @@ -255,6 +271,7 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>
>>     hwpt = g_malloc0(sizeof(*hwpt));
>>     hwpt->hwpt_id = hwpt_id;
>> +    hwpt->hwpt_flags = flags;
>>     QLIST_INIT(&hwpt->device_list);
>>
>>     ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> @@ -267,6 +284,8 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>     vbasedev->hwpt = hwpt;
>>     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    container->bcontainer.dirty_pages_supported |=
>> +                              iommufd_hwpt_dirty_tracking(hwpt);
> 
> If there is at least one hwpt without dirty tracking, shouldn't we make bcontainer.dirty_pages_supported false?
> 
> Thanks
> Zhenzhong
> 
>>     return true;
>> }
>>
>> --
>> 2.17.2
> 



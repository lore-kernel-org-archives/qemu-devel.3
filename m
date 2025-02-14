Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4F6C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2Lv-0005j2-2Y; Fri, 14 Feb 2025 15:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tj2Lf-0005Lx-NB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:31:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tj2Lc-00027h-Fb
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:31:42 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EGBUnE009858;
 Fri, 14 Feb 2025 20:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=rRac4SwYEN/IInybsGwzWnDlTyykXBfjIEonC6rWVNk=; b=
 nJc/JOziojypadJq3KvS6EmPxtJ/VyL4904xHuo9LZhMTt5S0bfFB+TClmMTILK5
 RlclveZm8AfnwmzxroeEGWModG/uOLBaJnH8FOX08rXoIB/SQS0Rps1KvdrQJyJL
 IVxFGK9p7AfK64pbf2kdSXSgSWqQET7yw8DwdqHzsSYhlelFSOUuNHw97wTP+XlJ
 SVgMa2o7wtZgZ4krEHNX+Vg4/WY7TEFA2jnpobVRbu6DusrVqFHi8cxAI8OCdy8M
 4zOC5Av1Pqh9SbhVQLuPGx+HCo45zNsYyU/oSfv1EucXWeLhRYinQrz3G8HWzUCM
 zka996EBO732ObYx/NVJEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqcnpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 20:31:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EJMo5c008887; Fri, 14 Feb 2025 20:31:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqdmt06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 20:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA7nWkDqM9WawLYALSIQWA/vh+A0XCh4v1eLm4aBz+Zi4wu4Z5e24EehP71En3vppXgyDmsrp6hbfMaQTJLuH0px7NzcOrPq9I4n0H9wZlpWMPdtltJ9Ti1HSZhZTjvpYmlkSV1F3WuMomSYcAsgttJwQ1aH0baHtYCwuj2ovZz3hUijOpzqvA9OsouyAy//RJI4f2iQqysu3U9ABDZ8BRpF0NSMIjhR8LHxdbBvo+vwXLE+4HCxlAEUdPPG+aPVZfJZp4Ikyl7eoB2RvNDQ49e6ZJB29woW3vqSg7LgH46CmdUSCyx5kW30OWZDJTp2MC4JOdnzXM7ltT7jC8zSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRac4SwYEN/IInybsGwzWnDlTyykXBfjIEonC6rWVNk=;
 b=UCDhzwTbWYSLXzlVCMNT+i7SBDYd2x2Mk+anhlEGv3nWWQPWup64ML53rwbi9tFRb7aOH8YIZyUdH+3ZBoOAPNG6y9Qu2vFePs925AT3+34Wws1FRoN3ZPvL6hEzzuq8DMegh/u9Tk1/OGiEtGpXRRztTLN9hSN7+o/SpAEq5l+cgLFp7w8LZ04D3RIrUXj+Iote8fJZ2ehoZpHSlWHgHdeslvKowrqf23IBFLf12hyEdJ0GZvgAKs8JtZG2/tCStFwc2oNU1yXkzdJxQwveR/9LhbgF246Z3elKEmIRVXe8FMrjgekmc1TB5I61FbabORqAhgKS14sCFjH/BKkmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRac4SwYEN/IInybsGwzWnDlTyykXBfjIEonC6rWVNk=;
 b=gN0xqLPk09K0j1PHu7Z5ZThlqiC4TsF9Upa+QvwZsqbCZBBmEcXCXFgj3QMCxXpNXy41q03jBJL99yjTwXgSDSO7jBsPxm62gUkb3G6/Ggm9KNgCkAcCtXIz4b5v/JE9C04G6XOzzphwFW092+DIG9dR5s6lYYk9xwjWDItRa9Q=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 20:31:31 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 20:31:31 +0000
Message-ID: <ee12d6ec-13fa-4e66-ba27-97fdb1f49f74@oracle.com>
Date: Fri, 14 Feb 2025 15:31:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/45] migration: cpr helpers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-3-git-send-email-steven.sistare@oracle.com>
 <Z69xPYAJcOjlSpff@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z69xPYAJcOjlSpff@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:408:fd::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BL3PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6e66cc-2c2b-4b57-31f3-08dd4d36912f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnpPbWk2R0pNLzNKUDBwVTV2WXVJaVZramkzV09POGlvQUxYYmhoV2hwZ0Vx?=
 =?utf-8?B?NUVnUDR1YTJpbm03MElOSW1INzZYc2FGRXlLWnhPNmJHc1NteGs1MEhabFR2?=
 =?utf-8?B?akNpNmM3RE1Kbjg4WmdVK0Z2V2toNndjdmVkRFNURkRoaVRCTGlkZjJ0dFZE?=
 =?utf-8?B?c3lJbUEwaHBsc016YUpxb0FVU2lmMDlEL0E0N1p1QUkwYVhhcmtCZW80ZXAz?=
 =?utf-8?B?UCsrMFo1VFpvU3Nwb1dCQ2lSWHZOYzVzUnpFNksvOUZjY09IMUxITUpBR3Bh?=
 =?utf-8?B?NTJkRUVwV1FkZlY3MFZnZGY3T09RNzQxVW5nSGx2WnkwR0pCdGtwRUpuL2I0?=
 =?utf-8?B?Ni85aHRXMVdxRGRJbHdqTDJNWWU3TEpRSWNhbmtWd3gwWlpxaEltQUlxeDZj?=
 =?utf-8?B?cUR3NFBDMzRlR3ZwYlJ4c0VzRmFWdmZaOThxQ2Fja3JoZzQwd3U3U1p6d21D?=
 =?utf-8?B?NkluYW9DWXdrNlRXT3pMRnVNRVBMSlNjZ1JjdlR0a2x1TkJjOTJMOGJkSHJa?=
 =?utf-8?B?Sm1BakNwenZ2R0dXeGdlOEpPYytvZjBDcUZMREpWMTN3cEc5Rk1UcFBmQ1hj?=
 =?utf-8?B?aXpGVng2V3RGS2J6Ry9pcFFoQ09QRTUvQXJJT08zQTM5dDltOTYxUWxmc2pz?=
 =?utf-8?B?RlFBSTVOdUNXVExmVnN4eXpNYVhoOVJUNCsyNFRkS0xrbGJMR1V0U3FQbU4w?=
 =?utf-8?B?KzlCaElmNTFGamhzaDNyVndYV2cwVFIycW4wUjdYSTNrcmVoRUxTZnJZeFAr?=
 =?utf-8?B?QVpUS21ZeFhDTHdjVDFrQVJYakd1UUZjaUpIdUIrQ3lNMXZDRS84TVJyN3Zo?=
 =?utf-8?B?SmVMRDk1L1BWaUVpWHdYbG53dDlUcVRkV3VqVUExWFJ5MmZIR0Z0eGNpM1Ju?=
 =?utf-8?B?cnpXR1NkcUppOGw3dTNvYWpIWnlTMWJwQ2sxMGY2d0hvYy9IbWpqR2JCQWJT?=
 =?utf-8?B?Vk9ndy9ZckpLbmk1RkpPTUhRTGtHSVV5Ums4UWxyTnkzMG9mMU5BQ1hnc2RG?=
 =?utf-8?B?M0hLK3poc0RZUjNqeGhXM3ltaXZKck9XNlU5ZjJKVDl5SFpCcWpDMkhwRFpJ?=
 =?utf-8?B?MlBJdk96dW5CdER3Y0RoRTBTbS96cm8rTS90MDFvRGQxZy9PUjFxT2JQQVhy?=
 =?utf-8?B?VnI5Q3IzaEdDTkpkQzN6NzNWOXNhUTZibEphTjdEZURjemhwWHJvQjkvRmc0?=
 =?utf-8?B?NjMwQ052czJPRENqeFpJU2VoVXVUVHVXWDVObjJDekhKdXZWNm5XT3pIS2Fn?=
 =?utf-8?B?VFJFeWNya01uVDVOY3BDeU5ralZIS2ZoeWVVc2loOGNwVjJ4RTArV3RxcGRt?=
 =?utf-8?B?TVN4UTduaGFtM2FxZWYxMkpmQ20reDczT0dkYUxwcFRnQWdDVjFXb2NJQ2J4?=
 =?utf-8?B?Ri8vVzI3eThwMlBIb1hEaXdQYmUrY25kaEJ4OEJTeGFMeW1yampBcEtkc0cy?=
 =?utf-8?B?Rk5rOHV1ckU3Qk5odzFxQ05QQ2tzcUtEWXFiR1NqODc3S3dIajljL0VkbFFI?=
 =?utf-8?B?S1RaTkdhOHhHRVNHZzczQnF1RHZNM1cxSS9zeW0wbVlLV1ZSdkljMFA3Titw?=
 =?utf-8?B?THJIcTNNWXZKdXEzcnljZ3NRVkU0MDN0VDJXSmNHK1JsOXpHcjdhM0ZZUU9j?=
 =?utf-8?B?OGlEcmowZGRjL3VyWDFQWnJRN0thY0tMSTk5TUtwSW11L2RPcy9WcW54NUMx?=
 =?utf-8?B?Q1Y5b2MxdnhMVnd4VG5wbFFaLzNFV3VSVnhlYmZrQWxid3h5R2VkSVV0dXEx?=
 =?utf-8?B?SXRUdWpRcFFCdTA2cHhlZkVpVy9FSVgyT25yZjgrTFMzUDBOMUUxRUJXYkc2?=
 =?utf-8?B?OGRpMDh2NnpFNDc5RmNmVmx6c0Q2K3F2RHIyazBEWWxSRmgrLzAya2ltVVE4?=
 =?utf-8?Q?MUIJw1t0TpPTU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWJNTmI4Ui9yUnVDWWEvWWdlc1lsRzBuVFM2U0NDSXZiL3A2T2lvMUI2cHpF?=
 =?utf-8?B?OGRkUWVyUXJOL2J6c3FXYlBXaWh6UlVFRVo0eWc1d29hck0yWmk0eHdwTW5y?=
 =?utf-8?B?QjBiZGlVeW1qdGh4dDBnZ1YwdHJvWE1mM05zTXF1ZWx5UURIZUdlM2FuZzla?=
 =?utf-8?B?TjZlNVBjVGwxcjJEdlZhUzJhMzEvYnEzcDZFS0Z0N004M0hBZzA1RjlFcUEv?=
 =?utf-8?B?Z2VwcWlXdmNCMWhFZ09pQWpySVV2REdoTUtsSUN0WWNwTEFOTXRYWnNkdWdB?=
 =?utf-8?B?ck5JeFJOTkpCaEVHb1IvdjRRUmdneWlGN1hEZXlZQXlQWHJETHZQd2hZT0ll?=
 =?utf-8?B?ZUFlTExaTXlDMGxvNDhpbzB6eUlnc05Hemtvc1hHVDVJeW0zYzBiZ2swWnBv?=
 =?utf-8?B?S1hSN2JpTWViUFo2VUtjaWpxVlg2N2tvWm5CQUFwVnpwTmFTbGJTOTZaT25D?=
 =?utf-8?B?M1RGNTZhbmQxM2tya1dYMU4vdU10TkVFbG5qNURQU0J6bnBlNHU3UC9abmV1?=
 =?utf-8?B?cjIxTmdtY0JjM0pZVlV0OFEyNitoUWQ3dmtpWEZ6UjhYU3g4NzgxTzVPUlNY?=
 =?utf-8?B?MEx3ek52OVRCM2NZRHNKOGtUT0hoTEMwcS9qUjJ2UE9ZSnN6MGVKMzRRVTgx?=
 =?utf-8?B?SDZvQzhZdTdoUDFBWCs4cGZTNmJGRzhRMUJlRjZtL0hwVWJlVWhJSlJQUW90?=
 =?utf-8?B?RTBIbmN5R1FiOFg0NnF0T2FlNGljd0RhaEY5eS9VL0Y3TjFwT1lIbFlySmt1?=
 =?utf-8?B?dFN1YTVjR1I2bEUyRUJQMEFFRHFGTjJNUi9BUUg2M3hHSVlZUW92cU5pOEV4?=
 =?utf-8?B?dU9ySkg4dnZ4dHZZQXN4a3RFcVVySzZwTWpudG5DWmZneEpFZXFSajFmVUk1?=
 =?utf-8?B?MHBlMFFsZDZ6NjFhK2JCVXdwK1FaRnBVcDd2UERJaTVOZEZMNThsb1E3RG1k?=
 =?utf-8?B?bnJ1RGovSytJMGp0K2xNZUF5ZG5pM3Q3U0NaQ1JFSjlsWjZtWWU5RGJhZ096?=
 =?utf-8?B?bUpuY0krdXdXbCtmMGdVdEkrL3Uzc1hYK2d2UDQ3Z1JKNHBvV3YwTmdVRlVn?=
 =?utf-8?B?R3R4RlJTQ2RVeWtFRG5acmwySVFsZVhSc09mcG94VTRNdkExNDNqenlIeVo2?=
 =?utf-8?B?MWVubDl6UUNyalJZaWZTQnpKVE9Yam9WdFhQVlFsdjZ3WiszSFgzU0dmN0p0?=
 =?utf-8?B?ZmpQeGFtWWJPczUweU9FUFlaVVdycTZzQjBHY09jWGQwV0tqSy9hYWJTWkRK?=
 =?utf-8?B?YVpoMXExSmRTeUJzcTdQdlFrSGs5cGE5b2RjSmlwMUdPbFlwWUVma2xFUXEy?=
 =?utf-8?B?REtnZmFsY3pRZDQrK3d1WThsNDNTRllpMFBTamptbnRsTmQvd2VaRVVnQzNo?=
 =?utf-8?B?a044aVY5NVdYbFdUaFRIcGl0T1dIUXNJY3hVRWJPeFFNMEt0bHFZT05qVDFs?=
 =?utf-8?B?eG1IV2xESm81OTJmd0M0bmZCbGJ6VlB6ckloajFIVkVTLy9ZbTd5eDJ3Zlo5?=
 =?utf-8?B?ZG5ZaUdnZ0s0MEhILzdMNVplc212Vi9Sb2VsOTlKZFFFUVMxdXpFRitkR2l2?=
 =?utf-8?B?OTIzenRPQ0phUk44OUVlTENURDFMNVZJVkFBNEoxcGU1RmhmMkduWUUwU3p1?=
 =?utf-8?B?d2N5SUpYa0F2akNheGpLQ2lCZUc5Vm5icGJlQXlyd2ZpbTlzUStQeXJKSG1S?=
 =?utf-8?B?NXJCY3VSWGRuMFp1N1F4ZlAvVlA4MHhDYVhablh6emRYb1JBdzJadkJkc2RP?=
 =?utf-8?B?T1NOdFFXeElxbk1jR1lSTEphaFVDYmcrU1BMeW1NYTBtTGtwQklZYmJHRWJD?=
 =?utf-8?B?MDJiYmtobGM1UGhGYVQ1OEdlZi9UeHppay9zbThIcFhsS0VhQUhTZXpzSHRV?=
 =?utf-8?B?NWFJaE56cmViV2sySFRXR1RHNkV4dldiekFrNDNMYzJMcTRZOU84UGZlVHQx?=
 =?utf-8?B?ZnN2eXlTbUlMd0ZKcjJYYTE4MSt0UGIvejhJWlJ1UzNaUUZ5WmphSU03QlBv?=
 =?utf-8?B?MUk4azBFajRsRk9ER3lsVWd6cjExUlBuRVhzeSs1V0RzMHJpaGlOVkNXTGs1?=
 =?utf-8?B?VFZoRHZWeGVsY2tHejU4WERLVW50MFFrVER5NkJlZnpBWmRwS0NRY3ZPL2Va?=
 =?utf-8?B?ZmN6enV2TW5QemlDVUNTYWpBMXFpNGc5MFE1alhiVW50OVlJaWFjRlluRnE3?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1XoysAWfNXsRIddXIbu3Eo+uWuAzrvaxvPogwVkaAXkJSZRy6rdLUHQkov5yyy8ETHYOL3XxQ3Nh2PoX//Ru42mvoIqZhb14pOxwqDNPUEE3+Zvjayz4gcZXbhsgSZOtQm3TPMta/BJN+F47xexdpN7dO5OCUtjGvV2YkFAEI7s6mlWqb3Z5hr3Rf7Ryed353rzMEXc8DuaffOswJloUM2ce8AaOfmmSJ+3z1eTXnY4ygTxPQ9fequwMxmwEovAupZfRx6exM21BpGHgXpBrKgnG73YDG8SM2FSO9EXkInMScO0UgU+ZzGYWar1nfrHeyQ1LhZ5nzW3RUxWGcQVxG84c/rr1Gm+R0Z9Cl5oLGhL0y3IheP72dYUn9FxsnpQvVb3zafuEoZipSAE5ZSYJjRLXI8N5qBPfmim0VGkofIm6/y8KME+Ot01MHhecvazMz1d0JkwVxjWDScrjt9cea5cEaHgqwR0V5Fe934K1XYzNKnw6W/40VTGbnReapujyQbkGth5RP49FG4yWqgSc6Z5lrhnV4fIrF7tdt/5MxYhNlhjuflUvb7WGvGCqV8MH12bKWCqMeTP1cFACVqy40LUNEwQk/yKgr21ShyYRXxY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6e66cc-2c2b-4b57-31f3-08dd4d36912f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:31:31.6980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3UlJ1PEtyHbeqiTE7Hu+N2XkIqLu4gWfbDyX5VfBOCvgMHpJme8spjsKVFz2GRKMCMBYnikhzUMewKBvEQKoPINDoQP1wUK15XH2080XOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140140
X-Proofpoint-ORIG-GUID: SNp_WxAek7euURSB32YIefuVIbYZG5dn
X-Proofpoint-GUID: SNp_WxAek7euURSB32YIefuVIbYZG5dn
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

On 2/14/2025 11:37 AM, Peter Xu wrote:
> On Fri, Feb 14, 2025 at 06:13:44AM -0800, Steve Sistare wrote:
>> Add cpr_needed_for_reuse, cpr_resave_fd helpers, cpr_is_incoming, and
>> cpr_open_fd, for use when adding cpr support for vfio and iommufd.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/cpr.h |  6 ++++++
>>   migration/cpr.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index 3a6deb7..6ad04d4 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -18,15 +18,21 @@
>>   void cpr_save_fd(const char *name, int id, int fd);
>>   void cpr_delete_fd(const char *name, int id);
>>   int cpr_find_fd(const char *name, int id);
>> +void cpr_resave_fd(const char *name, int id, int fd);
>> +int cpr_open_fd(const char *path, int flags, const char *name, int id,
>> +                bool *reused, Error **errp);
>>   
>>   MigMode cpr_get_incoming_mode(void);
>>   void cpr_set_incoming_mode(MigMode mode);
>> +bool cpr_is_incoming(void);
>>   
>>   int cpr_state_save(MigrationChannel *channel, Error **errp);
>>   int cpr_state_load(MigrationChannel *channel, Error **errp);
>>   void cpr_state_close(void);
>>   struct QIOChannel *cpr_state_ioc(void);
>>   
>> +bool cpr_needed_for_reuse(void *opaque);
>> +
>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>   
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index 584b0b9..12c489b 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -95,6 +95,39 @@ int cpr_find_fd(const char *name, int id)
>>       trace_cpr_find_fd(name, id, fd);
>>       return fd;
>>   }
>> +
>> +void cpr_resave_fd(const char *name, int id, int fd)
>> +{
>> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
>> +    int old_fd = elem ? elem->fd : -1;
>> +
>> +    if (old_fd < 0) {
>> +        cpr_save_fd(name, id, fd);
>> +    } else if (old_fd != fd) {
>> +        error_setg(&error_fatal,
>> +                   "internal error: cpr fd '%s' id %d value %d "
>> +                   "already saved with a different value %d",
>> +                   name, id, fd, old_fd);
> 
> How bad it is to trigger this?

Bad, cpr will likely fail the next time it is used.
I suppose I could add a blocker instead of using error_fatal.
But, fundamentally something unknown has gone wrong, like for
any assertion failure, so continuing to run in an uncertain
state seems unwise.

I have only ever seen this during development after adding buggy code.

> I wonder if cpr_save_fd() should have checked this already on duplicated
> entries; it looks risky there too if this happens to existing cpr_save_fd()
> callers.

Yes, I could check for dups in cpr_save_fd, though it would cost O(N) instead
of O(1).  That seems like overkill for a bug that should only bite during new
code development.

cpr_resave_fd is O(N), but not for error checking.  Callers use it when they
know the fd was (or may have been) already created.  It is a programming
convenience that simplifies the call sites.

>> +    }
>> +}
>> +
>> +int cpr_open_fd(const char *path, int flags, const char *name, int id,
>> +                bool *reused, Error **errp)
>> +{
>> +    int fd = cpr_find_fd(name, id);
>> +
>> +    if (reused) {
>> +        *reused = (fd >= 0);
>> +    }
>> +    if (fd < 0) {
>> +        fd = qemu_open(path, flags, errp);
>> +        if (fd >= 0) {
>> +            cpr_save_fd(name, id, fd);
>> +        }
>> +    }
>> +    return fd;
>> +}
>> +
>>   /*************************************************************************/
>>   #define CPR_STATE "CprState"
>>   
>> @@ -128,6 +161,11 @@ void cpr_set_incoming_mode(MigMode mode)
>>       incoming_mode = mode;
>>   }
>>   
>> +bool cpr_is_incoming(void)
>> +{
>> +    return incoming_mode != MIG_MODE_NONE;
>> +}
> 
> Maybe it'll be helpful to document either this function or incoming_mode;
> it's probably not yet obvious to most readers incoming_mode is only set to
> !NONE during a small window when VM loads.

OK, I'll add a function header comment.

>> +
>>   int cpr_state_save(MigrationChannel *channel, Error **errp)
>>   {
>>       int ret;
>> @@ -222,3 +260,9 @@ void cpr_state_close(void)
>>           cpr_state_file = NULL;
>>       }
>>   }
>> +
>> +bool cpr_needed_for_reuse(void *opaque)
>> +{
>> +    MigMode mode = migrate_mode();
> 
> Nit: can drop the var.

OK.

- Steve

> 
>> +    return mode == MIG_MODE_CPR_TRANSFER;
>> +}
>> -- 
>> 1.8.3.1
>>
> 



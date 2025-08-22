Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBE9CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 18:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upWTM-0007Z6-Ng; Fri, 22 Aug 2025 14:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1upWTJ-0007VU-QY
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 14:26:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1upWSz-0005ae-MY
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 14:26:40 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHWxH6028824;
 Fri, 22 Aug 2025 18:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=eQoCI0h1Gpg3aZMp58YPht033VKKV9Nb7jwL0jpdE3E=; b=
 K4pnAS3s0ynOTlvFQF3C+m+YZ5edSyIwqijp4NI9bdmOpk5trHXS5Ser/v4cr4au
 S9OxDlQNBOtC7YsVZ2ZJzVCDWLlT2YYWuA1KNtAoF3jUk1BfoVGT/8WyEqDzynlg
 0gka8a1TRHK+5dZfE6hrH6EZSqSzlLYVY79ygulO/BBRV+4OnJWr/z9sTg8BRy+Y
 U9mNvipoJNEHLgDCo+lRLkSu4+EqLvLG3rqqH6roHx0If1fLc/WX5B7vQ9ydi7RB
 zsT8R6A3+nClxQLdmhR+WoeSCq3/Hwwr1UVBSgVas3bbn4Tgn9D4E4J35mXPnWUt
 BKVO3t87WDOSDV8+Qog23A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48pw19g2tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Aug 2025 18:26:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57MH60ro020631; Fri, 22 Aug 2025 18:26:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48nj6hnpfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Aug 2025 18:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2VbPaFcqMSjmeOTICSQPZXkJH8QX8nl8c6a5fBVy0YDpIvcNJqGsDG/H4SIMXjS4+YF0Sk0kksiv3CRtJMYQXf4OXlyTLBICW/HOLCnq4UaMUZPoOf6wGe7pcK7GZeXnTCdhC8Cx6vo7NWsBGynWPzgKizMW2bX7H2cLvWl7EOPpdRZaWlswC0rt0mArM8u+6GtalaHqaP4x/2m91Z2Ulwj2rfIb+JYxv7YCjN04A42de2UQ42+Q2bpHW376Z08ymVaG5lb/WENVqCMepLUqjh9aaSM5a+3rJTtDieERvsdynLHbM+fUGw7PKcL/z9EQYjf+R+7+Rorg5WmU7cPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQoCI0h1Gpg3aZMp58YPht033VKKV9Nb7jwL0jpdE3E=;
 b=ENf6R3cq9N2dizdskLuKmx40JgQpK9rCpTpuVsEXcD/qz64vMxDmFswGkaoo4tuHBWVYQLyi2RAb4gQDAxTmx9tV6hULSY6npIz6+ckvcTEQ1t9Y96fPg5ATakZJtH83nKcXVtDKg2t2eu4/8092ApjimilQHQB2rH70kfhD+rAmyc68zGsVvP4W6W6S1BUdlRNXLP4F5/nXZa2tch6vFaicPzDy3+v721iUVkHyyp76vJT1I7aK0y9eZ7dYyvYDSFmBy4QDgBHVkDztX0Sd2tN4j5+7ucxP9ilVNfc+7yl/IXP4jsWSSvGU9ppQY1GHICLlu3J2POTp2xjGcxiYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQoCI0h1Gpg3aZMp58YPht033VKKV9Nb7jwL0jpdE3E=;
 b=jCek3VBrDKcF4Mwa76zBYKhEFQDXKsAUm9upL5yBApB6DoXYXaWCvTIb/7/+FqHlZy3Lg5RnlDq7Qdj5UKTXDD+PLzr0KC10ovcfaDiyXcorVMKlzb/Rxpw6YyRL0UGf2yCunIdY//P8ofRnXmUPAaYwHeVoaS83gWPwh2/Vclo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7226.namprd10.prod.outlook.com (2603:10b6:8:ed::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Fri, 22 Aug 2025 18:26:04 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 18:26:03 +0000
Message-ID: <cb0a2ce8-52c8-42fa-bbea-d90aae1f5a91@oracle.com>
Date: Fri, 22 Aug 2025 14:26:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "hamza.khan@nutanix.com" <hamza.khan@nutanix.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>,
 "Harnett, Dan" <dharnett@akamai.com>
References: <4370E749-04FF-4B85-BF6C-B24A3A3575DE@akamai.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <4370E749-04FF-4B85-BF6C-B24A3A3575DE@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0174.namprd03.prod.outlook.com
 (2603:10b6:208:32f::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 85028d71-9a4c-489e-d3c3-08dde1a95a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejhmNHRRcHR6RG8xWWttNDZOalQxUjRrbzZDVFNoNzFzK0ZvYnIyQnQ1TEFv?=
 =?utf-8?B?OTlTSjhxYTZqS2dsRlRyTFpXbGhYcDVxa0RHV2FqTDNjM0Q3bFBBa3dxVlRa?=
 =?utf-8?B?ZHZUREsvdGFtOC9BRHFFR2lIQ0NhL1lpclNCQXZvc3dZcWtmcm4veHZUai8v?=
 =?utf-8?B?ZTVXVzE5UTV5UnJ3c1RmNUVsM01yR2cwdVl6TjU2VEREaTB5ZlJmdVd3bm14?=
 =?utf-8?B?Y1pIcGUxN2pQbnVKcFZXaHUwTTZ3enNWRlVUeHFvN3M3VGhzZDR1eDBKeEpj?=
 =?utf-8?B?QWN6Q0tkZHdsVkNMdVRHUU1kYnV6dGw5eDJQaWl5WUdDZTZ2dUdJMUxNdlda?=
 =?utf-8?B?anNhenFCa21mdDYvc2hUL1VqZ3F6RlFQQTV6OUM5dWN5aHkzdU5CbEM0V3lQ?=
 =?utf-8?B?MncwRFQ1TTFhbU1KZ2xleXBwL2pFclJXZTJBOEJjL25JcFVWTExmbHdKR1d1?=
 =?utf-8?B?STFDbUVaWldNUU5mWkJ5V1BEb1RRSlBHR0J5OCtkS1RiOG5PNTRmWXR5Rzcz?=
 =?utf-8?B?cTNrRGFrN2o1aGR3akpMeGYzK1JkS1BBMjhLd3NnOWs0RkVacWd2bktHTDVm?=
 =?utf-8?B?VWJiQnEwK09lUHFvblQvNVhOTE5pVnR6Ukd1MklQZWFWcHg4dE4ycUVqR096?=
 =?utf-8?B?SHhMekxvbWZrRmJLcGQwRi9zOWIrdVRWV3greVJzRDBtWTUxaFBqeVM3NU5T?=
 =?utf-8?B?VVJ3Q2ZUOGlzS2hLOVNjZXhOT1VnYU9LMHEvcXZEZEljUjRyVExuZkU3cFJs?=
 =?utf-8?B?MjZ4M000TnY3S1g5eG9kbWlTQ2s5UHJHMk0wemRCRTVwcUlnNW9Hb0YrMHh2?=
 =?utf-8?B?b0RCbGVVUGdicndyN2tWc2NwY2VVR09wbVdqdVQxMXVrT3RPbDJCZDk4eHdR?=
 =?utf-8?B?N0l0aE14Q05zU3AzZm5UeDM4ekRvV296cnVNdXUxSWRFZ2pDQmphNEw4K09T?=
 =?utf-8?B?ZlU0ZUFCZm1tY2NGU25kMFhZcHRGVkMxMXZkTGJQWHhQSEd4MTE0MlNETTdz?=
 =?utf-8?B?N21lVFlIWXlwT2haaHdaNGFudVBvNWhqMkFpQTh1RTZpbksrUHhDYTJoVzI0?=
 =?utf-8?B?a085ZmRJRUlEbzhYRkVpcS9MVVp3bDh3RXo2ZWhNb2djbndwRFZFU2kyek40?=
 =?utf-8?B?dUZUNGNvVGpHRFZtSDBEZG42YmFmSUIwOEwycEFYWkNPSWd2ejhkMVdRdG5J?=
 =?utf-8?B?V2RhYk14VmowTmZkMDZGVWwwQXVPUFhZT3BsVllwd0RHZFB4QWFuL2M3eUpR?=
 =?utf-8?B?RmI3QjExSFd3YllzRkNjcTVzZ0NrMHVnNy9aWGM5L01jUXRGVG1wSEZXNUR3?=
 =?utf-8?B?eXIzZWNTYWdxb0tXK3c3bmlhUVBaYklHaUVWa04rbGcrTGdsczNzV3FIRE41?=
 =?utf-8?B?MnBsL3JUMkRqbkUzK0lsM05CemxKbGFONWJ4VmlJTVdCM3RmT2txSG9PWDBV?=
 =?utf-8?B?bXFtZGRTU0xSZkl5THVZd1N1aWhpckdUTWxpOFhmY0N6cTF3MnpqeTRNc0RP?=
 =?utf-8?B?Ni9sVC9sWVlmM3pFUkt3bVlZNWhDWldxUklZOTVaRzZacFhxVEVjVDdaYzd5?=
 =?utf-8?B?ZEo3bTc0bWZzaWxrSlJSRjI2VUlqSS9ua1FsZ21IbUpIaHZPcGsvdDVwU25m?=
 =?utf-8?B?TXZ1eng0dTIrOXhISXhDSnpNMGp5a3RLVmRKTU1OWjVGcXI1eVk5STdKbk1B?=
 =?utf-8?B?SG1GOFJpVWZxbGE2Z1JsS1JGdmwrbEtkOFFVMG4vamo3cWJ5ZEpNd2JZUXFY?=
 =?utf-8?B?N3gwVFBGZ1pUTkYzYi9zLzI5NjhybkVkZ3ZjaUwwNktpNE1IMm5GOVlCQ2tN?=
 =?utf-8?B?T2JJSGRhbitUdDd5QUZaRXR3WHhXak9QbjhrOFpJak96Tys3N1QxbGlZeXZs?=
 =?utf-8?B?akJDTnlNMm9xcURmRHY3Wjc5NVF2RGpXemZSSjdKeFJrMlZCNmFiUldRY1NJ?=
 =?utf-8?Q?SmnzEnQX1+s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE5taTZRREN4bk4zTU41VWNRYklEMStvYmYrV3N5NkhqOVhiak9tSHprRm5B?=
 =?utf-8?B?UGRCVDlHNmU5SE5Ld0dWZFhuKy9lbEdtdHhSRjVjbk8vOUhsNmhaNmpYQWlE?=
 =?utf-8?B?SUhhREQyZjB4VFhEWjlOSVJKV00wenp2VW1HS0RFY2VXSXVaSmpqQWVOVmtp?=
 =?utf-8?B?MERkdGF1RGdHbjZGemRibEtuaXVkOHZxRFhvSXhJWWN2dFJoWjkxbkVWUkkx?=
 =?utf-8?B?cE4xUlF3azF1MGxmVkgxeFNrRHhqVWlNaWpjL1B4YzlRdlorUkFCQnQ1cWdE?=
 =?utf-8?B?czNPWXg3eGgwaFo5b3hoM3diWHN2QlYwc3ZJS1ZyZkxMUm5SZndGUEl5bEFa?=
 =?utf-8?B?TzY5cExBcEc0RlFXZnJTZGMrNncrWCtUc2U4dWdvM2orL2hrMGJSKzlFQm80?=
 =?utf-8?B?Y2lYNGk2dHAvdHBxTWRuV0JpSWl4UlM1V0xCcG1tOU11ZmtRcmg0ODV0ZGdw?=
 =?utf-8?B?Y3hib2IwdEpqY2tSWExDWmU3NmJwMzAvdlBjczZIZTlaVGhKYTBtcHlIN3R6?=
 =?utf-8?B?RWFYTDlWbWkrbWp1VVdBQXpmcTNWNkw1V0VLUFNvMXh4aTRaTEtnYjAwMTZQ?=
 =?utf-8?B?QzAxL2JxeTl4cVI4NHdTUFRTcUxtNS82Qm5DRk51ZXIrQjdWN2RnV1dsVmZ1?=
 =?utf-8?B?bHhlOG1PRjk1VTBVV2FuVHJUWW43ckFaVW1jcWVnWERZMXhqNTFtMTRRelUr?=
 =?utf-8?B?eDlVZ0hza2t4UXRZcHdxMWNqcTNmcEVkS0NnaUFmSU5ZUElCZGVqNE5ZaVVp?=
 =?utf-8?B?OFZFT2JTWVBhbHhRUFpZNGxKcHlzc1ZwMXNnZDlyRlkxMmsycGhjbjI1ME9q?=
 =?utf-8?B?NVp2ZUQ5dzhNWG1OaEx5cElES3Nvb3VQMzdLWGxJc001Q0R4NFZXeUZqNS9X?=
 =?utf-8?B?TlNySmVBN2tHamZsYzk5TTJwaFFTbzBFZjA3b2dJTzFIYW1uRkg1WUpMNEJX?=
 =?utf-8?B?V0wrWWZ0VHlvTkdWaTQ0eGNUaml1SFN2bVRjV054aXpid0xicW8wNVJQNll3?=
 =?utf-8?B?cUJRSnJkUU5GdDdyTVo3U2pQMWZSZDVsak05ZlZRcVZIN3hTemNRK0IwM2FB?=
 =?utf-8?B?eVlOYjQwTE5JSmlEa1Y5bW9QRCtvelJqczJSYjBOUnU2UnhJczVscW1jN1JC?=
 =?utf-8?B?VS83aTQ2YkpTbEdDcU9VM2UvNDZkcWxMU09NcWFqUmVveGFySW9heFVaZnBp?=
 =?utf-8?B?Y2FxbHlFZnpRUnRHdlg2YnFoalp6bXhOckM4dldmSWdTWG5yZTZBZjZMOEU3?=
 =?utf-8?B?Y1pnblBtaHZOMnpET3Bsc2FJRDVEZ3VXcnN3OEpIOUVUY3NZZElRYUFZNVZ5?=
 =?utf-8?B?a0hLNDl4OTJkTllvQmNUemxWeXhyQU53d1lHQ0tST2VONGJINEV1VSs4dzB2?=
 =?utf-8?B?WmJLaTNLNDBma1EwcEVKVG5IaW1GWVoyVkJoMXI3c1EzQlhGSzF1SGJjdVZi?=
 =?utf-8?B?Zkk3SzgrdVFHcFdSNFZURGZrS2UrdmhieW5pRGtZb0EzQkJ6ckZUc1BLcDND?=
 =?utf-8?B?TEttOGtSbjhyWm5HMy9xbFRsVXdrZGpEbmZZNlB1YXh1MEYzenNVcWpyUW9t?=
 =?utf-8?B?NDFyOW56c29MdlZETGVmcnJESy9DUm9Ua0RBcXFITEtjenh3bUsyQXdEQllu?=
 =?utf-8?B?ZXFBMGZYbVg0NlY2bTBwZTZhWE9VRk1tR1g2NXJBa1QxdWt2ZVZKZktCQy9r?=
 =?utf-8?B?dGQ4YXJRVU9LL3pRSzhjMzRSOVpXS2lUS1pxUWJ3emlUQzVraEE4cjkzYVk0?=
 =?utf-8?B?dUVrRDZXaWwyVEltZE1vQmprWjl6dmJkRm1yeklMNThtb2RWeW4rS1NYNUNS?=
 =?utf-8?B?SXFsWXV1dkdPaTRCNGtIQzlmYkpqNk51S2ZtdUpveksrVkZiWXVrd3hMV3h5?=
 =?utf-8?B?ZVA3Mk1vUWwvYWJSRTUzejFaRlovZXBRVzAvZktGL2NMV2lORGdnQ0RUVUp4?=
 =?utf-8?B?N0pNTG9NSTZhM20wOVZYZlpDNW5ReHNwWk9GTitGaVBpaGNGUkVxdy9CUFZI?=
 =?utf-8?B?c2RRSnFvVE82V0tFbHB2SHZNMkk3Y1A5WUtWdWNwdUh6dERLS1AxNHNPNHY5?=
 =?utf-8?B?cFhQaU9nZ0RGVkJ4c2lET1JBdTV2clJnVzBPL3Z4RERJc2hGZEREbUV5U3Ja?=
 =?utf-8?B?eEVDOENkUVNnbVFxQXZ4MWdzRmY2VWIrVDFXM25qMTFYb29lQXROekNYY2Uy?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fswrj8Wf03aPiUplH/R+pUkg7KgkNxymdwXEepLg0oSh0V5VIYgKUPyo/7yM9cJt7Nj+uzvJlVEJjZstphPxQxk+Uy5UfYcDl1V40/PJw2/ThXiBR2AQM81UADFwZKTEQsn3IfBHIiOPiS+WfgqrOLuv9tfVsV5+Xt+sxx9yKKQhMDhAeXSdt8s3g8NtAeQJjYHQPjTxTfOdel5cHHWI8DMmjSCu19bpy0YE8qGMuVWykji29W58IrNlvQQXGAjaSgD67SiRa3eVUv3S0xkxTLAk8CiKAD137dfxgwyCJ8eU72kG93r/fJT6WMMpz9DeIiryvCNJDB7esPYU/Uth+BLnqveiSTKuXc9oMExEGRMf4BnirTX2CfIDxlh4gJzpS63Pa4Du1K/gkU7vkoI3v4QmovG0YdoAkuq3z2sTOPRSJbJChwldohby0r5+t/TNMP6k6AGEQjsGOEczfDO/1FAivtiQdrc4vXTkkxmPmFzsxEbUuthJ+IOgW+oF9r/Wvc+8MlxrYPo1tIBipxUkHr/HWulpqHGvhIvIhJqdjph+E50HLVQ0MI84/8DNGOJtt1S0RYkI4GCJLxku6TORI8Y9foYilr/3Ps58xN9MRUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85028d71-9a4c-489e-d3c3-08dde1a95a55
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:26:03.9077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qP/f65vcmv/JeG68YGMSmVWkdxUabz+7nnNqk9o6YvMTeRwlbU17feMdr9O2F/EK44QzgKqXJByvwxwhu1jhBdU86ZdTvQ9fpEWW6r8/3gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508220169
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MCBTYWx0ZWRfX0kpV5+J8rwew
 UpzEoy+zIfWve+S6qn538J9LNbs8DxL2r5LJOmYl3Lgax+v6ZiGSgpSmOOrGSzCxGR+ISZUPeDj
 50Y9CqaY45motXQ4a8yigeLV/0+S4XPSpAWZAqNoJeyCsj2AHR8qjuH9panvfki9e2CZ9OwHTL/
 n6hZpADSQJN0ZiOLqkuKiU3hxt+yEkZi5VIc09wWVpi/7wBr2/PK46bIzb9OS36DQ3oR6GF36gP
 lmK/ZknVmmwK6id/wiRouHt48Ncof6wew4y1D6Ms9TrwdWHICHzj/lLvOc8JpRYrJx+4Rc9THmB
 BBaFABjWtfEIvMXyxuL7AwmV3a4RC5WsX+XXMMKgAEbwu/cgeJFQTf700bOhZHvTJUSTLuyHDu9
 kXV1LSCNQpjdKFGKMEzen538nowl9A==
X-Proofpoint-GUID: 55jL4atSfX-wkhchS1GvvvDPBzWFrs86
X-Proofpoint-ORIG-GUID: 55jL4atSfX-wkhchS1GvvvDPBzWFrs86
X-Authority-Analysis: v=2.4 cv=EvbSrTcA c=1 sm=1 tr=0 ts=68a8b63f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=X7Ea-ya5AAAA:8
 a=yPCof4ZbAAAA:8 a=vCS72e2poOd6JONaoK0A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12069
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 8/18/2025 11:04 AM, Chaney, Ben wrote:
>   steven.sistare@oracle.comFrom: Steve Sistare <steven.sistare@oracle.com <mailto:steven.sistare@oracle.com>
> 
>> Tap and vhost devices can be preserved during cpr-transfer using
>> traditional live migration methods, wherein the management layer
>> creates new interfaces for the target and fiddles with 'ip link'
>> to deactivate the old interface and activate the new.
> 
>> However, CPR can simply send the file descriptors to new QEMU,
>> with no special management actions required. The user enables
>> this behavior by specifing '-netdev tap,cpr=on'. The default
>> is cpr=off.
> 
> 
> Hi Steve,
> 
> Thank you for sending this patch set I tried testing it, and
> the migration fails with the following error on the destination:
> 
> 
> 2025-08-07T18:14:30.564323Z qemu-system-x86_64: could not disable queue
> qemu-system-x86_64: ../hw/net/virtio-net.c:767: virtio_net_set_queue_pairs: Assertion `!r' failed.
> 
> 
> And the following error on the source:
> 
> vhost_reset_device failed: Operation not permitted (1)
> vhost_reset_device failed: Operation not permitted (1)
> 2025-08-15T14:50:16.028494Z qemu-system-x86_64: Failed to connect to 'main.sock': Connection refused
> 2025-08-15T14:50:16.028552Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028565Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028578Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028590Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028604Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028629Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028641Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028844Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028856Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028868Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028880Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028893Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028904Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028916Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 2025-08-15T14:50:16.028928Z qemu-system-x86_64: vhost_set_owner failed: Device or resource busy (16)
> 
> I suspect the issue may be related to the fact that we are dropping
> privileges (-run-with user=$USERNAME) as cpr transfer has run
> into other issues with that in the past, but I haven't found anything
> concrete there yet.
> 
> Some other information:
> 
> The full qemu arguments used for networking are:
> 
> -netdev tap,id=net0,ifname=tap.79874411_0,script=no,downscript=no,vhost=on,queues=8,cpr=on
> -device virtio-net-pci,netdev=net0,id=netpci0,mac=$mac1,vectors=18,mq=on
> -netdev tap,id=net1,ifname=tap.79874411_1,script=no,downscript=no,vhost=on,queues=8,cpr=on
> -device virtio-net-pci,netdev=net1,id=netpci1,mac=$mac2,vectors=18,mq=on
> 
> I applied your patch on top of 7136352b40631b058dd0fe731a0d404e761e799f
> I also applied the pending arm interrupt fix

Thanks very much Ben!  CPR for vhost is completely broken.  I did not notice
in my testing because the "falling back on userspace virtio" code maintains
connectivity to the guest.

I will reply to "[RFC V2 5/8] Revert "vhost-backend: remove vhost_kernel_reset_device()"
and post a replacement patch which fixes the set/reset owner failures, then the remaining
calls should work.

To use run-with, you will also need the patch that you posted for setting
the owner in unix_listen_saddr, before change_process_uid is called:
   https://lore.kernel.org/qemu-devel/3D32B62F-29E2-4470-86A5-9A2B3B29E371@akamai.com/

- Steve



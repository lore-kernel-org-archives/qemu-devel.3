Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DECE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDUg-0008Te-7P; Mon, 16 Dec 2024 10:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNDUe-0008TV-Vh
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:58:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNDUc-0005DF-Ds
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:58:48 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEttRV014143;
 Mon, 16 Dec 2024 15:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=45G5yr3gOZCWgdNwyTt+uyVU4NYfeBgUZTuUFYmsTaw=; b=
 VEoDAIRL1vHntgSh6vl99KAqiCKjelDnslqSsLmouZKJ9ZeWbQCH9iBRmesawol2
 J74msbqnWBA72A2yPhRZs3HmP0wlzsLEfn9h7WKMUibgnNm0z8UJaBhWeX4816Gf
 gBh1iAR6Aa494vEsILYwQF2WUdx51dWRcOagySwPxb5JaLRGgQsIVqRpWRcp8pwg
 Xyp+tWek7q/okP/MlU4USZOBD3qUIt9XIupGyzRY4zm7nCnO+cuuGE5vI8yFbYWK
 fc1TL60YhLKc40Xspm2ziC3J8CAAw2V7jw0EWD7G5aciLbi2m0nTpYxV6vDCfiCx
 GD66Y4Ytz/d3RUPdp2G7DA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt3h89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 15:58:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGFPX9X010895; Mon, 16 Dec 2024 15:58:43 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f75vf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 15:58:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apgmfN8LLLmbCtk+OjhfQzgMdA4ntvqL7OoTCtytpSValVivaVm+nOav4O7g7eXCXf+QO5hhetJ3mx732tYtMAWRA4L9ZCGrpv4epidFLDTyt3lDG39OEfHpyq6D92zLfy562zld4H39Rk0mTkEWn80folY0NzMTxz+56c7KoK4u73UYuXWaqsEcIG3vF0e+5JBfoJGu33hUhhpzWDDhs6KHQk2ZPlFKuB3m7uabB6bYKjR87mkKept/24EfVHWrE4DRVZl9jLHu75uqX0pvepk082ZntIP5lt77WNACXKEX3Uagdd9tO2MA1fbSlfY7PUuYIkGZKiUfQqah+zqkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45G5yr3gOZCWgdNwyTt+uyVU4NYfeBgUZTuUFYmsTaw=;
 b=xr4UDUQgX0cVwbz6redmKkkIipaMPBl1lvZPZwCAipZUVEvIDiineXzD4tOFYvrgSCbCAT+bFBA91QWzWHiBSf53YU1FkUuGvAhXkAzuwQIWTXKTLRdTSeDEnWn4wr/2GvXQEqhUbxYG1i9GojeEWrUkM0+t7iXdvYY/1sYJmwaEDlU9RSmux49jYkHS+Tk/DHQa+XQXGC6b6Up1sAmmVL1KhnITM+zNubbuslxfCIJxJXVC7Vhnf9WpzCnDXBmfJyCOmjDBqxHTIhETxzMsXijIkalyIXDaRSTmIZa+cS/vaiUsi3vX6nSuV/RxeboOHzNZ41iKVmOH63WXgM7P8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45G5yr3gOZCWgdNwyTt+uyVU4NYfeBgUZTuUFYmsTaw=;
 b=MVK0XuVtBcw0mRBHGlAnTzedNeS24VYBD0bInKMXNuXrWqARymD8rEXRmDYHGUceUC0YA/AQu69XrAk+r1rFmYgjQiJVmYPTwyEmQnvkoZ0qAutu6jjWMU78YcqMKI4UjJMB0aZkQ1ZgUfr6nofkUDk170bOMNgyzyNXdTaaBv4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Mon, 16 Dec 2024 15:58:28 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:58:28 +0000
Message-ID: <4741b80f-cdf6-4e43-8bae-f3604e858200@oracle.com>
Date: Mon, 16 Dec 2024 15:58:20 +0000
Subject: Re: [PATCH 3/9] vfio/migration: Refactor
 vfio_devices_all_running_and_mig_active() logic
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-4-avihaih@nvidia.com>
 <14070e26-ef99-4a6c-b3ba-ef910270856d@oracle.com>
 <63082412-a42f-42b9-88f5-8e40a8f28c8b@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <63082412-a42f-42b9-88f5-8e40a8f28c8b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0308.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::7) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS7PR10MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ed325e-22c3-42c2-2750-08dd1dea7aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFNIUEFzREM2UUF1QUZ4N1dkVFhxcDh1SXdSYjIxNXFmMmUwbmw5TkNQYms0?=
 =?utf-8?B?OEpJeDFkVnNrcndQQWtDSUFvRVVQWDNzeWJ1dElGd0hCeS9UTWMrTC8wWHYw?=
 =?utf-8?B?VlZXVkVlRm1hK0NUT3YxVU90NjRiK2Zsc0xmSExxb2JXM0E0NjJNSjFkVG02?=
 =?utf-8?B?djJJcVZWUWI3b2xFYWxGbWlPWk5uY2hIZFpSN3RBRzVab1lUZjhmM2lEcmkv?=
 =?utf-8?B?NWplMlBDRGpmNEQyYk1GMGk3ZDkvcHBsTkh0VnRlY3IzbU1PV3FEUWVKSE5i?=
 =?utf-8?B?dHN6NElzZjRQa0RBaE5rTTR1VXdWSUJGcHg4NW12L3RrL3RicWZTZHdhUmFH?=
 =?utf-8?B?bGxaQnJTWmZZYjljdlArd09rWHZseUxWdmZySjI5YzExU01rS0NtUEVUK2ph?=
 =?utf-8?B?YVBwZC90UStJM2VQY2NPTi9CU1M0Q1FScVlYSi92WWpEaG1WaDU4VUNBbVVU?=
 =?utf-8?B?TEVTZFo0N1NDVU43cFMvMG0rR0JaYkljVzBqU3B6aTV1V0ZFVW5MZXJOczNj?=
 =?utf-8?B?UG9mWURGbzI3ZHZPQTgvaHdPVmFFRE1KSTBTdC9DanZiZmhXNW1ZSXhHSUVW?=
 =?utf-8?B?SzBKZXdhQWVxdkl4eXArWS8rY2NhR09OZVZ0aEppVE1UYVQzUGpGTTE1dnQ0?=
 =?utf-8?B?eVcyeGd5RXB0RU0vTENvUWg3bEdiU0poS2xXTTF0TWpVOVZhcXlhei9XaWVs?=
 =?utf-8?B?cS9GY3cwT2NiMk9CQlU4YzcvbUYvU1MwbThpSGtEV0FJaXlTb3cwYlJrakZm?=
 =?utf-8?B?bGpHenBjaXBZcHlCaXE5MVpxQ1RkRXlXZDY2SzI5SXhJa05vOHloTnNVNmNu?=
 =?utf-8?B?TzQ2dmxtbVVvNzZISXlmeGlvWHMrZk1MdWRBeUFZajVOZ1VtZHBpakQzczFH?=
 =?utf-8?B?bTJKWlZXT0dBaE1vS0M2bFRJODg5ejBvRW53QStVcXRsZHJpRzlxa0trdjVV?=
 =?utf-8?B?M2tvN2dxZStpcWJsOUZlUG9XYkNhSk84WEJHck1PanpyQTRZWVRQTU51dU9Q?=
 =?utf-8?B?RXNsR3ZIc09oSU95bTNNWGhZVitBNGNjd293Lzg4aEh1enZkNVBFVG1OcEU2?=
 =?utf-8?B?NUZGUWh1RWdBQU1mQnJjTzg4blVIQTRyOURraFZMSWU1cnZhd2JVNkhNdUhy?=
 =?utf-8?B?ejJIQ3dhZ0xkdGNyeVJ0Q0EveWwxb3NrZnVheHMrMGI2ZnZDRGJTa3JxYUFr?=
 =?utf-8?B?elI1ZDVEZjB1dDh3b2E0SkRTZDMwUEtKSnNrRUVVY2owUjVwUWFBV1NGcDRX?=
 =?utf-8?B?S0I3aEk2bDBBbTJoZ29wL244UDJ6T0lmbXVsWUlmeG4ycFRmc1B3VXI1V2tY?=
 =?utf-8?B?QnBhelFyY0tOWWlReXBTc1hSVWVIWWdiNHc4bWl0cEdSWlZoZ2xtV2RPMk9R?=
 =?utf-8?B?RkhYa01vWlEvUUlXNzNnSTJzejRnQ25yZGJ1dHJER0VBSFBKSVVJZTN6T1hM?=
 =?utf-8?B?aFVLU3M5eEJvNEpFUy9EVnZPMGdOU0xTSUVRQVJWTlJ5R3VYL0JuME12dGRL?=
 =?utf-8?B?VytYaFVBZzNQQ0xmeHd4ODZVWGFvR09oTFJuMzY0L2hiNTBEbHMwV3g2OXlE?=
 =?utf-8?B?dXBHaG1aS2NxbGtOLzVKczBJNnFpUHZiSC94REwyejdmeldraXVWV2hlbjVt?=
 =?utf-8?B?R01OZjZhTmZCWm9xZUJHczJmK3Y5NUdXVkpWL1F3MzVXTHpJQ2twNFY5dHpu?=
 =?utf-8?B?S042WXk4UWJXSVc3cTZtNTFoa2hqZTk3WitFa1RVd1Bha1ZYL0t4R09neXRM?=
 =?utf-8?B?ODJ5SkJ4K1lobUFBMGtxL3lJUHlZa1JmZmVwL0ZRVFlkeTM3TGJGVFE0ZkZn?=
 =?utf-8?B?cGRoSTdEMEhEdUFZU0pWbHJCZGdKY2t0MTBxdHhmWVoyTVp1VVJqZkJrZk9n?=
 =?utf-8?Q?AJE6TdDSaKmvi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDVGOS83bUR6cVBqYmhySHRpbzk2UDFJMjdGMEFNUkRLcmlidjk2RzkzME9Y?=
 =?utf-8?B?bVpHRXk4WTBJU2VjNVpXWDZ4TVpNUnJ4SGgyVjF2b2lhMjJNTWlhNWQ1N3FX?=
 =?utf-8?B?WE9kVXZSRys3alhsWlRGS3B4Q1MxNFF4ajkwcTB0aitWdFFjZlNIS1k5VE9o?=
 =?utf-8?B?bWd2TUc3VmtWUGJIOFNNODJWNlVDV2FSL1JldHVwSzdJMDIrazVhZzBpUzZ5?=
 =?utf-8?B?Z0xXY0xZTnJPbXhUdjJPd2lZZGVtcWxNUVo4RkVBWDU4U0N3VlpRbDlURVBD?=
 =?utf-8?B?cyt2YTRRVzAxeWVGb0RLQzhlTlB3aHVveHo2eFZNdWZNbHdTQmhDNDZQWTlm?=
 =?utf-8?B?MS9xYnNWR29POW1KNHFZT0VzR2t4K1FsM2l4SHpZblpvL21udk8rU2ltVjdC?=
 =?utf-8?B?ck15QVRESVpxWnVNdk5IOUhneUtaQng4bmMyUEd6RkNFanlwT1JSRnRBamNK?=
 =?utf-8?B?UjQ0L25jdno4QVd1QTNjSU84UzhxL0tadjFaTjFXbjY4d1ErMHJyc051M0pz?=
 =?utf-8?B?K3djcGVNZERPS0NaVXhzbXFVdVFNQzJDSm8xd001K2dueHRoeXQvOXZDSTNN?=
 =?utf-8?B?elJFQWVvWW5ySTBFMFJLQjBXcFpIYUJwVGNYbDdVQ21GcExjNFJrZENIeGpI?=
 =?utf-8?B?Sk9pRzRXZnQ5VWtpalJUR2pGbU9CNnJJVHRDWmp5Y280R1ZBS3JMeS9hWlZE?=
 =?utf-8?B?SHZPN0U4SUxPY1A2YnBJUVRkMGJzNVd0YytMZk16TUhGR2FwdGxOY0RsQW5o?=
 =?utf-8?B?NE5KQkQxcDY2dHJ4NjE3bHpObm5TczRTQ1VIejlTc2NpZ1EyRzZSQjY0UkVY?=
 =?utf-8?B?WUNoMGJ5NFIydDcxVFROdzQ4ZFVNMFFEVGE4dEJkNUcxU0JrbmxpWCt4UEJ5?=
 =?utf-8?B?eUt1NXoyL3gzaXhMcTYvZDdDenMvRU1XeS9KZGtuUUVnK2s5TWpZcDZyMTV5?=
 =?utf-8?B?cTVtTXMvRVhIaFBvMnpzZHBJYnlKYzN2cTVvV3ZEWU5Gdm54dCtST0Jxc0JD?=
 =?utf-8?B?ZTdwMlZsSHluTVpaQlBQRlZtV0hZNTB2dXpnWGV3V3RjT3U3UmF1U2lUWkx6?=
 =?utf-8?B?dFlsRkE4ZmN3R1hqOXB1VGJVUkJHNjR3SmxkVFVOUkRKQ2pHNWt2TDV2MFg4?=
 =?utf-8?B?ZFNZUUN0bG5RTHB5clh1aHJmSHVwWThwZGlHVVBjMnJnQjVMMDMvSWx0Q2tX?=
 =?utf-8?B?bFJJaVJ2RlR2b0pDRm9IelJ5U0xiamJsQW0rcHNDNzdjOWpKMjFueW43Qm5K?=
 =?utf-8?B?aWNBSmRPUVFpY1lJK2YreHhRVWcyQ05hMUxOTHRjUW5rd3dGUU5qQzFMcThY?=
 =?utf-8?B?ZERNbWU5ZVZEWlk3cXQ1M2o0OXNLMjlkbk9yUWp6aVczMVh5eC95bk9DdURV?=
 =?utf-8?B?TzNRZGkvQ0M5OHhBMGlva3pMbE5ZT1Vrc082eCtXUGZOZ0Z5R2g5WDVOdHpW?=
 =?utf-8?B?U0p3U0UyL2dxREpZd1RHNmp2Mm9zYW8wbVRIMkRTSXZvVDBhMHFaL0w2TUhC?=
 =?utf-8?B?MHBkZndPQUlOMWhsYmZ5YVlZeEpQVDF2WnErNlpmMkUydkh1cHRFSnkvd0cw?=
 =?utf-8?B?ODAwSUtPYmM1Q05FR1NFUittZWFpVjI3Q2JhZmE4UVVBYVN4c2VkUHRyUnNR?=
 =?utf-8?B?RTJnSHNUOThMaWpWMVJ1L3d4YkZuTVYwUjFaQXZaem5QRlpkNkNRVkxqK2h2?=
 =?utf-8?B?RVVPMXpxb2RiaXhxZ3Y3V09QYkEwV3VJV0htYnFobXQ4bk9QelR5ZnZpU3Rp?=
 =?utf-8?B?L1MyMGZiUTU1dEVUQTRqYStyakpZSkpSaStxKy9LNUkzNHpUVDQ5MjNtTGRy?=
 =?utf-8?B?NTBLNDF2bWZEMGk3c2pzVDU0RzNHRGluL29FdURCeWFLazNPSnpHczdMRDkv?=
 =?utf-8?B?bWRCeElrNEdsenM0a3p3dW1UOEE4UGFMNDFZeE5OR2dBV0ovYTZ6TTRuQWxr?=
 =?utf-8?B?VFlPWWZHWTN6bUZ6SUwyY2h1cUt2RzRqcDVZQlFNdWVSbFVvNXJuNTlTSjg4?=
 =?utf-8?B?VzNDV0FOQjdKS2ZSa1BheHNocU8vOWlHZ0c1dDV0VzEwTmY0cGo3eDBWc2xm?=
 =?utf-8?B?RTVuTXJ0Zlc5R05CMTJIdk9TTlhKeENtYS9jSUxuRnkrYldUYURNS3FLV1M0?=
 =?utf-8?B?dkRaOGg4U2FvUVA4WHZpTC9uRjVmSGhvcHl6QldJdmYvSWtCbFkyVkZsQ2FL?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qwxztLqfchtuJ01Jq9hIJqACaw/aIETT2F2TxInYMMbyNfYCbvYIiX8ZVFB82BLDGKnyO7KZxougeAoNhQl5jf2QSfyjcwx6Z1YfGZcr8or01BVhEjqFCXUD8y4CYsErNC8XEAwnSBHZT9m187meMTBxTeb7iNayI+5Z/JdZC5XO+XhdWE/rUfz7Wyg6Zm5EmX5RYeELulyb2n1VT2DCMrLlq3SIsu1OzX9fKRBj1FFz8fXU5+e9/2IGvEygY9AYZThvIMQdYV/uB2d7J6+cdN99/lspx4t5k3FQmdMNr01LOPMKUrmNTWl0I3XavEAR9zJIB4/wPI6OrW19drjqHmmAmJ0bNgS7lSIeYoN97dN9VgVRtA40bDTUFC5PMbb/pp08Lg8lT+4Yj1gRArfXUJw6bTVOPkIEac+fh0zNnRc45IYvmuBvI+bv3lWbHSyZE+7hEl139xNr631GtGAitFprE5eGAIAtVqJsNzWVSlux/Jak3B9rROGk7N4Ani98iEzOQ4/F/WBOJ+voz2qBUOx5k7eDL+d7OBtRuT0P3imPJeguyTOfmSHk6DzFS2/k8deK9d/ekqTuaeqn1lUDJ3rCTpT5Pm6N3RTglAa2uNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ed325e-22c3-42c2-2750-08dd1dea7aef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:58:28.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sz+iH6PxajE/4Ss7sXOT78vYBZvo4D4ejwSsPRQvalBjmsJ6FJsP/kj61T7ysN+QSlfIgLwyoPIIBk2JKdhm5B/GmjclYIi2z/Wcl6J+qTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_07,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160133
X-Proofpoint-GUID: BCkZ5ySZ2g5If3c5kslvYY5LXwhorbaS
X-Proofpoint-ORIG-GUID: BCkZ5ySZ2g5If3c5kslvYY5LXwhorbaS
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.13,
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

On 16/12/2024 14:55, Avihai Horon wrote:
> 
> On 16/12/2024 14:45, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 16/12/2024 09:46, Avihai Horon wrote:
>>> During DMA unmap with vIOMMU, vfio_devices_all_running_and_mig_active()
>>> is used to check whether a dirty page log sync of the unmapped pages is
>>> required. Such log sync is needed during migration pre-copy phase, and
>>> the current logic detects it by checking if migration is active and if
>>> the VFIO devices are running.
>>>
>>> However, recently there has been an effort to simplify the migration
>>> status API and reduce it to a single migration_is_running() function.
>>>
>>> To accommodate this, refactor vfio_devices_all_running_and_mig_active()
>>> logic so it won't use migration_is_active().
>>>
>>> Do it by modifying the logic to check if migration is running and dirty
>>> tracking has been started. This should be equivalent to the previous
>>> logic because when the guest is stopped there shouldn't be DMA unmaps
>>> coming from it. Also rename the function properly.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>   include/hw/vfio/vfio-common.h |  3 +--
>>>   hw/vfio/common.c              | 28 ++++------------------------
>>>   hw/vfio/container.c           |  2 +-
>>>   3 files changed, 6 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index e0ce6ec3a9..c23ca34871 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -296,8 +296,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error
>>> **errp);
>>>   void vfio_migration_exit(VFIODevice *vbasedev);
>>>
>>>   int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
>>> -bool
>>> -vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
>>> +bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer);
>>>   bool
>>>   vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>>>   int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index a99796403e..81fba81a6f 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -229,34 +229,14 @@ bool vfio_devices_all_device_dirty_tracking(const
>>> VFIOContainerBase *bcontainer)
>>>       return true;
>>>   }
>>>
>>> -/*
>>> - * Check if all VFIO devices are running and migration is active, which is
>>> - * essentially equivalent to the migration being in pre-copy phase.
>>> - */
>>> -bool
>>> -vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
>>> +bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
>>>   {
>>> -    VFIODevice *vbasedev;
>>> -
>>> -    if (!migration_is_active()) {
>>> +    if (!migration_is_running()) {
>>>           return false;
>>>       }
>>>
>>> -    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>>> -        VFIOMigration *migration = vbasedev->migration;
>>> -
>>> -        if (!migration) {
>>> -            return false;
>>> -        }
>>> -
>>> -        if (vfio_device_state_is_running(vbasedev) ||
>>> -            vfio_device_state_is_precopy(vbasedev)) {
>>> -            continue;
>>> -        } else {
>>> -            return false;
>>> -        }
>> Functionally the change implies that even if non-migratable VFIO devices behind
>> IOMMUs with dirty tracking would still sync DMA bitmap. I think this is OK as it
>> increases the coverage for calc-dirty-rate (provided my comment in an earlier
>> patch) such that if you try to get a dirty rate included the IOMMU invalidations
>> marking the bits accordingly.
> 
> We still have the "if (!migration_is_running())" check above, so non-migratable
> VFIO devices won't sync.
> But that's a valid point for when we'll allow VFIO log syncs for clac-dirty-rate.
> 

It's the other way around :) This change helps calc-dirty-rate because you can
use it and still account for DMA unmap based dirties.

migration_is_running just stops logs if migration is not running. And that
doesn't care about VFIO migation support.

But if migration is running, whether the device supports migration or not... it
will still sync for pages. It won't sync if it has no VF dirty tracking, but
there's still the container dirty tracker.

Whereby previously, you skip checking all together if the VFIO migration state
wasn't initialized and the VF was not in the right VF device-state.


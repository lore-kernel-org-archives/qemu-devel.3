Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30093C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 19:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFdwp-0005tH-EO; Thu, 15 May 2025 15:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFdwl-0005ro-CQ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:08:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFdwi-000562-Gb
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:08:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1oxq006301;
 Thu, 15 May 2025 19:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=W2u9qlZcpwKvx+F80C5rMIuJzq2mnIFB1I94ZsPPodc=; b=
 ROzx18zc/Kn/4d1hEnIrqb/7/pu33o0Q/KULog0koy1cK9kVnY+Hi4BTyfGZzKo6
 hWIdLe0/7mYx4LpSXXCoWB5gxxuxNUefyuvQnVckVoQtxkkFvuJ1p0mgXBdMXWdA
 3+OYIeewVgdoU7w7IL/uD0rOw8v6nUrQACGe7rs4aymRxdxXzNp88VdcQaWtb0Th
 V0t8AKe1Fyq2l1iDmw5sFUeh1ZSzt6eeL0JfUXjzT7mIiHUH1GT3+B2Oij3BNr+U
 +Ogrf5LLr+hNG4J797grO6x30Ar8ctKLGvGWFWWYMNuI74Xt6VCma6AHicZvfFMp
 baQGyoMlZGRxiKxGFbmImA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcgvy56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:08:39 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54FIpupd004344; Thu, 15 May 2025 19:08:38 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010003.outbound.protection.outlook.com [40.93.1.3])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46mrmegyke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki8THB0QBRrEji5NJd4IcTMzn2Iq4AWULAPR/gkSwhSgVM6SSxjBKmlaz/7yn80yM8Yq4alaxrtp/Bn3DhGax5RMUua8wwoQ7BYscXzDtb8VI5vEVucwD4PHxy+grikfdBCeCUWNLH3H3RPW/AWTfAwB3T+16b7PlCK2tzn3KLUuOIvOMmyqvKk9dq6puuYkd/FKJ2+sQlQdZFKIaWOoNz+mFgpWUwluJCzZkedyoedDG5kBykaz2VQLaDc0044nlmWB66QGS6W0pz99ENGA8s/LlrNRoKZQZh9z8RB+sM+Cp1+HjWhU1ZZTVD9tDerR0c34zk+sVqXqWOOrcb67JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2u9qlZcpwKvx+F80C5rMIuJzq2mnIFB1I94ZsPPodc=;
 b=vOY8RKs1cCqVmMVDl8sPUVLsk7rrIh0UCMbT3SRrhlC9w4d/s0w0F0XQxt397bdHPlu09mmRBxRnvodqt0lfRZcOi3jIyaxyz6bzKtMRVYX8V/udvyNrUru19JsSBlzh52R34G+N038qjH25jDc9KfKHh+RyQK/JVO2C5j8zTshd+uPKt/IXoYOuRrhx+0CWUnqrcjRgEAVhqAny1VUMxgrOo18iVWWkhTQOBwKXUmVHFkLAmHwpyoNxI7E0J5iLE9QrWf1F2CEZzEPCJEirRpe7gfnq53Ff+IIijMR9TuigmajXdzNAdsyTUIO69gavkyosvEiyjnjeBHIIpUPwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2u9qlZcpwKvx+F80C5rMIuJzq2mnIFB1I94ZsPPodc=;
 b=SGuc0p7PsKdggTRBBo7S+esMlssjF2NHy5wRT21+68g7+w/GzoR4qkzNa7DQMfJCf+gsxFAEg+R3hPQBr9FGPCQNJjkzZqoevtBUkmQ4ipSntcHql5jNsC4NZy9uWHq0sgZfWY9l5weJSs3w4wwxgzV6x9ET5yXdS8bx2emN908=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 15 May
 2025 19:08:22 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 19:08:22 +0000
Message-ID: <8a2d690b-c49f-4ee0-8887-b0f7c438c3a0@oracle.com>
Date: Thu, 15 May 2025 15:08:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 07/42] vfio/container: preserve descriptors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-8-git-send-email-steven.sistare@oracle.com>
 <90ee0578-44f7-4e42-b69e-934833199eaf@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <90ee0578-44f7-4e42-b69e-934833199eaf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0875.namprd03.prod.outlook.com
 (2603:10b6:408:13c::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e300d1-a23d-4792-e5d8-08dd93e3dc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2VUWW92bjYwaERzSk5ueExQY0VMNWJVeDZsbUg2a0xUVGVLdkVBUlBQNktZ?=
 =?utf-8?B?dlA0TWRtZWg5WTVUY2hSbTh5cGdPUmlQcDMxOW1QMWZselRLTit2VFdpaDB4?=
 =?utf-8?B?SGhhcHpiN0lPVHdWdDNMYTF6MmpUSEIvbTNtVC9xV3l6SmdCbkNxSlpjSjFG?=
 =?utf-8?B?OXl6ekZ0bnFYS09KZGMzNWoxMEwreVpMRFMvQjN1NHFuaS85bHI0Rk5lNlE4?=
 =?utf-8?B?RGFlTWd4YXNNdy9GcGpYeUlvcmRtVEdKN3htZityYjlydGV5VWNuUWhYLzd4?=
 =?utf-8?B?ekdoWjEyODlUUzRYajd0Q3kwdzdmYStwbTdKb0lZMFFRYzVGL2FaandHRFU5?=
 =?utf-8?B?VEhGRXFTOUVKU1pnTDA1a0dnZ3NMZVpLamhrZWtKZDRTcHd1MTIvUW9aY3lv?=
 =?utf-8?B?QytEY0J0TjRNd2pKSlFpZlpIem8xanlWTU1tMGJhU0Q5eG5aWnl1OGhNakty?=
 =?utf-8?B?OCt3UTVHb1FORXdMdk04QzRkZWpGNWg1d2FvdVZINjVpajRpcGQ0anY0Zk1o?=
 =?utf-8?B?WnlVT1Rxbm9CYWpYS1JOSzNVc29RT2o3RlNSd2o5YmIwVUprRWJQaktudUo4?=
 =?utf-8?B?QWhEcCs3bGcwdEpyQXBWeWM0VFdnNzBRYjZIZGIxM250azhMZTFCZjhnUTVy?=
 =?utf-8?B?QzRhdXNMSk9pSlFuTGNxaWdhZTFwYS9DQWVyMTE0RmtZaDJJeU9xWWdFUm8z?=
 =?utf-8?B?ZEs2TlJ1Ym4yU2EvMFJPS0JJbW9oNWVoZ3lSbjdGZ1YzUVU5STIxQTBiYktB?=
 =?utf-8?B?aDhJcnI0ZjlvZkI4UTdLanhQRml2L3M1ZGE1NCsybk44dUdOQkp0RHdSL0Iz?=
 =?utf-8?B?d3dIZ3lBTEtqbUhXdEx6b0x4TTgyQlA0Y2tFb003eW1CV2tTUXpob1ZvbXpU?=
 =?utf-8?B?TUV0aUlYWDRPSEErbC8rSHlTMUt4SjRUQ1Y4L3ZieDE0QkR5aXZiNGZJMDFt?=
 =?utf-8?B?bmlSMk9hbTJnOW9WUHdmMVp2NXNUUzdTRWhCdmJCSUkzRDVXTHU3WVVBZUlr?=
 =?utf-8?B?S1NOVmR1NTBWK0VkRkVCd3lRdE5Jb3J4cU9GalA0bmlhSmhDQk1YU0h6bFVs?=
 =?utf-8?B?OHlIWnpPSnBtTDBnU0xoY1BkdldCMVQraEQwUWRIY0tCcjd6Z01nVGpoRTZR?=
 =?utf-8?B?QktDVVNmNGliY1BGcTB5MzgrQUwyc2VZTkdCOTJBTmNBRXdJcjYybzczYXZy?=
 =?utf-8?B?eHRFZ0k1RnZIdWRoK2N0VGhZZnB1a0hlN2YySFRPV29PUllETEJSVGdmV3ZJ?=
 =?utf-8?B?eHpVbFc3SmNaakdqL0xQcGJjYzdsU2VOaGdrTitycGdmN2VaQ3krdE1YS0Rn?=
 =?utf-8?B?MHkyUVZXc21IeWZMWWV5YTJ2MnROU0NabjlObytoZHh0RE1GejNDb0k5dzhu?=
 =?utf-8?B?ZklIYW5xY3BBRWlkc3VXTDF6SmlESTcxWnNVWVpQcjcwN1pMa3FVZFRwekFx?=
 =?utf-8?B?RWp3Z0tJM3czbVk2TXNZalFPemYvQitCTGNLcWhSZXEwTW9mRG5sZEp2QjdT?=
 =?utf-8?B?NG02ZG4rcmFQMm0zaHRnVVcvcjZtOTV5Rk40WFozT2NhLzE0bll4M1gzTEwr?=
 =?utf-8?B?emxtcEt6VlFrNmlNMmpXa2d6S3lsM2ZtU3ZkYmZlSzhaelFhR0hHMTVDS0Vu?=
 =?utf-8?B?OXJGazJsWXV5ZGtZTnk1MDFRR1ZoSzlwaHdkQzZBY3Jhc3pKbC84T0pyaVBD?=
 =?utf-8?B?ZVUwYzAxWnhMTGM1a3ZDS1dDbXFRZHBjMVlnRHlVRmE4OUhNYlJKYXR6RWN4?=
 =?utf-8?B?S0FDcWE3UitjSmY3TGZlR01QTGJXVmZJUEFtK1E4cUZkVUJlNElWZUVRajN3?=
 =?utf-8?B?WkIrTHAvQjJ6dXBTRTBiSXpoUnUxUjJVd2h6dkVPcG8weXFOb2l2V3UzOEdt?=
 =?utf-8?B?NlFmUGs2ZjA2Zm9zRTdhbW4va20rdHpyYmpnOVM4R0gzdUZ6dVhoZlp2Lzg3?=
 =?utf-8?Q?mFWOzUWVPNg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDJRWVpCZExUMmYrbHRmaysyNG4vZFYvZDBxVmo1TUI3TXB3S1dIb29LY01L?=
 =?utf-8?B?Q0VNVEFlRHFHUHkyY1VzVGVneTNHYitBNFUwUU9EN3AvWEZoZC8vd0tXSFM2?=
 =?utf-8?B?Uy9mdnpqZTlQN3FOVDN5djVXckJnbjFOY29UNXJ5ZEhIeUh1MmZmTGFCOElP?=
 =?utf-8?B?Z2FDNWZNL1VTMUF5QkhMdXR0SnFSeUJZYXZkWldiR0pKMm0wcmpUUCszdGZC?=
 =?utf-8?B?aFIzZ1g1RzFaY3o4bnRSRXNmOGxkaUVTWnhpTjZ5azFtZXhrM1FjRXhTNEdN?=
 =?utf-8?B?MFZkcVp0NHFkVVhFL2w2YVFhbHZOWjA2R2dxUis5VkI4YVpGdUNld3E0T2l0?=
 =?utf-8?B?RUdObDR2NXhGWnBWeFE1dFNtZ2pTaVA4MFZDRm4wUkRxZFpVNk5QeUdYQVda?=
 =?utf-8?B?YUlUc3I0K3gwRjBYM3o3ZGZuNnllRHBUM1VOMGZDUkRtNkM3RUMyQmNJZHA5?=
 =?utf-8?B?OVJ6YUp2TXlGdG1ZNWs5R2tFV2FPQ3JIcTFSNzQ2d21QQTdsUVg2ZEVoakQx?=
 =?utf-8?B?cGhRQnJmZ0U5VjhWenZXRUEyQklKdlJKSzJpbjJVRk1Ed203cjdZY2N4OW80?=
 =?utf-8?B?RXExWjU0V2NIOWJ3V3VpRDhZSll6MS84RFpTc0tRQkorclJIUTdvMVBXSnBq?=
 =?utf-8?B?QVFNSUF0dXBtTTNxMFovZm9vakFOMWpMcXVvZ1JRYmkwYVBXVi9uUjFyL3E0?=
 =?utf-8?B?bGtuc2R6a1dGMHFFT3dwUy9Sb25FS0xZTng2RGIwNjhKOTQ0VjY4OVN3Q0g1?=
 =?utf-8?B?eG9BWUJSaHQ0ay96UEw1NitxSlRpdW5kS2VlSmJkVkVjUnBZTjl5UGw0a1pj?=
 =?utf-8?B?blYvektUM1RYYVAvRUFVTm5rQWNJMEZEMnBQYXlwZW1pNGl4RDBacGdhZDNH?=
 =?utf-8?B?S1RQbk12K1diK2tVSnRTZXY3S0xXaE1EbXk0UW45S3llZ1VZREFJUDM0VFdG?=
 =?utf-8?B?anNLaDJZdFNXekQ5ZVhXQXc0cG5pb3ZQU3Z1OEJ5RXJjaUUwUXpRaVlRTXJK?=
 =?utf-8?B?MHBEQjJwOVZHTXVQbjVkUGU5b0RTZ3RHRkhjdlJJM044OW5zSVhMUDl3RVRj?=
 =?utf-8?B?eUhxdzBKTzZYMjIyQkNkakViZWZKdjV4dGV0NlpnS0F2c0poZlNtb0pVKzRW?=
 =?utf-8?B?eVZlbENQVk1BSmxxeHdWZVpmUGRkTnBqT0E2VXdiMGhMQ1o1ekRJem0yWG5w?=
 =?utf-8?B?emd4SDdudFVzZ3l4TC9nRnk3eU9KMklsUjVDQWRxdWcvT0oyM0IxU2xyRkxa?=
 =?utf-8?B?blN4c1c2SnBHZ2ZGaVBTYmxGdnFFR0lHeVZZUG5MZFU0MnRkMWtJTkRWaFJw?=
 =?utf-8?B?THdPYlJwTDIwRVpWVmhUYmJoMGZFSWVrZ29XVEdUYXJjbFZ3QktZS21sWEVx?=
 =?utf-8?B?aWczQ2NuOE1jUDFud1pxK005MUo2UUR2QmFIREQ3NzVpVzd4ZGhMdnptOURq?=
 =?utf-8?B?SThvME9sZTBqREY3UmRRSW1OQ2VXRXZ6UnRCekQvMy9WU2xJYzEwY1h5N0dY?=
 =?utf-8?B?eko1c21ueGtFbmJkWTJsKzQ0NXJJOU1KdDdyYW4veVg1ZWxzZ2NYQ2s2WHBQ?=
 =?utf-8?B?TFpJbTVBRHZHREJka3ppbWU5NTVORlFKSUVwNmVLcUVOMGczMVI2a1JOQThG?=
 =?utf-8?B?eHcwOWo3TnowcG56QWI4T25MVXRmV1FrZHp1U242d0ltenQwamhRMjBCMWFI?=
 =?utf-8?B?aDNQNk9aOVNlVWR0TmJxMG1HYXZpTTcxN2NrUURBei81QzErZ1BUalBIVGZx?=
 =?utf-8?B?Q3ZHdXlPNHdjR2cxaTZ1WHJOeHN5VXdNNWxYYURrWTJRTXk0Rmd4czFoUXNH?=
 =?utf-8?B?c0xaNTBTTHU5Y3BTaFplRE5CbmN1eE43UksxZ3hxVFdPdUY3VEFIOU5zZEFY?=
 =?utf-8?B?U0VYZEg3dVhEM01lQjhMTkdIMFovYmIzY3MwL2w4bG91anpUd1d3dFhkd2lW?=
 =?utf-8?B?UkNKQzFKMXNvazZYcEQ1SlZyZVhMaDhNZWtEZVhUby9KZFR2Z0xaeUwwU3Rs?=
 =?utf-8?B?S0wzUjRsTEZEamRXQjBrR3lHNnY2eGN4K28xclJ1cXRCODNkRTRXQWNFdE5v?=
 =?utf-8?B?U1BZU2JaSXZkbHg4M2FNVTBrQ3NlMW1oMmxydm5LREoreXhXOCt0emVpa1o3?=
 =?utf-8?B?c1dtcytEL2dXZ1ZUY3huQlJ2UkZ1OEUwUUdCdUs0QUthK0ZiNEpmdnQyU1o3?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wBeeofCCj86Rp8LkTfyVEm+I2xCRvHngxhVzMN9yyzaHtiWcNKkiJFxdSaOTf7UIiugbWKTYyDviX+IzDiXlQPyu6XnnlAbu++jKS2e7/0QV6qKOVdCJyjV/u6x8BevHW6FJA7WdfApLn3cXi+iJkReZK5uTxp201Hj6ctEMg70dl/MCmupLoDzl0s5Ut49V0kCpXmgdQJGyhb01dfkJb7xtKKgRSYzezCDwFvZWx7OIv65XOfO1C9g7mlZQmCmvaaOuHDv69Q4MvfhEBg7c+5H3q/Tl8sxUWWKAyaAj2iqfjYi1YHCLoxX3/VcDetCyZ5xmACDRbsqaKctPEjIZFf0WH1hMeq4blbOjyVS9JmnEIj4Jv4FkDTBJYqMsqzXyRc5DvAjitr4RaZKNr9SRCbvqrmXSsJpg8HCvHjVMdanA3LuB9T87F+RKixPbiFUWbh6ZeI6Ix/P5ZwhkAf0i23QMFEMErGoZW99u1XrlICTaIfoZ2b904o4CDJ2p0vgtCm8BHY97USqtjPevTSsPQEfG1SRpQ7AGf/HiVrozfc40X6fFYohwIma0TBLesBe2WQpFozyGLn4iKlqBseVhBMFbpC7I54cMl7QTnwXd79A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e300d1-a23d-4792-e5d8-08dd93e3dc49
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:08:22.0703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEIaKEx0pyGSWgYgb9UPmtHou8m4+1cvDOhMk5CvxkFl32H7IYpae6kXNsTxZiltgBmmq1AKhvuHcTomtpmGuH/dCGDPLdwzz4+wdwTFsSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4OSBTYWx0ZWRfX3TcOLMaReNBL
 rs7ZmyTKgLCqZUXHm972+rMlD2K6yBBEQZDwag9ADQsQiYMtDTTtr48trYWm1TWfTmJeZY5qNCH
 rTwrKbgMK+iZ9a9BXVaIYTBgSzXO7ob3MqjGHnoyeV6Ooc6fnPZKtB48vh0yhpDxGOOGCOuGP8U
 R4uNOZ+UV4NsxaXb37YYzrz1mFImlMVsKq+T/QYhkc7aBfx85gjkJ6oritFcau1yM0Sq64Cm2NO
 g6lV7LYKd/+g8DjjSJIQgebNyVj+eCgsF3OXr3Tj81cbm8rYwDgCC/ZayKm8o8wUbM922MUpeuj
 exnzmF/b3CPVc/3Ds8tet6cde33HEQqCzoy/lMXkey7ca5RXBlTO+wzcmhHgXs3kfyedb13Abmf
 Hjjitkc0fO0Hs3pSR2yB5fUEMg2++88vgX4PgqycEipsOaF256KoQoXWvGKCsEJ8mW93IBU2
X-Proofpoint-GUID: cTP5RDhOyyU0iPgR969mMEMFXGAZn7f8
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=68263bb7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=oHvqYj9ZVXgjWiX5qdMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cTP5RDhOyyU0iPgR969mMEMFXGAZn7f8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/15/2025 8:59 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> At vfio creation time, save the value of vfio container, group, and device
>> descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
>> the saved descriptors, and remembers the reused status for subsequent
>> patches.  The reused status is cleared when vmstate load finishes.
>>
>> During reuse, device and iommu state is already configured, so operations
>> in vfio_realize that would modify the configuration, such as vfio ioctl's,
>> are skipped.  The result is that vfio_realize constructs qemu data
>> structures that reflect the current state of the device.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c           | 65 ++++++++++++++++++++++++++++++++++++-------
>>   hw/vfio/cpr-legacy.c          | 46 ++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-cpr.h    |  9 ++++++
>>   include/hw/vfio/vfio-device.h |  2 ++
>>   4 files changed, 112 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 85c76da..278a220 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -31,6 +31,8 @@
>>   #include "system/reset.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> +#include "migration/cpr.h"
>> +#include "migration/blocker.h"
>>   #include "pci.h"
>>   #include "hw/vfio/vfio-container.h"
>>   #include "hw/vfio/vfio-cpr.h"
>> @@ -414,7 +416,7 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
>>   }
>>   static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>> -                                            Error **errp)
>> +                                            bool cpr_reused, Error **errp)
>>   {
>>       int iommu_type;
>>       const char *vioc_name;
>> @@ -425,7 +427,11 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>           return NULL;
>>       }
>> -    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>> +    /*
>> +     * If container is reused, just set its type and skip the ioctls, as the
>> +     * container and group are already configured in the kernel.
>> +     */
>> +    if (!cpr_reused && !vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>>           return NULL;
>>       }
>> @@ -433,6 +439,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>       container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
>>       container->fd = fd;
>> +    container->cpr.reused = cpr_reused;
>>       container->iommu_type = iommu_type;
>>       return container;
>>   }
>> @@ -584,7 +591,7 @@ static bool vfio_container_attach_discard_disable(VFIOContainer *container,
>>   }
>>   static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
>> -                                     Error **errp)
>> +                                     bool cpr_reused, Error **errp)
>>   {
>>       if (!vfio_container_attach_discard_disable(container, group, errp)) {
>>           return false;
>> @@ -592,6 +599,9 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
>>       group->container = container;
>>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>>       vfio_group_add_kvm_device(group);
>> +    if (!cpr_reused) {
>> +        cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
>> +    }
> 
> Could we avoid the test on cpr_reused always call cpr_save_fd() ?

No.  If cpr_reused is true, then the fd is already on cpr's save list.
We don't want to save duplicates of the same entry.

>>       return true;
>>   }
>> @@ -601,6 +611,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
>>       group->container = NULL;
>>       vfio_group_del_kvm_device(group);
>>       vfio_ram_block_discard_disable(container, false);
>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>   }
>>   static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>> @@ -613,17 +624,37 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>       VFIOIOMMUClass *vioc = NULL;
>>       bool new_container = false;
>>       bool group_was_added = false;
>> +    bool cpr_reused;
>>       space = vfio_address_space_get(as);
>> +    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
>> +    cpr_reused = (fd > 0);
> 
> 
> The code above is doing 2 things : it grabs a restored fd and
> deduces from the fd value that the VM is doing are doing a CPR
> reboot.
> 
> Instead of adding this cpr_reused flag, I would prefer to duplicate
> the code into something like:
> 
> if (!cpr_reboot) {
>     QLIST_FOREACH(bcontainer, &space->containers, next) {
>          container = container_of(bcontainer, VFIOContainer, bcontainer);
>          if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>              return vfio_container_group_add(container, group, errp);
>          }
>      }
> 
>      fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>      if (fd < 0) {
>          goto fail;
>      }
> 
>      ret = ioctl(fd, VFIO_GET_API_VERSION);
>      if (ret != VFIO_API_VERSION) {
>          error_setg(errp, "supported vfio version: %d, "
>                     "reported version: %d", VFIO_API_VERSION, ret);
>          goto fail;
>      }
> 
>      container = vfio_create_container(fd, group, errp);
> } else {
>     /* ... */
> }
> 

OK, but there is no sense in duplicating the identical code for
VFIO_GET_API_VERSION and vfio_create_container.  If you want me to
simplify the loop, I suggest:

if (!cpr_reused) {
     QLIST_FOREACH(bcontainer, &space->containers, next) {
          container = container_of(bcontainer, VFIOContainer, bcontainer);
          if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
              return vfio_container_group_add(container, group, false, errp);
          }
      }

      fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
      if (fd < 0) {
          goto fail;
      }
} else {
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOContainer, bcontainer);
         if (vfio_cpr_container_match(container, group, &fd)) {
             return vfio_container_group_add(container, group, true, errp);
         }
     }
}

ret = ioctl(fd, VFIO_GET_API_VERSION);
...

>> +    /*
>> +     * If the container is reused, then the group is already attached in the
>> +     * kernel.  If a container with matching fd is found, then update the
>> +     * userland group list and return.  If not, then after the loop, create
>> +     * the container struct and group list.
>> +     */
>>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>>           container = container_of(bcontainer, VFIOContainer, bcontainer);
>> -        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>> -            return vfio_container_group_add(container, group, errp);
>> +
>> +        if (cpr_reused) {
>> +            if (!vfio_cpr_container_match(container, group, &fd)) {
> 
> why do we need to modify fd ?

That is explained by the comments inside vfio_cpr_container_match, where the
explanation is more easily understood.

>> +                continue;
>> +            }
>> +        } else if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>> +            continue;
>>           }
>> +        return vfio_container_group_add(container, group, cpr_reused, errp);
>> +    }
>> +
>> +    if (!cpr_reused) {
>> +        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>       }
>> -    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>       if (fd < 0) {>           goto fail;
>>       }
>> @@ -635,7 +666,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>           goto fail;
>>       }
>> -    container = vfio_create_container(fd, group, errp);
>> +    container = vfio_create_container(fd, group, cpr_reused, errp);
>>       if (!container) {
>>           goto fail;
>>       }
>> @@ -655,7 +686,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>       vfio_address_space_insert(space, bcontainer);
>> -    if (!vfio_container_group_add(container, group, errp)) {
>> +    if (!vfio_container_group_add(container, group, cpr_reused, errp)) {
>>           goto fail;
>>       }
>>       group_was_added = true;
>> @@ -697,6 +728,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>>       QLIST_REMOVE(group, container_next);
>>       group->container = NULL;
>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>       /*
>>        * Explicitly release the listener first before unset container,
>> @@ -750,7 +782,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>>       group = g_malloc0(sizeof(*group));
>>       snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
>> -    group->fd = qemu_open(path, O_RDWR, errp);
>> +    group->fd = cpr_open_fd(path, O_RDWR, "vfio_group", groupid, NULL, errp);
>>       if (group->fd < 0) {
>>           goto free_group_exit;
>>       }
>> @@ -782,6 +814,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>>       return group;
>>   close_fd_exit:
>> +    cpr_delete_fd("vfio_group", groupid);
>>       close(group->fd);
>>   free_group_exit:
>> @@ -803,6 +836,7 @@ static void vfio_group_put(VFIOGroup *group)
>>       vfio_container_disconnect(group);
>>       QLIST_REMOVE(group, next);
>>       trace_vfio_group_put(group->fd);
>> +    cpr_delete_fd("vfio_group", group->groupid);
>>       close(group->fd);
>>       g_free(group);
>>   }
>> @@ -812,8 +846,14 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>>   {
>>       g_autofree struct vfio_device_info *info = NULL;
>>       int fd;
>> +    bool cpr_reused;
>> +
>> +    fd = cpr_find_fd(name, 0);
>> +    cpr_reused = (fd >= 0);
>> +    if (!cpr_reused) {
>> +        fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>> +    }
> 
> Could we introduce an helper routine to open this file,  like we have
> cpr_open_fd() ?

OK, but this would be the only use of the helper, and it would bury
generic vfio functionality -- VFIO_GROUP_GET_DEVICE_FD -- inside a cpr
flavored helper.  IMO not an improvement.

>> -    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>>       if (fd < 0) {
>>           error_setg_errno(errp, errno, "error getting device from group %d",
>>                            group->groupid);
>> @@ -857,6 +897,10 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>>       vbasedev->group = group;
>>       QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
>> +    vbasedev->cpr.reused = cpr_reused;
>> +    if (!cpr_reused) {
>> +        cpr_save_fd(name, 0, fd);
> 
> Could we avoid the test on cpr_reused always call cpr_save_fd() ?

No.  Must avoid adding duplicate entries.

>> +    }
>>       trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
>>       return true;
>> @@ -870,6 +914,7 @@ static void vfio_device_put(VFIODevice *vbasedev)
>>       QLIST_REMOVE(vbasedev, next);
>>       vbasedev->group = NULL;
>>       trace_vfio_device_put(vbasedev->fd);
>> +    cpr_delete_fd(vbasedev->name, 0);
>>       close(vbasedev->fd);
>>   }
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index fac323c..638a8e0 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -10,6 +10,7 @@
>>   #include "qemu/osdep.h"
>>   #include "hw/vfio/vfio-container.h"
>>   #include "hw/vfio/vfio-cpr.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "migration/blocker.h"
>>   #include "migration/cpr.h"
>>   #include "migration/migration.h"
>> @@ -31,10 +32,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>       }
>>   }
>> +static int vfio_container_post_load(void *opaque, int version_id)
>> +{
>> +    VFIOContainer *container = opaque;
>> +    VFIOGroup *group;
>> +    VFIODevice *vbasedev;
>> +
>> +    container->cpr.reused = false;
>> +
>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> +            vbasedev->cpr.reused = false;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>>   static const VMStateDescription vfio_container_vmstate = {
>>       .name = "vfio-container",
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>> +    .post_load = vfio_container_post_load,
>>       .needed = cpr_needed_for_reuse,
>>       .fields = (VMStateField[]) {
>>           VMSTATE_END_OF_LIST()
>> @@ -68,3 +86,31 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>>       migrate_del_blocker(&container->cpr.blocker);
>>       vmstate_unregister(NULL, &vfio_container_vmstate, container);
>>   }
>> +
>> +static bool same_device(int fd1, int fd2)
>> +{
>> +    struct stat st1, st2;
>> +
>> +    return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
>> +}
>> +
>> +bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
>> +                              int *pfd)
>> +{
>> +    if (container->fd == *pfd) {
>> +        return true;
>> +    }
>> +    if (!same_device(container->fd, *pfd)) {
>> +        return false;
>> +    }
>> +    /*
>> +     * Same device, different fd.  This occurs when the container fd is
>> +     * cpr_save'd multiple times, once for each groupid, so SCM_RIGHTS
>> +     * produces duplicates.  De-dup it.
>> +     */
>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>> +    close(*pfd);
>> +    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
>> +    *pfd = container->fd;
> 
> I am not sure 'pfd' is used afterwards. Is it ?

True, good eye.  I will change it to "int fd" and stop returning the new value.

- Steve

> 
>> +    return true;
>> +}
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index f864547..1c4f070 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -13,10 +13,16 @@
>>   typedef struct VFIOContainerCPR {
>>       Error *blocker;
>> +    bool reused;
>>   } VFIOContainerCPR;
>> +typedef struct VFIODeviceCPR {
>> +    bool reused;
>> +} VFIODeviceCPR;
>> +
>>   struct VFIOContainer;
>>   struct VFIOContainerBase;
>> +struct VFIOGroup;
>>   bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>                                           Error **errp);
>> @@ -29,4 +35,7 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>                                    Error **errp);
>>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>> +bool vfio_cpr_container_match(struct VFIOContainer *container,
>> +                              struct VFIOGroup *group, int *fd);
>> +
>>   #endif /* HW_VFIO_VFIO_CPR_H */
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>> index 8bcb3c1..4e4d0b6 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -28,6 +28,7 @@
>>   #endif
>>   #include "system/system.h"
>>   #include "hw/vfio/vfio-container-base.h"
>> +#include "hw/vfio/vfio-cpr.h"
>>   #include "system/host_iommu_device.h"
>>   #include "system/iommufd.h"
>> @@ -84,6 +85,7 @@ typedef struct VFIODevice {
>>       VFIOIOASHwpt *hwpt;
>>       QLIST_ENTRY(VFIODevice) hwpt_next;
>>       struct vfio_region_info **reginfo;
>> +    VFIODeviceCPR cpr;
>>   } VFIODevice;
>>   struct VFIODeviceOps {
> 
> 
> Thanks,
> 
> C.
> 
> 



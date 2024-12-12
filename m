Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724CBE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpxJ-0006Ye-QQ; Thu, 12 Dec 2024 15:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLpxI-0006YD-JU
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:38:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tLpxA-0006e1-Bf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:38:34 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCJfret022014;
 Thu, 12 Dec 2024 20:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=EaffaU5I7RZ23eJQ4rUfWJ7UBOFgOkkr/4PziEk82Sc=; b=
 ISzJGgsJjTBH2zu4HgYqqxCcrK5H2+tkCbkSv40i/5nKp09ifihP9l6h263xxqGQ
 e9xw83woUpepavDIvweTCaHMM46HH1JU8x2/UT+NNgCtI6niFikz3Yo2SclwDy3i
 JWLLP1nkuf+PGbTV269Wl7LyxQAA2yq2NycVz/phtx8ZWZFIMtrjfXTMpJtHpWrP
 iE8rpEigigGcx+oiGeBUPD56VojARoOoB1qI08y/fIRd2rI8haJlFo59vXAn/t7M
 Z22a5kaJ1I/uHZ3qPi6EnmN3LQVml1jkgXggfEyTwHkPSWxqyCX5MzsYeD5JIR7g
 3ZbI4XhbbdgnXjf39v6oYw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy0c97t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 20:38:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BCJpTBX035674; Thu, 12 Dec 2024 20:38:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43cctk6700-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 20:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVXmgFh+gbdPye/+t8xWXJbM8Dv7vrJtwEhZh8gU3zsG9umnwEZQ1y8pNHr/+Hpp3maqJk4Ygo6S/yTqeOHFVYcpAiiGnqAcJ9gUpYfWqe1HleDpdmhMikpCwlHyw68x1wN6fXFP1OcGRKymCOel0pxjSrFdl5nkpUnvCqG1jasbHv2kSTZBNIIILCg+1UaY1wPr5MKEUn2NINCmTL3+4vAYnGOWa5oCWi6jC+TsCg8bxwcg+R3A7ap2Lz1JyXSTNT1RtoWPp0nTdwiBaqX6b+fiJ3NLuvCGY0EpLwM66BrKYJmVYS/AcGYCjJmmWJDSO0AtjTrNplVVfBCcKQ7+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaffaU5I7RZ23eJQ4rUfWJ7UBOFgOkkr/4PziEk82Sc=;
 b=ix4zlp6+imp78tuhdfvtO7+aS0/rJZz8jE7ANIM892Z//bpmRPnxRRtYfXqiJ9/s5ahiCET9J4m//gdRZ+NNSdF4n8FFtATuiBcLtej5yegMO812CSh1O5qC1PelXWzwi3dAUbTRoUXZDojZa8DH3RBOs8ifn6ml8z2MMw+TTMCTWTSSRriBfKqG/NrdE9aAWp/EYgbD5wgYPakOzUyCsec5wvlUwNktNppwGviBSDwfy7uRCaYrZ/T549zSIg0RXoJu4Z5VsN78f34zq1azHAogv7gPOqe/+Wr3y0dFZPIUI89kfar9/Xp01jNz9lQ7xySkunDorRSnsGj7m4uxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaffaU5I7RZ23eJQ4rUfWJ7UBOFgOkkr/4PziEk82Sc=;
 b=I53ws1KSbyvGWETtpsf9eSszyMsHSWt65PJBKaoBTUBJSDLWORC/s1YNo+913CRmfQPbTaCo2UHvV1v/zNXW1ZT+CiJoReLt/2JD8vzQRZ4gtz69ahs5aYjgZ4i4lxf9+QiXbC5J+87Irr02H5qdTb0ZE+w7UklRqlXNWkB8WBY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7806.namprd10.prod.outlook.com (2603:10b6:610:1ae::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 20:38:03 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 20:38:02 +0000
Message-ID: <ecbae03f-a8b2-4a41-89bc-5a671a4c3c7e@oracle.com>
Date: Thu, 12 Dec 2024 15:38:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/19] physmem: fd-based shared memory
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-3-git-send-email-steven.sistare@oracle.com>
 <Z1dIEUcSrI1aROSp@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z1dIEUcSrI1aROSp@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:408:ff::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 813bc74d-b561-4e3d-2011-08dd1aecdfe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFRmY0lVUXNpNEpPUk8vZkVLOGRvUVdJanl6SGpHaEIvbzZQM2FRRytwQ0Rn?=
 =?utf-8?B?Ni8yRU9XWFRQVDJhM1RZMitCb1licElEbU8xc0p6VVIyQjFBeVV2MEZ2UXdP?=
 =?utf-8?B?Wk5hSng2aG53SjY4L0N1QWYxU1M3UytIKzEramZzOGQrdHhqV3ZFN1o5UXA5?=
 =?utf-8?B?c0kxWXVFd3RjdnZnNHArTVdkdHc4Z1Y1Yi9sT2dsU1N5TDlDdENpMWxQTSta?=
 =?utf-8?B?NXc1Vm9ZZlorZzYvRW15Y1ErS3hLeElHQldZcHVwc0grcm1aL2tqVUpxTmxN?=
 =?utf-8?B?OE0yRHc2dlNONDk2M0pJdTd0eXYrUUlQYkRJWnZmRndMSG1RL3hkYlU2MXJj?=
 =?utf-8?B?c2dpcFNuYWRSSGFCMkJEVm8zNy9mcXJTZHk4NUxEckpwYTd4dlhiSFZkb1V0?=
 =?utf-8?B?NTFKdmVxY0kyS2dDcStEbGVSRzd3bk9FanlQTEdBb0k4Rk9wb2FqQ3h1Qjdm?=
 =?utf-8?B?L0ZFNGdyTmdET0JQbXBoWmc4YmR5S0NWWVJxWlB3emF6bGEwQUtGT3FDNHdP?=
 =?utf-8?B?UnB6VGNabGwyTjlKUUNRQTM2Tm9Wd2pQa3d5NUF3empQbmhQQmdodzFYbWps?=
 =?utf-8?B?Nklld0xLTzYvbzJRUWVubXlMY1FXQWVnaTB6ZkkzSDZQdFFOYStNMmhUWnN5?=
 =?utf-8?B?V1RXYkJqa2tUUnlqeXBGTy9FRkRLaGozVDZkWmhHRytkOXVlOGtiV2ZUQ3Zk?=
 =?utf-8?B?UkVBSFBpeUJ5eDlBL2ttOW9xejJHZEQwRk1vcXJUeCs5bG45a3Y0VWFOQmhJ?=
 =?utf-8?B?YTVWMEhiOTVsZkxLc1ppWHpSYU5jdnlZVElZeUFwVWQxUzN1M3FqcG9lZVZn?=
 =?utf-8?B?cFoyN1Z3ZURDeDl6S0k1OHNOL3k3OGFIbGpmajlBcGdtQXZ0TUVRL2haZHpQ?=
 =?utf-8?B?MjEyT0EwdHJRWXJLNXgyUnYrZCtKSXQxdk9WTTcyMVNrbER3U3k2QlJ5QU5F?=
 =?utf-8?B?QXhsd09rRFRUN0FiVm8yWmlDZHBmMTI4UnJqS3NXOEdFMGFVMDNpZjFrT0Ix?=
 =?utf-8?B?blBRaWw4TTVzblpTditCajdaTThrSUkvUWJTaGJHSXpZc1Z3aEg1UVlqNUxX?=
 =?utf-8?B?WUR5OStXUGtvZERLdWdGOHlXYTVzb0VWUzQvZWRvWWJLeHJjaWM0V0ZFQWJI?=
 =?utf-8?B?L0hqZktrSWxwYW5xS0h4aTI0dmYzQ3JDV3dxdWtubUlUWWFhUUVURzR6QjJZ?=
 =?utf-8?B?YktwbUR5M2RXWlFpa1l4YlBXeWdMZGJNNkthMmRqTTdEdVJFcUlOUVFKdW5U?=
 =?utf-8?B?cFArNCtvVDhpTHlNSXl6TmpRaWNmQjc1b0ZRTXFpYVk5RlJaTmcwWHB5QWtk?=
 =?utf-8?B?NTFxVVVlemdIN3gyWTQ4Mnkwc2ZGcEtsa1p6NkFTdTlpMHRqc2oxZnZpdVk2?=
 =?utf-8?B?L0Z3WURaZ0tRM3hLUG9HSGNmc3RtRFZoWEVqZEp4RU5leTRzaFArRldpamFJ?=
 =?utf-8?B?MDhZcWdETEZ3NmpZM3BHem13VWxYRlRwZjV3VkUzOXBJOHpCUy94MlViN0x5?=
 =?utf-8?B?MWp2c1NNUGtWV2dBQmxQVy9YVmk4UVBxeWJWcmJHN3dhZS81ZzNxYUlQMlZT?=
 =?utf-8?B?ckhySTZJbXBPbjI2aWZZTFZFTk1RNXV4NjJYUkZhK3lneDc0RWQwUzFPb0dE?=
 =?utf-8?B?NHRyQXNaaEhaZ0ZHdkJ1MmZ3Nkg4ZEZweTJ3YnFQYkZvTGR6VjF5djlCNjJz?=
 =?utf-8?B?dTg4eHBKcEMvbjFqbzFKeUxvK2tHeVFHUTlHblE3RHpLQk5SLy81c2JZVkxR?=
 =?utf-8?B?Tyt4c2xHRFJTU3hoaW5zZnBlUUg5dE1MbHlXM3NLQXhiWldhOG1oamJ2QXRC?=
 =?utf-8?B?THZtdnlVc0RQWVZGNWgyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTFuWkpZMys4eWk1dGpCemhwS3Iyak1lRXFVZUhnKzdubGZqN1E2WDYyTWtN?=
 =?utf-8?B?N25NSWFOcE9hUjUzWkZQYjhXTzQvT2h2b3QyZENRUWxqS3ZlMmYyYTFiZHdj?=
 =?utf-8?B?WjFKQ1RmL3pJdEZ5N1FzUk9LS2JiMHhHSUkxK3VMVWFYMWI1S3NWYW5RZEhr?=
 =?utf-8?B?T2UzTmNocGg4cW9Zb3h2SEN1R2VYVkd1cGVySDZKNXpoRzVBekdaTHhndFZn?=
 =?utf-8?B?L0pFUHIzWDZlV3FTR2xDNlp0VVJSWUJzZWdKc21XVkJOWFFBb25TSVZLbkxI?=
 =?utf-8?B?TWw4aUV6bjJFYmtTRnBiN3plKzNzNnBRcWVWYUxRYTVFODJHYXhiNlB4Z285?=
 =?utf-8?B?R2J6aVlpUEZhM2NNbVE0eG1Cak9sNkV4d2Q2Wm1GSk41Z2xhU3FtRWQ3V2tw?=
 =?utf-8?B?cXJtQTVTdG5xSnNpc0lMdkRGaDBMd0p6NVpVNmc1dHNFcHVSNGU5TDkvWkkv?=
 =?utf-8?B?TE5wWnBYRjA1bFFxM3hYUGVtVFMxZTJNZWFOOG1iVVNRYk0wR3c1Z1dmZk50?=
 =?utf-8?B?OEU5Q3p2SzFuUTgrRVRmOGt4QlcvNGpjRWhEcWFzazJhYXBkam94UWF3S2s2?=
 =?utf-8?B?UTVpaUxLcTVGQVhtTFNMY1dKRDVVclFsdGZCblo4bGV5bmFDb01OSlB0VFZU?=
 =?utf-8?B?TG5UUldZdjJHdk1COXJyalFHUHV1K1FHT1V5cjRnMmxEN0ZXK3J1MGRIU0JO?=
 =?utf-8?B?RG9ZY3VlZWNJSDlDQkZvYXRhenQxSDhFazJGdVNERlVLNkhuTk9FRnhTZDBO?=
 =?utf-8?B?Wi9WSlc1MWRIaE9yaXY4MzVuM3h1M2hxSjE1cHJhVjhoTE5naklNMUkxcHU0?=
 =?utf-8?B?eUhla0R0Y2FkUUwxakRiUUE4dWxHVy9yaWliSytzNHMxM3NYNkFTOEgvV1lx?=
 =?utf-8?B?QVRScnVTclQ2NWRVcHhQcTEydTNVVm52WXBkUjJVczE3UWQ4TE1yUlN6ZHRj?=
 =?utf-8?B?S213LzVYWFNKYWp1SnlCTUFBR1JSVHdsM0VjT2M5dUZ6Nll6ekJqYTlUZkMr?=
 =?utf-8?B?YnBSTklENHZLbDgyQTNsR0tpWGNDZ0FTYjRsbUQrUUNYL3JnMi9od1hzdUtk?=
 =?utf-8?B?bWs1WmwyalZ6eXkySlltWFBGNHkyWm9pKzNjY2c1cHdaTG9KdnhUSHdaMkN4?=
 =?utf-8?B?cFlpM1F3N3drUHh1K2FkM0pzdUpUS1BOQ0ZmbG9wclk4SEFGeW1LR0pCZnlj?=
 =?utf-8?B?YkZPa3lla2JmL1JySG81RUxDMnpYcGkyVTFwaVloRHBaTGV4cFdzNzlRbHhr?=
 =?utf-8?B?RU04UkhrRVJuTkEvUUg3YWp4d2JicXZhOHNUTWpCd3FreFh3RHJ6MXdXOWw5?=
 =?utf-8?B?UGRzbEZKaUc3R0I5eFB6dmcwbWNqdnh1V1VzN3NXd01IenVkMFprSGRCdkY2?=
 =?utf-8?B?YXNLREZncFhnMEwyeDMzSVNEcnBvaXNmdlpVa3N4VDkrMmRSc3U2d1VoTmFs?=
 =?utf-8?B?ejROY1QwVjgwQU40OGJDN2xabzJBNmRqWlgyVFBQSmF6akJhU1F0UmhNamxp?=
 =?utf-8?B?dTVqeUF0MnBJdWxRSjFYUERzcjhQRmFCQ1ROQWQ2N2pIdDIyaFNIaFRQRnFl?=
 =?utf-8?B?K0I0WlBXcE90VFFLcjZGejYrRVA0RmQrcFRlOWJYb043b3pXMWM2eTdUUE9t?=
 =?utf-8?B?QnRaRG9mVFlDWnBwVjFBQmw0ejdmQk9yYVpkV1BTVDUycnFTR3JJSVl6a1U3?=
 =?utf-8?B?SEw5UlE0dWpQQVJoSXlwYUM4dVYwdmk0UHRHYnBiMHhpd2NOV29VRWJVbjcv?=
 =?utf-8?B?OXk1NnlIT3FHWmVQUWF3NVo3SE9ZS3JOb2N1d0NvVnBTK0hBYjJNMnZDOG9Y?=
 =?utf-8?B?MmpVSGFIMGI4em4xMDYrdXRjc1ZPWllOL0FJdWNyUzJNZHRWVzJjNnREcVZX?=
 =?utf-8?B?eTVtaSsxbFI0NWV1cHdETEZrMnROTkJ0ejRLOU8vMUF4NEUydjBsdE9ubE55?=
 =?utf-8?B?NnpONVBtR0xlN1dXb3JaS0pkbEVKM3FXQm95Q1lvRkFqbE1LWWpxakpqbHJt?=
 =?utf-8?B?S3gveHVpbXNUZTdXWUlQd0QwdnM1c3NDS3RkSVcxVS9Xd3c2Ymp1R1hqbmFL?=
 =?utf-8?B?c3VSb0FyYkJhUlFhUDEzL1lERURHN0M4U01PZkMrcFdsL3Nmbm1jMVBUamQy?=
 =?utf-8?B?TkZTQm8yaUYzakZ1OXlDUHFDR3YzTHB6bUgwdzhoeVBBaGdvY3o0VytzUkFp?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h5qrn3M6MMgOh//tCtWfDhaI9R1joNZdiIrpFp1QzKwM6Z5VIPZMJ+ga08qYukAO+l+Z+g0c+sQw8Q6+eQn3D5x2R1u7xCVdPP0ApdGlATJAiD6ULQAVsxralyhC/pkzW9XxNQC/3fUQ/4lNLD10kXWJtVC9587/EmxcqtTkyPf+difn5qzY+xP59Vwj7c+uUVVmjCP7DaqSc5VRDkseS9u5CgcpXUNeMPDWQNPVaiD933Z0i8GSn16u5LCbiHtlA+rEYDsIf7aF6E9BWHN5rG9O1UEErPwmL5/x03FgktHx1irZwCr4AidEHEdelyFlaQ40HBoThZZE5JaegHu2tOjt4ISN9EfyF+5erBkiKLL2SE7ml61/v6VwN6Z94xm3UQmBL3fLO822YJJcCT2eChV4RmH861Wa5+SfHcmPI3gnqkrodLjc4ckdWX7cDsqLWl8jonNSQqcWUdBs4MwqBH77oUPvcgmiYZyY2azp6rzDG3WCIKkyPXckqOmEbuBvxy0f7JpXHbIAA1V4JyNu1PtLEcFXmZ6xBQhCFZBn+Ii5rEZs8EM7Usmtf52a11zf0+3vYwWp4viKlxNm83plii9ERA7KigUERt5x4ZZDa+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813bc74d-b561-4e3d-2011-08dd1aecdfe2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:38:02.8733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vwirH1quymE1Hx4OSdd6osVeJeO2E5xN71z2ul1FpMxjeARyrZTaAfppjVEYp1J8iMwGEx5kZZPX1SWbIomzkfh4shl426u/MkkzXVTse0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_10,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412120150
X-Proofpoint-GUID: 1w5pn8_RARTxg8ja9vLyfrzBhTJUVytH
X-Proofpoint-ORIG-GUID: 1w5pn8_RARTxg8ja9vLyfrzBhTJUVytH
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/9/2024 2:42 PM, Peter Xu wrote:
> On Mon, Dec 02, 2024 at 05:19:54AM -0800, Steve Sistare wrote:
>> @@ -2089,13 +2154,23 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>>       new_block->page_size = qemu_real_host_page_size();
>>       new_block->host = host;
>>       new_block->flags = ram_flags;
>> +
>> +    if (!host && !xen_enabled()) {
> 
> Adding one more xen check is unnecessary.  This patch needed it could mean
> that the patch can be refactored.. because we have xen checks in both
> ram_block_add() and also in the fd allocation path.
> 
> At the meantime, see:
> 
> qemu_ram_alloc_from_fd():
>      if (kvm_enabled() && !kvm_has_sync_mmu()) {
>          error_setg(errp,
>                     "host lacks kvm mmu notifiers, -mem-path unsupported");
>          return NULL;
>      }
> 
> I don't think any decent kernel could hit this, but that could be another
> sign that this patch duplicated some file allocations.
> 
>> +        if ((new_block->flags & RAM_SHARED) &&
>> +            !qemu_ram_alloc_shared(new_block, &local_err)) {
>> +            goto err;
>> +        }
>> +    }
>> +
>>       ram_block_add(new_block, &local_err);
>> -    if (local_err) {
>> -        g_free(new_block);
>> -        error_propagate(errp, local_err);
>> -        return NULL;
>> +    if (!local_err) {
>> +        return new_block;
>>       }
>> -    return new_block;
>> +
>> +err:
>> +    g_free(new_block);
>> +    error_propagate(errp, local_err);
>> +    return NULL;
>>   }
> 
> IIUC we only need to conditionally convert an anon-allocation into an
> fd-allocation, and then we don't need to mostly duplicate
> qemu_ram_alloc_from_fd(), instead we reuse it.
> 
> I do have a few other comments elsewhere, but when I was trying to comment.
> E.g., we either shouldn't need to bother caching qemu_memfd_check()
> results, or do it in qemu_memfd_check() directly.. and some more.

Someone thought it a good idea to cache the result of qemu_memfd_alloc_check,
and qemu_memfd_check will be called more often.  I'll cache the result inside
qemu_memfd_check for the special case of flags=0.

> Then I think it's easier I provide a patch, and also show that it can be
> also smaller changes to do the same thing, with everything fixed up
> (e.g. addressing above mmu notifier missing issue).  What do you think as
> below?

The key change you make is calling qemu_ram_alloc_from_fd instead of file_ram_alloc,
which buys the xen and kvm checks for free.  Sounds good, I will do that in the
context of my patch.

Here are some other changes in your patch, and my responses:

I will drop the "Retrying using MAP_ANON|MAP_SHARED" message, as you did.

However, I am keeping QEMU_VMALLOC_ALIGN, qemu_set_cloexec, and trace_qemu_ram_alloc_shared.

Also, when qemu_memfd_create + qemu_ram_alloc_from_fd fails, qemu should fail and exit,
and not fall back, because something unexpected went wrong.  David said the same.
Thus we still need to pass errp to qemu_memfd_create().

I will push the qemu_shm_alloc ERRP_GUARD back to patch
   "factor out allocation of anonymous shared memory"

- Steve

> 
> ===8<===
>  From a90119131a972b0b4f15770fe0b431770456e447 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Mon, 9 Dec 2024 13:38:06 -0500
> Subject: [PATCH] physmem: Try to always allocate anon and shared memory with
>   fd
> 
> qemu_ram_alloc_internal() is the memory API QEMU uses to allocate anonymous
> memory.  It allows RAM_SHARED too on top of anonymous.
> 
> It might be always beneficial to allocate memory with fd attached whenever
> possible because fd is normally more flexible comparing to the virtual
> mapping alone.  For example, CPR can use it to pass over fds between
> processes to share memory, especially useful when the memory can be pinned.
> 
> Since there's no harm when it's possible, do it unconditionally for all
> such anonymous & shared memory allocations where the memory is to be
> allocated.  Provide fallbacks when it can fail, e.g., when none of the
> memory attached fd is available.
> 
> Two extra ERRP_GUARD()s are needed in the used functions, as we will not
> care about error even if it happened, so it's easier to allow passing NULL
> into them.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   system/physmem.c   | 38 ++++++++++++++++++++++++++++++++++++++
>   util/memfd.c       |  2 ++
>   util/oslib-posix.c |  2 ++
>   3 files changed, 42 insertions(+)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index dc1db3a384..4e795aefa0 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -47,6 +47,7 @@
>   #include "qemu/qemu-print.h"
>   #include "qemu/log.h"
>   #include "qemu/memalign.h"
> +#include "qemu/memfd.h"
>   #include "exec/memory.h"
>   #include "exec/ioport.h"
>   #include "sysemu/dma.h"
> @@ -2057,6 +2058,24 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>   }
>   #endif
>   
> +/*
> + * Try to allocate a zero-sized anonymous fd for shared memory allocations.
> + * Returns >=0 if succeeded, <0 otherwise.
> + *
> + * Prioritize memfd, as it doesn't have the same /dev/shm size limitation
> + * v.s. POSIX shm_open().
> + */
> +static int qemu_ram_alloc_anonymous_fd(void)
> +{
> +    if (qemu_memfd_check(0)) {
> +        return qemu_memfd_create("anon-memfd", 0, 0, 0, 0, NULL);
> +    } else if (qemu_shm_available()) {
> +        return qemu_shm_alloc(0, NULL);
> +    } else {
> +        return -1;
> +    }
> +}
> +
>   static
>   RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>                                     void (*resized)(const char*,
> @@ -2073,6 +2092,25 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>                             RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
>       assert(!host ^ (ram_flags & RAM_PREALLOC));
>   
> +    /*
> +     * Try to use fd-based allocation for anonymous and shared memory,
> +     * because fd is normally more flexible (e.g. on memory sharing between
> +     * processes).  We can still fallback to old ways if it fails.
> +     */
> +    if (!host && (ram_flags & RAM_SHARED)) {
> +        int fd = qemu_ram_alloc_anonymous_fd();
> +
> +        if (fd >= 0) {
> +            new_block = qemu_ram_alloc_from_fd(size, mr, ram_flags,
> +                                               fd, 0, errp);
> +            if (new_block) {
> +                return new_block;
> +            }
> +            close(fd);
> +        }
> +        /* Either fd or ramblock allocation failed, fallback */
> +    }
> +
>       align = qemu_real_host_page_size();
>       align = MAX(align, TARGET_PAGE_SIZE);
>       size = ROUND_UP(size, align);
> diff --git a/util/memfd.c b/util/memfd.c
> index 8a2e906962..0dc15b2f44 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -52,6 +52,8 @@ int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>   {
>       int htsize = hugetlbsize ? ctz64(hugetlbsize) : 0;
>   
> +    ERRP_GUARD();
> +
>       if (htsize && 1ULL << htsize != hugetlbsize) {
>           error_setg(errp, "Hugepage size must be a power of 2");
>           return -1;
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index f8c3724e68..6ca3e994fc 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -944,6 +944,8 @@ int qemu_shm_alloc(size_t size, Error **errp)
>       static int sequence;
>       mode_t mode;
>   
> +    ERRP_GUARD();
> +
>       cur_sequence = qatomic_fetch_inc(&sequence);
>   
>       /*



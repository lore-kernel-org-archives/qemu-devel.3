Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E819C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 19:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFe1P-0002fF-Pp; Thu, 15 May 2025 15:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFe1N-0002dc-Eq
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:13:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFe1L-0005Xc-5z
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:13:33 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1qYQ016629;
 Thu, 15 May 2025 19:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=f+tXgLRN/yVtGEovntWurEGYHpGa+UJ8jLjDU1XR/Z4=; b=
 ATZS+I3JTBN7tJyiyGw01xBoUxul5kNxVR3Us/x6daTQzCDerVeFJNrat/hXdmB8
 1pTctYEw1lVtu02iR8eSc57IFX7WCO4TLxZ4xT0gToC/kwjlUNbQBP0mcHuied90
 ovRNHmpXZopZ34ePgAucMnd+CllQ2+WkT/4bYeD8jDNYmiu6ByQYcxdtc828/Xyo
 ODcIED8t2kR66bbZr+J44kOsxPRwsYlOJlmnXSLsGth+4+3AFCffPov/tPMghNal
 +i0kMBmDW5AkT7qV18MvEyaUPigtYe/AFcGiPckpiiV1wMx6cSMXNqM9Siefuvik
 vMO2MzbYwIviyBvMlrtrmw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcrn1w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:13:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54FIruQU004339; Thu, 15 May 2025 19:13:24 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010001.outbound.protection.outlook.com [40.93.6.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46mrmeh50f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:13:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8/dtTavCe3PVsx/HG/DXHngoJvKuW0ecRQyLUyls8E86EHIzC1hzxbzjkB9WPTfRvEqTxm3q5WpdqW9w9RX0h8BMm7vYwKbcxuVWBvTUOsyp+1gyK0lEIExHgT8J+g2QTVDonETnP6gRlGaxOq0vd4NWjUgs3CMibzw0zoJ2CvMOP9OAEeUvGl+4jexI1venzC+OtLowKw1pqfKoZ0Az3yU+PnemfytjcMPMQS55fvAt6qFsIFO8Ud8RWSHeGtIDwPccmrb8ViCWxv2R6VRcmuhBHbaCT8sVK/hWXf6NJ5vLo2qw/4jVguIjd8PO373YVJzalpUVE7T/eHZJLpmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+tXgLRN/yVtGEovntWurEGYHpGa+UJ8jLjDU1XR/Z4=;
 b=kDV3JOKjHe+sVVxY30Rt2PZ7esgTWaNzP+P66x80cxt528CFLty7Eh4WqXqCqNNYk6VdWMaXfSXGjyJa+QkYDVkIfQWtUbOWb2WnSe7QRJMOPs7B5iIZO25xGUHGYntMR77TmV7ibf4ejzAH1b2u4TwChH4cyOfojEwa82y8GSeTnY0hP1mD8YZn4NHZrnPnl4MRhlEqvLuymrOOIrmuuFDE96gfRey3RvYHuRRLCzC3mv4AO+GD6J0i1/5sTd8KAiJcHd8B4CTLChlAPOPefmtLSNyd3pESNwnbKgTtg8tpx1JDM1gZh0tKExKId8cxU9vgJQJDOGyf02zUFq/9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+tXgLRN/yVtGEovntWurEGYHpGa+UJ8jLjDU1XR/Z4=;
 b=fYcnOdaPDoaTw1Z+32ewlWmkCq8uJO1H3J5yG2PWPFfhBe7yjQw80fJNrfrN59G5PolfeDgragVHq153tUhxJ41U8Pn4he6CxfPmSLNOG5IDMG9buVJo/ZZqMdu2p1O01sZTZ98w0J9hx39gFos+wS5CZUxeTWV7Cd9owRKqVQM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7573.namprd10.prod.outlook.com (2603:10b6:610:178::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 19:13:17 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 19:13:17 +0000
Message-ID: <e2975fa8-bc9d-41a6-96c0-0e24a2a289a5@oracle.com>
Date: Thu, 15 May 2025 15:13:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 26/42] vfio: return mr from vfio_get_xlat_addr
To: David Hildenbrand <david@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, John Levon <levon@movementarian.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-27-git-send-email-steven.sistare@oracle.com>
 <aCJfQ2jJ-B5q8hRW@movementarian.org>
 <a1f5d185-445d-417f-bf0f-1e11c84c91a1@redhat.com>
 <c53f8cf6-fbf7-4182-9933-5c6ae1ed9d93@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <c53f8cf6-fbf7-4182-9933-5c6ae1ed9d93@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:408:e1::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd72a35-07e0-42ba-5abe-08dd93e48c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTlXV2tZNFMwOGJKUEhqM3RHNytXTjBkNGxMVC91cGprWWxWUkQvUHpVYTVF?=
 =?utf-8?B?NVBSU3oxbzFacnRLYW9VVWJXY1Bzall0a0tML1hQZG1iS0RwUUlMTzlsOHg3?=
 =?utf-8?B?Sy9qazVvazBpU1Q1aHY5blh0MkRKd3E2b0JWSGFwdFo4UDUwZG4xUnlxSUIv?=
 =?utf-8?B?WGFSU3h5MEhTQktqWktnL2JkMmpBanlwcVl0NW5PUWcrUlhDRXZxNGYzcE9w?=
 =?utf-8?B?Q1dBbkJKUTlsS1RJVHFKZFhoVTAyOFF0cDlBMmE1QUdTbXhDeXhRRkUwSGFr?=
 =?utf-8?B?TGsvM3NvK0kvQW1MZ1RvUmZSS3dVb1ppY2kvMlV6eVIyVk52OUVsS3BEbjBv?=
 =?utf-8?B?MExmYTArQkJxdjZ4eS9HNFJDc2tLQmpuTGxUWk9yTXVaYm1VWi9ZNXR1YWxM?=
 =?utf-8?B?M1lkUWZzUnhOZ1FuWTVaeWtXSjcvWUZrVjRod1BMbzdDQnRnOWNZYTgxNE8v?=
 =?utf-8?B?Q3NrZnR3VnF2YzBndGRycWVGM25HOFZwZklOL291ZXlvajVDeVVZNmZ3TmE0?=
 =?utf-8?B?TG1TSjk2aTNYZjJ3SkRtWkJDbElUMWZobVdiMUZFQktsaCtFMG12YXd1KzNR?=
 =?utf-8?B?SzgxRVIvVEx0QklCTWNLVUloT1pPWXk2Y0MwdmJuZGNIWFdhR1o2ZHRqMVIw?=
 =?utf-8?B?YmEzMUNXbHpYUUZvaHFmeHVhTWZrR1B1c244bll4VjgveGsrVDJRTU41clYw?=
 =?utf-8?B?ay9GMjJVN0FCOG40ajlaYmVUVldlbE9NUG9FNVRnYTRpZEZiT2hnZGVkSTVH?=
 =?utf-8?B?aklScGI3dFV4NFZPbkFJTDVNenBpU1BhNndVTE13cTNNRXdNRGtVTDcyR3E2?=
 =?utf-8?B?ekY5c3ZXaDQ3RVY5VzAyVDhkazRPRVQxa3poZWQzTHh4NzkvL0lwZVhVZUQx?=
 =?utf-8?B?c0FKZGp6V3pTdGhZNUZzSmRxU3dJWExyTGl1d3RmQUpVSjVZNzdzNnlCbzdw?=
 =?utf-8?B?cGxDTzZBUGo4YTNKMHBLMzhBNnc2L1pjM1ZKNGxpZ0E1aWh0bENCVVdnRkli?=
 =?utf-8?B?V1RSL3laa0NwOFZycERTVkczVnk5QVR6WThZMzVDUmVqd2tZN2hFRmpXOXFa?=
 =?utf-8?B?TW1JdnQ5QmlTdHVTamxaQnM1MWxWOFVuNThrMzQ5clZqdUU3dmw2a05EMTZ3?=
 =?utf-8?B?UHV2TTEyS3dheVJVQzl2Wkt3cXFaV0M3ZHRQSTZNcldLOVFYZ0NRd1JNajBy?=
 =?utf-8?B?RGEwNGlQZjV2MTlpQ0ZoeVNQSFhOR1ZCMEYrV2ZSKzdnRlJnSDY5R2p5OG45?=
 =?utf-8?B?OHhHSERYOGZOR0svb0xqeHdLWUZMbml2VVFqSXMrUmliV3ZMb1puTmhUQ1pL?=
 =?utf-8?B?ZzcybEpRT2ExcEdBYS9ENFp6a0QyV2ltSS9odS95YlhXZm5vNW1tL0VYQjYy?=
 =?utf-8?B?ek9pM01GaGd4SUExUTc1Qk96dld1VmNxbmZqOVFnTFJHSmFaQmVmL2xIblhF?=
 =?utf-8?B?NytSL0hha1ZyTllMcjFwdi9MLzR5c2pUSTdXSmR4bkdyaEN4M3g5Z2VVVXRO?=
 =?utf-8?B?R0Mzb1k5OGtXQkV4dm5wQjJiLzJyZjhXeHNmMVlXYmdETU9tYUswSjhqM3hw?=
 =?utf-8?B?Q3V4YVhEaVVRSVcvQmtZOTNrMTdIQnlEbkpMV1BKR2l4VlVCZ2U4TUlvQi95?=
 =?utf-8?B?bjVXR0JmelZrcG96WUhTSUZPcGJhK3lPd3VCRUd2MmdwYklLVkVpYkE5anh2?=
 =?utf-8?B?ZGhJZDF4V3hvc2hsbFdWbUhmSm05ajYxdmVaUjZibFRxcUdjcXNlYWQ1eXlC?=
 =?utf-8?B?QjVoVUtjTElxdERCTlU3bklwYXYzeWpIYlNiSHYwQmlYYkZVVGRoeTYySFRx?=
 =?utf-8?B?WVJyUnQ3MTJoblhyem5RaUo4UlU0cVNheEF3bXpqTlV4ZHZGaG9hNFBidVZB?=
 =?utf-8?B?TERCL1VJbkk4NnJoZWRFayttVHlORVpxc0hsVEgvbEhnUktKNlVvUjduQVVO?=
 =?utf-8?Q?I64CTNok2uU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1dNamVtcWZ1eUVia0Z1dFhCTjNDWjluUmdQcXZHcENudjFDMTBDRnBNQVg5?=
 =?utf-8?B?RWRuYlU3S0VYSU1nOVZJN1Z4cFhRSk11MWJ5bmpGSUtNdFhtdXNpSmFGbTZJ?=
 =?utf-8?B?eCsvSWdCOUNubjdOVUlSQ1VNTDJxbU5kRHNRUGo1bGhNams2MHpCeGJrUWg3?=
 =?utf-8?B?RnlKVTBTOVhKZVh3a3dYbHR1ZTU2MVhjWVU3RGp3bU1QOVZNR0poZ2c1WFNz?=
 =?utf-8?B?bkxMTzFuVk1QVHVrOEVSQlRuMmRDWHdjWllINmp4dGlBWU51MmJwSEZmS2Rs?=
 =?utf-8?B?RXJkbHNOb0lPamFCRkNQM0VTR2xleHlBQ1JuTjBZbTFXWDBUOTg2eEtNaUh2?=
 =?utf-8?B?YU9WbTBodmEzakJhTnNGVDJvZHlmVzNxdjRXVzlJRTkwZFBEV1diUmFzUlNR?=
 =?utf-8?B?OWhKZWdlUW5teGg4SDJ0V21acmNNdXZ6M2ZuZGR6UzBLUjNBWUVlQ0JXWUJQ?=
 =?utf-8?B?MnVzbkZScXBRMGpjQ1VkWFlmWnJrS2dtM1F3WDhmUEVnWmN4YytjWlBuT1lG?=
 =?utf-8?B?cU1FcjhsL01sSUd1QWJQN3hTZ1Z6Q0NFNkIrc3lnT1BBMHphTXpENHU5ZDNp?=
 =?utf-8?B?ZzJ1WExEVURyTXgvK1RsS0hhZEJBeFNoQmFYd1lwNVNHTEk0UTJacW5Wa1Qz?=
 =?utf-8?B?djFqSXBMWG9qVjVEbzlXWk9melBnQk43dGZ4VnQrOExTaTYxQ1lCbVpOaDVG?=
 =?utf-8?B?eWt1S1d1REpkakhiTXFRNExldE5xbkhyMlNiNHVCalNwVlRJdTZ1eWZieEht?=
 =?utf-8?B?YTB6aG40ZWRReGtEeitsL2pEYzVrNGZWcGY2bDQ1elgwcmhjVzY1eGY1T0Ft?=
 =?utf-8?B?VTlxRjl1Z1pJc09tdjRld3dVQkVyUGVVVUx2MzZseW4rQ01ac3lYOTRQeS82?=
 =?utf-8?B?WklJWVY3N2c1aGRxWTVBTFNpZkdzeTAzZVFndWZhMURSOW1xeko1dkdhZSsr?=
 =?utf-8?B?SmUwUmhjWHprRE9MYm9UQWxuZmx6b09wMXJ0REdhaldYRWgzWmt0ZlFhdmxx?=
 =?utf-8?B?OU84YzF5bGFWbmE3Y1hOTFk2M2luVXVMMVVJK3ZiYlBoUEZ3RktkeENjTG1t?=
 =?utf-8?B?dURONGdqbWZpZE9xcGtDc0J1c3VleWo3b1lrdmF5Y2hta0ZLa3NINERqdmps?=
 =?utf-8?B?Yk1Jb0tVdGxqRTFrNDd5UzY3UTVlYWZhdWlodVAvTHlBL0xDWURBaERFbGlV?=
 =?utf-8?B?K3pQVkhkRS82aURkQ2Y4dFduMzlnck9HMVF3RHRhUFhHV0w2S2hGT0piYmFm?=
 =?utf-8?B?RXZQVWMwNDZ1cmlkeDNxUjNwZFlGYnhtd1Y4TWRiOUpNQUFJNUVNSnRIeUlH?=
 =?utf-8?B?a0QyQzkvVnk0aC9JRTRWa3JDU2MzY3c4dTJ6c1YrM1g0dWhvN1lxV2tHTkpZ?=
 =?utf-8?B?Qy8rMzlxcEgxVFpSbnNZUUdmbUVKTnpSN0xBMzFodEZRaEppY2hoSTFMNXNI?=
 =?utf-8?B?Q2xBNmtwRUtreGNhWUV2aUpFL2FpelpUaGE2RnJMa3lZbmc4WUxvbElQQ0lM?=
 =?utf-8?B?cWVaRFhpWDJMbFRXeDFHN0tJRTR5S0lzRERZNk1GSVRITG1aNDhvbzJhYlRz?=
 =?utf-8?B?dkpTUnNtMWJhaHlodjhxRG5NbnFraFRRS2dwU0lCRjVYakFlMlZQZDRnZlFW?=
 =?utf-8?B?cnFPOGh4di9oUnNONUZYeEFFaXNVWmIzK0VDOVdqNEcvYS9ZcGtMdEVJbk9w?=
 =?utf-8?B?eWFLRjFxTDArU21ycUhXSDI0cnF5alozUGFJaURZUENrYmZtb3RsVEF1OGQ2?=
 =?utf-8?B?a04zMlhEWC80MWtTaTNVcFBTaUZFd1lNYkxUQ1VaeWFneTdFbjJCUk9xNnpn?=
 =?utf-8?B?NjFVeWZnUlhyRDB0RXcyNVF1ejlTODVXODRURFhRNXVtU0JONFNiVk1Kankw?=
 =?utf-8?B?SU95Z2wvaW5qZ2MvNFU4VU9WZmxnNWhJbGdkSFZYT25kY2ZsY05qS0tGb0Y1?=
 =?utf-8?B?bndJZWQvc3Jzb01Oa25WdWpabFlsdWdTMEJBKzFDMjd5ZUIzaVpKdjEwV2dB?=
 =?utf-8?B?OWYxM1hueHlaMjFkMDR3OEl0ZXRzN2xPMDBhdmZicXJwYmVOUko3SkNJbVdP?=
 =?utf-8?B?TWttbWtxQkdFbzdVcGxIYnMrUEtyWDdxYVpMOG9vQVJ5WVlKSm8vOWhXc3Ns?=
 =?utf-8?B?Z2xleU5xQnFuYWFVdHFFNVR6eUE5NGpxcHRtQ3hWd1VvdlRRK0I4N1BMQ2Ry?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2nBaehrqk8LN3bHwmtwDWz41gdNX/n18BXyEO86c9ktD2iqnHh5D5pOOsOO9aJfaYpzn6Wud7bcZVP4PLOo3EkwtRWM8r+f28XpSi4pRGQBIo479l6Zukieuvx1TRuw04eyWgB6WMlyYhnR0Q79bgssFFsGyuS+VY0D7qE2ps4fORb/Hw7V+56IWsWjgLEIbFc6mWc8yc79Kmqcq11kkj4PLc7JmUiQs7Eqr6b3D7BIUhB4+xM49ianr92xLzsp5FgX3CuVqdaPt+EC9D2cb88gUkjlbOujIAXzb6qwkbXqftkkI4MY4l3o9A2a8fDdj+Cbk8CoSSQag92mAu+dSojhBDQU2AebMYpJitsryfTdLhNDcMyAwyv9opsWP6k29IEEh0/dZ8q5TLS6YN5qJFE0+Vl2KLKI8rY/QKwJpz+n4Yp7OpqYw/V98y1ZZv0r6CdO4n3/zRoeQWVfQi7vnFantjQex4n4uGBu4kMsobJm80hbM9h74WMwlW++wtXlFSKSZVpROQanNlUkqg8LsBSburbs7N4PlY8tPh0YfIFUlRZHt9YRFfL6re+BHTPDBx3wR3JKdw/+52oggfiRh+QBiwdoXjIzkl3eApVsnOSg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd72a35-07e0-42ba-5abe-08dd93e48c24
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:13:17.1203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bede2K8iy0LGk4oFIQsDhqHq3TnxlvB/Yu5ZWrmwWkT8W8xqk18ArHgla1E46VE10AFgnO1byhrjRbQ8sFf7ki5f+ZTADXOC/Tcbh5KadxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE5MCBTYWx0ZWRfXzvr63x3N9QMH
 T5nkavK+KAJOWLCDC6OeIRlIDjG7AaFewolH6ab6VtJwg50Vl8F4vZ5QtrN6cPzvtXiXKJZjt09
 rAzI1SlNC8Ma55Kic1hkaVlSxh7E0Ju4Bo2D3twxFKkbnXja65+KkJRDzmez9w1Rcnr5rBYtqb2
 pt021Lq26dzNDXRYNmwlX7CuHFQa7BXIYFP6ijEzWcb5n0TkMjzKdpJIYkQVCARs8dmjwxV5h8u
 ctK1XiCFaL8HdBOBJESwI4TYK8HR+P+BWSUrJ1XMgq0HVa5MHw8hMvj+fSZixu7rb3FQ4KT18vu
 c9FXocBFFq9TuxRzcV/GT4h84gxT1I8XZA/xfuwd63FkA740KiSLo5Zmk1nysq7R+Z/h7N5c8r0
 Zcj9jXQ0UGGX3mspyA7W7vJbJC2SmcGwUWuoctv40BIZpX8fi8du59vwVasUW/bl3BhjQnB2
X-Proofpoint-GUID: nUKD7VqJUlGkKYHnxA3f3b1fIsUDz83E
X-Proofpoint-ORIG-GUID: nUKD7VqJUlGkKYHnxA3f3b1fIsUDz83E
X-Authority-Analysis: v=2.4 cv=cuWbk04i c=1 sm=1 tr=0 ts=68263cd5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=JYBHAMXQV02heQKA-NEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 5/15/2025 4:22 AM, David Hildenbrand wrote:
> On 14.05.25 19:03, Cédric Le Goater wrote:
>> + Paolo
>> + David
>> + Peter
>> + Phil
>>
>> On 5/12/25 22:51, John Levon wrote:
>>> On Mon, May 12, 2025 at 08:32:37AM -0700, Steve Sistare wrote:
>>>
>>>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>>>> region that the translated address is found in.  This will be needed by
>>>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>>>
>>>> Also return the xlat offset, so we can simplify the interface by removing
>>>> the out parameters that can be trivially derived from mr and xlat.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> Steve, would you consider splitting this out from the full CPR series and
>>> submitting as a standalone, as we both have a dependency on doing this, and your
>>> patch seems much nicer than the current one in vfio-user series?
>>
>> May be we can merge this version if maintainers ack the change ?
> 
> The change itself looks good to me. Now that we want to return the mr from memory_get_xlat_addr(), why not make that the return type (NULL vs. ! NULL), to get rid of the boolean?
> 
> MemoryRegion *memory_get_xlat_addr(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
>          Error **errp);
> 
> Same with "vfio_get_xlat_addr".
> 
> Of course, we could consider renaming both functions to something like
> 
> memory_translate_iotlb()
> vfio_translate_iotlb()

Sure. I'll post those changes tomorrow unless someone tells me not to.

- Steve



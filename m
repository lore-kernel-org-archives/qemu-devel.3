Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38718C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 19:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIXvl-0003Cn-Cv; Fri, 23 May 2025 15:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uIXvc-0003C3-CB
 for qemu-devel@nongnu.org; Fri, 23 May 2025 15:19:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uIXvY-0000T4-Fb
 for qemu-devel@nongnu.org; Fri, 23 May 2025 15:19:34 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NIhZsP003367;
 Fri, 23 May 2025 19:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ynaOOKWwjfJ2MUf7SQqLZrkCL6/ul5kABOGOyM/E6HE=; b=
 YKKK/ImDrA0RWXK9I0TAAlKVPj1IpkNFMwN0JQAbwwS6dDVG7jmklZz+62Aks/pt
 KjWTje7w9irAOyLoFZzlBop5Hane35PifyWflBMtXRQ2ei3igHyh2M97DOJq4NWu
 dfahHQCWHjgs+djPcB2S61aaXFeJiNEriui5sE0spVDebiEpX0Mr5RlJFNuu1qVg
 C7sl/6I6e0H33XgJPNJ954sECt/2K8/YqFPtHF0XuRJGojRw9bkNq8IX183yGmwP
 lUJ9TCjB5bBM8TPVuc5ldzmnlRr4ZIiZ5KElLrT/ATQamWeKtWLHX2aCfHmN460M
 YW2KB25MhP7l4ekJDbyV8A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46txhxr1jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 19:19:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54NI5oMo032090; Fri, 23 May 2025 19:19:27 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012051.outbound.protection.outlook.com
 [40.107.200.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rweqd6yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 May 2025 19:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFpc6Mz4PzcudYOukYmUXPKQQlNXoPlYfNh7YNfJeGJ8fyr1B0NU2Zz72fFSgV7bOcgC693Rb88E1CcHgtbaY3cpU7chVgTzAyzHMLzllKMJe49rHKIKi6IcnR+Vh8KkFWdCcnRlQaDt2pIgC+Y8qyv+xbuUH7IzT4tdyJw1r8BQe48FywTQ2htXMWUHUuoQRyVjZJXrSkewaw4IOFeMQ2ETh73YtZ6OYetiK2xBJs2dEOoYn3tESKDQzoOtxX4l+8JGdObuHWNZ9fi3NDumESFWow3Sli6LM8/vwlxNPAVVylDjzVuRLclj1aw3IrK8tl5EpeZjYpuUUwiISKwthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynaOOKWwjfJ2MUf7SQqLZrkCL6/ul5kABOGOyM/E6HE=;
 b=FO/0xdzBRkhkzWWgTmQkeP9vjx+GgnCNJBsmagbrKAkfn1xq7+J96Ky+PFNUudlsSG3GblDWbYeaOAKcL6ylfZy+zBacioDuujlZoNOECbWJWBjb/DHTw6xjzrsUY8okNvD7ydQ43bardNVwRKAaNvM99fF74d6qlDlykQzyojjyLnZGeqqFDfjxD6HTA5XI99b/hsifqXmQkEZnX3gnd7GgXjGaLOq9BVU2GzqYuHHwHJQSOUE1vW0eEs+lvi1FlsNnhvP6J55Pg76bdHqHn6rKSc6S7rQ7O3gPNJaQWotYG+5cTx+JF7m+MXFM9gHOq13oXCdL6fLiIMNFhlF74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynaOOKWwjfJ2MUf7SQqLZrkCL6/ul5kABOGOyM/E6HE=;
 b=Injk1Hw+bzbcdhX86QZDOM9Z7rJnx8DOXqcZQ9N0q/osAVAJ3acwOMbgOP5kJ7SYda4JVIIhrklxddbw0lM0o7zElzBfP8DhEWw2PXiciW0GaUMgySj7PCctu7oXC1m10M4TCefwAKmm93ng9PgCr9YN9TkMcVdX933ikqOZ6HQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8465.namprd10.prod.outlook.com (2603:10b6:208:581::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 19:19:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Fri, 23 May 2025
 19:19:24 +0000
Message-ID: <e94d85b9-00a0-455c-8645-c439d90c5a55@oracle.com>
Date: Fri, 23 May 2025 15:19:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
From: Steven Sistare <steven.sistare@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7aa3c76f-a171-47b1-a56b-5fa16e38f4a5@oracle.com>
 <5c151081-07a9-4569-a3f5-4b48a6f1a1e3@oracle.com>
 <SJ0PR11MB6744AF83E1B9956A76F529D3929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c0db92f1-5bc9-413e-b0c6-39f9eb40344e@oracle.com>
 <SJ0PR11MB6744673E8B958DB5E408D90B9299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9455e537-7426-4332-8d7b-4c6260086ea0@oracle.com>
 <SJ0PR11MB6744E8AE3F29A924FB0866E09298A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <4ef5640b-17af-4692-91ce-529735a21474@oracle.com>
Content-Language: en-US
In-Reply-To: <4ef5640b-17af-4692-91ce-529735a21474@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 4377ce5d-2910-442c-e179-08dd9a2eba86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVhyVXA0ek9WdEdFbTlBSnZiTTNHSTNUZWZaSnpqemgyTFdyc0pnRVNiQ2ph?=
 =?utf-8?B?NjBkemd1QURKTGtldjZHc2J2L1lENEZCRXBpTm9JWkVCK05ZMVNYWnZJRG9t?=
 =?utf-8?B?dmloYVVFMVVXY0ZhekZndFdBVncxTG83S04xeEZ5MVlJVERZSHFDSVdpM1N2?=
 =?utf-8?B?YnZJUGFscGgrQWY3NHpoS00rUVY3Tmx2a3c4SmZjcm56Ylp0anlHanZQOWMy?=
 =?utf-8?B?QVdydjZQajFJR0ZGZjUvemhHVEQ5ZkVNQlNPdjJKa1JuSjNSN0wrTHJjazlB?=
 =?utf-8?B?dDBDZkQxK0kyVStuNERwUWhIRlBKOVAreGMxTFhXbnY4TlN6eUgrbnc4UHAy?=
 =?utf-8?B?MFZRSWN4QmtsK1c2dHhwNHlSS1FGNXpxcmZTTXlDZXZTT3VSL3hTcmJZNi94?=
 =?utf-8?B?dkpDT3VLSWNMc0pDZXlqSGo3d0V5RDF2NUNHd2I5ZGFLUXpnNSs5UjBqN2dn?=
 =?utf-8?B?ZFlHMlphelBKUDdjL3Z4Wm9XT2owNTRCUndpWk8xNkhwR0RwazZNZVJGS1g4?=
 =?utf-8?B?YXpoWE1UdUFocFRtaWFlNlRoTmVvd0daaDdMZkpidWtkTHFTZUdOcGdhSElX?=
 =?utf-8?B?YWlhczkxZVpEK0xTUGVsOVoxUUNjbnpvOHg2dC9QNzZacFBPMU1tNy96UXZk?=
 =?utf-8?B?em1kMWI2aHRBQjE4UEYyVllSLzlMUy92Z1VmRXp3Rk4ya0xqbFdxKzhWR2Jn?=
 =?utf-8?B?UVVtTkJOTTVFZFRNUGk1bmRSVkIxeEVaY0Z6c0RlVEdtcDJkSE4wVDFnRHBZ?=
 =?utf-8?B?WVhVRzh5Y0xIc1hydzkzYjliYS9scGo1QXBRUHNBNVNUbTVMRVBBYWhQU3dh?=
 =?utf-8?B?ZmJmdVpRYUZQOUd1cnR5TW9obUxpYmlhWkZ1d1JwaWdKWEU0WFhyMVlYeHlE?=
 =?utf-8?B?c1k2Y3JqWThsTzlLQzdQV3JGdkJINHhuS1FzNkNmYm5aeVNsSUdIV1pQY2t0?=
 =?utf-8?B?aFdjdTFXeTdtMzVJQ01qcFAwTlR0VW1rUHQrZHJrTmgwVVdOTmMxVkFtWnRB?=
 =?utf-8?B?WlBEaTArOWVzZUdBblVFN25mOU10Y3YyTVlpOVpMMzR0ZldvdjE5UmkwWXl1?=
 =?utf-8?B?M3FUU3FvbFlnUyt5TEZ1R3d3b1Z2NVlRc2wwZk96Ky9oK0RkV1hvdjVBMU5Z?=
 =?utf-8?B?dW5ieXVXbUZtTTN5dFdsY1hhYnBxL0N5QUFXRmNBTnZJRVBWYit4UXRFNmlX?=
 =?utf-8?B?NFQ1enJTVjMyMU5RVytxaFFXZnhzSTcyUGhDSWxGbEVXZ2gxd2tZdWxtY3Rt?=
 =?utf-8?B?V2ZFdFlPUUU2c3JNendaeU5nUzY5WWlDOGM4WWdBWkFDR1liaWVuRW5CMGd2?=
 =?utf-8?B?NEZwWlNpUlUvZ0dWZy9DUVZaSitqSFF2d3ZPWEpkdDJVWktpVGZZNm43NWRn?=
 =?utf-8?B?OU5aNkI3ZFQ5blNyQ0VOVDRGcHYwYnJrTXNnQXdDR0trZ29sRHlnQ0xGb2hD?=
 =?utf-8?B?aHZkTldDblE0MGxoNUh6Rkw5dEduR0tKSTZpdUkzYlNRYnI3V3pYUWZWem5Q?=
 =?utf-8?B?b21ZNFpuR0U3aGZuc3dhY2J1QjRBK1NxUXB3WG1JeXZZanQzb2tSa1BFbzZl?=
 =?utf-8?B?a3lIeXR0TnIxWVo3eWt6STF0VmIzb1hqVGNwT0J3YlQ4b2hiRDQzYThkcS9a?=
 =?utf-8?B?YUJnam5yRTkycGptYzJ0NGZPLy9LU0xCZTlwMWIzQzhOWDVQTG1yd2s2VnJ5?=
 =?utf-8?B?c2tuRVpyRm9wYWs3TzVLc3p3UXdkajJTb1pWT0hhOXNPQTlreGhCYzMzaWlG?=
 =?utf-8?B?ZnREbnpCRXM1U3YySGdoTEtPbGZHYmhZemJnV0xzRDRqT3c2VWhMZ0hnZmlp?=
 =?utf-8?B?d1BNUE1QZUhRSWtQWHRnQnp4RVl0bGtvQU14OWthMDlQRWRYY3JzeUJ5TG9s?=
 =?utf-8?B?NE9JN1hTMFJGL1k4dGx2STM1K0lmeDVkQWk0em1BUjAzTCs5eFhPTjRkSTdm?=
 =?utf-8?Q?iof0Y8z0ofI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRNbUN5SjZQNi84bGl5ZzdoYmJqc2FvRXE4d1RZSHNxNEE4MVBnVzZMV0R3?=
 =?utf-8?B?cVJNL01xZHE4ZGNITVVQME00YkY3SHc4K29wTG9wTWFaMTNQMXNnMUFqU0w3?=
 =?utf-8?B?bzNld04yZVh2T0xNRW56aktXL0VvaUJ4VTlCZUtnamRlS1lhbmVEMUV5U3dw?=
 =?utf-8?B?dXZNTlFVUmJvRDUzTU83MysyVGc4U0RtcXRTc3ZCU1oxaU9FcDNERTJLUVBD?=
 =?utf-8?B?OUVURDltN2VBWjhZRXY4bEdPRzByT203S2orTzkzK0JVdzI3TzIvRDU2SzdE?=
 =?utf-8?B?amF5K1pBUzNqdVdPUlIrYmhENWlaNHhzK1FHYm5mYWpXYUkxbmU4bjR5NlpS?=
 =?utf-8?B?QTNzN0RJeU5FdlJvckdVVHNQOG5NTEpOWWFjcDRpQW5yYzE4VXNRM2hjdWNK?=
 =?utf-8?B?VmJWSFhxYVVQRXFaQ0xKWmFoeG1IaEhuNFVabVY1YWpTUmF5VEdMVUJIU0Jw?=
 =?utf-8?B?elFmMTRLVzdLZk40TDk1djh2cUI0SmhoZncyMGpRSGxEeXBaTnZvODl1MGQ3?=
 =?utf-8?B?czhCQmIrVU1LQW5zY25sQWIwVmIrQzJMcnAxRGlOamVKK0Y5RlF1SnZDOXRu?=
 =?utf-8?B?SjBZZ002MUpPMHAxc3Q2ZHB5R21tVzVKUS9sTWx4cDNFZlpiYzlnc0dKQmpS?=
 =?utf-8?B?T1c0QWxxSHlBU203WFNUSW92WmpPelBsRStxWEtjUWxkYlhodFJaR0NkYWlx?=
 =?utf-8?B?NG5JdnM4NjNqUFNVN0hUb05YK2FBM2hPR3ZGcTN5NEMzejhKdmxQbVI3bmRG?=
 =?utf-8?B?WEs3ZzNCQmM2OEJFaU5mN3JWVGF3emsvR2lRcVkxUU1wRnNDdm1TVDNVSXps?=
 =?utf-8?B?WGwvbnVIYkJEUTJPckE3UUR4SlhobVVLZmVLRlhaaEtBdm56emJrNnlrcXAr?=
 =?utf-8?B?UERpTHdNb3VFRTQzRDZOSGZMMmNrS3hjemcwV05RcUJpa3V5YlpCaFhzSGp5?=
 =?utf-8?B?RERRMDVEM3JsNkM5T0VDeU5ta1d1Ukt4OWdPZ3FhQTh3Y3NMSVJ4aHBLclgz?=
 =?utf-8?B?azMyT3pSRlB0Si9VMGh0K2t6aVVQQko3VVFocXQ1cmI2UHhYd0UxOXZVeVNX?=
 =?utf-8?B?MUIzWkU1RWcwSVB0VHpNVmhOTlV5TWxQWE1xd2ZZUnkzd2dVeU1TYWRiTFVI?=
 =?utf-8?B?M3VZWit2K1BTVVE2VGtHa3dNai83SHE4eFA2NTFaZVVoenpPWXAvYzRBNlZi?=
 =?utf-8?B?MkJScXd4aDlubWxQUXVlVlZRUXo3RTNyaE5IczQzNjVobkd0UlIyNlZram4y?=
 =?utf-8?B?a2RHUC9Yb21idThoZFN6R05Hd0RNSXRyZTVtVEhQc09aalZEekNvNXVhV0hS?=
 =?utf-8?B?b2FFcjl1U3hGUWVBMThqK2c4TkRab1JybXNnMWhua2FaN05wMGNVV01Pa3JW?=
 =?utf-8?B?VDc3NXFrYlNxUkpHRE1OOE9DbDRrdjRGSTVuS3FvanYyRUdUMjZuclBzRTZx?=
 =?utf-8?B?amlqbTZFR3N6dHFxOHhhUVduZGpQR2V0UkhhdW9NQ1RBaTJxTCtKblMvZjd3?=
 =?utf-8?B?ZG5nN2Z0NlM3aVhteVJiZDY4czgzV0dOOWc1Ti9GSWtjY1JwZk1rREFMT3R1?=
 =?utf-8?B?RHFMSHdRamVEcVBTRUYwRUdkZ1dWRFg0dmI0THBlaWJVVSsxZDlUV213YWR1?=
 =?utf-8?B?TkZ2OU9DYytvTHF6ZlVhdGVHTG83N0Eva2xWenVWU1dkQWNYTWdaRmNURVB5?=
 =?utf-8?B?ZW1wL2JNa0ZSTmRFaUVSMWRWT3R4WitwblpaMU5SYU1IVThsNW9sSXNZQkZP?=
 =?utf-8?B?NUVML1NnNGswUm9uZHV1UmxSb1lpSGVndVIzU1BMYU5GOUJvTVVwNXBTMDZp?=
 =?utf-8?B?OWV5dTVHcGVyQ0VNSnoyV3gyMlFzSUtxL3NjK2x1RUxxcnZ0SU9FOEVsajBM?=
 =?utf-8?B?OWxFWDNpSk81M0Rod2xtR2t6bTdXb1IvUFJ1K0FtRnFNZEdHblQ5WVN6clpM?=
 =?utf-8?B?VVhNR0RDeDBySThXNkducEw0R1JSUUc3dWVxa2pRcEFxaE4wbWY3ZTgwa0sr?=
 =?utf-8?B?ekpWK1Ivd2libW8wTFo2WjVqRjQ2YWtRRW1tRERTUFB6Unl1YmE2bWxsU1dh?=
 =?utf-8?B?dVZpY3pIS3RmUXNKa25pREY3YWZUVU40RzMzaTdEU3BpalkrOTV3cFN4Mkpl?=
 =?utf-8?B?aGZFMENPU0FpUWNoY0hLK3Rnb0VadTZ5M0FHN0xOZVlXZlZQdW9pVk9GTS9Y?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rBow7NC1u0h0azL5V04kyeErUaIp/M2hzf4oPecaHuZ+w0NXlkay9nMUIj6qNXdbSZP2sbVJnlTgH3XbUEgoFi+x3N/a9l9Qza1NuPklN2yzpI/toShTZHjO9uLYKijgx9YKEEZh8n105VPedD6apVJn8QgQOjmpjJkFJ2cIyXIqYv5bsc8mQW6+XGSQ9ZQugPQ/WZrjx9Dis6z3cHN5S5QxCd82s69ke/xqY75GgXACroxLG4wCdSyu1ubYLVofqZ9fA7P66tORjSNSXIy2Zt6TpIGbLm0u0yfyLiCuUo6EztmVpSJxzkiy/Xyq7yBuS65z0wjQ28F9nd4RPLv3dPMPuGtH+h04ba4nQL7jGbrBXDJFEUifwPMl6Ni9QVkkZAPLDXsrA6gHK90Mxc4vVdpjTCJeIzukmOwbFnvsMQ/Q55devAFTeFjN9DqCauY99EMAFd5Bxw1zeg0VQUx4wFWQE8KLHNdXUcqjEa7ZbljWa85k/O8jg611xpAPYI8bvBz+/WfVOdeIs0e5FveVRzE8btbvAqji6kc5SGP7691FAEfcwxjvd+0O6ZI/pzyA7xL9YKa6q75NsHudyBFTv66bT0bIFFThQe1SxdbCbRM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4377ce5d-2910-442c-e179-08dd9a2eba86
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 19:19:24.7516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMqUYAqYHJ9YxX78qywqtj4h+gffGkxXHsBNLVIETrdsn79HJZFdfdNe1lcvvvLdj3rFlsTmeXrSbEU+tFWx5QWTa0JOafoavQpGu03SgTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505230176
X-Authority-Analysis: v=2.4 cv=fMU53Yae c=1 sm=1 tr=0 ts=6830ca40 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KYQYQKLSGRRoz8BM9MIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: f8JLBGfR2kZD2wUJsw-cKATEoKcAizFH
X-Proofpoint-GUID: f8JLBGfR2kZD2wUJsw-cKATEoKcAizFH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE3NiBTYWx0ZWRfX4w+Y5AODHb+r
 3OslsiOBUJYiJfLW9vgi2rXuma+rlft+thkcBZwtR10qYJJSnk+QDcLfTGjdOdKOyw6Q1kIqwjE
 ySarFYdKXk1V9gfdwjBvYseOMtLXMj+WOm3v17JhzXaYjIpaSPTUxW2oSQ2gdR9VOT4KgcDfAe+
 o7RPtWr9MjxOOjJHWg1hVsyQ6XP9gnc2+oURz4Zye9yDdvczi9bwaw4xc5uR0yUECsa4y5aSW6l
 v+pTckwJjqP7qvuPBdt0etJeYn+oFlPAcDxZPxFWxkHXrEshMurwWo/7Mwe2ygtGcUEA8R8PuiT
 dSbCKbggG9ijthXbvSGCs7CuCiKrG6RqKc5DwRGRHEF02pIuRrAy8YC4/o63a1N3uT/YDTS2oMK
 q+DP/KAeskWYO4D7OZe49KB2NVedDgylhO4ssQmCAkBwYkSCakpR9qgr6D+udp7rvGBm1hUw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/23/2025 10:56 AM, Steven Sistare wrote:
> On 5/23/2025 4:56 AM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steven Sistare <steven.sistare@oracle.com>
>>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>
>>> On 5/21/2025 11:19 PM, Duan, Zhenzhong wrote:
>>>>> -----Original Message-----
>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>
>>>>> On 5/20/2025 11:11 PM, Duan, Zhenzhong wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>>>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>>>
>>>>>>> On 5/19/2025 11:51 AM, Steven Sistare wrote:
>>>>>>>> On 5/16/2025 4:42 AM, Duan, Zhenzhong wrote:
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>>>>>>> Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>>>>>>
>>>>>>>>>> Define the change process ioctl
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>>>>>> ---
>>>>>>>>>> backends/iommufd.c       | 20 ++++++++++++++++++++
>>>>>>>>>> backends/trace-events    |  1 +
>>>>>>>>>> include/system/iommufd.h |  2 ++
>>>>>>>>>> 3 files changed, 23 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>>>>>>> index 5c1958f..6fed1c1 100644
>>>>>>>>>> --- a/backends/iommufd.c
>>>>>>>>>> +++ b/backends/iommufd.c
>>>>>>>>>> @@ -73,6 +73,26 @@ static void
>>>>> iommufd_backend_class_init(ObjectClass
>>>>>>> *oc,
>>>>>>>>>> const void *data)
>>>>>>>>>>         object_class_property_add_str(oc, "fd", NULL,
>>>>> iommufd_backend_set_fd);
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>>>>>>>>> +{
>>>>>>>>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>>>>>>>>> +
>>>>>>>>>> +    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
>>>>>>>>>> +{
>>>>>>>>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>>>>>>>>> +    bool ret = !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>>>>>>>
>>>>>>>>> This is same ioctl as above check, could it be called more than once for
>>>>> same
>>>>>>> process?
>>>>>>>>
>>>>>>>> Yes, and it is a no-op if the process has not changed since the last time
>>> DMA
>>>>>>>> was mapped.
>>>>>>>
>>>>>>> More questions?
>>>>>>
>>>>>> Looks a bit redundant for me, meanwhile if
>>> iommufd_change_process_capable()
>>>>> is called on target qemu, may it do both checking and change?
>>>>>>
>>>>>> I would suggest to define only iommufd_change_process() and comment that
>>>>> it's no-op if process not changed...
>>>>>
>>>>> We need to check if IOMMU_IOAS_CHANGE_PROCESS is allowed before
>>>>> performing
>>>>> live update so we can add a blocker and prevent live update cleanly:
>>>>>
>>>>> vfio_iommufd_cpr_register_container
>>>>>       if !vfio_cpr_supported()        // calls iommufd_change_process_capable
>>>>>           migrate_add_blocker_modes()
>>>>
>>>> This reminds me of other questions, is this ioctl() suitable for checking if cpr-
>>> transfer supported?
>>>> If there is vIOMMU, there can be no mapping and process_capable() check will
>>> pass,
>>>> but if memory is not file backed...
>>>> Does cpr-transfer support vIOMMU or not?
>>>
>>> I don't know, I have not tried your sample args yet, but I will.
>>> With vIOMMU, what entity/interface pins memory for the vfio device?
>>
>> Oh, I don't mean virtio-iommu, it can be intel-iommu or virtio-iommu for this issue.
>> I mean when guest attach device to a DMA domain, there can be no mapping in that domain initially.
>>
>>>
>>>> QEMU knows details of all memory backends, why not checking memory
>>> backends directly instead of a system call?
>>>
>>> IOMMU_IOAS_CHANGE_PROCESS is relatively new. The ioctl verifies that the
>>> kernel
>>> supports it.  And if supported, it also verifies that all dma mappings are
>>> of the file type.
>>
>> But the dma mappings are dynamic if there is vIOMMU, so checking dma mappings are checking nothing if there is no mapping in the DMA domain.
> 
> Yes, so there are 2 checks:
>    * at realize -> cpr register time.  if cpr can never work because
>      IOMMU_IOAS_CHANGE_PROCESS is not supported, then adds a blocker.
> 
>    * at cpr time, in vfio_container_pre_save.  refuses to proceed if
>      iommufd_change_process() fails because non-file mappings are present.
>      Allows cpr if there are no mappings present.
> 

If my explanation makes sense, any chance of getting an RB for this and the
related patch?
   backends/iommufd: change process ioctl
   vfio/iommufd: change process

They are not affected by the other changes we have discussed.

- Steve

>>>>> How about I just add a comment:
>>>>>
>>>>> bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>>>> {
>>>>>       /*
>>>>>        * Call IOMMU_IOAS_CHANGE_PROCESS to verify it is a recognized ioctl.
>>>>>        * This is a no-op if the process has not changed since DMA was mapped.
>>>>>        */
>>>>>
>>>>> - Steve
>>>>
>>
> 



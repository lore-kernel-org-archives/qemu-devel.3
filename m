Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3463C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYs5O-0006vH-3F; Fri, 17 Jan 2025 14:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYs5J-0006v3-W8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:32:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYs5H-0001Fw-ON
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:32:49 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HIBp09006924;
 Fri, 17 Jan 2025 19:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=OwRMY5aKitdBEjiLm8CAoz8XsDwX2BXmRbl5RKskbzM=; b=
 J7hTbjMLG4YETx9x3T/Jz5XGCRI1rYJRZ+BiEtnPhHJ9FoYvv7i8ou/Xp1UbwoJ1
 eHo40YsWOkrE96YTIAj3wL+F8z7GYtk4rx0BEpaNnPNK9VKZT11bpiPpqoeoKrjd
 ycxgN6cqB9QerSOARiUYSylBSG5KuQtA+08vRoOMt3HQOJIeDulpU7nxsiTrmq96
 VtM1VOzsVDCTv2bBL7g7wZ4gbV441fcWm0jll/ehY1p+Ea2kvesMxb9G+nbacSVu
 llyoTZldV4iCTJbXzy3w2PFO2GFDMdKDDe3hPp/MhM1t95BXBuXdaX0cLT3D/1ms
 nrh/61cLKil4+6pdyv07ag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4475mfjpy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 19:32:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50HJSWdY005189; Fri, 17 Jan 2025 19:32:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4473e6r3eq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 19:32:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGBx0NnJ+rnuPEhjJBtAEiVjn67uDs8NAZt1p6s38f2MWHDRhHBJlR3naDXNlD6QRT8vjW+UQtc5eAhlMG7VaSb+ceoKaVKIKHF6XXcOEwZKZTrx2paEIyhA4JcFKuWhecmBXnZVTB2Cw8eGXdQShGJtchqAg7hXuGt8joKirDE5qoxWEwaCx5rG1x4ByUp4xQabkbAwGCjcMOtHbjUuhuERSR5afU2paljLpmyn1rxG4RJjGN00rWlupU/Xhj1quXjWe+2b9L8r1bbsyzXdZpADN6pKFEFPSXCLI4aKY1SCl05FUp11Z2S9/UxxbWj8BjBkIS8q37LABirZg8BbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwRMY5aKitdBEjiLm8CAoz8XsDwX2BXmRbl5RKskbzM=;
 b=sDhzgk7ly/T4PCtvRlxSe4anHSmKrowz5g4RMedIsVoOabwfUl+wfuHxTeDCsW0b7FEQERiEpdCY+8aaPDPs9waDVEyP5XMMEygoWVUVn1tlGtS57239CAsvXOPk3NrEbS90zbUZDBg4oC6LIg992d8JA2k34nYWwdXKPFLZ6b+zzen78HXZVAYzCH5UVdmSIaPIH2t5C65Th6kMjtgsS4QTi9ygqCPRJaRhTrEPWngs3ID+VLkoKDdlp719oufG7GSahZRZs+bva3tqobpO0hl2upaWwK8oJgn6w+QCBdKxxO0iL9oVMlS5Vxjw4lOQtWH4zcmSpCYo1gyQbGWCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwRMY5aKitdBEjiLm8CAoz8XsDwX2BXmRbl5RKskbzM=;
 b=EQcx/Uz/L9VWalWBZbxjSHbw63jYwFzmfzKwL1f/1IqCQF3aaSL4+aizFqxK1SwlJF+oBFHQmYOvMwPe9cmJf0EDq8DEvfkR2mJUz56pYXxUwLyj9FNzMeK9ayyGw2nYJJFj+LX5KrrE00F2NDH7B+zILWkXidelAO2ME2TpJLo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB7815.namprd10.prod.outlook.com (2603:10b6:806:3ac::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 19:32:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 19:32:40 +0000
Message-ID: <823cae1e-7553-4735-8aa6-21d6f1b81b14@oracle.com>
Date: Fri, 17 Jan 2025 14:32:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 24/24] migration: cpr-transfer documentation
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <1736967650-129648-25-git-send-email-steven.sistare@oracle.com>
 <87tt9xec2y.fsf@suse.de> <68bee183-ba2b-420c-b885-a6ba630f74fe@oracle.com>
 <87r051e9xb.fsf@suse.de> <19a1f016-981e-49ea-9ead-bc64f69fa0c1@oracle.com>
 <87o705dzvn.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87o705dzvn.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:408:ee::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9ef3e4-7afa-4c8e-e826-08dd372db4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmxFdHBqL2VlcXk3UGJicUh0MDZpTDRqTjlDelZOUmdadEZ2a2t2dHJxMTVX?=
 =?utf-8?B?bjEvbHRYTjJNOFcwcTB5UzkzajNxbUZRNDFIV0ViRkRaUXkrTWhZQzM2V3Y2?=
 =?utf-8?B?NVRXYkhZSEgrYzdkYlJLY1VHbnRVUVdWb2pYMjlZc1lmSms1eUM3ZVp5QTZq?=
 =?utf-8?B?Q0hOUEQwK3VUc3lqTUhSS1FNMXFPQmMxMnJFc0VJYUExL1k1SFBYSXcxVGVL?=
 =?utf-8?B?ZzUzVnNuNnlOckY0YnZ5YUdESWQ4VHg4S1M3a1EvRjJYaXRXZXJ6Rk8ya3NY?=
 =?utf-8?B?ZXlJM0dEMkdjTUY4WjFyZnNUb3NOWjFzY1lybXVGQnlMS2NhbGlsYVo5TjRw?=
 =?utf-8?B?NFpmWklwbXVwdmloK3dHNU5QOVVob1ZlRnJ1OUZzaTJDV3dJK2V0MHEyL2NE?=
 =?utf-8?B?VWdQakQzd0x6a1ZVODBKZE5kYlVuek83RjJoZHdYTFIvWFMrYk5CSUdCNlRP?=
 =?utf-8?B?aVdMT0ZUQ2QwcXg0QmhhWFBPVi9ZcE42bWxQUzE3YzdGU3piVGphZzBDYmho?=
 =?utf-8?B?djQ0ZUdpcFZycE4wV01SS1h5UGduMnpIczBSZ2YyNitHWS8xNnVIT3NISUUr?=
 =?utf-8?B?VFRlSms0ZDVXd3o3RVFkZTFDa3Nkak84dzErcnNwZTcwQlUzL0k0d3RxbHg5?=
 =?utf-8?B?WFdNbyt4OUxVRlBvK1hWRW9tbUU4ZDU0d3RMRm42b2pQOFlVb1F2YlN1NnVM?=
 =?utf-8?B?QnpjRzFEUWdFSHV5QmYwMEZSZHp3M29GZmdaUFlMU1J4T0c3SnRlU3I0bk1C?=
 =?utf-8?B?VDJDOTh3UVVBenNUczcrNlVpQTFIY2hJSjJyVXM3Z2dCZlhyc1g4SFVBc0Jp?=
 =?utf-8?B?OGhEdUJrVHY2WHJUUU9oVnZYcXgyekpMWDRNMUdzTEFES0JxVG1KNDZFVUtO?=
 =?utf-8?B?V0hBSEhBN3V3QUtCTmdKNktKTklaTTB6T01qS3IwT1pPTVVwbzhCQzhGR1c0?=
 =?utf-8?B?bTMwMFU4ZGdJbzMrSHZ3UzJqTzlpc1ovVjdKZjlwOGRlZlErME51K2dOTTd0?=
 =?utf-8?B?ZTdyZng4RURmVmRZaFV4aHI2VDVHdC9qYXFtajc1Z214WTJjNWdLaUFPNGR5?=
 =?utf-8?B?RFFpQkxTRi9vSis4MUIwZDcySVFFSnp3eTkrcHlvazBaMlNyeVNpb2JnTFha?=
 =?utf-8?B?MURueWx0RjViUWthcGZrRmNoV29JcWMvS1U2ZE54ZnFlYndKV092aytHRDNU?=
 =?utf-8?B?NTlqYTlBeTBldURGSnJMelNoV1A3R0lQZnh1NlZTdkQ1RkdiRUJ6RVVxaDFY?=
 =?utf-8?B?eUl2THk2YTcrTXZVVGhSRkxQY2JJQzFxMDF4ZHVIVUpaZXF1eTRaeWJzVjRP?=
 =?utf-8?B?eTJrRE5MK2ExV3RJSi9EV01DUXNWbEZTdmtGMXdwSlY1ZURTNW95RXZSUHU4?=
 =?utf-8?B?UlhXamNHTEd5QjRzRVYvSS9JcVRUUUdtUlhRQkhNbWRuN3ljSFFsakwzektn?=
 =?utf-8?B?YmVFREpGd1FPTkdlaGFwMjg5WURMSmN3ZVZSRDk4Y1JhR1ozMnVrREhrMGh6?=
 =?utf-8?B?NFVIdyt6eUx2QmtYb0dTK2VRdjhXRHlxd216NDZBMXR3VlE3WUIzenZRYkNH?=
 =?utf-8?B?a25lMys0UGp5RjhURzRpWDJWQzN6YXBTTGk5SXgrN0hlUEFnMEhRcnR6VVd2?=
 =?utf-8?B?LzJab3UyczVBazdlZEd3eUQ5VUkzck9IYytneVBPRGhseFU2Q1huNDFoYURB?=
 =?utf-8?B?Tk1BNXBIUlptMzZNdGhGMGZONExDVzZRa0VhQ3JYL0dIMnBvSFB6QXRqTW0z?=
 =?utf-8?B?Q2JDWkxISTBTK05DZmlicklpU0o4M2VsMmtkUnpEVnFNZTZ1QzdpUVh3bTlY?=
 =?utf-8?B?VHdjeVhPMTJSTzBjWW5NVzk5eVRCdmtsckFNUStGZGxYbm5HLzVLWEZqT3pi?=
 =?utf-8?Q?50EPGVbzYsaZk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnJjMVpmTmNZcE5ZL3NLdVMvVTlzNndFcTMrcDMrdkZ4WG1BZTFRaG1wQ3ls?=
 =?utf-8?B?aHg2MkFnVENNSlQ4Zk1TUk5Nb1lGaS9qQ2lwaDk2Q2txRFRxcG9ET0lrdXlK?=
 =?utf-8?B?ZDZOK21HbEVMblQvamhLeHZzTGoyK3BDd0d3S1pzNnN6MHl6VEh4ZTFWekZp?=
 =?utf-8?B?YkhPdVAyQVE3em1aUGM1MVhOMXJCQ1NXTDJRR08yRzZodDVmdnFRSGVnZVhz?=
 =?utf-8?B?RW03YVo0NjZsVkhwdDcxVmRUVm1VcmxHZE9IUUk2enFWb2ZLVWFFV2hKcGRM?=
 =?utf-8?B?WlZoSmVGWFVaZ3ZKa2xYTzZyajNXRWQ5WjAvVjU3V1hJWGQrU29qUGxpeHBx?=
 =?utf-8?B?RzNzMklmNzJWWDRodGZEaEcyMHpXQnF1YmcyZjZNS0NhU3AxVU9vVzlJclYv?=
 =?utf-8?B?RDIzbkMzMk1QZmU2bTltakt0czlXc1NQU3NiNkRtRmRHL2dkOGtJUVo1TFgr?=
 =?utf-8?B?YTMvdDJTNmtZZjBRS2RlS1Rtd1ZRTHNDemVuNU9oa1d1bXhrNXFPNEJ3bGNl?=
 =?utf-8?B?RjFWRmtydTJHRitnbWNxdzVYdVdkdlpYNHREUUMzdUkwdFFOa0pPK2tKY2ti?=
 =?utf-8?B?UFEwSS9TVEJodzh4SUJ5VVU2akRlNlJIS2Q3bXh3NFd6cHIyaTMwUk1lUE9q?=
 =?utf-8?B?RVZPZVVFTGtlcU1QcldFcWs0WXUyNUNuOCtRYm1IdmNJcDBRejc3RUtMd1k0?=
 =?utf-8?B?MDkyRjAyVE1hSjR0TUZpZ1dHTGZYUHd4MjdZTHpkT1NHWmJwTWpvOTEyaWVS?=
 =?utf-8?B?a0RRUXk2VG5RNnJVSGVTOGtyZmRzOHVSQmJpcmkxdkpKTlI4MEVUOGp3ZVVH?=
 =?utf-8?B?cituR0crSTBIWm1zcmdzM2JHTlgzeUNCMnNCK1gwN0diN2UxRVRxbDN5ZTdr?=
 =?utf-8?B?WEErYVFMQWFPZUcxaDUvaDRpV1hlMm0vTFNLQTBvOXVTSGNEVlZ3UTJ4MjI2?=
 =?utf-8?B?bmdRQTFlQ1VyOEx4NHh5ZEZRdTBtRlpTbWIxNmZweGtRQ3JaTUZGeEtoSHdj?=
 =?utf-8?B?ZzJxei9pM1JIOFhBYXNHeER6YzBHYXU0T0pwdERodlBWdXF3TUdhcm1kV3VQ?=
 =?utf-8?B?dUpPL1J4NVNCL0trYndneG8xZDRDWG02REY0U0FvSUFkWjViMGFTVWorU0tq?=
 =?utf-8?B?cnprR2JhQkVsWmFwYnc4ZTBmTzY4aXgvaTJlcE4rRUxOUVVja3pyNHIxTlUy?=
 =?utf-8?B?Mk11YS82OWJ3a0lDYk9nQkMxT0xnYkdBVjEzNDNmcjZsMzZhZWFFOFVVYVNq?=
 =?utf-8?B?RzZtOUw1Myt6UWx3V05vRWhqTXVEQ3IzOGxZSW9mY2VBZDVjNWhxd1Bva29s?=
 =?utf-8?B?bnMwYitOYlBtemFqdkFYWE8wNjByVzdjRWdhSFU2RmJqZ2VIQzVBN0JReWhM?=
 =?utf-8?B?aGwzUExHcTdLanUrUWJsM0VDY25KbjkwRUcxdmRmRGRxaHI2V0tqOEVWU01R?=
 =?utf-8?B?UncvcTRXMW51ZzhWUWs0UFpKQ2I3MUpJa1hiaW5FT3d3S0VmMFU2cDB4UVNz?=
 =?utf-8?B?Q3V4TnNla20vemlCdVhGR3J5ZlFQckxoMHlqWHFzL3BZMG11WExiMjN0ODRB?=
 =?utf-8?B?bW5Sb2Viekk4STFCWnR2ZVlXZWVUL2hEMks1c0FPOWJtZExyUENXN2lkZjNt?=
 =?utf-8?B?cmtWWitXWDdqY0txcjg4bzF0Tm83bEFUTC96VFNXbWtKbzNSWGNBU2lRSUlV?=
 =?utf-8?B?TlFRK0pHWEZYUkRCelpFWWpCdGlzRDRDdE5tYU9ia0pBVlEva3doeStRTjhl?=
 =?utf-8?B?eHNRZktjODMwZU81dENaQk5RMUw0M25SMFVrZmlHMXVRRFVPcTZzenZwRHNZ?=
 =?utf-8?B?eXc2Vk9WSCtEbjN3NU1WZ2dHZG5EWTAxVUI4NzgvZkt1NGhpOVNES0VmY3h2?=
 =?utf-8?B?VEFzUGRQamJNZ2g0UUhYZC9QNEpHdTZURFp3VUFZeHRxclZSNjlUVFo0Qkl3?=
 =?utf-8?B?Lzd0Y3dVaTlhUzEzVXMwcFl2ZThORWMxS0Iyc25ZTXFzK0VvUG1ubFBvbEk3?=
 =?utf-8?B?bFNHNUV5dWx1RkNUY2VsV1FHdVI1NlNsSGFGUnZWOVRWOVhRRVFSbnlrS1Fw?=
 =?utf-8?B?ZnJYK25kLzhVOUFMTVV6TTV0TXkvY2s0dS9TUFBBNWplOFIwNzhmSHpLNTY1?=
 =?utf-8?B?Ry9LR0J5U3FVSXFjOE84ZWZWSnlweURmUVd2QlZaanczRGpKSHpFNjA5ZHVV?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PhwnsldkWcE5E2V250bhInYBqJJvFM6hp2ZbKLRZyBCb9CCnefR+Ai7KIN22ueaDR0Nq8m7lIZu79LqJ0xJhoUsK3uQw3dl/NbvTpK29UeGCP5CIi25dN9e/yM6zMmmzM5Wbo17ZaEwEktkE3xenrbANfQkdHigg9KltqVPH49dAcV9IhaE2kClYG0AuDXPlKurU0n7+ZZY5R2haL9uRKy76ECyuIflbgBqXx2P++sGxzjKySrMmfwov5eiysrpnscQHYDArZKIVSRQAyNWteEvIrjnHnGwTtuv8x/ElXwnWr/2dD1IhiU/szuK1copONjjNhvXnFU82IHWlRKdUDuofm1xChJq13YgUYUKfgZAH2OI6QL0m8oNjikjYQgwlkVoELJcFvF3lglZebsdxhquTcc/uznVFjCCreu4pPBpBoDB1i5vArrDOrcJ69jxwIVM3s24FGOOOEadpTdWX3LpFsA6QLRcSFi9cbepVx6JUl2rcAffSkPHKkbEKJitWSFP2y0AwISzbQ95ywEJjJk1KL99JwN8OvRZvNPPko07UyahCHVSpxnCLJn8YRQgMAvqzak8lQSFj0Gxav38nv25/ph0oe/yr1oabcLMuGTk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9ef3e4-7afa-4c8e-e826-08dd372db4f0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 19:32:40.6282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsHuhRUesWWrKu2pcxrXCpIIoAGZMjPyAnGMzU8F3kTa9dwUJsqStxRElB1jeyjMIgP0I0Qh8rMaNhT+IG9OUlvaD0ejSu2gwHwZPGhM5Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501170152
X-Proofpoint-GUID: 5YQZZUw0emt6FwXadkOFijGprrYs9k3w
X-Proofpoint-ORIG-GUID: 5YQZZUw0emt6FwXadkOFijGprrYs9k3w
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/17/2025 2:06 PM, Fabiano Rosas wrote:
>   Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 1/17/2025 10:29 AM, Fabiano Rosas wrote:
>>> Steven Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> On 1/17/2025 9:42 AM, Fabiano Rosas wrote:
>>>>> Steve Sistare <steven.sistare@oracle.com> writes:
[...]
>>
>> Thank-you for the simple example.  I reproduced the failure.
>> To fix, add "-machine aux-ram-share=on -machine memory-backend=ram0"
>> (The previous longer example had the former but lacked the latter).
>> Without that, the volatile pc.ram region is still in the mix.
> 
> There you go, that kvm-tpr-opt message is almost always indicative of
> user error. I think because it's the first vmstate to be loaded.
> 
> Nonetheless, we better update the documentation to:
> 
> -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m -4G \
> -machine memory-backend=ram0 \
> -machine aux-ram-share=on

Agreed.  Will you squash it in to both examples?

- Steve



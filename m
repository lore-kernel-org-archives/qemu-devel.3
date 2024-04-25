Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E23C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 17:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s038w-0002Ln-4K; Thu, 25 Apr 2024 13:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s038h-0002LG-JM
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 13:44:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s038E-0006fV-6G
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 13:44:05 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43PHOeeG004069; Thu, 25 Apr 2024 17:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qA3Qt+rXAYKLVpxL1vJ9wVXaZ69qvbj+sHvkaSUmHCE=;
 b=a1VftXoECMOMLhXq11SDXdqIut7pLcDPnEXb6Fs05q0/kWHAjPiPiyEU+khGShcMc7vd
 dG1KymONzS7V0lRc9moW25HCV515I0Qm6qm8Nb1Buz5gzRmWliyeat4oZoOuAEliC3WO
 Asifd/ojNuvTBOUFQm879zB7R/VMimYKAYxeBR08WYLhy46RsPJ/anZuBS51sSlp7L/R
 mxdiYq0VfHqLZtONn7OmJ4xGJXEePJ/rUTF2uNgDiFmCzk2qJ2ZTUqV3psmUj08Q/rBS
 rMadkq5E6uNxoImdeOLEMhcotAGnBJd/+H8lgLLT7q3l7hMmST8THdFUeFa3M5mCl5EB jw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2mjsp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Apr 2024 17:43:33 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43PGwvh9001865; Thu, 25 Apr 2024 17:43:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xm45bd7d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Apr 2024 17:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO9ECdzrznxLoJEV/BAnb14t91woH5ABiq689TwPcvrpJzyvtDWITljQ/eh1+2kGfrmgNpe0YZF1p32jUnA1EzWF2efBJW8PE7vMBedL4N1lDZuTb0JQvWTWRiOtm7hdBC3TNYROp6Fh35j3IIyG8zZp4kLKYOBVAssQLPMPNY+LfTroTaHI9A8abJWKnQhYhSCnX1RubrEp6CgzIB05/LMCyBog9LSDoiE5pGRlG51LIus0+OdPyT84RQAJecT3wnZi379vqMA8cYN4VdembvjAeBSQ2QGA8zFRwOLt04ZxeL1Gh0D+7M3YYti9DxGmEeEq0kk0pWk/+Cd8Ucd+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qA3Qt+rXAYKLVpxL1vJ9wVXaZ69qvbj+sHvkaSUmHCE=;
 b=ZjIk6FNGNRj1CLLs97sYf6eyaP1f3Na+Q7IoAoHwdChu8Wc4TUHTkUlvbjuNPUuN9TucIXLKe5P2w/DxIa0hZO0frErhOFyo8L5G/xAsEc6LSLk6pS4bMKRrbGLwCbso+Gz63Ga05ZtWQRIUgR27LpiYOAtIY1pBJ73bPoD3IExrMc9HaRlJkKI/ZMy49mCpVcOEY+U6xqIh81L5T+Nw56gtt1lMi9uS2bYr2NASrueuu4L14eebrR9bWqrtKcAeYmiQr4M2+nEZR2rwJejmU+ZA/2UqNWxPsPm9aHedKnVk5beF+lm8bFllgxgndsljwMNaF0evhSBSIru8Ufot9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qA3Qt+rXAYKLVpxL1vJ9wVXaZ69qvbj+sHvkaSUmHCE=;
 b=gZyNXuYrF4yeERWKZkCddJgTLd1uPldC1h6zVfAW4Dtmt2V2ELMTjl98C1PlBL7bIY7BkMtkU3KlAzJIT3pU8Z9L4ZwfjqGNxoAnUPCQeqUUuKAf1cYYp6Ce2VJQCbk7v/loVELZPyPZYTR9M03aIMXEFTI5SLnPTPdJcZASi3E=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB4975.namprd10.prod.outlook.com (2603:10b6:5:3b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25; Thu, 25 Apr
 2024 17:43:30 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 17:43:30 +0000
Message-ID: <9f347cd6-8c18-4253-8a5f-efae08230a62@oracle.com>
Date: Thu, 25 Apr 2024 10:43:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
 <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
 <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
 <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
 <f2dcbc76-f90f-4abe-b5c3-f159befd07bd@oracle.com>
 <CAJaqyWeSrwVt6imakpccieqN_3C85JcOZuj=FR+Xnmr7FKFaAw@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeSrwVt6imakpccieqN_3C85JcOZuj=FR+Xnmr7FKFaAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::14) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b20b0b-b726-44f9-bbfd-08dc654f3845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVJCNDRlQ1g5YSsrQlo0NGNSMDljN3g0N3pOZTh0SkpaWFVRa1lUTXNsc1Qz?=
 =?utf-8?B?czd1anY4MUt3OW8xNzVzMzJjV0dsaXkrNW03cnRtWU1POEVvenZhZythS1h1?=
 =?utf-8?B?VXI1YXU3VzdQL0kxQmt6ZGgxR3NzWkhTY2swQSszOW1sMk9nYXdOMGdERUoy?=
 =?utf-8?B?a0ZOQURtMktMRy8wV2JYMXJBYlhVYjY1VXN0Rk1pK2NBY1crWkJuM21iTk45?=
 =?utf-8?B?cCt2cXZ3SGhCNzhFclppOFd2bE53S0YxdE1iKzhoWVVFSXBqUEhsQU1vVndi?=
 =?utf-8?B?MEZ3bnpJLzZERDUrY2FmMkNTeFlCV2dYaTd3akV1OWcxbytKblk3aE81MFlH?=
 =?utf-8?B?UFc4eFRDRlNtTjJHS0JlekZVZmZjQm5BWFdxa3hKSkVQdHhhbDFPTlZraGsz?=
 =?utf-8?B?cDRnTXYrNmlFV2ZLd01ydDdzQitlSHRWT1dXQUFvK0FRcUZhZ2g1NFIxMjlT?=
 =?utf-8?B?OVJvcHZlbng0RllmZWU2ZFRmU3dFMW1Ycjd6QlUzMkhOYW9KZmozdVhtMTJY?=
 =?utf-8?B?cERIZU1SV1Vid09jWVdRQ0JKRWNlaXlQT0FvQzRncHNZTE1RVERhUWREbklN?=
 =?utf-8?B?WHFFTXdrNEFqMnlTR1pBOHRaOWxoTnN5clRYeHVLdXlra0lrQ0MzQ01IRDdS?=
 =?utf-8?B?WEMwSTdVa0pBV3VJemY0MnZTc0tSZENBSDJXRnhZaE5xK21na0dacXBvdWFT?=
 =?utf-8?B?alFrR3RPWXgvL0lkazlKOUE4OU9CZDNRVFpCRmZyTU8rcGdyWjRYemtCYlli?=
 =?utf-8?B?a1JkZ2EvbnJ5Z0lTb094dHhTV1pJcStHWnVKNTlpMWJCanlLRHJ5RHUzWU9u?=
 =?utf-8?B?MjE0NjJyL0JNZ3lvWVF6Zk9DSk1rM2xENUdtVU9iZzA5TWI0RGlpSVdzb0pG?=
 =?utf-8?B?WFQ1U0dqakVZWlVtTGQwVkNVODVETi8xTDRlOVg2VG9sSVVRNUc0dE1RRmFG?=
 =?utf-8?B?RDN0eS9xV3hlbjhFYWh1K2d6eDZZc1VCam93UnoySUlyRUJ3TGw0TjR1R21m?=
 =?utf-8?B?OUg3THBneXAxaUViMHJydGdKRGRnVXRFMFZPditWY1ZiQjJhcVVEVGhyU0Ir?=
 =?utf-8?B?SjBYQjFCS0kxZUVUNWpaTUp4MVM4VEJmY2tQSXoweklJMWhkMXlDcnJ1clQy?=
 =?utf-8?B?a2piWWgrN3Q1c2JGWjdSbHo3S0dqYVJ5Nmpzc01lWnJFbmNKWGZLWjhsbjd4?=
 =?utf-8?B?QTNBT0xTMnZnc2NKY2NrcUczUUphelVpOVE3YXJjN3pNMEZuTDMvemhhZEt5?=
 =?utf-8?B?Wm5YcURUUWVQMnhDazZGQTk2ZXF5NkRvTWNJYXM0RjR1NDNyQ2pkTzNsZ2Vx?=
 =?utf-8?B?eTdyZEk3WmpVZ2F3Q3o5YzR3UkMza1dCcXRYVWJiSWxmdWJrOU5xRWxwdE1Q?=
 =?utf-8?B?M3VpTVNpZHdrd05uOU5FQzNyaWRqSzM1SW84WWhMdGZxWS9wMWZpUlBjd1c4?=
 =?utf-8?B?Zmc5algySE5raVpwei9qdHltdDRQYjRlUWNjYU9QZ2FRcDlhdkp4SXphV2Iz?=
 =?utf-8?B?bExJL2FHMHN3dnN6R3hKVVB4QWZENGRvMEVQMWl5elcrYXNuSFFHbURFUjhF?=
 =?utf-8?B?SnFzVE8zLys5eUxYK25relJUbjU4VTkxL0ROeTZNNWpzTkdOYVVReEJEc0VN?=
 =?utf-8?Q?xLBOj2771sL5NsFl6uOD/IIGtO7fbZCbRNA7iisej8Ys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zlh4RGs0V3dNTXZubVlCNWVPdE42RE44UGVkZmVLeVladHk1VWRnVzFBU0Y4?=
 =?utf-8?B?b2xTdkF1SWJpOVpUMXYvM1ZjYmY1U2NXRjJYVlBjM1l2RXJrV0RralRsZ2Zy?=
 =?utf-8?B?RE9Lakpxd0RsdFRoc3ZqbWhSa1VXSDVCZStKNjRYK3N1eTBCblJReVIwL2dv?=
 =?utf-8?B?cGd0NDV2RTZhWDdhd1BzYU04SmVtUDZtWmp4K3JVa1ZrcmRRZkFYU3VNc01t?=
 =?utf-8?B?QS8rUmpKbnpjWnA0RllieEE3VUpUTDFSdFNETXp3Z2hCRnJTZnV4alU4bEpB?=
 =?utf-8?B?S2IwbCtHMHhQZjdVUkRuNEFyb3JMNVE5U0p0MGp5aStSNndMMkJidzVic3FG?=
 =?utf-8?B?TVg0UGhrU2p6OENsUEN3MXRlZ1RDaS8yRTVwcThjS3pZOHZkVHdmeEhROGJq?=
 =?utf-8?B?SzRNZVdOZERGOWhGQmU5ZnVMVFRIeEtPSmJPUmpaU0ZEakNrSEVJSnBVM0Ew?=
 =?utf-8?B?V1MzbjdiKzZOdExuWGRFRUpPcDdzdCthT29xVXJWTzRuVkdVSFpyYkIzTlU1?=
 =?utf-8?B?cThmZDRBQ0JuN3FVQkp1ZFliaUc1cmkrbkQ4Umx2MkFXOXBIbHBXalV2WDFh?=
 =?utf-8?B?RjdYckhWeVBPQVhLYW1BVjk3dDlYdnpYbmozU2Q0Mlc2YStZRm0yYXBVWkdJ?=
 =?utf-8?B?Y2Q3TzcwbjR1RzBRenZHeUYyTXZJZC9jb0YxNUg2UlR2cVlPQ2kyWHJWRi9u?=
 =?utf-8?B?N1dQUHQ1endjZ1pRdTEwekp0eWpTU3Bpd2cxeXg0Qm9pVUIrelFGUUFoRG1k?=
 =?utf-8?B?NThudU1scHhpVnB2YUV4ZEI1bkJVMEo5TzdMemhuUExyYWltc0dEM0svQzA3?=
 =?utf-8?B?Wlg5ZEsxTkxIUmNqelkvQkl2eUlaSkRuM1h2QWpibFByZnlWa0VTQkZUdjg1?=
 =?utf-8?B?dGxnMENJNmF5RmFyc3VpOWZaNHkxejJPcFJvWUtUTnZ2VWFxNGh2M2ZsZjBT?=
 =?utf-8?B?T0hqa0tDZVc4ekZwTjBGRVRwcG0zdFhpOVhqcFl5d2dlNFV0RkRMWm04YThH?=
 =?utf-8?B?ZDdsVG0zZHArWlBVcUFqSFQrWk5Rd3h0eXhEU09DajVsN1IveGdtSlR6N0hW?=
 =?utf-8?B?Z29NdXE0ZEpac0ZRMzhDZVVaK2VvNjYybFAxY1BSSzRScGhkaFE3VTFjbXRp?=
 =?utf-8?B?UXRFUmVJK2hQL1V5K0h2eTl5YjFQL2NtL0FYV0xzcm90YlI3bFEyOVpqUklj?=
 =?utf-8?B?VWd5Z0MrNFYwZk5MZjdlUUR4aWxUZ3F0d0J4ajkwQWVxWnRydldCUm5aSXdl?=
 =?utf-8?B?TC9rUjQwa0h2N2VGajgwTDFrZjhEb1lsMHlLZkxSZVA4bVBwTXFnQnM3MWd4?=
 =?utf-8?B?MGh0QlhSWVJ5a0VlQXVyVFM1STB1MmRMd0FpYXV4bDRwcFcvSXc3QzhXdDNI?=
 =?utf-8?B?TkhwVVpFcXFwYnVINnU5UWQrME9BLy9Ec1FYWG41bjBUbGF5MEx6MXlsSDZo?=
 =?utf-8?B?S0NadTJQMEZ2M0l4KzM2aldLZWhvYU9FL2J3eFByZ0hqMHNiWHZtWTBWa3Yv?=
 =?utf-8?B?QU1Jb3pnai9XUktjdFpEd1g3TW9OeFRqNk9idVZNQjVUWmhFSCt2UVg5Znlx?=
 =?utf-8?B?Q1JwMkxxcW8rQWpTQWRCNUhrV0dBUzlieHBwQXl3amlmdGxFN3VHVEd5UFdK?=
 =?utf-8?B?TkJ4MWx3MDNNRlhyMVBLRHFNUnBlR1lGbnp2aWRMVE50dkRPelZRSDZOOWti?=
 =?utf-8?B?Wmk2N1loZU9UZFZPbFA3SzF2b3M1MnVEbkc2bzFxeVJSTW9pNExGUHorZzFn?=
 =?utf-8?B?MW52dnB1UWUrZ2NFenA2RGJ0SE1pYjh4cW9EeTAydlNvYTd0R3dRbEM1YW5N?=
 =?utf-8?B?eVlRTHNEVC9ORUh0ZmdjMVhKdjRZVFIxSGp4dlZIeUFWbWk5WkVsd3JYZVpw?=
 =?utf-8?B?eVNJd1FkaVhqRVBiTFJVS0hQY1ljOENOd0lsa1hNdEh6cXMreURIY3VvOE9w?=
 =?utf-8?B?SW5tcmlMZFZMbmVTRlJBaVV5SnNKS2cxK3ppWEZBQUxZZ2VYT3FaN3RsSDd5?=
 =?utf-8?B?ckk3VmM1eU5FcWhYeEsxS21wcHRvYUxWSk1qQ0hjemZSOFNCRDRjTE5MTzR0?=
 =?utf-8?B?VEZqRDZYUCtvSkhHWDBKQjJrWk5XSW14WG1HaGtYSzZma1c4RHd3cmxRc01q?=
 =?utf-8?Q?h/fwKT9Sjug2tlF2HKOeDyWTC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DVHi1pinegCnt/49loBfmCTLSgldDJyMndUlRkei5xsLKnZA5vRlnV0Kr4+SwXh3o2iTXoeH2G63fhhPHXjA8fXNGdkVEuHsorgHqye/+NARPHpbNcSe4Y0g2qIK80bKwBWg1BATYtdRtTNyIeoIP2vrrO2XMMmhEVX86A5UVR4Jrap0RXcD7VYV9RmfvOTLh1ekxM5xuo5HTiARWKza94yH3s5bVV9NTjKXkekTkcSwlpvE9ouXgGUUt9L3X/1LXEZ4lpK2ckozA1AWmhfO46Jl71WokrL2STUIRLWpAdyN70vyFDMSSNXC5EfQVGIWQrD0Wn73PgUZh2iN4WeCxr97H1i3lDDYyaI8kOGwXm99YnfSvQ1NAVOcmelGzT+P9m0yDyZB/YC226hKyWeqSWvfrRGBmd8nvPG5sXJu8K8op9uC0/SYiuPtZqIOg9Bh7DWU4wmVVdqT2tQHmcJeciiNYh2ZqB12L9ATl41eeBFavTuwg6NYxC8vTJe4dfBlWNUPuYM3rfBwv5tKjv67p410kbOmpYOP20n8JecnUn8RVJNLawSnC5XW9H1KBechvZiPXSR1/m82wjpKwuJstOI7avoNV26ElGhc036fAUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b20b0b-b726-44f9-bbfd-08dc654f3845
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 17:43:30.2234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lr3P/jtglLXPdpKG83BA9CpG5nzWpkwdNr+967oh/MgafNZSsUB8tl65imHZ5lY07AUKB1X0rL4pinIBbHL7tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250128
X-Proofpoint-GUID: ixpwbP1XP1ZsnMJWHYHay8v3TlwaMBVi
X-Proofpoint-ORIG-GUID: ixpwbP1XP1ZsnMJWHYHay8v3TlwaMBVi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
> On Wed, Apr 24, 2024 at 12:21 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
>>> On Sat, Apr 20, 2024 at 1:50 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
>>>>> On Thu, Apr 18, 2024 at 10:46 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 4/10/2024 3:03 AM, Eugenio Pérez wrote:
>>>>>>> IOVA tree is also used to track the mappings of virtio-net shadow
>>>>>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
>>>>>>>
>>>>>>> This causes a problem when overlapped regions (different GPA but same
>>>>>>> translated HVA) exists in the tree, as looking them by HVA will return
>>>>>>> them twice.  To solve this, create an id member so we can assign unique
>>>>>>> identifiers (GPA) to the maps.
>>>>>>>
>>>>>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>>>>>> ---
>>>>>>>      include/qemu/iova-tree.h | 5 +++--
>>>>>>>      util/iova-tree.c         | 3 ++-
>>>>>>>      2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
>>>>>>> index 2a10a7052e..34ee230e7d 100644
>>>>>>> --- a/include/qemu/iova-tree.h
>>>>>>> +++ b/include/qemu/iova-tree.h
>>>>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
>>>>>>>          hwaddr iova;
>>>>>>>          hwaddr translated_addr;
>>>>>>>          hwaddr size;                /* Inclusive */
>>>>>>> +    uint64_t id;
>>>>>>>          IOMMUAccessFlags perm;
>>>>>>>      } QEMU_PACKED DMAMap;
>>>>>>>      typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>>>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
>>>>>>>       * @map: the mapping to search
>>>>>>>       *
>>>>>>>       * Search for a mapping in the iova tree that translated_addr overlaps with the
>>>>>>> - * mapping range specified.  Only the first found mapping will be
>>>>>>> - * returned.
>>>>>>> + * mapping range specified and map->id is equal.  Only the first found
>>>>>>> + * mapping will be returned.
>>>>>>>       *
>>>>>>>       * Return: DMAMap pointer if found, or NULL if not found.  Note that
>>>>>>>       * the returned DMAMap pointer is maintained internally.  User should
>>>>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
>>>>>>> index 536789797e..0863e0a3b8 100644
>>>>>>> --- a/util/iova-tree.c
>>>>>>> +++ b/util/iova-tree.c
>>>>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
>>>>>>>
>>>>>>>          needle = args->needle;
>>>>>>>          if (map->translated_addr + map->size < needle->translated_addr ||
>>>>>>> -        needle->translated_addr + needle->size < map->translated_addr) {
>>>>>>> +        needle->translated_addr + needle->size < map->translated_addr ||
>>>>>>> +        needle->id != map->id) {
>>>>>> It looks this iterator can also be invoked by SVQ from
>>>>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
>>>>>> space will be searched on without passing in the ID (GPA), and exact
>>>>>> match for the same GPA range is not actually needed unlike the mapping
>>>>>> removal case. Could we create an API variant, for the SVQ lookup case
>>>>>> specifically? Or alternatively, add a special flag, say skip_id_match to
>>>>>> DMAMap, and the id match check may look like below:
>>>>>>
>>>>>> (!needle->skip_id_match && needle->id != map->id)
>>>>>>
>>>>>> I think vhost_svq_translate_addr() could just call the API variant or
>>>>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova().
>>>>>>
>>>>> I think you're totally right. But I'd really like to not complicate
>>>>> the API of the iova_tree more.
>>>>>
>>>>> I think we can look for the hwaddr using memory_region_from_host and
>>>>> then get the hwaddr. It is another lookup though...
>>>> Yeah, that will be another means of doing translation without having to
>>>> complicate the API around iova_tree. I wonder how the lookup through
>>>> memory_region_from_host() may perform compared to the iova tree one, the
>>>> former looks to be an O(N) linear search on a linked list while the
>>>> latter would be roughly O(log N) on an AVL tree?
>>> Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
>>> linear too. It is not even ordered.
>> Oh Sorry, I misread the code and I should look for g_tree_foreach ()
>> instead of g_tree_search_node(). So the former is indeed linear
>> iteration, but it looks to be ordered?
>>
>> https://github.com/GNOME/glib/blob/main/glib/gtree.c#L1115
> The GPA / IOVA are ordered but we're looking by QEMU's vaddr.
>
> If we have these translations:
> [0x1000, 0x2000] -> [0x10000, 0x11000]
> [0x2000, 0x3000] -> [0x6000, 0x7000]
>
> We will see them in this order, so we cannot stop the search at the first node.
Yeah, reverse lookup is unordered indeed, anyway.

>
>>> But apart from this detail you're right, I have the same concerns with
>>> this solution too. If we see a hard performance regression we could go
>>> to more complicated solutions, like maintaining a reverse IOVATree in
>>> vhost-iova-tree too. First RFCs of SVQ did that actually.
>> Agreed, yeap we can use memory_region_from_host for now.  Any reason why
>> reverse IOVATree was dropped, lack of users? But now we have one!
>>
> No, it is just simplicity. We already have an user in the hot patch in
> the master branch, vhost_svq_vring_write_descs. But I never profiled
> enough to find if it is a bottleneck or not to be honest.
Right, without vIOMMU or a lot of virtqueues / mappings, it's hard to 
profile and see the difference.
>
> I'll send the new series by today, thank you for finding these issues!
Thanks! In case you don't have bandwidth to add back reverse IOVA tree, 
Jonah (cc'ed) may have interest in looking into it.

-Siwei


>
>> Thanks,
>> -Siwei
>>> Thanks!
>>>
>>>> Of course,
>>>> memory_region_from_host() won't search out of the guest memory space for
>>>> sure. As this could be on the hot data path I have a little bit
>>>> hesitance over the potential cost or performance regression this change
>>>> could bring in, but maybe I'm overthinking it too much...
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>>              return false;
>>>>>>>          }
>>>>>>>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C158DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 13:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKGsl-0003Lx-DK; Wed, 28 May 2025 09:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKGsj-0003LT-Ua
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:31:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKGsg-0008Ij-7y
 for qemu-devel@nongnu.org; Wed, 28 May 2025 09:31:45 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq3TD022180;
 Wed, 28 May 2025 13:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=p2d2euTEPB0hIbIlhnyLL+taMqOwd9QlgnAG1hWW4/I=; b=
 oksMKxgn5ZRaRafILzQENtJVGZ5TZ7jekolcZQylQ1nErKuVG1XcSkoYQSxQ8kPa
 4LtGuVtNLl4IEyY+w5vzmKSuu7OtlSsgyDfeoODRO2M1qGrB/O8bF054cpPNQ9hA
 3kRKUrlSYqOcr5RXONN7N5BOAKJ7xdMd3+2937bo3h7Ei+gqJ8O+7D4VPSo59e9W
 e6MrEKZQQl8iso44OrpyBGAUHxRLpuq0+kGn0zpptMuqZj6QCcZMbZ0XD2w6huYf
 Y5M08FaPBExLOmI9VBMvOucE7pbrRD1V1OJZDjsen1gVvx8RlODWQmiG2/PnE+uN
 Yncd9IGs5jvl9KqUyo9zpA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2dxah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 13:31:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SCK0ua027818; Wed, 28 May 2025 13:31:37 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jae7bm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 13:31:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onNiMrQBruFi3A7FZbvATr2fbnsgDB8w2FV3HUlTWQ9s3X0P7Fy8hlr/wvclvb2rzAVzD54pvxYNBVGc35qcx40WX0/aYsgH32AoOiAr5HofiKLAzOw3nGNqtpwLx/GTOtd7wifXmafTwB49p8A3Jivj9ee2E4j6fW3+UkKBgQEdllrek5cu7MYWR4JIy3pnt0gAsYUbqCmcZm4mrDgrUHrN/4a83AjbStGT1r7/slBqmW5fWSvLm4ZEZALvE7+NXCY2w3z+VPB8+o//4pfp7iNbhg6fmq6EvknqfC+9P+iK3sJCTK3tYmRHCtgNNfj+u09FAOPi+4JjNmYQskijGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2d2euTEPB0hIbIlhnyLL+taMqOwd9QlgnAG1hWW4/I=;
 b=GAJfnAoVfuqQwDVSgsMwj8Z53UQF3JmuUVYxCR6gz7qCP6xp1MZpVrWjOUmNIghy3nQiWUs3hK+Dp+wSrDJSH/XdGHnk47UHdkXYW88kVguhgOZBxDT4r/+chTQHrtb04vbXfHtqvacz2n/ErNNF5wUb+qImRwxQV02kFnk5rdR9O70FdHMygL3TEypLMJwpKv9f+/hEnEmq5hch1XsCe56qMjn30p6/Xq5BQpxzbQds7MQTLvkavH5Y5ZHG2hfxyUIn4ozOz/qRXLirT+LyYG+h+kFSVnC5/dmdkbc+43Qz2sWGX+MJXz0IIe/PFdYyLNwQnd/8Lzz1kUxrbLWEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2d2euTEPB0hIbIlhnyLL+taMqOwd9QlgnAG1hWW4/I=;
 b=MCQVcraJDBjs723c38myo3LMNwpj+o2XXBliMG/Q8N4YKVYOkwkhO/lm9Qx1uaplYVimzktIZQKuXUovfBjiOR9Q4DoLf/QmDqAJN05tQJtibIRuMC8Es6xHJ8XVbkNHNrKnY7olQPYIFwLZnCzTN4/eWGM1whRu1tsPNFUeNoE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7039.namprd10.prod.outlook.com (2603:10b6:a03:4c4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 28 May
 2025 13:31:34 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Wed, 28 May 2025
 13:31:33 +0000
Message-ID: <7ff17616-c813-49cb-9074-2a2fd592c13a@oracle.com>
Date: Wed, 28 May 2025 09:31:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
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
 <e94d85b9-00a0-455c-8645-c439d90c5a55@oracle.com>
 <SJ0PR11MB6744A8D64A7392EA16C51D1E9265A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744A8D64A7392EA16C51D1E9265A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: f18d88fe-fe15-4002-8010-08dd9debf68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2dIVzVOaEh0NUtlaktZYjdnenpwVW5CYzJUNFBLU0oxeGtXNzNBd3NNNjkw?=
 =?utf-8?B?YW92RFJ5QmFGcWVJWkIwMmtXNVkxWkFldmFvK2ZmMkQwczQ5YUlUOHZiM1FD?=
 =?utf-8?B?MnN2UXdjTmxuYTVrcjFPVTlEMGc4dk0wRHgxL1VZbGtPb3FlRi93SmppN3Iz?=
 =?utf-8?B?WGxrd20yallYZ2pLZlF3OGRJVFAyOGVhZGIxVitmNDR1OGpseW5aNUtzMndu?=
 =?utf-8?B?cHVjS2p0T0FDSnh1dlJ6NXVvTURtUUptbkdTRW5jaGxQN09tU0F2Ui9uTUxv?=
 =?utf-8?B?cEgwU0Q5OW9qTC8xMHpEMEpoWW1ZbjI0K3dqcG5ycGVUcHNrMFRCUlZ3VDBQ?=
 =?utf-8?B?SkFpQkdFQzJiY044cHdkdzhtL3M0aUVON3BBWURyU1pvVnFYcjRGM21TdUNp?=
 =?utf-8?B?bGFhQ1o0bDFQc29xT1RncVBESStGTFp0czJnclBWMFVTTjBsMG5RNXpraE9y?=
 =?utf-8?B?K21uMnc4Sk4zR3UycTFBWVpJbVFuWnJ0aHBOb0VaVmpCNHczQkl1SlRUSllw?=
 =?utf-8?B?eHI1NWlPbmkrcnlnemh5a0NmdDFCNkMrcUFRT0pHK3JyTVJ3RUpSbWo0dmFD?=
 =?utf-8?B?THd4MkFCZS9iYkRyNEpQUE1ETWdENDdLSk1ZSDhWazYyOGhTUTJ6aDRCb2hi?=
 =?utf-8?B?Mk1DRENJMG43dHY0RjIxY2xUUFVGbGxDZTJLY0FDakxWWUpTVUN1NmlPOTlS?=
 =?utf-8?B?WXJHQSthMEh5RVJHVGhtdTRDd2hUWlNmbW5UWGVVamNQaFZYaXpwWlNNTW1h?=
 =?utf-8?B?Mm96Vmg0NTdPR1JtZHhTZXV1c045L0pNOVV5VU5oaDc5WXdkWHJvQmFwRmJF?=
 =?utf-8?B?c2hSTDByb3hocVNsMUNCSU4vYUtyclhWVkhnaTFLWXlRQkpVeVRTd2JKWUpD?=
 =?utf-8?B?SWs3UDlRMFE0SHp6SFZLUmJwQTNTNW4zZDl4KzQwcE5WVmhzSEdWNW91WUNQ?=
 =?utf-8?B?Z3lVcHZuSUdFd3d0RkVLOWVVazNGbFJSaUhvckUvYXg0SndVQSsvV2lJblJj?=
 =?utf-8?B?NnpWTlRzRXVuZlV0emk3dGgyc0p2MitHQXBmQ3grUHVyaDg0bFJGUWkvN0Z6?=
 =?utf-8?B?OFhvdDNpdVJVRWxZSkJxb2lpSEQ4RkNoL1lTdURNVkZaRFp2Ry90WjdnUVRH?=
 =?utf-8?B?T2ZmN3hPa2hFbGRMYmdDdnJDQmR5SDRoTXIwNXJQM0RZNUJLRXFodkRPU2c0?=
 =?utf-8?B?Q2xQS1NuMFFQMHhMKzVvMUs3emR2amErUHoxLzlSVGh2L3NkaFA3T1VKUzFQ?=
 =?utf-8?B?WCtycmFEM3Iya3JnVXFvVjAvTVVxVUVQUUdQS2lpVFhQTWJmc1ZGVUtCSWRk?=
 =?utf-8?B?TWVqejdIOGFSelE3RE80ZHdJS3grc3RhM0lWV1FkaGdOcG9OT1dyTHlWVkNs?=
 =?utf-8?B?TWFBVWlRL1l6Z2FRcTdRdTljVE5oVXZVcVR4UXpWVElyUExkRHhGNDc2SWpa?=
 =?utf-8?B?NnB0UFl6VWZGUlUvaUVDdmsvYlQzeTB5WlBPbUFrRWI3TW4zWHkzUWVpOU54?=
 =?utf-8?B?NjA4MFdZMkRMaUZ6Sldld2Q4c0VkUVBUbTNWMnBDRmdrdk9ML1c1U1EwN0tM?=
 =?utf-8?B?RkZ3TjZFSnRJRWR5QTBSazNxaklTVWl3SGtDclNTOFREaGV0UHc4K3RxMk9I?=
 =?utf-8?B?QXcwdjBxRkpiMlh1VVVpSXAzNlUyWXBFUzRBY1VBTnZEYklSeGFMZ2VtNzla?=
 =?utf-8?B?SnhOQS83NVd6UlBQaGdiL0xRUDc1QW5kdUEycW5JQWZxa2JKdE5VamVDMEEx?=
 =?utf-8?B?VzB4QStvelBEYlBYV01iMGt0elg3cGxKRmU5cUVNbXhFSG40VkVlN0d5OTFC?=
 =?utf-8?B?SkI3M0xUSGl0cHczVEVIdU0yV3M2aDlSRGk4SmtJdGtvN21jU2xLK0V4YW5o?=
 =?utf-8?B?dkE2SDMrbjhOcnZnZzUvcFIyYUFzYjB5RWFaM2FMSTFVUGIxWUVGSFRaTmhM?=
 =?utf-8?Q?0SRVpaDTO2w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZxczNOdFhhY2U1b21jV0dmRGxTY2lXam5GTTN4dnFKYjVHL1RYdGRhbXM1?=
 =?utf-8?B?T2EyMFNjVm51ckx6dW81dSs5RnNZTzdJTmYwSExzbXU5c1JhUVM1b0V3azNm?=
 =?utf-8?B?VHRvampPYTZGY3M1a2VuYjhFVHdmVVRHOU1FZDh6cGh3Q1JWYUdISHNhdkp0?=
 =?utf-8?B?VmFkamVBUk11WVl5SVlQY0dUL29PY29PelBxUHBkUVFaTWRpeVF0UmdjNWw2?=
 =?utf-8?B?QUNsaFpIR0lDeGlpN092M3BpbEpERXJmTlRQaFQxbWI4c0NYcGZNRW5mZ0ow?=
 =?utf-8?B?UVRMUkVaTWxsSHNmeU1kVFgrWjFUMGZuY0tWMlhjbXNxL3RDQUVDU3JaY01o?=
 =?utf-8?B?THlxNGYxYkVjMDdmYmtIR0poZ3kwTXFmVFFNSEI0dnkxdWxtMEp5ZGpSOE1q?=
 =?utf-8?B?eWxoeGN4dDFpTVAzUjBQUlhCc3hlaHUrditrZFQvQWVqZ0pseXRqdmExcW9M?=
 =?utf-8?B?RW1QNFlBdTRLeVdyZHY3VTQzOTFWN0hrVS85RWRGS3RsNEpkSnpKZm5uWU5J?=
 =?utf-8?B?Ym5DYlNuSEZGOWxDd1lWY1ZFM0R3ODJIRVFHZnYyTnVLeS8zdHVwRGo4d2Ji?=
 =?utf-8?B?MXpWVGFDdmU4YkRnTU9HQWZJMkRWUTlWRCtXM2YxMXJuRFhIQU81c2JaZnZY?=
 =?utf-8?B?dzFXODdFU1B5eXZWSUJRTFJTS3JDOEludUdGdm9RZk5iY1dNOExSUDcrM3Vq?=
 =?utf-8?B?dWZ0MngwWks0OEQ2N3ZaSHNGckE5U29DUmhPWGFIeDdKclAvNmZxOVkvNzl0?=
 =?utf-8?B?bXh1ODhUN1d5aC9TSzhOQ01LcXlIL2I3R0hRVWtzZzFKZ3lVeE9TY2VDdDMr?=
 =?utf-8?B?N0lXbGNEVERnR2xMaTlrU0lRd3g1VFRscXYvTWViVVRBbE4rTk9mRlpCQnFW?=
 =?utf-8?B?bzBlOGhFSzA2RDVsUnkzd1huSGJta08rcTBpZFFVQU9UUkljeHdjTnA5UTFO?=
 =?utf-8?B?aXlHaE85VU9mOFk1UGw4eUFUYUxKeFhYYi9wcVU0dEFGVkVjenpaZ082TDV1?=
 =?utf-8?B?a2dQS3p6Sk50WEI4T1N4WDRsZmw1Z3ZOLy80NFZvTTVoMTd0UUVvQTNLS0lv?=
 =?utf-8?B?ZVhZdG5aV0tFUy9RWjVjNkF0ZU9qYU1yOWU2RjFEbWp1dGFudGQ1a3JsN012?=
 =?utf-8?B?MDNaTGhNTXdETXkvWndRTmNPcHRZekFTMlJOOE92ZzQ1VlFhQ0JaRlh3VWlq?=
 =?utf-8?B?YUtxZEZwTnF1bEdWQ0IxUFdQeUNJdWVBYXR0OUQ1VVg4TzV5dExEVFNaV3ds?=
 =?utf-8?B?ZkNiWXBVV2hBL2F2NHR2NktieHg4bXpMenVxUWVONGVVbmE4MXU1TEM4MDFK?=
 =?utf-8?B?SzRYUWxBc0pobEJhZ3YwY2c4cWNtSGJhT21IN0l0cXByQ2hhMER0MWpXMlEw?=
 =?utf-8?B?bjFKR0tvWWJ4RVZEeHBNWHJaU2tSVEN5VW1SVDA5OWp4YVBUTmkzVVNiN2Q0?=
 =?utf-8?B?Uk1aZm5YRkhxdmk0N3ozNlowTkZVYVFrbE45ckJmMExFaDAzR1J6MnF4M3U5?=
 =?utf-8?B?ejRxUzFVQmxDMWFyZkpxZUhENklrdlBmMFlSTzg0dERCS1FMd3VFaEhwWDVH?=
 =?utf-8?B?b1BKR3VWZDlPVXZHaEJoRnFlSm1VMVVaODFEbWQ4TDlvMXlLUW1KYWhUTzNr?=
 =?utf-8?B?MFRZdHZ0S2tHc0FqREtNckZxa0dKaktlWTR3STFSUFNHaTZ1L1pCSW5qSXdO?=
 =?utf-8?B?UnhoeEdPbXdmeGRTeVRJczRrcVBldkVYL0FncFpHN3dWQjRINzRzcTRxNzdB?=
 =?utf-8?B?MEhRRi9zekN5V1M2ZEE1YjhNSUx2bEdaMmJhdWYyTjlxZTZLaU9MYndUSUU4?=
 =?utf-8?B?NkZyeWNLQnMyWUdDZ3pudUxDTG9Ib0NKV29GODVkNHMvbTNqamV1RVMwcExI?=
 =?utf-8?B?OFlwSGxzY0pidGhsUCtQbmFpenlKUXNPaWJCcXZ1aGdSaGpHVFZnL0tpV2ts?=
 =?utf-8?B?amFPWlJ2SzdIL2lTYm9KMCtvZDcrSTFobHNzUkx4L2FaVHk2Nk9ZYkxsZGwz?=
 =?utf-8?B?UlVtSUcxOUg1eStFQWxOMHQwNVJmUUdvbDN4UDVsYTBYQUV6T2N0WVRRMWkx?=
 =?utf-8?B?WlZmVVZNT0pFZ0hXQU1ERFFsUGxsZGxqR0lmSFJqcnNWZjB2VjM1R215dkFu?=
 =?utf-8?B?RkNjd2lmVnkzTzlIb1FQVXlFTVBGRTduNW1OMG9veG84SkllVFQ5eng2dFZo?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bToO7NBW54uygEZ+8q+LdZv+gCOAXx24LUuHSVySWLVK8J42FM3/mKQWXA1WAdOXc7FQ1lCxC/dJAo7mROztC5WUrDQEcl4PIdOoYP+CXSApEouvtszVs1QZY0ZlNfexwkJ0+gB8bafZcYukMpzKcqbTfEm+J4Wg6Gx4M5D/qlpPqk4lILv/FpHhRnQ2GJKZitITsn8JHrbnU4LjxSLInGt+aKkEDgbpr+78pSCCMvKIs088tq4KFmUJQJh9EFcbvutpvzo7DOgpEs/i21Q2z+ZdV4WyA6G+kPDJHXMZQXXmEkp12EbgcWumfxJJ2B+dDGZzpNYYmka5chR1WtnsoHvvCMZ069eRPd85LghEI5al15ofkKgGjFhbqKh4bYWJaBvwblCclwbpSVGM3Z8mRDc72PLWKJN3G0DO/jQbOn73IaX4d0EiET1rhg8YSLut1l8zTueM/yHPnwauloi46bamRH8DBRWiB8V6r0kcs/+LSseneEK+qAENSm5/ygz3QL7dZH365RnigsCArZu+5OlAyT+fw8MMNEA9GIFYSrwvYYWmFm/bq7LEDI3xQLQeoMCB4+1VykzQzpWElS2a7Np5kmh1qZxsWl2Nb2EV9Po=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18d88fe-fe15-4002-8010-08dd9debf68c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 13:31:33.7505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAMhgauIBhUvYJFNXQBiXQlrX/EQg1LycIq8uAgOy5QXT8zxZnGKWDK2coF5SH6j3Vnu1UQ5TaKhaZWMLf4U5/7ZE9LcmpKGnDU5s3wUN64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDExOCBTYWx0ZWRfX2U2FvFF9Qv5v
 +cLsjIW1YfvvkJ6GgDdypj9KuIUOA5UnbyyO4SfpqC/pqchhsiCSC9Jcpa08gwVyQ/M4PdLAUKh
 KQi4oljh1q3g1BVeKbyoC/St9ehQ5uTWVNyCkK6c4vYHNbepZ1Nb1MFINSAU+IJEUyzYLxxMd9v
 Mznsi05ZbwrWFvPiRcnEd2Ap8NDyAicpRfSNYbhkwK8hcDe0JLyJK1/3kKaXdAUVqXA5k2YkPS8
 nDO8Kp7nTXvp8L7y9qwxWaeKmFW90xaKJ6oIM+BIHq+rNtdBp0c0sz5G3JjXQq0Afj6cDMjbcVO
 aoNNlmzZQxcI1oza6/N0JEw21PtDxb93APvbBODlREDIfhWE4bo/QE3hrLFycDQr/UPChma+s/l
 ZFcW8viz6nz84P7tkIrPpUy/Kn1WaHeWQr82Nma0t2ghnOnta7vjaspAMf59d072zE7Ne/BK
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=6837103a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=0t7znChWtf_4oeq2414A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ws5KtQMFDTLGpkI57tTLtgLjm6Tv8Z2l
X-Proofpoint-GUID: ws5KtQMFDTLGpkI57tTLtgLjm6Tv8Z2l
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

On 5/25/2025 10:31 PM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>
>> On 5/23/2025 10:56 AM, Steven Sistare wrote:
>>> On 5/23/2025 4:56 AM, Duan, Zhenzhong wrote:
>>>>> -----Original Message-----
>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>
>>>>> On 5/21/2025 11:19 PM, Duan, Zhenzhong wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>>>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>>>
>>>>>>> On 5/20/2025 11:11 PM, Duan, Zhenzhong wrote:
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Steven Sistare <steven.sistare@oracle.com>
>>>>>>>>> Subject: Re: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>>>>>
>>>>>>>>> On 5/19/2025 11:51 AM, Steven Sistare wrote:
>>>>>>>>>> On 5/16/2025 4:42 AM, Duan, Zhenzhong wrote:
>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>>>>>>>>>> Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
>>>>>>>>>>>>
>>>>>>>>>>>> Define the change process ioctl
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>> backends/iommufd.c       | 20 ++++++++++++++++++++
>>>>>>>>>>>> backends/trace-events    |  1 +
>>>>>>>>>>>> include/system/iommufd.h |  2 ++
>>>>>>>>>>>> 3 files changed, 23 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>>>>>>>>> index 5c1958f..6fed1c1 100644
>>>>>>>>>>>> --- a/backends/iommufd.c
>>>>>>>>>>>> +++ b/backends/iommufd.c
>>>>>>>>>>>> @@ -73,6 +73,26 @@ static void
>>>>>>> iommufd_backend_class_init(ObjectClass
>>>>>>>>> *oc,
>>>>>>>>>>>> const void *data)
>>>>>>>>>>>>          object_class_property_add_str(oc, "fd", NULL,
>>>>>>> iommufd_backend_set_fd);
>>>>>>>>>>>> }
>>>>>>>>>>>>
>>>>>>>>>>>> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>>>>>>>>>>> +
>>>>>>>>>>>> +    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>>>>>>>>>>>> +}
>>>>>>>>>>>> +
>>>>>>>>>>>> +bool iommufd_change_process(IOMMUFDBackend *be, Error
>> **errp)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>>>>>>>>>>>> +    bool ret = !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS,
>> &args);
>>>>>>>>>>>
>>>>>>>>>>> This is same ioctl as above check, could it be called more than once
>> for
>>>>>>> same
>>>>>>>>> process?
>>>>>>>>>>
>>>>>>>>>> Yes, and it is a no-op if the process has not changed since the last time
>>>>> DMA
>>>>>>>>>> was mapped.
>>>>>>>>>
>>>>>>>>> More questions?
>>>>>>>>
>>>>>>>> Looks a bit redundant for me, meanwhile if
>>>>> iommufd_change_process_capable()
>>>>>>> is called on target qemu, may it do both checking and change?
>>>>>>>>
>>>>>>>> I would suggest to define only iommufd_change_process() and comment
>> that
>>>>>>> it's no-op if process not changed...
>>>>>>>
>>>>>>> We need to check if IOMMU_IOAS_CHANGE_PROCESS is allowed before
>>>>>>> performing
>>>>>>> live update so we can add a blocker and prevent live update cleanly:
>>>>>>>
>>>>>>> vfio_iommufd_cpr_register_container
>>>>>>>        if !vfio_cpr_supported()        // calls iommufd_change_process_capable
>>>>>>>            migrate_add_blocker_modes()
>>>>>>
>>>>>> This reminds me of other questions, is this ioctl() suitable for checking if cpr-
>>>>> transfer supported?
>>>>>> If there is vIOMMU, there can be no mapping and process_capable() check
>> will
>>>>> pass,
>>>>>> but if memory is not file backed...
>>>>>> Does cpr-transfer support vIOMMU or not?
>>>>>
>>>>> I don't know, I have not tried your sample args yet, but I will.
>>>>> With vIOMMU, what entity/interface pins memory for the vfio device?
>>>>
>>>> Oh, I don't mean virtio-iommu, it can be intel-iommu or virtio-iommu for this
>> issue.
>>>> I mean when guest attach device to a DMA domain, there can be no mapping
>> in that domain initially.
>>>>
>>>>>
>>>>>> QEMU knows details of all memory backends, why not checking memory
>>>>> backends directly instead of a system call?
>>>>>
>>>>> IOMMU_IOAS_CHANGE_PROCESS is relatively new. The ioctl verifies that the
>>>>> kernel
>>>>> supports it.  And if supported, it also verifies that all dma mappings are
>>>>> of the file type.
>>>>
>>>> But the dma mappings are dynamic if there is vIOMMU, so checking dma
>> mappings are checking nothing if there is no mapping in the DMA domain.
>>>
>>> Yes, so there are 2 checks:
>>>     * at realize -> cpr register time.  if cpr can never work because
>>>       IOMMU_IOAS_CHANGE_PROCESS is not supported, then adds a blocker.
>>>
>>>     * at cpr time, in vfio_container_pre_save.  refuses to proceed if
>>>       iommufd_change_process() fails because non-file mappings are present.
>>>       Allows cpr if there are no mappings present.
> 
> Let me explain further.
> 
> There is a corner case that could bypass above checks. Source qemu starts with
> vIOMMU and non-file memory backend, then hotplug VFIO device, if guest
> driver doesn't setup any mapping or no guest driver attached, the mapping on
> host side can be empty, then above checks will both pass.

That is OK.  CPR is allowed in that case and succeeds because iommufd_change_process
has nothing to do.

However, after CPR, if non-file mappings are added, then the next CPR operation
would be blocked.

- Steve

> I'm not sure if that's a case we need to support. If not, feel free to add my RB.
> 
>>>
>>
>> If my explanation makes sense, any chance of getting an RB for this and the
>> related patch?
>>    backends/iommufd: change process ioctl
>>    vfio/iommufd: change process
>>
>> They are not affected by the other changes we have discussed.
>>
>> - Steve
>>
>>>>>>> How about I just add a comment:
>>>>>>>
>>>>>>> bool iommufd_change_process_capable(IOMMUFDBackend *be)
>>>>>>> {
>>>>>>>        /*
>>>>>>>         * Call IOMMU_IOAS_CHANGE_PROCESS to verify it is a recognized
>> ioctl.
>>>>>>>         * This is a no-op if the process has not changed since DMA was
>> mapped.
>>>>>>>         */
>>>>>>>
>>>>>>> - Steve
>>>>>>
>>>>
>>>
> 



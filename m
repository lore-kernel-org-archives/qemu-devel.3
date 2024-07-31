Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43FEC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZA1S-0007jZ-TC; Wed, 31 Jul 2024 10:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sZA1Q-0007ix-DX
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:09:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sZA1L-0004Nl-M2
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:09:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V7tWWO000495;
 Wed, 31 Jul 2024 14:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=cM+8/YJ/qpuc73GV7dtIljSIr5o9Vn4e4fItbPt1Cn8=; b=
 dWluuNIhVh+TjMBITxy8pToJCoFZ7a+RSsZQnr4x+7kqHV1yAZ5W6+jZeIyNHTjR
 OIApcxTVJ7S6Z8u7PAG1mj65UxvK4xmIFsyzkTcohahOJtNOSs0bhuNgqoD8hsS4
 qTYWYWIRBE1SmdH6Hz47aVDASFMDiXdvoaTUCrqOK2VOW5/a2YVFAcsF/baF+a7H
 BUVpNWTuHXcwPLEdUoHB32hLhs/nP84euI6X2PsfGf4kHAhcZNLvCUHk2PheNlFC
 pq3z8nqo3qExelIIGcnkF3B7hrZzofVQo3DMWQViLGoRvQnXBdVX0BWsiqfe8cMN
 tkBo4FZtucr1y0HGsD59UA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqfyfebs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 14:09:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46VD0h2A000715; Wed, 31 Jul 2024 14:09:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40pm84nbe4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 14:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRCn3ECaKVdWC7g+xj9/4CpHN0dUpWs4PhpXJItsOslUcQccxeaHpHmo/AHn7L433v2y8brqeGbzu5seBz43EcJfCYIx79Q8fyT8AWxLHQVKzzQRO+N6LoicXrbQu8a353KFHwfPBn+2/QMjUdcOarUaJlDKlf0Vzyu1duEQ4D305yVtBrqf1R0FkVWGbZZc2wlqzddFTrKRgY36V0ZU0l0QgVTLlIR2+QcxZbo8N08Pq797Er3psfCsUCsenObMEBSiuDbTxzG++5+MlrAZGqMpUd2McGse9AEnd0AHK6T78BJi5PrX1TcPvPX8lt2l3qDAdoPuGb6Dha0ID+hHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM+8/YJ/qpuc73GV7dtIljSIr5o9Vn4e4fItbPt1Cn8=;
 b=X/Kz504rocxuTVoMU/7RcJcwixMnv4RHmqy82/xdMP6BV3Cr7EKvUfNqwbpcHdsCjfhvkxkexv2jJBaA2CwwGl7nwZLjhP458qJR/VBymFBpOFoTY9LilEBRVZ6rZH3SxzTOOeMZyfkvUxcbPPUXfBOynHk4YCXk/M6RMYMPVzcTILQpdzVhwgpWzokdH5t4812C+JGtzcOt6wNT06JX6pWockjhBX9YdbeA+r5SfDa05sQ5cjVgtpMxg2jrAPUDyDhZpxEgtDyZMd7zFIxlQNdr1nzphVOskpbQAli8OXK/iuRG/ImGu3XcmgXWspl2e9G4hn1wk62ys5kF42WB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM+8/YJ/qpuc73GV7dtIljSIr5o9Vn4e4fItbPt1Cn8=;
 b=L3QTTJzDCA+2rs1tQGsSwEWShhWUStWHg+BG8zjCBvK/Lvn5XTrtEgnIbFND5/NzC+WtrVf0wGB5FTjEcCCetvYDSPhCgp4n2Cw9xBmXRB1RULSzaWHQGjmlGQ7H99Q4VCFVx4pz63xuhVHd6DbpMi+SErZlBrtfF2gMGKxN6Ro=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by MW5PR10MB5689.namprd10.prod.outlook.com (2603:10b6:303:19a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Wed, 31 Jul
 2024 14:09:29 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%3]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 14:09:29 +0000
Message-ID: <15d9fb93-58f9-4078-8f07-2ebf0f228d3b@oracle.com>
Date: Wed, 31 Jul 2024 10:09:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CAJaqyWdA_6Mx3mkcobmBjB5NDJt3tyqTJv2JijF0agnnBFxQxw@mail.gmail.com>
 <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
 <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
 <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
 <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
 <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
 <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
 <84374c5a-d937-4cb5-aafb-45ad75e2d837@oracle.com>
 <CAJaqyWfekhhG+5Zp4eddpp-2N=SjUL+7zs+YqS5xx6eWxa-PqQ@mail.gmail.com>
 <CACGkMEvYSBZpVG2x6q_viekods+QWrjoCETQcsgnHM+Ng4NWGw@mail.gmail.com>
 <CAJaqyWfm1zjU-eQ-j+GaWMHGt7Dk5nGUCUEA75yCga9sBxu39Q@mail.gmail.com>
 <2b2bf1a7-9ba9-4da9-b220-ce516ac029cc@oracle.com>
 <CAJaqyWf-Tcu0RdiWU3m9P07xJ7c33QXwSDH0-D=8u2FHC-=uZA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWf-Tcu0RdiWU3m9P07xJ7c33QXwSDH0-D=8u2FHC-=uZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::27) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|MW5PR10MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4c27b9-93ab-4c2f-7e28-08dcb16a6476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1RkR1FwRjAwcE9BMmgzMkpFbmF0WmRnMC91WEtQeVkyUDBJVG9RMmFzVU1k?=
 =?utf-8?B?RmR6d1Ria3FDU3FlUUdMTUdMby95K2J2NlVYd2hrZ2liTDhmTklUNE1YcVlU?=
 =?utf-8?B?cjk4WlRHclFtd3M5N0ZwQnpQM3BJKzhSWEdLQjJzVTRxU2s5NVp0TCt5clBY?=
 =?utf-8?B?Qml2SGtoeWdoWURqL0RPRjBYV3VMdmtiQUZraGw0RUlQUVV5RWw2Ym13L1V3?=
 =?utf-8?B?QUo4MzY1VGJXREJuRFBTbkw5NHhHUUxtZE9nRDhSKzc1Yk82Ym92YkN6VUha?=
 =?utf-8?B?cHRXTk1yWTJHUzNIeCtpN1QrdXRSeHcrYjdZN0QvM2xCRHY2VWErdUthR0w1?=
 =?utf-8?B?dWIwb1IvbDJBSU9KRE5PT1h2amU4N0dBUFpCVkt3L3BGYkoxeWx2ZWlDQytB?=
 =?utf-8?B?dWhzVklYQVhtSlVwY2NtUjJ4S1h3TDVLbC9ZRngvQUN4T3hJTnVGd2dndW5z?=
 =?utf-8?B?Q1NrU01mTDgxVTZCaVBzSHJySXFFUTFQb0s1cFEvYy9vSyt1Z2dyeHBDODRw?=
 =?utf-8?B?STFEYXBVTmptdVkvbi9nVUJmeUVSazVzSmgySU9yZmJJNkJ0blQxWng1ZUFX?=
 =?utf-8?B?WXAwdURocm5CbEViV1BsZ0ljWVAvVU5HLytWYTRpMTZLSFZSWGVtNnR6Sytw?=
 =?utf-8?B?bGkvbEIyRWNvck1vV21kRWE4b0JwZWtPZmVaZWhxczh0a0U2N1l1ZlpvamEv?=
 =?utf-8?B?NUxrQXMram0zWC9ZU1M3Uk8wdzh2ei9lbGw5U0V5cUNSYk1RMFpRTmxsbjZs?=
 =?utf-8?B?RHRSQVJEbHo5ZW45Kzg5QjRMWkY2dVJ0WFE1bnpyRE1RWkJaVkp6MGc2QVds?=
 =?utf-8?B?UFlsa0VCU0pJOUp0MjF1cXNGVFZuQU02anJjTmJEbyt3WFFLK0FUbEdUUXNR?=
 =?utf-8?B?L2RVcFhaNEtNZVlWamRmeGpVbC9QcmpkYy9zbDJKbWJWZ0VvK2p1TzZTTEVv?=
 =?utf-8?B?eUluUHRoY2ZtenQ2QW81WDd1S2FUMlkxRCtRU1JMcVROU0MxWmJMaTh2cXVJ?=
 =?utf-8?B?WE5FWDRhU3Uwa0tLQ1kwaHc2Z2ptQ05obzNjc2RTSVV1czJpajVKNUlyT3VL?=
 =?utf-8?B?VlNnWEgwTjhibkpzR3F6QzJlREVwbEFRb204Tk10SGxJYW5KSVBuWUo1M01i?=
 =?utf-8?B?aVY1QitSYlhiSFRUQmsxSG11UEJuMFhWK1JvQSt2MjlwVStiS2J3ZUtzNTVL?=
 =?utf-8?B?dEtWMFQvTnZoOTVOYkRlTk01V0JObmw1Y2gwYXU0eVhMamw4V0d2dDdSRXov?=
 =?utf-8?B?WEZzZ3NLWHJHSkNSdGRpejRTZlhBek5LaFlMajhObUs1OTNyRGFwOXVFUHZo?=
 =?utf-8?B?WGQ0dkRVQkFQa3djSndsMEdwQzc5RHc3bjd0R2U2YjZCLzFtWnlPcDE5eE52?=
 =?utf-8?B?TDFOOU1vaDNGSFZXUXhaT2tvWW9zb2xiOWY4NHVXa2NpYlppRnhXaCtCSGR2?=
 =?utf-8?B?YVh4QzNqUlA5NkVoMmVWZHBYYjFlK3daRDJIUk9PdjlCcVZqRTZlMm12Uks0?=
 =?utf-8?B?VFJGU2dWSVdRem0wUWdaQ2l4YlUwRnJVTEoyNnE2L1hHL01HNFFTbDZEM2FF?=
 =?utf-8?B?a21xTVlnR2wrU3lsZmFqQkFQcHQyRWxQbmd2Zlg4aTNaTkRTZGUvSGxCbzRl?=
 =?utf-8?B?RUE3ZmYwWUVyd3pvZWtiSFF1OG50YW5tRlEzeXJ2ZnBpUzdVeGxXbWVQYlBD?=
 =?utf-8?B?RUE1bXNtWFRiWTNrV2JHRWppNjdzRFhub2VnNHFwQURVYXl6WFUwMkh5YXpz?=
 =?utf-8?Q?1ihK9Av6V52B8QzpMU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHVwdHkvVTdXeGdYbmJ4VFY0emdVbWdhT01xem1oWkhSMDc4TlZoejYvWCta?=
 =?utf-8?B?S2RxVUl1dWF4RndySE9wSG9xQzZ4eGxERXVJWm00MFJTNFNwU0V4ZGd1ZXE4?=
 =?utf-8?B?dTZLZ0Fva0dQbHZIVXdzYkNsNXNrUkJjZEh5aldIeTdWZ0dsM2w5eHgvNnkv?=
 =?utf-8?B?TVdYQ0dzMlpIV3BranBIajY5TE5TZFNnQWZ5S0Y3SXVEbGZ5cERjb2VEL0pQ?=
 =?utf-8?B?QWVJY3IycjcwZlVpUm9lQUNzUFVJekJDWkFWZ21uT2dFcGxGYzR1K0ZnUldt?=
 =?utf-8?B?NzlVUzBheXdIejJVSHgvcTZHcUg0YUJJVEF4VVBHUHpiYm9aTEZPL3FkUm9i?=
 =?utf-8?B?eEZjUWEvVDlGdFF1bVhPU0JZSWs5Yi9pc1NkMmlsdHVOd1R4b285T1dpVmYz?=
 =?utf-8?B?Y3dBQ2NpRUtYQzJVMDJJREorRVdFcXJUT0M5M3FCNVJIZTRUSktpdERKQjVx?=
 =?utf-8?B?MDdTQS9nMCt4SkpZSnZHNmJpd3dRaFVpNzVtQXh2MUhWZExyZWg4YnplTTFK?=
 =?utf-8?B?cTh6RW16T0hUMHYxOVJjc1JaYjFTeWRxbVIyZUE2VCtONHBTb0N6K1NYQ3h4?=
 =?utf-8?B?YmQwQWgzbFYxK2l4bmpyWFF5d2lXenlJejVtSnhXNExmWjU5SnNSVGVJdGl2?=
 =?utf-8?B?dUNHWGNHWHlGM2o1VzY2MTNybENPYkFucSszWDk2bXhtN0g0QmpwU3dkZDlY?=
 =?utf-8?B?TjBXdFlGUHMxWmZ3U3VlSG5LMDUvcWR1ajBZVGdmcGJzNFR0Q3E3N0U3RURm?=
 =?utf-8?B?cnBTUHN6aTRRcm43MkZmK1dmTWl6SkloQ3U4ODN3WGVVZCs1TE5LaUk5cG9w?=
 =?utf-8?B?NUIwalJOeFRGc0JTc0krRFVOZHJXOG56SnIyemplMy9NZWxrMk1JbkZCTW1p?=
 =?utf-8?B?K2NVLzQ3OHJTQlJmd241TWJiYkdMQ3VPakpRUk8wTWgvbERpSFo5SVRxM2wr?=
 =?utf-8?B?V0lCRThnOVlvMVB4YkRtMk9Rb3ViS0NLcjNXMytGTzhUdHB1eFJveFI4cFRt?=
 =?utf-8?B?OGVPOEVNR1FPTkR2ZTg4VkxNdjRsVEMzckpocERRUGk2M05lckdqZlc5YmIy?=
 =?utf-8?B?d3VRbS9XcURpYUl6Skdudlk1Y2RGRGFqNS9nODVUdk8ya0NUUEtHU0xDUUkv?=
 =?utf-8?B?c0FMSjQyNmdDZFBVZEpHSXR6ZzZmakxDYVVLMGZLcWNmcDh4cDZacG9hbWJt?=
 =?utf-8?B?WG1jY2I0cDIvSDNaRXBHT00veFI3R0wvYlZRK3NUR29GakxjUUltalYxc2Jk?=
 =?utf-8?B?ZmZSdEdkb3M2Y2lCZ2tUaUxvbTY4enEvRUNyUnZxQ1pTcm5qZ2tYa0xrUGtG?=
 =?utf-8?B?ZURtL254K3R0TFlCT25KM2x1Zk5Qdktiald0SXNydVhIOTIvL2RNY3IvTUh3?=
 =?utf-8?B?a1pUNjQrVTRxT1VndlhVcldNcGxLUGJrYms4cFZ5WkJteitKZW5vQnF2WjA4?=
 =?utf-8?B?S2sxamxrRTFCZWhrY3ViTXZ6VkFUZmtVTVBTZ0dPSllzaWh0V0lUZm1Uejcw?=
 =?utf-8?B?bjBaSlFRUm1DMGlwdXhMQkVHNHhQZGZUSjhleiszV1ZicU44ZHlUanhTVEFu?=
 =?utf-8?B?ZXdKM3JmeFp0dXVLWnlyUnRVMUg4MkRTRnAxdzdUUUVBY2tQL0ZwbFU1eVhO?=
 =?utf-8?B?cm5idHhxelY0ZWVqS0tYamF4TDVjblgybkFWa3J6d3R4Qm1tY2xpc3ovZFhM?=
 =?utf-8?B?SHYwVTZYOUdPdEJldVg4ZlBJNE5GVjU2V1BPVmRzZ1V4TllqQkJkb1ZENjhr?=
 =?utf-8?B?TXBReXRlSzZVenlycUFFb29sVDUrdURVODVDN0hjNTl2RGZuUHE0NW1tRzVU?=
 =?utf-8?B?Z0NVaXRqeGJ5bXplQ1JqYjdVeVBqaE00OHlhMmY1RmlFQllKRm1FUk9NQjRa?=
 =?utf-8?B?Y2ZHR2ZTVEtXN3RtSGk2TU1pTisvTjVyM2l0L215d2NJTVpiUzVxMjRydjQr?=
 =?utf-8?B?Nk11YzdPR05PT3pxRnBrZmFickY3QjdKRnpCQnZVbERuSUVpYVg3dGVTUWhp?=
 =?utf-8?B?TTZacXdIV2s5TTVRYzYxTUI1eFh2UVFpQmpCdE5sZzZETjFQdmh3dFhPbkJz?=
 =?utf-8?B?SHo4Y2VUckRKK3JPUERsY09jOE81YkliUzdEMTBVNjRtUTRidmRGYVpqZmQ5?=
 =?utf-8?B?QldHMHU5bHhyWjZISWtzeDZBQzIwYUtoOXFwZ0ZrNlFCV2tyczBiZVhVNzZW?=
 =?utf-8?Q?lz53ILg1Bvi39/SmaXJLevg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0CalEClR4pAsP5OsYraJFtY2U8N/ATssr3IkBPhKB2aqcTkKPrhhQ1n14MQ7rG6V+2FqZTzj4I/4hkst6fCSlJ4SpfVNnpxZvQjnlOpjcl3VdskNVkTtr0JG1UYRl/cVtaR0yWmcDRihKpF1DS5E9xcLhwAIqfSxZU6kp7vAJaeTiuRy7h3TrN+6elGNWUpczcV3riptcu47FJAQmrYFFW/25pk04vWqBmMXjgl0DkCCPitntEK7NUHUFgVXkcUfSaxQ1efZeLS5E+JZM/KnJj9NWIruzraXRMi9EKNBWFKOgFv0VWSs269P8hW8DhduugxuxaW6vumGFf0NJSZ56t4DeLGlfuFerI9nLcsgJN0qiRONhbZeMOmqXk0PuT/c23FmFhGq+voJeydV42h5GTyZM6fbgglxsT+avr7h5gc3RdXFyksjmEXcFFvAqyt2VOXcdALunb0xi/NVqK4cr7L8VPLpkl8HkskzIS+W7+Hv2PSY9KdgN3mDG9fozY5Gcjz4AjnjZGrykWCJm5VaUagD6REUP9jDhMMu+XnalRHEnB8TXf8ZQqm4OBesgaVC/SBxYhbyFIOe9+gBXBPZ/PtfD5rJpbv7mE9yJZVrlXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4c27b9-93ab-4c2f-7e28-08dcb16a6476
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 14:09:29.2537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5r7alplCKICbHeLL/72omHCbgtLBvCHFT7yZIIwzaZzMQdFU78hmF3cNebI4+nVRxFkNeWdU4a6nQlShefKcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407310101
X-Proofpoint-GUID: 5gCKjpotwyey-uECF7YrZoE30Z1rDFdD
X-Proofpoint-ORIG-GUID: 5gCKjpotwyey-uECF7YrZoE30Z1rDFdD
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 7/31/24 5:56 AM, Eugenio Perez Martin wrote:
> On Tue, Jul 30, 2024 at 2:32 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 7/30/24 7:00 AM, Eugenio Perez Martin wrote:
>>> On Tue, Jul 30, 2024 at 10:48 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>
>>>> On Mon, Jul 29, 2024 at 6:05 PM Eugenio Perez Martin
>>>> <eperezma@redhat.com> wrote:
>>>>>
>>>>> On Wed, Jul 24, 2024 at 7:00 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 5/13/24 11:56 PM, Jason Wang wrote:
>>>>>>> On Mon, May 13, 2024 at 5:58 PM Eugenio Perez Martin
>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Mon, May 13, 2024 at 10:28 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> On Mon, May 13, 2024 at 2:28 PM Eugenio Perez Martin
>>>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Sat, May 11, 2024 at 6:07 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Fri, May 10, 2024 at 3:16 PM Eugenio Perez Martin
>>>>>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Fri, May 10, 2024 at 6:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Thu, May 9, 2024 at 3:10 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Thu, May 9, 2024 at 8:27 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Thu, May 9, 2024 at 1:16 AM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Wed, May 8, 2024 at 4:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Tue, May 7, 2024 at 6:57 PM Eugenio Perez Martin <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> On Tue, May 7, 2024 at 9:29 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 3:56 PM Eugenio Perez Martin
>>>>>>>>>>>>>>>>>>> <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 8:47 AM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> On Wed, Apr 10, 2024 at 6:03 PM Eugenio Pérez <eperezma@redhat.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> The guest may have overlapped memory regions, where different GPA leads
>>>>>>>>>>>>>>>>>>>>>> to the same HVA.  This causes a problem when overlapped regions
>>>>>>>>>>>>>>>>>>>>>> (different GPA but same translated HVA) exists in the tree, as looking
>>>>>>>>>>>>>>>>>>>>>> them by HVA will return them twice.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> I think I don't understand if there's any side effect for shadow virtqueue?
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> My bad, I totally forgot to put a reference to where this comes from.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Si-Wei found that during initialization this sequences of maps /
>>>>>>>>>>>>>>>>>>>> unmaps happens [1]:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> HVA                    GPA                IOVA
>>>>>>>>>>>>>>>>>>>> -------------------------------------------------------------------------------------------------------------------------
>>>>>>>>>>>>>>>>>>>> Map
>>>>>>>>>>>>>>>>>>>> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
>>>>>>>>>>>>>>>>>>>> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
>>>>>>>>>>>>>>>>>>>> [0x80001000, 0x2000001000)
>>>>>>>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
>>>>>>>>>>>>>>>>>>>> [0x2000001000, 0x2000021000)
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Unmap
>>>>>>>>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
>>>>>>>>>>>>>>>>>>>> 0x20000) ???
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> The third HVA range is contained in the first one, but exposed under a
>>>>>>>>>>>>>>>>>>>> different GVA (aliased). This is not "flattened" by QEMU, as GPA does
>>>>>>>>>>>>>>>>>>>> not overlap, only HVA.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> At the third chunk unmap, the current algorithm finds the first chunk,
>>>>>>>>>>>>>>>>>>>> not the second one. This series is the way to tell the difference at
>>>>>>>>>>>>>>>>>>>> unmap time.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> [1] https://urldefense.com/v3/__https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html__;!!ACWV5N9M2RV99hQ!MXbGSFHVbqRf0rzyWamOdnBLHP0FUh3r3BnTvGe6Mn5VzXTsajVp3BB7VqlklkRCr5aKazC5xxTCScuR_BY$
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Ok, I was wondering if we need to store GPA(GIOVA) to HVA mappings in
>>>>>>>>>>>>>>>>>>> the iova tree to solve this issue completely. Then there won't be
>>>>>>>>>>>>>>>>>>> aliasing issues.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I'm ok to explore that route but this has another problem. Both SVQ
>>>>>>>>>>>>>>>>>> vrings and CVQ buffers also need to be addressable by VhostIOVATree,
>>>>>>>>>>>>>>>>>> and they do not have GPA.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> At this moment vhost_svq_translate_addr is able to handle this
>>>>>>>>>>>>>>>>>> transparently as we translate vaddr to SVQ IOVA. How can we store
>>>>>>>>>>>>>>>>>> these new entries? Maybe a (hwaddr)-1 GPA to signal it has no GPA and
>>>>>>>>>>>>>>>>>> then a list to go through other entries (SVQ vaddr and CVQ buffers).
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> This seems to be tricky.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> As discussed, it could be another iova tree.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Yes but there are many ways to add another IOVATree. Let me expand & recap.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Option 1 is to simply add another iova tree to VhostShadowVirtqueue.
>>>>>>>>>>>>>>>> Let's call it gpa_iova_tree, as opposed to the current iova_tree that
>>>>>>>>>>>>>>>> translates from vaddr to SVQ IOVA. To know which one to use is easy at
>>>>>>>>>>>>>>>> adding or removing, like in the memory listener, but how to know at
>>>>>>>>>>>>>>>> vhost_svq_translate_addr?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Then we won't use virtqueue_pop() at all, we need a SVQ version of
>>>>>>>>>>>>>>> virtqueue_pop() to translate GPA to SVQ IOVA directly?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> The problem is not virtqueue_pop, that's out of the
>>>>>>>>>>>>>> vhost_svq_translate_addr. The problem is the need of adding
>>>>>>>>>>>>>> conditionals / complexity in all the callers of
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The easiest way for me is to rely on memory_region_from_host(). When
>>>>>>>>>>>>>>>> vaddr is from the guest, it returns a valid MemoryRegion. When it is
>>>>>>>>>>>>>>>> not, it returns NULL. I'm not sure if this is a valid use case, it
>>>>>>>>>>>>>>>> just worked in my tests so far.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Now we have the second problem: The GPA values of the regions of the
>>>>>>>>>>>>>>>> two IOVA tree must be unique. We need to be able to find unallocated
>>>>>>>>>>>>>>>> regions in SVQ IOVA. At this moment there is only one IOVATree, so
>>>>>>>>>>>>>>>> this is done easily by vhost_iova_tree_map_alloc. But it is very
>>>>>>>>>>>>>>>> complicated with two trees.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Would it be simpler if we decouple the IOVA allocator? For example, we
>>>>>>>>>>>>>>> can have a dedicated gtree to track the allocated IOVA ranges. It is
>>>>>>>>>>>>>>> shared by both
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 1) Guest memory (GPA)
>>>>>>>>>>>>>>> 2) SVQ virtqueue and buffers
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> And another gtree to track the GPA to IOVA.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The SVQ code could use either
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 1) one linear mappings that contains both SVQ virtqueue and buffers
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> or
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 2) dynamic IOVA allocation/deallocation helpers
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> So we don't actually need the third gtree for SVQ HVA -> SVQ IOVA?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> That's possible, but that scatters the IOVA handling code instead of
>>>>>>>>>>>>>> keeping it self-contained in VhostIOVATree.
>>>>>>>>>>>>>
>>>>>>>>>>>>> To me, the IOVA range/allocation is orthogonal to how IOVA is used.
>>>>>>>>>>>>>
>>>>>>>>>>>>> An example is the iova allocator in the kernel.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Note that there's an even simpler IOVA "allocator" in NVME passthrough
>>>>>>>>>>>>> code, not sure it is useful here though (haven't had a deep look at
>>>>>>>>>>>>> that).
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I don't know enough about them to have an opinion. I keep seeing the
>>>>>>>>>>>> drawback of needing to synchronize both allocation & adding in all the
>>>>>>>>>>>> places we want to modify the IOVATree. At this moment, these are the
>>>>>>>>>>>> vhost-vdpa memory listener, the SVQ vring creation and removal, and
>>>>>>>>>>>> net CVQ buffers. But it may be more in the future.
>>>>>>>>>>>>
>>>>>>>>>>>> What are the advantages of keeping these separated that justifies
>>>>>>>>>>>> needing to synchronize in all these places, compared with keeping them
>>>>>>>>>>>> synchronized in VhostIOVATree?
>>>>>>>>>>>
>>>>>>>>>>> It doesn't need to be synchronized.
>>>>>>>>>>>
>>>>>>>>>>> Assuming guest and SVQ shares IOVA range. IOVA only needs to track
>>>>>>>>>>> which part of the range has been used.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Not sure if I follow, that is what I mean with "synchronized".
>>>>>>>>>
>>>>>>>>> Oh right.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> This simplifies things, we can store GPA->IOVA mappings and SVQ ->
>>>>>>>>>>> IOVA mappings separately.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Sorry, I still cannot see the whole picture :).
>>>>>>>>>>
>>>>>>>>>> Let's assume we have all the GPA mapped to specific IOVA regions, so
>>>>>>>>>> we have the first IOVA tree (GPA -> IOVA) filled. Now we enable SVQ
>>>>>>>>>> because of the migration. How can we know where we can place SVQ
>>>>>>>>>> vrings without having them synchronized?
>>>>>>>>>
>>>>>>>>> Just allocating a new IOVA range for SVQ?
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> At this moment we're using a tree. The tree nature of the current SVQ
>>>>>>>>>> IOVA -> VA makes all nodes ordered so it is more or less easy to look
>>>>>>>>>> for holes.
>>>>>>>>>
>>>>>>>>> Yes, iova allocate could still be implemented via a tree.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Now your proposal uses the SVQ IOVA as tree values. Should we iterate
>>>>>>>>>> over all of them, order them, of the two trees, and then look for
>>>>>>>>>> holes there?
>>>>>>>>>
>>>>>>>>> Let me clarify, correct me if I was wrong:
>>>>>>>>>
>>>>>>>>> 1) IOVA allocator is still implemented via a tree, we just don't need
>>>>>>>>> to store how the IOVA is used
>>>>>>>>> 2) A dedicated GPA -> IOVA tree, updated via listeners and is used in
>>>>>>>>> the datapath SVQ translation
>>>>>>>>> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ok, so the part I was missing is that now we have 3 whole trees, with
>>>>>>>> somehow redundant information :).
>>>>>>>
>>>>>>> Somehow, it decouples the IOVA usage out of the IOVA allocator. This
>>>>>>> might be simple as guests and SVQ may try to share a single IOVA
>>>>>>> address space.
>>>>>>>
>>>>>>
>>>>>> I'm working on implementing your three suggestions above but I'm a bit
>>>>>> confused with some of the wording and I was hoping you could clarify
>>>>>> some of it for me when you get the chance.
>>>>>>
>>>>>> ---
>>>>>> For your first suggestion (1) you mention decoupling the IOVA allocator
>>>>>> and "don't need to store how the IOVA is used."
>>>>>>
>>>>>> By this, do you mean to not save the IOVA->HVA mapping and instead only
>>>>>> save the allocated IOVA ranges?
>>>>
>>>> Yes.
>>>>
>>>>>> In other words, are you suggesting to
>>>>>> create a dedicated "IOVA->IOVA" tree like:
>>>>>>
>>>>>> struct VhostIOVATree {
>>>>>>        uint64_t iova_first;
>>>>>>        uint64_t iova_last;
>>>>>>        IOVATree *iova_map;
>>>>>> };
>>>>
>>>> It could be this or other. I think the point is the allocator is only
>>>> used for IOVA allocation but it doesn't have any information about the
>>>> mapping.
>>>>
>>>>>>
>>>>>> Where the mapping might look something like (where translated_addr is
>>>>>> given some kind of 0 value):
>>>>>>
>>>>>> iova_region = (DMAMap) {
>>>>>>        .iova = iova_first,
>>>>>>        .translated_addr = 0,
>>>>>>        .size = region_size - 1,
>>>>>>        .perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>>>> };
>>>>>>
>>>>>> Also, if this is what you mean by decoupling the IOVA allocator, what
>>>>>> happens to the IOVA->HVA tree?
>>>>
>>>> We will have two structures:
>>>>
>>>> 1) IOVA domain (in charge of IOVA range allocation/deallocation)
>>>> 2) How the IOVA is used, e.g an IOVA->HVA tree
>>>>
>>>>> Are we no longer saving these mappings in
>>>>>> a tree?
>>>>>>
>>>>>> ---
>>>>>> In your second suggestion (2) with a dedicated GPA->IOVA tree, were you
>>>>>> thinking something like this? Just adding on to VhostIOVATree here:
>>>>>>
>>>>>> struct VhostIOVATree {
>>>>>>        uint64_t iova_first;
>>>>>>        uint64_t iova_last;
>>>>>>        IOVATree *iova_map;
>>>>>>        IOVATree *gpa_map;
>>>>>> };
>>>>
>>>> I'd split the mappings if it's possible.
>>>>
>>>>>>
>>>>>> Where the mapping might look something like:
>>>>>>
>>>>>> gpa_region = (DMAMap) {
>>>>>>        .iova = iova_first,
>>>>>>        .translated_addr = gpa_first,
>>>>>>        .size = region_size - 1,
>>>>>>        .perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>>>> };
>>>>>>
>>>>>> Also, when you say "used in the datapath SVQ translation", we still need
>>>>>> to build the GPA->IOVA tree when vhost_vdpa_listener_region_add() is
>>>>>> called, right?
>>>>
>>>> Right.
>>>>
>>>>>>
>>>>>> ---
>>>>>> Lastly, in your third suggestion (3) you mention implementing a
>>>>>> SVQ->IOVA tree, making the total number of IOVATrees/GTrees 3: one for
>>>>>> just IOVAs, one for GPA->IOVA, and the last one for SVQ->IOVA. E.g.
>>>>>>
>>>>>> struct VhostIOVATree {
>>>>>>        uint64_t iova_first;
>>>>>>        uint64_t iova_last;
>>>>>>        IOVATree *iova_map;
>>>>>>        IOVATree *gpa_map;
>>>>>>        IOVATree *svq_map;
>>>>>> };
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> Let me know if I'm understanding this correctly. If I am, this would
>>>>>> require a pretty good amount of refactoring on the IOVA allocation,
>>>>>> searching, destroying, etc. code to account for these new trees.
>>>>>>
>>>>>
>>>>> Ok I think I understand your previous question better, sorry for the delay :).
>>>>>
>>>>> If I'm not wrong, Jason did not enumerate these as alternatives but as
>>>>> part of the same solution. Jason please correct me if I'm wrong here.
>>>>>
>>>>> His solution is composed of three trees:
>>>>> 1) One for the IOVA allocations, so we know where to allocate new ranges
>>>>> 2) One of the GPA -> SVQ IOVA translations.
>>>>> 3) Another one for SVQ vrings translations.
>>>>>
>>>>
>>>> Exactly.
>>>>
>>>>> In my opinion to use GPA this is problematic as we force all of the
>>>>> callers to know if the address we want to translate comes from the
>>>>> guest or not. Current code does now know it, as
>>>>> vhost_svq_translate_addr is called to translate both buffer dataplane
>>>>> addresses and control virtqueue buffers, which are also shadowed.  To
>>>>> transmit that information to the caller code would require either
>>>>> duplicate functions, to add a boolean, etc, as it is in a different
>>>>> layer (net specific net/vhost-vdpa.c vs generic
>>>>> hw/virtio/vhost-shadow-virtqueue.c).
>>>>>
>>>>> In my opinion is easier to keep just two trees (or similar structs):
>>>>> 1) One for the IOVA allocations, so we know where to allocate new
>>>>> ranges. We don't actually need to store the translations here.
>>>>> 2) One for HVA -> SVQ IOVA translations.
>>>>>
>>>>> This way we can accommodate both SVQ vrings, CVQ buffers, and guest
>>>>> memory buffers, all on the second tree, and take care of the HVA
>>>>> duplications.
>>>>
>>>> Probably, but how to take care of HVA duplications (I may miss the
>>>> context, sorry)?
>>>>
>>>
>>> What to do with the duplicated HVA is an added problem that deserves
>>> more discussion, right. If a duplicated entry gets deleted, the other
>>> one should take its place in both trees.
>>>
>>> Store them in an ordered list and look for replacements on tree
>>> deletion maybe? It would be great to locate a similar usage and see
>>> what is done there.
>>>
>>
>> Isn't what we're doing here supposed to solve this issue of
>> duplicated/overlapping HVA ranges?
>>
> 
> Yes, let me explain again with the example of Si-Wei [1]:
> 
> 
> HVA                    GPA                IOVA
> -------------------------------------------------------------------------------------------------------------------------
> Map
> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000)
> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
> [0x80001000, 0x2000001000)
> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
> [0x2000001000, 0x2000021000)
> 
> Unmap
> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
> 0x20000) ???
> 
> The third HVA range is contained in the first one, but exposed under a
> different GVA (aliased). This is not "flattened" by QEMU, as GPA does
> not overlap, only HVA.
> 
> In this case we can ignore the third range, as we already have it in
> HVA. As it is unmapped first, it is ok to simply ignore it for all the
> QEMU run.
> 
> Now, what action should we take if the first range, GPA [0x0,
> 0x80000000), is unmapped first? We should reintroduce the smaller
> chunk HVA [0x7f7903ea0000, 0x7f7903ec0000) -> SVQ IOVA [0x2000001000,
> 0x2000021000) entry in the tree.
> 
> Maybe we can trust every case of this will be handled in a stack
> fashion and all of this is overthinking, but I'd like to know other's
> opinions / thoughts here.
> 
> Thanks!
> 
> [1] https://urldefense.com/v3/__https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html__;!!ACWV5N9M2RV99hQ!NM0p-noaAc1mabiBCHIh8H7LfCwn40F4jJ-zHuHXu9XedG0hXP5gh660HAWVVTqqIzhvmFAcueJFibhYh4E$
> 

For my understanding, say we have those 3 memory mappings:

HVA                    GPA                IOVA
---------------------------------------------------
Map
(1) [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 
0x80000000)
(2) [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000) 
[0x80001000, 0x2000001000)
(3) [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) 
[0x2000001000, 0x2000021000)

And then say when we go to unmap (e.g. vhost_vdpa_svq_unmap_ring) we're 
given an HVA of 0x7f7903eb0000, which fits in both the first and third 
mappings.

The correct one to remove here would be the third mapping, right? Not 
only because the HVA range of the third mapping has a more "specific" or 
"tighter" range fit given an HVA of 0x7f7903eb0000 (which, as I 
understand, may not always be the case in other scenarios), but mainly 
because the HVA->GPA translation would give GPA 0xfedb0000, which only 
fits in the third mapping's GPA range. Am I understanding this correctly?

---

In the case where the first mapping here is removed (GPA [0x0, 
0x80000000)), why do we use the word "reintroduce" here? As I understand 
it, when we remove a mapping, we're essentially invalidating the IOVA 
range associated with that mapping, right? In other words, the IOVA 
ranges here don't overlap, so removing a mapping where its HVA range 
overlaps another mapping's HVA range shouldn't affect the other mapping 
since they have unique IOVA ranges. Is my understanding correct here or 
am I probably missing something?

>>>> Thanks
>>>>
>>>>>
>>>>> Thanks!
>>>>>
>>>>>> Thanks Jason!
>>>>>>
>>>>>>>>
>>>>>>>> In some sense this is simpler than trying to get all the information
>>>>>>>> from only two trees. On the bad side, all SVQ calls that allocate some
>>>>>>>> region need to remember to add to one of the two other threes. That is
>>>>>>>> what I mean by synchronized. But sure, we can go that way.
>>>>>>>
>>>>>>> Just a suggestion, if it turns out to complicate the issue, I'm fine
>>>>>>> to go the other way.
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> Thanks
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 


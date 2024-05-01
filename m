Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E332AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 23:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ixu-0005a6-OJ; Wed, 01 May 2024 19:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s2Ixr-0005Zi-Cn
 for qemu-devel@nongnu.org; Wed, 01 May 2024 19:02:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s2Ixl-0006tU-8K
 for qemu-devel@nongnu.org; Wed, 01 May 2024 19:02:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 441JfjiY030843; Wed, 1 May 2024 22:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=rJHFzi6dvNoAFWrHOs19s0ZRmgrx7j5ILyWOYIhA5ww=;
 b=LGclreyKgi4Ehbv/E5qodZszfZoBaz4xk+3Mw+8xDEMDmWd27WTcjxx34eGpzFlHBji2
 14no74m42ssYGOHGbJJC70ZtWMmd99AG0HRigl3TN+g+aZXe2wvDjN/VkrfenkTjgE0K
 CTmpY9n6yexO04XQueaq5RtX/wNQ1nhUIuUa/GspC7roJZ62MPHWAmwpVpsJ80MElPGW
 OAQDBjFFcschG3JlbOcKUNLI8fVtZldYg8y02gSg5NhY4xThhJ6kaV6Cy3XAXl5J5Nf+
 0KAm/Zgh8YLV91Vd7FE83yS+LALPLVnTglJ6lZQud4oVqmqecAtIY9XU0x/rx1yzdXN6 Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqy30wbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 May 2024 22:09:37 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 441LoTRA016689; Wed, 1 May 2024 22:08:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqtg11wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 May 2024 22:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkgcXZnPS9RXJVMbSsXdWiLoEAUA1Ogwcek0od6y2ERVFE25xOTrBhmXfA7UYkm2sv3a4x1DnbT6FaV4R78Z1Z1ukSACcN7i6mhpflis2LbsI97s2JLDJ9RT26hbaytQoYDbqdkAc6NQEuQZqMA7apomo8P/kuIJ0nZcTbtSmEvmKLi6JwAtn9tKd+i3rkrHY7giKLowV9yNKC0Kfnpk2hmJ6e7fcD2b9qlX69ybNoibv/M692I9yueEpTtSYAUmT1eRAg8zslUYKVslPtTVZXdDmCG/pK1opqSp+QOt13avmvrUs4XrZOmhqobS4tEkhmOZhfPwyPMYvKw70VTltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJHFzi6dvNoAFWrHOs19s0ZRmgrx7j5ILyWOYIhA5ww=;
 b=mM1TYC9bT7xmNiXAbOZ7qgW+/la68H8Elmeb9VTALt+SEwyVsWl4A4qSLH03pCEvI7pAIWMjWLYJfWzSyQwXNx2PmRx/PMfYsuEUQ6iTenRNxWeryMHJ7tID2V0um6mcvkQC5dHX+uzx3/TRF6G9eVL2qJLmmWaejSxoj1ylafyi1H8hDj6tAtt2yl2d4imBX2sgk1rnvNGzwJOqCa0fCKVnI9d68tZ1P/LAjcj+d6mUbwEia/V9Q5fEXJ4hrRnzwruxqR/d5zZr6VZDKY5l0Sj2qDgwhLEmTBR16BUg9mqx3vlyZHEvIrNo8IGiEaf0pIPYi49Xev+uMHa2nnSzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJHFzi6dvNoAFWrHOs19s0ZRmgrx7j5ILyWOYIhA5ww=;
 b=jxu95AAem/ctdbYpM3I3qW6T1ZTxSNqFrwPcsZrCunz6xzSlUA/ey3fSYDs7tcAQttknG3Q47dFHXwiupzCHXNwg8dLlG/HpU8AcyNjvdzc50tIYJtyR9o6XZuBocQMbdhIO5ox4qXzirs39ktGFIekc8/KAkDKLAKR+0R+VxkM=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB5594.namprd10.prod.outlook.com (2603:10b6:510:f6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 22:08:38 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74%4]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 22:08:38 +0000
Message-ID: <d708a088-6d20-4dd3-8167-fda21b2551ff@oracle.com>
Date: Wed, 1 May 2024 15:08:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
 <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
 <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
 <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
 <f2dcbc76-f90f-4abe-b5c3-f159befd07bd@oracle.com>
 <CAJaqyWeSrwVt6imakpccieqN_3C85JcOZuj=FR+Xnmr7FKFaAw@mail.gmail.com>
 <9f347cd6-8c18-4253-8a5f-efae08230a62@oracle.com>
 <CAJaqyWeyfPp5bh9iZrkwZshoStEHZ85P6t4TcEdmR5sDYhG4ug@mail.gmail.com>
 <1e1cbe99-65e8-4292-b19b-8e054f5b1fca@oracle.com>
 <CAJaqyWeGUM+HZM1-SdQfXmw_xw_tVq9Nns+EH_M8jbOQatXWTw@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeGUM+HZM1-SdQfXmw_xw_tVq9Nns+EH_M8jbOQatXWTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:207:3c::47) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5bbdac-ec91-4c14-edea-08dc6a2b408f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFV0bnF3UXdHT01ZVHNPM2d2L3d2QVFLMGhkNXJ2U0lqYnE3dWFNcGxNNENh?=
 =?utf-8?B?VWN2Wkcyd1dJQlY5c0xrai9mR2dENHQ4WVNZbUxXQmhSbVAzYVJrNEZzN3pB?=
 =?utf-8?B?a1dUczNxSG9GTjdBS1djUnlaRVF1TS9mdnA2bGVQT2svbTdwTXduWnk4cWtS?=
 =?utf-8?B?b0RKRTlBZnFJYkFFU0NwZWphVXVWdksrOFJwS0JEeFdRb3ZJVXhHRmxSK1ls?=
 =?utf-8?B?SktaWTcvVzRHeWVhMEw1MXY5Q1M2SVlQTGYvSWJwalRUbENEYjM1eXRGb1RG?=
 =?utf-8?B?MzNlTlE4cVMrMFBtOCtDZkcvZzU5YUNTZ0sxMC80dmZ5VkRGZkpGWVVFbWlp?=
 =?utf-8?B?aG9pbXcxdzdHSHN6YUx5emdQcEhGemZZeVkzSy9Pak5QczQ0YWx0OGJhWTc1?=
 =?utf-8?B?cTd0RFp2QVNpVTRua2lCV3FRaE1nb2dSZld0V0hMVTNiZlIzY2tKU3V2TU5E?=
 =?utf-8?B?MjVkUmE1RVZ5SlIwcHdXUWVmbkF6N2tGYjZMajdjSmdjNEIvd09VN3Vjb2Yy?=
 =?utf-8?B?cWowRVlmQ0t2VEpGSDNqaC9yeDBZYXhEV0RoRXBML25McnF6eFlYeXlLUys2?=
 =?utf-8?B?a1BmUUhUQTNBWlVSTWtlbHMyU2Rvay9WVGIvMzlxZHZSRmpLR2dWSG9sRTZn?=
 =?utf-8?B?V0M0L1lJc2ZhMnM1dEp1aVd4TUxPU1R1U1czOHVHNXp6akwvekxLQXZpekg0?=
 =?utf-8?B?eGEveVRXOHBJVWJTMEFxMzJ6czVOMm1SaHk2MXp0VXFhNEJBUElOVWRNVitw?=
 =?utf-8?B?OHZSNzhFYit6NjBKR1dCbXZULzYvYzlOanIrQ25OdXZlVVRMd2xMY1ZhT3dh?=
 =?utf-8?B?bUF5amN4dzMra2NPbjMxV1VFQUFVL1ZNNWtvY3J1T1pnQnU5OW04ZVJtMzBW?=
 =?utf-8?B?YTJwOHVSNFhzQ21JLzJTOGMzaHRySjlZckNjTGRaOHlzaHR1dzIrN0ZQL0FE?=
 =?utf-8?B?alp6SmR2QlBrK1ZTQW9yM2E3bTNYK2YrV2xoaEZXUW9BOE1PdTFaYVFGeHRo?=
 =?utf-8?B?S1JueWY4Z3FlNTJ1L1gycTJDU25DQ2YvWmdiR1pmSzhzd1ZOYjNBSmVQSElq?=
 =?utf-8?B?czlHcXRJUkNTU043L2sxTWFpQmZWTWR1Skt4M3I2Z29tS3gzeWErRldTTDEz?=
 =?utf-8?B?VC9nMWRiTWFZZlpxNktGQi9iUjIzdjZKU2JPN0lkaW9sT3BrR2c2dnB0M1hH?=
 =?utf-8?B?R0F4bXFDcG1JdEgxbUw2ZS9TTk4vUEFWUEYrcjZiSVJLZkFod3FUMTJMY2U1?=
 =?utf-8?B?QjcweUV0T0c0Tmp4M1kxN1E2U1Fpd1FUbWJOR3ZaZ08zZ3dnOW1Ca3JvNjMw?=
 =?utf-8?B?MVQ4ZDVQeDBrVjV6SG9YLzhtQWJzSlRnOHNwdG5yNkJFSm90a2NaK255bnR2?=
 =?utf-8?B?YnpnckcwenVlcjg5VUV5L0ZjbnhEcTRpSGUxYXhWbWxuOUM4dGNabURXUTFm?=
 =?utf-8?B?L2NrN3pUL2xDaUhVb0lrUVBuMmVaNlppaDJZTnlIRXppQjV3TTNzSk1sUTAy?=
 =?utf-8?B?Ymo5M0t2RW5QbmZocjlhdjdkREZhWENuUEkxa054djMzYXViWDF1YXNUV29R?=
 =?utf-8?B?SFdPSStoczAvU2IyQXZIaHhyS0xIRGwyTUpIT3lqbWcxWlBUQUlwMXprZldN?=
 =?utf-8?Q?yey56Cde/PZ+588qHqqSwgiipLecXdFvFWmhyIneqBow=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEI3TGl3OVJQanpLMEZxTzExQjk5Y1ZYZm1Jb1IyUUljejdmZERvZDhkbmN5?=
 =?utf-8?B?K0k5ZGlrYXlMdm1NcUJTcWdiZzJhQ3Y3YkpYNUFaYTVtNWpTbE0rSk0vc1hE?=
 =?utf-8?B?TjkzbGdtei9FQXdUaENyc2VTMUVISWxFYUh4blkzWm4weHdGWXpEMmEwTVZZ?=
 =?utf-8?B?M1pHMy96bTBVQXlNb1MrYXFXWVBoL0M5dlhJRlB6RU1GM3pDUlZrenBuYVBz?=
 =?utf-8?B?WXhhMjBpZnJVakVzdS8xSmRoQkdETU53MWZKK3dLMlM5cU9UMTdRTXRzdVpC?=
 =?utf-8?B?Qm8velNCOXlWQTFxaWI1eWFjck1Gd0pvcTIwaTc2Vzl5eEoxT3NYV1B3M3d2?=
 =?utf-8?B?Qi9yWHdvMXVFM1lIRFdNYkZ6UUpJaGpBZUVZSGpzUHhKM0pwMVk1WVNkMVhD?=
 =?utf-8?B?TUV4NG43OHJJa3VoSU1lUmVaUEJmYm4xeFVmYXRYNEZvTE1ZT2pQYVBqNFhy?=
 =?utf-8?B?R3NsME5nRVkyWldWZWgrcmZsTHU3UTRRWHhnem9MVXFKRGNORmpWbGt4aVB1?=
 =?utf-8?B?ZHVoWFlINmFsTUVzZC95UzVPNVVkdFlGb3gzdGFock5mcmpvTVpyY3hZelFw?=
 =?utf-8?B?eSt3TFhLaktYSlJDMmJBcVdzMyt5T3Y1djZQSnRZUjZuMEpUMjFRVWJEUkVJ?=
 =?utf-8?B?Q0d1YUJBZTJHeVhid25DRXdsNGt4NWhyeFFzTWF6WEs0djloQkVGWnZPRnZj?=
 =?utf-8?B?OFNLb0k3VXlHT0xBN2xrNnJzYk04NDAzdTVsa0xmdjE2ckt3TDVtWEdzb2FC?=
 =?utf-8?B?UkdnVSs5cldFODgvSFpneGw2UktVaUxodG8rMnl2S0EwenRyT0xYeXRNTUl5?=
 =?utf-8?B?OHJEKyt2bU8yUmxMdVZ1d2lIYTgyUXRPOThHc2lvTDlxRkN0OGRTNENWZXNm?=
 =?utf-8?B?cE5aYlJKY0VnZWFjb2FsL3B3d1BjSkxFcUg4OXpxalVWYVI0dkltVkQ3aDJm?=
 =?utf-8?B?R2lvbmtZSWVBQy93T29tOWRaWXQzcUhLUWRHWHNMaE9XVmFDZGRjdHNPNkdB?=
 =?utf-8?B?WjgzcW9PL0xhcjAwSktLSHM1YmppSXZBVWFVZGN1R1VHWi83d0xOTEJXdGFk?=
 =?utf-8?B?NDFGUkpRTTg0Ymg1OVFFUE56MXRZaDRueCtqb3hMVWJuQzY0c1lIbU9lQXJF?=
 =?utf-8?B?SU9UL3kxNUlOa2x0YXBaWncyOFRDRjVKT3M0a0lVZ3V2VjhONWMwS3BCWnpT?=
 =?utf-8?B?UzR4RjdtZmkvdkZydkNMSG10Zm5ObHY5UE93VkM5OGRnbFlzVEUycm9kbXdz?=
 =?utf-8?B?TVMrZEZJZURCTkUxdUdQWVByckU5MU1pdXp3Y2dPd0JnbTJjSFRyL0hsR2pS?=
 =?utf-8?B?ZkJzdFZBOFZWZFFnMGJSUVZmalkvaVcyYVI2R1dYeEo1QW41TnFEdEpMZ2th?=
 =?utf-8?B?UnJuTGpQM2JOR2xUVC8wcEdpK2pYdmNtSDBxanF4UkJLU1ZCWFBEN2JFNDc2?=
 =?utf-8?B?aXJjK1VVR3hsdEgvbHNLSit6SzNjZlRPekxDbG5GWllxMzlFdTRxaGlqN1M0?=
 =?utf-8?B?eUI1MGU5TkVRbXlmd2ZIT1RvUDU3Q3pQSVpvN3dJSUE5UDVFYVhSSTRXbktr?=
 =?utf-8?B?TEYyTGI2eTdQeGl5QnlVOHFzR2JHV2ZSZzhGVXBEclU5SGIwL0JaNkdIcXpU?=
 =?utf-8?B?RTR0Ym9XcDlpVEVtZXB6SHJkaEQ1NEIzMlFodDFPbnZ5NCtPWVBoSzhxNkpq?=
 =?utf-8?B?WlNVd2o2VmFVejdxMWliMmFOcDI1OFkwemxYTDZGNjg4NWZmRjU3N0duY1hK?=
 =?utf-8?B?TnNnYkRqMStJQVFqMVd3d3AxLzNsa2p3OE5YZXNCeU9OMFBFcXVNREtLYkYz?=
 =?utf-8?B?NVg4N3hzUW14OW54WTNrNUNodmF0eG5IMSt0RXZDQ1VQR3BLMVA1T3NXNW9H?=
 =?utf-8?B?TkIwOUtBaXhZUWVma3E3WDhtaGlYMHBKZEF5RnRUUjFORjhQTjNPczBycUIy?=
 =?utf-8?B?dVlsbldtdEhRcGhTZTdHWWptZzc1NHVJZkUwMjJHRzJaa0RSY3lJQnVYeFJO?=
 =?utf-8?B?NTUyR25yRnZBSk5mUEdoaldkVXE3bTJTdFNuYmxsb2tBY1M0WXJ1NTI4N25L?=
 =?utf-8?B?S2sxUWxkTWJsMldUMU9kWUtkTEpPSXhuUWV5RFFEcVFtTStkL21XWDR2NFlZ?=
 =?utf-8?Q?pJjqltOXEj8wTBZtVFUoC9Xg/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a99WIXTRmzkXzundSElFwec8iBBgtki0UlMn55UoR+4cnCTX0IqKb1C+3oZSXXS3ys62XtzrCt4WB/rmZ4psiEvK6czF1AYfSeurM+qNSobhmeIa0uAD6fq9eRVrLRkWrgYBp82lcbfBmsZac1RgZ9fHzlhcIEdukeNqcSUrRJieeIRZeLhRDP/94KB1qOAJo2hXkkXyEZFgfBgRVyLUuOmV6jcaXBrsVYp049wYDuXX0xDDcSIhXhVylUelwkrZCbDHgaqtwCXUNZEv7A1qBy79VEtoH3INCuyXCAWKn97WfwjL5IOX3ur4pwS9Gm2yjrmMbIyXjjmDH55JvPUbgr9Icl2C0EwMhS2LBx78SRfiXh34BUqQeSVy9e31TezAuzpF+gQH0HpHTnmE1uKQT6rFi4wnXSVau038w84JYQMWAvAbY/3dVcwvdb3bKmclOe2HVDS/LfwS/TS8CbboKSV/rWKTeOiFI2C2mK6pNzFfo2QI8G8lAJOw8V5acWtPt65+CgGGrzwBG9yEp/epOUnsyAfPGxKgjwBCSoLUcqdWhTcYJqHlVG9H761a3B5ks7qb3+ZPMvH7f9DYXE/hHNMoEtJoUdp1YM/sowRAsZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5bbdac-ec91-4c14-edea-08dc6a2b408f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 22:08:38.1375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HAQJ7vFPAcoNZW8BHu0xHugLmiSrSE/X03L/tV0iGXcXazfmhSTehv7ZIh9GMFX8Am2/eBsT2sGj5t+TIW5Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010157
X-Proofpoint-ORIG-GUID: ujCSg9aboMuW2c2TBOmwt4BDDVctGLqG
X-Proofpoint-GUID: ujCSg9aboMuW2c2TBOmwt4BDDVctGLqG
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



On 4/30/2024 11:11 AM, Eugenio Perez Martin wrote:
> On Mon, Apr 29, 2024 at 1:19 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>> On 4/29/24 4:14 AM, Eugenio Perez Martin wrote:
>>> On Thu, Apr 25, 2024 at 7:44 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>>
>>>> On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
>>>>> On Wed, Apr 24, 2024 at 12:21 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>
>>>>>> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
>>>>>>> On Sat, Apr 20, 2024 at 1:50 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
>>>>>>>>> On Thu, Apr 18, 2024 at 10:46 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>>>> On 4/10/2024 3:03 AM, Eugenio Pérez wrote:
>>>>>>>>>>> IOVA tree is also used to track the mappings of virtio-net shadow
>>>>>>>>>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
>>>>>>>>>>>
>>>>>>>>>>> This causes a problem when overlapped regions (different GPA but same
>>>>>>>>>>> translated HVA) exists in the tree, as looking them by HVA will return
>>>>>>>>>>> them twice.  To solve this, create an id member so we can assign unique
>>>>>>>>>>> identifiers (GPA) to the maps.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>>>>>>>>>> ---
>>>>>>>>>>>        include/qemu/iova-tree.h | 5 +++--
>>>>>>>>>>>        util/iova-tree.c         | 3 ++-
>>>>>>>>>>>        2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
>>>>>>>>>>> index 2a10a7052e..34ee230e7d 100644
>>>>>>>>>>> --- a/include/qemu/iova-tree.h
>>>>>>>>>>> +++ b/include/qemu/iova-tree.h
>>>>>>>>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
>>>>>>>>>>>            hwaddr iova;
>>>>>>>>>>>            hwaddr translated_addr;
>>>>>>>>>>>            hwaddr size;                /* Inclusive */
>>>>>>>>>>> +    uint64_t id;
>>>>>>>>>>>            IOMMUAccessFlags perm;
>>>>>>>>>>>        } QEMU_PACKED DMAMap;
>>>>>>>>>>>        typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>>>>>>>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
>>>>>>>>>>>         * @map: the mapping to search
>>>>>>>>>>>         *
>>>>>>>>>>>         * Search for a mapping in the iova tree that translated_addr overlaps with the
>>>>>>>>>>> - * mapping range specified.  Only the first found mapping will be
>>>>>>>>>>> - * returned.
>>>>>>>>>>> + * mapping range specified and map->id is equal.  Only the first found
>>>>>>>>>>> + * mapping will be returned.
>>>>>>>>>>>         *
>>>>>>>>>>>         * Return: DMAMap pointer if found, or NULL if not found.  Note that
>>>>>>>>>>>         * the returned DMAMap pointer is maintained internally.  User should
>>>>>>>>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
>>>>>>>>>>> index 536789797e..0863e0a3b8 100644
>>>>>>>>>>> --- a/util/iova-tree.c
>>>>>>>>>>> +++ b/util/iova-tree.c
>>>>>>>>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
>>>>>>>>>>>
>>>>>>>>>>>            needle = args->needle;
>>>>>>>>>>>            if (map->translated_addr + map->size < needle->translated_addr ||
>>>>>>>>>>> -        needle->translated_addr + needle->size < map->translated_addr) {
>>>>>>>>>>> +        needle->translated_addr + needle->size < map->translated_addr ||
>>>>>>>>>>> +        needle->id != map->id) {
>>>>>>>>>> It looks this iterator can also be invoked by SVQ from
>>>>>>>>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
>>>>>>>>>> space will be searched on without passing in the ID (GPA), and exact
>>>>>>>>>> match for the same GPA range is not actually needed unlike the mapping
>>>>>>>>>> removal case. Could we create an API variant, for the SVQ lookup case
>>>>>>>>>> specifically? Or alternatively, add a special flag, say skip_id_match to
>>>>>>>>>> DMAMap, and the id match check may look like below:
>>>>>>>>>>
>>>>>>>>>> (!needle->skip_id_match && needle->id != map->id)
>>>>>>>>>>
>>>>>>>>>> I think vhost_svq_translate_addr() could just call the API variant or
>>>>>>>>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova().
>>>>>>>>>>
>>>>>>>>> I think you're totally right. But I'd really like to not complicate
>>>>>>>>> the API of the iova_tree more.
>>>>>>>>>
>>>>>>>>> I think we can look for the hwaddr using memory_region_from_host and
>>>>>>>>> then get the hwaddr. It is another lookup though...
>>>>>>>> Yeah, that will be another means of doing translation without having to
>>>>>>>> complicate the API around iova_tree. I wonder how the lookup through
>>>>>>>> memory_region_from_host() may perform compared to the iova tree one, the
>>>>>>>> former looks to be an O(N) linear search on a linked list while the
>>>>>>>> latter would be roughly O(log N) on an AVL tree?
>>>>>>> Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
>>>>>>> linear too. It is not even ordered.
>>>>>> Oh Sorry, I misread the code and I should look for g_tree_foreach ()
>>>>>> instead of g_tree_search_node(). So the former is indeed linear
>>>>>> iteration, but it looks to be ordered?
>>>>>>
>>>>>> https://urldefense.com/v3/__https://github.com/GNOME/glib/blob/main/glib/gtree.c*L1115__;Iw!!ACWV5N9M2RV99hQ!Ng2rLfRd9tLyNTNocW50Mf5AcxSt0uF0wOdv120djff-z_iAdbujYK-jMi5UC1DZLxb1yLUv2vV0j3wJo8o$
>>>>> The GPA / IOVA are ordered but we're looking by QEMU's vaddr.
>>>>>
>>>>> If we have these translations:
>>>>> [0x1000, 0x2000] -> [0x10000, 0x11000]
>>>>> [0x2000, 0x3000] -> [0x6000, 0x7000]
>>>>>
>>>>> We will see them in this order, so we cannot stop the search at the first node.
>>>> Yeah, reverse lookup is unordered indeed, anyway.
>>>>
>>>>>>> But apart from this detail you're right, I have the same concerns with
>>>>>>> this solution too. If we see a hard performance regression we could go
>>>>>>> to more complicated solutions, like maintaining a reverse IOVATree in
>>>>>>> vhost-iova-tree too. First RFCs of SVQ did that actually.
>>>>>> Agreed, yeap we can use memory_region_from_host for now.  Any reason why
>>>>>> reverse IOVATree was dropped, lack of users? But now we have one!
>>>>>>
>>>>> No, it is just simplicity. We already have an user in the hot patch in
>>>>> the master branch, vhost_svq_vring_write_descs. But I never profiled
>>>>> enough to find if it is a bottleneck or not to be honest.
>>>> Right, without vIOMMU or a lot of virtqueues / mappings, it's hard to
>>>> profile and see the difference.
>>>>> I'll send the new series by today, thank you for finding these issues!
>>>> Thanks! In case you don't have bandwidth to add back reverse IOVA tree,
>>>> Jonah (cc'ed) may have interest in looking into it.
>>>>
>>> Actually, yes. I've tried to solve it using:
>>> memory_region_get_ram_ptr -> It's hard to get this pointer to work
>>> without messing a lot with IOVATree.
>>> memory_region_find -> I'm totally unable to make it return sections
>>> that make sense
>>> flatview_for_each_range -> It does not return the same
>>> MemoryRegionsection as the listener, not sure why.
>>>
>>> The only advance I have is that memory_region_from_host is able to
>>> tell if the vaddr is from the guest or not.
>>>
>>> So I'm convinced there must be a way to do it with the memory
>>> subsystem, but I think the best way to do it ATM is to store a
>>> parallel tree with GPA-> SVQ IOVA translations. At removal time, if we
>>> find the entry in this new tree, we can directly remove it by GPA. If
>>> not, assume it is a host-only address like SVQ vrings, and remove by
>>> iterating on vaddr as we do now. It is guaranteed the guest does not
>>> translate to that vaddr and that that vaddr is unique in the tree
>>> anyway.
>>>
>>> Does it sound reasonable? Jonah, would you be interested in moving this forward?
>>>
>>> Thanks!
>>>
>> Sure, I'd be more than happy to work on this stuff! I can probably get
>> started on this either today or tomorrow.
>>
>> Si-Wei mentioned something about these "reverse IOVATree" patches that
>> were dropped;
> The patches implementing the reverse IOVA tree were never created /
> posted, just in case you try to look for them.
>
>
>> is this relevant to what you're asking here? Is it
>> something I should base my work off of?
>>
> So these patches work ok for adding and removing maps. We assign ids,
> which is the gpa of the memory region that the listener receives. The
> bad news is that SVQ also needs this id to look for the right
> translation at vhost_svq_translate_addr, so this series is not
> complete.
I have a fundamental question to ask here. Are we sure SVQ really needs 
this id (GPA) to identify the right translation? Or we're just 
concerning much about the aliased map where there could be one single 
HVA mapped to multiple IOVAs / GPAs, which (the overlapped) is almost 
transient mapping that usually goes away very soon after guest memory 
layout is stabilized? For what I can tell, the caller in SVQ datapath 
code (vhost_svq_vring_write_descs) just calls into 
vhost_iova_tree_find_iova to look for IOVA translation rather than 
identify a specific section on the memory region, the latter of which 
would need the id (GPA) to perform an exact match. The removal case 
would definitely need perfect match on GPA with the additional id, but I 
don't find it necessary for the vhost_svq_vring_write_descs code to pass 
in the id / GPA? Do I miss something?

Thanks,
-Siwei

> You can find the
> vhost_iova_tree_find_iova()->iova_tree_find_iova() call there.
>
> The easiest solution is the reverse IOVA tree of HVA -> SVQ IOVA. It
> is also the less elegant and (potentially) the less performant, as it
> includes duplicating information that QEMU already has, and a
> potentially linear search.
>
> David Hildenbrand (CCed) proposed to try iterating through RAMBlocks.
> I guess qemu_ram_block_from_host() could return a block where
> block->offset is the id of the map?
>
> It would be great to try this approach. If you don't have the bandwith
> for this, going directly for the reverse iova tree is also a valid
> solution.
>
> Thanks!
>
>> If there's any other relevant information about this issue that you
>> think I should know, let me know. I'll start digging into this ASAP and
>> will reach out if I need any guidance. :)
>>
>> Jonah
>>
>>>> -Siwei
>>>>
>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>> Thanks!
>>>>>>>
>>>>>>>> Of course,
>>>>>>>> memory_region_from_host() won't search out of the guest memory space for
>>>>>>>> sure. As this could be on the hot data path I have a little bit
>>>>>>>> hesitance over the potential cost or performance regression this change
>>>>>>>> could bring in, but maybe I'm overthinking it too much...
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> -Siwei
>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> -Siwei
>>>>>>>>>>>                return false;
>>>>>>>>>>>            }
>>>>>>>>>>>



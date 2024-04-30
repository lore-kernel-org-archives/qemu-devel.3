Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18264C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 05:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1gSS-0000P4-Bo; Tue, 30 Apr 2024 01:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s1gSQ-0000Om-NC
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:55:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1s1gSL-0003hX-BY
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:55:14 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43U1ho5x016643; Tue, 30 Apr 2024 05:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=yjhwkxO6Py6Ld9J2JRTLsHAvlwWsM2x5aTzfDoyXOPc=;
 b=IKuQvb0DL8wDV600CypaZUE0DNEM3vBf+WFJaAkO3SrBM7sD6bzC7oe1zX51hiKoUS/8
 X7a/hxibAgn7KcYuEJ6tTGqvKVZUYz9LRUJeKxHz2VDYunhV8EfvTedcfx2XARyFvjMO
 Cd+EaztD/2K55wiSBu0IeK8XXGNqn3Ug2mSBWDElaCj1QB1aSBtZGbsIf7KyCpKSOVwC
 PRjCgbujKhH0dPyJjtjeVsHqCrabf+KR1P4V3mOq8BejytkrPU5nxODcW8hGWG3IXxyP
 Ur0u12b+fMdSa2asCqXuGjnd7mFe7ajpwOmYevHEKvA1/JociYgbvTEZl0b8SESyixcW +A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdem5by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2024 05:55:05 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43U4so2M011412; Tue, 30 Apr 2024 05:55:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt7dyn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Apr 2024 05:55:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVOr+8athoTH4505LdZ92n4dc6t9Tn9o4DqogH7vRqmmel6OhR5yXiEc6NvYpNoZX3i4eYmBlZxpuIuVo29Ta53YHLfB0an2sCi9BhOeGmYUifu2S09gtbYRl3+g7oG+7seG8rPyW3emkIXWn5rGmMuPIDpw9rlWMADqZ95dNs1rVdH8wVaDuFfrCqIW6aX3M7omHPolzQHDSs9yNi3MdsK7s6eXXNmLMVqKkhW46VXaL7idF6tqEi8jFlOFdWCku3Vpn9woekqjzLt8vTqqsh5+o80ZXKUdX+BR+3xH6rwtrqAAiarIb349zpdxCEps2baw1pbZGRL4+MhhRx5mKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjhwkxO6Py6Ld9J2JRTLsHAvlwWsM2x5aTzfDoyXOPc=;
 b=NsBT+sB+9EkLmiJoqxMVcyavPjyvCHOLT1vSwJibTDORjF/6uqKci15e2DPud5roaV3PXMQFEiyrjXo7gwBzOB/QNP+PtzF3EEfs7KhE0M2tXQL8LLlYh3zaNeDpX3QRuv6hg+ktjSOCAkhsl5eS9Dr+4LpSGNFJhLFPyVxypY89ux8GYxfupy4pwqOdaRPky9VobMFn1eE7aJCyzTX0okUeLDiJQOveQKd38QihdeA5q3LwqRgDHOdnJsWoYYGLKVII3hTWSJHMLHVwL6Cx0H++1kHqqqpUKcqMBkHM0TP8RVYtHD/pZIyPrRlw8qNjfCiDKNj0MtMn+0fNWip8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjhwkxO6Py6Ld9J2JRTLsHAvlwWsM2x5aTzfDoyXOPc=;
 b=ijv9d1P4d2Z4wWcPJUeNt75tJIapMFkURROFVFKFlYn9+8ktZuuNk2yvJlDDqqRlsJPSXq4pDNVTJDJAnO/hdANK0tMIXhcOH4Xq0s/MdrfgVdsh8X12aq783ziG9DR28sg3jszdFrr4g+xqKOupOaa+RMhlmiuaycBYKhcMh2o=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB4938.namprd10.prod.outlook.com (2603:10b6:610:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 05:55:02 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 05:55:02 +0000
Message-ID: <f6c63253-57bf-4e7a-8178-667a577784d5@oracle.com>
Date: Mon, 29 Apr 2024 22:54:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
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
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWeyfPp5bh9iZrkwZshoStEHZ85P6t4TcEdmR5sDYhG4ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:2d::33) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: be66c0a9-df30-4495-b0b9-08dc68da13b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE9BSkxqL1BQY0E4bHZucnJ4Sm83cHNOb2ZWLzI4SXJaVFFma1BzZW9Odmdi?=
 =?utf-8?B?a05Wb2FheTZxY3doY1NNRFBEZG41b2JpU0dxN0gzS3VZWHN6TlV6KzNqRFdE?=
 =?utf-8?B?SlhjZjhadm9qbTFpb1kwT3pwTTBQRnkzZWErWE5BZ3RyMUxTM1hTNXJ5WjZw?=
 =?utf-8?B?ZElIL05nTG9YaWxJcVBTTmJGWVBqUlRTOFNEQjlCRWJYc1BOMmtpNkJxcERW?=
 =?utf-8?B?QlFEbVk5eEtRRi9icjdXMnJkb0J2MWhVRSsxQ0tqTjV4QmhpTlhzbHAzMEdD?=
 =?utf-8?B?MFlUZlFNTXZHei9jVityUTV0U0F2TGpCUTdmencreTdVZ0UyMEVoeWdnR09W?=
 =?utf-8?B?dGxpZ0tVS1lQdVdTV01uUUsrL0Z1WkM2QSt3Tm9zUEF2RWFwN1VFNUw0TEdT?=
 =?utf-8?B?UXVZS280aDZZdVUvNE1naTFuTjV0dXBySGNva0h5bmpaT2d5Z3RXakE0cmxJ?=
 =?utf-8?B?Sksvb1pVYmN2MXNqQ0VDM2dpNGRRcExaczNMVWJ3a1FlWlpkMzk4VmYySnBY?=
 =?utf-8?B?cHFydFhUOHJDaWExMCtJbFBZS042MDNvek1TVU5zNlc1WEVJQVNwbVpuS3Za?=
 =?utf-8?B?ZHNvbk1kM2QzOGpWSlNkNzlDbTl4eTN6K1N0akRSRkd4OXFLK0I2amRJdGgv?=
 =?utf-8?B?S3NmMUhyb3Ayai9ScTN4NVJLVjNkTVUwcXZWTlFjekxJSTZ4empSeFFqbm5X?=
 =?utf-8?B?R3pid2xuMng5TFByK0Nnc2hkTmRMaTNmd21TT1hGRnJGNnRGMGM4dVc2dkNq?=
 =?utf-8?B?L1o5U2piNWFMMFBIWmp3VUovSmJ4M2tUWFRicHpCakVmUjNLN0xPODRtcno1?=
 =?utf-8?B?T1JiMTN3Qjg2Vm5WL2ZCZ203cUtnL3BCUWt0RzU0SnNkbSthcE1HR3JqQ2xx?=
 =?utf-8?B?eEp4djhmLzV0aWpoaEtMSm9YdnlRYXorUWJMTXY3Q0k5VHd2ZTlUV1RZMVpI?=
 =?utf-8?B?YlMzckNtL0ZsR01YVW1mNmxqZ3NERll5a1R6TXBQeTAxTDJsZ2FHZU9CbDVl?=
 =?utf-8?B?S2VTY01OZmNtdnFTTVpYaEFrZzFiZTd2V2s0ano1RlQzaWNXS1oxek9pTERO?=
 =?utf-8?B?Mnh4YzBDUzJxRWJjZk1PaDBzMUZUUlhRRkRNQ2FtQ3lIM0ppVU50dnVyZUpj?=
 =?utf-8?B?WXFRTUFhS05KaHVEMCtZVU5rR3JwTitFOHJxbXU5ZXBxRG8vSEk2UlZJdVJF?=
 =?utf-8?B?bnpOeERwZHk5OTNzRjAwQUJkVVd6ZTJUNjN0akpCNG53c3lPazh1S2hzVmRu?=
 =?utf-8?B?a1FYWUtBYy9ENkxzZEt3SGtOK3o4QVpHbjZZcVB5Wkp2L3JXaVhhQnFoMURy?=
 =?utf-8?B?V0ZCSEtRZDh0MnpSTDFBV1NCVi9QbU5UNmRtVVoxRUVLYnhSZG1yQUZxdTNv?=
 =?utf-8?B?bTEvbjNnVDJEOG1oamhpMFVsVU1PbFVzRklUOFU1QkNJTngxVXFwaEZWZ2I3?=
 =?utf-8?B?ZUdtRklIb3FxT0xyOHNUblozTVpyN29KZWZudUpjY0diRklLdkZLR3JRcjFu?=
 =?utf-8?B?K2hGbmVGZGdEczZnUzZTSjlvakFsRUxaYWoxYVlnNHpNYkJodC92MUVMZTlC?=
 =?utf-8?B?RVE5VTRtWlJVeXArZlF1VW1nNXRpWCtjYjR5N3dTWi9xZTRyZW0vbGtxV1cr?=
 =?utf-8?Q?EFao47JgkA77dCQOdBXKCWjowcFrRGxUT3qYK0CGu35k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXIrYWdBalNUWk5ZMmZQVytOZ01jemVIWkVDeTF1dEJRaHM0TlVDRUN2bTZX?=
 =?utf-8?B?RCszSGtOWmh3c0lEUVBkd0ZLZXFWSW5iUlZ0ZHhNZFhraHprWU1OTUpJTllY?=
 =?utf-8?B?TjdRdWtCYWtSTXE4VmZQOXlNODJFaGQzZmJycDJZN1hKVGNCc1B5cHQzWG5X?=
 =?utf-8?B?aEFUeE1mQ0w4YzhWRnZ2NHRYQnJCYnFEcU5iVCtDUTNIMEhZd1JHcUJkUERG?=
 =?utf-8?B?QUVqOFBBOHp4VEVidUJQbVFib2t3ajNIMmF2anowNFBjS0p5cnBIMjlhSU9V?=
 =?utf-8?B?VkJsR2xMOUhtKy9JRXYyV0lzQmdoU2NraWF5VWFmTGtJSXRoejRzZXlaN2Z4?=
 =?utf-8?B?MG9WSE56eGlUTkY2dU4xOGVrOFNYdmk4K1o4U2RuR09sTXdzaGpOVDVwOWIw?=
 =?utf-8?B?bS95aW1YNUw3aWlhdUsxQnJYcDdia21lVWQwNG5wVitZNVBmbktsdWwzZVBM?=
 =?utf-8?B?eGpyZ1paNEM0Y0kxNDBWS3RVOU9GV0R2aWZYbERPcjRZQWJDWm45WUYxdUZZ?=
 =?utf-8?B?OHB0cGpQakxoKy9HRXFaL2JMQUZFSXY1MGJCZkJMZ25ubDBKWVhabWF3K0N4?=
 =?utf-8?B?cldLZHZlY1QrK1hpeStScjBJOFJoY3I4T2JGOGdHbStBeWtUZHROZFZSZm11?=
 =?utf-8?B?clVZYmxOZ0EwZUpodWhEVmltSXhoYzlHR24yRjVwYXQwQWs3NXpUSHFxUTZ3?=
 =?utf-8?B?bCtTM0ZYOG02WW1vNWUwU3FDZlZZWk52R29CL2h1SjR6VWxSenVhSGl0eDVp?=
 =?utf-8?B?S2x3cHVGa0kzVlVvQ3pPM0FNNkpVZTdrRDFsMWMxdy9RZkV3YmpNMThGZWZa?=
 =?utf-8?B?c05ZYUZZdFJLem13R0tyTXIyaTlvSFdLaFVpYTI4L1craVBnaFVYWGJDZlpK?=
 =?utf-8?B?Q3cwdFRpN0srK1BZcG9UVkRCQXN0OWJjRzYycTJMdjlqMkJCRUhPNHNDS1ho?=
 =?utf-8?B?YTdiUDhZbVhsTDhlcDh0YTdMQ1BHNFR6Zkd1RlJHOGF3azhpVDVzY3dpbFJy?=
 =?utf-8?B?T3pJOW50WWJQVnVLS2pDNkhvK0ZoejR3MWtRcmdnRk5jM0ZKWDJZaTNJaCtu?=
 =?utf-8?B?QWVoRmRyakJ5ZWFTeDQ5WjUrWFhJVmtFL3AyeUlrL2tENEttdTdpaUxwcGJr?=
 =?utf-8?B?YjBCdW5BNmZpTzlRaDRoZkxYZDZZMm1uWXZFZ1lwOGtUR2lZZWRvamhaK2E4?=
 =?utf-8?B?MUl5dUFTS2xkdHZvQTNEeGgyTmVnZTRRWVZkSU9tNHVzVVFMNGt1eDNManor?=
 =?utf-8?B?eldkRzhGS1VJNU5BdmEwNmpYR0FwRTZJbE9EeE01WjY4YjAzZC83T3BQeHNR?=
 =?utf-8?B?YzRWNGkybTloWW5NMUZJYldydHUvdytVenZkQjdBT1FUQitMM3Bmb2hKUVpW?=
 =?utf-8?B?eGExbjdPRkRvek90RmlwQXlVdE8wRTRvSnRTdkw4cFhuOFEyK0F0VGJKdExq?=
 =?utf-8?B?c2lpT3p0aC9wN04xeE1WU0svMFhVckFzR1M5NVJldXR2SUVZY3NDZkhDNVA0?=
 =?utf-8?B?MlI1MHhlMittaVgrTmVmYVdOOWp3aHlZQi9mTjk1Ri9obkN2Y3Njd2dzMGNU?=
 =?utf-8?B?Q1J1TFU2VmxvQ3phaDNNUW9NdzdURmY4OGhYV1dBM1BzbTlOTlYzOWtnMkI3?=
 =?utf-8?B?WTMrdXhrTVFhbXN2akp5TWVtTXY0eFZXRStyRm1HNG5rZ2IrdndoNW0zL1lE?=
 =?utf-8?B?bElCTkQ2L3RaTTRZOERGYkNxMGFHK0lXVjdXM2xid01Dd0pnUkQ1UHlKUGpT?=
 =?utf-8?B?MFZ3WWM2Y3dXalU0eTcxS0x1U0g2V0d0KzRVY1JTK09GQ2kyVVZubkZTQ09D?=
 =?utf-8?B?cjlLVXhMNDJCUnYyeXNRQ1Y1WW5qSElZQXdQbkJzRVRBdWdNK01iNHVQZHhF?=
 =?utf-8?B?OUdoUHAwcW04ZmJudk1uRlpQcXhhRXRPWU5abmo5NGpLQitSa2IyU1owUDlB?=
 =?utf-8?B?ZDIvN2grYlN3a0grWHhZdlVrbGpuRVA2WWR1aHFIS3RPTHZQOGVHblZSbisv?=
 =?utf-8?B?YmkvOUtXY3o0TExIeHpacTZDaXR2blRyeGhFdFU5M1kvWWFmeEU3U05KMGQx?=
 =?utf-8?B?RTBoN0grNnp6WWJiVjN6b05sQ2NOZnhyYm0rMTF4aGFyK1kweTIvVWQwYm1I?=
 =?utf-8?Q?vBCIAlBmkGpi7lEGXIR4QnHTU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FANv/HqKINs558oXCMgU5+ZCGNa0Oiu+NVMJeCwbvIM5+OfsX4mGN9vyRy2M2LllCpmdWyhvTbfW+9mn6fHM1nldkVU27cZ5o5U3yDt88x1V60t5FwcPvJOwvh9a61HqOvvDmEBaco5GvT+UeNgsWTYrpK0RhJbGd62ARPDRCO83BCt0zWaGfuCdjrpIDUeSRn7lqg8xOP7nzbstG4sEiFiacLNiQs/qHYpH+MKEAtoudYIHCJty6KVn7ddE32aPr4o/DIpupipldSHannCVrk89JsOB/Kou5+Nximtz2Ynt23prIFZnRWXUwm1EReFiilRu44xSLBhorUYB3aa98uihF5jQamz9sj0ffdr+BSvxgb/YMheLyrUEFIy3QvcEShe4blCuFmm/6b0Is//6yrdgM7jrjl5WOslJ12t+GHwQXnWFHNEeQoq0fcmAcJpmVeqOr82qsruoUgrier5boLsa3/CScAluZ9M9xRQsA8l6+h07Rs7Tk0qY0eYb/nfpF1pUXhGNtnKAniuQxwT6ugSyI0MdD1yiIFMKVaLn8jXGWPjBVwS/9lntJZc7BYB7dIRRi5/x1BKOvKkqjMs6EuKu7sCi4NJdTrj0luiL+Mk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be66c0a9-df30-4495-b0b9-08dc68da13b9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 05:55:02.4691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQ7jKvw/Jc5TToIoxWDvwOS54EZV25MHm9UUoAgMZf6+2aT68B2PtJMi0DxTBfT2tfQnkMvxYDtTM+7tsXrlEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4938
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_02,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300041
X-Proofpoint-GUID: y89jS2JfvhRkME3fJP1PY4mh94kunVb8
X-Proofpoint-ORIG-GUID: y89jS2JfvhRkME3fJP1PY4mh94kunVb8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/29/2024 1:14 AM, Eugenio Perez Martin wrote:
> On Thu, Apr 25, 2024 at 7:44 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
>>> On Wed, Apr 24, 2024 at 12:21 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
>>>>> On Sat, Apr 20, 2024 at 1:50 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
>>>>>>> On Thu, Apr 18, 2024 at 10:46 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>>>> On 4/10/2024 3:03 AM, Eugenio Pérez wrote:
>>>>>>>>> IOVA tree is also used to track the mappings of virtio-net shadow
>>>>>>>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
>>>>>>>>>
>>>>>>>>> This causes a problem when overlapped regions (different GPA but same
>>>>>>>>> translated HVA) exists in the tree, as looking them by HVA will return
>>>>>>>>> them twice.  To solve this, create an id member so we can assign unique
>>>>>>>>> identifiers (GPA) to the maps.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>>>>>>>> ---
>>>>>>>>>       include/qemu/iova-tree.h | 5 +++--
>>>>>>>>>       util/iova-tree.c         | 3 ++-
>>>>>>>>>       2 files changed, 5 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
>>>>>>>>> index 2a10a7052e..34ee230e7d 100644
>>>>>>>>> --- a/include/qemu/iova-tree.h
>>>>>>>>> +++ b/include/qemu/iova-tree.h
>>>>>>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
>>>>>>>>>           hwaddr iova;
>>>>>>>>>           hwaddr translated_addr;
>>>>>>>>>           hwaddr size;                /* Inclusive */
>>>>>>>>> +    uint64_t id;
>>>>>>>>>           IOMMUAccessFlags perm;
>>>>>>>>>       } QEMU_PACKED DMAMap;
>>>>>>>>>       typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>>>>>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
>>>>>>>>>        * @map: the mapping to search
>>>>>>>>>        *
>>>>>>>>>        * Search for a mapping in the iova tree that translated_addr overlaps with the
>>>>>>>>> - * mapping range specified.  Only the first found mapping will be
>>>>>>>>> - * returned.
>>>>>>>>> + * mapping range specified and map->id is equal.  Only the first found
>>>>>>>>> + * mapping will be returned.
>>>>>>>>>        *
>>>>>>>>>        * Return: DMAMap pointer if found, or NULL if not found.  Note that
>>>>>>>>>        * the returned DMAMap pointer is maintained internally.  User should
>>>>>>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
>>>>>>>>> index 536789797e..0863e0a3b8 100644
>>>>>>>>> --- a/util/iova-tree.c
>>>>>>>>> +++ b/util/iova-tree.c
>>>>>>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
>>>>>>>>>
>>>>>>>>>           needle = args->needle;
>>>>>>>>>           if (map->translated_addr + map->size < needle->translated_addr ||
>>>>>>>>> -        needle->translated_addr + needle->size < map->translated_addr) {
>>>>>>>>> +        needle->translated_addr + needle->size < map->translated_addr ||
>>>>>>>>> +        needle->id != map->id) {
>>>>>>>> It looks this iterator can also be invoked by SVQ from
>>>>>>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA
>>>>>>>> space will be searched on without passing in the ID (GPA), and exact
>>>>>>>> match for the same GPA range is not actually needed unlike the mapping
>>>>>>>> removal case. Could we create an API variant, for the SVQ lookup case
>>>>>>>> specifically? Or alternatively, add a special flag, say skip_id_match to
>>>>>>>> DMAMap, and the id match check may look like below:
>>>>>>>>
>>>>>>>> (!needle->skip_id_match && needle->id != map->id)
>>>>>>>>
>>>>>>>> I think vhost_svq_translate_addr() could just call the API variant or
>>>>>>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova().
>>>>>>>>
>>>>>>> I think you're totally right. But I'd really like to not complicate
>>>>>>> the API of the iova_tree more.
>>>>>>>
>>>>>>> I think we can look for the hwaddr using memory_region_from_host and
>>>>>>> then get the hwaddr. It is another lookup though...
>>>>>> Yeah, that will be another means of doing translation without having to
>>>>>> complicate the API around iova_tree. I wonder how the lookup through
>>>>>> memory_region_from_host() may perform compared to the iova tree one, the
>>>>>> former looks to be an O(N) linear search on a linked list while the
>>>>>> latter would be roughly O(log N) on an AVL tree?
>>>>> Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
>>>>> linear too. It is not even ordered.
>>>> Oh Sorry, I misread the code and I should look for g_tree_foreach ()
>>>> instead of g_tree_search_node(). So the former is indeed linear
>>>> iteration, but it looks to be ordered?
>>>>
>>>> https://github.com/GNOME/glib/blob/main/glib/gtree.c#L1115
>>> The GPA / IOVA are ordered but we're looking by QEMU's vaddr.
>>>
>>> If we have these translations:
>>> [0x1000, 0x2000] -> [0x10000, 0x11000]
>>> [0x2000, 0x3000] -> [0x6000, 0x7000]
>>>
>>> We will see them in this order, so we cannot stop the search at the first node.
>> Yeah, reverse lookup is unordered indeed, anyway.
>>
>>>>> But apart from this detail you're right, I have the same concerns with
>>>>> this solution too. If we see a hard performance regression we could go
>>>>> to more complicated solutions, like maintaining a reverse IOVATree in
>>>>> vhost-iova-tree too. First RFCs of SVQ did that actually.
>>>> Agreed, yeap we can use memory_region_from_host for now.  Any reason why
>>>> reverse IOVATree was dropped, lack of users? But now we have one!
>>>>
>>> No, it is just simplicity. We already have an user in the hot patch in
>>> the master branch, vhost_svq_vring_write_descs. But I never profiled
>>> enough to find if it is a bottleneck or not to be honest.
>> Right, without vIOMMU or a lot of virtqueues / mappings, it's hard to
>> profile and see the difference.
>>> I'll send the new series by today, thank you for finding these issues!
>> Thanks! In case you don't have bandwidth to add back reverse IOVA tree,
>> Jonah (cc'ed) may have interest in looking into it.
>>
> Actually, yes. I've tried to solve it using:
> memory_region_get_ram_ptr -> It's hard to get this pointer to work
> without messing a lot with IOVATree.
> memory_region_find -> I'm totally unable to make it return sections
> that make sense
> flatview_for_each_range -> It does not return the same
> MemoryRegionsection as the listener, not sure why.
Ouch, thank you for the summary of attempts that were done earlier.
> The only advance I have is that memory_region_from_host is able to
> tell if the vaddr is from the guest or not.
Hmmm, then it won't be too useful without a direct means to identifying 
the exact memory region associated with the iova that is being mapped. 
And, this additional indirection seems introduce a tiny bit of more 
latency in the reverse lookup routine (should not be a scalability issue 
though if it's a linear search)?

> So I'm convinced there must be a way to do it with the memory
> subsystem, but I think the best way to do it ATM is to store a
> parallel tree with GPA-> SVQ IOVA translations. At removal time, if we
> find the entry in this new tree, we can directly remove it by GPA. If
> not, assume it is a host-only address like SVQ vrings, and remove by
> iterating on vaddr as we do now.
Yeah, this could work I think. On the other hand, given that we are now 
trying to improve it, I wonder if possible to come up with a fast 
version for the SVQ (host-only address) case without having to look up 
twice? SVQ callers should be able to tell apart from the guest case 
where GPA -> IOVA translation doesn't exist? Or just maintain a parallel 
tree with HVA -> IOVA translations for SVQ reverse lookup only? I feel 
SVQ mappings may be worth a separate fast lookup path - unlike guest 
mappings, the insertion, lookup and removal for SVQ mappings seem 
unavoidable during the migration downtime path.

>   It is guaranteed the guest does not
> translate to that vaddr and that that vaddr is unique in the tree
> anyway.
>
> Does it sound reasonable? Jonah, would you be interested in moving this forward?
My thought would be that the reverse IOVA tree stuff can be added as a 
follow-up optimization right after for extended scalability, but for now 
as the interim, we may still need some form of simple fix, so as to 
quickly unblock the other dependent work built on top of this one and 
the early pinning series [1]. With it said, I'm completely fine if 
performing the reverse lookup through linear tree walk e.g. 
g_tree_foreach(), that should suffice small VM configs with just a 
couple of queues and limited number of memory regions. Going forward, to 
address the scalability bottleneck, Jonah could just replace the 
corresponding API call with the one built on top of reverse IOVA tree (I 
presume the use of these iova tree APIs is kind of internal that only 
limits to SVQ and vhost-vdpa subsystems) once he gets there, and then 
eliminate the other API variants that will no longer be in use. What do 
you think about this idea / plan?

Thanks,
-Siwei

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.html

>
> Thanks!
>
>> -Siwei
>>
>>
>>>> Thanks,
>>>> -Siwei
>>>>> Thanks!
>>>>>
>>>>>> Of course,
>>>>>> memory_region_from_host() won't search out of the guest memory space for
>>>>>> sure. As this could be on the hot data path I have a little bit
>>>>>> hesitance over the potential cost or performance regression this change
>>>>>> could bring in, but maybe I'm overthinking it too much...
>>>>>>
>>>>>> Thanks,
>>>>>> -Siwei
>>>>>>
>>>>>>>> Thanks,
>>>>>>>> -Siwei
>>>>>>>>>               return false;
>>>>>>>>>           }
>>>>>>>>>



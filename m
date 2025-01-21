Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB436C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFd1-00026W-He; Tue, 21 Jan 2025 09:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1taFcz-00026F-M7
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:53:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1taFcw-000081-EH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:53:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LEfuuW031164;
 Tue, 21 Jan 2025 14:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=OLZSQ9BLJPATVb6qBuiO8DLK9jrxeVFhOOrzQ5S+mEk=; b=
 K+PKsE961d0wx9XDKeJMl0466g82x3uFdB3eb9AzBjECqn6aXE6L8w8iqTNRAvJE
 d0nZWqXv0f/jTqOiy1Mz4imkLcZ+xf+An3h83Px8rIa2d0zqcyivQql68gQ11yWl
 hBLCkkrrDUHbPGdt7opPtEHS8PckPJMRTTNnpjMstts5gPxZCPoewmWqtGrQQu4D
 w5w7mI7QqcBX77pF5QVK4xSVPNkeqVhGi5L6Dz2ZxXDpu/fEa34w8HtwjTSA+07f
 b5dy2LCRAzIHRHbeUckhL3yem4eaMCvvn28a3tVjL2Cl3JMXLrfJfEfXDg8+DmUN
 v7icWsAlnv6iyYMV+lytEg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nb5kfe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 14:53:06 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LEF6El005437; Tue, 21 Jan 2025 14:53:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 449194bnrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 14:53:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yb7mfhbBXGo/25l6E8m1YiZqDNZYCCHLiXjeKjHkzg2MaB6z6E3L7TF+ALxPqAc+zZRDG0ym9hEAqVasmjGrQARnFXxKj/FwKaglntlNIoI4SIG1BdSY2lePA0fv6cgDChU9R73co3xuJr2ifcNtwWMhZgl80siaPhM4cpGKRKlPta3qfpzeU3Z43+EmVIzxLI7UDoqcinyxH8NXgkkgUvFteWwYrTNJRSDFzK+jfchKmoXi6R2zZ1RnodZBVAXK13QxdRss5rgZV4NT8mKmjgotXni9E5IW4L4JKrtEN2z1yY2eCRulB5fKuqjadK6AV6Lx4+msHw7AkoAA0DP22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLZSQ9BLJPATVb6qBuiO8DLK9jrxeVFhOOrzQ5S+mEk=;
 b=zE/5XYblL+8bf0gY9mh3ap2FvFegyNOt9uXpoECIAZ2yZPb2WW8d1bupQoHCud9FWBVB9rvcrnajnPW6WO6kBWftNKZbK4rY8qTXueKKEca0IdiNTBehRufVON+Ub0KOzDRI3PhQUE7SO3nUpPnq2X60Sx/zm49xyFbM39ynZexn/Gkn2FC2Pa/0N3xQFh88Fd6htNfUvFlvgXe8gLF0dawqned62iMpw/MBTIasTobg4PMmDN0xmKmvBKZU1op5X4gek1/EXROw0tCavOTCI3Xhwjrm8CdCBWlD8N02vsujyQw2Gov7W6bvzH5zVBCy2BZqy9oqN9RfkyNQZlOYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLZSQ9BLJPATVb6qBuiO8DLK9jrxeVFhOOrzQ5S+mEk=;
 b=Fll4mXz3AvxzDXdzFpBXscUAGWuZfA0FbOBJWh4J3/iCXnxYBw5aEFGpZpuEq94D9B7jW/SiH0oKAqb1H78ul++MjGb669oKZs8fNOc16YRb1Ef9BkSt6IAGtJBc2hr3qjCgHsM7ykRsM1T6ld9qTLsSmWwZ+geS0NnQAwM4SE0=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by DS0PR10MB7521.namprd10.prod.outlook.com (2603:10b6:8:157::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Tue, 21 Jan
 2025 14:53:02 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 14:53:02 +0000
Message-ID: <74eee431-a6b5-4da3-8a5d-344a3401a288@oracle.com>
Date: Tue, 21 Jan 2025 09:52:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/5] vhost-vdpa: Decouple the IOVA allocator
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-2-jonah.palmer@oracle.com>
 <CAJaqyWc-ygnHZmb-aLBG9Hik3v9PbBsnFMdrxXTmGMxsMB+ZOA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWc-ygnHZmb-aLBG9Hik3v9PbBsnFMdrxXTmGMxsMB+ZOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::31) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|DS0PR10MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4efb3e-2043-4d18-76b8-08dd3a2b4de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Uit3T0c0Rm12N2c3bjdlR1BCZk1CRDNhdWZDY2MvaS9zNkx3a21BckYvSWlP?=
 =?utf-8?B?Sm4rcmpVSkZwWFNMQUFnVjJzWExNRUc4cFlSV0cvVVlJVzdWeksvaE83aEtW?=
 =?utf-8?B?a3ltT0hscmE1bGlsVGxZTE9NbklPVmtZSHp3ditrZlA0eVZVUDI1UTlOTUNx?=
 =?utf-8?B?TXkxN3VPTGxsaHdQV2NCbnRXTkt0VkNkYkRIa1dacVY2a1hVbGlUbnpRWkdE?=
 =?utf-8?B?enhwTTMzT1NZTHB1SEFYMkpjQUZ6dFFSK09mdEZJQUxXNGZkWkxPT2tFVzhW?=
 =?utf-8?B?VFhTdTBUak51SVpTbEhDR3c3MXlFRzRGN0ZXMkFpaThCbmNWZlI3c2VSLzJX?=
 =?utf-8?B?TzV0d2p3TjFwQ0phSlRwdGV0OUxrU3FuN2xvWmRLZ1JpelNJOGxod2RQejJE?=
 =?utf-8?B?dUVMcVlWNGE2cTN5THN2K2lzbk10ODVkcEQwSzIyd0tUYS9XY2doOGErL1VV?=
 =?utf-8?B?TlBBMmU0M2ZvRmZxaWtBR2xuSTFyYTRRSHhpUG1iVm43MEtnL2xZK0ZQSDlo?=
 =?utf-8?B?dHd0MFBxNlVqdkNVUS9GY2Vpc0JxdEcvRHFiRDl3aEp2ZThTTU9qWkVMTm1q?=
 =?utf-8?B?eDU1K084M1NuNnU4dm1jS0Z2YldqbzZ1WG1DR1B4ci95Q1lEUUV1MktVMVJn?=
 =?utf-8?B?SjNJNW9KaVpWQk5mM2wxSzF2end3aHNUN2Q0bnJsVStnRWk4VDVNWFMyOWxq?=
 =?utf-8?B?ZFBsaS8yR2U4K2RldnRXd2FCL0pjYzNNS29ZelJGOWFvSkVoMmVUUXNnZktM?=
 =?utf-8?B?eFZrRnBiVlRuQkR3U0NWMVRRcWNkZ0d1dVAxL1NRNS9pSW1UbjdyZjdFanJl?=
 =?utf-8?B?REt2ZEluU0VFU3pzc2w0UWUreFpkTzI0SHpOcWlXUWhxOTkxTVFrM0U3dFdm?=
 =?utf-8?B?U25qajFBMFEvT2d0MHR3bHJGYklNTWVJRHBWQzBLS2FFWHhYQUFxc0IwSmRv?=
 =?utf-8?B?L3FRUWFMdlhvMEZTUTBXMUNoV0NrUzduc2dRcXo0RWk2TTlVZ2JOWTNJWjVq?=
 =?utf-8?B?MUVpM0Y5YWVmcFRjb3EzcDduN3BoYWMzMG9WdVdBQVByaTlBQndNdG44SmlY?=
 =?utf-8?B?NGR6RlFtN09pYjFMOE5IUDlrOXhUY0JIL1ZpWmlpaHc4VFh5d1U2OVROdEVa?=
 =?utf-8?B?Vyt6OEx6UHR5OFlucXlJcCt2N25yWVBuRzdnY2JkcWg3TXRKTXFmMHYzckt4?=
 =?utf-8?B?V3pPeDFnNTAzVWJSVGtmRTNCdkJzVDM5N0Q3K2ZXRHZMdW1wSm0zbzJ0aUR2?=
 =?utf-8?B?dlFzTTNpMXNiNjFQQmNidXJwQkplYXNRWFVkMnQraFpGM29FNlNBRi9DSTFo?=
 =?utf-8?B?WHQzT3puZVU2eHJGRWh3L3BBcGRFWG1DamdYNklIc0YydlVOVG02alozNCtY?=
 =?utf-8?B?Q2svbktZai9ab3prWGtNeXh1cnRxem9CbXFVb2tyQWFaNDJmR1BmeEkzYjNw?=
 =?utf-8?B?Y1R3U0xtcUNnZE1OazRPOWJnU2Ywc01wc2pid0VvcGFrTnlJU0RPdWJRZWFM?=
 =?utf-8?B?WHVTZVVURk4rWlZkNXRPeXNTTTY1cXFSNGY0THJpR3g4cS9ZVTByK0NKUG1k?=
 =?utf-8?B?K0NNcGhzR2xWMnNTL0JXbklzK3dvQkZ5TDQvbEw2OVMrbG9TM1JlQVNacEo3?=
 =?utf-8?B?RW90cG9qeDJRWGRlVkVFS2thVkVmbjhhNmIyNkowZlFSdG5ENVZIdFBacXlZ?=
 =?utf-8?B?OVdsZHlDK29BdVYyYXFiWU41TFJMVFVoTUd3UjV6YUhyR0EzdjVwV3FYNHBu?=
 =?utf-8?B?MnZCQkdqWmNIcFFLWS9nRG0rN1NrbEF4SGVLditmd3ZqVytMZWtXaUhKb3V0?=
 =?utf-8?B?L25ZTncyeXRFMEpyTy9xRmJlanE0LzV3WFpWUWttRjYrUDFzNlNnRTlBUlhB?=
 =?utf-8?Q?vYg8CzijosGjd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZsWkNCdTNnREd3UnI1RUp0bWhtcTAyL1R1K29iSXd2SjUwTFpHbXBPUWxh?=
 =?utf-8?B?ak1JbnRUeWpuckVicXVLRWRjemJGTS9DVVBvVEhhRHNaVU5FdDN5ZHFWNVdM?=
 =?utf-8?B?TGV5RjBQRkNkakhtb05vLzR0TWZSVlYwYzA3eVdoM3pVbWFSZW1XK0t4WHFQ?=
 =?utf-8?B?RllON2VGUnk5UThRMGo2eDNLNTM3OXZUak13RW4zOTJZc3Q0K25RUGwwemtj?=
 =?utf-8?B?Y2lvbEVMZTExbDJnQXVzWWJYZjJ6UWtiTU9PM0tpWGt5QnE1L2lXSzFKcXJu?=
 =?utf-8?B?STJwbHdMYk1ZNlY1WXN4UUtLUjk3MzJPRm52L3dLd1lYY3NUOFJDeWlSamVv?=
 =?utf-8?B?UmhEN3JQOFJ0MUtOUXFaQ1hhRDliQmVObVQzNlNzT0MxNnlJNVNqUjIrcytj?=
 =?utf-8?B?MEVqOHhGODljSFJ4eG0vZDFUcE5kdFQ0aGFlV0s1RjVxbFZIM2VNcGtoNXJs?=
 =?utf-8?B?dXdYbjkwSjdLUDE4V1FSUkFGN21wSEF1SFZySWQyMnllNkJSSHhxWWxYQ0lt?=
 =?utf-8?B?OXpWa2ltOXFZeDgyU2p3eTIxRlgzcHNVU3E1WkVZRE5BMXpDWXZFQWFyenJD?=
 =?utf-8?B?K1Zic2FLZXRtU0JXVjZhNDdVZ3EvZ3YyZC9PaUR1eTZzY0VCZkRwdU8vTzZv?=
 =?utf-8?B?K0dVcUpSd1FZVjFjM2FvbEplcHNMVWVTWlNkWTVJWkxyMHVjSmlrenJ1QlNw?=
 =?utf-8?B?bUdkVUlwMWlnWWhQNjFKNW9OZWlBQ2RCT1dBc3pRNnNicEF5QmoyR05UUGJO?=
 =?utf-8?B?NHNMa0lCOFZBdjJxbThJaVMvbWJLQ205cjFGeUNSM0VrZUp3VHZ4WVVnajRm?=
 =?utf-8?B?VHlENytHZXJOa2NsQktzZ3Q2Y1lWR2s2YVdCSlBhRFJGeno5NkNvb2Y1YmZL?=
 =?utf-8?B?OTFXaGFGSGxoSFNRamFCRmU4Rit1bXpsNHRra3IxRm9IUE1oUHBZVk1tR2xK?=
 =?utf-8?B?eEFSRW1GblJJZ09wSWQ5bFZzMHdoOWJqemdjdGh1TkI3UkU5QlMxcjcvWmlo?=
 =?utf-8?B?N1FIeTZtRTdXU0ZudGNMZ2hYcU45ZUNoOGM5OXRMMG9WMmJNL1o0RjlaemhX?=
 =?utf-8?B?Z2NhOWZtaXhIY005YzVFV21Ib2RONm1xcjFxbmFiZkJVdVFNVkRubUJCNW8x?=
 =?utf-8?B?MDNzck1OTXZ4UUdlSVQzUFlYRElMUGdZcUZSQXhEdWJ5eG1ZN0ZQTzYwblk4?=
 =?utf-8?B?cGRYM3ZJNTFVeDNOS01meVZtT3NDU2JaUFhKcm9UY3ROaVU0TTNLQWxyZWRt?=
 =?utf-8?B?Qm5ibkdlSmU2MEx4T0tIZkYzd3JmVllSWHp1VmVLSmk1azRiOHdWdHBKanlE?=
 =?utf-8?B?b0J5M2cvc3ZMbXNONUE1VW5xMTFLcmZvaGVJQlhYSGpaR1lqbnBOY2tpVWQv?=
 =?utf-8?B?NXVvRXBqSzhtYUd1UG51YmZBSDROVmJNQXFHM0twOUZUbzFySEJSTjNOWUt4?=
 =?utf-8?B?d1g5eFh5bDNJNUxvRkhxcjRBMXFkTXRiYTJKTW96MWg4T2xpVzFTU1liUUQy?=
 =?utf-8?B?djdXWWVXbGRxSTdwZ1VZNDVicUZHWnpRMVlIRFh0VjdQYkR4dDBMU1dqeDBW?=
 =?utf-8?B?bTBtUzJxMkhPZjNrNFZVRC9VR1FablhTYnhBTlEwY2lvUUFRcXBzbGlMZ3pW?=
 =?utf-8?B?ZWloZGliUmFFekdacGdtcEM3M3JucG01RHZvbnRIR29Yc0hDYVhnaWhvaXR0?=
 =?utf-8?B?ZTREREpHeFMvK2RjOG8wakZtRGZQVXhXdXJTU0V2ZXEvclZWUWdmQ3Q1NFYy?=
 =?utf-8?B?M2dOQzVBSzNSZG0rUWd5UjYzbUJ6ZnBVZ0tVR0NvMG9IZUFXNmpFckJZait5?=
 =?utf-8?B?NGRZSFhDZ2JZK1pZM3FadVY5T284cGlDZkJTTHZtZ1BkSmd5WnJPYVo3eVdY?=
 =?utf-8?B?d3hyeEtCMFlpYVFobHhIWkR0ejg3bytrbUc2NVV3U2ZwTnJoR0MzTFpOc1R5?=
 =?utf-8?B?UHdwVzNrWVpyaEtpclBXaDJaQi9UaFdrbnhJNGE3UXQxTm5EMkh2Y2pTV0RD?=
 =?utf-8?B?eTBESGNzaDVVa09ia0l5K2wzL0N3OFYyNmdGYUpsckhiVUZaNDd0b0o5Zmg0?=
 =?utf-8?B?M0dMcitNUEViSTdGbWdoNnMySXduUmV4WlJuV20rY2hpWWMrL2xaRmllanN6?=
 =?utf-8?B?OElOOEIxSTVQb0hyRmd4STAzZHVpNVRnUll2aFFNbm82cVFLN3JsZkZQZElm?=
 =?utf-8?Q?XDwaqJi5k3dzsfz2YytFsrk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pECPiN9MiVfmdiGMagVIiwj+ew+gG6puZTNhXmnOUIYac1c7CNNrMiN5EwWfxbKgIKaAXpFCURJPG05+zO9h56T0SxNZHwVCQvrGm6rDSHLIZmABit9nqdteVspn2fN94IA8ckd+vCLu52P2R2hvWtiCyBpq7jR+QsAYQpe06y250Zl1ARYn1o486vIyCCRHrQAcq8VLfPOCfff4g5M2eAFKjdh060EUBvgcNJqGoBCELnihUJ9W7NGAT/FEtAvc+KgUpVGNN7ob6NSUdon4MzYX9RdTmSSIzeiEXnNksXl4tkIiTncqPwRPNntvW0a+S31vl/DViS35y+oF9ipgwFSc0eeNofb+6vEMC71PdIJpDWVZz5R4NtfJzM+nlJQBPBgyoQIWhbv+RSGyn9upRd0Sn6EcyOaOCC3FYZH+Gg9SaAmR24HL/cLcqRVIDeCSLMf5qj0xAKoqRvMpBZyAthwvwWx7KglcGJxdwkqaNIS62iEH9k2ebZAgoHCoDTwl+sXIY/mP1J4mMQO/asSFVGIwalvROiE8mWhH/CEltW8gyJNs7f/oIfmcbqn85xsPox6qybdWwURwy0YF9vQ/D1ncjAftvhyWzQql3SLhbP8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4efb3e-2043-4d18-76b8-08dd3a2b4de8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 14:53:02.3351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNRfqvgu3qzIv/rKnrjCd7yNc91Hehla32ISI1EsQ6HvBKbjnIHQ+T1d6+oExaUmkqGGqis3s6xbTdIZKVzDFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7521
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_06,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501210120
X-Proofpoint-GUID: CJmpEnS6QW4oeoAN2cNK9qksZx1ZI_Id
X-Proofpoint-ORIG-GUID: CJmpEnS6QW4oeoAN2cNK9qksZx1ZI_Id
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.086,
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



On 1/16/25 11:44 AM, Eugenio Perez Martin wrote:
> On Fri, Jan 10, 2025 at 6:09 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Decouples the IOVA allocator from the full IOVA->HVA tree to support a
>> SVQ IOVA->HVA tree for host-only memory mappings.
>>
>> The IOVA allocator still allocates an IOVA range but instead adds this
>> range to an IOVA-only tree (iova_map) that keeps track of allocated IOVA
>> ranges for both guest & host-only memory mappings.
>>
>> A new API function vhost_iova_tree_insert() is also created for adding
>> IOVA->HVA mappings into the SVQ IOVA->HVA tree, since the allocator is
>> no longer doing that.
>>
> 
> What is the reason for not adding IOVA -> HVA tree on _alloc
> automatically? The problematic one is GPA -> HVA, isn't it? Doing this
> way we force all the allocations to do the two calls (alloc+insert),
> or the trees will be inconsistent.
> 

Ah, I believe you also made a similar comment in RFC v1, saying it 
wasn't intuitive for the user to follow up with a 
vhost_iova_tree_insert() call afterwards (e.g. in 
vhost_vdpa_svq_map_ring() or vhost_vdpa_cvq_map_buf()).

I believe what I ended up doing in RFC v2 was creating separate alloc 
functions for host-only memory mapping (e.g. vhost_vdpa_svq_map_ring() 
and vhost_vdpa_cvq_map_buf()) and guest-backed memory mapping (e.g. 
vhost_vdpa_listener_region_add()).

This way, for host-only memory, in the alloc function we allocate an 
IOVA range (in the IOVA-only tree) and then also inserts the IOVA->HVA 
mapping into the SVQ IOVA->HVA tree. Similarly, for guest-backed memory, 
we create its own alloc function (e.g. vhost_iova_tree_map_alloc_gpa()), 
allocate the IOVA range (in the IOVA-only tree) and then insert the 
GPA->IOVA mapping into the GPA->IOVA tree.

This was done so that we didn't have to rely on the user to also call 
the insertion function after calling the allocation function.

Is this kinda what you're thinking of here?

>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/vhost-iova-tree.c | 35 +++++++++++++++++++++++++++++++----
>>   hw/virtio/vhost-iova-tree.h |  1 +
>>   hw/virtio/vhost-vdpa.c      | 21 ++++++++++++++++-----
>>   net/vhost-vdpa.c            | 13 +++++++++++--
>>   4 files changed, 59 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>> index 3d03395a77..b1cfd17843 100644
>> --- a/hw/virtio/vhost-iova-tree.c
>> +++ b/hw/virtio/vhost-iova-tree.c
>> @@ -28,12 +28,15 @@ struct VhostIOVATree {
>>
>>       /* IOVA address to qemu memory maps. */
>>       IOVATree *iova_taddr_map;
>> +
>> +    /* Allocated IOVA addresses */
>> +    IOVATree *iova_map;
>>   };
>>
>>   /**
>> - * Create a new IOVA tree
>> + * Create a new VhostIOVATree
>>    *
>> - * Returns the new IOVA tree
>> + * Returns the new VhostIOVATree
>>    */
>>   VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>   {
>> @@ -44,15 +47,17 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>       tree->iova_last = iova_last;
>>
>>       tree->iova_taddr_map = iova_tree_new();
>> +    tree->iova_map = iova_tree_new();
>>       return tree;
>>   }
>>
>>   /**
>> - * Delete an iova tree
>> + * Delete a VhostIOVATree
> 
> Thanks for fixing the doc of new and delete :) Maybe it is better to
> put it in an independent patch?
> 

Sure can :)

>>    */
>>   void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>   {
>>       iova_tree_destroy(iova_tree->iova_taddr_map);
>> +    iova_tree_destroy(iova_tree->iova_map);
>>       g_free(iova_tree);
>>   }
>>
>> @@ -94,7 +99,7 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>       }
>>
>>       /* Allocate a node in IOVA address */
>> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
>> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
>>                                  tree->iova_last);
>>   }
>>
>> @@ -107,4 +112,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>>   {
>>       iova_tree_remove(iova_tree->iova_taddr_map, map);
>> +    iova_tree_remove(iova_tree->iova_map, map);
>> +}
>> +
>> +/**
>> + * Insert a new mapping to the IOVA->HVA tree
>> + *
>> + * @tree: The VhostIOVATree
>> + * @map: The IOVA->HVA mapping
>> + *
>> + * Returns:
>> + * - IOVA_OK if the map fits in the container
>> + * - IOVA_ERR_INVALID if the map does not make sense (e.g. size overflow)
>> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing range
>> + */
>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
>> +{
>> +    if (map->translated_addr + map->size < map->translated_addr ||
>> +        map->perm == IOMMU_NONE) {
>> +        return IOVA_ERR_INVALID;
>> +    }
>> +
>> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
>>   }
>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>> index 4adfd79ff0..8bf7b64786 100644
>> --- a/hw/virtio/vhost-iova-tree.h
>> +++ b/hw/virtio/vhost-iova-tree.h
>> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>                                           const DMAMap *map);
>>   int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>>
>>   #endif
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 3cdaa12ed5..f5803f35f4 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -1142,18 +1142,29 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
>>    *
>>    * @v: Vhost-vdpa device
>>    * @needle: The area to search iova
>> + * @taddr: The translated address (SVQ HVA)
>>    * @errorp: Error pointer
>>    */
>>   static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
>> -                                    Error **errp)
>> +                                    hwaddr taddr, Error **errp)
>>   {
>>       int r;
>>
>> +    /* Allocate an IOVA range in the IOVA tree */
>>       r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
>>       if (unlikely(r != IOVA_OK)) {
>>           error_setg(errp, "Cannot allocate iova (%d)", r);
>>           return false;
>>       }
>> +    needle->translated_addr = taddr;
>> +
>> +    /* Add IOVA->HVA mapping to the IOVA->HVA tree */
>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, needle);
>> +    if (unlikely(r != IOVA_OK)) {
>> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
>> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
>> +        return false;
>> +    }
>>
>>       r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
>>                              needle->size + 1,
>> @@ -1192,11 +1203,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>       vhost_svq_get_vring_addr(svq, &svq_addr);
>>
>>       driver_region = (DMAMap) {
>> -        .translated_addr = svq_addr.desc_user_addr,
>>           .size = driver_size - 1,
>>           .perm = IOMMU_RO,
>>       };
>> -    ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
>> +    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
>> +                                 errp);
>>       if (unlikely(!ok)) {
>>           error_prepend(errp, "Cannot create vq driver region: ");
>>           return false;
>> @@ -1206,11 +1217,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>       addr->avail_user_addr = driver_region.iova + avail_offset;
>>
>>       device_region = (DMAMap) {
>> -        .translated_addr = svq_addr.used_user_addr,
>>           .size = device_size - 1,
>>           .perm = IOMMU_RW,
>>       };
>> -    ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
>> +    ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
>> +                                 errp);
>>       if (unlikely(!ok)) {
>>           error_prepend(errp, "Cannot create vq device region: ");
>>           vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 231b45246c..1ef555e04e 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -512,14 +512,23 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
>>       DMAMap map = {};
>>       int r;
>>
>> -    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>       map.size = size - 1;
>>       map.perm = write ? IOMMU_RW : IOMMU_RO,
>> +
>> +    /* Allocate an IOVA range in the IOVA tree */
>>       r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
>>       if (unlikely(r != IOVA_OK)) {
>> -        error_report("Cannot map injected element");
>> +        error_report("Cannot allocate IOVA range for injected element");
>>           return r;
>>       }
>> +    map.translated_addr = (hwaddr)(uintptr_t)buf;
>> +
>> +    /* Add IOVA->HVA mapping to the IOVA->HVA tree */
>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, &map);
>> +    if (unlikely(r != IOVA_OK)) {
>> +        error_report("Cannot map injected element into IOVA->HVA tree");
>> +        goto dma_map_err;
>> +    }
>>
>>       r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
>>                              vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
>> --
>> 2.43.5
>>
> 



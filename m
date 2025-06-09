Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EA9C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 13:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOcjP-0001iQ-N8; Mon, 09 Jun 2025 09:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uOcjO-0001gH-2T
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:40:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uOcjL-0000ve-Qp
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:40:05 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5593i7X8006323;
 Mon, 9 Jun 2025 13:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=99CNV12hwLDkkM93auv3ymv/FpjkAKH1bnvc9xrEVyQ=; b=
 k00M0xHxxi7/ct0NGGqJgGho3kTidiBCCD88dOhprpL1g53doGnAy0RsnrnYZwCn
 g0DBBBq3DoOCglCgpV8TbdF8LM/P5yLhAsNcmUJlHLSBSRPJAFMzfmWM9Kb2/v2Z
 q6QCABx4HtsYOgZqry8VFiRgF0Sqp7qmX6XzX8NesDYKNtUZt5aBp0t41R2gn8pe
 VZ1J11FCw531CIDHq4BUZl0R+A872IDReqHXhpb76jlUWhVncd8JudG/hK2kNEKz
 /QtHltyw4mWDsShbuB60A9cbpEzHhr6O9eusi4RILu04BVz+KO82ZVSaXoBMbQ4I
 g8fgOumaldgLO8XA59A3PQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywt48s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Jun 2025 13:39:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 559Bgkjf020717; Mon, 9 Jun 2025 13:39:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8676r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Jun 2025 13:39:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZ1CzPw+QzAP3DQpjeYHaNaCGTdat2IPgiqYFmjWySaBur2vM931iZv9bXTvq65iO9vSHFFFHIeIQFp7pB0OxnXBAruYo8ZIvMjq0fi+syJ/nH374ceyvEMaz+puzl+aN8sIeWdEdsM5W+dhkdYZmgkzrcxopaTQAEdL+cEg6ApAtoJ7LSEml3CM3vvmOQD//iVtaM7+2mhvqiPYZIyWfql+brGcGEAbQVgiLgHFkcrh8GDAP6bboW8sY5CTP8yVYAop5Kz8KNHBYJLPcDbbzmsz/bD2i/kMoS2+oMtLKfIT2g60RDFkBMrQFKCwHTRz75Vkzz3EU0UbDSOxmiblgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99CNV12hwLDkkM93auv3ymv/FpjkAKH1bnvc9xrEVyQ=;
 b=ZWPdurYUU4MVEm85XqqFWtlB8PJanbF1E+bcQ/BLwohLr2+zqPQoBWTrI2Jd4AwISKRmDRinUnCNbPNXLfJUuqLNzud0i2TW9BPCf1/Q2GN09sCeOIkU8AQDKEUlcNa85FQCWBPEUSNfzEuYHbRB/vosiCMQvg8/Qb+KQIgBygzvjpy62heewX52H/BU3gyWz9HK0IzY/5yzidL94UpM7gXD2zW0Q83eBEegMfn/ngwM95l2VWV2nykMP92+mGsqledmTshNavYTaSQuu/XoENlbWtZOADuiZdcvP/3Rgr6dy5Wu0k6h2zXrIsKJ59/3D/XHyA4Y37lf8Ql2BH+msA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99CNV12hwLDkkM93auv3ymv/FpjkAKH1bnvc9xrEVyQ=;
 b=yeKSRG3YcXnOwy2F1O14uI1104E5gTw6eG0kBKzvRxzfyTNLsxdPOyVY7jIoyVJX7uPTrwjBQfS8SVMTn7zttjN0BO5oWTP/RqT/EDH53dRWWRsSGqgMfIM9Q9itWMXJ+izv9aS6RW/DUNhWOzx7YU0x7TcNPaMgXpEfu9AhIXA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.27; Mon, 9 Jun 2025 13:39:50 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 13:39:50 +0000
Message-ID: <881cb07a-95c7-4f3b-8012-352873e88d64@oracle.com>
Date: Mon, 9 Jun 2025 09:39:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: JAEHOON KIM <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de
References: <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
 <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
 <aEMMjtsKZLX_Bi03@redhat.com>
 <7dc8d42d-47f1-49c1-9bff-ab2d09d0b6f3@oracle.com>
 <aEMR6Xjs8tRJ8_sp@redhat.com>
 <b2d90921-0991-4a57-a141-ad0c830f8618@oracle.com>
 <5f211f67-17f7-4b1d-a60a-4ff62645fbfa@linux.ibm.com>
 <ad638089-af36-4f3e-8f3d-61549e9bed06@oracle.com>
 <aEaWC_Lc6c1g821f@redhat.com>
 <f46393bb-115a-489f-aa8d-08348e89d25e@oracle.com>
 <aEbfuM681MJh2S-b@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aEbfuM681MJh2S-b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:c0::39) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b9b4dc-7e45-4817-b5e3-08dda75b1bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHVYRXZMRk1saVN6MU9QcVo4aXBrZDk2eHVmM3RWZTNnY3MrUEZDSUJFVTQ4?=
 =?utf-8?B?WGJJVFA4WkNZTUwzZFZndjduTDhlSkZaRFZDZzVDVUdoT3BPNEpVRjJZQXQz?=
 =?utf-8?B?SzZKS1lpYU91Tjk1S0RONHRnOUJnSHRlVm1qN2tDaXN0Qy8zOU9HUUFGVG0w?=
 =?utf-8?B?RGFyM05YaEEwNGh0bDRkdHFYTTlHeUFmVG8vYnNPNkVmSXovcGRKVElMeHVN?=
 =?utf-8?B?RDh5OGZldWJEb1Vzdy9uN1QrTDdCQ0FBVzdsUUpENHc3Z2ppdjZiRGxhWDhS?=
 =?utf-8?B?RkhlVXRoQXA3Z2JUMXloY045dlZpNG1ZUlVvMlQ1cFp2aUhDdXg5ZVY0b1F4?=
 =?utf-8?B?dTZRb3pxbERDZnpjam0veVpjWHd4QmJOc1h5bC8yalEvcEZjNVI5UitTbVdw?=
 =?utf-8?B?ZTg5T2M0RkpycUJWV1BZNk45NjNGZDducWZjRjNYSE50RmZHTFdjbWFCbWxT?=
 =?utf-8?B?R3N4NFhwSm9sTWRueG9aOFFZL3p0RmpmSFJsZlY5dXdsQzdTYm4wUW5Oazhs?=
 =?utf-8?B?c0d6c202Q2FRVzRZMDJKQjc2K3AzK0NnSGpseEkwYUVKNGxEZmVhQ2hLVzFM?=
 =?utf-8?B?Q21POGN6cEtqYVB0TWlIYXM4R3ZDQ29CcXlrcWpJWU1Kek0zVDU5SlhKQ1NV?=
 =?utf-8?B?Rk9sNmFoeVFseDI0VGxqeEhhS0szTkNBZ0EvQURsYXNTTkp4QXBDd2pSYXZE?=
 =?utf-8?B?L1RTNjdoK0pwdy9rQkZIOVFtUmllNHhOT05ZakxjY2NwNGlaK3VBRnY2MEF3?=
 =?utf-8?B?Q1NDR3R0MWdqM2hVZHZ3RzRaSWdueUJEOXdFYUM4NFNRelMxQWJwWUszREI1?=
 =?utf-8?B?OFdKR05NbGFrU3lEdjlUaUh6YjdkYStwaGNKUWsyVDhEbUd3TGl6cXhSNVM0?=
 =?utf-8?B?V2Z4dE1RV1BZUVBWM0pjaFhXaGdnakEzeFNCTHJzQ3l4VHR3T0d0aThKRVAr?=
 =?utf-8?B?aXJMU0wra0xKdXpRNTVCMkhwNVduYlpwUk9SWFJxdnZGdXRMVytuR2piaXhQ?=
 =?utf-8?B?N0N1TTRKV2hwcXBSZGVkRHFJWkFjRFNNNlJpWUNpVWVhM1RlSVBHTFd1TTgx?=
 =?utf-8?B?aHQwN0VQQlNqdHJCOUFLQzl2YjNhMC9hUXpYR3QwNW1Sc0VQbGF4QUU5Rmtp?=
 =?utf-8?B?MDBWUW5uRzd2cllPbzdNSXpCZ3RZU2tkdk4xaTkzVXBRQXN5bnYrYUZVdGZZ?=
 =?utf-8?B?OTJLeTU0ajVmbTFWMnhTSUFVMG1xZVlDakk3TW1CRzdTMkpBMFU2bTJ2UHhH?=
 =?utf-8?B?TDE3OTdTTnlMZU9wdUo3U0d2N0JrOGh0bStzTnlIUlh0MzIxMmhDMXRxV1V6?=
 =?utf-8?B?dVlOeHpvREMrQWtyWm1JaGFZMExMR1BleWVwdm9ZMitpWmhZNm5ueEw3OThr?=
 =?utf-8?B?c1VCWDlpT2JwVGgrS1pCWjV5Q1VsdEFld29MR052TktBTWxTaDNmSS9zbkJ3?=
 =?utf-8?B?dDYyaVl2ZGZIVTc0M3plRzJibEFNd1BKTmEzWi9jTEtxTGY1TDBudE1tL3NM?=
 =?utf-8?B?VVVsOVM0U2daaHh5aG03VFNoMnpkOEQvdGkxZTV4ejVYNERNdXd5Z2txZzAr?=
 =?utf-8?B?a0ZjWEZDakZUWEhlRnV1NGZKcXRnbndTZU45SkZVWHJqU01PMENyeVhocEVk?=
 =?utf-8?B?ZmdvMGtXblozY1dKemwwMXhjblpYcG56NjZMVTI5Z0QzcC9Pb1RXN1lHZnVv?=
 =?utf-8?B?SEh3akQ0VDRnRElTcXdweTI3NHA4L1BEdEZqdXRFaEZpUCtlTDZ4UFk0SEF4?=
 =?utf-8?B?Qy9ETmllOCtraSt2bGRkakw3R2cvNW1sZThRRG13eFM1cHBXbmRTQ0c1Q2do?=
 =?utf-8?B?bFZQVTB0NTFoWndCUkM5eWVrN2pYUlJqWjNBUmVjT1I4Tm5YemQ2YlhiMHBn?=
 =?utf-8?B?UlJ2a2xkcEFUTS8rUllsN1dSYzlJN2xsd05GK0dvVnRYVmNsUE9LV3RCSHVj?=
 =?utf-8?Q?gKJy7bDfhnE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3hMNkU4UGdEQk5DMWtVVFBKMDZ4dEMxRVVlaGc2Sjd6QW5hSSsyZWloVzE3?=
 =?utf-8?B?VW0xSEdDZXFlTFhQaHBqUkJkdUtSQk1EdGZSM0RHd0dxSmx0dUZCcHFtUTgy?=
 =?utf-8?B?eVl6eWtodUNMZXlRZFE3NXg4c1FaNkdLUytLNkdyQ2F6bGRLM2taWXdvZGdm?=
 =?utf-8?B?aGV5QlJaWERWYkxCa1lreWMyWU5oa0c5Vi9BV054MVdmcWJ0a0REU3lGbUZh?=
 =?utf-8?B?YVN0bXhhN2VVSGtFSWMxY2F0MEoraWRKN3FGODhYaWdsNmo4T2xpc1doeVp5?=
 =?utf-8?B?NHllVkF0NlFUak1zU3hGVW5aU3dvSlhxSTdUaVkvNmpyand0UzZ0Y3pOUWFE?=
 =?utf-8?B?L0J4c2NNS2xQOC9IME9GTWZ4c3huUzZmNVJQVkdYZ3U5NWJMcjd1RXhkQWxY?=
 =?utf-8?B?RXZWRGNZWk5kdy80RHcvcjliTldMYlpVdFJoeXRFOVFwdGlLUGZBTEdOZk1J?=
 =?utf-8?B?d2hTdW1RS2hXWmpSR00rUnkzdkNyU2dJbENYb0UxbDRHWTNJUVEzUHhrRHJ1?=
 =?utf-8?B?YlJsdWtlZmFMWWhXUHZ1TFh4SjJIVVZjUEszSFFYMkNvV1FFR1FLVFBaVWRh?=
 =?utf-8?B?YjFtM0MwVlM4OW5LbkhTcEtFR1A3UXF6VXpVYVlaMEVyWUhaQnFad0JteVNM?=
 =?utf-8?B?VHR2cHJvVE9weDYvVmZVWGhYNFQ0Nmc0OFJBRm5IMnVpSXI0dndRM3h6dXQ1?=
 =?utf-8?B?cXBPUkNQQ1RWTjdGRnFzbWk1YUxvRytndThNdDZvcmpkWW9BOTVlL0dzdUo3?=
 =?utf-8?B?V3lkd0h5bGpXaFJNcXdNM0laYTZrMlRJeWpmdFgwV2hNOVJLL2tpQm80ZEZH?=
 =?utf-8?B?dlhEYXBuVGJnT0ppanhhLzJDSUpOQTlpV1RQTzlwQTUrQmNVSnBpeExRR0Ft?=
 =?utf-8?B?NHFTL0RCZmlwRkZKRGFFMTBXQ1ZLTkd6UlFFbmZ2TEloeS8rRXRoZEkzQUZH?=
 =?utf-8?B?dDN4TCtYSytDa2xiK05DalFvSzhSbzR4RTltY1FvbTZSaHB0ZHIyYW1iNHdi?=
 =?utf-8?B?VEVYUlBXeUJnWk91K2NyMUYrM29tRDRWREdzYWdoUklha3RLUHlHOVY5bW4w?=
 =?utf-8?B?cGZQUWpzdUE1WHBkcmRqUmNvZFM1ZFRLcStSRzd6T1NPWjlrNTZXOVE5KzhX?=
 =?utf-8?B?aDdtYnVFMkZQeDZyYzVhcTdidjVJN3FaSXlJYTY0QVZ4dHdvV3F6Q3hIRDJS?=
 =?utf-8?B?UytBYUQ5OUlZbHoyK0NQaGVWcEVDMElYWDNuTDROM3V4OWx0bTNhN3BQWGJG?=
 =?utf-8?B?Y2tiSkRZNkFaN3p4K2JOQllHVE9pR1RUQVpyZlBOd3Z5a2Q3akJINFJZalBC?=
 =?utf-8?B?ejVhOEdNS3krd3JiekEySGpnejliN2pNcnBpM0dOdUlZSnJBWGg0bzgzOG0v?=
 =?utf-8?B?OVRGZHNuVnBwNGkzTEFEUC9aTG40SDNWR01QeTcrT2JxWkpPWTV5L1YzRS9B?=
 =?utf-8?B?K0NhOFEvNmhwMUN6a2FtaVVEOTFBdW5mV0xRb3I1ZHlCNWFYZzVNbFRLR0Fu?=
 =?utf-8?B?M0c3Rm1LaFZBcnNpb01YRVBxZjNrV0s2aG5mblo5dDhwL3dzREJWemFUbmFx?=
 =?utf-8?B?MGRUMUdhQnlmenluQXhuUSt2cG5jdkNEYldNT0RNNTZlU2hZTG12WXVzNTd4?=
 =?utf-8?B?WVVOd2JDZ2RoZm9rSFUySEc3Ulc1bmszOExlOWltQkNNaVZVc3F6VmpITFJV?=
 =?utf-8?B?UGJndFY1ZkJmVUY0cDVjbWpRbjNRWitGNitidnpsK09YeC9XZUNBcG1PQ0Rr?=
 =?utf-8?B?Q2Zpby8zV01wQ2hQbWJ3Mk50R0JZL21DVWFCVjIvd3JJbTFObmgyVkh2NWtJ?=
 =?utf-8?B?WGh1SzNzNU5NZUxybFN2Wk1tY3dDTGFLMlpCOWlhdjM1NVZ1OG90SDdyMHc3?=
 =?utf-8?B?UTdZUUNod095MmV0Vk1sUmcxc0IzdktUdUJlSEVRcDFoUGhNTHljZEQ1Z1Nl?=
 =?utf-8?B?S3A4R2RLbTlOeXhUY2Qvb2IxN2w1ZG5tRmlqUnlKaUt5V0ZIVWdwV3JvK0FJ?=
 =?utf-8?B?Z1pveS9VZ3hXc1BPVUdzVUZrWTg2OUp5SXZMbXdFYXppdzRNSm1XWldZeGdX?=
 =?utf-8?B?RHdvcWJLZUhCclZ3cTZyUTVFWUgzcnAxU3FkR0dUbVBkVmd4c0RhczdIVjA1?=
 =?utf-8?B?RXhua1JXME80N1FkanJEZzJRdm5Mb1ZzeXBMUmFMTmxUZ3dnZDJZbTVOUjhG?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 64MxSVjBbR1eUq2alrfNA6dH9e1jOn0f2QWwOh3MVdubSJeyTzVYQLiRLuVcxP/4ICKBAtrPqOeGPi8GxpI5m8ShUZMLgl66/LckgUEIM1YqL45pNLk6m6oGdxT8xLPwtT+oQXR/rhzdEIklfVACdYVcPjLUnOUXsZ6hZq6lD+hrf0wSdFQnkGYZicn0u3AYbHySaV7Bsu0yXyia7YPMLc/4C+jFwhOAB7fx2eOotiA9iQbORHBcaFiUA77g+4nVs4oewuCprgkUO76ri+5+/hbCVrehFcsLNUc3P9H6Cx3/gBCrNv1wWinrJ/4lFOU/brCVHsJFf3pUDA4a2QtHgQIeu6ltjBtGTlQU0FCBsVbEGmClhG9E1zMU1/wb9Q6DZ7yXet7LEfc+5U6tTNoZNyvUXgffJDvCh0rPZ6PuK8ub6k/wbBZvg3ciIPr9lo64hLx/gcBuxObkh8Pe6PeuyTwrRuO6ctgRG6YKelXMNys2pDkgrh38f8yth6iiwzXba1lzMoFm3G2ICjGHPCsfIqm16/5b4hsQZfDnbQw5CCZz30nKLgQxbAeunhWoV+uP2hTjAKUEAHvEWpDUI4Zx873zGvjVz9SuWfnBJffGn/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b9b4dc-7e45-4817-b5e3-08dda75b1bca
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 13:39:50.7882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQSG9/QGvzgbo8sEnbcv+2DpsiyzISJbsmVutbNvyV1qCWowk9mNTiCrts7J4apw3MDwWafoVhXZu/REK9MMkp1njHa2XiltA/iOxHypTjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_05,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090099
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=6846e430 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=9OVJHK_a0wd55AT1Me8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: F1fWv_uzUEOIYvy6LFpZzRHz3do9DSgH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEwMCBTYWx0ZWRfXyUJtvPut3jmu
 +mQn5VuId3mjWFBU7PedCorZBao9niHcYcrWExuhITzcibHsWMDhTrT797Df9K3rhAcDa/Z/Z5S
 hnS6nDY08nY2mtstNsr1qRa6HwxQ4cYF9G/YXVFrtUJ1SvfgHYSTuGlQyZc9Q1sUbbSYWvaShOi
 BoRtPtA6v/FlnrotWV//euP72quPWvP1+7riF1XdQomWndRPxoJ12WKEkVurrv5EE/KBKcR//TU
 oGDNp1iLEDjEUkN/Os+pLzTcpX5yjWO4H7KJx7xOdLhfvDN9RIIeWKupCf1xgy7uT6TbzC7NDqA
 v/xyP7GqsO7WKn9WsER03x7jHknZFbTNKPuEuTaXmG25CMGxlo+LDpmdqdlLgedyJKRfvioYTuz
 kxNP5/7CRdZjdttlwThCuMWw7f/k6hhOyQze6IB9o3cxvvHcJNjzVqO2Tn0Vy1c1wU3if1Q5
X-Proofpoint-GUID: F1fWv_uzUEOIYvy6LFpZzRHz3do9DSgH
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 6/9/2025 9:20 AM, Daniel P. Berrangé wrote:
> On Mon, Jun 09, 2025 at 09:12:27AM -0400, Steven Sistare wrote:
>> On 6/9/2025 4:06 AM, Daniel P. Berrangé wrote:
>>> On Fri, Jun 06, 2025 at 03:37:56PM -0400, Steven Sistare wrote:
>>>>
>>>> The easiest solution, with no interface changes, is adding wait_for_socket() in qtest,
>>>> with this addition from Daniel:
>>>>
>>>>     "With the busy wait you risk looping forever if the child (target) QEMU
>>>>     already exited for some reason without ever creating the socket. You
>>>>     can mitigate this by using 'kill($PID, 0)' in the loop and looking
>>>>     for -ERSCH, but this only works if you know the pid involved."
>>>>
>>>> Daniel also suggested:
>>>>     "For the tests, passing a pre-opened UNIX socket FD could work"
>>>>
>>>> Note we can not use any of the standard chardev options to specify such a socket,
>>>> because the cpr socket is created before chardevs are created.
>>>>
>>>> Perhaps we could specify the fd in an extension of the MigrationChannel MigrationAddress.
>>>> { 'union': 'MigrationAddress',
>>>>     'base': { 'transport' : 'MigrationAddressType'},
>>>>     'discriminator': 'transport',
>>>>     'data': {
>>>>       'socket': 'SocketAddress',
>>>>       'exec': 'MigrationExecCommand',
>>>>       'rdma': 'InetSocketAddress',
>>>>       'file': 'FileMigrationArgs',
>>>>       'fd':   'FdMigrationArgs' } }           <-- add this
>>>>
>>>> That would be useful for all clients, but this is asking a lot from you,
>>>> when you are just trying to fix the tests.
>>>
>>> Note, 'SocketAddress' already has an option for declaring a FD that
>>> represents a socket.
>>
>> Yes, but if I understand, you proposed passing an fd that represents a
>> pre-listened socket, which requires target qemu to accept() first.  The
>> existing FdSocketAddress is ready to read.  We could add a boolean to enable
>> the new behavior.
> 
> It can do both actually - it depends on what APIs the QEMU uses the
> SocketAddress with.
> 
> If it is used with qio_channel_socket_connect* the FD must be an
> active peer connection.
> 
> If it is used with qio_channel_socket_listen*/qio_net_listener* the
> FD must be listener socket.

Fair enough.  cpr currently listens here, and we could add a case for the FD:

   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
   {
     MigrationAddress *addr = channel->addr;

     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
         addr->u.socket.type == SOCKET_ADDRESS_TYPE_UNIX) {
         ...
         g_autoptr(QIONetListener) listener = qio_net_listener_new();

Or to use my socketpair() suggestion, that function would also need changes,
calling qio_channel_socket_connect.

Which do you think is better for clients -- socketpair or pre-listened?

- Steve



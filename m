Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D4CCA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 18:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulXCz-0006MH-6I; Mon, 11 Aug 2025 14:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ulXCv-0006Lq-G7
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 14:25:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ulXCn-0007wR-GC
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 14:25:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BFN8iK012230;
 Mon, 11 Aug 2025 18:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=sZ4jquEY7MnurwgFJaPmAxFrqD6mw0p0NJgDB1tURsU=; b=
 jk6rTVnPBvnmZKqkaJezVC2TS3BIeAlPbG4SLMwBp19kB6H5oMY5XPswl065onj4
 XAIBiO+j55aH4/ke0q8gIjAh39Zx3I9iDOBG03zRksMvrTe7ZkLjrFiM5WEyzgSb
 Z7i+b/1yUt0i/wKzjqui0dbu+PJEyWeIQbDXnUM4E6LDR/phJgNXH9sLBkK6qOC8
 47jL0iatdDheOYHtZbMcmCnDCE/mFiS6WQLVIaS1r2+m/Mkx27Azdqa8OkFjuzzl
 aLw2ZUdoWpulimwtKEE+oxmi36gqZqm2zoA5XPMAv5MDbw7AayQlw42I0+6DkBYv
 AEXcU+9lfG0k94Kvq4yNTw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dk55g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 18:25:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57BI69GP005774; Mon, 11 Aug 2025 18:25:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvs8rm47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 18:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t97qaGrrWY1xSyugpjvZoSyXagyuUOKg+A5w4D4HzWDd2oCxuNZdAONoD05yzRvU5lcqVjRCJwOPGpHRGURZgMoNyEw1qYUeYSEj7D4tj5XzLxHZLQT1woDbKDEm3NOwwrnu8wgHfgdP3FuBNIhWQxVxbejdTSMQIAZIdXOIPOjJUWSvUXyQ9QWQ0XG15jzC37P2peRzVZ5Vmg2emSO54eU8kkOJ7WT3ltKj2fglDvQ7qYS9XCi4mH76lNFHytf6Oles2xx55ZFIOegW7fZja7CB5HUhoAUmEN4m9odLkKRAgZXrAPlVd+qNH51Lk9J+jIx38FH2z+6VPvsWsCvRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ4jquEY7MnurwgFJaPmAxFrqD6mw0p0NJgDB1tURsU=;
 b=I76EMtWfoDzuMQQ2idiLCwpznRvzd6FuDN1fP+vnhyFajyS8+clM7azgoOlmtIQpT9ZusHFFXJTIgGRODpbVDo8lFo51RYS8gzmPqYvhEWoWvQ20gvNTwt0vS6Wky9nipMUn7JEl5t8U8dMkuuNg0M14SAIw8Bi2vlK5zWuv2rFtEqFspvP3e1ne0GwlkYBP1fCtd066sm7WGWxpsOUkFwN63/bIPtBMLd/PPwdToBROi2Ri+BtLp3lQbN0VOWdGdy/WkRB+GpEfaLZSPcMshhA5iI95dDbSgOXPNt2Rb32zM0QMD/Ot/6FavetfOjqseO4yhQoWqPWvEv2SoBabBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ4jquEY7MnurwgFJaPmAxFrqD6mw0p0NJgDB1tURsU=;
 b=J5xofVOjC0OZoTZv9NQ4Pevbz1rsTGRtc9lMOHZYorXl6yHl0EWwwOtqEdzEwAbPlEGCGjcJ1BAByIkwZPBKSvisydLfbzAKgCvYg6mdlDO8/j4UHz8pZJKOHKilYGCrNfKmB7Nz+tgyj+uitKV6+S31Ak+sOWWpLGa3Tw6u/QM=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Mon, 11 Aug
 2025 18:24:59 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%4]) with mapi id 15.20.9009.021; Mon, 11 Aug 2025
 18:24:59 +0000
Message-ID: <2df79f18-6a28-46e6-937a-c584b2c8885a@oracle.com>
Date: Mon, 11 Aug 2025 14:24:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
From: Steven Sistare <steven.sistare@oracle.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hamza Khan <hamza.khan@nutanix.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <87cy993mdi.fsf@suse.de> <a01be1bc-8604-4ed1-9c22-9fe4b45de595@oracle.com>
Content-Language: en-US
In-Reply-To: <a01be1bc-8604-4ed1-9c22-9fe4b45de595@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::29) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|DM6PR10MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 533ee5c7-b3ee-44c5-d0c8-08ddd9046121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjB1a2RpNWxUd2Exdk1tNkoycmxsM2N0alRjVzlpV2h5RFpBMXdBOUF4QUd1?=
 =?utf-8?B?aFE1WTRxaTcra0dqalVLNVVJa081TEs1MlFUOFlobzlKRDAzajBYWWo0ZWRn?=
 =?utf-8?B?Y3ZvaUhORnE0RXV0ZXVmV3B4MmVVcE5VeTNVRnZlVVZmUmJWbzBnRWYra1Bm?=
 =?utf-8?B?c3ZmOFkyeGxWWEpEd0g3WGpIb2RwZG4yT0JxbWFidjBDVU02RS9QZmJyb0xj?=
 =?utf-8?B?dlhZbTZjOFpNSkxXdVY2UFc3bUpLU1hzRkt4RWRqMEVVQUFVNUd4WFBXeVBF?=
 =?utf-8?B?NFJEclM5US9rMFhmUm5ka1VXZktVZXRKWlBCRG5WM2FwME9UTG84S0tkVDU5?=
 =?utf-8?B?ZmdSV0NLRzNoMDRKSk5OM1FVcng3L0VCRG56ZlhUR1JIRDAzKzRUR3RZd2dD?=
 =?utf-8?B?K0h0V1k4Wkwvc0pER0RxRUZtZzRWK0Q1ek5mNzVzcm1TVHBvOGJYanQ5VFNs?=
 =?utf-8?B?emVMelFpSG9qUWRrV3pkV2o2S3IwZGc4YTFMUlh5aHVBT25pOXlPMDgyR0s3?=
 =?utf-8?B?MUZ2c29QcDNLbi9xNjBWVG5ieUUxcDdzbFRKb2x1dHY5eUZiNEZUK0hRVkhF?=
 =?utf-8?B?ODVsd0VLM1kzR25CaXNKTWdHRWRRbzlaWkNZNE9QMFByUmcyWkREeFMvTnFD?=
 =?utf-8?B?UXY5RDBHZVQyRG1tK2RJWlNwK0oydE81bXZpa1Nvb2dBRDVuS3YrSEFIdGtP?=
 =?utf-8?B?d0ZjNnk4YUxBMTd2UnJ0cHcvMTJKVGFwblBSWDNKd0o2VnVwaDdhT0ZNZk10?=
 =?utf-8?B?d3l2blUrcVlpYi90Tk5nQXhGTkpwTjR0SjdiOXJPZnpvM3NibURaWENOL1JR?=
 =?utf-8?B?b2FpamRZeFZOcldZVk1RM0FibVpjSFFTS3ZLbFhoSlExNGtYSXB1bS9SKzI4?=
 =?utf-8?B?bE5VZ3RjWlhCeGhDektpKzNIeGJsbUVoeWdZb0tnZjRtWUx0YUZkR1RvWVA1?=
 =?utf-8?B?OW83bjIzZ0kvbWdCdWhTMjJHS2FzeTlKNlFkUy8wWWV1YnlIWmNjV0hCRERG?=
 =?utf-8?B?dFltZlhIMXdqNWdmNGw4VkZlUldJeHZqUGxUVTNEUjhWWHNZYmVqaGlmeTRQ?=
 =?utf-8?B?YVorN2lZNzd5aWRORUxmR2xGUGIreWt2bzAvWFBiTVl5WUdBRHlhQVpYcjhp?=
 =?utf-8?B?OVFlbUFVVFVMdFZibVF4ODcxZTlrYmJ5SU5FSm1pOHdHbDZ2R3d3TTBJMlhh?=
 =?utf-8?B?T0pYd0ZFa2NHS1hXak9uaUxnM2M0d0hSUk05S2lCQkhVRjV3SlFBVmhScEhH?=
 =?utf-8?B?L0lHaUx4NThObzRVTUdCdU4ycGh0THFraFJpUXlHOEpzaTRVVDM2UzJ1cml2?=
 =?utf-8?B?VlJxRXdCWGRDNW56VU02ZHU2bVBQUVAwMFU2czkrZWxjNlBsUjAwQ1VxWGpZ?=
 =?utf-8?B?MXRoZTV0dW1zdml3Y242K3pwNkRyd3NLVGNqM2N5M01DOU9IZ1RkVHhHWCs5?=
 =?utf-8?B?b3JuZm9HbTBJNkFQbmF0VzMwNE5PL2ZWMng4Y1RJVUtQS2tGMVdmUU9wM2Q3?=
 =?utf-8?B?Y0JjL0pSV1cwUFhHbTdocmZmbG0vMlVBMUZnZjFWL2RhVi9sL2NZdWVpZS96?=
 =?utf-8?B?SG52UktsSHZDTWxnQVVBaTZ2RW9QNWdDNHBoSFNHQ1FBdDVaVzFZN3JFWmNS?=
 =?utf-8?B?c1hGTExvTFZqaDFaaFFnS0grbzhrcmM0QU1Ed0l1WnBiYnZ0Q1hPdUhWSFJh?=
 =?utf-8?B?dU42SzNBSVNWb0h2TVZpY2RKblhMU2JDM004bEtMdHRvc0lvT3QwNm9qTEVs?=
 =?utf-8?B?ZjJETi9EQWw4V2dra2RQMFN1TDhtY3MzV3NyQzNGSllqY0VwbFpaelREbkZL?=
 =?utf-8?B?Qy9PaFZYVE9LNVVTMGtxTFRWZklYc2dyMml1blBHcFVSa3NOV3Nxd21ZSlZR?=
 =?utf-8?B?UUhsQ0F3UFNKalVUY1ZBUmhFeTd4eWZCdTFNWEFxdTVJZ1kxWm1pc2RGR3JF?=
 =?utf-8?Q?Mglsy9FmDIk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2QxTEVNMUtaMlU2RzlvQy9FaTJxMlNLUkZsc1hlTDd6b05YMHdkNldpLzU5?=
 =?utf-8?B?WlZRM0szRUdTVmhtYnU1ZUYwdXJVb2dla2RTVGRYTUdlaFVEUXBTRlRZZ2ZX?=
 =?utf-8?B?T05kK2dQWHJHQ3poYTBYN2kwZG5oUUE0TjI4Ymd5aWdQNXc5ZFJPNlB0Y1k1?=
 =?utf-8?B?eGJZRUJlR1Nmd0pmeHFaNERlaTNzWm1qcXd4WDFGNS82blFUZ1dkWE4va0w2?=
 =?utf-8?B?RkJYczI0OTA1SEREUWI0cmU5V2w4b3FSeFpXNHZQVGo3Y3FvejdBL0E2WU9S?=
 =?utf-8?B?YWQrWlIxc1VDVlVSMEg5VEowdTdiNWFaWVBPRmdiVnpjbDY0VytqYWVSUjZ5?=
 =?utf-8?B?SjdtUThkUER0V3hwakhxWnoySGM5NVFqK1gvbG5IaDh0ZVNpUWNrVzhJQ3R1?=
 =?utf-8?B?a1k3bUpmK0NQSHI5ZDRDV2V5M3BwQTNROUFVNmp1aEFzTXRmSEU3bldOYjE2?=
 =?utf-8?B?dXZzTGdjS1R3RVY2bXdEb2UyOU0wOVE2TE9YbjJFZmdmcjB3WDhkcUp1M3Zh?=
 =?utf-8?B?RU9HWXVnTVFBd0M0czJwUWN6dllSTXg3NGZKcmtkY2JsTzQ3a0NCdk5wTTZC?=
 =?utf-8?B?MkVkYkRna2Q3aUFIYjRUaFlnNEh1WTVJbzA3d2gvTVEvcTlCdjRjbVhEUE5z?=
 =?utf-8?B?a2RmajZaRVZ5elFDZktqVklFeStIRSt0bXBTME41b291dnVkTHQ4NEkyL2Rx?=
 =?utf-8?B?WTAvVHNBMEJHelEzbzcwUHJqL0w1WnMzWEhvSXFJTGt3Tlc1QnJCemZxU3dz?=
 =?utf-8?B?UkRRdjBVckhTZkJSYXM0d2RXZm82K2lqT0RGSjlsaXN4NGplVEY4Y0xmR3VC?=
 =?utf-8?B?QXNKYUpyOU9jYXVkY3lhL2hpc0lFMDZMeFMweWF0bis5VzVnQXQwaWZYNXFv?=
 =?utf-8?B?Nmc3SGRGUDZHSHJwNWxDbDFScWpXMDMxclc5U3NhbmEvRjhCOEhZTHJGdGt6?=
 =?utf-8?B?TGt3LytuRzAxempKUS94d3pFVEVockh6KzRwNzhXYnBGazUvejlXREM5a2V3?=
 =?utf-8?B?M3RWOHpnMHdJSHBxVUU5aXVCeXhvMHlOcC9LUjBXUmllbWd2SEJrUFlnL1BZ?=
 =?utf-8?B?NU9zYm01ZVZJcmJYS21KSTRMd0k4akkvZFJkMExjemhhVnZGV2dTUDdqaDJ4?=
 =?utf-8?B?aWlWa3lsWnRVN0tXajR6NkVSWTN1V2hOYjM2b2tlNzgycGVMd3NMeHFUL2pM?=
 =?utf-8?B?b0dvWUswdXZYUlp3dmV2U2NWTXNtOUxiYzFWZGdiUXkwVkw4aGRMRnF4endu?=
 =?utf-8?B?dWdrSldwdDU1YVFodVpvczJKOXJDQzhvWVNBTmJUcHVIeFYreUVlR1Vxb3ZD?=
 =?utf-8?B?K1pLUkJkbUVVMkJQVFpzWW5WOE1va2IxNjBMWHlBQ0Zwdi9QRmt2YVdnKys3?=
 =?utf-8?B?VzhoM2JudkpNUE5CSUNlNGdTd3VCTHlPWUZ2ODFFUFBYVi8rUlI3OW5iOXNr?=
 =?utf-8?B?K01HN3E1V3JISDBmeCtabzIzcms3VmRvbnFubU5LK3VGWlNXZ0Q2dEhQUmVs?=
 =?utf-8?B?QUdzWU54NmducmZreDBZQkNWTnB5MlY2VCtwK0paUjlEZFFhUHhvaGdLRnZJ?=
 =?utf-8?B?MWJRMFJ4clk5SVJ1RjVZVEtFbGluUGxWK2hGcWhXdmk2RldwZUwxMXhvcnVk?=
 =?utf-8?B?aGxIYkFnQjg3VW8ybW95NDUxNTQwZFA0UDdvMllZT1NlUDkwMzV3ajk1MUY2?=
 =?utf-8?B?TmE3UFdSMzVrRjcvQmJQWGt6aEs4U3ZuNTNqNWVQYm5DZHFxNitxVFlSVDlI?=
 =?utf-8?B?OGtINE03cnJIblJkcVc3dFNuTkx0RzdMN0xtZFpYQ0tQYlhUZkdVUDRVMktD?=
 =?utf-8?B?d2t0cmJKdlBtOXhmdnpVdnlKVktsUmt4M1diYkRvV1kyZXJUTjhYcmpFTEU4?=
 =?utf-8?B?M3VYL3hFbFFNYmxEQkxYTVhKVHFYOTFBS1AxWnZCUG82VHJrTW1qY0Q5aTRU?=
 =?utf-8?B?Nk95NFZuRDZqUDYzQVRJN1Z0UjNSRnphTWlQVjVUWnJMRHVJQk5kZjRYc0x1?=
 =?utf-8?B?eEM4blBvZ3U2dzloSUg4RGxLWGFkSmpSc0xnTitQRE5yVFdxKzNyME1FRExU?=
 =?utf-8?B?a2J0ZVg3NkFJOWtMOFBVY0NzMUc2NWJCWFVPSEpmTklZRWtXZHJNbFVHT3I5?=
 =?utf-8?B?OFFWdU1YcjhsVDlSeDhzUk8rTFh6WVNsR0hLb1pXMWZ2M3dMc1dncmZudWd0?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /Xqi2i3Ccwk4iwggRAN9AMUpAt5DSM6buRwonQ3lU9IuACFGOjiw6aHgZmfetsppn/GiCMc6QUByHvwHeR7ShuvTfBnxmPBBPXR13SYgNi1mCT6eo+n6i8x0uf1Sq+K0SEnGklveXmGiHuPD0KcUmMJgtwcUlT+Nc/OpZ7qk00hhJmc5IwPk+Ou4cIhw4/4xEfMhxtqZlh7cRGgY4WYvE0AX0AwNY4H88dO9NayO8yb8nR7ftNx0GmPS/TDWxAewADPlm9Mgp9pfWVYSyuizqmYTkNnkavGDN6cVUto2OMakODpZyIhH81x7GQia06Rf8PGYWXNSbstJM2xb/Mro+DpZ3rPtmXU6CxdQockpPxTs9Ba4s+6dcgCQIoMcfjR4c4WZxvNkbSzw4dKOaCGM0LbijIYTCaZ9KHZiOMOX5JFdmJJp4G7F5Vy98HQxCniyWzvVnQPZFdjR4M7X79e0k7AWC/h7AXtM6MKjUXw1ds9+W1J8UFhvnpKm+VWFg0R6LhHkhZVI8pGfOoTJaD1ni97r0ZieL/x30w/5VgilgSUrMM7Tev+l1sl7gmr9FgEuNgwTclSxMVWpTCwZpMvRRyk6fktkZspkoViWXaQGjHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533ee5c7-b3ee-44c5-d0c8-08ddd9046121
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 18:24:59.1491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UYHJIrOYbpoy14Q0nOzZIawmavWIjADCAeXRK45h16A+5mp1iO0kasCbEC/bT1U5Qo2KO6m9dpE4SRdygk3+Yi/9Xw7bDVvik7tPM8LFQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110121
X-Proofpoint-ORIG-GUID: aQCrZYcvky6zxw3fOgRzhVGoY7tKcE_W
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689a357e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=L-UniLcwofvayi0KdR0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13600
X-Proofpoint-GUID: aQCrZYcvky6zxw3fOgRzhVGoY7tKcE_W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEyMSBTYWx0ZWRfX/rqSbrVYkfiR
 1IQKdk/vAMgi90SY+e+0vb9m0hjnXhb/WNJhsW1wN9fVIuumqE3pfZDX5rjew79nBxFedLt5Dup
 CK6r+TuuAE93biMmPuSvsr2s7pOkrnJnocS2wtvAZSJSHQ1k07+2XOEbms1SIkAvzd4dKgfJn1F
 NKbNa3U3SPREUx2pKc1uFAt3f8YdRvaECt5m2V6ua2fb7Bfd2vvp2wSxyVwlP/8n1uYLVJIdj+U
 QK0qp07xNsPloXpCun3iyHFmAAxfS9+EDrEf1ExXc3ncUX0cXTe2P0Aoh/Bn+s2QAQP5az6hh8P
 lg3NX0+B8XtPMANZYnjiExdn54UPqzm7jIcv8u3ClKVGo4aVZXvsY2PvgLZFM1M8hVbh+UAAPAx
 SLrauP6H6VTr72rn3akP5W07ZgKPIZAFFth+C6lBpniNmMk5CXqZpfhqN7Lgiaqz6k45X5nz
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/5/2025 3:53 PM, Steven Sistare wrote:
> On 8/5/2025 9:54 AM, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>
>>> Tap and vhost devices can be preserved during cpr-transfer using
>>> traditional live migration methods, wherein the management layer
>>> creates new interfaces for the target and fiddles with 'ip link'
>>> to deactivate the old interface and activate the new.
>>>
>>> However, CPR can simply send the file descriptors to new QEMU,
>>> with no special management actions required.  The user enables
>>> this behavior by specifing '-netdev tap,cpr=on'.  The default
>>> is cpr=off.
>>>
>>> Steve Sistare (8):
>>>    migration: stop vm earlier for cpr
>>>    migration: cpr setup notifier
>>>    vhost: reset vhost devices for cpr
>>>    cpr: delete all fds
>>>    Revert "vhost-backend: remove vhost_kernel_reset_device()"
>>>    tap: common return label
>>>    tap: cpr support
>>>    tap: postload fix for cpr
>>>
>>>   qapi/net.json             |   5 +-
>>>   include/hw/virtio/vhost.h |   1 +
>>>   include/migration/cpr.h   |   3 +-
>>>   include/net/tap.h         |   1 +
>>>   hw/net/virtio-net.c       |  20 +++++++
>>>   hw/vfio/device.c          |   2 +-
>>>   hw/virtio/vhost-backend.c |   6 ++
>>>   hw/virtio/vhost.c         |  32 +++++++++++
>>>   migration/cpr.c           |  24 ++++++--
>>>   migration/migration.c     |  38 ++++++++-----
>>>   net/tap-win32.c           |   5 ++
>>>   net/tap.c                 | 141 +++++++++++++++++++++++++++++++++++-----------
>>>   12 files changed, 223 insertions(+), 55 deletions(-)
>>
>> Hi Steve,
>>
>> Patches 1-2 seem to potentially interact with your arm pending
>> interrupts fix. Do we want them together?
> 
> Good observation, thanks!.  I may need patches 1-2 to completely close
> the dropped interrupt race.  I will do more testing to verify that.

aarch64 does not need patches 1-2 to fix interrupts.
It only relies on MIG_EVENT_PRECOPY_DONE, whose relative ordering is not
affected by patches 1-2.

So, the arm patch gicv3 V3 can be pulled.

I am still looking at patches 1-2 wrt x86 interrupts.

- Steve


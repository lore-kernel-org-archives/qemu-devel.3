Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A36BCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 15:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzd9X-0007fj-6w; Fri, 19 Sep 2025 11:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzd9V-0007fD-Eb
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:36:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzd9N-0004fK-ND
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 11:36:01 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtpDC014680;
 Fri, 19 Sep 2025 15:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=w7lQF2Ers8XjIOrNlHdnH9XwiDkAAhT6NAR6PsUhTKo=; b=
 NMUxZMPLb8P+oU9USLTbDQ2Aai6xHGeoASrxi5iCVBfxhsa3ejZU12FiVWaCXdB2
 JqS3mHP0MEw49z5yszd3pYPAyrn8eetj0cyiUjIXRBFT/wxKEAzsENpmwfsuZG22
 sdu+ZAYsVMi3NJ82anjeO29/XSeMr6O8GDQ2/Bn6X1smiByAE4+5CrhX/qp/vi/P
 ge5jqVE/J/OrFtuKYwvMV4gChc4oTEkD1d3XgXM5XEv1Z4+3xYg0GeYOlHasVLbO
 lal4YVUUF662gGa9IP05spChA96btcRxUhOkHUHNqJmGbf5XD1PrpWEC9+gZkeqS
 3sFrRiUUj73Ny/UsixwuCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbwumv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 15:35:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JEiHx9033703; Fri, 19 Sep 2025 15:35:49 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gj8pc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 15:35:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSJqVS0xvcYlSqmJxt4puPGCHtegYng8uqpB/JxIPkFC0QKcsB+u/yi1X93XfmXmS9ZygmHQcV76ZMnoOuOVNFaiwrsy9mptOsdgqwwtprrzynGQXvZ+qhhSMmdPVWAc6qVIXjAyQHhlY/qqjYj2Uq9yV2IlJHYpBG/MVXQ2r/MnoaUxkwfDg3/l59LeXeuEF0Pgam3ZyTtsja9OKguZf/MAWYPCt7R3tV2VGlz5LafHE/nKk9WHgmLZP22w/WNPpY43DRSpw9u+DGe3+EAEv+EfpDwW5UPCWCxDNB73J1XXfTxASMquCyNmp3M9/AM8OAZ2bMb/Y8NZrqI2QvuYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7lQF2Ers8XjIOrNlHdnH9XwiDkAAhT6NAR6PsUhTKo=;
 b=lrj5ksivqUMqdv5wAvBzhhTkN6kHs6n/NTn2QjrXxjE875484GO6t9AVOEWEmaHg1doIlPbPV2jkicGfrd8KnT0ncb47FIjwGrsKPN0ueicSl1qoovq7p33N5NQi9EEgNu57SvX3HMhaVAH/G3OueEUXRCISt+LLKfVc3NPwxds+2t8T/Z5zlOudlEyEoasQ87cg1OcC1GMSiwall9/qDg/x6uE6WwIk9LjXZTgL9wMHWoB0coXAeybtumk9egNP+g/SiGD3fK56z9VqBCH9oV5t+5xr5Kcu1HFTSdx0tOghGxZBgbJA8N99b15fAK0u2PFdnAko4d/UjlB23LRU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7lQF2Ers8XjIOrNlHdnH9XwiDkAAhT6NAR6PsUhTKo=;
 b=DWol00yUljHM00mM1LqpIhMgMc5nOp9A8W4dJjwxtacowf3M61FwzW9VCIb2eAElY6Hfu7lmHJI5orIFPDgJlp+Ui197Pw7TzdHPaGvSdzLVMu9V/L6J4p2WE43CbC77WmGuS2oCWpfSnHIrhSx/GKOdKqkK1S2Xxvkv3GP88GU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8663.namprd10.prod.outlook.com (2603:10b6:208:571::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Fri, 19 Sep
 2025 15:35:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 15:35:39 +0000
Message-ID: <504a1139-6d43-4174-bb30-ccac80575783@oracle.com>
Date: Fri, 19 Sep 2025 11:35:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 6/9] migration: cpr-exec save and load
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-7-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1755191843-283480-7-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f179b0-4c47-4ebb-fe2a-08ddf7922f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3pBOCtBRUc5UWRxRlR0blF5TzhTQmZSdytRRGZQSjFwdWhqSTJBS0FuK3o5?=
 =?utf-8?B?WUdxQ2F0clBlMG5FemFIenVuQisxNm5DR1VEd3hQTnpNbForR0VWUWpxcWpG?=
 =?utf-8?B?QlBMVUdxOCtlSEJuNmIyRW85N25DNVQrZVRJRG1sQmhyblI5SWJPL1FlRVpW?=
 =?utf-8?B?QmI3OWRVZGZxMDB4Ri9tRjhVaGZjUzlPdmhIaktiWXpxdm9HWlJLQVMyQ0xj?=
 =?utf-8?B?Z3hUUU1OT3U2N0NXQkx3d0VhUXJRTzlkNFJZb2Q3dWFha0F5L3pacHJ1NkIx?=
 =?utf-8?B?cWIrMk5XWlRPbU9zZFRCR3I1ZHgwSDhOTEl2bFZkU1NHR084WlRzT1JmS3p3?=
 =?utf-8?B?LzB5ME5UY3V5VHdMV3BzZnJmTEJNWGZlaitWamtxNFQ3MW5xTWtadDU0R3V3?=
 =?utf-8?B?YTFDVkt5Tll2ZHB4cmhDcm5NOTlKQ2FJN1RKT1V2aGpodVZTR0thdnNSZkpU?=
 =?utf-8?B?UmJ6MzFUQTRjREl0TldHQ2pYWDVsYlBXNDdIa08zZmtRQkFMOHNWbUdnY1Vl?=
 =?utf-8?B?U1F6OFZkcUIxNjlyenRsNVBBRk0vNkpYTU45OCsvelhOalE1dzNCWnpUY2Zm?=
 =?utf-8?B?c0xEd1lZdDR5d1RzRnA1dm9laGFhdE5YWlo2QiszdmdZZy9DLzhGc1RvNlN6?=
 =?utf-8?B?WGxFL2luNWlYQjdXUUM2dktrMVFpd0xqeVp3cDhaUWo3a1V5emNpdkVCbE1s?=
 =?utf-8?B?aFloM1hBb0paNXhuS2gwNnpTdVpaTENHLzIwN3EvbDhDR1FOUjB2eWg0dVZM?=
 =?utf-8?B?RDVyN1p4eG1tQmZ3NFk3T3VnRFljQ25NQ2FvcW8vSlRxYVZSZHlKU3FIVEZF?=
 =?utf-8?B?Ti9Zc3ZYb2V3MWFvZVJ3bmhYK2NMN3pYbGcrZjVSb0poTUtqV2VxdS9WaVBI?=
 =?utf-8?B?U3RZTE4zZGRVRHp5MUpBRzdldEdjL2k1aXFlWTZmZ1pZZnNPbm96N25RRXJ5?=
 =?utf-8?B?US95M1dVNjRhOE1HYyt1UzNZODhzRG1PMmFTYlFydkM5SjFOZWRHMGF5RDFz?=
 =?utf-8?B?VkdMV1RSR2Z1T2E1U3pwZk9ldVcvYTZLOEZadnBka0ZJSUMxdWNycEZDUlBP?=
 =?utf-8?B?TjVQMnIwWVRIQ09kUEptSXJEZ21CaGpqZHRETFFIcFI5S0pSbHI1NHl2Q2Fi?=
 =?utf-8?B?czYrKzBaSGxPbUFnQW1FVUhSYXRHYmRCNHNMTmJqOFNuUE9NTHZBQ1BtSVJI?=
 =?utf-8?B?QmhyY3dOWW90OUlWaDFxZnVHTThMNlRUQVRzSm5TK2EyWlIwTWJaVDZKWm9W?=
 =?utf-8?B?OEo0d2dZT2xLZGVoRS9iL011Ump4MlNZam85d2RsTTZ6MnM0UGh0RlhnOStn?=
 =?utf-8?B?cUgwMHBwbWFKdDZ0bVRGTE40NndSZHp6eTNLMUh3MkJqYnYvTzBqUU9keU1S?=
 =?utf-8?B?Rk9hMUhMK09TdVBmZDVreC9lc3l1NFpsSXljeGc0UTErWGpUUWVIdE9MUmRD?=
 =?utf-8?B?bXZLZTR5UHlIN2ExVzgxK3dkSC9QQ2NmcmpkT0hZWjBPK2x3WmdVNFpMK0hB?=
 =?utf-8?B?YVNWVW5OR1g0TDEzY1FCLzJ6UThlSmlMbnhtalhrODFFbkZoNVhGamI2Y3Az?=
 =?utf-8?B?S1d6eWJPa2srckRIdDZvWVBJNDNOZ2xXTlc4MjdWZzdXbzR1eWN5eVA4b2ds?=
 =?utf-8?B?T0c0bldZVlJ5UXgvbDNjWWFITGRGeWxBR0pkeWxCVElHajhyajB6YWtGQStm?=
 =?utf-8?B?K0ZlZTM0MlJ3ZVppWlgrcTNCWWp4djJ6V2hocGdjRjdmMUN0VWJ2eVhFZDJI?=
 =?utf-8?B?M3A2ZTQ0KzRtN3Z0WFN5STNhdFFtMW5zbkU4cXpxOWZVQkl6UXg4eFdvTHhK?=
 =?utf-8?B?OUZwdDRxWGNCS0J6SFEzV3IwMGszUXZhT1A4OTVIcjN2bXVrTjRvdTQrcFF4?=
 =?utf-8?B?V21uUjREQTI2U2lVQzdCN2hQSi94M2RKTHRDanJqUXZkVUh3UStYY05ESXkr?=
 =?utf-8?Q?OWfbnpjmyoA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGQwYUNsYWJKRmk2M2hHZE5PRXc3T0RtWGVrM0l4STVXK1pBR2FIWE0rdWJM?=
 =?utf-8?B?SWF1Zjl2cDRjZ1NwTjVTQkJlaUNtbE00THRwZ1UwKzNudlMyK09PZloySE9Q?=
 =?utf-8?B?RmFmUnhCZ3NlUThtRXExc2E4U1BNNkoyRHp5QzRoSkk1Sy9UMCtwWTduT0lB?=
 =?utf-8?B?ZG0yOGRZZVdhVksxTEpOczJSUGdvemZMWk5SblBtVTY5MzIzM1VLZHdkbU5m?=
 =?utf-8?B?M1BtR1F5bjFEWThEQjdLQTYvWk1sOGxmYlBDNkF1cU8zT0k3cmlYVXRlb2I3?=
 =?utf-8?B?UWc0Zlo2TXJsOStaWmlxODJsM3BCMjNHNnJ0WVBNblF2MkQzdDRLU3hpTW5W?=
 =?utf-8?B?RkF0WitLcy9uUVkzWkRDSlJ5czkrNTQ2MkFXLzZqaS84Z1laZXJJUmdLWVJx?=
 =?utf-8?B?RTlmZkxxTnZIOWl2V2h2RSthaDVlcmE4bEFaZFZQaldGNzUwdDVPSUN2Snlm?=
 =?utf-8?B?by91Lyt4UXVVMUJ3OGp6NEgvRnRrS0xTNUdEQXZMRG1RYWJFNUYyaFQ0WlJE?=
 =?utf-8?B?aVdMNnZvZFhWSGRuRGhvWjNnNm1BUWZXWWRpUkV1YXBGU1drc2lhNWMwRVFG?=
 =?utf-8?B?M3JIREpINFBVcjVLaTBkK1AzMlBrTE9FV2VhUFlQRXE4eHIxOFQ4TFM5bjhs?=
 =?utf-8?B?R1l3L0lOem5VUWZmYWQ1WWRVdS9aRzhmMmFrN3BQbnhGSEdnZ2wrNmVDcEZw?=
 =?utf-8?B?Qzg2NzZVemkrWS9jUWVrZm14WjN6R2thS3V2WW1LU0NTNDlKYVdMUzYyV1Bj?=
 =?utf-8?B?cHJmTGNjd092dUJDWng4aTFLcHg3UzBUbTk2WW8vM0NXUjJsYVFzV2R2cHRh?=
 =?utf-8?B?T3dCRE5nSXE4Y3huRGxpeWNpZDV3YWJLbG9LNGxWQUtzMUZKcFVZQjEwNDU2?=
 =?utf-8?B?bmdreUZGUm1iM1JtSGlVNE96cC96SHNUaEROR0phSXNIY01lMFUzbEc4aDFs?=
 =?utf-8?B?S2I4NXlSNUVEVWUwak1VSFZyYUwyUThVRGNxK2NPLzZuY3dSR1ZibEgrb3ls?=
 =?utf-8?B?MWNJZG9IUFZ0cldmTnJZWXlkUkNQMkN3R0tKZTFBL3QyZ2FOazA1ZFd6eU92?=
 =?utf-8?B?bGRXZndmUExnNHZjV1JVZFNvTk1WeDRYOE1oNDlWUTErYmF2WU1HOFQ5TDhY?=
 =?utf-8?B?cXhjRDh1Mm1QVzhwalUyaGI4S2VQK0lPRTRobGoyRjFhT0U2aGhNOHljTmRQ?=
 =?utf-8?B?a1JqbFhoQVBLUnF0MkNoUlFZV1ZFUWY5S094YWFETXhJYTlUa3BYc1pJbis5?=
 =?utf-8?B?TVlCWDdtK0pTM0lsM2xPWW9FV0lHTC9OWTFGN1R2UFBvYk5RQzlBTUtyamtD?=
 =?utf-8?B?U215eTJ1Qys3QnRDSDNiWTBuNEdaNTFmS2pVN1g5eWFXanBDc2dtd3NmZ01h?=
 =?utf-8?B?MmdMcnZLSWtGdnRVdWlsVWtpNFJEQlZHUXdraFEwQlVRSHNBdlkvc1k0bFR0?=
 =?utf-8?B?QjBHbENxQUlIaFJOL0ZkUFJXL25kY2VsSHBPMkF3VHBpK2JIQUlETnVKVW9u?=
 =?utf-8?B?M1IwNENQYS8yZUtkbk12NWYzcXhXM0VzSnM3anJaeUxSL2RIUG1GMDZUK3cv?=
 =?utf-8?B?TGNpSDJkU1lvRm5hbU1OL1lMdU42MG9BM3lubXFheEY3ZUczSGRJbEtHT01s?=
 =?utf-8?B?eTRvTWVFb1NwZ2l3bk9ZUmFHUHBUc0hKbjFDdWFIRlRPR1F4VjV6QmIrbU1w?=
 =?utf-8?B?RVJwWklZZDA2b0ZQRHlyYXlnVUVpa0hxb21uRG1HZjJZSUxaQi8xQjNIMGJ0?=
 =?utf-8?B?MGdJMzhHLzFtRDhUSndDTms0Tm9BMkQvMkhLNUtneThWaTE5eDJQOGlUb1hy?=
 =?utf-8?B?dkJjQnMrQ3JwUXpJcEcxTmVZRnd0MUJYZ3gyenZZUHlBMW92ODVZVHk5OG1E?=
 =?utf-8?B?bjBiTDh2dU5rcDN4WGlNZ0NTQnExWTM0b2c2RmdpeENwcy80V2lFYWQrUDA2?=
 =?utf-8?B?U1JjNVRpOHJ0QjVDaEt6YnNxZTdqazYvNWJZSDA0YVEzcU9ZQjdaZ24zd29p?=
 =?utf-8?B?NHR3NWdsVzUydUVzdTJrclErL3JCTUZlc2cvTXhMRzB0dzdveWVqWVFydEI1?=
 =?utf-8?B?Q3NEUUNzREdKTy9LMkpLdXErdXRGUjgzZzNvK1RZTTRZT3R4cnEyNm04cFMv?=
 =?utf-8?B?ZTZkMzBZeHVYcDA3Uk9jTzJHK3hZK0VOcEZNTlU1NnkyOXpVbE5qc0VBcGxs?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +odm559hHqwsQPhsegYmwtJqiBo2qu0x49Sjnb5cSjTTkPmkzI7mGH1VfeyAcZ8z1vGXVfWXr9V8iEgRwRmPdV0sv/g4AwvgoyvxYorTJFY/sGMhv/fRZ+eBTgYxCWizRaahiXb2Pmb5IraqVMKUe0pMbz5qVlRHS/Rrs6HTDYZ1fr4re7DjP3y0PbtmLzQODR4WatL68CGFFnFeAdOJVh36rxmKKGd4UAh6pDdD/t6mlf5QiTel+jnWOGYdBX92qIO/jTfy53XxFOvN5KP4imSOBbhw2q+1/TP2csdaLNbIRxMFbiHvQUXFkKWYvnqojoOayw91OEUF+LEoDvL4bU2PRjWHFmBHhKwoLCaSkZ6Zi0z/FO72XlPBDnIkcxbAcXTWXt1MFWqPaM26FFYYDR3XMIz3M3rLRcvZc1CEPzv88okgnHpOJzF6q4dORkIMfk7cxffLv9QWl9grtOO8AqDrcrA2bdfOmoN4ly4T9bfDdzXjbtLtJi0lnuUfo8RYAM5qUgadkleCyf8PSk6TIQ1LfmEFuslQdUatkeVWdkJ/b9JYYnkyDKob3EtlywE3wHkpeT25Ti9NWAFFhZpx7mSBzHjHOIjwu4dj+A4moqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f179b0-4c47-4ebb-fe2a-08ddf7922f8c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:35:39.4458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOc4cGhOXu9lYiWGhWQBIvUmQbjqWT6OaBToGve/xSk+VSoJDluK11jp4u7YXPYYhc4kUcUjnZ1GhVphFYjUqM9ixx8iuwhF2tI56LJNuic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX8m7gMIXueN9y
 dr6841mAcM0L7AvNZczJRTZx5tE8eFHGltukTAJ1res4qWjZKaPrdV6fRgF608m1Uxw8xNcghyN
 /ohBbF49X6os6dIr2th8RawqEDMgKRE/I5gNct3soXQJ5NBgXE1g+4XNsmZtQ9uZ2SYq6cWgklJ
 EvfhGj89Qz6iQdyXGvKSlLDYD/EF3ttEvHHXyQyLc4rakyJ/LRokldr6Mq3kSZHBiuXGls6cx2G
 OSK803zacmhZWbaODxu34HHKBHXnfzTx5U1nGvg/6rIV+qF4hcbY0w1LkBzZrjdC1/t7yexeIck
 9pP86P4BnVqVayvMJaAlO0TUdYxZhC2bxi+UjMieFnUrPSU4rG3D0CYI2QR4gSrzfAsDvouRfw7
 UWGsDMrV
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cd7855 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=n0hssg-d6tzL8DQcBSkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: c6gg_5Gzrxa13BLU6YoIwcRl1skjqJKx
X-Proofpoint-ORIG-GUID: c6gg_5Gzrxa13BLU6YoIwcRl1skjqJKx
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This still needs review - steve

On 8/14/2025 1:17 PM, Steve Sistare wrote:
> To preserve CPR state across exec, create a QEMUFile based on a memfd, and
> keep the memfd open across exec.  Save the value of the memfd in an
> environment variable so post-exec QEMU can find it.
> 
> These new functions are called in a subsequent patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/migration/cpr.h |  5 +++
>   migration/cpr-exec.c    | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
>   migration/meson.build   |  1 +
>   3 files changed, 100 insertions(+)
>   create mode 100644 migration/cpr-exec.c
> 
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index f4fc5ca..aaeec02 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -54,4 +54,9 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>   
> +QEMUFile *cpr_exec_output(Error **errp);
> +QEMUFile *cpr_exec_input(Error **errp);
> +void cpr_exec_persist_state(QEMUFile *f);
> +bool cpr_exec_has_state(void);
> +void cpr_exec_unpersist_state(void);
>   #endif
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> new file mode 100644
> index 0000000..2c32e9c
> --- /dev/null
> +++ b/migration/cpr-exec.c
> @@ -0,0 +1,94 @@
> +/*
> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qemu/memfd.h"
> +#include "qapi/error.h"
> +#include "io/channel-file.h"
> +#include "io/channel-socket.h"
> +#include "migration/cpr.h"
> +#include "migration/qemu-file.h"
> +#include "migration/misc.h"
> +#include "migration/vmstate.h"
> +#include "system/runstate.h"
> +
> +#define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
> +
> +static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
> +{
> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
> +    qio_channel_set_name(ioc, name);
> +    return qemu_file_new_input(ioc);
> +}
> +
> +static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
> +{
> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
> +    qio_channel_set_name(ioc, name);
> +    return qemu_file_new_output(ioc);
> +}
> +
> +void cpr_exec_persist_state(QEMUFile *f)
> +{
> +    QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
> +    int mfd = dup(fioc->fd);
> +    char val[16];
> +
> +    /* Remember mfd in environment for post-exec load */
> +    qemu_clear_cloexec(mfd);
> +    snprintf(val, sizeof(val), "%d", mfd);
> +    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
> +}
> +
> +static int cpr_exec_find_state(void)
> +{
> +    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
> +    int mfd;
> +
> +    assert(val);
> +    g_unsetenv(CPR_EXEC_STATE_NAME);
> +    assert(!qemu_strtoi(val, NULL, 10, &mfd));
> +    return mfd;
> +}
> +
> +bool cpr_exec_has_state(void)
> +{
> +    return g_getenv(CPR_EXEC_STATE_NAME) != NULL;
> +}
> +
> +void cpr_exec_unpersist_state(void)
> +{
> +    int mfd;
> +    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
> +
> +    g_unsetenv(CPR_EXEC_STATE_NAME);
> +    assert(val);
> +    assert(!qemu_strtoi(val, NULL, 10, &mfd));
> +    close(mfd);
> +}
> +
> +QEMUFile *cpr_exec_output(Error **errp)
> +{
> +    int mfd = memfd_create(CPR_EXEC_STATE_NAME, 0);
> +
> +    if (mfd < 0) {
> +        error_setg_errno(errp, errno, "memfd_create failed");
> +        return NULL;
> +    }
> +
> +    return qemu_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
> +}
> +
> +QEMUFile *cpr_exec_input(Error **errp)
> +{
> +    int mfd = cpr_exec_find_state();
> +
> +    lseek(mfd, 0, SEEK_SET);
> +    return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
> +}
> diff --git a/migration/meson.build b/migration/meson.build
> index 276da3b..6087ccc 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -16,6 +16,7 @@ system_ss.add(files(
>     'channel-block.c',
>     'cpr.c',
>     'cpr-transfer.c',
> +  'cpr-exec.c',
>     'cpu-throttle.c',
>     'dirtyrate.c',
>     'exec.c',



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD21DC02181
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 00:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1talXw-0007Qo-Or; Wed, 22 Jan 2025 19:58:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1talXp-0007QU-Ik
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 19:58:07 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1talXl-00088D-JX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 19:58:05 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N0gWuD029577;
 Thu, 23 Jan 2025 00:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=zuzM68wY0/k7kIvN/6sKftjGjID/lyiBipNgKpoLWaQ=; b=
 gxEX7wy9+4Y5CAkXsY223HXe12ybDEtAyNaLYoPZf7S37EBOoVUv7QvtDh46+WtP
 Up0i9L6O1sxiAuCbFsYfXCgJzyhW1jF8tqVvqjIpzzQpqJYIk+fm8CqG6aJQ2NXX
 +gedCaHVGASgR9ZgW5FWVjP2omRFOT7uGS3gWJFj+5G0YgE430AMVAeo9wrxS/+M
 y4G0RXDxCHw3BMvkQS868Gw2bD+ie6vFyVNuKBeL/AO98mhkT8mOH9VaJWE4AFdx
 uoSfOPMXUNJsLqdi7V79+r65CiJUng5AT+gzZaFpOQtYlAYcQqC7FH2VkkXcTiIs
 8Ysl0GU9FZLym8LQOdDowA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awufsrw9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 00:57:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50MNaeoP005423; Thu, 23 Jan 2025 00:57:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 449196bnhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Jan 2025 00:57:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZavCXOZpA36mpqqhNs/uelGidap8M1ScY8/RGlo5Raa1CZrv8KqpwgtvQnDPfAM+VOAYFIJRtIGXLctlgAvQKVhjJNgNS0p2OCt4MVnnzRQtvd5BJ9c7KyUNYynIAopiw/aLxS3kjUuMO5uWFHYVAVDjMMZgD2kbqu4qFPMMXVporDWQ1qIG2nMtn5CKO2Z0cmHe+rEHiLISCVtiztIJbNqyFJABT6t09tJfdJ8YP6r2Y4vEwIHmW806PNRpLKEcxJyJ89WS6fc1oyME+LG2vaE4nIGs/RhsOW5Q7n9vGvLbu/ePQAtbfAhxiRQkCUAVR3aVzDEgqE6zo/IXinpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuzM68wY0/k7kIvN/6sKftjGjID/lyiBipNgKpoLWaQ=;
 b=yBmn6fCnzlXMK4umJenD5NymxM6EKBspq6EQ8/oW0Tux727oTAmX4J+G1pF6Rfia+q4th3+fwLAwBMjHtTib6IDaEP+L4K0fb1SwOOFi6SUdjGihvA/w8umrhzoe7zR3DcebewMscxcKiWg8lFiEh6a2f/Zr8AyI4k/vDhxVZvX7A0VmP7XRI9CPnpZ5CtRbnJHGQ4OnW9WkzWAoR3yb20I3lJQ+ikUDufD1Qee1YQhCes6OJof6gU+izx8oPfjkUML73xFdXvtfuuJmbIif1MuX2EevfN72Z8/hRRsL70G2yyudMdjNFnfeo3Y8c6iCSDzeEn0LlahG5BMOv/afqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuzM68wY0/k7kIvN/6sKftjGjID/lyiBipNgKpoLWaQ=;
 b=RKkRe2fm9kQSs/SZG7Gwdki5c0wpGH7TB1LV7jIF86gIFQH1Hmw2ZqIb8+dkImBQgP9zKtS/nXas+Nt6afxgnqdqmgby2KcEElGRqIErPUicsTtLx0ic8bN1LDU0t+Qf+x0HW1ItIZkrsr6f4eU1BJWs7oUHo1ZKZ07HUnNXiR4=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM4PR10MB6160.namprd10.prod.outlook.com (2603:10b6:8:bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 00:57:54 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 00:57:53 +0000
Message-ID: <eb9f9e8d-45e6-43d7-a643-7539e552e5c3@oracle.com>
Date: Wed, 22 Jan 2025 16:57:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 4/5] virtio: add in_xlat_addr & out_xlat_addr
 VirtQueueElement members
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 boris.ostrovsky@oracle.com
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-5-jonah.palmer@oracle.com>
 <CAJaqyWfSffrHcMt-EFW9P_jmVjK6v4hf_V_rLrrihTguQNX7Lw@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWfSffrHcMt-EFW9P_jmVjK6v4hf_V_rLrrihTguQNX7Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0337.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM4PR10MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: c42a3e35-4629-4e21-9166-08dd3b48f7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bENUQ3lBV081L1grNEVmSW8vMTZLYkkycndmYUhsa2UvaGN2TkxudDVFNnly?=
 =?utf-8?B?V3hFeE9sTFdWSmhsQk5QdjViclZXcjRFcU1MYXRlSEx6bG11Slc2M3BwNGJs?=
 =?utf-8?B?bjQ2SEV2MDRObURqeXpVeldjdkVwK0N2ZERZV2IwZkc1RTVjYkVxK3FXZHRQ?=
 =?utf-8?B?TjVXVytpZXZxTlU0dHY1Ym9GYzRNRWNKdk1yQW91aVRVMXgwa0hpRWtPRWMx?=
 =?utf-8?B?R2owVy9wYkVqTmJtZFd6V0drUkpXVG5lN0M4RSsxT2lUSUdLMzF1K1ZZMTZ5?=
 =?utf-8?B?c0FiUWtuOEdkQkwrREFjQ1gzL2pNU0VjclZobXZLcCtFRTJ2QjhaRXg5Zm85?=
 =?utf-8?B?RUtxUlNzVU9NbndONCszVHc3aHdRYXBOS3o0enRqNlVGYlZielBLWHo3NG1Q?=
 =?utf-8?B?R0cvN0pEb25zTU1na1BoQ2Q4VWl2V0ZvTGtXZnlVZFA2WW9odTdicU5Pd2NI?=
 =?utf-8?B?SGd4TnVFOUZMV1k5dVFsREdRbzI5Y1RPVk5xcndXZUwzR2todGxRVDcwLzhU?=
 =?utf-8?B?Mm4xb1JQVTJQelJsREZjL1drK3pMcmVtb2E4aG8xa2MraUxsMzJqdnRGOXVW?=
 =?utf-8?B?c0ZSNUIwd2JFRFB4cmkvS09CV3Vkclo5Z3JEMUF6MVVLck5jWTU2RmhpdFNK?=
 =?utf-8?B?OVdoc0U1VEhNcWtnWnhRVWtNenZYNDVzKzJCTGJHdCtUNnBWcU8xYmxCdFdD?=
 =?utf-8?B?NWFQYmM0V1cxQnhUSmlWOU9oRTFnd3NLV1J0eWtRVCtYbFRFZTNIcHhtbUdW?=
 =?utf-8?B?MGNaWFhIUGVGcExxUzZXeTNyaVFNWjExeUJqZU8rV3RwelczMWFxc1gyK05Z?=
 =?utf-8?B?UHdqSzhmempqeTVIS25JZGRJVEpDQWozNUhidnJ5OUIwSnJTQ2lGT3V5c05q?=
 =?utf-8?B?blVYaE82Nkt4SHlYRE9BenRxWThvWWc0eUhTS045NXpQdi91akkrL1FxWDVu?=
 =?utf-8?B?VjkrNUduSWFaUnBNY2F3L05rblQzcHdNNjBram42OTZrcTV0U1VOWEliekJv?=
 =?utf-8?B?YVBlUDRETXBFNG5YaWI4dGJiSkhDbU01L1BoWjdsRWpiMjlHUnYvV2kxTG5j?=
 =?utf-8?B?ZnBveVcveFRaZDkvR0hjbFFValUybjJ2ZzZXb1FEdWh0eG5Wb2VlM1E4S05j?=
 =?utf-8?B?NHhJMkZTNEpNaHA5NVFXSlByZ0UvZ0xQeXNhcFJKQWVtejVUUjZEK2piS2ts?=
 =?utf-8?B?MXR4RVNDTzI2U0RiaGQ3V0YvZ1BHQXZPditDYjBzczBRREt2NW1ERnpZRlRN?=
 =?utf-8?B?SS96dmpEcWdadXpsZ0p1aWdSNnRZWkREMnY3RzRCblpkUTBrQ3hCYmQwbW1W?=
 =?utf-8?B?cmRqdTZIQnJCNTlBUlhSRjN5dk9WWjVEVldiVlFQdXIxM1RRQXZHcG9GNWtE?=
 =?utf-8?B?bHFKMno5QS9kVjRkUWhCOWsybXB1MGR6bm1kTko0OHZva3NyWU5TVTBFMUFp?=
 =?utf-8?B?bnNxSllxYXU4WHRhTkZpVEFPOVFQd0Z1c2F0OGdqNCs5dmluQXZPaTU3UUVw?=
 =?utf-8?B?cDU0aGhZOEpWWkN2R0hTa00xcEtGT0pWMEJUb1R0QjRWZXJUdGQ4d3R6b3JN?=
 =?utf-8?B?WHU5YkVha0FCZkVoVFZnbGlxWkZlbGhvTTQ3U2hrUUhUUFBEWWZWVDQ5cFNY?=
 =?utf-8?B?QnlJTUZGYzhuRURoazd1Z2NkbzcyRmpyb21ZSUpBOW9jc1FxcHhRaFliT0Vx?=
 =?utf-8?B?QWZvZFYvMjg4a1ZQcGRLRTlkS0Y1RVVQNkVvcWJ4YnQ4UUxNZzFRLzZkSlRr?=
 =?utf-8?B?KzllZVBZZ1NZdkxPQ3JDclFNUDNGTWp3SmdmajR0bzBJTHNJK3podWVuVmpR?=
 =?utf-8?B?WDlRbXQ0UE1LSDE5MThCUzhjY2U3MFFqYkNid3BXc09nYjd5NDhrMG5rTkZ4?=
 =?utf-8?Q?0PfQNR1oy4vRY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZkOE9XbjFIQmhuZDduS0g0VkRVNURZTEw2QnFLSjQ2YThzOE12cUlaa1M5?=
 =?utf-8?B?aEVucWRQVkJocnB5MHMxNS9SRTI0enB5VlFOTGlOVUN6Z2N5VDVEZ3JXbTZs?=
 =?utf-8?B?cWc4R0ZnVkNhYUFCL1I5ZHMxOVpPaWxzSi9aV0t4SENDOHh1eVNvL0NZa2dH?=
 =?utf-8?B?eDBLVUIwZHo1bkVka1MveGR6czJCazQzV2drelBvQWpGWDM2U2s3d2dRQmNw?=
 =?utf-8?B?WE83UCttOTAyWnFwZ1BGa2tRekZRZy9HODA2cERrcGw5bkNkbUhQQzFhY094?=
 =?utf-8?B?K1FUU1VHc1B0bTQwUURsdVl6UFhxaktTcWhuVFdhZW03cjlHaXVxMmwrdXB4?=
 =?utf-8?B?U0daUk5PT1NEU3B0NVNaZjlTZEgwM0JPeHNKaXIwZlRsSGNjQVhUTmFwV2Vm?=
 =?utf-8?B?Z1VUcHVHZTV4T2UxT0RPK09yZC9BSWExQlRQMGNTMkcvdExvSGw2cXFjeGNk?=
 =?utf-8?B?WU44MmhtQ2ovcHR6QVg0L3MwWmtjNjF4YTh5eGVIY3gvUytydHJQSDR1dmlt?=
 =?utf-8?B?ZTRlSGI4TDBta1R3ZjlhUEZRQnlmTk9ydUFtc3ZKQXZEL25UMGloUlJoMHZH?=
 =?utf-8?B?V2x4MVpoS0ZpSEorY3ZTeGxaT1J6dnUreEZZUWM2ZGNZc2M3WDQ2VjFzS250?=
 =?utf-8?B?NUdCb09kODlMTEN2SHRGUVlpUkc4TnA5QjFwaThGTiswSDVVemtjSEFqTjJl?=
 =?utf-8?B?a2M2VVAvb2tzTURoaGFGVDJVbDBUUEl4ZjJKVVdXUHd6Qk82S1VYSTM3NHFD?=
 =?utf-8?B?UlZlYVBDcFJzR2k4ZTYrWXRVNFdoUDdrV1ZaTmF0dks3a0RnQmdPS3dhWWtn?=
 =?utf-8?B?WDVMUDZPUVVTUFY1U0lweUs4ekoweitzdFliQ1FYb2FaK0xtaG55TzYwQWQx?=
 =?utf-8?B?QkNQQ2ZMTi9KN3d0aGJwODJSOFJ0Sm04K1pEL3lGV3RlZGJTcEZlVmtsTTVW?=
 =?utf-8?B?YzEzR2NkbFgrdUxaQTIvYU1ycUZ1d0NsSDgzRTBWdEJZRk8vVEY3UkRvbVdV?=
 =?utf-8?B?S3VuOE1DeWZVREFBT0ZzdHJwNmxEVGwxY05CTUtsL1FqelErZUEzdjNGMElj?=
 =?utf-8?B?dDd5cGQ3Mnc3Z1VjUHZOMDYwV1dydWUzTkVFcWl1SDNrSEZKUDhsd0kwK1V5?=
 =?utf-8?B?cklCWWNXV1hia3NqcSt2Vlk2Tjg4eWdBS0hvSEI2YWJydmpSN2lNYUlnS1Uv?=
 =?utf-8?B?M2FCQVFoRkk2SHhqeWpXZHZQa1kvSitPUlFQMVRVTzRnYVhBVHlYNE5Jaktn?=
 =?utf-8?B?SmZGU0wwT2p0clpsR3RkMzMxUXN1WXhFOTBtSHRtcWllSnk2MnRnTEduQnA5?=
 =?utf-8?B?ZFNrNWEvUGtqR3E2VjVWVElaU1RXTFBHbGJnWkdpRGxqVUR4MFgvTzcyOEUw?=
 =?utf-8?B?ZnpjMTZzcHRtc1FCWXNwMkRlNG5KTkx3eFhVa1d4c3FSQnBja2JoODJkWk5m?=
 =?utf-8?B?ZDJhU3A5Q2tJd09FRmo4cE5Gd01xekdVZUlvVUoybTE1bGdxMEc3YXVKNHc5?=
 =?utf-8?B?SWRFaDJiZXlmbHYvRnkyZDhjWkZBRU1yRHl6ZE9Fb0lBTG15eE40OHNPemdp?=
 =?utf-8?B?VjNZM2VBckdzWnp2NVdsM3NIWFhtbk1SMkFIYnI4aXlyeFIzZnNxWUMzNjZD?=
 =?utf-8?B?enFEWC9BSEVTRHBxYWxxMHp6Z3BodVVRbTc2NHJ2d0tITkw3RkZkamM2WmFO?=
 =?utf-8?B?YStKN1pUdWJ1ZlJKbVVtbTFlaE4xMFV5YnRwZEtPOG1RMkc1VXdtRk9KVStq?=
 =?utf-8?B?VVFRN0N4OVpoRUI5dFhSU3FucGV5MlZCYmU1WFE5cnFEMllnTUtXK0FRc0Ja?=
 =?utf-8?B?ajh4c2hNK01Lcm9mSjd4SnFpL1ZPaUFIWjVBbDZRS3J6NHMxY2VxRjV5VFZT?=
 =?utf-8?B?N2ZIeWoyNm4xcUxOUG1xU2czWCsrTmkxaGFMbmpESUVyVXV0U3FRS3VIZG5E?=
 =?utf-8?B?Q0hhazR4TlNhaEg1UFlXbVFhTkh4a0d2NDdwVHAxRjJCVXhhUmFDR0FwWHJv?=
 =?utf-8?B?U0VUSU1LSCtGTUErQW81bUtOVTEwUlV0NUJNZUsrRlkwQkllU2tiTFF6ZXRr?=
 =?utf-8?B?WENKcUhQYVJOc0hwZXVqS2dPVU5NcTZESDRnSGVia1A0Z3c3aW0wNjFjUFRT?=
 =?utf-8?Q?1HigdnMeQxRxmOuxdWiIOOFob?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t9lBobN47pPPz+xBpsDSpoQVwfJ+zjBZG2MZrh9Dv/op4aCHa5OeWmoDaWnbklZF8HHH5gpnxmN6WHOahCcgHXWd452sZZcCPDbR3c/8YoLiCQntLLvcpCaglReKv+jw0/dKZcYBg5DxbPoVFv8edw3CjIVOnG6ClEAm67xsJ1KzB3ZNzyEdpu67Lyr9KDdl5yyhFBa+19uISJ7//sOqdVPSHl7is05PMuWMhWKltOjht8m9G3T0w9AMoQT6TREuKe7PbAtfmmyGCXr9JcnpSV43jd5zOzXHOwbybMcf44w8xmelEmUrsM6St+tnRIPoCA3Lq34Vng2kW0F22VYVxyO8Vpiqo0Gc4oNIkT4+Gu//v6/Ktyu6kdTPEwGDQ/rk404WJ6zKHxSfet0N2Zw6L6rUgfa9PFkKb1NLkwlW0VD2c5JiHL32du8BdYR0hbsSCkZbVD/lrFaI+mPLaprHSau3UcKAKPBmWG9AR2p5UAPXo/jHAAjwLic0W2sOjnM6jjHswR6GhDwhnK6YP7REg+IOIxOFIUJa2ax5PRqmPE3mLScJ8mM+UQtGETXPHEOG/PrkaZ9jISeNo+XC/Zinj4RnM7Ixh6sh1JMIPrr6kXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42a3e35-4629-4e21-9166-08dd3b48f7c0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 00:57:53.9107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YokqMeyBd639WB2f5bRg1j86py9dGI6/O7oWk2md16k02z97GUeIOaGNhXdgT3HnHDMH+n3npWO6NCZj6sayEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_11,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501230004
X-Proofpoint-ORIG-GUID: Uq6TXjJnk1FgKH4zfoXHLoQc-AGd9WLE
X-Proofpoint-GUID: Uq6TXjJnk1FgKH4zfoXHLoQc-AGd9WLE
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
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




On 1/16/2025 11:02 AM, Eugenio Perez Martin wrote:
> On Fri, Jan 10, 2025 at 6:09 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>> Adds the in_xlat_addr & out_xlat_addr hwaddr arrays to the
>> VirtQueueElement struct and introduces an optional GPA output parameter
>> to dma_memory_map().
>>
>> These arrays will store a VirtQueueElement's input/output descriptors'
>> GPA of the mapped memory region, if it's backed by guest memory, via
>> dma_memory_map().
>>
>> The GPA will always correspond 1:1 to the iovec entry when translating
>> addresses between Qemu VAs and SVQ IOVAs in vhost_svq_translate_addr().
>> This helps to avoid extra complicated code in SVQ's
>> vhost_svq_vring_write_descs() function (e.g. splitting up iovec into
>> multiple buffers, not breaking devices using aliased mapping, etc.).
>>
>> Since the translation is only done once inside the DMA API alongside
>> virtqueue_pop(), the cost should be minimal.
>>
> I think this is a very strong change as it touches the dma subsystem.
> Let me try to avoid it on 5/5 :).
This change was what I suggested to Jonah actually, the intent for the 
DMA API change was to lessen the friction of vIOMMU support for Shadow 
VQ (for which case elem->in_addr and elem->out_addr is GIOVA rather than 
GPA). This will be the most efficient and performant way to get the 
needed translation done only once without having to maintain separate 
GPA mapping & translation out of the memory subsystem. I wonder would it 
work to create an variant of dma_memory_map() API while leaving the 
current one as is: the new API variant would return a cookie that is 
used to represent the address translation, such that SVQ subsystem can 
use it later on whenever needed in order to fetch the GIOVA to GPA 
translation in place (the translated GPA address may be cached in the 
opaque cookie) from the memory system?

Regards,
-Siwei

>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/display/virtio-gpu.c     |  5 ++--
>>   hw/hyperv/vmbus.c           |  8 +++---
>>   hw/ide/ahci.c               |  7 +++---
>>   hw/usb/libhw.c              |  2 +-
>>   hw/virtio/virtio.c          | 50 ++++++++++++++++++++++++++-----------
>>   include/hw/pci/pci_device.h |  2 +-
>>   include/hw/virtio/virtio.h  |  2 ++
>>   include/system/dma.h        | 25 ++++++++++++++++++-
>>   system/dma-helpers.c        |  2 +-
>>   9 files changed, 77 insertions(+), 26 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 11a7a85750..afb9a8b69f 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -839,7 +839,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>>               len = l;
>>               map = dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
>>                                    DMA_DIRECTION_TO_DEVICE,
>> -                                 MEMTXATTRS_UNSPECIFIED);
>> +                                 MEMTXATTRS_UNSPECIFIED, NULL);
>>               if (!map) {
>>                   qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
>>                                 " element %d\n", __func__, e);
>> @@ -1258,7 +1258,8 @@ static bool virtio_gpu_load_restore_mapping(VirtIOGPU *g,
>>           hwaddr len = res->iov[i].iov_len;
>>           res->iov[i].iov_base =
>>               dma_memory_map(VIRTIO_DEVICE(g)->dma_as, res->addrs[i], &len,
>> -                           DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
>> +                           DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED,
>> +                           NULL);
>>
>>           if (!res->iov[i].iov_base || len != res->iov[i].iov_len) {
>>               /* Clean up the half-a-mapping we just created... */
>> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
>> index 12a7dc4312..c3308a1bfd 100644
>> --- a/hw/hyperv/vmbus.c
>> +++ b/hw/hyperv/vmbus.c
>> @@ -374,7 +374,7 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
>>               maddr = (iter->gpadl->gfns[idx] << TARGET_PAGE_BITS) | off_in_page;
>>
>>               iter->map = dma_memory_map(iter->as, maddr, &mlen, iter->dir,
>> -                                       MEMTXATTRS_UNSPECIFIED);
>> +                                       MEMTXATTRS_UNSPECIFIED, NULL);
>>               if (mlen != pgleft) {
>>                   dma_memory_unmap(iter->as, iter->map, mlen, iter->dir, 0);
>>                   iter->map = NULL;
>> @@ -492,7 +492,8 @@ int vmbus_map_sgl(VMBusChanReq *req, DMADirection dir, struct iovec *iov,
>>               }
>>
>>               iov[ret_cnt].iov_base = dma_memory_map(sgl->as, a, &l, dir,
>> -                                                   MEMTXATTRS_UNSPECIFIED);
>> +                                                   MEMTXATTRS_UNSPECIFIED,
>> +                                                   NULL);
>>               if (!l) {
>>                   ret = -EFAULT;
>>                   goto err;
>> @@ -568,7 +569,8 @@ static vmbus_ring_buffer *ringbuf_map_hdr(VMBusRingBufCommon *ringbuf)
>>       dma_addr_t mlen = sizeof(*rb);
>>
>>       rb = dma_memory_map(ringbuf->as, ringbuf->rb_addr, &mlen,
>> -                        DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIED);
>> +                        DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIED,
>> +                        NULL);
>>       if (mlen != sizeof(*rb)) {
>>           dma_memory_unmap(ringbuf->as, rb, mlen,
>>                            DMA_DIRECTION_FROM_DEVICE, 0);
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index 1303c21cb7..aeea2dc61d 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -221,7 +221,7 @@ static void map_page(AddressSpace *as, uint8_t **ptr, uint64_t addr,
>>       }
>>
>>       *ptr = dma_memory_map(as, addr, &len, DMA_DIRECTION_FROM_DEVICE,
>> -                          MEMTXATTRS_UNSPECIFIED);
>> +                          MEMTXATTRS_UNSPECIFIED, NULL);
>>       if (len < wanted && *ptr) {
>>           dma_memory_unmap(as, *ptr, len, DMA_DIRECTION_FROM_DEVICE, len);
>>           *ptr = NULL;
>> @@ -928,7 +928,7 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
>>       /* map PRDT */
>>       if (!(prdt = dma_memory_map(ad->hba->as, prdt_addr, &prdt_len,
>>                                   DMA_DIRECTION_TO_DEVICE,
>> -                                MEMTXATTRS_UNSPECIFIED))){
>> +                                MEMTXATTRS_UNSPECIFIED, NULL))) {
>>           trace_ahci_populate_sglist_no_map(ad->hba, ad->port_no);
>>           return -1;
>>       }
>> @@ -1338,7 +1338,8 @@ static void handle_cmd(AHCIState *s, int port, uint8_t slot)
>>       tbl_addr = le64_to_cpu(cmd->tbl_addr);
>>       cmd_len = 0x80;
>>       cmd_fis = dma_memory_map(s->as, tbl_addr, &cmd_len,
>> -                             DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
>> +                             DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED,
>> +                             NULL);
>>       if (!cmd_fis) {
>>           trace_handle_cmd_badfis(s, port);
>>           return;
>> diff --git a/hw/usb/libhw.c b/hw/usb/libhw.c
>> index 4f03ef4ba9..762d70b419 100644
>> --- a/hw/usb/libhw.c
>> +++ b/hw/usb/libhw.c
>> @@ -37,7 +37,7 @@ int usb_packet_map(USBPacket *p, QEMUSGList *sgl)
>>           while (len) {
>>               dma_addr_t xlen = len;
>>               mem = dma_memory_map(sgl->as, base, &xlen, dir,
>> -                                 MEMTXATTRS_UNSPECIFIED);
>> +                                 MEMTXATTRS_UNSPECIFIED, NULL);
>>               if (!mem) {
>>                   goto err;
>>               }
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 85110bce37..be756f3ac8 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -1553,9 +1553,9 @@ int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
>>   }
>>
>>   static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
>> -                               hwaddr *addr, struct iovec *iov,
>> -                               unsigned int max_num_sg, bool is_write,
>> -                               hwaddr pa, size_t sz)
>> +                               hwaddr *addr, hwaddr *xlat_addr,
>> +                               struct iovec *iov, unsigned int max_num_sg,
>> +                               bool is_write, hwaddr pa, size_t sz)
>>   {
>>       bool ok = false;
>>       unsigned num_sg = *p_num_sg;
>> @@ -1579,7 +1579,8 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
>>                                                 is_write ?
>>                                                 DMA_DIRECTION_FROM_DEVICE :
>>                                                 DMA_DIRECTION_TO_DEVICE,
>> -                                              MEMTXATTRS_UNSPECIFIED);
>> +                                              MEMTXATTRS_UNSPECIFIED,
>> +                                              &xlat_addr[num_sg]);
>>           if (!iov[num_sg].iov_base) {
>>               virtio_error(vdev, "virtio: bogus descriptor or out of resources");
>>               goto out;
>> @@ -1618,7 +1619,7 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
>>
>>   static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
>>                                   hwaddr *addr, unsigned int num_sg,
>> -                                bool is_write)
>> +                                hwaddr *xlat_addr, bool is_write)
>>   {
>>       unsigned int i;
>>       hwaddr len;
>> @@ -1629,7 +1630,8 @@ static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
>>                                           addr[i], &len, is_write ?
>>                                           DMA_DIRECTION_FROM_DEVICE :
>>                                           DMA_DIRECTION_TO_DEVICE,
>> -                                        MEMTXATTRS_UNSPECIFIED);
>> +                                        MEMTXATTRS_UNSPECIFIED,
>> +                                        &xlat_addr[i]);
>>           if (!sg[i].iov_base) {
>>               error_report("virtio: error trying to map MMIO memory");
>>               exit(1);
>> @@ -1643,9 +1645,10 @@ static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
>>
>>   void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
>>   {
>> -    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num, true);
>> +    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, elem->in_num,
>> +                        elem->in_xlat_addr, true);
>>       virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, elem->out_num,
>> -                                                                        false);
>> +                        elem->out_xlat_addr, false);
>>   }
>>
>>   static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_num)
>> @@ -1654,7 +1657,14 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
>>       size_t in_addr_ofs = QEMU_ALIGN_UP(sz, __alignof__(elem->in_addr[0]));
>>       size_t out_addr_ofs = in_addr_ofs + in_num * sizeof(elem->in_addr[0]);
>>       size_t out_addr_end = out_addr_ofs + out_num * sizeof(elem->out_addr[0]);
>> -    size_t in_sg_ofs = QEMU_ALIGN_UP(out_addr_end, __alignof__(elem->in_sg[0]));
>> +    size_t in_xlat_addr_ofs =
>> +        QEMU_ALIGN_UP(out_addr_end, __alignof__(elem->in_xlat_addr[0]));
>> +    size_t out_xlat_addr_ofs = in_xlat_addr_ofs + in_num *
>> +                               sizeof(elem->in_xlat_addr[0]);
>> +    size_t out_xlat_addr_end = out_xlat_addr_ofs + out_num *
>> +                               sizeof(elem->out_xlat_addr[0]);
>> +    size_t in_sg_ofs =
>> +        QEMU_ALIGN_UP(out_xlat_addr_end, __alignof__(elem->in_sg[0]));
>>       size_t out_sg_ofs = in_sg_ofs + in_num * sizeof(elem->in_sg[0]);
>>       size_t out_sg_end = out_sg_ofs + out_num * sizeof(elem->out_sg[0]);
>>
>> @@ -1665,6 +1675,8 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
>>       elem->in_num = in_num;
>>       elem->in_addr = (void *)elem + in_addr_ofs;
>>       elem->out_addr = (void *)elem + out_addr_ofs;
>> +    elem->in_xlat_addr = (void *)elem + in_xlat_addr_ofs;
>> +    elem->out_xlat_addr = (void *)elem + out_xlat_addr_ofs;
>>       elem->in_sg = (void *)elem + in_sg_ofs;
>>       elem->out_sg = (void *)elem + out_sg_ofs;
>>       return elem;
>> @@ -1681,6 +1693,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>>       VirtQueueElement *elem = NULL;
>>       unsigned out_num, in_num, elem_entries;
>>       hwaddr addr[VIRTQUEUE_MAX_SIZE];
>> +    hwaddr xlat_addr[VIRTQUEUE_MAX_SIZE];
>>       struct iovec iov[VIRTQUEUE_MAX_SIZE];
>>       VRingDesc desc;
>>       int rc;
>> @@ -1754,7 +1767,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>>
>>           if (desc.flags & VRING_DESC_F_WRITE) {
>>               map_ok = virtqueue_map_desc(vdev, &in_num, addr + out_num,
>> -                                        iov + out_num,
>> +                                        xlat_addr + out_num, iov + out_num,
>>                                           VIRTQUEUE_MAX_SIZE - out_num, true,
>>                                           desc.addr, desc.len);
>>           } else {
>> @@ -1762,8 +1775,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>>                   virtio_error(vdev, "Incorrect order for descriptors");
>>                   goto err_undo_map;
>>               }
>> -            map_ok = virtqueue_map_desc(vdev, &out_num, addr, iov,
>> -                                        VIRTQUEUE_MAX_SIZE, false,
>> +            map_ok = virtqueue_map_desc(vdev, &out_num, addr, xlat_addr,
>> +                                        iov, VIRTQUEUE_MAX_SIZE, false,
>>                                           desc.addr, desc.len);
>>           }
>>           if (!map_ok) {
>> @@ -1790,10 +1803,12 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
>>       for (i = 0; i < out_num; i++) {
>>           elem->out_addr[i] = addr[i];
>>           elem->out_sg[i] = iov[i];
>> +        elem->out_xlat_addr[i] = xlat_addr[i];
>>       }
>>       for (i = 0; i < in_num; i++) {
>>           elem->in_addr[i] = addr[out_num + i];
>>           elem->in_sg[i] = iov[out_num + i];
>> +        elem->in_xlat_addr[i] = xlat_addr[out_num + i];
>>       }
>>
>>       if (virtio_vdev_has_feature(vdev, VIRTIO_F_IN_ORDER)) {
>> @@ -1827,6 +1842,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
>>       VirtQueueElement *elem = NULL;
>>       unsigned out_num, in_num, elem_entries;
>>       hwaddr addr[VIRTQUEUE_MAX_SIZE];
>> +    hwaddr xlat_addr[VIRTQUEUE_MAX_SIZE];
>>       struct iovec iov[VIRTQUEUE_MAX_SIZE];
>>       VRingPackedDesc desc;
>>       uint16_t id;
>> @@ -1891,7 +1907,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
>>
>>           if (desc.flags & VRING_DESC_F_WRITE) {
>>               map_ok = virtqueue_map_desc(vdev, &in_num, addr + out_num,
>> -                                        iov + out_num,
>> +                                        xlat_addr + out_num, iov + out_num,
>>                                           VIRTQUEUE_MAX_SIZE - out_num, true,
>>                                           desc.addr, desc.len);
>>           } else {
>> @@ -1899,7 +1915,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
>>                   virtio_error(vdev, "Incorrect order for descriptors");
>>                   goto err_undo_map;
>>               }
>> -            map_ok = virtqueue_map_desc(vdev, &out_num, addr, iov,
>> +            map_ok = virtqueue_map_desc(vdev, &out_num, addr, xlat_addr, iov,
>>                                           VIRTQUEUE_MAX_SIZE, false,
>>                                           desc.addr, desc.len);
>>           }
>> @@ -1928,10 +1944,12 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
>>       for (i = 0; i < out_num; i++) {
>>           elem->out_addr[i] = addr[i];
>>           elem->out_sg[i] = iov[i];
>> +        elem->out_xlat_addr[i] = xlat_addr[i];
>>       }
>>       for (i = 0; i < in_num; i++) {
>>           elem->in_addr[i] = addr[out_num + i];
>>           elem->in_sg[i] = iov[out_num + i];
>> +        elem->in_xlat_addr[i] = xlat_addr[out_num + i];
>>       }
>>
>>       elem->index = id;
>> @@ -2117,10 +2135,14 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
>>       elem->index = data.index;
>>
>>       for (i = 0; i < elem->in_num; i++) {
>> +        /* xlat_addr is overwritten by virtqueue_map */
>> +        elem->in_xlat_addr[i] = 0;
>>           elem->in_addr[i] = data.in_addr[i];
>>       }
>>
>>       for (i = 0; i < elem->out_num; i++) {
>> +        /* xlat_addr is overwritten by virtqueue_map */
>> +        elem->out_xlat_addr[i] = 0;
>>           elem->out_addr[i] = data.out_addr[i];
>>       }
>>
>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>> index 8eaf0d58bb..e2bb453dcc 100644
>> --- a/include/hw/pci/pci_device.h
>> +++ b/include/hw/pci/pci_device.h
>> @@ -328,7 +328,7 @@ static inline void *pci_dma_map(PCIDevice *dev, dma_addr_t addr,
>>                                   dma_addr_t *plen, DMADirection dir)
>>   {
>>       return dma_memory_map(pci_get_address_space(dev), addr, plen, dir,
>> -                          MEMTXATTRS_UNSPECIFIED);
>> +                          MEMTXATTRS_UNSPECIFIED, NULL);
>>   }
>>
>>   static inline void pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len,
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 6386910280..e822aafd91 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -75,6 +75,8 @@ typedef struct VirtQueueElement
>>       hwaddr *out_addr;
>>       struct iovec *in_sg;
>>       struct iovec *out_sg;
>> +    hwaddr *in_xlat_addr;
>> +    hwaddr *out_xlat_addr;
>>   } VirtQueueElement;
>>
>>   #define VIRTIO_QUEUE_MAX 1024
>> diff --git a/include/system/dma.h b/include/system/dma.h
>> index 5a49a30628..b5d4c07452 100644
>> --- a/include/system/dma.h
>> +++ b/include/system/dma.h
>> @@ -12,6 +12,7 @@
>>
>>   #include "exec/memory.h"
>>   #include "exec/address-spaces.h"
>> +#include "exec/ramblock.h"
>>   #include "block/block.h"
>>   #include "block/accounting.h"
>>
>> @@ -201,10 +202,12 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
>>    * @len: pointer to length of buffer; updated on return
>>    * @dir: indicates the transfer direction
>>    * @attrs: memory attributes
>> + * @guest_addr: optional output for GPA
>>    */
>>   static inline void *dma_memory_map(AddressSpace *as,
>>                                      dma_addr_t addr, dma_addr_t *len,
>> -                                   DMADirection dir, MemTxAttrs attrs)
>> +                                   DMADirection dir, MemTxAttrs attrs,
>> +                                   hwaddr *guest_addr)
>>   {
>>       hwaddr xlen = *len;
>>       void *p;
>> @@ -212,6 +215,26 @@ static inline void *dma_memory_map(AddressSpace *as,
>>       p = address_space_map(as, addr, &xlen, dir == DMA_DIRECTION_FROM_DEVICE,
>>                             attrs);
>>       *len = xlen;
>> +
>> +    /* Attempt to find a backing GPA for this HVA */
>> +    if (guest_addr) {
>> +        if (p) {
>> +            RAMBlock *rb;
>> +            ram_addr_t offset;
>> +
>> +            rb = qemu_ram_block_from_host(p, false, &offset);
>> +            if (rb) {
>> +                /* HVA corresponds to guest memory */
>> +                *guest_addr = rb->offset + offset;
>> +            } else {
>> +                /* HVA doesn't correspond to guest memory */
>> +                *guest_addr = 0;
>> +            }
>> +        } else {
>> +            /* Mapping failed */
>> +            *guest_addr = 0;
>> +        }
>> +    }
>>       return p;
>>   }
>>
>> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
>> index f6403242f5..a6d2352c0f 100644
>> --- a/system/dma-helpers.c
>> +++ b/system/dma-helpers.c
>> @@ -135,7 +135,7 @@ static void dma_blk_cb(void *opaque, int ret)
>>           cur_addr = dbs->sg->sg[dbs->sg_cur_index].base + dbs->sg_cur_byte;
>>           cur_len = dbs->sg->sg[dbs->sg_cur_index].len - dbs->sg_cur_byte;
>>           mem = dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir,
>> -                             MEMTXATTRS_UNSPECIFIED);
>> +                             MEMTXATTRS_UNSPECIFIED, NULL);
>>           /*
>>            * Make reads deterministic in icount mode. Windows sometimes issues
>>            * disk read requests with overlapping SGs. It leads
>> --
>> 2.43.5
>>



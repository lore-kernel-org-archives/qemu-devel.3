Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FB6C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 14:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHklu-00069e-UM; Wed, 21 May 2025 10:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uHklr-00069K-2V
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:50:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uHklo-0006di-63
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:50:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LEnRWQ032200;
 Wed, 21 May 2025 14:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=MB4qbiCazQrobVBlzAsr8SLA/dsXhfahZD4F8KT6fr4=; b=
 Fe477YmSl22dhzD5ejkg5hZsWYih+gWtyzGzsk8LAkbPaeRB/S7hzfwiOqDKNylH
 /re3Pp9ENmUSgm9LOPC4XHkD0xFkn8ikC69973U9gbGxzypvXYjPevJTtgJmISFZ
 Hn59kCCdqRFpYLVZchyu3Nk32aRi9NLrpgG0zzFoSIRR8V47taRTV/ykDv9o4tAT
 052Lx0hx87BkMDU2cQCVpo4vPYOYawg7WJ0aFyeuD2Ykn4gGwq+MkuUy9d0kDVuo
 q/w1Zxivv2GLj0Jiph4O9sSyxDvXO2AA+HTnl8lS3gQ1uR9oJ80BKAwqXIodUvIn
 HkAJR/D9JZvpku7DDW/PbA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sgnpr2db-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 14:50:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54LE2Onq032061; Wed, 21 May 2025 14:50:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwemf7gp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 14:50:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA/y7YdI+/vyoBL+HNBjrlIL5q+ZmB7nvCK3GFvmYkhNfOqR8QUBoVigGcqkCW0cPpY/NzVqtkk7Fe/d0vwRbjWQz+G4XuCqeG/2QzsnTD5KAm3Y6lBuq1fcRtU8LOH2R+gCUMLUhX39PXoyui/DBly4/3RQ58rA33cPwAIq3lqxaEDhaIGTN4cJfCfJJ/ZAQhBdBDKpVL5PpITIJi9rafjPWUlLnQkQ+UOibXaUVgHjCkpgr0bAqAQermTQ0DpzBQ4Ttr1ti/hX8qve3a0KsJKJ117ex+iR8f3axc2Ig1ub3FrMSQoshvd9xw2QE0QpeAunkCQ1JPld5MIn3+LuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB4qbiCazQrobVBlzAsr8SLA/dsXhfahZD4F8KT6fr4=;
 b=qXfOh5DwKAe2+lzx9qbTw8LZAW0uvv/V0is1y0EYJ+L9OJJ28ykUtTvjDpRbcWO9qR91cG3yB0yWj5z1Ni3iazcmJuw4MsnlJRMuVO7+hYmEBRrPK6fk4UjuC0s2dGOBZq6zfbIvpPc4RSrGYN0pTf7ImziTK0JWW7MxpvmNmWFG3+6oxEj1r475aGOLaItrtM3+/cBF/bdmMViPG/VEFmgPIh+oYyE5Zi5amFQcHLiMTDeN//dl0vr2r7IEJ45opQ16+BShvty0yJvDx2N67E7HX3kJw06/7gXPlOv/MTtvT+/Isf2F4bxkDVZQxAa2HvYpKKE14RcFz3Ibv5sqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB4qbiCazQrobVBlzAsr8SLA/dsXhfahZD4F8KT6fr4=;
 b=joGov/a3JXJdcQHH+rmreQ6rQm8iLPA+h4rw5/rtgi7zQxO4p9PaMe+gOJjHdFMlkl++LVU63jUfKoxC/sw1mznyizD1D66NaLPubIIZ8arB4CFVUZMUc1JJyRU/HQvHaVCfTyZ5b4hzxjJ9e2+B+OTaYXZhUFeZheD16JPumWE=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SJ0PR10MB5768.namprd10.prod.outlook.com (2603:10b6:a03:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 14:50:01 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 14:50:00 +0000
Message-ID: <fe4c0209-ae9f-4353-8ebd-8e0d6d251b2f@oracle.com>
Date: Wed, 21 May 2025 10:49:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/20] amd_iommu: Add helper function to extract the DTE
To: Ethan MILON <ethan.milon@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-6-alejandro.j.jimenez@oracle.com>
 <8e6cdfc0-2c6d-4785-ae49-d0b108e48923@eviden.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <8e6cdfc0-2c6d-4785-ae49-d0b108e48923@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SJ0PR10MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb86dd8-3735-4f04-5264-08dd9876c2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MU1FeHI3N2FQOWRJS2lvZVdMRWZEeGNNNG5tU0FYYmkrZVE0dDJGZXNnbk5m?=
 =?utf-8?B?VU9UMzJQdFd3ZGZNRGpqMS90cFNlb2tZU3lmWEtGY1BkZUZla2gxMjdDcHFJ?=
 =?utf-8?B?WENJZ3FXUzFiWXllajJpakl4QVJoM3NqWEErREdISFExQ3RDcGF4Y21uZXBG?=
 =?utf-8?B?dTZPMjRORE9SWjNUYkhaVW1GUVpBSmtYRnFnRy9wVldNc2dDYVhlSDE3RkQ3?=
 =?utf-8?B?V2FWUS9nM2djc0NwU1VkVkZxUjlvZjVNYlhLTWhKeXVKRC9zczVLdXJ6dnQ2?=
 =?utf-8?B?MVVrZ2djT2VBeFFxak9ZL2t4TkJJMU53NUhxa0JFSnlTcjFXdjhnZC9RQ01U?=
 =?utf-8?B?S2I3UHl6S2hzazJZYlVIcWh1bEVIOXhWVG5hc3ZuclFzVGp5Y1graXFiR1hz?=
 =?utf-8?B?UUFtaUZMeWFTRE5nNWM0U1h0YWVySERlWUVPTlJiN0VkNVNkMFJQUXhUOUdz?=
 =?utf-8?B?d1hxdmEvU3p4TDVOSmc0TTdUbmlvZ1pEb3luUHlmaWZZVll5WDVYMVZwMVZM?=
 =?utf-8?B?N0F6dlF3aXVqRXFPR0ZkQXFyL0g0S3gwYm5qank2a2hEZytkV21aV3RqL0ZL?=
 =?utf-8?B?TVBsV3BaZnJnYUhqWGY2RjdMUS9MbTBmdFRLL0JlcTFLR1FXYTlPdFQrTVJo?=
 =?utf-8?B?eFVINVdYWmllUDcyTGQvRk5lQ21mQUZueURpUUczaHp0c2x3QnBqYjU3Q2tu?=
 =?utf-8?B?L2QxOHM0ZlAvOGhKR2MySGMwbUtxZk5HWktHZFJ5RzBPVTRWM3l0VFZxSk9v?=
 =?utf-8?B?dmdVWkZHY1pjeFVkY0tSd1d4N09oM0xPL0tENmNkT1RSMHZVRDhMeldXME5s?=
 =?utf-8?B?WDZzeHgycUJYUG5WdFFxUEhUZ0NmY1JPekJ2TEoxMWNOSUNCdlZRSVc0R1Jw?=
 =?utf-8?B?djU4KzVHa1hsbnB5ZVp0dlhCS25xSkRacTZzOXhkSG5QQ3NlalJFVkJ5Qko4?=
 =?utf-8?B?VDRxS3NpeHEvQ1l0K21tcjQ1RHlYeVBLN2ZIZ0xrb2pXTWt4K0F1RktTKzE3?=
 =?utf-8?B?RHFXUDNqUzhLMzRuekRmYVJTYUs0ZitZUjdWK0tBTksvZnM4VUdFZzR6b2lm?=
 =?utf-8?B?MDRjdm9oK1pac0t3SnIzb0RmTTRhN2U2N3liOFRaU2Z0RS93V3lyM2VTOERr?=
 =?utf-8?B?WGIvNllHVzhZek8zQzdxb1duVWt0K1BvRjQzM0luWUZ5Uitzblc5OXc3TjVn?=
 =?utf-8?B?Y2ZhN2M3Vm1MNWVKSjZmZEdYNXlySzR6aG1IUC9rZURXSEVrOFRxQTlDeG5W?=
 =?utf-8?B?T3pQSW9jWGdKNDdNYnJycHB4WHF1akZqWWh3US9BcHIzREc2bTlDNHNZMmFV?=
 =?utf-8?B?T3orR2VnYmdaSTRMU2k4OEloaDQ4aWUzQXB6UzRpc29SNmNGa3VhbFlnM0JD?=
 =?utf-8?B?OVV4S2svdFpyRGtLNjNqZnk4S2lzNncxRXlDSWRkR25hQUtNb0kzd044cUVx?=
 =?utf-8?B?eGdqMjRUcEpJeUl4NlZHdEM4SVdmVWRaVTVZYjRyRlhFU0VMM1pQc1hkQWpO?=
 =?utf-8?B?YTMwNnVub0t1NUprRkV4VExtTkVCWUNoTVdhNWhOUDhlYjE0WWVWMUUyU1FX?=
 =?utf-8?B?aFNLUDUvNWRFTlRjNW5CeGh3UGxQTUZ3YWUvY0E4ei83WmJUQkRuRkVmM1Zs?=
 =?utf-8?B?VCtabXVVZ2s4TTF3dnh1N05ieTlVaFBHTE02TlFxLzIvUW1oOGljTXpxd0po?=
 =?utf-8?B?S291TDNmM3dXTFZGUkRlTVdNUWJDWFJlbGgrbmhYU2F5UGkzWWpMcmZ3bzJN?=
 =?utf-8?B?eFIrMU9pQ0RhUWpzVWFxcUswbFlJbVVDVXNxNGNOUFNNdFJQTjdDT2h0RkZy?=
 =?utf-8?B?VTV6VVRGNkNSVkRjNWwvVFVZV2lyekZpN0pVY3VWOXJoN2pIWmZ1L0ZPbFlB?=
 =?utf-8?B?ci9UYmxjei94RTNFY2p1bWFJQUNxVmUvV3JUZzd0SDQvTzlaSDFUaEMxOWov?=
 =?utf-8?Q?bfjqH0gioGQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW91N2RnSmc0dmpxaFIwODhzdnZHRUVpajNwS1VLUzJuNlZ2MlUxRXJudkJs?=
 =?utf-8?B?WTRFbXdXaTdkZE5mWEY4azRWbFNjU2xtR2lkTFJ5VjNXYkovU0lKUUN0WkJp?=
 =?utf-8?B?RTdrMnFCdVJrZjBrdTNPYWlydG92RHR3NWlnRVczQXpVMVdqTjJuTmozOVN2?=
 =?utf-8?B?N3RwYWtuaHpqa2R4TnpLbTR1WWdIVXNuTFBvS3E1WUh0OEU5M2dUKzg0ZC9j?=
 =?utf-8?B?OFV4Z3NMVlB6YUdxWWU5ajJKcW41UUtOa2ZyWHBCbEpjK0oxdkZpakhLeGNZ?=
 =?utf-8?B?VkoreDVCYlFDS2VTOUZEdkpoTW01VVkyOTA5b2pHUTlJMklxSTgwREZrMk9T?=
 =?utf-8?B?WnMwYmZuMkI3NUc2V3NFaXN2QXhDbytOQjJpbllZeW00b1lQKzNlclhidmtB?=
 =?utf-8?B?c2VTQi9CenpUV00yakpVWVVtK0EvVCswZjF4dzBqOGRIcWYvREFNQlVmQlJp?=
 =?utf-8?B?cnhqN1Rwd3lBREltTVg3czllNDk5b3dyeWZ6Nm9NQjdiMXVab3BBcFBXM3gr?=
 =?utf-8?B?SGpjL3ZHTmFYMkttYzJ0MWFhNzFEM0NBMURCRVAzR2p6b204ZmV1UUUxKzU0?=
 =?utf-8?B?WHlER3ZobC9HNnROREdMRzNMR2QzZ0VLSFcwZlB5QUozRW1qQWFGaXNubTRw?=
 =?utf-8?B?a0w3YWdxMzJodWpRQS84SEMzTHJVNEd5djVQYTBYZDdkYVArdnJpNjgzekJS?=
 =?utf-8?B?Qjlhb0pWelZieGJGZmF0THpoM212NmV3MGU1YU5kNmlXSEJFZU82aVRnYVVM?=
 =?utf-8?B?bmRGaUlzN0F5NUpVT0M2V3h0VGhJdW1mWHpZZ3lqRmJjSEJZR1MwT0FBL25k?=
 =?utf-8?B?Qyt6b1BHWEtDZkxZR05EUHpFK1ZISUdoMzBzeEdGSHBFMHRNbVdzaVFaSGNy?=
 =?utf-8?B?YUNsajBKRXpuUmFuZXR3bitTVGcrNXBuai9wcmJlVTdvYzM3dTEwWjhxSmc1?=
 =?utf-8?B?ZGNuOExzc0R4Z1lrQmt5UVRlcitxMXlyTlFmYTJkWVp3bW9jdzRjRktpR0Z2?=
 =?utf-8?B?bGVTcVJmSDdiWjk4a0RoZEt3aVNuZkdlZEczakFNLzRGVmFiTmZnQVlpa2tp?=
 =?utf-8?B?NnE3RjVHT1RwZGVPc0ZYbERQQlo4cnBaSGhRUzFOY2pEd2NSY0h1QVRQTkFn?=
 =?utf-8?B?K0xrcEtTbmVzenJTQUJaaGg2VzBPR0NHL1lxeitVVWNROW1TZHNUZVdVOU4x?=
 =?utf-8?B?NjUyMTJlbnFkQXlKRC8zR1k1U29McUgvZjlkSGVDRmFrUzVDNnYzZ0czcGVr?=
 =?utf-8?B?U25SbmM4Ni9UREtjMzV6cllNTHdxVUhBZ1V1ZmtNalJ6TndqZ0tZeGg3UGhu?=
 =?utf-8?B?MUJEdEZYMVpPSmIyUy8zNlF5eTRySnlKN0FUcm45WVZQUTNlN2NkNmsyMHp3?=
 =?utf-8?B?MWloK01UL0NWVXdxdGRXSGljV1JhOEh4ajMwVFY4Z2tvdnFTUXhxTEx4ekVo?=
 =?utf-8?B?OVNKNzI3emJWalBJWkdsdWZYMEFHdldZNVNzZEduTUNZWVhFMWZLVHg5dlBp?=
 =?utf-8?B?SVdzUzR5UWVROUpnZTlKMi8zRlNkTldTQmFBdGFSbHRMZ1NraUpQSFBjTzdH?=
 =?utf-8?B?amxlYmRuR1kvSW1ZNXZHVjNZdXlUZmVsVGhSTVpuSE80YkVwaG1wbi9wdCtY?=
 =?utf-8?B?MXNlTzk1NTdvaUFJSmZjNGNlM004TGt5ck9yU2JTQXVJQVIrdURQMjhvS3lZ?=
 =?utf-8?B?dGdvbzM5M1daVFhrR0Uwb3NNcm5UbEdZNWg5NG54TEZmcitIMGRXY0ZyYTlu?=
 =?utf-8?B?TmJnZzFJVHVVbnFSdjIyYzJUNFg4ZS91N3ZCTWt2THBzK2JqMmh0bTFydlR4?=
 =?utf-8?B?R040YWxwVTBKK0ZQWHU3aEJnVGN3eGRZY3I3cGRKa3BsWmFITGdRNFVlNGNW?=
 =?utf-8?B?Rmp2RjFDd2xaTkhFWUh3OTYydjBLQmU5MEJ1bXAwWFA0YWNZN20xdnQwT21X?=
 =?utf-8?B?dkd0YlY1UVRuU2QxY1oyZUdwMm9lMXcxTW0zNWxSN1BRdG5VTTJtMkt3bWs4?=
 =?utf-8?B?b2x2Ny9EV0x0Vm4yUWRFZnZETXRmN1NTVEtpdlRaMXpjMlVHNzZpZFdiNWtz?=
 =?utf-8?B?OVNXcVZFWWNUUFk0RFhhczVsVTBvRVNqS0xNTUVPT1hIYjBGNnQ2SEJJa0ZY?=
 =?utf-8?B?Q1VqanlGZGFrOFo0WjRoTG5ZQ2V4M3ByWDJNeHdOY2VBeUhtVXhPRkR0dFBP?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8/iLnCePQxFKmGJaQHVkZR2a77sO8SpUVAI/nXn4wIezf7jqRWzyJwERSR60CxXDv4sJ2BvZFkNMvYR01sPNLJ5E4IKRMvl0Oodv5miHGs+KNswPL7DKL2kur5HVbLonGGJrI2KP35Z41Ch8en+3bRROMIC3ggfgKADZbOtQf5kGhXYddbHFJJ8IMt9D4vHvry4NvsO/qDntGgwLLZKlSpWwNWKaILpilak1tOdltIPTjq68ByHuzsH3WNt7+NsTRikFxNDAo7zITg+pOsmD8msZ8nf3p9B4UWPdypvynm7x+JNS7UOpvDGQnoww32kjUq52YC+Uv/fNTuULIdsU/CmUYrsMRNIGzfA3YxOEUWkTQ4NjhVwwtRn671kY1BsPEcC2NqsK19lfpSQEC+3o9k7NT/Zz7Sc0N26DE6oQGTHkyEjh9cP5dI2AjeZKzP60y8GEMRD4sK0rpVKvZhLRwAZjcNLxq6xd6+iCdXcP013oQVINeHiXSXVTub2N75aaxg/GgLGOmdhevbioClCro0y9Vj4PeiST/s8lq0LMyT/+PbzdHJ3ty0bRYl5aDILKcZsazrCjFIS+CI5xFlFpQOLvQo3XKni7M/vLqsfvaF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb86dd8-3735-4f04-5264-08dd9876c2f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:50:00.3475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re+PaYd8UpcTsY8ttQu93SftuaIP/owF7fLJWGpDBoCnncz2uuYR7kSFX1XRFizgAkOXbiKZl45dfhlIHxgr49v6ngwlOVfdO9ZoZIFSaKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE0NCBTYWx0ZWRfX967gRSaYWAkG
 vp5VHjxFa//8KoJWXlwffvDOELh1zvWg5xzrLsnF8jJLd3k7RsM7zV3U2XgtprJ8xbvjKUTvfHn
 GShoQ0FEZnw1GwKyYDAp0cQDU1cklEJV7rQJ21kPl1HWQwyfkwooGu8D5LGcdLPUyNSlnrn33sO
 ckNShhdOttZcEyp19iGx2PNgyR5E/2DBCLgTBu7Rgadz8tYP0ZF5AjuriGn/9Eeq7FlLigBY9nf
 Wkv/TqSqord63uBwt9S9kq1+5Kf5JaL/80Kw4qLS3UvGnB7BgSH/Wq/HeTYO8vP0HZS1fbt7KuO
 sWmwy8wwpvZEOzDDtu+Rknd1vUXfwZdgHiGxxZ4/+9HsfQAiEdOPbq5WxIbMXnIy26Wj3dSke1u
 8nl5iQLcHe8r6zQxej58uyroR4df2lKsneBg+PuptFttpgcehCdCgjAJkI/tqQFEIiMKtnP0
X-Proofpoint-GUID: xTkli9scXHHpI0PxroJguFeqfQ-2ExPI
X-Authority-Analysis: v=2.4 cv=QO9oRhLL c=1 sm=1 tr=0 ts=682de81c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=qZIjDpCgwzPhxpNeOhgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xTkli9scXHHpI0PxroJguFeqfQ-2ExPI
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hi Ethan,

On 5/20/25 6:18 AM, Ethan MILON wrote:
> Hi,
> 
> On 5/2/25 4:15 AM, Alejandro Jimenez wrote:

>> Extracting the DTE from a given AMDVIAddressSpace pointer structure is a
>> common operation required for syncing the shadow page tables. Implement a
>> helper to do it and check for common error conditions.
>>

>> +/*
>> + * These 'fault' reasons have an overloaded meaning since they are not only
>> + * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
>> + * IOMMU specification, but are also used to signal internal errors in the
>> + * emulation code.
>> + */
>> +typedef enum AMDVIFaultReason {
>> +    AMDVI_FR_DTE_RTR_ERR = 1,   /* Failure to retrieve DTE */
>> +    AMDVI_FR_DTE_V,             /* DTE[V] = 0 */
>> +    AMDVI_FR_DTE_TV,            /* DTE[TV] = 0 */
>> +} AMDVIFaultReason;
>> +

>>
>> +static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
>> +{
>> +    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
>> +    AMDVIState *s = as->iommu_state;
>> +
>> +    if (!amdvi_get_dte(s, devid, dte)) {
>> +        /* Unable to retrieve DTE for devid */
>> +        return -AMDVI_FR_DTE_RTR_ERR;
>> +    }
>> +
>> +    if (!(dte[0] & AMDVI_DEV_VALID)) {
>> +        /* DTE[V] not set, address is passed untranslated for devid */
>> +        return -AMDVI_FR_DTE_V;
>> +    }
>> +
>> +    if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
>> +        /* DTE[TV] not set, host page table not valid for devid */
>> +        return -AMDVI_FR_DTE_TV;
>> +    }
>> +    return 0;
>> +}
>> +
> 
> I'm not sure the new amdvi_as_to_dte() helper adds much. It just wraps a
> few checks and makes it harder to report faults properly in the future.

I am afraid I don't understand this argument. How does it make it 
harder? It returns 0 on success, and a negative value in case of error, 
and the error type can be checked and handled as needed by the caller.

The current implementation checks for 3 basic possible failures and maps 
them to errors:

AMDVI_FR_DTE_RTR_ERR --> This generally means something is very wrong

AMDVI_FR_DTE_V and/or AMDVI_FR_DTE_TV i.e. V=1, TV=1 --> This is a basic 
condition that multiple DTE fields require to be considered valid.

Every time we need to retrieve a DTE (for current and future features) 
we need to minimally check for those conditions.

> Is there a reason this couldn't be handled inline?

Discounting future uses, just by the end of the series you have 5 
different callers of this function, that is a lot of code duplication...

Thank you,
Alejandro






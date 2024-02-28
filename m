Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4A5C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfNDf-0000Wc-HH; Wed, 28 Feb 2024 11:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfNDa-0000Sf-NB
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:55:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfNDW-0004cf-0g
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:55:40 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41SESVvb013201; Wed, 28 Feb 2024 16:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aB5U8QqPxXB+CXZqF6MeYM3K+vSwilOK4C5TENMzq+E=;
 b=STjVftW9K79y6ymmG9gp7RvfBmZManUuCeEUCQOwlM3nqKzNY+yoneqbQXcjeNB74dit
 bWMc5B8QbtMpRsygiDKFvjeNHNyYieyRvHorU5zM0iJHN/A7YtDnL81hsuE3IjcXFpJG
 VgiY6VO2+KcpL4Ewsoeq5PNi8GPKPhnPx++17w8DQ5ArPuY++ID1vanPc5Ti6E5gnfKS
 GVUQtb7jGR/G+C9TcAvY7ktbN9C5j5yjqYNISYuqwuMt+o2bR6gn/Ep1avgZHlFYLXnQ
 UxBNR0LRQwtiAvYhYYqELFGkYNme2xkFDxuKR5jhgjiN1QRHOXNV0S7d4Mr7LV6Rob4Y yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vauck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Feb 2024 16:55:35 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41SGMJht022405; Wed, 28 Feb 2024 16:55:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w9fwc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Feb 2024 16:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFPMSC9XnhEPbUUCw2XygPjONLGQvm6BhEON+KeqvkVrKiv2b9dqb9OwXrSsd4jp72YO0+wPdmFYDTJ08ISKAb0AVjX2B4mZdXFBWoKZTco8AaI1cVJP3dj03v4/RlmB1Z4z3iXsfb4rbHrmkUSGMMo+S0Zt1Pd7x0syNsfAELCSVCizAT2mTWKr+cE+wijaW/Ig4TljSUEhUirVd9lTIw8spUV44YE0/soAOSqyBijmWDZNQJmd/CGB2J95RYdfLsxNZLxrCQBngkce9nRFKWIta0bWvnT7OjYKmSWiZFsqzm2u6l6nAUrHVB7tqSTYBNXAweHy8FM9w5sVtPWonw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB5U8QqPxXB+CXZqF6MeYM3K+vSwilOK4C5TENMzq+E=;
 b=VQdd7rTRpBOpY6pFFKaAcg6FYkY6smb7PW6xNTZrw88RetvAtb/O9n2k/Z3P+z5VDzK4KVmU9osxF8wBaaMAPqADODxownGHxLzUbIgj5q78tzJN9Mkq+GxjCWSHwbAhtJdeLY3eXB44nS7m5vGatBJTjMS0vK+RAmxpEAkgOp94Pfu5iNR/HyMA9ZQIslZ09gkma8Th5LIHD/WQvL2DrPQONVihl8mcjL4tprTv2Ms5uWJFPfF/1gnwM/NFvlPOKrJ8nc+E3WQtKAprZsu0AaZWmg1iefHp4yCaMHL6gULNuoUZJoGngWv2lEn6EF57eYJi7nOQrawRJqMNAZXqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB5U8QqPxXB+CXZqF6MeYM3K+vSwilOK4C5TENMzq+E=;
 b=ufeZVAe7lAhICwvxpGkQQhp3lzL/sPJsVxCqsj5q2Sn6DndmNjqSHQ+Fm7VMjjrKsycuw0K7G8rroR9x78s2RC9fXEK3mZ43znqbDvYH/i1E2q/iP41dhoyqQXNTCVRTqMOTc52r+3jxJ0dAvZOMMQapmqn8WYJtJi71avxdcHU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN7PR10MB6524.namprd10.prod.outlook.com (2603:10b6:806:2a7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 16:55:32 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 16:55:32 +0000
Message-ID: <592e18f7-0274-4d33-b0e1-543ad39e9d35@oracle.com>
Date: Wed, 28 Feb 2024 11:55:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] migration: export fewer options
Content-Language: en-US
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1708985769-280850-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1708985769-280850-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN7PR10MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: 85351373-e776-4615-d7af-08dc387e135a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUAZcxmB6G1+k7SXlviLZQVvAZXXuaFQWGZm2rxM/fMtQ1qQ/6/5tKgEY4jKnaGDzYiYpUbNsZeqis07ZoKcC/T8tyj9fDFfVJbvLSBktGiFbQUieie4fzJtPCRUCELS6a5MdZTRf+fYcj1cP0mPjriGQVIOALMbw7J1X707VFhfm/Dxxcc/2cgLTbCCJ3px5ufTlnLO5ESIGV+AXjfSE63PeRZBdUtt+yVzE083kjkwRhkqUX9BTrocgE5JPgAAW7o4zOYIb9BIgp4J2NOzwSYoqpHiBWrifz5CSiGQFfWTY1wNNbxLgudbiNgwWzzgpjESNyXfQ4y/i4ljoMUuQHiFW6WPYi7BCJpbv0VdAkz+sZGm5uSyegNk7QtydcJzg1fwfwfJwtR+SPzmeBEkh8p9xGOD9HsMWAuVmtMGl300F4iIhITQ+/esnsbpQMRiLQ9Y4xrJNiQEzv6Eirpp2aSXexbtz4i4Fno5Tt5xWb/LK8Cc8wTHe5RJS8RBCnbBrLlzDzA+qNEmnA0GW6TG9IDzhVq0f5oYBoyVbzAewBSVGyDBgJJ/Rk10C5d9BFj9k+t+AP1Pgbo8f7UFHjh9++DGdaX8s9AeQwCuUv0731i1dm7Z7A7X3iyX0YHzZLqFslqkG1wQkA9qSKEA1r31sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ZVVE9WcWpTdTlKN3JjWWQybnZBL212VG1GRWdmYnl2blJNQVc5WlZQZUZj?=
 =?utf-8?B?Ym81UUFuOVRTM0wya2RFVXdoVzU0TW9QSmRpOUF2RkhLQTJrRjVxdWo4Y09R?=
 =?utf-8?B?aDhNVEFlT3ovb1N6Y0QxM2xXWVNkNGt0cFBKcGJoZWJjUkU5My9sVkczQWNt?=
 =?utf-8?B?ckJtR2xXV1JsLzA4N204ckcwSThHZCtuUWllSmNPK25JcUF4ZlpYR0F1MUJ6?=
 =?utf-8?B?bmgyMEFaV2xnZ3VZMGFlZ1pkT0tpcm1DbzZOYk9ESUt3TWZ6K3YxcnBiM3pU?=
 =?utf-8?B?SDRSTWNBVlJkWFFSczdiYVhGamYrVTRadUNxY2lhZ1dDK2VhMU1VZ0FlWUZF?=
 =?utf-8?B?SGJhaDd6QlBDQ1hEYSszYXkzbnVSM2tHTmQyQU9aOVBKMWJWVXRVL1pHclJh?=
 =?utf-8?B?Sk9wN1NGK0ovZmZqN3FNaExGZnFzcExOOHRpdjk4ZUl3bjF2bFNIaURGSHFo?=
 =?utf-8?B?c0xUSis5NHRRMUNnWEM3cGcyeHJRQUltVVhhT29yWlRtb0dYSDhTOCtFVUU1?=
 =?utf-8?B?Y25sRFFGR2pMMXVkS2Zoc05Tb0crNVFuZkJOZDYzK1laNU5GWGZtTFZEWlF4?=
 =?utf-8?B?VS9vaXU4YlBTTlZzTDZYL1FSNWdmME4zMXZpOE00OHMyWEVJaTQxYjB5L0ZR?=
 =?utf-8?B?MndOU1VjWjVwaVpHSnBKdGp0Y0pITTVLallXMU15YUJrNkpwUlVsMjUvdHRZ?=
 =?utf-8?B?bE9lNERFbHU1ZytJbC9jNVhBTnVtRG5XMjdkMUxNMExmK0I3dnVuMkcvQnFq?=
 =?utf-8?B?SEVhSHVLdHpqV1dUYU9sdlZkclprMllXLzFya2dxWDhqYTJYZ0laYUxVd1RH?=
 =?utf-8?B?WFA5SDNGK0ZRcm44cHdSTGd0SWJxQytNY1hjL3VTOVh4Y3VtQk52dkwvMGhm?=
 =?utf-8?B?aDN4UlZpMTlyR1FjZHBEWVU4NUUrSHhMYTRaUUVKeFUxS1JtU0R0Y0xMRnpn?=
 =?utf-8?B?eVoyakRjL2xGbFNlcCtxTVhLS3BrdDhRblREbGZVRnVYT004NkJSL0ZVVm1i?=
 =?utf-8?B?Wk5xcGlML2lDWklvZ2FDdkp1U1ZKblcvSEQ4UERQRHYrc1EzdkZOQ0dhZGZp?=
 =?utf-8?B?OVFLNER1QzZ1L1RrNzZkcUhMUFlXeXMzemJKSnBYN3dqMFN1QU0vbWsxdWVt?=
 =?utf-8?B?OWtieHNDLzVvZmdGYmtCajhCVm1aYnIwQlMwZkx4aFZ0dHhMdVF2aG0zSGpR?=
 =?utf-8?B?Tk5GUXBtVWFsQXNpVnVzUFIzTklIQWJqYjVONE0xNXB4ekNXV0FZaGJhQ0hp?=
 =?utf-8?B?ZGxvdlh1bFY1dDZyRG5PM3A1Z0hmbURaUEUyeGkvNUloc25iZGJQbTZHZExk?=
 =?utf-8?B?SFlEekM1Ukk0OHY3N25oZWZqb2tBaitiWW1Qa0Y4YlBBMDhiTHIxMkVCUkpy?=
 =?utf-8?B?WWRkT0Z2OUhLcEI4Mi9VNERPbndvQWxROUc4QmltTU9GT2VsTVFlMmpxOXJh?=
 =?utf-8?B?TWlyWFkyTFcwYllVNjI3T1dyUm9DSmhLOTBmQVNnZUp1WThJZ3JLTGJOc3Fy?=
 =?utf-8?B?SWk4RXBScHpQdGlMcmgrVlc1ZzRpTGlZa2RvOER2UEI0cnZMZ281UTJGMGdN?=
 =?utf-8?B?WU84cGdrUWpEOEQxcEVvYUVHeE9JNm9YTjFVRUN3ZUFqNlhYc0pqaVMyWTk1?=
 =?utf-8?B?MURySXlVNGNWV3gxUUJCM1JFeGJKWk5wc1BUeTZleVd6elk1RVh1Syt6NVBt?=
 =?utf-8?B?a3pRcU1ybkx1ZXRIYWV4OSsvLy9BSDkyY1AyU01BYmhPZXFRelc4VEY2T2ZN?=
 =?utf-8?B?UUhNbHNWRTRZZWFyazZMUlc0U3NnNERmTURxMDMwQ0l6ekNZUENESnhkWG5Z?=
 =?utf-8?B?TnlmSStwdHgzUk8wQzBRSHhYc1gyL0tZU0lZZzBoN1dSamJZSWxwcWxzejFD?=
 =?utf-8?B?enRlbysxdzYwaEFYUS80elBTUFhHNVlMNHhlTlZzY01UeWVGZ0pwU1hRS1Q3?=
 =?utf-8?B?a3FURHltUUt2eC85UG52OFZLZDR0SzBHbnRZTXc3K09BdjRERUlNamYvSkQz?=
 =?utf-8?B?blVHUkhWcWxQYVVPcGhuVWUzS1REemkzTnZBSnZzdDBhMTJFZE5qSXpBWHox?=
 =?utf-8?B?Z09zR1BrWENaNVhVQVRUSFV5WFBteUU0cDFFUHNTY1pJcjBHUHlZM0hpZEl4?=
 =?utf-8?B?QVhEK1J4YnpjbUsrdzdDdUtyUWNveDJKUHJvRGplOWM5Ly9ZbkdOS04vMEFo?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: boUans3+fOIpVna48vUb3BOBqyOVa7iZ0TmR9c+NnMXQ7XPnsighTSuwxri8B1qwj648Re9jd/I0n1aKaEPb3R3FHNV6CKeNqrrG5ji6lHQ15f/SH+s4H5fJqszmrmobYsz6UpM6aOK2qYhPZbMypy1X6IQbzzxkdnKvb0dwuxx646ocQNH6alPEFZMUYcUBolc9dPFzlAR8qO+sBUuHISST9WGwi07td3o4EsCYguj/ZYCT5BQwG9EjBx7xE4ifvQig8GA/nrO2jz0a7CBH8MozbcOSj7klC9ERgzLPkc/xzDYYpkOI83SbFoObJ5rtMSuTVM49x/v4R+LdpCX6veCTa6fNZzHvOMP+IlMdo9dTUDTlIRqbEgYSTJR3F16DEBTav3OuUd/K1fiGqz98rfjVx4HjcwL+MLmX5etcv/P38rtVnrCJ2nGSt1wpx1Ka9WeuK9IZREz3kXtt3a57QWmUPketL7ShHLnsSS0zpin+k4EvEsVuz/1tjZx1IweU+tivxBQMSu+L3WuKB5aREsrgBWhlLfwpFuz6Rz5Exsg5kCXRWtobjYJFVqcQ4Rx6N0D9Ui1c5JbEIzLY1wBwkgvUAWJX/QT7690qyn8YIF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85351373-e776-4615-d7af-08dc387e135a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 16:55:32.2865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7NjCVnHickzbbT08uxVVA7b+ir7O+Q7+rfIB05tK0AoHVVOFmndpYuoqoVDQnZ+j045PAyE3eHVV3F2p4jSVCIlkBkve7aEEwcDkCHanIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280133
X-Proofpoint-GUID: ZgzasfjgFwjp-WA9MrdhOTWQ3kxN9inb
X-Proofpoint-ORIG-GUID: ZgzasfjgFwjp-WA9MrdhOTWQ3kxN9inb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Just a reminder, after our further discussion in the V1 thread, 
this patch is still what I propose, no updates needed.

Markus, I think Peter is looking for your blessing on the new
file name: include/migration/client-options.h.

- Steve

On 2/26/2024 5:16 PM, Steve Sistare wrote:
> A small number of migration options are accessed by migration clients,
> but to see them clients must include all of options.h, which is mostly
> for migration core code.  migrate_mode() in particular will be needed by
> multiple clients.
> 
> Refactor the option declarations so clients can see the necessary few via
> misc.h, which already exports a portion of the client API.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
> Changes in V2:
>   * renamed options-pub.h to client-options.h
> ---
> ---
>  hw/vfio/migration.c                |  1 -
>  hw/virtio/virtio-balloon.c         |  1 -
>  include/migration/client-options.h | 24 ++++++++++++++++++++++++
>  include/migration/misc.h           |  1 +
>  migration/options.h                |  6 +-----
>  system/dirtylimit.c                |  1 -
>  6 files changed, 26 insertions(+), 8 deletions(-)
>  create mode 100644 include/migration/client-options.h
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 50140ed..5d4a23c 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -18,7 +18,6 @@
>  #include "sysemu/runstate.h"
>  #include "hw/vfio/vfio-common.h"
>  #include "migration/migration.h"
> -#include "migration/options.h"
>  #include "migration/savevm.h"
>  #include "migration/vmstate.h"
>  #include "migration/qemu-file.h"
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index 89f853f..a59ff17 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -32,7 +32,6 @@
>  #include "qemu/error-report.h"
>  #include "migration/misc.h"
>  #include "migration/migration.h"
> -#include "migration/options.h"
>  
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
> diff --git a/include/migration/client-options.h b/include/migration/client-options.h
> new file mode 100644
> index 0000000..887fea1
> --- /dev/null
> +++ b/include/migration/client-options.h
> @@ -0,0 +1,24 @@
> +/*
> + * QEMU public migration capabilities
> + *
> + * Copyright (c) 2012-2023 Red Hat Inc
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_MIGRATION_CLIENT_OPTIONS_H
> +#define QEMU_MIGRATION_CLIENT_OPTIONS_H
> +
> +/* capabilities */
> +
> +bool migrate_background_snapshot(void);
> +bool migrate_dirty_limit(void);
> +bool migrate_postcopy_ram(void);
> +bool migrate_switchover_ack(void);
> +
> +/* parameters */
> +
> +MigMode migrate_mode(void);
> +
> +#endif
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 5d1aa59..4c226a4 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -17,6 +17,7 @@
>  #include "qemu/notify.h"
>  #include "qapi/qapi-types-migration.h"
>  #include "qapi/qapi-types-net.h"
> +#include "migration/client-options.h"
>  
>  /* migration/ram.c */
>  
> diff --git a/migration/options.h b/migration/options.h
> index 246c160..964ebdd 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -16,6 +16,7 @@
>  
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-properties-system.h"
> +#include "migration/client-options.h"
>  
>  /* migration properties */
>  
> @@ -24,12 +25,10 @@ extern Property migration_properties[];
>  /* capabilities */
>  
>  bool migrate_auto_converge(void);
> -bool migrate_background_snapshot(void);
>  bool migrate_block(void);
>  bool migrate_colo(void);
>  bool migrate_compress(void);
>  bool migrate_dirty_bitmaps(void);
> -bool migrate_dirty_limit(void);
>  bool migrate_events(void);
>  bool migrate_ignore_shared(void);
>  bool migrate_late_block_activate(void);
> @@ -37,11 +36,9 @@ bool migrate_multifd(void);
>  bool migrate_pause_before_switchover(void);
>  bool migrate_postcopy_blocktime(void);
>  bool migrate_postcopy_preempt(void);
> -bool migrate_postcopy_ram(void);
>  bool migrate_rdma_pin_all(void);
>  bool migrate_release_ram(void);
>  bool migrate_return_path(void);
> -bool migrate_switchover_ack(void);
>  bool migrate_validate_uuid(void);
>  bool migrate_xbzrle(void);
>  bool migrate_zero_blocks(void);
> @@ -83,7 +80,6 @@ uint8_t migrate_max_cpu_throttle(void);
>  uint64_t migrate_max_bandwidth(void);
>  uint64_t migrate_avail_switchover_bandwidth(void);
>  uint64_t migrate_max_postcopy_bandwidth(void);
> -MigMode migrate_mode(void);
>  int migrate_multifd_channels(void);
>  MultiFDCompression migrate_multifd_compression(void);
>  int migrate_multifd_zlib_level(void);
> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> index b5607eb..774ff44 100644
> --- a/system/dirtylimit.c
> +++ b/system/dirtylimit.c
> @@ -26,7 +26,6 @@
>  #include "trace.h"
>  #include "migration/misc.h"
>  #include "migration/migration.h"
> -#include "migration/options.h"
>  
>  /*
>   * Dirtylimit stop working if dirty page rate error


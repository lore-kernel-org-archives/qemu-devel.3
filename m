Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80809C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 18:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlCNJ-0000SB-Pc; Fri, 15 Mar 2024 14:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rlCNH-0000Rq-AL
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 14:33:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rlCNE-0000cx-4q
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 14:33:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42FH9RDM008461; Fri, 15 Mar 2024 18:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kvCr8MmXl4jw0dg+xPmfIjndh9R937atTurVV0fnoOM=;
 b=JyUX/L2Z1edBuu4cVyz3A2Imr0fYn/3QcKfbSS3SSejvswXZXa1HD+MHirJnbu5shevI
 J32Mr1CADizcyWA7JX5YPQuGpmC4y7Dnmtgn3vPzED5AQ1rBC7co6HzyOLLyhz6diR+V
 vuxTnV2LgHzK9ndZAo5417WzxrJ1l5RI2i/K8xv4DYW9OmIjRbBQIWQD5vA+8Z9jXP7B
 Acd/9SCzZpP1sAnMGANkqoVvqF1pL9bmm/8AoCKYYFu+wJgZc+xaJV5B1ajjmtCDb8WQ
 9H6U7of3s4RojvbZBd6H5JA7J8tUXdYnRU5N9s+/gnGqAhzPgqh2BZAzxqVm6D+SLUYw ZQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wvsxh87br-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Mar 2024 18:33:41 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42FIRkUO033233; Fri, 15 Mar 2024 18:33:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wvt97c1tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Mar 2024 18:33:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGA6AKn7Zd82f+bl6QE/Mg1bJazRwXyZxGxvA8ztQIxSjDXLWNysqdiL0GL7KamA+wJWbO+h+nF+JjVvi9rHEyV5fI43APVsGUkmZaLMRqZoqbztDh5NbWOF4UVhNOVjfOJCrzvcdlfAynacp/xfthlj/yNUM6LvcMaesVTqQqCI5rkpauyZ9seRPSJVeTwMEn3CxYgdUtU0QCyNnTdmw5qwlhcAPDRwS85MHJ/Hf+Cn9zgUAmO/1KLGnZ76OcvGvZ+GaCgq/kJUPuUERYzbJsUuE11RCGY6jO773Lq6XbUcGpJEHh54pywUl71VF8+M2paZawfiiw5JMaHZZyroiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvCr8MmXl4jw0dg+xPmfIjndh9R937atTurVV0fnoOM=;
 b=AybwaWhPvZaHpeqPmCE81DDBvO9o24pKA7YvbtcIzoA9gn4IdQy81UXL3BwBsO6pc6+HoIpLBSI0w+CMzX0rvzluCFyBCIR18EzulMD2UuVE1pmbXd8BnFX0I1T7qSkv3ofAPNYvIi9HtS6iClyEBW2TQWS9dNRXOPNh4y5oTkBW6h67j6sfnBVFZbDMM9UJqN/X0kyN/gHGsEMsluGrjMpDnxxhoAMbIGmLTmhsXksHkOyfYO+O1Eg5l9PpMY0KFgvyZ1b9asBoZkk3mfiGdoaqHyEYetCpGandKrSgvalbWTWL0ZXGGFi4qGkftYNFTUtuiNg42/rXoNkqQYULKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvCr8MmXl4jw0dg+xPmfIjndh9R937atTurVV0fnoOM=;
 b=TcWdjdwFvKru6CJ7J6GSDoR8uSbPYTb+q+vGSOBWCrnGOovWDr0dsOUUdT2Qy65ffw7sJMbifI8kwr6LMKptWvrDzTdG36eL88nmgPzEwlAz57hjTpoMmp8WLHxNlcMslGLbBbzo1zNK9P/hKOoB+apl6eYXhz83QwAPmMG5l4Q=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA0PR10MB6819.namprd10.prod.outlook.com (2603:10b6:208:438::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 18:33:38 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::bf6e:420b:90be:3cff%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 18:33:38 +0000
Message-ID: <9cb9fe47-f173-4cf1-8bc0-01971e47559c@oracle.com>
Date: Fri, 15 Mar 2024 11:33:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] vhost: dirty log should be per backend type
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com,
 joao.m.martins@oracle.com
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEt2-naXvHjCcPyQAoSfto44OVaSUqPtg_gvS8-wrhNwZA@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEt2-naXvHjCcPyQAoSfto44OVaSUqPtg_gvS8-wrhNwZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA0PR10MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: f2613f2f-9729-4d38-4e87-08dc451e6e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UXGNywwfOpAnT4Yzbyh9QWDAzUjRG3sC+/Ue8DLJ7gbKRRq6o03qV0CjjYz9aYm+CeT7RK0JmjzpE8dsQ9oFJfSndOrI90nHSV3KQ5frEk9c76/mG5p/wJB0Yq5jrc80lg6bABWN+5kvW+GbXSw7ADyuMGhSvOGzdBHrEZ0fcTNE+mi46JnBM1zHMqW9OZwlz3bi3eQDs8adZuO94JqzKZ/3Oyh1Cbd6451FpEwbZSST5mO4mlakcEfuAWYm5h/1mXM1mmAoUow7aFmFpBze3EFVWq/CJA6xX05sCYuiW9sdHAmQfZW1fteO/cUtqFyjw3oCE3MszWD1CDB98Nr9w4xNrBxjD/7J9AIGE1+CQ50ITe8rsbB1nWCYtNv00mw/XFc+0iADHvxrH3hBmPrZWovSgCj2nHMK7IQtnKGRuEuhrh+u3z24CKbKCB7jWMsd7RfkCEE80Y9ZpkHUwJE/wYn7mYKqBrZsEO4ZNqgF+pwaOxi+DNgZNOZFyW910oKeQvFNUfvGkuoXQS8BJzbVtPcAyQQaxgnEEPoD0zy859P4ywpS5RLy+ka1F2+Kivo74OV2B0nGmtmrQyJB+n1ANXczbp4gPAqGpvuEpnqyjpR0f1R8GNWGPTHbW8XJRdLWzqLYm+jnKvRvT7HnE/m1gVMRc1Ik1xFWWawxE2Mkehw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW1XSFQ5SEZtak9KZmFUa0ZrY0pjOG5VTEpZVnIvWWZ5TVd5Mi9KWUI0b095?=
 =?utf-8?B?SUdScElaM3NaaTJJNjhyanorU1NUSW03NTdGRFNqS2d0RzV5OFBWMFRwZjM4?=
 =?utf-8?B?QkJ1M2xKbU52cDBuUkpjaVZzZHRRTW54Z1Z3dUV6ejJYa1V1UE9oTmhwLzR5?=
 =?utf-8?B?T3ltMUxEclFmRGZwc2VRRU9IZWdxKzV6NHgzTFgxMlR6OG9uVTJZSVBRaGxK?=
 =?utf-8?B?cm5xU21oQ0N3aERpV3BDVDU1eEYxUFVURjJacXRMNXJKYmNMSVlTQ3ZXcVIr?=
 =?utf-8?B?VysyQWs2UktJQm9DMUhCQnNHWVpHNFJXTnVLVktRb3NCbXJ0QWc2cXZsMElC?=
 =?utf-8?B?OFJYbnRmN0FLM3lTVnRxMHV6M0VsZSt0NWVacXY4UWsvdkk4UGhsaDB0clFV?=
 =?utf-8?B?QkFNK1B5WC9ERXloQkRXMVJWQXp2bkhYWEZYVk8zbndwRUxSZFlDN2xiM21z?=
 =?utf-8?B?M3JOQ1lmV0RMazFJOU9waURuR1BVdWsrdGI3dUVIMGlOUTB5aU9lWW5WQzNM?=
 =?utf-8?B?MGZpUVU0bGZjUGIreDhLUk83cHRjWFlCak52WmlYWENKTXE3cEdMTW1rUkJu?=
 =?utf-8?B?WlhJMW92c1hEZG1ZZVRocE9Kc01xS1VEbk5CUkl5eTVMdkY1aFN3TGRqRTA3?=
 =?utf-8?B?MkMzM0t6SnY2L3Q5MXYwY3lIclhxbXpXZEJoSDNMVTBQUHl2K3cxbTh4bVNM?=
 =?utf-8?B?YkZLR2FuQ1prUmFwMUhHYjJkaWY3T2FVR05scGRPc05kU2QzU1k2RjE5QVlO?=
 =?utf-8?B?a1plNFN0TUJqSmtXV3hRbnJieTF6azNnZjk2dmpjcnJkT0lwcVdsSkwvc0J0?=
 =?utf-8?B?NjhxcTNib1R3NUZRbzhjSEQrTXNsa0cyajVNRm55dVRMNGhFRS9sMnBubGcw?=
 =?utf-8?B?Mm84UmZRdWNBWjEyRU5tUDQ0aUJISFJDNXhiUWNYK09UYWwzU3ltQ00wRVhl?=
 =?utf-8?B?OHhla2dGeWZKVDNYczR5ZVcyWXZONGpNUWUzdlNpVHJVQUtyeStjM04wNXhw?=
 =?utf-8?B?Q1ZTWko2eGhIK2k0eXJnZ2ZUUmpjRmRsRCtrOG9MMXk2eUdUWWJjOFJVek9H?=
 =?utf-8?B?RXJpZjVWUkNabGNDQVlrRnE2dWtKelZLWGk1TWR6MW1CZ3VxWGs0OWtVMlZD?=
 =?utf-8?B?dS9JNzQvNFgyUVkzbllDakFaNFNkTXFsa1BpcmlablRYeVZ1QnpxSFZ5dmMz?=
 =?utf-8?B?d2NUcmpEY1BQQk1BUkFKWmZDTmd1RWJpekxhMUVFME85dXYreVZHODA2dlVL?=
 =?utf-8?B?Zjl3cGFhakdUOTh4R0wvRm9lMENDcitOdk9QVVM4dzYwVWt6V0wxK0s5a3Zv?=
 =?utf-8?B?Tm8yazN4MEh5dTYwWnhzRFFWU253U3BraTRTNVBTbzZzd0FJRVFTVlc3SU1y?=
 =?utf-8?B?UVpsVzlMNTBIUkxEVEMyN2JTZjRtcjVVSWJUZWk4eEgxaEJPL2k4ZVBGZnFY?=
 =?utf-8?B?bUNBMnNJZFRIeWJxNU9oQnFTT0MzZGFPcy80MTJMUzRZMmRnaHRBQXdYOFNE?=
 =?utf-8?B?NzJnZ1BhQzhzV282TkRncGVXZHdTYmtMK3k1VFpHcUgxTExaYSsyRXNvU2ty?=
 =?utf-8?B?cVI4ZTR3VDBYejBRZlVIMFg3dDRDTVRuOStmTks1MnkrQm0yNUNjUHAvdTU0?=
 =?utf-8?B?OHl3eE5QWlZDa0NpdG1zQmZlYXBpd3pvOExaL2NYZlBjSmU5c3U4UXcxQUpu?=
 =?utf-8?B?d1cwK1lyUFZJTHAxZitWTXlYeWJoSUlJZFRFU1BYQ3NMUkRnT1hlcEh1a3Vs?=
 =?utf-8?B?KzVmdWxrbjR5U1JjMnM4Y3BrbW9leWhrS0dxRmVmWFVWTDhQM0F2NTQwSmZt?=
 =?utf-8?B?ditwb0RGS0hLMXRBd1R4S2tYblBKRUxZWmllZ3RLaUM3T1V1ck5NMlhMZldx?=
 =?utf-8?B?S3FDaEQ1M2JPZU92ZUFzRllGc2d3ODh3V3pxN3VjSUptYnJ1cTV1U0hUbUQr?=
 =?utf-8?B?QTlwNUQxNFBTWFh5c0l0QTFTZnJOYVdKMFVHbHdIbWxCN3B5QWlIdkx3bjVi?=
 =?utf-8?B?SW5adHhqVDMzR1FVdGg4T1pUM0lIUUxFNXZGaGpJRDc3Q2FnYVhpQTZVZDQr?=
 =?utf-8?B?WFBpUlY4ZCtWbUhzMVN5cDZ3eHp0V0IzVnJvc3A2V1VKVURwWnJIQTh6TXVQ?=
 =?utf-8?Q?LN8NzkZB0BhXPA/mFXCcx9JjY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dQLW8PLkQ5LhAmVMF3jVjsgQq+ZZsnadUcU11GO7gpyq6A4/xA5YmRaZGMhfyfTrvee1sFkMKTB0HO2HfnyWO7sQ2b2Gw/lvsAOzualhkjXwcEK9aY7DufGs0tKIv2AqhKW5u1qi+xTRyVQkGcl3/ciVlwLYG6difIIRJUb7CZSXBtDvxpj9fpHmaPpBqA61BNOzkYYlG5/0GAKO+KlvPBT1BBmtO3lHu0/080vG4jzEABd1iDzlRUwl/1c+vKW+WYbiZk4yW1xLiyBdHXnjzqUqghqxCWorLbEnviMO0Re0H0rQ1j5CVQr7xDoKYc7B2/nSBD9GHzaj9Tyk7BGhHw79Kdo0WniB39qbwWqZLyA8p85sJvWgcQNIw9GKeV9IUVaneh9X2U5MsULKVcqLX0af50UXjbylWocNpuM/pjFvn8yvhVSyngA2hhXt+cNMeFSzP9/zhdYvxhvHr85B9HLuoYB9y3Tu1wnW+AQQxEJgzKTnAwLrpYLe3KZuCvOQ6MI58gyFnvtf5hAT0nI54+K/avUHvcc/akYaf7otIa43OgU9z6htFkrQjqEJVJzE4IblO4MDoSXROk15Upm0/ekqMShKtHJ/Ylg+JrqkF8Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2613f2f-9729-4d38-4e87-08dc451e6e76
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 18:33:38.5749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLQ1TYd+IJhykJsdvNUtTdrGv8SXF9YOZMe31VHSfNvwU3+9uS0bK9nqL8kT3b53RIqws9AOjIqaRwzeTng9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_05,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403150152
X-Proofpoint-ORIG-GUID: s9yjj6s2xsMSu6FTyMAJ3fQ2wbeXmgFo
X-Proofpoint-GUID: s9yjj6s2xsMSu6FTyMAJ3fQ2wbeXmgFo
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 3/14/2024 8:50 PM, Jason Wang wrote:
> On Fri, Mar 15, 2024 at 5:39 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> There could be a mix of both vhost-user and vhost-kernel clients
>> in the same QEMU process, where separate vhost loggers for the
>> specific vhost type have to be used. Make the vhost logger per
>> backend type, and have them properly reference counted.
> It's better to describe what's the advantage of doing this.
Yes, I can add that to the log. Although it's a niche use case, it was 
actually a long standing limitation / bug that vhost-user and 
vhost-kernel loggers can't co-exist per QEMU process, but today it's 
just silent failure that may be ended up with. This bug fix removes that 
implicit limitation in the code.
>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>
>> ---
>> v3->v4:
>>    - remove checking NULL return value from vhost_log_get
>>
>> v2->v3:
>>    - remove non-effective assertion that never be reached
>>    - do not return NULL from vhost_log_get()
>>    - add neccessary assertions to vhost_log_get()
>> ---
>>   hw/virtio/vhost.c | 45 +++++++++++++++++++++++++++++++++------------
>>   1 file changed, 33 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 2c9ac79..612f4db 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -43,8 +43,8 @@
>>       do { } while (0)
>>   #endif
>>
>> -static struct vhost_log *vhost_log;
>> -static struct vhost_log *vhost_log_shm;
>> +static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
>> +static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
>>
>>   /* Memslots used by backends that support private memslots (without an fd). */
>>   static unsigned int used_memslots;
>> @@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_dev *dev,
>>           r = -1;
>>       }
>>
>> +    if (r == 0) {
>> +        assert(dev->vhost_ops->backend_type == backend_type);
>> +    }
>> +
> Under which condition could we hit this?
Just in case some other function inadvertently corrupted this earlier, 
we have to capture discrepancy in the first place... On the other hand, 
it will be helpful for other vhost backend writers to diagnose day-one 
bug in the code. I feel just code comment here will not be 
sufficient/helpful.

>   It seems not good to assert a local logic.
It seems to me quite a few local asserts are in the same file already, 
vhost_save_backend_state, vhost_load_backend_state, 
vhost_virtqueue_mask, vhost_config_mask, just to name a few. Why local 
assert a problem?

Thanks,
-Siwei

> Thanks
>



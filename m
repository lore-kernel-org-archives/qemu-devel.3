Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F2BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxYen-0006Jr-6X; Thu, 18 Apr 2024 16:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rxYeg-00069b-D6
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:46:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rxYee-0004ZA-EL
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:46:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43IJiUdB000472; Thu, 18 Apr 2024 20:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=yOtODzac2nyHdqJevVV1uuHiNxtN8jVq67KmeVipeTI=;
 b=FYKcYKRuHFFchzV1Kc7dw55MqHr36eofnzuhwczT1uL1cVev+XD5ZO9wNwJQWAqrPsZ7
 +aoc+ZuEU2FvCF7hdMutZZXYeKs/9RnZ6jzdQE+GszUaVd+/0ZV95LxTzOx7WD2qSOhW
 /Cf0asHsD6IXwrfF8ySstdPRbh+7bPIfFWN5BIdFYuNtSw/6gza6yGF+P/rTDPljA63p
 5AR5SGNa9bFn93diAr3Xsj1nFnzw5CD4kHywpkElCC2SocftbWaD16irA2hsR8IoZ8ut
 ZAd2f3KkWgRF05ua2uTdcWNhjtZFnsh/KDh35CeUu5ikXClwh9jJwKKBWn3MKOuReBpQ GA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbueup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Apr 2024 20:46:41 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43IK0tKx004350; Thu, 18 Apr 2024 20:46:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xfggh948f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Apr 2024 20:46:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuLtqzUWaUOT00BC+pHLvlKaR/Kfh5UH7HPUD3y3hmzLkzkbR6QhSbJ+OUXsnvTt5FWiy4/g7qz5v38hWJc0XS1PFbSOlYBxCVViE2XJwNGHqelU/SzehR30hG0UyHdHYBZtg10xAjLhsdgtH7WQpnU3iMmxssTov3sZov/OI6kLKEgSF+oCO5GstxU8XsMwZLdh36iff2kH+eZ3of4Kk0lIrB6p407meKTQP3ZReyJAGTMwDSJ38z2qgTEDvrPhnAbTvJBIcdav0mNT4nN+3uLnxKlN3VzuwwftDWFOo6C092m8hcMKdWKogBhYd0c/TKxFQj1RZKQT25olY6P2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOtODzac2nyHdqJevVV1uuHiNxtN8jVq67KmeVipeTI=;
 b=P6IDEEa2BVT386ahC6rJRAVXCR0biPADjYyJmm9WJj4FoA7RNtFzBEZx/jsupj0Zpoq4WuerSVaI0pdDisQPQZsrqsJP003UUtFEg1iRwSAWxyjvaNApH6EFn5/Wtt6UI/wcx22veOoizvGIFX5rkzqAfgBNbh86UZZ+pIdp/dUswKhpS8cRPRMBUctDRG6zeTdruOYJwvKL6jhjnBHnv+f7Eg0BgUnrj05NXnnuo/wxiQagxc76owqoyoF2zOc4SvPDP4Dg8r23wCwuRsqDpkDvpDehy7UYdjOa4R35E4vcRJiBIrhwnx2yueiEmB9Cprtpy0vGwZ1Qa9rfvFqYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOtODzac2nyHdqJevVV1uuHiNxtN8jVq67KmeVipeTI=;
 b=rKyHUsuUrkc9kqligi/oe8eMHW0gpL+JSLhYvcFMR17Mw+umvmNJNCoG78gCi3Qofqvx0oBEtc5LH3fz/zSSGI7HLjdVc6uqIAE9EaukqK9pLVRPRZa2SqOyY7r1xSlH3Fp3nEIuX5y+BHxvL69FxOZxJBgzNWKErnr0fIGM648=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by IA0PR10MB7136.namprd10.prod.outlook.com (2603:10b6:208:409::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 20:46:38 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::b34a:bd2b:445e:1b74%4]) with mapi id 15.20.7452.050; Thu, 18 Apr 2024
 20:46:38 +0000
Message-ID: <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
Date: Thu, 18 Apr 2024 13:46:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240410100345.389462-2-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::41) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|IA0PR10MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3067f3-5e41-41a1-29b6-08dc5fe8a4a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwIWTmRuhN8Iyp/Mf2LLhYFk9UY4VNyUO7vXrlQQg6/SwMW1VarMfqt+nEaOeQTQy33W5P+joxbTQOsrIuJ8pTEgMJY0Vo2x65iz3bpt8FDVq07gkvMkqeBMy02/bPCXu/IOgH35QysjLNanxWyF6pLnqwWQCikQmO59LUBcbd52q6Wn+wf/Rg/7dGdo87U2NVKsnxSnkT6NxJGDHeWzIopJuEacB4SJISR2MrqxqTQb8r5B2G3h4/BoKWNnb7/l2L9OwYdwGeR5xI8PjCDkamEA7Ab3oRDMntsJCqIB6C8lZpKT/laCtHHEVkTg9AtmUeRSKpRTTr5ZuT7zh//DNAKDOkw1lxnSIFvzRug5QHe9p5MIZN+29BS1lE2oHMdDJj0GKcg6h1Htuj/SfBy7tTEJJ6JO4yBFLrEtFj8IbEc6P/vawL/s4GvoBu9SGKCWBF53zasriqQ0fJ8OL/HoUT8xHABThknoZpvjl4OzkX+t1sXx5WMXenh0AGgIY6LtF0LTkBT2ab5euTfu5J/xhNcXprw5Zq/DWgFtvxu6PVBAD/ASCD5Sd5OouAucMfbxWPYcZ8ZGcMmLRlxSjWVsHA6RHJ+E1mtM7b+qB86szUOdh70M+rGp3MQYHyag8yqYZ+pA8XWfW7KSl6jyKO7xPRNfCE4Yar6LqhQX8iVfwMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVNOMkUvYUdNZjhrTzU0eXFuNVRsWnJJUDY1aUlSSDcwblhHRUxBT2ovY2xu?=
 =?utf-8?B?dUdMZVpWeXhrSlQ1YzZjVG1ZWi96STlaWHhscE82SXJHMTgyZVJLUXJwVFBq?=
 =?utf-8?B?T1lPYkRSTllSMmVLaVF6QnB4N1RWeUtsUHpVMXNmTUlrbWQzZHhGaHRkSlpM?=
 =?utf-8?B?WmNKYWRpeCtHTnlwdktkcURrUXZFamZrZWVXN0VKTnd1ZFp4cW95aXlLTVIx?=
 =?utf-8?B?OGttb0Vic25EdFdXQ0QyZTYvMUMvMTFsViszelpLN2tOQXZYTWRpVkdDM2xZ?=
 =?utf-8?B?Vi80bFRMQ0VPR3hGM0JnSDhDOVFHVDZJV20yOXEvUDVjK29BUjQ3RWlZQjVt?=
 =?utf-8?B?ZE5DWlBKTmYzNlJUcEpxa3hhcTgzRHJEVGpBTnF5SmNrbDFVVExpZGxtbTRB?=
 =?utf-8?B?VEhrN0luOE1sUVpIcHl1Z0h4ZVlzdUQrQmYvN1N0VmErNGUwMzQ5dkptT3li?=
 =?utf-8?B?T1dzV0UwYU1wQVdPaDdQUHhDMTh6dmdxRDV4M2xmMlhyQUJ6bWlZUE5mcEVX?=
 =?utf-8?B?dmNOSS9xUCtQUkYwaVMrY2c3MG9uU0pDVmw3aU1EN0s2TFJGRERDd0VlOXhE?=
 =?utf-8?B?MmMyUEZmUm5oSGNySUtDMXVUWkQ3djBtL1JHRWUyakFZZ0xzcGdtcGh1Vzha?=
 =?utf-8?B?OXhabWpaSWF0UjRTc2lsODlPNk1JWngweW4vMVRRckt1b2IwL2t1a3M3Tzl0?=
 =?utf-8?B?MVZ0TjBMSTZjdmpLZ3dpUW5MVG4raU9QYkRCUWl2QlJTYkN6MU8yYWRqejRz?=
 =?utf-8?B?SzY5bk1ibEU0bm1LRytmYzlZd04wL3BQZGh4NWZuODE1MmF0SEFZYWJFZlFK?=
 =?utf-8?B?TzhnYytFd0RqOFJzb2ZaNGhOaFlqUEhnWENWbHd2Z1pGRlVYek5sejVENHNa?=
 =?utf-8?B?M2RPZCtKUmFtd1U2b1VYdjB3Vm1rUWdXdzBnNnN4SEZlQ2JCNEFzaWJGQ3pV?=
 =?utf-8?B?UlBwUDduV0paSVhKR084bTR0RDgvS3FqcWNMTGxrbHZvWjQyeVFHOERHbVBG?=
 =?utf-8?B?SmdzNVdFZ2N3dWV0QVhPWTZLTkhOTnRJYnI0OGVFMzNpeXRhc1JWNWxUWGt3?=
 =?utf-8?B?dkhxWmhhMFgvU0wrQ1lHSytlQmRMdTRPQzY3VWRDV2hVV21obUdNOEtBcmI2?=
 =?utf-8?B?YXE5VzFrSEZRcmVKclZnUk1lbzBzampmdkNjblEvYnZTcCtaN2JUYjhjMHFT?=
 =?utf-8?B?czNmeDNWeHA0T3RkRTVBdWtNRTZGU1pBNDMwdjN6QUFGVzA5YlR2NVp3b25v?=
 =?utf-8?B?QWxob09SWjhhMnNWclMyRFJpN0IyUW8yVjdMY2dqSkR6NGZqSG1rTkF2MXJU?=
 =?utf-8?B?N201UFVkQU9OYVR2TmlMYWdUcGhNUDY4Z3N6YkRDRHdmRG5HVmFpSG54WTdJ?=
 =?utf-8?B?V0lVMlFTQkRJYU9CNWtOMGJmQ0FFN1l6VGlQZlRDYmt4M2o3ck9KRHZEdEFV?=
 =?utf-8?B?VFZEZjd1YlBjcWtUQ1pSL1U1QjFRc2JPY1JuWFlRQjY1YXBmUDUybVRXVExi?=
 =?utf-8?B?S1dsUlZVM0pKRXhqTGlxcWwrR2xnRjhudkZDVkxUWUtlbFZXSldDUUN2WVRD?=
 =?utf-8?B?bWN6YVJxYWxEL0I3Tnk1UlBuVGdIa0N0SUJjUWpuclhMYXZGVDl5NnJ0Zkhs?=
 =?utf-8?B?cGRvbzNmQTQwVUdKMXlZK21MdEJBREw1R05tNElyZCthOUlCTXUvd0FqOE1p?=
 =?utf-8?B?cFFlYnhPM3NSYVdWQXhGVnorSVRaRjRoNVgrRm1sdVkxdnIzTDhQeVN6YXMy?=
 =?utf-8?B?UzJEN21ocDNLdGxpaUovam5GdVBCWWIwMC9qc1VWenNpYXA1Ykh5d2sxZHZL?=
 =?utf-8?B?TWg0VitDckY4eXNiMlZ0Q1hud3NEM3JjWllKSVFWTVVVelhuamdjOTF2Q1lu?=
 =?utf-8?B?V2g5VDN4SlhHbTBlL2l2TjhFWlF3NE9TQnpCZ2MvMXgrR1Q4TE1yQUdKd2M1?=
 =?utf-8?B?WTk1OUFScCt3SU5Rc09TZU5NbzhmeTBpTUh5amJXV096WVl1Q05MY1JBTi9R?=
 =?utf-8?B?NUs2UTZHUE5ML3BmVENIUFhFRkNPeUpXQXR2bHBsTU9yRGlxVmM2enJlaS9z?=
 =?utf-8?B?bkVCTk1iaUorRVhUcjczSTE4MEtMNm9QNDFRLzFOY3RLeDVVc1BNeGIvRzMz?=
 =?utf-8?Q?MBAcCcL9e7iEpjtpUEEQwR8OR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: blTmFNHPIjgE4OhbIGQGOhfIj8dEbloErXpKprtUIi+oL1xY6l/WO6LgCvsP8grVUMJldHoqWOdnyyVNajyV+GorLdGUlEveah+eN8VTJSlqZIOo4ZbdLxyJ8ia/NM2BLD64cpMwxMsTzs2rr10ULKN4rr2lfOPHi5e8g64IaTyYwD7tF7qawLETH7U5A4fNI1kkWUvH88IJtDbYdACNEyzmXMGZ7h4LbSo3VjljrVbyg3s00Zk93LEfRMA+4+6rK94+tbPc9Y7BbqpFljxxIuZ3dL3bQvb8hNDGXspRvrUk6KiYjH/OfQN9B//dkgWSvyr6D3Y9YRd2k82j7N6wXajQrGFeb52mw3AmhCRiT/Hxc+Raqz6/MGGgM5Fy1ybSKe0G2qOzkaW5+6b6ws43QBPU8tKFcyoC93I7OcJC01dB5l6zg2DffN3GOOb6RzKPpiv+GC1g6G+WMSTzJYj90YnpKJrTfgKmWllSb8re18crmPz/YGUAMMaP4RhRLz1Blr48Ct/cH8qlf+hUsApd5QfaG+CmcdvjPF7ua2or19A1L1PtVNAuCjiXbU4B8tHsDB8WmekVRtapzmZGUmfa4uw0Mc/zwSVMskf4q53pWT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3067f3-5e41-41a1-29b6-08dc5fe8a4a4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 20:46:38.0196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYwQ49FY8vBb+SHoj6CBTbDD2yIXe71b917kztRZl1Fe3AojiYu0nIctqFdlPUn8fiek86DcRPoIs8QNfoldJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404180150
X-Proofpoint-ORIG-GUID: 4UApDOh9G3aNPNuW6ealq8HTpmoK51xH
X-Proofpoint-GUID: 4UApDOh9G3aNPNuW6ealq8HTpmoK51xH
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



On 4/10/2024 3:03 AM, Eugenio Pérez wrote:
> IOVA tree is also used to track the mappings of virtio-net shadow
> virtqueue.  This mappings may not match with the GPA->HVA ones.
>
> This causes a problem when overlapped regions (different GPA but same
> translated HVA) exists in the tree, as looking them by HVA will return
> them twice.  To solve this, create an id member so we can assign unique
> identifiers (GPA) to the maps.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   include/qemu/iova-tree.h | 5 +++--
>   util/iova-tree.c         | 3 ++-
>   2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
> index 2a10a7052e..34ee230e7d 100644
> --- a/include/qemu/iova-tree.h
> +++ b/include/qemu/iova-tree.h
> @@ -36,6 +36,7 @@ typedef struct DMAMap {
>       hwaddr iova;
>       hwaddr translated_addr;
>       hwaddr size;                /* Inclusive */
> +    uint64_t id;
>       IOMMUAccessFlags perm;
>   } QEMU_PACKED DMAMap;
>   typedef gboolean (*iova_tree_iterator)(DMAMap *map);
> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
>    * @map: the mapping to search
>    *
>    * Search for a mapping in the iova tree that translated_addr overlaps with the
> - * mapping range specified.  Only the first found mapping will be
> - * returned.
> + * mapping range specified and map->id is equal.  Only the first found
> + * mapping will be returned.
>    *
>    * Return: DMAMap pointer if found, or NULL if not found.  Note that
>    * the returned DMAMap pointer is maintained internally.  User should
> diff --git a/util/iova-tree.c b/util/iova-tree.c
> index 536789797e..0863e0a3b8 100644
> --- a/util/iova-tree.c
> +++ b/util/iova-tree.c
> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterator(gpointer key, gpointer value,
>   
>       needle = args->needle;
>       if (map->translated_addr + map->size < needle->translated_addr ||
> -        needle->translated_addr + needle->size < map->translated_addr) {
> +        needle->translated_addr + needle->size < map->translated_addr ||
> +        needle->id != map->id) {

It looks this iterator can also be invoked by SVQ from 
vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest GPA 
space will be searched on without passing in the ID (GPA), and exact 
match for the same GPA range is not actually needed unlike the mapping 
removal case. Could we create an API variant, for the SVQ lookup case 
specifically? Or alternatively, add a special flag, say skip_id_match to 
DMAMap, and the id match check may look like below:

(!needle->skip_id_match && needle->id != map->id)

I think vhost_svq_translate_addr() could just call the API variant or 
pass DMAmap with skip_id_match set to true to svq_iova_tree_find_iova().

Thanks,
-Siwei
>           return false;
>       }
>   



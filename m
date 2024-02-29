Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E630FC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiE3-0006Ru-Ni; Thu, 29 Feb 2024 10:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfiDx-0006RS-W5
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:21:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfiDv-0004L0-5e
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:21:29 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T9rbsY012454; Thu, 29 Feb 2024 15:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9+Tj0kL5TDmETMfEFVO0AgEedGha45oAIaJSimiT1/4=;
 b=DruBCi5mGE1WMl1ZObXzxHbZZGIT6F/w40dRs02SD0XSrFiNg6Iua8vpDcwnUWtVptac
 GPZHh6AUPTG4UclxCZXiRlKfMoxptkMfNHh0ORaQUh4b5xMOaYv+pJDTGP3sgVzcFdgj
 FHiL5/XQlEGkqytwAE16uyKqkeWFr0Pb5qvGhn1uwj2OMFS5XW2Fvpy9zRgpM1m1o4hQ
 twA3CrE3zgvi9OT1e07BXtDSzgQpkUMw1/5/egk+k8QlPgLgB/F/D7SDr+1PCU9440GF
 6cac6+Xp4heF6wrzPy+Ix3cr/3fH04fCk9Am1zFH3nsmeRRA1FZSXBKbEMoJo79SwrAd qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82udg5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 15:21:22 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41TE7LUV009588; Thu, 29 Feb 2024 15:21:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wjrqkanny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 15:21:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPTXshT2hc7/sspCjyF3IHXowjygm4BXurOaicHwncPf4lf75I3yYdpn+D3t3DLWrG/RGVfaRv66v9FDMNvUbqnAX1t/KqDxgglOqbHmHoagLuG6Krt8j3xcbVWZOWLmiqem3s/VPocwnTdOgD66MudlHSItuvpBCq2Sktm4kInHkLv6UW6dGX7kfGnxjFPXycmHxypDtZX/396WDYff2bbKUtOHQFfMSzw503huhrgo3HTFUreckkHRoz0P6PLjwril0gXiqau7fzWUAdLykv5vM9gwkspV06VpKe9z+8tSaqvOOlZfXoOibGD3ptoeQFbYpu7/qUwD7sHLRZAjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+Tj0kL5TDmETMfEFVO0AgEedGha45oAIaJSimiT1/4=;
 b=QWujq+urFEeQGZ094ZLiDsLIZzkGOjS3Ni+4u6nS0AfVICORplaDqgfH/DB9DUK0zivs3Fs84JSLfGKOq3da93EtzbcCZHtXHKa5/j4WPqmqRq757djtFDoArEU3lvqUrITdlZ2t9kPVr+i3zrAR0+goYCXBR606vbc0GHqPTpRFmg4qhsf9Pc/3qM7/+2tLkQsipUwTmMBqKNrIoglMjkn/Sf7Hz50tcbQbtUySKwUXiyJ8twzWBRKcbCN5ozX1gcGedsgk9QAyuDGLQYbxxEU9jg4CKqn/k1M557dOHTKNlO+sfB/k/Wn79EYDmy4O9m+jsO1aBcLfv30+nkdoPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+Tj0kL5TDmETMfEFVO0AgEedGha45oAIaJSimiT1/4=;
 b=E5Z3a81qoBFOoEEAHSUPQca4pMTq8WiYpbMfp2wtVS0U9z+KsIsQ4+VcRpxyzUZS/3mplmOGNr8vP0vNvMT/QZZ55/eQUrcdgk4VuoVwWnSUnebUreA75/CQ5+4P838mr9LI88XFcQ91MyR5GgD3r2LjSgsOHpDC1n4KsX+FwHw=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH3PR10MB7986.namprd10.prod.outlook.com (2603:10b6:610:1cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 15:21:19 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 15:21:19 +0000
Message-ID: <9d560585-8f3b-4ad4-82e6-333e8c74b496@oracle.com>
Date: Thu, 29 Feb 2024 10:21:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/14] migration: stop vm for cpr
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-11-git-send-email-steven.sistare@oracle.com>
 <ZdvyuazPp6Lrn5Mr@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdvyuazPp6Lrn5Mr@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0077.namprd03.prod.outlook.com
 (2603:10b6:208:329::22) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH3PR10MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e405d2-c8c2-42c9-198d-08dc393a1469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83vv2sy/us7dtcc4G9UCGMvsDDRdpgySBACvUaPSHwROhKlWSWlwu2S/dN/CWVtzTcnz62sp6+vxmRZVLdlOpQrS4tWqXq3iz47gsAvCC81tWxgQkmvKAw8G60P6q+snAs+ZKSlUr9an/FKgKQ9c0I4FqMP96MswICLVebwfRQhr0UGW+nZkAXKB8Ap3k8Krkml4d88Ahj3aeqTOdOsNQCBlbuyBrsQ7c5mtKugIB8PaYpZ3X5UfIyXeYm/G2AFMJmWhjG8Qvdxfr45dP9xU74p9lXcU8nwxh0G+iX3aX0nbHp6xE6FOE6bvqW76Meq9gUYwiFj9CggTBawMKR/43KZrJwjtK9LQe5dQsaF1rqWMlSxhBoz2YEMQKWc3bQAZC5H6RLHvFVey2Gniz7BC6sJRQRv5Cmr47B3pzAIrhdn+VubzipGYF2JfHTiaXsrF+oICTaDYYBaZt+E5nhKNvB1tZPnLI6f1eef0iTsmM5IHnFuevkoLFk0JaHmkXuOGcKalKw0ZldAcVOaaeuEc/T6WQcahlLMLAIF+08NueM4S2rwaZsHyiwtxDcCFNPCNHl5FHHgsGQKpojorjMIsMX4vlxSMWGCLFz5Zq0f1o2O778nJZrdYx6innSojaaqfqON5zkjSGO/NMDagHchASw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czlnL3JDY1NTeDJYUTVETHhkSlFmWkZFWEZLTWl3eHVoeG44dWVVcmd4a0pk?=
 =?utf-8?B?QnBGbUNHN1ltang4ZFNhMkRzaHVtWmdHS1l5UWowWGJsSW0zMXNSbm9FdjRi?=
 =?utf-8?B?ckdwbmpDRUplalgzYVoxcnRnclc3UWtFN1JxU1VzZnRHSmx5T1N5K2VqQTE4?=
 =?utf-8?B?YUpVN3lUcldXS0MwaURscHd5cTFlbVdOWjVWUXRqeUFVdHFVZFAyQ3lERHVG?=
 =?utf-8?B?TEQ1cTJCQU9JNEk0NWlMbXhiR2h6bXN5UWIrOUpPclAxL01JcWV6c28xdm1T?=
 =?utf-8?B?eERoUXJkdW9EZFA5ZmdqQVFoZXNLQmlEbE84L1ZZT0Z1N0NoU0IvTWFXdEJ4?=
 =?utf-8?B?WVJoZ21ONzEzWjJ5bCtORTUrRFhtTS96WFNWblRFYllJTEJLeUdBMmhlQ0ZM?=
 =?utf-8?B?NlROQk9ScENyVkpvb20vSkk2aHlRc1ZqTDBtZVhuSlkzQVpzdGRJeXkxTzRw?=
 =?utf-8?B?MlYwdlNpWDlBMzg3WWdTQ1NnOG9yeFFCb2dTQVN5OVlhSHEyWDNqZFlicTBu?=
 =?utf-8?B?NWNaTTAvc2hrSHhpNEZLR0pJdlJyeEtQZWFydUVoanBINjk1VkU2a1lnUVh0?=
 =?utf-8?B?T1gwSUVsVW9kSkR5WXZ1RmViUnZuc1VweUlDR3l2eXEza2R0TTE3c1pEb2hR?=
 =?utf-8?B?SWlDNlMzZ2Eydmh2VnZRQXBrOVhpQVkyczFhZlZhYVJRSXRMSUxRc2lES21R?=
 =?utf-8?B?NzlPRzV6Y0ZjZFVlRUN5WlI2SGY2bG9BTFlVQk9QT3Q3UEZodHdHbkFFN2dN?=
 =?utf-8?B?dzRybUtRZ2d2dTJWZkJUNC9SQVloR0pKeW1GaGpmaUZHd1FUK1dRZHBkVlVn?=
 =?utf-8?B?MU96U21RZnNvUm9UTWMrSG55dDhydUw4bUV1SzJEUFNOOWFZbWFJMlJSbE5h?=
 =?utf-8?B?WDloVnZzLzhYMkw3cE5wSkN1K0NZcVhuMHF3OUhxR0RmdTc3R3U0REJKdUtB?=
 =?utf-8?B?OFMvSVo4V3JLclBlZytpTkV0WmR4MGYxZ0orRWNIcHBHMVd4UzRoSXcxV3V3?=
 =?utf-8?B?ekZGRU1ZczRvajFzcVpQV0dWL1dsT0dnLzQ5OU82N1FxdmJHWGlCYm1ESzdw?=
 =?utf-8?B?K0ljbEJqQkJXR3hJaEZaczRVUzlzYnN4SG8xaVJJYXU0K2wrVzAyTzVjMTgw?=
 =?utf-8?B?YXkwdEVhNmp6c0l1ci9EMkRlVzVKTHZNaEI4YVE3TGVzUTlHNm9PK2htUjE0?=
 =?utf-8?B?RGk1eThySm40YjZLeFJaN2M2N0hQYklRT2o0d2liNjZOdFkrbU5wV3AxVEdh?=
 =?utf-8?B?RW9wbmQvek1TZWhPb3QyK1R1MGllb1hDTWE3VHpoUVExT2JUcGtpRzNjL2Yr?=
 =?utf-8?B?NjJHdWM5cVRFbHJ3WDB1c1R0d3QrdXY4Uy9Ha2ZobTJzTmdOVFhLb2tRRDFL?=
 =?utf-8?B?M3hMVmZTOThQWFJndHB0ZHVyN01XaVJJTkJjd0lmN3pTR0tIVUZLUWcvaTRi?=
 =?utf-8?B?b2lEUStsa1RiNU1ET2xWL2dlblN2YS95Szh2azNxd1U1WkRVcXd3SllsSWps?=
 =?utf-8?B?UGhwQlRmdXB0UUdCSCtkakFtSTdhbHNrcUJjVFFZZGZ4ZUQ0UWxTeXlKYmI0?=
 =?utf-8?B?d0RKMEFBOStiL05jdkdhbjBoSWZJeHVYVWxwdmFyc0dLQzFtVDJUQ1Bsc2FL?=
 =?utf-8?B?bmtlY2RVbFpvdWZtZ1VPUjdSSEhpb0pXTldsZEZxUFYvUWpnQW5xdTMwQTBs?=
 =?utf-8?B?UFNhVVoxSXNHYTV2bzRNQW1TWDgrSVhlV3NVR0tGU25GcWhPVzYvMUx1Ujlm?=
 =?utf-8?B?eTJUQldZeGZwdkJpMzEyS1FFbk5WMWc4MUZVUk5EWk1BSHVTQzRnNW9QT0sx?=
 =?utf-8?B?WW92ZGVrQzhBM0tpZzVQU29NdEd5TDU2ZlJSdnl3d0xwNFdENFE0YVN5aXdZ?=
 =?utf-8?B?dWF0Y21ldDRJWlIwZS8yemJ3Z3E0ZUhGc3lpa1NGY2U0SzRvMW5pRmZhdTho?=
 =?utf-8?B?RnZ4K0ZSVlFLNGNBZ2FIVzBseWNtQzJJYzRrMnRBUEIwWmF6ZU13WnpEaHZi?=
 =?utf-8?B?cUltRnkvNG92RXloZlNKRGhpRmhyakl1S0d4UkllMm1GRGtONUFrNzN4NG1T?=
 =?utf-8?B?UDAza1IvQVJTSUVTTksxOFNhbFlpaE5WV1E1aDM5K0MvVGQyNi9peVlEWE5j?=
 =?utf-8?B?SHgxNnMwNjRqVHZoTHhvWWhOQ3RNbVpFcjVuZ0c0NCtwdFA0S2JJcGtNVVFn?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TmqT3ZB8UB10nAxzcLyaLGauaBOpB/xsgXP20cZdpt2/FM5XANkicECbz2ihaI+59JR9wgJjiPb7U4KmtoNfV/7SBxATGfh8r10STDt+m8zkNukOOb+8SYHR2t/HnzFnVe8mpf1drZXzQLJ/2A1EgLC7xJEy5fQlvKJniLNbj9Z5slm6oGwj1xjwXc2Zn53dzrk0X8I4+QyKJihJCmMkehfdTgxjwm9rSIqg16WgzCCgaGkeS3ZtqjxUTXIZNLxoGkEG0sHPXs19kHasfS82v+jaU94RRGYPl5cpf+uV648FxPwGbdatBaQRtnSY1MKxTJETexQjBysSNchXzPjbyZBxwmwzeV6WDKkR/B9W2ypqcJ9Gy/E9khIosWB0HWgGE//DY4pg9+Usgv6z/nxNkgFrnaa+E1GWHtQVt7/Yx3DnR3Xr0YV20Fg2AP3EBpxZn77t3L6yfHM1qIxdAMrIozVDPwcuKzqypiZLpUqllLmLTEx3Rjmc3lbXBX5ikIN5OylLPpFXIEOJ6eOT+rR/NkQCBWfjaR7L1688i/POqTsrmwmB1u9UXwLW79WtMe3x7otEuewW45KOp9FfgpriAqArzuxmSqAgAgFz8npKrHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e405d2-c8c2-42c9-198d-08dc393a1469
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 15:21:19.4398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0j7Ae8TFbs780RtbE4e8QWT6L1P+pQ7qgHr9ixplt5GxPpFYcQ0ArOWZZAqqUE/2ARxYFLoSezpP8UOC9Wev8DUAjbhDIgQzG9LxZRrPdeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290117
X-Proofpoint-GUID: cuWoxswg3ibcEHQf3rY8NENNW7b9D0wi
X-Proofpoint-ORIG-GUID: cuWoxswg3ibcEHQf3rY8NENNW7b9D0wi
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/25/2024 9:08 PM, Peter Xu wrote:
> On Thu, Feb 22, 2024 at 09:28:36AM -0800, Steve Sistare wrote:
>> When migration for cpr is initiated, stop the vm and set state
>> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
>> possibility of ram and device state being out of sync, and guarantees
>> that a guest in the suspended state remains suspended, because qmp_cont
>> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> cpr-reboot mode keeps changing behavior.
> 
> Could we declare it "experimental" until it's solid?  Maybe a patch to
> document this?
> 
> Normally IMHO we shouldn't merge a feature if it's not complete, however
> cpr-reboot is so special that the mode itself is already merged in 8.2
> before I started to merge patches, and it keeps changing things.  I don't
> know what else we can do here besides declaring it experimental and not
> declare it a stable feature.

Hi Peter, the planned/committed functionality for cpr-reboot changed only once, in:
    migration: stop vm for cpr

Suspension to support vfio is an enhancement which adds to the basic functionality,
it does not change it.  This was planned all along, but submitted as a separate 
series to manage complexity, as I outlined in my qemu community presentation,
which I emailed you at the time.

Other "changes" that arose during review were just clarifications and explanations.

So, I don't think cpr-reboot deserves to be condemned to experimental limbo.

- Steve



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ABFC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjyZ-0005am-R7; Mon, 11 Mar 2024 14:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjyX-0005aX-UL
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:02:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjyV-00030Z-S7
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 14:02:13 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG47o0011957; Mon, 11 Mar 2024 18:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fhnBXUGBR/4LBiFePSzW7ku5DMWNboViWcGVg3cgUek=;
 b=lqHQ1Bg7njgKDjpRvwdR4BZSe7218MuOiu+Vihu2rUBveZ6CybM7BQ4/8+Axp0v2MT3U
 u+EcBHu60TtWwAVG4xvGiZ6+uTCZiRHvb/n3u3yCJOq1B4GUbsZyV5VNoA8vXjVVhw0J
 jzX0FQAEZI6vANFJ/vAjifHuSV/rXeIx8PqEfdWTAMSRmYAKgh3RTgzXON1p+5N1/qJr
 x5vMJ14BfsDEejjygxk9LYN3O9Lc69A2kJnkfkbcqv/PsYv4Kq5KFMGB9OTIqQPTnQt1
 cCnPMkoSFBRNOhp7dlYhZMF1CzPvuunwqZdeFU0dD9yyGHPyw/iDKKj1nP7McxVgLnaN Vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ec1rn-15
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 18:02:08 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHlAgF033723; Mon, 11 Mar 2024 17:54:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre75uqvt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:54:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwdWLoIblJQcbtFP+Tuj4o1YWfxUMhoiTp3kWUmMyrqYYeMxLyN4SFHWt3wVvwtzNEhAOhQaEULJE4w+71tS+pQ8iaLGZva/fgsM3bt7HmU5wxfXxnvLKw+NBLvuVnTp9qft6C/IcFkTV+Gr+2RSrLETmU0SlRiXdwDWnwcxCc+/dDg4h7hmIL1p5ztxie+FkhbDdbYxXd3005WrXxcZ4CWxOtv2SVdrwLwf3vSzhbva1nrZKzYm+zVIe4i812lP3yvt6y4YVO1UUkLEpa8Ep1/h3w8sEXK+eTMwsx7NP1Ud7Rr8xqwivsE9HPAfYoTBP3BBAPew4Uw2IwyC2Koj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhnBXUGBR/4LBiFePSzW7ku5DMWNboViWcGVg3cgUek=;
 b=U6PaAW/d/wY69L2gjxboLmPdzLxmSjDtCWExNy71KqRRWOBn7wsIgn0LD8ISYQjyvT5YPJz97ExMEAD5/UkRWpSRHyvsbwIZ8q3b2eu1jEQbkSoh2R2Qjts6fR+YJ1epMIsOAmgyoSOnsbaSE33xYI8zn2w2ek6RDhB94HQ+2gkrmlulU6ToCufn/dYGEFWxbiXIXhhPFwP3M2rRG1S5zuKorxVfh0Gu69QPYOxqDih5Iuwg3nxNDNhGuHZ+Rs0VWQVsKoN5l9hejD1OnHXA407cQ8Ac1O1hGvjZtMO5whN6fRdMZPyWNQy2zBcZmjayS/+iky31dum46VWRUE/F3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhnBXUGBR/4LBiFePSzW7ku5DMWNboViWcGVg3cgUek=;
 b=uj8sHH3l3i1w+bC2wq8KHYYJqwpZpNslWKBSBm4ykzx3za9nYdDKLNDBOQH0OwlsrR9VvIzg+/wen2IjELD5AfmKOByX0KOK9vNiCHCJebKHx6RWys0vizriES8NWNAZwYu6Yk8pAUYamhMfOw7nIMVuw8KI2VxuovLYAm69Gp0=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW4PR10MB5838.namprd10.prod.outlook.com (2603:10b6:303:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 17:54:01 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::6130:f924:897d:7da]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::6130:f924:897d:7da%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 17:54:01 +0000
Message-ID: <d69bc25d-d4bf-4ed3-9411-531473ebf088@oracle.com>
Date: Mon, 11 Mar 2024 13:53:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] migration: export fewer options
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
References: <1708985769-280850-1-git-send-email-steven.sistare@oracle.com>
 <592e18f7-0274-4d33-b0e1-543ad39e9d35@oracle.com>
 <87y1b3st6v.fsf@pond.sub.org> <ZeGIKRoY5_VpJjcJ@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZeGIKRoY5_VpJjcJ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::10) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW4PR10MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: f86bc2a5-c918-44c1-8512-08dc41f43b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /W8O2UNz/c1wHCR8EKV4PXHNXrH98Y2hXwRIwy3rdb81A0uamGUD7HYbWdP2FKMEjvDO8bekrYgXhRrSAF5A04+iZb/OjBjvoBviUUzwNoJLwyqh6ml9aa5DH6h8t5By+6LqZMoyr94O3imEG3zwYimhY82uyMxPJLRASsW3/y/vV8ilDbE07Huw3ZDcQCmODQwSTHVfFdYrxnlacpjImzQvrhLLq4S12S5XaNcK2UU5t9kUsCKZ9kKl71uIAxRpwLQuNa8OjMfkfgsMOUmrvVW0amuMScEdTbzdRMyx8a2m9ZympYLhT2GOZBys5nE0ejJIVTs8Ewm9LqVlIAyvVoXWelaHC8booOLKYJmJpnJMDoj5jOmsB3VNP0+bZiRusNnwEwKW+oHv5pjwStL+oWZlF1+Y/9EhitxRIxOwFEBpdxzc7QR4dt5xd5/wzFTHODJeGB3KLYK7jEiHIdx+a1ptAN0TXNpohQ7t9fM/B9VHWZmh0oAYAx08KcrQd7Mj7iAYXBMEGotpGbtWGCbMLyAHX8G1x9b8g5gbZ+2S9WA0wS1R40G8CSn/LdVqC+mJR9drOh8EU81Gt+93PJH8cHg7vIMS3J29D7rjbCcyvd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU92VTJTNXFMRTVvMUxmMFRjQkxFSnNydVZwWTZpTDgxZjVHV1FMWXNCcDdh?=
 =?utf-8?B?elBmNFpXeHhPckx6b25PdllIT1N3T0FIZXVDV3FaeWtqOWJYZXhIQy9pQnRq?=
 =?utf-8?B?V3RnNzJIdndvbXhGdlRkeDdjN3VIWmt6Uys4QmZ1Y1I1MU5HWFRtV3EzUWtW?=
 =?utf-8?B?MkxTRCtHMm1zMDZaSnJoT1N3ZEdOVTVFbzQzNHl2NExZMGJPMDJ2TDRGUWNn?=
 =?utf-8?B?Zm9sWUMxS2NjalNhQ0U3REZ6c2NBSU0ydHJEMGx5Si92ZGNVQ0hmMThZOW5w?=
 =?utf-8?B?RFlmZWRjc0xpbDNybThtUHM5Qk1QVnQ0QmE4aXpFZjN0NFZZY2xlazVOWWZ6?=
 =?utf-8?B?MFBrUENubE5GZ1dPWGJxYWVhUkhvM1VmazhKMnZHaVFCTjVoSWdYaUg5cEcy?=
 =?utf-8?B?MWZ5dDZhMEVRMXVxMXA1QUM2VGZJWDNZb2F3V2VZRlVpRSs2QWVCL3JmNXJ3?=
 =?utf-8?B?b1ZoWGIyL2tBRkFEUTRYVmtiaVdhbVRtenFxTk9STVlIeXViUmtRb01HdHVt?=
 =?utf-8?B?RkpxN2lOR3h3UThGYlFQRlpWam1XSXFpUnZrRkMvcVNFUG9LR2tmRmZMdGtK?=
 =?utf-8?B?OTR3YW01VG9IVUZGa0tvUDFWa1NJVUVJby9IYTErWGJSclVhaUZzdFpuWHAy?=
 =?utf-8?B?b0F4KzYxaXZjYVY5b0tYU2ZFV0xHVlVMbDBka285RDdHQm9tWnlheW0zc0dB?=
 =?utf-8?B?OStXalBqY0puNnZkTWgya2hxZWcwR1dlN0dhL2o0S3hGTFJIRlBRMzQrSlNE?=
 =?utf-8?B?L29rTVIveVVUVU9tejJpT1RwLzEwdTZIalFXWEVBUzNCM1R3Mk1Qb2l6T2xO?=
 =?utf-8?B?UjAwL2NBTGZObkxBV3RYaDRXUlJoRUNuY2VrdVI0QzNtVkc2eHc0SzZmdU9K?=
 =?utf-8?B?S1h3WStCMkE0M0xIVWU2ZEVyNkJTdkt0bExFeHBGWWd1VklYT09MSTRjcXgy?=
 =?utf-8?B?WjBLMCt2VUt4VWpydEVwdEVLZ20xT0NkTHZuMmt2WHdmMkJaWlkzaTR6V09m?=
 =?utf-8?B?VlBPdHd1RHNRbEtlRWYzWWcwQWo4NFlLT0tVVWtoSjZxYVQvbnNYMjNIeGI4?=
 =?utf-8?B?T1MxWFZVa0dxK3YvVFFhZElUcGhrWGNpL2p5T0UzOVltMDREU2sxakZjeitu?=
 =?utf-8?B?Q2lrVUk4NjJtN0FDNXdQNEtaakdEbFRYQVFmRnhBUjB3RXBSWlVGc0RrbnBt?=
 =?utf-8?B?Q0N6ckR2SXhVRXFLZisyMXorMFlEcG9kWEZJaGQ2ZTNOVWR6aGpoZmxTTWZO?=
 =?utf-8?B?UGpRNnJaUXBncHRlTmlQb0wwWk5mSGZZSzBuS3JuR2l6MGt2enlCc1kzcWVy?=
 =?utf-8?B?QlNLbzRNNEtGQ05HNnZyQ3N1c0RvMzcrU1BOMGtlbWZ0OG5ROUpxQ01UOTAx?=
 =?utf-8?B?WlJUQXhyOGVLMXdqU1BxczNRMXp5T3l2TW1QaE1UbE40SGt3QUN4L09ucXdh?=
 =?utf-8?B?U2VnZ2wwREUxTXRBTU5WMWIxNWZjTzZxQ2QvZjZWVE5oaStnaXRlY0pCcUFK?=
 =?utf-8?B?bjNrUVozQnB5cHh6ZVJYOVZpWnhEL3VPNmRrMnZKdWVYUzFlZ0F0eEFRSHJx?=
 =?utf-8?B?dG93S1R2YkliRFdTV1hXUkU3d3dUTi9BT1ZCL0ZPMkNrY3h0d1ZlbnpkZkor?=
 =?utf-8?B?WklHR2pKRDRBcy9sZVRzaEdjL2JCOXZBbGJRd2RuT0lvdE12NHdsMitrR0xB?=
 =?utf-8?B?dUd5WG9wYjdoam9lWkZ3QndGYlJMODhLWCt6N0drdjVBc0ZZSjl1R2thR3Fl?=
 =?utf-8?B?QW05bHJYVVBsa2JzbFlmeG9iVDA1TGtVNXpzTHY1OFVRSi80ZXUzYUpkZjhY?=
 =?utf-8?B?TTYrMlNTclg4VnUzd3BSc0VBN0N6TDdRd1NYcmZLdzVrNGwycmJtMjlUOW9B?=
 =?utf-8?B?VU9yOUo3bnJqdW9TU2E5TmxwZGRoNk1uQ2tQME9mUERQWERaMVhvRXdEem9z?=
 =?utf-8?B?U0FnNWFsbU5zTzlXNEE1dk40UVg1a1pvWk05bXI0Y3N4NWlieUtsVnhHMVZw?=
 =?utf-8?B?eHdPd3NFTXk0UTV4UjAxTlIrZ1A3dFh0UStFcHp4V1lsWVUrd1ZlUEdrU0F4?=
 =?utf-8?B?Qkh4NU5FVkNraTZxcjF6RnBLeEpBRjFFVnVLYzYwdzdYbTArNElRNDNIYTBI?=
 =?utf-8?B?SlgwQzRnM2NFUW85dGVSenRyQTR6QWI0QjZ6SlRNS1dRMmUrYktmYWg5VnRO?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vhm32i9fayGF5oQhtU/zjp5i8FW1PAr0DyMT0LYNMS5XGpxO8aaTTdYMUK0sclBa2GRoqcrJ7uPWrD/HkyyEZt8ph8sHBfWLIIdy3UkqA3LM0uPQu/FMkOspF7oCF4U9qMHPj43/S3qIvunYVqU7f+Xg64DnBGGAoF82o9B63fv5Hw17kyqT14JMDa+7C32oVG3gGWgdBklXp5LmshvlprjAHY7rft5v4rhoh38OZwmZKpz8W0QjFkslUz33gyvys4ZeJu30+XuSAn9qMufXwr6oKBEfMKXlW/22eBR3WpQ41s3njGZnsQ6J0xSgME3qlQLVdIKM/kNhlVIxj3EYN8h1tiSmLvE9CpTP9rw+ChnMXSwM+B5mkO/Z5embm1PSo8/yZ4+3dxL6N5ygfBpICKrwE6RsQxJ2K7nehne+w4/X7ruz1LuwqcxgLycnXaPT6S2ofkkL2o6WqloNiAAVEWi/88TojaQ+kn11abVcaePDeNUv7rqlePmQG88adalrq0zJgvg7qLFUTrzM0QKKdJ/ZECavuWSQOONMgoJoRSgmWV0BD6Qey8/TwhYVqwjyUdWvSoxq0zLRGuURcLQ+fFvpeMoT98tZUEQtcVhrPkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86bc2a5-c918-44c1-8512-08dc41f43b9f
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:54:01.2303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Im8DOsNzbsARbb7KpKui79209B+y0FglpKlhPuaBsiWEz5f/1SknbgZayUQ7c4XKREJ/D+uBhIZtIJ+plk0v26CUWLfqIQ4ZX5Mfg+UfIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110136
X-Proofpoint-GUID: xJ3EamlBPteJGgexab5Hk_2ZmCBqPT8m
X-Proofpoint-ORIG-GUID: xJ3EamlBPteJGgexab5Hk_2ZmCBqPT8m
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

On 3/1/2024 2:47 AM, Peter Xu wrote:
> On Thu, Feb 29, 2024 at 07:03:36AM +0100, Markus Armbruster wrote:
>> Steven Sistare <steven.sistare@oracle.com> writes:
>>
>>> Just a reminder, after our further discussion in the V1 thread,
>>> this patch is still what I propose, no updates needed.
>>>
>>> Markus, I think Peter is looking for your blessing on the new
>>> file name: include/migration/client-options.h.
>>
>> Not my preference, but no objection.
> 
> There's yet one alternative, which is to put these exported option
> functions into misc.h directly.  After all that's not so much, and misc.h
> already hold random stuff from elsewhere.
> 
> Steve, would you repost this patch (with/without my above comment taken)
> along with your other series with a rebase to migration-next?  It doesn't
> apply there.  Re the other series: one nitpick comment on the last patch,
> where you may consider splitting the removal of the unused 2 functions into
> a standalone patch.  Other than that it looks good to me.
> 
> https://gitlab.com/peterx/qemu/-/tree/migration-next

Both are rebased and reposted, thanks - steve


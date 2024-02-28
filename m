Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DCBC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 13:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfJuF-00022l-5W; Wed, 28 Feb 2024 08:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfJuB-00022O-O1
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:23:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfJu7-0003nt-U5
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 08:23:27 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41S6irL0010251; Wed, 28 Feb 2024 13:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=r6/Xn36ioEpkeNLYEceBI9KAZvdgCwn3tKyvXieDnbQ=;
 b=azvBdv63hvRJ9Y+ejjrEOKTUXHAOnHq0Ml3fWyLW5lW86Ote4hds5ByzLvKt698zy0Rs
 LzygHw4w4bOymPI/T8NIxLQJXvqbp4EluSqvUtYCmzy4EnySfCZ1iXWvmh/eLYX+7m11
 QsVzMF6B0PDC4KqOK/lrHiq+KgwKBxCqujhH8gHnRmRNSxI3BG+9cqycyVXMiuK8vPVz
 /Z+pMWOYqlKypknPcNVxbtSKIqeRcnoIn+N2pyn1l2wztNdehujTM3FmSS7xB81xlPtu
 mfxdfFSu8PKZgK61qLp+aO7RPIP8JjyMox2Kl3uRLUSFLJY5uOgANBSHWKJ180DVmpCC iQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bba3kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Feb 2024 13:23:20 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41SCmAk6001763; Wed, 28 Feb 2024 13:23:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w8w63e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Feb 2024 13:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcbJ37YG4GAW6sEZiHhVmOV9ABoVqb46Nkscgi+kpU6AimPFa7WI9hrd0wwSpvwTjwO3JgCROpwyBFRfnYAFU/gDPc4hGbtZedNxOqlxI2qPM3UBZHn4Tq0/8AMPmCvBDd5DybZP1XvQmzWLdf1jKQ5XM+1OgvieZH6+TwTdSs5q9LOz03VYSThNlufn71H5EpgBBBQnoVtK1XIl2qraVH0HsqYJQ/vVuhtOl3el/Etbh3QAmlinD7kUqK6gec1tPa2Yjxad790zpa2featHn2KxIX8HFGKqUICMHkwRRpitota4CZRssiHQx1g6LIuB4/7/TR2SvJC88bNeRSjDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6/Xn36ioEpkeNLYEceBI9KAZvdgCwn3tKyvXieDnbQ=;
 b=JD3pvCq0GEqMNjFYfvJ0wRAzNGHudcZwgcxchP3bt1SML7qGJu8uS6maNxsZ/QQ1gC8+5v84/2pItCqlocrgrp5PxdWnNrS4ItaOCEDkP3LpvVVxjCt/HpLiXWMVQt8Ja4VPloBrap76K/Vgze+Elvc7u+BexwUUFltmjQwbUNGSlAtgAcJaxmex2+6OIs/OqOK+OFCuW3y+pnuKbftNlIaCJ/E6OOCjKMbRyCSkmbSB/lnYCiikaMgMGqOJOzpw+on27w2YfQaOxaOxZqKrxsMaGN9vPc/lMgAk/QsXG6oPhqQ8AO4b/4v91+mvzIxN8HEzVPnn/uZJ8dkl7MLyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6/Xn36ioEpkeNLYEceBI9KAZvdgCwn3tKyvXieDnbQ=;
 b=N1xMB8yYYoEZ7/AKVv7Xpip+vPrbqokddHFi/Q7U1FFwoZ1XY9x5lHOZrVAFRPDGl95+Bs4qlbNxgxKi2vlKKW6+CmlMRhushVNA14OxIf7+f92KIniP55kchYQPuPOKJcv7kfGpJz7vCiQ4dYV5b0pzeoSN3aWVsgAMX+QxynE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH7PR10MB6531.namprd10.prod.outlook.com (2603:10b6:510:202::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 13:23:05 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 13:23:05 +0000
Message-ID: <d54495fa-063d-4cb0-9e6a-4a57a312237d@oracle.com>
Date: Wed, 28 Feb 2024 08:23:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 14/14] migration: options incompatible with cpr
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-15-git-send-email-steven.sistare@oracle.com>
 <87cysh3vg0.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87cysh3vg0.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:208:234::13) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH7PR10MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 33eef9f8-f4f2-4779-69ec-08dc3860655d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srfrYYQF0Z0+bdr7eSuDnC0LHssJ/zXPy0Rgjzw5A23Y+Rp671iTbc22KYpFB9jYIUX+LZ0bjMN2FeKWKct8trtkYJ5trh9urppZYUHM3ekI3c9oICBPLyc00TUp0oifXp59Uo2CJUrYcH39QstAHMbWSQFypj+h6cJTYF/b2+iRqO8LG2MdlDnZqgIVbN0Gnbxbs2n8plF76PSORmK1GMMsgDEbvjnW4J8RO1w3R75k++Yy4kjNGCNSOzVNJkUcZCswAFYU6WhjAYOjkVL28Vp3im8QbE6h6c60fn9OxC550KW0M9QcE7BaQYNrYLslStmgiv0ULALMHQRl9E3WI64hf7oWatpUG7N0Ycrbe+tZcPBxi5II8xd4e4KcFMg418Wk8jQSFfjvB5MzJ0wqql39YyoDWDKjQXM5WZNw6c93L5Utcz69NIHhJbRLg7huAkMKF4CYocrDfnAg28bt4i1XaNsSmnsk/5wCCCVumALLBkB6XtbEGgt7bo909BgcB5gMIE9fdgF9+KAeX4VHyBy7pAHi1qZSKrlWiki9UvkJ6xnFTZ2rDo3qvLB5/y8NpguxKgNHfb5+y16NXjjdqembPWryGw1zZmLWKk5ZEyLDyzZ6ftvu2hRbhuVfNjhvI8718qQPGDweh5YLNFIcwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdhWU12eFBFRk9USERvaWVKemJwYmF5Uk1vV3djYWcwYVhaeFZPbXVkdm9H?=
 =?utf-8?B?bm5kaGMxWXZYRG9hN0hIV3V6SjlmNHZhK0VXNndreUo2YzF1anloRFlrUUkx?=
 =?utf-8?B?T0t3ZVQ5RFg2R3pIeE85akkzQkZNeWx5Z1dpSW1scDRFenNFajg3eDZ6aDFp?=
 =?utf-8?B?Y0tJdjFSRjViclpQM1ZCdEdwcDN5OWhiR294SUNhQ3JaaHFxNXpqd0FPZGtx?=
 =?utf-8?B?ekR5S2ZDUHhoWWJXc0dNRXNhOXJFNy9EbXJJRFh1N01kcmdGd0ptc3d4MnZv?=
 =?utf-8?B?VlpsWXNaQzJ5L1ozdGpJU2RFQjB2bk5pbzNqaGZBRGw3OVVVTGM2WDNaVlBa?=
 =?utf-8?B?QVA5VXJXOXdVL1RZdWVYSUtOaEpveWE4Qzl0T0ZIOFN4UzFnSlQzaTVQVjVJ?=
 =?utf-8?B?UUpaeG9mQXVwRDhyR2JDNXpIekhXSC82UnpSZklXSHlVRzVHMEs2c3orZFF1?=
 =?utf-8?B?U3BkcjhsZFdlL3l4d0pTdTNLNDlUbzE4Z2FRQ0pLMGVWeURMRjhUcFkrWmF2?=
 =?utf-8?B?R0R0NTU1YzR2bklyTEVHNmJ0OGxpTDVDQ2N3MTBYUC8wZitmbUF4RlhJbHpz?=
 =?utf-8?B?NHp5Ujh0Q0pnT2pwVTZteXRWOUNzQUhuOGNvRnNqS2l1Q0srTGtyazdqSFdF?=
 =?utf-8?B?QjczRU4xajZuS3lkL0E1aWJiVlM3N3lqYk16L0o4TG1iZEtUMFMycXpRNjhE?=
 =?utf-8?B?LzlNcDdoYWtEOWZkWUdmWk9UdDJQUSt3NnJrOEdtZHRjbVpsSDRnTjdhS0xq?=
 =?utf-8?B?c0FTbWtBNngwUE5yVFNVS3N2K2lMWHBiMHlPSkpoTGwrMkdRNFBYVUNXd3ZQ?=
 =?utf-8?B?d08vSkY1U3N0UDZSWWlVZjhjamhITXZDZ0tLd2l2cldSbTFuTmlMMUs5VmFZ?=
 =?utf-8?B?YldJZTRrcmtCQjJLWS96TFVxQm56cldqNEpxZ0pDcmhvKytzdkRlbGY3YzVI?=
 =?utf-8?B?WG82L1lFUk8vNVdidzlTK3MyUFF2bndwZzVRbkZOZGk3b3NFWkU4MFhzVjNE?=
 =?utf-8?B?bWpCYTdXWFQ1cDJTYmlNWmlUdFpUQkxBUnpucEs2Y3VWMXBwN0UrNUFod05Q?=
 =?utf-8?B?RU1QL3RtQjNLWVF6dTlsVEFXQktHR29LM1ZScHFJL0hRK0lsQkMwR0RiUXUv?=
 =?utf-8?B?cnhrRHJxWHU3ZlJZb0crQjduR0RqenlWQ0M5OVhNMkl1ZWQwVlZnT0FmSDZC?=
 =?utf-8?B?MWJ6MU9VbGo2TFdSYVAybnJHcTFKYkJ0bjFwMmxQVXJhaGQwOVZPMlIxVEJ6?=
 =?utf-8?B?eE95bVFBSEpzdTR3YWlGYllKVHk1UnJGemJxNURMaTg5eU5DR0VoY0JHZnVH?=
 =?utf-8?B?ZXhjODBTUG1aa09PZVEvM05Bek9tUlA0VWRSYy9jN011akN2aGJCMDFoZkU0?=
 =?utf-8?B?TXJBL012amVaT2hibVJ5VSt4RUpBc1RiaTZkWEloeXlhMWZveEI1T21yRk44?=
 =?utf-8?B?ZFNYaWtZb3A0TkNoV2dCSlhZcHVxQytBQVpTWDdxaEpsQWxhOER4UlRrc21n?=
 =?utf-8?B?bG1IMDB4Tlk0RmNMOE5sdFhmdnMvcVlOZ0hwWUVBNnJNVHZTODJKNUtYcmE2?=
 =?utf-8?B?TFBSNjdubWJqWWVIWGMvazBEMCtUdFgxMlhubHF0M3ZMbkh2K3BRc1ZyY01N?=
 =?utf-8?B?REQyR3VDOFZjaU1JemttNnhZaW04dE9jS0JnSFRtSGZXNGtnSEhka21nR21L?=
 =?utf-8?B?a0xJYW5FY2RpOGZEZk5pU3YwWG15VERzam4xcG5nVDEvcjBEK1NWalpxY0Ew?=
 =?utf-8?B?SnNva1lxc04va1pyb2ZLQU14SVNSRS9Qd0RiUE1md3pvWHZEWUt0ZnhST0Zx?=
 =?utf-8?B?akQ3UlFUOU5uaitCSytQSG5uZ0h3U0Y5bVFvemJiMWNXUGU4VlR4dVYzdGpN?=
 =?utf-8?B?THNMSmkrWFZRV1RiNHlHekc4OUczaXJidlZRaGdEVStzRkhvc01wNTJub25D?=
 =?utf-8?B?R3JiamkyNXJROVNlZUpnRTVvUWpuVDBUSTVzZFprNHdiTjlWK3ViMTl5SVZD?=
 =?utf-8?B?UWZKVUFrTHdQbFEvTDJDVU94Z2FtU25yOUJvYjhzY2VhYTEwdXFGTW9jT3Jw?=
 =?utf-8?B?UEk3WUViUWorRTlXU2gxZzZYY3BHdVM5TFl5cWlxV09aMUVzN2t5eUEzSmV0?=
 =?utf-8?B?LzM0T1A4UGZXMnNGbmpEVEM3a1o4aHduSjBpb2NkTHJZNnE2YngwVHBBMTls?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +JwmOoiH1bN0Jb+EqEwUEonIr8XgRjCk0peR2e9MVEdftoaGpdF0xlcxjxfzpB0t7j69+ZT1xWuYOA9qaQvUyU3XwzzZPqA1bwLz1m6wnSeAcP67bCtaTPJk/GPdOjOfQFUlMOi+ZXDrTW3NFv8sKP1Z2ctWvLMIHan1+8HHx1OFLkazYXQh1j5/d6K6KC65d8SpKCLplvfqS2WlTXa/vaVLRAJVtE22jwVDdmbFoOwprU/tDyIXZEGNXANzWNYIteTRlyWholeuOkMkxm4th1CVWtFrvxRTK5kJVNph//jUHYGcomcpvXt8cF0MCDwZZu8BGt3i9M6CYVHTES7fNAXudqj4anMY4yyNFkq7kET4JqtgSGVRF44llMySH3rkunTrqX+0XqoovAFExSRRXTTpfkvPOXJ6BgWwwAVDsfVTvlZ3M2JYMqO4DsiS99QdE2YrrSrMuF/Rjo2ZxFMLBNUYmTsa0CLPPzUv8w1zzS9ahM9r3jTxWaR2qavWnuk8bj1ciy9I8Xgd1Jj3DjMej6sYBKoRiVAgR4CRn1X0KELhEpLWXNHVpcxIz4ViBv66fxBEUCPQ42zEab3RNqcN61puVoKZaH1HiT9qcZEOSjI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33eef9f8-f4f2-4779-69ec-08dc3860655d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 13:23:04.9770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MnXF6PcGT5hxpFq8nPqaZ1SanCZ/9AsWmZFyTSFJEsz+mqpZmEGdygJYDYT5NApHxlknoJDQsc6EktsyrDqRjmkHRKNrce69BbDrgFFeqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_06,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280106
X-Proofpoint-GUID: jFOynEB8Js69n2W7BvIxs3uB6n-Lt8II
X-Proofpoint-ORIG-GUID: jFOynEB8Js69n2W7BvIxs3uB6n-Lt8II
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

On 2/28/2024 2:21 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Fail the migration request if options are set that are incompatible
>> with cpr.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  migration/migration.c | 17 +++++++++++++++++
>>  qapi/migration.json   |  2 ++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 90a9094..7652fd4 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1953,6 +1953,23 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>>          return false;
>>      }
>>  
>> +    if (migrate_mode_is_cpr(s)) {
>> +        const char *conflict = NULL;
>> +
>> +        if (migrate_postcopy()) {
>> +            conflict = "postcopy";
>> +        } else if (migrate_background_snapshot()) {
>> +            conflict = "background snapshot";
>> +        } else if (migrate_colo()) {
>> +            conflict = "COLO";
>> +        }
>> +
>> +        if (conflict) {
>> +            error_setg(errp, "Cannot use %s with CPR", conflict);
>> +            return false;
>> +        }
>> +    }
>> +
>>      if (blk || blk_inc) {
>>          if (migrate_colo()) {
>>              error_setg(errp, "No disk migration is required in COLO mode");
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 0990297..c6bfe2e 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -657,6 +657,8 @@
>>  #     shared backend must be be non-volatile across reboot, such as by backing
>>  #     it with a dax device.
>>  #
>> +#     cpr-reboot may not be used with postcopy, colo, or background-snapshot.
>> +#
> 
> @cpr-reboot
> 
> COLO
> 
> Wrap the line:
> 
>    #     @cpr-reboot may not be used with postcopy, COLO, or
>    #     background-snapshot.
> 
> This doesn't tell the reader what settings exactly do not work with
> @cpr-reboot.
> 
> For instance "background-snapshot" is about enabling migration
> capability @background-snapshot.  We could write something like "is
> incompatible with enabling migration capability @background-snapshot".
> 
> Same for the other two.  Worthwhile?

I initially was more precise exactly as you suggest, but I realized that
postcopy encompasses multiple capabilities, and I did not want to enumerate
them, nor require new capabilities related to these 3 to be listed here 
if/when they are created, so I generalized.  A keyword search in this file 
gives unambiguous matches.

Peter pushed the patch a few hours before you sent this.

- Steve


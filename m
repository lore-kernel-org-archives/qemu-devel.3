Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD08C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUabL-00051U-D5; Mon, 29 Jan 2024 17:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rUabJ-000513-2o
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 17:59:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rUabG-0007ms-2o
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 17:59:36 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40TJiSVB007798; Mon, 29 Jan 2024 22:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iX3VdpnRXH1UJxC76QoPju7v5YX1belTd2rV2KOWmaE=;
 b=IypneLBBSJ0kTuGX1UGABpyOX+y9uXvkCwotERNNwQ4M4x8ZZnF0a6uhE6H3YRDdmgLD
 rbagjwQPUfhA/5qgRkEscPOK2yWT6piVLVDdUi/Slvsq3wGyyF9zcNdp8pw7rEH/FvdE
 zIMLAtFXwngIgFvlQFBSNowiD9w0NyewruwNoVZWdOcWFr55EPjmBWHe1PRYr2NMYgaf
 AOf0p0yGbeFIwWmz1lSN+mW5OL+VSEzthAbar6hjDbw6s+jJfw4HEjiGoS9l7kilaTky
 y/OaeHU89KgIgO4r05+2VW2egtA4QI/kv/SvZbU5gMaACRV75FVFO1zU8B6kC4x93K+6 4w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuw6pr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 22:59:31 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40TMcs33035241; Mon, 29 Jan 2024 22:59:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr9cbf94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 22:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWUTZXbxm52JSncBS8zyP8PX8yzYlM88B5rAQw2Ve1wcVme7AJD1Axh2L5vY8oGUKs07+sdd/aiXPwzD3VesJhJiE8oJ/CUZcNfkH4xdw0+W7uNiUnq7HXMACbAWVtNZ+NvMhLZW0bA/l33ydCEqG0nOOs6E/vLt49DgcRhf0uK1JKda7hjVCEarlpu+lB1dQ7/+Qa3HaQeoxAwyTZdxLoaQF9CPTLC4AULyPGg+8vVPSLcwvmxn4BIjaLAZAS/p/1J1U5twa4gNpMJGGuGQQNo1JAKG5uEjS5A5Y7iOuU2hFfXGUt9Wjkdbc4KEY9dKXdgxQoCzn+f+tx/4YboKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iX3VdpnRXH1UJxC76QoPju7v5YX1belTd2rV2KOWmaE=;
 b=DGrDUbih9l8qqkjmV5BgGoASKNG7KEioyDpM4FtwMBgF/LuwX915ThhIgaC1A4+AvXGKCipvIATwsVgzbDUPrfLX7iscCbtlANOvA1Xfvp+qsW+aDLmC7TNdWgtwI5ulW1srnZpKgN38R0TVvVvTXtiZjPYgq9w9J9A7RbeGd2IUMwQ2a1RU9Rvxz++UX+kCrFfSQiUF6DqwuJepZ1y6XHxfWGLZGS9tMxUGsGiwiwOq7PanzEXH2DVs5buzGP2M0BOgtcikqFliVybbK591EdXNGw5II8+caF1saR+qFRrl31/d7VKuyaQb450OUmKd8emWuag71WAs+L5zCBcZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX3VdpnRXH1UJxC76QoPju7v5YX1belTd2rV2KOWmaE=;
 b=OguP2GvWPf33G/BDl69cHwhr8YYTTGirY9HcWqHfvmOMwUJUgvotdzOKdpvEbOLqkyxWTsysSRvU00kTiFaey64fv9hvgJkDDXfk0hesikfHAYZghHHlE9hKmZNE48UI0pl9VaAdBoTc5380eKvdYrtOifOVuLYsNI2Es2YUtb0=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by SJ2PR10MB7669.namprd10.prod.outlook.com (2603:10b6:a03:542::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 22:59:17 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 22:59:17 +0000
Message-ID: <93a62006-328c-40f4-a18e-5fbf89cba49f@oracle.com>
Date: Mon, 29 Jan 2024 16:59:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Initialize backend memory objects in parallel
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20240122153219.2885749-1-mark.kanda@oracle.com>
 <c15161eb-f52c-4a82-8b4b-0ba03842188c@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <c15161eb-f52c-4a82-8b4b-0ba03842188c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0697.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::12) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|SJ2PR10MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec2c47b-5ca7-47c5-e2b4-08dc211deb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHE4r98d0xI40McfYxLfb+KhVRwru/Uaj8krkY65PKdqcgxjjQeT2I9TQUznPR1HezFaKjB8o09zriIC6UhVaxrzC8KgwNcz+q/22s8KQUX/aaQyakGGyPPYn22N2HFQM5Z8/PnRT+UwlcyzLsUFZ1hb5VtKgpcC9YmXrzCEqOl43EIHzeXNEz70LsbonVzRAZ2TEZgoJEKn+3le50xtLS5mWaf+uKnDUqmUMnrnu7Od8q4nUfaSWQQ76h2X6hGcle9gYlYd10/8q4n9tC4eTw/lrtwacw/Oa7hVtFO1lFVmUOcMJvncUMgFTHxazixytDgw0HuWqzeoXVS8FBNqGwNaAxaEwpGJMVDX7q1Fh7sJPzBe+aeGzV8I3ykQs48QVXHAPPlxxUuID+8xp4YXBiyvI8rjlHYsKXz7rhqMUf+89nXumlok4czzc07qy0Q6jaoF98mluC/jw6yx6BiIPvlxu97Ssm5WSC2jEteHLeieE+AeFACmv9KsRqJYuw2NJMamLddI+n1oSBvt/TWNjJEkKgMYpKTnpjy3km1dm0xI4x0DP10diwStreFiIsy0p5JMkaz0dmKG5hCU/hMePsI7RnA+xZa5X0zu4mikdWSQvxoZDQej/wfi6G/k51GsiHkfkVG06icI2P07w6UOj8aHTcQ1xjqMiid7EqrsbnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(66899024)(83380400001)(86362001)(36756003)(31696002)(26005)(38100700002)(2616005)(6512007)(66556008)(6666004)(2906002)(53546011)(6486002)(6506007)(30864003)(8676002)(478600001)(316002)(66946007)(41300700001)(66476007)(4326008)(8936002)(5660300002)(44832011)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzRwVUsyZ0lYMzF0LzhCak52SHZGV2dIanQxQ24wN3AycllSSjdTclVYakZB?=
 =?utf-8?B?VTlmcmhzSWFqMzMwMFdPb0xLYk8rdFo5cDRha1lUbzRGdjlIT2NvSXNBQTYv?=
 =?utf-8?B?WnBvME9nd3pBYlUxUnN0a1lkTEFiQzdEbHcybDViajZRWVV0QjdqZDU4Z2pX?=
 =?utf-8?B?ek8zWDVDYmpXTE1wMldMaUJONmFVN21Fa3k4QzZtd2xUdGZycyt4U2FzVFdV?=
 =?utf-8?B?RjNwNU5LcFN1M0w0aGlWYWpkWW5hL1VnQlRVZE1wdk1obW53aVBwbE5LZnA3?=
 =?utf-8?B?YzJFakdyNTVHdGhFeHJyQ29ta1NlNWpDbnU4VFBKWFFpTnBHd0M2cFUwdGEv?=
 =?utf-8?B?V0hHTVFnQ0JpSHhCUFI2b1ZNQ0N3WkViV2J1QTVvaVZTdkp2QVlaeXJoTmk1?=
 =?utf-8?B?VHRtaXQ3U3JRbXhyRFVOcWhERG9IaVZQODFFZ2pzZC81UDRhNWJyK2gyK25H?=
 =?utf-8?B?aHAxbW1zdXRsMTFuR2ZkME9YdExQL1JNNGhxbkVhdVQ5THRvTWl1VnJneHBl?=
 =?utf-8?B?T2FBcEh2V3VadFJuZW9DUXhZQ1BwUEZoNCtNdXpDTG85UE9YcGw2dURwWEpH?=
 =?utf-8?B?NGI3bFNiYlhmajJUTWFIYWNTTjlBaldsTXpmQW5GNUJHaG01ckM0ek53b1JT?=
 =?utf-8?B?Unc2SDhBMXdIU0drSGNFYmp4WUV1Wmk0SlNKa1hka2ZRMVRuVVZPaWEvc0p1?=
 =?utf-8?B?WFhQUDBvZ2lRYnI1RnlWRVgvWFc4U0pjMmdzM2g0RGNCQWlHbm5STHYxWWJk?=
 =?utf-8?B?REgyMHdtcTdEcVJQL01vUHcxN2NETHFnQ0U0dVp4TmhwYXo4bzA5d2o3bjJY?=
 =?utf-8?B?K2pFTnErK21lVlNvTVRsak5sOXMybXVtYXhnaWF5bzZ2ZXdhWk9ER1V0Ull0?=
 =?utf-8?B?Tit6S2w1dTNJc0xZbmRIRVFONGtTeEVwSVUrZTM5VldJanNsbDZqWENWNmlm?=
 =?utf-8?B?bEowRnNKNzNJQjl5WEdqUWZmSE1vcEpDSmtVcFBLRkxRSkFiemFSaEF2ZDFK?=
 =?utf-8?B?STZFb0RYNzVZMmNKeElGNDJMaXMyc25CZWZQSEtYS1QrWWxLbTRsMlhHYWts?=
 =?utf-8?B?Z24zaHh0dnFjM3lLSG96bHVmM3o1K0xLdC9lRDV1N01ETElGQUxxcmdZamhB?=
 =?utf-8?B?em1IUHJrNU1GSFZ0T25KRDZUMXhJSzNMRVdxWjVQcVcxbFNJUko5RXhTZG9D?=
 =?utf-8?B?T0tnL1dtKzAxUVBRQm9SNUMvZ3M3bFZoLzViNFFIbWtCcGRkeUZaN2JwUjRx?=
 =?utf-8?B?cXhtOEl5QUl2U0hGWmZkS1BRNUdoWkhLSlErMzhyZ0owOG9GVmlhQkVtcUhW?=
 =?utf-8?B?MDVZY2hncktzM09YMVFEYUtLWVl4NmhVU3YrNHdCYktlWUFZdDVMbW5vd2tO?=
 =?utf-8?B?QUo3VkczWjZ3TjFnZHNLTmpQNUVHTzlIN2U5M2c2aVlrZ1crb2RDeGpPZldU?=
 =?utf-8?B?VVdmaE00YUc2Z0pWNkorM3BRN1M0YnI3NGJZN2xiTnRGU0dqRXFFeUs4VmNU?=
 =?utf-8?B?cE9BNHZidytCV3R6YmNGR3ArMEYvd1cvU0xqcnFhL2RGVkJUOHZCT2R0aXVI?=
 =?utf-8?B?aTlUYjZlQmtheEVibGlrOGtTNkN5OUtOc3BEUTRQZHF1N3R6emRsTkJ5bkxa?=
 =?utf-8?B?MVBNZTFZdE1Od0hDN0w4WHlHSFlmQk1TZmpPTVBtMk5sRElzSnQyTW5vdEJO?=
 =?utf-8?B?c090c1hwQ2ZJVHRQUnFZbG4wQUNTRm92dWJhV2NEbmFPRm9XQ0pXK1Q1N1hH?=
 =?utf-8?B?M1RHUkdGOHJYRGdiZ1h1RGc3WUpqZVl5VmpsY2hvOVFpdTJBWTFLV3FHTmFF?=
 =?utf-8?B?czdBZWFHcy9FSHNHVWppVFROVEtqcWJDYmo1MlhmbnhXNUZDM1FsQWJkcVdV?=
 =?utf-8?B?ZlRVd3hMVjljckFwN1o5QUxueDVhaXpPZFNqb25JMDZiRGRPa211U0QzWFRX?=
 =?utf-8?B?Uys4eGNzU3hJS0YwdW1WMWwyR1NiYzZ3RE90akpMWDZWOHNSQWpqRktwSmVa?=
 =?utf-8?B?TUx6TStnTTdIZHI4TDV5amc1TTJOeVZoR2Q1QlJMWjdLZE5YbnFTaUdMMm1X?=
 =?utf-8?B?WUdPRE5mQXd0ekd1eU9ET29XTUYvc0lTajl2RTdsS3FtS2phMkNRZWNDS0JB?=
 =?utf-8?Q?wvqf5q8+OAftE62k0h2ey+rGL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cTjUqNagbeiaub1xD9ZWJjrZ+S4D0t565wkWeuz5TKlmnBhHJTrhCGhzrJefw1XxO+e2vy82fVXhdvZT8mNlREASEVen3e/PYRalcaC11YqD+BEzQYYTq53nJOIB2NVH9v8RONGumUOACTyMzinquErGv7iFqQbpooSlBWD9ctqiYacCANqB2jhdaAwCbjs/GiRQL3RX+Olbn6soBB34Xbr1nU+63kah6kqNrdQC8n5JzFvcrmStH3lh4ncsjIkPk5D9fPTkyKjIudKS5gT4Uj3FQPVpLUeKGV1goMgO6AyjAoaralXs6Pg8lLj50ssc7JoAzO8UAX89heQD6dHVRcPSmOJfM0Jgc4xHHWKyCuHuUbbCeyGuqOcnTteDdxnMUKSqezBCRwQXHfHuRfcWAculqi1sf8/RvoX7jEtMVVhxC9XZWieDvshR7LyNq+2zDaDlQA/FuyxcbWe4X2HkJWFfwVJFr96SpSWtMy67HsBXmVBYZyinDqXGAve2mTX2kuzUFMmjrA3uvQjJNrevhTfkYZ9I8BzFp/RAmKyNLaNLaYc+F5bSx0x3P3cO5/I9GJsQ2J5zxiQlwXgGBQ22lB2aM/djv35+WBazLmfMft0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec2c47b-5ca7-47c5-e2b4-08dc211deb42
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 22:59:17.0809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMPx45z5HZL+lqtJWdvaJkX14aeYMN2FtB8qcOzFaRl1S9ewlhDEStQvKoEbvY4QX8Dh/uVBZHYSnDyNG00MOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_14,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290171
X-Proofpoint-ORIG-GUID: 21g4tpg0nO3ULtqGiEUgQaqVIKZOyRKB
X-Proofpoint-GUID: 21g4tpg0nO3ULtqGiEUgQaqVIKZOyRKB
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 1/29/24 1:11 PM, David Hildenbrand wrote:
> On 22.01.24 16:32, Mark Kanda wrote:
>> v2:
>> - require MADV_POPULATE_WRITE (simplify the implementation)
>> - require prealloc context threads to ensure optimal thread placement
>> - use machine phase 'initialized' to detremine when to allow parallel 
>> init
>>
>> QEMU initializes preallocated backend memory when parsing the 
>> corresponding
>> objects from the command line. In certain scenarios, such as memory 
>> being
>> preallocated across multiple numa nodes, this approach is not optimal 
>> due to
>> the unnecessary serialization.
>>
>> This series addresses this issue by initializing the backend memory 
>> objects in
>> parallel.
>
> I just played with the code, some comments:
>
> * I suggest squashing both patches. It doesn't make things clearer if we
>   factor out unconditionally adding contexts to a global list.
>
> * Keep the functions MT-capable, at least as long as async=false. That
>   is, don't involve the global list if async=false. virtio-mem will
>   perform preallocation from other threads at some point, where we could
>   see concurrent preallocations for different devices. I made sure that
>   qemu_mem_prealloc() can handle that.
>
> * Rename wait_mem_prealloc() to qemu_finish_async_mem_prealloc() and let
>   it report the error / return true/false like qemu_prealloc_mem().
>   Especially, don't change the existing
>   "qemu_prealloc_mem: preallocating memory failed" error message.
>
> * Do the conditional async=false fixup in touch_all_pages(). That means,
>   in qemu_prealloc_mem(), only route the async parameter through.
>
>
> One thing I don't quite like is what happens when multiple threads 
> would try
> issuing "async=true". It will currently not happen, but we should catch
> whenever that happens and require that only one thread at a time can
> perform async preallocs. Maybe we can assert in qemu_prealloc_mem()/
> qemu_finish_async_mem_prealloc() that we hold the BQL. Hopefully, that
> is the case when we start creating memory backends, before starting the
> main loop. If not, maybe we should just document that async limitation.
>
> Ideally, we'd have some async_start(), prealloc(), prealloc(),
> async_finish() interface, where async_start() would block until
> another thread called async_finish(), so we never have a mixture.
> But that would currently be over-engineering.
>
>
> I'll attach the untested, likely broken, code I played with to see
> what it could look like. Observe how I only conditionally add the
> context to the list at the end of touch_all_pages().
>

Thank you very much for the feedback David. I'll take a close look at 
this for v3.

Best regards,
-Mark

>
> From fe26cc5252f1284efa8e667310609a22c6166324 Mon Sep 17 00:00:00 2001
> From: Mark Kanda <mark.kanda@oracle.com>
> Date: Mon, 22 Jan 2024 09:32:18 -0600
> Subject: [PATCH] oslib-posix: initialize selected backend memory 
> objects in
>  parallel
>
> QEMU initializes preallocated backend memory as the objects are parsed 
> from
> the command line. This is not optimal in some cases (e.g. memory spanning
> multiple NUMA nodes) because the memory objects are initialized in 
> series.
>
> Allow the initialization to occur in parallel. In order to ensure optimal
> thread placement, parallel initialization requires prealloc context 
> threads
> to be in use.
>
> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  backends/hostmem.c     |   8 ++-
>  hw/virtio/virtio-mem.c |   4 +-
>  include/qemu/osdep.h   |  19 +++++-
>  system/vl.c            |   8 +++
>  util/oslib-posix.c     | 130 +++++++++++++++++++++++++++++++----------
>  util/oslib-win32.c     |   8 ++-
>  6 files changed, 140 insertions(+), 37 deletions(-)
>
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 30f69b2cb5..8f602dc86f 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -20,6 +20,7 @@
>  #include "qom/object_interfaces.h"
>  #include "qemu/mmap-alloc.h"
>  #include "qemu/madvise.h"
> +#include "hw/qdev-core.h"
>
>  #ifdef CONFIG_NUMA
>  #include <numaif.h>
> @@ -235,9 +236,10 @@ static void 
> host_memory_backend_set_prealloc(Object *obj, bool value,
>          int fd = memory_region_get_fd(&backend->mr);
>          void *ptr = memory_region_get_ram_ptr(&backend->mr);
>          uint64_t sz = memory_region_size(&backend->mr);
> +        bool async = !phase_check(PHASE_MACHINE_INITIALIZED);
>
>          if (!qemu_prealloc_mem(fd, ptr, sz, backend->prealloc_threads,
> -                               backend->prealloc_context, errp)) {
> +                               backend->prealloc_context, async, 
> errp)) {
>              return;
>          }
>          backend->prealloc = true;
> @@ -323,6 +325,7 @@ host_memory_backend_memory_complete(UserCreatable 
> *uc, Error **errp)
>      HostMemoryBackendClass *bc = MEMORY_BACKEND_GET_CLASS(uc);
>      void *ptr;
>      uint64_t sz;
> +    bool async = !phase_check(PHASE_MACHINE_INITIALIZED);
>
>      if (!bc->alloc) {
>          return;
> @@ -398,7 +401,8 @@ host_memory_backend_memory_complete(UserCreatable 
> *uc, Error **errp)
>      if (backend->prealloc && 
> !qemu_prealloc_mem(memory_region_get_fd(&backend->mr),
>                                                  ptr, sz,
> backend->prealloc_threads,
> - backend->prealloc_context, errp)) {
> + backend->prealloc_context,
> +                                                async, errp)) {
>          return;
>      }
>  }
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 99ab989852..ffd119ebac 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -605,7 +605,7 @@ static int virtio_mem_set_block_state(VirtIOMEM 
> *vmem, uint64_t start_gpa,
>          int fd = memory_region_get_fd(&vmem->memdev->mr);
>          Error *local_err = NULL;
>
> -        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
> +        if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, 
> &local_err)) {
>              static bool warned;
>
>              /*
> @@ -1248,7 +1248,7 @@ static int 
> virtio_mem_prealloc_range_cb(VirtIOMEM *vmem, void *arg,
>      int fd = memory_region_get_fd(&vmem->memdev->mr);
>      Error *local_err = NULL;
>
> -    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, &local_err)) {
> +    if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, 
> &local_err)) {
>          error_report_err(local_err);
>          return -ENOMEM;
>      }
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index c9692cc314..ed48f3d028 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -680,6 +680,8 @@ typedef struct ThreadContext ThreadContext;
>   * @area: start address of the are to preallocate
>   * @sz: the size of the area to preallocate
>   * @max_threads: maximum number of threads to use
> + * @tc: prealloc context threads pointer, NULL if not in use
> + * @async: request asynchronous preallocation, requires @tc
>   * @errp: returns an error if this function fails
>   *
>   * Preallocate memory (populate/prefault page tables writable) for 
> the virtual
> @@ -687,10 +689,25 @@ typedef struct ThreadContext ThreadContext;
>   * each page in the area was faulted in writable at least once, for 
> example,
>   * after allocating file blocks for mapped files.
>   *
> + * When setting @async, allocation might be performed asynchronously.
> + * qemu_finish_async_mem_prealloc() must be called to finish any 
> asyncronous
> + * preallocation, reporting any preallocation error.
> + *
>   * Return: true on success, else false setting @errp with error.
>   */
>  bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
> -                       ThreadContext *tc, Error **errp);
> +                       ThreadContext *tc, bool async, Error **errp);
> +
> +/**
> + * qemu_finish_async_mem_prealloc:
> + * @errp: returns an error if this function fails
> + *
> + * Finish any outstanding memory prealloc to complete, reporting any 
> error
> + * like qemu_prealloc_mem() would.
> + *
> + * Return: true on success, else false setting @errp with error.
> + */
> +bool qemu_finish_async_mem_prealloc(Error **errp);
>
>  /**
>   * qemu_get_pid_name:
> diff --git a/system/vl.c b/system/vl.c
> index 788d88ea03..290bb3232b 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2009,6 +2009,14 @@ static void qemu_create_late_backends(void)
>
>      object_option_foreach_add(object_create_late);
>
> +    /*
> +     * Wait for any outstanding memory prealloc from created memory
> +     * backends to complete.
> +     */
> +    if (!qemu_finish_async_mem_prealloc(&error_fatal)) {
> +        exit(1);
> +    }
> +
>      if (tpm_init() < 0) {
>          exit(1);
>      }
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 7c297003b9..c37548abdc 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -42,6 +42,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/units.h"
>  #include "qemu/thread-context.h"
> +#include "qemu/main-loop.h"
>
>  #ifdef CONFIG_LINUX
>  #include <sys/syscall.h>
> @@ -63,11 +64,15 @@
>
>  struct MemsetThread;
>
> +static QLIST_HEAD(, MemsetContext) memset_contexts =
> +    QLIST_HEAD_INITIALIZER(memset_contexts);
> +
>  typedef struct MemsetContext {
>      bool all_threads_created;
>      bool any_thread_failed;
>      struct MemsetThread *threads;
>      int num_threads;
> +    QLIST_ENTRY(MemsetContext) next;
>  } MemsetContext;
>
>  struct MemsetThread {
> @@ -412,19 +417,44 @@ static inline int get_memset_num_threads(size_t 
> hpagesize, size_t numpages,
>      return ret;
>  }
>
> +static int wait_and_free_mem_prealloc_context(MemsetContext *context)
> +{
> +    int i, ret = 0, tmp;
> +
> +    for (i = 0; i < context->num_threads; i++) {
> +        tmp = 
> (uintptr_t)qemu_thread_join(&context->threads[i].pgthread);
> +
> +        if (tmp) {
> +            ret = tmp;
> +        }
> +    }
> +    g_free(context->threads);
> +    g_free(context);
> +    return ret;
> +}
> +
>  static int touch_all_pages(char *area, size_t hpagesize, size_t 
> numpages,
> -                           int max_threads, ThreadContext *tc,
> +                           int max_threads, ThreadContext *tc, bool 
> async,
>                             bool use_madv_populate_write)
>  {
>      static gsize initialized = 0;
> -    MemsetContext context = {
> -        .num_threads = get_memset_num_threads(hpagesize, numpages, 
> max_threads),
> -    };
> +    MemsetContext *context = g_new0(MemsetContext, 1);
>      size_t numpages_per_thread, leftover;
>      void *(*touch_fn)(void *);
> -    int ret = 0, i = 0;
> +    int ret, i = 0;
>      char *addr = area;
>
> +    /*
> +     * Async prealloc is only allowed when using MADV_POPULATE_WRITE and
> +     * prealloc context (to ensure optimal thread placement).
> +     */
> +    if (!use_madv_populate_write || !tc) {
> +        async = false;
> +    }
> +
> +    context->num_threads = get_memset_num_threads(hpagesize, numpages,
> +                                                  max_threads);
> +
>      if (g_once_init_enter(&initialized)) {
>          qemu_mutex_init(&page_mutex);
>          qemu_cond_init(&page_cond);
> @@ -432,8 +462,11 @@ static int touch_all_pages(char *area, size_t 
> hpagesize, size_t numpages,
>      }
>
>      if (use_madv_populate_write) {
> -        /* Avoid creating a single thread for MADV_POPULATE_WRITE */
> -        if (context.num_threads == 1) {
> +        /*
> +         * Avoid creating a single thread for MADV_POPULATE_WRITE when
> +         * preallocating synchronously.
> +         */
> +        if (context->num_threads == 1 && !async) {
>              if (qemu_madvise(area, hpagesize * numpages,
>                               QEMU_MADV_POPULATE_WRITE)) {
>                  return -errno;
> @@ -445,50 +478,85 @@ static int touch_all_pages(char *area, size_t 
> hpagesize, size_t numpages,
>          touch_fn = do_touch_pages;
>      }
>
> -    context.threads = g_new0(MemsetThread, context.num_threads);
> -    numpages_per_thread = numpages / context.num_threads;
> -    leftover = numpages % context.num_threads;
> -    for (i = 0; i < context.num_threads; i++) {
> -        context.threads[i].addr = addr;
> -        context.threads[i].numpages = numpages_per_thread + (i < 
> leftover);
> -        context.threads[i].hpagesize = hpagesize;
> -        context.threads[i].context = &context;
> +    context->threads = g_new0(MemsetThread, context->num_threads);
> +    numpages_per_thread = numpages / context->num_threads;
> +    leftover = numpages % context->num_threads;
> +    for (i = 0; i < context->num_threads; i++) {
> +        context->threads[i].addr = addr;
> +        context->threads[i].numpages = numpages_per_thread + (i < 
> leftover);
> +        context->threads[i].hpagesize = hpagesize;
> +        context->threads[i].context = context;
>          if (tc) {
> -            thread_context_create_thread(tc, 
> &context.threads[i].pgthread,
> +            thread_context_create_thread(tc, 
> &context->threads[i].pgthread,
>                                           "touch_pages",
> -                                         touch_fn, &context.threads[i],
> +                                         touch_fn, &context->threads[i],
>                                           QEMU_THREAD_JOINABLE);
>          } else {
> -            qemu_thread_create(&context.threads[i].pgthread, 
> "touch_pages",
> -                               touch_fn, &context.threads[i],
> + qemu_thread_create(&context->threads[i].pgthread, "touch_pages",
> +                               touch_fn, &context->threads[i],
>                                 QEMU_THREAD_JOINABLE);
>          }
> -        addr += context.threads[i].numpages * hpagesize;
> +        addr += context->threads[i].numpages * hpagesize;
> +    }
> +
> +    if (async) {
> +        /*
> +         * async requests currently require the BQL. Add it to the 
> list and kick
> +         * preallocation off during qemu_finish_async_mem_prealloc().
> +         */
> +        assert(bql_locked());
> +        QLIST_INSERT_HEAD(&memset_contexts, context, next);
> +        return 0;
>      }
>
>      if (!use_madv_populate_write) {
> -        sigbus_memset_context = &context;
> +        sigbus_memset_context = context;
>      }
>
>      qemu_mutex_lock(&page_mutex);
> -    context.all_threads_created = true;
> +    context->all_threads_created = true;
>      qemu_cond_broadcast(&page_cond);
>      qemu_mutex_unlock(&page_mutex);
> +    ret = wait_and_free_mem_prealloc_context(context);
>
> -    for (i = 0; i < context.num_threads; i++) {
> -        int tmp = 
> (uintptr_t)qemu_thread_join(&context.threads[i].pgthread);
> +    if (!use_madv_populate_write) {
> +        sigbus_memset_context = NULL;
> +    }
> +    return ret;
> +}
> +
> +bool qemu_finish_async_mem_prealloc(Error **errp)
> +{
> +    int ret, tmp;
> +    MemsetContext *context, *next_context;
> +
> +    /* Waiting for preallocation requires the BQL. */
> +    assert(bql_locked());
> +    if (QLIST_EMPTY(&memset_contexts)) {
> +        return 0;
> +    }
> +
> +    qemu_mutex_lock(&page_mutex);
> +    QLIST_FOREACH(context, &memset_contexts, next) {
> +        context->all_threads_created = true;
> +    }
> +    qemu_cond_broadcast(&page_cond);
> +    qemu_mutex_unlock(&page_mutex);
>
> +    QLIST_FOREACH_SAFE(context, &memset_contexts, next, next_context) {
> +        QLIST_REMOVE(context, next);
> +        tmp = wait_and_free_mem_prealloc_context(context);
>          if (tmp) {
>              ret = tmp;
>          }
>      }
>
> -    if (!use_madv_populate_write) {
> -        sigbus_memset_context = NULL;
> +    if (ret) {
> +        error_setg_errno(errp, -ret,
> +                         "qemu_prealloc_mem: preallocating memory 
> failed");
> +        return false;
>      }
> -    g_free(context.threads);
> -
> -    return ret;
> +    return true;
>  }
>
>  static bool madv_populate_write_possible(char *area, size_t pagesize)
> @@ -498,7 +566,7 @@ static bool madv_populate_write_possible(char 
> *area, size_t pagesize)
>  }
>
>  bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
> -                       ThreadContext *tc, Error **errp)
> +                       ThreadContext *tc, bool async, Error **errp)
>  {
>      static gsize initialized;
>      int ret;
> @@ -540,7 +608,7 @@ bool qemu_prealloc_mem(int fd, char *area, size_t 
> sz, int max_threads,
>      }
>
>      /* touch pages simultaneously */
> -    ret = touch_all_pages(area, hpagesize, numpages, max_threads, tc,
> +    ret = touch_all_pages(area, hpagesize, numpages, max_threads, tc, 
> async,
>                            use_madv_populate_write);
>      if (ret) {
>          error_setg_errno(errp, -ret,
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index c4a5f05a49..107f0efe37 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -265,7 +265,7 @@ int getpagesize(void)
>  }
>
>  bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threads,
> -                       ThreadContext *tc, Error **errp)
> +                       ThreadContext *tc, bool async, Error **errp)
>  {
>      int i;
>      size_t pagesize = qemu_real_host_page_size();
> @@ -278,6 +278,12 @@ bool qemu_prealloc_mem(int fd, char *area, size_t 
> sz, int max_threads,
>      return true;
>  }
>
> +bool qemu_finish_async_mem_prealloc(Error **errp)
> +{
> +    /* async prealloc not supported, there is nothing to finish */
> +    return true;
> +}
> +
>  char *qemu_get_pid_name(pid_t pid)
>  {
>      /* XXX Implement me */



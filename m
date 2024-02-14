Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7120C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 20:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raMLS-0001aE-Jl; Wed, 14 Feb 2024 15:59:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raMLQ-0001ZQ-FM
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 15:59:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1raMLO-0001bP-Gn
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 15:59:04 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41EIde2O026498; Wed, 14 Feb 2024 20:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OigyOTJdA7pZ4ZwiwKDTZFGs6WXU1oicURM7wANKQ84=;
 b=SkVc+nZN1ISKNpdGjMSZHT4Tz9lGbtwDNG/9K1c8dbzfLGxnR2Nd595ZPHJEB4Af3qYs
 hf1nfCnbIh5m695GSGqRbcby+R156zo/Stx5xejWXGogaxhqXhrtiI0zQ8igt/m+BKgl
 eQ6mXfroOV9XuBp6GGdnfU4gW/KsLVaG48aS9MtzaOJp0OzK9I9wY0iZTY7GxjH88AFl
 ECmCzTW1t58L3GOeTzf/Bx0HX8vBU6m/MlUmkroDfaGHqQNS9Nf2bOrz75XsAkJ/iqrY
 brV3mDU41cq84UZ3mOM6lMqLyx3uwVpXjyQV3Xj9xDvOllpH26CCxmvv67K9dV0UO/aJ mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301g9p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 20:59:00 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41EJmlST015211; Wed, 14 Feb 2024 20:58:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3w5yk9h7cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Feb 2024 20:58:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j57rnh6Rz3uCw/mXNIa6xZG5f8Cja1mceWcfhFVjfC0rtLAuQiONRfJvSXI9fOXLmWT73sRO1x2DzJQnbc1Ja5LrTLM6MNItELysTY66zNtHQVWhpaXxepheqH2sNi2H22DZonDfNVMwSt+bKH7AmJPfQxgfYm2/mD9fEOfWdo7AknE+zbPb/b2H2JUQZPqgM3lxFzSizCAWG+UcxR21DZeoSaBKdMi1bkNLVMZljmL8OV32xNTuJ6JiV3WrmMDQpqBDqYcNW6jXq6nAvFsNyg3gE6T4v3RnKX2Da3xps63x4eRnJRVDdFkzquWgL+G+MhuJtL5pfB3jN5aa/YjLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OigyOTJdA7pZ4ZwiwKDTZFGs6WXU1oicURM7wANKQ84=;
 b=WhEKp47+ewjHyj8p3/i0Uo7kKdOp5Q80oUb/A+xGltnvhCNbdfz/XRX2y0fhFDum/upBC3/m3VMacg1p07lh/tf91MDhocoioVBKeukqfduyKi+HbMF9QUUIh11TKlyxlxWAQGGZzO1Dxm2fEOhG8swLajGdhCqdaFO4cN78vZ1Xbuv2mfCFXLADSX05dKEhZNOCRCvFcqsHxDVZdtP/SCWTufMorTTjI5dF2rz2fXReuJqQAQnVlRIdhe2+fkZQh7+xy5lD5oaWWDxHbc166DnKFTwVd1XG9e/XKWPBWusYtn5PE7VdzvTEUSOwRHLBpjK6M0hpcCFtlhDwzSuFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OigyOTJdA7pZ4ZwiwKDTZFGs6WXU1oicURM7wANKQ84=;
 b=gBVuroXSTiLuVZdUy+j9GBqLdKiApRwQioT1vwjxITC71Nyiy7uJaGwj6cFlo2nTBff5m9Ar2neRguRn5blFBs+/sPoqK9F39kTytxpSQSPaHXD3Vg7ridJFmmgehaMH23c8R62aqXmlNxX593ZNfVikj1o8epKaAb6+6o7C808=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB5291.namprd10.prod.outlook.com (2603:10b6:610:df::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 20:58:56 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::7368:33a0:2dc8:38c6]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::7368:33a0:2dc8:38c6%3]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 20:58:56 +0000
Message-ID: <fdc1ba6f-6e25-42ac-a40f-088501c648ad@oracle.com>
Date: Wed, 14 Feb 2024 12:58:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] vdpa: factor out vhost_vdpa_net_get_nc_vdpa
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com,
 leiyang@redhat.com, yin31149@gmail.com, qemu-devel@nongnu.org
References: <1707910082-10243-1-git-send-email-si-wei.liu@oracle.com>
 <1707910082-10243-5-git-send-email-si-wei.liu@oracle.com>
 <CAJaqyWd1qPmUn3Z=3SSbWT7rX78zza_mt1y6RQwi+62wFbda-Q@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWd1qPmUn3Z=3SSbWT7rX78zza_mt1y6RQwi+62wFbda-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0081.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::22) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB5291:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe785f1-184e-4619-e97e-08dc2d9fc26b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUNImp5jkdQJI3xfOs60eL7DE5sDlAtuunTuUiW5YGqAwWRJcF9o6UVOLCvcX7tpsKrKX2Hs9j6ac1RBZm8bjpZLR5jqK8NLVo++qRxq72zXAczQoAidzn3ejOUB4f+NCBaM8i3TKCkntzp0F8KjSU120hgZjm9bxLngtS4M6w2OTFC97uwK0kLmGqj6Pxdk7+n+ILq0yh+d1eDYsl8ZJs22qpqix02RFaBXOlUt/XqJijRfRXzaJoAQDkkfD9/8vUx52B1GseZj6rMZ1Kp63IQqpR65dsfgqAiTRKk1K2MeCyn94GXlmf/UINQsOjOC5LOsnilKY5LT+DoGiZPpbJX836zujlDwV4MWU8tL9w2oxyUYzC3Cp3aPbkvMeCkUJ5IJJ3Xa7HmYdLtB1nM5Za5xsL6ji00r69Fjg/2l31ITsOVCNbetTniECEVAL53aHwlHRlxJaq3JuGK//dAvjYd44lEJxaHzsYFcJ5YosjspqoOf7OKVPiBGM1hLJ3v7cBZzFRfui76WBEfoSBcFghnHMTavEUgilXz4W0UCy2UjptGo/vYXxV+zrlkLPmUx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(5660300002)(316002)(41300700001)(2906002)(31696002)(26005)(83380400001)(2616005)(38100700002)(86362001)(36756003)(8936002)(4326008)(6916009)(66946007)(8676002)(66556008)(66476007)(478600001)(36916002)(6666004)(6506007)(6486002)(6512007)(53546011)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDFDUGtiNmZ4T0ltQVZybHRaUGFHelBJY1Y5SE5xNDAvWHdLRk5oUHhDeHha?=
 =?utf-8?B?d1VMcDlZQ0lVSGxiWGdzbXBDelZFOFBSQkhjSENreUVKL1I4bGQxQUdLZVlU?=
 =?utf-8?B?bW9tS2ZJMzFhMHlYUHFJMUZZMUREQkIxcS93QmllTDl0Z0N3ZTUrK0VpZW9W?=
 =?utf-8?B?UzlJYklGcXpUYnM4YnE5N3A0WWNwZkJpZDZVL3pHb2ljT2gzdTRhSjQvMzZR?=
 =?utf-8?B?Q2hNYWpSZEgvY3pBWjV1NjFJQ2pqWk9JSFNrbGJiL1BaN0o3U1h0NnREc0Nm?=
 =?utf-8?B?T2hGR3MzcU1uRHViMVdLWHpnNWMxTHNsTWQyUXRKWUFKRWVTckpwRnhMM2VC?=
 =?utf-8?B?Q3dFYm9qUmg4ZXBlQ1l6MTY4M2wvVjdqR1dkS0F0SEVGR0dpZ3k2cExqYlE4?=
 =?utf-8?B?cjhac3QwVGRCUlJMZ2pWZ1paZlA2UFdDTE9WTXdhWmkvOE9rVzJNa3lHWEZx?=
 =?utf-8?B?ZjdZeDF1QkRPOE40aGFOR1k5d1V0RmdoTnFHRUFxYnNuK1RjaUpwYXdaeXhh?=
 =?utf-8?B?WnBlQS9USEp6T3owcldCVXowaktYRVh3ZlNoZURoUkRoYTZENzdhQ2JNdTNj?=
 =?utf-8?B?VXZYa2ZlRm8rbjRabmNTVFJRUmdYT0VGQlVsQS91a3NhZVJjUUtJYkdGUG5I?=
 =?utf-8?B?a1F0b0xNbnNQc0hBYjNOTVgyOFZBM0ZldGU3RC9zWjIrRWxBUE1Nc2crODBX?=
 =?utf-8?B?Uy9rS3BRN2UxQ0s2NXYyK2s1enUxVlRSVHk2YkRQMWsxcGh5V2FXck4wb0tk?=
 =?utf-8?B?ZGhRVVhwMENiY0xDMWtwQVF1WHplb29CbjBFV1NBNmcvNVExdEw0RndPZWth?=
 =?utf-8?B?a3JicXU2UlkyQXk3Y1FMSURzVGc1eTF6RVk1TmovL2llbHZRL05ZeEQ0aCts?=
 =?utf-8?B?WUVxM0JLYWdqMXFCWUNjQXBpQTBoaXdjeVJOOTBsRUNRMGNyOXA5ZW9GbHFx?=
 =?utf-8?B?VE1mNUdLYzZVSkQyalpzSDVUZ0N0Z1l4cmVGWmVDa2RYN0FpYkpoNlVtQzI3?=
 =?utf-8?B?NjF6aERramVwRUlmUDEwR0VvTU05bHhEMUVHOVN6NEtRb1RvTWI1VHhndXU4?=
 =?utf-8?B?dWswZldMeU1HNU5HYitnK0FOWGV5M1QvUUFIaHhmY1BpdUZBL3ZQSHNvckEz?=
 =?utf-8?B?b3hTVDRSUzN6QU9McDBDaTNsVHNZdnIwbm9VQ09yWDdOeHZEc3NldTNzUEhH?=
 =?utf-8?B?YnZEUVpkeWNXekI2bWw1MDJZOWZSN0dBYVA0QVFCYXZaTXJZeEcwZ0kzMWkz?=
 =?utf-8?B?djhMeTdUbzFaK2lzZFVESnlhV29SNzkzaGw2eDBCdWJwSHB5L3BKR0R2by95?=
 =?utf-8?B?cXpEOHVBTTlwS0hpRWdXQ1B4Q0UxM3ZWR09ZcG1XYWhteTNwUk10cjl3b1M0?=
 =?utf-8?B?MS9ib1NiTVE2MzV5MEUwR29ST29za3ZmVGgvRmJWVkZNTEd0R3RheGQrRkN6?=
 =?utf-8?B?Tm9vV21vOWJ5UnNkV3c1SVNoZU9oZktmYlR4azcxMjBIOFRvRGdYMk1GUkgy?=
 =?utf-8?B?ZTNqYVhZRmNEWDdkTStIU0dOTHdjUmVhT3ZlSnB6Unc5eVVrQWtlQWpLdG9Z?=
 =?utf-8?B?UGM4TlpzSWlpdlJqQmhyMENwYUdMVHNsZ1N4UUhuQVNHWU8zVUZnRENOcVly?=
 =?utf-8?B?cTNHbHNkZEhIQlFTMHgzVXhsZHZodG1seWhXMjliN2xrVk5pQktZTDU2YWEv?=
 =?utf-8?B?ZlR1TUJrdnA1SUxmRDZMQVdOd0VQUGNLTW42RVgxNGhtK2l0Um1kQjZLYmpp?=
 =?utf-8?B?MUU5L1NhMzVycEhuNi9UckZyQTB0a1dsNS9kOHlzMGdnTDhSRXRPeStxL01z?=
 =?utf-8?B?czgrTVRWR3c4SmN5ZENqV3h5MENpSDF4THJ3eVhUTlQ5TG1TNys5UWlGK1d6?=
 =?utf-8?B?UndmbGI0UnBOSEtxeFZ4QUM1VnpId0FQV3VEUkNNcStYZ2lLNTIxNSs2RWJF?=
 =?utf-8?B?b21BSkVYcmtaYTlXMXR3QkcrMGNsRi9xbmpXL0NJZXdla2dGRTNIaml3dXR6?=
 =?utf-8?B?Rk9qNEovOUM5MzNodU9FTnFVTWRGcTJFUUZQOUxlY1VHOTJ6WUZhOExEMERW?=
 =?utf-8?B?aTNXalBYT2FuSERZU3hkaGQ2cjdZU1FibWpxbHUweDI0Qkp2MGJ0VGJyMjZl?=
 =?utf-8?Q?tYVMnGnBPUiws3X891dIdL8Rt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pcQZqAq6kBWcWETMQJBXFDmQa0EN0rFnaAku/KkyrBjF/sAhbdk9KdOeyOtCtg3BYLcb5/Xk3174ZdVeg5Way3w6qb6ZpcCJcCXY80jJuhCvo/KlILjaDcnBpgf6MDCAeUTyOcUw6d2/sRw28b4iZQFDCrEvu3c5Ek56wuNnZ+PFUFbJUUgkFV5hvGW6iaXOLSwVKqCt3MjPSyXTdnZi+sK/cJwkE3uCeekJpft2l2EEaEfQa0SaJxS65cKaHOJHeC3ayjH8ZaLjIs0gbXJRpucVPqfyB8tWqrOG+jlZPmZAbEo2luxKn/b2703joCAPjyqJIwDe0c4Bba4Rn8UQbnq87tkgvYgRYxyQFeZxkMg4++48PE7POzBlWFDu8elB5jKJcVOJIC+XPA1phd2bp58D9tRbm2MbA3S1bgzIvdqoMTkV9cIpnP4AePcf+YkK9qRcfa6BVoGKxDymlRlhHCr1yHLmSlCGmQyESRjNdCUNnyJW2o5np/3+pDgnzvHx9OiIQMGO0qZhgKWvId94pn5jmlH6Xu3e0L6z25YjRSFbz/5CFNgWj646tHNCrX4MyVIJ8HppPsm9N1NnyowdztRtZHu2geEvDrND4ON8Mjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe785f1-184e-4619-e97e-08dc2d9fc26b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:58:56.6542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2XW0ab+fZyjDTo6GFnxfjjMc+L+fmheTLIJe/hJ7/XJgOKF0kCzrJFZXvV0N0bPRQPmAnqYtR85QyIWSQOtoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_13,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140163
X-Proofpoint-GUID: jl_W-29_D06XY9Blnz3CBv9seKxbgpqN
X-Proofpoint-ORIG-GUID: jl_W-29_D06XY9Blnz3CBv9seKxbgpqN
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 2/14/2024 10:54 AM, Eugenio Perez Martin wrote:
> On Wed, Feb 14, 2024 at 1:39 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Introduce new API. No functional change on existing API.
>>
>> Acked-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> I'm ok with the new function, but doesn't the compiler complain
> because adding a static function is not used?
Hmmm, which one? vhost_vdpa_net_get_nc_vdpa is used by 
vhost_vdpa_net_first_nc_vdpa internally, and 
vhost_vdpa_net_first_nc_vdpa is used by vhost_vdpa_net_cvq_start (Patch 
01). I think we should be fine?

-Siwei
>
>> ---
>>   net/vhost-vdpa.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 06c83b4..4168cad 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -281,13 +281,18 @@ static ssize_t vhost_vdpa_receive(NetClientState *nc, const uint8_t *buf,
>>   }
>>
>>
>> -/** From any vdpa net client, get the netclient of the first queue pair */
>> -static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
>> +/** From any vdpa net client, get the netclient of the i-th queue pair */
>> +static VhostVDPAState *vhost_vdpa_net_get_nc_vdpa(VhostVDPAState *s, int i)
>>   {
>>       NICState *nic = qemu_get_nic(s->nc.peer);
>> -    NetClientState *nc0 = qemu_get_peer(nic->ncs, 0);
>> +    NetClientState *nc_i = qemu_get_peer(nic->ncs, i);
>> +
>> +    return DO_UPCAST(VhostVDPAState, nc, nc_i);
>> +}
>>
>> -    return DO_UPCAST(VhostVDPAState, nc, nc0);
>> +static VhostVDPAState *vhost_vdpa_net_first_nc_vdpa(VhostVDPAState *s)
>> +{
>> +    return vhost_vdpa_net_get_nc_vdpa(s, 0);
>>   }
>>
>>   static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
>> --
>> 1.8.3.1
>>



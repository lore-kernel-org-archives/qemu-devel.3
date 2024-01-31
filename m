Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DA4C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 14:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVBtS-0008C9-SD; Wed, 31 Jan 2024 09:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVBtQ-0008C0-QT
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:48:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVBtN-0000AI-Rw
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:48:48 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VEl42N002414; Wed, 31 Jan 2024 14:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4JkBWlmYDeIoabxmdyK+GhuMq78LPruIXrvkhIp8Cgk=;
 b=OWsK/L8qt0NMXvA2xGswqew9nIN9OZvl+Abtg2KlVnrd5QPepDJHNiJHmfGF54kttcx7
 6qy3WsYGfvBuWqXzIACzvJtsGLDohtW1733jld0HM6D+Evtp8zPPhhsEbT9/ijT24i1S
 AQeyyZwZHFeVvaUhIvmzC/hgONZu6dxJ/i8a2P6sndrjdBa2TOrpbb8PnGFGbG/TYDqU
 mfMbNgFKXcaNTQFcB79YqIRjmIvnmM5qQgfTQEAiyQMqfJn6DH4yjLMka7J64FggWmqE
 tuKpku9Yc6lXl9e0yy6ZBTDiPJwTjGmaIw9HxaO0GaFLIk11YZ64TtMxkrXPG//hrDff pA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcj5hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 14:48:43 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40VE8d1A036107; Wed, 31 Jan 2024 14:48:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr9fdfq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 14:48:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE/l+YMEqXYOOsaGtiIg0d4Se/y5uR7/NLTrLo2QWJwkXRoyMYVElBzb545ZyEoJ6vMnsOGbN2P4LD7gSvLHBmF0bE02HzAFBkJIm9p3QWYV+YN0WF8AlwDgyXKlbp62omas0gqj8WC+NenYF5kwTGfq74unJa0VoYvbJVG2BAK7TlleA1SPpiuQVw+JTXaQFZpHYp4YvlbExP3CZ0Hwlke967VYcWlMHMl2zmFAwUBI2VlD0GKKJH86Cf7eNqFS+slXOqbYNDucBZOJ+IgRF0+faFXi6WKsjdO2OAs8jIQ3sn1aJg+kX+n4MiGnNUEr7+d7o6pWwDCmPHn0WzLLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JkBWlmYDeIoabxmdyK+GhuMq78LPruIXrvkhIp8Cgk=;
 b=O/zMnL7lEyMeJ5cw/ZtIDN+GZJUTUKGZxmlBPAhkqcLP6LKqeSSbIFoicbAZXwY3U09QZL08JwWpuG+s/VZhlw1jzwJ3lNYy/B7DpKL18HB0/dmJ7J5M1PzFl4E3jYT1p3nAmzQN4V8CH0CdLB2yhQ+vS/BWCpOxmPQrWUTaTBI0Mi48vKRgJApGB9IZ+BaPq9D3TPW358N0sJqtpXKFGMwsr8aA3EnqwHI6cPyFufFS7WtLh65w0M3CjW/hrQk4tdtFnYDZB2olHeR1f6+op9icQQiYm4kH2au9hNXvpw0WsHfpVG3wJEJsCUYIL0fNZ6/QZgDtxsnj6J/oJ+6i3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JkBWlmYDeIoabxmdyK+GhuMq78LPruIXrvkhIp8Cgk=;
 b=Jol29syk4zrnm9S/tGX3Touxp+gn+KDuwgIsve31mTCFuljm9qDBpRjG7Skxkjy/bVOi1ISimgXgdEMod4TlXb72x/Abb3O/juI4n4ATw9pY5FZrG8415O2x8bUeTUrNWTyMJKlSlQjjadlYeFQIZZcltRbS+DypZEXy2RTn3w0=
Received: from SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 14:48:39 +0000
Received: from SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535]) by SA1PR10MB5841.namprd10.prod.outlook.com
 ([fe80::3634:659b:e407:a535%7]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 14:48:38 +0000
Message-ID: <6a5773e2-6887-4cd6-995a-209affd71b74@oracle.com>
Date: Wed, 31 Jan 2024 08:48:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] oslib-posix: initialize backend memory objects in
 parallel
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com
References: <20240131134843.3074922-1-mark.kanda@oracle.com>
 <20240131134843.3074922-2-mark.kanda@oracle.com>
 <46fc0732-8735-4440-b14a-13e2389d7d6c@redhat.com>
 <578395fd-9538-4d3d-85ea-f5e9b95b8bd7@oracle.com>
 <7686daa5-c175-4b2c-a6ad-72d3c78b2249@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <7686daa5-c175-4b2c-a6ad-72d3c78b2249@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::31) To SA1PR10MB5841.namprd10.prod.outlook.com
 (2603:10b6:806:22b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5841:EE_|SA2PR10MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f55a23c-53c4-4d92-2ef7-08dc226bb5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIGxhwQOag/fbr7omJLdB4PCONkdskdOIERL3g4WSB2smihCETy2pTYzqOUKlUMWmEQuknzcCccO5sMM56GEZE3W9cWISIWVKduEnmLBFuM/yWH77bXwqzXrb/SG86plHjiLZVIC4uDGnQwdeSAaQWExFtm7I7vbJFuQhXaIAGHBCQacbXqzJ90aHuB7Dpgj1gMIbrUZXDfdog+gX7oCzd8blGc6R4x8IWpfmzRZWGoFIAGNPqVz0NWSZlqSt1mxSSZFRa3lo14RQYsXYD1+LlJLEgEVU5oVjB7+1RbMi6M+4gWMsMW29tfxUAvxSfBpTCks0jJRo4SvtbljokWqpyWkIREAOfquop+jHoUlrYgu82iMjxT9CFBaYa4P5mBjcTdYR4XppLxKor5b2w+i2Jrw+ZNNXLDFye7o1+qgj2uPs1SsztXsQOgNWiqlp+40WVxgipqfr0RAcsGfezOP8zgD8KLkvn/O9fDG8iedkJUgAyUENNmbW6kdwF/n1taNXt9BMqrWtPwkxAWdc4RIn1tCs7BQxyVtRJidMaKLLnPvi99EbmC2P7zhaOl+H5Gi8DzcBB//D7bsnBmtNP+wHBeuehSJ60qiJRlyJ1nsUPkufC4fzhgd+aubhEooLnCkFgaM+89METzjcEA3ASVk7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB5841.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2616005)(26005)(31686004)(41300700001)(66556008)(316002)(66476007)(36756003)(478600001)(6506007)(6512007)(6666004)(6486002)(53546011)(38100700002)(66946007)(5660300002)(31696002)(8676002)(2906002)(86362001)(4326008)(8936002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0Nob2V1YnFDWmdOQ04vVEtnbUlFWk9EYzJabFVjcGlzV2hSU3BoUWdXcVFO?=
 =?utf-8?B?b3VKSEhKbnBTRERpZ1NsOHV5eFc4VHlHbFVydllZQXM1d3Bhamd6OWZMTWZZ?=
 =?utf-8?B?T21ud1laa01xa2o3akNSSzFMQWthbE11S2NYRm5xYTJZZ1FxeUhubzl2REND?=
 =?utf-8?B?MCt5YWpOWHowZzFsNThQbUlVclFmODVXRmFMTXB0dEE2d1JPMkF4amFyQzlz?=
 =?utf-8?B?ZkVaQWg1UGJsRU5lZkFCeExCZTJIT3UxLzlHOTQrN25WeHYxemNWRTRGaCtB?=
 =?utf-8?B?RFFIT3EyeDFoWVhHd0JjL3BRSlRTeisyWVIzdWZtRW5qNis3UTA3dXRDUmVU?=
 =?utf-8?B?d3JHSXRZVm43S3lrTmw2ZDI1TldtdTQzRlhMUXZHYnRnR3doVE5VdlpqdEp5?=
 =?utf-8?B?eXhWa3RFaXBaWWtRdzdUeEVEcS9hVmFuWWVwS0djeHBxTlV2TUhDZUJQVjBO?=
 =?utf-8?B?bFhOd3JOUDAxVkVHZUVpeFJZMWVVWEJISUFmRmVSZVl3ZWlGdmNjVUVMMTAr?=
 =?utf-8?B?WVBZMXFjMHlZZU1QRVp6bXZLbitaNm5Eak5zdE9GeWFZZXFRS0dKMFk1eDZ5?=
 =?utf-8?B?RXY5dldoZkhBK3o2cUNjVDFheVFQR25HbTBkY244WE1XQTIwUUF2bENLeUh6?=
 =?utf-8?B?OTUza040Rkc3OWt3UXA3MWlyUWJURnZaWHRwNTF6dkVLV1FPTGNrYXNGa2E5?=
 =?utf-8?B?SVVGL2dOUTRKOXgvTXlqdi9iWHJaK1M1UzZZOUJVUk1GOVJNWnJkOWNhZHh0?=
 =?utf-8?B?dGptUlBTOStOQjNQZ0tiSGlhb25McjlFbmVJUzd3UTgwTkhReGxDOWZEZitk?=
 =?utf-8?B?bHRtOFFVbDRDMFJ2aEVBbG1QVTlmU3pFekJmL3BOb1JyOXBQOGZ2dFN0V25y?=
 =?utf-8?B?b3Jpbk85SUlsTjc0KzVZSzM1ZnJlMUJPOHFOamcxb1V6ZXlMMU42UE9LN0dS?=
 =?utf-8?B?RjgvSDB0NTByeHVSamhTbXdKeWt6MkduN1ZSZVN1V2lBT1BOQVh3RUE2WEFh?=
 =?utf-8?B?TWtUZ1k5TVpWa2RVNXBGT1JxNDNFWUxwMWJFSWpGQmtqUkEvb1crL2FNNXFo?=
 =?utf-8?B?S3dxNlYwc1Vpd0dBOGVacnRzeXZzWVFFZ2g5REZ2WDhLTk8zQWxSbmx0Qmsx?=
 =?utf-8?B?MHpFbmhTUmdVMzA5cnYvdGVRN2IvN09kOWNJTExGN1RNR21CN2ZaZmcrWktn?=
 =?utf-8?B?eFhCL2hpWFJYWE5kOXR5WjNqbFJqMTVZZlBROW1HYnloZGJtMURDN1dMb3FS?=
 =?utf-8?B?TGp1RG5VeUtNVXZVL0RxbkhyQXlRNWpSanBRS2Q5WUlFRW1yQ2ZUMUNkeVBy?=
 =?utf-8?B?VDAyYk16NTBKYWpjZ2NOWWJ1Wk9meTdUaHNrL2hONEV4MUJvQ2daTHYvNkpT?=
 =?utf-8?B?RnVGZnUySWg4cmlHWXFuQ282NnNtNmRDNWlGS0JQYkpNNkU4RDIvMlF0VFlJ?=
 =?utf-8?B?RFNPOGxXcDMxc0VrN0hxMWhpeW9mQllSUGZNWGRWUFkxYTNJeVlDS3JvbFZn?=
 =?utf-8?B?N2tORWdwQ1NXbW95ZDBzOGNTU3lWeEd5TXBRVGwwWTVvM2l6dVJpT0tUUU1D?=
 =?utf-8?B?UkxwMVhlelhNRDk5YW1semM3R2FzaXZzSElJKyswRW8wU1hxQmh6dDBnOCtk?=
 =?utf-8?B?VHZiYVVWRDJxZUZJajlnd05DN2hOVjlwQktGYXhqdlEvWVB6OHpaNU1oY1Iw?=
 =?utf-8?B?RWhnWnorOVpQTzBoZkxsazR4V1JHU3I1RDZFVDNlNndaeW1nMStFWFdJd2Ir?=
 =?utf-8?B?ekhPYmNRRmxtREdQZjZsMnROcUtiRFNMWnFvd0FDV2RudHhoSXZNNDlSL0tr?=
 =?utf-8?B?RkxPVmZML0w4elVwYXl3bWRZS203TjhrdzFLbXdIMy81dVBhc0xmK1lPaUtT?=
 =?utf-8?B?Y0h6ZHd2M3BKcmJ0ODJrZUh2Uk4yZjF3TWoxRWF6ZTk4ZG01Rk1KcmpSZTBM?=
 =?utf-8?B?dWtWTjBpaFM3ZERhY3V3alEwand4YXIxQVRuRUlKeFNHYzZuWHNoOUVNem96?=
 =?utf-8?B?ZUZsYVFMN3ZneTd5SlRNeitFQmZTdWNDeXFFQzVUWk9yWXBHSEV2RUdkbnBi?=
 =?utf-8?B?a0YyWFZrL05tcEEwTTlUTUp0OGhNWnZMUUxPdTJxeFJlck95NUtQSjY0ZVY1?=
 =?utf-8?Q?5+wjkpD6f6SJrVaNL0Jafl62S?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: phuQ8D6Vo8Yyx8G/6K6h3GRe49FFIWqTArR5JPjs8OC8X4BVvtlSbrTpe8Jkf44RYy6hvpk0CiIFexrDHca88vieese9RxPF7PoxP/GhX9PWMdQ725G/YtVGHBG8J3vvFIgfKB2gpjpKotuIR1oL0F/gDHfJ27iNMI0QtZmL8dcBdjGrEwhnpPGeMmXcJZsZGjNveOW93I2MzNH7F7oRMeLVj6NADhYEX6a3GZsW5MkF2tuaz3UWWTnFxbHWUSiVG4KvekVPxw5Jhl6JcIpM5kZfyVfGwN7lrd+Kdm2to6YmPAA0NAfpEQrkdMuwbjOoH92X4j9zG1rlWlDJCt8autdeYv89bz62hh+Z4/4ULkbEj3xc7L+74GGWa3FP3PhgR/nh7TgsOjBrdYj+YsZf9ACD+RARyUmgN2gKRAExmtrzEK4ZkyBHBzhfkZY0ooJFm0gmAxT47e5G1g9x85nBzRALaRoJdO+7/QYsPcm7yYB+WQ/mWsBz+ajymVoJHAB6uw79wyb8zfiFkOgfXsoXK5ewRrF+Pcuk7gcmIclkTseYmKyX76IdrEVQj0/Gd4SEU8eCkHJe+Sp840EFFfC5O8X17fGE/gYca2Gn7l9ZnIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f55a23c-53c4-4d92-2ef7-08dc226bb5df
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5841.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:48:38.9470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uqqppjHeXcUoChLLa0YZvK+Eh9rUNkeNrGF6b7uOAfxcT5M5fyODnKMHuCuVMgowjYQjeULGjsgIphznb/kDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310114
X-Proofpoint-ORIG-GUID: ogQePe9HTH0t6GIMmEcGWwVgBclUwXwQ
X-Proofpoint-GUID: ogQePe9HTH0t6GIMmEcGWwVgBclUwXwQ
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

On 1/31/24 8:30 AM, David Hildenbrand wrote:
>>
>> OK. I'll call it 'PHASE_LATE_BACKENDS_CREATED' (to make it consistent
>> with code comments/function name).
>
> But then, you should set it at the very end of the function (not sure 
> if that would be a problem with the other devices that are getting 
> created in between -- if they would be using one of these memory 
> backends; likely not).
>

I think I misunderstood your suggestion. I was planning to add it a 
'phase_advance(PHASE_LATE_BACKENDS_CREATED)' to qemu_init():

    @@ -3703,6 +3703,7 @@ void qemu_init(int argc, char **argv)
           * over memory-backend-file objects).
           */
          qemu_create_late_backends();
    +    phase_advance(PHASE_LATE_BACKENDS_CREATED);

And use PHASE_LATE_BACKENDS_CREATED (instead of 
PHASE_MACHINE_INITIALIZED) for the async bool in 
host_memory_backend_memory_complete().

I was planning to leave this call where it is:

    @@ -2009,6 +2009,14 @@ static void qemu_create_late_backends(void)

          object_option_foreach_add(object_create_late);

    +    /*
    +     * Wait for any outstanding memory prealloc from created memory
    +     * backends to complete.
    +     */
    +    if (!qemu_finish_async_mem_prealloc(&error_fatal)) {
    +        exit(1);
    +    }
    +
          if (tpm_init() < 0) {
              exit(1);
          }

Is this what you had in mind?

Thanks/regards,
-Mark



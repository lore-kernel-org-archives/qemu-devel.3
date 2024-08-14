Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D61C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 19:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seK4v-0001nG-71; Wed, 14 Aug 2024 15:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seK4u-0001mi-7n
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 15:54:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1seK4s-00064q-8t
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 15:54:39 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EI5Ww7023338;
 Wed, 14 Aug 2024 19:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=RDeiLkj3LTGhpwyaMVOeBrqyklNSdqsceHcrhTtpGA4=; b=
 UvOpCsV4UOQpA+vdptSdkReEWe4UBpgTT0Dwv1RFNo9lJ8mo9zWucooOhc2fbqJj
 vR5QzFDdYCNC0lvvXDeINX1ZyQIg/1s+7BkUG4oFH5wQIIl+Wo8D3IsA3oeRXqz7
 S05tNuA2sdZRmsQwpG0amkBNy3gXZohVny7JDVVYfnKIKOGHEJsnh8TTB9L+aFaY
 pPD1WUNPSH5PZdXA9xdPRBWUYU5uqApp8WQ6VELSaGZx05NNDp17g7lkeL/Zw8Br
 tS4YeFFgW6IKsLjjO0UOa0wwEyAsShUsh23p7qvl7h9ZqrGwJtDDu/a0LwOejlOO
 YW+eS2Jz9YMoW3jloEBS3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4104gakwct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Aug 2024 19:54:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47EJ3qkb006085; Wed, 14 Aug 2024 19:54:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxnbcggn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Aug 2024 19:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blbQIpJxldDXA8VvXQMK+X8PHvs0+qn2Ok0yQbGiV9ssaymxzsObLj6O6zq7hhRh6h29UGHBfSBeFtJt9HcZy4Ls9w4c56mspcUsOQkj65xgBJ7o0YK8xzjeNLrNjWzCg71jPLIN28hrxFjDklX3abSD2ZEexvFNm5Mfi+N7qax4Y45D+4Ovy/rqgy6Tq7Qw+WBJsMYg2pH67SoQmVGatKhejuBAujvzckZCBTRfdqLSs8BFIZ2rHuozQ39RGnEM8Hc5dAtV6Z71nW7xQTU04fhU+NXI38Bw/9jJ3DqnLp1RKNNwOAYaEgdRJO7p4HfQ/ycZhXcCHXh3NnJCugLi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDeiLkj3LTGhpwyaMVOeBrqyklNSdqsceHcrhTtpGA4=;
 b=keCuKsEngb/zhBbV6gK4nAKO6YJV9uknCXw2goiVciXRHWiWsWSavL6fjwck1XwXnaaOLpeSTdtR8gGuWfKf8U4qcedYZc8yIGRq6qz3inZJI4w7KGoCfMZOPjjWQZoIOnVRjjgynL7FjFhMA7C51/xB4/5WZght6E8LZF2lGXXrdRh0wJCYKIH2MooSz15Q6dxfKydwCBcg3gh3qa9krXfoy0qwhW2eJelNgJ9fde5eVBmJ3cs+mvTQrd+0Ggwy3HSxY72j/iWUXuWnPuF+jDYi1ys8l+RWspJOQyYmTIt78yJUDg6XMOC38izdRIdJkBeNLKKJvA5djDhbzubGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDeiLkj3LTGhpwyaMVOeBrqyklNSdqsceHcrhTtpGA4=;
 b=s2uxAEz6HDRBDQqjKob2OyN8/VGaiF9Hlh5Z/kMnuHNbEEypD1x3cNgIRyIk2MGr33zYa4r2m2Kp8jBYXKjYjNfF+VF/uZbeLSB4B145ocX/8Xil+whnuctbcuP+HDAFsUABFLZp3UYRVPwZM2gfNynqYNg98GoP4JECmAEXBxs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7530.namprd10.prod.outlook.com (2603:10b6:610:155::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 19:54:29 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 19:54:29 +0000
Message-ID: <48244fb9-eeb6-4446-bf59-8cef9c7d775e@oracle.com>
Date: Wed, 14 Aug 2024 15:54:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 2/7] migration: skip dirty memory tracking for cpr
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
References: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
 <1720792931-456433-3-git-send-email-steven.sistare@oracle.com>
 <87mslhfu2r.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87mslhfu2r.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 4967af0a-05ff-4f68-3728-08dcbc9ae89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0xUTWlFVEtFbmZ5UHlnWkVqTHVCSlBrcGRoYzhwZFBWY000MlFJQk1ldWwv?=
 =?utf-8?B?eHhaUTRmY2thQUkwaEdDMlN6bzZTZXoxUGdWN01nQjBoSHkzWnBUQW1wVnln?=
 =?utf-8?B?Mmt2R3Y4R1Y3WFA0bU9ua3ZId1FwNUU2eWZOSGFzaVQ0c3U0L2NRUTBDRnRK?=
 =?utf-8?B?bTNYZVlpK2VROExIWTd0ZktkTHU2UVB0Q3FrNmZwQTRKQjF5dGxuRHlrT2Zq?=
 =?utf-8?B?ZHEzWjdkSXpPOXVUVzh6QzVEY3YzNG10bnlZU1JwSEJUQWN4aXBpTUxER2Zq?=
 =?utf-8?B?SVFYRExlNWErak0rZnpqN1NBcXFLcHAxRUdvUGphd2pOcGhIRGg4NGJFSkVJ?=
 =?utf-8?B?azNReE1zT0pYY0FpRDFoQzRzcXN1cHpaTDg4YmRhRUVtR2xpVUZoZW1na01V?=
 =?utf-8?B?U2NQTmtyV3h3SFBMNC9jM0U5UFU2b0dYOU5EYWVWK3dJQTk3eUJmVUljM1Bp?=
 =?utf-8?B?akpXY0NLVnBUbk16bjdxcGJFS2o3TDAwZkJWRS9mMXYxWHExOGozSTRsQW9P?=
 =?utf-8?B?R2JXQXFLT2NFUjlFNUVsbjZRMllFZ1FKZ0JrRkl1WHZDRlJTN0U4Qkw3cTdS?=
 =?utf-8?B?UmpJVmdxS0d0bjNjNEZPVDg0N01wclQ5bG8zNDlIOEsrTjdzVFk1bWlxaUZQ?=
 =?utf-8?B?eTNYYk1XNkQ0bjJteU9NaW5oQnQwbGFYR0M5Tk1mUTRFa1V3SWF2aHF3VDZx?=
 =?utf-8?B?aE1YUzVBclM4TnNrY1UwNE5wTVcwNC92RTMzQWZxanJPVzB5TW5vSWFNbkNp?=
 =?utf-8?B?UEdVbTRrU1hlTFJCUFdPQzFFMTZVbGt1QkFZQkR1SFBHZnhrRmNBbDdEYk04?=
 =?utf-8?B?bzJKYWN1ZkZDbWp4WEdnRitkbjN6enJvTTgvQ0pJdDBYMjM1bmVEU3hSWUpk?=
 =?utf-8?B?aGlRM0ZKZFFSUGp5Uk9DeUNsMmVZZWl6MFBYb0FMekZJZFBBbkdGbFpmS08z?=
 =?utf-8?B?cmFVT3FmOVdQU1hUWVR5TGxkMm1Cb0VZaUdrb1EvK2JGcmcyanhaUmNDb1Uz?=
 =?utf-8?B?M1ByZTc1QlgwNWM0YlF5SzlQOFRua1F5aHNmSGdZcEdVTEpRU2hrUE5XYW1I?=
 =?utf-8?B?QzN5eGlyZWNtYzE2akxPZmg2d0RHSVhUNkVNTE9FMGRrdC80MlVUb1BNWEha?=
 =?utf-8?B?SHhJRmZ5YUZPUE93M1pobUh0cENuOWMyZUlKQ2laTUxjcUIzcyt4Ynh5L2Nq?=
 =?utf-8?B?Y1hhamUxSUwxdE1teEZnU1l1T0ZndTRNOXJCcVdRbUJENjNHeVpjUjZGNzh0?=
 =?utf-8?B?KzBvZG9jSkJ6K1VKYnJxVGE4Z1VzN292MDduUHovdDNFbWNYalJYelV2Uktq?=
 =?utf-8?B?RHd2YTl0R0dubVpOZnFPZjZRMTlSZUdBOEppaG9BVUR5TEEvTnVsTFUyQ2xy?=
 =?utf-8?B?VFZGZG9KbzAxVkVZRjc4Z0xjcFZ1b1kxaDdSQ0ZOWjRwOGVZY09uOHRGWGJu?=
 =?utf-8?B?ZzFxQzhDNWZNQW9KMDhMZFpUQ1VVREdHVWkwSXIzUU51RjE2WXdKQzVKN1RL?=
 =?utf-8?B?cjF5K2pSMThFSUpleFdORU90Rjd1OTdUOEEreGdwMWoxbnZqMVBPUFUvRmJr?=
 =?utf-8?B?MG5QbmRSVjk3MjVER1NXSENhbXdXZkJSbUhzY29NMzBCdmtFbVdZWjhlTSts?=
 =?utf-8?B?WUJCaURCZmVnbFVlWWYrSmYxdWVEcWZjRkN1RENXMUFWdlFYRUUrWTU4QnBG?=
 =?utf-8?B?T1J0bVJpdHpCQ01IazUxMEsvbGtsWFN5L3JlQVB2eDMyVkNuNEErejVWYlRo?=
 =?utf-8?B?NndLbFRhKzRZMlVNdjBpbElTOFJEVFRMTmJOYnRrTHpJUk9JSWlWTGUxazBN?=
 =?utf-8?B?ajdsZGZxYjF3OGpHbFYzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDdVb2pjMWxBSWZwOU11MElHbDl6ejBYSm90ZWNOTHpINVJraGJnWWhzZDRi?=
 =?utf-8?B?WXgwSEIzZVMwSWc0azdKUUNPeklSNXZxeG1tQ1dCYVJBWkNXTXVUcDd2WTd2?=
 =?utf-8?B?d0V0OFpUeUJxSzczNjlyVjhDVFkrYnJ1Qm5vNHhTWnpqMklWOGNqQU9xTjJu?=
 =?utf-8?B?cVZydGdPOUs1Sm1Wb0JxMm5MTjdmSUxNWU9LM09MTjhKd2ZsM3MwTDU4a3Rt?=
 =?utf-8?B?YjRzd3Q1VWgzRDRrU0x4VUl1c25adFlmMnZ3SllLaVlvSmZUOTFRRFBQK2FV?=
 =?utf-8?B?NTJ3TFlPUWdHRC9uYmRoaXZDTmtFaSt1TlNWejBRYVN6bjM0Z3VJQnArRU9p?=
 =?utf-8?B?dWxXMEtHVFB3UVh3VjRaejVPcGdCTFJLMTBrYUdEY1B5QjZ6L2pKOGxNU1NO?=
 =?utf-8?B?ZVQxMmt1aDJuc3RzWEJRQXU0ejZNSVJsM2tlUnptaEdiTjBqc01uWnNCT2lE?=
 =?utf-8?B?ZTB1b2hhNG93QWFIbVBjeVdVK1YyZkszbXlrNyt6SWRBZUhKNndqQXJBdCs0?=
 =?utf-8?B?aUR5NTkxTXhmY0puRDAyVHBlMlpnd0pHVG5HaUlZaDBCTmdnT0VBZzZCTy95?=
 =?utf-8?B?Y1Q2T1EzRHIzUU5UdjFJYmI5a1dxUFlGQlI2UmVGRE9ldU14K3MzQnYzTkJa?=
 =?utf-8?B?QUk0d3RSQ2xablhPNmY3ZUQzQmZGNmpveWNxdWpWSDBIejUxQUxUakIreW9H?=
 =?utf-8?B?c3NkOEpxLzRKNzZRVFE1cmEzRGswdzB0Y0tkRFpkV3JmazVDbW94NjM0RytR?=
 =?utf-8?B?cDlFNE9KTHQwTTg2UERpYmxLbkp1WlFLaXFrUUpmbFZYeWxsbzR5bmJMK1VG?=
 =?utf-8?B?WUplN0N3S2hNaC8yUm01cENKSUZxR2ExNTBxVVBBLzh4Y1ZVZ0dFVUVLbkhJ?=
 =?utf-8?B?VWVpWEZ3QUJ2V0p6RUtra2Jaelo3UHRFdlFybjVpL0JVYngwbXh5RzUxTkJr?=
 =?utf-8?B?U2IwMjhZUTExa1BHVnptZE9DMFBTRkQxV3ZNUWVPY1FSMkcrV3NTUjFvNkxM?=
 =?utf-8?B?MTZadisyK3FkMWM5NmU0OVRzOXF3MU1OZFNiUEhBdWpneDdNcUpqaHBSbzlE?=
 =?utf-8?B?QUduaU8xTVRESjVMazhYb09RMGJ2Tm9CNXRpaXlUQnNhRnZadThPZFowVTha?=
 =?utf-8?B?MjhrcEx4TGNlbGZxZjJxbm9jVUZicW9mQndRcDgyZGRiSjlBakdMV2U5YSsx?=
 =?utf-8?B?Yno1bjFudFdQdmRmbzcxWXJaSVRSNkZYRFA1K0IzcE9ySkM5RkZxd2lkdjFD?=
 =?utf-8?B?YjdwT051TjU1LzVLREZqWlZON1R2TnpCZCtjNHJJdGJ2T0F5K0k3VjlERGE5?=
 =?utf-8?B?L1V3cllqd04zZGJkN3EzMCtpb001bThRVDVyZlIyVzVnT2N5Q2h4M3VONXA2?=
 =?utf-8?B?SytNaGNUenFVUmpibUVCbldaMUk5M3NMYnBYNkM3NGhZY1IyU3N0a05TTFhF?=
 =?utf-8?B?RWszQWlacURvMUQwdUpYNHdEZkFuSnpwTE8rQVcwc2xFcHZyM0ZWZDBIUVh3?=
 =?utf-8?B?MmZaeUdFK084aE1IMFlsdUsyUytaT0xpTkhSZVBaN0d3ejEwZVp5TitLQ0Fl?=
 =?utf-8?B?bHFXNjRQeWFHc1BCLzU5UCt1YjVhcCtJT2xDbzJ5OGd6MGc2ODZvNzdIMW13?=
 =?utf-8?B?TXpYbng1Q2U1NHRoNHVtY1AxNGszZjlJcENMRVlaVzF5TW1CNElhdU9RbGhl?=
 =?utf-8?B?OUk4RmVpbUV0dnpxei8yUURVZkNibHA3dWVSVURmdEtkNlB3b0RjaWxuNHFv?=
 =?utf-8?B?MlpUOTVRMUZFL3NLcjJ3c2NVY2JMUGNoK1g4bkpJY0UyVVpmOFFyeGNoK0px?=
 =?utf-8?B?NXV5bzIxVlRPaEV0SWtEdXRia3N2SUNpR2JDR2tqQVNuK0VMNkJHa0NKVjkw?=
 =?utf-8?B?SEwwcjQ3YjZLVjZ4OVBxd2RVamtncHlIRFZjUUViNGoxK2RZR3J3NGcxYVJs?=
 =?utf-8?B?ZTRQWmlIQjc4TUdiZGZkTUZwS09tRWc0eFc5SHpxa1ZaZjRXNzUxOTk2TTk3?=
 =?utf-8?B?dzBpVUlNYS9tYXRtN01WTGtsN3ZLa2tWbk1ubjdMY09BQVJhT2F2OTY0WEQw?=
 =?utf-8?B?UkNCY0VFQkZnNlFHeklxU1ovVGFWVy9RdUY3bG1FZ2JiZURQdFd2ZlJTdTlH?=
 =?utf-8?B?QXlOSTNwVUVTa252Tm9UMFFISVNHeUVidGR5R3plQkNFT0dHdkF4Q01lYURB?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e9+juRsnfeq9DmaB2gIe/E0TmKmzoyHd/6md0rA28Oi+Al0iE+tz7oi2uwGNvQRaMFhVcn5DgtNzX+eW3cRPI6Hm/EqiOKQZELM+ObpFo/iegAZvV4OdCHO3lBrRzPkLpnvdzrTcZgGTS1qZXlJraxKrEFCvmUxRB8C6jUnpZiv9egEGx9DeH+OWvdc7JAndb50C67cV6FTrIArfymFZl11l8SCHdPeR7hQK4vjPieUdN9/qT/x8DmCVSh+G/MtkAMyU17yCtNHh760OQoQGAyiAWudPB5Jv7o8w2Ctp1l2Hk0cBJtDqLwRqk8VZcHESYor9/BwrjslxT4ngdbgeVunZeLTe4HOuuW1v1Itq29obMS+I3q8/0+buOljS5xmjan9WuvpmRShpL1G/0/KlwG4n2d6cMPhmTBWGpqeVBune16eM2XQ3PyP9KQ4HDTMRbyvycE4TQ5xGL25cA9cAON6i9E56toD9RtGp8NIU5oVX7GrTTsS9AjBIaltYx1xNBjQuOrYycZ53xcdSDH1hsVQejIO5hbRft5ryYZp2oDdtOd6GDTazD/mOnQrFTIQyXL89gyfdik1SaWVQYdPYy0HsP1E+ML7qvr18zM8MMlI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4967af0a-05ff-4f68-3728-08dcbc9ae89d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 19:54:29.4201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g602h610B94w10VNy5fUvms6QCkn8HM/looOV3L0V0WboGgNqkVhix2Fz81PUS57u8rIlnJytvbsZcefWvGMZivYXvBrV8eSsbuhoKgaBPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_16,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140136
X-Proofpoint-GUID: rq4CgaeGprvfsWTv4PYXEIqn63MVsfdH
X-Proofpoint-ORIG-GUID: rq4CgaeGprvfsWTv4PYXEIqn63MVsfdH
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

On 8/12/2024 2:57 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> CPR preserves memory in place, so there is no need to track dirty memory.
>> By skipping it, CPR can support devices that do not support tracking.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   system/memory.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/system/memory.c b/system/memory.c
>> index b7548bf112..aef584e638 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -27,6 +27,7 @@
>>   
>>   #include "exec/memory-internal.h"
>>   #include "exec/ram_addr.h"
>> +#include "migration/misc.h"
>>   #include "sysemu/kvm.h"
>>   #include "sysemu/runstate.h"
>>   #include "sysemu/tcg.h"
>> @@ -2947,6 +2948,11 @@ bool memory_global_dirty_log_start(unsigned int flags, Error **errp)
>>   
>>       assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>>   
>> +    /* CPR preserves memory in place, so no need to track dirty memory */
>> +    if (migrate_mode() != MIG_MODE_NORMAL) {
>> +        return true;
>> +    }
> 
> How this interacts with DIRTY_RATE and DIRTY_LIMIT? The former at least
> seems to never overlap with CPR, right? I'm wondering whether this check
> would be more appropriate up in ram.c along with the similar
> migrate_background_snapshot() check.
Agreed.  I previously pushed the CPR check down to memory_global_dirty_log_start
to catch all callers, but the only callers that matter are ram_init_bitmaps and
ram_save_cleanup, so I will hoist the check to those callers.

> (I wish we had made the global_dirty_log_change() function a bit more
> flexible. It would have been a nice place to put this and the snapshot
> check. Not worth the risk of changing it now...)
> 
> Also, not tracking dirty memory implies also not doing the bitmap sync?
> We skip it for bg_snapshot, but not for CPR.

Good catch, I must skip it for CPR also:

--------------------------
@@ -3250,7 +3261,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
      rs->last_stage = !migration_in_colo_state();

      WITH_RCU_READ_LOCK_GUARD() {
-        if (!migration_in_postcopy()) {
+        /* We don't use dirty log with CPR. */
+        if (!migration_in_postcopy() && migrate_mode() == MIG_MODE_NORMAL) {
              migration_bitmap_sync_precopy(rs, true);
          }
---------------------------

- Steve

>> +
>>       if (vmstate_change) {
>>           /* If there is postponed stop(), operate on it first */
>>           postponed_stop_flags &= ~flags;
>> @@ -3021,6 +3027,11 @@ static void memory_vm_change_state_handler(void *opaque, bool running,
>>   
>>   void memory_global_dirty_log_stop(unsigned int flags)
>>   {
>> +    /* CPR preserves memory in place, so no need to track dirty memory */
>> +    if (migrate_mode() != MIG_MODE_NORMAL) {
>> +        return;
>> +    }
>> +
>>       if (!runstate_is_running()) {
>>           /* Postpone the dirty log stop, e.g., to when VM starts again */
>>           if (vmstate_change) {


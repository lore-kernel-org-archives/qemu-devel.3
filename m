Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BE4CEFC42
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 19:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFyP-0006GO-3z; Tue, 08 Oct 2024 15:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syFyM-0006G4-DQ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:34:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syFyK-0006qw-EW
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:34:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JXfdn021608;
 Tue, 8 Oct 2024 19:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=3Q90oSrwMMFaDYR745LdAf/eswCnzrOXVsf+k8mqjxw=; b=
 FXqrCXWcXesTgAdtNbQ/Bt4A9Bo+Q6S6/XVG5KSBWSvrw/xEbPK+Vlzu5cWSDESf
 DGpkjhx+wMdBDUYqQUNcsYkRsfJPT1gPKL9ccFTptWmU6ZrkMWgeiPpeOtdQk5cC
 AM1o8yIq0xqTW2/ObHD7tPRubgTxghM6zndaAQfytmkAY/SKd9rAoVYzPVeVzcta
 AUiObAK47HaPNT5lgyWgZLA/sGN3Giq7fOYPOJbh848KXi+7gwLa1+AjZFNdeezc
 dB7JxtI2wmW7BP5aWRScGm/ewKINOTAxi5BWA990RSZh1Lz8tA29wctyid/fPITP
 xKHmVMG81+PyTj31z//0/g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pejau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 19:34:06 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498Ipkxs031098; Tue, 8 Oct 2024 19:34:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7nnkh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 19:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anJoK6yxQgDP16huwW8mPxZdPa8EEVnzOC9XSb7UN2f3neU5NG71bEh25wTTNaqqsK2upqUCtxiVTbsLCUzNclG1vDsaALXhNoBvD8aD4DfnGdIO548uGa4+h/cKAkkc3OhIod8RMjYhjjWRP9DftrgZY6S4YoO7TmmN+KubK6a487lDb6Q9waJ4gjicR1ck/k3IXIcHZ7CJJbfW/XUXYnrdeZGlyEDAF2Ew7c5cVgl/3iasGXCsH0Urbc5grJRKH8aQZUBbpgINSvj3Rl9CvygX+2atr6erQvSOUtcFMnFYR9LuGxh9Dagaqb53s0Xys18OsWjlH+ubJDh5Ri2wHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Q90oSrwMMFaDYR745LdAf/eswCnzrOXVsf+k8mqjxw=;
 b=MOw2Y5DHX+wxDV+tMuH6XGhfbAmpaXEmjaXLc+5zaexZczy9lEODFC0Je8nHL2xKt4x2fXNfoVAkIk6BgRG4oAz7taxrkP7QSCrRsv3nMCZiXzvtC5zVuhZhzBLeDBYTMU4L75NEZEUD7wgQIrppZEi7MwxDnepiKwXWn9r/dCdfg+Iuzc9Sjavqz9GPvJMGDmmohtXntnP6a0STOzvDkBdexg3bkt4TGSwK74sCJnbmQPiwCW6w8DuBcDnfuNO+RWCgijyQxu9SdwZLKBe5Kphqj2RUwQR2cukqDR6Bf+kYihv4JoBKJWTYT55SQ460JufPm8PRNRtRRH0egqZlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q90oSrwMMFaDYR745LdAf/eswCnzrOXVsf+k8mqjxw=;
 b=MC+Aq/MG9EuPq9Tj47bICXKVczX277pYlf/XKcRhlBMznpEG6a+YhReICVJRonaXFfFgZm9KJ7AYjaXP0Jj5lG3OwhpnhojpUPMIsrY4vysFv7Mub6mkctudBbrVGy9Y8YYIx5LqwUnL2B8Xzwl+IkcLgYutFs6zG4uE9HV5P/4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7828.namprd10.prod.outlook.com (2603:10b6:a03:56c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 19:34:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 19:34:02 +0000
Message-ID: <b9116ec4-6c17-4158-b37c-9ed64d1118bd@oracle.com>
Date: Tue, 8 Oct 2024 15:33:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n> <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n> <877caitno5.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <877caitno5.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a20496-5800-468d-8b40-08dce7d02a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVM2dnFSNHRrbHJFNm5wRE5zODJvR0R3elpjcEJpQ0tVMkVvSFZjQWgyQlpG?=
 =?utf-8?B?OWNJbEk2L1d4VWJWbSs2Tk5YK3Jsc05vVDdXb29QdHY5Zk5OWjVEbDlGdmhF?=
 =?utf-8?B?MWM3QkpJbSswd3Zsd0J5bm4xSUJIV1N4N0pBU3dLUGZSSGhkeUJWdFV6UEsx?=
 =?utf-8?B?bEw1Szl2b1NrK3BzbTdjZ3F3OGJNeEIzT0ZTalR6TGJRTWlnNFY1aHFiWk5D?=
 =?utf-8?B?bDRhbjhQaWtGR09FVEt6eUdPb2xDYllyTExTWHhRKzI0c0VwaVdEQjVnWkh2?=
 =?utf-8?B?bE9vdGdDSElpTVNQV040bnR1aUhXdlZBbFpSdDhpT2o3cFJmT1FCd0RxdzNa?=
 =?utf-8?B?SDYzcDkvQ21MNzdUS2t2Y1BUN3B0T2hMM3NCeFlTTzh6SUhzQThoUjVEWHo4?=
 =?utf-8?B?MHVMdTRlQTROd3RYUFE5bjZYVmxUWmsvN1h4dzFkWFVYdU9qanhZNkpRWk9q?=
 =?utf-8?B?alM0Ykp4V0RQTlI0VjBGWHQ2Y1lOc29YQzdlb3VhZ21XSGxaTmdZL3dCUTFK?=
 =?utf-8?B?Nm9wanZ0RlJjVnB6SXNOWlNjN1ZVOUJtOTl6eDY2ZHFqZ0ZWVWxDY1N3UzZa?=
 =?utf-8?B?cEMyd1FsMDNhNEtFcXZJaGE5dWZoM2JiZjVZSUFlL0I2ckhCWSt0Yi9KSGlV?=
 =?utf-8?B?RXR0OXZuWWdCbXJWNGNvQTFmNmlQdzlyaURGWFdnQWtuR2NmYnpQSDdocGgz?=
 =?utf-8?B?R3MvdytWdkpjVC9nN0U1d2twUk5ncGJYb2RERUJOajJpSHNGbTlDYm1VNlI1?=
 =?utf-8?B?KzZMSjVQWEVGeEJHTDNkUWNlN3h5ZmF0TkZUUm9tMGxZTU1Sa3NHcy9tRFZE?=
 =?utf-8?B?OTFVZVJJYjg2bGJ5RUhpVy9NUktER2w4SDY2QlZ2NTcxdGtCRHZRUG91aTVO?=
 =?utf-8?B?UVpYOW84QURQL1VTb3dvcHh3SkE4YWk2UWhGRXFQRXFwZU9XajN1MnNsdmZl?=
 =?utf-8?B?Zk52Ty85emZJUGY2eGpVNnBMeTJUei9xU3NzbCtNODI5M1FGUWJvM3dXc1RY?=
 =?utf-8?B?bEZQZ1VVSWRXbEVqNDRZVEV5bjAwM0RYeGI2TVlDK3R2N2k4RDVuL1AwWVdi?=
 =?utf-8?B?REZZa1RpblpsZitjRTBKakFScjNhekgvWHo1N3dIRW1aaWgzbk9UNWIweHgw?=
 =?utf-8?B?VG5KbHJJckwyNUM5ei9vUTNKajFMWmhLWWpzSG9Zd1krRU1tZ0QvamZHU3Fh?=
 =?utf-8?B?VFlsTUw5ZDRuL3pNVm44KzZuWHJTWUVhTWk0a2JmTHRxM2dycjA1NVU0czV5?=
 =?utf-8?B?TTNWc0IrY1pXbXJVZTdJdk5nSW5tWXIwNjNJNGxVNkZJcDZPTVBkc3NBSFJX?=
 =?utf-8?B?d205cDl6NFZkMGRCdXIrVnpjK2NKNTFDcEI5SklZQWlqdzlyVXJ6VEI4c0xD?=
 =?utf-8?B?dmJnT0lzN29hQ3ZUVExBN2tOd05OMTFzNGhxZDQrRDltV2Ixa05pM0J6b3Bu?=
 =?utf-8?B?WFM4YTVES0Y0UzMvVHZnTWNwUm1ialdHTnBIMXdsaFJIVG9uSWNiY3k3amEw?=
 =?utf-8?B?ZEJ4eUxLLzZMRDdTWVo5MGRWeXFvWTg0d2NhS2JKenZ5S3Z5QVA0TGgweUJS?=
 =?utf-8?B?VzA1YUp0RjVLVXg0bHkzNFNjNFVXRXhmdXJFYXVuWWV2M1ZTdkRRTDRLUnIr?=
 =?utf-8?B?bU42WmIzQVY0dW1SbWRvNUpPcTZlaTJqLzN6QUNoNlZudHlXYjNsKzZFTEYv?=
 =?utf-8?B?QngrWmIvRTRIT1d6UmNxZ2FYeGRBaEx6bGtXeHJlQlJsUkJWb1AvWUNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDQxUUp1QUl4R3UrY0R6VnVEZHExMEFnSWpZeEQrOXF3Q3l6UFZmY1dldlkx?=
 =?utf-8?B?MGJuMDNEWXNBOFFSeFZDR2F2TkpLQlhSTjNBbHVuczc4NXp1aklNRmVPbjli?=
 =?utf-8?B?dVJDeG5CRHE1dmhEOFYweG5tL3lycndqdm1uQnlhbWRuWjdGazlDQmhUanVV?=
 =?utf-8?B?QVVFc04yWCtKcVdjTlcyb2ZUWWxOTHFOUmZtNGxMSGdsS2FHWDhuQ3lkakNh?=
 =?utf-8?B?R1hpVzVWU3BIbWc2VXZ2VWI2aEFtK21scmhkaWU2UUdtQjVnVHNZSmZqSld2?=
 =?utf-8?B?Y2V4ODJ6WktkRVRxZFQwR2dxdkVqWFJpREZTMVZEUGlabG1qeFJrV3hvZDRZ?=
 =?utf-8?B?SlhVcmh4alJKbG4zaXR6SlBLeEx4bFZsaWVQOXhaV2Z6WnRjQkxSQ2lubWJR?=
 =?utf-8?B?VkNub3pYcW55Q2NXa2tlbWZoUFpqYjRsWlpGajkzYk45V0IzK3JzUVVzVklU?=
 =?utf-8?B?c3M1V2liclpqZjY5cE0ra0o1T0JmYnVzcTlUUy9kU0VITnFTaTlHY0R4bkRh?=
 =?utf-8?B?K0RjRVo5RlU5Ni85L3Y4ckZYZkhpcENSaElnRjZzSlZIbWtIR0U4QWx1cUND?=
 =?utf-8?B?Y1pkOVZDSzVjTFd3RFM5UlZ2dXNIRUJlWGJ3TXJqa29BS0pnQldDKzB4WDJi?=
 =?utf-8?B?Z0x1ZXFyZC9tdDRaOXJIekxyM21ydHdwaCs1RTRDUkh4TG40aTNmTFo4RkND?=
 =?utf-8?B?dDRMR0wxbkJ2R1IzMVVCeTdhV0VQVzJRZFZrMnIrSExBRWEvMzhPa3JvdlZC?=
 =?utf-8?B?VGtqaDVtV2o0MVNFSUN5L0dqS28rTDcwUWE1S3VYWmJwL0U5eWJrWmpEVTh5?=
 =?utf-8?B?RVhaaVhnbEVZUTE0bnUvQy9yUkR4N1owSlBLTXRpK2pmVFo3eTAzK3l1YnFo?=
 =?utf-8?B?S3NEemxQbXN5LzZ5TjArMW1MSW5WVlJxbXBvT24xNTVRRjVJUmV6ZWN1WHFi?=
 =?utf-8?B?MHI2b2M2MEhQOEdwSjRpeHVnbkowY25GWXUxRE5DM0xUcHliQ1h1ZDZkZUNx?=
 =?utf-8?B?UXByNnNxb2JoSEdNVnI2TGVxY3lLQytZUTdBNEFMeHNFT2NhM2ZndWRTWlBN?=
 =?utf-8?B?WVdSaVlnYW4zZ3YxZWFrdGpIbm1lbHd1RTY1ZGNGY3NoYzlndlQrcE1MNGlk?=
 =?utf-8?B?NUREQjgveG02MHBJNG84OTFqbXlUdTFJN1pMZ2JIeTFhWEsxMGxnNjNYejYv?=
 =?utf-8?B?cjZPT1ZuL3JUT0llYVY4V1BkYVM5YzZYR0Rlbm9YRFJhTE5jMkx6YU9rRTQ2?=
 =?utf-8?B?QmFmb1VPV0QyV3FJcStKOVJrclFneTJ0alNZeUUrZUtIZWZMK0pkQnc5cnRG?=
 =?utf-8?B?bDlKVlFVeHJocDRMUDJtelk2Zkh2cjlMU1NMYWR2YlVpZElkRWpXeXN2bjN3?=
 =?utf-8?B?Wll2RmNJTXp1dmtBWkZMZmowM0N2cnFKb1RHMEticVVSSmg5bTd0WjFQWmNh?=
 =?utf-8?B?R09RamNEUFVuR0xkZlNuKzRLZ3FoWVZ3SXVOcHhHRHdPWkV4MmcvL0dlVUdy?=
 =?utf-8?B?YU5VZUtDQ2pJRzFCLzc5YUV1ditFWFFZa1poaXdybHRVYmZZYk9OaCtpaU1u?=
 =?utf-8?B?RUJMcGI3T2dJbllJaWhtNDJDQ3hVY2daNVhKSmlxemZya3FJV3hrWEZXMnN5?=
 =?utf-8?B?UHdZUHp4djNrTHlvZVMzL1dQQzd1M25ack91RnA5ZEd0bmtmQmtsVytnQ1c2?=
 =?utf-8?B?UUUvR2FWcnpTZGZieElRUkJXU1VtSHRyMTFZdVhNRjIwRFdwUHloZFBpZm1v?=
 =?utf-8?B?Vkh4ZVVjSWphOEpuanJic1d0NGlLY1Ewbnc2bXNoTktUenVZV0NMMUg5bGRD?=
 =?utf-8?B?M2xxcnU5ckt5OXdMTFQwWDlxYll5ZDZMeEViYW5MSUh1VjNodHZvS0NlY0U0?=
 =?utf-8?B?SUhhNnVJczJoclFrei9iTmEvdWxlek1mR3RUSWVSTmtsYTkvZVgxbnFGOVl1?=
 =?utf-8?B?ZGJpbWgramF4TFFMSjNmcFlhQ3M3d0RzOG9FREtINjFnMUtwOExBQllxNG9t?=
 =?utf-8?B?ZDlSd3NUZmFleGt4Vi9WR3pSZlFGZEJTN1dVSTdxNUo5WHpMcWZJMEhxNGs1?=
 =?utf-8?B?NHVBVU9tMDdRbHdjUTk3NFI0NENTa2pwRFovOC9SUzhocFNMck4vV3dMaDFn?=
 =?utf-8?B?RHBNTlNjd3JEbDhZMStLNThPZ1hrNWs5dEViWllkZU4vczFaOStQWENkTUFt?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +I+iMYJ34nZD48gcO3V5PGogZqBUJbZG7+DIPldUkaiYYwmYDGnfp8kKhDoHY9YZlPCsmh1ZQYITpY8qVJ9hXERN/xnNB6KYGjVgX1i7MiqnxYymbDOHco600dcqOjeY0ysv1XWVVaeTGVG0BO3Ef+hG9pwhFa8jXW/yZZ5mPJeN4nwul51opFPD7tfM41DQcO1hYmCKzO17rojlUnauA80eyimM4+Z/Wyft88WdenIEbOd7Xi4r7h2ZqLJlT7nRtWs3gXznIXpoUFa5cqyLTSJdzTNk5KFgMoyLadrckTQ+0XEPIVmbmjktr5BAn33B0aqv4xygEje9OomLDXLIYpb4sZJapwq3p9+E6L5SVRC6Gfie/GyjgawJAtAJp4eSAXw8U9NMQvtBmQMbHeItfrTPlRI6HiFWCWZUmVZSA7x6Tvw/cu0REXP01SZBm3MddHL/Os/ogCDwzUWgej6SvH6lqwYVHkGsbIO/ov0zWrp06XBMBAuVGwjEflODw0ti0oDQnsHzHqEM5fCh2xbVDKnTRt2NrcgwmVTo7JOOcB+s1e8fn5F/hiO/WSMrRCxt/Ec113GXTx4n8s0F2CEFvdWMN6lAXoKTyjLVLlc8cig=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a20496-5800-468d-8b40-08dce7d02a09
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:34:02.6035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekkb2UWfxi0mYhyMqr7vhG1wOtKH6E5kXp2VaBcUzerDN4l04vrLE5RA0WmyGwOfIvs299gwu7uAT9lRxOkAyUDeeYgeThbZbxRkcyTJOUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7828
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_17,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080126
X-Proofpoint-ORIG-GUID: _W_9-sxLa4ffhZD8QQ-AQkgNJv3zSCPF
X-Proofpoint-GUID: _W_9-sxLa4ffhZD8QQ-AQkgNJv3zSCPF
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/8/2024 3:11 PM, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Tue, Oct 08, 2024 at 03:28:30PM -0300, Fabiano Rosas wrote:
>>>>>> +    /* Close cpr socket to tell source that we are listening */
>>>>>> +    cpr_state_close();
>>>>>
>>>>> Would it be possible to use some explicit reply message to mark this?
>>>>
>>>> In theory yes, but I fear that using a return channel with message parsing and
>>>> dispatch adds more code than it is worth.
>>>
>>> I think this approach is fine for now, but I wonder whether we could
>>> reuse the current return path (RP) by starting it earlier and take
>>> benefit from it already having the message passing infrastructure in
>>> place. I'm actually looking ahead to the migration handshake thread[1],
>>> which could be thought to have some similarity with the early cpr
>>> channel. So having a generic channel in place early on to handle
>>> handshake, CPR, RP, etc. could be a good idea.
>>
>> The current design relies on CPR stage happens before device realize()s, so
>> I assume migration channel (including RP) isn't easily applicable at as
>> early as this stage.
> 
> Well, what is the dependency for the RP? If we can send CPR state, we
> can send QEMU_VM_COMMAND, no?

The CPR state channel is (and must be) used before migration_object_init,
and before the normal migration channel is opened.  Thus we cannot use the
normal return path.

- Steve

>> However I think dest qemu can directly write back to the cpr_uri channel
>> instead if we want and then follow a protocol simple enough (even though
>> it'll be separate from the migration stream protocol).
>>
>> What worries me more (besides using HUP as of now..) is cpr_state_save() is
>> currently synchronous and can block the main iothread.  It means if cpr
>> destination is not properly setup, it can hang the main thread (including
>> e.g. QMP monitor) at qio_channel_socket_connect_sync().  Ideally we
>> shouldn't block the main thread.
>>
>> If async-mode can be done, it might be even easier, e.g. if we do
>> cpr_state_save() in a thread, after qemu_put*() we can directly qemu_get*()
>> in the same context with the pairing return qemufile.
>>
>> But maybe we can do it in two steps, merging HUP first.  Then when a better
>> protocol (plus async mode) ready, one can boost QEMU_CPR_FILE_VERSION.
>> I'll see how Steve wants to address it.
> 
> I agree HUP is fine at the moment.
> 
>>
>>>
>>> Anyway, I'm probing on this a bit so I can start drafting something. I
>>> got surprised that we don't even have the capability bits in the stream
>>> in a useful way (currently, configuration_validate_capabilities() does
>>> kind of nothing).
>>>
>>> 1- https://wiki.qemu.org/ToDo/LiveMigration#Migration_handshake
>>
>> Happy to know this. I was thinking whether I should work on this even
>> earlier, so if you're looking at that it'll be great.
> 
> As of half an hour ago =) We could put a feature branch up and work
> together, if you have more concrete thoughts on how this would look like
> let me know.
> 
>>
>> The major pain to me is the channel establishment part where we now have
>> all kinds of channels, so we should really fix that sooner (e.g., we hope
>> to enable multifd + postcopy very soon, that requires multifd and preempt
>> channels appear in the same time).  It was reasonable the vfio/multifd
>> series tried to fix it.
> 



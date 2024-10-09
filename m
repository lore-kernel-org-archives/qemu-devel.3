Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F61DCEE345
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 20:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syd9H-0003Cy-G1; Wed, 09 Oct 2024 16:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syd9F-0003CR-IL
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 16:19:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syd9C-00078D-Oz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 16:19:05 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IIToO016153;
 Wed, 9 Oct 2024 20:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=sMd+bLQghwOGZsNzOBSHa71ieV/YeLq4Mfv6y3VFhTw=; b=
 AXeDZc4jpJVIR50AjQkqh/S79wz165BAiMUJzFOCjmH/JUggBuUO8lRwoCxuxpwr
 b61vZzBow3fMoqSL/NUqKg3op+2Qkgcyl6j/lQvY8p990c5JqH/menwC9gXee3vF
 amWs1df9586Pf9aUciQb5LmewdwPfodV4TI6Y149e08dXy6rCls2iD747kvq04+Q
 /rP16/zXmunhty/6IcpxrizY5XnjnD2SybPVWhsPW63KnWLLr9akw2qP/nAVrFOq
 GOKO7rxuPguJ3d/kWst/XasFeBLQmFL6dQhzEfUj4L+r5ukHxT0x/nwXFYlc0eMh
 sv0ApPCG/gTPpE15oNmdLQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306ehb8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Oct 2024 20:18:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 499Inwk9011522; Wed, 9 Oct 2024 20:18:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwff0en-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Oct 2024 20:18:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3sbyHLrNVMfVcUdQlS8MkqtQWUg2lAX4BXhlm+hMSonU6JeIgUrpXFYtIpbgjdfcgcp0prNTTxcS8K7jgVldiahjYH0xxxwun0blBro9X+4tm2+1+N0/G1GDVhNEIMhupdfiviPWzwu73DWh+NFSey23Ka7eI/Qc5dUbl+Xp3bM3vdHDNYQk4hvS7fJ0ytbbvzaW1yqZ8wLJ2P2CdSLWEUazafCCriz5/ax1q0xQjfZRgOMuEn93iYeNFaF7/Hp4yOZ82mDvKH3HgRRhn6LcBjhrSGfj+58dmw6L7jE/vERWax+jcli3xV+ifU89faiDp2Er5V/sdaMeQKp+Xy7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMd+bLQghwOGZsNzOBSHa71ieV/YeLq4Mfv6y3VFhTw=;
 b=CGyv+k2yT2IQMSbDIDqt2Ksr2hk+cyLCmPuy8hAL7hLrXRqiXU45Z6GNVKouMqit3YfbWoQZVbaHoNtwtF/4jtfukmKLiLThqMONKI8bgbRLNjImuWn60ZcAScpml0DkzGntsPEY1NYDFhFZp6tixKtnRpdUASjJy5smFmn/0vpJiiSTqO1yc5Pge3DIss28cev+c7H+2cqMtbJGUl2colq/H0Ge52c7Dd8fooOf9qDDa44DlDoU1rbx8bO12+yWvJIaiT4E8AL/Mcv8PMaTzgj6CmlcviFQLeixa412oj2pIwCPFn2QMDztWzSwe86tqH7GL48aumsa3s6ufdANcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMd+bLQghwOGZsNzOBSHa71ieV/YeLq4Mfv6y3VFhTw=;
 b=swvR3llGDBeIQKgobKixCSVtcaO+QlWHP/GZSJjfM0uUNrRoJbxEMpn4zmXESeB6PNWGdnqvWn6iNqsohrBDHSUliy1JOj1NNr0SvKKR4j64jjWPQbh18Hcck9VPgrgVNz+MjDrGLPwSYSmEF/c0W+YbXObPFFaxxXMCEPiM5D4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH4PR10MB8121.namprd10.prod.outlook.com (2603:10b6:610:247::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 20:18:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 20:18:39 +0000
Message-ID: <97268719-56f3-4d7f-aa21-c04cd0262601@oracle.com>
Date: Wed, 9 Oct 2024 16:18:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n> <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n> <877caitno5.fsf@suse.de>
 <ZwWMj4FYYpOSnPbe@x1n> <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
 <ZwbUTXCxxl4heZYV@x1n> <Zwbgur3d0cImLV99@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zwbgur3d0cImLV99@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH4PR10MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c443e04-7b1d-4e83-a97b-08dce89f8fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QytyaVRzTldwOXpRb0ZRQWgzTEM0amlEY2tUQUlQUnlOVzNpVkVRa0w3cmQ5?=
 =?utf-8?B?L0dvTFFmSkFaeHdVODNKTVV2cmZFeGNseGtFeXE0Ti9JUXFkaGVSYk5aaytC?=
 =?utf-8?B?bDJGOXR3VEMzZG9nL0wyeVBOaG1kalNjdVB5UllUREdoSm4vMzRGWmhjanV2?=
 =?utf-8?B?ZUlwMEc0U3NZMVp0cm1YWWFnU1hRVjZIcXhSbEoyZ0dsTDNzSUcwaG9lcmxG?=
 =?utf-8?B?RGk0TjBLSEc1TGJlSVRkL2xDWlVuZFRqTDRZdk1wenRucUJmU2ZVa1NGamMv?=
 =?utf-8?B?SHppa1V1VFU0SGZocWR4eFBXT3FJdWpISTNpSWRDRHZmWmREWnR5V1hMZW1P?=
 =?utf-8?B?VStrVXVkVTF0TVkrc0tnT01CTVpNUzFad3U4TWl5S2x6VEw5ZmpIaDZER2dr?=
 =?utf-8?B?SFBwcGxUUk80M0tFTWNxV2NobzN4cjdxOWxJUjl6UTU2RDdoejh1bzRWWnhK?=
 =?utf-8?B?RGtsVUVYM0pOYUZQNkd5V2pJM09Kalo4dnYvOE12dGoweFJ5ZmtpaXh5ZUNY?=
 =?utf-8?B?ZllaT2xlMlgyVHNVYXBiNWk2SEtWWFR1ck9UeDhPV1ZTQWhnYVYzazRFRTJW?=
 =?utf-8?B?MUwvZnVuMFV4VkFibWlrNVN3ZW9kOVZVYVJOSjRiblU5TktPelVkRFBGU3Fr?=
 =?utf-8?B?U2xhRGMrZ1BEOENKL0pmMWdvYWZjTTZlckNGUnhQUFQ1SGcyN2xlUVVVMTRu?=
 =?utf-8?B?WlBObE4yTkxQeU9lRWlWV1kvbmpjamh2ZHJWQVBUQUYzNEFJNEFrVGFTNE11?=
 =?utf-8?B?aUc1YnhWL2IvNERDdExRMkROdWljdnJNUlgvaFFxK1M0TUsvVXdxd3lzTk1N?=
 =?utf-8?B?c1FLZXFNcjBlTVdSZER5Vk9IRXlFMDM0VmVwcVJDbmNvcnc2aVRzdkdSN2xn?=
 =?utf-8?B?UnBuT2xCUzFyTHI4TjhyUFhCNlZNenMyU2hpemtrc295WU03N09XY3RIemly?=
 =?utf-8?B?V0I3UWtwQXFqdlg5KzJod1pYZ2sxY3V3dG8wNWgyTDhuVWhsZXRqWlFlMm9B?=
 =?utf-8?B?SnRoeUFueVRyMzBqbDRXUXEwNjJPN016N1dRMmx1NThxdWYyY3JWUjgzVlZV?=
 =?utf-8?B?TENrZ1B5ZkZPQkF1dElqNUZXQ1RzMVlLS2JZd3RLMDhFQzQ0YUJvZS9EcDRN?=
 =?utf-8?B?S0gyZ1JwY09WNXRCNVJUdkZ3bk85ZVBwMWdNTzI2clNSeC9kOGM3dko4c3Zt?=
 =?utf-8?B?SFVQMjVOQmxzWndOZEpPbGNMUXY0UzhTeEtRVFpmWm9zWUNseHVZOXRSY0RF?=
 =?utf-8?B?OWo1TldjVXJ1RVk0WjZtbEw3RzZzeU1td0tCZmxWMDBjL3ZWMW9yOUZIZkRH?=
 =?utf-8?B?T3RwZ0FPK2RoUDh2dnpXWnZMWU9kZEY4bVZsSzE1MFhCd24rYTg4QVhVNDdK?=
 =?utf-8?B?aEJJZWNsNitlVHdVank4T1VXTDRXUW1yanZtVFV2RFJWZi8yZFVZUERiWXhi?=
 =?utf-8?B?SVBpdGFHcDc1Wm9BeEtVelh0aDJsbUFDa3JjeHNmWlZ6Yjdhb2VkaU1EUGdW?=
 =?utf-8?B?SDBPNG5BNUlzL1BBZVJucGF1ZmdRRkE2QW51UEo5Mys1VHZacU5hZ0dpOTZt?=
 =?utf-8?B?SE9yVTJVT0dod00rY21yOHMwYWlCbmI0VFZybTRNTWZRODhhU0F1QmFNNTNu?=
 =?utf-8?B?M0hSc0JtNVppTi94TVdoVjljSy91RzJRZDgxVGV5Uzh3TlB2bU11cWZEQnVV?=
 =?utf-8?B?SFRNNmV1UGtzTkJEZkVaYkNCZjFueVc5cUVqQmJxWXNWU2JsZzE5YmhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVZrTjVBNXZ3UFJBL0J5MzZPeC8rK3FVc0NLcXRwMTE5ZlFIS3BVbFpVcVpB?=
 =?utf-8?B?KytYNUY2MTlBM1RwYUpPdlhUWk1TelZnelIySUx0cEJzR2Jra3VRRi9USk1M?=
 =?utf-8?B?dll0Wmx4V1NIa1lBK1p4VkNrL0x0L25TMVU3T1N3Qm82NFE1MEpGMm8vTUc1?=
 =?utf-8?B?a0l5V29ycFA4blRRR1d5aVJNWk1YbUJrNWlXWDd5Qk0zdTMrWStYYnhEU0tN?=
 =?utf-8?B?T2ZGaGF5cFZ1ektjN1hZSDRRcTRsLzFWdlJEY2hxMzV3Z3JmZUJ6TWJ0S3hY?=
 =?utf-8?B?ckJHOExWR25RWW5ON09MaHpyVUpoRTFSckJmaFRjdzM0RURNYzJ5cHZNSkw5?=
 =?utf-8?B?cm1nUWlKTngwUzBveThheHN2YVNacnJ1YXhSSzY4K0xKT2NuaFVNbFNvOFhT?=
 =?utf-8?B?WGt5M3RkbnprWTBoblQzUkRmRFY0eXRqcnRjR3NLNGdJc1dXZGQrS04xclgy?=
 =?utf-8?B?QXNXb2wzSG5IeU0wRXNtQjVDSlBGWW10UVVFSW1BY2plUnp0NVRRWEJ4Zi9W?=
 =?utf-8?B?a01uWmlEU1JHeFVlcFJqcGRhM1R3cUFmb0RjNnNVbnFhSGJ0ZzZIRmw0VEc4?=
 =?utf-8?B?VDBnL2ZHSmZaU3NVaEVaMmM4eW0zNGdsWGVwZXkxdFVxY3JFKzNMVXVuMGFa?=
 =?utf-8?B?bHZMZDA4T1BCeTlrWVNneTJCdTJ1M2VPZzRFWEdLcXZ2VjhtelJYanJpZVFq?=
 =?utf-8?B?REtyR2V1OG8wZ3MxMXVkbjNlL1VqUzE5ejgwODNpM2swUFNNY2pTVXBsclhr?=
 =?utf-8?B?aEtJeHJBZTVjV0xYVUVMZHJGd1ZsTGZzSm5FWWJCaFdKMmR6WDV2MkhDZ0xx?=
 =?utf-8?B?QUhucDVFQ0QzTndhcUlCNG5YYmNMU0VwaUFuWUpHaldxU1hZUFlVOGpYU2RU?=
 =?utf-8?B?OHdFS2hEOWx2MG4rUlhKVTQvakxOMUgxa0JDdVdVSThMRDhLb3p4dmF2bFRI?=
 =?utf-8?B?SHZBQ2QxenY2bzRWcUpwNTNhTVQ2bXl6RlVrZ09Samx5TSs3MTBxK094Rlli?=
 =?utf-8?B?bld6TWc4Y1hwTWFNOXlZS2tLNGVQSzJ6OTVlUTc2S1llcmdlRmpBcjM2R1FD?=
 =?utf-8?B?TFNnNkZBT3J2ZjV5Qy9xb3g0Uk9TZjdQWkVQUlRXb1N1OFdZSlcyZmZ3cElq?=
 =?utf-8?B?b2RDUnJYeVhjT0YwNFdKRGM0NkZVQWswNXRRbU9zblpLTG81VXZ2LzR2aUp6?=
 =?utf-8?B?L1VFT0x2KzYxYVZSUllyQWQ4T3QwSzJIZzhMT2dWV21qQk92WVVlYmFLaFNF?=
 =?utf-8?B?QS9UNFdXb3FMc3dvSWpOdUwzYlB4a3BObFFucXpRQ0dlcDRNbm43NHdwcmlK?=
 =?utf-8?B?WTlDSkNOQXNFVGF6V0RGMmIvM2pHbWFnYUJBeE9ZR1BWR003eVh2UTZ6RDZX?=
 =?utf-8?B?RkRWZUFyZ2k2YVIvcUYzYmZOd2VNczFhaG5ndGVMSGdoUjMzcGYybFNJYkRU?=
 =?utf-8?B?c0E0c0hZRStGbTNJR2tCV2g5bkQvNE8yOGtQeTViRzBzQXR1VnVWSHFPVm4w?=
 =?utf-8?B?RXBla0IyWU1PVjFyTmNKcXNRcVNGRnI2Y01hQUZqbGp0djdYUG9JUnhhcnNi?=
 =?utf-8?B?UnBHZ2VCbGtkbi9aN0N2VFlTMUc2VGswUENWaCtpTTRMaW9rSFhPcEJzeFhG?=
 =?utf-8?B?cmJFaDF6ZkRCNGtPbDNLd0VwUVlYc3VXUm5jcjVlMDZxNlhrQ1U5Y21Cb1FU?=
 =?utf-8?B?RDh2TmxxYVVrWThPalovNzJKV2c3KzRMYnF4THBJa1dlaitkN2ZUT2xLdnBZ?=
 =?utf-8?B?QWY5ZUhsMDJLUXJTZ2pFSTFLcGpNWUpIbHlZbWNjMmp3LzZiY0d5eTdvMldE?=
 =?utf-8?B?YnlEclU2MEJZWUlIS1hMT0N6SE9HZE90Y1BEV1k4Z0hYS2xLTENmRU05aVVr?=
 =?utf-8?B?SzJrZ05jTHNPekFJMlgyUTBnaHZkemZXZEN1V2M5NE9zTGJmdFpzZTg5Q2t6?=
 =?utf-8?B?QlBIM3hyNlBPWEx4ZHBVV2x2UHZnTlZmSDljdkh3dk01allQOUlBQXlnTG9F?=
 =?utf-8?B?dEVXWkRqNHFlSzFGaCtKakxabWFWb3VtS2RqQ3llOUhjWG9VcU9uMU9vNHM0?=
 =?utf-8?B?dGdyQXFaSnFHcElLK25USzRLU0ozRm9NMEc0UUR0aUgwM1RTa2hNSUpOSXg0?=
 =?utf-8?B?SXhFeGphdXhUV0hkc2dJd3pvaGEydnB3ZFBMU01WeDN5NlhoSkpqWmlzczR2?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VrLRy1sDR23k/m2H8PtYlENwmAvxjGVp7VcqfLClxsqd7dJBBLBLPIYgnI3WtbOAtBqNNI31VuYTVID1VCq2q9IHALiVTvmtMsBXEcGpsFuWgz7AAl/ZRjWcOuxcNzRMEU9VM+lrD35MoRTu9IKjiLZI+L7oJe1bSGLtvDCd3OyfAPsYLqTM/AX61y54A6zl6tnZzSGbmVj1+5TAepUbEQdszaWcaS2FLUHLklNT81Qf3b6Aadq/bqQ8Ush+Lu7Cvp1+E6WWX4I2nwG4csyrQnx3NZYfv+PjqY0qJvUIf6XcUEzywwVPfKX3DIZP2qD2VUx5MN5MVNQuHnh0pA+N6Pv2K2+SjLYzP1jEWzKyXTJEWwlDlRmhvVjrszO913TK8wR6K1Jtqm071wCrlFUkQqHNdEXUVSrOxKnZ0fsoRo6xs8DeQjoYkC5metyugrtpS0iqGHrvaVWjQTiNAcPQJvLjXB4Ub+xLitK7IOLqK8LL0gtGNjKFY/bYR/yaeoX6axa185LUKwbF+amyTosAMwURyOdZ7GvpDFwP9FaNJlqjOyBmlgNQyksSoQmVc3XOk22eJHS7f5DikSlVxxuSWr7zBIK4eMWH975L7uHAtmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c443e04-7b1d-4e83-a97b-08dce89f8fe3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 20:18:39.3220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCxJYwNLGpsWzPy0AkYqxcDtnxkf1QzXoVdGdUf9leKilWHlUvQXLnRK02xkCFh9axmway79ZDvouUfOqcaGHi3kMv/aFCcwVrRGJnUNUGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_18,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090127
X-Proofpoint-GUID: 5KHBf9JHICgbpAMN6615HtbxvRZZR0dR
X-Proofpoint-ORIG-GUID: 5KHBf9JHICgbpAMN6615HtbxvRZZR0dR
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

On 10/9/2024 3:59 PM, Peter Xu wrote:
> On Wed, Oct 09, 2024 at 03:06:53PM -0400, Peter Xu wrote:
>> On Wed, Oct 09, 2024 at 02:43:44PM -0400, Steven Sistare wrote:
>>> On 10/8/2024 3:48 PM, Peter Xu wrote:
>>>> On Tue, Oct 08, 2024 at 04:11:38PM -0300, Fabiano Rosas wrote:
>>>>> As of half an hour ago =) We could put a feature branch up and work
>>>>> together, if you have more concrete thoughts on how this would look like
>>>>> let me know.
>>>>
>>>> [I'll hijack this thread with one more email, as this is not cpr-relevant]
>>>>
>>>> I think I listed all the things I can think of in the wiki, so please go
>>>> ahead.
>>>>
>>>> One trivial suggestion is we can start from the very simple, which is the
>>>> handshake itself, with a self-bootstrap protocol, probably feature-bit
>>>> based or whatever you prefer.  Then we set bit 0 saying "this QEMU knows
>>>> how to handshake".
>>>>
>>>> Comparing to the rest requirement, IMHO we can make the channel
>>>> establishment the 1st feature, then it's already good for merging, having
>>>> feature bit 1 saying "this qemu understands named channel establishment".
>>>>
>>>> Then we add new feature bits on top of the handshake feature, by adding
>>>> more feature bits.  Both QEMUs should first handshake on the feature bits
>>>> they support and enable only the subset that all support.
>>>>
>>>> Or instead of bit, feature strings, etc. would all work which you
>>>> prefer. Just to say we don't need to impl all the ideas there, as some of
>>>> them might take more time (e.g. device tree check), and that list is
>>>> probably not complete anyway.
>>>
>>> While writing a qtest for cpr-transfer, I discovered a problem that could be
>>> solved with an early migration handshake, prior to cpr_save_state / cpr_load_state.
>>>
>>> There is currently no way to set migration caps on dest qemu before starting
>>> cpr-transfer, because dest qemu blocks in cpr_state_load before creating any
>>> devices or monitors. It is unblocked after the user sends the migrate command
>>> to source qemu, but then the migration starts and it is too late to set migration
>>> capabilities or parameters on the dest.
>>>
>>> Are you OK with that restriction (for now, until a handshake is implemented)?
>>> If not, I have a problem.
>>>
>>> I can hack the qtest to make it work with the restriction.
>>
>> Hmm, the test case is one thing, but if it's a problem, then.. how in real
>> life one could set migration capabilities on dest qemu for cpr-transfer?
>>
>> Now a similar question, and also what I overlooked previously, is how
>> cpr-transfer should support "-incoming defer".  We need that because that's
>> what Libvirt uses.. with an upcoming migrate_incoming QMP command.
> 
> Just to share some more thoughts below..
> 
> So fundamentally the question is whether there's some way cpr can have a
> predictable window on dest qemu that we know QMP is ready, but before
> incoming migration starts.
> 
> With current design, incoming side will sequentially do: (1) cpr-uri
> load(), (2) initialize rest of QEMU (migration, qmp, devices, etc.), (3)
> listen port ready, then (4) close(), aka, HUP.  Looks like steps 1-4 will
> have no way to control when kicked off, so after cpr-uri save() data dump
> they'll happen in one shot.
> 
> It might make sense because we assumed load() of cpr-uri is during the
> blackout window, and enlarge that is probably not good.
> 
> But.. why do we keep cpr_state_save/load() in the blackout window?  AFAIU
> they're mostly the fds sharing so they can happen with VM still running on
> src, right?
> 
> I still remember the vhost/tap issue you mentioned, but I wonder whether
> that'll ever change the vhost/tap fd at all if we forbid any device change
> like what we do with normal migrations. IOW, I wonder whether we can still
> do the cpr_state_save/load() always during VM running (but it should still
> be during an ACTIVE migration, IOW, device hotplug and stuff should be
> forbidden, just like a live precopy phase).
> 
> Iff that works, then maybe there's a way out: we can make cpr-transfer two
> steps:
> 
>    - DST: start QEMU dest the same, with -cpr-uri XXX, but now let's assume
>      it's with -incoming defer just to give an example, and no migration
>      capabilities applied yet.
> 
>    - SRC: send 'migrate' QMP command, qemu should see that cpr-transfer is
>      enabled, so it triggers sending cpr states to destination only.  It
>      doesn't run the rest migration logic.
> 
>      During this stage src VM will always be running, we need to make sure
>      migration state machine start running (perhaps NONE->SETUP_CPR) so
>      device plug/unplug will be forbidden like what happens with generic
>      precopy, so as to stablize fds.  Just need to make sure
>      migration_is_running() returns true.
> 
>    - DST: receives all cpr states.  When complete, it keeps running, no HUP
>      is needed this time, because it'll wait for another "migrate_incoming".
> 
>      In the case of "-incoming unix:XXX" in qemu cmdline, it'll directly go
>      into the listen code and wait, but still we don't need the HUP because
>      we're not in blackout window, and src won't connect automatically but
>      requires a command later from mgmt (see below).
> 
>    - DST: the mgmt can send whatever QMP command to dest now, including
>      setup incoming port, setup migration capabilities/parameters if needed.
>      Src is still running, so it can be slow.
> 
>    - SRC: do the real migration with another "migrate resume=true" QMP
>      command (I simply reused postcopy's resume flag here).  This time src
>      qemu should notice this is a continuation of cpr-transfer migration,
>      then it moves that on (SETUP_CPR->ACTIVE), migrate RAM/device/whatever
>      is left.  Same to generic migration, until COMPLETED.
> 
> Not sure whether it'll work.  We'll need to still properly handle things
> like migrate_cancel, etc, when triggered during SETUP_CPR state, but
> hopefully not complicated to do..

Yes, I am also brainstorming along these lines, looking for more gotcha's,
but its a big design change. I don't love it so far.

These issues all creep in because of transfer mode.  Exec mode did not have this
problem, as cpr-state is written to an in-memory file.

- Steve



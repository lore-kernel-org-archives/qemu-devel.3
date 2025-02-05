Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94427C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 22:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfnT7-0001wu-Qm; Wed, 05 Feb 2025 17:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnT2-0001vN-54
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:01:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnSy-0006oL-Mj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:01:55 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfnJD028357;
 Wed, 5 Feb 2025 22:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=B6e4X6jndH8OYXnyF9xNjPj0lLMkEkoNg8av4i3eAuE=; b=
 ob7Nma3b5Xt1ISvh1TzBaQG9y4VF16npxPvtS6Sg3Kd8+lnQU7ImRB3uzxP1+xUO
 6mK392D492o9MsKA+BnvqoHcpPbSeANqJqkDmlAU+sLtyHAgrP+8Ci7sd/jqkIuo
 fsH0xbKn5KmZSZhJ5gR2fzokxeO0TeAIJN506Zn3/0Alp73ERahlgiSopY2tWo1N
 75twMv6wLtsyGZIp4LQ19NOlQ4k7+aKaw7gkopC4RbuUn1EaCDE3t/o4xlDZzbEp
 S/R4V+wTYWwpVR8KwzGQ1cthHrruTlgy4ZIhgTMh4TLGcHdanSOTvUJpqXNikvLS
 jJfc3kuPW7cuGy6xzsXZRw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfch0b7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 22:01:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515Lipfw020619; Wed, 5 Feb 2025 22:01:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8fr10ex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 22:01:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwcgyOuklIlg65iO2AdTra7jzGZKemH7CL7R/hwYLi9n4nAu5SYavCAGo81LHfmUCh7MXhFP8PFRkA31ElDxlbSb2T8j1tjGmeZNE90JeWTn1M+TTjMnfeWgT7/AMlhyBWC/HqrUOrY/Kj7O7QmT1e273m1GR10zTeT0RBwGsiU9zvMwIc1Sj+HK/CO3/Hk7dqqCn1UboprjzmrKEt7LGEIg7Mv3s0L8eQKwTgByWwmLTVp7IsNrJnISllW6p4/IGw13UJw9FXXmGqwuZ7deIi/08owjyPrm7Rat11k5CgY5kbPyi3TNWE00sJgTxsqpP/CvSlrJfEAndT9/chvbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6e4X6jndH8OYXnyF9xNjPj0lLMkEkoNg8av4i3eAuE=;
 b=kdKiEMlK1/T2Y7H4ozTHgz4SZheXEyjL0OR+T84mxQ8miB8Zezkv0QfU3LVVmV5w+ssKoz35aR4gna81xa5hijOJ7xZkVKkcvLR0qAA5by6uzlV74XCh4Ki5dzOYFthtFlE/nqvdSppC9b0DEN3XZFtzsUUDg8QAihkG16+UNqmzRfrnlwix9wo4fCxQRTwZtvO3mSdgmV4IIabsrwcRl7zQkz9ghJG2aPXLZLwLUrMwSvEhU/vwRqTkVm/AmMtj0eR5qBZEYaQS5nh7fF7Ph/1TozwhBBUCQjfPFO8N4gRZqjqFqIJL90nlntOR2qmr6sqa6515i1TSFBNJiaVXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6e4X6jndH8OYXnyF9xNjPj0lLMkEkoNg8av4i3eAuE=;
 b=MCUrJ+ax4eK6IyyWpbMiiIxQeDthCVJm6wvYuxb+DSvn6l8POWMPSSjw2lZcSif9+Lju2/2apExLt1Vr1JHyof68oYSuLZA5RAbPZYZTNs8v3OGJRgfrbFArYES0C+AE/+gHaZuaKlF7tg0IKu2Y2LVEotUrxYUNdMlxvxI1j1A=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 22:01:45 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 22:01:44 +0000
Message-ID: <a649d9a2-f9d2-4366-9abf-6fa7c4321c7e@oracle.com>
Date: Wed, 5 Feb 2025 17:01:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 19/26] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-20-git-send-email-steven.sistare@oracle.com>
 <94093d0a-f9bb-4327-b793-2f3145c7cba2@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <94093d0a-f9bb-4327-b793-2f3145c7cba2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:408:ec::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8ec2f2-0343-4587-9bd4-08dd4630adef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk00bTN2aWt2WW8xRDBhMVNQcFc3L29KSXFrUkRSYVIvejB4d1lGZnV6a0ZY?=
 =?utf-8?B?T0oxeTY1anBrQVNJQzhTZG9aTHVWOUQ3aG5aQU9DOUhYRzNsWEkwazY3NitX?=
 =?utf-8?B?cFlhYWIvcitCbElVOExsMkkxUk1DK3E1Nk9Bc2RwSHFHejNicWlWbDNnOUpl?=
 =?utf-8?B?aTlwQzBjanFRcEp3U2preGtZSEhaYy9JOTd5cUM0NU9ZN3NPZTNoNk15a3dr?=
 =?utf-8?B?S3JLOWprSkZGR2dYM09mWU13UGk2cEw5cTRqTGp6RVByaFNJWmxBcE9rbUV5?=
 =?utf-8?B?elpzVkJvNURTaTh4a2x3QmxLbUpLMnFuWkprNkNLZjFmTUpXMTdBaVhhOEZS?=
 =?utf-8?B?NkhSVUxJZ0p6VHg2cDhLRVpKR0RVZmdheXg4VGROenZPMzdXYjlyNjZWeS9C?=
 =?utf-8?B?eGRkR0RpWklPYTJRVVZwSU5PQ3Q4UTB3KzZjTGpiYUJhVGVNS1pXbDRrMG5G?=
 =?utf-8?B?VXZnNmEwZEFzVWpNc1hqek5CRi9rSFFIWHNENk9wa1lyNUQ4UUErd2pXZWJH?=
 =?utf-8?B?QnA1OGlHYWNqQ01LeUxxdmF4Zmw5djNML3lYbHMrcG1xVWljVzh5NFp5NjU5?=
 =?utf-8?B?YjJTTGJsZklUekwzSmRUM0hJQ3FkcTA4V1NhNnd3RHZuRlBtVUtvSFZDNDJS?=
 =?utf-8?B?ZkRJU3BtS1AyaXJwYzdJN2lKNW9wWG40Wk81cmNkWE4xMlJjeFZmMkVFQnJn?=
 =?utf-8?B?aFdRSVc1YVZmbi9uNklyZUtqZmkybmU2NHpjT01ubWh6MHdIUDhoRndoSlJS?=
 =?utf-8?B?eEJSSUJSZVZQQ3RNZWlESk9SY0NFS0JDV2wyL3MreTg3czNBZnp4RTZZeXdF?=
 =?utf-8?B?c3M3Y3Z3SHJXT2p5RzdqNEFTNlVjcUZQOXEzUzlSZ3VsYlNxZUJ5dGQ5bmdI?=
 =?utf-8?B?NHZDN2hlTzBLL3dBN1NJMlRXVkZ2VjZkZnQzTU10azNZNWN4Q29PVGZTamZB?=
 =?utf-8?B?N1BJTkN3bWptUWZqNjMrQ2xNOGJYUmxOTEQrNFRCbzNIckhISXlFc0hHd00v?=
 =?utf-8?B?UFpnbjJZL21aUFhnOVJDUnRWQ1F6aFE1emlteURCU2NxVmg5NWIwOUJoTUtF?=
 =?utf-8?B?YlVrUVFka3hxTFRVQ2RGeGg4UXFUQlVQckJPRW1CUzU2eFRWaGNXNTd2LzYw?=
 =?utf-8?B?VXRSUDU5bDVuOVA3MGZoYmZCdWhleGZyQlFkVWJvb05kL1hZUnpITlV6RW90?=
 =?utf-8?B?S095eFJDaEN0OG1jSXZEbmhRZEhUeXE3UElwWHBBZXhWbkpHdkpIaThxVVZ6?=
 =?utf-8?B?Z0JSTWs1dlJ3S1hNaVp1QldoV3NmS3l1YUwxaXcvcmNEY2h2cG5jbk1YMlln?=
 =?utf-8?B?SzJVSS9rejBIb3FnZ21ES25zS1NyM29sM2crQTNOaVA3VTlpTkM5UEpIa2dJ?=
 =?utf-8?B?U29VaHVIL2doRXRMTzY0eXl5U0lzQkZHb0p4SElxRjJMZTVnbUJlV0VDekhr?=
 =?utf-8?B?ZU5KMUF6N2NEbkkrOFkvYmw0aTB2Z01wZ3F2b01hL25YSVB2MGlENm8wSWht?=
 =?utf-8?B?N3FRYm9CM1JWQ2NjVmVOUG44TTFjSmZoY3hYbGhOL3BzSTRvci9ZenJXeE1S?=
 =?utf-8?B?Lzh5TzJQQWNRT01rZ0xmZmRXMElYbDVKSW9YSGNjZUNVN2prbWhwdnRtV0o0?=
 =?utf-8?B?bCtRZVVicVZJSDJCWFJoc0JSSUZ1TFF2blQ2dnlwaGhINFBRTW5yMS9pOUpZ?=
 =?utf-8?B?eDgwY09JR0VFVHZDeXJvQWZFZk1vVWtzc2ZveEp0M3ppbG9yVEcrQXA1QjVa?=
 =?utf-8?B?L1Z3VE1ucE5BUXhQL0pjaFpBa1lYVm5vRDFHell2SVhENE4ycVlYbDdXTFI0?=
 =?utf-8?B?U0lxZTdUVHZteWd0YWVmdnQ3VFlwT2ZvTjRWNjB6RzkzRFF1RUZhNUd2bnEy?=
 =?utf-8?Q?8nkWXothEnAym?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hKR2lZZDJUQmVJejZpcmZXam9NT1Y1T0srUEY3ZzZwaTBaSDFtV1cxcWJP?=
 =?utf-8?B?VnNobWdEeVpaUXlDVStUZlFSVkhGQjl4eEJ3VFRSY3o3QWV5c05JREd5djZC?=
 =?utf-8?B?UWNIMXYyM2xXZ3ZCSnFXMlpUdDJpWlJZWWtaUGRESkxlU3Q1QitSblJZcHJ2?=
 =?utf-8?B?UUR1MnV5dEVvcWFDREIwRUZGaTZKMnd0bXNPMjNEV1RMdDBsSGdGUVdmTS9y?=
 =?utf-8?B?U2xoSnM3NFhUQitpcGoxMzZpcWlUeUZUZTBONS9DbC9yaFZPNFJrb1hjSUYz?=
 =?utf-8?B?a0RXTHBFNThvNUN4ME1QdytQd0NZWDdqbWtvZnlrZ0Qva2pNZ0lscVFGMzRL?=
 =?utf-8?B?aVdwakEvSGVNOHNZbW5uN2F6Y2pCeDNneG45NkVzVUZHWWNvdmhHOXl0VmtJ?=
 =?utf-8?B?bTJ1NnZUSmpvR0diT0lyaEk2VDRJZGYzdFpEOFB6d0haYzU1YXoyLzFVS3NI?=
 =?utf-8?B?OEFDZjZqcWxBWUJYK0NHaVdXYm96VFNwYXF6OEhwMkVPbzgveHF3bTVYcnZV?=
 =?utf-8?B?SmRuYVFSdzI0UUtZY1plNEVqRU9qOURqQy8wM0lZSms2S1dPaHh6SUJtQ0dJ?=
 =?utf-8?B?UkRlSVlBQ0lZQlpMVTlBTHNsT3lpMkhJSEkwQkIzOEptN2lpakYyQnU0MWk5?=
 =?utf-8?B?dEd5WDY2SG4rcHIwWDZ2R0Q2Z2ZQVU9vUWdHT05YZTdiZkFQNEtmVnpnYkht?=
 =?utf-8?B?cHlLcEg2aWpwMXVqeGE4TnNzeUhaL29GRjVYSGdZZTA4YWhDZ2xDRUlXVDBk?=
 =?utf-8?B?QUxmNDF6RVV4R2tmbXZ5cEJYa1Zzam9EM3h2VDRra1BFUXc0Z2xZUmM4MjJU?=
 =?utf-8?B?dWxkczE1UVl5R29SOTRlRm84NzczU2xoNHoxa2sveUlQR2Frb3dRcUF1dm5E?=
 =?utf-8?B?QlhGUHphNVhMWlB4OHZDUTVGL0tsQlBSckgrRmNRYXlwcExnK2EwK0tocGpG?=
 =?utf-8?B?SFBBZDQzRTNSQUt5R3EwVzQyRFRheGF0b2d5Tk9JQU5HSzJGNDNoQkN0YnhN?=
 =?utf-8?B?VGdSOTZMb2ZMU2Q2cTYrb0U3S2ZINFlPQWNLOWtqVGxuYVJNV2U0eU40c1pv?=
 =?utf-8?B?TWJaTjdxKzgweHVIUEl2TWY1NVNMV0tzNkN0M0xicjlveENhSGJaWW1FZVZD?=
 =?utf-8?B?UGJyVEhweU9CMUtnQUtxWFRDV05qTjZydlZ3U3liWjk0Yk01OXNmbXVXYmFm?=
 =?utf-8?B?VTNhOFZaTEtJR0hlT1VZY3FRcldGSjlxSnRSMGh6NHozZDEyTWIzRjdVUkRV?=
 =?utf-8?B?TzN0N09haHA0UkNIb04wZm41MUp4OW15L1FkdEVuZnU2WU8wS3NGbVordE5Y?=
 =?utf-8?B?bS9aRE9IUW5vZnl5Q1M5YjFYeTliaXh3VjhLRzI1bG84UU9RdU9CM0RNMEIx?=
 =?utf-8?B?TldXWlJIdUg4ZTNvU2tFdmNZR3FTMnNUYytqbTgrZ3FkQVI5QWgyc1JLbnBx?=
 =?utf-8?B?M2hLU3NRQUtMQytXNDRvRWRwbXdHTk4rUHZuZjlQd2d4NkNJOWRYWFlWanJQ?=
 =?utf-8?B?QVU3RlB0WWNxTUlFWjFOMmZuYk40YjhLWTNua0ZicXJYU0Jmb3k4VWRqemZS?=
 =?utf-8?B?STFLNy9acnR6Z3RNMVBqS0ptOWlnWWt3S24vMU1VWXNyZ1N5NG5vZEFVNThl?=
 =?utf-8?B?QlI5Y2xyamEvdlNmUHpJOXQyTDk1Z3gzSktGUmNhYVBkMllDL0ZRdzJSYVpJ?=
 =?utf-8?B?a0E4V2JLbUJDVFpYdmVBS210dlZBclF1dUFPL21MdWFjQ3hYQk5uekpXdkJT?=
 =?utf-8?B?Qk9LUjc2MzdOOHpjR3QwRXJZOW1uTzZ0andoMFFZd0ZkUE5QMlNGblA4Ry9h?=
 =?utf-8?B?Y0svQkVxcWtvR2VrcGoyWW52ckY3ZzA1RnRmR3pCd1VqTk1HcTdmczVBRFVP?=
 =?utf-8?B?WDBqL1ZuYkN5ZEtSNm9VeGRrS1hSQ0FyQnp3VEt2dEw2R1F5N0gxU3lKZEJR?=
 =?utf-8?B?WXhZK1dMTmRNc2xGRE82QVkrejdOc0hzV1FXRmVCM3dtT2NZb0dydlpONUxV?=
 =?utf-8?B?cVU4WTcyRVU3WVRUaUVkbG8xVkpoTW1DT3RFNGx4anBOcHErTTZSMmtuVTc0?=
 =?utf-8?B?K0dzd3hObXhUMWVBQXVBWVFqRWhQVVByVTdsRnVhSnlEWTNpanhsa2dsVElT?=
 =?utf-8?B?YWN3TWltWTRLZWUrRDJZcU0wRjJZUkpsZ29RRDJkTTJEbGg3SXZrWm1OT3pi?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nJqcSUeqit70WHYgnjPM3z3yf5nQIlDvTLU2YUVGV0EFkf5jS4MKC/Y34k29L3jgUVhDLxYlRm+qFqGUnJkH9biBkx0DCuH+rRyEC4OnUGCOIVxjXoPZbZU5n4Y7XoH8qqMvq7vPxw+X/jV+lHpPZ2VsNTye4q12suVsKS8EDHurduYJ74qwup3kc0ADtltSEKeWozAjo/mV4lYGwURvO/2NX8rAEVMIJMp1yXvsBFhYgZWhVUctEiErTcTNypK9/eJIaz0im1ByM9mLNOarCzWyAqY6aVVzLFZfefb/NT+T+LzOBN2DyeWEr7NdmZOhaE3uCjX3T1rjP1SlGiz4kzvO4MszXf13YV1TB4LcukFqJd84LYGTjew//4e/DmIk9b+iOrkfI+awthm5/lbP5F6rZRXceyXubLHKx71FQopgURk4h9rGIqjVGP7yxO6Para+ek536cf+XIpccxXSEeKC6WH3z5bto5/csEydDVhyARqRT0VfZjqp/nK9OTdU903Rg3xk8UAmBDv/vYj5F/lybU5aoKS0us/Y4B0uaj5tJVa/KkSJzoYPnfp4L1agZAXbJav+PGddBLu4oq1Sk2ytdaoyK6vAq4eaPcRi138=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8ec2f2-0343-4587-9bd4-08dd4630adef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 22:01:44.8547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2l2OWPfN5uI/vv9WnA2czEjrJpFIIrdzLkmOL+VcEzPWfgVFMohuu4ImL8PC6l0BF73yiZMSqxn3vg4ELt4EZltRxTaWfEhGjc695cDUp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050168
X-Proofpoint-GUID: PlWC8e4cDpvGwBCsFgRaWSNnfCsBFZrn
X-Proofpoint-ORIG-GUID: PlWC8e4cDpvGwBCsFgRaWSNnfCsBFZrn
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/5/2025 12:23 PM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
>> Such a mapping can be preserved without modification during CPR,
>> because it depends on the file's address space, which does not change,
>> rather than on the process's address space, which does change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   backends/iommufd.c                    | 36 +++++++++++++++++++++++++++++++++++
>>   backends/trace-events                 |  1 +
>>   hw/vfio/container-base.c              |  9 +++++++++
>>   hw/vfio/iommufd.c                     | 13 +++++++++++++
>>   include/exec/cpu-common.h             |  1 +
>>   include/hw/vfio/vfio-container-base.h |  3 +++
>>   include/system/iommufd.h              |  3 +++
>>   system/physmem.c                      |  5 +++++
>>   8 files changed, 71 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 7b4fc8e..6d29221 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -174,6 +174,42 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>>       return ret;
>>   }
>> +int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> +                                 hwaddr iova, ram_addr_t size,
>> +                                 int mfd, unsigned long start, bool readonly)
> 
> Please introduce a patch for this new routine.

OK.

>> +{
>> +    int ret, fd = be->fd;
>> +    struct iommu_ioas_map_file map = {
>> +        .size = sizeof(map),
>> +        .flags = IOMMU_IOAS_MAP_READABLE |
>> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
>> +        .ioas_id = ioas_id,
>> +        .fd = mfd,
>> +        .start = start,
>> +        .iova = iova,
>> +        .length = size,
>> +    };
>> +
>> +    if (!readonly) {
>> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
>> +    }
>> +
>> +    ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &map);
>> +    trace_iommufd_backend_map_file_dma(fd, ioas_id, iova, size, mfd, start,
>> +                                       readonly, ret);
>> +    if (ret) {
>> +        ret = -errno;
>> +
>> +        /* TODO: Not support mapping hardware PCI BAR region for now. */
>> +        if (errno == EFAULT) {
>> +            warn_report("IOMMU_IOAS_MAP_FILE failed: %m, PCI BAR?");
> 
> I am not sure this warning can occur when the PCI BARs are mmaped
> in an VM with incompatible address spaces. My attempts produced EINVAL.
> Let's keep it for now until it is clarified.
> 
> 
>> +        } else {
>> +            error_report("IOMMU_IOAS_MAP_FILE failed: %m");
> 
> please remove this error report. It's redundant with the callers which
> will report the same.

These warnings and errors are copied as-is from iommufd_backend_map_dma.
I aim to be bug-for-bug compatible until the issues with mapping BARs
are resolved.

>> +        }
>> +    }
>> +    return ret;
>> +}
>> +
>>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>                                 hwaddr iova, ram_addr_t size)
>>   {
>> diff --git a/backends/trace-events b/backends/trace-events
>> index 40811a3..f478e18 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -11,6 +11,7 @@ iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d user
>>   iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
>>   iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
>>   iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
>> +iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int fd, unsigned long start, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" fd=%d start=%ld readonly=%d (%d)"
>>   iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 302cd4c..fbaf04a 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -21,7 +21,16 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>>                              RAMBlock *rb)
>>   {
>>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
>> +    if (mfd >= 0 && vioc->dma_map_file) {
>> +        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
>> +        unsigned long offset = qemu_ram_get_fd_offset(rb);
>> +
>> +        vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
>> +                           readonly);
>> +        return 0;
> 
> This is CPR related. Please add a dma_map_file helper and move the
> code abolve to a cpr file.

This is not specific to CPR.  It has value that is independent of CPR,
by representing mappings in the kernel using file mappings with folios
rather than struct pages.  It would be proposed even if CPR did not exist.

>> +    }
>>       g_assert(vioc->dma_map);
>>       return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
>>   }
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 42ba63f..a3e7edb 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -38,6 +38,18 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>                                      iova, size, vaddr, readonly);
>>   }
>> +static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
>> +                                 hwaddr iova, ram_addr_t size,
>> +                                 int fd, unsigned long start, bool readonly)
>> +{
>> +    const VFIOIOMMUFDContainer *container =
>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> +
>> +    return iommufd_backend_map_file_dma(container->be,
>> +                                        container->ioas_id,
>> +                                        iova, size, fd, start, readonly);
>> +}
>> +
>>   static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>>                                 hwaddr iova, ram_addr_t size,
>>                                 IOMMUTLBEntry *iotlb)
>> @@ -806,6 +818,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>       vioc->hiod_typename = TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO;
>>       vioc->dma_map = iommufd_cdev_map;
>> +    vioc->dma_map_file = iommufd_cdev_map_file;
>>       vioc->dma_unmap = iommufd_cdev_unmap;
>>       vioc->attach_device = iommufd_cdev_attach;
>>       vioc->detach_device = iommufd_cdev_detach;
>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>> index b1d76d6..0cab252 100644
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -95,6 +95,7 @@ void qemu_ram_unset_idstr(RAMBlock *block);
>>   const char *qemu_ram_get_idstr(RAMBlock *rb);
>>   void *qemu_ram_get_host_addr(RAMBlock *rb);
>>   ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
>> +ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
>>   ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
>>   ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
>>   bool qemu_ram_is_shared(RAMBlock *rb);
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index d82e256..4daa5f8 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -115,6 +115,9 @@ struct VFIOIOMMUClass {
>>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>>                      hwaddr iova, ram_addr_t size,
>>                      void *vaddr, bool readonly);
>> +    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
>> +                        hwaddr iova, ram_addr_t size,
>> +                        int fd, unsigned long start, bool readonly);
>>       int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>>                        hwaddr iova, ram_addr_t size,
>>                        IOMMUTLBEntry *iotlb);
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index cbab75b..ac700b8 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -43,6 +43,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be);
>>   bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>>                                   Error **errp);
>>   void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
>> +int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> +                                 hwaddr iova, ram_addr_t size, int fd,
>> +                                 unsigned long start, bool readonly);
>>   int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>>                               ram_addr_t size, void *vaddr, bool readonly);
>>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 0bcfc6c..c41a80b 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -1569,6 +1569,11 @@ ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
>>       return rb->offset;
>>   }
>> +ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb)
>> +{
>> +    return rb->fd_offset;
>> +}
> 
> Should go in its own patch.

OK.

- Steve

>>   ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
>>   {
>>       return rb->used_length;
> 
> 
> Thanks,
> 
> C.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2FDC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 21:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHU51-00011Z-Bo; Tue, 20 May 2025 17:00:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHU4u-00010y-R3
 for qemu-devel@nongnu.org; Tue, 20 May 2025 17:00:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHU4s-0002UA-L3
 for qemu-devel@nongnu.org; Tue, 20 May 2025 17:00:48 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KJTZQk020441;
 Tue, 20 May 2025 21:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6bBSw1pEQz7ltUTRBSL0hviIGHd0bWhbyKjmzZ7k0Zw=; b=
 h1ZCQcD8FaMs79RL6nB7iLqChohISzZHkMM2U4Tl2sNqAmd6FIGpLrrCh9w9X/Mm
 vovQllmmgjw4FBt6cKotqV6IcY8bi36P4DdvjYpePdEnDkeu51sLQPwFNTdd9Ck8
 7Re43ubelmpA3htQD6h4yW8PP98OsUoxgDBhk5LqxhgiWUAA+uDbDG27Rsj7oyPb
 U6evE7UPhT+hkzXIG0Z4bVpxxR61aQK4X8TPwdp07s4xtrYmEtzB/zbHIoW+nAfn
 NIKu7oiNOBfaQrSs6YJEHpmiRHO9gBNUHz1WTRoOuwCJO7nas/M39X+1sRFcC7uM
 abfmkfX0dkwfHlxby76y6w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ryxdr60n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 21:00:42 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KJv9cf038076; Tue, 20 May 2025 21:00:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwerj344-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 21:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPhf/G3XG5CIsdQ9wSjMVqgK0koJUpo+QrXtvOalLTArJbEK5DiYmr0LPMHzlchIhsccjYMaNGJIDzWQ6sIadF06zxQDT1eizGfQudbj/f4p2JsAuU5V3v7UGQ7gwHJZhUV0q4oOB4Q/H8wLXCUTKcuSxDxcN7piTp4DyodhB83r5OxmOeeiMgCa3wjTYQAwc9mrBNsoXGSnqa7TnNuqRl7jl7eP8ambfuo8YiYQs2rm07/OC98jQ6ILi2Snp1npYqN3SM0uiGChx44XEknXINYfFw/8kHbgIsgW/nYPY+16b745bU4YFZ6smIX3OA6JNW0TUTLRRG3WWvGEgHDPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bBSw1pEQz7ltUTRBSL0hviIGHd0bWhbyKjmzZ7k0Zw=;
 b=hBn6i0mD+FP9oEygkEZpcDTL+ksjOUDTeAQokV/m8D9w3TH1lRt/gROt3GvxMsaYNxYS+ZbYr72pO5wD9uFM/pqgfjtEzamuKtSVQWrT5oBXSMNbT+hXFRE6QzhP6WfmrVG7vXdpHb1qf7D/Fr99WJmnIDcT+KvRnG/vpvcD2E3kCRzq81wYvcaZgjZnYdDVyayIPZVPdgZe5GVHf2W8EOHQU20taR7W91WxGWxXqRSfcezxZMDfLut5+eP69+kihySrvpnLw1kgXSzl5xZqkFkvptwqZG/Cb6mgE6u4vW4esC0SmGYnvY6c7tKERt36bhVe63sQGKKPmwzhlM0FpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bBSw1pEQz7ltUTRBSL0hviIGHd0bWhbyKjmzZ7k0Zw=;
 b=YWufU79cCN8IALouaKgooytFt0eGw6bfWchqfd6woydX5Kh5fk0H6agxQRLWEzUbHanN1w5WRrPvXI77tR58Rb7U1dTo+Gra4FmWKrHbEONximTzAPi8/4V/5MS/qRcuQQE20J26dlw+vTQu3B+FL/9ALlaAZSHVtqWouZt4trY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB4834.namprd10.prod.outlook.com (2603:10b6:208:307::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Tue, 20 May
 2025 21:00:37 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 21:00:37 +0000
Message-ID: <513443f4-aaf7-464f-b39b-a22391f069a4@oracle.com>
Date: Tue, 20 May 2025 17:00:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 34/42] vfio/iommufd: invariant device name
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-35-git-send-email-steven.sistare@oracle.com>
 <c92954d8-f70b-470a-9e12-890c9bf63d4c@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <c92954d8-f70b-470a-9e12-890c9bf63d4c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0222.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5cc1aa-0494-443b-cf99-08dd97e15ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1VlR3VON2F1T0FtMkYyRGZFY1l1L1hCVHhydjQ2SEhKOEZDaWIyc2xYUXBv?=
 =?utf-8?B?b1ZmTkkwUEZsRlViK25VS1B1bmZMWkpKZzhZRldDN1E4Ykp0VXZBeUtLTitE?=
 =?utf-8?B?MngyRzVzMmd4cWVlNUtLNUgyQlZ3M2pkS2NzME54RUl2Q3Z6K1FsejV1OXQ0?=
 =?utf-8?B?Ni9mMENvQ0V6Q05kWGlhTUQ4RUpsaW43bkhBSnpwKy9tdHJWdk1GVVFOM2tZ?=
 =?utf-8?B?UnMrTjAzWG5hazNtWWFFcURjdmlqSXNpdzgxN0ZRbnVpU29RS1RlMlJmeVpJ?=
 =?utf-8?B?Wld2Wnp3aXRZZGRXY2ZIN3ZBSWtHOXBSZURRbjVPQXI5TWFNdWR2aVFNZnlY?=
 =?utf-8?B?NGJ4MEpKVnRFcE41ZWpkWHdyRlVKeHhsUjF2bUVuOW9wRWZlUlFqc3JWc3Np?=
 =?utf-8?B?Nnpvek51WkszWWhndVV4Q2hOWUlQR0hSZFBZK1VIZ1BPckRlbWVEbXl3RTdF?=
 =?utf-8?B?NjdCWGJ5Tlo4YTJ3aFdjRnRhQWhuaFpLMHkvVGxmQ0c0TG1kMk9NcjBoWWJt?=
 =?utf-8?B?UEl5L2p1dTdGM1JRU2VGcVdqdnpueG1zNUdzNnk5SHJqZFd0b3FvSW9uNllY?=
 =?utf-8?B?R3cwSUJFTHFpcSsrTjNxVHl5YlZEYkVEZStjQXFDQkZ5VmtoMktKTmRPU0tI?=
 =?utf-8?B?bHgwdEhvNzk3OUpBK2pBV3JVVmNMczYrQzIxSXFaM2JIbzJGakx1N1VDRW90?=
 =?utf-8?B?Nit3MitsSkZSVy9NQnBSWHN0NGsydVBubDNiZmJTaUxsbThRYlhLMG41RERR?=
 =?utf-8?B?QXl5UGt0SlhIaEFCTEhlSHJuRWlVS1Y5a0NabGpNUSs2NFN3L25MUXkrbm5q?=
 =?utf-8?B?MDJVYUpXZ1psZjF0dTBpVVg4MlhkYVZFb0o2TWkyV2ZZYzF3N3F2eVlDWlI0?=
 =?utf-8?B?Mk9CWjNuVW9ucW1kYnJibGFSR1ZwOFM1OG1hSW5xZFdBYUE4amluMUVJZjZn?=
 =?utf-8?B?UWZqaTl2YUZlQVFUVGFQL2JGTm9IOE1KbkxMd3FOOFYwWUlRZDliTGdGdjNs?=
 =?utf-8?B?RFY5VmhBTU00WHdadWUrMFJBWkNRalRxOTBiZlZJcXlDRkhaNGdWRVdrN2N6?=
 =?utf-8?B?aUw2bmY2QlhSNCtmeDJ0ckUzdHJ4U3VSZXl1TEpJTDQzVHVCRjlJOUEvMjJy?=
 =?utf-8?B?WkYwQVFWK0RjL3lWcXpKS21aMTZWbWQ1eld5ZHlIeDZhZUxyU1AvRU0zb2pW?=
 =?utf-8?B?YXBHM3NlMGlXQlNyZytINFFpMFdhZ2EyOUVTSzJvL3cyOFlVeWZsRGx0QjRR?=
 =?utf-8?B?RW1lVW94aFlFY1FJVVVia1BXaGpOSmZQeDVjckZTT0tKWFozdkhleW92NmRQ?=
 =?utf-8?B?VzVlVXhoVUlCNFovS0dxeGlNSEJXNjA5dUEvOHFlQzJEUmgzcDBHVzJZM2M0?=
 =?utf-8?B?K2tHOWVzRmlNN3VLdVM3UTVSZjRuRUdtQS80NUhNMVJDUzBzWWk2c3RYbG4r?=
 =?utf-8?B?bEU2M29ocnJURXNON09kUDNmZ29QUUxyZVl3T25rUDVBLzJSNGFhajluaFhn?=
 =?utf-8?B?ZW84cE5ETTBZYkV6ZVlMZnBKbCs3ZmlCV0tmVldHMTVBY0drTWU4WFF0QVVu?=
 =?utf-8?B?bk1mbUJSTlMzalRlWDQ1Zk1kajExWUVYNEg4VVRtSU1RMG1Dak1tSzFrQnJo?=
 =?utf-8?B?THZpc3VUbndlbkRwOSsxZXY1VGRZUVhPZ0ZLR3JsZDl3NEwvYnhJS2dHQU9n?=
 =?utf-8?B?MnUvYTczN1JqZkx1VjVnQ3ZsQnNod3FQZjR2UnQ5QUM1dDduTStRRWo0eEpl?=
 =?utf-8?B?NzFLZWl3SHV3QlpSRS9mLzNITVBUNXBpemtrazljZS83VXlKT3YxbC9tVTVv?=
 =?utf-8?B?cWFFSEFGaElmMHdYdXBJdC9pcVRUbm56Mk5RTUgvL1ZxSzlnV2VHR3F0U1lk?=
 =?utf-8?B?cTQzZHA1bUNkUzVFV0oyOHUwL1ovaFh2TTlRUE1sK3UxUEw2UG9mR2NTdElC?=
 =?utf-8?Q?KZF3FzTCH7Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmtxZ2t3RVpaY0RZdEpGdFptRStpNHdCaTJRbUtBMFF2V2Q0UzNvNGJxMGg0?=
 =?utf-8?B?cVgxTW1ZeXlIZkpqTEdhbWw4L1FZTmQvWEJXUU1vZExxZEEzR0xmMnJhQmJp?=
 =?utf-8?B?S21VcWRFdVN1OE5uOFNWZVo5TlRFTkVlTEhYL2s1OTBFZGVDOGpXT1lYY29O?=
 =?utf-8?B?WGZpVlFMR3htQVRwVUlibjRldmNHQUhzdlFDejg4SnlTclBBTHlPTmluQjlt?=
 =?utf-8?B?d0tPOGgrMEJGMm1Pblppd3hJdkd2RE1ITlNZTExJc3ptYVVFTDR3MkRxSVY1?=
 =?utf-8?B?WnRZRXhWVTA3RmxIckxMR21vZVZ4S01RVVcxanVWWU5jRlMxdHpWZFB1cnhE?=
 =?utf-8?B?NVBOY0tlYW1jK1ZKSFVwd1lyb2lhbWpiRG9mWmc3dnl6WUZrM2Q3bEZxRnV1?=
 =?utf-8?B?ODV1RFlYZklEUnJrYURyUnRGMUJ3VzUwV3NNcWZZTmxveGpBWHp0NnhsZFdE?=
 =?utf-8?B?bUhTUXdrdGR0T3hzK1cvVkhWOFVxTVV4NDlwVld0SENkamVRTUFPSTdodzJ5?=
 =?utf-8?B?NldlWkJwQWxVWmVsa0RFUktZaU9Fb3lId0t0a2hjcGFtbk1JZ3pBa05oR1Fx?=
 =?utf-8?B?bEtsZ3ZEbmc2UUs5a1pVeDMxMnVsNndWUllYQTJaYnI2RjJFeC9lVGpIa1kx?=
 =?utf-8?B?cnpicTJGYitZbmNEQlo5TUlQemxpNEt0RnRCeWl2RFV1cTdBVmxGVitRMjBJ?=
 =?utf-8?B?R1NsQjljWHJ5ZG9mWitBTHFyOTFFWWdndlhHdjhoTWVUcG9VOUcrOTdwVHp6?=
 =?utf-8?B?WEU0N09nVXVia0N0SGZXY0RJQjFTbVJxWlFkb0x6WDhRR0QyZkZITENXM01y?=
 =?utf-8?B?TDRxcWlYU0Vqc3B4a1hneHNxdk9DNVFra0ZWVnJ0M3VTSmpHQ0NXb3BVdTFY?=
 =?utf-8?B?UVVtRFBOaUtTMnJIUXFMeWpDUklHc2FiSTRYVG9GY1VPK245SG5FQk5zUWRn?=
 =?utf-8?B?VlBpV2FOcS9KNHFoWHZhN0ZKREpVZUZRWkk5Nnl4dytZVUZqbWd1dUZJVlI3?=
 =?utf-8?B?dnZVcHBFVThwcGFzR0lYdHRTTmh6WURmcmpGU3ViL0RGWmp6NnhVdDAydDB6?=
 =?utf-8?B?SW41Q0JxOVJFZ3RmUmJzM3hRekpKamlnYjUvcjZuTnZVVk5yZkRleWRaWnVG?=
 =?utf-8?B?ZzFPSVE0eU5aWXozTVg3UDMyTTBobXlhSSt1QXB3c2UxcmdSQ2FpekVNbVhL?=
 =?utf-8?B?NlJSL1RXY0tHUnJnbEJ4cHVUQk45OU9hWHJlR0p3L0lCbkpXQjZSL08xWHRi?=
 =?utf-8?B?RW9TRGtMcjlyR1J3N2hkZGVnck1ybWl3YWhnVmo5M1BqeGd2NHVUZnJYSUdl?=
 =?utf-8?B?NThwSHIvQTlwQXNCeVJvamh6UkZyMk9tQWhtS29pVzc4ak5PUTNLam1OUkwz?=
 =?utf-8?B?d0RmYTVkVXJ5RUJ6dGEvUFpkRG1md3pyRFFOUWxTMzdybFJ0NytoMGo1WG8v?=
 =?utf-8?B?ZlVtbU93emNScU5jdHczdlhreG80Q1R4bUhZYkd3djRUbHpXazR1TzZ1QXJ3?=
 =?utf-8?B?MzBIMHN1aEVDMEJ3VzI3WVI0RXN6azcvV2V2MEVSbmYyWEtRZmVFcWZGRFdv?=
 =?utf-8?B?eEYwRkJhdnZGUG1nTkFkWCtTZS9LUkhkRWhVZElwTXhoNXVhWnNUMWc1S21D?=
 =?utf-8?B?UnVnb1hRa012TVJKSTNpNVd3b1lBV280dHJHcEYwQ1J1dXYyb3JyejZ0OGRU?=
 =?utf-8?B?MEg5d1dnL1FMbzJYVWh5d25ERlhRWDAyUkorbGs5cC9Ka0h1WkZpelZMQWZH?=
 =?utf-8?B?a3pVUzZqY1dlM2NHKzZBTVYzYjBNa29sOVkvMEZYQTFNUkRheFdIZWlUcDhw?=
 =?utf-8?B?WlRGWkVuejZWdHozcGpYZ0FTczByRXM4aEZrUWJKZ3h6cVFBemI5L3h2VVNX?=
 =?utf-8?B?cjc5anM5SGtyOGZrdXdycDZYbVFSd3g2U3lJYjc2eUJrVFpjNlZjWlJnam9R?=
 =?utf-8?B?Z0JqYzFMNFJoV0ZTMWhOMnFubWRhNGhtM0hpNEFsYVc5OGlJQmo0UUhHVGUx?=
 =?utf-8?B?dVhLOHhMRElQMzlaOXRLYUoreFhEU3FmMFVuOFQvVE1JcWZhZEIyYnZxamF6?=
 =?utf-8?B?TEhiaU9WbDN3RzNTelpiMDVla2FlTGJ1VHduWk0xWk9GcHp2VWhLcFIxd05W?=
 =?utf-8?B?M1M5VEZ5amJoTFVrNk9YcjBnVk96WjF2U3Y0UTJlT0RCcmJ5T3lwcjN4amMz?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iMjEg3yPDnPotWQjA2jjDWrXAlejQ8wxSUypUFmqettqTPz7dWwxRImTVkf+5iDKImiE9Jvb5M89Tyj54sMuLcBjUIROfmMbVTatf7A9cvNStennNcnliVlni3rhWKkuQefU1v4xhD53Z8/cqVpKhxZPtQEFnxIsTV4P/t3sUJiCJl0FM1Bu5oS85n6P/f1A/0l5RNKkqa6hVbaCxzHdlkcBaMYUwQkxqfpVhAaur9kKVh+J0aGY1mdThvTBiOeOZcp4NBtdEkjLk9ULBXgXXbHO8WePdoVT5q9MtJSxC3GyXAgMfLnpaDZCshU7P9nX/GlSZmglMsgd4JnGTyZkAoPHuwP8kmhiEsf0jSUD/kqUFYHJ9FyL4w5Hf/zcBxRDk4ZhQKvjhUi3P8Ho6B2Fies7rHv0qd4PYgvIzHkH1LpmnBpf/Y6QAz5EZvhJP39OVA/XCRcCVgQWlmO9us09Kx4C26PDd4+8JDeainxdwIuHJ50tl3LJu0azqkT8l+qybPOR3jNjPsNErWMoulH+vA4uFERJcEfDwHZqQTJmbaV1r0ZnPiuf8kvngAyp4Dl0COTNR279bx64A/DBRF3KV3oRYPp7m7cEygtdzU4ZGQ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5cc1aa-0494-443b-cf99-08dd97e15ef1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 21:00:37.5293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvQgpOJ6NTYYIVkYymkT7xpRpebufNffc8fT4Q2yKAUZJFwSWVbbyEF6vLxUF73e3mRr4PkEievUSRD+QrozpVbB1kfgl0MXim5BTJzL7Ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_09,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505200171
X-Proofpoint-ORIG-GUID: N3wOsl8sRGJLTGVDd_E4HWVDle5-N0qy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE3MCBTYWx0ZWRfXzxWFBPWTgwdx
 rjMI2Xu0bkDA/OvBst+XGBzeGaxW1aCeSk0C+cE3RcChboX47x//YZE0DuRt2ngQ5Ag6z3Ycsbe
 thzEsn2PHPRr8v/evKVH08IGt/s82W1hOsXDh0gL4lEHMLJHmR9DIyv/irdcnIA0s0apsIN1DbT
 Hu65X5U75RwJNZkFCzYvVx4Wjr/us1kkVuGZsG0D6ZQUMVUsGZZZzTEI00Qb6V5aPK809si044M
 CdgbiQuvJrPQMov/RKcQFhWv4IBuTowDBd3aCx0Oj79/SWH9Vm5jHNWsVaV1SBydJa8OojT3VYu
 eYotQGZjkUjRHRokhF28eLEQcHuwTFEAIOCDAYf8eL0+Q3RSG31HDEcUVcxb1LbBEzCLY3Ajrv5
 8z7PfeRO6vD+jVXMpY3XZv/iGB/T+wr5Lm/WZbdELHRF/SB1DG8OCbYidY/NuK+z4IKCx4vu
X-Proofpoint-GUID: N3wOsl8sRGJLTGVDd_E4HWVDle5-N0qy
X-Authority-Analysis: v=2.4 cv=ZKDXmW7b c=1 sm=1 tr=0 ts=682ced7a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=CuGZ61GzXcyR_fWHcW0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/20/2025 9:55 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> cpr-transfer will use the device name as a key to find the value
>> of the device descriptor in new QEMU.  However, if the descriptor
>> number is specified by a command-line fd parameter, then
>> vfio_device_get_name creates a name that includes the fd number.
>> This causes a chicken-and-egg problem: new QEMU must know the fd
>> number to construct a name to find the fd number.
>>
>> To fix, create an invariant name based on the id command-line
>> parameter.  If id is not defined, add a CPR blocker.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/cpr.c              | 21 +++++++++++++++++++++
>>   hw/vfio/device.c           | 10 ++++------
>>   hw/vfio/iommufd.c          |  2 ++
>>   include/hw/vfio/vfio-cpr.h |  4 ++++
>>   4 files changed, 31 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index 6081a89..7609c62 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -11,6 +11,7 @@
>>   #include "hw/vfio/pci.h"
>>   #include "hw/pci/msix.h"
>>   #include "hw/pci/msi.h"
>> +#include "migration/blocker.h"
>>   #include "migration/cpr.h"
>>   #include "qapi/error.h"
>>   #include "system/runstate.h"
>> @@ -184,3 +185,23 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>> +
>> +bool vfio_cpr_set_device_name(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    if (vbasedev->dev->id) {
>> +        vbasedev->name = g_strdup(vbasedev->dev->id);
>> +        return true;
>> +    } else {
>> +        /*
>> +         * Assign a name so any function printing it will not break, but the
>> +         * fd number changes across processes, so this cannot be used as an
>> +         * invariant name for CPR.
>> +         */
>> +        vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
> 
> The code above should be in vfio_device_get_name() proposed in its own path.

I understand, "in its own patch".  Will do.

>> +        error_setg(&vbasedev->cpr.id_blocker,
>> +                   "vfio device with fd=%d needs an id property",
>> +                   vbasedev->fd);
>> +        return migrate_add_blocker_modes(&vbasedev->cpr.id_blocker, errp,
>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
> 
> The cpr blocker should proposed in a second patch, maybe with a small
> wrapper to set the 'Error *'.

will do.

- Steve

>> +    }
>> +}
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index 9fba2c7..8e9de68 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -28,6 +28,7 @@
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/units.h"
>> +#include "migration/cpr.h"
>>   #include "monitor/monitor.h"
>>   #include "vfio-helpers.h"
>> @@ -284,6 +285,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>>   {
>>       ERRP_GUARD();
>>       struct stat st;
>> +    bool ret = true;
>>       if (vbasedev->fd < 0) {
>>           if (stat(vbasedev->sysfsdev, &st) < 0) {
>> @@ -300,16 +302,12 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>>               error_setg(errp, "Use FD passing only with iommufd backend");
>>               return false;
>>           }
>> -        /*
>> -         * Give a name with fd so any function printing out vbasedev->name
>> -         * will not break.
>> -         */
>>           if (!vbasedev->name) {
>> -            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
>> +            ret = vfio_cpr_set_device_name(vbasedev, errp);
>>           }
>>       }
>> -    return true;
>> +    return ret;
>>   }
>>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 8661947..ea99b8d 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -25,6 +25,7 @@
>>   #include "system/reset.h"
>>   #include "qemu/cutils.h"
>>   #include "qemu/chardev_open.h"
>> +#include "migration/blocker.h"
>>   #include "pci.h"
>>   #include "vfio-iommufd.h"
>>   #include "vfio-helpers.h"
>> @@ -669,6 +670,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>       iommufd_cdev_container_destroy(container);
>>       vfio_address_space_put(space);
>> +    migrate_del_blocker(&vbasedev->cpr.id_blocker);
>>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>>       close(vbasedev->fd);
>>   }
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 765e334..d06d117 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -23,12 +23,14 @@ typedef struct VFIOContainerCPR {
>>   typedef struct VFIODeviceCPR {
>>       bool reused;
>>       Error *mdev_blocker;
>> +    Error *id_blocker;
>>   } VFIODeviceCPR;
>>   struct VFIOContainer;
>>   struct VFIOContainerBase;
>>   struct VFIOGroup;
>>   struct VFIOPCIDevice;
>> +struct VFIODevice;
>>   bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>                                           Error **errp);
>> @@ -59,4 +61,6 @@ void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>>   extern const VMStateDescription vfio_cpr_pci_vmstate;
>> +bool vfio_cpr_set_device_name(struct VFIODevice *vbasedev, Error **errp);
>> +
>>   #endif /* HW_VFIO_VFIO_CPR_H */
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2376C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 14:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg36k-0004cd-Uj; Thu, 06 Feb 2025 09:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tg36j-0004cT-P6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:43:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tg36h-0007Mc-Qi
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 09:43:57 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516E5NEU028724;
 Thu, 6 Feb 2025 14:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=BC5cUfKDgmHqSwEguofnvjO1kWLOv17k2dXZkO792ec=; b=
 Zx/3t0rxkFbcUqn4JFztdffuXbq04fuRHgV3YrWHzvNn+oYNaKyYIJXrGI4VQZN8
 Ds5aMAfF1cCNapXMd1E5ffBx/9jgK20bRckQ3XJoKdsQpvTje+92gx161xS4iMd8
 +NFtcBGjxPzAq700zb5+pprqhpD8DHMQ+QSOgQPaGajQkuK0yD5nBBzfndDjUX8i
 fA5EEJnyoeusqxEzRk0RcvGGwJktBfdTq0ukxkZef6fI1l6OE1M+W2vY0WZTJxX/
 n+RCyRPExcCd6STRUOrKk6uYFvWuiCfFnDZybzzjxK0p5Qrkq02b2yJ34yIn4F3T
 pgrXJMsjvksw6KquFcALsA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4vnue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Feb 2025 14:43:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 516E5Dff027879; Thu, 6 Feb 2025 14:43:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8p5wvbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Feb 2025 14:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqYTnBhP6fUY/EUKneCZUY47EqbWfsVCemsya83otJon0GaWjgQw6ftWg8N9MsxOSRBOKMn/eY7BNhjprlO9Jr5c/FQGq3zXCFcgrYrDrYFO01MJonf7RTY8gJOmVOObMpf0G46TlQa3E9AaCSdpZbUKs0GH2/9o7nLVVSYO2uSU/DXaw5Du58W+dNF7/ZfJtpY0f6tBjheJFx4NwOyJIP3L5FfHOO2NlrZ19pY7vjBuDWFJDRiHT8Zei+lQvhB2hRwMy3oid2icR2qPkHiGCSh/bEC2OcFv2CrlVag4nLJ6AsUdj85kGKl1SCo2zpIWkNbZicu0wX2WdSq/q3mE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC5cUfKDgmHqSwEguofnvjO1kWLOv17k2dXZkO792ec=;
 b=pj48Ks+VIEBPTwR/MzJ+u/ePPLGM5RzslY5IcEslDXX5MjQG3QP8kh1yDDcBTeCoAS2QaFrkC85ZsGqGKJqUg4JwWFoEHwyJddhAN0JRhgifRvrXN/0yWuXovhhwdGz7FnyIzDNAp812SVsDxf8JfxZBv7gmFv2Fs4UwCfUi8NQ6l139LHCq2lXvLLRGrzNBkwMZLxJ+y/u4wRgGFHBrP4uPLnd44mtPuYdEW/CjbyoyqjIyEJ/Ts5DVpnV9JulC2Vl9B46CzrM8RHXNeVCc5vbo3jMV1YHAv2P8a8EcfxUyCEMjXiPqGlfjdhgdZeOXU7Z0cUzNGp1eO9A4+DK/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC5cUfKDgmHqSwEguofnvjO1kWLOv17k2dXZkO792ec=;
 b=eUjR8Ur77TZWIXqjwmDSk3SHP3EtUkHVtku2UrsFFlvYNQXJk50oMoqBHNkOlDXtlyzNkNw2G08z1ki8RiyYN1DFImAlsQvbtMiIiFMB9SR/FZn3PZgVyf9bfSi5/CCJdEaaSgaWejaTe9oXsTSA5jNG3RJR1zEwzCjm1LWIb1A=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Thu, 6 Feb
 2025 14:43:49 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 14:43:49 +0000
Message-ID: <1a970ff3-f2fa-411c-8970-ef0dd1229c76@oracle.com>
Date: Thu, 6 Feb 2025 09:43:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 13/26] vfio-pci: preserve INTx
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-14-git-send-email-steven.sistare@oracle.com>
 <219faed4-284c-430c-8410-d2af398f588d@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <219faed4-284c-430c-8410-d2af398f588d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0716.namprd03.prod.outlook.com
 (2603:10b6:408:ef::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: ce179877-f1e2-4a90-db44-08dd46bcaaf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2ZaeTRTSW53eEJTWXVVVkdGaTRKcElSOXdKNW5VZDNWZ3o1a3R0d29VZXRW?=
 =?utf-8?B?aUhMZ0lCVURWcGczV2VBQUxjUVpBWU9yWFBYYnZ6bmFCQVpRaUhrNE5JdGp1?=
 =?utf-8?B?ZldQM0RiUWZxMXdHV1BIN0FKYjlLdndIYk1sS3FYbGVMSGNsVDNFcC9tRXZ2?=
 =?utf-8?B?OUx3dWlHb2o1d2dKeWlwRjZ4QXl6Q2JUb0hqWXBkVmIzM2h5TXY4Ukk4SEdx?=
 =?utf-8?B?VndWWThEendyUjJveStwaSsvcFhYTWJuL3gvL2RxTlFZR01MZ3VEcjBma3Mw?=
 =?utf-8?B?TGEzOCtpSVpUTEVlMnFOVUFCR0R5dlFxTXZXSlZlOVErUUVNeG1RY0x5MTA2?=
 =?utf-8?B?RjVzTURWa1F3SUJRdVd5TkJCbklHODJLZDVLYi9xTEUwZlc1LzJSSU9neDRk?=
 =?utf-8?B?S0JidUZrUE9qWWRMNE1mdXdPWS9IWnNQVkJUcDM1YU5nNndFTTc1dDk3MEw4?=
 =?utf-8?B?NUQ1b2tsN2NkdkxaZkFOaWdXVW91Y0pkOFdJRVZsNVdaZ1JJZ2I1NjJWTzN0?=
 =?utf-8?B?ZXBVQUd4RGNNQkNUWXJ1NUlwaGpuaXlwT0EyaEFFcDRPM0xxNHFtSG5UOUU3?=
 =?utf-8?B?d1c1T1FjVmk4SW9iRy90UHBMVVpyUW1BK21PZjBsUXAxTnM2S2dEa0ZtZ2tz?=
 =?utf-8?B?ZXpQeTRybzRwcXpBOXV5UHdKZG8rOC80RFE0RitSbnErZHg0QTJmVnAvZFcv?=
 =?utf-8?B?WDNHeDVtWWFrUFlGV0g0TEUvK1Y3Qzhud3hmSmNpcjdDdnI3ME95dzdLK0N6?=
 =?utf-8?B?WHZUMWlTODVndkE1dVdHSUVQSkttcjAyK2t4Ty9BR2ZnQWxRSkNQTGhPNU9s?=
 =?utf-8?B?OHQvOGtPWnBkSnZOcElvS3lJSjUwUXhzVmtQSDJCY2JtOC9mdDVKZEJRSytS?=
 =?utf-8?B?VlhPSU1iWUEvdWQrY2tuRUJranN3dHJsK0dMRDNaRU1VL2Q4ODloVVJUUStE?=
 =?utf-8?B?UTNWbDNyejd6ME5OQ2xxK0xpaFdqc1pXY082VUpSak4yS2QxeW1Cc3lnRHlM?=
 =?utf-8?B?SmN4aWxHZXJLN0s5SWlHU21oL2ZlSXNSRUkxVFNjV3hVckJHdzVFUi9CZlBW?=
 =?utf-8?B?MzYvY1pRZU1FWk14RXFzeUU2eVpaUXNvNVVPRkpCWUdnUW0xc05kZ256S21B?=
 =?utf-8?B?RlhNek1ETG96NzVGOWVzRnZxZlExM21SR0lkSGcxSmhxc1pTM2FDRWtVOFUz?=
 =?utf-8?B?YVVwNzlXYjFXNDhTTUZzZjBSWkRoQkpOYS9YblcxTkQwUXU5QTVmOG1uS0RE?=
 =?utf-8?B?dlhLWGtLWWxRaGhmVElEby9iUktVYjUwMUpKc0h2TVgzVEF0SzRjd2Fmdnk0?=
 =?utf-8?B?RVp5cU1mUkgvTTJwWDIyZjl4bVJTNWZmVnhPRzRlQjNuMm1aamJQWEdwY1Vn?=
 =?utf-8?B?UVFBdE1CeTd1ai93SEE4R2pKWm40a1lSVGJ5QVBURjBENThGbHEzbDlYU1Jh?=
 =?utf-8?B?eGFUUUxSSC9SVTJhbk1ydlZBT25Bc1JxYzd4U3hjTlY2ckhiWko2VXk4OXlU?=
 =?utf-8?B?SkMzTUxmZE5ibDFINW5PY3FWTGxhRDRtQ2xqOVdjc2VzSER0N2o2NFNVNTFK?=
 =?utf-8?B?TUcwNjh1ZTJCVEdQSW5qZytkazU3VC9rT1dqTktXMzI5V3FFSnlNRHhUMmxl?=
 =?utf-8?B?U0JLNlY1Vkg2ek04M3ZIYndLUHBHL3lJWlcxR2x1a3lVeFR0cWJsSXViSW1W?=
 =?utf-8?B?dS81RHEvOU9BRGpJdGx0MnFydlhNT0htVkFZb3VKNDUxcm5TYkErUnNsVGVS?=
 =?utf-8?B?a2RWWHM1Zm5NWVltTEsxTHg5VjgrZzRVNXVqenFZL2xBRnFwdjZJS2VmVE5B?=
 =?utf-8?B?MHJjUVRyY0hiRXNqSVh1Tk9GTkpFbjFsTERlVTI4ZVBxWS9ZUkJ2c3Ywa0Yx?=
 =?utf-8?Q?FkCEpmyJbA6dv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVlzd3Nicmh1R0lQTWNtZllKQVZhRFU4ZXNZcGppNnpqSTZ6eS92SktuSkNJ?=
 =?utf-8?B?eTM0M3RaRXR4Tmk4d3JzN290Y0JPWEhqT1UvWUlKbkxOU2VsdWFITFJZSXQx?=
 =?utf-8?B?U3I2RERVSEdXS0NaNTFOQnhzMXlyT0tvaVJjWE5JMXJySHRMRVVLVGpQWEZM?=
 =?utf-8?B?WWxOM2ExQ2pMbVR4aS93Z0dyVmpXVmxHdDcxd1BiQXhVQUt3MmloQ1ExUUNk?=
 =?utf-8?B?SHpyMklWMVhIZ2V6bzVTaTQ1RWwvSko5blZBV2xLaVpqYVQ3UzErb1FoMlpw?=
 =?utf-8?B?U092Q2tGWlErTFJOUmxxVGJOWVJnbm1kaHBGazdoMTVGMWhPRW1wWVN1ckox?=
 =?utf-8?B?SnpDT0g5c1JyUngxNGFyTXJKK1ltOVJxaVIrby9QeEV1amRyOWY4T2JhWHN0?=
 =?utf-8?B?ZGd4d1BzSllBazBBME5tcndSLzhwRm9TWHdabXBaVE1rMjFzRmtGOG9FUXZN?=
 =?utf-8?B?cEhxZE9uSzhZcktNc3RiUmJFOHZOYXZkUkt2ODJqY1hGQVhHMysxaHFVckJw?=
 =?utf-8?B?TlFaUWFLL3lZNjhqem8ra0tXdEdRRk1UTE16T3dqTllzYURVeFBHSy9NOXVz?=
 =?utf-8?B?R0ZJNjdEeWVzcEQzbS9Pa1ZtN3lZYm9hOGdCVDNZazdFbnFRVmdIbGpZd3lN?=
 =?utf-8?B?MUx4WnNXaVI1ajRnWFdBbzMzWEpMQm1rbkZkV0RXQTBMSHNIbTMyM05rd0xO?=
 =?utf-8?B?Ylp0QndWL3NvNkpqdndmZSt5bUQvUFJXb2d1K0ozTTQ5eitmbllkdXVZNXVN?=
 =?utf-8?B?SjZ6OUowRHRNdEFxZmhzK1pKL1FzeURaNTl0NWJXd1IvbEVXdC9aRmpTVVhr?=
 =?utf-8?B?a0xkTENXLzNnYlZQazZrbGQzNTh4eU50bkNRd3BCSUg1OFpQc3FVVktpWXRJ?=
 =?utf-8?B?cHMwWk1DVXVmTEk5L1F5bzNMQS8xcUVFRjJnS0JIa0pNK2ZLTmlFMFVyUnlF?=
 =?utf-8?B?eEdBNE5ZeklxamMxcFVjMTlRUlBNa3ZaTXpuVzF5VFlMTTZCVFhMei83NzNG?=
 =?utf-8?B?aFRaUGtTSmV2Rjd1ckJMM0YyaDlONHFWbisvNEpWTFU3QXFISTFGN0l3ZFh2?=
 =?utf-8?B?QUh3SU1obEdTZDZWWTZKNExJQnErR1VLSmtGdFVWUUZCQkYyZXdwVEtNTmlK?=
 =?utf-8?B?UW1jR1pBS1JWNHErREZRY0xuR3cyNHQxeXVmbXFqdFpLUHQ4aGlwNFZzQ28y?=
 =?utf-8?B?azgyanM4YUQxOFQ2S2l5enhGWkJwRDQ5N25QcFhlTHZXQkl5Z2p2UXExNURj?=
 =?utf-8?B?b2MxOFVNWFFCV2JXWUhjTEI3dWFOcU1DdytwVWNOTVU0S05IVjNjOExtZDB4?=
 =?utf-8?B?cXROR2N0TXN1ZHI0aWZ6bGRYek1rOVdyM2dHbEZRTkN1U1FNUlM2VjdaME91?=
 =?utf-8?B?VmtTcjdVeTYzK2dYVUdaQUZ3NnlTOWxvaHgxeG9ZbGlsd1BWMC9mcGRnazZH?=
 =?utf-8?B?ZXN0UlhhSmhVa1pSTW1BaWM0OVlrc3A1R0VJWkxtclZzQm1yY2lGdlk3QUF4?=
 =?utf-8?B?d05CcVFBeExTclRuS1lidmNqUThoSWFJMkkydituSjBibXVEYm5sT3ZRdTEr?=
 =?utf-8?B?a1dOcU5vZk9ERmo4QVpOM0FqVEhNMjVabWRzYVV6WWttaHhDVHg3RmtNeGs3?=
 =?utf-8?B?SEJER1BlUjlTSkRuUTBMaDJlYUNQRmlBK1F3Zk9OVzdHSmV0N3BuaDQ0Z01j?=
 =?utf-8?B?bGlmVnRiY0xUYjVwSTFOeWsxaE1Rd0RhVEkxQjZ6YXVXZFUrNThvckxhY1pG?=
 =?utf-8?B?Z0cyVWs4clIraXNMamV1Y1VSSUFsN0VjdlNNQ3VuaCtYdVR2ci9BVzd1QndR?=
 =?utf-8?B?Tmp5Y3N4Z1FEVGFUVmlDTENHMmUzb1pnSjMySEU4ejZ6OE1sa2R1SVRTVy9m?=
 =?utf-8?B?YlV6Wjg5MEl6M0czYS8rSjhkbEp3R1dZTGsrWlFvQ0JoQWM2SkFrQk5kZWJY?=
 =?utf-8?B?L05ZSnhLQVFKWXRMelJJQ1ZZRVBPVXJnbnNQMng3c1RuRURyYlg3UFZUNGoy?=
 =?utf-8?B?LzQwTFRpU2NFWnliZ2xlTnRVQkwvSlpaZUJkSnlXZG5VSFJHeFEyZWR1UGJK?=
 =?utf-8?B?SkdPSzhtOFlidDg2dGVsMXE5VzY3TG85ZW5QVE9UYmk5RDdMY2ZwMEo1enRP?=
 =?utf-8?B?aVBaRngwV2FhMEtpV2pPaFJpdHVZUXFKN1ZTMmtZTTlySTR5N1ltM2Y2bFRJ?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AI1n9/nmVkpERA157p5EDZtJHqpDLCVTfpVO6dxVnj+vDucZyJAJuDpol/jOVETZygZBWE6mq49UkJuF9jwVqscMNolBl7EpPRfqkRbAcQOzbDv4q9/wEP6vPMZYhKkbeTM32sV+3IKD6ECTy5Q+0EH+N2GolmDUwj7DgpOP78/DRYVHoXftFKK4KEA+eE8UiM+Q+RAvPBe1ZyKKj4dr1ZK4jm5LU3Sfo+oFN+ARhdFQFrK0RaEXROQlP4q0RnGZjEhDCqlFY2XUf3OfsxiUZX/A8It6seBvEFJU5Th8INcYVo+l8R3NxYv40M3NGyexCQGLYavIgxhspmE0Iua9ap1+7hywlUB5poewEU5ul2jkvkQ5i01zQf13BnaBRWu65H3zpwrtooiFsiAS1XWMlegIRXhBKq+3RI7FwKOilj4uCHrX6+yOTxXvoI8IBum6BJoQF+EjK0eb3uZzqIOdU5xcmI2khscMQq1XWub7BRhhPYfhK7JaSxRRlyhgZDHEcYGHoSY9NZSyAd8KDCUTwfUQ2Zeu05zD/+fOzQehLFWMe0gaHPt//QKse5ZNC9OnUJ1q4rXUD0STJ3fVPOD0gYi/EN/CKs+Ju3nvY1QR1/M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce179877-f1e2-4a90-db44-08dd46bcaaf7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:43:49.4476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khH0dJjaLwpu/COEaowEBs/TGEPzdnLQ9Gx8fXMKPPTdKP2r223DfL4kSSqzn2tj46EG/tQVFVpzhkKmYx+A1/HMneY4cetQc0ZlST+mVw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060121
X-Proofpoint-GUID: 0tij3QHcXkrGwkTFleJNGQ4i-CEJHhFg
X-Proofpoint-ORIG-GUID: 0tij3QHcXkrGwkTFleJNGQ4i-CEJHhFg
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 2/5/2025 12:13 PM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Preserve vfio INTx state across cpr-transfer.  Preserve VFIOINTx fields as
>> follows:
>>    pin : Recover this from the vfio config in kernel space
>>    interrupt : Preserve its eventfd descriptor across exec.
>>    unmask : Ditto
>>    route.irq : This could perhaps be recovered in vfio_pci_post_load by
>>      calling pci_device_route_intx_to_irq(pin), whose implementation reads
>>      config space for a bridge device such as ich9.  However, there is no
>>      guarantee that the bridge vmstate is read before vfio vmstate.  Rather
>>      than fiddling with MigrationPriority for vmstate handlers, explicitly
>>      save route.irq in vfio vmstate.
>>    pending : save in vfio vmstate.
>>    mmap_timeout, mmap_timer : Re-initialize
>>    bool kvm_accel : Re-initialize
>>
>> In vfio_realize, defer calling vfio_intx_enable until the vmstate
>> is available, in vfio_pci_post_load.  Modify vfio_intx_enable and
>> vfio_intx_kvm_enable to skip vfio initialization, but still perform
>> kvm initialization.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/pci.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 47 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index df6e298..c50dbef 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -184,12 +184,17 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>>           return true;
>>       }
>> +    if (vdev->vbasedev.reused) {
> 
> 1 x vdev->vbasedev.reused
> 
>> +        goto skip_state;
>> +    }
>> +
>>       /* Get to a known interrupt state */
>>       qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
>>       vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>>       vdev->intx.pending = false;
>>       pci_irq_deassert(&vdev->pdev);
>> +skip_state:
> 
> 
> hmm, this skip_state label and  ...
> 
>>       /* Get an eventfd for resample/unmask */
>>       if (vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0)) {
>>           error_setg(errp, "vfio_notifier_init intx-unmask failed");
>> @@ -204,6 +209,10 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>>           goto fail_irqfd;
>>       }
>> +    if (vdev->vbasedev.reused) {
> 
> 2 x vdev->vbasedev.reused
> 
>> +        goto skip_irq;
>> +    }
>> +
>>       if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>>                                   VFIO_IRQ_SET_ACTION_UNMASK,
>>                                   event_notifier_get_fd(&vdev->intx.unmask),
>> @@ -214,6 +223,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>>       /* Let'em rip */
>>       vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>> +skip_irq:
> 
> ... this skip_irq label are one "very quick" way to get things done :)

I chose to use goto's and skip labels for your benefit as a reviewer, to reduce
diffs, so you can see that the non-cpr code is not changed.  Not as a quick way to
get this done.  But if you prefer, I can use conditional blocks instead of goto's,
and let indentation create additional diffs:

         if (reused)
             goto skip;
         non-cpr code;
     skip:

vs

         if (!reused) {
             non-cpr code;
         }

>>       vdev->intx.kvm_accel = true;
>>       trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
>> @@ -329,7 +339,13 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>           return true;
>>       }
>> -    vfio_disable_interrupts(vdev);
>> +    /*
>> +     * Do not alter interrupt state during vfio_realize and cpr load.  The
>> +     * reused flag is cleared thereafter.
>> +     */
>> +    if (!vdev->vbasedev.reused) {
> 
> 3 x vdev->vbasedev.reused
> 
>> +        vfio_disable_interrupts(vdev);
>> +    }
>>       vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
>>       pci_config_set_interrupt_pin(vdev->pdev.config, pin);
>> @@ -351,7 +367,8 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
>>       qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
>> -    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>> +    if (!vdev->vbasedev.reused &&
> 
> 4 x vdev->vbasedev.reused
> 
>> +        !vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
>>           vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
> 
>> @@ -3256,7 +3273,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>                                                vfio_intx_routing_notifier);
>>           vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
>>           kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
>> -        if (!vfio_intx_enable(vdev, errp)) {
>> +        /* Wait until cpr load reads intx routing data to enable */
>> +        if (!vdev->vbasedev.reused && !vfio_intx_enable(vdev, errp)) {
> 
> 5 x vdev->vbasedev.reused
> 
> This patch already adds a test on vdev->vbasedev.reused at the top of
> vfio_intx_enable(). This one seems redudant.

This test is necessary.  I will expand the comment to be more explicit:

          /*
           * During CPR, do not call vfio_intx_enable at this time.  Instead,
           * call it from vfio_pci_post_load after the intx routing data has
           * been loaded from vmstate.
           */
          if (!vdev->vbasedev.reused && !vfio_intx_enable(vdev, errp)) {

> Please duplicate the whole vfio_intx_enable() routine and move it
> under a cpr file.

Do you just mean vfio_intx_enable?  Or also vfio_intx_enable_kvm?  The
occurrences of vdev->vbasedev.reused that you flag occur in both.

I coded with reused conditionals and "skip" labels for a good reason.  By
keeping the common logic inline with the cpr conditionals, I minimize the
chance that changes in the common logic will break cpr.  Conversely,
outlining cpr specific versions of these functions and duplicating common
code creates the very real possibility that changes in vfio core code will
not be made in the cpr copies, and break cpr.

>>               goto out_deregister;
>>           }
>>       }
>> @@ -3578,12 +3596,36 @@ static int vfio_pci_post_load(void *opaque, int version_id)
>>           vfio_claim_vectors(vdev, nr_vectors, false);>       } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>> -        g_assert_not_reached();      /* completed in a subsequent patch */
>> +        Error *err = NULL;
>> +        if (!vfio_intx_enable(vdev, &err)) {
>> +            error_report_err(err);
>> +            return -1;> +        }
>>       }
>>       return 0;
>>   }
>> +static const VMStateDescription vfio_intx_vmstate = {
>> +    .name = "vfio-intx",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_BOOL(pending, VFIOINTx),
>> +        VMSTATE_UINT32(route.mode, VFIOINTx),
>> +        VMSTATE_INT32(route.irq, VFIOINTx),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +#define VMSTATE_VFIO_INTX(_field, _state) {                         \
>> +    .name       = (stringify(_field)),                              \
>> +    .size       = sizeof(VFIOINTx),                                 \
>> +    .vmsd       = &vfio_intx_vmstate,                               \
>> +    .flags      = VMS_STRUCT,                                       \
>> +    .offset     = vmstate_offset_value(_state, _field, VFIOINTx),   \
>> +}
>> +
> 
> move these to cpr file please.

OK.

- Steve

>>   static const VMStateDescription vfio_pci_vmstate = {
>>       .name = "vfio-pci",
>>       .version_id = 0,
>> @@ -3594,6 +3636,7 @@ static const VMStateDescription vfio_pci_vmstate = {
>>       .fields = (VMStateField[]) {
>>           VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>>           VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>> +        VMSTATE_VFIO_INTX(intx, VFIOPCIDevice),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
> 



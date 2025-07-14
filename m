Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286CFC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQHD-0003tc-F4; Mon, 14 Jul 2025 16:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubOk5-0008BG-4p
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:21:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubOk0-00080N-Jn
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:21:36 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGv9Fw019054;
 Mon, 14 Jul 2025 19:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=nkEYmy29HbbcdJvBrli/siGKTkl3dqldhjzHgZ+pEJI=; b=
 jYMTUmLyaUpVfxjVpjmnaBPoxTiJdhqoX1bXAwSiga78PUdAmkp7A7G00xAAeVWR
 VklHyM92QvzfGNpe6HBegMhWTtT21sUQXdEORJoSIjkNkEBMDTn8+PTW4Juc0cV4
 Qriuteftaz0sTtlpmED2qkhsvglc2aCPQoiWV38/B+UAnMlZV4Dvx+bXSFO6VN5m
 U74ldjaKM+Zpolwh5YX8nVTRJMiYPqB63TF2WH93CcmxuzTXoiWdLldtoKek6qQJ
 ELRfPGZPrhq498MFmTOe8vs3JgqxCheFtIFJiJP+NebN2v9xhNnIWjpE8qHd8k4U
 9j5aJYijSUYactmIwzhdqA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1aw0ja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 19:21:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56EHqZMK029758; Mon, 14 Jul 2025 19:21:27 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010008.outbound.protection.outlook.com
 [52.101.193.8])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58qtb1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 19:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JossVqiv8iiHuZGyBxw9iLfxPtey5Tr4zToxEHnXcuEXr7JQle3bwrE6xQa67N/ascRoal9+QIKD+d4GoUDFiJqhJgq9+aG61ZYWmJByMVhEyPyD13VDWOTUoumHgq2PDFYiHk8p0DrvKbnY6T7sWeCLwuc+7Ho7E5doDkKrNdVfRDT9KkhdvP962Ndjv3/ihSiHMqcKxaDr+Y+mcLaxcG/E+AQ8XqK8iNc04X4qewUKUNSzKF1+OTLpibkh/ODXXXgmy/y7hh7jelaYkXaH4KYoV1tSoub49ur1evT3cAEeVyH5/EmQTdooyPz8jX1IeUl1jaLgjV11atbEbTM+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkEYmy29HbbcdJvBrli/siGKTkl3dqldhjzHgZ+pEJI=;
 b=WFFDxsIvL2sTeeAVvK/4P9oai4kBnFOuyXlx6E523TkIBB/yggEXN2EWbaG6+KgmzwRp2M6ZvrQU9zsPmVTvHyfrjY2Ae4OnR7seKuH4wxEPokMJBEwPGiVt4gtEY6LQ2oY7LWymtrY/p5vLWhb4v4p+H4jj3QAgzVyH8XsoyrUFv4yj/J5d4idkKwzt3MZ+TKVF30h2SQOeyjG8p58bsH73xI5U0Uq6bh3w1DzoeG2hEd4xFTNw0VNJc7rZZuqsifkNYmYjmy4Ns10dT4Aakww7XUmQb53C8sTAkaAh/iMLI6unpca06QA6Prcy7Gc2y5WhOBzrx2rs70gmvo4SQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkEYmy29HbbcdJvBrli/siGKTkl3dqldhjzHgZ+pEJI=;
 b=XQP7eX09SjwJhGTVOhDMOPMvuhmWp4J+6h4FFrfPS6JFacIrjmVJrLb3lX8HvDM8GF/G0DnRECcxMucXJuF+1jMSOrvwNAZuaGSYJbmDO4s2iKzddO15MovQCZmeIq9qFJckAlhW2fIHuSnY1+Vs8dRHfZO5ZDzZQpLZlbCSZkY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB4975.namprd10.prod.outlook.com (2603:10b6:5:3b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 14 Jul
 2025 19:21:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Mon, 14 Jul 2025
 19:21:24 +0000
Message-ID: <81153780-336f-48d2-88e0-b3ad26217447@oracle.com>
Date: Mon, 14 Jul 2025 15:21:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 59/59] vfio: fix sub-page bar after cpr
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <1752520077-223287-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1752520077-223287-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ab1aa4-2671-4556-3a34-08ddc30b9f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmpLMkJiY0htMlh3a2RiWWNFa21OYlRzVGExa3BpdXBmSjR6aTd0aUYvWjAv?=
 =?utf-8?B?N2J4azRvbW9IRUcrRTYxbklLcDlsaDkrcFNLMVdwbjlFd0g2T1Zsa3ZUUU8w?=
 =?utf-8?B?ODdaOStwekk5Y0VtMlBLMEZQV09UWUxEcTFTMzNMV280a3Y5L2tXRFVPemFj?=
 =?utf-8?B?bEE4a1dMcFpONGZmeWRqRXF1SHhFVXlPckdhZHVtS3ZkZUJvKzlTOTdYaUE1?=
 =?utf-8?B?T0RJUFd4NXY1bjRsUm5tTUZPWENRSnpYWGxJM3ZFRERseWVXM0xQdWRDdzBi?=
 =?utf-8?B?VU16MThBRGNFbTdZK3dwKzh1ZTVlZ0NYa1M2dEVmYXNpMDdwM1l1ejkrQlpV?=
 =?utf-8?B?U2hGN0gxVms2ZjlZcmVTbE16RGFJMmNNczNDK3RDREhxSnR1ZndpTW9vMktY?=
 =?utf-8?B?MFFINm1ZSWpjVUF2ei9QMy9mZFBsY0xGR0RZdjNuYWJMb3VEUGpHV0xVeHJD?=
 =?utf-8?B?TDdXUXI2S3p4ZmxuNU9wNHpETUdYbkkvTGpyNGY4a3NjK0hFL01PSHhZMnV2?=
 =?utf-8?B?TzhTQzNvT09EeWV5cldMTEw2ME0vTzNQSzlWcDdnT1FiVVJkbi85UVNRVmgx?=
 =?utf-8?B?amQxU1BsYUFacE9xZlhaSFFuZUJSVHNsbXdmWlZITjFkckRtSE81Ym9nTWY0?=
 =?utf-8?B?WkF4TzAwRVljck85SnU5T004VWtFSCt2WHgyRGIyU0E2ajF1TjlWbkhwaVpW?=
 =?utf-8?B?a0FPc3FuR0l1cjFLRWhja2s2SVJHS0ZOYm9wVTBJRW55NFg3Q3N5NU1vQVhW?=
 =?utf-8?B?ZlN3TUYzTEszdnBaZVVHQk83T1lNMnlTd21wY1ZnWEgrZkxNVnJBYVhmdE1k?=
 =?utf-8?B?bUdxc1NSdGJ1NnhGMC9USHRqMS90Wi84dy9PVGJ6ejhCNXdkUzVOV0cwdUJl?=
 =?utf-8?B?ZFh1cUd2OFdjdjhXQ21CNTUrUjhaem1xcWMvdWFOUytQbmpQM0FJOEZreVB0?=
 =?utf-8?B?N1didGNRMjd0M1kxbG9zZ0l0dys0VUVpQitoOG0wVjRTZzFFTzRudDRnNHRT?=
 =?utf-8?B?dGZaTlRObWsrQ3ltQ3lubzBSZkFkNGFRM2JUS3BFT0JqSHFtYUtHb2s2QW9y?=
 =?utf-8?B?YUhlZ3VGVXI1WktpSG50eGw2SCt5TkhVeDRHbVRIWE1BWkZ0T2xxV20zQXRC?=
 =?utf-8?B?TGZsSDRiN0NveXc4M1BJalBhTVlhT0VVeEZJWmk3aTlMSGJ3dlJ2b1dzZi9w?=
 =?utf-8?B?OEFRVUp1MERaNGY5TjloRFErdHEvenNGR25VVDc4cVdIek4zckNUejFrQVBu?=
 =?utf-8?B?cnNyK002U3ROeGFTendBWjJtTnREL1k3T3FieSsrZkVEVHpDWnQ0S29DMDBx?=
 =?utf-8?B?T3JiMVI1Szkva0ROUEY5NVo0RjMxV2V4d2hLTHZFSUtidSs2VlpUNVFJV2Rl?=
 =?utf-8?B?c1BKTmpwUXFmUEx1RjV0dnVwSDVmZzk1Q0MvTHovSXV3elk4TEwxbXYyRXJ6?=
 =?utf-8?B?WkxZNjdxTjA4YWR1Qk5HRHRkaWRpb3czU2UvTFRUYWpucVpmQ0Qwc1VCQ3Iw?=
 =?utf-8?B?NU9veVBWRUtGVi80eVp6eHZ6RWlJaSthQWlxR1ZBZEZSM1N1WW9PR1ZmWDIy?=
 =?utf-8?B?UHZUZGZoY0loWTliTkd2Qi9BcU1PSnJJeDRvTXRHVlBMQjlUOWc4NnBRUGE2?=
 =?utf-8?B?MWppWUJPcEduTWdvZ2xEK3ZUcUtSampMYjZrNzNldDBVaXUxc1J4eFJFSFZR?=
 =?utf-8?B?TDl4bm56WUlZaVVxMHFVdDFHRFZUZUE5MnhBQkVKTlVodFB4VWpTMk9SdDNM?=
 =?utf-8?B?K3ZDZkQ2NGJjMFRDK214dVJpYnZkL2hSRDI1NFVDS3hzWkFVcXVpK2tOWUd2?=
 =?utf-8?B?ZllXYVpRK0t2VGVOZ0hxbEh5TGZZNlo3WmJ4NWU4QUFtSTlKZ3FXVi9lYTB3?=
 =?utf-8?B?MlBWa1lMWnpBb0hpYzFncFVXQVJ4UzIvYlR0Q0RDUXV3dURGbXJLSXhUOS9v?=
 =?utf-8?Q?md+k48HoI0Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi9uVEpqc0RLUDhKQ0crUUpwTGl3bFN0UWdNOUd4K2dnaXpJZXJCSkdTUGVD?=
 =?utf-8?B?eDNpTlZXNkhmdlZucC9adVduVnpnWDNzc3VOWGtBUlIvVGtBY216SjUxL2dB?=
 =?utf-8?B?REUzM0hlSjQzb2trcUxJcTNjLzVHOVVzL3lxclcyVGI4bHpFc2JKaXJyMmdU?=
 =?utf-8?B?OTlVaHFER0I2dDdUM3JDRlFram4xdXl6MUpOTWlmQlZTalNsQjBZSHdJRnJq?=
 =?utf-8?B?V3pxNm1SZXFWaytoY2N1amw0MnJlekxlMjhySnlWR012Z3NuTnFQeHNnS0pj?=
 =?utf-8?B?ejVyK016dG1PS0FHRk1IVHd2dFhiWXlIZ3BvUFdlZDhPeVhKSWN2MENxMlR4?=
 =?utf-8?B?QWdXMG1JN0M3VWFNZjZXQitDcmNwYTdrYS9TTXJpcDU2MDhBMDBqYkRFcE9S?=
 =?utf-8?B?d3Q3QlVjVmI0QVhIc2hQaGR0U2lqbi9EdVVTUmtpRjZEY1BEY0doc2h6SGtP?=
 =?utf-8?B?blRwZElvdmNFNmdFcFJ2cVdSaEVzU0dycCtUd0QzbVpFek5FTFVTdzBNVkJw?=
 =?utf-8?B?dlhCWW5NcUZDVGJITU5zT2pEY0p3aGtPL2RLM01LWnN6cHZlUzdHVVp6Q3Fl?=
 =?utf-8?B?TmlpcTA1WDRQZGwyVFRyTXUyMkJiaFpISnVFU2hZNVFoV1JTbC9VU2xGaG9k?=
 =?utf-8?B?ZHdiRitOV0ZrZk84MlUrVFYvV2ltYkphRlA3VjZUaWEyUnZMWmhlU1JzMmtY?=
 =?utf-8?B?OXlOMzM5cG5UaXdIVXJMRDFEeDB4UklVYmwyR2lncjRvRDI0M0pjdkMxQ3ow?=
 =?utf-8?B?K1JVV2hjRXlmSEtIOGs0MnV5YmhadVBpY1ptT01DNmJNRFgvWC9DejcwVGFz?=
 =?utf-8?B?b2hpbkhHVTZMYXBYcnlqNVp5UVBJYUx2cVM4SHYzbHVmZ1NsRCtJZDd0OHVI?=
 =?utf-8?B?K2FRODl4WnFsZWV5VllaWXBwV0hXcUtWNEdxeUh1dFFnRm5vaXAzQ09vaUVZ?=
 =?utf-8?B?MVRPT0JJWk5qM0Y2UjVTRUdtVis4RXhCZzBybU9hTVpVMnhkdllieE5sbkkv?=
 =?utf-8?B?Q0FVb3hMWEVhd3k1a25DRUc2WXg0cGErbWtuL1ordUMxa041R0JJNnZpQVFX?=
 =?utf-8?B?UUZCbGVSYU0rQzhkaXpFazU1b0Z3YmlVWU9xTysxZ0tCRGh2VzREV09MRllF?=
 =?utf-8?B?V3h2ZlBXc0NLQm1vd2N4T1BNUGltOXUwT3dRTHRWM3VJYWlodVFMZ3I1UjlV?=
 =?utf-8?B?TVE2akJPemdDZFFuNmxyNHB0TEZwUWxTZ1I2RGliV3htazBNV0FzQlR6Y1ZD?=
 =?utf-8?B?T3JuZ0lPdmlxVkh6Wjk3NiswYlZCbUsrRC95WlRXTExrVm5MT0cvVHhhbTFx?=
 =?utf-8?B?cWZNQ1l1SVN2N3VKYUdvVnQwQWxWaVl6OFYzQm45dDRqL0NmT2hza09ndFFY?=
 =?utf-8?B?bW40NHRVNVhSZzNkbkhTRWRTNy8zS1RBVlBrSE8xQzNWTmV1K1hta1A4bTRq?=
 =?utf-8?B?cGhYdmdEY0gyUjRNUlJjVURXeUY2VjlaNmxvSk5YTEJBd2lTZTYxUVFHMmxI?=
 =?utf-8?B?QkluTHBVQU1WQmVqdS95dll4ZnF0NnRqbWx1WWoxeXhRZCtub20vdURGczZh?=
 =?utf-8?B?eWJXYURPSGY3V2ZpTWk4N1RBZWVOV1N4RnBsNkx4Um5qc2Rhcjh6R25iTDMr?=
 =?utf-8?B?dHlqS1VUQlBsdGdjTStoK3FnUk5SWGZUZ1NZUmNVMkpBUXFqanVkb3Q4eEV5?=
 =?utf-8?B?N3gwQWJ2Smx6ODlBdElRMVhub3FrR1VDM3phM0JPYlo1Q0dHazJTQzlReTFq?=
 =?utf-8?B?R2ZkV3VNdnVvZTdaMk1GditTZnlVUWdLV1k5NnlBMDhHUWJPYSsrYXNsWlR3?=
 =?utf-8?B?eU5RUWI5TkRiTi81OXRPaFUwUXlMM3RFa1V2L3AyVHdxREJyOHlsYVgzM3pv?=
 =?utf-8?B?RjZSNXBTTUphNk05UTlNdEF2dXFtVE1TN0VFSGF1R3Y0SzFvUk55WERkYSts?=
 =?utf-8?B?WnlYNGlpWitqWUJkRnJLUHhtRE5wZXlZeVkwTkg1NWx1NEViM0xvQ1FaSHl2?=
 =?utf-8?B?bGZPYkhKTSs5d2M5OXRYS0E1SGZWWUo1N09wZEZVZi82YjYvMGNrTHBOL0Z2?=
 =?utf-8?B?cyswVDhzVGhnM2xVRDlUMjM4SDMvcUJmNU82TWY1MFZBeFlDOHNvMUhSU0k5?=
 =?utf-8?B?Qm9xZXJsdksyUXlDd2xrVENtNk80L0dza2x0M2N3ZGFUZ25XNDVNaTh5amp5?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N/c3S/p2XlYNjSRJ8W2qCd//nWjT2JAGiAi36SwbjrCeN1pv0xi9dtftmhQpRphN29vx772YGvohDYZ06CdNvLbxddwkoPCbza0UP5uxg1BXOlGHGFUd2PxGZua3HX9RMV8ubP0IxSq8dvvePCIZjCtOqLJOUzfDtG3KJi/81PTvz4J5DjBRhSEkmib3OGL13WtkoLx+jGXylHoEhmi3G2cFa4NcXFxDW2abZJibFFe8OcS8tvPBwprCBvSlfPOkS8vVo95mPr5ta1nI0ssMMTzjnTvpdscX1LdSFis1aZ90YSr14Fi0+Ezlckq3/9Aqy3GaiYnpDQhn09WGXG9/OIyCavyxWURh6IFLm5zhX1IA2HCv+6WSqyv7TtA+cpsdS/ZBV30RnT5aJUiE9mLSEqqq21dAHK5tp1j3PXZ8Al6PpIRlyrGih6sEhyP6v3DyBXZC6rLTDeGkNGMEGAyP5dfxVFAOFZsj3q9JEcnM1KxmUV9WWXBoevQcamI+qcG1+ERDfawdhaXqbZ3ugqdKXKyDZ5HXNx8Jd6viCcfMOSbLYvXExUVq07uWb4S6J4CSKuWK96/bwQC/g7GR2t2iS8frOg5UW9tfmzEzsdYlKFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ab1aa4-2671-4556-3a34-08ddc30b9f52
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 19:21:24.3702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ivp7Mjb1Xgz98Fy7kJRgOGaXI8gU3sy5cuAyUDYZzvQ/8XwsU4AIwkSF0UjdtHQUDwEeZIQ5ePDA3NC4fYjYwm2Ti+XbfEV7/BUQ8ery9UQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEyNiBTYWx0ZWRfX/dgw7Zov3p6o
 0SYClZU6MjDpwuY8gUaaPR4Rgsx7Psq2d1B1btPejHYPNWSHS4XYD/SLqXYe9+uD94lTOt7PH0I
 FCg8XVqdWJaq1MrYG4BsmAydda8fXxWjyMHAWYsLsbh4zn7JqQumS57lHa4bttxSptUqFisAvcc
 GG26lAhi0A4o0nbiR+iqJdgxRVPwarZ7+L+Vu8Oo9kgn+6vah9H8VG8Ny3R6U5yjk3JZ6KCW8e8
 zEQQGoz+J23wbyvcNWKr0RiIEe42cdBdqhkFcF6K1DuJjK6S64sWdp1YWpOEV+V5cg6UUaCrmNM
 RM7tcTxOxrjVBR4Ww0pb16UQgsBOIz/pwOEI2XNMvhP3fiUrKwMV+hiKbk8lBA/g2sbUWNys9qH
 eXWn2UYHiNaSGcXu16+BlQLeWaGntdroZ/JwhmyboQNxrKvfifcFoFsQb/t8RBqQl8eS6JZk
X-Proofpoint-GUID: kYF3am5D2Az7XxJuhVZBQWFNblMYgzsc
X-Proofpoint-ORIG-GUID: kYF3am5D2Az7XxJuhVZBQWFNblMYgzsc
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=687558b8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WEvzv-lb--2Uu1L9jKYA:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I will resend this to fix the subject line - steve

On 7/14/2025 3:07 PM, Steve Sistare wrote:
> Regions for sub-page BARs are normally mapped here, in response to the
> guest writing to PCI config space:
> 
>    vfio_pci_write_config()
>      pci_default_write_config()
>        pci_update_mappings()
>          memory_region_add_subregion()
>      vfio_sub_page_bar_update_mapping()
>        ... vfio_dma_map()
> 
> However, after CPR, the guest does not reconfigure the device and the
> code path above is not taken.  To fix, in vfio_cpr_pci_post_load, call
> vfio_sub_page_bar_update_mapping for each sub-page BAR with a valid
> address.
> 
> Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/pci.h |  1 +
>   hw/vfio/cpr.c |  2 ++
>   hw/vfio/pci.c | 14 ++++++++++++++
>   3 files changed, 17 insertions(+)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 495fae7..cb1310d 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -228,6 +228,7 @@ void vfio_pci_write_config(PCIDevice *pdev,
>   uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
>   void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
>   
> +void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
>   bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
>   bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
>   void vfio_vga_quirk_setup(VFIOPCIDevice *vdev);
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index af0f12a..384b56c 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -116,6 +116,8 @@ static int vfio_cpr_pci_post_load(void *opaque, int version_id)
>       PCIDevice *pdev = &vdev->pdev;
>       int nr_vectors;
>   
> +    vfio_sub_page_bar_update_mappings(vdev);
> +
>       if (msix_enabled(pdev)) {
>           vfio_pci_msix_set_notifiers(vdev);
>           nr_vectors = vdev->msix->entries;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 1093b28..9c616bd 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2826,6 +2826,20 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>       return ret;
>   }
>   
> +void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
> +{
> +    PCIDevice *pdev = &vdev->pdev;
> +    int page_size = qemu_real_host_page_size();
> +    int bar;
> +
> +    for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
> +        PCIIORegion *r = &pdev->io_regions[bar];
> +        if (r->addr != PCI_BAR_UNMAPPED && r->size > 0 && r->size < page_size) {
> +            vfio_sub_page_bar_update_mapping(pdev, bar);
> +        }
> +    }
> +}
> +
>   static VFIODeviceOps vfio_pci_ops = {
>       .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
>       .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18ACC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2ns-0008D3-Uk; Mon, 19 May 2025 11:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2np-00082s-MP
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:53:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2nm-0000Xs-Uy
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:53:21 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JETSNT014741;
 Mon, 19 May 2025 15:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=TQW1cx0WP0KTH0O8+AJ9YEIZr7/tGsJ+k8NW8ZCNeIo=; b=
 QQ+Tq4510BtuU35WRnnqOHfbb0vxd2cUVyQlDPMDbB7ODtI2BVDg6AankqDjrKVF
 v7HSFV+ZTIJSIo7sf4W5DNk6wIFYmPmk4miePBkekv6L6DLRYG5NRAZnhCQCKeMe
 WNhiILUk2jBvTD0rjxXOxqe27K1naab3ZxitYkBzaIx600UmMy3zqlGI25ie5XHR
 S71AfTgYONCqTZU3O4cTQnrnN0UsyZrEdLprcrFI433YgXNUK+KyPvqvzxWaecEi
 FJAtaQpDrftHne2EGTQF8brouyhEyoPj/Fhluv8bZairUsQYOJcbcB2Fr1Z8kFrv
 IA36BV80DbJPsd4vYwMu0A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjge3d59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:53:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JFIPvg028841; Mon, 19 May 2025 15:53:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6uw9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:53:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9r7sGsgMQcaSoWs1vQ3W5XuWtmxKUADocOkL7DAacUdaBQXz0qy2o8SmxVyDie8Hm3vIfaSpDYkS/TQGUi6LKQg5qWaEixLX9719afA+OK6xYlK8fdfVw2pkx+kjUzGxsiSsuVIgyZF+xoJMW8aFakC2kiNe8u/hwH6CXma0MBXD+HwKyoaUrjclkKqdkRAnvmF9U6taN/xh3CukiHo8JtogNamoYYz47ogcswYexUPu/0Zw4w/RFvm+jCRbBh+DN3dHGyydrTjwQ8I44Pk7Fm0A75BlW1wa7dbiQsmGY8WiIImAjJU6FSY4e8HEMAqT5UW8kLBW4xTh/w9F5EQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQW1cx0WP0KTH0O8+AJ9YEIZr7/tGsJ+k8NW8ZCNeIo=;
 b=NteldxRa9DpSb8o2aGZMO8gA6+MUTcIapV24sdrq0rQ8ovt0wKAQr+Phe6u1Wh/tadjsVcP/PUJwlDX2lNJkxCo1UwkX/lz3R/Ix/ts2R80DOPvyN+WY9aDysZmibvEZt80tHb5yYnCfyv4lctm3iEWZjHtpVMRKPJ3GTSVitNr0NQMT8bJ3RNK7oFcg4qANQlUOwzt68MrXwssBVzDVk8M7sDZ1KbRBf8vVPuV8Cq/wwl52gr4EV2oph7azR99iwdhyQVLqKa+4Wkv4COsIQyOcTETFcLJKRt2bMJnKeOXoC/dZqTCoCq3eJZtRawQDj37FIayWP4wwAAEsotRQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQW1cx0WP0KTH0O8+AJ9YEIZr7/tGsJ+k8NW8ZCNeIo=;
 b=gwUHOq9TVI2zFi9Xa3zASCLfEQFQ0NZw3Q0Ql540g7l+izZtnLojbuO/kys2ttkyGHXtFp80sgjdo0nsVviKm4dRqZBJ3o6ZsfAzjBnNwhZg6ic4BDaagjCtlki6QpMEbMpPbQ+0SZw9cxPjOnzNecfY1F/7B0sHb4Pt9ZmM/vQ=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 15:53:07 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:53:07 +0000
Message-ID: <fee4df02-876e-420b-8afa-ca8745c81c1f@oracle.com>
Date: Mon, 19 May 2025 11:53:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 36/42] vfio/iommufd: preserve descriptors
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-37-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB67441B4BA69BF42F30261EB19293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB67441B4BA69BF42F30261EB19293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:23a::20) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: f139c704-4e03-4abb-c695-08dd96ed3f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eC9Pb0hDTjZDK1liZXZyOUVxNkNvdW9wRjRxNVBUM0s2VVN6VFFzbVJ3Wmp2?=
 =?utf-8?B?SVlnNksrYjd1a3dFNlZOS3lacVloeVJOZ3BNY1dwL2E2OC9QNkdLT2h1Y0RN?=
 =?utf-8?B?ODA4UkVaaVBJRzhEWURSeWM4UXNqRHcxYkhXS0UrZGdGS0dQd1A4V2p0Zytl?=
 =?utf-8?B?Z2RMdmR2dGtHeEtySFBOUXRMbm8rd3Z3Q3U3SGE5cVpWY2ptMm5jLzRuYm5m?=
 =?utf-8?B?ZmFxdDVqUDNVWmFYQzlPSDJHOVZaR1Q1aUxxOExTd3p4dGpJVzBZN1JXcVox?=
 =?utf-8?B?Z3NrYjc1eHlHWTVMWXhRVHgvQjNHWFl4L2xmeCtLSGpxVWppaDEyT3RpTUw3?=
 =?utf-8?B?VTc2cXJIa0hVY2l2aGJaZy9rT0NDTWdLajRQa3BrejFtcDdJRTlTekhjNWNL?=
 =?utf-8?B?RVhPRDF5R0pxTHR0blA3NWJ3cTFvVldlZFY4U0NRZlpWRFo2c1k4Nm5JclB1?=
 =?utf-8?B?V0hBNTc4ZDhRUG5aT0ozQStBSnQrei8vRjV6cEZxWG1pdDQrNGZPRUpYa0Za?=
 =?utf-8?B?WjhkWDBWM1RBc0dESFg3cFhRcTR4UldpTkQ2ZThRTUYrZVZLNktMcllJQWxn?=
 =?utf-8?B?MEVRRFY5MWd6K2xmc0x3V0JYQkQvNjFOZkZUSThRenFwankzaE50OXV0REN2?=
 =?utf-8?B?WEFhQlUvUDd4K2h6Z0ZBaDg5YXdTUXhId3NjbnEyYXg4Wjd3VWVROWowWTJi?=
 =?utf-8?B?bmVBeHBSUWxuWTRzZ1BhY05YQkk1ZUJwbXhsZ0pWbnZxcHZ3YVg2N0RUbC8x?=
 =?utf-8?B?Rm96aDBXVmpEY0YzVkkvZU9WTXRBN0UvMTFQR2E4WmIzNVFrMUpqVzZlVzE0?=
 =?utf-8?B?YlN3elV0NUwyby9vSlVLMWJJZVgyelhWUjJLNFpVQ1hDZUJ4d2dTeURGanN5?=
 =?utf-8?B?c0gzemtkeWNVOWpveUErVlI3dXlKRU96RVVKZENPLytseUVoNzFJQnZVUGpJ?=
 =?utf-8?B?MnB4WVpZT0RkRzFURFhvRVZyaFJHTnBQZmZydEVTMWFORExWQVR4RUdzWEtJ?=
 =?utf-8?B?cnkwUkhjTS90ME9oWm43ZWFQbE5wK08zWXFjZXR0b003RXlPYm13SG5SdHR1?=
 =?utf-8?B?WUlGVXFlTWU5K3pWMUZoVUtwWGNlVnczaU1BY0oyM2RnTDI0Vm9wN1ZVdmpt?=
 =?utf-8?B?a1dFUzF0bERmMVV4MGZNQUxqNkxGc0VEM0FlVVBvdDVSaDRMODZMTHNHWmgw?=
 =?utf-8?B?THpac1pUZ3M3Z0pISGw4VWFQTzYyMGFmRVZKVHFFbksxZUliSXhSWC9oK080?=
 =?utf-8?B?UkxPMDV4bjllV3c1NDU0OFZGRG01bGttUFJtbFgwYnhSS0dkaExjTUFza2x5?=
 =?utf-8?B?SU9yVzVpSW15clNWODRnaVlyb2svS3hiT2xldjd2Q2JoLytGNFBBYzhkWEpk?=
 =?utf-8?B?L081Y29pVGNuNmt1UlcvQU1LT2xpUFN0WkxGMHhEYytuZFRFZGRlY0poMlZr?=
 =?utf-8?B?ZjdaYUJxeE93M3ExUWF4d1k5ZXY0ZzRyL2dJbmFVTXBtZEVxcGdQNVNaUE9D?=
 =?utf-8?B?emxjRURiR25GMERNR1loRktmalJLdFJnTTU4K2w0dWZVWjlxMzlZaTYrakx4?=
 =?utf-8?B?bjJTT0xOYmF6WHZVRDEramhtUitVcnVJR29HRi8rUkVFVUx1SGkxM29sSHFn?=
 =?utf-8?B?L2xPcmR6cmpyRHNET2RlNHZvYlYyNXQwcmJwRkVuTExyMFYrYkxPSjlYMDlX?=
 =?utf-8?B?TVhYL1lZM0tRbkM1QmkraUMxN3pERlpVVkZmNDhmd2ZzV28xNzVuZmNOaC9Z?=
 =?utf-8?B?NTMra1lPVnBWZWh5OCsyeXlUa1VjUHdkTWtJN01BbWswTXVlcGhoaHE0NXJn?=
 =?utf-8?B?VStmTlB3Nk54QzBOaktHL3U0N21QZ1VUNkVOSVI5RkRpcW5kTVc5RDZTSlNq?=
 =?utf-8?B?VDJyZjgvUUVLano5VEdxdTd3R2RVMS84Wkh6Zmt5cDFzUXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXR0aysvNjVRUGViTDVabk56dE5WUG9PKzNyTG1WTDdpdUFCY1JueVF4RUJN?=
 =?utf-8?B?ZWFBeXNRL2RDcUxQTEVHMmVPMUNhWitIN1I5L0U0U0hsVElGVEE5TE9UaUlW?=
 =?utf-8?B?SjI3dXJ4cDFhMG9sbkpraENVdGFrYnVDd09sU3Z5eTJxRFgyWEtxWG5XaWVt?=
 =?utf-8?B?MTk1OGZSZ1RmMkdlbjlsUSs5emZCamRkSTVodTNRRksrdDBZNWwrdFZYOU51?=
 =?utf-8?B?ZC9hYkVNajFiZjdpMkY2SGRnMEJ6ZGcrN21kcFZSc3p3N3AySEVld2RUeG5x?=
 =?utf-8?B?ckthTmt1akhyQmNYSEdaQ2FHUTc5eVJyeG8vYVYwR3p2cm9oZDZQTmNZWW9s?=
 =?utf-8?B?ZWdWOHMrSzhTOERnaGloeGM3S2JtNG4waWFsUW1ZVk04OHFrc1JMRHh5UlRW?=
 =?utf-8?B?TVNMNTdKQTB4cGVVRU9GbngrNEp1TUUzWnFOZWpDZE9Wa0dvZWZoSFVmclls?=
 =?utf-8?B?amo4RG9UYlJrYlcxQjRNdXBzdFVJTlZvU0R6c1JnZXJYcytVcFk2OHVXcFFn?=
 =?utf-8?B?VkpLK1F6cFNwRnhBSTAzelNLUENSWGFZNzBWb291cS84Y1JBbW95YXhyZjZQ?=
 =?utf-8?B?aHlnN0pIVG1NcjMrSEU1Wk03K1pkN29FK204bHpBbXp4V3RNdnpXYTNJT0RS?=
 =?utf-8?B?ZmR4WXExaXkxdVVOeno1RXh0NkdORW40S01wTEpQVHRaQSszeVo3ZmErcWVQ?=
 =?utf-8?B?U244Q0ltbnMzeXJIdnBnaTBVNGVteVd0YU1KdFlSZXUzLzhwM2FkMDRhN0Nm?=
 =?utf-8?B?dmV6LzV0cmcwaC9TMU5jNU5VWGVkS2l3NzdWZXhRV0xPOHpYMkYwS0V1aWNt?=
 =?utf-8?B?YWR6N2s4MHBTRzlqNnZNRmhoaTJFc1IwWDljZXFPSXh0bytpVloyc3NPR2lr?=
 =?utf-8?B?NTZ6emRURjdXWFdLZzhyNHNla01ITEo2U3hkS2haeisrbno4aEVvbWVDU1hn?=
 =?utf-8?B?bytneUZQMkxuNnk5RFlaaHgzYWhycnZ6dDBkVVhoNWl5Ny9JUGM4dUdkaWNT?=
 =?utf-8?B?OFcxRWVnNis5Q3JPYmdLTGRiWEpmNEpSZURMdk1HNDRnMTJVU0l4OFZKc2Zo?=
 =?utf-8?B?WVlHeHpwREJ1a0VWakpLU2RnYVQ0MTNTMmRqV0RHeVNsU3JTbjAwaUdTTHUy?=
 =?utf-8?B?Y1ZUaUNkWkNrZE1iQXVNQ1ZBWnZmM2Zmck95Q0JoTjJsV01Ra0wwVjQrRzNq?=
 =?utf-8?B?NmlOM3VHM0ZGbDZFSGYxcGFmN0UvZ09oQkhnS3RvNE9PdFpqOVZFclNsb1ZM?=
 =?utf-8?B?M1pMeldqL2J3OTlyRjBDWGZCa1RHMHFKRktEOTV4ODFKMzl5T1pHZ0pwWW81?=
 =?utf-8?B?LzBhbEhGc2x0YXdhVXA2UnR5QmkrZzJuUGplT1dLZzZLSXVSS3RxQjA4KzNK?=
 =?utf-8?B?Mjh1Z1UzaXRNa1pTYWRGVzdZWUMwRnBZcjhIZlZrblBqTHh3UWFxVklJdjhr?=
 =?utf-8?B?VnZIQVhyNWcrZU5Fc1g3YzF1aS9pMXZ4M0RJU3FweThnd29uazZqRzBqdHY4?=
 =?utf-8?B?TUV1aXhRWmc5TXBDUHNkdzBwdlBGSnVsYTFDMnFvOWY2ZmY3Q2hCbjRoVG9l?=
 =?utf-8?B?NXVJd2RybUlVVlJxV3laL05FSkNFZmg5eTd6SmljWVJzTTlNWnZ4VW9TSndu?=
 =?utf-8?B?WnRjN2g1UzNIZWNkVDNCd2lnekpmQkdaK05QVyt2SmNUL3AxL3J0dWxveFFE?=
 =?utf-8?B?MDhiRjNZdFRXUDRRZVZtZUFlTTVxNHRXeVU2djErUGsxTHg1R2tBOVVqYzdG?=
 =?utf-8?B?eHQ0bC9idzJRS0hxY1VxZm5JN0FsNndoYXBFcGF6NHNaZ3pxSmVnemZRMVZL?=
 =?utf-8?B?eUtGd29nWXJ4bjJ0K0tEd1kxWG9EcHJ2WUJLQWFraXRHc1czZlRUZkU0NHRz?=
 =?utf-8?B?eG5MR2c5bVBnVnEwNXJnY1BqcXJzVmljRE9jNXppMVJOSEQySFA2Z3BHRk5E?=
 =?utf-8?B?d2pMOGx6ZVdGMFRLYVkrVlMvdVpQakVERHpOWjJ2R3JSck1iVVJ5Mjl4UFlP?=
 =?utf-8?B?eC9MaTk1UTVsVCt5eXNiUTRnOFBERFVDOEovWjE5WS9Gbys5d0lmdFpQSXpG?=
 =?utf-8?B?Q0xZclI1VytMRzEyK3NZNTJKSlZvemZ5N0xoYzFJRWIvYkxnREZDaUh1VTlW?=
 =?utf-8?B?NWl3QWpZYnE4N1RZWXBkTmxjZnFKczMxYzJHSjNCRW9aOXF3b1BTaEN6RC8y?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tRfXgSGWFLcn0Y2uyJFfCKCoDi3SDcGF9vX+J5lOfihJA32oayn1wJZ/8RB+LA+SLtl8bJm1XEArkED2OEsseHG3kqTf2+HWL4Rjx4/z6OPlKMUuYKqlpKCfOpvpahtpHM7Mvvfbv2sPC2d85GqJsAX+QsC5wHqfwSwY4CGoW/qAyOjSCsj44k8DjqG4ZmwBf9Qbn+1efEW5k4ZV/7Gleo0arzXE1reEV81iDc2qum/xSaFEwMYX56ZsaxlrK4dWbKbjtyt0sLkO6iEcRmv+rlqc/Nn6tnir6JAazsQ7wOn+cZZ3t5Xc1wN7z5me5we0E7+mSoo8fXOJX1hCY7wuQSUyL+lEHShgRFIkdqAwbDQl4StY/8pQU9AYfJTF5YRd2j0cT0bmaW/xRITPhiXBhgIFhM2cMl1lZX9Bd7KtElr4QqEigLgCkqHxCQ4EKIBCw4f2cwwPjN7R24hyTEIiFdVHzv27YHOPUmSYrp2/HpNeBWmxdjPy9Z0tWf2eMDZClOMTzNxzoKuA8tTpjnJw1dl8+iJy4djuBSDyvw4Ugf+IlteT5m8iFcroBqNMD5QDEqfXQUd/sqGgYuu/y4QcooEBpo7zNx1AXyysEfsZPrs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f139c704-4e03-4abb-c695-08dd96ed3f7b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:53:07.4469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UL8rkSjoJ2KB6zaE9mYwjAedw6VuRSmP2J9Qc1Cux26HC+XKpKgbtvp6mkSIQDwtGHkgBfEplMMlOUzwBnu4iB+lXP+uCYCL/8KG9Z/aN70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190147
X-Authority-Analysis: v=2.4 cv=RamQC0tv c=1 sm=1 tr=0 ts=682b53e7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=G4A5vdrzfFBscPi07l4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE0OCBTYWx0ZWRfXwr4ZgDLVIm6c
 zbe8HRI+0GJOmalhxtK5FxbrZdgo0ooGu2/+LMBmD38R2L/eEYF9kyCyd62wd1xUm+3dO6tdFlh
 /CfyjeZzhe0ewszV4IJy5qYuhcSOk3ZKx7eYkCcrslJYdLlcDVsH+nlrdkkY3FZW0b455xGN7OS
 LQ6AyvsAramq6tnKx0NmItIm809SSCR+AKsK8eO7COCKFfigd9Ox4f04PT6G0lZzK2XBJzG0DYB
 D+iN091DQbgtuTrtWLj/y8ytL6gy0W/VPUEU9SIfAuHnfl0jo4bf0kD2LYw8OvXbCabOgsYzMjO
 GBDUOUCyjp1TXTsN90bAlZyg1/sAj937HtyNlnxL0HdtseiRVM+vMJA4M5cK7R/mX0w6bd2t5dM
 70nScoc+YUXimI8ALBxVTrswnbyxu0vlHAQTexBSQ8NFJgHv+MTrBXUw5AQD/E3dXnC6iNJk
X-Proofpoint-ORIG-GUID: plo_zMXXgop3mdt1bWxCZ7T4yLjuENRr
X-Proofpoint-GUID: plo_zMXXgop3mdt1bWxCZ7T4yLjuENRr
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/16/2025 6:06 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V3 36/42] vfio/iommufd: preserve descriptors
>>
>> Save the iommu and vfio device fd in CPR state when it is created.
>> After CPR, the fd number is found in CPR state and reused.  Remember
>> the reused status for subsequent patches.  The reused status is cleared
>> when vmstate load finishes.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> backends/iommufd.c       | 19 ++++++++++---------
>> hw/vfio/cpr-iommufd.c    | 16 ++++++++++++++++
>> hw/vfio/device.c         | 10 ++--------
>> hw/vfio/iommufd.c        | 13 +++++++++++--
>> include/system/iommufd.h |  1 +
>> 5 files changed, 40 insertions(+), 19 deletions(-)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 6fed1c1..492747c 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -16,12 +16,18 @@
>> #include "qemu/module.h"
>> #include "qom/object_interfaces.h"
>> #include "qemu/error-report.h"
>> +#include "migration/cpr.h"
>> #include "monitor/monitor.h"
>> #include "trace.h"
>> #include "hw/vfio/vfio-device.h"
>> #include <sys/ioctl.h>
>> #include <linux/iommufd.h>
>>
>> +static const char *iommufd_fd_name(IOMMUFDBackend *be)
>> +{
>> +    return object_get_canonical_path_component(OBJECT(be));
>> +}
>> +
>> static void iommufd_backend_init(Object *obj)
>> {
>>      IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>> @@ -47,9 +53,8 @@ static void iommufd_backend_set_fd(Object *obj, const
>> char *str, Error **errp)
>>      IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>      int fd = -1;
>>
>> -    fd = monitor_fd_param(monitor_cur(), str, errp);
>> +    fd = cpr_get_fd_param(iommufd_fd_name(be), str, 0, &be->cpr_reused, errp);
>>      if (fd == -1) {
>> -        error_prepend(errp, "Could not parse remote object fd %s:", str);
>>          return;
>>      }
>>      be->fd = fd;
>> @@ -95,14 +100,9 @@ bool iommufd_change_process(IOMMUFDBackend *be,
>> Error **errp)
>>
>> bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>> {
>> -    int fd;
>> -
>>      if (be->owned && !be->users) {
>> -        fd = qemu_open("/dev/iommu", O_RDWR, errp);
>> -        if (fd < 0) {
>> -            return false;
>> -        }
>> -        be->fd = fd;
>> +        be->fd = cpr_open_fd("/dev/iommu", O_RDWR, iommufd_fd_name(be), 0,
>> +                             &be->cpr_reused, errp);
> 
> Need to check error before assign to be->fd.

will do.

>>      }
>>      be->users++;
>>
>> @@ -121,6 +121,7 @@ void iommufd_backend_disconnect(IOMMUFDBackend
>> *be)
>>          be->fd = -1;
>>      }
>> out:
>> +    cpr_delete_fd(iommufd_fd_name(be), 0);
>>      trace_iommufd_backend_disconnect(be->fd, be->users);
>> }
>>
>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>> index 46f2006..b760bd3 100644
>> --- a/hw/vfio/cpr-iommufd.c
>> +++ b/hw/vfio/cpr-iommufd.c
>> @@ -8,6 +8,7 @@
>> #include "qemu/osdep.h"
>> #include "qapi/error.h"
>> #include "hw/vfio/vfio-cpr.h"
>> +#include "hw/vfio/vfio-device.h"
>> #include "migration/blocker.h"
>> #include "migration/cpr.h"
>> #include "migration/migration.h"
>> @@ -25,10 +26,25 @@ static bool vfio_cpr_supported(VFIOIOMMUFDContainer
>> *container, Error **errp)
>>      return true;
>> }
>>
>> +static int vfio_container_post_load(void *opaque, int version_id)
>> +{
>> +    VFIOIOMMUFDContainer *container = opaque;
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>> +    VFIODevice *vbasedev;
>> +
>> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>> +        vbasedev->cpr.reused = false;
>> +    }
>> +    container->be->cpr_reused = false;
> 
> It's strange to set iommufd and vfio device's reused in container's post load,
> Maybe better to do it in their own post load handler?

vfio_container_post_load has MIG_PRI_LOW so it is called last, which guarantees
that be->cpr_reused remains true while all devices are loaded.  This is required
so that we supress dma_map calls during device load processing:

   iommufd_backend_map_file_dma()
     if (be->cpr_reused)
       return 0;

"vbasedev->cpr.reused = false" could be moved to vfio_device_post_load.
I put it here to be future proof -- al reused flags are cleared together,
at the end of post_load, and to be consistent with cpr-legacy.c:vfio_container_post_load

>> +
>> +    return 0;
>> +}
>> +
>> static const VMStateDescription vfio_container_vmstate = {
>>      .name = "vfio-iommufd-container",
>>      .version_id = 0,
>>      .minimum_version_id = 0,
>> +    .post_load = vfio_container_post_load,
>>      .needed = cpr_needed_for_reuse,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_END_OF_LIST()
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index 8e9de68..02f384e 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -312,14 +312,8 @@ bool vfio_device_get_name(VFIODevice *vbasedev,
>> Error **errp)
>>
>> void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>> {
>> -    ERRP_GUARD();
>> -    int fd = monitor_fd_param(monitor_cur(), str, errp);
>> -
>> -    if (fd < 0) {
>> -        error_prepend(errp, "Could not parse remote object fd %s:", str);
>> -        return;
>> -    }
>> -    vbasedev->fd = fd;
>> +    vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0,
>> +                                    &vbasedev->cpr.reused, errp);
> 
> Same here.

Do you mean, "need to check error"?
If so, no need.  The new function definition is:

void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
{
     vbasedev->fd = cpr_get_fd_param(vbasedev->dev->id, str, 0,
                                     &vbasedev->cpr.reused, errp);
}

cpr_get_fd_param() returns -1 on error and sets errp.

>> }
>>
>> static VFIODeviceIOOps vfio_device_io_ops_ioctl;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index dabb948..046f601 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -26,6 +26,7 @@
>> #include "qemu/cutils.h"
>> #include "qemu/chardev_open.h"
>> #include "migration/blocker.h"
>> +#include "migration/cpr.h"
>> #include "pci.h"
>> #include "vfio-iommufd.h"
>> #include "vfio-helpers.h"
>> @@ -530,13 +531,18 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>
>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>>
>>      if (vbasedev->fd < 0) {
>> -        devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>> +        devfd = cpr_find_fd(vbasedev->name, 0);
>> +        vbasedev->cpr.reused = (devfd >= 0);
>> +        if (!vbasedev->cpr.reused) {
>> +            devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>> +        }
>>          if (devfd < 0) {
>>              return false;
>>          }
>>          vbasedev->fd = devfd;
>>      } else {
>>          devfd = vbasedev->fd;
>> +        /* reused was set in iommufd_backend_set_fd */
> 
> Should be vfio_device_set_fd

yes.

- Steve

>>      }
>>
>>      if (!iommufd_cdev_connect_and_bind(vbasedev, errp)) {
>> @@ -634,7 +640,9 @@ found_container:
>>
>>      vfio_device_prepare(vbasedev, bcontainer, &dev_info);
>>      vfio_iommufd_cpr_register_device(vbasedev);
>> -
>> +    if (!vbasedev->cpr.reused) {
>> +        cpr_save_fd(vbasedev->name, 0, vbasedev->fd);
>> +    }
>>      trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev-
>>> num_irqs,
>>                                     vbasedev->num_regions, vbasedev->flags);
>>      return true;
>> @@ -673,6 +681,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>
>>      migrate_del_blocker(&vbasedev->cpr.id_blocker);
>>      vfio_iommufd_cpr_unregister_device(vbasedev);
>> +    cpr_delete_fd(vbasedev->name, 0);
>>      iommufd_cdev_unbind_and_disconnect(vbasedev);
>>      close(vbasedev->fd);
>> }
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index db9ed53..5c17abd 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -32,6 +32,7 @@ struct IOMMUFDBackend {
>>      /*< protected >*/
>>      int fd;            /* /dev/iommu file descriptor */
>>      bool owned;        /* is the /dev/iommu opened internally */
>> +    bool cpr_reused;   /* fd is reused after CPR */
>>      uint32_t users;
>>
>>      /*< public >*/
>> --
>> 1.8.3.1
> 



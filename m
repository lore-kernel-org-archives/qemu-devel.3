Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D6EC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 14:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNmV-0002Fn-3Z; Fri, 08 Aug 2025 10:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ukNmT-0002Ea-Fm
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:09:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ukNmQ-0006DQ-Ql
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 10:09:13 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNT3j004001;
 Fri, 8 Aug 2025 14:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=btmD0VlmP4elMbfSawafLc8WPSh56UIto7KjzAbn8Ms=; b=
 iH5aH2u5pgZnd361Ers/U4ymmgxHW+sICLlbeD/n7i3aaBDpJUuy1XLPeX8YiKWm
 +XKY767uNUGr1wmA1LgV7q+FlScidqNgtuLWIQtIrXspJwXYZdfBvfsGE/QoBzFS
 PQXgvGO9Dps2XNI5VGn/iydt2rDZGPzhL9zbUg/CbDLbP0zn20MZqDuk6FoDwTrC
 fTqqzthdzsm6Rm2UV4qYxbgT8koaKtoLn5eGfw69rSVLPI8cgt/Tm46o/5+R4jNT
 +/1rH1oLCiR9nRh8EeGFRDbZmMJjsHstzqMOjpuxtsbaWQ1svn8zVhjMzBdfysKC
 CLxrwej+AovnC/b3al6KPA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvf69yu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Aug 2025 14:09:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 578DO6sR009830; Fri, 8 Aug 2025 14:09:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48bpwpsp4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Aug 2025 14:09:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr9//a0HDgZpfY2V3DIqcQzE9aR/wP1wCNlCGae3hWQ6mrOl+ZdGTE6iFtKtmivV0K7yHlpudZjah9eqe7+931zivfDwMa1P6UMm57rOuqJ5+Hx+JrqvZUC2u1mS+5gFas70m8GRlWjtycWQmRkRxB/sK/0GIVhgRkrFl9zbswtxYvbVdUR0vJTNjk0ZLGluyi85poia15OumbFA0i2VtAbe+qwKwrsYCP9/5z+jKy3lz5aN5SVZSmalAjQ3VnFBox8XxZCB7wL4y+7d5XEkV1qvzOqq0Q+lNhJpIWzKk/RPrC7KFS/jUUwiTC9U9Sjb2u7nKqBltiebts0mypphfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btmD0VlmP4elMbfSawafLc8WPSh56UIto7KjzAbn8Ms=;
 b=cqdwTCMaZQITkrONSSJR5eMdpNHRsuYHlNp/YyQ7wf6mIafOb7PmgT9c7FLVck9oUpHtioGEewHW1BPjU+Btl9cMmKSdnSb4N9oloPYTvDvNahva6d7J+C18ZoiRySgckRoqsw3ii7c+d+2LmTMIyaN3MQi33hqvJafki3g0KmCu8HHIloleFjhvpicdOsHjoR4z1XYry8riDILhOSYDTDSZlBFm09/cHjec7I279OC+ntq8ub8rq4RNZ55FHe7nTx8klCPP7S9f0WmmZJIf4kZDo6/bXGzo8VPznyY0gcO2x5vlvhMhSo4OwT2E7/5HZwoty615sFXsWw2qxXojXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btmD0VlmP4elMbfSawafLc8WPSh56UIto7KjzAbn8Ms=;
 b=EX6k0uO8/iAlRaEKPIGM5FDVqmmg9FyFzXqqZxAoU2VEiNB9FrF9xLDtDZ365n/cTMC5A5Klk/DNuEUn7aJjGV3wMEH0Ylc7GyadlSmEMZIiKI99jO02vrAVVfzNAMJZy1Ae+asJVdpmzLVlJ3JHkPP0gv2otAJD4rYv63JaS3Y=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6557.namprd10.prod.outlook.com (2603:10b6:303:22a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.26; Fri, 8 Aug
 2025 14:09:01 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9009.016; Fri, 8 Aug 2025
 14:08:59 +0000
Message-ID: <aee57c51-b7e5-4c11-b8bd-222251c4ce91@oracle.com>
Date: Fri, 8 Aug 2025 10:08:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] migration/cpr: Clean up error reporting in
 cpr_resave_fd()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-5-armbru@redhat.com>
 <6d876750-9d7b-4556-a1e5-06f7c7487eb0@linaro.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <6d876750-9d7b-4556-a1e5-06f7c7487eb0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0148.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 521b37bd-06e0-47c5-5c63-08ddd6851ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NURHQ21YUXdzRWsrWm5DZXRleFlaTWh6YjFRSVF2Mlc3WHg4K0RsbzNPbGFN?=
 =?utf-8?B?emtzOEVpNFZ6WWNUeFlOaG10SCt0Rk5vRisxWGRlVkRCejc3ek9SSmNCUklt?=
 =?utf-8?B?dWttM0FFTEFybVlkQ1RRNG9pTi9FNXh3NUhQU01BRDNiK3dBVUU5bk9LV0dY?=
 =?utf-8?B?RnV3WEU1NUVLQkQxeTBzZXYyREtSU0xFNmw0TWM4VWErdVlFdDh0VEJQQU5N?=
 =?utf-8?B?OXdRdkIyZmRZWXNPWUZOT3MxZTgyUzh3NGNXalllelM1LzNZTnlNRG9UNWFu?=
 =?utf-8?B?c3JieUsxZVlzTUFBUGlLeWFpSUZiQ2hGT1lORkFqaUdWN1dpZlFOcTlPSllm?=
 =?utf-8?B?OVZacTlOazJYb0VrQWsyTGNsUnlmN1RGY1dKMTgwYWJ6c2tQYXMrYVhSUk01?=
 =?utf-8?B?TGltdDAvcWFIT1BJYTlrczhoUnlzS1hib3VSSkpRWG4wckZaUldGREZienlX?=
 =?utf-8?B?UVlheXRPWWI5ZmJpS2RBdUxZQkxIR1pjQ2cvNkFVL1g0TzIxZFBVbXZIQm9t?=
 =?utf-8?B?czdMbmJOWjZzY0hqcjZUMDBLS2d4VGNIeTEweTlRdjY2SnFmZWtUNW5RRTY2?=
 =?utf-8?B?NytrLzFkQnRHVVJuWXByTENXWUdieUFHVTVQc2FPZE9nUWJtRXdCdFU4MlhP?=
 =?utf-8?B?bVpiRUd2UTR6clpleGxEaXBrbkdmWkV5VFlpRXlLV2Y3UjFNNE42ZkhiMWN2?=
 =?utf-8?B?TzdNUDEzSlRPMnBaUTl1SENOZHRNZkdTU2QzK2hLdW5GUEtpQ3FvZUcwVURs?=
 =?utf-8?B?dWVRaFg4ZVI4dCtGV2p1bU9tckN5UVhFOVlyb0o0Z3Nock5pamJ0OFhkN280?=
 =?utf-8?B?dFFoUW1iN0pBVDM3RDZVd0NHMmcweXRiNy9DS0tRb0FxbVIrWGNhUHNYZ3R3?=
 =?utf-8?B?cVM4TzVMc09wN0p4ZzgwSkV5dkZQSU1hZ1VkNnZpMno3QmkxNWJZdG5MWGJP?=
 =?utf-8?B?OGJCRkRwVWpUUEs0R2k0VzdoWUt3NW9UakdxMWRTZFBFM1NNWEpxZWkySjJj?=
 =?utf-8?B?TTRQTG5sVVlWY0hNbTVCL2l1dHRycG41VFhPZ3RFWktja2dRMlkvV0YrYVgv?=
 =?utf-8?B?b1cwZlJ4SkxMdXhsRHBhZ0ZFYnNDZndTS0x1UVIveXoxeWdydE5wZ2U1YUl3?=
 =?utf-8?B?eERMbitrRjlPNk1hbVhMQU42cStFMnJRVm5RaFFSUzl6TFpvZzd1SlBrOHAy?=
 =?utf-8?B?NmZ4Z05ra1BtZXJLd000VjFtVjI2eTc1UG9IbkdDSUNveGdkNXFkeGFhdEtW?=
 =?utf-8?B?cmZwalVEREJHc1FGeFRmdlA2amZYS080cHl5K0N5aFRQWFpQcW5MM25MWEZ0?=
 =?utf-8?B?d0wySWJCTDN0TlZmUWZJdVRVZ1kxSG9INzI1dWROcUphZFp5UTlXY01YTkhW?=
 =?utf-8?B?WXRmeFQvdUJMNW9jQWpqMVU0Z2Y2ZnRiL2F3eWNDNTQ4SE9OSjRBS0NmLy9Q?=
 =?utf-8?B?d2RwalAvcUxkM1hxT3NQQnVST3hhMUJVRzJvVlBUZDUya3gvT0w4dFZmUERx?=
 =?utf-8?B?SEkyYWtKZ09HU2o4cXBjSkVEK0FhZVVYUm1ITGxjU0R6VmgvYWRXTXdzZVhR?=
 =?utf-8?B?TkRvcndmd2hCbGRKMGh0ZXQ5NDZjeEFONDluOFc5TmxoZ3N3TUpsa2hVdWsw?=
 =?utf-8?B?akZkSnZQRjhaaExXZlNrbExEaWJUTjUzL1djYkhaOFRieHdRYUJVTmZsdWJx?=
 =?utf-8?B?SXBxUkQwekNucUE0TWw2TGkvUjMwUlBMRTNvNTJDUVhmcUZWRDR1T0JYWCtP?=
 =?utf-8?B?dnFLbHJTOGFaT1h6ZVloelUrajFxSXl4WTROMC9seXFOZkJGcGIvcXFmZmI3?=
 =?utf-8?B?MEVCc29qMTh1WXE1VVpLUURhSFpCK1NjS0xjSkNxL0xpMjZMU0pkaUNBZzhh?=
 =?utf-8?B?cEZRbmtVZDZ6aUZWU2NhMFVENFdxb29XbEJZYXdxREJzdWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNHTyt5aVZ0ZHl2Rko4UzRKVU5oVVFJT0V4dGg0eWlDWTVBVENhMHR4dFV6?=
 =?utf-8?B?MGhpa1lvUHc1ZGI2UklxeFhQWmRtaUl1ODlEclBMM0ViVTFhalFlS3NqL0pn?=
 =?utf-8?B?L29hSmluRFRKQ3kvU2VSc2grM2l4QVllN3dmUmFrV2VLVXNMU3VhVk91OUJG?=
 =?utf-8?B?TjNwNmNVVUtmNWd2NE8wSlNqZmZ0dCtkak9RMXFsbk44VGdsYXpCR2FwWmpZ?=
 =?utf-8?B?aHUvWEFuNGZUN21XVk9tTm1xM1E1SFhVdGZYc0t1R2FPV1BvTml0MGpWMmwv?=
 =?utf-8?B?TkF1MHZmMFFiU003ZkNZcVQ3NFp3V1ZwMWFHb094SlVCQ09KQ0lUcXprNmg3?=
 =?utf-8?B?ZXN0QWI4Sk1TN2wzVUFDQ05BVnZ6Zkpzd05aejIydmU5ZzRYMW9SQk8rbTdq?=
 =?utf-8?B?ZkNIUUk1UERTSlZMcFZlVHN6ckIyc0dvZndwMCtqaGxIU3ZwODlLVjEzYjJW?=
 =?utf-8?B?T2R6eWlQWVRZMWxkNzJjek0zT3FKcHJVMjVpaDNyN1NkL2ZqZjI3eGZwSW1X?=
 =?utf-8?B?UkZyalptZXFSQ3hOZlRIWlh1M0FST2hSbWdSMzFKWTU5S3M1dFUvK2daY21k?=
 =?utf-8?B?VVRlNjJDVCsra1hxNWlKV3Q1OWdjUmVXdzlCUEo0SFU2NXBXRkh0SWRMaCs1?=
 =?utf-8?B?ei9ydWJMaGQ0WGs2S2RqM3NoOUtGMnBMdTN1d0RFSklmY0hHMVd1QXRWK05G?=
 =?utf-8?B?dUdoem5XMUt5bldEdVQyc3dQLzJ6NkhPaXVzNEdmemU1RVUwOU1sdFVkaVh2?=
 =?utf-8?B?U3hFT1h4ajQ0MFhWQXVkRjRYdUNwamRtNUgvN0EwdnorZ0ZzT0RCVDV3cVJj?=
 =?utf-8?B?QVV5YWJsMnZIVzZITmFkKzk4Vk5ZcVJMWVR5c0M1ZGErVVFjM0s5RGw3V2hP?=
 =?utf-8?B?YlVtMjhsV1pCMzY5a0NsUEppaUd4QnMwTHBtZG1yZTBpWWlWOXZFRk1hK040?=
 =?utf-8?B?a0ovdFNlN0w5VGhIYzJRUDE2TW8zb05pVlZJQ2xrSHpER3J6ZE5LU3ZSeEx6?=
 =?utf-8?B?d3dRY2hFOERLVmpQUGN0Q29kUlV1cnlTUE5uSUFUZnJaU1llOFdNL3VVUEJu?=
 =?utf-8?B?TzZjcE1lOWZzQllIUEpyNWgrWnpIYWZFUmhhZVpXYkZieFN3T0xqT2NRc3B6?=
 =?utf-8?B?eWxhd05yelBuMmtJUkdTSGlkMjZUQ2w1dG9ZaG01eDc5b1NNOTBuTUZLVGc0?=
 =?utf-8?B?aUtvOHVsUmwrYlNTU01WNk4xWTNGbHROTTdITnppN1lJdlBHUEs5aG1uUytl?=
 =?utf-8?B?c3QxNUxQK25sM2JadHVyb0ZEWE5rN1IzaTFqcFhId1lNeSs1RVdlWStndUVH?=
 =?utf-8?B?NzBPU3lkTjB5ZGFUZTlCN0xLS3U4bkNxL3pxRlIvemYzZDY2MURLeVVHMm5E?=
 =?utf-8?B?MEx3QjRLbkovSUtLZ3RMRnUrZVlRQ1dwVFZ1c0V6UGFJOXhjRTIwNWhzdUFJ?=
 =?utf-8?B?a3BmMmk3VEp6dzczOHRTTEhBeitGelVOUHVING5xbU5SL0JyWHVlNE8xNUs4?=
 =?utf-8?B?WlI0U3VKMjlnTzNKbXFGWGN6SUFOZFk2dmh0UVZUOEFLSklsajkyWXFBdzU2?=
 =?utf-8?B?eTl3d2ZUUkJpaW5uNjZzeFovOEIyUW95Y1BVSTgzTEkrWm1ibFE4K0VFNzZt?=
 =?utf-8?B?enhUN3Y3N25RT0dYL3c4Zjd6NGppcVdOVXVNMC84MWpSaHZSMVRWVzMzaE04?=
 =?utf-8?B?aUFoQTVZRFJVYjVtb0pzOWozZUpqeUtTMVUyM2JzSFdxRWd3RktaZGhiU0RW?=
 =?utf-8?B?V0xDRzY2WFM3bTMxWTNyTnhVUXUva3NqUkRpVnhqRzF6YmJaalpXYnRHWlIw?=
 =?utf-8?B?OFJtREVMVG42bld3ZUtqQlZDMFlEOS9GZUZwS2VRbE1zY0c2MHRxYlNZQnpu?=
 =?utf-8?B?RFF5S0hMYTNqOVNFY0RFL2crSHhGc1loa1VZbUVzeE1FcHJrVnVIbHc5Rll3?=
 =?utf-8?B?eWY3UTQrNDh5dWd5NVJLbzQzeUJLT2hGNVpIc1doT0liQ1I4VHFPK1cyb2N1?=
 =?utf-8?B?QlpQR2w0ME1wNFBBYzRnWC9zZ0R3V08zR2F5RExXSTJNeTlXd0F4aXRMOGVk?=
 =?utf-8?B?bXBTclhNWTRJSWcreS85dWYrNnB1RHFIRWIrT0FoYTk4OTdEWVNaa3c4Vkhl?=
 =?utf-8?B?SDVUR2tRWUQwMGxMNFdGdWh1a3dZRlZQbWRYU0VWTGloM2xvTnVwTEdFY2R4?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n4ffI8jbF9t0rYNg2srQ/ExufrvNfSHt4WCaGpTUUKL4IaytdikL75O2Y1kkWiKk/tYHWJjPgXan4KXQH7fgQcvatngnM0xyF1k/4AUV/S5T3r7v7A7SzSly3GEqbBX5MCcR3QDp1cSkmecMgogAL2WrrzySIjpMVCjH5vsy0QL8hyliCCZWc+K+KpRKzDTJffppdNrFSEgm1DoeKw4fb5VjlY5arM45wX/gjhAu5u6k0honNhc65llV8nPkhYNRzPsdV4UMtMPItNmah6Gwy+OCOAHHFOg34XJ2XfoBEeLki6d/xzRFshs+/iwytuy+kY0GkX+O3qPj+aYSyI1JYJyk1mKuXc3GybmMgXZjTwm3S9QbGF9EVv20DOG7vukGpmKKld8kVMfjEUVoiMDHVqii3nlpc/XiLh8ssczWo3PFKy9sGoFmuVoqx9K3bkGPkbqLvQo8hnC0m26dX1lfCWJypFpNYa9jrvOEoQX+hdmpRqCHRYjaJckuSJ6YZBGTfUraDNy8LR+bqA5+zA0MzDdscHom4EV9cdZjmlzbvAgHzz1G5jUL3dtkbX2fYyB2BHvWyqEk1T6/Gtaf0wUGPQS7tdYFTbMSPG8ldwfUBvA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521b37bd-06e0-47c5-5c63-08ddd6851ef4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 14:08:59.6581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uViPDTT1vneDylrE/NVaxqhWdkoTgsxuRShv+DP3hcKlM7dc2pGRGDjI780ZHULVFSz1BOn/Ljed6+1S/A/fjiWzm2vV1qW1uVP2XaXZchk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDExNSBTYWx0ZWRfXxa53MycvXDAi
 ocTnogdcOkmAyjSWPKqjeI/E2gYlfj1UBO1mL22xT8uyyfFgPmmmXZeNNxvl52NwQU1F7mMb1VJ
 UOoLbnkfiC79SVvrCGEHp+Hj5H1p3lZNJuQezHZv8y8EhiXnuvxHuzw8pgxUhUMuBhB00Ev3xWa
 KdpRrB/iWjzzkcs3j2GU5swkm/7dfDFD/fIks43vMbR4bKbReHli7TPNDXV/9dUmJ5GCoVbuvQ0
 0Vwft4XWiNsGw71OabMh19lZkxmKRdGfNttzlnjfkOlhF0c3VBiAZLI89v+Q6H0qngkNT0QP9XE
 lmHF9pk1D3zgN9pGA1HBC8G/DVAtVldPTOhiLnCikUog1WlRL1Y9h90RI093mUf7taiduXUnhaC
 /sDHPfhgbKpkYpTzuqoXRdP14p9VJ8pOXkOXUnj5Yc0FxYi6rLk2902ix9bAAlpdJGNX1A20
X-Authority-Analysis: v=2.4 cv=RtTFLDmK c=1 sm=1 tr=0 ts=68960503 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=bYP65l4SzxmFb3PeuIIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WH7jZh4LnqV8BDSbrEvCxwKeebyZe2gD
X-Proofpoint-GUID: WH7jZh4LnqV8BDSbrEvCxwKeebyZe2gD
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/8/2025 9:55 AM, Philippe Mathieu-Daudé wrote:
> On 8/8/25 10:08, Markus Armbruster wrote:
>> qapi/error.h advises:
>>
>>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>>   * exit(), because that's more obvious.
>>
>> Do that.
>>
>> The error message starts with "internal error: ", so maybe this should
>> assert() instead.
>>
>> Cc: Steve Sistare <steven.sistare@oracle.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   migration/cpr.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index 42ad0b0d50..908bcf83b2 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -7,6 +7,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>> +#include "qemu/error-report.h"
>>   #include "hw/vfio/vfio-device.h"
>>   #include "migration/cpr.h"
>>   #include "migration/misc.h"
>> @@ -100,10 +101,10 @@ void cpr_resave_fd(const char *name, int id, int fd)
>>       if (old_fd < 0) {
>>           cpr_save_fd(name, id, fd);
>>       } else if (old_fd != fd) {
>> -        error_setg(&error_fatal,
>> -                   "internal error: cpr fd '%s' id %d value %d "
>> -                   "already saved with a different value %d",
>> -                   name, id, fd, old_fd);
>> +        error_report("internal error: cpr fd '%s' id %d value %d "
>> +                     "already saved with a different value %d",
>> +                     name, id, fd, old_fd);
>> +        exit(1);
> 
> My 2 cents, I'm not sure this information is more helpful than a plain
> assertion (at least for users). No objection for this change.

The message gives more information.  It has helped me debug
problems in the past, in concert with enabling cpr traces.

- Steve



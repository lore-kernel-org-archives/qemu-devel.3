Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED652C28B2E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeoR-0007k1-58; Fri, 07 Mar 2025 16:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqeoD-0007aX-JM
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:00:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqeo8-00059J-6c
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:00:40 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527JtjGc017655;
 Fri, 7 Mar 2025 21:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Ja9qHv9bOJ0MP7rqavQacdSCreW43e30+Q/wRFIPpPQ=; b=
 hno+KmfYftuSKy8fUKz4nIQFMSGzvewZA2g0ckR6soP0s2nrhW83idOY2AlbGNj4
 f3fwYcEvn3XNjDq5Qz6uEi93NPdAhQ4HZp6Lo4rdV21VIh1nzPL1YAYpIO6CkwY1
 alRHgJ2MQrjaMCjEIPuxnvpqRs9SeA0bZQEBHSKLW4ZG7JaVICrAUqWphecHbm/f
 neGnorp6k4HzXEY6av4Pcr1ONjqXSYrtxdzk/fotCr1mB4oxMWm14EkUUf02AeSE
 73csHpbH7EPGxiu55sDelZEQylXP3ESYUu6JBYlY0ccxhaiPl+2vILIlTV+lrlBF
 MnaINpuUE9skxV8B7l4x5A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u82567x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Mar 2025 21:00:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 527K5g25015740; Fri, 7 Mar 2025 21:00:32 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 453rpf3e9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Mar 2025 21:00:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpiMVQwogDHkf5QTHUdtN552dYlTSV7+xniPDitih8Yo+pf7La+LOQjp23/ulNbXQO7e9+nfo71kJM/4/r71DwkB12d/kK567sxdyUc2aPTKYYbQu/JoIDDc11l/DTNglT7RQfwqsDyd/owYhj66QUeQYsF1XwdPldLxVGTxhvjAXykrwChbw8FGfN0h/52Xpz0waUH6SJ75O88qwm+6FFBeu4ji/0606w7+1TbkO6+uyKgD5Ilk4jqPmCGbcTC+35+k7jOTwQO0j9NrWy/KY9zneMBYTOlRfdT74O0u4aNMoRRP9beSfCtPkdGNXK2lvt/38V4wShYWe6u54hwHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja9qHv9bOJ0MP7rqavQacdSCreW43e30+Q/wRFIPpPQ=;
 b=tr8MAACUzy7KxZlvOQuE1aeffs7F7qj3lniul1vvbhsMLtKPe3lz3DCAE6A5fm0rT6N249BtDqXk3u2nMWLnipB7XYYZ2s++xuqSdb49suZL/Vjf5kYF3SfZyx1T0U+e+7tHqwCtJPs6gkUqTRU+8CcyLpKjPSrjMjTSxnxW6Qd5d85fi9wwJb3tTDpkNEdKqBh9aU8rm2nebNp4RnEJ6SGYUUmYYlX3y7OH43RhQco87a0WoEgsvQKpKWA+LxcDb358CVU5INzV4r2eCvTw1H6j1GWE4UtK18PS1FhqZObLz5BdVFHuZqeViVw6WwOsZbzMXfHYgECXXTYpSitscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja9qHv9bOJ0MP7rqavQacdSCreW43e30+Q/wRFIPpPQ=;
 b=hq6xE6wkLN4oiM9u05Me3fTh+uPeV53Kgr9DF8ppLk2n4YtUzAfxzuKGU2V9u05tx8zBrylYxnW6ySQA9UOFedr/G541kQKOM5srnamwnFuLnnr9dQjCLRCn4NTIXz9omT2kibKkU7ZkTrVE8Sgf6m1c3hjIza3vzgv2u5QaWM4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB5155.namprd10.prod.outlook.com (2603:10b6:208:320::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 21:00:30 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 21:00:30 +0000
Message-ID: <95c279cf-4319-4dc8-b35a-d56749039a54@oracle.com>
Date: Fri, 7 Mar 2025 16:00:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG, RFC] cpr-transfer: qxl guest driver crashes after migration
From: Steven Sistare <steven.sistare@oracle.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: William Roche <william.roche@oracle.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-devel@nongnu.org, "Denis V. Lunev" <den@virtuozzo.com>
References: <78309320-f19e-4a06-acfa-bc66cbc81bd7@virtuozzo.com>
 <6fd87c40-92dd-4290-9fa9-abd014ddf248@oracle.com>
 <8c79212c-4b0b-426b-8563-3e7d478ef24f@oracle.com>
 <4a74201e-7394-40a5-910e-36c4255ed9fc@virtuozzo.com>
 <d03329c3-a55a-4818-8d41-7efb2e6af1c7@virtuozzo.com>
 <d5a37291-e183-42b5-9b9f-7ed736f0c367@oracle.com>
 <063ee0ac-0568-4413-835b-e620f8d70761@virtuozzo.com>
 <76d393fa-4c40-4331-aa5e-381f34c60c3a@oracle.com>
 <9f3fe262-fdab-4c01-9117-e9795444fe20@virtuozzo.com>
 <24677eb1-dbe6-4e0a-980b-9c38d4decde8@virtuozzo.com>
 <849106e8-1e4d-4a0b-8c79-6988b4cd8b0b@oracle.com>
Content-Language: en-US
In-Reply-To: <849106e8-1e4d-4a0b-8c79-6988b4cd8b0b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:208:32e::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB5155:EE_
X-MS-Office365-Filtering-Correlation-Id: a5294721-fd2c-405d-6d71-08dd5dbb17d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDhSTnlmTVNCODBLcGtMWUV4d0dqYnl0NTQ5U0t3WjF1VVY0Vy9qNmp1QUY3?=
 =?utf-8?B?TnV2ZzR2R0psQkNrait4a3g0Z1JEdGFDZmNYTnczKzVUZUVBZUV0cm5TQ3NJ?=
 =?utf-8?B?Tzk3UythMk1QRTVBQXozQTlZSVRmM25jNHBsbVpzcGFpWE13b09FL2s3M25R?=
 =?utf-8?B?VVQraEZvK1lEZ0hJVXovaGZKSVhXOEc1WmNaUVNVUGM3ck5Jd0xTK2U1Mkpi?=
 =?utf-8?B?TkcyT2Z0dEs0cmV3ODV1bmNmSWNMbEpJNnFiM25jd05jeU1KNUNrZFhITUow?=
 =?utf-8?B?MDZQK1JXSnpNNWpLNW5XaThoejB2bTlyYVRpczRBWFpQa3lsOTMrOWp6enQr?=
 =?utf-8?B?ODJhTXdyZzZUVkRuWW5JMEtqTnN0Rlo0SHo4Uy9yQ2p0aFYxYXQwU3ppUkdB?=
 =?utf-8?B?UVdQRHVDR1FvM2FXWnM3RTI3Zi9aRVp4MSt4eEFFYkZMVnMyVWdzc1I5Mm9i?=
 =?utf-8?B?UzUxeEVoeFcrWU9OREZmeUtMdWhoRGdMbG8zdDBkNE8zUmg5V2tQOE5SYjRX?=
 =?utf-8?B?YWk2UmRDa2hxbkNGVjZBdVcyM1hWTFpLdWxxbW1Bc2pJeEVhdHlYOXZQZlR2?=
 =?utf-8?B?SklwRWFuTkVmSGVNWmxjOCtKY1B5VUpDNHBJRHpuZzlBSTFyNkRuNTQ1NXZT?=
 =?utf-8?B?dWRRSktwc2RiYlExeng5eVBwV05vbDE2Y3c1NGRjRjdrS1ZDMkRKTU4zMlhE?=
 =?utf-8?B?amMyaXk5Z2pIOWQ4V1FNZVhJeFBvMlJrOUxqbE9TWHJYMjI5ZzRsQ0J0b2kw?=
 =?utf-8?B?dURVckwzblZ6ckthMG5RYktEc3dNVGd1eVhmdTEvL3F4d0Y5U0s5MllWYk96?=
 =?utf-8?B?VmR3WkdEWnN6aU1HU2NCaStGdFVBYjhCalZwS1oyQm9kcWw2YTJwLzlIcTVM?=
 =?utf-8?B?WE4yblRDQXR5MG9kUTNJUWdXOE5IVTZneENMNFI3SmkvMEptYkFWK2J3YXN1?=
 =?utf-8?B?a3JraWNMWWRNSVh4VGtCdVJHS3VvaTR2cTlGKzNnUGRsdEV2clVBblZkQlZu?=
 =?utf-8?B?dE55anJpd0hyUXJiblJON2Z2c05jaUVkNkRlQUx6NlUvdlU5Zm54bUF0ck11?=
 =?utf-8?B?blB6QXFDdkpObUE1QzBUWW5wMFhMaUgzV1Q3OCtxU1plWUhIUnh4YW5BZ3J5?=
 =?utf-8?B?citjTWxCc090VFBSLzZOSy82SjA3QU9WaHpLNVRJcFhYRm9CVUNOOFJyRTVF?=
 =?utf-8?B?Ukc3S3N3MTJRR05PNWZBNzJMSnRoYWprYWl5dVBoeDFCSGJGOUtuUHRTUjBM?=
 =?utf-8?B?Y0pLRXFOZGp4Q0w2VHd2YkJ0Y1pmMGNZZmhJV3RLa3BkSFNPaG05WU5LbGRC?=
 =?utf-8?B?ZTUwcVdScld6bUFSRkNIT2JiOUJ2UXkvaEdrTkVEUkR4T0lsUUhISlJCeDg5?=
 =?utf-8?B?NmxFYllKVjN5OHJkd1U0ZFlMdEV0RmhTZ0xWQ01WTnJldHBVZ2g2eEhNNWxW?=
 =?utf-8?B?bDA3QVRpL3hUUlZDVFcxQUVnYlE1NWd3SFBIc0k2dGFZNzJDemNoRjUzbWRC?=
 =?utf-8?B?V1JsSS85ODRKaWR6bmZHalRuVGtaN0dsbkkreXJCRkJrcDV4QWR2UTBTdUs4?=
 =?utf-8?B?NmprV09sWWEybGo1S2JFdjg0UmY3TEl3SWExR3NGN2x1RkFlaHRBMkxUa2h2?=
 =?utf-8?B?UnFXZkNiMklxRUFJQ3VyUjc5ckdkZnU0T2l0OVIxY3g2L1o2UjBHVVJzeHBl?=
 =?utf-8?B?V1dPOFBSVVpXSzN3L0UwdUpEWVE5bmw3SERNdUc0ejhaaWJaaXNNR016aDZT?=
 =?utf-8?B?UXBSY3BvTVNCUUNiS0RTbmlzeXRkajMxbDYvNmUwbUJCOUxqVjd4cVkrQUEz?=
 =?utf-8?B?YUNYRXRjbEJUdnFtOUJFZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFBlajVCb3ZWdHpwa3FEMjlpMjk5ekxwM2ZrSTRrS0phTEtuY1RjTnZXbEJK?=
 =?utf-8?B?aURYakF2VDl6MEIyaTNDT2t0OE43M0pZSnZINGpnZ3dmSEk2ZEZBWnVaaE8v?=
 =?utf-8?B?MTNrTCtlL1h1S2FIcXNMRjg5eVExczVaRjBveFFpa3BNK3l5bTRlakZXWWZP?=
 =?utf-8?B?RlNhOHNXeDJ6KzVnR21ZUVFMU0NqWXp5WkVJUmR1b2lCcjdSQXRENVd6d3Nh?=
 =?utf-8?B?ZUtESUtMRmFuV0dFRmFCc0V1ajlDeEZpVkVkSmtPQU1oK2ZWcEZxTENDczJJ?=
 =?utf-8?B?ZDZJOXBCSllwOEZSU1VHWGt3YmFoV1c2SHRxYVplcWhKNDYrQ3BJbXpGd3Vj?=
 =?utf-8?B?bmFsZXVvbE9mMkJJTFM2aGhJN0FhTUFkclRHaHhPbkNaTGtTcitFam1Pa1pP?=
 =?utf-8?B?RGlFMGRUQ2xoSHFZQjlnVFBHend4Z3plTmFENXlHeWxORWxGb2FTOVpDdlUw?=
 =?utf-8?B?K09OK3NYekNvakRNUUxFRWlUZkY5SW85Kzd1KzhrazdIYVNWTjFPQk96bDNa?=
 =?utf-8?B?UVJ0V1YrNU5vVWRxYUFwMUZYQU5Gb0tpZmhyS2gxL0FIbTZFT0YwbjM2TVA1?=
 =?utf-8?B?RUdJNStjZWFLOFRTVzZBbXh1ZnU0MnY0eTRHcGFSRnh1Z3ZzbjlLWTRlb2Iy?=
 =?utf-8?B?VGxyaXRYN2cyY3E5UE92UklaMEhrdURsMnFRSTNnNXZEcEg3SUpHMkYxd3JW?=
 =?utf-8?B?RGNGWXVBcVZrVXM1ZTd0a2wvYi9TdjI4QXBDaG1hWkd2bS9vUENKM0hCaVFv?=
 =?utf-8?B?YS9DQW5CRG5Uc0IwdERJeDBlbkVEa2N2UlRmd0lBaG9wVWtVaVpHQm9MbzZ0?=
 =?utf-8?B?Y2tibFhGd0J6SWUreTFTSFVFTWtmQWNXYVZaM1dWV3ZLWDcxeDNsdjZ3RWhL?=
 =?utf-8?B?RTRaTzA0anFlUjhpc1hwOEI3OGV5dm5WVW8wNmZFQ05SdjZoeG1vckV3ZkhQ?=
 =?utf-8?B?bHA2N0thS3p6V2lST1NoM3ZzWmxGeVRxcUwwZTB3MjMrYnFSb1VsS2dORkxi?=
 =?utf-8?B?UWw2MldyNGp0djNCZTRINkdhZFEzOEJkaTNCaWtjK2lWOXdsL3VFRGVJczMv?=
 =?utf-8?B?NTl3V2JkK09laWo1N08vdENEMmZzcU9xK1RvNkkwdU4wcDJxdjlRYlVwRDl1?=
 =?utf-8?B?dFJZRnhYVmc3NUxOQVdQNW45NTN1L0lmM2szTWp5cjUyZm9KcmE5WkU1Qnk5?=
 =?utf-8?B?ZnVpZTdkOWxCUmc1OVNWeC9jS0Q1VDVaSit6VjZDRlNhK2RuLzRqbHJFM1k2?=
 =?utf-8?B?QzQyUUl6REdUU0FNcFVmOW56eUdPYzJtKzJ6WHZmNVlsd0VoMzdFTVpRK1ll?=
 =?utf-8?B?eE9FZ0lzRWRwK3kyS3FBbmFQNTFFSlhOZ3VEY25DQktXa3B0UGs4cWZvZGFW?=
 =?utf-8?B?WE41V3FXYjVIaytDT3RJb3BkUnFXT1cwd1ZOUHZESiswdjA3RURjaW5kWWZj?=
 =?utf-8?B?UFh4MkhPelpJbkxVaDlQWTd6UmN0UEpETU8vR3QwZ1NpSGVOVlUrTlc3Q1NN?=
 =?utf-8?B?eDRLZDNwYnlXUnZYdVAzTWR0YnR3Zk9KK2YxZ1ZGUGFpL2ZvaHJHRFhCNFU5?=
 =?utf-8?B?RGZZcDhrd0JOckpZMVNQY1JVcXlkZmdqdHZ4blFWNGhyWlRDYmxaNE8zUmRo?=
 =?utf-8?B?WU9Na2s4eXJRRTJvUlNXZmhXeWx2VHRwaHpRUXFPMTBjVWNyVHl0TkdWZnhS?=
 =?utf-8?B?SC84RnhJSktNcE9DNmFJZjNFSDhtM0VPS2RKVzJHV1ZCMVdmYkFybEMvdGZV?=
 =?utf-8?B?N1IzYzU4M2Z0TkxtMldiWld3czZVZlR2NEZwNUJRRVVFbU5FZGViRXNHeXB6?=
 =?utf-8?B?c3ZYcC85dzdCMGgvSUR4UDM5WFdwU3plTHpWTG8zNEk0TTl5R09VN1pmam9w?=
 =?utf-8?B?dFAySER3Z0pHcEtmaWRJZEdDelBuWU8rMC9CZkRwNEJESk8razBDdFNLbEZy?=
 =?utf-8?B?aHFIbnoyNE5MQjdGcTZLV1BhL1d1WWxhRDU5ek10aG1nNmd2eDFBZlo4T1Y0?=
 =?utf-8?B?TGZubmFrQzQyVDhpSkg0amVhWmVpUUplbzNwZzVwTi94ZEovQVdVOEJaeTNl?=
 =?utf-8?B?SFVUL2RlaHV1N2xuN3doT2NUelJpczczemZNNk1lU3V4TlR3ZXE4MzhxZFBN?=
 =?utf-8?B?U2JxTGFQVFA3QVBJemUzTGZwWkg5aUJILzVtaEg1UXA1bWpqelFLZjlzeFQy?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sF7TsR5OHsDWdu9R4B3Jh3wtxUYYET0OuJezOIo1ihYKAQid9T3tmNuV7t0VAy3JUZbIdRD2zkWT7z/itI4NmRvpE14ARfKQggqm75dM/KRt0fU3+Hs4mZHbL6L+ahAP9y24PSKCSJoQueioJDJ6IbsIAGbtvTkqaDW0DM4xqQU101X5SRyhoybP0k/6ykEHaoF0EZqLxKqf61jZqt8TuZfeVzMQBzxV/Mwlt89Q8SvLDlCUB/XelEdUtqJGpj+HltqKmctliMEnBMYvCPWUML//OzxNBh+Enz+vRtkcbsimhTAh1/KwNtaBqkErwLv5NtpkytlDXxtkLf827cCmp7lypQHyb1ecqZ8aeqmlkFzyGhgInJpJScNKQK5TizJVI5A5vlu4wgxLdIQ4RSFUXv2BgOVkOyX9UnRgEFCifPD+SQ8kQ5qxplxqY+/CN2Ti11I7wRUiiUIdr1Axh6apDeVn3bISq7OgUXBkdELla6jlJfOecuRm/ijH8NyR21fgKuiLQdKTecfHnl4Nei4WmDIwjy5H+tm2xEGWx3IB9IU1T1ISJ6UEkzOzEomt5ILsDVc533GQejOejgLN54p5qHe4oq0XMIC8/IjsQdCpYy0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5294721-fd2c-405d-6d71-08dd5dbb17d9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:00:29.8713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AolxiXwafTb3OY3SGI+VKIlSeWD9Q0xSwyvseAPY8O+l5jjoJ8FxH/dRxxT0ozZ7BN/5mzpfUMTvF5ccGhSArMWDMyyC6yHNG5DJvKFOdNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070158
X-Proofpoint-GUID: Ul9S14TbdHOvwc4t71G2x927HbnntvlZ
X-Proofpoint-ORIG-GUID: Ul9S14TbdHOvwc4t71G2x927HbnntvlZ
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

see
https://lore.kernel.org/qemu-devel/1741380954-341079-1-git-send-email-steven.sistare@oracle.com/

- Steve

On 3/6/2025 11:13 AM, Steven Sistare wrote:
> On 3/6/2025 10:52 AM, Denis V. Lunev wrote:
>> On 3/6/25 16:16, Andrey Drobyshev wrote:
>>> On 3/5/25 11:19 PM, Steven Sistare wrote:
>>>> On 3/5/2025 11:50 AM, Andrey Drobyshev wrote:
>>>>> On 3/4/25 9:05 PM, Steven Sistare wrote:
>>>>>> On 2/28/2025 1:37 PM, Andrey Drobyshev wrote:
>>>>>>> On 2/28/25 8:35 PM, Andrey Drobyshev wrote:
>>>>>>>> On 2/28/25 8:20 PM, Steven Sistare wrote:
>>>>>>>>> On 2/28/2025 1:13 PM, Steven Sistare wrote:
>>>>>>>>>> On 2/28/2025 12:39 PM, Andrey Drobyshev wrote:
>>>>>>>>>>> Hi all,
>>>>>>>>>>>
>>>>>>>>>>> We've been experimenting with cpr-transfer migration mode recently
>>>>>>>>>>> and
>>>>>>>>>>> have discovered the following issue with the guest QXL driver:
>>>>>>>>>>>
>>>>>>>>>>> Run migration source:
>>>>>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>>>>>> ROOTFS=/path/to/image
>>>>>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>>>>>
>>>>>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>>>>>         -machine q35 \
>>>>>>>>>>>>         -cpu host -smp 2 -m 2G \
>>>>>>>>>>>>         -object memory-backend-file,id=ram0,size=2G,mem-path=/
>>>>>>>>>>>> dev/shm/
>>>>>>>>>>>> ram0,share=on\
>>>>>>>>>>>>         -machine memory-backend=ram0 \
>>>>>>>>>>>>         -machine aux-ram-share=on \
>>>>>>>>>>>>         -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>>>>>         -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>>>>>         -nographic \
>>>>>>>>>>>>         -device qxl-vga
>>>>>>>>>>> Run migration target:
>>>>>>>>>>>> EMULATOR=/path/to/emulator
>>>>>>>>>>>> ROOTFS=/path/to/image
>>>>>>>>>>>> QMPSOCK=/var/run/alma8qmp-dst.sock
>>>>>>>>>>>> $EMULATOR -enable-kvm \
>>>>>>>>>>>>         -machine q35 \
>>>>>>>>>>>>         -cpu host -smp 2 -m 2G \
>>>>>>>>>>>>         -object memory-backend-file,id=ram0,size=2G,mem-path=/
>>>>>>>>>>>> dev/shm/
>>>>>>>>>>>> ram0,share=on\
>>>>>>>>>>>>         -machine memory-backend=ram0 \
>>>>>>>>>>>>         -machine aux-ram-share=on \
>>>>>>>>>>>>         -drive file=$ROOTFS,media=disk,if=virtio \
>>>>>>>>>>>>         -qmp unix:$QMPSOCK,server=on,wait=off \
>>>>>>>>>>>>         -nographic \
>>>>>>>>>>>>         -device qxl-vga \
>>>>>>>>>>>>         -incoming tcp:0:44444 \
>>>>>>>>>>>>         -incoming '{"channel-type": "cpr", "addr": { "transport":
>>>>>>>>>>>> "socket", "type": "unix", "path": "/var/run/alma8cpr-dst.sock"}}'
>>>>>>>>>>>
>>>>>>>>>>> Launch the migration:
>>>>>>>>>>>> QMPSHELL=/root/src/qemu/master/scripts/qmp/qmp-shell
>>>>>>>>>>>> QMPSOCK=/var/run/alma8qmp-src.sock
>>>>>>>>>>>>
>>>>>>>>>>>> $QMPSHELL -p $QMPSOCK <<EOF
>>>>>>>>>>>>         migrate-set-parameters mode=cpr-transfer
>>>>>>>>>>>>         migrate channels=[{"channel-type":"main","addr":
>>>>>>>>>>>> {"transport":"socket","type":"inet","host":"0","port":"44444"}},
>>>>>>>>>>>> {"channel-type":"cpr","addr":
>>>>>>>>>>>> {"transport":"socket","type":"unix","path":"/var/run/alma8cpr-
>>>>>>>>>>>> dst.sock"}}]
>>>>>>>>>>>> EOF
>>>>>>>>>>> Then, after a while, QXL guest driver on target crashes spewing the
>>>>>>>>>>> following messages:
>>>>>>>>>>>> [   73.962002] [TTM] Buffer eviction failed
>>>>>>>>>>>> [   73.962072] qxl 0000:00:02.0: object_init failed for (3149824,
>>>>>>>>>>>> 0x00000001)
>>>>>>>>>>>> [   73.962081] [drm:qxl_alloc_bo_reserved [qxl]] *ERROR* failed to
>>>>>>>>>>>> allocate VRAM BO
>>>>>>>>>>> That seems to be a known kernel QXL driver bug:
>>>>>>>>>>>
>>>>>>>>>>> https://lore.kernel.org/all/20220907094423.93581-1-
>>>>>>>>>>> min_halo@163.com/T/
>>>>>>>>>>> https://lore.kernel.org/lkml/ZTgydqRlK6WX_b29@eldamar.lan/
>>>>>>>>>>>
>>>>>>>>>>> (the latter discussion contains that reproduce script which
>>>>>>>>>>> speeds up
>>>>>>>>>>> the crash in the guest):
>>>>>>>>>>>> #!/bin/bash
>>>>>>>>>>>>
>>>>>>>>>>>> chvt 3
>>>>>>>>>>>>
>>>>>>>>>>>> for j in $(seq 80); do
>>>>>>>>>>>>             echo "$(date) starting round $j"
>>>>>>>>>>>>             if [ "$(journalctl --boot | grep "failed to allocate
>>>>>>>>>>>> VRAM
>>>>>>>>>>>> BO")" != "" ]; then
>>>>>>>>>>>>                     echo "bug was reproduced after $j tries"
>>>>>>>>>>>>                     exit 1
>>>>>>>>>>>>             fi
>>>>>>>>>>>>             for i in $(seq 100); do
>>>>>>>>>>>>                     dmesg > /dev/tty3
>>>>>>>>>>>>             done
>>>>>>>>>>>> done
>>>>>>>>>>>>
>>>>>>>>>>>> echo "bug could not be reproduced"
>>>>>>>>>>>> exit 0
>>>>>>>>>>> The bug itself seems to remain unfixed, as I was able to reproduce
>>>>>>>>>>> that
>>>>>>>>>>> with Fedora 41 guest, as well as AlmaLinux 8 guest. However our
>>>>>>>>>>> cpr-transfer code also seems to be buggy as it triggers the crash -
>>>>>>>>>>> without the cpr-transfer migration the above reproduce doesn't
>>>>>>>>>>> lead to
>>>>>>>>>>> crash on the source VM.
>>>>>>>>>>>
>>>>>>>>>>> I suspect that, as cpr-transfer doesn't migrate the guest
>>>>>>>>>>> memory, but
>>>>>>>>>>> rather passes it through the memory backend object, our code might
>>>>>>>>>>> somehow corrupt the VRAM.  However, I wasn't able to trace the
>>>>>>>>>>> corruption so far.
>>>>>>>>>>>
>>>>>>>>>>> Could somebody help the investigation and take a look into
>>>>>>>>>>> this?  Any
>>>>>>>>>>> suggestions would be appreciated.  Thanks!
>>>>>>>>>> Possibly some memory region created by qxl is not being preserved.
>>>>>>>>>> Try adding these traces to see what is preserved:
>>>>>>>>>>
>>>>>>>>>> -trace enable='*cpr*'
>>>>>>>>>> -trace enable='*ram_alloc*'
>>>>>>>>> Also try adding this patch to see if it flags any ram blocks as not
>>>>>>>>> compatible with cpr.  A message is printed at migration start time.
>>>>>>>>>      https://lore.kernel.org/qemu-devel/1740667681-257312-1-git-send-
>>>>>>>>> email-
>>>>>>>>> steven.sistare@oracle.com/
>>>>>>>>>
>>>>>>>>> - Steve
>>>>>>>>>
>>>>>>>> With the traces enabled + the "migration: ram block cpr blockers"
>>>>>>>> patch
>>>>>>>> applied:
>>>>>>>>
>>>>>>>> Source:
>>>>>>>>> cpr_find_fd pc.bios, id 0 returns -1
>>>>>>>>> cpr_save_fd pc.bios, id 0, fd 22
>>>>>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 22 host
>>>>>>>>> 0x7fec18e00000
>>>>>>>>> cpr_find_fd pc.rom, id 0 returns -1
>>>>>>>>> cpr_save_fd pc.rom, id 0, fd 23
>>>>>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 23 host
>>>>>>>>> 0x7fec18c00000
>>>>>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns -1
>>>>>>>>> cpr_save_fd 0000:00:01.0/e1000e.rom, id 0, fd 24
>>>>>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>>>>>> 262144 fd 24 host 0x7fec18a00000
>>>>>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
>>>>>>>>> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 25
>>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>>>>>> 67108864 fd 25 host 0x7feb77e00000
>>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns -1
>>>>>>>>> cpr_save_fd 0000:00:02.0/qxl.vrom, id 0, fd 27
>>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>>>>>> fd 27 host 0x7fec18800000
>>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns -1
>>>>>>>>> cpr_save_fd 0000:00:02.0/qxl.vram, id 0, fd 28
>>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>>>>>> 67108864 fd 28 host 0x7feb73c00000
>>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns -1
>>>>>>>>> cpr_save_fd 0000:00:02.0/qxl.rom, id 0, fd 34
>>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>>>>>> fd 34 host 0x7fec18600000
>>>>>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
>>>>>>>>> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 35
>>>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>>>>>> 2097152 fd 35 host 0x7fec18200000
>>>>>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
>>>>>>>>> cpr_save_fd /rom@etc/table-loader, id 0, fd 36
>>>>>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>>>>>> fd 36 host 0x7feb8b600000
>>>>>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
>>>>>>>>> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 37
>>>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>>>>>> 37 host 0x7feb8b400000
>>>>>>>>>
>>>>>>>>> cpr_state_save cpr-transfer mode
>>>>>>>>> cpr_transfer_output /var/run/alma8cpr-dst.sock
>>>>>>>> Target:
>>>>>>>>> cpr_transfer_input /var/run/alma8cpr-dst.sock
>>>>>>>>> cpr_state_load cpr-transfer mode
>>>>>>>>> cpr_find_fd pc.bios, id 0 returns 20
>>>>>>>>> qemu_ram_alloc_shared pc.bios size 262144 max_size 262144 fd 20 host
>>>>>>>>> 0x7fcdc9800000
>>>>>>>>> cpr_find_fd pc.rom, id 0 returns 19
>>>>>>>>> qemu_ram_alloc_shared pc.rom size 131072 max_size 131072 fd 19 host
>>>>>>>>> 0x7fcdc9600000
>>>>>>>>> cpr_find_fd 0000:00:01.0/e1000e.rom, id 0 returns 18
>>>>>>>>> qemu_ram_alloc_shared 0000:00:01.0/e1000e.rom size 262144 max_size
>>>>>>>>> 262144 fd 18 host 0x7fcdc9400000
>>>>>>>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 17
>>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/vga.vram size 67108864 max_size
>>>>>>>>> 67108864 fd 17 host 0x7fcd27e00000
>>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vrom, id 0 returns 16
>>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vrom size 8192 max_size 8192
>>>>>>>>> fd 16 host 0x7fcdc9200000
>>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.vram, id 0 returns 15
>>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.vram size 67108864 max_size
>>>>>>>>> 67108864 fd 15 host 0x7fcd23c00000
>>>>>>>>> cpr_find_fd 0000:00:02.0/qxl.rom, id 0 returns 14
>>>>>>>>> qemu_ram_alloc_shared 0000:00:02.0/qxl.rom size 65536 max_size 65536
>>>>>>>>> fd 14 host 0x7fcdc8800000
>>>>>>>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 13
>>>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/tables size 131072 max_size
>>>>>>>>> 2097152 fd 13 host 0x7fcdc8400000
>>>>>>>>> cpr_find_fd /rom@etc/table-loader, id 0 returns 11
>>>>>>>>> qemu_ram_alloc_shared /rom@etc/table-loader size 4096 max_size 65536
>>>>>>>>> fd 11 host 0x7fcdc8200000
>>>>>>>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 10
>>>>>>>>> qemu_ram_alloc_shared /rom@etc/acpi/rsdp size 4096 max_size 4096 fd
>>>>>>>>> 10 host 0x7fcd3be00000
>>>>>>>> Looks like both vga.vram and qxl.vram are being preserved (with the
>>>>>>>> same
>>>>>>>> addresses), and no incompatible ram blocks are found during migration.
>>>>>>> Sorry, addressed are not the same, of course.  However corresponding
>>>>>>> ram
>>>>>>> blocks do seem to be preserved and initialized.
>>>>>> So far, I have not reproduced the guest driver failure.
>>>>>>
>>>>>> However, I have isolated places where new QEMU improperly writes to
>>>>>> the qxl memory regions prior to starting the guest, by mmap'ing them
>>>>>> readonly after cpr:
>>>>>>
>>>>>>     qemu_ram_alloc_internal()
>>>>>>       if (reused && (strstr(name, "qxl") || strstr("name", "vga")))
>>>>>>           ram_flags |= RAM_READONLY;
>>>>>>       new_block = qemu_ram_alloc_from_fd(...)
>>>>>>
>>>>>> I have attached a draft fix; try it and let me know.
>>>>>> My console window looks fine before and after cpr, using
>>>>>> -vnc $hostip:0 -vga qxl
>>>>>>
>>>>>> - Steve
>>>>> Regarding the reproduce: when I launch the buggy version with the same
>>>>> options as you, i.e. "-vnc 0.0.0.0:$port -vga qxl", and do cpr-transfer,
>>>>> my VNC client silently hangs on the target after a while.  Could it
>>>>> happen on your stand as well?
>>>> cpr does not preserve the vnc connection and session.  To test, I specify
>>>> port 0 for the source VM and port 1 for the dest.  When the src vnc goes
>>>> dormant the dest vnc becomes active.
>>>>
>>> Sure, I meant that VNC on the dest (on the port 1) works for a while
>>> after the migration and then hangs, apparently after the guest QXL crash.
>>>
>>>>> Could you try launching VM with
>>>>> "-nographic -device qxl-vga"?  That way VM's serial console is given you
>>>>> directly in the shell, so when qxl driver crashes you're still able to
>>>>> inspect the kernel messages.
>>>> I have been running like that, but have not reproduced the qxl driver
>>>> crash,
>>>> and I suspect my guest image+kernel is too old.
>>> Yes, that's probably the case.  But the crash occurs on my Fedora 41
>>> guest with the 6.11.5-300.fc41.x86_64 kernel, so newer kernels seem to
>>> be buggy.
>>>
>>>
>>>> However, once I realized the
>>>> issue was post-cpr modification of qxl memory, I switched my attention
>>>> to the
>>>> fix.
>>>>
>>>>> As for your patch, I can report that it doesn't resolve the issue as it
>>>>> is.  But I was able to track down another possible memory corruption
>>>>> using your approach with readonly mmap'ing:
>>>>>
>>>>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>>>>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>>>>>> 412         d->ram->magic       = cpu_to_le32(QXL_RAM_MAGIC);
>>>>>> [Current thread is 1 (Thread 0x7f1a4f83b480 (LWP 229798))]
>>>>>> (gdb) bt
>>>>>> #0  init_qxl_ram (d=0x5638996e0e70) at ../hw/display/qxl.c:412
>>>>>> #1  0x0000563896e7f467 in qxl_realize_common (qxl=0x5638996e0e70,
>>>>>> errp=0x7ffd3c2b8170) at ../hw/display/qxl.c:2142
>>>>>> #2  0x0000563896e7fda1 in qxl_realize_primary (dev=0x5638996e0e70,
>>>>>> errp=0x7ffd3c2b81d0) at ../hw/display/qxl.c:2257
>>>>>> #3  0x0000563896c7e8f2 in pci_qdev_realize (qdev=0x5638996e0e70,
>>>>>> errp=0x7ffd3c2b8250) at ../hw/pci/pci.c:2174
>>>>>> #4  0x00005638970eb54b in device_set_realized (obj=0x5638996e0e70,
>>>>>> value=true, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:494
>>>>>> #5  0x00005638970f5e14 in property_set_bool (obj=0x5638996e0e70,
>>>>>> v=0x5638996f3770, name=0x56389759b141 "realized",
>>>>>> opaque=0x5638987893d0, errp=0x7ffd3c2b84e0)
>>>>>>       at ../qom/object.c:2374
>>>>>> #6  0x00005638970f39f8 in object_property_set (obj=0x5638996e0e70,
>>>>>> name=0x56389759b141 "realized", v=0x5638996f3770, errp=0x7ffd3c2b84e0)
>>>>>>       at ../qom/object.c:1449
>>>>>> #7  0x00005638970f8586 in object_property_set_qobject
>>>>>> (obj=0x5638996e0e70, name=0x56389759b141 "realized",
>>>>>> value=0x5638996df900, errp=0x7ffd3c2b84e0)
>>>>>>       at ../qom/qom-qobject.c:28
>>>>>> #8  0x00005638970f3d8d in object_property_set_bool
>>>>>> (obj=0x5638996e0e70, name=0x56389759b141 "realized", value=true,
>>>>>> errp=0x7ffd3c2b84e0)
>>>>>>       at ../qom/object.c:1519
>>>>>> #9  0x00005638970eacb0 in qdev_realize (dev=0x5638996e0e70,
>>>>>> bus=0x563898cf3c20, errp=0x7ffd3c2b84e0) at ../hw/core/qdev.c:276
>>>>>> #10 0x0000563896dba675 in qdev_device_add_from_qdict
>>>>>> (opts=0x5638996dfe50, from_json=false, errp=0x7ffd3c2b84e0) at ../
>>>>>> system/qdev-monitor.c:714
>>>>>> #11 0x0000563896dba721 in qdev_device_add (opts=0x563898786150,
>>>>>> errp=0x56389855dc40 <error_fatal>) at ../system/qdev-monitor.c:733
>>>>>> #12 0x0000563896dc48f1 in device_init_func (opaque=0x0,
>>>>>> opts=0x563898786150, errp=0x56389855dc40 <error_fatal>) at ../system/
>>>>>> vl.c:1207
>>>>>> #13 0x000056389737a6cc in qemu_opts_foreach
>>>>>>       (list=0x563898427b60 <qemu_device_opts>, func=0x563896dc48ca
>>>>>> <device_init_func>, opaque=0x0, errp=0x56389855dc40 <error_fatal>)
>>>>>>       at ../util/qemu-option.c:1135
>>>>>> #14 0x0000563896dc89b5 in qemu_create_cli_devices () at ../system/
>>>>>> vl.c:2745
>>>>>> #15 0x0000563896dc8c00 in qmp_x_exit_preconfig (errp=0x56389855dc40
>>>>>> <error_fatal>) at ../system/vl.c:2806
>>>>>> #16 0x0000563896dcb5de in qemu_init (argc=33, argv=0x7ffd3c2b8948)
>>>>>> at ../system/vl.c:3838
>>>>>> #17 0x0000563897297323 in main (argc=33, argv=0x7ffd3c2b8948) at ../
>>>>>> system/main.c:72
>>>>> So the attached adjusted version of your patch does seem to help.  At
>>>>> least I can't reproduce the crash on my stand.
>>>> Thanks for the stack trace; the calls to SPICE_RING_INIT in init_qxl_ram
>>>> are
>>>> definitely harmful.  Try V2 of the patch, attached, which skips the lines
>>>> of init_qxl_ram that modify guest memory.
>>>>
>>> Thanks, your v2 patch does seem to prevent the crash.  Would you re-send
>>> it to the list as a proper fix?
> 
> Yes.  Was waiting for your confirmation.
> 
>>>>> I'm wondering, could it be useful to explicitly mark all the reused
>>>>> memory regions readonly upon cpr-transfer, and then make them writable
>>>>> back again after the migration is done?  That way we will be segfaulting
>>>>> early on instead of debugging tricky memory corruptions.
>>>> It's a useful debugging technique, but changing protection on a large
>>>> memory region
>>>> can be too expensive for production due to TLB shootdowns.
>>>>
>>>> Also, there are cases where writes are performed but the value is
>>>> guaranteed to
>>>> be the same:
>>>>    qxl_post_load()
>>>>      qxl_set_mode()
>>>>        d->rom->mode = cpu_to_le32(modenr);
>>>> The value is the same because mode and shadow_rom.mode were passed in
>>>> vmstate
>>>> from old qemu.
>>>>
>>> There're also cases where devices' ROM might be re-initialized.  E.g.
>>> this segfault occures upon further exploration of RO mapped RAM blocks:
>>>
>>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>>> #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:664
>>>> 664             rep     movsb
>>>> [Current thread is 1 (Thread 0x7f6e7d08b480 (LWP 310379))]
>>>> (gdb) bt
>>>> #0  __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:664
>>>> #1  0x000055aa1d030ecd in rom_set_mr (rom=0x55aa200ba380, owner=0x55aa2019ac10, name=0x7fffb8272bc0 "/rom@etc/acpi/tables", ro=true)
>>>>      at ../hw/core/loader.c:1032
>>>> #2  0x000055aa1d031577 in rom_add_blob
>>>>      (name=0x55aa1da51f13 "etc/acpi/tables", blob=0x55aa208a1070, len=131072, max_len=2097152, addr=18446744073709551615, fw_file_name=0x55aa1da51f13 "etc/acpi/tables", fw_callback=0x55aa1d441f59 <acpi_build_update>, callback_opaque=0x55aa20ff0010, as=0x0, read_only=true) at ../hw/core/loader.c:1147
>>>> #3  0x000055aa1cfd788d in acpi_add_rom_blob
>>>>      (update=0x55aa1d441f59 <acpi_build_update>, opaque=0x55aa20ff0010, blob=0x55aa1fc9aa00, name=0x55aa1da51f13 "etc/acpi/tables") at ../hw/acpi/utils.c:46
>>>> #4  0x000055aa1d44213f in acpi_setup () at ../hw/i386/acpi-build.c:2720
>>>> #5  0x000055aa1d434199 in pc_machine_done (notifier=0x55aa1ff15050, data=0x0) at ../hw/i386/pc.c:638
>>>> #6  0x000055aa1d876845 in notifier_list_notify (list=0x55aa1ea25c10 <machine_init_done_notifiers>, data=0x0) at ../util/notify.c:39
>>>> #7  0x000055aa1d039ee5 in qdev_machine_creation_done () at ../hw/core/machine.c:1749
>>>> #8  0x000055aa1d2c7b3e in qemu_machine_creation_done (errp=0x55aa1ea5cc40 <error_fatal>) at ../system/vl.c:2779
>>>> #9  0x000055aa1d2c7c7d in qmp_x_exit_preconfig (errp=0x55aa1ea5cc40 <error_fatal>) at ../system/vl.c:2807
>>>> #10 0x000055aa1d2ca64f in qemu_init (argc=35, argv=0x7fffb82730e8) at ../system/vl.c:3838
>>>> #11 0x000055aa1d79638c in main (argc=35, argv=0x7fffb82730e8) at ../system/main.c:72
>>> I'm not sure whether ACPI tables ROM in particular is rewritten with the
>>> same content, but there might be cases where ROM can be read from file
>>> system upon initialization.  That is undesirable as guest kernel
>>> certainly won't be too happy about sudden change of the device's ROM
>>> content.
>>>
>>> So the issue we're dealing with here is any unwanted memory related
>>> device initialization upon cpr.
>>>
>>> For now the only thing that comes to my mind is to make a test where we
>>> put as many devices as we can into a VM, make ram blocks RO upon cpr
>>> (and remap them as RW later after migration is done, if needed), and
>>> catch any unwanted memory violations.  As Den suggested, we might
>>> consider adding that behaviour as a separate non-default option (or
>>> "migrate" command flag specific to cpr-transfer), which would only be
>>> used in the testing.
> 
> I'll look into adding an option, but there may be too many false positives,
> such as the qxl_set_mode case above.  And the maintainers may object to me
> eliminating the false positives by adding more CPR_IN tests, due to gratuitous
> (from their POV) ugliness.
> 
> But I will use the technique to look for more write violations.
> 
>>> Andrey
>> No way. ACPI with the source must be used in the same way as BIOSes
>> and optional ROMs.
> 
> Yup, its a bug.  Will fix.
> 
> - Steve



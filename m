Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12F1CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 19:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v42BE-0000NR-J0; Wed, 01 Oct 2025 15:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v42B5-0000Lw-C3
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 15:07:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v42Av-0002yy-FW
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 15:07:51 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591I0n0a022814;
 Wed, 1 Oct 2025 19:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=waThX040WVIee6jkoWIblfGs4OlrXKg+D7NKmaEzfQ4=; b=
 HiXQNRIABiS1p7Vp0pSb4EcDSZzsX9fZ0KNm0ugzac4InmTDqCZHZoMRKLj9Ut80
 fw+xJqN4O87z0DbCkSqmAORObLDZFmqm3KC5uDo/9bbFqpNIGkFsNT7sqUlLtec0
 v7C7JRLGV9ET7gLZYYw1pPenj8vvWVWTGNhi+1JKtyeHOc2hGOTr06CvYKCa3iWO
 lN9c+zmKFOWONRoW9XWLjaWQEDha0tOPuwukSysPwbf8zhw7QLUzTCMXK9dwjrF4
 7UZtRfrb8uM8CkdZkwS43GCJz5GGdRsfn3/IdDv7vACbhv8bAFzSjzWHdAEeQM0b
 VjFV1WK9h3ejK0lFAyYoBA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gkxnj3t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 19:07:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591IpixH012316; Wed, 1 Oct 2025 19:07:32 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c9kafq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 19:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFJotOpMHuqZFNNJyPQYZEQUF2iq/t29tzg4w+ZAGk1psaw0ah0+WjonVci8EvhCrMl/Knddake04AVdoHApv2HRCMHj89CbFMYd/4cccGjit9i0hrcG7qa1LQseJxXNDOSfwqnTpMfOtDurDwv9kkQH/Wj9359i12dsMEaoK+C7NOaebNC8lFP4eJfRaQnwBJ76EO6WvTv/L2sX0OT5AacTidhGrXTJOUg6olK2qudgbvVWd/eGOglb5OX5q+2t8coI2A2y84Zwk4xOYrZE9EyHPlkyGZCDiZNT9Z7zBG7H9+DY/l7Orm2FIQBGQ3wkhpfVU45cHfN2ZtnV3FbYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waThX040WVIee6jkoWIblfGs4OlrXKg+D7NKmaEzfQ4=;
 b=j1vKTBayu05e7PSCcSr9a70Td2VjdAqWkUqwvdUi53AcmyZM6AMqEsBkjMvcnZGj5QTR02qPefsjWUPFffep5q1QKv/1qWMxcnaNcipfA87nFL2PJnkoQeFkjDhvtJdSC5CVsC4ZUIotfAK1Abz0KOC4mllMN48rGdcn6HyEznb/AGQVGqGZIUHm69ec90+7KdbU/uO6m1E6fL3j1KbbESz4CTmrGd3wJVnaRAIzH2J4AxQSiCMf9OhdhRYXjQjIvo3/skwvpCi45Vd4CrPOsUvoqFLxc7OMZqr+FTvTZQHBZRIwmwC3zaHJ//P7tTGtXxUsm+VbB9xj9aXApU1ZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waThX040WVIee6jkoWIblfGs4OlrXKg+D7NKmaEzfQ4=;
 b=T45a84bEfHL/TNrAjtpnRzarqeFPZCb/StWWd9Y+mGUaAHIPChPIwsU1ODYmvSyPVAiYz/mmXn1r2h+75L00TJXz1Uq0KBoZYI/e6h6ooVLwUHj3PVfbCnbSMhPmTeFSoagqijSRYV/kfuh2x3vZIzIYGIR2lZZMZR/fbc8KO74=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ5PPF8CB762A0C.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7b7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 1 Oct
 2025 19:07:27 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 19:07:27 +0000
Message-ID: <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
Date: Wed, 1 Oct 2025 15:07:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aN15cNEwH4HBt7NU@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ5PPF8CB762A0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 99459a62-f191-4cb5-c7a6-08de011dc2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlJhSFdzRGdWWU9uSzAzS2RuaUxnQ0MrR1BTSExKK0p6ckwxZ2lYMEd0eTU3?=
 =?utf-8?B?aSsrb1FKNkVDNFFNWUtZYVZvQUVISnlWSDl1U2JBTFJsSFJRREllV0dsNXA0?=
 =?utf-8?B?VlNFYWk5MFFIUERRVjdBYkNOdWtwbWZPdGtXQnpZWXNaLzIwdHFMK1EvL2x3?=
 =?utf-8?B?T2IyY2NzZVJTZU5FN1BLdzA1Nlh6cTAxYkQ2bVJlVDZxNlB2VytSNGdDWlRv?=
 =?utf-8?B?YmhadEhVeVVHWDVtekUxZytQZlNROXgxRHRJa2dydm9SZ0t3SUtYT29YVDVh?=
 =?utf-8?B?dldvWU81WE1MZ1h0RkFtTFk3VWJHc203SjUwMktnQzZER05nWlc5Yjk0NGVK?=
 =?utf-8?B?aFVKRGlsTks2Z1VNbEJGWW1jVi9ISUFjZ2dsaFhjc0VzN1VleHZzL0dYSTdj?=
 =?utf-8?B?cHorV3IvS2p3cmxQdWxxWFVpUHB6UE9WQnVNejFvd3MrQXc3RTdpR1Z1bGdY?=
 =?utf-8?B?VkVPNytQOXNlVTdZelJxcWdIcXJTT2U1MjhUeXRlTWg4RE9BT3Q0UmovdVJ2?=
 =?utf-8?B?bUlPS0xvM0Y4Z0lXYjNhN2dNaGpYS0NuUjA0TzBuWnA3alFCYSs4d090Si9n?=
 =?utf-8?B?UzZEZWh0aGJacjdLcFYrMVNpK0ZtTXBjK2MzRG9zdndwNFpyZThvbWh1MEVN?=
 =?utf-8?B?dElxUUZ6SDVjbncwOG1XeWFYZGlySlZFMWhTZEVXUkVNeVZtaDZZVCtDTEkz?=
 =?utf-8?B?bEZWRURqbVRGOGs1NWpFWkpFZGxOK1ZEVGpKb2luamFTMnFCdWxhMlpXeXJ3?=
 =?utf-8?B?M2tPRjA3MUlJYVhXa3hVWFQ4NjB0aHZhVUFoMWI4eEFxMWJsSFlYcFA3UUxa?=
 =?utf-8?B?U05VM1FMaVdhYkpKckpZQUtTMTFJSWplVkhHUUhKMVp1U2YwSGNxdGpqRGNF?=
 =?utf-8?B?bHhJZ0JNL001ZTRQMktaUXNDZkRZa0VTUml6U05KcW1TaDhrTitFUzkwZXFv?=
 =?utf-8?B?QjcxcEdqVENKTHo5ZHFRSzBWcmNVV3NzNUpqbC8rRlpXUWlncFNVODNidWkv?=
 =?utf-8?B?NnN5eEZkNW95eGZkTFNZSHQvT2tKZkxPR1R0Yi9TMS9BY3VEUTcwTnJjSndN?=
 =?utf-8?B?SmNJVjd1eFZPTkZsSzJJSGJDSEFKbzBuVG1wNmNERWF4Mk9jd2VEUHR2Y2RU?=
 =?utf-8?B?WGZyK2tyZDZjY1pTU2R4c2JsU054OEI5dDlreHVmMlFYS0t5Q3R2M0NVMUY4?=
 =?utf-8?B?NVh3bG5qVHppMEdrWFNsNWhodTIxSnE4S09EeFRSSkV3aWd2WTBlQXFsTGQx?=
 =?utf-8?B?ajd3RitOZ2F6ekg4ZHRmQ1YrMlVmcGR3azVKeDhYcVIzRW5ZU0cxWlB1MXN0?=
 =?utf-8?B?N2swTm9rTHFiK0xjcC95WU95Y1Z0dytQbkpVK2gwMkhFdGxhbE43d2R2ay9H?=
 =?utf-8?B?b2JlUlBMVFZ0UFhGbUhtOEF2azFuOUYxbkUxTkN2SmM3bHl2aEVGemVCelFC?=
 =?utf-8?B?QWxLOTlxMzhlbGFKSU5kTlh5S2VHTnpKU3l4djdEU3ZIQk92aUxIWDcrcTlr?=
 =?utf-8?B?N0Y0dU5TcFVTQ0FLVDBnQktaSGRkZ2ZidU5LWjI3SlNqSEtzN3I4RzdjZnVm?=
 =?utf-8?B?d3E2bk1YZFhmOWZLQzZpSFZlYnJzL0U0ajFENDhQM2JaaTN5VlNtampuTnVN?=
 =?utf-8?B?eHFiQlA0K1JmV25RS0h4YmwxQkhodnZBUk5aMFdRa3VTNFhoaXFUbEY3eThM?=
 =?utf-8?B?WkJjZUN2ZDJ3M2dkcGNnTC93RGpUN0s3TG1mZnhJYnNGeXJVQmNOQjVjSGp1?=
 =?utf-8?B?eWVjSjc3VGt0N0ZhTHF3aEpMeW55NXpabzhYalJOcE0yZmlXbXNaaEhma09E?=
 =?utf-8?B?K3I3bCtXbHgzVm9abHk4d1hmV0VyZ0kvQXIwajVvZFhscGNTR2pDcmc3V2s5?=
 =?utf-8?B?dmxGQ0ZYRUVoVlBZakQ3dm9INXQ0MDVpWlQ3ZG1QQjlXQnh0c1BoM0FCTGZw?=
 =?utf-8?Q?JINAS80xqzll9kiaHxqmCHaz5WouZnly?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d25ia0dQYVQyYkdiYThWZGRWTUFSaFA3MkkyRlRsWExYVHlzd0EzREdDM29y?=
 =?utf-8?B?UU14dHFHc2hUSmNBWG9hb0dsZ09EN2VDdkN3endwRjhvMEJzdDRLa3hJbTB6?=
 =?utf-8?B?NXQ0ck15NkRZRHJsMi9KajMreExBeFo1aStTbXlaNE5UNGRvTFA3U3Y5c1d5?=
 =?utf-8?B?aFFlMXVudGNpYVN0YW44MGI5TEx2Uk9yeWJ0ZUhPL1h5clppajY5ZTQ1NnhH?=
 =?utf-8?B?VDNUczJWTmJNMnhMNHArTitFcDFnbzcvNkZYeStldzd0ampkNzlxUzB4VFdu?=
 =?utf-8?B?Q21jK2hpaExYRkhNS3Y0VlIzYVlIcWZoWkFEdzB4cm9NTy9rQXp4TlZweUJT?=
 =?utf-8?B?VFRZRThHMlRGbXBOZmxLVXlBZitaZ2wySlBSb1lzY1BVYW9UVjFZamI4SnFo?=
 =?utf-8?B?SmluSjVEU3BCaDRCZHZPbUQyZmVPcmdQUis0dkpsdmVsWTdqRUhIT0ErdFE2?=
 =?utf-8?B?ZE1mY3dKeDY5czdrWjg3UVp6ZWRxdmlyOHFtN2poc0cxWDVIYy9QWkRoVHFN?=
 =?utf-8?B?RVFKaGJVQkJaN0dNNFEyUUZ2blRQcjd5QzZOYnhDUWRhWHFDbUM4SHBJUVhP?=
 =?utf-8?B?ME1UejJ6ZXdXaFFQMUVPMlYzT0ZpOWMyaGRwSERrcm5heWx1OUo5U29KZEg5?=
 =?utf-8?B?ZHdPLzRyUzVCVWJMM2JGWlF3THhSbWRZbWFLYk0zNFp4WWJheG9ESFVDVGZ5?=
 =?utf-8?B?WEJ1Q1dEbUZPdzNPV2w2VmJSUE1Ld3BKQzNzZFExOVlSM0pFS0lCMEZDenp6?=
 =?utf-8?B?R2JUOHF3c3hUZTlZOFNGQjBMWjZzb1BGV0piZVBIWTdsQm1uZ3FPcWdFa2RL?=
 =?utf-8?B?QnU3Y1BpOTRkeVd6Vi9Eb0JLMnJSaXB5R2wxWC8vV0JBUjhYUzUvL2x1cXBn?=
 =?utf-8?B?VVpLTEVXTlFDSzFwekJhMlNMZmhQbWo4d1dmQlJHNDZ2UnRFY0RUdFpENVVk?=
 =?utf-8?B?SHFZTkpSNVE1MVBMUnBwQ3pIQlJOeE1FNVNSc1c5UHl5NmRMNjNzcFJjc09U?=
 =?utf-8?B?L05FNjVwSGJ1cTAvTDA5UkRFeFJQTzdHNnNNcGJKTS9mMCs0YUVtZmRsTG5P?=
 =?utf-8?B?RWxhK1A0UjFCSHFWQWNXcUtMNTdXQlZSYWdaN08xNS9BMzdpaWZJaWJoaGdC?=
 =?utf-8?B?emVSdXltaXpOVnhZd0VFWlZPb1V3MFl6akJYTWNBVVJQTzYxS1BMQ2k2b2t2?=
 =?utf-8?B?Y0FhK2t3dytjb1d3Rm9NZTBudENHNm5uaUppZUFNQVIyRi9kL3BtdXNOUndN?=
 =?utf-8?B?L2ZVMzh0UFhSdXkwRkN3MVZlZ2pLdjhuR1ZQSDdIWUZwR3AxYll1MjF6aUpY?=
 =?utf-8?B?WTNZVHUxTndKeVhWNnNWTklpU2FkSW5OOW5LWUU1cEFQTW1qN3Q3bm04WSsw?=
 =?utf-8?B?czJJaXVkMDdXbFN6UUZLd3VjMVk2dHY4S0xBQTdPakxlTUxJV0xLWkRPNHBY?=
 =?utf-8?B?RjdxRUwya2phVmlwZUxCeXlkSytCZWp2cll3OUoyT3Q1WVhJd0ZCaDhJNUVu?=
 =?utf-8?B?aDcvRTNTV1RVZkt0ekszMWlUdnNaZFBMMG1TdVpYZ0FnNU9YM25OTUUwVWVn?=
 =?utf-8?B?STBiMVpFQ0xvZEh3WXRDY2dGSXpxZUJyYUVRMmdpWDd4cGFWdlA2azhLY0FP?=
 =?utf-8?B?OXlldncycUJyZndWZGFIRnB6YVZnMy9zMzF3TXFxVWw5OUJoNjlRVndPTzBF?=
 =?utf-8?B?UFJXUStYOEJpN1pDRkM5c1I1c1M4RTdKb3RPZWNyM3hiVnhUVCtEOWdlWlZZ?=
 =?utf-8?B?NGRyUkFtSUNSOVpET0U0L0RSK2dMeGpjNWtHeXJXaTJrWHNUZjJNZXAvZHdz?=
 =?utf-8?B?dzQ5ZmpMQ3VEUHZEdXdBZmlyMEhlQTJDTzBQaXI2T2RSOTY5Wnp3NFo2cXhQ?=
 =?utf-8?B?OWl3c1JHQkhvNTBXNE9NL3Rwa1dTTU5LUDRxam1ubzZoR1ZheTFxdlEraGxS?=
 =?utf-8?B?ZjVjREIxczY4dklldDd2dFgwN3MzdTJvV0U5K0RCdjE3emJkT3NkNzk0cVpI?=
 =?utf-8?B?K0h4cGw5L0xzUEdlUVFGMTRxYVdJNHFMbjlJd0pva0oybU15TjRWcGxuSzdQ?=
 =?utf-8?B?MzFlZktVTWoyYzZxSnFzeDYzYUx1Y1lBQmg2U0hiNmoyMDhxTzNxTUxpbktp?=
 =?utf-8?B?SVlEd0VWZHdsdldkRXhmd0I4UzZtTjVBdkJCM0YvZW9ScUgySU9JeW1vRzds?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Bk9pW9E7eBCgXvLhwp305pjlQKQtNjY0pvP0mcNjfpmKqWnxIVsH9tQ0MYRQFx+rG4V0dFN/kenQ2aA1r3ra5v3YtSB6GJ185AuG8jBEMuUKuMZl1k2+EHBJUQFf4PndfrKSex/3WD2jV5uQ87rNAjS3LeiW/iaCfJcUTTTQJbKPaOjs2MJ4iOOu8XSdubnfRsdf4YsIfw76m7r5p4S9t3MMDi+bNOx/hfdKFGt2to50ZnZiNTRQq3+rnS7IvbhWu4CB6q89sz2ZGzhIL2UOSPFld1cvbiFIbXLCuWup3iKBynGRjdJK7zx+bOkNB7j+8Jkhz4z0ASDuPggfbGs6roACa11iCtLo7ajGfuS5Fdcsv16I/fFnufUNY7k/HM2h5ryzVMEis+9yonZMfJDGNKN2e5htmtuYbwkc6VZc7vYjs/pyXLDuHRaGGQtzPjvV1P0XQv9Zljy2L5Upbg391HnyXJJJF2054DEI5wal7sWltX/OloW8C4F7Mqrd56cF1pnQ70LC6JmF+MugnVNiWMQJGoT1qOzS9MF7E6VRGD7hGGb5p8jnxefSWh7uBsilcTzZX2fXwaKIZJrxC7l2vdXglyGWD3uFAQrF8Uy8L6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99459a62-f191-4cb5-c7a6-08de011dc2f6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 19:07:27.2230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sKTiET4ypysf/HQlqbnU1XEyklV8gq39o7VRuilFJYNhi4Q/7PG4wd0lO7n7gq09Mq4ONVt1AwNSiCAuPhoB/2OdcM0zj0vfwlrGEjozyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8CB762A0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010166
X-Proofpoint-GUID: xAsrPhYt2uUCMnfLYoLXjOl86rceb_w0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2MSBTYWx0ZWRfX7WCyExhYiZjx
 VJQWlsxy0vSqPJnPc27Sq96uXsvDD9AWxuEfoKJY4ZRF0Bv8FKpTdL35d3AA83gtNXreV+EAOTI
 totzGmrgLixrgSLIavVy9pxLB417snb7m9GD8vp0r8fj0b/E0ZPzReqqmprrPl/CP922hwLxYl2
 fpy1IdsJCZGNjtdPNkbLFBDWr4iciZUQvnHilJOtMShr6INb0/C2NAbwVY/cKNCdn+Z576j0nLd
 QWKyVR1utYkiptwS6aKl7HWP1msOwvtkPdTDCpvEANfwOJ9D8iELAg1gs1THPLi7k0iAO0HnN+b
 engF6RG+rhewfTJcmjZ/u/BHzhGwRp1G2zowKgJkAipmOkyt8f5FS0tvQgVGxQcTOvbWJUo0lnN
 6SZ4CRUb67RIqdWaVGTxyc1772Z9K9iv874+yH227446iF/PGvY=
X-Authority-Analysis: v=2.4 cv=RLW+3oi+ c=1 sm=1 tr=0 ts=68dd7bf4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=p0WdMEafAAAA:8 a=cg7ncOeShrgmAC_4XqMA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12090
X-Proofpoint-ORIG-GUID: xAsrPhYt2uUCMnfLYoLXjOl86rceb_w0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/1/2025 2:56 PM, Peter Xu wrote:
> On Wed, Oct 01, 2025 at 08:33:52AM -0700, Steve Sistare wrote:
>> This patch series adds the live migration cpr-exec mode.
>>
>> The new user-visible interfaces are:
>>    * cpr-exec (MigMode migration parameter)
>>    * cpr-exec-command (migration parameter)
>>
>> cpr-exec mode is similar in most respects to cpr-transfer mode, with the
>> primary difference being that old QEMU directly exec's new QEMU.  The user
>> specifies the command to exec new QEMU in the migration parameter
>> cpr-exec-command.
> 
> It turns out I was right where I replied to patch 5; this fails the Windows
> build.
> 
> Smallest fix is to wrap qemu_memfd_create() with a CONFIG_LINUX ifdef,
> returning -1 to mfd otherwise.

That does not make sense.  It already does that, which is why I used it:

util/memfd.c

int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
                       uint64_t hugetlbsize, unsigned int seals, Error **errp)
{
     ...
#ifdef CONFIG_LINUX
     ...
     return mfd;
#else
     error_setg_errno(errp, ENOSYS, "failed to create memfd");
#endif
     return -1;
}

Did the windows build fail due to a different error?

> A better one is we only include cpr*.c in meson.build if it's linux.
> Personally I'm OK if we go with the smaller one as of now, however then it
> would definitely be nice to have a follow up series to reach the better
> solution, if that makes sense.
> 
> Feel free to use "make docker-test-build@fedora-win64-cross" for verifying
> the changes.  I hope it'll work for you, even if for me currently it didn't
> work due to a gitlab.com dns resolution pulling dtc src, where I didn't dig
> deeper yet..
> 
> The other thing is, this series doesn't apply on master branch.  I didn't
> feel confident to do it myself on the vfio change, please have a look on
> both issues.
Ugh, they renamed everything.  I will rebase and send V6.

- Steve



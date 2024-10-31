Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F3EE68943
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 20:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6bqx-00075G-9X; Thu, 31 Oct 2024 16:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6bqu-000756-1p
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 16:33:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6bqr-00024o-MS
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 16:33:07 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VJBZ1r024264;
 Thu, 31 Oct 2024 20:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=TQtwO8fIAu+aGddnNdx/cJPK6GsNpPdaM72VdBUx0Kw=; b=
 h6PvaTsfmnrNHSQektZ1fFIkNB7+BiQixfqfb71nCXCTWYxrXBk1oBINi2YtDjeI
 3LQ2I7Z0Hrvn0PGphU2qFQnafhtcJpTvnZ75nFHMHYjOob+DZKZVoYeqgA3GTvEK
 VkRRmCMp0rFueqq+qKaY2XP9Q4caIytgBMDlerY3Y88B7SPJQmkBzwk9bi97ySEC
 uwexhxSe+W0FWXLBVthmWUdxW62wnj3+bQQM2Iqj4XHznZugup6k+RHxs8QsvLuF
 NBd3GJRmpZhEmz/gq6LocLhWyJxCC2FuJl+XdnVbxQfVXVkiB6BSN2MqOo5bHfFm
 3PuISbZdvRtNmDOGbrAymw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grysb85e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Oct 2024 20:32:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49VIm2v0004746; Thu, 31 Oct 2024 20:32:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42jb2xdk28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Oct 2024 20:32:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lrl56fU+vzZ5TyeTUu8uVeSCe5XwgUD5oakQDxQwTp2zqtmXWYxa6tZRV/P9K5Kn4n+nr/0/CAPrgtoH/RaXWpUUjgWFIzOlpq8ikzv/wdWm53LVP/pmR5Qp03bLRZFYVBZLxCbblkSpGEM5/nIzC7TXuAecwqMFYI2/XP5+8Y1pEi3TWh9CNz0IrWX+59tfG6uvXuTA1e/NLPGd552ez8k/udEQeQJCj5B/1LBeeE4iRrvP3LADCw7p2J8v/tkWfhJEscbatwGX+gHG+wfKwE4aYVbedJgR8jIjC/pWDYm+AJybCjM6OriAU6SSKJhHUtSNb9cAVuq+PB8n2eKMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQtwO8fIAu+aGddnNdx/cJPK6GsNpPdaM72VdBUx0Kw=;
 b=f7qXkL3c5tqzSE2KO76TIiDw06JUp4MD1isjz03Tp2RTOKu5hOuau3KOoPcfqq13a9LTPBz80WpA+Ic+zRLxYh22VQ3N+u5loNiPbX4FIvRk3HtMLbtzl6fOgGcBv8JtbtRIO2H+TceAh/ws8cUoVcKGCydX+Vo+no8XBZ1Yv/ZmySH7Vfy7V+YOcPtZREKByVyaEYUasyvQJNhmfE/bdt+6/hOCyPnfY/OMpYAT9WYvN+31U81hWayQtYxb8RrQqdfd+MuWtxwiRW0QgQyU0xegzJy2oDZPm9Wpk1Gx1T8zWAM597t+SgqSJ5XJ5kVs8umD092pD7zlC/LUYJ2Hdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQtwO8fIAu+aGddnNdx/cJPK6GsNpPdaM72VdBUx0Kw=;
 b=UvTrqY7V1lyvFK5JUiDTNFDDTryRvSRpYWJmY5v/uUCqgESRO6GF/ErP8i0m9h2s9VR5+Icpl2FwGNDgbUN9GIcEEOUCAHckMDGwQ5BP4hSe4/4REke8Ajm3s8tgJ+AVTomx4xaoCSLgUr1U4TmaYfFyvwEciHEhYAgOBKVqJG4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB5071.namprd10.prod.outlook.com (2603:10b6:5:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 20:32:48 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8114.020; Thu, 31 Oct 2024
 20:32:47 +0000
Message-ID: <47d6d984-7002-4086-bb10-b191168f141f@oracle.com>
Date: Thu, 31 Oct 2024 16:32:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/13] physmem: preserve ram blocks for cpr
To: Peter Xu <peterx@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-6-git-send-email-steven.sistare@oracle.com>
 <ZwQDBc-8niK2A0Vt@x1n> <ZwQMRlSSqP0i0ITb@x1n>
 <025423a6-8cf8-4300-91f2-13be32ec2c5c@oracle.com> <ZwVdGZtmZ27tX6gS@x1n>
 <22321990-d30d-4ab7-8c3b-f2baea662d7c@oracle.com> <ZwWk66RpczCpejhx@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwWk66RpczCpejhx@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB5071:EE_
X-MS-Office365-Filtering-Correlation-Id: 91596a1d-7bdb-44ea-cf50-08dcf9eb2e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFd2b0U3MHdUL2pPQ0lCMEhFS3FKbGVqUklXK29RMWFvd1FFRkZKQ0daM2Ri?=
 =?utf-8?B?RGVKd2R5cjh2L1pFdmRjNUVTNzJxRlNtNGhyUGw3K3BNbExsTGNjL04zQTVy?=
 =?utf-8?B?czFqTWs5Ri8xVGNJcjc2WTNIc3Z1cEt2aDlCeUx1dm1veGprT3dwNWJ3NEhx?=
 =?utf-8?B?VTZ6YmdIby9KSTdCVXhzcnRvSlI0VjB6MHVWYVg4UnYrQmJIZS9Qd2dmOHRH?=
 =?utf-8?B?b2FRWXVlQjRSSDFwTnpWRjhrVldhbWR2K0FYWjdYYjZwM2RPOS9ZQlBHcURE?=
 =?utf-8?B?TlhUTkhGZEpkNG92eWtGSDJ4VnVNdzRMWnBiSnlGcU12UnJuMWZXZ3oyWlBC?=
 =?utf-8?B?ZkNxbURyMXBzL0NERC9OaGtPTnpLU3hneFA5cXBaR2U2L3BrRTU5ZW5qY25Y?=
 =?utf-8?B?Nm4wWmcyVC9UTGo4Zk11YXV2VUFnRGQvSXBnTVV1YThZbWlVd28xaXViV3Zj?=
 =?utf-8?B?VFZUakNYcFp4eGE0QXA0TFBaT1J4SE9yWVpLQUFYMFdvTVdHeGFOaXRMQWEy?=
 =?utf-8?B?WWxjZjljYnBKbW1KNGhnSnpod3M4TGJWdEJrSE1sSnBFa1Y3ZzNuMnU5cDZo?=
 =?utf-8?B?bmRVRFFyTjArRVd3WUd3bUtSV3lGSmtvWGlhZjVndExld2F2bzVDWFYyYVdu?=
 =?utf-8?B?THVTY3REZnJscE5ndHRMeHA5Q2k1VFJXQmF5K00wbVN0eUp4NEFhK1RqTjFD?=
 =?utf-8?B?L1NtSTBvcFlpRWZlblR2b0RPd01YaGhYRVFVaG1tMUhkdDBuZVNPR25wV0xn?=
 =?utf-8?B?M1ppbTluSE1Jd0J5N1hmQUxnU0ZpOVlHbW1JWU9uQWFEMlRpVzNHV1FCcmoy?=
 =?utf-8?B?WUFSUCtYaGVqL2J4V3hFZWJVcGVYWjh5N0pmVDNtVUtiNm5xZitwTEp2ODBy?=
 =?utf-8?B?RlRJK1A3ZG1qNWhaYUZhbXMzSGs0YXJXemh4ODJnbDRLblVlbnFmSitTSitt?=
 =?utf-8?B?YzRXMDZrQTNGWEVYZTNZdVl2WXA3TC9mem96bFdLa0FadVpBTnFGaWlpZk5v?=
 =?utf-8?B?ak9idmFnY2xkdXdsdnRoZG5FKzFHUXk0K2ZLNVJCY0tNcEd3c2JPYmVIdU0z?=
 =?utf-8?B?N3NnMUE3azV3RC9hcTBaOVdJUHl2Nm9Td2xDWHVYdWZidkRIK0kvY1R4a1Ru?=
 =?utf-8?B?MGFKZGx6TEJ6WmFYZlRnSjNqZUczSCtSK0VseXZTUUhXRWVoaSt1Zk1JSTZw?=
 =?utf-8?B?WCswZkg3ekd3OThKTWpNYU1Zb0JoYnR4N0pRbGEzNGh2TnZyR0UrS2VjOTA4?=
 =?utf-8?B?ZlF3NjdwYmdNUDhxQTVXc1NDQUMwUVBwYjVoUkhraVEyNjN3RDIwREw3MWhD?=
 =?utf-8?B?bk5zSnVsOHJydnhrODJic3lJU2dmTFZ5ZHkzUThKblh6QjVFTnVMYXhrZDIw?=
 =?utf-8?B?by9QRlVydDVJVHFuM3gvaFB0SDU0UmpGVXdTekdDUFdZWk1Qa0RKZGwrZzZy?=
 =?utf-8?B?RW13eDU5STNkKzEzZHEvVHZCZUh3eHdMZTVucUQ3S2xPZ1ZTTUVTZ2pGWlRo?=
 =?utf-8?B?aC9RWGxiRVJvdUNuTG5JSGU4VkYyUmNvMlI5bHVFZmxZYVNhdjBlQzFYQmNS?=
 =?utf-8?B?a1hRUHhZNmtqN2h5M1ZqTzlvbDNqd3VjTWFtWGY3VWFKZFdpajY4eE9TMGo3?=
 =?utf-8?B?V2pZUS81bEdrZFhObVBra1hpV2xZRTRGVm52bFNtK2hTVmhibWhnUTk2dU5E?=
 =?utf-8?B?U3JMUm02M1pZT2xOUy9mblh4a3M5TUE4T1cyajFuUmU0U25MdDQ2OHNOSFZB?=
 =?utf-8?Q?w2erJEFr6hbOVf37jwn7hTVzEYrYXGp6emYmNYS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkU0cFNpQVpQM2F3dnlHYmNIcGppYzY5SjN5V0pzZWdXcUx4aGx3NTIwWEh4?=
 =?utf-8?B?Z1NNbjYvL292MFJWT0YzaWtoWHpDQ0NaY3hKYjlpM0pqMUJqUU81OGduMFFK?=
 =?utf-8?B?ZG5iZ2JZcmdFNEVVdHNGT0tvaDFma3RVS05zUThhL1BtUlBQTkJrQ0dFUEM1?=
 =?utf-8?B?c0YxMG9abzBmT1pzSUVkVGluSDdzQkc2N2ZtRHRpV1BtbzhQZUpBdmhRa1R4?=
 =?utf-8?B?YUJSZ1FnT1RQbG9JUUg2emlrcnVvOUtNU2k1ZlZ6VjJSWHhXMnd2NTNaZWkz?=
 =?utf-8?B?dnBoRkJVY2pmK08zeUFQb3REZlhabCtWQWxFNGZ3dEZRYXdjdVZYa1lCd3U0?=
 =?utf-8?B?OHNTOC9uSzZUVWlKMjFvRlY2TUl2MmdHQWkyTUxjelNpbmQzL21PQUVpVmha?=
 =?utf-8?B?aWtoRThjQXlucXJ2K295QzBJV1VIKzFVV044QUE5RDZJUWlYWHRxSFNEU05v?=
 =?utf-8?B?M2orK3NYYk5NQ3VVTXQvSmVKNzFTQUNvL29GS1lyb0ZzLzlvOGpPdFo3cGhi?=
 =?utf-8?B?NlVQZ01adVdhYWlzR29oTnFyeEJBSjdrSzgwc0dsdTdycW5GaEtuSTk5ODV0?=
 =?utf-8?B?NjNDeG81bENyV2NhOTNvSlllZnBjeXExWG9xRnp3YllualFhaVFJbVdyY3hO?=
 =?utf-8?B?RHlxbGJYVllvZms2TXVOUndtNE1oeGY4R1hoRmRvdlg4ODloN2MyWXdNc3ZW?=
 =?utf-8?B?T2IxaTcwTG0vdS9DNmxZRXF5VVlkNE5Ebmt2LzhrOGN4WXBqaU92RlJzUVlw?=
 =?utf-8?B?dkZuT0U4SEtXQmk0NEVjUGdPNHZPbXpSR2t3ZC9MdDJ5UjAwQlBpcDcvZ3JC?=
 =?utf-8?B?UCtESUF2WStxMmVVWkFNTXIwaE43NHAyTTliNk9OUlp0akhPM0xydlFhbXQy?=
 =?utf-8?B?TmNvRkFqd2luSzR3K3FCK053ZFNQOG1vUW1TbDNXTWQ4NlE1cUxPQmRhbFJa?=
 =?utf-8?B?NkMvcHlURlF6L1IrTk5RT1JRaEY5cUlwR2JrSFVVZ0RaYmxxRGlHNC9ZL215?=
 =?utf-8?B?Mk9nSnQrR3ZBSTdUZWRtdE5kUmNONVJRcUdtZEl6MXBYallySkRRSkl5OGI3?=
 =?utf-8?B?SjFFc0tMMTVOR0FxU2tsTlpCdk00UVY1bW40Rzk4akN3dWdXeGZoZHhZRWVF?=
 =?utf-8?B?QVNMQzRxazVCZk91OVQzQlFRNWkxYnJNd1NHdk4rTTRXTDlPVDRYblY1Y2s3?=
 =?utf-8?B?T1pCeTA5NmE5NHFPTUNSOTVjV2R4ME9CMWZMZHY5Z0hUeFp4S3lOZXNmMWVn?=
 =?utf-8?B?NWdGSEc4SzQ5djBxSngrbFJ6ZU9ZYVNxVlRnWS9NU3M3aVVrcFJsSng1WEtT?=
 =?utf-8?B?RVNPdzRMTjZIRWhIQVRxQ2pPRDlJZ3Rsa1ZvWjZtYmt4UTlvUWdESTM2WFNH?=
 =?utf-8?B?cmQxTUEzUC9XMi9HcG1wOG9VaUQzZXl6cWJ3Z3JKdFFhV3ozMldoSnUvVk0x?=
 =?utf-8?B?a21SOXBxbTJtRm9jSGFUVmZaSkFSamhDZ3FGbmxqaElBUktSMy9XNHYxYUJl?=
 =?utf-8?B?ODdkVkluaWZpQ2J6QnB5aHduY0J4ajB4cFBHK3lFcm94dTE5SzdJV25WOXNz?=
 =?utf-8?B?amQ4ZEhMbDRiQ2JuOEZ5bUxCV0tmb2ZBMXRHc2VEQ2dScWJ3UVNadW9CaDJ3?=
 =?utf-8?B?VDNTWktCUFM2QWNiUklNa3pneTNZK0FtY1NUMmROaGxmcHFvS1IxZzEyYzg3?=
 =?utf-8?B?eGx5Z2hOcWdtQjk4RGlFVkhaQnVxckdLU09TclJSeE5IOXRTNWZTSEQvdFEw?=
 =?utf-8?B?Z2dnUXhIL1pLSUNPQVZXaEFkd0tjZnVWdjFHeDJnZGIyZ2FRRUxjblgyM1hY?=
 =?utf-8?B?bUpUQ0dDanV4L1RMRlJJcEFGVzI2YU1uU09ZSkN6UnIxNWp6bCsvYXFkUWNX?=
 =?utf-8?B?b1c1N0RMMHFTUjFSNWI4Y0svNytIRGN6djRTNjhTQ0VwZGpIY0pzdVJYZ05h?=
 =?utf-8?B?TlBRYWQzd284dVNVWDB0eWJhRTlOcytjaGhaQVB3SDNoUkJBNHp1a2h4dDEw?=
 =?utf-8?B?V0s1NnZta0xCNk1obVp3TlZvSnNoZ2dpR0I0MWd2Y1N3WmhxWjJNMVBQbnBU?=
 =?utf-8?B?VGtJdUpvWUlLLysrdkgrMTE2UVFIc3I3Q3o2bGM1RllOYXo3S21zclhvc1Q3?=
 =?utf-8?B?aXJnSyt4UC9RamxyZ0M2ekQ3VlpmSCtUSGFkYXlBT3lNV2hiYm1TNkE5azhL?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SxVbo72e9min4CchqyQnVpPBPzBXxAGKZ9noLKBAviHEfOmzjalHukBZ/QNYit1mkWGb50EiO7V7VghtqrlXv93Uhd1sHzDRQkLP/WqtqfCvajuwV0TFCOhjQknmchcky4ivZFMThxv+KP7m15MNgFa5X25QgR67rUYaRdXm7h/WqeN7I6Wty4WeoOdgZBMy9HFvS8/4hN4IZc1WnLqMp8uCZMi7ohrNuJAzzVB9jGH6A/0l88OGqll9jIGre1SdKzVTpQU07TrGH1uDanzdn483qY52EJgmmqxhM7kJpp0U2kNBUmDwSa2OrTYliavJors3q5VW4zkQJ7HntnJa+aroSNk19PRSQLkNYJL+vubiZmav3lw0V64eyPPDS4uvaZkcNf76qJ+mn6ZSS3/n9CUijIy7Do0n57G1ps8yRga7AkbL0LGyoAbuzIJjYkwCNpGegjDQL34u5CvDIXiS7cjl3/fsdZem+Y+b/hlOYRAmQ1hOZL8Q6zwmBjXVTtVfGVhabeRKTS7kADj2UZpp7cAAAyTE7Qn62CwIS9R3fdZWYgMZDpPMh5Ek9uiuPHd+Kn+4MRZaS5J3zYED8+F0eQMYLVAv2vKEw8+lcAsy3DA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91596a1d-7bdb-44ea-cf50-08dcf9eb2e84
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 20:32:47.4639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xEohb/NMROvXJ/nK08AcJWbdZnHDlNvvjKIs+E2w8IQxgg5IXoEs3wFDA8qj2e5y6MAUx7X5gsOw8xQisSWf0YY6suGOPq8T1r46431O8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_11,2024-10-31_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310155
X-Proofpoint-ORIG-GUID: wlkQAgkdoaaVzwFi1_p9cI5gSt2L2Rc8
X-Proofpoint-GUID: wlkQAgkdoaaVzwFi1_p9cI5gSt2L2Rc8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/8/2024 5:32 PM, Peter Xu wrote:
> On Tue, Oct 08, 2024 at 05:05:01PM -0400, Steven Sistare wrote:
>> On 10/8/2024 12:26 PM, Peter Xu wrote:
>>> On Tue, Oct 08, 2024 at 11:17:46AM -0400, Steven Sistare wrote:
>>>> On 10/7/2024 12:28 PM, Peter Xu wrote:
>>>>> On Mon, Oct 07, 2024 at 11:49:25AM -0400, Peter Xu wrote:
>>>>>> On Mon, Sep 30, 2024 at 12:40:36PM -0700, Steve Sistare wrote:
>>>>>>> Save the memfd for anonymous ramblocks in CPR state, along with a name
>>>>>>> that uniquely identifies it.  The block's idstr is not yet set, so it
>>>>>>> cannot be used for this purpose.  Find the saved memfd in new QEMU when
>>>>>>> creating a block.  QEMU hard-codes the length of some internally-created
>>>>>>> blocks, so to guard against that length changing, use lseek to get the
>>>>>>> actual length of an incoming memfd.
>>>>>>>
>>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>>> ---
>>>>>>>     system/physmem.c | 25 ++++++++++++++++++++++++-
>>>>>>>     1 file changed, 24 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>>>>> index 174f7e0..ddbeec9 100644
>>>>>>> --- a/system/physmem.c
>>>>>>> +++ b/system/physmem.c
>>>>>>> @@ -72,6 +72,7 @@
>>>>>>>     #include "qapi/qapi-types-migration.h"
>>>>>>>     #include "migration/options.h"
>>>>>>> +#include "migration/cpr.h"
>>>>>>>     #include "migration/vmstate.h"
>>>>>>>     #include "qemu/range.h"
>>>>>>> @@ -1663,6 +1664,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
>>>>>>>         }
>>>>>>>     }
>>>>>>> +static char *cpr_name(RAMBlock *block)
>>>>>>> +{
>>>>>>> +    MemoryRegion *mr = block->mr;
>>>>>>> +    const char *mr_name = memory_region_name(mr);
>>>>>>> +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
>>>>>>> +
>>>>>>> +    if (id) {
>>>>>>> +        return g_strdup_printf("%s/%s", id, mr_name);
>>>>>>> +    } else {
>>>>>>> +        return g_strdup(mr_name);
>>>>>>> +    }
>>>>>>> +}
>>>>>>> +
>>>>>>>     size_t qemu_ram_pagesize(RAMBlock *rb)
>>>>>>>     {
>>>>>>>         return rb->page_size;
>>>>>>> @@ -1858,14 +1872,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>>>>>>                                             TYPE_MEMORY_BACKEND)) {
>>>>>>>                 size_t max_length = new_block->max_length;
>>>>>>>                 MemoryRegion *mr = new_block->mr;
>>>>>>> -            const char *name = memory_region_name(mr);
>>>>>>> +            g_autofree char *name = cpr_name(new_block);
>>>>>>>                 new_block->mr->align = QEMU_VMALLOC_ALIGN;
>>>>>>>                 new_block->flags |= RAM_SHARED;
>>>>>>> +            new_block->fd = cpr_find_fd(name, 0);
>>>>>>>                 if (new_block->fd == -1) {
>>>>>>>                     new_block->fd = qemu_memfd_create(name, max_length + mr->align,
>>>>>>>                                                       0, 0, 0, errp);
>>>>>>> +                cpr_save_fd(name, 0, new_block->fd);
>>>>>>> +            } else {
>>>>>>> +                new_block->max_length = lseek(new_block->fd, 0, SEEK_END);
>>>>>>
>>>>>> So this can overwrite the max_length that the caller specified..
>>>>>>
>>>>>> I remember we used to have some tricks on specifying different max_length
>>>>>> for ROMs on dest QEMU (on which, qemu firmwares also upgraded on the dest
>>>>>> host so the size can be bigger than src qemu's old ramblocks), so that the
>>>>>> MR is always large enough to reload even the new firmwares, while migration
>>>>>> only migrates the smaller size (used_length) so it's fine as we keep the
>>>>>> extra sizes empty. I think that can relevant to the qemu_ram_resize() call
>>>>>> of parse_ramblock().
>>>>
>>>> Yes, resizable ram block for firmware blob is the only case I know of where
>>>> the length changed in the past.  If a length changes in the future, we will
>>>> need to detect and accommodate that change here, and I believe the fix will
>>>> be to simply use the actual length, as per the code above.  But if you prefer,
>>>> for now I can check for length change and return an error. New qemu will fail
>>>> to start, and old qemu will recover.
>>>>
>>>>>> The reload will not happen until some point, perhaps system resets.  I
>>>>>> wonder whether that is an issue in this case.
>>>>
>>>> Firmware is only generated once, via this path on x86:
>>>>     qmp_x_exit_preconfig
>>>>       qemu_machine_creation_done
>>>>         qdev_machine_creation_done
>>>>           pc_machine_done
>>>>             acpi_setup
>>>>               acpi_add_rom_blob
>>>>                 rom_add_blob
>>>>                   rom_set_mr
>>>>
>>>> After a system reset, the ramblock contents from memory are used as-is.
>>>>
>>>>> PS: If this is needed by CPR-transfer only because mmap() later can fail
>>>>> due to a bigger max_length,
>>>>
>>>> That is the reason.  IMO adjusting max_length is more robust than fiddling
>>>> with truncate and pretending that max_length is larger, when qemu will never
>>>> be able to use the phantom space up to max_length.
>>>
>>> I thought it was not pretending, but the ROM region might be resized after
>>> a system reset?  I worry that your change here can violate with such
>>> resizing later, so that qemu_ram_resize() can potentially fail after (1)
>>> CPR-transfer upgrades completes, then follow with (2) a system reset.
>>>
>>> We can observe such resizing kick off in every reboot, like:
>>>
>>> (gdb) bt
>>> #0  qemu_ram_resize
>>> #1  0x00005602b623b740 in memory_region_ram_resize
>>> #2  0x00005602b60f5580 in acpi_ram_update
>>> #3  0x00005602b60f5667 in acpi_build_update
>>> #4  0x00005602b5e1028b in fw_cfg_select
>>> #5  0x00005602b5e105af in fw_cfg_dma_transfer
>>> #6  0x00005602b5e109a8 in fw_cfg_dma_mem_write
>>> #7  0x00005602b62352ec in memory_region_write_accessor
>>> #8  0x00005602b62355e6 in access_with_adjusted_size
>>> #9  0x00005602b6238de8 in memory_region_dispatch_write
>>> #10 0x00005602b62488c5 in flatview_write_continue_step
>>> #11 0x00005602b6248997 in flatview_write_continue
>>> #12 0x00005602b6248abf in flatview_write
>>> #13 0x00005602b6248f39 in address_space_write
>>> #14 0x00005602b6248fb1 in address_space_rw
>>> #15 0x00005602b62a5d86 in kvm_handle_io
>>> #16 0x00005602b62a6cb2 in kvm_cpu_exec
>>> #17 0x00005602b62aa37a in kvm_vcpu_thread_fn
>>> #18 0x00005602b655da57 in qemu_thread_start
>>> #19 0x00007f120224a1b7 in start_thread
>>> #20 0x00007f12022cc39c in clone3
>>>
>>> Specifically, see this code clip:
>>>
>>> acpi_ram_update():
>>>       memory_region_ram_resize(mr, size, &error_abort);
>>>       memcpy(memory_region_get_ram_ptr(mr), data->data, size);
>>>
>>> Per my understanding, what it does is during the reset the ROM ramblock
>>> will resize to the new size (normally, only larger, in my memory there used
>>> to have a ROM grew from 256K->512K, or something like that), then the
>>> memcpy() injects the latest firmware that it pre-loaded into mem.
>>>
>>> So after such system reset, QEMU might start to see new ROM code loaded
>>> here (not the one that got migrated anymore, which will only match the
>>> version installed on src QEMU).  Here the problem is the new firmware can
>>> be larger, so I _think_ we need to make sure max_length is not modified by
>>> CPR to allow resizing happen here, while if we use truncate=true here it
>>> should just work in all cases.
>>>
>>> I think it could be verified with an old QEMU running with old ROM files
>>> (which is smaller), then CPR migrate to a new QEMU running new ROM files
>>> (which is larger), then reboot to see whether that new QEMU crash.  Maybe
>>> we can emulate that with "romfile=XXX" parameter.
>>>
>>> I am not fluent with ROM/firmware code, but please double check..
>>
>> Thank you for the detailed analysis, I was completely wrong on this one :(
>>
>> I also keep forgetting that ftruncate can grow as well as shrink a file.
>> I agree that preserving the dest qemu max_length, and using ftruncate, is the
>> correct solution, as long as dest max_length >= source max_length.
>>
>> However, IMO the extra memory created by ftruncate also needs to be pinned for DMA.
>> We disagreed on exactly what blocks needs to be pinned in previous discussions,
>> and to save time I would rather not re-open that debate right now.  Instead, I propose
>> to simply require that max_length does not change, and return an error if it does.
>> If it changes in some future qemu, we can reopen the discussion.
> 
> Hmm.. why the extra memory needs to be pinned?
> 
>  From QEMU memory topology POV, anything more than used_length is not
> visible to the guest, afaict.
> 
> In this specific ROM example, qemu_ram_resize() on src QEMU will first
> resize the ramblock (updating used_length), then set that exact same size
> with memory_region_set_size() to the MR with the size of the smaller
> firmware size when src QEMU boots:
> 
> qemu_ram_resize():
>      unaligned_size = newsize;
>      ...
>      newsize = TARGET_PAGE_ALIGN(newsize);
>      newsize = REAL_HOST_PAGE_ALIGN(newsize);
>      ...
>      block->used_length = newsize;
>      ...
>      memory_region_set_size(block->mr, unaligned_size);
> 
> Here a tiny detail is the two sizes are slightly different, but the MR size
> is even smaller than used_length.  The MR size decides what can be visible
> to the guest, when the MR that owns the ROM file is mapped into GPA range.
> That's true on the src, while after CPR migrates to dest that should still
> hold true, afaict, as all the rest memory (used->max) is not yet used
> before a system reset.
> 
> The extra memory (used->max) can be relevant only after a system reset,
> when the new firmware will be loaded, and qemu_ram_resize() can indeed
> extend that MR to cover more than before.  However that should be fine too
> because that means guest memory is being rebuilt, so VFIO memory listeners
> should do the right things (unpin old, repin the new ROM that is larger
> this time), iiuc.

So, we actually agree!  I said the extra memory needs to be pinned.  You said
the memory listeners will pin the extra memory.  Cool.

I will add ftruncate to this patch to grow the mr.

- Steve



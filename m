Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1805CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 17:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzej6-0005GO-Bx; Fri, 19 Sep 2025 13:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzej2-0005EH-CP
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:16:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzeiv-0001XT-MM
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:16:48 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtqoI014713;
 Fri, 19 Sep 2025 17:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=eNz5XzsozNgLALSRYp3ZFn1Oft9BdzVykxnKwajAoBg=; b=
 TI4ZUKBzEFY8UZW2Zb7nt37qYJpG4L4vCX4fUh4i9AS2ttd1F88dOzA0qDuhQoy7
 9S/3lHzhFQOU3drTbEqq39c4BnH87ye7z633/J+DD5xRGk7vCTyOFVblv/X5GzaS
 2Xby4tr4YsLMB3/sAofkNZ2FJ1uFMW/m4ZVBO/LdYc0lKDJCtzEJt3TGb0FIgfEi
 xRB3QVGigexuBN9ptUOBORW9NXsg3Ou0nGFpYsewoM5koRTYTsvMja+goCvaH8vf
 Tm5FP1RxXv/MEzB5yIA40WFSW4Gsox4X+quJhI8hEL3G0tLs/B0RxktZgXhQeBJs
 gJGyvSU8ObuxRY5pCf6arw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxbx17p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 17:16:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JFPN2e028863; Fri, 19 Sep 2025 17:16:36 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gt9we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 17:16:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGhVsczAR2IsCgMUEOqnHWIjzF0LpQ4ib0v5gUJi5nA82aGWYpctzOq9OmsSC6y0YgP0LZucFNqFHwY3yENm9AAAII+NHC/tVP/cHAX9rUg4UhfWoLe5iOlryXjrq5pE5JqwNMnX4ZXTqsVgiOPGgwbSZYcUTnmpLndZSHHJsgT504xmorATokA/EpZicN+1mEsaVVX/3YYoghuoX7JLooznTrLsLe5btTYl8rALcaaXtZnkGPJjFy9bisixiTfWEe6ybNIWFi6tSTemRmkTngJoec7VRHvnqJpZ2M3ZIEBxuNg272t1Im4GY1dYOq3Ia5XkvRUfJ2qKgjZw4dv4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNz5XzsozNgLALSRYp3ZFn1Oft9BdzVykxnKwajAoBg=;
 b=BBZsyplRESsMw2cpadKP2kCdYnNPEV5zQdNXf3bKcbxUyiwGavdloSRYdhp3bb+3H0DJiVXq8Hu+XNSCsMt3kLe9HDBQQflz2zFzkqMD4PQTeJEw78ejwE7d/PmEzDuSn3U2zGC5zzetdyaHvhq+Qu41ubdDG1dDiD9m8iycq9+YDcaePhFk+pxo0hFIFywc9LxCuGw9UJzsTAjZljyq9OvTZPy97lDno1+r83wQo5T5gcOjFywCo8InqRxoMyYEA9S1J68XS6R7CmgEM9F573wfjUfukrqzPazaO2AmaCAo0e1u0dqUKRjifrwwctWXNHwHcfwT3SAjAUgnR0VlhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNz5XzsozNgLALSRYp3ZFn1Oft9BdzVykxnKwajAoBg=;
 b=nEb7azjAYWw3yahSbAYdlqw/UjAWdJbmTPHOSl7XeDclmGlGQGYlGbv0Wc8T8qiLGn66rSeeW0ve0g2fm1xxVENL2+0zfOzdZ4rWhkgnqFsccJvb0EZr10lXIAo7OJTTYn3GFMp5J1ucJl9JO9S88IAXvytcGNKZSpGaaxzWZxo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4426.namprd10.prod.outlook.com (2603:10b6:806:117::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 17:16:31 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 17:16:31 +0000
Message-ID: <f81f1138-1450-4a71-8459-63f653018226@oracle.com>
Date: Fri, 19 Sep 2025 13:16:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local> <fd56205a-11c1-4297-898d-603f1836bdad@oracle.com>
 <aMBGnHXieiXpBCqF@x1.local> <992bf553-e622-4e51-b1c7-f59c1413558e@oracle.com>
 <aMB0BL5SEGfwjTFm@x1.local> <1a3c46b8-985e-4768-a3d1-e797370c0822@oracle.com>
 <aMQ_65_BybkbtZL4@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aMQ_65_BybkbtZL4@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH3PEPF000040AC.namprd05.prod.outlook.com
 (2603:10b6:518:1::5b) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0844880e-0ef6-40d7-f015-08ddf7a04718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXAzd0JjbnNPeGRqRGZQS2pHSHpIUDNwWlVLM1pWaXNEMG1kcXhXY3RUNHJy?=
 =?utf-8?B?dU9DVHlCT2VwWm1UWmJyVDQwS0E1MmUxazVtSFR6Sy9nTGN1cnlZL2hJbWxv?=
 =?utf-8?B?cnFHWG5lU2cyTjFVaXVzZ0dZcXlGNWhYN0tRRHlPcVlJcHRnZWZ0WUxjaVJs?=
 =?utf-8?B?KytWQ01BdUxyUlFqd29hM01IVC9xVTdZb0lXV1RtYlBBNm50eHp6TWhJa3JL?=
 =?utf-8?B?cEozZ2xNdEdzMCtJTXlnbFhYSEMrcE1zU1VwV25jeURyRlB6L25SUUlHTDBK?=
 =?utf-8?B?RzMvRnhYZ3NPaThnVnBoOHRnY2RCYzh3bWV6UkVsTnkrbnJNajN4MGRwZ3cx?=
 =?utf-8?B?Z3IzVTF6b2hCVEYxV29zc3ZHR1lrRHFEWUhOMmJLV1VDNHM2ekcrcjFQbjdk?=
 =?utf-8?B?M05wRWF6Y1VkTkhFaG1FbE9tRlBhNDhoeGx6dXprSFlRaVJYMlJEYXZEdmF3?=
 =?utf-8?B?NnNid1VWc0RXMytWY1lQbnE4NGkvRjVOZExUQmVEbXBTajdqMVQ4N2xLR1JX?=
 =?utf-8?B?M2tCK0c3Q1lIbG1wbXltU2hnenJCT0JPKzVEVk4yY3l0TGpvSWlZWCtta0dj?=
 =?utf-8?B?T1h5R0VsR1NqRFN2dnIrR3FLbU44Tm93QUlwNmRFQi9TZmtSbFpicXRYRmVW?=
 =?utf-8?B?cTJMazdsaTRsSFQzaUd6dVVoa3BUREJFbHlFRnp1Nk9GaEdPSjlwUUl3RGxI?=
 =?utf-8?B?OFgxSk5NSXdFc2NFb2xwbEhkTVE2b1RGaFQ4d3YyZ2ZldXQwNnpmU0JUSGVK?=
 =?utf-8?B?Z0pZU1E3REp0bWhMWklRcjJCeTcyejlQbTFlWldRcFQ3cC9tSTVrb3FmWUNn?=
 =?utf-8?B?amVJejNPMGdkUlo3Yi90ZTZXd05DSmRrbXd3NlNBdlFJMnlCMyt4ZTRmU09I?=
 =?utf-8?B?Z1IzWHZiSTlHYXZNSkxjZmdzYUxLUFhKUTZqSFhGRkhTYmVub0ZSQTV1blJZ?=
 =?utf-8?B?OGdSTTdOa0hIWk5PK3N2UTR2MjZDdWRmWDQwSDJueXNEelhoWXFFc2RSbzkx?=
 =?utf-8?B?RlVtQzdPSWNxN2U1NXQ3Vi9zUDNMclJDRzhlTENTcFNGa0RHQ243V2g4Y2hH?=
 =?utf-8?B?WnNlUnVjNzdlYmZBOVByRnczRG5Qc2NOSnhvaXFLUjBBalV0UlM1ZlJLc2pI?=
 =?utf-8?B?RTJqK1paOFR6SEZHTGFmYmdHOGw5RkhvVk1NdjhmdjllNjRvTENHdHM0NVlT?=
 =?utf-8?B?OXQxVDZzdlRPaFhYelFaTi9RcWI5NkxxMmVmZE9sKzlKbkozdm85c2VSaFBm?=
 =?utf-8?B?bDBuaitSSDBaZlF4d2QxdjVFcE9hZjRwNmdDcGV2NTJRS0ZPbGpGSTVpYmly?=
 =?utf-8?B?ODR0eTFmaWQ0c2xjdk83dFV2bC8xMGNQeXJtTFVndHZpdjlrVmF1NCtXRmF4?=
 =?utf-8?B?TTkzRTU0bXRaMWVFZkNhOEl0MHdVb2ZFZU9yZjhaOXNjMFBwRjFHSWRnVFkr?=
 =?utf-8?B?Zk5VYURqZzFHQ2pFZGRIajZFb0M3QU91bmwwWEVPNDVrVThQY1VJTmtlVksx?=
 =?utf-8?B?NFpKbXdVUStCV3V4cFIvTW9wR2kwNnkzenNSUmJ5WDlickV0d3Q3SjkwSXNs?=
 =?utf-8?B?bVIxd1hKYVFHZ1hUUkpJQnpyM1JIZ0tqeFVWYlZKU3hacGFSSDZOWldvNlBv?=
 =?utf-8?B?cVBOMVJ2TWR3Tlk2WTIwQ2tVSWs3dXRWSGg4dHczL0JTMm9ZaDdkZVhzYjZF?=
 =?utf-8?B?UDZuTDh6N3R5bFRXWGI3dFoxd1lUNTBoWjB6aE81QytGL2dQOFNxY1dla3dL?=
 =?utf-8?B?SEwrODlxaU5oNzNjbkpoOEpVaS91eHhVVUhPby9rSVd4SFJkZVd1amtYSkxo?=
 =?utf-8?B?N2FGZHd0ZFdvYUI1Tk1DUFlZVUowUmpGOURZRU9RRFN1OWJQcXBOS1NQdkt4?=
 =?utf-8?B?RTEzRllFZjlpY0RGTzVSRitmNVNqakJtTFNsQ29wNllxK0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elN6eGxuTDd2ckhaZTJjQlMxb2ZkeUNzc3FhVmlwdmZvcEJkNytkYllqOEdm?=
 =?utf-8?B?WVRMdXltS2JvTnNKL1ZRU2R3SUcvZVNTUVRtQXgyL1dKeklqQ1IvVXpJVDZx?=
 =?utf-8?B?UkhDcEMvMFhCdXdKVTNIVnlWalVyNHBocUQ1ZkhsUjlseEdraFNJbWlRZ201?=
 =?utf-8?B?V2wzWHJjdCsxdXBNR3dKZFZlbXh6Nm16ak5FM3hGWjBNUHo3aVFlUUdTbUNG?=
 =?utf-8?B?TmxTR0ZSOUZ5TG4yc3BCMUdyMERFV3BTOHZrbktSZFlqL2EwdWFNeDFmVlNO?=
 =?utf-8?B?WWNwWXlkZmF2YXRINXZNYkNtWGxGaUwrVm5qRkxYdktwNFB1ZDdSNTFObUQ3?=
 =?utf-8?B?b2FTWU9xZDZzUzlSUytNb2lQTTVidFlLMjNiVW9weFpsQnpFNGt0THhkR3N3?=
 =?utf-8?B?UmZnTWIvQis0b0JsaDBDRVhDd1c4ZWhJYmM3L2JpSmRDamxSTkhpa2tlZ1Bl?=
 =?utf-8?B?UXN1SGQ4M0xvMVkvQWJOaGVKMTlKTW0xWmZkUjNqdEorR0RrZ1FxWWF2VGd3?=
 =?utf-8?B?YmhhZHJrUVU2U2JJcnpYN3NyODVYQmtjbUhvTDdYYVNlS0xlblNpcnFNTXRo?=
 =?utf-8?B?NXlqNzdzeU9jMU1zb2gvanFEbDBxenVmdzNqL3dHL24rMnZObUdiTzhQaCsr?=
 =?utf-8?B?V2ZjZ0tQRWdldVZkOWdQMEV6alZXeWRFc1VHY2lEaFIzdFlqV1Q4THdvR3JU?=
 =?utf-8?B?VSs3dXBhQmJMd1N5eWpId0k5TzY3Ulp3Y3FmdUJwYTNCdEdlRS9jQmF4RVdh?=
 =?utf-8?B?dENma1YwdVdqMlZuY2o5UDluTHFEaE50ZCtQS1EydGpiSS9wR2VLRU9mL3R0?=
 =?utf-8?B?QXZVcXo2dWdZYzE1alJaM3Z1VWluQVdsRCtjcGdMazVkdWpRZ2lyWVpvTGlv?=
 =?utf-8?B?Uy9YMEhkVDU5SkpRMWtoc1BZU3hLeW1rcGRZUUtCN3MvOXRWR0VhcGF6NjFF?=
 =?utf-8?B?UVNPbHFIMHprSjVNZDd2d29iUGZKZFJGWnBhQW5NOW4za1pjYzVVY0VNclp0?=
 =?utf-8?B?UDM2bGhFc2tNZklMYmtOQmRYSjFUYTFROWdyZGVOT3p6SWhqamkybHlQK2cv?=
 =?utf-8?B?cDY1QUdWT05oVXpHSWJjTjV4QkR6OE5TRXRJVHhYS0VieEpmMGhpSk9zSE41?=
 =?utf-8?B?Vk5VRHFkUkJZK2VWWHk2Tmd4Y0MyL0R5VkJkaHVTSEZENXY4L09kcU9GWW9m?=
 =?utf-8?B?Y1NzYy8ySlJWeDduVnRkUTNGUWowYVlXeUNTS2lSazlET3dBOU8vR1ZuZkF2?=
 =?utf-8?B?VnZNTlduWW1VVVN3RHdON256OGlmUEhsb1FPU2xhVEdoalh2dFJMYkR6K1pX?=
 =?utf-8?B?M3BxemRKeTNVUllQaG9TdUNxd056WGc3RFBJN1Jwd205TWE5YisyV3hFUmsv?=
 =?utf-8?B?WmtWa2VYZFVWTFgxeDhLd1dqczlGR2NONXZHK3d5OGUyVDNodGJ5RVhmMHRV?=
 =?utf-8?B?bkR4dWtwVkFpQ1ptMmtDQkFEbEZUbjFYcVBLNk5pTmpWNTA1eVJQc3FGcnU0?=
 =?utf-8?B?MWk1OXE3ZXlhS1BzVC9reG5yUHJDdWszcG81cmdzTXdsZWRhdnZsOEs1MW5B?=
 =?utf-8?B?c092eEJPS1ZnazZtSEtBcUVXeFhGTUpDdzYxU2MwUzVpUktKTHN1cTdkcU8w?=
 =?utf-8?B?NWlvN2tybGdUSTNjZGZqS0NQaVVIVFZuR0xRRTVCakxQNVVHdEJpc3Z3R0xh?=
 =?utf-8?B?K1puM245YVBxQlE1NHNBTVBIelRsUDFxaTlkdlVtL3MxdVhYYysyVjhxKzdo?=
 =?utf-8?B?YlBnbER1WWNpYnZlWEpxbFd2OVU4bzhaMEFZcEdtRmo0c1NtQnBidWQ3LzR1?=
 =?utf-8?B?ckgxUWFJcXBISmkyVGNkdHI5Z1dRVWY3bmVOYkZLb2lSWWtzTDFvcGF6cTdw?=
 =?utf-8?B?anltK0J4TlFZT2pVZm4xcUprcEZySGtKZGhJeko2WXEzem5RcjRKTnBQZTNt?=
 =?utf-8?B?VmJnUE5nSmhWcWU4czNPdHQ5dVhKRlB2ZTR4RC9KcUpyZjVoOENsNktYejF2?=
 =?utf-8?B?NmpNV3NCWC9lZFJWaisyZGw4TTV1bWdXRzJISGRBckM0RHVKbkpLV3NnVjdT?=
 =?utf-8?B?UVlzMWh3N3haOHVtcWdvOFZkSzNISU5yY1NCNHhKMGN1UlRWeVhLZUptcWtC?=
 =?utf-8?B?ZUR1YnNoaEgyK0ppazcvSFMwSk1YK3NYbW5tS0JXNnR1ay95TWZSd3BDYm1h?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EN1vsvtWTMzzGqcEXM9do9o2wVvAXh6Us5idvWsQH95NxsCDwNg/maUhWrMkSUrZRklqmkLrk0jUI8FD0Jfo/A6YvKqDA8toWMhIUNQQevtBtDRIFwFdlSbRmjC5vud1x9FRRCOSYZ2uFSmCv1zfmoz/uO6C3Irdi7JOs+Il+2tVQ1EWb8PZ9JDGYTMwV6YJJJmZZQmmZ/cabsVzBSy2BjZBZQ6i7mYVxia2kq77Ei2D80zivPlaL4hHyVubs0yvyuttdsg8vnRnhe9deZHkBpIppu3KnYMoRDddalDpoLBp3zKvr009QQut2XZqpZGkyyHfkloaHAch3WWQI/AEtLsu/9q1TaKkf7D0L4EY9HQWpIVHfc7LrmRGNkAyZahjOLZhUjUi8cWkGf2espNbOhxwA7jc8HOYvRR7WBT1JtvoKc9T0/fm15yxknGO0HbRmRhU3QjmOOnAPkAyDE66PG3dgdSTaLEftMgNq9W6zGLdAlfSeqV/XOfu9AT26nk3TKgxYH0ZW6BKvbEEJMTvLmcoFrappgPz4M4dceIHF8IoSxlAu6x6RzStnXz0lvnyitfhR+76jcIhyLq2CZ/nLuZcNEQa8/O00Nbmmzfhofk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0844880e-0ef6-40d7-f015-08ddf7a04718
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 17:16:31.7899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HG38FJGd0v7vC4ckt1JoZUPWJ5jmIfdrAvaJtdYGA8Vuid0qTNcR0VWRVKjdz0090sE2xovOfcB7hDrfj/Pz6LScnmt1UnsDoKBZAUeJQfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzXHJvkibQ/nV
 CKaEo3+xrC0xtcjj5q9me4w4I6aFfng22defNRe8vYneJsVuzm9Dw5wRCq8FySOqDI7pJLdms0q
 0BKZyaASM+JZLOb8/Po14Z4oI9FH7idkAh/5GO9R7JllRgrl1EW2jtLYQUz5bOOHQR/fkf3uGoY
 uqOk9zXVxJ0pQEQF2zDpoYqrT9n23VJNJm1dMfHYB4QzZYkqnbvPhHkUNobskM2UBHL9E4cFiOz
 1BLVaEh8Onj/875YYju06n/z4jC99BQ+r1uB+fDTJnQm0yA0AHkaF7sOBYNjzAAYjhWrOc88SIk
 lSML1zuaCn/AxgBaquHp9HhuSElSXZF0nOrDMdsK8OeWDoNefXBC849vlzz2JPAB/tIiS2/9AFu
 /xoWbIrB
X-Authority-Analysis: v=2.4 cv=X5RSKHTe c=1 sm=1 tr=0 ts=68cd8ff5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pTy7Qt0MdbCsmxypxN0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eEXnmDktlGE7ePMmFUWm8SgH4FAAH57Q
X-Proofpoint-ORIG-GUID: eEXnmDktlGE7ePMmFUWm8SgH4FAAH57Q
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 9/12/2025 11:44 AM, Peter Xu wrote:
> On Fri, Sep 12, 2025 at 10:50:34AM -0400, Steven Sistare wrote:
>>>>> How to guarantee src/dst device topology match
>>>>> exactly the same with the new cmdline?
>>>>
>>>> That is up to the mgmt layer, to know how QEMU was originally started, and
>>>> what has been hot plugged afterwards.  The fast qom-list-get command that
>>>> I recently added can help here.
>>>
>>> I see.  If you think that is the best way to consume cpr-exec, would you
>>> add a small section into the doc patch for it as well?
>>
>> It is not related to cpr-exec.  It is related to hot plug, for any migration
>> type scenario, so it does not fit in the cpr-exec docs.
> 
> IMHO it matters.. With cpr-transfer, QMP hot plugs works and will not
> contribute to downtime.

I don't follow.  The guest is not resumed until after all devices that were
present in old QEMU are hot plugged in new QEMU, regardless of mode.

> cpr-exec also works, but will contribute to
> downtime.
> 
> We could, in the comparison section between cpr-exec v.s. cpr-transfer,
> mention the potential difference on device hot plugs (out of many other
> differences), then also mention that there's an option to reduce downtime
> for cpr-exec due to hot-plug by converting QMP hot plugs into cmdlines
> leveraging qom-list-get and other facilities.  From there we could further
> link to a special small section describing the usage of qom-list-get, or
> stop there.

To hot plug a device, *or* to add it to the new QEMU command line, the manager
must know that the device was added sometime after old QEMU started, and
qom-list-get can help with that, by examining old QEMU initially and again
immediately before the update, then performing a diff.  But again, this
is independent of mode.

- Steve


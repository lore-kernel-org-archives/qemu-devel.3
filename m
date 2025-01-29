Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C21C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 18:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdCg0-0000Li-9u; Wed, 29 Jan 2025 13:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tdCfp-0000LJ-0d
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 13:20:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tdCfl-0001K2-M2
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 13:20:24 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50THQmti028110;
 Wed, 29 Jan 2025 18:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=BDPTR+I0Xd9XPRtUO8DUpFmGVe3wKGYMlZaianFoX8g=; b=
 duvfDJ7hsAapyCREib2D+AJ5aQBxp3Wa5m+PFsSuBWU+kKbQu1NgJT76xbyzazdc
 eFcN8vqJIolCgeVb6WPZ5wZCTCFrG6fto5ohqKxQJoyD1uVg2xEHSKGPx2lXZQCG
 D4r8i3/UuuEZCXApEAwi0YgqNE7aXW+UOgLJqqUHoDLjLKvHfn6VYugnEJ+uE6Rf
 mySijRv5mpxFkfCNkoleoJ0AHiABPDPKvUR25GndVhGyjcJIMHw8HhKw5VZ9PHxZ
 MVgy7lGKF3aKCZqFX3+W1JctDbYBbOBUhAVpKprpoaAX25jQs1dBJU5gzjj09v0f
 g5SNpuMBKPGG6ZMKZzy90w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44frjeg4ge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 18:20:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50THS2eA004169; Wed, 29 Jan 2025 18:20:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpda6qkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 18:20:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3B1jO1OqpaFn+pkJeHxzzqUcbM514320O/U2mUzRQx6pZxGZN8xX7WoAlob/MCyP37zRmPVt8hD2ky/6B9hNyZTlbwtUA69kY4auE5ypau/P/h21AnX4fcfjs0v65t2gr8or4vYI/eRUqb9EvS/31uPWHBfKYfneA8HoCs40sFpDJNvObaFlzsQjrDJyivvT0FhioPMnmiSaP0x8BJG6e8v0erYhSPH7Aeb1NjyrTO8k0jA2ws0iAhJAtqDt6cbFfEYavXm1d8in2nXTUJJMxMfXRKKyCVV6vTtl506O1RLKDdjIooxUzooNPRNLEj7qwOTHUb0YK2fAvZdzZ2Egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDPTR+I0Xd9XPRtUO8DUpFmGVe3wKGYMlZaianFoX8g=;
 b=MY4sgqseYP4BMEA/6O9QKMTj1uVlaHJb7uQiK4lsQhnRbIOddCbZgwkl55W0MZwZZg0BVLifa9x5bVHGSaTD1fGqyY91YMsWF0im08IDkudUYcIeHUDZ15j8AFPNWZPup0B4R0E2Lw/zVw5xIOLFmWYVmJ9bSsa39sEVSogSVg0NsacTFjHktXE9YVJGJMDUlR+PaIp3OFejQFvYrJiq45uKAFW/J5K5Rf7op/sEhgN+0QJsIxCmrrQ74SehEhcNYH17hugfWzykc+ZIJV2bINerZTHhacHnxeLmC26bjB5BPU9pkxkYeNeT6Z5kQJGIWl/CodSasiGm8Wv/5dUpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDPTR+I0Xd9XPRtUO8DUpFmGVe3wKGYMlZaianFoX8g=;
 b=bO+70Zu6uV2Jk4ksL/d7yrYX8iDyvsnLCVinpFesod9VB1rA4slfHIqQKGQj9rP2rKoJMVGGLxNGt++MjOTuKgWjRUlR+Ayh3Idxm4G38BkjpiSWKRUm8P7YbapZNoXLoKgXlZbWnvrVgx7qLptHq6w6aewDNjPuFuZzu50KeFA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB7679.namprd10.prod.outlook.com (2603:10b6:610:169::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.24; Wed, 29 Jan
 2025 18:20:15 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 18:20:15 +0000
Message-ID: <20674b54-3c88-4d2c-a590-3b0ddaff86f9@oracle.com>
Date: Wed, 29 Jan 2025 13:20:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: ram block cpr blockers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1737135971-132839-1-git-send-email-steven.sistare@oracle.com>
 <Z4qelNxnBcgO87go@x1n> <814d9205-8ba5-48a8-9940-6f16bbb097eb@oracle.com>
 <Z4ruhpH28-GnnTq7@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z4ruhpH28-GnnTq7@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fbd397a-0e37-482a-4749-08dd409193fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmVwNXlpWHJxZHlXWXNNc1BhUlF4dld3UE9rU1pBdEdZMDBWLzZkejk4VjJF?=
 =?utf-8?B?WHJ0QUlsdXJydGxUcHp1VGdvcXVDUXZEZlNGVTdRS3U1TXU0enI0bERLZWNl?=
 =?utf-8?B?MHhhMEEyVk8wMk9KL3IxZzZFcGwrazRMbkFVRUFKS1J2L2hFN0cydEVTbENq?=
 =?utf-8?B?a25PK0orTERBZi8wOWwycmpaemhYQkZFZzhCa3NZUGdWVlJVMFV5cmV2RnVz?=
 =?utf-8?B?VlhxZDJ6enIvTjI0cEI3bnovcjFpYW9DV2tqelZITUMvazZzZHI2WjlKelBC?=
 =?utf-8?B?TWtCN1lJQzQwNGlENmtNNWlIdXdCOGRubG4weHV0bGpBOUxFc3RoenJtVGNG?=
 =?utf-8?B?VVdCUHAvZ1lZV1FnclU2MlNyVEs1a2t5cmRlaFd1ZGpnYjBPVEtsSkhaa2I0?=
 =?utf-8?B?MEk5TTN1UVBCblVZN3NCd2RUVVNtM0lMS1g2dDF2S29ETHdQdmxCTlRRMkNw?=
 =?utf-8?B?YWtBYVB5aTIrS0RIcUJiN3J4aUh6SkdtRWYzSnpjOUMzYnE3NTVxMWllalFU?=
 =?utf-8?B?UytpVmVOdVBFMU5PWXlqQWMwZjkrekhTYTRneXpIZ3lDZEFXMHlTK0RmU2RO?=
 =?utf-8?B?SXk0cXA5SERSWlBLbS81N24rZVZFS2piWmphZTBDQmEvWGNoVmpOWkcwb2ht?=
 =?utf-8?B?Zmw5WUFrektXWlByQVhXNFVsb2ZzTk51ZzU0enJTZWJDaGNEVjZYZ0xMRUdv?=
 =?utf-8?B?dHBSUXZicWVjYkZBVHVIdlBJUHNUUXJGNGs2TTZua1FqNHQycE5hWmxiNEor?=
 =?utf-8?B?VEpvZS96dldMRzIvY2pUWTJVbkNxUU00Qlc0a1VtdWN5QWNsNnN1dDFYb2lG?=
 =?utf-8?B?L1ZydmFIZUdwcVRBVGh3U3BEUlpLaEd4OHYwMmJ3QTlsSVhMLzVDbUU0Q2l4?=
 =?utf-8?B?WG9XUlJsRTFzdU82RlBMcEFyUzBWaWJDdEhzZXpVVFgybGZzYmR2RTdVUm9U?=
 =?utf-8?B?VGhNRjJGTUluR0NHVkFyMzcrVmphY0o3WGVBSkNMenhmam1JVSszVHJ2cWZv?=
 =?utf-8?B?WVVmRmFmcnl4MHRoOHphV1dyTStUSDRDZVU2SEJWd2hPSjY1eVdCeThBRDVs?=
 =?utf-8?B?b3l6TGM0VVAvRFA5cmZrL01xNDdyOEVScW4wOUV2MUswUmxFRzVaeVRHNzdt?=
 =?utf-8?B?K2lIbnZTS3lINzNxQkl0bUpvWWVCTm4rbTF1RDJITjVhWEFVTHhJdFk1Smp4?=
 =?utf-8?B?cEkyR2FwSTdjOFpSNUEvUkJQenh4YmlzanFqcHVvRHhCb1ozWmNPcXZmRmg1?=
 =?utf-8?B?eCtqeW1GUHhKRGd1ZnpKcTBXYmpLVEJUdGhxUHdaaTcyU29xUU8wOVVzd0dh?=
 =?utf-8?B?RVNyamZJZVQvcCtxNGk4Q3BZQzlHc3R6WWducmxGdkRDeUtyTTU2bU9xcWdh?=
 =?utf-8?B?a1ZKVitmbkUwUTNWMXJNQ0U0N0RYMzZDNkE0aDhDR0syckYzYW5aOEEvMU9v?=
 =?utf-8?B?UytUUjhFeCswSVRhMDV4bDlDT3E0TWI3eE9UemNYaXF6RVo3ZVpmMytFVXpp?=
 =?utf-8?B?a2Z4Ty9SUjBaOFRVY0JRU3ZTOWhkQW1lSVNsc1hzcjA4Y29ENlpQWGl4Qm5w?=
 =?utf-8?B?cklESGpFSjM0VUxNVEhORktkTnQ4VVlMeno5Z1VpbFQwUFVmbEh5QUNBbUJt?=
 =?utf-8?B?WnluMDB6NWQvOE1peDhwRmJ2bmFmS3VVSmFpdUFIaVkrZjB6YlNZTGhiL3Fo?=
 =?utf-8?B?SkJsOUp4U0Q2bWdvUmNaaThYRGNSdStjRkU0UDlucitkOTd6R1RRbGlieUc0?=
 =?utf-8?B?Szc3M2EzL0V6VmloOHdVNU9EOEplWjAwNmRTcWZKYmloMFpZa0lYWk9McW52?=
 =?utf-8?B?Z0kwQUtOYXJ3bURTQyt2ZFpPK3RIbHlwa1EydVN6dG5RVHpMSzdaQVIxeTZv?=
 =?utf-8?Q?PqsTAKzcQ/loY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHh5dlM5N052NWZpdEQwVGNFcFhPRlEwWXczVFJIcnU0cTRVQmIzWldVZ0I3?=
 =?utf-8?B?bGRBUktLSGs2Q0c5UVJxbEIvdjJHVXJaWit1SDlXMFFoVUFnNzdUQ05sa1kz?=
 =?utf-8?B?cFdxblBrQnM3aGhhc1FRYmltenp6ZjlxK0JTNXZnUGV1cUlBVlFncEVqaGZ2?=
 =?utf-8?B?VmdtNlI1OXA0bFEwMXMwQnJMVllwc0UyK2ZSZDFsQjF5d1NZVHFpaEpPckU3?=
 =?utf-8?B?WE9CbE1XS1VRd2hLM0prcG5WKzY0Y0tlTXFObXBvZFF6SnNOczZZRTByRVFv?=
 =?utf-8?B?Qmw5WnBQV2grSHpoR3NET2VpWTEzaFo0NzVWL3Z4NE9rQmczUnZlMEtubGZQ?=
 =?utf-8?B?OVJxMGRiUlgvWEpGbEh6bFNSWWw1Y3lvQmhSU2tJK2JrNVVxalkyZHgvTG5o?=
 =?utf-8?B?czRnUXR0WVFzTFkxeUxjcWh2aUJWM25DUzhQTTVTWHhwbDNJKzkzRk80bFdV?=
 =?utf-8?B?R0Fuc0R6NWFGWERaZGpMQ3ZVQndGZG9nbjRja3ZVZFNTTmI2bitkNDNCdUp1?=
 =?utf-8?B?VGhvS2g3VjVCcy9ISkNUczVUT2M2ZFJzc0xKazVpc0dCQ0RpWTdtL3VuVTJV?=
 =?utf-8?B?YjZOVG1OaXgzd1MybnlHWUdrWnA4Z3JJYUFuU25ob05pUHBNVnFXd2JBR1FY?=
 =?utf-8?B?TUFSQkRLK2NER1JRTmtib1ZvMlArL0ZTWnNzNFhZZW1jZGVpd0J0ODhDczdR?=
 =?utf-8?B?SWJhd2ZOMlhhR29jVG5hOHliWWxac2lXYUF6Q0dHS3Q2TWcrb1dPU0NnTm82?=
 =?utf-8?B?WUxkV2ZjdGRLaUh4VnMyQ1JTNjBnWkhGUHBwd29zcFd1Z2F6aWFqSEhORTBU?=
 =?utf-8?B?by9BaW9mV0FKbytmeGl6dEhLY2xESjlHMWxqS1M1UXFZcVU1NjJSU2o4Vi9q?=
 =?utf-8?B?NDViL29UNVg1bkNDRTBoa2ZTbHZYSExUVFQ3MGRuQ2k3TlFhMFRNRXh2bzFi?=
 =?utf-8?B?T3U2Ly9hcXJ5ZlA2bUduN0t6QWlHZjVSTGpWdVYzNEZVdXRtYStUT1JtZ3R4?=
 =?utf-8?B?RlVyWUYzRUM4Nk1VSFNaaE5ZUDgrRnZPMGExVmhDcFVqelM2SlByWDlvRjVR?=
 =?utf-8?B?Q2dybWY2YU16dU5xMUNDQm5oUGNuREF5Yjd6eWJydnJ2aDdRSEZiMzdaZkpx?=
 =?utf-8?B?WnB2QjNUMFhmeFJOUEJiM2dFZEhWOTJ6WFlBblRJNjE1T3g3QVdNbGJ6RnU4?=
 =?utf-8?B?SXVPc3BQRVd1N0FtV2pjRkUyd1RaUk8vNlNvTW8zejdrQVhyREtycU9PVnBT?=
 =?utf-8?B?ajVYWjJPYUZlaFB3VElRUHBTdnNZWHhFZlNjc2tiOGZEK3gzMzhuWTRxTmFD?=
 =?utf-8?B?M0dmWFMwSC8yQlRac05URExXNXZ1LytJRC9GWUthSThvcm1ubWFlbVJwRHZw?=
 =?utf-8?B?Wmxvdzd3SXJVMXdCRGZodUhvYmRucGZneFNqeHNKaXlzelFXWU5oRUQySjgz?=
 =?utf-8?B?dE05NWVDbnczc2dxVThUVFJBSzh4NjRlZkN0QUl0WHZxdjEvQU0xemoxRkJO?=
 =?utf-8?B?VFNDR3o5SkgrQTkvcTBWUmhwY1E3K1dXQnI5VXFJQ1FzSitRK3Vud3pGRzlP?=
 =?utf-8?B?eXI0d1pUZGlHMHZVTFNHVGVxbGZCZWdTeTlxVXJrUWVUVVRoNmFjVGFWenFx?=
 =?utf-8?B?Q3pSTEJnQzFnbG9UQ2lyUkVuQmNnRlRmdW5SNEltaTRxM050MG0zWlEvM3BW?=
 =?utf-8?B?UnZsOHNIRnU2VHRmMm16eXF6VXpTZDdReWFXa3I1WG1ZbGlIWWg1ckRNTkQw?=
 =?utf-8?B?N0k4VmJRWVhLcXRuOFVIQ1RtUkNvS2s0eTg3T1FkT0N0NU0valpBaWZZT3Nh?=
 =?utf-8?B?dG9nelVHdnpJcFc3cXRTMHhKK3RTa1YvTlRET0FvUXpYUEE4cktrQVZObG5h?=
 =?utf-8?B?TlNMaEkyM1BCdjhmYk9neXROV21Oa0dObVB6Y3huQ0I4S3VMcGkyWVJWUFRP?=
 =?utf-8?B?RXJaZ1kySVhwTlBvVFNIODd2MXRaSGpOTDNsU2xXMWhRY3pkb0x2SWVFdDdV?=
 =?utf-8?B?Mkg5MjFpWGgxekpMa2doMXg4b1NJUWIvaHdYMGVsNi9MeGJNVXFkVG40by9m?=
 =?utf-8?B?MVhWKzN3WVZyRUdJK1ExY2xSL3BRbFVQV0FSSi9Qd3Jqc3czK3lBQmlydkF6?=
 =?utf-8?B?YzAvd2IxL3laRkhQTnpzWStsN1FqczFqMCtaMWhkOFhKSUhVOW9XMmRLQmpo?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CxvR16fcnfkGI+uFI75UwsJ+whNKtexd8gZTazQQsRMe+Fdecsk0ngoFM2C1JyP4sH2cm8yvSp+gjBPawDVW6846nDnujrd7nxb2u0nErtvyoFjZQq6/BKdc9WOjtIPbGI2TljSwcUIFwYsjroaLPsLUJw3ndF0PcjkDTWq0WxcJMFjpX6hSgbhrQ0F/LvWkAfQoIyPxXsXbZzj0H87tw4ze7fU+n6E8u2YHRTz4uEA6ohFC4N0ugp3lHPMedj8AR/+C5b1QbY7/BqbdUGdwf9+PS0xYGliCE0GwSiv5t30oJgdfT67vw4VFo614C2taSRhgzEk2Qe/Huog+SJSNc7dvTF5NozQt7A5oZ9zAnA8D3xFLN3IbVpAJSyqKIult5dCkjLgtc47cCrpuamYf8eFakBx7RxPDK75x1Nu6wDB92LFXTkvgDJolAecePBURpl8OHnjNpo0qOo0jgkc0m1C234fj58TfV+VBqEZrXHjGw6z9Xuk/hO0SDJVA7aqH8a2tkbL2rP2+8C9rDTqEl7rq85XeSajgvma9UL2BsyyLNZyLsncju60nl//gNjY4uG0JN7jQWSCMIhSSzrbKcyVEv4YlzTpbjm/cH/mBLM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbd397a-0e37-482a-4749-08dd409193fa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 18:20:15.5426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL0qqxMAnxe9E3PaHJG7wULA+6avWFQMwJebpY5yUxNQ8GeL4DmaJADNYy+Gt248+4KsE+00DawopYPf6ue3dCmgDdvlELJ2ANBuR32miWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290143
X-Proofpoint-GUID: pGqkVKkf02QCmVheAKUGXjXBWrKquEHT
X-Proofpoint-ORIG-GUID: pGqkVKkf02QCmVheAKUGXjXBWrKquEHT
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

On 1/17/2025 6:57 PM, Peter Xu wrote:
> On Fri, Jan 17, 2025 at 02:10:14PM -0500, Steven Sistare wrote:
>> On 1/17/2025 1:16 PM, Peter Xu wrote:
>>> On Fri, Jan 17, 2025 at 09:46:11AM -0800, Steve Sistare wrote:
>>>> +/*
>>>> + * Return true if ram contents would be lost during CPR.
>>>> + * Return false for ram_device because it is remapped in new QEMU.  Do not
>>>> + * exclude rom, even though it is readonly, because the rom file could change
>>>> + * in new QEMU.  Return false for non-migratable blocks.  They are either
>>>> + * re-created in new QEMU, or are handled specially, or are covered by a
>>>> + * device-level CPR blocker.  Return false for an fd, because it is visible and
>>>> + * can be remapped in new QEMU.
>>>> + */
>>>> +static bool ram_is_volatile(RAMBlock *rb)
>>>> +{
>>>> +    MemoryRegion *mr = rb->mr;
>>>> +
>>>> +    return mr &&
>>>> +        memory_region_is_ram(mr) &&
>>>> +        !memory_region_is_ram_device(mr) &&
>>>> +        (!qemu_ram_is_shared(rb) || !qemu_ram_is_named_file(rb)) &&
>>>> +        qemu_ram_is_migratable(rb) &&
>>>> +        rb->fd < 0;
>>>> +}
>>>
>>> Blocking guest_memfd looks ok, but comparing to add one more block
>>> notifier, can we check all ramblocks once in migrate_prepare(), and fail
>>> that command directly if it fails the check?
>>
>> In an upcoming patch, I will be adding an option analogous to only-migratable which
>> prevents QEMU from starting if anything would block cpr-transfer.  That option
>> will be checked when blockers are added, like for only-migratable. migrate_prepare
>> is too late.
>>
>>> OTOH, is there any simpler way to simplify the check conditions?  It'll be
>>> at least nice to break these checks into smaller if conditions for
>>> readability..
>>
>> I thought the function header comments made it clear, but I could move each
>> comment next to each condition:
>>
>>      ...
>>      /*
>>       * Return false for an fd, because it is visible and can be remapped in
>>       * new QEMU.
>>       */
>>      if (rb->fd >= 0) {
>>          return false;
>>      }
>>      ...
>>
>>> I wonder if we could stick with looping over all ramblocks, then make sure
>>> each of them is on the cpr saved fd list.  It may need to make
>>> cpr_save_fd() always register with the name of ramblock to do such lookup,
>>> or maybe we could also cache the ramblock pointer in CprFd, then the lookup
>>> will be a pointer match check.
>>
>> Some ramblocks are not on the list, such as named files.  Plus looping in
>> migrate_prepare is too late as noted above.
>>
>> IMO what I have already implemented using blockers is clean and elegant.
> 
> OK if we need to fail it early at boot, then yes blockers are probably
> better.
> 
> We'll need one more cmdline parameter. I've no objection, but I don't know
> how to judge when it's ok to add, when it's better not.. I'll leave others
> to comment on this.
> 
> But still, could we check it when ramblocks are created?  So in that way
> whatever is forbidden is clear in its own path, I feel like that could be
> clearer (like what you did with gmemfd).

When the ramblock is created, we don't yet know if it is migratable. A
ramblock that is not migratable does not block cpr. Migratable is not known
until vmstate_register_ram calls qemu_ram_set_migratable.  Hence that is
where I evaluate conditions and install a blocker.

Because that is the only place where ram_block_add_cpr_blocker is called,
the test qemu_ram_is_migratable() inside ram_block_add_cpr_blocker is
redundant, and I should delete it.

> For example, if I start to convert some of your requirements above, then
> memory_region_is_ram_device() implies RAM_PREALLOC.  Actually, ram_device
> is not the only RAM_PREALLOC user..  Say, would it also not work with all
> memory_region_init_ram_ptr() users (even if they're not ram_device)?  An
> example is, looks like virtio-gpu can create random ramblocks on the fly
> with prealloced buffers.  I am not sure whether they can be pinned by VFIO
> too.  You may know better.

That memory is not visible to the guest.  It is not part of system_memory,
and is not marked migratable.

- Steve

> So, to me ram_is_volatile() is harder to follow, meanwhile it may miss
> something to me?  IMO it's still better to explicitly add cpr blockers in
> the ram block add() path if possible, but maybe you still have good reasons
> to do it only until vmstate_register_ram() which I overlooked..



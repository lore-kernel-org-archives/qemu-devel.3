Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7CDC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJUV-0004td-69; Tue, 04 Feb 2025 09:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfJTr-0004nV-Ur
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:00:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfJTo-0007RR-A6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:00:47 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514DRgSn017272;
 Tue, 4 Feb 2025 14:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=AAtYEJ6SsS93ACddnjsdgKYgzbJeix4cg+Ki3gnR9Is=; b=
 F+AIb4p7iqEJtVPnJLBpcGbvhwzDKJSHHXB0BNvnASsE2nEY3QMnIBVZTWYGmQld
 6Dak+xFX+n9idlXkGXH+zntjT66lVKw1zOl7df2tDFPH6T2FTX1guj/6pWNWTFo2
 gJag0qgmCTT38Yylt9F7/odpDAloHC2VeGRLTGuI4KXsdXt4Z9vMWX2r0o8c3cOB
 786bmmVi1DygCYBljzhMMcEhxmvoUDjMkSFlKsUvP+bKOivSF5YmtVcGCFlVoIh5
 QDQI+n4/qMi4Q1I+2z0QrLrzSp356KipSRR8N3rc6HR3hBekakljF5yNRfKEqehB
 Tm2saBnF7wnuczhqT9vh9A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hh73mnff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 14:00:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 514D4CXQ039045; Tue, 4 Feb 2025 14:00:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8e7qt0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 14:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZgFlHexu3B88+xTeT95HBAp6ID/rw/kE4Y60xFkQiCX4UXOvnqNuhYrJ8eCcEjSimkbvVE52SBtNuo7y3JQwKiB1AhrrxmP51cKNlEwDFzJDePtTnmhpcNRbzTtKAbRaiyN3ldwhCwAY+YPmVPOqWbeEVqnYQZIRkNzpG0OOAmzvXcEgrVgQUjl/CdPJAMClYQQT/7ofSM7oqEnApqUsKgnrM5m2cjc/qY0pcTKeFlKGhnYLcjfGa7jh3ohu+V/lpgodqjWp97yrUwbBym/nb0cx9Sok0hP1L2lNkRAKKQlKKPwN+BRxXVT8C1xv/lBzgi3Ho2YtfIhGIDdcWRQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAtYEJ6SsS93ACddnjsdgKYgzbJeix4cg+Ki3gnR9Is=;
 b=GYAnSCLKkz1kzNP9jFppBbuI4ROF4Nfv/Qs7ZfVNVndJcjhifIo66Hd8bED8JELH2rhMp5Wj/lZ5c+ltClNblyDMGG1eZ7UHg9Bn9mwKESk03yT0bHbQ0c1EgXrEbqTpXz4PazjMAuKsyT5BgkS8HKwiWcW7L+bkoIylXmTkyl7wQPYYaw46wChuHpt/4FLEzNWU6p9/kj5r3bTaEx3NZ6JJHyH/Z2tBq4F3kX935OPQ5cu8WCIK27SbSfYEy7tQQqVFmL9Rhhiz1j2znrPZHCRELf+omIlx79tFcXym0gBrlzbUGc9zLv82G4ga3KJMb/Ykn7nLU8uf7j3/kEG3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAtYEJ6SsS93ACddnjsdgKYgzbJeix4cg+Ki3gnR9Is=;
 b=JLHXlKtQJnBG5V08l53b91dmNzWKwAKT1W7NNBH9+Djrp3qM3UAGILFHXDLK9u8Jlh/lYGWVcYBkihvHScLYNePs8S9slsUis0HcXFVP6ULYgZ0Nubi1OH3d0wxVExU8R8TKsn2RTP9RDmhNqX15E+YW5/e3xnEWTdtarKmVcg4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB7426.namprd10.prod.outlook.com (2603:10b6:8:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Feb
 2025 14:00:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 14:00:35 +0000
Message-ID: <9295d5cc-775d-408f-8554-1ef5db823748@oracle.com>
Date: Tue, 4 Feb 2025 09:00:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINER: Add a maintainer for CPR
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
References: <20250204082859.846886-1-clg@redhat.com>
 <8599e016-4ea4-4c1d-b4d2-c583c57a9558@oracle.com>
 <8638674e-5a79-4405-9063-89ba78112c8f@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <8638674e-5a79-4405-9063-89ba78112c8f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:52c::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 49de64cc-7d39-4386-3156-08dd45244be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bytDQXJUUEl6ZktoVlRaODRhRWhDQzRjTWJ3UzZ3bUlVVy9yTEpCNkJmd3hG?=
 =?utf-8?B?YTUrdStmQWhvN2tVbzRoRmo4YXpnY20vTXcxRTJ0Mll0bkJMb0dvcVZER3E5?=
 =?utf-8?B?NWlFTVFYOEFMaE5IUW0yVUk5eHh5N1lFYUpnY2kyRHVWRVpUYUgzRE9rdWFM?=
 =?utf-8?B?c3BnWVlzVVRPdE1qMHdudTlWWjRkTDRHZWFqcUxXV0N3MThLZDVmamMwZmtE?=
 =?utf-8?B?dmhjd1cxSXd3cEZrb2xRWmhRbFNyUTByTTZPWjErQU8renVLb0FDeWR5UGQ3?=
 =?utf-8?B?NnltTFp1U3IxbEdiak1USkJNTlIyODNjMkdGaUNPWnArdzVibU45SUcxRjN2?=
 =?utf-8?B?RDdHbG1rQkhGaTc5K3F5UVpUcDFpd0RwVjl4MGQ1bjZUTEN3M1UycE0wM2dk?=
 =?utf-8?B?KzViWXRHN3h1WEZPekdWMHpycGJKOEVCRGUwVlk2c0oxLzV4ZDZSbEZXa0M1?=
 =?utf-8?B?Y09SQXZ4N2RBNUw5MkMvSVVxMnNYWjh5b1ZaMkhaU05aUnNlSERBUHl5MFJO?=
 =?utf-8?B?Tm9nb01XTnZVUnhuZkxXZ0x6bkFDdlJpWjFzQ3p1dWJSODdVVjRHeDEwR2hx?=
 =?utf-8?B?NHdQSU5wVG05cmlacGdFV1B2Y3ZPRHZqdFE3WktJMmR2MTJ0bGpKZzQ1ck82?=
 =?utf-8?B?eTRSaksxckFaTDZUM2tsQUlPT2Z1Yi9Wa3h2RG5VYWl4emdWcjIycDZyaFlr?=
 =?utf-8?B?d0p0NXV0eXNUUGI1THFieEZGcmVHejM5L0wwUWFLSFB3T3NJRzRudGxFMGdD?=
 =?utf-8?B?TzJlRHgwWFBac3c4VDhFWTd0ZS9mckV5NnFtUVJ5UVhmbUt6V25mR3VoMVlW?=
 =?utf-8?B?YzJJUXlXTXNYMGlJOXdZQm1ZQnY1bWh3M0RvMmI2U0tVTktHMVhTNUxURlFj?=
 =?utf-8?B?djFCdnRWY0ZoMHZOMVBvYjdFbVlyKzhPUVVsekhhQVlYM2NSMmp4bW43WUZm?=
 =?utf-8?B?QWlhOHBWelFwRDV4UjF6b1JmanB6NFFnbmJSN1Z2TWgzQmlJamRpRzBjTHU1?=
 =?utf-8?B?SEd3TG5SQzVmTXJzSDFiWWg4T2pSSnh3dDZzTmRHNjFaSzZ5S0tYSU03SXEw?=
 =?utf-8?B?SWhESEdXVURBZUM1cUV6UXVQcVRnMDI0Y3RKMXY2VGNPWHp6QldsZzdUdnVE?=
 =?utf-8?B?M2tOUTlmMzg3NHFDR3ZiTVl4YXVhNFpIcy9SdkY1K2RXV1FuVFpma3V1bFBH?=
 =?utf-8?B?am1LWEJnM0xkRlp4ZFlYZXFOUjJ6N0c2YjJhNlNlelJGRnVWaGV3NTBRbGt1?=
 =?utf-8?B?V1FoQXlPWHQ0T21TdlpPNW5HS2I1UUFhdTZKQU5VckxTVUpUa2xoSWF4ZHhw?=
 =?utf-8?B?RC9qWllDcnZkKzgwY2ljcEdOekdZb3YvN3lRQ25yelpxZ2JXMjRjSStmeWdk?=
 =?utf-8?B?L2YzOFZZZEZ2Z0MwaEdLUUxpYlY4MGl6QWt4ait1dVpMNnNOVUpwTlJ1VTdH?=
 =?utf-8?B?UG95b21LbUZIbU0rMFdOeEN0Y21YTDJGSDRPc0UrNmpYQzJoMkRUWmVocStm?=
 =?utf-8?B?UHpVWGFmU0lPSEpkbGJvTS9HdE1yYjg3Q1BZRVI2REJCY3BMeGhzTk9GOHlr?=
 =?utf-8?B?Wis2SllEK0tKdHgyRS9PY0hydzEyeE5oZDdBU0YrV05HVTlpZGEyRVVXVFFD?=
 =?utf-8?B?MzFSRklUcmg0UGJRY1VFK3NyUURXN2R1WlRUMyt1YWJlK25OaW1XQlpWQkdY?=
 =?utf-8?B?ak1qM3R6dEJiQUk1S1dJUFBsRWw3a0d3Umw1QXp6WlV1d3ZhQ1BMZXF2enZs?=
 =?utf-8?B?ZHlGeW1LUjVNdEZmS2l3RVRZL2lPNTdXazd3ODA0cDVkUDYxRHZrdGd6M0NB?=
 =?utf-8?B?STZsNDZicDRrTGNXbHpEZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0J4ampuN3grOVVJcEdHT0c1aStWOHllRGZySmlaV3MvUU0wczloa3Q3L1da?=
 =?utf-8?B?cStsRW5IKzZtblUwalhGYXUwQ3dJc0V4NDFMSEY0MHIrVmVrcG03QjJXaEd1?=
 =?utf-8?B?cTR1VHFNaDlmS000dHg4SWRla2M3MEtFekx3QnFxWlJuZUxZTUxxbnNKdDVH?=
 =?utf-8?B?UzJROUxyOGd3MEJ1enRobktLMHZhOUJCclkvV244UGRXMGV2cjMxYUlobWR3?=
 =?utf-8?B?RFVGWG5HTVc3VG16RFZIQ2NBcTBHUGhmUVdKckYwUUpmRWpJWGFLTzRjTDFL?=
 =?utf-8?B?R1JtM0d5T0s2VUdTYWlKczVGVDZ2am5QU1hpcTU2Y3BTeFBrUUFpTHV1RGR3?=
 =?utf-8?B?dmJ6OEREZmZpRW5mMStQenA1VHI5clRCbnFTWEVJekdqMFNiZE10UXpuNzlT?=
 =?utf-8?B?NERsMDUzSDBEdjRsR1M4WkJ4dk1ISjhhMFBSWUd6UkpoaTJOZ3lHdzFuOVBU?=
 =?utf-8?B?bnRqemljVjZpelI5Uy8zdGtTNWFpeFRBOGxlUWZsSnBRVjUySXlqOFBHNUhl?=
 =?utf-8?B?bmNwNENIZHdERFIwQTQ1UGJDelJFcnZvSk1vTURlcXZ4Q1VvZDRadGRPWWlO?=
 =?utf-8?B?c3NiRXNMK29vTjlvbkxJcFg4c2RSVVIwZDRyczFJaTkvWW14b0o2SjhnU0Jr?=
 =?utf-8?B?dGJrQktZLzJiQ0FsdTZjajhUOVBTYmxDODhZcjVBSVpseVIxaSsrT08rQ1lx?=
 =?utf-8?B?djRxdkh1ZXV1T29RNXRlZUErV2MrMnk3RzBEbTNpNm1sbXpET252ZXNWZE5E?=
 =?utf-8?B?eVo5cW16aW9YZ3IyTU9kalVuN3BZUGpvWVVndDh4U0xvUHc2VHdSYXBwUFE2?=
 =?utf-8?B?cVE4ZWpCYW9SaSswWWV1c3RtN0ZDUTgzY0NQMnZwV1JGTGFieWEvZ1MrdFlK?=
 =?utf-8?B?ais0WUxCdEVoZ0VGQVFucWtVbHNNQnR4aWs0M1c5Q1l1SHNJSDd4WEtBTmgw?=
 =?utf-8?B?eHNnTTA3VTNsT3lsUmpCU3RHNk1iMW1HYWVXanVBSENuNEUrdFRMeWNUWi9M?=
 =?utf-8?B?dDM4N0hVR01rZzZyUitYQUVCZFljY0JPT0pYRjF3MG1DK1pHaWdDc0Znb3VG?=
 =?utf-8?B?RlRpcmFDZ2tNRmEwMmd1WnUwSXo3YUZPVmJLTzhKOHZ2MG1iZmpNQlJtNnlu?=
 =?utf-8?B?TUdaeFZrcjFBRzQvU0U1SlV0WXdZVUtYUmpodlFaZUEwRUc4QWdrOXVGK1Q5?=
 =?utf-8?B?VGc4d0hETHVjdjNPZWU2VEJ5clplNHFTUmxjaEljM2tLNUNDcWRjd09CSnRB?=
 =?utf-8?B?bUtOWkFvZ0haMmZSWUlQRW9PSC8xNnk3K2tYaXpXZVdNUFdNMTBacEpoeXp6?=
 =?utf-8?B?OGkxWlhoZUEvTVJaYUpLSDNqMjJydDRwaHNvZkR0UG9hQVV6ZmxZblNuRzJF?=
 =?utf-8?B?Z3lOVTh3MnQ5Tkw2MnFReXdNbEhkVjk1TEtEbU1uRTRKZjNtb2VvZlF4NTZ4?=
 =?utf-8?B?NVNGdGtPSDFBUW04Y1ZQQWFGcTNzbTZFMVdIR1pjRWpiN28wT0REL3NleUdJ?=
 =?utf-8?B?K1Q3RlNNNEpsSHVYNFdaclJ4cU1RdFZ5SDBCWjE5ODl3ajRUUDg4Sk1rcjZ1?=
 =?utf-8?B?Njkrc3A0bmRYL2RaTStaaFJYamtlVkVCRXJIWWVXQWRyYzR3b0JtcEthaC94?=
 =?utf-8?B?dnMxc1RiZXY5RG9vcit4Uko0ZHA5WVFTVTFXckhTckxyR0trNlg3am9PQ0hj?=
 =?utf-8?B?MHBwYm9mUUFHUnRnMzU1SXRoRHRhM3FhSkd0OE9XWXhPbjBMRU45d1NiMnZS?=
 =?utf-8?B?ZmdzYWovNHFyelRVeWJLS0pERzE2Y2FFTnB5a0RSVVR5WEtxZlo2Q1JsNC9m?=
 =?utf-8?B?U0lCRlo3ZU5qdDMrMU1zYzIzb0N6RS92WjJYclN3SllTU3RkcWN1bVd4bTVS?=
 =?utf-8?B?K1RkUEFLeEo3OFdnRDRGamluaFFtdU1NUjdqcDhLeHpjRlR1UWxqZkk0SGFm?=
 =?utf-8?B?N2QrYVE4N3VXd3gyazA5WXh6cWR5QzU4V0VRc3V3eDk5ZHhlV0t5WjhlenEv?=
 =?utf-8?B?RXN0UHBuM0xGUlJLaXFkTkI1UXN0YVVvc2RjeFVOaGRFOHAzVjhtSGxNYmJD?=
 =?utf-8?B?QzRmZGlUMkYzQy92T1BZWGVSQ2E1eVlkbUozWHBkZ1ZPUzJBbHFJeVgwS2pu?=
 =?utf-8?B?TkhIWFMvRVVNdzhyQ2ZlNGU5TTNZdWJQYkVuKzE0NXdLMU5oWFJNaWUxdlZr?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6bOPZIn7RYRYLsG+S3gtOzs37apnz+85oYCM0huJ3pNYnAJpky13IUclzNdgD+E5WiHl3ri7cJ0zI8e+FlljLGCW/t5UjWICZcgkdUCgWZG6RMBiX1L3IYoU3GZnIl5mmSA0JjqlYPHU1JqwBokNFLyr/dOodZia+KF28TZyrYwOJJuCvidnvK7oG3wQWK0Cn+CoJPgkD1RP82jyqFDgl8pbyuzum/7INNUelhveUqlTA+7ITCEkIDPuv78Vr9Kq/w1d4utr5451Y8M1W4ux/kClpO/+L+7xX8CZz9jmsa/WQsjQwO73J3WmPFM3RjBMFwZtNlh7dTOfDunNh12ZLfXcxqGGK4Xs7Hoh3KWMa4XEo0szAwETavEUTM1VFsO8U3OEFiTQWRY5mSEEEC+Ru1l8Zxp5k/ZcH8CO1Am8NyBuGIVX2zk5BsjrHQDjLwwmV+ySL1JzqDdEUNDK+v2jTqjpGEUJCbKCQVCdEAk1OLz/IKm2lwC0NLakGDPbxvqRNgPmtRIyYCAlnRwpfdUXxxXQ864JrJrpPJgcO5H8aB1UAMcgQ7p+iPKZWR9Msg8D/H0oA/GDpWvNPYiDss2XTGSR+k70t5rtE3UWy7t6hxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49de64cc-7d39-4386-3156-08dd45244be5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:00:35.2438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYxw6ocxGop3YE9J84z8HaEVxK5BvLThkp6LuQTiHGF99S1gHmzogAShbx28SwR0szH/3GN1suyFa0j2nXQF3OBlRezb9yt9h8FavukLsGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7426
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_06,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502040111
X-Proofpoint-ORIG-GUID: vc5Qz5BgnW6hzJ0lkuc5af6KS0UGu0B1
X-Proofpoint-GUID: vc5Qz5BgnW6hzJ0lkuc5af6KS0UGu0B1
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

On 2/4/2025 8:42 AM, Cédric Le Goater wrote:
> On 2/4/25 14:31, Steven Sistare wrote:
>> Hi Cedric, CPR is a mode of live migration, integrated so closely that
>> it makes more sense for the migration maintainers to maintain it, and
>> consult me if/when necessary.  "migration" appears in 4 of the 5 paths
>> you list below.
> 
> CPR is growing with the recent proposal and it is a large enough
> feature to have its own maintainer IMHO.
> 
> Should we add cpr* files under the migration subsystem then ?

Sure, I'll do that in V2 for the vfio series.

- Steve

>> On 2/4/2025 3:28 AM, Cédric Le Goater wrote:
>>> The CPR feature was added in QEMU 9.0 and it lacks a maintainer.
>>> Propose the main contributor to become one.
>>>
>>> Cc: Steve Sistare <steven.sistare@oracle.com>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   MAINTAINERS | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index db8c41fbe0f9..efb9da02f142 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2943,6 +2943,15 @@ F: include/qemu/co-shared-resource.h
>>>   T: git https://gitlab.com/jsnow/qemu.git jobs
>>>   T: git https://gitlab.com/vsementsov/qemu.git block
>>> +CheckPoint and Restart (CPR)
>>> +M: Steve Sistare <steven.sistare@oracle.com>
>>> +S: Supported
>>> +F: hw/vfio/cpr*
>>> +F: include/migration/cpr.h
>>> +F: migration/cpr*
>>> +F: tests/qtest/migration/cpr*
>>> +F: docs/devel/migration/CPR.rst
>>> +
>>>   Compute Express Link
>>>   M: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>   R: Fan Ni <fan.ni@samsung.com>
>>
> 



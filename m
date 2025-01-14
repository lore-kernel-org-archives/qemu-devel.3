Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE38E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXksP-0007KW-Ao; Tue, 14 Jan 2025 12:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXksJ-0007K7-Gd
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:38:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXksE-0002GT-Ub
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:38:46 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC0oMi014279;
 Tue, 14 Jan 2025 17:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=GmUw1DVuNZ0Dmw0aDDn1X8zGH9wOjimUU44/iWU8DQM=; b=
 YVlHHdfmoE7Tf2Fa+Q3QDNBzMj16Y34vil3FWnpbJ69rTziutO/tuG0yoPCHL2m9
 8Pl8dHKiTBl2o0d4rTDIHk7UQPTPLAJl1/M0+FfaDwMfbzk3jQwF94LFhOz+glTC
 qHH5ZDClHOURop1NutgNiTalQB6cTRa3qPtjvp1jTtMcprQg58HytFoiMAaIinsZ
 YTwKSplWYu1j8GTgBmXW/v+A/ehGA0YC4XJN42l6DVoSu9NCun8Fw9lR3s834Aur
 nDS/lXd4OCZTykASACIvX6see61VuLLBKLyJx0X10BSGjLVV+/FdHZIAoar3vmdy
 FA70zFUrkFg5jFV+AIkrqg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gh8x34p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:38:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EHZ6EQ033463; Tue, 14 Jan 2025 17:38:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f38echj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGjSwiGPK8nNcnhK2rKLZCKDPnlX9yLUeEPWBG5hukest7ZP4j4aLkMdc0sFraS7zvLemRSu716tOpp0vmtxEuQREnAOjyqABs0ZLXMrxmJwKddFQJVymJ2Ng2QnCbDlBoDdNqSkB2ot5VfzyC7snLUB5FOUREQlEBLqdTGe9DMFPwTi30TfF6WOE7dIA/gmsKMQ2V83bCVNrSiniH6QjJuPWBhjUwjFo7VFyzSq+LVQGVTWiVRFq30OUaeejWtFNsNhY/csI300WXXN2MznfpEOu46xqE18Imi3jeTRJ09pGuTqeAxtgDHEj6ojQYXpjz8zKKfIl/8nqSQLpFKerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmUw1DVuNZ0Dmw0aDDn1X8zGH9wOjimUU44/iWU8DQM=;
 b=ptjPHq21Rybqb3xHv3X9PAIld+jEFPK0qaC4Z0GZPNbq0iQ9i7JoW3x1zwV9EdAgIKUTFYvpc1/tVA6Rz0KDallOb4b4N9NygmyugWW3itY3Abdadf0opLtNU/iSElSlxX6ZufBZ5h6mDnLwIg0wKl5zSCypO3j1t8U7qDRjcl5BCCuQR+twHtEs/P9J+xi8YY/MLD8pNhmcFjOkzmvcM9C0agEBptTFo5JlcFTQ84KQEVonLFbi9/W4NBLsK97oi5Q0Fjn3sP/kXjmGhVMeh+ZL59Obd0+82AOHO+vk2vRT9lvWp+iysB+id+z+KZjv+TYMd2Vtkx1pMHXWKgQ7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmUw1DVuNZ0Dmw0aDDn1X8zGH9wOjimUU44/iWU8DQM=;
 b=OaTbuZZU6y0tfJGAfb8Uu9+4dQgxGrTChizmahz48po1qDu+DxWhcwFOJuNsld7azG1gkDKtQ0vbpdlLNKBkRq03rQBQa+XkF+cGKPN4Agkwx2FseBPu6cbUJFHeNr3OQg1pcP0scjfDy5xBIjVTnEk9o3MaQGqjc20+NEupeAU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB5842.namprd10.prod.outlook.com (2603:10b6:806:23e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 17:38:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 17:38:32 +0000
Message-ID: <74e95503-f59a-4b5c-87de-2216a1777538@oracle.com>
Date: Tue, 14 Jan 2025 12:38:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/24] Live update: cpr-transfer
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, qemu-devel@nongnu.org
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:408:e9::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: e3045dc0-3a61-4832-b706-08dd34c24363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXRyeEpELzdHSjZMMHB2a2d2THhQdTRibGNRdWV4WCswMUY4emE0TllPcjBM?=
 =?utf-8?B?SFV0d3dQYVo2dmNOdlZzdjBZVU1JVEpQQVZrSi90aTlpQXBHb1p3eGFKK2JY?=
 =?utf-8?B?Q3hsdUFuKzlFa3NPRXdLUU5ienlTK0FHdFVXdkJYZk9mZjllSkRKTDVwOVUr?=
 =?utf-8?B?Y1RGY3JGVlp2SkFEYnN5Y1VHZjdQcXpYZ0doL2dyc2VhRC80V2Z5RlU1WXBQ?=
 =?utf-8?B?MFVWdURGNjByNXhpc0NOY1lvckhmVnpmR2pxekkvUHJwNUVFM3N3akVDM01L?=
 =?utf-8?B?R3d3b291QmJ5WUM2TE1iNzlJVHZlZTRHTk1ya2dEaGFRNFpLQzhJKzBwcWZM?=
 =?utf-8?B?WTMrREZFUU83bDR2ZjlqdElzTDh1VkFVT0hBbWlJVjVQNDFTcExCMmdRY2JI?=
 =?utf-8?B?THlCQUdXeFJiWEhhOStBNkZWUW9iOE8zRWZpTlh1TFFBaHNYWUc2R2lpQUpF?=
 =?utf-8?B?bllUVkxpcG8wM21EeDgrMTRWRWRyczZqU0xUazExZTdmYkpRTWJ6M2wwUW9a?=
 =?utf-8?B?WENrSWxpVTRjaFN1NWVIRHpWcEFUNHVmdHhhYkdYVnF2U3Zlb2NtN2FjNnBL?=
 =?utf-8?B?aExhUk43K3ppTnljTll1MzZXZkNmSWtoY3U2TDZGcWdHZkVQbCtRVDUza1FT?=
 =?utf-8?B?Y21EZXVjalg0a044N2FmdklQbXJGeXpNYUZ2dnBtbkhGYVVBOGp4UFMrRURu?=
 =?utf-8?B?bHdaS01BUmVuZDQ4Z1ZFSFh1dDJPSlZrbTN6Sk1Sc09LbmJvYlJaM3FPcnVF?=
 =?utf-8?B?eSs0NUkvaTkxUzNsQm1RUnMyZURJblcvOGdLTWJiRVlRcnlkd3RtZHdXZkl6?=
 =?utf-8?B?OVFlVS9aUndzbDQ2am5IRlhVbUI0TjhVK1YrREpCaWxJZWN5TStWQXhMMnhB?=
 =?utf-8?B?cEJaWmNveVNMM0J2WlU2QjdJOXpBbGVLbWdEVDh1MFZsdHdiK200U1hhK2dv?=
 =?utf-8?B?TUs2T0ljNnBBcHFsRmh3UldMUkpxczlvM0VGa25WcXQreUx2SG9SWForbktl?=
 =?utf-8?B?UDZ0ZjlZdkpJWVFBOVdKZWVuQkNlM2tOd0lVKytPeXV3RjhiNVFyVUUyRVYz?=
 =?utf-8?B?VGpXVTNxcjZQNnBJVmhVVG8xZUsrMWhQREt3QTBPMkdwUjg5Q0hzd3o4WkY2?=
 =?utf-8?B?ZGpKQWthUjUyR3EzSmtCR29FeTByN09KQVo4RTVuaFZHQ2pMV2N2NzFEazky?=
 =?utf-8?B?a3VJV1EwUUt3Q1dxeERkcjlPaGk5eEJLdUpqSjRaNTNRNTNFbmdacEllN3Fi?=
 =?utf-8?B?K3JBTW96azdhWlArWEU2NldobDcwbjRrbVYzN0ZHU1haUTcwOXNhU3EvOCtx?=
 =?utf-8?B?NEN2Y3hQTVZabUJpbFYwUVowRm5jSHpoN1dhbG12SEJSMkZYand0Q1JCODUv?=
 =?utf-8?B?NFVwMmdscXNyRFYwc2l2T0NJcnVyWVljeFBOelgxbmlnVFZvVnQrWUJKTkFB?=
 =?utf-8?B?TGMrQ3JDMFUxbjY3b1pLL254SnA2cUZ0NC82a0JxZ1hTNS9WOTZVNy82L2dG?=
 =?utf-8?B?NVF6WkREUFNpNDFTYXh4TW1zTzN2R3czeXQ5ak5LK01ldEwwM0hxMUNEZitV?=
 =?utf-8?B?TEs0WHo0RTI1WVNPd2VzMGlHSTg3WlE2S0pIQVdCMW8xbjExdlJiWkFneEpH?=
 =?utf-8?B?MWxHM3BnZnRoUk52SkdFTHYrRjVQRHh3Q24wZ09zcVh2V2VlT2J4ZjRkdlI1?=
 =?utf-8?B?Y1FybzZzcjR6SUsrL0swT3JUVXN5eHJRWGZscnZFazJwZkxJckJ0WGNzQWIw?=
 =?utf-8?B?aTV3V3Q5WHpydUhGVjFtdFhhdlNvZmZYVGxLaHRZTGVXNEEyUUFWLzJaUmdR?=
 =?utf-8?B?Wkt1MHhFRUpieGQ2clY2YVYvUlRQN29tVGNpRVNKVVU5Z0xnOHdkdk5OUE9t?=
 =?utf-8?Q?OsVFwMRr/aIa4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0tpbVd1VU5XMjdVRlRLSzF2QVBGL3pLbEZaN1g1UHJ4Z21IbVdMYUMyaW5l?=
 =?utf-8?B?eDNvSnpWZWhmLzZMMGRHNU9rSEh5elp3dXd2NHhlWnRaVndlYkJmU2FHeS85?=
 =?utf-8?B?VzFBenM1b2lMaTB0cDF2cGpvQklHV0V3dDBDN1RoVWFabVhpN1hzdXFmVVVG?=
 =?utf-8?B?VXM1SWVDSFk1LzdyWDNPU3VhRmxNbjdpaFdhL2ZMTDkzalRVaFdPd0E1NmJ2?=
 =?utf-8?B?VlRhN2hXNG14bmYraUp1ZVhMZncwN293NldENXFaQWxQVzBGb0wyYTJ2akJw?=
 =?utf-8?B?Ui9TTnFwR0o5aVJKbml0VE90eWs5ZHBvL0FKZnI0bFZJYy9WaHFLc0xPMEU2?=
 =?utf-8?B?bW1lZml6SUg4MkJ2eHgvaHBIT05Nb3oyVU9VcWNLbGp1ZE43OGVNTkJ3V1Vv?=
 =?utf-8?B?MnNHUWZzY215cjQ0T1ZkRUwvaDNiV0tkYUs2RWZlK3FHOEpYLzdLOGlpbHVk?=
 =?utf-8?B?bnoxVXJXV2JIaS9YT2I4WldYS2oyQTdyWVI3Y1BvMEc1aEpFM0ZmaTlvQXV0?=
 =?utf-8?B?MzF1OFpqWTdINTl0SDduRnFBWjNJdUJRU0lWOGFSSHVmUWVNRmFmaU5zVUxi?=
 =?utf-8?B?WVBYOVA1QVNGWGxnNnc5OGhSN3Vibnc2SkRJZW1kbFNSR0JOM3IrbnB6cUZs?=
 =?utf-8?B?bndLWXlFRHZqeHllRjBaeFUzSFVWRW1Dbmp0RnJLQ2RCY2N2K09wSk5QMnRR?=
 =?utf-8?B?eVUrTFhsU2F2ci9JdW9IZEtCWU1NTmhKemZNdysrRkRyOUk1YXpwd3FCK0Qx?=
 =?utf-8?B?ckhLL2ZwMnpLM2g2QkNpWmR3WVdqNDZFYkZpNGFNWkk4bmpidVFGcldOVm1w?=
 =?utf-8?B?eHhXUFdPaVVxYy84bzkyYW5LLzdpb3F2eFJuYkJ0ZCtNL3FyY1hGSVVKMkly?=
 =?utf-8?B?ODVZU25UNUdTbjhqaTlUd0ljU0xidTJQN3FHa1VMc3hkdVZIQllUNFZPZ3pr?=
 =?utf-8?B?cjhMSm03Kys4VDlKNU9FMVZhMmRsQ1N4VUZZTXNmd2R2OGx5R3dEc3hHSEpH?=
 =?utf-8?B?eXRJc0VWVHZNc0IrQkF1N2Z6eEVFN1laNTFvYkdRK2g3ZnQ2MC8rUDBsb21C?=
 =?utf-8?B?aCtuMFp1bU43TEdsVzM3ODFobVRsT1FjUUpKS1B5SlNKcGtmK0VvOExXTkJq?=
 =?utf-8?B?SmpJMUJvemRQdmhnbEFDajNqS20yMW1TdXZkUEZMZ0tOdTkwbWNDV1NLTE5L?=
 =?utf-8?B?UmZVVmFDdXJ2SVV0bDlScGdlZjRmckUvM0Ewak9sVC9ZSGQybHpCZ2xJQWVQ?=
 =?utf-8?B?RkRSeXZRUnBwNnhkaHk5RnlEU3NFWTZzSS9KbVNBcXlZTlV0eGM3elI4V05t?=
 =?utf-8?B?OVliOVB3bHBVV0tkM21sQllHRmw2VFhUR0FwVjNzdVhWaWdPUUE5Rm0rMTdK?=
 =?utf-8?B?Tk1wNXM3WG82SXJFNHRZeFk5TWFNVVZvRXR3T3R1QktsaDhNUHpPUTBtQVpw?=
 =?utf-8?B?N3BrNjJWbGg0ZFdaL0hoZUxPYm9nUzF1ZDhabXl5cmMxNXVhbVhKQzk1Sjgx?=
 =?utf-8?B?YW03eE55NFpiVGtmSVFqRnJDbEphTG9wRUJXb3E3bUF3R3p2YnJRb1YvSUpp?=
 =?utf-8?B?djRCa2Nnai9RanppcUhZY0pRMXJvR0pNeW5pNmFWbDI2bEVxalpLWDdoaTVm?=
 =?utf-8?B?eTkxRjU0Rnh1SHpFUDd0dlY0akJRcHlxdXVZdG1wT1FENnR4L1hEaXlqVHEr?=
 =?utf-8?B?NnAyNHo2WkVoSExiUHNJMG1CRHluQjdLelgzNUltQWpOU1c5bnA2Vkp2YlFM?=
 =?utf-8?B?ZnluZyt1RmQybi9hemhWT09DN0E1NkpyM09tQVB0dmY0NDd2QU1pSXpRZVNy?=
 =?utf-8?B?K0M3ME9JdWdDN1hvQkFOTHNmRndmckdCMm1pSEl1a09UenZlV2lCeWhSZnZD?=
 =?utf-8?B?Y1dkeC9UTWR2UTlDTWhPUVJzN1V5VTZmbTVsMnJWRHEvOGg1ZkJvZmdKNk1G?=
 =?utf-8?B?bE5ZbDEzcDBvYTZDbWdoRkhpOGtwK0J1cVIrL3NuUTBYQlBXazhyenp1SGlj?=
 =?utf-8?B?aXJFdWMvTXozZm1zMWoyUmxpSW9ZNnMzUldxUzJOM25xb3J4V0tGK05lT0dy?=
 =?utf-8?B?RkQ4a1Jrc2RKdGlqMGFOWWVVWXh0cVpHNmZvSVVEUGh0MFY4QUJ0elI4VS8w?=
 =?utf-8?B?WnFaRFhsZm1paitZUjNLSkxqYkEweGsrNXJBL0lmVDJoODJOY3lCYVAwN2NI?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vr57cJUn9lW/8PnB1M17J+dZqO2WmtMPqoRWXkrENO3OW8umvygD3kt/G397e3aq/0CL3CKRuFf3gZEVGVIIWGu7DAZTZ6T/4nths/ZXHliJoQ6s5W6lqY7CMLkurOzQGzRsgJN4vGayGuMjNc6rjyBZnaue51coJt0nNGZ5Bblkjc2NwXzS8L8wz+Q+zpavNK7qR1BQ4dn8iQsABbmB8saocs5y8mBBMndfAHYQQTPya7DwyWZb30qbIsfPSH57lZNwhWR7I278dRJYTAefhXeZ7+UAXDfVdN+3xkEivtQ4C0XDNP1ojaZU7bI/Q/5OP6CrQWNiAEk+1Ey+teD8lpTOaG+HGwxuEOLiYlbxsk6nbGQ25ipwZ15ZXQGsqSbIhin2SL7qKF8VuUVNbjMguVlrB+ZPQ+q8+mG0RuSqMBvPkTSDNH/XrH6nA1U3fRttgHdW2n2gsfgCx2vit08gl8mtQc0JnJ9NaWk8CrQ62xhAqVuRWYeQsd3j17L0Ij6vYUl9n/gq79s+lsmdt8TngovM1bdh/A2ZyBbQawzOD5/W/ldQdmqch0XeHOIR3NLcY+kWiSIh45bbljehVDCDqlveFTGImkbXvVYcutu3lrE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3045dc0-3a61-4832-b706-08dd34c24363
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 17:38:32.3285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3Io3U3vJmwmG+eh4S+lubElxL+gplpiaXpnZxxAhAh4Su5jgZE1q62IPZWWRoOHO+zInK4U7qK9wd386bl5uke0V1D4DTH+6XbKww5NPb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_06,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140135
X-Proofpoint-GUID: 48OqYWBysbNP6D3ea46eSpzA2xtUYsB2
X-Proofpoint-ORIG-GUID: 48OqYWBysbNP6D3ea46eSpzA2xtUYsB2
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.794,
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

Hi Peter --

These still need RB.  You said the first one "looks fine" in V5,
and I only needed to split the qemu_ram_alloc_from_fd size calculation bug
to a separate patch, which I did in V6:
   * physmem: qemu_ram_alloc_from_fd extensions
   * tests/qtest: assert qmp connected

Hi Markus --

Patch "migration: incoming channel" has an Acked-by from Peter, but it would
be good to also get your ack or RB, as I updated this patch in response to
the comments you posted for V4.

We are inches from the goal line ...

- Steve

On 1/14/2025 12:23 PM, Steve Sistare wrote:
> What?
> 
> This patch series adds the live migration cpr-transfer mode, which
> allows the user to transfer a guest to a new QEMU instance on the same
> host with minimal guest pause time, by preserving guest RAM in place,
> albeit with new virtual addresses in new QEMU, and by preserving device
> file descriptors.
> 
> The new user-visible interfaces are:
>    * cpr-transfer (MigMode migration parameter)
>    * cpr (MigrationChannelType)
>    * incoming MigrationChannel (command-line argument)
>    * aux-ram-share (machine option)
> 
> The user sets the mode parameter before invoking the migrate command.
> In this mode, the user starts new QEMU on the same host as old QEMU, with
> the same arguments as old QEMU, plus two -incoming options; one for the main
> channel, and one for the CPR channel.  The user issues the migrate command to
> old QEMU, which stops the VM, saves state to the migration channels, and
> enters the postmigrate state.  Execution resumes in new QEMU.
> 
> Memory-backend objects must have the share=on attribute, but memory-backend-epc
> is not supported.  The VM must be started with the '-machine aux-ram-share=on'
> option, which allows auxilliary guest memory to be transferred in place to the
> new process.
> 
> This mode requires a second migration channel of type "cpr", in the channel
> arguments on the outgoing side, and in a second -incoming command-line
> parameter on the incoming side.  This CPR channel must support file descriptor
> transfer with SCM_RIGHTS, i.e. it must be a UNIX domain socket.
> 
> Why?
> 
> This mode has less impact on the guest than any other method of updating
> in place.  The pause time is much lower, because devices need not be torn
> down and recreated, DMA does not need to be drained and quiesced, and minimal
> state is copied to new QEMU.  Further, there are no constraints on the guest.
> By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
> and suspending plus resuming vfio devices adds multiple seconds to the
> guest pause time.
> 
> These benefits all derive from the core design principle of this mode,
> which is preserving open descriptors.  This approach is very general and
> can be used to support a wide variety of devices that do not have hardware
> support for live migration, including but not limited to: vfio, chardev,
> vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
> to allow a descriptor to be used in a process that did not originally open it.
> 
> How?
> 
> All memory that is mapped by the guest is preserved in place.  Indeed,
> it must be, because it may be the target of DMA requests, which are not
> quiesced during cpr-transfer.  All such memory must be mmap'able in new QEMU.
> This is easy for named memory-backend objects, as long as they are mapped
> shared, because they are visible in the file system in both old and new QEMU.
> Anonymous memory must be allocated using memfd_create rather than MAP_ANON,
> so the memfd's can be sent to new QEMU.  Pages that were locked in memory
> for DMA in old QEMU remain locked in new QEMU, because the descriptor of
> the device that locked them remains open.
> 
> cpr-transfer preserves descriptors by sending them to new QEMU via the CPR
> channel, which must support SCM_RIGHTS, and by sending the unique name of
> each descriptor to new QEMU via CPR state.
> 
> For device descriptors, new QEMU reuses the descriptor when creating the
> device, rather than opening it again.  For memfd descriptors, new QEMU
> mmap's the preserved memfd when a ramblock is created.
> 
> CPR state cannot be sent over the normal migration channel, because devices
> and backends are created prior to reading the channel, so this mode sends
> CPR state over a second "cpr" migration channel.  New QEMU reads the second
> channel prior to creating devices or backends.
> 
> Example:
> 
> In this example, we simply restart the same version of QEMU, but in
> a real scenario one would use a new QEMU binary path in terminal 2.
> 
>    Terminal 1: start old QEMU
>    # qemu-kvm -qmp stdio -object
>    memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
>    -m 4G -machine aux-ram-share=on ...
> 
>    Terminal 2: start new QEMU
>    # qemu-kvm -monitor stdio ... -incoming tcp:0:44444
>      -incoming '{"channel-type": "cpr",
>                  "addr": { "transport": "socket", "type": "unix",
>                            "path": "cpr.sock"}}'
> 
>    Terminal 1:
>    {"execute":"qmp_capabilities"}
> 
>    {"execute": "query-status"}
>    {"return": {"status": "running",
>                "running": true}}
> 
>    {"execute":"migrate-set-parameters",
>     "arguments":{"mode":"cpr-transfer"}}
> 
>    {"execute": "migrate", "arguments": { "channels": [
>      {"channel-type": "main",
>       "addr": { "transport": "socket", "type": "inet",
>                 "host": "0", "port": "44444" }},
>      {"channel-type": "cpr",
>       "addr": { "transport": "socket", "type": "unix",
>                 "path": "cpr.sock" }}]}}
> 
>    {"execute": "query-status"}
>    {"return": {"status": "postmigrate",
>                "running": false}}
> 
>    Terminal 2:
>    QEMU 10.0.50 monitor - type 'help' for more information
>    (qemu) info status
>    VM status: running
> 
> This patch series implements a minimal version of cpr-transfer.  Additional
> series are ready to be posted to deliver the complete vision described
> above, including
>    * vfio
>    * chardev
>    * vhost and tap
>    * blockers
>    * cpr-exec mode
>    * iommufd
> 
> Changes in V2:
>    * cpr-transfer is the first new mode proposed, and cpr-exec is deferred
>    * anon-alloc does not apply to memory-backend-object
>    * replaced hack with proper synchronization between source and target
>    * defined QEMU_CPR_FILE_MAGIC
>    * addressed misc review comments
> 
> Changes in V3:
>    * added cpr-transfer to migration-test
>    * documented cpr-transfer in CPR.rst
>    * fix size_t trace format for 32-bit build
>    * drop explicit fd value in VMSTATE_FD
>    * defer cpr_walk_fd() and cpr_resave_fd() to later series
>    * drop "migration: save cpr mode".
>      delete mode from cpr state, and use cpr_uri to infer transfer mode.
>    * drop "migration: stop vm earlier for cpr"
>    * dropped cpr helpers, to be re-added later when needed
>    * fixed an unreported bug for cpr-transfer and migrate cancel
>    * documented cpr-transfer restrictions in qapi
>    * added trace for cpr_state_save and cpr_state_load
>    * added ftruncate to "preserve ram blocks"
> 
> Changes in V4:
>    * cleaned up qtest deferred connection code
>    * renamed pass_fd -> can_pass_fd
>    * squashed patch "split qmp_migrate"
>    * deleted cpr-uri and its patches
>    * added cpr channel and its patches
>    * added patch "hostmem-shm: preserve for cpr"
>    * added patch "fd-based shared memory"
>    * added patch "factor out allocation of anonymous shared memory"
>    * added RAM_PRIVATE and its patch
>    * added aux-ram-share and its patch
> 
> Changes in V5:
>    * added patch 'enhance migrate_uri_parse'
>    * supported dotted keys for -incoming channel,
>      and rewrote incoming_option_parse
>    * moved migrate_fd_cancel -> vm_resume to "stop vm earlier for cpr"
>      in a future series.
>    * updated command-line definition for aux-ram-share
>    * added patch "resizable qemu_ram_alloc_from_fd"
>    * rewrote patch "fd-based shared memory"
>    * fixed error message in qemu_shm_alloc
>    * added patch 'tests/qtest: optimize migrate_set_ports'
>    * added patch 'tests/qtest: enhance migration channels'
>    * added patch 'tests/qtest: assert qmp_ready'
>    * modified patch 'migration-test: cpr-transfer'
>    * polished the documentation in CPR.rst, qapi, and the
>      cpr-transfer mode commit message
>    * updated to master, and resolved massive context diffs for migration tests
> 
> Changes in V6:
>    * added RB's and Acks.
>    * in patch "assert qmp_ready", deleted qmp_ready and checked qmp_fd instead.
>      renamed patch to ""assert qmp connected"
>    * factored out fix into new patch
>      "fix qemu_ram_alloc_from_fd size calculation"
>    * deleted a redundant call to migrate_hup_delete
>    * added commit message to "migration: cpr-transfer documentation"
>    * polished the text of cpr-transfer mode in qapi
> 
> The first 10 patches below are foundational and are needed for both cpr-transfer
> mode and the proposed cpr-exec mode.  The next 6 patches are specific to
> cpr-transfer and implement the mechanisms for sharing state across a socket
> using SCM_RIGHTS.  The last 8 patches supply tests and documentation.
> 
> Steve Sistare (24):
>    backends/hostmem-shm: factor out allocation of "anonymous shared
>      memory with an fd"
>    physmem: fix qemu_ram_alloc_from_fd size calculation
>    physmem: qemu_ram_alloc_from_fd extensions
>    physmem: fd-based shared memory
>    memory: add RAM_PRIVATE
>    machine: aux-ram-share option
>    migration: cpr-state
>    physmem: preserve ram blocks for cpr
>    hostmem-memfd: preserve for cpr
>    hostmem-shm: preserve for cpr
>    migration: enhance migrate_uri_parse
>    migration: incoming channel
>    migration: SCM_RIGHTS for QEMUFile
>    migration: VMSTATE_FD
>    migration: cpr-transfer save and load
>    migration: cpr-transfer mode
>    migration-test: memory_backend
>    tests/qtest: optimize migrate_set_ports
>    tests/qtest: defer connection
>    migration-test: defer connection
>    tests/qtest: enhance migration channels
>    tests/qtest: assert qmp connected
>    migration-test: cpr-transfer
>    migration: cpr-transfer documentation
> 
>   backends/hostmem-epc.c                 |   2 +-
>   backends/hostmem-file.c                |   2 +-
>   backends/hostmem-memfd.c               |  14 ++-
>   backends/hostmem-ram.c                 |   2 +-
>   backends/hostmem-shm.c                 |  51 ++------
>   docs/devel/migration/CPR.rst           | 182 ++++++++++++++++++++++++++-
>   hw/core/machine.c                      |  20 +++
>   include/exec/memory.h                  |  10 ++
>   include/exec/ram_addr.h                |  13 +-
>   include/hw/boards.h                    |   1 +
>   include/migration/cpr.h                |  33 +++++
>   include/migration/misc.h               |   7 ++
>   include/migration/vmstate.h            |   9 ++
>   include/qemu/osdep.h                   |   1 +
>   meson.build                            |   8 +-
>   migration/cpr-transfer.c               |  76 +++++++++++
>   migration/cpr.c                        | 224 +++++++++++++++++++++++++++++++++
>   migration/meson.build                  |   2 +
>   migration/migration.c                  | 139 +++++++++++++++++++-
>   migration/migration.h                  |   4 +-
>   migration/options.c                    |   8 +-
>   migration/qemu-file.c                  |  83 +++++++++++-
>   migration/qemu-file.h                  |   2 +
>   migration/ram.c                        |   2 +
>   migration/trace-events                 |  11 ++
>   migration/vmstate-types.c              |  24 ++++
>   qapi/migration.json                    |  44 ++++++-
>   qemu-options.hx                        |  34 +++++
>   stubs/vmstate.c                        |   7 ++
>   system/memory.c                        |   4 +-
>   system/physmem.c                       | 150 ++++++++++++++++++----
>   system/trace-events                    |   1 +
>   system/vl.c                            |  43 ++++++-
>   tests/qtest/libqtest.c                 |  86 ++++++++-----
>   tests/qtest/libqtest.h                 |  19 ++-
>   tests/qtest/migration/cpr-tests.c      |  60 +++++++++
>   tests/qtest/migration/framework.c      |  74 +++++++++--
>   tests/qtest/migration/framework.h      |  11 ++
>   tests/qtest/migration/migration-qmp.c  |  53 ++++++--
>   tests/qtest/migration/migration-qmp.h  |  10 +-
>   tests/qtest/migration/migration-util.c |  23 ++--
>   tests/qtest/migration/misc-tests.c     |   9 +-
>   tests/qtest/migration/precopy-tests.c  |   6 +-
>   tests/qtest/virtio-net-failover.c      |   8 +-
>   util/memfd.c                           |  16 ++-
>   util/oslib-posix.c                     |  53 ++++++++
>   util/oslib-win32.c                     |   6 +
>   47 files changed, 1473 insertions(+), 174 deletions(-)
>   create mode 100644 include/migration/cpr.h
>   create mode 100644 migration/cpr-transfer.c
>   create mode 100644 migration/cpr.c
> 
> base-commit: e8aa7fdcddfc8589bdc7c973a052e76e8f999455
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A14E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTQ1s-0001Tk-4R; Thu, 02 Jan 2025 13:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQ1p-0001T8-5x
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:34:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tTQ1l-000138-Uh
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:34:40 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502HXpni026578;
 Thu, 2 Jan 2025 18:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=+DVKV33Sdz7SaI0fYqrG7ZHJLx/Xco7RONIbx10FM/k=; b=
 SNl+LU8ZsREOvZjojyvO/2iDNVNKCElxORsJ5eid0tRngVhxcZW28NANyxigfIWV
 i+en/am7e0uE4Eofw7AcZOK4SozFm5iaF64xvZGvg0jWuqkovs45iDpB4dIkGo3X
 VJD5dzquz28zBlF1Vl43HwiD3DzxvSguQnPtSb1J85OigtX3kuP/Ic2Il87iB4IV
 r53WzDbq5Oi8CWtRdpG5B0V3MDp1aBhph9m87tP9+Wly9l64ICdWxVv6e9jsOn3l
 4SzsTIKgQM6+Yo0yOYOFmctufOLpwh/5cDEtSrgTwTpTqfqv9+Qr228/PFTijebz
 jb2QHnFzP7To1eluiQPv5Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t7rbxdtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 18:34:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 502IQtqT012754; Thu, 2 Jan 2025 18:34:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43t7s8vjd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Jan 2025 18:34:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+8qqra+mWI5f0UUD5oHJCTmKc36hQsOn45Mwi8wkLjp9OVhVBtWG1VM7iShTrkh6nULZMZrg8uo+qvj7c1ByVVPJd7nKN/G3+/ccWEc4GCdOQB6HtYeEaiefqemFRz9B6LnSHgLKLO+ulZhoq2msLv3gyTHf1lYIr8AjFSerEMUlTAYL0F/n2H3HOXCmDjp3gHTdDh9yirLbsMzeDvM2L70RRnbi99ZOEg3KkGWw1gZY6zHIrMbLXYNCYJgvskr4PiP1zFMfGojWhhzwdax88zl5lUzjTDA5N5MrOCuGn9jjKKHI4tgSa7m7R5QN1ZJQfh6+WSNXZdLXoAEd5Wwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DVKV33Sdz7SaI0fYqrG7ZHJLx/Xco7RONIbx10FM/k=;
 b=XemIRk0qUL5tLcY3DMU1PlM0KwRRrUuEF8GtFGVt8DQSDlkat9OUKRXF8yyZ5xs8GnVoFl2c5fPOyxUMR7IRRr+m/rBx0qQX2Hm+L/47epDlOaunaTo/wfu5oFLSi+X84AtTIHXpBgQ1AKYk3hnWHKYzCBz7+sstGohtpQ1S2tGw0iYfPPMf/PQPrefN+CgYh4ZFS+Av+JjMxYYnRUEpS4m8OCkxUWLTCgnvCNG3+vtTyzHXSmlmIKayCm1r097RZ7Dui29Ocj5SZ9mTZmCKSfzEe4CKkKP8yX4Xg7GDhJNIoAPQxP8vBAVEnrkVS25DygEli/0msc5vN5hrUbL4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DVKV33Sdz7SaI0fYqrG7ZHJLx/Xco7RONIbx10FM/k=;
 b=BtIhOcKIYNSkiEghz/3z2Sg6bCrrEbwMnGHPXnTY9FGf6pwNHLNZG56NTzwg1lNw0uef04h4JJQa7164s+RVhvx2pBQr2dtR6yK9Ctz1c8isPLWloSDKD89QUThYmAOnXWRw11rj++MW0YhIGHjUwOQYpI3VCx/o75c0Y1OWioo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Thu, 2 Jan
 2025 18:34:23 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8314.012; Thu, 2 Jan 2025
 18:34:23 +0000
Message-ID: <b2ece497-bacf-4ff2-97aa-250a0ccc70a4@oracle.com>
Date: Thu, 2 Jan 2025 13:34:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 03/23] physmem: fd-based shared memory
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-4-git-send-email-steven.sistare@oracle.com>
 <Z2ru86ST5BCoiOhy@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z2ru86ST5BCoiOhy@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:a03:505::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e53fdb8-a3cd-4df8-5b00-08dd2b5c13fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cU12N1pxcERCMWhVdnF5UEptNDYrM3ZZajRyUDNkYjZEeTdodE85T0E5MDlR?=
 =?utf-8?B?WjZFN2M3THhCL2hwWmpvalJvOHFuck5BdUlZbXR1ZWV2MUlwbHNCVnU0ZVY4?=
 =?utf-8?B?cHowR0s2eEl4dEhhczF4QVhYOENmbWwrWnVpQmFxYzdka2J3SjRpeFhQOEpW?=
 =?utf-8?B?Uy82WVlvSXpKaHpIR0RlVi94eSsyMWtqRWY0NFA1M2VzZkJuQlU5L1o3S2xN?=
 =?utf-8?B?ZCtUc2pRbFlFYm50b3gwaGZYQldCYWs2UnA2dHBkaVkyWG9qOEdKRkdpMVVW?=
 =?utf-8?B?VkE2c1czbnBjMXBXYWdsYUlDR2ZFcFhlTWh1V3dnRlE5bGw5U0FqVFpNVVpL?=
 =?utf-8?B?Mlg0dDcrRDYvNWViM09DaysvMmU0c1J0WXJaN28xY05OTXJVSFhxdHV6MFZT?=
 =?utf-8?B?UWduUlU5Q1lneWZldTg1dHFvTjIwemdpUEFsS2hGUVNBZW9CWFRFYWJmWXFm?=
 =?utf-8?B?MmNVcnJEVHN6R3E2RDl5THVRc1Qra3hScHJEc0pSUXhESHREendTaCs5UU1y?=
 =?utf-8?B?K3VWQXBuYWtFaTdmRzhMejIrZEdFakxiSzdmZ3V3bzZNNjNPYm9GZEQzYlBU?=
 =?utf-8?B?Ny8xVTVzNUw4V05qQWc3bFlUSC9HNUgyT3YxYUR2VHJwc2ZuMEpTbUd4SVc3?=
 =?utf-8?B?Z2YwdHBIZC9TMGFYS1J4UWV5SGloZFhnTEd1M0w5S0RJR0VyckY2STVVd2RW?=
 =?utf-8?B?bWlvcHR6OW8wZ0pEaytzQkhWSDRwRWlpZVdKUzJ3SkJoaGxjbHgxdjIySHRi?=
 =?utf-8?B?YjlmcFhRM2pQQU9RcDJkd1JVT2pyTDlobUxuS3RYaVdRK3BGYkY1N1BZRzdj?=
 =?utf-8?B?Zy91ODgweVBFb0I2aFBUM1FzeGE2SWpXVnZ1VmFpT05WU2JkQis3ZkRZeVpr?=
 =?utf-8?B?d3hudkVkZm9LekFpOFVjNFE0T1JuaFV2cnhjelhqMzkyVUdiY1JtTWVpMGUw?=
 =?utf-8?B?bFVMcFh3WGJrYVR2WWJCbWxvOFpoUDRSOHkyQjZKY0w4RzdWSFlpQTBCSGJL?=
 =?utf-8?B?aWZIQU0rSEd1OURqTlBhcUEzQmdHM1BmRUFPWTZTeWY3cVZJeDFISlJYQUtG?=
 =?utf-8?B?NlBMMFNzZXQ5UGF3MWtjTTh0dXNWc2IzYUdtZ0k1WTlVZW5KWVArTU55YjF4?=
 =?utf-8?B?TXY2NjRBb0tRRWdPZTJhamlpQWd5UlFsenNWVzVLRnNVL09HTHZwd3BhSGs3?=
 =?utf-8?B?SlE4S2lDb3lyVENUQ2d5anZwKzY3dEdxbHJiVS9oTzd2WVlpY2JQYTdwSmlw?=
 =?utf-8?B?bUZnNlRvcUR2RnpnTFV6U08vbVExVjRWU1ZXWDVuK2xWMTQyaUFhYTgzMWVY?=
 =?utf-8?B?VlFKVXJKVE9OTUpzbWh5bmdDU2pQc3o4RFhuS21Ub0Y2SzBxZUhVZ3Yzb3Fn?=
 =?utf-8?B?NXZUM0I0YzZvdGZ1R2VIeHRMOXRoVWlIaVlOTkJsVmVFZ3k1RERWdnJhVkEy?=
 =?utf-8?B?NEJpbzRTQkc0R3hyK1JUYW9LS2J0SVVsSmNGZE1ZaXZUcFYxY1lubmt4TUVs?=
 =?utf-8?B?S1htSVhYUmoxUFp1RFhkRi9TOVJza0R4MW85KzNzM05yb29oUWVwNUV1Vy8w?=
 =?utf-8?B?a3FrL0NMZmh2Z294MXoybyszNno3dFNsNWZaNDEvR0sxZ1NrYlN0cEJUN2xr?=
 =?utf-8?B?cGJ1K0REdHA1SE5ZdjlSckFURFhUam82NldwQ0FGbUZuOERSRExjNFlMVEN3?=
 =?utf-8?B?MEtuSTkxRWFYVzJuaWI1aVd0MEMxYzlZMWVYeHAzWGxkWWxVVnQ3TE1NeTFX?=
 =?utf-8?B?dEl5aVZrT0RyS09BOFYxZHNtRVRrQnVuTHJFRWIzM2R3RFZ6WlZOTWg3Z1I0?=
 =?utf-8?B?TXRVVloxU1hLWlovN1NOL3JFL2hjQ2gxSnVCT25UbmxYSEw3RHpNRzNUTFc3?=
 =?utf-8?Q?bmH9w8CAWLZSS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWp5K21NeEhQcVRZaGxDUlpacTVZeVBsTXRYclZsbzZKSjZpWHF6bFlGQmlG?=
 =?utf-8?B?YlZHcEFhZ09oa0U4UkxuRXp3d0pwQllnTmxmNjRqSDFpU2VyUkJsME9hMWtR?=
 =?utf-8?B?ZkdUSEpzRXB6M2RCNjFsaUY0eEdPY2JGb3h1TzhmMXU1Rkx0L0ZQSGE2RWxQ?=
 =?utf-8?B?SHlaSkZVNnFjTUV4dUYyZFBQdHB6cDNuSjNFdEVpT1J3b0taRWYweE8zUDFJ?=
 =?utf-8?B?VW5OdlNOUFdWRDZ0dytCNHhPa3F5czBqenJSanpJSFc0WnJYTFlRcjlkYUt5?=
 =?utf-8?B?Yi91VlFnRkJzQXBVTHlMOEJjTWl1K1k5YURnTHJrVVlTdUhLckxKYk1FMVhP?=
 =?utf-8?B?dWQrVlZUb2tQNitNTVYvNTBQQnhPNjBoMVJEOTltYzkvRkpOT2dWclJoZWxP?=
 =?utf-8?B?U0VTUlIrZXp3UURRK0ZGUUtOUkR4bXp0U2NSMDFMWnU4cDJSTmFlaWdienIw?=
 =?utf-8?B?T0hnYnBHd3kzL0RwT3lmd0NxaVk1eWUyMGFISFllaDFEQU9qMytKVDh0Nm1x?=
 =?utf-8?B?RDNmZGtEaUJoS1h0eTNyVnZVQ01kUXlLWDJ4ejdXY1I5UnEvby9jU0RicXZl?=
 =?utf-8?B?dzQ5Vm12L0U5RWdDenVVMm9QVkVBM2FaTzVqa1pibWY4bjFlbnNnTVBQUFNF?=
 =?utf-8?B?RWpJamR4VzB2V0JlTWo5WmNRR1ZIS1lzWlRQb2orNVlkaEVORy9leXZnbHlH?=
 =?utf-8?B?ZVQvSjJDbG9SSFBLTkxlMjc1eFRKZEhib2hxdko3UDhuWlU3SUwvM3VTQzhQ?=
 =?utf-8?B?dFUxYzM4VjVveTlBckpVSWxUMmpPajN0VldhRWJHMmtZd2ozbm03NTB0VW5l?=
 =?utf-8?B?aWpNM2ttSlFtQmRLU0I5OCt3dGltZUVPZ1ExOEpFK3VFbXVHUmc2Ui9vcjJ2?=
 =?utf-8?B?MXNpeDdZd1VOZk5yd0VGM3NnbmJKRENBRXBKcE9lWC92SDBkQWlNTGZWdjJs?=
 =?utf-8?B?Nm1hQVVBbVQ3TlBwWjdQVkZKUzQ4MjdCcnlxSEZJY2tHTUR1b1AvcmRDOURJ?=
 =?utf-8?B?TDlZRzFwWGp6ZEtoUkRJOXg2TndNek01aS9INFNNejg1NHNMcXVUSlM1aGFJ?=
 =?utf-8?B?ZTREWEkvREwwZ01EWWFYOGdYZjJwNDRvbXJxNE9QNjhPM2JyanBFbHQ2SjJK?=
 =?utf-8?B?RkJtUi9oTnROcUw5Sk1OUmRYdnl6SUwrc1ZnaWQvM2dpYkdIVEo3ZVJnbGIx?=
 =?utf-8?B?T0ZuaWJXTFRnRS9kTk1IZ3NoNDFoaUhxeEhYaTBWRkxleFNrRXc2YmsyOE9F?=
 =?utf-8?B?ZnBEdHJDQkFXTDdJcEc3UW9yQVR6bXZQc2pBWEFaZ0RoWndPd2lhSHBKNnRI?=
 =?utf-8?B?QStVZm82NlJneUpRdzloWnlJOGdJanQ0TTltS2ZGUVJ2RFRwdEY1THJpSHp3?=
 =?utf-8?B?L2NmRDJ2aS9EVEdUL2tETzZuNlgrenpWdG81ZWNYbTFJWUluWktPMTlwcmx2?=
 =?utf-8?B?bTRZYlM4MWJXcWp4a2p2NEpNa09UUjlDbU1KWkhsWnJaYy9VTDh0NXFqM25P?=
 =?utf-8?B?RHdtNHQvZkJmK3VlNFVycjBldzBicGtuOE5ha2pCcVNJMU04T2VQZWxya2Js?=
 =?utf-8?B?T3dzR3VobmlzQ053TEpQOGsyb2hpa0NaRVoxZEJiOS9Ncnl4RHgxajAxUnlW?=
 =?utf-8?B?a2RNRzVjU294R29hOERzblVXdXpzTGloRlBsVnFKM01raVc0NG5ZNkUyL3dB?=
 =?utf-8?B?VXRBQmRvd1BNT004a3NMUDlwYzdXWldSR1VTSnorYVo2MEErVDJMLzNJajRt?=
 =?utf-8?B?TVZqdjY0T3VZQ09IZ0xVcUFRZ1VkRVVITk9ZSEFLSjZ4NGNjK2FzdDBhWEpt?=
 =?utf-8?B?eU42Z1JGaGUzMUZDNXg0WUZaMkhvQWlrYzhxdUUvY250ODRSYURva2dSeGNF?=
 =?utf-8?B?OEdGc3dobTdHQ2ltM0hvNVNCWHFPejVtRkl2SXVoOVpDdHJNWG9ZQ3Rya2h3?=
 =?utf-8?B?WlJXSTd3N2tJVzE2M2UvUDY3QmhpS3pBQ3hGaS9iaTVDUVZYNk5PZyt1Sjk5?=
 =?utf-8?B?NnA1TnRwaE9NNHZhaG9HTFphRjZTdU5UYTdIMEgwb0lNdmNtSUNIbHNjM3Jr?=
 =?utf-8?B?eW5Jd01nU1o3SGRRNTVWZ2NTODhXMnR0cWpYNVFSOGQyQkFVSHVCdTZhWmww?=
 =?utf-8?B?b3RIY3A3VkJlbEo0ZisxMVJkVU5LZ3lSVUFLUTYzeXFkM2tSV2xqWVZYcm0v?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 67F1A57jxWwfgzoxu+U7abResnPipzeQqA2C1TtFcsPuRDOr1pvtvT0+ALW9XSPdSRnz6JsKfDXTluOgZ+ybPk0svRTP2RgbKHxP5Rn4cO2K93DzaD2dXRs22w3tiC3yhQnEA44xyAS7hWpz0DqrTzcuAB2Nnw3zPhhhv2FOJygsRpfVsh+HgDwn36X/LpGJEZz+pb/iPbL2wHp+adVBAnEyVE5YKAffwfnUSzoei6yeatVS8zj+c9IW0BSq97MGsU8m+MTRjvhPZf3nimTMu5yxxDVJ0jKb4FznHQYJJoXULiFAYsdXPZO839IdRkHNkpCQppyoF1tSKWpYQzmaH0G6u6AqM+Axu1KgjhZNx7U7S0JuxVUwZa+w+iMVP2G1loHE+H86sW1CD/7Dz/ftkQu49XWO2ZFfl99lv61rcDoZAZYXB7DBy2VQ9R2J0EAZDE56BS47f3pRLPEEJ/esDc0osyfNDGjPSL2do7F7sd0JN/ZonHrHIsJdicbXJNso7WR1G4k/2u2q95sxR7Ek52di2ZdUNNxUDRSMez4tM6e97qgiRoU7OfvYe0M4dbG8KXsoI5mNYfKVBtwKPak0OxIIDwMTgb/uATwBalxjsJg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e53fdb8-a3cd-4df8-5b00-08dd2b5c13fd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:34:23.0795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svNdaG0lX64BVwGslveNDgkFad680iIGrmEFxKxvl2Ok0rAemC2ToZkJiDot2siUVOLZDhMxY4ZGu+G+HRj5Y5D8xNEYqFehruAPrNYuAlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=991 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020163
X-Proofpoint-ORIG-GUID: LMbnWaRKTGz7U7tiCXVtzoepFnU_kqvg
X-Proofpoint-GUID: LMbnWaRKTGz7U7tiCXVtzoepFnU_kqvg
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

On 12/24/2024 12:27 PM, Peter Xu wrote:
> On Tue, Dec 24, 2024 at 08:16:48AM -0800, Steve Sistare wrote:
>> @@ -2079,6 +2100,41 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>>       assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
>>                             RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
>>       assert(!host ^ (ram_flags & RAM_PREALLOC));
>> +    assert(max_size >= size);
>> +
>> +#ifdef CONFIG_POSIX         /* ignore RAM_SHARED for Windows */
> 
> Yeh relying on POSIX should also be ok..
> 
>> +    if (!host) {
>> +        if (ram_flags & RAM_SHARED) {
> 
> Nitpick: can merge the two "if"s.

The subsequent patch "aux-ram-share option" requires two ifs.
Coding two here minimizes the aux-ram-share diff.

- Steve

> Reviewed-by: Peter Xu <peterx@redhat.com>
> 



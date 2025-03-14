Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE85C28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 19:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttAKp-0004Fp-Tm; Fri, 14 Mar 2025 15:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ttAKn-0004Fb-0T
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 15:04:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ttAKg-0002qX-1P
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 15:04:40 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBmMgv014516;
 Fri, 14 Mar 2025 19:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=DoI8Zn4GWZ+ATqyiOqjFsOzXe5j3WzVqyiHtp8io2YE=; b=
 nA9aTVY8RTtge4Kk6IgCeHvVW6WlvSXTH+F7iehPra+ONGZOqvlvbaNkiSIn8o+H
 vJbyOMdT6tdD2iJS/4K2XD6BOehmg7CEPTconltmDYoXVUmxywVrsiJB1avycWnl
 /WxITSq5iyMEw8iQp559o6cGtKsSwZBdI1dfFKhTl1QEThKwOFXv2JB7Kc+BqN7t
 PA607i22BaEDxHsgDGYe+UNadAJ6R7jVTj/qPfC+1zFQh5vegnrU5daGPd13eiTI
 4KaLPVsHtKWI15dw8SxojhyjsUaH8LL3AXqAG0dt/L3OPTBUmbnT25Gu8mZakcXK
 pib3yuOI5TooLa/zDzKUJw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4cy062-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 19:04:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52EHgKTX012138; Fri, 14 Mar 2025 19:04:29 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45atn4ea93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 19:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqwAVzrmm4rLz6/XAtELLxpoAUfh5Kh1l4EXLiMo9MJrLfkyNd9Pg6y0jMXEeMOKO50r1PPrkKgHRNFG+Q8+hjVgLhMtD3nplJ/S0s5+vEayNcdANlQK9CcMPPlR8nKY4f4k2Fi7ZbtfD9n2e8XGZvR7GShqs/eyP1jY/aM7Rh4DgdWhrYUxjyWHU4zQOtf6LjcMvr5x+9e75ymD53QoI5QfGkqbjHQCzhgziFuknVvsvaGkG9E4reMJ4Cl63xoNWP+vDmAtRerNM6kkOQTRmwvmF4AIom8kBE5rRZJ3erH9mUpmQMhkIsFN+bT8glMO38rBHoJ8J8He9kWgyCniaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoI8Zn4GWZ+ATqyiOqjFsOzXe5j3WzVqyiHtp8io2YE=;
 b=yMsM4nvw5aQYigLhB4UnTSM6/W04u1sU602Eb2WNffPofK4Iqt5VfwW2+dvWgcNwSAytI2mjN+p/ya3ckRxk7EUDmeYCj/4t66HWlT6jGVir5QopZFhvuvbIA6MU3Rwie5wO4b9wAVbFWkCQgaOSymcLeI2St7s2CLn9h+ysxjuaar3hHCeKr3xxpwnIo3HFV7SrJBmVZ0R/P+UtTk2jfHMGkpsyrn9Kv6QUuQmISbi24oS3O+blDjpd0m62cxZ6N8QJys3ry5P9Nf5uadXcfJJOPQnC8O0JWv+NeCtVTIuEYuM6x38ypLXATdXNJsxFJe7Ctz4d4lvsJwgRxnJTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoI8Zn4GWZ+ATqyiOqjFsOzXe5j3WzVqyiHtp8io2YE=;
 b=I0w1Q7MIL111lEesXvlfH6U24ArvDO2NTUGMSNcJy6d50VGSOui6cG6y0v1xhFC+0yVT8GG+nAi6Ee7PQCOWiIk/+Fb2fIejAo4Q/PwQmDEFkAGOMm4tgI5y/UGvrLpyeqQqyLEbZ59BfXBLo8xjH3pwBQ9UQchiWnIoXAN0xCg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ0PR10MB5766.namprd10.prod.outlook.com (2603:10b6:a03:3ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 19:04:27 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 19:04:27 +0000
Message-ID: <32b444b3-3378-4f9e-a185-453394f96345@oracle.com>
Date: Fri, 14 Mar 2025 15:04:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG][RFC] CPR transfer Issues: Socket permissions and PID files
To: "Chaney, Ben" <bchaney@akamai.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peterx@redhat.com" <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "armbru@redhat.com" <armbru@redhat.com>, "Glasgall, Anna"
 <aglasgal@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Tottenham, Max" <mtottenh@akamai.com>
References: <3D32B62F-29E2-4470-86A5-9A2B3B29E371@akamai.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <3D32B62F-29E2-4470-86A5-9A2B3B29E371@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0205.namprd05.prod.outlook.com
 (2603:10b6:a03:330::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ0PR10MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: bb21d911-d431-4b67-65fd-08dd632b0ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N21PNVRSY0lScDIzUFhJRWJuTnRkd2k0Yk1wTTRrMUMrT2UvVWpMYTl0aW82?=
 =?utf-8?B?Ynk4dDBna1VJNGRMREhrUmhiUUpTUHNtakxiOXc5MnoxakNDa09kcWI1eWtZ?=
 =?utf-8?B?cnBZZURuSm83eStwQ29ncldINXFTYXdLTm01NSt2Ym13UVR5NTVoMEZtM2xt?=
 =?utf-8?B?anRrTjBNbEJvVThOMnhqSnR5UGJnUTFqNUVJT3ZJRFZOUUt2SWRJdGhnR3ZM?=
 =?utf-8?B?eVpqTDcvYWZBQWVHN3M0QVU1R1l5d2NLd0ZzNzRzVkJFUExxVmlFYjYvZ0dO?=
 =?utf-8?B?a016L0VSanY5RExQRWJLUjk1eHdUczl6RFNrZlN3UFFOT1ZEM3dNRTdwa2Z6?=
 =?utf-8?B?OS9jdnBkTU5ka2FraFhxWE5yZE82Qm5QSWpmK1JKRStWUGZzSk9tbGg2TUhI?=
 =?utf-8?B?aFB3eWE3ZjFxS0x2My9Ld2JHMzdKZmdibHYvRUtDcmN3bzBJL3pzQndmUjFo?=
 =?utf-8?B?SVRzTnZaOVcwclBqMFlHcnBINXBiYUtXbjFneHE0OFdFSnRvYVJVbzhTc2V3?=
 =?utf-8?B?UkFsdzN3QU5jZGtpZG5sQlVjM3FTRFhiZUhxYUtITDBGMVlTK3lZVG5nOGNN?=
 =?utf-8?B?eEV3bnNpR2FvdVRvc1BucWhDbkI3b1c5ZWRkcnJoYk9IYTd1bUZJREFmNTg0?=
 =?utf-8?B?bUM1cjZzODdYeEFkMzh3ZmF1TmtoSDZvamhSSkh3dXBKK0xBSkpnNExuZ09v?=
 =?utf-8?B?WkNnZWJFL2RSMmZ6UGEzb0huRGR6aEFva2kxdnArMzJ5UkRocWN1NFVmM0dx?=
 =?utf-8?B?TWdSSVF1U3NadGFRNXFWRmM0bERUZ080c3MyWHhBdWVDcURYSGJVN3RENXJ4?=
 =?utf-8?B?czFlWHM3UCt0YUExYWplWnpnV1g2ZVdRMG91ZG1NM1NDT2N3UnBJSEtteEpZ?=
 =?utf-8?B?TVJKUHVaQUhFVlA5ZlU3MTZCT3FNSDRsVEVoUUQ3MTZ1eG9XQlIwQ2JVNC82?=
 =?utf-8?B?SW9idSt3cEJsZXZMTHNCdVdFMVNWblhscU5OY0dmMnIzRVRvZENkWjMyVGtH?=
 =?utf-8?B?ZjNSMWdQNmxvTitLV2Eydjh3MjlNSy9ROTFJbStya21YSnBDLzlwdkpBdjVM?=
 =?utf-8?B?ZmN5dFZZbnBKazZnZnJXWFppdnZRRmp1bzZuenl5N3ZVQm9WWTdsaFdXZG5M?=
 =?utf-8?B?UkVoMm1iaiswSGsxd2dYZUpubXBWYUtFNUlOYXoyNWRCTGV2ZzVkQ1UzS3ZR?=
 =?utf-8?B?SHl1V1l1aXFkbEVybkwwYUY2d01wOEpsOXNDTktjdmJlSGxQZm1RbE1pYkhL?=
 =?utf-8?B?TXJMMXlQb2U2aWMvT05lalJtSmZyZmNIRWMyM0c0NHFaQnNIOVVmUk9MRkhF?=
 =?utf-8?B?Z2dYazZOVnRLZW5YK3NMSktlYlNVMHpYUzMwQXczdVJDMlRYRnNCc1Noay9w?=
 =?utf-8?B?bUI0MnE3YkhxUVpQc1JrNkU4RVIzVm0rK1FZQXAvcFNqZDJpd2R2empKZnRo?=
 =?utf-8?B?a0lXSzVpVndOL21MeTh1UDZKYXpOV0Z3RklieHgyU3FrUWVLTjg5M2NEd0J6?=
 =?utf-8?B?NmdzSFQvL2hxemp6WGlyTittcWtqaHZ1VGZld3I4ZkFBd3dwalNwaFArZ3Bj?=
 =?utf-8?B?bHdlbGJNdmRkUk02U3N4RDJEV2VISTFTd3ZnNklSUUJHZDkrWW9DTkNQWlkv?=
 =?utf-8?B?N28wOEpCZmNpUE9QcFRjQzdjSk8zVGN2bkdkcm43NEx2dElNWDM5Zmh5aHJ4?=
 =?utf-8?B?bUUvd1lnOHptNTd6QkU2bUdSTGtXUDlVWkZWVkFDUm42YnRXVkJ2WGM5WUVY?=
 =?utf-8?B?VXhyVVdiRGZjSWRCL1dhajlEUGpoaWptN2R3T0RNRmxUYkFONVV0NmhBekJn?=
 =?utf-8?B?K2lSNXNKYTFZVkx0M2RtL3U3Sm9nZ1Y5aHZKWUxGTjVtS2xUSTNyREpnKytH?=
 =?utf-8?Q?Ai1zuSgwVTGT5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhHTjBQb0J4aGIzVnd4UnluV3JvSDVMQ0IrRVY0cHhmWUpDWFNTaDFhKzVs?=
 =?utf-8?B?cUMxZnR6SWJxSGZlWDNPUzRMV1BaVWhSSmx4ajJUQnZWbG9IcVhLelVzUmV2?=
 =?utf-8?B?SVMzVUR5Z1dzR1pmQTRFUEkyWkZnVExQYmdqbDZyVzIzZ0tWQkJsbTBMT3g0?=
 =?utf-8?B?U1ZQL29wRnlCU0tsdC8renZ1OFl3ZWRWVzI1UWtPUzA5OWUvVjJ6YW5DUHR6?=
 =?utf-8?B?Qmx4QmlQTjNOOGxSdzBiUmw0akdleExUellUMzlSalBTNjFPWHlGOFJKbzNC?=
 =?utf-8?B?cmZOWWhYbWpNd1JaN011Qlp2WXBvaTBFVzF3S01pSnBwWXd5M0VmV0c2Y1dm?=
 =?utf-8?B?UXR1d0pZU1dnSzNuNFFTYVBBVFNiTjhWUm9STm9XWUROVUhEbE0ydDhLb2tz?=
 =?utf-8?B?MWFVOVJ1Vm82ajVwVUEvbXNqZU5NWDErVGwyeDdjb3JLV05rNUpoTDNuMXhs?=
 =?utf-8?B?RjFjeU1hVXo3WmxQUHZEcndWbUtseWxtT0JHMEtSQU5sQ3R1Zi96NEdqVFcv?=
 =?utf-8?B?azEyZjVieWU3Ny8xOXVhZm9seUtXRkZJWEtTNDdRMXVZN1h6N3hwMi9TT21R?=
 =?utf-8?B?dmJpUlRjMGZRQm84SGgxNXlZczBaYjQvdVhrZUpXcXQ2RGwxK2JhWHVlTVZH?=
 =?utf-8?B?SFNDYjcrZVBreXhzNGpSTG80bk9GdzFSUnVlRHlDSUJNKzI1R3JHa09JUldv?=
 =?utf-8?B?Tzg4UmdlMHVWSHd3L1hvMnhrcndiai9XaE1vR2hMZEluQXNuTEI4b2xUOXZW?=
 =?utf-8?B?VkEzVDJJaGhwcmF3bmkrWGk2WnphSnk2UEoxVlZiZ2s4M0EzUDZ2bExZU1RN?=
 =?utf-8?B?bUVmdjNxMm1RL0pPNGsyMU1nQk1NRkExRld6ckZuQUV4aEUwdnNZRnRIT2Jq?=
 =?utf-8?B?MWgrWVhGekpIbE9WeUIzZFFUZUViSkZOM01EQ3pDYVRlenU0dTZTRjNXVXVR?=
 =?utf-8?B?QkVpUnpiNU5SVXRET3FuSEZQNnFrRkZFYlZ0RTI5eUhJckd1UTdndk9tNGRk?=
 =?utf-8?B?UkphUXR1VHZTM0NHb042VlNoRmF0UGJNZG4vVERtc3ZFTUNCQVhsRStzUjRw?=
 =?utf-8?B?aWJ1czcreGo3Z3ljWjFGNGVrd21IYlBydGg1eFM2VURlbTl4R0Z0T0VTMmxO?=
 =?utf-8?B?UlFLeVRSZlFFdW9kS3Era2ZPS2FKUlR5SVEzd290cTI3aHFGcTNlYmg4ckti?=
 =?utf-8?B?OEx1SzhKdDZlMjFncy9pTzdBeGNheHBlZXZVOTJkRzl6WDBpa2hrKytzdm5V?=
 =?utf-8?B?YlBLWjZxNFNzU0hQWkM3RlhncFJmcHNaVkFtZC83VHZMTXJMWHd3M2NXZGxu?=
 =?utf-8?B?NW9objVQU2lDckY5eU56VGFsTmJIQjRJQVpNd0QwelMvTGpCd2Q4cGhuT2Rt?=
 =?utf-8?B?bU1wRHRhOXNlcU8yMWlYYXpFYi9vaUFrT0JtdFhZanp4amhUSkJnZk95ODNF?=
 =?utf-8?B?SW1VZDNEbEl2WWhPWGVWKy9MRURRRWlHVURrVFdDdEF2cTdBVWZWRG9oZCsw?=
 =?utf-8?B?Rm5CZU14QWM0a0VYR0hEanJ0ZnhDZ1pZUXFnQWpGVlFiUzBZdElOMXpKT3c5?=
 =?utf-8?B?VzRYczJHZFpyblNnbHVDbXNJYnlCZ3hCOTErbWVWOGJiemxtZnUvOXNFS3M4?=
 =?utf-8?B?cVBoUXNWaldZQ2N3MjRQb2dQZyttVGpiNTZxYzQyTzRGYUJnTjBGQXJ0VmJt?=
 =?utf-8?B?YllhTURxUmIrTVQ2ZWxYNXBVMTkyazZ1SHNXUkxVYmlLOGFCRUhGVWdXNXJW?=
 =?utf-8?B?UVNyaDRVby90R1A2K2xhSFMwTW9VbUg0MDZ5UEVYeVZKVXBSZjhJdDJjQjMr?=
 =?utf-8?B?Rmt2QjcrbUdXbnA3d29KbnJ3WkF3S05HVGVjcEJwVUZicVU3Q1BiTU5uemVo?=
 =?utf-8?B?eTd0Tmxvc3hnbFNFT0tCczEyMVlzUDgwcnpKM3BkWWRwSFlTZ1ZXd0R4VEFm?=
 =?utf-8?B?NkhqWDA3SXRJOWgzZ1ZSaHFIOExoenBON01FS1J2VmNkdUdpWHRZMUZCWkhU?=
 =?utf-8?B?OVp4OStmNWV2SEppNWk1d3RNVkN0ZHFBMUlKS2JQVmh0bUo5eDdKRUVHZ0hL?=
 =?utf-8?B?dWdVUVR3YUQ3UGtpdnJkaVBjMHZ5TGNIc3NrSXFhS0p3YklKaXlhQURQNGhm?=
 =?utf-8?B?dTQwQ1JJbHlMcnA2YWQ0QmRTQ09ZdkZWZC9udWZoSmpWNzI5T1NIUTlUUTYv?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lqUSaoCUZjL3YIykqao+mN4c5vIc1vzGh/xSqAp8iAcaBTcaRnP6fn8JGvhhyCN3x7BxSsC/aTZzG6JMY8fY43Bx0Y0zJZVHmQ0xU0pR1OfxDNcMjyf297and3npjgro8YtwuC+s2ElivZS5jVXWL9vO3PG+D+6m//9EFgLPul1yc68KbRGscJTHjFocnE3LtTY6NL5nT50wLV/QwBKi81Tu5UkaiIMj681LBA1cHhv2DMzA8eZDfD+DYL53oqT6HE55kPi+GdOeuV7aF2ExI6PIXV5u60aImAA74V9BOu+ssjZBzpc2MaMubHbC5NXdssLqaotwKdP8WRdBuNYs4KBBZEVYVqdegRwXWwdxgqpY9ecjgLVt4Js9M7eZJZlRvkDAAIJbbBvok9kAWAg2nHNzZlHQq/XIz+fLlPF/w5GANFKirKcGmBmowdN4pGF4zdx/IBlI2yJVXpQsNrI0zX4qsLS3oqTY/mWp4+MFI8gMFkJLRkT1LYahRIn8d/54emyznhYtMpfnR9UlL2vQo+iCMcQNtDIgsBLPrlrdOW2hIZ2l194mzW0at3jCqJuZKI/kOjldlW6Yu8cYwXgFDpfy4tS5Dhfld3s/t1td1JI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb21d911-d431-4b67-65fd-08dd632b0ada
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 19:04:27.5408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/mWy0TejGFdy0q8g+A5yvqXJeuYL+69zIZZC7lSlQkuR609Pqvs3SnDcLeAPvCvFSdfOIy99dwoL/ji0AwOINphpOsvfbvz76vqajekiZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_07,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503140149
X-Proofpoint-ORIG-GUID: BdvldyXsfvvLCBn1I1p0acliW1-huZ3l
X-Proofpoint-GUID: BdvldyXsfvvLCBn1I1p0acliW1-huZ3l
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Thank you Ben.  I appreciate you testing CPR and shaking out the bugs.
I will study these and propose patches.

My initial reaction to the pidfile issue is that the orchestration layer must
pass a different filename when starting the destination qemu instance.  When
using live update without containers, these types of resource conflicts in the
global namespaces are a known issue.

- Steve

On 3/14/2025 2:33 PM, Chaney, Ben wrote:
> Hello,
> 
> While testing CPR transfer I encountered two issues. The first is that the transfer fails when running with pidfiles due to the destination qemu process attempting to create the pidfile while it is still locked by the source process. The second is that the transfer fails when running with the -run-with user=$USERID parameter. This is because the destination qemu process creates the UNIX sockets used for the CPR transfer before dropping to the lower permissioned user, which causes them to be owned by the original user. The source qemu process then does not have permission to connect to it because it is already running as the lesser permissioned user.
> 
> Reproducing the first issue:
> 
> Create a source and destination qemu instance associated with the same VM where both processes have the -pidfile parameter passed on the command line. You should see the following error on the command line of the second process:
> 
> qemu-system-x86_64: cannot create PID file: Cannot lock pid file: Resource temporarily unavailable
> 
> Reproducing the second issue:
> 
> Create a source and destination qemu instance associated with the same VM where both processes have -run-with user=$USERID passed on the command line, where $USERID is a different user from the one launching the processes. Then attempt a CPR transfer using UNIX sockets for the main and cpr sockets. You should receive the following error via QMP:
> {"error": {"class": "GenericError", "desc": "Failed to connect to 'cpr.sock': Permission denied"}}
> 
> I provided a minimal patch that works around the second issue.
> 
> Thank you,
> Ben Chaney
> 
> ---
> include/system/os-posix.h | 4 ++++
> os-posix.c | 8 --------
> util/qemu-sockets.c | 21 +++++++++++++++++++++
> 3 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> index ce5b3bccf8..2a414a914a 100644
> --- a/include/system/os-posix.h
> +++ b/include/system/os-posix.h
> @@ -55,6 +55,10 @@ void os_setup_limits(void);
> void os_setup_post(void);
> int os_mlock(bool on_fault);
> 
> +extern struct passwd *user_pwd;
> +extern uid_t user_uid;
> +extern gid_t user_gid;
> +
> /**
> * qemu_alloc_stack:
> * @sz: pointer to a size_t holding the requested usable stack size
> diff --git a/os-posix.c b/os-posix.c
> index 52925c23d3..9369b312a0 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -86,14 +86,6 @@ void os_set_proc_name(const char *s)
> }
> 
> 
> -/*
> - * Must set all three of these at once.
> - * Legal combinations are unset by name by uid
> - */
> -static struct passwd *user_pwd; /* NULL non-NULL NULL */
> -static uid_t user_uid = (uid_t)-1; /* -1 -1 >=0 */
> -static gid_t user_gid = (gid_t)-1; /* -1 -1 >=0 */
> -
> /*
> * Prepare to change user ID. user_id can be one of 3 forms:
> * - a username, in which case user ID will be changed to its uid,
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 77477c1cd5..987977ead9 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -871,6 +871,14 @@ static bool saddr_is_tight(UnixSocketAddress *saddr)
> #endif
> }
> 
> +/*
> + * Must set all three of these at once.
> + * Legal combinations are unset by name by uid
> + */
> +struct passwd *user_pwd; /* NULL non-NULL NULL */
> +uid_t user_uid = (uid_t)-1; /* -1 -1 >=0 */
> +gid_t user_gid = (gid_t)-1; /* -1 -1 >=0 */
> +
> static int unix_listen_saddr(UnixSocketAddress *saddr,
> int num,
> Error **errp)
> @@ -947,6 +955,19 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
> error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
> goto err;
> }
> + if (user_pwd) {
> + if (chown(un.sun_path, user_pwd->pw_uid, user_pwd->pw_gid) < 0) {
> + error_setg_errno(errp, errno, "Failed to change permissions on socket %s", path);
> + goto err;
> + }
> + }
> + else if (user_uid != -1 && user_gid != -1) {
> + if (chown(un.sun_path, user_uid, user_gid) < 0) {
> + error_setg_errno(errp, errno, "Failed to change permissions on socket %s", path);
> + goto err;
> + }
> + }
> +
> if (listen(sock, num) < 0) {
> error_setg_errno(errp, errno, "Failed to listen on socket");
> goto err;
> --
> 2.40.1
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 



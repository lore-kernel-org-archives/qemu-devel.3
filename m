Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DF4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 10:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Tb5-0003fd-De; Thu, 02 May 2024 06:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1s2Tb2-0003e9-Lm
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:23:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1s2Tb0-0005fa-9A
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:23:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44284S7l030363; Thu, 2 May 2024 10:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=0+wfBKtLH9m6LgwGJmYiE5exnHYjkc9yvyPhk/734d4=;
 b=W63MFovL+4Ek1n0vcG+JC0s3x2KeM0fSfheBcD7W7+vpJPDJx4uH8UbOVga6i1I+bvaQ
 81UKu4GbDPIb4VSn8TGL7BCq6bmgPXmLGu2hbdpOKwW4u/umvbWlmbLpSbHte1ikzK1Y
 xTjNe1q3EOqOfcrVfqaICd05Z5de/BEDq25wuj+5aY2tvPxrZZouY8nuaz7QTZo7rZpI
 BQvZVSvY6zVlm/q5lPgQJ60a9COshOCwVjinpLvo4h6/Cbt72nPhstEacnJKC8fzFlN0
 fCSpoYGrf/m2Cqt8X3Cs+oalhOhbcuiWr6+hWcSwjMpFh5A7hYKns/BcmzWIQKVI+HFC yQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvwq2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 May 2024 10:23:18 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4428oCvc002190; Thu, 2 May 2024 10:23:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqtgqgrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 May 2024 10:23:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtLcNg9vx0+qz4aqXUdHwulyWgLcmAEt0o7rBuGq7RXtAqwfoKZjQYSyfC1IjGRNA5O2onV7zWLYuzuY8ouOwxVDXYWxtj7iGhgxrwwSol+B5dicqZQV1ZtLopx8o3s6ZS4s/ah3yP9oA94kyChO561jWEk9AT7vICnXHy02wryn9eTGHSBOAY2/gh4m9rW5QQ4STp7+M1q4C3sQOWpHim4HxIZsNpj6BYUTNMEnKXAwprZbhgeV27PC+7xlGpap5FS6UQZIHJfSIA7zB4Izeq06xXsi/KOxZiIoW4din7xoC0ylqVj9Z+t5crUUlZsbLnblehzvuCKlTxcLblxdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+wfBKtLH9m6LgwGJmYiE5exnHYjkc9yvyPhk/734d4=;
 b=fW8AMzSgqH6VT3rmTAfcABBWojIGdE5UhJg+OcgpV7JSMId3Vme/C2ZVGz8C5i5SBSZR/EZy0/818Gj6aovp7yqABzAK5DyUl2FP/Yjr1KIJnP9YxPmwUn9WdqQwiQBav0C8eZZZT831Ukphj+sOSuS3EaUQQ/lXXPt89VqZyz9O93rntfbrIe20JFBgHEtHLLnK2E8lHMlOcQyUOECRbKLCawimVzC2YH4fuRUU627JAQoMdCVmOqVT/9GkHEs54BgGU1LE0W7vVgAcRxKQ9nkNOGw1uZgHyzXUFjeP1CnLD4R/LisK5witZ6K3VqiTgRlhm3iYyUvAVyz1VWScPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+wfBKtLH9m6LgwGJmYiE5exnHYjkc9yvyPhk/734d4=;
 b=C1sEGeqwevyLnC4OAM5+0OY9zYuIz2eFC9+97diTLVAEP3i62+fa5aZAIwitLTMiMkevkG85qpc+v5GGp8eq1pHA+o48zHDp65XR7wSa0I5YZlqVCnKBHb8IMX8Rxjq0sbB38KKdA2WelhHoKGgrDPlvijkBs1f+Iij5hvljDNA=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB6311.namprd10.prod.outlook.com (2603:10b6:510:1b2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 10:23:14 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::de7c:2c87:8c7f:e14e]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::de7c:2c87:8c7f:e14e%5]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 10:23:14 +0000
Message-ID: <5e9c1edd-4e99-4fb7-8b9a-159b1a6503c5@oracle.com>
Date: Thu, 2 May 2024 11:22:13 +0100
Subject: Re: [PATCH 2/3] vfio/migration: Emit VFIO device migration state
 change QAPI event
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Maor Gottlieb <maorg@nvidia.com>, qemu-devel@nongnu.org
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-3-avihaih@nvidia.com>
 <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
 <0d368ac4-fbba-4829-b25d-d49957b7c9da@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <0d368ac4-fbba-4829-b25d-d49957b7c9da@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0074.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::7) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c026aa-217f-4f97-d7c3-08dc6a91dff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1creVgxQnU5aDVWSzllRHpUZWdNQ0IxWS8rcU9nUUlrZDhYS3BPNUpYcEdX?=
 =?utf-8?B?bm45ekNPQjgySFFjbEltdDlyR01LenNVRngwZldNa0Z5SXRuVDBzSDMrbjFN?=
 =?utf-8?B?ekUwR2J4bVhPY2ZTbUZUeXN1TWJ0YVo5RGlEYk52RFlrVU9mQktudFczSzhW?=
 =?utf-8?B?QndkWkgrU3I4Z2laOWs2TzhMT2xCdExIU2ZUa0dhQmVPaFppQ216bGVPZzVE?=
 =?utf-8?B?bjFpNjUzVUUxK3Q5a3hPZ3NzOWZYK3RoWWtmcTN3RSs0ZU9LVnlPRjh1NUh6?=
 =?utf-8?B?VE9lNEZQWURSdjd3eUFCdWhlOElmTXZJN0lScE9XRlo2T1BUR1RhTURzOFZY?=
 =?utf-8?B?cmllZWF4dlRmSHhJSmVZVXRxMUpzSW5LRTRxUVlQbFhLSFpMWVR2Z0x1Zi81?=
 =?utf-8?B?RGRXeU44K0xkZmMwc01YVWlmWkRCdmVnMTFGTHRpcU1ncmE5SlI0Vnc1emxC?=
 =?utf-8?B?TExsbmhyQ1kzK0U3U0xyMWpaUU9EVjRtUjU0elQvUTFmOHFFOFdOKzNrN0JS?=
 =?utf-8?B?MEFYdXZGekFKNFdheTBrYVRUcVl4T0pBbHhhdmMyNjhDcWEvdnpuaG5mV1lM?=
 =?utf-8?B?b0gxNmpqZWlhYU5wdklmWG9VTU41K3NwQzZvdnJaek1zcENraTQwanlPMXhQ?=
 =?utf-8?B?ekF3Y0RvRlBiNGFnQ2tUcjVoM0d4R3c2N25WWENBV3J0YkVka3paUlZlTkla?=
 =?utf-8?B?NWNvangyZ1hzNHZKNG9pWkdWbThtcUZHcytvMjVnK21yT21vU0FGeEVKNGRF?=
 =?utf-8?B?VzhPV3BnZXBNS1RmN0FVVDQ4dSs2WnA3VVJFRWViazJlQmZ6aFFGak5CYitP?=
 =?utf-8?B?ZVlhbTE3S2NRZUhUTEVCQUJKV0p1Z0lIOHNiVHRUVVNLOHNTWmh5YktBY29v?=
 =?utf-8?B?VENMcVhYMUZKM3ZSeDFrNXRIbjRnbmRvRjZTMnpzK3pGeHl0QlgwTjNMZUly?=
 =?utf-8?B?aU41MmMxYnhTallvVHBOK1liamlQNERTbXVhbk1EUE1CQ2Y3OEljMVlpSkFk?=
 =?utf-8?B?Ym5MWDV6TStIWVpsbHpmcGhZOEZ3V04vU251MXVUN2g1eXVScnpyelJuNE52?=
 =?utf-8?B?a3pIOEdNcmNadDkvTFV3S2E1OEdLV2Y2S3ZLTXBUMDIwam5ycmx5cUJsL2J4?=
 =?utf-8?B?K1F0dUF2TWFNMUh2TTF0S1lFdkVIMUVDV0owTVhGTVNlQmtnNzNreUtzV2Fy?=
 =?utf-8?B?cjlxZ2kwdkY5Wkl6aXpoZEJTQXExbXJGOTNnZGNpKzFXcmhuUU95YnYwOXgy?=
 =?utf-8?B?dmZIR1M2VFZKL2tCOTV6VEdCcWYrcUw3NnpZamZsVEhsejRvRTB2MytQTkYv?=
 =?utf-8?B?cDhlUjFqR2RuQTRtS29HOXRTMEREOFlQNWo2azM4NGJFQXZpcXhFcGFrQVBE?=
 =?utf-8?B?bDhxYVZadFM2dWNvbWFzZGtPTVZUM0hMd0gvQWNFazZzU0tGTWdldHJxWm1M?=
 =?utf-8?B?OEp0dURFTmhlaGVJdEtKVCtPcFRHUnQwVTMvZG52Qy93SUxIbzJHYjhBQkha?=
 =?utf-8?B?WlAwVzgvQklLZUd3UVA4VjUzR0ltam10OGVkaDNxMU1sVE1iUTZrajFNTS85?=
 =?utf-8?B?c25lUHNpS3JSSzhjWUVrUWt3ckxNMDFDZHdkTG5GL25qTWpQWkJJeU00TjJl?=
 =?utf-8?B?Q2NONExGQlBoalpqS3R2NzkvMjE1UUxQSmhoSHVEZ1BUdzZjYTBCSGNCT1Bj?=
 =?utf-8?B?RlN6bHlQWndyR2FMMzArOHJQczNHTjczUTVxb0l3KzJYZFNqdTVGd1R3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUdQUnJwYlJLcU1MNXR2ckFVUWFBLzQ5TDNOMjJUeWtsMlNodjIwS3pmS29p?=
 =?utf-8?B?bmpEczdudmVBY1JEc3ArYitndlRyUlZVWEdHaDVQMW9pZHB0WFNQcXZqcklN?=
 =?utf-8?B?ckZqc0ZtQXQ3Z0wvK2NHSnFHRndtNXdSQllCVHFpWVZJNW9tME9JNW5hanRz?=
 =?utf-8?B?cmM3S0NiekI2ekxDN0F2dndCRHJpY3c5VmZocDZpS1pFNHdvNXArUEFiamQ5?=
 =?utf-8?B?YVN3amg2UjRxYmhzNGI5ZVlMbkJsWGg1TFVVZUJPaEk5SlhEWUdHcEtsT3RX?=
 =?utf-8?B?WFdFNTRhSHI5S1E0Z1J4T3NtRHZIQWRDM2FQbFdlY0VGemF5MGo5aHBUUUFK?=
 =?utf-8?B?VCtPVEh4WkkwVDZxSU9vdml2V1hIRXBEYXN2M05QbTE4S0hOTnFMT1BScWdU?=
 =?utf-8?B?aEFjRW9KaXlSOENjRmppNlBtUGRUVUlpdGszM3lKYVhmT2tTbGcyaFl6TUIy?=
 =?utf-8?B?MURtVW5kVmFDNHlhUWJ2OTJuMTZkVXM2cDd5cXlubXF0cTBCcVRCNlhpdG1p?=
 =?utf-8?B?bElyVGV4d0ZtWFZ0K3BVTFJ1Sm1USnZIZVZBK0REdXRWMVhFY3NVdHdrWlp2?=
 =?utf-8?B?V0ZCR2hBbG9mU1l4ZnU3ZndTbUNVSGxyWEFTdlVFSkp5NVZ4dXluYmpOMndH?=
 =?utf-8?B?YmoyM3R2dlRGZWt3OHZFUFlFZG5LY1loelBobHl1T29HTmtMcU5GdUVaRzVE?=
 =?utf-8?B?cldIK1hJKzNyMTFuOHhGNmdNNkY4aDBLUEJMcFFhcFN0d2d3SGx1SkxHbEpP?=
 =?utf-8?B?Yi8va1FPRWR1WktZWHl6cjNaR1pUazlReWNxZGgrY205eTVBVVpVRFlHbm1z?=
 =?utf-8?B?cHRaUUwwS3dXeFBWaVBpdHoxS1kxV0xKRG01c3BaQWllamtRSldrbVQyK0xk?=
 =?utf-8?B?VGZKT3JrNUI3WVBKZmM0TUd3OHNpT05RL29yMGVYRU50VEw5ZHdpZDNibVZr?=
 =?utf-8?B?U2p0Tk5OK0l4L2h3V2JmTnErTFZrMjliTWxaTjE0K1NYNlBJNkpXczU2V1Ji?=
 =?utf-8?B?NmpVWXh5VnpvNlphdS9NeDN0aFZYcWhDejUrQ2NpTm9EZ0ZMOXdxaTYzRzEv?=
 =?utf-8?B?V2VZRmJnVUZtVlZSSVMrK1B0eHJUUnJ5MENpSmZ2R1p2ZGl6aXIxNW8vaURh?=
 =?utf-8?B?T21URG9BNUJHWVE2OTdPYThIZFk3ZHlEK3dVQnAzaEw4SktZUC9YOUU0Rnhq?=
 =?utf-8?B?a3J1cnRaSEZsSEVWWXBGS3VKYWVsc2d3UTlxYmZ6RzdVWXlnUzRPQW1qZUxp?=
 =?utf-8?B?NkQzZlhCaUN4QXZvQ00vdGk3eC9Hd3dLaDRIMWpDbmRDL0YxMW1Da2VTaFFY?=
 =?utf-8?B?VFNQbWtTcURvSjE5Y0xJYjJQcEFwQUw0RjBoUUh4c1lHbC9yWWZCUjRLUzhT?=
 =?utf-8?B?TVhNL3ZtVCs1azhzRTh2MWQvbGcxdHMyeHp4SWNveS8xWUJ6R3dRaDUyMU1S?=
 =?utf-8?B?WUROYlhJaUVLbFlsNEdoTllqU3hidy9HMEZ2cnlvdVpOaTJaZ0JhRVRSU1F3?=
 =?utf-8?B?c0hzN2Jzd1NhZ3BZeE1TUzJOYVplUmFNTmZ5UGZkTlltbFk0dTBSR3dGREFs?=
 =?utf-8?B?Skxqb1NDNkF6eTBJTnArWk1vZVpqZmVTTmc3Qno4UkVNVUJ3aVhIYVFCejFQ?=
 =?utf-8?B?NUR1cG5GZDhPN1dHemdhK1JPUFYwVFA5QXFnRlQwbFMwMWNGb0gvbUNySDMr?=
 =?utf-8?B?OWdyZmdZSVU3MGF4MS9GUkFsWlVEKytqcm5WRnpiR01FNitMTjJ3M3kwVkdB?=
 =?utf-8?B?SDRDR052emRDdFFROWhHb1g5eUxaVDFoa09DRXpWNkVFSlprelArdXZ5Y3Fs?=
 =?utf-8?B?VlZ2UWtRUEFVeFJGeERETk02KzIvTUdZNEhjTmJCcmM5aWhBNm53eVNSMktG?=
 =?utf-8?B?cWhVK2FlN3VYUTMxajFrRHVHVUphUFRWbjdGMzFmOElKcVpCU0FFbWl2cVlm?=
 =?utf-8?B?Ky85SDlCbGgwdWk4d3k0SDNGSDVnNGVKdzhwUWVVL0NkY0lFajZ2QkQ4bEo4?=
 =?utf-8?B?L3JvM0szdUtzSGN3bTgwT1g1d1lRaHQySEpCNFlBMGlld3ZFM0NjVGtUbWVD?=
 =?utf-8?B?Tmw0bHpxd3FJbFljWnMzcmIyU2dnNUxqUGREaHMvejJMR1p6cURsbnAxODNo?=
 =?utf-8?B?VDZlTUp1ZXhnRXRhR1REYm9LSGJPcUNQY2VnWjRsVzUxSU0xeVJnQ1N1TjB5?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lAYUjinjhRd8AVj0VOoKu8tt7DdFRaYQ3vWY1lF7lYNd8YKxwSxfWDwW82djS17kRc/+WthgV/I2zShWnzmkUgsqUyq/Ug9OA+UAtChY5HEH0PzYlqJ0L+r7GNcw4f0lzbSCvRkgQUoXmDVsyUvTbfHHY1jDExmrXBt1dyeQ29XTohgtdjeCFUKfMRPUIgj/q0zL4GRUqcWOIwdixeuiVIitxR5oZfuS597CUrNBU1lJTMtblGXkfEMtdtRraKgcVa7TPz5X9Ljww8z32hnOsPSY7Izx2Q7jzfGGg1gGWw9Hvla5CUKafCe6fD0QMsfQehbgGypgHFNiCM5cjvDAhROJCPg9wzWMzCVMW1IoFZr4HwDs/URqgV3Cge9n43EWB8eK6tjodxZJ1gxAzNIvBwrfzi+TIr3JLuuQ5YkV87eIEHL5TPdAdA61Os8zrhDG2tsM7jlXmybZxHHbU/Ds1a2j75b0ho3f2CKTbroXbLNp3BQ+wdVzZCGRgUjXCCcxrIWnvbp27zCctLFgTWz2Qz4isZA/mFTonyMyqNaqbYIVdbDG3A8Sr0h4A9p+HRMRNi+VTrszqm71FBzoCD28Hw5vEggPnMKJiquOz5gUWis=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c026aa-217f-4f97-d7c3-08dc6a91dff8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 10:23:14.2897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw3Ljd8VKgFE9q+U6D37RaWg392VF2NHson2Fkb0SspTJlxzBAIslrxCbXmw1u4FfLp05l2zrthjyQVHGFhCwMchlmZnjWAv+adUO2cyGkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020064
X-Proofpoint-GUID: fMQFreV2FRs3utT3PTkXs2DJRYByYl_B
X-Proofpoint-ORIG-GUID: fMQFreV2FRs3utT3PTkXs2DJRYByYl_B
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/05/2024 13:28, Avihai Horon wrote:
> 
> On 01/05/2024 14:50, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 30/04/2024 06:16, Avihai Horon wrote:
>>> Emit VFIO device migration state change QAPI event when a VFIO device
>>> changes its migration state. This can be used by management applications
>>> to get updates on the current state of the VFIO device for their own
>>> purposes.
>>>
>>> A new per VFIO device capability, "migration-events", is added so events
>>> can be enabled only for the required devices. It is disabled by default.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>   include/hw/vfio/vfio-common.h |  1 +
>>>   hw/vfio/migration.c           | 44 +++++++++++++++++++++++++++++++++++
>>>   hw/vfio/pci.c                 |  2 ++
>>>   3 files changed, 47 insertions(+)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index b9da6c08ef..3ec5f2425e 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>>>       bool no_mmap;
>>>       bool ram_block_discard_allowed;
>>>       OnOffAuto enable_migration;
>>> +    bool migration_events;
>>>       VFIODeviceOps *ops;
>>>       unsigned int num_irqs;
>>>       unsigned int num_regions;
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 06ae40969b..6bbccf6545 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -24,6 +24,7 @@
>>>   #include "migration/register.h"
>>>   #include "migration/blocker.h"
>>>   #include "qapi/error.h"
>>> +#include "qapi/qapi-events-vfio.h"
>>>   #include "exec/ramlist.h"
>>>   #include "exec/ram_addr.h"
>>>   #include "pci.h"
>>> @@ -80,6 +81,46 @@ static const char *mig_state_to_str(enum
>>> vfio_device_mig_state state)
>>>       }
>>>   }
>>>
>>> +static VFIODeviceMigState
>>> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
>>> +{
>>> +    switch (state) {
>>> +    case VFIO_DEVICE_STATE_STOP:
>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP;
>>> +    case VFIO_DEVICE_STATE_RUNNING:
>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING;
>>> +    case VFIO_DEVICE_STATE_STOP_COPY:
>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP_COPY;
>>> +    case VFIO_DEVICE_STATE_RESUMING:
>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RESUMING;
>>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING_P2P;
>>> +    case VFIO_DEVICE_STATE_PRE_COPY:
>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY;
>>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY_P2P;
>>> +    default:
>>> +        g_assert_not_reached();
>>> +    }
>>> +}
>>> +
>>> +static void vfio_migration_send_state_change_event(VFIODevice *vbasedev)
>>> +{
>>> +    VFIOMigration *migration = vbasedev->migration;
>>> +    const char *id;
>>> +    Object *obj;
>>> +
>>> +    if (!vbasedev->migration_events) {
>>> +        return;
>>> +    }
>>> +
>> Shouldn't this leap frog migrate_events() capability instead of introducing its
>> vfio equivalent i.e.
>>
>>          if (!migrate_events()) {
>>              return;
>>          }
>>
>> ?
> 
> I used a per VFIO device cap so the events can be fine tuned for each device
> (maybe one device should send events while the other not).
> This gives the most flexibility and I don't think it complicates the
> configuration (one downside, though, is that it can't be enabled/disabled
> dynamically during runtime).
> 
Right.

> I don't think events add much overhead, so if you prefer a global cap, I can
> change it.
> However, I'm not sure overloading the existing migrate_events() is valid?
> 

migration 'events' capability just means we will have some migration events
emited via QAPI monitor for: 1) general global status and 2) for each migration
pass (both with different event names=. So the suggestion was just what feels a
natural extension of that (...)

>>
>> Applications that don't understand the event string (migration related or not)
>> will just discard it (AIUI)
>>

(...) specially because of this as all these events have a different name.

But overloading might not make sense for others IDK ... it was just a suggestion
:) not a strong preference

>>> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
>>> +    id = object_get_canonical_path_component(obj);
>>> +
>>> +    qapi_event_send_vfio_device_mig_state_changed(
>>> +        id, mig_state_to_qapi_state(migration->device_state));
>>> +}
>>> +
>>>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>>>                                       enum vfio_device_mig_state new_state,
>>>                                       enum vfio_device_mig_state recover_state)
>>> @@ -126,11 +167,13 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>>>           }
>>>
>>>           migration->device_state = recover_state;
>>> +        vfio_migration_send_state_change_event(vbasedev);
>>>
>>>           return ret;
>>>       }
>>>
>>>       migration->device_state = new_state;
>>> +    vfio_migration_send_state_change_event(vbasedev);
>>>       if (mig_state->data_fd != -1) {
>>>           if (migration->data_fd != -1) {
>>>               /*
>>> @@ -157,6 +200,7 @@ reset_device:
>>>       }
>>>
>>>       migration->device_state = VFIO_DEVICE_STATE_RUNNING;
>>> +    vfio_migration_send_state_change_event(vbasedev);
>>>
>>>       return ret;
>>>   }
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 64780d1b79..8840602c50 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3362,6 +3362,8 @@ static Property vfio_pci_dev_properties[] = {
>>>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>> +    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>>> +                     vbasedev.migration_events, false),
>>>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>>>       DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>>>                        vbasedev.ram_block_discard_allowed, false),



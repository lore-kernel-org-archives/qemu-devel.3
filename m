Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC03E77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAHq-0001pv-8I; Mon, 16 Dec 2024 07:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNAHi-0001pK-8N
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:33:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNAHe-0002IX-Px
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:33:13 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MpUN008324;
 Mon, 16 Dec 2024 12:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=UqOMl2aLRcq2Ukq0/79Va82/4PFZ3+IuXrkhpR+Rl7Q=; b=
 eDlrX9xWdZibyhL6M83rZY4+qIvQWMFXTTidvxVsRsMvTkXE1f+HDjngYOt+gkHv
 3ZFIrXq0yPyQ9ZFhbh5QuNTlW+lvZoqK/hq5r+2YZPb63bXdnl2KIespHkrFAiTC
 2Wj5jz8iaaLb+TdrxkpWx598wDOu1FZITAU3hxCnXI7eyeRBaeFKP6OJ4qPpsJfh
 yJkDDjquYvvY/5gQ8+wwH9ZtToDiM63jMIkoJ9wLKQHwaPL6/5Ak22ycePymh6yg
 LMaK0ZVumNaU3ZGW07kf6kUjCB1iIfgn4YUtNMD/SpICg9dw/l0baUy9btKCfRqX
 aLaO2g4fRkBGV4E+wjV02A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2b50d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:33:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGBrFZ7035232; Mon, 16 Dec 2024 12:33:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f705rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:33:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zK461OuYttPCiaCd9OrSEBcpeRtDfyrs9YKsJzUrWHPMF9mormO4pVu2Bf07N+y9wf1xgv3jvfUQZ6Er6+3D2YjcTNehDOXvL5qvrR8gDqBheNOhlgBIq+BsvCy6/wnLGic6Divm4REOMCrNRddHxEZ0hP3SQNVQ5j051pL231V9AwRSoN1FIHL1mAFkR0Nblj+AO+xNT9vZLaVkHKlpjYx1gQGhwpIiFlkfXSHmATC5qWY6HQzkPu/hiwtM0FjHgceN01dxW2Rx0PQRldvarJCzZtcPd+sg5sOV0pKtrl2ogY1/eqWMgVWSBOx4Mi29LDA/U6YzGFBBczLIjhfHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqOMl2aLRcq2Ukq0/79Va82/4PFZ3+IuXrkhpR+Rl7Q=;
 b=Gvr68cQm1EWO8kyBzKBgIWcRV2uw/2Xf/T3G9ISneHWqnI1Lc1/XREih/jNV1WppccKSCZiV3dNnkU2rMJO3j73iYtJ+Me/IzdOM1a3QFHecL6Swq3eyeRtMcT/kWZcG+J6PKKTzeewlO1M+5JLU0idc60dyL2PllLdxUFccqOGY2bjyLCr/s4bdvr2vDpvK/a183V3w5I8y9y5UX+HY9uQ154hfNYT971wpdAevsaRsBwxmWpzFMSpwv7+SA4v4874ndFzuFDw9NS2TAGg48jMSjhUZoC79WSQWjKHUPet3N6oYUWJQ1ceOahkvrwkS3DMlIVjnpSJP2gALlGSJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqOMl2aLRcq2Ukq0/79Va82/4PFZ3+IuXrkhpR+Rl7Q=;
 b=R+26s2tPc2ToV8Wh7Cm30eB87X+dceRXwtWy25eI3bXcIPwgHQRV15nkr6nPxftRPfPRqupT3f7vRSGAVZA5zdFfYor3tMEvkz4cHhO/R7Fc9/NT8HeWPnpTT3lYbnqB2vrYc1K5XRA0GjzBupvUFJkIImN5LG9hjRCEz7zcHIw=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MN2PR10MB4381.namprd10.prod.outlook.com (2603:10b6:208:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 12:33:06 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:33:06 +0000
Message-ID: <7fdc0511-7a31-4e75-a873-c4c67edbc08b@oracle.com>
Date: Mon, 16 Dec 2024 12:32:57 +0000
Subject: Re: [PATCH 2/9] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-3-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241216094638.26406-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MN2PR10MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: db9cc4cf-60d8-4229-37fe-08dd1dcdca85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUdRb3hMN3E5cnJvMEFwcHVEZXBVN0xrTTg5NExCUzhGVTFXdHdDWnJET2pv?=
 =?utf-8?B?bmJ2eVpQMHRyejFyUkppRFpNSkdaY1ZLVUN2bW04eUxaNTRhUGFtWE04Wk41?=
 =?utf-8?B?NDhiQldDdmNscVpDaVhrWWFTL1pBTU1zSXNNS0pMY0gwVndPMlR4Q1pLRHZV?=
 =?utf-8?B?MjlvMzdKbW82UzhldTA0TFdWM3Fybk1OdU1ZU2FsVlpmQ1hVWldab1NHaGVq?=
 =?utf-8?B?UkdwSUdnWEhJR0dJWXV1REpwN0J6NHNiV3BUd1pHL2w1aEJhNmkvQW5HYmta?=
 =?utf-8?B?TTR3emRVU04zbU9HTW9ZU09JSjMxM05rN3NUdklJL28zeFlwQ0tLeUtiTFVR?=
 =?utf-8?B?S1poQ1JkekdZdWdPd3JDSEhEMy9reHdHanBlRm1jbGFXTWVWVmVVQ3pVSjFl?=
 =?utf-8?B?UlRWKzZVRTBoNUtBVGVPS1I3aUU5L3JON3FmV1NiQ3VTMU1JeGVJbUxKdXhm?=
 =?utf-8?B?cWhNNDAvdlp4K2NvQ1ZoOTIvZmhsMDltMzJUWVEwT2NqZFhOY0tnNGJzUG9H?=
 =?utf-8?B?UWp3ZmRrWjdZMVQ0MmVDSVVTYTlpamNGTU0vSkdvVEZKVGJuK0tHK2JGT05M?=
 =?utf-8?B?T3JjVlZFMUVnT1JHS2w1Ulo4ZTUxelIxbXMvSzFGSk1VN2pTY2lMcWdMbHBZ?=
 =?utf-8?B?VEhOSWU2RS9zM0pLUFZuZ0kxdXYxWjExNE0xZWpvS0R4Ty9peEc0VVdmS1FQ?=
 =?utf-8?B?TVhKTXVxdldMUWFTdzVZY21NZExrS1RyYkdhMXA1cTdOa2xDM2xMVWR2aU9O?=
 =?utf-8?B?TzV5enhveGFSeWJoMTFZaWtkVjZSU3FEK3F1QTlLUFhmc0xvV2VGNmxvYnNz?=
 =?utf-8?B?Q3NCby9EVWhaZlRNZmJ5SFYrWmU0dnBvN0pQemU5emJENzBYK3FGejloSHIr?=
 =?utf-8?B?cFNObHpqSWtEazNVVis2Mk1mQ0p3aVRObmEvSUxaUndNUzQyVms1WFZqWTJT?=
 =?utf-8?B?M2tTbU9tenNmalZyQlpWV3NFQXVjM1dzVVI2SHRjZGJHODlzUlNDZFJCS2Fs?=
 =?utf-8?B?bkZNTFV2V2lFQmZSS2dyTzlRZUs0RXBaUzFIaFdodExKWkNLallYMGk4dnFK?=
 =?utf-8?B?Y3FjbmMzRXFOTlQza0NkN0UzZVQ4bTd3SXYvSGFNdzhudjRwK1FJY2QvUFRj?=
 =?utf-8?B?b05UQmtIZGFUT203TDd5bXFWRk44eGRhVmw0OGJUV29PbXdMQ2FvZGdlVGpI?=
 =?utf-8?B?R3RiUUM2Q3FzcGUrNzc5VXVabFdQbkYxYjNtUEF5WEZERnk2UnJZakZnNnZK?=
 =?utf-8?B?akU0S2h2djlvbURieDRoMURUVSsyRDN3QW1NbEdCSWRzVkpoQzcvVFI0VHRJ?=
 =?utf-8?B?ZExxSUZoY0xvOGxDbkNoSG4rdXZZV3ByTzMzdDlCcVVab3FFQWMreVdVWGkz?=
 =?utf-8?B?Zm1LYkV2eFUvUFJ5ckIwZ2wwcnhHL0pEejFSdmVoWklmSWEwVHozbUtEeWtY?=
 =?utf-8?B?WGMyQW92eUNZWFZnYUluVFQ1dEcrczFNOGhmYTlMRzBhbDV6RGs4TWsxRUNG?=
 =?utf-8?B?Mkp6akdWRWdZM1p6QUVIemRjZ2RkMldvR3NVSjN1c2kzNGN1alovQUt3MW9Y?=
 =?utf-8?B?Zm8yUlRoalpMazlxT2FCWS9UeUJFaVFSaGtobG1qanM5V2c3enVGeFNSVUMx?=
 =?utf-8?B?SUtRVmJxM2xOMWF4NVV3TDU5TlJDcTlKd21ETXVlWFRVanRpczN6TXBFcVN4?=
 =?utf-8?B?OC9qL3JBTEIyeDZLcHhveFl3RnFsSmU2MXd0QW5oWStzT0IxSDY4U1hIck5a?=
 =?utf-8?B?eExaV210dTl2SzhQcytyTnNsTzZ5TURNR2kxNXgxQTdURnIxbHlkeVVnVlF6?=
 =?utf-8?B?T2lqaE5lZU5BYWhYUzdPMDEyVjdWRjBlT1N6bWRrVDV3MTBMbHZsRDJSSlZz?=
 =?utf-8?Q?ESIlvMknHZThz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFJER0VncGFpV1NGSkdDeUxDSGhtNk9XZmFYRktqQ2JCUTlqallHcXlQSk9q?=
 =?utf-8?B?YXJ2MnoxeXBnRXpYVEh4L3pSZmVjTFlGWkdhUlFNZTE5cDNYWFFpem43cUFn?=
 =?utf-8?B?SEhuWVJ0Y2RKSEZKTGY3N0diaWVUZWhkVmFaMjFjN2ZzcjgwWVNpOEkzTkJ3?=
 =?utf-8?B?b3QzTlM5eVFQYTZUNVpyMjkxUUhZejREU2pPekxlVEovQkVXR0dQV0pGeW9Z?=
 =?utf-8?B?Y2g3bDFNc2J4SWhZc0Jpbi9DVVk5bjNYWE1Ea1Z6WjM3N042d1BtWHpscFhT?=
 =?utf-8?B?RWs5cFYrY0xQR3dvNXo4YndrcEJwSlFOL2ZlTDVvWGJnR1VVdERySnNEQy9i?=
 =?utf-8?B?VHQ2U21wNzhoWlo3S0tPZjMzcnUyNEVFOTV2V0ZFblBodERPYjA3dGwyM0pJ?=
 =?utf-8?B?K1lzeFdtSHN6Um1hSGhodnNuS1k0VitpdUlMWXUwYUJhUmh0TkU3ejZKd3Nu?=
 =?utf-8?B?T2FwMEtldlBWUGtEaU9lb0hyRDd1WExxeGxRZVcrVW5OcVlWRThaNEI3SWNJ?=
 =?utf-8?B?RUtpKzRzWmNWdDE5OXV4bktac1Z0NURQSkhXaFFhUDRRUEJYSGZtQkZ3TURK?=
 =?utf-8?B?bzgxVzVHd3h4SFFTVWNGdGJ5SnBSZXROb0N4alhnc29LcGdwcWJzSmkzVG1y?=
 =?utf-8?B?bGM2SU9nNW5mLzVtOU9uNEtPNzRVRkdyWjVLV0ZOSHZmUVJ5WTBZNU5DQUtQ?=
 =?utf-8?B?M1J0TlUzQXpFN1VxZStweWRWQU1lQkNzanRuVjFlVzZaaHFHc0dZZ0dBTFlS?=
 =?utf-8?B?dytxUGRadStjNGdEUTV2dGF2d1RRSTdjQmRvVXBRblV1TXRaZityMitkWDdC?=
 =?utf-8?B?UE96VEl4WWNMaDFERXNrOVIvKzhsMklCRHJUK0JoV3hCN3NGMFdxb3ViMXQ1?=
 =?utf-8?B?OG5JMlBsN24rL01CUytyZklORFFHcml1NUE3cEQzT3Zza1ZSbm5zSXU2enpY?=
 =?utf-8?B?R0xlWUpNVG9hRUxqa1pibVRFTDg4WnNxdUZDZ0Q2M3NyR091cElaTnVTVEYz?=
 =?utf-8?B?VXVEWlRvQW1xbEMySVdmaEMrSFgxeDltMmMwdk1VT0NuRmh1QitnWUtENHQr?=
 =?utf-8?B?R2ErdjZ0ejk1cWw3M3lTTWNuMFQrUzVUZXZuQ3lmUW5JODJwRU9BWDRsZGE3?=
 =?utf-8?B?S2V1TmZNb1h5b2hTQXpHbVBWWGwyam5VcGgxVFdXRGs1T092YW0wVS8yemJE?=
 =?utf-8?B?a0h3RzQrdCsxVDBLVGlTRXYxMnJjUy9iS0syTk5ZZnpwYlVsVjl6Q2JFdEk3?=
 =?utf-8?B?VFltMDlLNzhBZFBZRHpuZHlsNmZpRldocVBTNkhsblMweVhxZEVhTVY0WFBJ?=
 =?utf-8?B?ZVJhQlpFSDd2N250aWNYVUpEZm45TWtpdGN0TUxSZ29KNklCcGZLakhNUEU4?=
 =?utf-8?B?Z01tTTM2NUpreWxOU3NpNE4xRTBGMWVrSm5rdFFxWm9QNit1K2JKdnloRTNH?=
 =?utf-8?B?YkFHRm1ZaVd2QmJQY2FYNkF1UGpkN1diYjJzTVFpVVh0cnZaaVJhMkEwdFNO?=
 =?utf-8?B?aXUzL1hTRnplSkFPU09vR1ZXN3VWNVUwOHJQVTBrOFFyWGZtNDc0ZHIrTWZn?=
 =?utf-8?B?b0U5eVowcTBWdjExZ2FjZXFxY2FUajFhR3lOa0RqZ3VKWVl6OTlzWmVUZjVH?=
 =?utf-8?B?SWhRdUtrVlVQQXVoYU40TVBXV21ubTJtME4xeEhKbUhlRG5XTC9rZ1dObU9t?=
 =?utf-8?B?Y2NCS2M0WXpMcElBandMdXRqb3BtdjNnZ3ArMnZ4b0R5SmdYQzhIN25USlRL?=
 =?utf-8?B?aVlrY3c0b2JFemhIQUJkVmw2U2ZnRE9ReHg3RE1uVTJLbmcwSHAzT2pqVFkx?=
 =?utf-8?B?ZjJMWnRaV21TaHRxc2FFM0Z5bzhLM2pFbHd5aTByZlNuclJNckJYMkV2QmVC?=
 =?utf-8?B?L3RzTEcrNW1ZOVNITEVJZzZpWUNoUlZDU3VTVG1CUnM5a2g0aTRFNTNyUDFJ?=
 =?utf-8?B?OE45MVBNZmNyWVJRNFQ0UUpUTU5Nc25IMEZrcXl4cWdBdG9DcGo5WkZwdzNH?=
 =?utf-8?B?aCtHTjlWNDVMZkR3ZDY3WGcySW51TFZnMUZobEtVYkZVRGlwNGVseW1RZkpD?=
 =?utf-8?B?TVhMeklNcUdxNlFtYzVXT05wY2lmRWdaU0R0MlVRakt0R2N2SnhTVnpCejRQ?=
 =?utf-8?B?cHVFQlo5a09CSzZVdjN5WWNDRkgwTjlXNXgzYklHUi9JeU1TMFNYOUQyS05w?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9kPnRg8ZzIoFLvezzv7bt5JEqUyUpPq4gBxrTqnqFZf2UuK9vVOrLizOKqKJjXOe7ojVS9ZY0jvBKscUowCiMNV+iSKoreHSzb7VCNBAuDYDWz9iD0k/JF4F0pUpqt5VoLx7J376jpkJohr/NzxM1064N298INdaDl4u/KT2d1fqdOJvMJ17Z6bt5wGKyAuVrWx8b/Zadq7K/DGvRBcNXG7g72pDP0iYpeCXSWoI8OdkJn66VKtKFCj2Ur0dUjLxUMg1xzT87YgyL9Oo8hvqHzhNtQLAgd6WLlljMsL0B3oCGjRlzK2DyBe1DsFSRtgFN2uYPLABZQMSw0YykwfZPB+ms89qpR2JvPRlGkObXkU6389Z0LUcFYKPVOB2iex+lsghzDpHrz1XqN62BC5Ri+nTHLKUOP15TVbNm7/hVm7Lqp6cv7X9Qq2M9xUVgeK6VYvTWaHSpnphkwmMxZjNzCM1qkCjsDBht1DkWQruKEM5H1ecWXrVFcJX1xgfSQzxEAwfCyEdwdgEiT2XyI0gZlti2BFGUlqL4YhngNivcViAIXMyQn5iU1nFILq/aRX+j3ZkuDZ/g+law/+2HAAtR2OS/L8T1v1UZN5An730jAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9cc4cf-60d8-4229-37fe-08dd1dcdca85
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:33:06.2145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBFK7mitdjoAMR/VGdVKUL3qBUL+t7bOH42Bsq9bR9C5B2hlUinOdxjn+WaQDmoKHLd5BayC7OtJ/kYx5Aeg4heBxKXlKKhbxf0dyMMYzu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160105
X-Proofpoint-ORIG-GUID: PUUHDxkPHCyDJ24WaBpZFHkZDCN16-_-
X-Proofpoint-GUID: PUUHDxkPHCyDJ24WaBpZFHkZDCN16-_-
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 16/12/2024 09:46, Avihai Horon wrote:
> During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
> check if dirty tracking has been started in order to avoid errors. The
> current logic checks if migration is in ACTIVE or DEVICE states to
> ensure dirty tracking has been started.
> 
> However, recently there has been an effort to simplify the migration
> status API and reduce it to a single migration_is_running() function.
> 
> To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
> it won't use migration_is_active() and migration_is_device(). Instead,
> use internal VFIO dirty tracking flags.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

The refactor itself is fine except a pre-existing bug:

	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/common.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index dcef44fe55..a99796403e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -170,11 +170,30 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>             migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>  }
>  
> +static bool vfio_devices_all_device_dirty_tracking_started(
> +    const VFIOContainerBase *bcontainer)
> +{
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> +        if (!vbasedev->dirty_tracking) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
>  
> -    if (!migration_is_active() && !migration_is_device()) {
> +    if (!migration_is_running()) {
> +        return false;
> +    }
> +

Tieing to migration status means that non-KVM dirty trackers cannot be toggled
unless somebody starts migration. When really your original intention behind
commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
was to avoid the setup state when you are indeed during a migration.

Now you can actually start/sync/stop dirty trackers without migration when you
use calc-dirty-rate which is immensely useful to draw out how active a VM prior
to starting migration.

The fix is simple and would be to flex the condition to be something like:

	/* Migration status is 'none' with calc-dirty-rate */
	if (!migration_is_none() && !migration_is_running()) {
	    return false;
	}

This is ortoghonal to your series of course, but given you are skimming around
this area, sounded like a good idea to raise this. This patch below is what I
had plan to send when the development window started, but this was before folks
wanted to unexport migration status helpers. What would be the alternative idea
forward?

-------------------->8---------------------

From ace22f29a0547353e4ed5a0db53292a77f79fa81 Mon Sep 17 00:00:00 2001
From: Joao Martins <joao.m.martins@oracle.com>
Date: Wed, 9 Oct 2024 00:27:46 +0100
Subject: [PATCH] vfio/migration: Allow dirty tracking reports with
 MIGRATION_STATUS_NONE

Invoking calc-dirty-rate HMP/QMP method queries the VM dirty rate
without starting a live migration, which is useful e.g. to understand how
active guests are and even for testing purposes. calc-dirty-rate asks
the dirty rate from the VM and it's not restricted to a particular dirty
tracker.

However commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP
state")
didn't consider this and currently restricts that VF/IOMMU dirty info when migration
is active to allow it to be skipped during SETUP stage.

The vfio dirty tracker is already started, the reports are just skipped
based on migration status. So change vfio_devices_all_dirty_tracking() such
that we include MIGRATION_STATUS_NONE to cover calc-dirty-rate case.

Fixes: ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c         | 4 +++-
 include/migration/misc.h | 1 +
 migration/migration.c    | 7 +++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index dcef44fe55be..0c188a2baac2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -174,7 +174,9 @@ static bool
vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;

-    if (!migration_is_active() && !migration_is_device()) {
+    /* Migration status is 'none' with calc-dirty-rate */
+    if (!migration_is_none() &&
+        !migration_is_active() && !migration_is_device()) {
         return false;
     }

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 804eb23c0607..857768b51383 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -53,6 +53,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
 void migration_object_init(void);
 void migration_shutdown(void);

+bool migration_is_none(void);
 bool migration_is_active(void);
 bool migration_is_device(void);
 bool migration_is_running(void);
diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c85..49d11e1adf04 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1637,6 +1637,13 @@ bool migration_in_bg_snapshot(void)
     return migrate_background_snapshot() && migration_is_running();
 }

+bool migration_is_none(void)
+{
+    MigrationState *s = current_migration;
+
+    return s->state == MIGRATION_STATUS_NONE;
+}
+
 bool migration_is_active(void)
 {
     MigrationState *s = current_migration;
--
2.39.3


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AADCA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 06:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unt8D-0006iX-Sy; Mon, 18 Aug 2025 02:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1unt8B-0006Zt-Cz
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:14:07 -0400
Received: from mail-dm6nam10on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2413::623]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1unt87-0006wj-Tn
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:14:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=am6R+YDyMQZsU87205NagQdGeWORcVL3MMdhdvSjwsp4SV6BDyZ/MjKxUUE3D7A0mLwpycCYCoOyUrm2jFKuhV0zafk1PCzAishoKUD2Q3eOhDSmDuxE+YMZ+V3l+BvRBQv8L/V2k12JLI31xdY6pdZ6aYqwoelDsaxRtoJvzX1gm1WsgFCJ3KM93YicK/KndBrbKcuEAmc4hOd/UNaOl6J57EFbHfV2gPn9m6VVLWR3RUcfPs99xmwgY21YNKOYkD7YmLJq878kaSBDh4U7rLVs6ayYg6K1m84v1eiHts66gBipzHFeOxhROAB0otUZQGG/1vnQ54jTDslauQAy4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crw2ghzNeXQIRsU39pwx3G5rSS88wBxZJ7ANtXVMk34=;
 b=AhNKzHoQNGkpAeae/EdtX3Rcpncqiev22eHwp33COEBWK4RIz7C0YgK20CRuvfMbzTes+yXxlWmJM+JU68N+L1O9aFdYJ1M8GtdTkBKTc4JB2hvls52Yp+/iWSFxX8sh87kkd+401cCsJ4g3gYkLTVclfpaTQDGP1MOxRS0biorCN2TPTh2S/DLDbM4dKYw0vnM5JjPw89qd2XLnWMe2IpUN2Tb3d7+FziXEVk/iQf9x/I25JRu32nedbmnANPLASSOgmJDz4YOCDLF0y47ZZQScSvWUbMPUipwu8Afhy9tBcJcqtCAOY6lg8l9p2wpymhGRC9f5HvSSNLEQ6RUtiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crw2ghzNeXQIRsU39pwx3G5rSS88wBxZJ7ANtXVMk34=;
 b=CF3MPo/OvsNwI61zJG+o7nHlVlPRK+fTO/vb3mmYRQDpnkaqMMWHSDeMqMoY2PgpdBJwdOp102fmkDGxPdyFQSO1X3GhapqXtSZUPcGb+FCE4CL7jNRGmeh4WgPtUI7cBpfxtmzYCeUx7SJsPy0/K3HKZqsIYi+DQ0kd2vzL7OIsO8NcJvbByrrJkfwtesRGwuLAwq1SZwmcbKiE1167EB3yZA8tbZUrOXCiBpPYlVFxujv7XTdoKxZKgqIHinnueFahNMhoqjhHvf+TnSzfkn/9IU9ZcZGpKRW9OYGe7IklQ6T+1BWgVoDu2bDbIfye5LY3RQ//8oWOF1UG/YpIcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA1PR12MB8966.namprd12.prod.outlook.com (2603:10b6:806:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Mon, 18 Aug
 2025 06:13:29 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:13:29 +0000
Message-ID: <363fb7c4-a8c2-49de-85f5-f007ae94189e@nvidia.com>
Date: Mon, 18 Aug 2025 09:13:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] VFIO migration will not be aborted in a corner scenario
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Kunkun Jiang <jiangkunkun@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>
References: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
 <f6c1cff4-a0ca-436a-b8d7-3d19ce49e848@redhat.com>
 <506cab2c-35aa-4c68-ba94-b26ba1b315bc@nvidia.com>
 <f6165e17-a926-4a59-9b59-2dd6853f20a6@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <f6165e17-a926-4a59-9b59-2dd6853f20a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA1PR12MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: baca34d2-5616-415e-6eb3-08ddde1e599e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azVObHZCcWtuL1lYak83Ny9sSTJKUTd0L1A4azhGSUdsQ05aYlIyclh5bVBP?=
 =?utf-8?B?cGkxYmRVemxqN1ZwVWJBRlMwVFhOQjlTNWJnUjAybUJaZ2N5UnJiQ2plVmVR?=
 =?utf-8?B?eWdhZkdDU253R3o2N25wS3l5dkZYZDFXQXZ3YUNMcWVPbERJYU9lQ0s0Yjls?=
 =?utf-8?B?VkN3SnhjVllUYXVOT1VxTkJ3THQzVk00cVd4Qk9JNGhoNjRjODNlODFYYU9n?=
 =?utf-8?B?ZXZ4clpMTzRpcE1GWEFjbEFEaFpEWjlwNVlHQy9NS2djRmJtcGVodEtNamI1?=
 =?utf-8?B?amc2bmZBSXJHSndyUWtoaEhTMXJYdDlTNHRTN2hsaVBNTitnVW5OQkd4ZG9P?=
 =?utf-8?B?N3hVVmhjWTZxMGVQV1c3Sk1KVXNnM1FkVTlINVNMK3RzcGFuUmRlYWZtZWxP?=
 =?utf-8?B?dmZaNVFzVElaenhJQ2FHRHM4ci8wWVdPRDNpdDh1SmRBcVN6eGJyVm9obnp4?=
 =?utf-8?B?SEZkTG9QNTNjWHM3aXozRlNQT1gyOUZXVTRPdmFMRTA2TnYybzlaYzVlY0M2?=
 =?utf-8?B?eVR6d2hXQlRHOGx6RmZaZDhZNHFWbjc1dUNYVVhlMkpYSWlGN28zTEpSOHVC?=
 =?utf-8?B?Z1V6dGo3SXlVYmVzRndnQWl1eTZ0bk5USHlkdW5mMHlxdzNZN3pLK1lxcjA1?=
 =?utf-8?B?YVBzcCtkbmg4ZDZhK1FKN0daYmgyQkgwbHgwOGwxV01FVFZvODJTbG1jcWZl?=
 =?utf-8?B?ekVHMUlNNitTNHB0MXY1VWIweXJ6amNrdWFNNXoxTFRJS0JnQTladnhQTGN3?=
 =?utf-8?B?S1NuYnI5cHlsZTlnWkxCaGkzajh1RFhxM24wcUN6WHphM3VOWXgzS2hPek1H?=
 =?utf-8?B?cXRIVW9Ra1J4VWFES0NzcTVKTnRtT0xUcHo4YVF2ZFpXY3VoNHJuWEFHc1hT?=
 =?utf-8?B?Z3RMOWdRWitiUnVsWHM3TTMxRGo4L0g2S1cxTThmK09mUmZkaHpiSy9uMHcv?=
 =?utf-8?B?TXBTeDNEdzRsM21ldnBMRmpFZzMwaitkYkZMQWEyREdzKy9xMVlRMm8ySVRx?=
 =?utf-8?B?emVuVlFRbm4ycnFxaDhPcjYyMU1uMUVaY20xYWQ4cmJNK24xaEYwZGxiZ1hm?=
 =?utf-8?B?eVhGbFB0VnJSWXlITm9YSElUSVE3azNtTTdnOENsbEN6MnRtTTNVWGVIUWRx?=
 =?utf-8?B?RzR4elV3cmVTS3FXOG9YOHZqQmhteHlpT3Y2b2daa043UTRZcURMc2laZXUy?=
 =?utf-8?B?UWowWEhwTTgwRE9XczFYTGZ4eElMU0hkNm9zOHJLd0xMaVRUYVZDZGhwUEM3?=
 =?utf-8?B?OUZtZEt6Vk1sanB2ZDRZdzBHTW1xR05GeXJZV0Y2c25WNEFhZ3BOVUJ2QmZF?=
 =?utf-8?B?eW1PZ3hyMlhxaGR3YTAwZHcxNEV0aFdJYWpoK3RWckNOQlBnTW5IWWhORlIy?=
 =?utf-8?B?RDlSYmYvOTJDRVNPcnFhWkkwNEVTSzVYWUNCSCtWRitCVFFzZkk5QWR4bUpp?=
 =?utf-8?B?d045NEs4Z3NnbENaREUzOWdtdTI3VkZhL3dYczljSVY3UFVLZ2h4R0YyZGlr?=
 =?utf-8?B?dllCbHlnc010OWJrNUlHNTMrcVNWNVNDa1lVRnpHNGJLN1o3OUhzZ2ZJemV5?=
 =?utf-8?B?Q3YvZTl2bzZ2UGJnYzRob3JlQVFsOXUvNHQ4ejhta1FlV3BaV0sxL0ZqclFH?=
 =?utf-8?B?Y201K0dUQzBwWmVlMCtVaXM4MGdTNEd5OWU1SVBQVXNteHlwWis3OWRNSkEv?=
 =?utf-8?B?RXJPSEFMRXZ5MDIxK3N2SmhYd3NVSWtkczNNd3hWZWx6TFlEcXprbHo4blk2?=
 =?utf-8?B?TXFTc3JCcmovS3U3WjloMDBiM0p1Qk5Ec1RqUm9OM0FWTHRncjRTRktoKzc3?=
 =?utf-8?Q?YkHRCtCYJJo+2IHRtp4RvcLzr/Nn3+WD0J4DU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzlMb1dUQ3JaeEozVk5qa3hkTFZFdmp0cE12RVMxM1VyMUlIckNZZEgxaTM5?=
 =?utf-8?B?QldIQVdkOTgxcEFyNmN4dzFpeUpsa1FDYi9McCt3OVFhblpxR3doZDJzOFRo?=
 =?utf-8?B?cEljM0lsOTRoWlF0Y24veXdSUUNJUWQ4OFQ0U3Fua0tldVFkenRTYnU4WUNW?=
 =?utf-8?B?NU5EaTB5SlBEUkJtVlpXZlAwaXo1b3ovMnZwc1JsODZvdlNNQmJ2ZnRpU0Ex?=
 =?utf-8?B?aWJhYTVXU0I5NGloczVjWDkwVzNwQ0FUUS9xVUdYT1dKSCtGVGV2S2lmZVU1?=
 =?utf-8?B?cHhHUHY1NFE5bXI1b09VaERLQTVORFpMdEtFcXpKcVRDclA5dmxXd20zYmds?=
 =?utf-8?B?ak9Tb3JINmExTGIxdFFYclRjNjhCYUYvTzVsR3dLa3BINUxPUittK2NTOEpM?=
 =?utf-8?B?c1VDUXNCci9XUnlRVGJKYUJCenJ2Zm9Tck41OVNZU0F3aU5LY2d5cVhHTU1p?=
 =?utf-8?B?QzJGclBKQUNtUmxuaDNwWk5kT1BWdHRhNFFKYW5QY0xla1cvL2w2NEt6Qnl3?=
 =?utf-8?B?Z3F4QUxZY2UwVTFkUDRHYXNDZktUZXFhRk04SVczU2pSRW90ZkxpaWRSU0lJ?=
 =?utf-8?B?R1JublFoTnNISVFrUFQ3c0FoaTJNMzdGbFVaTTNXdk52VDdPUldlZ2JEVlVS?=
 =?utf-8?B?eTV2dXVOb0VPWEVBY1pCQ3JkaGR3MUp5NnhxOCtTbjlML3lJRlQ5UnU5RUJi?=
 =?utf-8?B?MUVHVDJHSnZUc0lwQ21NL3poR2x2R01qamowajVBZDJHRHlmMzNZS3VJNXIx?=
 =?utf-8?B?a2traTJOR21VcUZKeTFvK1p3bW1oS3M4L1JhQVpEY1dLY1VqcVltMmFjdlJC?=
 =?utf-8?B?ZTZ5YmJ1S2xXVm92bzFzTUJkdWZheGdxUmo1QjhzeW40SThJWHBDazd6RnJs?=
 =?utf-8?B?RUlLYSttMXVrQXFDa2Rpa241ZmgyMGpwN2d6bHBNNHNNYmVuUnNjaWlwSU4x?=
 =?utf-8?B?UkN2WWtlbzVDVVdGWFd2UFVpK1JLK0Vnd09NaHhUZXFVTjJsYWUwamNtWVJi?=
 =?utf-8?B?OW1UU1hRQUdEUk45WjUxd0s5bTZXMTVZR2VjS2dTWVlEZFJ5d3R0MUJiN29a?=
 =?utf-8?B?eENCaTlDQW8wREt6dVdPbWxWeHE1b2NYRndTZWVpOFhzZmc4MzdMM1hLcWVV?=
 =?utf-8?B?STZZcFVNZWRTQlpiT01DUi9VVHMra0NBS3FMdGl4bVJCTmRiejN6UmZVRnl1?=
 =?utf-8?B?elVydnUxOEkwVGg1Uzd3T05kbHRmeDV4SEhIUWlCa0FmRlQ5djVCVVU4OVMw?=
 =?utf-8?B?VGJ1aE1UVUZaTXJjTkt5NzU1MG9VQ2txWWVkZ2NteW9ja2cwRm81Rzg5bDQ2?=
 =?utf-8?B?d1JnTkFaQUxDZEdnek8rQXhwTXRPOWU0emxjQlcxOHJyRTcwNmVibHlFZnNv?=
 =?utf-8?B?b2l4bmU2ZjMxdDhCWUVxZ1F3Q2JLNy94YmxkQnFtV1dkSFJKS3VVeXFqc1Zh?=
 =?utf-8?B?MTc3eCtERGo4VE4xeWw4Y24wVGdMTHZ6Sm9OU3JtcmEwVlhXZWExTXZEUUdB?=
 =?utf-8?B?dUN1ZHo2aEJnSXRLLy9sSHBFL3pTcTFUMkVJOFdZVE9BaG5BMWtyZFRUTzJJ?=
 =?utf-8?B?YnpqeTNyUHZSN0h2cDBQMDJwZlBKVXNuQVRraFM0S0JFYXhPOCtuR3NBOTkw?=
 =?utf-8?B?VFJVL2NxSGFlY204RndmNGxtMEIxVFFOTFk5RkFrSEN1STFwdzBRR0s4ZGdQ?=
 =?utf-8?B?Y1hyZHRmK3pLQ05CaENpdUUzdVVKdENqQkc0KzlXYmF3MG00UTNMek12cUt2?=
 =?utf-8?B?NWVVQitORzFwSFhzeUhxSnZKaGVpVUdYQVpDZ2d3SHNFV0RaZ2NlaktaMFVy?=
 =?utf-8?B?dXJQTlNPTHpZZzhkRjR3aWxFL3JnYTNFcyt4N1VQVTNOSkd3ZnllZitTVlg3?=
 =?utf-8?B?dStMb0tHUzY5YUNYUDdDeGR6YW5kcnZrUjFiY1liY1QweW5jYmtPcEdUT1M1?=
 =?utf-8?B?Q0QrT0F1U01MV3ZnSHVBZ0xFVVBJYTZlaDJVMk85eDdDS0dRa1VHUGdOK3hJ?=
 =?utf-8?B?ZVdDZFdBc3REM0RiNHdrc1Nkb1FtYmV2VnhnK0t5YXgxVlJrbEtoTDJNYkJj?=
 =?utf-8?B?bTV1dXVrSkdSaFdpMUNXdWg2M2p4TzI3UTA1bWpiWDhMQWJrZWVnQ05xQmFF?=
 =?utf-8?Q?xgZFZEJmWU6v2M94oYFp7M3rd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baca34d2-5616-415e-6eb3-08ddde1e599e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:13:29.3414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dhaq3xDnxUEp1LWt2RZN7lWlWP7CmcoTXxIGZzt+CGjPnh/H7Lw3FM9ujdtY/4ZhnXgxYP2jKGUGRYC/6zjW6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8966
Received-SPF: permerror client-ip=2a01:111:f403:2413::623;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1.376, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 12/08/2025 17:56, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/12/25 16:08, Avihai Horon wrote:
>>
>> On 11/08/2025 19:34, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hello,
>>>
>>> + Avihai
>>>
>>> On 8/11/25 18:02, Kunkun Jiang wrote:
>>>> Hi all,
>>>>
>>>> While testing VFIO migration, I encountered an corner scenario case:
>>>> VFIO migration will not be aborted when the vfio device of dst-vm 
>>>> fails to transition from RESUMING to RUNNING state in 
>>>> vfio_vmstate_change.
>>>>
>>>> I saw the comments in the vfio_vmstate_change but I don't 
>>>> understand why no action is taken for this situation.
>>>
>>> There is error handling in vfio_vmstate_change() :
>>>
>>>         /*
>>>          * Migration should be aborted in this case, but 
>>> vm_state_notify()
>>>          * currently does not support reporting failures.
>>>          */
>>>         migration_file_set_error(ret, local_err);
>>
>> Hmm, I think this only sets the error on src. On dst we don't have 
>> MigrationState->to_dst_file, so we end up just reporting the error.
>> But even if we did set it, no one is checking if there is a migration 
>> error after vm_start() is called in process_incoming_migration_bh().
>>
>>>
>>>> Allowing the live migration process to continue could cause 
>>>> unrecoverable damage to the VM.
>>
>> What do you mean by unrecoverable damage to the VM?
>> If RESUMING->RUNNING transition fails, would a VFIO reset recover the 
>> device and allow the VM to continue operation with damage limited 
>> only to the VFIO device?
>>
>>>> In this case, can we directly exit the dst-vm? Through the 
>>>> return-path mechanism, the src-vm can continue to run.
>>>>
>>>> Looking forward to your reply.
>>>
>> The straightforward solution, as you suggested, is to exit dst upon 
>> error in RESUMING->RUNNING transition and notify about it to src 
>> through the return-path.
>> However, I am not sure if failing the migration after vm_start() on 
>> dst is a bit late (as we start vCPUs and do migration_block_activate, 
>> etc.).
>>
>> But I can think of another way to solve this, hopefully simpler.
>> According to VFIO migration uAPI [1]:
>>   * RESUMING -> STOP
>>   *   Leaving RESUMING terminates a data transfer session and 
>> indicates the
>>   *   device should complete processing of the data delivered by 
>> write(). The
>>   *   kernel migration driver should complete the incorporation of 
>> data written
>>   *   to the data transfer FD into the device internal state and perform
>>   *   final validity and consistency checking of the new device 
>> state. If the
>>   *   user provided data is found to be incomplete, inconsistent, or 
>> otherwise
>>   *   invalid, the migration driver must fail the SET_STATE ioctl and
>>   *   optionally go to the ERROR state as described below.
>>
>> So, IIUC, we can add an explicit RESUMING->STOP transition [2] after 
>> the device config is loaded (which is the last data the device is 
>> expected to receive).
>> If this transition fails, it means something was wrong with 
>> migration, and we can send src an error msg via return-path (and not 
>> continue to vm_start()).
>>
>> Maybe this approach is less complicated than the first one, and it 
>> will also work if src VM was paused prior migration.
>> I already tested some POC and it seems to be working (at least with 
>> an artificial error i injected in RESUMING->STOP transition).
>> Kunkun, can you apply the following diff [3] and check if this solves 
>> the issue?
>>
>> And in general, what do you think? Should we go with this approach or 
>> do you have other ideas?
>>
>> Thanks.
>>
>> [1] 
>> https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/vfio.h#L1099
>> [2] Today RESUMING->STOP is done implicitly by the VFIO driver as 
>> part of RESUMING->RUNNING transition.
>> [3]
>
> Avihai,
>
> Could you please send an RFC patch with Peter and Fabiano in cc: ?
> This will help to discuss the proposal and keep track of the issue.
>
Yes, of course. But I am a bit busy with other stuff, so it may take me 
a few days to do that.

Of course, If anyone would like, feel free to send your own proposal.

Thanks.

>
> Kunkun Jiang,
>
> Could you please share details on your environment ?
>
> Thanks,
>
> C.
>


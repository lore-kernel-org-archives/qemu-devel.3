Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E4ECFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 08:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNSOS-0006NJ-K9; Mon, 24 Nov 2025 03:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vNSOQ-0006MR-39
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 03:57:54 -0500
Received: from mail-norwayeastazon11013056.outbound.protection.outlook.com
 ([40.107.159.56] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vNSOM-0006nw-Nw
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 03:57:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0kxX9l7pL6etyXxE4ewlxG8bcH3t7AzcGlv/uS9qnO2M4juKjtUKD9gWUEjeFs2JUN9i1fEeJKgXZP7I/cIsHtFM/IYENboZ5qOGEtHF+iOR8yAToUPncY2GBAPz/up4u/2Z+WnhXlIiVBkUZmG5LYtfWH4HGtNs04dQgmvwkzJS0/vIYsWpZidIp6qNaIkRcnjQ9YSsZFs+qT28h8T0VQdg5BM6VQEH6IXk5avVoc/GqZ58lJLVnGVKuQX9OLgCzsnZUE2MOfg8Q/DyLa48CmbIqG8wOmwxyuX396UTahbEUxnDy6Rw/VkjeukXlFWQnUHlfh5wC/zqhE+A+LWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4LrXNNxJdzldT7ZHw0wn1+TbeA/QWnAY2kQ5EIV8AA=;
 b=Rvu6AgN8ToCob2X9LveLK3n901EC3EcE24pX6iYzU+Im8VzphMLe2CSrk3qIEU+MzgXf+wAvDGv1Gzs2EISuhabfd3nvTze0eI8fR0zKnFXcMxaS/4reFJeLIZ2SL4RmYRGYIKz+cC/WbsBLTGWPhPNygWOh1/J16oaY8mgn5V64JqQF+T9Ib1kCBsS8H5OJQrgPF0qoqW3U9qcFf96rEUq/cjZCQPN2+FRKXClORIOHs17NhpAfw7yNe/Ov9REL6uKnhdqqHptHOKTztNLQZIZeegKpWp0F5DqzRKI/B+pMESo5j+QMMT2b60pUFqKE0l9Vk9hFGlR3hYLhF/ihlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4LrXNNxJdzldT7ZHw0wn1+TbeA/QWnAY2kQ5EIV8AA=;
 b=Y5CUvyxTos7cMwljLRVASFqhfccAnyfpZLwkttfLtlUAlxunzw+SoHYlOamYjfpBvMchOmtfb4Pjp6z/RAs0YmJgd0+jhLC4Jzlnh/wqq+U9Y76xyLb62kbBwkTtnOcEun6983geGUz0K5sQ1tglZd+YTi9JdXT0wZD8mN8vNodPtY9AkJ+lAMjNNlHcccICNoDb8Cgy0TzqYPzgz2Ongma9x+eyKOqI6Tz4kFTFSeuxiDANNknkbvmhmE8JVuLUdCpiypLt5ui85NJbL7FBK26i9Kiu2/wMKHp7kw4DQqhqYLzOc6XciN/ICb8UL3A2QLZ+Zsr60GSNuhpgsHmOAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8844.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 08:52:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 08:52:44 +0000
Message-ID: <041fe104-eaee-484e-bc80-1da8ed3dd762@siemens.com>
Date: Mon, 24 Nov 2025 09:52:44 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Resuming VM on network requests
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8844:EE_
X-MS-Office365-Filtering-Correlation-Id: 533a9dee-be5d-4e91-85ef-08de2b36d5b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTZFZG1aWlpTYlUrNXN6NjBJUFlLNUdBeGxFYUs1emR6SklHL1h1U1ovTlQx?=
 =?utf-8?B?QloxNEt6aVF3Y2lQSUZRZXZGVHJxQVh2MVlZM25BUVVMZmZxK2ZqUW1wZ0Jh?=
 =?utf-8?B?M29pWXVWSHoxTkh5bWovZ0RYV0lxU2xpZVphTVVwQzFuWVdKNllZekRKK24z?=
 =?utf-8?B?RVBYZEMzVmt5OUZRTXNHZVpqamU1OEtuRkg4OEl6NXU0QWNtallRTnFkd21W?=
 =?utf-8?B?S1VtSHlobTRlTllSVXJ6R1VQZHpEVnJid08vYjkzZ0hjWU9WQnVPdEFuQjRv?=
 =?utf-8?B?bHRGNkxXWm5aWmZlRGNTSnJDWE9SejVCOEVQNm44YzRmQnh2STBYbnM3TlZB?=
 =?utf-8?B?ZzhRd0xIL1dUUlZCaWxOMTJuUWVWajRheVQ1N2VrUS9ka0FIR2dWbUZVS1FK?=
 =?utf-8?B?ejFmOVArejEvU1hNS2xVc1BOWlhsWVl3M1Ezb0w5SFYzOXBZWFBPYjh3MlJQ?=
 =?utf-8?B?SnpiaW9udjljWldFRDM4OFgyYTZpRUVoUXBCZEdlK1lzRDdnSldSckt5emZj?=
 =?utf-8?B?aHNpNE9zUkIwdXIvd1M3SUtBRndWaTlJS3BKQkszS1V3S2lzbWprT0Yzd0t5?=
 =?utf-8?B?T3ZGVFlZcm9ScS9tTEJ0OGxmVUVkR3Jjam9MeTFNMUpmTE14NzQ4cmFocmI5?=
 =?utf-8?B?TFAxZ09jWnZITi9taGJBM1Vic2MrN1ZpeSsvVXFNV0UzWHo3S1BsV3UrQkhw?=
 =?utf-8?B?eWZ0T2hpMEVoSzZ0K2MvY1JaZEJYcVhmOHdsZzJYWWZscm8xM24wZzFiSEZR?=
 =?utf-8?B?TGxxNGZMWkJ6YXJlNGhWcFpicjAxcE0wU1hGZG40MVBOeFIya1Fta0hzQzhV?=
 =?utf-8?B?T1U2aDQ1SmVkSXFQeUxZeGswRTRpSG0zQzUwSk9uOHA4Mkl3bGlJZXgwZGM4?=
 =?utf-8?B?Vkc1UW0zbm1XYldxa0dzc1gxdDFFTEdEWk1sWEhGZC82ZjRxOHlDTjFVMXF2?=
 =?utf-8?B?WCtGUTJkeEhxbWpjcEtZejViYjZhQzc3Mi9wMUwxenVHMVNmVWRpY2x2N1Vt?=
 =?utf-8?B?amFjd0ViVHhsd3Y2MTJ6dXRiY3YyN1lKdHdFSTNHeXczYnJ1RjNaUGtlT2ZQ?=
 =?utf-8?B?b09SOUk3dFc1em1SM1AxMDBnT0NVR2UzV3h0R2h4UVNlR3IvR2lqT0pHSTZH?=
 =?utf-8?B?ZEQ0YkdJcU1Pd0xNU3hXbElWcmRROWd6d0Vhc1kzRHJuZUlvMC8vMGd0bUNK?=
 =?utf-8?B?dzhvQnQ2bCtId01CVW11bnhpYVZLZERkQVkrM0Z3ekZOeTMxMDV6OFp4bFRk?=
 =?utf-8?B?ZFlQNHZ4K3M0VjVjUWlxb3BpNGZaQUJjRktnZnh0cGU3aWtna2tUZks2T0Qr?=
 =?utf-8?B?L2VPQlI4ZnJOajVPdElFN0UvTGlzaXdnWVZUZTMzNGtzcnJVVGc3QnRUdU9y?=
 =?utf-8?B?WENwSFJqMnVBZjFRa1JyNFIrOWw0V0hjU1gyYndmNDFMeTZQVDZud3E5RW9v?=
 =?utf-8?B?cmovKy9VL3p6Tm9kMURqcnNoN3dNK2FzdWhtUmpiNmhPTm9rdmtSZFVuVHdx?=
 =?utf-8?B?Q3RwcXpBbmtUWFV5RHI5WEtJMG9hbUx2OTF0MUNrQ1VzNlpFTHJrbSsrSW5y?=
 =?utf-8?B?ZktwYWZHdm5ncTd3Q040bnFKczduQTFLVXJ3T09VaWVCUlh3Slk0Mkd5Q2gr?=
 =?utf-8?B?QUp6bnAyWElKK2JyYmNMc0ZmSHlUUkJjclJLcmtLVzltbEpyODZIdzVnNHZF?=
 =?utf-8?B?MmNsYXlGbnMyeHBaOTZHVjAxUEx5anFzUStZMkJ2SElKNWdiSU9TMTNadUlL?=
 =?utf-8?B?Q0twM1JaSExrK3dldHpNaytEWVhLRGxTQllUNmZuenA1TFdYc3NQRXVKcUMy?=
 =?utf-8?B?L09oYndPcGpWbHdyNUpkUVozTXVkdUNDQkt5SnNJb1ZvTUlxdzZuSTFjVXlZ?=
 =?utf-8?B?WVowTkd1M1B3b3M1WlBMSDM3d2U5QnE4OG1qUU42WWIybG5mbXpiOGI1Z3hK?=
 =?utf-8?B?KzhsWlJaQnp4R2dQSHBhaC9tMmhCNzg1ejBrL0pnemxVRFpydVQ5MEd0U2RY?=
 =?utf-8?B?VHdlblpPUXFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJreHVJVXA2dlR2SUJ0MmtRM1Z6MTIyc2Y2WUNOMjVkVGY5NkRDNElXUmg5?=
 =?utf-8?B?T2NzUEhrYldzVHlsZE1wdFRnSnR2cHpqalhoUGxiZGVadTM2OGM2OEVFaUFa?=
 =?utf-8?B?NDhZMER3TkNOeWZ0cG9PTkltOE5xU1ByT1JpL2NjSi9UeFZ1MEpMZ3krM1FM?=
 =?utf-8?B?UGJvR2w5Y3Y1d3N3bEx4NHVwSXpWSFIvSUNaekIrSTJwZmpVL1pLNndmb3BB?=
 =?utf-8?B?UGJyNWJZREVSL3dLNG9hUjJXNHJoSzdGbk0vM281U2c2TDVwNFlpdlRyaXBX?=
 =?utf-8?B?L3BxZ1Z5ODdOS2F5OEtIQVlGZGlqT1VIRVBhaUF1QnNwalF2RGNtSVF6Z01Q?=
 =?utf-8?B?S3dkdjVkVHZ4NHRCUXRTdVladkFqd25Ka3hhRGgvYU10dFZacDZZV0YrTHZL?=
 =?utf-8?B?MjMreUlrZ1Q2Y0xGUDJySWExVk0vQkpBdkM2RU9BYkhtR0cxaGEzSlY0ei9a?=
 =?utf-8?B?TzAyKzR3UlZYOW9velVkVC9FOE51S0JOaCtuQ0ZQWHdmUklVOFJ2aVJKQUZo?=
 =?utf-8?B?LzVCNTV2UjQxd2Ivc2NFZmRTVnV0NnZmNW9JVkZmeU1VemsrcEZWWlpaOXdN?=
 =?utf-8?B?VGhwOUxmWU5XMFBoc1g3RlF0MVRtT2pvRklyWER4cEIrYWNORHorK1lodWVi?=
 =?utf-8?B?cGpOUEpmYkIyNXBXMWZreG5kbmNLOWltd0MvL0grc1VIOHhtRit2NCszVTdw?=
 =?utf-8?B?dVA1Ni9tZmZlbCtzZS8ycEtadk9oSENsQjUyQVpJM3hiNWVtTTlSbFpXOVNk?=
 =?utf-8?B?NC9mNDFBY2FWMmVnQzJuL3FqaFFyT042QVlQQnZPeE1ma1JPRjQ0ZGZ0RTFD?=
 =?utf-8?B?MG5EYzJBUDRSL2ppRjMzTVoxR3VIZEtSRkNlZG5vUC8wVE5YZ1dFZTlUZmZY?=
 =?utf-8?B?NFAzTDVJTWdPRFd2Ky9ITmswNThQTGVpTUtvRC9xNUlMNkZnZ05hM0FjK01C?=
 =?utf-8?B?SitHLzFNN2FUdUxIaWpwUkJGVWtCeHJhTzVyS21qOU5IdVNjdXJpalo3Zm93?=
 =?utf-8?B?UjF0WVBVb0cyOVlscEJLc1ErQVB5eWo1SXBRS1JPLzdLbmU2UzA1SkNINmVL?=
 =?utf-8?B?T0xZcFN3MDFsa2EwOGpmaW5tT1ArUmxNb3pJSWdoVitCMXRlRG5UZ2RRZTNq?=
 =?utf-8?B?U3J4OGNhd2oyeGpEVXRTS3RBN0VEUXJ6SWM0anFtRTJheVdIM3IvTGVMVDhz?=
 =?utf-8?B?ZVk0bFNWZ3NRMVlZekJnTXFPNkRvT3pJTFczVVpia1FYSUVtRWFXcXFDUzA2?=
 =?utf-8?B?NkVLa2RQc1JkY2lGRHpRR0REd1NWZ1Y2ZHd2YXpnOUFnMW84RGZkaDhRMDh1?=
 =?utf-8?B?Uno5SUVyRDlUVFkrSW9hM2ZhZmViNUtmSk1nalY3OTVhbE8zdzNoQlo1VE1q?=
 =?utf-8?B?RzRZTmJNTU1qanY4SFBrblRON0p4MnArQm1paWp2TjR1NkNrRjVpSmpZRXZK?=
 =?utf-8?B?OThlK2ZMRnJYemlxQXExY2pHcEJuNzdxNFBseVpXd0wxSEF1VkJoSjEyQllj?=
 =?utf-8?B?cktodnIrWGdRN2k5a0ZCZXdRVVpvOHlXQ09ncmtrM0VJV1RLcDZoSUh1U2w5?=
 =?utf-8?B?STEwMzBhb3NkUEhhWWlEL2UrRHRyMlh6b0k3OGdnc1V1bmxQejlud25wNHRl?=
 =?utf-8?B?KzNpVGxtUk1oL1UxUGJnMVZIdGhhaWVhUGdBOWxhV005UHpPVWd5K3M2UVRs?=
 =?utf-8?B?WldzV3VENzl2MXg1SjNjZDhWREx6OFY3SGtacklBSC9sMmllc29iT1JzeFBa?=
 =?utf-8?B?N2pYbVpGNzE0NEdzMTIxVVRBbzRGQ3VOUVhsRVNMMTRrS3lrNWhtVVZIUDRV?=
 =?utf-8?B?NU1ENGdpeG9yWU1YbWkwa1VFRUF4VnJoNEM5dGpNNStiY240ckVBRXlIN0JR?=
 =?utf-8?B?TVVGVzQ5VzNSQ2IwNG00LzFsRWxWeEJ3VDJhNjA5dm1FVGh2RHJmL2dDRlF4?=
 =?utf-8?B?RDZQQ0JZUWhEc2lzc0NUdEJ2UkEzWUNKWm5UeitIb2VBa0wwc3R6M3lyM3c2?=
 =?utf-8?B?bk9sTDltVUI5MVlHaldiQm5FMytrSVZGbXRhVE15U3d0WnpHanB2c1BJS3Rx?=
 =?utf-8?B?Y3BvU3lORWpYOHI0b3ArVXFtVWl2MXlVOXp0VHl1TUJpbEx6dUo1dEhwczUw?=
 =?utf-8?B?Q0hIdkhnVktCVmZhdFAydFNXMWhhejVCc3RsQ3B5ZFRVdGxTTEU3ci96S3JH?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533a9dee-be5d-4e91-85ef-08de2b36d5b4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 08:52:44.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZ5k3aV+g09Vhww9ScHzvRszLu4YpKRjkOHC+FVqy9NljfGC99j+37n6XPK2hEz6kXWtUzJ/AuN+fj5Bdf8R8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8844
Received-SPF: pass client-ip=40.107.159.56;
 envelope-from=jan.kiszka@siemens.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi all,

via a quick hack, I realized a power-saving optimization for a VM that 
serves sporadic network requests:

diff --git a/net/slirp.c b/net/slirp.c
index 120eef6122..f6b0ddc846 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -40,6 +40,7 @@
 #include "qemu/sockets.h"
 #include <libslirp.h>
 #include "chardev/char-fe.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
@@ -120,6 +121,8 @@ static ssize_t net_slirp_send_packet(const void *pkt, size_t pkt_len,
     uint8_t min_pkt[ETH_ZLEN];
     size_t min_pktsz = sizeof(min_pkt);
 
+    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
+
     if (net_peer_needs_padding(&s->nc)) {
         if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pkt_len)) {
             pkt = min_pkt;

This plus suspend-to-ram inside the VM after some idle time gives a 
nice workload reduction for the host. But it is a hack, just working too 
well to make we wonder if there could be a way to get this modeled also 
without a patch.

Do I rather have to write a proxy service that hooks into the traffic 
targeting the VM and performs the wakeup via QMP? Or is there a chance 
to get something similar to serial [1] also into the network path?

Ideas would be welcome.

TIA!
Jan

[1] https://gitlab.com/qemu-project/qemu/-/commit/9826fd597df59a8bac7beafd192e4baad790c31a

-- 
Siemens AG, Foundational Technologies
Linux Expert Center



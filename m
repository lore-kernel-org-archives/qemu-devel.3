Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0877606A521
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=c5OICtaU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUHmF-0006fV-Dg; Fri, 20 Nov 2026 01:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xUHmD-0006fH-Vg; Fri, 20 Nov 2026 01:07:13 -0500
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xUHmA-00065N-Uv; Fri, 20 Nov 2026 01:07:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZJr+VnClENrTaOCw9j6n6qEZLT7ZsqP8R6iYFGpVMuArc8Qa4Y9YRH+td4H6BByvZ+06/VvulKIcEOMx+jc15VRPUiE9NuFgt5TJYMoeR6NQocl+M4FTFHXQA2S2uY+lSCi8UW1avUbmLQe3ZB1L2Gm+6O0PQizshw8mZWEzPOmmuWiD2FsFgnLG71IQS8+hm9PyymMYg/tpn90I8PUaMZ6j/+9feI9BDOwnuxfZFK7rauZHCDiEtQQgCVM5f1IqaYc3+1NYtVeaVf4fPO79cTHqUgQ6DtYRxNoBrPfmrqEPWLPzQuNM2ELkQKJE6CSzL/fL9tAlIeK67RfkjxyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJr8WCrEsu7pUxD395lM7Oy2OvnWyYQpoa7OjVRlL48=;
 b=XziKtbxq/hPY/Ek/O1jDHvAv5tTSOFVRaAQ92clggYDhQ6McuxVHw4F3QsopCIc/+Yt+8og7cwfVIoSGmjMfjMzqa7F0x+TsyUc3OruYhDSgW2jHUAUutc/1wOMAmiigWtAXaCGnDvh2G2rZd7CivHQYn/dqOBcq5b32GlVr3PVohpGXw3pPL3CqIk866nM2Bh9goa7c86+sDbetq6WmjNfhpn7tkG21TkAF/gEIX3otLooxNPs6I6civzsLpUrr1pmQkjDL0vSpRQnDejOZveLa8Ifn9GLba3YKKRkFC8BMKp2MOeVzKgljAkCRwn989szgXoz/3/0fJk3VgELVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJr8WCrEsu7pUxD395lM7Oy2OvnWyYQpoa7OjVRlL48=;
 b=c5OICtaU4k+VhgUf5xJhEWUjs7111g6Twmf+vxbqYZS8zfoCtM8e/ozX3JLA8MsAzqPY9C1eqL+exI2S/2O1PVdjWWxLpxsUh4MaU1iQt/tXIjnmuEylpZuzM99/w954h3jv8UNVjSw5p0twnqUXjRLW/F5YXbZ8xYoXYEu5zLvkMDdMzC67ux9wCRzdoMF6USgLbskLJWLznOz3zjPnv8Rc2rxbPSzzwhjyqkoKCAadcOLuJFQZfupnksmT1tCONY4FIYNsOwSV8VF+FOCFP/K8G2g1Feyn4Oi45IFns4oTEuzMGYcsDTjLJEPJCg6fjmmZnKktt72lPIWJXMUUyQ==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by PUZPR04MB6557.apcprd04.prod.outlook.com (2603:1096:301:f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 06:07:03 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 06:07:03 +0000
Message-ID: <TYZPR04MB749116F7D4039F3C2E5AFAC2F3782@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Fri, 20 Nov 2026 14:06:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] hw/riscv: allow machines to set 'hpm-counters' for
 riscv-iommu-sys
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20261119082356.1264726-1-daniel.barboza@oss.qualcomm.com>
 <20261119082356.1264726-2-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261119082356.1264726-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <c71a7f88-3243-41d4-b398-b06c1db78ba9@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|PUZPR04MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb69ec1-25e4-49d7-9367-08df46cc7ec6
X-MS-Exchange-SLBlob-MailProps: Om8TgR6f4EDKwbHiBQa7ExePO6wqvFC1aPNPFw7RJdhboyqZJq3NNztwgfJx7HOrb0tXsTQPjPEAChW3lqnjwGEZh2Kila2yGf4CIDUpzKiEzRH84D2+BwxagiDj7LIc6/QE7zhjzXtFirzaBPoojcgxSHJQo7X5ltcmYVWB9gwWk7/VycE/GRBesnwauRY6saNdX651gy5tj1y93eqxPtpxhzoMDdKxxCVpPv/LhNKHjAOAsL9NFQMbBvtaU90JgwUBxg+vUS7YqFY/uPVi1GMiATOuFtPp9j3QDG2e33s1XqHzpE4OPtMhZszt+MTIiBqfxk/oLS8aLfJlzv9rmRvM1z1G5WptkDj1NI+QLcFXPoPzsZKBFrS/XwrBYXK0dcyXU7adhgRvm23Ak46kSD9hXHMM9BVosEdYWYtl9McQgALzb84zZfbVH+O0Bs0se4pnn71utoCzUiS64BjhuC3SijggEgMF6p364jjD+I52NHtY7Z5Uv95ParhdOQ2ZpBWv1tpB/NylZ5QZYrz019c6puQnZCktEcLalu3zHGWkrTQt2vMfw2zTQkJRVPchihxZCwxzCIEOVAwCU2Z6c8Vx95xCyF41qN25oCZye9dAtRbN/YNKU4Gg9GcIFhyXbp0NkO/Lq/T4r32fGx/2oOqk28Ke5UvBvZswkG6OKeGJiFMMhlAqZNCZVk6Jf19crkP1TT7unWikXINJh2P8CEqBNRLQs19kZpV6G5cfMBQB2QIrFhAFlnu0bNx8JJOt9qBCswYeSdyDdklJ8Fi/pBdbRziCmdZWMHenJMAJQuB8ipACpCymVASIKRjklmE4A48antFCsv0M0Y+QUtnh43xuPKgINqOq
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|24121999003|23021999003|22091999003|15080799012|5072599009|6090799003|41001999006|51005399006|25010399006|4140399003|19110799012|8060799015|19101099003|55001999006|440099028|3412199025|10035399007|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0h5NktkMWFlNXAxK240VXBUTFdDbm1temlESTY1N2pLRFZDTSs4dTFOS2li?=
 =?utf-8?B?U0hkaHdGNStpQnBic0RQMFg5dHIrRGRXN1orWFc4cEljQVd6UVFybmdEZUds?=
 =?utf-8?B?SzJmTHJlMjJvZExKVTMwczZ2SGtwVW1DaTczRnRRaW4rNS9BcFVuNEZ3bnY1?=
 =?utf-8?B?WGVpVUttN1VyeGRWblFLbEFvalVIemNvYTU2T0xqSzMxOEk3NDhKL0hlTGN6?=
 =?utf-8?B?WGhQS2ZZUzNzckl1TTVHME1JQW4wY0NQbTNDMytOVmxUR0pTbkcxZVMrd2x2?=
 =?utf-8?B?bFVpTUNZL1dua3k1MW5YbjdkdDIrblppNEV1VkZKWWs4Nitpc0ZISFh3OTFC?=
 =?utf-8?B?TjRueGJMcXR2YWZ4K1p0bzBscDVyUlNTUFQrMW44RlNKeWRPRzFLWDBxb2R2?=
 =?utf-8?B?ckZiV2cxL2p4QWJJa2NmWjNYVTdROS91TUJvaDRXd1dWblE4RFNTaEJqd201?=
 =?utf-8?B?cjJ1ZTNKUjRWNTJmVEQ2NXQ0OXhqcE81aVlpdVlraFUyYzVJVCtvWEgrRVVj?=
 =?utf-8?B?V0ZzVDUvWCtHU1JEL3VpMTJvakplY3J6bDNwMTBsM29QWlBXRlhNVklwR1Jw?=
 =?utf-8?B?ZXRndjFDWWR5UU01dUxOcVhZNWFoT0R3WW1pVHRhL3ZlZkVOZVAzb0kvaERi?=
 =?utf-8?B?YlZsbWtHVDZvNit0VFhTNExFSDM0OUplQ2lKR3FuelZ6Z0t5NjAxWWFxelA0?=
 =?utf-8?B?b0NlS2ZuOGVWbzZlWG9CZjE2amRrTTQwc0RrVmVyc2cvb1NoaFhYQ0R5Y1JF?=
 =?utf-8?B?OFlXa0NrQk5tQmJBMGR5V3FXWGxVQVdwTkdKUzlLRU9VckhEY0NNMTBHbmZC?=
 =?utf-8?B?S2ZnMEtiUEhLQzh6cDkxYXlpRjNsTlRNUUgzRUV2Q1FlYm1yR1A1dFNUcXZs?=
 =?utf-8?B?VHR0VzdGU0daZWRvVVpnT2dSa3JRd05xcGErNlY5Nndyb1pyT0o0cmIxT2l6?=
 =?utf-8?B?U2dXRnJ1ODlyRDRpOHIyVU15WjMzSmFaZFJ6c2NSbVZucW9IaFVQS0FWMmt3?=
 =?utf-8?B?SXViUHV6aXcxSTJXRldzaWRmczdjQzNGV09iMXZPbkRVUW9SQTlrSWZBM1Ja?=
 =?utf-8?B?Ung0MTc5aFc0WUZLMmJXcDFvWVdDMjVDdUZtOHloTDJyUEpMOW5BKzlNaHNI?=
 =?utf-8?B?S3BjMXVIRUJSc3dOZEN3Wndpa2ExdmI5enVxc0ZTVXNGcGhpcWI3b0tEUzBq?=
 =?utf-8?B?L250aG9odFh2NkVwSDNyZXJIdDJWOEtsSzN0SXZPaGRtNWdsaG9YZEV0K3Nx?=
 =?utf-8?B?dnhRcnZIUytJQXp5THNoTjRpWG5oSE9ZdDQ4TjdIOFBRNTl3cHVaOWJHWkR1?=
 =?utf-8?B?aTR3MnNzUXZFY29BN1BNK3lHUmxkOS9BZ1c5eHRmOFhLeFVXNUtPb0xNRWFG?=
 =?utf-8?B?R2krbm5FNEpsOGluR3NrMlZ4OFNwNDVFRk9veGhSVUtYRVdHZzFWdzUvRi9K?=
 =?utf-8?B?RWM0UkRKaDFsdlBjRzRXTkppTDQvWGR2Z2ZFSnNRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUoyYncvRUNoQ01YWWc5OTF4QkNzaTM1dmtpeUYrdVdzN2dINFhMWDhMZHEv?=
 =?utf-8?B?RnlIKzd4UGozaDJIZzJyMDhjY3FwWGswSEJtWVpPUWpQcjFrTWtpWE85Yjcv?=
 =?utf-8?B?YkQ0T1BWS0hoelJUdkpTckpMY0xWV1JLd1ZSVzVGWStiTXFRK3dyRE9yMjI1?=
 =?utf-8?B?TDRkN2ZialZNMytPOG5hVU9LQmNNcjAyNUJQNDc5Znl2NlZvWC9yNlV6eWkz?=
 =?utf-8?B?MWJpdTk4bkhUaCtXM0ZwVlV4T1BDbldWUk9MVGMxNTVjZmt5Yi9jdUZDWjM1?=
 =?utf-8?B?MUozNm5USWZUYjRPWVFweGpqc0p6UmN0SUhSWDBGL2VFQVUwV2RZZFRPYktH?=
 =?utf-8?B?SnFWL3ZUV2xvM05NZnB0QS9RT3Rtd29NMU5WVWxUTy9mN3ZxMVlhWjF5N3NI?=
 =?utf-8?B?ZzNtYVdSVm4zQ0dvVHRTc0ZWMU9waWMzbUVxWEh6Zzc4c05rTW43OVJRSDdv?=
 =?utf-8?B?VXRBTDhCN0hCUmZOWmllL20xbElhZDYzby9CUHVkK2I1NDdyOE1QcjV0YXpq?=
 =?utf-8?B?cGpyd2FzY2F0OGswTmpTdWVsbnZObm5rSGQ1SVp4dkM3aWVFYW1FUTZaak00?=
 =?utf-8?B?TUYyMzFnMU85Z3UvSEdlYnM5NFNWVHhmenVNR2o2L014WEZyaGNPTmlXR3dI?=
 =?utf-8?B?aHpBTFh5SFUzMVYzTlpVc3RsVDg0T0FwMzZGSlFNd2pvc0dkbU0zOHV0TkZa?=
 =?utf-8?B?Yjlnc0lEWTk4MHJ0NHBKL3hNOE96d2ZwVk1sOGtQQUc2RlpOOHhUeEo5UWxL?=
 =?utf-8?B?YnBmTGVuWE5aVXIvMHo3dC81elAwS0F4MFV0RkVBdlpMTUlYSGF1Qk5CUW5T?=
 =?utf-8?B?dlBDMTYvdWFVVzdBVWlHZmdwQUI3elhORFhjREw1RGw4VHk3b3oxeGtMUWxz?=
 =?utf-8?B?NE5haUdKSVFLM2pMWUFTRHkveXozYVdkOWlBZXlSTmI1dVlKb1lUZnlWVk1n?=
 =?utf-8?B?QzRUVDBSVDJOY1M0Q0hkY3ovTmlvekgxajltSVArMmtqcStqKzg3N2ZtQWNr?=
 =?utf-8?B?YzZlckVSaW0vQXg2QUt1Uk13eGd6MmYzdXRPUnlXS3F4NjIrUzA4WTZscWRo?=
 =?utf-8?B?WFdsRys4RmczUEtQWS81YTdNVTJHMTRUTjNRc01NK0h0dTRBRmNvVTVlTU1H?=
 =?utf-8?B?dGlpblFXRWNCdWlkTVk3bmZrTTJUSDBGcmdFb2EyRVRGWlpOYm9DeldHMWsv?=
 =?utf-8?B?R05iNzR4UGpVUXE3OUg2UXg0c3hOSXBYR3JzSlZtWWQrT2tpem96VkZwVUNL?=
 =?utf-8?B?N3ZOUjM4REFGQ3lmTk1MdkJhNVo3dCtNeEd0Y3dqb2lVNkhLVkUwaFA4VHA5?=
 =?utf-8?B?RHhQc2EvY2kvbXpPMXdOczV4cG1SMVhtcnozSmx0bHVicVBBTFRZbW9KRHlR?=
 =?utf-8?B?OGZicGpRcWE5WWl5aUVJdWNLdWRqUWhOZVZrZEk2a3RCbTRzMjlJRm1zMVlC?=
 =?utf-8?B?NDR2MDRFRVJoSGlnd29yK2tmaXVqVk5QTC9CT29haHpxb3g3WVJSZkhaZ2Ny?=
 =?utf-8?B?L0thUHovMjBMSnp5Y1hucngyTzFUYkJqTElLYXpwMG5Tb1B2VEpiK3hwMFo1?=
 =?utf-8?B?SGx4elNVVzVQWEFwd3dQcnhWMDZEbk1BSkJWQmE3YklWTDJtTk1IeUFwSVdz?=
 =?utf-8?B?S2ZuSnI5YmtYbWVHZG9ON1FIQTBVelY5MTZlaG96UG5ZaENQT0tPRUZTcG43?=
 =?utf-8?B?UFoxVHU5NkE2ZU5uUUdnN3FGYURMdmdKVitabCtJL3JtbVF5NWV3QWZEbU5B?=
 =?utf-8?B?SElUOTFpbW9QUG0rVzlTMXFKQndnMGwzQmdISFdXQktjVXJWby9XdTVJL2F6?=
 =?utf-8?B?aUo4V0J5YnhuNjNqRHRlQWlDRDlpd09NWGtXYmxLaFN0WkFoelEzTzJUNG9R?=
 =?utf-8?Q?qyE8HjJ7iCejL?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb69ec1-25e4-49d7-9367-08df46cc7ec6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:07:03.1475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6557
Received-SPF: pass client-ip=2a01:111:f403:d405::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/19/2026 4:23 PM, Daniel Henrique Barboza wrote:
> The riscv server soc requirements [1] dictates in rule "IOM_200" that
> the IOMMU must have at least 4 event counters.  As it stands today we're
> creating an iommu-sys device with RISCV_IOMMU_IOCOUNT_NUM (31) counters.
>
> Following the design of setting just the minimal spec requirements, set
> hpm-counters to 4.  We're doing that by adding a new argument in
> riscv_create_iommu_sys().  In case more IOMMU parameters need to tweaked
> in the device we might consider a different approach, but for now this
> suffices.
>
> The hpm-counters value used in the 'virt' board is default val from
> riscv-iommu, i.e. there's no change in 'virt' board configuration with
> this patch.
>
> Note that the 'Fixes' tag points to the riscv-server-ref initial commit
> because the IOM_200 rule should have been there from the start.  There's
> nothing inherently wrong with the initial commit for
> riscv_create_iommu_sys().
>
> [1] https://docs.riscv.org/reference/server-soc/v1.0/server_soc_requirements.html
>
> Fixes: c2fa4320803b ("hw/riscv: server platform reference machine")
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu-sys.c     | 4 ++++
>   hw/riscv/riscv-iommu.h         | 1 +
>   hw/riscv/server_platform_ref.c | 2 ++
>   hw/riscv/virt.c                | 3 ++-
>   4 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index 258c171efd..3a9e22080a 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -219,6 +219,7 @@ static void riscv_iommu_sys_init(Object *obj)
>   
>   DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
>                                       hwaddr addr, int base_irq,
> +                                    int hpm_counters,
>                                       bool is_32_bit)
>   {
>       DeviceState *iommu_sys = qdev_new(TYPE_RISCV_IOMMU_SYS);
> @@ -237,6 +238,9 @@ DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
>                                is_32_bit ? 34 : 56,
>                                &error_fatal);
>   
> +    object_property_set_int(OBJECT(iommu_sys), "hpm-counters",
> +                            hpm_counters, &error_abort);
> +
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
>   
>       return iommu_sys;
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index 403d10b321..0f755b0992 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -107,6 +107,7 @@ void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
>   void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev);
>   DeviceState *riscv_create_iommu_sys(DeviceState *mmio_irqchip,
>                                       hwaddr addr, int base_irq,
> +                                    int hpm_counters,
>                                       bool is_32_bit);
>   
>   typedef struct RISCVIOMMUContext RISCVIOMMUContext;
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> index 22b3149ee8..fb770cf6fb 100644
> --- a/hw/riscv/server_platform_ref.c
> +++ b/hw/riscv/server_platform_ref.c
> @@ -67,6 +67,7 @@
>   #define SYSCON_POWEROFF                        0x2
>   
>   #define RVSERVER_PLATFORM_BUS_NUM_IRQS         8
> +#define RVSERVER_IOMMU_HPM_COUNTERS            4
>   
>   #define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
>   OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
> @@ -641,6 +642,7 @@ static void rvserver_ref_machine_init(MachineState *machine)
>       }
>   
>       riscv_create_iommu_sys(mmio_irqchip, s->memmap[RVSERVER_IOMMU_SYS].base,
> +                           RVSERVER_IOMMU_HPM_COUNTERS,
>                              IOMMU_SYS_IRQ, false);
>   
>       s->machine_done.notify = rvserver_ref_machine_done;
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index dceb3ff55e..016003d73d 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -962,7 +962,8 @@ static void virt_machine_init(MachineState *machine)
>   
>       if (virt_is_iommu_sys_enabled(s)) {
>           riscv_create_iommu_sys(mmio_irqchip, s->memmap[VIRT_IOMMU_SYS].base,
> -                               IOMMU_SYS_IRQ, riscv_is_32bit(&s->soc[0]));
> +                               IOMMU_SYS_IRQ, RISCV_IOMMU_IOCOUNT_NUM,
> +                               riscv_is_32bit(&s->soc[0]));
>       }
>   
>       s->machine_done.notify = virt_machine_done;


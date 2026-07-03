Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC0CC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVKr-00064e-4x; Fri, 03 Jul 2026 00:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wfVKX-00064I-Jv; Fri, 03 Jul 2026 00:16:47 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wfVKV-0005Fw-9l; Fri, 03 Jul 2026 00:16:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyqN2ko13UjQ0oLWo/lTFXBtyk8qih+xfRUhav5c1jfxfl2i5r3PuExHHmm7WqFKazaSXKH02wzbEy93GAcDw2klD7wMkvMBuZEWs6aftDBymMn5InNSNUMrUM7BiRFHE97E/iJtTG5DGRm9xlWHyYvD2U3j/tucdGG1/Z//xfgX4lO2clpTjUOybeJRmmBctD35vWfXjdMCSMWZCybHi1R2dTvKR2kgrqMvBh3NcZsHwmv1OcIINtkJso/kzql/VNWQOZY1I3OUZvdXYWnn0g4T4mGtGgpatmF/X2G354qVoAVAxavB+3jDxh4+w+xeL6k8FehxaBQkg4mBxcVx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGOJ3MRySKLf88y3ovm8+goUIocp5NdPUacPGb9pqhA=;
 b=xt88zR6u9KSLCRfkDqBs1IM0MCamPoArDnll2zjVkdjlIIh6KIu1QAP6Smn7HkyYBh/xctS3O6I5jJEOaoZ+W+Dxdxg5jeOR4tbkhUzEsb28KJZEFZXzZu+22gsWYMpsM7QM5q83Pbmk4uHAW/gqmyYV/lszEPPptzV2Kwrnki8dC9SQbnFXM/GUhUTLtsmbasQGtwpf4nAebP5TYUnQ2GRP620X/1K8henohwqzudx8oXSxyK0dRyI0m6rtl/NHgdZkBj5e8xtTZeaBibY6jEHrLj4PwuFYWcwXmQr9lW95KKDlrmSSUtdKMAgIP6Gvmvh1Sggjz8SRkXj1X963Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGOJ3MRySKLf88y3ovm8+goUIocp5NdPUacPGb9pqhA=;
 b=ZAy4zwrEegXgTiACOf0k9otqd+cpAFGLMhcg3Yam37XeJSAgCBKp/EoJJlpKfCTCxMX/wcBFA9oCG+TQDNu5bIovDShZIEhU5MgU9kTK33fm5apM+f/pxngqRtmj5IBzcyDmigLpZUCU/lVZ8P5QW2JIGPrqIfMeW2T1DPsPMqMcKt+lnV9x7JNOKtwkaeWSJUOxccMs4+5UZiBhAj5oWWu4PX++TsqD9PWn5s8EizqI9YhbNUpZLnqJSp0UnwlqB8/oAcdLkzvpokv6BUquj9kdeyzIDuVnmYmFVc2ygPX355JUd0cs+s9mGLKP9ALxOikLF76TYwHWwP2W1JMzww==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by OSQPR04MB8090.apcprd04.prod.outlook.com (2603:1096:604:299::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 04:16:36 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 04:16:36 +0000
Message-ID: <SE3PR04MB8922853878C80510DAA2D910F3F42@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Fri, 3 Jul 2026 12:16:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] hw/riscv/riscv-iommu.c: check for misaligned
 IOHGATP_PPN
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702203616.1795588-1-daniel.barboza@oss.qualcomm.com>
 <20260702203616.1795588-2-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260702203616.1795588-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <243e00fd-5b64-4262-be54-93aad97668f1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|OSQPR04MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: d10545f3-2bbf-43fe-7f4c-08ded8b9df7f
X-MS-Exchange-SLBlob-MailProps: Z9TzpHVL8qo66q/I2BQDGqmFnMul9MvF102JZ5aLAxiMJdSjUXR0a4Ug6BvGlSc2pCNT7TTXdoeNaDVSWdO6OlZq/UKv1EsATHefMc5+XFCC897To4Rt42zds3Moyqd/pQXyfp+Ko+j+PSMEjMSuDyWIFp+AID2hMnjtJITXkS7YsPV3VFmc01dviuqoLcazz2NSiQHraCI6PWi1UNCxquiFIer3Ch+SHNBevcS8HuU62vGggXKLNaQn+k7Ihw+f9rJubJELpmL8cBUK/FUrU0fXVXX+cEyktNCaw4NCyX35AfqUj/+s5TvDci+Maz/BTelRciIAJ0QAOEz62X6fdG6+jJT30qgKU/mFkqoJZ9UX/CtKnpBNKJbr/FAhsDNFj4I4Y4Q8OabdB52tLRzsHti/F5+awHZiODXSiJf11s8Xz6G7mpjhq7PPSb1PLjpi0Fb1guM7pQS42oHsC8KwJT3k1K/GLxgvvW+PmF2qkEyLHsS0hhQ2Er/43ANCCzc+vcJxMSAXOXM2I+NfqRmBn7U+1y6Y/QIF4M7ovhaUy4gNH29AMbAiKccl2x4IbUhylwopztRd1vHpz6aKlrB5rPisTiciggcIYGe6CBcf0/SHKG3Ej7TEk69OKsDH9BLVWTghPGv1BvE8YKUrRK3jy4otVNWeRiqGF03UFOKzu5dCrz+k9Ghyy1hh8NHW2rhBEAZdqNaw0i/sLDLeVmwvls5mfNFqy1a3tG16tVe541YKivojcDBCrEGU9f6sWuvEtIBPDEl0JtyxbEpC0zGKJUf6DJXNGWE0iTfS1br1Vdz9PaOZ5Li1L00onU3JNJATPuOXsMClNVulgZRWT2jgfF64HAwKfu/mCHyZtZWtZj1E7GZYabpuUQ==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|55001999006|12121999013|16041099003|5072599009|25010399006|4140399003|19101099003|22091999003|24121999003|6090799003|8060799015|19110799012|15080799012|23021999003|41001999006|440099028|4302099013|3412199025|40105399003|53005399003|10035399007|26121999007|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHVna245TVdnekc2Yi9IQnd6S2VMRU8rVlVyaUs1Um1TbFBhWk5hVEs1Z2FD?=
 =?utf-8?B?RGFKWTE1UGpwYVRnc1RVK1M5VVNOc3FMdkxTcFVvSjFNeC9GZytvQzdFcFdj?=
 =?utf-8?B?TDVTalNHYWY3RzRTZXBZNVFaaHRTRXF1V2tQczliUzUvc04vSkVxVVVLRFE4?=
 =?utf-8?B?VVNUbjNFTm9XZFVSRkV5UFo4VmxZUDAzWU5jVm1qUkM5NWM1dW9ZS2dEOXha?=
 =?utf-8?B?eHE3RC9TZVRobWxpNmk1amgxNDI3dTF0aHFXSmtEMytGRE9zU0tieXhRZGh0?=
 =?utf-8?B?QUlBZ1FteGFOb3JoWTJkZHhjbUhKandtUi84ZGNhaEErNXFrUk5JSkkxay82?=
 =?utf-8?B?cHpxMjRnVlBqZFBZRDV1QnZ6SWRnZzBHdzJQMEdhK3NXWkhMZy81QmNKOVV3?=
 =?utf-8?B?emhSZFAzTm82MjhyZWx3QU9kTHYzN1BrWUUwTVovb1AwV3VzVW5CTzc4R1dN?=
 =?utf-8?B?OU1sK2xIUTB5U29VRnh1QVVRWjBxakxhTk80TDlydHBWTFFDSW1MVXc1T25r?=
 =?utf-8?B?OGlVK3JHdno3aFJwcTBpRDk0MzVYcjM1WTJMTTNoM2VDOGJCMWFhKytreXdv?=
 =?utf-8?B?TnNxRWtKY3hNM1dsL2Qybk1EeXN1clBrSWIvTVpiU1dGRG1sbDU1NytxdVVm?=
 =?utf-8?B?SkJUTXRvdFNha3B1eG1WaXNiWVJBUFFmaGZreXV1b3hPT2dMS0xXQloyRTYr?=
 =?utf-8?B?UGtJT1lYL0pYc0xSalBkeTc0NEdJS2FrZEo3ZERldjlSaDI0QWlkUUdXQXNF?=
 =?utf-8?B?Nm1LVnZySUFnQncxVlpIU3kxSThHQTRLaUo0TzlLYjJrWnoxUGxyMmJJL0RV?=
 =?utf-8?B?Y0UzcDFMS2FNNitFREN4YVlMbnUycDFhZzZBVGd5Unc5a0JRZWZ1N3diREx6?=
 =?utf-8?B?U0hNOWdjbE8rYjRocUdBb3VwWEttK21rWkN0bEhSM1l2WWdKdlJON3JLWFpn?=
 =?utf-8?B?TktNQ1Y2Tm9rZE9kSDRpNWE0M29hd0kwUmkxcHJCbjJZMlY1L29qZ090bHll?=
 =?utf-8?B?SnhhVFRoYTZCVVYzWWljcVoyYS9SOE9pVXZLa1gvY0JibWl3Ny9QSFpObitD?=
 =?utf-8?B?bDc2bGU1TnY2SWtLakRUTnNDZitTdWJLdkt3VWxlR0V3Z3VYS0dCTUYyMFQr?=
 =?utf-8?B?V3BHV0tXNk5wazJzTzhkNWVHUW12LzhVOExvQ0ZsUVVzYnVrU3ArK0pMbldr?=
 =?utf-8?B?a3Raam5ST05ES01ubmlRRUU0SGFvK0FEc29ETU9iWUFWNDl2SGFRdFdiUU9N?=
 =?utf-8?B?azU0K2ViTzh5WGdCTkRVaERrcExqT0JTNTVvZGQzZzJpaEl4cmtlanFBWllu?=
 =?utf-8?B?dk1ndk9XNGc0V1VGT3E5akZvWTVKa2pBWHpwNnl5YXVKcHVFM2lCcndpOTVj?=
 =?utf-8?B?Myt6SSt6OUlGdHNsQXdmSnJObEF6U28zVWtQa2pURDU3dXpDbUJlWVljelk3?=
 =?utf-8?B?Q3poRzE5RHd1UHQwcjQ0WlpOWHdaKzFsUjVsbGczcmhlRGdWUFc2S291cjdj?=
 =?utf-8?B?R0JtKzBBeFlXUURuWEF3d3diWm1TR25ndWd3SWFQNGlIMEJkSW5DS2hRcmpR?=
 =?utf-8?B?RGFhRTZtRTFURi8rcjdKMzhVUnF1SzRXTEllOXlXV2RIYjBLRW9sS1FDL1VL?=
 =?utf-8?B?a1gzZUxIbjNiYnVnNldzWjVweVN3MVh4d2Vldlk3QW8vb2REZlRLNXhKOHVK?=
 =?utf-8?B?ZzBGWWZ5TThDd3JYT2RWTUVidFpmelV2VjhIYzZpOG92UytpUlZEQzVhQUYy?=
 =?utf-8?Q?nnxSQp/595K3nhMDas=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWd2eGFwVzRKQnJXYmN2cGxRcHNWQ0pPbmJVcE9YMUxyTjJVakxQS01BSm1G?=
 =?utf-8?B?VjhZdzdRN2R4NVBXeWFoRlNTRkk4UVZUeENFSjNmVGtKbjVLZFBhRzZzbm9u?=
 =?utf-8?B?T3JJRlBtcmptd1NYV3I4R2w0WHVncVlOdUVNT01kakZBMldRK1VIM1lJVVpG?=
 =?utf-8?B?WU9ncGJ1WVpSbm1WMDBKS3ptT2pleUw0eklIMGxmTnJkY0g2QXVBVW5WUXUx?=
 =?utf-8?B?VEVNelFsQXU5ekhKdFZEZ3JqM05TazFQZTlLZkpTek9lcTZrTFVaKzFsQWtl?=
 =?utf-8?B?ZFhQVDlXZDgzRVlMYzVwRmxYUjU1T2lZa1FaVi9wV0wyUTZkVEttOHNOSksz?=
 =?utf-8?B?a3ordTlBSjNqQjBraXM5UkFmNUVKTlM0cU9lYWxNSWxDb1Nya0kwMzZMYVVo?=
 =?utf-8?B?WWluRmRDMGNNT1NGWmR4WTlTaWpGak5XWTBHSi90eHRDVklnbWFpZkhjTDAy?=
 =?utf-8?B?S04wSk4xT2owa0NBbGtIc0dBSEcrenFhczlqZXpzRkhJVThnVS92dXBVeHh0?=
 =?utf-8?B?Tis3KzhvTDM1dTNrUm5PS05VZ1hKU0dVcjR3Um9PVGo4bHF6MWtnakkra2tl?=
 =?utf-8?B?MTVORWlGUWNCd3UwUDJxZzRYL3pPbm9WelRIa2JpZGk2SU9yTXpwenllOUdo?=
 =?utf-8?B?OTR2OXRENFF2cytGUTFLa2xic0kxSHU1NnllQ2hOdDNQeXBwSUF1Y2U4ODF3?=
 =?utf-8?B?Qjk0cXpib1M5R2xNTVdqQkdHcUtMNGxOc3pyZU10WnRKeUJYeWdJa3Rvc2RL?=
 =?utf-8?B?RHB5ZFBZTWQzUklXM205S2xBNDJraHRjcXlza1ZQWkhkQUhlZnpwVDBpbzAy?=
 =?utf-8?B?WHRYVUZwMWFaTm9XWUZmRXdjcFNYSU1FN1VTNU9kWFNheitZL2dkTXVFQURS?=
 =?utf-8?B?ZG5mNmZtWDVxY0p2WGNGRUFPYlBFcU9DZDZsVlg1aUhUZTg4TG5VWkZiQk5H?=
 =?utf-8?B?WjJhRUpkejR6QStid1h0Um9ZMlBTVGxaQzBKbzFQaVg5T2c0alN3czRmbEdU?=
 =?utf-8?B?bW5mSTFBZ0luZ3Q5UDdXbDhNTHJUV1lhTkRtUStqMVg5cDFuSUpFaGZ6d05y?=
 =?utf-8?B?NURBQUN3M0d0WlpOL3hyYU5VdGN6MDRncDZoV1V6OS9IanIwb3R2ZVkzTldv?=
 =?utf-8?B?RDVwdzRDeFVoenpBMm8wUitXUmY1TGIzSUVpbEZlVXNQL1hIRWwzVStSMUZU?=
 =?utf-8?B?QVoxVGhPVXRjM1JscDB6Y1o3ZzFMbGlNTUhXWDJiTVR2aFhOL1F5SW1mU29s?=
 =?utf-8?B?dG0zeWxrR2d5QUxmRndzWW5tcTB1T044UndtbE94UkhYZmhWZjBiV05ta2Qv?=
 =?utf-8?B?a1B5VmVmRzZCeDhZMW1oMlIvM05BMFBJbi9NdGJEQWZtNWZaMlRFaStWRjZ2?=
 =?utf-8?B?aWRMTStvTVBNcFRoSjB0QmtpSFhncGVraGgwcTFQSmNPdnlNRkJvMWRRU1JT?=
 =?utf-8?B?V09XcmRUNk5jRkVBYXNhNGdaL3dYME44bUtuU2hrQWdmanA1eEhBQVhYalVm?=
 =?utf-8?B?NlBrejkzdlU0SyttVnV3VlFMS0h2WlllaENUdWkrUmwxTzcyQUJqQ29wK1Qz?=
 =?utf-8?B?cmlBRzNqOTdrYlhzTDZnaFF1RlpvNjc2UzhxZ2p1S1ZnZDQ4Uk1oMXNlSHFX?=
 =?utf-8?B?TjNud3dIVzVvQjlMU04wOHNXN241L0RSSkNIbmhkc3ZsSUxhM2QrRjlLWGhM?=
 =?utf-8?B?RHFyRGZYbURHYUZIYVBmVG1TU0NLYU50bVNIS1VhdVRQK0YrRFBMaHo5dDgr?=
 =?utf-8?B?L0RENDdVT2pUSDhQRDlmU0VyR0hjZ013OUc0WWRHREd4b0xBcEdBWjlJMDBR?=
 =?utf-8?B?U0JyTkpudGY5TGxWLzhqL1JBMWNXMjNOcGJNSmVKUTlNTEd6NXlNSFJwKyty?=
 =?utf-8?Q?OqjBFgqlEzxQl?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d10545f3-2bbf-43fe-7f4c-08ded8b9df7f
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:16:36.7315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB8090
Received-SPF: pass client-ip=2a01:111:f403:d405::2;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 7/3/2026 4:36 AM, Daniel Henrique Barboza wrote:
> We must check if IOHGATP_PPN is 16kb aligned for non-bare GATP modes.
>
> Fixes: 69a9ae4836 ("hw/riscv/riscv-iommu: add ATS support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3550
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 974042d017..ad8e108a23 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -813,6 +813,21 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
>           return false;
>       }
>   
> +    if (gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
> +        uint64_t iohgatp_ppn = get_field(ctx->gatp,
> +                                         RISCV_IOMMU_DC_IOHGATP_PPN);
> +
> +        /*
> +         * One of the conditions for a misconfigured DDT entry
> +         * according to the riscv-spec: "DC.iohgatp.MODE is not
> +         * Bare and the root page table (address) determined by
> +         * DC.iohgatp.PPN is not aligned to a 16-KiB boundary."
> +         */
> +        if (PPN_PHYS(iohgatp_ppn) & ((1ULL << 14) - 1)) {
> +            return false;
> +        }
> +    }
> +
>       fsc_mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
>   
>       if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {


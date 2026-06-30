Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1351C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weT3Q-0006mv-Pd; Tue, 30 Jun 2026 03:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1weT3O-0006md-Tq; Tue, 30 Jun 2026 03:38:46 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1weT3N-00036V-5K; Tue, 30 Jun 2026 03:38:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCc+9ZmNT7TlDMsqPwue6LI/4gH/YXptLgw4dVP90SFJ83mysdf4xHJ7LtkzggEEV4GRwW30XNO8aqXpEK0fqKLLyel9vwZFWAH+JgXwd4TidPhClpojBYKk1r3WpBcmT8ubD1kpHE6RdV3K3Y5rfpMH32xp1/tu9Xg1PeQw3Ud7P67cgYrcwIa5u7ejzZJMhTzyUzwJAJVc0GeiS1aYCx+pu5Uv6XQBaw8DtD6mAxYvADRlNx+eA5I0elvXxbKzUcWsoF1mcxGALnwKIRNz2SkzDbZ0NfyfIHQDs9gIG7RIFMCnwikL3fBSVXaGfWRBi+QLVpbfD7LPDB3KS/6+Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxuw4iqoNVdgmojSZdV8A3eHAlvf+URxQPaHj7/pndk=;
 b=Ok+0x1+1wxteBSMAfMl+eXyDvk52uxS8aza6kNubHNa7Oxro905r/JLMuP87hM5zy70l2BoqpqnrR7q3cnFb+w+dLN5rr1cS15BVCcFqrSqbzzCtQoVVBvTcMMupUghj82v8ppFTppdynA004nM3+FgLCVzOxs7KpCq2weadH1L3M9MxBiO5qT7JAJVunQG29KFznU1M2PCWpd1LOcPCLRhPD9SfUpoCUz9xM6O6mKfK6u9ScrbwvzD9gv+6MaJJnVIyaMPAn29cvHD9dU62c+diUfJDJY8gbw+05ZV+PIyCmg5qx1E8EfikyIYPioupi/I56qdRBS6fKb9BJCmsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxuw4iqoNVdgmojSZdV8A3eHAlvf+URxQPaHj7/pndk=;
 b=HuI50xJj5CS/WP4UBASFlW7ANVVON9LGhNQfSPJfdAOSn/RhHNfCsrkyuFeOCDAQn4QyMQpPYSaPD2hmpR250jcXkV5XSSoPrutKRIa5iS+jQBSCUc2og5Hfo9X3Lh+jHv6nvhcFPNXZykFUszjmYso74taUgTHO/JuqOpBh3qKxvhf8dTVvkDNS5wYcT0So9DcyoJOJ7gYhtRx+vrzuqiBhYSTD5AOMV2c7kCe3Fhl5u5T0I0IvEOiushOl7qKZ6trBUGw5/gRI6iJVNLPf2uD03i9gQ5wNkxTSbfnXjskx7s5jQLMg3FBHD8IJld2NexmCgKioVR1OE2XxkRkx9g==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SEZPR04MB6574.apcprd04.prod.outlook.com (2603:1096:101:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:38:34 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:38:34 +0000
Message-ID: <SE3PR04MB892266394575EA5C04C8FBE8F3F72@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Tue, 30 Jun 2026 15:38:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv
 access
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Tao Tang <tangtao1634@phytium.com.cn>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260629121334.567587-1-daniel.barboza@oss.qualcomm.com>
 <20260629121334.567587-3-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260629121334.567587-3-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR06CA0021.apcprd06.prod.outlook.com
 (2603:1096:990:77::9) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <150c1f19-0993-4ddf-8140-f6001aa599ef@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SEZPR04MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: e571c40c-02ac-4631-d4b3-08ded67a96a3
X-MS-Exchange-SLBlob-MailProps: V85gaVfRD4/uZtbPKQiHMaRLDxOOyjp2gALjs8RoCTPhHn/Kzqm3vKyhmWBLTnHiTVdbQv6hgDs1Z/2LpyYar2Z+KKMTo2eTcTgTQxzzTLHQbfAGbW/0H2Q810tgiU/wPbpE2a/u6Dz35mxm2cZvz2XTdbyBJ4k5PYiI8FL/GoA2W8gCqZE695AzzgDdXj/D/MZgx3QaeNC2BHg6B/OzGx5czGykpXpOEjq897VwMA9uXyga4XCh0ZbzFA8PUutBN4viit97/DG7vbsBGraXBo5uiktXI9xuzSglvNpNXz4EGuEhdiSjsFwPXkQA2kDaigUCB6zp1LzlMGvEFSymU50G4wEY1F/RdkP7CGjRZvEYTK4J7vp5IKp9hOBv457qRF9fhOJFnFPj/1n4S9/wCCmYho3/cccbE5YyzFvC6cU5dSSIBS8x/HvRBwc8Q6U9fpRRoZE9LMkKGsIwXENr3ekOHWs2XO1wG7CEZFuNivtO/ik5akXErMJ58g5oIfTlP8F65CF6gMGEvAFrJsnMXrNdc2RD6z7FwP7RQZQfOobRolFaawS2OajECSoVQ2uBM0AEZdtU+sPBNokCoSW67wfJGklo1nr3HZu7jgQ/zODZPbZRznZwNgcC18QhHJAnjZp/PI6TZbOiVkjWLZ2wGkEo4DCz6f2Rd43JgEGgvd01Uqp3nKPo2oVg5lUs+55hKl9Pgk2aoslb8Rc2RkOxs2p1q0bpaMpA2HgtdKu5jR2CxuxQ5QvHaNen0dxQ09yeM6/9SXzoGUPd8joycKSX71wxwRIZc+YZHemPQjTEUoP6TzyJP5itiY4rmWPi+pb3pe6/HTgO7VDEjATUcD4PQg==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|25010399006|4140399003|19110799012|8060799015|41001999006|5072599009|55001999006|51005399006|23021999003|15080799012|19101099003|4302099013|3412199025|440099028|10035399007|1602099012|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmZiZTdHVGl4dENFdUdiOVhFaXhsT1NlMWphZ1h6VDR5cXFjdFhaM1FIRmN2?=
 =?utf-8?B?dDhYU25mTEpMaG4rSkhGMjVMdnBMZmJSUmFveHhwNjhsSVVsNmFXbmduT3ds?=
 =?utf-8?B?NVRUcW1sb2dWRTlFbzZxSUpDOGgzMVBUYUdNZmpUMkxnd3MrVHlnc3ZKZ09E?=
 =?utf-8?B?M2RZVWlxcis5L2R5M2l6a1FnT2d4elFRU3pTc3p5RTJlTmhqcjhTc2IvNGha?=
 =?utf-8?B?OGF5UkNBNlVPUHJUbWpzaUtvTVRBWlJOQnhBL2pyY3VJeXZZMmFHbEVNYjh0?=
 =?utf-8?B?Qm1pNUFrU280THhoV1JyK1Rhd1NCODFodW5sSEVOcjM2V1RDclh2V21Qa2NZ?=
 =?utf-8?B?QkkvQ3JzRmp2eEZsaytHSUlnMVl6bmlEUEFBZzVtelIwTUNxenF5MlV3bUI1?=
 =?utf-8?B?TjVZQVpPU1RFRnpMVUh5andBYm9Qdi9IZG84L0FBNjRCMjVmdDBuS3dUbTdX?=
 =?utf-8?B?dHVNQys2Z1pDVWVsby9pUU1ld2duWlNORVZWWFgwR3ViYzhjbER0RlhPVkxa?=
 =?utf-8?B?dFo3djlxWmk4VE94Z2xHdHpJZkorREV2dGNER0VQZE1JRWRDa2hDRk5ZUk1l?=
 =?utf-8?B?dWRPcVNYNmN4VW95TmNHZGdaRHpIN2FEelQ1MWE4NVRtNzZOTld3Y3JBeEdZ?=
 =?utf-8?B?MkRzVTNyVHp0N3NLQmpucXlpeDZjNHNZditPWWFLMzB0aThHN2VCTlY5RjMr?=
 =?utf-8?B?NkQ5SzNoZk5kbHgzSEU2YmFYWkU4alp1aWxWVjJqNlV5eERKTnorQ0R2Y2Nk?=
 =?utf-8?B?dUc2ankzakF4bjFwZW5EUldVRkRrcU1ZbWVXcW1GUUhDZC9MUHFadHNKU21D?=
 =?utf-8?B?cmI3RER0bjU5dkVxTW9VOTREb3pmeXhXa0dWS1A4QUtjSjNNdWtvMFNSSmRV?=
 =?utf-8?B?TUwreTJZMzM2Ujh3QmkzZUZvVUVPbW1OTlZyUmxIQW1wRGhUeTg3endBbFBo?=
 =?utf-8?B?ODNMWXIyV1VYQjhCU2s3bjdFalpYSzdPZmtQQzdRelVHdElkTGtmYmNzQlE2?=
 =?utf-8?B?Z281eWhjSWt1bklzVm5RVFVLa2pUL1huTU9HUGd6WEsyZTRQODErQzIyaC9Y?=
 =?utf-8?B?dGxUdURxMjhyc0Q0NjZPY1NLamY1MG45KzdIZjlmWEFDV1NFNEJubkhNcTdH?=
 =?utf-8?B?ZVBtdk5OT2xDQXQ1T2s3Qng1MERIaCsxTTdTMkFQbEZqYjBUejhHMEl0a3B0?=
 =?utf-8?B?S3g1VmpMaGE1WXF6WG56cWQvbTdRcGJxWG95RkhUSFZSSEFiNTB1VXVDRkhs?=
 =?utf-8?B?TGJtZUV4RjVaSGowbkRxZ3ZSOGhUZit5NUFUbmlpMU40dFJKeXJDMG5kSytn?=
 =?utf-8?B?RGNpYkZ5aHlVb2NzUHFuandLcDE3cGUvK2t4dmlUQXg3eC93T25WK0pReTBP?=
 =?utf-8?B?RStYSXU4dytIYTVGYWtLZENVcTBYYkJZd2QxRitPbm9mNmRZb1RRblFrb1Rh?=
 =?utf-8?B?VXB0TTg5VktKYU1yWWVsYzFsTi9UV2xnNkRMQzZ4RU1hcUp3MVhHL21NdFZI?=
 =?utf-8?Q?KoNrVpv6RWmJWLR4P+gTjZhyFN5?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkFyeXNYbm1wWFo3QW83bUQwMDNidlI0VzBySThqdXhncGMzLzlXU2dvajdX?=
 =?utf-8?B?RzhBUndvNVZKeUVTNDZicFBvL3RZVmVLOXZ5eVNQcmdlU09PQSs1M0w1eXFk?=
 =?utf-8?B?cnozakxFZjBUeTZ3S1dOTFlPSGFnTlI5VFRUeDdZRk55L0h3VkhmVFEzSlZi?=
 =?utf-8?B?SUpHVE1ZSmwxS2drMUlCUDBCWlNlM3k5bGlxTVhzTDUvLzh5ODR6V3BtN2FY?=
 =?utf-8?B?dUozNXJ2ZHlyd2Q4c25MTjNBd2ptSHNBNW00aXk0MkpJTjl2NGszOFlLeGd1?=
 =?utf-8?B?NDNuQUh3eTk2R3V2aXJ5VHlCQ3RYWFNPMkFPUmR0MWJrRE1IVFNHTENRaVFY?=
 =?utf-8?B?UVJEeU1rZ1pjNWVkYkJYSDlydnlEUkpmTFlWR3E4MGdUcHA5NGVaeGtTYWFW?=
 =?utf-8?B?eVhtZGYva3lqV2czM2tISjZNU0pmZU5xOG1lK2UrTlpQRlJrZGJpSThSUlUy?=
 =?utf-8?B?Q2M4L2lFRDJlZzA1QVZOZUNvblZHaWMyRzd0Rkh0YVZSelcvNXFQRDREV0hN?=
 =?utf-8?B?TXZ4S0FVTDhxcHZUT2x3eGFRc0h1M2J0TlFYQlNHS1VCVkFWMGx6RENkNStB?=
 =?utf-8?B?MUFrMlBEOHRuSWFlQWd6Q3lWSVlFd0w5S1NXalFMNEhCMzROY2pXRDdHUFZo?=
 =?utf-8?B?YXhId0IwVzVBKzRobStpZ2tvRmFaYUdHRnYxN01CVVhwa2J6dlF5QkxhR0hK?=
 =?utf-8?B?clMwSjRram9kQkNramxJQklTd1dwWUtYU0ZKVUlrY1UxMGcyM3NKYkovd2k1?=
 =?utf-8?B?M015dmk2TDBMYVZwemJidFF1RjB4VW8vV21TM3BYbTNjTWNUWmdvNFFUdGo3?=
 =?utf-8?B?a1FCM3E4VzE5czVOZ3Y4enZrZ2wrUXJqSG1LMm5qM1M1U21xQUhMRXRxbGQr?=
 =?utf-8?B?bHFMb05iN2Q1VmpXZTR2eTliOSs1TGU1aFc5cCtjenEvTGlFUXZXYVdwL1lI?=
 =?utf-8?B?UEliRGdldThXQ1JCVWRVT3hDdUVsWGpmYmM0bjBiTG1GSlhNYXRmYmtteU9Y?=
 =?utf-8?B?SWZ4T2JsMkltK0pUOGQ2TVZnRUg0eklTOTB4b0VqSVE0RmRqSXk5anhwZEg1?=
 =?utf-8?B?QUNhU0JVK0VGMC9WUEoya0hwUGNidXNqRWlHN0Jwb3Q4bmdueHVvOUt6cVFH?=
 =?utf-8?B?aTFocit2S2R0RldrbFM2OGdmRXppNFNtYm9nZ1JSbkt4WFJCNURlZkRlQXlq?=
 =?utf-8?B?R3JZTUJaTmtVeGw4bE5uZGE1OGVMcFJ2Z1QzRVNzS0VNYTE0SkxuU2UyNUFu?=
 =?utf-8?B?V1VpaTZZbU1HeWIwMjBnbHZobU1wbEp6d1hhT21yQnY1R242VDRiY1MwUzZQ?=
 =?utf-8?B?bjRydDl6dE5jZEJ0MEZJTHk3Z2VTeS9VcTg5YmtIT1o3clZORW9jckV1YU16?=
 =?utf-8?B?enZidlh4OXlyQUVVbTFtT2s5NWdwRE9PMzI5MGVnKzJiUUpqd2dMTmIxNVNy?=
 =?utf-8?B?VWQ0dGdNY1hMdFZhdHlnU29ZbHBhUE5zVDJaeWU0eG11S0dmcDlzV3E1VVVU?=
 =?utf-8?B?ZHROZFpIWUtKOFZDS0gwSGlsRWRITS8ybnhEVDhoWW9WQnlmbUh6K0lMS1FC?=
 =?utf-8?B?dkFRYTdVUVBVU3BQQU9ieGtNWUJkanUwUWFRNm5laTh0QU92OTE0MHhTVy9l?=
 =?utf-8?B?MzVFTVNPallSS2hMQ2d1VDVWT1F0Nzl2VlhpMURYd0kzKzdoNDQxWGhjK1Vr?=
 =?utf-8?B?TmtxUFJDOXJIaE1KU0J6SS9pdEZsV1VVYUVMbUdoOFdtajY2U3BTY2U4NVdx?=
 =?utf-8?B?WDE4UlEzNGZIbU83Y2hzNEVGVjM5S1M1c0Y5b3dOeVdDS0UrVmUyQjlRamhR?=
 =?utf-8?B?UFdCTkM4VTB2Y1hHZmMzQjFzYmNOK3R5eGt0bzRIRnJOQUFRM3N2K3FFbWJn?=
 =?utf-8?Q?Z2VI7O9HTJmq5?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e571c40c-02ac-4631-d4b3-08ded67a96a3
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:38:34.0818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6574
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 6/29/2026 8:13 PM, Daniel Henrique Barboza wrote:
> All IOMMU accesses are assumed to be user mode unless told otherwise,
> i.e. we have a process_id.  In case we have a non-user mode leaf PTE
> (PTE_U isn't set) and we are running in user mode, we need to throw a
> fault.
>
> This also reflects on qos-riscv-iommu tests: the tests always run in
> user mode so our PTEs must have PTE_U (bit 0x10) set.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3553
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c               | 8 ++++++++
>   tests/qtest/libqos/qos-riscv-iommu.h | 4 ++--
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 453601d7a5..e6d2ca94bc 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -297,6 +297,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           G_STAGE = 1,
>       } pass;
>       MemTxResult ret;
> +    bool pv = !!ctx->process_id;
>   
>       satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
>       gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> @@ -470,6 +471,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>               break;                /* Invalid PTE */
>           } else if (pte & PTE_RESERVED(false)) {
>               break;                /* Reserved PTE bits set */
> +        } else if (!(pte & PTE_U) && !pv) {
> +            /*
> +             * All accesses are assumed to be User mode unless
> +             * process_id is valid (pv).  In case we have a
> +             * non-user mode PTE and !pv we need to fault.
> +             */
> +            break;
>           } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
>               base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
>           } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
> diff --git a/tests/qtest/libqos/qos-riscv-iommu.h b/tests/qtest/libqos/qos-riscv-iommu.h
> index 90e69a5d73..c218e9d66d 100644
> --- a/tests/qtest/libqos/qos-riscv-iommu.h
> +++ b/tests/qtest/libqos/qos-riscv-iommu.h
> @@ -54,8 +54,8 @@
>    * PTE masks for RISC-V IOMMU page tables.
>    * Values match PTE_V, PTE_R, PTE_W, PTE_A, PTE_D in target/riscv/cpu_bits.h
>    */
> -#define QRIOMMU_NON_LEAF_PTE_MASK   0x001  /* PTE_V */
> -#define QRIOMMU_LEAF_PTE_RW_MASK    0x0c7  /* V|R|W|A|D */
> +#define QRIOMMU_NON_LEAF_PTE_MASK   0x011  /* PTE_V | PTE_U */
> +#define QRIOMMU_LEAF_PTE_RW_MASK    0x0d7  /* V | R | W | A | D | PTE_U */
>   #define QRIOMMU_PTE_PPN_MASK        0x003ffffffffffc00ull
>   
>   /* Address-space base offset for test tables */


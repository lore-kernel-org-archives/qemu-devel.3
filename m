Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAA3C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVNL-0006eO-MS; Fri, 03 Jul 2026 00:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wfVNK-0006dc-14; Fri, 03 Jul 2026 00:19:38 -0400
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wfVNI-0005g2-BU; Fri, 03 Jul 2026 00:19:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUqhu5Od+AI7WFlE+XlGbTw+7tvgHyjQsiAihl6SxsM9J83z79pzVb3nyFW40OJWXqnGGCE2VKyhMroycnD9e7ntY6kKi7UTug/2C+fIdWPPeTwTtNwXw/B37jGjwrZ4d204C7TZcU9cWCnM4y0CWhCSSmUZIH8AJgubVHhx7lHVF1B+/3R9YP34Es64Qx3XkAT8l4SI5G4fd+KBQ4KeJLMZR1BIxHHuxPV6iNLNyL+focW2URQjiZ+MPHbaxsFSc/23R1QOERNvBsCI4ygXMk99Xd8Tp+ZgONkIHysmX1NWabaQahldINzT0dcnTmU3RujEepRQiBxesD049occYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3nESjYvM+y9ITluXL7jgtWs6BpTDt/9SzrsBVR8VpE=;
 b=H8vuLYtzcyaTUVWmqTBCkjIP38UbWEf1fQ8RkKAxmeY9uNMPAjOkT4K/0DSTpafarmW+QJ7OCaHKz6vFYI2Zv+Z3k+9rQb6GIkwMzpL9b+prTO0Y7ZmHEvvp/kxUrDCLWtmdpWPXNVjauHIOcGGkAN+QyAVBOv568/+hjMTUw8RueiEMXlxcA3444a3DFbAt473m3PUfbVPTEhpQlAFwpnEb9d2kLifmKo0Sp1cObPAsq971Ugdlf92bo4YNFWKzgayHINnFDHZWlYsEclUhPIANwHQZ9fT978UFMSaMlgxkZerwsunjZdf0xQxmsJ9JJkJsCQQqOinVxNcVysPVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3nESjYvM+y9ITluXL7jgtWs6BpTDt/9SzrsBVR8VpE=;
 b=tvhykqVrNn8fpqWK0KzxHm+EDxC8xSWLhmoUtZhAfEZ7DqQYk5F9vIiDeHb6yrHuI2xIcjCSkfS6cCAHjASUW2D/nuD1Y/1vFaEugFtlwUOb3PhUWmHRJ9Glflklx8q0WPwwzxF+vr+C0lA/T/gntR+ybLBLercdnnZ+ZQFcyQrnp66kXAcv8j8tvnbnvEFotDnNAvBK+TQ7FBraSGR3TU3/p2GyJdORV7DVPE7gfok0xeJ+mDF3c//dKk5XNEAyMCzg0ZXLkfwgDZ82tD5rCVe48uzfINEHrS4a/Qum+AMeKXrqQFytT6PHnYutPyJOUs+OKfuIaVGnHhbN1JJ2fA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by OSQPR04MB8090.apcprd04.prod.outlook.com (2603:1096:604:299::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 04:19:28 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 04:19:28 +0000
Message-ID: <SE3PR04MB892210BFD922A592633E2A92F3F42@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Fri, 3 Jul 2026 12:19:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: fix MSI_PTE_M_BASIC address
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702180714.1428013-1-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260702180714.1428013-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <424b17b0-ae0a-40e4-8d57-df874212d26f@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|OSQPR04MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ada75e-b42a-4026-a960-08ded8ba45b9
X-MS-Exchange-SLBlob-MailProps: Z9TzpHVL8qo66q/I2BQDGqmFnMul9MvF102JZ5aLAxiMJdSjUXR0a3j04ALr2bWK6cZ5W+l47EvPJrXxPxBFViIpKFcR6sYFouerK1/WXSJmT2n7z4qDsZ6jX+8vsp1UnJ6kHTzfH2jzWsStITkWUBixx8Ka101ViLY0EjAxIFf0Oi+5SS4s5I9xSB7mrTiZ/yHrwr41aMdzFgxLp4CYXMGpY93BVuWUuJijUzSv/QaQFKzZ0VKfNl55J/5y9SmMbbd7fGWo/8V2a48zDE84mYvBq4tQV+NWCcenaXsUUbwJSLZAET/2YWk+51mwtupfuExm685VoWGIae8+TLnJAZvGwFONfV+8fv7NPs28VPGFrzYB9rIv/AdMfnR5gx04/FbwYLnGNj+a5YmW+pRExoEpAfUWCz1RopfEY1hl7QWw9Zj07zn/J0ueXT7zzoIR099MPzQP5PgwiUaCvsA6dvU5Kk7xnENDvTDUpFFGVbJArw1A9pBdD35lhPhXDTtG5vWjNAIsCRzqQeNmgdWD6o6VH5nmy2yh7xtptZk0x2le8posNEH/kmXHLPPrHTWPtkgWqmp9URrDQyocBFsyhmu89BiSfUWnB3gs+PPGa9A75+vpCfsIx1fCYkHjwdpStsLuTYs88iXRRneIfEjpCPP94VUPP9eE9++9ecqGrCkUzQBEjKp7K2LXqRF+3hrwBpg0eIrMVyCBJilp4pZp7PuY3OmEQ84GgKa2VGpCJCaCjKwfuyvGuBSvoGo4ek1NqRiWSk41NQsncSbxE8Klhr/uowH4V/oX8wUD+U1HBPCcZzPs0m3PEKK+Wkk3xaQo3hWsVOgHOXmIyKNRymT0pP+qbrq/g5o3t/8XaQy5lkD18rMFZlW6Ug==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|19110799012|8060799015|22091999003|19101099003|24121999003|41001999006|15080799012|23021999003|55001999006|4140399003|25010399006|5072599009|16041099003|10035399007|40105399003|53005399003|1602099012|26121999007|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkpDVUcxQzhGMnVvdlYvSzM5eW5LSFFKVHdCcE4yM21MbHpYMEh3Umg4b1cv?=
 =?utf-8?B?dW9pL2FPQnJzOEhSSFBoWjFWME93dk4yU3JhUDBvank0bDRVckJzMWdXT1Jl?=
 =?utf-8?B?cW8vOFBMVTFDTXJQbVgxYXdHTmNRYWJ3cXFVS1kycURuQldkUWNxMm0rUnpR?=
 =?utf-8?B?MktNL3M3TEM2YWRHbDkxalhkTWJrbWlsM3BsQW9zZXZyN202NGYxVUg0UmFV?=
 =?utf-8?B?Y09VNnU4aXlxQkdraGhpb3pPYnQ2djNrcTI2STZMMjh4cGVqS0ZpRHBjQ2VO?=
 =?utf-8?B?Q1NyYVlLaGN3QzR0MkcrRjFBWEp5SjJpVXNpSzVEdEZXU2kvYTNrSzZMYTZq?=
 =?utf-8?B?Q3ZDdmRFNHpKZ3gzVy9RRlpRUnA4KzVDQ3c2T21OYUhlcVZqbGpBNThkWUNC?=
 =?utf-8?B?R3VIelBaeUJ6RG96cVpwdnh4Z3A5WnhjamZWMno0NzFhMzZnQUJGbXlERkl6?=
 =?utf-8?B?am5nQjZIUEpmTVByMGdLeVZ0NmRpdnJ6aWFQVGMxaDRsT2trMkxLUW5VTkFv?=
 =?utf-8?B?N1ZIckFPTkFFMzVoWlFJdjA4UWN5WlFwNDJZKzZKZkhndnlnbG8yem5KT3M4?=
 =?utf-8?B?WGtDSTg1RHhNdDFodEE1b2FWNkM5T2Z3Z3I0S3cvYWxiRnBKV29MNVc4MUp3?=
 =?utf-8?B?Mkwyem56c0hWbzU1eE9qTXpyN3Y2V3o4UnJXbndCUWNJUzBuejcxNWVjeVFH?=
 =?utf-8?B?YW1VYktJWHZCd2JJMDZYSE1VUHoxSjZHbitUMkJaK0llNi9CRmQ3T0M3SnNM?=
 =?utf-8?B?ZTNsWnNpajdXeElnNkcwS3lKbWFycmMrMFRsVGhRdzd0UVFEZGpwV0NzeVJQ?=
 =?utf-8?B?cGFzd1c2bzNkMmROcXZhM2d2VjdYYmlJUGNXVHNIeE9CM051SWN0TW8yMWZ6?=
 =?utf-8?B?NXJPUlI1Tm56Z296MUtBRVd1ZEhlejFJSnVBb0RSUEJSMytTOTNXc2Z0RWNp?=
 =?utf-8?B?YmFpdlFwOHRFdDF5dzVRVzZCYUtPbmJlVFZFNkVDdGFOYWljZTBLY2MwYXVl?=
 =?utf-8?B?b1E1aTZGc2Evak5YVi9HYnN6dWJpWHJ5Sm84MVJCM0dMSkEwYmNkdGdIbDMr?=
 =?utf-8?B?cGtYUXNyNW1uSWh5dEFMSVRMb3BveW5STVBTS2RiUVZhMnVjNnp4bnpEZ29m?=
 =?utf-8?B?bDdGU2lpU0RycHo2bzRra0FyTWZUTjFhT2dWQjhwM3YwRms2L0h6M1JPK2tM?=
 =?utf-8?B?UVV1eWY4WXhjdWQ5aVVlUGZNUW1aelprYkc5c0FoTzZaWlo1S21Uc1cvelgw?=
 =?utf-8?B?Skg2TkJER0lYLytkUlRyTHhCT1VONmlKaCtlV0RMYUJNdWtpZ1hyNXJ3T1Rv?=
 =?utf-8?B?M0FHQ1ZWenhJd1Y0WmJ5K29Fek55VThSU3VTUWZiUmJ1T2QxUlNibzJrSVpx?=
 =?utf-8?B?NkVWd0lPQ3orcEpCMVlIYlF5UUlxeHZEaDVoV0lzd2xra0pLWWpScnBOVjh1?=
 =?utf-8?B?eTd3UEI4MUgxbzRXTmFsVmRNWVdSbUhScDRyUERDY1FYeVlENzFkdHB2YU1C?=
 =?utf-8?B?MFcwQ1I0bDhNd0hiZU9tVnd4S1ZKT0dBZWZsYkhkN0hNSEtXNEh5cElVUU5q?=
 =?utf-8?B?MzRjNnBDWDJOWHBZNzZKMzgrNnZWWDV4MGlTTG9rKzJ0TGk4VmtSa2JJTlRl?=
 =?utf-8?B?enhieW11OWpCQ3FSOHovY1RnQVR5VWJSK2lHSTZQVFpaejRVK3ltOTdKZHRv?=
 =?utf-8?Q?RmAt2q96qrMPHxYjtoLE?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRURjNZWkZNWmJsQ1FmY1J2UGd2Qm9KVW51Y0hiQlAvemxBOGJJcFpDTC9x?=
 =?utf-8?B?SGsyRlJWZVk2Z1FxSkdyTTVLNTA2bVRBSC9xR0h4WjN3STZWYlRFcFp2ZXBp?=
 =?utf-8?B?MUdDWDMzWDR6NnV2OVkyb1VTZVF0bHduM2VORDJqcWpZUHlrQXVMU2hRSjcx?=
 =?utf-8?B?YThFYnZiSkdSWml2S0F0QU5Qdm9lUUg4VXl6VGpXSERjS0s5OXh4NFZZalpG?=
 =?utf-8?B?cVN0TGw1K0FlMGM1UWFHbzF1YUFsZEdLQ005S0ZFTUJMUi9VQVdkYkxaK2Iz?=
 =?utf-8?B?cm44eG9hS3NzVmN3OVZuaWVPWkdqRE90UXZSWGF6bE5IblpZbDVLWXZvUGVy?=
 =?utf-8?B?bHkwMEcvd290U3hQUElwQkk3cnE0NTNZYVhEdVhESXJqUjRWaWM3TWx5K21t?=
 =?utf-8?B?NENadU5ncGxnWW91MnJacE9zakRZZDBTRHVKWWpGTEdjMUd6Y3dKNTl5aHdS?=
 =?utf-8?B?UUdQWUllVUpuZDZNQWFsbEg4K3k3WmxjY2tEWGw3ajBOZlgzeGlPNU1Hd2Jo?=
 =?utf-8?B?Qm1vVmRRYS83WTRuQVQzMGRQM3kwVWxtdi8wS3Q4U0xCd2Irdjh0K0ZMdEVJ?=
 =?utf-8?B?UmNnYjAvdkZRdDBQNmVZTWRZRWJwZmNtZTZRUGJRODZPcFFBMzJ1MmFaV0x4?=
 =?utf-8?B?OVZBdEEwYUVneXdKcEdvdnYvak80SFcyUXM1bGJqZE5rVFJBeHVjdjBQcXM1?=
 =?utf-8?B?RkR4Mm5EbFVHNkZCNGtldlRNbFZUaW1ZQkxINjdhZTNjY3ovb3psZXNNbk94?=
 =?utf-8?B?R3VUdjVJUjRBQnNYRzFxT3BoRTdHUGE2dUl6YmRaUnoxYVlKcktmRVI3SXBh?=
 =?utf-8?B?VTZHbUh6bkNMc3IweVAxOER2dWJVUVkzejQ4WjRDZ2poellSSURieTNUR1RP?=
 =?utf-8?B?T09lT1ZZY0JvMisyQlVXY2o4dHR1RnYyb2NSSXdZM3JpZnAra1I1b1hxU01Q?=
 =?utf-8?B?bEhHOS84eWJ1S05aZ2o0cDlRSXZrdEphcjhhY0NUOU9rSkNHdnh5MldRcFdL?=
 =?utf-8?B?YTRZWFlNQlQzdkh1N3lEbk1vRUp2S21vZlpFZEdlaGk4ZEJxc2w2cUswaFFh?=
 =?utf-8?B?Z3VBbjY5MTYrSUxnNUVraVh3NWZmQjBDZm9DZjNJMlFxNGgzWkFabWNoaVds?=
 =?utf-8?B?NWgzR1B3REIwYkVmdnh0R1k4WWlSUWxEbXBSS2hiaWpnbDRqV0pxQVAxMzJI?=
 =?utf-8?B?Q3I4c0tRUG9Sa2EramFSL0lFQmtLUFJrRmluTmpVdVhtRWRpcExyWjlneTNO?=
 =?utf-8?B?QVJZQUhlTmtyNy9KL21rUldwbGI5WGJYR0JqYTVYNTR5QnZ3ckY0L3l6WG1z?=
 =?utf-8?B?V3lPT1UrQU42cDU4V2dxOWhabGQyWlJLU0tML2tWVTExVUIvMncyeGdCWDdk?=
 =?utf-8?B?WGU3WHJIQ0J0UGpXd2JWUGJ0REwxRFZ3Q2c4SCs5Z0h0RDM4NXZjT1RBSEVJ?=
 =?utf-8?B?dkUzWktZZmRrL2p0SElrcUhJRnNZTzNyUUVaYlNmVS9wUWRhbGxhZUtRak9q?=
 =?utf-8?B?eWxaRnAxcTgxSjJxQkN3aE5KYXNSOWptSkVOcGdJSS9oYVRISkNtbWdqZjJS?=
 =?utf-8?B?R0w5YVZ5ZWtJY2RJc0lEc1hIMmxFaWt2cTF4OFNVM3k1ZUZycGVOcThSd213?=
 =?utf-8?B?QWUwWlpUOEliY3V0TTg4Y2Y4UTVFRGZQNUNNWFY0djlRakh4SGpPRTlRVnN0?=
 =?utf-8?B?b3hiREkzdFM0Sll3VjFMOTZyRis0Sit4WUFtKzJFNlcyemxBbmU3dUhqRUpC?=
 =?utf-8?B?SFpWa0p4NkpzZFo1Rmx2U01qTW94cWlFM1VySlpMakJWWnRNOUdiVnZ2dHZ4?=
 =?utf-8?B?Rm5HT3dxZzdIM3NuWXFtNjIrV1RPR3VzQTM4d1FLOXZnZG9RR3RqTUM3MU9w?=
 =?utf-8?Q?RaNKhpBEHXOls?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ada75e-b42a-4026-a960-08ded8ba45b9
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 04:19:28.0904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR04MB8090
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 7/3/2026 2:07 AM, Daniel Henrique Barboza wrote:
> We're not considering the page offset when retrieving the MSI address.
> riscv-iommu spec 1.0 says:
>
> "1. Let A be the GPA
>
>   (...)
>
>   13. If msipte.M == 3 the PTE is in basic translate mode and the
>   translation process is as follows:
>     (...)
>     b. Compute the translated address as msipte.PPN << 12 | A[11:0]."
>
> I.e. we need to bit_ior the GPA page offset in the translated address.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3560
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu-bits.h | 1 +
>   hw/riscv/riscv-iommu.c      | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index cc0b1c3ccd..f1f10cc318 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -471,4 +471,5 @@ struct riscv_iommu_msi_pte {
>   #define RISCV_IOMMU_MSI_MRIF_NPPN       RISCV_IOMMU_PPN_FIELD
>   #define RISCV_IOMMU_MSI_MRIF_NID_MSB    BIT_ULL(60)
>   
> +#define RISCV_IOMMU_MSI_BASIC_PAGE_OFFSET  GENMASK_ULL(11, 0)
>   #endif /* _RISCV_IOMMU_BITS_H_ */
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 6761b77f95..6f3db7b73d 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -658,6 +658,7 @@ static MemTxResult riscv_iommu_msi_write(RISCVIOMMUState *s,
>       case RISCV_IOMMU_MSI_PTE_M_BASIC:
>           /* MSI Pass-through mode */
>           addr = PPN_PHYS(get_field(pte[0], RISCV_IOMMU_MSI_PTE_PPN));
> +        addr |= (gpa & RISCV_IOMMU_MSI_BASIC_PAGE_OFFSET);
>   
>           trace_riscv_iommu_msi(s->parent_obj.id, PCI_BUS_NUM(ctx->devid),
>                                 PCI_SLOT(ctx->devid), PCI_FUNC(ctx->devid),


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B3CC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weSkB-0002e7-Fd; Tue, 30 Jun 2026 03:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1weSk9-0002dD-Cj; Tue, 30 Jun 2026 03:18:53 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1weSk7-0004GW-Mc; Tue, 30 Jun 2026 03:18:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEof9xcYUy4yA5N+9tuPuuP681u6DsEqhtnDhQ6NBVYEi4xdU2EtQawExGvYSBDoCFnES347vF+fUb7B2WLVK+MgFlM2EFWQd2ho6sVNHAXpf8r0MS+lzhYkcXSY249cDuNBLMsWzBl5U8Qyl/CWXRgRigdHRSnWGfQaBAGxbs0TsmSHjacHyYHlbJzfeHz1VeeJBO2cFDmjEXRGxOyVDO/lLbH6lslVtM+Te4c8+qbug4l1Rne56qLaCdtP9kjIYWLCP/AGj01C3kxNDQ6EZVJcBcyQxwq0zGalW+rFlnq1pSHZzCpdlZ/gJ0P8UHiXei77uPojydHtZcP9+mH6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhJo8ZmFcvDgDyN8tIXDnJSBWOh5W4+E9umLB/XIzTU=;
 b=SffQCHPG7D0GtgJgpGc8HXkoXWtAtHJn0gyPPDSLOcgUfB13Y8jHfF5ftFuKhc0KNmRqwcaW/DSbAx6CthEyoTf8q7E8VEmYzYfRDKbSF/GVXRsXxBTvw1/dimbiHeB9yCpVbAYKiMfSpi0cwBa7tPawTi87E827smZQEFoiww00vFcBPMWiOwFRyGZg2KUgFcFEhxyPWbJcmBpuny2WONIP7S8mtN0fEDNiLxU+mbZrfcYPeSrp+2V6oMmGAowV3iCvBIEMxcVnbLf/nODDpTNQympHGZV/ImmCbrDFHR/s3p9okpuS5ZEjpBpxN42Jft8iSEE2VQg4ALg8jZ3rcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhJo8ZmFcvDgDyN8tIXDnJSBWOh5W4+E9umLB/XIzTU=;
 b=R6jrdWEGoIF1x89ORN2f+3we+xblxxkkkHK+LljmUtvIhjUgoGTMsHV2CUikUJWXAAOPE1RA8MaXcgVQDx3NPjppKAWYIQ9UQfbl8IyvaiXKIeJtq+fNqQnMR4pYgmhfIHReaHGPIZinG/OYL/5LSfQj9alqmG0nGP4WBH4unoV2OqHxQUAHOlMe6o0dEQurYvlVSsMGdl/VPX/OV1WUXjcff1+ecrPvFAc6mPJGsEO8ZMDuFUNpvoU6fnqIXfNlvjuGsudJRYIRoDJBXyqQSK26y2yYAn21ZysPNSeEUUAzNSXYxpZ9Yi6zCHBLFlHFlRllISk0Ua2pquKns8Zs0w==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by JH0PR04MB8065.apcprd04.prod.outlook.com (2603:1096:990:9a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:18:44 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:18:43 +0000
Message-ID: <SE3PR04MB8922CEA7FE3E5F59197F1C48F3F72@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Tue, 30 Jun 2026 15:18:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu-sys.c: record fault on
 IOMMU-generated MSI write
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260629165954.1018123-1-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260629165954.1018123-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <318ad437-5154-48e8-8630-9222d7238bff@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|JH0PR04MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: bc459be8-bf41-4100-7228-08ded677d0ce
X-MS-Exchange-SLBlob-MailProps: suo+AMQROd7awkY+uqD1IG9kXGqTcr3c22Z04+i/gVSt+XKzfnp5WV4h7n0NXfpEa06SvtaXrQXFXKJx1I8zWvbGRQlv9C2VBK+uqMeT8C08VhiXBmpYRde2BgTV7jaoaGRROthFcsjnT5NyH0hBFceWE4fKPky8D5CIamlH6DjDwbYVfy0PwmTwYpgf9BRbQV03kOkiwR1rD9PFrZ82POB6aClo2TadoSr1NrSetBEJrTpiR2b9r0VbcO74QuGdAZZFC5Squ1QSCwxLQnXMxpSi7u3UTZM0KIPajVc/e4AwBT6ePZuks2PgPk+kPkObcYOKEzVAeqaAYrwZPqRuIhY0xHzIcfgx99MO3nBd0qs/ltIGEoPG9xy4eyoO9FMMfj8rY7QwMVY0Ez9l1y01qndVw79VFT5rZY8RKi28OBz9EjvpqxVu1eEMhEkd3igqo3w+ycbY4W4TLpCbdjCfqxCkPqjiq+k5m5pdfSqYR90KbxL73vDDtIusIlFEHg+QXUIGQT0j+W7pvHcmRx6ezgzqiHSRlelW9Cy+YLyBcm1qD9/e9t5czH9gZdEDU8zgN0amPtMSpyPsF2UIdaXJj8TvUjDtsSFAeJfmTqiG1VSxFi8YIwOVsdbJ4/DlziMKwi/isssZ84r9Q1qTE3vV4Q9tukU1Qb3E+YMDOFkBPyUf1MDIsq2sdMyq7jd82tA1+a2JrCbETU9Def9yVc3UYj43htTuBuFrzmvwbEvv9m/XIb6Z+fbYZz1VEDXu6RNv6uV98NRx3dWrbNY8CQXpQ58f5aBlio9nEMrtorfQlgiQz8w+T2rMluzQkDQV0bXKr2OMSI3j3EBbZVzI6zNGuA==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|15080799012|19110799012|55001999006|23021999003|5072599009|41001999006|19101099003|25010399006|51005399006|8060799015|40105399003|10035399007|1602099012|4302099013|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDE3blFlL2tTZjZzVUEyQlJTQnk4TzdPUCs5UVB6U3RGOHQwcnVwb25hNUVo?=
 =?utf-8?B?dGQ1bytxdnhpVUc5MndYLzg4NlcxWmpBd1VsQWd2d0dFRjdJM0piclp1TSs0?=
 =?utf-8?B?b01jMEdXTUljNUYrdnFMUnF4d3A4Wk9HaHl1bzBLbXBOWm9hU1IwdmttNFZ4?=
 =?utf-8?B?dnQ3dE5XQlNjYy9CVjZsZ004bitLTlpxT1JhTmZ0bUEwcGw5dmhEUWV2cDFn?=
 =?utf-8?B?Q3hCNW9WMVpUUkJ1eHBOUVBqcC9kNEg2QzdFRHU4QUhlbW4zZVJvRk16c3g4?=
 =?utf-8?B?eXg3a05TcTRVazV0eG5iR1hrTlNuTDVRa290cmUydjBWQWJ1dnZWTXVEbXhC?=
 =?utf-8?B?NzRDbjZXeWNrUWpHWVVNOFhyRmE2aUJ3dUJhaTUzK2FxeGtRanpUR25SSFhr?=
 =?utf-8?B?blFRbGNMYUZsNGpGN1R4Q2FjVlcvcVJ2Z0R3TjEwdGxqWXowQVgzMDVwWnp6?=
 =?utf-8?B?aE5HV3RJYWNQWnVWNklLUVNIbHZDeGg1S0RTUXl0WUk1Vk1OZndlR2VFVEtm?=
 =?utf-8?B?RHFkRU5HbUxGNzkzcm1HaWtXZTFmdE14ckpnbXZ4TGdKaFZjVEVobklmVC9q?=
 =?utf-8?B?N1VaMHlwQStkTlpqRXdKMjZadDRSaytOSllwM1ZhSUhlQW1BU3N3ZEhWL3ps?=
 =?utf-8?B?ekZqU1NSVjU0S2JlUGR0Q0d1bmYvNzdzNlBEaWo0Q01OQUpBelNUTHFzY2cw?=
 =?utf-8?B?WCs5ckJoV3BsdUw3R1pEYVNYUytIK2x3ekFVQnM4MnQ0cCsxNk8rRjV3Uk84?=
 =?utf-8?B?WElCNjRRNmFEYnRSQlpqelJ6VnkyajBiYkx3bjYzZXFZUDUrcVJmbklrcVBo?=
 =?utf-8?B?M1IyZjNwZUZZc292OUpHMU83TFlCMnl3VnhRZ3BkNlEyTVgzNUNycE5uZWpB?=
 =?utf-8?B?TGFzbDBXMEJ3ejkwaHdxRFp2aHVOQkN0clM1UzFJcEhuU2JxMzF2am1KS2lX?=
 =?utf-8?B?Qit0Y2dHblVacDArcWs5TTBCVnhFV0xoRjhlbUhjS0VzRkxZancrTFVmMU1K?=
 =?utf-8?B?dmF0ZmVtQlE4NjlEWDVzeCtXZ0hsNFg2dVVqWjNYcWRsbDk0SUcwM1NlNk9V?=
 =?utf-8?B?dGx3RkRyOUVFODV5WlhKb1NTMjdIQStFVlF5d2x2aTdodlhNQ1psbDkvWnVr?=
 =?utf-8?B?ZXVIN3VQVkcwdis0eG9NbmlHQlU1VDNtNkZVandrNTEvQ3VRUVBwaytGbnFl?=
 =?utf-8?B?OTBBUlExUGxFT01PM3JvY0tkdVdRUjlEU09VM0RCZEovZkZHZVBuWnVrNDRs?=
 =?utf-8?B?cFBYdkdrTCtQNzZQWk9LT3ZtWURNYmU2elFGeW1YZE9tTC9EMTAzWVRUOHpu?=
 =?utf-8?B?eEhlU2daaVBqQW5oU1pHYjVwNCt6ZERVaXk3Zi9iVGNmR09hSjc5S255SDgw?=
 =?utf-8?B?cWUzYms0d2RlWkcxd2dXQzFabnlLQ2N4RGI5dm10aXg1UERJLzBFZ1o5Z2F0?=
 =?utf-8?B?bm5qTjFZYWo2OEVxUXg4VEdUSGtYUUp2S3JMTDhiOVdveitIL1p5STJ5azZW?=
 =?utf-8?Q?wILtkZCuM4AEgpyAc81xlvkEDCo?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNhbWdkOVdMU0x3ZzQ4VXNKTERqcEFKSXBVSUFIVUxMSTVJZS9EUERId29o?=
 =?utf-8?B?cWpORGh3bUZERkZ6YTdSRUpFVFlhRnVIcFl0UWE4ZlpmVTNUQnR4akJGOW4w?=
 =?utf-8?B?R2tHekxCSGVXbHBaQUpObkpacFZ2bEZEeGU1ZzdEQ0xCcExjK0QvTUFFNmFE?=
 =?utf-8?B?bHV3bFZIaWp3SytCSXhhTVVZU21LMmNnOG9aYlB1bjFWUDNNUnk4Q0FJUzQ0?=
 =?utf-8?B?U01OdGpaL083ajcraDBUK1VDcENXRHhBamFQM3JVVG44eHlPMWkzckR2anRK?=
 =?utf-8?B?MDZvTWFZa0p0VFJZbDhob0tmZ3l6akF3bVNzTXg5R0dxYy94K3Vjdjd1VSt2?=
 =?utf-8?B?dk5NQ0lwMmtrRDMrMGh1THBKN0ZiUjdtY3lXaVNmQk1JcWcvbXh5QnRkRDND?=
 =?utf-8?B?T090bzFWcDlKVWNMTjhhcWk3WUtMTXg3SEhDK3EvdTdpQ2hMOFMrcUtHaWpS?=
 =?utf-8?B?WUxoWURJSmF1S0FDOVh2cjhRaDRZMEtnb1l3SmNuTlNMVkdnTEV2T3JIVVkz?=
 =?utf-8?B?NllYczcyWkZ0T2M5M3R5Vzk5Q1RRYTJ5K3dEZG1ZdVA4YmlENTdROHNjWk5Z?=
 =?utf-8?B?cGJqb1JBbG9JS3E2cUNWaUQ2ajBCQzdyRTlVLy9WTmlreWY0dC9rQ0JkcEpn?=
 =?utf-8?B?NTNjK2kwTW1USFBJYWIxUUpIQUlkYkJvaUpGdUl1ZGxmSXVrbE9iZkJORGZz?=
 =?utf-8?B?SnZSSGNKV0xxQi9ZK00vWG1TNUNRSnlWVS8yVFBURzdxMWRmcStCN1R6K1cx?=
 =?utf-8?B?YitvYm1wRU1wV3JsbEJvMnJmQy96bHdNbmozY3FEaWh2bGNNbjNOYm1KZ0FT?=
 =?utf-8?B?THY3WkQ4NFRtRlAyZXZSN2VGWDlZWUZrVzVVams0UlFPUFB3ZENtY2tHVlFr?=
 =?utf-8?B?dWFENGpQcHB4YjM1TG1aMktaNi83UzRSSWdOUFdOektvVFdDV0ZLM3k5TUlr?=
 =?utf-8?B?SVY5d3JkOGVLWlJIVFplS1c4ZWVKMHIrUTFQYUNKWHFqTFA1UFNYSlJuTDRU?=
 =?utf-8?B?SU5yMUZaaTdDNVFZcXlHVGxtMDkzRHEyTTNCdFZqSlcvVnFMd2ZzakgxZkx0?=
 =?utf-8?B?ZjVzMUZHTlFldENpTlFqcS96ZEhpeEJlMDRTQ3A3Z0E0eTl2bTN1K1g2ZTYv?=
 =?utf-8?B?YXRjeisreThLa1UycHV3QmE3cDkySXNTei82YmJra2lzd28xSFhVb1FDclpW?=
 =?utf-8?B?M1VmelZ0UERreDJuN0EzTnNRTi9zcDBlMnhvYmJPa2p3WUFzRmJyUHhWYXlW?=
 =?utf-8?B?TGhFU2NwS05hTnR5bTFEdUU5WFB3VVZGNFNrZEE2ZCs1Vi94ZS9FV0lXQjFm?=
 =?utf-8?B?MXdTMFVhWHQ1SExtak1uYjBXYktJZkpUWWFqRmhCTCtpL0N2aGtsNjV3a0Jl?=
 =?utf-8?B?MmRLMVN3MFFWNXpBNnlyTXAwVFJOam41Ung5akh3NVJxcnNrR0dIbVl1WU42?=
 =?utf-8?B?N1gxZlV2dXBicnFOeGFyaWpVMU9reldHQkhobDl1OUpUVUFBNndZSmNWY1Qw?=
 =?utf-8?B?T3dLZlNVYUhUWDN2QlZacWJqN3VUcHprMFYyWEZjNzRFNFE1a25kRXI3ck9a?=
 =?utf-8?B?aDh3SVI0TDZUSzZ0d25EaGFUWHg5dzQ2R25qWUdQejdwbTNtWTRicFVxeWNx?=
 =?utf-8?B?bkpERVNTckNzZTMycnluMmJNcHN5SHh1T2FxTHhpOXdBMFJ6MFQ5RFFUbjE0?=
 =?utf-8?B?UEFjU2dOK3ZzT29oTWJvLy9VSDFlWFBXZHlQR2d1NE15WkhlWVZRbGhBMXEw?=
 =?utf-8?B?dVg4VE1KVDUxS25vWE1Zdlp1QlY4RlNETG9vWnJUZlBDdzVBNFNHVVY1dVVq?=
 =?utf-8?B?dXMrTDZTTWNkSnUvb1pNVkpIeE1DOEM2a3FhOHpZQ0hCYzVCWjN3S1cwYjNG?=
 =?utf-8?Q?lC8DnnWUym0nL?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bc459be8-bf41-4100-7228-08ded677d0ce
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:18:43.2834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB8065
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


On 6/30/2026 12:59 AM, Daniel Henrique Barboza wrote:
> The riscv-iommu spec requires that the IOMMU records its own generated
> MSI write faults.
>
> Fixes: 01c1caa9d1 ("hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3572
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu-sys.c | 16 +++++++++++++++-
>   hw/riscv/riscv-iommu.c     |  3 +--
>   hw/riscv/riscv-iommu.h     |  1 +
>   3 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index bf87b0b4ea..3314adeed2 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -26,6 +26,7 @@
>   #include "qemu/host-utils.h"
>   #include "qemu/module.h"
>   #include "qom/object.h"
> +#include "target/riscv/cpu_bits.h"
>   #include "trace.h"
>   
>   #include "riscv-iommu.h"
> @@ -143,7 +144,20 @@ static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
>   
>       address_space_stl_le(&address_space_memory, msi_addr,
>                            msi_data, MEMTXATTRS_UNSPECIFIED, &result);
> -    trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
> +
> +    if (result == MEMTX_OK) {
> +        trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
> +    } else {
> +        /* Record an access fault error in the fault queue */
> +        struct riscv_iommu_fq_record ev = { 0 };
> +        RISCVIOMMUState *iommu = &s->iommu;
> +
> +        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE,
> +                           RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT);
> +        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE,
> +                           RISCV_IOMMU_FQ_TTYPE_UADDR_WR);
> +        riscv_iommu_fault(iommu, &ev);
> +    }
>   }
>   
>   static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..a962926688 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -118,8 +118,7 @@ void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
>       }
>   }
>   
> -static void riscv_iommu_fault(RISCVIOMMUState *s,
> -                              struct riscv_iommu_fq_record *ev)
> +void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev)
>   {
>       uint32_t ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
>       uint32_t head = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQH) & s->fq_mask;
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index a778e86fb7..da70e8bfa8 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -103,6 +103,7 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
>   void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode);
>   void riscv_iommu_reset(RISCVIOMMUState *s);
>   void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
> +void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev);
>   
>   typedef struct RISCVIOMMUContext RISCVIOMMUContext;
>   /* Device translation context state. */


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E98BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weSrG-0003vW-LD; Tue, 30 Jun 2026 03:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1weSrD-0003v7-S9; Tue, 30 Jun 2026 03:26:12 -0400
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1weSrB-0006pw-6q; Tue, 30 Jun 2026 03:26:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsBE+ugQjfRK0GEIiUFgyWsaGZZ5cO2kmxMIDj1UB3CxWglYLWoTUtr1YUKod0P+nDBfV3q3PsPastzNEXCoHwYOI/cRPJxZjQJIvOrgm8AxLZmBkRkD/PdDg6vtBI/7/vRc0ney74vPSS8dmklwtmu5MRlIf3OY6kxvGJcveGw0nqK09WQBDv4w3XpEOUjYJrsgGKkpSposZy48sPG6Q5KoESRpo57cMRrrgCbEzvBRGpxKI7gI5Izwa9GIxrVecTNgAmrUmRM+EG8MQvYGvqTYmeZOPHdwZ0pBG6z/BKkPkQ4zWYm1f0EIxjtqm6+qy9JIijE6c4w8U4sCM2H0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OR38r2nYhGIC/b5JsSecbBxwaWeLd/8FGSUDWkTkpUg=;
 b=HztmxSUw4JNDgo+mEZlPcOTnEWZ09SRDCyJTcqOyoa4NSH338U9F/0CxoocJWCw0uJ23Fq+ABEOOltEiy/sOGvxluzr6k9PIJu/UWyjLw8DvqkvJA1If2nbvMJpuXBO4xLthJlOUhpuII4nYuv53zC1R3EaMBqdIgXGc7ZcbYg7UUi8rYLXoiNRq+XruAtX8eEmiIkpBsQnbqmr6k76XjwlfQ99ngZgdt0U3liKgfa+ysXS++Ry164yZqKY3okayr73Xvv1Z21+tme/IsrvAkWOUiBEu5c/3x6NCtjhiEoZFeeJJqbO/NlX/r11s56JWRnaPsmvX166h9K7K/lTSLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OR38r2nYhGIC/b5JsSecbBxwaWeLd/8FGSUDWkTkpUg=;
 b=WtJzEVQEjnAJpTNgHhAxKJhBZSb19RbFKAPPVOYietDNsEripscn/nUaBO0U1gREjwrPwvCEJWNAwZK0tzieEztnEfN2FQD9r5s+K+COEAFvd2XwovxXG8wzlTN+Yo8rVgoyV8+UwpA8hZKDy9kWW2r+nXFHBrr+PQVEFt7mSSGwtVVCi+xpky7JPnPAXGKZZEo3HImZNfCTRV6pguNgKdxOekA8peHtzyI7xK7Jl95Ai06PtOl8Uv0AE/EclW8hRbpFMHjJ2v8jJJX/ypHSFRw8TBVdqWM/g31rxO1VbhpeOIzsdk8UlKqmVzcrX1KXE0nKsEvWBJXbgJofIO01wg==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYPPR04MB8957.apcprd04.prod.outlook.com (2603:1096:405:316::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:26:02 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:26:02 +0000
Message-ID: <SE3PR04MB89227A46265C07B1D98BC4E7F3F72@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Tue, 30 Jun 2026 15:25:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/riscv/riscv-iommu.c: check for reserved PTE bits
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260629121334.567587-1-daniel.barboza@oss.qualcomm.com>
 <20260629121334.567587-2-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260629121334.567587-2-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <13bf4c5f-3db5-4271-bdd2-9a568afe934b@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYPPR04MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: edb609ed-668a-4667-7ac6-08ded678d6b0
X-MS-Exchange-SLBlob-MailProps: P1EfU6pZOd/ur0QDa6YmBjuOVf78JKonAxJ3OchCmkXp+3UWBcRuDhT247+OdanJCmqxmJQGIdXqdNjp4QTLU+s3YfOLRE0s/4MVKTaCIgCooEPzbZBUKpGWOH/wwTICgfQ6EITuEE60OVci89OqEAvhoUw9Flo+w4mxa2rNXuvQ8og+siBezzhq5Yh8yI0ycLizeFjaq1CGUZg67EdYg6mjqJpydRxGKtQ5AjjGmA7aaLXnuFfu+a9v+rdspJ2ZEn+bs9r8i2OPE58KAFr/y89BWiWbDGpxmmnuCrX1/KghNI6Jfi8zhBdmvjvQ8EhJnIRVMsNUzLcdv/L3ll9v+ZKGGCsfGgSYnJP3o6DjFntqkVocbo/fOXvdGvrb+xTKISkkK+OlFAqx1tjX7VE6IC6CnJeuioACSMg/Q8CX4ZTT8/DwEP/pMmEfBzvjLRyoHxw6GDyz3mrL5oBc7jGClhDtuRmyOeBip4HAM9CaQvlvNePMixDN3Rb+drQ/o0g5f0HHqA5yGux4YoyyHBqCj4IndtRgqREAYvh4tcLbfQs3Q+yyJ0gcHX81nhVXT5cqrTs3Oe3gYw0L+gyMNrC0elF8T3O/51O67lsy3eVqOj1m7Ards9C/zL+tZh2gwKhgOnudw1D1NGN/43FuwySp7etYUy4tmnH0xkqOI+tgwmleG9DGny7uHjyC5mBF2hkD0yXhtK/LG3KkXmcg1iUb19pnBKfqqzkSOn9R916q+SXti6YZiMPPYxskNk4MRjQxUUJUH9KwUiydd//xFyqFFbvEG/r+P0u/Zqdavh0/wERR/MMjZ63nhA==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|19101099003|55001999006|51005399006|19110799012|8060799015|5072599009|15080799012|25010399006|23021999003|10035399007|40105399003|1602099012|4302099013|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGp0RnEwRFhKdDNsUmc4SmFSeENzQktUN3g3Z0ZWMlJqanlYUTZXVkVIdzU0?=
 =?utf-8?B?T0Vnek1KSWVwS29NZnBRajFqYzVTbklObEF0RnhRaFF4RmtHdnRQSGNuRDFk?=
 =?utf-8?B?UEg2eEE5SnVpelRzdGx4NmNiMXpaSVR2WVR5b09lOXRoYWNYREZZYXpGK1RI?=
 =?utf-8?B?ekQ0K09UTmpPNmJBd3lzVm5FVVBhdTIxNVVpdCtOZS85ZlZETTQzZTc4Z2lw?=
 =?utf-8?B?UWhuSFFXY2o2R1lrT21MRWR4cGtZNDJHVVN0RjFyN3B1d1A4ODM1VVR1T0or?=
 =?utf-8?B?UzZVUUQyUVFnYlFuNlZvclI1MitFLytKVi9oTzQ0YVRzQ1F6RFNmQ2QwVWNI?=
 =?utf-8?B?ekw1TWhVTEdxNUI2bzR2RE10RXhFT3plMVJSNGpzY2d3RCt0RTFzUFZRcTZw?=
 =?utf-8?B?MkgwUFpWSDJTT2t3bzNYTTM4MUU4cnZIMC9qK2h6WE9McmR2NSs3OWpYMy93?=
 =?utf-8?B?bGFOY2w0NE5zWXhETGw3NnBQaXBYVm1xMjExL1NJTGdVZHA5aG5pT1NCbFlX?=
 =?utf-8?B?V3VJalFiVGErYllMVEd5bG9jc0V0RjNZbUhUYzhmb0dzM3gzSXlMM3M0M0Zv?=
 =?utf-8?B?SnNSenYyTkxRWlhCZHF5OHhvTW1GQ0JvZWtVcUh4cWdpNGN1SlNQUDJkaUpT?=
 =?utf-8?B?YWtROXBwTDFIR2F2cGpSWHo5UUxuaDFzSUFsRC9EcThrVWJ5SzFvZHcycCtz?=
 =?utf-8?B?bHFFZ1cyQWN5UWtQL2FWMW5peG4vTjhLTEY1cklkcXA4cHVsdEtXMTBkOWRQ?=
 =?utf-8?B?dlZIMEhIU05XRGVjVjVhTnpmZ0xUanJqT0IwTVBrWkgwQmpnQUUxYmxQVk9S?=
 =?utf-8?B?UFc0aTAwcThyNmJ4ZE1DM1o5UmVKTnFhdGtmck1lQmNSVFNHVkRJRjhXYytp?=
 =?utf-8?B?M3pHRlhLN0tzcHFmSisxYmZ5WDJwdXZtWTNSOVV6WGk2YUNBU2xvNmdpdk9s?=
 =?utf-8?B?UlM2WEJSb0h0SmpmbytRYmlObytjamZLVnlMbnlaWEhyd1UyWGhzaXhFNFNY?=
 =?utf-8?B?Q1RBZmd3Sld6WEhNNkZ1dWJhaHVRdlFKZXdZU2lWN3pMR0gxTVlKbndyZTJB?=
 =?utf-8?B?cHRjeHpZUi84OXhlbHVYbHMwcjYzTkVPV2RIWmVUaFlhNExtYW84Y25OTUdM?=
 =?utf-8?B?Sk9NNXVpOEFDSVZ5NWRvRGI2Y2JqSFh6b2hueWtQTkwrMjFjS283THpWQmI4?=
 =?utf-8?B?WlJyMmNHeW11T2UwRnhlTzBmUGYySjFac1JPUWNJcWFIc3Z5REhlZGF3Q0x0?=
 =?utf-8?B?K2NiVC9jZWo3L215N0FHRXF3aW5pNW15cytWVzhjS3lJYUsra1VueGZvTWdt?=
 =?utf-8?B?ek5oTStKWmtyaXU2c3pCLzdHNXZmcm9JWnEzaEFPWmlIcWtyYmExdmJHMHMz?=
 =?utf-8?B?UHUyeWN2Y0E3dEpTV0ErQWxuVVQ5azZobHVyL21ISGlYL01WSEszak9ycExL?=
 =?utf-8?B?aDZSOE96WEk3aVQyYTlEVjV6WmhZSXRaVThCbERnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzI5cEpTS0JMd2p5aTBXK3BvVDlVNXFZZDJDNHRWMS9HSU5TVy9zajZkSDlt?=
 =?utf-8?B?d2xhWTN4R1dMRG1lQnVzNnJBS21IK1pmQUhLVGk0QmpDNHlBN1FaWmsxaFl6?=
 =?utf-8?B?T3ZYeEdWTmVDQ1c3VlNMeXhhdVZSbVI4b29mbHNpUG5lTzdoVVZhc3hidWxO?=
 =?utf-8?B?N1ZmZ1lWdFpGa1VuZGcwTjRic1JvdE5kVGVmYzFYTHJYMjZpWDBUd0RFUmd1?=
 =?utf-8?B?VUZoejkxUG1IZUkwS2I2WitPRFBIWVk4dDdwblVHZmNDMS9WTTBIZGVabkhI?=
 =?utf-8?B?dHRGUTFkK1NlYkNsbVpyUGJCVXNHRE15OHZkSmtIUnU4OUc4RG4yam1Ncm5z?=
 =?utf-8?B?TkVaOWMzb3pnU1ZvcHFyUDRkaGtpVWpMRSt5K1o3L1RkU21KcklOejFqV2d5?=
 =?utf-8?B?d1NFWVN6SC9pemxGSzBzRm5BdStKaHpDNzg3b3Fkb052UnZuVkJGbHRQUmxu?=
 =?utf-8?B?c2RodHppQTVRWWlRQ1JQWXc0aFprZXlDMm41a0N5S2YxT25wS1pjdmVyWTZr?=
 =?utf-8?B?dmdCcVF4U0RGU3IvRzhhL1lYTU1sZTRYN0NraW4yVW40WXFkUUxjTTZDamo1?=
 =?utf-8?B?VXN4eVpRcWNRWmR4MXpZelY4RGdXdStFRG5xRWhUN3U4aVA0MExoS1h5UTUz?=
 =?utf-8?B?bnFGbkZ6b1IxQVRBTFNxbEtmNWtTSHZlK0w1bjFUbGY4Mkxwc1BHU1ZSUk9S?=
 =?utf-8?B?eVhvcC9QcHhrTkdtWk5vaTZNUFVMZWFUVm5DOUdiTmp6NkRMUjQ2UXFTTDE1?=
 =?utf-8?B?dVNWS05razB1T29jOXFmdnZaTjIrVmQ0YmZUUWZrU3lRUVBkT0VFSC9UbXli?=
 =?utf-8?B?Q2tuZEJuSWlURy9Fc05LWkVhUGc4UWJOaG91dEdJQ0toc2p1dTR6RDVEM3Jv?=
 =?utf-8?B?NkVKNXhSajAwUjNWU0RBR1NOSFpwN0NZWXpWcWFhdW9FTFBidkcweHMrRDZL?=
 =?utf-8?B?NlpXWWhCRUdUWVFoK2s0TUpWcEZCeTFpYXV5SmxYaURRT08vYnd5NHNTTTJI?=
 =?utf-8?B?SCs2MVpVc0g2M1JVVmdhNGlJNjVxTjdQY2l0NGJHck56UDlFWkNUSE9hcktu?=
 =?utf-8?B?VnR0Qkc3TVF3K0tjSFcxRlJYY2F6VDVuSzg3dG5zdHdCTUZSeGlMYVRHMVZr?=
 =?utf-8?B?b1lEc1dxeWFnSWxsVk5lVWZWaUxnOHp5Z09obDcrVmJocDhGZjdzbmpHcnVo?=
 =?utf-8?B?R09pbytqVXFBT2ZGeU1UREJTbEhBdUVhaUluT2Y5NzgvTXpaY2dLYTAxQlJn?=
 =?utf-8?B?dS9YRTZVeHhhdit3YlNqL2NHOTRhWGpWSS82OG1BNDBDZys1Y3Boc1hkcUU3?=
 =?utf-8?B?djFNR0xwSFdRSU9wRGEzL3owZ2ZqKzVCY0p2Nm1IeTVER2hLWGZOVWhRYTZW?=
 =?utf-8?B?T2NxS1l4UmFrSDllOEhpSnRnSEk5L1l2dkgyb0UrL1pwYnNEUzFtanQwSThE?=
 =?utf-8?B?SW1GNDd1Z1ZVanRLdmhVaDJ1Z1FFUi94R0ZtYXQ3WXRaMkM3b2ZhOFkyamF4?=
 =?utf-8?B?eHNLMGg5NEw3WEpwdGYzNHhsdTQ0bkVwaTNmZjNudVNBME0wVmJOa1ZJMC9Y?=
 =?utf-8?B?OCtUQWw4ajZtWkhwdDVKVElPeHpxcmxFcnpKYlQrckFrSjNhbGxXSW5RZDM0?=
 =?utf-8?B?Slk4NXBhNWZWSFViNmh6WlVvcm4zcEJXRGdQeUprbFFla1IyZlh3bUJ2WXkx?=
 =?utf-8?B?UEtreEJpbG1wWDJJTWloWGlINWMxRUZxaXB2NVc4c3R1T0xmdTZpWi9uS09X?=
 =?utf-8?B?VFRaSWovRFd3M2x2dEhPK3FMNllhT1Y4T0VnUUg2NldJQ2xZa0hEaWdVVzJ4?=
 =?utf-8?B?T2lUSjBrWTVzNnpqdGNrUVh4N0lGb0dqeFg3MEo5TXhZL0ZnS3J3UXAvM0kx?=
 =?utf-8?Q?Ad2M9pHHCqjjk?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: edb609ed-668a-4667-7ac6-08ded678d6b0
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:26:02.5378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR04MB8957
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


On 6/29/2026 8:13 PM, Daniel Henrique Barboza wrote:
> We need to fault if reserved PTE bits (60:54) are set.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3554
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..453601d7a5 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -468,6 +468,8 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>   
>           if (!(pte & PTE_V)) {
>               break;                /* Invalid PTE */
> +        } else if (pte & PTE_RESERVED(false)) {
> +            break;                /* Reserved PTE bits set */
>           } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
>               base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
>           } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA51C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 07:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wep9d-0002dn-5N; Wed, 01 Jul 2026 03:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wep9a-0002dW-9d; Wed, 01 Jul 2026 03:14:38 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wep9X-00089i-KK; Wed, 01 Jul 2026 03:14:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdCp/DHw7YOCfZVBLloG8iFIkJgEwt6pge1d3te3WRcykzuknZ7agG/AP/hhypbd+bRauXX2LFULrNFZQiP6UpUjIgCGBEsTuGM7emHbxDiCs3xaVR/4n56G0eU9TfOQlbh2ey8FpCmUZrr71Mhp9YdsVP6mtTwqBUMWhVbKvDnl9mpC6QuF/d9zodWaYl1KSUu6sbFyJ8fBxC4F65GOUSHI2W7+/BT9V+Lw8i+5SXfiC65Wc5DtSiJUSlFOikMIVVtiLnHhBXWfWB22TRDyxY644f9P0uN8CgRrDpmX6MUSPC0sFGzAHprG6XoEkU+TV2ssjBwHhqWocFiyWM5oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/txsZMry+RH85rbpLUaqO4GwLfJEZh66GZVuVUmbtg=;
 b=ZMASqkr+y5AYWGHYyFVoFCPaPK+wX/K054sdIdkOfTqbS7JeZLwzKldr9d5j/IBYPg0esQ3vP7GqBnl/rfYiBBkpf4sgRKGcqYFHmxQsixP/pdmymPai1dkXtPdrKMfhNW2wAklRnTL3Ot0SHJoIbFEVLtpxyCQc1z3roBwKC74s6ZgTeGcQ5FqzLDNNCidjPC9CxppYl1p4nliY/Q8TG1NrdBuo7gP6sYG7ZjFfdsiqEgkPTSY5EW8chwqVIqB5xnumpUQKBlBcYNi5TNFLwpguPvsXRd5lYltBNfCupjfKgjb/Z+xk6VkofyEUdJmA3XuoqfvhsUiRLV4kIlivvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/txsZMry+RH85rbpLUaqO4GwLfJEZh66GZVuVUmbtg=;
 b=ZGKLpN0FSOz/PJ29njB0qgGxEElpD98KfBlwiH8X7rAJonKgtFR7s0ihXOkc243jHnTPCNG7b5jVVGOVBr2SxkEpyWxw4w+VD45eCqZpiEbljl/ZGtza2OK2aHh8Gt4tTeoMN957M38wo6yO0ey2Bd9/dYuWpc+oYsMeO/KdevLXEA94+IOVAHReLxBP+S7qJtA0QU06yBwwx3hMW5z6508sqAIOEx/EmvmmjbrmfoEzxKpLETc67YJ/CJMpc0PT7DJ1kack25iUYlpdHmFaF2Kc9iBGny9hwCF8tC7BLeptriH2ebvwSpLJ5kZtiVQlc6nfDl1n/xPuHvpDncVdAQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SEZPR04MB8286.apcprd04.prod.outlook.com (2603:1096:101:23e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Wed, 1 Jul
 2026 07:14:25 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 07:14:25 +0000
Message-ID: <SE3PR04MB8922CECD5609C19D2A69751FF3F62@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 1 Jul 2026 15:14:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: forbid GATE/SADE if caps.AMO_HWADD
 is zero
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260630172110.1866951-1-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260630172110.1866951-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::18) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <a2c9a824-b6fb-4eb3-913a-12fc7469b686@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SEZPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: beb8ce5d-8197-4d07-7df1-08ded74061af
X-MS-Exchange-SLBlob-MailProps: V85gaVfRD4/uZtbPKQiHMaRLDxOOyjp2yRhLen5hfVnAVboytvmh2YzW5gvBrMVTotiyyYSNSxagojaodX+VHBZTUA0c5uc7Bl/iJGSbMPd18u6k9tY3mneTmBV/iFxLkeMdnKiO/G4VoatEp6jX0atLho7XnIL6p6154WFRq/uD/vwMXsTO6D8DLyRg0+gZCjS1xS2+j55kOHbR+nwFiPZ3zZy1TZ588xygV9BglBTYOAOuWH0Idaz+UYmXVtiXqPrTWz6jKSKX3GxycSTkYESvabZRlN2YBwuIGsam0eQOedK5SMwBJRAhiDI3ySwpStTqdDnH/xnurW8bM36yxn0iTmvUXET57UA8PkOkRLcrg1/zNfksAz6AycxWMvF21rDy95saiz9wQmQ9tyzcjm2OMtrCwWn439EzniuyU3838ZDwE8dak2b9PlqQ30KNHJ6l8+YCo6J3X39s9nbw4QW2wrZo5IcRxGeQGlqfzO/yE2Gdp6Xxb6N9HzKDX+X123I4HBkJjXj1ITiT2kx6rDbjqZSZCkP3B2r5oIk7KnR/IWRyYQlL9zusOMhjPmWwtEwV01d0Rs8g7bRHkghXBInB/DgvDkl//tIB9iO31jvtmpL8u0UifahScsdSUDpSEubTHfBQz+WOQEfsKYVvwpfaJDXqrAEglGCJkBYZ+Tvpm7oT2BNozKtBcz01Ti/8/QDuWOnSrIz9sqGsFxMVlHGMojQfd8TYXe/iE1tWfQonOhRq3XIe75yIkZq7ePA9Ll/2KJBRAy3+yTFUJx4aAo1psfDTxSQlEm/4H5AO+OBstECRuMfDXTSUMtnzD92eOEh52C4yRXs+txknFpcp6g==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|24121999003|22091999003|16041099003|23021999003|12121999013|15080799012|8060799015|55001999006|6090799003|19110799012|4140399003|25010399006|5072599009|19101099003|41001999006|53005399003|40105399003|10035399007|26121999007|1602099012|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHBZcm5vZUYyNFUrYkxIMlJOZzJXQWpoZ1h2NFRiL0NNRVpSNmZiR25EYzhF?=
 =?utf-8?B?dTVoMEZqM0c0cDRJWnEwS203cmpkWGhueEZpU1VVdXpEUmw5QkJVNnhKV2pk?=
 =?utf-8?B?R0hteVUzYVNUcnluOTQwUTY1cGdTMlcxVXZaZHIvbXZQeXBlYnZPblVYMFBk?=
 =?utf-8?B?eDVDY2hxc0JQQlV1UzJZeG9JN0FIRmNxOEMydjE5NXo0YkhQVGNGazFnckZ0?=
 =?utf-8?B?aGF3RXcvVTdJRVZ4UEgwYldDckViT2FEdUpYQWpqVGV1cHV5U3ZmNXRKRGFV?=
 =?utf-8?B?Ynl2QjhjRzNMcyt1aTNLMXJ0K2ZGeC9MZTA3ZFdsYWRHTDV6eUwwSmtwRFkx?=
 =?utf-8?B?dHRrRjYyZVJITGhHNjdWK0NUczZ3aFFvZVdKdkcyKzkzeUl3dXhCOGFBb0Jq?=
 =?utf-8?B?b3lLSjZkSExZQkZ4Y3FmU1RhbFZVWTNsRVFZNXdWQlQrM09QcjM4UjgxaVZs?=
 =?utf-8?B?MHUya3pic0dMWXRaOEI1aG9weXVDZDRwSDdYVzdJYlpBeWRxcm5qaEk0b3Rk?=
 =?utf-8?B?S2d5cU1yRjFsdU9yWWpsS1FvcEFhM1JUbFQrWEk4WnQ1bmk4Y2w3d1BVSEYr?=
 =?utf-8?B?aUNGcEIra3dERnR6Y2xLdktwRnhJSyt3T1hWTklET2Vic1Q5ZWIwMWhuOE9L?=
 =?utf-8?B?Mk11V3RwQTRpUGk4ZW1OR014d2FKdFZ4VU5yTUMybUtTRTBOTDNnSnZEOG9n?=
 =?utf-8?B?RlpSdEJMTit6N3Z4SFhZbkIwRS9NUzRtc0dKZnl4VE9yQXByRHNzMDBwWjBk?=
 =?utf-8?B?czN0N2FqUUtwaEZEY0hCWTZFaWx5dFJaRm5icjl3MHJnZ3hvSm9UWkxzMml3?=
 =?utf-8?B?d0JTWkJtK2NBZ3Fja0g4NzVCejNzSjRSakFaQys0K2YwZXZxd292cDhGa3JO?=
 =?utf-8?B?OE9KOEoxQjYwWm96Z1RWYkJhVldJNTJUS0R6S2FyQVFBTnBIYkdxYWhRSmxN?=
 =?utf-8?B?L0N6aHZFakZYdDhlSDlyUko0UER6dGt6a1MrbjRFVkltMW1BTDNrQXhzaUZH?=
 =?utf-8?B?VXhQMUI1aWlaZ1l3Y2NVRFZpRTlzV3ZkSFArT1pXN2NXZml6VHZZZ0hYdFVU?=
 =?utf-8?B?WWw1T2RNdTNqaTNodktEOG42aHZyWmRCVDRBbktLbTZ6NHN1LzhXc0xKdHN6?=
 =?utf-8?B?SmtPNnF6OHdLQWVXY1M2eDJXektLU29ZbG1CSll4QTREM3dhaEZOQUhYazho?=
 =?utf-8?B?M2djRHBrY04yeEpDMGliZFRTRTlOZ3JTZHVtd3pEMjd6dkovZXgzSGcrb0Mw?=
 =?utf-8?B?Y1ZOc25reFByTmV2K1VwUTNZamljTjZteVQxSGhxUHcrK1JWRWtIVlNNK0pR?=
 =?utf-8?B?cmxaajNlZjJZRXpCWHU1WWhHTmRuUUpURmRvbWR5YkN3RTBFVnl5ZXlOT01C?=
 =?utf-8?B?YjJvNzNpNnlBaURaVE93eGpsWml6cE1pUXFaWXhzbVEwbXRwWm5oTHQ0UU9L?=
 =?utf-8?B?ajA2UGRwcTg5YU1hOWVvMlQrUTY2Q2JwVjF1QTJFb29LSytYUkR6OWZSWWRv?=
 =?utf-8?B?NUJxNGVKclEzQXpNclR1MEl0UXVtWGx4MUpWSW1CcmdYWGlQNFBIMWJhaXl4?=
 =?utf-8?B?b3VMTk1jWFpOdlB3bVNYdDk1QWoyUEtOcU1TeWp4ODFjUGMrY1hOcXkrTStr?=
 =?utf-8?B?cVY0UmRrVUNFeDlvZGJCWDk1Yk8yaURUdkdNbzJXZEh0WjgybFRHK29BbFY0?=
 =?utf-8?B?ZWxFWGkxQlZ5Z2pmQzRhMC9SRXF1bG43QlRkbjNiMVR4SUpoYi9Jamt3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU1oeFE1cEpIaFNYRjNKK0ZkTDdxQzhhL29taGJzeFZMb2VUeUhISnJwK3VQ?=
 =?utf-8?B?dmw0TFBjYWJlZWRFSHhTMVBPWEpIcTdlR2YxOVRJWHYrSi9wbWFkQXZhK0RL?=
 =?utf-8?B?RGRGNXBRKzNsOUJOSGdFZytZL0hDcVg1NE83azlleFg0c2t5WGJZamhTc3BK?=
 =?utf-8?B?d083aTZMYndKamhST25zdjlwUGNYb01wQ1lqRzVxbkNxUWJaRXRFNzQvQWxl?=
 =?utf-8?B?amtFNTlUS3JiWEp6NVpDZEdWVHY5L1VNMlErRlQ4bUduZ2VQaW45NUJQbWJW?=
 =?utf-8?B?YlB0dHkzVGM0WFk1SDJwWDMwc1p5bkl0dWYvdmVmN3dDcFI4UVY4S1A3TGJp?=
 =?utf-8?B?TGxHSGdlNXJVc1lXTU82N1A3QjhEMWNwY20wUWlBbFhwZHpjUHp0a0RQbi9a?=
 =?utf-8?B?aVNlcWlsWVIvZEJ2MHJCaVJYeFhKUFRZdnY0bHY4YTl4dlZyUTRuT3Qvbk5X?=
 =?utf-8?B?MzJoNU5neFJpeDcrc0VNallSQ3MxaGUvK1c4cE5vYytjeTdsa0REVEdVY0NZ?=
 =?utf-8?B?eHJSUHpkby9RbllhdDFXbmlNNmRLbnBwYWo1RndqbWdkbkNQZituVk43Znhm?=
 =?utf-8?B?VW5Md3pwYm5nSGFCOW9RM3JtMlE5c0dKTWN6VUszTzhDZDFvRWF5RmsrVkZG?=
 =?utf-8?B?Ym5MVXVDOUg4a21jNkN0Z0V1NzlYbzlkWG81STN5RDBhejd1VU9KeXRIYVI5?=
 =?utf-8?B?TWFaT0NQT2s1bDlZUCtaRFd4ZE9pWTI3VDU4eXozVXJDaXR5UkZMOTdYcE9j?=
 =?utf-8?B?UEMyUEkxY0VvZjdSNXltSmgyY2V2bUhBeVF5UDVEZ0JWVld6a1FwTFNXdW42?=
 =?utf-8?B?amJIdXk2MGpESE5yVEl0dUVXZ1M0MXhob1JrWVl3d2liVTBLZmpWWWVaZE9n?=
 =?utf-8?B?S2tVT3FNZlhGUlFBZExTVHVYWmliN3grZUNHeSszamRBUEsvQVRpSXBGaG83?=
 =?utf-8?B?TXZhS3pJeDhrTFp3b3VPY2dTbU0rUmRxWjU0OWx0dmFpUmcxU0J2NzBTbjJZ?=
 =?utf-8?B?OFRETkFzTkRBNitiZU1vK0NNWHFZTmNiL2NPcTN0MDRybmM3aG45RnM2cTNV?=
 =?utf-8?B?a01KVHljNm9DSnBtSWlGUTBGQU4vdUo3REI4a1VobEpjcFBkQ2FmZWZJcFN3?=
 =?utf-8?B?Y0VYQWhpaDMzRkN3TUVDU1JOSE8yUExEL2FnMDUzT2dwYnhLRU5DV3RVYk1Z?=
 =?utf-8?B?ZW1wU0N4clRhN2p2TW9lZktZQ1poeWFpRG1RMkRDZFZVcTlSME54S2p1RUta?=
 =?utf-8?B?WTIzcHMrT1h3VHIvQWJEMVJGbmdFN0tOREJtUW9aQUl1N0s1Y3VDUDlpZXNk?=
 =?utf-8?B?OEdKaGdwS0FtYVFqcjNacXJlRjB3S216Y1VGSHBVV0dYakJadmtVdDNUTVY5?=
 =?utf-8?B?ZTRMZFVwcCtZMHNqb3NkaERySERWQ1BpcGVUelZHblZLTUVyTjV5dXVJcDJR?=
 =?utf-8?B?ZCswQTdrd1JzdGlrS3lobjBBOFBpQVM1akdzV25sQWJwb1RuNllIeHpSaU5F?=
 =?utf-8?B?dE52K0tZODZNUmtHWGt5M3hkOXNiMXdFcTlqbWEremsxR2RCQ0JSYUNiMGJy?=
 =?utf-8?B?WnZzSmROWnlOWklUdFRDMkdPL2ZkLzFLUGtRTkpsMWtsUmhhdlUyTGt0Yitv?=
 =?utf-8?B?YW0zYzZkd0NRVi9FdVdBWjhkNGt1ZHpJemtERE93REk0OGJzSm1YK3puMzA2?=
 =?utf-8?B?U1pYaHNxamJqaDFlMlN6YUJNcXVVYzgrMEZOd0szdGMzTVFyZmxoK1lEYU90?=
 =?utf-8?B?dC95cTRMM25Na2VzNXorK3JuYXpqNDJzME1LWDBuWEdSOFNhL2xvT3ZhbEJp?=
 =?utf-8?B?NmMxMEV5T2VpTytZN2RWKy9WK3MwRTdDck5QeW1jNmlPU0d0S1FtWVhibHhQ?=
 =?utf-8?Q?Mzt37jB+phYI7?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: beb8ce5d-8197-4d07-7df1-08ded74061af
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:14:25.6761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8286
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


On 7/1/2026 1:21 AM, Daniel Henrique Barboza wrote:
> When capabilities.AMO_HWADD isn't set, DC.tc.GADE and DC.tc.SADE are
> reserved bits and setting them throws a DDT_MISCONFIGURED error.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3549
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu-bits.h | 1 +
>   hw/riscv/riscv-iommu.c      | 5 +++++
>   2 files changed, 6 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index a938fd3eb4..2e8bc19dca 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -86,6 +86,7 @@ struct riscv_iommu_pq_record {
>   #define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
>   #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
>   #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
> +#define RISCV_IOMMU_CAP_AMO_HWAD        BIT_ULL(24)
>   #define RISCV_IOMMU_CAP_ATS             BIT_ULL(25)
>   #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
>   #define RISCV_IOMMU_CAP_IGS             GENMASK_ULL(29, 28)
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..891a56e731 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -416,6 +416,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           const bool ade =
>               ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC_SADE);
>   
> +        if (ade && !(s->cap & RISCV_IOMMU_CAP_AMO_HWAD)) {
> +            /* GADE/SADE are reserved bits if AMO_HWAD is cleared.  */
> +            return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
> +        }
> +
>           /* Address range check before first level lookup */
>           if (!sc[pass].step) {
>               const uint64_t va_len = va_skip + va_bits;


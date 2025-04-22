Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8387C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u78Bn-0004gc-K7; Tue, 22 Apr 2025 03:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u78Bj-0004fr-EE; Tue, 22 Apr 2025 03:37:03 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u78Bf-00059j-DV; Tue, 22 Apr 2025 03:37:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWj1MkFV1h2240LfmcjHyEaQugCWdWuSnScmruE9KQpszA+UkCi2NcYTCFTZxYY6Uk5Wjh42JKXaxFaS/rXbkL8J8NapfiXD7WUwwEa3nTzudliM3g9u0A2J6m78LA9r+7Fq9pG5sVvxWoeSEW1ym3W8s8nWeQ8eVWzhfXFX0+LnDe6ePBeD3JEKilMd18mls4DX1NuowcddG/R4KR7lsE7ftvNmjcxlVOQhawEssjwYYnWjWyuNgGclpGWiC5xuEiVlk6OwwROsNEWAJt4iqkqXJZyHca6VOsoXJr2xmxCBBY0XE08HLON0m8s/+iVvf0E3GTcOAqkKXiuej9SAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0ktKvNbMlQKhj8fKQ1OU/MglpLwrXB+KOzyb3u3Q6U=;
 b=eXVePCSePmMe6WXmjakCAZvG3i+KGQE4qBWEtkcm1PN7eK8Xaho+vg4XEHI8+Cyv8Z5iERiyPmLyZjiG0DNVV17q5mOnKu8+dBfJ0sYsN/bAd3ksZfH3cjNhLMg6mHowhVAROR/ljDWmOU3o3vSj4Fut9+eEdNjwtuvSjTAoifGnFnJGJI7UnBF1CZORcWLlMf6jlvDfiHEz4GTMqiQD+KzE23z79pU9WgiykSy/hBK7kn2qNYBl6+TEJwjUMj2Ak4squWVa2edebGWgQW/HCuIrxYjMnb2QcbvDBZNxwmGRxmcxcLosZlMFIZ5tdUq0xdkWL6tf/YZmE8uumRbRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0ktKvNbMlQKhj8fKQ1OU/MglpLwrXB+KOzyb3u3Q6U=;
 b=CVn10gwP1cgqkJXC+IeSbyRXN+kqCphYBya2fPfpX0qT0KhqFCenkWRpn+fwOPdGmm2h1d9zi6XtGRirJqPec5bWZT5lnu/iiA4wDS048m4n9FAWtsHLVLzcFOtCyAhDV0tx4zMw3b5HWDmLP3PnqkbuQItyQVj+OIP+7BRFAPdaay4tKYf/b9c1C8Wdd+VszaMwci6uySfUoh7V3zMT/ifj/LNcr5r/ucI7AHOXAxZNzlvnOG7aeAsne3Y39jSSvzyRe1wjRnBeAIyv5v+/eMXoW+l4aXNszO+WMIUPVZ6wIS9HcF7oJQJp6xo2JzTpH9HNCfC3/xw8W3oxRmLf3A==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 PUZPR06MB5572.apcprd06.prod.outlook.com (2603:1096:301:e9::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 07:36:48 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 07:36:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 10/10] docs/system/arm/aspeed: Support vbootrom for
 AST2700
Thread-Topic: [PATCH v4 10/10] docs/system/arm/aspeed: Support vbootrom for
 AST2700
Thread-Index: AQHbr0a70VD1lyhUH0m2RE07ytcgnbOvUeUAgAAB+9A=
Date: Tue, 22 Apr 2025 07:36:48 +0000
Message-ID: <SI2PR06MB5041555E9F0B80660FC5A1C9FCBB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-11-jamin_lin@aspeedtech.com>
 <cf409986-18bd-4e33-8871-b68ab4eba1e5@kaod.org>
In-Reply-To: <cf409986-18bd-4e33-8871-b68ab4eba1e5@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|PUZPR06MB5572:EE_
x-ms-office365-filtering-correlation-id: dc6b2fe0-1bcf-4afb-7878-08dd817070cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b28xcjRsYjBpcWcvU3o3bCtRSEtqSmw5d2dzdkNRNHFINUpkVWhSUEo2azhF?=
 =?utf-8?B?alZnS0hBamxTTisrdkpPVGdzYVVUQ2FGY2JjajZUOG93ZlpVdjFvYk9DV1Vi?=
 =?utf-8?B?b3VWamIzanBteFIzeXR4OERGTnQyRUJFckxidWJlTDg4bDNZdUdpYW9UZGRS?=
 =?utf-8?B?ZnNSTlNaRUEzajQyM0kxR0ZBaUtMazZTaGp3UEpBVzhOdVo1OFh2TDNDSElz?=
 =?utf-8?B?SDQzdE9Kay80M0RJOU1pS2dpUGxISGZTdVFkQzkzajZITldYUGdrMnhaMDlR?=
 =?utf-8?B?cHZCSVkwd3lEQWg5Y1FJeGlOZ1NlQ3RhZjJKRGJkeTVBOFdHQzFRWUR3RmZU?=
 =?utf-8?B?S2hEc1dpZnpsUmdQNllrR2hHRG5Da25lclJUbUUrVmZBcjViVTZCcXdaWWVO?=
 =?utf-8?B?UmNheDZuM29ld2JVWnY2SUhpR2RNNFc4YzhzYmVhcTFJYkVWQ3dmazg1TkRJ?=
 =?utf-8?B?VkN4bXVocHVsSWxPMVFDTTNabnFCYks2a3Z6KzVRU3B4Nm1uTE5xRkVCQWlZ?=
 =?utf-8?B?QWlqcVQ2MnFGeWl2V1dLQVNYaGtISHZ4QUVQUGRFdlNTMzlCYzRVMlkzbngr?=
 =?utf-8?B?d3dUaVFWSFgvamFLbFZJbkJMSTQ2bS9nS0U0ZVFpcjIrZlRrYjFnRGE4dUVC?=
 =?utf-8?B?cDY5bXkyOWNMOWRaUTZEalJwVWxiWTRPRlF5WVBJQkthR2lTMk8yaURJcGps?=
 =?utf-8?B?NGF2VU9xeFd5Z3piUENIU1lKeUdlOHBNaFpYZFRXSTgwVmVFM1lHdEF5VUNu?=
 =?utf-8?B?elgwOWJzOE41a2dvdjd5RkVDWHY4cXR6YzY4dzVSRXRxQit1ZXRpeEdORVRt?=
 =?utf-8?B?VFZwME52K0YrY1ZIOGdURURxbThIY1dickhUVnkwK2V1c3U4MVNFbTYxL01M?=
 =?utf-8?B?NmVoUGl6QWE1dUlxajhMT08vZGZEVVlCNCt0d3pWV2V0QytMV2dkZ21IMnFi?=
 =?utf-8?B?V3dubFVqVEMyM29ZWTdIa2RrTExSYmZpNkpGMy9vSFhybFdQc2xRWkgyWG1u?=
 =?utf-8?B?SXZyd1NiRnUyQWUzbHVDM1h2RFNrL1lMRmtMckdzUlZmVGZNMzBxTkNzTlF5?=
 =?utf-8?B?YmhLQ1RFV3VkWEF3MEd2MCswZ2xma3p2ZnUxQXdnOHBmb1VWbDY2SlgvRm1Z?=
 =?utf-8?B?ak11NUNOLytBa3lCTnJ4dkNTakZkMlAzWjd4aisydDJnZzFKVGpmSy80TVAy?=
 =?utf-8?B?WFQyR2tEL1VOVllxdDlUSys0ZnVod0kzaGVSa2ZqYjA2Z2xzYldLNWpoWEcv?=
 =?utf-8?B?TmNsd0gxSEQ4a3l1cithaWU1WVRLb2ZYYUg0OUphUzkwaHdmaGREbk9LYzRL?=
 =?utf-8?B?M2dJd2lidlUreGpZMUp4QlJSK2R6QzJGSjRHMHc0V2pIVDJraitLNFIvL2lp?=
 =?utf-8?B?T1dBVjhCVzJ6b0wzamw3bmtOT0cyaXlQcUM0bXFuWFk4MjJwcXVKQ0hTajZW?=
 =?utf-8?B?N1ppM1pnMEhlZHJKSFZkRllLYkJCM1JWRkhaKzNaUUlnNG9YSkhrRGd2VFFy?=
 =?utf-8?B?Nk9Ob0YyY0gxUS9kUWhBYzRmRW1PR2hnVkRxTjN1MUtuMjlPbWVlRWZIdDZl?=
 =?utf-8?B?MTN4MnRQRW9iMFh5ZzVpUkhEWndzdXl3VHpCVzZ1eW1GSndNUmQxUmdqdUo3?=
 =?utf-8?B?RTZsUkNGN1g3bzR5R0w1WUVJMzRKWlRTb2tEL3Rqc2h6SmxweEFmMW1kZ2JL?=
 =?utf-8?B?c3Q4a3IrUnNDWUFidXcyOVB3OE1TNVRrdVlEYzhmRC94QWlraG9OWjBjQi9Y?=
 =?utf-8?B?RXE3bEE2d0FZeXhZUGY1NTRtd3BnaUJMNW40MUI1WlZRc0o2VTRYSUo2UWxL?=
 =?utf-8?B?eHZuRjltbGlaZGFFRFBwRk5XeVZsSnF5TGE3UlE5dDRrNDVYcHBvMHRxRktl?=
 =?utf-8?B?SFVXUTFYL21xVWcxS0dPZVYwNitTY1FLUjVIaEs2UktnR1I4VjZLejNyd2NO?=
 =?utf-8?B?KzRmOWNIcEh0SjhOeGZMUk1QWWVKV0pER1RyWTJKTzIwM2w4aTNaUlMreFdx?=
 =?utf-8?B?MlZlQ2U4REFBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjZtbzhEaEJ0RkNqMGg1SmxyUElTb1h0dnVWbk9oQS8yTFhVQ0hoVkZGQndo?=
 =?utf-8?B?QmdXaFJIQ0F3MXpVSmYralhzS2FRL0I2OStnZ3ZzeUFKUkhiNkF0YU9FeDhZ?=
 =?utf-8?B?cmlFRHlwUUVQL0FFVE9lbTVCeWNER3BCaVp1ZXZrOFhnM1I2b1VHZGlkVEJR?=
 =?utf-8?B?a20vYXgwTk5SUDhqNjAyZHhmNExGRmx1ckJsYllVaVdwc1NLYWQrVXk2Zy9N?=
 =?utf-8?B?QWZFckE4TmxkY3JyWm5LYitRd3BHM0F1SVhYM2paaG9XbDQxNEZaTmxBc1Br?=
 =?utf-8?B?ck1QMnFBSEgyT0JjWnRaYmt2eU9JR0F3UTRmZ1E5eWFZdlh3eElnZUdua2pG?=
 =?utf-8?B?eUNCQUFKbUtaOTdtQVNBbSszaFRwbm5TM1ZPdUY2N2ZnSkJrVldxZjh2UFA1?=
 =?utf-8?B?SUhRM0IrRG1FTGRyeXhIc3RBY0QwcXI1MDA5ZW5ROUlzK3Z1OHkzcUROTjBp?=
 =?utf-8?B?RW9DcDNjam9YMStWTW55Y3lhYUVOQVVEZkFxc0NDcVVsdnA3cGF0VUNkNStB?=
 =?utf-8?B?YSt0THB2U0FndUpxTS80cjNuUFdkS3M5SnIra2R4eDlySFlNeFBrQUJ2cFRy?=
 =?utf-8?B?d0FVSWtGbnNjaDFhOE83amdIQTBBVlBrc0NVY2JTK1ViK3hhRkZUMFFPakRx?=
 =?utf-8?B?aWsrKzNSVTMvUWJhZmdBc1Zhb3FaRHk5ajkvZk1ESXZwSlkxUFVqSStWNjF2?=
 =?utf-8?B?UzU3OFpOZGgxLzd3NHUwM1JpMTZKbkdZOHgwVFRReXRzTC9nVXAzak03blR5?=
 =?utf-8?B?Y1E3OTNEQ3Nnd3lsVXo2OWRBWXduWWlZOS82YUlmT24vRi8rMzFQSkUySUtm?=
 =?utf-8?B?VGoySFJnREtENFBibDZmUm1VdE5mYW11RmFxY1NjUm1ZeGVkaTRxUGNUSkVC?=
 =?utf-8?B?eDQ3WEM2TDZoY1NWMmV4S2wrR3ZuYXNRdlNQOUNJTyt4MXc5UW5XVkQ1b2dB?=
 =?utf-8?B?b25ZK1Z2bDFCc2lZalpzeVViK1RrMHQ4Nlp1WDhvNXQvYzNzWnRyUGhuakN0?=
 =?utf-8?B?bXBpMVN5aDZ6WnpiNzFwUUZFOU5uU2lla1E0VDBuV3RuM2FUYzZSWC9KZHVu?=
 =?utf-8?B?eXJoeXpXYzhORXRhMFdrMXRSdVUwY3E2UXk5N0JYR05NNEgwNFVaNFJneS9X?=
 =?utf-8?B?OUJJNncxV0VBa2QxRWMyNVBpNHZvZGgvUGo2dGdaaUU2Wkc1ZTVBUEJXSUF3?=
 =?utf-8?B?VStqNy9lWkZySWZyMVlIUlBSdkJUU2tMWTcreGtlakxHZFU1d1dpMFBPZHp0?=
 =?utf-8?B?RERTOGJXczdUVEdGQWY4Y2l2T1VPSzA2YmhBWStVVVBFeHZFRzhiTFBEUHhC?=
 =?utf-8?B?YWkzVy94WFVXRW5lcWpuNlVyVXQ1cVhQU0FoMnZSVHRIZ1RiNjBIc0wvUm82?=
 =?utf-8?B?VGNLb2tmZ3dVdjY3U2d0NDZBVTh3RUVBcW51UWp4MmJISDRhSjQzdkE4R3VG?=
 =?utf-8?B?L1k2anNUMGdoZDZCMzBZVWtrek5RYkd3VkRpeFZiSkFjQnNaY1NTdHZZbk5M?=
 =?utf-8?B?RXRjNGNYSXdhWTVYQno5NHJ5N2FYT0lXUTNlN29BWStOVFVDTlRvekM4Z2pq?=
 =?utf-8?B?KzlkU3ZvNmlNbnRpMkhINFpuNjBJeEV1UllMVXlwZ0l2aXhnN0k2NzA3NDdm?=
 =?utf-8?B?UEphM1NzZ2lLbHZ4RnVDMWxZazcxZkRWczg2L2dVTkVrTmJyTGRLUmE5UjBl?=
 =?utf-8?B?OUc5czFkZlc2YkxENjU0QzcrT0YwcmtqcHVwQUdnbndqL2ZNdVQ1dEt2NWhH?=
 =?utf-8?B?TTF4ckpGOUdzVlcrdXhFekc3anFLV1B2L2I0b3hMYTlSUnAyNDJ5ZUphekVK?=
 =?utf-8?B?YUlHLzBKMmhlc2xJWFN3RmlvdjEwSERBZmhqeC8wTWVZWlpoUXp0dDN4R2RK?=
 =?utf-8?B?OWo1SFlqenVIaDcxUzdjODU5dmRYanprQ09taldWNnJaWm9FODNQYjBCL1FL?=
 =?utf-8?B?RmFqak9oMFRzZlNkODQ4ZUFHUXhENktmV21Wc3VzZzN0Z0thNjhxRjJkcEFF?=
 =?utf-8?B?cm5CSC8ySVZ6VXpFZ2tjSTJOM3pLS002aHZ3NkNneHpoQWpLdW9wekErbmo0?=
 =?utf-8?B?T3NseXhnNGtlVm1hTVVmbzlDM1VrOHlHU0pWcWdPUDB5NEMwRmhWT0VINWN3?=
 =?utf-8?Q?FCXWd7KPV1qAi65jFD10g17n7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6b2fe0-1bcf-4afb-7878-08dd817070cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 07:36:48.4931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUbZN+9F/fP78JX0KQ4DQSXB2aNZZkbWiVBhGQmfcMCWUDPUB2wRQPgcSlIxRUypAq4pZaeyfF9/ZWbZ/FmHQjR2bMgMgssGiHrrQFPSmRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5572
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KDQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyBu
YWJpaGVzdGVmYW5AZ29vZ2xlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEwLzEwXSBk
b2NzL3N5c3RlbS9hcm0vYXNwZWVkOiBTdXBwb3J0IHZib290cm9tIGZvcg0KPiBBU1QyNzAwDQo+
IA0KPiBKYW1pbiwNCj4gDQo+IE9uIDQvMTcvMjUgMDU6MTIsIEphbWluIExpbiB3cm90ZToNCj4g
PiBVc2luZyB0aGUgdmJvb3Ryb20gaW1hZ2Ugc3VwcG9ydCBhbmQgdGhlIGJvb3QgUk9NIGJpbmFy
eSBpcyBub3cgcGFzc2VkDQo+ID4gdmlhIHRoZSAtYmlvcyBvcHRpb24sIHVzaW5nIHRoZSBpbWFn
ZSBsb2NhdGVkIGluDQo+ID4gcGMtYmlvcy9hc3QyN3gwX2Jvb3Ryb20uYmluLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZG9jcy9zeXN0ZW0vYXJtL2FzcGVlZC5yc3QgfCAyOSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9hcm0vYXNw
ZWVkLnJzdCBiL2RvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0DQo+ID4gaW5kZXggOTdmZDZhMGU3
Zi4uYzg3YTJjZjc5NiAxMDA2NDQNCj4gPiAtLS0gYS9kb2NzL3N5c3RlbS9hcm0vYXNwZWVkLnJz
dA0KPiA+ICsrKyBiL2RvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0DQo+ID4gQEAgLTI1MCw3ICsy
NTAsMTQgQEAgdW5kZXIgTGludXgpLCB1c2UgOg0KPiA+ICAgQm9vdGluZyB0aGUgYXN0MjcwMC1l
dmIgbWFjaGluZQ0KPiA+ICAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXg0KPiANCj4g
DQo+IEN1cnJlbnRseSwgd2UgaGF2ZSAyIHNlY3Rpb25zIGZvciB0aGUgQXNwZWVkIGJvYXJkcyA6
DQo+IA0KPiAxLiBBc3BlZWQgZmFtaWx5IGJvYXJkcyAoYXN0MjUwMC1ldmIsIGFzdDI2MDAtZXZi
LCBhc3QyNzAwLWV2YiwgYXN0MjcwMGZjLA0KPiBibGV0Y2hsZXktYm1jLCBmdWppLWJtYywgZmJ5
MzUtYm1jLCBmcDUyODBnMi1ibWMsIGcyMjBhLWJtYywNCj4gcGFsbWV0dG8tYm1jLCBxY29tLWRj
LXNjbS12MS1ibWMsIHFjb20tZmlyZXdvcmstYm1jLCBxdWFudGEtcTcxbC1ibWMsDQo+IHJhaW5p
ZXItYm1jLCByb211bHVzLWJtYywgc29ub3JhcGFzcy1ibWMsIHN1cGVybWljcm94MTEtYm1jLA0K
PiBzdXBlcm1pY3JveDExc3BpLWJtYywgdGlvZ2FwYXNzLWJtYywgd2l0aGVyc3Bvb24tYm1jLCB5
b3NlbWl0ZXYyLWJtYykgMi4NCj4gQXNwZWVkIG1pbmlibWMgZmFtaWx5IGJvYXJkcyAoYXN0MTAz
MC1ldmIpDQo+IA0KPiBUaGUgZmlyc3QgaXMgcXVpdGUgYmlnIGFuZCByZWxhdGl2ZWx5IGNvbnNp
c3RlbnQgZm9yIHRoZSBBU1QyNDAwLCBBU1QyNTAwIGFuZA0KPiBBU1QyNjAwIFNvQ3MuIFNpbmNl
IHRoZSBBU1QyNzAwIFNvQyBib2FyZHMgYm9vdCBkaWZmZXJlbnRseSwgSSB0aGluayBpdCBpcyB0
aW1lDQo+IHRvIGludHJvZHVjZSBhIG5ldyBzZWN0aW9uIGZvciB0aGUgYXN0MjcwMCBtYWNoaW5l
cy4NCj4gDQpUaGFua3MgZm9yIHJldmlldy4NCldpbGwgY3JlYXRlIGEgbmV3IHNlY3Rpb24gZm9y
IHRoZSBBU1QyNzAwLg0KSmFtaW4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4g
DQo+ID4gLUJvb3QgdGhlIEFTVDI3MDAgbWFjaGluZSBmcm9tIHRoZSBmbGFzaCBpbWFnZSwgdXNl
IGFuIE1URCBkcml2ZSA6DQo+ID4gK0Jvb3QgdGhlIEFTVDI3MDAgbWFjaGluZSBmcm9tIHRoZSBm
bGFzaCBpbWFnZS4NCj4gPiArDQo+ID4gK1RoZXJlIGFyZSB0d28gc3VwcG9ydGVkIG1ldGhvZHMg
Zm9yIGJvb3RpbmcgdGhlIEFTVDI3MDAgbWFjaGluZSB3aXRoIGENCj4gZmxhc2ggaW1hZ2U6DQo+
ID4gKw0KPiA+ICtNYW51YWwgYm9vdCB1c2luZyBgYC1kZXZpY2UgbG9hZGVyYGA6DQo+ID4gKw0K
PiA+ICtJdCBjYXVzZXMgYWxsIDQgQ1BVIGNvcmVzIHRvIHN0YXJ0IGV4ZWN1dGlvbiBmcm9tIGFk
ZHJlc3MNCj4gPiArYGAweDQzMDAwMDAwMGBgLCB3aGljaCBjb3JyZXNwb25kcyB0byB0aGUgQkwz
MSBpbWFnZSBsb2FkIGFkZHJlc3MuDQo+ID4NCj4gPiAgIC4uIGNvZGUtYmxvY2s6OiBiYXNoDQo+
ID4NCj4gPiBAQCAtMjcwLDYgKzI3NywyNiBAQCBCb290IHRoZSBBU1QyNzAwIG1hY2hpbmUgZnJv
bSB0aGUgZmxhc2ggaW1hZ2UsDQo+IHVzZSBhbiBNVEQgZHJpdmUgOg0KPiA+ICAgICAgICAgIC1k
cml2ZSBmaWxlPSR7SU1HRElSfS9pbWFnZS1ibWMsZm9ybWF0PXJhdyxpZj1tdGQgXA0KPiA+ICAg
ICAgICAgIC1ub2dyYXBoaWMNCj4gPg0KPiA+ICtCb290IHVzaW5nIGEgdmlydHVhbCBib290IFJP
TSAoYGAtYmlvc2BgKToNCj4gPiArDQo+ID4gK0lmIHVzZXJzIGRvIG5vdCBzcGVjaWZ5IHRoZSBg
YC1iaW9zIG9wdGlvbmBgLCBRRU1VIHdpbGwgYXR0ZW1wdCB0bw0KPiA+ICtsb2FkIHRoZSBkZWZh
dWx0IHZib290cm9tIGltYWdlIGBgYXN0Mjd4MF9ib290cm9tLmJpbmBgIGZyb20gZWl0aGVyDQo+
ID4gK3RoZSBjdXJyZW50IHdvcmtpbmcgZGlyZWN0b3J5IG9yIHRoZSBgYHBjLWJpb3NgYCBkaXJl
Y3Rvcnkgd2l0aGluIHRoZSBRRU1VDQo+IHNvdXJjZSB0cmVlLg0KPiA+ICsNCj4gPiArLi4gY29k
ZS1ibG9jazo6IGJhc2gNCj4gPiArDQo+ID4gKyAgJCBxZW11LXN5c3RlbS1hYXJjaDY0IC1NIGFz
dDI3MDAtZXZiIFwNCj4gPiArICAgICAgLWRyaXZlIGZpbGU9aW1hZ2UtYm1jLGZvcm1hdD1yYXcs
aWY9bXRkIFwNCj4gPiArICAgICAgLW5vZ3JhcGhpYw0KPiA+ICsNCj4gPiArVGhlIGBgLWJpb3Ng
YCBvcHRpb24gYWxsb3dzIHVzZXJzIHRvIHNwZWNpZnkgYSBjdXN0b20gcGF0aCBmb3IgdGhlDQo+
ID4gK3Zib290cm9tIGltYWdlIHRvIGJlIGxvYWRlZCBkdXJpbmcgYm9vdC4gVGhpcyB3aWxsIGxv
YWQgdGhlIHZib290cm9tDQo+ID4gK2ltYWdlIGZyb20gdGhlIHNwZWNpZmllZCBwYXRoIGluIHRo
ZSAke0hPTUV9IGRpcmVjdG9yeS4NCj4gPiArDQo+ID4gKy4uIGNvZGUtYmxvY2s6OiBiYXNoDQo+
ID4gKw0KPiA+ICsgIC1iaW9zICR7SE9NRX0vYXN0Mjd4MF9ib290cm9tLmJpbg0KPiA+ICsNCj4g
PiAgIEFzcGVlZCBtaW5pYm1jIGZhbWlseSBib2FyZHMgKGBgYXN0MTAzMC1ldmJgYCkNCj4gPg0K
PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQo+ID09DQo+ID4NCg0K


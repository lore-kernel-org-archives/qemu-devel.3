Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE17DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 06:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFS09-0005l3-RI; Thu, 15 May 2025 02:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uFS03-0005kU-UP; Thu, 15 May 2025 02:23:24 -0400
Received: from mail-eastasiaazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c400::3] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uFS01-00054q-8Z; Thu, 15 May 2025 02:23:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQAUWg/i9UqtYf2JokpTbYLLE2bcy0dnzl29Yng7NsuKzeBaa7XynT3fSooRkvmjKa5AnHeEMSlQf+1N8PAWDZmwkqZ3kOMqBSv52b0k09FQ/mmnvNb+IlDT8ICzzWJ2g3ksqxv++fRTHsiu3TpfdkyMKJRHvi2Hl1H/+LdRP8M60YSdSYZ+SbJlzVc6LavFuc2dFf23CjMcgmEkpkak7HAMBZ0YahXm6cCj3gRxuxELo61XbmdnsYCnGvxi8msIe2isO1m4FHOms+xrSFDaBmDKdR2MiS7d9KcVY7wfI2gof2HWQqS6QDoU2P2wfzmXm2p95wfnva8Z0LwoAEer7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow6s8fsIXcmNKVM/MMVHnHB4ZICGM2z9HproV/H9Lko=;
 b=A0f6sPaTi9nx2Smf0gxEaAPxaHYNjoZeDCvtqFM8/wr4NFwHQawYRwA+ZzcD9VX18iV97qo/0N9RGf137QD8Uch59mvx+xbZnLjfZYtf6bAxtC932IBHd3Ud6+PkcFfFUizQpn7ZNlbwDKfZ5Xz7nSL3EQ3VHu06HLLhMFuOft3X3pDxy6IDZxKP+T0fb02Gtm7cTAaGShLE7ANWks6vLzUTh2i1slu5zbma81KLMpHaLJL/SPyQxW+e6vbwHOhgOfYpYbvZ8qP0C5XUBXtgzHipYeXNbT0LOwWSH1k/xQRqzI20y9n+cN5xFBz2Lx+tuJnldpm2qXNYVw5h/IK6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow6s8fsIXcmNKVM/MMVHnHB4ZICGM2z9HproV/H9Lko=;
 b=YFsmcWo76GKzTRTehRiyUQQgcrE0nuF/8crgAQHurBQxuplAb+neyimV/C3W/oE8ny2oMiXHJBzYYqidIJRiOsYD1GsOgcNyiBoxnnhNYFl8GH+FkU4ExR2hqXpFNzH4LZMpd3cx+c2kJ2on1i80yuY6cbqrIOPqXT16nK5v9vbhfkFNcq+XmgcJRkRxg+TQS6EdDECVQh/1yGh0gW1QdDTPpLZGIe/RQMNcTK7ClLrfQIrBDqvKSujxq0Pt88ZabPX5qtNlDQf8jg3Ss3sMD6jBq036ArTPaVpeGdqhjWMXJx3OnervR1j4cqTx4CuUZf/Hy5e8Znu6Ng4KH6zrXQ==
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 (2603:1096:820:29::12) by SEZPR06MB7138.apcprd06.prod.outlook.com
 (2603:1096:101:225::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Thu, 15 May
 2025 06:23:08 +0000
Received: from KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a]) by KL1PR0601MB4180.apcprd06.prod.outlook.com
 ([fe80::6fe5:1995:96a2:552a%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 06:23:08 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 3/5] hw/arm/aspeed_ast27x0-fc: Map ca35 memory into
 system memory
Thread-Topic: [PATCH v2 3/5] hw/arm/aspeed_ast27x0-fc: Map ca35 memory into
 system memory
Thread-Index: AQHbxK8ktEuudT7umEyNRCy5cBcUmrPSQVYAgAD4tpA=
Date: Thu, 15 May 2025 06:23:08 +0000
Message-ID: <KL1PR0601MB4180E9F7CE0955D784B3EED98590A@KL1PR0601MB4180.apcprd06.prod.outlook.com>
References: <20250514090354.1461717-1-steven_lee@aspeedtech.com>
 <20250514090354.1461717-4-steven_lee@aspeedtech.com>
 <58fd39ee-0294-4a05-ad5a-76a144a36e91@redhat.com>
In-Reply-To: <58fd39ee-0294-4a05-ad5a-76a144a36e91@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4180:EE_|SEZPR06MB7138:EE_
x-ms-office365-filtering-correlation-id: 499cab7e-cd80-4d8e-15ad-08dd9378f593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QW9pVlZqbVZzU0lqVkZWOGdZSkN6N2tBL1FBdGhhQkN3cXRnVTdIYXVxTjBk?=
 =?utf-8?B?NVRJTXNuQ1NNNXBnYTlYdGRUWXlNeXd6NlNheTNIS21xVis4U2QzeE1SZ3Rx?=
 =?utf-8?B?a0k1VmFoenFub2xqRzRhd0pENTlUa0JYMC84N2RYVklITU9rOWdmZHBGcmpy?=
 =?utf-8?B?aWJ1ZnJtUmlBMlAzWXRBR0ZYeDFBVVFINzdJK292SkJFdlhqelhUOVExM1Q1?=
 =?utf-8?B?clZVK0xsOXJNZE5kN2Q2M0NxRk1OYjJ2eE9uUDlzdnZmNzAxeEhVVHhMb3R0?=
 =?utf-8?B?MnR2eXVEUHoyZWVZdlVwUExHOUFmRzVZQU1iOW5FcnRCTElzRnZKU0lyRzIz?=
 =?utf-8?B?Mk5JZkU1SGF5dEFJOU5UNjBIanlPVlVUT0tWRGh1SElnSDF1N3pWLzFiQjBJ?=
 =?utf-8?B?QUtLazgwVkJ1UUkxR05yUzJRakRnTWhKVkpQV0ZSRElEc2x0akVqOVhDNXJE?=
 =?utf-8?B?ZHpBT0F4Q3N5cFU3MmszU2hRUnhNTVBOZnIycElUOHdRaGJnQlhLRDFBUHJH?=
 =?utf-8?B?cVRFS2J3V1hIeDE0RFliRWgxbU5lRnZvbEVJZno1N2JsdFZJM1p0Y3N4ZzNK?=
 =?utf-8?B?NzJSUWE3eFBzS1RCbHI4WWNIS3JRQ2NuZ0hJdTI3N2wvS0FjSkRDYm4vSVhu?=
 =?utf-8?B?RlZvWG1uSmo3TUt3ZnI1WWU0Z0lxVTAwZWxtK0tXYWNLd3BQQytBTkFnZ291?=
 =?utf-8?B?VGN0TFJnRmxBeFJ4cWNwUGUvaVl0bFllN2NLVktBalJDeWY4eUZTVnFYUHhT?=
 =?utf-8?B?bDJtRUt2TndCYjk1bm5PeEpvaUxSajQwU0RaQytMT2VqOVpHNUhmTHZuT0t4?=
 =?utf-8?B?SXU5OUxZREFuQTR6OUl3Q1FtaUxoRUhtSjc1S0V1Rm8wVXNKQ3dWK2JGcS85?=
 =?utf-8?B?cWxhMmFMa0puUHYyRTBxRVQvam5NSExQcXpSdUV5M2RTTWt3M2lScWJiMk5t?=
 =?utf-8?B?UGI4bXo4K29FT1dRK0cyZHo2Ly8wbUVmUnVlaXlabHcvbUU0NUdhVDZJYk96?=
 =?utf-8?B?U0ZibXdzaGVCOFdlWHgyNXNPYnFtbkhoaFdwY3hzTWFnLzB6RXFBbk5EM2w1?=
 =?utf-8?B?dTh0Vm9nWk5hdTFnWXNiZ1hCcG1MZmxldDBJbWpad3Q1SFp5NlRxYjNwWHVI?=
 =?utf-8?B?ZHdiQWtQZm00aG5zNTFJTWNMYS9hTkJSdGNpekFoSUlnZEJwZ2JXczVEVEJo?=
 =?utf-8?B?SFo5b2ltUDN1czIxeG1ZRVhXQml3cXU1MUV0dEJCYVpGczJ3VWpRVnVOVU1I?=
 =?utf-8?B?TWs4MCs1UCt6bWpwVVJLR1NXSzBVWCt4UzkzYzdhWTR0Qk9XbVRMWWs5T0Jk?=
 =?utf-8?B?QXA3Y3M1Y1AvYVBjK3RlSW9DcEtUcWVZSFFWYlZlL0dZTUkvVzNIeThDdk55?=
 =?utf-8?B?aXlWNE5rNkR2cG5JRVdCUUE2akR5blcxZkk0cHd5emg1Z0FsZWhvTEdKQzZ0?=
 =?utf-8?B?SU81Y0NFbmc2ckV0dEVpWE9YdnJWY0l5ejZKdFRvYUxXcUtCamU5QU9MSlRu?=
 =?utf-8?B?UUFIazlOQnFpaUI3M0dtdDRpSHJFZjRlcmdSTEh6WVZPRUlCY1BWdldsSXhC?=
 =?utf-8?B?bHlpcUpobDExaDMrSDNZblBEYnVjK25HTzBmWnNldE5CR0RCWmlxMDdSNXJX?=
 =?utf-8?B?cVJUenZyLzBpd3lRSmFMSjdqNE5TejMvY1NIR09KUDk0WWl1SVNnandsQ2JC?=
 =?utf-8?B?OFgrM29iYzJac0JUa2NOMTF1R1ZadWdRZThCaGkwRW9qQ3JzWWVsckxraTVL?=
 =?utf-8?B?L3hVdzJHaVNSU3JGb0tyRzVxSWZ3emJIaS9zV00vWjQ3RWlKSW5YYXpMZ29N?=
 =?utf-8?B?eEl3ZHFIZUNsb281aGo2QkFnZVZyMFFoWjJTK2ZSSjcyU1c2bXZ4NEdva2hO?=
 =?utf-8?B?bFQwMXYvQXJPNmU4TVN0c2VZSGxYWWhwVENsZEloTXdqL2FyTEtieXlHdits?=
 =?utf-8?B?S2k3YzQ1eHIwWkFnZzRkWDVBdTJvZTJHTEg3eVJHZG9iSXBQMTBjdkFxaVdh?=
 =?utf-8?B?RTZUdGp0R0FRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4180.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUtkMVJzVzJSOTR1Uk05aGhCb0xsbVdVQ3ZqeGV1SXhNajFlVU9EY3A5ckxa?=
 =?utf-8?B?N1hmL3ZRMzE1Tys0NzlCUThjVjhJTUt0YW9zUWVsbDRGZzE5MVBVSTFhL0VL?=
 =?utf-8?B?clV1emlIeVdlS045emttS0RNRUEzRGNoYmMwY3JYcHVVeTlNSlFLeW82eFpY?=
 =?utf-8?B?WE9rckxxQnRwWDVmS1krY1VwSFh4RnhPNWRza3NFdGJTZGZwYyt6Qlh3WW5h?=
 =?utf-8?B?cEdqSzY2TlNlUUlMeXpOam5nUy9yOEVWUUQ3MDkyRGJYK3F4TGpIOXJuNm1F?=
 =?utf-8?B?N2NZcXBRd1ZSNWZ0UUxtTGJVUGZLVTdteGZkdEdqNXZmWHB1dDdoNm0wcXdj?=
 =?utf-8?B?aWxmSERGUU1XdUcvaG8zU0MwVGJ6c2lYOWg0REVlZnc0K0Y4OWZ1TjhFUEJW?=
 =?utf-8?B?ckwvZlFQRndPNU5VQVo0SE5EOXluMWhaZmJIcysyTTBvYW1PVlhnRGFUbGFH?=
 =?utf-8?B?MFhTVE1GQjlvVnN5clh2cy84bUUvZjgrMXpER0paK2FWbWRRZGVxUXEvS2ov?=
 =?utf-8?B?WXo2cEZNemIzTTM1YzdRZXpvVUU5T2VRdVZLM0FURGRTV1RoZUlyaDllK2hS?=
 =?utf-8?B?aGg4WkVkdTljVFozRUt3RVNDcU4wQUVIcmMwVlhPYWo1U2ZYZ1hjRldzbnM0?=
 =?utf-8?B?MGg2VnFrMy9UTk5ZQmM0STBhSmJVbmQ0SjFBTy9WLzR2SXI5TGorWGE0QXlk?=
 =?utf-8?B?TW9NVjVlQk1LM21wM3FQOVNvMjJNYWNjcFZpeUhNOHQ2NHpxYmZZdkRqSHQv?=
 =?utf-8?B?NXVqUldlNUx0U1d3aVVpV3hPTUZ0TG9ndDB5d2R2SUtjdFBCK2dtZHRMMTFn?=
 =?utf-8?B?dldIZkgxT25YT2Y1TmJSdnZGa2lVMDgyenM0aXRCNHBocmFZVFFBUHhWQi9H?=
 =?utf-8?B?OXA2Ukp5cXN3UjFmbkdFaHNyenVLY2R3eFBoRjRYbTFVYVNzWC9ObUtESkhT?=
 =?utf-8?B?dWpBZXI1YkFxcElDaDV0OE05MmhuNUxHNU4xUkpFT2FYTnFxeEgybFROenZ4?=
 =?utf-8?B?QTBoQ3hxajFPUUlTeE1YYm9XYnVXYUp5b0w4MGdFVTQ2WnR3YlhxajRHMU5I?=
 =?utf-8?B?NTBwTFhSWk41VHRzNmFrQnZTSFB5eUVhbWpCSllXTzNVbFBwS0pvMnJBa3hO?=
 =?utf-8?B?RjRtaFlyTERyUExkdjloazhsc1FPTmVsbHJlL2Z1Wm85YXUvVFBvOWRmUThP?=
 =?utf-8?B?M3ZnMWtrN2VOR1g2WVZNbGxMbFQwM1BaYjJ0aGEvYWhsaHVuUlFyMitFMVBp?=
 =?utf-8?B?bm1BTi9vVWFEaDRZbXFoc244SjJEVkVMUnlOam4wZWJIYTdUdk1Ld2dFMElP?=
 =?utf-8?B?akp5a25vOVN6SU9iNkRTOFoxdXJ2ekZyeE1uSkZpdkFyajk1NnJIbFp1T1BM?=
 =?utf-8?B?Y3dadytMQVBoQVZNOVY5ejJHT3JiMGpqNVpQUmphdXNyUUxMc2FxTXhpbkpj?=
 =?utf-8?B?cW0xY3EzL3l6OEM0eXo3Tm4vVWl5cFZ6ZE1wL051MmJaWWFzRnlnai9DRVhO?=
 =?utf-8?B?bmdhWE1JeFNWQW9hdzA2NzBuZ2tYMTNlb3pSQVJtblg0eTBwem9OZHZ6MUN2?=
 =?utf-8?B?a1pGSnZsU0hSTEZacTZvT1VOR1JJMUE2cnhZYW9VM2lrYktNWXdoNXBLc0ov?=
 =?utf-8?B?Rys3dDEzUFFzaUtraEVHZTQxRHdCejh3YWVVNkRvaUlHUG9ZTElRdG5lbUox?=
 =?utf-8?B?TUNDdEszYVRvYkNWcXplRDVlTEJCZjJra0FTVHZnRElRUERHelNUNE9zTlNX?=
 =?utf-8?B?bVVVaEl3aktKaWVZd0pSeGlVajh1ZWV1THlRNFFJa0x6ZVdycUNhZmticnNK?=
 =?utf-8?B?RWgwUjVVNVdRQzQ2QW04eFhyOWdYMDZ0aTZSTUcwQ2tuMUpNOVN4YnpNTVA4?=
 =?utf-8?B?UGdoUGRNdXE1bmF4SzJ2U013MFJyZ1dycVNQTEtZTFllSkZPbkJIbFpKS2hn?=
 =?utf-8?B?RzR6UjRMT2hhZm94STR5aEZkZVNWOFRUNDhKcXNDSFVOVVVURGFkbTFQUm4x?=
 =?utf-8?B?SUJNN2F1NjA5QUNOY3F2RVJPWU4wa2toQUIrY2oxaFdTQUxaUStiZGtQNUpG?=
 =?utf-8?B?eG9WcFo0eVlpdW1MakFTSFVSRUxYVHVCTWZaUVh3MXhzY1Fsc2lvenFWa3B1?=
 =?utf-8?Q?Fry8vOqUuk/QKLGABM5T5ftKE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4180.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499cab7e-cd80-4d8e-15ad-08dd9378f593
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 06:23:08.1620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzk7KKkEYvBXYeUQmcCfLvjeY39A40cGsKxzqOBJO2k+z3Gm6WkV4PUEGjXnYJhyKr4aQNvdDwBmp17ZSAqksMLjqZAU7MvTOvrjRAIo6qU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7138
Received-SPF: pass client-ip=2a01:111:f403:c400::3;
 envelope-from=steven_lee@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDE0
LCAyMDI1IDExOjMyIFBNDQo+IFRvOiBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2gu
Y29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgVHJveSBM
ZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluDQo+IDxqYW1pbl9saW5AYXNwZWVkdGVj
aC5jb20+OyBBbmRyZXcgSmVmZmVyeQ0KPiA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1Pjsg
Sm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8
cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxx
ZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVj
aC5jb20+OyBsb25nemwyQGxlbm92by5jb207IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bh
c3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzVdIGh3L2FybS9hc3Bl
ZWRfYXN0Mjd4MC1mYzogTWFwIGNhMzUgbWVtb3J5DQo+IGludG8gc3lzdGVtIG1lbW9yeQ0KPiAN
Cj4gSGVsbG8gU3RldmVuLA0KPiANCj4gT24gNS8xNC8yNSAxMTowMywgU3RldmVuIExlZSB3cm90
ZToNCj4gPiBBdHRhY2ggQ0EzNSBtZW1vcnkgdG8gc3lzdGVtX21lbW9yeSB0byBlbnN1cmUgYSB2
YWxpZCBGbGF0Vmlldy4NCj4gPiBXaXRob3V0IHRoaXMsIGRtYV9tZW1vcnlfd3JpdGUoKSB1c2Vk
IGJ5IGZ0Z21hYyBmYWlsIHNpbGVudGx5LCBjYXVzaW5nDQo+ID4gZGhjcCB0byBicmVhayBvbiBh
c3QyNzAwZmMsIGFzIGZsYXR2aWV3X3dyaXRlKCkgcmV0dXJucyBhbiBlcnJvciB3aGVuDQo+ID4g
c3lzdGVtX21lbW9yeSBpcyBlbXB0eS4NCj4gDQo+IFRoZSBjaGFuZ2UgYmVsb3cgZml4ZXMgdGhl
IG5ldHdvcmsgRE1BIHRyYW5zYWN0aW9ucyBpbmRlZWQgYnV0IEkgdGhpbmsgdGhpcw0KPiBjYXNl
IGNhbiBiZSBhZGRyZXNzZWQgZGlmZmVyZW50bHkuDQo+IA0KPiBUaGUgdHJhbnNhY3Rpb25zIG9u
IGFkZHJlc3Nfc3BhY2VfbWVtb3J5IGluIHRoZSBmdGdtYWMxMDAgZGV2aWNlIG1vZGVsDQo+IHNo
b3VsZCBiZSByZXBsYWNlZCBieSB0cmFuc2FjdGlvbnMgb24gYSBsb2NhbCBhZGRyZXNzIHNwYWNl
IHdoaWNoIHdvdWxkIGJlDQo+IGluaXRpYWxpemVkIGZyb20gYSBtZW1vcnkgcmVnaW9uIHBhc3Nl
ZCB0byB0aGUgbW9kZWwgd2l0aCBhIHByb3BlcnR5Lg0KPiBUaGlzIGlzIHZlcnkgc2ltaWxhciB0
byB3aGF0IHdlIGRvIGluIHRoZSBBc3BlZWQgU01DIG1vZGVsLiBTaW5jZSBpdCBpcyBtb3JlDQo+
IHdvcmssIGl0IGNhbiBiZSBhZGRyZXNzZWQgc2VwYXJhdGVseSBhbmQgbGF0ZXIuDQo+IA0KPiBI
b3dldmVyLCBsZXQncyBrZWVwIHRoZSBjaGFuZ2UgYmVsb3cgZm9yIGFsbCBvdGhlciBwbGFjZXMg
d2hpY2ggYXJlIGRpZmZpY3VsdCB0bw0KPiBhZGRyZXNzLCBsaWtlIHJvbV9jaGVja19hbmRfcmVn
aXN0ZXJfcmVzZXQoKS4gVGhlIGNvbW1pdCBzaG91bGQgYmUNCj4gcmVwaHJhc2VkLg0KPiANCg0K
DQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLCBJIHdpbGwgcmV3cml0ZSB0aGUgY29tbWl0IG1l
c3NhZ2UNCg0KUmVnYXJkcywNClN0ZXZlbg0KDQo+IA0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
dGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcv
YXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMgfCAxICsNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1m
Yy5jIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMNCj4gPiBpbmRleCBmZjY0NjA1NjYzLi5j
Y2JhNWZjOGExIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jDQo+
ID4gKysrIGIvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLWZjLmMNCj4gPiBAQCAtNjksNiArNjksNyBA
QCBzdGF0aWMgdm9pZCBhc3QyNzAwZmNfY2EzNV9pbml0KE1hY2hpbmVTdGF0ZQ0KPiA+ICptYWNo
aW5lKQ0KPiA+DQo+ID4gICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0KCZzLT5jYTM1X21lbW9yeSwg
T0JKRUNUKCZzLT5jYTM1KSwNCj4gImNhMzUtbWVtb3J5IiwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgVUlOVDY0X01BWCk7DQo+ID4gKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdp
b24oZ2V0X3N5c3RlbV9tZW1vcnkoKSwgMCwNCj4gPiArICZzLT5jYTM1X21lbW9yeSk7DQo+ID4N
Cj4gPiAgICAgICBpZiAoIW1lbW9yeV9yZWdpb25faW5pdF9yYW0oJnMtPmNhMzVfZHJhbSwgT0JK
RUNUKCZzLT5jYTM1KSwNCj4gImNhMzUtZHJhbSIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEFTVDI3MDBGQ19CTUNfUkFNX1NJWkUsDQo+ID4gJmVycm9yX2Fib3J0KSkg
ew0KDQo=


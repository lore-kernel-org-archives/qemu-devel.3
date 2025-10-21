Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0D0CCD1A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 02:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB1xo-0005q8-2w; Mon, 20 Oct 2025 22:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vB1xk-0005p4-7Y; Mon, 20 Oct 2025 22:19:00 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vB1xf-0005KC-L9; Mon, 20 Oct 2025 22:18:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csxq15/n7xNDyGhS5YDWxvEE3Bk6x2djacxxUs0FHRvkXfqZ+QGhXvMm/g+deSmWPZVyq9ZxdSZDJiviApECI3Jl4RA227THvMdZQVwIMtxDh7hQJBWRfQKzQdLXdVnZT10R8UzTrDtW025DMEFos4cyT3ycRmQxDUt+W15pHX96d7Fuoj0ByF4waElkPrEPyx/cMRpIIPpW3lguotXAF+4h/FzNV8SQQRf0rKhZSxCh+3oPGRkqB+lesIXHpIXC/Gt4ojqURsXBMyf9lTlecg3bh6z6xAnnjvWIz1a8jTpO1xqz2QW32i+z3cEKcmnqcQ6/2dbYV7J2YbYDPp0gRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hdZcTa2RzPCYLZ68tra0IKI7Ldf6j5bStqsRvpFWxU=;
 b=OYWHY/eZ2W9SJVqwOaoCgC3r2Y7jC5ZPAG0KU/QWbnjzg5eXsj61vmxpzuzh1mUXsKYt70CyqC1YdQ55JXrGiNCe9hJJe/QoeAGWjZlY802Z6VRqGFxmkZ+fSr5j8lHuOWFGeohBZ/H+bwh84iFi+59IEucvUY1nt0bb7OBRPkke1B+i0YkJxxPx5uK0BmOpYc1k2ZdKV1fDmQZVSt9HE/7JkLq+TNJdV8FoDJ9BU5yNqoKoh5KhSeJSTbwVlReZBZIQc7IQ6eDSnhrF/KFsJQl4Iv5OUGkXJHCXRM4pfxCamhZeS89mjkbY6zM5tkYCWuAUVzB8QVE/A1oYTwlzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hdZcTa2RzPCYLZ68tra0IKI7Ldf6j5bStqsRvpFWxU=;
 b=cZsVKy48IOpMrllKCmM2kKJqT5Xy9PIsfp9I2J53gYiePA7wzVCe+pvVQpwQ+tx5nIQXmsps671tgf2iuldZCZl8UywPQ0rWE3TfxN+VMk7JNHibKj1c0gyRXGtj7ymMM7wLCT6COcRuW+VM0hEPaTyXq+KCii6VuX++v4/U9nJGpTd0P2BdzWPz1rpARYVax2+BJKoBL0uR3VF7aV54NGAUK9ZJe9Z4NHIIVNt6SebvLExkb/P+ExPSdozdpvyNHYWfZ1rf2ohK0079aiD8hwuNSDeop4wRWAJVC1o1RrR3zQObBb8+kaYw03Giljem/u5bBKnD/hQAVrErRwdcWg==
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com (2603:1096:820:30::6)
 by TYZPR06MB5025.apcprd06.prod.outlook.com (2603:1096:400:1cb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 02:18:42 +0000
Received: from KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156]) by KL1PR0601MB4196.apcprd06.prod.outlook.com
 ([fe80::13a8:12fc:7753:8156%6]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 02:18:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: 'Andrew Jeffery' <andrew@codeconstruct.com.au>, Joel Stanley
 <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Patrick
 Williams <patrick@stwcx.xyz>
Subject: RE: aspeed: Split the machine definition into individual source files
Thread-Topic: aspeed: Split the machine definition into individual source files
Thread-Index: AQHb4PvonkQ5WUYo0k+UuuoQJWjdG7TEwxGggACgzwCABzH94A==
Date: Tue, 21 Oct 2025 02:18:42 +0000
Message-ID: <KL1PR0601MB419628CE287BDF2715845C4BFCF2A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
References: <e2df1ff1-3ce4-4233-b32e-2bc680725c71@kaod.org>
 <KL1PR0601MB41966988C6264D25E6782045FCE9A@KL1PR0601MB4196.apcprd06.prod.outlook.com>
 <965c2eb3-639e-4792-bd8d-f47682099601@kaod.org>
In-Reply-To: <965c2eb3-639e-4792-bd8d-f47682099601@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4196:EE_|TYZPR06MB5025:EE_
x-ms-office365-filtering-correlation-id: 6adf4c93-ea41-4657-0b3e-08de104827ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MzdGN25TS0hjRVlwQmNYK2k5OHFwOVJ6bFV4WlZHcGhxM1NpazFhbEc5MUFS?=
 =?utf-8?B?RTg0OXpNd0NNbnJuMUt1N2lBVTdUV1JBZzVicmd1bThTWnZwM3NnVllUd0Nx?=
 =?utf-8?B?RjZLQmFESTJNNU9vRi9jZGJNa0E1Tm1uaFBZNTAwZXBjTm1DSjhMVWgwU1Nw?=
 =?utf-8?B?bTM0dTNuZ0QwMFNhUHF2VkU3M3VqaVJQSU8rQ2ZSTzdtak9YR2ZlUWVBanN5?=
 =?utf-8?B?Z3JVOW5lWDFzNEw3aXdBelhPZDVySCtvZzM1S1NtakQ2a0ZJYzZvYk5SMjlT?=
 =?utf-8?B?Zk9pOGFoQktMekV3MjVydVk0b1RKNklxenJIZEVXSWV6VTR3T0QrNmoreDg1?=
 =?utf-8?B?RFNOcXBsVjJsSEdZM2xObkxvN0s2R3h3TWlYUndJWlA1c3c2MTQ3UUxlajRX?=
 =?utf-8?B?ZDlGMW9uOGVqQVNPTFplOC9sZDM2Z3lneUY2STZPOFR4MzNZQ3Z5SWpGU0pK?=
 =?utf-8?B?RnhQWHcxQ1l4bVhJSXpCaHM0ZmkvWEptQnY2M2U4a1ZLMzZKVnAyVXV4L0o4?=
 =?utf-8?B?eDdSVHFxRlI4Vi9ESGdOYkJ2eFZQVmRVSDc1ZlJLT3pTVnpPWGhaRlJidldQ?=
 =?utf-8?B?TXdSMFQ5MjJuMkxRUUxJNHJGMTJwRnNFTEUwYzkrSXpra0dYRzNlUElJTytl?=
 =?utf-8?B?b1d1Y0FRWUR4RUFqWVc1bjVUSGpYYkFNU3NzeGZ4empCWVZKV2tIaDJORmhu?=
 =?utf-8?B?eERkTzhHYlIxMERiSkN5TEdENDdBTnJqVlhVYm1xSVRENEx4OUNpODdIYmhJ?=
 =?utf-8?B?L3NTL0FjblUzUVBBMXQxdFRDdklFUTltTi9lM0pMTjVwNFRGeFJSZVczb2o0?=
 =?utf-8?B?eEdZNytJVk9JcnpPQWlNdTdXS1Z2TlRhekdXR1RKU2xkNlhCQTBEbWZlWGM0?=
 =?utf-8?B?bEYvRmpBUkRyZ3p2QnlRaVlQMzBHR0dWRnV2Y1V6VG9PN29zaFNjUHJZWFVK?=
 =?utf-8?B?czdmUkdsRUxvZmFxdWIvUitSQlREdUVLNlplWU9aVElHZEtKYjdxZDZlbFlC?=
 =?utf-8?B?QnRSSmdTV2hDMElIZFMvNSsvU2k2ZllpbzZhanI0UFFWVlZVSlFXYzBhb1pW?=
 =?utf-8?B?MGREQUdlelBFblh6TGExanhKamZWdEJCNGs0TkNkM2xOYjh3VExzVnZ0OERN?=
 =?utf-8?B?U0tJNkt5b0N3UWZSSm5UMUpMTXBPbVV0eG93YzEvWHpiNUNoRUppNnFNNElm?=
 =?utf-8?B?WVJGenNvelpzZ25sVnAydUpKTU9DSHJWdmJHUmpacWt0bnJwWFZ3VGNRL2E1?=
 =?utf-8?B?TXlNM2hoU0pQV0gvUHRodmluZlRUaWRjUi9Qbml1VzhFQ1lDeE8xWXpRYUly?=
 =?utf-8?B?R1p6YStCQnJ0TW1KQ04wR3JxdUpkdW1rcnJwT1N4Q1hLSml2Y3lHbzVtdjZG?=
 =?utf-8?B?aHJ4ZkVicWUvWmsyOVBNYzRhMzBZak43cUFKcjBkUkF2WG9sRCtESG15TnNu?=
 =?utf-8?B?bWcxMW1sanN5aXdZcGI1b04rbSsyRldBME5Kc3crc25IN0lBeGdjZFl3b0RC?=
 =?utf-8?B?Skc4RzU4NVdCMS9jSUpUTkcxanlKUURwMEwwalhRaG41bGs3UG42bXU2RVBJ?=
 =?utf-8?B?V0xQeXJXSFR6aUdyU0xFcmJvVDB6QS9lWGhzYk5VZndWN1ZZOU9OOVhHbTY2?=
 =?utf-8?B?SjY0eTJ6RCtzZGpJSmhiT1FBSUFTbnlaYjgralppdWJ4N3o1OGlFbnJBVitU?=
 =?utf-8?B?TktkWVY3d0EycTQ5QXNqZVZVTjRWUHo2YkNuY3VIY3pVZWhadHBIS29tLzFI?=
 =?utf-8?B?N29KS3FKcFJYQ1k0ck5Wc0phaDZvckdMZjFzSndSdVpqMjVaZzE3d1J4MTll?=
 =?utf-8?B?M2lxclAvVGpVMlBQdjJsaU02a01HdWRpbUdMaERsMzh5cm1CWDlDZFNKVGRM?=
 =?utf-8?B?NzhKck1OS1FFd2lTRm9Fd2w3WnlwajVvUlRUNnlUME5BYTA0ZWpWK3NNblNi?=
 =?utf-8?B?dFpWdnVZdFdpN043V1pnU1pWL2dZeElnakJrZklyalhPVmI2UHFPSHBiOC9U?=
 =?utf-8?B?NVI0a1N6bVhzRTNsalcvQ1FvY3NnKzZFRmZkMU16cktqZUpMekwzVWdlSjcx?=
 =?utf-8?Q?ddvG1N?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR0601MB4196.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czRzc0FsdndFck5yYzhqdWNFS3duRFRnUkNqNTZkMHZGeWpkMTZldFFsUXdi?=
 =?utf-8?B?cGdaQXYzMjY0N0pVNStTT1o0bnhIdENvTlhwdFV4ekt6OFRGZ094ckZrOUtv?=
 =?utf-8?B?dUMrM1lIRjZEeTVJc29mbjl1U2k3TGptbDV5V3VYMTlOdGQ5c3BqWGF6NmhI?=
 =?utf-8?B?M04ybzNWM2pKZXdWT09yZ0NrNGlFZ25TVW0xc3lUSnpyYTZnOWZnVUNKOXVB?=
 =?utf-8?B?K09UVjlPV1draGhuR0xZWFVaWWZSaUV6RGsrUTZpdlRpWGFZQk42YWplLytE?=
 =?utf-8?B?N1Z2QW5zZ0lYOW9ReFN3eDdFVXRqczN5bnJWUm12b1AwMy9ETm9ONWltRGFz?=
 =?utf-8?B?WUdkcUs3MkNsbzdLUGc4ZC91UDdycGJtWkoyaGxPd2o1dXFxbnlSdjl5VDc3?=
 =?utf-8?B?c00xaHRycVkzakUzWXhyZ0pkVHh4Y2NNUmx0WE9wTlAyR2JhWDBpOERudGVl?=
 =?utf-8?B?S3lKTnNoMFZINjd5cHlRQ0xvSFNib25Ca1hWQjR6by9LVTFVMkdmZkpsSHVp?=
 =?utf-8?B?ZnRRWVZGQnMrMWExbVJnT2wzKzFadDQrWEJETmQrbDNLRWJyQ3kxL3Y0VnM3?=
 =?utf-8?B?STA1TnF5aTVsVjE4UjBXN2FJQlZkTDFQbitqSE9IVGtHWEdjcnNMVXc1ZU1C?=
 =?utf-8?B?SndOM3JaL2M1VmV2UlJ1TDIwaHdyQ2tRTk02TURjS2xQRzZIVk9YNFhFbkh3?=
 =?utf-8?B?NEVrSVZPaGEyYWVnRXArQ1daVVd2R0g4MktPazBFczdBdWZDdWZPNlRwbFRz?=
 =?utf-8?B?NWY5TTBDNkNSU1BSR2FDU29zNUh3NHd1VGNJa2hpR1ByeUhhZUs5bHVRNkJI?=
 =?utf-8?B?dks0eFRRR1RXcllBMFFWRzFST1FUMG5WMFpBc05yRkR2UzZpY1E2MEQxOERE?=
 =?utf-8?B?eTgwZkl5NzJVS3E5dmF1R0tqNlJtNlUwNkJNSE9LY3o0SUFjdnQ2bzUvN0RB?=
 =?utf-8?B?TnNKSUowdGtoU05NNkFIM0JRNzRPaDA5ZXdac3ZtU0JsWFJlSy85M0lhYklK?=
 =?utf-8?B?N21qNkV4NWdYRGhUdkFYM29pbE9aNi9pdkZNZnQ1TmZMQzh2MjVLaXNCd0w1?=
 =?utf-8?B?NlhReDlOYUZScE1tcXY0cDRXZFUxM2JIMDdYemx0YkpzR1dLOVpBK1lBRkJj?=
 =?utf-8?B?NllVYVF3enArc0xhaHVFU3ZGS1pjek5seklXWjNHcTI0Z3hzU1RIUWF0d3hj?=
 =?utf-8?B?SEgrQnZPdjB4MDhrNExxYTR2RnlaQWYvR2tKRUpiM0FsUWV1TUFybEJOL2w1?=
 =?utf-8?B?dmNrL2Y5OFF5OWM4cE1mQmkrNFU0Nk41SnhvZDBoYk82VHpYZ2EvS3JCV3Yx?=
 =?utf-8?B?QnZ2UERabU5yNHNGeEpPZ3R0YTdRTXV1dmRHMUMxdXhJTWRSTWhnTUJWUWtZ?=
 =?utf-8?B?aWZyV0ZmeElka1VtRzRwUTM1Slo3cDM0bHBhNjRFUHprSmM2YmkvSjJTbzVp?=
 =?utf-8?B?cUZIOEdkM1l5aVFiSXVyY1Y0NDhucDVXVWtKNS9wd1RvT1poUGxEeEkxWVJB?=
 =?utf-8?B?MU0rTHg1VUNCa05LdHR1dHRxQ2xMclgzdndGS3h6T0d5T1M1ODh0QlRtVDBr?=
 =?utf-8?B?NjI3dG0yUkh4WnJuWjRlVHd0U1ZpeU1hWmJoL2N1YTRGR3FPaU1iVTFzZmd6?=
 =?utf-8?B?amZxUWNzTGtIbzR2OVl1bVZxdWdGMDdxTGYrdkNhT1pUY2pZMmdhUEJJM2FO?=
 =?utf-8?B?dlNuR0hRT0tuSlhlR2NIZ0xjdGFiZ0VGaXoyQktONnJSUVVaOS9EZ3I4Mmd3?=
 =?utf-8?B?dWdkbHcvamNCQjYyUWxQYitORCtvWEllZ2VZM1NOQzVOSnRmektnWVdZYmJH?=
 =?utf-8?B?WjgwOGJjQno0anJyZUtGdXFnUXc1U0pzK1BJY1ZqandvRlVhZEI5dnhLM0Iw?=
 =?utf-8?B?TWZmbXIzb0lkaUlWMHZDUE1XbHNBRnVGTlpDM2RUbllqL0ZnRFFnWnZuaFhk?=
 =?utf-8?B?cnVXdk9sMW5DNnBLZno2WGtGdTlqVDBJVUpsVUw2TDg2bm9UNWdpMVNpRFRK?=
 =?utf-8?B?QnFiYVhyN056b1JvVDd2dmVWbmREYU1CUzlwY1ZseDZxZFZSWVNIcittaTRp?=
 =?utf-8?B?S1M2VWo2K05lMml0OTVaSDNORGRyQTBPMmVFeWdqaVZvRTJHR2Y1dWo2KzN5?=
 =?utf-8?Q?M9kur/Fk841BUWuk2wpgMSgo4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4196.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adf4c93-ea41-4657-0b3e-08de104827ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 02:18:42.2342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Js5wxcT/05PWO4rPKINKdFV2qNi/6XNSR7hJtPChNIqM2Ub/o0g+RuRrrExVHpyyOLtQrnb+Bqxcd2tX3W8NUcBTSLUF+rveNiRPBO4Phaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5025
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywgDQoNCj4gU3ViamVjdDogUmU6IGFzcGVlZDogU3BsaXQgdGhlIG1hY2hpbmUg
ZGVmaW5pdGlvbiBpbnRvIGluZGl2aWR1YWwgc291cmNlIGZpbGVzDQo+IA0KPiBPbiAxMC8xNi8y
NSAwNDozMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIGFsbA0KPiA+DQo+ID4+IFN1YmplY3Q6
IGFzcGVlZDogU3BsaXQgdGhlIG1hY2hpbmUgZGVmaW5pdGlvbiBpbnRvIGluZGl2aWR1YWwgc291
cmNlDQo+ID4+IGZpbGVzDQo+ID4+DQo+ID4+IEhpLA0KPiA+Pg0KPiA+PiBUaGlzIGlzIGEgZm9s
bG93IHVwIG9mIGEgcHJpdmF0ZSBkaXNjdXNzaW9uIHdpdGggUGF0cmljay4NCj4gPj4NCj4gPj4g
QXNwZWVkIG1vZGVsaW5nIHN0YXJ0ZWQgbmVhcmx5IDEweSBhZ28gd2l0aCB0aGUgcGFsbWV0dG8t
Ym1jIG1hY2hpbmUuDQo+ID4+IFdlIG5vdyBoYXZlIDUgU29DcyBhbmQgMjUgbWFjaGluZXMgd2hp
Y2ggYXJlIG1vc3RseSBkZWZpbmVkIGluIGluIGENCj4gPj4gc2luZ2xlIGFzcGVlZC5jIGZpbGUu
IE11bHRpIFNvQyBtYWNoaW5lcywgZmJ5MzUgYW5kIGFzdDI3MDBmYywgYXJlDQo+ID4+IGRlZmlu
ZWQgaW4gZmJ5MzUuYyBhbmQgYXNwZWVkX2FzdDI3eDAtZmMuYyByZXNwZWN0aXZlbHkuDQo+ID4+
DQo+ID4+IFNpbmNlIHdlIHN0YXJ0ZWQgc2VwYXJhdGluZyB0aGUgU29DcyA6DQo+ID4+DQo+ID4+
ICAgICBody9hcm0vYXNwZWVkX2FzdDEweDAuYw0KPiA+PiAgICAgaHcvYXJtL2FzcGVlZF9hc3Qy
NDAwLmMNCj4gPj4gICAgIGh3L2FybS9hc3BlZWRfYXN0MjYwMC5jDQo+ID4+ICAgICBody9hcm0v
YXNwZWVkX2FzdDI3eDAuYw0KPiA+PiAgICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXNzcC5jDQo+
ID4+ICAgICBody9hcm0vYXNwZWVkX2FzdDI3eDAtdHNwLmMNCj4gPj4NCj4gPj4gV2UgY291bGQg
ZG8gdGhlIHNhbWUgZm9yIHRoZSBtYWNoaW5lcyBrZWVwaW5nIGFuICdhc3BlZWRfYXN0PHJldj4n
DQo+ID4+IHByZWZpeCAoYW5kIG1heWJlIGF2b2lkIHRoZSAnYm1jJyBzdWZmaXgpLiBJIHRoaW5r
IHRoaXMgd291bGQgZWFzZQ0KPiA+PiBpbnRyb2R1Y3Rpb24gb2YgbmV3IG1hY2hpbmVzLiBXZSB3
b3VsZCBiZSBhYmxlIHRvIGdldCByaWQgb2YNCj4gPj4gYXNwZWVkX2VlcHJvbS5bY2hdIGFuZCBt
b3ZlIG1hY2hpbmUgY3VzdG9tIGRhdGEgaW4gdGhlIG1hY2hpbmUgc291cmNlDQo+IGZpbGUuIFdo
aWNoIHNlZW1zIGNsZWFuZXIuDQo+ID4+DQo+ID4+IFRpbWluZyBpcyBhYm91dCByaWdodCBmb3Ig
Y29kZSByZXNodWZmbGluZywgc3RpbGwgM3cgYmVmb3JlIHNvZnQNCj4gPj4gZnJlZXplLCBubyBp
bXBvcnRhbnQgY2hhbmdlcyBpbmZsaWdodCwgYnV0IGlmIHdlIHN0YXJ0IGRvaW5nIHRoaXMNCj4g
Pj4gY29udmVyc2lvbiwgd2Ugc2hvdWxkIGRvIGl0IGZvciBhbGwuIFNlZSB0aGUgbGlzdCBiZWxv
dyBmb3IgdGhlIGJyYXZlLg0KPiA+Pg0KPiA+PiBDb21tZW50cyA/DQo+ID4+DQo+ID4+IFRoYW5r
cywNCj4gPj4NCj4gPj4gQy4NCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4gKiBBU1QyNDAwDQo+ID4+
DQo+ID4+ICAgICBwYWxtZXR0by1ibWMNCj4gPj4gICAgIHF1YW50YS1xNzFsLWJtYw0KPiA+PiAg
ICAgc3VwZXJtaWNyb3gxMS1ibWMNCj4gPj4NCj4gPj4gKiBBU1QyNTAwDQo+ID4+DQo+ID4+ICAg
ICBhc3QyNTAwLWV2Yg0KPiA+PiAgICAgcm9tdWx1cy1ibWMNCj4gPj4gICAgIHNvbm9yYXBhc3Mt
Ym1jDQo+ID4+ICAgICB3aXRoZXJzcG9vbi1ibWMNCj4gPj4gICAgIHlvc2VtaXRldjItYm1jDQo+
ID4+ICAgICBzdXBlcm1pY3JvLXgxMXNwaS1ibWMNCj4gPj4gICAgIGZwNTI4MGcyLWJtYw0KPiA+
PiAgICAgZzIyMGEtYm1jDQo+ID4+ICAgICB0aW9nYXBhc3MtYm1jDQo+ID4+DQo+ID4+ICogQVNU
MjYwMA0KPiA+Pg0KPiA+PiAgICAgYXN0MjYwMC1ldmINCj4gPj4gICAgIHFjb20tZGMtc2NtLXYx
LWJtYw0KPiA+PiAgICAgcWNvbS1maXJld29yay1ibWMNCj4gPj4gICAgIHJhaW5pZXItYm1jDQo+
ID4+ICAgICBmdWppLWJtYw0KPiA+PiAgICAgYmxldGNobGV5LWJtYw0KPiA+PiAgICAgZmJ5MzUt
Ym1jICAgICAgICAgICAoZmJ5MzUuYyBzaG91bGQgcmVuYW1lIHRvDQo+ID4+IGFzcGVlZF9hc3Qy
NjAwLWZieTM1LmMpDQo+ID4+DQo+ID4+ICogQVNUMjcwMA0KPiA+Pg0KPiA+PiAgICAgYXN0Mjcw
MGEwLWV2Yg0KPiA+PiAgICAgYXN0MjcwMGExLWV2Yg0KPiA+PiAgICAgYXN0MjcwMGZjICAgICAg
ICAgICAoYXNwZWVkX2FzdDI3eDAtZmMuYykNCj4gPj4NCj4gPj4gKiBBU1QxMDMwDQo+ID4+DQo+
ID4+ICAgICBhc3QxMDMwLWV2Yg0KPiA+DQo+ID4NCj4gPiBJ4oCZdmUgc3RhcnRlZCB3b3JraW5n
IG9uIHRoaXMgcmVmYWN0b3JpbmcgYW5kIGhhdmUgc2VudCB0aGUgZmlyc3QgcGF0Y2ggZm9yIHRo
ZQ0KPiBBU1QxMDMwOg0KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9x
ZW11LWRldmVsL3BhdGNoLzIwMjUxMDE1MDgxMjE5LjINCj4gPiA3NjYxNDMtMi1qYW1pbl9saW5A
YXNwZWVkdGVjaC5jb20vDQo+ID4gSeKAmW0gZG9pbmcgdGhpcyBiZWNhdXNlIEkgcGxhbiB0byBh
ZGQgYSBuZXcgbWFjaGluZSBmb3IgdGhlIEFTVDEwNjAsIGFuZCBpdA0KPiBzZWVtcyBsaWtlIGEg
Z29vZCBvcHBvcnR1bml0eSB0byBwZXJmb3JtIHRoaXMgY2xlYW51cCBmaXJzdC4NCj4gPiBJIGp1
c3Qgd2FudCB0byBtYWtlIHN1cmUgSeKAmW0gbW92aW5nIGluIHRoZSByaWdodCBkaXJlY3Rpb24g
4oCUIGNvdWxkIHlvdSBwbGVhc2UNCj4gaGVscCByZXZpZXcgaXQ/DQo+ID4NCj4gPiBJZiB5b3Ug
YWdyZWUgd2l0aCB0aGUgZm9sbG93aW5nIHBsYW4sIEnigJlsbCBjcmVhdGUgYSBuZXcgcGF0Y2gg
c2VyaWVzIHRvIG1vdmUNCj4gYWxsIGV4aXN0aW5nIG1hY2hpbmVzIGludG8gc2VwYXJhdGUgYXNw
ZWVkX2FzdDxyZXY+X2JvYXJkcy5jIGZpbGVzOg0KPiA+ID4gUGxhbm5lZCBzdHJ1Y3R1cmUNCj4g
PiBDcmVhdGUgYXNwZWVkX2FzdDEweDBfYm9hcmRzLmMNCj4gPiAgIGFzdDEwMzAtZXZiDQo+ID4N
Cj4gPiBDcmVhdGUgYXNwZWVkX2FzdDI0MDBfYm9hcmRzLmMNCj4gPiAgICBwYWxtZXR0by1ibWMN
Cj4gPiAgICBxdWFudGEtcTcxbC1ibWMNCj4gPiAgICBzdXBlcm1pY3JveDExLWJtYw0KPiA+DQo+
ID4gQ3JlYXRlIGFzcGVlZF9hc3QyNTAwX2JvYXJkcy5jDQo+ID4gKE9yIHNob3VsZCB0aGVzZSBi
ZSBncm91cGVkIHdpdGggYXNwZWVkX2FzdDI0MDBfYm9hcmRzLmM/IOKAlCBJ4oCZZA0KPiA+IGFw
cHJlY2lhdGUgeW91ciB0aG91Z2h0cy4pDQo+IA0KPiBuby4gSSdkIHByZWZlciBrZWVwaW5nIGEg
Y29uc2lzdGVudCAnYXNwZWVkX2FzdDxyZXY+JyBwcmVmaXguDQo+IA0KPiA+ICAgYXN0MjUwMC1l
dmINCj4gPiAgIHJvbXVsdXMtYm1jDQo+ID4gICBzb25vcmFwYXNzLWJtYw0KPiA+ICAgd2l0aGVy
c3Bvb24tYm1jDQo+ID4gICB5b3NlbWl0ZXYyLWJtYw0KPiA+ICAgc3VwZXJtaWNyby14MTFzcGkt
Ym1jDQo+ID4gICBmcDUyODBnMi1ibWMNCj4gPiAgIGcyMjBhLWJtYw0KPiA+ICAgdGlvZ2FwYXNz
LWJtYw0KPiA+DQo+ID4gQ3JlYXRlIGFzcGVlZF9hc3QyNjAwX2JvYXJkcy5jDQo+ID4gICBhc3Qy
NjAwLWV2Yg0KPiA+ICAgcWNvbS1kYy1zY20tdjEtYm1jDQo+ID4gICBxY29tLWZpcmV3b3JrLWJt
Yw0KPiA+ICAgcmFpbmllci1ibWMNCj4gPiAgIGZ1amktYm1jDQo+ID4gICBibGV0Y2hsZXktYm1j
DQo+ID4NCj4gPiBSZW5hbWUNCj4gPiBmYnkzNS5jIC0+IGFzcGVlZF9hc3QyNjAwLWZieTM1LmMN
Cj4gPiAgIGZieTM1LWJtYw0KPiA+DQo+ID4gQ3JlYXRlIGFzcGVlZF9hc3QyN3gwX2JvYXJkLmMN
Cj4gPiAgICAgIGFzdDI3MDBhMC1ldmINCj4gPiAgICAgIGFzdDI3MDBhMS1ldmINCj4gPg0KPiA+
IEtlZXANCj4gPiBhc3BlZWRfYXN0Mjd4MC1mYy5jDQo+ID4gICAgYXN0MjcwMGZjDQo+ID4NCj4g
Pg0KPiA+IE9uZSBsYXN0IHF1ZXN0aW9uDQo+ID4gRG8geW91IHRoaW5rIGl04oCZcyBiZXR0ZXIg
dG86DQo+ID4gQ3JlYXRlIG9uZSBjb21taXQgcGVyIFNvQyBnZW5lcmF0aW9uIChlLmcuIG9uZSBm
b3IgYWxsIEFTVDI1MDAtYmFzZWQNCj4gPiBtYWNoaW5lcyksIG9yIENyZWF0ZSBvbmUgY29tbWl0
IHBlciBib2FyZCAoZS5nLiBvbmUgZm9yIGFzdDI1MDAtZXZiLA0KPiA+IG9uZSBmb3Igcm9tdWx1
cy1ibWMsIGV0Yy4pPw0KPiANCj4gT25lIHBlciBtYWNoaW5lL2JvYXJkIHBsZWFzZS4NCj4gDQo+
IEluaXRpYWxseSwgSSB0aG91Z2h0IHdlIHdvdWxkIGludHJvZHVjZSBvbmUgJ2FzcGVlZF9hc3Q8
cmV2Pl88Ym9hcmQ+LmMnDQo+IGZpbGUgcGVyIG1hY2hpbmUvYm9hcmQgYnV0IHRoYXQgbWlnaHQg
YmUgdG9vIGludHJ1c2l2ZS4gQXQgdGhlIHNhbWUgdGltZSwgaXQNCj4gd291bGQgcHJvdmlkZSBh
IGNsZWFyIHZpZXcgb2YgaG93IG1hbnkgYm9hcmRzIFFFTVUgbW9kZWxzIGZvciBlYWNoIFNvQw0K
PiByZXZpc2lvbi4gV2hhdCBkbyB5b3UgdGhpbmsgPw0KPiANCj4gDQo+IEV2ZW50dWFsbHksIGZp
bGUgJ2FzcGVlZF9lZXByb20uYycgd291bGQgYmUgcmVtb3ZlZCwgc28gd291bGQgZmlsZSAnYXNw
ZWVkLmMnLg0KPiAnYXNwZWVkX2NvcHJvY2Vzc29yX2NvbW1vbi5jJyBzaG91bGQgcHJvYmFibHkg
YmUgcmVuYW1lZC4NCj4gRmlsZSAnYXNwZWVkX3NvY19jb21tb24uYycgc2hvdWxkIGJlY29tZSAn
YXNwZWVkX2NvbW1vbi5jJyBwcm9iYWJseS4NCj4gDQoNCkkgcGxhbiB0byBzdWJtaXQgdGhlIGZv
bGxvd2luZyBwYXRjaCBzZXJpZXMgdG8gaW1wbGVtZW50IHRoZXNlIGNoYW5nZXMuDQoNClBhdGNo
IHNlcmllcyAxDQpody9hcm0vYXNwZWVkX2FzdDEwMzBfZXZiLmMgKGFzdDEwMzAtZXZiKSAtLS0+
IG9yIGh3L2FybS9hc3BlZWRfYXN0MTB4MF9ldmIuYywgdGhlbiB3ZSBjYW4gcGxhY2UgKGFzdDEw
MzAtZXZiIGFuZCBhc3QxMDYwLWV2YikNCmh3L2FybS9hc3BlZWRfYXN0Mjd4MF9ldmIuYyAoYXN0
MjcwMGEwLWV2YiwgYXN0MjcwMGExLWV2YikNCg0KUGF0Y2ggc2VyaWVzIDINCmh3L2FybS9hc3Bl
ZWRfYXN0MjQwMF9wYWxtZXR0by5jIChwYWxtZXR0by1ibWMpDQpody9hcm0vYXNwZWVkX2FzdDI0
MDBfcXVhbnRhLXE3MWwuYyAocXVhbnRhLXE3MWwtYm1jKQ0KaHcvYXJtL2FzcGVlZF9hc3QyNDAw
X3N1cGVybWljcm94MTEuYyAoc3VwZXJtaWNyb3gxMS1ibWMpDQoNClBhdGNoIHNlcmllcyAzDQpo
dy9hcm0vYXNwZWVkX2FzdDI1MDBfZXZiLmMgKGFzdDI1MDAtZXZiKQ0KaHcvYXJtL2FzcGVlZF9h
c3QyNTAwX3JvbXVsdXMuYyAocm9tdWx1cy1ibWMpDQpody9hcm0vYXNwZWVkX2FzdDI1MDBfc29u
b3JhcGFzcy5jIChzb25vcmFwYXNzLWJtYykNCmh3L2FybS9hc3BlZWRfYXN0MjUwMF93aXRoZXJz
cG9vbi5jICh3aXRoZXJzcG9vbi1ibWMpDQpody9hcm0vYXNwZWVkX2FzdDI1MDBfeW9zZW1pdGV2
Mi5jICh5b3NlbWl0ZXYyLWJtYykNCmh3L2FybS9hc3BlZWRfYXN0MjUwMF9zdXBlcm1pY3JvLXgx
MXNwaS5jIChzdXBlcm1pY3JvLXgxMXNwaS1ibWMpDQpody9hcm0vYXNwZWVkX2FzdDI1MDBfZnA1
MjgwZzIuYyAoZnA1MjgwZzItYm1jKQ0KaHcvYXJtL2FzcGVlZF9hc3QyNTAwX2cyMjBhLmMgKGcy
MjBhLWJtYykNCmh3L2FybS9hc3BlZWRfYXN0MjUwMF90aW9nYXBhc3MuYyAodGlvZ2FwYXNzLWJt
YykNCg0KUGF0Y2ggc2VyaWVzIDQNCmh3L2FybS9hc3BlZWRfYXN0MjYwMF9ldmIuYyAoYXN0MjYw
MC1ldmIpDQpody9hcm0vYXNwZWVkX2FzdDI2MDBfcWNvbS1kYy1zY20tdjEuYyAocWNvbS1kYy1z
Y20tdjEtYiBtYykNCmh3L2FybS9hc3BlZWRfYXN0MjYwMF9xY29tLWZpcmV3b3JrLWJtYy5jIChx
Y29tLWZpcmV3b3JrLWJtYykNCmh3L2FybS9hc3BlZWRfYXN0MjYwMF9yYWluaWVyLmMgKHJhaW5p
ZXItYm1jKQ0KaHcvYXJtL2FzcGVlZF9hc3QyNjAwX2Z1amkuYyAoZnVqaS1ibWMpDQpody9hcm0v
YXNwZWVkX2FzdDI2MDBfYmxldGNobGV5LmMgKGJsZXRjaGxleS1ibWMpDQpody9hcm0vYXNwZWVk
X2FzdDI2MDBfIGZieTM1LmMgKGZieTM1LWJtYykNCg0KRm9yIHRoZSBGQlkzNSBwbGF0Zm9ybSwg
c2luY2UgaXQgaW5jbHVkZXMgYm90aCBBU1QxMDMwIGFuZCBBU1QyNjAwLCB3ZSBtYXkgY29uc2lk
ZXIgcmVuYW1pbmcgdGhlIGZpbGUgdG86DQpody9hcm0vYXNwZWVkX2FzdDEwMzBfYXN0MjYwMF9m
YnkzNS5jICAoaHcvYXJtL2ZieTM1LmMpDQoNCldlIHdpbGwga2VlcCB0aGUgZm9sbG93aW5nIGZp
bGUgYXMgaXM6DQpody9hcm0vYXNwZWVkX2FzdDI3eDAtZmMuYyAoYXN0MjcwMGZjKQ0KDQpUaGFu
a3MsDQpKYW1pbg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCg0K


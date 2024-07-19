Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DCCC3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc9g-0008Ti-UY; Thu, 18 Jul 2024 21:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUc9f-0008O9-3V; Thu, 18 Jul 2024 21:11:27 -0400
Received: from mail-sgaapc01on20713.outbound.protection.outlook.com
 ([2a01:111:f400:feab::713]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUc9c-0002Dt-63; Thu, 18 Jul 2024 21:11:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgQwolosTPu+5JpdejEeQpZW44jTVXTqUyaShaAi6MaCDwzx0npFC2rsGi0URRGNeEarRb0GqkjfrxzKuPZYT+mp3LoiDoFDyLgJqLFl9dB026ditm7JHlOBUYqf8mWOpaiyZA4kasgFR3+obMNbLhqcC6OQt4VmFF+trh9OuPoo2ol2GVgIUS2L03ioXxJpPi8fQi8UvIm98FPxt/7/hPkFQ+mTTNR1iB6ewRXEctTU9ZrtnAp9kCVAGCxXMxd/uY0gXFepNCu4dYJ2DRtqawK14D9xfIU3Y1U6cHHzpPTg041ekdvhVk9iipy5p7co5X8QE8sBuPN0Zim0hThrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmfnAFLv+GM8CmxX5D1XalfOALS+YW+wdcoF7cE6Sis=;
 b=hjPhAP2IO9wTpIqtTnErUdb2PwVJK+dkkwNHbstS/uQ7+QdFz49WQsP2+ksalYxdNVmQBRp4go+ROZslaxSdYvnwc8Z3JMdIaow78tC2QNCjlmwAtaECtvhYQei1BrAnaT2j+F5W94mEn4PMxOq4ZwSrY4d3L7mEmToHl2av8p0gSQrYpSoxrzQu2jJk253Pe1QxUAZYABh3HvmjF0HcAyXmVU98r8fAJpHbA4ROUnVIFTlW1xeMs6uScvA053w9XYiIZtwmydV/m1HvLtw93sHk2cY7O7LNaNZiHpGoXGXZ6Oq9VB2W+aHoy8WEQ6vsXm+nxz+OYzpP184OdB4NnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmfnAFLv+GM8CmxX5D1XalfOALS+YW+wdcoF7cE6Sis=;
 b=idtoF98ytcxPPIOw7HCSqwPzgt51wUKJh/Fm8NbDZHHRQaPkKBEP70OT3x7B0jNKNysq++DZvqMC6c6IDSbt1RxB6qAkaqESPp6j6eymErz2fuPDclleXhue5jvrTGhUAwGtmVz4ycIa45oEstgHgiYHuRhRiLMad6wD0bmmjlAEG60qct9NKkOPrlae02G0P/Tl/fRXDnf4PFQzL4xAXYtd53TVbPjnSvwrPxKseieyUK0Ctq+hv4V9fkjRrWD0YOB//+p4VC1/lZAuEpyzKbOAKYOYK59Wmb6m0nvutmrE2//KDF8/6+uNPIqWt2GeiVNgFU3T2f4aIhV2UwoFDg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB7274.apcprd06.prod.outlook.com (2603:1096:405:ab::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.18; Fri, 19 Jul 2024 01:11:13 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 01:11:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Alistair Francis
 <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 03/15] hw/i2c/aspeed: support to set the different
 memory size
Thread-Topic: [PATCH v1 03/15] hw/i2c/aspeed: support to set the different
 memory size
Thread-Index: AQHa2N7EjNjdflIlaU+vGz4Ys7QZsLH8HzuAgAAau6CAAD6gAIAAxplg
Date: Fri, 19 Jul 2024 01:11:13 +0000
Message-ID: <SI2PR06MB50412C180B0C364D1865BE0AFCAD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-4-jamin_lin@aspeedtech.com>
 <311c3893-4e27-4472-8356-889fdaaade6f@kaod.org>
 <SI2PR06MB5041287D9E64F7D0E25968EEFCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <5f6efa7b-0ed9-4cf3-b8e5-b6b0656394fd@kaod.org>
In-Reply-To: <5f6efa7b-0ed9-4cf3-b8e5-b6b0656394fd@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB7274:EE_
x-ms-office365-filtering-correlation-id: 09e3488f-76ce-498f-7239-08dca78faebb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MkkwNVB6WmpWZ3hyTHpNdWJGbUVieVJNNS8rN1RoTzhsakc2UXNlcmNOajNq?=
 =?utf-8?B?WEx3MkpSR1o4SHpicFAxL1pPN3lPY21GM0tNbnFXd0l3R1dHUkEwM29yTExn?=
 =?utf-8?B?NjNyRXNJU3pPUVYxNXRPdXk4NjZRNzI3NXVCOGNoaHdjeGI1NmprU1F6S1Za?=
 =?utf-8?B?OEtaQm90RU9peGFiR1lQcUJldVhkOVBidDNEM0FqL2g0WlRyeHBsRkZ2b3g3?=
 =?utf-8?B?U1Z0alJnVVBZdnI3VTFITkFYN2Eya3l5L0lLZ2x1NFFaOHR2UHg3MTVyMUNL?=
 =?utf-8?B?UzZrKzBTQzl5a0FEQWdsVjcyVFVwbENxbEhQUnowWjJ0VEppdm5MYXRkZ2Vy?=
 =?utf-8?B?WUlwaXBDZUdZZGdjYXNFYkxoUndpM2FpSmtxRXM4RTdXNGtTNzNQbTN5Ujdx?=
 =?utf-8?B?Z1p4VTJoczE2WHM3NGpUUi9TQjlSdXN1TEJwU09LRSt6NW5UMUFGcXUwUzMv?=
 =?utf-8?B?a1MycloyN1BqcTF4Wnp4bTR1Mkh1VmFoUkN3Tmd0NjNYRlowclVQWkFnUTBO?=
 =?utf-8?B?NmhtRHJ1UDRjQkNzcTJicnZkTU8valBic3dvWGVxY3IrZGtBZldMSTI2UHRP?=
 =?utf-8?B?NkxXOXZCVUt2cWw0VEhrdGYwU3FhaVptOW5QUHZPbkpWUXNhQmJySi8rMWtB?=
 =?utf-8?B?UmVkajdBaXI0N1VuQnNyUDhCZHB6NWR3clc3ZWZaRUtWUXVnV2VhVnMzMlQr?=
 =?utf-8?B?UHV3Uk9TdEF1bGJwbjFLWk1FZTUwUVRJbndnM1F0YkptL2Vad3Q1L3hoK3Jo?=
 =?utf-8?B?UnB6anNuSzZ2SzNpS2VUVlQwRUFXblhmU3VZK2lzOC9GMzZQYWI3VEhoaDhC?=
 =?utf-8?B?MDFmbGN5RmVVSEVzeFRXY1MyM2NQdnZ0QjZES3JBSGlwREc0bkpDSGhRY1Fu?=
 =?utf-8?B?eFQweHFNSklUSEZacmphTVJXZDJCOS9lcWJFU1pBa0JZbmdiMW16anR2R1NW?=
 =?utf-8?B?azNOdXlhVVlPdXhadlFnZzluUmZ2Vy9xeVhxaldTVFZFOERmSHFZMmJlUkNN?=
 =?utf-8?B?Mm1PR0pPUEdYdXJPdnMxVm9yMkRXRHRqUGNVRVo1eTFRRzNqZTRrM05aT0l4?=
 =?utf-8?B?eWhBYXVFM0tNeDBiaFBaNklyOVJLYVpTV041V2szOEVhRW9YNGJwZXVQNkFL?=
 =?utf-8?B?Uk01N2I4SzFNNmlZYVFsNDRuTm03YnMzV0lZdmZ4RmZtbE5TQ1lrdDhJUjhI?=
 =?utf-8?B?bU9Wd0Q5em5KM1JHaU9PWVFWRVNWV1JHakdkR2djMFYxd1JYc00vQWxENFFJ?=
 =?utf-8?B?bEwxZ3NMVjlnTVREZmJLbjRNUUlKT0NYVmVUTVVockZvTVk1WXJEVFFZMGk0?=
 =?utf-8?B?eHJUeG1nV3NkempYWFRBMVc1OWtWQ0QzR0x4WlRGUnFtNjVSSGVEV0RPQ1FX?=
 =?utf-8?B?N0VBWDkxZW5BTFpYR2FsUFJTdlBWZEtKanIyejRsMWlqSGUvSGs1cHg3TVJh?=
 =?utf-8?B?bytKZ0hmaG03VjJCWTlKMlovV0RkYnpFZ0JiSW5VdGFBODdKT1hnVkFVKzlm?=
 =?utf-8?B?anFpaHIyUkJSeFZTR0QrRzhZTHFUWEFTZEVlY0grbnBnYWRQTENtSmZWb1hH?=
 =?utf-8?B?V2ZTVmNqbTFyLzFscFdCM212VmE0aHNJZjdDYkJzZ09acEdqcVQzMEVWR05M?=
 =?utf-8?B?ajFhZ3N2NnJXdHAwT0tiTFpVTkJEcjFhWkJIT1V2QVJCaXZxMXp5ZEl3UndW?=
 =?utf-8?B?R084NU5hMTJkcHE1NWZKYlhweGkrOXY3TDRQNDFKbW1rVm1rY3AyZmppVWgr?=
 =?utf-8?B?Uk5WVkpnQVJnRCtXcXJGd0RUR0QxdVJkMUNwWkY4Q0t1UklKMmRyNzJpdkR1?=
 =?utf-8?B?TDZOYXBHNkl0d09hdjBIaGxaZnFqTzUrMCtjQ2hWWlhNYnNqMXMzb0ExRFl3?=
 =?utf-8?B?Wk15cUJRTFFoNmZGWk9nNFNIUFREYkNDNkx6ckZvRDh0NlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHlaWlpqT0hMN1hYMzhwWmlBQUdYbUhONzQxd1JuUDlCTUJ0WGo2RktYcEJo?=
 =?utf-8?B?dWhBUHZvbFNLbE51bmx6U2NCZnZHVWEvdE1kdHBic3QrWWVzSHlwS0NWTHpE?=
 =?utf-8?B?eVNCOEZmUlI1Z2NpRDFOYXQza3NnVnFCM2dTUUNueWFIRXhwRTlaMHZDd2pT?=
 =?utf-8?B?WE5kTjNsc0lHaVBKcUk5OWhkQVp0djcvekR4UXo3bGxUVkt6emM0VVBtWHg0?=
 =?utf-8?B?QjR0TTJiS3lkZUFXaVE3akNkYnVHNW9pckovQ2NoRGhWYktwTG5uUHNYdGhW?=
 =?utf-8?B?clNOVDZXYWp6a1hBbnh5TE8wbUpOTmd4TEhic0NNNzV3eko4MFJxU0tiMGFq?=
 =?utf-8?B?ZlJKM1VxZWJUUktwTWJJd0RscTNhQXBnRUVDZDFGR2dJTGpMN2JNeGd5YnVK?=
 =?utf-8?B?dDg3TTgvUmk0eU0rbW5UbXpUQVkrZ2Z1b0V5VlN5UUg4QzJFZUdnMSt3d0xm?=
 =?utf-8?B?cndTUGlSSzI3Z2kyU2w1YlEzcXBtM0hkWittN0QzVFlzc3hwVk1ZSk91TTdN?=
 =?utf-8?B?bHNja29jLytBREs0cHhHeXhyZjE1N3hnQTZZbmN2SENGZ2FxSlBWODFGTDU0?=
 =?utf-8?B?RGtabnZuclpkc25ud1FoRk56K3diMEtvUUhJd1Erb1BJbmxHSGdRZXN4RkIw?=
 =?utf-8?B?UEluWnBFUUEvYk9qUkhZeHpmWVQyWHlweTJqVnpSRVdsY1VYT3BFZW1nTEJQ?=
 =?utf-8?B?OVQzcHNrK3pqUWwzR3ZsNE5aemhXSmtsN2lMSGZKK214MHE1OWVUcFdVUVNm?=
 =?utf-8?B?d0oyUWh3c0FDQjFmNGlPMElEalhGZWN5NzkyRzNxa2RDcUNRMVlISmM4aXNM?=
 =?utf-8?B?T0RVQk5rRGFlS0tWT1VFVDdjMWlHK2QxYlZxLzA5cCs2dmp3N2xPNnRTNzRJ?=
 =?utf-8?B?ZFhCcU9vSlJCVU1JcmhabSt1UEFtVVFMcjIvbkM0NklNMTBMWTVnblpURGdY?=
 =?utf-8?B?dTZ1eEVtb0dHVkluR05zR1M3NkhTd2lheUJQSE9RZkhGMUIwM2pXZWtyK2R0?=
 =?utf-8?B?c3RBbmp6Ym9UYytaZVZ2UEFxUnB5UkJNWG5zaVRia293WWJ0dHplTHMycHlj?=
 =?utf-8?B?ejIrbE9MZmhmUWJ6dGRBQTdEbnppNGxjV01zeHExQ3FIR3JjVS85SEtHd1RQ?=
 =?utf-8?B?YjBkcFFzUUtwNlozd09PTEY3QUR1TDluZWVGbmQ5SDBuUlhtZ05odEpMTEk3?=
 =?utf-8?B?SFMzcjd1MU5yZUJncDJBc3pEazZpUlB3ZThRQzZWWnZlSzRBYlVMdSthRmth?=
 =?utf-8?B?ZWczWFliVlhROEhlWDVjQkhpUU9hS3VQY1VQU1h1RGI3N0VJQkdPOFp0TE1U?=
 =?utf-8?B?V0U4THF0L1U4NndyNkRLeE9pRWtDTnVPRlpSdVVIL0U3MmsvWk9PRjUzOXpa?=
 =?utf-8?B?QTNtK2VIQVRQVnREQjhnbEdGcnhHZzhCOC9aeVd3d1g2RmVDMENFV1YwRHNX?=
 =?utf-8?B?UU1nY3BoRXdSczlmem52RXRydUt1a3VCNXBOMFZrUUg2VlRNeU1ValhCUVpu?=
 =?utf-8?B?d1B1VWVFSjNOV0thenVSWG04KzZqUnJWWGxHbzFycHBieVFJNStvRlM3STVh?=
 =?utf-8?B?QkQ1NUVvRGlRQ2twV0xIR1FjcWhJaUFEQ05jZnFrVGJ6cWs3aVZsNUxlbmtt?=
 =?utf-8?B?QURMZWZBTysvTlRsbUNiSGJLQVdXNUtHVVVhcFUrSXRITDhRd29mTFZDSUI0?=
 =?utf-8?B?OW8wVFB1enV5L00rL2V0QXd1M3MrckJLK0tQMTVkNHZFTHdaTm1TRkZVUGhI?=
 =?utf-8?B?OEFzcXZ0empVUHo4MVVwL3NGaWtyWTBzTFhNcWxXcDR1UFJ4TnNZUkgwbVBP?=
 =?utf-8?B?VE1DcnBVK2Y2aTdjb1BnOW9yNW1NTVRheS9xQzRJQmhXUXMzNEE5S0RscUFE?=
 =?utf-8?B?bDlkS1NCYUtCZDVTM0xNRldUTFp5OE5wSWJEcFZ2SmV1Z3N0aFpGYXVia3ZE?=
 =?utf-8?B?ZkMwSGJJRVAzU2N1RER6dHVYSm55WEhteW1hUFdIVTRCK0dPUmFvdXNoMTc1?=
 =?utf-8?B?U3EzMWNKQi93RUg3TWZVU214Y1lvbzg4ZDY3Wlc0Y1NRbXltSW5DSGJ1TnZY?=
 =?utf-8?B?WG1Bakx1ZXFhVUtHK2dxaFEveGVMTFNBYm92cVhlR0xiZERBbjZiTDFRTUlV?=
 =?utf-8?Q?C1cIHyMxPDSLo1E21D2g18COw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e3488f-76ce-498f-7239-08dca78faebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 01:11:13.2767 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyvpAdf3DK1dJG/Y6k3W85uIFiJs2INojb03II319aI33Ccy4G7YxzPGxfOkHSaMjI+17SlkYDLqxsjG/R5ri736qGKZCninGxdc7QxXjnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7274
Received-SPF: pass client-ip=2a01:111:f400:feab::713;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDMvMTVdIGh3L2kyYy9hc3Bl
ZWQ6IHN1cHBvcnQgdG8gc2V0IHRoZSBkaWZmZXJlbnQNCj4gbWVtb3J5IHNpemUNCj4NCj4gT24g
Ny8xOC8yNCAxMTo0MiwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIENlZHJpYywNCj4gPg0KPiA+
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAzLzE1XSBody9pMmMvYXNwZWVkOiBzdXBwb3J0IHRv
IHNldCB0aGUNCj4gPj4gZGlmZmVyZW50IG1lbW9yeSBzaXplDQo+ID4+DQo+ID4+IE9uIDcvMTgv
MjQgMDg6NDksIEphbWluIExpbiB3cm90ZToNCj4gPj4+IEFjY29yZGluZyB0byB0aGUgZGF0YXNo
ZWV0IG9mIEFTUEVFRCBTT0NzLCBhbiBJMkMgY29udHJvbGxlciBvd25zDQo+ID4+PiA4S0Igb2Yg
cmVnaXN0ZXIgc3BhY2UgZm9yIEFTVDI3MDAsIG93bnMgNEtCIG9mIHJlZ2lzdGVyIHNwYWNlIGZv
cg0KPiA+Pj4gQVNUMjYwMCwNCj4gPj4+IEFTVDI1MDAgYW5kIEFTVDI0MDAsIGFuZCBvd25zIDY0
S0Igb2YgcmVnaXN0ZXIgc3BhY2UgZm9yIEFTVDEwMzAuDQo+ID4+Pg0KPiA+Pj4gSXQgc2V0IHRo
ZSBtZW1vcnkgcmVnaW9uIHNpemUgNEtCIGJ5IGRlZmF1bHQgYW5kIGl0IGRvZXMgbm90DQo+ID4+
PiBjb21wYXRpYmxlIHJlZ2lzdGVyIHNwYWNlIGZvciBBU1QyNzAwLg0KPiA+Pj4NCj4gPj4+IElu
dHJvZHVjZSBhIG5ldyBjbGFzcyBhdHRyaWJ1dGUgdG8gc2V0IHRoZSBJMkMgY29udHJvbGxlciBt
ZW1vcnkNCj4gPj4+IHNpemUgZm9yIGRpZmZlcmVudCBBU1BFRUQgU09Dcy4NCj4gPj4+DQo+ID4+
PiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4g
Pj4+IC0tLQ0KPiA+Pj4gICAgaHcvaTJjL2FzcGVlZF9pMmMuYyAgICAgICAgIHwgNiArKysrKy0N
Cj4gPj4+ICAgIGluY2x1ZGUvaHcvaTJjL2FzcGVlZF9pMmMuaCB8IDIgKy0NCj4gPj4+ICAgIDIg
ZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4g
Pj4+IGRpZmYgLS1naXQgYS9ody9pMmMvYXNwZWVkX2kyYy5jIGIvaHcvaTJjL2FzcGVlZF9pMmMu
YyBpbmRleA0KPiA+Pj4gYjQzYWZkMjUwZC4uN2Q1YTUzYzRjMCAxMDA2NDQNCj4gPj4+IC0tLSBh
L2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gPj4+ICsrKyBiL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4g
Pj4+IEBAIC0xMDE0LDcgKzEwMTQsNyBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfaTJjX3JlYWxpemUo
RGV2aWNlU3RhdGUNCj4gPj4+ICpkZXYsIEVycm9yICoqZXJycCkNCj4gPj4+DQo+ID4+PiAgICAg
ICAgc3lzYnVzX2luaXRfaXJxKHNiZCwgJnMtPmlycSk7DQo+ID4+PiAgICAgICAgbWVtb3J5X3Jl
Z2lvbl9pbml0X2lvKCZzLT5pb21lbSwgT0JKRUNUKHMpLA0KPiA+PiAmYXNwZWVkX2kyY19jdHJs
X29wcywgcywNCj4gPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWQuaTJjIiwg
MHgxMDAwKTsNCj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICJhc3BlZWQuaTJjIiwg
YWljLT5tZW1fc2l6ZSk7DQo+ID4+PiAgICAgICAgc3lzYnVzX2luaXRfbW1pbyhzYmQsICZzLT5p
b21lbSk7DQo+ID4+Pg0KPiA+Pj4gICAgICAgIGZvciAoaSA9IDA7IGkgPCBhaWMtPm51bV9idXNz
ZXM7IGkrKykgeyBAQCAtMTI4Niw2ICsxMjg2LDcgQEANCj4gPj4+IHN0YXRpYyB2b2lkIGFzcGVl
ZF8yNDAwX2kyY19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCj4g
Pj4+ICAgICAgICBhaWMtPnBvb2xfc2l6ZSA9IDB4ODAwOw0KPiA+Pj4gICAgICAgIGFpYy0+cG9v
bF9iYXNlID0gMHg4MDA7DQo+ID4+PiAgICAgICAgYWljLT5idXNfcG9vbF9iYXNlID0gYXNwZWVk
XzI0MDBfaTJjX2J1c19wb29sX2Jhc2U7DQo+ID4+PiArICAgIGFpYy0+bWVtX3NpemUgPSAweDEw
MDA7DQo+ID4+PiAgICB9DQo+ID4+Pg0KPiA+Pj4gICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFz
cGVlZF8yNDAwX2kyY19pbmZvID0geyBAQCAtMTMyMCw2ICsxMzIxLDcNCj4gPj4+IEBAIHN0YXRp
YyB2b2lkIGFzcGVlZF8yNTAwX2kyY19jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9p
ZA0KPiAqZGF0YSkNCj4gPj4+ICAgICAgICBhaWMtPmJ1c19wb29sX2Jhc2UgPSBhc3BlZWRfMjUw
MF9pMmNfYnVzX3Bvb2xfYmFzZTsNCj4gPj4+ICAgICAgICBhaWMtPmNoZWNrX3NyYW0gPSB0cnVl
Ow0KPiA+Pj4gICAgICAgIGFpYy0+aGFzX2RtYSA9IHRydWU7DQo+ID4+PiArICAgIGFpYy0+bWVt
X3NpemUgPSAweDEwMDA7DQo+ID4+PiAgICB9DQo+ID4+Pg0KPiA+Pj4gICAgc3RhdGljIGNvbnN0
IFR5cGVJbmZvIGFzcGVlZF8yNTAwX2kyY19pbmZvID0geyBAQCAtMTM1Myw2ICsxMzU1LDcNCj4g
Pj4+IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF8yNjAwX2kyY19jbGFzc19pbml0KE9iamVjdENsYXNz
ICprbGFzcywgdm9pZA0KPiAqZGF0YSkNCj4gPj4+ICAgICAgICBhaWMtPnBvb2xfYmFzZSA9IDB4
QzAwOw0KPiA+Pj4gICAgICAgIGFpYy0+YnVzX3Bvb2xfYmFzZSA9IGFzcGVlZF8yNjAwX2kyY19i
dXNfcG9vbF9iYXNlOw0KPiA+Pj4gICAgICAgIGFpYy0+aGFzX2RtYSA9IHRydWU7DQo+ID4+PiAr
ICAgIGFpYy0+bWVtX3NpemUgPSAweDEwMDA7DQo+ID4+PiAgICB9DQo+ID4+Pg0KPiA+Pj4gICAg
c3RhdGljIGNvbnN0IFR5cGVJbmZvIGFzcGVlZF8yNjAwX2kyY19pbmZvID0geyBAQCAtMTM3Niw2
ICsxMzc5LDcNCj4gPj4+IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF8xMDMwX2kyY19jbGFzc19pbml0
KE9iamVjdENsYXNzICprbGFzcywgdm9pZA0KPiAqZGF0YSkNCj4gPj4+ICAgICAgICBhaWMtPnBv
b2xfYmFzZSA9IDB4QzAwOw0KPiA+Pj4gICAgICAgIGFpYy0+YnVzX3Bvb2xfYmFzZSA9IGFzcGVl
ZF8yNjAwX2kyY19idXNfcG9vbF9iYXNlOw0KPiA+Pj4gICAgICAgIGFpYy0+aGFzX2RtYSA9IHRy
dWU7DQo+ID4+PiArICAgIGFpYy0+bWVtX3NpemUgPSAweDEwMDAwOw0KPiA+Pg0KPiA+IFRoYW5r
cyBmb3IgcmV2aWV3Lg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBkYXRhc2hlZXQgb2YgQVNU
MTAzMCBpbiBjaGFwdGVyIDcgKE1lbW9yeSBTcGFjZQ0KPiA+IEFsbG9jYXRpb24gVGFibGUpICwg
dGhlIHJlZ2lzdGVyIGFkZHJlc3Mgc3BhY2Ugb2YgSTJDIENvbnRyb2xsZXIgcmFuZ2UNCj4gPiBp
cyBzdGFydCBmcm9tIDdFN0IwMDAwIHRvIDdFN0JGRkZGIGFuZCBpdHMgcmVnaXN0ZXIgYWRkcmVz
cyBzcGFjZSBpcw0KPiA2NEtCKDB4MTAwMDApLg0KPg0KPiBPSy4NCj4NCj4gPiBUaGUgZmlybXdh
cmUgb25seSB1c2UgNEtCIGFkZHJlc3Mgc3BhY2UuIFdlIGNhbiBjaGFuZ2UgbWVtX3NpemUgZWl0
aGVyDQo+IDRLQiBvciA2NEtCLg0KPiA+IENvdWxkIHlvdSB0ZWxsIG1lIHdoaWNoIHNpemUgeW91
IHByZWZlcj8NCj4NCj4gSSB3b3VsZCBrZWVwIHRoZSBsYXJnZXIgdmFsdWUgZm9yIHRoZSBtb2Rl
bCBhbmQgbGV0IEZXIGRlY2lkZSB0byByZXNpemUgb3Igbm90Lg0KPg0KVGhhbmtzIGZvciBzdWdn
ZXN0aW9uLg0KR290IGl0Lg0KDQo+IFRoYW5rcywNCj4NCj4gQy4NCj4NCj4NCj4NCj4NCj4NCg0K
KioqKioqKioqKioqKiBFbWFpbCBDb25maWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioq
KioqKioqDQrlhY3osqzogbLmmI46DQrmnKzkv6Hku7Yo5oiW5YW26ZmE5Lu2KeWPr+iDveWMheWQ
q+apn+Wvhuizh+ioiu+8jOS4puWPl+azleW+i+S/neitt+OAguWmgiDlj7Dnq6/pnZ7mjIflrprk
uYvmlLbku7bogIXvvIzoq4vku6Xpm7vlrZDpg7Xku7bpgJrnn6XmnKzpm7vlrZDpg7Xku7bkuYvn
mbzpgIHogIUsIOS4puiri+eri+WNs+WIqumZpOacrOmbu+WtkOmDteS7tuWPiuWFtumZhOS7tuWS
jOmKt+avgOaJgOacieikh+WNsOS7tuOAguisneisneaCqOeahOWQiOS9nCENCg0KRElTQ0xBSU1F
UjoNClRoaXMgbWVzc2FnZSAoYW5kIGFueSBhdHRhY2htZW50cykgbWF5IGNvbnRhaW4gbGVnYWxs
eSBwcml2aWxlZ2VkIGFuZC9vciBvdGhlciBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24uIElmIHlv
dSBoYXZlIHJlY2VpdmVkIGl0IGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkg
cmVwbHkgZS1tYWlsIGFuZCBpbW1lZGlhdGVseSBkZWxldGUgdGhlIGUtbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnRzIHdpdGhvdXQgY29weWluZyBvciBkaXNjbG9zaW5nIHRoZSBjb250ZW50cy4gVGhh
bmsgeW91Lg0K


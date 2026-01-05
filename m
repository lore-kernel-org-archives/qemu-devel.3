Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F33C2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 06:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vceGK-00063d-Sh; Mon, 05 Jan 2026 01:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vceGA-000620-Sz; Mon, 05 Jan 2026 01:40:12 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vceG8-0007yF-1H; Mon, 05 Jan 2026 01:40:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmwH671/9m1a/ZTOS1wyyj96zxRacPwlzd+AT5YaoHWL1bUwj5HIUtVLU66NBt3RdJp/W0xUiGgp9z0Q+AzLCQu17A+5/mDAxHqb7cUvetzMBf1cX35c1cw74rLqP9Lk6QW/y5DjfbSJpp1+VptKMgg7+Q7Qb+IOUvEl0IGtFRmcP0UH2Je3MvC0IzrG4xs0QyoQi7AxbuH++FdbQnzPd9kPeqAKVrTLzK/KEYHaYRmmD6Z/ux+lCX8alwHNaVtkNSk4aqXYKjLzorM267JRWPx0djDgGc7FlM7WRnl9BcJbEwUrbLQIBgS0lx2/a791XvIUUHBNtHpFkFArFY9wyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75/LIEGF90VGFrL11Etmy+UTlqtiVB9PX9MXdMwbuAA=;
 b=SMc5Oi0pl70IZkgwnz48xkonBe8z7OL2scx1WUv1UkrSIxclH96ewCZRw4b5QUrmS/5i0Y8GfLQVmB5fBwKHnlmvh6kxQDwEi9CP/kiDZ9QZG+FyicLIWGn9jg7IKclfJNLDKzLCma9ed5hgPScrCMxsv6vPMrnsWffJccudykCBWWRMXbgZ12Ej9yTYfBAkmZ1CxATARtim5QgejM1IwfkpPkkOWjuWWY5hMboQ80mzcBeyXD0f3xPAKcKaayCDs6o1Y4lg4eIYA9BqjdmdA/4wOAHXWtpZnFbz5WuWnxDALF2NMeabIjDBW8vlaijpBHrhraIHccM+YjFMeih7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75/LIEGF90VGFrL11Etmy+UTlqtiVB9PX9MXdMwbuAA=;
 b=Tq/iQ9Fd/6qN2kRtEQKGEoU+fHO8m6U0pDAE1V4B4uEdlcwf5Os4i6dlHIg6ldlI52fH8V2hojssQN3SY0MbFh/nLvTYk9xiDgJm8N20QuuXQ3wKoCZg11R8oNh9kBA1Can7G5AT1/IdqxdOSfcoOZkXJJP0sxdAd/wOEZhyrbdmLViqU6fPprOSEk0mFZcvl270rqbwuwWFNr5zYKmpkXePUTY166jMPqnAEtqRUzXQzA4val8yZ1z9imjS52XsrwfTRVt/VY7EQ5zQo0ePSYDT2YamODan2HkDFY3C72SP8eYXxuc34uX0yX3g62AykPcU0uqTT4UuPGMgKCYOgg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPFE0788CA4B.apcprd06.prod.outlook.com (2603:1096:408::7b0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 06:39:59 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 06:39:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 05/19] hw/i3c/aspeed_i3c: Add more register fields
Thread-Topic: [PATCH 05/19] hw/i3c/aspeed_i3c: Add more register fields
Thread-Index: AQHb2/a5Q+rXnKXZPEayoq375SprILVEZCkw
Date: Mon, 5 Jan 2026 06:39:59 +0000
Message-ID: <TYPPR06MB8206189FC62823524909B246FC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-6-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-6-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPFE0788CA4B:EE_
x-ms-office365-filtering-correlation-id: 5e2e043e-630f-4dc4-ea63-08de4c253f58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NHdSb29VcXl1MU9ldWRhSE5wb2ROT3diMUltSHA2UzZrWjdXeFRKbk90RjRC?=
 =?utf-8?B?Y0loQnBPc05WbFFVSlBSNExBa0lBdFM4ekhMbGsxb2hMUnViTU9MUkF6RXg5?=
 =?utf-8?B?WndYRTREbnlac0w2RFk4L01xVEVsOWpzbW92S2U2RFMzblVIQ3dGUXltK0ND?=
 =?utf-8?B?U0N0ZHZoNDlaeGp0aXRsWGZXN2Q5b3RvQ3lEa0FpL2pzYW82S0IxMzl5QUN2?=
 =?utf-8?B?UmpRMlpzdnNNT0tsWkRQekkwdnBuS3ROQ2crcTNwVXZacmJFT3ZhUnkwbGgr?=
 =?utf-8?B?bkVMYzJGNXhTb3d0UEhyanpoeityMmtiaEw2b1ZwNzBaRHBaUWF0Z29VZTh3?=
 =?utf-8?B?aVNLT3g5THZIWFYxMCt4b040amNhOGRXdlZtczVBK1ZEd2hLbkhQWXhMNXUy?=
 =?utf-8?B?cEdGY2JQN3VnV0pFM0ZudG1BSGVJZzdxMEpHdTFpUE1sYXkwMTM5U3FUOEp1?=
 =?utf-8?B?MGFZWlJuL1JsTUJwSlVRYU9IZzRSSlR5SXFUNytBUWpBNnRJWjRWLzJLM0F1?=
 =?utf-8?B?bkljby9YWFBtZHdmRUJJVmRvSHU2cDVDQmkzL1Q3aG5wSUh4UVkwZWxNRXpu?=
 =?utf-8?B?QUtVUk1weHFoYjU2VGJGempsVUxXUEhpV1Z4ZUhuOXhxcVlpRXpXTDNLdWdv?=
 =?utf-8?B?ZEhiRU90OENlLzY2RW5ld2FMU2MwUWVKTkVxTE10OUhjUmJMeXNvVDBob2dG?=
 =?utf-8?B?Wjh0cVMwN2dJdGRNNWZVK2s1MEErN0xPVGVsWEZ2bTNRNFpreXdPdFpWT01p?=
 =?utf-8?B?MHBrYXFZdk5zKysvUHpRbzdPZ29OeDJaQ0xNYXNFTzlBQS9sdFpuSlcrbllV?=
 =?utf-8?B?azRicnoyeFdYT3dwQWhwenM4QVVhc0R0eUZmL0t0QlM4MTlTRUJ5STQ2NTFP?=
 =?utf-8?B?ODlCS3pGT2tSN3QwY0Vub0lHNDl1Z1ZycjBWRzVTbVZoQVdMTmM1VTI2Q0RB?=
 =?utf-8?B?RzlZNkoxTHlyVFZpeFVJMHpnR2JWOXM5TG5GNGVDODJ1clEvZS9ra2hxV3U5?=
 =?utf-8?B?THV0ODdKSFBiaFhTejl0RTI1WEJFQkNQM1RnSFBsVUwzWE5JVUsxaGpCbGhr?=
 =?utf-8?B?UlVpK2k5Vmx2SEl6Y0NTREFoK1phdks0OE5sSGNTNFkrTWtZVzAyTzRuL3hp?=
 =?utf-8?B?d0dmNHNYMThubWdUaXVRSjZOeUJ5d3EzMHhidUVBNExKcEZPNGd0OHZ2Nkpl?=
 =?utf-8?B?L3c1UlJkZHNGNmN2THVVMTIrZkY3RTk5QnZkU3hBd21vRDdVS3AzazludlF2?=
 =?utf-8?B?NnVILzFLN21sb1JqZ1J2UytOc2tYbUxoRjlyZTdhNnZiZ2JhdGJPNTU2ZlRO?=
 =?utf-8?B?aU5GZmtSV0g4cEVXTGhVYzRyeFY4eCtKdmM4NlpDK2Fic004N1RqOUM3MnVk?=
 =?utf-8?B?d3VmZEVlbUJkZmFoM2RzYVhtYUtNMWY3UDE5T2hzRDIrZTB4NG56MTVnSTI0?=
 =?utf-8?B?aEpENjRiTHJiUC9nR3E1Z1BtMm5jYlZiTnhtTENybVNaOFhrV0FEQllrcm9O?=
 =?utf-8?B?NzA3U1JHV2FuT3JEMkhyeEplbTFzYTNQNjlGWXhYVnBkREpVMGREUlVTRHFC?=
 =?utf-8?B?aU1rYkkzSVdMUHBlajA1dGhJbmE4TFQydEhTZHJqNDFDellXQTJiaEY3S0VG?=
 =?utf-8?B?alU0by9ndEdFRWRQck5wRTNOd1FoL0NLS1JQaHFkUXpKOFkxZDlzVTRrcm9h?=
 =?utf-8?B?aHNmQmlqWVJhZGl5djBsUFBFZGdoemdYM1FFc01qajEzMWd2aG5hRGJSVzEz?=
 =?utf-8?B?NENaZnh2emo1VVd3SEt4U2x1cFNjN3VTbG15SmYrWitUNkxFRWNYRkNuMU0y?=
 =?utf-8?B?ajhaaTk5OFBuR292bUFKNUJWbUx5YThUQ0RvTU4rVzFjWXlXbmZ6MnlDN1R2?=
 =?utf-8?B?WkQ5ckFHR054dVBDOFhKWmIrWHB2RzJzRzl3MWk3dTNLSzlqN0FmTmc2SVV6?=
 =?utf-8?B?TC9EMEN6UVAzc3pxeXdFUjBZWm03Yk9odENjMm9NUzh5Q21rMGZzcHR4Qk1Z?=
 =?utf-8?B?NzNad01HR2JsRVlQeWpDN280bFdVMjJrakk2REhISVU3K3ZXY3JXS1l4bjhu?=
 =?utf-8?Q?Fkmfvi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTVSdjJvSUtkRWJQUFNhQUVETGxSdWdRclBna09oUUtTbUs3WlBBbzVpVmNx?=
 =?utf-8?B?VWlMYnhuZURvVjZDOFRKTkRrMENSQThVcnVOUnFCNlpjYWxzSG9nUXRkZ0hB?=
 =?utf-8?B?aElSUVhidm1YdTNSNTliZUxJQThnWkZXL0tJbDJhcVZoUGQvRXMyVnhvNVgy?=
 =?utf-8?B?SWRtNURRMVBxY0drdVhHYWhiVzBGSnpJbDBmT1Q3N0dZME8rTXlkVy9ZRTl2?=
 =?utf-8?B?dnJCeHlrRnpYelllWUlzcDlVK2NRWXNLMDVaYko5TDJLeVZzUHREUmZOajhW?=
 =?utf-8?B?c3ZxcHd0alVFMFpDV2hTcDB3cTFGTmVMWktwSU9RcG8wM0JvNlBPdmRkWEFK?=
 =?utf-8?B?eHNtNjBOdEhDOTBkSG9nMUM5SXpHcTFuL2lkRVRkaGFZR3pXVVBJaGN3dXht?=
 =?utf-8?B?OWRsWlp0eHp6R3dJV1hwdjYyMStHMEZhZmdvMUo5MG5sc291RlJaSlhkY1o3?=
 =?utf-8?B?ZW9aRkg3UmpoamgvTzV1YUtQU0hSZU92M2tMVmhBOTVpemJzOWhyeTFQSE8v?=
 =?utf-8?B?enBiS2NIUm95WkZRLy95dE5JV0x2S3BYcUhYSnViRFpTZ2FVeHVHcUp6ZWht?=
 =?utf-8?B?ZVVLcTBEWExORytoUjE5anhwMXlScTZwTzdvTFB3SWlBMzdwZHltNVlZdVFo?=
 =?utf-8?B?YzlDTHJDNDhTbHNkTVpPY2N4Zkd2QWdwTU12UjNEMWh4WkNTTzllWFUyRFFv?=
 =?utf-8?B?VGxRUkZUc2pUNnltSnd0a0h6Ukw4Zk9BZ1pqcUltQjMyNDhvdnUvNHBnNjdh?=
 =?utf-8?B?ZlNibmpvaS9rdHI4QldTOFdWL2ZDRXNRNW9HSHNqbGNoOEkyT3QrbG43YnFB?=
 =?utf-8?B?dkt1V2VsdzN2M3Z1d3RTellPdm5QQmk1SnVIWW85anJ1Z2U1UGhMN3hXdlhH?=
 =?utf-8?B?R1dvU2NVeEpEMHUxMGovY0ZCSXNoWjVRUk1NWUFyT3RnZXZqMStkYTRvQjBF?=
 =?utf-8?B?UWM4VXY3S1Z0WHRZOEltZzhSU0FoUGlKOFhhV0F6NXFERWZnRm51Ylk2bTNT?=
 =?utf-8?B?TTlqZmNpbGZ0QmVKRkNBQzhZd1lVYXZKZDN4NkdRdVFOT3NwaHVZSHdwVFY1?=
 =?utf-8?B?eTF0S1RMd1k3dUNmS0p2KzR2S3hxS0Rsb3kwaGM0SnZzaDZHc2FsMnNUSGJV?=
 =?utf-8?B?RzV2Vmw2dGlYMHRDb0NNT3VGbmdEd2R2ditFeGhHRkxPamhJNkY4bjVhbzh4?=
 =?utf-8?B?b0Y2bXlhVzJiRytPREg3VTM5ZDVxb3NNTWJTTlc1RzFwUzJOY1prdXZOUDB0?=
 =?utf-8?B?TGNqMkNpNmZ0Z2JNN2ZVNUtMWWRUWGwxZ3liQm9xMmsvelZkQ2h4NjlSSmRH?=
 =?utf-8?B?M3hNanFMWDU2dk1qUU9XMFMzcWNMak5VdFVsYWtPM0p1WDczbDZMUUQ1Q3lr?=
 =?utf-8?B?YThIaVVJRlJhY3JzbHpGU21yTVY3SkI3NnZBWTBVbWlMejAwb2o4M1pNQmR4?=
 =?utf-8?B?UVVRd2xROFFDR0JEVk1wM0Y4Q1dsSGIyV0hIbkNHR0VQck5BUEpOTWFyWkJR?=
 =?utf-8?B?STkyMXpJY1JuZUxnNHVXMm02QTk2S3NSdUpESzVCYjJpS09WTk41ZmdDS1Ft?=
 =?utf-8?B?YXkxN3BoTy9xRXp5Sk45WDhMeVJhaHBkK3MyUytxSW9xaWhnaUkwZzU5Uk5q?=
 =?utf-8?B?M3krSkxqWVVvdkNMaDNWV3d4MHNKaG82VVVBcnN4TFZ2YUVxd3B2TjBFTzUz?=
 =?utf-8?B?Nng5b3pNY0xDazV5UTdLS25BQmUwR2tWRWhIbGxWekJianYwMTl6cnZSNTRn?=
 =?utf-8?B?U2xZU0lFS0dyOWdMd2Nmd2JCVXh3UDJqdFByUk4xdW9tZXBvQ2l1MmpwUXR6?=
 =?utf-8?B?UHJzWHpVNmRNT0dCWTRjMG1jaUUxVEFaclBRYzVKVVFPdzEvemxGWm9ndjdm?=
 =?utf-8?B?WXBqcFIwSU9Od21lY1p1V0N1ckRyOVdHOHhvb3BicklUV25aaHhoQTVZbk9l?=
 =?utf-8?B?Yi94V05RU202aEFFYVIwN1cvQWZmdmgxcVJEREREZnJWbnMvQkdTaittT2xR?=
 =?utf-8?B?eStqclNuM2c0enc2aW1mMmlRUXpRdjJqWU5vYy9QaGdnSVlvVDdDa3lxL3My?=
 =?utf-8?B?ZGZxMUFOak9IamZUTzIzZkVOVlZMTWFoeDQ0ekM1NGgyMUJsRmYrU2hCRys3?=
 =?utf-8?B?MEtvOGdyRFRtNU5UaENMcVRLbVUzRW52NFdaM09JdUw2T3U1dnMrZGdnZGJr?=
 =?utf-8?B?dXJrY1AwbWxYVC8vbDZQWENrbFJwbmRHZjZzbStzR0xrWENBMUI1bTVjQ2dR?=
 =?utf-8?B?YTN5eVZNdENJNTlzWS9UYW5yRXB0aVVHcklCRGNiT0ZTVHdFV0FieTBuZGNw?=
 =?utf-8?B?K3BSNHRTM1prQ0NaRXNqdWdtTk54QmRuaHN2V2doMDFFRzFrRHI0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2e043e-630f-4dc4-ea63-08de4c253f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 06:39:59.3227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0ZVnFgbnISztAe9YGNdYNAmWKaBZC/iwtloDs1PoTdnQNpQ18iURtVciOz3pzjrxrnktjd9fYZ5wx/xELa24nJnDvWDOf29+K+4Caypuyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFE0788CA4B
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDUvMTldIGh3L2kzYy9hc3BlZWRfaTNjOiBBZGQgbW9yZSByZWdp
c3RlciBmaWVsZHMNCj4gDQo+IEFkZHMgdGhlIHJlc3Qgb2YgdGhlIEFzcGVlZCBJM0MgY29udHJv
bGxlciByZWdpc3RlciBmaWVsZHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2UgS29tbG9kaSA8
a29tbG9kaUBnb29nbGUuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBhdHJpY2sgVmVudHVyZSA8
dmVudHVyZUBnb29nbGUuY29tPg0KPiAtLS0NCj4gIGh3L2kzYy9hc3BlZWRfaTNjLmMgfCA1NCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9ody9pM2MvYXNwZWVkX2kzYy5jIGIvaHcvaTNjL2FzcGVlZF9pM2MuYyBpbmRleA0KPiBj
YjAzMzI4MjhjLi43YTE2ZGZlYzUzIDEwMDY0NA0KPiAtLS0gYS9ody9pM2MvYXNwZWVkX2kzYy5j
DQo+ICsrKyBiL2h3L2kzYy9hc3BlZWRfaTNjLmMNCj4gQEAgLTIxLDI4ICsyMSw1OCBAQA0KPiAg
LyogSTNDIENvbnRyb2xsZXIgUmVnaXN0ZXJzICovDQo+ICBSRUczMihJM0MxX1JFRzAsIDB4MTAp
DQo+ICBSRUczMihJM0MxX1JFRzEsIDB4MTQpDQo+IC0gICAgRklFTEQoSTNDMV9SRUcxLCBJMkNf
TU9ERSwgIDAsICAxKQ0KPiAtICAgIEZJRUxEKEkzQzFfUkVHMSwgU0FfRU4sICAgICAxNSwgMSkN
Cj4gKyAgICBGSUVMRChJM0MxX1JFRzEsIEkyQ19NT0RFLCAgICAgIDAsICAxKQ0KPiArICAgIEZJ
RUxEKEkzQzFfUkVHMSwgU0xWX1RFU1RfTU9ERSwgMSwgIDEpDQo+ICsgICAgRklFTEQoSTNDMV9S
RUcxLCBBQ1RfTU9ERSwgICAgICAyLCAgMikNCj4gKyAgICBGSUVMRChJM0MxX1JFRzEsIFBFTkRJ
TkdfSU5ULCAgIDQsICA0KQ0KPiArICAgIEZJRUxEKEkzQzFfUkVHMSwgU0EsICAgICAgICAgICAg
OCwgIDcpDQo+ICsgICAgRklFTEQoSTNDMV9SRUcxLCBTQV9FTiwgICAgICAgICAxNSwgMSkNCj4g
KyAgICBGSUVMRChJM0MxX1JFRzEsIElOU1RfSUQsICAgICAgIDE2LCA0KQ0KPiAgUkVHMzIoSTND
Ml9SRUcwLCAweDIwKQ0KPiAgUkVHMzIoSTNDMl9SRUcxLCAweDI0KQ0KPiAtICAgIEZJRUxEKEkz
QzJfUkVHMSwgSTJDX01PREUsICAwLCAgMSkNCj4gLSAgICBGSUVMRChJM0MyX1JFRzEsIFNBX0VO
LCAgICAgMTUsIDEpDQo+ICsgICAgRklFTEQoSTNDMl9SRUcxLCBJMkNfTU9ERSwgICAgICAwLCAg
MSkNCj4gKyAgICBGSUVMRChJM0MyX1JFRzEsIFNMVl9URVNUX01PREUsIDEsICAxKQ0KPiArICAg
IEZJRUxEKEkzQzJfUkVHMSwgQUNUX01PREUsICAgICAgMiwgIDIpDQo+ICsgICAgRklFTEQoSTND
Ml9SRUcxLCBQRU5ESU5HX0lOVCwgICA0LCAgNCkNCj4gKyAgICBGSUVMRChJM0MyX1JFRzEsIFNB
LCAgICAgICAgICAgIDgsICA3KQ0KPiArICAgIEZJRUxEKEkzQzJfUkVHMSwgU0FfRU4sICAgICAg
ICAgMTUsIDEpDQo+ICsgICAgRklFTEQoSTNDMl9SRUcxLCBJTlNUX0lELCAgICAgICAxNiwgNCkN
Cj4gIFJFRzMyKEkzQzNfUkVHMCwgMHgzMCkNCj4gIFJFRzMyKEkzQzNfUkVHMSwgMHgzNCkNCj4g
LSAgICBGSUVMRChJM0MzX1JFRzEsIEkyQ19NT0RFLCAgMCwgIDEpDQo+IC0gICAgRklFTEQoSTND
M19SRUcxLCBTQV9FTiwgICAgIDE1LCAxKQ0KPiArICAgIEZJRUxEKEkzQzNfUkVHMSwgSTJDX01P
REUsICAgICAgMCwgIDEpDQo+ICsgICAgRklFTEQoSTNDM19SRUcxLCBTTFZfVEVTVF9NT0RFLCAx
LCAgMSkNCj4gKyAgICBGSUVMRChJM0MzX1JFRzEsIEFDVF9NT0RFLCAgICAgIDIsICAyKQ0KPiAr
ICAgIEZJRUxEKEkzQzNfUkVHMSwgUEVORElOR19JTlQsICAgNCwgIDQpDQo+ICsgICAgRklFTEQo
STNDM19SRUcxLCBTQSwgICAgICAgICAgICA4LCAgNykNCj4gKyAgICBGSUVMRChJM0MzX1JFRzEs
IFNBX0VOLCAgICAgICAgIDE1LCAxKQ0KPiArICAgIEZJRUxEKEkzQzNfUkVHMSwgSU5TVF9JRCwg
ICAgICAgMTYsIDQpDQo+ICBSRUczMihJM0M0X1JFRzAsIDB4NDApDQo+ICBSRUczMihJM0M0X1JF
RzEsIDB4NDQpDQo+IC0gICAgRklFTEQoSTNDNF9SRUcxLCBJMkNfTU9ERSwgIDAsICAxKQ0KPiAt
ICAgIEZJRUxEKEkzQzRfUkVHMSwgU0FfRU4sICAgICAxNSwgMSkNCj4gKyAgICBGSUVMRChJM0M0
X1JFRzEsIEkyQ19NT0RFLCAgICAgIDAsICAxKQ0KPiArICAgIEZJRUxEKEkzQzRfUkVHMSwgU0xW
X1RFU1RfTU9ERSwgMSwgIDEpDQo+ICsgICAgRklFTEQoSTNDNF9SRUcxLCBBQ1RfTU9ERSwgICAg
ICAyLCAgMikNCj4gKyAgICBGSUVMRChJM0M0X1JFRzEsIFBFTkRJTkdfSU5ULCAgIDQsICA0KQ0K
PiArICAgIEZJRUxEKEkzQzRfUkVHMSwgU0EsICAgICAgICAgICAgOCwgIDcpDQo+ICsgICAgRklF
TEQoSTNDNF9SRUcxLCBTQV9FTiwgICAgICAgICAxNSwgMSkNCj4gKyAgICBGSUVMRChJM0M0X1JF
RzEsIElOU1RfSUQsICAgICAgIDE2LCA0KQ0KPiAgUkVHMzIoSTNDNV9SRUcwLCAweDUwKQ0KPiAg
UkVHMzIoSTNDNV9SRUcxLCAweDU0KQ0KPiAtICAgIEZJRUxEKEkzQzVfUkVHMSwgSTJDX01PREUs
ICAwLCAgMSkNCj4gLSAgICBGSUVMRChJM0M1X1JFRzEsIFNBX0VOLCAgICAgMTUsIDEpDQo+ICsg
ICAgRklFTEQoSTNDNV9SRUcxLCBJMkNfTU9ERSwgICAgICAwLCAgMSkNCj4gKyAgICBGSUVMRChJ
M0M1X1JFRzEsIFNMVl9URVNUX01PREUsIDEsICAxKQ0KPiArICAgIEZJRUxEKEkzQzVfUkVHMSwg
QUNUX01PREUsICAgICAgMiwgIDIpDQo+ICsgICAgRklFTEQoSTNDNV9SRUcxLCBQRU5ESU5HX0lO
VCwgICA0LCAgNCkNCj4gKyAgICBGSUVMRChJM0M1X1JFRzEsIFNBLCAgICAgICAgICAgIDgsICA3
KQ0KPiArICAgIEZJRUxEKEkzQzVfUkVHMSwgU0FfRU4sICAgICAgICAgMTUsIDEpDQo+ICsgICAg
RklFTEQoSTNDNV9SRUcxLCBJTlNUX0lELCAgICAgICAxNiwgNCkNCj4gIFJFRzMyKEkzQzZfUkVH
MCwgMHg2MCkNCj4gIFJFRzMyKEkzQzZfUkVHMSwgMHg2NCkNCj4gLSAgICBGSUVMRChJM0M2X1JF
RzEsIEkyQ19NT0RFLCAgMCwgIDEpDQo+IC0gICAgRklFTEQoSTNDNl9SRUcxLCBTQV9FTiwgICAg
IDE1LCAxKQ0KPiArICAgIEZJRUxEKEkzQzZfUkVHMSwgSTJDX01PREUsICAgICAgMCwgIDEpDQo+
ICsgICAgRklFTEQoSTNDNl9SRUcxLCBTTFZfVEVTVF9NT0RFLCAxLCAgMSkNCj4gKyAgICBGSUVM
RChJM0M2X1JFRzEsIEFDVF9NT0RFLCAgICAgIDIsICAyKQ0KPiArICAgIEZJRUxEKEkzQzZfUkVH
MSwgUEVORElOR19JTlQsICAgNCwgIDQpDQo+ICsgICAgRklFTEQoSTNDNl9SRUcxLCBTQSwgICAg
ICAgICAgICA4LCAgNykNCj4gKyAgICBGSUVMRChJM0M2X1JFRzEsIFNBX0VOLCAgICAgICAgIDE1
LCAxKQ0KPiArICAgIEZJRUxEKEkzQzZfUkVHMSwgSU5TVF9JRCwgICAgICAgMTYsIDQpDQo+IA0K
PiAgc3RhdGljIHVpbnQ2NF90IGFzcGVlZF9pM2NfcmVhZCh2b2lkICpvcGFxdWUsIGh3YWRkciBh
ZGRyLCB1bnNpZ25lZCBpbnQgc2l6ZSkNCj4gew0KPiAtLQ0KPiAyLjUwLjAucmMxLjU5MS5nOWM5
NWYxN2Y2NC1nb29nDQoNClJldmlld2VkLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbT4NCg0KVGhhbmtzLA0KSmFtaW4NCg0K


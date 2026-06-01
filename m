Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E282CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjL-00034s-5e; Sun, 31 May 2026 22:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjJ-00034V-9K; Sun, 31 May 2026 22:50:17 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjG-0002Y8-Gg; Sun, 31 May 2026 22:50:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haakCt4lc8wY154i6wueuN3Q2qlcy8s3UmbUDsvBseEk1eZUt+UaomQaay0g3ldeds8+Wr9gRzKompYg4/Ue0jC0IYe903HT3KiximW1q8lwrEBoSHdDMnHoAx2VI79KTfa5w0LYmZoYDGkq5/e0erQnh2VR9PWWd8bUhZBqSnnnhIL4pD61np/Lt2JnXycyZdT+X+0cu7dWlhOysA4gGSm5tIbAI0GmZ0NPgATBM9+3zQus9SCDMyFZx3BKUSQ7dj8eyk1Tz/4Y9AKDmgNj0lre93geKjvCWBuwjb6bVxonhq4SvHYJy8ko340cgjmD+x/4R23agGvfclsPB/Ts3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7+ueVrvgoim3xCNjSGcEPKDoLDh7epFxcGC7SUpJO0=;
 b=k2J9T37MGVNvzEoV0p498NYviYI/AhO+OIn3UOTb03qg8+/HlrkwPOjKCnmeJmjXYYhNEWYyjNR+e5sVGzub6KPXkyiFQcBJKEk14dqZcX3lI9PuI4vVuKr+23rF+61nxVJ2+dIMMxcEJxMM0PFqE28TmVGejLExF8zcpPL99png6sUF15PD4MiU9XTunqVctCFcJDYSL7daQmN9DRM/crFo+61BXwT32Wclh0O2+Mff0CskWYuVnhFlQotcu7EJU0Hj7PaNvdUAFAIWiBp8ZggfSV599euphi2wTdKQm0WbxpEBA24lFgYbcuaLJhPEKkTCJRoaaVsceJSbhYeZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7+ueVrvgoim3xCNjSGcEPKDoLDh7epFxcGC7SUpJO0=;
 b=jwM0Kbw9kRZKF59A009MIvjHWgFDC1ZDBtq24dKvPHZBr3rS7ewKzTN2vQ8TNffK0RpCRx/ZwgqK8maXu62/Kiym8Wxza5ChveHdajhjANRY7bm5aXZEymYNKAkWSPR3d/+TW03OvCGXpzP3BYnX3pcz0dUOUtxWvcfB77ErPWryZ6rzT62zVyuddDFYhAFeKUlJb994mTZ26/KZzZ54y+Ei3JJULH3MWUE80K5EwhbExQVI6zCR//0SGGft+tUThyRPz/mrS7qB9q8QU/REErW+OOzTubvxUOoSX0aXhlYrOOHK0Tq5bkrF+v3z/1FDs2SzC0nXRImX6ygsoa2erw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:01 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 00/24] hw/aspeed: Convert all Aspeed devices to
 DEFINE_TYPES() with inlined TypeInfo
Thread-Topic: [PATCH v1 00/24] hw/aspeed: Convert all Aspeed devices to
 DEFINE_TYPES() with inlined TypeInfo
Thread-Index: AQHc8XFXKPB/fbK5wU+1bqPPadAJVA==
Date: Mon, 1 Jun 2026 02:50:00 +0000
Message-ID: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8361:EE_
x-ms-office365-filtering-correlation-id: 57bc208e-1952-44c4-336d-08debf887993
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: o4luI0KsLus1xm013726dtBzEk3wHQtW89+woM3hzb+IW2I8LHHCvBsdBH8HcXgMph7yrQqxorVdf855261w/XXJUBLqAqRouxETS9oLDT2caUWv5wvW3x9C2++isP/98uWqqwMKWzV0M2O8DoCku1SrEzF7LD1vUS3S4M1AHCjOuytR2A/KFxLEwhsT1Ea2BEXtd3BwsiTwvaRgXKehIq0LI+A0dJSTeCzuJEuAkwTjWXg+M9/IXsI6PpXHpXEa6ZggBnb2bbk/Z7gguyiqMBDvX7uP6VE45OC7KYoSoaWwsGfOR6aq2A2+Xu8id2DFGZ//UpW84LKQgLIY3/WOWcV3QF0drb4alNUr6HcMkRbqEoTBpagCh/Y6kjkNlX/yktZCYxGiezoKMsd0M5uvRgwXUIKsGcPTy9URtpAGEukvlbsDq8ULmS82e1pg0BbfOSXcR0Zhiy+MafYCgEoXwyT7pPj9TqcB/flRL09yJsGf5/ctpO2PkiHQ99qDIr/8qzIBAo6o4qX1ZCRLL1pno0GeIO6sVnpM/GKacjNbsc4wE+97q+t4svklv33l6AV8cke+Kzwv6pWJTlY/IfuPdFIjsjtYU79dFcvSwYfIhQRZIx0Z0Su6kfcWMsf0zfqDEU0TiK0AXXWWi9gPVhp2xlxf2D1pwb+WS1T3n6+yOb97TTSE0Q31jG0M21f7yyQ2YmZx2UVZJ9NSNKMWbXqYUoBBIa6j0Lnos23YEUeHTOVRA4g8k0bPX44ZhWmVswDzUj8Aj0vGm4uAB7wgN47Kjg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vvpERFFjmAcA+JqWgvsPbYkHDLcJ8j5Fam8Wd2vWVvn2Z71AdbRcGF6nLE?=
 =?iso-8859-1?Q?MoPT48l9xIhXxfVst4XIk7AHAva2IHOSS10wjM5PrTkRyVvUSWmmyJdIT0?=
 =?iso-8859-1?Q?AxmMWqNHz7LzC2IsQ0LJo8zSvmcxsn5g4oTVrNd+9X/G2hnAcPHLiVoDKc?=
 =?iso-8859-1?Q?vIlvV4JjDgqXTli9W3lgUyl9UD3UzUNVP8JPwIewfq95ZfPem+ALqYyUSs?=
 =?iso-8859-1?Q?QraP03hWgkv2tadeAJgMJkcJ72PwE7Bw+3etzSuc6etsn6fAp37HHVTJWu?=
 =?iso-8859-1?Q?QxNwlOv2Jz3p82HAqU+bhMMWvAbns+OwP63GZ5Y/ciEIxhim490/zFgwGL?=
 =?iso-8859-1?Q?9JowyAML8c4OkBlpptojxXMOs60gyB+H1e7XqrMdgjNbzr/l4f/uwjCFOi?=
 =?iso-8859-1?Q?WtGd+fHjqObUGQlfLzMFgftVIoTf0KibrvFSAqLo1qZR/vLCeluYKwfGjw?=
 =?iso-8859-1?Q?wTog5iLqJFGypUpNOtRDgMtSjppJqSAWcm1GjKBFc+zdcnrEqrBRAJSAxw?=
 =?iso-8859-1?Q?KfBJ2U/izI3liRDthpmkTOypmvFRkoeHDlq+s/sUi7rN8Szc6/A7YGCIcL?=
 =?iso-8859-1?Q?BbEL7+UCSYkOcVOVa4FUky3ZnqSWW26YcGy4B0DqEaO0luiLtjWbhDa6Y3?=
 =?iso-8859-1?Q?ajMJhPPgHJgKXntudoCzd6UOV379tHTAOkVjLfwAdA3UzK93iTMJ3kQWAk?=
 =?iso-8859-1?Q?8RmIdsdQX2O06cO9dJgq5XA0In0EmqbcouSvNXQB01Anzw9msboFAa945J?=
 =?iso-8859-1?Q?i1QVF9HVqlNFdiSFkRsPkVMF0USKL8NoJ4C21r6XHbOcy4Q2XaYxNShfNV?=
 =?iso-8859-1?Q?hCxx1zve/antQykkA9T+gYXtxJwuYQPKo+lvxIgwnV11ddo7ZZkG7XF3El?=
 =?iso-8859-1?Q?pllZslOIne03mtJjQHkpHDVa8EdP5oXN9tCLwVRh+p3AbuTU1GFNioRLOp?=
 =?iso-8859-1?Q?irVcI7hzC1hDXv8EIHr5wvEvTTLTz0dwEG0NeEXTKJg+qV61/KvIuGdTGx?=
 =?iso-8859-1?Q?H7/toitfKYJgObsgVfxueF/7JrYRMBh3e7MOZPZYS8JOpkSyMHDxJwZGna?=
 =?iso-8859-1?Q?iBQbVr3m3sZC83Z9J/yvlHb9jur+lSKbInq2CiPUHLDRDBOpUHdcNlvxzL?=
 =?iso-8859-1?Q?Sc7CwbIGHhx+HKndziNl9nX7LrO5AA9C3PLxerddZXh95sLtMVjvIOO0/5?=
 =?iso-8859-1?Q?1nc8+Dg2YZVZz/u5rp1ErrWalPIJ9UUawu8Gexx2fAJwpthxvATLakY64A?=
 =?iso-8859-1?Q?nXQ/cm+EbVJj8iZwOvRv8uDog8W3B9E+bkOha15x8lW4p2BPaMIVJV30nt?=
 =?iso-8859-1?Q?dANkRLuzcv5huJWEHqI00w+6W1rs6aq2pV0M4jFTbAjBwscIKaBYYhmmfV?=
 =?iso-8859-1?Q?/Y/tL/Lda8mavoO6FMEUpbjchI+IWl2Pk2OQ9XDPdgwF92EOEibNk9u+tQ?=
 =?iso-8859-1?Q?/L/SPcGchU0971LSNTszW5wuzjrxJPCxIgOJN0ILsfwilF++OUMlpIJLpA?=
 =?iso-8859-1?Q?PxeLL/jU4O8yqfaebkTiSQoQHDby9libnjDGCPSzDoEpFRhR+T7aFY+Fjt?=
 =?iso-8859-1?Q?l+CNWY/LlBLJLFvnVrB64/ITBb+C+K5fNNmGB5SyGJq7F2QQaqMTVlu9T/?=
 =?iso-8859-1?Q?ZujTmES9eZ5rAucvF+F6+awq2eubQHMiE/apblHZzCtRA9vKFAkNA5TG9h?=
 =?iso-8859-1?Q?C2+g4al3ZX1v+FBtG/knQ6r+Xa6C3ueI1NasXDk3nQjycwdZbBlKUOttR9?=
 =?iso-8859-1?Q?qOCYQcc5tIsGWp3HyoNdtAfDcRDFuoo6bskokHv8EJinl2Gr2ennYyfCZq?=
 =?iso-8859-1?Q?4mQh4jFBfg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DIRtbZ+nWy45KD+ql3tGoDBUXGfM0+JFnbd71xUJnp/CuFN+3OZ9SwektLAcX0UQYZ0B+TDjRnnKGbjy1aIkKcJjjDl+581zhps8oZwwZBRIIqDtatKOmi1n4+0AkjPBceyahTZhOIXzLFIzAFtaPCTnyjFCOnTCuIwvD9t1bTqK3F3jBVRAQmOFZYmdyN1W5rNKKJOR7bZFYlcOhBToWudq/O1S1cw2ftNXjgxUbR5S1aAPMM0w5Z9BTRa4tiP7PHWFCNJvs9HzwgbJAMhr+tu8WtGM3sE34iLZHU9HdigW3GSGAaZMhrmaCMnnk15RlHY4M91LIWKWAMKzNWcdgg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bc208e-1952-44c4-336d-08debf887993
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:00.8914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RHZP7/gd6szJGY0RfGxmXBwzAKMtPzxj7mfvIvhJIen/6gAGUuDw86RBYe7sOS5LU6ifpQy07UdKq7E6Omhol+v0DUk/uI+cHixUNumiS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The QEMU community now prefers the DEFINE_TYPES() macro over the legacy=0A=
type_register_static()/type_init() pattern for device type registration.=0A=
DEFINE_TYPES() accepts an array of TypeInfo structs and registers them=0A=
all in a single call, making the registration code more concise and=0A=
consistent with modern QEMU coding style.=0A=
=0A=
This series converts all Aspeed device models to use DEFINE_TYPES() and=0A=
further inlines the individual static TypeInfo variable declarations=0A=
directly into the types array, eliminating the need for standalone=0A=
TypeInfo variables scattered throughout each file.=0A=
=0A=
v1:=0A=
  The changes are purely mechanical refactoring with no functional=0A=
  difference. The 24 patches cover all Aspeed-related device models=0A=
  across hw/adc, hw/arm, hw/fsi, hw/gpio, hw/i2c, hw/intc, hw/misc,=0A=
  hw/net, hw/nvram, hw/pci-host, hw/rtc, hw/ssi, hw/timer and=0A=
  hw/watchdog.=0A=
=0A=
Jamin Lin (24):=0A=
  hw/misc/aspeed_hace: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/misc/aspeed_lpc: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/misc/aspeed_ltpi: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/misc/aspeed_pwm: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/misc/aspeed_sbc: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/misc/aspeed_scu: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/misc/aspeed_sdmc: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/misc:aspeed_sli: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/misc/aspeed_xdma: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/adc/aspeed_adc: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/arm/aspeed_ast1700: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/gpio/aspeed_gpio: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/gpio/aspeed_sgpio: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/intc/aspeed_intc: convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/intc/aspeed_vic: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/rtc/aspeed_rtc: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/watchdog/wdt_aspeed: Convert to DEFINE_TYPES() with inlined=0A=
    TypeInfo=0A=
  hw/nvram/aspeed_otp: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/timer/aspeed_timer: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/fsi/aspeed_apb2opb: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/pci-host/aspeed_pcie: Convert to DEFINE_TYPES() with inlined=0A=
    TypeInfo=0A=
  hw/i2c/aspeed_i2c: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/net/ftgmac100: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
  hw/ssi/aspeed_smc: Convert to DEFINE_TYPES() with inlined TypeInfo=0A=
=0A=
 hw/adc/aspeed_adc.c       |  95 +++++++---------=0A=
 hw/arm/aspeed_ast1700.c   |  21 ++--=0A=
 hw/fsi/aspeed_apb2opb.c   |  42 +++----=0A=
 hw/gpio/aspeed_gpio.c     | 107 ++++++++----------=0A=
 hw/gpio/aspeed_sgpio.c    |  37 +++----=0A=
 hw/i2c/aspeed_i2c.c       | 113 ++++++++-----------=0A=
 hw/intc/aspeed_intc.c     | 121 +++++++++-----------=0A=
 hw/intc/aspeed_vic.c      |  19 ++--=0A=
 hw/misc/aspeed_hace.c     |  81 ++++++--------=0A=
 hw/misc/aspeed_lpc.c      |  21 ++--=0A=
 hw/misc/aspeed_ltpi.c     |  19 ++--=0A=
 hw/misc/aspeed_pwm.c      |  19 ++--=0A=
 hw/misc/aspeed_sbc.c      |  46 ++++----=0A=
 hw/misc/aspeed_scu.c      | 107 ++++++++----------=0A=
 hw/misc/aspeed_sdmc.c     |  73 ++++++------=0A=
 hw/misc/aspeed_sli.c      |  44 ++++----=0A=
 hw/misc/aspeed_xdma.c     |  58 +++++-----=0A=
 hw/net/ftgmac100.c        |  32 +++---=0A=
 hw/nvram/aspeed_otp.c     |  19 ++--=0A=
 hw/pci-host/aspeed_pcie.c |  94 +++++++---------=0A=
 hw/rtc/aspeed_rtc.c       |  19 ++--=0A=
 hw/ssi/aspeed_smc.c       | 228 ++++++++++++++++----------------------=0A=
 hw/timer/aspeed_timer.c   |  83 ++++++--------=0A=
 hw/watchdog/wdt_aspeed.c  |  93 +++++++---------=0A=
 24 files changed, 678 insertions(+), 913 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=


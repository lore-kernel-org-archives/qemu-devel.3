Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC64F436AE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkVZ-0004sY-7I; Fri, 17 Apr 2026 10:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVX-0004qM-HI; Fri, 17 Apr 2026 10:49:23 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVW-0007Cr-5g; Fri, 17 Apr 2026 10:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIeBPJ/pFdGnMsJiZ+2JU0NZbPfpoRbJjvoBjlA6yrqFo5uKjVdWgp7wDHiD0SGbqy7bB+A8iiNZjBMgPZqtreCQn6I1jKkmW2AFBO5wciCgEwNbbCcFX0WpYvMaKYefX0BdXuxroT+EOm5xyRVOdlpnH2TkC6cpe9TGQ563ltNLTVjcUAx84yZn+ac2ELhJM21PVuJXhQkX+wqfbRWC6Jl4wTrEcHJjGncYnydQ1OyDt4s2r2xON8Fwu0rUGP9oQ/dVP6yWdU0TGPfs632K4sivHIGvfMlPugydMnbrooSzqKPtnhpKvpEBuHvbqokrKhnBeDIWAXeybYADLkmGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddK7Rom0AYFdxbB8gCajhiYQui/iJNt6SZbcvbfdXOU=;
 b=iuGCWzn/z2TXMksp+ePuGcCd8zw8JT2z1pHdb/eNwg1CRPajrqLgybJEmqgMAUFBaobB7fU2DSZCW9AYPsgwhP2LcwoFRGEyr0fjkRIzAKp1CXJ84xAGh10mx4Vp3jSWlFzgYtZV1/LtKLU9z9Eypb2/CZJebTwwPpV/FKNPkmP2gPIFoJAGYO2Skz5CJoXEKurbOMcBwzrb8qGfh163cJCfuHi5LWXThZfOMSJ0MmVL8vSH2cLYUQpJaiw3jpNiMyljaDKv1n25yNCPcURn/XFCSMch+6yzveKzeR0Dqj/XHzc1dEW6xB5N6KTMnwzQw4SxLZJ5TPwDrfG25eQnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddK7Rom0AYFdxbB8gCajhiYQui/iJNt6SZbcvbfdXOU=;
 b=OXb5cS6emEviTbv5LGwDbh3d/T6kBlDNdCs+QdR6m8aMzbabVWziZsKSm1s4Pv22HonB0h+/xJXU8fghc+x0yOyhrSybbOjE/dFUEtRt0X/hegeWT+YNs0q+EggqroMEDz/W1+XpZFV6Pdbk9oiR2SQlihWeZVr6jhg6rxBVk5tCgFQAzCCzpGherHTpiZIk2E83JOERtrePoU+FbKlDQayA1adlYW5hPyEDMl8vnbqj1WkT2sZMJ9EX2VUpnjfbElthIXGcOfrdktdHBzZC3Or1rKIAMIDl7h31PCaSvPPX1FVH/QrKtHmPBiBI2cISFkjXyWzy5me2PlnZfXLm8w==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by VI0PR09MB8150.eurprd09.prod.outlook.com (2603:10a6:800:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:49:13 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:49:13 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v8 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit
 masks
Thread-Topic: [PATCH v8 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
Thread-Index: AQHcznlbGfWgzQqaake/gvC4iYEMcg==
Date: Fri, 17 Apr 2026 14:49:12 +0000
Message-ID: <20260417144905.178056-2-djordje.todorovic@htecgroup.com>
References: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|VI0PR09MB8150:EE_
x-ms-office365-filtering-correlation-id: f5834115-751d-40df-c5b6-08de9c907ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: /P1dms/UzXV8v02GqW/GHEfkLsnPWUsGr+aqpJvqT1dqEOckQMDNoJsKElMTHJcOmgSJvaCnb0N0Wd00gRoAavXNG4KvoWnitYT8sOlCE2KoIwS43fbw76hxLh+W2ZYyLKFm7OB+brPT4svYxAPt3pgocrZ0l0H16HWlxjDQPTT4zFLHso66WNC1Iht6zc3C+v79WYZWtc2d+uJw1zNLF7pX+6lIt0QRZGJFGq4H1+V8jU/oW07geI/FncO609sEGndnF5QYFIibl+1wARYfm4M7elbRIKJGyf3UnRb+16YEf5IfJlEw9n7+yLYDGY/AiiJpsgAjCQX7J/k0lO11tvuywNK3MqguMC+9c1Rd1PV2H5WT0BMm5rvlJWlXsa2LJosjeh4sbdHvFeHeYWA5/+S+UyIhVvE39GDWYwzypp+k+BnBTkSnzDypl7eQvHVWIk57nO+bF93LgupJeu1x3+EAYwJxAUZiHfDdTYl57dcFWLchCx4vrQP68TLusuOCdiMX8PkNiIfe9NdFcEJ2Ked2i3hnXDIEru9NOnh+SKstFo+2EreRsL+tu4wqr+jHsS4hLbPcME0xPjAMXqBd7GU3yc4XvNOtoCoDLWadYaFMGVlxWDSup+mbTkrX/MmdBOP5k5Y2LNEY+UGYxPGZoE+sZ0yyXHU3ShTxiE8FQ31LS5p7zxqq3uRHu1AtZ19S3Yu27gTTqMhQGboVigXetf5ta1Y8BCLskjHPe81TuRUuhLF4rjCdECNsOOiGsDIvdU/nSfO/gINV7cP9LxhLiTCXEHdJhCzdrObn5t2/LvI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW56bWFYRTV5QWplOTVUbHRscWs2K2JiOTdwRlR3bEIxYjIyQVh2aWQrU1RK?=
 =?utf-8?B?Rmx4T3NXQnRRamwvSTJ2U0hXSnRPT0loc1RQNjVGc01rZ2hmK1V2S1BIZXd1?=
 =?utf-8?B?ekR0YmpmbzNEazJIeUN1eUMwZlFiM1M0UlJaNDZnT3hrTjVoenpiOHZ4NEdW?=
 =?utf-8?B?aHBlQlIvKzcxdk96QXRURXBmQ2ZXZHVReUhJN3FhQ3BiUjVnM0dXUFlXL2ZG?=
 =?utf-8?B?UkNqdlBUaFplb1NoWmg1a0xCbTB2QUpNYnBwbkVJOGRlbzFDZUZKaGlCM0Zk?=
 =?utf-8?B?cjBUeGltUkpkdVdwNnhvMzFkY2hWcG5PM1hFRnlEeUNmeENvNmQwUmgvQXZC?=
 =?utf-8?B?Q3h6ZWQzWWpUbWRkOUtwYWVDS2RIcmZKdlA0QzFKYkU0SE1jTDcySHJ3R3hl?=
 =?utf-8?B?TTVhWGpzdVM1MXNoek1Pd3R1UWxYc3ROQTdVczVDMHljdnRtV1F5ZnVibDhL?=
 =?utf-8?B?VFgwQVBRZXhiTnhXOTVDM2laeFRRSzRzN21manlMMUswNTlRY3lmUlA0Rm5t?=
 =?utf-8?B?d3hsOHl5MS9OT3pZYWtMeU9xd0I0QjE4U2ZlbmE0MmpOejlmV2VBR290emlL?=
 =?utf-8?B?RHZkNW91L0kxQWdOaks1Q2pSdmp4NmZ6allyNlQ3MDRtMzhkRFpTamp3cnM5?=
 =?utf-8?B?azVWWFhjcTFQdmVXMWdwSVEyZ3ByK3JkZittQkJvYnBTTnRNUFh0VkluTDdp?=
 =?utf-8?B?eTFxQUtXQmhQaS9PMWIxUjZZUnlXTVhBeDdMWlFZd3RzQkdKaTVkbGlOK3RH?=
 =?utf-8?B?SlRSSG9JamlacTNDNEtCbk52SUVYVVg5a3EycThDRTBIUnk3NWJZQmcyTmNS?=
 =?utf-8?B?cXhDUXg5N3VPQW9NaDRxNTlCNVVKQlJWeEdRTXQrcnVzVnl1K1VOcFRpZVpr?=
 =?utf-8?B?VTNnMkVvTEh4UDgweTJGanAzR1JaVytBTXZKQ0QzNXp5STdnb0M4dUZtVmlM?=
 =?utf-8?B?NXgrRFpXb3NmZFBTYXd2VnRuTlZMdkl2bjhyS3JuT0xnaTg1TjIzOEZQSXdt?=
 =?utf-8?B?YnJWMHBJNFMzdEZ6OVg0U2FZQU9uZjBoV1hMV0JXSnM5RlVWckE3c1VON0d4?=
 =?utf-8?B?NHlsczhIU0RSK2FSYm80c0FIYmQ1YzJaUnJndHNLRWJTT3lLWjdsRHJyaDVE?=
 =?utf-8?B?TWdQRGJUc1hmNVM2M3BSZWQ3L0RlK051cStnRkdDcUIzSzdJc0cxZ2Y1OExi?=
 =?utf-8?B?R3JLVm5zUjFvd1dZZnFiNFpJUGZsTVpuZ3BZSnJ6U1RPcW5jRzFwbzJ1WW1O?=
 =?utf-8?B?OU1ENCtpVW5HVmJ3S2ZoeEpLUzIwVjJTcktkMXZCSHA2akVxeTJmaUVFT3J3?=
 =?utf-8?B?UFVTek9XUDFYK3RJZng5K1VZTXBjeCt6ZkpHZTVjdTVzeDQyYkptaksyRlFY?=
 =?utf-8?B?VmVreVFPMFZmQ01WV1FjckVYSnFEaHExVGZZd0xUNGl6VTl2YjJmdVVKMk0r?=
 =?utf-8?B?cTlsRkpqNVNITGZ6NjFqTENQZE45VFBveFcvNFUyVXBxaCsxaXdxNEpwVGpw?=
 =?utf-8?B?TkdoYmV6TVlzK2ZkNnVwcUtENDFBdEhOYThwN3E3U2VneW04N1ZMYnVxRHBt?=
 =?utf-8?B?azA3NmpLNkFIQnVTSXFYWmhEUXRKK1ZXOXE5aWhKSEhhQkdmZExBRGhKRTBT?=
 =?utf-8?B?OXBsbmM0Zi83cUkvT09qWmcxYnFXWUlpc3RDMTA2L21HNTRMR1ROKytrSmk5?=
 =?utf-8?B?azh4MzIvaytxb0padW5VUjdvTGZBZDZDY2lqdnBzcjRrdkI2N3I5akpZUTNE?=
 =?utf-8?B?b0hNaVRFM3poN3doREt0SER1L0Yzc2dadkZaK0UrdG10aW9yMmdSSUV3UEJ1?=
 =?utf-8?B?ekNhN3VOaXBOUXhHendyMEtYVTg3bU9jR2VmUDVSK2tOV0pPZ0c2TmVUbDZJ?=
 =?utf-8?B?SXJ5MUtCdjN1b2tWTWtSYzJDY3Uxemt3dCs3WnhxeEtvRkhqeVVDN0dZVlVy?=
 =?utf-8?B?YlluaEZFamo0MjJVNVVqdHNhazhJRk5UL0lBSVJzbXdQa3BLQ2FNRGtuRVNQ?=
 =?utf-8?B?cHF3NU1WZ3NRc2hxTG1QVFFjZ2RpWENDOWxjcUsyVWpTLytXQURFNVdScngz?=
 =?utf-8?B?a0NoTk5qZlJGS3Fjck01N09rUVBRSGlDV3NLWFRlK3ZmWVlBM0ZPZk90NkZt?=
 =?utf-8?B?b09VRGZqSVVpRU1pMFRxQzlTdkp6aUcrU1U5dHBlZ3p6czZjN1VjSHE5S2Rr?=
 =?utf-8?B?cDd5ckZ0dHRycjdMckpkYVByZkRvVHNqSThVR25WYWRFY2xzbjNRWDcxU01V?=
 =?utf-8?B?UkwvdjdacytIY2R2TmZBTVZaemc0U1ZtWlJqbFJtZlhOOUlxYUdQdXY1bFhT?=
 =?utf-8?B?RkRFd3d3NUpBSXZ3S2dlWjJFbGNqODVYNWxuNUNMM0dUbVlSK1lhQ0Fja3Ar?=
 =?utf-8?Q?T+ZYFak7VO5YmuywXqUHkkSMA8Qm28WJtr9jO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65879F63B8FABF4B943664FBD701BF3D@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5834115-751d-40df-c5b6-08de9c907ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 14:49:12.9138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IqjHqM5l7G00AHCSldeccyQdpDeuoyRkXklvgke4G6YcEZRelrQuZHsf536u2Sr0F0nhxiYRYZ8iIr3u77l503BbBZ7F/UqRZ5StprUxkis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8150
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

QWRkIHRoZSBSSVNDLVYgcHJpdmlsZWdlZCBJU0EgZGVmaW5lZCBiaXQgcG9zaXRpb25zIGZvciB0
aGUgU3VwZXJ2aXNvcg0KQmlnLUVuZGlhbiAoU0JFLCBiaXQgMzYpIGFuZCBNYWNoaW5lIEJpZy1F
bmRpYW4gKE1CRSwgYml0IDM3KSBmaWVsZHMNCmluIHRoZSBtc3RhdHVzIHJlZ2lzdGVyLiBUaGVz
ZSBhcmUgdXNlZCBhbG9uZ3NpZGUgdGhlIGV4aXN0aW5nDQpNU1RBVFVTX1VCRSAoYml0IDYpIHRv
IGNvbnRyb2wgZGF0YSBlbmRpYW5uZXNzIGF0IGVhY2ggcHJpdmlsZWdlIGxldmVsLg0KDQpUaGUg
TVNUQVRVU19VQkUgZGVmaW5pdGlvbiB3YXMgYWxyZWFkeSBwcmVzZW50LCBidXQgU0JFIGFuZCBN
QkUgd2VyZQ0KbWlzc2luZy4NCg0KU2lnbmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRq
b3JkamUudG9kb3JvdmljQGh0ZWNncm91cC5jb20+DQpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZy
YW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCi0tLQ0KIHRhcmdldC9yaXNjdi9jcHVf
Yml0cy5oIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgN
CmluZGV4IGI2MmRkODJmZTcuLmMyYTNlZTRiZjMgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3Yv
Y3B1X2JpdHMuaA0KKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCkBAIC02MjgsNiArNjI4
LDggQEANCiAjZGVmaW5lIE1TVEFUVVNfVFNSICAgICAgICAgMHgwMDQwMDAwMCAvKiBzaW5jZTog
cHJpdi0xLjEwICovDQogI2RlZmluZSBNU1RBVFVTX1NQRUxQICAgICAgIDB4MDA4MDAwMDAgLyog
emljZmlscCAqLw0KICNkZWZpbmUgTVNUQVRVU19TRFQgICAgICAgICAweDAxMDAwMDAwDQorI2Rl
ZmluZSBNU1RBVFVTX1NCRSAgICAgICAgIDB4MTAwMDAwMDAwMFVMTA0KKyNkZWZpbmUgTVNUQVRV
U19NQkUgICAgICAgICAweDIwMDAwMDAwMDBVTEwNCiAjZGVmaW5lIE1TVEFUVVNfTVBFTFAgICAg
ICAgMHgwMjAwMDAwMDAwMDAgLyogemljZmlscCAqLw0KICNkZWZpbmUgTVNUQVRVU19HVkEgICAg
ICAgICAweDQwMDAwMDAwMDBVTEwNCiAjZGVmaW5lIE1TVEFUVVNfTVBWICAgICAgICAgMHg4MDAw
MDAwMDAwVUxMDQotLSANCjIuMzQuMQ0K


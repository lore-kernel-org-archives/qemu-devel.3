Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD52FC624A4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1EUF-0006L2-5W; Mon, 31 Aug 2026 22:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1EU7-0006KQ-Nd; Mon, 31 Aug 2026 22:44:27 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1EU6-0003Kq-0M; Mon, 31 Aug 2026 22:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptcRkEm1/ZHq93YBU+gycFZ/Z5Yp1hsvsJRvqs+EAI+K/s8cUvo6dgP3Nbpmhj3XpV0EAOJ/lVdf4bj0ISnUjIUecsGsZX/1/YTlUzFhVahVv3LPr/HjrAnUIohsAmZYwtI0HCYORz6H7zh9e0R5CwezN2guqOSA7WW15TeVNOgY6Ci8UeIr9iCZ2mt5OoCHCf1+A5cp4mAEY8aP8GR+ELqfMy41IHJpnXfAWo6swSPnXx1mKDFC7CrubKnH5HrFleOr8djPQgpJ2g2gwMqvNNOiQP0hZ+xJP4v/c0GdKQQviExi6effMupY/OAwcrUwny3u2e804IK2vAXX1C5zww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+bzWwB7kQD5omyUZ3eGF8MktAp0NFMKoFFNYBTtuX0=;
 b=IS2PZ9j/C/RekfvBTIbxOprrvxmljDEdsUZPy48AdbL45SCVYJRYE8Rr7o5iTgMTGnI6+oOG55m1EYjffLzNgDUB1ee+fQ15VDZV/M4iwPEIsZHNwddRCQy7odCHrSKz4MxAmlFnqZPKgCc0spoypvQkhdwuJ2d8T/Zz9gWHP7tc7fVyzPrL8H/kUvN7xUhHtKj2c/zXVZO9aGhf7eB2lVWaEvwDgQacb+qBehr5da8ujFo/Lc0Qa12dUQrbehCXNRNVKuhfTBppKP04dwAGcbmc1EulEKCEN9L0xRBfnXPfg9S/9DiPLn8z5IfTFRR2lF+7dcnB5A7+M3gqPYvVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+bzWwB7kQD5omyUZ3eGF8MktAp0NFMKoFFNYBTtuX0=;
 b=jg1F/gK3Si5Qtu4KCUsHM9s6Z8Rd8m1OiB8SIhZIihYhUqvkwp+ioI9jXtkChr/sG0a+MH2hrf279pEggv3+tuBFyIyqrkptdIGqtj2+EHHU0Rt8nKc3JIAOIcN5/hRetwaIn++m0Snefz27vj9EpAjPaZlpbdAS70CX9wlqSgJO9yUgIO7HHI/cLggeEUzVXFrXoSC6g1sD4n0/OSTYiK8OtjqSi3wklBegInv/ls31BQbvKEh9O6F7qI0DdTH4Q4fyb1zwLeoUnQRkRr0RCT9ClaZAmLzB+ihYR/gdN9ipZpnJ220V9F3tAu1LnBW87QDWF1i8dogEuXLU5MWkkw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI4PR06MB8448.apcprd06.prod.outlook.com (2603:1096:4:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 02:44:06 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 02:44:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Topic: [PATCH v4 4/4] hw/arm/aspeed_ast2600: Wire up the UDC
Thread-Index: AQHdObvBv4uu2bw7/EytaYA1Jvsdcw==
Date: Tue, 1 Sep 2026 02:44:06 +0000
Message-ID: <20260901024400.3488429-5-jamin_lin@aspeedtech.com>
References: <20260901024400.3488429-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901024400.3488429-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI4PR06MB8448:EE_
x-ms-office365-filtering-correlation-id: ff921511-c123-4f30-5264-08df07d2e459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|921020|10067099003|5023799004|22082099003|18002099003|3023799007|56012099006;
x-microsoft-antispam-message-info: 9qa7JjdtDR7hewptNOwRCAUbFeychOwtnZ+wiVTTchAR1AO81QOBVwo6CAbSlAuV0iwuXBhVpRQKlxrSv2mKLCPoBM4LAtT6WBu1wEF5FkwX4GhZvtgdS35VKOtlg9q6go+3KGMDknlVnmoY7w5a7KQJ2IM9KeZdYJHUDg9toUVHTOvdzHG7YQz17YVPKlO95PU7/Lav0rHs66VdvdODV2oTWiiJ/6FlueWw2GAw2WrmEvZsld985fyEyvH9WwAJqWHkjlPV0FRf5skGtlibzbnbdw3x7wQDYquxx9RwOw27n60tQPwtkPM4Vdi/Q1Hq9GoXEkmxtTwv5ZKCpUt//X0PlQBNlDF3jUoKXfSmZ+u7o5miued4jqLAVag002klEeLuDR2kUxsT5bBqkqvFI3JP43ykHEhjayG/jYZp7f00jc/BzV7siabELLSqAgEuqu9RKQ2RrSurW0x+Rylfj0X1WCkRgUIlaMto3vD1d6fIa3OSFSnwO1f8nOSQaRQtYcEHvhWjDbA7aJtwcA4Ry0kaF08CtO+gVuulyvhsK804e0F155PAgLaYVKmg6Kld+RrCRyhluAkb1USX4UOQ2D4zu7NsMde4Eo1r7VSDRMXoc1V79rH3PR4y92aN4a49huLnHCWTk5Qii2WJfjaqiRsL9k0aqCRInHid9ZWyIB7cXO5sO62gURSAR86RxHdrDTt3HmzIq+6vn2Dg4/cjTeJJ/zloIcA8VHvxPUvGj3o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(921020)(10067099003)(5023799004)(22082099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rLoqPgXi5pCYd3t77CPs+xhsXGiIjWvVj0GQ/o1KmoqzQbesmpsKhCOI69?=
 =?iso-8859-1?Q?wliTmgrl3FWMeZLBHSys9U0GQwn5s30ykxY7KvhFAlqsSimo5bRXiVJ1f/?=
 =?iso-8859-1?Q?J8N+IsIlFgh+O0WYW7EdEE5zjvUmeWHohMN3Yse+Q3/qC4cIPPTsLg0tJO?=
 =?iso-8859-1?Q?fvIyJf33FhbMO9Nth2SHVzGjOUj6jSxiosQ5lyrmtcI8aCqYZ6BRqbohd5?=
 =?iso-8859-1?Q?YdiMYZ7s1mjSE5nuRhQEZZoMrvnZJH3yC/4MoUilUafIBlNTbjTTGTqgub?=
 =?iso-8859-1?Q?rpZy1neO1yiLJBGUHN+Ena9qBfMK4h7/iU6A64DioNPPsKlqaLCJhUIq73?=
 =?iso-8859-1?Q?KpL0Ti4iiE6uKwqXiqt/J6uXgRXNe389pJY64DS+4bhQYhwWX0ez4URpuy?=
 =?iso-8859-1?Q?cMRmgx0JgwbfzaMtYy51ft2DkxQlFCS3HNfZ6Y3/Xz4cx27CLqlljlAqLC?=
 =?iso-8859-1?Q?1X9+8qNHUtfGru0PTOS9/pF717pUS7IcDXI81nlfJlgAor/r8ij6NvsVB7?=
 =?iso-8859-1?Q?hPrzdskrPgPS20p+uJWTLSHo4KasEbNil09zxnLZKUoFMLDWyOsR3n3omy?=
 =?iso-8859-1?Q?ik1NrvKDI7yChRmL20Q7+wmu79fBy+hmVd7XEDCaeAMBWIg426jjl6UBTJ?=
 =?iso-8859-1?Q?XlvBjqxpGFgFVOw3aiUTkq45MhgMY/WcyHRcGmf89qLN/ta25bPkxbChKk?=
 =?iso-8859-1?Q?lK4mTfzTsYXZXuYSWpiPKZOHWbV/amMrRMYP3dhhcFyZxioOH42Yt3otjA?=
 =?iso-8859-1?Q?KSilnaMd7/IIWOzO6lbw2fzAz6f7XE6uFp0IVvicgtif8TAiZRr9M4XjfY?=
 =?iso-8859-1?Q?Kp6MMo7DrUcw+pTusUnD2j0X6cKhA4AEpLAktiTeg5+mZNH1aGwYCF4ani?=
 =?iso-8859-1?Q?OR4K7NK7kztyfNfibREFv7BJ3N95cHeblitsCC3lE08+uXvX8PTbgeR/74?=
 =?iso-8859-1?Q?QfLZV3rO4pQzWoBR/+DViGO6OC1zYOA0fWmF0VV3Q+h+wzHm/CgzsLsd6c?=
 =?iso-8859-1?Q?e+xXMl1Lzvo+riWXQx01tF4rJTC2mJbWRtSReJ36o2IgwqAVwcHTW77HYD?=
 =?iso-8859-1?Q?2AsFtBj53PmGEITXHhGymU3Iw6Wnd/9FOV1IWQ0irBTNEdmKyXbIqA+yoC?=
 =?iso-8859-1?Q?9UtWVRdWPuHVJUafZNiN/R9MHSZopkGakM1umftCJgC/+SkucfUSRUqml/?=
 =?iso-8859-1?Q?myobiwNjmkuDN3X4g1L3Y7L/7cE1YTyNmmIWu+1XHvSbe8ZQy6KYHU9vKP?=
 =?iso-8859-1?Q?N+31R2eNbxIJN0zXs8kK9Q3LzmxdZMgCVwbRM289Wiv9nk9vwNw9jNPmbV?=
 =?iso-8859-1?Q?GlRKR9okbks+aUkbVIElmXR3bSdy6G6H3ZjyTI94XIL8onLozym1Jjqo6F?=
 =?iso-8859-1?Q?BchG3qUF4SBlKDBKtOE4/TbbcG85Lyu69oqXg/zmHO7TZszeDFAb/lJW9n?=
 =?iso-8859-1?Q?mnGJ/HqtHcDd2TnNpCSRLqMky2FZoQ4inJflHaQuVynSQxOthnu+OK6Por?=
 =?iso-8859-1?Q?f785KTmhdpb6bLDTXbnX7GI93o3PUAwEUE119M1r4kQJNlp6RGnB0t+JhP?=
 =?iso-8859-1?Q?oh8gYK5Yo6b7KtuEitXfRVV3VaP1W3n4OQoK46xi3ER8tQKfq+kcwsciJb?=
 =?iso-8859-1?Q?neR/aOwhbgvdl08AndKt8R8hA44js9aldxNq+q9z5QvyX2gPZhGpZ3Avz/?=
 =?iso-8859-1?Q?G/Ra8qu6yzJ8SsMYHBUV93Z/QNB02paNMcBGXP9xmHo7xC2ueHMbGqHbn7?=
 =?iso-8859-1?Q?C2SO0OlgQqMb1sgWRKsajoSLJ0UeX9/b+y+ZBgjwdfrOI/n+gczjwO7gkt?=
 =?iso-8859-1?Q?3oPOTT1Jyw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PXFmMp/ni0NdvIamfjKIhCU3Z1ygXcWNv1ImgNWYU72/7ftNKYRAUCHNSnohWf0gS3JcCJ+XFpaFiOyUpfGgMg/g8fV56yqVIozTq9zV3aEXFxoiEXQMWxz9S2Aienc1SEEBBTAB0UNjNZIxu4MoSJ6UI5inTQiUVA/7N3t9hLa/WfvZsxlbiX2qY0EBixOKaGHfs3WI2vHNba7NUQsfXI1DpXu5E1AVV1oHouL30NNQ+3XZvyFGIJpsUjonxS/Z69tlXm7NNPENMTOtqbcN0xSGDpHGpYfVvOJ+NKYJ4sFhi7OE0/bG3ug81Hcpe3Mk3Qf7MwFW/nKVDAcmT2LQLg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff921511-c123-4f30-5264-08df07d2e459
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 02:44:06.5175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uw6kcxq+I4ObEhZ7IoVsrHsbr45RoztEYp6Q7D3v5zsMKwK2p7xctuthhqxQJwtPPvsLRv6eikVEuuM9ONpnacHqGPRudG4ff8NrvlBfDf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8448
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Create the USB Device Controller (UDC) at 0x1e6a2000 on the AST2600 SoC=0A=
and map its registers.=0A=
=0A=
The UDC and the second EHCI host controller (EHCI2) share one SoC=0A=
interrupt line. Route both through an OR gate whose output drives that=0A=
GIC input, so either device can raise the interrupt without the other=0A=
clobbering the line.=0A=
=0A=
The gadget USB device is not created by the SoC. It is a separate,=0A=
user-creatable "aspeed.udc-gadget" USB device that the user plugs onto a=0A=
USB host controller's bus; it finds its controller through the "udc"=0A=
link property, e.g.=0A=
=0A=
  -device aspeed.udc-gadget,udc=3D/machine/soc/udc=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  4 ++++=0A=
 hw/arm/aspeed_ast2600.c     | 37 ++++++++++++++++++++++++++++++++++---=0A=
 2 files changed, 38 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index cd68c7f1ca..fe7b31e42c 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -36,6 +36,8 @@=0A=
 #include "hw/gpio/aspeed_sgpio.h"=0A=
 #include "hw/sd/aspeed_sdhci.h"=0A=
 #include "hw/usb/hcd-ehci.h"=0A=
+#include "hw/usb/aspeed-udc.h"=0A=
+#include "hw/core/or-irq.h"=0A=
 #include "qom/object.h"=0A=
 #include "hw/misc/aspeed_lpc.h"=0A=
 #include "hw/misc/unimp.h"=0A=
@@ -138,6 +140,8 @@ struct Aspeed2600SoCState {=0A=
 =0A=
     A15MPPrivState a7mpcore;=0A=
     ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */=0A=
+    AspeedUDCState udc;=0A=
+    OrIRQState ehci2_udc_orgate;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index d1f18e471a..21db95f5ae 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -32,6 +32,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_SPI1]      =3D 0x1E630000,=0A=
     [ASPEED_DEV_SPI2]      =3D 0x1E631000,=0A=
     [ASPEED_DEV_EHCI1]     =3D 0x1E6A1000,=0A=
+    [ASPEED_DEV_UDC]       =3D 0x1E6A2000,=0A=
     [ASPEED_DEV_EHCI2]     =3D 0x1E6A3000,=0A=
     [ASPEED_DEV_MII1]      =3D 0x1E650000,=0A=
     [ASPEED_DEV_MII2]      =3D 0x1E650008,=0A=
@@ -214,6 +215,10 @@ static void aspeed_soc_ast2600_init(Object *obj)=0A=
                                 TYPE_PLATFORM_EHCI);=0A=
     }=0A=
 =0A=
+    object_initialize_child(obj, "udc", &a->udc, TYPE_ASPEED_UDC);=0A=
+    object_initialize_child(obj, "ehci2-udc-orgate", &a->ehci2_udc_orgate,=
=0A=
+                            TYPE_OR_IRQ);=0A=
+=0A=
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);=0A=
     object_initialize_child(obj, "sdmc", &s->sdmc, typename);=0A=
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),=0A=
@@ -561,6 +566,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
                            aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_SPI1 +=
 i));=0A=
     }=0A=
 =0A=
+    /*=0A=
+     * EHCI2 and the UDC share one SoC interrupt line, so OR their outputs=
=0A=
+     * together and drive that GIC input from the OR gate.=0A=
+     */=0A=
+    object_property_set_int(OBJECT(&a->ehci2_udc_orgate), "num-lines", 2,=
=0A=
+                            &error_abort);=0A=
+    qdev_realize(DEVICE(&a->ehci2_udc_orgate), NULL, &error_abort);=0A=
+    qdev_connect_gpio_out(DEVICE(&a->ehci2_udc_orgate), 0,=0A=
+                          aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI2))=
;=0A=
+=0A=
     /* EHCI */=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
@@ -568,10 +583,26 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)=0A=
         }=0A=
         aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->ehci[i]), 0,=0A=
                         sc->memmap[ASPEED_DEV_EHCI1 + i]);=0A=
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,=0A=
-                           aspeed_soc_ast2600_get_irq(s,=0A=
-                                                      ASPEED_DEV_EHCI1 + i=
));=0A=
     }=0A=
+    /*=0A=
+     * EHCI1 has its own IRQ; EHCI2 shares the UDC's IRQ, so route it thro=
ugh=0A=
+     * the OR gate.=0A=
+     */=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[0]), 0,=0A=
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_EHCI1));=
=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[1]), 0,=0A=
+                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 0));=
=0A=
+=0A=
+    /* UDC - USB 2.0 Device Controller */=0A=
+    object_property_set_link(OBJECT(&a->udc), "dram", OBJECT(s->dram_mr),=
=0A=
+                             &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->udc), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                    sc->memmap[ASPEED_DEV_UDC]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&a->udc), 0,=0A=
+                       qdev_get_gpio_in(DEVICE(&a->ehci2_udc_orgate), 1));=
=0A=
 =0A=
     /* SDMC - SDRAM Memory Controller */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {=0A=
-- =0A=
2.53.0=0A=


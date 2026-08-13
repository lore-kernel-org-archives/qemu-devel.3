Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5505C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuOru-0001Yf-Gz; Thu, 13 Aug 2026 02:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuOrY-00019w-97; Thu, 13 Aug 2026 02:24:24 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuOrW-0003FQ-JS; Thu, 13 Aug 2026 02:24:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tq6gBP0eZ5Fv+5cP/IzbYZ0PJACJ0NzbMlUxU02UO/pblrLfP/qJ0Sm4OczkH7XYE10ecFgBmw9gGjWPEy8kGc74EuFjAshFGOTqwJXjFTZS/uvnEYkF38flyUR7euHjlYY4SJ401C79vyMSwhGv+8LZjZUzcTaDh3NUpQJWu9IkK5SX+oSs536kBCPqJPBAqQDNBSn1551EMsfqcz8W8tQ5d9WWxgu4ZuPbq6lnuwyclcxaZtG0OYPEqEiHGIeuPCAJK8Ek9cX+hWgmvT7PPwF/OI5e+8+6eV8nzp+w3LiuKhR9pfoFe17Sf8f6JKT6Pvkl8UgcYAW2Ac7IJP02ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLK86TSGu35Kx08sfLKmpYOBUp4eCZ8WTV0OI5zuXIM=;
 b=W9DT84pokCc7+63ztc5uuOHCvmZI5YO680w9qaag2f6QSrMIRynJm0LBrINIZ39MvOrTbaUoCUjdTjIZHzW65FjAXUVKOVaYUwz+pvvtiPSSjXM7kF9XNyRrfQSCPr7GsTqVc1+ciocOtACCvea9mKK4pZPbnOIEcF/rekzNzjNQGwVvJY1F61lgnNC2iZ8X9+Whwm3mHjKLKXU/YIrkV5eLGNaVx8DErCEWd+XlAYut96CA0i7DS3VMTFMJgvO26rMJQwZSIwKeUuf8/RH6zgmGZxFc7tpBPCNHhvy/06DCQUIj1vpx5MiTFimMN0YDjzIQMA8DdeAz5L9PsbNMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLK86TSGu35Kx08sfLKmpYOBUp4eCZ8WTV0OI5zuXIM=;
 b=imm+BWhi2kY/iE6z0i7KvbLeuwEHMMSz8S/wxE87KQsbjlnJJ4vJA4LA8uBDeJz+SYHv1xApMejQrylQMqNN5/t+DW7ORkwFEUylpMY7bkkpZZ+D0aRWcfPvLKDSdIwaw9hrAjQ7zxKVPXR9jHk8pvP0IPLCfg7YC4gLN3G9frR/iXKgtKh79zP+Ll+mTa4nac+FbobncUgUC0yfbEOxwQpDXnGeUgVU30q/02L2QIDOVd7jjvxXvVWOFXj+2NFm3cDQi3iJC0is4KI2bDxJMXi1ErO+UM2nAtT6K1Tiag8bC5HbXBC+mteZueo2qDs90jQg9nVfUSqLFYmQG5VuZw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF56FB370CE.apcprd06.prod.outlook.com (2603:1096:d18::496)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 06:24:06 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:24:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 4/5] hw/arm/aspeed_ast2600: Wire up the ACRY model
Thread-Topic: [PATCH v1 4/5] hw/arm/aspeed_ast2600: Wire up the ACRY model
Thread-Index: AQHdKuxXaUO1MAwdxUmSzukN2Gc9LA==
Date: Thu, 13 Aug 2026 06:24:06 +0000
Message-ID: <20260813062359.425268-5-jamin_lin@aspeedtech.com>
References: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF56FB370CE:EE_
x-ms-office365-filtering-correlation-id: 8f5fa8de-f9eb-4d74-4902-08def9037a5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|56012099006|10067099003|921020|18002099003|22082099003;
x-microsoft-antispam-message-info: tMFo6Iu+W4p9SD3CvX3obKU7n3SwHMYxi7QuM9f+lvpFluFeYKdLPl6nuN+K+5bguidhStAu9Lm9B1+/AbEsmPzaFQJ/tJoHs68z1ZomRwKzs9lw6MDoLUPF3rG6/VOWhFMT6X9invjJ4a2Z1FwO74Xsf9Q8hRtht70e2L+1E0eY6slXgWAnvS9b+1E3IohWggJeOz7xYiXq9wv5RV+tD01bS0a9KL17P0uU0QKqjfQazkNEo4SyNreOvegyAaf27ymZRlclz9rKlmj7HkYqy7fW+Aro0RuybEfk3yv3V+8NozJ+kp1GMO2yPOE8+u1LEqOTT8Cwy4g2qew/ox+Sg3kZCgdOreBpfw9os9qoEyL9Zi1Q48LgRElfAUSBt90ncYJsllJuMh/xWCxt+PkL6ZX0pGznR4QKnSeJ20Bex5rQPT5hmywPDH2RSNaW0+1mJrBjjpG+pFZcdvVA4iZC1Hc1DsgvAdTMuqPOEpH5BtSfY8k07UEmDvjqL5fyNflSHIP+kqqYXm0Gv8vdOCbX5DCb8oRTJFbbd0gxkSnYLVuY/uEn/ODDnu5MtKnvpcpHcIEvD9mkmrCvOWcE5PFJFSVW7fZTwX6zNJGHdg436c7mtK1ac0+vvo19rH3V0RJ7X2TmyRxzM+ZTtrV7IGvNaNSB8a0ODv69RAtnOF+Llu6eeP3KTBtquFBZzUyO5ZwEtlZ6+tgy8/3CUORS3lK8h8ivuUK+vX4MVeizyJ8zy2v2+MI8x023++8rDKiWIhAG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2Ja0F3l3T/3Qeck1V3HJ7y3sv8kGwSaaQ4DegEdlhKZ3ZoSA7wnom835hX?=
 =?iso-8859-1?Q?yYBGuvw41wcOKEM/POOZiUn6+5mzWotgEnflXXGg5DD8x0seR/PwxUKuS8?=
 =?iso-8859-1?Q?xYA6Ctoy9avBkKyBHw+2H5SAOZTUV91vhE0xRxt82WfGwpiASTQAM4x+tz?=
 =?iso-8859-1?Q?9IychcZDxxhOI/JIpRKyZpKV9Wq1cw5x2w+A5Nm66evLy+B+PydciZqjkj?=
 =?iso-8859-1?Q?dH/4pXPX6LWt+AKhShoOO/86PMxGjta8HXzpx0vglJ+C4+y+eTTR3qYX7/?=
 =?iso-8859-1?Q?MG2TQeewrT13oupUJZwUxIhlSl1qEHT+gwmKpqghjA0xHfzcCG59kX7d1P?=
 =?iso-8859-1?Q?YoaRo/e30wQ49gmuM9Zd+ExQaQXxhIJ/L/dO7a6zL7OG6MD6bIL6xH9mwh?=
 =?iso-8859-1?Q?CgoHGZvWaGariv6X7CdrRgMHS0vq7irZc7IB5/Ubg4FXeggq9Kwq/ylm3j?=
 =?iso-8859-1?Q?MPFLlhErxNH/mHBlAZqpUQVof6y5wXjffK+rCHJ3yX9cgIbTQVaelziqcJ?=
 =?iso-8859-1?Q?nyHan+FcwkmVqLwT3gPSkYIsDFhjRH7MtyGEjGw9OkyCQVcXBoUewx/WMf?=
 =?iso-8859-1?Q?8B33eAZ8JrTQCjdkP5nng9VRs3kUCXOWO2neuEyvnO5J3DCxjsKZAy6ZsJ?=
 =?iso-8859-1?Q?kjQ0Z3Hf0dWTAQIMPQ4CLxCdNbrt+UHeiNPgwr3ZxceFd+flfsLcbd8ofQ?=
 =?iso-8859-1?Q?VhSzyqO4Ldhb7xlNzk0EoM3HA7PnBjJODuWG476kQEZMonjBG06MOe3btS?=
 =?iso-8859-1?Q?ZKovk3ghE78hMOD3M0zBExTQDoPskLUNPdrGip4YNWo7Mg2K8acWScLaBH?=
 =?iso-8859-1?Q?7yA56ycR+S95DCLxAbddSNKkLJrFzgSEVw1Ldtw9RqPEK2v6OO1iBKkKNk?=
 =?iso-8859-1?Q?nYnnfyuDxamJxkqLHqg7dfM64rPkT6uKj/SIfApWn4SB0pZtVz4qKg+But?=
 =?iso-8859-1?Q?qsUkWvO5OofCCHPvni+AtQvqLLqOZky8QX88ErEHRf8Au1Jnb5RmtNvgrs?=
 =?iso-8859-1?Q?FOTFH6AP1+2cu72WuHYEt7QB9UsUHSsaBvpoxEIJ3DBJ9s8i5LFi1C6N78?=
 =?iso-8859-1?Q?vAakXFHY6e/Cw5BH/IqtdcLE2k/GhxWi/lwxF1QXzzDT3BVIc+9hGjpWBQ?=
 =?iso-8859-1?Q?G4W/ZpmpUK7q+axgpUnNqqyQmVEiSc7ZQjzmigLfTs2u1ZyZ+PmTxIyE4v?=
 =?iso-8859-1?Q?0W930ILJ+BI0cKhRG+0jyvfENTQEbzvpTjpu4dYtNdTDBE4XruV+KW1NrJ?=
 =?iso-8859-1?Q?RrJAFJw5fOv3bl5GNy96BgMySqJnZ8LKfsGfGPBMzy9Jbh2Z/tovpg7SBg?=
 =?iso-8859-1?Q?GSLuVX6AOqrlmT27VgpVqHRFQrsWfeymUWJf5aMtG3676JewJUxi5rAcnc?=
 =?iso-8859-1?Q?sETMq/7E92mUDKt38/tnIdt1Bjn0I+sWXSIE2G117R6A7xcZr6BZbxNXXz?=
 =?iso-8859-1?Q?kXhb9icnyGaJ9ix24UE84HomjNHwnbneYyZxYo7H4myFFEZh+cMV115s2Q?=
 =?iso-8859-1?Q?G1QC2wxou33db1rSNVU8fdXCXCLUyWLQ3k1ZnBeTyJCi9ergvvd/fnlqFs?=
 =?iso-8859-1?Q?H4Q/he/TjzEJsCpulsf8HjCvKXTZPk2spWGv3OuzxEpFdmVqpcbSk6PjHT?=
 =?iso-8859-1?Q?QLkL7IZpfHLgnx1HB+csVC26GtRpTgRXvK6LELq4ENWOIzyPUcblbuI0LY?=
 =?iso-8859-1?Q?rJDkcPT6J9U8UYe2HbSTJQxxmUbEJ9H/CBECphuL0n3VHstn4/ebjqJcb9?=
 =?iso-8859-1?Q?tdCAL3idbUrJFvHJo5aHVkhSkZfafsu8wyWVZplWiMCNuySPKShj15ubd+?=
 =?iso-8859-1?Q?BBADdpFErw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MXjzEfF5kXhMumuja1GUFzOBQ3Zf6JlHDwLiQr08cxNrFdxCTcBcZdP8qZdCX9vWv+WpwhMziTFJsqNpN/lDZv9EOgrfePNNdSUWG1jUntTJ6rcGbDtdi50TH2/bEOdv67gjpf27M4Zw/5TKKdXYaiJH7qZKLOokl2wRmOxVB/dT5OE2QMHQgb8/ISa4ko02dZgdoZTNWDFQpxw64BsGKjtSSz++c15VC/MdBf2qM/3wdbT2QHJ46QpOKwNRg+2u5gGyYXTTiK7ICUYa8XFA9C70vVVeBJo0gYYB6d0dOFHtFAUFm4J2aWI58K8deQPcNzsEMo2Tq0vmoMpUhkwxJw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5fa8de-f9eb-4d74-4902-08def9037a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 06:24:06.5666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrfWqRXHI3I/eeYyS/D93K7PyIv/W2DyLB5UWT+VhycXC3vLpBiYAQCV1Nn91sljwUM+Oi2Tg8vkurvYNh4g/vTIsPzZmM3/5GTbm/gRDAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF56FB370CE
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Instantiate the new ACRY model on the AST2600 SoC using its=0A=
real-silicon register address and IRQ:=0A=
=0A=
- ACRY register region 0x1e6fa000-0x1e6fafff=0A=
- IRQ 160=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast2600.c | 19 +++++++++++++++++++=0A=
 1 file changed, 19 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index 3d1cd8e2d7..2c96700a92 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -52,6 +52,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_DP]        =3D 0x1E6EB000,=0A=
     [ASPEED_DEV_PCIE_PHY1] =3D 0x1E6ED200,=0A=
     [ASPEED_DEV_SBC]       =3D 0x1E6F2000,=0A=
+    [ASPEED_DEV_ACRY]      =3D 0x1E6FA000,=0A=
     [ASPEED_DEV_EMMC_BC]   =3D 0x1E6f5000,=0A=
     [ASPEED_DEV_VIDEO]     =3D 0x1E700000,=0A=
     [ASPEED_DEV_SDHCI]     =3D 0x1E740000,=0A=
@@ -144,6 +145,7 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {=0A=
     [ASPEED_DEV_FSI1]      =3D 100,=0A=
     [ASPEED_DEV_FSI2]      =3D 101,=0A=
     [ASPEED_DEV_I3C]       =3D 102,   /* 102 -> 107 */=0A=
+    [ASPEED_DEV_ACRY]      =3D 160,=0A=
 };=0A=
 =0A=
 static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)=0A=
@@ -269,6 +271,8 @@ static void aspeed_soc_ast2600_init(Object *obj)=0A=
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
 =0A=
+    object_initialize_child(obj, "acry", &s->acry, TYPE_ASPEED_ACRY);=0A=
+=0A=
     object_initialize_child(obj, "i3c", &s->i3c, TYPE_ASPEED_I3C);=0A=
 =0A=
     object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST2600_SBC);=
=0A=
@@ -723,6 +727,21 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,=0A=
                        aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_HACE));=0A=
 =0A=
+    /* ACRY */=0A=
+    object_property_set_link(OBJECT(&s->acry), "dram", OBJECT(s->dram_mr),=
=0A=
+                             &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->acry), "sram", OBJECT(&s->sram[1])=
,=0A=
+                             &error_abort);=0A=
+    qdev_prop_set_uint64(DEVICE(&s->acry), "sram-base",=0A=
+                         sc->memmap[ASPEED_DEV_SRAM1]);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->acry), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->acry), 0,=0A=
+                    sc->memmap[ASPEED_DEV_ACRY]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->acry), 0,=0A=
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_ACRY));=0A=
+=0A=
     /* I3C */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {=0A=
         return;=0A=
-- =0A=
2.43.0=0A=


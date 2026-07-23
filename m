Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835BEC531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj69-0005JY-MU; Wed, 22 Jul 2026 22:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5j-000568-AJ; Wed, 22 Jul 2026 22:23:19 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5h-0002ZN-C9; Wed, 22 Jul 2026 22:23:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTOrC0vhutXdKsQCzuiqEeJahtVYnr5mI9REAl8Yppr2Mc+UmcwrpPEKWff63dGBaWVXZVh85aJk4HYKJO21WFDgKYaikXSCOxmOqqAD/HFgGe24eLNmPYHcjkkiQmms3ZaSn2hwFkJ7vvX/30P0Ls8AgZxF201MXezUIUIDhaxWZuwgdPODDEQ/WA6iL8OT9xnkYat1JSfKaZobRoxeDnwNQiLbW7bLDguSzqI4ILFXv+YXYX+yc91P+xAETIKR9SfFBdsGgc2NbBsEnT1cY3FE03NTnTWxzpxeXUee/KWWRNtpR4TS1k48+HYJxJTtcMvrsYmOwoIQAjeETJr1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTb8HN0UqZj6ADiaakV1uTGPl0+gca1DoFmcbg4nM7E=;
 b=WqWafyHznrJlJmxfcScCZS9LVZaEMak4lPKm/7hhkaA+/n5cJBzNcQCuA6hNEgbI6NP9JsKwGXN1IaFT8wzDRno9nCdApQmHOyeMkvY3PV+Su/C8Bmu0Y64Tw9Vv67UM2DY+LlEggnOPogkHsvX2p5WKHFAMQOsgZr6/0Hame+daFQw41DDxnGnIsr5O4e4Vx+3LGE/ltxZSv2VcjQIEMHoIZIW8CaKLQPsX0gDqQZ5C5AsKmyOiT5O+3f7MfL9TXFPhoLXhJ+EWkG2dC/t9TpfBrQkKSUIIj9xn0Pu/3FbOuF+r69KAv1ZoVB5MifXAEAwJ/XmcirDNLs2vvrs0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTb8HN0UqZj6ADiaakV1uTGPl0+gca1DoFmcbg4nM7E=;
 b=fBgEOuImsG4vUo2+3D7z+FWplw6u/Anlxfr/CmcHGHiddq0nKnQUszVBB12NHUbW2OuJ/eVv8oDN7ukYCmlGGD7Hycykm/43pfGiht8hLIsWHOJsCqakgaqACnA7EbVs2L8F+2t6YNO0BUco9eJ/9Lg4gBnJ9JLMrQZVZZA+vtVZsK4NWObQRBpQw3GUxt/rvMIv8A+Fy+biN/Egc1ZpO1JRHwxtv3iZHjd0k9EjbshjX6He/rw+fLZKcA1RlCUJUnzl3alViaNl4Tm1toJDD44zAedXC70U74Q5bb9tLi28gjhqQ/90X/htCiKRBNVyE51sG5tgR6qhBGXHBuNu5Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:06 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
Thread-Topic: [PATCH v6 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Index: AQHdGkoyNVbtC9f3JkWfD1cwcvqKnw==
Date: Thu, 23 Jul 2026 02:23:06 +0000
Message-ID: <20260723022300.4174471-5-jamin_lin@aspeedtech.com>
References: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB7034:EE_
x-ms-office365-filtering-correlation-id: 67f215fa-5335-4f5d-cbe4-08dee86154a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|6133799003|56012099006|5023799004|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: lhR54TXrlW3z3wWez6UxtOp9xDS/sgKntfiGPhuXbm4Q2jKbaiOYT+21wj3RYo9RGF9UKU5qNYO6Jty3Z26E5+XiSi+bg/FE/HRXDTtqO5A076IDxvuQMZzAezv8NPFyIqk7QeKN+4MvKoZnzNBJocU+4VdbaJg+TmRvY0rEuuRCdfN10P18YTMYhnQXiO1HKJOV4mD27C+ou+N/wK4YPtY2iOd8WIS5zeC75LtKNklrmySSOFZZxnodUJe0VeAZn5TTMUFf2rCrZ7HUlvyl/W6PtI9fXuNuABYoWCx0WhMry7mDTRzVEeILQTCxINqhSMjBXkqqNrhJgUDcVzmpCqHp+o85mbCUSkm92NwmslZTwBq12txu/J+hXwjMxetuwqmA/fiyyR8wnPwLuJc7+q/hj3OeJf2h8mz4i1P73eqdf4ZR0xzcyXueATsDr8cIKcRUdgiMC2DwE5LbMC/Sy5p8guVqXu9k4HczOq3Anh7EZnaZ/lMWsnUgGzXuDaO6eDx/5uKEXvKxhJrI221xulJq7lP4iURSFykS2YsOTR3fEVPawO8fQjDibkfJ7AQEneW6erXW0D6SvSU0mTIx7vdE7wOrG7wdi0wlmE9bk0vK51iuTHLp+lzaNCHq3wucDGCz4X3zDkrLcf9wEN4dRBJ58i3S4dMqgQLWZUV9hJqBDtrA6Wkdok08LvcUuu9SReUNkYNogjFtJWkS2nFwJXAOHb0PSkFpX9mw/JGqINnvOGiF3AOZPGi6JuZyV6Y5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(6133799003)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A5o0WMaR2UpfYTO8HC/D86GPvsO1DdPGXTV/JFEKOfI3YHMOWrT42bbDoi?=
 =?iso-8859-1?Q?vA+e79HMvfpTcNYXYfmUpeEZNEsYhSEBU/ruQdDDKGjTkx13ZEE4nWbn+N?=
 =?iso-8859-1?Q?61OO5n5MCe41VzI9TssLWTTE1n1IWXn9cxBQx9cnx0hNoZW4flJ0LOK5Fi?=
 =?iso-8859-1?Q?dLZ9uFtKFcivGcP8wYf3ZDuuUNGVYTfqsP4lrVoTU6nrhmKnLcQSEpWXoA?=
 =?iso-8859-1?Q?BCz9ejNdYZgyMbsqCq2sAIGF33ZwNAs4TWrS0y1l+iXCFrVt0uNGH9/Jce?=
 =?iso-8859-1?Q?UM/96rKQqz0VcBF49/xj6e/mzbGE7iFVmXpmZIB74NGX6FE01xT00kDVYS?=
 =?iso-8859-1?Q?lCsGhQI0XNWN36NWRGPOsFn3tCVyVrND8dTEmh2mKaymznJkjTyivqKcP/?=
 =?iso-8859-1?Q?JyfZMTrcz7pY9U1gWUTKrfeh9yfOGP9gwpKvbU3AlJsQerbNyY1X07d9Nw?=
 =?iso-8859-1?Q?FNEzVBIacixr/k4v96DCT+5d7eT0L0teu8hMfBqR4rzUjSEOjGnLXa6V8K?=
 =?iso-8859-1?Q?mw8/usrf7gyP+x+CIJi3/Rl/Z/AmjRKITLmudIvT/djhbOBZt66+bkaMYE?=
 =?iso-8859-1?Q?jLmAuyAAnW07FaJOi/jzV1KfDObxHF72cJxnCuTGOnBMJQKE+cJ+9TuoJe?=
 =?iso-8859-1?Q?7Ue/yC7qi6O3txObW1/FjGUnXKtwjMANn1DMUoabGIqRrhzr30TaBEOH94?=
 =?iso-8859-1?Q?eoaMnqtNRfg/uaFpSAzlK/NnoQMRYHT9JExA8FMoJ866FFqXVRyJMSBfhB?=
 =?iso-8859-1?Q?pZ8nYaM0XrGsZVLvoL3eg9JiNVnpAkffw5RcCx4TokFVGApHJ9+xRkUg/H?=
 =?iso-8859-1?Q?3MSHoX2GiwkckScQPMvoQDer7qSPExZ8b1vMxGJQQcj8AImzlfoNxgzEut?=
 =?iso-8859-1?Q?5zycyxSErAHOYGi9etZfAhILVuNjrKNaK2OCtZ9GwP0qfSe3yTcknphc+Y?=
 =?iso-8859-1?Q?/28y8oPiea5u2d/0S25YjajY2b/p2CvMVc9dyqPNFWONlpUrWrLm3KeUD+?=
 =?iso-8859-1?Q?YpzVygsUt64dqzyrkD3dIZmoFcbfxmIgNGUmacVvsyJywIPXnxap1Qdvyq?=
 =?iso-8859-1?Q?LMsGls5CzwounXmTA4rEXYl3qndgmPXkUnY3x11EUkfpvxbkGC4CVNnpcY?=
 =?iso-8859-1?Q?YIsigBFz3Vq3RhMVEXNpi7hUijaY/rvDD7dTCzAJsc4ZyYXrTg/nmUemeE?=
 =?iso-8859-1?Q?IgkNt1i9Em0h6mcMc3evhnOLzHNUCi/4Sm6E/uSAgBplhN+wfw1KTcQhoE?=
 =?iso-8859-1?Q?qREy3+WDXGfj5GsGwNNXdJvEhyYF9Q0SEKicgAqkL5LasBNCvN/J7mprvP?=
 =?iso-8859-1?Q?BL46kySMGlBva+ZFpwqKEiEgtJEsvZ2cmPbB/VRYZlevyEoEaN7td/U8l7?=
 =?iso-8859-1?Q?fHNLflP8IisKscaAWjsiMk4qp1vW+Txcfe9NKLlq1nDmC8kfFZ+b0X74hB?=
 =?iso-8859-1?Q?kbW5Tcpfxi3qikKFaI3TYssIW/23EJ7S+Yjwq8Oe58rsLuJKvewt5H9gK0?=
 =?iso-8859-1?Q?wULspXNoDFKsd8d3E3J+en8Hkhe2KnUVReSMh41qsnpiFLOATvKnkvkHax?=
 =?iso-8859-1?Q?Wlqq51RT6Pn2hvp+Llccqi1nWNHsSor77Fb6rEqHyB4WFCG/fELRVcw5z9?=
 =?iso-8859-1?Q?CQBvlFgA4s52fxjsqzujhslYFBFwdQ9u3gTBboG2DbX3Uj67Pq6sKoQiqP?=
 =?iso-8859-1?Q?W42YCovBBXUDyeBzaI9Kk96vBRl/pWTTwg4CczkojEfKdnpLWxNNN9tKw8?=
 =?iso-8859-1?Q?efuSMzF5ttS2/WJj6PDW/jht9hV2upUBBPhEDiJhUrYJbP9mEhpxQkXxtv?=
 =?iso-8859-1?Q?0IIWIbgtmw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QrjGs9shbEtcd6TJhfUhytvN3FdtiPWJPMI0FsLZJMD4yhSyF98svnZs71cJvPyfLvXcxbUKdiSlRXm0crLh+CFYBtMsjEwaNoEvY7b8FDk91KK+Q0iWYW5Et1/5KzHJ+TizItZOqns1W7OeAq2TurckjpmU1MwZCCwLA5HUA4y3iXXMwcDywSbYmnv2Wz2zoBq4zEHtRg1TGoQpSFenfkfaEFMSfPsvSdXY7vleqx6FqxmOWm+4QgO0twkAQCbx/6/dbCVh7qDHtMXOLkfza7YsFGRvVq0i9Hod/uzHlshIS82MmpukZRc6K9MbA4qsLUqqfnu4nmlVvyKXYvUeyQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f215fa-5335-4f5d-cbe4-08dee86154a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:06.2740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhdjHXLWAR1NMLY6mgjkmL5d0T7O2yyTyQ7wY2nxrnZJRuN0hX0biagKHL4cuUa+nXVdSMhCObiSqP1KmQamaTHZSQ5AQVu1p+SZoKEcpNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
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

This commit adds two MemoryRegion aliases to support PSP access to=0A=
SSP SDRAM through shared memory remapping.=0A=
=0A=
The SSP exposes two DRAM aliases:=0A=
  - remap1 maps PSP DRAM at 0x400000000 to SSP SDRAM offset 0x5880000=0A=
  - remap2 maps PSP DRAM at 0x42C000000 to SSP SDRAM offset 0x0=0A=
=0A=
These mappings follow the default SCU register configuration used by=0A=
the ASPEED SDK firmware, which defines the memory window mapping=0A=
between PSP and the SSP.=0A=
=0A=
The alias MemoryRegions belong to the SSP coprocessor state itself=0A=
(Aspeed27x0CoprocessorState), since that is what they represent; the=0A=
SCU only holds pointers to them (ssp_remap[0]/ssp_remap[1]) so its=0A=
control registers can reposition/resize the aliases at runtime. These=0A=
can't be QOM link properties since the SCU is already realized by the=0A=
time the SSP sets them, so the pointers are written in directly.=0A=
=0A=
The SSP cpu_index is only known once the SSP's armv7m core is=0A=
realized, so it is written directly into the shared SCU at that=0A=
point. Its "not wired up" default of -1 is now set explicitly in the=0A=
SCU's own realize(), since nothing else sets it via a QOM property=0A=
anymore.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  2 ++=0A=
 include/hw/misc/aspeed_scu.h        |  3 +++=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  2 ++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 38 +++++++++++++++++++++++++++++=0A=
 hw/misc/aspeed_scu.c                |  3 +++=0A=
 5 files changed, 48 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 23c3b97f06..d9d0ae7b6d 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -52,6 +52,8 @@ struct Aspeed27x0CoprocessorState {=0A=
     MemoryRegion scu_alias;=0A=
     MemoryRegion scuio_alias;=0A=
     MemoryRegion fmc_alias;=0A=
+    MemoryRegion dram_remap[2];=0A=
+    MemoryRegion *dram;=0A=
     Aspeed2700SCUState *scu;=0A=
     AspeedSCUState *scuio;=0A=
     AspeedSMCState *fmc;=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 904549465f..01e8854104 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -44,6 +44,9 @@ struct AspeedSCUState {=0A=
 =0A=
 struct Aspeed2700SCUState {=0A=
     AspeedSCUState parent_obj;=0A=
+=0A=
+    MemoryRegion *ssp_remap[2];=0A=
+    int ssp_cpuid;=0A=
 };=0A=
 =0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 058cea42ed..af700e748f 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -155,6 +155,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                             &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "dram",=0A=
+                             OBJECT(psp->dram_mr), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scuio",=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 9c984d23cd..2b0cf5041f 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -184,6 +184,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->dram) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR=0A=
+                   ": 'dram' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -201,6 +207,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
                              &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
 =0A=
+    /*=0A=
+     * cpu_index is only known once the armv7m core above is realized;=0A=
+     * write it directly into the shared SCU.=0A=
+     */=0A=
+    a->scu->ssp_cpuid =3D CPU(a->armv7m.cpu)->cpu_index;=0A=
+=0A=
     /* SDRAM */=0A=
     sdram_name =3D g_strdup_printf("aspeed.sdram.%d",=0A=
                                  CPU(a->armv7m.cpu)->cpu_index);=0A=
@@ -232,6 +244,30 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
                                 &a->scuio_alias);=0A=
 =0A=
+    /*=0A=
+     * DRAM remap aliases used by PSP to access SSP SDRAM:=0A=
+     * - remap[0] maps PSP DRAM at 0x400000000 (size: 0x1A77E000) to=0A=
+     *   SSP SDRAM offset 0x5880000=0A=
+     * - remap[1] maps PSP DRAM at 0x42C000000 (size: 0x05880000) to=0A=
+     *   SSP SDRAM offset 0x0=0A=
+     */=0A=
+    memory_region_init_alias(&a->dram_remap[0], OBJECT(a), "ssp.dram.remap=
1",=0A=
+                             a->dram, 0, 0x1a77e000);=0A=
+    memory_region_init_alias(&a->dram_remap[1], OBJECT(a), "ssp.dram.remap=
2",=0A=
+                             a->dram, 0x2c000000, 0x05880000);=0A=
+    memory_region_add_subregion(&s->sdram, 0, &a->dram_remap[1]);=0A=
+    memory_region_add_subregion(&s->sdram,=0A=
+                                memory_region_size(&a->dram_remap[1]),=0A=
+                                &a->dram_remap[0]);=0A=
+=0A=
+    /*=0A=
+     * The SCU is already realized at this point (it belongs to the PSP,=
=0A=
+     * which is realized before the SSP), so the remaps are linked in=0A=
+     * directly instead of via QOM properties.=0A=
+     */=0A=
+    a->scu->ssp_remap[0] =3D &a->dram_remap[0];=0A=
+    a->scu->ssp_remap[1] =3D &a->dram_remap[1];=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
@@ -317,6 +353,8 @@ static const Property aspeed_27x0_coprocessor_propertie=
s[] =3D {=0A=
                      TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
     DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
                      AspeedSMCState *),=0A=
+    DEFINE_PROP_LINK("dram", Aspeed27x0CoprocessorState, dram,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index ca93c3699d..4025ea3205 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -932,6 +932,9 @@ static void aspeed_ast2700_scu_reset_hold(Object *obj, =
ResetType type)=0A=
 =0A=
 static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
+    Aspeed2700SCUState *a =3D ASPEED_2700_SCU(dev);=0A=
+=0A=
+    a->ssp_cpuid =3D -1;=0A=
     aspeed_scu_realize(dev, errp);=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=


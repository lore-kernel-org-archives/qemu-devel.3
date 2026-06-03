Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14B7CD6E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcn3-0003Ww-88; Wed, 03 Jun 2026 00:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmh-0003UF-Db; Wed, 03 Jun 2026 00:00:52 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmf-0002QB-Be; Wed, 03 Jun 2026 00:00:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1uK8ufvAdK/B9yKZbG2Kre2eqILel8LNGm5eF3FVxYqgIvq3AAKpzpDNVU16LM+wpR6XGPaCI1FdW4DDMniUKAY1mADNbMslnHJ+mAvTxdQtJCWlUMDB8Tdus4znVpH0xWV+g4BSB4y4UNY+KAsefY12yWOQT3GUu8j9pzkHY7FiixrkoyA+JZBOHKAymVDkc13zkai86fSY9y6xxsi2GKYu3yoIfFjSeQpBBT3oYyoAVkUiJYsfzeRk6EycxUOCgva03d91Uwa6DOYvBsgEMqcQuOfTZOlb1pRTaC9pEADIwVgCbcz73i4Bv74fLpPrJbD6jbPlYnJSRAIbRSKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEVegwRiUCq+PRBAvXjoVyyq1Cndiszr9rLKaQIyY4E=;
 b=jIAKGfxQNAYfy3Gu2JrYovEashLEe1sFAyf4mckYJDmh74JbXmAN0PJVKDHkA8Q9kJmkyYNSRKHB9CPn5e8f7SsKGmMkUbraC5H4tjIkR1Yz3o/N9Dqd/1nQy3TDIYVyHwOyuLxeAqKtJQMR1Tzgz+Kn7BouQpnxPfnx7crH6D9k4a/U4Q+Y6YfmabMcaulzd3McADIT9JzEKcf7J26dtpvaHcfU1wj0GjJfrX+yAfGlBfESsj9FvNWjOFp/KpsiHI8qJ6gTaVwlLIsrYPwpRKYL4tEwlA4VPNtghSk+uBPnq1pNFGbwCJ3JBNd6snnxeXhfKbr8yOCSLGTSaIQ7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEVegwRiUCq+PRBAvXjoVyyq1Cndiszr9rLKaQIyY4E=;
 b=QiwFVIEiwayBBvzdktskYBnUJXsyzrCsMz+OFcGG+HLimhzjCNmBli7X0nW7Gq2Epd+s65gGkVr8t49Qwr0v3ilzD+HZf/wsYfUF6SKn390w6PTJpaPInsizgmbi/QExknhlMFGFUnW5BA7FvgCMk9k1yLbUBk+lHYMTau5WMSCzcNUpIyHqkETbrCpa+m6qeJqeyUdOTK3gwynftZsF7cGwCq6D5lWh+slfjy410xCBH7K335q+wF2Po64pYjE3PVBXWF4GE3He94kawKxPIwmTL63Sw/QFQIFCwkDqV32Ek/bZkaVS6L1s9bY5ENBgv70+R2NPbS0TZHbsQup/5w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:33 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 04/10] hw/arm/aspeed_ast1040: Introduce PECI support
Thread-Topic: [PATCH v3 04/10] hw/arm/aspeed_ast1040: Introduce PECI support
Thread-Index: AQHc8w2GGahSZlCyWUOC8kEFyje33g==
Date: Wed, 3 Jun 2026 04:00:33 +0000
Message-ID: <20260603040027.938816-5-jamin_lin@aspeedtech.com>
References: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYSPR06MB6921:EE_
x-ms-office365-filtering-correlation-id: 87778352-74a8-456f-58eb-08dec124a932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|6133799003|18002099003|56012099006;
x-microsoft-antispam-message-info: vK6dczpijdhbyXGvpK8w4NpTpYZPXwOgj1rCx+fZLCm4+pAI4mbSyx/a2MADkygBNFuzFM39NIx7xb4qe8n/MW7Wv+7CyQwCWb+1SYncD8Ti7zi5dtJ2RHoymGtawozP2FOJtoaxKlrNNe+QvtBFTXmnoVJ7X1nU367wS5vedlTWlitEK/xKIxXzqTxqgUeg/3RJoo7Dl6peW8Gu+biYN2xeTDI75bmj9XMppLALwp9Xm27YmTjsfeHWtsFF5e6q25+DCmxILReYLNXS7jAqytj/J/sWL1g+qaa28BQVzapTJd+nJldP5mYSwoXjlrvEBwdGnTe0jpIlYzoNcyzXdbUtdGb/o0qv8ixXyU3qVaGd8gQ22vsW/aRzfeubXsSlRbAzsKg3BLMn4qeE3qWrXHPjzV/lbsVdR0xsnBbMTI1EtYJnicaO6KeAqoIG/t8ARZTZ9gdvWqrCTizIk3bt4fQ0tN0q1CXqHP4k34g4PivtAaNwSJILOFSowrfaKzEGpxaa4qa70Brg6zpthFTNb1dFyAS9BLkEDJgP6a/aY8cd5WKrf/ChayBDbeJEI3y+j6aLQQnanbtarS4S7P00wAcLbkE62IfNjasz+4SwF5ZBkoefLieVl82GpeSK+eDvm3HKtLP6QL3PW8pPr7LlDzmqX5E19+wuIOd8R03z9SrPniMulNBpL4dWD6onaY5IKXGLefyzGcxjyRpTRrTfSLb4U/RD8B2RUGGAxa3GdJHPPRyAhodfnB5kI2rPEVh/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Uag98qCkts8EuEgz9AXRtfx9323gDQ+EHvLP5qQHCliBkT+CgV1m3buWXd?=
 =?iso-8859-1?Q?5B0DUlEG+31sNKNhr5XBAApWZmpKGzrGpg5WtIfFRmy9rY7MvwVUeA/5iv?=
 =?iso-8859-1?Q?wvlQyATZghSgQMvCHDcYpZpGBv2nW+0xOuhmIGHv2WB7gLjHzg5hilb5mK?=
 =?iso-8859-1?Q?Nz/oDClge/aMpeBdv3Rj3vft1RX+wcmzEAp9J/WZkpeylWYMDJi6D/pHVl?=
 =?iso-8859-1?Q?vK7YCpgW/UVhNktR+zhjqsggFw8gnQPFNtEvvTfoPV+Y1grTfAx+O2uJ1R?=
 =?iso-8859-1?Q?dvVh9NLsquU5ZF85uzTv5vdlRnT9WTXbxSHazMeq7RgE4yXk52JnrSwK7L?=
 =?iso-8859-1?Q?xQRdwkuhhkqvZmSR975gkPSrouXZt8m8oFMzqABh6BoX6Bzh3y4SmbRhEa?=
 =?iso-8859-1?Q?WcVgmM0IQ8Zc0hG/F9vlJtL7A8yvfzXOB9/hnm+oyWzJIvj+OUflP7bvh/?=
 =?iso-8859-1?Q?y4aF5q8GSO+bJ9JjbKCbqjM/cLiztVRVqcydl+bXPcX4wr4XJa4IHFF0LS?=
 =?iso-8859-1?Q?lcxOmuIBITbicIBngi8lACTZw3AYAziwluf3ilP3bUUsh3H4qzc24xTaUZ?=
 =?iso-8859-1?Q?KbGHKYjtxwkCxDFxJgb8vhO3GK0Po/Hmchn2JDwzyhIjkBa9KRP5NKv9x6?=
 =?iso-8859-1?Q?dLYeSKoDucyAR0ZxABbL5+mIRZ4HiV+WCSuQHbz8rQ/ay8JpG071xRsq1L?=
 =?iso-8859-1?Q?mlCyyyNf22MSTSf9h+g09jqp00vx5wvyiSAnRsLLiNwuIwO9TSRa/lA2qr?=
 =?iso-8859-1?Q?7u/CJJUxvI7F/uS2BN8cK1PD9z+FTBzj4LsKx65KAhHF/fAjnBva5SNagy?=
 =?iso-8859-1?Q?p5Ng7wQWXohRpGyOThzOELYGDVN3Z2lFJRq+uw/90Lr6lvGjof1J3dBQVV?=
 =?iso-8859-1?Q?YfKrVfJVvCgJJKeRNtkr+2sFnMtLklumvMnEIZoF6NN1xWma2A6Cr9ebbi?=
 =?iso-8859-1?Q?CMyQFRV8ZWnlHVXawpwhymuSJQM3pk11Suud8BzZF6QG1xGYOicOfby9tD?=
 =?iso-8859-1?Q?sJkII8kzBPgcbr0kBJ5SL1V7h1JjNyND6NTukJFsJlxulmxZMjP0uWGKAv?=
 =?iso-8859-1?Q?HL9wnEr2zSEx/zeMsCxZjz2fyskvHLKN5kAhc3FiG89CFw4lwAZmLCmRIH?=
 =?iso-8859-1?Q?NGIEcDcd53H1I2iNhKwRQnFNvuXVIkcttccb93Md/7iaBT0Yk1cGbMJhP6?=
 =?iso-8859-1?Q?4uFbkCW81K979lHNNilS56rpaeHgH+YZ6xwyJi8TMVd+wdwh4Zv5djqJQP?=
 =?iso-8859-1?Q?eY/dEFJ45gWLL6h3L1gxCUuxkt+IXkPtWObC+JMhKQr5ZouBB2+Mla8Peo?=
 =?iso-8859-1?Q?95WFcbLo+23L9ec0e96NyLU4OR6naSstNtiGBp3Fd80yKdO2ftO+EbaN5w?=
 =?iso-8859-1?Q?yleW1h/QdyZOQZ0XnTfWDlRul7VjwpWe2oFvl1Mv/RDiRD+z7Cj3YMc8wr?=
 =?iso-8859-1?Q?6hjMXFU/1/ZOqi45dDhIw5M4r/ytcsMzGdNYeWQZGUpqD+Yv3tshe2Klw9?=
 =?iso-8859-1?Q?klxQvnxP/TXX6Rwca0DhoSGDMUvRCHyfNHRdkhHy0xWPbq70/GXTbS0vq7?=
 =?iso-8859-1?Q?jpIm5Ot03fdqYaGMP9yi2sTONRTkt+R3sKFyN7spA9rsyITAessfUSvV+K?=
 =?iso-8859-1?Q?obYgt+vCwQiFVJmupwFwAZ9OTAL9AMq0sOQrTVfNN81b6gk+UsoJ3zKilU?=
 =?iso-8859-1?Q?SOnddIuZgedAfeieD3pjuqKzY4srCn5yv2C41G2UWAn9LyO08M2urXDDc4?=
 =?iso-8859-1?Q?/XkJQkYu6o3EEl8VxFzgHGHBBsPite/kNN6g2ScsjySQx8dUeWMYM31xvU?=
 =?iso-8859-1?Q?DSmwH1GXSA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: al8r+pY1qCYJBPhiBOPX45XZ9WKrBzxqvbQDsGNgMh8amRT3OXkagHCk4SadKSUwRBDxJA+ViNO38WerWS4GFnl0QE/HXhZLcH0720FKD++Ifz22bkn+e5EWVjVKWlsWVmN7FhocwVYsQ0Nfl3Ttpl+dYXFJxB2rtKpafOVDGgA7U04a/kx8QmjhOaWydwmP0J9/xX/BbP/np8wCFYux9yl0+ZP5tnegpeyOu70A25Tm5RLYI6PdTfSK8fcv9T+DUEFo6IeGDo6mRSIqHaKZtVFaVOZY7GHC9GQVsN2or/Fx4HEc+/UE1t7dYFmSfjbbWHPTTd2sGktOcNrpxebwqA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87778352-74a8-456f-58eb-08dec124a932
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:33.3383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hms+SYysKiyhNLmwFfrR9+KCUaOJEySzmdAIP3lkNbzxcxdnBU9iy/NPqYKhsC2yhHs32c4+s+Xjc/FjwImfTpicXYOgJ4fQNtGTPp+/DrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6921
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

Introduce PECI support for the AST1040 SoC model.=0A=
=0A=
This change adds the PECI MMIO region and IRQ mapping,=0A=
initializes the PECI device instance, and realizes the=0A=
controller during SoC initialization.=0A=
=0A=
The PECI controller is mapped at 0x74C1F000 and connected=0A=
to IRQ 164.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index b736e690e5..9ae0a0e7a4 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -31,6 +31,7 @@ static const hwaddr aspeed_soc_ast1040_memmap[] =3D {=0A=
     [ASPEED_DEV_SGPIOM0]   =3D 0x74C0C000,=0A=
     [ASPEED_DEV_SGPIOM1]   =3D 0x74C0D000,=0A=
     [ASPEED_DEV_I2C]       =3D 0x74C0F000,=0A=
+    [ASPEED_DEV_PECI]      =3D 0x74C1F000,=0A=
     [ASPEED_DEV_I3C]       =3D 0x74C20000,=0A=
     [ASPEED_DEV_UART0]     =3D 0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D 0x74C33100,=0A=
@@ -76,6 +77,7 @@ static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
     [ASPEED_DEV_UART11]    =3D 146,=0A=
     [ASPEED_DEV_UART12]    =3D 147,=0A=
     [ASPEED_DEV_JTAG0]     =3D 162,=0A=
+    [ASPEED_DEV_PECI]      =3D 164,=0A=
 };=0A=
 =0A=
 static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)=0A=
@@ -108,6 +110,7 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     }=0A=
 =0A=
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
+    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
@@ -199,6 +202,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));=0A=
 =0A=
+    /* PECI */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,=0A=
+                    sc->memmap[ASPEED_DEV_PECI]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F32C4453A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj5z-0005Cj-CF; Wed, 22 Jul 2026 22:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5f-00055R-5p; Wed, 22 Jul 2026 22:23:15 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5d-0002ZT-Hx; Wed, 22 Jul 2026 22:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrP13I0D0UHqxpugl8Kn+nC5Iz7Tkh86LvQ6MNdEK3vmsYWVvcW9UqftcR/zo0gmMnlXhiQHeaqT+u6pUjtHMb36dQuCRzPYQoUEJze0dTkKTzwp/MW0VK63AP9i65Jq9DeGlzyxy9122qCHBG1s2UM8cTIgkOgY28iQafVj9w60x04kvaYJlMzk77fxFszT8cDFV2KRScNORXjRxdlmROFOVlmXFzvg2VrxWpEYgXOd/jyPpkveyR7tR44QZBf1jyNsBf+OeYIdT/MQAu7BdpygD161BGkHjWYtOlIEq4THbv1yb3eGS6eE7EGSxsQcOX26zfXUU73xVJQmh2vqYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6a7jf/6RoL8JvKFkWPGUJHBVfFcLIuF/h2taiuUW0c=;
 b=iKbNDE5SxNeqKLdBcb0iw9Kb5DNUVNOt8QKjS2EackP7WymjAdVLMUrijKZUtxS8GvYN78OpSXkiWzW2CP/Kpo6DvhiB1NCQOy7P8Q5g2MyVdlPGlo7DGcBnrkFZwG8ZJ8hn/7VGNbuqiXTYw/nn4iIYt2yOKFwSsst2hvtv5nQ0vR5x+XNFR9s5VnzIOM3WR3Avy0LI+PpwxG5Ve2ghNsnFS6Vse74UipKUaEGhSoBGCLGTRRcD1V9ZfFkZa6dKfoCtkEJ96w7zDMiEBDi/pR1vh7xEHAZ4S8yUplp7WZFASywLwnRu+LkCqvp/akoLDrE1RA7sDCM9WuxIgXtFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6a7jf/6RoL8JvKFkWPGUJHBVfFcLIuF/h2taiuUW0c=;
 b=JwG+b9EwWMlJ8tOFqD+zvWxAqf9Jdd+ByXNgP+icJoDEU7vQE3E66X5ndc0cgxHJSnfq/J4FYBeRg5ahmPA1R2IRz/Qp3EWnt9FK68fjc6AW0JFg15O8icPZByc4HzE62r8sobLdEarWt3C5RY0TflogrHwuW6CpAb0bn9OBAiHo/ScHf+rTnwr37DC+2NUju3Fi6chTOyuedTxaHpuW/9SlB3Hjb37I2rmopH0XrJFb0uEv7WRqVjPVyWaCz6SzK9Tv4KrCc0B5/WeBcYDvIySxlCiwsQwHtU5rcpbO13pQacO+5IlnZwKbkkCRxqbYRMHDpwmSM+0JlvFoaDfRxg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:02 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 01/11] hw/arm/aspeed_ast1700: Correct AST2700 SCU to SCUIO
Thread-Topic: [PATCH v6 01/11] hw/arm/aspeed_ast1700: Correct AST2700 SCU to
 SCUIO
Thread-Index: AQHdGkovL+s/Q63uAE+I4bXDc6Ih0g==
Date: Thu, 23 Jul 2026 02:23:02 +0000
Message-ID: <20260723022300.4174471-2-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: e1465b8c-e54c-41c0-350b-08dee8615272
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: cR56vmGAfvTn60VukGMRY1BZVXnRQGmC6tN7WB6YGjkwr/pSOF4NOMmvEk1fTAJq1E+CJyTtNUvlTBhqwAOoXQnDG3kfYeJtP7wIObgXsMZImGxh7cWC4mbWwByB0oOcAZQmrKW2maSkXpU1CsBl/ssVwVaikJ5+KArpxZ04G4cMY7/9JatkT4giTkYfgj/OhC+bW4RUN3+GOurRi/vLTjF0qPfl5vGShIrh+AnjdhtwS0RqEqSJTqDQ6+dHSZBXnrD/nmw3gjaZxsN69cNpVmqUjYjvfvkHhRI/fFYbEZqhB8L2XZfzzrHwhwI05jsPZMQaN7vVlru1cQby4NQ3BZdfiZ6qQC5OnVZ5Thy2u5B/hkZlayKsRyi2gRqCH2BFmg2aDCVO/yizvtRrhzvuplOK7CvJmuguo63ychZLq3lWXs0+py+I4F+IyD8vgakK1UKQ6UBrpJKGQtGI5tZJ1ePU9nSO0tMf9QUTPqkfdcfxookTM3sCdy2HAd51hroh+VKNXG46AlzqVY+t+sbVZBtgBgUw7TOc81KslqV/I5FlxMn/I631sllBpozorCFK29+0cvdu3NKZf0ocmJ61ddk3BflH2ltdP0lKzeZGK+mx+DsoPS0Tz3Q/47+8BvKGvLErveMp8Ms/D1FJlqsU6rRioJohcNRcFvCsnECWMsSJaZA+bCILgFf7G8LoycfuhxxLwbsMjmZHYe16sshY40RMHXj7PXmd4sYsvkxpenGWgmjbzRmKtK7al0CjyJPR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GQoRshl1Tk6tn/OPf8RYxSweVPjmXNLMTRJQcRu1AQsg09qfK1c2SziiF0?=
 =?iso-8859-1?Q?RiusHf/pi1IGGKqF2tgLmIwSPIOiuBlhB/zBPQIMYVxlih6flryxpOjUaR?=
 =?iso-8859-1?Q?7rDRYCXcZZ72HFYAE8f8iA7ADuasKKHdRMTS6cxF5cyNmuobIF1mcrl43U?=
 =?iso-8859-1?Q?JCis4QTV89pek+JltFmQtGgvle8y10jOy4TFFWDqbR6YEx6UFs1HcVCLKp?=
 =?iso-8859-1?Q?QS1jNllNTsoccvCUgGHQ27MbucHFUbOIhws2VR1Pk2RynUr1Pj+kEbTanO?=
 =?iso-8859-1?Q?46h5wsljYJ2ozNVB3Jp35cKBAjs2e953BHZRQx5RNIe9qxBaKhwynJKkd/?=
 =?iso-8859-1?Q?3H9+12fh3zd2wA6sHiIQ2LO13P9DRwbN29RielAQ1dT0IW8kzDxROLXUUz?=
 =?iso-8859-1?Q?cQm1Oj7LUXFMqXtzL1//aBY5cxDRSdt4kXcFAITWGr3o/xaz7KJ9nGBQAn?=
 =?iso-8859-1?Q?lL9pM7I77b/OESbFrXoO5Jtes/eiKU0Hbh+RVdKVPqfHBcWPrD3MsTz01X?=
 =?iso-8859-1?Q?a3KUJghygXpzgGtPi/a6xxiC1SrnF7T2sLCbWHgfTflW9667d2nmup+rCj?=
 =?iso-8859-1?Q?HZvshMJR5grUkldHqxVCSTWbUJYDOUhzEtDizvTWIMznQuM+8BuamfRDCT?=
 =?iso-8859-1?Q?5hPNveCWfBeA1itIiJ95BFTiAPJgN26p6f+q1tEDdtS/ifx0zrhNeQFY7o?=
 =?iso-8859-1?Q?CO3wYZXGe50PCBRaeUK9xtFwsn1EpzFhklax3f1srvpfA7wbbbROEXeHuI?=
 =?iso-8859-1?Q?bH88GnvojaffNcqu//fWNtPEbZCDpRN3qQYeS0FeIWVPVU0E48ZJ2+TrP7?=
 =?iso-8859-1?Q?+Qobf2kBXqTZoK7yo8rRzlAXuQcro9hsM9QyWwt9j76MCm/D11Q1H2C4cq?=
 =?iso-8859-1?Q?qNVdZgee7rOkeiKjBF4ZJOoFK51lVLUuuW0sK6pe4H4oOW8yiFFMAeEY2U?=
 =?iso-8859-1?Q?pduWxX5pW96EofDBOPh5UOaWqEeapDk/UGHO/3o8iay0nX/TV5Yp7VOxM+?=
 =?iso-8859-1?Q?US7ExW4sFcKO9X/g4ki37s0+zIIDj/zk84qa0DbCOlOy2/agAw3PrG6YXy?=
 =?iso-8859-1?Q?p9CNgAh9hcMH3tvyLYyVl37DNRlrl0gWnE+7Do2Nb1tlqY7Un39SKwnNVW?=
 =?iso-8859-1?Q?Mb9qTB/8h7qM8UHefGp6XDYczIENXSinojEG7A68w52JAkMAtlTchX+Xpz?=
 =?iso-8859-1?Q?jodb56n38EmH0r6F/GcSuHezve2F4zm0UCXXGONQDrmDKVLoEUnK1BATS7?=
 =?iso-8859-1?Q?e/GMFycDdAqi/B66s5DCFaXTP4JZs6CnsbOlcR12KrJYWmRgHUU2rQB/oM?=
 =?iso-8859-1?Q?lwSu9fSfiIYPR5mFCeSTmP8FKNQLKn2FYkpBXxOCHgIVdlDcgSakooJggj?=
 =?iso-8859-1?Q?MnZMuxA+9p5biqlXxJi9jv/NMwsbTwj3BhtjvrLZ+Hwx8eFaukN/IThjCt?=
 =?iso-8859-1?Q?qtTCexae6USO+U2faHnY5QfOUFyatK1Ts0jH0O6P7z81xIg5as3lZxNf7L?=
 =?iso-8859-1?Q?MyWRAq5w/d167phUaXHxGIqD9cF3M1n2uXllFMvB3PIb88RF/4thhvgIYz?=
 =?iso-8859-1?Q?SuIpwDe8DVd/Pl1IQay26rK7+KU2scgSJ3MvwiX/Rn4SOB7mn27QCcwAP9?=
 =?iso-8859-1?Q?Nh+pyypF+xCLGnWhVHZgU0yx87ZHyZrR9Zbfrsd+062H6yDWhgTVJiDybg?=
 =?iso-8859-1?Q?NN1SJk2YUrSYtaSr8HWVXd+yvnhuigX9AxkO7QYbstrTxGeRrxKBmPCTCX?=
 =?iso-8859-1?Q?En4tw9+Rg13k86dvTgvYl/HgN7wHhwlKS2/GNbDWa9Dtjl2nM1g9xRNARd?=
 =?iso-8859-1?Q?AhoYoacjTA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o+Zi49/YtIh0/3FWQE7e36NMYw9l6aaRadBr3xKyf7fhJ1171TxNDi6SH6gbQd0u6meZmU8WJRNbUpKriZ+psUXaPcSlYqd/AtSEX+wyANzOjDr0rwfNEPG+vbJL6xSoFiVZw4kymgrcj3vKFzrUMUA7KedscLYr+EHwzvzHb9ECXIR3lHOpcJ+R5t36zkFuJ0ZZh1VXcUvBxAl2S9iW3TZHoe3sGZpKdtgYG12Dkb1BU6/Dz7hysIcXwX0hfa9Yv+7mu+CNX+1+9UudYpOnTnsr583Kvf0X+JHoSAeWJJvFcc8Yzd76SHyhii+ss0pfZZG7DYgi48CRzchA4n3jjQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1465b8c-e54c-41c0-350b-08dee8615272
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:02.5776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl96bLqfMUleeh+AxQ4TuyO3o35XG4KP9h9t9urTtuML/YKaBD1YakQcCT1ljPd4G/MYVfeX9apgyhBgHuakJJdb5IfTrLWrIkcW4HVoHh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
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

Per the AST1700 datasheet, its SCU register layout matches the AST2700=0A=
SCUIO (I/O-die SCU), not the AST2700 SCU. Correct the I/O expander to=0A=
instantiate TYPE_ASPEED_2700_SCUIO instead of TYPE_ASPEED_2700_SCU, and=0A=
rename the "scu" field/property to "scuio" throughout=0A=
aspeed_ast1700.c/h so the type change is clear at every call site.=0A=
=0A=
Fixes: b500ab00552da06566a505a397255f4c031670aa ("hw/arm/aspeed: Attach SCU=
 device to AST1700 model")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 +-=0A=
 hw/arm/aspeed_ast1700.c         | 22 +++++++++++-----------=0A=
 2 files changed, 12 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 39c5977cf1..86bdb266b0 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -41,7 +41,7 @@ struct AspeedAST1700SoCState {=0A=
     MemoryRegion sram;=0A=
     AspeedSMCState spi;=0A=
     AspeedADCState adc;=0A=
-    Aspeed2700SCUState scu;=0A=
+    AspeedSCUState scuio;=0A=
     AspeedGPIOState gpio;=0A=
     AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];=0A=
     AspeedI2CState i2c;=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index 5af5da5b8a..418c9fcd45 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -22,7 +22,7 @@ enum {=0A=
     ASPEED_AST1700_DEV_PWM,=0A=
     ASPEED_AST1700_DEV_SRAM,=0A=
     ASPEED_AST1700_DEV_ADC,=0A=
-    ASPEED_AST1700_DEV_SCU,=0A=
+    ASPEED_AST1700_DEV_SCUIO,=0A=
     ASPEED_AST1700_DEV_GPIO,=0A=
     ASPEED_AST1700_DEV_SGPIOM0,=0A=
     ASPEED_AST1700_DEV_SGPIOM1,=0A=
@@ -39,7 +39,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_PWM]       =3D  0x000C0000,=0A=
     [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,=0A=
     [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,=0A=
-    [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,=0A=
+    [ASPEED_AST1700_DEV_SCUIO]     =3D  0x00C02000,=0A=
     [ASPEED_AST1700_DEV_GPIO]      =3D  0x00C0B000,=0A=
     [ASPEED_AST1700_DEV_SGPIOM0]   =3D  0x00C0C000,=0A=
     [ASPEED_AST1700_DEV_SGPIOM1]   =3D  0x00C0D000,=0A=
@@ -108,15 +108,15 @@ static void aspeed_ast1700_realize(DeviceState *dev, =
Error **errp)=0A=
                         aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_ADC],=
=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->adc), 0)=
);=0A=
 =0A=
-    /* SCU */=0A=
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",=0A=
+    /* SCUIO */=0A=
+    qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",=0A=
                          s->silicon_rev);=0A=
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scuio), errp)) {=0A=
         return;=0A=
     }=0A=
     memory_region_add_subregion(&s->iomem,=0A=
-                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SCU],=
=0A=
-                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->scu), 0)=
);=0A=
+                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SCUIO]=
,=0A=
+                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->scuio), =
0));=0A=
 =0A=
     /* GPIO */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {=0A=
@@ -171,7 +171,7 @@ static void aspeed_ast1700_realize(DeviceState *dev, Er=
ror **errp)=0A=
         hwaddr wdt_offset =3D aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_=
WDT] +=0A=
                             i * awc->iosize;=0A=
 =0A=
-        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
io),=0A=
                                  errp);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
             return;=0A=
@@ -207,9 +207,9 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     object_initialize_child(obj, "ioexp-adc", &s->adc,=0A=
                             "aspeed.adc-ast2700");=0A=
 =0A=
-    /* SCU */=0A=
-    object_initialize_child(obj, "ioexp-scu", &s->scu,=0A=
-                            TYPE_ASPEED_2700_SCU);=0A=
+    /* SCUIO */=0A=
+    object_initialize_child(obj, "ioexp-scu", &s->scuio,=0A=
+                            TYPE_ASPEED_2700_SCUIO);=0A=
 =0A=
     /* GPIO */=0A=
     object_initialize_child(obj, "ioexp-gpio", &s->gpio,=0A=
-- =0A=
2.43.0=0A=


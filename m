Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20989C4453A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj68-0005Ie-VB; Wed, 22 Jul 2026 22:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5h-00055e-Km; Wed, 22 Jul 2026 22:23:17 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5g-0002ZT-4v; Wed, 22 Jul 2026 22:23:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhfGx/AK+xzOjPzi5Ye+olcAJ8+HpndiqOLJ6CEffAemFaLH34mw/Yn2ZtM9fK52cW9o5vRuJbXh7+h7ut0mXTXiiGa7B9WTAmYI90hqW5uzjI4fqYV77PaoKMCT3fAVSjllts+Q9VfISxJmA7+A2jMGaKfK3z9uj8x7yfrRFPkVQZqh5i65R+6h2+AYNIq0OF7wuNq6pU0dNpsOrXQAZyDvhbgOmJhGcJh9vT3X9CT8AvOmvAUaA+JOdmkCZ3kBFEIavBbAPIafB2Y3CiJTOuKtFgHeLwud/iE2bWIMZT7h0O0JviKAfPe1NlOHSi0HjKAOWTN6fNQF+oa3j4k6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4MPcCjq6SvMyIo5Mp0A9ylknndNhWShO0vB/ObTp0o=;
 b=HYJ7a+jR6AF1U8laD8vu6fxp2EdXTUXXW/RCVMggqO9HLrt8vKLxvSWMNPx95szZTaAYtYf9iXJBp0xGwmI57SIZVnanUuun85NiTgtqs3JA3Ti+tjWYKtCYZG0CS2CjB5mPag7BEp+GlhQVbVKJG9/AmRcMAHWqq4h6t+8LZTF5elpJExrQ5noeOYaKwL8/+a3tL3N72ZDs3eBwiXL4ntRBwfrmzTHoGmq20dRTmHyYVkB5NSq+L/CgUgVqsiROkbe1vr5XCVoGIijMTa9N6J1/Ucx5BX6kpWWSHZBWYZ3TsI6z4c6bLpq6ZNHhFSIr9CX4GLK2Fp31uPDp7SnEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4MPcCjq6SvMyIo5Mp0A9ylknndNhWShO0vB/ObTp0o=;
 b=Zp+pzQnmwk4YjnvpB45jnz74ZKll66kqcwKGw5MGOSaqHadpJXSlV9draoXfxoBGjZx9JGYoZ3qeiZlc8QDFLZQXG/hlI0dHpSCRj2Je4ZwElsNCgLSq8GRme+f/gq1lb6h4Mj9E8MF8Xerp34RX/LGv/dCJ5uXgIfBdozRha4uYAceDepxULDPNgWTAIQsmFTW5iyLp8rIyah5p+N+Xp4q9RRyJjGp5zSadPIG6g7AdhwB9PX0yoeh/dKpI8doIiChbMenEukrMzi79HBICdFbn12dDBRrNqwvISUxTFf8cpR7hrNIneunHAR6hCsZPgHVGfLfY2wJvtEfaaCDiww==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:05 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 03/11] hw/arm/ast27x0: Start TSP in powered-off state to
 match hardware behavior
Thread-Topic: [PATCH v6 03/11] hw/arm/ast27x0: Start TSP in powered-off state
 to match hardware behavior
Thread-Index: AQHdGkoxfR614cL8YUiOWRPTV+1ftQ==
Date: Thu, 23 Jul 2026 02:23:05 +0000
Message-ID: <20260723022300.4174471-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 95b3f3bd-9397-43c0-0fed-08dee86153ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|921020|38070700021|6133799003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: HQ+AS848RFUYJoX7y9BWgPJENHy7bjk+8YUR//Du2JP9r0RK0SbuJbMSNJgngEQOyfaj4dugS1mkqxPcrICefiYJrTxRrEhaHt/qtNmcJqdkJXQD1cAFR1AOowwBxftNSkGnXmi+8c9qi6xyBm0o+OyOEMtKs4eF0Ygt34BJQv4cXCjobX/trh99y/kiPD8cej+SHKm8x4Hw7MYPR+HftnYACdCDWerrQbDP4qaGhzsm/um4agK6qLLsV+NkX2yE2eGt6doFcfGXoT5LmWY2OAriRWDrMtkzGYOxzauxYQj0ApGCOMZZS9ZgbIs6BIHK6ztkMtprJRDC+szfkKNUXMsNJeaKGoewKJvJ45hC+OSA/NoWQoQNtQGWZaqQLv7l3ejq1YdnBC99PCeikP7sfy3OZt2TlrAilFpiTIm0EDAMMw/LuSCV8JTtpcFaVDP+nWzhpGbyHxDNhruIbE5GGXdagWpAdvtEC0f6ljGLxBROYQKn/zdj+koImU5BMidquzumP1Z82Z4g6h0gjB065XD7uAsoFPLCP0nPfvWOmzmUJ9c2+4a9mSEP4YRqchudVbA4m502mRO9/eXkuHFgb7F4V6L/kWW+i74L1ObU2D7PluL5JtW3OZDAB4Qb1nGtrwSZ2ss1cAa9orazXnoS4UvRZwlP2BcwdnKexXluQR0dMPEwEwMkHyGJqSjaO4aRoqK2S1ZLdARQO+4TdgXBi00Pg/xFB7yHCJB14mlkOnbTyyUY7ZDt/2jjY7e4z0dU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gyr4ldHephU9EWEG1/s/ZOm0cWnofS0/P4WKMb8stx2OD/9JwqyfDcu12F?=
 =?iso-8859-1?Q?kN14YFqCT8Gxo5O/DJj5ZWU5VQCKBdNrRABCx2Lakeg9RVLkJkuasVmUMz?=
 =?iso-8859-1?Q?Hkwvx8z1l3eK4yf0wAceiJtltzIBr1ljSQ6FxFaZzaW0xOu+g7mtdEDsa9?=
 =?iso-8859-1?Q?2+WCeZa8NfyhtoVvH8zWtVfaw27uPfT4aNLtDyo2xREtUITgjARvWIOckl?=
 =?iso-8859-1?Q?iknLIUX1E0G7uNhGJ97qRudCpyNOO/mFytmtvGzV6+TMtPtkfFho4+xbvs?=
 =?iso-8859-1?Q?nuq3qwFXv7uowiKIVFOZcdMX5uXLZWgiwIkyCLa0H1ACbTxgIbzxaSmNA5?=
 =?iso-8859-1?Q?GqWwPFBgRZCGnHciYWs1yA7inDrTroPXK6moRZaBLKxdG1PM/QNRR16AmH?=
 =?iso-8859-1?Q?ib4DjrsPZhdjYlAkSbCouxPJpA5ml1E/NX10BfyAhGsUfd1cvFn1E1swyv?=
 =?iso-8859-1?Q?NgoDGcRPmVtzfVNDbgz77Jp2t4nhfgBy0dKLk4s3LqIYLNYum3ZdfFNjiU?=
 =?iso-8859-1?Q?conLWVaNtom2Kiigu7j1jGV9pG+IJRa13Zob6Mn8jqr0ptCLFug6c0ZO/I?=
 =?iso-8859-1?Q?t11iU64QRlNjI63XQP0eFCt/1Py8RxCEYQERLAeA+6yaqqlwve8ot3lG1g?=
 =?iso-8859-1?Q?7mOMR+dS0xylSA9+CBgwFBffvl8iO/WTT3ne74k7O/pk8nTopp4Bc6f1Q/?=
 =?iso-8859-1?Q?uNlRdter2H7iPT7qllf4vuuT5pIsb1L8jD68a5VIrhP2AOci8bfulnojts?=
 =?iso-8859-1?Q?XqxFKCsakN1LyIz9Ngk1gep9553pGL3NxNX9QIKO42+FtvTbQuRTlbaCxQ?=
 =?iso-8859-1?Q?xSSG8IbJ4npCVn6xY6mT9cD8Eua7E2IuUvYkWVbbmpa3+JFNaEDfUohdaK?=
 =?iso-8859-1?Q?6guULW61GYrGVa+Si4YFkQ1dhRvsaFVxP1giXgYDkPKTeXi6/GvjaNDNLL?=
 =?iso-8859-1?Q?Cc3+Ysvlwy0cD8H4NeKvbotWbInNfQu6qrBc/0vtVG/tV8Mvv3sxs40C3u?=
 =?iso-8859-1?Q?zI6i7z5lMxu9JV441q2jC8kjtqkqV2MEdxuk4tJibEliIaBFrLIgx/kIrK?=
 =?iso-8859-1?Q?e5DXLk3BxO3ADH0++5XFV2R/aEAG5YXuiTQExCy5TuCpHMf3nK7SWnYYU1?=
 =?iso-8859-1?Q?kqx67awYkvkQP0cT8JCcB9q1ItwZ2ka4MAfPs9lK0/tksv41hXi1nSiixI?=
 =?iso-8859-1?Q?mEUArC507eqqpzJV7niD1Glw+to99LaBtzscJHwyFg9+0f4Uis6KjsiXwn?=
 =?iso-8859-1?Q?oWcKxb6bAvZIyYoS8xrbb/dyKW+cRVuTIhJDa7wxbQkznQDbHACJzbwp3B?=
 =?iso-8859-1?Q?UKu54vIKeNc0IFSyH5a3ruFf0DyBALN+nC7fSiUpEWtPYpGnTymfgV1ruj?=
 =?iso-8859-1?Q?fJStu//iqcnj7LRuDzwVz9zmiHa2v5vfqlziNSTT0tmxdtJaTxw54En4hD?=
 =?iso-8859-1?Q?uAhHIHSeEDZmev90yIRNMqUtP7gbv8cf6RcQ6FKW54fuhi1clqbXl3BHys?=
 =?iso-8859-1?Q?8jzmQPORdCJXHfcKuw0mhneRCHn4cWSCIls0aPgQOkVBgm7YXgJys1/Gtp?=
 =?iso-8859-1?Q?tziHL9OKfnKoUyPO5yJbV5Y8Vg3u1hGDoCMuL9/MOs41yR+NCU+32yXSKP?=
 =?iso-8859-1?Q?LJnkI3GvydwowWQTsBsYXoazbfH73xGq7mPDQq5PsuGg9/QE6xcgRx48kF?=
 =?iso-8859-1?Q?XKfsFQPqi/46SjEfFm8A+wesmMJ/rigl4egvQbGmPlxYpx+BSPJ2H1vezu?=
 =?iso-8859-1?Q?7YqDOXDiw6+Cjnbc+ruwacSfM1BBpViTMTeqDKNRLcP+3eLY/IVmFNdqHe?=
 =?iso-8859-1?Q?Y6Q6UKzX0w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QYHTg17EborPG+5OWgkXs1g0JlcmAF+hg5JkUI78EUWSJH7uJd3sJNfsnCwvL0DXmTaZFjR39ibk6NaA2ir2I89tmkMliy3mXwJLuePqL42gW8bVP5cOR9SGe9xAzDC1oLkf3KRj46w2h9YEqusvCvCdotggYEHIxZVpN0HPhMeAUAC2+fT+Opll2377kFKi+bCZaWSkLbaxKsiCpKw4DlgeL8SpQCBJ6RJtk+lENeBRHpXpAevo5afmg2Q1gpBiBeHxJwCLVs0NGwlaRd/1h8SJv21xg4Qy4BQn/X7TvP9Fsyd/CmwBhPQcRZsUu7dMuV070zAnBnWGS/BoJNI8Fw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b3f3bd-9397-43c0-0fed-08dee86153ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:05.0691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+63RrLOzAJvYkz6iDCBApijE3mMoPFyVapjSqIRX5eon6cGL7xOpRm4HGdeEZxMr08cpE/PUyKZk54UxBhAu3FzGnxu+u2d/iAYnQEp484=
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

In the previous design, both the PSP and TSP were started together during=
=0A=
SoC initialization. However, on real hardware, the TSP begins in a powered-=
off=0A=
state. The typical boot sequence involves the PSP powering up first, loadin=
g=0A=
the TSP firmware binary into shared memory via DRAM remap, and then releasi=
ng=0A=
the TSP reset and enabling it through SCU control registers.=0A=
=0A=
To more accurately model this behavior in QEMU, this commit sets the=0A=
"start-powered-off" property for the TSP's ARMv7M core. This change ensures=
=0A=
the TSP remains off until explicitly enabled via the SCU, simulating the=0A=
real-world flow where the PSP controls TSP boot through SCU interaction.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-tsp.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 39ba062a20..4212e7bd4c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -192,6 +192,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);=0A=
     object_property_set_link(OBJECT(&a->armv7m), "memory",=0A=
                              OBJECT(s->memory), &error_abort);=0A=
+    /*=0A=
+     * The TSP starts in a powered-down state and can be powered up=0A=
+     * by setting the TSP Control Register through the SCU=0A=
+     * (System Control Unit)=0A=
+     */=0A=
+    object_property_set_bool(OBJECT(&a->armv7m), "start-powered-off", true=
,=0A=
+                             &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);=0A=
 =0A=
     /* SDRAM */=0A=
-- =0A=
2.43.0=0A=


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B622606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=LMhDVE7v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtU0-0005bt-1z; Tue, 27 Oct 2026 22:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSt-0004TZ-24; Tue, 27 Oct 2026 22:32:36 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSo-00082z-NT; Tue, 27 Oct 2026 22:32:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAETN79tWODXguGU0p1oajpJhX39D1HPDrjCzqaWGtPZU+8pCtWshkq82eMvOAAVe0zlMD0GeKlqi19b5i8e6zSWY9gNWMurlT6svSq/WR5AmS7e+sS7l4i++2OWoynukoldwQaghWAvEVuFw9Hc5rul/o2qqjsFJ54H0Prz6RNEwCnRWEsHUFiJoU02hph6Pu125ACuEZMOgkn/0lXotJre9EJqml0AZpRGP4EIC1lDx6qAD5rqYb9nA0c6CM9tYSrMKvYmr6QrJ8RO7ZS5mlOSDMjRcIHXYbi6PARWx5FWqpbQKZq8LXHLmQrNXAihoNZHlIWROgpCpv3LZAikXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khxCHza3Vqz8GVZhEDXjGhZ4XYIsWCh8/CEYpG0kakg=;
 b=n4kkWnJTcKEw8LZkpb2Ft5b9NtARWLFoZacQ56NtaoNRPnNEUsf79BK+AFAXpmjNS0AKDTqfOx1Jz8hFf0xMqbylLmk3tbAJ6ta401pfj4E2zZU3ZkScZIwa5KA3lv/+lf05elfkP8l+Z6Ep06Gmgc2i1mVOWcADfx7qWpOeLGYg+CVAyVbCwgZKcuMrQ9Tclb4oEMuyIucccL+w2e8Ch2VifxMlH+jqOgLilAPL038OKVVNjc2Y99U3tqYMFM1SRDdEgfb48CoABFuwh8GQalTx3cWMMegiQvZYqdsembEicWEMLWA99J1fFBbLir6AbZgVS/UDcsnQYIvaDsUwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khxCHza3Vqz8GVZhEDXjGhZ4XYIsWCh8/CEYpG0kakg=;
 b=LMhDVE7vkAzWM95NLmRhXZeTwyWMJ9+v2NHvaumBBFy1o/pd3tWpEnbH40+5XqnBfANJt0SxZ2BaUIGQnWnXt+nltBWbmQz1gAFRIDm5Bh/oUdOEGrieykhcic9dWt+UB6+7+2nQTbNXoKGVNcu/y6ZX2nW5tdSV64ulGhbdzSZs0ubDufaJrg9aJh7jHXP8lz0z/lTNf31n0WgwI/4XDbyV11TJNtHcVW86UQxS05Uzw6kvgRNZs+iMu3+oGBmLrTKovnkQkSeVCaBC9kG64W6H88JfxnIDLxi7nCNlM3IvJ13vETFmC6nqAB+wmqiWKyZszoX0u4ruHjeG/0teHg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY8PR06MB9103.apcprd06.prod.outlook.com (2603:1096:405:3ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:32:08 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:32:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 13/13] tests/functional/arm/test_aspeed_ast1040: Update
 AST1040 image to aspeed-mcu-fw-hub v01.00
Thread-Topic: [PATCH v2 13/13] tests/functional/arm/test_aspeed_ast1040:
 Update AST1040 image to aspeed-mcu-fw-hub v01.00
Thread-Index: AQHdZoSH31/LqaEFGkC9397EjEwS9A==
Date: Wed, 28 Oct 2026 02:32:08 +0000
Message-ID: <20261028023154.48395-14-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY8PR06MB9103:EE_
x-ms-office365-filtering-correlation-id: e2e77cd8-1294-4694-c8d8-08df349ba9f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|38070700021|56012099006|261009223027099003|261026121527099003|261022075727099003|261022115727099003|261021123027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 1brLOO4V1/JTVFca9QcQLiOvONK8xdeC83IrZbls89b9HyLazbbpzudTo+ThJ45gzLbCJU79zcpeIKkXCdfuTv/wRun1fvsRZynBVwPsoddlgxhtsNUZ7IdKVMNozIl+4S3zhTGAjZP5cHvhR44GEPg1elCnkh+dl3GcLJgA+hsGdR4t8CinfCzhrfyn7k21friBwDckX7SZH9eU8jK06SparIYOGSH1c0OM+GMZf2TGWidyZj2IT4PqzZN4P1xEdhoT7txCXc24M5B/Q0HFihaqZu4stKyf70UvsbTN5poKXEt2ZQ4LSoIMYRbcLu4vfSpRFESSfQB0cKqeP0A7Bl6rk+cdPSGVkJSP9iD0lYU9hPu1fA+fFdQR1360XPOnHggx20SbtVuMHHHcrypbymv1tTUbZ4T1b4ikZBPG2DS82bU2oMAyK5Y8jsbECIXVEV+JI/4g9vSBhmiDB89KusXZm6836VwNg96opZ1+cpMbdkyyjQKWmvmgf9ULgo4ozFlI1/Rj4o9XkW4lgjjkRbkbFu97QS3N3pYgQmiCy7D9GEO9csmODStEzZ5FTbPdutZopez+LduJoK56yb/Ogc3CVJ0SE1yBrrZy9zRnFU3N0FGAkJcrsdVNH+OistFe1cZEHwcQ0nHnnSJLENb3kioY2oa9OJeSAz9oTYULWBxvzZN1kO+qI1bu+umEQwEhqsw80o8zxQIxxJduUTt19HPs5q7MyvAreY63QdzxYoW/KQLNkSf0IYhI2UVYxrU+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099006)(261009223027099003)(261026121527099003)(261022075727099003)(261022115727099003)(261021123027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eAtFZSwMqQxjl52PVTVP6rNPSBDtJFZK8VEtPrGZgz61/qf07hA9i14YFg?=
 =?iso-8859-1?Q?hGAENOPedfWKLYTibT9Y3/40JLME6xw8vqQQfJzhdY9a5pvkaHfY9s/UON?=
 =?iso-8859-1?Q?0oIGt3aNHP8puED6ujWfud8iVPZaNHLpT9KlC9Z5qTcJ/ewoFJm8vixwA/?=
 =?iso-8859-1?Q?qCNPpvLjve8sc1DHmXVq2Q9MG2d28HEZlt15giBl76NNzj5M12nTEi1U7c?=
 =?iso-8859-1?Q?LW3SX4zcXOn9kh2syHZAZzxjw2ku3H7tdd+ySmuacxl9Cq5IzjPh3JG/EI?=
 =?iso-8859-1?Q?G6VLKD6nmq9l1UsVSLeEWLt2ZvkzcvcdQzQJh4hyzLEzhWV+uM5cLd+8Mm?=
 =?iso-8859-1?Q?cAOt9WvIOjeDgIzxEUoD89EUBmQ8ZI2Nb4bBgDITkWnPctMUzFShC16Y7V?=
 =?iso-8859-1?Q?wcf+/5UyRi4Gf+L6Z8e/fWmxpGYSfM9KM9XKafc6fQ5/ddLyd/+v3wCPRo?=
 =?iso-8859-1?Q?yyeA9Y2FDQZ/1Cjc55fnGtJ41PvZg3Z16Ezv1Nbk8BoFPaYR07L/rmVSeg?=
 =?iso-8859-1?Q?KT9HisNuNRTjqUE7oocCuON0y1fjwszbWvaJGI4M4+F0U9qViw7GMvxGXF?=
 =?iso-8859-1?Q?+uETT1tQC9p732/ZotDbSUQGMfy00+bwIYxu8hOXAfXv/ImxnQjym9JFHP?=
 =?iso-8859-1?Q?bj6OUI/LZuoycPfeZvxHyrEIsiwCkh5obxNwNa6CK8YGKUZ2IBlsxhiS+l?=
 =?iso-8859-1?Q?bhMha0D8sGAXbTW9GSNfbcKFiswq+VXNb6h0UK5mZv0G/v+jkAPlHd2QeB?=
 =?iso-8859-1?Q?kIbtDAwcIFpJe6wCQxXvxKEI15kBHwO0Offa2HXGT9ySa8WbVv64zV+A8I?=
 =?iso-8859-1?Q?L6O2rhp+UcUCRwtftIGHiOrbchtwOr0+bjgl9jjKA6CTLl/a39qCy+8RGE?=
 =?iso-8859-1?Q?THM0uz/ttwvCz87RAe8e6qLKHiNaT8TpBksH2Cc16t3ok+uKzKXM2GAsQf?=
 =?iso-8859-1?Q?obusaD8xi4EyyEv9Kmc661RdnriAPIxBEtReWA5W16BmGPOdcXkPS/Dc/N?=
 =?iso-8859-1?Q?5Ohd4SpHzh9Jhxe/ZlnkzQaLdNBMDJlI/GRWlxAytE/H2R24Z53Go8iWQ8?=
 =?iso-8859-1?Q?g6E7+FmfadZlHTr+jF2FKYnsYtM63yyxGyvq9b7RZi+xGAMILdR81/ABDo?=
 =?iso-8859-1?Q?3HKzb5+Kr7EZ4gevFeIKXncGmOuYzo4D7SgaTxM8pAzNGDjtgmCjPvBUPF?=
 =?iso-8859-1?Q?M6iCjwnyCRxmMA+yGZKV649gdk2FleZuN2Uze/NLifQObMt9iFlX0mCmBL?=
 =?iso-8859-1?Q?jD2/qL2Mje2vd0NaZr2azEpXjbKOV3RiJMiEWgjMrcVPP1PZFluMLvXVMv?=
 =?iso-8859-1?Q?99esPD0vRoznX1hx7jinEbQ0FTMQmUD95795QENKdiECvDmPxQ1PJomveZ?=
 =?iso-8859-1?Q?CwYe0cEFCPuD+m1Vb3CrgSXzLZdBngnBw883PjvnlfkEGbpRL9xCQinWtW?=
 =?iso-8859-1?Q?PwBomgeZaJjZdPBJZZrKAHiw3KtZ8/xL28nfNARNV6uUnwaxxCt5XapI+q?=
 =?iso-8859-1?Q?Jr1Q4PtIACEsagAp4Vb6X1+ohU7/nCCX/27euV7uiKGCq9mrqLebl+loT/?=
 =?iso-8859-1?Q?2ZsqhoxeGhX1BV0CY44ZOsgW9dP7Lk/iiZ7Ugypqt6eHrlJCJrLEwRblA9?=
 =?iso-8859-1?Q?mB4tppThSoUX4PzP0VFu1ibWTPdIZpeReFoZIMWoIa9UgOC+SyJrVN7qmw?=
 =?iso-8859-1?Q?R0mkP+rPhjHZo1tooIgEsbOFobOrpPEaSgJEFGfJ0b558uFkCXzks1oyDZ?=
 =?iso-8859-1?Q?ecpgDatfTUmJCDHEVga/tQGwzmrWZIWlzKWxl8PyDtOwzE2Eioz/hjq1oZ?=
 =?iso-8859-1?Q?DyGu+kNQ/w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e77cd8-1294-4694-c8d8-08df349ba9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:32:08.5652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yvciT+jsfywp6K3v1zh/lte18DWnhtkmr7VfK34MNz4l6EdTgHFGz4t1PeLLgpRFH7npj2cLx7S+d9wpEfaj7S64h7yvoIuKc7nv/+6kog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9103
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Previously, ASPEED hosted the AST1040 pre-built image in the Zephyr GitHub =
repository=0A=
as a temporary solution for QEMU functional tests.=0A=
=0A=
ASPEED now provides official AST1040/AST1080 pre-built images in the aspeed=
-mcu-fw-hub=0A=
repository, starting with release v01.00.=0A=
=0A=
Update the AST1040 functional test to use the official pre-built image from=
=0A=
aspeed-mcu-fw-hub instead of the Zephyr repository.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast1040.py | 12 +++++++-----=0A=
 1 file changed, 7 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1040.py b/tests/functional=
/arm/test_aspeed_ast1040.py=0A=
index e4d8ecb37a..bdfd815673 100644=0A=
--- a/tests/functional/arm/test_aspeed_ast1040.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast1040.py=0A=
@@ -12,17 +12,19 @@=0A=
 =0A=
 class AST1040Machine(AspeedTest):=0A=
 =0A=
-    ASSET_ZEPHYR_3_07 =3D Asset(=0A=
+    ASSET_ASPEED_AST1040_EVB_01_00 =3D Asset(=0A=
         ('https://github.com/AspeedTech-BMC'=0A=
-         '/zephyr/releases/download/v00.03.07/ast1040-evb-demo.zip'),=0A=
-         'b5189797c22c2d732ddc27670c1efdeba821a2747c9c7434f190791125baa121=
')=0A=
+         '/aspeed-mcu-fw-hub/releases/download/v01.00'=0A=
+         '/ast1040a0-evb-v01.00.tar.gz'),=0A=
+         '62dff10cef99a72a9ec679b7ed2c80ba1b76dcdab6bb66251e99a83a31612a02=
')=0A=
 =0A=
     def test_arm_ast1040_zephyros(self):=0A=
         self.set_machine('ast1040-evb')=0A=
 =0A=
-        kernel_name =3D "zephyr.bin"=0A=
+        kernel_name =3D ('ast1040a0-evb-v01.00/ast1040/ast1040a0/evb/'=0A=
+                       'zephyr-shell-module.bin')=0A=
         kernel_file =3D self.archive_extract(=0A=
-            self.ASSET_ZEPHYR_3_07, member=3Dkernel_name)=0A=
+            self.ASSET_ASPEED_AST1040_EVB_01_00, member=3Dkernel_name)=0A=
 =0A=
         self.vm.set_console()=0A=
         self.vm.add_args('-kernel', kernel_file, '-nographic')=0A=
-- =0A=
2.53.0=0A=


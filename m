Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887BDC79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tqq-0005Uy-Lp; Wed, 09 Sep 2026 21:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4Tqg-0005QP-76; Wed, 09 Sep 2026 21:45:10 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4Tqe-0004BU-Gx; Wed, 09 Sep 2026 21:45:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfVdiErfiTKvOPQV4MEiuVhPnnMXKOkkP0fBf9/XLubgCeZzhz6sMAIx9AbYo0UjIuEOAQr2RN22MxT3Xnqcg5PTdiejlZAoRlo2EkdDJ60avmVq1Q6UAQU9GOmDbC3FaPhFYlcNXLEylT5v/2PeGxyuO8sc2IvpEKQBnBQ4ECIeUTUis/6du3Prx/lSbmaEe11kP3P5xeg9Ks0aZVOBTtWH5UpYgAn8vS4i2WTv7dUjWSKYtg1HUCGW/ONOWpq7PyEasbUHJfh4U989EvKW32eszc4gtBJlggj41gDveVw6BzbV6rhvYVUPlZlrzBj20VeY+cu5KBG4APXWEcxFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAsaKbEcunvWuo5wSwV0RR29y2iDU96EA6RdZBfDK4I=;
 b=AgKkq6qUYrmrs30mIvGTr3LX1U7ZoX4EFhh/NqfJiABAJPTjCwrd5Wo8nJHg7xN2/EyN/HvcR6WUTKuRT123efaRlafwVawBVUV5rtSp6jolobUeoz4DOfLjHlsJaxhu8j2LmlETeb7CJiiVZpqjbuJqJesJOB2RV9iyMrbgNRTG4Ptt8fYXoJMt8B1QAAyM8TCoyT/buBuei0onf+JN55Nmx1fK+Ce45viX7jU39xxcT1lsCHlC2qwah8aeUnKk3ODuzgfJJlOm4LSCdXojpYzeM2vtou4B2Icr0uouJIdp8L9SxWZB2rggZ2g30kycYlgAR0RVC1AtLRYHdjhZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAsaKbEcunvWuo5wSwV0RR29y2iDU96EA6RdZBfDK4I=;
 b=qrOJFny7YAr6uQRuju2Jo01kSIoeRLrPVuxaS+s+ax/MQpD8oWOIzmPHG0hi7togHaL58gH3vVsNc7qMPKsy8O0GIKS7nYBQyGrZ7zwdnBKUtPgseR//sRl6RAxwLaNNgIYARF0oD52VLi7gT3Uo9qQeVSo6v5X4FDBuEItgkCL515kuNfsnHHyp6hnDvxXobWjFrDbMA1LvD0mwowPypmKYGErNXlnFEAy0J+tQpvrAyqZGDJ7VH7p/nzf2wM/WD45NcVHvS9gZ3d/6FjwMrc3mUb5TSD5bCHTC2T7RusZNkBrR2TCXE28VKdd5H9tgXaejewOaG38Kpw9+jQInIA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB6829.apcprd06.prod.outlook.com (2603:1096:101:1a7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 01:44:55 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 01:44:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 6/6] docs/system/arm/aspeed: Document the VGA display
 controller
Thread-Topic: [PATCH v2 6/6] docs/system/arm/aspeed: Document the VGA display
 controller
Thread-Index: AQHdQMX64aSGzQwhjkaMwt2EbOAkVw==
Date: Thu, 10 Sep 2026 01:44:54 +0000
Message-ID: <20260910014447.4110781-7-jamin_lin@aspeedtech.com>
References: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB6829:EE_
x-ms-office365-filtering-correlation-id: e9742dcb-cb0e-4168-4172-08df0edd1d51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: B+j5MESJ/6/us8gWampJNYMN9wflBMAE+zS8sewzFdzqSnGej4vRYgdt4aOjtEBmIHMT6473R98froscnZ4L7x4VKevsPrrLYbvnM7mfmRUBGoECSugm1Y+k3juf2m+HzGpaGR3BJhhP+kybNQIhkK+9QqzwRUmfsEbNxdIGf339RibfNk/u2KKfZa4Z0Gy8pqCBmEKlM4S7ipimGEeDuFdg9fh7ben27gJ65RRpvUOIcqY57eDj2IIwArccIlbSlX+cb6OZSL3vICvZLwkuU3dDm8VZ7XJohazPbQp12m6Ab97ZNrwP6koT9ZHyorWN5AfzDNb+M97uEzbWHqD1sBPN64bP/jbYQqQ+druMqBj6NP/tmgoIlz0x7bq6rMVeg3K6OJgEu2wsxA7JykStIsljLKAc7z/DYlnvDnm7k7d9vQ/KOPyTpDLKgOEjnNbBWgSRH0kvZ56Bnf+8Go3DZkh4c1+9LMKMmX5QU2K+On+UMxSBQCemKMXVUj6c+54BT6nECrcVvcWfewozqhP0W9LUcVLfDgqS4wg7Mq15fQefRs+RYEq4GmYjt6/JfWOyoZk0d3f/+Kdw9/hqrL55WZOcJgWgZox21nWGHAGpSBr8eSk+jEuhqZJZvBp79F+1UYRZsVuTAfvuSnc9h7w/uJJZBgYL894pdg0OlxZ8csR3lu4UWO7MzBmkqSgWLTR1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CEahHDEoqooe4RLbCh0cw4wTKDWChb4jZSuk9VatTC2+JbXqMS/BP9opfH?=
 =?iso-8859-1?Q?uFJLgv8FXz9F5TnN0crS0Virn+Gk1yEqvTb2P6nsVIAu4JSCbGim2OPln+?=
 =?iso-8859-1?Q?NbfV6EYqiWctw9J8T8LHINuE3pjmBg+/f7yb4Ge7f7e5IsL4QeC4443fPK?=
 =?iso-8859-1?Q?+hgtg5pAoBaVcLq8HAOwoFOiHo62OJ+nIHknZxHiUYaX7ztD13al6DTj6g?=
 =?iso-8859-1?Q?7aszlt3s9gkPxAyznziz2JdwTmHYBMPtX7oMvxg9H2lKNXoL3N/QkKp6iC?=
 =?iso-8859-1?Q?NKFwuGcZj3JBEylhuOMoWJf1xylo1feGsxuAeOGJxf6Gvdev11vkIeX4VZ?=
 =?iso-8859-1?Q?gJLKDM6+fb0MsNDa3HN6h/e+lhUSIWpMhYpOgI2VQebTUNy6WPB7Pm0PE9?=
 =?iso-8859-1?Q?+lSZTHoAozLO2x04M441RcHEETqLqgSvhZ2e4AQOVX6HSlj/kTZyZPbWtv?=
 =?iso-8859-1?Q?IelUj0RwTztmpw27CmdHrjMFGy8BE8npopxXPdpzOpRgEwn49d6icTXOJt?=
 =?iso-8859-1?Q?dnLZN+RW7argNRTNrwUKrxDoZTIYcx5SRudMWGBU8r1ZNCCsMT0A+RzmHV?=
 =?iso-8859-1?Q?1Pxy6v8ewHL0iDdYp0EEogE+VBYzWNtrpx7n/5F7g/jtdXAyLCjkKSWvYu?=
 =?iso-8859-1?Q?E4RXyaOEVcgpdkyfBsFJD4EQxD+YrvS3+KQ9pUfJH0WdftWmXhBR3h1gj/?=
 =?iso-8859-1?Q?+59UtxI8RmXpx87HCNeUHHRCFeVpB2CyMOyhFnsdZMos49i7S4uvDl6JIg?=
 =?iso-8859-1?Q?3iTzTV9RZ4GMhvVJYQUcHS11tGMleqn55yZCaHqlX2GRJWOx+J79Ylteo2?=
 =?iso-8859-1?Q?MG4pmlDDGmlpmpu/zG17rtMC8Wrc91wD9nVd64Yb856TY/cWvU9X8k/EzZ?=
 =?iso-8859-1?Q?Q7XvDVBtH4Kmg/1PTacTnSjNSZ7Gp/yFtGWuUiCF/NWBtjHYYPqJEuosen?=
 =?iso-8859-1?Q?5dCcstmSW8n9DRhXJxvDXkBBxEgNnQPyDTfeng9aaZekiIMKz12AKHYewX?=
 =?iso-8859-1?Q?uJbz1vn01BR5FyFZFIvq4T7q337/o8p4ijDU+N+qjFuK1Zhi8w6d+CY8z3?=
 =?iso-8859-1?Q?18LorX7+v+zUPC+IlkotvI8fYh+W2tFPiHYr2VQEnpdIJofoEizrxw3Eme?=
 =?iso-8859-1?Q?eTzLsNEzenT8bGyv7PR2lCHLJdPQVP7htfoUvn4hXmw6pVBNQac0NdHwWu?=
 =?iso-8859-1?Q?uxAxvoB5o1Mt5wINXBRMYTR2v3xdf0G0jeQw5arf5JKglaQrExygjrd492?=
 =?iso-8859-1?Q?vvIHWEbB+2HjCLXcw0cTcaE08vh7aQ3oaz1Ve9bVFHEAPAMaRAaNLZwizz?=
 =?iso-8859-1?Q?ckKvKtm7rcBUSfm6TDN4CrmqAAzJ+mHeNZIKhEWKAwLn1tjAk1RNht3fEp?=
 =?iso-8859-1?Q?jwTWaiRSnEE0ZEmfJst2+XjVy65lWs54PeQ05exSAFaqTz+OPnBmZzydfa?=
 =?iso-8859-1?Q?CiKdN+k/lTldXcNJ6Nn50T0rTIAXTtt3Te6YaAF9iEbjymeo79eIlIH2/I?=
 =?iso-8859-1?Q?gSdLI1tPjojacvz7egHdFkqrZikNXndXadCi6cC0kxRrb03mxXobCXOpd2?=
 =?iso-8859-1?Q?4QUBY4eGNVvLOkdMtPqmqo3gkItfs7orwuy680GarLEThvvclGk9KvShc2?=
 =?iso-8859-1?Q?RDWi68knOyPi/nH9xEm8oGc9+fPl9VTf7fev93gU6es+xUQrl9JSUa8/p8?=
 =?iso-8859-1?Q?AaTscoQ8G+vStw41smt4vLKL9G+/vs2fGQtnxfxKiXwBK13PQtDfSJ7cvD?=
 =?iso-8859-1?Q?bH/8MnvT3HTE4V/tSLhTZwsPxx2cEY1ssvdUgnUo1NkpOJLAmNaMZOE561?=
 =?iso-8859-1?Q?L4za5zwHbg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2sTEyUJ0YwFR82pqosjj6lzoQF+pOYPEu0VtqfDhVS9xxpKYroeYfHA39mQCVsgYAl0bWhTbSOatsfidIUync6b7yApd23lHhj+7zA3AhQB3lJzZITlJ/SxaBEKvirYVilciPQsGMnDyxzIPslsv1hY4qZgkOQcGToPE7v0HAWKklPmb0Vbv7wE3KJsFean1wpcted8c7HaiscrBeQ6xS/iX81KiCdLoVDaWbLdeGzwcoRw/rIX2SeH6rYiD5ctKV8FyLZBOWq/zxY052TGd6SnSl4HYysCq4R5mW4mk9xNQFQAsZPQIdT3Cm3oHgq4Ef5qt62pCmZzIiRNIelqcQw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9742dcb-cb0e-4168-4172-08df0edd1d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 01:44:54.8923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ku6rG7Bo0H8ECBDV2PeXiOqda9nzGa6WIzeXYCTTLV1Mvu/f/IkVpzHGQBqyNCq56ah8IoKvMvK9V/vN3uOlM+og9AYunbvdNQgMu/nQvns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6829
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

The display controller was listed as missing, which it no longer is. It=0A=
does not belong with the rest of the machines' devices though: the host=0A=
reaches it as a PCI VGA endpoint, so it is plugged into whichever machine=
=0A=
stands in for the host rather than being part of the BMC machine.=0A=
=0A=
Describe it that way, with the two flavours, the property that sizes the=0A=
framebuffer aperture, the option ROM, and how to reach the screen.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 37 +++++++++++++++++++++++++++++++++++--=0A=
 1 file changed, 35 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index 2d51ceeb84..0900b4202d 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -75,7 +75,6 @@ Missing devices=0A=
  * Slave GPIO Controller=0A=
  * Super I/O Controller=0A=
  * PCI-Express 1 Controller=0A=
- * Graphic Display Controller=0A=
  * MCTP Controller=0A=
  * Mailbox Controller=0A=
  * Virtual UART=0A=
@@ -319,7 +318,6 @@ Missing devices=0A=
  * Slave GPIO Controller=0A=
  * Super I/O Controller=0A=
  * PCI-Express 1 Controller=0A=
- * Graphic Display Controller=0A=
  * MCTP Controller=0A=
  * Mailbox Controller=0A=
  * Virtual UART=0A=
@@ -512,3 +510,38 @@ To boot a kernel directly from a Zephyr build tree:=0A=
 =0A=
   $ qemu-system-arm -M ast1030-evb -nographic \=0A=
         -kernel zephyr.bin=0A=
+=0A=
+VGA display controller=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+=0A=
+The display controller of the Aspeed SoCs is reached by the host as a PCI=
=0A=
+VGA endpoint, so it is modelled as a device to be plugged into whichever=
=0A=
+machine plays that host rather than as part of the BMC machines above:=0A=
+=0A=
+- ``ast2600-vga``          Aspeed AST2600 VGA=0A=
+- ``ast2700-vga``          Aspeed AST2700 VGA=0A=
+=0A=
+The size of the framebuffer aperture is set with ``vgamem_mb``, 32 MiB by=
=0A=
+default. The device comes up with the standard VGA BIOS; pass ``romfile``=
=0A=
+to use Aspeed's own option ROM instead, which can be downloaded from=0A=
+https://www.aspeedtech.com/support_driver/=0A=
+=0A=
+To plug one into an ``aarch64`` guest standing in for the host:=0A=
+=0A=
+.. code-block:: bash=0A=
+=0A=
+  $ qemu-system-aarch64 \=0A=
+        -M virt \=0A=
+        -cpu neoverse-n1 -smp 8 -m 4G \=0A=
+        -bios edk2-aarch64-code.fd \=0A=
+        -device ast2700-vga,vgamem_mb=3D32,romfile=3Duefi_arm_2700_vga.rom=
 \=0A=
+        -drive file=3Dnoble-server-cloudimg-arm64.img,format=3Dqcow2 \=0A=
+        -device qemu-xhci,id=3Dxhci \=0A=
+        -device usb-kbd,bus=3Dxhci.0 \=0A=
+        -device usb-tablet,bus=3Dxhci.0 \=0A=
+        -display vnc=3D0.0.0.0:0=0A=
+=0A=
+The disk image is an Ubuntu cloud image from=0A=
+https://cloud-images.ubuntu.com/. The output goes to the VNC backend on=0A=
+display 0, which listens on TCP port 5900, so point a VNC viewer at that=
=0A=
+port to see the screen.=0A=
-- =0A=
2.53.0=0A=


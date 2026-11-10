Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE760A5BE6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=DmpbyECa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhFj-0000dv-BX; Tue, 10 Nov 2026 03:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEl-000072-Tf; Tue, 10 Nov 2026 03:29:53 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEi-0002zI-Au; Tue, 10 Nov 2026 03:29:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1ikuhwCBsDU2LHhWBT0sKC01niwPgfCxVeNe4tRMb8uFgjk+OaQtQxfUNYhZG8vXpDmKCh+xGb8erDP+/d9XSZL4HIFWA7bxlQYIcYTneih8QPmck+aLRykiwZ2RvLp38LIbt7lGYWGuPyBwW97jVQi7WrQ0EQKKIDcEUL2MEbgI50YhC4in49bKSiOVQC12iWB9wNKKHUjz3yWm+X8IPMHpd0CpUkuMfMJZjm10JaB0UHx8mM3I4R0mDgRK/hrIgLgmlKAtui8PcAeoqu/nKxr+VIjsFCBF9OPb5ish5f06pbbmPBJFP35ZZbwLKotWDkTYebfAsp79an16MB/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E44/7zC+LYXf3BoUpEZqWVC0ICOU04ouJsUzD+5hKsY=;
 b=ohkM2P0y23LDKH0r84BbLKsrAJa/wY+yMomG1SNNJ9HzeiTTdjRsgF9kFYVGl7kem+QEXh/U4xraVTGuhAIPkoAgoTy1T9y0evAxV57qhZOBCbyCOuulTx4UDXdBeSJUv/P3BmFl8IIH/gjY/L7ZgMqmA+j8/gzAleZiZVIJWRmv794eY9jFars26WcajmGhy7sS2kLUuEQO2xdnEYDLObucRpxHX+lz09hEa49glck7+y7F36OyjXONcN0L5Nw9+S/ujnudFicZrsrdHsVNBrM5mM27xaWbWaN2DGptBvLJVZpsVr6Gz2uW/oPtEs+N+So2fskfcAlGghcec6PKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E44/7zC+LYXf3BoUpEZqWVC0ICOU04ouJsUzD+5hKsY=;
 b=DmpbyECaSJy+6i8HUuX2kLEgxrqfWF55gpcrcOZwk41CbzAhpcjwojU1HgvaGLp656bamJej3Z9fhhFJHrBVWEcmb7VDeuxJHDoF6DSA60OWRq2ZFBq4aWTjd49/kJLZSJ7yTcqGttBGWFzP27i/e0MBORqZGnqMacW8Jnv8jzxVGtQFncEU31uP4xIVr6sMxYdoSbeW/eMqPChSnBN6XNrHnEzFsO0WB5H7ASiUzbXVby5K8OBix8hi/yoAW5ShWHR0RtLfNsWpDJHCv3sye6RPY6dNPSU6jcL552hqqN/Zu9kBeCLCZnB8X1O6gRi2dIcXccB95bK2fbfsODZ7HQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6047.apcprd06.prod.outlook.com (2603:1096:400:33e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Tue, 10 Nov
 2026 08:29:31 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 12/12] tests/functional/arm/test_aspeed_ast1030: Test the
 usbredir server transport
Thread-Topic: [PATCH v3 12/12] tests/functional/arm/test_aspeed_ast1030: Test
 the usbredir server transport
Thread-Index: AQHdcO2bJJbA7im0MUyDO8x5hTSvTQ==
Date: Tue, 10 Nov 2026 08:29:31 +0000
Message-ID: <20261110082917.240329-13-jamin_lin@aspeedtech.com>
References: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6047:EE_
x-ms-office365-filtering-correlation-id: fd9da7b4-6fdd-44ec-679f-08df3f04be60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|56012099006|3023799007|261026140227099003|261028144727099003|261009223027099003|261102123227099003|261102130727099003|261021123027099003|261021121427099003|261022075727099003|261022115727099003|261022105027099003|261026121527099003|10067099003;
x-microsoft-antispam-message-info: 7PXG0wQnaUcWt5FTvs5iUUA4JGlCkABvnwiVXrow1ui3940rgPk7vn1mhbxFHzPu1aSAGu4nVCZNxESTQc04q9szQrTmNWtW85CeX0pi4pMU9/CvVXMSp/BDpT5wvtQf5XizDF22FzneO9tOCnMZC99GyURiNY2gMy2fZztQayLS4JbinNG66yRdGwg/WhBZ7irWZrKrVLrHrfvQFu48YmiDjBmcBtgmYHk4CTZVECM30L7BHF+CtgneWI9RvB1NCPYwYzp0K2iSGBekq6wTWPEef3J8UYW91haVX8lwQg9Aa1jPChVV/2RPyHMEquuQXjObh3gIrOQ0dwWxWb69T72osNwx8UlZZsI6rSLKqk6oO/yuyHOiXCV58cf2ZH22UUJG2A2ysBX/AbjpNfmwgfeeV8bI7rxuddqZzE1vP1XxGkdoPSmMwFYqfmS1TlQGpoOJCnXpO5242izy4EiPMjemf+1qViljUlXUBm0kEtL9XTZ2QDXUw5E7FpYOhQw7v/LiBEeR1QYyt+w4Betjwa58gMf8T4J9Jzi2Ek9gzyF1s9Bq96jVvMEuNeeGNAO1BzWcLMu41z2llhvRX4LW72cu0ggsjmyJe+Qa7qZ5/ACEN4MIBvA+XSBygGn2bxuhNEQnRdCelcG9O1YMHtst+L9pHzwSoOdo2O/dPLeMD3s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(3023799007)(261026140227099003)(261028144727099003)(261009223027099003)(261102123227099003)(261102130727099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022115727099003)(261022105027099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CIjCNtNKuPKKWKPc+QXodXiTZa67HaMex4KmziDkcm/hvvsXAtNwTCFAlG?=
 =?iso-8859-1?Q?CZFSNGrX3VWfb9/qJ0Zb9DkxuLmZH470juXCaNxkDQbY2NLFMOyiq6p/ao?=
 =?iso-8859-1?Q?8GwD5S09GAygSJ/R/MkCoyOL3xaVUpoLkJYq9IqolKCnbAqut5KzzAAVLO?=
 =?iso-8859-1?Q?goaPgAvO6ydXOBw1ImBjfV3UoaTCGASKwopYSghI+bb+5aWcIU/8Carcby?=
 =?iso-8859-1?Q?pWKsgZRSrhInvlIDGQdNhHQ7+HksydhVO0atmeL9pkjfikRFCjkvUej7ws?=
 =?iso-8859-1?Q?syHFqd4pmyyAk6UXcl2cd7wrOmBou8upVadibdyy/10EclqaOT2dcNkCZA?=
 =?iso-8859-1?Q?QzsAWofDmhT9uxxJNGO+wNN4v5aCoswXjwCybrzrNJYI0p6diiNDEAIEME?=
 =?iso-8859-1?Q?OTGbp2yt70JDlvW3RQx+uLhTBz95iRTcbynqUQOeaKouILqnKmGjm7Qqil?=
 =?iso-8859-1?Q?/vzQViB7MfqhDmoROmrGCjjWhKdVlYPC6vy1ktpL6OJsGjUdbaV8ebWgQe?=
 =?iso-8859-1?Q?tA66DupqQGzv++IoxQNBPY7vu5AR/ns89VFkTPmY1zn/mVSdQz3cLhXEiF?=
 =?iso-8859-1?Q?RUlZcB9ZmXsxzGNjUocpX+3ekDl2yr2VqjW7TO5vvwvI70KSn+n4ZnyvwD?=
 =?iso-8859-1?Q?bwGewOyZSQ2nTa8Ve8qCSrZv/RGbQwzZyxwCPACudgqyfwaTQ5rWpEC/F8?=
 =?iso-8859-1?Q?vgMZWA7h7EAKHPTzZqXNsR1ZyO/joRI6fvOHU/Elr1u9htwef4Vbi0jMkr?=
 =?iso-8859-1?Q?ulKsoSUPZ+3/OZk1uJqpYNB4LmGjuNGt5RKiA8V22V8WuwgCEHBhU8BQBm?=
 =?iso-8859-1?Q?NxzNNQyQjkIWZpmpCmcRMcTW6/WFWT/4uQlIbFBRJTdNEyOMtdR1cMzTE+?=
 =?iso-8859-1?Q?JW5kr6ZTeI3pbsqr5NzERxJQ/nUkBZjaeggFnBv+ZeiJzh8WCPOmcxzrPK?=
 =?iso-8859-1?Q?rMyhSqu1pghlhKMojB8Nk2mvg3vZ7JPjP4oDMhPLFAwJOAgYPWVtR+rs7H?=
 =?iso-8859-1?Q?YdM8j7z0l73txhAXF3QUZnPhhdgCnGyXsfL7Or1JwkBnIdRcW1bvRECamW?=
 =?iso-8859-1?Q?1lQXmwsj2bulrwkyOmpMd2zfX/V4P8oF0f74fYcEDpic4fHBn/0rySSqWM?=
 =?iso-8859-1?Q?5491MSPGA37dwelaZ5FlJT6XnYR2dOZt1/+LmsDG1k+KwcVDFdk90E5+dy?=
 =?iso-8859-1?Q?raMPxY3Ugn0PcK3LXOfLP220sVXcXH7G9TwwX7/Ymqmf+soB4+GCsD7Mac?=
 =?iso-8859-1?Q?vCtaxQ3jvCR49lanXdCDSjZJVE6RH4RWbaS/3kKHV8Yz4870CxgutgHtob?=
 =?iso-8859-1?Q?llj0PKscSPt2u0FKAJ/kuOOFG+83Wk9boQeaXIJdaAmxnnyny/c3IqBDVN?=
 =?iso-8859-1?Q?2tPzOcc+JaEZUEg5wp1X+fp5fskQu9A9KS0tlWAtl6GNQ71XvDGUHlk5DS?=
 =?iso-8859-1?Q?tFGB39zHlySSIAJdrgyVLF0AaM8L29CTOoZDBK80Mi9jXuRuHP6s9q2LEf?=
 =?iso-8859-1?Q?V5cWnNfuoMj/tywTjW5TP13jaKF6ITLu5fwWJkg/3dIihV/k4efgfX6HCs?=
 =?iso-8859-1?Q?iGGZfW3gmOkZw7RmdeSzU/exemrhP6PQIyv8YS+pv8D4iXWSwQKY2x/Vp/?=
 =?iso-8859-1?Q?SE74ghMeAV0D1BC/iq+uG3QMcJHMMSOOegeklA5wCnn8xKkFWBSV5KTMhI?=
 =?iso-8859-1?Q?rPWTJQdtyVrMGraMK6+M7hy8CFQkJRrwOrkwvBssGp1hNxH6efxFkwOGpo?=
 =?iso-8859-1?Q?aLh/my3i1FEPTOLrxr/zlzMm2F/4ABetR4hxze2lRtWPTc67wL+4bSu9Jq?=
 =?iso-8859-1?Q?eDEkV+FUXA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9da7b4-6fdd-44ec-679f-08df3f04be60
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:31.6022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntJiW7GWX7tolZObXRPJ+z14Zh5tOPQnPTSX7p1n1wGsROMVcWUvxQSieRZmdyAsM2nGcTXFH9avj+JrDOb/OKdHgv11Y0MNjG8BOHqsAeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6047
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Export the AST1030 UDC gadget with x-usb-redir-server and import it on an=
=0A=
AST2600 with usb-redir, then check that the AST2600 enumerates it. That=0A=
covers the announce, control and enumeration paths of the transport, and=0A=
the UDC model behind it.=0A=
=0A=
The two machines have to come from the same QEMU binary, because a=0A=
functional test gets only one. ast1030-evb and ast2600-evb are both in=0A=
qemu-system-arm.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast1030.py | 51 +++++++++++++++++++++=0A=
 1 file changed, 51 insertions(+)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional=
/arm/test_aspeed_ast1030.py=0A=
index 83a96ec322..57d1233b6d 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast1030.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast1030.py=0A=
@@ -6,6 +6,8 @@=0A=
 #=0A=
 # SPDX-License-Identifier: GPL-2.0-or-later=0A=
 =0A=
+import os=0A=
+=0A=
 from aspeed import AspeedTest=0A=
 from qemu_test import Asset, exec_command_and_wait_for_pattern=0A=
 =0A=
@@ -68,6 +70,55 @@ def test_arm_ast1030_zephyros_1_07(self):=0A=
                 'kernel uptime',=0A=
         ]: exec_command_and_wait_for_pattern(self, shell_cmd, "uart:~$")=
=0A=
 =0A=
+    ASSET_SDK_V1103_AST2600 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
3/ast2600-default-image.tar.gz',=0A=
+        '47e3656a14bf7a4de28d3dfbf48bc2325443bc42d270f3bc82646f92f6dea165'=
)=0A=
+=0A=
+    def test_arm_ast1030_usbredir_to_ast2600(self):=0A=
+        self.require_device('x-usb-redir-server')=0A=
+        self.require_device('usb-redir')=0A=
+        self.set_machine('ast2600-evb')=0A=
+        self.set_machine('ast1030-evb')=0A=
+=0A=
+        ast1030_kernel_file =3D self.archive_extract(=0A=
+            self.ASSET_ZEPHYR_3_08, member=3D"ast1030-evb-demo/zephyr.elf"=
)=0A=
+=0A=
+        ast2600_image_file =3D self.archive_extract(=0A=
+            self.ASSET_SDK_V1103_AST2600,=0A=
+            member=3D"ast2600-default-image/image-bmc")=0A=
+        sock =3D os.path.join(self.socket_dir().name, 'usbredir.sock')=0A=
+=0A=
+        udc =3D self.get_vm(name=3D'udc')=0A=
+        udc.set_console()=0A=
+        udc.add_args('-kernel', ast1030_kernel_file, '-nographic',=0A=
+                     '-chardev',=0A=
+                     f'socket,id=3Dusbredir0,path=3D{sock},server=3Don,wai=
t=3Doff',=0A=
+                     '-device',=0A=
+                     'x-usb-redir-server,id=3Dudcredir,chardev=3Dusbredir0=
',=0A=
+                     '-device', 'aspeed.udc-gadget,bus=3Dudcredir.0,'=0A=
+                                'udc=3D/machine/soc/udc')=0A=
+        udc.launch()=0A=
+        self.wait_for_console_pattern('Booting Zephyr OS', vm=3Dudc)=0A=
+        exec_command_and_wait_for_pattern(self, 'usb enable', 'cmd_usb_ena=
ble',=0A=
+                                          vm=3Dudc)=0A=
+        self.wait_for_console_pattern('uart:~$', vm=3Dudc)=0A=
+=0A=
+        host =3D self.get_vm(name=3D'host')=0A=
+        host.set_machine('ast2600-evb')=0A=
+        host.set_console()=0A=
+        host.add_args('-drive',=0A=
+                      f'file=3D{ast2600_image_file},if=3Dmtd,format=3Draw'=
,=0A=
+                      '-snapshot',=0A=
+                      '-chardev', f'socket,id=3Dusbredir0,path=3D{sock}',=
=0A=
+                      '-device', 'usb-redir,chardev=3Dusbredir0,bus=3Dusb-=
bus.1')=0A=
+        host.launch()=0A=
+        self.wait_for_console_pattern('U-Boot 2019.04', vm=3Dhost)=0A=
+        self.wait_for_console_pattern('Hit any key to stop autoboot', vm=
=3Dhost)=0A=
+        exec_command_and_wait_for_pattern(self, '\012', 'ast#', vm=3Dhost)=
=0A=
+        exec_command_and_wait_for_pattern(self, 'usb start', 'ast#', vm=3D=
host)=0A=
+        exec_command_and_wait_for_pattern(self, 'usb tree',=0A=
+                                          'ZEPHYR Zephyr DFU sample', vm=
=3Dhost)=0A=
+=0A=
     def test_arm_ast1030_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast1030-evb")=0A=
 =0A=
-- =0A=
2.43.0=0A=


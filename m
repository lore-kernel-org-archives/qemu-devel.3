Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA8DCA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRQ-0006hj-IH; Mon, 05 Oct 2026 02:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRM-0006ey-4h; Mon, 05 Oct 2026 02:44:48 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRK-00005B-EG; Mon, 05 Oct 2026 02:44:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjfAHViowGUh7fU2gW+tXX9BWp4gP0/tsWZjh3RKYc0tvHxbv2kqd4fweGVGwB9PTaIj2knvZMwTNofBxbOEshof+hHHnheZKzDfeB1GoeyU/GuhwwEIkGrZL/mQAyTfkh3W0+WYzybFYp7PKyIK0eB6n6uiJ2l6Hkvzgmo6ExmYLjsJ09f0hRNp0c43Or6YcJbLJYEuz78g6fPuRkhADHchuHxFE0vZ5xbd5p/hAGeNVXKALlUuwB3poq07WpQqfz3JYoqVsFXhLrVbWrkY4OgREqVrwI/jp0eVC1ChBV/XJSk3JJKYqRS7oBxJvj7dWtW45xp6zLmKWjU7m+L7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6wEuyDkwv34EEohIFKwIEnuGdCxbL2J8HZxN8dloTY=;
 b=v2m0SZYMlkPJusviQwAFRBqlXDIwSBHr7KIq1acwJq6q63Ts/PLpIskNh7zg1AafZFUQqfU1OUwMMxUv2q4TelZBYbevWzrOYv0TyzOjmoWzZj186c8UoHHVNUsb2kRH1XFG8ZTRswVBFbi+OkApR9HwEyRvxEIag9b8x2GlDVZXlv8G07MqTezcOg+RxP9TorMLRzd0xB51vw/Po+yHA+Z5FFBzvWtpMVZznU61XhnTtK5Jbhnt62cWaUAyp6T40431tKZPuZRyTEpYupGNuahwAQzwofX1JgI+RIRuB/L7rdfpr8b/pXgFRP5qDT7DN2fupWVN8Un5urwrWKaGng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6wEuyDkwv34EEohIFKwIEnuGdCxbL2J8HZxN8dloTY=;
 b=gF/mAjBLLqSi4Y72euKYlm9j1sDwIufnfFVUkvsOolixTnYQUgGJ6UU2D8bQsMRMBvFnUfByoUxR/UlhR9O5eYMAlFipCjVE04Wc9u4wW9xuIxMvHgy6bgQcszWz4HxUFB2LLR59fQq217S+gjIfoSoqMkIan+OpDpw8SbOO6nw9hWPXRalheuRKvF/uSAnD0qZMoMHHjHJ45yCepkgVPKYQMtq6ngOZXJ8LdMN5qrvZzdDDQeCzbwlzWjFrW8DdzhnqBBilYyy0vUt4MTpfkVkZXtNy9XzkAI5mchAu/tQtEYttMN7qx6XcXVfpW7lLbxjqC0zlDV+ChXh392BzOA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7166.apcprd06.prod.outlook.com (2603:1096:4:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:44:32 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:44:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 11/11] tests/functional/arm/test_aspeed_ast1030: Test the
 usbredir server transport
Thread-Topic: [PATCH v2 11/11] tests/functional/arm/test_aspeed_ast1030: Test
 the usbredir server transport
Thread-Index: AQHdVJT6QMEH/wGBj06KL0N9PyQZaQ==
Date: Mon, 5 Oct 2026 06:44:32 +0000
Message-ID: <20261005064418.3060881-12-jamin_lin@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7166:EE_
x-ms-office365-filtering-correlation-id: 8492cb1d-0200-4a73-e4b6-08df22ac1cda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|3023799007|38070700021|56012099006;
x-microsoft-antispam-message-info: iyE0XnbIjLF23umLp4/zrxpOiQwUEwkkxPvVKU4wTsmEpqVi30JXk2NHheoRuy8iD2KPviByBU4eH4yj1K8GHU7RQNNDtt5JNWPqltJl5JGDsNbEiDPw9du0y21UX34v8H/ZmwWsq7cD+7KonEnjncTLS+h3yn674VkrmWSEm8NoC9t4YmdfRynn3x7aHq5P/sYM0XLgIX1+POpxSLpQa3BvWz7NxSc9Ql6xdD5cd0jAOCzH9qR+66A8M8Tf+du5fZegRS8x7yL8B+fny6EY+pTkLMJqhkkIsd/NfMwt8c9ThtgnU5yAlvuzTF/aIEP7aTgLzlpxNMHuTanTKMjx+hs9DVHyM8FfGC+wYp9dK9fCkZTWJcmNuGXmDm2JeP0GkRje2cTDyY2F4l3+hEYkEX2vr2y2w4T6vdcfaksfFiRMNQtHI5f5rnfeGfmoCTDZtoEB0W3zX9Qcyz+HNOePTs6EOvZ1DPuymYVCf/Gxb7V8+Xbmd3OZtQ1u3vltqM230oMzlEmoj9cswcgs81Pot5Lb5NUtqrRvP2odKwAQ/42CXoB6E28dV2sBWfya/RRwHXMyjdPvhIZpyKeqneAxuNeV9b0Kcp8b6uTndF4NvfGZgz1v89cHleL4TbidnEdO4HJaCvBYIwpAXCEamXi2f8CKKlHZ0HHDkLJtbg1Pa5c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1Z5fG/dYDw8AfXmMU/eOZgtklM/2unlYu3MbMvO7PJqpHY7NvtL4QcXvs7?=
 =?iso-8859-1?Q?oG5a1P8hcO49TOnhtzoPRZf/WE/AixIBVoQCv0p1dtn8BKprCdO/R2QXYZ?=
 =?iso-8859-1?Q?OJcCHaKiXx1WtvrP/ATPdGoZ3EVMxt4jLIxZRTNjtqrc9oJS5BdsCmttC8?=
 =?iso-8859-1?Q?WtVj9eOlO4Xzze1N3qwZgBd/rADvH3yp09iBSa9AG5FxuXYIvgS3zge5ho?=
 =?iso-8859-1?Q?wdeNC8IWmx9YZ+UKjSgZI21D8B6zGgbK3fbxrPn9Z0w9vGIil5TlEgVlaf?=
 =?iso-8859-1?Q?DoQUz6290zphEVrb9ExuEfPhddKfWOGujFw2YplSEJDbycdtpMOitxDRla?=
 =?iso-8859-1?Q?E2baqjkz/58KTbJHgGMVlzV7RST8+uGeQhMLW8WMJkxWiEfLLmiy+4X3JK?=
 =?iso-8859-1?Q?zs/2DyeFctP0uCU+ihgSxuEr1ahZyFMBBOSKw+3Vaf+pKoNoZr8Y8swENc?=
 =?iso-8859-1?Q?KBfeOY6tRJxl4hhJwA2ovu+Df7b6ACqyesSu1BJ+Xc7gkCSMxfWXLfa3bn?=
 =?iso-8859-1?Q?3DnquCI1HjFWtf9QKL2vErjqVCwucO1485jlB6bO9gInr9GNg0YuTDmmAg?=
 =?iso-8859-1?Q?5kvpjaI1MVaOHj+3zg5ZhvGRF+x6cPBhESHrg2TxsCvAGQ94mWTqlg52qA?=
 =?iso-8859-1?Q?wzg8op4QbASV9w1AlO02F0+p3jVO0MnkGCAPnH4uhSeF+ozu7Rt/xtg1BC?=
 =?iso-8859-1?Q?S79em27BQWN54FYHyqnlyLeiB4hOVpTqWu2j//rk9VgjLVJwS1xZ3QPuqY?=
 =?iso-8859-1?Q?rgWoyCXMivdj6shrjSlVrMOHRASHtZ7TUEKMXKKoCAAFYNDV0KAhaxgWCU?=
 =?iso-8859-1?Q?/zwfC3CE1Ewh7IZaZuRxOsZRO10qp9Rf7QF77FW2kuyvpvSIknEJuXmHfE?=
 =?iso-8859-1?Q?t0nlOv886zKIUxhdSUozN/BfKfT92PpmXa3h6+kuahQIXnyjWLN9zZl/Al?=
 =?iso-8859-1?Q?XcMxN5uXN6Zp+iXG+udoijZRxQOPbpBgaJheXBRO96gkWo5YdTaLRV1f1s?=
 =?iso-8859-1?Q?xNOS7K4AxzB+/wqHG1Zu4p/US1RiWb38qUixj5w4gkQ9GTU2DBMYJqlLUV?=
 =?iso-8859-1?Q?UGk0y91hIxueoX0tTsm5US0SBfTSTCSYoOSORP8F7Kx/svNZgfrZjHmJuw?=
 =?iso-8859-1?Q?3oK3Wg9K47eVQRsUl5fWk7gZLeajiriERs+/IuGQghhrLYkY983B1sPs4h?=
 =?iso-8859-1?Q?5nvuyJf6lAayKRQ3GzuXWDBVcdqnCRh0jy4x1ilPMjvb6apkpVaGsC17R4?=
 =?iso-8859-1?Q?uMzlVlZrQbxT/eTleKG/NSt4sPzZ/uu1JEnCwplcGYePYYkBT/Kyuw2NUj?=
 =?iso-8859-1?Q?6DgQCg90GjCqe0AzzqctdoZ0KJTPxfEuNl1X5xGaNlF2geCLuFFTdvRE5O?=
 =?iso-8859-1?Q?rAXs2Ac2cFS7Wa9VezX4x8KjWEa7LQtnv8s5jGl2pyNiTn6RKgmiLolJKE?=
 =?iso-8859-1?Q?LU1sz6UpqAKGhCX05sAarlYbjdWZU24ugr1FgwXuqGquEELzHEwgf8QWRY?=
 =?iso-8859-1?Q?iEuPoKpbNQZUjAZ5a9Uj0+JbDuA74rZdkjuHQGUXoXLEJ1NKIXcrSayCID?=
 =?iso-8859-1?Q?GZzsPyScRYfs1/k0FRtkm6pEtjd/zjnWYkD007jAZQH628oO34O4U5Z+WF?=
 =?iso-8859-1?Q?HxJMeRX5LCkHVOCpid5DQVLEmsIuHgiBRK0rRLHELAQ1MzxsNQJ8pGSZTR?=
 =?iso-8859-1?Q?Ov0A03PrZkzUpTlLgwLvIJK7BqY7WtrQE4o2JHJh/frYI9mpxwjgMqgaZV?=
 =?iso-8859-1?Q?vMtKKasn0XqQ0b7bZ3v3mO2swt3fq5HCFMVI9J7J3O6u9wHlAqd51upP78?=
 =?iso-8859-1?Q?ZCoVxBZs5w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PJpXrI3+2CP418vwyulAP41u/lI6P3otRsej+qeEqpm4RzNVW1FY8F9yFGxPAfbrfzqtr/hh3sq9lU2WpHWEvCsbS74Wlmbg3WyToDV+j+hoC5QdOk83nX9XhoQuxaCIm4OoD2wc9PVVsX4ArbkWdex6+1N0mTICULc2F3EqYq3nLLtMPw5OE9/dYL/p7LYExHJvE1xCybpuCkvtaKTB5rjmtmMlEWIFu9KSvNXP0ySM4CYz8rA4t25KN5nJadlAsYr31et4CzI0N0gad2YgudEmWcN3Z8A16cuhw7cBS0vBBl7ko+n/KSBAIYLa6o0Wwb33KqfjlWEKY0LCqI3h6A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8492cb1d-0200-4a73-e4b6-08df22ac1cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:32.3436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRmXpXbCYacIWHZWPlgfyiUUPa5vBtnbHrLi0iAaThLAn4ORbfMgNLtkrtHESx4PQGmeeNnYxq1eT3uF0hWdW8AbGUYorehuGYbhbEYYe7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7166
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

Export the AST1030 UDC gadget with usb-redir-server and import it on an=0A=
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
 tests/functional/arm/meson.build            |  1 +=0A=
 tests/functional/arm/test_aspeed_ast1030.py | 52 +++++++++++++++++++++=0A=
 2 files changed, 53 insertions(+)=0A=
=0A=
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.=
build=0A=
index 61b00932db..cfbd376b0d 100644=0A=
--- a/tests/functional/arm/meson.build=0A=
+++ b/tests/functional/arm/meson.build=0A=
@@ -1,6 +1,7 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-or-later=0A=
 =0A=
 test_arm_timeouts =3D {=0A=
+  'aspeed_ast1030' : 720,=0A=
   'aspeed_palmetto' : 120,=0A=
   'aspeed_romulus' : 120,=0A=
   'aspeed_witherspoon' : 120,=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional=
/arm/test_aspeed_ast1030.py=0A=
index 83a96ec322..d1d059c83e 100755=0A=
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
@@ -68,6 +70,56 @@ def test_arm_ast1030_zephyros_1_07(self):=0A=
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
+        self.require_device('usb-redir-server')=0A=
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
+                     'usb-redir-server,id=3Dudcredir,chardev=3Dusbredir0',=
=0A=
+                     '-device', 'aspeed.udc-gadget,bus=3Dudcredir.0,'=0A=
+                                'udc=3D/machine/soc/udc')=0A=
+        udc.launch()=0A=
+        self.wait_for_console_pattern('Booting Zephyr OS', vm=3Dudc)=0A=
+        exec_command_and_wait_for_pattern(self, 'usb enable', 'uart:~$',=
=0A=
+                                          vm=3Dudc)=0A=
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
+        self.wait_for_console_pattern('Starting kernel ...', vm=3Dhost)=0A=
+        self.wait_for_console_pattern('login:', vm=3Dhost)=0A=
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=3D=
host)=0A=
+        exec_command_and_wait_for_pattern(self, '0penBmc',=0A=
+                                          'root@ast2600-default:~#', vm=3D=
host)=0A=
+        exec_command_and_wait_for_pattern(self, 'lsusb',=0A=
+                                          'ZEPHYR Zephyr DFU sample',=0A=
+                                          vm=3Dhost)=0A=
+=0A=
     def test_arm_ast1030_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast1030-evb")=0A=
 =0A=
-- =0A=
2.43.0=0A=


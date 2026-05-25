Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23063CD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNu2-0001ds-NR; Mon, 25 May 2026 01:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNu0-0001Vm-Km; Mon, 25 May 2026 01:31:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRNtw-000382-2l; Mon, 25 May 2026 01:30:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCh3OF2IHMNQ9xHrNXrTXc+xz7AtngETQCt8cUoOogZIzvkB+x8KY4IkPL0O3hQIN3cborTLFeFTlAt2rkYOrjX/kFRpIloBmttcNkNcBtbEAqPRNtSuGSn9a5lqwCUvKoPH3phYSneIByVQeiGe60uvRtl6tBVEc0fzObfL49w0clQZAPrD6sEc6rcFkfJUhLXWbmloE3mG6oYnM+IgEvzyX8CBTOu1ZuoMlucHLgNGeMRCiuzMWhqCuFJ0Z19865r2QvxZG8YVD5ux+5S8DmSLuG+z9NHovRIn94Rk+C75I0d2FgLdVjyX2NJbifxWx2mxyK5FeQC6upekR7VJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9V2WNkEKkxkkEy60r/xxpTVeZRwQpoXGU5BmeHdU70=;
 b=bAgh4/WKVDGN4nEa+Gr8TO+M+akKI8hc23JlO6yF9gDJQMx+o6ODz4MVTlrzyCArXoRMhrUv3zmNAuFWyvLufXjZZqgC4CSUumJ8jsRgqlydB6V9FMr7GDtw3TAOGLAANLG0FSRapyUrHn/+fBKqEsD88rCc8ej+tLD00Stb00Wej7SBXp2RNDdMQ0OCwjiyIMsi4nyVjDWDhQx5O5rfoBubotv1f4HRJD3K7b8PEcHGuqWN8VXaUHnNw4gsLHWfWNGFHw5qI+cjH+1/+XJOy8ihlWSsdPejTX3dScJug65O9nO2b5Z8mdM1sBH9TouPfPMjExY7rwrHL0NcrvtBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9V2WNkEKkxkkEy60r/xxpTVeZRwQpoXGU5BmeHdU70=;
 b=Kiheysg7Pra/4QBB1/TUuGKSOsQbAK9BHA3X90Uc1FC45isizhMZqtsVnTVvT7OYSsRlkY/c6Y+xNC/o24p6T3LLvT9keDl+clpLGKaNWiD0LaMHFEZc/tcvBfEs5GpSV6O+DzcyfBRZwcqt9dZmutrIf0Xskv/tXX1XMRSY4ILeNXWXFHQygWyrwYWczsrm+uq5ajFwDMTFLhjlFT8UdXODDD2OStNU59aDMbIUS9STJizbwN1TCo+xfEfoSehsbkbQUOiJanCHNhjWU7X37oxAJ7r4UbhNmdU4Oe8vwdZzbQo9EbjOi2Z3lVlSUOpF0RHPAoCE7iaZcm8oAmVnSg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5997.apcprd06.prod.outlook.com (2603:1096:400:335::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:30:48 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:30:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 8/9] tests/function/aspeed: Add AST1040 functional test
Thread-Topic: [PATCH v2 8/9] tests/function/aspeed: Add AST1040 functional test
Thread-Index: AQHc7Aek6DN1Ffam3Eu5IPnSbnVpnA==
Date: Mon, 25 May 2026 05:30:48 +0000
Message-ID: <20260525053036.3305181-9-jamin_lin@aspeedtech.com>
References: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5997:EE_
x-ms-office365-filtering-correlation-id: a325601a-a39a-45ec-6db6-08deba1ec6de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021|921020|3023799007;
x-microsoft-antispam-message-info: UORPOqjSIjz9yrKAWhBrMti7auJgkh4buu0fTtnKA1eJljWec/7X+X9QkOkWF62LsOxVwYXyUk8q3ri7jJvl3+zYCBcmo7DR27KVNmWOuvnmAL/doQ0zAuWUiV1O3MfIhDgexLwFTwogStIAL+glFKhGVrnk5qNJAyNyaaFXFR0iyV380cQc5HBwY4VzuygZ6HIbZGxKnTaKniYEviDJ5sWaAZKgDvNd+wuLZ12NMMZlnhcXM8P0lpSBNQuCWl3PQuMPT4LCEXZ+62sb+dktw9DPlW40peNY47Nzy5yxmayTxKrXJ9YobRjaPbP3l8rShJpneuYIoTjD/NCZ8m2TGLw+JjTJ7zQ1IGhQk36M0cZSIlAlz2QjnQhqsy0jG4l+PHAcipDuMQe94r4fkCXgoDIKywooY7gk2uWRSe60e0tq34hhN7zCaYh9Xe7EXzZGtF1eXLl7NYOWOi1N9rDQtH6APGYDi1Uui9fIq3sES8P8jmImWUCOHv+6aJsV+YFCWssbIUEC22BITOaRrCMhwkQI22igLUaBuEvkmQRcIDsPua6BTyg9YBuLQMSpZ62yuwFoqod9jAQP/GcugLuVW9J7Dzrg68JgqDGSNbfL4ENPaoIzdZmvJlTNel6/JC5ZS495P5c7Kml9XIf1LQolWyQckdrcs3n0OFvt+s+XMY39+fwxOFdKh3CWz8tUHkG7NikH1bnU56fE/lxZqR0PAzdPuyvf9UMJa4ynbonQDyp9NolncVySnBdHuQhO9XlvHCb1zg/mMDKPYIgOxBZIWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(921020)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mJN6r2a202OnPhOz2szD+ae1QX2bCKTRd6EC/MUjnkWfJMss7R+KwZmQ7g?=
 =?iso-8859-1?Q?sZkaT1xJVBmZwdsiNdrUElCLISW9267IV8zcVsCo3A6H5dU+34DlSb5CAV?=
 =?iso-8859-1?Q?RVY6ouZK2ebF0goATfwIewXRVUYwJNr7//mDLOIN16DiBjGpljgqzWi31H?=
 =?iso-8859-1?Q?RK3vgcWyHV7lAT0XicakQjved5Ct3zX6bsqgZP0+bzgsYVZBDd0KyBHmEC?=
 =?iso-8859-1?Q?R23TQyE8Ponlk7vazRXOJjbsXXgU5RJML+uls7jN7zWbHXMDWfoC6gZLd9?=
 =?iso-8859-1?Q?gvszuYGNwZV15tr8tDrfy6vFri2nyfzjqSWcRteiQVjtpk5E/+hYbaPJQj?=
 =?iso-8859-1?Q?hrp4Ob/BUuGx15MBgDcJKeOWMRcKwM0gkhXdNZiPgJ+FGtHFhCHbAyqnyq?=
 =?iso-8859-1?Q?LqFAKaoWnbcqEMJpGXsv+a71RJwsMM+XXMDdvs1vFUS8szd9wOfl5efJUY?=
 =?iso-8859-1?Q?pz/Za1OGLtT7EYxBU9B65GIUYWgulzWYZW+hZtS953gI8Wymx/zFfNNqcS?=
 =?iso-8859-1?Q?b8DqHaHokvNqAQSiOS37OCuwIuHP5/9YjE9agiZXSacRtfnFv5n6duvVSi?=
 =?iso-8859-1?Q?i6oHNYBfj6Xjm81SXk0PONU5B7RQNscSeE2euo6OzBk8+fKhA2mYZrRSXo?=
 =?iso-8859-1?Q?uh76dI1nEzO9UAb3nmJTbkje1EqZ1zRGxmn40Mcio+9sy/ksbdG6EIxk0U?=
 =?iso-8859-1?Q?n+QWGhqF/ApRI7IqwbQbm02pcdk4rU1NzpnIAlw+bp5KK3cS8a7Db97LmU?=
 =?iso-8859-1?Q?F3e1PVQtPud2CcpVSyJJmJRh5+OkA6SXNNWpU4EelStnrKDRaTd7v3IdF/?=
 =?iso-8859-1?Q?IaTaJNc0+olKsMoHIPnn1xf7p8KSbqMTXUafB2XehFyEnWAiT0q/wy+B8R?=
 =?iso-8859-1?Q?S1FS4yqbILBlbF2kWtu4D7p5g+5FqdmB0gosCWmGuSUnA1vxQpe3bnBzkU?=
 =?iso-8859-1?Q?4OoEKM//ziiISOJRTP0yF8N6Mdil7PrN51DWiY3a2A2forahqKkhmTirRm?=
 =?iso-8859-1?Q?fNX2UCGg6fKTK106HPs2N4V4eQFFO42NaS7miCHcr2UKIw9NTNAX5Dyzrz?=
 =?iso-8859-1?Q?K9c2aDGmTOa3E0UKJRB/5YD65/qPhVhrmAzo5g2sctT1ZjVjp9Axte3uPc?=
 =?iso-8859-1?Q?hgf8JeiRyYhHWDuVPeFcIG5R+tiWyGkMFg9khZovYNGrIQ3Di4frZwypcA?=
 =?iso-8859-1?Q?t/X292GM/af3ubDBxEwwzEZfKN3Atb1fjnm8bl4OPr0CqB4t4FeFdnhLpG?=
 =?iso-8859-1?Q?zcujyyWbecSxXy/C7fSTe6rMehlvEsJCVBDvOXLaDysOlniXRHAGio/aJc?=
 =?iso-8859-1?Q?EUD0uBauhr4y3SiNVnMQUOeR14x7n4BL1zwxOU1VsD+9HuP6ydSLRIMIKn?=
 =?iso-8859-1?Q?6s1x5eQOHXmOOJeFchpq3Hn8gjoeMSSNZypipmh7i+6M9+anCd4Vu2GoSP?=
 =?iso-8859-1?Q?NEU/IucnwXY3u3B6jsatl4uIbdDSfX3V1R8I5ep2p4nXPpi2E62irR8l3R?=
 =?iso-8859-1?Q?fzhSQXvNht3WFh0bl1MyUxcH8IwTy9bXWuMmDKPaF3l1JlbPSCWb5Ms4d0?=
 =?iso-8859-1?Q?w+DogdloFQ/6UdTjffeZIobWO8ubRMlqv9QCeZs1zu4vAM8wvlS7ZPkYFO?=
 =?iso-8859-1?Q?fkx1EKMbDUeQPsdBzIr+0wigTIiqOMMJtyNugPQx1PqkGfh76gB1rVFU+c?=
 =?iso-8859-1?Q?4ookRIpFQpQHlLd1gc2UaXHIjCkhsVy2YHM6O//7jgIazpILceD2UHxJfe?=
 =?iso-8859-1?Q?kBd2tTh9fjVyhpFyCDHab1f6vP45JJK0fnhAVigTVIWTOg+aCSOk7tfel/?=
 =?iso-8859-1?Q?lzsKrMV3fQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nRs2Pl0ZtNjLnnzNhax6whw8He+GgyxWD27BVs+5H7r8z0W9l6zCWu1Pj0gcl0JDnT6YPjn9FVV71Y+jdYZSWXzn8MSRvp2HJ8SUro76OR2afi4Fj0tAccBfFCBBjAiq1Hr1ON4WtDxl0XDaQCoBrN44pezIG0lqE9K87PxCCyI02pcvaWJUjUnexjY6AZ4KPjFcY/GJcUt3XkfS2f4m7LiLo79Ww2tDlCEmiJHmF96/z7vOPRiHbul8Trsyt99/1n2BEp6kUWBhPaG1AWHEBZOsf5Gr+sZk0FtkLJnF+olJiy+yNlMMtKs/Y7CcAvxGKvQVv0ADuvUc8LrT/l4h7g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a325601a-a39a-45ec-6db6-08deba1ec6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 05:30:48.0830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnciQE8RjvM0/EgpX0cHCrkUu6DWBMATR8NQo0OdYZ8p2ZZcGWfw53k12Yw8tAQg9G5ACbs1KM63dKpGkWDHdQTjSpp6yxBDKhT0f2Vt6mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5997
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

Add a new functional test for the ast1040-evb machine to=0A=
validate Zephyr firmware boot flow in QEMU.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/meson.build            |  1 +=0A=
 tests/functional/arm/test_aspeed_ast1040.py | 35 +++++++++++++++++++++=0A=
 2 files changed, 36 insertions(+)=0A=
 create mode 100644 tests/functional/arm/test_aspeed_ast1040.py=0A=
=0A=
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.=
build=0A=
index 2f538f29a2..786b4b2985 100644=0A=
--- a/tests/functional/arm/meson.build=0A=
+++ b/tests/functional/arm/meson.build=0A=
@@ -33,6 +33,7 @@ tests_arm_system_quick =3D [=0A=
 =0A=
 tests_arm_system_thorough =3D [=0A=
   'aspeed_ast1030',=0A=
+  'aspeed_ast1040',=0A=
   'aspeed_ast1060',=0A=
   'aspeed_palmetto',=0A=
   'aspeed_romulus',=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1040.py b/tests/functional=
/arm/test_aspeed_ast1040.py=0A=
new file mode 100644=0A=
index 0000000000..e4d8ecb37a=0A=
--- /dev/null=0A=
+++ b/tests/functional/arm/test_aspeed_ast1040.py=0A=
@@ -0,0 +1,35 @@=0A=
+#!/usr/bin/env python3=0A=
+#=0A=
+# Functional test that boots the ASPEED SoCs with firmware=0A=
+#=0A=
+# Copyright (C) 2026 ASPEED Technology Inc=0A=
+#=0A=
+# SPDX-License-Identifier: GPL-2.0-or-later=0A=
+=0A=
+from aspeed import AspeedTest=0A=
+from qemu_test import Asset, exec_command_and_wait_for_pattern=0A=
+=0A=
+=0A=
+class AST1040Machine(AspeedTest):=0A=
+=0A=
+    ASSET_ZEPHYR_3_07 =3D Asset(=0A=
+        ('https://github.com/AspeedTech-BMC'=0A=
+         '/zephyr/releases/download/v00.03.07/ast1040-evb-demo.zip'),=0A=
+         'b5189797c22c2d732ddc27670c1efdeba821a2747c9c7434f190791125baa121=
')=0A=
+=0A=
+    def test_arm_ast1040_zephyros(self):=0A=
+        self.set_machine('ast1040-evb')=0A=
+=0A=
+        kernel_name =3D "zephyr.bin"=0A=
+        kernel_file =3D self.archive_extract(=0A=
+            self.ASSET_ZEPHYR_3_07, member=3Dkernel_name)=0A=
+=0A=
+        self.vm.set_console()=0A=
+        self.vm.add_args('-kernel', kernel_file, '-nographic')=0A=
+        self.vm.launch()=0A=
+        self.wait_for_console_pattern("uart:~$")=0A=
+        exec_command_and_wait_for_pattern(self, "help",=0A=
+                                          "Available commands")=0A=
+=0A=
+if __name__ =3D=3D '__main__':=0A=
+    AspeedTest.main()=0A=
-- =0A=
2.43.0=0A=


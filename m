Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617EAF54AD9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54o8-0003pb-33; Tue, 24 Mar 2026 12:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54nx-0003kc-Bd; Tue, 24 Mar 2026 12:40:34 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54nu-0005Lv-OL; Tue, 24 Mar 2026 12:40:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYD2HyKDyitzXmTXI3bNfmPYU7LifsMZ35nfN3PkMkMggynkCxZ6hIBx/8uZvabPg1uBgfU/PW3faxzB6GEVPNlMcC3/FxWHhlCfyR2M3EhoPRUZoMCpYuriC0N5BSbQe280+Qj7UKsg9DSOEBcGqqCKg4Ul0iJhH0BOfLH6PTkLatV9U2HoJX4vSWujFsTBRswh5SaqQh435Emyijb7363ez3N70e2WUZ1SQqMBd6QFEbmDVeuctiZex6N+zPYbG1N72gRZHCUZYbXP+Fg5np24YcprZDqR0gF1XtCr/5YRsYIZqdChtS9L6SzmertFWh5nhqfmbupvo86pq6HRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ+8VnVISIaiAx3b/US0algMNION4gZYqhTqPzHdZEc=;
 b=Q+fUsgYrkYz3YeJ048XMoJdWWj9NwPXnGmMfCXxC/vEmclulbA8H7X0QnPURBSOZToQvhIyRJGIghWiI5mCIbp7EaQKT3Le5mlWcseYRpzG6Je8LZqoM+hwCzCqaein3l9mRi82LFS5setZkSk+1YgEv4Zz4sOoU1QHlIbAck/7AIlHIX0ZP5S5p4rNUKswFXrVCJjm4wEvmDFg9JRJN7AdUTkYLgN8XO9fPj1NG/lQOCXVI2FZ6YC790nUWTcQ7gW1H0bsrJe2J9KMEbyf4sVYGtHjSjLJo+BMw8t8gTB6FfFvxue/zKbcpdhEPq1DOnXRB532MpMR38nC3sKDXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ+8VnVISIaiAx3b/US0algMNION4gZYqhTqPzHdZEc=;
 b=edDky1n++1ygJxJXfpbhy9/e7AWxjC+Qg3n1HhtYORyOMjTAdsnd5AqFNHRlaxzsv4IcTHlijeCn94ZPh0i4rqNEer5NepM23IfiprBrIDJXpvl5nCrtDBSv8LRkG7kZZbzo/KlzySiXFC5kb0AdL5z/1Q/mt4b1AHS5rwq7+cDXgPqHXCPgzWNhtzoeT2A1l/v19viarsAWGx3VdEkmATnoIXA4lpbRCpN5ouH8EJbouIuVxaeCcEwK/yiA1AABJDSB+p0WgfUE65LAdBnaiYKUwyKdRznO0o/fgFP270pCa049/CUWvUJWYntuhSkIRSBCqAqZQvT7IobjoobOOQ==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by VI0PR09MB7005.eurprd09.prod.outlook.com (2603:10a6:800:243::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 16:40:18 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 16:40:18 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 7/7] target/riscv: Add test for RISC-V BE
Thread-Topic: [PATCH v5 7/7] target/riscv: Add test for RISC-V BE
Thread-Index: AQHcu6zlqiKktxJWSECRq3yCOJ8gIg==
Date: Tue, 24 Mar 2026 16:40:17 +0000
Message-ID: <20260324164007.549397-8-djordje.todorovic@htecgroup.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|VI0PR09MB7005:EE_
x-ms-office365-filtering-correlation-id: 553f3425-cb13-4e13-c21f-08de89c40885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: t71dhW8iOQ4AuWS8iDLM5ijHpTLnFzPpqovQrlzlrMIjJOB+9y5Ay5zvxNIUX8Yy2nNadquznDtupmCL245r+fbxHo8KYtms4XrmM227eUxFJ05hfzaYnKxKZ5fkI1uY8Ypibzq+VciS9EClVFE1EeF3Dk9uZCnndqhONG9MNccYDMo8RZ0KZ4xTNz/+Ouda/aI1J8fN2EIpGY50fKdIrD5BvlZRiAjK9WHHOcycdWHyyHY2CRQqRyWP97NuvszoVSnKyKxeBsWRwS0jL8ME8/6ElR2hmYo5N/alqCZNWYh87e/DFe8o5Dr9e2CRtXwxse1qcHs1tA2Oo3sS2UUg/uIN1lEBFNiWO7CPQpflsxwnl3E7wkZ6ywfn+566cXIGATL5hf1bBW0BJAXOIbG5PxDmDzFBYIOFYQhX9U5Xs41+oN8x1WZgAF4B80zATAffoXn8ulXGCZNYkJRdObxtRwF9CjpmQwmLj6/ZE33z5SAC13kGndxmERBUwAqBmxcpwQ94XZ072xWy4LfXScQObpVxXPVHSuZXeieLQjDj7OwolCosgTO2V35EtYXg7ERJj4edFpYK5HVelJCIjDV0I6qaQ0zZneAgaiNZ2/+TPd8iD2/3FpZ5azlLwG/ezNRMrkeAtXtYrjfS0e1bG6WhK+RKY/dVUMfevop1smxHh3WLa+uFG6/xGBlTyBCxrDg6l/B7IFdtXKKBXDzXTqmA2VehHpfh2CaUVZdG58eYoePZjch42rAJEGVCSDl9MW44wvGMqyWfU9DtAXOp3Sdg1HB08+XGYybmBbZ3x88uPPc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0b5vp51aVCMYoL93Qmnbs++yE6aoUugZQhHieyM64v2a1xLqDsAOxx8lea?=
 =?iso-8859-1?Q?iEoWK/N3jN3mCUb12u0f2XljudM5RZY1rHoK+UmLf/zJ3wDniOaOeOyIvU?=
 =?iso-8859-1?Q?JBZQ7dq6mApx9knZnyP4xrVkKPnMHrOJ6BFVCjJeVV4QWw+QKupgg43hUt?=
 =?iso-8859-1?Q?h/MbcL0XEEXyM7zJe0PMybmvqcapWXHz6SMz+aackQtTyLB6asqxrvZVmW?=
 =?iso-8859-1?Q?oGq0BJ6wFFtAEvH9S0v0zJchgmGwOdU6mcPfUZA37PsWBzUDv/RK6BwT/E?=
 =?iso-8859-1?Q?Vet0+Wetafld3fK8sxBWsoFP/pnk4fuU+sWalCG9MVcghUpgQ8pjtqtcxt?=
 =?iso-8859-1?Q?TOa1MQUFsZBAq8B/WOtxJIf2VblM0zjm7ubr1RkuFCXdxWvLEqDg0hbnBu?=
 =?iso-8859-1?Q?tdfG/rPl1HT4Cbfnb4gTj1422XHMluoUhfeAAzcSZbD0uIPc0tzXr0YhPn?=
 =?iso-8859-1?Q?B3HjcaH/MJ1FEMd0hEs2LSYcgyyhn8S1a2TcwsqT8hGaRMhgxM/RUjDAmS?=
 =?iso-8859-1?Q?85GdqewwNu2cLpuz1xnSvcH3CjcOsqH0TQmW6Y7WmcU11Gj3cfxX/FzQ3b?=
 =?iso-8859-1?Q?8I+k2NzLqtT9vZ6jpLpV3+Rxokq1Q/XEvwKNpAbLEE4wBynBfAMaFafAvn?=
 =?iso-8859-1?Q?3JeeU8H4ovd7eVysgcVAmwy/UNAEZD3+2rrc6C+2M+PorjKBlbA8YxW8Hs?=
 =?iso-8859-1?Q?+4VzVtzpn0Nz895yboNaEVXllxT2eXnPRW72IHeBeSh4kBjtjbgPwWaHe9?=
 =?iso-8859-1?Q?TVuB3YkZ5H1bx7RAqMpTVcJFqUQpYyd1ELL03YpsrKe6MUa/AXRxjFR9pB?=
 =?iso-8859-1?Q?inXxRd68jE6SUCSZTTQRn00gYcSBpwKBAGoUEkUC0A+/zfoZusA4HHt7yC?=
 =?iso-8859-1?Q?j+KWcaXGMvEN5YSjqdoi0QUZk1CcWs8vvZh2ZR/JdH+Ym1t9pzSm0yKvJ1?=
 =?iso-8859-1?Q?QCTrLsA3087oKTXaga2F1rhaCEZ4511ZnfY8BwBGQYnOnE/tVDU6xTkgLE?=
 =?iso-8859-1?Q?ZzxrdmDtZLbm66SdWIdC1YnWHrCntdwbjQcX8W+tlQRQQXq0mrPKkLCCiA?=
 =?iso-8859-1?Q?LdINJSIUwFUYY1JVoMfu5or6/9vp+HlIYzrfPRB8Oa24AWfPmSL2tJgZMC?=
 =?iso-8859-1?Q?rvAS/ukSTvAxz9L0/wJXAYgs4bIlZRdNCnpVRejD2Fh1yAwJUtUm2PKqhH?=
 =?iso-8859-1?Q?5xI2cPz0GQq+OjtVlRna6oG8fJjhcSbseIyul7OTjoHhhwtk/BRstfy9dz?=
 =?iso-8859-1?Q?VveQgtdVPnhnW5641OBWzqvBsUkpomkMqgBJdsiOvMw9fgoMnr6pARuWQ7?=
 =?iso-8859-1?Q?GC0AkRMU5SCu1ZxLFLojK+jTUjx1M/i3BFcV6A3rHN0AnTpmEf54RfH9SE?=
 =?iso-8859-1?Q?qYZ7rQlN1bds0R8qamJHrPIGuxXDg9mljLZBA2hf7TG7Ppv4uhTQxhLxnj?=
 =?iso-8859-1?Q?hCYNGeDOhHlO5ZYDGN2nPrCII/qOWUSQEpxTArTrjedsvToSq1wiiElwQ5?=
 =?iso-8859-1?Q?WId3+vgEx4Bp78Y/xL1KBvQ1IVut4mgJwu1PWVP/66uf6HTfeFjhsworhZ?=
 =?iso-8859-1?Q?2gZ1nu/MAml4d43ggFk16AgxUiRo0qyb3JdYs31i/FfIvxUU/VfDHOQN4n?=
 =?iso-8859-1?Q?f+Sgi/fxEFajax57d1okM7aqI59NRpozBdXUH45mt3BPq7MUzr84yqxEv9?=
 =?iso-8859-1?Q?ftEsYMEZpwaHjM4zr7egoRRVsyvlnmtx76E5ZlhZik4m7Vhld0w/u+alvw?=
 =?iso-8859-1?Q?LogX3MtgTaHLj/gkOkDW8toFlXkrUPgNPZb2la8tr4om71T/ZCNH+lJnU7?=
 =?iso-8859-1?Q?qLvuU/bPvUpy9M1jLD49s6tlYSVl6Gr1raY2HzydVKKzzPafHg06?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553f3425-cb13-4e13-c21f-08de89c40885
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:40:17.4770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mw2RVOnUlgdgEi3lD7lNr9277IMuZyVVCZTh6Q6cnXBB97DXCETl/Lw9dvNgl1xnyfo+L1UMwnDbSM8+KhwCXUzMXQccQICyy2mBAOeCSxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7005
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

Add functional test for RISC-V big-endian.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 tests/functional/riscv64/meson.build       |  1 +
 tests/functional/riscv64/test_bigendian.py | 57 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tests/functional/riscv64/test_bigendian.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv6=
4/meson.build
index b996c89d7d..d06d6ea112 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -11,6 +11,7 @@ tests_riscv64_system_quick =3D [
 ]
=20
 tests_riscv64_system_thorough =3D [
+  'bigendian',
   'boston',
   'sifive_u',
   'tuxrun',
diff --git a/tests/functional/riscv64/test_bigendian.py b/tests/functional/=
riscv64/test_bigendian.py
new file mode 100644
index 0000000000..9e0b3b7db5
--- /dev/null
+++ b/tests/functional/riscv64/test_bigendian.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Functional tests for RISC-V big-endian support
+#
+# Copyright (c) 2026 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBigEndian(QemuSystemTest):
+    """
+    Tests for RISC-V runtime big-endian data support.
+
+    Uses a bare-metal RV64 ELF that detects data endianness at runtime
+    by storing a 32-bit word and reading back byte 0. Prints "ENDIAN: BE"
+    or "ENDIAN: LE" to the NS16550A UART on the virt machine.
+    """
+
+    timeout =3D 10
+
+    ASSET_BE_TEST =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/'
+        'riscvbe-baremetal/be-test-bare-metal.elf',
+        '9ad51b675e101de65908fadbac064ed1d0564c17463715d09dd734db86ea0f58'=
)
+
+    def _run_bare_metal(self, big_endian=3DFalse):
+        self.set_machine('virt')
+        kernel =3D self.ASSET_BE_TEST.fetch()
+        self.vm.add_args('-bios', 'none')
+        self.vm.add_args('-kernel', kernel)
+        if big_endian:
+            self.vm.add_args('-cpu', 'rv64,big-endian=3Don')
+        self.vm.set_console()
+        self.vm.launch()
+        expected =3D 'ENDIAN: BE' if big_endian else 'ENDIAN: LE'
+        wait_for_console_pattern(self, expected)
+
+    def test_bare_metal_littleendian(self):
+        """
+        Boot bare-metal ELF on virt with default little-endian CPU.
+        Expects "ENDIAN: LE" on UART.
+        """
+        self._run_bare_metal(big_endian=3DFalse)
+
+    def test_bare_metal_bigendian(self):
+        """
+        Boot bare-metal ELF on virt with big-endian=3Don CPU property.
+        Expects "ENDIAN: BE" on UART.
+        """
+        self._run_bare_metal(big_endian=3DTrue)
+
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1


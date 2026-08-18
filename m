Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508B7C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG2Q-0001sC-0I; Tue, 18 Aug 2026 05:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2O-0001qu-4E; Tue, 18 Aug 2026 05:23:16 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2L-0001a1-JZ; Tue, 18 Aug 2026 05:23:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPClSAKcMaj4LYLMigHKWO3Y4Ff8S8pROLA4X4RyCP8pfi9D+hr1sogXPwbLfcJkx9ZbM01LOAP484CxwTvB+ReAhtr/+c6Pl8Bb7asmKDBOpSq66qlTyD4V2INQJHRUoo+6YsZniSDghWiSTA7enGPq6X3I2UC6cswnLpwL9dInBVHCH7iIbzBgtYTVVM3p1ERK7ACHZBLTVjmHWhGtFPICfD3aJ8/aCcxXWfIFfkJtISwD1cQuigiS5SB41zfwLj6VGJBoQDA4DF8SnjkgZzl0TB2mIivKpBhct+A2oIssLpkpVMwdwDn1tTpLAjp8Rp8jvrtmwOt1hUAq5bj8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU8BcZQef8iB3IFJ5XohrzlVxLidK/IZ9BXq4N01Tf4=;
 b=JBd6e3MEOx3ZlDnrbBjK5CFfutGyHu4IPF9WNvxpLyJSiQaG8v3EaPa35TlCV9CsBDz51L7Z8aB8mV9rzDbx/OYviVNKywb6bxyYLqgPiWgv3PFBDXrWJxpymTOxzm5Jrx38OVgCmciG/LFxEd9Wgb3wTG3pbrvHx96pV0VCuLZ6y24XTb9g4J0Mkbm2vkIu77P3MBGrPr9RrcLt/Yk/lNNv8MOtKjFDv4zWp6GWAI1nFj5on670LzpE1DtlioFHN6MMQktU74VkgZWl2TkGoODU92JBBevYozFjJ2SZ8uPczlzQTgZjq//sz+XIIxzjoLZhrW0hRK1jA3fHGuDs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU8BcZQef8iB3IFJ5XohrzlVxLidK/IZ9BXq4N01Tf4=;
 b=Z1t8KJyc8E8hCoyaZ0mgFLvEjHhnJHKuasoZ4mSMSrOpm60bbvwNwNuO7d0338TrABQXTopemXGcws/XkUwpeQw+vSSNYSPIVyddBKMXwkEui6d8OvFsmsakjE6Qhzgd3IrUgOXm5TdJN0Yg2CCctE5JUaG0yr2QKbpgt7lzjSv+3mcbNONalxPOY0UmyFuMxNB/fwbYVhABLwgB+bZhAQPltobnS9zwW9krlt8qKyBVFnvEOUlzOodCgkylXaqVpZke/5xbYJylvBU/PIZzB+PWELwYh0ujnD8pMDbnQ4pm/gysnFYhjTGQP8QYTmYdvANQ+znbHcSabmP2UfcMhw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:23:05 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:23:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 8/8] tests/qtest: Add ASPEED SBC ECDSA engine test
Thread-Topic: [PATCH v1 8/8] tests/qtest: Add ASPEED SBC ECDSA engine test
Thread-Index: AQHdLvMs8ttTpiwfPEudO8nu+Ak1VQ==
Date: Tue, 18 Aug 2026 09:23:04 +0000
Message-ID: <20260818092249.602137-9-jamin_lin@aspeedtech.com>
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5982:EE_
x-ms-office365-filtering-correlation-id: a6ecf1d6-f424-4b77-e09c-08defd0a4ebb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|38070700021|6133799003|10067099003|921020;
x-microsoft-antispam-message-info: HRkopjogSFFJjqt5CZONML5GksJfULtpbMZDIQPLogaL+d7rlW1y2Pi+tIW+y0TrHQRqNnukZuxSNXyvKIkyHxOl8/9XHbkZmQyr7sFic1r+rtGhfBEqspJXYdV1IPvAt2wM1KttBsMPKTBQleEcWXrHLZe3A2Zmb4IJm1tfQpK7VMNeUPE9isj1qHxT5ynu4vgEWsRxQ0cJUS/tS+FwbKBnUdgkU47j5eo8wzD938wv1wiHiOQgfy8HEz6QAZTpMGJfrRHkvX3hHrlxflrzFUlxKWTynEbVB5804ARFbWaUy987KDi9CVt3lJH4oYx3HeAz4Z7efcDz0+LGyjeI5hLJm8KItvgRIbGre3h4R5xYK8h6dqmHEk9GtSkSkw0/GxKZ0nu8hyN6qn9fF/WzdyBN2GO7ddxtOEJpeyGZ/KEbF47hNOuRiS+X2mc8umYG02IsN2ud8eXkQIRNnb+7PPTHbDMIDmU52iq+ETHmzBtlwVTnDscuTb9IM99shYeIjFpL2M/oMzk5x0rgYiOz9bBEIH9sMMfpzwF7KEJbvWxPlsBgTvBGud8DjMdFl1oyVf98qcpFMBU00p0g7aZhDlNXFUelXbqLIwd6R4h33uapP8h8y6svvM6Ul0Ao3ppN8KPuamnv4QA5zYyINFVkKumIQH74BXwdW1GH/GGGmwyb9St09jBIkZt4Ff9kTICAhJODkN8pdOJPORKskP4blzqmWjWN58TYCRsIVZFHquDD7iVUf6R/zFXeoO+1Nmkc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ADAoHbLpD1Pt0rDiH0zLOwhBVYcmhlV9PUpQ+9Ad3lKV0fQvNlzS8wptNa?=
 =?iso-8859-1?Q?tjzdIYklYlwKsfn3fuFt3O0pK4XUcMXrud2yPwtsfrCPIZF2sHegNPk7RS?=
 =?iso-8859-1?Q?kzqnefR2EmJAwpvDhL4+NyKdVD8zGCnoD8IcCxM1wihwB5u5Z6YIKJDsR6?=
 =?iso-8859-1?Q?QZJom71w7GjoNuIfCemW9ssLb+qO0CSKPNNl1LOHxmN9KDO+6m+WI9Ofnc?=
 =?iso-8859-1?Q?zPd1PmGhKqRUgBZWRKoBqsjM8Mvz2gPCD16fuFxEPo10I3O9EsU6dW+UTa?=
 =?iso-8859-1?Q?RNp+qSmKp+IMy5K7oyTepXBGAAZB37tJ0IWW9hyEK0EP3Xai/CWns+IpEU?=
 =?iso-8859-1?Q?RDeTu3Qh4QxtpDAboO31ni3XV4HbydSmJKe7ic8EUdHOUyZBOL7udFTwzf?=
 =?iso-8859-1?Q?mWmci0QZPHr/zJTeh7pBBKaWbUEUEwN6DNrBQANKn+7wKocEkDQ8xXKTxd?=
 =?iso-8859-1?Q?I+OoxQk84j9b9hDrbJlno7I7qIsq9uxGdjPLgJesG6LgpPR2TPngchn8DX?=
 =?iso-8859-1?Q?lrRdjb/L+UXGZcXwcK+qUgqTSrpwBj/pmK0AHNcqldWiBpRn666VG9BRz8?=
 =?iso-8859-1?Q?Xxe1xKnTrI8pv/CpGn6Sy+Ux4hjWU5BtTRT0wJ9N3EdeLjYxJc4szkXVjF?=
 =?iso-8859-1?Q?R4Us+yTagGhc3vS/nuhh5CWhJgdr/snstiuK6O+JhQYuLDXYQI16DjV9Ij?=
 =?iso-8859-1?Q?CsGkgF5VJVtneyXTBog0bMBbgKu3MAUDLkImhN9V68t30+5ap+zSlq4L8s?=
 =?iso-8859-1?Q?CPf0E2kEV/rZ4UZczdxrdo1fg3LDJJUerRHqUg8BwYDGqLzVhvGUGJ6HYA?=
 =?iso-8859-1?Q?H8GSwvoaqO65f8n/iDDN2mDdItpsM9xtUb2Z12Jg/fe+MfZb93wNh+XdUf?=
 =?iso-8859-1?Q?E87ygU7cRNN2SKzyzFZ3h6nLL02tbpkqoCCUVaNKHfe0D8MjadygoKzET7?=
 =?iso-8859-1?Q?wPOEVmf/ZjoK/e8w0Yz83Cf28mdiIqvI718j/fTkAYQuUOIZaYX9EPzuEL?=
 =?iso-8859-1?Q?UyL1mujZoPKsm3zgqOt/OMORnZOn5Xc+5CxCvV6Hh/AWRHI39VeP/4t7SS?=
 =?iso-8859-1?Q?Pk/6QIZ+ZFMjobTKRIxbPWudIgi4sYw+6X8WG98VnbVTC5gk1I5Np6RiR5?=
 =?iso-8859-1?Q?sw4V4KzBlJeMc7Fp8rg0wY9ruYrKH5mL9aq//WdfVwTObqxT6Wh2s0Vhx3?=
 =?iso-8859-1?Q?Rxj2uGfEUBuxuXVgsR8jDD1tV+2hYBMvI/VSouDZyTH53aUetkPADf/QKt?=
 =?iso-8859-1?Q?/PPY8lGnOKsVRiWkGU35jQUIgIAgOfvBsz/hxcvGd9knJcPtOnd4HqoBBG?=
 =?iso-8859-1?Q?O+4QUw+GZYlVKG4rx/Li/WaMFZ8SmsjDB61ZdmqW9zizhvyNB+09F3Y8v5?=
 =?iso-8859-1?Q?pME7/NpijD8coqwtEloCB+4hzUTxJgBR+QQJ1OrSvibg79gaK92MLv1Wzx?=
 =?iso-8859-1?Q?C0V5goxm4FpnIep7lCDR4Sxbbn2e97U3JR2Yalzvn9hY/9ddxF98ddoJYQ?=
 =?iso-8859-1?Q?CbhhOyHFgXhLmwxJMfqGt4qgbKtfkx3tOG87E8JnKw/4GKTBsaaNTtAXg/?=
 =?iso-8859-1?Q?iGym37TpPkbqkLnmq/N1JqipVvGLUIAcUsPYy63/oztR3d7cxASVo7ruaX?=
 =?iso-8859-1?Q?5+1imjvXw5mQsIAZII2BqTBrX9RSFOllQqTTrf+wknwRnJlhQs2/aDSBvh?=
 =?iso-8859-1?Q?+ubslLV+k7s6hW437+T0sCDwUH8dM5JhGFtCaA1shC1N5qYzdWz14dc/48?=
 =?iso-8859-1?Q?B6DLZGFRn7j4hcXNxEPNmOHt5ELt86i0ClCj7oNVuaJb12Zg1CRlAfPJeL?=
 =?iso-8859-1?Q?UjxHbfBwXA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LIIAJTw94pru5Xq9e+/sfBC+yGgyWtfQ3TAa7bBQztZsar3x4GkWFXphud4kQzRsvSmi8McyNcNcPoVTPtSUgAYKvMdlzDbPwd9bSpsKaGcaKm3XlTMhScm0Ht/NDUdxhFYJRzKIod910Xo8uCt7s7083qgZNefPrhs7hkrwYh1p7rWLRBjQ/nlzUDcbAulOQpTfdGmj/HAVi9FGepf06YXqf27rLqOZES4NnMMCg3wQnJPFll47hNe/rcK8oQRF4+P3NPnapZm+f6YTX12af8yvX20o/SKreB/O6DhoiH8DYfvNAcSsdyKSpskTgJ5LDq39RTIXtc50BPyx0iHBaw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ecf1d6-f424-4b77-e09c-08defd0a4ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:23:04.3958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QWGNqQl+lk6XEXEehCRsgS7U/9yHFhFLv9AdbvafPieBYYMezRT4ewsZkEupMIhwyFEC2k1Pl2MEutlmDNxzUEbWPBXw+dN+eROFKh/9XE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982
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

Add a qtest for the ASPEED secure boot controller ECDSA engine. It stages=
=0A=
the public key, signature and SHA-384 digest of a secp384r1 known-answer=0A=
vector (from the Linux kernel crypto self-test manager,=0A=
ecdsa_nist_p384_tv_template) into the SEC SRAM, triggers the engine's=0A=
verify command and checks the status register: a valid signature reports=0A=
done + pass, and a tampered signature reports done without pass.=0A=
=0A=
The test is skipped when the crypto backend does not support ECDSA, via=0A=
qcrypto_akcipher_supports().=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-sbc-test.c | 190 ++++++++++++++++++++++++++++++++++=0A=
 tests/qtest/meson.build       |   2 +=0A=
 2 files changed, 192 insertions(+)=0A=
 create mode 100644 tests/qtest/aspeed-sbc-test.c=0A=
=0A=
diff --git a/tests/qtest/aspeed-sbc-test.c b/tests/qtest/aspeed-sbc-test.c=
=0A=
new file mode 100644=0A=
index 0000000000..927a54dffb=0A=
--- /dev/null=0A=
+++ b/tests/qtest/aspeed-sbc-test.c=0A=
@@ -0,0 +1,190 @@=0A=
+/*=0A=
+ * QTest testcase for the ASPEED Secure Boot Controller (SBC)=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "libqtest.h"=0A=
+#include "qemu/bitops.h"=0A=
+#include "crypto/akcipher.h"=0A=
+=0A=
+/* SBC register block */=0A=
+#define SBC_STATUS              0x014=0A=
+#define  SBC_ECDSA_VERIFY_PASS  BIT(21)=0A=
+#define  SBC_ECDSA_VERIFY_DONE  BIT(20)=0A=
+#define SBC_ECDSA_CMD           0x0bc=0A=
+#define  SBC_ECDSA_CMD_TRIGGER  BIT(1)=0A=
+=0A=
+/*=0A=
+ * SEC SRAM operand offsets for a secp384r1 ECDSA verify. Every operand is=
 a=0A=
+ * 48-byte big-endian integer.=0A=
+ */=0A=
+#define ECDSA_SRAM_QX   0x2080=0A=
+#define ECDSA_SRAM_QY   0x20c0=0A=
+#define ECDSA_SRAM_R    0x21c0=0A=
+#define ECDSA_SRAM_S    0x2200=0A=
+#define ECDSA_SRAM_M    0x2240=0A=
+=0A=
+/*=0A=
+ * ECDSA secp384r1 / SHA-384 known-answer vector from the Linux kernel cry=
pto=0A=
+ * self-test manager (ecdsa_nist_p384_tv_template, sha384 entry in=0A=
+ * crypto/testmgr.h, v6.18), decoded into raw big-endian form: public key=
=0A=
+ * Qx || Qy, signature r || s and the SHA-384 message digest.=0A=
+ *=0A=
+ *   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/crypto/testmgr.h?h=3Dv6.18=0A=
+ */=0A=
+static const uint8_t ecdsa_p384_pubkey[96] =3D {=0A=
+    /* Qx */=0A=
+    0x3a, 0x2f, 0x62, 0xe7, 0x1a, 0xcf, 0x24, 0xd0,=0A=
+    0x0b, 0x7c, 0xe0, 0xed, 0x46, 0x0a, 0x4f, 0x74,=0A=
+    0x16, 0x43, 0xe9, 0x1a, 0x25, 0x7c, 0x55, 0xff,=0A=
+    0xf0, 0x29, 0x68, 0x66, 0x20, 0x91, 0xf9, 0xdb,=0A=
+    0x2b, 0xf6, 0xb3, 0x6c, 0x54, 0x01, 0xca, 0xc7,=0A=
+    0x6a, 0x5c, 0x0d, 0xeb, 0x68, 0xd9, 0x3c, 0xf1,=0A=
+    /* Qy */=0A=
+    0x01, 0x74, 0x1f, 0xf9, 0x6c, 0xe5, 0x5b, 0x60,=0A=
+    0xe9, 0x7f, 0x5d, 0xb3, 0x12, 0x80, 0x2a, 0xd8,=0A=
+    0x67, 0x92, 0xc9, 0x0e, 0x4c, 0x4c, 0x6b, 0xa1,=0A=
+    0xb2, 0xa8, 0x1e, 0xac, 0x1c, 0x97, 0xd9, 0x21,=0A=
+    0x67, 0xe5, 0x1b, 0x5a, 0x52, 0x31, 0x68, 0xd6,=0A=
+    0xee, 0xf0, 0x19, 0xb0, 0x55, 0xed, 0x89, 0x9e,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p384_signature[96] =3D {=0A=
+    /* r */=0A=
+    0x9b, 0x28, 0x68, 0xc0, 0xa1, 0xea, 0x8c, 0x50,=0A=
+    0xee, 0x2e, 0x62, 0x35, 0x46, 0xfa, 0x00, 0xd8,=0A=
+    0x2d, 0x7a, 0x91, 0x5f, 0x49, 0x2d, 0x22, 0x08,=0A=
+    0x29, 0xe6, 0xfb, 0xca, 0x8c, 0xd6, 0xb6, 0xb4,=0A=
+    0x3b, 0x1f, 0x07, 0x8f, 0x15, 0x02, 0xfe, 0x1d,=0A=
+    0xa2, 0xa4, 0xc8, 0xf2, 0xea, 0x9d, 0x11, 0x1f,=0A=
+    /* s */=0A=
+    0xfc, 0x50, 0xf6, 0x43, 0xbd, 0x50, 0x82, 0x0e,=0A=
+    0xbf, 0xe3, 0x75, 0x24, 0x49, 0xac, 0xfb, 0xc8,=0A=
+    0x71, 0xcd, 0x8f, 0x18, 0x99, 0xf0, 0x0f, 0x13,=0A=
+    0x44, 0x92, 0x8c, 0x86, 0x99, 0x65, 0xb3, 0x97,=0A=
+    0x96, 0x17, 0x04, 0xc9, 0x05, 0x77, 0xf1, 0x8e,=0A=
+    0xab, 0x8d, 0x4e, 0xde, 0xe6, 0x6d, 0x9b, 0x66,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p384_dgst[48] =3D {=0A=
+    0x8d, 0xf2, 0xc0, 0xe9, 0xa8, 0xf3, 0x8e, 0x44,=0A=
+    0xc4, 0x8c, 0x1a, 0xa0, 0xb8, 0xd7, 0x17, 0xdf,=0A=
+    0xf2, 0x37, 0x1b, 0xc6, 0xe3, 0xf5, 0x62, 0xcc,=0A=
+    0x68, 0xf5, 0xd5, 0x0b, 0xbf, 0x73, 0x2b, 0xb1,=0A=
+    0xb0, 0x4c, 0x04, 0x00, 0x31, 0xab, 0xfe, 0xc8,=0A=
+    0xd6, 0x09, 0xc8, 0xf2, 0xea, 0xd3, 0x28, 0xff,=0A=
+};=0A=
+=0A=
+typedef struct AspeedSBCECDSA {=0A=
+    const char *name;=0A=
+    QCryptoCurveID curve_id;=0A=
+    const uint8_t *pubkey;=0A=
+    const uint8_t *signature;=0A=
+    const uint8_t *dgst;=0A=
+    size_t coord_len;=0A=
+} AspeedSBCECDSA;=0A=
+=0A=
+static const AspeedSBCECDSA sbc_ecdsa_tests[] =3D {=0A=
+    {=0A=
+        .name =3D "secp384r1",=0A=
+        .curve_id =3D QCRYPTO_CURVE_ID_SECP384R1,=0A=
+        .pubkey =3D ecdsa_p384_pubkey,=0A=
+        .signature =3D ecdsa_p384_signature,=0A=
+        .dgst =3D ecdsa_p384_dgst,=0A=
+        .coord_len =3D 48,=0A=
+    },=0A=
+};=0A=
+=0A=
+typedef struct AspeedSBCTest {=0A=
+    const char *machine;=0A=
+    uint32_t base;=0A=
+    uint64_t sram_base;=0A=
+    int index;=0A=
+} AspeedSBCTest;=0A=
+=0A=
+static void sbc_ecdsa_stage(QTestState *qts, const AspeedSBCTest *c,=0A=
+                            const AspeedSBCECDSA *t)=0A=
+{=0A=
+    size_t len =3D t->coord_len;=0A=
+=0A=
+    qtest_memwrite(qts, c->sram_base + ECDSA_SRAM_QX, t->pubkey, len);=0A=
+    qtest_memwrite(qts, c->sram_base + ECDSA_SRAM_QY, t->pubkey + len, len=
);=0A=
+    qtest_memwrite(qts, c->sram_base + ECDSA_SRAM_R, t->signature, len);=
=0A=
+    qtest_memwrite(qts, c->sram_base + ECDSA_SRAM_S, t->signature + len, l=
en);=0A=
+    qtest_memwrite(qts, c->sram_base + ECDSA_SRAM_M, t->dgst, len);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Drive one ECDSA verify through the engine the way the guest firmware do=
es:=0A=
+ * stage the operands in the SEC SRAM, trigger the command register and re=
ad=0A=
+ * back the done/pass bits in the status register.=0A=
+ */=0A=
+static void test_ecdsa_verify(const void *opaque)=0A=
+{=0A=
+    const AspeedSBCTest *c =3D opaque;=0A=
+    const AspeedSBCECDSA *t =3D &sbc_ecdsa_tests[c->index];=0A=
+    QTestState *qts =3D qtest_init(c->machine);=0A=
+    uint32_t status;=0A=
+    uint8_t bad;=0A=
+=0A=
+    /* A valid signature verifies */=0A=
+    sbc_ecdsa_stage(qts, c, t);=0A=
+    qtest_writel(qts, c->base + SBC_ECDSA_CMD, SBC_ECDSA_CMD_TRIGGER);=0A=
+    status =3D qtest_readl(qts, c->base + SBC_STATUS);=0A=
+    g_assert_cmphex(status & (SBC_ECDSA_VERIFY_DONE | SBC_ECDSA_VERIFY_PAS=
S),=0A=
+                    =3D=3D, SBC_ECDSA_VERIFY_DONE | SBC_ECDSA_VERIFY_PASS)=
;=0A=
+=0A=
+    /* A tampered signature must fail */=0A=
+    bad =3D t->signature[0] ^ 0xff;=0A=
+    qtest_memwrite(qts, c->sram_base + ECDSA_SRAM_R, &bad, 1);=0A=
+    qtest_writel(qts, c->base + SBC_ECDSA_CMD, SBC_ECDSA_CMD_TRIGGER);=0A=
+    status =3D qtest_readl(qts, c->base + SBC_STATUS);=0A=
+    g_assert_cmphex(status & SBC_ECDSA_VERIFY_DONE, =3D=3D, SBC_ECDSA_VERI=
FY_DONE);=0A=
+    g_assert_cmphex(status & SBC_ECDSA_VERIFY_PASS, =3D=3D, 0);=0A=
+=0A=
+    qtest_quit(qts);=0A=
+}=0A=
+=0A=
+static void aspeed_add_sbc_ecdsa_tests(const char *prefix, const char *mac=
hine,=0A=
+                                       uint32_t base, uint64_t sram_base)=
=0A=
+{=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ARRAY_SIZE(sbc_ecdsa_tests); i++) {=0A=
+        QCryptoAkCipherOptions opts =3D {=0A=
+            .alg =3D QCRYPTO_AK_CIPHER_ALGO_ECDSA,=0A=
+            .u.ecdsa.curve_id =3D sbc_ecdsa_tests[i].curve_id,=0A=
+        };=0A=
+        g_autofree char *path =3D NULL;=0A=
+        AspeedSBCTest *t;=0A=
+=0A=
+        if (!qcrypto_akcipher_supports(&opts)) {=0A=
+            g_printerr("# skip SBC ECDSA %s test: not supported by the cry=
pto "=0A=
+                       "backend\n", sbc_ecdsa_tests[i].name);=0A=
+            continue;=0A=
+        }=0A=
+=0A=
+        path =3D g_strdup_printf("%s/sbc/ecdsa/%s", prefix,=0A=
+                               sbc_ecdsa_tests[i].name);=0A=
+        t =3D g_new0(AspeedSBCTest, 1);=0A=
+        t->machine =3D machine;=0A=
+        t->base =3D base;=0A=
+        t->sram_base =3D sram_base;=0A=
+        t->index =3D i;=0A=
+        qtest_add_data_func_full(path, t, test_ecdsa_verify, g_free);=0A=
+    }=0A=
+}=0A=
+=0A=
+int main(int argc, char **argv)=0A=
+{=0A=
+    g_test_init(&argc, &argv, NULL);=0A=
+=0A=
+    aspeed_add_sbc_ecdsa_tests("ast1030", "-machine ast1030-evb",=0A=
+                               0x7e6f2000, 0x79000000);=0A=
+=0A=
+    return g_test_run();=0A=
+}=0A=
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build=0A=
index f7c7d06620..af7a460e08 100644=0A=
--- a/tests/qtest/meson.build=0A=
+++ b/tests/qtest/meson.build=0A=
@@ -222,6 +222,7 @@ qtests_npcm8xx =3D \=0A=
 qtests_aspeed =3D \=0A=
   ['aspeed_gpio-test',=0A=
    'aspeed_hace-test',=0A=
+   'aspeed-sbc-test',=0A=
    'aspeed_scu-test',=0A=
    'aspeed_smc-test']=0A=
 qtests_aspeed64 =3D \=0A=
@@ -394,6 +395,7 @@ endif=0A=
 qtests =3D {=0A=
   'aspeed_hace-test': [files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),=
=0A=
                        crypto],=0A=
+  'aspeed-sbc-test': [files('aspeed-sbc-test.c'), crypto],=0A=
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),=0A=
   'ast2700-hace-test': [files('aspeed-hace-utils.c', 'ast2700-hace-test.c'=
),=0A=
                         crypto],=0A=
-- =0A=
2.53.0=0A=


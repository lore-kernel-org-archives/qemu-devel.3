Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04894C624C6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KF0-0003uX-Jy; Tue, 01 Sep 2026 04:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEz-0003uB-Lg; Tue, 01 Sep 2026 04:53:13 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEx-0007J9-I2; Tue, 01 Sep 2026 04:53:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StXY9p9/P+/NdVtCDAZlnMBbgAKOXOFYbeVvk5GZBBEF6fV8VaEqTq3EGrex30bzwaSXGXvjHLfUiFjZAm3ETZFJE8ojVwaKusI/vVaWsXikOJwyBEkiFkd6eEf5OOA73XjgHIUtxupGEnuqYQ+Jb4Tcy0FzQbbH9g73XMpgqahTwZkLTiFWwTX+3nV0g2oUtq2s2U+JBVleDK8e2Bd2oVutzsFVjiJHdQGw2uJFgc/TydwlJ0Ou4PORY3vooEAheLoWRYvPkjZ7oQR3+egQEho8VBi/xn/7hdnyGIkK9VC7mghtfRJHJ3g/mIjBJ0sy+AqBOPjjeXcoQ+tRQPcQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwEYbLgLEdrQlsZKv3r1VModB6T72IIJsnwVWlsepn8=;
 b=Wyf3jOJZgQLoD5bMPLxRYBzVgL0EPui3NWtU4qYEWOotzkt5cEhioj4QsMrHTH0C89VPlWNYy2FNrChLgrOYYlhG+cc8OKUwifzWAdHFe94bA8SHuYcS36PMNkoVXKIL0NCE7cZeMZWwRBViAuqQGklJiBs2ylGFfBrkKLXgJftoIcgsMQFfkzfckCsrf0kxGAEg7W52NJtrtkriZ6ZPjIvDRhNcol5HRW8FcF+06bWB+19eacH+eKpCyNCHzETkfPplp0ePlG5j7nlov57kqbrq2gY/VdIw4LPg//Y77/uYdIJOxmeNQeacAGRkvWxoRmkPQyrnS/HgLISdg/fPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwEYbLgLEdrQlsZKv3r1VModB6T72IIJsnwVWlsepn8=;
 b=llXWUBsGjYHwGc/rs6P3L8e3HJuwHFEysoUSuNvFjqULfF8sF/3X1YntGPzlKf+vCWtNOz3YTpnUwbZyh8RFLfdi3m7LYB8DpSlYzV8kBFh5uNvM/UeyhG2Udz7PBq1J1A0L3mg7WnIEhiLaC4QrbH1AojbqiVrwdcRKSRa9wyvAB+CU/hUV06mVuL+Qpd8DuNbKLMrCucT08XbkZeTxd9138W+ZL7F9G5e/JlRjTjew4KN/O4bJnuOSGJiJkHe8ldNqh5vG8ow8rFnVzqAAkYOaeRx5NUNVbqnqmMapwvX+WAOxvCCSckzVTZLp0Bh6eevt4w7lFJNpwgN/1/L6qg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF557D403C2.apcprd06.prod.outlook.com (2603:1096:d18::495)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 1 Sep
 2026 08:52:50 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:52:50 +0000
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
Subject: [PATCH v4 9/9] tests/qtest: Add ASPEED SBC ECDSA engine test
Thread-Topic: [PATCH v4 9/9] tests/qtest: Add ASPEED SBC ECDSA engine test
Thread-Index: AQHdOe9Efh0Mw+LIZk60bAQoVSVzmQ==
Date: Tue, 1 Sep 2026 08:52:50 +0000
Message-ID: <20260901085238.995968-10-jamin_lin@aspeedtech.com>
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF557D403C2:EE_
x-ms-office365-filtering-correlation-id: 704ee438-f411-4777-c418-08df0806670f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|921020|38070700021|6133799003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: CC+AFOlFL1/LwCXayoeQDR+6OHEonHidkCy+hgqrtBWNqMNdgAOl+XWkWiA8GYxSwf1GMIgj5FjwijWYLYC1136G8yWDM3dwpRb6yN4fpfbGwB7YAw3+hDzwbYQdrO3nNQEfL+bqFepIO5tclrUnGXYi/vjaOi6lBQyoVqNbxyf+YG3O9z1/2nW7jAn8d8Nn3GrNQrqDhcWXkQXZ2TiFIIr+kVjmpbStRWtdA+eOaZEg60rNtkVDNh4yHm2nY7iR8R54ePhBmbV9L0TFwD+HlI3uq2DGbJBHpT6P95XZdVPAFCmWP0IzwOOIc3j8qOlNmEiEJNy0eU3hJbVYaD53eGmRb+28vmRfduC4hqMf5/HwIZFZ4wIPp8yR7RBYAfzGWAw6s+neS8hZVdrv1lW7T9Dhevon0UTlEdwbQrBN7AUXbgqakecWCKKGRv/D7F5d9sccQpK2eoQBE4Qli6EBSQPtcEfFWz8xlG/xbQ2GhRfzFlHTjpjhoSDIdhaF2143u4428wmcXtuBUUWxUss1EyFk7flFGLZ8FN0nXtxWeNr0w4O/N3vxU4EQXX36hGGCiP4/UdEPt9OFoIqESp+cBYTc4UTRvcRd+FWp5FzHi9+vA3j09CuZViedH8p78s6XFdOjRhM4++PfRdkXhYnbWgIIbW/tmz7UnazqbAL+ubxpaO3oNdUa+wLAIDJpybwAfWvrc/qgYwOhrhR9TX4HC+FnED9MSZ/mE3RzxaROOhKPeLnQy7FTVb1gt41YAKzu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(921020)(38070700021)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ig8pat/QBE7Anch+nZCILVe3QDlu+N9d6HC0jn8h0Y8InIJ2wbRaR8S5Kf?=
 =?iso-8859-1?Q?XGunDfjuD71noydUyKfWphDTpfIX1zS3LQty0zoGzicYuVK+yEbRowD3Dz?=
 =?iso-8859-1?Q?EqmCQzP/QJ2Ga/5PasJrOMlqmmFY2gdUTNblASpG262g9eo8EaMb4hVb/f?=
 =?iso-8859-1?Q?J8CUOA0ngS3udNVqXx7kIGo4vJlCulTSgqVDgWrFpR7+mk5LCUdDp9UNcl?=
 =?iso-8859-1?Q?C/IS168BkE8zKWLCy+YCPtKnDV1q1z53nX7OgAWW1jH6VQ1inixNYVVZWS?=
 =?iso-8859-1?Q?JYEYU0v22L5KGFjWizPoFodQlrzO55lHNlrf/WX2HKfAeBzQV/apEFN33U?=
 =?iso-8859-1?Q?MqtYmsgqDegeQDZpi+uZohoHPenM6d6+uC5JaC6TlmYDDrEJHYBAWxQpab?=
 =?iso-8859-1?Q?7sU6TIeVBQQoWqkFrXhKoOcJ4tbibO+6wd4a7zCHB1uPCPkG3OnHh7wEIm?=
 =?iso-8859-1?Q?oQjUoKesxBrWwcZAaxg2MycyP/S181Z04q/+zTbKVWIhdR48b9iB24EPBI?=
 =?iso-8859-1?Q?+XHmzTf3QtnCHug/LkrgPyrl21HP17AAk0FtuskskhoJIhUyVC6xxRMjfm?=
 =?iso-8859-1?Q?H/bjoIbJNkfdJ/sQLU3TiKSdVUFslfPYMKVCiDiFW69nmbhX6eokHMCJvl?=
 =?iso-8859-1?Q?Y0NMBSLRhpRoszyPb6rjT1FVMSk3Ie8Qb9+uP3fPsVbaRrVk3YMxQqMhYp?=
 =?iso-8859-1?Q?U6X6QpyBNwsSsI0oJvTVpajpD7548AzwFZ1T9o3qieEqsKHLI7GFoAOLSe?=
 =?iso-8859-1?Q?Fwa7M+FRfPrq2GSvu2fotoISiGaWOvT0MR1P1KNu7xOfA+HyjIwaSIjKYl?=
 =?iso-8859-1?Q?jjYMOXjx5ijCtKAssCTiXk273Plll8L7zhlyjZXSiFKqk8Fdb+kCU0v7YP?=
 =?iso-8859-1?Q?DpCkjnSGat1XDWJSKsviLFumjkkhmOBcfnqjIRTtf7dSc4Bd5bn+V93xDa?=
 =?iso-8859-1?Q?bLQ/PHvpYYvuyoAkLR05f6Nt0gcHWE+7En8gS7BL5ptD0v2LBUD/NU7x6I?=
 =?iso-8859-1?Q?YWAdItFZoLyEg4pXR5BYt9hRX0chKz/tLYlNql5PAzDV7cg7opq9lb9GBp?=
 =?iso-8859-1?Q?nOuTe5UMd2tIsp2CHROMnIW0ohCL525UIbW3aDDhEsJrUcaDc3xsnMbiHr?=
 =?iso-8859-1?Q?CV+U4i2K+wsJkKuTd+gh5PkpGgOD1032iSPA7tdqvpFlL9SSIistINgyJv?=
 =?iso-8859-1?Q?M4yROQb6U1z2w56kTr0dLmAMxFywBjqmIbLrDpGXrOcC5QcRFoL4oFYf5s?=
 =?iso-8859-1?Q?Ghg4RpInDSbS0X2/tHlaicbkujvmuthWUfrJs+cEYeofgjO7J2QVzPQX4G?=
 =?iso-8859-1?Q?oG3B7M2i7R09rKRHCjLdcIPbej05isBUmHX2CRctVzAMV+eIPSKWydgrlL?=
 =?iso-8859-1?Q?52whw8iOL2kn+GB4bDpvAmqVVQMnMH8zyVTVwuQxp8xXRy40rCQC3FojJ7?=
 =?iso-8859-1?Q?5hXSY1J8fjRfT/WJ2lSZWdRFDZPwV9Wrux0TlTkWg9cVAgYcMu0qmmlS2H?=
 =?iso-8859-1?Q?bG2o+nW6CQvFfJoFaj3D2fdURtQP3+5vrQBHgxnfEXLFY6xb7ihwJqjjgj?=
 =?iso-8859-1?Q?HMbdKhGX2SB2Pb9Mj28vHgsxO4JRqPiOoUaDSS0BaJvL1uemHnmsE4dLwB?=
 =?iso-8859-1?Q?cALSWhJvelf2a5/F7uXw6rqI+tlDl7CphSXc9LkR+wXo4zyQ7VoSR6vt4Z?=
 =?iso-8859-1?Q?EEO+6x0w6bj11tgDDXjbtKyGhZLIwf9Uy9ZOVFB3Zb9s+nvdiu/oYoNvwk?=
 =?iso-8859-1?Q?ycw58F1AgbiU1VrWRNsdGOy2E0OnrhAYCFcy4CaWgrr5ElmtMi/eoRU1MV?=
 =?iso-8859-1?Q?hIb/lMb7Ug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ELWBmTIJNWtsjlP9nbu7c025aYwKrJmz3FyJcM4Jay8ErkwPJgtOvhYmpJQ9P/y/otuUdUn+b0s5EULtbW2kz00nR9Ev2FI1I4AiDWXe/r/ff7ajfQMNo9eFU3U/RaqqpoGLOMAW4Bt/As8SJzbCtoJX4DsC6b3H8y7NbTO4ROauyXkWKv3o+7hX7yvkcLf0nLHId+TB6jqLqouKG8dTWVsL/4noN+/EQB0txUT/pl3+JETxdLqn07vHek8S/vhJMtTEshqtd8UeTU2Kpl+Czh8F/4HnFXZsucTXzixxt47sEyH9C2VBvJ8K9X3FCBJUBOCQUh0B1VgaNoXvU9xVEA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704ee438-f411-4777-c418-08df0806670f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:52:50.1352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET/J/5s6Ek3O8FIMyEBIv7QRpLtj2eCk9ox5fxa3b7n21rSZj0qZpvnI2KuMW3Vhc0L8a6NI8/hMnyxXjrzsbhMwgFMoz8ya1KQN2KiBscc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF557D403C2
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
 tests/qtest/aspeed-sbc-test.c | 194 ++++++++++++++++++++++++++++++++++=0A=
 tests/qtest/meson.build       |   2 +=0A=
 2 files changed, 196 insertions(+)=0A=
 create mode 100644 tests/qtest/aspeed-sbc-test.c=0A=
=0A=
diff --git a/tests/qtest/aspeed-sbc-test.c b/tests/qtest/aspeed-sbc-test.c=
=0A=
new file mode 100644=0A=
index 0000000000..c445dac47a=0A=
--- /dev/null=0A=
+++ b/tests/qtest/aspeed-sbc-test.c=0A=
@@ -0,0 +1,194 @@=0A=
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
+#define SBC_SEC_TRIGGER         0x0bc=0A=
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
+    uint32_t sec_addr;=0A=
+    uint64_t sram_addr;=0A=
+    int index;=0A=
+} AspeedSBCTest;=0A=
+=0A=
+static void sbc_ecdsa_stage(QTestState *qts, const AspeedSBCTest *c,=0A=
+                            const AspeedSBCECDSA *t)=0A=
+{=0A=
+    uint32_t len =3D t->coord_len;=0A=
+=0A=
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_QX, t->pubkey, len);=0A=
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_QY, t->pubkey + len, len=
);=0A=
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_R, t->signature, len);=
=0A=
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_S, t->signature + len, l=
en);=0A=
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_M, t->dgst, len);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Drive one ECDSA verify through the engine the way the firmware does:=0A=
+ * stage the operands in the SEC SRAM, trigger the command register and re=
ad=0A=
+ * back the done/pass bits in the status register.=0A=
+ */=0A=
+static void test_ecdsa_verify(const void *opaque)=0A=
+{=0A=
+    const AspeedSBCTest *c =3D opaque;=0A=
+    const AspeedSBCECDSA *t =3D &sbc_ecdsa_tests[c->index];=0A=
+    QCryptoAkCipherOptions opts =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_ECDSA,=0A=
+        .u.ecdsa.curve_id =3D t->curve_id,=0A=
+    };=0A=
+    QTestState *qts;=0A=
+    uint32_t status;=0A=
+    uint8_t bad;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opts)) {=0A=
+        g_test_skip("ECDSA is not supported by the crypto backend");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    qts =3D qtest_init(c->machine);=0A=
+=0A=
+    /* A valid signature verifies */=0A=
+    sbc_ecdsa_stage(qts, c, t);=0A=
+    qtest_writel(qts, c->sec_addr + SBC_SEC_TRIGGER, SBC_ECDSA_CMD_TRIGGER=
);=0A=
+    status =3D qtest_readl(qts, c->sec_addr + SBC_STATUS);=0A=
+    g_assert_cmphex(status & (SBC_ECDSA_VERIFY_DONE | SBC_ECDSA_VERIFY_PAS=
S),=0A=
+                    =3D=3D, SBC_ECDSA_VERIFY_DONE | SBC_ECDSA_VERIFY_PASS)=
;=0A=
+=0A=
+    /* A tampered signature must fail */=0A=
+    bad =3D t->signature[0] ^ 0xff;=0A=
+    qtest_memwrite(qts, c->sram_addr + ECDSA_SRAM_R, &bad, 1);=0A=
+    qtest_writel(qts, c->sec_addr + SBC_SEC_TRIGGER, SBC_ECDSA_CMD_TRIGGER=
);=0A=
+    status =3D qtest_readl(qts, c->sec_addr + SBC_STATUS);=0A=
+    g_assert_cmphex(status & SBC_ECDSA_VERIFY_DONE, =3D=3D, SBC_ECDSA_VERI=
FY_DONE);=0A=
+    g_assert_cmphex(status & SBC_ECDSA_VERIFY_PASS, =3D=3D, 0);=0A=
+=0A=
+    qtest_quit(qts);=0A=
+}=0A=
+=0A=
+static void aspeed_add_sbc_ecdsa_tests(const char *prefix, const char *mac=
hine,=0A=
+                                       uint32_t sec_addr, uint64_t sram_ad=
dr)=0A=
+{=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ARRAY_SIZE(sbc_ecdsa_tests); i++) {=0A=
+        g_autofree char *path =3D NULL;=0A=
+        AspeedSBCTest *t;=0A=
+=0A=
+        path =3D g_strdup_printf("%s/sbc/ecdsa/%s", prefix,=0A=
+                               sbc_ecdsa_tests[i].name);=0A=
+        t =3D g_new0(AspeedSBCTest, 1);=0A=
+        t->machine =3D machine;=0A=
+        t->sec_addr =3D sec_addr;=0A=
+        t->sram_addr =3D sram_addr;=0A=
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
+    aspeed_add_sbc_ecdsa_tests("ast1060", "-machine ast1060-evb",=0A=
+                               0x7e6f2000, 0x79000000);=0A=
+=0A=
+    return g_test_run();=0A=
+}=0A=
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build=0A=
index c58be94c25..13de12da02 100644=0A=
--- a/tests/qtest/meson.build=0A=
+++ b/tests/qtest/meson.build=0A=
@@ -223,6 +223,7 @@ qtests_aspeed =3D \=0A=
   ['aspeed-acry-test',=0A=
    'aspeed_gpio-test',=0A=
    'aspeed_hace-test',=0A=
+   'aspeed-sbc-test',=0A=
    'aspeed_scu-test',=0A=
    'aspeed_smc-test']=0A=
 qtests_aspeed64 =3D \=0A=
@@ -397,6 +398,7 @@ qtests =3D {=0A=
                        crypto],=0A=
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


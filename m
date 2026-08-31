Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FD2C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0suZ-00067U-8O; Sun, 30 Aug 2026 23:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suV-00066V-VF; Sun, 30 Aug 2026 23:42:17 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0suT-0006yv-U1; Sun, 30 Aug 2026 23:42:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnpQOvcAZxvtiAMsVTZ0Hac/ANZ8+8lZLm0sRZSOIiUAZqrXRh1YBrnxDsKFwWTmzVC1FwFV2Gw2Do7gIGwnmtCDmBswUAjaxM6AHcQ5cvU/t1qCOktelGQPde7oK/Qgl9fmWy+7cUrWS8DhiykFpmFEnwpwIEaPJz3cgWYFSArVlsYFr5UEm2mU21AOvC1LWvH58Dpgsh0MqHVQZ/DclDZ6rMpFQUh43JjSIYA/OnHyFuKmjwGLOSzI3IObm2thChXru9iqDu8blv5ydTKxbPUlVvq02OXWw2ntLUZFk/6BWoLle6j+Rp4N/CCRISox8fswM4Y8yTZn1YJirE5AFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwEYbLgLEdrQlsZKv3r1VModB6T72IIJsnwVWlsepn8=;
 b=MQ7L7Tkyq2cf5n6HbgbhPBtKJM2S2bdjj5AJQ07EomkjwCZM/U6jcU20jd12wvJ7z4HdJxItjnlOWgaKq5Ni7YJX4eg0RU5B4BOy4uZNpUrwn4yjBZvwTjZZriorx32F0TrHty93Hzj4C348ffNHMzthvmvCgV5LXjKTVgJ4KinoJiTWji+Y+VMBPM8Eb7NCRRi+i2CInBU/QO1lwEyLCqjJBFSYGorwRMBNWzUIkIR3hnS3H67x83SzcPmIGUVs0oFGt47Uf93zD2Lqb8Z6WRzdP5GCzZuus6u7QjGfmGa8BVu5ULEDjCz92nOAt0nIFmHJnhjgxaiABMsLgCSDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwEYbLgLEdrQlsZKv3r1VModB6T72IIJsnwVWlsepn8=;
 b=SN71BAwP/RbQfNDU7Ta+PU/G8/J9eS2A3TxSWOC22J1Y63ZjHPOjWLV4vLvTwqsJJlTULHm7PV6msrxsFIk1aE6o9cBMDA0Ddmo/RiCylaCQrdpB7878KO+p0WNYNdEUs4Vn03czuXNwAUn+wpYKR7l59xAiM4Lg2aRJ2PxkSP4WLDOkSc6Q36LkdW4ifGrOziJDfj3a9w5Jg18NoAjcaqA1wWX2TjDGa92YVKXiYsRi2TkSHPNte4i9XtRmYBhmEizcLXuVA3o6w1oeJWrmgyAuGd2Xv5FyJNss/oz0IKm7928jWDdZ1af3nK3+9rCqp7r12bxn8gmpr0pDg/9mCQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE3PR06MB8096.apcprd06.prod.outlook.com (2603:1096:101:2e3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:42:05 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:42:05 +0000
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
Subject: [PATCH v3 9/9] tests/qtest: Add ASPEED SBC ECDSA engine test
Thread-Topic: [PATCH v3 9/9] tests/qtest: Add ASPEED SBC ECDSA engine test
Thread-Index: AQHdOPqwWmTvtdQKBUGAqFOxgK7iKA==
Date: Mon, 31 Aug 2026 03:42:05 +0000
Message-ID: <20260831034153.192916-10-jamin_lin@aspeedtech.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE3PR06MB8096:EE_
x-ms-office365-filtering-correlation-id: c50e73e0-de0b-4ed0-3f90-08df0711d382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|921020|38070700021|6133799003|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: l/v+JWUan0ButF67T6IkAqpigXGCSWExOQccS4mh2DAIu303Vq8755bkcIGHl+8CRsNn7HuCmP5Y3yKjx0ihWRV+Ln74KH2q9HEmNIoKCVHbc53yCCbCiIDLMwdqc9p6S0LH5PRKFESZWnHssxWiz/xxWXIazGDDgsu4U8g2IYVK/CwZRh/CwVv83xNtpRV1r3XpPuj8epOxKbMql8IhWayWRF2PMdfS4i1B5+AL2aDx0T/MH9V0/vd2mrRBRzs9oq97kcVbf436FBavm4FHiFNX5gZdQEAX3EVf66n3C0z/+zgFTWsNsbjx5tH6zX6km3ALjHTxnx/rqQS9rkR/H63nCX2DMaPbSg1liW4mGDy1kVX6ykjUQaBUsiYj8/MvKcQhNjavtWSuGXxk5/uUWvMHMsF0FHtJns5VVevR1iwsGBIbhJ4edsWIIGWym5XViw0sGRk7qAgv7a4erFWl7w86IqqNPJaJMu0FwQlmKD+9EVwgDpEYds6ZdbaR14CcUIQsWMLspa1RTZcXK94QGLS+RSo+mT/g1tIaDl3DQWrzG9B97O6/9Qi+j8afAYwxuPurqjNMtjD3rqOTNgN0jRoUSZzV+kTRoFR+6gTk6SiygXdWKBQfF2U1bwYQV1iNGN8U482TMOpak10v+5xB/9QitmuthabXvNYiLx0fl1XvKjn0P4dl/OETa6bZGW0nPAdzJd1EnWs84yqDUy+L5xVFO4iEjj8jcm2fm9JhEJjjFbzSjFDUPlid1WpBJEew
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(38070700021)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LLB3acsdtiqrGJ4lg8PpW0zYzObPY0Wc99SstdP1KrELRoC+qExfBeVdpy?=
 =?iso-8859-1?Q?MJ5e+SEW8F/LF4arCrpw7xAlsrh7kJrZn/Sr9cB/wYKs4R0z/varYMt4wy?=
 =?iso-8859-1?Q?V/zCykXLr99eB/ppsc6YufpSRG3Qeksh/JQWcZ3/T52mwsTnUq25PmDVet?=
 =?iso-8859-1?Q?8kpZRhMXb0aIGRvRR6Pf0e7ZMIFmMyWOBgRaR/0mwnhf8ohBp4ElMR9+QR?=
 =?iso-8859-1?Q?5q3nD0Wkb2dRsfhKZqjJn0xIqrKFAn/vGl/sMKllpXkKzIBBAocMqSTTc6?=
 =?iso-8859-1?Q?UI3NAGbob53r95XaDh/C9izo/6ff5xXZpFax18ll7weWfp340G4kw2jkJ2?=
 =?iso-8859-1?Q?pK6juExhZvKiaxbx6uidPwCAG1+uAROjVJKnmLRZ0f8iEIcIGpJLUN/y3d?=
 =?iso-8859-1?Q?m6lzPbV6QdIg1horOzuxHSKpDoz29d710GNd26B31ispVD7IjgHLArwb4W?=
 =?iso-8859-1?Q?kf0TPJ/IILoHg0LAZNkOAR8kY0pDoBtZthIkucHo30420i+UA1ikqxpJAF?=
 =?iso-8859-1?Q?WvCFpRyUoPcb4QthUmZBJiJ1S3HLTW/IaKXjsogQEuZ4KiROYZJxLKyXU5?=
 =?iso-8859-1?Q?GWWZqu/f89LHRghNGQnf/Nru5m7g7i0ZugSmQojXfCyXK25bZwD6U+CSZV?=
 =?iso-8859-1?Q?Qw9ZiyzUzM3UiLQjMc5IijNoiy/FuoefwmbGCbyvsi5byUFpj6whp3sF38?=
 =?iso-8859-1?Q?dFhkFsZxd45LKZvEQo+sg1CZ6BJ8LAbHlcUU5Gydar1ImUBw0CrZlDzT2Q?=
 =?iso-8859-1?Q?ptrPsTBu9FVoEEdzu5oeEnHqhYR7TDUmsWD5VIBdTiXLBtT0P93RD0/J5I?=
 =?iso-8859-1?Q?GJuSSIyCBW+S6OAO2brMjgk1RWlx7wZHEmhYk0Ns0sfrjx5RJdaLBZGYvn?=
 =?iso-8859-1?Q?NIx0wZopdYjDIKlQZJz1niE9tYTeFsxX5z0I7JfoXzcZt7oi9jpw/QrYq2?=
 =?iso-8859-1?Q?RQIi38f1znRlRPO1NyCW6w7in3uFXWhCsx2wJuk9q9PxymTM1raYjFgXUh?=
 =?iso-8859-1?Q?C2XqcRiLch6uX0oVfQ3Okno0pXaBo9i/f1fa5xhJhxyvL5CBkZpsrGBxwy?=
 =?iso-8859-1?Q?RIcAXyF62OiPdUqWxS8opvSjAX3kXfSTleapld6Xhfk0wH9cmANCbQJZMu?=
 =?iso-8859-1?Q?iEiNg74hecSdfvll5rKsOHdaTF2g8dR17dr7ghkEXUxvg+liBiwlott5bv?=
 =?iso-8859-1?Q?gjHrHKzYPCz2oTIz/mca1IS01wLgkwLmRn/IgCZjHzD0rb68oDV4hUeNVB?=
 =?iso-8859-1?Q?chJYykBVdUXMoz4hPBFJaZObDWtp7bvXaXP80akBfctGzsYrPpi/tgjmGP?=
 =?iso-8859-1?Q?V7xZDLhNi6hqt1cNJji8y1DDeHX/R5AyW3sf07CsyNTDii+BJWww3wPvlB?=
 =?iso-8859-1?Q?tM6o2ORIYSamWemG7lFFR6MoghMrn9xtlDIZ2YiY0XesWX26GPhW9Vmmr3?=
 =?iso-8859-1?Q?WLLsbVB9gRH4KMgEXtNb4Z8excqPCQBzwE7D1Dhy2qsXtUunx1ZcpkFWrE?=
 =?iso-8859-1?Q?ux1oRE33UlaFqUKT7bkJ1VTN7oMv2RebMdoN+OLMblszDybTEXlCvd9J9m?=
 =?iso-8859-1?Q?OkVp8gNQwFRGVJ8SifgSBroTkmCQZ8lb9+KQmtZzvBbWiun6UiVLkj27DL?=
 =?iso-8859-1?Q?TSw8UPTXiecJZIqkcBhCBl+LFVuaNzTm+QfU9t1BXFQmqZHHP1YiRFSssz?=
 =?iso-8859-1?Q?5E6T2WRQHjD/cwZA7rHYZx8ZFFk21rKkjVLJN775kbUr6oOkq57YewLpxl?=
 =?iso-8859-1?Q?JiTvigEJvPUNBHSZWrSBlPjs8T+akiJiY1mlif1Z29o1002yI3fxkkQ9i0?=
 =?iso-8859-1?Q?xXfwNUdj2A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: md4482IgvrT9uvDm8TJI+lR/obMN8dU2SpbMkI/zNfl6X4ZIiDheopKJNhWpFIuiknMwM9o+GeSpjCKWdNjVP7f97hqGKdfWY+pAblb0QpaglkFrzJqNIX/cPiAzaMoart/lmYwfkw4Ab+as4K8Twz9oG6B1IxLcuvuRwA0wv01tdek2GObxBgxqCUdlScSaEMiHVsLhyv2WWhj+Wqigvyo+BVeKa5I+Ksf63CIcJHG7p9xSP+G9ILJeH/gkfyDX/FLkGV0yWnWBweeDfTGtrKfAPIXyoOC3CaNSIuNqbVl8ql3QM5JC/nKPlgkeLVQy+ZWqeV/rrTdfo8EXBaX8KQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50e73e0-de0b-4ed0-3f90-08df0711d382
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 03:42:05.3944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B02pgYVlXqqO+7C9s/9r6vL9335vq0uwSNgz1D7/ZR6gdy5kW/Nzcc5I3Yytn9677+8CewlC9VFq7P8Ov7k9Ba65OIfYWQ9CpWvbTLuUL6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8096
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


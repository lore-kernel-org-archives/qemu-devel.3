Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A17C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0s1H-0005Y5-GT; Sun, 30 Aug 2026 22:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0s1D-0005Vs-LX; Sun, 30 Aug 2026 22:45:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0s19-00028h-Vh; Sun, 30 Aug 2026 22:45:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0mQRCBrzO7+xcJC3u2ybaq0WSLmwZeUAEnGJgtoDeJtxc7Q0upYZgdVKkw5IZ/KmW1KaUom/kY+Bng5tkz4E8oOV2o2Z7Kcc5lPL6J/ZbV/IyKITQwVgfBlLYAhMGqmsPsQdq0cmFwWQVkvxsa6UYvkvURBSf0MSUfF08CnKG2FPxlNmr4EZKHDTkteK+LOeKIzMxTzGs5Jpvn2gecMqFuOB1sSvOKsCMCfg9R1yJA9hIBsQ/K3zz+vIJDwefEqTPrg+4TnaYBDGYzHxpOgjhJlh+g9lyHvtb5dNFKLlJMa81RHl+iXW37rdQBkmE8rMBx6fG36iNREu6OX2Lw8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNMnpAUg7a0Agr/RhC9ZUFFaNZNQxjvE2l9mwkzmbBg=;
 b=PhT9Fe/G9RNZexKd0vSoROxZzgSJJChOLbLUix2DJ2QPByS9n9DLHV2EXSa0aqeEGi0kUAkMJYCq7QtwWH88Hb85svpCUKK0VWW4TTcAm/ZL27jXgV+hkCtG0qLxZ4lrs2NZvHQ/aaLNl6GaFQ+DZnRyjPk66ud0bK1iaVfIit1VPOtMj1Eagmm4PJ0xN/HEUhslYJWiK1cbw5AS/GUSKWuAhrniUbYtGTJW+lVbHoeZ4mjK5TDFXzlGr9hAYV3Jes1/Et1/BdOIakP/TEnrKwOpMLaqBjreBQKXz4me5kPjFw2VcHlX5B1Fu/m0hvcyEg93moYIMyHTbFE9zusu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNMnpAUg7a0Agr/RhC9ZUFFaNZNQxjvE2l9mwkzmbBg=;
 b=q9zWe2ytvZjRD/ZCoWITm0GUi9X9Hk0JFWXcwIQKfP50IVMCtGRBPeIycPLZ82RSMCnt8sOHXcyDl22OiSizXWKur9+iT/SDwDumILNeD0JmU9KV3xpAE6crZwmjPxjOccomNTsPSyvD6q9GO+3IWeFbm3WoNvlzxmHVRgm+Wt6iGRdGltCbVdgck+AHEEb/Qb4T21XXS+SMh8nySZ3ybsebjzdC83zOjENUJhnQI91nON0ismM7RD0tAeOyDfJQp+h6NG6wJfMsEI3yuS7TlxXDfXb9uLvqciHS2lME7q8Jb8LGRa2gmBR5pLh0sZVwO4uZcv2sR0CWw7CCx2Ax0w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYSPR06MB6528.apcprd06.prod.outlook.com (2603:1096:400:47a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 02:44:57 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 02:44:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 4/4] tests/qtest/aspeed-acry-test: Add RSA ModExp tests
Thread-Topic: [PATCH v3 4/4] tests/qtest/aspeed-acry-test: Add RSA ModExp tests
Thread-Index: AQHdOPK1ncZ3vlgUcUSpxgSKACbbBg==
Date: Mon, 31 Aug 2026 02:44:57 +0000
Message-ID: <20260831024450.27178-5-jamin_lin@aspeedtech.com>
References: <20260831024450.27178-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260831024450.27178-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYSPR06MB6528:EE_
x-ms-office365-filtering-correlation-id: 5fe9943b-4874-4841-5767-08df0709d85f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|56012099006|3023799007|38070700021|6133799003|10067099003|921020;
x-microsoft-antispam-message-info: frmTVoEeQHtmgJEcQaUKtyspZ/rr509jxZ9EWnf2EfN0T10U+kC2iDSO34Tksz3LfwWPEKdcCwuCWcgUSuTpASp0Gi2loJyhHY0Xznce4bHrxIhCpr8a9/3D2qSDCWYBP4mlnSGTA3AEb7FydcXbVrrxhTpNujaAHSQDllpGnhNTXpdXQxav+abZymqQG3V/qPyhNrucqOoBBKRZ5QC/ZctJArv/qM1293IdNay/QUpruVvFAqAF5FcgAFesnzxCMd7G/lRvfzzshAyvg96uy3jviwfv98lb76Ar7GOXUyAHTl8L+/tURHrmKfBCKFkKRbWmlQJP+7r2HKRZgErOnNJBKXvnFP+D9xOb3RiEcZSsUbT3puSGV4aoTEmGxdmGJIfjhfjpwClq9EVx+Cs+s4IBUn3odGwl6Kp7Jz7Rqlq6bMudOKv6HW9O+ChlFS4JXA2GJ8qGoZw4hMVILSVEOIp0ijtcwDukl+RumMyTqC+eP/i4Yq4CTKxb/Db5fLR15QQLRRVQjqtp0ZELJfd3KvJSt3VNYrp7P6obvCcWD1CW9Z1BoRIFL3UsQPgcAsVFnPlDYcG+OroeKd2BE3zFnOZeAfDSocEAB7BA589b8UPGuU4JvyRk5kzDW3aODfQRFZR5bsaPLBj+2TYvmX4XCLMQN7w6+ySPqb82uH7TJ9+9ipftNqX0f2b2QNA1Sl3HIBsm6DpdPoJM8m+lPKaDQqNFuh3N/v77cUvrWnFSf0U4YhwQr4xZLvQReI1L5KVw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xCrbLUPtPx1bz9V0k8f0m85LQiY8VN6mSZDiiWyO2OrAfuqIzB/EN+Zxwk?=
 =?iso-8859-1?Q?NzKc+TYzOsLi2WPNAL38YwxRTbhOYB0MCIZhgi+oCNHhsbvD9dJq1xZciF?=
 =?iso-8859-1?Q?ttHCRFUBkEgsTweHx6/tlctgyhpw5zMXQMmWgDiYQzzZBEVizFLYPPK0i/?=
 =?iso-8859-1?Q?2HB6PXJVPsBgd0idXowGivndRjlYnbQbG7ggealfYIgKmU3sf3EY/5lp5l?=
 =?iso-8859-1?Q?nwzgCpapiI6wp0jqKKffjjVOIfEBQvD1zcMVi3e6kWC+NWOkVKZGrYcL0g?=
 =?iso-8859-1?Q?faINQjMorsuRWQe3KLB1giZI6/bAgvyT3Cqts/1V3tgC+F0RWFWdEnUl5+?=
 =?iso-8859-1?Q?g5CZxZkJDcbPTFiC5PXqgW6yWentMHzOP0p8/P+EeRElSSVjk9/+flX64d?=
 =?iso-8859-1?Q?frWbFKDG0YH266se11th3AtyPyALPYd8PqF+7uvzuD6lZWc3EnlRol4JYj?=
 =?iso-8859-1?Q?lq65eDpKj+uml9ExevCv9XIPUlJSziSVlaI3vrEwgtIufBo+m12sr2sPkM?=
 =?iso-8859-1?Q?mlEc3rAUZpEkx4KnD3qo+on9FqyPTQAccZVfupYd4n/WIM2KnTnGM2JG69?=
 =?iso-8859-1?Q?jFY2YSrbS1NX/YYNlQSVw87BBlJ03yeKF2ZJuDai/ycGz3X6JTBQfhqPq5?=
 =?iso-8859-1?Q?aIzVaY3JNzMEsRuOOswXvLjP1y/nZeb/Q0UnVdMUIh35+ESiLOIi0T+dtT?=
 =?iso-8859-1?Q?IUhViaq6xcG02+oEaAchC/ZptWgK5sw1xIL5WRZgsI67SAi9vICaX/kUIS?=
 =?iso-8859-1?Q?37smavUUAj68sLXqKfhsEdI/ht0RLfwhxJAV+iAOYzbsxJduuJ+Sg3/zua?=
 =?iso-8859-1?Q?2gh1hmlSrJbLRAbowf8U3OBYjeyy/pzHrK62wLzgucOyg3p3fwuymwH0w1?=
 =?iso-8859-1?Q?iMtAW6bl/dI3EM9LUnBsooGexgXSZ4kWmx65aIvRE+MfWWC+jP+5Wfgofe?=
 =?iso-8859-1?Q?NC7jDBAUFn3b8D+rodoJ/4mbRTrKTro2S12MhLGOu9hkXuVUMvImY970rY?=
 =?iso-8859-1?Q?IyxCvBhOCHSkLcXwybjf0UvgHXSTCG2wQjdAf9uHw3qTicWpi19Wij96mE?=
 =?iso-8859-1?Q?9u7rhAoDP96WODNpi724dcH2mMVkHO/ghxwQvb5FjtKDt/yB7Ddlm10pOt?=
 =?iso-8859-1?Q?wzZBvFXseh7ruUv2eoCtSgp7EUtGbcgLwiY2HNRA77nmIyLmH2GWYH9uWc?=
 =?iso-8859-1?Q?MyZJCOsO7pxpkXH99uFvwnU+OUGZ7GxVsxzH5Gr3A1rUqbjAF67EUkM/2Q?=
 =?iso-8859-1?Q?JGSEUp7Owp1vgc9aZRohugSTNtQ84LEUMJBbON8NJOtgIDBLTei/m6eKNI?=
 =?iso-8859-1?Q?Yj6YEc7HKNlP//SWFfWO1nWYMkPYNbv0jtFwCmguIYNieIdWAybM6kiLCI?=
 =?iso-8859-1?Q?IXY6Qx7h5I0fj4fHmesV+kD6ESvaiG8HNg1jdj8iJykt+b4XLl0qexLysk?=
 =?iso-8859-1?Q?GriRljepDm/NPLmeegwgr0SG+hVlZJaXK0fG9MX9Q/pPu7uzsgM+H0DUTD?=
 =?iso-8859-1?Q?nd1lubYuxpmBebAm2ZTwTY0/CZB1ZzxvLzcNvLQdhdex0CflKzOinbgWox?=
 =?iso-8859-1?Q?kPjVUmlrGwSjwRcvJQrcAm/sBYws8OUuDLTJBR3HGYzbNn4KlyuZDEvIF9?=
 =?iso-8859-1?Q?chmW7pTar/DeBQiNFnFJ/6KCS1ALIbiBW5Hr96xPdmG15qHCE5AmxnMQMX?=
 =?iso-8859-1?Q?Ytdr8peg74O2ns1ELFIzOSB9c2ZNVoOnw4ZJbmjyCHUNqVzybl6LDPTPbd?=
 =?iso-8859-1?Q?Egrr7ntyJKTW9nbDUREKxlKcNJgRbZpO71dbFn3EvPfrVJZVh87lKXFBSb?=
 =?iso-8859-1?Q?oEOfMUihXA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vBTMZ3x50f0fGDg3i1E2HYE112t+Ww1CA4+LXXbJq5jHwBOpWFP3KQVimmBWCpWJEZx48G5+npruENWdQYLH/g/DRKkBeWYo0ubSefbdqzeYH+Gmt/8x2sN8Ksh6usn+yG5Waukx+BbFgYbYqynBu0zk7LUtosbKFpSx6RGjQd+c+YSrVyWJH+zwJN5MenOezk/+QP0Z8mntpdhV18r7KMRSctg2OGjCfIN+UoU/Oo/dP091v5QOyLUuxlNFzAFx28cxJ/+RGFTdcBaFPcipgmD/Ir0DL9O9PfjFApmDXLdSH7sFPzQENMFF2oDYIhxQDQP1O/yJRklREeOrQ+7jzA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe9943b-4874-4841-5767-08df0709d85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 02:44:57.5307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkmHkNn7mb2i7vIb2pu63xaLSyhz6WC8yxTKeFBTH9QosJFswV8VY4GFjrpUXUqhQqarXQvvunuM09k5ZCrA/Exmxd2xr97S5QeEs2f4rgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6528
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

Add qtest cases exercising the AST2600 ACRY RSA ModExp engine end to=0A=
end. Each case lays out the exponent, modulus and message in the=0A=
scattered SRAM byte layout the engine expects, triggers the=0A=
engine, checks that both completion bits (RSA_ENG_DONE and=0A=
RSA_DMA_DONE) are asserted together in the status register, reads the=0A=
result back from the result SRAM, and checks the status bits clear=0A=
afterwards.=0A=
=0A=
Comparing the result against a known-answer ciphertext=0A=
also validates the SRAM byte mapping end to end.=0A=
=0A=
The cases cover raw (unpadded) public-exponent RSA, c =3D m^e mod n -=0A=
exactly what the "rsa" akcipher transform backed by the ACRY FW=0A=
performs, since PKCS1 padding is applied by a separate template=0A=
layered on top in Linux, not by the ACRY hardware. QEMU's akcipher=0A=
backend only implements raw RSA via libgcrypt, so the tests skip=0A=
rather than fail when the build lacks it.=0A=
=0A=
The 2048-bit and 4096-bit vectors are rsa_tv_template[2] and [3] from the=
=0A=
Linux kernel crypto self-test suite (crypto/testmgr.h, v6.18).=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-acry-test.c | 396 +++++++++++++++++++++++++++++++++=0A=
 tests/qtest/meson.build        |   5 +-=0A=
 2 files changed, 400 insertions(+), 1 deletion(-)=0A=
 create mode 100644 tests/qtest/aspeed-acry-test.c=0A=
=0A=
diff --git a/tests/qtest/aspeed-acry-test.c b/tests/qtest/aspeed-acry-test.=
c=0A=
new file mode 100644=0A=
index 0000000000..9de4c7a103=0A=
--- /dev/null=0A=
+++ b/tests/qtest/aspeed-acry-test.c=0A=
@@ -0,0 +1,396 @@=0A=
+/*=0A=
+ * QTest testcase for the ASPEED ACRY Engine=0A=
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
+#define ACRY_TRIGGER                0x000=0A=
+#define  ACRY_TRIGGER_RSA_DMA_DATA  BIT(1)=0A=
+#define  ACRY_TRIGGER_RSA_START     BIT(0)=0A=
+#define ACRY_DMA_CMD                0x048=0A=
+#define  ACRY_DMA_CMD_DMEM_AHB      BIT(8)=0A=
+#define  ACRY_DMA_CMD_SRAM_MODE_RSA (0x3 << 4)=0A=
+#define ACRY_DMA_SRC                0x04C=0A=
+#define ACRY_DMA_LEN                0x050=0A=
+#define ACRY_RSA_KEY_LEN            0x058=0A=
+#define ACRY_INT_MASK               0x3F8=0A=
+#define  ACRY_INT_MASK_RSA_DMA_MASK BIT(2)=0A=
+#define  ACRY_INT_MASK_RSA_ENG_MASK BIT(1)=0A=
+#define ACRY_STATUS                 0x3FC=0A=
+#define  ACRY_STATUS_RSA_DMA_DONE   BIT(2)=0A=
+#define  ACRY_STATUS_RSA_ENG_DONE   BIT(1)=0A=
+#define  ACRY_STATUS_RSA_DONE       (ACRY_STATUS_RSA_ENG_DONE | \=0A=
+                                     ACRY_STATUS_RSA_DMA_DONE)=0A=
+=0A=
+#define ACRY_DATA_MAX_LEN 0x800=0A=
+#define ACRY_SRAM_SIZE    (3 * ACRY_DATA_MAX_LEN)=0A=
+#define ACRY_MAX_BITS     4096=0A=
+#define ACRY_MAX_BYTES    (ACRY_MAX_BITS / 8)=0A=
+=0A=
+/* Dwords into each 12-dword block where each operand's region starts. */=
=0A=
+#define ACRY_EXP_OFFSET   0=0A=
+#define ACRY_MOD_OFFSET   4=0A=
+#define ACRY_DATA_OFFSET  8=0A=
+=0A=
+/*=0A=
+ * Raw (unpadded) RSA known-answer vectors: c =3D m^e mod n with=0A=
+ * e =3D 0x10001 (65537) - exactly what the "rsa" akcipher transform backe=
d by=0A=
+ * the ACRY FW computes. PKCS1 padding is a separate "pkcs1pad(rsa)" templ=
ate=0A=
+ * layered on top in Linux, not done by the ACRY hardware.=0A=
+ *=0A=
+ * rsa2048_* and rsa4096_* are from the Linux kernel crypto/testmgr.h (v6.=
18),=0A=
+ * rsa_tv_template[2] and [3]. Grep that file's own comment to find them:=
=0A=
+ *=0A=
+ *   RSA test vectors. Borrowed from openSSL.=0A=
+ *=0A=
+ *   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/crypto/testmgr.h?h=3Dv6.18=0A=
+ *=0A=
+ * There the modulus n is DER-encoded in the .key field (not a raw field),=
 the=0A=
+ * ciphertext is .c, and every entry reuses the same 8-byte .m message.=0A=
+ */=0A=
+/* rsa_tv_template[].m, shared by every entry */=0A=
+static const uint8_t rsa_m[8] =3D {=0A=
+    0x54, 0x85, 0x9B, 0x34, 0x2C, 0x49, 0xEA, 0x2A,=0A=
+};=0A=
+/* public exponent e =3D 65537, DER-encoded in every .key */=0A=
+static const uint8_t rsa_e[3] =3D { 0x01, 0x00, 0x01 };=0A=
+=0A=
+/* rsa_tv_template[2].key, modulus n */=0A=
+static const uint8_t rsa2048_n[256] =3D {=0A=
+    0xDB, 0x10, 0x1A, 0xC2, 0xA3, 0xF1, 0xDC, 0xFF, 0x13, 0x6B, 0xED, 0x44=
,=0A=
+    0xDF, 0xF0, 0x02, 0x6D, 0x13, 0xC7, 0x88, 0xDA, 0x70, 0x6B, 0x54, 0xF1=
,=0A=
+    0xE8, 0x27, 0xDC, 0xC3, 0x0F, 0x99, 0x6A, 0xFA, 0xC6, 0x67, 0xFF, 0x1D=
,=0A=
+    0x1E, 0x3C, 0x1D, 0xC1, 0xB5, 0x5F, 0x6C, 0xC0, 0xB2, 0x07, 0x3A, 0x6D=
,=0A=
+    0x41, 0xE4, 0x25, 0x99, 0xAC, 0xFC, 0xD2, 0x0F, 0x02, 0xD3, 0xD1, 0x54=
,=0A=
+    0x06, 0x1A, 0x51, 0x77, 0xBD, 0xB6, 0xBF, 0xEA, 0xA7, 0x5C, 0x06, 0xA9=
,=0A=
+    0x5D, 0x69, 0x84, 0x45, 0xD7, 0xF5, 0x05, 0xBA, 0x47, 0xF0, 0x1B, 0xD7=
,=0A=
+    0x2B, 0x24, 0xEC, 0xCB, 0x9B, 0x1B, 0x10, 0x8D, 0x81, 0xA0, 0xBE, 0xB1=
,=0A=
+    0x8C, 0x33, 0xE4, 0x36, 0xB8, 0x43, 0xEB, 0x19, 0x2A, 0x81, 0x8D, 0xDE=
,=0A=
+    0x81, 0x0A, 0x99, 0x48, 0xB6, 0xF6, 0xBC, 0xCD, 0x49, 0x34, 0x3A, 0x8F=
,=0A=
+    0x26, 0x94, 0xE3, 0x28, 0x82, 0x1A, 0x7C, 0x8F, 0x59, 0x9F, 0x45, 0xE8=
,=0A=
+    0x5D, 0x1A, 0x45, 0x76, 0x04, 0x56, 0x05, 0xA1, 0xD0, 0x1B, 0x8C, 0x77=
,=0A=
+    0x6D, 0xAF, 0x53, 0xFA, 0x71, 0xE2, 0x67, 0xE0, 0x9A, 0xFE, 0x03, 0xA9=
,=0A=
+    0x85, 0xD2, 0xC9, 0xAA, 0xBA, 0x2A, 0xBC, 0xF4, 0xA0, 0x08, 0xF5, 0x13=
,=0A=
+    0x98, 0x13, 0x5D, 0xF0, 0xD9, 0x33, 0x34, 0x2A, 0x61, 0xC3, 0x89, 0x55=
,=0A=
+    0xF0, 0xAE, 0x1A, 0x9C, 0x22, 0xEE, 0x19, 0x05, 0x8D, 0x32, 0xFE, 0xEC=
,=0A=
+    0x9C, 0x84, 0xBA, 0xB7, 0xF9, 0x6C, 0x3A, 0x4F, 0x07, 0xFC, 0x45, 0xEB=
,=0A=
+    0x12, 0xE5, 0x7B, 0xFD, 0x55, 0xE6, 0x29, 0x69, 0xD1, 0xC2, 0xE8, 0xB9=
,=0A=
+    0x78, 0x59, 0xF6, 0x79, 0x10, 0xC6, 0x4E, 0xEB, 0x6A, 0x5E, 0xB9, 0x9A=
,=0A=
+    0xC7, 0xC4, 0x5B, 0x63, 0xDA, 0xA3, 0x3F, 0x5E, 0x92, 0x7A, 0x81, 0x5E=
,=0A=
+    0xD6, 0xB0, 0xE2, 0x62, 0x8F, 0x74, 0x26, 0xC2, 0x0C, 0xD3, 0x9A, 0x17=
,=0A=
+    0x47, 0xE6, 0x8E, 0xAB,=0A=
+};=0A=
+/* rsa_tv_template[2].c */=0A=
+static const uint8_t rsa2048_c[256] =3D {=0A=
+    0xB2, 0x97, 0x76, 0xB4, 0xAE, 0x3E, 0x38, 0x3C, 0x7E, 0x64, 0x1F, 0xCC=
,=0A=
+    0xA2, 0x7F, 0xF6, 0xBE, 0xCF, 0x49, 0xBC, 0x48, 0xD3, 0x6C, 0x8F, 0x0A=
,=0A=
+    0x0E, 0xC1, 0x73, 0xBD, 0x7B, 0x55, 0x79, 0x36, 0x0E, 0xA1, 0x87, 0x88=
,=0A=
+    0xB9, 0x2C, 0x90, 0xA6, 0x53, 0x5E, 0xE9, 0xEF, 0xC4, 0xE2, 0x4D, 0xDD=
,=0A=
+    0xF7, 0xA6, 0x69, 0x82, 0x3F, 0x56, 0xA4, 0x7B, 0xFB, 0x62, 0xE0, 0xAE=
,=0A=
+    0xB8, 0xD3, 0x04, 0xB3, 0xAC, 0x5A, 0x15, 0x2A, 0xE3, 0x19, 0x9B, 0x03=
,=0A=
+    0x9A, 0x0B, 0x41, 0xDA, 0x64, 0xEC, 0x0A, 0x69, 0xFC, 0xF2, 0x10, 0x92=
,=0A=
+    0xF3, 0xC1, 0xBF, 0x84, 0x7F, 0xFD, 0x2C, 0xAE, 0xC8, 0xB5, 0xF6, 0x41=
,=0A=
+    0x70, 0xC5, 0x47, 0x03, 0x8A, 0xF8, 0xFF, 0x6F, 0x3F, 0xD2, 0x6F, 0x09=
,=0A=
+    0xB4, 0x22, 0xF3, 0x30, 0xBE, 0xA9, 0x85, 0xCB, 0x9C, 0x8D, 0xF9, 0x8F=
,=0A=
+    0xEB, 0x32, 0x91, 0xA2, 0x25, 0x84, 0x8F, 0xF5, 0xDC, 0xC7, 0x06, 0x9C=
,=0A=
+    0x2D, 0xE5, 0x11, 0x2C, 0x09, 0x09, 0x87, 0x09, 0xA9, 0xF6, 0x33, 0x73=
,=0A=
+    0x90, 0xF1, 0x60, 0xF2, 0x65, 0xDD, 0x30, 0xA5, 0x66, 0xCE, 0x62, 0x7B=
,=0A=
+    0xD0, 0xF8, 0x2D, 0x3D, 0x19, 0x82, 0x77, 0xE3, 0x0A, 0x5F, 0x75, 0x2F=
,=0A=
+    0x8E, 0xB1, 0xE5, 0xE8, 0x91, 0x35, 0x1B, 0x3B, 0x33, 0xB7, 0x66, 0x92=
,=0A=
+    0xD1, 0xF2, 0x8E, 0x6F, 0xE5, 0x75, 0x0C, 0xAD, 0x36, 0xFB, 0x4E, 0xD0=
,=0A=
+    0x66, 0x61, 0xBD, 0x49, 0xFE, 0xF4, 0x1A, 0xA2, 0x2B, 0x49, 0xFE, 0x03=
,=0A=
+    0x4C, 0x74, 0x47, 0x8D, 0x9A, 0x66, 0xB2, 0x49, 0x46, 0x4D, 0x77, 0xEA=
,=0A=
+    0x33, 0x4D, 0x6B, 0x3C, 0xB4, 0x49, 0x4A, 0xC6, 0x7D, 0x3D, 0xB5, 0xB9=
,=0A=
+    0x56, 0x41, 0x15, 0x67, 0x0F, 0x94, 0x3C, 0x93, 0x65, 0x27, 0xE0, 0x21=
,=0A=
+    0x5D, 0x59, 0xC3, 0x62, 0xD5, 0xA6, 0xDA, 0x38, 0x26, 0x22, 0x5E, 0x34=
,=0A=
+    0x1C, 0x94, 0xAF, 0x98,=0A=
+};=0A=
+=0A=
+/* rsa_tv_template[3].key, modulus n */=0A=
+static const uint8_t rsa4096_n[512] =3D {=0A=
+    0xC3, 0x8B, 0x55, 0x7B, 0x73, 0x4D, 0xFF, 0xE9, 0x9B, 0xC6, 0xDC, 0x67=
,=0A=
+    0x3C, 0xB4, 0x8E, 0xA0, 0x86, 0xED, 0xF2, 0xB9, 0x50, 0x5C, 0x54, 0x5C=
,=0A=
+    0xBA, 0xE4, 0xA1, 0xB2, 0xA7, 0xAE, 0x2F, 0x1B, 0x7D, 0xF1, 0xFB, 0xAC=
,=0A=
+    0x79, 0xC5, 0xDF, 0x1A, 0x00, 0xC9, 0xB2, 0xC1, 0x61, 0x25, 0x33, 0xE6=
,=0A=
+    0x9C, 0xE9, 0xCF, 0xD6, 0x27, 0xC4, 0x4E, 0x44, 0x30, 0x44, 0x5E, 0x08=
,=0A=
+    0xA1, 0x87, 0x52, 0xCC, 0x6B, 0x97, 0x70, 0x8C, 0xBC, 0xA5, 0x06, 0x31=
,=0A=
+    0x0C, 0xD4, 0x2F, 0xD5, 0x7D, 0x26, 0x24, 0xA2, 0xE2, 0xAC, 0x78, 0xF4=
,=0A=
+    0x53, 0x14, 0xCE, 0xF7, 0x19, 0x2E, 0xD7, 0xF7, 0xE6, 0x0C, 0xB9, 0x56=
,=0A=
+    0x7F, 0x0B, 0xF1, 0xB1, 0xE2, 0x43, 0x70, 0xBD, 0x86, 0x1D, 0xA1, 0xCC=
,=0A=
+    0x2B, 0x19, 0x08, 0x76, 0xEF, 0x91, 0xAC, 0xBF, 0x20, 0x24, 0x0D, 0x38=
,=0A=
+    0xC0, 0x89, 0xB8, 0x9A, 0x70, 0xB3, 0x64, 0xD9, 0x8F, 0x80, 0x41, 0x10=
,=0A=
+    0x5B, 0x9F, 0xB1, 0xCB, 0x76, 0x43, 0x00, 0x21, 0x25, 0x36, 0xD4, 0x19=
,=0A=
+    0xFC, 0x55, 0x95, 0x10, 0xE4, 0x26, 0x74, 0x98, 0x2C, 0xD9, 0xBD, 0x0B=
,=0A=
+    0x2B, 0x04, 0xC2, 0xAC, 0x82, 0x38, 0xB4, 0xDD, 0x4C, 0x04, 0x7E, 0x51=
,=0A=
+    0x36, 0x40, 0x1E, 0x0B, 0xC4, 0x7C, 0x25, 0xDD, 0x4B, 0xB2, 0xE7, 0x20=
,=0A=
+    0x0A, 0x57, 0xF9, 0xB4, 0x94, 0xC3, 0x08, 0x33, 0x22, 0x6F, 0x8B, 0x48=
,=0A=
+    0xDB, 0x03, 0x68, 0x5A, 0x5B, 0xBA, 0xAE, 0xF3, 0xAD, 0xCF, 0xC3, 0x6D=
,=0A=
+    0xBA, 0xF1, 0x28, 0x67, 0x7E, 0x6C, 0x79, 0x07, 0xDE, 0xFC, 0xED, 0xE7=
,=0A=
+    0x96, 0xE3, 0x6C, 0xE0, 0x2C, 0x87, 0xF8, 0x02, 0x01, 0x28, 0x38, 0x43=
,=0A=
+    0x21, 0x53, 0x84, 0x69, 0x75, 0x78, 0x15, 0x7E, 0xEE, 0xD2, 0x1B, 0xB9=
,=0A=
+    0x23, 0x40, 0xA8, 0x86, 0x1E, 0x38, 0x83, 0xB2, 0x73, 0x1D, 0x53, 0xFB=
,=0A=
+    0x9E, 0x2A, 0x8A, 0xB2, 0x75, 0x35, 0x01, 0xC3, 0xC3, 0xC4, 0x94, 0xE8=
,=0A=
+    0x84, 0x86, 0x64, 0x81, 0xF4, 0x42, 0xAA, 0x3C, 0x0E, 0xD6, 0x4F, 0xBC=
,=0A=
+    0x0A, 0x09, 0x2D, 0xE7, 0x1B, 0xD4, 0x10, 0xA8, 0x54, 0xEA, 0x89, 0x84=
,=0A=
+    0x8A, 0xCB, 0xF7, 0x5A, 0x3C, 0xCA, 0x76, 0x08, 0x29, 0x62, 0xB4, 0x6A=
,=0A=
+    0x22, 0xDF, 0x14, 0x95, 0x71, 0xFD, 0xB6, 0x86, 0x39, 0xB8, 0x8B, 0xF8=
,=0A=
+    0x91, 0x7F, 0x38, 0xAA, 0x14, 0xCD, 0xE5, 0xF5, 0x1D, 0xC2, 0x6D, 0x53=
,=0A=
+    0x69, 0x52, 0x84, 0x7F, 0xA3, 0x1A, 0x5E, 0x26, 0x04, 0x83, 0x06, 0x73=
,=0A=
+    0x52, 0x56, 0xCF, 0x76, 0x26, 0xC9, 0xDD, 0x75, 0xD7, 0xFC, 0xF4, 0x69=
,=0A=
+    0xD8, 0x7B, 0x55, 0xB7, 0x68, 0x13, 0x53, 0xB9, 0xE7, 0x89, 0xC3, 0xE8=
,=0A=
+    0xD6, 0x6E, 0xA7, 0x6D, 0xEA, 0x81, 0xFD, 0xC4, 0xB7, 0x05, 0x5A, 0xB7=
,=0A=
+    0x41, 0x0A, 0x23, 0x8E, 0x03, 0x8A, 0x1C, 0xAE, 0xD3, 0x1E, 0xCE, 0xE3=
,=0A=
+    0x5E, 0xFC, 0x19, 0x4A, 0xEE, 0x61, 0x9B, 0x8E, 0xE5, 0xE5, 0xDD, 0x85=
,=0A=
+    0xF9, 0x41, 0xEC, 0x14, 0x53, 0x92, 0xF7, 0xDD, 0x06, 0x85, 0x02, 0x91=
,=0A=
+    0xE3, 0xEB, 0x6C, 0x43, 0x03, 0xB1, 0x36, 0x7B, 0x89, 0x5A, 0xA8, 0xEB=
,=0A=
+    0xFC, 0xD5, 0xA8, 0x35, 0xDC, 0x81, 0xD9, 0x5C, 0xBD, 0xCA, 0xDC, 0x9B=
,=0A=
+    0x98, 0x0B, 0x06, 0x5D, 0x0C, 0x5B, 0xEE, 0xF3, 0xD5, 0xCC, 0x57, 0xC9=
,=0A=
+    0x71, 0x2F, 0x90, 0x3B, 0x3C, 0xF0, 0x8E, 0x4E, 0x35, 0x48, 0xAE, 0x63=
,=0A=
+    0x74, 0xA9, 0xFC, 0x72, 0x75, 0x8E, 0x34, 0xA8, 0xF2, 0x1F, 0xEA, 0xDF=
,=0A=
+    0x3A, 0x37, 0x2D, 0xE5, 0x39, 0x39, 0xF8, 0x57, 0x58, 0x3C, 0x04, 0xFE=
,=0A=
+    0x87, 0x06, 0x98, 0xBC, 0x7B, 0xD3, 0x21, 0x36, 0x60, 0x25, 0x54, 0xA7=
,=0A=
+    0x3D, 0xFA, 0x91, 0xCC, 0xA8, 0x0B, 0x92, 0x8E, 0xB4, 0xF7, 0x06, 0xFF=
,=0A=
+    0x1E, 0x95, 0xCB, 0x07, 0x76, 0x97, 0x3B, 0x9D,=0A=
+};=0A=
+/* rsa_tv_template[3].c */=0A=
+static const uint8_t rsa4096_c[512] =3D {=0A=
+    0x5C, 0xCE, 0x9C, 0xD7, 0x9A, 0x9E, 0xA1, 0xFE, 0x7A, 0x82, 0x3C, 0x68=
,=0A=
+    0x27, 0x98, 0xE3, 0x5D, 0xD5, 0xD7, 0x07, 0x29, 0xF5, 0xFB, 0xC3, 0x1A=
,=0A=
+    0x7F, 0x63, 0x1E, 0x62, 0x31, 0x3B, 0x19, 0x87, 0x79, 0x4F, 0xEC, 0x7B=
,=0A=
+    0xF3, 0xCB, 0xEA, 0x9B, 0x95, 0x52, 0x3A, 0x40, 0xE5, 0x87, 0x7B, 0x72=
,=0A=
+    0xD1, 0x72, 0xC9, 0xFB, 0x54, 0x63, 0xD8, 0xC9, 0xD7, 0x2C, 0xFC, 0x7B=
,=0A=
+    0xC3, 0x14, 0x1E, 0xBC, 0x18, 0xB4, 0x34, 0xA1, 0xBF, 0x14, 0xB1, 0x37=
,=0A=
+    0x31, 0x6E, 0xF0, 0x1B, 0x35, 0x19, 0x54, 0x07, 0xF7, 0x99, 0xEC, 0x3E=
,=0A=
+    0x63, 0xE2, 0xCD, 0x61, 0x28, 0x65, 0xC3, 0xCD, 0xB1, 0x38, 0x36, 0xA5=
,=0A=
+    0xB2, 0xD7, 0xB0, 0xDC, 0x1F, 0xF5, 0xEF, 0x19, 0xC7, 0x53, 0x32, 0x2D=
,=0A=
+    0x1C, 0x26, 0xDA, 0xE4, 0x0D, 0xD6, 0x90, 0x7E, 0x28, 0xD8, 0xDC, 0xE4=
,=0A=
+    0x61, 0x05, 0xD2, 0x25, 0x90, 0x01, 0xD3, 0x96, 0x6D, 0xA6, 0xCF, 0x58=
,=0A=
+    0x20, 0xBB, 0x03, 0xF4, 0x01, 0xBC, 0x79, 0xB9, 0x18, 0xD8, 0xB8, 0xBA=
,=0A=
+    0xBD, 0x93, 0xFC, 0xF2, 0x62, 0x5D, 0x8C, 0x66, 0x1E, 0x0E, 0x84, 0x59=
,=0A=
+    0x93, 0xDD, 0xE2, 0x93, 0xA2, 0x62, 0x7D, 0x08, 0x82, 0x7A, 0xDD, 0xFC=
,=0A=
+    0xB8, 0xBC, 0xC5, 0x4F, 0x9C, 0x4E, 0xBF, 0xB4, 0xFC, 0xF4, 0xC5, 0x01=
,=0A=
+    0xE8, 0x00, 0x70, 0x4D, 0x28, 0x26, 0xCC, 0x2E, 0xFE, 0x0E, 0x58, 0x41=
,=0A=
+    0x8B, 0xEC, 0xAF, 0x7C, 0x4B, 0x54, 0xD0, 0xA0, 0x64, 0xF9, 0x32, 0xF4=
,=0A=
+    0x2E, 0x47, 0x65, 0x0A, 0x67, 0x88, 0x39, 0x3A, 0xDB, 0xB2, 0xDB, 0x7B=
,=0A=
+    0xB5, 0xF6, 0x17, 0xA8, 0xD9, 0xC6, 0x5E, 0x28, 0x13, 0x82, 0x8A, 0x99=
,=0A=
+    0xDB, 0x60, 0x08, 0xA5, 0x23, 0x37, 0xFA, 0x88, 0x90, 0x31, 0xC8, 0x9D=
,=0A=
+    0x8F, 0xEC, 0xFB, 0x85, 0x9F, 0xB1, 0xCE, 0xA6, 0x24, 0x50, 0x46, 0x44=
,=0A=
+    0x47, 0xCB, 0x65, 0xD1, 0xDF, 0xC0, 0xB1, 0x6C, 0x90, 0x1F, 0x99, 0x8E=
,=0A=
+    0x4D, 0xD5, 0x9E, 0x31, 0x07, 0x66, 0x87, 0xDF, 0x01, 0xAA, 0x56, 0x3C=
,=0A=
+    0x71, 0xE0, 0x2B, 0x6F, 0x67, 0x3B, 0x23, 0xED, 0xC2, 0xBD, 0x03, 0x30=
,=0A=
+    0x79, 0x76, 0x02, 0x10, 0x10, 0x98, 0x85, 0x8A, 0xFF, 0xFD, 0x0B, 0xDA=
,=0A=
+    0xA5, 0xD9, 0x32, 0x48, 0x02, 0xA0, 0x0B, 0xB9, 0x2A, 0x8A, 0x18, 0xCA=
,=0A=
+    0xC6, 0x8F, 0x3F, 0xBB, 0x16, 0xB2, 0xAA, 0x98, 0x27, 0xE3, 0x60, 0x43=
,=0A=
+    0xED, 0x15, 0x70, 0xD4, 0x57, 0x15, 0xFE, 0x19, 0xD4, 0x9B, 0x13, 0x78=
,=0A=
+    0x8A, 0xF7, 0x21, 0xF1, 0xA2, 0xA2, 0x2D, 0xB3, 0x09, 0xCF, 0x44, 0x91=
,=0A=
+    0x6E, 0x08, 0x3A, 0x30, 0x81, 0x3E, 0x90, 0x93, 0x8A, 0x67, 0x33, 0x00=
,=0A=
+    0x59, 0x54, 0x9A, 0x25, 0xD3, 0x49, 0x8E, 0x9F, 0xC1, 0x4B, 0xE5, 0x86=
,=0A=
+    0xF3, 0x50, 0x4C, 0xBC, 0xC5, 0xD3, 0xF5, 0x3A, 0x54, 0xE1, 0x36, 0x3F=
,=0A=
+    0xE2, 0x5A, 0xB4, 0x37, 0xC0, 0xEB, 0x70, 0x35, 0xEC, 0xF6, 0xB7, 0xE8=
,=0A=
+    0x44, 0x3B, 0x7B, 0xF3, 0xF1, 0xF2, 0x1E, 0xDB, 0x60, 0x7D, 0xD5, 0xBE=
,=0A=
+    0xF0, 0x71, 0x34, 0x90, 0x4C, 0xCB, 0xD4, 0x35, 0x51, 0xC7, 0xDD, 0xD8=
,=0A=
+    0xC9, 0x81, 0xF5, 0x5D, 0x57, 0x46, 0x2C, 0xB1, 0x7B, 0x9B, 0xAA, 0xCB=
,=0A=
+    0xD1, 0x22, 0x25, 0x49, 0x44, 0xA3, 0xD4, 0x6B, 0x29, 0x7B, 0xD8, 0xB2=
,=0A=
+    0x07, 0x93, 0xBF, 0x3D, 0x52, 0x49, 0x84, 0x79, 0xEF, 0xB8, 0xE5, 0xC4=
,=0A=
+    0xAD, 0xCA, 0xA8, 0xC6, 0xF6, 0xA6, 0x76, 0x70, 0x5B, 0x0B, 0xE5, 0x83=
,=0A=
+    0xC6, 0x0E, 0xEF, 0x55, 0xF2, 0xE7, 0xFF, 0x04, 0xEA, 0xE6, 0x13, 0xBE=
,=0A=
+    0x40, 0xE1, 0x40, 0x45, 0x48, 0x66, 0x75, 0x31, 0xAE, 0x35, 0x64, 0x91=
,=0A=
+    0x11, 0x6F, 0xDA, 0xEE, 0x26, 0x86, 0x45, 0x6F, 0x0B, 0xD5, 0x9F, 0x03=
,=0A=
+    0xB1, 0x65, 0x5B, 0xDB, 0xA4, 0xE4, 0xF9, 0x45,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Offset in the scattered buffer of byte 'op_byte' (0 =3D least significa=
nt)=0A=
+ * of the operand whose region starts 'region' dwords into each 12-dword=
=0A=
+ * block (0 =3D exp, 4 =3D mod, 8 =3D data). Reproduces the byte layout th=
e ACRY=0A=
+ * engine mandates, so the test lays out its DMA input and decodes the=0A=
+ * result the same way the hardware does.=0A=
+ */=0A=
+static int acry_operand_offset(int region, int op_byte)=0A=
+{=0A=
+    int byte_in_dword;=0A=
+    int op_dword;=0A=
+    int block;=0A=
+    int lane;=0A=
+=0A=
+    op_dword =3D op_byte / 4;=0A=
+    byte_in_dword =3D op_byte % 4;=0A=
+    block =3D op_dword / 4;=0A=
+    lane =3D op_dword % 4;=0A=
+=0A=
+    return (block * 12 + region + lane) * 4 + byte_in_dword;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Write a big-endian (most significant byte first) bignum of 'be_len' byt=
es=0A=
+ * into the scattered buffer region 'region' (exp, mod, or data), placing=
=0A=
+ * significance level k at acry_operand_offset(region, k).=0A=
+ */=0A=
+static void put_bignum_be_bytes(uint8_t *buf, int region,=0A=
+                                const uint8_t *be, int be_len)=0A=
+{=0A=
+    int be_index;=0A=
+    int offset;=0A=
+    int k;=0A=
+=0A=
+    /* be[0] (MSB) maps to the highest level; be_index walks up from 0. */=
=0A=
+    be_index =3D 0;=0A=
+    for (k =3D be_len - 1; k >=3D 0; k--) {=0A=
+        offset =3D acry_operand_offset(region, k);=0A=
+        buf[offset] =3D be[be_index++];=0A=
+    }=0A=
+}=0A=
+=0A=
+/* Inverse of put_bignum_be_bytes(): gather a big-endian bignum back out. =
*/=0A=
+static void get_bignum_be_bytes(const uint8_t *buf, int region,=0A=
+                                uint8_t *out_be, int be_len)=0A=
+{=0A=
+    int be_index;=0A=
+    int offset;=0A=
+    int k;=0A=
+=0A=
+    /* Inverse of put_bignum_be_bytes(): highest level -> out_be[0] (MSB).=
 */=0A=
+    be_index =3D 0;=0A=
+    for (k =3D be_len - 1; k >=3D 0; k--) {=0A=
+        offset =3D acry_operand_offset(region, k);=0A=
+        out_be[be_index++] =3D buf[offset];=0A=
+    }=0A=
+}=0A=
+=0A=
+typedef struct AspeedACRYModExp {=0A=
+    const char *name;=0A=
+    const uint8_t *n;=0A=
+    size_t n_len;=0A=
+    const uint8_t *e;=0A=
+    size_t e_len;=0A=
+    const uint8_t *m;=0A=
+    size_t m_len;=0A=
+    const uint8_t *c;=0A=
+    size_t c_len;=0A=
+} AspeedACRYModExp;=0A=
+=0A=
+static const AspeedACRYModExp acry_modexp_tests[] =3D {=0A=
+    {=0A=
+        .name =3D "modexp_rsa2048",=0A=
+        .n =3D rsa2048_n,=0A=
+        .n_len =3D sizeof(rsa2048_n),=0A=
+        .e =3D rsa_e,=0A=
+        .e_len =3D sizeof(rsa_e),=0A=
+        .m =3D rsa_m,=0A=
+        .m_len =3D sizeof(rsa_m),=0A=
+        .c =3D rsa2048_c,=0A=
+        .c_len =3D sizeof(rsa2048_c),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "modexp_rsa4096",=0A=
+        .n =3D rsa4096_n,=0A=
+        .n_len =3D sizeof(rsa4096_n),=0A=
+        .e =3D rsa_e,=0A=
+        .e_len =3D sizeof(rsa_e),=0A=
+        .m =3D rsa_m,=0A=
+        .m_len =3D sizeof(rsa_m),=0A=
+        .c =3D rsa4096_c,=0A=
+        .c_len =3D sizeof(rsa4096_c),=0A=
+    },=0A=
+};=0A=
+=0A=
+typedef struct AspeedACRYTest {=0A=
+    const char *machine;=0A=
+    uint64_t dram_addr;=0A=
+    uint64_t sram_addr;=0A=
+    uint64_t acry_addr;=0A=
+    int index;=0A=
+} AspeedACRYTest;=0A=
+=0A=
+static void test_modexp_rsa(const void *opaque)=0A=
+{=0A=
+    const AspeedACRYTest *c =3D opaque;=0A=
+    const AspeedACRYModExp *t =3D &acry_modexp_tests[c->index];=0A=
+    QCryptoAkCipherOptions opts =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_RSA,=0A=
+        .u.rsa.padding_alg =3D QCRYPTO_RSA_PADDING_ALGO_RAW,=0A=
+    };=0A=
+    uint8_t dram_buf[ACRY_SRAM_SIZE] =3D { 0 };=0A=
+    uint8_t sram_buf[ACRY_SRAM_SIZE] =3D { 0 };=0A=
+    uint8_t result[ACRY_MAX_BYTES] =3D { 0 };=0A=
+    QTestState *qts;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opts)) {=0A=
+        g_test_skip("raw RSA not supported by the crypto backend");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    qts =3D qtest_init(c->machine);=0A=
+=0A=
+    g_assert_cmpuint(t->c_len, <=3D, sizeof(result));=0A=
+=0A=
+    put_bignum_be_bytes(dram_buf, ACRY_EXP_OFFSET, t->e, t->e_len);=0A=
+    put_bignum_be_bytes(dram_buf, ACRY_MOD_OFFSET, t->n, t->n_len);=0A=
+    put_bignum_be_bytes(dram_buf, ACRY_DATA_OFFSET, t->m, t->m_len);=0A=
+=0A=
+    qtest_memwrite(qts, c->dram_addr, dram_buf, sizeof(dram_buf));=0A=
+=0A=
+    qtest_writel(qts, c->acry_addr + ACRY_DMA_CMD, ACRY_DMA_CMD_DMEM_AHB);=
=0A=
+    qtest_writel(qts, c->acry_addr + ACRY_DMA_SRC, c->dram_addr);=0A=
+    qtest_writel(qts, c->acry_addr + ACRY_RSA_KEY_LEN,=0A=
+                ((uint32_t)(t->e_len * 8) << 16) | (uint32_t)(t->n_len * 8=
));=0A=
+    qtest_writel(qts, c->acry_addr + ACRY_DMA_LEN, ACRY_SRAM_SIZE);=0A=
+    qtest_writel(qts, c->acry_addr + ACRY_INT_MASK,=0A=
+                ACRY_INT_MASK_RSA_ENG_MASK | ACRY_INT_MASK_RSA_DMA_MASK);=
=0A=
+    qtest_writel(qts, c->acry_addr + ACRY_DMA_CMD, ACRY_DMA_CMD_SRAM_MODE_=
RSA);=0A=
+    qtest_writel(qts, c->acry_addr + ACRY_TRIGGER,=0A=
+                ACRY_TRIGGER_RSA_START | ACRY_TRIGGER_RSA_DMA_DATA);=0A=
+=0A=
+    /* Completion requires both RSA_ENG_DONE and RSA_DMA_DONE to be assert=
ed. */=0A=
+    g_assert_cmphex(qtest_readl(qts, c->acry_addr + ACRY_STATUS), =3D=3D,=
=0A=
+                    ACRY_STATUS_RSA_DONE);=0A=
+=0A=
+    qtest_memread(qts, c->sram_addr, sram_buf, sizeof(sram_buf));=0A=
+    get_bignum_be_bytes(sram_buf, ACRY_DATA_OFFSET, result, t->c_len);=0A=
+    g_assert_cmpmem(result, t->c_len, t->c, t->c_len);=0A=
+=0A=
+    /* Clear IRQ status and check it is deasserted */=0A=
+    qtest_writel(qts, c->acry_addr + ACRY_STATUS, ACRY_STATUS_RSA_DONE);=
=0A=
+    g_assert_cmphex(qtest_readl(qts, c->acry_addr + ACRY_STATUS), =3D=3D, =
0);=0A=
+=0A=
+    qtest_quit(qts);=0A=
+}=0A=
+=0A=
+static void aspeed_add_acry_tests(const char *prefix, const char *machine,=
=0A=
+                                  uint64_t acry_addr, uint64_t sram_addr,=
=0A=
+                                  uint64_t dram_addr)=0A=
+{=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ARRAY_SIZE(acry_modexp_tests); i++) {=0A=
+        g_autofree char *path =3D NULL;=0A=
+        AspeedACRYTest *t;=0A=
+=0A=
+        path =3D g_strdup_printf("%s/acry/%s", prefix,=0A=
+                               acry_modexp_tests[i].name);=0A=
+        t =3D g_new0(AspeedACRYTest, 1);=0A=
+        t->machine =3D machine;=0A=
+        t->acry_addr =3D acry_addr;=0A=
+        t->sram_addr =3D sram_addr;=0A=
+        t->dram_addr =3D dram_addr;=0A=
+        t->index =3D i;=0A=
+        qtest_add_data_func_full(path, t, test_modexp_rsa, g_free);=0A=
+    }=0A=
+}=0A=
+=0A=
+int main(int argc, char **argv)=0A=
+{=0A=
+    g_test_init(&argc, &argv, NULL);=0A=
+=0A=
+    aspeed_add_acry_tests("ast2600", "-machine ast2600-evb",=0A=
+                          0x1e6fa000, 0x1e710000, 0x80001000);=0A=
+=0A=
+    return g_test_run();=0A=
+}=0A=
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build=0A=
index f7c7d06620..c58be94c25 100644=0A=
--- a/tests/qtest/meson.build=0A=
+++ b/tests/qtest/meson.build=0A=
@@ -220,7 +220,8 @@ qtests_npcm7xx =3D \=0A=
 qtests_npcm8xx =3D \=0A=
   ['npcm_gmac-test']=0A=
 qtests_aspeed =3D \=0A=
-  ['aspeed_gpio-test',=0A=
+  ['aspeed-acry-test',=0A=
+   'aspeed_gpio-test',=0A=
    'aspeed_hace-test',=0A=
    'aspeed_scu-test',=0A=
    'aspeed_smc-test']=0A=
@@ -392,6 +393,8 @@ if get_option('replication').allowed()=0A=
 endif=0A=
 =0A=
 qtests =3D {=0A=
+  'aspeed-acry-test': [files('aspeed-acry-test.c'),=0A=
+                       crypto],=0A=
   'aspeed_hace-test': [files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),=
=0A=
                        crypto],=0A=
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),=0A=
-- =0A=
2.53.0=0A=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38824C5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFoZ-00016r-5R; Thu, 20 Aug 2026 23:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoX-00015K-Md; Thu, 20 Aug 2026 23:21:05 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoV-0004D4-JB; Thu, 20 Aug 2026 23:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VflcPZDcnP4y8Z/XwLahBqvGgVNPL/0As6GE2pmLm8yDOCzdzH++FzVU+7cCfq/u9YtVY8EAkVOGsgUopVGUXa4yaVjcW63V6l3ULDbaAl9eBKB2vjW3+gDbRWWXeBwfCRmDPvYmwMQdQUGxQuvZlWxMIyJQ55UZbpRwdQj+zZ5+Tk4+WmJJDnhT/Zi4Dubw8dcRzuMdVMvyLXArIvpUDD6qbWGllmtij5OMldh4Yfci9R22vv+tTlNM+H74CIbqQ13uZcb/ZMaa+PHyLmuGWD1yxJ8P7m7brbBt/dmCqt9qfsJnBOQT4wDbWy44rxuWHRizSVROhnHEtsG4AAwuYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5LiAFQwGnLkYapDUQBz7q6Nl8n/oZ4ano/LT1880Go=;
 b=Ah/ZaluiGhEJfMBCbSJ1a1vGCGIQVdPBuzwYSsxIXuc8CQgvr2YYFGvOprB8jrV7cq1zh4DaQf0/NXv5CLR1uFFMPheLTuoaedMFEDSUwcrJxAmQzMyzLb5HSZPCk8ChnMb2voh5de82OyzvUnh1fCXXAek/LECXrvCllOT0kEyGcpnU9P3oHFvEBjI3lapGoL/fMXNAeyGKXTv9lG9Xpe9DJbAP7rSQ5dauZHoz33MSyo8iyqpRmhpAEgSKSmG/7Cl4D5gBBACNVi/s4l08Jv0eD6iTczGpJm9qIb0gl0Jve8MpFEyIMpvoTtilDvSLDehy5PGCIiXcfUcD97U3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5LiAFQwGnLkYapDUQBz7q6Nl8n/oZ4ano/LT1880Go=;
 b=J/TdZivgeocB8Wbqn7AQ750w2YjZCYhHCBj+TrTY5rYlwDubEKQ6stVn3WitfHjgmllriRcSDFmgePen1GG7rln1937HSRcyUHYlbhYKqZQ3UWFCBjkcxsDRvXIIDPw2fp/IBkxrFJSUcQLiaK2uzpwBiTCgYvVjTLf5HcsqSBXvpyALVgXQJzs+HmIbu0vSDSx5WO2CK/TmiR76Ya4iVee5IPtsxhPniFgImasi9PT5llyZGVSy5Stbu6cz7RWtCODf6RNXTHwbt2YJ2U+MuZHAkhrAnS5Ss1KjhX+WSzTHUxa++QSuBo8B6M/Si7rIqG5BKFVCV4o2kEF0bj+7Ng==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5467.apcprd06.prod.outlook.com (2603:1096:101:b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:20:49 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:20:49 +0000
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
Subject: [PATCH v2 9/9] tests/qtest: Add ASPEED SBC ECDSA engine test
Thread-Topic: [PATCH v2 9/9] tests/qtest: Add ASPEED SBC ECDSA engine test
Thread-Index: AQHdMRwQV/tM4a/eWE26Wknz/sxvEw==
Date: Fri, 21 Aug 2026 03:20:49 +0000
Message-ID: <20260821032036.1829294-10-jamin_lin@aspeedtech.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5467:EE_
x-ms-office365-filtering-correlation-id: 99b195a7-2760-402b-5885-08deff3332b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|6133799003|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 3evA+y9U8RAsr5d9/yi07Ttrf1kwyKgC1mYiG6rORLDSF5XsLMfnvJllNTyKME7z80CjvKB5H1ockC4UPhDKbhnsjSA1NLnukic+5xkJNcREnCYl05AcldED60SEOzP+mBttfoeMDVrbXnh2eZaxZE/iQoo26WfQiNQq+YYGGjs2whWSHwwteAecHNzLwjsvN0ZoyApy+RxCNHdMieU0zK6EY37WYhZ0/tklIbTVeYWeFtfhARFHZX5GbFGEZPIzmg7F8Vd91PBK2fsF0PTE8Gs+hKFy3KZj+zF9FmSbF98cqDyWE6p96vq6nco8zx3sG/971yZfWlQ0eyjamwhu66I5YsXVim0AyTehsKT88nc3FKKaNdfkNbDthEwersw9k3axKdcZ/dxSrcbMjZsDa+oaek6ANdsWXSscSHVgGJ41NNkB0so3h9j4XJ13juM99KysodOTR2wiB57cr11BTG4waU3DqYxuguDAtxmIro9laHcUahqk6qL63EKpy30YPOwPfjelU3Mz/jnOV1eemObnIGPO3EsJICxSH9dfrB3HDK2cZM5C2IkLSBIq1Mwy1HrlsvwLo7Zc7BCJCJw7bSTRYuytLx75ePhRmSzSHptZUQmSULW4XQ8y5Mp+4mST5ImbePleNYQhdQ63MAIcDaOXKQaMYW1OXHqkO26L5U4CVK8JcJ3nRMvul/h6MD1x0VxY+eJUxBfFRCWEJ6bz29jIQbgbfXXW7Wo15d605B/zRWqsdjNw/uyGtjPU3KYJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rzOGUv1jNv/GxK+mIjRBjjmYrov/B3qUyvsfIp4c1W8MzdCacRx8rtIKxQ?=
 =?iso-8859-1?Q?v2WGMXyBh7U4u+ZABClaHPuYluOUUcvTUecuCOXVwZHmhyE+rsSV+jsJYe?=
 =?iso-8859-1?Q?xVusQ+D/5JCtxrnrUFRkIGNp9aa7sIqWlhsf5/0CfX00+yi1x8w2+JOvhh?=
 =?iso-8859-1?Q?Z1mBs1GOAw90J6lQ02PSrX9Jk5n1Z4a84cbDyZr2dUpBFGRpXJfko3HiJ1?=
 =?iso-8859-1?Q?WC7jHap5v7+iupsNnwgZOrD4ije/0GFAdJBcMA1IeDNLJXgQECf5N3kBhO?=
 =?iso-8859-1?Q?fZg8v692eMgzB/Mclh+k6cxzTizjlOUl03Ez9S93GD8nm7VvU2fFVmjX3b?=
 =?iso-8859-1?Q?Y154EK67E7QYtriurS7JPd4Wu/yraFJRL2Ziw30DSVFxDyd4vaFDexxuQI?=
 =?iso-8859-1?Q?4ZwPlzCwmTbqhaNNgNXmOOVrvEi3mYsrwL1KL2CDFKjWzUCfg0ezkESP0o?=
 =?iso-8859-1?Q?FwPbSCWvmF3zIy2FRnriHU3YBcmFIyT4Luy5UtsLuU3AfWtbkaO7hIhE7h?=
 =?iso-8859-1?Q?GQ/O/4j/pv5WbohHYeDuAWYHWy6M7EpZcbLlgoWwMEMrHzw7ETO/8/ioR1?=
 =?iso-8859-1?Q?E819B9bvF42XwCj+BRbfEZuV83wa2KP0rcexajnfxjJaaKvog6X2uq/3CV?=
 =?iso-8859-1?Q?EJTxcIMHPtbh3udF8CG83fc3hjXXDUl5hAQJ8butteSH/B+5iNwjo+yPSY?=
 =?iso-8859-1?Q?ycKeh4AAmPh6jaF1fpZRigv1AbCLMnJzFg1e7NzYq8vlxg0mr+IIft1zwI?=
 =?iso-8859-1?Q?W4J+pW/Gvt2TpXP8vYjnAP/F3SH69i2yck3ATg5PanWaXspDIJdIfxtMZW?=
 =?iso-8859-1?Q?TNsaBXTta5UzkS3LAGfbhnzyzdFlfVO6NuDISnK6qbyOgAZqp/D73dvwix?=
 =?iso-8859-1?Q?pLSiv23+GJtJXxPOFJcHBm6NOQCltdI2T6lut7EJIGg4TuDB6WqdE4QLLw?=
 =?iso-8859-1?Q?fcTT+Y1rlXZNYz/1QZV58hm5AhD7shcUWZqkYBiVhUsNBHrctdg3I6IJVp?=
 =?iso-8859-1?Q?YKNphxqmJDp2ZcJur9JRGgXLx33Ak8ZN9emcNyfSOCleJgk19T7QIsceaq?=
 =?iso-8859-1?Q?mRIqSBscR0v1KzVedC2T4+uZlj67Vuh/QcCeG6+k2QT7kGFdjsfIUDXAxI?=
 =?iso-8859-1?Q?829TYZqkdmLhMh6NtVwwKXbCPxpNiP/zyYWcsZ1JyLRwD8h2LbrNNr6aF0?=
 =?iso-8859-1?Q?iBvql1QFAIiE6p+lYI+Nzpz9OLYvR/1r/yze7whK+MhXALSbOCYpJbr1ES?=
 =?iso-8859-1?Q?tZnxG2XsC3DYDcsfXFy4VC2R6jyFh+GGzCZ0shPNcESOLaquTddSz3yyOo?=
 =?iso-8859-1?Q?bnEAMrKo8ovKMKW1xc80n+xv9BLUTQTn/z2n6MXLkEd6H5dZKoGiQ4xVDi?=
 =?iso-8859-1?Q?LHtZ0NdQoKQFim+X7DAA4k8hhtHVtGYOGb5NMDoiqHevaMYXjRZNUE0zU+?=
 =?iso-8859-1?Q?xMZAmlwqINn1HjFJVEFj8CDWl8EN8AgCUQP3S5mj9QTvpaBMorWQMtjnpx?=
 =?iso-8859-1?Q?wM/H80KeFUe8US0zPtTPKgzZRQ867ZnZbqo19/tasYy6LzW2pxXD2s+4zG?=
 =?iso-8859-1?Q?uKYhEn25NBl59nLJELuVwYgCczAlVnRXwP0zBKA256w9eyj9cUyXlPcUIh?=
 =?iso-8859-1?Q?ZXP4fXr7lpynJf+0kyt9xLeo8ILHYmMHCqwcN3Ul+yGZ5mvmeeqeeciwFg?=
 =?iso-8859-1?Q?4dGDaDurNbshP5mpIyj3beIIphSZpz8fbmPepS0mIEiCj16CEP0uL+wlhT?=
 =?iso-8859-1?Q?Ztkyblmwfq4/Yllsez3IEc01rOM1ewA0i4uPJ3mCzZ9qpRcf0+6AsEDC0r?=
 =?iso-8859-1?Q?U5OllHpYag=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KM/Of+/0xinmENmJhq2h7Teybvixkk6W/HGEhmszNVlmZHbtMoeesoivUfjzcrkl2wNlQLKgbVhWFwoqXGhnVC5qYRWKHlEgSxtvWDljyrLzOmPTgzXhK+jzhKeydcnjyBaHpWajp4N5fRhvW2WwFcFSQoAE/fUjkNDS/F1DF4rk3Cz3VM9c9KNNC0OxgVTAgEudt9f75wAQ6UpTs/If7iPFh5eOzsv6vWZX6WwseDl9ihe5yf1CZNdwgJHndHLSCxCfnyEVFa87hd5agS875IasIUD+06iTU34iDn3WBNgv4+ZxoL0IZceJpcE49mHGlBM3XOl48f/JjPe/+sS+3A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b195a7-2760-402b-5885-08deff3332b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 03:20:49.2095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DccDamq0G+Iz4p3icx/0615y2GeGm+b2m3jkAm6h69jkQTJJDjbeYeTTAU49iEBKGA1sPdK2KDXgt9WW3Gt+feluqAcexOT27fEs2D0coI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5467
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
 tests/qtest/aspeed-sbc-test.c | 193 ++++++++++++++++++++++++++++++++++=0A=
 tests/qtest/meson.build       |   2 +=0A=
 2 files changed, 195 insertions(+)=0A=
 create mode 100644 tests/qtest/aspeed-sbc-test.c=0A=
=0A=
diff --git a/tests/qtest/aspeed-sbc-test.c b/tests/qtest/aspeed-sbc-test.c=
=0A=
new file mode 100644=0A=
index 0000000000..d67fe970e4=0A=
--- /dev/null=0A=
+++ b/tests/qtest/aspeed-sbc-test.c=0A=
@@ -0,0 +1,193 @@=0A=
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
+    QTestState *qts =3D qtest_init(c->machine);=0A=
+    uint32_t status;=0A=
+    uint8_t bad;=0A=
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


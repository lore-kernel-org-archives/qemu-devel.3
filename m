Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C27CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfF6-0000A6-M0; Wed, 03 Jun 2026 02:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfF5-00009Y-4y; Wed, 03 Jun 2026 02:38:19 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfF2-0008Ja-PD; Wed, 03 Jun 2026 02:38:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igtbXG5T9t3tieGTx0u6iHwljYiZwaPon5MvwCySzMZGxoy+dQL3zuRCrjmSyvwZCgCfNn6KT3ttLraJgk4J0PoJA/bfIwQ7fUk8YBeqDPu/vLKNDiyQbvf2FUxNn4KiqBBZTC/ZRtxtj3/soS/AXz4BXAqIA+Myog0qlbsFRp0XMgip9xLnFkYOJipdDwdOZGCXDjd63d4jHatK4BCsSrpL0DWWrLcU9PjD0/nu5NsvX+sn2WcLSXUVGkGz9hq6ebEDmDoHcx6JtvdLClUKYdtTFo18WNFf2aZ6D7mXdTg2HZy1DwvdQTNL9dL282mjHRip5UPF6fsgY6HoqblHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHvXAtoDpqiLRdefaANbWrlPKxnjnVGo7wGi+Hd6peM=;
 b=MXLVqofHhcOydjf+TdgsX1Wfn875vbz6FRhBScyIVXZBF7vzCMqB5a4XxYETZe7sm16XUiL+9q916f/cJur4FQ8dZpIGgxL1LJ99zJaEqzsdrPQ3s5nhMXBf9EOK5MVHbpxYsf+BWJNVdFvJL6VDkHd3gejiSDPozzCW/d/gWILcfRbPUkMlS0CFPP6+2MLx9NizH3BKwTuHqMiUyOzGf/0iO6ZRZT0n4y1/5ZFVom3zVCpcQn0eA6sRyd1EdDE9hPFFLEFvuX8yb1O2nyO40D02NoDIvEUAIneVqLVFJJV9V/TLQ733k+vFdi8Z8zYY8kE2n3pPdtHfCGqdFZFcXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHvXAtoDpqiLRdefaANbWrlPKxnjnVGo7wGi+Hd6peM=;
 b=IAqL+W1POv9gAYOgKKi2EuIcqtk/9FlzRMtSZ+Ng+ipuiBVDylx4cpyAXxil8pKTYwdvt32r16SiLrt4zeiW1ScB5u7diVgLtinPI9Bat1uUzZcPoc4XDi0yXGL0jcQ84HQTRXVDe7Q0O3/1PmRR5cOnTUOCtNVJZOuer2PLzJg8/ZnCMi6AnfhQIfFdIAiLASNznlnLPOF3vhisMCFhibGyh/s3Gspgpm7cs4ibl+GjDX5Nl4ewErZ/iOt2jEiKK3DA76Wfk3N2gVyujZ3wGopkcl/u8tirmyzgPcplSywWM/0wkyav5B7I6buV8+megFJXV5u0S7PsjHZMAntMKw==
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com (2603:1096:400:129::9)
 by TYNPR06MB8525.apcprd06.prod.outlook.com (2603:1096:405:3d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:38:05 +0000
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995]) by TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:38:05 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: [RESEND PATCH 5/6] tests/qtest: Add ASPEED Caliptra mailbox test
Thread-Topic: [RESEND PATCH 5/6] tests/qtest: Add ASPEED Caliptra mailbox test
Thread-Index: AQHc8yOIR74D0z49m0Sx9lMadPVCRw==
Date: Wed, 3 Jun 2026 06:38:05 +0000
Message-ID: <20260603063756.1481524-6-steven_lee@aspeedtech.com>
References: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
In-Reply-To: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4746:EE_|TYNPR06MB8525:EE_
x-ms-office365-filtering-correlation-id: a0ab7bfe-d49c-4467-e958-08dec13aaaef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|6133799003|3023799007|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: lKtixkLx3NRqJpk2uMqFBHM9gQMINczkYTcRas71gXrJ/3hhY/pmN1RZN22imWgIJuFBMWwy4Uw5gGBSldeC4TtmjxLEDHriOXZwrZmRbKLqkjxuuWt0lzcnoQHxSFnSsjg7J/KX6rObZhxG0jUOrq2H+jPSESHjwDKqeTVVEgJvIV+i0r8D6Jif9DOep+g7EwnVCDjAAk0UmtMKgotfEDBtooz62FqWaLRgpwWMAS350Vlx5FjUgFeIp8WlNGQ9OGaXuHtHs+HPpevpzWJp+J7VUoS2QEmrM5Uu/Yr4RvG4HJonnb7yZQT5Z6TEnyTjBmuAH5tl+g7LCVfW2zzthcg5v+ivXP801eS2oNJ/zsGX0N39m8MoLDvVFUx0YLatJ7Zu1Yuf945IFxnSMKr78e69IsOe9Tv7aIuZJnxKMN32TGtIZe9+kPt41MBuKJVlLvgdpMR/DCf11IGm2xud63w1sOFxm85jk+5irqzPyQIM+bkEhlD97AqIROp3BjNKbtnTiCEBBnE6po1nUXMOJ+zJabEqO5ChVvLnfy1a9U15qvSUC21VGdGlDWmJQq+eJ37OCCEMeisSGiEV4uBTkTsBf964twj3M91MuhlACIeUEoV/22s4aSZ63YEqzQWgrRxzazPYZ+gpTn00Y/zN5iAcoiDsZwE4qWiGeqRzrx+EKurXSsbL5+Q3dNUlh94HLqqEOkwDcgRAM93UeHCMvr53Rrx/23waV2B49g+qoOZah7XX8Ab3Poeap5v1cg3GA+0nGk/+O79Wd9kVBsGkUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4746.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v3CyxcNxQwxxSH4mP7ER3vW/EvGt72DS65ayEYCBp1gWEsLhWF/3pHM8bF?=
 =?iso-8859-1?Q?2utIqBG6RzQ6+luqXOOwmLiiWYFRI119BU2SPQe80eqJazTDVz30Th06Vp?=
 =?iso-8859-1?Q?Pimkxf/P+2Agjk7T9Zc5MZQYlk1hzE2g+D6yfnWhn/MYRVJv29yn3Oy0lH?=
 =?iso-8859-1?Q?yQtib1tkb8FABNPktOBwhEwOrtk7oH88cIjYCms6hLo3QE5FPalYA1tIZs?=
 =?iso-8859-1?Q?BxzUx1EGs5BL5Qnr7EtRl2rtUJcRKtfjhf4ZJRcHMx7Gighzq20QtP+NGA?=
 =?iso-8859-1?Q?GyrrGeIfzR5JVD9+0AutLiyIFtTIuyga5eddYILtxXdEnTwTYoutLOWgva?=
 =?iso-8859-1?Q?X3XDgbDSe++OPDPzrlcmz8Mcwf+x/jTQpjPSOizu3yNRb+RSYWrW9OsnkU?=
 =?iso-8859-1?Q?/9ajTdiYHA+rYFhExJRtEKf9Kzf2nXuNpSrVT4JJwcylQN5IsbSHAoBDg6?=
 =?iso-8859-1?Q?MGJHpW5v4rbSv4z+qt3SldSOz1XCxNoJABVTOpSqPdL6SLmNVbPfNO1FHx?=
 =?iso-8859-1?Q?duH93wAPeXh6cgxrTtgrZ+56SktdaL38HJjzGlaHJF2R/JNme2df5QBMUO?=
 =?iso-8859-1?Q?Fd4SWqVQWWZ+StQDzfeDzzVfyYmTd1E2biZF2fLpk6BK0shBouX5urbWHo?=
 =?iso-8859-1?Q?WXS05L0FE/P2YD2XrrAEq6Jpa127prmxnjhSV3TkKrB1MmWamgFDS2wCYx?=
 =?iso-8859-1?Q?eJNCeXASmuWIwRjluLUEzdpab4kug/x1eB4EbAaNv3iPIm199ACV7aW898?=
 =?iso-8859-1?Q?f87SeoynuTyKYp5xzL206iB2HcH9xKCQx9mhcatsTXtKlt0M14OXggwN+d?=
 =?iso-8859-1?Q?+VsVpjhRTbv2PH5DIxXUFlKKJCcs18lXGyKDDj2DT2d75LHR2j6k2ChToS?=
 =?iso-8859-1?Q?O8K0gKHFNuKl1et3/1MI87WqGjGMt3Lo2pTBJPG4SCjfc+IU9ILeXvoetM?=
 =?iso-8859-1?Q?yljPiuztyqxNMLmahBgNofiwc+bKqU30iohV49YdQouAcavckuX3BSrGoF?=
 =?iso-8859-1?Q?1GP4BaR3AEws+93BeyszhJWywjTEdMlmMV6RnS9EOJ7BOrnChrEt4G142Z?=
 =?iso-8859-1?Q?r4yxOjzKEQFkDTdn2/qvWtK5KG+F5FE+RnK2POLTusepX/uXPER86XWGFy?=
 =?iso-8859-1?Q?e5NEv4jox8uXcARFc9+un8ccwY3ECzyW/s+mhbQA3jEfvpOE/qtR5kQ0/Y?=
 =?iso-8859-1?Q?9pkUWI8T/C3Ey0uGoam9BX5TNpgPGNRyQ/b+lmBBeSb6qCfkC+8iqy9nT8?=
 =?iso-8859-1?Q?+TcnbghtPlJrful2fDRQ4qJ9V8+2PpjNIE9aKbiZxglzqddWzDBxvyhSnV?=
 =?iso-8859-1?Q?oqwvL3IRRtuwqKm6EPq1n3ci6w65+ieHRrCmg4rCk0iATME4eMUC0BeH3Q?=
 =?iso-8859-1?Q?yKQsi/+fmcpZdXFKPQLBcuyJUXFqBEHKG9BOf7ss34tYp7WTTbd2dR/Bos?=
 =?iso-8859-1?Q?P7UHmAJfHUvXws7jyJS3fyBnMCCnSecnlP024/EkPidGzzrD4VFqnxgP54?=
 =?iso-8859-1?Q?gELLEjYtew6DwiqIq8tzahw4rzW1SJZXOYVkWCIHRJLeHVOMqWiJ8IMZzB?=
 =?iso-8859-1?Q?AQ8828cqIPeLJ7FvVb0bjoKMyEe26kEOYPLMbqV8v+/zSykEMiqX6I+CMF?=
 =?iso-8859-1?Q?noNpnHebJZbybH3xK1tWC4HCmrQ5SYB4Lj1Wm5Yenes9Ijf9P0C4dYySi6?=
 =?iso-8859-1?Q?shQFESyuY8AqBIdzchC7zBtN5zXcmJmm2tPG2juJBSjPbNZwGBZlRncOkL?=
 =?iso-8859-1?Q?V1y2P9IASdbfcT9u3bwGrz2IrvugI6k/4LgGeTNkagjWVFO427e3/PttBJ?=
 =?iso-8859-1?Q?lBoQzlOqhA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jrjUVySDpNg68ia/3ls0/78+vBN2CqODhSrEju6ZF7p8SVDtqlrEZEuuxk/9OKLQXW8FYmf/uyeN5I97MwGUOtQR7DHRhbTcdnK308kV3DJP329o8haeLkYBUttSCHrHE4d8KiyAHS7bJTG4WWCVUnwzoXvMZxAvqhk/dV6r56X6tsWoGufCdrG/863cbO2AySz4ZNm8476oF1NliwR4IXs8b6g6MybUTbPrmjPIOSQ0Tl6s4jIsozmcUZ3UgJ3E3cuvCNyd1ik+S03iIeo25EmkA17uLIeisfqus/Ik+Q5a3pDU/e1sAQw+em+JMmB/LL+4xPvGjw7ERV1DOr13RA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4746.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ab7bfe-d49c-4467-e958-08dec13aaaef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:38:05.2908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5zFgEplLYsHfdeG6MKxAT18C2ys205FNyBUcqrpquLEwsyuVRm6L0TT/aD8ml6T+GaJEByWwsS4ZpGKcHxwASD77SCDOfiP58ZZbmgY6Fo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8525
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=steven_lee@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Cover the AST1040 Caliptra mailbox execute flow through the external peer p=
rotocol and verify that the SCU CPTRA page register remaps the MCI aperture=
 between CSR and SRAM pages.=0A=
=0A=
Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed_cptra_mbox-test.c | 223 +++++++++++++++++++++++++++=0A=
 tests/qtest/meson.build              |   3 +-=0A=
 2 files changed, 225 insertions(+), 1 deletion(-)=0A=
 create mode 100644 tests/qtest/aspeed_cptra_mbox-test.c=0A=
=0A=
diff --git a/tests/qtest/aspeed_cptra_mbox-test.c b/tests/qtest/aspeed_cptr=
a_mbox-test.c=0A=
new file mode 100644=0A=
index 0000000000..4d0e1682da=0A=
--- /dev/null=0A=
+++ b/tests/qtest/aspeed_cptra_mbox-test.c=0A=
@@ -0,0 +1,223 @@=0A=
+/*=0A=
+ * QTest for the ASPEED Caliptra mailbox on the ast1040-evb machine.=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "libqtest-single.h"=0A=
+#include "qemu/sockets.h"=0A=
+=0A=
+/* AST1040 guest-visible mailbox bases. */=0A=
+#define SRAM_BASE   0x21400000ULL=0A=
+#define CSR_BASE    0x21600000ULL=0A=
+=0A=
+#define CSR_LOCK         0x000=0A=
+#define CSR_USER         0x004=0A=
+#define CSR_CMD          0x010=0A=
+#define CSR_DLEN         0x014=0A=
+#define CSR_EXECUTE      0x018=0A=
+#define CSR_CMD_STATUS   0x020=0A=
+=0A=
+#define STATUS_BUSY        0=0A=
+#define STATUS_COMPLETE    2=0A=
+#define STATUS_CMD_FAILURE 3=0A=
+=0A=
+/* SCU CPTRA page-select register (SCU base 0x74C02000 + 0x120). */=0A=
+#define SCU_CPTRA_PAGE_REG0  0x74C02120ULL=0A=
+/* MCI remap aperture. */=0A=
+#define MCI_WINDOW           0x74200000ULL=0A=
+=0A=
+/* Wire protocol. */=0A=
+#define PROTO_MAGIC    0x4D424F58u=0A=
+#define PROTO_VERSION  1u=0A=
+#define CMD_EXECUTE    1u=0A=
+#define CMD_RESPONSE   2u=0A=
+=0A=
+static int peer_lfd =3D -1;=0A=
+static int peer_fd =3D -1;=0A=
+=0A=
+static void peer_read(void *buf, size_t len)=0A=
+{=0A=
+    size_t off =3D 0;=0A=
+=0A=
+    while (off < len) {=0A=
+        ssize_t r =3D read(peer_fd, (uint8_t *)buf + off, len - off);=0A=
+        g_assert_cmpint(r, >, 0);=0A=
+        off +=3D r;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void peer_write(const void *buf, size_t len)=0A=
+{=0A=
+    size_t off =3D 0;=0A=
+=0A=
+    while (off < len) {=0A=
+        ssize_t w =3D write(peer_fd, (const uint8_t *)buf + off, len - off=
);=0A=
+        g_assert_cmpint(w, >, 0);=0A=
+        off +=3D w;=0A=
+    }=0A=
+}=0A=
+=0A=
+static uint32_t ld32(const uint8_t *p)=0A=
+{=0A=
+    return p[0] | (p[1] << 8) | (p[2] << 16) | ((uint32_t)p[3] << 24);=0A=
+}=0A=
+=0A=
+static void st32(uint8_t *p, uint32_t v)=0A=
+{=0A=
+    p[0] =3D v; p[1] =3D v >> 8; p[2] =3D v >> 16; p[3] =3D v >> 24;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Service one MBOX_EXECUTE: read the request, optionally check it, then r=
eply=0A=
+ * with MBOX_RESPONSE carrying @rsp_status and @rsp_data.=0A=
+ */=0A=
+static void peer_serve_execute(uint32_t expect_cmd, uint32_t expect_dlen,=
=0A=
+                               uint32_t rsp_status,=0A=
+                               const uint8_t *rsp_data, uint32_t rsp_dlen)=
=0A=
+{=0A=
+    uint8_t hdr[12];=0A=
+    uint32_t plen, cmd, dlen;=0A=
+    g_autofree uint8_t *payload =3D NULL;=0A=
+    uint32_t rsp_padded =3D (rsp_dlen + 3) & ~3u;=0A=
+    uint32_t rsp_plen =3D 8 + rsp_padded;=0A=
+    g_autofree uint8_t *rsp =3D g_malloc0(12 + rsp_plen);=0A=
+=0A=
+    peer_read(hdr, sizeof(hdr));=0A=
+    g_assert_cmpuint(ld32(hdr), =3D=3D, PROTO_MAGIC);=0A=
+    g_assert_cmpuint(hdr[4] | (hdr[5] << 8), =3D=3D, PROTO_VERSION);=0A=
+    g_assert_cmpuint(hdr[6] | (hdr[7] << 8), =3D=3D, CMD_EXECUTE);=0A=
+    plen =3D ld32(hdr + 8);=0A=
+    g_assert_cmpuint(plen, >=3D, 8);=0A=
+=0A=
+    payload =3D g_malloc(plen);=0A=
+    peer_read(payload, plen);=0A=
+    cmd =3D ld32(payload);=0A=
+    dlen =3D ld32(payload + 4);=0A=
+    g_assert_cmpuint(cmd, =3D=3D, expect_cmd);=0A=
+    g_assert_cmpuint(dlen, =3D=3D, expect_dlen);=0A=
+=0A=
+    st32(rsp, PROTO_MAGIC);=0A=
+    rsp[4] =3D PROTO_VERSION; rsp[5] =3D 0;=0A=
+    rsp[6] =3D CMD_RESPONSE;  rsp[7] =3D 0;=0A=
+    st32(rsp + 8, rsp_plen);=0A=
+    st32(rsp + 12, rsp_status);=0A=
+    st32(rsp + 16, rsp_dlen);=0A=
+    if (rsp_dlen) {=0A=
+        memcpy(rsp + 20, rsp_data, rsp_dlen);=0A=
+    }=0A=
+    peer_write(rsp, 12 + rsp_plen);=0A=
+}=0A=
+=0A=
+static uint32_t poll_cmd_status(void)=0A=
+{=0A=
+    uint32_t s =3D STATUS_BUSY;=0A=
+    int tries =3D 1000;=0A=
+=0A=
+    while (tries--) {=0A=
+        s =3D qtest_readl(global_qtest, CSR_BASE + CSR_CMD_STATUS);=0A=
+        if (s !=3D STATUS_BUSY) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+    return s;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Realistic mailbox transaction: acquire the lock, run an EXECUTE roundtr=
ip=0A=
+ * against the peer, verify the response lands in SRAM, then release.=0A=
+ */=0A=
+static void test_execute(void)=0A=
+{=0A=
+    static const uint8_t resp[] =3D {=0A=
+        0x11, 0xf9, 0xff, 0xff,   /* checksum */=0A=
+        0x00, 0x00, 0x00, 0x00,=0A=
+        0x14, 0x00, 0x00, 0x00,   /* inner dlen =3D 20 */=0A=
+        'C', 'a', 'l', 'i', 'p', 't', 'r', 'a',=0A=
+        '_', 'C', 'o', 'r', 'e', '_', 'v', '2', '.', '0', '.', '0',=0A=
+    };=0A=
+    uint32_t status;=0A=
+=0A=
+    /*=0A=
+     * Acquire: first read returns 0, USER reflects the SoC agent, busy af=
ter.=0A=
+     */=0A=
+    g_assert_cmpuint(qtest_readl(global_qtest, CSR_BASE + CSR_LOCK), =3D=
=3D, 0);=0A=
+    g_assert_cmpuint(qtest_readl(global_qtest, CSR_BASE + CSR_USER), =3D=
=3D, 1);=0A=
+    g_assert_cmpuint(qtest_readl(global_qtest, CSR_BASE + CSR_LOCK), =3D=
=3D, 1);=0A=
+=0A=
+    qtest_writel(global_qtest, SRAM_BASE + 0, 0xfffffec0);=0A=
+    qtest_writel(global_qtest, CSR_BASE + CSR_CMD, 0x4d465756);=0A=
+    qtest_writel(global_qtest, CSR_BASE + CSR_DLEN, 8);=0A=
+    qtest_writel(global_qtest, CSR_BASE + CSR_EXECUTE, 1);=0A=
+=0A=
+    peer_serve_execute(0x4d465756, 8, STATUS_COMPLETE, resp, sizeof(resp))=
;=0A=
+=0A=
+    status =3D poll_cmd_status();=0A=
+    g_assert_cmpuint(status, =3D=3D, STATUS_COMPLETE);=0A=
+    g_assert_cmpuint(qtest_readl(global_qtest, CSR_BASE + CSR_DLEN),=0A=
+                     =3D=3D, sizeof(resp));=0A=
+    g_assert_cmpuint(qtest_readl(global_qtest, SRAM_BASE + 0), =3D=3D, 0xf=
ffff911);=0A=
+    g_assert_cmpuint(qtest_readl(global_qtest, SRAM_BASE + 8), =3D=3D, 0x1=
4);=0A=
+    g_assert_cmpuint(qtest_readl(global_qtest, SRAM_BASE + 12), =3D=3D, 0x=
696c6143);=0A=
+=0A=
+    /* Completing the transaction (EXECUTE 1->0) releases the lock. */=0A=
+    qtest_writel(global_qtest, CSR_BASE + CSR_EXECUTE, 0);=0A=
+    g_assert_cmpuint(qtest_readl(global_qtest, CSR_BASE + CSR_LOCK), =3D=
=3D, 0);=0A=
+    qtest_writel(global_qtest, CSR_BASE + CSR_EXECUTE, 0);=0A=
+}=0A=
+=0A=
+/* SCU CPTRA_PAGE_REG0 selects the target page seen through the MCI window=
. */=0A=
+static void test_scu_remap(void)=0A=
+{=0A=
+    /* Window pointed at the CSR page exposes the CMD register. */=0A=
+    qtest_writel(global_qtest, CSR_BASE + CSR_CMD, 0xdeadbeef);=0A=
+    qtest_writel(global_qtest, SCU_CPTRA_PAGE_REG0, CSR_BASE);=0A=
+    g_assert_cmpuint(qtest_readl(global_qtest, MCI_WINDOW + CSR_CMD),=0A=
+                     =3D=3D, 0xdeadbeef);=0A=
+=0A=
+    /* Re-point at the SRAM page. */=0A=
+    qtest_writel(global_qtest, SRAM_BASE + 0, 0x12345678);=0A=
+    qtest_writel(global_qtest, SCU_CPTRA_PAGE_REG0, SRAM_BASE);=0A=
+    g_assert_cmpuint(qtest_readl(global_qtest, MCI_WINDOW + 0),=0A=
+                     =3D=3D, 0x12345678);=0A=
+}=0A=
+=0A=
+int main(int argc, char **argv)=0A=
+{=0A=
+    g_autofree char *sock_path =3D NULL;=0A=
+    g_autofree char *cmdline =3D NULL;=0A=
+    int ret;=0A=
+=0A=
+    g_test_init(&argc, &argv, NULL);=0A=
+=0A=
+    sock_path =3D g_strdup_printf("%s/cptra-mbox-%u.sock",=0A=
+                                g_get_tmp_dir(), getpid());=0A=
+    unlink(sock_path);=0A=
+    peer_lfd =3D qtest_socket_server(sock_path);=0A=
+=0A=
+    cmdline =3D g_strdup_printf(=0A=
+        "-machine ast1040-evb,cptra-peer=3Dpeer0 "=0A=
+        "-chardev socket,id=3Dcptra0,path=3D%s "=0A=
+        "-device cptra-mbox-peer-extern,id=3Dpeer0,chardev=3Dcptra0", sock=
_path);=0A=
+    qtest_start(cmdline);=0A=
+=0A=
+    peer_fd =3D accept(peer_lfd, NULL, NULL);=0A=
+    g_assert_cmpint(peer_fd, >=3D, 0);=0A=
+=0A=
+    qtest_add_func("/cptra-mbox/execute", test_execute);=0A=
+    qtest_add_func("/cptra-mbox/scu-remap", test_scu_remap);=0A=
+=0A=
+    ret =3D g_test_run();=0A=
+=0A=
+    qtest_end();=0A=
+    if (peer_fd >=3D 0) {=0A=
+        close(peer_fd);=0A=
+    }=0A=
+    close(peer_lfd);=0A=
+    unlink(sock_path);=0A=
+=0A=
+    return ret;=0A=
+}=0A=
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build=0A=
index 728dde54b3..c50da850f7 100644=0A=
--- a/tests/qtest/meson.build=0A=
+++ b/tests/qtest/meson.build=0A=
@@ -219,7 +219,8 @@ qtests_aspeed =3D \=0A=
   ['aspeed_gpio-test',=0A=
    'aspeed_hace-test',=0A=
    'aspeed_scu-test',=0A=
-   'aspeed_smc-test']=0A=
+   'aspeed_smc-test',=0A=
+   'aspeed_cptra_mbox-test']=0A=
 qtests_aspeed64 =3D \=0A=
   ['ast2700-gpio-test',=0A=
    'ast2700-hace-test',=0A=
-- =0A=
2.43.0=


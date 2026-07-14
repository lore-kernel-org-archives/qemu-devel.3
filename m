Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964E0C44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXZx-0005m8-81; Tue, 14 Jul 2026 03:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZv-0005lA-AB; Tue, 14 Jul 2026 03:29:19 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZs-0006WV-U0; Tue, 14 Jul 2026 03:29:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKsePV3u6zD0N8wE8nGTDD+Mbyo7DBgsTlCMz8izjaFpEJSsUrMMN+H5O4fKXc8ZrWbjOm+AhUUx1BC/U8seYCqcykzfSLHi01klxHuKQqlUogj1m07PTKdRRGzsNqCt2zAC8Xg+g5EmDy4AEayjCl0/k1qpfolo/uRbmOHPhyJLnaxEL8OCVhwNxvL04BGPN264n/GZ6atpF7m1DPUAbjkiPWNbM7A79YSyATSyD0pWEheD26eTlQH6AvbU/h4SVg50SNY4LZtuUIHfekondtlPH+w4huruUMXfNE926YT5GSAIZtWtxLZfmPba9WJBqOyfstr+gpagnEke/iYWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSYH4GKc3hwBNFlOGW3IuU5yEHxM8D8320C0TfuLa8E=;
 b=miK88LY0pdICDsI4HvGP/dFyxIYF0VjWcS+H9R9x/utLne3TL7/DpgMzvmgZ8MV4W2wHXm5Oh57q4LsjLzqzzHEQdFD75Uf7K4ta5P078D6iHm7xfqjzSdK2oQb2Xq9LT1S5oXof6sexIr3f1y/HBl71AOgwq55i4HHfdK/2O4qt7uzS0awnQpGmfAWByAw/rfxEFBISKjj31d14HS9+kte0QsNizI1xStd6oOn7bZt/WouH9DLRxLeZjBGIe9Ixuv7S1afn1Jx659OJXvhfvghMeTtMHLredZFg+PqPUjSHRZeLMNbSUmgrCbcxqyqOKMDwNNqbMmqjyyycu80B6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSYH4GKc3hwBNFlOGW3IuU5yEHxM8D8320C0TfuLa8E=;
 b=Eus+9IhB2UcLYunT/hZQesjvzyIZ6BRi2O9sUO8Rs6TJxlmyqo9MgAsjdHabz7cUNi0cnI0QJbmvuKG+Il0JdKRJ3icFcOv2FQZ7uo+yff/ZqC8BdedjRd7UeC9qftwPXblkmEdZ/w/rqDCrmn1K+TnF5us2RXLNLqU/WFx1X/fpgBaVmWsHB/+E/uen+JB4rJS1q9B11j3ThzcK7v8tm1ir9XXdlsTQcqycj4K9n3TDZD0Xufv+3Ghklbq0FsEujPJsYf5D8NNNutIOUV7t4Fj8bMBNrbHcTOV3DGFusy22nFsRYzjti/uZdYx4MANya7/LP311LGwdwfaEogv4VA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:03 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:03 +0000
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
Subject: [PATCH v1 01/15] hw/misc/aspeed_hace: Support the crypto command in
 direct access mode
Thread-Topic: [PATCH v1 01/15] hw/misc/aspeed_hace: Support the crypto command
 in direct access mode
Thread-Index: AQHdE2Jxe24QShapQkeRU8176KEoAQ==
Date: Tue, 14 Jul 2026 07:29:02 +0000
Message-ID: <20260714072900.3023742-2-jamin_lin@aspeedtech.com>
References: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6117:EE_
x-ms-office365-filtering-correlation-id: a79a2412-3910-43ea-b807-08dee1799465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|3023799007|6133799003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: c/VGhxmzaaUEU+pFayGXWlLmO/AmKraCOYXR49uSXbceuukB0m+fd5OPbOP53gDGz80pOgVOCuc0dWfHvdImB7+m8GePfN5KSD9lsXUHCtBVUEZOAps/U6QVQOv4wgsul+gvc5n+4hqQxbYvH/ZRwKTdvL8i9VhsuOE7OTFZcUvBoIh+tHTULAp/tFZy1zb3L2CvuDReisruX3Slv996OSM+pop37l0vqaF9UDq6K6XiEW7nIu7nIU6tVMzzs7b5RFdaZZ7+VSFIxeFwXXCFlHu7g1HuVp5E3gzbAFXbwmc77mgQyE5851FsAtW0mlG/PFF+RkRYCXWqoCWrZSXWmXjYcK+nMScc0SK6+mEJyL35nuRy+/Wan/3fAugV8CNvG5U+8Jcd8Fzoi0JLprUPsV1cCOs89k/qQ6fgDoWVmceuccNyOunF9Vtuwv1cHJYs8yL1WV48y1dxG5j9RF827wbe0QAbloViLGPyw6gXfm7f27Fn/HxdFVrdwnq3zZsMf3u5s+nPzlbbqUIyBpjvK54Tj8NcXEHGrR+b6ACxiIxOtYWbdBD0DphzjDWKureM6hFGpJBSfzvrhSo/HDMWdHY9VXn4iDDiEqMSky7FiudnIX8T1+GXHpnq0VKZX5LfJ+8FlnTS2XKf++Ctpq0Wj0Eju83fpHU6gjSf+8U0yDmEYWySWNt/vUyhiYcvgB3ly2D1z2FMu7z976cvT+6MvSFLeEh6bSE/xCgxbdU8HL8LGCe/Zseg5QJhhYrcwAXN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Co+P41NSB76aKlJTMXq8HRbk1bk5JCt9ePeM1fX3AXpAIAcJd15LD6vW+k?=
 =?iso-8859-1?Q?atZNtZQr+Ys5qH4oCTPp9jt5mW6A7WcmzB6+xSRaC5S82CtMqxOGj0GcP2?=
 =?iso-8859-1?Q?RJPZsvMNXMKHQ7aUF44dc+P5yV8efTu9+QgeGTxltnzefATkRwztcn8rTi?=
 =?iso-8859-1?Q?38yk79UFVDukXu83rvHYgZ5BCfecPwUYABF18ipa/ZDl/tY0MJamXTR2Oi?=
 =?iso-8859-1?Q?ICh5zqzC8Jcg8/bShFgeIv+gR14BTWM73Hvwai2Ny5t5s4C7D3+L5gpNOK?=
 =?iso-8859-1?Q?t9jbcc2ho0bNBusZkTho6ACqGnIxpPpQcFLNAYxK8DG4UXMRaVJCZWPAxA?=
 =?iso-8859-1?Q?+9IKyMQG677WlzQdgztaUrvaO4yHWAQkvghyXlsys8iQLx8FtxTPBexma5?=
 =?iso-8859-1?Q?ue5n+8fLmQZCOuLWSgg93gFjklzDGlZY82C4mlOftjixD9c2MyDRlx07q0?=
 =?iso-8859-1?Q?M79+kX3wURouGm4Uh2lImYiRfOQsV21bhqe1gcMfZ8/uusU7frr8dj9tpd?=
 =?iso-8859-1?Q?PsoPbuWxbY6YdVApsOLmnFWJR2gtXAzs7tDsN3BTgyUrHhc8ytkIt0EaOr?=
 =?iso-8859-1?Q?TWY4FUXLf/VmprQShtzhDIh0Tl3ATZMXqtl6TvKrHK5mK/fdMWZ6yKwYh2?=
 =?iso-8859-1?Q?KwwwBC/LC5JrqqKF/a6Lq7aJqRg3LS6bicrDt3MBdKGDU9YqxHve4X+dYu?=
 =?iso-8859-1?Q?Fh59UmlkELrdSjWWn6gTpSHFcJX6StaErX/g+jKKKpAstlildbTptUzuHk?=
 =?iso-8859-1?Q?Uy8RK7ON1+RmX/wfAvRSpV0nh4dm6FW+HG7Gmb9PCkFgQyJTM7GNUskCqP?=
 =?iso-8859-1?Q?J+h3DYhXbzVvmKZiDC4xZAyR/z4J27X6J+wdiqcAZBEzqPVkG+4iggni5Z?=
 =?iso-8859-1?Q?+t/YVjmcei09jgSe4deL3AVX5vKOczHleFt/2XIu8VWpW+T9iJTj+wIK1/?=
 =?iso-8859-1?Q?GGvkxf/NmzdPcJXIi2meqpy572py3YO4kiRRR5zt1oL47CCj61SAYVqBMR?=
 =?iso-8859-1?Q?2bKp71ahGXsqWTIDGRTETPEzaa7d56Ds+JdXOuwXCzD9jB8iCF201Oeabq?=
 =?iso-8859-1?Q?vl2iWkJkXPXvOBqYsMx7rZNdO2TQkgD69mXBkZBLMMIq4CS+M4DsrU6bHh?=
 =?iso-8859-1?Q?1mffXR4MrEatCijBOyhdqxmjy1uIkUD0UtCN7gxwoWt4Yuj8geCl96dV+J?=
 =?iso-8859-1?Q?swsjb0zXUajToy5pDmkAmkAi10ReTYR63rm9HJzXORNy0wZjNUqS4a2WgV?=
 =?iso-8859-1?Q?sVyKsDqi0o4lKtGbZUO+hqm2MnPNkawQ8gQ9aVPgCwEFxFT7DpQfURP6k3?=
 =?iso-8859-1?Q?EsAT+f1BMW1r6NkVowM9vZEdZYW1xUSViErzJefqyooacJ99u9P50EfXJU?=
 =?iso-8859-1?Q?6GSeO3w4PTwMFuQfHR8ka40xd7O1wxwYOOxH5eMYT2T923G/rnWoR7harh?=
 =?iso-8859-1?Q?zCZpmaCkBL0jwOHxEi54QU8ScCR/BwQnV9Mo8Q8x5ZGCdNXAWzH0ZgDPnk?=
 =?iso-8859-1?Q?dK42Lsmd830VBavxA4ITBtavMZZFq69EFJ7genn3xvcmD1h/Zo93/zwnTa?=
 =?iso-8859-1?Q?Wm1uVZlICN2zW7LmFdNx37PdplX3q689Y66/OM/umh6ypUXh4wUyxxKWmk?=
 =?iso-8859-1?Q?yiv02ovlK9CMB6VjSnNwdhfc+6vOxXpHas7IDbp609x8sapKdLQSpcvJkb?=
 =?iso-8859-1?Q?yO9ch5cggMItoCaUz097+M8hJKMNFW+Zuj50BG5ADBxhVdPNir5MsLXYH3?=
 =?iso-8859-1?Q?gHw+A+ok1UmHYihspS5lYa3FkihqrRaz4vOEabnTZ37ZL6CNU9J/KJFDnN?=
 =?iso-8859-1?Q?bnxLxZwOIA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MVPaLLEPQOnT/RcSm3scLTd/hxChHbtoiKA3rGQcvvA9fnz1CZ5vf0BEgdrTe+6xfCT3yXC7p7JJRyHrmLMk9t4X+6BX9iI1j5AgU+igd2X+1T60YL2HsFFAJsk/I7aBEZAYsnDCJzXq1PZmRI0IbvKlbJKC6S/uGMRfJEiWoEKIY0nh0Lw+33D0SEFdSvQmKtlunKmc9kIZeXM4MJYXegm0SvAdmrTU6HPq4dQ4WGZ8pXWsWCYI+KJubsGT3w1IAlGj5JgGeyXsp7A/DqGicc2mKyAul039CRlwJ2K4BwtFFUBjwDnNPonsUY+bv9s6sRvmJ7XD71Fxul/+h255eA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79a2412-3910-43ea-b807-08dee1799465
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:03.0115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNgHwWijKCiByhslRMOP+16wpxd+qQcxiZywOr4oi0J4WxURQGuEEp7DNypJ/3YGtG4qeGkTQ7HyKFYsyb61n1GUylu48X7/WZ7CUXLysSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
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

The crypt command register was previously stubbed out. Implement it for=0A=
the direct access mode, where HACE00/HACE04 point directly at contiguous=0A=
source and destination buffers. AES-128/192/256, DES and 3DES are=0A=
supported in ECB and CBC modes via the qcrypto cipher API; the IV and=0A=
key are read from the context buffer (HACE08) and, for CBC, the=0A=
resulting chaining IV is written back to the context.=0A=
=0A=
The completion interrupt is now raised for every HACE variant as the=0A=
hardware does, which fixes the crypt command hang on the AST2500, AST2600=
=0A=
and AST1030. The AST2700 crypto engine still needs 64-bit DMA and=0A=
AES-GCM, which are added later, so it keeps its temporary interrupt-only=0A=
workaround until then.=0A=
=0A=
For debugging, the context, source and destination buffers are dumped=0A=
through the existing aspeed_hace_hexdump trace event (disabled by=0A=
default). CTR mode, scatter-gather mode and AES-GCM are added separately.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 276 +++++++++++++++++++++++++++++++++++++++---=0A=
 1 file changed, 262 insertions(+), 14 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index c61efe50c4..42d8b38be3 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -18,11 +18,44 @@=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "crypto/hash.h"=0A=
+#include "crypto/cipher.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/core/irq.h"=0A=
 #include "trace.h"=0A=
 =0A=
-#define R_CRYPT_CMD     (0x10 / 4)=0A=
+/* Crypto engine registers */=0A=
+#define R_CRYPT_SRC         (0x00 / 4)=0A=
+#define R_CRYPT_DEST        (0x04 / 4)=0A=
+#define R_CRYPT_CONTEXT     (0x08 / 4)=0A=
+#define R_CRYPT_DATA_LEN    (0x0c / 4)=0A=
+/* HACE0C[27:0] holds the crypto data length */=0A=
+#define  CRYPT_DATA_LEN_MASK    0x0FFFFFFF=0A=
+#define R_CRYPT_CMD         (0x10 / 4)=0A=
+/* Crypto engine command register (HACE10) bits */=0A=
+#define  CRYPT_CMD_ENCRYPT          BIT(7)=0A=
+#define  CRYPT_CMD_ISR_EN           BIT(12)=0A=
+#define  CRYPT_CMD_DES_SELECT       BIT(16)=0A=
+#define  CRYPT_CMD_TRIPLE_DES       BIT(17)=0A=
+#define  CRYPT_CMD_SRC_SG_CTRL      BIT(18)=0A=
+#define  CRYPT_CMD_DST_SG_CTRL      BIT(19)=0A=
+/* Operation mode HACE10[6:4] */=0A=
+#define  CRYPT_CMD_OP_MODE_MASK     (0x7 << 4)=0A=
+#define  CRYPT_CMD_ECB              (0x0 << 4)=0A=
+#define  CRYPT_CMD_CBC              (0x1 << 4)=0A=
+/* AES key length HACE10[3:2] */=0A=
+#define  CRYPT_CMD_AES_KEY_LEN_MASK (0x3 << 2)=0A=
+#define  CRYPT_CMD_AES256           (0x2 << 2)=0A=
+#define  CRYPT_CMD_AES192           (0x1 << 2)=0A=
+#define  CRYPT_CMD_AES128           (0x0 << 2)=0A=
+=0A=
+/*=0A=
+ * Crypto context buffer layout (HACE08). The IV is at the start of the bu=
ffer=0A=
+ * (DES places its 8 byte IV at offset 8) and the cipher key at offset 0x1=
0.=0A=
+ */=0A=
+#define CRYPT_CTX_IV_OFFSET         0x00=0A=
+#define CRYPT_CTX_DES_IV_OFFSET     0x08=0A=
+#define CRYPT_CTX_KEY_OFFSET        0x10=0A=
+#define CRYPT_CTX_SIZE              0x30=0A=
 =0A=
 #define R_STATUS        (0x1c / 4)=0A=
 #define HASH_IRQ        BIT(9)=0A=
@@ -501,6 +534,209 @@ static void do_hash_operation(AspeedHACEState *s, int=
 algo, bool sg_mode,=0A=
     }=0A=
 }=0A=
 =0A=
+static bool crypt_aes_alg(uint32_t cmd, QCryptoCipherAlgo *alg, size_t *ke=
ylen)=0A=
+{=0A=
+    switch (cmd & CRYPT_CMD_AES_KEY_LEN_MASK) {=0A=
+    case CRYPT_CMD_AES128:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_128;=0A=
+        *keylen =3D 16;=0A=
+        break;=0A=
+    case CRYPT_CMD_AES192:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_192;=0A=
+        *keylen =3D 24;=0A=
+        break;=0A=
+    case CRYPT_CMD_AES256:=0A=
+        *alg =3D QCRYPTO_CIPHER_ALGO_AES_256;=0A=
+        *keylen =3D 32;=0A=
+        break;=0A=
+    default:=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Decode the crypto command register into a libqcrypto algorithm/mode pai=
r=0A=
+ * and the block/IV geometry. Returns false for unsupported selections.=0A=
+ */=0A=
+static bool crypt_decode_cmd(uint32_t cmd, QCryptoCipherAlgo *alg,=0A=
+                             QCryptoCipherMode *mode, size_t *keylen,=0A=
+                             size_t *blocklen, size_t *iv_offset)=0A=
+{=0A=
+    if (cmd & CRYPT_CMD_DES_SELECT) {=0A=
+        *blocklen =3D 8;=0A=
+        *iv_offset =3D CRYPT_CTX_DES_IV_OFFSET;=0A=
+        if (cmd & CRYPT_CMD_TRIPLE_DES) {=0A=
+            *alg =3D QCRYPTO_CIPHER_ALGO_3DES;=0A=
+            *keylen =3D 24;=0A=
+        } else {=0A=
+            *alg =3D QCRYPTO_CIPHER_ALGO_DES;=0A=
+            *keylen =3D 8;=0A=
+        }=0A=
+    } else {=0A=
+        *blocklen =3D 16;=0A=
+        *iv_offset =3D CRYPT_CTX_IV_OFFSET;=0A=
+        if (!crypt_aes_alg(cmd, alg, keylen)) {=0A=
+            return false;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    switch (cmd & CRYPT_CMD_OP_MODE_MASK) {=0A=
+    case CRYPT_CMD_ECB:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_ECB;=0A=
+        break;=0A=
+    case CRYPT_CMD_CBC:=0A=
+        *mode =3D QCRYPTO_CIPHER_MODE_CBC;=0A=
+        break;=0A=
+    default:=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Direct access mode: the source/destination register (HACE00/HACE04) poi=
nts=0A=
+ * at a single contiguous buffer in DRAM. Copy @len bytes between it and t=
he=0A=
+ * bounce buffer @buf; when @to_dram is true @buf is written out, otherwis=
e it=0A=
+ * is read in. Returns true on success.=0A=
+ */=0A=
+static bool crypt_prepare_direct(AspeedHACEState *s, uint64_t addr,=0A=
+                                 uint8_t *buf, uint32_t len, bool to_dram)=
=0A=
+{=0A=
+    return !address_space_rw(&s->dram_as, addr, MEMTXATTRS_UNSPECIFIED,=0A=
+                             buf, len, to_dram);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the so=
urce=0A=
+ * and destination are single contiguous buffers (HACE00/HACE04) and the I=
V/key=0A=
+ * come from the context buffer (HACE08). For CBC the resulting chaining I=
V is=0A=
+ * written back to the context buffer so the driver can continue the chain=
.=0A=
+ */=0A=
+static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)=0A=
+{=0A=
+    uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];=0A=
+    bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;=0A=
+    g_autoptr(QCryptoCipher) cipher =3D NULL;=0A=
+    g_autofree uint8_t *src_buf =3D NULL;=0A=
+    g_autofree uint8_t *dst_buf =3D NULL;=0A=
+    uint8_t ctx[CRYPT_CTX_SIZE];=0A=
+    Error *local_err =3D NULL;=0A=
+    QCryptoCipherMode mode;=0A=
+    QCryptoCipherAlgo alg;=0A=
+    const uint8_t *next_iv;=0A=
+    uint64_t ctx_addr;=0A=
+    uint64_t src_addr;=0A=
+    uint64_t dst_addr;=0A=
+    size_t iv_offset;=0A=
+    size_t blocklen;=0A=
+    size_t keylen;=0A=
+=0A=
+    if (len =3D=3D 0) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!crypt_decode_cmd(cmd, &alg, &mode, &keylen, &blocklen, &iv_offset=
)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: Unsupported crypt command 0x%x\n", __func__, cm=
d);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* Fetch the IV and key from the context buffer in DRAM. */=0A=
+    ctx_addr =3D s->regs[R_CRYPT_CONTEXT];=0A=
+    if (address_space_read(&s->dram_as, ctx_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                           ctx, sizeof(ctx))) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to read context, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
+                      __func__, ctx_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("context", (char *)ctx, sizeof(ctx));=0A=
+    }=0A=
+=0A=
+    cipher =3D qcrypto_cipher_new(alg, mode, ctx + CRYPT_CTX_KEY_OFFSET, k=
eylen,=0A=
+                                &local_err);=0A=
+    if (cipher =3D=3D NULL) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher new failed: %s\=
n",=0A=
+                      __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (mode !=3D QCRYPTO_CIPHER_MODE_ECB &&=0A=
+        qcrypto_cipher_setiv(cipher, ctx + iv_offset, blocklen,=0A=
+                             &local_err) < 0) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto cipher setiv failed: %=
s\n",=0A=
+                      __func__, error_get_pretty(local_err));=0A=
+        error_free(local_err);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    src_buf =3D g_malloc0(len);=0A=
+    dst_buf =3D g_malloc0(len);=0A=
+=0A=
+    src_addr =3D s->regs[R_CRYPT_SRC];=0A=
+    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to read src, addr=3D0x%" HWADDR_PRIx "\n=
",=0A=
+                      __func__, src_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("src", (char *)src_buf, len);=0A=
+    }=0A=
+=0A=
+    if (encrypt) {=0A=
+        if (qcrypto_cipher_encrypt(cipher, src_buf, dst_buf, len,=0A=
+                                   &local_err) < 0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: encrypt failed: %s\n",=0A=
+                          __func__, error_get_pretty(local_err));=0A=
+            error_free(local_err);=0A=
+            return;=0A=
+        }=0A=
+    } else {=0A=
+        if (qcrypto_cipher_decrypt(cipher, src_buf, dst_buf, len,=0A=
+                                   &local_err) < 0) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: decrypt failed: %s\n",=0A=
+                          __func__, error_get_pretty(local_err));=0A=
+            error_free(local_err);=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
+    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: Failed to write dst, addr=3D0x%" HWADDR_PRIx "\=
n",=0A=
+                      __func__, dst_addr);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (trace_event_get_state_backends(TRACE_ASPEED_HACE_HEXDUMP)) {=0A=
+        hace_hexdump("dst", (char *)dst_buf, len);=0A=
+    }=0A=
+=0A=
+    if (mode =3D=3D QCRYPTO_CIPHER_MODE_CBC) {=0A=
+        /*=0A=
+         * CBC chains on the last ciphertext block: the final block of the=
=0A=
+         * output when encrypting, or of the input when decrypting. Write =
it=0A=
+         * back as the IV for the next request.=0A=
+         */=0A=
+        next_iv =3D (encrypt ? dst_buf : src_buf) + len - blocklen;=0A=
+        if (address_space_write(&s->dram_as, ctx_addr + iv_offset,=0A=
+                                MEMTXATTRS_UNSPECIFIED, next_iv, blocklen)=
) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: Failed to write IV, addr=3D0x%" HWADDR_PRIx=
 "\n",=0A=
+                          __func__, ctx_addr + iv_offset);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int s=
ize)=0A=
 {=0A=
     AspeedHACEState *s =3D ASPEED_HACE(opaque);=0A=
@@ -531,16 +767,22 @@ static void aspeed_hace_write(void *opaque, hwaddr ad=
dr, uint64_t data,=0A=
                 qemu_irq_lower(s->irq);=0A=
             }=0A=
         }=0A=
-        if (ahc->raise_crypt_interrupt_workaround) {=0A=
-            if (data & CRYPT_IRQ) {=0A=
-                data &=3D ~CRYPT_IRQ;=0A=
+        if (data & CRYPT_IRQ) {=0A=
+            data &=3D ~CRYPT_IRQ;=0A=
 =0A=
-                if (s->regs[addr] & CRYPT_IRQ) {=0A=
-                    qemu_irq_lower(s->irq);=0A=
-                }=0A=
+            if (s->regs[addr] & CRYPT_IRQ) {=0A=
+                qemu_irq_lower(s->irq);=0A=
             }=0A=
         }=0A=
         break;=0A=
+    case R_CRYPT_SRC:=0A=
+    case R_CRYPT_DEST:=0A=
+    case R_CRYPT_CONTEXT:=0A=
+        data &=3D ahc->src_mask;=0A=
+        break;=0A=
+    case R_CRYPT_DATA_LEN:=0A=
+        data &=3D CRYPT_DATA_LEN_MASK;=0A=
+        break;=0A=
     case R_HASH_SRC:=0A=
         data &=3D ahc->src_mask;=0A=
         break;=0A=
@@ -589,13 +831,19 @@ static void aspeed_hace_write(void *opaque, hwaddr ad=
dr, uint64_t data,=0A=
         break;=0A=
     }=0A=
     case R_CRYPT_CMD:=0A=
-        qemu_log_mask(LOG_UNIMP, "%s: Crypt commands not implemented\n",=
=0A=
-                       __func__);=0A=
-        if (ahc->raise_crypt_interrupt_workaround) {=0A=
-            s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
-            if (data & CRYPT_IRQ_EN) {=0A=
-                qemu_irq_raise(s->irq);=0A=
-            }=0A=
+        /*=0A=
+         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM, which a=
re=0A=
+         * added later; until then it keeps the temporary workaround of on=
ly=0A=
+         * raising the completion interrupt without running the command.=
=0A=
+         */=0A=
+        if (!ahc->raise_crypt_interrupt_workaround) {=0A=
+            do_crypt_operation(s, data);=0A=
+        }=0A=
+=0A=
+        /* Hardware raises the crypt interrupt once the command finishes. =
*/=0A=
+        s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
+        if (data & CRYPT_CMD_ISR_EN) {=0A=
+            qemu_irq_raise(s->irq);=0A=
         }=0A=
         break;=0A=
     case R_HASH_SRC_HI:=0A=
-- =0A=
2.43.0=0A=


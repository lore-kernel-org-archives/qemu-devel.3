Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01838CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoh1-0001ua-5b; Wed, 30 Sep 2026 03:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogy-0001tZ-1j; Wed, 30 Sep 2026 03:25:28 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogw-000289-BG; Wed, 30 Sep 2026 03:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjzH3t5PRpUhzmznLYL27eYo9bdIrg96/GfWRHTeZt8lDKhu60HCUT3Pv0eWUX4GIzbV2TO+0YrQxqTgCLPfVkTC0z0q7v0dDQK4YatfJcO6+jZcCHgpFugBQsSSMwFPSqXPYw8Z2olAOZowDoHKlFy2kepyUkBVLc7kZQWlRqixN6ORoaQfKOsZqjV6l2oIFfcNYzkBTmBtaTE3OxEyaSRaGU0aAw7M6tLkfL8dgFzdam0QU9U/H47SCWPSob7kwpB13XWA+VITiM78LlSJeEb+hNWSShycJMjiCsFjBnrrq5WQwkau2JxGWPhakIuYY/BGKDjnqulfycDGA6R0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueZDCriK8glf+eGQkFttTFXCxpcGFHtDy0S1Q4lnlBw=;
 b=Js56Q9HJhPa3K7au3DwV1HSF6We746+t+BrQlfec9Le9Fvpkiaw1xMsSbOqGxpuTG1Ld1EbqWpIr6xTNwsdBiTnQ5YWsMg+s+3D1vWWhjRl0k6vMuoYY3GjK7gQjdOnU/+28u8m+gszwE9LqHcb2j0f8bL6eNEGuC+/j0ycjDfSQMEexx6iEqhUVqpFzWhQTOsfY+iwJzqH8Gh1ZkvEWAjj7xwRpGwIJWlQ/kw9d6q4tp9bl7sLq9I89i5bfzB7UI6zw98B+oQitM2jNl8JHhJcxf0ii73ZMxZyGx/961sz4TesNvHAfbSsxyNwCB7cfjsJCPlg+yU32bn4l8fIaEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueZDCriK8glf+eGQkFttTFXCxpcGFHtDy0S1Q4lnlBw=;
 b=Jl/szktYrKUHFAPFIQdyA0LYFDXm5tvDwEKg+CFeWLjtoNnnBjDzwxUbRfru0Uzyr4dtHjMFfyejiDkvouIk/BjT8S30Nz/8naTKeaJXnokVQhumNUuuAqwCAQpsqtS+z6gmJNlMrkXGm6qi1jf8PuVPNnFJR78DwGhbotSFw5BENQxOJ/Vme48Kkhp7JaS3Xd2+V2EI9Dhx85WilS25gHsv1f1ek/Vq5TBGcyd3QaHcNihvhHIl/k0A+Om4d+/jC2YptOHAHGreLrk4BK919j/Mn8VblAhbt1NZawFg9PIYdWK4cTMJxURfl9BtCmiPpMPNZwHws9IcTL3mNAmffg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6616.apcprd06.prod.outlook.com (2603:1096:101:168::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:12 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 09/11] hw/arm/aspeed_ast1700: Use unimp array and table for
 unimplemented devices
Thread-Topic: [PATCH v1 09/11] hw/arm/aspeed_ast1700: Use unimp array and
 table for unimplemented devices
Thread-Index: AQHdUKzUwtsvOMaCf0qXZCulqeTZAw==
Date: Wed, 30 Sep 2026 07:25:12 +0000
Message-ID: <20260930072501.2612119-10-jamin_lin@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6616:EE_
x-ms-office365-filtering-correlation-id: 2013e667-2dda-4e64-9f24-08df1ec3f764
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: C+T7NPE+b2LBz1YgwABVpTb/qQBnIVXRbTFQdx0dkphtJwtQfOYc5dSE5+tiAnzCfBFa46HHeOZZcZldsf9I42+sPzgM9WRywE92cCW4P0ntZmp73CAh+LABanHwycC0NlHLTwLO2A3Jxy1uI5hry4WXX5tB64wzrZvflqUHaL2AFdky+cvsnknyOrePBXGrPcSfSi+PcGbLBPS62JiczNrKMJtQ7gUQTTqHMB0wLIQEQWytaBmKd3hvJp7Y8hqOUeMAZl4ht13zje0Q7YkJ7kiVN/HxJo9zpR8awzIwazXA5oBq6/RFKHsXMg2JDSd9726YRfbQYXV7O89Kk15YoGN30ugZPtllvN5CVeAXhYahvDpu05Fh/pPXb4YkEpEdEriZjbGPVTrppON9zLzobT+LHKEY0cc1mWNiGQaYj9qN89Ko3XLPB9By4rlLQO60uwAjv2ALepkH0uQPEJp+NMPqmnmUaxwI4MdtPvgcia/yObodwvHW1wmgTDKSvWi9eA7CQQ4TJUgzFmuqt/iNnwWD2BAtFYLnYaiTKJVdAe4XtcuuM8ZY94D8PVD5V367nOeEVxAlkidWqvgWEmMBWphcax3i6EOOfPbAb/hj0Z0ZhiHwHmzWe4ZCZhWHMyNuESQLBWqh1+3WlsEGecGj6HLzbCzlWIAcnn/eMCEFxiEM5V7ouBuvMEqQB0+83INp+/eng8nFJhBRFUUFzmsyiQCpmTmBo12bR4qsBiwi9zk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TYL+WfvNkeF4Ac0nKM8h67NgYkTeVnt42ZlBlchuVUWNY2L7WmsFv70QJE?=
 =?iso-8859-1?Q?7hKqDQ82o5fPXgARUwqSUf7zr16pvrLUD18CRkr/q8fXFzBeyPWhxiTZwE?=
 =?iso-8859-1?Q?8SwZM7eDgYx+4Tn3YCpa/tqj+5YEE/gvfi/sdqMd8QhhkS8iAAgPXNfwTv?=
 =?iso-8859-1?Q?fds5apQw+9CMA2YV/aQ8yjdfkn4EnK6E4KBvVH/0pZIpobl0kadxiI70RL?=
 =?iso-8859-1?Q?gpoEtkpX/UJoiw9/8hZSSPSeItgEjHAs2OQJ8zm0O/zqKlL+8cO7dA5sbm?=
 =?iso-8859-1?Q?eS4kNRN9QX+H/espeT6iPekK7clBZHkXB0GPqvdaq9SNNfwk/OIaCZasqN?=
 =?iso-8859-1?Q?zY9Upq/wUEHOI7HRII8bLGjgbU88MfmVNNdNUw+h4f632/pfykgazUDBWI?=
 =?iso-8859-1?Q?B9iwmNtdhiOoVVq9J46nHJpkF7YRaWTXnQhUp57AeGU8KOrP56Galpbc0f?=
 =?iso-8859-1?Q?Yk3UAis7PmOtJ8sTsm4xSPqA6SpSIUUy1pA96q1B2usfLb27f6XKsiCfPu?=
 =?iso-8859-1?Q?YcUVLAu6ebBjk9PX8FEH9AH/QU3DJ668D7Zzkz6IIJ2+FMy0IrENyZf/lk?=
 =?iso-8859-1?Q?Q1Z0DX44GyxOM1fPeV7aSti+0l9Z7Q7BE0IW1Uae9rsOnAlyg6EdgQCSBQ?=
 =?iso-8859-1?Q?SYH1Bh/sx5/3NoEMAQeKq8eKK4BPqh/4e2UsJe5PRxg7dYdrI11dK69lZe?=
 =?iso-8859-1?Q?+8PcNi1Fvr3c+FxbusZ0mmbFbQwfLE5bBrA4LTkiSTtBM9AQqMTnjmfgM6?=
 =?iso-8859-1?Q?rImcjUGa3FSl9OMSTJPiQnVl4Ml+23ZRVOUFehQEUXBr/ufaY6w0oUGIUl?=
 =?iso-8859-1?Q?opjplhXW+aj/aDCUL+5V1HDfK3qm/m8Pz5cw4zNeCNSuT9ITZHFp0DXZuQ?=
 =?iso-8859-1?Q?YB1WEH8mtG1HpF5+n2CYE86JNqzuJhikRz3dV1oKF+qno0tvUUdg7TFh2L?=
 =?iso-8859-1?Q?N5xL+6U21zg5hte5rdM2boGOcEToitCdxQZFy1Ish9qNbYAG+Lg7K2VBIA?=
 =?iso-8859-1?Q?P7SFAGn/dg6GOgC02EOF6111Z2Rj2+8BN3BnbZj/5/YrMMi+AxHn3hbKxx?=
 =?iso-8859-1?Q?lwInOwzohbdtac2p6/9k7V6Q1o18vLyX+4Fqsw04qG9TJzHokPWSwGgkoL?=
 =?iso-8859-1?Q?1YDe8JV5Nuo7SmYkmAZYZdSgbSZ1RLB1QKLb1zsLcTa0pK5YxSSij10j9g?=
 =?iso-8859-1?Q?ABr2pAxHnrAbOoblMgB5cUxDGI2N6Z5xf5Z9UGdDgl5GT09u5+BhpDTVDz?=
 =?iso-8859-1?Q?1YDCkxMD4FKKH/uCqqaE05YqQ6oMJISIWchGK6c2lr5fj8ioI1M6UIC8fi?=
 =?iso-8859-1?Q?9Z8JBvwpZGpcr5Ei+GXw8gmLNt5ifD5NZP1CC7dKYpOM6I6EpHQIok4nos?=
 =?iso-8859-1?Q?nRjjc1k/umLhkbFPSgJvyCXzUzpeJkY3aPgk6Tmonx9IyDdIFH9p/o9ZVe?=
 =?iso-8859-1?Q?GMX1GQay5PAdvNR2CT/m6vKDpii+KVR8yt6qQWE0TQ9yBeBUfu9VNEbC2U?=
 =?iso-8859-1?Q?9ur212Nh2pARBECXPoNSagSyWnmbVRHhVJuTd4a9xjVghZ0D3cvYXluRHf?=
 =?iso-8859-1?Q?WeRs2vfxQMxnQyduqB3s9UUgMrCBCeHc+a3NqnIuIfXsVCP9OTBG3VzLoW?=
 =?iso-8859-1?Q?HCTbHcvyVmCLrvtESiUvVlOjNEBIABuuzMX6ejP/Nv41ChsKzdUK+WYPt7?=
 =?iso-8859-1?Q?IUvjgCPihC+atdJQCGmqYTFGhyJg7UqoZwYmoZylR2WOgiBQ8s1zcF/COB?=
 =?iso-8859-1?Q?JVtcqsrD5OgciamFDZX9gVUp7v0AxvGm7BWXmgB1PJPAi90eccSpTnO/6m?=
 =?iso-8859-1?Q?3RdbvYAZAA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iZbEIaWcPrP+g9lq6ysEMJxsTbLfqpWb60v8IOaAUMSYAfVXWBAaQfZ3KEGEDug4t5r2X0KSDBq45tOTVpetkufavghNxQcu69/1RsOzxy2ye5yTv2O5endSRluev1aroI/hTYmuXYpFmOsWyn7Ca+XudoO2YNwmrqNN3e6FK8nlX9aA9YQ/2qHX1CfvfFaMLHAbj4vrIF2qVAL+SUwaMTcuSgpnkvu4JbZZTW2DoGUmDvZpXFpmfblBTykCb+wty1jFWmV/D4xQWY32+h2VHUBSRKeVbUtm0Syx8P0wNeVxhgU1f8SU5poNB2vhZzurptLYjnLlCB39H7ard+Y1SA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2013e667-2dda-4e64-9f24-08df1ec3f764
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:12.7281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxwzyg3vUZQxvFRgfgLg9i1pslkdQcQxWrJq/Hyzf2pP5WywR1+WSp34FKePABDDORfGi/mLPCT2wvohRj1QmcV/9KH0j42aIR2E3yV8XKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6616
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

Before this change, each unimplemented device needed its own field in=0A=
AspeedAST1700SoCState. This made the code hard to maintain.=0A=
=0A=
Add an "unimp" array in AspeedAST1700SoCState for all unimplemented=0A=
devices, and use the AspeedUnimpDevice table to describe them. This=0A=
makes the code easier to maintain and read. Convert AST1700 to use=0A=
them.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 ++=0A=
 hw/arm/aspeed_ast1700.c         | 42 ++++++++++++++++++++-------------=0A=
 2 files changed, 28 insertions(+), 16 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index 39c5977cf1..ed9b45e202 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -23,6 +23,7 @@=0A=
 =0A=
 #define AST1700_SGPIO_NUM            2=0A=
 #define AST1700_WDT_NUM              9=0A=
+#define AST1700_UNIMP_NUM            1=0A=
 =0A=
 #define TYPE_ASPEED_AST1700 "aspeed.ast1700"=0A=
 =0A=
@@ -49,6 +50,7 @@ struct AspeedAST1700SoCState {=0A=
     AspeedWDTState wdt[AST1700_WDT_NUM];=0A=
 =0A=
     UnimplementedDeviceState i3c;=0A=
+    UnimplementedDeviceState unimp[AST1700_UNIMP_NUM];=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index 5af5da5b8a..f926851166 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -12,10 +12,10 @@=0A=
 #include "qapi/error.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "hw/arm/aspeed_ast1700.h"=0A=
+#include "hw/arm/aspeed_soc.h"=0A=
 =0A=
 #define AST2700_SOC_LTPI_SIZE        0x01000000=0A=
 #define AST1700_SOC_SRAM_SIZE        0x00040000=0A=
-#define AST1700_SOC_I3C_SIZE         0x00010000=0A=
 =0A=
 enum {=0A=
     ASPEED_AST1700_DEV_SPI0,=0A=
@@ -51,11 +51,18 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,=0A=
 };=0A=
 =0A=
+static const AspeedUnimpDevice aspeed_ast1700_unimp_devs[] =3D {=0A=
+    { "ioexp-i3c", "ioexp-i3c", ASPEED_AST1700_DEV_I3C, 0x00010000 },=0A=
+};=0A=
+QEMU_BUILD_BUG_ON(ARRAY_SIZE(aspeed_ast1700_unimp_devs) > AST1700_UNIMP_NU=
M);=0A=
+=0A=
 static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     AspeedAST1700SoCState *s =3D ASPEED_AST1700(dev);=0A=
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+    const AspeedUnimpDevice *unimp;=0A=
     char dev_name[32];=0A=
+    int i;=0A=
 =0A=
     if (!s->dram_mr) {=0A=
         error_setg(errp, TYPE_ASPEED_AST1700 ": 'dram' link not set");=0A=
@@ -156,7 +163,7 @@ static void aspeed_ast1700_realize(DeviceState *dev, Er=
ror **errp)=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi), 0=
));=0A=
 =0A=
     /* SGPIOM */=0A=
-    for (int i =3D 0; i < AST1700_SGPIO_NUM; i++) {=0A=
+    for (i =3D 0; i < AST1700_SGPIO_NUM; i++) {=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {=0A=
             return;=0A=
         }=0A=
@@ -166,7 +173,7 @@ static void aspeed_ast1700_realize(DeviceState *dev, Er=
ror **errp)=0A=
     }=0A=
 =0A=
     /* WDT */=0A=
-    for (int i =3D 0; i < AST1700_WDT_NUM; i++) {=0A=
+    for (i =3D 0; i < AST1700_WDT_NUM; i++) {=0A=
         AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);=0A=
         hwaddr wdt_offset =3D aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_=
WDT] +=0A=
                             i * awc->iosize;=0A=
@@ -181,19 +188,20 @@ static void aspeed_ast1700_realize(DeviceState *dev, =
Error **errp)=0A=
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]),=
 0));=0A=
     }=0A=
 =0A=
-    /* I3C */=0A=
-    qdev_prop_set_string(DEVICE(&s->i3c), "name", "ioexp-i3c");=0A=
-    qdev_prop_set_uint64(DEVICE(&s->i3c), "size", AST1700_SOC_I3C_SIZE);=
=0A=
-    sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp);=0A=
-    memory_region_add_subregion_overlap(&s->iomem,=0A=
-                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I3C],=
=0A=
-                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i3c), 0)=
,=0A=
-                        -1000);=0A=
+    /* Unimplemented devices */=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_ast1700_unimp_devs); i++) {=0A=
+        unimp =3D &aspeed_ast1700_unimp_devs[i];=0A=
+        aspeed_mmio_map_unimplemented(&s->iomem, SYS_BUS_DEVICE(&s->unimp[=
i]),=0A=
+                        unimp->region_name,=0A=
+                        aspeed_ast1700_io_memmap[unimp->memmap_idx],=0A=
+                        unimp->size);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_ast1700_instance_init(Object *obj)=0A=
 {=0A=
     AspeedAST1700SoCState *s =3D ASPEED_AST1700(obj);=0A=
+    int i;=0A=
 =0A=
     /* UART */=0A=
     object_initialize_child(obj, "uart", &s->uart,=0A=
@@ -227,20 +235,22 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
                             &s->ltpi, TYPE_ASPEED_LTPI);=0A=
 =0A=
     /* SGPIOM */=0A=
-    for (int i =3D 0; i < AST1700_SGPIO_NUM; i++) {=0A=
+    for (i =3D 0; i < AST1700_SGPIO_NUM; i++) {=0A=
         object_initialize_child(obj, "ioexp-sgpiom[*]", &s->sgpiom[i],=0A=
                                 "aspeed.sgpio-ast2700");=0A=
     }=0A=
 =0A=
     /* WDT */=0A=
-    for (int i =3D 0; i < AST1700_WDT_NUM; i++) {=0A=
+    for (i =3D 0; i < AST1700_WDT_NUM; i++) {=0A=
         object_initialize_child(obj, "ioexp-wdt[*]",=0A=
                                 &s->wdt[i], "aspeed.wdt-ast2700");=0A=
     }=0A=
 =0A=
-    /* I3C */=0A=
-    object_initialize_child(obj, "ioexp-i3c", &s->i3c,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    /* Unimplemented devices */=0A=
+    for (i =3D 0; i < ARRAY_SIZE(aspeed_ast1700_unimp_devs); i++) {=0A=
+        object_initialize_child(obj, aspeed_ast1700_unimp_devs[i].qom_name=
,=0A=
+                                &s->unimp[i], TYPE_UNIMPLEMENTED_DEVICE);=
=0A=
+    }=0A=
 =0A=
     return;=0A=
 }=0A=
-- =0A=
2.53.0=0A=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E95F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtQ-0002UF-9K; Thu, 16 Apr 2026 23:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtI-0002O4-0L; Thu, 16 Apr 2026 23:29:12 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtG-0005tG-FX; Thu, 16 Apr 2026 23:29:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVrC7VlRkXQO9y2SGhYvcoxUmWEVW5uAOGGOONQg7RmuEHU6kt1ozNc2BJjLDAcVg5aiqr7eTJqMa72Djve2K4pK9yjicSNN1jekfy2uHvtoFaeFIdqNAwR+/qow2FZugqoxBw2jZJ9C5pQoDzghOPqpHcZslK2qQcEGliHv6z0QLfR/3EhUxHlR2pP9nShU5auHauf/H19/cu9MgcF8QWoBT4zZISkgjCYCS7JJZ0bn8JtNFGdx/YvQ9QF+RMXreIPkmgolRiVJN+PMPl2khU9UrzNTzKC5H4/uHoF0bmuYzLJw9pVjYgiwYWwu32TiGQ9kqPFQi7+RSo9RZdNv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubh+06WXVmh9Q6DKoKW3xA+gkRkA3ip7ZfUfMww3bPw=;
 b=PgNDGXd9nqdRm0sHKk+Vulw/HeXSgRo2ww70qdxUWwVqdloSsfRQuZLySkJfJO9MTOaYKyE6sMIt6kwFU4GnrgEQWWREGxayKkinEZkFbsv58w/pm4VaRo1erBtJHgl7owPDhxgClaxy/9XdatbOGubJ45P4KlIaMzjZAP1sE0LuA77sYnh3l8osC5LkTvUTa9bCJ3sw0K3d99YwMCVzKvISuZMdG0TS1eXim0hDnlAhSvsejCnLVBjjx3agW5LgmrvI+liOdmog7oo2cC4y4BpQDc5GQTKeWRv7h6qP0IaJ94wtPYsDIZOloSOpKryg/OHt6KqPeJzXCFATIMcZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubh+06WXVmh9Q6DKoKW3xA+gkRkA3ip7ZfUfMww3bPw=;
 b=XDpvxvTRyC5z4docMY795N2lCxqnFAI3dmH/1iAX8rInqL3SHOZEkEmhcWvYzINkJORqH6g+rrqNt04/Dz8pCNfFcMr3ab0IGsiIabXivl2PnmJpqmzJIiF8+9xGtcfaJ48ubWmBf0ORnuAUFkK8sKFJge3o6IAGK1DWI6gD3XRVRkfmODlt59L2BS9X/3z4ueptpYnklC12bNDtVLjxRvRfV62lpLw8zQtq9vbTjBYsNw44JPnsIO8AwCmS5QeW+/LGUVRQhIlIjLNLrGcB+IC+sNUANvp99I5QlaNE2DuTeXSSKQbHJdzw85y3gKCSOvBdb+RiytzxMB95dSmXcg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8076.apcprd06.prod.outlook.com (2603:1096:d10:43::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:29:01 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:29:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 17/21] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control
 and data registers
Thread-Topic: [PATCH v4 17/21] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG
 control and data registers
Thread-Index: AQHczhpVrugVxWMklEeYg06fZ9cdhg==
Date: Fri, 17 Apr 2026 03:29:01 +0000
Message-ID: <20260417032837.2664122-18-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8076:EE_
x-ms-office365-filtering-correlation-id: 79f7b7a4-d92d-406c-c9b7-08de9c3177eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: ZXtkHzLGz9tPiuZrjQuCt1dGmlSeGMWsAaq2HHB38j77MuulqbwbB9JjlyqcF+aS0dW3LlCsAxb9zvUAC3ZXVwYYSa5lopOK+JWFJpW+vZCI41qBlcJEiTv1Y+oyeANzBgufzEFxtlcjcoVHW/jhhPY03lLbodvIyYr9HXoPV6eLpaB+luQBCzqJ2fXw5XsHFPEj1iZPqt4C1klOpNlOJMfsx6cbFx7hf0f3936GZLEEmYiO6DCU1bvslEkPXf6pT9BWRwFooO1SonyP8HJJkc4WCYcxM6UQMrJRiDxnz9Tm/76CuA+c+TAMxIy4Mcsi48KsUK7KV7sszzidUj2O2rnTpRpwSfZ4osSK9sQkx6qL+LUFO/QNDmTZCwBmm3b0nq9zIDXiI6B8CAk3dh/4qTnb4lqwIs7claeT3pMejv6m8L+IOSWE73p09aYbvq1xYXYoRG9TwEJ9TxY8wFpf5T7xDFsrWIYZDVrlGeOBtZJqxVTXT7UNzGuKrWhJcNQx7c5dR+zIUAKaTJnWtrBU6D4mJf0sIqlNgfwVEw7MyAsxEx+mAV6Jn9f7i/K09Yg9p0rR7oobvX0rbXR3Gx1xyh3+DcGvs9+iJmtCu8qBqxyDPf8HW1IqrnA0UB+Gd+s3Qg817vBZGqFH5wW8TAY9a0jEdyTkhBw3AUIA4A1MjsN6YdNgax2ccTBh3qu3SPI4Y3gGiiKgxTv0rR1U3kZLCaJ+GNL+zTo5MGsoKGu52qgTLdmXYVDqW1CzS8n0HFgg1ovTagN+r7hN3hBzWWjFhuf+8hZFS1PFERFn/utDTxA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SVK+CRyITIXHYvIzHfaZqmMYMsEcEbdM6rj3/17iiMHBYN+M//LMesT/j5?=
 =?iso-8859-1?Q?BTDC5qfgVHI6bSSd1GGkYcide/7Otstwgr6ff6WBTCJRMuUM71qSPkYzHw?=
 =?iso-8859-1?Q?r2/pS9PbG/AvgBxuLcTbWp9LAFCbx8BiNwPheK5XgB0JR+4KSf6+JEDWM/?=
 =?iso-8859-1?Q?SKBoesNvFpCyNWOfC4WOMq+YOEy7ojjiIfN2qxp6RR/hvRbIlILU9b8bX1?=
 =?iso-8859-1?Q?XjNlyIcwVvRcvAL4SYYQuUGuM0312oJZ2HidoZXLxxFj+IgFig2U31E/Om?=
 =?iso-8859-1?Q?85LPQeqFg86U0LfgoPKE6m4hC/uUXmutrS6SWZEMFDiLOCekTN4ZwkR3Eq?=
 =?iso-8859-1?Q?f4olfDhgxSdHtxacMV1+GfLtR/vnfWNMPF/sQ0Wk2bet7X/s9cLcPVHnGq?=
 =?iso-8859-1?Q?Ej7/cx4cmxRg0Qko7zB04O8iGD129oWwGk96qaSAoFSIrWlhJEyVIoLuKG?=
 =?iso-8859-1?Q?AGZ3gi+K2qrIjk0OXpCMXmYJVPkw4HNU1vOkqgA1NZAUNcynDjkmquSunz?=
 =?iso-8859-1?Q?cozSzIETHhjd/Uz/8KhXiV5cLh/7Fl1OVkUidbGsomo5/iIQvfoVSVBW38?=
 =?iso-8859-1?Q?Z70fOy6/vBCKkFqcmiKReANZ/u+Vg8+Y/G8k8PjCcUEBQDUE8leB+V2F+/?=
 =?iso-8859-1?Q?Onzri/L46WaB8VYOBRaH7KV1pJ25IKRtaJ7hvtX5exV5cFUszQgB6ITg+x?=
 =?iso-8859-1?Q?tcESzsGrQmAtYHmTMO5q95GyQLx58NqTYVC9uJto5pUkuyFSOkzgh8Yvbb?=
 =?iso-8859-1?Q?pwh2cwBGO1V/4h5o9GeRSTfb/LfY7IRVCPVRlOWwtoBKqkJAsVlcUVMgMg?=
 =?iso-8859-1?Q?ASCVQ8asqLpcRZKiF+R9sO1OqNRSwAu9MtM4SB7SqqSxPVEFT+IgiepqyI?=
 =?iso-8859-1?Q?NvxLzbgJacXxfv3eCR1FrBUvA7FvkAW/2U0B0i+/ZKFNxmZ4UEI7esaL5u?=
 =?iso-8859-1?Q?4sYoLv+smAK3Rb6map/BYc/w+1HfB5wtBWeBo5QMMHoYKCOW6J2m4BvJKk?=
 =?iso-8859-1?Q?qC6L9crIASGHFTODpAkxayvY592VpZiNd5ffXmDH0sDGshDJLk1X1DmxAs?=
 =?iso-8859-1?Q?mbpqaaAwqVVfpcTwjxrtNBoPzVkS5ONWA1vghMZD0thmXodJ6GkhhiVL7I?=
 =?iso-8859-1?Q?VNlDvJ1HRU6ZjMbtYNGP6WEyyGB2Gh4BE3kTFILYFiq9CEy5HjLFV/6gP2?=
 =?iso-8859-1?Q?mdmCyZS3P4Ar0srFvM9Cb84PKc+ub490QQX2+LPVYQ1XY9uNwj+KRRw0XQ?=
 =?iso-8859-1?Q?ub3gtKLcm9iGhbCkOhNGiZwrvDxUsFTvqO3Nmi6E+4yIX0FG0nFoPzOG7X?=
 =?iso-8859-1?Q?wWJ8wFYM3AcNkoJXZi7TXJxgVatYrmTC9hP9sULPhyOdxxuyy01sg7t/AV?=
 =?iso-8859-1?Q?I5ugOxQzHpXAOTZWapDbScqoS5RF9yUGgC0dNdoDM1tSyXTZtwvhtBFveh?=
 =?iso-8859-1?Q?UG55DeMIAME9tx2z8mqEohF97lhMKTwbKuSPSvUEYtU7gHTjNGus//HNNR?=
 =?iso-8859-1?Q?0Hutv68TY2YPEFFSD/Ch97o7MW1MqW8mruvBET+wWRQn2eaGx9sYNF6Pi8?=
 =?iso-8859-1?Q?5PMSyUCGXMS4/ynn4fHk+foQEjvNUECPil9s1E6Nx+54hr8Qq6sxpcs1mx?=
 =?iso-8859-1?Q?JT2vV8T9hAVV6hLukVbGVaRnud4kSeWtzeCkuyCmyrP/9kGwS7DQxLtQhj?=
 =?iso-8859-1?Q?Bi1oXBlR4Y4rNiGevT/3olGaA0KfIcVQYLqEmtrZ6DgN91StE8+aj2Ayqm?=
 =?iso-8859-1?Q?z/k2ujc3r+AjhhDXNnmY/Fgm9uNUXUZg+m3xC+kzkcKjoJIZOI7dxrUR8m?=
 =?iso-8859-1?Q?tbcDODaQcw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: clWZqyze5Et1sv4dxJie2dGlQuNGqZ+MOgSLeURShN9moxiCpMrQTwUgcVM5Bv5q/woIPohM84IA1mCTt2YtyzvicnMsByFoy3ZtG9JqxLa1nlgYgDDWBhU500/h0L6LO3uAndjp1iaDcnA6m3Ld+aVjyFqSjn/FYr8toS7iFKBWdteRlzausEb9Tby7sTqXlNAhB7liBvycifSAtbjlXTfq9u4IOz57/ufyFUBU9mAjCL0JbWz1Jg8fRGMeE3suD62V0GPXMPxCDNAemV04gCKQpgTR0km/GpCpcN+INTUsvIB7Sf4ECeoT3WUCsnXRKMMgv259FqzBLovBhLdt/A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f7b7a4-d92d-406c-c9b7-08de9c3177eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:29:01.0627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgovHtBHtLecnOwM6cKcez/NqFSKpS97F0AJusBfssFMBwoINt/HZ5BUueK3ocpn5LyFUPs/ogi4skfFUzuNFb+mjFy4ubN7rz5a3DVwYRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8076
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
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

Implement basic behavior for RNG_CTRL and RNG_DATA:=0A=
=0A=
- RNG_CTRL allows guest to enable/disable the RNG via the DIS bit.=0A=
  Only bits [0:3] and bit 5 are writable; other bits are masked.=0A=
- The VLD bit (bit 31) is updated by the model to reflect the RNG=0A=
  enable state, and is not writable by the guest.=0A=
- When RNG is enabled, reads from RNG_DATA return a newly generated=0A=
  random value.=0A=
- When RNG is disabled, RNG_DATA return 0.=0A=
=0A=
This provides a minimal functional model of the RNG sufficient for=0A=
software that expects readable random data without modeling full=0A=
hardware behavior.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 25 +++++++++++++++++++++++++=0A=
 1 file changed, 25 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 362733ba11..f9ae65d83c 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -187,6 +187,11 @@=0A=
 #define AST2700_SCU_CPU_SCRATCH_1   TO_REG(0x784)=0A=
 #define AST2700_SCU_VGA_SCRATCH_0   TO_REG(0x900)=0A=
 =0A=
+#define AST2700_SCUIO_RNG_CTRL          TO_REG(0xF0)=0A=
+#define AST2700_SCUIO_RNG_CTRL_MASK     0x2F=0A=
+#define AST2700_SCUIO_RNG_CTRL_DIS      BIT(0)=0A=
+#define AST2700_SCUIO_RNG_CTRL_VLD      BIT(31)=0A=
+#define AST2700_SCUIO_RNG_DATA          TO_REG(0xF4)=0A=
 #define AST2700_SCUIO_CLK_STOP_CTL_1    TO_REG(0x240)=0A=
 #define AST2700_SCUIO_CLK_STOP_CLR_1    TO_REG(0x244)=0A=
 #define AST2700_SCUIO_CLK_STOP_CTL_2    TO_REG(0x260)=0A=
@@ -1257,6 +1262,14 @@ static uint64_t aspeed_ast2700_scuio_read(void *opaq=
ue, hwaddr offset,=0A=
         return 0;=0A=
     }=0A=
 =0A=
+    switch (reg) {=0A=
+    case AST2700_SCUIO_RNG_DATA:=0A=
+        if (!(s->regs[AST2700_SCUIO_RNG_CTRL] & AST2700_SCUIO_RNG_CTRL_DIS=
)) {=0A=
+            s->regs[AST2700_SCUIO_RNG_DATA] =3D aspeed_scu_get_random();=
=0A=
+        }=0A=
+        break;=0A=
+    }=0A=
+=0A=
     trace_aspeed_ast2700_scuio_read(offset, size, s->regs[reg]);=0A=
     return s->regs[reg];=0A=
 }=0A=
@@ -1280,6 +1293,18 @@ static void aspeed_ast2700_scuio_write(void *opaque,=
 hwaddr offset,=0A=
     trace_aspeed_ast2700_scuio_write(offset, size, data);=0A=
 =0A=
     switch (reg) {=0A=
+    case AST2700_SCUIO_RNG_CTRL:=0A=
+        data &=3D AST2700_SCUIO_RNG_CTRL_MASK;=0A=
+        if (data & AST2700_SCUIO_RNG_CTRL_DIS) {=0A=
+            data &=3D ~AST2700_SCUIO_RNG_CTRL_VLD;=0A=
+            s->regs[AST2700_SCUIO_RNG_DATA] =3D 0;=0A=
+        } else {=0A=
+            s->regs[AST2700_SCUIO_RNG_DATA] =3D aspeed_scu_get_random();=
=0A=
+            data |=3D AST2700_SCUIO_RNG_CTRL_VLD;=0A=
+        }=0A=
+        s->regs[reg] =3D data;=0A=
+        updated =3D true;=0A=
+        break;=0A=
     case AST2700_SCUIO_CLK_STOP_CTL_1:=0A=
     case AST2700_SCUIO_CLK_STOP_CTL_2:=0A=
         s->regs[reg] |=3D data;=0A=
-- =0A=
2.43.0=0A=


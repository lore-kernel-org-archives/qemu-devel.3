Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E044C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwxt2-0002BY-SU; Thu, 20 Aug 2026 04:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwxt1-0002B0-JO; Thu, 20 Aug 2026 04:12:31 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwxt0-0001n5-1T; Thu, 20 Aug 2026 04:12:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ActhQIGVZGHVeD1Gd932HXQ8u0YEMqqgbgRD/ixRhH9eUizPxNuS/R1QMbyg3Q/Fpo7qdijrxlRhq5lNCiPlLMVgbwVmQfPqjhQnGJTuDMuwikphfluhnSvDPKyg4tni3uiD1xqGTa9XUAUYvFpCt21ioJJ+RY+vtDirUTqI4TSxN1/snsrTdxuIU6R5xlYEuRUsmc30BUMi1Dx0pjnQqKvRazEsLRody/uwwuEuFH9R/D+u5B6YmuYh14ZWyQeT81H2Wbrx1l7sD3mfBcR7L4rHF+qaT7drC2Ap+xIywsL0KoRDufhfqvIzg1CuYtzeUxt3tLrfCsje2Uv7n6nxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE1td2hTZ9vm6g8idVYcayqlIvLuIs/7DS4fD4DfdVU=;
 b=AR1ZAhx4DegRj70zjtBIXXQ4FCedUUhYnpOZVnccCG4jNLtHGFYtNrIhRGHRAQFg7nV6VaXLSsLwda64DlDcsDFoQBjSNyGwbTFbRCO8Nj7Tk8yGZ87V7/gYvGvtQTNENsLN4g9PyzvoBjErWqLglp/qtpqD/EJLkRZ6suWdu9CL/2OkfR+5OttNoyG5MGazTct8+FoGlXWrEBgj+IK7VOwzdqpZ1KGxC0ojREOtf843q2KEjsnoMq8gMTWCul3bKGiGD3kLDqp9/nxKmkX845GyzfivZBhOeZxkOUKWhvTk5lQ8+M1D3RX7r3q+jb9R7LSUyZPCExmo7IlytkYIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE1td2hTZ9vm6g8idVYcayqlIvLuIs/7DS4fD4DfdVU=;
 b=h5V1O2LR63d7nxgKBcG6SRn24RccH/0JxDswRCkOszq7yoNIyhHnz1140+yrO78Jsc+6AFt2CQnfr7+LaUYSr5WCAZzmMLdJkswUkGpjkfHAcs1lC0lC2ic1DI+iSVobOLZHJ4vyz9TO6/uI2biC59GFXOTaWVF3IoZqgFYbJ+zh8lMH96RmwT9P7QmduAj9F3FWqtqIazFAFTNDlefWZpXDBfDyA5RO0/hOiRnNVttMmJ73YnijlIklnMl4Ie0PilL4WXCoWT+PBIEX8DSwvOpEcRl5Yxqh7VLaJJeP0MF4v0P9Qc1axFrciyGRk2wr27IvOuMgkc3JGiPxw7Yalg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5661.apcprd06.prod.outlook.com (2603:1096:400:28e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 08:12:11 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 08:12:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 3/4] hw/arm/aspeed_ast2600: Wire up the ACRY model
Thread-Topic: [PATCH v2 3/4] hw/arm/aspeed_ast2600: Wire up the ACRY model
Thread-Index: AQHdMHua26bF2D6Qkk2Fm6WjmXrk3g==
Date: Thu, 20 Aug 2026 08:12:11 +0000
Message-ID: <20260820081206.3353463-4-jamin_lin@aspeedtech.com>
References: <20260820081206.3353463-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260820081206.3353463-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5661:EE_
x-ms-office365-filtering-correlation-id: ab8d2b97-309b-411f-a184-08defe92bcab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|921020|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: sC0h8morEtuCWt1Nal4T6XiJtzWlghS3+Zp3/8X4uTkVwgAewW1o9vxPuVjVA7tUVBKxiSrolH3RHOzyjEMfTiYgmS+ishSVMHS4/wfce68PWig2Bt8tVkupgB0EBvdjERrUbffI7Qp8JR5Uy6q7E+UQouWc/hUwL8YwIOBRvE7Bg7SRScVArlhHqThhJiLS/GlknzrkdwzEAjQqBCjQZSlROKDIDYkRj6qEwD1PMVzuhTlgRu+5NQN6F0wbMahM2W6tcD4VNqgVcsaB1JhL3jZ+PiFVAwmplZ9FOobGHgYVvSi3qCIivevi/8m565SxfL9rNmG3lGFK4daiddjwLfegYQidKmJC4A2vi1gOL5S0/R3Vy9W8BDBwQ1pD3D5YLOkS1Zfaq8iAScgcKh7mVYgibflUqnpKPfDK/Ca7HW91SlargJt1RelpuUrshxB8nTtEFuEcdZC/+978mAgogkdRGt+bXxBaEvvWbPy5qeIMuwQ4cJoh41hI5/5SdILo34Nu/4YuSXroSgOkMehhWeXGKzotq/mECOpev7l2s2aGIKr+4xJBBEwus2efYqlwVhYagacjayQXStfvrVqIstaGIF06HRsOX6Bn5g2bycnjwiN96XQPWc5N/RE8hb+LJIzZgxa1Wkt6PoQxghNnMwy5N0IdKkXjK+uCpm1pje/grXpUgejf1CdD+kDHn16Gy537LNEsAf9kUWRJMicmuDxQvkEj8QfNJjRuzJpEZrU6yuGwqemovTlbIJfPF4I8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(921020)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?My5fEg6b8WteZ6MlkYtStWMiJMCIHprVwdtiWhXM+gxN2AKPG2/rF3stoh?=
 =?iso-8859-1?Q?HIVWZvnXgb+BkCx4L/CbfpDUQNT2BKBl5+49usu6MGaLueYgWltqC7IIBq?=
 =?iso-8859-1?Q?LJuuBcfVqnm2T7uw5givOdbfYYwqq6MZbDdKnxgQN8TugflFFZIrotUtHC?=
 =?iso-8859-1?Q?XI798qNXMvwJjFJwBWftOo9MowVzze75VvQujPzFuB+846cqVUWtEo4wL9?=
 =?iso-8859-1?Q?Nql84u+5LeFljDX76N2TnJoZgFPogHxJx1LvwMVsCPxSdCts30C4sUpafb?=
 =?iso-8859-1?Q?Xkc2KWiqI8zR+04JAhMGEexVSxG2ffCfsEJJnBP7HaoXXypgbAh1oBLcI3?=
 =?iso-8859-1?Q?NEwZW/jR9ZhSiYxC95zpvKgju0Zc8I6u9jWS5rseC4M7JEiq3tNu+MSHHZ?=
 =?iso-8859-1?Q?Pl3BPCv8EvpBBjSfbOnBpIWIbWb7hDvZiqXB45aWftW8R8pBrudAWqdi7G?=
 =?iso-8859-1?Q?GDM7IfOMgdOMcfyEj3oaYbH6/C567/ntDO8CaZAJvaAsCuPVh8/6sZzZUj?=
 =?iso-8859-1?Q?qyjCv/M59jzfR5bFxlWGX3fFzmmlzuFsT0Al9wL72nix6UZBEZqySh5LUQ?=
 =?iso-8859-1?Q?IM+yutWLUtSOr/p1AW9NfVF0O59rW/OdUc/K4We/f7GRHQRoKLEIp2jPfI?=
 =?iso-8859-1?Q?wVl/kqSxdfbL1A2SKrvuWIoHZMfEsmUh7tHhGlEfKRDaF3Csfw0B7PxpS9?=
 =?iso-8859-1?Q?3n54RxXSW2vM9cV5As4jTqvqiGgrU83bhoa93FZmW5ML8V7wOTSNJfMIPn?=
 =?iso-8859-1?Q?orG7c1aLomIzHJBFRADkEXmjlsrIb/FUqdXXrCxt2lA0fARd380bIGonuB?=
 =?iso-8859-1?Q?G81QQ170NO+GvsUG6Ukye9jS0TQ9z4fYpLuRnX9L2Zrod1hrUqHbWXjNA3?=
 =?iso-8859-1?Q?UF7RRKpzfb6eKNpSJX1ZHph5E6in6b0yRwmxaPeG92WZyz7tZOhceZ0hLq?=
 =?iso-8859-1?Q?OS2sCIeyVKRMmQ27TmfUBVnQx0zH5r9C7mNwNys8Ecg2D/dT4yZX0zd3Hw?=
 =?iso-8859-1?Q?hkyGauNBD6IOc8F2TRqifLJ2E+v36d7Ig/3+CgCEiLfCAEkBb8bz3IHKnR?=
 =?iso-8859-1?Q?nyQpy5ny7aQoe6XYWQhEH/yPE4uAXvymU5pe6HJ5qERyYQQFlDWw+HexJj?=
 =?iso-8859-1?Q?LCPJIYtkdTif195Ab/rp9m3CQ1DyLIUaRdzjqfutpbVcnOZMZVBkols6BC?=
 =?iso-8859-1?Q?aOvY6ryjwWj1Y89uZChEfQq4uscCDeV1U7AvtRs4DNP8xY/fP8MQHeSTnx?=
 =?iso-8859-1?Q?QHPKGww4KP1qX4rOcaXGBnFIntTV8S00/4axMtCd3JYvI4fy0VuuXRGai3?=
 =?iso-8859-1?Q?5DNTyArCdnSRugmDfoLlr2PeZsBOzkSFKF6p+vlAv8Mw0kgbn6oKZ64oYD?=
 =?iso-8859-1?Q?TBH1NpmqT73aFQPtRv63wc53BZ9bEpUPUQBprkRpSU0ndNue14S6/S5L7C?=
 =?iso-8859-1?Q?OXu0cI7Xs99jmpn57gctQjSsCcC7oPiBQ2/wstZ7EvJpQmpkHTavQ+2MRf?=
 =?iso-8859-1?Q?pJ4TSUaWgVgabCaCEVAHczJ2LVyHlbwPMpAujJOZqNPJdZJTbIu5YMliW2?=
 =?iso-8859-1?Q?VykhfgcBreREoTldUHQ0WA2wCvO9AQcBcXYi+vge4hlubh5nLVPp/01byK?=
 =?iso-8859-1?Q?CERZIHgTOPTvU2R4nIRTPBoMscOieQxGWTMjeJbPtrMakH8JEfopDa/Vdm?=
 =?iso-8859-1?Q?eKsDzaDDFDg1mKX5qzd+3ycmX23NbhqEPzIThaDWcO4OHqql4YcRm8eO6D?=
 =?iso-8859-1?Q?BXjF1pUq1shCawnGtQUB28VNR2L31w3Npq7GLqJhbgXV6gbqzDeqbPTlH/?=
 =?iso-8859-1?Q?AD76VoWbhA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ajtqKiGODDBD5jAgjjwjnOhXMb6ZaLVGmS64gyshd+aigLqUjMTF1CMU9oLZGbYA75D32iNAQg++fly101yc2xs0wP65NqGoJ3rGux5CqBnGveJIqBe2s6mLjGNL9DzuJPE6gU6e6VK9+4KTSOaIF2P9QovHRCx2D7sz+Aq26P6dsXPsyonxo84sZT1tsHGu8fJRS3I7EHt72UdpsEGhP0otAlkro41nq+k3N/sqJKczc8SYfZmSM3SwdM7h86gyLsx9E/pO/JQ6xhRM61S10CGErYJe5raUwmyGtLF5yeE3Xon3h5CsY9/C1/5I39zQl7TmLbYFfYnnC4vYftIo3w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8d2b97-309b-411f-a184-08defe92bcab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 08:12:11.6864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPuKPjz3gYNKGaASNldRYG4uvnr3BA99rKhweTG/6aIb8N1ZWZntvnxITPxKHnnAgAM6MwKm2EMsCMeQwvMZ7yr1299q/3sTKXFFF+hdX0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5661
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

Introduce the ASPEED_DEV_ACRY enum slot and add the ACRY model state=0A=
to AspeedSoCState.=0A=
=0A=
Instantiate the new ACRY model on the AST2600 SoC using its=0A=
real-silicon register address and IRQ:=0A=
=0A=
- ACRY register region 0x1e6fa000-0x1e6fafff=0A=
- IRQ 160=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h |  3 +++=0A=
 hw/arm/aspeed_ast2600.c     | 17 +++++++++++++++++=0A=
 2 files changed, 20 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 46e7854727..8d80f16705 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -25,6 +25,7 @@=0A=
 #include "hw/i2c/aspeed_i2c.h"=0A=
 #include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
+#include "hw/misc/aspeed_acry.h"=0A=
 #include "hw/misc/aspeed_hace.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
 #include "hw/misc/aspeed_sli.h"=0A=
@@ -82,6 +83,7 @@ struct AspeedSoCState {=0A=
     AspeedSCUState scu;=0A=
     AspeedSCUState scuio;=0A=
     AspeedHACEState hace;=0A=
+    AspeedACRYState acry;=0A=
     AspeedXDMAState xdma;=0A=
     AspeedADCState adc;=0A=
     AspeedSMCState fmc;=0A=
@@ -271,6 +273,7 @@ enum {=0A=
     ASPEED_DEV_EMMC,=0A=
     ASPEED_DEV_KCS,=0A=
     ASPEED_DEV_HACE,=0A=
+    ASPEED_DEV_ACRY,=0A=
     ASPEED_DEV_DPMCU,=0A=
     ASPEED_DEV_DP,=0A=
     ASPEED_DEV_I3C,=0A=
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c=0A=
index f23a51c8a4..f7c7ec7fb1 100644=0A=
--- a/hw/arm/aspeed_ast2600.c=0A=
+++ b/hw/arm/aspeed_ast2600.c=0A=
@@ -52,6 +52,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {=0A=
     [ASPEED_DEV_DP]        =3D 0x1E6EB000,=0A=
     [ASPEED_DEV_PCIE_PHY1] =3D 0x1E6ED200,=0A=
     [ASPEED_DEV_SBC]       =3D 0x1E6F2000,=0A=
+    [ASPEED_DEV_ACRY]      =3D 0x1E6FA000,=0A=
     [ASPEED_DEV_EMMC_BC]   =3D 0x1E6f5000,=0A=
     [ASPEED_DEV_VIDEO]     =3D 0x1E700000,=0A=
     [ASPEED_DEV_SDHCI]     =3D 0x1E740000,=0A=
@@ -144,6 +145,7 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {=0A=
     [ASPEED_DEV_FSI1]      =3D 100,=0A=
     [ASPEED_DEV_FSI2]      =3D 101,=0A=
     [ASPEED_DEV_I3C]       =3D 102,   /* 102 -> 107 */=0A=
+    [ASPEED_DEV_ACRY]      =3D 160,=0A=
 };=0A=
 =0A=
 static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)=0A=
@@ -269,6 +271,8 @@ static void aspeed_soc_ast2600_init(Object *obj)=0A=
     snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);=0A=
     object_initialize_child(obj, "hace", &s->hace, typename);=0A=
 =0A=
+    object_initialize_child(obj, "acry", &s->acry, TYPE_ASPEED_ACRY);=0A=
+=0A=
     object_initialize_child(obj, "i3c", &s->i3c, TYPE_ASPEED_I3C);=0A=
 =0A=
     object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST2600_SBC);=
=0A=
@@ -726,6 +730,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *de=
v, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,=0A=
                        aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_HACE));=0A=
 =0A=
+    /* ACRY */=0A=
+    object_property_set_link(OBJECT(&s->acry), "dram", OBJECT(s->dram_mr),=
=0A=
+                             &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->acry), "sram", OBJECT(&s->sram[1])=
,=0A=
+                             &error_abort);=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->acry), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->acry), 0,=0A=
+                    sc->memmap[ASPEED_DEV_ACRY]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->acry), 0,=0A=
+                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_ACRY));=0A=
+=0A=
     /* I3C */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {=0A=
         return;=0A=
-- =0A=
2.53.0=0A=


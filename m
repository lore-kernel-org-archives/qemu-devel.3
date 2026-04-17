Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B6AF8E4A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtY-0002bL-Qg; Thu, 16 Apr 2026 23:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtI-0002OK-Jo; Thu, 16 Apr 2026 23:29:12 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtG-0005q6-TA; Thu, 16 Apr 2026 23:29:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBTVNeM/5vSzbiyNUqWIKo4tqZ/jRKMAANHS9YgbYXJO1RMIwqvEge8FjRyEWC5UP2kgN3xgMJPsvYWi4X3pkGBwHhSNaXdJmoInSV8gpY9bWdnTLTpBTNyOwWIBBmQG/Pxf09W9qvI/ldN7hPbOFQlFBHvD+7dqLACoY5an91yLc4J9T5j2QFMtjdrU0HJ7bm6v/8r0lbB69XE/k6eSoBHl92UwvWItvppzdp5SSP/A+44jtFxDoNlpi0X1HACcl+0azpjrDwcyy9d5T60jCFIsONnI8lIe5FbdyPH388GSY4v0wsCfq8GlVZxzlMny09/H774NiKyTJPvaQleY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeIkCYXtai9hSC+zuW1JUhOYo+4ir8PHk7+GHvwGsGk=;
 b=dAVWwcWD+V0wcI+CmA3UnSvDi45qe6SN3fRWASBglZ3kfOy4y+xR5kvkc/+HeE4aEnHDb0JNNmmz4nBBOihDW+zpA2jOURYRJMkF2wWeVkvYQeu8OITIYuure3z6c845cKs/JBacFCIDzoUXGU5KGXm1nvYfo/DcBXbmfmJAUaDLe6G9WIhZR6BUXNWZzj/CgZ+2b1EKZNXo8Sg3l1uwYCzsTrKDcE5Ldbv1QfoaBjvewnDNCZF4Oxxdj8QcU57DWINE0blncJzHgT2FQRqrxS33TbbCvEkEcs/MjxvbRJtCj5G6CzbxSKt/92ns6bwYuSJXTiymlbsJrMF282wb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeIkCYXtai9hSC+zuW1JUhOYo+4ir8PHk7+GHvwGsGk=;
 b=ORlp52WIByTupMqvBJXqxOS6k9pwvo+0/h2noySPdxia/skgUmWjcuAtMocK9BRCC8IkBDH3+chEuGTmahxpuN2iAL4l/Rt1+tDfDz0Y2pIP9nF7l2nm0gLMeA33I61vyUluzfgjxdK6CzYhyjqeJHnsnDJeOpz42VnwJQ9/PzpRG8HbAmdu3TmJfkQ1MWZz31sZb727n4H0q0E6yWl23wIvqUFnGMzAI1QHLpEjBL0OtPm9SNLBI9rqyRkShI4bS649VNgUhWpbZ65gIKSUEW72fUhAV7jN+Ds32rbqfBcqakFquS3qJRmIEAwGlAEbl2mhOumPdljDrKA08aRFyQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:56 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:56 +0000
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
Subject: [PATCH v4 13/21] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Thread-Topic: [PATCH v4 13/21] hw/arm/aspeed_ast27x0: Add unimplemented OTP
 controller MMIO regions for SSP/TSP
Thread-Index: AQHczhpSJ7PHzbamVUeV/l4HBmQxvg==
Date: Fri, 17 Apr 2026 03:28:55 +0000
Message-ID: <20260417032837.2664122-14-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: d7ca3bbd-bdd1-463f-e511-08de9c3174c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 39/gZi5h2x7RU0VOFtxBlBmIF9uZhhznWOL59vI2qZHIQCLBnCUglScqU8Na3TsQP1Ju3ed6Ayw7Tn2poTV3JYSsTYf7pyFy6jP2BEISplXJlokU0o7kOUCI0Ho6EzyYJ0/QH2huzH8KCEITAeGjTFtdJtFJxvplRI5BZqN0tt4zv7lBLAnKw+VvMIr2WqFAZEc+Cg90OSxV6UtWI/xpe/VE+YLBiUHg36VJBZKWKCUmRjla8LIcwegRnKvz9I7dPkkr+/dGFHZ2Z5NpORf4cI+akfBBE7SMS4OIfoNsAx385p/ZIrue3avQZY2zqvPAImhdVw/a7j2/qRdLoZHDDky5SyP9ZZkb6iZ8M1bcOVxe2IqzPtUQBpkEFu5IxkzzryKcK4Bw900YFpoRhqqqjCWs549jc1VrUkZKfc/WClkvBfeIuGZnMsfsZYuy+GEJ7p6h/fb7SvRMtjOKXVvKU5Fc+GxCPvhtc5eA7BnFeZJaFyMMD6GvIwsIIoC8C1wTXgc/iWefH7Vxsgww83NSHqITzjB5sG8eDQt2wdKrdvgylbTNuNNqtfKqXn+iKxMXlI/ZNU5Kib+Pg1VSGi3ZgHtFisUci8ykmPYMpCMQZDbhviTIxP7YzheDb/5eemahDI3o1xLGqqx9qXTGe1AP04grCFwHikzCv87hPoYf7X2XjxI/SLoJzVzhTy37E64EqGB1K1S+fkdwkPjvMzl8ih0LQzk06bYYaGa+I34HReAF0yaBtynCe2Nmp443nVhI4tE/RvIQeZ4UNrkdCJ8RXpPkr2P3gnKNaKdJoFTDmm51QqAbGE0n5/oCEjmuclWp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CPmS0vEv26HEK/Dc8pTnJbwYJ5fIHT6wMdnaGyRT7VV/6HSbo0B8hIDPWr?=
 =?iso-8859-1?Q?LFe4M9SwHvuhd4uuqhiIJmVIamFVULi6hRM3iYe8OIhO4IZh34ln+HK0kX?=
 =?iso-8859-1?Q?YsBOAXt+McvSErWrx/0swQyxy7a5WtgNR03jOMGQ2ti0RJGje4GL1enfUF?=
 =?iso-8859-1?Q?TqZnyQpbduURrsp6KQNzkkq/X540ZwaJP9DMMafDToBAMUPZztkSIg0FBZ?=
 =?iso-8859-1?Q?CzIlhIEqkLvmYzlaefqD2JVMjTfaqeKStaOxuRnZ5RUEaGX8oV/S1Ghg6e?=
 =?iso-8859-1?Q?l4z+Hsk/7L+L0Slfnq6x6IrU+WTMucAxgmPr8Ch8oSOkBLMNNLCduvE7IG?=
 =?iso-8859-1?Q?92O8/BxFMu7VUOmfyBXvcyr2rmuhTPMAiamoO7odLcJmxOd58k1Vhsck/x?=
 =?iso-8859-1?Q?NgUwUIISfiXRvcRFAZ0/ODVF8nUB5rHHAbMjRMqn3QHvm4z3jTJXq9F/WT?=
 =?iso-8859-1?Q?WTODcfBD2RfORkqboIm84Sc1ogpkVPwaD2kSnR4OUTgiw0RbR5I113g5a/?=
 =?iso-8859-1?Q?w//3/9ZMntlKCL969YJ9zKWdDotQj39QlsasnDVaTmWB8fQwy4F+T4Li4k?=
 =?iso-8859-1?Q?GBMkl5c1kDi0gHZ0yD6+csNa5HGwbxMTxXkCfwnu2vXWUCz/MbT5p4qiwR?=
 =?iso-8859-1?Q?n0GKNJ04ozb76sndtocoRvDPEs92JQW/SS5ysJVYxxnqtuGmZaGWp5HH36?=
 =?iso-8859-1?Q?+VlHY/5O3rGMT1q7PVYz+9xashQbtbDjKasNQtgeX3yuTuWFnh+mzJcRBD?=
 =?iso-8859-1?Q?0Ypylha7MMP1gtzEBzoz+RHK4sSKYEFvmRGmao7WKtP/1oC70uxacNAdvs?=
 =?iso-8859-1?Q?qq3HJNHrojPe8EfAEQBCm4D3D6AEHHd3rJkZ94RVVqxMiKrsQQdduZ6+Cn?=
 =?iso-8859-1?Q?kI8F2sWHX0RrrPc3qPz0luaSD6rGZ2txr2FTaSlCe2wFVUHmdgXEtgxIN+?=
 =?iso-8859-1?Q?SYfv7hQvfv7VxfM8aYos8o6GQRtGAAQ44ECOi3In1AhguF7Z/VH27HzLQo?=
 =?iso-8859-1?Q?Ir4In3D3r4u5K2ssGg25NEoeYjYgxICy3X2wylS2u3wpYvx6+bhalw2TAk?=
 =?iso-8859-1?Q?6MU8PiOLb/CtHUQs699Zw61+dYNMbzrtZfLXxg4Gc4zzBSciZMxUdVj3b/?=
 =?iso-8859-1?Q?+H/gPLpYhatDmTHvYaAbuQLqTBFBq7hDs4S12t4SpaCRhiLBOT+iEFxjVm?=
 =?iso-8859-1?Q?epcwCk2jCjKM2X3I/kQH6bGfd5U+WGkyakfT5+jHn8oTyV7fIRC7r3aS9H?=
 =?iso-8859-1?Q?A8c7/1Wd5kXOClaopRvdw70lxXJHlNtJZigvA9r2RqHxabEFhfNaRPNcV5?=
 =?iso-8859-1?Q?gwjJoB2DJwB6qY3BZgs3E08sDYmKHzvIxQFHLpC7YYIIunBsQ5zFdZHXiM?=
 =?iso-8859-1?Q?5h2ERAPPZ3o293eY+o8w6Xid9bVEra//oEGPZqtcGVWhZPIRy8dQZ1KBRP?=
 =?iso-8859-1?Q?zbiUSyWSf3uLX5tayqkcUdw0HN0SScMAqyZr/J/DSf3LlWwpItxIdDDk9V?=
 =?iso-8859-1?Q?/YFEeYgo3P1iB63tCydZsQjZ9HXx2VNkhjvYSaHh4APV2rITOSIPSSC3vv?=
 =?iso-8859-1?Q?ablSvGfX+dgfY7cZ79qajkK+97iW24cHgo+tAyPW6EU5D4ie6DcCxsEFNJ?=
 =?iso-8859-1?Q?GwdWwqT9x9mVWD5g+FpEVJEnvnMSxRDNLpht62kkeIdbZCwqW6+ePwEHSp?=
 =?iso-8859-1?Q?IPt2pW8enzCZ0ANwg28Gil80ifFIx/ChibthrueR+gNjFiMl23uPy3ys0+?=
 =?iso-8859-1?Q?UA5QExYN7qzIawJ6qRGfXxfMzIKpq/oclrADwIZDq57ybp6uyOR4z9gJs2?=
 =?iso-8859-1?Q?7kK7Z+Nc3Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZUvokj4F2ImoT0rO0nSYrXoc8czwHXMKOrpCyFNe5u98lYxBDrstRmZMl+tbQuqX7E7kE1tK1BRrSKekVFKPDq2tBUW2JHg394dTouNLkdJxfYJMMXuSmcgSOtbSgJFylVqUTbuflOlgxv6aMEYvND6AXdXy1m5VaYfYaR8GLQ9eW+/+J0WXaHkdEuPpljlPRxeDHpT2CglcffmhYNVIr2auN71vwfpGP+AT2QJ71wHwceW+zBQJrbqJkyqW8abM/YXuIPV9lVWHU/7aaL+gW3l4E3B987VFH3USIRWyDzOEtVFoNCYuZQILzOkuSYR86VTViK4FjAfJBk90/nEDzw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ca3bbd-bdd1-463f-e511-08de9c3174c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:55.9198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLaCWz1OavsmLlaTGhGJ/zNyc+T13MhPrzir7wHONLH8fd6wBX8jLuWUNlM24mI90ghtNETz897t1GUvyR+B1YKK34gj3KH3eqwN0/SJuAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

The AST2700 SSP/TSP firmware accesses OTP MMIO regions that=0A=
are not yet implemented in QEMU.=0A=
=0A=
This change adds unimplemented MMIO devices for the OTP and maps them to=0A=
their corresponding physical addresses in the SSP/TSP address space.=0A=
These stub devices allow QEMU to safely handle firmware=0A=
accesses and prevent spurious exceptions, while accurately reflecting=0A=
the hardware memory map.=0A=
=0A=
No functional changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h | 1 +=0A=
 include/hw/arm/aspeed_soc.h         | 1 +=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 6 ++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 6 ++++++=0A=
 4 files changed, 14 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 084040bbed..7750569eed 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -47,6 +47,7 @@ struct Aspeed27x0CoprocessorState {=0A=
     UnimplementedDeviceState ipc[2];=0A=
     UnimplementedDeviceState scuio;=0A=
     UnimplementedDeviceState pric[2];=0A=
+    UnimplementedDeviceState otp;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
 =0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index d39e4f7553..1df847b34d 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -299,6 +299,7 @@ enum {=0A=
     ASPEED_DEV_IOEXP1_I3C,=0A=
     ASPEED_DEV_PRIC0,=0A=
     ASPEED_DEV_PRIC1,=0A=
+    ASPEED_DEV_OTP,=0A=
 };=0A=
 =0A=
 const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 467fdea9db..78bd6f342c 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -30,6 +30,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
+    [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D  0x74C33100,=0A=
@@ -148,6 +149,8 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "otp", &a->otp,=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -288,6 +291,9 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
                                   "aspeed.pric1",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
+                                  "aspeed.otp",=0A=
+                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 3a90bbec51..d6448d82f5 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -30,6 +30,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_PRIC1]     =3D  0x74100000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
+    [ASPEED_DEV_OTP]       =3D  0x74C07000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D  0x74C33100,=0A=
@@ -148,6 +149,8 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
     object_initialize_child(obj, "pric1", &a->pric[1],=0A=
                             TYPE_UNIMPLEMENTED_DEVICE);=0A=
+    object_initialize_child(obj, "otp", &a->otp,=0A=
+                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
 }=0A=
 =0A=
 static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **er=
rp)=0A=
@@ -285,6 +288,9 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *=
dev_soc, Error **errp)=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->pric[1]),=
=0A=
                                   "aspeed.pric1",=0A=
                                   sc->memmap[ASPEED_DEV_PRIC1], 0x1000);=
=0A=
+    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&a->otp),=0A=
+                                  "aspeed.otp",=0A=
+                                  sc->memmap[ASPEED_DEV_OTP], 0x800);=0A=
 }=0A=
 =0A=
 static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
-- =0A=
2.43.0=0A=


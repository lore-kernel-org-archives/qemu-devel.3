Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EE0CD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8z-0001ph-8U; Mon, 25 May 2026 00:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8a-0001hP-7F; Mon, 25 May 2026 00:42:01 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8Y-0001Fm-Cf; Mon, 25 May 2026 00:41:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6n9HS9FKVbSdtu7SmJ3aZwCiYP9Tjov1Dq4TVPQrUsCQA0zvHsQsiST+ibB3+RxDsis6g3q7UWRDTlmeRMDSdl2Fd1odo/wjUqTX8Y1yAgUazWqiVOzs9j5Wzw3saWX0V0/92LN3Jv+5+JjtqMuJKukDhautMyikQodqyRHlHHIKu+d85uz73diGfeUftvwHCdDVI96IXsTtJPsxFu0p4IEb7N1XhLt2m5WgnDdKBlc1/oLQpFLtT7MVEdvT0VIoLEbwBfl2ncvAin/TtB/kulEUuGTCc51/EGhgc6DMtFCFz5nWyAn2I1eZ5Zgpba16xTAqIpB9HAkLi8leCKc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBUDy3v5zbyY2Hhdq8Kn91tv7N/4vPcenyiCjglK924=;
 b=QyzjkVKlnOn6DWx5YgzrC7EX2c6kt/lqS/QbPB/kWR9MfYweqivpD2ieY6JmcXvhjm9tIopRYLHhINKTqIGYDsLjFIz5yRBX24rpcAdnP8+MXTECyQB2ZhNuQoaXwd1le5XzzbaiWo4jUeB1f/PTZiXwUZT4k6+VoPQaRiQpRFuWi5uoWKxqdTvN3sa6DYRl/ofpCANVqLJIMlHeE03dnCGObNlUZiDsmR2x44bMT2jqIfFvcgUbdVFgFU4JU9GFF/1ACk6cEBYFqeTnGOdTdIIOOrq4FuSMhS3E+yyYkx4hulUbidCUoFTSRo54FGtbyvKrTTYqqPmrxcGYRF+v6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBUDy3v5zbyY2Hhdq8Kn91tv7N/4vPcenyiCjglK924=;
 b=PMjP6uPtTlJWcgJcnsP8qOpIiV/iLkfiZ0cqkW7nG1JVuHGBBJQkToHH/TtIZgljgAhg+Y4upOKF6r5q01t2rvEL9eFmsBDhLgxHjwTmWlrY7Rjq4GLJTvBn1GyrzWNEuCPcFiyVhVGOQ8UWqBHnDtEQK0SSxVG5ti3Dqb67nSRUu/kejumAho1K3GDWFt7CkOgUMJHlgDKMrTI9psZ5SR/anYpFu+f0RGXhm95+3wyrd8s331vaYR9L8xh221hqyD3YaTB9Fu01sOgIS6AcK5CFtY2HiWGrvw96nI68t2SOoSyaZkVQaUECsjvEvDOyqAL8lCJ1YN7MIxhClEdu4Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:45 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:45 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 10/23] hw/pci-host/aspeed_pcie: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 10/23] hw/pci-host/aspeed_pcie: convert to use
 Resettable interface
Thread-Index: AQHc7ADKS1KcUEV6OEOnvYrt2ZbgMA==
Date: Mon, 25 May 2026 04:41:45 +0000
Message-ID: <20260525044129.3133916-11-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYQPR06MB8085:EE_
x-ms-office365-filtering-correlation-id: a1115783-f6f2-40b8-18a3-08deba17ed0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: 7lcdBlHsKbuPLZKgzH0aVIniZfL2QKczZAy8tygYoYGROJzBRDXQZXbIDlhSbWSnrehTCfpoDysam3QTPbnYWNevKgnDsflW3zkqr5C52nvPmWbrzcJRvEQKHPoCzaZfapiU4yN4ckQv7NNLyqhfvXkQcMTqDFeJSsJPameWpVr48k/CKa/7c28hTizZwSqCINlanB2xy2QchooME1dcGaZCgHjFFJEuRteL5CZt3tG6S5GJpDbAaE4WAMr1lBHjq474LhoSXseovRyy8FQo0Y/TsUvExLfnmceKSE+Y4iC4sdgJTfWzSvgoAThPLolGldG+ubyRC8lEDzfuWbWsIGPIhOEkQuEGZIumSMGFSOppSc4LHsVruaZfpVPbLhuANePztmAY9Jzmq5RdqdDr4jilEjhjplQC6bug1EgNKewTywvVt3ASVVs5SWbiK7zfKHdr4qX08f4IKWEM2eBDiHXhx3uDPlCdsQQnl6ZaME8Wxjm9qVTcnsfP0TAjsojOAIQqBA1FPm8p/Su8TRzFjdczsPCPtPsFmAfVJBQhxIqCLkX0yRygfalWkGd7miZ73kt0dmSg0zcBgsbz+V/u2EUwYozwgfyyEbbEPTRfFg+Ial2mMgZrf0MdroU7JFiT+f7N+uYFvU+Tgxs0JP5XoviV930YuH/i5NZA5AiGQYD4OTCPkQMhMjnYoiS7j9c/ic4rGf4y8CyZr+KVRdH7ElwbEjp6i+xtdq+OmR4m42wkeDIav082gD0/Wi1K/MPHNn941dbASU8zSymhIbtLmQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b2xrSlO8KK2CdlBR6mshfowN+ZYOS8Fofvbvt/zKwSitnLiwUMKM55gfBF?=
 =?iso-8859-1?Q?U3RxnITDyuTL/KouCzwJqvTep+CZ+tSB2apZ45jlhLgCwIYn5Gtm4JRgwL?=
 =?iso-8859-1?Q?A1NW0syFdgYZ/Ebfg6o4qXdq5TMHPFYGdKh0rfigBuWzdEEz7gXELfksDa?=
 =?iso-8859-1?Q?8sBBirP1tWGTsx62tzz6WCNKJE74A5w5+MOW9HhtAG3buzsLMx07qyN0wt?=
 =?iso-8859-1?Q?9WzXuvCjrPVPDPJ3wG/9+iESyU+pmndiXGjrK65LYoRTdUi4v+lLKuUUq8?=
 =?iso-8859-1?Q?TqKNpjMnnJPNatCvUt6yZulTB0WAzi3By4rqLkvBUEiIziDvcrActJbjxK?=
 =?iso-8859-1?Q?RxGWG+HI7PM/hyXfg8M61pSU2JGNn3JUBRzha6bdRcJvzGvUPVrJx11mic?=
 =?iso-8859-1?Q?IIKA4Hc2+PWaG60YN2/mAP77h0rdaJQtv5VpHN4L8+Zg1DqfbFaNpVeSGE?=
 =?iso-8859-1?Q?49aFqgNQzY/vjXV0YoiWi00X2PKQkqxXiCY11JBWrPB23sl1Prhty1FL1q?=
 =?iso-8859-1?Q?er556y+fkmyz+SI6WAFtCJF+MnpmmSi2kTHlM2qCbu+8SGjKI0AzKlsrNP?=
 =?iso-8859-1?Q?1UKZ0aACYs+2fVHsWfEXzR/0HakzxtEqwHGAnjYKLKId0IhUfHjXx1dRgH?=
 =?iso-8859-1?Q?K3BSWzpkLs7EMzigfuz6i7Uy3pjryqdKa3fOVADlTdlaP8VE1LiS6gHBMS?=
 =?iso-8859-1?Q?OwhXqRc/EYrScQDhzw+P5bgDiLnppP5LvtPXIxh+FMYmnhXwbTrhWKQ1cG?=
 =?iso-8859-1?Q?fR8ie+mzHAfqCwOlaafMTO54MhzgG5LVxPg80xePsMlf6oFx0yZ2PT/smW?=
 =?iso-8859-1?Q?l6t+jqlPenAK5F1gt1Xjoh6+f3ySp4BZb0KR80uY5B+/Ftq/oMkBeyDbL7?=
 =?iso-8859-1?Q?WnGookywgPassrYH12PO8S1OgvrnMOxNxfbfPzqiTpemyd2fIIUFgueDVK?=
 =?iso-8859-1?Q?efSkey4oxnOJbslvbP9ZdBV/J6mgr4BpkFKJoSpD6Rnq1t3VPbcUrjREBI?=
 =?iso-8859-1?Q?zs2IlI9p9efVHIG9W52OV/Rt0gKppHtv7kgn1EEhcQOTnmAx9dMf9bbJAa?=
 =?iso-8859-1?Q?cDBZN+YbfXYfptVFnz287V9j1F48/W6n550EcdFEkfJB45aYUw3by2LXdW?=
 =?iso-8859-1?Q?4Yr5kUJascOHL2gOdk3vryqyDramaG+FxCgrWePdWqMO6zfJ976nETl2Eb?=
 =?iso-8859-1?Q?m+JawzcdNBdlzH7UJ2RXhzHAcu4p3qS8AP6CFdNdBOSaYRWYzi5+8izyeR?=
 =?iso-8859-1?Q?spS/BGgAudSXBg5IoZyHoUAsLs9Vpdgpgghv/5Ukn4kOs5a+nX63FHzX87?=
 =?iso-8859-1?Q?4iZKKOCo4m7QqHq7H8gpKU/cfNJln391s7fLkR5ORQgq0FtyAqm+V/7ql5?=
 =?iso-8859-1?Q?VAR2t/8ovMYRUyMofuXAaSi73eyBx+Hs5WHR32rjoQz8iMMobenUVJ7jYR?=
 =?iso-8859-1?Q?WxVrShuzt48I6NyxeKGggYtGRfXmFo4+2oDtZKjZURtZ9uUCLYo2tcRyWn?=
 =?iso-8859-1?Q?7h470RsX0CsGSIeVwdiEYR875+7PDEw9/Qv73X5t57A2gg5NMR5A/Qr1jn?=
 =?iso-8859-1?Q?bz0BwrhcVo3v86N67ddI8QbBhT73Pofv4xW23ocKyzQvb+uQfd8ZsBKCfn?=
 =?iso-8859-1?Q?tucIEgk+CdZJM3VP+R22Wv8v3xY9ECd0XGm+x8O4zd5Xk/2Fa78Eg6bnLM?=
 =?iso-8859-1?Q?NcY5UGMORnpgnpUUvkkpejvVrMxtdFp+zd4WJNmV/IJar0nYUnQ8jj93uW?=
 =?iso-8859-1?Q?1vw4CF3sQbcNndqJUfRWV07vBw4K6VOGxdZy52EaaMfRaE2b1XYHjeKtxL?=
 =?iso-8859-1?Q?ReEECWc3eA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DZG+c0CkA9tMTZpDlZi/xXufoFC+8GodrdmzBFdwdUiNDNzENHvHWFf/gXyTXgsEHdbRZBOB5yCEqrzMQenxvx0ohmjiERd/dAZE3AgRTrAiHPynomFE/ahMO/c+ygc3PQ8LLvmndDA9mjVLqp7q6UVyIR2hcy0J7O9tTcmfr/DEy8MV5okxAg6G/0ma9r9vR6HLT7RiK5FkPCmHyU98IUlNnAgbH8VTjMVZe6NQRsiyTp3yteq57LdAk5Lu103EKNzsyrnAkz7gcqPP+9up/VfM4BFpgzcGc+Q1tpUaflz8dpb5ZVRabGh4qUcjUUOgfOpT3Rpy/3Vl9xQ6My7sxQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1115783-f6f2-40b8-18a3-08deba17ed0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:45.6905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wi0U/7pwpU9DJNolNTczuMlwG8RV/JydRBbNIVAZu+IteGD6XZkQuCTNwUc797cq/bPulCgX8LHqJrENa03uaX7i0sGy3jzi5kipQPeEup0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/pci-host/aspeed_pcie.c | 21 ++++++++++++---------=0A=
 1 file changed, 12 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c=0A=
index c150496f7b..186e5aeea2 100644=0A=
--- a/hw/pci-host/aspeed_pcie.c=0A=
+++ b/hw/pci-host/aspeed_pcie.c=0A=
@@ -613,9 +613,9 @@ static void aspeed_pcie_cfg_instance_init(Object *obj)=
=0A=
     return;=0A=
 }=0A=
 =0A=
-static void aspeed_pcie_cfg_reset(DeviceState *dev)=0A=
+static void aspeed_pcie_cfg_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedPCIECfgState *s =3D ASPEED_PCIE_CFG(dev);=0A=
+    AspeedPCIECfgState *s =3D ASPEED_PCIE_CFG(obj);=0A=
     AspeedPCIECfgClass *apc =3D ASPEED_PCIE_CFG_GET_CLASS(s);=0A=
 =0A=
     memset(s->regs, 0, apc->nr_regs << 2);=0A=
@@ -663,12 +663,13 @@ static const Property aspeed_pcie_cfg_props[] =3D {=
=0A=
 static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     AspeedPCIECfgClass *apc =3D ASPEED_PCIE_CFG_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED PCIe Config";=0A=
     dc->realize =3D aspeed_pcie_cfg_realize;=0A=
     dc->unrealize =3D aspeed_pcie_cfg_unrealize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_pcie_cfg_reset);=0A=
+    rc->phases.hold =3D aspeed_pcie_cfg_reset_hold;=0A=
     device_class_set_props(dc, aspeed_pcie_cfg_props);=0A=
 =0A=
     apc->reg_ops =3D &aspeed_pcie_cfg_ops;=0A=
@@ -870,9 +871,9 @@ static const MemoryRegionOps aspeed_pcie_phy_ops =3D {=
=0A=
     },=0A=
 };=0A=
 =0A=
-static void aspeed_pcie_phy_reset(DeviceState *dev)=0A=
+static void aspeed_pcie_phy_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedPCIEPhyState *s =3D ASPEED_PCIE_PHY(dev);=0A=
+    AspeedPCIEPhyState *s =3D ASPEED_PCIE_PHY(obj);=0A=
     AspeedPCIEPhyClass *apc =3D ASPEED_PCIE_PHY_GET_CLASS(s);=0A=
 =0A=
     memset(s->regs, 0, apc->nr_regs << 2);=0A=
@@ -913,12 +914,13 @@ static const Property aspeed_pcie_phy_props[] =3D {=
=0A=
 static void aspeed_pcie_phy_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     AspeedPCIEPhyClass *apc =3D ASPEED_PCIE_PHY_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED PCIe Phy";=0A=
     dc->realize =3D aspeed_pcie_phy_realize;=0A=
     dc->unrealize =3D aspeed_pcie_phy_unrealize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_pcie_phy_reset);=0A=
+    rc->phases.hold =3D aspeed_pcie_phy_reset_hold;=0A=
     device_class_set_props(dc, aspeed_pcie_phy_props);=0A=
 =0A=
     apc->nr_regs =3D 0x100 >> 2;=0A=
@@ -932,9 +934,9 @@ static const TypeInfo aspeed_pcie_phy_info =3D {=0A=
     .class_size =3D sizeof(AspeedPCIEPhyClass),=0A=
 };=0A=
 =0A=
-static void aspeed_2700_pcie_phy_reset(DeviceState *dev)=0A=
+static void aspeed_2700_pcie_phy_reset_hold(Object *obj, ResetType type)=
=0A=
 {=0A=
-    AspeedPCIEPhyState *s =3D ASPEED_PCIE_PHY(dev);=0A=
+    AspeedPCIEPhyState *s =3D ASPEED_PCIE_PHY(obj);=0A=
     AspeedPCIEPhyClass *apc =3D ASPEED_PCIE_PHY_GET_CLASS(s);=0A=
 =0A=
     memset(s->regs, 0, apc->nr_regs << 2);=0A=
@@ -950,10 +952,11 @@ static void aspeed_2700_pcie_phy_class_init(ObjectCla=
ss *klass,=0A=
                                             const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     AspeedPCIEPhyClass *apc =3D ASPEED_PCIE_PHY_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED AST2700 PCIe Phy";=0A=
-    device_class_set_legacy_reset(dc, aspeed_2700_pcie_phy_reset);=0A=
+    rc->phases.hold =3D aspeed_2700_pcie_phy_reset_hold;=0A=
 =0A=
     apc->nr_regs =3D 0x800 >> 2;=0A=
 }=0A=
-- =0A=
2.43.0=0A=


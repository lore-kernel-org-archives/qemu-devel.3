Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE701C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7SUB-0006k9-Ae; Fri, 18 Sep 2026 02:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x7SU4-0006iH-I6; Fri, 18 Sep 2026 02:54:08 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1x7SU3-0002rT-24; Fri, 18 Sep 2026 02:54:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONUFJ0FN8nMy+r5uyL0xdRvPPeINy8fT3+5P0RIqSVAZsar0Sca7+TUcPGY5UAG8mrzYYF7JmHgQh187c7EKnMYzWkuwrL2RdUVnxPOthvG/kyQB4VV/SQrSw9OTl6gSyewWjcj8jeTmvf1UopNRtP1EA5W86CvCyv7aan7Mz+XPaVVf5EMXio+qYOpazGSy+oxYh1ONGaDhPrcaK/fd3PrMd4HiR2TZ/9/WbyIi1teIbWuETSmkhciNV0b+WCE6AMFQ72HhMb7bxEETYG5j0yi1Yb/27YhzqAAUS3bP1DkiuT5B3BqLvQNp94waZrrz49ZhT+P2ORpiHHj7zRr+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqW0LM2U54X71PU5+QnQHrPKP1sexrVpSNlxuxYWMo0=;
 b=EtVbZaVEgutD3Ei1Ojb+MtyZ2GstbyX56RwaNJL06vZE7NGcVfJejmOSiT4MuOt5ZOUafirg9nvKzPw2C3EJYsdhmTzF/5J/QJnNa3rELVul+8kj9BxSeI7mTwvoYyVKvhHpYdIj9uBREq7ngbhstHWmubfu1hutrORVEoKkXWh82G3inhgNGJnZi5Awr6QsrobAhDaWtuvnWmPBDjzuVL7ZhTPbF+MoCXRQM7lkoMQF7jNTLHU9l8wVduG6UGLy50lO6skSmCSleJ+Rq5AMWeoeQTYNmqlvigSXOxzBepxPu6+LuLi8I8tf7OCJfK1GZ9pWxzEJni3OuVqHbsXBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqW0LM2U54X71PU5+QnQHrPKP1sexrVpSNlxuxYWMo0=;
 b=q0+He17SdcDKhXiQsc1i0txuEzPUJUUaCPlHsFZv3fgT/lLOaC530991YJZaNJpV/scCiD9l9kcE4RCc/4l1WJegp16D7cZt1Xazay6u4schNUXuQt77R76wrircTMJlpNJ2y4l2eyzRKeMbW9VUT9cPDNISIEtjetHgg11qKAUCalrZ+x6rfHub+ctvowHe2twGm2qwPStDzxanZWugG+qyz4vUSagiurOx3xK0xPgaroMr6MTkoPnkK2U0vknB9w9SX+VpKB2w7oc9B2AtWkbMwZD/Ok8P4jH/3JcpvTfbxDlRyWTvUftw2l+SaL3ctkfjettm1Tr3/G1RKTg8cg==
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com (2603:1096:101:249::5)
 by SEZPR06MB8814.apcprd06.prod.outlook.com (2603:1096:101:33d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 06:53:52 +0000
Received: from SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6]) by SEZPR06MB7619.apcprd06.prod.outlook.com
 ([fe80::c8d3:efda:b73:f6a6%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 06:53:52 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 3/3] hw/misc/aspeed_sbc: Derive secure boot state from OTP
 config
Thread-Topic: [PATCH v2 3/3] hw/misc/aspeed_sbc: Derive secure boot state from
 OTP config
Thread-Index: AQHdRzp2QR099gXF2UW86apyi1Ym2g==
Date: Fri, 18 Sep 2026 06:53:51 +0000
Message-ID: <20260918065347.3713868-4-kane_chen@aspeedtech.com>
References: <20260918065347.3713868-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260918065347.3713868-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7619:EE_|SEZPR06MB8814:EE_
x-ms-office365-filtering-correlation-id: bbbc2445-518f-4b55-498e-08df15519964
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|6133799003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 8mlE/isGfgeskawd/dGOSwceT3eK7UdNLq+QLTM3C6QXZxTH7vbqDp+70wypsJemx6nP1v4jC3Du4kFUm9k7Pgx6/WfyZf1VFX+YtgpVf5ti+/CEqlXl6TqaSxjazE+vwsUQJU+uWADZNTS/5B0VoThvf/Y4m/G276fQO/lofwg3VYsPaSoEUbaxxfxxUJP5vm4aW5on45tlw6UvAFQjvMTXEiXyciiN14AyVrpZ8/31SGS8XOQV/NKVIg7kHU8Mcf4OcqpZ5cSHSrDRpPGOGM3Z/C/m37Hh11DihRiJRAuQS5FNk4W0DkfBmy/JFLcYUlOy8l+tnGKlchUD+YsOR0XRdrmJD5Oj+HvK/RvMxDlpFmnFwgEeDFlvn7cABBkBDk3Ibo8PC37BLnaoPSeB3AOwkdq228L1LHfH4lZw7BmdXHcKIyl2bX2rYG0wf6cGmIiEQUhjRYw4LZc3bxAeP0liUJPeqG4Vv669++E+o7+bfrK02BqBVQRiVT0xCZUfq9WG4LbDQ7Sgl0lfxQuk8F1F5ORoRvfMcQD7py1Ki628Vn7BEWqsnlqKkjit7rnzZyFyy7G3d7spEEISg6anoqcJXK9RH0SbN6KHt9hdpZokiLMzsrVJQ7QhhYbGfZlJO+SLkqAj0dauKKRyRgPvZHUMFvozA8g8T+Szh9lWuBKmjdDEEcPsKN0O+ZK1USqpkBokMJkCyEyOBgHzFVL8mfA5f2kDqNLa2p1HE9fWH0Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7619.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?68rqIKBoar/5/rE8NNxt1/3HI4W9O6x9I0EANcmav6OXnV2uaeyLkHAeZy?=
 =?iso-8859-1?Q?bS7dE4Z73q19HI4TLYjONebLjlsgAd2RNO/4r/HHjKpHO/wFFHUMkQwNpn?=
 =?iso-8859-1?Q?zP6/J4wyHSjYuCPBa7pjpx6+jFaQ0yMyqERHFjHfP6vt3Zt/b0BzCwTmhs?=
 =?iso-8859-1?Q?+nA3H2v1jgNUECre5QCVWBcJfeGko0onBritYZlPwYjTijg9JJdqpy4K9P?=
 =?iso-8859-1?Q?mrHAO4deM1T582gjVxW+R2ztOdEObU15bwtbIXoTY64htHDFGRbaR+ID/T?=
 =?iso-8859-1?Q?1aVVDV01it4sHh+6WLNKAKUoXENIFKt9afL3E7ymoBFEIGALKJrG3C/Vbk?=
 =?iso-8859-1?Q?CxkZFesYKHe7eVuFacP1EJdclVSBGxGxxREOaJUJUoW5ef2M6H6aDq06Ir?=
 =?iso-8859-1?Q?MryE8PfxcLx3F7jQbRDnzZWNKLyuGfHYOrOvdl+orrDOlZY861pjWOOrK9?=
 =?iso-8859-1?Q?NUZW6/ugVPwhedgHH9Z1TLT89ARcllxEoChInoVwRcuAaPkGuWxysJihVV?=
 =?iso-8859-1?Q?KGetzaYJA+C751nCI07zPuFgyM437B9Kh7AsXiGDNygT1k+q+ZELL8cBG3?=
 =?iso-8859-1?Q?RCxzaCAhOh0VKwoFSRG4LStnYKhDI/Ock8R7XhVCr5NyW0VlW1KpzcBR7M?=
 =?iso-8859-1?Q?AfXRgJdKs24euOI208yasZhcD35IfmTqqZG9YhjGnHPZMCorLBpMB8DaP9?=
 =?iso-8859-1?Q?Qs3+jaWcvKDEBiO2mqrf86QXX5i5NeJWfbAcJpqTQS/efvsqkF3a0t5lsX?=
 =?iso-8859-1?Q?69u6wNc34+vwHvZC8ubhrCiUC1TlBc6Ub3rasidT72MXO1owvgVHqOGIGj?=
 =?iso-8859-1?Q?jlw/QRx1p21MVeYLi4lhK+5ls5TrYtxwfGxTMlQPx5rtQAxQWumd2ZbQ7M?=
 =?iso-8859-1?Q?HEzncIuI024kRkBJbiqbb4csO0El9nh/kWvc/ybqAvBkdCmxbM8le3lMFd?=
 =?iso-8859-1?Q?rq5dg7L/AqDzo+fjAgEZjn8C83ZJfA6OAWSonaPb05kss1/JjWVZiyOoPE?=
 =?iso-8859-1?Q?DqHzHaZYTF7K/Ho6rjdS3PkBYzb2X4mp8MZTQJujbBxMZSsklKpeUV+N83?=
 =?iso-8859-1?Q?4Vx/Oifxzk8kwj5cYQgyEp71jmbF2/XMx41UIIUOGDW2ZurG2GtFRy+n6A?=
 =?iso-8859-1?Q?RiDJgMR6LvUX1BZWUNv4Dam3veOhKrB85T6FipJ8nGxnKjBL/4KfEZXN0/?=
 =?iso-8859-1?Q?sKGo75hkbUC0bis8Bs7JB0TwCoqkrVXG3t9l2iBjezpTEXpM3LELeGIZf6?=
 =?iso-8859-1?Q?/fqO7o9j7dN4ch1DbBZmjS+vceC2fFegrD+GJqALmMw0wtRIt2zDvL4xqb?=
 =?iso-8859-1?Q?C5zATKIqlamJKcHQ54drKeFKIeIKoVzsgCbeA0oxD/lOFfv1q0jS443sI0?=
 =?iso-8859-1?Q?l9FCpssjOEYtbf8EGKIy247oCKQ5evm4mfiGN+Tq7IWY3edJCPinpLYpUG?=
 =?iso-8859-1?Q?T5hllanLHmkH73XFVX7RCbKYZyytTppjP2o27M/6y9WxL8werZ/mtWMOlG?=
 =?iso-8859-1?Q?nZOl3xvXL4zvLb25rC9/YBPPNnfU1EDxkYvERQvSXV8zzgvuFqvq6TeWkz?=
 =?iso-8859-1?Q?Yx6EgL4yWaFCIY90yfX/hbaoFVhrQ+TBMuZfmHaCcrhrhryLmUpE1jH0FG?=
 =?iso-8859-1?Q?GwiecqCMBz5n2T0RUfiThK0v4pfS+l56FJ3mZFA6ZPXHvtAqUYV7YvVtTf?=
 =?iso-8859-1?Q?pO43LBUPX5nD11x77jIVux8bfzAh2Jzq/vW2VALSpEuCrJgJaRQlC3kzmd?=
 =?iso-8859-1?Q?cCdQcmVtZCaC9uqjBwa0NBEHWHnQQTB1IvGMTVbQBzloGbjvsOvnrgBg4U?=
 =?iso-8859-1?Q?JgkmtvMuBg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BU3UdKVD71KHQsFYZtD9/6Yu9LqC2Vy9sFtfNhoejacvR+3gdrLTLzpQSZ2mTdL9GQRH82rxAJo9tMuAPPH+PkemDexbJ93X5aUkSgDkUVOwgpLLt/jwmqRcxpdjwJ66ii//9jqvTP/pqf82K4Z5+Tmy2+WNCY04eDXatatuh/8QILL9IZXkg0tE/Rpw3MRLn43BiWyzrSTVZLpg9It3pGhrD8WwDYRw4omk4TpcFYYZw5Tf1EwiCjFCCUc6T6bb5PGJT7TyNvWYouP8F1kSDxzMLNtpA8eFnfwhwYL7IjvYNoCgel7/9hKIphHEVvOc4ULK/UyxdtXg8tQtvxyW+Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7619.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbc2445-518f-4b55-498e-08df15519964
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 06:53:51.9301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SSF55vJwsoVxpluVBkNXFI4h331UaBEzkE4oPVpU7GEH5+GaJ+PfUy+Irw6Cs2t7BbVo3H/HoO5I4NPdqCdsZTOvqoBhEAv1dZdHGKX8LEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB8814
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

The secure boot state is currently controlled by the=0A=
"signing-settings" machine property instead of the OTP configuration.=0A=
=0A=
Derive SECURE_BOOT_EN and R_QSR from the OTP configuration when the=0A=
registers are read.=0A=
=0A=
Remove the "signing-settings" property as the secure boot state is now=0A=
derived from OTP.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_sbc.h |  2 --=0A=
 hw/misc/aspeed_sbc.c         | 22 +++++++++++++---------=0A=
 2 files changed, 13 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index b210ffb8aa..7f3fa7062f 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -32,8 +32,6 @@ OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEE=
D_SBC)=0A=
 struct AspeedSBCState {=0A=
     SysBusDevice parent;=0A=
 =0A=
-    uint32_t signing_settings;=0A=
-=0A=
     MemoryRegion iomem;=0A=
 =0A=
     uint32_t regs[ASPEED_SBC_NR_REGS];=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 6cec9ad3da..ad4c2b4b1d 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -79,6 +79,8 @@=0A=
 #define MODE_REGISTER_A             (0x3000)=0A=
 #define MODE_REGISTER_B             (0x5000)=0A=
 =0A=
+static bool aspeed_sbc_otp_read(AspeedSBCState *s, uint32_t otp_addr);=0A=
+=0A=
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int si=
ze)=0A=
 {=0A=
     AspeedSBCState *s =3D ASPEED_SBC(opaque);=0A=
@@ -102,8 +104,16 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr a=
ddr, unsigned int size)=0A=
             val &=3D ~ABR_EN;=0A=
         }=0A=
 =0A=
+        if (aspeed_otp_read_config(&s->otp, 0) & BIT(1)) {=0A=
+            val |=3D SECURE_BOOT_EN;=0A=
+        } else {=0A=
+            val &=3D ~SECURE_BOOT_EN;=0A=
+        }=0A=
+=0A=
         return val;=0A=
     }=0A=
+    case R_QSR:=0A=
+        return aspeed_otp_read_config(&s->otp, 0);=0A=
     default:=0A=
         return s->regs[addr];=0A=
     }=0A=
@@ -406,16 +416,11 @@ static void aspeed_sbc_reset_hold(Object *obj, ResetT=
ype type)=0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
 =0A=
     /*=0A=
-     * ABR_EN is derived from OTP on every read, see aspeed_sbc_read().=0A=
-     * Set secure boot enabled with RSA4096_SHA256.=0A=
+     * ABR_EN and SECURE_BOOT_EN are derived from OTP on every read, see=
=0A=
+     * aspeed_sbc_read(), since the SBC status register is just a=0A=
+     * reflection of the OTP fuse state.=0A=
      */=0A=
     s->regs[R_STATUS] =3D OTP_IDLE | OTP_MEM_IDLE;=0A=
-=0A=
-    if (s->signing_settings) {=0A=
-        s->regs[R_STATUS] &=3D SECURE_BOOT_EN;=0A=
-    }=0A=
-=0A=
-    s->regs[R_QSR] =3D s->signing_settings;=0A=
 }=0A=
 =0A=
 static void aspeed_sbc_instance_init(Object *obj)=0A=
@@ -468,7 +473,6 @@ static const VMStateDescription vmstate_aspeed_sbc =3D =
{=0A=
 };=0A=
 =0A=
 static const Property aspeed_sbc_properties[] =3D {=0A=
-    DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_setting=
s, 0),=0A=
     DEFINE_PROP_LINK("sram", AspeedSBCState, sram,=0A=
                      TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
-- =0A=
2.43.0=0A=


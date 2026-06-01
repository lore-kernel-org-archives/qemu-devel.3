Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12030CD6E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjc-0003Fj-Vn; Sun, 31 May 2026 22:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsja-0003DV-4Z; Sun, 31 May 2026 22:50:34 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjY-0002lH-1V; Sun, 31 May 2026 22:50:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGOJ1BE+b88yX2GppZJz9FCBqGPDGPFtWFwccFSmWc4drjLGeHSL6ORAMGzlNhAeXLZftBh4f7uLPMjIsQ+fYs4jT/J16BfxJpuuXkKDjJ4MhFF0hi4palJsZdiOiqOmS6ArxspwBk/ZFdvlyJPO4V6CgQyWRMgyLrdg1jnUWE1NYj3ZEq7uahBcrZP+jI3J//jbuM8FZtuNoLdrI+EVc3KtPPFfwoAYDCtvGDVMwaYvAqCxcQeBla6u2AXMbjuUyx4rAVc18j7gzIhFOSk2kA0eUbeJKefAS+PJlfD3hdtvNy0E8E+7whxbwKFtzrXoENSZy0Ep33gM+h9kBnZ7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e9komiWATwtpKlx/larYwjq0l1Cl8HzbT4y7L51pmQ=;
 b=Zs8ntI4QrgbWd+2hZDYcYD5wa7zi5Xih00f6dKoW+61hIqgER5D2N+fhbtnd+m8ERe5P7cN97A2/C48AUk8Sr8ll/sMDVgwH4gRAoPYRYY0k9CYw6HFmnlMIr4/zHejf2JSJmz5Bttt3z9Cf+tAKCoq/wGbc6eBKz7I6x96Hp7Q/2YyBZRTRF3m9Ezg1MRs0jnM8s1rD8HGZD6M9iMBg5UFvsDbkC4VfKREeKqJkp2Q9IiIP8/+1GL1Rw+atD52rkrHwhovrXQLD7S/cMuwcetm4OCsK2fGTmnt3K7n7ovjiP+SlZlmL+A015WniQ4YWQdzfgaO0B0sgWHkvLQR7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e9komiWATwtpKlx/larYwjq0l1Cl8HzbT4y7L51pmQ=;
 b=XL03mejdUWACEFhgQEd4ED8UeUfFtPOBbxAp22No397uPyu7I2tcYf2LVYeXbswD7g75Vcy28Gvts614ReIihxPE0NrFjhCgQfERl4QOzu17ktS1GNBlloyu/MICruL5AbJS8g04EbxsDfJ4KXnXlumZbV4C9A+3X11FRShjKSP5w3BPwjbcfpqee4JOGjrzbURC28TghUZpkYLgfUfANOCi9sP4TdlCTOstKmueVtXyXF2oPC+NvFqwB1UpL1gu2xiSQyoJgq+x2F/gZTBML/YOhyMe5WHLdaG2ntiJ74ddDXhQY1550dLw46Gxc1auvfBCPjT2RsuBqskU4GRATQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 02:50:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 17/24] hw/watchdog/wdt_aspeed: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Topic: [PATCH v1 17/24] hw/watchdog/wdt_aspeed: Convert to
 DEFINE_TYPES() with inlined TypeInfo
Thread-Index: AQHc8XFmwSp1HhAb80yAEHozCwSUfA==
Date: Mon, 1 Jun 2026 02:50:26 +0000
Message-ID: <20260601024959.2347639-18-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5490:EE_
x-ms-office365-filtering-correlation-id: 58a0b148-0303-46a9-db33-08debf8888e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: DB5HlPWy+5xjlRhgALyD/EwaBAvEHWaYw4FF7t6j5H7JIwns6xWk6zNYXiy6UrlfLGgQ242QmmmjOTsnzq1mLPcCP9yTxK0CWtQMsZQDhUmIzu8J6ZlWmXK9QKdMOfXF80xEfupojyT1dO3I4fKfSJahS1+PYrWdzT/F5buYV/4DyIAnSRiFVi2QNR3O4TtZGQYyTpNLH144VygxHlbfILiYUoS0OTBMolGjIKz9ZWuVMPoOBLrfN0UvlwfntUZ0w6ItL5tm8oVKIAXw60Q5p13nTmzkBd66e51ezkh+IH18xG9/CG6M1YJ6Ui5taZ6cYtCdxAafDAQGiZfM2L/gLtWr3mjfhU5Z2RXXAvCtRafiYx22sjr0eVqNWXwQT8ri8PEpr8kIIVtqPv5HX24dFEZcjnhzFEJrLciEYRhFRumrGSNWT7H/xIGrz1vu6zCHpHWESm2r/cxC+Glzqu8b6gYtsujUKe70+3bIQhIReMINPO4ZgjkvBz3mx+GLZ43vc+F+Po/QlOikzRlL3+5p0ye9lXqC6/LJ/VsdxHGT5GVlHEJtc8GWUc+pp6mDAMEGszNGCHr4ctpLPULfOQBidAY1+e987i4g+GlUfmaALn68Wt/bF8bFxxXEWj0VB1Vk+JWjtTGiGAUe7LErhcqmAT/3TzM9gKLR/RoRKQRk9UELkpT9CLRNXgnurvG4AGps57uZ32fsIw5Yh5wEUnDVChFnvJ9O4cgXBJM3YvJnOnTdhy09yaVU0zbWH38XN1nNibF2qiCTSzC+UkY0IK0bIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?46NEJ4fQ4HvFSRB9fQqzs+2lGh1nKPVHd4u6LHsKTx9B8i8b3YeCzDxTb+?=
 =?iso-8859-1?Q?pKEvHbl5yKczjCL3H8WBoasG5VFnkprwEPd+nbO42bPG+XRs2nN2dpXm8Y?=
 =?iso-8859-1?Q?P0Jo2+PZ+guYjDSHo9P5s/HVKcoQLAX3MkdU7ZV+sZY3vVu5TkpF+3zDVH?=
 =?iso-8859-1?Q?8Eb1F+uUQ7BJrslI1/SJwXDEtawUb/y+rGWqWm1XR36VH6bb2X8IEgS4Mb?=
 =?iso-8859-1?Q?hyYSS4LPvb2/aPHZsYlux1xL2C/tHaf12iiOZ9SX+1EH79zMC6jF6tMXXS?=
 =?iso-8859-1?Q?4XiKempqpwcXnps+P5rnUR//mhtD2YeQCwu4ZF1pXzPWaILKTBuEEfpfwP?=
 =?iso-8859-1?Q?+MR0VKOeQThZchTfER6lWsWXRl/9Ue7R6O+hGOzk2QTYyID9U0uBTBLKAM?=
 =?iso-8859-1?Q?BZjosoIYRnKqlGTakcAQ15cYc6rh0hi8YhRBzG3gbnxqpfxZeNKtmhswaQ?=
 =?iso-8859-1?Q?TfuawP9Db09v8UUpG9v3BKxWArcu/Klu6QOelvfRrvIViU3Hst6EWEvPAf?=
 =?iso-8859-1?Q?u99RAnBuIbmBSe48l3ASonqojxLltGqmxcljZonDEAlOOBi+rdrXLlxlMW?=
 =?iso-8859-1?Q?j7yemLF7SmN8Ee6eOWDoKtS3KCqcK0Ci0BY56v6ZJDpiDGP127PfTk4PcT?=
 =?iso-8859-1?Q?ZUtPdk9ngRRS21S6wL9lzZ3yrHIDQN5LyP/E8PrO3K1sOBUo6zsAuZSD8z?=
 =?iso-8859-1?Q?AiaDpBGpQdIfy6EDxot8dXnHMrer86Bv+J9btRD2J/yiF7BOJ4rRenxGFT?=
 =?iso-8859-1?Q?vGOgC4DXvshdhS4SEepDGfcX5iMuQ60x26sWB0e4oxcTsgLHmUcAH+5ffF?=
 =?iso-8859-1?Q?M3dpkOTeGtmHNInLdHI1cWcQpYppfCPX+omJ1faNHLnTyW2N/aQrX0TBL9?=
 =?iso-8859-1?Q?l+Qar3QAwoNG/MF9bBxGJeJcBIj9jn0108ya3YAQrJbWJl8JAE+ew/Wp2P?=
 =?iso-8859-1?Q?J/lg1cXSE+Adcj+fhSFtymdwelgWLKDLPW1Y9hZp8VmK2BM1iYaflR0FWQ?=
 =?iso-8859-1?Q?Ynd85MOmXEh1I2t5v8XvRnNJm0SikCZ+5P/GCmkGPOmQksSQfTMQ8qs8JE?=
 =?iso-8859-1?Q?9OdqDJAUL1XPdK2YH6pz0pFW+hWzyRWoZR+rJUell+GgUWnukmiuC41XTJ?=
 =?iso-8859-1?Q?hnJCO8qX3aTpp9Pmf0LnR3g22xIq9jZ9N73tyCby2o4wsU4Fr2qCOUHKOs?=
 =?iso-8859-1?Q?6/iap6CuvAnwi0rJlwqWUo4UBfkfAnxUoAk7MKwkDO2VDFMBr44cJPH3E4?=
 =?iso-8859-1?Q?tiv4i/BV1OdH7YWEOTd0bCW5Fp6LWS6Y5yqQXskNPYVxzWol9Afu9cWOSr?=
 =?iso-8859-1?Q?RlJQeh+FHu7vPrMcZOenpFrglZq+o4apoapgoSCqXUbwuqvED9ciNa0NAR?=
 =?iso-8859-1?Q?yB6NZEJfl+067Sbk73K6tRxyeSaPwffIfHQv/mj3k4DnRNAZHYJ7DQhEqO?=
 =?iso-8859-1?Q?12d2w7927I2iukwvPSQ0q1cjqxeQpi+JJEMWb8qFwS8ApnjIpPd5VElY8P?=
 =?iso-8859-1?Q?uj9bOWuGZLURIc9JLbkUWz7ySde3LEjWIY67KArijNsffvdUtT/jrYCDTR?=
 =?iso-8859-1?Q?VcuYYR4+X4aVzN4BNFBJM0XYooNJ2zBeAkIcsJ/+KpZTwd0ByAuCkhoq2e?=
 =?iso-8859-1?Q?twqYZXFd499H/2CDzWq9YP6Rd5JbkyD8v3JsPK8/AfgJOdL89YPZl9a5gc?=
 =?iso-8859-1?Q?WikvG8XqsNZeDstLfbfvTfxZt5C8E6WC5B24Gwy5h5kXkhLql6Q3DqMw4g?=
 =?iso-8859-1?Q?rlm87qx9ekcm1PG+tMdZs0n73VrdaopOdSvy54Oqj65tqjCjjA58/BkzxC?=
 =?iso-8859-1?Q?2TtdZTXmiQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cGLCyGoPPMT3pj+fwGmX/3rZiMnXVWwR+3HBkl0HgNgcv6PJC3WHcx6yVxKbSw77N3TflVTFCKfSeJnzzO4D/IqeFX65dMMEVhfACsvVXK0MLrB7EWStCOOjbOAL+Fsgw084DpHziMQ4WiMMbDXxVFmslplbmZIlOeatabN8gFVjxFd1DzE+bT7ts2KOEntSJetqx4DJ+ZahaatER8UBWf1mwwpRU/MZ4y57bl9WVW9eIsNWqBy9f3+AIYswjoytBmq8/GFF63SlmlVjcXMufbmNb4YidF8rTbCU3J2Ibv5Ff6p1W24RuWm3Y/FFPA0XKYxks858wEprArHQHw2Zfw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a0b148-0303-46a9-db33-08debf8888e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:26.5963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPtFCxuZE7AkUKXLRaG6KiI/jy1DkIdXYNYuv9sbFTFkGyzSXGug/1UfnZD34+gVhOFLebNrMqUboDRDIs9/Kvo9SByGDoOPuGhYBDzsK7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5490
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline 6 standalone TypeInfo variables (aspeed_wdt_info as abstract=0A=
base, aspeed_2400_wdt_info, aspeed_2500_wdt_info, aspeed_2600_wdt_info,=0A=
aspeed_1030_wdt_info, aspeed_2700_wdt_info) directly into the=0A=
'aspeed_wdt_types[]' array, removing the need for separate declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/watchdog/wdt_aspeed.c | 93 +++++++++++++++++-----------------------=0A=
 1 file changed, 40 insertions(+), 53 deletions(-)=0A=
=0A=
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c=0A=
index ae411593c5..deed970c89 100644=0A=
--- a/hw/watchdog/wdt_aspeed.c=0A=
+++ b/hw/watchdog/wdt_aspeed.c=0A=
@@ -321,15 +321,6 @@ static void aspeed_wdt_class_init(ObjectClass *klass, =
const void *data)=0A=
     dc->desc =3D "Aspeed watchdog device";=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_wdt_info =3D {=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .name  =3D TYPE_ASPEED_WDT,=0A=
-    .instance_size  =3D sizeof(AspeedWDTState),=0A=
-    .class_init =3D aspeed_wdt_class_init,=0A=
-    .class_size    =3D sizeof(AspeedWDTClass),=0A=
-    .abstract      =3D true,=0A=
-};=0A=
-=0A=
 static void aspeed_2400_wdt_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -345,13 +336,6 @@ static void aspeed_2400_wdt_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     awc->default_reload_value =3D 0x03EF1480;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2400_wdt_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2400_WDT,=0A=
-    .parent =3D TYPE_ASPEED_WDT,=0A=
-    .instance_size =3D sizeof(AspeedWDTState),=0A=
-    .class_init =3D aspeed_2400_wdt_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2500_wdt_reset_pulse(AspeedWDTState *s, uint32_t proper=
ty)=0A=
 {=0A=
     if (property) {=0A=
@@ -383,13 +367,6 @@ static void aspeed_2500_wdt_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     awc->default_reload_value =3D 0x014FB180;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2500_wdt_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2500_WDT,=0A=
-    .parent =3D TYPE_ASPEED_WDT,=0A=
-    .instance_size =3D sizeof(AspeedWDTState),=0A=
-    .class_init =3D aspeed_2500_wdt_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2600_wdt_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -406,13 +383,6 @@ static void aspeed_2600_wdt_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     awc->default_reload_value =3D 0x014FB180;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2600_wdt_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2600_WDT,=0A=
-    .parent =3D TYPE_ASPEED_WDT,=0A=
-    .instance_size =3D sizeof(AspeedWDTState),=0A=
-    .class_init =3D aspeed_2600_wdt_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_1030_wdt_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -429,13 +399,6 @@ static void aspeed_1030_wdt_class_init(ObjectClass *kl=
ass, const void *data)=0A=
     awc->default_reload_value =3D 0x014FB180;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_1030_wdt_info =3D {=0A=
-    .name =3D TYPE_ASPEED_1030_WDT,=0A=
-    .parent =3D TYPE_ASPEED_WDT,=0A=
-    .instance_size =3D sizeof(AspeedWDTState),=0A=
-    .class_init =3D aspeed_1030_wdt_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2700_wdt_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -452,21 +415,45 @@ static void aspeed_2700_wdt_class_init(ObjectClass *k=
lass, const void *data)=0A=
     awc->default_reload_value =3D 0x014FB180;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_wdt_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_WDT,=0A=
-    .parent =3D TYPE_ASPEED_WDT,=0A=
-    .instance_size =3D sizeof(AspeedWDTState),=0A=
-    .class_init =3D aspeed_2700_wdt_class_init,=0A=
+static const TypeInfo aspeed_wdt_types[] =3D {=0A=
+    {=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .name  =3D TYPE_ASPEED_WDT,=0A=
+        .instance_size  =3D sizeof(AspeedWDTState),=0A=
+        .class_init =3D aspeed_wdt_class_init,=0A=
+        .class_size    =3D sizeof(AspeedWDTClass),=0A=
+        .abstract      =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_1030_WDT,=0A=
+        .parent =3D TYPE_ASPEED_WDT,=0A=
+        .instance_size =3D sizeof(AspeedWDTState),=0A=
+        .class_init =3D aspeed_1030_wdt_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2400_WDT,=0A=
+        .parent =3D TYPE_ASPEED_WDT,=0A=
+        .instance_size =3D sizeof(AspeedWDTState),=0A=
+        .class_init =3D aspeed_2400_wdt_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2500_WDT,=0A=
+        .parent =3D TYPE_ASPEED_WDT,=0A=
+        .instance_size =3D sizeof(AspeedWDTState),=0A=
+        .class_init =3D aspeed_2500_wdt_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2600_WDT,=0A=
+        .parent =3D TYPE_ASPEED_WDT,=0A=
+        .instance_size =3D sizeof(AspeedWDTState),=0A=
+        .class_init =3D aspeed_2600_wdt_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_WDT,=0A=
+        .parent =3D TYPE_ASPEED_WDT,=0A=
+        .instance_size =3D sizeof(AspeedWDTState),=0A=
+        .class_init =3D aspeed_2700_wdt_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void wdt_aspeed_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_wdt_info);=0A=
-    type_register_static(&aspeed_2400_wdt_info);=0A=
-    type_register_static(&aspeed_2500_wdt_info);=0A=
-    type_register_static(&aspeed_2600_wdt_info);=0A=
-    type_register_static(&aspeed_2700_wdt_info);=0A=
-    type_register_static(&aspeed_1030_wdt_info);=0A=
-}=0A=
-=0A=
-type_init(wdt_aspeed_register_types)=0A=
+DEFINE_TYPES(aspeed_wdt_types)=0A=
-- =0A=
2.43.0=0A=


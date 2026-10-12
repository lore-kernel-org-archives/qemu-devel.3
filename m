Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE5ECA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mg-0001qz-4b; Mon, 12 Oct 2026 02:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mb-0001ot-G3; Mon, 12 Oct 2026 02:45:13 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mZ-0006MT-Sm; Mon, 12 Oct 2026 02:45:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGd8JfRStsl3H0yHKzfQdi4fZ/6eTxzTDYPJmmNLJxIIUM62O5csgUlh2PS5yZUXYHv6XHjLgmdTo9wfVCWk9udatZI0i6Cf6+3P4C+Ou3hBcOqTUh0S8Ohiguwg6prMLApDV3mT2dN7BYLjTVoFpLvrUMeab/blBbQNvFWPVd+xV4MC8KnuzQ71FH0lBetUJIuz5iYhz4wB3iD1dJhujsjzIyfbJw3Xktxc1ezBmJDtNNKNSp+jtm8JhnWUqeo8eaPBk8GZImzCQ2E0Rr8jLZPR5KB00YzfVn6GfnbmyE1Mn9/+jU5pQRIqaVjfJTwLZunCOduxWI8SyuN9OIeDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYdPpEIboSJtD7Zj2dweGki/BSXxXo4tASm78nIqRiQ=;
 b=Wx9pn7yXWcsUXqVM8YINqB1qIh8NUCK+iruRHAefk62/b0+j8phsyimxMtjZCeh8gkNGaK001dBCQ0jO/eAbNh+FkUTXJZnrDrVarRRRs11gOQKNPXf16N3oje+zwTsa6LCRAZ+NbOGDP0hQ73KpEfVRKEu3rUVIQKFNL/l6IUwgkQpoMlI360FJbXjw6e92H1UI3EKuToqZyldWVIquJARgNuWsTE8Muq6Ume/m1nNXX3cgPTcAxm49Wz7FpWdX8FjNToanhDgfFrc/K+RapCOG7ulQFPo/Gp5AWD29KmGQV15TXEj20n6xrmWAxCSsehF1GLB1aiAra26RKuBTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYdPpEIboSJtD7Zj2dweGki/BSXxXo4tASm78nIqRiQ=;
 b=UI46IS6PHTEi4bHwTod4Yjr519zfLU0Mkv0UrwUNG48yHTJrVHgtE5GWKuJSgtK4F1dpfXoz+Ntz9P8sdWColf9DN36mAsphauH6kOKNA2JjhZ4avysnbdAKz6AllknpZfNdL8q+61t4+TDJ0srVtETNGHU/J74BO4b3ZcyeYLR7K1PvQkDpucyYzU0GKA7Hf5isYLZiGDxYFGrqrtQczUvxtMIUnsoCHSkGxbJCxAl8s24D8CDrALcsj9Cy0X3b/LSzikLxz3CLV3LNgrZ/fn2Y1Yi4O25mToGN+GEXUckzOeOxQUaKg4L1S/yokL9ZaniLPo9ik8A2vzG7wtqvDg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:57 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 10/12] hw/arm/aspeed_ast1700: Use a table for unimplemented
 devices
Thread-Topic: [PATCH v2 10/12] hw/arm/aspeed_ast1700: Use a table for
 unimplemented devices
Thread-Index: AQHdWhUyUF75Wg8dDUy4uRschzSKlA==
Date: Mon, 12 Oct 2026 06:44:57 +0000
Message-ID: <20261012064445.2571633-11-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: ce988bc1-be9b-489f-273a-08df282c54b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|38070700021|921020|9063799003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: F3mBOEZ/w0rmxWwN13JYjZHznP28mTXazsyHlvoEBT/0pzVFH/z0E9S/9w/RRepQELwXkQpyTn5Kor/i9Zt9Rd2Kk4gRFs0Y0gXgm/d6fmp3FV9sdcxTF60tREr1mbW3JT7e+B9Y1s520Sqh4STyRW8L+vfDKvrErUtrOyAa8eoA6JpoX4OKD0J+SkUCg3qTkCEgxP90TWPRfjNZiHnSA946PmJouo19VOcf2niCxA4z5WCXFDMTYtnlp/J5uFPBFlPuo3tjY9EQ11po0NKdcAgtvRd8KmSgmnmzv5i4nwM7jZLpFsbvkVdvchaGB7nT8BnbPs5vgWRAATRBWnOpYrf2aEL6ZwRfVeBILPBsotw0Cd5Y1Y2cGVIqWnbPgO3KS1jDZUutSfqV3GliFVGurO53a2aNe4ddjw4Em333XC6KVjvZoj3Y/WIbDSnOtXX5Pp2TQFvI+g/Kw8IH0ZoyPqSPa870y8+K4q1BF+ZdAjDyiVR1uUMV8hC5oMV6gnNa6cXv6ZSxHCb14KLTelqa4TM4d4Z1GADUtyROxb4pR04+GyTqp7nrlRtd/HpDHxkzXO+0J6rcmYeuEinx6jiAFWL3jzoXCBH5x0Cke1wFE7lwP1kHWz62pxUah1YYhUU6viSK5mlInlZqfcbvXmnboVJM0c1VmpwH+tRR74GyKYgB5/zjfnw1VeVbMTEjK9mxNq2kBRchXa2jhnRoc3s8f3ypTml48Uq5WOQm2pc8DOLCjHYVRe+zXEvLUZDXmsjr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(38070700021)(921020)(9063799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RWKNOUEptthqKDTPgLCKrHLLwkw8gYsITIwuaxuBui1KZZoY8F/HtfXlB4?=
 =?iso-8859-1?Q?NNYqCC8OAvp0rHkseVZMZQYoKZhWE6gwKGhVaBrVq8OKXNu/6I9vJNYpWx?=
 =?iso-8859-1?Q?sfKJdwdqFMQvtDhEfe8IlQHzflGVM2vfTuhOe9uMMK41IPz5nBXMXfaC9g?=
 =?iso-8859-1?Q?B4XWrxAmCs2H2nDdX6As/fIpRG5oXkB5OfM5SBiIsGWIfSkt2lI9iU2vyA?=
 =?iso-8859-1?Q?JFxWT/zfxMdCXRys9rbx2lv/cKV62l1SZsJOo+KmtAUUSMIr9UtQr/bxq8?=
 =?iso-8859-1?Q?C47iTT0Kc4TTeH3ekGYfPolrdLP5mC+TIyIcoddsXpMH1LKCY73Yd/b9Ag?=
 =?iso-8859-1?Q?ofGSJyM/u3DhspDcc8MGOP6c/Kn2sxv3Fp94anT/e09SrPmia/bh/qfp2I?=
 =?iso-8859-1?Q?k1ATOa31YMKbTl0lA40YhoL7+VC6UnCTQqWX+vMKFzjRP8lfeHr4rjGxoB?=
 =?iso-8859-1?Q?MmNTLmWuXEl5MycSOcACEZIXw57EjgKq07J2ZoUl4KOERtQUx0mkSEPgmt?=
 =?iso-8859-1?Q?mGWrP1b0eO8o9f1caBrbEsNrdydu7PXZCpTRiUwp7blL5LpvgW1VWR2b5w?=
 =?iso-8859-1?Q?ZFY18txJY+N10/kUmkZ5nsiSOJd+/ihsMppU/r74FOMHirrzcgO5/4RgD5?=
 =?iso-8859-1?Q?K2aVgcSRU2+ew3QtnZqxbbzpIOYQofGV6WDKV/cbWuozS484EYCD3hQp+e?=
 =?iso-8859-1?Q?QDT+ugsxpgtr1id1NiYgu+pjJvfEX/twtRRbWbml2QFPXgLK3h+0yg58oO?=
 =?iso-8859-1?Q?BpIYKMTQmaga45CYwHGjxlsQ0oiQ2/gSUQpTRoGiCwSPgz4bS8ZXTUi/2h?=
 =?iso-8859-1?Q?J4ttz6KVz3fIk+y9yuzSqw0TmnAFhUVU7ThL3uXZaYDxLqQFpZy5XmNrug?=
 =?iso-8859-1?Q?i0Cc7s++6lpnBDuHGBNCrTlH96iN+Txg1+BXhbyBCTiW6mje2qt/LnqwNM?=
 =?iso-8859-1?Q?7nw16rXntdwKRUdLdzhtl9vqR9NA+Yab6+F12NQo21SXW0XthfFriZFPjE?=
 =?iso-8859-1?Q?qNsZZc7rs68Bj31rwj4S//HmRvuSHuyYSh93riQO3hi0If1GV2MlwGj+IH?=
 =?iso-8859-1?Q?o391r8Kcyg/DCLbP3u6xvCY6z/59HUllf7w1zJHraXi1/0uiTVkZSF9ncG?=
 =?iso-8859-1?Q?Njy/LaeNDfnwwXshdMKuWRp1h0eZnZsCQou3lMACjBrxp7K1AZaehlSmaI?=
 =?iso-8859-1?Q?UypXEr7Z6gnnShm6yQpmDGVJuh7TU4w5YgnZZzr6TdV+2/q5/MO3mfYwHF?=
 =?iso-8859-1?Q?1oCC/xOoobbtdUlFXX5CTSMgAK4mvPMIVmQ2INfycK15FKkTzNRHM5koK9?=
 =?iso-8859-1?Q?92gGmCkYGfwaS+18k3o8FhK7qSnOCc3RmhY+zVwpkM62o+UF6AeKrKZWd7?=
 =?iso-8859-1?Q?AaswloRzkhPRg+dO9EMJkcvBMl4iD+RtcGkrJF/KOCxqv+sjtzail+SO2Q?=
 =?iso-8859-1?Q?rY48qOeayYyR0dt/bV4adW/pMDxghCO74mx2XuaW/K0jK13G/AEWOqUsti?=
 =?iso-8859-1?Q?ZKz+GQVHWuUVee3aXdUEzpbsQnD5VaMPpQtk8NSMF5IzmUrBoCk0WLgF08?=
 =?iso-8859-1?Q?XknN3prlL67aMN25fZrAPtVV1seZ2db+480HuQc7j4KCBq3M2bLc62jMAp?=
 =?iso-8859-1?Q?CG5tXZATMzU9kMhH6d6J/8zY9hnkzwXmdUNTTK3kXx0qodmXo2/p/hp+3s?=
 =?iso-8859-1?Q?WSmPtkq01tw+8/dF6WICCZn1cmv+P+e/3JTIhD6ZKigZXDcrGbsRnQZ4JZ?=
 =?iso-8859-1?Q?rhHuHVIfaardr1PTf62rbb8yK0ESmEXfxBjkESwJJSZHVSMT2TdnEMhWqu?=
 =?iso-8859-1?Q?q6P+det7lQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: waomHp0bbmDkjSBA6TjjufeYM0aPuMRf8KY3qv9d7x9iRnHG7leDND+YfqhA57rHNML7+yPuEA7CjuS1y3odeP5RYducu0GMH/oIAV/ioBVxDtKcOYY3CSTQVM6c9Ww2woR54JqNMYLyv/sqRJ2eiHMwiSY9rOhfr23Ns8hzmGNh5HUaD5B/Q/JHDZlzw9/sID1ePCUi4sOW75n83AkekU+T/At7vbXJu/vySUgpd7OXMngQC0dtXZjNqDS8UMP/58NzSLObUjWZEhpKXyj8fSr7Ci7t3WmGcV0d03mh9gYhFYiVssyG4z4epLuvAdQbMGJuHaVh/GP8TOZWVydO/w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce988bc1-be9b-489f-273a-08df282c54b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:57.4056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBbdcZvkyg67OeQ+2wxMOV8sjNP407fks3E32Xbh/lzpVSMTDRQnHVBU3sjTk/K7Tj9G22/y2cpLHximWC6/tI5fvC/7oOZ4/SjLX1860yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
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

Before this change, the I3C unimplemented device of AST1700 needed its=0A=
own field in AspeedAST1700SoCState and was created and mapped with=0A=
open-coded calls.=0A=
=0A=
Describe it in a table and use create_unimplemented_devices() to create=0A=
and map it in the AST1700 memory region. This makes the code easier to=0A=
maintain and read.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast1700.c | 21 ++++++++-------------=0A=
 1 file changed, 8 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index 5af5da5b8a..e5d5bf4056 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -15,7 +15,6 @@=0A=
 =0A=
 #define AST2700_SOC_LTPI_SIZE        0x01000000=0A=
 #define AST1700_SOC_SRAM_SIZE        0x00040000=0A=
-#define AST1700_SOC_I3C_SIZE         0x00010000=0A=
 =0A=
 enum {=0A=
     ASPEED_AST1700_DEV_SPI0,=0A=
@@ -51,6 +50,11 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
     [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,=0A=
 };=0A=
 =0A=
+static const UnimplementedDeviceConfig aspeed_ast1700_unimp_devs[] =3D {=
=0A=
+    { "ioexp-i3c", "ioexp-i3c", 0x00C20000, 0x00010000, -1000 },=0A=
+    { }=0A=
+};=0A=
+=0A=
 static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     AspeedAST1700SoCState *s =3D ASPEED_AST1700(dev);=0A=
@@ -181,14 +185,9 @@ static void aspeed_ast1700_realize(DeviceState *dev, E=
rror **errp)=0A=
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
+    create_unimplemented_devices(OBJECT(s), &s->iomem,=0A=
+                                 aspeed_ast1700_unimp_devs);=0A=
 }=0A=
 =0A=
 static void aspeed_ast1700_instance_init(Object *obj)=0A=
@@ -238,10 +237,6 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
                                 &s->wdt[i], "aspeed.wdt-ast2700");=0A=
     }=0A=
 =0A=
-    /* I3C */=0A=
-    object_initialize_child(obj, "ioexp-i3c", &s->i3c,=0A=
-                            TYPE_UNIMPLEMENTED_DEVICE);=0A=
-=0A=
     return;=0A=
 }=0A=
 =0A=
-- =0A=
2.53.0=0A=


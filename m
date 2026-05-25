Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED22CD5BD0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN98-0001wJ-Me; Mon, 25 May 2026 00:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8f-0001iM-F1; Mon, 25 May 2026 00:42:05 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8c-0001Gh-Um; Mon, 25 May 2026 00:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a90AMbJHX/3QTAZYdCCbaq5wHo5M/yaUGz/Mn8ssverq0eQs2ePU/csnyUQNLuCwxDTFgI3/Y+A12B1iMLgIqFHcf93jNKlIKkSIqQt3xfy4gzIIOSeI9qvUJytnX5cb3/2G6GMa1BUiQOtmbY9cOaKaWRw1fpLFu4QlCxIvCWrCl9FSWdHPlUmYj44NXWcIzlkE7e4iOuoMoG5HIZDborWFP/zUTSARxrUImnFnmIP64KRZ+WQ2H5hqwxmhW0zzm33eFmFD4os/zRCWpjLZipJaeMJMD6GaeD7ljZmQ/xeAmJ8LZtbhXNP8T056kWh+2Z3Bao0DyAw+471NuVcE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ9tKtYo+IAl1u7XGR48pWWPVtyPVPA3elhiwsoSvuw=;
 b=LGG5o0DU0ThfKfj/6VdjFnuS3A/nYQ3e7d7DZgFwypbWz7ptQYm/9olk0WEeUF4P0nv/zfOIoU+VvFnu0CEVR0Fqm6puIDLHvOve2HySlY7FEOWq0KkZFG+SDXmRPHOgg1QFqd/akagBNeBwEsKNf8p+7bdf7b8xvORR+DEphRe++cIeCkqefvrjh7VCNHNo3d+T5pVXoC8NlmKbPb4QfCNAB0yBfMTXHSWw+YyWoZTNL4UQ6oxlmIZCn6Of00+I1/GxiA04E85D2Vwjk3pz272+gwNRhQMu9Fw5lsz5yBd5iIkC3ZrjJA/5caB/++owYxWcSGtuewvzMVqB/EByFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ9tKtYo+IAl1u7XGR48pWWPVtyPVPA3elhiwsoSvuw=;
 b=fZ5NHKmIfcXxkZuY54OWZvcIb3rbPrMRoE0LKzQa/9L6yVS4m71jwosEuBV0ij2OLkGPiGRkT/i0i8k5bHFTpsjgCHCU0ituGAAaDDDrTt/5a1MO8XMC9jE3dH8U7pt3Jo9S+5EbXNjzrPeP4NmXjmpZamo04GEBO3MsVkvT4+uNORCaWNfxKPral4U57OoMZaPXby4qoAmd6xy10+upxH0w1hcPsPMPV2zaDYaUvDr4sVT6gIkkXlEhGFC37hvU+XuADJTkVjIUUX3ikNru9na+ppsQLPfBF5fAZPYGziNK67w7sLrkFxb5rvZUST9NkEg2zzQ/6hQOIs/sEg51kA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6593.apcprd06.prod.outlook.com (2603:1096:400:458::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:51 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:51 +0000
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
Subject: [PATCH v1 14/23] hw/ssi/aspeed_smc: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 14/23] hw/ssi/aspeed_smc: convert to use Resettable
 interface
Thread-Index: AQHc7ADNLL4tLY0zEE+3Zci61FZV9Q==
Date: Mon, 25 May 2026 04:41:51 +0000
Message-ID: <20260525044129.3133916-15-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6593:EE_
x-ms-office365-filtering-correlation-id: c64cbffe-9659-49bf-8a42-08deba17f089
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: ofxfETFRz/0LJ8UVTgoN3ReoKNn4nTXnK4g5gjSYPSVva7oXG0sdEM0FzzbTLq5yR5V0jpDnWndmfgutBdA4BJGQ8OepACRUkuUex5dn435s3Is94SR5uYpQwRHo1LLrIE1XMNn8ac8Uc+LU6DjU9sIa5mrlYv+muzwd3aWbSop2yGdZhuJHoq+KnugJfzz1oqq5nsKUOeY+hmXcpP81lstTJv21o68SyXsG620jnHXdvVoVj5P5AA5CCsSBO+OYvfdraHZmrOFpLCNULji3kTPwGvn6jj6hETO6O98AavLb6D6h8JxAi2syT41iNZ/LNrPCctaVqeESpAeTIcjMyP/+r7FaMPjUH9c5aoylcOegOHDH9228Ip6DLw41DYp2hbO6A7V6ZyEGI1OANV3KbBn0nABo/o0RmH6lASjhfAH1hrT0pqiTLWTIYVSUaKTbE2Kz15AOuALio1ezmddXNAmg9aWp+l++aJTfGT/GFYew/y41swyUj68vq0ynbGeprQVp4kOcNwmyE2tlfTyiwn3c3u2WpP78FWjLvzoLyWwPzWixkkuss9qA7sfEXk7W1Y3USgPps69O7dbOcuPfuWed212SOWKz1F4SsXFCaWX89AtTHuw/82IwTx8DES/hdSqpRph/VuQtM3acIkUPUAHLCphh+jeNmRKRwQwnOQjQxZ4PkoE7attZnBEwH0WFgRtW2wSux09r2xJrd1CsKNnUL3Lin9AUYacvfFNECUWNYgG7R3Ygr6FPhSm/987Um2gHIxd6cvJsW53aIXfD1w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uSQfKIzJWr9mqdN70LyrHZ/w/BJRBEJXe9XJDDLDQItWwCa+PTI3A42gkA?=
 =?iso-8859-1?Q?P96r0nQRZGAY2N4iE61+R1ETHNC9OzFGh3WJ8UWoUO8iH3BMYI0f4/Iqho?=
 =?iso-8859-1?Q?H1B4varVHIVi2wQgYQJlCV33vuA8V/5kDZ/l3GUNTbBLGjbHKq1CUVuXGN?=
 =?iso-8859-1?Q?P0LZhHWMkCa863FDozypdCwzqzrvn4UktngBbD2VTmrQhdaXc4YjG+BAnK?=
 =?iso-8859-1?Q?iJFUi9J9zYokLW74qH8rHhSN+wUxWfzYYaFZpzHSqpFa6xg8Dvs1+o3+XA?=
 =?iso-8859-1?Q?Oi4kzUhPqGqTVJsj5fI6V7GYXBewM3f4SCgSsDetHzpYyMtLmnMJz71wzL?=
 =?iso-8859-1?Q?uK/dn406gK/m9Vp9wLn0vN3MVLCw+4AVIvEy2PM1N+YG0/WqZJs7M1tInl?=
 =?iso-8859-1?Q?NhkNbENz4PDHNJzrAY8mZto203iYdex8EMhJp5tejL0aC/CRE+7OO2r9vp?=
 =?iso-8859-1?Q?QSinJDc+rkB3PvERbMjSDYTul3d9J1UeCeYaz66i0eJuVdUcDV9bTYem1s?=
 =?iso-8859-1?Q?vcsA0on3QuloodPn1Cjf6bzFtoWmJIf8MYwbtF6NFCLlgdYtkYULJD4VMa?=
 =?iso-8859-1?Q?5a5vOaRG4kb1cGB8+2qWzoHyNwArwXb6Ak/F0JU+VaHpSMrrCuqtWB6Ypq?=
 =?iso-8859-1?Q?2kaNmOpEWXa1oLeK8EmKCd6TGkFXSAZN7NIwpvCAv91W72C2Rc7aDaknZP?=
 =?iso-8859-1?Q?g7mnMgHmhLWJ/TNNA0Q1GXjQdJS8YLmfkPvHHaxlIrfhRl9grscQXsIq+V?=
 =?iso-8859-1?Q?NW5iDw7acSsElH6yC7cevh5aD6mPMqTccwmDDgniL6MXdc9/noS3uPp5aN?=
 =?iso-8859-1?Q?t3epwl5WZamWteo44d5TRNJ29Crp8fdBKW2JS0Sfl3oiuZiHk0WbgDDJyl?=
 =?iso-8859-1?Q?dCY+JDXTAGVmIgBWBQaRuVsVXUDIZg/3q/mm0DSXZvWTY/sb67Gza1jwrr?=
 =?iso-8859-1?Q?LQ8WKPsH0l5+y8JxVsf7oRNo7EAEgJs1cyKHZyBC80zy64OqdfPmgnX1tp?=
 =?iso-8859-1?Q?H5K3l621q9Jv/HGWY/yXz80lnTv71Uuq5d8QZPiF7MVmVV9gnWHs0AokXx?=
 =?iso-8859-1?Q?y7ESr0Rn88H68fF1EGja9xJceiVU2fTour4nsC14hLVu8wxETBLoZsfMib?=
 =?iso-8859-1?Q?s01SJqMdTxSdTxBU+O1pKyGEiQPCHGl2EI5z0K1Jt3DLRnNp5uOyfPJrdN?=
 =?iso-8859-1?Q?jlWeAf67XW51qbVPWAOjf4l4vAhYVylfrycDekFsjeeQMVvxfIwLcdHhkZ?=
 =?iso-8859-1?Q?5EMW0g8GLFKy53F0xAimzAJ5uK9Y5CmOC/5kAcDmQSzRfq/rF9QSSoRSlU?=
 =?iso-8859-1?Q?64/BQSfJxeLwdXGpwTYX4Ik+WbIfMYb6C7SDnh1JRCm4GrmAt0B1UAkos6?=
 =?iso-8859-1?Q?XUFGy90UKmCi3KVb1NapjfGYx2f7oSTAYTE5ZMoaCCLehvky2K8lAxPad0?=
 =?iso-8859-1?Q?llAFmyIAv0Ca88HENv1rfnd6fNvFaKf4WXPTkYrEkkmd6KWeMYwTlFVlKA?=
 =?iso-8859-1?Q?p5F47/Ea281G4QyLUGLVlrHXAP/leruAV+azqtU9VzVLoDsals32OYWPDb?=
 =?iso-8859-1?Q?EdJR+q/coE1WUg0Gz4/6td4PDejd4Oh68xrrwMcwKDB2IRuGYG5onsY5rI?=
 =?iso-8859-1?Q?l/86j6aKir3hqRaEOuiA/xgC+au/9cFNX5FmiRttYuDGTZvLorNC8YMIyP?=
 =?iso-8859-1?Q?tOg3X38NoXJKOxaGfq55PiH/PDk5AvoP3cwvt2WlD4goyRPDBuxffjLpKA?=
 =?iso-8859-1?Q?fNmkH2FYYiMW5r1Kbdub14Tkd5uAhsUw6qTDL1qNFpbYY+Vz6hUNC5VEsp?=
 =?iso-8859-1?Q?9xi5IH4DYA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YJvzE9CVbTV1Eh1Wu+Jv8m+U62ZDGSOqb6XezDUJoVNEt401xfoksCbJUEl+qNV7zdChQL4YnSxFqFQxbAU5aTZCnawHpko/1RGkngkxX4Ola9ASxSt39tlaWy9RskzvJKVmdmsFAQn1IpdRwekSEk8VyGqNCtbnXXamxmGW7qCtzfhNam9TpXPz04B7NMLKRuJsfoDKK4pZBat3t6XEq60bC3Ay4W8CRUTj3U/bnQvY3LhHbyYNNVp8ZHYUmClb9vhGmmc2kdIfNqYBIiB09N5A0XQQjg3NI8zuIdog6so2TQkQO+Q3wOF4Vcs050VSeOue23k1UFxySDow7/mD9g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64cbffe-9659-49bf-8a42-08deba17f089
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:51.4763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5a0+g4bZ3gXGk3arQE8nw6xivpSazg9AV+rFgGwQ+97c6j4qke7CSSctaxy0A2qpafX5LuUsynlpESRQN5/5+BFfk9E9W2cMIknsTVPDLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6593
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
 hw/ssi/aspeed_smc.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c=0A=
index f0deeea996..3767ad0c7a 100644=0A=
--- a/hw/ssi/aspeed_smc.c=0A=
+++ b/hw/ssi/aspeed_smc.c=0A=
@@ -713,9 +713,9 @@ static void aspeed_smc_flash_update_ctrl(AspeedSMCFlash=
 *fl, uint32_t value)=0A=
     }=0A=
 }=0A=
 =0A=
-static void aspeed_smc_reset(DeviceState *d)=0A=
+static void aspeed_smc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedSMCState *s =3D ASPEED_SMC(d);=0A=
+    AspeedSMCState *s =3D ASPEED_SMC(obj);=0A=
     AspeedSMCClass *asc =3D ASPEED_SMC_GET_CLASS(s);=0A=
     int i;=0A=
 =0A=
@@ -1304,9 +1304,10 @@ static const Property aspeed_smc_properties[] =3D {=
=0A=
 static void aspeed_smc_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_smc_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_smc_reset);=0A=
+    rc->phases.hold =3D aspeed_smc_reset_hold;=0A=
     device_class_set_props(dc, aspeed_smc_properties);=0A=
     dc->vmsd =3D &vmstate_aspeed_smc;=0A=
 }=0A=
-- =0A=
2.43.0=0A=


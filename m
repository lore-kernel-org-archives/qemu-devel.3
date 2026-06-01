Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18B4CD6E60
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjh-0003Ja-CJ; Sun, 31 May 2026 22:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjf-0003Hk-7O; Sun, 31 May 2026 22:50:39 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjd-0002lH-GJ; Sun, 31 May 2026 22:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOURsuLD92EPe2uH+uxFuEeDZrhKVu58dlWHM8STT35L8TZUb5hvBUQtARlPAfkoTRiWphRQnjrdkQjyWQculDpdDSkdtSIkL8lRcnGY/0B2QFdlrsuwVN+4v5R5Dfp+M/NJurZZ4VdB67qxb8cE1jcDise7rg3k+CgDQWQF7TuhMvRPLrs8ntH4kxYxDW582yEXjssqDPFzAu2r2++4Q5DUlpcBab1uF4BPFonmks+Eg5JuJ2sHhaisp3+7IK3KSQ0eWYUSxBrmM8K5riMaOpV5ekrWeFEeMXpGuiLhuFvx1aWibPEHjlKe/0HliDSnvbPCGBMrKH4o0HDj64ELWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFHUF5pvCTKkAq5ghzGa/cRa+WZDPPxnXLzTbzmfDp0=;
 b=SlLML/Fhtc93LRBXthcDrCbym0LHg3Bt2yBnxk/QDGQUfP5wxW4BKqjTVVq0TmtMu3WA6APns2ha204xzzKmXGYg9osLQFobD4vLwn7yWoxppugmszdFI8RDHcjZeV2rneIjQBUVvB9B/n5AYzatY+cq3RPRPhOzhjJIUmVaqZDTHJw/uMlOeV1qlG2rNT8TonHQTNMS4782SLNiWegjnzmMpjQNV28GPRXo2LRkk6Dd0Unrbxevjo0zkiqSfjl91Qo1eCjl8OVOg6nZiJjL2ccbhxXW/MQ+fvIGdxp0p8aTrFVo1ftHgZJG3MDxPLZnODOOcA5O8yiQDH2WrLnUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFHUF5pvCTKkAq5ghzGa/cRa+WZDPPxnXLzTbzmfDp0=;
 b=kGMY7e2yiBg/wVN2DM2ccYKT4W1xZlkeo8rB4G10xzHthGcZqqWkEzXc6Z9NE/Fy8NQT2cpwP5fu1KYOsFOyO7GGFRvS8Ec9rwKq7qRjveLYFqk556REXAu9LfLzhg3/xTPlFyytHJ+7GoZMdbjnX2HYkM9zjQc7O77RBC3ByofnjBoKoxAzvnMyYp0g+aHT33RAlEd+8aVpAbsEGtPvmfIJw9m7FhvKdbtaqW4OH8JntNiMZjJwTWZgfNTQrhVlE/doDicsF6ZXIx29fkwSVMRdk40GIAnU21AbdXQpQlTsgX55EaDsLb4M8WP0Pchmr2WsqsRi9WbvukxiGD/mjQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 02:50:29 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 19/24] hw/timer/aspeed_timer: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Topic: [PATCH v1 19/24] hw/timer/aspeed_timer: Convert to
 DEFINE_TYPES() with inlined TypeInfo
Thread-Index: AQHc8XFo7CTrpralykmroQwPAln4mw==
Date: Mon, 1 Jun 2026 02:50:29 +0000
Message-ID: <20260601024959.2347639-20-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: dddf5772-5351-4db6-bbca-08debf888a97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: nL2prLDrubc9uYnCFs45EJXB9MdIg6SYBh9NUXMvzxgIQatvnlVugJxI7zX0Oggx/flo4tz1kUNk660y5elqSfHZnFsuoPZBQhm+ux36sUDT/uwhPrzsBHEHXKRz8/qEmWNL9HzwrixxbAy1fqUYluFzGTu4OTB0osYuaIGp/by1Yr8LzNpLmXV32sxOmbdTsFx8G2jtJTWlRiGrv8pV5qwsyyw+FOIO6e9EymIO9RH+l5SK0Z84zJSR7iQr3pQ+59tnOwaWbmomDVXyM6dZfNlIulTmHuLvPeIArZ8kIMWXK/HQ+jGZV9QGg+FPjgSHf0bONlEzCsWbssYXREE2TpgC9RYo2MyoP51fHRyGW4W//Atp1krs2SQK8p1q4l+bT745wUFOU6YaX42eR+yp8D7oj6kZ7slaacL+0GrNffKYsJNY27cEZROI0YQfUrkydXO0/6UkS0qKpmUt+f8FmPlYGEGtudIvlTo8j6duqoSF1SeLfzAmfKDf+uX0r8Ng7NkrhR1TIMH3cg3+Nq+uOwhKjhfcc4ZmuuqyOm9NI2eX34UZHlAiuXxsA5GsTWpcLokYyve7pSvwXKZyHg5JTXEzeU8puyuvyUqfPn2bdqq8xf9u2V0TwWNJUZZs/t7vTlxosHRqiVSFhrCTkeGyXcap0dTXLqY5tnDg8h7ePJACtuswvqFJQs21FGV7wUPQ6EaBORLGT1gd8NMfR3ubc/oFpFvzSS60YzIA9iHyR9EwNPI7P7rSrivRa+YBz44Yx/6tGCx9C8eBzcD9b5gbGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R1eUa0IoIbqZMPyE79rbenCqq/j2cGHE9v4tsnwy1rv6772vJh1Cy8++cM?=
 =?iso-8859-1?Q?YilbSs2jc4fLECqzgiHujOqsuid/4jVuPOvxYKELUrG9VM8gBGYXQpFKOC?=
 =?iso-8859-1?Q?bdcvFGbW3kAx3c/VBp9Yng/Hp0nJGbYfmkc06X9CzDWLBYFiCX+HqyuIQt?=
 =?iso-8859-1?Q?NpXDHPx7BQNJcZ0kh3HFNnoUbuB1PYtNPNBJGtNYj5TzBgWFOigfpYn6HZ?=
 =?iso-8859-1?Q?g15OR3xR1maoMsuDwKrZFfZM2t2hbIpFv7ogae+rgtpGW36t6ovXKPEmtO?=
 =?iso-8859-1?Q?s2P7R1URP9XkReUJGCERr+BkoNShQVEQb2ngotzkJ1GOVcKvHV0mPU6ilE?=
 =?iso-8859-1?Q?FKyXLfJJt4seDq7NskumtOvxtRc1VHVaQkGKJT0gCheh3bsweU4qBn3WVp?=
 =?iso-8859-1?Q?3mvlSXJjF0PrKW65SpojnuqgJG5w3E2NbjyoW83VDOSDJVcGoWXAFsXpGv?=
 =?iso-8859-1?Q?B8HI9n4Kyp8K7ZrgqgwcYu+duURkgWesYSam35zjsMUvMuwqFlppMREO0e?=
 =?iso-8859-1?Q?YhwBpFpxXASyLBYLIm59j+utVjnG/gjELCFZOXv4mBShpJssoy8u+yiW3Z?=
 =?iso-8859-1?Q?yFI0RI1gzDZ+LBm7JNfiyDfZzihL+xxVUnRF8VKv6qRgHT+0fQmR4Y9SP8?=
 =?iso-8859-1?Q?6m62pY8cl76DD484FaCdpv5Pe46rRjlAoHo/ly4HsnVHxgKo3PMl1+88Qe?=
 =?iso-8859-1?Q?wDED3ywYlzUpGd+781u/6F4Kolq757nxULApE8x1VOoPbzu8jswoat0o/k?=
 =?iso-8859-1?Q?0/8N5CbjB1mxJtMqThrIZFwDxcRgocULc9uFF0TkLkZPI0oHixsQrV3U+o?=
 =?iso-8859-1?Q?vsp/ITzBvDBz1YOCZwvmGlWcdE16OsWNaU60rjQyg9oCBxvhS6Pv39jWse?=
 =?iso-8859-1?Q?VcGFjJ8g6Iimmv+973iN+cRb6FSK0Wt6TVHOGNfRJ+xpeyTkMItj+1Qh67?=
 =?iso-8859-1?Q?Tj5EKQnCdK40E1atmdoTxy/YZ7cHPjCv7piXeGgyiH06Yg9ErgkBkGUpz6?=
 =?iso-8859-1?Q?LKy4l1j5rPi6YLikw0hO9k3bX4eYC4NnXZGzTNvDgfoxsir4zEywWpofY/?=
 =?iso-8859-1?Q?j9f0bChy7Lpphuox3Th4ko5N9k4nkxHtLrqVCsQ+PKKS1okoE+1kS7GvSL?=
 =?iso-8859-1?Q?pRClg/iI4ylLff/xVvnltfi9ZGtq2mMHQ1Lb3rnOasUc6kynyhubHPfC+M?=
 =?iso-8859-1?Q?fFazcK8ELFZs45MtTYiHnLePb0gS0X2E3wt8O397e+o9vzLVfIXSC5zG0w?=
 =?iso-8859-1?Q?/Cayp+9S3kfhtlFSNBUHVCYdgjvzFf+eKpjYfk+3FLnlZ2g0eW+CPVp1/V?=
 =?iso-8859-1?Q?4r52Kc600iXyPA2IOo7e/dGdWF9i+6T7guMZbEGyfDbTSrIHgZWpq0mkAs?=
 =?iso-8859-1?Q?ke1VthODJfCtIBkklVWwlZmGETTXOSAXUWdmFZJYw1wjyZxVezH7A45Yjs?=
 =?iso-8859-1?Q?srQfEMBLvTpYmvXiRrRo42MAjSjEwwXg/AHwkrkyyczhjoPgTGX1PkMuSw?=
 =?iso-8859-1?Q?5uKNlg/yQ8K9Mw00GNltCRBxNB9dRcEUuhsdcGcc5sIfJEp3nyWBuJFFLg?=
 =?iso-8859-1?Q?40yawIjYayy9vnhuC9lT8RsdAY+41HfH4aE8U2ZPV5dvRJjSONPUvCUstI?=
 =?iso-8859-1?Q?B3W1z6LrBncTCfCBY7MiQo1JO1qGeU2LC1A/++DaYuhETCmODi+VUtMLLx?=
 =?iso-8859-1?Q?xWpdNmM+/rfVvvbOQ73KsUc1089JbNYtajNNRuJfifthULrwVQDWr5XnVB?=
 =?iso-8859-1?Q?OOlK6kU9DUitEmuA+PHH+G2XBxl1N5ZBKi/rcinuRxH0H88oNSWjwNDUkR?=
 =?iso-8859-1?Q?lkhVGip6Cw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QKea74Gb98+AXsiia23bRJ4CZsoHYcmdSTaDuedAtYyGUs+1pQ9PHrjwQTEF95J7Dr3svmMIQL7bPqpSMyS2K39rK3f6TFxrdpfTgRgiMopFW8KZfCYes20ZHpdPApXYlrrLDk7LV493PF8RVckYvbfzWi8y4mM3h3uRwPZ4xhk7vdoASk2vtr1f7dY79r2/hlIG8+l+CiS8RjEdEnnUvVM6YZDlz+CY5opb9zb+hjbC5K5hMKyYTc20ToVTqETT59vl1Me9D/DVIxtqZeiS+8ULRtTg/Z/QAT/o5v+tgjfAWZXsaoDXcIwtnDsGyrQ9tsyGd5wxx2skoTwVA/Gu+A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddf5772-5351-4db6-bbca-08debf888a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:29.4530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9vlXtU1xr6XLCbhVgCfzV+hfilqYh1y8CROG1RFq0B1wiivL5namA/uRxw1P8QS7uVkrzUWn7igfFYoYxiSPMTchOa5wy0pu3E694WSxaY=
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
Inline 6 standalone TypeInfo variables (aspeed_timer_info as abstract=0A=
base, aspeed_2400_timer_info, aspeed_2500_timer_info,=0A=
aspeed_2600_timer_info, aspeed_1030_timer_info, aspeed_2700_timer_info)=0A=
directly into the 'aspeed_timer_types[]' array, removing the need for=0A=
separate declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/timer/aspeed_timer.c | 83 +++++++++++++++++------------------------=0A=
 1 file changed, 35 insertions(+), 48 deletions(-)=0A=
=0A=
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c=0A=
index 69f5c89215..a607736387 100644=0A=
--- a/hw/timer/aspeed_timer.c=0A=
+++ b/hw/timer/aspeed_timer.c=0A=
@@ -907,15 +907,6 @@ static void timer_class_init(ObjectClass *klass, const=
 void *data)=0A=
     device_class_set_props(dc, aspeed_timer_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_timer_info =3D {=0A=
-    .name =3D TYPE_ASPEED_TIMER,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedTimerCtrlState),=0A=
-    .class_init =3D timer_class_init,=0A=
-    .class_size =3D sizeof(AspeedTimerClass),=0A=
-    .abstract   =3D true,=0A=
-};=0A=
-=0A=
 static void aspeed_2400_timer_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -926,12 +917,6 @@ static void aspeed_2400_timer_class_init(ObjectClass *=
klass, const void *data)=0A=
     awc->write =3D aspeed_2400_timer_write;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2400_timer_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2400_TIMER,=0A=
-    .parent =3D TYPE_ASPEED_TIMER,=0A=
-    .class_init =3D aspeed_2400_timer_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2500_timer_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -942,12 +927,6 @@ static void aspeed_2500_timer_class_init(ObjectClass *=
klass, const void *data)=0A=
     awc->write =3D aspeed_2500_timer_write;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2500_timer_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2500_TIMER,=0A=
-    .parent =3D TYPE_ASPEED_TIMER,=0A=
-    .class_init =3D aspeed_2500_timer_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2600_timer_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -958,12 +937,6 @@ static void aspeed_2600_timer_class_init(ObjectClass *=
klass, const void *data)=0A=
     awc->write =3D aspeed_2600_timer_write;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2600_timer_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2600_TIMER,=0A=
-    .parent =3D TYPE_ASPEED_TIMER,=0A=
-    .class_init =3D aspeed_2600_timer_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_1030_timer_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -974,12 +947,6 @@ static void aspeed_1030_timer_class_init(ObjectClass *=
klass, const void *data)=0A=
     awc->write =3D aspeed_2600_timer_write;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_1030_timer_info =3D {=0A=
-    .name =3D TYPE_ASPEED_1030_TIMER,=0A=
-    .parent =3D TYPE_ASPEED_TIMER,=0A=
-    .class_init =3D aspeed_1030_timer_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_2700_timer_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -990,20 +957,40 @@ static void aspeed_2700_timer_class_init(ObjectClass =
*klass, const void *data)=0A=
     awc->write =3D aspeed_2700_timer_write;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_2700_timer_info =3D {=0A=
-    .name =3D TYPE_ASPEED_2700_TIMER,=0A=
-    .parent =3D TYPE_ASPEED_TIMER,=0A=
-    .class_init =3D aspeed_2700_timer_class_init,=0A=
+static const TypeInfo aspeed_timer_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_TIMER,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedTimerCtrlState),=0A=
+        .class_init =3D timer_class_init,=0A=
+        .class_size =3D sizeof(AspeedTimerClass),=0A=
+        .abstract   =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_1030_TIMER,=0A=
+        .parent =3D TYPE_ASPEED_TIMER,=0A=
+        .class_init =3D aspeed_1030_timer_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2400_TIMER,=0A=
+        .parent =3D TYPE_ASPEED_TIMER,=0A=
+        .class_init =3D aspeed_2400_timer_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2500_TIMER,=0A=
+        .parent =3D TYPE_ASPEED_TIMER,=0A=
+        .class_init =3D aspeed_2500_timer_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2600_TIMER,=0A=
+        .parent =3D TYPE_ASPEED_TIMER,=0A=
+        .class_init =3D aspeed_2600_timer_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_2700_TIMER,=0A=
+        .parent =3D TYPE_ASPEED_TIMER,=0A=
+        .class_init =3D aspeed_2700_timer_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_timer_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_timer_info);=0A=
-    type_register_static(&aspeed_2400_timer_info);=0A=
-    type_register_static(&aspeed_2500_timer_info);=0A=
-    type_register_static(&aspeed_2600_timer_info);=0A=
-    type_register_static(&aspeed_1030_timer_info);=0A=
-    type_register_static(&aspeed_2700_timer_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_timer_register_types)=0A=
+DEFINE_TYPES(aspeed_timer_types)=0A=
-- =0A=
2.43.0=0A=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B70FCD5BCF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN98-0001w1-Jn; Mon, 25 May 2026 00:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8m-0001kt-Ka; Mon, 25 May 2026 00:42:13 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8k-0001K9-Mx; Mon, 25 May 2026 00:42:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJd2FLgwbo//ep6iRPIz+mcVj03YiI86/xNRNSkBLxQmr0RNwBuxRh6uAYZdm+Oia3aGmWIPALNg4W4Y8HcZY8UEe1THXZ5TEhtwwnWcxfwRaeeQ4gp1mbvuClj1CvaV5MTQav5NU1LkU/M8OhIBFj3DpFllhfafl3kpfkqlIp8RWvAAFk80oCdC+1OzI94AXRv/qKNNFER03K3jCR9b/nxreGhhVGGQoaoE84dmdldR9cs2SQFQVeOD77AgpoJKQaM3GQsJZJ8y5N2PMSc9u8KDGbooSXdVs24BuThWW1OCLtkbZJpGS+jsc79a2YRhyKaeXPCbXzndzuxcwCcKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nj/3Oytw8lbTkxU0Hwv02dmqa82vfiIWlVKKEBpMXs=;
 b=jsnUoAubIWhwrAuiAjsuZqFQAvx21xud6WjkpMoLYygHwzQLE7/uLCaVR0Lv+0sUpJumKV011JmW6NuInbHlzX4XobMTaGnNg/79Mah2Lb6PFUAWHH/bM3uvdC5pzVlO6bkxNN1NwzwdrgBYjeV+YBGdC7be2PDgMSoG6RNOrurOBe1kwOyxkB4nFwfIvaihg/ZoHeyPLclbDaI9Ro3GwQMN0gTOw6f7itPjiIVU7/bweezUXxqWsl3m1B2FaFVQLoJTRixD3ATSHOdSsexcd2aqyykffmSOBKiamC25jBa1qFPk2wrXfR08hZ4L0JH0r4KiPFp3vg53Td0U+WjORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nj/3Oytw8lbTkxU0Hwv02dmqa82vfiIWlVKKEBpMXs=;
 b=f2+olb+8waVvppqEtdvpld8KiDVJ0OtEZBBcY1inGNoROoWDHIiBjsrSm3UiqS8rRCuLtDVhwGDz1eexfh1+V8wFmW820G4iC5iOc+WOxbGuLSk26vlcI19PQPZAW0ZlzmoIZ7+0a0P4mafznNrKAAbjK9A8EIompirufTnxIWCJ2ZKk75F54DbyJUfabSHcl1l4IfJNpSkLjcdqFDDTD8DF/15MWUVnHopADie2NlusSCsORKrY2RkUSxhoUCdQeemayA/WaC0db2eELfZSzVPjo6zmdnn0ON9Vzyw5U7iKNchl03pSOiOo4CoO4mjo70uusAywCtidtw63Af5kCw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 04:42:01 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:42:01 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Joe Komlodi <komlodi@google.com>, Nabih Estefan
 <nabihestefan@google.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 21/23] hw/rtc/aspeed_rtc: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 21/23] hw/rtc/aspeed_rtc: convert to use Resettable
 interface
Thread-Index: AQHc7ADTVp+c3o9qWkeqBulcLQ+Fug==
Date: Mon, 25 May 2026 04:42:00 +0000
Message-ID: <20260525044129.3133916-22-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEYPR06MB5111:EE_
x-ms-office365-filtering-correlation-id: b9fbd9b4-1a65-4596-9df8-08deba17f641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 2mZpC2AfSZWECeaI2iSZbdpiTB+7s3GDjEtZnwYHoSa2DCIfJKw5ISWrsYmGN+H3e9J8b0vETDeoaftO+hjZgFn6jh/hHbqIXV2v2ilxPKJJVjWWxnRCEUObCl5FP3o9KfVQpJUsi5i5JCaLJthgyfi8pIwqfZoEWydTA84p95D+KJwHSQ1uMoUpKXbk7JwbXQdOBNsE0a5ZW/xdycE641DecBZQ29VgMiX8wbAS2PWnWhmi2RrgxBlGE/tURSADGw4Ciix0rVMdo0l2hxMSrZMWdfjgAqwGN5TaJ+ZWHtBx6PZzUYh6MU+Oc5tTmFrBCoqvTsW79Ftn+GyBylZ/LF0xOqnTMN6QfZbb4vrHOaTbLrBmEf8G4VgkO4eUvbnjmRA3vs2g1XQstuadTUE2r1iUFqBYrlVH95bpCwmiPS4ajBSxhKkC8rNjPW0DWSr9dNnS9U0feZfKXWsv6KAoFmKDZBifgrR8X0cbCzbKlkr4tKBA5BYR9a5buxO9zLn6QGl6vyCT9btoqFLFuusp1EFrjLItm8J/YoTUbRAS+A1mVlsH1AkuRFP9QkGWAcLqOmQvRfJrkB+LEvxvorbw6q2RqIbELSfF+CoquT2qzTSKVs4x2jSwU/nTtthojX47S0P/+XBu4P7AoixUeevfTrcyRDMHjEroMVoitdpmsQRJOOmKLPVakUanhUikxK04vmkIlwdZOrKh8lbtx1SZIVIDFOtUtwvSwMbrDTNXypsrTLPjqYrBpbbkx7unuDj1aMns2vLOjdUtmdMkwEwBvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F7jGmfxTMvA3T3WIlykDYGvzH4xvcpOWBmCFc6sXoqvgxRtxlZo63Ga+Mq?=
 =?iso-8859-1?Q?Eg8vJC7Nnmj2Hb2Eom8aJsYKQNOuOFUDehQsOzfzYJYsSZhedb3Nd5c1Ft?=
 =?iso-8859-1?Q?QAge+X5SCYyfQLITERbvUBzpWiNw/thMTiqYEpxnbSQaraSLAejCrkvs+/?=
 =?iso-8859-1?Q?L8U80z4tJjn1f45erxYbdlr2kgbvAjxtjB6QYxnGScbFQNsT68uFKwaID6?=
 =?iso-8859-1?Q?DLxl4ECezZz8Tuq/6u5GUXAXS/zQhY+pfjbcXgtWJHNphmvveiB5c1Qo4E?=
 =?iso-8859-1?Q?3RHmWPMX1QXBQzU5fK/X0wm8Id/2eBi/gsZUOitErooBtOqChoTKud7Sbc?=
 =?iso-8859-1?Q?unugG7uTF591Ert91apApZgXNwU/i6UjJTsdw7On5TOXzj6X26KPYMdRZt?=
 =?iso-8859-1?Q?DtCtLUjvKWfqjaBxf+/JEpcPHqw8jdwOIpulyuoAZBDJSKFT/bxXCmPL6r?=
 =?iso-8859-1?Q?C7GSUf6+dHJXg276t8+FSC3XvxsaD4yBB1kKxtQH1g3lNRUbCqrYqFmkIH?=
 =?iso-8859-1?Q?UuA5EtJH7JTYxZmtKDwEy+qCrPp/YsbCN3giI2+fQrfuWtD/vMQUX2CdHf?=
 =?iso-8859-1?Q?le37Rc3TNrxf6I8YYWyuwQuqI849y9MuDf3rszGS2jPUaaDDevacy3e2+9?=
 =?iso-8859-1?Q?9n250/CU7tXpxnCFKxIQ5sSXJLZ2yuiKou76yYWTZ2pOWJG669O/kkcsXF?=
 =?iso-8859-1?Q?5Ov22KetjAWSLhElHPJuBlkFDx+rEfeaug56uW+S8puE3AuymmzBMzNZOb?=
 =?iso-8859-1?Q?dB+ehGhR5ZYUBJsh/p1QTry8rJxsf+Sac5bGz0VsWHcLQ0iZa5bStQXJ/5?=
 =?iso-8859-1?Q?b6fQ2S8KP5EmSEa8HwOLugVjry6dv2lljuOtqINGZzJIYLqWkG2XgJc5XT?=
 =?iso-8859-1?Q?HckRJ0d3cVGrVM0MYqz+uKvVLML7xnyM/c/tUhpep2zxWLsWl2qsduDQyh?=
 =?iso-8859-1?Q?JuX3mnC8nb26kgReB9FrWsS+NA/xGSGY8MuWyqi4PDytKma2JJ3Re6TWrF?=
 =?iso-8859-1?Q?s08avlctsG/Qp6a23lR9Ef1f+CQVslH2o97eYSpAToCaIu7StjN62b++2u?=
 =?iso-8859-1?Q?cNqK1LlaVOHsovF+TC5FH8GdOAVD7rppKfxzekBdk2Cr36KUTS6vcCSsAA?=
 =?iso-8859-1?Q?VKgBsqkoyHWBrnm5CVaU1jxPku4VKqwFHP1u2A2qDcwgewe/CeyzKCVyuI?=
 =?iso-8859-1?Q?0NWgNtTbCoEzI4GvM/N7Otzt/7KnnvvZG0CNlH6JIZXvbc5UdQnARPQIek?=
 =?iso-8859-1?Q?55zKfoHmL8YcGBUikmkA9SNnDdfKD1TGNsDev4O1OmaxCjO+gkZX4ijqxG?=
 =?iso-8859-1?Q?+5WSLsXsl76dkyhznjTVi01tHOjTTJrRoVdZ8eheTxbBeJvzIOvxghGcLA?=
 =?iso-8859-1?Q?n5nh8miSrCkQ++vKG6pZwEUIEVfAfA50IVfJ00aUFygW6xP1MQjIaXIqGc?=
 =?iso-8859-1?Q?5PdrWq5UDj51ZsM0SnpS8C6MwkVmKIq1jm1Pb8G7i6OkfGRktSrFQ8UOxv?=
 =?iso-8859-1?Q?+Gqwl+x5B1Nx/8VvOdBuJZZQOJk20bbQ1hN2yROVZ0J3oPfheFr8wKlHjZ?=
 =?iso-8859-1?Q?/y+3ih3veelwpuG+XbgjVVEwjtXrCh373Z8O0S8cSQ0lPAriEya6j27fhe?=
 =?iso-8859-1?Q?F3UFtntSovJfFfOSPEuPeFGU5CIz11kG/rFGaVEGeXSqCUjPTzDMBTPRI4?=
 =?iso-8859-1?Q?7P18RvlOnBcDlS9ROncyBi+bMru4wLfZ5j0D0nnPSNp1BNMR8GWW9EnPEA?=
 =?iso-8859-1?Q?3xWq36UuCxc03TD47PdoD2tTAgxcb/5SWXqULjvXom7AobNOhm066UdybO?=
 =?iso-8859-1?Q?Xz7xZZtzRQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z0Pyx7ETDpXcHStQiIAvyta5BRHau1XXvau2osK1piyfjmdLlpCCFkab77X1noQY0jlR6tblyH2gEOppgbPbR5d7POoU8eMiMgNUOtQn3+OM54kYONdv5cytqnsoi4v7kWxnjhzev7XDa1U7dRvdMoiqJQzGbVnSYOHFQA2iyT55CPqqL18IOTGspuO2f1/PsEXkZ4GDy5MZPr1YhNdqQrXDaljYZNYW36zwQmlIMLBum+o4MNNkK0O9aRe6FMdnHCXrlWTKTB+qcWh3nlUBe6J9Tg+uh0btUOdTcpE8OvW+SDZ1ByNe6wnG0ouq/VOwC/Sv9qRHJEgPkRT03WN4Ng==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fbd9b4-1a65-4596-9df8-08deba17f641
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:42:00.9300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Szr7Zxur1yj46uaSgoH0a5b8Hw6NsAvzthn/019m2i0XRE7Ntpb1qIKt5sgPhd589PIEpPUTQvZ1bniiwnKwVZsOJwOc5Yws9UttWmQMyss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5111
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
 hw/rtc/aspeed_rtc.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c=0A=
index 6793e253f4..5245f3f956 100644=0A=
--- a/hw/rtc/aspeed_rtc.c=0A=
+++ b/hw/rtc/aspeed_rtc.c=0A=
@@ -120,9 +120,9 @@ static void aspeed_rtc_write(void *opaque, hwaddr addr,=
=0A=
     trace_aspeed_rtc_write(addr, val);=0A=
 }=0A=
 =0A=
-static void aspeed_rtc_reset(DeviceState *d)=0A=
+static void aspeed_rtc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedRtcState *rtc =3D ASPEED_RTC(d);=0A=
+    AspeedRtcState *rtc =3D ASPEED_RTC(obj);=0A=
 =0A=
     rtc->offset =3D 0;=0A=
     memset(rtc->reg, 0, sizeof(rtc->reg));=0A=
@@ -159,10 +159,11 @@ static void aspeed_rtc_realize(DeviceState *dev, Erro=
r **errp)=0A=
 static void aspeed_rtc_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_rtc_realize;=0A=
     dc->vmsd =3D &vmstate_aspeed_rtc;=0A=
-    device_class_set_legacy_reset(dc, aspeed_rtc_reset);=0A=
+    rc->phases.hold =3D aspeed_rtc_reset_hold;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_rtc_info =3D {=0A=
-- =0A=
2.43.0=0A=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD83CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN9A-0001xC-Vi; Mon, 25 May 2026 00:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8e-0001iB-5m; Mon, 25 May 2026 00:42:05 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8c-0001Iv-JC; Mon, 25 May 2026 00:42:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXl/FRH1fzPQSwjmeaAdPDA03G8Nd/s0+rFi9zq6RSniP3led2gSKsdS4De/6phbVeeA1r2CAcp9TAeDnL7IbHslztzxVNJJNQbDD5+QySZL8UwNHxPU1yS4aA5tz7Gm8eVpqxZXHD2JqHbbd0PUmtIZkgoyRkT8PNdm3Xm37KxRbnKo3pHfMU26iRHfZM0XY9nfqLmFH2s5rpD6B44MD04kFObmJvbtUaSv6TWoqF6PmYs7DWq6PiWwj41SFtHoC2XV1/nOQnjtqyE+4ZmjWQkqZBR9B4gRJNAS1Ms3nJDmK/luiIhPM9tKfP0V9ifp/zAN2aa+G12/YvLWb8XRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOytIMFhGtwGyBvw0xGfm6OzqdDhn4eX6H3BoD7yikg=;
 b=cuWnlt9N5s4dh5LtEMBc6rkJU9W45Z9LadI5qG/qQL4IetmFeqmVi2Mt8J+eDmFs2Q8cYoBfmOtncRrMFO2R6cw2lv+nI/GqZusIJb8dxO8HiUKFnYXgzDwEyhpqIO9d4lsdn/IFIrGdrcYfkJeIeqdTGnlpMty8/t0otb0XKREVT+6r4W5hz1H0qRJyRVjvLSZKQIytu1L9SGqU0bDb9g4DoJxXA5otTLErkyOUa6Le4zGjhqiKcvWZ2eVnTMOSLvadQ2D0EUxud5EPns37oLQRohnq+BG+CnPhXPo1fTFxosQmkPQlQi0p4dOJ7BwjJ2nnbWpUBmIFgJyES3+q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOytIMFhGtwGyBvw0xGfm6OzqdDhn4eX6H3BoD7yikg=;
 b=WtnG6XMASBL4oRsQ3+VCeNH8Sv7xRFg1bIXGSHcXHtGT+E63DT6LPuugf4Lvh96aVpmjd1GI2LYS/9M0n+9zPefSMdTTk2PFVCndj2Y5E1jipraZ3FVH63OSYC7EQLzU80t6fLbiiiz1K3qCfhxHMwBZWwrfeN5uP1Q7sN89OgpeFvmN/HajNSq1GypOCCRfAd9+E/nLlK0In/Xigt8E9Fa7OfV3it7w3VLPe8/DHTJUI4moRxvStUjR+cV9jQNOZO+LMTS3qU0djZAZxdv6Q5zpreA6eqha6F17JuecV1wKmYfRgsFo+0w3cd3bzi0sUpOw/1/JN9+/u4BwA6qz+Q==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5617.apcprd06.prod.outlook.com (2603:1096:301:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:56 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:55 +0000
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
Subject: [PATCH v1 17/23] hw/i3c/aspeed_i3c: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 17/23] hw/i3c/aspeed_i3c: convert to use Resettable
 interface
Thread-Index: AQHc7ADQ+IyRT2ZamkewApW6MfeUjw==
Date: Mon, 25 May 2026 04:41:55 +0000
Message-ID: <20260525044129.3133916-18-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5617:EE_
x-ms-office365-filtering-correlation-id: b450e4d0-4c79-4eaa-71f9-08deba17f2e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: 5uPqT7KFbikQujNTopahGzwZUhPFm+YXyxaMnYYBidyVZsF3m4SgbKVDoM3Qx4E8zpf5pvkXnu31cIuUTj+yu/oiWceFa1CD0SpiL75frk2lB21dEp7T+IJK+ei37NO72XSx31BJefqb4fcGnILl9aI1AgFpNZroFWG+sKoecuDUnkfRceX/MwCpMS1Q23jt5QUv0gMz0qyqyj/4DdhVGNn+6xFZhZCxsuhC56NETktT1VnTv4ugcwyVsGUXpsueKMw1zyqP4TFOHTUCZ+pgSNDvT6FfT3Til1XKfBDeZ2siT/+xp6M31gsmMCa07qjb8N/F5BHDjuHwXdLgv85Vy9IaTJH0I+GwAPcvb+Czlok8TOu4v02OVMGv7lJJ9VaIsl+fIfv9WDMsDphLfVPOiIwP4CsA5rmKNriRk+YwTGunskhsZBrdHTpayuOqYASDgCCOK2k7Kb9+gsfdtQrtTi2Vv25z8Ncvxx4ktc7fhOTbGudBuGQhz1VKxKKdM7GnAmsXTB7FQHg37YNz5G4VYPOx9SjdyIbMTdsY8RWAddOltirtsyUltYUwF73TGnUqaro66XKqMcNennjoorpQ4lgYd8hYhzfgJ6tEXE/HBTwrE8jSaKpA9+MoGBSsMKomf48ACAv/Y1ce9cpTS6/1cRbGC2WDcYMOZptheJeGhRpnkOZ6WQrNpRRKbynJ2HBbeP08Gn4sZsmwOR5mvXwHMsDEo27vcvf+I4M0mhKmXjUaeAEYDnMXDImjHBejgsh7S0hP+FN30pFcOU5YuxFYCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6qBt7h6ObaqmAnHLwJX8Z008iTODsZHv9DLB5S0dCInJQmx1ElW2XgImud?=
 =?iso-8859-1?Q?38DetAwOtgUsvzPwK/scUnpoAbufjVBeiCdpvBM59nmGj21NAzrfNl/tuH?=
 =?iso-8859-1?Q?jfiXW3VXecnskBQ8kwqJ3DCkEZvNWXpzKWKhHux3hVhh/wexjPnNCiStFx?=
 =?iso-8859-1?Q?AGW06MCLCm4/zE0cZLFxxX0NEk1xTDZfoQfaI23/3nVPoIEmnYQC19wsrv?=
 =?iso-8859-1?Q?U017IpMDKzmpzxMDu+6NUqlq3Fn3cveGJCbk+OM5QCk0WEiTQ5Gmpu7AuN?=
 =?iso-8859-1?Q?Oa2v/c7TrzhIlCR5M6nsxnMifRa8wBSCS01VNu6fY+BDZHsgxhEFREorFp?=
 =?iso-8859-1?Q?k8Dq1b0EYhuqfyUqfSJXH3vXeHpiz+UDmPjkXkR2xI4Evy0wPDN7pzJ0TW?=
 =?iso-8859-1?Q?uPcebe+HYdz4siJfuriOB9gshxzLpKOvqR3yxKhiVmFS3+uHi9wSSID+Io?=
 =?iso-8859-1?Q?RLYh9OVI4dY3dv4xZZ7/lIznzLFojr/oj9x0i8joqI2WIZonlAiCZ0LCQ8?=
 =?iso-8859-1?Q?LLzIPhma1KJcGgT7VaxdKWuWP96at8LExY0NzwJxgKPBV6eBA1EEBszOwy?=
 =?iso-8859-1?Q?6jZc0mEStHgUxs2Qn0iliQxZtiFvZ4hH5XFNxC0XzLOLNzZPLNAGx6aVzU?=
 =?iso-8859-1?Q?jxogiXeLFwoK5A5zHAEvgO1VV1Raziun6FihBhD2p4J5+RCSEy4EMtDnvm?=
 =?iso-8859-1?Q?mlNuq/fWhOuE8ugKCt8bJ3y5k9cyonuOamZ9tDPeDVc/D8oRl9oNj3ezeq?=
 =?iso-8859-1?Q?uu0dty+NauekjuAZJdva48bYGSn0ZmyeDV0hUnXNz4e/5JuJdFRaN8M2Fn?=
 =?iso-8859-1?Q?h0sRSxmt7e2uTSrRJR8YS5FbKiuRXG4Nt/Plyv3gW2w/0Fhhbk9i78B+NH?=
 =?iso-8859-1?Q?CQHoWo37OgL1JMhALLt1bJqxhhIFO6OCpaP5/X41ErhE9/7MA3h66YwyCo?=
 =?iso-8859-1?Q?aDpPC+N326tjx8XmVeHg329XY7tklO73Vy0dZQIuSypFtP+NIvZdoVdgjf?=
 =?iso-8859-1?Q?7DBTeW5P5Y9fUZEK5j6NFkrprKCsjtPxCEMeyXrxC/Z5VuDGzOTS8Rbd42?=
 =?iso-8859-1?Q?sEf5M0xD2Z5BTHztXHYGyU60UHKEHXMxONtUchragk5P4+UOl9e16Q4oW8?=
 =?iso-8859-1?Q?bhVTDNxHNgbkwzUmMh0iaRINbZlOPlT0veHIxMliBE5EaH64dps2n2xezq?=
 =?iso-8859-1?Q?LetKKNw6qKXCNGWxEwz/NN73eeOliDjlDN/hXOZ67CvTlX2Q5bCNXz6WLt?=
 =?iso-8859-1?Q?O2ozcTj8AYbBUw4dzHIkFNtR+23l+evSRgKZ2mznKx9k66Lj+ImDHt1yIK?=
 =?iso-8859-1?Q?2yQG9sSUdF0hgq6o8JeepyYB37VeNEWzw3yCnNM3LY6Cf5HWwSBx/nTwZk?=
 =?iso-8859-1?Q?nYLDLgyiqLBnI8GATMNO5HjPMxgBew62ERDN//+smW5aBgwJGJPfRMgWsZ?=
 =?iso-8859-1?Q?L23VNcdtzaG3T6RDUN3iPECGSqPp+s52LT4eHdaDc8Ncxdb5VlaTM6Qyyy?=
 =?iso-8859-1?Q?bLRFa24v5QK5DyWwkMvmXICr83DPfPFVj7oW0H5L7dQTg2dgFsTsmTX2Xu?=
 =?iso-8859-1?Q?hvpgBVlIHf8AjoVRb2bUElYk4MOEzcrd4SqpXgAMcwKfVm33sdv/Ks3U6b?=
 =?iso-8859-1?Q?HWbjjiEyCnxoVfOu6ycyAQB0Lw9MFiWMQGECMe5aI0st0Uew4BzRG5DsZh?=
 =?iso-8859-1?Q?lj4xELk5oOaPw3mAq9VYsP+YtgrAIo/RughE79dObvsB1+7Wngg/TWXsdj?=
 =?iso-8859-1?Q?eDft5h9RQ6lUAFXZRsyoHEtAB2Ikk2oKElvbhy06RifXWyMM/cxY35soDr?=
 =?iso-8859-1?Q?sJ9Yyigm6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yxz3lHyH8izKc4Xz92qXiRbydINVRC79sGNyEhkRECahUknKzHigFc0dxnefnBMKgUA3zIKUsKLQv40RyIEJ6rqinVC/bX9Z4r/RIVc361xo2LRWSC0xslHsFj7/5qMj+SdhcjNBGkdkEqXbVfn1q9fRhf4RgD1GqJCbdiTSTdeh0S1MtjzswgpChLPTyOTAUQIfRhJDiT0Tt/OGSXLrjGn9GarAt5jZd3/kDvSkRTSDEoLR+8EnmVuqlaAg0WXnN3gCe68HCXGjlynXUOaWXntzrV6mnqyUYg+WwlaN9DcP4NoSJ+9UBNAkrj5g0UoIkWnsn9ebBkMHe1ISNSwYSA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b450e4d0-4c79-4eaa-71f9-08deba17f2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:55.5119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGO97l03l0TC+qr1709mHAiE0S1fDtkr2K/sVMYJ8H2zN1CYyc0ohUXBOvPM/rhnsdHSLC+vMrB3h2PdSho2RWjrC90pZ1OUh4EBupokCc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5617
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
 hw/i3c/aspeed_i3c.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index bac8c55bb0..de61d67dfd 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -162,9 +162,9 @@ I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t b=
us_num)=0A=
     g_assert_not_reached();=0A=
 }=0A=
 =0A=
-static void aspeed_i3c_reset(DeviceState *dev)=0A=
+static void aspeed_i3c_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedI3CState *s =3D ASPEED_I3C(dev);=0A=
+    AspeedI3CState *s =3D ASPEED_I3C(obj);=0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
 }=0A=
 =0A=
@@ -238,9 +238,10 @@ static const VMStateDescription vmstate_aspeed_i3c =3D=
 {=0A=
 static void aspeed_i3c_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_i3c_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_i3c_reset);=0A=
+    rc->phases.hold =3D aspeed_i3c_reset_hold;=0A=
     dc->desc =3D "Aspeed I3C Controller";=0A=
     dc->vmsd =3D &vmstate_aspeed_i3c;=0A=
 }=0A=
-- =0A=
2.43.0=0A=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF2ACD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqw5-0008JP-10; Fri, 29 May 2026 02:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvz-0008Fy-DI; Fri, 29 May 2026 02:43:09 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wSqvx-0002Ht-J5; Fri, 29 May 2026 02:43:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIAk265Fat1rx0rBdMxaG+OhTlv3iTDLsN/hcb+LWUdaomfXTtYFPH8a7Xq+XbUytwsCWzGC5Fm2rS8kbZRKbqA4OFSoyiIaMro8M1cTdFM16acbUJ8kb4maQMDjXvqBrViDT1oWSjyT9HRqw6pjN4Zc3ifEZc1tMKOFvm46Ch9IfC0UMUs1ZtcaAjX5FqnjkwkUlroUR0N2HIOSp2Yfs05fhJq/mXotr5e+YB3ePnd72OIpM6dIR5jwxui0blI/Hxl9bnXB7yxHdcn2l0QH5xVkn7RFgmBtDzg/2FLqHJMJYyhPGZYVJrqXHJnd9WlA1IJ92z8VLXMviOZAC04BOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNC+DbuhOi4JjB70hgIefc7cKIYTh0wz1Oj5Ts4Wneg=;
 b=RaQ+op+4iv07T8EWDifOZCbaXoSbKEPFnN3OaihNGwxp54mO+CADdr49Y3qJS0PhGdsDDCxpY6gRSmUAYb9DuT8lZ4N9izMhZSw+nVL2uMv2/cBKzxzKy38rdzZ9WnylGfpKmpuJy4Zz9zKGjLmFydjzehDCWudi7ynvFXnreEnK4SGfgaJddzG1mdnoKy2cQqMvEuJwdy0Oecl/+V+gYUVWQSkEN8i00PhsfZOkxrCQBiqTCRw2JOxCk4ofKx5HtXgAjvWt8WRwHF2HmaPgs/aJEZ2f7fHRbyH2U1u+SIF1aDhmELmoeNFImRdigl7/1Ot09dKYdKgq4HmnBCnuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNC+DbuhOi4JjB70hgIefc7cKIYTh0wz1Oj5Ts4Wneg=;
 b=do8R9IVmMbfVE85jqt2XceH2Ezc+8TfpdGcDWj/AuEsNjLTJ5Yq9CwOYo0INQ9UhXaP4SLMNGCuLRIrcmRrnWlsxsquRbfgEsE0KlUc1pYDZ51JygorLmKkxkarpnyyaRiOQrbXcquW7YOa6tRJvNYOTWsETNzK95ChrSdlavcq5xbT+/GYj7P4/VR55Ppj+5YlTo9d/TcxBWkiao7K5vMlIabpc22y0LYuRq78QKXKninlnT9Vu8BtpHOcdZm3OzGbCVN0FHtmTWpYOFgiR+bh450Vj3NJQKY5ZDrP44I06HeGTngZtB3CoMV8DlNC+bl7YqcJHPAbXbBbYG4eY2w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYNPR06MB8451.apcprd06.prod.outlook.com (2603:1096:405:3b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 06:42:52 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:42:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 07/10] hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
Thread-Topic: [PATCH v1 07/10] hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
Thread-Index: AQHc7zZfJ/DGFR9jj02PJYaIajPf1A==
Date: Fri, 29 May 2026 06:42:52 +0000
Message-ID: <20260529064243.2064188-8-jamin_lin@aspeedtech.com>
References: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260529064243.2064188-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYNPR06MB8451:EE_
x-ms-office365-filtering-correlation-id: 11c33e4e-a04a-44a1-b2ce-08debd4d81fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: 1tlTbm0w+Soe3NPtDxngoMeZ7qheDIov6TvXCxw+Mp56HxsL9wuD6exgJQ/yAJArgWOSEi6dCz6qY+OfyBsgbOio3NaNzLFOtmFXzSyzqLDPk+Nt/tDMUK4bgyZY/VVMD3yK55bt9z3WkCIxEdDVDedHIg1s/GC0RtLZD3ZUpGknj5hZBl22UXYJaeUCISkXXnLMnPvkEstvQJ4GO5G37xPdAYcXD3Mb7rY6EQTcsniVDl3fl6TaVHmnxnl8yMy9mS4/5mMOaWp55j6oHo9CQMTCpvmFvARoLu1qD4pdX9JfP3CNaow2tDYH+nQUp0XtzcCj1ikZz8XZoirT0KpX04MQVLUNyseLy7sXS00S4a3DAo1WnQL+zpLBFQy6hxcNKh363E2jkR5jAp6gumWGD86r9egF/eZqDeONu6f04DOvYKXVtpAmJueWxNlShinWR3n9QqYf5ZulEd4u8zhDgV0PiTdRD+V3LbbnhJAdYhIhwkx7/0ABLtKHzL2dLjhjhyFYBk/nO4Z7F+tkb5X4xqscfQgs1bzhOMs32zMdxRmtXJRAK0L0hRtk18LfYYykqdooI0HuhxofP6HVVQCps2MFWhNYQPrhtAm+qPP82o+3wvaGIvsWc8M2qlzG0Geap9uPJAJeKMph7tl4psOTzHMeIeocHF8zq1WjWzPoYQWFRxI1JG7Ja7f8uqQ3NwxgddGxnBcOuZa1cIyN45lmppFxVUA0exaHpuklrNgXX4nwb3YeJBJfaS2MDc7SVDyt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X+pcC5eTVWf72GPDsdPlkM7aH4TuRRZxXuPkVE8cs+CRvw+h+8lKRkOH4O?=
 =?iso-8859-1?Q?d26GR0RUo1GJi0Pqc449U1b0/h1vm7L4k2vh/i47Bq7vUXrzOd58+EUjiW?=
 =?iso-8859-1?Q?+qymJ1YmzpOzmvKHYR3D+ulXszTKWelkcY/z7Wz8BnzUCQiQw8L/g2S5rj?=
 =?iso-8859-1?Q?vpBQ7psM0EbUrZKw2RfHGvC/CV5VWh+Ia+M6sEMsqjbjFmqpnai9O19sqx?=
 =?iso-8859-1?Q?AergrBDkXwL+CvfNeQ868Jbneuz30G5Vkf+KMQNqRqIzrm+nfCZyVWwuKx?=
 =?iso-8859-1?Q?gjn1o8BFMeVfQvhIIlMLdc46aAL73WGnE00jgynjjFTMsgQc+H939x728M?=
 =?iso-8859-1?Q?XhVZrrv6EQIZU/pNWtnDllBhhhWdNm9IdfJiuVI+aikFrSBZbIrSROyB7q?=
 =?iso-8859-1?Q?I2oawtxPbvBX9AzeYuGo3qhtDtlBo8oA2z+YtiPGEixW4u92MHzS5JhcnK?=
 =?iso-8859-1?Q?3DGmPMfjwqBrcF+eM1FoaDXClaviclKUypgSr8eeDScn5Xa93Hgi/VtqsK?=
 =?iso-8859-1?Q?ZktQ5fAe6Cc8ftePhjg14dYRuptEFOt9s1qaZKjAxDafOjug0gGupV/mRw?=
 =?iso-8859-1?Q?4o1naJ+M1+iR4O26wgyA6p2kBzckaXy7XnMWAs3/UH66f4BtcV87vO+sdh?=
 =?iso-8859-1?Q?Cp5DJPBhdvNcHHQwxxHfpHlrVJf7/MfAwWS6P99G4upHKQGnmSucIUWYBT?=
 =?iso-8859-1?Q?LHooyFrp0QYs/Zsz/6BEWr0QyFXGa7znTMQKikympqEHV5p+f78OQdtfuB?=
 =?iso-8859-1?Q?N6Ng2m5KtncsuFGvW74MaUJnnbjEoKcxG31skVntrOl1ExYGVKABjeFIr8?=
 =?iso-8859-1?Q?uWscJVzMnuOsTxtb09XrolfdtBim/iLfGoOg0nZ99eDfYi/TB9CD24UkCC?=
 =?iso-8859-1?Q?rlqYooM/GEC3NSFBRDzNWvL6fmPD/wptmTT05z7MQmyOfQ3hgncjQUsSlf?=
 =?iso-8859-1?Q?hTeDOW2yNfDDJw0wE+JOKoz3NPhXZyvFF1bIZOjjpUYfEnwOdk2rhkBDdp?=
 =?iso-8859-1?Q?NdxjTwG0SA2d3uRKvdu9UUzNFLzOZ320l3sFYnbni/phc1GP6x8V74AKX4?=
 =?iso-8859-1?Q?Mi+6spCMHe0902eI9nI7Y+6GppTFd6NdpdaQ0eeoZJjWtMTOM7TioqJbvs?=
 =?iso-8859-1?Q?ZjahhWZ08gGHZAeO1I6wseSErytef5lt/u10RY61hmNDqXdr+aj7NaecOr?=
 =?iso-8859-1?Q?3y2ZC6NtU79gEKaRjamd52StzIeOES7fhkZJVRtVVwvZ5PWo62F5RvXemx?=
 =?iso-8859-1?Q?3tJ2qerxCmNVJR4uWOTYqdoqIsLLe7oK0AI8K+yMMNbZSinrYgEJhTO4ck?=
 =?iso-8859-1?Q?K3lD4Wc304cknphyjmcqOXslyyFugA+OV2SA1tik0Se0OFauGb2hof8unL?=
 =?iso-8859-1?Q?G0VU3YeETURn7j0WYetLLJCnxQ2LyTTSJhIT7S+fPQpf6CeickyMiDwcjk?=
 =?iso-8859-1?Q?vSzuzQMi6G2zjZtaUFQCZJ284+WST0CennYxtaR035fMHwRRCF72qOqQyu?=
 =?iso-8859-1?Q?LiEgE1xhlFs+UchZewuiFs5QYlaCGZrrRlFQl5MjOQVmdfr0pTIZr55BcO?=
 =?iso-8859-1?Q?Xh5o6ueRYU+ST7G2C7p2P0JPCrtjoVPyIx6kJnM05JQi9K5goH+/PjzZ7E?=
 =?iso-8859-1?Q?tAAaQKLilN37GtV4m+PVyvsAuXJOQxhulUK5tZFSuljng6ZT5w51CDwQuR?=
 =?iso-8859-1?Q?vkE+sxCI9fLWuO+0KTHZJBVAiDlSniJmpjBClygMPeocsHpBGiu0DCoAeF?=
 =?iso-8859-1?Q?bbhmLwjEYD3FLbvTpTK/lM9F/87iW2fH8AZeh/LVFY1o8U0chxinMc5AAJ?=
 =?iso-8859-1?Q?WRNjj3QMRw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r9WzNBsGVGAC8XGXO7i95Ars4CpbV4mhBnIOUTiNjyezGC3pgi6sC3WqYCmPFUD/M1TtiT0H5pCkfRcCht+LjSaEGPBmhJw4OR6Hloc/AVrMeItfwBGcYWyDgVTvk/TouqOxMRARx5QevaJU66kwco0mF4yuKRLpRsQpxWaGKHFwDuztcc0j6E7x7KPLAf+y5i6pE4cLA5ZORuoOjh1anJYwsnF0D/+FVxvIbUFXpepXxfWRNCMLqwrls4aZvAvN4l3uga8iZ/GH4SUxavH1YtIXtcWceHM8Gy8c1LgvwkDj3K/NSgIeGG6Qqw5tVdSQ7smlv69OxQ3M3DbrA/4mRA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c33e4e-a04a-44a1-b2ce-08debd4d81fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 06:42:52.3810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rB/aL/VaPD/0eEpUDwwuWDaO8sB2DA9/ucVF+leifr5bSI2itPL7IQPhkUhW1Bpbm9n/R09eZUXeuv6RcVCGA3lGd5vXXM5CVzoZXuxR7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8451
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Introduce the AST1040 I2C controller model.=0A=
=0A=
The AST1040 I2C controller is compatible with the AST2700 I2C controller,=
=0A=
including DMA support and the 64-bit DMA address registers. Set has_dma64 s=
o=0A=
firmware can access the high address register and program it to zero, as th=
e=0A=
CM4 CPU only supports 32-bit addressing.=0A=
=0A=
Since AST1040 has 16MB HyperRAM, limit the DMA low address mask to=0A=
0x00ffffff.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  1 +=0A=
 hw/i2c/aspeed_i2c.c         | 29 +++++++++++++++++++++++++++++=0A=
 2 files changed, 30 insertions(+)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index b2e4d2fb9d..156998e7c1 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -30,6 +30,7 @@=0A=
 #define TYPE_ASPEED_2500_I2C TYPE_ASPEED_I2C "-ast2500"=0A=
 #define TYPE_ASPEED_2600_I2C TYPE_ASPEED_I2C "-ast2600"=0A=
 #define TYPE_ASPEED_1030_I2C TYPE_ASPEED_I2C "-ast1030"=0A=
+#define TYPE_ASPEED_1040_I2C TYPE_ASPEED_I2C "-ast1040"=0A=
 #define TYPE_ASPEED_2700_I2C TYPE_ASPEED_I2C "-ast2700"=0A=
 OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)=0A=
 =0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 5be6fefc4d..8418a0a686 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1702,6 +1702,34 @@ static const TypeInfo aspeed_1030_i2c_info =3D {=0A=
     .class_init =3D aspeed_1030_i2c_class_init,=0A=
 };=0A=
 =0A=
+static void aspeed_1040_i2c_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "ASPEED 1040 I2C Controller";=0A=
+=0A=
+    aic->num_busses =3D 16;=0A=
+    aic->reg_size =3D 0xa0;=0A=
+    aic->reg_gap_size =3D 0x60;=0A=
+    aic->gap =3D -1; /* no gap */=0A=
+    aic->bus_get_irq =3D aspeed_2600_i2c_bus_get_irq;=0A=
+    aic->pool_size =3D 0x40;=0A=
+    aic->pool_gap_size =3D 0xc0;=0A=
+    aic->pool_base =3D 0x1c0;=0A=
+    aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;=0A=
+    aic->has_dma =3D true;=0A=
+    aic->mem_size =3D 0x2000;=0A=
+    aic->has_dma64 =3D true;=0A=
+    aic->dma_addr_lo_mask =3D 0x00ffffff;=0A=
+}=0A=
+=0A=
+static const TypeInfo aspeed_1040_i2c_info =3D {=0A=
+    .name =3D TYPE_ASPEED_1040_I2C,=0A=
+    .parent =3D TYPE_ASPEED_I2C,=0A=
+    .class_init =3D aspeed_1040_i2c_class_init,=0A=
+};=0A=
+=0A=
 static void aspeed_2700_i2c_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -1739,6 +1767,7 @@ static void aspeed_i2c_register_types(void)=0A=
     type_register_static(&aspeed_2500_i2c_info);=0A=
     type_register_static(&aspeed_2600_i2c_info);=0A=
     type_register_static(&aspeed_1030_i2c_info);=0A=
+    type_register_static(&aspeed_1040_i2c_info);=0A=
     type_register_static(&aspeed_2700_i2c_info);=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=


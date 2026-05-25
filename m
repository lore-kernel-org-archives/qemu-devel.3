Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869E9CD5BC7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN9E-00026R-Th; Mon, 25 May 2026 00:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8l-0001kP-4A; Mon, 25 May 2026 00:42:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8i-0001Iv-Mj; Mon, 25 May 2026 00:42:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1Sj5tidGDXxz9ip2iyeXgraVWQy56YYbvoea0sPImc6RMzNQPRvs9W4VNuKH+TgrY4hsyClzgQcCZxJGIe4FPMdDKEU9ARLscvcPRLFvTTy1Uv7wktaAotuu/XsB3yjojBsUVhQGUwlsb1Q/ePMnQHsYkWANtVOhK2GjzI8dG7D6VdeZjt4dVbgsMaWVSL28qbCPDy5dY3hnR0RiFflZxqAheqsaMt7rQopxwvIeFt1k8iHYI2wuQOHwTV0/WrObrqUZevRXt1GqJa858EdccohweHwM+EjQAzcI6YSftQoFRtohA9mMZTU5LXU+TbUyRJmF6mfGndHAKfV+11nEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1WQF5Zb1DiMqkV+MzzOvXbTdY8twQWnnOG7p0qmXv4=;
 b=B7WMcOgRvB3aqzdnXOxuBq16u/aQ4Q5RW8Rc5WuNWcDbQXZXNq60XA+QW7ZNMz1k7DFsC2aPIY5GnJ+A/6NiOqmiU7fYNJatKLD5a/Ms78rxE89n4bnBHMsF9uR34pn8hsnWB25h4IJ9pw0lSa+68tOlLaYCg1Dd6UuTPTvSfO4JsYD844ISqIwgk6RUHXHqYuFuLF0JXuQ3XXFnzuEuxN5o9/PgARArNxYv/d/JpysLSagrT1o8EQdo7A4otDyl9qdyk47fIlUEmi6hlTjI4rH+hT3FX2xKb9rfVr8bj5SG9wgSXgODokjfWZedeLesl9ysUdqpSiyd0oHuUNEj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1WQF5Zb1DiMqkV+MzzOvXbTdY8twQWnnOG7p0qmXv4=;
 b=X0lE7v6e/zEsqXsItuD45opxLGqteOj2NGuf12e+Yx5FUN+jil2Cm9mTd9FL9WvL7E2eh46R1iewd48oqM2lyfBWq+tXSffV+ymNCGwmiYtw01U98MHJhTG4uWVEvjxOtPmgTxsTGaDa2KWkOmjRn9Tl6oWV26z5s0ljXROu75NXAj1LZ8JJIt15Ots6ih5bawmCkk9tiHg5drG6UQH6c9K2tA7zvoh4iA8Kv9HUZlz5kC0lYEb0S5m9+vxEIR1A1ZLUCbiIEGJspjS7lBzrYNFtRndOdWErEX6kJTNLOJkE0QrqMv+gQ9ZiOuweGnAxxdd3uWVxn0c7I8ZLhpMxbg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5617.apcprd06.prod.outlook.com (2603:1096:301:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:58 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:58 +0000
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
Subject: [PATCH v1 19/23] hw/net/ftgmac100: convert to use Resettable interface
Thread-Topic: [PATCH v1 19/23] hw/net/ftgmac100: convert to use Resettable
 interface
Thread-Index: AQHc7ADSiutOcixyekiWRG44SsxJWA==
Date: Mon, 25 May 2026 04:41:58 +0000
Message-ID: <20260525044129.3133916-20-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 992fff9f-0e0a-4782-2827-08deba17f485
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: KCcQyVM6uqraMkqWxirYXXsVcSarDyX0IH+L+pj5KfikzsumWrQclhXfDCwXEhOHGQH9uVzPbsOIgx2kPgrksFX7DvYWXtbRrQnhYta+BvuVc0FjIvVhEMUDmj88yqeMlODpuMx+yJOZmep7ycuyzf6wE3eZ1oOIJN/rQRjDhL5DAXPLxpYpShM/1DZzfJWWNUPrc9OytwRACxCcTbddIkhp3KqXaCWOOk7AOH4jcwAmEs3jxfeWVdYJkGZl1wERgPm74tw8stiO2eb0ac6NwomXuwKvLXBlCCByg4+rujA0Dt2BPIGGExyRbrC9EUxd7PiL8okpli55dTUBSAEbEwh9LPCupCrXOkXgN+YYYVQxJ8/KAvl7Wg6RParCA5+P2O8LjNN6tYzDYRlsBGm2dseX9VARSdloNYcDM8Q7SJQrsnVPBbjg9KFb9snOZX1lxOUQMnl2/umNtLheDV+Ww/fJrBzb1dwd7HjWu/CKKtjfJsQh/Au6PElaYOzYdkgEAchRZlNhBOJGq6eMzM17WNkodnC2Y9kHpD6++SzntBsSMUxvPrGkA50GGLedkk34iDs9ozzYBf3G1tNzq/yXRCSiV2oSNwKgeghTYiIpLGwilbZ1hYclHBceIB/v5XBUwczQryIA3yz/RKIXKOBEeLLrL30hOBvRXPtyKochAivQaHb56VKmjSHZwXyfxjm3gjT/UcSZHkYdFIrJXPrKHYfgwoSldbtDEx4AQEXELrkrF3goPesc72DG+lgGN3/9PVUHEN4KWtzjRtHEdbA7TQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?y4w8CYkpYqpo9QSmFJ/r6Aw4dipeq5GL5xQLOtO2QSZVItN8PsA2NfeHgU?=
 =?iso-8859-1?Q?VF5IfqYYgLq5shVWwp7NjnvqL/Pr3wR+bdRbCyHR6D1/l5MQ5HNrXdAlu3?=
 =?iso-8859-1?Q?Q2dwCYgJMu6sH7Ez+zyzgT8mD9DaXfKvOcEgMFmDXTjn64+e2aTeZfutNt?=
 =?iso-8859-1?Q?WG4wVMv1VPjGHCdqrcoe2mLlWchMUtvQAKF4pQAcC+dP6iSktjwGVOEOK5?=
 =?iso-8859-1?Q?uGm7q7bMoDRWod8UfqAlSrmz8eZXF63gJK2N15KvBvJ3/eSoGwM8c3gfHP?=
 =?iso-8859-1?Q?J+r5HTiFDcfXPXF1X3du60OnY2/ptIZXSr3hBuVoXSEq2nH8xjKCOiLjCf?=
 =?iso-8859-1?Q?HbfIouJpzT+k7hiOaTkcfzO9YitDU3CYy9VraslT6/MJMtAiYIl0ajpQ6r?=
 =?iso-8859-1?Q?Q7xWRJMvt1tYAiCoM57Mpr4YvB5safHs45yx8KWSq83P+wgoLvmdbhx+jn?=
 =?iso-8859-1?Q?3UGcprx9tnLiaK5/jdbref+KtioTr+HErIQ1ZxQLxw9vLqV9gR5scYuqME?=
 =?iso-8859-1?Q?eOLL3wOtSdArSjqaRnJgRfLGllc2gSOm+rjYThvS+kAZ1S16/v0xFjTLQd?=
 =?iso-8859-1?Q?AIzw3yuCC7QSJjprbE7Qrfiphm86t/QR3QPZbe8v1QRHD64Dnb/ZFD8aw1?=
 =?iso-8859-1?Q?ARHc9ydFBEJvirikiEEzV7pZHHs/qdYQRxmK8MdmHdysPNo2ynPQOf7oNS?=
 =?iso-8859-1?Q?vFFCDKz0cFVfTOQtu6HCYxiVRAl62657WH12xCe1d0a+WbDKlI5gZ605qR?=
 =?iso-8859-1?Q?dMxbYX3m9CYDB+UErdK3WGmAYNC6TVDuuhs0zPxI6jCZzbh2x1hYvAXK8K?=
 =?iso-8859-1?Q?zLZVQD0Bt9i3DqHqRIXlvPMnAabE6v6UqK/VE5uYYA69pW4OXfzPg6Ihzs?=
 =?iso-8859-1?Q?KHNx9Z+uUJ849MlQBM/hP7n25T0gotPWy+lDgHuM6Lg47Af3RJg28dTnm5?=
 =?iso-8859-1?Q?w84RjJlDkfQ1bYABqboRwGrFwrsN/90Nvf/8jPTKwnePZnJsLtrs4fR/le?=
 =?iso-8859-1?Q?1CyPNbKfYsSNuhzKqMkcee5K7ZgyaJmU3dbG6B5sUABDDfHFeFEF1Bk1d5?=
 =?iso-8859-1?Q?hr0hox6+2VTXwHbGqG2YHLJHiyN6w7SXNHp+WzUqiF1a0fx2AM6K3KgaVh?=
 =?iso-8859-1?Q?dvd+LdoDfFz0j2kwKW30HJkIWSTXAw76TOxA8lJrgtET8pzITCXO/jx74M?=
 =?iso-8859-1?Q?LhDVWz6fvVs7QG8/49KXLQEimMC/RNdvumgilzjatVzPs/9Nz401HkoZqx?=
 =?iso-8859-1?Q?tskA+cbGH3ilWqCzeZbg+phfk7JKPNCDLECl2rJr/JBd2lrlXFGW1udhPR?=
 =?iso-8859-1?Q?76inw4tILLT018E692rNXlmq17b8lSGc3LLuh1E+BxbsQOzalPT4CznspZ?=
 =?iso-8859-1?Q?s0HO9kNyaEWR8MJxEAY/QPzrgg8tKZfTFFcpqVETl3xYn8TVCeaD4iUP/C?=
 =?iso-8859-1?Q?QYpxn/2gZWXZDxnMtsn/zA8KKHyKpMaCqwH2Rkro0rboP4UcCI6qCluhpz?=
 =?iso-8859-1?Q?uTpprffawjr8gPh1FIG6Cg+69t1cdYlYsXawN2U12KBEmI7s8S1Dy+6vEP?=
 =?iso-8859-1?Q?RtwTLks+qm6MG8sAyFvsTmc84BQcIoXYXEQe3Qh4ybu7er+aMeKwMVKBJ0?=
 =?iso-8859-1?Q?2ZRU4ThuG95Bv0rqN72W4Ec9JwUiX6KuXwn7b0XrimjCo7cdSN15V7Hrma?=
 =?iso-8859-1?Q?hX7Ms9zlP8dFi0SylWGnogxvMFNyrtFNMbZUrr7OXk9NX1CschcN+qTiBa?=
 =?iso-8859-1?Q?s6gWsBOvzEy84jhKTDd01Ms7UHWGqKPDgy59pH2OT43qtx6Lg9EMTvTsuT?=
 =?iso-8859-1?Q?yCl6U16xzw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bThdycRAIrgg7qrQzmzAJuOyVmDmRzBQw20Nxw/F06GcVYN3xC/BMZ1xHVz0pNAoeLW5PcF55orIjnFrklhzNyDCOquWk2seGW90bRmFREFz/T8SX8CRm9cGpdmemlVNNZY92cWZ6VtnZZOScqf4Sax1axUntComFvJD7QxJWHSrxpObbTRPzNo+lce9sw3jVxBWDelVZ5Igub044HbX0VvfGlQ8NjymqhL2/tg7eJ+C8IhoUc2umCgxgyW8su8FnjMVaICOhbHLAk1g1u1D2pClwOZuhRAMK/mntmUDOlPygd6B3OtUb/MTEitQtfbimsFCYIyJh3hYx0yhYOOtCQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992fff9f-0e0a-4782-2827-08deba17f485
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:58.2330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJrrbEUAkq1+76DE8TOq7NjpdE256fvmwmrWbsX7EF6c+P6iZX74+qDiSiZZ9LJcucz21Iu+ao8p+AeSa7gbgCo0yChS0Sf4LUhtd+6EvFk=
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
 hw/net/ftgmac100.c | 14 ++++++++------=0A=
 1 file changed, 8 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c=0A=
index b3da48c343..2bec817b9d 100644=0A=
--- a/hw/net/ftgmac100.c=0A=
+++ b/hw/net/ftgmac100.c=0A=
@@ -723,9 +723,9 @@ static void ftgmac100_do_reset(FTGMAC100State *s, bool =
sw_reset)=0A=
     phy_reset(s);=0A=
 }=0A=
 =0A=
-static void ftgmac100_reset(DeviceState *d)=0A=
+static void ftgmac100_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    ftgmac100_do_reset(FTGMAC100(d), false);=0A=
+    ftgmac100_do_reset(FTGMAC100(obj), false);=0A=
 }=0A=
 =0A=
 static uint64_t ftgmac100_read(void *opaque, hwaddr addr, unsigned size)=
=0A=
@@ -1269,9 +1269,10 @@ static const Property ftgmac100_properties[] =3D {=
=0A=
 static void ftgmac100_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->vmsd =3D &vmstate_ftgmac100;=0A=
-    device_class_set_legacy_reset(dc, ftgmac100_reset);=0A=
+    rc->phases.hold =3D ftgmac100_reset_hold;=0A=
     device_class_set_props(dc, ftgmac100_properties);=0A=
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);=0A=
     dc->realize =3D ftgmac100_realize;=0A=
@@ -1387,9 +1388,9 @@ static const MemoryRegionOps aspeed_mii_ops =3D {=0A=
     .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
 };=0A=
 =0A=
-static void aspeed_mii_reset(DeviceState *dev)=0A=
+static void aspeed_mii_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedMiiState *s =3D ASPEED_MII(dev);=0A=
+    AspeedMiiState *s =3D ASPEED_MII(obj);=0A=
 =0A=
     s->phycr =3D 0;=0A=
     s->phydata =3D 0;=0A=
@@ -1428,9 +1429,10 @@ static const Property aspeed_mii_properties[] =3D {=
=0A=
 static void aspeed_mii_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->vmsd =3D &vmstate_aspeed_mii;=0A=
-    device_class_set_legacy_reset(dc, aspeed_mii_reset);=0A=
+    rc->phases.hold =3D aspeed_mii_reset_hold;=0A=
     dc->realize =3D aspeed_mii_realize;=0A=
     dc->desc =3D "Aspeed MII controller";=0A=
     device_class_set_props(dc, aspeed_mii_properties);=0A=
-- =0A=
2.43.0=0A=


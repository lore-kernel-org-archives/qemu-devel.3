Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588DBCD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8R-0001dY-7L; Mon, 25 May 2026 00:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8O-0001cN-LA; Mon, 25 May 2026 00:41:48 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8N-0001Dc-8g; Mon, 25 May 2026 00:41:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLCNevAW931Lbt7mAe5lGyDNXaMtfybVmP7hoH+Jv4O3itjL1dCu2sQqXbiaWoHZsgnU2IdfcUmk9XFdrXSXMLGBQ5KDxa8gHS+sp0Pv+P7+aOG65DMDByoSG35VIcOxhFQkZ5+d8j9EKVF0zjD/eX9pAPnTn3gKw57oK/BKRlPpenVC0BQmSRdywov/NV7pwWcEztsfuP9l0ZHcU7gW6GNWW1Ne3hWuukn4+4l276XJGza3X2QLb9+WjRmcLbwL20A9LU1gY5sIrVhOwTDy7aOaopVmo1FYygo868+9MDfgS3ej6Rqphp+zCuK/ttxf524qM1akEs7mTvzPyAuq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oehwYRe3jyIZ7pGYvy0JeEDaIcXsRrFtNRSXPTOMvs=;
 b=Gy6Cm+DtfotySLai1tiT5zK8BJG59VZTQyFmySQyxVE1TBNTMETYCMeyIQ07FM/gYTEfWOlxGcPVjqBg9ZW0rXCLeB/WPQay9IXQjY9G3vXWgS38XB9PRiBtDQ5mBxW3gaHmawYY9eqaSQee7xSjsV/q8d3EonbRK8lHRW93/+VW2v4wtCoz8qdyX9J0CuW4NLCuCM9Uet8Sd+qjGGNUDrQD/Y/fKYirxKLPJahh1VI3gVw+s92U/wY18O9GQ/fwvjifXZys3O6yosT+CwSX8RMqQAGwbK8eI3P1TNqrlEERpX/dmmoE+547p6cBmOfWfnQnh9E4ePDqv1vC9T4bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oehwYRe3jyIZ7pGYvy0JeEDaIcXsRrFtNRSXPTOMvs=;
 b=o1twUSaVBGSOXfy7ZtkbnS9+sNXJCWKBxZye92gBYPJ25YYVTr4wVLWGwDWS4t3cssYvK7fWwKAwiahnTijI1fzsKv4QqIZ2Gdr4yW6VPMfXcQyvNeAV6WPuMAvYnzyQnlTXoWocYgBuCKjzkHKsUG+PDlP7by+lS2ZpEQOKAVnGwSHu6TTnf/+r5TlFhJWk0ZYuuLy3IPt7h6FkCzVlrp3+Pv1dR14k0oxB9Wbn37pSeClPqalhSnNBrQXAC+PxwwKnAt4jZeK+n70rpPx9bPigiAUMki6M8jErmZA0vThd9o4YytUzHKeRCveESx5SjxSOjhHLjMVOONzaL7DuGg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:37 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:37 +0000
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
Subject: [PATCH v1 05/23] hw/misc/aspeed_xdma: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 05/23] hw/misc/aspeed_xdma: convert to use Resettable
 interface
Thread-Index: AQHc7ADFqLov6XIuXUKKh/Bk2fJNUA==
Date: Mon, 25 May 2026 04:41:37 +0000
Message-ID: <20260525044129.3133916-6-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: dc6a4078-25f7-4dff-583b-08deba17e85f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: 7fwHl0OMzlcSHff+RCibTLTDOe6XvbeNi7k07ymCFefD9idJITrAwJSku4fTsU6jkyHnvyUBaVvPygQCh+zPs/h8vRQXYBhU63sge1CWHb5uyxLhYguAySPFEBJZwTTxn5AryLJ7RGeBj6XD8K4wSal7s/qanA8xKEDwSQM/WDWutlIT7ffX+EzPgM1qbGy9HhtKWA8Fefdg8ApYHHYEpLyHJC2nWewSKKhZ2Ln3cmT8TqRgf9kFTn96nfD2xK04q20apBQwmi+QQvNLSa1aktqUWI6T3I+fMWKPwa2lULwkVw3vhsuw7ZY5KcOpW9nV2U9KQmpZt/4ypX2tXWJMhXxcJ5g8Qegr0fFx2ufFx2z++vvDXRJIWE5fbWXXItZrvsbslsk5n7ok33d5nRYlp9UdEmLtsLaA1maI87zjWStslM7dC6QEYeATtdpdrSzfVVlffE3oQ8u9QH0jVLyO+7T9qaGBjSGcIvvPSbA0/B42WSFLrkUVDy0jM0K64lA/sIZ4vyt1/Zyd+AgzdhMkrMDHSD7E+EV1DNCGUGvd34yTZlha2+33K7fMhofH+om4FQu5Y7kzSidIq2QPFnohvYWukMooj+JOXoQf2uyveZ1qJ9qM0KtXsehMoPeF11wqvVukWB637K4MQiEyOrqh7xWOrtbtMJfE9xQKsySIazJWB+t0HMrAiI7PP1qonKZk8doVtip+W5Jjr3JztF3kDB+X9WA2tgX6gQeFTSbkYCF50fKpMMWm9R7jVx+oxuaZlMO9Md5vJbtZ+1VKedIznw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RnypC2E8IbUYSXNInXrG8NDHVLjv4zI5Z5fkn+x9gnCKiPv9lHYZ202cKi?=
 =?iso-8859-1?Q?qq3JYheQyYae/P8pI+i66oAqPZ657hNIFTgmdr/ETaHjA5MjAlMXtFe3yr?=
 =?iso-8859-1?Q?IK2fA4cLe9imxW+Ser9uBm0s5BoT9xq5z74ffzoE4uvdBNS/ldTN9HEL3z?=
 =?iso-8859-1?Q?O8VpMyzpgMeaSTChdZx/Ew3P3l76MuesDbzwKIfI+jF6Wkwb+LfhxVXXg1?=
 =?iso-8859-1?Q?+mLh11O/FpdEBb5gfjjayXXRV6X4y5SHkyw9l8rRyq/3AmEP5YWIi990k8?=
 =?iso-8859-1?Q?Z8k8mb/XohuuIiqnPtWWgsARhy0mEyg8vz/qRoyAcapeJlfiOSmn6s6fPP?=
 =?iso-8859-1?Q?S932F87BHKxD4rT1oz+U3RVZlgj4FEHwpscpcXMMNK2oGP3+vhgF0ad4BO?=
 =?iso-8859-1?Q?l1iKDxXzaJo4qCyrnlwQ1P7EDltGhD4Cmr/Ntjn61q51XumLqmJspvnHqS?=
 =?iso-8859-1?Q?gyhvYr/dk5T2zQCU2BNOlDYI54WMFgeP9ONiw3RzdAVk6PQNP56iVK2TX9?=
 =?iso-8859-1?Q?lkjrbGEsM0hRQxbriyTwQLZGK3gITypSs4SpzthMNTbKGGZrvbFH3Yp7hJ?=
 =?iso-8859-1?Q?KKbBgRWF98Hb5RKz1EvS6JizMloANrFqpLGh5cEswVZNh0czwbeQibIMXg?=
 =?iso-8859-1?Q?SpopySOguWsW3DkqkqLYvQUVjysstqsEfZmxwPkb+qTy/EHTxXt+wkHZjZ?=
 =?iso-8859-1?Q?wL7RAm6E7zBdFxYpVzYY9sbJqV+alwrNtUIGYa/r2X8JUVqJ3e7vWY478o?=
 =?iso-8859-1?Q?6aJF2g/vNjcc4okwIu4ejL3GdZ5LsLp6UUXyLORbJU3YDwBniNbpqcaNKo?=
 =?iso-8859-1?Q?kNQ2idk7bw+5CjpyuPYXjLbV4yN8bSCr3VS5qd474z2tf35Npr/KQtYw4B?=
 =?iso-8859-1?Q?f09ov6zfs0C5WLFIGDSPn/tW5a6fPW/I/FWL+VZjPbWABXUlNQEXfItdAG?=
 =?iso-8859-1?Q?FCMbkTmkTJVLG69+1tKFEPA9OMqtg6ZGUSgvts79G2/o+dVsgL5X6T5/zb?=
 =?iso-8859-1?Q?M6bVqIy3WW7fenp8aSD/bLK3zPwbInx7cUsx6ndQXchLmT7i4ZVoWZ8e5R?=
 =?iso-8859-1?Q?bdcVVQuLVIcQj6K3CC30ho3TbrRl2Q4Htkig6mo9vPWsr//NKQ3T1c6jac?=
 =?iso-8859-1?Q?5raM+lA2Tf8i7/6UHdJIiKxkHhNOo6j20D+b8njHUR7WKxF/N5vEnjv8Je?=
 =?iso-8859-1?Q?I1om8howCRuJsr4pGVezKQqI0PWxL6/mQFZOcUh82QmZLA/Jr4wjQj8v3G?=
 =?iso-8859-1?Q?DOzEbJRcfd0Ws3aedzD2HXVbPl0qcYrfOMVQoKu2XK/nxAjvfvDlYmMf5k?=
 =?iso-8859-1?Q?YYieDyx1HHP6tePZQNGKgXCw18TZFqMeapT5GIpeRgMzh4eYloJWkXBigx?=
 =?iso-8859-1?Q?Ey64JrfMD7qJ3jG7SryHPsfovXCrF5/yQNyQ+CdT/i39eaPEExKivaKI6o?=
 =?iso-8859-1?Q?MQaco2waQdoMUOoNete/PnML4cjNdKhoI5+nuA0CyV9Xs+1X36helSUhDy?=
 =?iso-8859-1?Q?YLPGHykKoCJsUdKmUalwOesru0T7rzn9TWy13ogGWA6WyxXJbDlEagG0V/?=
 =?iso-8859-1?Q?bX8rps4/Sd2EgUnVlsvHGgY1ehbH0OQH95t9ukZl7818evHN4/HvKRkhHe?=
 =?iso-8859-1?Q?YNPuYmP3m1XKSSOI4WaL4BOeqWw3tyJR8BLpM5e6fgDMgodAaAZ2IcX0jH?=
 =?iso-8859-1?Q?7LtllGwy1f+tU8GNDFBMso2klESyytY9esAN+UXzGCTQLFEf0HiGvtjxfi?=
 =?iso-8859-1?Q?pyojdN2b83yxMzN30shxdxGWuarQ1dO7KBzjaWMzOQA9LVXFYCRtdRxJCw?=
 =?iso-8859-1?Q?VDnknGhA7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ja6Vf1VYzcBXI7URSuFCH2p547xdt7a2LFb8l8fUlQXWNesKKhLhiz8QW5bUKna4lsIhXSJbD2a3zeUd88OHsIgG6qKLqJsqHBte1VBA5VNqBjKgFIO4GwaviEWB/Dx39TjpBfss3lSlZ8oZ9BxDF892fymXlKe6TlOfANPetZImFPo22TGvfVo4h/1tgCslmxdx8YGP8tZ+yMaRG/+rcCyQbQsnQ2jtTWUJsHbYlXnOnadi0KYDp5UdtcUYO0G/+y9eWK9rfbt75wMP0+TOXIW46DOBnrYh8h0LRKmpFCyPsjRSDLq+6T1xp7miD7Q9O3ZRPmPPAlCX4WKZxc+mMw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6a4078-25f7-4dff-583b-08deba17e85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:37.8186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwYF8rId2APpyDbHLTBm4DESInJ7TYiFLClu2ErHDpHbTKBZxLZMhAY9rjjNMUDRZZrzugEDbtGI7ZC+AR+g9jODxwyCOig1dKYmLJMQCLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_xdma.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c=0A=
index 3e2beafced..80b3259333 100644=0A=
--- a/hw/misc/aspeed_xdma.c=0A=
+++ b/hw/misc/aspeed_xdma.c=0A=
@@ -129,9 +129,9 @@ static void aspeed_xdma_realize(DeviceState *dev, Error=
 **errp)=0A=
     sysbus_init_mmio(sbd, &xdma->iomem);=0A=
 }=0A=
 =0A=
-static void aspeed_xdma_reset(DeviceState *dev)=0A=
+static void aspeed_xdma_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedXDMAState *xdma =3D ASPEED_XDMA(dev);=0A=
+    AspeedXDMAState *xdma =3D ASPEED_XDMA(obj);=0A=
     AspeedXDMAClass *axc =3D ASPEED_XDMA_GET_CLASS(xdma);=0A=
 =0A=
     xdma->bmc_cmdq_readp_set =3D 0;=0A=
@@ -220,9 +220,10 @@ static const TypeInfo aspeed_2400_xdma_info =3D {=0A=
 static void aspeed_xdma_class_init(ObjectClass *classp, const void *data)=
=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(classp);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(classp);=0A=
 =0A=
     dc->realize =3D aspeed_xdma_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_xdma_reset);=0A=
+    rc->phases.hold =3D aspeed_xdma_reset_hold;=0A=
     dc->vmsd =3D &aspeed_xdma_vmstate;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=


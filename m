Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DAAC5DF81
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFoV-00014c-OL; Thu, 20 Aug 2026 23:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoU-00013v-Q3; Thu, 20 Aug 2026 23:21:02 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoT-0004BJ-BW; Thu, 20 Aug 2026 23:21:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNNBbn/44nz3y7/Frb5U1BFKaV21/vu3WBOt2tROylIndLikB4MCPkfTO2NYNDtZA5WTcIT1UFf1LzZIGAIMTwTEXfa5Xby9wwx4EFVZ1C4uX6C+KIGo/VCtEGZVOouX0gKxd7CENy0TrYW+2xZ5O+Dcaiu0ntYKHYDJPzQ2AR5db8gjdN/I+GMKYrRpQwnIzTSkFIKB2D2N6xtMXCKHofGKLZmvym5triR3wepNz/a/qDM0MTLmZYUNMz2U8nq4i0lNvuZsUBLtx9y6nu1W53Uuydx/Q5o6YWwntdmTcKUGsu5hgyIpBLD3gECEzEKLP/tvdruWfvR99MJ4zoLDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjUUOMCdxGcTuWVXZRhnlb/uFNe3929r2V2k+mSHhcY=;
 b=ed8YlRN2GXcRcXJN435p6TPwvcSSgmRX0PuO+IbcBSy3h04r+YTn+/CzzCqs6mbRiZtRl8IKcyeQ69wVwyfEQaZx4WSwHdQgPgFI5MjTKc5lSc/IpCJkbfJ7OC+g+t00vBUgOGEED6BTRoXB7rPv1608chLZnvT4GJSKpA7Bs9173ytefkaO/1x3wr3HVKPZHtOMSyTCfjWisk6PmAtZ7wP54zkEFU0XgxSCprNtURIMWlsXXEvmgKoZXssgnmQxHaMwAPekYh2wSH+Jonwy4t9qkL0Ado/auuSC5ONRq57F/zm14tdRPy2sYJrqxCzLRNnoYFM4TvhQiPa4k5nEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjUUOMCdxGcTuWVXZRhnlb/uFNe3929r2V2k+mSHhcY=;
 b=eOGYyRZmHihSaD+Oj7JHBTZnEsR6mCbvFD9VEAAqUzTRd2361OOzY3cdXjxtoXJruHdMh8HRW2daEBJ/9kH6OpAEk2FM+OqT4Gzn6PafW2/f6gEm9Pt/sE/de/r1pxcmCwjF5KxqXkh9rFdmVS/MsVDi3UWK5ucbbWeMX/LSE+dcJDbohD5VxVvSp5OOo7enzRsxNGiqUVIzy05J3jqvT5MNamAmW3Ba4My7owD388u2Ay4JZ1V5cMigVGFaA6X9QlVAK+wv7xxTeMXqfBPiEaN3HnZATxG4bxl7bLQoD8OWmyOSZxeO1DrX3wz5N5U3e0DpHCAE9v+q6mMkPUw4Gw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5467.apcprd06.prod.outlook.com (2603:1096:101:b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:20:47 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:20:46 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 7/9] hw/misc/aspeed_sbc: Increase register space to 0x1000
Thread-Topic: [PATCH v2 7/9] hw/misc/aspeed_sbc: Increase register space to
 0x1000
Thread-Index: AQHdMRwOrgmCz3Cr8kKaMqLL1yAFgg==
Date: Fri, 21 Aug 2026 03:20:46 +0000
Message-ID: <20260821032036.1829294-8-jamin_lin@aspeedtech.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5467:EE_
x-ms-office365-filtering-correlation-id: 71ee8162-098e-4f44-6949-08deff33313f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: iQhO0X2kQqle1H+CXyD1ZxCloinWubQ426ywleqn6Hl+iRujTDdW7LMSbdiufWVhtK23MmxdVBjXOKBlmEtaFV70CGoRCRQWrTB6XYSuNpi/eIjG/Db3G5N6BaP9tawSqzYN6osKuKeFJoXzQoyQrHOGrT3mPmHEFlPbfl1jRAr6KEJGJMdnQV559+rDxeNbGrjagBR2r04GyNKth0mpgRUa5I3NQErjeqGoSt1JdJpYVLEEyu/CRaMKJkLrWONlLUlfHQrygWSfsR+dN44RFgB4Zr4YTzkNTngwzIod5LicP+6Nowawbnpu4uq0NGjFF1d4W0WehXBuVK5/70A/PXbSZCP58AYbW1nddhnIwSJ0nrVgs82HhsROyYtIUexlr77ZmRCDBK/fjYMaK5FThXwZIJn1+RX+W0Y5opdoVedWrFo+1+tuscVX2kQ9wLDCqGqUPxBFBJ4h/bIipqxwdUkIPSPxftAhWtlhE0KiHKBtatK9kdFQY/KEqQRe8Eg/BQPWH7vYcDGgO4LnrHny8J4TxZxjNdLKtlmrBcTliku2pRiIKOX5f/92yKiE24dvWOjF/NlLhi0WLyXQvY3FzdJDe7sdWQzchNop8/0nLgB2a9EjAA47/BLCLE5nEWyRkXvhVh9dh1B2WANO9b0GdcLis+HWBX+H8kvKadJFAhcPBcZ40VrSmNMV42DTtg+OvQ4oiqf9vJXHg9ff2wcAqFWwaeOZLO9o9aV11D6+qG+lQJmFxLx7vxQbFgIppjdd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ioxMrRvS2Jq9B0ZT5O9DxbdDsV4rbNjg3AsIQ1t1t7cDQLFCyy+KgWVlQT?=
 =?iso-8859-1?Q?8Zl7Jv6iTTU5KQkkzvPzmWP2zEgz0QWSgYVJJYXx6a1+zcaaE9dqRdrf3P?=
 =?iso-8859-1?Q?PMkxJ4uvZtMIhfHLwvboD6HHIjs/GVEVm59RBMfo8biZomYTBdhi3PDYiP?=
 =?iso-8859-1?Q?fxX/pR5lga3CFX9cWZepnqf3ienakotcCdbYSHU2hPsf3fQQ6bgz2fdZjk?=
 =?iso-8859-1?Q?afZZHn2761f1kzX3KoVKz653CbP6hoa88ZgY8Y4R3YqXqINiuQdVD5NJ0c?=
 =?iso-8859-1?Q?WdNMRFAamnSuHUh9bhaxkuWMuX/UF/kbJJeNgDXAXXhsKZjMAEcoguuPkF?=
 =?iso-8859-1?Q?ybYASas3B1rssSJ1YvGmUbIyFXrDuQFg1/2zrV52IyZa0SPq2KiXARUsp/?=
 =?iso-8859-1?Q?whXz8+q0LYJQakUJUKwAMPdnUVgSPzZbIbRGF168XzBJT8IuDKK66l4DyD?=
 =?iso-8859-1?Q?gqn9/AHyzY6IJ4YiCaqqwDUI0IvLlE2ZssGcCGt/6WzeecN7nsiukyF/F4?=
 =?iso-8859-1?Q?JtwTVioZUTwB9pxYxdfYRyLJPlhFgc69LgZvYu8/Q6BwhOsoQygahz7eVz?=
 =?iso-8859-1?Q?i6CC7B8fZkgZA0y+gboMpwiM3oEI4GGB1LA6b2Y71XDHNOKlJh7eWzRd+Y?=
 =?iso-8859-1?Q?dqmvcL1BYZHxPLrsBluHD5B0MWRC2fa4AthjUfYdbtC0gGZPTmagJXyI1f?=
 =?iso-8859-1?Q?4nLVrA1m58GSw1uR+vluk0/GpprV2HMxNGeOe6SM3mQkVHr58dD5yrul9I?=
 =?iso-8859-1?Q?pmQmvtqnQe5Ie+PIyDtmpNjIrAgjFpwqDxQdwQvQ04Y9kAxu+vyd+ARDj1?=
 =?iso-8859-1?Q?tKwNcfSJtc/kdE3UuJgs7kgfpp+hP68+OHN4yX2+B8AlUZ0giayMAXiM61?=
 =?iso-8859-1?Q?m+hv0jg0haeSplozo5tc096yRxKny0rNFko5mF3KpzRrIxWHqkMYC5J6/r?=
 =?iso-8859-1?Q?UnryHn+3/nJhNsP55ByslCr+u8QTIKdlObZavgdp1X6fy93KW+GTPq9jD6?=
 =?iso-8859-1?Q?uIvOVe2fYLjuHZESSBxvdrVrjN8gnzjhEaxuAECTJ8vXCR3VHDjT9c4NR7?=
 =?iso-8859-1?Q?ttAoUFUVvbLzYN3wtyQ4njIS21eo8BNbL2cFY1lz0dgmInvhP3FYMDdH4W?=
 =?iso-8859-1?Q?yzEhkQbYd3FTZ79pRCC5fyZt0Pb7JrIOfzmKinlKeEGgNHiebzfrlhTv+T?=
 =?iso-8859-1?Q?JF2NLjxEAELcP00a8mmXijvLnCW6e1fMjxeMXjX7LK+6VqwHcurw7AvXl8?=
 =?iso-8859-1?Q?cjXpaebsaIbtu6frxmTAP6PUCTKyptpC6rVaxPRRvMIOSzTBW3ARWsi3VF?=
 =?iso-8859-1?Q?Da3tegED3PJWEw11gnlN2BGTKydblMvHkRztwFx0lIc1EXzBtLMq2l6Ywk?=
 =?iso-8859-1?Q?4G+MVDNN46V13G2QgPGaQj72IV8iihq+s6kU/U9gzwRnpnUoYF3AkJp8uf?=
 =?iso-8859-1?Q?HzU9O5ou6lsMWmxmWgVpYOKSynv6zHBNqUCfXdm7ABD1gT21UTU9mKGkEV?=
 =?iso-8859-1?Q?TfHO6BU1V5wta/t8X6I41flRwaQljuy3+ybcyHyzbGf5OXiPsS0v4p43wk?=
 =?iso-8859-1?Q?mF3UN6WjBhXI2AWIScrYtXTgMps+99dzx0+3nZYWkvjNFBd2teC8eQ7+fQ?=
 =?iso-8859-1?Q?/E4/SD+ENx3OrzhJFdr03XS2/xVR328y6aZ4t1dv8a4gCSs1MnhV3/7Cio?=
 =?iso-8859-1?Q?QXroA13SiX/UywOyUBarpstA+ASRDxBgpqUC8C1Jbwq2hxZW22fERny/89?=
 =?iso-8859-1?Q?9Xk8O1koEkHC2/oytiAbULbTBBm+It/x4tf7ireIj7DoMScHKVZkoEk6Cq?=
 =?iso-8859-1?Q?tMmPvm2VWg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VrTPrmigig02iA81fuFlg2P3alhjRR+RgfgFPzhJMHpwBQRQYlKKmtf0Uh5azof8sGaLIc6FaoBSRmJ5yIgvwGDqCbuDsLEz+3tWhVwsfqlERI7zbzWjoHeyGWH3eR5koEvSjcliSlZBJvopt9c1si3FQET4O6UVphUm7XUKRCc9kKWdPbUI/5ofb2TeICe//TM0VaflWHMQaAB04M9p0DfChZ1m0T6hKc7L/0NI035BP4UmJhMr+A9Yq1Yg2gW9lFyBJv6sIWyxxaJqmvsU/O4u8A60cJVUXSDs/huYfVDo3/gq6dQaavXPPVJ+5qv22yMptM0WHiRXdyF/RDZhAw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ee8162-098e-4f44-6949-08deff33313f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 03:20:46.3636 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xa5326nuKlOjplpFsUWBuVRqTfzZHKsndknQcC2Lsv6WQnEBJOSzERwtOe/zVUBujuM14pa4fGHrt5mwd1FUG+tP0Qnvl4pRbWVzJ6+Fgd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5467
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The SBC controller register space is 0x1000.=0A=
Increase ASPEED_SBC_NR_REGS accordingly to cover the=0A=
full register space.=0A=
=0A=
Bump the VMState version to 2.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_sbc.h | 2 +-=0A=
 hw/misc/aspeed_sbc.c         | 6 +++---=0A=
 2 files changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index 8d3f9207fc..756c612356 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -17,7 +17,7 @@=0A=
 #define TYPE_ASPEED_AST10X0_SBC TYPE_ASPEED_SBC "-ast10x0"=0A=
 OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)=0A=
 =0A=
-#define ASPEED_SBC_NR_REGS (0x93c >> 2)=0A=
+#define ASPEED_SBC_NR_REGS (0x1000 >> 2)=0A=
 =0A=
 #define QSR_AES                     BIT(27)=0A=
 #define QSR_RSA1024                 (0x0 << 12)=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index aa167be4c0..5c193d9086 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -456,15 +456,15 @@ static void aspeed_sbc_realize(DeviceState *dev, Erro=
r **errp)=0A=
     }=0A=
 =0A=
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,=0A=
-            TYPE_ASPEED_SBC, 0x1000);=0A=
+            TYPE_ASPEED_SBC, ASPEED_SBC_NR_REGS << 2);=0A=
 =0A=
     sysbus_init_mmio(sbd, &s->iomem);=0A=
 }=0A=
 =0A=
 static const VMStateDescription vmstate_aspeed_sbc =3D {=0A=
     .name =3D TYPE_ASPEED_SBC,=0A=
-    .version_id =3D 1,=0A=
-    .minimum_version_id =3D 1,=0A=
+    .version_id =3D 2,=0A=
+    .minimum_version_id =3D 2,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedSBCState, ASPEED_SBC_NR_REGS),=0A=
         VMSTATE_END_OF_LIST(),=0A=
-- =0A=
2.53.0=0A=


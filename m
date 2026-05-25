Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59185CD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN9B-0001yk-VT; Mon, 25 May 2026 00:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8j-0001kO-TP; Mon, 25 May 2026 00:42:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8i-0001K9-Ab; Mon, 25 May 2026 00:42:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVAzr5de63FVxWmTGGEZN3LK70cpJNAM0a3pgNIHHKyBkWNuhNSrxFbnsv/2Mfsa/IWYIPGYPZEnE09MciEHa6WJyVeJrJuWIektY1r+lzgomu5a71ryHMTyG7ewUe89H5ZNvRcofvsLQLcsThB8SE+OXz/QPjdVKUdGunOthjInMNrOFQt4Z7d6ipFDFN8Mooh3wznAZkG/W1ICTx1tMAyKf0q1nrS6fguF2ZU4rM/t5Afoogzw9oHrDiEfRJqSBanTSbZEwHUZWnw8s/+655PTdYeqdQeUwbe0i4ULbSxkgHzM3Qm+0OdCYGc+Wox8JO3dwasHXhhUVNmOlELjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuNq0VcPOGIttYSpLdGfyQhU/BtLXpx61UV5F7Sz+KI=;
 b=C5bbGA35D4QunDmRerC/hZrYJF0/SG3+DTOYGebItxYVEYFFNAbZZPSBDsUmOYsDQXGaNy2PRt2rhO/VnEq19LGmtjv83GW0QUpYHkTw6IGmMgGc+5pVRV1YpcJjDlPFhznOR9UCR6bQiBnVsQP5qljRVIXz9Bdrw4iOxLAeupHwF9V8w97mrRNSGxI0AOOrtYWyr81Fp9TVUbLZU2yIN5gQVKTo60L8av+1ncjjrDI66d3S+Tb+V5yut7CGHnW5LaIfNrB5RrRpKKmiMwyBTioByshgCc+l8Jf9mUgcr/Vkc0aHnppo22REbP3xG0MYQMRR5u0eL+To9HHkYEpVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuNq0VcPOGIttYSpLdGfyQhU/BtLXpx61UV5F7Sz+KI=;
 b=fvEa73sZtVSNheJpsp4h5WSvTlP3onlMe2EwBFAYLcLfgbAzK0XRFiMpNcl/vzuL4qBpJtYvJ4OgL4GOsuuTbuwi0+S8iwsCOELMliRBIxUyq4WfGBUVShpf8NPpc/Wa3U/8xQFX5yoMMCxWtwO9VaenLRx1omSgvb9/qJpZ1ZuzlrLlYlIvQ03yUNQW+siFILWzXm+QQzmKwZcQJWTTQAcoUjLIz4dCFH7pB+EciAWdSjMyhH4Rjk6wMSFxuqOuH5BSGnaUiWzo265BKZgAkReaq//nHFunuuCACL34u+hpWqODcdsG5RJmbm9kf1mBSLxJLBX9wP3T0jXuIzxNpg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 04:42:02 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:42:02 +0000
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
Subject: [PATCH v1 22/23] hw/adc/aspeed_adc: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 22/23] hw/adc/aspeed_adc: convert to use Resettable
 interface
Thread-Index: AQHc7ADUE+tO6eHF5UaQHy+YlIMvOQ==
Date: Mon, 25 May 2026 04:42:02 +0000
Message-ID: <20260525044129.3133916-23-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 51113933-d604-4abc-c28c-08deba17f700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: dkKfP+gyZiYibtjnsrXAo/PlVafYYzVjr6mvejbao7+OtG/F9poyaKNXTxzHxwcerXs4G33buJY6WNOSNTO95lZznKtKfg11wo8o2kYfWKloFGy/+6r4z/wQAzkcWveP3smNsQNJku2P00YJeCjlOPFcV4NdWEbvroecEdnu44y86Lh4BDv0m9yo6drGSAzJByl9lhcgSYzumlQKZm86d44wucRCFSgYCLbCk7nmS7e1Mz/NVTN0HVOajSLDhHkX87Ffpj/rqI5E788KV1XiCxKJZiB0cj+7c50wSni/FJrJIUZ3PtVgJzKU2in4Ex9V6ntqtUyuy2Tl8yKjht5HUNFz20vxTu2Nu6Unn5ZJEVQj7q0OHQVsUubQJUQKkqy3ifnPcc7C4w7JRWBhNbIlv8cIplazD4CaOyWWfSqRoQsJnUTySdWMRwjONBEN+9NNu5NFJAYj9pflucsbmpQemUw0bh4tPLhU9qYD7+BBWTF9RNaQXjzzqPvXIPS/M4TNh1lc5fM6PkBwmKhXrl9hi4Lt8pvWKdgdVmKXNDp1+VxnNL6REyHd9Sptl6BP0N4yJItaRxVk4jPyaeKkQtqZbH4Ut++tyQUCfEcEJiAW5jTf+l97ljO9hmbV5uXBvZUF9gUI2GQ01NFvMRdFY9kY5ZTgVZP4vwzqCsDx0D+ZqYPmZ69lNCNk0aOxMtNubiPbN7TWwkBHa+kutAREBWjdAg5ycy6rMuSLE7Jl8UPJz0zEsTbdjdps/bO99b1HZgHmnqWiS27r7msP8mZvNi5StA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2l5YFNIqn7NPsKQStKH1+raVIY4XIjkTiYTQxsuAASg8KsQQ8onZG0D3uE?=
 =?iso-8859-1?Q?gsLfaF3iP/617y4+lmgEJlpA6Akg5HFCaL1eV8Ut+JH21y/zYRRmLJ/SIU?=
 =?iso-8859-1?Q?cHBXP1MgCuPiNuFBy6fJ6cP5dQW4/VS57P723dLWISYoMO0zBiLXjIPwhk?=
 =?iso-8859-1?Q?zALGaxrjtu7DQrdiYI5vG9AoUkHmfho+vfOtjH6Bd55SdbQoPh8wfxrQve?=
 =?iso-8859-1?Q?ZyeA26DV0fFhrHxw5CXeRMbeuEi4I2ii82hBOSxQRmuWXfBXahyOEBi7da?=
 =?iso-8859-1?Q?Ev286wZTr58y48TR7+r+LYnKCAT7UiL3NUDN/seseQWyiAYTlrj1wXLA5Z?=
 =?iso-8859-1?Q?FQO9aLU7vxeydUu2bdsDxb4N56ysRusjQzt/nbSR5Nv416DhGy3YLraaXp?=
 =?iso-8859-1?Q?y3m+aGg2lP6AjrlEQlS1OQXdMJzAoAV/wfwXK4P+I1cniJ8z+aG0rMW1GX?=
 =?iso-8859-1?Q?EyOsrtLFPvGabWDULeznk8yjjxlKtQhWiDzjbyMu3KfBbTOJXfleza+9eQ?=
 =?iso-8859-1?Q?pwsX367cHBM9ywphcDyDHpeKq3xqv/zuK5APhWW/PJCWulJz4XJcRlbdi3?=
 =?iso-8859-1?Q?7/1iyvpJDqVq06805F8MLo7SJ17Iqg+RFsWYndK3kHinDDbSak5YqmvnCl?=
 =?iso-8859-1?Q?p4tlSNclyqBmX6YZ0l3HMrEjQpTHRchDLV3fjpfHsyRa7BllXKYLOigeXj?=
 =?iso-8859-1?Q?MHCuDK9HbNCaAXWQQ7/hRnTzMshFGWwphIOd7OsSGmtgWLJrgi0YUeaV3k?=
 =?iso-8859-1?Q?XnerJo1t2Wpvgw9GI8XYvsi6B/1x6LgomvJpAbG1+lESZg/v63FuuD+1P9?=
 =?iso-8859-1?Q?ZHspDXRzfiJgbIbVk6ezIbrz5pL0OL49RgtaaX8mv0ic9C4Nq/iEiBPuFz?=
 =?iso-8859-1?Q?EaYEes2Z9N7CNGhYi19WBimthTc48FQ75RM0aQOpf2SD9KydL9J5h9L4vZ?=
 =?iso-8859-1?Q?fXzfKZ/JR4kk/ciTuoFL9iroRUo0mHKuQ8BfyNM0P9akdNn8vbUN5oUF+S?=
 =?iso-8859-1?Q?C/jn6vy8ba5L7JUgrGJ9j9JFh2T/TDbNmacdkjkS7pHYOntv6jTlY6yJpU?=
 =?iso-8859-1?Q?EePKQd0XUBtVBlFrH0SLP5Wroeq1o5z6Ydc9A2xQLjm5cg1clibZ0ZaQwM?=
 =?iso-8859-1?Q?8wsWQw/zyyXiWqCqn+sam9q3EGRZLlVwZlrdiIZamhAl0/wXHQA+Aq4wnz?=
 =?iso-8859-1?Q?BZJHYAnnZ0kgbh1R9gpPK9AyGey8iU1q3Drd/XrH1gdpjMRNytDWMuPc+5?=
 =?iso-8859-1?Q?aHdKwKLEfJ0ESmvlKfA6n6KxhP6TfNXgSCSVU1xyTpV5eepXrH6TKVCD4g?=
 =?iso-8859-1?Q?wOD8sjmC5rOOElT/t+oqdU5ze1C+ttQSa54Y/cRuvbdt6BYNMTz6+lvTUu?=
 =?iso-8859-1?Q?zUnjF9GjzLjMJg/4GSHVm6VkLU0fvEuPUCmopsw3VB5NooRRQa++TIpYfS?=
 =?iso-8859-1?Q?K04yLCo1gJjAVhPfHGzpRgYwtlrZLQQ+7olcD75IqLNF+O7TT8toi38hrN?=
 =?iso-8859-1?Q?LtbaDyhFTvijQxcVjBgPM+rUCXQESUkeGrbZdKd9snugqTADvuOb2qEPvi?=
 =?iso-8859-1?Q?m/VbOmTZU5hOh9lVOSz7J33bPS4HS6Mmce/RK092IbJ/JX+XkCciIwc5P0?=
 =?iso-8859-1?Q?2SgidSUvdToSDcySYTeFUv9I19NbrTGe4z/b5IQWTqx/GIxzmlBn+VhTJ0?=
 =?iso-8859-1?Q?OvJMtr0e3vvPTNIq8+2oBby3XOWMMqaR5/1vRWyecpE3VHzMceS/GJDnSq?=
 =?iso-8859-1?Q?3d7KScCChNhtMpCsgXrGs7lmLD+wCjrEdtwWG3JeLrDDthUye9OmqfYBdU?=
 =?iso-8859-1?Q?2pZCBIE3CQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CFYH/xGGSbtmZViI0KSt/FmE+bp/nsbtUnJ40eAdT3a2afFl3IwSrvayMocD5Cbxpgc8IP5ynnK52Oz4r0aGrb9DLFiIU/9SmDtoozpni8JUZb4lF/kXaskbCCeEH+T8OP7FvrQlOoMouq/v4xOiOKpL7L64q8EXH1sbsSVsG9ZZ2NGXB7pSShlMyMGcsAjWF/k62F46Bcqd7JkI4oE0RRYyh6NQIWx7ijOJeqmrT508m5AJaYOPxyWElbH3vJ+QV0ZYT3pM2ACRlFMQLNIlXOr8mbVrSU1dEgAUkoDQ5Oc8URDRRy/vGDC7Fv+U1MscyD0kp2Lbz+9PehGuA09lCA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51113933-d604-4abc-c28c-08deba17f700
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:42:02.2789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqw2Sdoy0GQWGz2cpWcRkCLjniAGc2lk9mmjUsJ76YulPwPNofZJKwm732NLDhyKN7bQZyY75iPizvPPY1V0/MXonElX5YFMG4Yvwy5tnZs=
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
 hw/adc/aspeed_adc.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c=0A=
index 3cc75bbcd6..18b74898e1 100644=0A=
--- a/hw/adc/aspeed_adc.c=0A=
+++ b/hw/adc/aspeed_adc.c=0A=
@@ -253,9 +253,9 @@ static const uint32_t aspeed_adc_resets[ASPEED_ADC_NR_R=
EGS] =3D {=0A=
     [CLOCK_CONTROL]      =3D 0x0000000f,=0A=
 };=0A=
 =0A=
-static void aspeed_adc_engine_reset(DeviceState *dev)=0A=
+static void aspeed_adc_engine_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedADCEngineState *s =3D ASPEED_ADC_ENGINE(dev);=0A=
+    AspeedADCEngineState *s =3D ASPEED_ADC_ENGINE(obj);=0A=
 =0A=
     memcpy(s->regs, aspeed_adc_resets, sizeof(aspeed_adc_resets));=0A=
 }=0A=
@@ -295,9 +295,10 @@ static const Property aspeed_adc_engine_properties[] =
=3D {=0A=
 static void aspeed_adc_engine_class_init(ObjectClass *klass, const void *d=
ata)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_adc_engine_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_adc_engine_reset);=0A=
+    rc->phases.hold =3D aspeed_adc_engine_reset_hold;=0A=
     device_class_set_props(dc, aspeed_adc_engine_properties);=0A=
     dc->desc =3D "Aspeed Analog-to-Digital Engine";=0A=
     dc->vmsd =3D &vmstate_aspeed_adc_engine;=0A=
-- =0A=
2.43.0=0A=


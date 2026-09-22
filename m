Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093BFC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOR-0007bC-V0; Tue, 22 Sep 2026 05:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOQ-0007aN-7s; Tue, 22 Sep 2026 05:02:26 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOO-0002C2-NG; Tue, 22 Sep 2026 05:02:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaQb0PnoZF012fCoNeZnKUnGF9ejwgus1ojjIVSbuMlaPklLXvpcYg9V1w/MP0TSbwiOX5rtv6YPesPlKSp4wsHyRkTyA05seiq/NysvpSwSO8etljkYlpaWO4/EzQ85sOyqv2hnj+nHDBZf19Z4ROFl/WG/rC2wAzglPsORsdPQhYg25ziWesUb2hWYtrrtQBfO0KYut6c9AMsgbIFHkd0N0uhut4k/Eupg7WYRGezCt0weOoKXbJLnRXY7NTE5rCso3vsJk3Mi/4REhWOONrUj/MaWDh8KO3yosLWThh5H8T2AMPrKN6T/bUMmJ1QeVFu3lu9Mzq75zQSibfN76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvu2pMHkc6dZYHrkpyvtL/QlP3wxUIYfDi0Y0W2Zezw=;
 b=gJW9ZBJzcIOUcaOc5nthbdngOMUi4ndLsuo5ZDCLm4FzLH+QA4hM4HEGmebLuP41HukYGLTz5JGgAAFRahoRvE65wZ9fJPzzXoqkYN+0Kntg2/wIkduIpQmbHXz2WHi0jcTAzSbPFoqIgXwV40tW0w8fI06iMHqJi5NX7DRMg6XGm+7gO4H8xaacq7Ur40VHMgGAuYCb+WAzd7gEzMa7Eyyaa/6vBQ/syMH4VlEhQ5R1e8SdhrDItP/rNu7OPJ/FhpoeOtZuibTi1JmC697b9fIebQfAS4G9JG1YOAW9bV4jlUIegR1LhSbVLXq82UCDRLKiChutVQE6KRKUiOViRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvu2pMHkc6dZYHrkpyvtL/QlP3wxUIYfDi0Y0W2Zezw=;
 b=qaZ/wpPaZMaXSHG6DH1tcolAjKnjCCxMgiZ1FEBtGycFJxV9yCfcfq/WN3hJGbUwv9+xHGkmBR9dUgMFoq1dqCzjXKZICEk+8PyKc4oXTxbc9l97qtE3gHKhJRTz2HDlQID4KAWZAdTSpvS5TUbfxHnE/VOCA/w5JT/+Pyx9ANgtz4LizfqveNphHKo1wtIN4IfRwujiOdUC3eL6+gBN8Wge7WMusq3h58fVJmzr78l4XQvWgz4nykocM+EwOt+5Pv1ZwfMG4TE8cngM5k1UsHLK4kfxgx+Xw/eYZJ13DW43G4VnEQeaVNsKLnfZrSuRZPY0vTpBZ8+lreyEo5Dzrw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:14 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 14/19] hw/usb/aspeed-udc: Pick the EP_DMA_STS path by
 direction
Thread-Topic: [PATCH v1 14/19] hw/usb/aspeed-udc: Pick the EP_DMA_STS path by
 direction
Thread-Index: AQHdSnEOSxNfqx/jzk6omvXAeKQTJA==
Date: Tue, 22 Sep 2026 09:02:12 +0000
Message-ID: <20260922090154.1792077-15-jamin_lin@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY1PPFFE5B965AC:EE_
x-ms-office365-filtering-correlation-id: f716aa3a-736a-46f4-90e7-08df188831d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|5023799004|56012099006|10067099003;
x-microsoft-antispam-message-info: 2vkmTxs4lGmaUpGAG206Lt8A9ctQ3i/OIt6kYsuRUb6Rz+1MG3ikxnXdwR1ghViDysDce6/7dKOo8nOQCEdqvuD61EW7NTxopGY5B58XnQM49gEzBM1fs0OaSJoVIjC5CJ7JDN1MeiwE4OqDrzxy/u6FTI+E7lWxxyZHhhOcwnovZWWPEoL4ZQyy1Ym54rokB3xfa5EdfMQu5whC9zCwZ+BBm6YvVqI8UnNwtiJs7WGzfQXR34IEzka2UcT+h07T+okTXXSKUolfpoJr5aQ5Tuqe3rNnxLBBwVaQi+Z/fI81+kAWJ3PqIlIIeEUDIkXtW5XJKUfqEyGfGFtxZVo/LzotqSYP6b7xZ65lIcU5/fppTvc52AQhnX56SXKGMkUPPwO8x5En+Y7/0QBgMxwZHAqAOYiIBI9ZeASvG6SaNgaqguD1YyCWu8ARuKkbwqVc1KbfkkTu30ZqUAwbWpYhBj4MbEDJPLGU+AguQZ7xQwUqQNGNCP5ZKsqyjxommDvLuHU8c80ScS4v7lcBI92+sqQWmUzpVDnM/NHEPvpez+rgGzPgO7gmnbS0y3cII9pAbsgULMZuzVdblfx16CxpEJWfs6/0cpxJOWNVuDY5FA5CyUNwtUFcplcecqX7L1o07fQrmrFxOhrqG1tRasZrp91nX5z03XrR2E6qUfHJIZniDAOKWFj6qOo/gIzsdwBaL8xToGg16VtbRKzY8Gm03JVL/eX4BIhwOB3cMbwlWf4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(5023799004)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B1sNhxOKVU6FMsZsQoDdzDPGa88As3qmWxAU2Wd19cfpm7KH5McanaMAEj?=
 =?iso-8859-1?Q?xnVA5xhi+iLpcX9kYhNnGuA5uQo+yzATqqSTVl5cR4115p+nKaoFDuAvlW?=
 =?iso-8859-1?Q?vr8VIJL5HV9WwvDWvuKXiqQVl6tutqHp7z6GB9vy7EmwFdeR3/aIilYtSS?=
 =?iso-8859-1?Q?9+cVEuX56VtsjwYFA9qaLqG1FUZiko67AhW35jhXG1rrnzCgkZzLbR5+0P?=
 =?iso-8859-1?Q?klzQ7JwCRsqKDoC4LgKhVfUeOU4Mp6HCSXDw+Xex4gxbXcL+Y0aXQ+meRK?=
 =?iso-8859-1?Q?iCwxniyGhlXTe7qRsKpm5dK822pFx/i4lzVZ7CUYrPlN1Mah7s89pPxRZl?=
 =?iso-8859-1?Q?JIMabQBRkkjYW31jaaOBHcZZA7zcEW6zlACWeklbFAYmJyT143eaUwb8IU?=
 =?iso-8859-1?Q?hG2rkSvCEQ+dadzWSosN4Mkbk9NoPgCqIs4o+07gQ0KJy7/Z/bHFxRKjlY?=
 =?iso-8859-1?Q?V4XmXPOafq5iEoIAPiIRY6iesqwc4modNuvfQHr1Smx2Rn/5l0iLRBc+ZU?=
 =?iso-8859-1?Q?BEw1EAbebBW95Cvr0eE5rMH1fbDsC/tpqNF3DDTtaH1qStZJ/YIG5pK1d3?=
 =?iso-8859-1?Q?6/sbQrbRKUnctjl6CCf2pahnu3bu9z+EFHdOBGjQiI22rnRO4oSkS4o4lh?=
 =?iso-8859-1?Q?gDEP1cbT+JWcfzArr327vztDX2rZ/gjJeL0ca9IjirkZTx92WKjevhSyc2?=
 =?iso-8859-1?Q?mwUJVx3Zw6KrTxXvjf+qlM1z8is52m5GUBLLWKz578HP5c5rq5aIsTteQB?=
 =?iso-8859-1?Q?PRQCBEXPjudwVPwBLGCDXWhoXLmDW97sDYGgC6WsxGpH71UMSm23jHma8S?=
 =?iso-8859-1?Q?q4k3/tqdQeuQZNmLVOKYd2D0usKL1rxqq1TF7ZPjyC7qtwJVfKwvWrzcAF?=
 =?iso-8859-1?Q?cD5OiUHGo0QRCZ1QQNOcw8Kk9fXUBMrKyXEw4I86yb8LypbS9Fud0ue8Mn?=
 =?iso-8859-1?Q?JbKtv7hyNldkoYsyRm6DhmZomSdiSREt3aagDpVR22kgJdlCj1P+Zk9632?=
 =?iso-8859-1?Q?5BSWcogDOg/fOJAl4pS2WyjkKq0/EYRE2m2vebLnpE03ma3dO/l8sYGo5t?=
 =?iso-8859-1?Q?eaT53i5GkX6V1CtB4DQch8aVw+iLbDOouT1j+ocUvODo1NvCknp5wpZ+In?=
 =?iso-8859-1?Q?7kmxeNXMR0WEFRT8KxrqdQGP14Y/a8Dg7heEj9xeXLn6hVsMFJp3m+JvDA?=
 =?iso-8859-1?Q?lPy1G7IvuOSSLRHzqO6ORnESJGEirqsIkA0P/vuKXHiqeQ0qMDnHVoBJGw?=
 =?iso-8859-1?Q?TTSi0pcyZIvHk/Rs5h+IP6J2C8vuR26osGSR/oSQA+bgltSsJhf0n7uWuH?=
 =?iso-8859-1?Q?ogr8BQEp+fwWIN+MQ0jBhpXY7G2uS5joGKns4ix2uDCguuU5Rgo+hICMEi?=
 =?iso-8859-1?Q?MTwfqD78uBNYsugL/CXtQ20wQQmkkFepGHPqKOghz29F4oJrysLe6ZAUb+?=
 =?iso-8859-1?Q?OdVr8fSp8gG6/GsPczAk85qsBsR9w/Z69waf01HeMMvq3AZv8Dn1NHntjX?=
 =?iso-8859-1?Q?/P/Cy9SlDuSVXKQGjvZLL/4L2LaOT1EdHcjJ3CErYcv0yzBSgbcuqGXsSO?=
 =?iso-8859-1?Q?DMgmD4I3WsJ0YFGnk4Q1haq6JLiYTJp1wCDppj86h/W/V0vfxy57s2QXTO?=
 =?iso-8859-1?Q?NvAK+1yjRxXy6/yywDXmhUeNF1AdAU0nnqb9b3VG9yZePPxXJBD2fdfkI5?=
 =?iso-8859-1?Q?Dw3P41uRgH5zSQpTxvSp0kXjyymcuDqkVOcsZdLdUG7ITd1MqYCiLl0kdc?=
 =?iso-8859-1?Q?b+phvR+Uwx0s+gkGpBZLidYnsQruC4GvmQQ9VuwMl+03z3C6y51N3Ax1fe?=
 =?iso-8859-1?Q?GgyPyiJTUA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: B0Nie0eOAA/Zh36ikYq4wiFgPIcEvxyYg965QrvrYDIcBf2wwuhkZY0aEo2b2oikW6i6qY/VaZAutWbR9vhpfYew/d+nCqyvI0xWxh/hL236/Bhx79Dt6q/fxaGhNpZP1Oe/XEGMKlv2YXrTERFHIMMj0XnvT8+o2Jq59Tm4xWkI3sqRqnslcTI9J8PYHRaj7E4hrfLDl9Sry6kstxdyG5vO1SJIYtQ0ypfIVCtC+KgsaLjGy1XYH8YerVhpN9w1aH+WN7eqixL8T6poELyOqu9c/xWASyieVZpgNt9z81/0fX2CXEJjMV1LjxZieFL42MnUJc3wNCThEp7bNM1glA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f716aa3a-736a-46f4-90e7-08df188831d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:12.9941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BhpYzQNHmU2+l8XyPE+JWMf+txYLGyzTKoQBiD/fGFyNpYlRMEYGKxXYuc/9my/kIaQ4Vk3Tg+fmCh1ujUoP0UL9qxabrEyPSKpDoD7W5Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFE5B965AC
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

DESC_OP_EN is the DMA mode. It does not tell the direction. The write=0A=
handler used it as the direction anyway: set meant IN, clear meant OUT.=0A=
=0A=
Both directions support both modes. So take the direction from=0A=
EP_CONFIG.DIR_OUT first, then take the mode from DESC_OP_EN.=0A=
=0A=
The model does not support OUT descriptor mode. Log it as not=0A=
implemented. It does not support IN single stage mode yet either, so=0A=
that path does nothing until the next patch.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 15 ++++++++++-----=0A=
 1 file changed, 10 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 4572914e16..c48e2c5f1b 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -729,12 +729,17 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
offset, uint64_t data,=0A=
     case R_EP_DMA_STS:=0A=
         val &=3D 0x77ffffff;=0A=
         e->regs[reg] =3D val;=0A=
-        if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {=
=0A=
-            /* IN, descriptor-list mode */=0A=
-            aspeed_udc_ep_in_kick_desc(s, e->index, old_val);=0A=
-        } else {=0A=
-            /* OUT, single-stage mode */=0A=
+        if (FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, DIR_OUT)) {=0A=
+            if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN=
)) {=0A=
+                qemu_log_mask(LOG_UNIMP, "%s: ep %d OUT descriptor mode is=
 not"=0A=
+                              " implemented\n", __func__, e->index);=0A=
+                break;=0A=
+            }=0A=
             aspeed_udc_ep_out_kick_single(s, e->index);=0A=
+        } else {=0A=
+            if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN=
)) {=0A=
+                aspeed_udc_ep_in_kick_desc(s, e->index, old_val);=0A=
+            }=0A=
         }=0A=
         break;=0A=
     default:=0A=
-- =0A=
2.53.0=0A=


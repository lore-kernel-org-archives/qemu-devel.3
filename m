Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E2606A99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ZrVdET5q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhEr-00009p-SL; Tue, 10 Nov 2026 03:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEg-00005D-31; Tue, 10 Nov 2026 03:29:48 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEe-0002z8-L2; Tue, 10 Nov 2026 03:29:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6lTPJCm3WOdp3X7L5pFSzDOMP772enQwP8EAM8KCVBoRcgIphFkOwjhKx8hjcpobDSfpe1p7SgiR+k24h00+FsJrZJBqKr1YK2hSPNBea/2rOKhULnn5MOXp0FZRqJHWstz28iKJ1rAYSL2zG8I/NqcZJVPyMFac6uGjr2CZ2ski+746jb7ERh4vf6r1ibyUUXgwpmwGcoo94G4pItPh3v8aHQbPuRixlWLnv96M4+71FVC0IpxcSZKBNTni/V/wAl0nSan/VGnyCK4Vvf6HAqtViaMO/7vkbPvtjldNRjqiGZgXXMUapJb5KwwuLlBagDA2CEv/GlDMxn9UxM14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+HkIj+Kffg5NxQprCmXQhpnTRAK7mZ8I1y9w3+szSs=;
 b=XpNx8/8lE9mUnvsJSwwZPHLJvR1TaMktwPvR+oyso9ZCKikLgMeK1/ZAHABHaRl6BbsykwJpNcMI2KpkHXWk8XDkx7wgEq9xahuVfWk4DXMvzqQ2G/WYB+uLSblJJTjxUbWeUlwe1mYtr1+nBBduIJEoCflheXK9EVvyg4utj/OCxJONjC4hjyJDPYjZ6vmqOqToYSZ7AawUy2L9W7OeNB0zSGeeufba9HC41Zn8AKMaClStw2Wu3LQ7gHX9iZK6kbFod8WsNHopuNSz86FopWsV9JuzIB6XGCvL4AGEoxIND7w7MVZ181Lh/A8r25ZKyGLlNVofd3WKX5vYx3hviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+HkIj+Kffg5NxQprCmXQhpnTRAK7mZ8I1y9w3+szSs=;
 b=ZrVdET5qUikHcx0WsgJ9HVK3ejMwjWmQ5gEiK9mtJzBAS8R7ybyv4UHf6kAtvyp9YyL7t+pCYDeMgMBEth7Zp4/qwhyIz0fDb/Of/wEu4IMAqaY0ZB99w3GouQYDfUWyZzHSh1dlxqfhkDTlIgD6Dpj57JWJ4wnInVjOSlXVCZy0lWG7fvZoZr6JNkwtsZMdWPOokoGTxx2ZUzKTYzLS+LSydKqXXPNrnVoZssSbny6VFK+8Zx0OvVnDKv/VvIjLPTVb6RBxwCa9Ivt+R70zdHqh9yC40DYvQmH9GOUvBFAzMsDHFffyQUgC9bkQS8u4Fku6jb58Hx53fGRlbBuF/Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB6047.apcprd06.prod.outlook.com (2603:1096:400:33e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Tue, 10 Nov
 2026 08:29:27 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 07/12] hw/usb/aspeed-udc: Pick the EP_DMA_STS path by
 direction
Thread-Topic: [PATCH v3 07/12] hw/usb/aspeed-udc: Pick the EP_DMA_STS path by
 direction
Thread-Index: AQHdcO2YiagWLtD6LE+XwHhV/95s2Q==
Date: Tue, 10 Nov 2026 08:29:25 +0000
Message-ID: <20261110082917.240329-8-jamin_lin@aspeedtech.com>
References: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB6047:EE_
x-ms-office365-filtering-correlation-id: 42beeea9-ec1c-4d48-71b3-08df3f04bbfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|5023799004|56012099006|261009223027099003|261102123227099003|261021123027099003|261021121427099003|261026121527099003|10067099003;
x-microsoft-antispam-message-info: AxfuzcvjhASd/Vkv4aYHaEfPAvI3/mSRxKFHXMGiWrJONSo3gxtsVibljOczpHO2MFrK1k4rufho6KpAP06FL3GzM7iPkb9X0ANRQb3Ult+BOjk0b6Q1/7jfnWLPMHJ8MxcnDzuyzfGM9ZPSyg5I3g6eMg9BVDtPUS+zSxrf/e87/gAMQsr+moJJA8sKbRKyBmbwyLOr/3c44goGmPF7pOTLwUHK0bazKa9WPwvHm1TUOhqQvZTJIBQw0fF0POj3qig3mLMZhboJ0LYPD0ix3130vqGjgpHuCt6IIZjodjVDmCxp/C6/Hk20OqMd2aS4vO7juZML22QldE0Gc/A5y27bwYMx3uFuRTNfAIv9d79MjlJJ40//zAuGYryIMnasZr6xbd1OEhN05NRuHX4G5uIPolKEjt/wycVVJjuAMqiy/jiHRHoExW1c8omuEtl/WXfT/ZL74ef6yqv6CNGYAZiw4eDiCQUIR8gg+5ok6Q7Y5JjZoUgp9GUUa/mqD/CGTr3t6WxMcOx7Aggy1wSMCKzo97gb5RMOqfaE8YQeweC8saaMLrx+XYiLdMRF6eeErTFA6I4aOB0vgkIThBhtwtGsUsRigFHQd+8dZ8hIfAcLeS4o1LvHoYD4X7jJ6/bb9r1BZZj08iKHh4MG86tVWvcVDoz6szPvsNbORtNjj5dDGFdi5kaFI8bdqLwtt6wXnTtfosBsxKutNTNzgV9YUTmi8Zwqv/m70GMourTrB/Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(5023799004)(56012099006)(261009223027099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OnhW+OoFPw629e2GA3bPXBX6axc8Y1oz9ww52maPrXN47e3zRrxiVLfvXX?=
 =?iso-8859-1?Q?mNnvYXDCO5c/q2e2CwXepggN3ow9Sp1HwSEd81YXG+my0U9lQuhdiyZddT?=
 =?iso-8859-1?Q?019qO33ktJHfbsgzFNz4XjWNMtWgnRIjA1D6GerxvbktC8wf5UacaH6JnA?=
 =?iso-8859-1?Q?IIXDjvV8jF0QpBL9UmUmeQEOYXHteBIB5SLIliZooDO1chcAYsyd9zaS2c?=
 =?iso-8859-1?Q?p1Cw+Dehk1SsNLuCRznwdrqeSADh9jqhKXELzOsrt/lMwnNLP+s5MHCYLK?=
 =?iso-8859-1?Q?86xROyq2VMfbbIn9vRBnGmS+ow0f/mH/WOjuroLlQM2XzormXLwvXUquCm?=
 =?iso-8859-1?Q?34oaDOlhozJSrCNm1kcAl+kWsCP2nMKZUG7O8Wcfqd5vLEMTJF9U+GEt0l?=
 =?iso-8859-1?Q?P5YX1u+SX4eOZXWNArJvKPWmbcHACknzZUA5hgOSce1Qbb9JmjnwhamYNQ?=
 =?iso-8859-1?Q?sUM3lO/vpn4D4NG5YxprfRTVcSQC68fi3SLIhwpv5L6BCN9bv+mChPZg4v?=
 =?iso-8859-1?Q?sgxEJyE361UPETvPW21FTuSY0u9lyAaSI9L2fNCPK8ubas6xcY6S0ayQEW?=
 =?iso-8859-1?Q?qJsCEqne5ZQqQrqEj13YEfVA0R1onnWBOo0JtzIoKYIdeU07iDCKSVU6WI?=
 =?iso-8859-1?Q?4OCR2KSxhIoweHxvimUyDPEUkxKqHtni6SQu2ujQTEyf87CfIsvY7+yK27?=
 =?iso-8859-1?Q?gv8IivG4UOf+jbLYR5BM0M3RJ2mEJdADsKtCGr/eZ6/Ni5Y9SOMZhxpPEe?=
 =?iso-8859-1?Q?Ompbhr731hX13c1ECnGFLBYtK8oKZxdppyR6H/beDO6ux8zXN3coK/CRR/?=
 =?iso-8859-1?Q?ABMk7aN8XAu81BN7CGOcVDVzPouLH4aMLALWliRyK6w1gY7pkii0DBVTZ0?=
 =?iso-8859-1?Q?2qiV9lI+Geh8JXE2Aq56MGnopJA+hVK6rc6EEDtNu1OOY3JsC7tB4XIjtq?=
 =?iso-8859-1?Q?mVdaX2tRx89F9uSVajFUZifnhqemL+BGFpvzFJChtrGv8Hm64C/oaBcUlA?=
 =?iso-8859-1?Q?pHdNAtqwUbsA4XN3TOSMLgsv/DOuOMxjteRz/jh1ntcKkPJXcJYC8fgNpU?=
 =?iso-8859-1?Q?ORzUWYymZyuU53rf60xkE6VpQnmvJXT7bDuUoby67DI8RIiSJ2KDoZ6spA?=
 =?iso-8859-1?Q?9VnzQEEVOT33IU80uwB9za7MkPaLWRwcCeIKEG1YzhwAUZgHuR0mqUbjvw?=
 =?iso-8859-1?Q?IygpUMcEijH9nJPzywrWi8JXXrVe3KNm5V/AZXp4fkxzTjXfTehMzGh88x?=
 =?iso-8859-1?Q?LCQfDQiqs+a7+qZ2p9CXfEJQHFIMmsGsIGVaOkL3fSEHePtSaTHiP3QfTo?=
 =?iso-8859-1?Q?gD1gnmEoD3lkJ7C/afZ/pwfb+wZAQsOn5AgJc3Jtbark8FhJ/kqQZSzwcy?=
 =?iso-8859-1?Q?NO28tOaq9mFmil0EP/cOA/f0kofbkPUi9OG1BUSg8u9b9bp/ostoPGjwoD?=
 =?iso-8859-1?Q?8IYUSoM+H9HE2dlTKmBnPQGtlvCRCWvJErLrAtq5e9BD4NNOcX9ro8N5XB?=
 =?iso-8859-1?Q?FQ6cgYyeEO/2NuF4dxEPBr5+We3ipQfslsOqnB1sbmdONkY4UN+vF1YnH6?=
 =?iso-8859-1?Q?yiPQ8aRW7C0+oB1YaZIUzS+S0qXQgeaFbqF2VPNcURbqj3poIVnAslH4eR?=
 =?iso-8859-1?Q?Z/IqeIWd2vimWJBk76oj+9q0LjO55fDtwTlvNc0yDR1HnMf7pAEwlogEvP?=
 =?iso-8859-1?Q?K7Fj31VRap41Rp2NnXgLBbpPdj3qKTTmGgMbiJcPj+tW65GqCtXS+6JjZe?=
 =?iso-8859-1?Q?hQZMonzEz5wQb3O+HZlmGavBf9ELouXcmWg3PkLSyk4XhT2tzZIpU80ckb?=
 =?iso-8859-1?Q?M8gmPTHkSQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42beeea9-ec1c-4d48-71b3-08df3f04bbfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:25.8735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cN6fZ0VyS8WjrsbWfXBvNmMoCL5Y7HG6WEHvf80lM/quRZZYGlrav9JyswSiGqraBap6IOPBbPgQ7Dx8E2ROrIIPEMQx0ADqGciemaiT0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6047
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 15 ++++++++++-----=0A=
 1 file changed, 10 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 5f7b9f94f0..6231b96487 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -739,12 +739,17 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
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
2.43.0=0A=


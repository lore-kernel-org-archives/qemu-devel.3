Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E9CC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOL-0007X8-JR; Tue, 22 Sep 2026 05:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOI-0007Vj-Aj; Tue, 22 Sep 2026 05:02:18 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOG-0002C2-MQ; Tue, 22 Sep 2026 05:02:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWgl/UEP5fAt5guEOeFwyrpSG5R3Zvk8ZgKhs17wGIWEzw9xLCHdQNUW8+RE6qcQ3gieaGfpx/DosJqylbTbzICwcoNTGsuKZktCdX0Zvl03njSjVQZ/76sziilMYfI9fYIcmq7mkp3yIGT4YO5Y6OfHSE4PpOiy5Ht5rUQGMj9abYYApidqfPNT5Vunep8Vvk5nELYYWKVpOT2OZ8rud+ObdMIaHb/XM7nmynO2wf7V7kYt0H0Adr5GRewI+elZr//sC0pRoKJsbm2oLqfMbM2naBKbrWzG/7dT/rw94ujfRYj8hCi5EvF6qv0VNcJS/fhrdutEc9wZMQbhsfl4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXyPsUOF6Dr+ybSUviulLSM6KRHCdPuRSxJcpIt14jE=;
 b=fYyMs4dIPkfTwBRJSmOd8XZmFow0fgi3z5VqyIoIeGEAefhiwO+61miD4jib4spQOnIt2bNpmTL5r/AdxZFikw1iOBng7Ol87ItpSDGJ/hoRfF2CcJhOR/r4ETlYR578ZWSUUgsoxIb22Ew941UiD3CTKY1V3L+S/Ga1UFlL31fxJwZBjzP+tKk4oTmzx6M77paRyAmFjhGH273ZKF+QGIsD+pFRYhRtjRZ9SLqt/2EZ/rDWpDk3zgbwnMfZCvGdOVfb2fiJk4RgqnOTRzd3GXOwt/S85qsbl5lyUUZ9H5Tr7aJUbeb9gajHkva6W0SY+o965Nd5irJX73sq7iOPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXyPsUOF6Dr+ybSUviulLSM6KRHCdPuRSxJcpIt14jE=;
 b=OYVdvmCAH5XDZxcw2Khv3DsPo23o1yUOyfZYOJcRQhBcuiJgFUTYnsbJOp9xU7HBRP+w+aJIKU/bYFgSL4da+JmUq0ZouzI18lRwzs8E8/QB96O3MtMD9c0jNMbr0dKuTipJy08Zel7uD9TVt8VHrK4RcF1haJcsapmsDuLOhoj7BgNeKC5oM0ucZ4VMZ+1CTWndPs7Giy+tSLxZV7nQJVA1cGreMwQ7M7s20iS2iJUe/4uWevqAxPBYZtYZI6Axhch46yrXFGv4o5cT/m0el/Kxv+yk/QLnr673hmrKpyvhh+Phrbfy9hOgFM936QOi2QgRTsQsnR3bC1Q6fB3jBA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:07 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 08/19] hw/arm/aspeed: Enable the usbredir server transport
Thread-Topic: [PATCH v1 08/19] hw/arm/aspeed: Enable the usbredir server
 transport
Thread-Index: AQHdSnEKLOWK1Z9CFUKdFkSODpKLfw==
Date: Tue, 22 Sep 2026 09:02:05 +0000
Message-ID: <20260922090154.1792077-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: d860094c-4dc4-4cb7-1de2-08df18882cf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: AF+7koHwrCST55xYUU3/vcFKddkIsxviRYWClygP7yYFOuGHbmGJlI86SnkmaBPlf+2xGM6L90XPK8izbRytSyAxj966ga5FJXvXCGhzXkvHwshcFsk+fhh9CQhOOiUsb4BFTtTDh7oa5xZQhOIOA7ZLMuv6WpzSNsHcA5j7KVShVhUtz8tYkaep3KT8dwm34tw1lG9s7MwlPlFwO7Jx7oCT3qFZ0HsbdQFf46vhThpFJlUbfmbge1q6kWOWyY8OKmLgqJtjINl2aMxXC5Qh0TM6q/jA/jrcR/0cqZ496SvPXx/JFxMs9NRVFgxj+5es3a+CyKmEUCNOYsKnUhqAAXcbvIbRgaQJddrKgfM8IEIwfnCNHTg7SmN9Yh/rUVQJiS7FNezGEzQrQeLyjEAkRl7yZ8qAxmecZDokRaYIGRzbVngAkzOIm7/F/0GLy/ZgcOTUZqbnNfmFVU5vyLcz3IrphxQX3xyRmDti2SUIEl084by6ha5fL39z8KytWutgU+wQ0s4GhLCSR79S/XZlBYWrWnkbDXfZ9SMc4WN7JIq2N8m5+89a8TzG13gQbQDMqcrG55Ku2hP/dHMRutsbwGj5ZCKpfTbwnmk62Mm55pUbJhRVMJG88sfQ+qDhdG/+O3MVY7UJ3glh62zF7oq90o3sVQVIbP6RqnnZ2vMCkPuYDH+3FSW4uHnKGNlSpKDLggLHkWsnhMRlUd5L9POlfBxZo/EcAvIBaGYx54qDj9w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R5NoyqrxhD8WpaQFk3udI3qj0EG3xH9wykk07YXtDfyBdHDoRk+My7+h/F?=
 =?iso-8859-1?Q?KOdE4BimhHi0mrPr8amqBYc5glo2qpkcBPSB/KbW7Pa4wRYPrMFsXVKB9S?=
 =?iso-8859-1?Q?9kLhWfQxaIBr98m8uhlz/Fh8k0dAwKzwym9rTmDED7MjsTD3T+wuWEM7rQ?=
 =?iso-8859-1?Q?XXHRDnU8IwBJJYrVHf0hpPWpgisSPaGzHTBN8wUFA1S+b0A03Wm0Hey/jw?=
 =?iso-8859-1?Q?mq2+GvxamVpD2uWugYSBPloHZ+Tizf+aYd68XCdg14wi32/rNSPEhjb5nL?=
 =?iso-8859-1?Q?6tdQWjtGL+ZzI/roq26DNQcN9Ni1u2WX+GppFOO3fS8AIYoJ96Jh8+a1Zt?=
 =?iso-8859-1?Q?tib/43Vw/+lJf3lVULITY0QfNLYESkUDI4BQmEldrHcFfZ9uciYh4Ttv7N?=
 =?iso-8859-1?Q?72kuk+jSuVdORP73ClQaOIUrNUAIXhUUdXOJ5W508yw1d7xCSUv88/+tDR?=
 =?iso-8859-1?Q?+GqtS/MWnx0QJvKDiFIGfFpqppooTtptknBBcc7oL0INgOZaNLwQD926kg?=
 =?iso-8859-1?Q?qIHTHsMqrV0dSCE3bWmQPEwhKyjaN+hW0XwO3XS9RRUh+ge+OnokE5+IOZ?=
 =?iso-8859-1?Q?3fhPcTxgPJ44TO68ACI/bnJwFtSNT104WXA40uz9v2ll379aMVDAeeFq/6?=
 =?iso-8859-1?Q?J0y6WnVK2yOw4gFCjaUp1JP9uzDBcu5PiolXlnpjcJcKLv4CUE04GoWyv/?=
 =?iso-8859-1?Q?xMsDUVlOevS13Vf1JISPEdjppZYcbNKQISV29k+AkpLqO9TXBkt60FiN3X?=
 =?iso-8859-1?Q?MMDJklQZKR7WS2eFpt5FmFkJf/P368glG+cSgzsIrzl7vicAbvV67MT5CX?=
 =?iso-8859-1?Q?VqMJNsNjS28djSoMnLQylEqzBXrBCEpSfwSa3L/wmaKRqr2WFO3HyiRyWG?=
 =?iso-8859-1?Q?gKFM40BaOL/rrJ0teGpuUCTglkoa5wWx5/VtlVn8dESsTzhwzjoDs4BITe?=
 =?iso-8859-1?Q?ZBfFeUOaFC3pmbdqhFj851ckUGKw6pHJ8mWys/ajvIEHZAKXts/5yxYZUe?=
 =?iso-8859-1?Q?zn/FCWxcfvaXY7gB6qSZ/E9qF/7Ayb8nFOyNYqQbxs2kwhLxLjuwj8zclT?=
 =?iso-8859-1?Q?bIeyPgBPFgKXVCdc+p/NVcBZfrcWAJT5wBDJKf1cN2toZqhTut1VwwMbZm?=
 =?iso-8859-1?Q?vXDynLfu/SDuRheyu6naIsuWNaCMGVoxSj279g9ncXRD3mTlYcyp9+uGta?=
 =?iso-8859-1?Q?2syviY8bo5VGvbkBU6BS8ppFTOsrKICtUjB8PwGaRovaxJA/mHBokD4JMB?=
 =?iso-8859-1?Q?3tcdvR1vDpuWghzb2Ku9JBxM3WZtjxD08nhvM+cpbgBX0/AUxDXUvkzwP+?=
 =?iso-8859-1?Q?JUVpOSoFsUvKClXILvawZSW9BNgd341rCJCDXsBJbtMUiUGsUbwFYRhj0J?=
 =?iso-8859-1?Q?2ocgRWZRMohLnZNaCsK5JiBwXPgBnqR0yKcGnexvw3YqAdHnV5IDMHDMg/?=
 =?iso-8859-1?Q?bI8gK/ZOjf1mWm4Xd2iCwQWVVM0V2aJ9fFK1vokJlw6Ms2skXuf2BYEr7r?=
 =?iso-8859-1?Q?szVTh/xt9vRTx6MHccmne/gLf4qKRPeCKheu0fnZVCfYSusuWrfWTSGfSQ?=
 =?iso-8859-1?Q?S8m9tFY8qCBKL47Wibb6zQ7YgWsjV79wZL1MIIBWWT8GWSYpcgt0As1kXB?=
 =?iso-8859-1?Q?O68SUYKpIsLjIDbP4pJ1/2Y4EWNNAOtMglZxnuTB2y8ZwBvlPCjWXs5ocE?=
 =?iso-8859-1?Q?SN6HSMEOlPCkAjNYD8TFXS2iAFqzeM59JURowaPCB/OBOfMgH/d5Nk+kHs?=
 =?iso-8859-1?Q?RAEhIJ7zCIhrZ5SXXuiSbxXJJzk3vv7OQM0LJ4BrTETd/boUhFl5Jrmx95?=
 =?iso-8859-1?Q?3OR+ZIaVKg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cSnnqYH/soSgrKrNz01YjbMfQm0pFQBGvVLd2obWlBpObthdP2ETk+tvhzcsLkegqrSfGK1zZAzE5DS8H2EHnR0F1ZDELbFVPO5GXlXJRTfUaLl/1WyRiSyRtznS6NNNJy5X1Y+ZniZ4LvU+GDj7Xo8nnVJH/nzQpw50WdYclSiaiP05CGs7s4gQIZEj3vH3jlrzkICVYhnfRaUyvUpWA2hc/vY2BiNBLnp1Qk/tnCyrHn0P+FetNfSDdCb6GjSe0CPlLmBLCxvOvIeWzWqLvWbYruajh94efpwLXi3LN193TOiO3uijqymYTUj6moB3y/KQ+bRlOVsyhEBnfWm6ag==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d860094c-4dc4-4cb7-1de2-08df18882cf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:05.7873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edg9scGaE4F3apuNIzEUhHj3Bn3wBqz2zNmL2IPBWPndjFJLwWW/VQ3owJ6YAc5c0BJsP0zBE2Gu2XoDpmb0jUdCp6v21ueJlDVZEtsUIJU=
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

Let the ASPEED machines accept "usb-redir-server" with -device, so a UDC=0A=
gadget can be exported to a USB host running in another QEMU:=0A=
=0A=
  -device usb-redir-server,id=3Dredirsrv,chardev=3D<chr>=0A=
  -device aspeed.udc-gadget,bus=3Dredirsrv.0,udc=3D/machine/soc/udc=0A=
=0A=
usb-redir-server sits on the main system bus so that the USB bus it=0A=
provides can be found by "bus=3D<id>.0". That makes it a sysbus device, and=
=0A=
a sysbus device can only be created with -device if the machine lists it.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c=0A=
index a7cfbd6c5e..4e1ecbabe7 100644=0A=
--- a/hw/arm/aspeed.c=0A=
+++ b/hw/arm/aspeed.c=0A=
@@ -409,6 +409,12 @@ static void aspeed_machine_class_init(ObjectClass *oc,=
 const void *data)=0A=
     mc->no_cdrom =3D 1;=0A=
     mc->no_parallel =3D 1;=0A=
     mc->default_ram_id =3D "ram";=0A=
+    /*=0A=
+     * Lets a UDC gadget be exported to another QEMU instance over usbredi=
r.=0A=
+     * The type name is spelled out rather than used through its macro so=
=0A=
+     * that this still builds when the usbredir library is absent.=0A=
+     */=0A=
+    machine_class_allow_dynamic_sysbus_dev(mc, "usb-redir-server");=0A=
     amc->macs_mask =3D ASPEED_MAC0_ON;=0A=
     amc->uart_default =3D ASPEED_DEV_UART5;=0A=
 =0A=
-- =0A=
2.53.0=0A=


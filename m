Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E995CCD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgP-0003z2-Uj; Tue, 02 Jun 2026 01:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgK-0003yA-Ct; Tue, 02 Jun 2026 01:28:52 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgH-0002gD-IF; Tue, 02 Jun 2026 01:28:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBDQ3fsbj/tTvcvfW1hEjJ5odNx+9nF/7kjPLae7klCqGxULBueGermHpYc5wd2hMisJNE/kGrLsj8BsGF8KoRywrq8qIlKCJ8p8hNbJp6B34iEneI4H15dLFhR2anYPsJntcpGxI/OoDIJTJMALOISjq749gwUHIcKQNcMJT9ExxxQ8bVK3J4VjG9gDM8gkEnl/YElp4Q6mL+IUgLd24mA1rNSjyOaMABTEIbZudL08gtZZ8psk4cctymBnBhFoNztJbZw5LXFsOJ1B/bgzoWcViehdgM90DZoAen0opXWjQHg76ZcIQz/KZKezQmUioBQxgkkmLYFMJAyO65fRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEVegwRiUCq+PRBAvXjoVyyq1Cndiszr9rLKaQIyY4E=;
 b=gHfLhSjhjYbLuy/4lplJ0IkiSPMnAb9iP7zPr8AfgP5Budf4QQGmQnnB4xDzScwL2E9nkQb51ABbCwelCDFLbAmuV0eRLsy6bGEZCJekf65OkMQOpfUNjdE7ircXLBrMDhMOAqkT12PJB4U0V1pMq/61Bf+k+PSvlFxoVYbw3GUS3hHhZaYyY3eJ8+0um768OTYyYVtx7h7FQ2aQS4ID+sjKFWPoFfsUkeRLw8LoMP4eVacibtWZaMPU2v7qO7Jl/S2MAQoOekwXSrls5O63YILDUGWCT3rYkEuN62yuyMy6PsFlvoilK2iPNGRCTl1iO4yNMabm54B9XqAuoqFtkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEVegwRiUCq+PRBAvXjoVyyq1Cndiszr9rLKaQIyY4E=;
 b=dot+o/8Mu1b9zyh1UKh8pavft7I8OctWNsOV3nkLcLoBd8cu/jLldGv/GfQQfl2fHtTUaZW0dgdzchtIrewaogumEpuFZKz8q9Cuw2qoBMQAmXfEzQC3QR1wIk9kZOtgKIJGH/AJ/IxpZ6pLiCj7tZd5Dj9Fs9g59cqVw3AqZ6k1MEdUlfqZzfE13FlVxbJWwHLXj95dfvYJv5PlGZQGpnwCPdpBhGtJgjKqPoZjrECM5HIQlDw03o1UeWcFPJiWNQtfHuHpfhP88pyZapCwQsyK+7+viESapvIworNz5Xs8eEAdVaOL3MNf/4JGgXXdQ9X0Zifclj3B94LGwRQKBQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 05:28:33 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 04/10] hw/arm/aspeed_ast1040: Introduce PECI support
Thread-Topic: [PATCH v2 04/10] hw/arm/aspeed_ast1040: Introduce PECI support
Thread-Index: AQHc8lCnRzA644Fqm0Gm6Q6CmCqEzw==
Date: Tue, 2 Jun 2026 05:28:33 +0000
Message-ID: <20260602052827.1535299-5-jamin_lin@aspeedtech.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5411:EE_
x-ms-office365-filtering-correlation-id: 559feafe-e225-4b73-965d-08dec067c9ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: 16co9jIu2Scwxfqw7xFMxUlvyT3Un0+j3yROCnUw3tSmnBd44ROHs1GV6xs45M5oEIxr24Jp9VECyEiZDqq4wM6MDWeKTTGOXmS1clTsbh9b3ovRq8N0+qDlb+yOluTtBVwoi5gCXJAiiOoYIYVLAlYvMj+/YzHmSXi/fi1Xe6UgAQCyF5Xt8kXJtTC1YxQfMcr9FqZcm6YVuG+UieAizkaR5fFR/khGBA2ofFfL62PqLmVGb0fCHmEFoq+dB+r6H49FxjrP8tq9HJzJ4xhCweNLuMz5uXpPCA0AfbKXO/j6X9NQSDWVggz7Qn1cJyg2x32pwqLzjM1HpyuGyjY23aBDrvX9hhDIC5XGfTIAsF/Soci0tf3cjGvYCAsCMSlhAONhf1yy4R5eMdytckDpLYikVbwzI/ctHUpG2wFZ41/PL0ryfTgq78nZcBbpbWzmAgukuhnI0BwRo3rnet2pe3/ebooh+4NRk8u8/khye8iUtH7I1aijJonw4ElIuWVcmqRfkTApJsfje9J+zDi6N117CGGBaFxwjHMqE1kuo4fFCTOQwzUC7tl23xdfqFvaeUbgPqiN30l7XXz0KnKe8rZwUKeTF5JfV8j9ZntezjvJ+xAFkLsAcDUAwXSGbdhK9gMn9m5B1bQCE1+pW63IW7befM+/VMpGG1VQtSKIUzZe3BUYf4H8Lvo40jnP9V8l2PXgXQYrCht0snpcVyR1c7Mx+QqXONKpxNASvzx5+9jdSFYlFI63o65ZvkkH2O+a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KQvQxYxt6jk3Wi27G0OdxHfWBskP6g4KgxQaob9hRrHY7/kck5YLn5Zr2E?=
 =?iso-8859-1?Q?eOj9TRAiX2KNj+fCaWmZ7TeY32UnjiRh7lX70bIC7zYF/2BM6df0zell1h?=
 =?iso-8859-1?Q?g8fAV3QsWnVcH0N2MciAZ5y71lt00HP71e6obua6Ocb3Nd79KVX7Xf5YhL?=
 =?iso-8859-1?Q?nW6QNgzOX5OLZXcpf+btaMaEV7CL1aJwWHjmT4HE4PgeDLA6zZqCj/mhQW?=
 =?iso-8859-1?Q?fXRzHsOeE6Qrv2py0opcaVahbc8iwGqCUUp3rCvqHENr1YtEGQwcE4ZBYU?=
 =?iso-8859-1?Q?o5A8YxkyOXSrMpAcCZDJUnpTf2sFLMuWINH6Ra82HB7ZxTZaLOvmhrCjJ8?=
 =?iso-8859-1?Q?0VCPqxKrF0wMHOI7AaxjvWvTS6eZXIyoCBJAu9tBojkIJP/rgkTQAIOzos?=
 =?iso-8859-1?Q?wLgO6Jc9glGsr6PP+XO+fDP3QeGykukuPptiNKIXaJMhziYDeQhMGIVROD?=
 =?iso-8859-1?Q?Go+lsPqiNseRWUiDzV/2Ej1HpAQNF21GAEyiD546d7NaNW7XyjkgwoXP31?=
 =?iso-8859-1?Q?v61vsKeqIECHA1Im/dQfQgsD19EhU2AigYl73xFFJu34jqFSV8HAGXxjIf?=
 =?iso-8859-1?Q?vJEaRQsxcwoBPSn9bMY6CynEbRUKAVf9FEeSRNWo1+/FdUHXab1XtoTFLz?=
 =?iso-8859-1?Q?BSXiqm/UWS5m/+LP+riN8qlgNaYWoN8D/7eJgwQeI6hqAc9TmqBd1ONcRw?=
 =?iso-8859-1?Q?mn2R51dEMlGAO6ITJwR9JAqnRvru4aE0Yf5yJjk+sY1ylIACjAxbKy7lnb?=
 =?iso-8859-1?Q?E+mJ7zFPrIfOEJNyRRx7n74gwlSMmns5PTejQjhpawljSsMyz0znJm7UYk?=
 =?iso-8859-1?Q?9DBC7XK4a4HGHbXg7+Ng5Da5A2nFcScizTwQZ/9IZ9iaq8uOVewxt6qofj?=
 =?iso-8859-1?Q?Gks2x9Zi9XDrQdA988VeLqyS/sqV/D+1aigDZ0YgpV/uxP5aNJajQlDYcI?=
 =?iso-8859-1?Q?DDX6tP5nYYCjNQJY8BijDLxhMquXJ7aDSjluwr4a3oxsKDvs6X6EOMpXqQ?=
 =?iso-8859-1?Q?S7VSkUVJ3mHQNGtmBy+Wu+3AJGCG9eu/412rq6MZz6aQjGVWNPUDfBtrgB?=
 =?iso-8859-1?Q?X91Y/zwz1AOQD/wTTQRvxZAjXScIbfJbRNJJHmHz6ZUwws/Yebxd+kctN4?=
 =?iso-8859-1?Q?m5Jg71spLofVU1Vsr+o9zEwGzKeLqTAWYvlQUACTk0oDOZjGbJC6ecHsx3?=
 =?iso-8859-1?Q?IDNxJp5awOkax2IYQ6Z3CP9TwbDXiMgPSBZvGdoRRMdnFbh1xzDsFEeChk?=
 =?iso-8859-1?Q?sQ3iKcw8QwbRqhZo4Ysb7egm5OKBYLf4cPj2WEdv8BJsTkVQ2K0wz5pmnM?=
 =?iso-8859-1?Q?Dg4HZiBODwFEIES7x2C5E1HLWePcp2zN83tNFsaq3Ae0x6oJxK8ZhsVLRw?=
 =?iso-8859-1?Q?umj+vg1+ZMxmx3/iXmRY4qQSgaxD0A3U3unKCGUXqDlcEGgMHZYtrmG/pf?=
 =?iso-8859-1?Q?cR9rvg/j0c6wJvQ9Vv7UL3v/BVKiWzgAUmrytnc0AGMtsJ1kOIBvwQv83e?=
 =?iso-8859-1?Q?5NEDOImeEJcYa9EhnQNIrIH9+uOd3BMSGliWd8EgzBkilrR7luBt/jD+en?=
 =?iso-8859-1?Q?iWFykkAaxmB1rOYcLd19YFrJiIpdb0CVWwzsNwyIGXhzZYlNK3/Be6nr4I?=
 =?iso-8859-1?Q?mG6NruDjw1dSd87o9ufUI20RkdcUJTBd57FDn7G5v19N3nwqiYAk2+s2RD?=
 =?iso-8859-1?Q?8rMdHgmEkNpgKXbOsRIabR9bsG/+JrA2jUWaGkq/kt6MmrTBUOIFBiAod+?=
 =?iso-8859-1?Q?0RUEZBdvG0jx/2YAzMDBjSPlH+0vl7b1gtRrDLHWB5L1ynlXE/57hL/0LO?=
 =?iso-8859-1?Q?8VArvvf27A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kuzrh5Qxtd6u6b+LZPQOK9/Rj9UXhRa7wIC3x70eCn3+eNrPkvSSk0PtEgyMa9zuLYf1zvZfShCgA4CqsIO5/aehOCjpzajNyn5PDdBoXhlx0I6vClTLX1z87jwzdaRXX8qu7e5IGkSw2/FxBCg3NkQIJ2GJ0V2OWmQnymzBFDUCIKu+pmeneJfcupmLc44i0ywb34a2YtI9jeMzC/XB+1v2xjqCmuUhX9BDD2HKijKV82GfBxUUSfAIbm4U8M/agtwjqc9kHdzqM9dx0RUWgs4T/D9ihOSkFIPOC/RNJfCzWD2RiEgD3ZL7v+9OXtzVxNrlWRF8N1FeNDv20zaUCw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559feafe-e225-4b73-965d-08dec067c9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:33.4679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAgr3VfP+QB6gxzbfaZ7Ru8C93dluWsrtcgmjJcm/JfGCYGOFu0jtufCEc26KpdkxUJDi6z4JTnQK4sqbEJL/Yq7980sugMUo6IaZ+Nypu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce PECI support for the AST1040 SoC model.=0A=
=0A=
This change adds the PECI MMIO region and IRQ mapping,=0A=
initializes the PECI device instance, and realizes the=0A=
controller during SoC initialization.=0A=
=0A=
The PECI controller is mapped at 0x74C1F000 and connected=0A=
to IRQ 164.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/arm/aspeed_ast1040.c | 12 ++++++++++++=0A=
 1 file changed, 12 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast1040.c b/hw/arm/aspeed_ast1040.c=0A=
index b736e690e5..9ae0a0e7a4 100644=0A=
--- a/hw/arm/aspeed_ast1040.c=0A=
+++ b/hw/arm/aspeed_ast1040.c=0A=
@@ -31,6 +31,7 @@ static const hwaddr aspeed_soc_ast1040_memmap[] =3D {=0A=
     [ASPEED_DEV_SGPIOM0]   =3D 0x74C0C000,=0A=
     [ASPEED_DEV_SGPIOM1]   =3D 0x74C0D000,=0A=
     [ASPEED_DEV_I2C]       =3D 0x74C0F000,=0A=
+    [ASPEED_DEV_PECI]      =3D 0x74C1F000,=0A=
     [ASPEED_DEV_I3C]       =3D 0x74C20000,=0A=
     [ASPEED_DEV_UART0]     =3D 0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D 0x74C33100,=0A=
@@ -76,6 +77,7 @@ static const int aspeed_soc_ast1040_irqmap[] =3D {=0A=
     [ASPEED_DEV_UART11]    =3D 146,=0A=
     [ASPEED_DEV_UART12]    =3D 147,=0A=
     [ASPEED_DEV_JTAG0]     =3D 162,=0A=
+    [ASPEED_DEV_PECI]      =3D 164,=0A=
 };=0A=
 =0A=
 static qemu_irq aspeed_soc_ast1040_get_irq(AspeedSoCState *s, int dev)=0A=
@@ -108,6 +110,7 @@ static void aspeed_soc_ast1040_init(Object *obj)=0A=
     }=0A=
 =0A=
     object_initialize_child(obj, "adc", &s->adc, TYPE_ASPEED_2700_ADC);=0A=
+    object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);=0A=
 =0A=
     object_initialize_child(obj, "pwm", &s->pwm, TYPE_UNIMPLEMENTED_DEVICE=
);=0A=
     object_initialize_child(obj, "espi", &s->espi, TYPE_UNIMPLEMENTED_DEVI=
CE);=0A=
@@ -199,6 +202,15 @@ static void aspeed_soc_ast1040_realize(DeviceState *de=
v_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,=0A=
                        aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_ADC));=0A=
 =0A=
+    /* PECI */=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peci), errp)) {=0A=
+        return;=0A=
+    }=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->peci), 0,=0A=
+                    sc->memmap[ASPEED_DEV_PECI]);=0A=
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,=0A=
+                       aspeed_soc_ast1040_get_irq(s, ASPEED_DEV_PECI));=0A=
+=0A=
     /* Unimplemented peripherals */=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->pwm),=0A=
                                   "aspeed.pwm",=0A=
-- =0A=
2.43.0=0A=


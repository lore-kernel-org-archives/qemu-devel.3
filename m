Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2432EFAD40E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSK-0007UX-VR; Thu, 23 Apr 2026 01:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSJ-0007TE-9k; Thu, 23 Apr 2026 01:18:27 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSH-0003Bi-SO; Thu, 23 Apr 2026 01:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQVddwIG7wg2F/FF254n3ay8fCBJkKDTlBQATmNvSYeav9voKYPDf/H8gnD+UgQORWV6CS2dxnUluI0jUZi3KlEFhZ928i/8kMRpktMRCO9sQhfSjFWo/op86m1wzI5sV3j4P4ncrJiYFBkIKX138a5Q68M4B9XgVaupLmt4J2OtDdqvvEllli3SprwDSk1/PDNkN662mHQjXsy4ILThFjsjqoQsxYobDYKz1EypCYJ8XZlRgngAQSxtJ2F1PO7HPfQthnkI0rt/nyNr9JePM7TDTRatfkAfAwUCjZndTqciPB+/4SbRjcJVwXItKDkdLFV+yy5sdtDWQsfGIcUvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSSfOUtpTaUIDGIST6WnKPs9DfsxmQ5yxdMVXnjA+Rg=;
 b=uKS8N9vRSS+GacE34yRKllVprmiqzMrN8oWumn+p4Va5NoaTAymPn0/bUJDSV3NhljeNohFiyjSr6xTHNyG0oQB9M90iJ3HHHXaRpYSit5fhw4osVh3C3VixOInVqIP/ua0TESEU42dZs67VYgvZeD7v+Mwwjd6IU6ErHEIE1tM6lYyfE4GvqafZ/heD6a6hHYKjnYPEEMtxCBIRnsw64Kvsimn7k78Ww0HMnaAdM2qNiy+Fkw+BvZW3/r/iVph4l9bU98MHHlK6ZDFNiv4mmSyAoF6X7dfVWmGE6fxtxOgoHVFcP5n4ktWi4PANjb+W/qg13iHBfRExCI5dabt9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSSfOUtpTaUIDGIST6WnKPs9DfsxmQ5yxdMVXnjA+Rg=;
 b=cuYbkS17+M4XV6LjYBvZoHr0W3Q0O74Tfj51ZSjddLBV4fbzGHOpfJHRMRJfVzimpM0JI06iuaJKnGPRe2P+dGPr2Cubn+U+auFspNQz8xRckRLilLISZtFVmXBULNoYAJwDe2z+gbPpqHaJeOEfj/KsRJsCwtsILZXLFr4dE8xZ0mscHq5U12RFe58nANL0bIENuoaJ8DzEDPXXstY7QFD3kPNWSSZwZm1/hc+7omSebb0r/CDs5/VL7TAytzhlfYvb2zk9vwD32bWTX0zY2xQBzV2L/XOa9wCKrvH+FLj/UTTWjNZryln8UkrYnjvS7xDvsGDv6hEvnPsLVv6gPg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:14 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: [PATCH v4 07/17] hw/usb/hcd-ehci: Introduce common properties macro
 for sysbus and pci
Thread-Topic: [PATCH v4 07/17] hw/usb/hcd-ehci: Introduce common properties
 macro for sysbus and pci
Thread-Index: AQHc0uCVUV5fmueCzE6QXZ4hijt6gw==
Date: Thu, 23 Apr 2026 05:18:14 +0000
Message-ID: <20260423051804.362095-8-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8534:EE_
x-ms-office365-filtering-correlation-id: 1aaf5565-28e7-44c9-882f-08dea0f7b859
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: SiRZJJ9z0xVet6S0CA95IziVB67nAjE9xUctKbGdrvwYxDRL95JVtlLK6hZFNuWsuE0joYabj7HRY7pk+jdoR8ab9nlJ/r5ivGSrie+W4NLj1MdSpShcqSferGTVBntSCUmsDTng3ILnaLD0nXDpVhZck0GaK1mbdl3utjkvjHOE7hevHxl5mWZGIHShlnVFc8E0bnzCtI5hRc87gBmwigcyRy9CA+KTnasJbdSBHYUA0z2VDgNeO4iYeIDVzI+/1xxdnUbiWkP+byrjFGDzosFofGHDa8ITCCR9eCYXxzpkRHvldMe8iKTg9XSuZMc9SRm0tE/C3N2t1lxokEBtcx6ZygduZvMvdwTZoVoO3ObSas5Q/8Prs+MB7iaX/LKcNxJUF9Geci7zYKgPpS/4HZr4i7xGFa9NCL7J96TXrzbAvSpYSrSSictFNggpTouaZ0wReTz2KvmrYSA9toPmpzRkEZaEan0FEiSpz0OU2F2rWzJgFQIagyBU/G14uc4jIoh+MpOLn8U+8g4AbbvcPvclZQ27m/skTLl07f11kF+gNhi7MIihyU70ea7G/uEQ42l8qUYE3VUdnTCAI8UdWuEhkWJut6Q81NVkhOfst4yXR/x4u9z2Jhq41Fp5QZIGxaRBIbsWsU0ptl3SFfs1DpOVA1fwYHfIsE+i7ns7lBK+1nZLjWtsTjV/7Ee1lGK/lY01T4wigw27I0PzhLqr9lT99NU0soYfiNECfjtkKYZtrBZU50/vbSVpkyLMvjIumzqJb+LBi2GlF6EfcxrX/96QwAsp+pZzLYiD6ChP2zsH8Lvksg6oeRXr1cUgkj8I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EPGe4o3IjXecinmlmxgyu1l3zqp6Al1Fj4Qa6uK80I6v03/xK856CA/Cw4?=
 =?iso-8859-1?Q?/j1d1K81AyEBqB425PMF9Me1tyyLhcJVoNybXyW4yJE2mnwZ1UXStRfPUP?=
 =?iso-8859-1?Q?NivOPUg3A1/Xq6HajxiFj+6CgrFQRSIx8k/LtnG3oDOrRNzLXoYlr0pWWB?=
 =?iso-8859-1?Q?TUZezflhwGlXEZCvBzQpn09inZhhMi+9l1/XBIHCQXt9xCUxHizJ6L8fO8?=
 =?iso-8859-1?Q?UpR+TdgtqkKBgskLbc4vn9yAwsyO3ThrVECr14Pq5NlHtaluHvfs9xsh0+?=
 =?iso-8859-1?Q?vZrzHugZ/KCn+X84h6yti1B1l98q84tGVNJR1Vl+tCvRcHmBBrbxRCxpqQ?=
 =?iso-8859-1?Q?TA3xGG9Sxp/gaq6ytMU+6JlieoTGXZyT6X/Ig5UQENfjtGttI+491Vysqx?=
 =?iso-8859-1?Q?WSvmowTY1AsMW9j/0jjVrOAnxbcqvy0LljxnvQS3rwp5SvU4PXnOQ0TAlx?=
 =?iso-8859-1?Q?zOHbmX1nuZIW/wOy8lfpJOX1QZTcxPzWY1RlVPldOvF3khI3LAGXD+/Rh3?=
 =?iso-8859-1?Q?TvR7N1ZcfVUh7dSQ++nKaSac4yLLvGZBu1DCMwxH5OdOUerHvaqk67Aetg?=
 =?iso-8859-1?Q?izMsdr6j7h5hoAFGajQ7p53h+fAFrnOjZD4zDl1S/Z/VsijqcKMIbhAtxY?=
 =?iso-8859-1?Q?aY0w0d3DSIGKZEYTXmxqYscUA/k2uvL44rngEjOmcjoSq/W8cT24qbH/HM?=
 =?iso-8859-1?Q?jKwk2AvmgeRrp8XzMC7faxEOpn6SvUPp92M+VZxbUOSttSUt1uj1mb89pg?=
 =?iso-8859-1?Q?BOkZu/kfOzutmH8GR7pYvVXIC4uuLJsKMPOwmWJPypF1uVh1L8BZi6Fje2?=
 =?iso-8859-1?Q?KMZRaR2f491qCu0yI+gMHdoYI6P3Lf9lLniV4gnb0N2ATiU/lwVMqiIeGY?=
 =?iso-8859-1?Q?YqQR9GIrKnlv350H2gmbpnnVemjDfrEd3uIcc63VM9zGkYxorKg0HwC2K1?=
 =?iso-8859-1?Q?lU1RupO9lE6Cr9UJ/Pk1GGSj7e7BcxuBIs9hjvFoo2vn3jtWn0cCKfm0Vl?=
 =?iso-8859-1?Q?urr8lFJFQcxJGo1InyZegxbmwsWNfAjopLALdyJ1iQee7v4tTbA3wxLFjm?=
 =?iso-8859-1?Q?3A5wp3crE2LQ+VkefbppDmU8tY5n1CqEQuFR1O9jv0CT8rThjZzWcwYLHL?=
 =?iso-8859-1?Q?gjimArQ9Loj4fxmJLtbAZ8V04qmnLdErlJyWngRW8wway8RjIa/dh5tlLO?=
 =?iso-8859-1?Q?czHlJ6zSzwaVkOfdWKbbaK3Jkvp+HIHPlcuRnkMwpgjNN3vVGXeafojwgz?=
 =?iso-8859-1?Q?cpY3o2ghVtrLPpUu4cln+s7OAWzedMigmPV1zNHMt4U/ZWB3HK8l1o6ddz?=
 =?iso-8859-1?Q?DQnScpDwEZUsNOqR4TNgjwLD+n7RVEFLJ/3R6Nq/pRalpiPy35bMTR4SD9?=
 =?iso-8859-1?Q?ASQbxhPxgeBhTzgTIYFbOGlQF/Tbh8ZzIoK1m8fqDySufgfWvzEjEbY1Il?=
 =?iso-8859-1?Q?CkT3EP2clCGSKJgMf5+ql/RolTneysRFF4aq6bu/VGTnUbNvueYV2pTPvS?=
 =?iso-8859-1?Q?iRaZec95NK7wl4J7CHkiGjZGAswiYxSF7ppPIj4v0G+9nbNGCOiOIi6zF+?=
 =?iso-8859-1?Q?McZoHxcYdwLTOfgIlK934G+aCsSw43YE5aBlgPxLwmBH0dOlPeaQVYT27A?=
 =?iso-8859-1?Q?1i5fyR97TXL8pxH68hGfeJ8gGBxYqySg/dUCBDMLLwKAP6om3hPILRz7LE?=
 =?iso-8859-1?Q?7JrxL6hDoS6CN4bJ/hcBfyinIujcyNN3ukwZbKSdKx16MTAiQE3x4NcThJ?=
 =?iso-8859-1?Q?ESKFQvH/zlxtEi4PJd8gxEst5NKLZziFKsgmpp0BMf4W5QbGK1RFu1v8Fy?=
 =?iso-8859-1?Q?02W+C6q/FA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: reWzU9MKWXQoArFxJPeYlEivQo1WCnc3f0H0qNEO4otWYVfGUHsP+GSmjFM7pnWhcBbF/bA82kcHjtkEIiNj8WUQnWnN+8JApMz0tJUkObgYuVUraJc0veht3U5SoPhVAifeCTBepYcYk41bx2wYzEieDuQjU66XJhOjsSCpg/b6U3WjO6VDzk7b5Cnqo9uUTgM81/lZrN4Y3OvtjhKHr8gCIHwYTvvBkVZO8aEqLpZoBmC/3jcIW5HkaDnRDvSco+dGV/YvvNXMWuyOM2X96N0UiH00Zuz2vXmSCaVFWCUFJx3SvkMo5EaOHonvOPeW98yXgS7SiGMqRAjf1Yn8QA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaf5565-28e7-44c9-882f-08dea0f7b859
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:14.3357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CaRsWPmsFlF1OHl2SWmp/H2/bclqJpxv+o5IQ8TGaqpmKB4HhGVYszTOx3CjmcwH6HWz7BDg5+G4hbtyCCXv7sALybetETriOB7tEV2tbhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8534
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

EHCI properties are currently defined separately in both sysbus and=0A=
PCI implementations, leading to duplicated code for common fields=0A=
such as "maxframes".=0A=
=0A=
Introduce DEFINE_EHCI_COMMON_PROPERTIES() to consolidate shared=0A=
property definitions and reuse them across both EHCISysBusState=0A=
and EHCIPCIState.=0A=
=0A=
This reduces code duplication and keeps property definitions=0A=
consistent between different EHCI device variants.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h        | 3 +++=0A=
 hw/usb/hcd-ehci-pci.c    | 2 +-=0A=
 hw/usb/hcd-ehci-sysbus.c | 2 +-=0A=
 3 files changed, 5 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 4234591cb4..d038ee1e31 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -307,6 +307,9 @@ struct EHCIState {=0A=
     VMChangeStateEntry *vmstate;=0A=
 };=0A=
 =0A=
+#define DEFINE_EHCI_COMMON_PROPERTIES(_state) \=0A=
+    DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128)=0A=
+=0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
 void usb_ehci_init(EHCIState *s, DeviceState *dev);=0A=
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c=0A=
index 9febcc1031..fd35d25340 100644=0A=
--- a/hw/usb/hcd-ehci-pci.c=0A=
+++ b/hw/usb/hcd-ehci-pci.c=0A=
@@ -136,7 +136,7 @@ static void usb_ehci_pci_write_config(PCIDevice *dev, u=
int32_t addr,=0A=
 }=0A=
 =0A=
 static const Property ehci_pci_properties[] =3D {=0A=
-    DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),=0A=
+    DEFINE_EHCI_COMMON_PROPERTIES(EHCIPCIState),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ehci_pci =3D {=0A=
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c=0A=
index b31032bbf3..7f7c7f8a2f 100644=0A=
--- a/hw/usb/hcd-ehci-sysbus.c=0A=
+++ b/hw/usb/hcd-ehci-sysbus.c=0A=
@@ -31,7 +31,7 @@ static const VMStateDescription vmstate_ehci_sysbus =3D {=
=0A=
 };=0A=
 =0A=
 static const Property ehci_sysbus_properties[] =3D {=0A=
-    DEFINE_PROP_UINT32("maxframes", EHCISysBusState, ehci.maxframes, 128),=
=0A=
+    DEFINE_EHCI_COMMON_PROPERTIES(EHCISysBusState),=0A=
     DEFINE_PROP_BOOL("companion-enable", EHCISysBusState, ehci.companion_e=
nable,=0A=
                      false),=0A=
 };=0A=
-- =0A=
2.43.0=0A=


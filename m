Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8A0F433D4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsI-0008Eb-OZ; Wed, 15 Apr 2026 21:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrn-0007sJ-H8; Wed, 15 Apr 2026 21:50:09 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrl-0007PV-PF; Wed, 15 Apr 2026 21:50:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvBsjPAkI71SJxic3HaEimwecH5IZ/4TdzdmzF7ckwLUDG8YpDpqgw6zG3jtw3T3qgyDIxk7/nL98g+C+rCNuF0fUore3NHrE3Z+Guz7Ny7HzA7kvD20YV4HAILJL6CNtY2NHPmhNlMhSGhc7Q+oVKS7pzQqWSfdcZXm+7zTMzjnpM1KwfOgovkDSw0Ly2nlFegXhrHAT6l4gs/NJKXvQCedVsr7a+KD71iQyXQAmKC2bc5vbo8SJSkgjUoLe2AhYmA8SmQVjhSii2+L5uIt2K97391VqYri4oND4p4gMI+3c/aj3jukqMq+S6mvc6DlUAgLv3mOQZNUugluHmuOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EclfufI1YRpxqMtzookxkixvWHefxyzUgqjTJNfTzbk=;
 b=LAFjNEiZHzyYxzXAZ9a13iTbVsGOe0WqFItoK6QpNIaLhY7nlx5kF91Ls4RRevrd8hbHTBFFvFRxS5VuSSCcNoFDIM+dyOt1XriyoEysVDmNNA63qm5Ckl12Idrgzhaa8s8SgjkojQlN2dTPaWB9xAJDDfVFc68FdAo/Noe9mOjoiQjZ2a27icDqqpkoDEHzhI8Bg3/boeuWm87NHQbfDNmRY5FXrOOuIsMD0igb4eY7JdcX0/iVMMTbbTB5ApzDMscU4XUmgeXHG+SJF0pAN16iTCOOclKCIKxiyhAExcXtnlFh6WelEVpGpXnXXOjyzF4P1FwJshyVVQM1ZzoEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EclfufI1YRpxqMtzookxkixvWHefxyzUgqjTJNfTzbk=;
 b=LsDV6FPetspGpBqJAWpXmmO5LkUGoHyILGtPs3FMZ4fsxgVHNZQGYlfWk9wkOKtQzmiiLgftv2PaXvK3K94l0jze4XB864Qjk1viqmScp+hpy/ismUllfzfF1du7AvBu7s5XLULsp/e/yiFAVlG5d7/CZfxZgiOGjX/6tL3MfNWCPg9B43pH7xhPaQXnIo3ILqEtj8OvYCudm2jxXvkhJEMZdcl9MLtcNxI20+XA/nPC72I6BLCY+pvoITywck8kBRou3tYJhE5nnRFcfsD96K/v2ZeU2KUqfxZd5+bv9wujpqpZZ1N64G+4aawMbaiHBWlsAgFvg9eVJM6Bu51AKQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:43 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 07/17] hw/usb/hcd-ehci: Add property to advertise 64-bit
 addressing capability
Thread-Topic: [PATCH v3 07/17] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
Thread-Index: AQHczUNMHTuypzYDy0GPztSDEQCVRg==
Date: Thu, 16 Apr 2026 01:49:43 +0000
Message-ID: <20260416014928.1279360-8-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: 2b789a81-352e-4252-9cda-08de9b5a6e8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: zgeV7tV4mQ3pdddSTQk2dkgfnpfTIkDlz8VduLqzfrcVVprXBAFxCzNauRTJyoD5NstNCYPcqtv7lLq72q9flmLboYtIK8/sNLVoPQ7dg5WbX/zC/sfI2zRrkXUl7aIM/BmChB9Iax+j0RW64idUMWygxfQiFcBl5kmAtCPIOmEj1dTsz+yYqaZBTqe0ZIczjaGsqlib37imbmCTflkzzBjmvQ9idkmj+8kHJwLorAanuajsEY4SheqSdpijOIDRUy8FUQz53uVOUQcS71VfMmVvhC1jUFLk6lCU0eLWy7CZ79wrmuqH6tY6wktzopI4DHzwUOxnxCwFftX4+bRpR2qgQHKbdHUzTFHluWzDeJFpK4yMQc8ZVEz5I0iLdJyj7aMsoSxxyec9gYn8PMMLKfBy56g2fCqZKgUvr0mv2wf0xPpXFxpbAMo0NjAi1DxN5cRT6Qb3/nLwgAGSWk1fSZfpuYfmZcd2DbDKXDXTmei9SaFEyZ0xows7x6K9Y0mJaHdb8IBfrAEErrd01gvm72xbNw14vXTCwpYBKdM/oKmlGIqY5hUUXciQF6G2sgHB8YzbQjLuHhu69pjOEadYgTUlEiHY/oZrPcO9HOW0Hr7gsMWIyyD7WVcFr2zK47t3xU0UGF0ovHQq0SeZCIFfFb6vQnRoLgG0aG40uGsfGfDr8+XiUmlnj9SBRozR+r6pIBj8/hp2J1QqHhdimoxvv9Y5gcnwGZ2gL2I5Zpc9V0BXRcnS+k7kaGBypKrDyQgqd5tzFaq7t4wSx4hTx+gR3Z7mUw55ixGWGzbX5CVyC/cL5ghKRIJ0r7FfsT45akTq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5UC442hqtQrfXGacUtxGxQlA0auUsN8kXdpsx3CNtXVl/wolY/J8tocihU?=
 =?iso-8859-1?Q?BZtQ7T8fKnqGj3TZy4nKkRnevLwBa2nXg8O96l5y2dgK3zQMRvuonsWB0U?=
 =?iso-8859-1?Q?TV4B6c1jLcE0eARSRt/cLduQvEzyX4+2DRdoqE+twrv19ViXx45HfdeR8M?=
 =?iso-8859-1?Q?eao7q0NATx0w0YOFeFZsWk0d9UxE0PRQ7ihxBbNmUCGBb6fsEPqoXgQxS9?=
 =?iso-8859-1?Q?5uUV3xcvfvsRDOT7hydv+kGqXkBKYssoSKc/LcsiMzXJwDAtNdPRvEdgHE?=
 =?iso-8859-1?Q?8cMqZfX31uQH8H3S0VQAGhD0bAdbmj5Oq30CWvM9329xfNpOjhleggCaVU?=
 =?iso-8859-1?Q?Kc4jAeCWsj9sZCUtUTZfbOUqjXBar5IbjOcYcOXYJpYSDEmlz2TRE2vDrK?=
 =?iso-8859-1?Q?DCSZb/bBi0+yChFo638BQLgtH0lTxAOuUXi7ZaQtBU2r8oLT1vdh7+sP+x?=
 =?iso-8859-1?Q?cjIkzGjRXIVW8NlWZGmag8cJmX2FeRGeG2IexcXa9fT7neoMvdd5ZiYR/4?=
 =?iso-8859-1?Q?OPUwTSC8laF63iAup3dIxO1poXD1FneLOOuK+DZ9tByUL/0c7cFfXuEVqB?=
 =?iso-8859-1?Q?JphgpJ8bCBhxpWoqd1foZudSwiKPXYzWwjNHhEZJdGWypyF4zberLxKCHE?=
 =?iso-8859-1?Q?BraocJJuuyUT8cQ6iP55KWU1Bipv61SuaP4nJyjssSVDnVP8m+nBXaNMUI?=
 =?iso-8859-1?Q?YaBaXkm7Fh9aW3bZGbXLzE2Bdrp8oSzrs4fLd0yUWnM/DHZWCW9z8MA8pW?=
 =?iso-8859-1?Q?F9QDffac/pTYz400gDjERzZeocisredqS4A0JvNHyh/iWJ7C12IQKhMmk8?=
 =?iso-8859-1?Q?/u0daGeqpYPKWn2KNna+S+zKtco/g6VLq0vaBt3b0FPYCT+pcnor+bQeqq?=
 =?iso-8859-1?Q?2TzsaIAxPmGLRFsFrS7U7+fTVa75TIP6r+9/1SXJSOVQu8ifBNRIf7Jota?=
 =?iso-8859-1?Q?dHDhNmvYGoUO+chONrdOh9vO9FFMr71S8v3iJIyJs9Bl+7BirGXC/cBmpw?=
 =?iso-8859-1?Q?5v2VL9r0K0eYMkZi1/XV6LgsyVSFn2+dn3u2tFlDhd2LARUz+lUfnhznfB?=
 =?iso-8859-1?Q?ugfjUbeeYqh6N0lbAsqlEe4jztCqrfjhXJ7v7QtTGMHUEiR4PcobaOJ0kh?=
 =?iso-8859-1?Q?bTG84dqXL2mcImQ7kMeR4AXHegHLxbC5lwLD+4rBIJ8I8X18eqCwZV9Iac?=
 =?iso-8859-1?Q?93OGkQQNzypwCYzNX+097DTTqdy6F38o/rx8OcHRnNJ2cFlLuGs1n3wWtw?=
 =?iso-8859-1?Q?ar6MCo2vJk4wZ9DQJX8tIdfaxUldhlzMfbqWU+N0PbV2uqUu4D5M2Bu3fF?=
 =?iso-8859-1?Q?5efRorX8yqdMKgiQnnDTcNMmGOriBbi3v7TnzOq5bgibuaiMUAKukVhiY2?=
 =?iso-8859-1?Q?9NyA7lCL5lX5novGWYjWm7jth2Kh6yMPIzNOYu3wsMmpXxfvmLirU0rHkf?=
 =?iso-8859-1?Q?odaRdMtB7PKT+hu2D8FnLSN8DzqHadK9XCj2vJGfQYTN8qmzE/sddNyUi0?=
 =?iso-8859-1?Q?zOjFR6EmSmAFULrF4Ckm4pa/TK0hFJSYcX1W2mTQutA0AlpyXy9WaGhq0I?=
 =?iso-8859-1?Q?gvFi8PBCTrYI75CQIRtOAsLNhynzYmFwT6um7wOM4Q5zNgS4rBSdFfBVOj?=
 =?iso-8859-1?Q?kV4QmH7KxekyVOKdylcOO+JbmLrt4A+LUw0yZzTlJy5e088WVjdILfq0nM?=
 =?iso-8859-1?Q?1u5yDrbaqanJwrGA7ghD+jpALvSL/zLmAdg9MAG4T6WMoNTy9mp+TJBBGf?=
 =?iso-8859-1?Q?aawUxgeqfTrPolwi3Hxg1JKYaQWyqVUR1Ja+y9HkhV2JzSCDgvfRj1GMrC?=
 =?iso-8859-1?Q?2c/Gt11/YQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O55oOn1L2Om8v9QsWFlUSKa1mIILLnCicd9t9Sp5F6pgLgu1HnYGAtZIiJPLNmeFWPBftmAI1XJOEJkKM+zimeK51IiQnRoWvagV9GFpJwp8Ab8flxQWh9c7vCLYCua0yChR0SorlWclNNXXNptGVF+FJtLclxsqJUsBZ9TxcBuKbch9Ya/nUty4RI9ZPlcLu3CZ8uZTHJLangCfUXl1abUxLkOQ39Kqcm5fkeYvQADegq0Bd/B64RJOlzP2zry08BIKwf53rD+NV/a77ct85WGxTL39C83g5TQs9VsVcRGFT+hlvIW9z+lK8lfYlDGE+FPDuf5yTaQI6sYF7M0wvQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b789a81-352e-4252-9cda-08de9b5a6e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:43.6741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: scxIXGo3y9MLJfLeustlBQuGzikkfHJHrw1Lla4jmliQX0GdgSsDgqZvcnWTwMSDEHmThZL68SzKjHRpZdqa5z6N99eWRcIQRWcOJ9zhVTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Introduce a new boolean property, "caps-64bit-addr", to control=0A=
HCCPARAMS[0] (64-bit Addressing Capability).=0A=
=0A=
When enabled, the EHCI controller advertises support for 64-bit=0A=
address memory pointers as defined in the EHCI specification=0A=
(Table 2-7, HCCPARAMS). This allows software to use the 64-bit=0A=
data structure formats described in Appendix B.=0A=
=0A=
When disabled (default), the controller reports 32-bit addressing=0A=
capability and uses the standard 32-bit data structures.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h        | 1 +=0A=
 hw/usb/hcd-ehci-pci.c    | 2 ++=0A=
 hw/usb/hcd-ehci-sysbus.c | 2 ++=0A=
 hw/usb/hcd-ehci.c        | 5 ++++-=0A=
 4 files changed, 9 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 24eea9d23b..fe4c508c32 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -256,6 +256,7 @@ struct EHCIState {=0A=
 =0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
+    bool caps_64bit_addr;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c=0A=
index 9febcc1031..2ea8549db9 100644=0A=
--- a/hw/usb/hcd-ehci-pci.c=0A=
+++ b/hw/usb/hcd-ehci-pci.c=0A=
@@ -137,6 +137,8 @@ static void usb_ehci_pci_write_config(PCIDevice *dev, u=
int32_t addr,=0A=
 =0A=
 static const Property ehci_pci_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),=0A=
+    DEFINE_PROP_BOOL("caps-64bit-addr", EHCIPCIState, ehci.caps_64bit_addr=
,=0A=
+                     false),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ehci_pci =3D {=0A=
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c=0A=
index b31032bbf3..61215e9f3d 100644=0A=
--- a/hw/usb/hcd-ehci-sysbus.c=0A=
+++ b/hw/usb/hcd-ehci-sysbus.c=0A=
@@ -34,6 +34,8 @@ static const Property ehci_sysbus_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("maxframes", EHCISysBusState, ehci.maxframes, 128),=
=0A=
     DEFINE_PROP_BOOL("companion-enable", EHCISysBusState, ehci.companion_e=
nable,=0A=
                      false),=0A=
+    DEFINE_PROP_BOOL("caps-64bit-addr", EHCISysBusState, ehci.caps_64bit_a=
ddr,=0A=
+                     false),=0A=
 };=0A=
 =0A=
 static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 35173d27b4..6409457186 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -2539,6 +2539,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev,=
 Error **errp)=0A=
                    s->maxframes);=0A=
         return;=0A=
     }=0A=
+    if (s->caps_64bit_addr) {=0A=
+        s->caps[0x08] |=3D BIT(0);=0A=
+    }=0A=
 =0A=
     memory_region_add_subregion(&s->mem, s->capsbase, &s->mem_caps);=0A=
     memory_region_add_subregion(&s->mem, s->opregbase, &s->mem_opreg);=0A=
@@ -2598,7 +2601,7 @@ void usb_ehci_init(EHCIState *s, DeviceState *dev)=0A=
     s->caps[0x05] =3D 0x00;        /* No companion ports at present */=0A=
     s->caps[0x06] =3D 0x00;=0A=
     s->caps[0x07] =3D 0x00;=0A=
-    s->caps[0x08] =3D 0x80;        /* We can cache whole frame, no 64-bit =
*/=0A=
+    s->caps[0x08] =3D 0x80;        /* We can cache whole frame */=0A=
     s->caps[0x0a] =3D 0x00;=0A=
     s->caps[0x0b] =3D 0x00;=0A=
 =0A=
-- =0A=
2.43.0=0A=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03C0C982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOP-0007aE-Re; Tue, 22 Sep 2026 05:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOK-0007Wx-UH; Tue, 22 Sep 2026 05:02:20 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOJ-0002C2-4E; Tue, 22 Sep 2026 05:02:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wP9YFLsZCPZUsvU5o3kbz/657oHPDQ+Gin95n2aRRrn2YA0yP+gXzYzRoR6tDIyMunXtnL/aWrhMsk6XPscU0D/GuvtbfBqxYaTXkcBvcf9Ab4F82WDBgORIidHhkV7n2NiY6ORNJoNBj1JkOeY8RLNsQIMW6YnuTxYz2Ff74e5j5tHlxBto8Zm2W83RU8YeNn/PT4w9A+pXwuxxeaF62J3uSudrBUwyvRLILsixsntXAXsW5A8grO3hapwzhxfpXdHim+VJmmHCDxKQVjF+IsQx8qkS9jRl+cHtNv4XK7O5RBOnqgxoyC9aGEeUOMF+4MOXVQJYrgqD1sg1gqC2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/DyTS5/JKw+xQV7CCDkIIv4AtiOvdTt4yVykDmLTss=;
 b=d58ojQQJxuHieSJMujeNG6XoXpgBrC4TrWAPIgkupIUc35wa/ssGeETWWh/q7SBh0VU0KANJLWMK70ct2Nq2EwPimux0/AOUHaYBIXQeSSjAmUs7aSknDIf3PdJMVXp1xU2EaraTLvbUgG92P0/RDXvokWrsUepXCQZi700N38RvoXCqK19BMjRzZgi8iM3UuSIxyibxDSKC7YS707wRJXx+5zLH+n+dYYc8qnltWiRswd9kF4Y9VhtmkJORmGxzK+Wxf0kkRVR13T5hlXFStiS8lzQDbVPYbPWCegO0onLt1AAeafEOk1aKUubT1nPt3s0KBYLbht/Q45f19uDcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/DyTS5/JKw+xQV7CCDkIIv4AtiOvdTt4yVykDmLTss=;
 b=beCTBIQOqE+mZu/hi/rsDA90uTKUgz9aCyhJJTi0crOGs91aReaT9+fPurGBFc6I2iR1AGbu8WUclUu4enZugbATdLrTmFNWcgU9VkRJkv3DqMuVszwqKumvRxIDpcqGOYOo1dGe1ZduAQOnaNSmb0e8ItlvBcIaU+F/x9Cad+kcRDKblHtUaH7VLjnoN2XTnqK6TGNgDxNnAb9l88uKlupo8002gc5iQYWFmZscmCbXXzTvzJYiTo/V9sh6gYVtrHS5Ivk+S6PsCLELCDg7QppQN7Fi9jCOctCODAAwtIYsn6wSxyG63sNznxV1aoNuc+iTZiVp0Dl7heWU/iAJGQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:08 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 09/19] hw/usb/aspeed-udc: Make the SETUP buffer byte
 addressable
Thread-Topic: [PATCH v1 09/19] hw/usb/aspeed-udc: Make the SETUP buffer byte
 addressable
Thread-Index: AQHdSnELXlxFHAG1XkS4jUtxHj0vUQ==
Date: Tue, 22 Sep 2026 09:02:06 +0000
Message-ID: <20260922090154.1792077-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: e082d361-81cc-4aa7-c11f-08df18882e36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: 7cz09LTWWcCICvoj7l6AyypfoYMOYbsn5GfIiXxGhmR/KR38xSsE7IYUsuUspz0oDjQ14NTB3Ta+dIQLlAWAP35wrztg7iZ0hJhNdMCh2FL+cxhJbPHACCeIRfx3a/vuPU24d8Sl7+XyTNsDBChvhXRjP0NJOsBo2qKPjxjcAtVofqqOsCzEUba8zrj2U25s6WDGx4PSE4jtjvBbZffgQTrr0RsBscmL7ZMeomKV3Uf4yY71N6dPw61iExs6a7UXt6ASd5Vp2e34m8QdLlFh5qO2e6H4ewZ6m8VglErAZqIE01ShC8Rr10Bh7jlj/XEto1+O6d0gXOyBNLiDKYPdgYLGQfIo6p5dk0jpK5Rw4U7mM+H610k19keWheAiyopcIHAmY0NN3wmnOVDhbo8rOX6ZIn/6JH998JC4AL//o26KSRulWdS04JBcmzqSWTirPJ+A+/LsKUQAMa3R8yOnPc0aG5/EVAQigtm0aYcdrFz+i+79mbORBGrvjw5VQ7tDHrcDwRn3mw+xd8KuatxEuq0CH3qoslbsN2XjpFGg7jBSf1ErtG+sQO7V7Bu+UUBTC9kKfdUY7yXEiBGFAtmCy/o0yQYqlAVvJ5/U8/HbP5sOALFa4UJb69X/NXJaFcl9+qoYfgz58S1g7Znuhkb9ei76aOqZmN+nY9pOptKN3zQtVgQWFQPN2q2cIrrZ+N1/ZvoREUOc9XAb1SQFWn6pdFn40zy8CAtM7V8Qvin6M7M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u7RMzw5Tpcsz3ONQBqcwVhdv+dgz6YEC7qke1UcBjV/oclU5Jjhedv+8jB?=
 =?iso-8859-1?Q?yIyr6yY5sL9UB6imWHa+a2C3hiUri2/pGlLjnY0hAzenVRTfkVTT+Np6vK?=
 =?iso-8859-1?Q?SlCtg1DMgdaFHKCFerP3735id9mlVnxbcb1rF2h8v8uWxsfDf1uLmX2NNH?=
 =?iso-8859-1?Q?B64GsAp1Tbb5xIRcMpifgVuLlgfJnLta2F/UON6FQ+vqFCsLCk0PlRH1oj?=
 =?iso-8859-1?Q?tOKrLoXBNLWV8YMyqpvBwG4TNr4JSmpzZyvna1ugLEDPPu4/hgir0UJC5O?=
 =?iso-8859-1?Q?tgmsdUcXBWr+mCoHXHxaCbEzQUx9fgAad2muckNLX1i+putlC84hCpYdNG?=
 =?iso-8859-1?Q?4BqCKmFr7CCBTMSydFg2gMW9CbCJEOHZYV8RUp21tOQcWj5e1kcxW1Ina9?=
 =?iso-8859-1?Q?3lpl3YWS+EEhfZHzrP1w8oIMwDpnm6JiSIK9AQYGyOCzj5t93GuBGwaXXS?=
 =?iso-8859-1?Q?Ql/0HFF42tiNQm8+s+YxQWjwDjItN/AJyiX8bqFZdqohtsMagGBtfV2h19?=
 =?iso-8859-1?Q?twFaoKVqFPqf+A2eg4cE7kJQ1famCOjd1cy3ulmSFVhIhMohttax4vGpa/?=
 =?iso-8859-1?Q?0G3X83ExGwE0K4DHSYHdmhj/HeGdQmLdoQcc/DumVKV3NLYeV15Kq2nl3R?=
 =?iso-8859-1?Q?sNnSSMwKl/zw2fyMBW0njJ2SHkMsIhBfbNI05BvVwU6Ezve8GIt62G6zPS?=
 =?iso-8859-1?Q?LiM1ZJitF7ZrVlqVGOa7tuFW++rQxNyI3FUmO+f7Gcja0Pucm2L5vsAecw?=
 =?iso-8859-1?Q?9WeJ6JinSxAd28/CiVLOXAkWZK7k5atdXFS3dFcwbFzT/A3RawEKi8Ha/Y?=
 =?iso-8859-1?Q?eQWPS9acVgzJvEp2AKv8SIuB9nkwuKvayOk1jAtdBoHB0WhBhZrWCUes+B?=
 =?iso-8859-1?Q?21MW2b9X3kKdawzyFhAfPm2PCVlPHe40PU3X25z4w4g8gluVRGdM0c11Kz?=
 =?iso-8859-1?Q?4anmjm1A2wMOpK2dTpZ78CUhy7HNDzdQj8IVUKFJXZC6e3kXc1JIoK5PiC?=
 =?iso-8859-1?Q?7Esfh14gKgzRT5KtKwaVvz0AFplEqyH6tgLgdLBF60PmxrRsp+ts2gVK5Q?=
 =?iso-8859-1?Q?R7ibNN/MrWRLWbQ7zUer76BDfmYosq+TfigvK3wUDNyqWtDrWp50QpPm02?=
 =?iso-8859-1?Q?pehnBgpvsMOTjvfZh9Rb67m5pu5TfoFr7X3zaDlBJF2SBV+uQF9QjEiMYt?=
 =?iso-8859-1?Q?T08b0QlcRVUY65ZFmumaVqr+pae0L2BZfMYjiV7ua/iApEIpCTz898bQXn?=
 =?iso-8859-1?Q?jrN3OLT/777kiigghmorZvOfIeiciwBtaA+qnhey2eyiKR+GmYrYhVyNH2?=
 =?iso-8859-1?Q?kW0Sy6vfOp5XuibCDWIrdASEofwFnUZhSpkO3aCd7CWsBASARP3EVDYf4m?=
 =?iso-8859-1?Q?TvfKbbNnYtTLB0JbOBiNCfY3N8vgGr6Tn6Uvy+KQL5aGHX6mtdKVuAUyFh?=
 =?iso-8859-1?Q?tnSutdLszoJa/t8GVKdK45a24k5pMVvs6xhGEKtmYyObjrhmNwvBA2xKu0?=
 =?iso-8859-1?Q?uSECANh8x8Z2uWdAO1+l9VmxAW7XmYHUI6JENlS96CxeK6iDEbEEKenj46?=
 =?iso-8859-1?Q?XnEOX+PClOGBIR8nyOWqrXAZQTvr/t1yu/00ASzLankL5xfeuXZCg8QXL8?=
 =?iso-8859-1?Q?sdoQ4tvnK2BB5TqDHGrDHoQABIBgCSrCpzTt3L01+kkbOdO8e7S5PG1Ezi?=
 =?iso-8859-1?Q?PRiKsHKwnEjilamf3j25tRqTplJp9mOnAmwotPbbamA/FLMt1EEehzkzDc?=
 =?iso-8859-1?Q?1wkFh9jl7VbWiJAvIRtpb3g+zjvcvd9e6UTXNJhae81np1Sy1lBYtu69/U?=
 =?iso-8859-1?Q?6Ff7I+CKaQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QBHCllOxu7tQ/Rmw9nYJU9SNs3iv6KM3oLFIb9G4iSACP5OI/YdbtdVjVogqDdAYIr1/uVNs/OadeaxP93PGYClYVQiKyKfmCTVuycg/4RHjl7eSkq7F8aPRcfmSFcLS8xrHJrCyB7fH0f9hW6cChcZOaOrJoyhG4nxuu78TzUift7hWVEYDTJLeexjyXwTUO6u3i4oTvXLM2zB2uKbVgsfB5CggchX8g/5qvgEKfTQqd0jniJcy+Rnl9LXExdJgYg7bFmGLYwhrboBwQnNrNaL7kYED+qtnk7oQaaum3OmmcpOoARQK9D3U01FpDBrlb5ZKrhA6/2Wl4NTKFgyjwQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e082d361-81cc-4aa7-c11f-08df18882e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:06.9396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xzznDonio7rFnSPVXcBnNBmZK4sXKTLn/xyEDDpWEQa8w+OJPFSjD+7aZ9V+2FL2WUV4Oc55Iub5crDamVPZCoObxjs5qWw3XpVZJsduM4=
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

The controller registers need a 4 byte access, but the 8 bytes at 0x80=0A=
are not registers. They are a SRAM buffer holding the EP0 SETUP packet.=0A=
A read or a write that is not 4 bytes returned the wrong data, so the=0A=
driver saw a broken SETUP packet.=0A=
=0A=
Introduce a separate SETUP MMIO region that handles 1, 2 and 4 byte=0A=
reads and writes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h | 11 ++++++--=0A=
 hw/usb/aspeed-udc.c         | 56 +++++++++++++++++++++++++++++++++----=0A=
 hw/usb/trace-events         |  2 ++=0A=
 3 files changed, 61 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index 7701c1aa34..42916c0bd6 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -24,11 +24,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)=
=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCGadget, ASPEED_UDC_GADGET)=0A=
 =0A=
 /*=0A=
- * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte ba=
nk=0A=
- * per programmable endpoint from 0x200.=0A=
+ * Register map: root/global block at 0x000 - 0x07f, the SETUP buffer at=
=0A=
+ * 0x080 - 0x087, then one 0x10 byte bank per programmable endpoint from=
=0A=
+ * 0x200.=0A=
  */=0A=
 #define ASPEED_UDC_MEM_SIZE     0x300=0A=
-#define ASPEED_UDC_ROOT_NR_REGS (0x88 >> 2)=0A=
+#define ASPEED_UDC_ROOT_NR_REGS (0x80 >> 2)=0A=
+#define ASPEED_UDC_SETUP_BASE   0x80=0A=
+#define ASPEED_UDC_SETUP_SIZE   0x08=0A=
 #define ASPEED_UDC_EP_REG_BASE  0x200=0A=
 #define ASPEED_UDC_EP_NR_REGS   (0x10 >> 2)=0A=
 =0A=
@@ -62,9 +65,11 @@ struct AspeedUDCState {=0A=
 =0A=
     MemoryRegion udc_container;=0A=
     MemoryRegion root_mr;=0A=
+    MemoryRegion setup_mr;=0A=
     MemoryRegion *dram_mr;=0A=
     AddressSpace dram_as;=0A=
     uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];=0A=
+    uint8_t setup_buf[ASPEED_UDC_SETUP_SIZE];=0A=
     AspeedUDCEP ep[ASPEED_UDC_NUM_EP];=0A=
     qemu_irq irq;=0A=
 =0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 4c90b4f4c2..355512822b 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -58,9 +58,6 @@ REG32(UDC_EP0_CTRL, 0x30)=0A=
     FIELD(UDC_EP0_CTRL, STALL,              0, 1)=0A=
 REG32(UDC_EP0_DATA_BUFF, 0x34)=0A=
     FIELD(UDC_EP0_DATA_BUFF, BASE_ADDR,     0, 31)=0A=
-/* EP0 SETUP packet buffer: SETUP0 =3D bytes 0...3, SETUP1 =3D bytes 4...7=
 */=0A=
-REG32(UDC_SETUP0, 0x80)=0A=
-REG32(UDC_SETUP1, 0x84)=0A=
 =0A=
 /* Per programmable-endpoint registers (offset from the EP register base) =
*/=0A=
 REG32(EP_CONFIG, 0x00)=0A=
@@ -363,6 +360,45 @@ static const MemoryRegionOps aspeed_udc_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
+static uint64_t aspeed_udc_setup_read(void *opaque, hwaddr offset,=0A=
+                                      unsigned size)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    uint64_t value =3D 0;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < size; i++) {=0A=
+        value |=3D (uint64_t)s->setup_buf[offset + i] << (8 * i);=0A=
+    }=0A=
+=0A=
+    trace_aspeed_udc_setup_read(offset, size, value);=0A=
+=0A=
+    return value;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_setup_write(void *opaque, hwaddr offset,=0A=
+                                   uint64_t value, unsigned size)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    int i;=0A=
+=0A=
+    trace_aspeed_udc_setup_write(offset, size, value);=0A=
+=0A=
+    for (i =3D 0; i < size; i++) {=0A=
+        s->setup_buf[offset + i] =3D value >> (8 * i);=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_udc_setup_ops =3D {=0A=
+    .read =3D aspeed_udc_setup_read,=0A=
+    .write =3D aspeed_udc_setup_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
 /*=0A=
  * Copy len bytes from guest memory at addr into the IN packet, going thro=
ugh=0A=
  * a bounce buffer one buf-full at a time. Returns false on DMA failure.=
=0A=
@@ -708,6 +744,7 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTyp=
e type)=0A=
     int i;=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
+    memset(s->setup_buf, 0, sizeof(s->setup_buf));=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
         s->ep[i].pkt =3D NULL;=0A=
@@ -754,6 +791,12 @@ static void aspeed_udc_realize(DeviceState *dev, Error=
 **errp)=0A=
                           ASPEED_UDC_ROOT_NR_REGS << 2);=0A=
     memory_region_add_subregion(&s->udc_container, 0, &s->root_mr);=0A=
 =0A=
+    memory_region_init_io(&s->setup_mr, OBJECT(s), &aspeed_udc_setup_ops,=
=0A=
+                          s, TYPE_ASPEED_UDC ".setup",=0A=
+                          ASPEED_UDC_SETUP_SIZE);=0A=
+    memory_region_add_subregion(&s->udc_container,=0A=
+                                ASPEED_UDC_SETUP_BASE, &s->setup_mr);=0A=
+=0A=
     /* Each programmable endpoint has its own register bank */=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_UDC ".ep%d",=
 i);=0A=
@@ -918,8 +961,11 @@ static void aspeed_udc_gadget_handle_control(USBDevice=
 *udev, USBPacket *p,=0A=
      * Reconstruct the 8-byte SETUP packet into the SETUP data buffer wher=
e=0A=
      * the guest gadget driver reads it from.=0A=
      */=0A=
-    s->regs[R_UDC_SETUP0] =3D type | (req << 8) | ((value & 0xffff) << 16)=
;=0A=
-    s->regs[R_UDC_SETUP1] =3D (index & 0xffff) | ((length & 0xffff) << 16)=
;=0A=
+    s->setup_buf[0] =3D type;=0A=
+    s->setup_buf[1] =3D req;=0A=
+    stw_le_p(&s->setup_buf[2], value);=0A=
+    stw_le_p(&s->setup_buf[4], index);=0A=
+    stw_le_p(&s->setup_buf[6], length);=0A=
 =0A=
     /* A new SETUP clears the EP0 STALL condition */=0A=
     s->regs[R_UDC_EP0_CTRL] &=3D ~R_UDC_EP0_CTRL_STALL_MASK;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 931996e8cd..e84561d2e8 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -381,6 +381,8 @@ canokey_unrealize(void)=0A=
 # aspeed-udc.c=0A=
 aspeed_udc_read(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " val=
ue 0x%x"=0A=
 aspeed_udc_write(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " va=
lue 0x%x"=0A=
+aspeed_udc_setup_read(uint64_t offset, unsigned size, uint64_t value) "off=
set 0x%" PRIx64 " size %u value 0x%" PRIx64=0A=
+aspeed_udc_setup_write(uint64_t offset, unsigned size, uint64_t value) "of=
fset 0x%" PRIx64 " size %u value 0x%" PRIx64=0A=
 aspeed_udc_ep_read(int ep, uint64_t offset, uint32_t value) "ep %d, offset=
 0x%" PRIx64 " value 0x%x"=0A=
 aspeed_udc_ep_write(int ep, uint64_t offset, uint32_t value) "ep %d, offse=
t 0x%" PRIx64 " value 0x%x"=0A=
 aspeed_udc_pullup(int on, int attached) "on %d, attached %d"=0A=
-- =0A=
2.53.0=0A=


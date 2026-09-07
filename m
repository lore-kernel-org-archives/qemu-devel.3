Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BE5C79F9F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3VWh-0002ep-70; Mon, 07 Sep 2026 05:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWe-0002dq-5m; Mon, 07 Sep 2026 05:20:28 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWb-0001gO-V5; Mon, 07 Sep 2026 05:20:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp1Bv+ls9W8OjD5jcMzxvVcQDEOQ/SOyiMLd5DiMm5tB3JD2/SWA8xT8tGNEXoOgFhskgjIZAL0oG2SpMDt9JVDpG1nnM/EsYXAKxi38jwFPSvvX4x30/N3V3tcSwQb18rdqBqzI4BBV5/GCIzr+ZZQ4/bdkdmvijEcXkdfarvL12UUw1fzhXPHIICRbGYlreRI23MkfaaBrsCllrYCGTGednPrOchSTDQniVty2FNJuapryDl7mPFREtwKUrjmswlDHXf+D5wK2req2fy7e9mn8HJBb7eSpnnoNlqHIGpKW8gfLxaOPvVajBMaIXm/6nneYihXcmfaITNiC0VKORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3liQ3hHHBdA+EIZPiml/oGvhNx2U1CCWuMWl7gzSGU4=;
 b=nLm9ms0FP/kEOZbdMOZJzTAT4H8AuFzcjR/oozWa9TejoHomwjQ4JhgjRouoH6+tsg1tAQvs1gPPdjPGwl36sbf/v1M0BZ5izbDbvOK6AMSM7bsfmbVyK/PBdTqmxKAk/lQH22Ieq9OQZZwSyRK1vJuZG+/7H1q5ZxLgn78xari5PWx3pzmQwIPhawUGAzvqy9R719yLyhj1PkXKm5p7tk000gAMAYZIcCiUR9MvQmau4+OaSD6w6NU51gtXTqDV106tTOkVsjl+XNpD2nSb8go1Q7hEi1XoVe8+0aTqIATmyOjeM9975fbyj+6GyykV625nopK9d8r9rbgmONW6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3liQ3hHHBdA+EIZPiml/oGvhNx2U1CCWuMWl7gzSGU4=;
 b=Th/LIWV3j2eIs/jlDxGhZ1wqoHgYBdKwhrkZnW6cO677c+VkBd+IX2phbwWJYahEIhN95iG83k8vmuZp0nqzbaR2hIpZZMWl5QKlakrbluo2LOKuF4vmeZp2S8oMGz7RXdLiOkU8El/9wEDw5GG8oL2/bgqtU76rQ7doVwwdhtMiKTd9QhvvV7+imTiVF5ntSM/afgKfLr8WK4gx7AjsWmgqvJZaKwgvCL/3w5O4fcXbpkJmKPFb2VyGJYUgFkZW3P4oCC+zIE0kMcPX1jWZ1aTKPW9wLJEbTXBOUlxB8LnG457fBk5wfeNL5RzO26RUHi7byxMYz/m1bgLQSXQqkw==
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12)
 by SEYPR06MB5301.apcprd06.prod.outlook.com (2603:1096:101:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:20:12 +0000
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c]) by SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c%6]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 09:20:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 6/7] hw/display/aspeed-vga: Add the 2D graphics engine
Thread-Topic: [PATCH v1 6/7] hw/display/aspeed-vga: Add the 2D graphics engine
Thread-Index: AQHdPqoVWZoyi+A33U6J2kqoASfUaQ==
Date: Mon, 7 Sep 2026 09:20:12 +0000
Message-ID: <20260907092004.2590015-7-jamin_lin@aspeedtech.com>
References: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB4989:EE_|SEYPR06MB5301:EE_
x-ms-office365-filtering-correlation-id: e7d1f7a2-c7bd-4185-2b43-08df0cc13852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|6133799003|10067099003|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: p7OxN21bmZKdI18/6Z7opxMhjj3+EV09o7q4TRKoKTkEVEKrWnYTX7YDEiI8rhlbo95MX/swhuUww6YUsREOqoh/EheVIpOtWJVqvel7zKiHg8ekxHnV4r5lrOKeXd/k/v6xKFvQqVbHlN11zzcJWlKeqMAOU3nTsW2E8dNBTBqGBZ6E85l4iI7PZMfMPuFh6S288kwVhRGhXCABZsXhs1k+X9b6Z5NhhSmqdHmhV3K8j/h6F+IIPbPzZn8Ii4osVUGZZXOy5FVz9FmHUDwokWahKx05xovUQ+6aVaxOWt43m/i95evWwLF047lVkbRqro4wSTHLUuz+2Ox3YGDQVD3DbrpohnX+3Pz5IfH37fNXTu60fbVShluolY8LUTX25t5/KZBJO7D3nfJiykZA4MFhW29fqtJx8qxTi4xKzYkyMwT3LfAIRGO/kQnUeeCIst+9UIHY0MHM5aHTRY6G6uT2FVG3dy5TU59xGy6x94dhuY0JqxfULtyAOEwgzrV9yxVN5wCrzsV5/dDEh+JHOA/77IwTab9Mb0LQLUieycXJ0OtNpbDKbkpF2iFHV2w7J/cx0PpIKTMnXvwR7R6PT1xVK/hdB7TfwjvLdVziBYGEw8WtZ5Wr04yEZwjjwajFHqlNC1WtJgJkF7KKz1rJr3LKFB7mFqkU/mfnXv3hQ+039tdszAid0nrIXNByEVKdUUvQbw2iBpb2kvcXsyxVdhm2ywBpwr0RKtYpLVJvLh0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB4989.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rLV3KmZZrFEPWs7mS9iWdi3KWb60WCQTa/CcZnvbspd55rnWCUBao9Agun?=
 =?iso-8859-1?Q?D6nuczE84whaT84Y0ledUZDAkrlNzdHYsG0jG5235CtbxpBoljCAco1CNY?=
 =?iso-8859-1?Q?TRBzO3yUe1V3bh+Z8sx4ryPk6fGVvKN6VXBR/UKIwY4Us0Qsb+uL9Lq1NC?=
 =?iso-8859-1?Q?JmQHlTUzyb68ifL8tmeYbq/Qbeat8Kr2rgzNaTME0gOQxnlTO831jpgu2S?=
 =?iso-8859-1?Q?kMPq4EP6k7tME6fKln8+iBDkWjmmQRszseJQwXtdqZpq0Kg9eTRzw4mGT3?=
 =?iso-8859-1?Q?kpD56NQQNHfHuBwyzRhd4DJFBbjjtaDxJEltq6Ffp30Ax3xNe13TV60C7r?=
 =?iso-8859-1?Q?SJ1/Qb4FSZDpmFl/X6A024R26ZyqbVjNcgNMY2kEu4rLCJMZ4v9ZIN0mAF?=
 =?iso-8859-1?Q?FWrFHsz2FzdsAiPa89tzlT/iBs/h72Lx/0gwXFQCs5odYK3XuTF0+Ohla+?=
 =?iso-8859-1?Q?ZiAm5UHwiMJADuQ/MzXe+/AFJDMWzftQl1BMnFNwmfXGDTHfRBEXcjQbLq?=
 =?iso-8859-1?Q?J74lUSOkwLzotgf5jx3KhwLfZRIa0zLiWsrfneLIW1Pwsag91ar8mFFVeN?=
 =?iso-8859-1?Q?BJ7RyztVg/2zTHyTLjESNZt0lV6UxqC1T+3UKztjxw9VW2RoUGEXZ8BpkH?=
 =?iso-8859-1?Q?ZWLLErWLKuwPbdiR90Hvwnw6bQDd948dqImqg5ECNw3NbkVphpgJy3AT6S?=
 =?iso-8859-1?Q?j1lT5ZaFPnRMQEZEcU0SficKRfVXvijOY0DeTpZbPRBNDdJtaPhyBgizDH?=
 =?iso-8859-1?Q?KZlXCPAkgJvx97EJCho1wQ9cnK/jcMgJa6xpDdasoE7pUhz0GXvsfjNtOM?=
 =?iso-8859-1?Q?FzpJ6zgrGUiFUJre9LqcSABr8Jzjnu1qNwgHEAKGHtsn3HSvui7SwvZQfw?=
 =?iso-8859-1?Q?msJYHet40kJrOU517mCYSAFNI4KlQDJ3gv6RKMqod/crq5G9Kb5AV3gewE?=
 =?iso-8859-1?Q?yxx91FPm8WqrWo/dwPRXpSK/6ElB+8a47WpPlKKEGU7ztHwPE47w8xnb6R?=
 =?iso-8859-1?Q?mmyyYs+JiLF+TJ7EfafjSpvZnj0Ho/aWHVJlA+n5cMSgEsZke0f0LxxOQI?=
 =?iso-8859-1?Q?deCj/B7cMXpw42XwZpVK+KXuTNavCIy4rkYlyTDs2LfSGWXx/bIc1zd2jl?=
 =?iso-8859-1?Q?gWVPNUSYSNb4E6xNywvG+McUSfYwpobAY1GN+/Yx0CxUygZfgWxK4VJygE?=
 =?iso-8859-1?Q?YvfIFWSTPcYrHi9DqzQZBqdyRfvVYcPzdU0pDJWURkxOAMDZ+3HzfeK8Md?=
 =?iso-8859-1?Q?YXtklOWDii5aKeBOizSD9v97qRK4rfEZCioczxncJhJlUvffr6aO2pTaC+?=
 =?iso-8859-1?Q?Ov++Zl7pIonPUX614tXRqX7QYb7OaFZXcKklvE0kq/btYnM6hNjf03ofCk?=
 =?iso-8859-1?Q?wBibbVQME+P2Sp+rt6dkjvRDw+qfi+eTJ6dVkuEBnaQzNIZdeN6u91r7MZ?=
 =?iso-8859-1?Q?2tPe75W40YZN3F8CKKRhjsqev/Ce8iqwxgElKhJ2F8eGQ3Kl5Y0GyjY26e?=
 =?iso-8859-1?Q?Gjdu3KSlnrgmGekgxczI5TmIBzqAWrxwP+R6U24DnMaZqXPhQ0BwTz9SqV?=
 =?iso-8859-1?Q?N61ybRaFomMLDRa9xzH0s/bLA2eQU3AAnpCp1s9gDEHbNFfwSt4bSFLMEy?=
 =?iso-8859-1?Q?k3UF4Uyqzci6S1y6HLgWSdV/DdCunt6AnkUafMy1WEKpJK0iSNDHkjSgvO?=
 =?iso-8859-1?Q?wJf7J0rsyFtZBRh3+MtJhAVf24eDIbLWUr2NOvzVgT5Oy91iUNyHS+peNJ?=
 =?iso-8859-1?Q?Oum/g3Xyl2t1NWHV595FG0GO9Xn1+UMcvuyVwGS8tN4Gkk2Gsi3aI0Ljl1?=
 =?iso-8859-1?Q?90EQiNviYg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 02JLeDkYAClOquxpug7RB1oueHgp1RK/+4HEp0D2ZHz6UZg+maFwuhxp18oVi89wub7SNrdz2BPGF9Fn3UGIpqASSFrho+ZVQCezJKs0Ft9QfJxb0wrVx14ypAtnqJME4Ao0Slh6vybPMLQ3y6jKO1qCkXIkZDu8+9ZIqTfic/3abzRL6Nr9zbY4/SjI6h94ALRqKo6UXoYDP6mUnQ1nnmyod2c4F8KP4ryZY7d/eFKOnbUC/1FBbeRLn0A12cwS8XLTl1VWIxdM9/PfBln9j5QpXlbzrcKBEUgExfEZL4iO0P6IPwUZ/Unc3m4z5gIkF6a7091bb4tSWsVn4tXHnQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB4989.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d1f7a2-c7bd-4185-2b43-08df0cc13852
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:20:12.2324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bz9gJObD3waAC5kKoQc7pHhE2EVigIuyIyQ9zKi1JFoNxJ//M41dgxy0VRMrO2SDkQBzIQ2/OvgZ9Wm6WXy7QaZWxb8isVMr4qJNQG3VnGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5301
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

The display controller has a 2D engine at BAR 1 + 0x8000. It was not=0A=
modelled, so its status register read back as all ones, which bit 31=0A=
defines as a busy engine. ASPEED's UEFI driver waits for it and stops=0A=
when it tries to scroll the console.=0A=
=0A=
Add the engine as a second subregion of BAR 1 and model the BitBLT=0A=
command, which is the one the firmware uses. Only the source copy=0A=
raster operation is done; other operations, clipping, patterns and the=0A=
transparent monochrome mask are logged and nothing is drawn. A=0A=
rectangle that does not fit in the framebuffer is rejected rather than=0A=
half copied.=0A=
=0A=
The command carries a direction for each axis. When one is negative the=0A=
coordinates are the last row or column, so an overlapping copy starts=0A=
from that end and a scroll does not smear.=0A=
=0A=
The status register reads as idle after reset, a write of one clears=0A=
that bit, and it is set again when a command finishes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/display/aspeed-vga.h |  10 ++=0A=
 hw/display/aspeed-vga.c | 261 ++++++++++++++++++++++++++++++++++++++++=0A=
 hw/display/trace-events |   3 +=0A=
 3 files changed, 274 insertions(+)=0A=
=0A=
diff --git a/hw/display/aspeed-vga.h b/hw/display/aspeed-vga.h=0A=
index 55dcc57108..625e513115 100644=0A=
--- a/hw/display/aspeed-vga.h=0A=
+++ b/hw/display/aspeed-vga.h=0A=
@@ -25,13 +25,23 @@ OBJECT_DECLARE_TYPE(AspeedVGAState, AspeedVGAClass, ASP=
EED_VGA)=0A=
 #define ASPEED_VGA_IOPORT_OFFSET    0x380=0A=
 #define ASPEED_VGA_IOPORT_SIZE      0x80=0A=
 =0A=
+/*=0A=
+ * 2D Graphics Engine (G2D)=0A=
+ *=0A=
+ * Offset 0x8000 from the BAR 1 register base=0A=
+ */=0A=
+#define ASPEED_VGA_G2D_OFFSET    0x8000=0A=
+#define ASPEED_VGA_G2D_NR_REGS   (0x200 >> 2)=0A=
+=0A=
 struct AspeedVGAState {=0A=
     PCIDevice parent_obj;=0A=
 =0A=
     VGACommonState vga;=0A=
     MemoryRegion mmio;=0A=
     MemoryRegion ioport;=0A=
+    MemoryRegion g2d;=0A=
 =0A=
+    uint32_t g2d_regs[ASPEED_VGA_G2D_NR_REGS];=0A=
     uint8_t vgaer;=0A=
     uint32_t last_cursor_y;=0A=
     bool last_cursor_on;=0A=
diff --git a/hw/display/aspeed-vga.c b/hw/display/aspeed-vga.c=0A=
index a859c9da0a..bb9e8705ed 100644=0A=
--- a/hw/display/aspeed-vga.c=0A=
+++ b/hw/display/aspeed-vga.c=0A=
@@ -104,6 +104,259 @@ REG8(AST_CR_SOC_SCRATCH0, 0xd0)=0A=
 #define CURSOR_MONO_AND 0x8000=0A=
 #define CURSOR_MONO_XOR 0x4000=0A=
 =0A=
+/*=0A=
+ * 2D Graphics Engine (G2D)=0A=
+ *=0A=
+ * Offset 0x8000 from the BAR 1 register base=0A=
+ */=0A=
+REG32(GER_SRC_BASE, 0x00)=0A=
+    FIELD(GER_SRC_BASE, ADDR, 3, 27)=0A=
+REG32(GER_SRC_PITCH, 0x04)=0A=
+    FIELD(GER_SRC_PITCH, PITCH, 19, 11)=0A=
+REG32(GER_DST_BASE, 0x08)=0A=
+    FIELD(GER_DST_BASE, ADDR, 3, 27)=0A=
+REG32(GER_DST_PITCH, 0x0c)=0A=
+    FIELD(GER_DST_PITCH, PITCH, 19, 11)=0A=
+REG32(GER_DST_XY, 0x10)=0A=
+    FIELD(GER_DST_XY, X, 16, 12)=0A=
+    FIELD(GER_DST_XY, Y, 0, 12)=0A=
+REG32(GER_SRC_XY, 0x14)=0A=
+    FIELD(GER_SRC_XY, X, 16, 12)=0A=
+    FIELD(GER_SRC_XY, Y, 0, 12)=0A=
+REG32(GER_DIMENSION, 0x18)=0A=
+    FIELD(GER_DIMENSION, WIDTH, 16, 12)=0A=
+    FIELD(GER_DIMENSION, HEIGHT, 0, 12)=0A=
+REG32(GER_CMD, 0x3c)=0A=
+    FIELD(GER_CMD, NEG_X, 21, 1)=0A=
+    FIELD(GER_CMD, NEG_Y, 20, 1)=0A=
+    FIELD(GER_CMD, PATTERN, 16, 2)=0A=
+    FIELD(GER_CMD, ROP, 8, 8)=0A=
+    FIELD(GER_CMD, MONO_TRANSPARENT, 7, 1)=0A=
+    FIELD(GER_CMD, SRC_FROM_QUEUE, 6, 1)=0A=
+    FIELD(GER_CMD, COLOR, 4, 2)=0A=
+    FIELD(GER_CMD, CLIP, 3, 1)=0A=
+    FIELD(GER_CMD, TYPE, 0, 3)=0A=
+#define GER_CMD_TYPE_BITBLT     0=0A=
+#define GER_CMD_COLOR_TRUE      2=0A=
+#define GER_CMD_COLOR_HIGH      1=0A=
+#define GER_CMD_COLOR_256       0=0A=
+/*=0A=
+ * A ROP3 code: an 8 bit truth table for a boolean function of source,=0A=
+ * destination and pattern. 0xcc is the one that leaves the destination=0A=
+ * equal to the source, and is the only one modelled.=0A=
+ */=0A=
+#define GER_CMD_ROP_SRCCOPY     0xcc=0A=
+REG32(GER_STATUS, 0x4c)=0A=
+    FIELD(GER_STATUS, IDLE, 24, 1)=0A=
+    FIELD(GER_STATUS, CMDQ_SPACE, 20, 1)=0A=
+=0A=
+/*=0A=
+ * Copy a rectangle. Only the source copy raster operation is modelled,=0A=
+ * which is all the firmware needs to scroll and clear the console.=0A=
+ */=0A=
+static void aspeed_g2d_bitblt(AspeedVGAState *s)=0A=
+{=0A=
+    uint32_t src_x =3D FIELD_EX32(s->g2d_regs[R_GER_SRC_XY], GER_SRC_XY, X=
);=0A=
+    uint32_t src_y =3D FIELD_EX32(s->g2d_regs[R_GER_SRC_XY], GER_SRC_XY, Y=
);=0A=
+    uint32_t dst_x =3D FIELD_EX32(s->g2d_regs[R_GER_DST_XY], GER_DST_XY, X=
);=0A=
+    uint32_t dst_y =3D FIELD_EX32(s->g2d_regs[R_GER_DST_XY], GER_DST_XY, Y=
);=0A=
+    uint32_t src_pitch =3D FIELD_EX32(s->g2d_regs[R_GER_SRC_PITCH],=0A=
+                                    GER_SRC_PITCH, PITCH) * 8;=0A=
+    uint32_t dst_pitch =3D FIELD_EX32(s->g2d_regs[R_GER_DST_PITCH],=0A=
+                                    GER_DST_PITCH, PITCH) * 8;=0A=
+    uint32_t src_base =3D FIELD_EX32(s->g2d_regs[R_GER_SRC_BASE],=0A=
+                                   GER_SRC_BASE, ADDR) << 3;=0A=
+    uint32_t dst_base =3D FIELD_EX32(s->g2d_regs[R_GER_DST_BASE],=0A=
+                                   GER_DST_BASE, ADDR) << 3;=0A=
+    uint32_t height =3D FIELD_EX32(s->g2d_regs[R_GER_DIMENSION],=0A=
+                                 GER_DIMENSION, HEIGHT);=0A=
+    uint32_t width =3D FIELD_EX32(s->g2d_regs[R_GER_DIMENSION],=0A=
+                                GER_DIMENSION, WIDTH);=0A=
+    uint32_t cmd =3D s->g2d_regs[R_GER_CMD];=0A=
+    uint64_t src_offset;=0A=
+    uint64_t dst_offset;=0A=
+    uint32_t bytes_pp;=0A=
+    bool right_to_left;=0A=
+    bool bottom_up;=0A=
+    uint32_t color;=0A=
+    uint64_t line;=0A=
+    uint32_t i;=0A=
+    uint32_t y;=0A=
+=0A=
+    right_to_left =3D FIELD_EX32(cmd, GER_CMD, NEG_X);=0A=
+    bottom_up =3D FIELD_EX32(cmd, GER_CMD, NEG_Y);=0A=
+    color =3D FIELD_EX32(cmd, GER_CMD, COLOR);=0A=
+=0A=
+    switch (color) {=0A=
+    case GER_CMD_COLOR_256:=0A=
+        bytes_pp =3D 1;=0A=
+        break;=0A=
+    case GER_CMD_COLOR_HIGH:=0A=
+        bytes_pp =3D 2;=0A=
+        break;=0A=
+    case GER_CMD_COLOR_TRUE:=0A=
+        bytes_pp =3D 4;=0A=
+        break;=0A=
+    default:=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: 2D command 0x%08x has an invalid color mode\n",=
=0A=
+                      __func__, cmd);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (FIELD_EX32(cmd, GER_CMD, ROP) !=3D GER_CMD_ROP_SRCCOPY) {=0A=
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented raster operation 0x%02=
x\n",=0A=
+                      __func__, FIELD_EX32(cmd, GER_CMD, ROP));=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (FIELD_EX32(cmd, GER_CMD, SRC_FROM_QUEUE)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: source from the command queue is not implemente=
d\n",=0A=
+                      __func__);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (FIELD_EX32(cmd, GER_CMD, CLIP)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: rectangular clipping is not implemented\n",=0A=
+                      __func__);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (FIELD_EX32(cmd, GER_CMD, MONO_TRANSPARENT)) {=0A=
+        qemu_log_mask(LOG_UNIMP,=0A=
+                      "%s: a transparent monochrome mask is not implemente=
d\n",=0A=
+                      __func__);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (FIELD_EX32(cmd, GER_CMD, PATTERN)) {=0A=
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented pattern source %u\n",=
=0A=
+                      __func__, FIELD_EX32(cmd, GER_CMD, PATTERN));=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!width || !height || !src_pitch || !dst_pitch) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: 2D command 0x%08x has nothing to copy: "=0A=
+                      "width %u, height %u, src pitch %u, dst pitch %u\n",=
=0A=
+                      __func__, cmd, width, height, src_pitch, dst_pitch);=
=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_g2d_bitblt(cmd, width, height, src_x, src_y, dst_x, dst_y=
,=0A=
+                            bytes_pp);=0A=
+=0A=
+    /*=0A=
+     * The engine renders away from the given corner, so when a direction =
is=0A=
+     * negative that corner is the last row or column. Step back to the to=
p=0A=
+     * left one, which the rest of this function works from.=0A=
+     */=0A=
+    if (bottom_up) {=0A=
+        if (src_y + 1 < height || dst_y + 1 < height) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: 2D command 0x%08x runs off the top of the "=
=0A=
+                          "framebuffer\n", __func__, cmd);=0A=
+            return;=0A=
+        }=0A=
+        src_y -=3D height - 1;=0A=
+        dst_y -=3D height - 1;=0A=
+    }=0A=
+=0A=
+    if (right_to_left) {=0A=
+        if (src_x + 1 < width || dst_x + 1 < width) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: 2D command 0x%08x runs off the left of the =
"=0A=
+                          "framebuffer\n", __func__, cmd);=0A=
+            return;=0A=
+        }=0A=
+        src_x -=3D width - 1;=0A=
+        dst_x -=3D width - 1;=0A=
+    }=0A=
+=0A=
+    line =3D (uint64_t)width * bytes_pp;=0A=
+=0A=
+    src_offset =3D (uint64_t)src_base +=0A=
+                 (uint64_t)(src_y + height - 1) * src_pitch +=0A=
+                 (uint64_t)src_x * bytes_pp;=0A=
+    dst_offset =3D (uint64_t)dst_base +=0A=
+                 (uint64_t)(dst_y + height - 1) * dst_pitch +=0A=
+                 (uint64_t)dst_x * bytes_pp;=0A=
+=0A=
+    if (src_offset + line > s->vga.vram_size ||=0A=
+        dst_offset + line > s->vga.vram_size) {=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: 2D command 0x%08x reaches past the framebuffer\=
n",=0A=
+                      __func__, cmd);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    for (i =3D 0; i < height; i++) {=0A=
+        /* NEG_Y says which end to start from, so an overlap does not smea=
r */=0A=
+        y =3D bottom_up ? height - 1 - i : i;=0A=
+        src_offset =3D (uint64_t)src_base +=0A=
+                     (uint64_t)(src_y + y) * src_pitch +=0A=
+                     (uint64_t)src_x * bytes_pp;=0A=
+        dst_offset =3D (uint64_t)dst_base +=0A=
+                     (uint64_t)(dst_y + y) * dst_pitch +=0A=
+                     (uint64_t)dst_x * bytes_pp;=0A=
+=0A=
+        memmove(s->vga.vram_ptr + dst_offset, s->vga.vram_ptr + src_offset=
,=0A=
+                line);=0A=
+        memory_region_set_dirty(&s->vga.vram, dst_offset, line);=0A=
+    }=0A=
+}=0A=
+=0A=
+static uint64_t aspeed_g2d_read(void *opaque, hwaddr addr, unsigned size)=
=0A=
+{=0A=
+    AspeedVGAState *s =3D opaque;=0A=
+    uint32_t reg =3D addr >> 2;=0A=
+    uint32_t val =3D s->g2d_regs[reg];=0A=
+=0A=
+    trace_aspeed_g2d_read(reg, val);=0A=
+    return val;=0A=
+}=0A=
+=0A=
+static void aspeed_g2d_write(void *opaque, hwaddr addr, uint64_t val,=0A=
+                             unsigned size)=0A=
+{=0A=
+    AspeedVGAState *s =3D opaque;=0A=
+    uint32_t reg =3D addr >> 2;=0A=
+=0A=
+    trace_aspeed_g2d_write(reg, val);=0A=
+=0A=
+    switch (reg) {=0A=
+    case R_GER_STATUS:=0A=
+        s->g2d_regs[reg] &=3D ~(val & (R_GER_STATUS_IDLE_MASK |=0A=
+                                     R_GER_STATUS_CMDQ_SPACE_MASK));=0A=
+        break;=0A=
+    case R_GER_CMD:=0A=
+        s->g2d_regs[reg] =3D val;=0A=
+        if (FIELD_EX32(val, GER_CMD, TYPE) =3D=3D GER_CMD_TYPE_BITBLT) {=
=0A=
+            aspeed_g2d_bitblt(s);=0A=
+        } else {=0A=
+            qemu_log_mask(LOG_UNIMP, "%s: unimplemented 2D command type %u=
\n",=0A=
+                          __func__, FIELD_EX32(val, GER_CMD, TYPE));=0A=
+        }=0A=
+        s->g2d_regs[R_GER_STATUS] |=3D R_GER_STATUS_IDLE_MASK;=0A=
+        break;=0A=
+    default:=0A=
+        s->g2d_regs[reg] =3D val;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_g2d_ops =3D {=0A=
+    .read =3D aspeed_g2d_read,=0A=
+    .write =3D aspeed_g2d_write,=0A=
+    .valid.min_access_size =3D 4,=0A=
+    .valid.max_access_size =3D 4,=0A=
+    .impl.min_access_size =3D 4,=0A=
+    .impl.max_access_size =3D 4,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+};=0A=
+=0A=
 /*=0A=
  * The ast driver writes a color format to CRA3 when it switches to the=0A=
  * extended mode. Until then CRA3 is zero and the device behaves like a=0A=
@@ -517,6 +770,9 @@ static void aspeed_vga_reset_hold(Object *obj, ResetTyp=
e type)=0A=
         R_AST_CR_SOC_SCRATCH0_VRAM_INIT_BY_BMC_MASK |=0A=
         R_AST_CR_SOC_SCRATCH0_VRAM_INIT_READY_MASK |=0A=
         R_AST_CR_SOC_SCRATCH0_IKVM_WIDESCREEN_MASK;=0A=
+=0A=
+    memset(s->g2d_regs, 0, sizeof(s->g2d_regs));=0A=
+    s->g2d_regs[R_GER_STATUS] =3D R_GER_STATUS_IDLE_MASK;=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -592,6 +848,10 @@ static void aspeed_vga_realize(PCIDevice *dev, Error *=
*errp)=0A=
     memory_region_add_subregion(&s->mmio, ASPEED_VGA_IOPORT_OFFSET,=0A=
                                 &s->ioport);=0A=
 =0A=
+    memory_region_init_io(&s->g2d, OBJECT(dev), &aspeed_g2d_ops, s,=0A=
+                          "aspeed-vga.g2d", ASPEED_VGA_G2D_NR_REGS << 2);=
=0A=
+    memory_region_add_subregion(&s->mmio, ASPEED_VGA_G2D_OFFSET, &s->g2d);=
=0A=
+=0A=
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);=
=0A=
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio);=0A=
 }=0A=
@@ -612,6 +872,7 @@ static const VMStateDescription vmstate_aspeed_vga =3D =
{=0A=
         VMSTATE_STRUCT(vga, AspeedVGAState, 0, vmstate_vga_common,=0A=
                        VGACommonState),=0A=
         VMSTATE_UINT8(vgaer, AspeedVGAState),=0A=
+        VMSTATE_UINT32_ARRAY(g2d_regs, AspeedVGAState, ASPEED_VGA_G2D_NR_R=
EGS),=0A=
         VMSTATE_END_OF_LIST()=0A=
     }=0A=
 };=0A=
diff --git a/hw/display/trace-events b/hw/display/trace-events=0A=
index fd4289d755..0e2adc2b80 100644=0A=
--- a/hw/display/trace-events=0A=
+++ b/hw/display/trace-events=0A=
@@ -141,6 +141,9 @@ vga_cirrus_bitblt_start(uint8_t blt_rop, uint8_t blt_mo=
de, uint8_t blt_modeext,=0A=
 # aspeed-vga.c=0A=
 aspeed_vga_read_byte(uint32_t port, uint8_t val) "port 0x%03x, val 0x%02x"=
=0A=
 aspeed_vga_write_byte(uint32_t port, uint8_t val) "port 0x%03x, val 0x%02x=
"=0A=
+aspeed_g2d_read(uint32_t reg, uint32_t val) "reg 0x%02x, val 0x%08x"=0A=
+aspeed_g2d_write(uint32_t reg, uint32_t val) "reg 0x%02x, val 0x%08x"=0A=
+aspeed_g2d_bitblt(uint32_t cmd, uint32_t w, uint32_t h, uint32_t sx, uint3=
2_t sy, uint32_t dx, uint32_t dy, uint32_t bpp) "cmd 0x%08x, %ux%u, src %u,=
%u dst %u,%u, %u bytes/pixel"=0A=
 =0A=
 # sii9022.c=0A=
 sii9022_read_reg(uint8_t addr, uint8_t val) "addr 0x%02x, val 0x%02x"=0A=
-- =0A=
2.53.0=0A=


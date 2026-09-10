Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0273FC79FB7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Tqq-0005Ue-50; Wed, 09 Sep 2026 21:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4Tqe-0005Np-IC; Wed, 09 Sep 2026 21:45:10 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x4Tqc-0004BB-4l; Wed, 09 Sep 2026 21:45:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3kJfgEST4QSsixoSzmDrNyJWdxZ/XaaG2r/85XMJJPVTwc0xL2vjn+KXhX+FX5romOmFNcuwlKYKXdEtQb89WMRQqna08zhfUoUnR23nhgiX6aqYIHq2fizhm7JRoMOfL5/IAki6wSgTs9iwhDoEO5+Qhj1sZZiloavQzDTnDWcGnNjuUEndmBoUlz6msoGkYUsEqca/Rr0fB4SxYDnxHqJzl6RuVITaAWntFG1sntBbPMAWZRXNYnnY8X+q03YdLQomRk3jMgSci4UYQRcRI5GVuWfHdww89olayupcBl2zWsVASAoQp3K9r12jbCenxx9NYlT4Ntw0gZFvgk4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxQMHDjU0OCSzXl+QMJrGpSc8T40N3mlTQL/BLVZ9z4=;
 b=hGVwL9UD7sJ++8J9tbtrZ0PkposcgyXsO8EwfKV27H5SH0mLn6kdobbtpcyaP7P/MqzZIvvqzaP6Ib3m2tE56suI8pdXhOQ62mDKaDpDCq1sYuJCzhxeUDX0PVgYbMRMnClunIet/XF3ITfcsp6B0OxlQiozlwoJntTdYy7XqNqF7xIPEAH7oCpc2EIDlreT2wd6f/kMy7X/J6Ovo5OEi33RjuZmz9b2XJXzOTdIybI532KzsJPCfJXADgPsqi5D+f763xDnrli7MPB3nei5eQQhzXiQSgppQiaoWYgaIye7WEboZ+uNSdpyhx3+Y0mKAt47M/Rxy7L/JYNg/ZqsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxQMHDjU0OCSzXl+QMJrGpSc8T40N3mlTQL/BLVZ9z4=;
 b=cmSyGpoTK5oeWD7mC8dVn6IJmGldIebV2tfnRoOF9wJ8YprGVAwyUn8OQAlawfq4ipWL1ZmpvwHj+PcUwcwTk4ySKSGFWCwOEAPdYqBIudSQRlf7Jlbu/1KRPHMcPmnGfjZfcqUVoZePqMafDMnIewjNzzbqipQR1oYx6z24Or5inzFAL+0XniZ7cpxzZxslsYQR5RtJQX3QH8apmTTelxyrYZ53fTE68BFZH4/ov535HU7VTms5GC0b7NtBGXPTI+BGpiiz5UgDiUdQXZeV2RuvoEUitndvAh7NFpj0XxUBYyDEH14rOB0mUW43IjRo+iET0K2wCFQ6V8vozxGpCQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB6829.apcprd06.prod.outlook.com (2603:1096:101:1a7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 01:44:54 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 01:44:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 5/6] hw/display/aspeed-vga: Add the 2D graphics engine
Thread-Topic: [PATCH v2 5/6] hw/display/aspeed-vga: Add the 2D graphics engine
Thread-Index: AQHdQMX5iKdbCG5n+E2sxDV8qjsq6A==
Date: Thu, 10 Sep 2026 01:44:53 +0000
Message-ID: <20260910014447.4110781-6-jamin_lin@aspeedtech.com>
References: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260910014447.4110781-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB6829:EE_
x-ms-office365-filtering-correlation-id: 81c85294-1843-475d-17d3-08df0edd1c6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|6133799003|10067099003|56012099006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: Amgq2lQRKZOUGvymaJKqUkErp3jqXPpjyQiI9Wl/M5qMaUWwvpi/J9VL3xXA5ulEuZ5QFWuBUGV7ozq1c9JQRASiB/Cd0S5QvvCTMP1JreVYGrH0wodGnuGPCWS9aIfeTNJ5pXzYkhV6Z9OYQBuWXA2HYhA+YjqcSKsG5WmntJmIxD3uwrh0M/lkgT8xzTpLoJCgQX/ePqEsigVmCo1r3WPyI/jnHwNSVjUhayFKRK3YeWqZ+euU2tYrElDMEyxfbPIms/pICXzh7XHF8ah1BElo23IDfJNXgqg8iEMCMCNE92nqg7bdxXno42BLUM6+o4yGCo9YFELVLeVfOIQiaDI0cMAGHJdIBNBo5XxekeAj4TLzLo1Gpij3BBzYHl3CzNyaUpl1aULdGl34Y0s7IbIDLnD4ckaQwMEPvGBxV1mJ/hn2B1QYLKVfk48lZs29AldPKH2rRZNKyeR5HsnQ/OavmwvCE8hUN5Muvj3+6WuwIJmEI4mLGXbUlQAm4djg3MgY2J0nv5aVcR8MnZUNUpDdiBipmCOxTpxcbtS2utT9txV3vlfmj8KKZ+H8XTlGqwe0FIiKy8SR+mbwM8jdFme4/X1aqdhAK1JOULsU03J+phzVDoTgdC8oVKgNGB8am6FTpI4Tm7XZlyb4Pu35DeFXlscJ2RFWlr59eDZvNOOY+B0MmBzQkbJzcZeR39ICf1tftMWWMgp8Yr37CwzqepsmdiE0LIeW3ls15gwiyYM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(6133799003)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vpNCrhUerp8kIiy0NJxju/Xopwd6tA8aLNGNwcVr0XR1CGIOGoyUcqvjF1?=
 =?iso-8859-1?Q?L1IRcQ/i6Bko4q5LPfo1FX6D9niftJ64WJsmk7pa5NtQLaRRpoqGPGJ6yO?=
 =?iso-8859-1?Q?fxuDNiSs0LxUyVJGwfcBZnObhVFbYWiOqLKTT6WS9H+WLN3otnRHQ9A24S?=
 =?iso-8859-1?Q?/j4Bv9w4TVrvZOxUGSnVRm9bA0YMOj5OW3iy+jUDZfThBR/qU5OPlp/Ccg?=
 =?iso-8859-1?Q?o/WJpIipYt+cBXHf9dDhkdtqN9a0axzx9ZJG91IGKTkofeNl+pGKNwDfHH?=
 =?iso-8859-1?Q?DorgYdjdXU8pI6EBJLL9gG4pI8FiR+d8akhdRCo49C533t1WjqyjheWePr?=
 =?iso-8859-1?Q?s4Qxk46ETx5CxYq6sY2tSHs8+WXqFGBiFUNkkW/01A2hBHwcZ2d+ReQFc3?=
 =?iso-8859-1?Q?g8WyH5RAx3MAUlFL8aydMMukRTQkSHFM5sa3BZgt17EDc01UOoP+EG89Kd?=
 =?iso-8859-1?Q?57hgOiykc4ayYbDf5wwsSPjkPWbEzWCU5KpM63yb09fpGP4xDpunw1/XID?=
 =?iso-8859-1?Q?h5RJo2gNfbQwDPrw3/Hq12Go1/xNGtByaFVsD/LLjvreFQO+2agPhikuoo?=
 =?iso-8859-1?Q?Xw4BE0/Tp5Cl854CAe5w2kHw0aNAkuwnRoZSJffjy5OG7NNv6y7uoqfSk3?=
 =?iso-8859-1?Q?1WTkUHJlTIk9FS+7Zk2UI2LOW8hVejgve48dMVCbqeEewovsRBImDUd4/i?=
 =?iso-8859-1?Q?V2Pu7/AILV3Vfa5yWoEGOa4soKUua+7qlkhk9nwfR2O4n7fXu4OTYql+G6?=
 =?iso-8859-1?Q?EgLN5nO4nypgwwbltGlPA7fMoQk8ajoc5FoQV+iVCXY2GWQfZvm9TzlMzr?=
 =?iso-8859-1?Q?3l8sNkl4lU/enGE5r2OW9sOAvm6VtaQ/53xbY2sa/i5GdEH+YiH41sC/vn?=
 =?iso-8859-1?Q?eNP+cgdFZlFx5rT1npyZw98xGoZxdQbpD/AmBgF2bKIWNmyKh+Yzx9apjf?=
 =?iso-8859-1?Q?tiMQ1/4lxwYdN4E40NYYsSGYF/LsSGL+BlksygRezMMMl6HZCN5zZr+2IT?=
 =?iso-8859-1?Q?2bbu13+PcvaL0h6QF+NjPOdHnkp/gg3vGXaGEe3dSCIwv5NE+10qjsYgrn?=
 =?iso-8859-1?Q?G0pDA/MRYfyXIHyBznanIM30LnmdVv+UPP9aIULituBfeBnQoFbAHIFllN?=
 =?iso-8859-1?Q?SJOLmgG7A/t/4fbDSMq92Ch0z7YWPW7I3Up5GufVNT7AB4a87tSdjTuLx+?=
 =?iso-8859-1?Q?r15eV2QVLnlcbd6EV73Yrq+Fhxn6O2bWSKt7nwiw89s1LlNnMu7qfzuYSd?=
 =?iso-8859-1?Q?GAIEpVOFSSVyAS2D1f8oTZhclmW+wFgsKaRQTG8qj+pgwC3Eqhk+YeBOV0?=
 =?iso-8859-1?Q?S75jo8NU4nWuGq+LS3Pj4VOJ2ayD6JzNsq+nM7uja3uQFCWVRTt/Pmcrk3?=
 =?iso-8859-1?Q?xOquPmnyHZ095IN95pjYgs9o2gkIn5cj4UaQkzNy5bI+4hjxlf08BeQYDP?=
 =?iso-8859-1?Q?129lKZb5UdNvMpgePkk+XOpLO1qDeboQwj2XAntgjaHsjQWZpNB8/tpt49?=
 =?iso-8859-1?Q?HzojYUwTyUWh8WKLJ5asd/x+QRRNRh/bI71l/Hl+6rtqzdS4Jx5ownDCT6?=
 =?iso-8859-1?Q?b8xc5BlCQ/WI6af3miGalBuISxzfsHgCNe/KdqRVKYweZHWJ7+wMTW8ob9?=
 =?iso-8859-1?Q?W5QQjhAMNwjkUBtpKaYoFgGRZDPyyZjwav/6s6Kr4mxbk+D94D3vU9R0bB?=
 =?iso-8859-1?Q?BpojtcQraSsjdNFg9Btytpwb+kH4ntKVupKGpjiIzBFnbuMpgeEPW/Sdbk?=
 =?iso-8859-1?Q?dXTPX8UUTT33RFru7GJWXqrz7NNY0HtMcLNHYUgBl9Y7oZpIWxDlbE+Drn?=
 =?iso-8859-1?Q?Vbumhrtz8w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QBNOWFkbXNAqhhCzbyzmZNAY2tZfFWN4jBA3lMHyVTKvC1w7VkiUoLoKPKLMMfIqMckjXQPhuNhFdvuHbnSWWr7P7/qqsDPTSOTFkpkLiiKxz/cMVm4qnEIz0MI4MRLJ3VHdAX3JZYpYAZ1XdTvHRvsrHH/tsdErCwKPPZv7MbCceL6zbT407AjqZ3krpJBRzELmn/oVCmoK/6iOH/aWagKjiUvvsk88ksywgqXvAFwm12viIniOEdOu5TMWYSQliISRIikFx3owNfKJ2eyA2YNCt6Pwt8igkarqnNZav81to0MK1wUtm6VBzBLHNfmiEwDBsdDqfEFbHutHVym3Mw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c85294-1843-475d-17d3-08df0edd1c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 01:44:53.7175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHHhuRwLWuNIqHi11BBKgEUrwpMzII/SVM/5dP/6tlAwP87vGEDkdvv4ys7sSp36H81XLp/N1xyhyM15HwhZpl+gNdxacPzsum2i9qj88sQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6829
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
index e40d503910..f3ea154538 100644=0A=
--- a/hw/display/aspeed-vga.c=0A=
+++ b/hw/display/aspeed-vga.c=0A=
@@ -104,6 +104,259 @@ REG8(AST_CR_SOC_SCRATCH0, 0xd0)=0A=
 #define CURSOR_MONO_AND BIT(15)=0A=
 #define CURSOR_MONO_XOR BIT(14)=0A=
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


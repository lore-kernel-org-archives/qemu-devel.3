Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BB1C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3VWe-0002dn-5j; Mon, 07 Sep 2026 05:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWc-0002Zf-Cm; Mon, 07 Sep 2026 05:20:26 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWa-0001gr-AE; Mon, 07 Sep 2026 05:20:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hljKUTUVDbYqEptPaGZYzKB1TpdkDtNUWHKWRsplKGV9QByf9N+uWhypN4Yj52szmAPPdaEl1SBryt1ddRE+YGDrOp0MFOekWrE7SOUGuWJG7cMazpS02srtVSG+kXqf/Jqr04AUmCowvKvCm+mtWuZnuQ6PjJ++si+rJY8WrQ7U8+F2UynpQFEfLFh60AA2mCBw+hAIROqnYd7GluKHVd/wEvLuGdnlqaZEWj4aX071hbgu4uXsNhuOqK/8J+jbYnRBCYvHjm79BGeQ7aKGCZ6pYx8mfRVfYov27pdkjWvC1K8S807ewGVkoDAt28LEQQBAzzrG9wpxKE3jmTDbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2akF8nK2YfIXgLLWqdLFfU3iSlJX5nK2WcYJJ+AuV8=;
 b=RUHlNc8GdIwKjj151oChZHmdITIW0q7FDG04aleEGrm1eUUOxu1WyTuU6buFHnV/Og0caWRUBwdg7lWBp/Evs/LKXDC51XuD2BJQOCLWBN8PsJIL97K3S/OZafwy/NJ0KKHK4WL+ph243hlJfFuV0vV005B0cvMW1QEr5WHGqGL/8ox7lu7AQmwym2xheVat2TGJp752ucUY5r1S5taPSqdfoAjdoKpaRn+aulUpR6sZK7A03+kVi4Gkox9faD7txNmcXWfXvjnAIjYFQQLFazuJeuxQGWR9hKihNRmMtQpJNeb5jGMRQb/Rr2Iljcldcs4HmePdaTyJ3hhHR9jqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2akF8nK2YfIXgLLWqdLFfU3iSlJX5nK2WcYJJ+AuV8=;
 b=MErh2K9tI4xkuPrdRga0x0UBNqXz5lLb8LZLT9j1qdJ3FLEjBu8ywX2UduiIV3k2kq7GygBWw6o3fDoJ0dYasTKOE7E7l2vy6u1tIWQQk8MfL7NfeMEg2nBpWKFg3wDs4UwEjwoySCc+1s756VN7RT0BBWqXrfK0Y+zQhMNZCqF5dAm28aGUiwsEKXBK4v2vyqH39AhSbWcyU/CLr6H6m6lAFDmlmuZFTR4pIDVkCFtliXqpkRzDDyYpyep5uGIm4lyiUDZDZzjLmmvtstKxP3PaHMg+Sumk2/FchUiw/EcIntT0SrFEs38L0nFY9E9SOhQdoCHrp9D7pX8xf9J5JA==
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12)
 by SEYPR06MB5301.apcprd06.prod.outlook.com (2603:1096:101:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:20:11 +0000
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c]) by SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c%6]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 09:20:11 +0000
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
Subject: [PATCH v1 5/7] hw/display/aspeed-vga: Add the hardware overlay cursor
Thread-Topic: [PATCH v1 5/7] hw/display/aspeed-vga: Add the hardware overlay
 cursor
Thread-Index: AQHdPqoVySc4jLvbOkWkq8QKHJnu/w==
Date: Mon, 7 Sep 2026 09:20:10 +0000
Message-ID: <20260907092004.2590015-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: a2ef9a51-bf09-4093-cde2-08df0cc13797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|10067099003|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: rxsQFuWnhfs4UDOFL9EmKQIs/Gv6E9cxhQ0+mXn5LiR1Bua0+z+WCKAvX0/4j9BYW9ukoj6+lWdXeYCYgd877sKrs4L+7SdVNsaIkkG009ji3sjubxZifMRx4WH5gBNihou3AItgl8bBK+GILBhwOzketXcYMrXGuwEd+vqXQF2Du2c834YCqa5OgAE9RMxJrrF3Kjlqh8pn5LttdidflzOR6VqZ/drLeIjUci7NZTXRlKQgtKRckNe9oj9qTSOcpnYHWbSde9gZgTezCLR53fXM9CO16xcAdg6b4fyxRqhw6OJEDYbUumT0xNjAUPy930WbVNWi7s+C8B/Ec5dYy9aTtyRnV6HvaaGEg3mNeQaTGXiNifknUF3Ao+dpieIlWYCbkAGMP+OyNUUFXIfHYaRUfXvAEQoYEFl9zM06N4BJnDKk66zubTG02XoYkRBf2BuP7LMrk4d8T4eYvvM1tMZa93Ako4dZ7zCvBog8h4AKkJOqQEwO8/n+GPCMVBYwgr4A/IwMRWWY4eNF8ovja7SDP/VkAddNrTvKSYpbgM+lci0Bp0vfVnZoNfwp0SwFp4oVnR7A+8czFC790qxJi7iEcanQIoeyrKp4gipGIPtgjdQIffqSjIkeTrEkX2gn4GluW7nmEdajGG2mtFhYekLPLkR9W3M3ze2Tec46f/YDIi5O+xjtXIHfM9GX/w6171vrMN4iqKVSh2qpx/t8X8dviNZnstn9pqw5dgG5UEGVDTWb87Izd1etHBcAK2ac
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB4989.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uCywMxLDM6QT4X9xC3b+3evGZobWdEIc/3DSSXWQHVuuU5kMi56AvpRmQ6?=
 =?iso-8859-1?Q?cZO01uB/v1T5etpCbNwzOcDw4q5hYbeLOOIVwKlV/Sye2kOS8TFtdKmVpo?=
 =?iso-8859-1?Q?AUOF5eXU1vflXj4X3EApCYp8pU5ui4rHe2v1qpGNG+C/pgk9lSTSEdL1XC?=
 =?iso-8859-1?Q?M8hktX/10XxJwTNsLD/lsQMhBMJLjMLtSMsEhpI3geUbXWSTmAg0USWROQ?=
 =?iso-8859-1?Q?m0ZtbgzQfUn0TcDXuyDunigvaDf7itVX+JtEVBOY6DovbpfztBkvpwb66+?=
 =?iso-8859-1?Q?wHBugh90wUyTGl1l9uB8RCbvxt9iRX8+x4TX5O73JfAiQw+htGjyhS0vPt?=
 =?iso-8859-1?Q?uBJkIJ2FJ/tUwpzjQUl7j0FeClgHZPLXukFrTfV7h5NwDPUJSN9fiizImT?=
 =?iso-8859-1?Q?6DB+TNbGOdJyKCzQPKpr0CIZX8FwjN+Ly3u1OM2vQ8bAgQe4C8bDHyOgzR?=
 =?iso-8859-1?Q?YHAE4xGdGfFAzfW4EVLFC4XzQtblMf9MI7mhrhrzXPr1RBWREk0qUpRCRi?=
 =?iso-8859-1?Q?ws9tU1JVd1XGY4WmAZIM7M/JfBbvo0qjCx8cPChL2GC94D6mRljQQO15gg?=
 =?iso-8859-1?Q?RMYnaWtraqROs1jhZKU7nxbDPyHUkziCQAXSuK/ouN7D6T1LywW5SVEYyF?=
 =?iso-8859-1?Q?SepFKO1yXKtat4pa8k9tJl6Cp7aBPu6jijWH6SYl/ta54urSI4hUJBAf5+?=
 =?iso-8859-1?Q?Y/FBOEyVDfauwOG8nz9L+SNfic28crmD70i8QMjTz4+HpU/WUttmBpDyDB?=
 =?iso-8859-1?Q?P9K7mXt/XzmnSXG2O33sGlArE1qMmHYk22M/WiSInUavi4SM5/+rUh52dK?=
 =?iso-8859-1?Q?YzVJprkcOFACfU0TGZQ5mMZ5fKWj8HFbteueA75n2KgxCL83aVXeYjCd6c?=
 =?iso-8859-1?Q?RIOGhBlG3r90qGmT8osskpBYE+mAML1g4iEUSOioPo7/tGKLuXKs2PjndW?=
 =?iso-8859-1?Q?NjcHoARFxRXiIJQwYoeRmP7sMDae227dHU1jNVTn1WasLhYIAF757bX5uz?=
 =?iso-8859-1?Q?fuH4LsdhOcsa2WQ1mI8kIkIh7c6ODfXgPz4DWJjcy7G9WyYcdmAphX1GLs?=
 =?iso-8859-1?Q?QNJWjk0fwwtDU4JRjKAmR0VZ4JvULEVhQ3KcvobA+8Z1NtQqQpwxCVf8zt?=
 =?iso-8859-1?Q?A1xiRh1FJuNK29ck0cAM52ssZJgtEW8nf/yTqlCT4SH4BTKtWbtkSN5mW0?=
 =?iso-8859-1?Q?/jbLZCgLzMk+B4hpe5DgG1F9ezW6EH/kmxWFORjaMMQft1qMmh9L89gJGj?=
 =?iso-8859-1?Q?9nWCWR1GDHtawOHwvM4T66Ch74OeCF3iamuIDgFlYB9xwkDEYVMZIr1siF?=
 =?iso-8859-1?Q?QzFR4mQY64MxZMuP12kLqSGSxhwqcd2Eq/GN/wLQJCotZE83RigHCYqtcc?=
 =?iso-8859-1?Q?bn6dypZ5GTSrq2IPGI0p2Kq3sAvD5xCmXk25yxDtMxL6BA+H6NXVQOZeDB?=
 =?iso-8859-1?Q?5YQkfANdBzaR4KWyREF0hlwlLrFuBETWHVwogK/WAfkpY7B3xG4jWYQiON?=
 =?iso-8859-1?Q?+rFgkV3ZMe+4397hBB54UX89fRN2x7x4gg8z92XLJu7ROSNUOPZIOGqpet?=
 =?iso-8859-1?Q?VI2bTa1FMOyFnMT6S3Pi6OdnyFS5FmxWOnv1sqA9gN7z8CZiXX6QE6qboG?=
 =?iso-8859-1?Q?IFI9eRAuOy4RYmbxH7TeuY2oG08iUYTrBkU4DSz3r4bB/vVlnOSi7ntYEn?=
 =?iso-8859-1?Q?QfUUJ7c3ji9N/FTV2qjCA19uTCqt/OsMDTWgZkJOy6UWHZKRzQ8dx4Tj5l?=
 =?iso-8859-1?Q?7tFkAzzBJ4m8gjQ+ofABl6EGpYj2xjbOZknI6ZP2ezbxIOy2ycDHgcT50I?=
 =?iso-8859-1?Q?fdNvjmXujw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CYpAjeYn78FhcjIuXVfNcbHfEdlBIzb6t8w3eQEu9o8UcBUPmVnh4oCF/Sf7bUgPS4Dp+mFr28bxiVN7Nmz2Z+cTtoZFURHnEHAfWBK84w6W/ffqcaD+DCv4+x5x6LOWBH6vR2WfiwlPO9h3nJWxfIV8Fnxx9QLoDiv6RxlSLf3+pacqBHm+RyZGyjE7GcgrMgECs51O/ZZxUJLuQSs1dQEY9wIrQtaXRK6/mzPUH+xcq8pD+hkaqcedz637efhhST9KktrECD9bQl8Sl1cg2pfiHJ49KQUppTnc9s8fRNupEZLJrbezBRcfCtS+1EKBK1x6COBl5RH7p71Ag92Dlg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB4989.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ef9a51-bf09-4093-cde2-08df0cc13797
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:20:11.0454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KGQ3ATiRpCsJQbwZ/TG0vCw6y82Tk2/n1ZSou4VoitnQ9EV7Yi/DkLa/Y83VKv6GSQCJHFu60QK7PyP8rSQ6gN40uglokFKNyZqqEBSATUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5301
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

The display controller draws a 64x64 cursor over the picture. CRC2 to=0A=
CRCB hold its position, the address of its bitmap in the framebuffer,=0A=
the offsets into that bitmap and the format.=0A=
=0A=
Draw it through the common code's cursor callbacks. The position cannot=0A=
be negative, so the offsets say how many rows and columns to skip when=0A=
the cursor runs off the top or the left of the screen.=0A=
=0A=
CRCB selects the format. Both are modelled: ARGB4444, and the one the=0A=
datasheet calls 2 bpp, which is also two bytes per pixel but carries an=0A=
AND and an XOR mask in the top two bits instead of an alpha.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/display/aspeed-vga.h |   2 +=0A=
 hw/display/aspeed-vga.c | 194 ++++++++++++++++++++++++++++++++++++++++=0A=
 2 files changed, 196 insertions(+)=0A=
=0A=
diff --git a/hw/display/aspeed-vga.h b/hw/display/aspeed-vga.h=0A=
index 4b0315f699..55dcc57108 100644=0A=
--- a/hw/display/aspeed-vga.h=0A=
+++ b/hw/display/aspeed-vga.h=0A=
@@ -33,6 +33,8 @@ struct AspeedVGAState {=0A=
     MemoryRegion ioport;=0A=
 =0A=
     uint8_t vgaer;=0A=
+    uint32_t last_cursor_y;=0A=
+    bool last_cursor_on;=0A=
 =0A=
     /* saved standard VGA handlers, used while the extended mode is off */=
=0A=
     int (*std_get_bpp)(VGACommonState *s);=0A=
diff --git a/hw/display/aspeed-vga.c b/hw/display/aspeed-vga.c=0A=
index 4c24c4f04a..a859c9da0a 100644=0A=
--- a/hw/display/aspeed-vga.c=0A=
+++ b/hw/display/aspeed-vga.c=0A=
@@ -26,6 +26,7 @@=0A=
 #include "qemu/module.h"=0A=
 #include "qom/object.h"=0A=
 #include "ui/console.h"=0A=
+#include "ui/pixel_ops.h"=0A=
 #include "trace.h"=0A=
 #include "aspeed-vga.h"=0A=
 #include "vga_int.h"=0A=
@@ -69,11 +70,40 @@ REG8(AST_CR_OFFSET_HI, 0xb0)=0A=
 REG8(AST_CR_POWER_MGMT, 0xb6)=0A=
     FIELD(AST_CR_POWER_MGMT, VSYNC_OFF, 1, 1)=0A=
     FIELD(AST_CR_POWER_MGMT, HSYNC_OFF, 0, 1)=0A=
+REG8(AST_CR_CURSOR_XOFF, 0xc2)=0A=
+    FIELD(AST_CR_CURSOR_XOFF, OFFSET, 0, 6)=0A=
+REG8(AST_CR_CURSOR_YOFF, 0xc3)=0A=
+    FIELD(AST_CR_CURSOR_YOFF, OFFSET, 0, 6)=0A=
+REG8(AST_CR_CURSOR_X_LO, 0xc4)=0A=
+REG8(AST_CR_CURSOR_X_HI, 0xc5)=0A=
+    FIELD(AST_CR_CURSOR_X_HI, X, 0, 5)=0A=
+REG8(AST_CR_CURSOR_Y_LO, 0xc6)=0A=
+REG8(AST_CR_CURSOR_Y_HI, 0xc7)=0A=
+    FIELD(AST_CR_CURSOR_Y_HI, Y, 0, 4)=0A=
+REG8(AST_CR_CURSOR_ADDR0, 0xc8)=0A=
+    FIELD(AST_CR_CURSOR_ADDR0, ADDR, 1, 7)=0A=
+REG8(AST_CR_CURSOR_ADDR1, 0xc9)=0A=
+REG8(AST_CR_CURSOR_ADDR2, 0xca)=0A=
+    FIELD(AST_CR_CURSOR_ADDR2, ADDR, 0, 7)=0A=
+REG8(AST_CR_CURSOR_CTRL, 0xcb)=0A=
+    FIELD(AST_CR_CURSOR_CTRL, ENABLE, 1, 1)=0A=
+    FIELD(AST_CR_CURSOR_CTRL, FORMAT_ARGB4444, 0, 1)=0A=
 REG8(AST_CR_SOC_SCRATCH0, 0xd0)=0A=
     FIELD(AST_CR_SOC_SCRATCH0, VRAM_INIT_BY_BMC, 7, 1)=0A=
     FIELD(AST_CR_SOC_SCRATCH0, VRAM_INIT_READY, 6, 1)=0A=
     FIELD(AST_CR_SOC_SCRATCH0, IKVM_WIDESCREEN, 0, 1)=0A=
 =0A=
+/*=0A=
+ * The cursor bitmap is always 64x64 and lives in the framebuffer, two byt=
es=0A=
+ * per pixel in both formats.=0A=
+ */=0A=
+#define ASPEED_VGA_CURSOR_SIDE  64=0A=
+#define ASPEED_VGA_CURSOR_PITCH (ASPEED_VGA_CURSOR_SIDE * 2)=0A=
+#define ASPEED_VGA_CURSOR_SIZE  (ASPEED_VGA_CURSOR_SIDE * \=0A=
+                                 ASPEED_VGA_CURSOR_PITCH)=0A=
+#define CURSOR_MONO_AND 0x8000=0A=
+#define CURSOR_MONO_XOR 0x4000=0A=
+=0A=
 /*=0A=
  * The ast driver writes a color format to CRA3 when it switches to the=0A=
  * extended mode. Until then CRA3 is zero and the device behaves like a=0A=
@@ -176,10 +206,14 @@ static void aspeed_vga_get_params(VGACommonState *vga=
,=0A=
     AspeedVGAState *s =3D container_of(vga, AspeedVGAState, vga);=0A=
 =0A=
     if (!aspeed_vga_ext_enabled(s)) {=0A=
+        vga->force_shadow =3D false;=0A=
         s->std_get_params(vga, params);=0A=
         return;=0A=
     }=0A=
 =0A=
+    vga->force_shadow =3D FIELD_EX8(vga->cr[R_AST_CR_CURSOR_CTRL],=0A=
+                                  AST_CR_CURSOR_CTRL, ENABLE);=0A=
+=0A=
     /*=0A=
      * GR05 bit 6 selects the mode 13 shift mode, which is packed pixel li=
ke=0A=
      * the extended modes. Without it the common code picks its planar=0A=
@@ -208,6 +242,164 @@ static void aspeed_vga_get_params(VGACommonState *vga=
,=0A=
     params->hpel_split =3D false;=0A=
 }=0A=
 =0A=
+static bool aspeed_vga_cursor_geometry(AspeedVGAState *s, uint32_t *x,=0A=
+                                       uint32_t *y, uint32_t *xoff,=0A=
+                                       uint32_t *yoff, uint32_t *addr)=0A=
+{=0A=
+    VGACommonState *vga =3D &s->vga;=0A=
+    bool is_cursor_enable;=0A=
+=0A=
+    is_cursor_enable =3D FIELD_EX8(vga->cr[R_AST_CR_CURSOR_CTRL],=0A=
+                                 AST_CR_CURSOR_CTRL, ENABLE);=0A=
+=0A=
+    if (!aspeed_vga_ext_enabled(s) || !is_cursor_enable) {=0A=
+        return false;=0A=
+    }=0A=
+=0A=
+    *x =3D vga->cr[R_AST_CR_CURSOR_X_LO] |=0A=
+         (FIELD_EX8(vga->cr[R_AST_CR_CURSOR_X_HI], AST_CR_CURSOR_X_HI, X) =
<< 8);=0A=
+    *y =3D vga->cr[R_AST_CR_CURSOR_Y_LO] |=0A=
+         (FIELD_EX8(vga->cr[R_AST_CR_CURSOR_Y_HI], AST_CR_CURSOR_Y_HI, Y) =
<< 8);=0A=
+    *xoff =3D FIELD_EX8(vga->cr[R_AST_CR_CURSOR_XOFF],=0A=
+                      AST_CR_CURSOR_XOFF, OFFSET);=0A=
+    *yoff =3D FIELD_EX8(vga->cr[R_AST_CR_CURSOR_YOFF],=0A=
+                      AST_CR_CURSOR_YOFF, OFFSET);=0A=
+    /*=0A=
+     * cursor pattern address, D[10:4] in CRC8, D[18:11] in CRC9 and=0A=
+     * D[25:19] in CRCA. D[3:0] are not stored, so it is 16 byte aligned.=
=0A=
+     */=0A=
+    *addr =3D ((uint32_t)FIELD_EX8(vga->cr[R_AST_CR_CURSOR_ADDR0],=0A=
+                                 AST_CR_CURSOR_ADDR0, ADDR) << 4) |=0A=
+            ((uint32_t)vga->cr[R_AST_CR_CURSOR_ADDR1] << 11) |=0A=
+            ((uint32_t)FIELD_EX8(vga->cr[R_AST_CR_CURSOR_ADDR2],=0A=
+                                 AST_CR_CURSOR_ADDR2, ADDR) << 19);=0A=
+=0A=
+    return *addr + ASPEED_VGA_CURSOR_SIZE <=3D vga->vram_size;=0A=
+}=0A=
+=0A=
+static void aspeed_vga_cursor_invalidate(VGACommonState *vga)=0A=
+{=0A=
+    AspeedVGAState *s =3D container_of(vga, AspeedVGAState, vga);=0A=
+    uint32_t addr =3D 0;=0A=
+    uint32_t xoff =3D 0;=0A=
+    uint32_t yoff =3D 0;=0A=
+    uint32_t x =3D 0;=0A=
+    uint32_t y =3D 0;=0A=
+    bool on;=0A=
+=0A=
+    on =3D aspeed_vga_cursor_geometry(s, &x, &y, &xoff, &yoff, &addr);=0A=
+=0A=
+    /*=0A=
+     * Moving the cursor dirties no VRAM, so repaint both bands here: wher=
e=0A=
+     * it was, to erase it, and where it is now, to draw it.=0A=
+     */=0A=
+    if (s->last_cursor_on) {=0A=
+        vga_invalidate_scanlines(vga, s->last_cursor_y,=0A=
+                                 s->last_cursor_y + ASPEED_VGA_CURSOR_SIDE=
);=0A=
+    }=0A=
+    if (on) {=0A=
+        vga_invalidate_scanlines(vga, y, y + ASPEED_VGA_CURSOR_SIDE);=0A=
+    }=0A=
+=0A=
+    s->last_cursor_on =3D on;=0A=
+    s->last_cursor_y =3D on ? y : 0;=0A=
+}=0A=
+=0A=
+/* Source-over blend of one 8 bit color channel with a 4 bit alpha */=0A=
+static uint32_t aspeed_vga_blend_channel(uint32_t under, uint32_t over,=0A=
+                                         uint32_t alpha)=0A=
+{=0A=
+    return (under * (15 - alpha) + over * alpha) / 15;=0A=
+}=0A=
+=0A=
+static void aspeed_vga_cursor_draw_line(VGACommonState *vga, uint8_t *d,=
=0A=
+                                        int scr_y)=0A=
+{=0A=
+    AspeedVGAState *s =3D container_of(vga, AspeedVGAState, vga);=0A=
+    uint32_t *dst =3D (uint32_t *)d;=0A=
+    const uint8_t *row;=0A=
+    uint32_t screen_x;=0A=
+    uint32_t under;=0A=
+    uint32_t out_r;=0A=
+    uint32_t out_g;=0A=
+    uint32_t out_b;=0A=
+    uint32_t addr;=0A=
+    uint32_t xoff;=0A=
+    uint32_t yoff;=0A=
+    uint32_t cols;=0A=
+    uint32_t col;=0A=
+    uint16_t px;=0A=
+    uint32_t x;=0A=
+    uint32_t y;=0A=
+    uint32_t a;=0A=
+    uint32_t r;=0A=
+    uint32_t g;=0A=
+    uint32_t b;=0A=
+    bool argb;=0A=
+=0A=
+    /* nothing to draw: the cursor is off or outside VRAM */=0A=
+    if (!aspeed_vga_cursor_geometry(s, &x, &y, &xoff, &yoff, &addr)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* this scan line is above or below the cursor */=0A=
+    if (scr_y < y || scr_y >=3D y + (ASPEED_VGA_CURSOR_SIDE - yoff)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* the cursor is off the right edge of the screen */=0A=
+    if (x >=3D vga->last_scr_width) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* xoff hides the leftmost columns of the bitmap */=0A=
+    cols =3D ASPEED_VGA_CURSOR_SIDE - xoff;=0A=
+=0A=
+    /* the screen edge hides the rightmost columns */=0A=
+    if (x + cols > vga->last_scr_width) {=0A=
+        cols =3D vga->last_scr_width - x;=0A=
+    }=0A=
+=0A=
+    argb =3D FIELD_EX8(vga->cr[R_AST_CR_CURSOR_CTRL],=0A=
+                     AST_CR_CURSOR_CTRL, FORMAT_ARGB4444);=0A=
+=0A=
+    /* the bitmap row for this scan line, past the rows yoff hides */=0A=
+    row =3D vga->vram_ptr + addr +=0A=
+          (uint64_t)(yoff + scr_y - y) * ASPEED_VGA_CURSOR_PITCH;=0A=
+=0A=
+    for (col =3D 0; col < cols; col++) {=0A=
+        screen_x =3D x + col;=0A=
+        px =3D lduw_le_p(row + (xoff + col) * 2);=0A=
+        r =3D ((px >> 8) & 0xf) * 0x11;=0A=
+        g =3D ((px >> 4) & 0xf) * 0x11;=0A=
+        b =3D (px & 0xf) * 0x11;=0A=
+=0A=
+        if (!argb) {=0A=
+            /*=0A=
+             * AND clear draws the color. AND set leaves the pixel alone,=
=0A=
+             * or inverts it when XOR is set.=0A=
+             */=0A=
+            if (!(px & CURSOR_MONO_AND)) {=0A=
+                dst[screen_x] =3D rgb_to_pixel32(r, g, b);=0A=
+            } else if (px & CURSOR_MONO_XOR) {=0A=
+                dst[screen_x] =3D ~dst[screen_x] & 0xffffff;=0A=
+            }=0A=
+            continue;=0A=
+        }=0A=
+=0A=
+        a =3D px >> 12;=0A=
+        if (!a) {=0A=
+            continue;=0A=
+        }=0A=
+=0A=
+        under =3D dst[screen_x];=0A=
+        out_r =3D aspeed_vga_blend_channel((under >> 16) & 0xff, r, a);=0A=
+        out_g =3D aspeed_vga_blend_channel((under >> 8) & 0xff, g, a);=0A=
+        out_b =3D aspeed_vga_blend_channel(under & 0xff, b, a);=0A=
+        dst[screen_x] =3D rgb_to_pixel32(out_r, out_g, out_b);=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint8_t aspeed_vga_vgamem_size_reg(uint32_t vram_size_mb)=0A=
 {=0A=
     switch (vram_size_mb) {=0A=
@@ -384,6 +576,8 @@ static void aspeed_vga_realize(PCIDevice *dev, Error **=
errp)=0A=
     vga->get_params =3D aspeed_vga_get_params;=0A=
     vga->get_resolution =3D aspeed_vga_get_resolution;=0A=
     vga->is_blanked =3D aspeed_vga_is_blanked;=0A=
+    vga->cursor_invalidate =3D aspeed_vga_cursor_invalidate;=0A=
+    vga->cursor_draw_line =3D aspeed_vga_cursor_draw_line;=0A=
     vga->big_endian_fb =3D false;=0A=
 =0A=
     vga->con =3D qemu_graphic_console_create(DEVICE(dev), 0, vga->hw_ops, =
vga);=0A=
-- =0A=
2.53.0=0A=


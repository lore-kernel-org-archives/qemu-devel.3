Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30672C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOK-0007WL-6c; Tue, 22 Sep 2026 05:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOH-0007VQ-NZ; Tue, 22 Sep 2026 05:02:17 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOF-0002BR-HF; Tue, 22 Sep 2026 05:02:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnbnRmGNcCCRj7ylRWXZNR8lu4tLSZw/LQD1Vc4kwC7QF2RlIkN+PiMQYT9PR7/1yQVuX11XIv2DdPnRBjWa/2UmmMi3XZstIaBcW/8y3gzwQNBVh3MGE2H3c3fswaJhyy7LDX/R0muzVuXu4j7fWjMO8XcenKQXQaxJ9jnv8GpWfXvWR2AR53/3Ai9ScRnxif2g1/gMyoYKtM16zAV3LqCiMFqCs6qZVEbIQLELsWcWggqQDfN0oi8ssvlkMPG84lWpkJnKx6Ue2dD/9FXH2LITRvSpr+Kfv4/SNl0dN/4Gs6tIXJb9IhyLmlwjbpYdhTAMvV2+Dj05n/8+oa0AQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVS4QuGgy7PA8PCPabNqcnmC9cfPR2yypY1pSHo2NMA=;
 b=g4ya4FDoss+drbNOratadReAWrrPd2rfJt0YC3bHVBXepHFvB3VLur5HL6Uim2BNv7qt+1QRIx09KkgN02mm/iZqvOUjpFzfmpsEb1lbHbf0jR5rrKEvTMs26SVcV9HI5vy4esKgsMJ1MzKMPuPIcduxr8mx7nS1qaXCCr6DUCSAIBFC3aIp94UHnonVDvicOwPL9hcwotAKLVpIP4lJ4Jl/sOCNzN8PQ735DSLB2ZqvdH3LQFaQ4kVU5maHVQl6jbb7JSkj1LqVWZmpjkBsQ5xMrUpXAT2QMr5SSVmMlysUKeUDZ1m/Uy8yTsav+L5jVg5akbtdgi3yuXYF6GWPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVS4QuGgy7PA8PCPabNqcnmC9cfPR2yypY1pSHo2NMA=;
 b=ehpSi+Ji1PjxR/whkvQMLbSTxJQBls3vGR3MJhQA2DNh3ITcggxqKZ9wReHl9iYgPdwkEECTyg1626jkPZ3XTQcOu59XCHAJhRs8+KczUQ3FqFiTgrTqVbDIVP4bGcsces1xtN42Q032Shsk8U0llyCO9MUUFqGQX857RIUqjeSFkGSzlD62DEFrT/jUDMe0dd/qWTR4mwmCdwh+jyx9ftNk2+/4WZVM5TokBVcbMptlaThhitBE5XZ9oR1os7BFtJ5GC7lFcRwVZVWv/hfn4B/WJnOgKa2GBQYCIdhQ0wppa0Q+Hk2CDkcHrzhUu+aKDrlnyOq2aBzM3Hdl9iOZjw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5090.apcprd06.prod.outlook.com (2603:1096:4:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 09:01:59 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:01:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 02/19] hw/usb/redirect-server: Add a usbredir server device
Thread-Topic: [PATCH v1 02/19] hw/usb/redirect-server: Add a usbredir server
 device
Thread-Index: AQHdSnEFna6GqnvWPU+v45ByS774Dg==
Date: Tue, 22 Sep 2026 09:01:58 +0000
Message-ID: <20260922090154.1792077-3-jamin_lin@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI2PR06MB5090:EE_
x-ms-office365-filtering-correlation-id: 0b5d63dd-ad5c-4bfd-2da8-08df18882943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|5023799004|3023799007|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: AT7neoE/rsOVn0PwnPvroPyq8Eias+Sh9/AI6sHdgkIBt+FilHuuKm1BWW7WkpnC2gUXyPWxXsimLOy42N67DLM3H9qRGCTbjrrnSWaJM4AmIk8XPlmFP9QsQESgIAKosVAowOwrRBZLXtBywq+sy5PLMhrqYQjPwqJbXOteFUXe5knXisRq46WSCjffcJja1ryX/sC58Ec88rfwn2qR9PoY6BVNlWdJqnGIXJGsmwToD4t4VmhOB9+AcZAB9TjZPSH/utksGpcbALz4xj1dULysTcWj2el8aR2uQ287zfiqm5cQZzpGurqViabJa2ro7d2gZdz3J99t9/RtdSU3wo4FYGaRZs72aAUpa721mCiGg/vMAUHzrBBbN2TrDQxVd7jYC6p2OvtDuevYUB/LKumYSaghk/xYzNHojjCoV+xQyYu4OvYWZqdwDHQtiQ8CmGLyxZK2CZNfg54qQRWDZfhlEM4wxk6DwItQ1ADhlnnx+jw56ANXKydyv6gphoH20VJeydocz5a1quJFU10OWcxaFcvvflVl+49aA8qEmHe4Xri3939DpT7m06sOpkacnRqfZk6jKMt9F/KKnstBVsGM587pHPU1+SgiYQ9VOKABTnIin1dnmTKRglJKz/CXeftDd/mKykvHBqnwmJ9vVjTjEC+muOpA29OGueFv7in4J8NpTzZKZ/mwfMfWdkXv3Ok9MpQjC1bSxirpCH68kY6Iif3J0g9I9SAhr67L2ZY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(5023799004)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5lCv4FTyE0EJkjOxz6QmwcKgJJYqr+fa9xqFnTgoKYiTy5bYHMYlh9dbI9?=
 =?iso-8859-1?Q?ovFkyZTqc5Dd62Pv+cC7D8TQ+GKmIgMrVJ5mFuHQk/lpad2YBTuiMGgpbP?=
 =?iso-8859-1?Q?rSup0/wNEh6cPtBHKcEub1YqBfEd8ylxGM+xwNu1+nrzPPSj3bxyt6qB5g?=
 =?iso-8859-1?Q?Makxy9mgrnRR5bmp/uJa9xsWzY/y/5p0i5doo3OA0byHAEo7vbrOjmS/OT?=
 =?iso-8859-1?Q?deLuJGlfg27sPxdmd8NAakurbmzwGfMeknpGUvguoyV5kGBb1SRYFOgao5?=
 =?iso-8859-1?Q?+qQVRoqxeMB0kfPohcdoyKaLa+eclLdbWvLyrJEqVNzKipFFTEjwbo1Ecg?=
 =?iso-8859-1?Q?4ePhqT0b8PMjyU3OcAgf/1IBalMAvDhe4Vn2qyymSYXCJO4LhVtrMwr80H?=
 =?iso-8859-1?Q?1h9JBEbIMp3clt1ucY3ArpjT6SLNloAagDMotWYMqMJxPKb3N8ErWZNzPh?=
 =?iso-8859-1?Q?Qecp/6AodLWr2WeQ+isAgO7uKYROG90q5+f3OcJGCuaQnQAwsEewxIvUnc?=
 =?iso-8859-1?Q?rQdlxliLspON8/B8tAupnxjGbjkOW8dvHm6w6t5ythx4CmTb63UfW5RV8k?=
 =?iso-8859-1?Q?7p+nSWYYdHswss39p+j08pTfQdE33ihTlQqYqwslGbaV8zjzN3PP2hehGG?=
 =?iso-8859-1?Q?f4BWb9/OS3MR6kWliBiQw9hjGpMAOhX3zE4Y1R/OIhcU0ZQU2INJtji/WM?=
 =?iso-8859-1?Q?xG8GfyhT5gsxhSD15331Khc45MMvDcvpb8nM8xhCqFtxI3Ua2HY8sfy297?=
 =?iso-8859-1?Q?i66U4PNfmBd5ig3EzS7+4lW59DJlzeM30AgUGti5FZ6CKhji4+J0gXQ3kx?=
 =?iso-8859-1?Q?BsPhxSCLbbg3gNO+oXtpB3vLjyVB9rMpSS6E5reKe2KV7PrOp1tOvmwIZ9?=
 =?iso-8859-1?Q?JLphHWnwDOnKglo4OM7ob5tCpOnTmYTasU9ABiWAXYNQz79HfuZ0ZRo9Nd?=
 =?iso-8859-1?Q?3Uur3sTg7ECIHRRXti3z2sM1Tg3ah/2SNRwO/GdMYGVHSZvxalfcWHXKw1?=
 =?iso-8859-1?Q?f8JHMM1FvnwpXCjqeT5MYCNaH6C2rPcMikrg6jvKHMjBZ/uO6xNWpRuDwI?=
 =?iso-8859-1?Q?DU+l2yMdNG4LK75l7C1BLZuSpbBrgBFG6WWFq2QdLJTAi2/7ijU8Cen7jC?=
 =?iso-8859-1?Q?ArqoFMzvFaZrOQilNgD2HIZ62fnn3k3fdhiSWSGuA2pbyAIIBAoznhoIMS?=
 =?iso-8859-1?Q?nyLLsGLxRMN11HUdEigSEMsT6NvrBK1atM6zM1s1qo6jX2UPH211rXXrY1?=
 =?iso-8859-1?Q?FYrEzMd81pZf7flkK7rHfsXIcZQ6S0AKbnXNySG9mWAEEhUQHTeDKh1AyL?=
 =?iso-8859-1?Q?RoAHpMEBfjsqyb7K7kwRn0Lm2xG2Ctw6VRSj+80k+LqDCdvaE6W1ZS51EB?=
 =?iso-8859-1?Q?USBn5cd7OOi5nbC81zwCfcfctboz0YHfYt+gaePGyOTlcW6DYCRotdUQkW?=
 =?iso-8859-1?Q?nVT+NKkMam7JSirQZexBDkGn7ghxPooBx1l7oW2veLLyTpaFT3ssPZl5uI?=
 =?iso-8859-1?Q?DmVg8JWgmBxVjy9QoBPAjFjRPPflF7CIP4yktvUp0hxRSeUGQ2AwJr4M9e?=
 =?iso-8859-1?Q?UocFNOXCyZLbbXnN1KROiR3qrJg2ZDl+SE5C+nHeLReST30woocHL8PSIc?=
 =?iso-8859-1?Q?uE0nyQnavi34xWZWeLAI6ojM2rYIBbpP6PZabp6MahWOKw8o9NRzHhQatE?=
 =?iso-8859-1?Q?yVBkYtNf9lfD6mMqNWsQCaw7hlD0GGpOKdy4ZUfWGxUDt4XxUUKQdWTwRf?=
 =?iso-8859-1?Q?PDcEu7O6ju55cCZ1pLsgyhp1hcGDEBz/OT0NpC8FJM4FoP7+fAA/GyPC1R?=
 =?iso-8859-1?Q?72Q7GJuGYw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yCHMy103+aEgIe15XW51oUoapIgRcAYhQ7XR3GmV5Ey/G0DRDlsMafIEaQ9Yy7Tv48/2N+c2GHc0bCxt5NBAuDs0LpWjcv6DmLGNIA8JiTDSIajsXMxMzmsiXOPpIW16Cdyb4SiDg4r9jhO1SOQTqATJlcroLwa9uTEJHbxknDvcXHglQim4RZEHEOLjljhOR9NSwHtxFycD2e7ll1w3l1JOZVeMdWzC31uwTQ9Iv9nfY9q8DZRBrzCeX/yACKOvQLSHcNJjf20dCrt8J7odD+fjz4+zpZEn2TzpzOSeNV5/jsrojZTyGFuABypgWeRImNqO0jE6nvQvNh5O+Hq5GQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5d63dd-ad5c-4bfd-2da8-08df18882943
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:01:58.2092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WBqWDAT9to8UeB2rDBFrACT/Ncimg5gupUM9IbMTdPXy3vTqc9illYLDGulyX70jBVoShimpPBpg3MFluNHkEg5VV6xkrtAsNdJLE/BbAdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5090
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

Add "usb-redir-server". It exports a USB device from this QEMU to a USB=0A=
host in another QEMU, using the usbredir protocol. The other side is the=0A=
existing "usb-redir" device.=0A=
=0A=
The exported device is plugged in with "-device <dev>,bus=3D<id>.0". So we=
=0A=
have to provide a USB bus. To find that bus, qdev starts at the main=0A=
system bus and walks down the tree. A device that is not on a bus is not=0A=
in the tree, so the bus it provides cannot be found. We have to sit on=0A=
the main system bus. That makes this a sysbus device, even though it has=0A=
no MMIO and no IRQ.=0A=
=0A=
usbredir carries one device, not a bus. A hub cannot be exported because=0A=
the protocol has no device address field, so only the device on the=0A=
first port is redirected. To export several devices, run one=0A=
usb-redir-server per device, each with its own chardev.=0A=
=0A=
The link to the remote host is a chardev, so this device cannot be=0A=
migrated. Its VMStateDescription says so with unmigratable.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/redirect-server.h |  27 +++++++=0A=
 hw/usb/redirect-server.c         | 130 +++++++++++++++++++++++++++++++=0A=
 hw/usb/meson.build               |   3 +-=0A=
 3 files changed, 159 insertions(+), 1 deletion(-)=0A=
 create mode 100644 include/hw/usb/redirect-server.h=0A=
 create mode 100644 hw/usb/redirect-server.c=0A=
=0A=
diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-ser=
ver.h=0A=
new file mode 100644=0A=
index 0000000000..e81d4e0608=0A=
--- /dev/null=0A=
+++ b/include/hw/usb/redirect-server.h=0A=
@@ -0,0 +1,27 @@=0A=
+/*=0A=
+ * USB redirector, server side=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef HW_USB_REDIRECT_SERVER_H=0A=
+#define HW_USB_REDIRECT_SERVER_H=0A=
+=0A=
+#include "hw/core/sysbus.h"=0A=
+#include "hw/usb/usb.h"=0A=
+#include "qom/object.h"=0A=
+=0A=
+#define TYPE_USB_REDIR_SERVER "usb-redir-server"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
+=0A=
+struct USBRedirServer {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    /* USB bus */=0A=
+    USBBus bus;=0A=
+    USBPort port;=0A=
+};=0A=
+=0A=
+#endif /* HW_USB_REDIRECT_SERVER_H */=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
new file mode 100644=0A=
index 0000000000..5f365f0a35=0A=
--- /dev/null=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -0,0 +1,130 @@=0A=
+/*=0A=
+ * USB redirector, server side=0A=
+ *=0A=
+ * Copyright (c) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ *=0A=
+ * Exports a locally emulated USB device to a remote USB host over the=0A=
+ * usbredir protocol, so a device emulated in one QEMU instance can be=0A=
+ * enumerated by a host controller emulated in another one.=0A=
+ *=0A=
+ * Architecture. The left column is a request going to the device. The=0A=
+ * right column is the answer coming back. The middle hop carries=0A=
+ * usbredir messages over a socket. The top and bottom hops carry=0A=
+ * USBPackets inside QEMU.=0A=
+ *=0A=
+ *     remote QEMU: guest driver -> EHCI/XHCI=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     "usb-redir" (the client)=0A=
+ *              |                     ^=0A=
+ *     usbredir |   chardev socket    | usbredir=0A=
+ *              v                     |=0A=
+ *     usb-redir-server (the server, this file)=0A=
+ *              |                     ^=0A=
+ *    USBPacket |                     | USBPacket=0A=
+ *              v                     |=0A=
+ *     any USBDevice, "-device <dev>,bus=3D<id>.0"=0A=
+ *=0A=
+ * "usb-redir" (hw/usb/redirect.c) is the client:=0A=
+ *   - it takes a USBPacket from the remote guest and writes it to the=0A=
+ *     socket as a usbredir message=0A=
+ *   - it reads the answer from the socket and completes the USBPacket=0A=
+ *=0A=
+ * This file is the server. It does the same thing, but backwards:=0A=
+ *   - it reads a usbredir message from the socket and runs it as a=0A=
+ *     USBPacket on the bus below=0A=
+ *   - it takes the result of that USBPacket and writes it back to the=0A=
+ *     same socket as a usbredir message, for the client to read=0A=
+ *=0A=
+ * A USB device has to sit on a USB bus, and in QEMU a USB bus is always=
=0A=
+ * made by a host controller. So this file makes one and acts as the=0A=
+ * host controller on this side. It models no real chip: its cable is=0A=
+ * the chardev socket. The real host is in the other QEMU.=0A=
+ *=0A=
+ * usbredir carries one device, not a bus. A hub cannot be exported:=0A=
+ * the protocol has no device address field. To export several devices,=0A=
+ * run one usb-redir-server per device, each with its own chardev.=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/module.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "hw/usb/redirect-server.h"=0A=
+=0A=
+/*=0A=
+ * USB port ops=0A=
+ */=0A=
+=0A=
+static void usbredir_server_port_child_detach(USBPort *port, USBDevice *ch=
ild)=0A=
+{=0A=
+    /* We only export the device on our own port. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_port_wakeup(USBPort *port)=0A=
+{=0A=
+    /* We do not pass remote wakeup to the host. Nothing to do. */=0A=
+}=0A=
+=0A=
+static USBPortOps usbredir_server_port_ops =3D {=0A=
+    .child_detach =3D usbredir_server_port_child_detach,=0A=
+    .wakeup =3D usbredir_server_port_wakeup,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * USB bus ops=0A=
+ */=0A=
+=0A=
+static USBBusOps usbredir_server_bus_ops =3D {=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Device registration=0A=
+ */=0A=
+=0A=
+static void usbredir_server_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+=0A=
+    /* One port: usbredir carries a single device. */=0A=
+    usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
+    s->bus.no_auto_hub =3D true;=0A=
+    usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
+                      USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
+                      USB_SPEED_MASK_HIGH);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The link to the remote host is a chardev, and we cannot migrate=0A=
+ * that. So this device cannot be migrated either.=0A=
+ */=0A=
+static const VMStateDescription vmstate_usbredir_server =3D {=0A=
+    .name =3D TYPE_USB_REDIR_SERVER,=0A=
+    .unmigratable =3D 1,=0A=
+};=0A=
+=0A=
+static void usbredir_server_class_init(ObjectClass *klass, const void *dat=
a)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+=0A=
+    dc->desc =3D "USB Redirection Server";=0A=
+    dc->realize =3D usbredir_server_realize;=0A=
+    dc->vmsd =3D &vmstate_usbredir_server;=0A=
+    set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+}=0A=
+=0A=
+static const TypeInfo usbredir_server_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_USB_REDIR_SERVER,=0A=
+        .parent =3D TYPE_DYNAMIC_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(USBRedirServer),=0A=
+        .class_init =3D usbredir_server_class_init,=0A=
+    },=0A=
+};=0A=
+module_obj(TYPE_USB_REDIR_SERVER);=0A=
+module_kconfig(USB);=0A=
+=0A=
+DEFINE_TYPES(usbredir_server_types)=0A=
diff --git a/hw/usb/meson.build b/hw/usb/meson.build=0A=
index d4ba60a91c..8e95cc7b74 100644=0A=
--- a/hw/usb/meson.build=0A=
+++ b/hw/usb/meson.build=0A=
@@ -77,7 +77,8 @@ endif=0A=
 if usbredir.found()=0A=
   usbredir_ss =3D ss.source_set()=0A=
   usbredir_ss.add(when: 'CONFIG_USB',=0A=
-                  if_true: [usbredir, files('redirect.c', 'quirks.c')])=0A=
+                  if_true: [usbredir, files('redirect.c', 'quirks.c',=0A=
+                                            'redirect-server.c')])=0A=
   hw_usb_modules +=3D {'redirect': usbredir_ss}=0A=
 endif=0A=
 =0A=
-- =0A=
2.53.0=0A=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E52CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5bM-0006Y7-19; Sun, 11 Oct 2026 22:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5av-0006Ox-Ju; Sun, 11 Oct 2026 22:16:53 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5at-0004ly-Gq; Sun, 11 Oct 2026 22:16:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auRjSYTyMo7Ti38weilf4sQlFkLZ++EcsoDyzlSJrAwdkvlqAdNqW4cjN8C+aFh2Wv4eAvh4i0VGQW8cNQE04dxQL/l+jVTrBc6OMGxCRNzM4BQpjcxSh0JD0ekC2QAamyYCpw6PDWa93Z7LEMApB/UVAQOvAbK8DUdbm2dHS6badAQWrsrE4pQ1adetFlGFh2v9k6GNjpVoAxBxoxfnxjI7RJDYHYnjH9CdqZFMtR8XR3xPIEOPXzI6QPYqh9agenQXWF/zE+txc1RRMpvSyexodgVZLCg+1OGSyETBt9hs5Lt/SOT6jDHQjjjf5/Bp2CETREZ/6u+VdAo5H2wwKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYjFuXvjgT+4HDk7m8V5A56R14cS91nI7cjYyMORBeM=;
 b=ihFZg1o8FhXXCOhWrIZfD+8LMLlYsM8OFXoWl/dy/zmM7knh5MPDJtb8Qi5+jiqAf+SQwtqA5VJdBvdFlRxskZY6EzouL93pYsDKjWdll0VNQf5N83ytjcTtednSpFsMsJFhWuTTWQ3DrSMbptXEu7IiF11HBDVStIx5VQ5YTOSJsGz8c5tOwDPMr1z0ImKsHchFe7lqCo1MwxFRybf3s1EHloBy0H+QiDrN7q21DCYVQrpiRh7lpZ2FCNNLUPudaRj+9yFZ2sCr9uSQ75fFrn21BL0/xVMXe05VYk2HmRsPeD5VD5gR9ok2zcteKa+rgI36G/lE907aF6VW1/j3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYjFuXvjgT+4HDk7m8V5A56R14cS91nI7cjYyMORBeM=;
 b=hLly4Q47QhvD125T1vstcnaIySZ6msRQUzNOXYiZDsEOue84QRPyxYDWmEoEATHkqSiekKyoW52m5PFUu9S2UUASMoMjttjPLah4BdlNJoQGKsfPnAU7aqqH1xPyikvfoCICzFWd4eambIcdenjWugpCd+kBNXCRLIXmQxvNj2rzl+B4FiSty31vgoRZmuT2/U5+3Wi2ZEpPtgEZIou273UQeMXzUbAFSXiZq327wPE3rziEA1viXOMLeNqvH2UCKKg0LuDtb9ghbj+QYz/cRF2jy5YfiDk1k4JucysZgI17kpyChZMHUQjtzoDgwcCA2kCvJ2z5vuFbYH9PYPsCJA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5398.apcprd06.prod.outlook.com (2603:1096:101:8f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 02:16:39 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:16:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 3/8] hw/usb/redirect-server: Connect usbredirparser to a
 chardev
Thread-Topic: [PATCH v3 3/8] hw/usb/redirect-server: Connect usbredirparser to
 a chardev
Thread-Index: AQHdWe+2fCYo1OYxrkKue7biRfYCSw==
Date: Mon, 12 Oct 2026 02:16:39 +0000
Message-ID: <20261012021634.2006424-4-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5398:EE_
x-ms-office365-filtering-correlation-id: aebffbbf-2b10-44c2-85bb-08df2806d969
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|10067099003|3023799007|261009223027099003|5023799004|38070700021|56012099006;
x-microsoft-antispam-message-info: i+6Fj/mreS4qFJiPDWA/zgb/UlwuBcQAqVesWpO06jE8vX6cQIJVKxVcsf1rEdRGyDWPHh59+fIsrF2x1emApApBvJdhcSzfGAzr0KS9ufuRCEyHVIF3s/kzFV+VwO8DFnLQ0OQviUQ95HtKyyMy0rO5A56lEC+6wmPgoQWh3AIpGjj4o9wr7aCe0mWJV8Q2nSMBnOsEPsT+aq3kkGujT6f/1Xk1Zted+c+Ho3t4z3ZuOwlYfZCywFgn0iq2XtxQLK7szlLh63RDIEeu2jpdC0MItj41G6qhyeKwHgM9Xs2RwhpaGI6UMTV/WfsPHjm2LPt9UV4VaBBtief7OlyzvNoAYIFXvYkJ0L7YdTKt0IxgmPOOCxWqwP5bG5ybN6A2jiJCK2iAua91tMrCLhaUuxS1fiWWGDtmjH6n9++6F/Fp56KUzr1n+RRHb2L/qhARwbkUi0hj9YkmHa261WgKCgWJ8kPry0jzrhLjaM28H01hUpEX0ix4j1MKfopvyEiA9CnVBdN4P9ZDyfWm3W6jFZM+bAk1yHBf83Ns9n91uvBooQFjYQ4ObLk7yQ1aIheu1dDRchd9eWuQh4pCc7TJEOAZYYgN+qM91p3f5HaiCRMdwdYLN5Q/ov4H8zroa/De2SZb47GXDnLz4y57rxfVL5W76+Y6nwYS6SEYQWyVFu/oNB7EcIf00Y/o1FAMFCP5aBRE4Tfa2DedFRMgBebO3D3xGVdS/2dLKlf55N2DgO4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(261009223027099003)(5023799004)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qhPilfqj8vj6W2kH6oIMTdYaRpYsEwNHodfGrte12d9CqJDMG4BXkAcfj6?=
 =?iso-8859-1?Q?6zhATz4qac3SKp6YotR21Qp6nIJkv3rVSvogpA5i8gMqunDTrD5xs/M1PO?=
 =?iso-8859-1?Q?1N3sxidYEQ2bj3OOEy9IN567+8cbOdQ+pecuycWrrSipkRJ9fs2E+6jNoK?=
 =?iso-8859-1?Q?so/FKdpr+RVZkerxGGIUIVPv0ou1SocbDn9i4535pCC6R+O44KMI05Mrn4?=
 =?iso-8859-1?Q?fVo9cYBwayq+UROgr2nuxrUukB+gMvQYONXYwEGlM7FUfzlflOgb1JllEi?=
 =?iso-8859-1?Q?CuVKz6Ikj3TMSncJPz9yCfN8U1l+ds6MP49JI4HC9MScdIqkAeubjpuCpl?=
 =?iso-8859-1?Q?uV2bk/uZwNxTOPQE3VS2Sfj50C0ayoTui8IuKRstlSa27lFFyYKJgvXJXU?=
 =?iso-8859-1?Q?3zyePekOl9RSq+/OOoNshdKaIOOUPBeW+MvXDG30oJvkROSPMHj2T/LHVc?=
 =?iso-8859-1?Q?JTACfRc8ZTTO9B80xTb1s5BuP4uCzDtuYs5g3K4eRL6A4bR3A5yNMSCeLg?=
 =?iso-8859-1?Q?3+P+gfFquTQUgxgzlxLb1Ad/rSFefyqwTlX9/p8KhTopPfurKOd0jWIzOg?=
 =?iso-8859-1?Q?yFpoid67SrHxTAHtcI2VRRKlCkrtMh/mV7kwgyxj4CSfL1ng4BZLI7P5bt?=
 =?iso-8859-1?Q?3KZGzaFDyb7+FM3UWSWpssg+Wv+l3uP5WVQBXdjQ5p0GyjYxCLD88v4zFg?=
 =?iso-8859-1?Q?vX6BG3qYKEkI66WfXYMeyXc0DHJGwadTjBPXHfbLLfhwbXbmqWz9l/dj+D?=
 =?iso-8859-1?Q?x4DHP51qyQ+ZNy1nyHC/Qx0cxJMNxNnpYhVxqtX8qWUHZAz5wfZuKnTejH?=
 =?iso-8859-1?Q?J1ZFn/nmWPpet5BjNDh8LkarWnh90p1SLYc9/pIrFViLq7fqzxNfTLmOeI?=
 =?iso-8859-1?Q?f96HbM00Va7Dn9X6c97CWDx4j1nLnEWUuZem0EIQhtEIz6bpejdvKfwHCP?=
 =?iso-8859-1?Q?nyrIvqZqRav03NBxb5b5EmE4QDu45iU6SAURYpc+X1+iO1jeYkSCLQKPSe?=
 =?iso-8859-1?Q?2vIqLnI8I2CcypttKJbblARsfk8jdkuinBsql4p5Bh0ggoKQUnNknfSdJ/?=
 =?iso-8859-1?Q?LwX3rLehzzmWCUCNm2ypnUvkAdpbGO0uzCPJgJWR9zFtoYX5ytI5df3AEK?=
 =?iso-8859-1?Q?dNJqrW9ltl89R4DZ9WlosTQ5z7qCcgPFc363IMa8QVvgMu3GbgaZkNwKmj?=
 =?iso-8859-1?Q?045F1RqwePyU49DMWZ6qgOfrngKATjJZWeUF3GUWUca2TmzC6e0x4QweBg?=
 =?iso-8859-1?Q?6VS4BjJjCwPBj4mn0w1gCcZsFG8Jx9Pl360XqRBk8dieb8GjLIwYbJO4o7?=
 =?iso-8859-1?Q?NbKKVD4tznsin62R8r4QgmXKWmT1RggPyawzY5905i+wluzml71T3f5mVb?=
 =?iso-8859-1?Q?0FI1nzeKuXK8vtSlF6cVq/LtuQGC13kZuo6OcgV66k7f80BqCVUwNjJ/Tx?=
 =?iso-8859-1?Q?gI8MyddJpdUeORbmGSMcFS6z2D87KB8HkgbGxjEfOAdkUWBFs0tDKzjsoI?=
 =?iso-8859-1?Q?/0B2s89apqOoNhhySdR7ILmXEP7UNQAf2HHveBWQZ0zfVAEd/huoVIgA9R?=
 =?iso-8859-1?Q?EK1460E8sBZPwDvs71vOjiCuO6LNfsAF4y0KXbTeSOnhiGly3Fg3608Lp4?=
 =?iso-8859-1?Q?4Xs017/va17TR2aQ9KmwRwjVF8EL+PVjVFRL7YtibpIso7OH5e2WbG772l?=
 =?iso-8859-1?Q?rO3umqz1Q/ecLhna6ofTtFyRg/gFv3jl/F79wc6lS+FS9awkP0rUytqWHd?=
 =?iso-8859-1?Q?TynjQqPL425TBGWYxAY/xJ57KH7y2RS1TCADO+q0Kgq9gSJA2milRtH3QX?=
 =?iso-8859-1?Q?GJj7T8mhvQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NZfpEOuq5Qww/gIHRnJ3EtRRSedr+l5e5WD7y7j+88nkgmu1vVs1cKXZd0RFWiV8ui0DEU08/JuRomyVE07k/g4+lXv5tl05gweCpoaphBoufoNRJmcc30fVNfPkgsOZFO6NmiiTDoPrECJL/3qy/1wJN1fmycrzLHCax7HfMu0XFkzMG/C4NDM4SU2683FocOCcr8Jidm5N0e5swlYmSrGI7zVaG/i98DfqhgCNvcWwmrBwNlk430LgIA3vxTNTm4hRgdnznNu09pUm9NONlVORKObT+6dwr4Etwl9LUYPCAYLmS/MwoZZGJdaxodxFxkoqRjxFVj+9emR4QV3X1g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebffbbf-2b10-44c2-85bb-08df2806d969
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:16:39.2021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvHMxXfVzqwURIY2/LagGt23siKAdG/xANIvFdJjbG7UYR+byasS/Ek6jqIag6mqZaf45dG7l9efGIAnr+4y95zKevcO+U9Evumi6WY1hRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5398
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Create a usbredirparser when the chardev opens. Feed it from the chardev=0A=
read handler. Destroy it when the chardev closes.=0A=
=0A=
The side that exports a device sets usbredirparser_fl_usb_host. This=0A=
side drives the device, so it is the USB host for it. redirect.c is the=0A=
other side and does not set the flag. The library uses it to decide=0A=
which direction a packet may travel.=0A=
=0A=
The chardev handling follows hw/usb/redirect.c: take no data before the=0A=
parser exists, do not write to a closed backend, do not re-enter the=0A=
writer, and let a close that is still queued finish before a new=0A=
connection opens.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 284 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   6 +=0A=
 2 files changed, 290 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index bc883add0e..a48b821642 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -50,22 +50,46 @@=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/units.h"=0A=
 #include "qapi/error.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
+#include "chardev/char-fe.h"=0A=
 #include "qom/object.h"=0A=
 =0A=
+#include <usbredirparser.h>=0A=
+=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "trace.h"=0A=
+=0A=
 #define TYPE_USB_REDIR_SERVER "x-usb-redir-server"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
 =0A=
+#define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VER=
SION=0A=
+=0A=
 struct USBRedirServer {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
     /* USB bus */=0A=
     USBBus bus;=0A=
     USBPort port;=0A=
+=0A=
+    /* Properties */=0A=
+    CharFrontend cs;=0A=
+=0A=
+    /* usbredir over the chardev */=0A=
+    struct usbredirparser *parser;=0A=
+    QEMUBH *chardev_close_bh;=0A=
+    const uint8_t *read_buf;=0A=
+    int read_buf_size;=0A=
+    bool in_write;=0A=
+    guint watch;=0A=
+    bool host_connected;=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -94,6 +118,232 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
 };=0A=
 =0A=
+/*=0A=
+ * usbredirparser I/O and logging callbacks=0A=
+ */=0A=
+=0A=
+static void usbredir_server_log(void *priv, int level, const char *msg)=0A=
+{=0A=
+    switch (level) {=0A=
+    case usbredirparser_error:=0A=
+        error_report(TYPE_USB_REDIR_SERVER ": %s", msg);=0A=
+        break;=0A=
+    case usbredirparser_warning:=0A=
+        warn_report(TYPE_USB_REDIR_SERVER ": %s", msg);=0A=
+        break;=0A=
+    default:=0A=
+        trace_usbredir_server_log(msg);=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static int usbredir_server_read(void *priv, uint8_t *data, int count)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    if (s->read_buf_size < count) {=0A=
+        count =3D s->read_buf_size;=0A=
+    }=0A=
+=0A=
+    memcpy(data, s->read_buf, count);=0A=
+=0A=
+    s->read_buf_size -=3D count;=0A=
+    if (s->read_buf_size) {=0A=
+        s->read_buf +=3D count;=0A=
+    } else {=0A=
+        s->read_buf =3D NULL;=0A=
+    }=0A=
+=0A=
+    return count;=0A=
+}=0A=
+=0A=
+static gboolean usbredir_server_write_unblocked(void *do_not_use,=0A=
+                                                GIOCondition cond,=0A=
+                                                void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    s->watch =3D 0;=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    return G_SOURCE_REMOVE;=0A=
+}=0A=
+=0A=
+static int usbredir_server_write(void *priv, uint8_t *data, int count)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int ret;=0A=
+=0A=
+    if (!qemu_chr_fe_backend_open(&s->cs)) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * Re-entry guard. The chain is:=0A=
+     *   do_write() -> this -> qemu_chr_fe_write() -> chardev feeds us=0A=
+     *   -> do_read() -> a callback -> do_write() again=0A=
+     *=0A=
+     * The second do_write() would walk the same buffer queue as the=0A=
+     * first. Returning 0 means "sent nothing", so the buffer stays for=0A=
+     * the outer one to send.=0A=
+     */=0A=
+    if (s->in_write) {=0A=
+        trace_usbredir_server_write_recursion();=0A=
+        return 0;=0A=
+    }=0A=
+    s->in_write =3D true;=0A=
+=0A=
+    ret =3D qemu_chr_fe_write(&s->cs, data, count);=0A=
+    if (ret < count) {=0A=
+        if (!s->watch) {=0A=
+            s->watch =3D qemu_chr_fe_add_watch(&s->cs, G_IO_OUT | G_IO_HUP=
,=0A=
+                                             usbredir_server_write_unblock=
ed,=0A=
+                                             s);=0A=
+        }=0A=
+        if (ret < 0) {=0A=
+            ret =3D 0;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    s->in_write =3D false;=0A=
+=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+/* The remote host greets us once the socket is up. */=0A=
+static void usbredir_server_hello(void *priv,=0A=
+                                  struct usb_redir_hello_header *hello)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    s->host_connected =3D true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Parser setup and teardown=0A=
+ */=0A=
+=0A=
+static void usbredir_server_create_parser(USBRedirServer *s)=0A=
+{=0A=
+    uint32_t caps[USB_REDIR_CAPS_SIZE] =3D {};=0A=
+=0A=
+    s->parser =3D usbredirparser_create();=0A=
+    if (!s->parser) {=0A=
+        error_report(TYPE_USB_REDIR_SERVER ": failed to create usbredirpar=
ser");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->parser->priv =3D s;=0A=
+    s->parser->log_func =3D usbredir_server_log;=0A=
+    s->parser->read_func =3D usbredir_server_read;=0A=
+    s->parser->write_func =3D usbredir_server_write;=0A=
+=0A=
+    /* Callbacks for messages the remote host sends to us */=0A=
+    s->parser->hello_func =3D usbredir_server_hello;=0A=
+=0A=
+    /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_ep_info_max_packet_siz=
e);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_64bits_ids);=0A=
+=0A=
+    /*=0A=
+     * In USB the host is the side that starts every transfer; a device=0A=
+     * only answers. The exported device sits on our bus and we issue=0A=
+     * its transfers, so for that device we are the host. That is what=0A=
+     * fl_usb_host means, and why the side that exports a device sets it.=
=0A=
+     *=0A=
+     * The other QEMU does not drive the device, it receives it. In this=
=0A=
+     * protocol that makes it the client, and redirect.c leaves the flag=
=0A=
+     * clear.=0A=
+     *=0A=
+     * Without it the library refuses to send device_connect.=0A=
+     */=0A=
+    usbredirparser_init(s->parser, USBREDIR_SERVER_VERSION,=0A=
+                        caps, USB_REDIR_CAPS_SIZE,=0A=
+                        usbredirparser_fl_usb_host);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_destroy_parser(USBRedirServer *s)=0A=
+{=0A=
+    s->host_connected =3D false;=0A=
+=0A=
+    g_clear_handle_id(&s->watch, g_source_remove);=0A=
+=0A=
+    if (s->parser) {=0A=
+        usbredirparser_destroy(s->parser);=0A=
+        s->parser =3D NULL;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_close_bh(void *opaque)=0A=
+{=0A=
+    usbredir_server_destroy_parser(opaque);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * chardev callbacks=0A=
+ */=0A=
+=0A=
+static int usbredir_server_chardev_can_read(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    if (!s->parser) {=0A=
+        return 0;=0A=
+    }=0A=
+    /* usbredirparser_do_read() consumes everything we hand it */=0A=
+    return 1 * MiB;=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_read(void *opaque, const uint8_t *buf,=
=0A=
+                                         int size)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    if (!s->parser) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* No recursion allowed */=0A=
+    assert(s->read_buf =3D=3D NULL);=0A=
+=0A=
+    s->read_buf =3D buf;=0A=
+    s->read_buf_size =3D size;=0A=
+=0A=
+    usbredirparser_do_read(s->parser);=0A=
+    /* do_read() ran our callbacks; flush whatever replies they queued */=
=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_chardev_event(void *opaque,=0A=
+                                          QEMUChrEvent event)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+=0A=
+    switch (event) {=0A=
+    case CHR_EVENT_OPENED:=0A=
+        trace_usbredir_server_chardev_open();=0A=
+        /*=0A=
+         * A close event only schedules chardev_close_bh. If it has not=0A=
+         * run yet, it would destroy the parser we are about to create,=0A=
+         * so run it now and cancel it.=0A=
+         */=0A=
+        usbredir_server_chardev_close_bh(s);=0A=
+        qemu_bh_cancel(s->chardev_close_bh);=0A=
+        usbredir_server_create_parser(s);=0A=
+        break;=0A=
+    case CHR_EVENT_CLOSED:=0A=
+        trace_usbredir_server_chardev_close();=0A=
+        qemu_bh_schedule(s->chardev_close_bh);=0A=
+        break;=0A=
+    case CHR_EVENT_BREAK:=0A=
+    case CHR_EVENT_MUX_IN:=0A=
+    case CHR_EVENT_MUX_OUT:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * Device registration=0A=
  */=0A=
@@ -102,14 +352,46 @@ static void usbredir_server_realize(DeviceState *dev,=
 Error **errp)=0A=
 {=0A=
     USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
 =0A=
+    if (!qemu_chr_fe_backend_connected(&s->cs)) {=0A=
+        error_setg(errp,=0A=
+                   TYPE_USB_REDIR_SERVER ": 'chardev' property must be set=
");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* One port: usbredir carries a single device. */=0A=
     usb_bus_new(&s->bus, sizeof(s->bus), &usbredir_server_bus_ops, dev);=
=0A=
     s->bus.no_auto_hub =3D true;=0A=
     usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
+=0A=
+    s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
+                                              s, &dev->mem_reentrancy_guar=
d);=0A=
+=0A=
+    qemu_chr_fe_set_handlers(&s->cs,=0A=
+                             usbredir_server_chardev_can_read,=0A=
+                             usbredir_server_chardev_read,=0A=
+                             usbredir_server_chardev_event,=0A=
+                             NULL, s, NULL, true);=0A=
+}=0A=
+=0A=
+static void usbredir_server_unrealize(DeviceState *dev)=0A=
+{=0A=
+    USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+=0A=
+    qemu_chr_fe_deinit(&s->cs, true);=0A=
+    usbredir_server_destroy_parser(s);=0A=
+=0A=
+    if (s->chardev_close_bh) {=0A=
+        qemu_bh_delete(s->chardev_close_bh);=0A=
+        s->chardev_close_bh =3D NULL;=0A=
+    }=0A=
 }=0A=
 =0A=
+static const Property usbredir_server_props[] =3D {=0A=
+    DEFINE_PROP_CHR("chardev", USBRedirServer, cs),=0A=
+};=0A=
+=0A=
 /*=0A=
  * The link to the remote host is a chardev, and we cannot migrate=0A=
  * that. So this device cannot be migrated either.=0A=
@@ -125,8 +407,10 @@ static void usbredir_server_class_init(ObjectClass *kl=
ass, const void *data)=0A=
 =0A=
     dc->desc =3D "USB Redirection Server";=0A=
     dc->realize =3D usbredir_server_realize;=0A=
+    dc->unrealize =3D usbredir_server_unrealize;=0A=
     dc->vmsd =3D &vmstate_usbredir_server;=0A=
     set_bit(DEVICE_CATEGORY_USB, dc->categories);=0A=
+    device_class_set_props(dc, usbredir_server_props);=0A=
 }=0A=
 =0A=
 static const TypeInfo usbredir_server_types[] =3D {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 80ead23358..d141661673 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -393,3 +393,9 @@ aspeed_udc_handle_data(int ep_nr, const char *dir, uint=
32_t iov, int ep_idx) "ep=0A=
 aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t =
iov) "ep %u, rptr %u, wptr %u, iov %u"=0A=
 aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_=
t iov) "ep %u, wptr %u, avail %u, iov %u"=0A=
 aspeed_udc_ep_ack(unsigned ep) "ep %u"=0A=
+=0A=
+# redirect-server.c=0A=
+usbredir_server_chardev_open(void) "chardev opened"=0A=
+usbredir_server_chardev_close(void) "chardev closed"=0A=
+usbredir_server_write_recursion(void) "recursive write, leaving it queued"=
=0A=
+usbredir_server_log(const char *msg) "%s"=0A=
-- =0A=
2.53.0=0A=


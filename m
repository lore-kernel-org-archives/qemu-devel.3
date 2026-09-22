Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1EDC982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOJ-0007W4-BW; Tue, 22 Sep 2026 05:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOG-0007Up-S3; Tue, 22 Sep 2026 05:02:16 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOE-0002Bc-Lj; Tue, 22 Sep 2026 05:02:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVH2vHtAChPP0i9wIV71PRm/4T0EkUHdfZlm90rNZ4z/FzXj5yQIaN1c6k6VJ04awP9qJywkklZEJ3XGN5rg+ZotWbiyFUPOepUdzUId04p5kjJa1Q8gyESR19JomE7BpkoO9mE02G+9C2oSPgEY89/6mKRrgHzrdrubJDWUC34GxnJ+3vI8GAGSYYOOy/Jig6DGYRd1CBjV7ciT9/LJjBRNvlkpiCkpAf/UZvS+AwoBKbeBJu4+3PFRKIyReNLc7SClgtO7G+Ghqq1Olvk2AlMjRiDESXV6Nn/tuAQ4+GGtLr25S83ED63dV3my81fhX1jdzpbESSnVXsZcJnThcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bumKTamqq6Kt+f+Ohc1kdZVuLAkNZHeLFKqK5Br0uw8=;
 b=vTXsrBMxN0OgarKDvTVr1cVQ49ui3RKZSBJt/tTcZzlPVGxkGY3rQppC+yOQ1UC1RAMb/47BJcvRBIlWktjLjek7LkgKNuwicKEEZPGqjrqY+t1sIxh8MSRXB1zGHSTZL20EDXDh8TFidRYnjuAWACdRHVmL3SjAPqkUUyGTtt8EsEw0Gs1gyRJ/uoTNvN5+PRZskDLMk2FoqUjno9Fg8c7zQpcrnjdl2Qodv6dMQVa4tyEVbViDI4p3bdEUEqXXA6JGrynJJtmzEml7roufF+TmEVkYdY9lKqCzLv70SEOlztVgz/ZFynoAGtcNj7YlYyQvKFzABmsh21wXjz8/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bumKTamqq6Kt+f+Ohc1kdZVuLAkNZHeLFKqK5Br0uw8=;
 b=H3jrd9lcNy0wx6+Xx7sk22Q/GGnIIfXa2Gn1mwH2RihEzFWl7tZ+ztXzJ4pGwA+o/BNOKVdvgkG8YCv9j59kWh0uTT189x52OjpKEhG/vcGXlYPE8NxoebRiEfYDVaOgsQ2k2aFFHLBUYDmtM1t0U55nBW+G+T6UQ4C5TIJ2PLurShP5HYgqrN5NdHhYIPdPslO/CV1XGP2NG18sB3sTLY1x4MDdpMu/JeBO91HIoIFTbQQHwybRxqA4Cfl771r3dUSzr7ONvQXMvF5dXhaajztVL9t0rzb3S4bZXmC+JZd/eK8y3YAKefkkAAUt6q44TFF8Em0JzKrdEobX+McE+g==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5090.apcprd06.prod.outlook.com (2603:1096:4:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 09:02:00 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 03/19] hw/usb/redirect-server: Connect usbredirparser to a
 chardev
Thread-Topic: [PATCH v1 03/19] hw/usb/redirect-server: Connect usbredirparser
 to a chardev
Thread-Index: AQHdSnEGYE21x5YoNEaUStp3xO2eqw==
Date: Tue, 22 Sep 2026 09:01:59 +0000
Message-ID: <20260922090154.1792077-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: fe6320ff-785e-421b-f9ee-08df188829b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|5023799004|6133799003|3023799007|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 6E6I5gXx9LHHgBtku1MEf67QoUj8zJY1zrTCi9S2eZUt/8oHHSOKCG1TFinDInvbst367I2Cv+XOAIAinTk7GoZgHMRk9W70G7F0ArabgppFHOY0jB0SMZGMbsedU9EERxLwO9EF6aHDJCf5rtdVB8/HomQbhhcHaUG4LxkefNE34DKWPd7i5VOdznbvI4Ddqkj3+nlx2Atf6m5NjxsGz0b3vOMSO1KcBNLZdn3NGMt+qfgDRttWE1rwbCga4pWXd9ieHUu+w5lwGHYOQAC4IT6Xeu2u5F9sQ8fZIsndPRV18C3Cv8lOHxLLpt1Fn9eljPd+rEC+GTLMgD3A/VE4VxtIixQnlWwlSBMN3SJyQl7JkndG5FPOYA4HhjS6aCQtXqkAbwyeDI6+ZsSU+ToWPHzWEJsjEwnUOFhxQrNvBO8/DDUIe3gYXn9vAKIGcGdxPrBNJsqtTK0sAOtK7IQTS63rT3LyPRSxB+QZidDkP1PIBZCbARrhzYP8ud2vLOURU7HObI80RimJWiC1GUSdRsMlkDygQjbder9MJPowyvZz4WtG942iqtBS2rGtqc39dUiiKsadtW4JBIVwLcK7yk76bN7YbeSBb3VhQ22W7UIKhcckD3lh2gdh96n50+4B18IpZgbvfLSQU46JkjPrm1HLqhslqmQ0rr8AWmtwXWPDsKY6+QrlmmwFjZp7b10G+TO1eTGPQM9xJU+vlOqRn7Qt/z/S6ZixoF5IBMFpmgY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(5023799004)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6E2bC+y34Qtpp1IcNU+QOhsns3xow44D+vxLiJjUKnxQhKmYVhdJxOTEcD?=
 =?iso-8859-1?Q?2LXAMyNvpZsZY5A3mHvXrISNe/JZRHY8e8Ibst7N0p0X2iLQqdqbFnworh?=
 =?iso-8859-1?Q?4lQk4ZLMPLHAOLv2RvG1sZyA5zPEh4tjiRjx6ZcVcYQrrm9jomOObnXCZV?=
 =?iso-8859-1?Q?uHOOTKSSFtVhHUvFdeIAy0dOW6dO309eHXcG5X3SCCOmxoA00EYMKYW/Ys?=
 =?iso-8859-1?Q?ZBmhHwDMzPbsBDQrNC+e4Pn1tdNv5VT5hpbwPFB+ZXsQ+RW+h4Bor2L6tS?=
 =?iso-8859-1?Q?L+mKf8mlfFo7FNrCpD7I7UcITT9GLwxJEvVP6A5puLddVkkBAEugSHn5Yn?=
 =?iso-8859-1?Q?uj+weJysc13/Wib7zrIUKkG9uSBaAe4sbbwlWDwoO04ME9cxOVAAMupxXB?=
 =?iso-8859-1?Q?t2/wLBFsU58va9kRbLgHHqYRO/9iet1iMkqlI/pC60miwsnZsLQmXq46CG?=
 =?iso-8859-1?Q?K6OqvpILFzDwfJS2MmfUok4Dk0YDkG+Mhd35pxDxMXjXn0mjdgpDFRtKpw?=
 =?iso-8859-1?Q?a7SVBpWXt7f4tKSe6BOEHotJypZGk3A+uzKGbpb8wm38yvN5QYWmkj/CX1?=
 =?iso-8859-1?Q?NuNRDRgCyJGPY+qVBJN2GggOkejFmqyqD6mCQ2vMFemKBUC7mNDmYl3i2I?=
 =?iso-8859-1?Q?uejx65WRGiMGcfL4fAayqHwO2ljL6dROJVok5EGUG3SAYpFO7nfqxTfM/P?=
 =?iso-8859-1?Q?7C+O2wKY8a7HnAgPSivbbMRnZKPFjpavgE3BZnKPaSkOQxze/oK2HsMyl/?=
 =?iso-8859-1?Q?YXtXRlCK9No1vN+gTNOG7YDR9uVMa9PZTZVrt6ZTgBLvaQgY7kBdw/MLje?=
 =?iso-8859-1?Q?/Zvpb1OTv5dxMObWZDDslR8UBg+kO56QCI9pztUsNvK/vsCeGfpUvk0Gmm?=
 =?iso-8859-1?Q?vOtH5sM6fSXry5r1DKZctz7cJtdFrWpDV0ELpCUbbCAKuXYwfEuFgU8IZQ?=
 =?iso-8859-1?Q?yEnobvysKJK9QgQsFzFd7ePdM0xAycgRmN9OmCvEhc+tsPSXlqh4WI1ATJ?=
 =?iso-8859-1?Q?wsY+3yOQCFxVFiHq85Pj+Wl2D8py+n+TjgCOK9A4K3ijOb08lShxPQsA+1?=
 =?iso-8859-1?Q?GRm4k3OUh+8aZdJX5Hz4UkdXDsMKjmFZbVXuhZY/NILWZETaHnTDqzsvGJ?=
 =?iso-8859-1?Q?ccv60lWdST9LtdWYGAT32pkFzi6zlzPl4skRnXHJL1lclYqqbg46EPmpAp?=
 =?iso-8859-1?Q?91E4D9RIWsa8LcaoVRtTQMFbBsyfAiuqrtW9MFT/cOrHvlGVRfOw19BqCD?=
 =?iso-8859-1?Q?FRMuSuYkuwGbt8ptad3RtPefbfvW/BwVYSAuzs5fnFcaKWm0AhJCPsytfI?=
 =?iso-8859-1?Q?I3Z8OQrSCvC3zRwuHFWL4c7R/8tAesqs94t9T8R7bVd2bgtyUy1VEdlHdJ?=
 =?iso-8859-1?Q?ZOyy8QS0LmDNpAcIv8SBOFqOz6C44rXNj+AddJyzbu5+x316jYCCFwP5OI?=
 =?iso-8859-1?Q?HxYoQWMyJQrGuFKxlX4w+nz9Mlu+o4nSVAh2xGouxsos+UUUuE7Y/lzjei?=
 =?iso-8859-1?Q?ofzCcQyB76+FRfAqQcqlsNPt2LVgYzF5TSt+kB3JXZaM5Ze9Sx2YakaAgW?=
 =?iso-8859-1?Q?ld+lS1qQbWXn9A8xaf4S26VFRzIDe2b0qZC0cfBKt+4yXzf8lUR2vLKoGW?=
 =?iso-8859-1?Q?Q4w5ldzaoBcbv34ZHCIlBqsAgK66NNsh8UfrxS6m/QHIPT8sMvchmD03o8?=
 =?iso-8859-1?Q?PCYyvitzWUq3W/otHfTTFkzAY5+jSY7rqaZSN84dngB8aXakE0sCovKY5b?=
 =?iso-8859-1?Q?b/sq+zaBkg2oxgNpHxPGWEHxacd7ASpRBLlIvE4D1HVTN+z4doLfj6VitQ?=
 =?iso-8859-1?Q?HbYHuvOVcw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YAKfeM7w/5Mn2MuZBEK+p0BBK2YF775HBHt+61bOXuC97WxLKTcK9wEPR5u63uWKRnnoKqlQqlaTt58ZdWI8a+kZ3DrleR3/NcJ51pZiFN2IK/1wu9KAPnGt+Hv8RO/fpeEfHJtnUG6Y4XQvR/OedOV7OobCGP6Xar/53k6a9/2BmeXEoHm6WOhGx68c+g6P3GAba5ODEi2lzORlIDkuBYX6np8OnpcjDgOW9ypw+2ciGnBbtEFNtU9XFA6oRXMUsMaDw3CNn6wFrbBG72br7uI/DXcc9No/91Ncf1obROCYe/0dBdu0jzIpgvXGe41FSOJnekM/9mYnCuDy9Nk3Qw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6320ff-785e-421b-f9ee-08df188829b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:01:59.4430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06cZZ9cj1VN0q8Jlp3iP5SIK/CLWHnEj85HOYHnW8Xu7dv/PLSMMy74WKf2lay8f3qqFaACXdqrzCwl0XbWm848ESKLYzCWFKGKLa8Brfyk=
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
---=0A=
 include/hw/usb/redirect-server.h |  15 ++=0A=
 hw/usb/redirect-server.c         | 268 +++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events              |   6 +=0A=
 3 files changed, 289 insertions(+)=0A=
=0A=
diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-ser=
ver.h=0A=
index e81d4e0608..2af881bda9 100644=0A=
--- a/include/hw/usb/redirect-server.h=0A=
+++ b/include/hw/usb/redirect-server.h=0A=
@@ -11,8 +11,11 @@=0A=
 =0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
+#include "chardev/char-fe.h"=0A=
 #include "qom/object.h"=0A=
 =0A=
+#include <usbredirparser.h>=0A=
+=0A=
 #define TYPE_USB_REDIR_SERVER "usb-redir-server"=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SERVER)=0A=
 =0A=
@@ -22,6 +25,18 @@ struct USBRedirServer {=0A=
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
 #endif /* HW_USB_REDIRECT_SERVER_H */=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 5f365f0a35..c36b5c16c4 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -50,10 +50,18 @@=0A=
  */=0A=
 =0A=
 #include "qemu/osdep.h"=0A=
+#include "qemu/units.h"=0A=
 #include "qapi/error.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "hw/usb/redirect-server.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "hw/core/qdev-properties-system.h"=0A=
+#include "trace.h"=0A=
+=0A=
+#define USBREDIR_SERVER_VERSION "qemu " TYPE_USB_REDIR_SERVER " " QEMU_VER=
SION=0A=
 =0A=
 /*=0A=
  * USB port ops=0A=
@@ -81,6 +89,232 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
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
@@ -89,14 +323,46 @@ static void usbredir_server_realize(DeviceState *dev, =
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
 }=0A=
 =0A=
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
+}=0A=
+=0A=
+static const Property usbredir_server_props[] =3D {=0A=
+    DEFINE_PROP_CHR("chardev", USBRedirServer, cs),=0A=
+};=0A=
+=0A=
 /*=0A=
  * The link to the remote host is a chardev, and we cannot migrate=0A=
  * that. So this device cannot be migrated either.=0A=
@@ -112,8 +378,10 @@ static void usbredir_server_class_init(ObjectClass *kl=
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


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EC606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=JxWUzXK5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuY8-0004rm-Jb; Tue, 27 Oct 2026 23:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY7-0004qm-9c; Tue, 27 Oct 2026 23:42:03 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY4-0005dK-5O; Tue, 27 Oct 2026 23:42:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xp5vWravA1iF99lmsf+Ap/vBybv98O/31D9u/YKM4DuTdWfZ812G3IMmhRNP8nBCXMdE4xVv4PvzOiEUSE9GrLebA2wcAueIBAU0BdDO7tvSUWzrvUWqFZbfOujgxdSuTFf4bY74/jIlvTFwZQ0fUtdrfo6uvA3jdMN+v3efCnyf7tygT5RPgsQQToCuw5AUWK6TRYdNw/xNuocEk89FC6IbqpFkQ5XpDd1iqjWrAMa79xoMOzp0U3LYWCJc/U5tNly416F5rX7b/ud1/4p2SHRqPRQ0a4OjWDsbDYjcNicsDLuhfEqETGR19/Ug5BW8dXCgweFb49qrmkOF7PwMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PE18u9pzksTglMwNheo4W6Uuw7yiKPsJFvcmMGjVxo=;
 b=WA0OPrd0oq3Mhvb4LJasn1KnR5o4bue9T4e3mP5nisuMkIRpg2j4zfctKPqrHkGJeLnhQwvdZA1Qn72c18hra2oHf00tjTbhHKkKEPOMjsZ/ECMDwFHp8dilDglHJPahjkBySkSob7waa3ep99SwKCJf9D2NLdzxaTn3aFbnRMS8kpR2KmyIfHUtwEUe3XpBcnssvDTCCDkEqr7ldWcMva1EdE35bweZggYIm6cglxYOUUO+dKRu593nopLoZf8/OoaGxwWisQBz7unry4MpcOdOkdXNsgHI5CPXTzmZWKjESQG6mfPadYVVxNXx/UKxt/SEffsIYKplspcD9fNKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PE18u9pzksTglMwNheo4W6Uuw7yiKPsJFvcmMGjVxo=;
 b=JxWUzXK5Y+yizHaX4oe0HRzNtFgl/9vdiLnE5NgVs32cYTx0fa5HJ0rB2ZVcA5dqfQr6HkqFONezpxEtKQjSqH2IjWMvD3POioTpomGfEj1dgcB+NymXdLe44KHExgC1lUgZQMDheypxK9fFOCuaw9aXVo3ZcELM+HvOBXhFPxUbwnnxjiuqo1O9ipog+KVlCDV2Txr2BiW0tGKWciIE6mcdm7wHc5fwN+NZ5BS01eEIdmxZKWMMqhwsyjpDm0IvBgTnSBc8g6FODKCYWhutpxTDRQL7g0Q1k6+6RjB2JdAxKICycWOlA4p5L1DruFcgUvCRPUh6Z+UXjR4NtyAZ2w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEZPR06MB6485.apcprd06.prod.outlook.com (2603:1096:101:17e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Wed, 28 Oct
 2026 03:41:50 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 03:41:49 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 7/8] hw/usb/redirect-server: Stream interrupt IN endpoints
Thread-Topic: [PATCH v7 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdZo5DqEh26q8Bj0eudtOpncB2+g==
Date: Wed, 28 Oct 2026 03:41:49 +0000
Message-ID: <20261028034140.367393-8-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEZPR06MB6485:EE_
x-ms-office365-filtering-correlation-id: 91525af0-f53b-4d99-5b87-08df34a56601
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261022113327099003|261009223027099003|10067099003|261026140227099003|18002099003|22082099003|261026121527099003|56012099006|38070700021|5023799004;
x-microsoft-antispam-message-info: YiZNhHSyvh/ur6UWPKaVZ+kjC/bqtVj9NF81E0/FOVdW1wuGJhcER1hTCs+QY7WIN5DiiqUa6NRbycV2iYbA3y3MloVpBx6Q3HIBVQuZ2tjUevqFU7nvDHjNu+Az2lGivYFS2cGgqAKSf1oLGNnSjgjbOpRlpHIBgp2iJD3rYJEjLK6i+n36pGCz/l77AP+gxvoiXwYsnrwrxSqH4/FShJshL/cE8v/0jwzLIawHSaNBpKMCwVFSG5r9XOAM8j9mmhJ5kL7ZgeSdx/kJh0Od1U0wCrk05f3FDUl+VV93GkBnsrHuRWjatVyg9qMasRvw6rdYqUOHL9NvBkL+e+xGsWt/CBJV1BHwWxy5kJJ2DO9jnRsii4tVYsAkPzir0L/r7G4eT24PqEX+C5423rIGKL+Ot+itXdAwqobxUzk/k9V5r3xxiz1fI8JJCfqiKOG9T1RMeCBq0IViJ3dINtsr+5DeyKQsTyhQ7KTmL/cMgkiijTht/R1di+etdqqut/ppByvXuuF2VcKCqZ6jx53I70DbcJbsOccO4AfbAGGdul5cNXB8ieMFaBJW0dU0EVqIiR422BxiaOQlXCukfLkcFHR0ilfPhCKvvvfXYLUpMaLATSR7NZdQVqeUac6J24w5NCauRFMsY7pCx0tXfW5Wlvb81qESnZ1mwrH7aOD5cSFdIE7Oii0qEtP+CzWM+xuVvgN7Q+3Iec+t0PJrBzF/3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261022113327099003)(261009223027099003)(10067099003)(261026140227099003)(18002099003)(22082099003)(261026121527099003)(56012099006)(38070700021)(5023799004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qJqUiDWlxphXPGMbBwBbNznwwRKhZqEezLkCjEYgA5z694d8cAdhvqxd7F?=
 =?iso-8859-1?Q?/2fhQU1b+gY5Di52SqlYzRQX0ECLtmlwijM8RO6fcr2VmtT7MSUYqpzOWB?=
 =?iso-8859-1?Q?zoktt82DxvOqtd6IsVjyd2WSvc/OtYHBAPaQO1PFXw3xSBxrcBtF4P4ZVI?=
 =?iso-8859-1?Q?Zh6JZpMZUAc/xX6YZDY9GENYUzyGQKX2VtD6ET60OGRYVF7tdmi9U6t9Ck?=
 =?iso-8859-1?Q?YccVCXJHLrYXumg3OUaAbGJk+qzyozLqp3D5s5imyBnHTFtknWRDB6Iixu?=
 =?iso-8859-1?Q?86iEox9LL2BJHm0EYPBs+bR8iG2yDxwM82SEfDCNWEUXxcD3kd060f4IIT?=
 =?iso-8859-1?Q?njN5jTNSYvVLrHOQ9AGFt7t418NQjvhz99LiqvEfhfSN9mDzM/KLH+Np09?=
 =?iso-8859-1?Q?cubdCFxmxn7i3/YYFS5X1hD7UC8vzSBeywjBn+dmwdkwygV4MfI8N9bjZC?=
 =?iso-8859-1?Q?52yAcctg3rSACp2cBQ86IlELHbk4uGSXZIGfVyb/wgPTdYUXyZhtJ/kZNe?=
 =?iso-8859-1?Q?15dOpv3p0Gy27SmUlBh+IshJptHa4/QMz4IhqYByweuBewIp/nVRtdBMdS?=
 =?iso-8859-1?Q?Y38zUBNH0xmO/f+d8xq8b49keic8swEYKiXkGwB/acfxPic3ROHRJtP+dD?=
 =?iso-8859-1?Q?hAPPVmTvAOryAL82dJ8G7WEAHrhihtTJdM5JoofIp7lmU4S9mu1EmCJWYq?=
 =?iso-8859-1?Q?AitauZMLF8ioyc6R56EOClSTa4VHtbT0SVfOwnIhJUxqpY0ABZQThd8gNB?=
 =?iso-8859-1?Q?Go2p0chOYGytSdTf7AaIIBMwgIVkf++6XRzHCep4w5AfA3pI0/Tc80G9yy?=
 =?iso-8859-1?Q?JxbNeb7rtCrGsprmYQ5OqLggJO0T2Y8sH8QuAUrMLl1ZAuNUxQg3UWlvbq?=
 =?iso-8859-1?Q?PM/JmBEWbEAFR8LqYjbNSJHg4giJ8KxCq1Rynmjf2Y5wJUIhsiTZO17o6A?=
 =?iso-8859-1?Q?ezAsWZ5Xy++cEcEKK6jRepJqhu2OAPpIIKBMd849hlvWQC0nCp0bAYgklP?=
 =?iso-8859-1?Q?kWN5esoC9hobVsf9LHhAWnM0h5H2x4GYmxiWwWv0OJo+hpTqhrdlQ82aDa?=
 =?iso-8859-1?Q?FsT7H+nh4wrheqRFXJ5Oy8Mzt33XWNdN+ODAhxJv0SouF1YYIPhm67k6s7?=
 =?iso-8859-1?Q?DK1yoIxFsz4bhynTp4SK4yWs4cZNRPONoaXX3xUGEfcp101EiEiJE0aBeF?=
 =?iso-8859-1?Q?yVAmQJN2G1c9rY4ElQ9Vd1o/jOh4aHLuQ74BTxlDyBDHyAorSi/nlBhA2a?=
 =?iso-8859-1?Q?gksJ6tx0z3ulf+U/PDnSXcjwabyMsBUmagOUHF6i0YaY2RyZc9RJNjUas6?=
 =?iso-8859-1?Q?Xp10I6BAmiioeAHOyvqBuxXCxwh8CEoy9qrUO61nGDMQAdiQQ+t8nENbqH?=
 =?iso-8859-1?Q?stWYihx81/y3ELQWhD5oB0C2MdIoI6RgCxBehsSTgKlIw3xabdD6m/kGmV?=
 =?iso-8859-1?Q?6m7nZBZr3HDjy8pgC0UAtlj0I/X/lKcrNckp7p0NRxzJgfHEV6+kBWuj73?=
 =?iso-8859-1?Q?TSZ+y1qZU/a82DadcADskxEPycDmPzXj3eZRq5PunmlQopACNzbiDbhCoH?=
 =?iso-8859-1?Q?qUTINEWIQZW1ByzCeQOzkeJU1bG3cEqd3XDSmA7+wMFV8s/S4P7cyV2jQB?=
 =?iso-8859-1?Q?Y4KKNt70CfF2n5OIuLQ/GhEJRbiovVuydoS9iAPID1Xbqh0g5q7wgoyfET?=
 =?iso-8859-1?Q?GmNeoW3NOozBwZ8pdZvqxy9CojWC2xfkdgwbZPYU0XfHgCcDHEQEjMcKt8?=
 =?iso-8859-1?Q?edwZuVTdKv3oQzlWXwho2xVA8FFMwic/GkDMp12kMJsulKp9FnJt9l7S6R?=
 =?iso-8859-1?Q?pabUU7981Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91525af0-f53b-4d99-5b87-08df34a56601
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 03:41:49.5192 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dgv5DRq7r02cNSFPH4iBKSbT2GcpoCT72N++HGEYhp8/yUyaDQG19ttSPTS9xgZ5QszzslzBziI+XAFTFSZj16jFNZbqWhr+ys2Hfuj4eIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6485
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Interrupt IN is not a request and an answer in usbredir. The host asks=0A=
once with start_interrupt_receiving. After that it expects a packet=0A=
every time the device has data.=0A=
=0A=
Park one IN packet on the device for each streaming endpoint. A device=0A=
that answers USB_RET_ASYNC holds the packet and completes it when it=0A=
has data. A device that answers USB_RET_NAK gives the packet back at=0A=
once, so park a new one when the bus reports a wakeup on that endpoint.=0A=
A slow timer parks one too, for a device that does not report a wakeup.=0A=
A streamed request does not wait on the endpoint's list the way a host=0A=
request does, because this timer already asks again.=0A=
=0A=
Wait for the endpoint's bInterval before parking the next one. Some=0A=
devices answer every time. Without the wait we would ask as fast as=0A=
the main loop runs, and the guest would get no time.=0A=
=0A=
On an error other than a stall the stream stays up, but back off to the=0A=
slow timer. At a high speed bInterval of 125us an endpoint that keeps=0A=
failing would otherwise send thousands of status messages a second.=0A=
=0A=
Give every endpoint its own timer and bottom half. We ask each endpoint=0A=
at its own rate. Drop the timer when the bottom half has already asked,=0A=
so it does not fire for nothing.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 298 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   4 +=0A=
 2 files changed, 298 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 7eeb08ecd7..fecb7119dd 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -96,9 +96,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SER=
VER)=0A=
  */=0A=
 #define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
 =0A=
+/* Buffer size for an interrupt IN endpoint before its descriptor is seen.=
 */=0A=
+#define USBREDIR_SERVER_INTR_STREAM_DEFAULT_LEN 64=0A=
+=0A=
 #define USBREDIR_SERVER_CTRL 0=0A=
 #define USBREDIR_SERVER_BULK 1=0A=
 #define USBREDIR_SERVER_INTERRUPT 2=0A=
+#define USBREDIR_SERVER_INTR_STREAM 3=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
 typedef enum {=0A=
@@ -156,6 +160,15 @@ typedef struct USBRedirServerEp {=0A=
     /* Asks again for a device that does not wake the endpoint. */=0A=
     QEMUTimer *retry;=0A=
 =0A=
+    /*=0A=
+     * Interrupt IN streaming. The timer asks the device again at the=0A=
+     * endpoint's own rate, and more slowly after a NAK or an error.=0A=
+     * The bottom half asks at once when the device says it has data.=0A=
+     */=0A=
+    QEMUTimer *stream_timer;=0A=
+    QEMUBH *stream_bh;=0A=
+    bool streaming;=0A=
+=0A=
     uint16_t max_packet;=0A=
     uint8_t interval;=0A=
     uint8_t iface;=0A=
@@ -616,6 +629,97 @@ static void usbredir_server_interrupt_complete(USBRedi=
rServer *s,=0A=
                                     rp->data, len);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * How long to wait before asking the device again. bInterval means=0A=
+ * different things at different speeds: a number of frames at low and=0A=
+ * full speed, an exponent at high speed.=0A=
+ */=0A=
+static int64_t usbredir_server_intr_stream_period_ns(USBRedirServer *s,=0A=
+                                                     int ep_nr)=0A=
+{=0A=
+    int idx =3D usbredir_server_ep_index(ep_nr | USB_DIR_IN);=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    uint8_t interval =3D s->ep[idx].interval;=0A=
+=0A=
+    if (interval =3D=3D 0) {=0A=
+        interval =3D 1;=0A=
+    }=0A=
+=0A=
+    if (device && device->speed =3D=3D USB_SPEED_HIGH) {=0A=
+        interval =3D MIN(interval, 16);=0A=
+        return (1LL << (interval - 1)) * 125 * SCALE_US;=0A=
+    }=0A=
+=0A=
+    return (int64_t)interval * SCALE_MS;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The device answered a streamed request. Send the answer to the host, th=
en=0A=
+ * ask again, because the host still wants more. Do not ask from here: the=
=0A=
+ * device may answer at once, and this function would call itself over and=
=0A=
+ * over. Arm the timer instead. It also waits for the endpoint's bInterval=
.=0A=
+ */=0A=
+static void usbredir_server_intr_stream_complete(USBRedirServer *s,=0A=
+                                                 USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_interrupt_packet_header resp =3D rp->intr_hdr;=0A=
+    struct usb_redir_interrupt_receiving_status_header st;=0A=
+    int idx =3D usbredir_server_ep_index(resp.endpoint);=0A=
+    int ep_nr =3D resp.endpoint & 0x0f;=0A=
+    USBRedirServerEp *ep =3D &s->ep[idx];=0A=
+    USBPacket *p =3D &rp->pkt;=0A=
+    int actual =3D p->actual_length;=0A=
+    bool retry =3D false;=0A=
+    int64_t delay_ns;=0A=
+=0A=
+    trace_usbredir_server_intr_stream_complete(ep_nr, p->status, actual);=
=0A=
+=0A=
+    switch (p->status) {=0A=
+    case USB_RET_SUCCESS:=0A=
+        resp.status =3D usb_redir_success;=0A=
+        resp.length =3D actual;=0A=
+        usbredirparser_send_interrupt_packet(s->parser, 0, &resp,=0A=
+                                             actual ? rp->data : NULL,=0A=
+                                             actual);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        break;=0A=
+    case USB_RET_NAK:=0A=
+        /* no data yet; wait, unless the device wakes us first */=0A=
+        retry =3D true;=0A=
+        break;=0A=
+    default:=0A=
+        /*=0A=
+         * The endpoint failed. There is no data, so send a status=0A=
+         * message instead. The host gives it to its guest.=0A=
+         *=0A=
+         * redirect.c ends the stream only on a stall, so do the same=0A=
+         * here. If we end it on any other error, the host still=0A=
+         * thinks the stream runs, and it never asks again.=0A=
+         */=0A=
+        st.endpoint =3D resp.endpoint;=0A=
+        st.status =3D usbredir_server_status(p->status);=0A=
+        usbredirparser_send_interrupt_receiving_status(s->parser, 0, &st);=
=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        if (p->status =3D=3D USB_RET_STALL) {=0A=
+            ep->streaming =3D false;=0A=
+        } else {=0A=
+            /* the stream stays up, but do not ask at the endpoint's rate =
*/=0A=
+            retry =3D true;=0A=
+        }=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    if (ep->streaming) {=0A=
+        if (retry) {=0A=
+            delay_ns =3D (int64_t)USBREDIR_SERVER_RETRY_MS * SCALE_MS;=0A=
+        } else {=0A=
+            delay_ns =3D usbredir_server_intr_stream_period_ns(s, ep_nr);=
=0A=
+        }=0A=
+        timer_mod(ep->stream_timer,=0A=
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -688,6 +792,9 @@ static void usbredir_server_packet_complete(USBPort *po=
rt, USBPacket *p)=0A=
     case USBREDIR_SERVER_INTERRUPT:=0A=
         usbredir_server_interrupt_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_INTR_STREAM:=0A=
+        usbredir_server_intr_stream_complete(s, rp);=0A=
+        break;=0A=
     default:=0A=
         g_assert_not_reached();=0A=
     }=0A=
@@ -727,9 +834,11 @@ static USBRedirServerAsk usbredir_server_ask_device(US=
BRedirServer *s,=0A=
 =0A=
     /*=0A=
      * Keep the request and send it again when the device wakes the=0A=
-     * endpoint.=0A=
+     * endpoint. A streamed request asks again by itself, with its own=0A=
+     * timer.=0A=
      */=0A=
-    if (rp->pkt.status =3D=3D USB_RET_NAK) {=0A=
+    if (rp->pkt.status =3D=3D USB_RET_NAK &&=0A=
+        rp->type !=3D USBREDIR_SERVER_INTR_STREAM) {=0A=
         trace_usbredir_server_nak_park(rp->redir_id, rp->ep_idx);=0A=
         QTAILQ_INSERT_HEAD(&ep->waiting, rp, waiting_link);=0A=
         timer_mod(ep->retry, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=0A=
@@ -775,8 +884,18 @@ static void usbredir_server_wakeup_ep(USBBus *bus, USB=
Endpoint *ep,=0A=
 {=0A=
     USBRedirServer *s =3D container_of(bus, USBRedirServer, bus);=0A=
     uint8_t addr =3D ep->nr | (ep->pid =3D=3D USB_TOKEN_IN ? USB_DIR_IN : =
0);=0A=
+    int idx =3D usbredir_server_ep_index(addr);=0A=
+=0A=
+    /*=0A=
+     * The device has data. A streaming interrupt IN endpoint may have=0A=
+     * answered NAK. Ask now instead of waiting for the retry timer.=0A=
+     */=0A=
+    if (s->ep[idx].streaming) {=0A=
+        qemu_bh_schedule(s->ep[idx].stream_bh);=0A=
+    }=0A=
 =0A=
-    usbredir_server_kick_ep(s, usbredir_server_ep_index(addr));=0A=
+    /* The host may also have a request stopped on this endpoint. */=0A=
+    usbredir_server_kick_ep(s, idx);=0A=
 }=0A=
 =0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
@@ -830,6 +949,95 @@ static void usbredir_server_pkt_free(USBRedirServer *s=
, USBRedirServerPkt *rp)=0A=
     g_free(rp);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Interrupt IN streaming=0A=
+ */=0A=
+=0A=
+static bool usbredir_server_intr_stream_inflight(USBRedirServer *s, int ep=
_nr)=0A=
+{=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    QTAILQ_FOREACH(rp, &s->inflight, inflight_link) {=0A=
+        if (rp->type =3D=3D USBREDIR_SERVER_INTR_STREAM &&=0A=
+            (rp->intr_hdr.endpoint & 0x0f) =3D=3D ep_nr) {=0A=
+            return true;=0A=
+        }=0A=
+    }=0A=
+    return false;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Ask the device for data on @ep_nr and leave the request waiting. A devi=
ce=0A=
+ * sends data only when asked. Do nothing if a request on @ep_nr is still=
=0A=
+ * unanswered.=0A=
+ */=0A=
+static void usbredir_server_intr_stream_park(USBRedirServer *s, int ep_nr)=
=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    int idx =3D usbredir_server_ep_index(ep_nr | USB_DIR_IN);=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    int len;=0A=
+=0A=
+    /* No device to ask. */=0A=
+    if (!device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* The host did not ask for this endpoint, or a request is unanswered.=
 */=0A=
+    if (!s->ep[idx].streaming ||=0A=
+        usbredir_server_intr_stream_inflight(s, ep_nr)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    len =3D s->ep[idx].max_packet;=0A=
+    if (len =3D=3D 0) {=0A=
+        len =3D USBREDIR_SERVER_INTR_STREAM_DEFAULT_LEN;=0A=
+    }=0A=
+    ep =3D usb_ep_get(device, USB_TOKEN_IN, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len, idx);=0A=
+    rp->type =3D USBREDIR_SERVER_INTR_STREAM;=0A=
+    /* streamed data carries no host id */=0A=
+    rp->redir_id =3D 0;=0A=
+    rp->intr_hdr.endpoint =3D ep_nr | USB_DIR_IN;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep, 0, s->next_id++,=0A=
+                     false, false);=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    /*=0A=
+     * The timer is there for a device that does not wake the endpoint.=0A=
+     * We are asking now, so drop it. The answer sets it again.=0A=
+     */=0A=
+    timer_del(s->ep[idx].stream_timer);=0A=
+=0A=
+    trace_usbredir_server_intr_stream_park(ep_nr, len);=0A=
+    usbredir_server_submit(s, rp);=0A=
+}=0A=
+=0A=
+/* BH and timer callback: ask again on one streaming endpoint. */=0A=
+static void usbredir_server_intr_stream_kick(void *opaque)=0A=
+{=0A=
+    USBRedirServerEp *ep =3D opaque;=0A=
+    int ep_nr =3D ep->idx - USBREDIR_SERVER_EP_IN_BASE;=0A=
+=0A=
+    usbredir_server_intr_stream_park(ep->s, ep_nr);=0A=
+}=0A=
+=0A=
+static void usbredir_server_intr_stream_cancel(USBRedirServer *s, int ep_n=
r)=0A=
+{=0A=
+    USBRedirServerPkt *tmp;=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    QTAILQ_FOREACH_SAFE(rp, &s->inflight, inflight_link, tmp) {=0A=
+        if (rp->type !=3D USBREDIR_SERVER_INTR_STREAM ||=0A=
+            (rp->intr_hdr.endpoint & 0x0f) !=3D ep_nr) {=0A=
+            continue;=0A=
+        }=0A=
+        usbredir_server_pkt_free(s, rp);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * usbredirparser I/O and logging callbacks=0A=
  */=0A=
@@ -1237,6 +1445,62 @@ static void usbredir_server_interface_info(void *pri=
v,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The host asks to stream an interrupt IN endpoint. Send the receiving=0A=
+ * status first. Without that status the host throws the interrupt=0A=
+ * packet away. Then ask the device once.=0A=
+ */=0A=
+static void usbredir_server_start_interrupt_receiving(void *priv,=0A=
+    uint64_t id, struct usb_redir_start_interrupt_receiving_header *hdr)=
=0A=
+{=0A=
+    struct usb_redir_interrupt_receiving_status_header st =3D {=0A=
+        .endpoint =3D hdr->endpoint,=0A=
+        .status =3D usb_redir_success,=0A=
+    };=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+=0A=
+    st.status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                          USB_ENDPOINT_XFER_INT);=0A=
+=0A=
+    /* Only an interrupt IN endpoint can stream. */=0A=
+    if (!(hdr->endpoint & USB_DIR_IN)) {=0A=
+        st.status =3D usb_redir_inval;=0A=
+    }=0A=
+=0A=
+    if (st.status =3D=3D usb_redir_success) {=0A=
+        s->ep[usbredir_server_ep_index(hdr->endpoint)].streaming =3D true;=
=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_intr_stream_start(hdr->endpoint, st.status);=0A=
+    usbredirparser_send_interrupt_receiving_status(s->parser, id, &st);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    if (st.status =3D=3D usb_redir_success) {=0A=
+        usbredir_server_intr_stream_park(s, ep_nr);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_interrupt_receiving(void *priv, uint64_t =
id,=0A=
+    struct usb_redir_stop_interrupt_receiving_header *hdr)=0A=
+{=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    trace_usbredir_server_intr_stream_stop(hdr->endpoint);=0A=
+=0A=
+    /* Endpoint 0 is control, and an OUT endpoint never streams. */=0A=
+    if (ep_nr =3D=3D 0 || !(hdr->endpoint & USB_DIR_IN)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    s->ep[idx].streaming =3D false;=0A=
+    qemu_bh_cancel(s->ep[idx].stream_bh);=0A=
+    timer_del(s->ep[idx].stream_timer);=0A=
+    usbredir_server_intr_stream_cancel(s, ep_nr);=0A=
+}=0A=
+=0A=
 static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
     struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
 {=0A=
@@ -1337,6 +1601,12 @@ static void usbredir_server_stop_transfers(USBRedirS=
erver *s)=0A=
         timer_del(s->ep[i].retry);=0A=
     }=0A=
 =0A=
+    for (i =3D USBREDIR_SERVER_EP_IN_BASE + 1; i < USBREDIR_SERVER_MAX_EP;=
 i++) {=0A=
+        s->ep[i].streaming =3D false;=0A=
+        qemu_bh_cancel(s->ep[i].stream_bh);=0A=
+        timer_del(s->ep[i].stream_timer);=0A=
+    }=0A=
+=0A=
     /*=0A=
      * No "cancelled" response here. This runs on a bus reset, a detach or=
=0A=
      * a closed chardev, and the host has dropped its own queues already.=
=0A=
@@ -1382,6 +1652,10 @@ static void usbredir_server_create_parser(USBRedirSe=
rver *s)=0A=
     s->parser->device_disconnect_ack_func =3D=0A=
         usbredir_server_device_disconnect_ack;=0A=
     s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
+    s->parser->start_interrupt_receiving_func =3D=0A=
+        usbredir_server_start_interrupt_receiving;=0A=
+    s->parser->stop_interrupt_receiving_func =3D=0A=
+        usbredir_server_stop_interrupt_receiving;=0A=
     s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
     s->parser->start_bulk_receiving_func =3D=0A=
@@ -1523,6 +1797,16 @@ static void usbredir_server_realize(DeviceState *dev=
, Error **errp)=0A=
         s->ep[i].retry =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
                                       usbredir_server_retry_ep, &s->ep[i])=
;=0A=
     }=0A=
+=0A=
+    /* Only an interrupt IN endpoint streams, so endpoint 0 and OUT are ou=
t. */=0A=
+    for (i =3D USBREDIR_SERVER_EP_IN_BASE + 1; i < USBREDIR_SERVER_MAX_EP;=
 i++) {=0A=
+        s->ep[i].stream_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
+                                             usbredir_server_intr_stream_k=
ick,=0A=
+                                             &s->ep[i]);=0A=
+        s->ep[i].stream_bh =3D=0A=
+            qemu_bh_new_guarded(usbredir_server_intr_stream_kick, &s->ep[i=
],=0A=
+                                &dev->mem_reentrancy_guard);=0A=
+    }=0A=
     s->config_descs =3D g_hash_table_new_full(g_direct_hash, g_direct_equa=
l,=0A=
                                             NULL, g_free);=0A=
     usbredir_server_clear_ep_table(s);=0A=
@@ -1532,7 +1816,6 @@ static void usbredir_server_realize(DeviceState *dev,=
 Error **errp)=0A=
     usb_register_port(&s->bus, &s->port, s, 0, &usbredir_server_port_ops,=
=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
-=0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
 =0A=
@@ -1562,6 +1845,13 @@ static void usbredir_server_unrealize(DeviceState *d=
ev)=0A=
         timer_free(s->ep[i].retry);=0A=
         s->ep[i].retry =3D NULL;=0A=
     }=0A=
+=0A=
+    for (i =3D USBREDIR_SERVER_EP_IN_BASE + 1; i < USBREDIR_SERVER_MAX_EP;=
 i++) {=0A=
+        timer_free(s->ep[i].stream_timer);=0A=
+        s->ep[i].stream_timer =3D NULL;=0A=
+        qemu_bh_delete(s->ep[i].stream_bh);=0A=
+        s->ep[i].stream_bh =3D NULL;=0A=
+    }=0A=
 }=0A=
 =0A=
 static const Property usbredir_server_props[] =3D {=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 5ec5127efa..6eb47085d0 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -423,3 +423,7 @@ usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, u=
int32_t len) "id %" PRIu6=0A=
 usbredir_server_refused(uint64_t id, uint8_t ep, int status, uint8_t want,=
 uint8_t got) "id %" PRIu64 " ep 0x%02x status %d, wanted type %u, it is %u=
"=0A=
 usbredir_server_interrupt(uint64_t id, uint8_t ep, size_t len) "id %" PRIu=
64 " ep 0x%02x len %zu"=0A=
 usbredir_server_interrupt_complete(uint64_t id, uint8_t ep, int status, in=
t actual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
+usbredir_server_intr_stream_start(uint8_t ep, int status) "start_interrupt=
_receiving ep 0x%02x -> status %d"=0A=
+usbredir_server_intr_stream_stop(uint8_t ep) "stop_interrupt_receiving ep =
0x%02x"=0A=
+usbredir_server_intr_stream_park(unsigned ep_nr, int len) "parked IN packe=
t ep %u len %d"=0A=
+usbredir_server_intr_stream_complete(unsigned ep_nr, int status, int actua=
l) "ep %u status %d actual %d"=0A=
-- =0A=
2.53.0=0A=


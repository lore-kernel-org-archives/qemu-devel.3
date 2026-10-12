Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47027CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5bU-0006h1-1t; Sun, 11 Oct 2026 22:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5b1-0006Q7-MT; Sun, 11 Oct 2026 22:17:00 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5az-0004md-Je; Sun, 11 Oct 2026 22:16:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TT6zfPkRfA94jOn6wKXVDJzPMK8b/MP56XiBAzLNYhyPMjq69UZEfDUtRD8eziL12RKuTfnvhHz4omyEtLKFtrwBVC61pib95UuUnGy5yJfxCC7pUVUbV8wy35hkqTaZK7zKjhnl2loCfRjjWAoG3c73tqrEYLMEN/UzkhwR+0+xYBSnhdMopa0rukmtVehYI9edk0BJOwIhN3BPiXeelJsAWukPi2OhSu+K8PSkD0o39vOejvn6uz/auNsoDH6fS7NMMtP60qBeyEG6DCY+RaWt6iUDaE4SyB9lNAENNJ5VOcbm8J9Gdtcy2g03Ola/PiUnHWEZzXio4YiN8t1FTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uDmLGrSXYGSNjvCrNY6nJy+N2v/6yFspQAxUtLzlK8=;
 b=jyo7Lp1EPW9SVe3OuXtwCoGDJ7gaoqiFPGUZbFBOT1MDxniQGbLZL/6MlaLY7MLQLRZ7cpzB4qIz4mgI009DrE3CVsv9Z+TMn2vBLyjlkfFlyZu2DYbN6NYaWMwok/lRMaCGTNtHPfmso/FWcxtamTG2KGlLsS5uQMZki/pZa+gtwxxAfr1Fb6YacR7tAUoc/9IIRGFwrExeZjU8o2mOksq08BK2BM8WrkoS8eWeyFzvcOf6AE7UlJIxqaLvIX1QXmAy+SWQTOxT3dl4WG6WNVbqChHEbaRu43YzQYFzmio1Npvc2lBGg8LE/yaXbrPigBiLLf1qwuO8CD6QzeSr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uDmLGrSXYGSNjvCrNY6nJy+N2v/6yFspQAxUtLzlK8=;
 b=aS5+aE6/FeJzbCjv+fSd0R/6fSVLtCrms4+61xTcUb0yEzYV2gmK9h58JYQo8iBF8d35tbmc1RNEowH/4kU/uqPbZBiDtUPfP93h2I8IoG+cJYdKUdBbXcs5jQwHvHduB+oGGBBoAipYJFtsy4IB3YWc/RacV3ApoYv3CQ6E8rxO8MlANoklgdhL9DEi7p8W06LfKSCOpQ5eZG/Hpp2zKQGsK9i6gOu3cT3TKwhlMyK0+SqtOGCM+Vwp75jwcuErOMdXq0wd0LIUbAPZdVf3bLTSHriVFP6wDcMqBnS+LiO/E0pgFfE2TiwP9MWRMqzn7AvbBvtkI4NWP9jm433D9Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5398.apcprd06.prod.outlook.com (2603:1096:101:8f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 02:16:43 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:16:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 6/8] hw/usb/redirect-server: Implement bulk and interrupt
 transfers
Thread-Topic: [PATCH v3 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Index: AQHdWe+5LUoFgTjdjEqyQ1RevlwdzQ==
Date: Mon, 12 Oct 2026 02:16:42 +0000
Message-ID: <20261012021634.2006424-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 3ff4d950-ad7f-41fb-7256-08df2806db9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|10067099003|261009223027099003|5023799004|38070700021|56012099006;
x-microsoft-antispam-message-info: zA7OvN9n2hTnjqTyMFi4YO+QooIdL/ouGHE42GJfXwoXP7+LUaqtzkfxHLRQK2yYzRWMhx/WaYE50kcBNKBviaFLfTa9DDS4apErZOS1orS3vi3D8m9/edgcRWWx05oiIYqZQMly0uIi5n8jzPHoBq87Dgukj3eKMUmfcNnFB/rDNt8EItn8yTtCUeyMjy9Km8XjSBbB4Vv/YVcaa2psA1p0VWGuaxxrpJjYvi77cIJhmTg5vPWgcEiYxRwWJvhJna5zFlSDU48BZfKA2s00Kb90FMBpF2VVRzrxr9GFIY7yuYqQFNYdXiFRhZ29uKWUHxbbNQfi2Idlr4688xkemr1+UkmNH3SjaEI+kMyEZoF/hUr7kdShdmSjFGid65bGeM/vbqphn26KYJodeFa7hK6czPWWAJDT0j7kr4Hf9l29Fl3MyWT3gvSZ9wMEF9wviIwUn7GtDFd5i9Tsye4dVFIINvAS2ZCkT6C+VogJvG7rf1bhch6vBdGa7b6Pje/kUovZsM1Rrf4pKv5T2EUP5XnvjnMRA6WY4mBuPNjGnT4J/FAsMyP3U61ZQDfqx6vZzSnGacN2t3Mz4eQv6ZyzpANyBSo+NGnuMEK3/czs4IAFMiRFlQxf7UwDhn/30gRLeFvDd7wL9iGU4Fi/tay4UfEBc0WYIZKrqRPnM+rBOF8i6Rzcu1q7b06/W4sIfgHxotm6WqtUVqxeghdjnR1Lf1McgNdHXfdBfcZr3xuHzBI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(5023799004)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oBspLnJAoa382PJnMmWE/Pr3l5k8Nx+fB5i6tJtj0eqe9HQbHGfT7KqnDF?=
 =?iso-8859-1?Q?xtmmC20sfZz8gsGF10NuD9YVWjBcuJmHPdK9I0PVt2zz+oOdBtcLIo6UZf?=
 =?iso-8859-1?Q?shlcWJ6pBoUAREwhzcqRHSx1UUz1y9cPSyqGT4vfRHyxI2+MR+Bu4penrq?=
 =?iso-8859-1?Q?UgYw50VunljxiRY3l/KFsFDTwSHRk+NUS+k78bZQoWhQ5tpUy9bly0DY4D?=
 =?iso-8859-1?Q?eWnJgzMofKRk4G+GGFCJf8chhdHQ+7vP8zeRfgfG695LhkkXEA7B7I7pOl?=
 =?iso-8859-1?Q?qd3c6gRaTlSZjf1CCer9giqp2uAtu5I1amNUz+S14uHg09XFQlas3CdC95?=
 =?iso-8859-1?Q?2t+wewV84qOvHF+Lqdhb7NVKdHQeJ8hthKSyN0jlLn9e8k097zby6/GEif?=
 =?iso-8859-1?Q?isPOhJk1pwK/WhQg0YcnBY2oIHxRgshkIra21WGIxBs3/GrLdUaeyOByLj?=
 =?iso-8859-1?Q?FLYTAo5IfuVkDKcQGIDRid8glkS+x+YAAj67G2oWE4jYil1TdMGW6yfZIn?=
 =?iso-8859-1?Q?UJpucbsggMv3cEwuNgb66IFxDG5QN+5Lty5FM5ymNjeae7SOXxOUiK+P4S?=
 =?iso-8859-1?Q?XArjRYFb8C/No6q18CTa3yqELO+dG1qGDLCKcBEVgCLJ8gljSwJksu4ZqY?=
 =?iso-8859-1?Q?TF0CyuNh3dv1/nLrFiKDowffLG4lxwsh0fV/zwYrO040F3crxl5P79qeR6?=
 =?iso-8859-1?Q?EWOydgb5aETCnyMnmMOWSolxa76tRAH8TGaDCexabv39aw0Qq34TANmGWm?=
 =?iso-8859-1?Q?xuu251ldL3RoulWwx6Hdub2zRKhqAYVgV5SOSyxnAg7s8ioL6IMtWJYUYd?=
 =?iso-8859-1?Q?Eo7c3wyHvaZSv+br4YfjKtzmBVr4c3J80eSlrxSq3uhbNfa+onoQYoR95C?=
 =?iso-8859-1?Q?txHf6V4ZfuMW6WcJCC+/8HAS6zsONHHW2NvyA/Or29ms67YqjzIVL/D0AU?=
 =?iso-8859-1?Q?cMBbkO1VJiCdaPf4isJxLSJsm+vU7s4C4c+P+U1qR11FrtBL4SFpGIKbaS?=
 =?iso-8859-1?Q?/EgefpbJgJmaiwzhtpVtBrFP2aHUNt/5BHyfGr9YGeqy8A77WyKUEaWAa5?=
 =?iso-8859-1?Q?s9uDGArR7874pISP2tRQuLEOevUxEDbWkPpJHMn+y1RquC6xso00Ce1gIC?=
 =?iso-8859-1?Q?L4dN0yN2XTUbqES5mvrR9XcXQskv1knHHlyrJ50kXjXYBf+PJc9F3lTxIF?=
 =?iso-8859-1?Q?JTfJOMcLaZKqSQTYS9Dz7JGKXZ5cL6cqG2pim8U04l4j2JzqTSRwUqPZ+e?=
 =?iso-8859-1?Q?jZdTwAHJTycFUILF4DITzI5F/5iik0JEBYugbqdap8m8ceKA8rCOSWy5Uk?=
 =?iso-8859-1?Q?gwBKavhwWplp2wCGB0uHo1r8rJ/uhD1D7XvXaAr7yB7ZzgnU69oMAW2hm5?=
 =?iso-8859-1?Q?K2sA97LYrM4mWsCm6qwpgbdkMqcss4CnzLDpKVLTdQmMyZPbN/53jHXtus?=
 =?iso-8859-1?Q?GZ7+0JVlab9gH2HYJ79gaKVAnzXfpmPbQ9+AiyEDxPFsNKf8cyDsBZnRVt?=
 =?iso-8859-1?Q?a17++Cl1cuyMOgMPMqCanXFJvlRzaEZ9v7Eyxy+uBntOxj5M3eWk50wVej?=
 =?iso-8859-1?Q?kbr4voAgQhX7WKnivQ4G0x9345btUHw0LsSKQNqD6mYRX5xkJqsMSDiZls?=
 =?iso-8859-1?Q?olXyTIQ5qBQ04+OvoV6pV+T+7igb0L/vdwvIPE2733b41Xi6zYqEvRqh5V?=
 =?iso-8859-1?Q?QHy2AHZjaIU1nA+Xy9NXl626YAxgvMR+wwYqczAg6tgw8NKig+qyy2jZKf?=
 =?iso-8859-1?Q?X9RKcTsg3Av/DWhGzlSaxARS2CpkkodHdlMfRpYAwWCXWtYbz//MzoLUPf?=
 =?iso-8859-1?Q?pCBD/g7jUA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kU39EG7xnvsVK3ELGG/GniEX/KdcyAc6pGG7TQ4tYkBf/EPkel58elsbMOMEWdm6+xMkwkQtVFQKjteytS8KqY2ScY9guj6ZrbsYy0EHhAVVdxjRU6GSTwH3Kyr4MmkxmD2QozLgJGS9WuCkYQZEvwFuN9YAUlY/MJuItZ3SFrKjwotA67cCT/qsoRG3QnGYY5u53vb4z/A3VE/9oNG7T/GQ7fIzVS8C1O+Kq/AoCiZ5unHRQ8fVPUcf7QmW7ZXm5qI9oJDaKkl4oW3//tfSHB7lw4lOI7jsxrAcdxAInNXNIpC4c2F+q6qveFJWTn24HfsyLkwUiNKlRTMEkuhduA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff4d950-ad7f-41fb-7256-08df2806db9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:16:42.8019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFBWpu+VOp7KrRjTSku3U8A/bnNAWP4G+1aFmtwYBWpyJF0pePKHuGxG3QIyswwpPeuaEb2P0mFLqfMVWRjCRsd98HycWawddPc1qx9Qk18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5398
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

Send bulk and interrupt packets to the device and return the result to=0A=
the host. Each one is a request and an answer, so they reuse the packet=0A=
tracking added for control transfers.=0A=
=0A=
A bulk request carries a 32 bit length, so the host can ask us to=0A=
allocate up to 4 GB. Refuse a request that big. Do not answer it with=0A=
fewer bytes instead: the host counts the bytes it gets back, and it=0A=
resets the device when some are missing.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 203 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   5 +=0A=
 2 files changed, 208 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 22083394ab..a46d7aec43 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -82,8 +82,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SER=
VER)=0A=
 #define USBREDIR_SERVER_MAX_EP 32=0A=
 #define USBREDIR_SERVER_EP_IN_BASE 16=0A=
 =0A=
+/*=0A=
+ * The bulk length field is 32 bits, so the host can ask for up to 4 GB.=
=0A=
+ * This is the largest transfer accepted.=0A=
+ */=0A=
+#define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
+=0A=
 #define USBREDIR_SERVER_CTRL_SETUP 0=0A=
 #define USBREDIR_SERVER_CTRL_STATUS 1=0A=
+#define USBREDIR_SERVER_BULK 2=0A=
+#define USBREDIR_SERVER_INTR 3=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
 typedef enum {=0A=
@@ -96,7 +104,9 @@ typedef struct USBRedirServerPkt {=0A=
     USBPacket pkt;=0A=
 =0A=
     /* Saved headers for the usbredir response */=0A=
+    struct usb_redir_interrupt_packet_header intr_hdr;=0A=
     struct usb_redir_control_packet_header ctrl_hdr;=0A=
+    struct usb_redir_bulk_packet_header bulk_hdr;=0A=
 =0A=
     /*=0A=
      * The IOV points here. IN data lands in it, OUT data is copied in.=0A=
@@ -428,6 +438,52 @@ static void usbredir_server_ctrl_status_complete(USBRe=
dirServer *s,=0A=
     }=0A=
 }=0A=
 =0A=
+static void usbredir_server_bulk_complete(USBRedirServer *s,=0A=
+                                          USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_bulk_packet_header resp =3D rp->bulk_hdr;=0A=
+    bool is_in =3D !!(rp->bulk_hdr.endpoint & USB_DIR_IN);=0A=
+    int actual =3D rp->pkt.actual_length;=0A=
+    int len;=0A=
+=0A=
+    resp.status =3D usbredir_server_status(rp->pkt.status);=0A=
+=0A=
+    /* Only an IN transfer carries data back. */=0A=
+    len =3D is_in ? actual : 0;=0A=
+    resp.length =3D len;=0A=
+    resp.length_high =3D len >> 16;=0A=
+=0A=
+    trace_usbredir_server_bulk_complete(rp->redir_id, resp.endpoint,=0A=
+                                        resp.status, actual);=0A=
+=0A=
+    usbredirparser_send_bulk_packet(s->parser, rp->redir_id, &resp,=0A=
+                                    len > 0 ? rp->data : NULL, len);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_intr_complete(USBRedirServer *s,=0A=
+                                          USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_interrupt_packet_header resp =3D rp->intr_hdr;=0A=
+    bool is_in =3D !!(rp->intr_hdr.endpoint & USB_DIR_IN);=0A=
+    int actual =3D rp->pkt.actual_length;=0A=
+    int len;=0A=
+=0A=
+    resp.status =3D usbredir_server_status(rp->pkt.status);=0A=
+=0A=
+    /* Only an IN transfer carries data back. */=0A=
+    len =3D is_in ? actual : 0;=0A=
+    resp.length =3D len;=0A=
+=0A=
+    trace_usbredir_server_intr_complete(rp->redir_id, resp.endpoint,=0A=
+                                        resp.status, actual);=0A=
+=0A=
+    usbredirparser_send_interrupt_packet(s->parser, rp->redir_id, &resp,=
=0A=
+                                         len > 0 ? rp->data : NULL,=0A=
+                                         len);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -497,6 +553,12 @@ static void usbredir_server_packet_complete(USBPort *p=
ort, USBPacket *p)=0A=
     case USBREDIR_SERVER_CTRL_STATUS:=0A=
         usbredir_server_ctrl_status_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_BULK:=0A=
+        usbredir_server_bulk_complete(s, rp);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_INTR:=0A=
+        usbredir_server_intr_complete(s, rp);=0A=
+        break;=0A=
     }=0A=
 =0A=
     usbredir_server_pkt_free(rp);=0A=
@@ -873,6 +935,105 @@ static void usbredir_server_get_alt_setting(void *pri=
v, uint64_t id,=0A=
                                USBREDIR_SERVER_REPLY_ALT);=0A=
 }=0A=
 =0A=
+static void usbredir_server_bulk_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_bulk_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int pid =3D is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;=0A=
+    struct usb_redir_bulk_packet_header resp;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    uint32_t len;=0A=
+=0A=
+    if (!s->host_connected || !device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN: what the host asked for. OUT: what the host sent. */=0A=
+    len =3D is_in ? (((uint32_t)hdr->length_high << 16) | hdr->length)=0A=
+                : (uint32_t)data_len;=0A=
+=0A=
+    /*=0A=
+     * Too big. Tell the host the transfer failed.=0A=
+     * Do not send back less data instead. The host would see the=0A=
+     * missing bytes as an error and reset the device.=0A=
+     */=0A=
+    if (len > USBREDIR_SERVER_MAX_BULK) {=0A=
+        resp =3D *hdr;=0A=
+        resp.status =3D usb_redir_inval;=0A=
+        resp.length =3D 0;=0A=
+        resp.length_high =3D 0;=0A=
+=0A=
+        trace_usbredir_server_bulk_too_big(id, hdr->endpoint, len);=0A=
+        usbredirparser_send_bulk_packet(s->parser, id, &resp, NULL, 0);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    ep =3D usb_ep_get(device, pid, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->type =3D USBREDIR_SERVER_BULK;=0A=
+    rp->bulk_hdr =3D *hdr;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, pid, ep, 0, s->next_id++, false, false);=0A=
+=0A=
+    /* OUT data comes from the host. IN data is written by the device. */=
=0A=
+    if (!is_in && len > 0) {=0A=
+        memcpy(rp->data, data, len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_bulk(id, hdr->endpoint, len);=0A=
+    usbredir_server_submit_to_device(s, rp);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The host sends an interrupt_packet. It is a request: interrupt OUT=0A=
+ * data to write, or a single IN request to answer.=0A=
+ */=0A=
+static void usbredir_server_interrupt_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_interrupt_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int pid =3D is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    int len;=0A=
+=0A=
+    if (!s->host_connected || !device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN: what the host asked for. OUT: what the host sent. */=0A=
+    len =3D is_in ? hdr->length : data_len;=0A=
+=0A=
+    ep =3D usb_ep_get(device, pid, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->type =3D USBREDIR_SERVER_INTR;=0A=
+    rp->intr_hdr =3D *hdr;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, pid, ep, 0, s->next_id++, false, false);=0A=
+=0A=
+    /* OUT data comes from the host. IN data is written by the device. */=
=0A=
+    if (!is_in && len > 0) {=0A=
+        memcpy(rp->data, data, len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_interrupt(id, hdr->endpoint, len);=0A=
+    usbredir_server_submit_to_device(s, rp);=0A=
+}=0A=
+=0A=
 static void usbredir_server_filter_reject(void *priv)=0A=
 {=0A=
     trace_usbredir_server_filter_reject();=0A=
@@ -896,6 +1057,24 @@ static void usbredir_server_interface_info(void *priv=
,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
+    struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
+{=0A=
+    /* We do not advertise bulk streams. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_start_bulk_receiving(void *priv, uint64_t id,=
=0A=
+    struct usb_redir_start_bulk_receiving_header *hdr)=0A=
+{=0A=
+    /* We do not advertise this. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_bulk_receiving(void *priv, uint64_t id,=
=0A=
+    struct usb_redir_stop_bulk_receiving_header *hdr)=0A=
+{=0A=
+    /* We do not advertise this. Nothing to do. */=0A=
+}=0A=
+=0A=
 static void usbredir_server_cancel_data_packet(void *priv, uint64_t id)=0A=
 {=0A=
     struct usb_redir_control_packet_header resp =3D {=0A=
@@ -944,7 +1123,9 @@ static void usbredir_server_cancel_data_packet(void *p=
riv, uint64_t id)=0A=
 static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
                                            USBRedirServerPkt *rp)=0A=
 {=0A=
+    struct usb_redir_interrupt_packet_header intr;=0A=
     struct usb_redir_control_packet_header ctrl;=0A=
+    struct usb_redir_bulk_packet_header bulk;=0A=
 =0A=
     switch (rp->type) {=0A=
     case USBREDIR_SERVER_CTRL_SETUP:=0A=
@@ -955,6 +1136,21 @@ static void usbredir_server_send_cancelled(USBRedirSe=
rver *s,=0A=
         usbredirparser_send_control_packet(s->parser, rp->redir_id,=0A=
                                            &ctrl, NULL, 0);=0A=
         break;=0A=
+    case USBREDIR_SERVER_BULK:=0A=
+        bulk =3D rp->bulk_hdr;=0A=
+        bulk.status =3D usb_redir_cancelled;=0A=
+        bulk.length =3D 0;=0A=
+        bulk.length_high =3D 0;=0A=
+        usbredirparser_send_bulk_packet(s->parser, rp->redir_id,=0A=
+                                        &bulk, NULL, 0);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_INTR:=0A=
+        intr =3D rp->intr_hdr;=0A=
+        intr.status =3D usb_redir_cancelled;=0A=
+        intr.length =3D 0;=0A=
+        usbredirparser_send_interrupt_packet(s->parser, rp->redir_id,=0A=
+                                             &intr, NULL, 0);=0A=
+        break;=0A=
     default:=0A=
         return;=0A=
     }=0A=
@@ -997,6 +1193,8 @@ static void usbredir_server_create_parser(USBRedirServ=
er *s)=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
     s->parser->reset_func =3D usbredir_server_reset;=0A=
     s->parser->control_packet_func =3D usbredir_server_control_packet;=0A=
+    s->parser->bulk_packet_func =3D usbredir_server_bulk_packet;=0A=
+    s->parser->interrupt_packet_func =3D usbredir_server_interrupt_packet;=
=0A=
     s->parser->set_configuration_func =3D usbredir_server_set_configuratio=
n;=0A=
 =0A=
     /* The parser calls these directly, so they must not be NULL. */=0A=
@@ -1008,7 +1206,12 @@ static void usbredir_server_create_parser(USBRedirSe=
rver *s)=0A=
     s->parser->device_disconnect_ack_func =3D=0A=
         usbredir_server_device_disconnect_ack;=0A=
     s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
+    s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
+    s->parser->start_bulk_receiving_func =3D=0A=
+        usbredir_server_start_bulk_receiving;=0A=
+    s->parser->stop_bulk_receiving_func =3D=0A=
+        usbredir_server_stop_bulk_receiving;=0A=
 =0A=
     /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 25219a018a..c9ab80c6ba 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -411,3 +411,8 @@ usbredir_server_ep_info(unsigned idx, uint8_t type, uin=
t16_t mps, uint8_t interv=0A=
 usbredir_server_control(uint64_t id, uint8_t requesttype, uint8_t request,=
 uint16_t value, uint16_t index, uint16_t length) "id %" PRIu64 " type 0x%0=
2x request 0x%02x value 0x%04x index 0x%04x length %u"=0A=
 usbredir_server_ctrl_setup_complete(uint64_t id, int status, int actual) "=
id %" PRIu64 " status %d actual %d"=0A=
 usbredir_server_ctrl_status_complete(uint64_t id, int status) "id %" PRIu6=
4 " status %d"=0A=
+usbredir_server_bulk(uint64_t id, uint8_t ep, size_t len) "id %" PRIu64 " =
ep 0x%02x len %zu"=0A=
+usbredir_server_bulk_complete(uint64_t id, uint8_t ep, int status, int act=
ual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
+usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, uint32_t len) "id %"=
 PRIu64 " ep 0x%02x len %u"=0A=
+usbredir_server_interrupt(uint64_t id, uint8_t ep, size_t len) "id %" PRIu=
64 " ep 0x%02x len %zu"=0A=
+usbredir_server_intr_complete(uint64_t id, uint8_t ep, int status, int act=
ual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
-- =0A=
2.53.0=0A=


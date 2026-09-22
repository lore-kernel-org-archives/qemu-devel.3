Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135FCC982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOR-0007am-GV; Tue, 22 Sep 2026 05:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wON-0007Yy-MJ; Tue, 22 Sep 2026 05:02:23 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOL-0002Bc-9i; Tue, 22 Sep 2026 05:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ll1FX3gc080kFqk2ZmKOm2M9X6QCQCG45KQTk8PBSXhTL2RaWctErTB8pEW5EsUtuEN4q0pdQbsDpTApTrp0oDxJi51GxsPr0wRVkLTf/TD7t9GrKufnEnH69nj4gkSlzYwo8Wd36wIV/k5tiJ5p6W/Epjb1WsjpNh1uiurI6gNNNHu1Cq11QeZ3xukFeM+KqFcrqVFKn/wYWUcyozq9BljQN5gMiQ88+jur1qIFgqG2LtztQT+Yzi4fAifi2uJ2nqjc49aE0Ap2FOwxjm9OAyzOSv3mrY2+UOm/jZLDYILWTBkKSDIBIldonZ5ja2QwV4pThvfjiIVaXbykUTpxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruenKFtUM7UzHY/uPz9dr4ueL6wb67G2b6e4NfL52/U=;
 b=H3w5dW9GCOMLm7y/5IL03qM78NjXbBWRppoVdhKpFhhR3exaoufe5fE+FLdOBC5feZR52lICAxZ/n531tihNLd8DnLc2a89MD8Mhg4u1FBsk//o5rvIMeLbSVdC/sRCIdz9Y09Xo5FOvoSdI49cWRiHkn6Jh1g0z4m1NLtin7/oxPvWHIyv7ewjbrqsg/wfsyEYqi0JUU/Jve62dOKwwg9NPMddO1PPmJ+crSgG9+wDBXRap/yGgCJvQWArE3nLxGbLjczSSGVlhKZ3QVr9CrU86TFonIbYJ/MIS/lDS83SHPTKsFjQRuPr3nBnbWEnz5I+vb/5KARscu8sFNyy7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruenKFtUM7UzHY/uPz9dr4ueL6wb67G2b6e4NfL52/U=;
 b=e98EZ3jJuoqtbbNJEGzLcJ41qNEr/NPZ8EwzGScdN5mMhll5onJE2jf0fGXVhsaE4UQU3FAdi8gWd3Qz9qDYYwC0eufRb72epGeNmXdmDyzldtHwdWw4Z3FXUFJTkK9A5c19qmR8UvpKeclG92VfIt2UVCBwS1Nx09TVo6nxZXJgBWRv7xs2yQozwUQJdmB9oemgvTnfW1LMDzbXkcgfQ5U/0Uvv21ADUb8QbFuxh/J7acSkTCq8qA9T0uVFp+4PIoE9tyUtjkvICQkv63WJv0ynu3wjiB6Z70J0Jp7L3GgQwPJrxTWBGfcuWckU+f0tVABKGWMTK1SbgrsLnG/zFg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI2PR06MB5090.apcprd06.prod.outlook.com (2603:1096:4:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 09:02:03 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 06/19] hw/usb/redirect-server: Implement bulk and interrupt
 transfers
Thread-Topic: [PATCH v1 06/19] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Index: AQHdSnEIghL6s6qOb0S+dK8A4y8Quw==
Date: Tue, 22 Sep 2026 09:02:03 +0000
Message-ID: <20260922090154.1792077-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 02650124-8836-4a00-3b89-08df18882b60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|5023799004|6133799003|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Qg9vqdWEIHDM0exFI3I3Ze9AzQKDN+z1E2c6pe/NeX7aHZGUMT4rbaMQqJT15RNAslaRfMbSsCIhp3CBn2makDHa4uMW140+U+8S/H+v2X1ndDKgKxPuBfN2QH91hUvkM8XPn+q/jBL2tkI+yNyPmEavCzAOdC8bPIoebvTBVzWjU0g+lpWGoJXQBmTCWZLzo9hUEdAn2j7GJ/6Ch1D3NigAD9VnHnsgnSldEhUyys1yQFktYo5u7aXeScI5SrLc6Uhtgjpjx+lkZNupNLp7aRhQObD1XWHjytJeFs6+KzsJEL9av2V+2i+1+7+qbgbf61m3thKQ8eKHG9bNQ1MIWePbU82v4V+uqsbClt04ZIqak8b5IWM1zjnDPFWNsY6XwDjrUxO4lSGwOEDqJW1Js5qOhpyiRt1b2f3Gy75AU0N/1Dn2N87BzDdu0GENa2YFZG7nwmm5icCsELY3Kft9A4xv67PFl4b3/AKmjnJrbqseogzXxu4ZEu8c34hlTn+ClnyI3+XUEaVcMmFjongyBVdA5VuULGri27bt3ymSa+x1yH2FoLOTGj8x1O0mEfG1jbJcNC0pIIEp4VfBECtoJsApV/PjqYmNiCQr2kWXx+AHjitLnP2quDwevnqP2zB+BHlFfQ+JeVK1Bgv4ro/wt69ccGGxHOVeQBZZXxEOVhoPCnIb7LtlSoNvMugbDs/Efer17Rp3VePw75I/A8Q1FloWovP/JWErHw1Aa5RUNhM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(5023799004)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3FVJNeJ4PhzXKf5DLINLcAW+z9Zwo3u49+o4usmqa9/frWmgvwdxJWPfsL?=
 =?iso-8859-1?Q?QHC+gogdpZE9ni/74Wo3mFN8hrCCuW19giJn7oAVFj8K1fHktL1NPpOAOi?=
 =?iso-8859-1?Q?/MVzf716ObwwZh1Tl5fvfQhzWb/IRIdoXOGG0llP866MqVi5f+O+BbXKgx?=
 =?iso-8859-1?Q?otipgK5YrSsARqvUWf5qfvhYamvYSu0+HgLI/1p4NcJ2ciotZCPsNv98K3?=
 =?iso-8859-1?Q?+8KrUIIckEgIx+21Kj3X/gGwW1P4RM/70Uf+PE0j7CkUbQj48cu0G81syF?=
 =?iso-8859-1?Q?z5BZAkOIQ6JcACEIOPyh6Trcj6QXRb6SazPw7JXgO4rivJ4QIOzC0cs2iM?=
 =?iso-8859-1?Q?IUxrmRs0HT4eou+BjN83Y1eMGrmX5tFxwNRNBjqhkR+LXEgnfW5j+qgnLF?=
 =?iso-8859-1?Q?u1bHeK3HUGHxXcwxs/FcH2rz6RXRFhBelNaEZ53U1c084Ljc/k4bZuJq0u?=
 =?iso-8859-1?Q?eNUNA+AkbyVLPYIHnf6DywZlC4Z5t94c5HzyDl3fe7rJmbDe+tRWm323oT?=
 =?iso-8859-1?Q?LoHacWajS27gB1XOMDjGU6ZVS+T877MhnY5dTx1qmBSDdYJqvU7WcsPjIl?=
 =?iso-8859-1?Q?e4Ao+v/jJBRV7Kt/y2Ip4JOXH/etzxFsDhVkXU8zVEg0GIo4io5xG83gvw?=
 =?iso-8859-1?Q?sP3TP1rOG39KNqtV9csFMrbyHEOQcuXL+PzXShgrKqwAMEtoR47y+B5agv?=
 =?iso-8859-1?Q?m6FIgPitqMCKhF0tKkmEE0cpa0gJxwifO6C7n5yW1SNdboEaY/lRsemwKZ?=
 =?iso-8859-1?Q?4ZQIwM/tniJlrSAsF92C1UfYia/yTHH4k5dDyH1ZJbJi/fVuu4e+P8B3c0?=
 =?iso-8859-1?Q?R1bO7aRdjAiyRet23jXQbgH1xUdL77SdZ85DTQEtUGGAJF0fwUv3TIvwrz?=
 =?iso-8859-1?Q?//aegwpRSUcUk0yRMnqS7uMk2bst/orRoMUGAlK+PejT5qAhXcpeXyxiSQ?=
 =?iso-8859-1?Q?Bhow/qIgXoX2eXWSgTPTWyTG2xJtjG4IPTrBCE9AnaTmSPyOacpAQ+QG6w?=
 =?iso-8859-1?Q?iZI3f+LAjnBVdIHWeYg/s9GeFf+0rkGS+/EjLoxi2zMJdc1aVWgig1WLrk?=
 =?iso-8859-1?Q?aWRJPppHkA53M7s1d+NMAGzjaavxuHk/tDHkEmp9gzAvpdXt5lhRxglbD3?=
 =?iso-8859-1?Q?VBHHY+qUsaTdXXSDsnPy0fvstH8Lkvhh7Mn92D1Zzh4jpSQvk2YKSSqjB7?=
 =?iso-8859-1?Q?HNKvB1GlirRlOrArdtd2R4QWUnB7jJgGIlM7snFdApxP7sNpQMG93gyDp+?=
 =?iso-8859-1?Q?bKPuqotFRqxWiIMHikmi5MLqAiqKJ2JSbtYxABr4VlL7Ar0kEOXx8VRlGa?=
 =?iso-8859-1?Q?a5wv1nztod0ydsc1qrTeiU35UBrfJwhbOsqw+r9WAShL4MV2ecR3+9cLST?=
 =?iso-8859-1?Q?k6I5+7Y1fpIjxFFULRvUtktnz+qJweGL9tEhgFZTsCTPxjQD1Loascsr/q?=
 =?iso-8859-1?Q?3yteah4Z0U93HM5nWzTDrAc8mqXmQMdFrwnlxfzswIFSVyMSdVGPWJ1zmY?=
 =?iso-8859-1?Q?EOEv4HnC4VL9lEygvwcCn4eWCEhpFa9aBvp+mAYcSVsOoA2uwxP5P7A0n8?=
 =?iso-8859-1?Q?aeOonqZekcS25ZbwiiOJVtfTnQg6n1+m+VjfpixTzaAwiwtY0kqhTcRTUM?=
 =?iso-8859-1?Q?w4I8BILOpUWaFRAWP2FY6QY9eZhY22c0Lvyx0x5Q7NYVLykmFz0joPEzlN?=
 =?iso-8859-1?Q?uyxoTSvYkXK1oZH8n920Tc13fNuHHHHWJl3cuz41MuLj8lKzi2qnaMcaiy?=
 =?iso-8859-1?Q?P+knTu6rYinb6EUmuDz4c+H3z63jqcusbFURMX9w+BfW7ZQ+d4svMzPNLZ?=
 =?iso-8859-1?Q?Yv+o4/KY+g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M2oi3wv2sgO0UoGzhpBF7cQnEr7QBii92Tpsg+xsnaTcXbaBsuw8ec2IutMiGpDPJV81IyQoFzItaw93b333ZMOr23aYMCyHZnHBQ9osxE7Ne0YtF+vwjxNYsRvM8Z9E0TYYqE7FltZvfPhqpXmS0pn42ELVRyxH74nkTmNcqGotl2ztncu6tD13QMPxOlG4QS5D9V756GE/Q9fyEG8SNpqjUIvbwVMeSm+ljb/EugO7+aG6sbILRKh3rFjd3qUTAe6JxX02TXr+HsKnVnZLBI0PiRW8UqIT5TeenwmWHaNDoHbdjIDfkZfNDeiUiwW1o05stwtW6BIQwMSDrQcPFA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02650124-8836-4a00-3b89-08df18882b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:03.2198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P247/6icC82ZplIqDTPD3iFUV5qLYr8W3Ae9yYmxJWhFhp23+2QAQoo14dFxyc8wO8ElU5lB7dpjOxCfj3ANwvYWHrgw4VNOLQ0uQLZ+oFY=
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
 include/hw/usb/redirect-server.h |  11 ++=0A=
 hw/usb/redirect-server.c         | 193 +++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events              |   5 +=0A=
 3 files changed, 209 insertions(+)=0A=
=0A=
diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-ser=
ver.h=0A=
index 83c4524040..f7b2261db4 100644=0A=
--- a/include/hw/usb/redirect-server.h=0A=
+++ b/include/hw/usb/redirect-server.h=0A=
@@ -9,6 +9,7 @@=0A=
 #ifndef HW_USB_REDIRECT_SERVER_H=0A=
 #define HW_USB_REDIRECT_SERVER_H=0A=
 =0A=
+#include "qemu/units.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
 #include "chardev/char-fe.h"=0A=
@@ -27,8 +28,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SER=
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
@@ -41,7 +50,9 @@ typedef struct USBRedirServerPkt {=0A=
     USBPacket pkt;=0A=
 =0A=
     /* Saved headers for the usbredir response */=0A=
+    struct usb_redir_interrupt_packet_header intr_hdr;=0A=
     struct usb_redir_control_packet_header ctrl_hdr;=0A=
+    struct usb_redir_bulk_packet_header bulk_hdr;=0A=
 =0A=
     /*=0A=
      * The IOV points here. IN data lands in it, OUT data is copied in.=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 5005ea5f8a..a733a007e3 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -356,6 +356,52 @@ static void usbredir_server_ctrl_status_complete(USBRe=
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
@@ -452,6 +498,12 @@ static void usbredir_server_packet_complete(USBPort *p=
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
@@ -828,6 +880,105 @@ static void usbredir_server_get_alt_setting(void *pri=
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
@@ -851,6 +1002,24 @@ static void usbredir_server_interface_info(void *priv=
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
@@ -899,7 +1068,9 @@ static void usbredir_server_cancel_data_packet(void *p=
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
@@ -910,6 +1081,21 @@ static void usbredir_server_send_cancelled(USBRedirSe=
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
@@ -952,6 +1138,8 @@ static void usbredir_server_create_parser(USBRedirServ=
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
@@ -963,7 +1151,12 @@ static void usbredir_server_create_parser(USBRedirSer=
ver *s)=0A=
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


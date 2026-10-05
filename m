Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26172CA5FE2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZG2-0003ki-NH; Sun, 04 Oct 2026 23:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZG0-0003kM-PS; Sun, 04 Oct 2026 23:20:52 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDZFy-0000RH-A7; Sun, 04 Oct 2026 23:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aEKL4CWiF/37bSG+kYNZ1wJGociPJy3R73IOpnBNmBbMI1UnbddiNxTDI9siPfOhUqS9rc8Zq4FQ9TYyxmG34kcUD5uP4TugO62tSXT+fG98dIGONSNd7J+B+z2oVC/FFauFq7N8UsUVIqN5UNNTjSbrfS51okirD06yWQqVkXiL3qG0xRcJAOHOOIos6hNpgeotDB2uFa4aNVbaUc9QnE5N424AAtATr0ft/qg8l7cX+JZHshCZiw6xwyVUQSoUE40/efk9+f6wMPcK4o8FTGFj6utRZ5CMvVJYZ4jbfBRelqf+vBb/fu0o8a7Yi7zR2pP4WPX1RkYMouh5sNIMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6PIiRMmNICQ25lVLhcFpyS1Igu7ZxT9ybVSTKRx9LQ=;
 b=XJmdP5VfxY0RAKdY1mIszCgqJPu8rgr74f1JdqQqk/5JVANGpKIh3ijkAPu/eJi3izT8NgqHleeq4ULt70nI7me5oGI5NU36PYHZSN643nUPFq4UB9+4ufBOXC4by6nGgSeGFqTfDV0Rqi6ushi6YyYwnL8796schzxfwE9SSaOyHjP5rLrTlnDp8RHB6xJtlEacKoWclIYFXBAgJxax8PHWIjKFW6I9uwg6QuddRES94/pYw+KRiVfgAgr7aojaXnifm7fR1mQTxwY4Bl3GzyX4Wbo7zqERlncS1mFyUWQI1Nb0IZQUm1mXtbNcFLDj40orCchIjNCwT3dU1bTqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6PIiRMmNICQ25lVLhcFpyS1Igu7ZxT9ybVSTKRx9LQ=;
 b=WSavctVqwnXDc9eoYcBKKalvjkVcc6f6QnuCmz+hLJ1IN0nkVz/vTORva48Doyd96PkflU9hthogVOlfDlQ55/dVhdEOki4DEvpcZ2hQ76w4J0u75KN2Fje1/egVIhWVPLj7JOrXEOs3xMPIx3m05mtsm3qsvavFfrq88SxMrdYE8HJY3hMd+j8JjCQyStcMM98ZAj7e3Ngcmf6Qxi7LqjjTpTgeH6QfEKtlWeNZja9yW2WOMwtvN5inN2vZqQT0XMCQEyDhsBODr5+Hey/PeGqlZcjrcexrLBMBfvHp8fWxlIu2lweTRFkYLdseCTciYuw/n6fVAbmctPw88zALlQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYUPR06MB5945.apcprd06.prod.outlook.com (2603:1096:400:35d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 03:20:33 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 03:20:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane
 Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 7/8] hw/usb/redirect-server: Stream interrupt IN endpoints
Thread-Topic: [PATCH v2 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdVHh79niIwWVTwUCN6umFFWw1bg==
Date: Mon, 5 Oct 2026 03:20:33 +0000
Message-ID: <20261005032022.3980903-8-jamin_lin@aspeedtech.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYUPR06MB5945:EE_
x-ms-office365-filtering-correlation-id: d5754b73-1c0a-472d-26f0-08df228f9dbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|5023799004|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: j8aJmTgq6dUDz26ANdb5Yikd2RpRLzr3KRXEVqNaGf8DqvJxi/468xX6Q9n6EqhEiseUmQwfJvF+8blR/a9naSo5kfoByksE1QFMrWdvgljtf5Qh0oMdGODH4J6Dbo+od1rn/zTkUX+c92BuRwGUfYgcjb2YGawmWEeAXrS+GoqHBp6B4gVgaNYHznJmr2Nt31Ok46+xBhham08YJJEAu1vRlntqyLdE+NvtpriHMSOkIqjLQ75BZMH4i8kq8VuZZVHciY/wwjBxCUVGY4VwSuiwkabxI98OwfKSBXMjy2J8U0b5hqr2HOoj/bIcCmNeEDDDpizHyceRKkP4NwMQjDv67If7mD2J01nCRaLGXhnEXpjdnxENFnn8hDvr6yd1h7oBLAC0+jc6EitCfsCQWTvMrk+o6mX5ZHmvY81QDdidfjC36Vetqo0bsQw0I6f+S06VLgpGA5nBBajjE737l9MMHu6R2GQtMYnRX7iDPh9eeOAzrDquXbPHyDuc0hahOtmC5iHP+WPgQTbKvLUrlXOWHDxLMlululy1iVcjHSykEP/9iZEU1wPx7HWR1xH8ueqz+XB3fROLm4VxvDS7B+MH/jzmGNq0IjWsIihWc3GOsZRYTTPJgDNB1EQwEC5R4W7woCjzkZvqXZ1PrCEuMP0pCBIiRI6hoW56Y03F3CM1J3ZSGIUQqRp46ftq0iuFP7mgK3E+LQPa6bipG7rloYRN5MDNHieB/RtloKAsPm8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(5023799004)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AqOHkawOKutyxv/P+q/VJi998to5nQ1tbDR0w2Z82m9josvoh9uFDqshNVPV?=
 =?us-ascii?Q?BBoCILEcuObXkr938Cp5Gy2khtxVd377h6Dy813Os0nYX9prLeGBmyopKwyj?=
 =?us-ascii?Q?jck1CvQ6+Be8WsTvCjwYd9RsHLtnonntoxLagBG7b1TFdue0ZbGDM5qq06nS?=
 =?us-ascii?Q?0Csq3jWDB513FbL5P2ITCMgyrzWe0zv7wPvovpntEzYqG93pAUA8T92NozgG?=
 =?us-ascii?Q?07pJaGWFh5pd7rxjUKNl6cKApTxv3ZS3/rIuevij0tBsYQPWn9lnRJKuiUmP?=
 =?us-ascii?Q?HnWBV7wDEVDwzpFcX7xrPEtB/tNUWtpfyrAUj0Lb5b9ExU29hTIt4tGRK4Gw?=
 =?us-ascii?Q?4TmKe270B07gBOpr/puqI/bJQUAVaeXjLW1OxOSjeJhDtwMss5soZpNmieb1?=
 =?us-ascii?Q?DUs3fiNZj+kpf4mm74020dO4LsoBv8Yp6fVlkpW7HszDQgbs3oZIkpNWhxbR?=
 =?us-ascii?Q?L2vKh9gTJ5EkBa66OGHnCgAVczhHnNa8eEGT9+1PXaOvYKJPQlv7s5iBCt2J?=
 =?us-ascii?Q?GLzoQ25Fg28lLKZO9jh4uYIV0MidwQ27heopKCdloi509T2/KwgLMj0wSRud?=
 =?us-ascii?Q?C05eagBHJU9BjRhs3c0+Jf67AFAQKFiALh/GJgIf0Nt8QVhgOo2Q/SM6C5y2?=
 =?us-ascii?Q?+u/Bh+m8FuP2d/AWD0rHsFdmjIGWrZFWkfVSRGqM+xX26+j7N7B5J3nGCAm0?=
 =?us-ascii?Q?SOQaXKeq8FSJhfpnwDyXjWfkqdXUwNItKcEstur1mqa3Eq0LEXK70AWYyFAZ?=
 =?us-ascii?Q?wRhS39BNgnW1OS2llzjRDNGJUAAkZ4+Uwoq9CXE5TduSSGCRM7VepgcPbn6r?=
 =?us-ascii?Q?yv6PmV7ZhoWH1U5rYhtJefdAPSFttGI3YlMizhCIYWVexYnyLMtXxcGlLrog?=
 =?us-ascii?Q?KrjA/d+B0o7G6g0GepW137V9yAOIqe+b97tKBhLhZCHyhk0Z+NfxrnQxiAot?=
 =?us-ascii?Q?PFZH0MvQnHK4bQZA8G8sG+G3oEehT2Drwr1qFd5grnl0d47w2drOYZ55lx4W?=
 =?us-ascii?Q?/IVXKYsvrKYXQqFursKznXRKhWcNNqrwhVt0QE5qUgSd5LEAiT6Nre2ao1mV?=
 =?us-ascii?Q?lqXIA/LJ5pFOtmA4gxZMDZEaU+y7tzTto5B1nEnb3uWsCS7NCBxsYsUPXyd2?=
 =?us-ascii?Q?pktFzm4reEUuZeoJwJb6q8sxTKULme7jWvx/r/27k4hwAQsbp88J49auHKBn?=
 =?us-ascii?Q?ZAmqh16w4yWffdTu9mZu0VmE9JSv/UGpzQTrTfA2qkTTYLHN+zM3m6+Gmd94?=
 =?us-ascii?Q?L+3Cqd4FC0VYfUDDb2A5C8PSt9bY9IXWMlGnV+0KGUiSKfqDVrLO6GmmCasM?=
 =?us-ascii?Q?PuGGRNROTsptYqj6NeaMmhYwHeTwq8LAQSSxF3GjDjoAcF+BltKtk4hG+GbG?=
 =?us-ascii?Q?m8yqAaDyf4m3jOH1Y8c1lI99YOiybd31fE7WrSNeoJgkS4THV9C5R8t7a/2N?=
 =?us-ascii?Q?M0mXPKi1fv+mlGssbWwpZyYtXacz6JQCiYuMo3sovslaSSa+qK0LNqj7zEXC?=
 =?us-ascii?Q?NeLxU6FDy6/hq8r2dpOFHJGIdRdeU5anLGhugp7JKSzyx/NH7f9dTIPKwOo2?=
 =?us-ascii?Q?3b5wG7PFH/8Gbus6Ki3XBdxT3L0U7WNzFAxhpYdChwRX3Sngjo3WSpqcOEWS?=
 =?us-ascii?Q?HjtDGqHKtS2zPtTCPWUsvNI+xFErGMqbj3e8mrNhQyGwTOc5FrT1xlbCq0jY?=
 =?us-ascii?Q?CRjyz31bTHOaHNPTtiTkd1eRgkbVgvLVbHOj0wI2AKMI0/C4Mu917Yq7G/TD?=
 =?us-ascii?Q?kcir8ACYxQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UBFWgt3MhMHnVHJnqKGToyVu48MBmFnLW5qQH615zgqLALS+3hjtqiyyHTqwDcAtykt4MuFSGkLXSD63Lvz+fM7GVhNxUuLThnwat2Oe8m6s5qbTs6axLIeihkafttsrtsdWph1iHUjuD27/Izq3btow6kE7uTW2EgLb9aCb34DV9y8R605pSQo1va3izX+Zt1YAjsmn6paEgD3/npYTCI1GKlBKsbp4aZwLXhAXfJPDbjVJYIz8bFewhReEtN3KwtfoNnW8EQ8yu8sW3rybg2ma4bxF6lf2u8my5NumW27hHzvC+Yhf2y/V358GCBANXuGnHMocKYGaI/FXCPOppw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5754b73-1c0a-472d-26f0-08df228f9dbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 03:20:33.1606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CldXBPPQoWwY51khcusd2hdprFlEe06Fpn1wwBOk7+2GX+OJ/7/iXD8uUI5040M8ealj+Y4eWODPCM1VF43mTBOZjsahD0a9CXFwPOCd50g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5945
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

Interrupt IN is not a request and an answer in usbredir. The host asks=0A=
once with start_interrupt_receiving. After that it expects a packet=0A=
every time the device has data.=0A=
=0A=
Park one IN packet on the device for each streaming endpoint. A device=0A=
that answers USB_RET_ASYNC holds the packet and completes it when it=0A=
has data. A device that answers USB_RET_NAK gives the packet back at=0A=
once, so park a new one when the bus reports a wakeup on that endpoint.=0A=
A slow timer parks one too, for a device that does not report a wakeup.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/redirect-server.h |  15 ++=0A=
 hw/usb/redirect-server.c         | 248 +++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events              |   4 +=0A=
 3 files changed, 267 insertions(+)=0A=
=0A=
diff --git a/include/hw/usb/redirect-server.h b/include/hw/usb/redirect-ser=
ver.h=0A=
index f7b2261db4..1fb2a8a7a4 100644=0A=
--- a/include/hw/usb/redirect-server.h=0A=
+++ b/include/hw/usb/redirect-server.h=0A=
@@ -28,16 +28,23 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SE=
RVER)=0A=
 #define USBREDIR_SERVER_MAX_EP 32=0A=
 #define USBREDIR_SERVER_EP_IN_BASE 16=0A=
 =0A=
+/* An endpoint number is 4 bits, so 0 to 15. */=0A=
+#define USBREDIR_SERVER_MAX_EP_NR 16=0A=
+=0A=
 /*=0A=
  * The bulk length field is 32 bits, so the host can ask for up to 4 GB.=
=0A=
  * This is the largest transfer accepted.=0A=
  */=0A=
 #define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
 =0A=
+/* Buffer size for an interrupt IN endpoint before its descriptor is seen.=
 */=0A=
+#define USBREDIR_SERVER_INTR_DEFAULT_LEN 64=0A=
+=0A=
 #define USBREDIR_SERVER_CTRL_SETUP 0=0A=
 #define USBREDIR_SERVER_CTRL_STATUS 1=0A=
 #define USBREDIR_SERVER_BULK 2=0A=
 #define USBREDIR_SERVER_INTR 3=0A=
+#define USBREDIR_SERVER_INTR_STREAM 4=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
 typedef enum {=0A=
@@ -87,6 +94,14 @@ struct USBRedirServer {=0A=
     bool host_connected;=0A=
     bool device_announced;=0A=
 =0A=
+    /*=0A=
+     * Interrupt IN streaming, indexed by endpoint number. intr_bh asks th=
e=0A=
+     * device again; intr_retry does the same after a delay on NAK.=0A=
+     */=0A=
+    bool intr_in_started[USBREDIR_SERVER_MAX_EP_NR];=0A=
+    QEMUBH *intr_bh;=0A=
+    QEMUTimer *intr_retry;=0A=
+=0A=
     /* In-flight packet tracking */=0A=
     QTAILQ_HEAD(, USBRedirServerPkt) inflight;=0A=
     uint64_t next_id;=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index a733a007e3..f84ece02e4 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -69,6 +69,13 @@=0A=
 /* Wait this long after attach before we announce the device. */=0A=
 #define USBREDIR_SERVER_ANNOUNCE_DEBOUNCE_MS 10=0A=
 =0A=
+/*=0A=
+ * Ask again this often after an endpoint answered NAK. Most devices wake=
=0A=
+ * the bus when data arrives, and then the next ask happens at once. This=
=0A=
+ * timer is for the devices that do not wake the bus.=0A=
+ */=0A=
+#define USBREDIR_SERVER_INTR_RETRY_MS 1000=0A=
+=0A=
 static void usbredir_server_pkt_free(USBRedirServerPkt *rp);=0A=
 static void usbredir_server_stop_transfers(USBRedirServer *s);=0A=
 static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
@@ -402,6 +409,63 @@ static void usbredir_server_intr_complete(USBRedirServ=
er *s,=0A=
     usbredirparser_do_write(s->parser);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The device answered a parked request. Send the answer to the host, then=
=0A=
+ * ask again, because the host still wants more. Do not ask from here: the=
=0A=
+ * device may answer at once, and this function would call itself over and=
=0A=
+ * over. Let the BH ask, or the retry timer after a NAK.=0A=
+ */=0A=
+static void usbredir_server_intr_stream_complete(USBRedirServer *s,=0A=
+                                                 USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_interrupt_packet_header resp =3D rp->intr_hdr;=0A=
+    struct usb_redir_interrupt_receiving_status_header st;=0A=
+    int ep_nr =3D resp.endpoint & 0x0f;=0A=
+    USBPacket *p =3D &rp->pkt;=0A=
+    int actual =3D p->actual_length;=0A=
+    bool retry =3D false;=0A=
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
+        /* nothing to report yet; ask again shortly */=0A=
+        retry =3D true;=0A=
+        break;=0A=
+    default:=0A=
+        /*=0A=
+         * The endpoint stalled or failed. There is no data to send, so=0A=
+         * send a status message. The host keeps that status and gives it=
=0A=
+         * to its guest. On a stall the host also ends the stream, so end=
=0A=
+         * it here too. A later request from the guest starts a new one.=
=0A=
+         */=0A=
+        st.endpoint =3D resp.endpoint;=0A=
+        st.status =3D usbredir_server_status(p->status);=0A=
+        usbredirparser_send_interrupt_receiving_status(s->parser, 0, &st);=
=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        s->intr_in_started[ep_nr] =3D false;=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    if (s->intr_in_started[ep_nr]) {=0A=
+        if (retry) {=0A=
+            timer_mod(s->intr_retry,=0A=
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=0A=
+                      (int64_t)USBREDIR_SERVER_INTR_RETRY_MS * SCALE_MS);=
=0A=
+        } else {=0A=
+            qemu_bh_schedule(s->intr_bh);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -504,6 +568,9 @@ static void usbredir_server_packet_complete(USBPort *po=
rt, USBPacket *p)=0A=
     case USBREDIR_SERVER_INTR:=0A=
         usbredir_server_intr_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_INTR_STREAM:=0A=
+        usbredir_server_intr_stream_complete(s, rp);=0A=
+        break;=0A=
     }=0A=
 =0A=
     usbredir_server_pkt_free(rp);=0A=
@@ -521,7 +588,25 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
  * USB bus ops=0A=
  */=0A=
 =0A=
+static void usbredir_server_wakeup_ep(USBBus *bus, USBEndpoint *ep,=0A=
+                                      unsigned int stream)=0A=
+{=0A=
+    USBRedirServer *s =3D container_of(bus, USBRedirServer, bus);=0A=
+    int ep_nr =3D ep->nr;=0A=
+=0A=
+    /*=0A=
+     * The device has data. A streaming interrupt IN endpoint may have=0A=
+     * answered NAK. Ask now instead of waiting for the retry timer.=0A=
+     * Every other transfer already has its request on the device.=0A=
+     */=0A=
+    if (ep->pid =3D=3D USB_TOKEN_IN && ep_nr < USBREDIR_SERVER_MAX_EP_NR &=
&=0A=
+        s->intr_in_started[ep_nr]) {=0A=
+        qemu_bh_schedule(s->intr_bh);=0A=
+    }=0A=
+}=0A=
+=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
+    .wakeup_endpoint =3D usbredir_server_wakeup_ep,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -572,6 +657,91 @@ static void usbredir_server_drop_pkt(USBRedirServer *s=
,=0A=
     usbredir_server_pkt_free(rp);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Interrupt IN streaming=0A=
+ */=0A=
+=0A=
+static bool usbredir_server_intr_inflight(USBRedirServer *s, int ep_nr)=0A=
+{=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    QTAILQ_FOREACH(rp, &s->inflight, next) {=0A=
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
+static void usbredir_server_intr_park(USBRedirServer *s, int ep_nr)=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
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
+    if (!s->intr_in_started[ep_nr] ||=0A=
+        usbredir_server_intr_inflight(s, ep_nr)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    len =3D s->ep_max_packet[ep_nr + USBREDIR_SERVER_EP_IN_BASE];=0A=
+    if (len =3D=3D 0) {=0A=
+        len =3D USBREDIR_SERVER_INTR_DEFAULT_LEN;=0A=
+    }=0A=
+    ep =3D usb_ep_get(device, USB_TOKEN_IN, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len);=0A=
+    rp->type =3D USBREDIR_SERVER_INTR_STREAM;=0A=
+    /* streamed data carries no host id */=0A=
+    rp->redir_id =3D 0;=0A=
+    rp->intr_hdr.endpoint =3D ep_nr | USB_DIR_IN;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep, 0, s->next_id++,=0A=
+                     false, false);=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_intr_park(ep_nr, len);=0A=
+    usbredir_server_submit_to_device(s, rp);=0A=
+}=0A=
+=0A=
+/* BH and timer callback: ask again on every streaming endpoint. */=0A=
+static void usbredir_server_intr_kick(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+    int i;=0A=
+=0A=
+    /* Endpoint 0 is the control endpoint. It never streams. */=0A=
+    for (i =3D 1; i < USBREDIR_SERVER_MAX_EP_NR; i++) {=0A=
+        usbredir_server_intr_park(s, i);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_intr_cancel(USBRedirServer *s, int ep_nr)=0A=
+{=0A=
+    USBRedirServerPkt *tmp;=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    QTAILQ_FOREACH_SAFE(rp, &s->inflight, next, tmp) {=0A=
+        if (rp->type !=3D USBREDIR_SERVER_INTR_STREAM ||=0A=
+            (rp->intr_hdr.endpoint & 0x0f) !=3D ep_nr) {=0A=
+            continue;=0A=
+        }=0A=
+        usbredir_server_drop_pkt(s, rp);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * usbredirparser I/O and logging callbacks=0A=
  */=0A=
@@ -1002,6 +1172,58 @@ static void usbredir_server_interface_info(void *pri=
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
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+=0A=
+    /*=0A=
+     * Endpoint 0 is control and an OUT endpoint never streams. There also=
=0A=
+     * has to be a host to send to and a device to ask.=0A=
+     */=0A=
+    if (ep_nr =3D=3D 0 || !(hdr->endpoint & USB_DIR_IN) ||=0A=
+        !s->host_connected || !device || !device->attached) {=0A=
+        st.status =3D usb_redir_ioerror;=0A=
+    } else {=0A=
+        s->intr_in_started[ep_nr] =3D true;=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_intr_start(hdr->endpoint, st.status);=0A=
+    usbredirparser_send_interrupt_receiving_status(s->parser, id, &st);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    if (st.status =3D=3D usb_redir_success) {=0A=
+        usbredir_server_intr_park(s, ep_nr);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_interrupt_receiving(void *priv, uint64_t =
id,=0A=
+    struct usb_redir_stop_interrupt_receiving_header *hdr)=0A=
+{=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    /* Endpoint 0 is control, and an OUT endpoint never streams. */=0A=
+    if (ep_nr =3D=3D 0 || !(hdr->endpoint & USB_DIR_IN)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_intr_stop(hdr->endpoint);=0A=
+    s->intr_in_started[ep_nr] =3D false;=0A=
+    usbredir_server_intr_cancel(s, ep_nr);=0A=
+}=0A=
+=0A=
 static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
     struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
 {=0A=
@@ -1106,6 +1328,14 @@ static void usbredir_server_stop_transfers(USBRedirS=
erver *s)=0A=
 {=0A=
     USBRedirServerPkt *rp;=0A=
 =0A=
+    memset(s->intr_in_started, 0, sizeof(s->intr_in_started));=0A=
+    if (s->intr_bh) {=0A=
+        qemu_bh_cancel(s->intr_bh);=0A=
+    }=0A=
+    if (s->intr_retry) {=0A=
+        timer_del(s->intr_retry);=0A=
+    }=0A=
+=0A=
     /*=0A=
      * No "cancelled" response here. This runs on a bus reset, a detach or=
=0A=
      * a closed chardev, and the host has dropped its own queues already.=
=0A=
@@ -1151,6 +1381,10 @@ static void usbredir_server_create_parser(USBRedirSe=
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
@@ -1292,6 +1526,10 @@ static void usbredir_server_realize(DeviceState *dev=
, Error **errp)=0A=
 =0A=
     s->announce_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,=0A=
                                      usbredir_server_do_announce, s);=0A=
+    s->intr_retry =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
+                                 usbredir_server_intr_kick, s);=0A=
+    s->intr_bh =3D qemu_bh_new_guarded(usbredir_server_intr_kick, s,=0A=
+                                     &dev->mem_reentrancy_guard);=0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
 =0A=
@@ -1311,6 +1549,16 @@ static void usbredir_server_unrealize(DeviceState *d=
ev)=0A=
 =0A=
     timer_free(s->announce_timer);=0A=
 =0A=
+    if (s->intr_retry) {=0A=
+        timer_free(s->intr_retry);=0A=
+        s->intr_retry =3D NULL;=0A=
+    }=0A=
+=0A=
+    if (s->intr_bh) {=0A=
+        qemu_bh_delete(s->intr_bh);=0A=
+        s->intr_bh =3D NULL;=0A=
+    }=0A=
+=0A=
     if (s->chardev_close_bh) {=0A=
         qemu_bh_delete(s->chardev_close_bh);=0A=
         s->chardev_close_bh =3D NULL;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index c9ab80c6ba..931996e8cd 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -416,3 +416,7 @@ usbredir_server_bulk_complete(uint64_t id, uint8_t ep, =
int status, int actual) "=0A=
 usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, uint32_t len) "id %"=
 PRIu64 " ep 0x%02x len %u"=0A=
 usbredir_server_interrupt(uint64_t id, uint8_t ep, size_t len) "id %" PRIu=
64 " ep 0x%02x len %zu"=0A=
 usbredir_server_intr_complete(uint64_t id, uint8_t ep, int status, int act=
ual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
+usbredir_server_intr_start(uint8_t ep, int status) "start_interrupt_receiv=
ing ep 0x%02x -> status %d"=0A=
+usbredir_server_intr_stop(uint8_t ep) "stop_interrupt_receiving ep 0x%02x"=
=0A=
+usbredir_server_intr_park(unsigned ep_nr, int len) "parked IN packet ep %u=
 len %d"=0A=
+usbredir_server_intr_stream_complete(unsigned ep_nr, int status, int actua=
l) "ep %u status %d actual %d"=0A=
-- =0A=
2.43.0=0A=


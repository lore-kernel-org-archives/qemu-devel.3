Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3043ACC6B29
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtl0-0005ZY-VJ; Wed, 14 Oct 2026 03:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtky-0005YH-BS; Wed, 14 Oct 2026 03:50:36 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtkv-0006yR-Tw; Wed, 14 Oct 2026 03:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njBEQVv9lJbwVbkizbWE/U76bSZlFf7B5d8MwOmSXDsElfVnA+MOyfteZEKRNP6RZU/VswKK1AlXYluzQQ+uizrQxiLvaDaW2r503pYZX8wlvrUmS/CnDJQ8CHETEflhOLxVC5UcHKIewMgCS3czvz3EifXdIHQCichEYTnlNwat2bB24dBBlCNTeJWU66ItAsYvJ5W3Ds5mD3oidGXYqZEjdpsubklDxZ70MFeQge+Fqd61Hul7gdgHFnps9UeBSRQwwh4cTc19RJlXmF0ZU36iq51AKQr4TdplZA5Ozd0vGWa5nqeDzFfCK3fl2+a+YqKepEaQlN+zF98Qkqfttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIz5efoeMHnDBvmoi78vuPOmGgx5R26mRWm1J0DY40k=;
 b=rA1vg4CMBPMa8Tx+4pCqIbDcg8Dw/6JuFwA7xNtXNI4Ahrwjc7L8i8awNcZoSNCiyHm3eZBO68iycSu5qQCemT8espz/l+HdLqcdzDsRz6Ik4MyZG8moVs5+Loq0Vb5VkAS82teJwqLdHiVIWXc4qIyyWLOlOME25LBwyO96I4MVIffDkc0uHB1MYtIVV2rwVr/FZpjdixPCnbIre49LH6gmVVustaLXmLx3mi6FtLIpt8R8q44cLXnt3nRvmfSCyyDwQpoXHNHjetaLNZ0/JQ8tYeL+ms0tsxfPvP4y77zcxcdeq4q8AtPS0lprEdLS3+N+mvaJ8yTbfjfDf/LyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIz5efoeMHnDBvmoi78vuPOmGgx5R26mRWm1J0DY40k=;
 b=QIa4fJ4gxpqAySfr/n8Lz0bCyvbNQZ7g6TzeYwhAFZxk5O0fMJoWhRd+bxHFFnySs7GIkPtBAbxNgULY57jqeQEV2t6EjEcdS/caDLtKRt5SnWnq7T1aWdvLgeVGSwc8lS+nqjoLykQNZDmxuVYLveeYg9ujcN6np/X3gHebp3NTHWNgxo5xH+ek89xRnnjEnF4YzDCzhnkT5/PrTQgprzSMTrdezZt9eQfBv3DjfariQ0/lsNWA17SCKiksC6uNtKVmq7vN1/7fpXYrHsjahfuYDonZWYmAw4tWe2MVL2Q8mkMrRvDf/J0pjbZ3K6XRQiVyVkMUPgGCoO4qtzU1nA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6864.apcprd06.prod.outlook.com (2603:1096:101:1b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:50:19 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:50:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 6/8] hw/usb/redirect-server: Implement bulk and interrupt
 transfers
Thread-Topic: [PATCH v4 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Index: AQHdW7CoJTNo5PLhX0W9SJ3zycBjwQ==
Date: Wed, 14 Oct 2026 07:50:19 +0000
Message-ID: <20261014075011.2708115-7-jamin_lin@aspeedtech.com>
References: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6864:EE_
x-ms-office365-filtering-correlation-id: 613031d6-5155-40b5-77eb-08df29c7cb32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|921020|38070700021|5023799004|261009223027099003|56012099006;
x-microsoft-antispam-message-info: 2e4duETpRZx9J200LDQggClhzHpyH4o1u3CZlwDcaN8Jqty10ZcTLPM/4XDU6C6wvYedoCQ4S8bgu2n0ZrDkQ6Oj7G0zEsYgykfhwiBT6z3izqV4PAU2vt+b37AFdeFr50Rx1BFom7khGhy2vWYWbr4j+zOisLNlAoHwjC4YfaXnWOhbqljtOyLvLno2SvP/1KhEggU7eP0zdZsg8MsUw6MOv0ycwjegsXPGfETABbc7keHeMJDyZO+KKiCBmmLpll84B4b7MEZXKDGAmYdPKAl3RFx0P4iWARRNctdxs+N+JiQl+qNAf2tq1p/xlV/4Z/nP7NYTjR9tAGQGL0z4B2mEZWB2btp6YVyXj8hwC6d4qbHmn75GLkQXCtjnt3WJmzuI/NL+K1UOSPHBvNcJm6N3880gtQVDXsfEoT8wqJb2FtgaT12yn8EVepAhdxATEmyd30ujlhsM6CosS6VASdGjhpgnaClbWl23u+ZTkfdRsf6E4AxYcBEbjVpOeKw21eY73ZM0i4jV8/INOGi1GDsT6xdfOabwR+XymwSzH+ucMy2zQHPEkVgPjkugHukTX8VjN57pjnkwR17I7r6f1qrpXix6UPBmWxcDkLIQ4smgrDGVtePqJ6t54W4F/sUycWX5/D1WBfJPbkIa2RF+VJjDbRnd50FTpiHFWglhTJK3gwq+tMrzZkDRDR3YRiUcjz6TB9gcJ3n4ci2IOvumnLHta82QWQhyykonmvFTyfj3CYImidMj++m0Qu9YkUaX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(38070700021)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SOPLlC/bGp436F66yIqeoPeVbvvNEUKga9MxTXfQ+SuvINzkDkvWJH2Zvt?=
 =?iso-8859-1?Q?r7/DcbYxImP4WNEpGNGdHTomQ5ZBO+UgDvI8ltzhQouRONipnHg/CwCN+f?=
 =?iso-8859-1?Q?b3xYcJuggDLDHgiDc99otLssyLQgzc8J+CkIx2osg3Myymm4vnCWXJEBLs?=
 =?iso-8859-1?Q?ocEF1zuM6Tj0PBXot2h0mg1EomSlwwyC+nB8xeX7J3x0zaaARnSyCLvzbl?=
 =?iso-8859-1?Q?274PuvbzGu4CCNOFrQCZ8ei4ehsBv2eyX+dUi5XYZ4fuer4w3hoSJgcAxg?=
 =?iso-8859-1?Q?yfuxDyla79cTGa6HI74oio1uJsyrt7QSYSZynvyzXHJfrPVKPw2TUxcBU3?=
 =?iso-8859-1?Q?TrGW2eoBrX2zQKYFGwti//PSRByV0z5PPFMHgg4rWu4voURP+3UDCzLwVR?=
 =?iso-8859-1?Q?gj0xczA1KoN98AfJyVcsYl6EKjPQ1GXcmoNhndpXRkavWfjSU6lAaUj2as?=
 =?iso-8859-1?Q?jYbXk9K7qWDldIfpzqomsm0pFsEduZsgcjbMHysJtOC2n4HACU4X0cv5Cm?=
 =?iso-8859-1?Q?73PFjhlpd1gbgkHXjxMO3K0fLeyIXi6klQj5bldWQPRIW1BUpJcMiUgaw5?=
 =?iso-8859-1?Q?lRazpZrKgl1l5DueE7qPUTMzoKqj6FdX8GQ2vRLCIOo9yI6/yND1RbHwdA?=
 =?iso-8859-1?Q?HLVW3MOkPwb49lSX7BO6cqgNtvunGvDIDCTIBSgJ+BRdnByno4giZYZFVG?=
 =?iso-8859-1?Q?6sgO78IujunesLLY4kUoNMLjeM5AqCJKH7mXXs5OGy1dxA92SrtB4OvJ4b?=
 =?iso-8859-1?Q?xLVUPXhUC/jputzt+H3OHbnhoYHnVuLpctUHf78ji7Uy8Va3c5cLGmNL7i?=
 =?iso-8859-1?Q?h20pHkAvc69OSvvHQmOtWmGxZXuYA1TjgJEm1mOLccQu1+h3G/c4Pir+Zg?=
 =?iso-8859-1?Q?ZrthTQZ6koc9NDO5iqV1/AvjD7Ib6/yLtb9LzRtrZAXolmH2WCwNN6uQEz?=
 =?iso-8859-1?Q?WcAOzb89s80Rtb7R2h+3COx3iOM586luTClt7fcBCvQ5zGUFrPoqvqPELg?=
 =?iso-8859-1?Q?Q4auEoiQGEJf4HhVYnBfYbqCBrfWvpqFYz6YPLVAY9c06Vsj63nN/CHwGS?=
 =?iso-8859-1?Q?WOtb/ylV8TPzhQKpuowwiCDSuu6jrV6GSHvFHX2x5+1i1dGquJJag/1Xcb?=
 =?iso-8859-1?Q?Y/RGDRQMqloV2ekkIthgZPAE7xJnZy58Do3MHgHeeN8T/5ZYwFlQf/Bf2Q?=
 =?iso-8859-1?Q?DEWzFcnxIFVG5tjA55j7ieltzlu5jt71W7/kBvcw4WizxMabeXcVybKztU?=
 =?iso-8859-1?Q?BYMVOtZfyQlHaEj9plHZuxknY9UaAsWxvdf/MtNN5jkYBLxUBlYnwO+kYd?=
 =?iso-8859-1?Q?bqDaQkEVz87WeciLMpg+bT+U4fFGeaYlB8FOlpu/Ob9FC/vNWjIIe7+TpY?=
 =?iso-8859-1?Q?o1/75CvUE21vE1iKZ0HJLlEU8bPnva7RxasmvyLpIY0H249/GksrECnWvI?=
 =?iso-8859-1?Q?ZRMtG4pNDzYksded8uHuFt+3WfPS1bmYxQz9ekdAMc+LMo9g+cYjPLOBSN?=
 =?iso-8859-1?Q?NrX4qUGPCQvES8HYB2GQMfuxxvqf2qub24Un2paTMtxRzYs56CDCw0/P+d?=
 =?iso-8859-1?Q?zcOlyWpMomx4iRtoKYxfGNM714FV94UpmdtFr3DQRwHUszSKYzLw8IQaWv?=
 =?iso-8859-1?Q?XHXVtsNFYDZwyTw5cXQCIzYaIWPkwxTiodtSD0kI2L4zJrBc11z7vmZ6wH?=
 =?iso-8859-1?Q?QkSvuHQN8TTrqtaxsYx1GMtYGgJFE1e2dpPV67y2UIlTgHbluYL6H4x/pM?=
 =?iso-8859-1?Q?HwzQoZ7UXVPip8a9N8C14DkKtjoNhKOENDHB5pUAAAGH7hufY9Ohh7a9AJ?=
 =?iso-8859-1?Q?wcdZSwO83A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vk6AFitHuKr/1bwkMZ+Mn/RXcq8I/QPC9BviVU479khr8yt9bZoULyNuK7XCqc+Q6Za/8vECD9YWe22fnjtjtGpIobn7HBPMmBfjx/wWQWkdAYasxGcOmaC3qRijCSDBlIa9eGH0Sa15GLxxs5fCKUIN1owwmH7b8fb4CIufifGm9kjUTMJwa9dim/1u8DyUcxH15PWNRWvdVR5qNgK35xv6nquZvL1jMzCXPieV276Uihcq6lrMF2IewQV+zZVolqhQqOk6/gnb0ZSY92lI/uJlp8PWx8RHi9rnIE1hxLgr0h/YpUxrW87hFEjb5rghVMW3QlxjFVKdEoMFA/9++g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613031d6-5155-40b5-77eb-08df29c7cb32
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 07:50:19.3956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rihlQdWP0AHndLs6sQheM3wRIvna2jkySZYrNQiMRAVp9w3UyCY7kwoAeps+9e0YE0Y66oXDvl5fEdn578YMx0t3jznbk84zmJT2f2X3R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6864
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
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 203 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   5 +=0A=
 2 files changed, 208 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index a8647b5efc..bf5286b649 100644=0A=
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
@@ -524,6 +534,52 @@ static void usbredir_server_ctrl_status_complete(USBRe=
dirServer *s,=0A=
     usbredir_server_send_ep_info(s);=0A=
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
@@ -596,6 +652,12 @@ static void usbredir_server_packet_complete(USBPort *p=
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
@@ -972,6 +1034,105 @@ static void usbredir_server_get_alt_setting(void *pr=
iv, uint64_t id,=0A=
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
@@ -995,6 +1156,24 @@ static void usbredir_server_interface_info(void *priv=
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
@@ -1043,7 +1222,9 @@ static void usbredir_server_cancel_data_packet(void *=
priv, uint64_t id)=0A=
 static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
                                            USBRedirServerPkt *rp)=0A=
 {=0A=
+    struct usb_redir_interrupt_packet_header intr;=0A=
     struct usb_redir_control_packet_header ctrl;=0A=
+    struct usb_redir_bulk_packet_header bulk;=0A=
 =0A=
     switch (rp->type) {=0A=
     case USBREDIR_SERVER_CTRL_SETUP:=0A=
@@ -1054,6 +1235,21 @@ static void usbredir_server_send_cancelled(USBRedirS=
erver *s,=0A=
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
@@ -1096,6 +1292,8 @@ static void usbredir_server_create_parser(USBRedirSer=
ver *s)=0A=
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
@@ -1107,7 +1305,12 @@ static void usbredir_server_create_parser(USBRedirSe=
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
index 0ed20838b2..d74860ad4b 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -415,3 +415,8 @@ usbredir_server_endpoint_dropped(uint8_t address) "endp=
oint 0x%02x does not fit=0A=
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
2.43.0=0A=


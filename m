Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E46CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjco-0001b5-LA; Mon, 19 Oct 2026 05:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjcG-00011s-9h; Mon, 19 Oct 2026 05:25:13 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xIjcD-0002px-BN; Mon, 19 Oct 2026 05:25:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rejfMJ9aIgqPTJ/M2VgAE2bcVUvZFwtstEBkcZ3tlHxpMSBViq/H32yC7PZ411REelWdSWZSv8Uvst5yUrPCHIbKQtQnqC/+5L9AoqML3nBYAUY2lAGzdlDtYPApYs+KllBEXeaKz1JImmeMqjC8L1bxfKd5vj3QMUpocmqTevdBiKzYhtb62MH0MaK72xczf3K2W2oJQFwgzMeq9UXANPannknw+LK3zuEaYYWgcSXnAFluuFQX1G4bvJ3p6PSdlEjgpuEVeJtzRU1ZlVRjcxS0wpK0cvC/VfwzIhxzhnlIAkbpnebWV3mHSQuTba1AfS9GuABJE7SF1XPVlPklFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5mlAMH+pPRINn/ddeQLCsB50n8L+xBdvqcVEmcFTQo=;
 b=LL8wIpSR7a/sBuoxf6hepW+BfbYtYtUhxDqB4ASTFpUIfXTJH9BHb7EkUnCRGmQOKRxDB3BrJAJ04PVylXX8feevAd/XiBt3u7azK463I7JoKhNM0192jzSZpiXJmUyHY0ejLynEGBC1ZsFa2KANhNAV7cdExK1F5kGH0K5K4p66AiqpjPEU/dQiEtJ6QDcMBzhIwumjKPQkryiuOallLFwDA6gMEZRQwQSOKDqeWdQzI1O9bgj7XOeli51ceKKfJB2frGFi2b96Omz5pumY0Mfhgx7DNPlw3c4gzgMduMG5SgK1yWuz+/aRDIJLoVulDVq9r+ZX/9N8ACdBb2U3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5mlAMH+pPRINn/ddeQLCsB50n8L+xBdvqcVEmcFTQo=;
 b=itdUfO2AfPlXuE+tnYEama7KmMcGePt295lYxJL3cejn5ETnE1exw1DSk4qaGdvVtNxhqaQQxhudDVCtd5b37en6dYwtCsEk36jMJEgBv3lsRLXjUlYGgZ6am44tXXHJXbxkBtSbiqCvhvLvcly5EVdCHVH7bzWGiyTQImqV3xwwsF0VytxwZdxT0iZim9IRlA/2oGdn/77yhnklSbxUG5iA7GHVJL+5T+pg46AbwF3Ix6zT1TaAsR0AS9bDS5a98o3x21PzkCz7CGQwMry0/L+8vycseVSe9JHfYWdBxGXhzAWMjYSBjOJOYTzo4MKuULkSwkKwWPbqSMD+aG97yA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8674.apcprd06.prod.outlook.com (2603:1096:d10:8c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 09:24:56 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 09:24:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v6 6/8] hw/usb/redirect-server: Implement bulk and interrupt
 transfers
Thread-Topic: [PATCH v6 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Index: AQHdX6u0MAm0Gm9/sESzGu9qAc9rKA==
Date: Mon, 19 Oct 2026 09:24:56 +0000
Message-ID: <20261019092448.278079-7-jamin_lin@aspeedtech.com>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8674:EE_
x-ms-office365-filtering-correlation-id: c5d0696b-87e1-45f7-8586-08df2dc2d711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|22082099003|18002099003|38070700021|5023799004|10067099003|261009221227099003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: NQ6IjuLN5mGPKdRJXTo8luCkhNPyUokskRP21oE7qlVC2P5Bl3u4Rtk79XtwSZlxR96ZS5dJQXcF9H3uO1LJixtnIl34gpeBLGg9BALLjEBQV7ur7zu40jGDYSzSbqJqEIsVcB6ZPNmfynYoZxEcj/VoWbdokrbVjpL6gxytC6Fk8P/Jp4o9zM/eXlLpCxHMnJxz3IXd5MI65t7S5Gr8D6hpGu8RLva3cnulpwHE3xo02bH2aASQSuv6lDkMuP+gji+iyNm8GSUZZGrR2scZECXJyYMZ+Fi4YZ6aCvVliIAR1ZMDnFvCen1nkcm03ELoB7NZvO0ze/U9uqyX1IYv2E5nNZrA6rdWde4fy8ur2Gy4pJPTneFcGU0aVPsL0s992xk8VnCQ8qD0vWqcfHMLckrhFaZE1fnAgQfF5vvEyFGkM1wBPSeWpmon5RMl465rjuDzguveYT9joDxHoo29xEb2y57VwPfk3yAe6l7MM/+xYgvr1nGpnM/nvfJZdukpn/x3pLEYljtWKQNeQBlm83eiCAGayztAzlOfI0H3Fcdv3n2o4YZ3ZWR4Z7eRP2xDRXGl73S+okMs55HgwfFM5XIO08fdedDZW20WIbQHhcStflMJlTWC56MfQRhvJyF63mcI7hJAFSW54MCIlyQLgpIxZYLYmt8E98DUclRQmPsPOmGnZ8Ae0hIbihafVRRPvwNkmYqkUHQCJBtwWgtrqrLruV9puiXp6xZR2UZuOAw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(38070700021)(5023799004)(10067099003)(261009221227099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WITz7zE36zOtP0j5KhvFIahE+ZZIw8yopbsslfpPiq70RySNCMd8G31SeF?=
 =?iso-8859-1?Q?/Attrk6oVUbtAFlEgsDyPcJ8XOf5XZzO7+v/GiHpsIAJMaM4sLS03Flqpb?=
 =?iso-8859-1?Q?KiwAVDxLvylh3uaqxdUn63vKXOQP3fRTgFIHx/HMe/7VAWjZPLphjHdm4j?=
 =?iso-8859-1?Q?x9gWfb3Snw9nBruyUfpnNKXkFwRLzvqe0jB+oGqTdrGcJ4LJBF4EZBR2xo?=
 =?iso-8859-1?Q?z5Uek8SXpFFBhK+qLQHUOq6mM97NSfiuLQDTUhO8d3R7aFQ7sB+p3GPgz+?=
 =?iso-8859-1?Q?2NqIsIoZTEimCh7BLk9GxEQ1LeATyg25z3T+X1MJUGVKhxnyGZeURiQMlf?=
 =?iso-8859-1?Q?rIKQ63f/jAVPhVs+pzSU/k1k42cX2N9nRdrelqoFZrXRObiMqNd4EgFUKv?=
 =?iso-8859-1?Q?j/33VKvFcqEfWMj3QIeZ1/JHYN6X0U/naNEWpARRvz/hZW/pXrEtiN64zz?=
 =?iso-8859-1?Q?mpTSwzgpukgsYMaFuKOfghbCw/Ts6QUC8qihZWnp7EPE7Pkqs1tKu8N428?=
 =?iso-8859-1?Q?OFDV2liC1vSmH4wnh7Tib81li89YgUn007D3X1PBbxt6LFqIN7ikNVOFT3?=
 =?iso-8859-1?Q?oeaTA5aM1WOW5ptv+IKpnwGvcSvx5rRZ8xzRlcOvCJa0NXhj7pB5VCGlIy?=
 =?iso-8859-1?Q?aecRCteTEh5tINozvlrKmVhLbaEjHjYKq3f6R+reZSS36t95Yt5yMdOQuq?=
 =?iso-8859-1?Q?rph5sgZcpQf19q9sOk1fmJAY2ZtA4GOqDtk1Rr1P5SVnkNrpfJR6FRHlJQ?=
 =?iso-8859-1?Q?4O4N3ywiPRnJcfal5Rl1LYyTnyUITY+zRne5FwdaxvP5F1IpZNes3cc8zD?=
 =?iso-8859-1?Q?YzCQmsoRg4eM9QDeLhFogfm355FkQnvIA2684PmC/+d/ztzcn5W2dCI9mO?=
 =?iso-8859-1?Q?MKrXPBlCWp4Zzr3T/1RTztrIgu0PK4gtXVg3I0CL0YwlWHlZPtlGNQRW73?=
 =?iso-8859-1?Q?8Q+42WMFYBQVp5qL9MY/X1Ul4rRDWxpUTLuKWZ0YYaZwe9SJzdl0P2LDJ4?=
 =?iso-8859-1?Q?hhO/+5TaV5HOYNffkbQ5lCMDfXobmvGQe34AgtuZUy2qz/U0/XxNUF3AJs?=
 =?iso-8859-1?Q?IYL/xUE5iTJVTEjmDXll1kv1QxvVVQzt2TGbtOA3D4FstRslngoV4BcXPY?=
 =?iso-8859-1?Q?QFyptAnRT2W6zkcz5M5NPdFy/oatgkGuzqF+9aQ0SwKchZYMGPmkhJKpJi?=
 =?iso-8859-1?Q?HX1HgxbAuFRYGnIRu1ulcTCCR4G0EiO1L29R+deYaQxOGJ1dwiT5BfcvHw?=
 =?iso-8859-1?Q?dSXMFe14GzkEcU6oGz/rSZA5EaYMQpjntcKQoKcoitW1iio8KlE0ubX3G1?=
 =?iso-8859-1?Q?KIhnnJ3MT7d72v8mvBi+b4pl/Tmw4VCyrR2sdn7CRb8lJV7uPqYaXgf+Hq?=
 =?iso-8859-1?Q?LCBzOCfYm8WMDCsHYinFP8XVb+T83n7YOTtcMKDTc03fhv+91qZe1I9EKQ?=
 =?iso-8859-1?Q?D38x5IplDM1by51DdiQewbAZy/hPcmRUXqooG46OFz+OU1pupLEV5zEuad?=
 =?iso-8859-1?Q?fVPU3UuRxDR0u/6v4lCUp2uQ4rd8EiRDtzcyfjukD/fRS/RjFgTDYUzBU6?=
 =?iso-8859-1?Q?soefxDIGAB3O0DWc4Hj25X9ZleV4BPBlUjGFrAxaf5TRlYfwM1xx8TMl5r?=
 =?iso-8859-1?Q?EmjaMjQF98GLtTNt3FOSMD7slP3zwlIqQBWWO3+OGSoB9NQlNzEqJzclf4?=
 =?iso-8859-1?Q?M4fySsWxuWJKRW5oMgAAlvqtItYp9jzR8Ps3PgHYWAHry1vkuMB46wEZTC?=
 =?iso-8859-1?Q?sTiy8l2SXYxA1Lp7shJd555oYLfw45v98SZljjUxOLcvmjWnwVzL+FoBm9?=
 =?iso-8859-1?Q?add+bwAF1A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d0696b-87e1-45f7-8586-08df2dc2d711
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 09:24:56.5014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RqN9ws8r3aRt002jMehzznQVHthvdvxuqlpo6rWeQL/2S1uk+5JEveg2l5SkJA0piMCzkSW2MZQ/jNW9EF3Qf659+B2jHZFzE5yE0yE2Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8674
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
 hw/usb/redirect-server.c | 208 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   5 +=0A=
 2 files changed, 213 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 29a9fbc941..f81dbae2d0 100644=0A=
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
@@ -600,6 +656,12 @@ static void usbredir_server_packet_complete(USBPort *p=
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
@@ -979,6 +1041,110 @@ static void usbredir_server_get_alt_setting(void *pr=
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
+        usbredirparser_free_packet_data(s->parser, data);=0A=
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
+        usbredirparser_free_packet_data(s->parser, data);=0A=
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
+    usbredirparser_free_packet_data(s->parser, data);=0A=
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
+        usbredirparser_free_packet_data(s->parser, data);=0A=
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
+    usbredirparser_free_packet_data(s->parser, data);=0A=
+    usbredir_server_submit_to_device(s, rp);=0A=
+}=0A=
+=0A=
 static void usbredir_server_filter_reject(void *priv)=0A=
 {=0A=
     trace_usbredir_server_filter_reject();=0A=
@@ -1002,6 +1168,24 @@ static void usbredir_server_interface_info(void *pri=
v,=0A=
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
     USBRedirServer *s =3D priv;=0A=
@@ -1036,7 +1220,9 @@ static void usbredir_server_cancel_data_packet(void *=
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
@@ -1047,6 +1233,21 @@ static void usbredir_server_send_cancelled(USBRedirS=
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
@@ -1089,6 +1290,8 @@ static void usbredir_server_create_parser(USBRedirSer=
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
@@ -1100,7 +1303,12 @@ static void usbredir_server_create_parser(USBRedirSe=
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


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30DACC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHrE-0000KJ-1H; Thu, 15 Oct 2026 05:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHrA-0000Im-Gm; Thu, 15 Oct 2026 05:34:37 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHr7-0006Dz-4x; Thu, 15 Oct 2026 05:34:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1/fSO2dNY37agGu65RDW37BMx7z0y+0Pm2jYVYBAEtwbhAYO8hkdtdPnqFdfHAPoGkxQyw1nt9jaQ26MNeSeqYE5Gk2AccgEXJkfBBxmy27K2XPjMj/tSfGY8Xc93suyybathnn+fB7vCz4ZznKb7uuRRB3v+80XsVg+PssLzVO6U9/SCS7RGU17VukTasPZtvJq9Sit4t1fej5xl7eUwVpKJxFPq1nNHP1sWTfkv3Bqi7zHY2fQr7xy49YkVaa/xC5YiBJ63bIP6Uf8naOJu+qKsE8W0Ot8NLXKQ6etn5R3Fg7f/xVbsUAYzeGr9tXA4+BgLj0gw7OMMm1bZyWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIz5efoeMHnDBvmoi78vuPOmGgx5R26mRWm1J0DY40k=;
 b=Ti6xyq7Xin+12aedNIxF3Xj9i6mgjsjxSY5X7tsQd1IEOGe43nkETvaqMg7/x+I/mxjb5bDoIlr0nfOp77I8dJQykFQ0o4DpC6FSm4Pv70udF/Yo73eMQYuI6XjtUoNFJf6uZ1ktRtx71ghE94v2UDipTUd6rlv1C/hQOpG9uY1YUjFqmXuUPMzzE+FXjSsQWiFJOHU7+EFUjAoMCIJUIRUKImzGUBkVHMVVg26tJUvbS85lTEdQC7VM1GFx3Wll7pw82hBBRvcRwe0d1hd+VECq0g8B41wkARR+LmQhpYdDT6WYFviIxVq6uTQ01fgWCFJqnQAmxICKukXB/QWhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIz5efoeMHnDBvmoi78vuPOmGgx5R26mRWm1J0DY40k=;
 b=ext2WpP0EIH8XwLlu/uyl2KUYXWmVw92V75Wv5k4lJD9uZmNd3ZZ/NnNrZ+3oVFFN4zoCefYTI6DPPGDy7qaKGxqVlGIsC3VAyPuDF9Penk6BViEmGolloN9Q4WDNCfrKxShk02KKNDG7rk+JR0Ur/L5Ht1rZ/RC9nuRpzuRPhW0YrmLYFhXamOZsoRZPU/8cAXuY2AYV8GSaC+WUJBQXvMgKMcn7qzMR5eL7IfhjRbUtKrFteV58jy9K7/F9moNHJjHmWTTHk6WEY8U90+gWqcJ13sBHx+SIMw3rjneZMK6RAhqVVwvUQwS5K6FdHBBWMuuPUoBh1Gel5j765caUQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB7199.apcprd06.prod.outlook.com (2603:1096:990:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:34:25 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:34:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 6/8] hw/usb/redirect-server: Implement bulk and interrupt
 transfers
Thread-Topic: [PATCH v5 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Index: AQHdXIhdIifKtb7QpUSTZyTl8e2dEA==
Date: Thu, 15 Oct 2026 09:34:24 +0000
Message-ID: <20261015093417.573063-7-jamin_lin@aspeedtech.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|JH0PR06MB7199:EE_
x-ms-office365-filtering-correlation-id: bd8814db-0c5d-42df-3cc3-08df2a9f8037
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|921020|56012099006|5023799004|261009223027099003|18002099003|10067099003|22082099003|6133799003;
x-microsoft-antispam-message-info: tPnGGIiV1yoNDOyB3VmV6EsDuRdp8k8AwKGzKIpHsjH+zut7Hkw9D7AkeIZLxsWEvkeyMWNn0kyKOZ2AYpDOwgBYuOuYyu1aZjCZo1cOjNuLyCPXTWM4gyfDMCymSjSRzNwimyKkkTFh6zhkc9dZpKd57GzxMHbZY+8D7MF2iYWIWvt/B6sgXqHyPAbiQG7X5QLU1YgUxTtiwfJdoro5ktoGVHjSfmw/WfbS4kFdI4OLIrFfRq3ZYJ5gEHv3Qwc2hJ9ajjD2rmx50ARXnqzqmIxKcnBEce+F31PI/WePHWlGrf16xtLUq5vvkD9Iy5yeE6QjPJHyTPF0A/MIuHco4YYDckodqSC7BouU4s6Ct1cgT4lUPklobVrSNuNBNoFKZX3cwdiRr4vwDPewm8KxqdwZL8LfNanbcd9azczfX/sAMX8/yFSwOfCp+l8g5xExa1JT+TSnWvxKjLpSLefwKH5AmOqgiuDnDSySJ9wS9rRCnqDoC0yRVDwv8XtxKsaeM1tuRnx1RHHKEzo8r/9MYC7utMIS2fhr2TGh5SkxNfFU2/yyXRN7J7d4+8+ZxlLKgH8uia+9Xn6Jp43wgkgHOTWPSrcO6ajmYTMDwijoira5ewdkKw/qVSQ97GQjII2Xo6419HyJNC9Xgm4UAPDIQ1ZHx4URG35bDscThS7qJzbEwMuk47U2OyrWfwzxrprZ1Zx9JNNsFgEi+A0qFJTpl9WP3bbGEONlbi1wYvfd8hnkD9FQQ5bfRB+TtjJ0otHE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(921020)(56012099006)(5023799004)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?a8JB0RvElABJy8CLoSO4Z/OUFuo5cjV1PLLVJ+uLlsD0dUMIR8LgMs6IgQ?=
 =?iso-8859-1?Q?taN/i9xoCl9MeIQkbwDVQEIhi2sJd7Z6I5gstQuraQwOK14sXR3RylySv9?=
 =?iso-8859-1?Q?rm00TjZ2/hR2jmWCcsPsG/cGkMR4F9HDqe2lRcwxN8Zi7jsXu3e73B4GbR?=
 =?iso-8859-1?Q?ZBV3T6G/J10RGNlmYXbg/RAQ3TgJI54g0pAr19ofZBPP0flZ/+nYjY5oLc?=
 =?iso-8859-1?Q?RkT/D7Fb1gQb2vXbpHoPVKukhoe7K3fqucGURo2IFXn4KMYBqNAU+qWsgS?=
 =?iso-8859-1?Q?IFm7hC+++3GE/XVj6v3pfQzyz4nwjVIyXotvD2QwTKUiceerZ6gxtP78Q+?=
 =?iso-8859-1?Q?NCzbtAKQuQEStGpDj1BKr4DJzpoTDMBlqUZBOi1/iPfmJpOA+bucabcc2c?=
 =?iso-8859-1?Q?L/klz1xDqtkQh8QLmFDNRbPvDj7OQxBhHAx1/lnvJT1Xcw/86wz2mZOdSl?=
 =?iso-8859-1?Q?KBP7QPYvz14p4TRJuxyzY0D1j6bh8PlLmLdT/jkH3EIcnM7Dkeir/yX4aO?=
 =?iso-8859-1?Q?1r8nbQMntHDclaa1T6CtM9ydzJhJ6KKFuRrOzJQMBTZML7QC3aUC94Bp3+?=
 =?iso-8859-1?Q?2hYy+nwXWCdz9uVrqk3NC5KpFja2G2QzzA0LUAmAqrF8EiFketFqdMoIlA?=
 =?iso-8859-1?Q?IATvniq6SI1ZVUhyGSPqXN5opIdqo/u962zBG3q9DywXJROjJT+7/zcH3E?=
 =?iso-8859-1?Q?Yb2EJ9XBu7yhF0tiYpA57l25tHU6sBJtWbbu3X2c9X//ClbXPugW6tX7Rl?=
 =?iso-8859-1?Q?fe1omvwXxQs3vRt14T4WrQa3AVvkuhr/K0Nf60BsXTgkSX54Ap8TRH0gvc?=
 =?iso-8859-1?Q?hjzmUYiebPXMUM7K+V+fsZkAVIZNeXBkNl4//qQxT01suHOXWXuYRCN0DG?=
 =?iso-8859-1?Q?zvGj/6k13TpuNEB6wcxY/uRBoYUlQ9C8aM1AFfqlmfWlRHLXde2wqjJtGZ?=
 =?iso-8859-1?Q?vzV6ManO1S+UKW3f8SFMBT52hStF7hbTRKS2tKHQTZDeP6GOaiFFBo2aUs?=
 =?iso-8859-1?Q?mOQgc/OYrS5rbM4Dn7WG4/Ud08xcmCBYxvoisdZxyNsjuzkKD8PAnwt14E?=
 =?iso-8859-1?Q?FTHVhbXMHikFVYoUy2W6bbrWLVrxza+O7k25zvMtd915vYD11EsO+EKKb1?=
 =?iso-8859-1?Q?s3inH1CnKgfJ+HASK4xdcwKTnmeLwUj1hCxqCJoHJTBhf8X9kcbJJD9djr?=
 =?iso-8859-1?Q?3NY+2kO4GX8Fo7+1A3UuU/2c7crxdHTTyfKuXPSZdVUQzejXmzdFQbSREi?=
 =?iso-8859-1?Q?oowWgVi0l1f7ixT1Qoill8BJHUipZIg2CmHDPRZUyK+m3fe4aIHesDtbkh?=
 =?iso-8859-1?Q?/NPjN4YaRJ+b+iF/21YBSZ3azDgh+3/IYxg8ByPJxPOY4az43DsORN2m4N?=
 =?iso-8859-1?Q?nw6CEfrIPxsETnuvaiZ5Xf96BFLkK+W10xyIu/g8AE+Sp25HLBqVrYiqOH?=
 =?iso-8859-1?Q?BvLODRohZfnLSgpkce6lLtMv7VuMlcJ95s5yCVwDMwI0/uk2Xw9pFDaO/x?=
 =?iso-8859-1?Q?2qShatiJaxE5IVAPuSC9US+c2Iq5ai3huXBgZ5XLceJt9y59VWtMbCPnz/?=
 =?iso-8859-1?Q?15ZysgRxUk9JzSQNBQED7tkZElm2XFqakfkjol6xE3KfhroXlrnzIUG3yV?=
 =?iso-8859-1?Q?ukNYItAorfJ8oayrICgrSv0zGPm4kd90zeY1hDXWFeH+5v+AFLawUvxJNx?=
 =?iso-8859-1?Q?whSMUCKf8Fljaxcg2jOaTPKqDUz8lHGqSXHYiUIP0pnyRdeW4YDL410Cuc?=
 =?iso-8859-1?Q?SiBvbyfYzHJmdwqW4RuYt3tXxkrUesxfS4aVL/eq+G5H5Ns1rK4qyfS+/K?=
 =?iso-8859-1?Q?KdGKp17brA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: smrgLk2IkgpgPsOydTPklCLnItI7cjbd9tUUuGtAGhrW22Y0eduKWx88eUeVtePqEALeG4dqTroUtN4shlXyqeRX81/YtB0e7bclAPS9wq3QbYS30h+Yh1BpRrlRxyQ0xfWEzafR1JWNUUSEEfSZu9rxj71XfT/f89h0yJJh835l+GA5BQbNxFED/bn9t8T9VzC8HB5aDAoH22rptLsH4UkjDUERjwCa6nsuM7pzTYzP39mxOAa7YGntUE/u8JO3SNCBP3nlAb+KX7Y0Mp61oMW/zGAdI8TxDv6U8+xXZ6i2PMmV8Y6bckEE1dFbafmGBdhjfXU02KB+kpvMIuk3jQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8814db-0c5d-42df-3cc3-08df2a9f8037
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:34:24.8642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLXXhIqhePPpU6wdAUhM8DDgUy2ir+CNHRHgs39rDWW4wd862dduJlTg5c3hPk83k6E8ykesCieBOoFbUU1oDTv6b0j7ruWKnn20/t9mcY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7199
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


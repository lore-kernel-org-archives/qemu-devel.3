Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E6DCC6B3B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHrC-0000JG-FI; Thu, 15 Oct 2026 05:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHr6-0000IG-Ra; Thu, 15 Oct 2026 05:34:33 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHr4-0006Dg-3u; Thu, 15 Oct 2026 05:34:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNs0mV0seGgR0/qmEPnBQFtqKokvjS81w6tgi+VShgij+C96GWIbMQCVFmB7WbDK93g2Q1H/QYiIIaG3y5FjL40Z0yp2fagje5DOl8ZxxM5HFYPwtvNlV+G6iW9eszoxzOFQCXaNfom3R+LX2wxgkuzqYCKVtYsbdTSjPcJ1UfZ6nCTGebT6V6WDvZ+wb8EQd4k4W0LaYcDyspcbAaB7ToDNovR8syWjP52sUrQL7/MDY+yar8Vxmdx41Gsy0GlYcaOAGSNhKvXN6Xue9ycMYGK4YzmmMp2meCvSIOXB5lAc/HJ5J91ur/KtJn0cmwwNQAzF3jZdRj583kUyFluipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U23PJIr2zCrBIIO4P8/Pf2Wi0Fn8XpWOLAS+gb5zWYI=;
 b=EFjyOzxGc2555D/Ec96x9G5iFkoMdP/In/IMjWx65GztR5xZz8ciHmE8AvKy5F4aDEHDQYrAkHd2UhdET32sR/zWqGis9NF5TCvVgFX/UQEXHLvrdqtV912ilopTVbqHAyIabh/vIuo3f0afhONeruayCQfo8ditMFr8F9Xekh2nvKuGm/Y+BAzH+uyI3kV+7RThH9pcCzZSIAPgKF297gSy71ajD1eVPr8+L2ZUuRFX+dy4FYb0v4KBBUURjWig2HcytG2IZQJxcWokuQCuMNIAki3y2PP1K14oNYX7QFHZYEUaS/3WcgsjKFbeSMjkjtzExICZm1PK9bMBfCclfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U23PJIr2zCrBIIO4P8/Pf2Wi0Fn8XpWOLAS+gb5zWYI=;
 b=WIPRrJBC3bftheCA+nrVvTBHDmZwbHFMxOh3wn97FT9paoLZA/noLh8MyZ9ZEljUWYM1lGhcKvn8ZQSJp+VwDcqjqbbI4B4pG/50tyULE/Nv1DMSHLlfHWgYMfRK6z1/QXefgWmqI4pBzcEfyDv2XgDveAHS0JlBVDG0butwYOIqRKvIdz3d2PV1Lm301WWJyHnswz7Y0/uGJGAybCoXBU+JQclm0mRDs/E4/nr16cB/YvV4rli+TbS5K10DZpy/hxgnL1h97esol2R/3L582Y86fkh2op/+0ENy7mdKK2vXd7wesd9bsm84X9vvaYEhahdAJeQPTR4Czt37qitZGA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYZPR06MB5527.apcprd06.prod.outlook.com (2603:1096:400:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:34:19 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:34:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Topic: [PATCH v5 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Index: AQHdXIha49Zdbi3VXUq1mz9fB1z7xw==
Date: Thu, 15 Oct 2026 09:34:19 +0000
Message-ID: <20261015093417.573063-2-jamin_lin@aspeedtech.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYZPR06MB5527:EE_
x-ms-office365-filtering-correlation-id: 756b9227-d947-48d9-4f8e-08df2a9f7cbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|921020|22082099003|10067099003|18002099003;
x-microsoft-antispam-message-info: jXsyCNJNvXB8QRS3kFMrgUeu9jEnVnSCjoBPyOR5wSW2ktudbDhyG/9Dy9Q0lLVjikYZxW6G1YCUXV79zjlz9jPk5C/uF/ZCSvKEkcfzbhTA/4YcdxwhGzB/K7nM9+Ny5+yy2KX0HQ+33Zw9aAc9sxRc5ZeCAPbAphfGRA9i5tSJyjEtUiOuu7qI4kWiDSoPE/W/MND/lY2QrNpaQrRLvZ4tZeGxGE58vYibZFjqLITPizzBA4pc0BRlyJOSLgFGBQOSeb950nG0JtzO5t2x4Zsw4k/qy2PMPqjrVc079kyW16RLwzooxqb1G6d9lJEuQJS3sN3IYz9rh6svHDeFwB1icR/tT8ZDgKX24yFvF84QZFKd5+dEK31abaAwYnwyhx/jE2N7fb6JlZ5zoM5LsDxRcwKFjqA5xRbwBss5lOHvXwch/cqOU3IF4y9nn8DLzu0oCQDclibObR5GmFAweOMUmnxPmG7O2vks/GjPwhZq7ZxBax8r4W1IpPVlej3qMnhnE5ljIyXXgMg/j4ZE45Mo10v6G2BFcnZp4G39IN2puGFUYYNcyYeyfcapj1otUFSia2zNHRyW/7zRl3zMfkefCfeIksE/dnsGrPb9R34IyMdjJdu0BBJd8vxWUpA3g9rjHerChN0Wsam9zlILbCBiw2AhR/x9IVcPEaMRvBbvZd9n9vShbYAmWvI5Ep7uD40IfwJsJWwsC/j+ei0GtQ/K+cJi+1BhXIvl1yWIAl0d/+TnV7Y27c5ZaAXA3w7m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(921020)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kq3swfZgc4UqzxORMAhrRLjJDtsu3gTlIwDfqeKFDVw9bV8LsXmt4uZnWX?=
 =?iso-8859-1?Q?l9KtJqRXmBXszuNZzlzftQS8IvMnl3xs8102ghtdfSHv4kfqMiYUl3cqTC?=
 =?iso-8859-1?Q?qd98US+udJ+OsTPhJ2duBvCzUwCiPBRJoOIPFAurFdeMwJ8Y0COGaMuVUc?=
 =?iso-8859-1?Q?dAQRF5TerszNPVX5VFX6Dn3Bk2bU9K2KzywWv03toLZwKp7WzvgZRcLvoB?=
 =?iso-8859-1?Q?owut9+8CgNR5VNlS6XQ+ue1SB3mNsEuAc5L32ZTaBz1FSL9nQHRIedl0l7?=
 =?iso-8859-1?Q?Y9TMSsHdaliQlmqhu63WbMFIOmcNT3X4EklJVbyqwQjZNcqlK6ckS0jzD3?=
 =?iso-8859-1?Q?rWJj2lH9/C13WbV0lfYkcK1oKUUjJqiK2vBt7L24Jf32bIx2aFpia0wHOE?=
 =?iso-8859-1?Q?zVt3Jb2hgjqbWZLgelHq51jM6C1TAoypdxJDBJW1mci58MWbcZWzkkasfw?=
 =?iso-8859-1?Q?tCPaAx7KxwEiRlKZWVHkeVIeSNWel44oh548a9TlUeXSOlqu12smG4MftL?=
 =?iso-8859-1?Q?85buuUl4zTUMNqDwJBmCjUNoTu+4O+1btGUigbhXOvNxWDPB4VavyntLob?=
 =?iso-8859-1?Q?cDAYX12ZnCDKbE7JNaj8H7dDDPQa1JukmmVbJgXObTrZBxrxRvhWKF86rX?=
 =?iso-8859-1?Q?RpIsuBifZlFmenr436hTxUlyaCcE5D4Db9ehs9Sb3++ZbTUNHPgQbipGrS?=
 =?iso-8859-1?Q?lGAWURoRzHzPAR7PhInwGdkas+XHPNzG3o1Q/ZgroMgSkEMJZL1RnhrrXW?=
 =?iso-8859-1?Q?ciFlFwQwQXNZpjpkP6fXgerkRu8SquNmNiT2qaTEnVJB27Dl0ymSKxR2Hd?=
 =?iso-8859-1?Q?D359h6gRuiiomFeVqAwpFPEI+xW6aZrqZUXIFVtYPN3weO8+FlRywSgQUH?=
 =?iso-8859-1?Q?pfkRy4NIWUT/YYVFDXwT9wPAdj+FbWuoH/z+LRWRU5hAPBqQS9stjOI86m?=
 =?iso-8859-1?Q?usQbAepOabYEaeAoEJ0mvcq0j0u/y5igV9ZrWG0UnQ5ZeEfNdOpfGNuPkq?=
 =?iso-8859-1?Q?B6Tp6upDL03h1dYb4LzjAkhi77AldGYQnOXpAd9xOSoBQZQMaSly3yiT2v?=
 =?iso-8859-1?Q?2LrlaK+PxTOKSpElA4JWGhsI8fvc1Lae6CCqfNfZHoMY9ge4OLw5ZZm741?=
 =?iso-8859-1?Q?fxpguDr2GTF8dudCARiMnj2wYd4qyxZezl/MT4Y56ke7jCjKVGFYIMqpf/?=
 =?iso-8859-1?Q?R1BMaRzQ7I+8kL0mVd+mPnVHHjHRrN4JPIkGWPdylsxI4HzWhIRZVk529n?=
 =?iso-8859-1?Q?m9yEfoVf/pc06ITbJcHntvsiXlIuAgasma54Vd7i8Z5PwMLklNOgOsb1Jp?=
 =?iso-8859-1?Q?IPszzLso1tS/spIy8SANGcmiiW/rosnQH/IeRjePOM+okGFCG9llgZ/v/r?=
 =?iso-8859-1?Q?Js6MKIfbV8s5xnWnSzR/TYfOqoABxWsvbhR1s+XFSBgVdG2MzvYOtTtd0y?=
 =?iso-8859-1?Q?xW3CSMiNxFWsuYT7dX802YLLEf4lfkpR0+ye09GmdXY7SoL2TnEK7GCHYE?=
 =?iso-8859-1?Q?xWpzLG7VwLK1xpUrewaACxwnXso6hcv7cjzCuvKkPSGbotNOPPDgAfLDzI?=
 =?iso-8859-1?Q?SfyLKEQGBuIkwgB7HcC/1VutlM6S0CP1PNu8pyLS9HUWFWx0BO3BuYl6D+?=
 =?iso-8859-1?Q?QmkgvOLAlt3bxT4aqGsGfVa5GMXllajrx5FNl1NAEvHtK9G6g0QMpBwHq+?=
 =?iso-8859-1?Q?XWm+xxXMpjuB8edS26krp7htTQWOufV/AspSW1roD80Q4PEiXoJ+GG2FJr?=
 =?iso-8859-1?Q?igAxKj5Dmtz2HmeSqOwXjwtmMslkn6C4L5C3JYPyMFF1Xs85CRyGY72QTa?=
 =?iso-8859-1?Q?oBGQCA5fOg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rr3STks5PvC78/5kBaY6kMj8m5aa38UpHRb1dN9F903EJuOOF51O7qyY6zQhAO2elZ4eonPJETWyx7ubgpAKnr9xQrvJkludImLGlQVKtUIM+cAdqyzKqk9swaT4huefQx1cT8i9b8Se/MuKGTTLkUy+6svHEuaradAdHkugwrSQdk+PE5WlXYkrVNMpnhBgJeRVA3V+K/dEmL6RmJS5WLUcNsqY/byeItimmIZoNm0oclS4cBLAODfThSX/S36zmB8EqFBk69Q9G17qlqYt/rFiFMlAf3Ml7UhxUyosKubt5l3yoQ6ai+hV0nbfOXwJqtxq3+W1iYVyWKZmNWHoyQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756b9227-d947-48d9-4f8e-08df2a9f7cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:34:19.0691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Db24XSkuuwXkUKJBBOtWl7GOnUf7fPkP853UKkM+iXKEKweiJm1TYyBIdL8nJFrj6OWTjbRXtqO5ItqRBs2iw9y5tUXeey8Xvm8ANVaND8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5527
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

usb_claim_port() inserts a usb-hub when a device is plugged in and only=0A=
one port is still free, so that more devices can follow. That is what a=0A=
host controller with root ports wants.=0A=
=0A=
It is wrong for a transport that carries exactly one device. The hub=0A=
takes the last port, and the device that was being plugged in ends up=0A=
behind the hub instead of on the port the controller watches.=0A=
=0A=
Add no_auto_hub for such a bus. It keeps the ports it registered, and=0A=
-device fails with "no free ports" once they are used up.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 include/hw/usb/usb.h | 1 +=0A=
 hw/usb/bus.c         | 3 ++-=0A=
 2 files changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h=0A=
index cbd4711933..ab96812adb 100644=0A=
--- a/include/hw/usb/usb.h=0A=
+++ b/include/hw/usb/usb.h=0A=
@@ -484,6 +484,7 @@ struct USBBus {=0A=
     int busnr;=0A=
     int nfree;=0A=
     int nused;=0A=
+    bool no_auto_hub;=0A=
     QTAILQ_HEAD(, USBPort) free;=0A=
     QTAILQ_HEAD(, USBPort) used;=0A=
     QTAILQ_ENTRY(USBBus) next;=0A=
diff --git a/hw/usb/bus.c b/hw/usb/bus.c=0A=
index 5cc5ffec33..8a24b1837a 100644=0A=
--- a/hw/usb/bus.c=0A=
+++ b/hw/usb/bus.c=0A=
@@ -413,7 +413,8 @@ void usb_claim_port(USBDevice *dev, Error **errp)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (bus->nfree =3D=3D 1 && strcmp(object_get_typename(OBJECT(dev))=
, "usb-hub") !=3D 0) {=0A=
+        if (bus->nfree =3D=3D 1 && !bus->no_auto_hub &&=0A=
+            strcmp(object_get_typename(OBJECT(dev)), "usb-hub") !=3D 0) {=
=0A=
             /* Create a new hub and chain it on */=0A=
             hub =3D USB_DEVICE(qdev_try_new("usb-hub"));=0A=
             if (hub) {=0A=
-- =0A=
2.43.0=0A=


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2337ECC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHrJ-0000OL-GO; Thu, 15 Oct 2026 05:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHrG-0000MP-QX; Thu, 15 Oct 2026 05:34:42 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHrF-0006Dz-Fl; Thu, 15 Oct 2026 05:34:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPNAQiPHnAjnpP5ULzcoIjeMOVMmHwlY4LIuGfoMKhQe0+eRhEDwXzElBVb8k+DeHz0KwcZIuB07yZLnoyYIDuJ6uJnaH3HAVSJtpH4Juf9FQeQRd5t2x8LPoriTu3CJZzY4zk06F6XMb866SRQDqQKQPSSnduIDIOOiWXB86WHApO6/YzVZoPeHP1qPPS4cjssLl7T1MmpUn7VTae8/1gZlkjnfJeSx2Go42Mda9edMuTjiFMFDwIHtWCCV6x9hKEPzQAPWweIqfza/hc2Qa7+fiychSG61H2Q01iyXmymZe+mhUmysauOco6ot5zNQWE3A3lteKnsGMxpvswPAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyKnVcNB9bb9Oppe6x9bCVeam2Cwo6wbpr3zl72AnQA=;
 b=uEi3IPoVUuAy1godE9VBmBSqIokbazJiNFp6BvyyXY5NwEaDfZc3EZaVi1jo0vbDESQUjPv7lZxfyUwYARVXro11tYCHsUz/RYt8GCSjJoTNrUW6UegfpZcbxzHk+6IAF1XDFaYsyv1yQsmvh9NViR/C0XJtQK6j7mBW/uJQ6SBdn5bJLAt7acIoKnle1JuYRjZCHh76qxoV4B4VGJpr6+DEMIw5z9Sn+Djh4mMwl3EtYjz9fs3Prmap13OZy99fYmM9C6YoEp3PgxP2vverkooAxIRxKZYkg/nse+XYFmhpgaFi9C9UZHPgojsrow814mZks8/+sb5+8Mny3fIKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyKnVcNB9bb9Oppe6x9bCVeam2Cwo6wbpr3zl72AnQA=;
 b=Qip9ADKsavzn4XWMa7hV9S0S1KeVgVA20r9RNU9FLFnTBayoSZjroITeRMNRPX64CnuHr0b5hz8JrP0h4DRMHZJSnmtWEWPgv75AZoYJhez6Y+l5bTndGpbcgFfW0Q57NDcKyAtapYyTxHbjCJw4eb4S9fCfalycEc/v+KA5NsCnywE9auUzr3lri4K3RTpGKp9AgGnzPQvcEorpGT0z8hm6WXycrkeluKfGjNoSAwaKmyVNRlNInqXTpxvlC55lpZK1P1J9S77eRGMJ1UFZwzmwTYZ6frM84eKX0kmV4kLGF6rR1uIxfm6qiRMcHt9i+xeRKW9LxnkmUD1bntwCYw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB7199.apcprd06.prod.outlook.com (2603:1096:990:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:34:27 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:34:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 8/8] hw/arm/aspeed: Enable the usbredir server transport
Thread-Topic: [PATCH v5 8/8] hw/arm/aspeed: Enable the usbredir server
 transport
Thread-Index: AQHdXIhfzvwy6a2wWUOn3bB/XDfccA==
Date: Thu, 15 Oct 2026 09:34:27 +0000
Message-ID: <20261015093417.573063-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: f1adea4f-f205-4207-920e-08df2a9f81ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|921020|56012099006|261009223027099003|18002099003|10067099003|22082099003;
x-microsoft-antispam-message-info: lOI67xx+UPnuOQBCpAN6A8wDJdY5YNqkOiAti5kfdEFf+K49zuzqyGjjTIQm4XFt5AiaJ30Nitlo5sFt2suM6GHiVTNZd/Mn6+eWvHFKJi1ywOapx0uEjiSvSk5yu8RgEzDGktPb67rBbNL80TIbsm3tKMNzBGLnnQ2e1r5im8ZrVIIC+BQkob88ORp42Q58Wy7abwt5lQZLTNYaZs//I5KHScdfko52jUX0kAsN4Pvqo6T6YBPVmms344eaCDxmmDvy2cdecIWQZMws0cTPOgMw+cKXCvatrz2xFzdgA8QAm/V8neimH6L6Cort/5MZ7VDK/VR8bT6K2r3DvqB85BJIxqNGi4TWBacjK5F6a3r90OstKYFzeas7+e5FFbdc+JNFAGEAyFbH0EzDxda66QqIt2Poam7vzF/ckq8rCjWE5Zkn4kT675w64axb6cEmAfkCchvYHv3bL4QYQMPnDpecfuoXnaOqZDXDzcIZ6A/gqPVu3tfieAOtPL1TWut/Y7tTz9RRjhWIJ1jZ93mAufC6DGdysKjAScMcwuoysC4mknv1TahUfWtsih7CyfU6N9mBitajLjFw0ox4DCV+z+vc1C2/9cQ9Ycm82W9l+hxSkvKHew+7ZLpkSuy+RbmHTfVbQDBfARFDAQAI032ioXsVlIbMTkqOia3FRyQJt6gtNgrOv6Dr7FtF05DDUql7QjockqHSktyTcTztq5e8DErdbLnqe2x7+7mVBlQLED21IzfrjbJV2NFZEia0eXVi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(921020)(56012099006)(261009223027099003)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V1McefO+27E2yaVr9uOW5EYGKtt0LVsrXfNnQkOFxW+AtRrtVdGZoudzYN?=
 =?iso-8859-1?Q?BEeFQAHwWKg/7ZMI8swNclSBAL6okpJDv+GdQSCs4SCBpiq9HWlKE7+apv?=
 =?iso-8859-1?Q?kFTgJ7JRtvKqf9cKo1nCwhIOPPudvi0nlvk0ueb3YzIFIc+x540ZZod1X2?=
 =?iso-8859-1?Q?4CHp78mFbzfiwy4cC+Oac/T06hJVTxHXblicvlJ9xEwkwwkEDISOqkgGVU?=
 =?iso-8859-1?Q?mCKUcO/uhTb2T3Li/11DP9lI6IzgE5xE0ZhoeKStcxzzkwO+tnW4sio43g?=
 =?iso-8859-1?Q?b6acwdJBgw/TqgReJxGRxVvZ/qeW36SETbSwVg81N0bng6BAxnsPouPRVo?=
 =?iso-8859-1?Q?/fwBZUeQSrfJacttdx1uwB9CwW3E7b4JvCKcOogUHZhp/HVomA+u93rw7C?=
 =?iso-8859-1?Q?+JGGTj1SjGaqHOKF6/KhXdJLm84wyJ431oSCn56MXijB1R0tQbuawGB9yo?=
 =?iso-8859-1?Q?dAyEZwG8PHohF3pflsVy3f+esG9Tdi2JKlVn3VgRjLOkTtnPyGPXdxxg7K?=
 =?iso-8859-1?Q?l4yFoLa4c40anukqhJoud5UjigkiAnIoU5+SMX++dn8ByaIOGAXxK4xNBw?=
 =?iso-8859-1?Q?5Zp+t/UiX38IHfcWvanQf5o1DaBHeE4H3btdtqT6+39GDO+Wd/GEdfDESY?=
 =?iso-8859-1?Q?HptY1VNthjStbUi1SLRSmhUNGJaztXr5L+JJWQXScSYEgOa1eDGAHraLMB?=
 =?iso-8859-1?Q?Sv7tfYhbwBbg7zIisMGThFONtVcTX8RP3ywVLZ6BAwZt0fSxGGQheSKEtd?=
 =?iso-8859-1?Q?po2bXsTOyDihh6Qj5hbtPCMOQVLAawLP86SSbbQPsiz1szPdCt7ZLPtdqN?=
 =?iso-8859-1?Q?GN4CLXa1+WtJ5oqUXU+1JUpYfFLdblex6DD+KXdCzunu3Y0kWcBDbyppNT?=
 =?iso-8859-1?Q?g7Gv6bDz2+XgdsbStpKljPo7akNtz0lrsaYnnIeGusCAU5Lp854HiBeOFb?=
 =?iso-8859-1?Q?ZlqfbDNoJT39CknPOGhtZJvfDnqNhBWnDuUqvfC7Zpvm00l5ifIYR0qPIs?=
 =?iso-8859-1?Q?OYTVmEEbg8ExkM0Plxr0AXgeQcJ/YMzYKp1Ubj5DnWr8wDzF5MZVF3a7Wc?=
 =?iso-8859-1?Q?LsJuJImNngWrCTj7Zxk6QeOt/2Y7UorYP0aMZDlZ2SYkWlapTeWSat6smW?=
 =?iso-8859-1?Q?HQ2/1A1LZWnu3ONdbPmkfTfvcRgHzpbgKtGCgN+frLUJKc0x/vuEzBLJ/F?=
 =?iso-8859-1?Q?m7Wo5vYNd9c9/+GT+rDu2ytFtS/CTskro+o0FJdUqdIA086pesiFx4ozbP?=
 =?iso-8859-1?Q?rMqqVH5t4o5T4KjaO7q95SLVEVlPrPvR7UMTXcc4WzVLk3tCxJ8Jj/B95+?=
 =?iso-8859-1?Q?4PRqetshyIcn2YB0gTsp0FIOCZQg50TDd/czGLgrAVMg5oj/2cOtu4nVqX?=
 =?iso-8859-1?Q?GKaul3Y5HxBjwmOixlmqGNzB9/xnxHl1vaI4mjfFBPXBFA4iaB9m22nWuK?=
 =?iso-8859-1?Q?NbPrSstvAnT1y6h+Rbk2eZ4yKBMx1GKQ2EHUXW9UfKgpE6ZyZlgWxr1ay+?=
 =?iso-8859-1?Q?IEcm79MUY7NxfVFQV3MAdE0G72q/E5hMjOPuxGmKFxjCQNfycdEXTLsYuh?=
 =?iso-8859-1?Q?SUTC3Y/hMEv1Qws2TkBEM46bNQZK/Qo4vgPqcJBkr1+nZ+2jndprikMCcT?=
 =?iso-8859-1?Q?ir63wpVt/Kc/JjTfaNN69yiSaBeN6F4RVBJPFc/zQRG6uir0fTRQZN3lUu?=
 =?iso-8859-1?Q?OR9N8Ue3Jz/6NXDbCnrKpZVaffgtVQzxs6VeeYr3isTntOIxi5UOrNrFNj?=
 =?iso-8859-1?Q?FKZ144nSYBr7RkYykFVb032RVSkc8ki5LiFm2jlNPf+bM0OqMhyRpHOGHn?=
 =?iso-8859-1?Q?xY+l9A8wPQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xQ41OkA15YfhanjuF5YxDV3EOM+QLefpUiNg9AEcyJJI09VkFSgb8lqg2VXkTLTE96ywx0NFkuFls2cvA7ZNZdtlu/sHtVOE0EflwZKIXK3C6DqOhj5P4iQgBib5kgFN+NHR8QDKIjFmtgrOc75Ni8w/VhplmfNvZlM5iJDlBGLiufr6OcCGhljP+lJXs0QRS/IIzUq5Nq9omODOx6+q10BJNaCn+RSi5DaWhoO/BMYWyUWUmKnRArdfLTCcTTjh3aPQKcWvDR06FvfglXThK4F5NOcft0HOkLyo9cB0t4FzLT9dV9Agyz+5BtN3fftpwLwAe1NAqkR+L0Gz2E1f8w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1adea4f-f205-4207-920e-08df2a9f81ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:34:27.2374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8p3hII2wHjHlWSvYp4VPUcL8iPBvIbajzpjBAopVedrY0fJE2e1GxyJJPlTxDpgzPxSvNVfyqX8YFP7hOwdD4viN6H57C7SV5q0mCMuAq/I=
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

Let the ASPEED machines accept "x-usb-redir-server" with -device, so a=0A=
UDC gadget can be exported to a USB host running in another QEMU:=0A=
=0A=
  -device x-usb-redir-server,id=3Dredirsrv,chardev=3D<chr>=0A=
  -device aspeed.udc-gadget,bus=3Dredirsrv.0,udc=3D/machine/soc/udc=0A=
=0A=
x-usb-redir-server sits on the main system bus so that the USB bus it=0A=
provides can be found by "bus=3D<id>.0". That makes it a sysbus device, and=
=0A=
a sysbus device can only be created with -device if the machine lists it.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/arm/aspeed.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c=0A=
index a7cfbd6c5e..fc27ac1788 100644=0A=
--- a/hw/arm/aspeed.c=0A=
+++ b/hw/arm/aspeed.c=0A=
@@ -409,6 +409,13 @@ static void aspeed_machine_class_init(ObjectClass *oc,=
 const void *data)=0A=
     mc->no_cdrom =3D 1;=0A=
     mc->no_parallel =3D 1;=0A=
     mc->default_ram_id =3D "ram";=0A=
+    /*=0A=
+     * Lets a UDC gadget be exported to another QEMU instance over usbredi=
r.=0A=
+     * The type name is spelled out rather than used through its macro so=
=0A=
+     * that this still builds when the usbredir library is absent.=0A=
+     */=0A=
+    machine_class_allow_dynamic_sysbus_dev(mc,=0A=
+                                           "x-usb-redir-server");=0A=
     amc->macs_mask =3D ASPEED_MAC0_ON;=0A=
     amc->uart_default =3D ASPEED_DEV_UART5;=0A=
 =0A=
-- =0A=
2.43.0=0A=


Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685DA60A260D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=JMbtJlND
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoFQ-0007L6-Un; Mon, 02 Nov 2026 04:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFD-0007JG-Dj; Mon, 02 Nov 2026 04:22:24 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFB-0000WY-Fj; Mon, 02 Nov 2026 04:22:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Upi7bML+hEO2flSysAqrv1FsxtE5fLwJhkpmsVHDObxK2AQ8S+KIu8geCVF5l9izI0BDM/kgPG/C1zFPoYhvaagl7exr+Cr5j5URcbPprODJlp3tWvSHGaBdlLqXIwCV51xeFzOBeni5yn9+p9C9OSU7SnOhkXBYXe8Cht8968KeMeX/0s6kKitNppIAkKoV47p7g87K0V9jm7MdD6dkrLZEwcIHNKV+aTr5kMVo75pP9k/iVYBcJz0xCuDXtmc9q77IidopZ2ijY41UJvquBKfZxqJzsp2ev1Ey1v2hrEv3Pql69YSn6AZAAHUQk4u5oKvXs8MHM4k21zEtZeHF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymaNZN2H+GfrYhLbTN7EX4AzfAlYVc4ESieedfSDjmc=;
 b=yafyAQQr6QR+dRyrPkkG3IeuWwV/zwT/B5SKrqfoRxkLa3OQMaqB0eBD8r+uJ3caWxF4zJguDL0szP1z2zoHNcztmOcF8xIoJoAHEzUO1lim/qMBeTlGwXD+Zz1WT6qztYrmyQigJmH24Wp+/UlIJzKI+l0dchkxltJlDLenz+Rc1ebiDAQYpcO9wQ947HS7P+3FixnXQ5xJ1Oz4KSfjPtLXTQ6d8gvlL3udCkCQwZCzgGrX4ZZY36gHaDs1WzkSFKgxDnbSqc61/qYuhDPNIbLCeToeLBcTOc+fz/JjpbnZRFnUuKNvkp+VjfqlVSK7iSbA1ICxcSIpGNObSo+QjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymaNZN2H+GfrYhLbTN7EX4AzfAlYVc4ESieedfSDjmc=;
 b=JMbtJlND9zjOXz+moFB/9B93T1c/a5Rhk/ZbjaTbOkLfAV4P0+ixjdJAhryBihwoJB6kz0rSsFY60foK0ni963mQigZwI0woIqyaq2fLZ2DHvZPrvdQW9VS4s4A7sW+UX6wh2qTMIKecXjpkmwjb6lzH/Bib5Jar4rutT7iDrDsYRhFUyG83iwlRBpTgy6+PQQrYApFbsJ2n5NBnSaVsxR82Aaa+vY3xEQ9WrQILqTk0DX0YV6d4+PFna1oa+1VHOMUNtsRat/rkp5dvO0zPF/DIr+5LGfDEHG01JWDpheFNnaHiiy+m6hlVPTML/ziJcPvHTkAfTw5lpIkZacaxhQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by OSNPR06MB8331.apcprd06.prod.outlook.com (2603:1096:604:470::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:13 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 07/18] hw/usb/xen-usb: Do not insert an automatic hub
Thread-Topic: [PATCH v8 07/18] hw/usb/xen-usb: Do not insert an automatic hub
Thread-Index: AQHdaqukLyeSt+lGUU6ZEok9v0k5rQ==
Date: Mon, 2 Nov 2026 09:22:13 +0000
Message-ID: <20261102092201.1729245-8-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|OSNPR06MB8331:EE_
x-ms-office365-filtering-correlation-id: fb2b63a3-5d52-4f86-96b5-08df38c2c778
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|22082099003|18002099003|921020|38070700021|56012099006|261021121427099003|261026140227099003|261022105027099003|261028144727099003;
x-microsoft-antispam-message-info: cIzMGpWHHIRZPDwo85H5kGDrByME7+1AOIOyG6oF77U9tuQE/k80PIg+1sUxpFnfUfmg63hdzuc2cgB3zpmnf20vOShsmOz6JHWE8C6chgXIklzGvFCL0NEF7hi57wdm17qtqv+Pd67Dug3N0rnIHNry5MLASgOQgX/0mexuodK+ZgUumCWnOzKaYIq7tJn/nh8xIj+nNyIa3ZcjWvTgvBjsuPXLgR0rZKyYV2tfyH/jbS8LuNwyVpk496va95596Azo4PnaTs/Vz4bNPJb7dhbAuu92wUIBwm0sOhMY9Va7M29lXXYHb5Bgwsh+/tBj4ZMJZtTaHCfT8V401g9vdypiqrI8A7EYb2xM3xZUYzpb7hgns3P6uGAhwHyaeDVBltlfdASNFFAf/gIw9b+3AY6QsdBILEkoKYuvJ4bdsn3iHbOCCsGrBALOZejGXioEXGobrNHpaaoLC+N7Rpmj2kTTc2lFKPtPyib5FrLUQpjXiP6MxSEF5BbEEus89egxlEIa6fgvO/R96f+GAX/FWfcdMB25p+oW1s5oLto6gSmcKQntYKO31CLYjJup5Hcbgj2Chn0a5uBgXJPggP5geyLs8T9IYizB8jn67J1Lx2EQ3ao6JEE1ymk+BeLNwhmyYu9WHSJ8dHttKoks7FsQpNj4QsMazfrL7wgo79vARp0HFOTT1GocOEhUsM6txN3Db1xSuWtz7myZULAHgfJ9NzXD5gnT4rkAigZW2NJX6mJW01ePQVJajOxLMLVNsJYf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(921020)(38070700021)(56012099006)(261021121427099003)(261026140227099003)(261022105027099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?o9UQOjdI7/CV47YQ/6OWByEZu90lQq02X87bWjvJKE28XqqRIMvKq/YbZN?=
 =?iso-8859-1?Q?mV/FTl+nUNZIAr7Bqq2lFcy3TzF6hR5wxD9p6WE2/RqQbosuGO5xaHLRzA?=
 =?iso-8859-1?Q?APbLk6IM8a978Ncj0U37MuHBuIyQ4IO13HWxoiBNDe8PXFnExJ2e/1LsXX?=
 =?iso-8859-1?Q?k5HN0JBr+wBKDF77YBPyv5YGanwLq26L4lEPp/Rwg4MZmv033b/ARZm91Z?=
 =?iso-8859-1?Q?Rfs4m8ZhpnVZ3/HqejPIU6FPd+oHO5VswtBv7zPbFUIDNFvGkhllIqk6Al?=
 =?iso-8859-1?Q?NUtDibtHof8A0sFymGePnLGIvvNbmFvuwQvlKZ1PNI59kyARDu+PY3oKYu?=
 =?iso-8859-1?Q?hAYwzofuAwPVZg/hF9bG6frmI8yHLq91K07emdUJh3LY8T7NvmqfNVdxYh?=
 =?iso-8859-1?Q?ICS8kYdoDQFRQ/QxZ1SUyVMtI7iBsSUIQzx11sWWQKj7YqhIJuwh+G9Pxx?=
 =?iso-8859-1?Q?m7qiC6gwwSZt5Nj56VmRXPnz6p7FVL6KhkoZBi8S+MBAVXIRb6gqV70uTL?=
 =?iso-8859-1?Q?rvx//erBxz1cb3sETW0C8l/gci8JlvwvKAsrtX0N+12Piy6yRiqts2qzCg?=
 =?iso-8859-1?Q?LViU9jR38w2H7HJYQAsPC4zKrnfk4VS3qI1/VOh1AOuHrScNFwM2myMHTf?=
 =?iso-8859-1?Q?BRkac+xeBSEgbBgOqFXuUUZylr/3nqLDCM+Im1RuPxe15O8ONnrjxaNLR7?=
 =?iso-8859-1?Q?fTkI/TQxCvLdAZKVlIbvGM4Pq0UzBS+AKB6hqlkqrvsw6hVj0JaozsoLNg?=
 =?iso-8859-1?Q?fUy2w/4hDgIXG3ba/n3bJR+CnbNFKFF/uP4gjVPQxkyEtICBbHCyE+Ddf/?=
 =?iso-8859-1?Q?S22dGbzfEqgICjuCkF55GiRhas6MfthuiWjzsjwVgwRG3CHEtVHXcBiwJ1?=
 =?iso-8859-1?Q?s6AHLbrMIRQhaHpgtyYuxJIBlqNNdjLMtf+IaXmBU5VPOYWpepNaJnuPtS?=
 =?iso-8859-1?Q?ECDJ+oVwt7SH6Kh8hxPKkHjUlx5Tz5EC0pXQKd8XlWc8bYOvVjbnCHwzQU?=
 =?iso-8859-1?Q?FoyeKVMM9n3E0A7902K9Gp8SJo5muzqa0XQ457uHuAaoJ6PEz8qY9U63Ja?=
 =?iso-8859-1?Q?A56xmErZg4pOI6U736hGApUZQ0aV/Pozr0enao7aFlQ7If0eCeqfl4z2e7?=
 =?iso-8859-1?Q?zl5fvH9Ms10JqY2brMmip+evIA7obISSNPmQRbl6jwrZd9tJZ3OHOPphGY?=
 =?iso-8859-1?Q?AkLSZeiqyeNIFYc+aGx3gZFfmx0v+xRoO8G1j9XFuCCWEP8108dplTWmHZ?=
 =?iso-8859-1?Q?4yAhS3AK+hO4wpzlHI1w8ST56omd00IvJvqPjC1PuNXywzplO+NGImgLGr?=
 =?iso-8859-1?Q?vJDo8hJ6xCCO00mXIGRwT5oHePNWU/+1shmA/5Zq8DwwUBv+tns8Da1CxO?=
 =?iso-8859-1?Q?/PwT70HALJUBPweMMDUu9KpdIPmNOVLJik65nzu+T+b1D7xDd3tnxe8iZT?=
 =?iso-8859-1?Q?Odb9dhBZO7BzXGpubRQj4KgwDXc3leJxixrbpBEbtuJX63EeKciMglSJOs?=
 =?iso-8859-1?Q?uYd3dHbKd6FFCGsfbcBgBRgnk+XScGj9dj799X62ZY2ha5tyaJ3Rkz/y5O?=
 =?iso-8859-1?Q?6OMBqljkGyYEsTixqWMiV4kAFLlP0ln9ORu9VJuWkcAwdlvxFTcn6W/UO5?=
 =?iso-8859-1?Q?CrOjrPDAdvIpsoGzerD7VlI3GNviELjnTNl9XCq8x5epF6X6ffbKaekgz2?=
 =?iso-8859-1?Q?EXbbPxEC0AqWScGgBlvyGk2IP+/wGGDnwLU/izWP8YYsVBpzRMswJR9mry?=
 =?iso-8859-1?Q?KjtRXUHCVY0uuqPZu/NX1hl3ugdngTf3eBo3vzCP1hxkzDIUAjcpIXrzoG?=
 =?iso-8859-1?Q?vP3AkgX+Qg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lEgt2cxkcdJwEACbP3ZS5FfSdwS/pSXGEIieZvssk6nDd6UVbSf75FWGM0uOoCmAgZA+eqMuFBtxKYTwxvxpF5r24RLWXpiF4QywYhwIqcYvnVnnbSCeuX5VEGOWpHqVQPlMmEgAFwYRfDtWNUGyJ0ME+s96sDq0nPhlrPHhkF6SugVe8yeJSP0Drd1V2dVvaGFfM7o99dpUtM02xFJ+KseLMcIFc43gfN2Zk5WZ93Z4iciJBEHs8HgVhr4Rwq6PWAFpNX4BNUqHKHN/VTJKQPzKmn0V0dbs0r+Nqdd+ZlsVzGb3uVbrXVZRe5w6/npXF+9/k4ZWdmvDzjd1hxRdjQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2b63a3-5d52-4f86-96b5-08df38c2c778
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:13.1254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBpdwFEjuvrrTKDykthoNQi0YxMHwBOzAWT5HPJ9x4OH636OxcZaZi8CovHvhONb/t8tn1+zoFgGuEgbxHWHVUZQs/nGdBLYQfyJ2ExOtLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8331
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xen-usb gives every device a port number. usb_claim_port() then uses=0A=
that port, and never reaches the automatic hub.=0A=
=0A=
Set auto_hub to false. Every bus creator then sets the flag itself,=0A=
and usb_bus_new() can stop setting a default.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/xen-usb.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c=0A=
index caf9efbb77..5d1dbe6b1b 100644=0A=
--- a/hw/usb/xen-usb.c=0A=
+++ b/hw/usb/xen-usb.c=0A=
@@ -1023,6 +1023,7 @@ static void usbback_alloc(struct XenLegacyDevice *xen=
dev)=0A=
 =0A=
     usb_bus_new(&usbif->bus, sizeof(usbif->bus), &xen_usb_bus_ops,=0A=
                 DEVICE(xendev));=0A=
+    usbif->bus.auto_hub =3D false;=0A=
     for (i =3D 0; i < USBBACK_MAXPORTS; i++) {=0A=
         p =3D &(usbif->ports[i].port);=0A=
         usb_register_port(&usbif->bus, p, usbif, i, &xen_usb_port_ops,=0A=
-- =0A=
2.43.0=0A=


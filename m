Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294A5606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=CVxfaP90
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHT-0008G1-Hc; Tue, 10 Nov 2026 02:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHR-0008FJ-BT; Tue, 10 Nov 2026 02:28:33 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHP-0005V4-Tx; Tue, 10 Nov 2026 02:28:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMYcCnARobE/thnUhb2Ryxw0mI/2ftkLLTE/KHWGjd11Z/VDJW662pc2YeF1Fyot+dvnqsu2L+JuxBN3jj5pk+9CepD3nBL25BHVXtdJs/uJeeVzAek7G2uT99qyGX2oaL4PG1/dma84PO1N9wHR+H5M2npbu1pidM7lXG579Lbx+QBHpcEHF/jMrBnjxuCcA48IylxLGDyue9GA4Xv3fJO78BoOXBD3DMXNm4Eh0FvfqWPsvfQ3ny2WNxnqTPzM8IpyF5Tuo4gLlErPL2OfYvzK9D8m/rB5K2spYFLUXHc2PLxHKkn7+bzma7+7mC1xZUhNkNEoY90VGY6CgULYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+iMLQF/AYehb5VJ78GU+E9zHQMY1bN+GoDhIPU36bU=;
 b=WS8nyiJ6cWN9Uc5VSoZ+nsini9EJQFA7fms6M0Q3orNLZ25IUXXwkhCMzbqTDOXBKXa3kR/+gHAwWqXkG/swkns3d6ov6oV2VXKe5UAQeTEOMUCe4iKxZw/E/2TTrwSx6ldMs0Qk9wLoc+IFgMAvvpOU9nBX8VocXS+OB2zJj5pY4OfxAbh7ANv/+BDrZlnXwso+5vT9GMgiGlb7jK9wzSetkcyfmrCCUI54+Uw9/dR892BrgyjVb3aH8+S9DMf1YXvegOrt0trUy3qptqgtbxbV1GKdv/zSQ0GMcrwShFeJkLJcnsPVJWYfm9U0lmGZd/s9jATuPWPEbhZQNyWO3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+iMLQF/AYehb5VJ78GU+E9zHQMY1bN+GoDhIPU36bU=;
 b=CVxfaP90VuT6xAQzJ5B2vrz5X++giwNBCazV3RKruyfkWrcacSk/WO7Zx0TWtIONmfH7a4V8PNLdsLXQRt4Vz948aTQkQU22pQIThZ47iucS00x4R07qPKI/XtsbkUwnU8Zh+SGlwbyrKTgwDzbhN3nhLPey97BhA7lptcIL7XSPLlcsEu6Rrx7m7OUNnAOVsNvb9mXbZQkWo38MffPxLb7RDS+H+BHIfsMDVi0Gmyw/YKljNMWARuezRVVfX6z9pPyKqJVDPOJInqKeABh21vHMeIX1Vt3eVag/AoveUpuw36PFFMeQa9ulG1g/kMuIQDFjM3MOn9NayFhua6FU7w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:21 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "berrange@redhat.com" <berrange@redhat.com>, "junjie.cao@linux.dev"
 <junjie.cao@linux.dev>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "clg@kaod.org"
 <clg@kaod.org>, "junjie.cao@intel.com" <junjie.cao@intel.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
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
Subject: [PATCH v9 01/19] hw/usb/bus: Add an auto-hub flag to the USB bus
Thread-Topic: [PATCH v9 01/19] hw/usb/bus: Add an auto-hub flag to the USB bus
Thread-Index: AQHdcOUPkQHTyM6vNEiyaAVIcvUrnA==
Date: Tue, 10 Nov 2026 07:28:20 +0000
Message-ID: <20261110072818.2883349-2-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8987:EE_
x-ms-office365-filtering-correlation-id: 45f81576-c4a9-4573-8503-08df3efc327e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|921020|38070700021|56012099006|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261028144727099003|261026140227099003;
x-microsoft-antispam-message-info: uNBzQulsxNOA0k+lGGHFMnZYCJNal8xrodX65X70y76i2KbO97VtNkq0GY+CZoYwRQVRhrbeIHfBdL/o8xdugH5DSvVCSQiwoyTigebfzxHpg8QFG0aeVzSMs5TMHkRKQxsttxoZXq2Xg53tAMIo7VRQkQK0ifsjs00mI11avfWxzmZH5LgZoOM86wGfeJvgK26YSYvqouCWaNdD3v0uFn0fEEyxO4f5l9oYJMYoEiNoElcrAsGQS6ftofnPCSDxoOHp9NOjIYxqQMuh1O85bcA6aqwE5t1yOl/edNxL+ab/cdVjK5+rnzAyuZKlaZu/Hzt8GarF3iOpX7jckjfdWCCny7scym/6RqUXYhKhMe3y3Uu1hpxhfEXxgON/1IyMA/+N9Q8zswUFOv2Eca++FNspW5/Zjt5MT1lNPbPV6t7qF7QbRJWL54//1wS2qaem7UEQXG0GxDq9d5cjgIh9gH6dPrkGtOtF5hvuEgI/+NDhLW9LV7GfpYBb3WEVDJxKeNOYUy4oQlKIIEQ8qg4l+Sj1BysQSwjhxxeqwYBbOO8SV/eG4tPeNr/K9G9WqCh2EmjSo+zK+V4m9wVOzb2+PuoUlQjXKEC4v97vctWm330xXcxXUkWOWGuPzMw2v/ObLJy8pkQKsi/w/yDpJa8dErYAKnpemEyJTBp9vY4dvVB77LH0tDr4SizVmwAIwNykZjmbzWYvxo1uJCIIWX0b3pok7KBFTyYFpTQ5/UIjNoM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(56012099006)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EUuqDY+knv4dFOWK3REVcYvA5q5L9FzzYyC6X3Ri9H5fy4e0FTYtBDjlrj?=
 =?iso-8859-1?Q?WbopuqbZ7d5pb90TGZJKzIxZ8RnpErUDPjSTicP9VJq8DjjeKoX9vLBgB8?=
 =?iso-8859-1?Q?pPq2lI2aT/DR7P9JqhHv9B93xXDnUMQsUx3vAgtdwCfe9M0PHTfL1uMED/?=
 =?iso-8859-1?Q?UcxKfTN5VGy+0ddbT/uadXoOAAH9rz1elTz7c0nO/Xu+c5We4MV4EIPAdX?=
 =?iso-8859-1?Q?G3kKhNRmWUGG+Ois9fnNLDvsZmxwIqsL4WfEgrmfeWFsUz3Q1P5Rhg0mq1?=
 =?iso-8859-1?Q?qNtpezczuQwdx5XKv7+y7VIhqZuJS22U3fw+6yWJJzsGr2cGyByiVd/EXd?=
 =?iso-8859-1?Q?v8OhXGVBdtbSu7L1RzCN8tOuLD8DQZPL7aWleTUqEieAhWfEdH6j59PCzJ?=
 =?iso-8859-1?Q?HZvnDSY0ObYECFI4wGiO1C7v5BjggHiST+Yvjurt9hZR42xt+8so3enOIc?=
 =?iso-8859-1?Q?4kAQ4lXmaNoYu5gj78353rfE1K/F4wASIyHHjoobfi5bYvDzNtHIt1cJnU?=
 =?iso-8859-1?Q?nXS4LzRKqdVwf6kZs2TUPsW6zd+omxdgxnYrsOOgq4GaaJKZh68Mdr75ZR?=
 =?iso-8859-1?Q?GIVULv7FlKgpiYYgz2pdLRsUfR/L0NSxfue37+HIvnXHGVBeIv3dmW8mBh?=
 =?iso-8859-1?Q?Z7FiEtizGYI435DmxrDhylITqfTEB08vOWiHwuWf0WXgrde0o5nhbOHAiO?=
 =?iso-8859-1?Q?O92I+SfoPEiVK2WXVE02sIM6LdXrvCbH3iDy8TpoV1WgyS9ME/1PJm7w90?=
 =?iso-8859-1?Q?XH4aQFTqgC7LmAkGQ+WjE/GD13FEp5BRGvX/MJ4RJx3I5AU83fFx1Cqk21?=
 =?iso-8859-1?Q?fMHaFt+dHOlvX/GByAomXn9sy8HBZ6wGzKnIkuLdP1P8dLimDxIfVyVsHR?=
 =?iso-8859-1?Q?Tt/Kzo91bAIDhpYxS1rJGyTAkfU/QHRvkP2+LEU2fiJy4rXIB2pcIL7Pzr?=
 =?iso-8859-1?Q?aIj9X5S634fagERmJLjisKhsPMKY2gs05pLqYozCI30fTdVNCu32hCj77n?=
 =?iso-8859-1?Q?7rtoKq9asju8qaS5QzjPb3RwRvRKTIbOOyOE/uyn3dS+6ZDmRIE2AIwGqL?=
 =?iso-8859-1?Q?jNSqj4LXPxHfkg29PfgP76VXrhGlQvNUGsFlJeYg1Dsvhg8YFRTf7/qyBl?=
 =?iso-8859-1?Q?l3eiI01sw7ZRcWUvaNpsqczvugOdL7tZWuPiklt701gIXCof2ZA7FF5tvH?=
 =?iso-8859-1?Q?doACNjHOB4uW/WlQHIJT9QSxMu1R8jce1wltmrZo/Y1zkpp6pOUQK89mKs?=
 =?iso-8859-1?Q?ZIFhdY8xPg+ewnHfa1fPADsaRPv58vQfRSpEfDS2FEYTk+gOX+4+Av7N2V?=
 =?iso-8859-1?Q?r9czw9BgoQn+1rnMrRd2M+YNnvlQ6G7e0dPzPqTWyz0gnrOi/Rix6XR4eL?=
 =?iso-8859-1?Q?6s8Mtxbqpsm2ko+o3eMzr5edlRfVgFxR5BLDUYAWYkAWnqmnsRA814IZZp?=
 =?iso-8859-1?Q?ou6GqIgV1sHFEv9Npi3Vwm4VSzyJP1PQLRc13rEaZ/sxkdHP227SgN7oBd?=
 =?iso-8859-1?Q?gxpH3XjGzsbrNbW/6Gs8FELQtZTIHBmKL/lD+Gh1f+YOkeswyllkaBS/f4?=
 =?iso-8859-1?Q?WXE4g8bFZmWyu7UwfGJ/MGxLJ/xAGnOCD9qt+SODXCQDrmzoZ5Wdi/ybxD?=
 =?iso-8859-1?Q?KwKcn+gnYoj16ILeOTcKuIoXbosyDe+ETTa3i4yNeysXM9kL4APSWleKAp?=
 =?iso-8859-1?Q?vt7Lt9xNEinCGmD6zR6gS/FprHq3SMiiTtFDHuUr1rfaIwnvi/5dXSa0HS?=
 =?iso-8859-1?Q?PjY+0rDdjtPqo5eX6svZ6HV6rRNYsfoev/+vzJN/i8fmf348gHTZf8rLNk?=
 =?iso-8859-1?Q?v3GYztGWyw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PSXO468f87ocrgg4qTP/y+BCKjJPHzD+KXzELhCCfdnY8GCTn0SAW0uz+B1sVhBA7VwXEwB68CgtyA2K88KD3oYSiN/cnxIEzujC2nAUJlkX8ritEWmWXLiyn2KN704hk8jHucqe95oHaHp4pRXe9XR5jsNMisWcVOIKwWsroHfOXHH5xjL1yJV0dN9lEq657AaJXr2yK9LTBDmpSBxSJo8PCMjS5dIGEF6FgnRLJnVmkOyk3ATt3dICzgU4+B1gcJ1cUgU2ynDd7zHH6J5/s1Ea83bdQKE9fAQGl6FPWguKby5T9zXzjPkQcYzJet8h1QaiFavZEQg644FuezRDhw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f81576-c4a9-4573-8503-08df3efc327e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:20.8889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D2lg4khbNQhd8779pvJv856clAE7L7tvl06SrMdoPCaXgl3b6TSM/ppkqA7v7hWV36XecLp6k2VFsZapqDRZwO657H0Zs51MngbALZXH14U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8987
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

usb_claim_port() plugs a usb-hub into the last free port, so that more=0A=
devices fit. Every bus gets that today, and a controller cannot turn=0A=
it off.=0A=
=0A=
Add auto_hub and have usb_claim_port() check it. usb_bus_new() turns it=0A=
on.=0A=
=0A=
No functional change.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 include/hw/usb/usb.h | 1 +=0A=
 hw/usb/bus.c         | 4 +++-=0A=
 2 files changed, 4 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h=0A=
index cbd4711933..cc1d6d74b1 100644=0A=
--- a/include/hw/usb/usb.h=0A=
+++ b/include/hw/usb/usb.h=0A=
@@ -484,6 +484,7 @@ struct USBBus {=0A=
     int busnr;=0A=
     int nfree;=0A=
     int nused;=0A=
+    bool auto_hub;=0A=
     QTAILQ_HEAD(, USBPort) free;=0A=
     QTAILQ_HEAD(, USBPort) used;=0A=
     QTAILQ_ENTRY(USBBus) next;=0A=
diff --git a/hw/usb/bus.c b/hw/usb/bus.c=0A=
index 5cc5ffec33..92f67de4fe 100644=0A=
--- a/hw/usb/bus.c=0A=
+++ b/hw/usb/bus.c=0A=
@@ -92,6 +92,7 @@ void usb_bus_new(USBBus *bus, size_t bus_size,=0A=
     qbus_set_bus_hotplug_handler(BUS(bus));=0A=
     bus->ops =3D ops;=0A=
     bus->busnr =3D next_usb_bus++;=0A=
+    bus->auto_hub =3D true;=0A=
     QTAILQ_INIT(&bus->free);=0A=
     QTAILQ_INIT(&bus->used);=0A=
     QTAILQ_INSERT_TAIL(&busses, bus, next);=0A=
@@ -413,7 +414,8 @@ void usb_claim_port(USBDevice *dev, Error **errp)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (bus->nfree =3D=3D 1 && strcmp(object_get_typename(OBJECT(dev))=
, "usb-hub") !=3D 0) {=0A=
+        if (bus->nfree =3D=3D 1 && bus->auto_hub &&=0A=
+            strcmp(object_get_typename(OBJECT(dev)), "usb-hub") !=3D 0) {=
=0A=
             /* Create a new hub and chain it on */=0A=
             hub =3D USB_DEVICE(qdev_try_new("usb-hub"));=0A=
             if (hub) {=0A=
-- =0A=
2.43.0=0A=


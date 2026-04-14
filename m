Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D49ED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhf-0003fj-Vo; Tue, 14 Apr 2026 04:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhc-0003dD-DY; Tue, 14 Apr 2026 04:00:56 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhZ-0005tv-Vr; Tue, 14 Apr 2026 04:00:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3lKianQA792ONx/EmgMUItFss+bbq2H+TlbwemqLmOs3AHrcApyE7SEmigOBp6vFX0x7UEQgQMb0WO81mKfdtu9Lbmd2DKDYZkGxJMV/Cy/3wng1TSBf+maZlw7k0OCFWI7jqxfaHWwmsZAE8Z/hzGFDU/opfQP7Pt3vkBVJYq6p26belR1HwWr8TjLl6cpQzaDdpcyOq5AG0///YB/yS9V3/+mQ91/yhkaCceNImRiOyFyZ3Kb9hkHmLImhz8xIQYhlfZR9lYyDvHnMUnqC8UYD7vzVjWR6McOmRhX3qnDbE1J/EoMOcsA/ZuPlurOxL1uQAR+3GNtzpqJteHXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0k5yIYwJDLo1KAYtNzWFMwPPZnZg44krZ1IPrhD7sc=;
 b=QcCiIEIhfGX77JGoGa7CaifSEhzWFi+4LCEuE9jWZBtiCil2BpIGQU/HvmeM2RmOOMy+8NTw0gXF+GSPeLk96jvTI0iIpJjRE/O2Ka/8KSNExGt7QNC0VUB4f5CjHXlXqZzFUHX9/adJeo5Ca25JeIxTrTqKlZpT6oADVfUQ2tkYISPFGiZ0jfpfRfYm12YYlsTHpyn43cmpMCzhDAhk4O5mJBDBoxekRONy5pHWh6wYWQxXophPV4m37WfhsFKQHR3p+OctxUa0bVJC8gawjmjrPeYVvWfcdw1HQGTFsCyLBllKQ6eXVgsu68l9iuEZvI3tgSyERqjx7nccimqM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0k5yIYwJDLo1KAYtNzWFMwPPZnZg44krZ1IPrhD7sc=;
 b=Njp9veo0IZQR7Kg3W3pwgXT2UdIXc1PImrPY6PfLxZ3Clp3Smj+5XsgMdqLzzEhfNYAlU6GEag6LC3pkuWwJVHFPjaS61UW5XeYm6kpD/sJA40q04TjFn86wLdkabwHWlCNO7rOLcyrBEx5IhWhObhQO31YCNMTHHT3MYlPE23ZdMSgJMcLhrpcPtQzXMY1BwQClfpw6VY1o7rtq0+AzSRSl5rlSOlfUYInpD3W9hRJ3T8qQNqvmesEtKzjS6lXvRtfgVbpxV1H+Pf/9I0MRPRU0oiAVIVw5PdBttUped5p+yfbODAu6dKYx7Xv24ltugBHujJzrhqrR5yBOrXhNKw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8423.apcprd06.prod.outlook.com (2603:1096:4:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:41 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:41 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 13/17] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Topic: [PATCH v2 13/17] hw/usb/hcd-ehci: Add descriptor address offset
 property
Thread-Index: AQHcy+TJtjUIeRfiJESO6xYxyFKb6Q==
Date: Tue, 14 Apr 2026 08:00:41 +0000
Message-ID: <20260414080025.3005916-14-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI4PR06MB8423:EE_
x-ms-office365-filtering-correlation-id: 0ab9300f-6ec1-4401-e207-08de99fbec74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: +T9sSVtAxbToV3fnRvolDbKJE3XOj8Q+TKW4Lpxeks3GLeHNAIFL2SKNiTc9mAQID1bRs9jO/gTSBqdx8Q2gAU/Ch4iiu4awKqq4Ph0BFfDjjZM/fA1RIna3X538dLU3YbDuLwgmft5gGqkkYZapxGDTQ91t3a/P4y2xExaof9CmqhOZRwHo944f4b+CIlGGgOPTdx+3/9J5G7o00OAuD5NWtfHgXtqkxsIiItAeGbmCjznWYEkUEVjqrxHZyP30Ss5XpgAqEvms8oYcJddh/t/4pUjRFtAucm9SoSQQWx1PJOsk+n3i2RTZo+7vHtyGYoBTl6L9ub0QbK1Pd8tl71+Xi1mrg3WGjUThYvRb9e4zNKAd6w6NmH+roExLY1F9Wa3Ma3YrUUN8/auK0SHh00HsM1q2VpWMwxKNf+1XKJbfSy9xpXy+KiJj+2k3Md2mXmstBgSXphzHejVUKvwP4GGbz2/CHLMbFTT2sDTQ/veCF5mGYUEyyrSZ6Swa+FFHzHO/TmwPOIzfjlG4i7PgsQARTCjdlvjvH+IFOsYh07BVUJH1yb5xXuMZ2/Jgm9iDIFt1GEjkbBKKADZiowBpIyfQc39UmxYcaaSRT9vkScuDG6AYEy68hVb7+FNoL8Vzqbe39gPwzWsacQ4C1M490JhQKCWaXEXOgYI1S5wjMUOrmTt0JiN4+gQXIgHsYpcOGi9t0hofeeOfRjYoWnldI3SZV+LQ0+4QLMqfpL1WgwN/2INEfjvAKpgrc1aOrgZ+qbVDU46GInT3/q5Png2Kp2iMhHMDquGobhs9emFPxHY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oVDc1rMQuR9ndLAycj/irdwAyksAB9CUB9cN7EGDwQOcDUjoPRr4Jfwk+z?=
 =?iso-8859-1?Q?p4mYOEfLKat375G24IhDaAUn1xFlMWcSIynBsafQLHOKm0UjMm626fHHH3?=
 =?iso-8859-1?Q?In3+LJhiX/SNNVh2rYgbcZQtPcvJfXbApU3NGixJn+wQj7nBxudMZpuQOB?=
 =?iso-8859-1?Q?PM1om0jdpKhUgDBY0oPW3Qb0iDqRSakHXrMXysc4UhsCirhjQYHHq1D3y5?=
 =?iso-8859-1?Q?4EZ7GRksb86yhUBjIq4vaqSrelh2ieLnNhwOlZRBqZdlQwgbwfouSHFNzt?=
 =?iso-8859-1?Q?2ZKP6mJu2D+Kavmw2IJq8sBK6lBaYBoWpgGw7P0/K3iWpQvQhNaFX0zwxf?=
 =?iso-8859-1?Q?wJgUUUks64zAl6SzzyjKS9O05nPgt4FhnFrnCZKxAxuDaLCBLC+fZBPtEQ?=
 =?iso-8859-1?Q?DgDEeNJZzLtcf4HGSNvzTW46fSsmbqu4CyiSdzdKN+gqJ9gPrrETEEe16D?=
 =?iso-8859-1?Q?fUrf00obBr4Vc+XpzZiPVpMFjtuHOiHTGlEufsbmD6mru+/oEOvSwpcw8V?=
 =?iso-8859-1?Q?BaytNh9BKZ1UYJudkLw9l5MxdeT9g2EcYcfEI+vfg2ioYs5amkCwwReCk7?=
 =?iso-8859-1?Q?JDRIeV33dSjQ2JYbFB07DZEg0pghqnQyu2Bti4yX4JCX0MLzMRvIfiE1Uj?=
 =?iso-8859-1?Q?6y7bt2buK/JldvQYidoftrA66FRC2o8d+O98UXtT1H3FBFWecr7KauFlbj?=
 =?iso-8859-1?Q?hI8MOOQM67+eiyY0bzUxXyYozD69Xulv/fvzvUThAFllEStm2YqQjIekr1?=
 =?iso-8859-1?Q?iypJI0bIUKiDxZGF1jmjrVnTY1TTiUx+mSQdO1tf4l1c09nHgPTjCjencb?=
 =?iso-8859-1?Q?R5BxXxB3n40H5LsYs7/nQ9O6jmGdrl6qODNYA0gKU5r3cQNAVZbCsqsZes?=
 =?iso-8859-1?Q?2QtJr+EPYaNE20H997dOtUKqQo+2kjlXUmRCAGO5WKQtJiel8nDFYI90vZ?=
 =?iso-8859-1?Q?qmh5CTEqCFb7LXIzodUZnYgclfjWinQJ7i5+8MAnSgo/tqx01AL5tMZfKB?=
 =?iso-8859-1?Q?W9qFmIsE3OH2hbEHcjqj8cCEKWJo9PKY71VpA8U7mZd7P0hG2h475YYcoh?=
 =?iso-8859-1?Q?fe6uWGbEqXyRtvbnTyoeO0H/k1fMO6I2GmPhX9SUShU+wswkhdW9Nx22Uq?=
 =?iso-8859-1?Q?Sd4pls1Uy70A1vEDj5ZRX5OrfkkB57x9vLvgdFamGdqkGYGzFHOpnbAXis?=
 =?iso-8859-1?Q?jBiMnrn7yEtY9b0CRKolkqHC31TeOkONxzPqSUruBMZkITqQfR3mKGnydX?=
 =?iso-8859-1?Q?hj600pRY0RUa7JTUbhoJzIcvE0IhLfuxUJEPi8GtTPJ/lvlKgIWdC9xtQV?=
 =?iso-8859-1?Q?eLS5O0htEwhqNB2q+YOIbNgiyxFCyVq3JvYGI7j6d+tSyAwopbiTVuQ64t?=
 =?iso-8859-1?Q?M4mLOopB8x6/BTqU+dF2JJK2aabV+pFVFK66muafCafKwsTP8tcL91CHxI?=
 =?iso-8859-1?Q?SSHEbnY9OE3HBfxnW+HIL1G1Ho8Sis4t0QZhfJsZzuk1RFpPg10iEh9ktm?=
 =?iso-8859-1?Q?bOwOLJqNC4VeiZ21njLOiOf2jzpS0Z1IEcSnDq/gE3GRQu+gi/vRUlGeBY?=
 =?iso-8859-1?Q?gjqPx3BoeT5+tonxyjB5CWrw1h9g6SbnfGOifiFcW1vc8gYD5M0svwsTcG?=
 =?iso-8859-1?Q?ng8Byeh0+190XA+PRcjxhiKQVYE1KuQk373ywjsv/lSNs4ngyVA1iVf2qF?=
 =?iso-8859-1?Q?fhghxlF7ICNo904gpx0r41kpcAdnP0WiWmIA2QpS4B40Ud8AMmbn1JXQLH?=
 =?iso-8859-1?Q?rDYivZA1/8RJ+Js+t8fsm1zTXT/BZGAVeps64nuhGJ8k4vn+sGnzfOeIuh?=
 =?iso-8859-1?Q?HMT1pasz1Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T4USLp/VZVc0qcfwvzbmMcIXvqrTquyTEIWCx9lSJ+hsS06si5gn6IS8OJOlVdOWmX/LW/8woVdeiyBgiwgFQeRRkpBtjuBnB/MzDBNK/VSlTIW8QfkI/xc/c9EqaGJaZYJiasuc6Fvq9VLd7JOwCOKRLA6AL9vOa4WhRNYDVcYv+rvQD1m7zCqreMO1NUwdalVMTaTARQkdnM3S+HlolCVgegeHnTHilV/O6g2VvL4YqTnLIHK7xxFLYbmgwMaNh6CYf8mwXEe64hU8kVMJ1BxR6ODx/zVYKjpN5b34Je8IQQ64vdl4KKoS4Pq737IZSPnM/+Tt2otn6qFprLBBoA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab9300f-6ec1-4401-e207-08de99fbec74
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:41.5893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49fKZQqsB9Yaq/nOkuyEOy61LXqH7LGt4UdlAlOApv6i7Ry4ZywHiMG4w5oY149sLC9if73TMzVCJ1rV2hPV+5jI2UJmnEZWtdmYbybriV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8423
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

When 64-bit addressing is supported, the Linux EHCI driver programs the=0A=
segment register to zero. See ehci_run function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
=0A=
=0A=
The driver comment also notes that descriptor structures allocated from=0A=
the DMA pool use segment zero semantics.=0A=
=0A=
Descriptor memory is allocated using the DMA API. The platform driver=0A=
configures a 64-bit DMA mask so memory can be allocated above 4GB.=0A=
See ehci_platform_probe function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platfor=
m.c=0A=
=0A=
On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.=0A=
As a result, descriptor addresses constructed directly from the guest=0A=
EHCI registers do not match the actual system address used by the=0A=
controller when fetching queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
Introduce a descriptor-addr-offset property so platforms can provide an=0A=
address offset applied when constructing descriptor addresses. This=0A=
allows systems where DRAM resides above 4GB to correctly access EHCI=0A=
descriptors while keeping the default behavior unchanged for existing=0A=
machines.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h        | 1 +=0A=
 hw/usb/hcd-ehci-pci.c    | 2 ++=0A=
 hw/usb/hcd-ehci-sysbus.c | 2 ++=0A=
 hw/usb/hcd-ehci.c        | 7 ++++++-=0A=
 4 files changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 6406f536e8..05d8db4a5d 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -264,6 +264,7 @@ struct EHCIState {=0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
     bool caps_64bit_addr;=0A=
+    uint64_t descriptor_addr_offset;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c=0A=
index 2ea8549db9..115d05ede0 100644=0A=
--- a/hw/usb/hcd-ehci-pci.c=0A=
+++ b/hw/usb/hcd-ehci-pci.c=0A=
@@ -139,6 +139,8 @@ static const Property ehci_pci_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("maxframes", EHCIPCIState, ehci.maxframes, 128),=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", EHCIPCIState, ehci.caps_64bit_addr=
,=0A=
                      false),=0A=
+    DEFINE_PROP_UINT64("descriptor-addr-offset", EHCIPCIState,=0A=
+                       ehci.descriptor_addr_offset, 0),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ehci_pci =3D {=0A=
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c=0A=
index 61215e9f3d..df138fb339 100644=0A=
--- a/hw/usb/hcd-ehci-sysbus.c=0A=
+++ b/hw/usb/hcd-ehci-sysbus.c=0A=
@@ -36,6 +36,8 @@ static const Property ehci_sysbus_properties[] =3D {=0A=
                      false),=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", EHCISysBusState, ehci.caps_64bit_a=
ddr,=0A=
                      false),=0A=
+    DEFINE_PROP_UINT64("descriptor-addr-offset", EHCISysBusState,=0A=
+                       ehci.descriptor_addr_offset, 0),=0A=
 };=0A=
 =0A=
 static void usb_ehci_sysbus_realize(DeviceState *dev, Error **errp)=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 24133af9db..0af9e47fc1 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -162,7 +162,12 @@ static uint64_t ehci_get_buf_addr(EHCIState *s, uint32=
_t hi, uint32_t low,=0A=
 =0A=
 static uint64_t ehci_get_desc_addr(EHCIState *s, uint32_t low)=0A=
 {=0A=
-    return ehci_get_buf_addr(s, s->ctrldssegment, low, UINT32_MAX);=0A=
+    uint64_t addr;=0A=
+=0A=
+    addr =3D ehci_get_buf_addr(s, s->ctrldssegment, low, UINT32_MAX);=0A=
+    addr +=3D s->descriptor_addr_offset;=0A=
+=0A=
+    return addr;=0A=
 }=0A=
 =0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
-- =0A=
2.43.0=0A=


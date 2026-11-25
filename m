Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9D606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=T79jaETT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW3R3-0004q4-S5; Tue, 24 Nov 2026 22:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xW3R2-0004pd-0G; Tue, 24 Nov 2026 22:12:40 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xW3Qz-0006xk-Nq; Tue, 24 Nov 2026 22:12:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCrP03q3eb6rScAdXMlLmhKiErcLgANlONNF5CupTcGQ7NkfEqkZNMTw452fmT6cXKMa6kJavvBEWw7mktvRbD+4lP0ne+dy2qlAGPYK+e8mF/3oREuBgnMv8LH7UMZ9loI0oZNsjzGgZXA/75pArkPfVze5tWlwdktdU7VfnOgk5IBQshxChyH1ka8jJ6txmYejH1hTVIP/MDxe7AgUDE1W+/UP2/0WixrRoDxslP7QGXKBZcf3gYObFIqmfnd8sE8jZXc7EmgwbvAPIdSfYqm1m2ZWUFUEVq7drcJK7pZawxf/Hn0uWiz93Kud0LyRUXtsI6xNSrNSTm1AytWw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUqyvYCnam58GE2bzByFlPdGGEsWViRVrQCmeH9gpUM=;
 b=GaElA4dLlM6woG6gzqH+PiCZ6jnuXotl7Cg7LPcet73d3FQnxSqpivE5/EjnRTH9uPhSEmA/H4D63FOq8h+T8ho6NsxU7KQL7R1Z+EOBd6qsJueR05rpOT97ATnT3NWLD7NiMVcsyJZLTlgz32q1ZauX0tREyahamFRBrxUmXxTSbG2oN+5RRvhyGcdbZCqtkMXvdl3YPrUPRYk+FVnqYpJsy5KfrZBOSyXZ+NvUAbG3uzUw1PtJMQhDwnfmU1/D6TqvE1mQWQ/pJIa/bRM4M3e8suXJ1vuUwKTcnHsD0o7IDvbJHN4gG62ER3vs8PySLPthw3N+D0PuoDDJVuqkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUqyvYCnam58GE2bzByFlPdGGEsWViRVrQCmeH9gpUM=;
 b=T79jaETTnIKMDXAMyKwkSXJw/RSOYtW23LO70JhoZU+mJcqw1uEM4SJxqB4D5i34sTMKYLbCG6zaTq4IiQlnabCXrvQS+MGwNcbp+goLA3fWbRRjgUGofLTKs3l1O6nym0Xhsf14Z3HeMaWTRQrecqqQ7lDOyhq4N2EzQFX+hvxnxQ5T1bng4OtyUmKsrzO1EY7F4i4fWe1+KO+GrnAxm13/YroJTz0a6tF4ec3EIpoDhIeWbAa6Dvz2nKE+Q1Ach46FtyRizNRuCkTb09suy6tIcucCbCfFDesk/FPloMGsAwuDdTCqKWSa4PHMT1vBBio9d/9GLnZV2m22rNuLHg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6780.apcprd06.prod.outlook.com with HTTP via P2P;
 Wed, 25 Nov 2026 03:12:29 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 03:12:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/3] hw/usb/hcd-ehci-pci: Use DEFINE_TYPES
Thread-Topic: [PATCH v1 2/3] hw/usb/hcd-ehci-pci: Use DEFINE_TYPES
Thread-Index: AQHdfIrNsonBKgVKHk2bsGz/QUVTDQ==
Date: Wed, 25 Nov 2026 03:12:28 +0000
Message-ID: <20261125031225.3810653-3-jamin_lin@aspeedtech.com>
References: <20261125031225.3810653-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261125031225.3810653-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6780:EE_
x-ms-publictraffictype: Email
client-request-id: a50162a5-0d9c-4eea-bdf6-944d717437cd
request-id: cf02a250-da3d-4ce1-852e-08df4aa1f07d
x-ms-office365-filtering-correlation-id: cf02a250-da3d-4ce1-852e-08df4aa1f07d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|10067099003|56012099006|261021121427099003|261102123227099003|261026121527099003|261021123027099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: hVpxNoC+f28G66VLcVW6LHwc9Uj/OH3lboQ/XSq9fs1y/9OlfBSiRMmZI5Wtfc9ymPyxJt1GZnRaj9fyd6Cb1ROZb5XWL3YoYEMFyp2JjUbfgXD5LcyJ5/HfTJLvIPzQXpS8kk5yg0LmTAvYyh1DANUe/G86PApCEgHTVfNhmBONzC6uFjrJyM+imE04GZkThHJkPXZGqap3ApFpNeiZdZCxvm7Jj7Wsg7dJrWrJrjVrl398c0B9EpWJigsnLc6XQ5dZnies/Hl+j1dN4EokytYfUdm3sQV0ZooTCMhRCIEqC3iFQBCNztRFIstija0TrTFrbIGxYwZc1DrXmClV1mZbRG/4+GbLX3VT9aAJvEGQPrkxostSay5vAHoOTbXcoJyM+dz3/opifvAfncKIZDiLvu8vHPZUecbe8ypv6sFFmB3H8UURelok9JzK18ZkEoYfWiDkmgw5MZj70TPoygv8S7H7KAWLouPcbGR7PQYWndGObID34Qi2rAbzKySy2Z6FJzI3Z5Tlz+prlyVjQEypPvCjw1a37uWebN7jzbI9u9zDAUsIesgtIDiQKqLaNVQ0cNVvQnNVp/ih6n9/gZYDvD4kj0wEqgtJldflmjYob5jNHBK+3FKxFlvu7F2EZQId7a7mPkvQAOfgV1UHZ4oHodl42BmIoeJyJs5LIa6vwqYfRlV9hodDzQz97ZZc70aO8nRzztT6oc1K0qXnHFX3bLfutHth7eMuQxDyzfk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(10067099003)(56012099006)(261021121427099003)(261102123227099003)(261026121527099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mPJSAEKAH9UjLaDj19Ty0WwIl+UsyC6T8ZAB8sNdPweu04Frc53sP5SJp9?=
 =?iso-8859-1?Q?bJ2AqYJ4wAB3wNnGwSKL4E0ep8FvKZSy1ZxPKhyizdobD0q4hUxkCwu95/?=
 =?iso-8859-1?Q?XaRdhzWUiLViRt8R+d4zwq1VHAmP6ABrJ8SBuWzz6PCfw3sO3PrtLiPI7g?=
 =?iso-8859-1?Q?p/0fD5w3pqW3kU2KTonn0nRHiClQBL4w/r31jo98M7/76yCooRW4XfvQeX?=
 =?iso-8859-1?Q?/uJJTkDhG24YSCLRTWQXdAt2/54bTxLOtUwngC851yEKy4A0VJzSpe94Gg?=
 =?iso-8859-1?Q?sldSlY+lKXSHNsfAL6Zi5W4V4EQ6jWpYTbD/uvd3WR4M7ysPZ3jTzWIhoV?=
 =?iso-8859-1?Q?VJizwx5p9wLzE7ioCA3by1VL0CeW3ql1KtmkFC/P/JrRycja0gEo5e7JN8?=
 =?iso-8859-1?Q?1YmzkxI1GTyyuIu2DbadJ/Wf8AJwRWTrUtBSiXGwadjSdIi0FMJijSl1gj?=
 =?iso-8859-1?Q?HnH3IajRb1AVS32yqw4b+JwS/vqFfwYJECMeOJb7l6J/62XKlSDFj9UzVm?=
 =?iso-8859-1?Q?Z3lutQ4XHzjC9+YZSXKpovJPI0WA6sz/qA0wzSY9PKb1luCXG3gxHFjs/X?=
 =?iso-8859-1?Q?CAMUVysDPlEEeJutdvupQlMbzazHWQiHMhsyHHXvJM7ELu2GIwvcU9NHyJ?=
 =?iso-8859-1?Q?34+eKY8ZgNbpA6KsKkeY3R+JjFG/lTnwLOiL55552NOLpnYzJuHgw5WH78?=
 =?iso-8859-1?Q?jPCTOhb4waWaUgFPcFxICaKXrcHxhhgx7L5CfbwjL6zjHuceXkLEQQzRCl?=
 =?iso-8859-1?Q?gQXPTI9WhHAm/EvxWveKPInzxrqyOBujrpACiqqCW+oIy1daB8MMWxhGCR?=
 =?iso-8859-1?Q?qBiLP9qWhXFYtNM1qAROYxnlQ1WZN7Fhc80gRy481CEHYasmoMldAXxcp0?=
 =?iso-8859-1?Q?rDMMsImKapnjXQgp81RziE0ZHQ9glVTk2OGU80vzn8BpABx4xFPnofdTYf?=
 =?iso-8859-1?Q?wVbgdlLNpYWlbiaPHgHLYZjoe1Vnxf8sQylEWeK3S/GZDzGKvtl6XJ4H2d?=
 =?iso-8859-1?Q?iQ1X3qIsMmMSvO945WusCcP6mwibNy67gWepHaO1Q2mv0NNfoZz4GBV/bf?=
 =?iso-8859-1?Q?e6ixlZkHIdaEHUrx9f30EWaWTUCGhg7SN7HaFPwEo7H0uHceuRDRqNcD2O?=
 =?iso-8859-1?Q?yWgey2PMDbDGCUPQ76qvBZ9NgzJO3Unn4WxWbVOfJdnFZUUN3SW0vsKZnm?=
 =?iso-8859-1?Q?/2B3FhZimA17xlC6QCLDCRxK7ZCC4EUkay39GyjZ8L5WJj62WkLOwsgasR?=
 =?iso-8859-1?Q?9x143ET8+5VQfKD974X4e8rGNlPJUSEaeRpGtPan416NK1DrFURZN+tD3Y?=
 =?iso-8859-1?Q?swvyInS2HjImq5oqOYXvbI84S8o+TYUDdoxsJc/LvuPcMaiQYdqwQ9K8yO?=
 =?iso-8859-1?Q?PizmoQ3OLgERoFIElEVAHYHKOP5Tg1q2ajZ0a8Wjl9vKLaFYwCz/+/5p3m?=
 =?iso-8859-1?Q?vyI8UfDdktiNENc9tIQiMGTWgtXQ3gPpNwQ1+89r4XChFqi+VgapnXXzCq?=
 =?iso-8859-1?Q?yHpfr8ppfDAb5Y9M7BXpqewEUMlTygmLfpQtC92z9JTAWC/zO9oeeeA3lA?=
 =?iso-8859-1?Q?Rr73MLcA7uloOmfo6UBtsk1ueNZchWbmU+EP1u/MHGUKya6aoPu1hyk3Ic?=
 =?iso-8859-1?Q?KC3O9+F3H8OFyUdJ63GMXXOwBx5J6jX3sOXw4d5GHYLwWNjOAPByg4hEys?=
 =?iso-8859-1?Q?Z1cMu7io+sNfUkbUcpEZXXjgpqDNs2AtFqSAsLEX6FinL5jaxSHQo45tz7?=
 =?iso-8859-1?Q?qpO5DGnh/9SkJuANrUO+ifRTAXapoBtGDOmZQohTg9ikIZyeoMHQen6C5P?=
 =?iso-8859-1?Q?wNp6sWBc1g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf02a250-da3d-4ce1-852e-08df4aa1f07d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:12:28.9551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNVF8FQnBXvHTwssh9jFRAsd/AlUFmVkgnWEvJ1MKZWj25pSSvaHOIplziOOe0zljV251grfRvbum8ZqEi3dM8DsMYTFO3GZTDa1Om/D/30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6780
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

Register the EHCI PCI types with one TypeInfo array and DEFINE_TYPES().=0A=
This is the current QEMU style for registering types.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci-pci.c | 99 ++++++++++++++++++++++---------------------=0A=
 1 file changed, 50 insertions(+), 49 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c=0A=
index fd35d25340..c35529eece 100644=0A=
--- a/hw/usb/hcd-ehci-pci.c=0A=
+++ b/hw/usb/hcd-ehci-pci.c=0A=
@@ -23,7 +23,6 @@=0A=
 #include "qemu/range.h"=0A=
 =0A=
 typedef struct EHCIPCIInfo {=0A=
-    const char *name;=0A=
     uint16_t vendor_id;=0A=
     uint16_t device_id;=0A=
     uint8_t  revision;=0A=
@@ -164,20 +163,6 @@ static void ehci_class_init(ObjectClass *klass, const =
void *data)=0A=
     device_class_set_legacy_reset(dc, usb_ehci_pci_reset);=0A=
 }=0A=
 =0A=
-static const TypeInfo ehci_pci_type_info =3D {=0A=
-    .name =3D TYPE_PCI_EHCI,=0A=
-    .parent =3D TYPE_PCI_DEVICE,=0A=
-    .instance_size =3D sizeof(EHCIPCIState),=0A=
-    .instance_init =3D usb_ehci_pci_init,=0A=
-    .instance_finalize =3D usb_ehci_pci_finalize,=0A=
-    .abstract =3D true,=0A=
-    .class_init =3D ehci_class_init,=0A=
-    .interfaces =3D (const InterfaceInfo[]) {=0A=
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },=0A=
-        { },=0A=
-    },=0A=
-};=0A=
-=0A=
 static void ehci_data_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);=0A=
@@ -193,42 +178,58 @@ static void ehci_data_class_init(ObjectClass *klass, =
const void *data)=0A=
     }=0A=
 }=0A=
 =0A=
-static struct EHCIPCIInfo ehci_pci_info[] =3D {=0A=
-    {=0A=
-        .name      =3D "usb-ehci",=0A=
-        .vendor_id =3D PCI_VENDOR_ID_INTEL,=0A=
-        .device_id =3D PCI_DEVICE_ID_INTEL_82801D, /* ich4 */=0A=
-        .revision  =3D 0x10,=0A=
-    },{=0A=
-        .name      =3D "ich9-usb-ehci1", /* 00:1d.7 */=0A=
-        .vendor_id =3D PCI_VENDOR_ID_INTEL,=0A=
-        .device_id =3D PCI_DEVICE_ID_INTEL_82801I_EHCI1,=0A=
-        .revision  =3D 0x03,=0A=
-        .companion =3D true,=0A=
-    },{=0A=
-        .name      =3D "ich9-usb-ehci2", /* 00:1a.7 */=0A=
-        .vendor_id =3D PCI_VENDOR_ID_INTEL,=0A=
-        .device_id =3D PCI_DEVICE_ID_INTEL_82801I_EHCI2,=0A=
-        .revision  =3D 0x03,=0A=
-        .companion =3D true,=0A=
-    }=0A=
+static const EHCIPCIInfo usb_ehci_info =3D {=0A=
+    .vendor_id =3D PCI_VENDOR_ID_INTEL,=0A=
+    .device_id =3D PCI_DEVICE_ID_INTEL_82801D, /* ich4 */=0A=
+    .revision  =3D 0x10,=0A=
 };=0A=
 =0A=
-static void ehci_pci_register_types(void)=0A=
-{=0A=
-    TypeInfo ehci_type_info =3D {=0A=
-        .parent        =3D TYPE_PCI_EHCI,=0A=
-        .class_init    =3D ehci_data_class_init,=0A=
-    };=0A=
-    int i;=0A=
+static const EHCIPCIInfo ich9_usb_ehci1_info =3D {=0A=
+    .vendor_id =3D PCI_VENDOR_ID_INTEL,=0A=
+    .device_id =3D PCI_DEVICE_ID_INTEL_82801I_EHCI1,=0A=
+    .revision  =3D 0x03,=0A=
+    .companion =3D true,=0A=
+};=0A=
 =0A=
-    type_register_static(&ehci_pci_type_info);=0A=
+static const EHCIPCIInfo ich9_usb_ehci2_info =3D {=0A=
+    .vendor_id =3D PCI_VENDOR_ID_INTEL,=0A=
+    .device_id =3D PCI_DEVICE_ID_INTEL_82801I_EHCI2,=0A=
+    .revision  =3D 0x03,=0A=
+    .companion =3D true,=0A=
+};=0A=
 =0A=
-    for (i =3D 0; i < ARRAY_SIZE(ehci_pci_info); i++) {=0A=
-        ehci_type_info.name =3D ehci_pci_info[i].name;=0A=
-        ehci_type_info.class_data =3D ehci_pci_info + i;=0A=
-        type_register_static(&ehci_type_info);=0A=
-    }=0A=
-}=0A=
+static const TypeInfo ehci_pci_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_PCI_EHCI,=0A=
+        .parent        =3D TYPE_PCI_DEVICE,=0A=
+        .instance_size =3D sizeof(EHCIPCIState),=0A=
+        .instance_init =3D usb_ehci_pci_init,=0A=
+        .instance_finalize =3D usb_ehci_pci_finalize,=0A=
+        .abstract      =3D true,=0A=
+        .class_init    =3D ehci_class_init,=0A=
+        .interfaces    =3D (const InterfaceInfo[]) {=0A=
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },=0A=
+            { },=0A=
+        },=0A=
+    },=0A=
+    {=0A=
+        .name          =3D "usb-ehci",=0A=
+        .parent        =3D TYPE_PCI_EHCI,=0A=
+        .class_init    =3D ehci_data_class_init,=0A=
+        .class_data    =3D &usb_ehci_info,=0A=
+    },=0A=
+    {=0A=
+        .name          =3D "ich9-usb-ehci1", /* 00:1d.7 */=0A=
+        .parent        =3D TYPE_PCI_EHCI,=0A=
+        .class_init    =3D ehci_data_class_init,=0A=
+        .class_data    =3D &ich9_usb_ehci1_info,=0A=
+    },=0A=
+    {=0A=
+        .name          =3D "ich9-usb-ehci2", /* 00:1a.7 */=0A=
+        .parent        =3D TYPE_PCI_EHCI,=0A=
+        .class_init    =3D ehci_data_class_init,=0A=
+        .class_data    =3D &ich9_usb_ehci2_info,=0A=
+    },=0A=
+};=0A=
 =0A=
-type_init(ehci_pci_register_types)=0A=
+DEFINE_TYPES(ehci_pci_types)=0A=
-- =0A=
2.53.0=0A=


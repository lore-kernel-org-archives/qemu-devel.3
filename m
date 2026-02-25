Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D227DF357DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC17-0004Ij-EZ; Wed, 25 Feb 2026 05:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0h-00043j-KR; Wed, 25 Feb 2026 05:20:51 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0e-0002v7-BL; Wed, 25 Feb 2026 05:20:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I81+U2OtfMS7PVMWuzjhbPRMrrVrz3PHr0QsDq9wjr8O+mPZIlRB4ITCkxkHlZ+//24rhTsLuN0sg/Us/xWc3iA1f/jazT6MQU9EAQyLmwu7sJ453gdQ/zV+DYvj3cj9H1i05zMYbq6HMTU1Lfs8/DQsFtOZ6PqpXFFBpkw8tQ8hw44KDywlrOqRYbbvM3GuVBJFCGUuckCdQb+dq+Gmq5JgwyBkQvP0wItHIaS+9ezYWcPLH17oORmiLe46mQoQWG3nHztI2DBDHxMIdQ8BTXJ+PJqjd9F4oXQUA+Vp5vwyd9pkNA8dcsOW6rVaXA3EUh1BGk83pWz7lhKMTooOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw30E9Q/F230bpadcDbbSmbHRVXr0qE+5TtCegIauk0=;
 b=aw6/vXggMj44NG13AXzFkci50Fi8zUrLPhqSXM4u6Akvrtf3PDjvdPh8w/Wcg6gd3iEB3hF4J7C16Xi59f7lB/ksIxY0biLEOZDb1jV1B3H8z0yLNsG5T6MK+UuZ5+mqEHXHsFBYLqnj+UJOz+IkahyKSaKKZGMwPLK0xmNe8VXjJ2ccnpjE2GDCN7OYYA8msNTBIzN/4aL2O21oO7tUrMY8/GXkktnfDARopr2jObHuYt1m0zFHd01gVLNy6Bm9sllwGCMwnR2ewJwT5ax1OqmcU1LSkgyu1mBUW8OAliD/5eKkdu3D81UzwMgIrXM0hNUBw4F0T4JcpnxdnhXMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nw30E9Q/F230bpadcDbbSmbHRVXr0qE+5TtCegIauk0=;
 b=RQ7oRXvJUvSAmDyNJz3/Usb3Nitg08C9qpFGy1oiCv5x7rARqEKo6rf8L/Ml1w7CbGByn6x9na8GnF8BuXWIP1jWANr3JiP9+8we9rNM/XlYLA8Zh73sp0lZX1qEmXKzxL01LnScHTNYfAJ94AQ7rL65TLQHNPxkLvMupMosWsA8W/ZWdyV9Zphpi4LqaOQcggxTRxrVknmWcWAZpIfMjjPeNlGIOF87Mi4FfM3+eKlJxgTfXk1PU5LIC52hI8MithvfGtb6KFPTuLZCSSsZZgYByuv8xzIZEYEV1t+1/rJFZ+TkSFqw4ysE3EvShjX7H8DIB1k8ovBaPoLPLz8ALQ==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA1PR09MB7406.eurprd09.prod.outlook.com (2603:10a6:102:466::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:29 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:29 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 07/16] hw/riscv: Check endianness for fw_dynamic fields
Thread-Topic: [PATCH v2 07/16] hw/riscv: Check endianness for fw_dynamic fields
Thread-Index: AQHcpkBczKoEJQ7DMU+0E21ygRJVpQ==
Date: Wed, 25 Feb 2026 10:20:27 +0000
Message-ID: <20260225102016.200654-8-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA1PR09MB7406:EE_
x-ms-office365-filtering-correlation-id: a374ffc6-0910-4587-2296-08de7457805d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: eXfCRo0BVWT8PlyahaKpHFNDAP6zn/+W5luTNHA9mp5Z0zgsvJr2YU+EKFZ+gVopuve7oXDZNdtJLdPRa2WlrgTKIR4XZKYnN5ob/EIwqCzrj+39G5cYvkunf1uI7XNH8q7VJenN79nCmUJCYoXwws6eiooEPhdPzMZPG0++bTZ7zB20X0VJYeq03a/rLlD5O41Bt/ekoscGhkzLgXk3LHQxpEua2jYD+2U7CldKkjKM0wztGtJQbmtKM7xL8n56tJoklY7+i/beasslAVrSFNdDIt0uaztDYiGTkRUxNboo3GrbCBUEPynqp1SHw/qP8SnL1UYOjRtwUtsk1qZWHxTKIWPoueFiEuxhphZDjXWtbiYKPI6xHjIZ0oVkvopiFaaLp5h/vYAOyI0/TRWL4gIgxvaEhCUnXnkrVI2Y2s77EpGOnCIGXS2kyclxCQ9Mc77ykuiJAvnZrCEmxlVzrYLybxfjOVqJm/SVGXNmOEomY1m7rKPcEgMTbjSKtlA6UP/2Oux67l9opECjvPHVto4QmpcOUnOZdHhxnRLcOXbH0Lb/crNhr/w4XZldyUnEs4hoc8o//z4+NPNLvs+FEVIeVexEUiAIYhT88KaQbfDvHSVdDti2CAwxtmRgqGDlhUMi+f+uWuVi05MuSPlbqIJIrz3ewO91HTsp5Grl/xbGFGPON/UZ16pvq7H/t3I1+SHhxixBbZIdhFTopFzM73IlsOlWNuhyYW+zXiAKFmpX1Jz0WL/FpaaGwZ7FTDiCxrgFJxsJJIVA5fTZK7agFKs5vdggS3b5M7RzeGBsVSs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yMLV8fKCrrzmTCokZA/CDtg8kserFLWCjT++Bn+nh1xaKGSAIXvUbARdGd?=
 =?iso-8859-1?Q?Rxce0pCYQL29rGPuKQsvDgHSSABwzHpze3moxjWwNl0RzjKNshnZAObTIz?=
 =?iso-8859-1?Q?KdUen1RpywoSHz4B3fnNSiE3ZMz49J8N0FI5uqRJicdjS9zRBgD5PY5tCS?=
 =?iso-8859-1?Q?25a4kwDPQf3rURdF7RRtIDJ8jjee8LSXvXpzfe1MSjI9HMmzg7Y+FkzeWe?=
 =?iso-8859-1?Q?0hq/rWXvzxIdC3VZjWKWkooGakzbp4So2nIzInU4VboGK2rpiR+TPneuuT?=
 =?iso-8859-1?Q?3Oo5z1O6veTzFISqv869VlmrO8pNTyVg9tl/wqV3CcLoff3SLiSwtejy8y?=
 =?iso-8859-1?Q?AY5yt0hi55IvkP/mc7ykHxypUn63iRFtxJCD4k5aCNUfkKd9aZlxwKZHHC?=
 =?iso-8859-1?Q?L8INrLV8LvpXYVZSPs7a/NnLYluYMSkU6+gcdoR+QAQuB5ckc9dUpNxspn?=
 =?iso-8859-1?Q?sY1U+aJm/SvTmuZwPSZd6/iDApDK0QcTp3AAlpmVz64eoppAfB6K8KsaiB?=
 =?iso-8859-1?Q?PdDiZG/jOgDv40pH7hcM4XTd5vRXHEv/k5MWt2+Mt3uhuf+nW8fVuFeK+n?=
 =?iso-8859-1?Q?vnWsTSGOU7y5z3UGofE3FTTpHPDpWH10a3hF+w8GImExigMcCWci4s2tFO?=
 =?iso-8859-1?Q?FA2DrkdtflvkOug03il84qMEM4aT7k3FDtcI4/fBx8mtzD509UFSL14uLf?=
 =?iso-8859-1?Q?/iA0N8Vi+w815fQX0SdjyxCq5aaaxnhU0y5qAHWm+hYCBJM0G770TdpW3S?=
 =?iso-8859-1?Q?NMUW16zgopN1j/3ODuZktOt0KKSi4V5kprwLoKEjh0bDJeBdc+09sDpFy4?=
 =?iso-8859-1?Q?PHuDZhhqQVWIzLphZgjzPTVCqMHfjRZ1KSisD2ImtBQH8MjVVSfzjqC4QD?=
 =?iso-8859-1?Q?m2uz1mVDsh73t/kEq64DV5mEk5D6+fQ9VBTwDqSVtMdBSu+oNyEqnvO5rb?=
 =?iso-8859-1?Q?+YrPALxbU8soL2Kj9kaQnzqmOnwLcvda/gwCwC8pzbqOLDNfgrcXODujcv?=
 =?iso-8859-1?Q?nqXYZ+ngYaPWVi0OPpfYyw6mAsKWDAgdlulLDrWlYf4Lnr6VmyzHO/iwOG?=
 =?iso-8859-1?Q?NkoCO7BvixxiusAQ1RFeAz2RdD3rcF+Cs+T+1Q5irsZ5P3dfypnNUjR/V0?=
 =?iso-8859-1?Q?mFe4wX3MAn6886i8keB3kEt0tGBJIixO1OC4ygVHsTsgEWK1duVKhmgSnm?=
 =?iso-8859-1?Q?lYljOThjBCuZrHjiG28RMK57YYgJrzZv9a2eq/wUP/xkXSIN1dJCaBD1ON?=
 =?iso-8859-1?Q?4B95xjk8sSnsj+aCSArD+F9nAgLmdGLf7oCa7m+T1RF3mTHtxGJZbCsx2G?=
 =?iso-8859-1?Q?YEMIj6KiEzcKipd31KTiiDxItxRZhn5GR3mtR2WZNe0ENlQ2mND/ew/EpK?=
 =?iso-8859-1?Q?Quw6qp7Vd2ZESwBcDkJY8PueHgVwL7aVn+Erymn+nz4km/RoTx5ud+uuMX?=
 =?iso-8859-1?Q?sqUZLEo2aGgYWr8omYTRoHOsCQ+oeA3kUHVG5jum7vaUde+S2rng6OrN6+?=
 =?iso-8859-1?Q?RS8DwguaH+HnsUf+hD0lfUUtl+1Wr+CP/kfeGEh1puao/OikJuDlZppjJv?=
 =?iso-8859-1?Q?wPMaNMVRw2E5NDi3wTgcVOInw0XQ75sWUshRnHwfoW6nO205N9bUOWc0BO?=
 =?iso-8859-1?Q?heCbdEMCTm2Ab4gQXJTMCEoX6pEpSo030w31pLqa5Vtm/RG8+1OVIembLb?=
 =?iso-8859-1?Q?0qVx9iu+9YzJP/bAwD8EsBmxyAELUnwqfbgwaMeUTDeh2mHEx5SmoKb/U/?=
 =?iso-8859-1?Q?k/sSUnWzxCq/eFgnBnZfDaJpM1fUH468JSgwBZVn9bw2+SOR3XiCmCEcC5?=
 =?iso-8859-1?Q?tO84BajW0LjR5X/i7okjvaTZ9jfXgm2kbUR3WImixTJfHVnNTuLI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a374ffc6-0910-4587-2296-08de7457805d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:27.2060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcIwM1X35eWSafXB1gJXWJ+/ABWnfhFK6iDkbPBwOqIPcq5PcpgUsirTqm7lTNaZk+l6xaid9exFWhGqjfXyetkpddV+Pk5WkyrDrkuREJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7406
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

For riscvbe target, the fields for OpenSBI's fw_payload
need to be in target endian.
---
 hw/riscv/boot.c         | 14 ++++++++++++++
 include/hw/riscv/boot.h |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 6dab521a6b..f13264a87f 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -396,19 +396,33 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
ne,
     size_t dinfo_len;
=20
     if (riscv_is_32bit(harts)) {
+#if TARGET_BIG_ENDIAN
+        dinfo32.magic =3D cpu_to_be32(FW_DYNAMIC_INFO_MAGIC_VALUE);
+        dinfo32.version =3D cpu_to_be32(FW_DYNAMIC_INFO_VERSION);
+        dinfo32.next_mode =3D cpu_to_be32(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo32.next_addr =3D cpu_to_be32(kernel_entry);
+#else
         dinfo32.magic =3D cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
         dinfo32.version =3D cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
         dinfo32.next_mode =3D cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
         dinfo32.next_addr =3D cpu_to_le32(kernel_entry);
+#endif
         dinfo32.options =3D 0;
         dinfo32.boot_hart =3D 0;
         dinfo_ptr =3D &dinfo32;
         dinfo_len =3D sizeof(dinfo32);
     } else {
+#if TARGET_BIG_ENDIAN
+        dinfo64.magic =3D cpu_to_be64(FW_DYNAMIC_INFO_MAGIC_VALUE);
+        dinfo64.version =3D cpu_to_be64(FW_DYNAMIC_INFO_VERSION);
+        dinfo64.next_mode =3D cpu_to_be64(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo64.next_addr =3D cpu_to_be64(kernel_entry);
+#else
         dinfo64.magic =3D cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
         dinfo64.version =3D cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
         dinfo64.next_mode =3D cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
         dinfo64.next_addr =3D cpu_to_le64(kernel_entry);
+#endif
         dinfo64.options =3D 0;
         dinfo64.boot_hart =3D 0;
         dinfo_ptr =3D &dinfo64;
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f00b3ca122..6a6b796eee 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -24,8 +24,13 @@
 #include "hw/core/loader.h"
 #include "hw/riscv/riscv_hart.h"
=20
+#if TARGET_BIG_ENDIAN
+#define RISCV32_BIOS_BIN    "opensbi-riscv32be-generic-fw_dynamic.bin"
+#define RISCV64_BIOS_BIN    "opensbi-riscv64be-generic-fw_dynamic.bin"
+#else
 #define RISCV32_BIOS_BIN    "opensbi-riscv32-generic-fw_dynamic.bin"
 #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
+#endif
=20
 typedef struct RISCVBootInfo {
     ssize_t kernel_size;
--=20
2.34.1


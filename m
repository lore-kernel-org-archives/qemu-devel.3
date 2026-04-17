Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BB6F436AE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkVc-0004vG-DC; Fri, 17 Apr 2026 10:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVa-0004uL-PP; Fri, 17 Apr 2026 10:49:26 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVY-0007Cr-65; Fri, 17 Apr 2026 10:49:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg/YGwb0/s+29UGUzeFy/13/fG6zr7FLQuIq9oq/P2ly+4Ch4TFKvCa8vl6TdZcs5JSaBiJep73dQ/W1bIliuQDd/VmiGw0wOI4iPJJehR5X5Y/TpK/T/mUGVc3NloOtwtptN+2JzljdJMod8fkyFUkdj7kRrjjCcI3g++qY5EfgicIkd6L0XxDLky3X0oXn/uiduPmEmPydgKrpHNPa0b0W0F8sKwuZrONfMERWMU4luDsGRWaKAzLhdrhH5VB1xRgDt83S43+iB+XPIiGxEIlEEAaaqIFg4RxBraHn7u9A1AMOykvZB8ZwhgrjTuIEkb3bVIcPVN1HoOygLrmBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY1YGwQHj8EamZNz+VldBgGRJe54OJY4CKUosYVdpa4=;
 b=iFB8lsMh3vFWdWLtff5HNymzFoFtCGANl9oa5aYz5zYotBnIxILhEoEOqKZ469ce7U+5i73zTMoL1OYmjFimtwCMpJ6Q4VLCy2a8UKlJwziAT0P+2tKqbG+5atriWTb2j9xaDtXpGKMTcj8GkE69zxZ8Brzv8a/R2ghQfiR8NhkTanz1k34IfM4fMNxpl+SOXol3cw+yBn2Ib6TzyNLmk9JI9v3LqHAjoXxMYC0F38CxXUhHB9jfsl8mOkxppNSc8oTestt/N3BjnwL8GHDwac6Xwi/SSArOtse/9/QPD8N6DuaUIynbj9dmSqTzBWHRhhynFaPyyklJU96uo8uNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY1YGwQHj8EamZNz+VldBgGRJe54OJY4CKUosYVdpa4=;
 b=lI1SbRtfyL1v1hPmbSVqT3BvLPYodgm8hLUi3cJNxmYEoUBo64jHfRlb6af4oWpWTa+tOjRqgE5V4a9OmFglTnn/B7NP2FE69Wsoh9UUI3bmwBGweLuUG6YZzHqkYHkejYh+p0eBDIsX+O8Elpg2L5nLQfWNpOT7E1FjeF72ddNdPI9jaYOg9VFi8hd//WD+m/xq/JdbcsPGydlA/oQRF5x7MCIIX0iEUfq+tXdUqASc46Lec3iySGU9qdVvFzgWAZ5x0d+ZO3LOYD1xyEW5VMlrl0aySTkNl6/9gh8+/hHVd0+/R2fFWCE+zG2Lwe7TeZUTUlu7WUPNi1xAOs00fg==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by VI0PR09MB8150.eurprd09.prod.outlook.com (2603:10a6:800:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:49:14 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:49:14 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 4/7] hw/riscv: Make boot code endianness-aware at runtime
Thread-Topic: [PATCH v8 4/7] hw/riscv: Make boot code endianness-aware at
 runtime
Thread-Index: AQHcznlb7BoIn1Hi0UiJuaG7iDgy8g==
Date: Fri, 17 Apr 2026 14:49:13 +0000
Message-ID: <20260417144905.178056-5-djordje.todorovic@htecgroup.com>
References: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|VI0PR09MB8150:EE_
x-ms-office365-filtering-correlation-id: c66a2de8-bde5-464f-809b-08de9c907e51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: w/aN+47HXwGIsY/vhEVNCjAqNCQoFQA0vNzaZ5BW+II0aEWjMVK66xzayajMFY3CCju/G6pZ4YSP1sVjMznj5wELkVi/I5l1W23QKZMYQAF+HnqZJtnRM3Bs/snUExkSfw/mRV5NL/kAx3LUS6WREY2UwuUXwc7HsRiH6SecJfF+X5qaPGCW5XGTvO43XR6porLiJMxbZfN0iPnwIPkl+eJ0bgtGwfDYZLCdBG5Yby/J9jjkzSAfjro1NjYFv9wtkacOZwbit2l1pnOjj2Ge6wNINbeFTHnKOBIsVRPaqyt1BramwgIUwIKUE/IRiANlv12I56XGNQxDagDtHFGfRPKxjIJhmQ/8pKD2z87H1rghOwq9U5ceuZdz6JJPtiYI/5O+Wo8xTEwrUZBYOG7jP/3p/gK9hCrqfKCd/QAXT6HDuLuTMgSSkF8I9oSfvkOeMc84p8xFUeM2rlhRM9fn/TI+HDYFchCG3fW2eYwO3mDHAKK/K8J+TGvqLcuChbobLh+Aq96/VjqcPOS8SmzI3q8y7xlBCgcU9KYrpR8pvXGDQP4n9enBNtWzTSdnvDz7B8bf5cjKV9b7zv8859Rgjwppa3Vbdz5xUNjtLxw8EG3YhFVLy8rL916kvAkyxsDrm/rzqiC0dmTaPpOYNg2P/qbzLF4MuEhhVVv5LSh+w7bQiUy5t5CJ6Q6bgpWGDUH/KnNbS7TnjX/bIS7csQMj4yNJDSjRqEjMLYjCrki7P6WUTy1TqhTrI1FybeBs4iikj8teBnKDwCtb+OCXbgNT+cb/5MGRU2alsWkG51AD3fY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qTKGwMoNJVKuyf5LqHPP3VZeEWUkLpXVsArsa2jDHdH4/rjpYLhnY0RMA/?=
 =?iso-8859-1?Q?hxKMU+7L3tl+2YFonII8W3ZRYtXmXVDgPTepLTSVc2cEzIBPO39yOht3rB?=
 =?iso-8859-1?Q?Fo+Kkzr78SXlflsfV5beRwawqUk555qO4c1Aerba5RzpXi9E+DbYHJPIwR?=
 =?iso-8859-1?Q?wKwogyXvF9p+2E5FXyi3Xi9swVHsjC4QlEcciaPuAWIoyCj4vB+LMR+ECS?=
 =?iso-8859-1?Q?lYF2gebLj+imnsADPLAWyGFgT8zO0CxgGJO+uiY7Ch+yxtrlQC9LRHBb0i?=
 =?iso-8859-1?Q?aoBEqNPskzdukaLq5WJ2d4BBGL/JQDfYnKH2aIf1h59cVr0wtUoetgEEKy?=
 =?iso-8859-1?Q?6D+2sVPzY/L3hhC1Wqx/8N9wXAgTDLfjD81DScyN3wWH4//wfAPA/wGp67?=
 =?iso-8859-1?Q?Czg7Gt9d+3CTh0QKv7bGDdVZ3pxK9Uh5o0fsqMRPGRyrtiiiMl4f2xI/su?=
 =?iso-8859-1?Q?VxmYOVngcvOeYXHD96c03A8y8NREyZqa4W+x+8/GSQVyxAJnXDpYyRNRY5?=
 =?iso-8859-1?Q?QAyHqc9+Ogx9h9k6p1AYASxtvZap3P0OBrVqsQHX6T3ten3bVDIyKRUdEu?=
 =?iso-8859-1?Q?tZP+cmJKaAJ5kFDGr4XJ4J8ylOvg6BimuuDHhbAdSIDLEF1QBgTsLq4lJS?=
 =?iso-8859-1?Q?gvMUw2tms57qSV72bOBULP19IiqpGj0iKnVkL1bW871urZM0z14OUt1ID5?=
 =?iso-8859-1?Q?SbkjOlf9It3j4any3P0/Fg79rUse2MP1dEa2YaLew5N0/t96NByHFDnmuY?=
 =?iso-8859-1?Q?BJHnGFArf02FMwEDXU1nnKCB4zVCnuUqCwTou6jdGcX29/frQGv+tJZIt+?=
 =?iso-8859-1?Q?3zbYcx6tifuZlccbvCWaGp19ZHhAdbhdIYwr4O4GmJrWaitSwv4cYlgSvV?=
 =?iso-8859-1?Q?dSsF3eDHWAoz9DjKLnvsptcs7SmXckv9aTGGFHS64n62xChuGJ5Znva4Eu?=
 =?iso-8859-1?Q?jLckaYy1iQMhrjWIZef2oUrGKCY3wY7Pugl9xEIhYQzcFduGMdQTzPPAdc?=
 =?iso-8859-1?Q?bLAd1bLkVr8VKNhM3yF3oOKerVm8aRX+ZOhjMFIHXzQeJqSgBCPmegg837?=
 =?iso-8859-1?Q?VizG75HlsGcrtDiqz70Qb0l8/2ByGq4YjtdbOOC5lFMAzl5JbyfrSjLeyF?=
 =?iso-8859-1?Q?cRCbbRIH1cYrIKQfVpzQEDBhT022zGPwD/n4bMbtQ2WIMcXkrBUNXqL85z?=
 =?iso-8859-1?Q?1k3DnrWE8xSBdLnDzgUNMxOy13UFBEh7NspfofuTjHMCp2umiLs6s5coAm?=
 =?iso-8859-1?Q?WlteQVz9TTB8KMxiI8suZQencqm9nX3mpAtCmp0WxLnoI0equdVqwU9WX7?=
 =?iso-8859-1?Q?uqMqoHmCbKl1uS/4rict0AhbIG5oToohPTXXIIAp24Ip/xu7fSicqLDbVH?=
 =?iso-8859-1?Q?ploj4a+jtKNwObJea77TBWKD5+I0RlsDwE91huZHz5Szlh+h2VB4tQ98Ys?=
 =?iso-8859-1?Q?BqT5kPIkZoO/J9IhKtWpzSi4FBu7EUDFDVkwdo3IBWguM4vdtjJmYvHVJ+?=
 =?iso-8859-1?Q?8Z9aBDWtXpTGbH7Jv0RjxJEUbZ2tUAOs7KAh2WUxBvWV+YXfTj2Bt+OPR5?=
 =?iso-8859-1?Q?xa+z2IYwC3CFnly/byn8HiNnb53qvNGzRFD2GO1JWZsz2y0Dxir8fKv7Nb?=
 =?iso-8859-1?Q?MWp8CKrcJep2qWsNcDfc2hqaTRakykSGe8ISBwzqnqiRba55kR7Zf/JxNI?=
 =?iso-8859-1?Q?KrnJnkEJmFpF28k2YACfRDZpDZLqYESvCfqLa5e/47l4knTasK2AQcvNDQ?=
 =?iso-8859-1?Q?J+QaxxYTpRiFBYXmEIbBX3yRBhF3jK9RKOLgf6Wpf8Si+vShGfRmx41yxQ?=
 =?iso-8859-1?Q?ztivUHxU6wFJ5Si7FNPED80a9/mPquraLLTbyHVwBTCYgV5WR9vk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66a2de8-bde5-464f-809b-08de9c907e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 14:49:13.7557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgyNbfhNA1jvD0cbGt1JFbBpYOe6H42Uz8xRZmKe4O0MIle7XcrI/Wfi5Qx1YnobLjbr9vShgWDLnpU2pPgIx7kCsX7hMBB7jRJAodRKb0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8150
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

Add riscv_is_big_endian() helper that checks the hart's big-endian CPU
property and use it throughout the boot code:

- ELF loading: pass ELFDATA2MSB or ELFDATA2LSB based on endianness
- Firmware dynamic info: use cpu_to_be* or cpu_to_le* based on endianness
- Reset vector: instructions (entries 0-5) remain always little-endian,
  data words (entries 6-9) use target data endianness. For RV64 BE, the
  hi/lo word pairs within each dword are swapped since LD reads as BE.

This is part of the runtime big-endian support series which avoids
separate BE binaries by handling endianness as a CPU property.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/riscv/boot.c         | 81 +++++++++++++++++++++++++++++++++++------
 include/hw/riscv/boot.h |  1 +
 2 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5490beda0..03fb338d2a 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -40,6 +40,28 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
     return mcc->def->misa_mxl_max =3D=3D MXL_RV32;
 }
=20
+bool riscv_is_big_endian(RISCVHartArrayState *harts)
+{
+    return harts->harts[0].cfg.big_endian;
+}
+
+/*
+ * Convert a pair of 32-bit words forming a 64-bit dword to target data
+ * endianness. For big-endian, the hi/lo word order is swapped since LD
+ * interprets bytes as BE.
+ */
+static void riscv_boot_data_dword(uint32_t *data, bool big_endian)
+{
+    if (big_endian) {
+        uint32_t tmp =3D data[0];
+        data[0] =3D cpu_to_be32(data[1]);
+        data[1] =3D cpu_to_be32(tmp);
+    } else {
+        data[0] =3D cpu_to_le32(data[0]);
+        data[1] =3D cpu_to_le32(data[1]);
+    }
+}
+
 /*
  * Return the per-socket PLIC hart topology configuration string
  * (caller must free with g_free())
@@ -247,8 +269,9 @@ void riscv_load_kernel(MachineState *machine,
      */
     kernel_size =3D load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, NU=
LL,
                                    &info->image_low_addr, &info->image_hig=
h_addr,
-                                   NULL, ELFDATA2LSB, EM_RISCV,
-                                   1, 0, NULL, true, sym_cb);
+                                   NULL,
+                                   ELFDATA2LSB,
+                                   EM_RISCV, 1, 0, NULL, true, sym_cb);
     if (kernel_size > 0) {
         info->kernel_size =3D kernel_size;
         goto out;
@@ -391,21 +414,32 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
ne,
     struct fw_dynamic_info64 dinfo64;
     void *dinfo_ptr =3D NULL;
     size_t dinfo_len;
+    bool big_endian =3D riscv_is_big_endian(harts);
=20
     if (riscv_is_32bit(harts)) {
-        dinfo32.magic =3D cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo32.version =3D cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
-        dinfo32.next_mode =3D cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo32.next_addr =3D cpu_to_le32(kernel_entry);
+        dinfo32.magic =3D big_endian ? cpu_to_be32(FW_DYNAMIC_INFO_MAGIC_V=
ALUE)
+                                   : cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VAL=
UE);
+        dinfo32.version =3D big_endian ? cpu_to_be32(FW_DYNAMIC_INFO_VERSI=
ON)
+                                     : cpu_to_le32(FW_DYNAMIC_INFO_VERSION=
);
+        dinfo32.next_mode =3D big_endian
+                          ? cpu_to_be32(FW_DYNAMIC_INFO_NEXT_MODE_S)
+                          : cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo32.next_addr =3D big_endian ? cpu_to_be32(kernel_entry)
+                                       : cpu_to_le32(kernel_entry);
         dinfo32.options =3D 0;
         dinfo32.boot_hart =3D 0;
         dinfo_ptr =3D &dinfo32;
         dinfo_len =3D sizeof(dinfo32);
     } else {
-        dinfo64.magic =3D cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo64.version =3D cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
-        dinfo64.next_mode =3D cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo64.next_addr =3D cpu_to_le64(kernel_entry);
+        dinfo64.magic =3D big_endian ? cpu_to_be64(FW_DYNAMIC_INFO_MAGIC_V=
ALUE)
+                                   : cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VAL=
UE);
+        dinfo64.version =3D big_endian ? cpu_to_be64(FW_DYNAMIC_INFO_VERSI=
ON)
+                                     : cpu_to_le64(FW_DYNAMIC_INFO_VERSION=
);
+        dinfo64.next_mode =3D big_endian
+                          ? cpu_to_be64(FW_DYNAMIC_INFO_NEXT_MODE_S)
+                          : cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo64.next_addr =3D big_endian ? cpu_to_be64(kernel_entry)
+                                       : cpu_to_le64(kernel_entry);
         dinfo64.options =3D 0;
         dinfo64.boot_hart =3D 0;
         dinfo_ptr =3D &dinfo64;
@@ -474,10 +508,33 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
 RISCVHartArrayState *harts
         reset_vec[2] =3D 0x00000013;   /*     addi   x0, x0, 0 */
     }
=20
-    /* copy in the reset vector in little_endian byte order */
-    for (i =3D 0; i < ARRAY_SIZE(reset_vec); i++) {
+    /* RISC-V instructions are always little-endian */
+    for (i =3D 0; i < 6; i++) {
         reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
     }
+
+    /*
+     * Data words (addresses at entries 6-9) must match the firmware's dat=
a
+     * endianness.
+     */
+    if (riscv_is_32bit(harts)) {
+        for (i =3D 6; i < ARRAY_SIZE(reset_vec); i++) {
+            if (riscv_is_big_endian(harts)) {
+                reset_vec[i] =3D cpu_to_be32(reset_vec[i]);
+            } else {
+                reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
+            }
+        }
+    } else {
+        /*
+         * For RV64, each pair of 32-bit words forms a dword. For big-endi=
an,
+         * the hi/lo word order within each dword must be swapped since LD
+         * interprets bytes as BE.
+         */
+        for (i =3D 6; i < ARRAY_SIZE(reset_vec); i +=3D 2) {
+            riscv_boot_data_dword(reset_vec + i, riscv_is_big_endian(harts=
));
+        }
+    }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
     riscv_rom_copy_firmware_info(machine, harts,
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f00b3ca122..93b9a37f03 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -39,6 +39,7 @@ typedef struct RISCVBootInfo {
 } RISCVBootInfo;
=20
 bool riscv_is_32bit(RISCVHartArrayState *harts);
+bool riscv_is_big_endian(RISCVHartArrayState *harts);
=20
 char *riscv_plic_hart_config_string(int hart_count);
=20
--=20
2.34.1


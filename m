Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504E41098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bQb-0002uJ-K4; Fri, 20 Mar 2026 11:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQZ-0002te-Kr; Fri, 20 Mar 2026 11:06:19 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQX-0002Q3-T9; Fri, 20 Mar 2026 11:06:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNbkzrVX6qOnoJS5V0HaEruX4lqGbcQLjpz9gjBDgF6Pv0Ddj4qvEkAkmW7AQc1V5uB1tsyDjTDTnERE2rhtNkO9xs3W3Fgj6suDZzZjwWsdX8UHTGqYlUnUV/eufS/9Kh1XDFuyl1n21Vu+dnz8wlNmwG4B05XVWPC5xRXn5sjM1+w8XZJzvJoBgp2T3CnI5gxzcFNK32VhsF8MZwJXxOxkbr8gWsP23mo1f7un4JZKAM4mJ0UuRWgS3fXbRc/lj8i9eyC22BNc4PbeyM4JDeGTnPCRyaHSsAmwGYzO+69+hu12g50auWQT3AHNF9UIvsu9HxYjqJD81knNpAUUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34/CdfE5sekpOgwFucUGFpIY+yInIWQKsaB0b8SrQp0=;
 b=HSwFWGYnnGKM1M1k1p2MeC/ufobTnx/TNpTSxBONGBR6Sp6aYs6R7I9oiZ96xtDeyEiAeukp1q/OAhLMhUoLlspwbd/RQdadAhHFN3iHP7at7ox12TXz+/O/WMV/rvawAQposoaVVQDjW5oAJsZ6m6VZOyzVQW2sUSLmnrkTUNC56K/MJBUo/4OMXtZzIStWgWpVO2HnWd1TnPI1/mmwBwoGKTyme34lLX5l+xj6APSOCT+A2ojERKlzzhasCkK2kCgM41Z6l0cZAeoNg56nyYXIbRILhNvvlihuQFYcE1OmuelxcNHIMXAh/GsVwLK0UsGuOBELQtYR00JAMX5fSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34/CdfE5sekpOgwFucUGFpIY+yInIWQKsaB0b8SrQp0=;
 b=GnmxavX/AiEog3WlcbqqYRNiGY8ARApL1qFhjYZxoepWg++1uU+2wlHBFpnww0ikl/gD8NFcVKa4LRU3yAXBhXq5L5NC00NxEwWurrgui/LmYxBB6eyqEKATJacT3lWU9Q0HHfZO+bzQk2D1FJrA4cIaArrBLkE782FITrXWdhHmGWf3JgLDYJIko9pADLqMUTjxFCyDFsxkUtm3NYQU33nlj+luIRIt1hvrESTycXlSQdXFVXDXNIx6nW/wpTRNEd04ayf831B0RV/pSxRi4gjQbW/PdRwqxu2rsg65LgMKLZLIecZKK1x5Fo+9ZT+VC0Gpq8NMjibPAi7KE+Ubtw==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA2PR09MB7446.eurprd09.prod.outlook.com (2603:10a6:102:40f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 15:06:00 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 15:06:00 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 5/7] hw/riscv: Make boot code endianness-aware at runtime
Thread-Topic: [PATCH v4 5/7] hw/riscv: Make boot code endianness-aware at
 runtime
Thread-Index: AQHcuHsQRUcqHWNGIE2EyVuKcyhjow==
Date: Fri, 20 Mar 2026 15:06:00 +0000
Message-ID: <20260320150552.169480-6-djordje.todorovic@htecgroup.com>
References: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260320150552.169480-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|PA2PR09MB7446:EE_
x-ms-office365-filtering-correlation-id: 9040c81a-c4a5-48dc-cf59-08de869232be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: seoH9MXenhKypnyO71OPpaRzIC3Cjz6Ly4KRLG6RzoaHuYaikCYPQSHbrnx4lpnnh4dp20LZjEBPDEJ04XYhrLptUHq7OIXzKG/XGLpm0UbpwNXGOGxBxLcJc5jJsmou+AzB6Hp8h7thJ/cyPWLKrRL4TCeW5TRzSKwLmSLslmMUaDL94chlp11ZK4e8dUjn4nRDSts9KpFO8EaNdgA6vkNGTuaONeRNhcse7wzKbqX5/EmQZ2ugTx5o1n0ujUw3LGWuEbl5xrOtzNofTRH9CztIupy3/08WL7zY8bRN/iB15Ve+pLYxWJJXkHSGhsAYgH6sFQSM3exM5UdxG3Qjn1anE1oZEOQA+Xf/RB6p2GXCxJlidLZHQ1BSVjoD57ayQXLRF+++IMf5D2DVeODPJhIM9OITew/MJrBchs6prvugb/eJMDzExBjEK91s+Nv8afL37UkNEdOPpBFq2GdtA/gGtxrMJosmwCVgLs/GzgYOIzThyTyEZe85LF4O/ge43VNBZLqLknVlQZvgr69ME7XArMlxNe0/9mnwz+SySdDRn6qpXfvsb8hzD4PasiBpzzh2PjSobadkop2T5jQrMM4gjkeLsK5FUiF6j41npPIYeshOBMiOxivVsEG26u1iop6RjjpvUEzo1wTvg2mIWdmwCrczeWzWRep8L+I6+NbYfqUkIrsc+azAt+rSHA4wiaSYaJlOsuWIj2cW/BXBXd686AU1QN95FSu5QGP1J/3w1W6PLcrN7nOX5y+iEg3seq0TsqFlij1kunMap1GCunOp3+h+Z9dQcRQdN2Oh8WI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gh/npSPYe8JHYnRVZJziBc209r2KYll8NoSgEJZXn2+0jhsfErwxpSouhJ?=
 =?iso-8859-1?Q?v2X1T+XlM75T53T59Quw5qJcj930GO6br2J+SaPB4ScZawW/A9cDwtsklt?=
 =?iso-8859-1?Q?QDIO0/mX/ZVrJdGiH4bxDrhFOdxIF5U2lMIZcREUqH7nD0QI/Lvnvj5bmA?=
 =?iso-8859-1?Q?UbJEqh1hxj4IQdPM4Eb04ZHK6qHEtXxfetSX92E7xiI8YCQNLu2OXIpGID?=
 =?iso-8859-1?Q?aT33Gbt2piGZmnItHppKKb+09FqRmHtM42bkKRhX1ga3sBgNyd9xl3PwI8?=
 =?iso-8859-1?Q?5rooOUA0xyj2bWIi546mlcaZNhhBdCoP7W/291UClwtAW9lV1bdTYf0cqg?=
 =?iso-8859-1?Q?5tTsbJ+sJTqk5hiJtN05MIvf7ACKCeqWe0wfRC4d/WGK9JntaPc5Z9ARoh?=
 =?iso-8859-1?Q?wNYKuNmXl2dv18v1g1BRvpDZX6UbKkjg5g5exUL9DLgCLIQRxXCruDRRxq?=
 =?iso-8859-1?Q?vss1ogGABst5F/LqoPvDqdV7wTc50ZgrlUvnNh2WQ64EQr01moQ8puUQAB?=
 =?iso-8859-1?Q?lhShu8/tdv04QrG50U2abxLtvxXO3B9g17ozqyp9gJx74L1yQ3DwyctvIW?=
 =?iso-8859-1?Q?pW7IlrWvCYiJ1QH+rwC4b5WexjMDwYP/C/GSFf49y75GL77YiowEsNMtKN?=
 =?iso-8859-1?Q?W8/NaT2748E4B4hzgSlt73MJr99+F6q7uJP9DYeNiSMejiq7mNOZTpnnv7?=
 =?iso-8859-1?Q?2DAn9Q/Dm1N90Uq509Mb0tKeqd1/cI3Vfza0A38yL77jBKZbY6yZ1oEEN3?=
 =?iso-8859-1?Q?ZAvgxXJZW1CpT83QHgycow2wJC5nyeZ7cYwMRd6FX0Lcfu7MmdMu9moIxR?=
 =?iso-8859-1?Q?f3APHGWaysH49fuEX3vl2H144L9C3WSN4DG8VUAX2YSGOLTkdZI0WE8RbB?=
 =?iso-8859-1?Q?jdMoVFNGksjpI7addPyG9tH7HZijwAIHGBLNkWKThOkx7KvLoEKuz0xjhc?=
 =?iso-8859-1?Q?RWNO94T9mjH91HWbYgibjg5i6Av5m+fsRy6IaoLB3wKo0scbiVCgfNx6es?=
 =?iso-8859-1?Q?k+jGeeC66d0+72ilfwNybA3Z+Bg7Og9YRXTAztJOjaDJOczSvkdat4Zc/w?=
 =?iso-8859-1?Q?QzvOH1HCbN9/hWoQsvHfjuNLJO7mv8ClHbAGqSsJ8rqLusMo/rmLrxBGrX?=
 =?iso-8859-1?Q?V4F51h0Xh/2tvZ/1aRQ7/FB+IlOjRINwSZQp86wO7lxApT1+xhFnzVpsgp?=
 =?iso-8859-1?Q?chGVSykUz02IO3detJtS6XyVtWmS/QwNwBRYx9Q2vKEAXBHmwlLPvZSif7?=
 =?iso-8859-1?Q?TnZBI8Uc0Ciq2kGAhRW7EG9aGVYEPtqueZ463Gf/Yb1owzaYceuWtJIhh8?=
 =?iso-8859-1?Q?U+8m3Em4500yFbUTQ4g66lSr5yrbwl4MMhPyj4s5fzBxSZvm96md+UBiIJ?=
 =?iso-8859-1?Q?xqQtrjijgY6wPx4rYZQ6aTq+Ms+SFudEH3q43b8siN+LiZpTvoWDL2hnbN?=
 =?iso-8859-1?Q?bUpn8rgKUL+g8Jb2sMf/Sd+rScSF2b567wS9IqkNCd667wMCAMO24kiEKb?=
 =?iso-8859-1?Q?cYZfXTx8omwTCLjWNXDRp5rNxZMIVCRGLq547it3akDHPISQLQfwW5EqQQ?=
 =?iso-8859-1?Q?efrjnppRIP/AZp00OKrr++nh0WD1fFqZ8GE/aUyM+AFLkxzOTJsBJgWa43?=
 =?iso-8859-1?Q?pR+l8PZo1t8QLu/gyil7yGjPi9qxUHUGNTEe9MkOAFFKM/v7sWmwRbdyYI?=
 =?iso-8859-1?Q?MwfKKV0eAWkrh+xfTtbHyBxjcG6oGw1bRe05tR1/SN3p/wtCKFJrYo1L48?=
 =?iso-8859-1?Q?unQTfywW4SPdG2s2IrWR1YUTvp24lvEYUn+wsOR4sKh2k9i1lTZZEWL3mo?=
 =?iso-8859-1?Q?3xhO8ZwnTd+wlIdm7stGVRLEdrLcXzi7+4eatkaMy3zvQ45Yqo+U?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9040c81a-c4a5-48dc-cf59-08de869232be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:06:00.6282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DALkceiAfZoEjT3HUWZcYHNLDhJ53MsihaJTVJ7xmVCszbq7CsPlYm/7DCZvso9+n4OzwHSXqXbTrTNx0uVFsIKcKZYZe2WB/7pxim0TFOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7446
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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
 hw/riscv/boot.c         | 83 +++++++++++++++++++++++++++++++++++------
 include/hw/riscv/boot.h |  2 +
 2 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5490beda0..fdff2a7ddd 100644
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
@@ -72,6 +94,7 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartA=
rrayState *harts)
     info->kernel_size =3D 0;
     info->initrd_size =3D 0;
     info->is_32bit =3D riscv_is_32bit(harts);
+    info->is_big_endian =3D riscv_is_big_endian(harts);
 }
=20
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
@@ -247,8 +270,10 @@ void riscv_load_kernel(MachineState *machine,
      */
     kernel_size =3D load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, NU=
LL,
                                    &info->image_low_addr, &info->image_hig=
h_addr,
-                                   NULL, ELFDATA2LSB, EM_RISCV,
-                                   1, 0, NULL, true, sym_cb);
+                                   NULL,
+                                   info->is_big_endian ? ELFDATA2MSB
+                                                       : ELFDATA2LSB,
+                                   EM_RISCV, 1, 0, NULL, true, sym_cb);
     if (kernel_size > 0) {
         info->kernel_size =3D kernel_size;
         goto out;
@@ -391,21 +416,32 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
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
@@ -474,10 +510,33 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
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
index f00b3ca122..a54c2b397d 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -36,9 +36,11 @@ typedef struct RISCVBootInfo {
     ssize_t initrd_size;
=20
     bool is_32bit;
+    bool is_big_endian;
 } RISCVBootInfo;
=20
 bool riscv_is_32bit(RISCVHartArrayState *harts);
+bool riscv_is_big_endian(RISCVHartArrayState *harts);
=20
 char *riscv_plic_hart_config_string(int hart_count);
=20
--=20
2.34.1


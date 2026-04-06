Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AFDF46C4D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9mD9-0005dd-QG; Mon, 06 Apr 2026 11:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mD8-0005cE-6V; Mon, 06 Apr 2026 11:49:58 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mD6-00021U-F3; Mon, 06 Apr 2026 11:49:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gL6jfjb9/YfBTm0QCxXJKJX43bxbD7WC2UQNc9i4DHNc2HVB2idVXoHLWnQMpemqBZmwp5TEptkhCcF0sGZBRckec7VihvVoWCAQ76w34t27sAkov319kj/zPHWUfu62PlMtVWz7bXpyk2uvbp4Ncg+H+1mMgeHKMFjWiDMTjDxKRixPB2nIFz8mha7rD7uXPShstqbAFvtYjmZCR+CLnVqkZEGq3gSOkLcK6+Pyop2Xwy3yqS4Zr9HcbHilJEn9cSABbWfKhvZaEHqpU+iGFYTXk2m79Mxi7ZhBZKMo0OEBdYUEavdrR/ElIKoIlsg6PfJLWxYwqMph4bXRfoeBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbfVXWr9+U6etvsznPf/5+PQydUm4sQ3DPy9B4dJuEk=;
 b=D9NHE1DQ2yO/l5eSpmh1sO6Kyjp1iG1LYOcos4ZgP9TspRFFmx1qAjpuv8JJec+apoT7RL2ZXr13R0lGLHIYdUZAgL4wiYq1XMaUFZDD/VT22A5+wZLV4HmkndfPvjF1vz+BAkrIXKSin9mthg5YVE5y0NfjyVbcRdiF+UQZB0auXYyjfYGq1mPs4T5WvFAHisFZZRhus6IjuO/iFS10T23jHtSGLqH7PSLOGLEYksiO5gYM9ZudwPef+pJuh0A8mu/ffLV8ncdHifEdluwKJRkKhzHwTgOQIJe6rIdq46ZeTOBZdTM38viHtQP8jxj9tgyFejz4GhMOrNiBdVlHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbfVXWr9+U6etvsznPf/5+PQydUm4sQ3DPy9B4dJuEk=;
 b=u7rMRZLKj/KGn9QxcfkfLdkNFJASKXswINNuwIP32yRVdQQuTfqSDuB3iOEcv5u3DPutzK9+xLgnNbAZDnpzX2Rukc+PBrp4OmOGnGPVPAWpTJhAwaewp4BdlXbhFPdPhqjnCa/c5GCpqhnLcMXD+SS86qoBA5mjKP4WiYU/1hHGq3m7BqOpJkCretU/B6Wo7AuVzn9sQRI7cmQio1bveSy84k1T2LeGEhY2XTahXdP6jfRae85v5hcp0m5udd5UEr6LDwyvLADWNu+CZQK8DZRkgi6k/3vK/OEbAVUIgsuYpphpUFRD93l/bnwb/tEu5mN+R6BBzOaXvLJDiDhoBw==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by VI1PR09MB6903.eurprd09.prod.outlook.com (2603:10a6:800:1e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 15:49:43 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 15:49:43 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 5/7] hw/riscv: Make boot code endianness-aware at runtime
Thread-Topic: [PATCH v6 5/7] hw/riscv: Make boot code endianness-aware at
 runtime
Thread-Index: AQHcxdz7ZtpTLs+6xkGyp26LLHNMSg==
Date: Mon, 6 Apr 2026 15:49:42 +0000
Message-ID: <20260406154935.144674-6-djordje.todorovic@htecgroup.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|VI1PR09MB6903:EE_
x-ms-office365-filtering-correlation-id: a2bc9e86-62f0-4003-f899-08de93f41ede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: vJZw3P482XhjvAHR7USZJQ0ftOKB5bC4fhMj+p0d+z/AuNyWsKfnZoS01Km9JXaAhbUtIyhpT5RRL7Yo6erCc/ugMxj1uyxbdv8tQMfzvB+yq/wxi9q5mg/+l60QV7oQC1y8rxKkdAWEpyOuSS8dCWlztoU3fyjwfe+j47oLg37X2xLok7hh5PyxPyWUxDyWL3S68Rg1Pjj3PlXtVX3xQ+wWhN88ude15b/0K3b2q65cHYP/Vd4C9o8jKcWm/AA2JLSSwH0Kv+OynPbJC3bvYiACAXEpomOerj8em4ejnsLKAjqzgmAUXl1fGnkiX9rnUYIwrjWRfFXu5cyYfD/KwVSaRI7IAKoFNYR0GOCBk4HkFJnGrlCuHyrc6Z+nO4Av5mxz1YPdS7Bql4wH4EG4oB/n78HxFbqwFKaJJN4mX+tZUGwHR1tcXvrzww/KNf3gy9NJ14ByA3xYonOWlFSVTk6Ap4ZyzsBV6U9lD5RbX9yMUZy+r1QlDAEMO4CKixZU2xSWLaL5hSn23X0bbNFKDc1K7w0k6QvYyWh+vpc7Os7YpravY5eY7G69Uz8IhXbFb6Wmfn3Ijv9cWw/41NKZPIK7LmY1rbQYT5byx81keZyfhsAAMXc6mKRSUqda50i1N6WUWHJujYReCw02WiW4upksWKymyili1kLY/EaQmi9hxGFec4mOWOEaqt9rLSCNuW1GEoq+zLWDn7yFiTTURFa6sRcdJ5tj+ntA5EItRKcfRApZKFcYcuQjO5XE9GGW2X1+KuDfnv3sfxvbWTEkRoWUOYlRxBL9sGCIHJgeNbQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BsWLVdKMM21V2WegaCFLd3Kqjt6yKIfy3VlhCt0wNRIbwi7Q73Zc1vt4X/?=
 =?iso-8859-1?Q?0aznxbYJi4vbXyjlnFhk0Adk5tq5cRX9dRybQrk8Q3vZkG164V9Rxa5CLJ?=
 =?iso-8859-1?Q?nT3uHN5DIn4ztvXWzWZbRPNJ6e8j92oZ9l9mkaIEyJRRiXR/7D0H97XurN?=
 =?iso-8859-1?Q?P35yw4/nEkhSegV5SgTd/Z9g1oX8qwNXdIiSTfzGUw0NPopi20SpXSLNNp?=
 =?iso-8859-1?Q?8h1+tgXEKWp+6sU1GhH7oEU0wzqFvFduCaQN1CedQuk1lAMB5Lt4S/7l1x?=
 =?iso-8859-1?Q?JxwtmERS6e/5VEEDoMh3v/6edRhPhVHlTFDu0Mah6qQc4yfppd8m/ugmCQ?=
 =?iso-8859-1?Q?DYLeOpZ/PjXZUwGluXabpD+Z/jUtDRTp0tAsCbqkiqZgZ9wAw8fRgTn7Dg?=
 =?iso-8859-1?Q?9qAkrrjwnmcoaG0us1rR3M0fK9JYECO39PIl5h4Px4WwmSM1VDdhME21AH?=
 =?iso-8859-1?Q?x3DJbFuqxEJSyf/yjVGyjBl1FMNaK/CLQiNfKisAAfpNPqv0aSZ6WkzqeQ?=
 =?iso-8859-1?Q?jxxTPPBY+DVY9g4yYGf622tvleri8EfPdcd4ekdyO5ue/yoe4W0korLkEy?=
 =?iso-8859-1?Q?67EnbjVpypAg29d4R/Af4DSd+gz2fQ8nY26dEqgtDpTeocB/I7kPd3F1kI?=
 =?iso-8859-1?Q?YE/u3kigP3g2UQ4cbgGTQLXcbPtHcTA8Zvx/DuOE9Tb/rXKcoBj/6anqj5?=
 =?iso-8859-1?Q?x1T68JaLfiCPBnUlm9FtRAzBdyflaPt9N+tkN5h6cx1hXEhewwMZ0KzIDm?=
 =?iso-8859-1?Q?dFmdYcM1oQ04Qdu2+yBQDmuJQ/3UkmzU7in1YPEg19oZzDW/ZuH97JpGuS?=
 =?iso-8859-1?Q?G9PkU0RYa/dxmqg3BepUj6xnFXbVylz5aUW+ypi2OxUOKvuVOGxFa+hVBx?=
 =?iso-8859-1?Q?sJ3C4waJTkBimz6Sz5z/Enp9xHbz6KzkyEutIq+X8ciZFBzOYeNsu3P7pv?=
 =?iso-8859-1?Q?BDtecnEVqrAoe7px7MEfKGWXbIwC0Ky9kzPfpWir2TtuLFkuRFhTr/FEjc?=
 =?iso-8859-1?Q?bNU8gl9JiYomb9aiB8pxgNCTNXdDOXH5255hv7/FStv5HlhnVm3ndhQ8AS?=
 =?iso-8859-1?Q?IvfPyTt25dVCpvHrTcLDPy1y3563BOsPe3p6TmgYyqVGJ+d7htXRbmSpss?=
 =?iso-8859-1?Q?gKUdmhd+yZMyorXLt2w+5C3wbQxiyGiVUNH0LmKdUea7+vZJoMzKcpX31R?=
 =?iso-8859-1?Q?Z7JbaF/i1xEhk3tu6Nol/GS9EcvyMdoqv1NCgqDfSMyCgoVpPiZI6bnXpa?=
 =?iso-8859-1?Q?gOgONvHwu5pA5ApvNPfTc6hv5bnZQuurgzQJel3HjC0S0Zj/fzoXhImDHF?=
 =?iso-8859-1?Q?6WI3tP6/I6Bw+MXTlo4Tl6rAWyB5rSxU3LvNOyE4AimH9xll7IPEmJ4htB?=
 =?iso-8859-1?Q?IkZa7x1tRmu5gWMiiTAV1mbmBhIV3/QlDrwzbSuc/brtICwLoU9v6GlfpF?=
 =?iso-8859-1?Q?VlLQBRJt5PP17XyykOw+5E3cWPD6gS9LP/LFkY6SrwQFqlmIsmVnHUoSgR?=
 =?iso-8859-1?Q?a+FsgtU8TGWg+TTAbqslN4kgoQ2i9FLrvSR2WfkC1R9+rEpjy6tsbzbJoi?=
 =?iso-8859-1?Q?6CrI2SbCfPHZ6MlLKQp180O0JoqgjSh8p0wq4cMIECrL0WchqHebLoI7DP?=
 =?iso-8859-1?Q?CXTexqu2hntWaIr+Jy9SHpmXCJJ/n8ufnfaGSQhFoGPwkTGBbTk/Z+FxNz?=
 =?iso-8859-1?Q?kUr+KBznva23iIGDfdIjOgcmyXwN976+LhytTvSrBFCTOYsOj9dR5KQiUQ?=
 =?iso-8859-1?Q?3WDVFT0lLYZjJoivp5TFBiJ9yPIHQtOis3Wrgs8pZnH/wnyD04TgBuSrR6?=
 =?iso-8859-1?Q?x23W8PIjHq7Vtgi3HGhFjViF7Qllt9YWNPfNqkA/WshouD1YsrHF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bc9e86-62f0-4003-f899-08de93f41ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 15:49:42.5185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2PuC5JEp54zRQE79BSUCHRvYSuQU8Z9lJUIm43c1jbXI9JjewO1SOrirDJJZSl+zScwbxVvuDE1CVZ5A3tZ95cvHgPU8LPjk0E1yjqQnnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB6903
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
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
 hw/riscv/boot.c         | 82 +++++++++++++++++++++++++++++++++++------
 include/hw/riscv/boot.h |  2 +
 2 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5490beda0..c7558b904f 100644
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
@@ -247,8 +270,9 @@ void riscv_load_kernel(MachineState *machine,
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
@@ -391,21 +415,32 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
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
@@ -474,10 +509,33 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
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


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2953B1062871
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IEL-0000Q5-UQ; Wed, 11 Mar 2026 08:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IE0-0008K2-W9; Wed, 11 Mar 2026 07:59:43 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDu-0004dU-Po; Wed, 11 Mar 2026 07:59:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfL3iuOeOrpyVh6RAITO/66Nocmj57I0GAC1+bUFRHwu59g1cZ4da2JwysstAj0JR/aQqQM1h5L4BsjiroSqnVAbqotdaIGUYN7r1dcdiUEeH+lq89vObQ/QKkzAJiMolivuFa+gJ5K+9D5dB/kMkm98D7IrGwfgxnSq2MZ6TojMSWvOs+fBTtY9T09HhUlv+Dt3RN+ApbAxosoK2Ni/Z/hQCWdy8CS1O2911Us1Od6dcc5/XSRE6QvcXYifx8X5WfeoouwuaVZDjR+uechhKKiNDokVBadkA+9f9PfM7Jh5qytpmR4Npvd+fpeOaFK1+ebDeLLpnxg8r2KR/Skhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obg22XJW8rFs/l+JFsffm5A0qb9DwXngOOCrpt6CGgU=;
 b=eyE7+8/gFFc+fQGMORmIOlpQR/kiHEFDiAS8anK+Vpzszl/+4C0+jaSsFabjSRNYDGjhhOBkR9no6molVBIEcTJ09MPZgrrgvn8sQy5nGS/VStPHF0blKiDt3TcK2S/9rZ+OwyHmiRFeQZ/adRxg2fPVxcK4vbKN8CTdioZgpNscf8yb0Nuydg8avCdPoHxx4i11RqAU4+bVi2SZKRB8Y8ymIKLauizM0E5tqpNyXF8QIreCKBAUN0bT1wEodc0Qfe6/xlydikorcn4xEFf96s426MD10+hsXFrpvQ02HZfA9Zs2Vj8v2oFWAOTGRt3qVEYhPlqBF0YeIShLmNnZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obg22XJW8rFs/l+JFsffm5A0qb9DwXngOOCrpt6CGgU=;
 b=HtMdM8sf2jQMe+M4j1r00EmWmqc0HGLnIWSrGtn9oYWd7H0GVAdqmJtpMjDo1bAZMw0HNx1+KGaEWnbzDkd4+jVwX5qF8le1UHaueAES8EmFh7whgrA6b4584MleSyZVIszsqtFJ9nBUPtXrlRXOPquvZSvzcusqBrrQ+fmlHKRRvRRFstP2qR9P8WuaSwBWru2V4DrDxG72U1M7i3I9V5iS6rTrXT13rheIoBCubXjpngxEAFLNt1xb1+89+K6RfL63qk9kXrG9yTi8qqEuvx74GhY5I3EcpYTxQ8+Dnp4ktCnNarTgFQere5bM7nRTibR5eZFjc9jopjEKHlyA/Q==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6069.eurprd09.prod.outlook.com (2603:10a6:10:407::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 11:59:20 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:59:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 6/9] hw/riscv: Make boot code endianness-aware at runtime
Thread-Topic: [PATCH v3 6/9] hw/riscv: Make boot code endianness-aware at
 runtime
Thread-Index: AQHcsU59cwikxk0gFkGPIH+ONT2gVQ==
Date: Wed, 11 Mar 2026 11:59:19 +0000
Message-ID: <20260311115910.564481-7-djordje.todorovic@htecgroup.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|DU0PR09MB6069:EE_
x-ms-office365-filtering-correlation-id: ae473d2c-a68f-40eb-d299-08de7f65a0de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: OOd40125Azwv6/0QhwUQQvhB/d/6HdaARoDVV8YJHtcOYMLEtRnQz6WWMfYkZ4Yllp2vVUsTKhh1iS96Jt9rUlgo/zGmtGH8heYsdBSB08mVNBZCc0hQSeATI5moV6xzq9t3WPh3swnCzF3FVGvZa0vvnkh3khLGwslO2P2OsF+slPjQbrJN1XajeekXVYsgWE8xxItgvitz35viGZsLMmv7yaHsJuJ4l8U1qI9UIFJUQQQXBOSoZUocLTDUwPl089pFjEU8OJLgPT3/cfn0GrDgobUD2aU4cMnbRUb0osnYBpjlg3E4bfzuzYX/DZPnOZyahzvYiF5PvxTehMJAmz6VWsx9N/TLsNB6sd8Bgvcq+Emo0CQP2cayr9QTG1WofT3XAj1P7ET/T3BRX1UVWmCUSVhrZJ1g4OgQekWfwh3Wpaxg//WM/tL5dz0tR/j/wOo0A7jKD7psoeEJlJ0CVS5Ihmwa2rh+l1g2mmtST0y8cz32CYlsRbRRJRvIrBxKT0VIEeg+ZQAEtJXakJz3krxXN7EirEXtEllebdhyOp8iyZkgexdTxeYq1cB9qTKpQlr0ZAjCF7F9vkdbbn+PoP8QiYEBzWMvHhQFITnoIkbqP42RqDKiEAe0BeBj2i/J4jiGdMBUAOsazHXsOSpQQIKUoE38NgFoDeAvpCXoyyXBKL1W+xdc4621N+s0d9fKKPwV9nJ5hpzKSUOVEI08rJwxCimYpSUfVka1SN1K2W/lKev9tiM9PfjXYK3WDyyvTmqDKtcDtQ93+jHk59wzfXLb6ya7538MGt6IpeFKC48=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m7+FlY4nfCeKJ5ymJgeJIcl2q95NhRREApqRrYQFc7JWM0Hpg0b5Ker72r?=
 =?iso-8859-1?Q?XIcItYkA13IYch2QozwoinnGKwBWSU0UqemjJtQU3rZyf6k74pCNCTJAgB?=
 =?iso-8859-1?Q?D3YsG16bLO4oZwEXXlZCQqocQlgyM7bsR2XkZ6xLdwHtyK14gC7uHBF0HK?=
 =?iso-8859-1?Q?e3LOLwKF3yS3DjZN+CplJgBtCc4v17OcJJkGfoWNbLZIVdVSHIpg/PsO+v?=
 =?iso-8859-1?Q?QnQhqAij0jcDCV+OQPfPZEv8ktcfIIhCGhwJIkZacFfq8NIaPSV6WylOF0?=
 =?iso-8859-1?Q?y18rQu7giy9xyXCnf4rdYxwsUjOR82EN42G/gJgRNvJmHHEcO2pYGj5aNP?=
 =?iso-8859-1?Q?2bCjJ2+kTc1Esuo10gIEfYaDu56xeukDn54M/9nkGXU6qcxlZX7uKx0pRE?=
 =?iso-8859-1?Q?eT8vvtekBXsM1mSPFrHSDX0Yoccml2YfY7yBzEv5FV6LzN05O/nsyt8DiL?=
 =?iso-8859-1?Q?wMfXav/V+qbWeSwwP827lnFDapUKazu+8kg/cIxwFBWkfwtXCSRqUxxAyN?=
 =?iso-8859-1?Q?5ms51002rVMUzkNi/S2j4r2PfxIAl31RjewZ1GUNFZVmWwraTPE4nevY1J?=
 =?iso-8859-1?Q?P9DfiwjDDxiPlyKKGpKRLihYP1fpyW26D6O28RbdnW6YC7IExGf0aW6H3C?=
 =?iso-8859-1?Q?84KzFWdmJP0rYbLY0mXo7AYlx5Bcc8gnd9YJj96vb76EsLPr8lFjS15wd+?=
 =?iso-8859-1?Q?sft16Jk1ngPXseOv1QMzk9srwsOj/W8k/JAaEDvXZIvZN8cY49tH3I/sbb?=
 =?iso-8859-1?Q?maXfJ/dK72k4l/rdSD/y5BhUP85YRYK1NXYyVZzwvD6vJMh5kSjo+8OHjN?=
 =?iso-8859-1?Q?SFeJ/CZSvCH3132M4fyvKSV6bEm18n2qLWnr+9kv0FJUg8SX4JFHoWcKSN?=
 =?iso-8859-1?Q?JjYSftGSgZiECJ4Y5sTEBDMq/cRafbvJ6l5YFvfvOxAtSAtn2ZzemYswOU?=
 =?iso-8859-1?Q?IcYoKnWtWJxTyjDkQF9ERUpFSDjbPxxOMrAFmqMhG6j6he8KXhJVb05IJn?=
 =?iso-8859-1?Q?nevgjLIudtm5mgZQZo+SBVezllFDyCHqaPHOsTq/8q5ybWrfeNUISrI8n9?=
 =?iso-8859-1?Q?9pCVaTgB4O/bVsrkX1fWlTl/HZnUrk4YWrBFsieuzJg81eQ/MdA+BT6Y4d?=
 =?iso-8859-1?Q?uXiw2/vSfzGwWDPPTYmAQmoOkEG8PlXhSRh75ypXDpcSK/+Z5xE0HeRf5l?=
 =?iso-8859-1?Q?pjmIKaAue8jjwuTh+Mc2blGZxJOV+9SISOj9aeonMd8vqS7ysmrktOBvW9?=
 =?iso-8859-1?Q?wPouQKR0kmC855BXqpD5Xcn60PHaFe2fV/LjMJOTo3j8FZcy9vJXk2ZEhV?=
 =?iso-8859-1?Q?KbNh1HXlxV2dpGSAqijx6U+LrmgHTmVO67yTPyZe4LcK6j+aKjuQyRFWM7?=
 =?iso-8859-1?Q?N0lzOXUH+G9ObLktCokVjphgxDDaFiFJqcSixFHGLpXSwfZ224q/+9YRWn?=
 =?iso-8859-1?Q?0Z7VeCUDY8Vd/Aqn+DwDgsJsiA6ywYtEPUIk22uJcudBd0iHFfMhmHNvoK?=
 =?iso-8859-1?Q?nQi/As51h+B6orWgLqdsbGFvE3362bVPinFWqA65PU63NT2CAfqQa7Mgty?=
 =?iso-8859-1?Q?iJhDtG5g5VU8phfcU08ucv4+F01niXhXrZLjsJ4pptwij5VQVdYWnEBi7b?=
 =?iso-8859-1?Q?JI+2WeTaHXBYttp2PrsuKGqfO93wWsK4omF1Xfl11gCD8UyaH+dp8FD8Cy?=
 =?iso-8859-1?Q?dDmCohmZFsIjMZI74srsGmUinQrS5KzgM2HkOQz20bdUZ5NCaSn6Gn0spT?=
 =?iso-8859-1?Q?qRHzvm8bTNinuwznAZTzDQYVn8VRkcd2zMWB8bPANMnywPGYyzFVPrMyYR?=
 =?iso-8859-1?Q?8sfHi1GURlWHa4lpqZY9HPgItJp5sy3EkwMrCTVCpBvkt1B7liq3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae473d2c-a68f-40eb-d299-08de7f65a0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:59:19.3202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8CmSKEk3Q2VUdV6oj+3ZbNetAIfxqKceqmXL5VNlV0YqhGHLeYhrekkHLMdZyBplyJPSEP7QOkfkUDI38JsA2JwCNqQkRC81QnAekMfDFkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6069
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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
---
 hw/riscv/boot.c         | 68 +++++++++++++++++++++++++++++++++--------
 include/hw/riscv/boot.h |  2 ++
 2 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5490beda0..e9a049d2ba 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -40,6 +40,11 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
     return mcc->def->misa_mxl_max =3D=3D MXL_RV32;
 }
=20
+bool riscv_is_big_endian(RISCVHartArrayState *harts)
+{
+    return harts->harts[0].cfg.big_endian;
+}
+
 /*
  * Return the per-socket PLIC hart topology configuration string
  * (caller must free with g_free())
@@ -72,6 +77,7 @@ void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartA=
rrayState *harts)
     info->kernel_size =3D 0;
     info->initrd_size =3D 0;
     info->is_32bit =3D riscv_is_32bit(harts);
+    info->is_big_endian =3D riscv_is_big_endian(harts);
 }
=20
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
@@ -247,8 +253,10 @@ void riscv_load_kernel(MachineState *machine,
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
@@ -391,21 +399,32 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
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
@@ -474,10 +493,35 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
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
+     * endianness. For 64-bit big-endian, the high/low word order within
+     * each dword must also be swapped since LD interprets bytes as BE.
+     */
+    if (riscv_is_big_endian(harts)) {
+        if (!riscv_is_32bit(harts)) {
+            uint32_t tmp;
+            tmp =3D reset_vec[6];
+            reset_vec[6] =3D cpu_to_be32(reset_vec[7]);
+            reset_vec[7] =3D cpu_to_be32(tmp);
+            tmp =3D reset_vec[8];
+            reset_vec[8] =3D cpu_to_be32(reset_vec[9]);
+            reset_vec[9] =3D cpu_to_be32(tmp);
+        } else {
+            for (i =3D 6; i < ARRAY_SIZE(reset_vec); i++) {
+                reset_vec[i] =3D cpu_to_be32(reset_vec[i]);
+            }
+        }
+    } else {
+        for (i =3D 6; i < ARRAY_SIZE(reset_vec); i++) {
+            reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
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


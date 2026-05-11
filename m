Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050B9CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMN8W-0002G0-2M; Mon, 11 May 2026 05:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7j-0001tE-CG; Mon, 11 May 2026 05:40:27 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7d-0001R4-Kd; Mon, 11 May 2026 05:40:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQTstAYFUxVERC6Ej9g6X0UMRJVKXcPB5qd7Rs/bbZ5qb/1NRT8ThXPgTzu3f+ZyoulB1nmCJ4AqCIia7mjpYYhz79RXKWgFYOBNb+EqxeOW6jWdxIK+IDEXdEpb5bb+5wwUzY4FAXe2jLNOIEFaRw1Zo79ENPBo4rNpQqLJaU+LMeB6V/CJBDlIL8hiwNhpc71NYwtRCG2Q0XMcqb1div623o5tMzA3EC6l4ZEQziQSIf8hSfmoVB3OKzhJ3mdw4rgxiLWe4XtJpCJe8hQitG3YvVwoNctgWxaof+0scRTVbsAbil5CbtXVTL8ml2yRnOEeRlHhZ222vZ3SESlKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnMdg879MLQmlrTDWV1ZatqlH8cLuWshdwJGs9NbBIU=;
 b=pZOmy+7EzS2bpJ+4vgvkEwCHRUK2b1oCpzm5RIR1vBhAiRIELnCY54fLG7lVvQWJ0Q204GyyYUq4EZoXVrz8EMTiIqAZdj/MBUQMQfN8HOFoNVjGtkw9GsbvvMGMCqe8I9WUojxAxpCTbA5Sgnu7NMBFe5hpdtNFtCkkLL0joaJcVCm+jBJJxOpQUDsWW/i4alOZhhJFOJaV88Ex8NEII20AoKkSIarls3Z4Jv2xtai72AaXPCn/KHUEuAsQFHxNyuDhAW7GqqszAWNDtfyTUm6JMqfjIw5vGDONNZ3HXYtI3ZSy6JAsFkQOnUuKLhBlEurCiz1TC/WWkWJkjHzgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnMdg879MLQmlrTDWV1ZatqlH8cLuWshdwJGs9NbBIU=;
 b=BkIjlBT46YzkPxp9Obpnu7AGKUjTbCvyrVrH0hO2VRnyZK0+Ut4h4HBxmLzlYM8l/g0h5rt5KDBWn8ZmtaG/dFdduSGaxRKU4BsDTvKHOMBgGAuq2+ALcs0OJ1LKxJLukO2k2rrFbS2l9zkqKOoXnwjrt2ZJoUxlQn+rqbApGyPLkC48XclfVJw5Nv5NrqPanOlFPf8BUhAScpKCw6g5S0yrKvBFExVGM/8zv6D7TUlJvytqCQ3Nj3tpQlpV66HPvkm07gBCnIeS8dwYtjjCUQYrzW3xrIg+UtRpr4CW7EnoNm8HCRFi3KRsGdtNT2Og/e6cFYphuouCB4GImjnZYg==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by DB5PR09MB8695.eurprd09.prod.outlook.com (2603:10a6:10:64a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 08:38:30 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:38:30 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 4/7] hw/riscv: Make boot code endianness-aware at runtime
Thread-Topic: [PATCH v9 4/7] hw/riscv: Make boot code endianness-aware at
 runtime
Thread-Index: AQHc4SGKm7+O3f9aq0qJRDqo/tUBcA==
Date: Mon, 11 May 2026 08:38:28 +0000
Message-ID: <20260511083819.206216-5-djordje.todorovic@htecgroup.com>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|DB5PR09MB8695:EE_
x-ms-office365-filtering-correlation-id: a71d8d8d-7733-4721-0b6a-08deaf38adfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|3023799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: trecHGenZjEHjSVnqeXPmVk8w3zvZAfFKB9YP6PYmr8T/V5ZOibY4p+s/zsplbVIgrrQC5fRhUdr3ZajP4EEIqmNafAyxOTO//6sZ10MykPlOnhaPOKhD83dNIMoff///j4IH2qs6sHiHklv58cQUcKUg0EwcVW4ydUok6gN6XLD/ewAcD0dGqGfysccxtyHLWfZqjrewkp9eiQXhD5MVa9xKPZc9fdShNrk6XnI7Uyx22mAiEd0j7YGS9Rd1AuoQNLMK25i7/ZSG86I0PQXGrzxBgI5sGZOM+KvxdqaMa8qqSBkGfm1iv4rf/sPPdrF0PZBxLGsXknIILQggDVQBT4FlsIhansx7s7TzOmDnGsv45Km7lKOCXiU7NhEMyWSTERIoxzio+AD3k5FAgC7uamSOwW8DbdKVrymhdBV+ntf39CxnMQhmG8VXltAOBgBAqBhhsm1ej7pJ2Orr2QHcxCegdUXZNGjsCyc3b1YDpNc9w4Ma0cUMizIs0U73c4QEEiifJjdqUjPMJa4YRtCJbXlX/oE/lU0tbmP1qc1qDO7QQxszRnLxeHgTz0Cg/evcFr+7oGwKByvj+2SfUv4NCkyvLpGweeT/piPbyBTmgHmmlXup2NhG4F2fPK+SqF/IeIFk+UKcnZeBQak8+S13cgruIqgLKK3rSGBQrbd+6S2RwHCK0EAhkI0tAZZbJQXpz+r33oVHwKTijb1l01pY8nlzDX5GxZylVzGXtIfglHjusWIzcBsDMUfBkL/M1W8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e6nM+mdPVAFM4zZiz+o/EAYEKi2sf3R7VxxXkUVn+N0Dfcp58ozAOFw6n2?=
 =?iso-8859-1?Q?h/lx3RHHQkmXuq3vbSADsQ81UpiiKmJcIVCHvnqxl4DX18RU3xXOJEO5dr?=
 =?iso-8859-1?Q?UrIekKFaJm6ovVtZeHEMB7lj5evRXpmnTPJ1BP3Q3D+/k587Q7+vk9u1F4?=
 =?iso-8859-1?Q?q+Z/rt/dMGlnUykN9mpp9XahUunZ6n0/vCf5SPHnKIsfP6O3FjuiJ30sc+?=
 =?iso-8859-1?Q?uwEdg+mAdBXfVPvLbp3/qMDMR+YJ3wqLMA6yETLfKFlPu+FjZHwVr7eKYV?=
 =?iso-8859-1?Q?etxbbB2P5w4wBRzhLQUBMZQRPqhLwvizFlORdLrAo5MJw0B2BS9YaqkWuA?=
 =?iso-8859-1?Q?aEzlFE8r5PG6rdlnqK5o4L1ss0/DbyOo9lsAU/mrVYS1pzmalJHp6T9LFf?=
 =?iso-8859-1?Q?y1lZb3BEtPpxKciVKHTai94X/kbMvKm0YoVtzDAkSpPW4AGwvbYpsmXihq?=
 =?iso-8859-1?Q?LXJ6qzNqvWX161d5vK4s6iOVnvRRaVF2WzeH9TKpS/V98riB2PR6drF6HD?=
 =?iso-8859-1?Q?nvmLu7a/+DIT8vt1D4tA4pLF0fF9aQisYXJYtcJSUSrldmSDiWZRYrvFuh?=
 =?iso-8859-1?Q?xzEolJykINGEMkcg5NTbmJi2nqh4V7gxouMIaXlBehzi1mbwCuhUhLwuX+?=
 =?iso-8859-1?Q?nhqawIzDguuFm/Fn3ZFcFubrYfZgRBO3GFt5nAxDUqEx9MWt8t3jN4TuET?=
 =?iso-8859-1?Q?dINTsuj0h+Sbi9lS1PexYg2hESMZroXUfBy/6sn1qWPGCfZXPSDMpByA4c?=
 =?iso-8859-1?Q?vc7lEkp+Ylg6i5sVYtFuNf3FEzYW8ejMPe2oXOP/RHonUVyCJwc/toMrOT?=
 =?iso-8859-1?Q?0HF3A9fICflY7oci9QArYXyLbGRyvBPT9yufY0NZ/1V5PBapwKvg32GQYs?=
 =?iso-8859-1?Q?xuZIwieaNtnfY+j4+W15SKtNyUR7IWhvKhxEh5Cc+lCLivh1ZAbOonNehR?=
 =?iso-8859-1?Q?FS6DmlGcgt0ReSFFlncBT2NkAi5qkH0l4YsZFklhFH6Bz2mEDMhWzZyFZi?=
 =?iso-8859-1?Q?xtuBgm4+/ljdwMk/p1mmaaIXGOi679peboeJwiFJfmHrTrIFfdz/tmp1pA?=
 =?iso-8859-1?Q?5RMCYqv1/jOXUBIj5ndovhxTiXAFONmBhPt1hgwYEUap38jOdySinM98Wc?=
 =?iso-8859-1?Q?XJQ3LKn75tRJkjF2AWfSdXnrAdNGMgkglxnSu8H3vtqccuUIsPCSYNQwZz?=
 =?iso-8859-1?Q?CSbmrGtIUjf91DBuJ7hxQF47N5v9LIekZJIf4Li85LuYV1gR7JOPKjWk32?=
 =?iso-8859-1?Q?I4WbyKTXqA2AUFtEcoKZN+T88uWXna5ulHZqPdtSTlcWQ8+IdlNvso6taH?=
 =?iso-8859-1?Q?E6PXz6NO/21e/C1XZdVCsN4tBpRJdtA3ao6lipT62TJ4rAWxcjO1+zlJDO?=
 =?iso-8859-1?Q?mhKtrDzlDahxzsk4gyB0O6j94Cp2J4wjv21gTO/rMWrLSx3E7Sw3dFgLhP?=
 =?iso-8859-1?Q?gNtvwymE8zv3uj2tuHRmeHUP0BmXBbkjqqqs9JV7X/qem0N5Icag10XKVt?=
 =?iso-8859-1?Q?A1MiPuBmm/lVoQKaquwN2xJvR44/SSjlUou88JcEfczbkBzf0QniEQwWii?=
 =?iso-8859-1?Q?sudi49MN13GcT906eAmBZovVBfpJHNgxLtMraW+AiRIvsH2YkB0wNcfD+O?=
 =?iso-8859-1?Q?AKt9kfG9BfZdOeosoz1+TjtQBufogZyE7mOqnD5KlRA66t112jG7SVJIKE?=
 =?iso-8859-1?Q?Iu/F2oUgOSV+9hG2sijGjHZAXlYrUq8GmztTd4JkOw5b17uohkSXMixP8m?=
 =?iso-8859-1?Q?Wu5m3t9MWCP73FEHwAlnx/WivPyQCFHXR1G9VyK5BuO9YM2U+rqnGZg/Bq?=
 =?iso-8859-1?Q?qAf0a3vQj6qj0nqjGZguNsxtQDWwvkq7dE6IC9eyPA7PPBTaCyy8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71d8d8d-7733-4721-0b6a-08deaf38adfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:38:28.6980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l9513Kszp3EA+ytLP2AC/+4bel7Jctk0Re7NImlgVt4EJVCG8Q51WY2/KtD0pBO39aSiPwz/f3v+nXVaR7pihNw5Xf1mpmrbIqccV77SEPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR09MB8695
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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
index 9086793b7a..37b8f3dfa7 100644
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
@@ -262,8 +284,9 @@ void riscv_load_kernel(MachineState *machine,
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
@@ -406,21 +429,32 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
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
@@ -489,10 +523,33 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
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


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A06CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMN8z-0002bW-S4; Mon, 11 May 2026 05:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7y-00022N-Oh; Mon, 11 May 2026 05:40:42 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7s-0001RA-34; Mon, 11 May 2026 05:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNPkvHfc4L1e0FxrMDjbd+zFDLVQXTkMLvvViXGFo986jfbgmuMDSSxnMfrrOM/2Gju6PlUVC0fWne/TsmtuUq47uyb1xjLgvmCcOo4zTefma7JWx4K6vRLDny5zbGGgsP0JnuSdATkxyLg8nofoFVTxlfCRQxrZrpVg9qEcJuuV/umeIO9DFTY3yJjWuXwWiM3qbQePmp8t5Fx1bxjUUSe+NmId6bputwQ1gqrdylPSRJT4r4ZkhAOznLh9ifY3J7+NllwZxQpclAFK+9VDJWuvvYn5DmaUKJ2btAnMV/6LUZpHf8B/xVKrf0sGMfXxMDADz7zZE4Q6qqGV3sijmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE+vNn8PeRI7wWwMRGxdRaEYX3OtV4cGGq5kgSl1Pw8=;
 b=IZ0FxW0J2wPlhVE3mF8gkPE6mCcYAghXr33f7l1PAv8of8bM4aJB0oMjChYFQqEFxDH7fE/3v0ElS488cMlF/meSrpmDFMYH/F1PS0N6Qg/s3geVHOzZrbTlMhBWVu8Q0wMQivNp+uMqhb+s6KLM1RsS0So+dvapFz1yQVHtxdv2NdH767DQkxvgbihr6dZfc2X4kE5akl3H6/qlGFwnXCXRMefFkWoqWD8BayPlWixxCApGIyT+SpbzQhqv5JRTLGExGOXOyeK8mIn71Ff3eRFdirzISGffxDThAWtlqbxDpmNO2AQ8AYczVVkJ9d1ZOTPEmMk37jcOLrwOfpVO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NE+vNn8PeRI7wWwMRGxdRaEYX3OtV4cGGq5kgSl1Pw8=;
 b=ISvVrX/HaZNQQ3BOuS0LMkngjk5qiqCMTjYwTIeOVnvdKU9BTj2GI45pDXlbsGuSrgTMat4kzUwCKBKE3RDK3K9t210WMSZzhLLY8z0ZQFb+kYoONPfyWEkyGpkTvjCSv7QhNCtb/K4BJRpUgeyKLSIa7oIcK+P8YU2nvBpokn2ooQPyfTea8H5V+rzxL9dCIuATWhE/1WU2dtpSLPeeJPNyxpqSoaZVWNMXMEm7qfhEmltlLWd99SBKAIR7JcC+4exATdb9hU+XV9AFzzQAcwVE/Dt44HLYDEDFt47/4/EcY7r4yrG8lPAs0fNBHCv3owhon2Hd+pBzo1zFqVwYkg==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by DB5PR09MB8695.eurprd09.prod.outlook.com (2603:10a6:10:64a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 08:38:28 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:38:27 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 2/7] target/riscv: Add big-endian CPU configuration field
 and reset logic
Thread-Topic: [PATCH v9 2/7] target/riscv: Add big-endian CPU configuration
 field and reset logic
Thread-Index: AQHc4SGJk5eCu/l76ECEfDoZcXRzkA==
Date: Mon, 11 May 2026 08:38:27 +0000
Message-ID: <20260511083819.206216-3-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: c6320fb8-a5ba-46ab-2640-08deaf38ac6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|3023799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: /GrLIeDnEXZbwqb6iQR7eq7ggrknsLizXxR6FfQs7mnCUC4gqOYXKvLlmQI+Q23+r38WZ44w0ogDdSaLnwrGMnNCHhgrUYp4eqnINo/aJVL8OO5Yl0MKKyCJnezySVshceU8wkobbYiGl/es6sZIxskdvic1fsE21T08f2F9Jpc164oIH90LsXKeUBXJocNs6YPprfzqY7IIkfENz8KfEAbbkwtUt1mhPb/Els8Xo89rIvYDGm2i2tviXCfiyYSZ/4CupvYdV9p1nlaIERyB5F0qhFrtX0+rCiuRg4g0CvN8R/7hvfUC+2tsCu9gwIBo2FZlx3YJXkcNsJkbbw081e1rL1wx85b0j26+FFFijFskMmOo0m0nVcMyxS+clAJdUqjB2j0JHk4DP0PMhtwzhu5hACNZbvA/+4bb2Jbtb5XAOU+1SZ46CKZKMJDzmu/JwdmEOsFH532ifUj05k4z3DARH/Fc/fI6ct+zosgbMZ6J6nLsfVwQXGD9jNo9g+MV4FcwJnCFpQWZxwobMW2mfrEl7ggTCy3iKRRj5zvww48d7yfWcAfFlcZ8utoAvsyLbj9PFxsnLX0bOjypA1KVZ3koyAOlzWc7ck9YfuqSfXwW5ktSW1KmCYDsQtKba7+FlCfnvtF5EnUmgBACdAE5dOmGM2aREioY6MZ4Q7PiKezg9T6B91WkiRz1dvDE3OMNZ5wOuIoAuzVG1EPuhC0uovvIR440sGOBTG1U9geKACujOx5NxD1WQgiQPE6afgRV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wsvofMYIEobhs2tbxSCJG5a43YI4HYsp3kZMtFlDBFCwgvE+6ZdQT8KL22?=
 =?iso-8859-1?Q?97KnMRoIUKROf3iiV+rI0KuMghKyyR+/hs1m5+thC8wjEpLadyRuNsMHkY?=
 =?iso-8859-1?Q?CM1vhhG5uLBk0h72/q4+N/j7xAGStR+YeiTftQHctjr2YzVZGlwgmbAGBj?=
 =?iso-8859-1?Q?VKgwPCjrc4ay+tKlUS4W+EJ3ZzMwcYFnCIxLAp64qrDW/WXwXe/0GF6QT+?=
 =?iso-8859-1?Q?akN2VAc3aytEc/YevS7o2XzNCtQwSikQZzvBeFHGGsKXCp2TbboWSxA3eC?=
 =?iso-8859-1?Q?mWIWM5oPO9Thw9sW/JahLGSqRibguoGJd3/Kj4cly4IlP0pVqDlthSOwmh?=
 =?iso-8859-1?Q?+40nDDi27HeFkO0dxJ8NAK9MwzImGooolTuk71WzUZhvmGNEK3NAAUlEH6?=
 =?iso-8859-1?Q?YNwU4M3ZenbIStg7VioNiXxdZJrePi9vQsBoO4O9x0Pit9ztRSK2DAGAEn?=
 =?iso-8859-1?Q?rMQ8vCpJ72IZEcESTKFGhpcrLCFYRtOBPCiUgRnQlHmxvJlgGPPrN7wE3K?=
 =?iso-8859-1?Q?M9s8Mh3Bw0INYXjRvpbLl9nwt2l9eQu+q2pL6M7E9YAqo/WE8vII+17dSV?=
 =?iso-8859-1?Q?+210KP0Vf/ByqcuSD8qrcfe2NoJmo7EXkv7OArBzOWCCyHPcQeEjSVLB2t?=
 =?iso-8859-1?Q?FxyyG9+P6Sty0hJGGLj34ZmnknVUj/5TYzgCDQuLvfUM9lr5yAVk4jqu0h?=
 =?iso-8859-1?Q?vZ/tgGnZMzhvDAQp//L1HKHs0bIU4Ng9bhpK/JpznDN0PQoApex0+JvCDj?=
 =?iso-8859-1?Q?LhlZczuFlENJJFOfstRYy6segylBqXSlBEBCSYsLSCmJNIZ3BDikFPD4xa?=
 =?iso-8859-1?Q?nqmohJzbEHBVuFxIu61pYH/9wFd0GMpE7SGyMXPwl+Z+KM76a3SElhwF+8?=
 =?iso-8859-1?Q?Ogvsu9OcWaGvQqjsuL1lkGu22E2OjjhY0my8aUmb5OLxDJhbS7+gcWaGVR?=
 =?iso-8859-1?Q?+kdIdkWyPUWmgcdFZjLMcEIVC9AZSLo0cEa3kSEM5FtSD1M3BegSN2+3Yd?=
 =?iso-8859-1?Q?lfNegWPz22/e/o0YJUbpcUQ9mp50uimvUIUhd7apuQ7V7MIXNnSkYT+Rfz?=
 =?iso-8859-1?Q?CFFfGub3UZNiaOODRi4O7ZL7ZFJvPxQCjBYRUgAyJ/J34gGkoZR0SQzk6Q?=
 =?iso-8859-1?Q?eJuR7TiwJKVhQ4NGYvXyLz/f6ek03ZvD07KzDUgN4+/zMyEk4uFOs1CGYk?=
 =?iso-8859-1?Q?ll3NM9DjiMw5296Uit+XXmO21iebAJ0dXC3Y4knPZzdRVcpLm3q58Q0EsB?=
 =?iso-8859-1?Q?cFnaA9wJxq3muv6u0e4i7YhxRl9XXBZ9Nlq2BvsEAT5WZxONVL3CVhU+q8?=
 =?iso-8859-1?Q?glM3dk49XO3sNXUgWKCPSMWBUmweXvDT2DHMxZBuqR9kVyEJZbtsWcwsEB?=
 =?iso-8859-1?Q?GILkn0y19p1E0+9hQ+HXp9rW7zrOtR+PoCCEGmtEhceXI9Nr9SLSPnPWph?=
 =?iso-8859-1?Q?Hj6o4Za4f6FrFXDonKvM0PMv12niKwi51CliGacerAZp2Zoe9EHyiKMMk4?=
 =?iso-8859-1?Q?SR084kyDdKF86lvWpLoJJSKUDs4c5J0BZcNx5nYNj1d5xBDRZnGopEi+5h?=
 =?iso-8859-1?Q?mRlmXGRdyTtG4H/bUGku7+czeJAh61w9btT2dFKtJjtPAvkJsKy+QcvTPb?=
 =?iso-8859-1?Q?DgJWB7GYgpA0AGvsoANdCu0PU51pZZlWK3Ezo/P4t+PZpvfv+713IQzS9O?=
 =?iso-8859-1?Q?ymRUYZeMl8SKL7rghh04ywWGv/mT8UW0hZ3975YGYl3STcm1Lhv4qiEk61?=
 =?iso-8859-1?Q?4cz3/QbFxMOkJMogkXf3+a5yjoKQerGWQFiAU7EaBEEaEUodPpr+6r72gg?=
 =?iso-8859-1?Q?kl8gP3WxRs3czxZvTl01tw3WmCKWIramer8ITV5Utp9DEDqNYnYz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6320fb8-a5ba-46ab-2640-08deaf38ac6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:38:27.8601 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2QdzdCuLzYKHJQpCVaeXemBa0JrabBcWtbAq4qsJwddPwJgCTF5zY3XUGUNegFOU0lOzKb3SnubFhRH5V9BYJsM1IhIqObW6ZXg/EW+Rdv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR09MB8695
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

Add a big_endian field to RISCVCPUConfig and wire it into the CPU
reset path. When cfg.big_endian is set, riscv_cpu_reset_hold()
writes 1 into the MSTATUS MBE/SBE/UBE fields using set_field();
otherwise it writes 0. This makes the reset value deterministic on
both cold and warm reset.

The MBE/SBE/UBE bits are not included in the writable mask of any
mstatus/mstatush/sstatus CSR write path (unchanged by this series),
so the value chosen at reset effectively hardwires them per section
3.1.6.5 of the RISC-V Privileged Specification.

The user-facing property and documentation are added in a later
patch, once the full endianness support is in place.

Also update the disassembler comment to clarify that BFD_ENDIAN_LITTLE
is correct because RISC-V instructions are always little-endian per
the ISA specification.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                | 10 +++++-----
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37..ae75019186 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -720,6 +720,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType=
 type)
             env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, 1);
         }
     }
+    env->mstatus =3D set_field(env->mstatus, MSTATUS_MBE, cpu->cfg.big_end=
ian);
+    env->mstatus =3D set_field(env->mstatus, MSTATUS_SBE, cpu->cfg.big_end=
ian);
+    env->mstatus =3D set_field(env->mstatus, MSTATUS_UBE, cpu->cfg.big_end=
ian);
     env->mcause =3D 0;
     env->miclaim =3D MIP_SGEIP;
     env->pc =3D env->resetvec;
@@ -807,11 +810,8 @@ static void riscv_cpu_disas_set_info(const CPUState *s=
, disassemble_info *info)
     info->target_info =3D &cpu->cfg;
=20
     /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
+     * RISC-V instructions are always little-endian, regardless of the
+     * data endianness configured via MSTATUS UBE/SBE/MBE bits.
      */
     info->endian =3D BFD_ENDIAN_LITTLE;
=20
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 734fa079f2..9eb47af0a7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -157,6 +157,7 @@ BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
 BOOL_FIELD(ext_xlrbr)
=20
+BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
 BOOL_FIELD(debug)
--=20
2.34.1


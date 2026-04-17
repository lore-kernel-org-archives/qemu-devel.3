Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7F7F436B5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkVX-0004q8-AO; Fri, 17 Apr 2026 10:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVV-0004pg-Hg; Fri, 17 Apr 2026 10:49:21 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVT-0007Cr-FR; Fri, 17 Apr 2026 10:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzQQEDXmfQLr/nhSt+Nz9ZRAumwzMzSl1mzYPkklujw+LKw3FGKERh5LTOZL2Nxh7T9SiAOfNXoyjI9E2LyMZ6wZ4sUhdrQY4FPEpiGj17KNXWiEYoMd3qmD5g8FOiYrKhvjqGz91l2ZXyFwNx9CN4j9q28vhq297sOdpWd2811u5vXBhh4IPn9ymTjA/ug6H/imyzVvQw9vxffmt/eYLeZeNsuRZ0suHpbtkvclwIaWThAA3nuXqFrGu+TG+qrWeyL7f002pvVk5kkVbtuauSb1ZtVo/HEnTchQh6Qvk+tBAw6wI4J87vEYTIOcHLQw21HXmNbF9idsrsND8oceEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBYaelYJnDEOxuGQ6Xgr1D3xcgv6OmmdjvzXthya7nc=;
 b=G1ONxqEm/i8OCtf7tBr8JaUnH7gGIybl9SBf7FfK3ErABN1HxPME12p6gEGcqTm3DuMSAGUssNmUlvI4+2xrngHmI/1EoQjIJKIi5q7Crz0E3aXFfpMj35VQdnUTTomzMqcIqqQ1UXSfsl88CS5QZ/kKi6s3ptc59uPxRUeB7DfKEc2p9kqMdBOZ1lW7b9R9wuHp+wvqoJqy0mK72w7xU/U/k2tdYJXNuqc0ERPXx0qnNKVRejnPZq7o7k4QWgMNWpOk4PPfJIiL+XknDjqc26afDXnh1YsdflRbTcXd4ktDtk0XiZ0dbFuQHMzfPyjFoYY3v3QRboZ5nPQ3OBvn5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBYaelYJnDEOxuGQ6Xgr1D3xcgv6OmmdjvzXthya7nc=;
 b=IaDsdenhicKZu9mshvThwjmgYWuMWOAnXyJ4tWQQJ9ev9MPUChTVPPiHpOqrX/BvTDFpzgV+lylB+hOJf4cVHrh7AL5MX4XM7tr67n/EermCTQhtLycQ/9zJlCgeFtOG7FpIWtFoiYOiH86Z/vmqHen/+LS5AxuVognME1YdEU6+jotQ5PhedAfQ4TNGjFLxfF/Jtj2GPWseX+GO/Ms7xHRqzusgG7qBqv2DpAIl1D/OZ2G7IA03kcC4N6gd3Z0BCUNlBdOui4zloDQkS52Gb/qRZBMnP5OLbupqRS71zRAAf5ebS8IWnD2od0rD4BV6eD91h8rnqf17wAepkyDrSw==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by VI0PR09MB8150.eurprd09.prod.outlook.com (2603:10a6:800:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:49:13 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:49:13 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 2/7] target/riscv: Add big-endian CPU configuration field
 and reset logic
Thread-Topic: [PATCH v8 2/7] target/riscv: Add big-endian CPU configuration
 field and reset logic
Thread-Index: AQHcznlbw/aH1evqiU+h9VFuIPcTdg==
Date: Fri, 17 Apr 2026 14:49:13 +0000
Message-ID: <20260417144905.178056-3-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 5e64bc24-db2c-4eab-073c-08de9c907e09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: LhgnDzzCTfGcw0bQJIr2bm9coXCdeT5UgVYZ0Q4KGYTpVZi9+x/PEQZrsUTbHmvgPp/5I0nKmn1RVMXOy5K15kiUk3b7LKQrOmrlct6DCrwiAj7gNhjlMUiMDchW26n3huuqPFO4FGuYx0mHeuDC6XvOjplZ0ZRhB0Hn9HJkxUHO1bBUrlPYO9RGMciYUO7AXoxZy2xH4JGnvioXY3ZIk1ZyZEKyUL6IuB+W/a12weOUr3Lq+dypWl0PX+3a7uJRx8ATm/eMoMHxSZDZu0aL2qh5oQg59y7qwjbnTTF1MqDEJoCiCz1Qw8DHT7yC6qOTrqCh1lPWPFGyBpV0/JYPdcFeboj+HrjABeG1bG72b8Cb+zgJUKrTuDI+50RfuuyWpXxpJ7XHL0GirjEAIk6JT+AXwcyz6upqVtBrAlsADQZU/OzWF779i803rD7isZgdCxts/tMjMJNGxB5/5hmJIJo8dr+ImNep2Vx+zvCB6c4MP7k4kwi1FxcGKfPtJszdIZvH6XyhUszk6XX4lNad4Zec8mms4SX3UsJ5wS9pI8aBkE9z5rEkL09CO26/nS7pBLakY4Y6ByEoitP1Cm24TLQEkK1f9nz5uCEG/g9GngtLFsEORs61sDF+WR5Rg3GQjVcNQtFYjR8K8tzPXtkHcFouSyrsjA3jOAOStJmmWsRDZGqirkGHNos5JmOLSr44/X96r40N2BwO/MPzyf2n+u3g7pDuNXK33krVdR1HZAstjhrZPvy+u4StU8r3FoYGhEfdoGS+73mr9HbciBWtmsFScZs0yq3OxNriGCW8zr4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Qf+4Kcr2fpEzsVUQBOFd2zzdz7aqbsInn6APbDRRfJe4tPC/VlkAoYxdBo?=
 =?iso-8859-1?Q?1l3j+bdnoVGROz4QXNntxYU06JVDWZdIyrWcLIxdFGgXvCOZxlIicOYUjq?=
 =?iso-8859-1?Q?c+YkUFa4m+phIqg7bGRV12QmOKJhgaxMpNxW6aWCfRVFgTNo9Q1mfi1dcX?=
 =?iso-8859-1?Q?ym5abecjqy9a3vhwVLp26FR8Xz9vd++YaVgMdJMyp0iMWhgmFQ8a5xL3AK?=
 =?iso-8859-1?Q?m0gQn+bM9oIArBt3h2Q1H/OmmY5fjUrr0xB/RhSKdxr+exuyl0q8re+HEW?=
 =?iso-8859-1?Q?k/bM6v2y8HpXUreghBRhT4JNanxdgLq/TPwx9BFayUq/h+2gHil0Fnasur?=
 =?iso-8859-1?Q?AGat6MWIBbTlCuzIqcyNYndZtUEUJ05NrmpoU04Z2xA100TXqW1b+1x7J+?=
 =?iso-8859-1?Q?X+UsLVtHE97Cke1DRUIqmCDKh4kkLLjJMFb0NmWo6PQffkLsjPEjau5/56?=
 =?iso-8859-1?Q?25GbE0iBgSZH7btYhUjyfgQyN0YbMgwcQrR7i+z3i0957+pljLCqorYtJm?=
 =?iso-8859-1?Q?3+gh9tuF1ldhBEk5vs0Skwg8mOXrFo/c6D8QBkTwxizq8k41T/UjwUuwZX?=
 =?iso-8859-1?Q?rMlEgV282YR5CwZbOJDloN+/xmOAeXBwaip3TDuKHcRWidix7PTAMuE4oL?=
 =?iso-8859-1?Q?CG4qjeeC3tRa4e++bztkVb7/q8uU/2YBsImo+MVFYfbqTtDKVkE3rWASoU?=
 =?iso-8859-1?Q?lM3ZDGIzgFqJ5PwitiT5qF91xTa/zXy4uPtEQC1c8sT32SokOP7vfhgHgl?=
 =?iso-8859-1?Q?32iIZZ1LvMQgC1vXdyMijpFiAZc3J+JJVYwvB6OvjEqEq3P+DuHWYG1lhD?=
 =?iso-8859-1?Q?iowi4XKCW325vvpidk6PCKjPcF1oMqrYI8YQCyLIUPvLn/MTXXC2XBk6jp?=
 =?iso-8859-1?Q?2bzVbjerYxb4nNwjaX5rt1l+mJ1OKdg6B6VbglBdNjvQYD9dljEdW60g4/?=
 =?iso-8859-1?Q?rOqBi8pOUFGzOGUaJTneRKm7NtkYpFScv00sbqqtGBB6vsbHzwcV66Zcvc?=
 =?iso-8859-1?Q?rnKj/zGqx0XePBTtNnZl3n5EupCnD1CbfaWxi4DjzzHUmAJQFJSpVy68xP?=
 =?iso-8859-1?Q?EfY/z7zolThpBH0xp6sizvT3JXJYzxIS1sbVIT7iU6BVlylYul6oqG++C6?=
 =?iso-8859-1?Q?iiGmJW0SZzZY+z4Zbb9vz4MTQ/3s/jXaAereewVH73iUyLAXx4Q5Ny4x60?=
 =?iso-8859-1?Q?dMcL+MBHsrSPSoJmPd87kmtKXbftYbdQbtMcM4LJFlAGjKrg+/MEE8jJDW?=
 =?iso-8859-1?Q?oFCsc9cjWG5PJi0TmqzuS7NUAhFfNzgJfQv28ji9ZC99Cu9px1VL0hg4nl?=
 =?iso-8859-1?Q?LP6KGBhrtj3zWD5Z+JwbFAlb8AfxEjArNrVGeVIn4Z1P81QlFuX5uGdvpE?=
 =?iso-8859-1?Q?9uGiOX/pPITMEjRNE4JbJHff3HIQq5aQ30BI2i/o8zb4HarD+JKtO84zPm?=
 =?iso-8859-1?Q?/NbfONgxxkIC9nr2BNSJb0HCNmDfZhjw4j6BhMzMCiDX+ZzPiBe1hbinOH?=
 =?iso-8859-1?Q?Ub4VId/jERa9JLLTGJN/zdM+OFgDF/ojZU9JiS13aMzgil1JluzxAziAkn?=
 =?iso-8859-1?Q?rTEENg2lPHea8AvpFPHNZtg3Nt4JX4ikkrZIsFVom4stPCcgF5kxvvHJ7J?=
 =?iso-8859-1?Q?pAUwFFjj3QeBrnSlPMDHOQugo4Xd9qKV7BoBqbGRG/+GPnOaPBPbJmFJz2?=
 =?iso-8859-1?Q?H4mDjdAaO0u0o/M7s0i0JutOj7B14Eu9ydNODgUuQpJDZJz/NbKvLNBtxA?=
 =?iso-8859-1?Q?HvbWzoU32tjv3aNQEeUTKpj2CYyPsbaYU8zU0oUeuk/tY5hoLlbCnumSdH?=
 =?iso-8859-1?Q?JNfTIXpiv5ao642nrUyI+6oLvNDeXwwDYreKPWmIpH2+VWSlGEic?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e64bc24-db2c-4eab-073c-08de9c907e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 14:49:13.2220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMDusQyeC2T1TyNIepe4zZsx8IWr6z0DIzGvxYZ9cax9sSCTsMkjkErtKJP1FpSgD5jHA/CVWekTcLFmYk5wPPsF3LzRKHpJRxDlYPEWrqI=
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
index e56470a374..a32e4fd6d6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -716,6 +716,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType=
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
@@ -803,11 +806,8 @@ static void riscv_cpu_disas_set_info(const CPUState *s=
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
index 70ec650abf..51436daabf 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -154,6 +154,7 @@ BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
=20
+BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
 BOOL_FIELD(debug)
--=20
2.34.1


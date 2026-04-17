Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4EAF43689
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDg2r-0000W0-Fa; Fri, 17 Apr 2026 06:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2l-0000Us-S9; Fri, 17 Apr 2026 06:03:24 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2h-0006gN-BK; Fri, 17 Apr 2026 06:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJC3MFnwTSUmaAHRdbmjxeG2OVmt3bdEMWcOlOi73ft2qpWyRUysVWcnUfVJR8dfxnHJ16HAkXVHDh3rNIrGSc2jlT12eQIU9X0YpgtONK1WGnVqExjgHUh31qFNe8xk7QEqXhG+nfdZIXxkELY0O8sdNLkOi4y/GoPJWIxEH7Qr7gYV6WU7AO0dFIf0MxBj08QjODn3y2FCbjsbhBU6h78drCq0IUuet+8JBTB7viQ6T47gFmRQhfM8s3O33RG70jdLY9twlvg6LRh+4z9glGT6dqb3IapZwgcGGE3H7k8pDV0QuLp5FsYb+QaT+KDz34mKqOID5Rd3aHWknW1cfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyJTcEOGqZbsM/+0V779RHADg7sXv4dYp7g8aLTJ4/0=;
 b=eyTGbnIabCzJdBWJf4jUu0nCGbsHJAHk/YmCgDGURXRr/K4b4ygK319kpXg+WbsYNtZls+GyB/r3itgA+GJx9mxS3qh9zZncdpvToAZDisNzpsLmYd2/3R4LaLpLFg9heoc+NA+oXDGegZNoUc/Teya7VJQaXqBoEai5ioLYMZigfaZD4UE+IZFKBdlc/7lP9RR5BpyngxlHjtN46rDpE5kXmarOSwc7Gs8Q0vpKCMx9c7eO6pA0WSFaPZl5arPWppKmsOcOPb1OhpIc7J8locmrQV6fE2KG3S1lC1vuhgJxlchGVHOznKj6QVaIdXbQxbw+ZIaNM8jcfSMaEsBZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyJTcEOGqZbsM/+0V779RHADg7sXv4dYp7g8aLTJ4/0=;
 b=sImdi8ynPcTMjRpLj8gMAMJxtXFLIyBMRoeLGXEiWhz8BU7LGtMLn2aN0LK+0uh58t0gAMJTA2GJTJ2Fli7YtB1n8nufXtyMTkpuzWmrLahhsB6vwMAdLnB1y8Y74Urt8M5pgg+pGG3rfHFeGdvN/DyGc0okCB1Jb2VpFU0RjNaAyyJv0meWcX5MK7aFapwphuYz7mIwDtcBY79fRUEgaZrKGtPueL1aQ1ZPaHv9JnLrjI/HnHA0wVQpEDB5AmfkPEnmdBlhc1+UWrxD280bkCboYNOWF8EdQZVdSh4eC3BLimG0idXJA2JTSuHKhu2AHIyO1o906lRKPQDJHxJUdg==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AM7PR09MB3736.eurprd09.prod.outlook.com (2603:10a6:20b:10e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 10:03:10 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 10:03:10 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v7 2/6] target/riscv: Add big-endian CPU property
Thread-Topic: [PATCH v7 2/6] target/riscv: Add big-endian CPU property
Thread-Index: AQHczlFlSjRd9usdwkWfBofvuRil5A==
Date: Fri, 17 Apr 2026 10:03:10 +0000
Message-ID: <20260417100302.162260-3-djordje.todorovic@htecgroup.com>
References: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AM7PR09MB3736:EE_
x-ms-office365-filtering-correlation-id: 0bbda141-0cd9-4f07-4da0-08de9c688803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Viu1cTvFPVQgfeqv54dIGLvXNYUYx5wCZCmEw5TP5CJoaxHDuZLGLKgUcSgYymjGs0JhC8DafoBm8RxK3VPy3k4yzkoj4He7JyiivCR9ZK0DVC8zNVieskHt5kxPVy7Zur8hdHQzPzUD44ezqzi3ncPdSGtJTQ0dLC+5d7BqwCpd7/Dq/n7a7wlVJ47pCNuvkwCZ253ecAt2DW5cXDXOJg0uiTb8gd7q+kkXu3xZ0oNgXi+cMVxHQ9MMAPdnIe3FlShMLbfE6GdTD/XfvWiCpmocj210rt9GwS0syA5/0XT8Yt6zsLvV32lnqbX9lsN+AlwWxf4uK63ZxkzhUqFhqua1wTP8QMKkj089hgc0p4OfbY6ChnF8C/08e4MZz8F9VeKsTnwAnt79MI5+qagdb311hk65CsCI8q6Wl1ZBG4slfchIVBbnug0MgHs+SMMoYSp7bhGgs4Atdl/rGVwwpqQiX6ZHNW5jRdOonlSye/Vvh6CbKG/vkgIuEZPfg2mjIJj90U0kj/M8MtJZCwWjSBWUuWPbjUiienhIgewhpknFLTU4/tuScmHeAJ/eVYpe4BoPn7wrgmhjdERtHNv4SVdZwe3WyhlJlp7igsNESBsv0CuN0H6kGlDO1bJs/n1W6bRF7umvzE/jyNdAmI0BRp7tCchF52XqMb14qYKYgsmwJuUaOxH6WDftNss1a8yz9MKa8lMx6PZnkXD1wYa1HTtjM48xBmnJvYPi44V2klwgKZYi6O0L+LmWvxRrUVvPTNs1URCTv8yvY6y95lu/qiS37L+jDtZ/nqwJMcWTPPU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qGCdG9ZRKXMmNq4PzKa2Sw+a+4bgeizwj0H5ZusFp5o69Wp9ZF6gbu2YwY?=
 =?iso-8859-1?Q?zETRL1UT9TOTHENdDQegAMMF5On7hgfR4jnw2OlGGJB4zWDGhX6VdN7yP9?=
 =?iso-8859-1?Q?ada+ZK/iWpXakK8r+6M98zxa04GL+MfKZEvJGf+EhfQLPf1seoydZTWC5o?=
 =?iso-8859-1?Q?HfS4cgVi8MMra+PsWLqpjqwC0hFqRVRqUETjqQfxMtagaKDnyO8nS9PKxY?=
 =?iso-8859-1?Q?zM9DJ15U9HY2cUX+/PIaU4kzw8IokL6harP7rl1ODpXICgBfJXvSNoYcfz?=
 =?iso-8859-1?Q?sVQ1A3o3nz1tD8QaBwyEqP9IOmDwRoa4SSBr6K+jwSdn/gSc0IrDk2CbJo?=
 =?iso-8859-1?Q?YDG4LJGnqPWKa7KBpUyyJ/MhiLxPjhfJB0K4TyVpRXG5KzqmMy8sn6kDfi?=
 =?iso-8859-1?Q?yJH5yNiJW3nSi73zGEhZNqGmfcvyu4iZpQ4XeCusAII6R8Lj8IqeobW5B0?=
 =?iso-8859-1?Q?pcjTkpFUBg/AYR619iPxd9FLO4QIIkMwIaDzNcMydViBYq87jgoicCol4W?=
 =?iso-8859-1?Q?n8v0FYxe22T4ymmLNd48Jtz9myQMasrApAU+eNLXhRBPFKBAJQQk2Wv6jW?=
 =?iso-8859-1?Q?YtFdWWx8cRwsWsFg2V2kjMbk1OtlDTpON3XKVK55BbvV7ny2ijL/CRMSzh?=
 =?iso-8859-1?Q?Edee+TdDaL5edx7gisqj/JvigbnA2/Xuz3ytX4WwwFqjb78VpKVxqccKHl?=
 =?iso-8859-1?Q?qbEFgveD9IrB6uQkXIqYJsTS/xYiW5qSETDsUHHmYYVRGlbX9sGrfmbvRS?=
 =?iso-8859-1?Q?eVcuRRhee03yNJnC5D4UpkOLtXCnAWLSZO8AXMqlcRgBa0rFMsxgYrBqSA?=
 =?iso-8859-1?Q?3FZXqeF6vuPhL7MTz9Wp1Uo//1ChbygMqCVU9voMxRBDCa3sSzx3cIU4vN?=
 =?iso-8859-1?Q?eTFk6WISEByEgwiOi9DG/Lsb12rArw+mpULl9eelc24WDzkD39J6QefBqA?=
 =?iso-8859-1?Q?5EYfe6tMmDrZAqxQwhMFd3DDD745WpmIlWCoghELogZbQx2QTrkrDGTx+s?=
 =?iso-8859-1?Q?qvIByskG2B3hPPWSrbVs9dXOuAAUY6ULHjMjaQTtdJkxEd79he6H6Lg4Vb?=
 =?iso-8859-1?Q?Z10sxH1CeYiMl+rhJmrWo/JG28UpJ7A5olHxVpq4pk6LWIM1CeBJJrc1Pk?=
 =?iso-8859-1?Q?DGjnBcMTd4301F0OD2Xje2MFIVN9bfa8+kIB4wl9BMTjn1iTl2R9I817Kn?=
 =?iso-8859-1?Q?gmgLAd9M+y/AscIWRXqED0wcryXHguXG7/thfzduF6LOQ89hJhxmCqlQSi?=
 =?iso-8859-1?Q?IFakN6je2OLKok8EQVjywcvIj73S2bEbxjIqeLJ30ul5jD5J3FjHwdsjfp?=
 =?iso-8859-1?Q?K2Io3d7hwKK8r6ge0Ho26HfV02Lwy+vaGjrbhLaRysZ2PnXYeN/u69q4PR?=
 =?iso-8859-1?Q?wUEvihDVLR1995m1zA0f9JZ+PV9XX0V8UCDVP1t9UyDCATNmZuwipElYFc?=
 =?iso-8859-1?Q?e3VkY2xlx5kDtuK3Lk6N8qG2FKcU4QOtXxh10aeW3lALRyiKd8xvYLY7P2?=
 =?iso-8859-1?Q?gWh+1wZrnzhqD8/h05uI8TO6WFhos03HfuYqk5Bar4bMdynF7PNT5qstOs?=
 =?iso-8859-1?Q?xM6xhDCFWHiDGhzjGhK8y4ogVGBO0k4vUC4uAG0upE8EFR9dw/sKJs62D4?=
 =?iso-8859-1?Q?9a2OyPAE2f4pjYzu2e4HZ+3r/kD6ZMBQSAY8w4ko8OB1RAgx1VQr8n42Mw?=
 =?iso-8859-1?Q?Gpl0e+OT0aeeVE3dKO/wd3qKEX4aoR9o6pXbnY6vRaCuvY55qQ/zDfYl9c?=
 =?iso-8859-1?Q?yCN/FfrX5tLtGzRmxyaxH+CD7Hirl6wOC5Z8Tjk/Rb9T7Pou+EroyJ0WQb?=
 =?iso-8859-1?Q?v9rNQfUk4sNRwZLsWrB1fDy3hv7MvT+msn1z9cSgD1odTidMIczA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbda141-0cd9-4f07-4da0-08de9c688803
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 10:03:10.5052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /T/f0nD3KCCBK/XQNRLJ/SQJiO6AVhyaPPhc9CL5ULCCHJLRu8UypcF79Hs3QHxDj8Eb2t48Zy5vvSQijW0hCW16BIEB6icmCMjk1r98yuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3736
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Add a "big-endian" boolean property to the RISC-V CPU configuration,
defaulting to false (little-endian). When enabled, this models a
big-endian-only RISC-V implementation as described in section 3.1.6.5
of the RISC-V Privileged Specification ("Memory Endianness"), where
the MSTATUS MBE/SBE/UBE bits are hardwired to 1.

This is a static, per-CPU hardware configuration option, not a runtime
switch. It is intended for modeling RISC-V CPU variants whose data
endianness is fixed to big-endian at the hardware level. Instructions
remain little-endian regardless, per the RISC-V ISA specification.

When cfg.big_endian is set, riscv_cpu_reset_hold() writes 1 into the
MSTATUS UBE/SBE/MBE fields; otherwise it writes 0. The assignment is
done with set_field() so the reset value is deterministic on both
cold and warm reset, rather than depending on the pre-reset state.
The MBE/SBE/UBE bits are not included in the writable mask of any
mstatus/mstatush/sstatus CSR write path, so the value chosen at reset
effectively hardwires them. The actual effect of those bits on data
accesses, page-table walks and boot code is implemented by the
subsequent patches in this series.

Also update the disassembler comment to clarify that BFD_ENDIAN_LITTLE
is correct because RISC-V instructions are always little-endian per
the ISA specification.

No upstream CPU currently defaults to big-endian; the property can be
enabled from the command line, e.g.:

    -cpu <cpu>,big-endian=3Don

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 docs/system/target-riscv.rst      | 24 ++++++++++++++++++++++++
 target/riscv/cpu.c                | 11 ++++++-----
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ad5d1ddaf..7798184ebe 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -95,3 +95,27 @@ the images they need.
 * ``-bios <file>``
=20
 Tells QEMU to load the specified file as the firmware.
+
+RISC-V CPU endianness
+---------------------
+
+The RISC-V ISA specifies that instruction fetches are always little-endian=
,
+while data accesses can be either little-endian or big-endian under contro=
l
+of the MSTATUS ``MBE``/``SBE``/``UBE`` bits (see section 3.1.6.5, "Memory
+Endianness", in the RISC-V Privileged Specification).
+
+QEMU implements the full data-endianness behaviour described by those bits=
.
+In addition, the RISC-V CPU object exposes a ``big-endian`` boolean proper=
ty
+which models a big-endian-only hardware implementation, where the
+``MBE``/``SBE``/``UBE`` bits are hardwired to 1. When the property is set,
+the CPU is reset with all three bits initialised to 1, so the guest starts
+executing in big-endian data mode from the reset vector. The property is a
+static, per-CPU hardware configuration option and is not meant to be toggl=
ed
+at runtime.
+
+The property can be enabled from the command line, for example::
+
+    -cpu <cpu>,big-endian=3Don
+
+No upstream CPU model currently defaults to big-endian; the property is
+provided so that big-endian-only RISC-V CPU variants can be modelled.
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e56470a374..c39500cb3f 100644
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
@@ -2641,6 +2641,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rule=
s[] =3D {
=20
 static const Property riscv_cpu_properties[] =3D {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
=20
     {.name =3D "pmu-mask", .info =3D &prop_pmu_mask},
     {.name =3D "pmu-num", .info =3D &prop_pmu_num}, /* Deprecated */
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


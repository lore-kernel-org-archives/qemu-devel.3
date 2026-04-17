Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FF9F43689
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDg3E-0000pR-7q; Fri, 17 Apr 2026 06:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2q-0000W9-AP; Fri, 17 Apr 2026 06:03:29 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2m-0006gN-QH; Fri, 17 Apr 2026 06:03:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkL2AbZ3Qvbb3BJa2po8NGGm9KCi2Iq1FcUa0snHfGXDbCn2/zriS9UTDRKJ1idWaUf18MP57Y2sxwv2aE9HVTDVYghy274JaO0Ied2G65ehut5RlquBBnCdtFd7xLUtYdq567UFkkU7YU+4h+8tsKMraWgy2NvtObfdXaQYJuuqWe2i81s9K/y9MFTy2IwYa9qEifWxREF6TPBtOohkVsnYX0Nv5ZKJvYd/YRHoKKhpFIqFvWVKoYIVWPGEoTAsFB6c8lFpAZ205sItcSUCRghcQ7LAx6bXUVhC58JFCuZ2uRk8mG1vuwkzPCn65RdSmmFJzV9Ndpr8oj+GG9shOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oay11mJt144P7M4ouoSi8o0A0Ae8BlhXt3WQoUaRJI4=;
 b=HHnSxKCHkEGXqwGHJb2e3bhKASZM/Pir/QDNmAAeiYTeOhoIULygJHwL5ANAyydSsnLJ0OXt2RcaETaMYBWktvTWEottO1GVaop5TgF+Or1LNAyQ4u/9oPvhZhG0tIcxdGN7+6mVZUi1tLVlQsmDs5vftcOwCC4qqXWOnjrs9JoZP7B714DwOSzS2d9P4UmaUoOb7/eRO3Q+kBQab3PrP0BYC5SqIJYqbIcIl8fA3QCBlryCnVvFqJvoCo2kzfVX6kzhcX8J2kIZeqZOINlaYietPCfckBIyBEtnwZ9SscAFm93H7U4+ruJcqSypGKuuGP+o2CnZMJ0OOXjjH8B1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oay11mJt144P7M4ouoSi8o0A0Ae8BlhXt3WQoUaRJI4=;
 b=nahxjx57r94U5ByrJxvxe4chcrrhdJ6ERW9VywMs+m096Fe318pcjhnCmWjiszEvFQi+oail+OSRtVo7Mt/rwtwNr8/VxT+GtUvd2c+FSly8EolWAxXR0M4jWxAWmmLRbgNPetnO3L+ojpQ0GciE58Ta6Lr0LqgJlF/ROh+P87gaYmfCs3V8f1zpUdJck2H8wx35teKOJUeLzEBsW30P8uep2HnxDPrAR7htwf3b6pFmnZ+Wvg9IjZZu9V5DA+g7LJTqIyLd8FYtk5PPLvIdVwATnsEIPoCdDgaDq2DlQtjEhhua+6iPt3bfABpgkw02LakLRCte5DmqugLwdaRSnA==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AM7PR09MB3736.eurprd09.prod.outlook.com (2603:10a6:20b:10e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 10:03:11 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 10:03:11 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 3/6] target/riscv: Implement runtime data endianness via
 MSTATUS bits
Thread-Topic: [PATCH v7 3/6] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Thread-Index: AQHczlFlihUusYngh02OWnt1bDc+5A==
Date: Fri, 17 Apr 2026 10:03:11 +0000
Message-ID: <20260417100302.162260-4-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: d8b61dbd-ebb4-4183-2315-08de9c68886d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: LzTTsemi5WqgT3WVDxRwtpTXQbQtlrdXh3klNC5otqErbhdfCsOPYVlRbaZFIqBdWeuBwyn99GwFSep30bwU+/KhCVrppqUnKkxibqoH1AuPO7zwn63UTpq++biQ0nevIG/nIFck7WUseEhsNmMQ4olL+dY6XyovEMpG2rIhnWpiOOZktrIsjTB+GvARWhGNMhnMSoZGnQF23R/quC3qlYFRIB+x8/Ny1Vd0dr3PmWJjIehHdYgLoPyrJNR+WOusMyCE1IUpTiznuNfLKcvQ/TtJQA5xGoFxGa2ZT8081MFC5kOCawWwViOEwaN0cbAjxmsubYV8ZmHSgX/SXof6GkYLvzx58nQ/IKlAVrRSsn4fQspTF0fkcFc0JH09PWLN5Y44IZ5gc3dG/2ukUir8CQic5O4lwRGi90qADe20u4Phd21Rts2vd91Qr9NCxGkAvL05ZYUS21HhHDdoTWaPbf38sse4aJnfvXUOnRyvuceTy9v+HCd7arrzbR34ZnUyypxhm7bvQRbn55LMmO8QS9dH78YxHe+D4KNaTyjpEzvDAtgl2MZAvI9t1jt1k7DBD5Mv78z1nHZ+O2FhOh2mmTQUtTcMxpKicTfGK3MVf5/3HeB4jWHR7Rz6qZ6xXNQN5SHq4VDJ84Dpc+jx50tAy9aSZqu0q2CZIbN6GZp/1ilpinTD4xrWSJYZGNXclxBsXgjgPZCgrSryASaQIxscBVXRUMONRoR27nX4au8/AUYvAd++9Ynsxer8K6JU1zsY+OcexoMbvDZ6AROVqRMwIOdgRlfW8MOUZxhXBABHPWk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X10p4phmKj5DcMr4P1miNPCPGRVN1FJFP4ZL0FoX+RdFaAjbHSCBLGVzeR?=
 =?iso-8859-1?Q?jCLzP1rdhKTbcltQjMJ0hECG+6V1q2YqA0SQZ36CbkkWX0M6X2gEohVgxN?=
 =?iso-8859-1?Q?uWzd4KCHDd3smsw2Lqronk7l4ntlqfRvyYnDBIWV6EcZD6XonEdtv9EHV6?=
 =?iso-8859-1?Q?clyKPVtlXsA3dfh/vfwoRPLm+wsHX1jKvWPmCPe0e6F7tBf/7qs08AQlhG?=
 =?iso-8859-1?Q?XYRNcwrGGZzZ9OCLme1uppGAzjNpZRv1g51M5/nxMd5nnjwsWHOHlhe2SB?=
 =?iso-8859-1?Q?ouGNbaZD/WGNfjA9nuBkEsnwKGmmDwHqv8rbQA8OAJQZKUUerVgzLg6eut?=
 =?iso-8859-1?Q?Lv0nPgB9kr+DZbbAzBA2sd0FfI7t0zaEmPBC1jS8iVt8ytym4RpWleFpds?=
 =?iso-8859-1?Q?JY1E62oJhKr2qxa+Dnm74vMWwd7j3Paju2+9NN/ANOPYmmBOo5b9JttYBD?=
 =?iso-8859-1?Q?FBr3vYhmbES3TQkTN1fIXGPFJWcmMqDz0M4wibi0hRdt0zxAOzLF8+vXzx?=
 =?iso-8859-1?Q?cTY0KQiZJ3WBfM7FFPCbY/aKFKL2TNemGogSXJ2JLxGo1p1LX3AXWpXCqK?=
 =?iso-8859-1?Q?Vifl1buoSvKafljmV2a6ZR20ZxaRg8Xt6wZ67RSBADeS9gPlEMQzVydlXm?=
 =?iso-8859-1?Q?puZZvfWWT/fJirxiy9paka02mPf7odYGNd+MAtD+uVbdiQ7wkBGRGza7Aj?=
 =?iso-8859-1?Q?VfjNbfny6MLFlnoWcRyZTADvidiIDQRiKqqnLcHFCnacuMbSiFYZ/2Wvjp?=
 =?iso-8859-1?Q?/kZmzMXhiCT3L5pBahl8XUsP1BB45IZ+9LGLqp8wdzv6hdKMJF0WaRb8Qx?=
 =?iso-8859-1?Q?aO47Z0tCt/IBrhA7x+KRpCsrh175FR7tHhvULYO7tmb0/GfAKrogjvGmnN?=
 =?iso-8859-1?Q?uGe0KCETZDhzh7Xd1gtqhYJFsekktLUIL14+nVtUoi8V+n/hlrXI4s4aUS?=
 =?iso-8859-1?Q?7Ct8Ys00AcoAs24U2W2HA7nm743AvmLV5E6za8W0s0bvSpZYlVbiSB6URU?=
 =?iso-8859-1?Q?YIWAZ1flddAedx9JhCAHQej3iuSsJtgLK0hr4SSVdd4RLsgpVuAhaxuooF?=
 =?iso-8859-1?Q?N45hqQwD+zuroDLU4hQxNy1N1WT1ol55UB12ATugUrwiQuzpJJf3jHnZEQ?=
 =?iso-8859-1?Q?aT38QJWcA3QdrGioVxDw/UV/UkAQiex7Z8we2Lw7WKo9Yi6lNPIU9ZpQTW?=
 =?iso-8859-1?Q?9nLTbaqbCXBdvDmoXOSOOC4NdT7Mv+7f2XpY+xOz4fTQTc/QNZI5Qzl/e5?=
 =?iso-8859-1?Q?ZGRnN3Kle2JQ5h4WsgJuul0L9MzpYUCHsd/irGztfdXOFQzKL23bRoxp9F?=
 =?iso-8859-1?Q?lsOkq3g/O61QBIdWMnGb4AYITCbMhWH6SbHaJdOmdbpS7feEtq4bClsoYm?=
 =?iso-8859-1?Q?4J61JQ0LYnlJL41jiDn/hY6x+xhxboPyxzsdnGSdNnGYUspxZjgNBXI/aI?=
 =?iso-8859-1?Q?i3a7uRxJBuLLsDb5pAvv9zrNHopBa+oJmLIhD+qzTpk9Vps+SPwyJHqgKs?=
 =?iso-8859-1?Q?pfhbX0ECn8kKTx+eyn4ItIDMIu6uvuuOsYwmBxmFud852JljrSHuytHneR?=
 =?iso-8859-1?Q?1nWd7DB88J0d7Cs0DMLcnZqyrpycXcmquNjO43z4smlIQu37STcXicChrQ?=
 =?iso-8859-1?Q?YWXVS0WWcPsMw9c7bZYyyioQrxAQ9+af9swWmtPm5D5mWnYfs3C65uKGEa?=
 =?iso-8859-1?Q?jO9WSttxO3jPK1cu0x1iqJLNm1og2Ib7hSAYCdDD/JRqlgcpqhL57a7iug?=
 =?iso-8859-1?Q?Ky22ZP5oSI/pcxDaXb9UJrfoRe5mc0IuDmQv9qp/XleFLtF96jlIhWyJZS?=
 =?iso-8859-1?Q?W4EqHx9f3N3j/5aamZvDSuAAtiiNQk0l1GSXip/5/2kHIM9qSGsB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b61dbd-ebb4-4183-2315-08de9c68886d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 10:03:11.2190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Msgjr/urgF7JDkFcGjYS704QoB1VpPhhK+fec4lEdA8JtI2StOXw/oOv3z9k3DypFWv3prakSqL+YkIAfEVIgrQavksLRA8o45qB0jcG9OQ=
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

Make data accesses honour the MSTATUS MBE/SBE/UBE endianness bits
instead of being hardcoded to little-endian. A new helper,
riscv_cpu_data_is_big_endian(), picks the bit corresponding to the
current privilege level (MBE for M, SBE for S, UBE for U). The
existing mo_endian_env() wrapper in internals.h now returns MO_BE or
MO_LE based on that helper, so the hypervisor load/store helpers in
op_helper.c pick up the runtime endianness automatically.

On the translator side, DisasContext gains a mo_endianness field
holding MO_BE or MO_LE, which the generated load/store ops OR into
their MemOp. The trivial mo_endian() wrapper is dropped and call
sites reference ctx->mo_endianness directly.

TB_FLAGS has no free bits, so the endianness is carried into the
translator through bit 32 of cs_base (alongside misa_ext in bits
0-25). This keys TBs correctly on the current data endianness. The
cs_base comment in include/exec/translation-block.h is updated to
document the RISC-V usage.

Instruction fetches remain MO_LE unconditionally; RISC-V instructions
are always little-endian per the ISA specification.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 include/exec/translation-block.h              |  3 +-
 target/riscv/cpu.h                            | 28 +++++++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc       |  4 +--
 target/riscv/insn_trans/trans_rvd.c.inc       |  4 +--
 target/riscv/insn_trans/trans_rvf.c.inc       |  4 +--
 target/riscv/insn_trans/trans_rvi.c.inc       |  8 +++---
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 +--
 target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 +--
 target/riscv/insn_trans/trans_rvzce.c.inc     |  4 +--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +--
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +--
 target/riscv/insn_trans/trans_xmips.c.inc     |  8 +++---
 target/riscv/insn_trans/trans_xthead.c.inc    | 16 +++++------
 target/riscv/insn_trans/trans_zilsd.c.inc     |  4 +--
 target/riscv/internals.h                      |  9 +-----
 target/riscv/tcg/tcg-cpu.c                    |  7 ++++-
 target/riscv/translate.c                      | 22 +++++----------
 17 files changed, 78 insertions(+), 59 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-bl=
ock.h
index 4f83d5bec9..66068c61a3 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -64,7 +64,8 @@ struct TranslationBlock {
      * x86: the original user, the Code Segment virtual base,
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
-     * sparc: the next pc of the instruction queue (for delay slots).
+     * sparc: the next pc of the instruction queue (for delay slots),
+     * riscv: misa_ext in bits 0-25, data endianness in bit 32.
      */
     uint64_t cs_base;
=20
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 35d1f6362c..ef870d05b3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -703,6 +703,12 @@ FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, PM_PMM, 29, 2)
 FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
=20
+/*
+ * cs_base carries misa_ext (bits 0-25) plus additional flags.
+ * Bit 32 is used for data endianness since TB_FLAGS has no free bits.
+ */
+#define TB_CSBASE_BIG_ENDIAN  (1ULL << 32)
+
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
 #else
@@ -718,6 +724,28 @@ static inline const RISCVCPUConfig *riscv_cpu_cfg(CPUR=
ISCVState *env)
     return &env_archcpu(env)->cfg;
 }
=20
+/*
+ * Return true if data accesses are big-endian for the current privilege
+ * level, based on the MSTATUS MBE/SBE/UBE bits.
+ */
+static inline bool riscv_cpu_data_is_big_endian(CPURISCVState *env)
+{
+#if defined(CONFIG_USER_ONLY)
+    return false;
+#else
+    switch (env->priv) {
+    case PRV_M:
+        return env->mstatus & MSTATUS_MBE;
+    case PRV_S:
+        return env->mstatus & MSTATUS_SBE;
+    case PRV_U:
+        return env->mstatus & MSTATUS_UBE;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static inline int cpu_address_mode(CPURISCVState *env)
 {
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_tr=
ans/trans_rva.c.inc
index a7a3278d24..6597ae8bb7 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -35,7 +35,7 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemO=
p mop)
     TCGv src1;
=20
     mop |=3D MO_ALIGN;
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     src1 =3D get_address(ctx, a->rs1, 0);
@@ -65,7 +65,7 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemO=
p mop)
     TCGLabel *l2 =3D gen_new_label();
=20
     mop |=3D MO_ALIGN;
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     src1 =3D get_address(ctx, a->rs1, 0);
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_tr=
ans/trans_rvd.c.inc
index ffea0c2a1f..3b9a745520 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -60,7 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     } else {
         memop |=3D MO_ATOM_IFALIGN;
     }
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     addr =3D get_address(ctx, a->rs1, a->imm);
@@ -85,7 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     } else {
         memop |=3D MO_ATOM_IFALIGN;
     }
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
=20
     decode_save_opc(ctx, 0);
     addr =3D get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_tr=
ans/trans_rvf.c.inc
index 89fb0f604a..e935523c93 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
@@ -71,7 +71,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_tr=
ans/trans_rvi.c.inc
index 2c82ae41a7..2de74fac3a 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -392,7 +392,7 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a,=
 MemOp memop)
         }
     } else {
         tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
-        if (mo_endian(ctx) =3D=3D MO_LE) {
+        if (ctx->mo_endianness =3D=3D MO_LE) {
             tcg_gen_extr_i128_i64(tl, th, t16);
         } else {
             tcg_gen_extr_i128_i64(th, tl, t16);
@@ -409,7 +409,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemO=
p memop)
 {
     bool out;
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
@@ -508,7 +508,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a=
, MemOp memop)
         tcg_gen_ext_tl_i64(tl, src2l);
         tcg_gen_ext_tl_i64(th, src2h);
=20
-        if (mo_endian(ctx) =3D=3D MO_LE) {
+        if (ctx->mo_endianness =3D=3D MO_LE) {
             tcg_gen_concat_i64_i128(t16, tl, th);
         } else {
             tcg_gen_concat_i64_i128(t16, th, tl);
@@ -520,7 +520,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a=
, MemOp memop)
=20
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |=3D MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/ins=
n_trans/trans_rvzacas.c.inc
index 8d94b83ce9..79bca1e957 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -76,7 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *=
a, MemOp mop)
     TCGv src1 =3D get_address(ctx, a->rs1, 0);
     TCGv_i64 src2 =3D get_gpr_pair(ctx, a->rs2);
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
=20
@@ -121,7 +121,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amoca=
s_q *a)
     TCGv_i64 desth =3D get_gpr(ctx, a->rd =3D=3D 0 ? 0 : a->rd + 1, EXT_NO=
NE);
     MemOp memop =3D MO_ALIGN | MO_UO;
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
     tcg_gen_concat_i64_i128(dest, destl, desth);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/in=
sn_trans/trans_rvzalasr.c.inc
index 0f307affec..79b0b2c63b 100644
--- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -29,7 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aq=
rl *a, MemOp memop)
         return false;
     }
=20
-    memop |=3D MO_ALIGN | mo_endian(ctx);
+    memop |=3D MO_ALIGN | ctx->mo_endianness;
     memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
=20
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
@@ -79,7 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_a=
qrl *a, MemOp memop)
         return false;
     }
=20
-    memop |=3D MO_ALIGN | mo_endian(ctx);
+    memop |=3D MO_ALIGN | ctx->mo_endianness;
     memop |=3D (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
=20
     /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_=
trans/trans_rvzce.c.inc
index 0d3ba40e52..71b4ca5473 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -185,7 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, boo=
l ret, bool ret_val)
=20
     tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     for (i =3D X_Sn + 11; i >=3D 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv dest =3D dest_gpr(ctx, i);
@@ -239,7 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_pus=
h *a)
=20
     tcg_gen_subi_tl(addr, sp, reg_size);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     for (i =3D X_Sn + 11; i >=3D 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv val =3D get_gpr(ctx, i, EXT_NONE);
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_=
trans/trans_rvzfh.c.inc
index 791ee51f65..f36b46c211 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -49,7 +49,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, 0);
     t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -74,7 +74,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, 0);
     t0 =3D get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/i=
nsn_trans/trans_rvzicfiss.c.inc
index 0b6ad57965..43f586dce9 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -105,7 +105,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_am=
oswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 =3D get_address(ctx, a->rs1, 0);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
@@ -135,7 +135,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_am=
oswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 =3D get_address(ctx, a->rs1, 0);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index c1a30156d3..1b9993a9b0 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -47,7 +47,7 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 /* Load Doubleword Pair. */
 static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 {
-    MemOp memop =3D MO_SQ | mo_endian(ctx);
+    MemOp memop =3D MO_SQ | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
@@ -71,7 +71,7 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 /* Load Word Pair. */
 static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 {
-    MemOp memop =3D MO_SL | mo_endian(ctx);
+    MemOp memop =3D MO_SL | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
=20
@@ -94,7 +94,7 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 /* Store Doubleword Pair. */
 static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 {
-    MemOp memop =3D MO_UQ | mo_endian(ctx);
+    MemOp memop =3D MO_UQ | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
@@ -116,7 +116,7 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 /* Store Word Pair. */
 static bool trans_swp(DisasContext *ctx, arg_swp *a)
 {
-    MemOp memop =3D MO_SL | mo_endian(ctx);
+    MemOp memop =3D MO_SL | ctx->mo_endianness;
=20
     REQUIRE_XMIPSLSP(ctx);
=20
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn=
_trans/trans_xthead.c.inc
index f8b95c6498..f4e3051000 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -349,7 +349,7 @@ static bool gen_fload_idx(DisasContext *ctx, arg_th_mem=
idx *a, MemOp memop,
     TCGv_i64 rd =3D cpu_fpr[a->rd];
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_i64(rd, addr, ctx->mem_idx, memop);
     if ((memop & MO_SIZE) =3D=3D MO_32) {
         gen_nanbox_s(rd, rd);
@@ -370,7 +370,7 @@ static bool gen_fstore_idx(DisasContext *ctx, arg_th_me=
midx *a, MemOp memop,
     TCGv_i64 rd =3D cpu_fpr[a->rd];
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_i64(rd, addr, ctx->mem_idx, memop);
=20
     return true;
@@ -570,7 +570,7 @@ static bool gen_load_inc(DisasContext *ctx, arg_th_memi=
nc *a, MemOp memop,
     TCGv rd =3D dest_gpr(ctx, a->rd);
     TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rd, rd);
@@ -591,7 +591,7 @@ static bool gen_store_inc(DisasContext *ctx, arg_th_mem=
inc *a, MemOp memop,
     TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
     TCGv rs1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rs1, rs1);
@@ -747,7 +747,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_memi=
dx *a, MemOp memop,
     TCGv rd =3D dest_gpr(ctx, a->rd);
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, rd);
=20
@@ -765,7 +765,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_mem=
idx *a, MemOp memop,
     TCGv data =3D get_gpr(ctx, a->rd, EXT_NONE);
     TCGv addr =3D get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zex=
t_offs);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
=20
     return true;
@@ -926,7 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th_p=
air *a, MemOp memop,
     addr1 =3D get_address(ctx, a->rs, imm);
     addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd1, t1);
@@ -965,7 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_th_=
pair *a, MemOp memop,
     addr1 =3D get_address(ctx, a->rs, imm);
     addr2 =3D get_address(ctx, a->rs, memop_size(memop) + imm);
=20
-    memop |=3D mo_endian(ctx);
+    memop |=3D ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
     return true;
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_=
trans/trans_zilsd.c.inc
index f50c52f22c..8068cc1aec 100644
--- a/target/riscv/insn_trans/trans_zilsd.c.inc
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -30,7 +30,7 @@ static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
     TCGv addr =3D get_address(ctx, a->rs1, a->imm);
     TCGv_i64 tmp =3D tcg_temp_new_i64();
=20
-    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | ctx->mo_endiannes=
s);
=20
     if (a->rd =3D=3D 0) {
         return true;
@@ -85,7 +85,7 @@ static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
     } else {
         tcg_gen_concat_tl_i64(tmp, data_low, data_high);
     }
-    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | ctx->mo_endiannes=
s);
=20
     return true;
 }
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 460346dd6d..e2f0334da8 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -64,14 +64,7 @@ static inline bool mmuidx_2stage(int mmu_idx)
=20
 static inline MemOp mo_endian_env(CPURISCVState *env)
 {
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_LE;
+    return riscv_cpu_data_is_big_endian(env) ? MO_BE : MO_LE;
 }
=20
 /* share data between vector helpers and decode code */
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3407191c22..d73b749bae 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -189,10 +189,15 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState =
*cs)
     flags =3D FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
     flags =3D FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
=20
+    uint64_t cs_base =3D env->misa_ext;
+    if (riscv_cpu_data_is_big_endian(env)) {
+        cs_base |=3D TB_CSBASE_BIG_ENDIAN;
+    }
+
     return (TCGTBCPUState){
         .pc =3D env->xl =3D=3D MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
         .flags =3D flags,
-        .cs_base =3D env->misa_ext,
+        .cs_base =3D cs_base,
     };
 }
=20
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 5df5b73849..9f538ba96d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -119,6 +119,8 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    /* Data endianness from MSTATUS UBE/SBE/MBE */
+    MemOp mo_endianness;
 } DisasContext;
=20
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -126,18 +128,6 @@ static inline bool has_ext(DisasContext *ctx, uint32_t=
 ext)
     return ctx->misa_ext & ext;
 }
=20
-static inline MemOp mo_endian(DisasContext *ctx)
-{
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_LE;
-}
-
 #ifdef TARGET_RISCV32
 #define get_xl(ctx)    MXL_RV32
 #elif defined(CONFIG_USER_ONLY)
@@ -154,7 +144,7 @@ static inline MemOp mo_endian(DisasContext *ctx)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
=20
-#define mxl_memop(ctx) ((get_xl(ctx) + 1) | mo_endian(ctx))
+#define mxl_memop(ctx) ((get_xl(ctx) + 1) | (ctx)->mo_endianness)
=20
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
@@ -1147,7 +1137,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size =3D mop & MO_SIZE;
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b && size >=3D MO_32) {
         mop |=3D MO_ATOM_WITHIN16;
     } else {
@@ -1168,7 +1158,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic=
 *a, MemOp mop)
     TCGv src1 =3D get_address(ctx, a->rs1, 0);
     TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
=20
@@ -1346,6 +1336,8 @@ static void riscv_tr_init_disas_context(DisasContextB=
ase *dcbase, CPUState *cs)
     ctx->zero =3D tcg_constant_tl(0);
     ctx->virt_inst_excp =3D false;
     ctx->decoders =3D cpu->decoders;
+    ctx->mo_endianness =3D (ctx->base.tb->cs_base & TB_CSBASE_BIG_ENDIAN)
+                         ? MO_BE : MO_LE;
 }
=20
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
--=20
2.34.1


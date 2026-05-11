Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A583CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMN8r-0002O2-9J; Mon, 11 May 2026 05:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7z-00022s-Mv; Mon, 11 May 2026 05:40:43 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7s-0001R4-2f; Mon, 11 May 2026 05:40:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJ5LQ/KPBzkpNcJTIJIXYIpNlsHUHi1mCXGCFBVb1vLC2XtDlcsj6p+AHHIbWkNWmOMqmkNj4CRoc9GrshrsRFr92k/93vfwwER0B6x7wojHXrPCKjD2OHxyYPXxT9Yt2ju+5+7frPinlgkFtiuG2NHrRog0LebKe68aRrZf3N7UxYiVqo8zrDa27sRAlCd+jbuZDwOYXMIb6ycg/YxDKbjoWgjvHN1tGz1qUpL5x+F1T3VOIFp4LCj015zvvrJpxIIhS8FQn7+TTI5yZdlEOkTJZAjxWw8mHKPZ7EBfbKUpwk6gndkYDUJ1w/6gCdt0SGWRfYnXyfHB5GQmk0Z52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lPesuzBy9H6LEDKRzhMmyqXj332N4sgpkmVP6mVoiI=;
 b=ni8x45lzCq6iKI0T9FKbRiEL7YPkpNH8aLHkNBFJzTQBGSLJOy4++kyoX7ZR4hus4TdgATRfonWLmqA1lqwWlFp8p2XpYnO6O03fUvhknX6uoECz0sRiX8eZG42g1jzJM0ASYDqG9KMTRkC/apXOigsFfTGxSURxkVc14Fm9psTdakFLy3spwIcWpbWYEc2liXDrg9yaVOZhKcKPOvscgecdOMTvqqhUWRSyFnggc04hgq3CufvoeUoudbpeBymuLz2z+aQAjigrc2aexauEWdIfs0OS589RD69Byu6dBsZDbCbVG9K9s35WSwaq1Clg4MpmX+fW4ofCMh31DGohBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lPesuzBy9H6LEDKRzhMmyqXj332N4sgpkmVP6mVoiI=;
 b=J3E2F6c1TjtwwzjXQVoM3gioopFBrHy/+Penl9Yck+EYqjw+9XX3wLUmUy2C6KJc5aYhJDmZfz7XPwxHXHmOzA4OS7J6sjGjyXbv9ebhdDQGlMy/Ow1ityJHXh83HxwuY+rM6crYkc/O+ZLyaM/HqNLAUR0CZvirMGuEjiNIbYFg5fLiTz/YYDhiIdrVXKH7ktojrpDR/nbxvTdZgxoBlfk4Yl6PZIyvs1U7SKe8PpcTVS3eKcgB5Kp6AFujwlZfVHHlhcQfKawBllYHzsRMbKRBGN8fGVW7Ync/BO0A8j51gNwwfiHOq/tIp1PDEBDlBBaO4PkvPvw+87akHoajuA==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by DB5PR09MB8695.eurprd09.prod.outlook.com (2603:10a6:10:64a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 08:38:30 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:38:28 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 3/7] target/riscv: Implement runtime data endianness via
 MSTATUS bits
Thread-Topic: [PATCH v9 3/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Thread-Index: AQHc4SGK/6p98GtDO0yKUTC9payRhg==
Date: Mon, 11 May 2026 08:38:28 +0000
Message-ID: <20260511083819.206216-4-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: b6561598-6a28-4795-8fae-08deaf38acac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|3023799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: duLw25uO/MJjawwFsc2bZmQ4JTNwrNCjWGEf3LVrrCew+CiDaVjpUjqNgnISQrtMzAqx7G78rPGwuQuKI5BGWgkpcien2iwQL1XRLEs/iN+uTJgX90l+1bATjq5x6FWj0TTE26hanA/K+5FNIgpv/Prswtje6fvHgt/h9i3CcHfqJ4y4E/u0IA7jGUTTs6HgpyG6cFAUnsdCe0xZzUDXRgZ/qON4fGyf5wHndjrJnPqKnpwlFFaLe8AitoSMbvmQLMyPSptH6xjDk6fWqRHG2UnNtKkkWAZv+EHUk/v+WUmsCP0Du5CoVpjZB3yJzcvcnxG/qDemcdkVxTrUGQEWr+YoupRtumsqjzQditP62Psx+gtHoXDQAxHh42/KqNjpry6rXTfqLJ/1+2vKI7p62mp+XyuN10MBI+kznQm+VseDaWoceckAOm2bKBj8AaExqUQTFziC+F1/IfTICQ9qRsLgPmv/xFyCqCce90zozrNVUq8FfFAHPznf4EQT2torqjP3rsZblUMOyn0Bn1a6ZjZUVazRrvwtyJUaA+sBgFAS+m1/9kt71nh0wYnZbDUNCo1OSs6NR1gVvqFjBwjTFMTMJMJG/Mz3BwmWr/AdPnwo1u9LnJYzO3iugQQMPwmcrRk5w07sheP1QN7l3cNH/ZPKGh/r8viHoHFvOrpOIY/L+G2/VzCkSnyECStbBmwfKr9gJ1UK2gCSjamXI+yc6QE3RDy1F+jV8PKRlelY+pmzmcgTi5CXyhiCJHfr0QkS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l8Y6DYvmb3tcngvxHfBNyOzxT04NgEoep3mRM09KFpjwBWDSGk+OdOxml1?=
 =?iso-8859-1?Q?AFwKiA7NGppLYkVY6FjWcksAaHxQxcFJ/0XZj1gYSL+kWFgJIu/crV0tJ/?=
 =?iso-8859-1?Q?y7z3OZQ2yF801qYrIouX4tyNwEsdavuMASV/corENKitxV6o1OF65lIpQ5?=
 =?iso-8859-1?Q?6u8Cx0Hv0qIyuxPYMAYpvj7UxSDUcWqYK6S6tkHvKhykON83opCKS14gFK?=
 =?iso-8859-1?Q?fQxlXqtlWlCNWIuhRSDZqMA23Ehu/PfJaJVArCWQW5JNfXc4yKIh8qwbLL?=
 =?iso-8859-1?Q?sBiKmssjBHPJWPv9TYSkq3KaOX8aKyFbxoYJNZtZbQ3mFFUtcebXPGQUM7?=
 =?iso-8859-1?Q?moOx0JYleA+H/YSoU5b13B+Ua5TlJk8fPjAYOTvZ4BXa/aCiyKDN8Y4SNO?=
 =?iso-8859-1?Q?/hQEqVo/ykKl13XCdCJ6B9elNg2X8hlvPDAbO3hW2oNvwV8T/syQRKzKrh?=
 =?iso-8859-1?Q?JvjzoNpBqSCKmiwFby69T9+yoP+BDzQ7nw06B7umHbvWkjbHBt5Wbj1H6H?=
 =?iso-8859-1?Q?qusxglSWMWIxdKZ1LVLHVenNnGxCSBpFY/8HilsD8lZaOll3XlcM4jmnBl?=
 =?iso-8859-1?Q?mPLZWYUwl27gRubtdhpfcg9asXF+K8TzLkMoiTDWVaZ2gyV1xZyZ006iSs?=
 =?iso-8859-1?Q?Xg5yGUDIa0ICnxsQD6LBnQu/A/t941R5s6Y7h7jXEJB1HeXdSHmaU1mIrY?=
 =?iso-8859-1?Q?jm6TG7Ha57jPhdzrrzBZd8CPJLC3rHtiOs5rGtbUscpdotyKlaWcx6ZUmm?=
 =?iso-8859-1?Q?9sKdMHa3oIloYrH60eOH8Mem13KjgIOE11J58QDdnDWVCZ4HhrSgzzkAa2?=
 =?iso-8859-1?Q?0V7H/0aJoW+H6m5uTmgTPiUHg5eTJUFCzgtg7aLWqUUBpH1fDLjrySTPNO?=
 =?iso-8859-1?Q?0cQ5cahn6cPJUuhMxzB7fWyRT0TEQsb1v0GzUOlKdQPrQ7MDveWzOGQGGD?=
 =?iso-8859-1?Q?XdUF0O8vDFCHb8yJGc54g4mG4WTXQnN/fmTInYfGKPdbJ9VbjD+n0TT4a0?=
 =?iso-8859-1?Q?9965T6TxrR1EgnzjY/mCbaMNe9Obb0Uw34ibnwV57ICpFbIht4G+1qtts5?=
 =?iso-8859-1?Q?xU/t5xH1XwvIinLahB9uW0uJB7IP9xwYaEPRR7xERDrrEMSBX28haMKJoE?=
 =?iso-8859-1?Q?a68aD+WUNQ3aR+2lqGCV35SpaLSwE+ABV2NIK3vxrZlSY9/KKjOpsH6zrP?=
 =?iso-8859-1?Q?/VfEkLj0XCCuPUZegVyBhyQCiR67i0MXkX/k5mn7m+EokZYyyb7j1MeXO5?=
 =?iso-8859-1?Q?t5zAITsC0L8AlnYIFEbnbP9NhSu//mZEVWLrczYBa5+3wMjBtTLmiOD3B5?=
 =?iso-8859-1?Q?8IJyJL5oTrmPJUD4KZIPVDPq+MbTthTGY0WfZgYBNj7sWI9OpAitln6r+S?=
 =?iso-8859-1?Q?6nHMM3gqRiVav/dOOoVBTJiD2egBmTgMhxEjmkd55bPFi9k7iZucohNz1E?=
 =?iso-8859-1?Q?FPfIR3PdkJV2vHuG7k4kgchq6lznv9nVsy+aKjUQuxzXZwGjkdc4b5XiOl?=
 =?iso-8859-1?Q?W9jSFMEck/q+YvfVJoz2BiDjhIkeBJLVdZmlvUVzwfmfyTKMgHDhQP/G7X?=
 =?iso-8859-1?Q?OQRFIN1KCdBQDbqzQECkCNXyIHvyqzwElE3RlvZiMh36gRxDuEPPiswfDK?=
 =?iso-8859-1?Q?kYlMaoijqDzWGFS7zhCoIG73bjFUyDT6dmEQ8GNYavciU7kH+wxbw6y8/1?=
 =?iso-8859-1?Q?anPHbislN3nvA+0Kxcau+q3nVQ03hZS/OgUuX+6Y0XQaU/DDxmtO8ot+jv?=
 =?iso-8859-1?Q?+kmb1+2Ipc2fRP5H5Bm5fHuSc04WA40t3ZZl4PsOUMHXndM60AHSP129Q6?=
 =?iso-8859-1?Q?RwD8mUDOM56BCdRh5MP5BNzc8ubpiDcddx7fpHjDvyP7Af4BbQLU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6561598-6a28-4795-8fae-08deaf38acac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:38:28.3000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/pir1qYHvNlDS6xbPPvxQwrhk1TI9wDaw9joLaLHdcDre9IR1pMNzMb3tfGC3j8b9nLZfFtYOWd6f04LOUpadGKqXWQe2N+qLudyrBwXt0=
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
 target/riscv/cpu.h                            | 23 +++++++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvd.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvf.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc       |  8 +++----
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 ++--
 target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 ++--
 target/riscv/insn_trans/trans_rvzce.c.inc     |  4 ++--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 ++--
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 ++--
 target/riscv/insn_trans/trans_xmips.c.inc     |  8 +++----
 target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++++++-------
 target/riscv/insn_trans/trans_zilsd.c.inc     |  4 ++--
 target/riscv/internals.h                      |  9 +-------
 target/riscv/tcg/tcg-cpu.c                    |  3 +++
 target/riscv/translate.c                      | 22 ++++++------------
 16 files changed, 68 insertions(+), 57 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 81c41e3429..1f2d0777e8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -705,6 +705,7 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
=20
 FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
+FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
=20
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
@@ -721,6 +722,28 @@ static inline const RISCVCPUConfig *riscv_cpu_cfg(CPUR=
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
index 62c0fe673d..44c1696fe4 100644
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
index bac6c8032a..dc505a9ab3 100644
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
index 02c98cc2db..81b56e5a62 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -193,6 +193,9 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *c=
s)
     flags =3D FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
=20
     ext_flags =3D FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_=
ext);
+    if (riscv_cpu_data_is_big_endian(env)) {
+        ext_flags =3D FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN, 1);
+    }
=20
     return (TCGTBCPUState){
         .pc =3D env->xl =3D=3D MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1e4f340256..35c6b37c0b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -120,6 +120,8 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    /* Data endianness from MSTATUS UBE/SBE/MBE */
+    MemOp mo_endianness;
 } DisasContext;
=20
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -127,18 +129,6 @@ static inline bool has_ext(DisasContext *ctx, uint32_t=
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
@@ -155,7 +145,7 @@ static inline MemOp mo_endian(DisasContext *ctx)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
=20
-#define mxl_memop(ctx) ((get_xl(ctx) + 1) | mo_endian(ctx))
+#define mxl_memop(ctx) ((get_xl(ctx) + 1) | (ctx)->mo_endianness)
=20
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
@@ -1156,7 +1146,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv src1, src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size =3D mop & MO_SIZE;
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b && size >=3D MO_32) {
         mop |=3D MO_ATOM_WITHIN16;
     } else {
@@ -1177,7 +1167,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic=
 *a, MemOp mop)
     TCGv src1 =3D get_address(ctx, a->rs1, 0);
     TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
=20
-    mop |=3D mo_endian(ctx);
+    mop |=3D ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
=20
@@ -1360,6 +1350,8 @@ static void riscv_tr_init_disas_context(DisasContextB=
ase *dcbase, CPUState *cs)
     ctx->zero =3D tcg_constant_tl(0);
     ctx->virt_inst_excp =3D false;
     ctx->decoders =3D cpu->decoders;
+    ctx->mo_endianness =3D FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, BIG_ENDI=
AN)
+                         ? MO_BE : MO_LE;
 }
=20
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
--=20
2.34.1


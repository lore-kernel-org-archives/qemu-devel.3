Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3DF1098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bQZ-0002tu-Rq; Fri, 20 Mar 2026 11:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQX-0002s7-1f; Fri, 20 Mar 2026 11:06:17 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQS-0002Q3-NW; Fri, 20 Mar 2026 11:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzeC6+EVClpOZLAioIVgyup6MTujfiCVm2mWSThBZdlyo+0emmNyUpzoZx9ffNzQf6I8/BC2Pz3Ogg04iZIokhXH2HHoNqBsNYjbZpFCC+GoH4ZQsKxLBUNZYLs45ZHH1QconMMEE6ke+nbyUoLkhDAZuSeAzS22AFiz5YkzGHCb8UzqXCwjzq6ENspIq62jqdPEZpfGjj/lGNU0JAbC68pKqScB9+AyyINrnfaAk5mskpG8bR6fhDn89WDyJaa48aZr7nPexl/1a21qTDNctZTgMXma9QOcLjsbZCsVaPUTote5QIMzS5WIgr/Emp4YGikxqWZO5VWGWYWqV6p8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IvIlDTSCqZOcy60cvRsxbmIPpRE8DmuWP/+rIsbc2k=;
 b=IVbkJrjWXYINO9svhjD6qklVO4fJRyiP3imeasSDX2nORIgibiWQmOrlGZNi9aCZyomWWYzFQpyj7nxIDOqpBCedh1WuVk6scuhYxF+p2Z9KJaFttOTZHVL/ljCry8IlkoeNJCm52PYZnBPL1NiZBGD5/jcy1s3lkJDm+s7cvUMwwDnkLF4FySgiSfiqSh05EAlg9qDPDbMOWvI63GoDQI1ct3t/d15k4z6bkc5yTTWifhvRLOCSFYc+hxzLNrDaGSO5vwW0fBgMqnsqBnjpeTtJGdNeEbffMBxPfm7sX9+DWvxZgbGKUBBC61BoXJGxEQfxKSDWEEyMIrZOkR6/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IvIlDTSCqZOcy60cvRsxbmIPpRE8DmuWP/+rIsbc2k=;
 b=gI49sYV1fLl8kOi7S9QkBEcW1S9lip6rQv6WaJ7LWyTNGSWKRud8IWbX6v4Wuc/DJQ5Dtk53tVYcmrM2GAG6hWSsCiqw8fwy5ggDsx3cCcMqx+FuA5drPApBbEPvZBagF3cRcWkly3IBy3tzcddwYN7nhxXZ+5poMpPQVZuOaDKAEs9UVmQ7VdLaHgd8bVVgfTVMbknCV9pCkQmv3t3JqF5m7dPBWr6jab8I+eutEq8uzmYemD67ecqX+qfSfxWHMvfWDt9cKpIjwSXx/DhRU1kBmJUI30qRMAVynU9GstwzqI3PJovlyQ6OvFRjfm8uPF/sRY/wt3wrJtRF+BwpCg==
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
Subject: [PATCH v4 4/7] target/riscv: Implement runtime data endianness via
 MSTATUS bits
Thread-Topic: [PATCH v4 4/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Thread-Index: AQHcuHsPQnT8IFQqVU2ayD/d0a/CQw==
Date: Fri, 20 Mar 2026 15:06:00 +0000
Message-ID: <20260320150552.169480-5-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 3735dc28-084e-4f57-d832-08de86923288
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 6NcyAhFf/vyfaVTXoWkvWyiPS+ggMCmeJH/NBY2sXpLybVJ5WI4h3nRBifoyrZl68Lt2ug3BVMoZTZwfA/sQerCihvGstc82hRjrYIwDGO5tMwXMStJDDFKwHPSOFafjlW7D/BZfYuY4OwofmcKA6McRWmt+7sI+aBLAWkZDtomOqDD8DPMI5Gha8rWqVRfAxxQbjPUzCCvlAHizB1IewPfbbiTDS02z97xpA/yPGLE1gFXExOxCx10313zQz7yWKyTQ5jZC7703cwvV3OySsnq5vYJ2FI8PnoPtXQDB/vvqTYwWkhk3r43m8bk/SiNA27OU6wWqR428b6QiRPqWpmvUndAhqvrDyHfBFiNZmGJhdChFgdtSomFSF+DuAZ42L/69ucCrF4D29zA4gfJofqQYz1KywQ7BcaVC4sYrtjnZgrApaNgxdMACU8o8eWt3vQkgK0ed677v3B0/5S8ssjVGGDoDwBgzh+HlqY0kbvED3uOYP8zcXSsWthlekspO6lq15s79vTCPprFJ1fAoIOs90k39ZTWVbfrZSdZynJvfJjmpcIKwyYp7Q87BqMXbNMbTe3qha+Cecud+1+qm4sGHlkS1jaY4eIPRQ9aH6HzichCs+6IS4Cj1GSjdxdLFTRox31sdhKQ98DAxLTkvbDy+YGNw61KCFHb1t1StbLy5ZB0sUzBP+7/R9KKTmABxAR3BzIRjmZCqjOcwd7C7tbj8UfRndZIo7TfeODRdpfBxS0Q6gSerf95+Boi60LbUJpD1uwDHAVpcdl8eLRK2njBHjgWUEIS12sVRwUsrbJI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ts0ygOTsEMjJ0qsSwvZ4iMLLydf0dI7brNtKaJsDHT9mRt0nDZyZfVQ0rN?=
 =?iso-8859-1?Q?Ph1+y2RR19Hd/ubzJUvbdre4APVrAZykEdOmVEDnWnpGd1xcJxcQmihKCZ?=
 =?iso-8859-1?Q?HND6LWuNRVtBJ5heaPsolHZKi0kTsJjXmRFljfIegx/HHaLbvC4bzThIsz?=
 =?iso-8859-1?Q?cRUxu8MuhtgMdjekj2jn+KtvymDkwdD/4AmecmKNYiHGJbMyQ6EO+HZLLX?=
 =?iso-8859-1?Q?5LvPCILiqsxhLlznvGIb4/qGgwfDlZWg/udJpfQ4lGJRYst01FL5fZ/7ky?=
 =?iso-8859-1?Q?zkJuDeX0SHBYtNtAx8JG4FB2mdw65XEMFsAvMMnNq3VVEVEEs8GufITjUH?=
 =?iso-8859-1?Q?K15+dJrhqYYqCYsIxfVmt0dA4uetakdf+RGley9Fi4w84uoqqzz4vdqBD9?=
 =?iso-8859-1?Q?0hk1bTD1z6UxhaAqhWcoYiEVIGl7uMsBEGU2oTTx7846J0hQRfD77rhMrV?=
 =?iso-8859-1?Q?+vDILp+9q9fxKrCBlw/6/D6lfpXkRvqUgkFvhD3hbnqv4veaNSyruXgOiO?=
 =?iso-8859-1?Q?zMowmulf4Nr2EWweBTTE0wl1neplr5IYMvASJRudvl5u2MNCoNylZsn3UU?=
 =?iso-8859-1?Q?gXQGUhjsPJiUg1lqrIDfTxf55o1DJ6OS8Jtxob/iX7x4nEc1SHxHlSvzIX?=
 =?iso-8859-1?Q?tC4nGJR9XRczWTK28CHSWOqpGhiDrwAObBEq/Wrthugz2jC7l0xYw+udOL?=
 =?iso-8859-1?Q?1jH6xL1G0tIBYxVWROXV1OADgEuA8rLFBZhoC7pNNvSpYcnZwdZZ3s0KYW?=
 =?iso-8859-1?Q?qvDV9vT2QY1oFQuQ378252DwsKy8v3h9bDW/Hfo1OEw9UavatetotyNYJU?=
 =?iso-8859-1?Q?6KH8j9q8Ifi6X8xj/Wl7QG+puNWCBLcOqU+OjhamhaCDsdbqirZu9THP5o?=
 =?iso-8859-1?Q?SG2eaUIQSBSag6wmLQ88NgLtonUds2Bh0JQmcxdcuIL2W6aBqho5ZzhuAN?=
 =?iso-8859-1?Q?g3jYjR2DwvLZ7yNfYbbFwDfQ2qCEH4w8C35qIRHKS9WfaOvQLaDRoHNWXH?=
 =?iso-8859-1?Q?c0kjlKLpt+SmcyZYu2EUAcDMS5hfCojUY8qO+IwpJ1oMyKhYd3WQ4HfF2m?=
 =?iso-8859-1?Q?upNMbZjZ2dbBJwmrMqdWcZQW5x93O/KI8WWMRJmCDO23CfLgPObGve2jES?=
 =?iso-8859-1?Q?j8VT7YMKlf/TNlkzmCfTD4Rs67doyQS2RWa8efzpIJam8QhREMSLy+HTTs?=
 =?iso-8859-1?Q?oCdhjO0tcqbW2em28Qa/76GjwYcixmZ6jUSx5XH9FaPkT2IInT0KiMnu9b?=
 =?iso-8859-1?Q?WNrAFglSJGWWuite8YI6IYeAzX3XLKd8CWKA2JtOXFQ5nPifeuD3nO0LAh?=
 =?iso-8859-1?Q?NmNUgV2paawHyjUEvoHePJKoohOz5sXF0ZcChkHA+Epg8iGr3QD4lYe1F3?=
 =?iso-8859-1?Q?jadtCCpdFjaNstxiWnwnP6/5OfFzS57WVR8jF743dBqYKt07wJxBsdvQvf?=
 =?iso-8859-1?Q?giuigq5p1DQe5dcxNDAot1XzjhPjAMNcC0SS+8k3AMJcJPqGbCX3jPvbXE?=
 =?iso-8859-1?Q?EK4Cy+/sPLSC5tY5w3EWca+tn8aj8QTQ6IElmSv99lEEWg7PVZkE8n2l8g?=
 =?iso-8859-1?Q?SKAi3eRzx4ameWSzoi9M2Sr2n5cLmyUpwMcIQXiFtfe2Xo4Mua/NcfDor7?=
 =?iso-8859-1?Q?HIMTNm7WhxP67dnZc7smK3J20ISkHOHmmuwlQadvuBR59C9Ij8BRV+C6S8?=
 =?iso-8859-1?Q?WxAN23uJbFbhnpxIDiraF1VCCkUQmuYhKfehj5UjIL6oI/E/46F13Jy7oX?=
 =?iso-8859-1?Q?k6ysXdcn0iypn48lpLfJ0uXvuBXerQCMabJ/ls1yrQwvdijulkzJlYy9Ub?=
 =?iso-8859-1?Q?8bN75D2d6W5ucuGHunmmFOonOhok5HOzB1mULnyoeeW/+NaURf1P?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3735dc28-084e-4f57-d832-08de86923288
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:06:00.2182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSK+7LSwmapR9Z/WbpnanOfyUo0zilaMPn/LgLDs/eCAyjxt3lCF0TuCdm4n4m9ADu9g+cPr6o1cHh0gUxFAbLON60xKxJHHHuIFd8Q8my4=
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

Implement runtime big-endian data support by reading the MSTATUS
UBE/SBE/MBE bits to determine data endianness per privilege level.

The key changes are:

- Add riscv_cpu_data_is_big_endian() helper in cpu.h that checks
  the appropriate MSTATUS endianness bit based on current privilege
  level (MBE for M-mode, SBE for S-mode, UBE for U-mode).

- Update mo_endian() in translate.c to return MO_BE or MO_LE based
  on a new 'big_endian' field in DisasContext, rather than the
  previous hardcoded MO_TE.

- Update mo_endian_env() in op_helper.c to call the new helper,
  giving hypervisor load/store helpers correct runtime endianness.

- Pack the endianness flag into cs_base bit 32 (alongside misa_ext
  in bits 0-25) in riscv_get_tb_cpu_state(), ensuring translation
  blocks are correctly separated by data endianness.

Note: instruction fetches continue to use MO_LE unconditionally
(from the previous patch), as RISC-V instructions are always
little-endian per the ISA specification.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.h         | 28 ++++++++++++++++++++++++++++
 target/riscv/internals.h   |  9 +--------
 target/riscv/tcg/tcg-cpu.c |  9 ++++++++-
 target/riscv/translate.c   | 12 ++++--------
 4 files changed, 41 insertions(+), 17 deletions(-)

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
index 3407191c22..fa42197e98 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -189,10 +189,17 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState =
*cs)
     flags =3D FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
     flags =3D FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
=20
+    uint64_t cs_base =3D env->misa_ext;
+#ifndef CONFIG_USER_ONLY
+    if (riscv_cpu_data_is_big_endian(env)) {
+        cs_base |=3D TB_CSBASE_BIG_ENDIAN;
+    }
+#endif
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
index 5df5b73849..d7f1f8e466 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -119,6 +119,8 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    /* Data endianness from MSTATUS UBE/SBE/MBE */
+    bool big_endian;
 } DisasContext;
=20
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -128,14 +130,7 @@ static inline bool has_ext(DisasContext *ctx, uint32_t=
 ext)
=20
 static inline MemOp mo_endian(DisasContext *ctx)
 {
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_LE;
+    return ctx->big_endian ? MO_BE : MO_LE;
 }
=20
 #ifdef TARGET_RISCV32
@@ -1346,6 +1341,7 @@ static void riscv_tr_init_disas_context(DisasContextB=
ase *dcbase, CPUState *cs)
     ctx->zero =3D tcg_constant_tl(0);
     ctx->virt_inst_excp =3D false;
     ctx->decoders =3D cpu->decoders;
+    ctx->big_endian =3D ctx->base.tb->cs_base & TB_CSBASE_BIG_ENDIAN;
 }
=20
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
--=20
2.34.1


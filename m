Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C845F46C54
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9mD7-0005c3-PN; Mon, 06 Apr 2026 11:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mD5-0005ar-RZ; Mon, 06 Apr 2026 11:49:55 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mD3-00021U-VM; Mon, 06 Apr 2026 11:49:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmTJbpNLluEjiwtCDihtpnbSMxPB0GqHy8BOXhRKZBdncUEGxVoBEPiDN6nNnjp+9j8eawoPQgqiiiO6HYhMxLsJm4ra5JeizG39QmBfRaXoyLgUHy8Xao0Wx0GD+OBGoBRv0hSe/n3WVvxwCyaxG9CyOF5HS8OIsLpDXdkcpQ5wukfBIRG7uVhcR520QFx3UazbPHrVuTQ+SxwjdJFjk6imsc6PI695xyTBi8HOd1X91ghMimPyufJdfq1mMbB4j2kT5boPQqXZmpnNmTUdZody3JPMIhMxWA3g4c4yyDeS3RGLQm+lSICCIH85sGh3XhArC0fyXycVll4HKqfpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08/sHQojIUy4zh5MSN5RxF3KfqZ+pBKOElAfPMDok1s=;
 b=wntZsYdhuevAKOJGLC9LIxjfUe63oKySV+GUqkhXIo7m2uLQXHGYsE73FVZ/z6K6xVw/bZHOLa2f4OMOnNUWCpWnUY0EoVPsIOY0hzsQBJiEbRl6+QrQfgm/DpfjnMxDB+xOlftmQm36PK1GUExubUBJqP3EA1kUYDVr+3OWGC5P5LPnLQON4eXEVb/SH/ReCVA1T9mUJ/vnFoDcrLxbm+WvbtHMcd+32B/blA9w0lFKI5eH6OQJKEFfWFxA9IW2NmLNzwbF/0l3b4a4LvXV1BUFHS2O5qJmUgznLgTt7dKqJK/wMq8DX4l8BXxft26pcYDrG4i4ijzcpXVRmfNjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08/sHQojIUy4zh5MSN5RxF3KfqZ+pBKOElAfPMDok1s=;
 b=r/Heu4SNvq2y24x195D19SyW1bRtzuzQxFvvlS/YKKjZ/x2ZwrRFUvpUuyin9/x3+kN8/PtbyAO2ybWk+d+pTUy4anASePRrpjK74XIcNEwjX1XMQ1+M2tpLxDgxX+BSnh2kTTV+sRiJVxIQkTlvrfOZwUY656umYmagWUa50x/Dnyw0YvnUtQn+Na3Pcu16i5nuvuoz5bKIdeh/j7/STm8pvvK5DxCbLw2kphRo1RDUNvogUZM5bI2KkSi7CffZN4kvN6vJc+Ns+0aqdOSGKvJA32v/S6biBfj+GRkYFYkZGPWVXDyR1Kq9jFyXHjysO08grG4qcf6j+g3JPeDRvA==
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
Subject: [PATCH v6 4/7] target/riscv: Implement runtime data endianness via
 MSTATUS bits
Thread-Topic: [PATCH v6 4/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Thread-Index: AQHcxdz70J0jqOWNlUqTEQuyJ5XzXw==
Date: Mon, 6 Apr 2026 15:49:42 +0000
Message-ID: <20260406154935.144674-5-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 7178137b-59ac-4f98-102c-08de93f41eb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: t4mb1KgDBRbTXdhwCk0PV8pf5z6SVFy+MAsWgtlUo+Gyh66jyNSOwIcnDzbNHH9ec4uEugWxv3wIKQ1TVaDZn8qhkEHAR8SJOAa1HMMgftYFgeASWWmE8Z5wIrBoAwu2c5xvYVV+OTonp+91I83LVA8eyV3lv/6BRz5epT70kwuIX0B4cVIuZLFiOgX2HSn+uE3dw9kPD1d9GTD2a8yhPLkOxBRqcxedg9vpPdvAijyiweUQP9UsoOvWtHc6Eqjv3nDjiZVXxDesGfB2eoAcT8D/IpgDz0Ku0QK0OftNwdaaRDsKsWM7G7nIfS7loNshhIdx+2xi5Nu50Bs9rBGnnEJXzjTSyG9AIQSM+KqT7Wmii5yWSb+zc7issPJe4tN9kXsvGnFKEUqWZuZJTJLihvO/rAAHLDaKh4E21/hMhVYl2zJ+/7ZewUwFrCu8s6ybM9NfGO0OyUkhe6QsAwrE80RhCM4CNWkklekoiL/pTpPPqMF2ukKM6SJfWDOtny+ndWp4t+0o2uoDPGLjileumxtpyjlzEUz+mGGvuhYpINTLZ7MCnCql2j1ergtqbxkxWi6XdC0xmTbCFTegdKY5td4y6qVXOMdEd6b8sWoUhn4O9bYFmAmZn0wqmqPxrAKbhCfoJ/0lkLyD/WD+8/4oDcg0FODBQgWhXjlRXnd6GxO48msUqzkEpUwnORv5rLO4ZgdNtZvUCtSHYfI4742xkyTxEXPwke97b05tnkBva5i03tds5UzvRol6SIebCeFnb9iGCB2+31v6RK4S2V3xaNEHYsXQYEZPbeedxoF209I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?C8CX+SUwaiGYY/cQWIyKZKa68QJBdh7Vkbx3r5Cmfw5XQokhDdbGDQls/t?=
 =?iso-8859-1?Q?NZUNrut+Wg0+dk5RW1NWv0dMEuSq1zKZGc/NPO1JwYCgW8lODG60ogQtNi?=
 =?iso-8859-1?Q?QYmPzcX4RF3D1Kwhhc9UbIq06uwNgBDbdEja32kes69y9QgMaHEDcvDip+?=
 =?iso-8859-1?Q?s3yZi+SK9TuUuAE2zQtnFJZd1vsgj2h0jPxoAxl7/f7DkEvhqMXzhbbvel?=
 =?iso-8859-1?Q?+Q+eNS1SxRSw5SlpfYZ45mD/c792bzMRt3GQhWbVdQn0iYp2c1OhkcP2X4?=
 =?iso-8859-1?Q?hWlYsmu2N5bb/gYXOl9HlQCyJGAN82tjbMvHnvjPGDPud1PjsK6G2W7Lzm?=
 =?iso-8859-1?Q?nczS4DSKGAR/n1nkYribwwU7UdZK2CeMae1N/Fx3f35n3QjW3dCKLzmeaT?=
 =?iso-8859-1?Q?RWM/XKzJ6+1JirqgWQMyLO05b4E0vjjA0QQtn1Nt3Aee/oZa722AURRm9b?=
 =?iso-8859-1?Q?sK+Nk+eShsmWPFksfcGQnPTcXZLXfItgbjSnYuiqbQMYfDKdbi66tMrb4M?=
 =?iso-8859-1?Q?d/B1zhl7X9dYuxsfBAolXebMctbAR1LL3SEDwY0VBesphFOA19A6BkA+hO?=
 =?iso-8859-1?Q?UApT3Yl5EqgNqSANJUiSCwJFMsBhob1+OsTsiPE8lsRJX1tcGJFbci0tuc?=
 =?iso-8859-1?Q?qvz+BZI97yxXYQf7B0sqNzXI2XPrVcPLeSOK8Q0EV+7oFFNGwaTJf7wk0R?=
 =?iso-8859-1?Q?MPn7SrfWQIBTDxon655ZDGCAOu/60xUVkXLQkMrKTAttHmj/JYSQCWF0aP?=
 =?iso-8859-1?Q?1UvjwAnXh9dRsd0ukQyQcX+n1U/5Q5ZfBlG9Ayo75AednyDPunD1c2hYii?=
 =?iso-8859-1?Q?KS9etP3BsSwNRpq8yZqFvx/ro8cyrZClHA14CnWQnOR5I+rpgePvh+9zx0?=
 =?iso-8859-1?Q?5494GNM/XE8ns5lLpNtyFUDAAwGmsXCMuI/yzY2l6NZdpG3rlVl/yrdAOZ?=
 =?iso-8859-1?Q?F7M59A0qXLVBWIoE39Sh9zA6Yy5F5U6qTPGqypjbX0ifXXLMJbo6xjTqlj?=
 =?iso-8859-1?Q?fLXPFhf2gFEN9jwKlcpF+d1AgiW3WeU5e1uWsabmH1b+GFy0J+QZAmcqWW?=
 =?iso-8859-1?Q?aOONKW9qqjsx4dN1gq2KS509IEKDL4Tmcc/3ADR2K5zb62/o5/l2xpOod/?=
 =?iso-8859-1?Q?fK23yvtmXjVaGtpBxSE+onQUgbQrvCzGXPILEeIH5sQ1lY6EohhTrHeett?=
 =?iso-8859-1?Q?gfNy8FZ96KZRXWfwoCpDYo1i7bwZbqeWysBa9UC8arQcUAUzLluxlhS5/D?=
 =?iso-8859-1?Q?G9tDrLOvNSYZmaIcD/+Q17jyb/tfPmjo8GGVsEdX5auPnhMBOVt5bRtPkT?=
 =?iso-8859-1?Q?4TATpi+X+aaFoElNMjt53OsqlSPTvGnqCvtmxDNBPyUyXKTrQAjzxFb5Bh?=
 =?iso-8859-1?Q?51sazzwxumrjnTUPprnpnlVe/XMPrx8F0k23o1s+kL2afFumWbv4S6OreP?=
 =?iso-8859-1?Q?O3mFk81JyvddHgqbeDlqvf0ET5LP5mh4ib6dXsGtIMR/HoerYTZaai1xRO?=
 =?iso-8859-1?Q?e/8wLPJa4XVns2FieX0BZsGPvLMkFl1rKsThTNhhS6NESNABZ3vsNeI/tg?=
 =?iso-8859-1?Q?tjrGdDDQI+N4D7+DzUMjehzCRvRQ1TZeXN0hdoCnyPkTwqrDFnob3ks6Z2?=
 =?iso-8859-1?Q?Pvb/Yrj+jqL6X2zu2nth2yt2e8YST82VJQ1MW5EES36z3JyjHu98BzjZu8?=
 =?iso-8859-1?Q?dJ8WUOe0+TRfVnfTBYflgUkzG6cBIymH4K9tlW7dYFAVPGw6y3NXYfgfO0?=
 =?iso-8859-1?Q?cHel/HqD8saACRBWkGXSmSz96DHBijJglODWRAA1MwfvfrXP8H71vRbvNl?=
 =?iso-8859-1?Q?IAvLjxt43jGewxU3FBq89S/AT8PsLauQVFV12GzMTz8x4EqAKGrv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7178137b-59ac-4f98-102c-08de93f41eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 15:49:42.2515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAvwMA4/YKEvPWFFPlvGfyR02X2gDaDqk7ykQRKoJP8gopUR2Ka/AZ2wDVD+K0YkHRZBg9QyMCFK20gikWGFeWqArN2Cqqz1KIPwn7Sf9/c=
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
 target/riscv/tcg/tcg-cpu.c |  7 ++++++-
 target/riscv/translate.c   | 13 +++++--------
 4 files changed, 40 insertions(+), 17 deletions(-)

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
index 5df5b73849..77f36906e8 100644
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
+    return ctx->mo_endianness;
 }
=20
 #ifdef TARGET_RISCV32
@@ -1346,6 +1341,8 @@ static void riscv_tr_init_disas_context(DisasContextB=
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


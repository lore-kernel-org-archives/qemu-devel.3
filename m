Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881A2F54AD9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54o6-0003nB-5v; Tue, 24 Mar 2026 12:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54nw-0003k3-59; Tue, 24 Mar 2026 12:40:32 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54nu-0005LR-C3; Tue, 24 Mar 2026 12:40:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osWXb6hUXIpYICGCuXtVpZ5w8AgX/Jvl6rFaO+y//TPdPQ2HeSkkgn+IdeAzS6RJCLGH6bGfw8d1oJT0Xgr6KVBd0jrwvz2q7dMeZJrAM6ttBBGUeXo0KKuf2oHnEwU1NOuUUDNIR6Kl7qt6f0lVNTpwNA3mRzFKfNUmKWSLZMZ2cnuMKmiw6UvUTRxExCxN4GxpkxEaOVvS7p/xECMpQ4Bk1YUSgbLVjR8x4O+S8oCKnaaiFHxYcei4GFMI/6o4VOiyU2pIRNW5dO+5B9ayisyTsuXoVUw5ErO0/IE/xhujs/ThftV52ATYa4GcDbwof/L4f19tbrZSpq+bLw/64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IvIlDTSCqZOcy60cvRsxbmIPpRE8DmuWP/+rIsbc2k=;
 b=nauqNKYRf3/UEYdX0rSi4SgrqfqjjfLIoLcpITcjn1NVSxiJrULdFHpaDeibQKPdSaUdl+w/BVE5oqoHRJLQdXQqUq2faPez8/1F4JO2sZuU/oUenFTgKMN72H+XGnQmhzsrQPGntMVoqNe9FFUak3Fugcf1iVZHXp3QA0VpSOvC9DRsX7k36c63uU08B8ABbSdhHr9Rr49u0JwhyyFdh7j3k897+fc0gfxU+U0nHc59fnSLLSVY/wptAmGhNJBPxu8gRjmhvEegciE1qoDbY7A49dKmHIipwtqMTvWs+RXIC3kL+ozrfTPe0QULuYynA81+8t22Qhp3Qbom69/OwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IvIlDTSCqZOcy60cvRsxbmIPpRE8DmuWP/+rIsbc2k=;
 b=jHB9Wq2LZnkjaQdvMLqxgmCnNE1yoI0v45tq+eWseizOx+u9Mhqwi6uUgGatA7bTTTE7lbfmb75mEywWgJ5/TALbRXbcD3T4IEO3R2SfriAfY10qwqj1fZmeFry1fdheTFotJpkYmkY7FoOPax+l9zYUgmuJpPxr+7GMl0rr7SBV6B935xEEKca2PIB6qUCcTvKvrw0MkmXRLRXD5U30CMc9nkXUjbbnvnI+Ojna1TugMqEyYohWpyBQFuSnYgodQa+FNGKN2WXZzOb5B7UIBWEugmAtboI6XhU+Qn4q2r71DR9WaxSPi1Wzotk5umpHX4JFMm/lJwP1/VhPG6CTVA==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6145.eurprd09.prod.outlook.com (2603:10a6:10:475::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 16:40:16 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 16:40:16 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 3/7] target/riscv: Implement runtime data endianness via
 MSTATUS bits
Thread-Topic: [PATCH v5 3/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Thread-Index: AQHcu6zkMXwXI9vy0EubjyivhQYRHA==
Date: Tue, 24 Mar 2026 16:40:16 +0000
Message-ID: <20260324164007.549397-4-djordje.todorovic@htecgroup.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|DU0PR09MB6145:EE_
x-ms-office365-filtering-correlation-id: 91fce064-51bd-4081-daec-08de89c40769
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: DJIlAviIpFV49NxMe6Lqyz/5l7RiDbuu7vI++nJyBMDg45wBrEDhpTvVRwf21/X410PGa0ovcGjd9uKxJCSDf5ru9wR+ksJN2qhxJqEof9Za+I6gLQEx2Kw7qaFzCxENCIiDfQNf5Ll9+JVdRjmvMB7AzquxfzN2mEdPhmqfqqRmbVHcjKO5yvHdYSe0BKafEAuhs2b0x90ntVTnnGwKFqAhpoHhjIo8uI/k+l3THEOq0YAA1Ev1B40DJk7UoDnYonM8NxXdrhKgB62nItBA+W3E61ma4dhsDiGZePBDmmz62fiAlbQ4yC/1wrnpS1wYSyIIHP2PBG8hwxGgyEstL/KM0dA692vWGcp+1+PtmGsku+kMSz/Y1Gk8jqtilxOCAUiyCBbewErXNOoG8NC0rdO3oaaGwVh9BzuP0BhivlTuYwSjRWsyXzVXQKHEdgWnF1cUSJ6QqsTDeEy9oOFJw4GYlVGROxJuf12XjjXsNB7XkilW2N16OhY936uctFUVPfNIRsGlp9PGc43Clqgy0zZ9WP50LAX1zEj81UO1bNdrIcgVaYc3oi44ZGjCuF/JprHaYcS76yG8WcsCr9TivL22ZcY+QVcDR4iFImkBj1037gMEM+bq4M6BxCbWmotk91ST29Fx8WGSJaqWCGQHeE4lBeS78DlP5OUMTdcgmerrxe3oCFftayJGqCD4yEJy0TfiJ+M2zuVFRkOs/qAfTdvvok/hJqY+1frfp2uC5iHhcSTCLlWxd5iU1wjzrh3/Up8Dm//bdk+Oo7PIyzNZuVeykTh8dviW1CJlygDlj44=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vxUJvZKAwucIKGnnbwbrcFZWp8n1Y4B3ga+fddpqvvPJbk0nVpH/nlvScY?=
 =?iso-8859-1?Q?Pgy0x0GwfJW4fVpxClPOPZSDBQ2YMmiHB59HeBeI7mHFTHGpX7ey+v8xl3?=
 =?iso-8859-1?Q?Rpht+gTQepBeGokZASrq3pZ3AijDBD25bQLQ1ym0iEVu1gZk4GTLenm6tE?=
 =?iso-8859-1?Q?I+9NxNUW6PWogl6IhoRSoKuiJ+MUPmXT+20fSlXXyXOjNoFrFfP/t4/aBO?=
 =?iso-8859-1?Q?4Po3qR5qKEa45EznvbBm0mKyg4qze9P22aKUL3nfTIcB6RVr+dtvrShxc6?=
 =?iso-8859-1?Q?hnVIkR0DCwtkXcuhcxv1+FmxiuO8gFESmEthuxXaXOD8ioLwd3h93Nh//C?=
 =?iso-8859-1?Q?4HEtvFjVHko6k0yQg7Umf2rpzUZ+LA7eWTpFMYnq9657qW3JtI4GMfJjCW?=
 =?iso-8859-1?Q?5G0Y87xLQhOE3SFJ6WCn7MueVzgeBSiDt3CNQgJCSfN6Imdz1xL3OHn76U?=
 =?iso-8859-1?Q?/OlBgGZGKimZ1v4DKamLXACrW20gcrIM7Ebsge0bbg9XOIq1WFCyzjdPbI?=
 =?iso-8859-1?Q?IUvTd18ZDzWPMytTwGYOH/GEyqp/JRn6J0P5DNRzJNPV/qBMTy7AuU9Hjv?=
 =?iso-8859-1?Q?5EXX9rVRLW9LZxdYG4flhpu24i7uBO9jnZKxlVXnU5lqZogCIHSueBApdh?=
 =?iso-8859-1?Q?uHhNV3yE7tg/iUo400kFlFSNqLfyjR8aPvefXWtRoI6dFuW7xmnsO4vykw?=
 =?iso-8859-1?Q?ff/oDF5gcZ3rdP9W9IOnIrZrH+d+nesE8MX5Bs44/OMJBu0Cu7pNwhH6Bc?=
 =?iso-8859-1?Q?WIFAvDjeLRdnlBZDmSlFxyV07L86uqGbgIYiTybxGblX0zSgaJvc6kx4fE?=
 =?iso-8859-1?Q?CbMl/euyAstZxWdj7rspe75gYOJG+51n2C3l20e0eDuYDcUs07uZMFk69/?=
 =?iso-8859-1?Q?dn06GThBNs6ULxLS7E8yoOovwkPZMMk55aX5lfBgHNWpRHhdvyvON9I1Ws?=
 =?iso-8859-1?Q?dq9Bd9RWNNvT/xkfJuSU/btNH1GcwXiubhOSQLFFsYnFUzdykbGI1XBZIH?=
 =?iso-8859-1?Q?bZGJuaTv1AeuI9nnc3Uv39YKZT4DJ4LFVBE9artPBq3m/vL5IAG1ofXB9C?=
 =?iso-8859-1?Q?TZK3agliw2z39t7sQWFPYY6Wi4bU4T9rn0EwR3xuwkXPPXEjU4Nk6tcj4L?=
 =?iso-8859-1?Q?n/+BxTz6bB0+cqwG0Nt6tCC0VT4kG3K51qIUFP9xGv8AfdK1i/5A4pzgaV?=
 =?iso-8859-1?Q?iITsfBaVoPUaEuP+J1B+V7XjqHgtQ4QcjuJrZaoqUnz4SbU8cmC8CVkTYO?=
 =?iso-8859-1?Q?5qZEZ3jnhJsCeV+FFCN/SqP8lE1gEsKyTw1NEB0dD8h2Eg2qWGk00m/RIC?=
 =?iso-8859-1?Q?8w9ih8CQqB2Y+e3jEhypsh1IVbyya9vYQviX8xBf+YRpZEPrRtHVe/QRgu?=
 =?iso-8859-1?Q?/P3LFAmIxu/MEReJ8p94gfM6pt7gUBb3lxjxXEkTzuQndGGzy9IZAChGQe?=
 =?iso-8859-1?Q?l/LbzRQ8IA6tFpNA/nZAJNA/QB3bY6tXdDJ4f791DlM95t10jwJag5Zt4b?=
 =?iso-8859-1?Q?+VfLkGW5RXrlHq3aHiI3l1/N+jAVjlujJl2TYN5+H7CpSjHQBDTxa/Y1OK?=
 =?iso-8859-1?Q?dQDxjnujep0MU2iPlk38/ae7umHDTQhDo63Rz6QwagdQAo81e4wEgqyOi5?=
 =?iso-8859-1?Q?3yyn60q1Qd+rlucUK+3mtc+1qKesRzm26zy1asA9YNNMocque9o7EfUTiV?=
 =?iso-8859-1?Q?q0xU2Umj7cBZrvc2maJFSfQjqfniEFDeNYX8ehhv9R9jsz6r2BU+gRNZ0E?=
 =?iso-8859-1?Q?F5zrhjr2cIwazEoNMJuoPZ0/+kTUboh6dR5Xkycps80zOzxWr7fRwguIS/?=
 =?iso-8859-1?Q?ayoYBU4moQH7xmmZEu/JYNEn4PUOu3QO1FFOgGwitT6Bi6hdtIhp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fce064-51bd-4081-daec-08de89c40769
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:40:16.0667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqVyudgTAgiC1ME9VNSgujlbcXdvLZ5/jMv2s1JU96cNt9QkbPUln6m1s83yS/k8EvjdQm+R7rAExC4M1yJp8CsAjemQGt/HrzfR4PSVO0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6145
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


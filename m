Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0961062871
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IEG-00009T-3z; Wed, 11 Mar 2026 07:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDu-0008G3-8x; Wed, 11 Mar 2026 07:59:36 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDs-0004do-I0; Wed, 11 Mar 2026 07:59:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HlV/8Yhfp+IIPIpcv+KdhZZWy2Sr4aRilrAlKkPP4FxiLmMj3sNg9NOUnWCQHoiKqj5vsCA5sPVXg8fKx+QI8ToRd1d6Scxw6wX94lFi2+sRTvRo1ZViRzOJLCtHdJ4u7qTWPYVULDbzEdMi67JwvFNrbgyBEG/3nVHtI9XCsZnFKu9b97ytptAQ/6akpnmI4b4R9QR99AU969qTWP9IwrPbDOLnCoTT/K7kAOM+d5yDOSYUwQN6myRMrMeisEitTMECfeFEhWkQ8gu0bRGddlClh6m2u5DGrhBGiPG0FhT0OlZ8EH+tPpkMv27h0v68LOVr2v4FZA8CO9BNXJ22wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+GpSTI5UkPta0antcimc0FXxOqrY16NPB5qieIlurA=;
 b=nOSwS6OIgmVxpEl2XA8dNbuUr5IM1k2b6jdzp4tHa7Ve8eqJh4QdTTrhMhuL8w8E+Wtvkm8EQPbKSffQyiP+N6PkeK9oxAmJlfLkX7Et8PfkyCGsjw/xTBnWaonxVnYIslndYPEFI9LwYkwuJCNz17uuBR4J+if6BBSotA5oIK+nOxCqJnRFVZgNhnFB09/qzBDe1RgPdEh5kyFNmMtpmp4VROI0R28GcHFXg6bLYhgNnRKgwr3smg5nDvkknqMbnpv5/UAod+8ATvI0+mNJkDXlfbVtgHSGY+VrVr+goh1zHSWKSR9rMV2xXm3DK0+dYHZL3uQU6ZDNE+u6n4+EEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+GpSTI5UkPta0antcimc0FXxOqrY16NPB5qieIlurA=;
 b=KnQW1NF2PKyoJq4jz9tBel87PW8JMsrbNRsmDKaoiOHgWzfGPlFSYnnLgRzIhRm1H0jqmE2WWTb5K7IUq+cYulSqn/e/pV2ZXhfSKp0TtoMhWkviKSEHiR1uyot3uPpTjo5gehV7PIHlxMcBYNYx9WDvyh/mCtEtFW8vjcF4aRq4ppJ8qO6UKIC2L0WzEto49rJQTqtStXfIc54Uc/XdPD6LyZIYlSwQEi+R2YSw5UZe3hGGyplLf9se/iAIqh84vrrSzKDnxSu7U5RAd8t1zgaKGpdsWm1uwWysfFh8wf5yD3v44v9vMbT5PcJOTaCShDh3gICxtirsF2OBeaM+ng==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6069.eurprd09.prod.outlook.com (2603:10a6:10:407::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 11:59:19 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:59:19 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 5/9] target/riscv: Implement runtime data endianness via
 MSTATUS bits
Thread-Topic: [PATCH v3 5/9] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Thread-Index: AQHcsU59CU23aLKwv0qnhqe/n9XYmw==
Date: Wed, 11 Mar 2026 11:59:18 +0000
Message-ID: <20260311115910.564481-6-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: b8126018-d71b-4082-138c-08de7f65a0ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: GE9Jwvtntlz7xOaEGrKSoHUI0kkZOYaReS6PiXCCv6qXjBA9tvCzSYqvxkVedJAdU75EyjZpoR52rwSsxrodRhSw+M8/cO7YD26XrjhG0g8KCd1sGtW4y+PSZSqfkyYb3C+6Ugvc197gPTQjTqEcNJb5D/pZrBKT9u8HH93fhx/C4WXLmjpyDgoyyPEDnSMoisinDVNaM2Y/PYXLEaXlnnZh/Smbu3pyPNodPH9xhtGqVhLCR+YV51VZ0T+jDkFrGxhQYERzylkcryDOr7SdP7lraZuZGZE3s9xMcqy7p4xfZokU0Nwo7/fwCPbKY7UwpAnUXnXCWgU3A/1Y6BS5iNaIq4bpWMe+YpgtCYoUruZ9Vjktn4wM3dxtp6qV+2M3K2r017p5nwgHZv/Nx25kg4ApZfxn80Hfd0oxBYJfrMZajjyog/o5Jdp/u+arxJT9U2lF6sStP6ghYlS51Bork/uXj2hNSsoVpIbMfH63gQOBmhIW76x+bvY/YMghHz+EvlbSQ59V+HcO6RNKqtfGn2633Qy96WCGsoRCUNKAJMqXtX4AztS5Pvvj5p6XP+/FGJcS17hQgU6NWxkNfIgYZASKaS9aJlMTnivQvJ938aoTwk4OZ2dbKbcap8RibPQ6ImKJTakhVitgTakEhrM8QG4EL+9zU9G2ZOc8D4Dw8VVK43yH+QyNFePNVfLSahFZjbh53dO8iG+ryl5b7f31DkxTSzc4UyLLstRh7CP8BlCFPnbN0uxJAyIaMkzWdvRmkHvFR3aK2Jk/jJ+mAsbjD5oA94/y06GqSGS61anMctg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H7NfKrsu8DTtJY4Seh0lKQhWdX32SMG63Synyb/RaaISX6gW+J1ZZPz8I1?=
 =?iso-8859-1?Q?hJFVctnCQmEWhuky1MFgC5IzFwH3Q3VyNXEGJRUqE7a6Ro+2OSbBnFvM14?=
 =?iso-8859-1?Q?+NLPuibZXq5nravJXuO6yRvlUb1JReXzkJ1SxyBq5w/gpZzDC4f3uqT2ij?=
 =?iso-8859-1?Q?p01Go3jigsrGXeoRT+56qeAKQkTlDyCruNoooHNZmfvLAbYGjbaQIR/yB3?=
 =?iso-8859-1?Q?UVMH80Z0DPClWhfIOdEyiSagyJ6G65nIxuGJtsTxdiyyGdKjta0OGvm+Du?=
 =?iso-8859-1?Q?RMBLR7fXDlBaM4FkUeIye7FP7sYPyGsOCoqQHL37KGIA6skJLA5hzuXDWb?=
 =?iso-8859-1?Q?TK0ekf6HJfIXu2CcqAnjrbT0TlyzbeWNYJoujgLCnHqq8GnHYclydXv/Rn?=
 =?iso-8859-1?Q?tORWMgSCZWLcA5WIkPTemXdtirEUMHgR7tdI5B8UanzmFB/9XnTOdui+ip?=
 =?iso-8859-1?Q?Ee2z/biV2E46a49q2rCvuyb7trf9TGNlrLW2w5Vc2nzv62DOTH1L6wZ+Ww?=
 =?iso-8859-1?Q?DZ0Tx4Dgyr7Clu9TwgwCbtlgOwQ9H+EAMSlb8rxddYFkvoyL7QNxEEJMg+?=
 =?iso-8859-1?Q?LOf4bjltZErRISw2TkHTmYIvW5Jt2NVI3/OSmp+BXsgzuPaq6ainpo/BDb?=
 =?iso-8859-1?Q?6Z8OEEFCWvI12ETmhOPYNbMszqW7XY61UsG2grll3Qfdv7voJsQ0ZMQ+kK?=
 =?iso-8859-1?Q?u3prCY3fkQcScwuYESjk3vjr08nymte/Iu8fi4kwmjjbPAAbu0denV7vAG?=
 =?iso-8859-1?Q?cLeUXU82UX+Z+pyNxtkjaz7m36G4VY3myQ0GHp5wQRUSN55KOFl1l5qsjt?=
 =?iso-8859-1?Q?9h06mbEV0bLrUb/XyTgDTvGniMbr2v5rfEUJP5WA2EvjLADM1rjY9jqgBv?=
 =?iso-8859-1?Q?BFZLPYE2/3z61/eGVDKew98IEaJU1URIR0BpTRCwELCXoN9pJ5kWbiW1aD?=
 =?iso-8859-1?Q?pGguitGUqsr5FdtRgyty6D+Q1FSBzfV0tAqhEmMf22gC/YQzL9jcqkHTVx?=
 =?iso-8859-1?Q?wZI7g7DAdgFpmOXKD2b+/ReND63AOuWCi6c923eB87+i88EjklYYyFIcN/?=
 =?iso-8859-1?Q?EbvX14Jm1emyggwEW0v3Y/sUULQKN+m1ARhvIFoqf9E6pS1lFIaV5IlZpc?=
 =?iso-8859-1?Q?AOKgk8lmegWsdaSgXrk2WRT3jS68OdLOY2uJ5IVW79+mjT9RhFXFgnyInQ?=
 =?iso-8859-1?Q?7emTjwBfLMmi6E4ezpMettXRcnj71G9mQMksV0fdWb4jhEhCycnGxCSanT?=
 =?iso-8859-1?Q?8incrkvvVtbDtVDB/ws9QK/xYJk5kMkpUjJfv6JzL1tS3blygiJ7uh1eci?=
 =?iso-8859-1?Q?TekxilCrJA1n2Owd3OMW0mbYnv+/FOMXwrS/vxfofx7vIWhnSqpga1Okhu?=
 =?iso-8859-1?Q?647jOljtAFoPV9hDKB7zleV91gcFn8YeVbDH0ttet/ht09DxtRaNSLe0EE?=
 =?iso-8859-1?Q?Ad2Njd3nFUAYCMcfSPcAnL2OVdWK4jH+5Mw9jVYFmZDkmfjV9m1CZywoWX?=
 =?iso-8859-1?Q?JminipUIZJNpTv268GH0glOMfkuq56hWrFLsl/2itUvp5LWpCHx2EAp/0P?=
 =?iso-8859-1?Q?D0AQhEuMBlhtDh06x7LlUmNiutQwkehdeozXe4m4w5NO7wp/pTdlYCSj6s?=
 =?iso-8859-1?Q?9n0Caxca7k2s0xHenv5t1NFpPzzu4WHWmqdgBP0dd+9KMSHy3s0TFl9dP7?=
 =?iso-8859-1?Q?b2rQlO0KNUDOXXj6lnBFb5dEFuOpXG7dKzncQ3wQeISeUSpt/c6AwYIKYD?=
 =?iso-8859-1?Q?H+Cc988oswJtcvBiWW5Rqkn+v8xHKx6swYEqYQgOA0zlT3fO+jfM5vjKvn?=
 =?iso-8859-1?Q?sim9NzY3mZlgOmiFxmRkkQVI7oXecYSa0A1smrGYgTJ3197fl3S1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8126018-d71b-4082-138c-08de7f65a0ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:59:18.6725 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2RRY+nIwQrtPfPkd+v69pglh+xk5TuxUdzy8rVgZz73jezqN+/ZYBkmOsgJmZ6zUtjK5GtKo6vHn/Z/lSEAWxI471J/ytFVj7Ty48jmI24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6069
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
---
 target/riscv/cpu.h         | 24 ++++++++++++++++++++++++
 target/riscv/op_helper.c   |  9 +--------
 target/riscv/tcg/tcg-cpu.c |  9 ++++++++-
 target/riscv/translate.c   | 12 ++++--------
 4 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 35d1f6362c..c644462dfa 100644
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
@@ -729,6 +735,24 @@ static inline int cpu_address_mode(CPURISCVState *env)
     return mode;
 }
=20
+/*
+ * Return true if data accesses are big-endian for the current privilege
+ * level, based on the MSTATUS MBE/SBE/UBE bits.
+ */
+static inline bool riscv_cpu_data_is_big_endian(CPURISCVState *env)
+{
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
+}
+
 static inline RISCVMXL cpu_get_xl(CPURISCVState *env, target_ulong mode)
 {
     RISCVMXL xl =3D env->misa_mxl;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6ccc127c30..18f7773a38 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -31,14 +31,7 @@
 #ifndef CONFIG_USER_ONLY
 static inline MemOp mo_endian_env(CPURISCVState *env)
 {
-    /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
-     */
-    return MO_TE;
+    return riscv_cpu_data_is_big_endian(env) ? MO_BE : MO_LE;
 }
 #endif
=20
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 988b2d905f..e0f8fa2734 100644
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
index 413911f7f9..d7f1f8e466 100644
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
-    return MO_TE;
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


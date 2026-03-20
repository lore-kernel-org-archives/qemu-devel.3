Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF961098796
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3bQf-0002wE-Sj; Fri, 20 Mar 2026 11:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQe-0002vl-Fz; Fri, 20 Mar 2026 11:06:24 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w3bQc-0002Q3-Uo; Fri, 20 Mar 2026 11:06:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLtYmpdMH4bBN543dNxNpnNb/0O9JXbLJApw8aeMamrptqaD1hlp11OpjLyjPgRfKD6Zj9e2Q64fHIL7qZ18Y9ij+MRLLGeR8D7Gp01kJ2WaZPxWQhmd4voXb9X2ebRlI+vpkdz9q5+McwHE6Md500JumcqHI6NShrS7aF0SUwaZJOgJ74+qhQNyWzQbvwhMxlpiqofXbjdbUNvaOJVnAwrLfXGiRFnDhXidnooK9MU4hGfdNgZ6F6UlcX2+OqLLiMQ1GlQ09FVWZHUgDWWXkF4G21F46fwY4JCdfc52Tw1C80jWaDold5Qq25wspnCX9fE2rGpSLcqKGS/Gnih94w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8M5Z6S4ogZPxT8/5fxf7hLQjOASU894pYLJSpuE5fis=;
 b=vRIo5IK5xue/qDIXbrkIkVpZ8t5dBu82v+gYiH+Bh8z5q9zIr3mfpIsN1lxPWbBqN8Rl54KQpQ36YkAZkPuQAxqHQIogpov76Pf16K/Mlj0A/N9627tlgnwlH6aLo3uBS6CV7PpnC08a9Du19TsC2X5j8cJRLP4LA3MZWEaFeE2KYWMkml1ch9yaXFZhXyV7tFUin5YKZaH+cD9Lp3B/4fzMzeAv/+F348L0BmKFcwfZxS1QKBOQIiNqqmNiPFxKEwIbWpVjPpNNpdJdc+BfkzHs3jKi1afk94RpOhqajpFZ3YNXwMfGjsYhdvemr7G8lC1jHXWf0rW944eqPSe+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M5Z6S4ogZPxT8/5fxf7hLQjOASU894pYLJSpuE5fis=;
 b=nGAAbwMDP7q+GZFxjoznQ3tHBarVQrJtk5aI2kMc6j1CzXR9yx3UFU+QK1PAj+FflStfXvqbQG/SJ5XCzOPxWdckCwD3w6V1hoJ8VPMZvc66Rf7x66MQGUAUgjNQF7cXvTyjdGCWd8XkUhdsYYn4LJ/llacGS1QZX1/xs79HNzcX7T9k7YaRChF0RM+F8vSuf9uNAoxA7hLVb7L5NEQE46x4TMvoEiQM1L5NBVTtCutN4lV+BCtVu4VM1wXfaMak2Fl0D+XKyyreUZ3PAXioINEppXD/8dvCSfkuSuuZwXmedawt2vSE538WCG5ArayviQ+Me0eaORwgjbxa4cd3Tg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by PA2PR09MB7446.eurprd09.prod.outlook.com (2603:10a6:102:40f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 15:06:03 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.018; Fri, 20 Mar 2026
 15:06:02 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v4 7/7] target/riscv: Support runtime endianness in virtio via
 sysemu callback
Thread-Topic: [PATCH v4 7/7] target/riscv: Support runtime endianness in
 virtio via sysemu callback
Thread-Index: AQHcuHsQc8iwW6haQk2z5mk2ezRqDA==
Date: Fri, 20 Mar 2026 15:06:01 +0000
Message-ID: <20260320150552.169480-8-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: aab2968e-a076-4271-f1b6-08de869233fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: FLJV5yecMv40rZYO4BWPc1jHUI6Y7GZsHOomLjdlTeI7l5Z9F6XAkA5h1TR6PaEmNKqMqRTJqFHgxZumSr6U33NxNy13bGp7qfa7Vh6u2+qdH+76rD/Fw1go+zPsPvudc2JvgSvmqXBuXgR7ob+4M6tx1eBNrgE2i5KZVPrsO/EvmMyrjWXT4ompN7fR2nNGr37kli2HUvejsPaT858EHhyw2gaOaOuKGUrgQohF9BHLX27v5vpdJ6MmxV8rWk5Fo1vhFU3iLgUEBOP7f64EviHMv1QFuAQ4Lz5Yyiql36TwOFI9cYt2dorKHt4qU3mpaztB4tShaENyY2Hu4Skv0CNYP4GBxsUxKUdwCLTcckhnmGYBaAiar1vs1ON4vopgjIZtmpx77bmIhxrV/WfMpjHFqwuLh80J5grcQhaQovFZAS1PkFOMXiSEhzOvuU+kU/EUqEAO1XDRhJC720k4LDDp/s9xzm+wAPfiYyytQl1k1d4RagSIvjREb4nh2t41ysQk9RABg/BIcAEYY8MTXgiWGfVSy0ssy9OAIrJccoJYQCT57QKST0WyXF8UbZMrVzwBCB5z3aazosUGC3bctxOY/LC/iifYP7wZ9bF5EODMaqw+wggXuewVfgfYuUoUlrtHAaomHuGJ9NOzQ3BE4gH2hilUmWaBUSIJHbNoAwD4jyJEkMfPMHcJZluUCOSlA6w86RjCL8TtE9juCazcfUb9V0RLqUzzHetNY6kQwawFf9JNZAvIeni7Wp11NMS21TaCqX6jtW/MMw44KaamO1uKkE+cDxItIt0stwTiXag=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GlLqHRp9PWJYbKcwUVvEVyGrCxvdb/pVHiP+nDLYQaqqBcWawyOv0CioC8?=
 =?iso-8859-1?Q?OFuUp1Rik47TcHH8tnmnc75g6dP0h5T9uMqBc63jZP1ShqzQSo7/TOAmLW?=
 =?iso-8859-1?Q?660YIKXREkJ4n2bwN1iOuLx1kXYf0ME+PSFhxkVkKF3MYpJO5rqD/KO9Uc?=
 =?iso-8859-1?Q?KIkgbrM0YTfUZkksoduZCXRtxd+ofsTodzDFbcnbQV8Jjdqr8l9lzOrVXC?=
 =?iso-8859-1?Q?n/CI2soxBC5RiKHMtBFRnTE7SuyP9aXHY5kUHFfMu492MsrzIgmIdoC71o?=
 =?iso-8859-1?Q?M7N8JRcQTK9K2SXIv+1k9U/h0geG1AyyDUGqz1O70b81Vs5eOFqfZHpjXU?=
 =?iso-8859-1?Q?rfy00pEfEklhOroRb1/m9YsjSVq4a38F9k3uVmfiQpq+RUiJqSeJdy4JrE?=
 =?iso-8859-1?Q?yJX7roowvrdQYuMfZ+aOhM++BnXbe/j/b22ZVDRETvsZ3gS4B1sKXrPXBk?=
 =?iso-8859-1?Q?OLFiPQH47qPT+ghxk4WsPKgR7+wCG+GVnSxQbqTryjNDb2Ns3f6SsJd37n?=
 =?iso-8859-1?Q?Y5mA4hKqga4B+k/GDOaZI3sx/jGTNhajhTC6KfyHsBLyMTkgcqkI2c0hji?=
 =?iso-8859-1?Q?wTyOj74zlXY6rrDIVHQMCqBwodw6dt7Wx8xQDh7E4Wg26fwPBLBK7pgqpR?=
 =?iso-8859-1?Q?i+TGRLPiTTAMnJCu7jQz/bWr47ApoGvpGxFJ83+FF4oMD8S5KlE6aMVeJn?=
 =?iso-8859-1?Q?CiG3GxIODzcXQLiH09JiARnKWEOYdY7SgLRF4wVAHp1XB/DMT1xmL4MfHr?=
 =?iso-8859-1?Q?7ZWWiCKpwBNoFkgcWpjnRWXb42Y1zuia3vN7FOluFbkA6TlNPYEl/+gfZc?=
 =?iso-8859-1?Q?UG/FYPQVMR6x+9sC7ZmUdK9tzShZzTLg7smdso2I4wOZ5i+WNVlHyRbBb7?=
 =?iso-8859-1?Q?vQq4Or/Vds3IdWXG4J8Q/2blLj6MVJp5StBFGcZcEFucCFtLBApF9ETXd0?=
 =?iso-8859-1?Q?e6gV60j+kNDXj/wfNUEA1Br8pYRdeIkIR522VCjP11rnsbceQKUo7GVUJu?=
 =?iso-8859-1?Q?JfwPWAzJS27EueW91I+1+21+T/0dWME8t46HblTkqGbe137mr2KrOltj4Q?=
 =?iso-8859-1?Q?NON0WEDumM8kuRFYckN1NInio4IekuCoDcAd01x9osP2Uzdn2g1ss5zBZ+?=
 =?iso-8859-1?Q?B2eZaNoAQfHSjj6Ou9nbteixSNj2tV5PzTgN+QhnUnto+5yyPgwtHuv0v3?=
 =?iso-8859-1?Q?0hkBkKDrrw/VyQuDZmVQE8xGAiyDElGrm/dA/lSxMqk5By0mfdY52vjI27?=
 =?iso-8859-1?Q?BQbphKB+pXhyWr4jdG+rKk3yZHCy7qHxiCGDrF6msccunUKe4pidix3XmM?=
 =?iso-8859-1?Q?9Px69ovOl1LGa77ViqNXbnbIfDqnf1+6b2KL3Gy6skdjGBlK2WkCYYuvI6?=
 =?iso-8859-1?Q?Ya0zLMBW0hGb1w9wjkW6tS8YMn8CRlKKAGAcpjnmM1BdJZ1FrvaXHkKkDJ?=
 =?iso-8859-1?Q?fhq0xa18frqHiwr52GwcFBHL9nOEb0t022SWJpwLSt0iSyuIG6Q4zO9FdN?=
 =?iso-8859-1?Q?cRP0nMr6RPXQHWGWc2QOpp8Br//VOJc+av64zk6g3HUoNaGEikK+C6DhY4?=
 =?iso-8859-1?Q?CDilEQE7w3y8WLIu8otbrQBMT/WjqjBU+4OBaTMMym4bKE1iQYcoE8RzpL?=
 =?iso-8859-1?Q?RnacK2BDN0CslzjficoKC3EevNrqCgykBrpJrI6HR+aXpIxsjLWSz3j3g6?=
 =?iso-8859-1?Q?MgsNaYMWVP1Ie7ERci8C2iUhawkykh3+TL09YN7fVNf5k01wbtlcqCjzzt?=
 =?iso-8859-1?Q?Lyb64zvvC+M3usY9hepobD2kN/DMK9N8e7d5IeMxPHxqezc4ptTZGlbJGj?=
 =?iso-8859-1?Q?tihweSTeBA/niLMtw8R4R3/ohKyuKy2tMkwjHzbgJA3LPXik3M1U?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab2968e-a076-4271-f1b6-08de869233fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:06:01.4133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1X2n2wxQJ2WuxTZa769qNvYUSaJYHeqDbV8Xmrd3pu5H0L3cxko2vYzMdiUmc+3iasTvsFQ9iOcBPs92kGMb0nPv5T3EFmjQauvR0V4/+3s=
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

Implement the .virtio_is_big_endian SysemuCPUOps callback for RISC-V.
This makes cpu_virtio_is_big_endian() return the correct endianness
based on the hart's MSTATUS MBE/SBE/UBE bits, which is used by
virtio_current_cpu_endian() during guest-initiated device resets.

For bi-endian RISC-V targets, this ensures legacy virtio devices
correctly detect the guest's runtime data endianness, matching
how ARM handles its bi-endian support.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eed5afd27e..f813acf579 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -32,6 +32,7 @@
 #include "migration/vmstate.h"
 #include "fpu/softfloat-helpers.h"
 #include "system/device_tree.h"
+#include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
@@ -2713,11 +2714,21 @@ static int64_t riscv_get_arch_id(CPUState *cs)
=20
 #include "hw/core/sysemu-cpu-ops.h"
=20
+static bool riscv_cpu_virtio_is_big_endian(CPUState *cs)
+{
+    RISCVCPU *cpu =3D RISCV_CPU(cs);
+    CPURISCVState *env =3D &cpu->env;
+
+    cpu_synchronize_state(cs);
+    return riscv_cpu_data_is_big_endian(env);
+}
+
 static const struct SysemuCPUOps riscv_sysemu_ops =3D {
     .has_work =3D riscv_cpu_has_work,
     .get_phys_page_debug =3D riscv_cpu_get_phys_page_debug,
     .write_elf64_note =3D riscv_cpu_write_elf64_note,
     .write_elf32_note =3D riscv_cpu_write_elf32_note,
+    .internal_is_big_endian =3D riscv_cpu_virtio_is_big_endian,
     .legacy_vmsd =3D &vmstate_riscv_cpu,
 };
 #endif
--=20
2.34.1


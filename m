Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F15AF54AD9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w54o3-0003ly-BV; Tue, 24 Mar 2026 12:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54ns-0003jZ-S3; Tue, 24 Mar 2026 12:40:32 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w54nq-0005Lv-6A; Tue, 24 Mar 2026 12:40:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIEpJqKZrUpEVZVXDvKimLsmRkUMetCHbGeKkf4+ksim+fZw2oy0p8JJb97ph5eA6rk4fv0pFaX4kjj26zcLj/dwHHJFvZQW9loEgRXZkOsvtP4Htnc0s3Dy5QComb/tKytwHFvp32OraWUSaJijHA4Dgdda13I4xi3pSsNGS47fhxnDfL+if5yXE/qqNjfLZxV725YZBEjHBP2rx8P3qIlc2miZxzQZcTAmYZCEAqH+5BMUWbU5unsDDIa4RLE25EWkQUCKJv3tbrLe5/5pMW4wRAaRMz0JsLyhkMZD2fSec3+fLD2X69qAWC5GHG1132UMyzRjpUUz4Jzp59Ek0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8M5Z6S4ogZPxT8/5fxf7hLQjOASU894pYLJSpuE5fis=;
 b=Bs50i2T5spRSgo15CVlx5quJBY9axggq9jpSGYOP866weiGHbMCR2JsLPglorqHqFDITNT1xm+3+AfHRIigU79idAHwFuJYdo2YPJJG+sZ5TD264FH3dnlRCDfL7m4hLG6PfOu9jZlDmB0uK2JKV4h5AG0RdNcfEl5R6Ze0GxiARL03FPmnt4TIh6YWS4lgUl3aypJTktbuxNAI6z4AiVO5YL7eR7d3G0Pp3L4JwxUai8IWyJNmy/lBiF+cXYxi9etaBGxN8Jl3ijDZFJXLPHc6uokaXeaOVJOIu5HSChv8L8MQi5zELTvH3I8V7j/ZMqxSR8gVBlrRp3AFrkbz72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M5Z6S4ogZPxT8/5fxf7hLQjOASU894pYLJSpuE5fis=;
 b=kI54WT3BUXttKYPdcTO7/pcX87NJXw09zst3UZotPkGCGBnJvdM9cn8KNPgSIUPmt9envj8NTinRTum2YyGE/1+UtwsecUgVIDnNtMSndmiDar07iA4v6BsDRK5Y+vQ8paJ5Cht02UCwqlun60gtYrksuf4gi0qGTIEWyh82u/5FjVmKiCoV4TiFCeNGULVSl4LWy3KcFsfTBlgqoYZg4qEvHuta+wS2aspl2yhopjx9LHJypCqpVaVeo0TLOItShIHRT6G3yj7ne+qmLn57G9+DF7DoQGukFUOcnShVzUtC7Fozvd4EBpi4e16C6xISIAkYzhqU8Al8Ax2+oheIaQ==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by VI0PR09MB7005.eurprd09.prod.outlook.com (2603:10a6:800:243::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 24 Mar
 2026 16:40:18 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 16:40:17 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 6/7] target/riscv: Support runtime endianness in virtio via
 sysemu callback
Thread-Topic: [PATCH v5 6/7] target/riscv: Support runtime endianness in
 virtio via sysemu callback
Thread-Index: AQHcu6zltcJpEkofREi367s+vheM/A==
Date: Tue, 24 Mar 2026 16:40:17 +0000
Message-ID: <20260324164007.549397-7-djordje.todorovic@htecgroup.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|VI0PR09MB7005:EE_
x-ms-office365-filtering-correlation-id: 561c1ef9-8ea1-45dd-327a-08de89c4084d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: e2n2032DpORTzvwsEjR8SDgkJsVo4aayKQgweaR63ZjJeNpIYoVkQ+PpC3hK5ssQDvvbhd4RT9EX4lBQ2TugQ1HjxljNiS8eegts8WffTJijPtoYuG/tbjHrnqD49upywd5jOmQsMfiFeIfm75K6t4qcisw1+itSzri4Dz6qS+Z4d7E5CD10JymYBwoKzG7ymYD0blIEvK2nRrtHGyYqw9BoVJgzaGnKs0j/su6XjVveuMqa25AFYl8TViO1l2FlaOyhLU1zHd0psdNTJNfe/pQWZ3r7/r4SI3O4EU+hzfM2Xa5ZAjfCL8dupMZpc6hk9WDNuaS+V4sWE9H4nHek/QOlAeOyHJX/yRzSaheijWlfnp+Z1i146C8GDnyd29Mfwfy4mIV8pGycMi4hQhbsOj0+4EmSiRBm5HLbtfMxNf7dzN2kSHCQraZsGnga2RwdIlZtV7qJBGMP3GjNKC57c+IIgLrvoA4oZ7mynwpQvuqEj6F9b8RvVtWp8HJjfOsOZZpZrLG+xEy2Efg26ZCvWpHlUo7lO8bhvE5+Yzahjfp1HoV9Azl2x4y50D7t81223g4+JlWQgVKaG2m2RGz3dOt8h4XTTKVFCKtW2AIF4eXtQaNxe4dqhOhNaPqxG0iU5uL4MENd7Sawnwiup4dPLoC1rCLfj1ssDzn0NQGtuXp8po+Y9N6wmj6FEHYi3e0rRAEe0CtHXUSeYOErz1zYoJPVg3qg3rgOSQXCqpYzClswMD47IKpQ9q9GcIz1YrTt6iangGO8UlWcNPDwMcTuFmUko2UFXpYgR2xy1EphzOY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sn4bTZ/cgbN7o9sfiae/LJOCINxopw58qA9aYBcmU0QnIjQN49ZjznQrzq?=
 =?iso-8859-1?Q?eaQ2ZPjZq0ldwuHEiXgPVyYCeCOEp8M2zibS+wF9EbAzaeZpDPpEzPp6E6?=
 =?iso-8859-1?Q?4L4EJGd2ctwSdXdvkPbxtbP8bscdn4y8EVwdJLPyL91jFKgAUQ4taaGUb6?=
 =?iso-8859-1?Q?83JrVl/kL7DoD5qJt0KbiP6+rowIwNH3/8mP30jrNzCzzKViJpzXiBVEF7?=
 =?iso-8859-1?Q?VSFJ3GBqUYjEF9AuQAl/KMlKiW6LYhtVGmOW5RLXYnYOm8OrSPtonoT8JN?=
 =?iso-8859-1?Q?A7KFRgigqNJrHUmLFowgFt8c8g5c8oEWdcekRism8lvIca4ElHZ6qVjWJS?=
 =?iso-8859-1?Q?l/WHabPfOL5KLMRY322zq3sluyhwda9EEDeMJRqisPxkLr6yBP+HUXILQV?=
 =?iso-8859-1?Q?jbH9DErkC4SijyZ9zn23ramqOLCUa9NGIyGiiPlFwxxEufezuVERhKiHuN?=
 =?iso-8859-1?Q?y76GQljIq5TFy3B3brMhjIQmH9bQ5Vw5fn9bx6z3wXUNE6LvtT2PvPTZWS?=
 =?iso-8859-1?Q?VNmQMLnaysowpgRU4pdDnzf7AhuLsJ/B6H9eBw7KIzJtTvaF15cVdURnkK?=
 =?iso-8859-1?Q?M3buRUoeYU0GFkFZ0EZ8W8+UEkExCHd0OKbsCnnDAEvvbgbgOwKuAF1PoR?=
 =?iso-8859-1?Q?C0McENXbGMKvYajEIeh4aWWJvCmRlR3D0yqGT6aJQlolHSeAgOz36y4r8S?=
 =?iso-8859-1?Q?KJ9oQHmaCRaJn7PA5kSZwmL9uXy87R6Y7GJXUmFHdtermrbi7nAfEZ5wyS?=
 =?iso-8859-1?Q?k4tCgvC1LxWnyf81Ndb7ZUsCll1dVWq9BPMfgd0MjDDsq6bLiZov4LYa82?=
 =?iso-8859-1?Q?DlcV4orx0ZGE03+PLVnzOGSthHWtmphMxS8s4iHzImg09Y1glr4eYdyKW9?=
 =?iso-8859-1?Q?1yTM0/40uTjkgEjD77elWz/AZsd4YEmINDlmPBuJn5XcoysPk0cZccjQJw?=
 =?iso-8859-1?Q?QKDjZYTcu0tu8A5YT+swGb4zBemoSDO1A84JGZ56VIF8J9rjQwOS9jWoYx?=
 =?iso-8859-1?Q?QYZBEP1PDEwOrptJdVN48F2U2AyLpOSIJCdVzpyB0JK4tuOfTb1x7mA9uc?=
 =?iso-8859-1?Q?JmPYc8uz/M6STkQDSWC1wogyYpHFhCwOnHpCzXzo7pMU+c3ekUCG8hIY2m?=
 =?iso-8859-1?Q?m53Eylxiy88vDVbhpPAzzW6v3oXukAz3Z/y8tx8JeQHS/gBm/FQGl4IA7u?=
 =?iso-8859-1?Q?85UT+/rk8v+sVcqrFbzFtlxVLbUNAERC89iSaH6U0+J9OT4jaq6ttCC7+5?=
 =?iso-8859-1?Q?bMt27aMM+I6AMv8YJ6p2PMgI1g7B2nDFofMBz36nOpjqI9RcwGvVtRdExj?=
 =?iso-8859-1?Q?ZaBfHrUroAAP4wEvpWUZ9daYcg2zHHywD8o+pq+XinuG0qGJiyrJhMlo5Q?=
 =?iso-8859-1?Q?BkBefatbG/UNl0VsCRrYsjEIXmdf9C3JOe1UKgXVRrurJ9zQ4lF0rFopni?=
 =?iso-8859-1?Q?OGn2sMm/sOSUqNHBVo3D/oj0NWaeIkxiCX/yFVS+17YIPR8rSgEadAkErg?=
 =?iso-8859-1?Q?0aJ2JpCbL2lVW4svE+gtJCgN7cpJFFGr9zlJftAm8lqPnc30t6YIR2OHjN?=
 =?iso-8859-1?Q?RxDgYmyXyU5uLo2YdZqn5keYX5uh8re2CPKNRYLK6dg4nwbhN6NOhU2Ivg?=
 =?iso-8859-1?Q?qTKg7+G+NYJgboEln6SY/KH7TkKLJTUl9KhzMuaKagyaE0WQt5x8liFsSS?=
 =?iso-8859-1?Q?3hYTW1a4yMLehl5phLKq5beG3955jUan9Lw+qV9TctOZEtZX5t2O1H4q93?=
 =?iso-8859-1?Q?6yPeqYM+eYk6Ycp1ZBFWAPDXpvzT9yzf1uLWxGEY55Yhd2XOWDZIsVPGRL?=
 =?iso-8859-1?Q?EGrv9Il7R6hvTD6OlwKZe3q+0UnVePokxKyRGVXW/2agtu1Ej699?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561c1ef9-8ea1-45dd-327a-08de89c4084d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 16:40:17.1052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EA4ld2/3CoxpipsB0xhzZbKv8b3dAYpkTMO/8YPXz3pGx1J+5S7fE9GV+UZkD9wl/bj8px4EbRnSTGhKFgVo1tl9eesL/2ZxNnsTGRVwBlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7005
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCE5CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v909U-0007SR-Up; Wed, 15 Oct 2025 07:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909S-0007S4-4h; Wed, 15 Oct 2025 07:58:42 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909K-0007nx-18; Wed, 15 Oct 2025 07:58:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rm/OS/mXvlbrdikzw6hWt+I32gIKsQiZDzs+p4r9B3uQINCjxjdk6qOnFkcW2e/W9CssoPzPY1+f1x6A8zLRBqAs31h5tlOS+rtF9D8NtSiCX9GN4iGke2upSR7CD3A5jjSf19UuHmMP+1QDIpkNyMYmSS92GLqP3+90Hxf4CSCl6lktsYoOAGXBFy7tpAen0G4FSzsuqc07aNwNXDT5axT9sQwmKC3R1X/IBYTGxqwRHxAMWOm6UrD52dFsdloS1vJ7dQhDRkDaTkgoy6A1ze84f4qgCwzxnRNcuJfXXAc+/lDVa3P0zWeGXKmv6JFLgk2MEIIKaXKf3qxgMsBoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqK6fOc7okszTsgPOQ70tF7r7DASSM2TA7sWE/3/rd0=;
 b=qIwC4/nHxRZlDOc3Ivi8f6aIAQUU5WUhQNLxPLzpQuLgwl6sjXFensRNzjOl/H8ChCZVW6pnEwJjFmqWQQ+qO9VsCfTmYOFaGJvXmObM5robIQ2A9K1/YRFRwgebYvkWJQF9Dc0QQDO4l1g0WM+OWQXyXFFS7JXeXSdW2aRY6/v09SRDHIRH35fawmbPN3MLETtpnGBrG66UvYaWjOof5huPwMwWvTs8DMn5C2Hv81vWSqu62x/fMi5u/Ci7+RO2zYl1roUU7Y6gdlDSExDV7MLmrQ4/o4Mq7K9eOGRFVcOpbVYrNzHdu840hFO+jwmVB3ewiQQz9Lc32sq+Dj8dhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqK6fOc7okszTsgPOQ70tF7r7DASSM2TA7sWE/3/rd0=;
 b=OZP4PTpgw/ov0Z/uE89ekRAWusBKt1FI+v1vdMaSjvbYtN0H64hxYVlxLkzTTVUHFzgEzbV9XCTxX7Y9BIC1wHACHHLGuAkJT/gxdYQiUO5fd8ncWo7U+8882ue97DqTKKgWuAFDYmQksguvGhSUZGEIl/+9kTc4H+FNdPeoSNiJUmpG8v2Tp78k1p8sbiGrdOSjDKUjerU3ne+XZVPN2sqexA4tUgr8+AFoHHOemtQSGNLXJYzYRrYV4bYd+CSLvJGv31VLxTgtXPzqYEYwi1hkmYaNgKzBz5BhnKIsxxHjwV1b66IBUz1YNgaoF2pJpEo6krZb8eYCRAKXrFDjNg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:16 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:16 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v11 02/13] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v11 02/13] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHcPcr9bYn+0clS10WgkEo0Hzvlyw==
Date: Wed, 15 Oct 2025 11:58:15 +0000
Message-ID: <20251015115743.487361-3-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB5739:EE_
x-ms-office365-filtering-correlation-id: ba0cc90c-59b7-4e08-a4f8-08de0be2201e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fAAklAeGrHWnICZATmm9yr32zF0KoEL/UoOMa+xb6LhvyLcYnBUvWluvfp?=
 =?iso-8859-1?Q?PqKhTFPJcDBYwZSbvx55/Yzrtp8No1cSucfdzgeamrk7Vo/3xDNe555n/V?=
 =?iso-8859-1?Q?0mNm3bGUXSRVzmWkfMLZJRSHeiD21Y2gRTTgfvcVwbahirUGjTBV2ztF6I?=
 =?iso-8859-1?Q?gd6ZCs6eULzCJ1z/GV7UoxWX92BLBU2dTRwlhkBuxyGRjWSfthwJzH7MJ7?=
 =?iso-8859-1?Q?JIaMJ99NHYewWtsyJF8mNVUz7BjuCTVt90ueeMx6zZgRZzMSWph+qMT9uf?=
 =?iso-8859-1?Q?bGv4wICIczGmXOJWB6Ft9MVpiRb9otEK2RYZIn/d+l8hCP+T52YILkqo+K?=
 =?iso-8859-1?Q?T9ggjGC54YV7ikAzA724/eHwJLcorqsTmKEMzXXXpLl8KcV2XJGC1ZspOp?=
 =?iso-8859-1?Q?9QVr0dGzjRRxQ7XxZ7WaBkc65Ey2qEiHmTmLXhlG55k8eNTScdQR8Ojr/z?=
 =?iso-8859-1?Q?HOcCL7AW2pfPEzEcmq00yyXx+WaztV6rWyn++UcWZA3kKtVr6d3sc9tdOH?=
 =?iso-8859-1?Q?IFhss+Vx9/pXpiqNk8TXXIK9O23cqDRL4fi67e8NLAsDeL6ajg1sTc35Dx?=
 =?iso-8859-1?Q?U6PNFLj1k7dKu8ETqPoXLvQByAlnfBNSUm1Zjyx9/kybyTfMxp+VM5q367?=
 =?iso-8859-1?Q?WiV2Pkfkx9jcvS+bwWoW0EfN4ZqCT/OTVtJEiCGhvGLlnIdlKNWXvxlqOu?=
 =?iso-8859-1?Q?8pW52U6aRwXr7IrfkdU19+cgeQ2Cj5RvZ6ydVt+VqSZzvH1UIfWr56zD8G?=
 =?iso-8859-1?Q?9Ru+a/hN6Ebk1TENe0sREtqvU3gS9JrSamR8/xa8mciN/97Wc++OXydTz3?=
 =?iso-8859-1?Q?jlag+C6bRx4+dgstz9zpHb21XkN7epWkwzfD1YDbLBjDzyOLY3yr6NQab/?=
 =?iso-8859-1?Q?rkqqIF0BEJ/j3fZ4JsWT/vio63M4BmV63tBeJerU7SJ6dhqBVo4X3N4stk?=
 =?iso-8859-1?Q?b9WqMB59Fq3myTEbmQ70mWE9keJCpODRRdjPMjSbPRoVww7EChME719TU8?=
 =?iso-8859-1?Q?9xZCzUa+TeBi7RF9zEg5ILOut5rZbztIGlfskYm5PbJ4SG0RsUk2eVJwrG?=
 =?iso-8859-1?Q?Ct8KDDFA98qyIMLXZWKkjkxL4k7J1yBX5V2TdBCT8koiSsqtjvRRCYyQ9p?=
 =?iso-8859-1?Q?wVR5AqFZ082eUJIKxHmLYRfE6Zs+5Pgw/D5Tyt7XF2eEFYWZdj/kxD96Kr?=
 =?iso-8859-1?Q?Ei0Pr5SY1xMTq7R8ZJM56yP3bHMw0cpjjpqkE9Aese4KFGuhUiCdICXVuA?=
 =?iso-8859-1?Q?5s3QvykCTH2TypN5ypioNFLm8W/Tq9MGjQLYWio01cZM9ba4gUAv6FZHFF?=
 =?iso-8859-1?Q?FIZOtgIe19YuLdktd9Qa5pOa+tKku4gc4mJIalNYPXeFAKs3mRC9cB7zmm?=
 =?iso-8859-1?Q?xZiigffid9Va6Pe//ZPsNre5SF3nu0M9YXNYZjv2DKntfRwcQzCtBR493A?=
 =?iso-8859-1?Q?Rl3uPXgyoaFgINkgfScr6rQ/irWr5zQAfUgUNDDbZUdATgY3AyDeR/p/Wn?=
 =?iso-8859-1?Q?elWEJ+8E96SZVQHkw1V5mbdNX9opQ4Qm3XBDH8pbNnThc8rt9OsPKIbSw9?=
 =?iso-8859-1?Q?McLuiMEggkbtPElPiQ3JpDQGHCee?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MCoY+sVRDADEcKnZJqTlUQJCfkhuJqknPD77UzW03K04yWRSDIXaSdW+8l?=
 =?iso-8859-1?Q?gBdQ+qvNFX+CsicniJZ/OuA0EYhcXOiDJz1+FXUB5LW9zStc0CRfkxx/OH?=
 =?iso-8859-1?Q?g5+mBA/NRAgSeD2Jnf7t2O8WaSiDNw6/6WzTnMmwreV+407B+33qIUlI4h?=
 =?iso-8859-1?Q?c9sse1ohoGrVN8RfLEH1pQM3Aj4HAKXW5gvr54rVZQJfnjaNblJ0Z+HTQX?=
 =?iso-8859-1?Q?0S0rFKSJdeMt0pZQhWURvGihbizXB27eQzODBbJ3lMUC6z29ORErBgS7YN?=
 =?iso-8859-1?Q?tmBRxDRjfGOct3iPMg08NxIFy77632v39kc7mnGoG/8Whf9OZXgRQ/a9EQ?=
 =?iso-8859-1?Q?ANZ4ubR3yJKMTiq1WP3/dL/BMGRN6aEXy+T8TzCF1tJPcp9jnuPuZEPjK7?=
 =?iso-8859-1?Q?VPYGDLiCDKEFwW5CIEqQxRXw43eszteTPXvXXVIHl/ZFZJmXoWLkkJZoUN?=
 =?iso-8859-1?Q?aJ0Pe6+82W7kdS2gWRQg1c6kwkl9iZTdz1Li/xFzGEh32k5r4ee3G+mF4u?=
 =?iso-8859-1?Q?qWKcTCK3Hiz5i2oEi82SF8Hl3T8pYeLA38BMG0D+CDfbjJ0h/EeDXFN4L3?=
 =?iso-8859-1?Q?9e1VwQXOkxCaXY2xy8P3kTCxqlIfkz3Bv/c2C0RxO+sQEev54NjFG0kmKa?=
 =?iso-8859-1?Q?VxtFciswMFEJ9sAgyLX3rqiOXvCxEO/Fmr0xBMx7zqqR+zXfGVkrKLUzHR?=
 =?iso-8859-1?Q?TlM2zF0aTcOyOZdurcjwq5w/oNrsEHyPlRLK+/PMtxVCXs2UlmIJlcw2CP?=
 =?iso-8859-1?Q?IyXzu2hz4+bzZYd+dFhf7g/tIG789tL66sHgJ3AU+Ox/GCJTy/IcbYnkwy?=
 =?iso-8859-1?Q?/RA4t1QONTw+SIWFRYwmy7UGLdQYc7UxuLqcL1pTG29NGaCMjIAtz1AAwv?=
 =?iso-8859-1?Q?O6oFeqLZTTATquK033RfjFuotTCj82FJZfT/Ec3FO3FUkj6zbDPijFdfSP?=
 =?iso-8859-1?Q?BZfHOnRXR4j+Sw9vHYkbM8X8PAgae+YlXXRfvT172iioiI9+Vck0fgnqAK?=
 =?iso-8859-1?Q?jWt6FbyFrVOpDcK1m20ZkiNDYIng8gt9StHnwBhuA+GJ/EyQm7lsb/LBSO?=
 =?iso-8859-1?Q?wOgpMgTmDp3sG4aZhU5PKY0DE0gPJy8IZO26fvkHbllKkif2/j9OuMHv9I?=
 =?iso-8859-1?Q?HdnbTFoK3DhFXAsvoQ0mBpZ43ei5561Um4V3wSlatRZ0UJW1RfFX2in3P8?=
 =?iso-8859-1?Q?u1gPqRScvfFVGDmX9nyjxsqo1STrm2ZMZdU8bSzvPhPqLfXU3/NMcz3Hxa?=
 =?iso-8859-1?Q?Hpg1PKSkoZdqux20R9CCcVQrnsGu8mWwpRJu9ErwYJndt6eImR6LR6tc2V?=
 =?iso-8859-1?Q?HTX93f0Oo7CTf9tyx5gmylsgfAC3ktpLRLiALF2Xihc/vwfB27u7DGc0HZ?=
 =?iso-8859-1?Q?LnJK4sogtbsfKffWrQBMQcjy1fBBkOgUARf2GI+YP+0/c/8PLznhUe5R0i?=
 =?iso-8859-1?Q?8nL460bU+l9FrjPS5xsX1IDACCWVbGrGvzUedGlzTuQnyMLmNeGfhSJiiR?=
 =?iso-8859-1?Q?mMQuqxEeDmf/7jlId/Ourw0kToCx8RU0l4pM5GeR1P6H62gD+xQlQ5Dkbs?=
 =?iso-8859-1?Q?VIvWIZuQ8GFZpMa/VYywTUDs/ADPUCukFZfKp27NajamA+T9JrLj6wXOQh?=
 =?iso-8859-1?Q?6Nv9UXRfse9RhhYTFTLXbOciSI+G1K7OtybTQwukHD+ltw43y1GrVqYN6/?=
 =?iso-8859-1?Q?EOeIt4upArQE8+0uoac=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0cc90c-59b7-4e08-a4f8-08de0be2201e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:15.4041 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+Vr5m0RBXfMw5aqMBeKNnmdmprhchpbDfiQ/ArW+ZjMKV5yczmeOZe7DvM1pBaX4BvDLJ93X54T0RZ4OsoYbQTVCclwqcyVaccLEEi45N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a new function, so we can change reset vector from platforms
during runtime.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 16 ++++++++++++++++
 target/riscv/cpu.h |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..7932ba6873 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -73,6 +73,22 @@ bool riscv_cpu_option_set(const char *optname)
     return g_hash_table_contains(general_user_opts, optname);
 }
=20
+#ifndef CONFIG_USER_ONLY
+/* This is used in runtime only. */
+void cpu_set_exception_base(int vp_index, target_ulong address)
+{
+    RISCVCPU *cpu;
+    CPUState *cs =3D qemu_get_cpu(vp_index);
+    if (cs =3D=3D NULL) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cpu_set_exception_base: invalid vp_index: %u",
+                      vp_index);
+    }
+    cpu =3D RISCV_CPU(cs);
+    cpu->env.resetvec =3D address;
+}
+#endif
+
 static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig=
 *src)
 {
 #define BOOL_FIELD(x) dest->x |=3D src->x;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 4a862da615..34751bd414 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -672,6 +672,10 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *e=
nv,
 target_ulong riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
=20
+#ifndef CONFIG_USER_ONLY
+void cpu_set_exception_base(int vp_index, target_ulong address);
+#endif
+
 FIELD(TB_FLAGS, MEM_IDX, 0, 3)
 FIELD(TB_FLAGS, FS, 3, 2)
 /* Vector flags */
--=20
2.34.1


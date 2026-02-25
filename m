Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89065F4BB72
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC0b-000400-OO; Wed, 25 Feb 2026 05:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0X-0003xs-Le; Wed, 25 Feb 2026 05:20:42 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0V-0002vM-3j; Wed, 25 Feb 2026 05:20:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8JAu9P+Jtl4J6aK87UKPBAaX1+jfHVjNKSCeAENzBj9bMk5M2BzCFeEYCEuwa7Qz3ZbU9+t4HmID1P03G9pEdjbtuZIG8SqqNGJvksfM/eFm0LR6tQ1V3ZJ6pdwVU0wW2qvslniEO+MkCyndlI+3JuQBbGOAPQ8lHwLJIbu40gSRmsWzFFxuZiXD7wAhPkM9SNFj549j3pG2gsvqFToLhpTNb8wZSEdhRUrUfLrrIKEW4a9L03S5HZd3pNyDjwjolkpmyHEkZv5XUNHstxdX6lzGo+9Dw7mErGuId6I8pSBXV4fmKeGNEMpW3T3C2RvVTSfJYDvjcwuOYmu8kkjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6wsujba8JcjovTEjuCXqI9PjYutH2h8CHBeOsVt40k=;
 b=A+bsmrSSzcssO5Okv+GAC0TWldGc1VyXrBX0nxeZ131p3EuJaETXscbrsIaJYdsrJF/9hmt3kweNZ0tFhaopIiav7fiwBPMvN0vrc98rGxYnm/3Wcc2UCfeyxEYM9yOjBuulVu2q89Fp2EV99A5n4EpHku6VA90ou5GIMDOfxhykXXFlznvJ90cOO3Qe3VWwiUYVnh+H0LKnmoBZUvI+FhgX6uRbqxAK0/RH1kC8/QswSwXvoFlFgzwkxdduc8XQr8cDNSWt48DHwx/aBtQRo7gl5rKd6BePqWlv6Qlzhzju2xOviIMXgFGbiMy1ijP7RMnVwPCguIbh8nIBBtK2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6wsujba8JcjovTEjuCXqI9PjYutH2h8CHBeOsVt40k=;
 b=hhTyT41wMwptq98JE6ZWMIjfynmz75NQanmcbWdoitJ6mnhXnvXJhkq8y2FXEYqZMFN/Bk7r7qRhI+h1Z4eo4gO566QR7d94ZmeaC7pkhJR+3XwKdm3XuQEEp3Z1dXLqG7fpf6iCn3FtxPUxl1rYlC4TCQrYJzgsiJWos+8UbnksDEL2sDH/v0rJmCinOgeWzxQ2TstvlNC4HSAAPJ2ivy+/8JclXZb1tRwPBLb7qSW6Cq7NjweA7+dvke+fc7iEITYGUloNPRVpPQboJGFLnh180c+dAycl+PW45qZwefk7mJ+oL9MyOmhI5+CdF+XnkjskDoWZBM0looo22jobMQ==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by GVXPR09MB6845.eurprd09.prod.outlook.com (2603:10a6:150:11b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:31 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 14/16] target/riscv: Use MO_LE for instruction fetch
Thread-Topic: [PATCH v2 14/16] target/riscv: Use MO_LE for instruction fetch
Thread-Index: AQHcpkBd5b6kz8kf4kKGIU9A8dEJ4g==
Date: Wed, 25 Feb 2026 10:20:29 +0000
Message-ID: <20260225102016.200654-15-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|GVXPR09MB6845:EE_
x-ms-office365-filtering-correlation-id: 33504c9f-d4b1-40e8-afe0-08de74578178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: TiP+6E+5WOGhHc6gWYyepktiCTwGotxoYWISlvt/n5L4oon1rqj7TZK/FoT81Yg5J/Em9fmBtKx/8YuV59ERMlnP0s6obIoI5E9FtGIS0EzWyVbrZVblGPgIPkmF5R00rduIaYkSjfQ94jdulaybM5QNQyRqDiaoE4cmC1PKSt1RcB4Ox9zyE8IEw/llGkbfNxk8mrRSAJalcXWCQZyI/AON/RPeYge8VGUw2d/Z2LG6yJsYf304a/yjLlwN0TOv3Srgb78IgcxWhY9nv3LpRjMQSnrz5fvyBv/JqFBEyJKe+vx2gtoTaebCuEreRYV3M79W4x1WIg0LLxWTQG6NvjnkW1HTgs/c5OWO7/BGCRczQ9g70YW01Pya5FZX5cOOJqJ2ASz2adP8jxya4KOkDcnhQzAdunsIaJQHOIPx06PNvwv0w5ggE/zmgASI7ejTC+QAyWYYHlT4zG894FjcmfgwC4OldhIa43CD8FFEJiMCcybhU9coAp4/j6ctcK8e6jFJlt/P0qSXyDVgdWHcWE83G8YKlyUy6jBkL77HN6wLpcl+sL7zYVNVjbfDgVgc8tDVJiDHzjBw1FeQclkfz/ya8eYXP4EtoWg6WMstBnVMAc425ScHtMO/Hb7yxL1umppYDZ3JwayQQoXzexCO6vefxPmI5xFoS60popWFX9bV6XDkCQdd9G+4A4itVSlPLLsXiF8n3IMJh0yWtTgMWizhwbAE0XKsnzBgS82FcEgijwO98pmICahJiM7GZPEAvJ/IkaazvKvgSZ+2IWPO4l2Nuv8R7mEVPbe5nSiYA8s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HnYIxwkGVrQlIGunQd+baOXd+1k/CcDZMqqPmuihVtOFsaV5x13vnb6MDT?=
 =?iso-8859-1?Q?mkslhxqWf8WAXnbyl1RXOqqMTmxf5clnmsSF487G1P/KI0ifqtW3/RYOc/?=
 =?iso-8859-1?Q?lNo7sdvDjWf5RlviocM0+rJGqB7EasgDj6pe80+g2MgJtD/CZoNLSRBSch?=
 =?iso-8859-1?Q?moHo9CMH7odhokAqLwselAXUlkfaXDVR4EjYuR3v7GOWOslE1uwRW43pXS?=
 =?iso-8859-1?Q?yIaWLUq0ugX6IcCeDiMatbEDwPhVBVRcrWn+YG2D5zonwS5g9AiQ4T3ijn?=
 =?iso-8859-1?Q?Jvbc49yWh4gcLILE/PYYJp72mNanVj6HB/vI2Sz4DznXEtiQ+jxQJd5JV6?=
 =?iso-8859-1?Q?BNnXUIvgR10QRbFaSHNXabFqt+pDwkq5bN+EAkKsxb85FPnl4zKRqWzj9u?=
 =?iso-8859-1?Q?cLa2+QMU+5p4YHPukJ6K+5Kq+VDbJMTynkqnHBGHZeWSLWbEKuvMmRrxbV?=
 =?iso-8859-1?Q?++NPU4M1MEPBOKT3za9gsgaMNtYOfRXyCDPAZX3xcknAAr0E75XoKq8Dtq?=
 =?iso-8859-1?Q?KJrGDE/5Qj65yJ0FT2XuQ6qIc4DW4ZMOU6fv20nXBgz0OEUd11YPWOHngA?=
 =?iso-8859-1?Q?zinWOLAhZr1BC/eu5lo5FGr7/h2Vy5yPZJDs0AA7I12FKTrN9Oq/Q/zEo+?=
 =?iso-8859-1?Q?rqj+nhIhWGG64PWB+yGedgsUycCD+vhddyzPbVmMUYj4TQqs6cqbkqSsyh?=
 =?iso-8859-1?Q?eXuZSxqgo1gNa7zpkV0Ga66Ayk3BCkiolWnkokU8a9w39Brd34BhJq1wna?=
 =?iso-8859-1?Q?tzqfexSou1tofi+sfYPdap0tECAHM95SncNdfs1knbtPG1JnZKIT7Tuqqr?=
 =?iso-8859-1?Q?isUV1zrPX1KpyvbMdQGLXnJi+LkEVPaI/6k1iDove8Cc2TBiFHgzodN5u5?=
 =?iso-8859-1?Q?qMEFCIEq1hnelscU4KSXg0u/UHi3H+Qfnsp6zqSUMxr3AYvVxn3mvBMLzl?=
 =?iso-8859-1?Q?eJiOU6FsJy23AosxhrfdI39YA5oNEzi9ZsjiLHuQ8lcQzIWdHi2jV2Cl4m?=
 =?iso-8859-1?Q?AUKTUJW3rTqGwfaDavveqbMY5MxkpI6LHzTa+kJoSWeXu6K1pwKSjR/OvK?=
 =?iso-8859-1?Q?Mr1rFFAwVEmkfrnIEsEg37U0SDHw5RDCrJiD9v8N+jmhAAHUeQt4US5pmL?=
 =?iso-8859-1?Q?P5r9qfhXkcjV6D0nHgpnXH29+aq6qVeeGPrtX2wDFxWPE6dYkKj+mkBWZf?=
 =?iso-8859-1?Q?W9ospoYdiypOYoHXcZvEFDipSv9vb10zyaWVIBET4GFaVt14sA9ZfAjgoP?=
 =?iso-8859-1?Q?93H7Unnmlct/YhsWVlSPPpuQgm2BE7Rv/f0UHUFmoWtGzVXqo6Z5Bn8ePD?=
 =?iso-8859-1?Q?lWVuhLfoYTA9kRta9GlQehbiNZ28qLEJuibGC/ZWWFHS+xmtKPExh7BXkK?=
 =?iso-8859-1?Q?SMK3Gy8d7vyL9nSbfa4B82AuBa/Z4j84PW0wp6DPmnP5BWPDGtuRlmTyDW?=
 =?iso-8859-1?Q?zFarrG8oTQrT8G5dY1sw8p25w9A36OGMeUkLvd95sZXvcEbEsAYDQQ1yPq?=
 =?iso-8859-1?Q?hCVC7jIdX1h8mgWaUF+mriCVsq0IqmtBzf79YbyBKJPJn2ZxZIQH4UikIt?=
 =?iso-8859-1?Q?S6UuD6dEu+Juqe9lehMzKBTyJy7+c/iGjvttyXFvRQAx8qSx7UooZS2tKH?=
 =?iso-8859-1?Q?RbomscT4114PqisOvS4gmGcqY4LsXfNvDkUByJRF7huBTB1nWVHS+4BQTh?=
 =?iso-8859-1?Q?98E/2t3qkwiIAnapwOcT4xfmz1yC8pwwY+Z129FI+VR6iEj9VwsW04K9KT?=
 =?iso-8859-1?Q?6wJPuSPtVR6d7UsGJU07ILaexnZGP7/2DfFxDJoH+ObgIvcFe2cEWDsXxz?=
 =?iso-8859-1?Q?c845+mqNPA8I/OKVE8SOkIO1brnykFP9k0b0dy7xNmjrHpbtuL/L?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33504c9f-d4b1-40e8-afe0-08de74578178
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:29.3982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5I+7Xt4d/slzF4Dw/x4chRI+juwrE9C8ci4kBEq3gwEUHfYcVUttB09yOTYz++t6Aef9lza7AWgDrya9jBSNr4ACShAxOUGzghs5PNllyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6845
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

From: djtodoro <djordje.todorovic@htecgroup.com>

RISC-V instructions are always little-endian. Use translator_ldl_end
and translator_lduw_end with MO_LE instead of tswap on translator_ldl
results.
---
 target/riscv/translate.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 67dfb5f1c0..57dfc68220 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -23,8 +23,6 @@
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/target_page.h"
-#include "exec/tswap.h"
-
 #include "exec/translator.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/translation-block.h"
@@ -1255,13 +1253,13 @@ static void decode_opc(CPURISCVState *env, DisasCon=
text *ctx)
          * real one is 2 or 4 bytes. Instruction preload wouldn't trigger
          * additional page fault.
          */
-        opcode =3D tswap32(translator_ldl(env, &ctx->base, ctx->base.pc_ne=
xt));
+        opcode =3D translator_ldl_end(env, &ctx->base, ctx->base.pc_next, =
MO_LE);
     } else {
         /*
          * For unaligned pc, instruction preload may trigger additional
          * page fault so we only load 2 bytes here.
          */
-        opcode =3D (uint32_t) tswap16(translator_lduw(env, &ctx->base, ctx=
->base.pc_next));
+        opcode =3D (uint32_t) translator_lduw_end(env, &ctx->base, ctx->ba=
se.pc_next, MO_LE);
     }
     ctx->ol =3D ctx->xl;
=20
@@ -1280,9 +1278,9 @@ static void decode_opc(CPURISCVState *env, DisasConte=
xt *ctx)
     } else {
         if (!pc_is_4byte_align) {
             /* Load last 2 bytes of instruction here */
-            uint16_t opcode_hi =3D translator_lduw(env, &ctx->base,
-                                                 ctx->base.pc_next + 2);
-            opcode =3D deposit32(opcode, 16, 16, tswap16(opcode_hi));
+            uint16_t opcode_hi =3D translator_lduw_end(env, &ctx->base,
+                                                     ctx->base.pc_next + 2=
, MO_LE);
+            opcode =3D deposit32(opcode, 16, 16, opcode_hi);
         }
         ctx->opcode =3D opcode;
=20
@@ -1397,8 +1395,7 @@ static void riscv_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cpu)
=20
             if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
                 uint16_t next_insn =3D
-                    translator_lduw(env, &ctx->base, ctx->base.pc_next);
-                next_insn =3D tswap16(next_insn);
+                    translator_lduw_end(env, &ctx->base, ctx->base.pc_next=
, MO_LE);
                 int len =3D insn_len(next_insn);
=20
                 if (!translator_is_same_page(&ctx->base, ctx->base.pc_next=
 + len - 1)) {
--=20
2.34.1


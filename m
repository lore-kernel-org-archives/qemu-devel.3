Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DF5106286B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IED-0008RA-QN; Wed, 11 Mar 2026 07:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDr-0008Ej-0i; Wed, 11 Mar 2026 07:59:31 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDm-0004dU-8Q; Wed, 11 Mar 2026 07:59:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr/0LUbvLnM0bziwo4mkyh2k6TwPpQIk4iURRw8Jm12rYCwyaema6DxoTbZBHQczVKFDH8lxh0KUCV7UFkc9fnc1E7YJuZ7cJ+gxYUdXtxbCnQY/SlckZeKuZS0tqNuqxUB/xwNCPJ5IhFJ3H+kXy6U0hmAb2d1geA47+PfmAAXUpQ8ivGw6p1CcKEUpTpDvZmpDiw7QncUY13a5Hfva9vj/+WV7ixeZnj4vdv0mTOEoNmuamREEkIa6xW+GVTsFhPEpeuSVr0Z/igqTP4R1jHIhj0mn7OZA7oGSdRSxwOUUL7AzNjV47fVukGkcF2kW5PVqlJQ3lnu6Df0AyLEpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz82LXzriYZgfoGUE3iZDQh9xSJrs20j1KePjysyZwc=;
 b=GsFxgx34awX4LM9l6M4NrojQvI2xH3VMWc+QcRjcvrQAOTuzKt2Yn84MYvmnoEjeeyXbejebh/nedJ7kM41kdnaCSMLVmWXakzeFSYqiUbVuYq0/dULvpgDr6YWXbLvl73LQXoC91GggRA/boH/GWAxBqaE63+R9ppk7IQ00K+eq7raycvE9/DeccUjF+iZHAT13Ynd8nBmdQPYrN/YOvXANjj2zz0odEcfeNtqDRmD+hKUzaA5ENeWgjK8kF8heLso/6MCBDIbbtON0djxoAGqCCi/K0XYbm5dP+06+p098HkDAoj8b5Pa0pQI7Nq4ITgAKis7c0ysiXveWf3U8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz82LXzriYZgfoGUE3iZDQh9xSJrs20j1KePjysyZwc=;
 b=oAIy9arXP+c8SxVrQjP2nN6sQJb5HisiR+i67VfwV9y0RBcWUtBN69XrItheXkM7+pqF48LSuLsWZivnbLKAQ0VDh00ciAA44LIy9RnRV5AUacpfcBXRdzi5gC4g9uJKZS3aySNk9ZjEKs1ixxxMf23CRXU/v57thR3hKeM6r3MJV411uKahvdibZFLgXY/VTv3O5BX3cIufAuCvht9yl2r3LtOFAKTPNY+heRfN/6ki0jqeTOZvpxqoHxZDN/AetV+YoeYZIPCdgShHiGshMEJBxRTxcJGamvh/ls+N5I6CnVP25mqbq0ZHf+A2SxT+M//Mpc8EL1lnHTM+cgaOYQ==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DU0PR09MB6069.eurprd09.prod.outlook.com (2603:10a6:10:407::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 11:59:18 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 11:59:18 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v3 2/9] target/riscv: Use MO_LE for instruction fetch
Thread-Topic: [PATCH v3 2/9] target/riscv: Use MO_LE for instruction fetch
Thread-Index: AQHcsU584lAtYgI5wE6ljRovRmRCow==
Date: Wed, 11 Mar 2026 11:59:17 +0000
Message-ID: <20260311115910.564481-3-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 7e727737-6022-4405-9d07-08de7f659ff8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Hq/FGiBeK0BI2YjADVry3NWLb08Iw8OjJfyv+1aBGzT1tOQfDT0BcxRyYbwF1wgqq/0KKcUelEPZkpwYRtHViyYAS4U160obw+Yo8FKYlJuzaunESGjzRsk42tpL2JIF1uP7HRvW3BzMltMTJxAMkfEiGInZE5P1Bv3D0vSCrB3P5/FS+ZJOjQh5avhUOocqyBsPD6MUB1J/25ldsCD8iZwQHaAQjpl/+mhp/LJ0YFA4TfZTdJixBzaldyjvD8yXzqLmRS+REKC6vbdNm0YSF3V9q/NU4uJyRL2wQAK38O3qLRfsO680cAT7UssOIhpVp02kZGkT4cuq8upsrY42KYKUv4TkgGYfQVVzxbzr0S6abytAY32Ie/sX1h0n3yP9K8EeSEjxbAffzCFADto9tWlJwBwAcKqPunYG1BDURfrC53y69t4F46IG9/lkg1xbjjphClyi7b0BkSXHE47J3/r3EuUDo3MnLB1T9mCLAKV3TvAHRH5qTLaRh22OaaEW41rFvpyW5PBczfZD5YBbmIovquOXd7CP0EOsFc+yhdT1ZNIeHMRxXNBcRZbbwSmSPGviG+o/5EcOOJKpAvSwGPPdg23eQpPEvBVOdwtdBDTCMcsgkfAM4JIG/4khA7zgDYtzHVTWtfVo3dDuqy+4rPXSjb07ZVbArNusj+5hl8d4oWqkj0fv75b7ouAUAgGc0poOhN695h5dgGu6px4pfMEmngW5ovgkvB+IyWIsVpBatOBda+8lsVNmpOVNd9e0qHTnoNd8Brjh4g34pdOOHTUIL+zFzrI59ScI4wuavGo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cxMiiBggNuC7InAyS4su2GdYe/GEdPXeHaQpdwtf8n3hEKpwN6gbvGLyDB?=
 =?iso-8859-1?Q?APnVbab4Dhs/RPkPGYL5kVCCVvMYqNmLCWpT5C2PoiGCxuv7NsUkbV1Ldd?=
 =?iso-8859-1?Q?0CutD+zyfOAEOqZXGwxtkHUzqGrhyg3JLv5qUItr2zaHBdpPfox2VW5PtS?=
 =?iso-8859-1?Q?37I6iB1s4mdvRyj1gjtPEOfs47VYVZkUkY4DFdug/wWs8ngZjItEVUfOIm?=
 =?iso-8859-1?Q?drTNNJ8dOBh619Of/sCktknNL7TOgZt9NY7L3M4FIXn+l+7vTI7GYVxIGD?=
 =?iso-8859-1?Q?rZEzpGWiajDxKDGK3Z/MIyRknp/qi5wbgkwXg+TJDZ61OfkAcaFzbbgfBU?=
 =?iso-8859-1?Q?BEFfPvRdZrAxl9xpXZgSUl6HKiyjduTmvefIA+hZYcl6I/v4rbcX28LBEY?=
 =?iso-8859-1?Q?Ks8jGOcqxasMW6m1Y1EJY+Y1ZvQ72KS2N7jtRYpFODtRbzwoVlmkLirCYR?=
 =?iso-8859-1?Q?UewIEIt8DmyO2eGogtlQaQgYF+FYvgUI32cvlTGmSRbTjM85DZe1oQyPyz?=
 =?iso-8859-1?Q?V71v/89Yz9B/i728PwSmG03xqCWG0cwOdlVo0eA9oQuVHh+4A5pYMW6bAx?=
 =?iso-8859-1?Q?UBY81z9j+X0JcboqLT1JaP0LQEAvLtr5hxOho/czhbxH3ujZQ/ySExwPHb?=
 =?iso-8859-1?Q?//K/cb02rLgtNQmYgf+qQbhfMGlrqFB7f0x9vZLvItFL5w849utYL8jFjE?=
 =?iso-8859-1?Q?26j1XIw5SgCBaTx44jZAPMbcm6PV9qCikEL3lwuExnToitvqoDnhdctawV?=
 =?iso-8859-1?Q?MUh0kVJtGxE6w5GGuzPcuIGGZXVNyYufmefaG9IATMdCyJbnYCK03+2qeg?=
 =?iso-8859-1?Q?vm5nsrQD/dSE/KmTNggSYfUdDieSGXUazXYjq5GENcm0s/j7Y6em1w1EqS?=
 =?iso-8859-1?Q?CqdYW5z6QXzLgKP0UkKUzuesA1gzyCDaDnyP3uhuB5Ie4QzS7UHpi9AoIX?=
 =?iso-8859-1?Q?sqv4DZkU4bzT3BDF+ePS0BFd1du7gY+VUhpYj/m8GhHPB6gADzGqWpRwu9?=
 =?iso-8859-1?Q?toLg8pQpBIggpjil5o2PEOy/Jkw9wFiElGiDq9g8dmX5yB3SGn33lpMCt2?=
 =?iso-8859-1?Q?64qSbU0KALre6ZCnoClxOK8ZyhyEU+D2XZXvyPcSqM4cUscfTHBOkmu2g/?=
 =?iso-8859-1?Q?MqszMolx7COgJ0NPa39xCaiHOCJETdjS/iZVXA8laq7gdw980HFqgwDymW?=
 =?iso-8859-1?Q?XaqYZE7D6KSpMdA5E7bPBF8SrLwu2Jp6sPiCb+6zWv7heU5B9tdIITiChO?=
 =?iso-8859-1?Q?1NCh6iG7Wq5Uw5wGmQGrv6Nh1+wv+OyOaIuk6gY1NlqWNxSRoyy71RB3Pj?=
 =?iso-8859-1?Q?PV/1AhbKqhDS28DTvoYtpddE2aj9lb+XJaNipDmCNA5KmLfymTAYtnbsMQ?=
 =?iso-8859-1?Q?UfS7jk/aF67UDt9F4fbnFzWrdhfpViLjdV8mu4MC3tJwn835jBTBLH+zCc?=
 =?iso-8859-1?Q?DxTzSFuCzFttB9a6K9nWAcckd2F95mIFQL4Nn1fXA3ysbD6NDc58UhXLi3?=
 =?iso-8859-1?Q?U2TtvCCY83oQHycWj53AFzLUHtqUSynX9p/4cRxoBC08B7Kijexk/TQTnc?=
 =?iso-8859-1?Q?w8h3r9No102w5dsnqP7f4DEfq1INhIowYD+aZF+j3jYd4AKBpcAVTqJJO9?=
 =?iso-8859-1?Q?U8StD9uy//kBtszqiDbQIQV2ODN/5aU0kUrdlifm5sJ72mHNdvWRXzm482?=
 =?iso-8859-1?Q?B7L3Gv08HQoLLVm6G2f6w9UnA+xiA09RWS+MsN6OPEo0PE+aUIWVQU3Edt?=
 =?iso-8859-1?Q?T8wdJguYMl7cAbpF/5WnksONXOxtcKshEchagcJ4Fxg4Nqz0WdtOjBoXJI?=
 =?iso-8859-1?Q?qTYPpyVBTMvu4AwCSBLiX4oWZxi16265uFlv+DiNWgY3JRixQOlA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e727737-6022-4405-9d07-08de7f659ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:59:17.6976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTo4RNT5F9v4izXnf1NwL+tD91aoGsKRMvasXUbt0NM/fIPaiBamD6KeDKqcxcB1ydrS0U0vYP84cJ9iYghbL/csdnLmkjzNxegpn7updUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB6069
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

RISC-V instructions are always little-endian regardless of the data
endianness mode configured via mstatus SBE/MBE/UBE bits.

Currently, instruction fetches in decode_opc() and the page boundary
check use mo_endian(ctx), which returns MO_TE. This happens to work
today because RISC-V targets are little-endian only, but is
semantically incorrect and will break once mo_endian() is updated to
respect runtime data endianness for big-endian support.

Use MO_LE explicitly for all instruction fetch paths. Data memory
operations (AMOs, loads/stores via mxl_memop) continue to use
mo_endian(ctx) as they should respect the configured data endianness.
---
 target/riscv/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cb4f443601..413911f7f9 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1255,7 +1255,7 @@ static void decode_opc(CPURISCVState *env, DisasConte=
xt *ctx)
          * additional page fault.
          */
         opcode =3D translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
-                                    mo_endian(ctx));
+                                    MO_LE);
     } else {
         /*
          * For unaligned pc, instruction preload may trigger additional
@@ -1263,7 +1263,7 @@ static void decode_opc(CPURISCVState *env, DisasConte=
xt *ctx)
          */
         opcode =3D (uint32_t) translator_lduw_end(env, &ctx->base,
                                                 ctx->base.pc_next,
-                                                mo_endian(ctx));
+                                                MO_LE);
     }
     ctx->ol =3D ctx->xl;
=20
@@ -1285,7 +1285,7 @@ static void decode_opc(CPURISCVState *env, DisasConte=
xt *ctx)
             opcode =3D deposit32(opcode, 16, 16,
                                translator_lduw_end(env, &ctx->base,
                                                    ctx->base.pc_next + 2,
-                                                   mo_endian(ctx)));
+                                                   MO_LE));
         }
         ctx->opcode =3D opcode;
=20
@@ -1401,7 +1401,7 @@ static void riscv_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cpu)
             if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
                 uint16_t next_insn =3D
                     translator_lduw_end(env, &ctx->base, ctx->base.pc_next=
,
-                                        mo_endian(ctx));
+                                        MO_LE);
                 int len =3D insn_len(next_insn);
=20
                 if (!translator_is_same_page(&ctx->base, ctx->base.pc_next=
 + len - 1)) {
--=20
2.34.1


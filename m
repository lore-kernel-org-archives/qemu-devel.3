Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A05CCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97n-00056C-UL; Sat, 18 Oct 2025 11:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97m-00055K-5j; Sat, 18 Oct 2025 11:45:42 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97k-0001Rh-48; Sat, 18 Oct 2025 11:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cutn3ZUpz2JvpERW1Hx8F1tyFemrY6zP365P2UfHZO97jmTY44eoCq7QhjbZKqVPm7XXvvKuNm5kzpjI61jfPsy5mxp8o1fRACp6z1N23cr5K9vhgiAzN+vjUQsJAe25EjIFHE/UDQcDM/Yh6rEL1s+o1+fbkPREr8MB+1nzsnRm9DYGdO/bfixq8w3zvsnERMyh7vLVJZ4CYe6Jv8nLMXMDVoC2LR8q9L4ZV7+KH5+QT2xl9/TmCMKUl44gwWElqU7nuin3bwuz3WdFskliE+LunBX0vY/5u1soQL7v2JIEg8tbMcL5uRlSdPsUG08/kFLmjHdkDE7WeGt6eruqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2braOq5ecbz3Vm8ktPLzy3hIhWI8JevJoJP4vfqqmZ0=;
 b=Yqr9nUVl328rAuBPsgzd6unSSyj7rf1S/85TaL3uPLo7UN9PRpJaGQxvJANXNsirDvN840pVdYLhsQaxyLRbO+QjunMQ567pnWKrD04jkl+VIjIvBjNsPKwk0HXTDdky6h/grLPkVXmUIGAVjT05UIZEW+KsY5cGsfiMs/2k4PcYBHUeUJ7UA3XK/jDPR5XivdHyDhvF9UYQrs1zW5DvfJEf2HZaedsDKSsGglRQ9Qfj0OSHvPRDSQ1qvl8epN0wMlDImNmlRW1RPVP9ErJyq1k6J8q4ru2XM/5b5CFMj3NpLYZaM196ZqikO8tkX14ygPI08ot5/3kp/ZHsYiXc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2braOq5ecbz3Vm8ktPLzy3hIhWI8JevJoJP4vfqqmZ0=;
 b=H6LFkT+1kmqBsKK6q92ZBlaPcvM5THr+LhviYT4J+vXRR73Xy3Pm5iQdmfY+nQ0DNC12FmlzZ/vn2VMz3TL8IGFSnoxOvEvyB/asPm/kEUAxhfrsFXr3wzqCDMt1JRLS9jtHF3v6VbBSgUF20vvaxMrL0iHGcQnE+A1TYhP95lJWeaVCP96mOysThkyb2hjjjgZqmf2SHyIOKd5cMJCpDw4/F7CiBk2QyoNeIKKpJmwwm4haPs6F11OtGgX9KKYWyr4XM9wX1vLcHWB+3ctHSsw61XXM40AyyPeRtdjgWHavfevYGRHWFiQAOpFGGHrbeJPADhlI1m7WnEMENnLazw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:29 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:29 +0000
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
Subject: [PATCH v13 05/13] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v13 05/13] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHcQEY64HHv1J+iIk21MTKX/vlj7w==
Date: Sat, 18 Oct 2025 15:45:29 +0000
Message-ID: <20251018154522.745788-6-djordje.todorovic@htecgroup.com>
References: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4360:EE_
x-ms-office365-filtering-correlation-id: f3681830-459c-46c8-4b21-08de0e5d5d76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VDG/HTAZddEA9LiLztU5uSTOjQGJhLEqe1wEY0cPQApI5SAqHLlcNmm2Vh?=
 =?iso-8859-1?Q?p23+uGKJhHEW4911Qe9Dfe5DbCNyKEh5tIKbcNFb2MLuEt1sT5RP+LTDzJ?=
 =?iso-8859-1?Q?sl29sB8icoNSgr23lEeoKysdqpJj8I+jHAXHDNyQK1lZmXySXufQBgRyqD?=
 =?iso-8859-1?Q?bHj4ltni8ttpz3ukHDZh9V55uwJyXlkown3lJ3CRnV5fv5SPe1utDuk1C8?=
 =?iso-8859-1?Q?mP3SbiRFJLpYflLn/epGAXkWwLCa2uAViN6uGl8gWyA2grtreWgRJYZDUQ?=
 =?iso-8859-1?Q?OBcxXLfnQK26y2qk3kNZ8Oiach1XGz/JmkrTIbeX2LHI6PjBHvhUCB0Ygu?=
 =?iso-8859-1?Q?QbZTRFvN3CpIGe51EKwaox9BjF+2AgFvYYhbdZZj94FjAZ1yzWJcId4i3U?=
 =?iso-8859-1?Q?o9NLIzqb5pCE//+xiLytpMl5cOr3QHk+frgh1TGnbcl0NblMiRhCIHrf0T?=
 =?iso-8859-1?Q?jf1k0sOGwifNSqGTgwEZKZdp4qULdj3AvIcboO0Bul9O/2YllpP/npzgkY?=
 =?iso-8859-1?Q?kEFW2lnz2PpW8fvadx0uyGjfhBhrnIskGnl38Ug7eIOxigvD9gqPpUUbu3?=
 =?iso-8859-1?Q?tzDiomkNlAwHgqUhvLU8sAO1DXETh3eoallg6iZcL+j5oiJMmz/knDdiF0?=
 =?iso-8859-1?Q?0a2DNOeDMzcLbCwgo468Cou4RfhsJxsR8ivBXuqgnkIRO/EYePdq2pJkAT?=
 =?iso-8859-1?Q?+1k3Ig2ip5JG67fNiE6Xe0fs8yH6FS1pijyJmyPYnwEstCx0mC3O4+4kJf?=
 =?iso-8859-1?Q?ToX4dMn6wClubuBKJrEsS1npyvKgojx1GFGQ+DTxinPmr6w75s+mT9QF3r?=
 =?iso-8859-1?Q?BarXV+5cfkVdZRBIXCzn40knAyJxzWLnLNEINgbFrPHaWSyqou6IFcXYNh?=
 =?iso-8859-1?Q?ft0qStnj0nAZPt8AqTab49xjmP+JBiD5enxRmOEUNlQ9pzJ7B8BfqCN7sq?=
 =?iso-8859-1?Q?j13EftGAxXQDcbPRG3b+E9OiE4v2biSZiGnDUNb40ZTjQp67aKWRWZhf/Y?=
 =?iso-8859-1?Q?bpSijQ07W8wob0XAQCrV7QIpEs+T074acSdYB5r7gDlZnvSvCiASUKRKi0?=
 =?iso-8859-1?Q?R1pVzyS7euc5WfFKX//VkrxvrIlVk4SfiVx7QE4/rdW0c2O4EruGtxfCgh?=
 =?iso-8859-1?Q?zkKf8JgxNpHlgFOSLHe+c+BBZsVNUcJFKxRTmLKE3PWeLiyRMq3lZqm7CZ?=
 =?iso-8859-1?Q?gxHoIaAW3f3hegdOawb7JAoelnObBdJNET/s6V/2Kc2kTf9+1bbDxYffMx?=
 =?iso-8859-1?Q?pz2hawV+Qz5AN7760BIlrWZ684hs1JDYGctImDz/8plhlZmhzuGX8MQd7Q?=
 =?iso-8859-1?Q?5jHWHD1R6vw574tyUSVcj8Ao4CREMFf4z18KNQYQgAeU2//pb6z5VHUXmP?=
 =?iso-8859-1?Q?ezcUVXRbkyQQtVV1Bw0P39O+JEvB7vmqwjt5Jx8SUJuTl42kxZ8qFU5tr3?=
 =?iso-8859-1?Q?SyRHnjAlMqyfNESXJPNtqs8HAvHeXrE5Pw6Wf9BbEvM8dsOEir2Ybwut0Y?=
 =?iso-8859-1?Q?R6vrnbSzgFkCegxH/V4DJ2n5S4OHmDyAvBl80NhflygtaOmGkCwRWPjdju?=
 =?iso-8859-1?Q?oYYUL5SGU+ctvSOn5VTOJ8wjnmyf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DHQA4hqGuHVsCUjxToK4Y37L3gL+/SMUwrzGY6Bv2hDt/uLke0SB1t0DFq?=
 =?iso-8859-1?Q?5E2s4+xMqEciQEnmKSxk1+qD+iMmhw5fXDbcjhmEz6a80Bk4w47JSOj22x?=
 =?iso-8859-1?Q?+RZLcslVn+66cvn/bwv0DiMgX9svSIda3FnujKFsoyPKy+CVpctVUfC2po?=
 =?iso-8859-1?Q?VlTyik3DGndBO4aslbgE7efIfUO9KfJYCeOVj8/mdDELGO0YTmN/2g/1yf?=
 =?iso-8859-1?Q?D2+AMRldCVEzGWgW8RkZBNOK2QVBsM6yLigDDrECfkwaSW9IJo8WnoIt33?=
 =?iso-8859-1?Q?i0P3cM0uMcZSRPwtXgdgNoW78JiWsj45U3sMUwipWTiDNqlcZYY5NZtmm5?=
 =?iso-8859-1?Q?g76ug3kWMcOYAvDitbZkJ/BzI4RIQrXJZADi0jekpFMz44H59FVOQPXqmO?=
 =?iso-8859-1?Q?9KoZwUddXsdfPusqoiaWyRqG2d0sAi57YUwhJMgvijRpminfC0baTqv/h6?=
 =?iso-8859-1?Q?E1FuQIjwJtWtha09n3QBOjkgmAR09Rpm7satdAjVwvLCpX57s9nCjMp2Ar?=
 =?iso-8859-1?Q?a63MGQ4qi3rNbPWx8pBB9MBei4s/uzxw6nl79oK+ZwlCL2j1K7bsznPzXi?=
 =?iso-8859-1?Q?J/GTzT4yM7xXHYpZZ83Z+Rxb12Zzt7cmBjL13016mby9OqeFuwEkMM9JDZ?=
 =?iso-8859-1?Q?yZijV89fk9TBmNAJRiGdDTZRlvvDKiTYP/tKMrOMKb9Wa409qTeSYTG7ky?=
 =?iso-8859-1?Q?+AXk8+RxTnJpJqc6+ryR41pk5+gSrCMODvpf6+F5+isoh+vQTUIvPx1aK9?=
 =?iso-8859-1?Q?rA1U4+9okKrLrkHv9cQ5wpOpWm/rklcw/CZd/4zyDEQxJk9gLOyGIlhwc/?=
 =?iso-8859-1?Q?HUIgEspHZQSLpLxzok3vVGA/jDClGlR6pfHmkW0rZSh0rQaHgca8IHs3yG?=
 =?iso-8859-1?Q?dT0vKeuyfcJ2E4EHPM854lf+qYBLgO2fjdOMnF8Q5+ffdaZOyox7Ixwa7T?=
 =?iso-8859-1?Q?wRhPP1eeda/lCWc4KzHzgVU90tNayKrCh3PLaqJRneHPsJvgEK24Fad7Db?=
 =?iso-8859-1?Q?WnBKsfzx6toFSENcTkQY4wlTxA/Hb3yWLXitm39tXuGDumIUR1ZGnmke79?=
 =?iso-8859-1?Q?7LheTwEB2ADW0g7vbbSEiYOu6DqvhBDySnJUAbo4bCobzbP8Tc3Hxiyjqs?=
 =?iso-8859-1?Q?pfEAqPD3gGgxl01y6RtMMswBDm0gw+m52EZAlbBRWkhT3lu87jVmja70Rj?=
 =?iso-8859-1?Q?tLhGzjP8i8Hb0SJm/24mNXAyeOYATQbXVbKSeufX8ERLnJwMikGrqkKMkm?=
 =?iso-8859-1?Q?BHt1cKflYyYrngXDFd4uO49sO+yYEA18WAfKur1jiqzrEzasLWOekXkj+j?=
 =?iso-8859-1?Q?ZK238s7yWSEVm+TkAJnBRP/gdPaWOvsZyWD5f1IgbwarPBYOffG+5yF5T6?=
 =?iso-8859-1?Q?qmxY+H3Cub1kGiG6rwGGnU9ktZ6F4prT/slxVhFcHdL4g9XzG8fAfCsnIe?=
 =?iso-8859-1?Q?i7MuoZY+rDL3y6tUkQrTaaDe4oMvwp9kxaaauTCVwh+JNHHNhidDE9E9T8?=
 =?iso-8859-1?Q?wtLziXONZyZQ7vFowhD4EdmQbHWXSmLhbDVUpApJpilUAmfkJfCABpoyhf?=
 =?iso-8859-1?Q?VHg4Fm1V0D3dnzeZc+X5AUZm+F5pVQB9O4u4NLrJWuPPIZRgBOaphoCxRT?=
 =?iso-8859-1?Q?b2vGO5ldJWiDzhyWSulL8AbIwbh293n059jjE26K+knqCIwO8qKZBy+8TA?=
 =?iso-8859-1?Q?0PQeuoHDGF5PqSQpvT4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3681830-459c-46c8-4b21-08de0e5d5d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:29.5591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kPkNhARz8xt+UtGSQdEhuBpXAfYZyNfbb+kAU5UkV6DEIGAIHKKu78RN0KZh6bbjBVOkTyrErFHoAKCCbSLX7xM3hZP//TZmzHJRMxODzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  5 ++++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 33 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +++
 target/riscv/xmips.decode                 | 11 ++++++++
 7 files changed, 57 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2fd0ced25f..87cb367676 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1381,6 +1382,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3295,6 +3297,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index e2d116f0df..a290303ee7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..3202fd9cc0
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,33 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+/* Conditional move by MIPS. */
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 25d59ef9f9..3842c7c1a8 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..66d31b67d3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..fadcb78470
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1


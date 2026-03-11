Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D106C106286D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IEH-0000Cl-2m; Wed, 11 Mar 2026 07:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDu-0008G1-0T; Wed, 11 Mar 2026 07:59:36 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w0IDr-0004dU-O7; Wed, 11 Mar 2026 07:59:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNHsScdhU+n5lQve/lGQJCVYbrxeCyGHWJtRxyi/0yHOtIb6AcFcnMveuAOqpbXY+CFsTn2n/PXTDT3HsOBUYMOfYuOfnCnxHe/0XsA4Avm6qWY07t/Vlbgcbx2jQAlSuIhaABO6UzzMElyAP0JNO5kKmy0GkBLEANLQZvZn450Ujo4Fww1uZwjBiirvfdfSYO10nuNYZjfLKrp43h31Cqx/OHM8d/xrPRnT0wFlhZqprDGui+XHS9b7To8NWf0IDYmCUG2hdXcjVQtwiHUxg5bj+TWjRVhNS08Wre3jTY8w4uW9jySdwdWOYUwMVK/d4aisePE+rVyMedxtlrqrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpZRMbEu+DbcxNsi0jFoqxmY97B3yL0FLW/gg070UHI=;
 b=kbeaBeNwpBNo/zwUKn7HqmmOa+LBv+PJQoOUh17w4jqe+wNHBrVcLmIbGNN1UtbpiiuhOK3lFXgtAqYzmKEEpA2Lw+v8eoYPk0TLalEChnDUmSywAoPtW1A/HN2OveaBXWpO1IhQ3MbqYKOj5VDuHrOQnvR9TO868lJiwrq7WeqPGp+qBRLjId8GYtVZha8pv2+vtzVJJDDwGvEqAoRei3l/ZLuryxfPzi8Nb3WLoTzNfxP8lznJMMST+ffYoUJKPbcTREHY0xIam1R3lNimh5CY/NZEyTeV4jDsDlFsJ9vTbnM7QfEJH8pbmMwcAo6V269TDvFVs//wZZmmG5YQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpZRMbEu+DbcxNsi0jFoqxmY97B3yL0FLW/gg070UHI=;
 b=SGmZM1xJ2S1aJesMKdvjGFMxbVzSwI6dNBCPw7903OzG58ZMQvouzBY7Z/eaCZHWoyPobNzH3SCzcicm0d0D4FNSxEHaYkO5kZAgVPBifQpw95WsFuRiqSi/0ZlyJxlVSI0lLuB2vOE0GaMKewTXRH/JyIwSs4vixSpqxG/Cq3qn1u+5SOpRE6oMD//WYMOZ1NSIkyuF1QQOuciEqCdLSHBxsdZuT2EJlB7IHFvVyTaYHG3YHoMKHT93yJP2r/c4rUJ21ixcrGbl0fsqUeDcLuK9EdxGv3gb00bSSaJ7NVwmt+oc5EQw4Avsg9B1b9+pR+DwZy13aSbctBdoSXu+pg==
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
Subject: [PATCH v3 4/9] target/riscv: Set endianness MSTATUS bits at CPU reset
Thread-Topic: [PATCH v3 4/9] target/riscv: Set endianness MSTATUS bits at CPU
 reset
Thread-Index: AQHcsU5967JdqHXbmECHWiSK6MnYgw==
Date: Wed, 11 Mar 2026 11:59:18 +0000
Message-ID: <20260311115910.564481-5-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: fe46bcbc-c589-4ef5-fedf-08de7f65a05d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: dkiNchxIE/r7ZqX7JaAkVnUFobweQaduBdmrqlruPncpGDtwB6fsxth2bKBM2+CDQHIJSor7FypECQp/8LkrItGAI+QddQPqwp+BZWEel2yPMrXhWr4xCQZiLiOcnb2fkQthBLB6SfzTSzNNpjOvdio7F2JYGh0/ZOh58hwDmg0Uffa/g8XoRD1wOhgy6SRwI5at1FJ+gID59YigpiPspt0clKdIilAewt6YpeVxOgyKvV7sDcpfAh+EqYpIAu2bJgzbR/4i+7VIjjIIeQlne5jYW+U4sHJWBg4rMwM7f4Bux5qqHVJLLawu8wZxvFlPjVbmfLfJWQwPnNuvHeP+12tiRdBQWH6YGpii+qGDWZXw30QqnxdIL58xl63DR3tAHj1DRmXyp3GNQ8bguPrFkaEJwJ8pj6lsn3vWl1a+h97xDHjFrBeNtkrnRQhZHToXuNisYzSAotCGJLBubuAleLYUcP9KOS1ev630cjcey9jH6THV7rvEhKR94MQzAfezWEz5nTe7hXMwbN0lj7WzRqHEcU+OrH7petd3/rp8WaogGlQpfA1P5UYdlyxkWkG4mM7SkfrzjEq+W36ooqHtc8IvWbSw42nWQGWQmZxfVsSYdqNt2kdDX9ylxO6e0LdEAe1GXNm0E8tQ/0foGFL/5Qru+0VmDImkfZNN/tZRQPDm2jbpJNS3aAugrl+c/yownbPHpLJel+JpAqgX/7JaxV/hkGold1t2xzAnVbX/Dqbnka1JiUAMzQ7bkqgB8KkHvrBSWAsxl1wRYd5PXNJSCsOx4Pu+bDgzjprU2aiDXzc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0+lkIFTs0ao9FvuYLLGdS0Fn3dis2tlSjRGw8GS063txhI7g0u1qJhocCO?=
 =?iso-8859-1?Q?sPFVJQptOuLSBiyvIKcF67kdqWaAEA9rrOQiR5ub+lCB9od/TOMU0JamrV?=
 =?iso-8859-1?Q?2Fq3bcFVeFGAZllK74iQs8QgTSdbCnI7ck1aG8lSoEeFbE1psDKtJW38NW?=
 =?iso-8859-1?Q?6iwBK+v4nphXuLgj/YqM2oUevOiN5MfPnBlrCErZSuJ5/CeSg2q44TS9pV?=
 =?iso-8859-1?Q?LEdk+ybU2PQHJVK2bjCaRS+jCfs4XCSdMy78rS4njrWgAzlimoDxUlPQJj?=
 =?iso-8859-1?Q?zX2uYUbWEfQmoxjgEtXyxZvsSlIlroU3ZWr9hUxPDLmYOq4NnmcWUYvFlP?=
 =?iso-8859-1?Q?x9uaqGtrjfPgWOy0/+7CbYvOsTXCGEr6wOZ9r29q5l/I18BXUGas/01ybe?=
 =?iso-8859-1?Q?Wplb+sUYPbK4/olWIksJhmow+niPTc+WTqmEAQ6aajvn4E8G8cJ3fvy6PZ?=
 =?iso-8859-1?Q?MTftEwBdNvXaZi1yXNg05o1WjRbwm/fRV2l/S1IfRunD7NjcSMp5FEuB7x?=
 =?iso-8859-1?Q?1UJh5gUwZ0RGwED+DhLGcqQUJcL5SLr4/LAB2nGcKnu/5ovQ/c3bSKCxFI?=
 =?iso-8859-1?Q?kc+SmoHy4GwFFMczq/wY6sJKHSEX42vQpyR5suqkwOqt7d2cop74MHnS1s?=
 =?iso-8859-1?Q?JlQHi1WPXdjD9swM6eO/+aHcmxC5524/DsiGzt3xeFVSkfJnaE/73MDtBA?=
 =?iso-8859-1?Q?iv2EhpYlvDSXeX+vJKQwM6WZU3qynfByIdXIaegs0LzwflAqHaHKvi9Gch?=
 =?iso-8859-1?Q?go/Rh1Q/Fvcc/1JSBzzFttLiG0/Phs8Y57x3QzWnUhQ/SOYeBlH9qrm0qr?=
 =?iso-8859-1?Q?+pPZanGKReFSzBpfMy/QhCZWmA1fVInT06PnwNT0Wtjbr8A5Akz5rJJD7Q?=
 =?iso-8859-1?Q?xFtxdfgQdDHGSiSxDRxDxSPTo4OpCsReKKSIeSuj73mk9xcZj1NbWAXA8H?=
 =?iso-8859-1?Q?heEjfEYALaI/T6Ne4Ihex120/SD2lbnVUJGiGYj2PDGfZ1NvMQXECshIMm?=
 =?iso-8859-1?Q?40iNEdtPUXHMG2mNENLZWJypgaTexIZYk8xrjYN4x8At5xY4jxhE53fAUl?=
 =?iso-8859-1?Q?gQOnKZjqTAj7ZxyurWrNnXw6xm616gYzlSjosSkCIjVipvcgZlhNLNm4bK?=
 =?iso-8859-1?Q?DP9CvdrtiMc0R8RLDuEDO0pSvb2UbSlFhq0IysPIY//Ml9xwiUIFgaE6rx?=
 =?iso-8859-1?Q?j21R3XAbXwYQtsMXksAXUir7SLryzLNGuN8EMJLxrrHPJctqha5NAkWyQb?=
 =?iso-8859-1?Q?afk2j+oJtCAEP/8dHWYKnQesGL7PfgXTufkNViOQXEgOczT7owVeU/3OIO?=
 =?iso-8859-1?Q?MsRbSlRUuJk0GHE5m3uJEFHRFT1yMb+TGbzTmyYhJ9BoOF08OOSDbuJQE/?=
 =?iso-8859-1?Q?CsLXTa6rFG7Yg1xJGb+ukXlqsroa6A/7l75Gilyyp1E/3J9c4YJBiJcb5u?=
 =?iso-8859-1?Q?hfLC0amNvNPQ6RT4/8qKzT3gQ8GEXdDWKaTY/H1sdn3RBztERG81FW2Y3O?=
 =?iso-8859-1?Q?gbfCQ0JyjwGbkJwevhGFhxuFt2KZzBbOzbthRhAYJETEiE+4DWtgqCLLOG?=
 =?iso-8859-1?Q?X/jguer6KSKTs3z/um/D4rXU8OtYkqXsgL5BtzZnyAepyT0F/WTvzPhn7c?=
 =?iso-8859-1?Q?txrkQ/mAWsCc3oiZLXgHQKA8FQjfoYWXzknoyI4DqoDudx0GnTrtorZQ17?=
 =?iso-8859-1?Q?v0zGgcsWgqehjiKoaLkS/dBoYcjmkfHk5EbksbrNVCmOhq5J+FMfiSmJXU?=
 =?iso-8859-1?Q?tlmgFPp/4F1Fd/4d57/39KW/LLUZEqe0K6DHEX4gP2NQlcrhkZtj+NdLPJ?=
 =?iso-8859-1?Q?9dvjvdyPLCWqePDqVQNpjdpm1FYmcW4NvuHbRvwMexDqQS47hyCZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe46bcbc-c589-4ef5-fedf-08de7f65a05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 11:59:18.3232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bY9olr6Sw+nwnZBx3N84Bij/WG+yEVzuauWX3nvBynxwv523TfomPx2Sgw1BvT5mVvWQKCUnIIsbXECzT485PGlgDvEsJfbe+yxgHBtDokU=
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

When the big-endian CPU property is enabled, set the MSTATUS_UBE
(User Big-Endian), MSTATUS_SBE (Supervisor Big-Endian), and
MSTATUS_MBE (Machine Big-Endian) bits during CPU reset.

This configures all privilege levels for big-endian data access,
matching the RISC-V privileged specification's endianness control
mechanism. Instructions remain little-endian regardless.

Also update the disassembler comment to clarify that
BFD_ENDIAN_LITTLE is correct because RISC-V instructions are
always little-endian per the ISA specification.
---
 target/riscv/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 305a8d73ad..4e5781ff04 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -717,6 +717,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType=
 type)
             env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, 1);
         }
     }
+    if (cpu->cfg.big_endian) {
+        env->mstatus |=3D MSTATUS_UBE | MSTATUS_SBE | MSTATUS_MBE;
+    }
     env->mcause =3D 0;
     env->miclaim =3D MIP_SGEIP;
     env->pc =3D env->resetvec;
@@ -804,11 +807,8 @@ static void riscv_cpu_disas_set_info(const CPUState *s=
, disassemble_info *info)
     info->target_info =3D &cpu->cfg;
=20
     /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
+     * RISC-V instructions are always little-endian, regardless of the
+     * data endianness configured via MSTATUS UBE/SBE/MBE bits.
      */
     info->endian =3D BFD_ENDIAN_LITTLE;
=20
--=20
2.34.1


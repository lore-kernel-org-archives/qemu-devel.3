Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C757C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 13:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4yC-00088a-2w; Mon, 02 Jun 2025 09:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y6-00083H-Bd; Mon, 02 Jun 2025 09:12:46 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y2-00028w-7Z; Mon, 02 Jun 2025 09:12:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Maou3jFp/XE52jKAKXjym++cBcqqlg52KJOqT2Piqu7WeExxMcg99aiET/y9y2dmuxH3ukh2a+9eI0DIsa8UEiOiPSZ6NoAQoR1oWz820ZZ+cHDkuitTXZI6Kj+UDqybfw86EJPQrdoX5KixXKiaIWHoTC8yf47BH4D3Z/SBjkSKmKuCWw6C6/e0rEzEDJCcft5D1tjNVTLxNjKxz6IM/tcKU3ig6420qYCH/UMNAggI0efBHaDjfCJ4LFPtuD3s9t5nIow1XX54u4rTtR8lnzDNjvIszvpmmnfs1nugpNG9w/OC6Ai4P3t3FLgpgb/xsHHzb7+x/ykaooBtKcKVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bH2hQ7Vox2/GDtw5oXvGkoEds/gt9SLMBK/TY6Lliew=;
 b=sHoOehRsFzQnhsqi1ha7233tNA25Tqzj11QD+vlpj+zaypikUnW2Bk2YhXlYsaHUfPyS6U3CLCznK6OkDC02wPxvfBtFcN1FtZSKSbzGz3vX4hujQ9Ld3LRVDj4+8uE+9DjKekPHigOBCVZm5XIRSKOYtkg+v7/kfZYd51Fx9dpmPyAjCZYElLIMvYyp3soSUAipeeVCRV27vwyHBawJbZj4AUvZ/bSvjA+zBqmUe2dDpjynO1g8slWFCD3hZJ6Tbr1+p/RBCeNtkHFopHLnEWTqpdB9DFlfFrJSj1g4rXfhmKzcXO1nGF5Q3vbG5sOQ7JSrC2D14HanCA8QHcZTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bH2hQ7Vox2/GDtw5oXvGkoEds/gt9SLMBK/TY6Lliew=;
 b=V852gdt52uqwFZtIE+YyilZMUREDOmY3iil8PVhHjRTvLtA80cLc+IT/bWNZejUxmDPbyjZ4Nrt79tGnWGToUWQLInplYExryjhdA5cpQMEZxxa1FXIDLiX2fFgHE55uA5ibtYclAu9Ce1xs9ycdrGjOuU9hNzvQnCe0Om/a7wiViCy8+tPDittjml1dB8Cl/a+wGXSd+TkNFe6kQeVw1jCw5thotbDoTkTMdsldOWC9e8Kes4Lstt1753MS4zxHwifxqY504iQQOzzJn7FStFLng7ktLYtfjELGI0XRMv7gUHsxrfnrwW9hvB7iClSP/WJ31mvdtCn9beJCAin/kg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM9PR09MB4545.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Mon, 2 Jun
 2025 13:12:38 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 13:12:38 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 7/9] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v2 7/9] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHb08ACdRr7G6GTPE2qRNmfHibDaw==
Date: Mon, 2 Jun 2025 13:12:36 +0000
Message-ID: <20250602131226.1137281-8-djordje.todorovic@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM9PR09MB4545:EE_
x-ms-office365-filtering-correlation-id: 880df965-4f80-4906-bf26-08dda1d7261c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+b989PEa9DTWmy29XYvA5ImJ/UPcllZ2GgWCVQS+vv6V1osyPQ6POEDytn?=
 =?iso-8859-1?Q?yrh76eySNErtH1OC0BqA9JSWQzmj5TJBTdOrpWj3ReYJqodPzmzxMmqay8?=
 =?iso-8859-1?Q?6cDZpePsIZNRSz5AB1xznSavaAJGKs4IkrzQzey2kjUaMs9ye//2Z21Jik?=
 =?iso-8859-1?Q?/1LpxSPXJvwQ+eWBGArlITQzp2bTsagKN8+EERPWf12blnIzBWARYe8bSU?=
 =?iso-8859-1?Q?xD9nqSswxQ5gZ68kQoNrixkLqeBsUfqp5zFuyBkd2scxBZg0ML12qdcn9Y?=
 =?iso-8859-1?Q?0j8BxGMWhUJ638K7Q/X0CEAewgohJN4Cvotn9sIn/ImTmQ/erA6D54ETm1?=
 =?iso-8859-1?Q?7uK0EwuxWevRFzGPI9/wGD+z3s4kOiUH5+Zjr8nTvhg+8yDSZs1votZkH0?=
 =?iso-8859-1?Q?djZDF3diFV9W0/mkYekiAqM8ZVDMcu0C/LFXRes+Y4einfejoOvnpY4e3U?=
 =?iso-8859-1?Q?COu1EXPD6jytuasi3ehJ7fOyWjjY3ycw8/TQc5DFBtgiXUFTjoetonZd1a?=
 =?iso-8859-1?Q?6kyfjmgnXbnyZ0Z+URC9nbFSKFgeHJwtCYW+OYeHmG159qvTyINRAy9scT?=
 =?iso-8859-1?Q?zMSp1stlgJOK5dU8b2Hkia6MmuL/aI4cnk/+vlaVwOWAvssSb4C526nYew?=
 =?iso-8859-1?Q?UmMcBdDo2ynOpgEYRh43TFinWbyLkXQKrloOQOQhceQ9g6CL8MeYmhXG+y?=
 =?iso-8859-1?Q?hDXxmmP0MQBaKN/Ma1TTvI6bTDs/EtsN7wBxUCP5IoslaoduXoeG0fLEXN?=
 =?iso-8859-1?Q?n9czGekGnE3PlhXU8irTVRxTQIb+JPbc+tKj3y3CnjdcocnqSckKd6rEDY?=
 =?iso-8859-1?Q?eI3S1qgfp3znYHf/GlZYr1/CwWI/79ycfXcD+arVbXtkWaKWNneTZLPj1I?=
 =?iso-8859-1?Q?n3XC4J5vECdLGPv7EkP2WAIUdF7ATpLEh3MpSvXUykZ164MoXRF8prEMCL?=
 =?iso-8859-1?Q?N3XMQV4a1i6h/CxLX89LuwcGuMKyoSYrIQ5+xUJpL3ftn78r94lqJ+ZPjB?=
 =?iso-8859-1?Q?Dvw3GlRwOXjZIoXyvGo2ZUr79pjDVkSJQ9ZFj/uVXmNDY9V+aE3QMGwRQF?=
 =?iso-8859-1?Q?Oc9uvFN15h8AVABMxTwwL0VfXDF8aywHm6ixVwOnCCzEQAAXtGnOrwMswG?=
 =?iso-8859-1?Q?SQKG3PM1wa2Q9QcXGsBwRWZevCNnrF40x0WKtYUHF4LMDmGcQfEX+ksisa?=
 =?iso-8859-1?Q?NgurSNL13ptbXWrmZICc5i5lenXmMACOkYh+qgL166Fwaw93+J5kjaFMV4?=
 =?iso-8859-1?Q?BHpzc6mHNmRhZ6EnEt/7u/CjEbRjXz5WFmlLPcH0sLYA44xWzFiF7EhoyX?=
 =?iso-8859-1?Q?kJGyHc2jhAxPQx0VBvKIB4VHXBESEb0Mj6/sUoQY8IifHk3k4/5Mj0Y9QF?=
 =?iso-8859-1?Q?ZdkNoEYaIK4vjtStol820raN60whT/4AQAP4LX/voGzH8CP+ZkgXoJrhRp?=
 =?iso-8859-1?Q?+1SkUPKYN1bRzpv2/kOBmzSlCXVXe9SYoRFaR7G1CN99xNsa32RBWf73Qs?=
 =?iso-8859-1?Q?k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2+UhrHraTbjDW8fcEpTvd24kyvRKMvf3Fof6Z1VHZqgj1A1WJI/QLil7P+?=
 =?iso-8859-1?Q?hWcXX7Rr1YOokKcSCpq8eaXfJhtycjRrxHKb236dWGHq1JD4BdNRxirgh0?=
 =?iso-8859-1?Q?Nvk/gFitSVqpCcQXUWmlg3cKIp+oJtmMMptl1ExhNLo5fwoO53/OeUNdB3?=
 =?iso-8859-1?Q?bx2RM5JLM29xe5IUDQQvIuDxAx0equm6GoRoBSW3pvybmz2t3w3+VKz04K?=
 =?iso-8859-1?Q?0CTtS/hNMfegKce1jhDS7tGg5XJaN906Tw/zSARGECTKU/Qd/vZTucEHdU?=
 =?iso-8859-1?Q?3aZMq3N0MOo63ASX9Jqwml/PVXQA7uzfP7YHM/cZUbOSYEtrhqfoowcUHB?=
 =?iso-8859-1?Q?uevE0fvF4iu0thmuYGLHkVJp9z3Q5CxUmUSd36yeyXsPb8Hr/FwalL7Q7Y?=
 =?iso-8859-1?Q?8otP4TJwsEFMUfKU9kAkSP6ykIBz4gYBu7u7Qh5ItKtuXNgAFlynHz0iTo?=
 =?iso-8859-1?Q?IvJgM/G9cHIPCddiI7Mbrw7wCe5Jq181UVvVo63GtnLdnyTSJQAWP+z+NE?=
 =?iso-8859-1?Q?XUilUmHVvTJxepU9E7IiR0t/V5zh/gWpZGioO5KzXsERp/zB84KDz4botq?=
 =?iso-8859-1?Q?OFaAFunUpwGRp8jPM8UZ77Pc0N4qpmY/cnXMoO5ebpkZwZTaHwanJ8mmxc?=
 =?iso-8859-1?Q?WVjm23xJV/o3JBy6XuUImA02K8houxVKFvqFo2ILZjUJPkvc6ZOE9mPqqE?=
 =?iso-8859-1?Q?yiNxcuSiyxVslERomdbQi+4Yd4BeH0Wxex5LOPFR4MpHuhFWfWeqS+sSln?=
 =?iso-8859-1?Q?H48vEtx/mDwHdbEwbNuJJsxGDqAHxM1E4XpKKhXNP0dsPbX1mL3vo98wnH?=
 =?iso-8859-1?Q?8xd5k+sJYIFwtenQHKnzfJzS61zSPq4EN4v2WS5kywHsLNPS2GGbxTiUzP?=
 =?iso-8859-1?Q?FkuB8JAjtl48MIdfmgGqv0OAwE5PtC4LAhKasrIbqe3Pxn7CJqZNBOqNnM?=
 =?iso-8859-1?Q?xLRWOkA+/f8e1hgpa2ls6lnx7GkwMKdPQTZm9mdajAAGCTy82A2qqtCXNB?=
 =?iso-8859-1?Q?3ZRmleXhDN8xdI5qklwahqvhD2HYRP/p+fz/TfYwuQJDLq7N5X3uzUB1rg?=
 =?iso-8859-1?Q?s/sVXKu2qELHkMvjqXQBs2GanWTn5x19eIq8YJ7kNZ6QEX3VMjqkLdFpp+?=
 =?iso-8859-1?Q?GFHQ0a9s4qGqBwIQw2rjxSCXHle3RmnoSJ/M/ONnD92Uv+pPUdNzW2o/kA?=
 =?iso-8859-1?Q?OP7koyMelse93zZYvMyIfC/1tPgBrxolLo8wiNlOxpVnjsMdOphzwPb1ua?=
 =?iso-8859-1?Q?Ub/yB8QV+7LInI7VLMQZ/kB71NQ+2q+HdoU5hPs6jG+El3DqayXsOlPOrH?=
 =?iso-8859-1?Q?QvnZh8WCVk2lZ8arxiCAoQUYC3zoxkIbGEOfZKHTxwk29ekt9nz5KdXTuH?=
 =?iso-8859-1?Q?B/ZnXo6eS5m/QNKeslHelA+jbd661Nburw+5SK6p5118UsGQlTepKaPfl/?=
 =?iso-8859-1?Q?gFisjAEiLmnrGKFXNpgFcMDGHSYQFOOGw7NatiJ10oq3qOG8U/kH8Cq0Gi?=
 =?iso-8859-1?Q?zigt7u209cBwI1io/dhdVbs+63W2yQANwrtoIbMaUxqH9SmIDvl/4D+lf7?=
 =?iso-8859-1?Q?vMVz2rdSFTMf9r7YdNfBHz0Kp63vSfMqd+jAUaMgXS+RjkIDv707QAPXnA?=
 =?iso-8859-1?Q?c1hORVZ8g9x6KED2+GEtFzPYkajI621/uJVMQEiD23XiK79RiQ5Re3lCp7?=
 =?iso-8859-1?Q?rCiyFqjp0N5OPwPYWIA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880df965-4f80-4906-bf26-08dda1d7261c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 13:12:37.0363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5axvHyla9EJxuHrvqbQS2mOUK0d7+no4vPNasV5ppSWcfuOnXb4xhafdmXGmDRlXP7uN6GHDUqejd7YyvhIbHE5GBSyV/tfm8D2nG8M+c14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4545
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  3 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 +++++++
 5 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 58bfe50e4a..bc922a7c4a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -244,6 +244,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaC=
ondOps),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
=20
     { },
 };
@@ -1364,6 +1365,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3184,6 +3186,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 9734963035..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -22,7 +22,6 @@
 #define RISCV_CPU_CFG_H
=20
 struct RISCVCPUConfig {
-
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
@@ -39,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 9ee0a099bb..b5195959b2 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index fb80e58b87..66e13a0b85 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -28,6 +28,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
     REQUIRE_XMIPSCMOV(ctx);
@@ -44,6 +50,84 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
     REQUIRE_XMIPSCBOP(ctx);
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 697bf26c26..99c98d4084 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1


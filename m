Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9343CCCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v909z-0007x5-Il; Wed, 15 Oct 2025 07:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909w-0007vn-W0; Wed, 15 Oct 2025 07:59:14 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909l-0007nK-JC; Wed, 15 Oct 2025 07:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzApZc1Ru5dvDFC8leyXH5pmOufPnYoA5dgjrieTKX9XoIj1pGDJGe7zuV0u4WAjrpp/b4qZtDKvHODmsy8AtEqHMR62rtoOLFYbo9GjF3q6ati/5S4OFw0/b40EublE/bPEIJN5h1O5HRrPU9IwnuO1N+H+5TOePO+T5NIHL1C3EnhoFZv4qOAhroOhG44lP3Vy5vBjIreSravwcGr37tfUIg70/iBeCZEzMRHfozGEiKRN8H68/SggY4mGIGeOVaVQvf8bjg3j05jTBB1OOX0s962yAt5fCVNOvI3BBvBxxED2siW4rArmVfjA41GzdYqnwql3VMAwlMT2AFvAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD7NsZztFtW3xVK32pM36ulHIFJFWt4Xdv66bn0owNU=;
 b=ZCZtlnhinxihANz9Hbei6tNLgHNU3Vt0ZG3SznQHsfJM8miBFCReW/OMIWU5z00VrmEilVIWc+9Ykj1pcG+N0h9mmWXFk5AVjOh8CAyXNSGKA2GZs0XiARO7+5X2+bvPTNt/IMbl2r9bnuJnVVHZe+1VwoY6MXtTWzr4E+lXFusx2a06RddkpxYV/YTf7fD0KUvjOKviLNW9wWu2AhpPyZuWmY+nGGoqyjywznGwNG9C9oUw8Czjdy0nxlRIcROTzCwfSWtXfYKpcY+ena0uTgY1e0eG1pbznvLptnYUyHApJLw3QHuHzF3SnoR91qJfT2IBbzwMTdQ15WOH1SDDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD7NsZztFtW3xVK32pM36ulHIFJFWt4Xdv66bn0owNU=;
 b=cGHWsYG6rjzhEb9svDONFzZZm0XBFD6qIZGtQ8UGdnlPw0vSQnEw/oYDSvyXQOE3hL0AeUDsduArWYJak67ir8XVeJwfGeq5ocJyND+FAXvQuqZdU2Mn0x9AMr3WI9s1CgsQoOP2uzfls/abMG06L+wSHuLJLq28b3uVKKVsAsB5s24isL1uW/Y/+CPp00TS41cvJqOXZ43iaJk1TxzREnequsTiGtZ079hLreH8eVmcLagKU0VaFQjfhvjl95GIqlG3uXSAThoxMA80xwt+3SS6TmxeKFKTpdNI4rh3E6OM+ez400u6/KweMcH7S5dxkKnM4BnI3MjW4BIDkYY1aw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:19 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:19 +0000
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
Subject: [PATCH v11 07/13] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v11 07/13] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHcPcr+ilHqQngCUkamrlFjucBr6g==
Date: Wed, 15 Oct 2025 11:58:17 +0000
Message-ID: <20251015115743.487361-8-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 345e58b3-8774-4159-4a3e-08de0be22202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eoFv/AqCSggNLhKLeKPjsjtsLAWSqIuXWPwxtSUoDTVzvxgnnQwTbXRcbE?=
 =?iso-8859-1?Q?xrrxafevkMHuFPBVTlOkkpIAepZWh0ZvHrh3R4H8cvEIyAjjG32N1I+/tY?=
 =?iso-8859-1?Q?qbpBPFnqi8D9QY+0OO1RHBuOKjYSceBMGvX2+pjma53nHsm1Ahy7FQ5Gv3?=
 =?iso-8859-1?Q?HLbHkXJTCYewtn57DS8Ys6jzOhupiHrm6BvjByzpu9q/Vt+dTN6SIUucfQ?=
 =?iso-8859-1?Q?GDHxFLupeQo6O5rTtyCM5ZD8i0uUzo83POk8vYc0ruwivGa6JY12OtkCof?=
 =?iso-8859-1?Q?CnnMownF01eupWq/ESk0rC1nDJL9ARqaZn6D1VB+IALpdlM36BrGZZM5m3?=
 =?iso-8859-1?Q?Of46zB4Kew6toKaRvtkXcFiz8CAUs1tdDBZRx5TUuROMJm0VYSHmwhWMJ0?=
 =?iso-8859-1?Q?Zs83s4Acxogp2hcm47eqDaAbj0PJQFbfTnYLf4Lx0wCMgov6sHdsFfephq?=
 =?iso-8859-1?Q?tH04rWisS/mTZcgI++PR0oFrGwpXLQ0TRvvYe0rF1Aj4jE8h9xhcLY7+4T?=
 =?iso-8859-1?Q?mYdNT8T5y8T4xBjfAyMyBkNyMxIRvbrcH+KbWHwVk9MQ4PgoDrT0FGVjQf?=
 =?iso-8859-1?Q?p1YivVZz7k5JJpoRcJd9SpVLm0Ja5L2PwXeCylubdBXBJThhWzKC3M6eCq?=
 =?iso-8859-1?Q?mDXU+GsdyJUukVhzQfHtq3Sj4QsRJbTqlcIDB/0k7mSqd9gyfzGThFqDMF?=
 =?iso-8859-1?Q?NVQ7oWWVVBvAWoQM0f0Qte5mFo3XISrwzrBFKokVm+ohylY9GpF9iwuNbV?=
 =?iso-8859-1?Q?eT+HC/F3EZ0FX1XYYEGBBbnSjlY22zgq2CYXsGHitM2bCv+98TJkEfj7kh?=
 =?iso-8859-1?Q?Wr5YN2ZnVCV0LtuhJympX0EsmvmZFZSO/u+dEB/n0BxlXqgkXS1OGVqIr+?=
 =?iso-8859-1?Q?/t2kiwa1P/ezg9Kd0aKFkPW61wSAS0TRogdcyfVaqj3WOj7k9ASpUQm3NT?=
 =?iso-8859-1?Q?+WP2ossZk3Asn9JQdoYKVZ8djnX3xke9iai/18Nx2FF75LcCWy2bRZmKPX?=
 =?iso-8859-1?Q?mKDn0OmeW6AcQIpZp+p68UpcyS5lZk/Kizsln6tMNMFDoA07dQETpywNgi?=
 =?iso-8859-1?Q?aSyAzWKAUMH9XU3eo5UDg8ICxHtlVqakacyKSMbUZjsk1KIH6MrzW0th7W?=
 =?iso-8859-1?Q?t6B1CErJ9QeZRankvkFWEMymhLjAxEVQiUOMZEU7CaVe1sn4T6vciupO5I?=
 =?iso-8859-1?Q?uRHSyyfqe9ycNRITpnf34RXywofZjBB4sgrHIa+D/k0ZJuJM2QZA2PTkI4?=
 =?iso-8859-1?Q?GUViR6CTmNSpE87AnVsaBTK+7BBaB3x3BMXcG5ZDX4pGfcPHVdDNZ1emZ/?=
 =?iso-8859-1?Q?UHtEtLLktqkHd2hdHbyboR+bES1lX0Nxf1iL2z6rdRdCeIzs20WXsPS+Kg?=
 =?iso-8859-1?Q?jYQJzV/kfndnxuNSU8HM8x5ZkHAIgUj+gz9JVEYkFTVH7+MA+xYbcKWdBK?=
 =?iso-8859-1?Q?gYKt+skYMLm06wes9SDJwcuq6r4NxmRLdynq6Wdivq+jOmwrZGb9UG7tey?=
 =?iso-8859-1?Q?ofMhf0joOCIgT3a4s8blOn9MkqXpNegBo18oN6qy8E76wuk2aWjq4diug8?=
 =?iso-8859-1?Q?BgCdEkVKXepOzU8hsnFaO2K9fe7Q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lkErHByzrhfMa/6vH9pExCQ6QUXZDRZN7gwKa4YWTgT2gIkCLjnktwImzT?=
 =?iso-8859-1?Q?TsltAlFd5PfsJksqB0+vbaPkHy1l+LIeBle6gQCjlNxm3sLOOluDmehHVU?=
 =?iso-8859-1?Q?zOSHdbgqLvegU+Wvefqsqd/LfxAsZTt98ofXrP1eGxNWH6cePvfDypt1sa?=
 =?iso-8859-1?Q?kTny1mHw3jUFUlnQilUBjRiS3juJaHGnkEVMkFVVh6QKAFTkz6dtXbzMMP?=
 =?iso-8859-1?Q?NHJzGcNouRuYLqXZN/bFiugQBMK464/e8Zr/0HfeP6hTkjZwRk+p6swYpJ?=
 =?iso-8859-1?Q?rBK9yw6gD49gS+8wGK7OEnVieKiwUQkKyRMNh4WzA/xsyEaxnXiBb9grxi?=
 =?iso-8859-1?Q?LyWB9qGJUfEaJ+/OfaUhG2/MW0aWdb83LGP18vH2sCBtaFLOT3hxSn/OCZ?=
 =?iso-8859-1?Q?RdvyzYAXrdQwvFvkB8w8Uw9vk0bVcYyGx6uJezZwN/F/2Szf4qjcuSVTBz?=
 =?iso-8859-1?Q?9VGojPBYV6m0iH3GrTao0KoO4C+7EfOxDyww3XtrxIzS9eTMwVlv386oVU?=
 =?iso-8859-1?Q?fp6HFZuDSxs2r5X8aovxoMD+7VM0euj3OVJMAAqIdXos5+zmWrumtd7/h7?=
 =?iso-8859-1?Q?5kVFimP9+h4AvFeDXvA179wcaRFkb+ErcSpSYPF+FAhwRSZNg+vxe7YA9b?=
 =?iso-8859-1?Q?2XrEdNMRSfSCXYc1KLJHoFsh2h8PwyZvDjy1RWMHZgREN9fnZTYMObDNa6?=
 =?iso-8859-1?Q?gx/5inwFY9QclKqRsc/fL+ItbCAUDFmRipFPmY8kWY05sIkregZLjw9IxX?=
 =?iso-8859-1?Q?zMTW9a7d0ABpX/jp0dWtFpL+u3+UckbI6HPdudhM3LzG2NqGnRgBK+bRSn?=
 =?iso-8859-1?Q?RnDk1DQ2oFi9P7EltIX9CHtdlARrtbzDDG7V79rB1RaYWvhSuMrZ8qsj31?=
 =?iso-8859-1?Q?7aALs0MXrCMF75LCoviyLIU4vbeJ8wgAR/H6v4kv+dnamvhPEqpAL7Aj/n?=
 =?iso-8859-1?Q?ijTsJINK8O33eve8gXTogG/iQd2XjEYVtJS39oOPYcFPHXvyDV4+NZkrM7?=
 =?iso-8859-1?Q?2oQ8vgNKXch51+TaiM30lQg07x6ibxPZ9EwSt64tKUYneDUwTEgHht/aIr?=
 =?iso-8859-1?Q?q48azutPiald1S5LDoOu1Ias7Op8Lc177/42VcZO5xqvj/NCnPjecmuP0o?=
 =?iso-8859-1?Q?jaaFc2XlT3W9TOc5jlbcHL2wKDhppBj9qfPSIBZG2O0UCX6uxOMjcAGgIL?=
 =?iso-8859-1?Q?s9Tin0bkaQ2mOFgsZMi7gAcGpEXoALsah8hiiPzy2rdeAY+rPSJNUKc678?=
 =?iso-8859-1?Q?4QIzWappHT+v4vED3dcrTNkOwSFJFmnP/RrYBTvDWNDzBCPdv1rnCwX13f?=
 =?iso-8859-1?Q?64INoPn+GTLfpbjpZZdQvuDdF/gHIOe05RPFv/mr+ffsyrMO0m3a54QQ2d?=
 =?iso-8859-1?Q?1Yk/ENAkAKBX7pOyw0+n8d0xJiVswD1UHKIhnr/hkM3kYtWbqBb4SGeS02?=
 =?iso-8859-1?Q?Di1ti+MpV7Je8bfq4KCuSYqB4+XsHtDoh0drdu3f7ToYzPJpL9Es+8mT3D?=
 =?iso-8859-1?Q?XiCChLS7MvRi43nr8tM97ffAb2evk7Wm0LoXskfKXNlIHTjtMkI0UyYqs9?=
 =?iso-8859-1?Q?VOb6l25Nrw1Y3rB6UEaZ/IYvbndBaAYmOKvVX5A6POKLikp9fNV4CAPi9/?=
 =?iso-8859-1?Q?AD2dRqkNHzmt+nUp5s20GkWvoxnHOQXc8bnnlQ3Jw5wR6VeijysgUPGKi8?=
 =?iso-8859-1?Q?5139HlCRnZ7+04v3KYs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345e58b3-8774-4159-4a3e-08de0be22202
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:17.3456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9vhwo0rKwcB871nsvPW+ekPcEaiAMXghZ7qBSLMrXoF4FmErNzgULqeoVw/AFAPKk+yJs6PV/tKegJsjzgpQZxKbXR/hYpb9XVpvwrHhzxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 88 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 ++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9fda450683..c09ce9fc62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -251,6 +251,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1385,6 +1386,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3299,6 +3301,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e4d5039c49..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
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
index dd3ee7ba2b..7c624ab677 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -149,6 +149,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index bfe9046153..9a72f3392f 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 /* Conditional move by MIPS. */
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
@@ -38,6 +44,88 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+/* Load Doubleword Pair. */
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
+/* Load Word Pair. */
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
+/* Store Doubleword Pair. */
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
+/* Store Word Pair. */
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
 /* Move data from memory into cache. */
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 4215813b32..3174f17aa4 100644
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


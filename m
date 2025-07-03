Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F2FC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHVh-0002o8-ML; Thu, 03 Jul 2025 06:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVf-0002nO-Ov; Thu, 03 Jul 2025 06:49:43 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVc-00076R-8t; Thu, 03 Jul 2025 06:49:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noLy7ylR3aKJbQ78SeEDdWIf0CSPGXOGFwvYz+nTw156yyHJ2x7jFtQyMyYSG0ZSjqPkP+BtgFFoQJiDqUCMMqHMExI0rgPUHmV+XDvRseiduyrtrmA5BE9TFrsZaZDj3oObb7BIGDZcTjHUdi29CixbVDH8XDbFS66s3gDLb8+VnRQcHFEst8IVnlrISRK6K2WoA/YcEJeqTPqJK9NxIEAFskV0cTgGoKEy5R7+Y0uR7/Ea8jIYOrrsUD+urMf2H2NY5BQtQwOnGK9FQWvCTh0iIEAmtEpcWbk1ejOoQvN5sIDc5j15QMl3ZkrtSNNSuksHRvq6Lq/WP3l3MIzZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3RQtUjromSdgEQTrVZzrZC0nJVjRXGYhd/lfubGqOQ=;
 b=BnyziGIpGhChwIIZy/Ow7cxo4CqB3b8LEu3uNH4/ojI2M5u2Vg3oKXKr6WZ4CAP139XPW3E2x6zV4znBwQeVBYgskv1P8Bv+XuRV1nFWN5cjofj3UkUIYs2gt9E2Qw0C8f5fQEnOoE4wmUtAzr4ZUGCs+C+JFM8r8/ko5NnxUweeqySLRPDZSDB4Id+7SKJLiAatw3DGzZdlN2WnVrQ6wp61I/bCrDoBqQxtHO/FmZUxExUOoWaCiq7OqcXRCQICm66xKL+BLWNpA7XbmnxY2cT6fRokl+Dh/Ef5xep/hekQeeL0LRWkzr/OQTgxJ6huHStKGps+tw2yPt7JRHbORg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3RQtUjromSdgEQTrVZzrZC0nJVjRXGYhd/lfubGqOQ=;
 b=nhkQNtG8LYG7xbJRdSZGdAG9XrKnwTD5rYJHGnAy+5JZRwUgbddEBVUSpwGz5jgbYS5NtyvvAsMI6m+QRKeJdm6w01Vxf39ZW/p6EeNlTALy4bYeXV6owM9JJgm4p4+IQxwpqSyYoU5W4YiS7yysXnZMMuhEvCrMPg3wNJv9RvtZKBnLzKX2xRj+IMcCUOLVACvp0pnvprYTc1c6GHTpH6Rf4gboyxyPUiUrrOryMZ3kEXLPHUO8Rb3D+k0dETD4L8hsvdzerfNmvxF01OsaKGbkbRA5fzJ6rOwyzNK88Ogdde4bTPE8LHO0LDXmiU9OXseX80znPE3j7Ua4ABezag==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI2PR09MB7288.eurprd09.prod.outlook.com (2603:10a6:800:223::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 10:49:31 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 3 Jul 2025
 10:49:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 00/11] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v5 00/11] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHb7AgnwFDHvKXCC02l8kEZ/7XMVQ==
Date: Thu, 3 Jul 2025 10:49:31 +0000
Message-ID: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI2PR09MB7288:EE_
x-ms-office365-filtering-correlation-id: 4b7116e9-4da6-4549-1dbc-08ddba1f4a5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3w0taqHf3C4MGEz47xOByPwvlvmRh/Wd3ofh9hN3soymuR49De7X3PGMcI?=
 =?iso-8859-1?Q?eyHot4ZcYRDq4sy4kyfiGreHiLxU0mqhE6QgbZQ3BFPKVs0Wu6MYTUBxMp?=
 =?iso-8859-1?Q?HhgdDXJsNfFgriAN8hndBT9U2xypK9gVQqI0cLzpvgHpk9HHJSdav9c/bS?=
 =?iso-8859-1?Q?hGCQl3iC2YwlggYusitAnHJrgWn7sY0useRt3fm/b/mnAnCkoWfm6ookrn?=
 =?iso-8859-1?Q?McsG6oWtcoDwz4J9W0JIISpFjFAeXwhLxn0H6daaSopyfZu3nm9wym5mV7?=
 =?iso-8859-1?Q?i9Ftw5KCMBSPQ9kHiU6tUwjre+el9UgsL9lK8FRyJV2c5wHnNSFjA1PFLN?=
 =?iso-8859-1?Q?W3pakgRdHYUFOScUu2AerRNHEmqU9qd/H7rT6lLSQomfzd3B/QlOu2KRIo?=
 =?iso-8859-1?Q?Pim9BVNF/XAjVhPdjFhyljrzSV4Xq7rzDHaOjgI9sVZoYWa5vhiGldm2L1?=
 =?iso-8859-1?Q?aKM0IoPaKnMIlCiYFDBdFmk25rXW73wkpPZbEtemAAi6EZLX3u2mpEX/9a?=
 =?iso-8859-1?Q?nViVD1qzPvgxYoMDm1qtfjJBVJJrdS6eQlWK++CTCpiLdvVWPmKyHR6E2J?=
 =?iso-8859-1?Q?zFQzLVphsFOiND9zbr9X9nrJHkDeAZCh0fAXmuD0j8F4ZF+gVIIe8EtB5i?=
 =?iso-8859-1?Q?Z+6kCbCNN2BbGo5lkhuR6CTkTGjaZ9FqxGxYk5v9kYQQoSkdBwmVsp2ZxS?=
 =?iso-8859-1?Q?GOJt/8mxn87siAsaJEFHvCAbfLO7Svd5CvqtP0zM1K22XOcFwIHbYWL+IC?=
 =?iso-8859-1?Q?qwWoDI4O0e0A9K9h1EqDZwRqGAVFGpgccSYBS4xhMqKoux+cyLFxgGM/jo?=
 =?iso-8859-1?Q?7kZVQ7EalqwkqYbWk/Xk3LjSHQg0vgdVE78xqlULwxnvIx9UeqCFLNPril?=
 =?iso-8859-1?Q?b9H3dD/rUKt/NYcAOAJPCZHTzx1/qkHwG9T2A2NkLuD9cUxzzdW4i7vGFn?=
 =?iso-8859-1?Q?5/c+1R6JV/DTKjH7f+HrcBzwK0vMxsQ5qmw4wqQhsqEKK6/9PQMoJRc241?=
 =?iso-8859-1?Q?BzT1EGXhaEfiJIbHmkgcqC89D+bkBS8nPBJKngGciLH+rMpeUlltqVbCfw?=
 =?iso-8859-1?Q?zE4c4zVl4YaeDhizEcOUEPctTjZS03AC3bNi6Qsd5MqPcr/k3QWbnL9LUm?=
 =?iso-8859-1?Q?bhR6U6rdDCFP8zWi5VkyqJLddj0aBaBCZnd60mRSsTc4ckRwZhKite+19l?=
 =?iso-8859-1?Q?wEWEfAn2JIxwRO4tNbWBaSQVPplHE+Kmc6QlLvGbH+/Ib+Y6ZYYUf9J1ti?=
 =?iso-8859-1?Q?k+DPVnw+si/rBFu9I4YTsUUXCv+ET8j4gwQyny6crzj/RXCLD37uFMhXRM?=
 =?iso-8859-1?Q?HY5XgELySb+a1w4e2tAHWMD5aBvtPubrszStIRwjVh53zqjIsvpzlcIbmr?=
 =?iso-8859-1?Q?bQ0omcJryiIxZ/4H7+np4ttMy/7lDzNGPtZaTBVJvve9OQQolAOceDeGXT?=
 =?iso-8859-1?Q?rhH4vyyND/1HZMLf25tgn0VDwE0hUNM1jXDXZN9XfePsxB9lsKWnvdcS64?=
 =?iso-8859-1?Q?EdsD4xxp2Wfln0ikclIIfYtQNWfzqS2lCyAZpApP5pyA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cYYDGeb07jMsGpoeDdoFp/f5Qr5a9OP3dtCkXN5oX9XsSKAGXClsV2Jcr2?=
 =?iso-8859-1?Q?flnqppH8hy6rVb0Kj/2jzeUU53cXoI8d3GZORaywdNJoVCHO1Oh2duSF5o?=
 =?iso-8859-1?Q?53CJ4p+FYkjemYUdqkoZlOWdeIMR0K9UoHDHJY13sm/t+fEw1182+hI1DB?=
 =?iso-8859-1?Q?JghPk7Hgh/kGMCP9pZ9y4/rAxZNKWvz4ya39edkp2tmdkRITbkBEXolA8T?=
 =?iso-8859-1?Q?uHuIBeNbtGGe84LNVLLxT8Sy1O6zTYmWeaqnDMpu8aBUiuxQVOKOqL3NnX?=
 =?iso-8859-1?Q?4N2fbjOMvXS5M86bch7WqQ6jtRDuhXBHGYQJOENNJpWj29eIZ3NxLK0eIT?=
 =?iso-8859-1?Q?zjGHUSWIBePNvlrF1a6nyFazXgbgpVlc40YcsJd6UcI4mt5IA0AhiBJDfS?=
 =?iso-8859-1?Q?PupomfHvPPtHilawFvioqAeMUtZ9PP+SqmDQP1HC5uaExJUFmYTEuPoDV5?=
 =?iso-8859-1?Q?dgaxIhxuV7782YB4THENWAoP9b8+JZDEAhHqD+Epg54+sS7FAg5hGgtz5C?=
 =?iso-8859-1?Q?SBBdFuw7v6NQ1L9oieP7Mc67YdgUM1yziwRj++EWC8l9RfaMdHLVVwesOr?=
 =?iso-8859-1?Q?4JBLlVmy6g53Ps6nnkuxsU/b22Wkase+DDZFfEikx2fjYBTbi0/oA92i/h?=
 =?iso-8859-1?Q?5NWf7f5WVQnGbcwGr/bQQ6/XtuyjUeY8eOlc+iwirUHRiaPjXJOOR3F12X?=
 =?iso-8859-1?Q?3f44Nvn7H/r4kY5YEhEHYKiI8m+Ijhx2PTLjxr6GX/tl0CgqHR2KHxI4ph?=
 =?iso-8859-1?Q?LHXaYHgeBCwDKJ86khjyroj7SPCNuOzRYQGUEOZ66wTh34I2hetRO0Ejmz?=
 =?iso-8859-1?Q?1dwHukd6JfMvcCEfg/h+N6+qI2QdeSb0gMM1MZr7Jv9V0N/hsACDddNSAl?=
 =?iso-8859-1?Q?mZ45oSciAE8YfvEvNGMnCEM7ESNwTYsi1PKWYeiyScMpyoW08g3UppJvUP?=
 =?iso-8859-1?Q?F2r2c5X1bLrlWikDuvZz42aONVSJ+feybR4huwLtM++p0VHXokZEOK1V6w?=
 =?iso-8859-1?Q?kkYFe0RH9faVCEgG4kP6ZIyEKJLFEFPe+0X95fAJu9OGJA21hVVIj+bqco?=
 =?iso-8859-1?Q?m2J4fDqcXI0Qt5r/puqmQHpdtWxjxuhQgC+BjC/p+kEgbZ1THq+XsObOgB?=
 =?iso-8859-1?Q?1aLLp0bq641K6lLbMwGbOLQCvh66YsoZER7OTy69Uj5p0W4dgqczMNYIp3?=
 =?iso-8859-1?Q?fLECQNBbk71gtPtdDlTbueI87FG9ObKBg9MVBF0f2dytILpPXNA0JXjJwL?=
 =?iso-8859-1?Q?c3edVJYUPmQZsR0xZl0gaAIkZ0cpyxVGuiRAJTtfJy7ImOapXecyB2vNXb?=
 =?iso-8859-1?Q?BxjIFCrNBLstKtvzKWVcGiGyLc8UIowHw9zfRE1S2/RV93vyjq+j7zEQmP?=
 =?iso-8859-1?Q?fDVoT61s3tY9EeSM26CSMDIdl8RVnwWX5FmZ6C9NFhBqYAMEVzEomHafxk?=
 =?iso-8859-1?Q?pvk92mhH6NbK9cZybGetZvhAvogqyKujgYVAZ+9ZI63ndiREgtDfUZEiLa?=
 =?iso-8859-1?Q?Djby6hGTSwSt9BpusEYrCAyw9IAk/vv9TMbUIHvWx3wavSGAhy+pc/GJce?=
 =?iso-8859-1?Q?yNAGDrbi3U3GvlaQ3BmHU3Qa9BL3yuvlsd+Q8dOwPhAQDdKPrdUxwwacT7?=
 =?iso-8859-1?Q?dJU1wnzFBeFScxb94ugTxpLlX7uo3C38RyPzrm4v0aGTtj4H5OpLso6FZ3?=
 =?iso-8859-1?Q?R/D5CZwZEFkplmZKVAM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7116e9-4da6-4549-1dbc-08ddba1f4a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:31.0586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3v2jD14uixaLAAT8aSrFODbN1wbmCKDCaxC2z2kAqhtlW+5tET4CeTKUki89ioIVZiPjGt4+mZjCGe3mT7yEPXuMCCDuVoxFRVjCtqyFRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7288
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

In v5 of this patch set I addressed two comments:
  - 02/11: Moved cpu_set_exception_base from target/riscv/translate.c
  to target/riscv/cpu.c, and added some NULL pointer checking so the
  code follows the convention
  - 08/11: Improved git commit message by explaining cmgcr and cpc,
  and introduced a macro for 0x100 offset used in those features

The reset of the patches are the same.

Djordje Todorovic (11):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  hw/misc: Add RISC-V CMGCR and CPC device implementations
  hw/riscv: Add support for MIPS Boston-aia board model
  hw/pci: Allow explicit function numbers in pci
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/mips.rst                  |  25 +
 docs/system/target-riscv.rst                |   1 +
 hw/intc/riscv_aclint.c                      |  21 +-
 hw/intc/riscv_aplic.c                       |  10 +-
 hw/misc/Kconfig                             |   5 +
 hw/misc/meson.build                         |   1 +
 hw/misc/riscv_cmgcr.c                       | 205 ++++++++
 hw/misc/riscv_cpc.c                         | 225 +++++++++
 hw/pci/pci.c                                |  15 +-
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 489 ++++++++++++++++++++
 hw/riscv/cps.c                              | 187 ++++++++
 hw/riscv/meson.build                        |   1 +
 include/hw/misc/riscv_cmgcr.h               |  78 ++++
 include/hw/misc/riscv_cpc.h                 |  70 +++
 include/hw/riscv/cps.h                      |  75 +++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  40 ++
 target/riscv/cpu.h                          |   7 +
 target/riscv/cpu_cfg.h                      |   5 +
 target/riscv/cpu_cfg_fields.h.inc           |   3 +
 target/riscv/cpu_vendorid.h                 |   1 +
 target/riscv/insn_trans/trans_xmips.c.inc   | 140 ++++++
 target/riscv/meson.build                    |   2 +
 target/riscv/mips_csr.c                     | 226 +++++++++
 target/riscv/translate.c                    |   3 +
 target/riscv/xmips.decode                   |  35 ++
 28 files changed, 1867 insertions(+), 11 deletions(-)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/xmips.decode

--=20
2.34.1


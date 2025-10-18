Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855BCCCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97f-00052d-VY; Sat, 18 Oct 2025 11:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97d-00051x-Uj; Sat, 18 Oct 2025 11:45:34 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97b-0001QR-NV; Sat, 18 Oct 2025 11:45:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KajMI8R0zYFN0/KY6fBsb7kLRsfN+nsXnBF/JcCYX5WrEhYsg9IREKatirmXY96DcgRDSaelm+b/aDnomdlGaPDNMGLlJ/6+EHiVrTg9T2K1+W+tIXA6VeTJKyNrXyhwHZ5ybqLGYT/q3MJFqM8nABbhJhiAcA/jntKGozPAiosNk5tcVqs99Z27isZsCSmzpLb07nc6osRDzjCGAjR6NUpTXYgQEMvgPD9PaGou+0y2iomHbJAJpOdUYxTTzmPo3eZmLJ7TmCkXvQgyHM6EintA/yTe/z87ALMkqVA588uOwN2+ULB39ySkH9PjhB3lTdk9QiK7wR4VcvVHMDWxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSVadkM61CmC+otbofluW7+mS5tm/XAep2kROgwz7wM=;
 b=OcRpMEavveTPw6DZDk+9CebJZtbciYbHeSO640lMyuO5eSGZCOmjic++80kJlWIQ2v5XWg4aWdptZx8jzNVNd7nzbw2wjjexuUEkyBWPznDTCtCWapLzLIwo9HEeu1+gzhUjUUBQudIF2bTnFFamiebi1yQseCc1g2INw3goTqk2S/ZMLTIhE9HC0BsuOUWBz+rZwJ+Sak0L41NkUl3YjR20/H4OCLZ0O1f3tlot477O14mB92/7hfnG7LvfslPIaVWI/cYsvur7QbkaiY5MMBgx8fmNAYK81vnYg3jaMNVHTmajkG2eDxI5qCt6c9LLnDx71RdVkDeg0xtMCWYivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSVadkM61CmC+otbofluW7+mS5tm/XAep2kROgwz7wM=;
 b=VlfR1J6Tp3dnABkxI8h2kKvmoI8dXSoXOH5G4ReAheDXnYQa7HQaGhI+3ee7V9jwN8BUpUBd6imHpVBn5gKtFISYUSQkRJwFhuCRtIJzaPbcQnKPSsUMZsfAghRHU81lu2cAiJdeX36SKWjNw/NE84DW0CMYWw2VEyk0oyVRWvZuaTAbyBg9yaVQKqpw6QYxspqpA51zMAgldLrDqbSBhfuIbtAuaWjDFiAymbxURwa5fPfQeA0npjt5+8/62B55qUMz0lP76N9VcYh8dQ+Mt9VnjTyT7MVv6ygwV1mEh2h4SL5k5MWE4BmSkIxU5UdX9dA6ZJjOql0zfD88IvvE2Q==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:28 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:27 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v13 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v13 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcQEY5Tyk1dZyqaEqBYb77pPImNA==
Date: Sat, 18 Oct 2025 15:45:27 +0000
Message-ID: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4360:EE_
x-ms-office365-filtering-correlation-id: c93d4187-5d7b-4097-b644-08de0e5d5c69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZaMZqiPqsBBvtKLKvLKaJ8eJ2rTlJxSbmn12NOuaaFtIfR/uh0ekMSAbFL?=
 =?iso-8859-1?Q?PYpe3RR/IYNQb+IHZFUF4t7Sy+VZn4zcd/jiUdEFgNCXTMzguP7IjWXq6I?=
 =?iso-8859-1?Q?240xStY92ttwayuVz+Cs/Lai7ssKsB1Qmwz3rJoJNOeh1OtQWIdWinMYxh?=
 =?iso-8859-1?Q?oKXsDyQVtAc6XqlJttmUdjJG4jVNJq5ZFlgumc1bnHVvjgKLa3FauLLVt9?=
 =?iso-8859-1?Q?OCdj0Q3BGByCtLrONaJ2pNdcpGml5FWsPo1vU2Pau7S+fhrbeK2T0Z5YWo?=
 =?iso-8859-1?Q?agh55OqiNRaCuZMsm/z95bO4xiLoJabFJp3uxcj2mtxkZRU3CNGVl4eh2D?=
 =?iso-8859-1?Q?qZ8iKkfPRwXcw6gTnjcPyS8ATAIJ4ipWiiqokK7qT1484PS8rmbjs0GXvY?=
 =?iso-8859-1?Q?aEQXHHzrOMWhEGNpdplEloRCXy9T2wwQK9N6+e41Of6nfHoYuBeeO53hN1?=
 =?iso-8859-1?Q?gTkHuLOiKxxIRRNPmhi5XlL/QwsGpxHCgzM2jcOkor9n68rhqz4WpUqLQv?=
 =?iso-8859-1?Q?S9twjzOOgBeD6MBGR8P62TNghHB1M6hrZ+f9jKVztWWLuiaVrOeXqk60rT?=
 =?iso-8859-1?Q?+0gRsIOzd4GNxp29vSvviNoeIVEK4rOhfDG5kHh4G/BO3nbS9evamILyMi?=
 =?iso-8859-1?Q?8H9DqDqdtXLJ0Ir/d3vg8Xtzm83aegz5qo9E8XmdpjQjJ+h6FznZL1T1uv?=
 =?iso-8859-1?Q?w2ixDAuhfFcYDw0jWufxEQmVvgVKdul4/GL3gEQEm+woxb323+w68naFtO?=
 =?iso-8859-1?Q?EE6z7f3i69p0/M6qJh5tFOWb9vuisU7WVxpF6qCZAADD1kU14xraEFXpuL?=
 =?iso-8859-1?Q?X+kFFsL7KDwM+5w9XJQVecMLBBKLt+dWp6kIOIc/Pb1p5svJrcXOIu9BPB?=
 =?iso-8859-1?Q?SqnPXjnLx5VAxOqGiPSoNu/RFZql1wwQqvJuLkBDO+etpGVVUbw0ecMDYW?=
 =?iso-8859-1?Q?vkhoJEk+W8zG9DHlX9aSXxnSVIwGVwMMoQyFUymoRtaA4kxM+60/ePdBHm?=
 =?iso-8859-1?Q?Ng+dG1EkJOpTn5e4js8oGEyXEnrNuQxrJOPNqiXZmml8mEeMvDSG6It0Mt?=
 =?iso-8859-1?Q?eZ579HGZI+eiJ0aawBtq3yI2bsyRUg4G9DciXx9gT/+PV6wg3dWEIARc1e?=
 =?iso-8859-1?Q?LSHD/rMDQI7WqVyqhawEbziwMw8LqU758BhKV+RQZC2tqrOhowIP3trUSr?=
 =?iso-8859-1?Q?fmc6xjZiq6aS4ek1G6HjgYh3stLHKV0A8YlcvSuQ+gPKrGs9oqzPQBDrSx?=
 =?iso-8859-1?Q?PcKYWO+5UpSv+3nZSEJ3s3xLg+G8Edkx4cuiz+TMtFwouLqTnAnLO6hE9C?=
 =?iso-8859-1?Q?89rW0q9IbpYxgJCY7HuzuYD1gNl9vY3SMVj1xRM4/XNvNWcwQsN0Xy1A4y?=
 =?iso-8859-1?Q?eUgC729y01gCWGwyC3uSzt3Q7khxdNM7+tsp6lmyIaeTxYs5atlwzvAO+A?=
 =?iso-8859-1?Q?QVWWHbzJyZwmKU91gXDiUnMMh+SES8vbP0xowG8DcdXPvo6emUwZBCgR5L?=
 =?iso-8859-1?Q?Ynwkzk3g2uu9ROki/Y21UkoL0Sp00HsXt5dufc1ZpP89Kv74X/uwB+X/Hl?=
 =?iso-8859-1?Q?fpY6Hre6zPc2Ry0zVz/WR6YqcucT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4BE5nctu//3Z48fQnauz1RVnGsH2w7dQ2OcqoOliQrVE6Vc73J3n2/7N7m?=
 =?iso-8859-1?Q?OvkG8DfI1QFKQPcFaNd+mNWGOnqeROmvlxTLgCK60vXoWrVcPSNOFJRFCp?=
 =?iso-8859-1?Q?rOipMj1HZY2JbenwXGsFWYkoFMSU3SYag3Z9eNVgKJsV+ihGB5acGkEKfg?=
 =?iso-8859-1?Q?RVQoKwluE4xzvIbDawDarumv6Qyj/vqp+uLOvrudkDxUKYBUrGsyTw29Qb?=
 =?iso-8859-1?Q?orLUPvyoJnV6slPRVv4lVt7kf+yw+9P5gHdpg2/uhqgtoo3vPQEmjq1Udj?=
 =?iso-8859-1?Q?jxoaVRe7ytTT45g4HeoXwy6VFIIVPQT4MIGJyNsQJgdDBHjiQmGlo/DWzH?=
 =?iso-8859-1?Q?Jn4mN/L8+Ne0hnNcXRzvm+Tv/dsTxangIKlas7bB6DvhZVRI8UTcO0vs+K?=
 =?iso-8859-1?Q?pOGCLbEM/8mR+tfbm7a74Njvz9cm7K/FM54pAM2QG+sE16xfeU10IYnCHb?=
 =?iso-8859-1?Q?5a+nhih3IeXaBqIOARBiStYDDgVh7DP8ezJB4zpYMkj+7uIguj8W0DdpSc?=
 =?iso-8859-1?Q?Lo2RuLvoyibVIUCv3HEEsxXgwSP4JcXBtYx6/mWC13cLGGKEjy0FU7/XxO?=
 =?iso-8859-1?Q?lps1FuTKCCM8Pb4p2FTw6Ed2WG/kjWV1OQ8YtGw1Vc6FrwNp4grHO81NGq?=
 =?iso-8859-1?Q?s+V/18uAQgCgcraxQmKzf30Em1yLCfggh3JCnQvRaPOgc4sKO1aMSFtLUn?=
 =?iso-8859-1?Q?Iws9tubyHFM4t/kCABT1mdGvBlbY1xjPXqpZF9M72iHLksYlSb3SI6AOD+?=
 =?iso-8859-1?Q?HDBLU/lF5jsk/7d3vFREsQSU16qz2aXRHtwhQHyV05YWhYF5aPJ6dd7f2G?=
 =?iso-8859-1?Q?DeQmzdbyCM0i+yOHW4db83Uibh3MrqKkJZDXG3MYq1TOYJ4hi1lStTh6/3?=
 =?iso-8859-1?Q?NbgzUYUSeYRi0moSnuxMcLCKYxnGc5YyUCMWzbfjz5K6Ry/VOJKxf24ZL9?=
 =?iso-8859-1?Q?pDvN5WbjTWQ8ykrVdrw4zOxnadD02n5ZEm2Byia2/j6V81o2dBYLm92LAQ?=
 =?iso-8859-1?Q?lF7h0noR7a3mhrJgM2J8l78aHhKquRD4qXCuxUq6yfV+XYc4eXW4wysZi5?=
 =?iso-8859-1?Q?kUWLA8cVhUmNBlF3y+Cr+eoEIyGYYkZdCxMsjwAjvrjqj+C4PJnlvn1J9l?=
 =?iso-8859-1?Q?fFpjCCkcni7c9C7MpiHYerzpjr1PS0vYrCbNmSyHCAjH12XPGAZE96yp1s?=
 =?iso-8859-1?Q?yiH0Zr2tgT5i0i1PmMbAGO2Aw3c/HXSzuh2PWSLwF+Gwi/FKcX73Bv83/m?=
 =?iso-8859-1?Q?9XngAd4unN4jyWnRgJKC5lmWg1jEWCJinFRdyaizl3X55u1iVOILCf3Oyv?=
 =?iso-8859-1?Q?yI+yEEx6KpJNnB86k6qIgyHRX0uIXynouFlnFx0YBcJWMrqwmisDQjfsy1?=
 =?iso-8859-1?Q?m5qmBDsylMG4YO5JLp1rfRXLsgfmI5Gx/ET3cQYOGA5CRs2kFaY8qBlHar?=
 =?iso-8859-1?Q?SY5Wgr37sQhlTPQt+lQMampopqJ91GjmD2+ur5ZpcLCdrGddn97R6dyY+M?=
 =?iso-8859-1?Q?uiaXYohlPdfeX38Pbt6dS1cyvTxYdX/vzP2nXSmj1DdhMiYoGNaj0l/uXn?=
 =?iso-8859-1?Q?fVGQ8QuhdSTd89wiM0LPGXvsdg+mu239xZAZCWsmCvtI2J1qEZmEABXN41?=
 =?iso-8859-1?Q?x5IM3xbvpdbOv76k1o4qfAj/7dYTuleqIF+y18DlEg+Es0/EPXAI1J+Oe0?=
 =?iso-8859-1?Q?ID8w2W5x0u9vPS4vGuI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93d4187-5d7b-4097-b644-08de0e5d5c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:27.7942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F13QnV/Xy7PP7TiN2QXruonfbk16MuL6lSytE30OinuSYz/nhK7PNc0r9UUZETM9OQAh8Hr7Dn97g4ZKJgFUR2wend11HlQci3lVxizVZes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Update meson.build with the new test name.

Djordje Todorovic (13):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  hw/misc: Add RISC-V CMGCR device implementation
  hw/misc: Add RISC-V CPC device implementation
  hw/riscv: Add support for RISCV CPS
  hw/riscv: Add support for MIPS Boston-aia board mode
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
  test/functional: Add test for boston-aia board

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/mips.rst                  |  20 +
 docs/system/target-riscv.rst                |   1 +
 hw/intc/riscv_aclint.c                      |  18 +-
 hw/intc/riscv_aplic.c                       |  13 +-
 hw/misc/Kconfig                             |  17 +
 hw/misc/meson.build                         |   3 +
 hw/misc/riscv_cmgcr.c                       | 248 ++++++++++
 hw/misc/riscv_cpc.c                         | 265 +++++++++++
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 476 ++++++++++++++++++++
 hw/riscv/cps.c                              | 196 ++++++++
 hw/riscv/meson.build                        |   3 +
 include/hw/misc/riscv_cmgcr.h               |  50 ++
 include/hw/misc/riscv_cpc.h                 |  64 +++
 include/hw/riscv/cps.h                      |  66 +++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  44 ++
 target/riscv/cpu.h                          |   7 +
 target/riscv/cpu_cfg.h                      |   5 +
 target/riscv/cpu_cfg_fields.h.inc           |   3 +
 target/riscv/cpu_vendorid.h                 |   1 +
 target/riscv/insn_trans/trans_xmips.c.inc   | 136 ++++++
 target/riscv/meson.build                    |   2 +
 target/riscv/mips_csr.c                     | 217 +++++++++
 target/riscv/translate.c                    |   3 +
 target/riscv/xmips.decode                   |  35 ++
 tests/functional/riscv64/meson.build        |   2 +
 tests/functional/riscv64/test_boston.py     | 123 +++++
 29 files changed, 2021 insertions(+), 5 deletions(-)
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
 create mode 100755 tests/functional/riscv64/test_boston.py

--=20
2.34.1


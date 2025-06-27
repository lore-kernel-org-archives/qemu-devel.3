Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10A1C7EE32
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 00:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUwaL-0000eO-5k; Thu, 26 Jun 2025 20:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUwaE-0000dQ-Ph
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 20:04:47 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUwaB-0007Jy-W3
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 20:04:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qtExC/cnzByB6/TCEd4gDkazpQTXME7yaN8x0YN24HAVI0H7v4cxEPvgr8WtOfir+VQV731+zejy9KECW01HYmfemBJmK0tIAjqpsOBqPibWaeDJciFPZPmtzohqe6tg8tZHujfCyKlZCt0f2qSaE/Fj/aBVoOVXcu+Ka+3VSvqhDAty60EIt8/XY+of6MG+gk4hBjkHx1w3zMIPHLw7LJ7M7DX9k/vtHvbkLvoZUJ5m3/nxh51pysXhAtKJ2ZwXNvCrKNK2I7rUzutT7XO/rLdp5tIgYnEGzbO3f3NrLuRklz5dYEm4tXHmk78y8vrOWspE53VQZIKLoKntQlY+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7Qh+rE/XZ5mA8yAvIAYFQbmk5C5xCSw4M56GUFNxGk=;
 b=aiHADC4bGg4+wcAUMcSx+18pJ0eGYxN8xlUpUbHppbZgqu7kLI51JWu1ush/PybO7QP45FLZS2i0lB86VLgb2iv4/8ZTT8BJttV2Fz+Xg7TQyeOYrJMEqy3sftX0MEyn9MGyUYOZykoDADqoccvxLq8hcRd3P6z/ZjhP3rRT8TaJkNz+L5QCdTzjPUqFuSJU792iJ0GDC6kMsl1mTq4OPndyAUZbsacHpSHkBqDr3+X7jFaVZ/OuZ+QYPrpm+iZiIMRyBTaj0JRYPeoR3H/35Kk92WY85iMtBT3uUeo6dG92l6jhu9pEg5WoL+q7+nKOq2nKY9YxuZUGbETeGw7DVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7Qh+rE/XZ5mA8yAvIAYFQbmk5C5xCSw4M56GUFNxGk=;
 b=gIOcQYOGaVzBJIEyoMc8H9fjP349jDtQIV4sfg/sLzStVTD+ClKOq7mVTSBvlXqgQ96Sd7+Wc1Qh2Xd9RR6Ae0076D2Slvm+WOz8KIBpv9vrQHZQ+5675PBTm2+wEyGhb/Cv1Z886VU7UIB9ucO2oaew/iyOyJWFV9h6dLnQtyjEgHfT4iSoF9GoZkHfUFuZGa0EJtVi78CbC40hb95I7CsypO8hUEJpywMU0lMO8qa8rKKFvzc9O1I3DSinkWhAI8+oRZFdTLQmeAwOyWOjJB0A7mPukpAaMuJMXHIfyTeMzNwb51ElbRFZIRe6/e7TvCwIuSd7a9A5KHk0nM4SHw==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI0PR09MB6925.eurprd09.prod.outlook.com (2603:10a6:800:248::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 27 Jun
 2025 00:04:02 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 00:04:02 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "berrange@redhat.com"
 <berrange@redhat.com>
Subject: [PATCH v7 0/1] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v7 0/1] Add support for emulation of CRC32 instructions
Thread-Index: AQHb5vb85YVcD5EnLkCvOH5v0yDaQ7QWH7CA
Date: Fri, 27 Jun 2025 00:04:02 +0000
Message-ID: <20250627000246.1811052-2-aleksandar.rakic@htecgroup.com>
References: <20250627000246.1811052-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250627000246.1811052-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI0PR09MB6925:EE_
x-ms-office365-filtering-correlation-id: 0e2dde49-8d02-4481-f05d-08ddb50e1f91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?e9crP6HFdEwomxfpeZ+VTbQS+zjnbEwj8VIyX7e9X1Ktxpj+1RNNVmYS3c?=
 =?iso-8859-1?Q?/AuqJD5EkgzCl7b86IeNXyuk1Ov079jbtEZEUksGgDkwwLlbDQ7LesSPnL?=
 =?iso-8859-1?Q?TGVkzhYTwJKF9xLGNlS66HQ045wB3Oik+Cc62vL8g6YvfwMFEr2Mq+Rj39?=
 =?iso-8859-1?Q?0nkOkdXraluXfWUj+p0pxRJgJ3u003QPbVYwC+tNuSIgEHA31R5HV8lMbq?=
 =?iso-8859-1?Q?KT/ZqHW3ghSFWaFN5V9nhgpaujV7lF65a9gIBlZPYxxMyX4RvXrz3Mr50r?=
 =?iso-8859-1?Q?PdycRHDyRd9pg7+jaRt2XePxuW1LOTKkbgaaSilma53dRumnZpowQIJveA?=
 =?iso-8859-1?Q?pZ+LUcMiYBDieBKIwPCx9sq8GzpLdIPvl0uTnLBYZl8fg/2is8mTlTF2bh?=
 =?iso-8859-1?Q?ajZkfG6yeblpmn3o2D4zCHh0oo6+a7pxmtvi7h23ImNHhYV2O+/e2Bd4r7?=
 =?iso-8859-1?Q?dGVk7eyQoJi9BUB7Os8eBkVed2uDianpOeBTurhn2sb0oeI9ahbmvW20Jd?=
 =?iso-8859-1?Q?UH6sQkIYVH/iZhXJ0+Ek7x2s1Z0+9L+gV8kuhwYlDS4XEVefrVl0yNqT+b?=
 =?iso-8859-1?Q?B81m97IrQz57YdNPq/4+y2d9l84zKZfZCAnZzfVcd2vUfXgLQquIOEG3b/?=
 =?iso-8859-1?Q?3K3AcwqViHemyGu9t+bSZNTdk92mzjLjK5ODQjLyk5ZvYymtY5QqELBZwS?=
 =?iso-8859-1?Q?PJyoaro02C/hka3UzUHI0lP/RTYSneAF9WcmV+1h9Bd4cF5j7P99Zm6o3I?=
 =?iso-8859-1?Q?gAgccygHAf8+Py7hIwTFHYBldKXRoP35C9Ft3xh25BPr4/X0AVc0oHYn0T?=
 =?iso-8859-1?Q?7D8z4bUHhr7eQTcyZZe8qIuhzi2Uoc8rQhMyDY6qruPmewz+1EiCd4tzzW?=
 =?iso-8859-1?Q?Yi5pjFKCpC5tGn65MOybZfSKYb+IqgU8ZUfTAg7JNJhDJKk7063/0LF5W9?=
 =?iso-8859-1?Q?cm750VMM4Q2mORAlLNRtlIpnJ/d42HgwvgX7E5O2ukdf/Ba7CfGDrM++Yv?=
 =?iso-8859-1?Q?dGAdqPRM6T2dj+ztVyPgFQ3m3HZOyq1H3yre7mUwC86zpGoFAhHxG9GEAv?=
 =?iso-8859-1?Q?GGWWM9MYdDsxjoprARMsYkbLSDf2H8qqOmku69IZtRRyce1nJnHo39U5MC?=
 =?iso-8859-1?Q?gCxtEQpEJJZHbjeLNNNLYaS92yVNaQz/aitAHn0Q4RwuMpsn/x7tMgFQZF?=
 =?iso-8859-1?Q?SDXsnMKldppMeSlF6fVJmHzecgQZ3VDrCs0nhqvwzbjifUiTID02AGkwgl?=
 =?iso-8859-1?Q?Y072o6pYMAqrXBWr3uPkEBkKt4ztDLn9cSzmRlsrSmp/Ckl5ktBpxDDdER?=
 =?iso-8859-1?Q?gkKpGSc6Xsj+PjJBqHHGWSuU/puNMK3/Ht4yORu2hBHJTzafzCQ0Aho1+p?=
 =?iso-8859-1?Q?WcP7JAiGt6yu8WJmVtEULTGxGv6NeTgYlf+CmaSYXp6G/aonFVcwJlpzFP?=
 =?iso-8859-1?Q?JdjobaJ8BQLlddi+e1h2xRZdpofwEX75pV4RIHowlcG2k2jttqgG1Cg74L?=
 =?iso-8859-1?Q?QLTs+z5Hs8iOraHu+lUZJvvdupeuLLZUTKse/pWOBOxA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JEQuzNYGxf7PxOqjtQP3utuMMsaNM6wy4eK4d8wRYklOUgk23knulh5iny?=
 =?iso-8859-1?Q?6dmEC5w2P2CjkzBlVWBRv7P1W4hzaAaNow3F4Ew0RYaoM/KH9ZW5Vb4LuG?=
 =?iso-8859-1?Q?95SlpQKx/5MVNldllOyYTGvdRu9j99cug/xXC9Ok8ZhuKPqBZ47qF+89j6?=
 =?iso-8859-1?Q?qR1KoaYI7qClkgtqnD8EaG0X786/C4wZIvb/pm3hz2sTbM3C8rAoFjtSiK?=
 =?iso-8859-1?Q?0y6C4hRIYYmU6ndBBwoYrv+134LYJbMz78sM7cIR1/LDuyDEhelKSRw7pF?=
 =?iso-8859-1?Q?DOtAALSpdi/Q9aJPS/1vgUCYPknZgnOdHyNWCvciZqhWXYRAh2kuLHvsNK?=
 =?iso-8859-1?Q?tS9xczdJXDfEgTgujfrcbPbReNogrWQYG0K2XcEb4HjfmSln+rtf4CVjcN?=
 =?iso-8859-1?Q?pryxcBZ07yhANv/xyjI4thr3xA/zA5ttEYuaGYpLL3Ow/GiOHG4L1qtiCt?=
 =?iso-8859-1?Q?fZAbCR++B6WrRvoPi7U0c3FNrYk3G+9MCuY42sCOzibtkNovts7faOlZ5X?=
 =?iso-8859-1?Q?mOQ2d0psTl4/Q4dkKJnZCvcSFA+dfC5+aLFZrmLLYA6sbdqW9QillopcNm?=
 =?iso-8859-1?Q?v7iBWCLBDmX2LAQGlJ5cebeoymxSSGofwpWgXbCc3jSJBlVsr/cRQhGU7i?=
 =?iso-8859-1?Q?pAa6cTu0AZ/i3vRox+Efgwh0DRrbQdJzUse0zehKdmGHyTtLzVacVicfXQ?=
 =?iso-8859-1?Q?UDVo+i8bdVu53vmiT6rub3XTIctUaai4pDTuwnHoKDbIEgRwrbSoUvJSJY?=
 =?iso-8859-1?Q?6BRtodL36XNk6oIRtKceJEuXOqntzJcJs6lF9KLVID05OAIzUGCxgZMWgc?=
 =?iso-8859-1?Q?99yBaxgDEV6KVB/AnmnqnKQVS0jHoSEkPvxDv2PCFFVWSkOP4Hh6ZZ+lmz?=
 =?iso-8859-1?Q?ZrKADeOf/lruA5kgLjp01aiePO+RsaJVNkdCjaWWRPnR3/fk2B8Ba+vqYL?=
 =?iso-8859-1?Q?DAViqXn/pQ8BvBeOdzBuFxzpTFpuo2VDPERa73yM8ygAZtcR4IJQ/ElQQB?=
 =?iso-8859-1?Q?KmW6yznM0QSkyv0YQ46WfU24YdvX2l6Fmftg2RWH+RL/kjIYN16n4yd5OJ?=
 =?iso-8859-1?Q?py0k0bJJV/VPDRU7O8l2JdwE561JSGKoihTo+4PBohfFCFcqTY7ChSNiFT?=
 =?iso-8859-1?Q?hUeS4lU4MfElv9rwnYPTAZz/H4lTLC/KKp12cpIOd+es8g8fe7pnlSPs2H?=
 =?iso-8859-1?Q?nDADO9LDJys65Y5si1pyg0q9m1H/B0iHIiCm+P5XmD4jsej9lgMEBvecOh?=
 =?iso-8859-1?Q?oTvYRhza1Azz9uynJ5mBdAEiv47D2DtGSfU5rjfUQuHDtBdvUpDPliRwZi?=
 =?iso-8859-1?Q?m/LFsnvfZli/igQco8/lle9Ds5NXWVhI8TENyXFvCZFSpdaIwBYM3RIIQW?=
 =?iso-8859-1?Q?svN3WooS+Xy6je9Pv2lrr/72CiANy76Fd1KxiS1zmVgnSGOG8LusXxZCWj?=
 =?iso-8859-1?Q?ofdjRi3kSo+erGipR5yHXZwhuBIWWFLQTeOmsO54waj6pYFGQbEi4lI+lO?=
 =?iso-8859-1?Q?f05sHIT90A8PuR+o+WDc65hRseumvA7K0kVSpHZFcXvcI8spG0vMvLR06m?=
 =?iso-8859-1?Q?TqwCW1oH5JVhGY9IcP4+78TZzSEiM22AP2QCA4gpPohIypICgh8bWVIwko?=
 =?iso-8859-1?Q?EijwSxZSdmlE65qBRlM8KHneZ+596mrChqhYjYkVZeBxr7L6Xt2FfHtdnP?=
 =?iso-8859-1?Q?BNUV48miSltOBDzy7nE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2dde49-8d02-4481-f05d-08ddb50e1f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 00:04:02.0201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBHli77eaHoRC0WK4rf3snzHvFvBtF3bpWif+jgqTNtYjeZnMf1Tqd8rd7xjCtmTRaWUt3Mai0UYKWT92LfeWtxckpnTbMCdTtfufy/ZIXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB6925
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=aleksandar.rakic@htecgroup.com;
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

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Aleksandar Rakic (1):
  Add support for emulation of CRC32 instructions

 target/mips/cpu-defs.c.inc                    |  10 +-
 target/mips/helper.h                          |   2 +
 target/mips/meson.build                       |   1 +
 target/mips/tcg/op_helper.c                   |  27 ++++
 target/mips/tcg/rel6.decode                   |   5 +
 target/mips/tcg/rel6_translate.c              |  13 ++
 target/mips/tcg/translate.c                   |  25 +++
 target/mips/tcg/translate.h                   |   2 +
 tests/tcg/mips/include/wrappers_mips64r6.h    |  35 +++++
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  42 ++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32b.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cb.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cd.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32ch.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cw.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32d.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32h.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32w.c   | 142 ++++++++++++++++++
 18 files changed, 1294 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2b.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cb.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cd.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2ch.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cw.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2d.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2h.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2w.c

--=20
2.34.1


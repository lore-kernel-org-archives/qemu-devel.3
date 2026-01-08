Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1661D185F9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqH8-0002cZ-5W; Thu, 08 Jan 2026 08:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqH4-0002bO-K2; Thu, 08 Jan 2026 08:42:02 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqH1-0005p5-TJ; Thu, 08 Jan 2026 08:42:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRaQy2a+t6WxHY3u1ucyKRvb2oHqslbpOfMjevXDI2Gx0HxIiWoHyg363M7A0taYZLsbO8JGi7G6mi0+dPYWL/bvq+nx1Fgg6sDVnFcBznQNxgOqG6ryW3HEBI6qCOCHOGhd2FyEGTkVvyp0pPp2UbwMRIAeX8xnw714u8U/PcHPaHCcK0xV3Cn9Mz4SYeHLcdCOh8z7EWkTN9pwh3QJ8GOoDJ+/WNm5PnMabiP02Sb9g8Jf8t0elFuDImsEg9dbYZThQsassXoMIDx6hxDPQwnZWYMPGWkqd1yrfphKUH6SIPyze8q52JS4Y0gLxBjVY7GIiMrsyyNJMDEMT7YH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NnQ7J3d25dnjdpQQ79Mu03afNwwgRtvGscgRoG5nc4=;
 b=SZ8OdaSzvs7Txb7dzwu5dxnpjt9XSvx7YTo9+KTc3U35wImUr6Mn/TPaw1Sj5nTwZQGPatIdM47r3N7NvK68z0iqWg/mJktehh2Dqbnzn0csb+yg1Lu3Sp0OyIh7/PDwfDM4FPQud2X6cfhCx1FBxAWVWuPm37rUMcMYbDrlKOV5zbq2aQhef8VpMvzxIL54dZblNzMiuMFxjeVc8Z53wKr+68EsVK7hNY61A3ISTLJMvO1zK9IgwwQwuYOjfVpvCLbm66JbY8ZGh8Ob197u0QFFxcZfld79ZISCmkdBSZezZFdu9lk4YjQQJGJaQEaGjvGdWGwZ/pqtoKl2YMZeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NnQ7J3d25dnjdpQQ79Mu03afNwwgRtvGscgRoG5nc4=;
 b=ClNH6AKUjgvO55L6W9C2szVeQDrpUAXnj87eRS8TFDtm9GTQBEq8DdsWF6zl/05CiX4HRLhalNS7W6DRr64aMNAg6K9X3Ud71PsQD7EdXXwCVk0qcAyrRhvuNHpL1pgjFGIy67i7VoWZhEHhDNBplbqxeaf934IDvwiEgObznw6uczaoF3PZfxE9WX6jkbKsZ4QMRocOsABNQ1Gfj32UuIBNHwXTEjdDi2ErMK7YfHtZek98Xm1Nmj53JczJgrWsAvoOAxNbn/o/EpnB6rIIZFilKWyNZOK/AeFCvoY8mBU8jLKpj4CUMIAitW6CBjy57VUl9Y3EDE79f1x7WPvMMw==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:37 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:37 +0000
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
Subject: [PATCH v16 04/12] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v16 04/12] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHcgKSC5iBvVnQTyEmekymS3rnkMw==
Date: Thu, 8 Jan 2026 13:41:37 +0000
Message-ID: <20260108134128.2218102-5-djordje.todorovic@htecgroup.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM8PR09MB5226:EE_
x-ms-office365-filtering-correlation-id: 6e2a7264-826d-4505-f5d6-08de4ebba575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?2EF5H4xz6I10nsVgNkNKENjHtRzkZOCNtPc3rhBsATIQ/xV3Qvta/J1Ysh?=
 =?iso-8859-1?Q?6SccYUkut0K6jM3AYkx/xCYwvBfWnewYl6ynd33UdsYLSozq9ur4Jxdotm?=
 =?iso-8859-1?Q?KkBFyemaa/q6iAMHJLHAZ/dscgkGn4DNR/4VxTdr7+7uyQCkizxR3PGBnQ?=
 =?iso-8859-1?Q?p5RwoDzg8nIdzB/YuuiEivBjTsWGxL1bjCgoTlwEXjLkuKj1GGxvOlGiZt?=
 =?iso-8859-1?Q?lG0zEUBmxw7rsP4aPZYTNjgwn1LKdjXKMVjD2tJf9vQxLoUA1BpqeVMUSB?=
 =?iso-8859-1?Q?9LNlr2aGwnPyFrPDCKxUl58YhwUVxvyGPsSYyTX2iA7OgabXb7Bw6oV+AK?=
 =?iso-8859-1?Q?BGRQINsqHaQpKGk3vvroshY5iUrHm0/mE3MNKg90QysCbUXwCkezk5DN0r?=
 =?iso-8859-1?Q?MT9Rb4jANgSZ10OFHJQeDqZ7kNejalHy1r7HMttxaBBg5Lwm3jcJ0Fbexp?=
 =?iso-8859-1?Q?CLoqVK4329X4H1zwsHgLGC1n7OgQ+qL1Mp771zdP6Igzky3KcL71GiODGa?=
 =?iso-8859-1?Q?wn6CxyF1FyRltmFXyEZ27OPOA9x/KY8e34PpPYF6L0NMWxPB3Nbyw3FCgz?=
 =?iso-8859-1?Q?qcWty6TJoq1eD4oNHQMq9FsKC2i/lqQIRR6nrWGfNMvzR7oixssdchdNXx?=
 =?iso-8859-1?Q?wW7buWHBFGNSlGG5Dk4jUxf7PH9U3hwlSc0Hp4VXHTHRkw5JduTYKx0Xmm?=
 =?iso-8859-1?Q?cQ0OivusnpOC1xrwLXtdXbdAZfzxkCfuK/mIy6VngaH9goL3+CJVfc4TUU?=
 =?iso-8859-1?Q?iQo2nvuemmdDag78Do4RvrnMXUqYvUdVl13giDm6s8qwOTT+w8M6gXKUgS?=
 =?iso-8859-1?Q?1OtD82fQ9TybfLIAHegku6+NZ0LPZYpkS9TO7e6Z5vI/pBkh/vn95imgCf?=
 =?iso-8859-1?Q?PxKIU07kw/QXDRy3SRFTRwYi/yEmKVMHwFkn6gOx+klv6logex/zmMN9bC?=
 =?iso-8859-1?Q?KglejewI78QmJkckHxd+xDu5HYJQTj0eR1LeHuzjTBF7GfEmuWRm2I49Qa?=
 =?iso-8859-1?Q?hwVXeV0lLVrykGvRegTW52xaFkKvoeAQpmb4Aiaua81CpwcrhqFglqFxoU?=
 =?iso-8859-1?Q?W4n/7AI1reSnYoKuY+g0pSsEInazzG/jHbaVVodWmwB+Qu7xEJOLfR/eEt?=
 =?iso-8859-1?Q?zJ5/RiAVJpcEiOzr2yONjYfdtnLMGbX8Wk3fB5ZPvuau3csmQyirivA+/z?=
 =?iso-8859-1?Q?MKSQ5+hP/27IBLrDbb96SC5KSSbfJ+/BJZqo3TuMzfnXUeQRmpBAPo8U5K?=
 =?iso-8859-1?Q?nNXmUKwCujNTK44/481Rid3DqPYktZWgWTktQXeQjBUuK+UloxcwEudLM7?=
 =?iso-8859-1?Q?bwOIZdhZynplNQ/RjSDJRuQVpF9nCoASzN8X6zgW5x128BBf7eHT9/Mvfq?=
 =?iso-8859-1?Q?9iSIY3hyR9/QbnL3chqgbyjMQihDZgG8DiKPBMKmxZDuzzAOVOA0QbgpeO?=
 =?iso-8859-1?Q?9f2Yq5XQVKKnL+l5oWksw6QUQ+Kdfl+LVHt1CHwGk71YbSKFwHktaHIWj7?=
 =?iso-8859-1?Q?xvJORG+bTiGvf27iHIBwXOUVKkoxQoy4mlGQKygK2huYdJsA66fiKICIcR?=
 =?iso-8859-1?Q?NxvGB2NG+H6Lnu5XH0qC3U3oLDnE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3bUFJ10anL311OBAr0ifzDFZcu7CRElZQdv6kpVM/rRHdPARk7Te7ezUXY?=
 =?iso-8859-1?Q?qTo9Nr9gHjh1Abd6z5eGY7u4tX1ZZ4eZTpT/qAmBJraRJalHU0tVU7LUUd?=
 =?iso-8859-1?Q?rOKjnvn9Qmn5RIGPYdBgSVF3VEAgJFCScXZJIk9JQLuM063BYeJg5rTakI?=
 =?iso-8859-1?Q?Y015C+XxviXdkZjuH3Qrk6bS79LOL8sq9+wP31sM6lCVCwDh6Op5CeVlm0?=
 =?iso-8859-1?Q?mKG9jg5NxpPFEB3cuoRIUBENW3QhAhUh712lyMveLryZtqvg10VZU85SzL?=
 =?iso-8859-1?Q?c1Dun0MkArGeUFZBKc5RymdgzR3UsXorWqN/zjNb26eCp2hhEg3o8THMp2?=
 =?iso-8859-1?Q?IpL4qh7mmkbNZDRAeq+IoSArqn1tCG+Va0PcTTFS96Rg3iWHlMQEv1+Y5N?=
 =?iso-8859-1?Q?yPcvcFaPMzXa4IAEypGfo3AWfBE2WhSdmYK8+z4KBN4HPhe3uz+aG3fxUh?=
 =?iso-8859-1?Q?9rwxMjefR5qPXgx4609eu83nOpQdtP1+KLHj550oBSoYjRdojZHzMpictl?=
 =?iso-8859-1?Q?oWAzq+480/gtfxDUTg7hhDdkAfPcPpFKfoxP4K3KFomcM0lv0ob+KQrz8s?=
 =?iso-8859-1?Q?K7zEDntwjhJakTXA/bLF3bG3dkcpSLmH69/gK8vDttoFHnbod4M4w8H7Cw?=
 =?iso-8859-1?Q?b8GhUzN6rAztX/At6yV/nyQ2v2/re8PZwVg5NwJqecUxEib8Br5FDza850?=
 =?iso-8859-1?Q?cJ+uYp2BxCvzAARPMjToUqivnGGYmLY+GNke1J9lvYY/MJF75uyHT8GbgU?=
 =?iso-8859-1?Q?vkYPfvJVE+CRgH/B2jdkAgG2PTY0EUgdv9SNjIJaevFhKIT0ZrCOh2L57p?=
 =?iso-8859-1?Q?Of6Jprr6qhCZdXwKDLq44mZsbnJbKqfVKb8NFLtmx1Yv57+tc/Xaj3Iocc?=
 =?iso-8859-1?Q?+zZX/ZgJtU/vfKKMb7Po1rCUG3xcIQaiao/qxxPHbYh/6D9nrIFZv0tSvV?=
 =?iso-8859-1?Q?GLY7/VitwLvUELTTlqeY1mWojjCOqVAa2KRd//9i7QWvyv1CIl3xLYOOi3?=
 =?iso-8859-1?Q?NzB1nDMUt84jdsaCArUuCYk/x3qnjxWy9+s1h8zZL5qYsOyrxRiLMPDft7?=
 =?iso-8859-1?Q?jWzwy4qMj/HkYE0jAtiEgOIFQSD4c0+09Cq0I+rl63bkAE+h91LtLfRAWG?=
 =?iso-8859-1?Q?RGyns7lxUxlSNQPK3ps1uuHy20g5YoM+xVug8PXb/2OvfMWr+F9BzU3gyb?=
 =?iso-8859-1?Q?ErTAohK91L3uLppo5bXKGdS+cWVCxAqAfzY+PZTV4oM0ATpq1BSO2QmDt7?=
 =?iso-8859-1?Q?flkpmZtvX8MW5knpy8HDk1hcHHqsx34uPGbOAogAdOZvbyc63J2VaF+iu+?=
 =?iso-8859-1?Q?1snrrAePAq/pXW7mvExGB6g2ZLk3SR4Zi3drnMRPFMYcwIvPFHuNIZ0oGd?=
 =?iso-8859-1?Q?VytPMY31neW1E8x5m84hTHs1/LZ31iFlU5jLtvz5bLy6zYWuOXQVdw3YLK?=
 =?iso-8859-1?Q?enln7OzeHqUTQVcn7OXJoiqhoaev315QwFUZCQYHsv8QN6ke3DqQg2jb1A?=
 =?iso-8859-1?Q?4Kkn86k98TP0NSUVOCWeVE5UtmX/rTFsVKej5uiFOwkuQ4Jk/0u1F2LwVY?=
 =?iso-8859-1?Q?M8XoHBdGFhMjN6V0o2CqpXOwkP7G3dBpHQWhHHsESJwXyfbrTv6mSZdMl8?=
 =?iso-8859-1?Q?BnHbOd3uwG85QrS4jpYM7BOugzVEcvKxJAyGVAXZtxNzuffxDVxSNmWR7Q?=
 =?iso-8859-1?Q?zOczJmvZXnub6Ewb8BCgp0uNBOARlRJahEQrXdswW8YcpVYE3ecDCThmuM?=
 =?iso-8859-1?Q?B6TW5q2SqiKBa1e2eoUVBH3dCVzmA7N+24iAlLiZIwyYlO50okbFRgwn4i?=
 =?iso-8859-1?Q?zvLcSVt+B5Z0+o6LQIaFfZmyRgmayDeSJQg7SR3fFreSeaD9AKNC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2a7264-826d-4505-f5d6-08de4ebba575
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:37.4487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LEoW8XGqe0m3dp9oKD5THPGkJ/SEcrbbX/wze6bGzwja2mIpLVo1tbLvgj7EtnNYDowQ2QtivmDt+5ZgC2/7avw7VSvoKnuDxTI+jpgrFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5226
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
index 455574f1d4..b4fbcc2f5f 100644
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
@@ -1382,6 +1383,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3334,6 +3336,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
index a154ecdc79..e842d46805 100644
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
index e1f4dc5ffd..53ce86d583 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1210,8 +1210,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
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
@@ -1227,6 +1229,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
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


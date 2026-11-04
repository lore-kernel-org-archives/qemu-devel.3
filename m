Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83090606D81A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=AXMCGiLR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOcej-0002yx-2d; Wed, 04 Nov 2026 10:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOceb-0002yT-8S; Wed, 04 Nov 2026 10:11:57 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOceY-00061I-J1; Wed, 04 Nov 2026 10:11:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfAt3Yh3RwYPvcC6WVIs6ZCDRBUJaMNo+N/S8oD7kICanv7X3GXqV4Ohc4Qu207j7Gs4pLNFZ9i59HgqDVk0BZtVeiRG2vzBeQ/ufQndmyZC6J1hjsAZZYmZAeJsCrViePLJqYiQBgEbASm3o+QYHEMBKo/GMZx8VwSvHmyIACddmQ9qFJZIGYV6Xd50fC2yPhVCzAnCgrZt5WXzeY7rRiwqF/o486db7Y79MqOJ+JVMIL7xhd+F1TZLUmBKiTiFLvylNTW9k8AkegN9U+a+14+QCcUSoU+uy58+pgMYynWSruEkKrubWt6ZQ46m/F35XneUmfSHhGteF7QFh0C3gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFp8yyLJqPKuW2sbQ5bnb300UO9YQSQg1T/Xb7ndb1c=;
 b=kZeF5rkUIu6ISrTgJ3PuNWrFXxAJ7hZxEKBABvtgmNUhu0sfVd1RE1oFI5mill6kHCLkLp7mdYjTFZ/KegT9Ew241nFfThztd3WRIhotFDa1zOjCk4D6yFzD+CZ3GTRyMDuVl+yVMxQezOmmz0sYAxNl7gQXR2dwWHjSyT1X2jQzV1e0JjCRd+W8EVeIMwlXVb5TH6ID5PNFcdo8xP8GE4JhxnSvTV5dXD4LyBWkELYma8oqWxSYQ+/con3PKkmeQfMUXFhDXGIh1DWnJAbB8sLHD5FlF/DssziLAi5MAb3LIT4CFTcjiFU0Rn045kTmvsVjAflL6cho0tVcL7v62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFp8yyLJqPKuW2sbQ5bnb300UO9YQSQg1T/Xb7ndb1c=;
 b=AXMCGiLRnyiaqCOvbmlO61bVllIibIGcj8v2hKBLE6dgDMp6gJxoJSNRCcq2szwDHHkuWhIeQN62/woP4l2jZRIv82rm0jpkQZYZE5b0fit/hrawa9Y552+BDVqDYj+OCV+ZTHG9S6KTw+8KT3mBaXpI9q8FWW42NqNt1aqjitjCDR+/KZi3HVqzK8PE2Uv7Qj7/LlEOPS3MkzcrKMF0mTgrgpt7zIKl/IeZcDsDLan+qYSbyaLTgcz7jbzPcie43LN8Y5Eilk2AYikLbPmBQogF/njZfvotiggwI/l1jVcbylSXS6OfvD9EfxxxxPvgYJ8LSy0BQuqlc9Wl+JKsTA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KL1PR02MB6978.apcprd02.prod.outlook.com (2603:1096:820:10a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:11:44 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:11:43 +0000
From: Bin Meng <bin.meng@processmission.com>
To: bin.meng@processmission.com
Cc: alistair@alistair23.me, edgar.iglesias@gmail.com, jasowangio@gmail.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/net: cadence: Honor subword lanes in the GEM
 registers
Date: Wed,  4 Nov 2026 23:11:28 +0800
Message-ID: <20261104151128.600958-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927075108.3621107-1-bin.meng@processmission.com>
References: <20260927075108.3621107-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::15) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KL1PR02MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b80188-5bd6-4d07-6eae-08df3a85ef95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261021121427099003|56012099006|261102123227099003|261009223027099003|261021123027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eR5z0p1QWQwAG86KOQhe2wvMprC32zUP6qpVtbu9kOjr4Q/950r7H3pxwQuc4X1em6FobzCjQ+htzKICxO7rIXqYl6E6D0zHlyNrOEDdSB7C0fnSgfbcsdyfTKR8CLo6ix5AKBpy/mg72+3P33LmFEyhFJMs/m5MLd8tKIZTsLIz8Hdg2//+CfMkOGLEiCIQfNdEPowGWD8pF9beo5zFhPqFP1axqzh+DoD+k6OsDqrvN72c8vGNoPiCTtfF9FikQmxw1HcOwR7h3BtvlDTGqsMc//EKyR5axYJr8vEKiQe+f96B7u9G6xE5c3vwnd9lE5alGrF+6nIuaidbkjoON8dh8i//fofJUYtABOunHWyFe8AZq/QYPGug+DmIlzMdRWBD+doWsat2dsQk9pbuf1g2T+GkVHPMlcri7WvP8W7X+ay0ojma5OE1V7cTZOUQVhqLaf6qE8z045B3gjtE6wmzrJ/343mQ14O/pea8qKihRMM/fdcJTKA2+KVWBCYcYbN56JdLvZ+GMS0zbOsxASQgN8LJ/qRes9wmXo42kg9bm5QTIV5gRuaWaPPtswKtnbRsI5E/xuVpRzLx95PQXXlLNOPeLmkDRUz3inSunc5wz1lDh2Rra41lGt1my0q6gHWC6UstY85tE8r9UCZL+DFCWj1RVHHwehZGnv1mm2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261021121427099003)(56012099006)(261102123227099003)(261009223027099003)(261021123027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yn30UYGTLHRODa7UAfJSK1mEOT0ZC8tI6woheYI2Gi+OaJ+eGqujrESuU/7L?=
 =?us-ascii?Q?cC/bxPbpVDK+HHOnw1luXpzme3M8eK5gPuKyRFGUxUsOfbR/CrBssivnxLSO?=
 =?us-ascii?Q?GhnrC2uYd4l7ddKjgfAGLz//hwRUoRWagiAygmpM4WHpkIciHg5Xdyr3ekHI?=
 =?us-ascii?Q?Xx6w0JibkAnjuG8EH64r2rBKPt6S0cbmtOUSnYZUsnUqMxn/y+0LnGyTc9AJ?=
 =?us-ascii?Q?MLHqomKoFzBIjzQpV499iSTXFDrA9SuZ30rEqo45nEFrATPb8HHQ11iIjiCX?=
 =?us-ascii?Q?k3qFg5VXGWAc7lzTJc/sld7Z38Aj5Rc4FeTxBTwcThfutgGoAbsc/MRaTiYA?=
 =?us-ascii?Q?ksPuKE9Z55FVuj1uEfrC2hbzpu/v+F9iLvof4rQAJ1hGCtD22fcwFXEXHL7i?=
 =?us-ascii?Q?vTPNfwoQrQdHzXlbwmZHlrWY31Nytc6zdd6RDZ/m7a3Egcx+y7aGzkLgeSxo?=
 =?us-ascii?Q?6Xxnuv8UNruCuY7bPBqEj/yT/Gsj/chatykJhiIMv2zGlqYN0PH08iIWokue?=
 =?us-ascii?Q?M/MeUXVnNpUT89DLeZGETS3H5BLjd+v80X5WFZZwHCSXvXYQyCMfhVJzs/u2?=
 =?us-ascii?Q?HyD31doxza7Z6bJ4lm81t8bZOfDa7P9Sh0AFb3qM9jZCZlWmfSF/8RvoegOC?=
 =?us-ascii?Q?Avh3BYx9jp6mzqvLreqrfLYUU5KfQgf1yv/2cnQ3sv92Mc0Qu7zrVh3CfoGX?=
 =?us-ascii?Q?k4BOU9k8VY7IIQvM6Nnou/dbvGnieFZ5XBbhJ0NWYhkhrO9gt2U82gJLYds6?=
 =?us-ascii?Q?mMyJ2dezP1FRXEKVLjyWWG3jUkSr09H6Eej8soU7bN7TyYv8CQhzsX5Aih9/?=
 =?us-ascii?Q?pvm02q1wQ9dF/RWqXwywRLgq40u8FexJy8sbnM7/saflQsFrWEukqm/B+Xn5?=
 =?us-ascii?Q?mv/T7iLDLrpBaTuTwho/aTdVIZYbVw1BP1s79u7v7zp8HViZ0DeohhePbEb/?=
 =?us-ascii?Q?Paz7PO/3GRmDGl7V4tHgUZQzcLvoO8Ta0z8qxnYAKgmea1HAYtMBe2IqWZO+?=
 =?us-ascii?Q?+gXK7ChkQJA+nigkx4x/8tQeZR6ttotGEdfS/moW9VjHb6QBhjJI7si8xJVh?=
 =?us-ascii?Q?kFQqzqG9X8yw1zz08BiEJuswGXTiAWmaMYmZAfWGpOdigHny36QUXw9LS6Z5?=
 =?us-ascii?Q?bDuFD70sB19nlAEr8O4mTMzxwA0TIKQ7lod3Ub1nyxlwOg9cEU5wMQbu03lL?=
 =?us-ascii?Q?EB0vnJ8BoqrfoWr0v+3vKqKodjMxNIgGgvtgShAZ2wuGEaayruaGWYEX2yge?=
 =?us-ascii?Q?S4dHE3OqVQdqEUvHjcG9oF314wILYblKOqNZbxpFgFY9fTYUDjY1v3B2iHjq?=
 =?us-ascii?Q?wERcMILxSizriD5AQsAGFmIg1lpieZGCKWTHTxHyKUxt7qSsnTAikkPxPcc9?=
 =?us-ascii?Q?nv0bT+CKmHKCSqlshmKlooE4SlWA6Lp9wrbLTvOrbltOJSqIZrp4Ey4TpqJz?=
 =?us-ascii?Q?sBkcpYlhHmW+EW9qRlmQT0oRr0ac5vBeq9K6Su4CnhZ1H77TkmMu4n5EF4/3?=
 =?us-ascii?Q?by5ewDbn2xKh8AiCHn+gCKhwdWfT5FrMDxyZri0xoHaznhzkpyjOMEzY2K0p?=
 =?us-ascii?Q?84QNn53rzXgjU/Emc8rajxXKcBo00lsD4Wh++dzkBzuyYxd+iIuExVvD4jRa?=
 =?us-ascii?Q?tMitAwyA8oGEN+LQByFAuzrsSSs9LGaxK62Fp//EgesWyrbbGPrfCDISSs55?=
 =?us-ascii?Q?AFtHamMyUogFx3bKM9mKzFMkHqHXh6ZyIO143Q8x+MKRTTwO0d4T055nLPeD?=
 =?us-ascii?Q?ORaw6kFucxj1LNBw8ccQWnW7YXucHMo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b80188-5bd6-4d07-6eae-08df3a85ef95
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:11:43.6860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbwievrEymRONEr79K9gDhcUPF3r51jYnTSP0jrrU17EjvKz3d25OWodi0Sy1M0iSRL/Cn4Lx7qWWpRX2Lsb2y43Y7WQzflDhEcN2+pyw34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6978
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Bin Meng wrote:
> The GEM MMIO callbacks ignored the low address bits and access size.
> Byte reads therefore always returned lane zero, causing guest driver
> that reads the station address byte by byte to turn four unique MAC
> addresses into the same value. Partial writes had the corresponding
> lane-selection problem.
> 
> Extract the requested little-endian read lane and merge partial writes
> with the current register value. Preserve the existing read-clear,
> write-clear, and command side effects, including dynamic queue
> pointers.
> 
> Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---
> 
> Changes in v2:
> - drop the gem_get_register() helper
> 
>  hw/net/cadence_gem.c | 55 +++++++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 21 deletions(-)

Ping for review?


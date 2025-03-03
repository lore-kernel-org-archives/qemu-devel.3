Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D8CC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2Fq-0002dK-5x; Mon, 03 Mar 2025 04:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tp2EW-0001sT-RC; Mon, 03 Mar 2025 04:37:08 -0500
Received: from mail-francecentralazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::] helo=PA5P264CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1tp2EV-00007q-2P; Mon, 03 Mar 2025 04:37:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qh2Ntu4XJ/X6lwNjO260dnE/8vig9xV6aalj+dDT2ALxn8SZrIUNtW9ypRG5g/+NaORvbP70318mayN/Oz3Ws3O3gzL8jdKC/1Rj81JOqdnbXaLXvGQpePMQXqQ/eNp133UroF2VR/od46VQIXNYTqU5t+ieZE+Vp5o59zwfRnFL+UHut0Hwgtg4cvUOojp5D6o+Fyz2s6Bx+vEs4v/IAYaVScV/8dcUWQcJFegJNfrep7h3J+sFOrnWvkunWh2v3aW2DPODbZS+f9EJyGHUNxryDkvIljsW9MwXrkDy5Oje7ZnGWGRTob5DC8q65fsXX0Qn9Oqy5oUt8TH3OSgV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9s08VOWRqazVFee532PPyrWj+1t76xARZSsjKEPgS8=;
 b=ooX7n34BphD5gLWRzEo7IGfXt77BHfNxXINGCKFaD6WELImdikPRXw9+q9gvDDEyBcDeqBlrWP0G9eLNiWBM2XSbE962iEc8ByT+oNS6orUqeczE2UoHwQepKXimeEhVZ1/AS0CSCTGooyLJRyCLRGY5X/z9ZKhcYGBug5rAiSIRhtM35dyqyqOyJHYV8kR/T562wX2ViK6KiWgKXZpvmz/uFZ8rowLmS+MgyNt+HKttDkBG05Xllj/8eRONHvR8ygtKdAn4TpoQK3wm3yaL9GgaVsZ5YU+fmvDqpejuvS8dArTm0BhYDi3kZ5iJHFxRMFxlHL9E8iNJzj6MoJEbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=provenrun.com; dmarc=pass action=none
 header.from=provenrun.com; dkim=pass header.d=provenrun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provenrun.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9s08VOWRqazVFee532PPyrWj+1t76xARZSsjKEPgS8=;
 b=aA6IvzybQaP7rqkDzKVqYdiH4hByuVt7EVP5Z/24dhj/osVWjGTJR5JOuIzt3TvTWhb2by6RbDP+wDQ9IC4QuNmGDWHksdY5/hkfLKMpBNUIAmAYHqRyLQ1boPXveq1l0srk0KaXctq8xL3JSJqAhBTQPg/H+GIyo2dJ+xfCUZFZR1g9qqLKjqmUa9skuNXC9q19iGRpXzeEjp25KUIkjrjvmeo5qEZGawS6aN9STamxRF+PeKfMx7HnvNQpTqYuj8VPrFdmN1RopnETiyyE1NjGdMJLW0DSkav/4zej4m9yC8VKlBgOB75VNeipsvxHiKv85IQNpQmrPdeScankHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=provenrun.com;
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::18)
 by MR0P264MB5530.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 09:37:00 +0000
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7]) by PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7%5]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 09:36:59 +0000
From: Florian Lugou <florian.lugou@provenrun.com>
To: qemu-devel@nongnu.org
Cc: Florian Lugou <florian.lugou@provenrun.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH v2 0/2] target/riscv: Support scontext-based trigger matching
Date: Mon,  3 Mar 2025 10:31:53 +0100
Message-ID: <20250303093155.35585-1-florian.lugou@provenrun.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0158.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::14) To PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB2990:EE_|MR0P264MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: 350504c9-3fb6-481c-14e2-08dd5a36f23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|10070799003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VovPQFo378lG88TuxWdjsBrBSuTma6Ppbzd7pnT+1ppiZ38usR2oLT8mgDBq?=
 =?us-ascii?Q?5BrCD4FdrDdoVN2GkZA0cDk/AhwQ9dedmr5SBgOwjX6OoGUwl4Ol1Qxcf1sM?=
 =?us-ascii?Q?3TwIvnJkcxmmH9fktZdbN3KHTrsKfT6iQa30+gu+26IZCCoujnfOsVcnIWxC?=
 =?us-ascii?Q?KaRnoLtCTZCRhxvldhAk5awdBWY4NE75s6DgnvFHBk6g6dkwqdVnz8UnukUC?=
 =?us-ascii?Q?Ic9bUEWYPBmgY2Kj7kmYS5Wi1S5fpd5rFQXAPnop286UgiVTARYCFFDLlJ/h?=
 =?us-ascii?Q?M8Jzh8V/nXTcKOK1GEE2UuMh7PCMCfO2jZDKXko2zNvHYYn4u4PaytFG8ZIl?=
 =?us-ascii?Q?lD8HfjJiuFxIbuDjtaAX1b/xraaSp6HxLfBsurk2WMYhf0ACcmzmTPdY8pbL?=
 =?us-ascii?Q?aljw8M6rrMiTplQdFMqrFWGUy5PvpIDNGf+N9f6KSXMfTSFoFGspMY5yQhi6?=
 =?us-ascii?Q?FUsoEaMo7YcyEnPNLx5ByHrueyps7iA1cecgNKM0dI35qv77mKLIUaQWf//b?=
 =?us-ascii?Q?r+lTQGylIDfR0Dsm+P8zcvQkW/f8IjRbFZmYRhombWRf65Dwef2fu1JqolXt?=
 =?us-ascii?Q?bf0JZHaU1hpsbY/7+KOI9DUSm4n2axBPAhZEPzLbFdVBsjnLa9mVWoR97TYX?=
 =?us-ascii?Q?SoeGLD5WpjOmhndP7AHMQ0ovLyj3iU0AFOBTYeswQ7myyJO0/zJ6RLc1mfak?=
 =?us-ascii?Q?5LZVV8gimZS8g2HhKPq1ZNh+GA+Dd1KRT1mXWYzg7HZnSq77/zAJz/sp93fy?=
 =?us-ascii?Q?g+iXDvfaJtdupBFqSFrIxWqIdPhuooHWdTPMIWbeihUO4WTX169MRa2Wzwni?=
 =?us-ascii?Q?kICkCfR7hcqOSD/WD0MHSqbk1vkSLCihSDHbWcD8PyaSvJzi+st5iZ58kdNF?=
 =?us-ascii?Q?EaE/36yyTHafo+2mt4aSDFcAGIYg/5vlc8cOpWpfsU0whd+rwU0cd3wyilTv?=
 =?us-ascii?Q?42qAddaP9va0Kqagb3GKNoYOG9AwhJxRXBCkOXoN7jnRfalozfQfvsO70QQz?=
 =?us-ascii?Q?Sy14/enn3vRm1pqLJshUGMZvreTuX1YZRF32meCvCDEHvaZ0CicfLah4k/N6?=
 =?us-ascii?Q?oJZuMSh46ClZH6VZsdsETJdhPI+bf6CiwfLIJTpvJ0fCaX/MYHnBy7aTzITr?=
 =?us-ascii?Q?mLuvMEwSbw7OfAhZpHNlT8V/i3n29Tm8vlNmtjARolPG0d4VBvHDgj7AIZ38?=
 =?us-ascii?Q?47rN2gPdmtEvNklVLNdKIt/bXdF8NXtTWB3jdgDMpgy0t4cX6zdLaJdy/k+z?=
 =?us-ascii?Q?G61ki/SzTPFj+SKcOCqvglOX041+sfuFCE7hKKRHi9VMWnASnVU3GXKSia2B?=
 =?us-ascii?Q?bJLcfldin51dVvY255Gk9f7ARbjvA7Wha10VrWkV1lGgZVWyJkccyQSuut/o?=
 =?us-ascii?Q?B31qDJYQiRHp+ArI09YzHSzj1N/o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tl1kQkdLdhb+z5r3sDB99543W8SEvKG/hlcUsRFzGSQWAlgd4yR92U82H6nw?=
 =?us-ascii?Q?QblN0mEoqTyeVmpYM/68fP1hoA2wWtrkr8Ry8bo2l3/a4VIY5uk0kthv166X?=
 =?us-ascii?Q?gTjQtjm5oyU85CsZh6+gTIP1U2wdmu1ctXd8MR07uZtfYYwlMyH/Eyucl33p?=
 =?us-ascii?Q?EZbL2OHyA8lgYE/pz48CShu47ZUrmJ/puz4PWYp5ydgKj29jQ4V1ohDEPi/4?=
 =?us-ascii?Q?KuObZx6Bc30JcftezqwHrrV3xrzY8gpWl157wFNMV9Fi5ZmEwWEGiX5C/ve3?=
 =?us-ascii?Q?REmewEBTeBXlp8GcPgo0pamGSGqUStpFY06eziSEibIgotgtc/GmmqwEkNdj?=
 =?us-ascii?Q?A6kgJpgZrWg0REfrrSfJdkCHuuw5yzFAdljfooiexEM7iVFo31nTa5iZiZ6i?=
 =?us-ascii?Q?0SWciLJfWTHvwQ+t4qIDN9JYulh8VCDZYEgTtzrA0CLaLhIGWqOcXmg2Nvkg?=
 =?us-ascii?Q?Vrw7T3Hxhcd4oi6qX2o2KLhdIMHToihxuEWNrgrZ7ZJuLZhYoi/ETV6kShUl?=
 =?us-ascii?Q?owAEgm9/NLzoUgTVtMRTz36HtzQoZ0r9WzLsonzw5Bd1FfscKk4YQkqPe3LE?=
 =?us-ascii?Q?07qfI48V8ZludOA4umOLSX5/Pj8uthh3XqM18p4eJVN7k5WkSXAU86luyfaZ?=
 =?us-ascii?Q?OxDc//gT3eONtf795fu6VRfTAYEl3lZuGz0PEmH878xxunyXT523NYALFvrN?=
 =?us-ascii?Q?zD55z2FLW7LwBt6XzKQd2PIkEwaplslj184RwOj6e7nGV+vT4Su3IG2rdOMM?=
 =?us-ascii?Q?ykXIUVohpFuTXQIsjjXe+4NIjhufb6E4C8JZC+25i1TqtQxwM9ONuAT1cvNo?=
 =?us-ascii?Q?TB6dUUxsgIDnN5ziPRK6mdwnLEIDBGTd2mmfmPR2HGni5IOPVOBF90AD4De6?=
 =?us-ascii?Q?jyJEHuWknCJITuqnKl8wsHQ/k0gxSIvi37VkZ5/L+nVmYVFAuMyTFIqMfSWp?=
 =?us-ascii?Q?Y1o/hC15twP97zxIzVi4ronIp+/n2Y9t4tjXILbHiVNOf8WRa9Ilg/y8KXNq?=
 =?us-ascii?Q?QN/rsRX2YY29tpcCOlfFYDseaIhQPnbKIZNvchEYsndwZ6ceFsGt7PpfKwI+?=
 =?us-ascii?Q?0nZbU2BVNdbzR6uTDNjPpwWgiF83rINqek8wrnQ2gP+8Usqck7z5qL7Erp8m?=
 =?us-ascii?Q?LSq/tXcnHFLtBCcQhrgEjU4bnBJphdUMO5N+7bxP8FlpmuoUwDveeo44bh+s?=
 =?us-ascii?Q?AHi8jCom9P7Hi36151DEpTv3hE/iU40tDlxucVfQg2rT09UjTEHJIbMyOE84?=
 =?us-ascii?Q?uzk9HAjBxBHzZCZT1/XnpFtU1QtQ0VhN5qJKamDuTbNzQHALYwz7Z6ecMMM9?=
 =?us-ascii?Q?KBDhNP2D22/qmEJ43WKzUSdoLmP6IPgM/QuMCTVmCOgaY8yw7qHhEZC43kdw?=
 =?us-ascii?Q?BMZPTF172dM+KIB+zKxOyszkhZG1yazxThQpg6Fc5kaQjz5Cdt7t9jMJpnbj?=
 =?us-ascii?Q?3JzPnQ9q+bRzk8TFYQCf6w/v/ywDscwIRgG2YYfYIq8PM5Td7eLfoQt7IzAR?=
 =?us-ascii?Q?lWUxlAZ3Bp2d9sZQbT7HCibSA2aFXNkqvoMrMoCDhhf9T3Yb58EDXJ/irK0t?=
 =?us-ascii?Q?CQ8lQ8dKZvyE4cLZRXcrXyMfer0fuPgT8gUs5+gl89BL9Q3HUHK458hpRKvf?=
 =?us-ascii?Q?+CwVtfrrVHYxB6yA0CnCQulM9h4a6m+q3swd0Ji/0pO139qUYMk8whEl3GcO?=
 =?us-ascii?Q?i/wssQ=3D=3D?=
X-OriginatorOrg: provenrun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350504c9-3fb6-481c-14e2-08dd5a36f23f
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:36:59.7528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff654c30-3eb4-4445-b89f-a54a92b1f03d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ooHzvg9ouYkD5x5ZDgvM+SBWH8y0P//kF4ULa1YZPqdXn9jRVYitbV6NMICHVDS+uN3SPG/703Dn58IlUImjm1/+1QIOcQBW4YEOIjQ+SHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5530
Received-SPF: pass client-ip=2a01:111:f403:c20a::;
 envelope-from=florian.lugou@provenrun.com;
 helo=PA5P264CU001.outbound.protection.outlook.com
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

Hello,

v2: Rebasing the patch series on top of the maintainer's tree.

Thank you,

Florian Lugou (2):
  target/riscv: Add scontext CSR handling
  target/riscv: Support matching scontext in Sdtrig's textra CSRs

 target/riscv/cpu.h      |  1 +
 target/riscv/cpu_bits.h |  5 +++
 target/riscv/csr.c      | 36 +++++++++++++++++++
 target/riscv/debug.c    | 76 +++++++++++++++++++++++++++++------------
 target/riscv/debug.h    |  3 ++
 5 files changed, 100 insertions(+), 21 deletions(-)

-- 
2.43.0



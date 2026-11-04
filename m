Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF3606ECC0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=Zv5vQ05q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOetn-0004XK-Q0; Wed, 04 Nov 2026 12:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesQ-000380-3B; Wed, 04 Nov 2026 12:34:23 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesO-0006Er-Cf; Wed, 04 Nov 2026 12:34:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+LGjlYpM19YmmySFrwxNBPaOXIpdT8w0UBBpPdjablWyjfr1Xq+DUxa9dTs0lNjuFhUaTlwg+e0MrG8zPZShRvaPmnALADuZY3+jNxe/2+4K/CC4HMqgl3iI00p0A/Z5nECGA2ATEmcGiF8Y458dDcdOdXh2MusMLdQCe0eSsguX95Oh8CoEBWWr5f7hID2BMaeLqvhtEGXE7PzUyWI62NfD7shz57FQm7wCqyGx0s/ezzFWge2Obl3h+FRNHBuSacFPo5HRkt0SHBDWQdrYnb3RA5zk2Ru7pNwezeoyPP2G0tx6PAJfhjS2Sh6ARY2VuQ2WsS8m/UmpUAYNh8BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOIRAkdkSGu2BFJuq84qApIHEpdPwqjKkdrXigLm3VQ=;
 b=x1Lvt/1txcltpJtMQz4ibe1bme6Uo230K8cVAvqDMi9BTC8M8CD81LdcG2d3cZHNv9jm+2Pgkobi/Y0wcqlUJYrQGXWJgbczGGenpDW6FjczPSQZudP5yU7nFkXZrqr3p5wi5J/pN4YtbmoZFTLytyYhfUsC3PcT3f7zS+siGI0Pu2NiOWyqq8C/Adz/rqvOdmJmlt0/QXLCoZvB3gdlKNEQp7c7vwReulIAL+uKZaYjTC3VtRtDzb7Rsp70ZwUoyx0Of5jKHoK3bVRb4wVAXgMxI6LTXmbg5wZcVgXIGvu/fox1VQtThcM40CJFFKpD8afH4Obnbcb9BVp00E8b1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOIRAkdkSGu2BFJuq84qApIHEpdPwqjKkdrXigLm3VQ=;
 b=Zv5vQ05qZCzplukSRQls4eTDX2D3oexC1WT4abHk3EBHKm/AniGlfSfjZMB6+BOuaPi2zG3pSuELBOow3NZtigCGFaXRDvhj/iQXDZZFCXhWW1G8Gr/M7WqpzL8tpsZxCNWwFeCk+2FYM0prnwwl1i4oKSmHSG0HImTq8AT/21t14e8k6ttkimKtc+Ju2PPBuINqF0cUOeSbpX1y7HVz81T3sQ5ssLtJEVGC2PmWT6Ug1oFVgYcEFjHXLpjxtrxDGz8wd31Um4gDvvHuTHGrov2hECkAUgOVh1pHSdig86+8nv0WnZ7XVG648E1+nItruZ8tdOhm6tVkz0xeorr7nQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:34:06 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:34:06 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 11/17] target/ppc: Register IVOR42 on e6500
Date: Thu,  5 Nov 2026 01:33:14 +0800
Message-ID: <20261104173329.706635-12-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104173329.706635-1-bin.meng@processmission.com>
References: <20261104173329.706635-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0044.jpnprd01.prod.outlook.com
 (2603:1096:405:372::17) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KUXPR02MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b233233-dfd3-4687-68f8-08df3a99d34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 78SNCsBIYmTxPdbQyTh0zsUlg6ehCZibrdAeOMrUNpcnWXNkPJFOf6c9aBqYLWmdTpUJyG+TEqDmU2Rc6ODnoO80ZQv9wfgaHyGuKPYjROuz89WN9AAlkk/NRao4xV0SfmPPTRtTRxoNOzg0XwoVyT2C4ide14bzPtuWckKbfqZ5JLtVgIeZ/74oOdxrzgFGdY0pjE2sQVmGD6TfzDMsFUAdVH+4a5KOLmiqET60viONuTVFzhtOONAHAJJbKBcmiUluy4dJFOvRIlec8y4aJIObb2pbU1B8dXbVFAnqQHYylRUH0/9GrT7zEVAyoHNGBRWyXpBETPH2DLxoqVKKTt6/Hgrv8DMKdZgDsNkDOopvxuIMMvuNFjCGDQi+YZcVCTmvCAOONQbA38GW0o7anI/WwdInMPqsNqFJtSCAaorZXO54BOCRnlIb/SIHdxp6TVCUBi+WMfQ0WyCzTduIhAUgC02wOxCmMvSdSTnV58y5hv9QM7f3BN6XVRcdUk2FeLSh6xH2e3NqOc8Rm1sAdXi7eYPWYodrZyxM7f17WAq1GKtgMtTD8NKUD2xpCOOZwjKXv3RL6S4gQLQJnGdMQZ1jXuJel26WWdx+BX/o91p/h+e1sNnD/dwIMTsarr703zCdjmxCWjJY5X8hQydH8kZ7BwZxbxrFaQKGIOm4nEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cVWwVoxmVbnAtAwCo34iTU4t+lmgWv6N1oyCQBVYyjMlOwLV62JQTmA/qTtQ?=
 =?us-ascii?Q?2o48sQCYgApUXskG0R8nRFZ5pN0IkhRfN00IW+5r6ng3tAGboMFmQKOrKGdR?=
 =?us-ascii?Q?1dMYf0kYN4myxlRACiYa/O05ADw8+ZWSYjmJeOO3v3t44Bs2QYuPjLo63tz2?=
 =?us-ascii?Q?GwebM1nYJbzGNMvPbIh4oJH4iEcFZn1L0URBsiYALVwr2OjujSZRt0L0Vc6I?=
 =?us-ascii?Q?NtO7fNEWT7cPIz+/u8uFmdHPuWMRGE3NBArpN0SJXswnRQ0xXxUby6Vzy9RK?=
 =?us-ascii?Q?+j/3wdBa9joEi9nPF5XAbPqMWQau0ctITWLZA32195Mjl8+iBmc+Ovkkaqrj?=
 =?us-ascii?Q?3zcoDBuJOn5DFhhkAWj0zDI4R6cf59O/lWIja1GjKyY/n0ugjP/2Gx2jupR3?=
 =?us-ascii?Q?GpE9JhgeqGFkyBCmqo8qfogbk4RI+MLBZv08/m3+CILF6T/b0bOrSTpV0I79?=
 =?us-ascii?Q?VjxQKHbnrVkXWNn8WIZDLmpk14idapabPCTY59nhQ3HnH/u4NPvPlFjv+PV+?=
 =?us-ascii?Q?HwhYkqIOKx/JjqlCh2olWtxPz0kHkehhBY3m9TVbOzh5g1ru9zpyVoUQzPLX?=
 =?us-ascii?Q?IRqK2RNDYKCEuikxDQQ4u5SrbW+bVXGcOWh6peGt6cx/HhYnQdd8oSxEj+ro?=
 =?us-ascii?Q?5pvkm/pQJVZjYuHsPAhONbxkRgsl3kqF0MkRpU5qM8Bc6lhx0+BSplxYO5KE?=
 =?us-ascii?Q?yGk60Qld5unvOYZ1moh1F03LJYNR+2Vu0YN6TkNJZxGWyYQ5agBj/do14nuk?=
 =?us-ascii?Q?vx4cD47/7rnJ0USplHLy0mAPjt/20p/kiv1hroP8ZMz6RlKU44z9vHiI1eA8?=
 =?us-ascii?Q?Wva9oDUwuV8fQjaSv7tIIEKhWNaskPgoaWVNSC/737F2ESk1yS4U2bhqXIcU?=
 =?us-ascii?Q?gH8Bqmbkee4peXcdkn8uNKCM0WtnSnXm/9G2ndLgyizZv+ajXl88yJr+dh3y?=
 =?us-ascii?Q?8cgdl1o5rtGtLWySE7Sg3k/ohzwLWSf8fqYv0tYhQrfyhkUu3qweHVIX1fKj?=
 =?us-ascii?Q?o/IosYOzSuq3VX/OJqULqgrW5rqBOynpfEZVaNnUr6BuHnPOWbmnF8vEzD5v?=
 =?us-ascii?Q?am0mI9zZb/ZOk+ZGhtPD2KS1QqeENXZb+8FkWqgNl4jekFaOAp49kdQlVRXI?=
 =?us-ascii?Q?EoqJAfsPO2iIjRBkCE4bZQFYOWf1NDHnjLg0z3K3HnNXv8Usns66W2EuMDn7?=
 =?us-ascii?Q?fjJGCaFeumUJtzIUs/2eya9VCOvBasBxJ+XJtKIfMVOrt1u7FDKKY/tlLGWB?=
 =?us-ascii?Q?30f1sWSiK5hlDmNa2AwSCvYUzQr73q0alnhuHx69CT8ibxhjPyqEch/s0dUf?=
 =?us-ascii?Q?QS1nAOciWL32hL1lDwg8EOftJEG53yWgZ/KP2t/LETNRYZyP9z8GVug251zo?=
 =?us-ascii?Q?kNyFuTbQrftJ22rU8Mw3jS4Q5bXFoMlMirO7703U/h0hQLWETlaYHD+Imr0Q?=
 =?us-ascii?Q?rKrEOoKgAzCB/DuBbaKJhmUJO/BS6ERt335kgPrDF11wLzobCgzItA3WDLaW?=
 =?us-ascii?Q?PCDoQ35pGZ7sKeV5jM37jseRmnZ6A/M0/BECc95tB2fI07mrT0snYrAx1Noi?=
 =?us-ascii?Q?G8wE6cpvP3ne7yM/6VZWLdwS7j6fRfdhp5kavvF432ekQZRzH/JMHgqhBce3?=
 =?us-ascii?Q?FcewgK0rURnRC/JlsqpWCl+nzBM7DhddhvlmjIeYlTA9pU1eQ2iWUrh9/01r?=
 =?us-ascii?Q?3RqfXQQzrJYoK4OFE/xpL+zOK+Nf2VnNcN5bbCrJFaMzjIhaHXgjmVPCdGHu?=
 =?us-ascii?Q?ERZ/rNn3yBE572o3eHR/6uNDb964gr4=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b233233-dfd3-4687-68f8-08df3a99d34f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:34:06.0485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLrAzzE/N+0y+ric8PiO6JNpfY7zlQ635jII7sfrBmUlNylqcDK2iI4YVBOK9mrCWMsKFnkqhP0JuV8L7GiA2DnMAkrXvnMRt/2ZDoDv9xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB8801
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The e6500 core manual defines IVOR42 as the LRAT error interrupt
offset register. U-Boot programs it during interrupt setup, but
currently the QEMU e6500 IVOR mask currently excludes bit 42.

Include IVOR42 in the mask so the existing BookE SPR registration
exposes its offset. This permits the register accesses without
implementing LRAT translation or LRAT exception delivery.

Reference: E6500RM (Rev.0), section 2.9.5 and 4.9.22
https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index cc702d7c7d..224e1ff77b 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2824,7 +2824,7 @@ static void init_proc_e500(CPUPPCState *env, int version)
         ivor_mask = 0x000003FE0000FFFFULL;
         break;
     case fsl_e6500:
-        ivor_mask = 0x000003FF0000FFFFULL;
+        ivor_mask = 0x000007FF0000FFFFULL;
         break;
     }
     register_BookE_sprs(env, ivor_mask);
-- 
2.53.0



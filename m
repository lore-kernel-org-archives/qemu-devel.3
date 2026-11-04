Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E8606D80B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=g8eYGHrh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOetx-00055u-5W; Wed, 04 Nov 2026 12:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesN-00037k-FQ; Wed, 04 Nov 2026 12:34:23 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesK-0006Er-OC; Wed, 04 Nov 2026 12:34:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYW1kzNWBm9DjZBGO3Zrzj1uM81YsNGjyq/NBcJU/38yHpuH+SCrwDLo8yRI1MOM+Oal7UPAM49aWK+vsltBKrtRShGHYJwBDhRB0WhbLMXizuRj233TwE1EToi3HXL9LXvw7TGy+nqg+A2UuSeBBE3ZAfg/TCsAHl+MDAYbVKrp23vJ7rP72STywn1ysAjuhQuHm3ghms3ZYRMWSiqSDuYJnCCOrge6HoOg6aS2Z5k6t0yydJuYQXf7zty/1ba6zFn9QKC6Y/LqUAvPIUz+F2DdV45FnspABnh5VVOE3deLZGFLvvZW5dApg16smR+NlDD7qll2f6xDHuGShaNSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZdpzC06bfD0VeqCg1VvuHVTr8amtuLmuLgxpQ4Hq1Q=;
 b=e+cJjzMA9XSR5vNVg/dbiKQJdedXKuS3zPLMZAWkw/BwDuaNVAvTJA10ysjGjGNARLDHlkgH69GUSYkg6WlplIgXWsv62/0bMIjgJqzOcfY0DiOzWClHKvk5Ew2MtxNavApOYYEaxyAN35idIrvhETg3HrAJguqyqf0twBBgYenLD92kB6toK6vyYqP0jf1qgH99wnkadVM0tmz2VNDIFJPP1Mk3xGR9NvmfGlKSAZ7TB8gVzRuRfNmkhm/FVMXC+3reEmDqBg+dxGgaPEr4HiQACazLf604IrVjWzQb7yQM1zHlYkaUBwDUqSdLI0hPotj68DcAJtcV5KGEaxBNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZdpzC06bfD0VeqCg1VvuHVTr8amtuLmuLgxpQ4Hq1Q=;
 b=g8eYGHrhKN63NE2SU0baPUNGcGISQYRi8V4qijUC2uTdgwYyyi/DdsnWbU/ETt5ZjXru6+SEqml5dlXbWfjf699X66CaDaRSSqgKhBUSfpx1vbHXbLtfEj8qlWFX8jD9GmOvjp3ZYiwx5GxM0EwOg2CwMmZRpYhHLaGghsPEWwIW89qgX2wlKttimlgayhnQMw1xXQWr/Y6Rp2Gr5z80LcED4YnYJ6k9pisCVKZXMY3EHJiQEGYNwHWFjF9FfAs7Vk/XrFDmOI9kjWoB4v94HEHpfP/PvP2Zzybpv7NY3mmrfAdQvPuiJkPO3y4zvc22Z8SWZV0+KH25YG+5bwgMNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:34:02 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:34:02 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 09/17] target/ppc: Register MAS5 and MAS8 on
 e500mc/e5500/e6500
Date: Thu,  5 Nov 2026 01:33:12 +0800
Message-ID: <20261104173329.706635-10-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 29870027-373c-445c-2c86-08df3a99d112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|261026121527099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 8xkJyH/RQZpfiJXTaFo3wuOQTD+vBAQTOe3vlpObd6FanryvPrMGk3celP7b2Wax0F+39WWCJ6DQTdm8+U4nHpEFZQBy9BAjRdcB06tMJJieHiehrXgC0Kh/zZquy6HJOSArD5w/bjz+zomsxc+7yJh/aZx3maPShm2BmDoqnsE59keJ2zJan32l5ok0ArrfzPC48jd6T0m1dTTWcOH9rxTvtOjdoGJ8larLEheiGnO+G2Y/0B1GUeLDjZvEKhYtBLBAqzFaXolehwz2h5mUKmS1Bvv7pKoP5f/xQmijfxTOBoEnUngOPwEBd6+SCiG1qMEPrrpOpMlLLVAMwBsKccAEAQg0rCFERfDsAQ2jE4lIiiviun3RWvUTajYWI8EWmqSIWhVPBwTAZuiHFwXI3DMbMXr7BwbFDUK5W1C5meBXUsl7a+JKJy6KOk1s+G1lmnzdWFAxs8JMGEfrzNjkR/isDAjYDtF/1OQ0x+X1ms3Wkrdf4zPLUra+4JIau5lQcbQCXhBB2KrtMdVSonoP4GewNeh4NdAb/De5bc6oH/PCpSHW1a0ebG3hvAV+FPoh3+u/HvR6GMAZMs8664WehmrvalN6iAwraw/WGC0K2KQZr/hbubJnquz3Kz5FSGc5i3CGu5gQQ4GvwKBUJtSzyo/DQ73umHPJVeeJM0e3sfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261026121527099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZUOx5MqPXll3Usk63LVQXeGUUFmo9rngMmC89nJncPbGmdS981fxvkI+Goiw?=
 =?us-ascii?Q?2UkJ5qiCIGcyuC6qxMm6Q1YwqsEtYi+D30f/J5VS+HfRLzC3eCxMRmYJgEeW?=
 =?us-ascii?Q?x+ppyVW0INhn3D7KA7sW1OGc9eCHHg1nqet56XdqYA5k01SZ/B/sx4kmNFY+?=
 =?us-ascii?Q?mTUHOox6KvJYZRz1+eOdfiWDGyRXJJST1fXApr8Lxn3c+mvC2v2/nLMc/G7b?=
 =?us-ascii?Q?2iMukhrb3AeYbInJjn/Mr5PzAV5J/uTm4D/KX/Y8xRBUW5VrtRQ+Z5Ed1VSW?=
 =?us-ascii?Q?ENbKpJDoxA9CwrSlNC0Cl0veGJlP/u+SFmB59ruZEZlGE/b8+3v8iYzWKucD?=
 =?us-ascii?Q?BKrUAQAPRCmC6WJirbdzYTZXClod2a+ratthjeUp0ls6SjxvqVR4VeZxvyKy?=
 =?us-ascii?Q?tzKiT6kM5ARgmTK601Ek0wRTJd8tKiL57yXaHpxSbS2ja1joMGW0w9jjriB/?=
 =?us-ascii?Q?l3tsO7+BXkjNZN/5RtMF+g9WBaaARHKP++11qCTYOCF2xtC6o2DQDhpCFK2I?=
 =?us-ascii?Q?9V/LDPJ0fTtpDBISVrTrpjEosgnOkJfrLqT0sy4YmmLU62FAmg4fuv/N+/Fi?=
 =?us-ascii?Q?J5V9yuFSeNTKKKdp2m4L1pyCPrECKkA+KqXgrhz9GWyx1EhRi1wEuxKxfbsg?=
 =?us-ascii?Q?qW5SP1i8Kr5PJ7GK/XM33CWSMK1TannTnuprKySQAx2b6BV7qrdRzEe0o+0T?=
 =?us-ascii?Q?mscg+a1SYGEdFquRoluf3MsU/DmPOk4c8ngZlQe45Fw/ATsVniD/v6QXACCT?=
 =?us-ascii?Q?OEGIdyw3zE6C9E5O7QJkHK3MmtNMqY3s0+HVvyvLZO8Xxpt9kfKsFzDyrupu?=
 =?us-ascii?Q?asF8aJ4Zx8i7LDlNR2+SexH14WU3Z4rLEmlbfmConpsbdVY/dBfdE2OX5uCI?=
 =?us-ascii?Q?7xFqC+em/JJ0QgxQV+YeFPFLbhSVmyjbAWpRlz54z3TvOL/bweM52ZDrZ/3D?=
 =?us-ascii?Q?TCOqyghr96gHFcm9XWnjiw98CCizlBABZ0zfllpAHs5VX/a59+kXGQwmtpf+?=
 =?us-ascii?Q?RKeP3cj/OFjt3C6yNTXj+7+TCphXVbLMaTCyO96TUSGP4aZpAx+Mdym9ccGg?=
 =?us-ascii?Q?Hw7qfKQbPlQsOIdBcSQ9CVCjifMrzrJ5coqxTd9dWMqsgdfWzYZP1EoM8jEX?=
 =?us-ascii?Q?rm3TtSvQ94AlAyeqQtRnlVbPvqAl2MHtLo/ZXXwzvpED0+Q0mC8NN7lxdA3q?=
 =?us-ascii?Q?4qyIDam208Vhf6iLBEOqGn0XDZIwR2Pr8CHYEEfWmPImRQ3gp2HExRt3ze6f?=
 =?us-ascii?Q?bZHtglGRHP1SvpT8OugtYWACmFKFPL+1mfendDvSl2FaaTOU3qZm8OazVjEP?=
 =?us-ascii?Q?CJpnSjDzenVITsyQuE7/hXcQu2473BJ+ITtulGRbQUmfRfknHF/LvLqclo+Z?=
 =?us-ascii?Q?Mo9P1ca7pZDCrYnU2pPZd3jWvO0cfub9hO1H4L69wT46tK8G5+sGZOgABBFK?=
 =?us-ascii?Q?xk2NgLuA7hr4GkjFLrlLF0sVJZJkMU3LI5rUAZoJaT8qH/sbFFORJv267w/3?=
 =?us-ascii?Q?c4zP4vz3h1TU5rxXKlRprMr8ZV4t4juUaTkobRmop4BHNKrwxEjog2jCzj6A?=
 =?us-ascii?Q?6wFOjSA21PQSxafCKbgDI7vkkv2aK4By1sppqNUivdCNsienMD7MVRPAoFPH?=
 =?us-ascii?Q?nZrV39a0FIvYoKoqrd+6Lmy8tG0FiMwoKZx3lGBlpnQauw/sSpdiy/JdQKbM?=
 =?us-ascii?Q?mGIzuiQQjlWtGL6D+Os7ZeJMd1/TUSZRCxlBJCWbiKzEW8OwYkbJPQ/CltsB?=
 =?us-ascii?Q?FPWM6MOqIVW1EzwaEQ8atC3Fp5DhBsk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29870027-373c-445c-2c86-08df3a99d112
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:34:02.2852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBPFO+0t/1c+43PyxEM3MAxu8s0FabFh+LJ34OvTrgDZNtUuOPg742N53YADRZkQD4/rnypVtHovuXxiYjy89R1MYrlYoZlHgy8A/YAEHzE=
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

The e500mc, e5500 and e6500 core manuals define MAS5 and MAS8 as
SPRs 339 (0x153) and 341 (0x155). MAS5 supplies GS and LPID values
for TLB searches and invalidations, while MAS8 holds guest-space
and LPID context for TLB entries.

Register both alongside the other BookE MMU assist registers using
the existing 32-bit SPR storage. Exclude e500v1 and e500v2, which
do not implement MAS5 or MAS8.

Reference:
- E500MCRM (Rev.3), section 2.16.6.6 and 2.16.6.9
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.16.6.6 and 2.16.6.9
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.13.10.6 and 2.13.10.9
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3d76b8a082..e93f699f83 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1933,6 +1933,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_MAS5        (0x153)
 #define SPR_BOOKE_TCR         (0x154)
 #define SPR_PPE42_TCR         (0x154)
+#define SPR_BOOKE_MAS8        (0x155)
 #define SPR_BOOKE_TLB0PS      (0x158)
 #define SPR_BOOKE_TLB1PS      (0x159)
 #define SPR_BOOKE_TLB2PS      (0x15A)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index bf535d3081..7bb4e4bcb2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2901,6 +2901,14 @@ static void init_proc_e500(CPUPPCState *env, int version)
                   env->spr[SPR_PVR]);
     }
     register_BookE206_sprs(env, 0x000000DF, tlbncfg, mmucfg);
+    if (version != fsl_e500v1 && version != fsl_e500v2) {
+        spr_register(env, SPR_BOOKE_MAS5, "MAS5",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
+        spr_register(env, SPR_BOOKE_MAS8, "MAS8",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32, 0);
+    }
     register_usprgh_sprs(env);
 
     if (version != fsl_e500v1) {
-- 
2.53.0



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EE6606ECD7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=mWOGBsHH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOet3-0003LZ-JY; Wed, 04 Nov 2026 12:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesJ-00036z-CI; Wed, 04 Nov 2026 12:34:15 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOesH-0006Er-OV; Wed, 04 Nov 2026 12:34:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSxQhA5sOKWWI8+TfHqGEISkQ2cIVjV+kw48MX9asJ7rf20HwQcgdtwL6+hPrvhPmf8pwtcUpfTbdFa1nlOjw34Nidov+kWr/j4L8BXe/p9XO/Dl4EbHapA5j2poVYTEwmhhufHZ1GgDJFKoy5H/vhvqQK2K9sZbjaLHo6N96hqVFCMXYQAPRrCYepbxSKGOvYdhD/RTZ6drI9nXrrryLFcGpl1epGyYviq2y5wjy+VlZC7Y4/2hJqVXdlCDqBggn+9NXJeRKm/CFVTrS5iYe0zTWUY88T9jHyqaHcZe61kHwNOsIpsJtxqmuMVs/dML3U5v4ehu/DQwmxWSp+y8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyOSncRSavy0oyxM0+2e1d6EVRbK+86P0CgMdUafBj4=;
 b=dVpJh3Xxm/BptdhnzyvaAP6FsnaCvsNsBzXT/Xjc+9BPYmgcaTA/uSjS0e2/y/1vsJM8MukxDCkJquF17cBww7I5rAgANruVqMZVrWo4paHTdiJwDqT8yCSZOWpFxGq1oCRTREGiJ0jhQcSLl+i7SmkxhcaZwyNTRgoe/54voYVF1ut7HsUZeNAvgQd3aDGDYGQIThsSoysNZszt7KlwcpxkIeIPBtuDANgycYGBC1yzqr26cj6CRA0YgKoAhWyvuBaVu/RyAuZAm4pxb+B8YJ/TpOKv2+qFh1u8qyE1EjmgU6CSafbxcZ/Okk2QB+0as57ol1Tpb3aC4NccZWa6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyOSncRSavy0oyxM0+2e1d6EVRbK+86P0CgMdUafBj4=;
 b=mWOGBsHHMKuP4JKIrBdZDIyoe4R8zpRuoggsBC7pw4GybhtjS8A8yKQt1Fee1X7Xww12hD2ZfEJsAT5pkOEtXKUhFRHSHMXfNuy0nVZcesc/mYT3PMCJ10VDefEWgKRnWtp7G939vRBzso2nBLvHc9J9Xdn+Ykflvbfa4ZyiQIhplBlQthKWpxLfIoAaXxCAKAs9+j4TyChJbbSF2tK/rv1kL5TFqd4JPBjW/FvWi2Nto2JCZiZdGDspSaRRGAf8yUJRe0TXhYjU4R5ZDe3z3k3CUCGreU0iXdIagPIy8LY1jwxv5+ntOVIxFFXeN9GcbAge/fogNpQmK5k4ZExUJA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB8801.apcprd02.prod.outlook.com (2603:1096:d10:4c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 17:33:58 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:33:58 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 07/17] target/ppc: Register L1CSR2 on e500mc/e5500/e6500
 cores
Date: Thu,  5 Nov 2026 01:33:10 +0800
Message-ID: <20261104173329.706635-8-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2160a217-ab00-4e99-d929-08df3a99cee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|261026121527099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: zT90FOaNYCFgW6dPYXJoZeT/Q/ycaG9drDHZqmcvTNrx8LUY1HnovhFt2PgBLzHU/66N7cu6vZgbwp6L36qsrFnIWISZRRpEnBZcc5El+0j1ZqdlJi5KwiuqkGGmYG3aygdTFD9GRuVuwE0WMwBUTbvix/1E++pblndKNIss5JdzjRfqi89bSO9/OLEQPcMmHkH+g8MMp+bi7gYeR8CAgnzAHE9Jn+2O+04pByTZLxtOhvae0fTNj2ZmNvfPjkWEF0qHj+tvBHnXcr/9tT/xAjhCSIOQKdBc1wh+Ve4ZY6XRFVeOq3NjasToRJ/RlXrbzdw/9xhT1CK/cQp2QGJqv6F+WmOSJv2fLp9ZkmfAhHWmbc+Q8G++kuGa/LVr7nUKHf6tOPvcaBHkj9+GOomcpz3Ioa2v2UzMJ18WPODd0QK+qfpKtgWm4rppZ10ZEWizGD0xakp0FX6bLVYcSBmi+f1AgUP7utsl6CE/Bg6jMIDYCmAIWwJzfpXZOc5vn2skvXnBnN6AQpsre4SxEVgYp2XC99qI2m8h5qvjDbrarjqm9zEatVMIanHgzHV6VGYh/7PXlXCIdzSInzJi4sDGzhdw8r9VTrO2LWa0yKPF1m0QNnbPQFHDyUZ2xlWoGNgazJN9o9+Mnypb6Fc01zlyfqN4vLUpAQPJA7n0si2TlwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(261026121527099003)(261021121427099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PtJNfXSxjakR1uo+mT0s6Ue7oGYM3rYCshbzB3J75ZpRQI1GK58vWaUW8XYU?=
 =?us-ascii?Q?42P8KYlb+CcDLnbgwG5Pu2m2Cd/qil77+8itqbbhBQcwCdJeA8i6tCMaWEtn?=
 =?us-ascii?Q?yeY+KB3tbuUCqy/CUdg2jgm13oXOqQcDc3j07cjWJEaRV8+9NlCZogJlr2r+?=
 =?us-ascii?Q?GjdIIO/fbGXCph0GKp1FodEZAfMLbuNLQCkI4YG7ttm2daeqnN/SF+bDZ6Xi?=
 =?us-ascii?Q?rDV9d0fD2dTIoRWKApEJknFOTJPqaNf264OQz1bPYQoezr57MN71r5wMR0Cj?=
 =?us-ascii?Q?b55QsxG53mLmhbqoxHXx9V0EiX8G5gxmH80xZGO2mLWyIF+NnsE5DA3yimYq?=
 =?us-ascii?Q?axQkPkv+Xb4OumbACtqX9Sj0a3T564QCDzmLGem5VDgWt9l6wi3P0qAfk4gg?=
 =?us-ascii?Q?oI8FX0Bl9/J5pX1Ho4ASz8PS3xz8x0hrT8xhNEoZuoAVPGdgXFBlOPXr01vp?=
 =?us-ascii?Q?BmPGMGLtBCeagHXd8MvltMAfdCADlDkJToR3RPXe4LBQe2s7XSkyX77+40ZJ?=
 =?us-ascii?Q?wZuSAl2VIwADXEPKwAsF5nocZlN48dswhaUSBnMQDXAnl2+F0xAK/2RfQSnF?=
 =?us-ascii?Q?sltwhleBdg9IqEwtY+deHOjYcZoQ1nSHt4StZ5EyoiUu/LkRZC1Axqx7gwBI?=
 =?us-ascii?Q?XVCtFVEOcpEBv9ycK35/5JKRhGo9NxGhdQLcQNOFU4xVRxEeme7KZmMhfuy1?=
 =?us-ascii?Q?SuThjW5Ap9KuVr4/3FhHGpB5NLbnno/0b2e6FV44bf5sNvmotDKnjGAPyBCd?=
 =?us-ascii?Q?184CFC94DhNJyGyVAc80cfY92yCFLRfY6i6EGibH8oMIVpsayGQrgW+rwYZM?=
 =?us-ascii?Q?3WF9rVuQsktUHFZAunIw5mP3uf2DHlGOQd/3T2okZLKVkIl80f1FYFJ9/tzg?=
 =?us-ascii?Q?VsIVChnTeCmKX5BZi3qWQCYyBqmle/p3MRXMW4N23kPzOtQD6hwWpg2zjTD1?=
 =?us-ascii?Q?HW+SvmQgsMOLgzt8PiZd8ZsRpG37S2hQYRVqyESgT2n7phXiCuVbo61iVn1I?=
 =?us-ascii?Q?F7DkjGkU4vGSkHn8Dz9jqllImGr5X75LfzouV43FV7g7CSSg5Pn+95lY6mA3?=
 =?us-ascii?Q?Df2nbRqiXs+gasrNHckiM81fA1rvTUGVHTgYvGybDNx3aJzX5vZx01G6+ek5?=
 =?us-ascii?Q?w6omTpvknGE0syHYIhy6ZYkVMUmEFWVjOj4JubXrOTRwFIF1wSwzxM4IXNAR?=
 =?us-ascii?Q?E0tk0F3wCeDyyUTbqFeDZ6WWXW8oE3aPvdRgWAkg37j/0TWIR7fM3C6ZITEG?=
 =?us-ascii?Q?KuyUQjuCrRvP4MrMhPwv/7nsz243YLL138iVcaR5Ng66lLyoj981y9SZlGP9?=
 =?us-ascii?Q?qHQJ3cbXSBu+QZQylnNvOt1Bv4txaYgLqk5eePp3btW3PjY5BWwI7e4aGLK8?=
 =?us-ascii?Q?oPu/kJAr8r2ZNJK5ZJHBjrXADi64Yrjh8ydzhhG5sb5OB4wz0+9f+6WZtwg+?=
 =?us-ascii?Q?u2DG8f7GJk0mnOZ7QTNPJyutVeqPo+sxTq4MgXUx343Tgd0R6XOMYlYtuFxE?=
 =?us-ascii?Q?9lz2epkauemFX3IEJfdk4cECAmvHvcR/C2NMcY6KjLEirB5Jc19l6N4+6k9G?=
 =?us-ascii?Q?Q0K+mVWt/u6IPivNFEJXE3bhy8cPB6Zh4RspohkVsXxu+wXDxxGLf1rj0VSG?=
 =?us-ascii?Q?2+tnPnXK9momm6lkniPoqq6NsIzf40jrA7c3R1r+9hEwGfqA3wNoc5OSVI3A?=
 =?us-ascii?Q?OnVBU6LzBwT+tDFMVm63mjYa53ug/PJZV2GKoJp4YeNTb2TGN4HOgcc6I0KV?=
 =?us-ascii?Q?szqLpxKBnmvX62CC6UEBijysqkuNhkw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2160a217-ab00-4e99-d929-08df3a99cee3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:33:58.6115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLq4+mKF2dSElq75HUmEzJhuqiZibocANZCNt7qdZ6ujL9Uue551bdMn74dJhVkZ/dGAaUqyHSCBRYw/XIdryVp94Cb9t6uQCs8KA3/2kAc=
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

U-Boot programs the L1 data cache stash identifier before entering
its C initialization code. The e500mc, e5500 and e6500 core manuals
define L1CSR2 as a 32-bit SPR with number 606 (0x25e) and reset
value zero.

Expose the register on all three cores, excluding e500v1 and e500v2.

Reference:
- E500MCRM (Rev.3), section 2.14.3
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.14.3
  https://www.nxp.com/webapp/Download?colCode=E5500RM
- E6500RM (Rev.0), section 2.11.3
  https://www.nxp.com/docs/en/reference-manual/E6500RM.pdf

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 target/ppc/cpu.h      | 1 +
 target/ppc/cpu_init.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0cbc55c470..0dea3a9d2b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2040,6 +2040,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_DSRR1       (0x23F)
 #define SPR_BOOKE_SPRG8       (0x25C)
 #define SPR_BOOKE_SPRG9       (0x25D)
+#define SPR_Exxx_L1CSR2       (0x25E)
 #define SPR_BOOKE_MAS0        (0x270)
 #define SPR_BOOKE_MAS1        (0x271)
 #define SPR_BOOKE_MAS2        (0x272)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7a569970bc..5db9ea8b70 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2965,6 +2965,10 @@ static void init_proc_e500(CPUPPCState *env, int version)
                  &spr_read_generic, &spr_write_e500_l1csr1,
                  0x00000000);
     if (version != fsl_e500v1 && version != fsl_e500v2) {
+        spr_register(env, SPR_Exxx_L1CSR2, "L1CSR2",
+                     SPR_NOACCESS, SPR_NOACCESS,
+                     &spr_read_generic, &spr_write_generic32,
+                     0x00000000);
         spr_register(env, SPR_Exxx_L2CSR0, "L2CSR0",
                      SPR_NOACCESS, SPR_NOACCESS,
                      &spr_read_generic, &spr_write_e500_l2csr0,
-- 
2.53.0



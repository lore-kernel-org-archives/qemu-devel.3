Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C84CA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD3BK-00020u-Dj; Sat, 03 Oct 2026 13:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39f-0007be-6Q; Sat, 03 Oct 2026 13:04:14 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD39d-0007Ds-Kl; Sat, 03 Oct 2026 13:04:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfuuaQcnUs24n4fnUsm8RAzBfQ0Ws7X6FZqHX6zf39H5md76mHNTuR3B+2gIIzKbdUp7tr1KJhp+M8zlxQJ2oEYxrhcY1X3o0MFriyT6BcAuOBm6pClyWwTNEn1Ra2zRbsAYSR62Tme+hQz/nXOqf/h34sxvDf0urBPuNMUsFwixcZLIwhoT6paeHvbPVrJZ3ztf0A//Udv0kFemQfM8gu7OADbIF0JT3R1dYzotsga6IhnbfoApl00oG26Js6es3jDngz/dTcgaxH4MP6P9OlRARGNaxB0SAM0iPbOyvVjeVCz2u7ya1/XWhw1lw2glKw3IcKEvF/N5T4hdjvhrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyegSpEclT/Np29h6ux1AGvjt3UF6zkvVcPA4v9hH3w=;
 b=ABnzfZ6rK7x/KUnpt3raJEyXM51QNNZk5MDGGGKU364vxI9tswNU2rMKzCk55EfwIMi1Ftb3io+VjB/3ShN9ISwHtRRgY1ZfjLdvg5/52q5fRD2rbOe5hw9Lhk09M1S3e6c0iEG3w5mqCEqZCyrXJt8r0JYZnPhS4fpf6GCFPv/uR2SfFahELSu4nQM4EM8OrsIZAml5MutivqACEJO3NzAsYLOPRbdPDQP1fGEZoC991rUalLEgKE41+ROy1653NazlGYwSgTCUAt1AtS3WfKyCbwNpHzOzfCMw7vn8BhyDS0S3dTfB/rY/gl2Hf/gDfijU0dmEzkhg5+JkopT84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyegSpEclT/Np29h6ux1AGvjt3UF6zkvVcPA4v9hH3w=;
 b=r1xBCmSZrXaTyTqrV6a2iqE3twNTG965Rkvy5Dks2mEJEEC/LjU9gppJrGpcYwS13GZo3QIYcSD9ifOZ2L6kKTeAAhLOrmi4IObnyFVJeAZEabqR+2YUlDB6H7zI/lRkpG1cHMiu5qoOgwF86nivG8OG/XCvYixgPqBlI9eqSv4h+GKwdF+TtkHqYewymN1cH4s/WM4mhMa9khEB5tqrdkm71qjGcGVqyfruhvxIYSezqtDlc+zhvOYf2DNvVlrFeCqamKw2vfQGehkOJvrNECHZN+PcDlQiGsT4QZOyBiysrOn3tFET6V/IKOU5/9Cl7LTMzGW6Gr6ek5qWp9LyXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB6993.apcprd02.prod.outlook.com (2603:1096:405:29::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:04:03 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:04:03 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-riscv@nongnu.org
Subject: [PATCH v3 24/27] docs/system/riscv: pfsoc: Document CLINT topology
 for direct Linux boot
Date: Sun,  4 Oct 2026 01:02:14 +0800
Message-ID: <20261003170232.2450916-25-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9165f7-0f86-4921-610a-08df21705364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|10067099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: bytOKZyF6szg+UiXNJmb8XMvz1gJwA4yjSmMHkRExO51gxvt7+RpAl1sJrmvozzkHfYHWE12WWJMRnKHSLev1x9318vA/zP0WOSyG6v7Dtm20tJRwXRiu52/ivAIovq8oGGrGlYyD2utTTLeO1FNZ3yedvm3N5pr+wUy1d06NXD49DxtEtLecVvKO169UMDPKu0yhFwzHdukkUvaQ2aZ9MV9RDbgqNwGryFbidBJEN/++NhODV63/BObwXF5zZBCRhghjwChZ2y/e2mUxO8e463cYE5heoxCnD2du5IiypnrBIjl13Qh42z24cjCEQsQjjUKUotynfmZ8UfB/5MxknpnlVOGdXSQsV2nC7I+rf86igqHyflnTU1PjJM3SMFB3PCZMTfQU6Nq0KPvq8G3RaKWlY7PjB8IzRMXV3/48lcV0bwPVwvBz0T5K2708Rp19+wzShEDxiN0oG2A8muwI+t3QYLxQ49d3l/fLXwuDVgTJu8iPxdxVaDUKXiAoWvavdvXGc/t2qA+GcYLoCRgx9iFANawGmIsHiG1pU6kTKATGhImrxIgxsLoK/cWMwZOpZqa2CeBUwQe95PE10bX5P7SUmniUI59sfN6NKUUs+sfc8HQsWueVvE0yu6q1CBzHwnWY76TBJqe0jdUGtM/Qw6wnAD3ZsMejnILAEYtg1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R2YsQBIi9TcsSKDPSvnDldbJpsjNuKgK5jbzZ6n77rC0AM08CsQI0txgWuhl?=
 =?us-ascii?Q?5PF0fijTpxTZlPbC9AYT3xgnB6FPvH1iSBVWuel/C9kiwlxmKN8Lsum04qMf?=
 =?us-ascii?Q?CBjZimqhKLnWIWan3aEtSQ1dcCkmvHN2Bwmain0Z5+9izoigwdmEYullaQLw?=
 =?us-ascii?Q?5rfkmX6FXYjOLV+S5KHxjdQVgLdQyAb2bXTMLjmKScK9GAIRJ01QKCqsS4gV?=
 =?us-ascii?Q?1FjJtRPKOalXlqXVN4uKr4Ot4xwNfwhcWzXZW+t3lKhG0YSlUzgy6KS/vSca?=
 =?us-ascii?Q?mQU1W8y3n9o+0ZDcKklMLLmsyc9u8Gc5PEBiQykd7mqAaKpQfDj57E3AXWSs?=
 =?us-ascii?Q?WUOvzsPIyMzWJVkXfpwqyjBKbTD+thc4f1Ak/8cqOveyf9Ma7uIIkHS3qD/8?=
 =?us-ascii?Q?Nu343dea8T0gknpRfmKNiwKFoZAhmumkG5BAkObrGVG5K9CAkc8qLEBJt6UU?=
 =?us-ascii?Q?hlwE7Nys50S01dmKSf5Lz0lqr4icPP4Fz1oyXo7cTUWa6jmZs2Inhey9J1u6?=
 =?us-ascii?Q?X4afzecRt0J45jRvuLrg3ktUPVRZm4kyoNfVX1ZYOQEvNk3Li1qgAbn+yJ7r?=
 =?us-ascii?Q?YZZIE1KestMSO2qLKr/pDUAmwdPwYr4sH+5PQ/RTATnuBN1RLWsWhCibEASV?=
 =?us-ascii?Q?hmxALYNDAhCFlLKcbUip33qDUgZrmpDMv/h4MgT1zxGriYFs8lvzyaI+azxe?=
 =?us-ascii?Q?HCrvtMYhgS2lTcuwmmq0YF3X5ov75TxvWrEQmfeoX7v3mloall7E4II6J4z4?=
 =?us-ascii?Q?vH1SqvaKQnL7f3SzweFTr7bzsRVasEkqA/sJ3PDmMsmm9ok/3eB9IJb4W3ix?=
 =?us-ascii?Q?EAt4TUyi/3I6BBL5Q2ahccyEmH8XoMybSv1knPI98idTPg7YxZ03ZLoc+JN6?=
 =?us-ascii?Q?n68Vy+411lD8/+Yb2fkn8lwL3WXOhb9t/iupnxT5e4w+VnWMwta3i+PD29Y5?=
 =?us-ascii?Q?0mEA0IsMvwuY32+pnisJj88HsQGWKzzbdSTd+NoTeMeDGvCwC/Cdo8pjX/QJ?=
 =?us-ascii?Q?TPeDbZjAay6M63u3PhRhZXbk9BvJsSGb+werVTVsQjcSEvxtT7iLm6FjHKDQ?=
 =?us-ascii?Q?6cbr5YHYX5UR807OmC++wvx8atpTi1d26/suWglcyCM1WTnbAEZheDR+EFPS?=
 =?us-ascii?Q?Y+i+cBjv1mX7CiqBIPPgywhsoegHKrluss4xSOhV79KLMwyGkdK7PfKXYADA?=
 =?us-ascii?Q?FIpRHYNTbTO35uruc03Z+6lXTtmY0tcI6kqGMwNWNiTvUJzoZ1Ba7fzFRz3i?=
 =?us-ascii?Q?v8TvsB/d44jPFWK0ILRQT6Putfrbr1zyc+zSp+rLrj0fSwALv3rUeJrA71kn?=
 =?us-ascii?Q?9QMJHEkkDYSUiPaFOi7Kn/YtOyO74j1o83neZ9cfGfo4LBEMd/HADgEoBggD?=
 =?us-ascii?Q?qICPuExwoQ9YIo2ydQ8mX4bcbNv4afA06xFA6UQiNCZGnwCaX1qTbnXvHLrH?=
 =?us-ascii?Q?EmFoZ8ZDyqgVBE1eQZ/mcANbaeW4LvvRiMj/Vo+hcwMtvdIcyVAN/h3qQ2eb?=
 =?us-ascii?Q?r0lJr88LMycE4B3ensn2bCemolnP/QAEKv1kx8jBKK/IqFQV+5Qed5cu1O0Y?=
 =?us-ascii?Q?LpEAq99vlUKXEqCGvwRgL+8k4k67X9zDrBY1Vf61tJpJwWXyT1j4dZeyIU6i?=
 =?us-ascii?Q?QD/oAUpKgu0bzLA5fbA6G1hG/X40ODsRKxyP1r4wQf2N2WPFMrgy11scJJp+?=
 =?us-ascii?Q?PDm1jgXprImVh0Zro9HH9NXvES0nM0Dq21ZBL4SMTDdjHCK+Jd8GTPuMfj54?=
 =?us-ascii?Q?yZPraRHzeS8rYC/KKZ0TahFBZo8NMlU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9165f7-0f86-4921-610a-08df21705364
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:04:03.0310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yB4x6ag3uqkYYlKOt2VH/KmaxVhUCV7Ab6gGM3MrreTaw+FJkCxqJjmRStucn0JHsIk6gjSI7/J4gA6Eq9Q8lo+Kn0+GvS2i5JIziWj43X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6993
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The generic OpenSBI platform derives the CLINT first hart and register
slot count from interrupts-extended.  Some S-mode-only MPFS device trees
mask the E51 M-mode interrupt entries with 0xffffffff, which shifts the
MSIP and MTIMECMP slots when the same DTB is used for direct boot.

Document the complete five-hart CLINT node. Require interrupts 3 and 7
for hart 0 as well as the U54 harts.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v3:
- Explain how reduced hart topologies change the CLINT DTB tuples

 docs/system/riscv/microchip-icicle-kit.rst | 26 +++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 9fde3f1073..cc6afbca36 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -66,7 +66,31 @@ should meet the following requirements:
   option.
 
 * It should contain a node for the CLINT device with a compatible string
-  "riscv,clint0".
+  "riscv,clint0" or "sifive,clint0".  Its ``interrupts-extended`` property
+  must describe the M-mode software interrupt (3) and timer interrupt (7) for
+  every hart, including the E51 hart 0.
+
+For example, the default five-hart Icicle Kit CLINT node can be described as:
+
+.. code-block:: none
+
+    clint: clint@2000000 {
+        compatible = "sifive,fu540-c000-clint", "sifive,clint0";
+        reg = <0x0 0x2000000 0x0 0xc000>;
+        interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+                              <&cpu1_intc 3>, <&cpu1_intc 7>,
+                              <&cpu2_intc 3>, <&cpu2_intc 7>,
+                              <&cpu3_intc 3>, <&cpu3_intc 7>,
+                              <&cpu4_intc 3>, <&cpu4_intc 7>;
+    };
+
+When selecting fewer harts with ``-smp``, remove the absent hart nodes and their
+CLINT interrupt tuples from the DTB while retaining the E51 hart 0 entries.
+
+Do not replace the hart 0 interrupt numbers with ``0xffffffff`` when the same
+DTB is used to initialize the generic OpenSBI platform.  OpenSBI derives the
+first hart and the number of CLINT register slots from these interrupt tuples;
+masking hart 0 would shift the per-hart MSIP and MTIMECMP register mappings.
 
 When ``-bios`` is not specified or set to ``default``, the OpenSBI
 ``fw_dynamic`` BIOS image for the ``generic`` platform is used to boot an
-- 
2.53.0



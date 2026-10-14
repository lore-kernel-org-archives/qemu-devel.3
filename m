Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A0BCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnkT-0006cn-TI; Tue, 13 Oct 2026 21:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjn-0005rq-Et; Tue, 13 Oct 2026 21:25:03 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjl-0006vY-Dm; Tue, 13 Oct 2026 21:24:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSi+sCZTU/s6C4ojkOsn1EhUuTYeVt8uJY8I8uA5O62IGPtRk0tCRui/mL6OtP3B8bCAN1NpTuHj9+ioc8t7fp0Bn2H5m+VOWdpuVKuzDnOKc9zlQn/e4tpDmr9pVdHSuW5ff/Dw6j970IB1Wo2V9guJDSVKrkDBWCYb6AZ6ljexpn5FQbpO5wkPfr8V0rfodDX7H/PMHR0RfV3dDxdydhMzWZO6+Hep/I1LZMO/msJ76rfZakA/OpujuKpEZk3/KaXFnECJPV6AFjgLvHfZs6fJONow7by73zL3OdAKMAV8YB6qt1EGwQwuLl8RrnkX/Zp0IOazELs1X6iYiyDp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hhcrfaMIxBzNW58DJPGFj5sqgDjiafTfdqDdn+p+2c=;
 b=STK3348RYZmS81w3c5ykzVT+0Js9qkYk2Ev8MKTwrXk0H2SmC1LTFNZBJKQKKioXDtfJIuILULSmm6jWBmIc34GGf/BnXbUTaryr+4K/wt5W+6JFH7RBlQ/nQUpr7TrCG3DqMUma7Ql6mDlO04LWlY+AXDTr7pPQXoW9L8SS0CcE3rdsO4HbNGETMJiAWjn4kH67RftpvmDm2AtHtO+EN0zpFmmEmoSrnvZCNAVp8H1t/WLxNCQFPvmW0GNPxr+zvWf9P/pwTKgxBfhGvYdgFY8nX+lW3saBkzkdV6pFhoAAnEvFPJ+WKOxA43F+hvdREIfQoIEea7T30oGpQ/q3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hhcrfaMIxBzNW58DJPGFj5sqgDjiafTfdqDdn+p+2c=;
 b=jPpArE4w+P948Q3U5C+HXzIBRA8mR0QTDHaIk5Nk+LodncFev0J4LhP0ZRVIQa8FrE5J5feL/zsnbqh99zE23lY7nhLnB6mcgDW9C6bKaeydBIcovmjXcjyPudnW3Co0vi9edG/6wwGxIvOZOZ9ckIE1Mzjnio4eg9EMltgtERVqVUdQ9E9PD/bV8FtPwq3Hp1q0xZ3X6AKIcr2P3hhC8qxI/WH6U08J7xcgUXPg6x80OPTtOrxlBHgDRQ8ylUnZcVfaKKi+FGvWspr/fkx1rBLCLsEY+HVZUI6bKCiA8q4gVlYAFuDbRspvzE8/uiPMRWI2PikiWz+RtFoHSqHT2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:37 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:37 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
Subject: [PATCH v4 19/27] hw/misc: pfsoc: Let IOSCB own service interrupt state
Date: Wed, 14 Oct 2026 09:22:59 +0800
Message-ID: <20261014012323.322790-20-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: cc47dca1-01b3-41f5-38e2-08df2991e95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|7416014|18002099003|22082099003|10067099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: L8DPMGMgVMk2hXlydRNMZy5e5M9WLy9MrMbUqHsYOG7keqvPtIR+m+XmJVVGCD71ErmBuQggramZeIlM3lWukhmkcwQGxaK3B5zF1UWM1hCtDnlIDWvjtrHrpHjwPom3eQCSvx/n5M7S6xTSLXTq463sOQTqNXVogSO5hmpy5Sw31J+GJUynGhiErBJ1YNWjSQRpWliQWAxmooLjCOMNhEf0uj4aYXxmdOYD1CZEZdIDagLnhFOBrIc2gj5YkZztn3d7oTDC3Mxw7v6tGOvLFNm/wn8ZUYKZm0HSsgG5G4cNpRL/prsST2vD2o5zVgaVUazbKIux0ns7k61AXA/AsLrzIno7/dFprOZKkdeftMv2HHZ8TSIuc0VRRLkuRJDc6rny2S/xkPMRJ5BHyiUBSbNXKJj8CXurjyqMgNF94w+UE0JU/GJxwbAjOjT2Tv16HKEeDUYWZaTBFX1tApzbqAvDhEHky+J+66ggsv7PXGwwpPTjncjR1P4w4kQH0kM3wIMuiY8G7tvBO53hmScSj2YVrab1eMrGGGgL/q5XxRGjuK+gH3j7E1K18aZw98bEZDHG+97d55ziqgdErYyrThzg2evcuT8Zrw3AjuWvdSOyQCbCqHTsXrhul2RrcmzowHaTLtzZEqLdq0PIPWX77quKFF0sGMo/5M3RcZns/ZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dC2SKYYv2Y4L6Py04Ps2V4qrHJjeiuT/rtE0wUyJwJM+AsoNy/t2mR1AqmH?=
 =?us-ascii?Q?zVWZocXZJXH1/iHoeg57agE2UVrrQYdb7pP8uPFKgWSR09lkVJ/3ZTLnJo8o?=
 =?us-ascii?Q?4eKM21scZBtXqowrZxrxSUn+R6qo1LsAfDr37pf6zctbVYFrPAl4qFTLOMar?=
 =?us-ascii?Q?+oTOsMNNRhzlXEcJpydvo1Mfr/BURbOoP1F6QOtw5Tw/j7DYgGbxLnW8ywEO?=
 =?us-ascii?Q?9le0s2BQNGGwq/kgej6ICc99U56+5TUxGyEBoPz5TcQghxsvIXv1575NPNm0?=
 =?us-ascii?Q?I6COYHdSOpiohFuMLrkl/butqTSZKD3dKnduQsiXgrQ91abGYQ7KC+GSll8L?=
 =?us-ascii?Q?jjmvxPVnapwocZEEBuA0hEVft6g6VIUI/H9xBF41vcA/KkVnzyJudJ+f1w2M?=
 =?us-ascii?Q?r+EjEClRqHcxQsyt21HHfOPOtAyhX0L7xB2AVN/PJJ0pqpGM4RaJfUlv/D8Q?=
 =?us-ascii?Q?iRqJnlltYxCoPej9dDK0GS6srU9xbmj6LI8lx8CXPxj7+1DvezSoRWCTpFUu?=
 =?us-ascii?Q?HpkXshLp2ooY9ghAnPvggxSkMJ1zWpMqB36k7BYFhYfXENfBM9IHFmRtmpHc?=
 =?us-ascii?Q?2Bw8IpaIX0ZN/J8m2hO8fV6Kgfh9XErSX5i2ojfx2vPbn6XzAInyzXx5+ecd?=
 =?us-ascii?Q?8DmrYRBQce4PorbHMupF8odgoqP8LluoBzKEhcjCyTGoh3wLxONaI2aUnmWv?=
 =?us-ascii?Q?dAlF1clIlibx+tcY0ThfJGdNI5UWpKeGXRzP0kbH6jT51CASn9VdkNxD78vd?=
 =?us-ascii?Q?+uAT69plDmzV1W/jGRt4pkiFVST7wFsPvKYIyc6uW7p6cdIrBVuVlB9WO4QL?=
 =?us-ascii?Q?oJPjPV9fKvdjyJKWqDN43W+ddP43gkFAOVIhoyVqwkO0ObzI3x+yMuWGi1YX?=
 =?us-ascii?Q?POyYJkcpW011ckwqxx+UH7Te+ee5tfqtMP+/z8+wBfVCa81g2E3CGDGcC4wL?=
 =?us-ascii?Q?g9ASBCVSz2bsu+x9XlfLZk03n7LeIjbdv8+UrxunokQVa2Kdfjkxl41Z/4au?=
 =?us-ascii?Q?MqaK6fMiUCH9JaumQGb9H6KwIjDr7vy27D9xm+cJuIEAWgRkKpWsHbWGxwgw?=
 =?us-ascii?Q?iKuyts/hoT7dkOk/lA4IKdijNg81cMQUyuuUM9Gte91MFJwQRS/dGdznzFt5?=
 =?us-ascii?Q?0c/kiQZGsSbUX1mEVn1IQ/njwu8ivKgcYcnAjgBEmMdTOU5l5eLGmIXYKBum?=
 =?us-ascii?Q?2WCMPKZPR6ft1MCV3Voy3eIutl7SLRkpIonILBfF6rW/ARVQQFdATSjjqJ36?=
 =?us-ascii?Q?xys886Nk1wVYGs3QnGul3jkwhY0Sx0UC7XvzNGrShwcokOFmpg6RCI3DdTHq?=
 =?us-ascii?Q?xwci7VxFxPXSv8rrTuwZTh7W2KFriufAV0LUWWUpoXdu1k7vBY4+lfkXuJrL?=
 =?us-ascii?Q?LGR5EHMMdWx90JZmMqbDEJa6p/Sa73Y1YN2RYsFQqPMf0l4tsUi8HTNvKAim?=
 =?us-ascii?Q?c8/T03UAXbzomSUwtTarKS54RhAnxlUbiX4TMKtW2puXx2Yb4VqIjlmWW0HJ?=
 =?us-ascii?Q?mjnkeK0R70FPm6YpJR4NF2ozV5YKcCq8h36FCmhh7cL4jGSYBZ9ZFyuvV/tV?=
 =?us-ascii?Q?Td5HtcxuwFNzh0zzRbQr+bMM3VHP+4DqL+4MBhA0rrqXadSOcN8J3+h/emEZ?=
 =?us-ascii?Q?JirTbPiP10gbzcP7ItB20C8NreF4dJ+/dGyyKnXpfCEKaSAC73UWlB6BOwJi?=
 =?us-ascii?Q?cBRfmc5el8eK3ExXctwE+AAAzcpHmpBBax09GkhNrVgi1Zeob+likHU7yzVF?=
 =?us-ascii?Q?IGawBCUoMBi0dSSJnkbQm3JhK8n1Fyg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc47dca1-01b3-41f5-38e2-08df2991e95c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:37.3543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmkqFu3S3+RbiESKgoVBZ1YmIMmacy5XRHi6Y7Z75cIe8dMSXPQ4XAQT8NbrPJ1tb2ptBXERsYSdtb+BVbsknPncrB+kB2yAiYHDaZLCtJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

System service completion raises PLIC source 96 from IOSCB, while
software accesses MESSAGE_INT through SYSREG. The MESSAGE_INT pending
bit is not modelled explicitly, so reads return zero even when a
service interrupt is active. Model the bit so service completion and
register accesses use the same state.

Keep the pending state and PLIC output in IOSCB. Link SYSREG to IOSCB
so MESSAGE_INT reads the current pending bit and writes update the
same state.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

---

(no changes since v3)

Changes in v3:
- Separate interrupt state ownership from the NOTIFY fix
- Link SYSREG to IOSCB for MESSAGE_INT reads and writes
- Support both clearing and setting the MESSAGE_INT pending bit

 include/hw/misc/mchp_pfsoc_ioscb.h  |  4 ++++
 include/hw/misc/mchp_pfsoc_sysreg.h |  3 ++-
 hw/misc/mchp_pfsoc_ioscb.c          | 20 ++++++++++++++--
 hw/misc/mchp_pfsoc_sysreg.c         | 37 ++++++++++++++++++++++-------
 hw/riscv/microchip_pfsoc.c          |  5 ++--
 5 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
index aa108d2d88..e8386f9794 100644
--- a/include/hw/misc/mchp_pfsoc_ioscb.h
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -53,6 +53,7 @@ typedef struct MchpPfSoCIoscbState {
     uint32_t services_sr;
     uint8_t mailbox_data[MCHP_PFSOC_IOSCB_MAILBOX_SIZE];
     char *serial_number;
+    bool irq_pending;
     qemu_irq irq;
 } MchpPfSoCIoscbState;
 
@@ -61,4 +62,7 @@ typedef struct MchpPfSoCIoscbState {
 #define MCHP_PFSOC_IOSCB(obj) \
     OBJECT_CHECK(MchpPfSoCIoscbState, (obj), TYPE_MCHP_PFSOC_IOSCB)
 
+bool mchp_pfsoc_ioscb_get_irq_pending(MchpPfSoCIoscbState *s);
+void mchp_pfsoc_ioscb_set_irq_pending(MchpPfSoCIoscbState *s, bool pending);
+
 #endif /* MCHP_PFSOC_IOSCB_H */
diff --git a/include/hw/misc/mchp_pfsoc_sysreg.h b/include/hw/misc/mchp_pfsoc_sysreg.h
index c2b3688a94..d6c9027f2d 100644
--- a/include/hw/misc/mchp_pfsoc_sysreg.h
+++ b/include/hw/misc/mchp_pfsoc_sysreg.h
@@ -24,13 +24,14 @@
 #define MCHP_PFSOC_SYSREG_H
 
 #include "hw/core/sysbus.h"
+#include "hw/misc/mchp_pfsoc_ioscb.h"
 
 #define MCHP_PFSOC_SYSREG_REG_SIZE  0x2000
 
 typedef struct MchpPfSoCSysregState {
     SysBusDevice parent;
     MemoryRegion sysreg;
-    qemu_irq irq;
+    MchpPfSoCIoscbState *ioscb;
 } MchpPfSoCSysregState;
 
 #define TYPE_MCHP_PFSOC_SYSREG "mchp.pfsoc.sysreg"
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
index bde1917c10..1f77da6852 100644
--- a/hw/misc/mchp_pfsoc_ioscb.c
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -209,6 +209,22 @@ static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
 #define SERVICES_STATUS_SUCCESS             0
 #define SERVICES_STATUS_FAILED              1
 
+static void mchp_pfsoc_ioscb_update_irq(MchpPfSoCIoscbState *s)
+{
+    qemu_set_irq(s->irq, s->irq_pending);
+}
+
+bool mchp_pfsoc_ioscb_get_irq_pending(MchpPfSoCIoscbState *s)
+{
+    return s->irq_pending;
+}
+
+void mchp_pfsoc_ioscb_set_irq_pending(MchpPfSoCIoscbState *s, bool pending)
+{
+    s->irq_pending = pending;
+    mchp_pfsoc_ioscb_update_irq(s);
+}
+
 static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
 {
     uint32_t command;
@@ -248,7 +264,7 @@ static void services_cr_write(MchpPfSoCIoscbState *s, uint32_t value)
 
     s->services_sr = status << SERVICES_SR_STATUS_SHIFT;
     if (value & SERVICES_CR_NOTIFY) {
-        qemu_irq_raise(s->irq);
+        mchp_pfsoc_ioscb_set_irq_pending(s, true);
     }
 }
 
@@ -339,7 +355,7 @@ static void mchp_pfsoc_ioscb_reset(DeviceState *dev)
     s->services_cr = 0;
     s->services_sr = 0;
     memset(s->mailbox_data, 0, sizeof(s->mailbox_data));
-    qemu_irq_lower(s->irq);
+    mchp_pfsoc_ioscb_set_irq_pending(s, false);
 }
 
 static const Property mchp_pfsoc_ioscb_properties[] = {
diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
index 1d9154280a..4c52338c8a 100644
--- a/hw/misc/mchp_pfsoc_sysreg.c
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -24,20 +24,22 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
-#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "system/runstate.h"
 
-#define CLOCK_CONFIG_CR 0x8
-#define RTC_CLOCK_CR    0xc
-#define MSS_RESET_CR    0x18
-#define ENVM_CR         0xb8
-#define MESSAGE_INT     0x118c
+#define CLOCK_CONFIG_CR     0x8
+#define RTC_CLOCK_CR        0xc
+#define MSS_RESET_CR        0x18
+#define ENVM_CR             0xb8
+#define MESSAGE_INT         0x118c
+#define MESSAGE_INT_PENDING BIT(0)
 
 static uint64_t mchp_pfsoc_sysreg_read(void *opaque, hwaddr offset,
                                        unsigned size)
 {
+    MchpPfSoCSysregState *s = opaque;
     uint32_t val = 0;
 
     switch (offset) {
@@ -56,6 +58,10 @@ static uint64_t mchp_pfsoc_sysreg_read(void *opaque, hwaddr offset,
         /* Indicate the eNVM is running at the configured divider rate */
         val = BIT(6);
         break;
+    case MESSAGE_INT:
+        val = mchp_pfsoc_ioscb_get_irq_pending(s->ioscb) ?
+              MESSAGE_INT_PENDING : 0;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
                       "(size %d, offset 0x%" HWADDR_PRIx ")\n",
@@ -77,7 +83,12 @@ static void mchp_pfsoc_sysreg_write(void *opaque, hwaddr offset,
         }
         break;
     case MESSAGE_INT:
-        qemu_irq_lower(s->irq);
+        /*
+         * MESSAGE_INT bit 0 is read/write: writing zero clears the interrupt
+         * and writing one sets it. IOSCB owns the state and PLIC output.
+         */
+        mchp_pfsoc_ioscb_set_irq_pending(s->ioscb,
+                                        value & MESSAGE_INT_PENDING);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
@@ -97,20 +108,30 @@ static void mchp_pfsoc_sysreg_realize(DeviceState *dev, Error **errp)
 {
     MchpPfSoCSysregState *s = MCHP_PFSOC_SYSREG(dev);
 
+    if (!s->ioscb) {
+        error_setg(errp, "The 'ioscb' link must be set");
+        return;
+    }
+
     memory_region_init_io(&s->sysreg, OBJECT(dev),
                           &mchp_pfsoc_sysreg_ops, s,
                           "mchp.pfsoc.sysreg",
                           MCHP_PFSOC_SYSREG_REG_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->sysreg);
-    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 }
 
+static const Property mchp_pfsoc_sysreg_properties[] = {
+    DEFINE_PROP_LINK("ioscb", MchpPfSoCSysregState, ioscb,
+                     TYPE_MCHP_PFSOC_IOSCB, MchpPfSoCIoscbState *),
+};
+
 static void mchp_pfsoc_sysreg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "Microchip PolarFire SoC SYSREG module";
     dc->realize = mchp_pfsoc_sysreg_realize;
+    device_class_set_props(dc, mchp_pfsoc_sysreg_properties);
 }
 
 static const TypeInfo mchp_pfsoc_sysreg_info = {
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 36c894b677..38f4e7d799 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -315,12 +315,11 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SYSREG */
+    object_property_set_link(OBJECT(&s->sysreg), "ioscb", OBJECT(&s->ioscb),
+                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysreg), 0,
                     memmap[MICROCHIP_PFSOC_SYSREG].base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sysreg), 0,
-                       qdev_get_gpio_in(DEVICE(s->plic),
-                       MICROCHIP_PFSOC_MAILBOX_IRQ));
 
     /* AXISW */
     create_unimplemented_device("microchip.pfsoc.axisw",
-- 
2.53.0



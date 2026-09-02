Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504AAC624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1oOL-0006sa-5n; Wed, 02 Sep 2026 13:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1x1oOJ-0006sO-Le
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:04:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1x1oOH-0004oc-Gn
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:04:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682GfpT72324964
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 17:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=MLfmnrBBCUz1KlGa4eVPoHcBfJSPndnMv7t
 Hs6PtPOw=; b=Mdwnc22bHVLrwTXgHio2UmUt3WfYLfPeXOSpi2SZN0WjRhQRJxB
 agiJDzQi/lNaPidH2HIqjluCCclIVQaunLfMImphl9egLKq+PdhkB5IWvDQNSkeP
 PTIEpshf9QVmhyUkLYTF80FuZuanaTCFJzJokM6SnYjQfjWT4vxnwatByJJmva4V
 cO9dngb4UpLHbjEztXGtsL1d7kzzAaajsedaYvpMaoFNTIV/w0Kccqtk2vNpkt2G
 rtXI5rYEaeApfw3pLs2jCkTpPccTy93ykBcv4MvwN8aNaTktdRb8oRSnfjF5Pa1i
 LfjJdloPdMD8fnRzbqVnZBUCYWJY2cLKZQQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh8wa5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 17:04:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso94466a91.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788368686; x=1788973486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MLfmnrBBCUz1KlGa4eVPoHcBfJSPndnMv7tHs6PtPOw=;
 b=Uv0pFHOiMMRI7Cz3O/d4IX4YljwCEAduG6AptdR68AZSf0p1kW7/FExWQpfYSC/Snf
 yIzdj4J5UdadDdrLSsSGyk4SNsUxZ6Tv/XvwF6j/AYe2tC+vRDHH/iAH3R8r/9Bje9MH
 Hyj1LYat2nkOPDVejWj5NkjePFgS8zcJ5BlS93o4SLBZLu/gfLd3qvTWyFPoU0sk6FIu
 Zzp2JnGfLO+f2Ezvb2gf6ezcciFgfwxvbcwIe2LxP9oNnhHv4IBY8WKwAd1HS/+yuEiX
 Fz1ljsOTRdXS14+rPOiPaTK1Yjhd80g3MkaKlyxdTO1UFrL+cnBV4CM4WdCJsnIXjN3h
 fqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368686; x=1788973486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MLfmnrBBCUz1KlGa4eVPoHcBfJSPndnMv7tHs6PtPOw=;
 b=UqakA7Y66Mhf+zBlRgw9YBYBlfpHdb1kLURcmFE4nE/+lWa3dxHM6UxXe17ssurVHx
 yhhqnHsO/++rJ9n57ezinAfInaqNwQtBjDQutv6LjuflsXQ7L7kBOgm3otK+xg2cBUdc
 uPEyYEbjzFHaG4hxcporM57vPYfKl+zrJatJTDCFPjJ4jQuaXGDdEAPyHmp1eo8jgKOR
 f9BKrfhqBet/CMerQWYFgKIOvumNK1FwYhpdCk9Ut8n6pEgICiAE3lqb15YxsEzK8W0O
 6sF36aeWOb1xA8jX96YnHXeqrQOtet2wv5aeRQ3cD7GxnqYgVi0aKZNPRGYK3LY5AIZ3
 D+tw==
X-Gm-Message-State: AFuF++mrio4Y+gcgBzKDf9iDRJDIxbzHhGznApZEC1lpLJRmcElhTx35
 PhaEqd3eB3eIFb1jDrhS7bb1sSj351S57yD6Lyfnh3+7IYWBnivpXULAlx9M7HxBSNn4T3g3Os9
 fNVmLXtzBszaxbyig2T3Zl6wXLlGMK2QsThlaHXgSn5f3c4bxUZNKBWfshhYNqMDrBw==
X-Gm-Gg: AYBFou18F3OJPs2d0txIFa0obu66aZ4N5p2NB7OyRpTKTdZJMiBKi+kATDNovmfT5BD
 7UEiVKRmgpPxe2JOzL5P8Ngvd30DLNSOSWWJrlKs4KnHipCoWw05VvPZlZio2MXQ29PHU8OJDV/
 lWh5lhl8KVgXaZLYD4kcXZf5oU1WgIima2QbFtli+1SMrOAKha8iKFurqHJ/oiBcwSIVgULytwI
 oBMrM90XEhzS5maVh9ZFdAh+c8RFP1YzFGI64dgGZReGzzeSZaSBSa87Iu9zcJ5Q+t+lOpIcwE3
 WfbjMWT7/pmF3WGrg0UcfPA9eWErHx/qAxLVLtmEV/mBFaAXz1EGj23+Jf+u71Q3pePVBi5SrAG
 c6heHAMssxOK2Bg58hgSecJaQ9jbTqiIdsF/tfcmTYeR4NJGSOWDOJRczOczfC1Y=
X-Received: by 2002:a17:90b:5242:b0:381:10a3:8b10 with SMTP id
 98e67ed59e1d1-39b08046aaamr716463a91.14.1788368685889; 
 Wed, 02 Sep 2026 10:04:45 -0700 (PDT)
X-Received: by 2002:a17:90b:5242:b0:381:10a3:8b10 with SMTP id
 98e67ed59e1d1-39b08046aaamr716356a91.14.1788368685124; 
 Wed, 02 Sep 2026 10:04:45 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1430eb227basm8665200c88.13.2026.09.02.10.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:04:44 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v2] target/hexagon: add OPEN/READ/CLOSE DIR semihosting
 operations
Date: Wed,  2 Sep 2026 10:04:42 -0700
Message-Id: <810448a08da00bd2e1debaad949cdea5b1cd0059.1788368635.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: C6_hM9zVGfwTIy-aeQ6oTn8JXEYGGkxv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MCBTYWx0ZWRfX/1mNA/rfqoWV
 Fvsh5rGkCIe8j72LgWxPMkL6VbJagQ0bKAppAN5EBN0bPiTUjY1WGe69HXbBNdXMQ6CRiIdw0Rd
 7KkItLWICCxDgDKanrXGbZawavLBMyDkWCFAsWEQEdPUGP18LNm1boV/tP1tcAU6cvb7rVs6S86
 7SzM3oykeEMYZFWw1iR6P9MMROfXNvXbQF0igtWNOEiM4lyn/Fn0fJ/0MHezHXW6Do8m6pW7gK4
 2Mq1WPgYsgodxeQzsg/t9fysxfYMRUCDPMFv+2RiQIFzMKasTlv/EVz4P/E+2lwCInf7mNsyf2I
 QoV18jMG0Qkzf90cwTsBtdrYcyPNV1y9Udul3q+BoBUEbee+Q8c8CrxtXjRXKxrlsLBPQTqV/Tb
 VF9hPn5ybMm5nCRyHxXTdJDwFPHVc2QZ7Cqw244V9rqpkn4/zT1z4wTXzgacRM8K5n5RGOYF/1G
 QSJQLzZwLN3bRFS3ZsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MCBTYWx0ZWRfXxy+zetcXQmg+
 0jJTwClmauYW2WVbzc+RCB3OqxJws+kbbSI4YzErLashu33DUXVxbiclO+DKFYIstktnrvOPoQL
 m1qy5VtNPOD9iXzkP8IfEyU37fmFvW8=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a98572e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dbyEXaId37MxV82b3ZAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: C6_hM9zVGfwTIy-aeQ6oTn8JXEYGGkxv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020150
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Baremetal Hexagon programs use semihosting to enumerate host
directories via OPENDIR, READDIR, and CLOSEDIR calls. The list of
open directory handles are global to all CPUs, so that guest
index values map back to host DIR pointers across calls.

Also add functional tests for the new semihosting ops.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
v1: https://lore.kernel.org/qemu-devel/9823f67f-bfc6-40e2-ba3e-cb02e53a4004@oss.qualcomm.com/

Diff from v1: defined the dir_list inside the new HexagonClusterState,
as suggested by Phil.

 hw/hexagon/hex-subsys.c                   | 32 +++++---
 include/hw/hexagon/hexagon.h              | 14 +++-
 target/hexagon/hexswi.c                   | 94 +++++++++++++++++++++++
 tests/functional/hexagon/test_systests.py |  9 +++
 4 files changed, 137 insertions(+), 12 deletions(-)

diff --git a/hw/hexagon/hex-subsys.c b/hw/hexagon/hex-subsys.c
index 4e3a418340..f76f803dfb 100644
--- a/hw/hexagon/hex-subsys.c
+++ b/hw/hexagon/hex-subsys.c
@@ -98,14 +98,11 @@ static DeviceState *tlb_create(HexagonCommonMachineState *hms,
     return tlb;
 }
 
-static DeviceState *cluster_create(HexagonCommonMachineState *hms)
+static void cluster_create(HexagonCommonMachineState *hms)
 {
-    DeviceState *cluster = qdev_new(TYPE_CPU_CLUSTER);
-
-    object_property_add_child(OBJECT(hms), "cluster", OBJECT(cluster));
-    qdev_prop_set_uint32(cluster, "cluster-id", 0);
-
-    return cluster;
+    object_initialize_child(OBJECT(hms), "cluster", &hms->cluster,
+                            TYPE_HEXAGON_CLUSTER_STATE);
+    qdev_prop_set_uint32(DEVICE(&hms->cluster), "cluster-id", 0);
 }
 
 void hex_subsys_create(HexagonCommonMachineState *hms,
@@ -135,7 +132,7 @@ void hex_subsys_create(HexagonCommonMachineState *hms,
                                     &hms->vtcm);
     }
 
-    hms->cluster = cluster_create(hms);
+    cluster_create(hms);
     hms->l2vic = l2vic_create(hms, m_cfg);
     hms->qtimer = qtimer_create(hms, m_cfg);
     hms->glob_regs = globalreg_create(hms, m_cfg, rev);
@@ -144,7 +141,7 @@ void hex_subsys_create(HexagonCommonMachineState *hms,
 
 void hex_subsys_add_cpu(HexagonCommonMachineState *hms, DeviceState *cpu)
 {
-    object_property_add_child(OBJECT(hms->cluster), "cpu[*]", OBJECT(cpu));
+    object_property_add_child(OBJECT(&hms->cluster), "cpu[*]", OBJECT(cpu));
     object_property_set_link(OBJECT(cpu), "global-regs",
                              OBJECT(hms->glob_regs), &error_fatal);
     object_property_set_link(OBJECT(cpu), "tlb", OBJECT(hms->tlb),
@@ -158,10 +155,10 @@ void hex_subsys_realize_cluster(HexagonCommonMachineState *hms)
     /*
      * The cluster must be realized after its CPUs have been parented into it
      * (see hex_subsys_add_cpu()) but before any CPU is itself realized, since
-     * qdev_realize_and_unref() on a CPU latches cluster_index into the TCG
+     * qdev_realize() on a CPU latches cluster_index into the TCG
      * cflags at that point.
      */
-    qdev_realize_and_unref(hms->cluster, NULL, &error_fatal);
+    qdev_realize(DEVICE(&hms->cluster), NULL, &error_fatal);
 }
 
 void hex_subsys_realize_cpu(HexagonCommonMachineState *hms, DeviceState *cpu,
@@ -173,3 +170,16 @@ void hex_subsys_realize_cpu(HexagonCommonMachineState *hms, DeviceState *cpu,
         l2vic_connect_cpu(hms->l2vic, cpu);
     }
 }
+
+static const TypeInfo hexagon_cluster_type_info = {
+    .name = TYPE_HEXAGON_CLUSTER_STATE,
+    .parent = TYPE_CPU_CLUSTER,
+    .instance_size = sizeof(HexagonClusterState),
+};
+
+static void hexagon_cluster_register_types(void)
+{
+    type_register_static(&hexagon_cluster_type_info);
+}
+
+type_init(hexagon_cluster_register_types)
diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
index 3d7b3cb12d..bdb95b1819 100644
--- a/include/hw/hexagon/hexagon.h
+++ b/include/hw/hexagon/hexagon.h
@@ -11,6 +11,7 @@
 
 #include "system/memory.h"
 #include "hw/core/boards.h"
+#include "hw/cpu/cluster.h"
 
 struct hexagon_board_boot_info {
     uint64_t ram_size;
@@ -148,6 +149,17 @@ struct hexagon_machine_config {
     union hexagon_config_table cfgtable;
 };
 
+#define TYPE_HEXAGON_CLUSTER_STATE "hexagon-cluster-state"
+OBJECT_DECLARE_SIMPLE_TYPE(HexagonClusterState, HEXAGON_CLUSTER_STATE)
+
+struct HexagonClusterState {
+    CPUClusterState parent_obj;
+
+    struct {
+        GList *dir_list;
+    } semihosting;
+};
+
 #define TYPE_HEXAGON_COMMON_MACHINE "hexagon-common-machine"
 OBJECT_DECLARE_SIMPLE_TYPE(HexagonCommonMachineState, HEXAGON_COMMON_MACHINE)
 
@@ -157,7 +169,7 @@ struct HexagonCommonMachineState {
     MemoryRegion ram;
     MemoryRegion cfgtable_rom;
     MemoryRegion vtcm;
-    DeviceState *cluster;
+    HexagonClusterState cluster;
     DeviceState *l2vic;
     DeviceState *qtimer;
     DeviceState *glob_regs;
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index a50ab22554..f24ebe24c4 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -19,6 +19,7 @@
 #include "hex_mmu.h"
 #include "hexswi.h"
 #include "hw/hexagon/hexagon_globalreg.h"
+#include "hw/hexagon/hexagon.h"
 
 #ifdef CONFIG_USER_ONLY
 #error "This file is only used in system emulation"
@@ -30,6 +31,9 @@
 #include "semihosting/guestfd.h"
 #include "system/runstate.h"
 
+/* We start from 1 as 0 is used to signal an error from opendir() */
+static const int DIR_INDEX_OFFSET = 1;
+
 /* non-arm-compatible semihosting calls */
 #define HEXAGON_SPECIFIC_SWI_FLAGS \
     DEF_SWI_FLAG(OPEN,             0x01) \
@@ -375,6 +379,13 @@ static void coredump(CPUHexagonState *env)
     qemu_log_unlock(f);
 }
 
+static GList **hex_semihosting_dir_list(CPUHexagonState *env)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    HexagonClusterState *cluster = HEXAGON_CLUSTER_STATE(OBJECT(cpu)->parent);
+    return &cluster->semihosting.dir_list;
+}
+
 static void sim_handle_trap0(CPUHexagonState *env)
 {
     target_ulong what_swi, swi_info;
@@ -644,6 +655,89 @@ static void sim_handle_trap0(CPUHexagonState *env)
     }
     break;
 
+    case HEX_SYS_OPENDIR:
+    {
+        DIR *dir;
+        char buf[BUFSIZ];
+        int rc = 0, err = 0;
+        int i = 0;
+
+        do {
+            hexagon_read_memory(env, swi_info + i, 1, &buf[i], retaddr);
+            i++;
+        } while ((i < BUFSIZ) && buf[i - 1]);
+
+        if (buf[i - 1]) {
+            err = ENAMETOOLONG;
+        } else {
+            GList **dir_list = hex_semihosting_dir_list(env);
+            dir = opendir(buf);
+            if (dir != NULL) {
+                *dir_list = g_list_append(*dir_list, dir);
+                rc = g_list_index(*dir_list, dir) + DIR_INDEX_OFFSET;
+            } else {
+                err = errno;
+            }
+        }
+        common_semi_cb(cs, rc, rc != 0 ? 0 : err);
+        break;
+    }
+
+    case HEX_SYS_READDIR:
+    {
+        struct dirent *host_dir_entry = NULL;
+        int dir_index = swi_info - DIR_INDEX_OFFSET;
+        GList **dir_list = hex_semihosting_dir_list(env);
+        DIR *dir = g_list_nth_data(*dir_list, dir_index);
+        uint32_t rc = 0, err = 0;
+
+        if (dir) {
+            errno = 0;
+            host_dir_entry = readdir(dir);
+            if (host_dir_entry == NULL) {
+                err = errno;
+            }
+        } else {
+            err = EBADF;
+        }
+
+        if (host_dir_entry) {
+            uint32_t guest_dir_entry = env->gpr[HEX_REG_R02];
+            hexagon_write_memory(env, guest_dir_entry, 4, host_dir_entry->d_ino,
+                                 retaddr);
+            for (int i = 0; i < sizeof(host_dir_entry->d_name); i++) {
+                hexagon_write_memory(env, guest_dir_entry + 4 + i, 1,
+                                     host_dir_entry->d_name[i], retaddr);
+                if (!host_dir_entry->d_name[i]) {
+                    break;
+                }
+            }
+            rc = guest_dir_entry;
+        }
+        common_semi_cb(cs, rc, err);
+        break;
+    }
+
+    case HEX_SYS_CLOSEDIR:
+    {
+        DIR *dir;
+        int ret = -1, err = 0;
+        int dir_index = swi_info - DIR_INDEX_OFFSET;
+        GList **dir_list = hex_semihosting_dir_list(env);
+
+        dir = g_list_nth_data(*dir_list, dir_index);
+        if (dir != NULL) {
+            ret = closedir(dir);
+            if (ret != 0) {
+                err = errno;
+            }
+        } else {
+            err = EBADF;
+        }
+        common_semi_cb(cs, ret, ret == 0 ? 0 : err);
+        break;
+    }
+
     case HEX_SYS_COREDUMP:
         coredump(env);
         break;
diff --git a/tests/functional/hexagon/test_systests.py b/tests/functional/hexagon/test_systests.py
index f36e015f50..c354fd20ca 100755
--- a/tests/functional/hexagon/test_systests.py
+++ b/tests/functional/hexagon/test_systests.py
@@ -7,6 +7,7 @@
 import re
 import time
 import unittest
+from pathlib import Path
 
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 
@@ -90,5 +91,13 @@ def test_access(self):
     def test_semihost(self):
         self.run_console_pattern("semihost", "PASS", "-append", "arg1", "arg2")
 
+    def test_dirent(self):
+        testdir = Path(self.scratch_file("_testdir_dirent"))
+        testdir.mkdir()
+        files = [".", "..", "file1", "file2"]
+        for f in files:
+            testdir.joinpath(f).touch()
+        self.run_console_pattern("dirent", " ".join(files), "-append", str(testdir))
+
 if __name__ == "__main__":
     QemuSystemTest.main()
-- 
2.37.2



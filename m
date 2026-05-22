Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CC7CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 17:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQTcb-0000Dy-Jr; Fri, 22 May 2026 13:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wQTca-0000D0-9w
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:25:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wQTcX-0004Ad-Is
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:25:16 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGbHgx1734187
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=L1QJuou29xu3g0tnX1YPz/
 gvIfXQY74LadtdxGnVtec=; b=DhgPePR8kqzlC9yPUckKDX9n+84+PypDJTE7XQ
 7yQqpoUgyJG4aPeWAFxcRHXYYAHad4HuGrJmaJ+dVpMmngk9ra/U4mjbElgxYbGm
 mEoitNGCmPTdFFuUit/gyTdifzZ0vXx2mkGlkbzzOx+1t1E1pzo3aJ4klji9C7Dg
 05UI38Ax+5QghiLXHXNmz0FdyHO9nHzu0aOkdhCwxiqjETV3rMozJPKqhnvjfMUn
 pSzHWaQZ57IbIopHfL4HSA6lPIb62Np4i/+2R1bv/hDE5Q9gKway++fFq9HIN4LA
 NhdN3Bghq35nXPAvZJdaz/7Z/VhBS8mTkYparUVn2wdwTYfA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eattq86vu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:25:09 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-63144b84f14so11179496137.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779470709; x=1780075509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L1QJuou29xu3g0tnX1YPz/gvIfXQY74LadtdxGnVtec=;
 b=NO0O+GTEMfxy42Uvpw1OvB1ig7y/oFbO+AYv3U4HqvCqPC0BY6oSzzm1nl0l6XSSo+
 7AA1gsdzSkRbQP2c81LprhZ3bhDplGNx7SZfweVJO40gMXfRC69r7Dvdb36wBJ3St1RG
 hummaxmQpRKLoW7EruLmx5oJhB3QJsR+uRTN+l9EICAy/SwiGqACESBOj1YPQr2YsMo6
 pfnl3/gAi1s+Blz5qUoU4Nt5tzmJtpi0f/zsj2qhb6CFQA5hN7FYsjSVD1AbSxjVgeTs
 Znz81EWY3CaVorkgJFLafdS4HS4BjLOXjeZADu+wPIaJG8Y9WlTK0+auNdbuy30yEK3E
 RWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779470709; x=1780075509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1QJuou29xu3g0tnX1YPz/gvIfXQY74LadtdxGnVtec=;
 b=YU3EKYTvC8xv2po4mPXmc4cfSkC90p6tNifRuKlYRR3WQz7aPko73IYSnBdUQs4YpK
 HE4YwHl1+K1ujYxvagmkT9GcFgB3fULRix+8C/1xj/gZn6OlltZp7RvPbbFCVTmvVFu7
 DDQsoZMBVirXbn5CEtTtpJy184qjk5+DqzmmcpBwt+9aKumEkcEpfo7+pdB1bjHHuklK
 z+LynzBHUaT0lroH5CaeSSm7Z0RgBR+KjZC2tZ9JmrjvLwdrTjlk3WshrlKXppikLYgH
 4XpjzdVD6FPEArnU1Fbc6xpKdQH2aXpTt4Z+CmjQ1dA3vKWHHMuFwB7iwOC+jT1dpXeX
 GQJw==
X-Gm-Message-State: AOJu0Yx5Sa+6jT9gV/l+L09mP1WiYUGwvC/y176lyp6clSgpux7/PVZE
 G3IRZsY/lo+5YRYy6en7Cq4dpDFfEesZh7Bnjda/68CNY4t+F8dXbIWJFcAm9YoqzNJH+4zPVCx
 SK93G8wbdMFs/LatqXFOV3RVWm7cq2Iwh+RgUfrAcqUEHOvAB0YgQyahliAWB5Puv2Q==
X-Gm-Gg: Acq92OGKjmXbx/GrTD8gy1iufqtdienzmOLZo9ZswNPwWlzdX21w8DT5l9KkYoRGEuk
 JQORasgsw7BXs/XP5X7rugUldhvXKbRdBApbvHpPc46A+sy01QjgqMhRQmRnzBbsLxDysciZBwp
 9KS47kdfivsbCvaPJVITOkoqWOpMkBW5vIiMFPjzyQMUFxzVdpf0uYC3axUpeBD7P8KXGbh0SE0
 GbNwoTo5MvWO6yL1Ney5dVKH/LBHWE/IwVxDleKKqIc6pqoslr0rAO/eq8OVmzuevp1Q/BMYgMb
 dFwhs1KxDSZyxP64Sf05xo7xCvn9iBlPdHihAefDUnARNDv195r3jXG1PSDU5y5y767ZDfS8iRL
 ZxV3iLbgw+WrB5B6Mq+50Au9pSuJNXnFTmIrl6agsoCxpBHf04X2DRY7dqlMrLJbnc7Ey6wk=
X-Received: by 2002:a05:6102:5a89:b0:631:5ef5:8324 with SMTP id
 ada2fe7eead31-67c8d07131cmr2735284137.23.1779470709064; 
 Fri, 22 May 2026 10:25:09 -0700 (PDT)
X-Received: by 2002:a05:6102:5a89:b0:631:5ef5:8324 with SMTP id
 ada2fe7eead31-67c8d07131cmr2735260137.23.1779470708662; 
 Fri, 22 May 2026 10:25:08 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-67fda9015b0sm2118179137.4.2026.05.22.10.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:25:08 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] target/riscv/cpu_helper.c: add PMA access fault
Date: Fri, 22 May 2026 14:25:02 -0300
Message-ID: <20260522172502.320529-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3MyBTYWx0ZWRfXwaZWHjeRgGV9
 yvMsazGOUe4idbf7IW4pgnhUJ0o7nauR2v/9a3ovTME+tmlDlzLtG61MU5MODhNpFuYCXXUP7mM
 YiF/6eDur7p3x9yj9oIiinxktRO270ozDNQYwogHSZ78riBH/HIjlea1NuxSwqga1Zu8Ywep7S/
 hgovsaD89iHTklhkd93N7aRw3W3mUn74HKaUmKuDo5OBZwJXTmfiwAe80H+EI7qO0YeSJSScASW
 UoFVhV0fd4r30RnJqwZsnkQIt/vZh0y+NX7/sqsrzgzZxKgC/IefL1r9FWGQT9HUFOMW9GekblB
 wmeNSd4cJ5U2nWHGlz6Z8iRyzs9lUz7yN23wYCwmCao4ES5zMPkkgWFlURNEDC/fsrAlfDECoy7
 //MxoUso6jhRNL4zJPV43nRXBgU00nYxUWPfo3jMp9mnVqZt1lzUveqS6qsyKjByg0LbfmTRvgX
 78FcMvi+VWnbNwNMHSw==
X-Proofpoint-GUID: mqSxSO50T1yhUx7MMJ404KgOp4-9m1TM
X-Proofpoint-ORIG-GUID: mqSxSO50T1yhUx7MMJ404KgOp4-9m1TM
X-Authority-Analysis: v=2.4 cv=S/zpBosP c=1 sm=1 tr=0 ts=6a109175 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=KLl1PzbKQf_jOHGbhwkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220173
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

We're not doing anything special w.r.t PMA (Physical Memory Access)
related faults, handling them like regular faults that will eventually
turn to be regular page faults.

Turns out we can't do that.  Priv spec section "Virtual Address
Translation Process" mentions:

"If a store to the PTE at address a+va.vpn[i]×PTESIZE would violate a
PMA or PMP check, raise an access-fault exception corresponding to the
original access type."

This means that we should handle PMA violations with access faults, like
we're already doing with PMP.  One clear code path where we should throw
a PMA failure, exposed by [1], is the error return from
address_space_ld* call.

There's a separated issue with the error code being returned by them (it
always return DECODE_ERROR even with 'rejected' reads) that we're going
to work around it by assuming that we did a good job with the PTE
address sanitization beforehand, and interpret that the error here is
related to PMA.  This is of course not ideal but fixing this QEMU API is
out of scope for this work.

All this said, we'll set the new pmp_pma_violation flag when we have
either a PMP or a PMA fault, and everything else shall fall into place.

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3502

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3502
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.h        |  3 ++-
 target/riscv/cpu_helper.c | 34 +++++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7d79c7a5a7..e5e1687177 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -131,7 +131,8 @@ enum {
     TRANSLATE_SUCCESS,
     TRANSLATE_FAIL,
     TRANSLATE_PMP_FAIL,
-    TRANSLATE_G_STAGE_FAIL
+    TRANSLATE_G_STAGE_FAIL,
+    TRANSLATE_PMA_FAIL,
 };
 
 /* Extension context status */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 17305e1bb7..5303d9f7f4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1424,7 +1424,22 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         }
 
         if (res != MEMTX_OK) {
-            return TRANSLATE_FAIL;
+            /*
+             * The result of address_space_* APIs above does not take into
+             * consideration reject reads, putting all errors in the same
+             * cathegory (DECODE_ERROR), although there's a clear
+             * distinction between a rejected read versus other errors
+             * (see memory_region_dispatch_read() ->
+             * memory_region_access_valid()).  This is something that
+             * we might have to deal with core QEMU logic some other
+             * day.
+             *
+             * For this particular error path, given that we made checks
+             * w.r.t legal PTE address before calling those APIs, we'll
+             * assume that anything != MEMTX_OK means a rejected read,
+             * i.e. a PMA error.
+             */
+            return TRANSLATE_PMA_FAIL;
         }
 
         if (riscv_cpu_sxl(env) == MXL_RV32) {
@@ -1668,7 +1683,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 }
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
-                                MMUAccessType access_type, bool pmp_violation,
+                                MMUAccessType access_type,
+                                bool pmp_pma_violation,
                                 bool first_stage, bool two_stage,
                                 bool two_stage_indirect)
 {
@@ -1676,7 +1692,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 
     switch (access_type) {
     case MMU_INST_FETCH:
-        if (pmp_violation) {
+        if (pmp_pma_violation) {
             cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
         } else if (env->virt_enabled && !first_stage) {
             cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
@@ -1685,7 +1701,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_LOAD:
-        if (pmp_violation) {
+        if (pmp_pma_violation) {
             cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
         } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
@@ -1694,7 +1710,7 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
         }
         break;
     case MMU_DATA_STORE:
-        if (pmp_violation) {
+        if (pmp_pma_violation) {
             cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
         } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
@@ -1820,7 +1836,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     vaddr im_address;
     hwaddr pa = 0;
     int prot, prot2, prot_pmp;
-    bool pmp_violation = false;
+    bool pmp_pma_violation = false;
     bool first_stage_error = true;
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
     bool two_stage_indirect_error = false;
@@ -1921,8 +1937,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     }
 
-    if (ret == TRANSLATE_PMP_FAIL) {
-        pmp_violation = true;
+    if (ret == TRANSLATE_PMP_FAIL || ret == TRANSLATE_PMA_FAIL) {
+        pmp_pma_violation = true;
     }
 
     if (ret == TRANSLATE_SUCCESS) {
@@ -1949,7 +1965,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         cpu_check_watchpoint(cs, address, size, MEMTXATTRS_UNSPECIFIED,
                              wp_access, retaddr);
 
-        raise_mmu_exception(env, address, access_type, pmp_violation,
+        raise_mmu_exception(env, address, access_type, pmp_pma_violation,
                             first_stage_error, two_stage_lookup,
                             two_stage_indirect_error);
         cpu_loop_exit_restore(cs, retaddr);
-- 
2.43.0



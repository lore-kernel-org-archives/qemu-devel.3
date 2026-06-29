Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6392AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 17:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weFLz-0006Ss-6Q; Mon, 29 Jun 2026 13:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weFLE-0006BA-1D
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 13:00:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1weFL3-0005HR-5t
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 13:00:10 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TGKAMG3461400
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 17:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=e71F9ezZTieKP0kSxUIbUuE4aXYiVcbV7ii
 e4PSeZyw=; b=Vy9a7xhUg8z1MJqEAi+s4abZGLoctC+y0QTKD1QX675KD/WxOdg
 279SESADcdJtHVCTuEm3Kq8kvlaDCUXLUDkmisvg0VDKXtP/j9284vczIWszJWkZ
 KF7zaq/WpQVV18UxRp5in6R2pq/YSPZ+6PlTR5zQ7ru2VpHyXRnLU2Yq7KOOJ9px
 +2FDxdXW/6sguPCnMbmRwv+JjMQCEek6ZQov9gpN/qTbLmBVi4rvkuQwPZVdv572
 berkpJakSxFzNHrl78+qfKS9AU/nSXakoMpQvtCfS6vnf4HNJtb6ncbplZGV2uW8
 /bPxE+nvV9vg6YFFeBD8XY7OTScDJ4cn+sA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7j1nv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 17:00:01 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ecfc5dea0so1116857eec.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782752401; x=1783357201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e71F9ezZTieKP0kSxUIbUuE4aXYiVcbV7iie4PSeZyw=;
 b=OAAljoYGHP91Ztw6Q/pmgS26A7idx/YxcyNnbVNRNv0no8Tq1Vw7sarEP2vHHy1bZr
 8BoXFmrJ7+IwNAiqJ7i31KY2/ISw39IiMdVt2AA9QS8EWOBMjcbDgjeNScEC9K4UCnR4
 Tiqa9OECsL2Qf481+Q/QrA0XXefYIWZY+3LVkogzv7o+3rIC6gdbHNp2tqKFZ5AVXB7K
 o9xoWQbmyPn+hP9KOeptJlt+01vHmI1GwYsm3k3E95H2n+qfKzUGefJ0AmeiJ9ktXTW8
 4nr+mPtMTbTn+1C3M1AaZ0jkhOvV2JpEDc/F/WbMRdmYCAIp+5pM8LRm2zMEFev9Mgqo
 awiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782752401; x=1783357201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e71F9ezZTieKP0kSxUIbUuE4aXYiVcbV7iie4PSeZyw=;
 b=iOdqiZ8zngS118s4EJ+8CHp7Wtk0NGNwwsXgVZloPGIbZd4lvt70iJOFC6i32zoCRT
 6RoaTJwsOoMZbFEgCl1n74Y6Cz8i5M1meH072H4cYW+z6pe9QCvJ2p5HIlQr+Yn4iGlK
 CDk24cewWBreVXc1PTXQ+cgyPUdxMN+v/c+HqjxREiZdMNqcx7KMZJu5uNpFCvKEcH3n
 O3KC3OsqmoVDFeT+VhnCfTGE2RqBFvQWf7dliRHqmFPwHCzg2mXKENu+idwz8eWlp6yL
 v+450l3JOVN7PLPE++G2x0kONPehlNv9r3mpltXPmoiec1kYSbH+2hAndG7/0d0c1o0l
 JkNg==
X-Gm-Message-State: AOJu0Yx2NORyiXUHtoM3CIkoYl4rgmd7eX7+I+HOTwC/iSzNzPm2R6Od
 Qt+SwpkftdkN8ukZVtFc1RQFThgNwHhfLe5lDDW4SmI8VX15bdE5AuxufTFFlX3ES6pyHeWl+pB
 B9hiLgme1/85qGdV9HiuE9VWJgdTJVLzuDksKv1x+TSXeK9Vrow/Pv0q+AJu7rYwOzw==
X-Gm-Gg: AfdE7cnf+fTaXEEXCcVvPDYqASvgWqwF9LgC3r1dz7Zcuq5dPtlW8qac5eFhGgRxHKT
 Pu5dg8oSB+CIIa0amMINwzGwTrKMNLrbBPpIiWhcf7GCLET6qe4va7gxZWzxfto68wyxsTtNeVq
 RDPVmP1rsRpPS8SA4DC1+wUlGMcp7pNYO2d89xNJl1g4KXaMTpWyAUj5loL0iVA51wbC4hJIIrV
 fAABnj+vMiFJg/q8eMYgPMHk+lKY2sy/y5fZ3d+ZvIop3F2yCBdWa3NU+jXInKJO8/VrjBxpqIi
 L2v0JM7r4UhyJ2yFaEfL66G6gJoVAX8j5ytkRUBsasjHD6K97XaijQ1dV9qzmwCdy8mcW3ZSmCc
 Jj0brg5T+U+cIRDiXKpvWhPN0K8PyJRSOvtPxXaBhpJITKQ==
X-Received: by 2002:a05:7300:4793:b0:307:34f9:cc9 with SMTP id
 5a478bee46e88-30ee12bfb78mr229851eec.2.1782752400897; 
 Mon, 29 Jun 2026 10:00:00 -0700 (PDT)
X-Received: by 2002:a05:7300:4793:b0:307:34f9:cc9 with SMTP id
 5a478bee46e88-30ee12bfb78mr229824eec.2.1782752400356; 
 Mon, 29 Jun 2026 10:00:00 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ec3e400a2sm19914032eec.28.2026.06.29.09.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 09:59:59 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] hw/riscv/riscv-iommu-sys.c: record fault on IOMMU-generated
 MSI write
Date: Mon, 29 Jun 2026 13:59:54 -0300
Message-ID: <20260629165954.1018123-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE0MiBTYWx0ZWRfX+ErLp3dR98dM
 5H7jm/4zjIp2HOOjXLavf2bk4pwTtoIWCmQpMTlUYm7N4RLU6j/TiI5z2CIhIhA7wYsz+xQAg1q
 u0UkHOtly5zh/PBKxLlkEtp05v9UahJkl2wvssYjoArqUey2O0M5hSbzY4XjOLVXj6SeNgJ0t45
 Q1c0edIT4i8V4nr23WFvoxXX9xaO4HLUIrEKFL7I6KDMqtbjuASxww9oL9JLS7/UgDYN6qNJ78J
 bVAbEabzMFjPpyE2rbTJO3tvjLABBtdiHmeEguLjFjp2ETD1E5gbh8N9VfMsD1GfLsNaY0GrvGt
 JENIsb54iyFMEExhMujOIE9ScxcGXAr/73ZGTpClh6x/2MQpKFmCDUGnEVQj5lwxjD6U9X/oIqy
 NKTFKTyjRHP5xpuPA1wWm0l2IsttJ2HyvZCi5ePLMRqVezqNwkmx1WlBXM2xTAbj8J0C7QFVgYh
 A+gjSEJLHQoj3rGUyNw==
X-Proofpoint-GUID: SHTH3zwRu5c7eiMiCbAUyAFQxxyVFYMR
X-Proofpoint-ORIG-GUID: SHTH3zwRu5c7eiMiCbAUyAFQxxyVFYMR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE0MiBTYWx0ZWRfX30B73VeZUv7v
 l5K6E1raT+4pdftShxpk7toN8VLmuykucdvOKNvduZqb7xjlqENEw6etgt0CGqmq7FBmh+zT6n0
 1SQNQq0vv/3l3pmHRL9ZmC2Yb4ARoQ4=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a42a491 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=GMZP62Zmv_CeBqKudKIA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The riscv-iommu spec requires that the IOMMU records its own generated
MSI write faults.

Fixes: 01c1caa9d1 ("hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3572
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu-sys.c | 16 +++++++++++++++-
 hw/riscv/riscv-iommu.c     |  3 +--
 hw/riscv/riscv-iommu.h     |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
index bf87b0b4ea..3314adeed2 100644
--- a/hw/riscv/riscv-iommu-sys.c
+++ b/hw/riscv/riscv-iommu-sys.c
@@ -26,6 +26,7 @@
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "target/riscv/cpu_bits.h"
 #include "trace.h"
 
 #include "riscv-iommu.h"
@@ -143,7 +144,20 @@ static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
 
     address_space_stl_le(&address_space_memory, msi_addr,
                          msi_data, MEMTXATTRS_UNSPECIFIED, &result);
-    trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
+
+    if (result == MEMTX_OK) {
+        trace_riscv_iommu_sys_msi_sent(vector, msi_addr, msi_data, result);
+    } else {
+        /* Record an access fault error in the fault queue */
+        struct riscv_iommu_fq_record ev = { 0 };
+        RISCVIOMMUState *iommu = &s->iommu;
+
+        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE,
+                           RISCV_IOMMU_FQ_CAUSE_MSI_WR_FAULT);
+        ev.hdr = set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE,
+                           RISCV_IOMMU_FQ_TTYPE_UADDR_WR);
+        riscv_iommu_fault(iommu, &ev);
+    }
 }
 
 static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c9687e01a8..a962926688 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -118,8 +118,7 @@ void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
     }
 }
 
-static void riscv_iommu_fault(RISCVIOMMUState *s,
-                              struct riscv_iommu_fq_record *ev)
+void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev)
 {
     uint32_t ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQCSR);
     uint32_t head = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FQH) & s->fq_mask;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index a778e86fb7..da70e8bfa8 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -103,6 +103,7 @@ void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
 void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode);
 void riscv_iommu_reset(RISCVIOMMUState *s);
 void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
+void riscv_iommu_fault(RISCVIOMMUState *s, struct riscv_iommu_fq_record *ev);
 
 typedef struct RISCVIOMMUContext RISCVIOMMUContext;
 /* Device translation context state. */
-- 
2.43.0



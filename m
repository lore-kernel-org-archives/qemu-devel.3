Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3FCC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiII-0002F9-85; Fri, 03 Jul 2026 14:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHj-0001cJ-R7
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiHb-0002E8-Hn
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:06:43 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiOP3684032
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kCMThYvE/fH
 ManL2Sr5tYS0axu8TItu5IBhY/LlVIdo=; b=NFavUCMv3Qn80n7Nf1j/XtPSIU9
 DF1AhQV5eG7uxjWmbV62QYVn1KDHLkcZy3RrGH8npraVu+GvVvnutliTyIh+fomz
 q2wg0QDHt15xc3gIgZ4H65D618FOoxbvSyRjQECmDdu/zCpRTEGfMZBvobYjcJTG
 lXq68X7exfHg7IluRrSGFhkRCQRoLX5GcR0DSTvpWii4lSKAFpHSAtqOBCyITHIz
 ER/BwPpZHgGkMgiVOvh+E+g8PkwuFBK35m0SNqa/EdhUOA3Z80tmD9++YJhxXVIB
 vcvuX7CwbQBI2XKpSaz25Nblrhcz0XityE/uabvkRhilBXGvv4NDRPbGuvA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5bfjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:06:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d137a68so19569881cf.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101982; x=1783706782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kCMThYvE/fHManL2Sr5tYS0axu8TItu5IBhY/LlVIdo=;
 b=FlQ5pGztOPq+Upf5qGAJrdYow8Af1G5NcvgMIQC6dFimeTIWekYOz1EfeW5/T/2ada
 WBza2QAbhkfGvVyrUvWbQObhQ1sI3AuxuwDxHAB9qjVZTAbQwrpwrvW6aT8UNQxYcqhW
 0o2XUnYK0yfChSUqGC2hRRUjc8XnGhSSPfYQnYdPLz07HF96NhzA+KaNe6tfKWlrdtf9
 apdo6RPaY7eFPuPdYF2G5GlJOlTuXSqZjAsH3wF4D9x/XtirXC6k3T2YLtI8SA/GX2Ns
 eHwYo3AxgizRlKPjbQhLo2fp5QPHIkbvjHP3GnpXbzN9/oiy+T0AiUZGP1Mm3d+FPjRn
 1vRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101982; x=1783706782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kCMThYvE/fHManL2Sr5tYS0axu8TItu5IBhY/LlVIdo=;
 b=kNx+fmM4fx9+MsjqOAwv0iyZIhlrwK6e16emafpIkQhus36BxFnAuBLsS/BhxPGcqf
 JBepPyLurnW1usFH/TTHXKwnSLozZAJ7E4AVUq1h6kYj7E8y+vIc6+b88vmN2QsGoQH/
 i4aELgqe6XlF616HBCWOWNLBRNqYUF2FVVX86oVzXOhZyHGCOeuRz8BjF5MJPfObQUdz
 0H4K8quCY2qMZLPNTYwfJwpEFnvD0QrBz8teRUC0enu+nZDtY2uQDDjia4y1MDD/qDZJ
 Jrn7vtKFe1mTiRg7bwlTSYOqbqF3U0FlhtoynEg6LARAgiO1KQP1KpSwvD7RsiiiZEHW
 +LiQ==
X-Gm-Message-State: AOJu0YywPLF+tY7gJDzBnf6QzpcP7RWa7mhFxmJ0HoWUzLkAMXtQ+GE1
 Bv5dGWxltCX1Egmk+DH9GTHZ0In9QLETUvUQjeGZ+DEMaEWRMt1FDfJlI1+G28ov+M8pwe43IfL
 c4XZo5qhtOYdYT3nonDYZTwWWDCXS8FOJsXHphBev2U056r14oykvUIv+tygOXNMAmg==
X-Gm-Gg: AfdE7cmDuWF5XhMtLe/+uU3eTmAf7X9xg+2gmdmsiEbiO3SPr2s5BHUDdMXd4fJ4UDv
 45pto4iEzzw5gllkXykTgpsCe4GHYa2pFzsONYbCLC83fwnS+EBoJh1htpvFe356Q4uh6+9jFre
 U59kJhpq3jpktG0TeeZ4699425SmUmn+nzbecah+53Ba0E9tKT7CpHXopruNHrAb7pwAxFzXpAb
 6ZKfkOhOs92yUkcOVlifnWyzBdJ19gjMhZIxf1dBkWATLYpQocln3jfVLW6N6zIzbk2Hv0eKJV+
 ftadrs7NfTM/TeYSv8kR/ovfkRp10hr9yhsJUvr9R0vWGFBVqolCe+WdnDRaMaioGYxP4mvmkjp
 h8tGrYLuSGNdCLyydAMvQuYsrAO8vzT5sS8avxJ9mToxz4w==
X-Received: by 2002:a05:622a:258a:b0:51c:1a17:eba4 with SMTP id
 d75a77b69052e-51c4c2a2c34mr9400051cf.24.1783101981416; 
 Fri, 03 Jul 2026 11:06:21 -0700 (PDT)
X-Received: by 2002:a05:622a:258a:b0:51c:1a17:eba4 with SMTP id
 d75a77b69052e-51c4c2a2c34mr9399441cf.24.1783101980864; 
 Fri, 03 Jul 2026 11:06:20 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:06:20 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 13/24] target/riscv: move some irq helpers to cpu.c
Date: Fri,  3 Jul 2026 15:05:25 -0300
Message-ID: <20260703180538.3346781-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXxdU5luzizuLj
 RUpaCDinEtMLKT2kTeQkGnItIuWeyfZ/oFM9rUL+gbR5Y7st5lBlOXTvrTCTn5GkQ5+ZSsWNu10
 AqZfJvYdyc6tp+y9PvckDctWEbLsYzE=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47fa1e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=GPi4zPIJMbMzHxplyksA:9 a=kacYvNCVWA4VmyqE58fU:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: 095cJ2Ij_t_ZlsvLUYCYdfy3nDGP9KxM
X-Proofpoint-GUID: 095cJ2Ij_t_ZlsvLUYCYdfy3nDGP9KxM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfXxUAhewet32dz
 JgO2zKFC27ISe/semAdbiuYc+DhcNVHvc5RSth2PFJDDjLDCtCK6+NPnuzN62Fhsdc4rGbmzcSJ
 xs9vrxKvpvq5yXr8YddqsRpquL2W6eEHsK76n+ED1UXm0IlSx9rOzXQ7hHSaDLudk5lxJMKiGp4
 idTswm0OCGmB29QntKTqxf+fKKqKM/SG9knmydAeZ9nyYY7qSr1iAdRFtRzLNWihoN8RYS+CZnH
 Vlyl8JmwGBIeaZJez96UYNPHmcayANnHNYsAe/+pDF2d0rXdRUGKEd+o65G0GdemKNUVrKkgIwh
 r7bJMR/FfrHIoxL+PXAfv2rrJQdtpSBwUpiyhvokzWXzVdLRnfb7SPuf7gw8qipD7NxNAas6jde
 tbu8jJKaUWcCkpkIrD64ujXq90FNfXOzdA0plFEIy68JdA6yxR3s5TLgnyENzR3ifSnWtIwk/3W
 GaBROsk5rLBmQDqH12g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

riscv_cpu_has_work() uses a handful of irq pending functions from
cpu_helper.c.  There is a very high possibility that KVM doesn't need
the current implermentation of has_work(), but the common accel code
needs an implementation of this callback (see cpu_exec_class_post_init)
otherwise the KVM driver won't initialize.

Move the relevant irq helpers to cpu.c to allow KVM to keep using the
current has_work implementation, allowing --disable-tcg to work.  We'll
circle it back to evaluate a proper KVM implementation for it in a later
date.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c            | 187 ++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h            |   5 +
 target/riscv/tcg/cpu_helper.c | 187 ----------------------------------
 3 files changed, 192 insertions(+), 187 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 508e8dc03e..fe24751379 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -745,6 +745,193 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
 }
 
 #ifndef CONFIG_USER_ONLY
+/*
+ * Default priorities of local interrupts are defined in the
+ * RISC-V Advanced Interrupt Architecture specification.
+ *
+ * ----------------------------------------------------------------
+ *  Default  |
+ *  Priority | Major Interrupt Numbers
+ * ----------------------------------------------------------------
+ *  Highest  | 47, 23, 46, 45, 22, 44,
+ *           | 43, 21, 42, 41, 20, 40
+ *           |
+ *           | 11 (0b),  3 (03),  7 (07)
+ *           |  9 (09),  1 (01),  5 (05)
+ *           | 12 (0c)
+ *           | 10 (0a),  2 (02),  6 (06)
+ *           |
+ *           | 39, 19, 38, 37, 18, 36,
+ *  Lowest   | 35, 17, 34, 33, 16, 32
+ * ----------------------------------------------------------------
+ */
+static const uint8_t default_iprio[64] = {
+    /* Custom interrupts 48 to 63 */
+    [63] = IPRIO_MMAXIPRIO,
+    [62] = IPRIO_MMAXIPRIO,
+    [61] = IPRIO_MMAXIPRIO,
+    [60] = IPRIO_MMAXIPRIO,
+    [59] = IPRIO_MMAXIPRIO,
+    [58] = IPRIO_MMAXIPRIO,
+    [57] = IPRIO_MMAXIPRIO,
+    [56] = IPRIO_MMAXIPRIO,
+    [55] = IPRIO_MMAXIPRIO,
+    [54] = IPRIO_MMAXIPRIO,
+    [53] = IPRIO_MMAXIPRIO,
+    [52] = IPRIO_MMAXIPRIO,
+    [51] = IPRIO_MMAXIPRIO,
+    [50] = IPRIO_MMAXIPRIO,
+    [49] = IPRIO_MMAXIPRIO,
+    [48] = IPRIO_MMAXIPRIO,
+
+    /* Custom interrupts 24 to 31 */
+    [31] = IPRIO_MMAXIPRIO,
+    [30] = IPRIO_MMAXIPRIO,
+    [29] = IPRIO_MMAXIPRIO,
+    [28] = IPRIO_MMAXIPRIO,
+    [27] = IPRIO_MMAXIPRIO,
+    [26] = IPRIO_MMAXIPRIO,
+    [25] = IPRIO_MMAXIPRIO,
+    [24] = IPRIO_MMAXIPRIO,
+
+    [47] = IPRIO_DEFAULT_UPPER,
+    [23] = IPRIO_DEFAULT_UPPER + 1,
+    [46] = IPRIO_DEFAULT_UPPER + 2,
+    [45] = IPRIO_DEFAULT_UPPER + 3,
+    [22] = IPRIO_DEFAULT_UPPER + 4,
+    [44] = IPRIO_DEFAULT_UPPER + 5,
+
+    [43] = IPRIO_DEFAULT_UPPER + 6,
+    [21] = IPRIO_DEFAULT_UPPER + 7,
+    [42] = IPRIO_DEFAULT_UPPER + 8,
+    [41] = IPRIO_DEFAULT_UPPER + 9,
+    [20] = IPRIO_DEFAULT_UPPER + 10,
+    [40] = IPRIO_DEFAULT_UPPER + 11,
+
+    [11] = IPRIO_DEFAULT_M,
+    [3]  = IPRIO_DEFAULT_M + 1,
+    [7]  = IPRIO_DEFAULT_M + 2,
+
+    [9]  = IPRIO_DEFAULT_S,
+    [1]  = IPRIO_DEFAULT_S + 1,
+    [5]  = IPRIO_DEFAULT_S + 2,
+
+    [12] = IPRIO_DEFAULT_SGEXT,
+
+    [10] = IPRIO_DEFAULT_VS,
+    [2]  = IPRIO_DEFAULT_VS + 1,
+    [6]  = IPRIO_DEFAULT_VS + 2,
+
+    [39] = IPRIO_DEFAULT_LOWER,
+    [19] = IPRIO_DEFAULT_LOWER + 1,
+    [38] = IPRIO_DEFAULT_LOWER + 2,
+    [37] = IPRIO_DEFAULT_LOWER + 3,
+    [18] = IPRIO_DEFAULT_LOWER + 4,
+    [36] = IPRIO_DEFAULT_LOWER + 5,
+
+    [35] = IPRIO_DEFAULT_LOWER + 6,
+    [17] = IPRIO_DEFAULT_LOWER + 7,
+    [34] = IPRIO_DEFAULT_LOWER + 8,
+    [33] = IPRIO_DEFAULT_LOWER + 9,
+    [16] = IPRIO_DEFAULT_LOWER + 10,
+    [32] = IPRIO_DEFAULT_LOWER + 11,
+};
+
+uint8_t riscv_cpu_default_priority(int irq)
+{
+    if (irq < 0 || irq > 63) {
+        return IPRIO_MMAXIPRIO;
+    }
+
+    return default_iprio[irq] ? default_iprio[irq] : IPRIO_MMAXIPRIO;
+};
+
+int riscv_cpu_pending_to_irq(CPURISCVState *env,
+                             int extirq, unsigned int extirq_def_prio,
+                             uint64_t pending, uint8_t *iprio)
+{
+    int irq, best_irq = RISCV_EXCP_NONE;
+    unsigned int prio, best_prio = UINT_MAX;
+
+    if (!pending) {
+        return RISCV_EXCP_NONE;
+    }
+
+    irq = ctz64(pending);
+    if (!((extirq == IRQ_M_EXT) ? riscv_cpu_cfg(env)->ext_smaia :
+                                  riscv_cpu_cfg(env)->ext_ssaia)) {
+        return irq;
+    }
+
+    pending = pending >> irq;
+    while (pending) {
+        prio = iprio[irq];
+        if (!prio) {
+            if (irq == extirq) {
+                prio = extirq_def_prio;
+            } else {
+                prio = (riscv_cpu_default_priority(irq) < extirq_def_prio) ?
+                       1 : IPRIO_MMAXIPRIO;
+            }
+        }
+        if ((pending & 0x1) && (prio <= best_prio)) {
+            best_irq = irq;
+            best_prio = prio;
+        }
+        irq++;
+        pending = pending >> 1;
+    }
+
+    return best_irq;
+}
+
+/*
+ * Doesn't report interrupts inserted using mvip from M-mode firmware or
+ * using hvip bits 13:63 from HS-mode. Those are returned in
+ * riscv_cpu_sirq_pending() and riscv_cpu_vsirq_pending().
+ */
+uint64_t riscv_cpu_all_pending(CPURISCVState *env)
+{
+    uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
+    uint64_t vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
+    uint64_t vstip = (env->vstime_irq) ? MIP_VSTIP : 0;
+
+    return (env->mip | vsgein | vstip) & env->mie;
+}
+
+int riscv_cpu_mirq_pending(CPURISCVState *env)
+{
+    uint64_t irqs = riscv_cpu_all_pending(env) & ~env->mideleg &
+                    ~(MIP_SGEIP | MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
+
+    return riscv_cpu_pending_to_irq(env, IRQ_M_EXT, IPRIO_DEFAULT_M,
+                                    irqs, env->miprio);
+}
+
+int riscv_cpu_sirq_pending(CPURISCVState *env)
+{
+    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & ~env->hideleg;
+    uint64_t irqs_f = env->mvip & env->mvien & ~env->mideleg & env->sie;
+
+    return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
+                                    irqs | irqs_f, env->siprio);
+}
+
+int riscv_cpu_vsirq_pending(CPURISCVState *env)
+{
+    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & env->hideleg;
+    uint64_t irqs_f_vs = env->hvip & env->hvien & ~env->hideleg & env->vsie;
+    uint64_t vsbits;
+
+    /* Bring VS-level bits to correct position */
+    vsbits = irqs & VS_MODE_INTERRUPTS;
+    irqs &= ~VS_MODE_INTERRUPTS;
+    irqs |= vsbits >> 1;
+
+    return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
+                                    (irqs | irqs_f_vs), env->hviprio);
+}
+
 bool riscv_cpu_has_work(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 82430ecec6..396d9253e6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -640,6 +640,11 @@ uint64_t riscv_cpu_all_pending(CPURISCVState *env);
 int riscv_cpu_mirq_pending(CPURISCVState *env);
 int riscv_cpu_sirq_pending(CPURISCVState *env);
 int riscv_cpu_vsirq_pending(CPURISCVState *env);
+int riscv_cpu_pending_to_irq(CPURISCVState *env,
+                             int extirq, unsigned int extirq_def_prio,
+                             uint64_t pending, uint8_t *iprio);
+
+
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
 uint8_t riscv_cpu_get_geilen(CPURISCVState *env);
 void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 310c18db46..250bb20481 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -330,193 +330,6 @@ int riscv_cpu_hviprio_index2irq(int index, int *out_irq, int *out_rdzero)
     return 0;
 }
 
-/*
- * Default priorities of local interrupts are defined in the
- * RISC-V Advanced Interrupt Architecture specification.
- *
- * ----------------------------------------------------------------
- *  Default  |
- *  Priority | Major Interrupt Numbers
- * ----------------------------------------------------------------
- *  Highest  | 47, 23, 46, 45, 22, 44,
- *           | 43, 21, 42, 41, 20, 40
- *           |
- *           | 11 (0b),  3 (03),  7 (07)
- *           |  9 (09),  1 (01),  5 (05)
- *           | 12 (0c)
- *           | 10 (0a),  2 (02),  6 (06)
- *           |
- *           | 39, 19, 38, 37, 18, 36,
- *  Lowest   | 35, 17, 34, 33, 16, 32
- * ----------------------------------------------------------------
- */
-static const uint8_t default_iprio[64] = {
-    /* Custom interrupts 48 to 63 */
-    [63] = IPRIO_MMAXIPRIO,
-    [62] = IPRIO_MMAXIPRIO,
-    [61] = IPRIO_MMAXIPRIO,
-    [60] = IPRIO_MMAXIPRIO,
-    [59] = IPRIO_MMAXIPRIO,
-    [58] = IPRIO_MMAXIPRIO,
-    [57] = IPRIO_MMAXIPRIO,
-    [56] = IPRIO_MMAXIPRIO,
-    [55] = IPRIO_MMAXIPRIO,
-    [54] = IPRIO_MMAXIPRIO,
-    [53] = IPRIO_MMAXIPRIO,
-    [52] = IPRIO_MMAXIPRIO,
-    [51] = IPRIO_MMAXIPRIO,
-    [50] = IPRIO_MMAXIPRIO,
-    [49] = IPRIO_MMAXIPRIO,
-    [48] = IPRIO_MMAXIPRIO,
-
-    /* Custom interrupts 24 to 31 */
-    [31] = IPRIO_MMAXIPRIO,
-    [30] = IPRIO_MMAXIPRIO,
-    [29] = IPRIO_MMAXIPRIO,
-    [28] = IPRIO_MMAXIPRIO,
-    [27] = IPRIO_MMAXIPRIO,
-    [26] = IPRIO_MMAXIPRIO,
-    [25] = IPRIO_MMAXIPRIO,
-    [24] = IPRIO_MMAXIPRIO,
-
-    [47] = IPRIO_DEFAULT_UPPER,
-    [23] = IPRIO_DEFAULT_UPPER + 1,
-    [46] = IPRIO_DEFAULT_UPPER + 2,
-    [45] = IPRIO_DEFAULT_UPPER + 3,
-    [22] = IPRIO_DEFAULT_UPPER + 4,
-    [44] = IPRIO_DEFAULT_UPPER + 5,
-
-    [43] = IPRIO_DEFAULT_UPPER + 6,
-    [21] = IPRIO_DEFAULT_UPPER + 7,
-    [42] = IPRIO_DEFAULT_UPPER + 8,
-    [41] = IPRIO_DEFAULT_UPPER + 9,
-    [20] = IPRIO_DEFAULT_UPPER + 10,
-    [40] = IPRIO_DEFAULT_UPPER + 11,
-
-    [11] = IPRIO_DEFAULT_M,
-    [3]  = IPRIO_DEFAULT_M + 1,
-    [7]  = IPRIO_DEFAULT_M + 2,
-
-    [9]  = IPRIO_DEFAULT_S,
-    [1]  = IPRIO_DEFAULT_S + 1,
-    [5]  = IPRIO_DEFAULT_S + 2,
-
-    [12] = IPRIO_DEFAULT_SGEXT,
-
-    [10] = IPRIO_DEFAULT_VS,
-    [2]  = IPRIO_DEFAULT_VS + 1,
-    [6]  = IPRIO_DEFAULT_VS + 2,
-
-    [39] = IPRIO_DEFAULT_LOWER,
-    [19] = IPRIO_DEFAULT_LOWER + 1,
-    [38] = IPRIO_DEFAULT_LOWER + 2,
-    [37] = IPRIO_DEFAULT_LOWER + 3,
-    [18] = IPRIO_DEFAULT_LOWER + 4,
-    [36] = IPRIO_DEFAULT_LOWER + 5,
-
-    [35] = IPRIO_DEFAULT_LOWER + 6,
-    [17] = IPRIO_DEFAULT_LOWER + 7,
-    [34] = IPRIO_DEFAULT_LOWER + 8,
-    [33] = IPRIO_DEFAULT_LOWER + 9,
-    [16] = IPRIO_DEFAULT_LOWER + 10,
-    [32] = IPRIO_DEFAULT_LOWER + 11,
-};
-
-uint8_t riscv_cpu_default_priority(int irq)
-{
-    if (irq < 0 || irq > 63) {
-        return IPRIO_MMAXIPRIO;
-    }
-
-    return default_iprio[irq] ? default_iprio[irq] : IPRIO_MMAXIPRIO;
-};
-
-static int riscv_cpu_pending_to_irq(CPURISCVState *env,
-                                    int extirq, unsigned int extirq_def_prio,
-                                    uint64_t pending, uint8_t *iprio)
-{
-    int irq, best_irq = RISCV_EXCP_NONE;
-    unsigned int prio, best_prio = UINT_MAX;
-
-    if (!pending) {
-        return RISCV_EXCP_NONE;
-    }
-
-    irq = ctz64(pending);
-    if (!((extirq == IRQ_M_EXT) ? riscv_cpu_cfg(env)->ext_smaia :
-                                  riscv_cpu_cfg(env)->ext_ssaia)) {
-        return irq;
-    }
-
-    pending = pending >> irq;
-    while (pending) {
-        prio = iprio[irq];
-        if (!prio) {
-            if (irq == extirq) {
-                prio = extirq_def_prio;
-            } else {
-                prio = (riscv_cpu_default_priority(irq) < extirq_def_prio) ?
-                       1 : IPRIO_MMAXIPRIO;
-            }
-        }
-        if ((pending & 0x1) && (prio <= best_prio)) {
-            best_irq = irq;
-            best_prio = prio;
-        }
-        irq++;
-        pending = pending >> 1;
-    }
-
-    return best_irq;
-}
-
-/*
- * Doesn't report interrupts inserted using mvip from M-mode firmware or
- * using hvip bits 13:63 from HS-mode. Those are returned in
- * riscv_cpu_sirq_pending() and riscv_cpu_vsirq_pending().
- */
-uint64_t riscv_cpu_all_pending(CPURISCVState *env)
-{
-    uint32_t gein = get_field(env->hstatus, HSTATUS_VGEIN);
-    uint64_t vsgein = (env->hgeip & (1ULL << gein)) ? MIP_VSEIP : 0;
-    uint64_t vstip = (env->vstime_irq) ? MIP_VSTIP : 0;
-
-    return (env->mip | vsgein | vstip) & env->mie;
-}
-
-int riscv_cpu_mirq_pending(CPURISCVState *env)
-{
-    uint64_t irqs = riscv_cpu_all_pending(env) & ~env->mideleg &
-                    ~(MIP_SGEIP | MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
-
-    return riscv_cpu_pending_to_irq(env, IRQ_M_EXT, IPRIO_DEFAULT_M,
-                                    irqs, env->miprio);
-}
-
-int riscv_cpu_sirq_pending(CPURISCVState *env)
-{
-    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & ~env->hideleg;
-    uint64_t irqs_f = env->mvip & env->mvien & ~env->mideleg & env->sie;
-
-    return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
-                                    irqs | irqs_f, env->siprio);
-}
-
-int riscv_cpu_vsirq_pending(CPURISCVState *env)
-{
-    uint64_t irqs = riscv_cpu_all_pending(env) & env->mideleg & env->hideleg;
-    uint64_t irqs_f_vs = env->hvip & env->hvien & ~env->hideleg & env->vsie;
-    uint64_t vsbits;
-
-    /* Bring VS-level bits to correct position */
-    vsbits = irqs & VS_MODE_INTERRUPTS;
-    irqs &= ~VS_MODE_INTERRUPTS;
-    irqs |= vsbits >> 1;
-
-    return riscv_cpu_pending_to_irq(env, IRQ_S_EXT, IPRIO_DEFAULT_S,
-                                    (irqs | irqs_f_vs), env->hviprio);
-}
-
 static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 {
     uint64_t irqs, pending, mie, hsie, vsie, irqs_f, irqs_f_vs;
-- 
2.43.0



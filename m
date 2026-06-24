Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C23ECDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9e-0007i4-G7; Tue, 23 Jun 2026 20:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9L-0007WV-AD
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9H-0003IR-F5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NJwjGw3454642
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IijOlZ3k8fC
 mRuDBmWVMxoPeZiwipVAvycOnwQeR95s=; b=mc88IhZQmkQgWj2P4KAvc9WpDyu
 GJj4yRSsbjCto+itZZJ5nqw1Xy5a2ekOyq9RPIhTf2u9yJMaxshiDSPET57+zrlh
 MRcBm9KyNoc1ws3xUnuDmDGNZjHugCbwQpQhzo7QFC3uYmJ+1YeLT5BvU5KQe42y
 v3FnypCDbxhdpVcJhJZys1yccf7R5GecDl2G59C/yzrzS89LU7NZp++cfvFxpCVV
 r/KrtJ0xPUa10eWIoDKtvs0a+zre+20eeMG/eZubPdNXcsxvs5LyyjnoeNVuavIT
 eWKKP+8zpvTiSQGu+tuNF2VIDG58lTm1eWLbr4lxyB/Ifz0BxKnZrCO9Byw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp1gur98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:21 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8de3cf78895so9683046d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259640; x=1782864440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IijOlZ3k8fCmRuDBmWVMxoPeZiwipVAvycOnwQeR95s=;
 b=PI4El5lLeIGtDY3AZDYHy9i3PS1ubLHYz0qP1hwbDfV52Po6E3skt0ucGpl2BYHD2q
 wpvya1G/dym99x0U7CNzdZpVigoKk3eZ+QuMQq//y9DiMHMPrhFh5KnUmqpc8gdE/gtm
 S/CFGnFJtbHilSAlFIy1wKosWbkVeI9DaNdZR0v0Ch5Kdbu6zStaKwOK4n2iW/0gSs++
 ltdUFdOwbhHeDI7w/Irqjr/kITsdNJuTmKeluq/dZKRkyrySmNfVlqQOB9otMjdMC/ay
 gCVB0CKpGSxc/7axUQVqIy92DIsROqcjIg4YKoZTgdgvAzXibDDGCmEv69CiLESUvS/l
 Qdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259640; x=1782864440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IijOlZ3k8fCmRuDBmWVMxoPeZiwipVAvycOnwQeR95s=;
 b=jW3ED5Of7ZjRwO4fs2zeoyxDw+NWqmlCDDBk9sONw5+BoOBQbpw0NKy/0oA71L2mcO
 zd/2t4qNwK1aLbzSSGDws9bGFfRxb1p2pVow24y+8JOKG0XFB3msfAkESpzQQaxs++ZY
 hMGvU4hS7V7lIO/dDv4GOk9QmZkkAqYa9Ncv8ZJAd2MI9+yv7/WZMKF3FMON0jFhgfsL
 eGkpTS3grk+s69gVkhRzxwo1YrT+8F+ytzv/TqvJiV066V8aKgZ/+UxzGsxG63J9rtDm
 L9ZCyBPRZXVWecqM3aXmXlAvHTFlCup/XzD7ayGbvdzmgUP/fEkXkr4W84t6kXVX3wOQ
 AYsg==
X-Gm-Message-State: AOJu0YzZsRC3kzoBvBsmsed8xDcUVCr5r1VEo21BbEFbjfm4pCz+7xWj
 9CUh+TS1Oa7EDug1Oebn+FpF6zMl46ZEmuL1sq3Wq9rMA2DSLB09S1M5wOu7SCMNEVwgHb4IXSV
 iegsvt6iQXJRbFROuIYXFAsu/BWjH+ezwE8tQoaoxd2SXovh4wNdLA9QMd3y2cHoYJA==
X-Gm-Gg: AfdE7cn2JtmqYle/qp1ZdQAXojKhV2PjeXgQbXnhSHs6vINquKb0yzFhta2aBu8B+R4
 JV04aP191JvcP31Ywot4bOe9muig4D3U8E9NmRSQzZy1jhtv9mbLhfqnMr3tR3Rv1Z27v56ggb3
 +AGZBZgXBTyDDkVKnw2SKGZQ+8o6GZTA8458131dy6lPT0JbTYB4+JKXamYPWi30A+f2XtRCQig
 9B3PY3XRA1cp+FfO7VC/eqIdIpCKwwAxkalSy+Lo43ilnVpiwpNJNx4csZ5sSWNUUSYSYA4KfvD
 TQdbKffMw4oAG5DzHtDdZqYbh6GDk4J8bYPiuoOm8A51hbok6fYKHMFrtDg3TfIV9Vnj3niqNWO
 a9rfbruk9y8ZBIUFWBIRJxvXMtwGL0HOYpZOVTI/pa4mYBw==
X-Received: by 2002:ac8:5f0f:0:b0:516:d60f:6457 with SMTP id
 d75a77b69052e-51a61d274b8mr19388221cf.4.1782259640023; 
 Tue, 23 Jun 2026 17:07:20 -0700 (PDT)
X-Received: by 2002:ac8:5f0f:0:b0:516:d60f:6457 with SMTP id
 d75a77b69052e-51a61d274b8mr19387641cf.4.1782259639544; 
 Tue, 23 Jun 2026 17:07:19 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:19 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 13/24] target/riscv: move some irq helpers to cpu.c
Date: Tue, 23 Jun 2026 21:06:20 -0300
Message-ID: <20260624000632.2149359-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QJhYgALL c=1 sm=1 tr=0 ts=6a3b1fb9 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=GPi4zPIJMbMzHxplyksA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 2v24UrcVbNULEKVQ2z5dOSp8Vli-SiSe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXyDRhwwTo9wb4
 CX28YS7AnmyJAUDLQboUHlEFUyGOsP6HIFFCcgLDBlqVJtzzxDVI/pkyCNp6sxrXWllgrmSevLn
 boxCRDzPvseDrpxBGWwUyKyOZm7Wm/0=
X-Proofpoint-ORIG-GUID: 2v24UrcVbNULEKVQ2z5dOSp8Vli-SiSe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXyB47O4dXbehV
 y5YmMKBUclz+VfgZ1M4Rj1ywk2XAueBu+ctNn7ZzTIwChjiKIT5E7UYgDu5qhXg4GZJSxhKxQFi
 i+FnJHSWKXlg4Yg0yWcoR5IpxFIhMgsxsyaO4tMMJiL31mvd/+Yzwle/+unXQRLKr9+4u6+v7d0
 NTms1HgCOWll5rod7fHwpWjof6JTofRppag0KqoXQ9PXK8/RVOck1RywBt4ONdSkh9WXnuzTnqC
 FeYGX0wubh90aFnboz5dHU6LUtm3gzXP+iR+X3NOTSxzPLOcf0LDHplskx2DdJl0u8KuoePJXM6
 4mNxs9NPzJVdAwxEZwj40ju1qWTn9AY68oYU/ABRmQyNVRm44P15qtcL7SsDDl8az03pyOXeGTF
 lVt/15dSmxsWcydHK23guOsC451ETA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
---
 target/riscv/cpu.c            | 187 ++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h            |   5 +
 target/riscv/tcg/cpu_helper.c | 187 ----------------------------------
 3 files changed, 192 insertions(+), 187 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 29af0f2be8..483ac2e0d0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -738,6 +738,193 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
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
index 8c347aa1c0..b38f639dae 100644
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



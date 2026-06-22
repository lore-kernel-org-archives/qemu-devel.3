Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69646CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkNz-0000tn-WC; Mon, 22 Jun 2026 15:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNw-0000p6-Ed
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNt-0001rJ-VX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:44 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVlrd1010009
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=d+x/KmfI7lK
 59cwgzYrYOT6TnQYFSTwXngaXEUCLYBY=; b=IExnaafeP1qhf8C5ivVQllNJPpD
 lr91Xxvm7EUorwJXdzEws7orXDZGyjbI4oRcWXcT7EUpIiuGwmdCOG3mGcB+9hTF
 Ojx0udyM2iG3Ro54WtSHV+E8DIj4iPEKFyEsO1BLxBOWnvXu6AJNBD29ck/5EdL2
 LN30/py/DoP0/i6awYTOBwJHfP6KBcfqaMiLbToav7p95+52MqFfjtxM76yhNVeB
 ow1ECbFzYSouFvwR/9i22IlcDEH025P4IK/KyxvkAEtwsZYEjBM9REj+OeMN3nuB
 yJEskykyXKjQrgZS9EgMwrmysoULBA+VxLBVWhBLfiik6SWjYgOxu1jEveg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0syqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9157ae36434so735785685a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156749; x=1782761549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+x/KmfI7lK59cwgzYrYOT6TnQYFSTwXngaXEUCLYBY=;
 b=NT51vfJCh9rr31OoRgLl1LSfOHdp5LHJna1YUUXT0TLkac5qFDc5HpcO8qXrsJtL0/
 Ik0p2hjJ/xsq0QDkcIw9ZgsdkQCBweLcxid14kSuf9xtuOIcTQPbFW1MnXU1VwyROfSI
 UW/TzLld2tghBz7iYB9o8uBwAWgMULGXHqL7OFCeA53JWB36OuD/LtItVbaTz7cUAElD
 RMDaJX2Jd/L+TJzhze2nweq2Sm5it5qx0yBQhy0BU1HpB8mLKM5b1T7jfwZeFG173eph
 QmJfbh0ehB0wCOzDZUmP8JvjvU/wRvb8OXwvDPTErNHTltgCooqnaDAQvAtT5xdZQ7Gh
 x/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156749; x=1782761549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+x/KmfI7lK59cwgzYrYOT6TnQYFSTwXngaXEUCLYBY=;
 b=C0IvZaAVVtENtUUXaATj5mRdZsYxE5mwXM/jlok2ppT5vKSSCNDT7ej3NSLmdSqcWI
 bdWJK9HjBjoYhEpkPOd/04kK83gi++8bIUFxY3TsDUMSFwEhlZwwq+WFUHQijLO6+Ize
 yZy5hxx3z38AJ3sCqkpoANIH0Pe7sIbXE1MMRZifunEn51JCvtnKEYWqmAmqOZUfSek0
 3MvIWLB2Vo4YPJn7jid6ONNYZVS0DzCGtAA3SAwpLz7qzM91uHOpbxCUdiil5BjNYn+f
 k+hd8DJjjkGU30fbMXS5YLqhimBFmjoN9RWybvHdpnK21iAuph+/KdxYzUb0ZaTDW+5D
 rRvQ==
X-Gm-Message-State: AOJu0Ywc9BW5i08DSImYBjk7PaRo3t0Z+ucLPDJZAVPw7XPKHQviZyAz
 m5O7+dhMokZH+81eLUhXwi31g0g6eCHbFNgFPJWv+ndRSGMWCBhbXrqQMIlm90UfQmSymhPloFs
 SXtxuiKVC1p02VH8Mky3oopv0ugdd1Mq0oUIJkoRHS/aXk660N+nRfGj5L2o5t0sQVQ==
X-Gm-Gg: AfdE7ckJDyG1aIW4lSNwsEkQHxIavwL5Xc+UrfX51TBZjy+QmpLrjrc7IIemuOvxFKY
 juu/o4kxDNhyvcH1FGn9GxHqnxUxmgQH/wqroVdDXye0hjuoWtM0ulRNaDdco6Bqdg43Q0pNrEP
 KE21fX0wiHFMG8O2MlbN2TZwgMESfJJuZ6kH6w2H8045bgH/f09/2P0MMr6PfxL5Adb1PkUWOXv
 ERuDzn+kkEZFll6NR++uvRBxBfgxyr2QmIRqC8LAbSvzVSb1NecHfJA4NILu9eUxtbbBrQQWUfP
 0AdcX/UUssOkvSBF0xRXN1LxFjU44fuBKKVNuPo/oi92wTalr22YxJ7LaISE3adPxeBMkKMvOso
 YYgN8bxj13e05lxNqLp5evqiMapeYTV0tX9Nb4VNe/LY4Vw==
X-Received: by 2002:a05:620a:4587:b0:915:8f76:8005 with SMTP id
 af79cd13be357-920910a5ff2mr2445545085a.47.1782156749045; 
 Mon, 22 Jun 2026 12:32:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4587:b0:915:8f76:8005 with SMTP id
 af79cd13be357-920910a5ff2mr2445536985a.47.1782156748457; 
 Mon, 22 Jun 2026 12:32:28 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:27 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 13/24] target/riscv: move some irq helpers to cpu.c
Date: Mon, 22 Jun 2026 16:31:29 -0300
Message-ID: <20260622193141.1449724-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX8qOTB+ZTo/5H
 E6JUS+t7kXc6/vqWXPibcAz8t7wZDDBgAPv4fUq9j3msUvQu7Rj7E+TDu0tzv9mIi8bfvk89Qes
 lonqQK2MBXG2qcN7O5XwO/YfHmVphEY=
X-Proofpoint-GUID: liRojGNuIq7OrPTUH7gyZ1lafM8FiOy9
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a398dce cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=GPi4zPIJMbMzHxplyksA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX7f6ZDUZqQ5K+
 tdr2Gmzp5xGiT4ae6FS6T9s1hZdlV3ja2Wlk2XntCvNrBUDTiwGmV4J2AFSj0fjzZ9UBqwB7Nbn
 PH0VaBDbViIFMY0F/C8DINqfEO9p77UHZRL+AKCLWlb8cB6NSgdZtIOVR+y/xSaSibHHgXdT2aZ
 k8ESgkMHRWk3YbKAzzxoXVp7xwCA5I4G3HHFHWEeRnJkU9lpx09U9wEuJrkJh3cJgWZLALeNDja
 lhcA/7rB36Cw91tovgiGDKgUNQ0vu1lkqUVS9wrzQrJl2+YfhniZ8OsbW3QfTaKWtthme596UfP
 epLldTunka3998V98OuZUZVEzrc6HNOC2DMPDPLXr6vn2t93uP9uiJ/NFK1vT/9Bp8hJaZ8Ytlf
 R0WUjQa9eOD3f4hn0LroU/7nRq74vBdv/PTSHkah9pS0Cmb4wWiTVgeW7P0k298cYyXb83bujp5
 I/nzEGmd/QTvYhmqIJA==
X-Proofpoint-ORIG-GUID: liRojGNuIq7OrPTUH7gyZ1lafM8FiOy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220189
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
---
 target/riscv/cpu.c            | 187 ++++++++++++++++++++++++++++++++++
 target/riscv/cpu.h            |   5 +
 target/riscv/tcg/cpu_helper.c | 187 ----------------------------------
 3 files changed, 192 insertions(+), 187 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f0ef4c5a4a..41646acfb5 100644
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
index ae6b166d46..c45ee228f4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -638,6 +638,11 @@ uint64_t riscv_cpu_all_pending(CPURISCVState *env);
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
index 9293d61024..09ac1aeda9 100644
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



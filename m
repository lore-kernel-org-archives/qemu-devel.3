Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EEF606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cDzqf+yH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FnmmWLUO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfVe-0007Tg-HI; Wed, 21 Oct 2026 19:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVc-0007Sn-G1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVa-0004xX-Fh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeKNs2160548
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TcXneSB/u9y
 BDzqG/KSAIr8+QMbvQhEJzHVwZFL2flg=; b=cDzqf+yHnb5zNtLD5jdI6Ykf+3d
 viPWF36z1ZFwPWZtCoVErggj5u9llcp5QkKbbutN7ky6Gm/o7Rrbt39/9/b5yMZh
 MhcVrwZVm1DJZlHdXvgZYD8zo79Ed6/4lhKy1zdqHmUYmtNBNvO08+QIo01BSl6P
 TZdMrX690rU3piXBKzXnz8dGdp5TYysUHmL2EgwQXo/ogch7xCL4Qk4iLJ4UJ7aJ
 CK1aQ40/Mz5FT0aAKqqe+2i7q2GmgTdBw7wHIC/L8srNcMfNpP9/P1SwK04Q6Xqw
 4hK3l00wPSjjU5WqBceuOdZBVrsYJT7COHgMQOwGfrNMtdX7i0fK2V3J+xA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf1u3h340-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-536720195ebso26534791cf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624449; x=1793229249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TcXneSB/u9yBDzqG/KSAIr8+QMbvQhEJzHVwZFL2flg=;
 b=FnmmWLUOsA1ztEcah5CkaIWth5kSWFKOUdu9RepStT45DFOR8ImDbPW9RoatXGCRnI
 7Tr+cFhJdU7/EwDNWGCrKNBrE9Ngk9Mf2kCWX/HQnBhH65QguZhnUyvBEMB7JOFvpQt/
 mjtQxLjaiNXti52XngFBbO6eUJX9w1F55FYrad4xwsFow8Kc7rcrWleFbuNvkFwvzlE7
 Cl/ylwZEenqQVtSmoSKmKcfBqDIqfC/LtbFyMST28qhWLC91XpZ7pjPAtfxJVHcm33Db
 A+2dA7pDdKXb0zKHbsGAv22HZitM7bk9bBOdCQgjycXmvYGWmrd4vOvKELw5xOWDjYcu
 kCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624449; x=1793229249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TcXneSB/u9yBDzqG/KSAIr8+QMbvQhEJzHVwZFL2flg=;
 b=B/adiS+eWN1meApNYvoa6z7m5T1x/okWXfTyV9/Was8NnbAfZKiRwtLvv/zD6TvyuX
 4nWuj1TwBtkL09L6xecbWNj2X+xnguIDMMDRwhpTj6dEYsqdQxurBmZf+T14ut19bAzQ
 j64fO3gRjWriswhRiwUvIYKyijfOe3ItZJHTmeKobAN5TFP4T0X3l50P/DcnkDr1Qx6u
 /aEdiENZI5ZN0C+0ntUaKD5+c6P72vs0GRH+DNoYsNwV8iqfOS3n/j4E2F44DE9HaHIX
 iNfL3ETI63Q9cc9Hf0VyTSLoN5O4tv/As/Wi2qIT//cQVtby7oKu2ys+udn/NQQUE3QC
 ByMw==
X-Gm-Message-State: AFq9FYKT3ulQic0DPQ4JnqmHfaxHOAQFVAFWioNCCHUluCDeDKMHQE80
 nImGZ1Iwf2s10I5ud4wodZiP/TcIJAFbxYbcH97aT0CYFWV4pFqCG1EmU8KTcP1m7L523gWER1f
 092S0yekj5gLDQy5rdPt00zdcV/F5gWMGeXMiysgIk5+tbcaEANM8gzQbsKxMmXycDQ==
X-Gm-Gg: AYBFou34u4IW6O/zFqdWfxyWu0PJ9reyJ0/eDndIzfJFdutQyJ2ZYRoLqLvKOdHK1Ty
 aixQhVYBaZtezfHDknx4zg5z3V68ZLzy/OTgM2KAG2eA6oXLiDxlo2366G2fhAuyJKSqGUHYQiY
 QiIshjof1BTInaRZjLv9Of8wTPnzZgtzMUWI3T83Miv4+fQ9FtvOXlDLB9M6j4v7v99/nGzhDFF
 MZQ2kXLhGc/F7JriLEU+0A2C3q8j3OLsN9qmWg1jQe8JNOnpKhLNYU79EFCeeu01JYisxICJnTH
 C8Ck+IXycVnG9E5HRdTvSj5Ar85waoijKlaVaRK9pQKDmx1BqCPQIVIRYjkN2CZVWtmDgRy7iHh
 zouwg+z7dPRDQEMu2Z+Hyu4DQfLGTWfntYQP0sG5pAWjlCQe3DtyQaA49HlhOsakO+3VMOePJEw
 ==
X-Received: by 2002:a05:622a:4c13:b0:536:2fd8:a4d8 with SMTP id
 d75a77b69052e-5369b8538d5mr56442951cf.15.1792624448573; 
 Wed, 21 Oct 2026 16:14:08 -0700 (PDT)
X-Received: by 2002:a05:622a:4c13:b0:536:2fd8:a4d8 with SMTP id
 d75a77b69052e-5369b8538d5mr56442471cf.15.1792624448000; 
 Wed, 21 Oct 2026 16:14:08 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:07 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 03/18] hw/riscv/trace-encoder: add trace start/stop logic
Date: Wed, 21 Oct 2026 20:13:30 -0300
Message-ID: <20261021231346.2452179-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S8ZMU4sP c=1 sm=1 tr=0 ts=6ad94741 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Zvy5nz_Gwx3CY_hQl98A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: rZQKlF6JtvEN3ZVjo0TueOENnNzq7rhR
X-Proofpoint-GUID: rZQKlF6JtvEN3ZVjo0TueOENnNzq7rhR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfXz22wBEfrTDbP
 +6IvaVvbjId+4tsCN7Tk6c4l5N5axj4s68k2YX5Tebgi51bV9mFcBczH8NtwkFEYQkPLTvjjjs4
 Lbo3D16x7PMfW77MLBIxJrAN/+NjWwXylf/lu4WqhRJ2VbwpvvQSoLpPyaFnU76X5Sh1tWnK7Oz
 21IglCHV96luOxSX8zc+Hr//Koa0pUCSdhnS0gWQJqEUs8PjBMUvUXHzICviTQYjT85hMK0HQih
 b1wchf19CsUIVWwe1SzPwrpGq9fgbJf91TEQpZowKwZ1XPQdlifmGWg2DbT6PTfWXC5F7jYybVk
 oCZaGW205T5mns/Yj5f9rsCzFghTSQ3p1lKKwzfiKd+xTYBYJ41hs27K28BPudmmOkkztC9n8zZ
 mVDRm97QnL9WQrjjEv0JrETQ0wtUxdQb8vjX7gfJOp5pwVWdbfdGu+O51MFlq3iG18GKOlHmkup
 wVnMYHSoxBKuWNKNLnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX0MY+ZUdkGzbh
 mJ+3nP42cyUAPd9TtPm0pFR/xKNMeM693EzSfRrmN5eR1E8m5h5jUOUvukyXiRQUwQl/bgGmrfH
 c/l0sZelU+t/VnPo9M4ScPNVwwXBVkc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210092
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

Starting/stopping a trace session will rely on two flags:

- trace_next_insn: this flag will be used to signal the translation that
  the encoder wants to know the PC of the current insn. The translation
  helper (to be added) will clear this flag after sending the current
  insn to the encoder;

- trace_running: shows that we're running a trace session and certain
  insns classes (traps, certain jumps and branches) need to report to
  the trace encoder.

These flags are controlled by the trTeInstTracing bit. This bit requires
other two bits to be set beforehand (ACTIVE and ENABLE). We'll revisit
these bits in the future as more features are implemented.

While we're at it, add hardwire bits to indicate which features we're
(not) implementing at this time.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c | 107 +++++++++++++++++++++++++++++++++++++++
 hw/riscv/trace-encoder.h |   4 ++
 2 files changed, 111 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 19ab785334..99399a55e1 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -30,7 +30,11 @@ REG32(TR_TE_CONTROL, 0x0)
     FIELD(TR_TE_CONTROL, INST_TRACING, 2, 1)
     FIELD(TR_TE_CONTROL, EMPTY, 3, 1)
     FIELD(TR_TE_CONTROL, INST_MODE, 4, 3)
+    FIELD(TR_TE_CONTROL, CONTEXT, 9, 1)
+    FIELD(TR_TE_CONTROL, INST_STALL_ENA, 13, 1)
+    FIELD(TR_TE_CONTROL, INHIBIT_SRC, 15, 1)
     FIELD(TR_TE_CONTROL, INST_SYNC_MODE, 16, 2)
+    FIELD(TR_TE_CONTROL, INST_SYNC_MAX, 20, 4)
     FIELD(TR_TE_CONTROL, FORMAT, 24, 3)
     /* reserved bits */
     FIELD(TR_TE_CONTROL, RSVP1, 7, 2)
@@ -75,17 +79,116 @@ REG32(TR_TE_IMPL, 0x4)
 
 #define R_TR_TE_IMPL_RESET (BIT(0) | BIT(8))
 
+REG32(TR_TE_INST_FEATURES, 0x8)
+    FIELD(TR_TE_INST_FEATURES, NO_ADDR_DIFF, 0, 1)
+
+static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
+{
+    input = FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0x6);
+    input = FIELD_DP32(input, TR_TE_CONTROL, CONTEXT, 0);
+    input = FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_ENA, 0);
+    input = FIELD_DP32(input, TR_TE_CONTROL, INHIBIT_SRC, 1);
+    input = FIELD_DP32(input, TR_TE_CONTROL, FORMAT, 0);
+
+    /* SYNC_MODE and SYNC_MAX will be revisited */
+    input = FIELD_DP32(input, TR_TE_CONTROL, INST_SYNC_MODE, 0);
+    input = FIELD_DP32(input, TR_TE_CONTROL, INST_SYNC_MAX, 0);
+
+    return input;
+}
+
+static uint64_t trencoder_te_ctrl_prew(RegisterInfo *reg, uint64_t val)
+{
+    TraceEncoder *te = TRACE_ENCODER(reg->opaque);
+    uint32_t trTeActive = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL, ACTIVE);
+    uint32_t trTeInstTracing = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
+                                                INST_TRACING);
+    uint32_t temp;
+
+    val = trencoder_te_ctrl_set_hardwire_vals(val);
+
+    if (!trTeActive) {
+        /*
+         * 11.2 Reset and discovery, table 58, trTeControl = 0x1
+         * means "Release from reset and set all defaults." Do
+         * that only if trTeActive is 0.
+         */
+        if (val == 0x1) {
+            val = FIELD_DP32(val, TR_TE_CONTROL, EMPTY, 1);
+
+            return val;
+        }
+
+        /*
+         * 11.3 Enabling and Disabling hints that the device must
+         * be activated first (trTeActive = 1), then enabled.
+         * Do not enable the device if it's not active
+         * beforehand.
+         */
+        temp = FIELD_EX32(val, TR_TE_CONTROL, ENABLE);
+        if (temp) {
+            val = FIELD_DP32(val, TR_TE_CONTROL, ENABLE, 0);
+        }
+    }
+
+    /*
+     * Do not allow inst tracing to start if the device isn't
+     * already enabled. Do not allow enabling the devince and
+     * and enable tracing at the same time.
+     */
+    if (!te->enabled && trTeInstTracing) {
+        val = FIELD_DP32(val, TR_TE_CONTROL, INST_TRACING, 0);
+    }
+
+    return val;
+}
+
+static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
+{
+    TraceEncoder *te = TRACE_ENCODER(reg->opaque);
+    uint32_t trTeActive = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL, ACTIVE);
+    uint32_t trTeEnable = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL, ENABLE);
+    uint32_t trTeInstTracing = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
+                                                INST_TRACING);
+
+    if (!trTeActive) {
+        te->enabled = false;
+        te->trace_running = false;
+        te->trace_next_insn = false;
+        return;
+    }
+
+    if (te->enabled && !trTeEnable) {
+        /* TODO: this should cause a pending trace data flush. */
+    }
+
+    te->enabled = trTeEnable ? true : false;
+
+    if (!te->trace_running && trTeInstTracing) {
+        /* Starting trace. Ask the CPU for the first trace insn */
+        te->trace_next_insn = true;
+    }
+
+    te->trace_running = trTeInstTracing ? true : false;
+}
+
 static RegisterAccessInfo trencoder_regs_info[] = {
     {   .name = "TR_TE_CONTROL", .addr = A_TR_TE_CONTROL,
         .rsvd = R_TR_TE_CONTROL_RSVP_BITS,
         .reset = R_TR_TE_CONTROL_RESET,
         .ro = R_TR_TE_CONTROL_RO_BITS,
+        .pre_write = &trencoder_te_ctrl_prew,
+        .post_write = &trencoder_te_ctrl_postw,
     },
     {   .name = "TR_TE_IMPL", .addr = A_TR_TE_IMPL,
         .rsvd = R_TR_TE_IMPL_RSVP_BITS,
         .reset = R_TR_TE_IMPL_RESET,
         .ro = R_TR_TE_IMPL_RO_BITS,
     },
+    {   .name = "TR_TE_INST_FEATURES", .addr = A_TR_TE_INST_FEATURES,
+        .reset = R_TR_TE_INST_FEATURES_NO_ADDR_DIFF_MASK,
+        .ro = ~0,
+    },
 };
 
 static uint64_t trencoder_read(void *opaque, hwaddr addr, unsigned size)
@@ -132,6 +235,10 @@ static void trencoder_reset(DeviceState *dev)
     for (int i = 0; i < ARRAY_SIZE(te->regs_info); i++) {
         register_reset(&te->regs_info[i]);
     }
+
+    te->enabled = false;
+    te->trace_running = false;
+    te->trace_next_insn = false;
 }
 
 static void trencoder_realize(DeviceState *dev, Error **errp)
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 8978865663..30d118be1e 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -33,6 +33,10 @@ struct TraceEncoder {
     hwaddr ramsink_ramlimit;
     uint32_t regs[TRACE_R_MAX];
     RegisterInfo regs_info[TRACE_R_MAX];
+
+    bool enabled;
+    bool trace_running;
+    bool trace_next_insn;
 };
 
 #define TYPE_TRACE_ENCODER "trace-encoder"
-- 
2.43.0



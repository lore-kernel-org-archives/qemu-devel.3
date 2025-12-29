Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874B2E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIId-00041v-9M; Mon, 29 Dec 2025 13:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHA-0003ep-9g
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIH8-0008DO-HF
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:28 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTB3roa3815374
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ggJVaGHm96R
 1ROzP2B67gvQsc8GKAoWI3tbwNz96GRI=; b=nwptZdsKklXki4zKRM0mgIbhiWk
 +k46AliNAtFmQb30mAug9l054oI2ZeAcKXMEmfkYfhKuay0eIOl4PZpnXZb06/wl
 6Gul1FgNJpX0kmXolkSfFTc6+DPpKNY7/NkcBZO47AnqQl7qoZB2GJieqPWZL3cE
 +e7xWGdchz3St3qJngc3L0TZz8txupe/cahZS6VPKSZhuETA8p8IuU2raZ0zP/oP
 br117KEDFGFd/Y9yfcufNxVAial6/Fo5i4cJBrITMGNgULrIranueF2cKF4PARjU
 B/JN/va51wyqA0f0XgR5BnXyha5aejkcE3pXyBcnMwCCXgh6z2/hw5Mcnsw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbc8ytdpm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a377e15716so62814725ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034044; x=1767638844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggJVaGHm96R1ROzP2B67gvQsc8GKAoWI3tbwNz96GRI=;
 b=TTLBtPW09VXTeVoaE88EnYHrKBhO0Z2F/mHIJsYSWFEWep0HHiK8lPIphq0UhUIf+P
 fOjKvOHiBCgK2IWPqkm3GPIC6S6bL+QhZtJ2hpoS8Esmuo20K1ecAlNWzHER902m1yg/
 msTB+iGnkCQSTc5Yfl2n8yvozq1l7WsZ44w0dle8SO9SqzaigU7NTjtlQwAFcNHixDkJ
 jsstxb7galMVyjmZWv5jF0v0NFzS8nizNGm3pKhbyJ0Bh34vBOmLRlmMlfkSbHo7n557
 q8P5brD0t9S/JaGSKP1k8NAHrtFDOJoOBA2xhwOVFO8H0P1ZDVoDL7DMYFHgAU2JNSWU
 7KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034044; x=1767638844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ggJVaGHm96R1ROzP2B67gvQsc8GKAoWI3tbwNz96GRI=;
 b=V6m5ZpajNiBB6cAx8bhAKlkV7zcj0afTagOiw6ma68AE47z+KIiGn1fjT37wNCkpoZ
 g9jifoNruiaaQd/AzynBCPhxcE3a0ycqV0Z3QVaaRHpVW+PNSO8kqIT2DI5IKYtS4uuI
 c64b/9cVbB7e+cLxqk/eQXHahjaj12IciR9EJBhD/gFEuaMnLCnYBm7FDCzpESzgISBz
 SBPG+AT2XLvr1gl1/MYcqTroERqQ/8RFBcJGHjXZSssc7PqA9nN7bI77PSqrJHWK/ae6
 cUS8DDR0CDiBfs9ANAUc5tqs/LFpGTVwn1LtGAskHZRYht0MvoicGkOfFpGpxQ8b/00p
 tsMg==
X-Gm-Message-State: AOJu0Yw/J/g/7ANUT+Kxns4Dcmcdgcrqynk1Mh0rrbVJEaQxvHKVMRP/
 yomWxyIpNwZx89Z0vsGzYIJs7mir3kb7DX01wmRNAuUgL2AgEsU56L+UWrz/XJBmoFg73V5h4BD
 IPcZY4SWXq6E+kqUdQnfP30xpEpvLChU6yps7pi9SG2dWiHH5g6eLdIn9uHy4jc0x1A==
X-Gm-Gg: AY/fxX5ToIoYApB41A2BSmpjjM/9hq1a9cvN3wBACTRIBqxHOkq/vnCSxv2Bho5AMNr
 50ZwFY+uhxCYcX7+o1cWkrbX0aIgSyxW/YDDc/dP2QrE/VmH9VoNGk1aYATY9MmLymG9oXiO7JG
 PXMfZu6sxH4jUVubJ42bu9hBZVgvfbUUIi1j9z8ienHC+WWwGc76fMCsrw8VljRPXaQNg86M6PE
 r3AnPAmqrBGKElAKhG/y9cV/Ty0CfDV7HGm4aCKfJKhA1vAOyea4xdZ0cwRMTXsQt9lP1cpwXHK
 WhEIPBFbQ+1fUNF8DnibVuMqZCT5Cy33fZ8O2PHibP0WLApQGgJeRGXfZZI+cLIXE2PnTlYxnqd
 1b7XqvSVdK/lQ8HEwNgiBRMQZNDvn661Qs4dSf0DsgtK71WE=
X-Received: by 2002:a17:902:f710:b0:2a2:f1d4:3b64 with SMTP id
 d9443c01a7336-2a2f232c5ddmr296740145ad.21.1767034044151; 
 Mon, 29 Dec 2025 10:47:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmO3dKYgv39motkPncgVyGLMNMynK/pDqYoB84DlXlhmvecWXviJ40lqxqTt3WxouqtSoIHg==
X-Received: by 2002:a17:902:f710:b0:2a2:f1d4:3b64 with SMTP id
 d9443c01a7336-2a2f232c5ddmr296739905ad.21.1767034043584; 
 Mon, 29 Dec 2025 10:47:23 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:22 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 03/17] hw/riscv/trace-encoder: add trace start/stop logic
Date: Mon, 29 Dec 2025 15:46:42 -0300
Message-ID: <20251229184656.2224369-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfX5azB/+uNC+TQ
 JkC5xAJBK/ABa8dkZ34Jurz0Ng93gR68fK/T7kz3dORPcx84MN5CX3mx0M6NQxyS0zA5l+7+qV5
 Of4Bihw/fS8W+52vzpgNbSxmFgGQUvE0nzL6gxUADS/3jfsBsgkSzvcC54bl/baRzFVYhkGoiIj
 SwHFVFnMxXOo8z6Y2VVjFFm1ASQRIf2zbsh8KEJVdZYbOAWsWU1QnqEdc9vpQgsBoecZf0IFU8z
 2syEnnow9n4qtVimJBdodi4wGBNVQ9I6/acXnoNTuP7bulitHmukYLicNpqhp0VWq3pzLdyogbu
 RGLef/7TuC6ks42pU7nFRLcNu+bBcdXVNvfHQ3Ib3VwmQwF2bIgJLRNFC/yXUQ8lG7ehi1/OPna
 ukZbNrmbaOAPAAHi9Ti6ZBpmTXROb2fCBE3e71lp+837WBqww7XgvvbAJLi719RhDwZ20BFMCJV
 b8nER/l3ZIKUiKmd4xw==
X-Authority-Analysis: v=2.4 cv=cP7tc1eN c=1 sm=1 tr=0 ts=6952ccbd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Zvy5nz_Gwx3CY_hQl98A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Hy0uFi5gzxO_DVo6wB6g-SrGgysKDoWG
X-Proofpoint-GUID: Hy0uFi5gzxO_DVo6wB6g-SrGgysKDoWG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
index 6df8ba8e84..37d882f66c 100644
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
index 8f2b9ceb04..517675d062 100644
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
2.51.1



Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E8606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YFywT4/s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kPblbLtw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfWN-0007yB-OB; Wed, 21 Oct 2026 19:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfWB-0007n7-Lw
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfW9-00051s-UI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKf4Go1503340
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=moKJmcI+1OW
 uFQACzWAx/lqmUGHiR02qlhQGMZuwecQ=; b=YFywT4/s9HgL6vkaXLfBMQWH99E
 PR5k3ibfvyvahBC59c4shqjJEsNg8HjgYx10jgRRnB+qwu0+HKfTwqdsOGgdTSvs
 lpFjFxLp8pPIddGyqlSVq0EsipznJsx5Wk2y7tl/CkiPFs2t9DFp2aU54LZwuf9J
 3n8SnyvMfhdu229GvQ3x2/Kz7zgpb+jHXXaDCpbbPBFEDLbsnFMz4w5dVwYVcrSo
 cJcvAVd2RnwjKf4O57skCZhIIDslJRiWRWFZX3R42o3du+KBQR1flWBjr1T9ItFt
 nsmfiB/5nYHXsmZUNPwtfI71Bou8Z07mcAmvFa0pljW99JiDDE5paopOqQQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2hgab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53635e21ddaso17157591cf.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624474; x=1793229274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=moKJmcI+1OWuFQACzWAx/lqmUGHiR02qlhQGMZuwecQ=;
 b=kPblbLtwrqlmA3aAxfiLqC9K/vx1Y1k9hJ7+a/OTNaKaeq6TjVqwccoUFbSv0dasqH
 0hEy7+nqBYW4y3tuMBlBEt8u/Sm2Vxg19o/GY8epr1CgRQPd9SvFuf//n3dZnNVwgJsH
 ktRku6igXJzKdOrbcWvI1XsaAD3owHyUQyO86mEqdIOOMJhjB3MUrYrv1KCIsyx2fXEz
 xmyI1UIJUAeT4IgQqv4A4SrZW5oR65/Tfdw1UmIg/kKaFensCfHR++wH78Dsqyh4Nx8X
 IrHJwXJ5517JFqjNytuJ4O2V/9JA5QmmI5VpKJH9arWAZ7ifaibsv7ePTi/OTEnngIBY
 m+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624474; x=1793229274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=moKJmcI+1OWuFQACzWAx/lqmUGHiR02qlhQGMZuwecQ=;
 b=DQSixrkcm2wWIonPgrNCiQmWJlMiOmQ5aY4btD0OFKdRvYueaw8bPsGz779nChMBMD
 +QWXir8TjDegsmYZKYsAf1t53Ab+Xs1d3+/QYRY7GwRMF6y6tm8OHCO5zF/uJ2cauyHS
 rQ/UIH3LjLBycsgUBjzX3s9JwyeShAPY01TlkB4QgVeoiSS59hvDD4mVWu47bWnuDEr4
 GvJeZB3LfpdJAhU1EAP0KkAGM3nQ1E04byns05XlY4nmMIcqJBYKnpTJovJHDgjdumVn
 3/8h3c0hYb7Z/e2G8WmxoeAsrAY9+cbpaHRmZzRaHqgLGk3cs4hDVRMEUO5w5L39kJej
 adFg==
X-Gm-Message-State: AFq9FYI1YqkvYYTZqiALsQzjRw1NX+6qDX96NKlWWSDETpquN3ItnZLJ
 f8enTdah434vv5u32Cj90NoRNKPpCPdfOhJEDEaBM+6sLFuxgRM0hkoohs0wVZcOYrc5Ws3j13Q
 FwfRV/u1uTDvH4YV+fqdj5IczupYqKD0z4mwnFq92MDiGof0AbTqaAT0AIlH+h5tCjg==
X-Gm-Gg: AYBFou1CdVU3GiH4RVc9iZMOPBYZh8vjKIvTOi0zMcywMe8vqd7npZApLxwHyDyNY+f
 uKgfvNAbxN/MZvYWj3d+krILUG0ndOOTRyL6eYfEJm2a+XWzIM8m22gTkVuPuwO4KyXNntXt1d1
 qgS5mcFUdjhb7GqAIkfOPKW0Te9nXAa6p/sQxEo2d2sRQTW56gwEK5cVGDB6MBHkO/afB4dH+Ev
 pc2gbRvFxNQ7Jsp47aMOHDfSeJRNVQ5BhddBOB83cHXMaLplY/gBUpmNTIgdeh96kjUBegYwHSk
 Fs+6aMHkk8ihEFl+PGqQF/ecoMZjkaosZpLYvl57dGJo3/pnqgl2fJqYXT2+XMcFRj2ZIlYXs0g
 IRt/3s2Bl7YLZEN5mwc3ElNpcUlHXX6I8kF1dAPxsOMOc/v5wivL1sPp6K2berb3+HG3JymO4sQ
 ==
X-Received: by 2002:a05:622a:301:b0:533:3627:49fd with SMTP id
 d75a77b69052e-5369b8055a9mr64006971cf.18.1792624473520; 
 Wed, 21 Oct 2026 16:14:33 -0700 (PDT)
X-Received: by 2002:a05:622a:301:b0:533:3627:49fd with SMTP id
 d75a77b69052e-5369b8055a9mr64006631cf.18.1792624473068; 
 Wed, 21 Oct 2026 16:14:33 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:32 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 12/18] target/riscv, hw/riscv: send trace ppccd packets
Date: Wed, 21 Oct 2026 20:13:39 -0300
Message-ID: <20261021231346.2452179-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX7V6Gfz9GRLsU
 VtZnW+Gv478mqiK4hIrHvGXZELfxwU7X7SqKkfz6qJESGi166EvjF+pAwPNe85LbuoX1+JhrV/Z
 hGSViDDqsma2CwNXmz/slTXVu5wNdio=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX4XS4D0GQHuzn
 HPlF6er20dcRvgOhmviIqO2yhrKJu5tYPc0HhcuKgzDLy6ANrBtgZWupN0SRPMNX3C+7NatcVrx
 fydhadmWwrxcNk+aQ+XsXgkdddJRi6oMoumRnPjyDdlbrWw4v1ypnQvt9WaUhDbM9YWm3wSli9c
 wMRbd2JA6j3IKZ7hSAsz11PZSfc3HSFIlumhQ/pVvTOu51fAygasT6pVf31OcyXKYC6Vx3iu/ph
 Cz/uxQU2zypdCz1BK7pfw60KusdP10BsFlcZls0DIHXQAff7qbiaBy+F7VofklHKwnfkJDF+shs
 hMzXWq8GAoE/oQ8NQNIeaaUWqUB+vxKiPNSmHE5IClrxoR1hrPQEsHFPOQ+WUKRQy1Sv2S8OlKu
 WlYtjtTGNSEBiOCm11UpQtjVyao37L/O/nB5eqyiP/GQkz6Vjf6S9SKrJSyUxcQI04nJPEfNk4w
 r0rZzLpjMqs3nPig9tg==
X-Proofpoint-ORIG-GUID: x6fXZMklyFMhJutTbess6u_OwZfzjABc
X-Proofpoint-GUID: x6fXZMklyFMhJutTbess6u_OwZfzjABc
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad9475a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=AAlH0JvuWwwlC_hcYokA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The ppccd (privilege change) trace packets consists of sync packets like we
already sent during trace start and resyncs.

The privilege change is being fetched via riscv_cpu_set_mode().

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c      | 18 ++++++++++++++++++
 hw/riscv/trace-encoder.h      |  1 +
 target/riscv/tcg/cpu_helper.c | 13 ++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 0e912952eb..b2e2707e0c 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -390,6 +390,19 @@ static void trencoder_send_message_smem(TraceEncoder *trencoder,
     trencoder_update_ramsink_writep(trencoder, dest, wrapped);
 }
 
+static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+    TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
+
+    trencoder->first_pc = pc;
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
+}
+
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
@@ -421,6 +434,11 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
+{
+    trencoder_send_sync_msg(trencoder_obj, pc);
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 75645218ba..64e19c5752 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -50,5 +50,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t pc, uint32_t ecause,
                                bool is_interrupt,
                                uint64_t tval);
+void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
 
 #endif
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 8bacf0ca59..f23b89ccf2 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -943,11 +943,22 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
 {
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
+    CPUState *cs = env_cpu(env);
+
     if (newpriv != env->priv || env->virt_enabled != virt_en) {
         if (icount_enabled()) {
             riscv_itrigger_update_priv(env);
         }
 
+        if (newpriv != env->priv) {
+            RISCVCPU *cpu = RISCV_CPU(cs);
+
+            if (cpu->trencoder &&
+                TRACE_ENCODER(cpu->trencoder)->trace_running) {
+                trencoder_trace_ppccd(cpu->trencoder, env->pc);
+            }
+        }
+
         riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
     }
 
@@ -968,7 +979,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, privilege_mode_t newpriv,
     if (riscv_has_ext(env, RVH)) {
         /* Flush the TLB on all virt mode changes. */
         if (env->virt_enabled != virt_en) {
-            tlb_flush(env_cpu(env));
+            tlb_flush(cs);
         }
 
         env->virt_enabled = virt_en;
-- 
2.43.0



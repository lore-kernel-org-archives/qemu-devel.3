Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98AD606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oZFSech0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BbnEnH0/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfW6-0007fJ-43; Wed, 21 Oct 2026 19:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfW1-0007cC-EI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVy-00051Q-3Y
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:37 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKdwmv816935
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=umQBs0jc4pQ
 gaMYkFT6HH+2iJmSyQyXzAG5XzBVFQBA=; b=oZFSech0MJHG7oaNLTIHIX+nzRw
 MRm0nu473qVgd5NydQjXcmTn5Jd7tbbNGea4e/z3tGWz6fv7J58kAarH1spqPyK+
 XXU9HuLLrcPcqfcWZCgp/NnJyGtIU5mndEc/b+yZ3JDhfITLGkjncSaqAC984IUV
 slv9QORS+blqzyydBMpdiUlJsTDreaxutFijTyWj9UeDsnCtEfWOzgrZCW8GJ7hb
 9/h+rJ3ru9YpmG5O65bsZVuuIisMNBh7GxbbeR6Eax3b/M7cFL+u7qz+YvE1uvtI
 KntABAIKrwy9fpRs3c3s7EOp7AoZgFH7VaLNzmHf4vuuEUK+6RZO8jrXNhg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex58a92d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53380b67cfdso29475521cf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624471; x=1793229271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=umQBs0jc4pQgaMYkFT6HH+2iJmSyQyXzAG5XzBVFQBA=;
 b=BbnEnH0/QoovERXnGOOKE6P/MbKFkBUPVZR0WsOiRZyUdcP4soWqAuk5LJmq0+uD/O
 VOGnHOiDdTn699oiWL4LzFy4GIhQE5OJyeplHl0adWscRf59OyWoe9U8ih6r3Lfi9jSu
 bvJv/0aFdblFCGiDaMnBfMMOURXnv0RJvtwb12hlTEfuG+gS3uT4JmrhoQOocka4VKqG
 9rztfaAIE60t2DGSrwiVwSx75TskfBUbpxFOkmErkJsBhgEfQo+PKAycd6/jBpiQxnjr
 k714h3iUZxseyYaJHOzrj7B703oeRpGat37oEG3GZLxNrfBSBjAaIrD/jzdEcu6e3bXr
 +DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624471; x=1793229271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=umQBs0jc4pQgaMYkFT6HH+2iJmSyQyXzAG5XzBVFQBA=;
 b=rMM6PxmMZXGmvP8vM6tlj97m835MKTRkBujTaLrOqc3jEuJMt5oQpKUjotU+8ROeq0
 SSIZH/Lokq1a/W2nEqDFjLc7m1Tn/CNqMNpWILpOGvmO7Cea3kQPX5GsU32HSh9opuXS
 sxArEeZerp7+CTG9QMOf1C3gWTYu6hPW2d3Y2CXmagnKkqUH6qGQxQCc76ghyXKzNmDY
 bJISBdCRymOhFpoU/baJtmc9+3W8NH1txuIFPTxX4RwXw2p80UhfiGZR7U/do7zh24pY
 Y/vRZxFPCYUEUD3RwJx/aLS96oSUw9G0v1/cmNCzFDNkmoZv6Gs62GROX/o8s7bT1ugl
 I2Uw==
X-Gm-Message-State: AFq9FYJzWIpj4j/r+LyEdWKVKGuomSKIyxRstUyKmcwn06lpFp+/K1c2
 01RJeniZEvZn+QvW35/8JJuEqs90S7N84/Meg2F9h/cDY0D32PXpEcnp0YPncQqt7uPP0ge1BNr
 QQvWTerax3k+YdtDpraCOHmM+61gzFrVCbz4h38Po7zbgIKm6bNiTO+6uuvRO5LRNMA==
X-Gm-Gg: AYBFou3im5mPOn3aUAr8fZZuQRfcYRELPoY23zYFojsWH4p4S2zRrRlTl2TIZBIElP3
 L19T1vaap2wTYDraOA3jcuGj+Nv6FER+aZ+mp1syahtkqBBv5zmUabuPJgaIyp7x1Q1rqlWKNnv
 nxmiW91jpvZxl/t2rVSzjKbi0RH4yIWN1/2XvOm33GunNiSwIa3eAgPnofpgT9RoOS8ogi2KKTU
 Hqj0LEnLnbXopwfyOehdthgkbRkWQ+uhHUP1Ch5MvD0aHAIowQEqumraGWnuZ+QBeMHFzGbjJJ0
 K0I0u8g1xpjDWVAghLS1QspzsU5zEXF6d6XCv8rgcHETvi9zRIFGii+Okxstcdow3jIeXf15m+B
 Win7qm4rCr8AJx4X/8aaK+HmTqq7ikWJxux+yKOWTLrgL/wskQiHHmmmi4ZKyNJDar6KAFIxc3A
 ==
X-Received: by 2002:ac8:5d0e:0:b0:535:a5f7:d591 with SMTP id
 d75a77b69052e-5369bb71a77mr64564391cf.75.1792624470688; 
 Wed, 21 Oct 2026 16:14:30 -0700 (PDT)
X-Received: by 2002:ac8:5d0e:0:b0:535:a5f7:d591 with SMTP id
 d75a77b69052e-5369bb71a77mr64563941cf.75.1792624470140; 
 Wed, 21 Oct 2026 16:14:30 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:29 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 11/18] hw/riscv, target/riscv: send trace trap messages
Date: Wed, 21 Oct 2026 20:13:38 -0300
Message-ID: <20261021231346.2452179-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX+frcxIVktweb
 kNNtxpd39SNjTramSHhgddDGGt6BvXtu3InJeKpoXB+b2NbnkMnM12rA+soMqYcWgvOAOkj+KNd
 Z3RkP1+8fJumDr9d7Ujvvv7Vopv68+E=
X-Proofpoint-GUID: GmuPM97zj6zkw20BQadeNkuTugHnIvi0
X-Proofpoint-ORIG-GUID: GmuPM97zj6zkw20BQadeNkuTugHnIvi0
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad94757 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1gIMccR7lhx1aHGv9TMA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX3R8DrZfAEzkh
 PLTOCO4aY3yesLqWbM/hPQhjcOJS2BLQBPSj0ToPp2UdY8gNGvS74538t5wxPKn1eqdXS+w+4of
 yXP3GRIEke3hgJD6i1KeYZealPlslz4FPniGzqwfDAG5HGMurgsYkoixrvVBfuIJg2n4O7WKCra
 YbgOuYkjWjgw0W4Ovs6S3EDc4dQ2RvwKwkci2l2FuommTO2hbiLOSl9qs3L1Gpc/ef+lvxyzHjS
 8XEDhNe90Nt8CqjiM2DqFlUfim74xekjdHN1/7dw47ICz0mbyIRY2D/D+C6lnKk3NuHCoyX4YA6
 hgARfIXJ9D6KGyI/SZqFB/dDgtwYaknNDNm6rYehGOgftP+ay3zvfB9X+Q/7J/PaQb1HQ7MJ4I/
 mJ7V4qXShw1/81TKUUBz4ZFiAIJGmV6AcUbnz1lbdbquT1DXAuCXT0Ib1ZKGtVjDloAlDM2/Yol
 S4Aax3fzmlIZfsxYrqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use the rv_etrace_gen_encoded_trap_msg() helper we added in the previous
patch to encode trap packets to be written in the RAM sink SMEM.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c      | 17 +++++++++++++++++
 hw/riscv/trace-encoder.h      |  4 ++++
 target/riscv/tcg/cpu_helper.c | 13 +++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 2b358b2699..0e912952eb 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -404,6 +404,23 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+void trencoder_trace_trap_insn(Object *trencoder_obj,
+                               uint64_t pc, uint32_t ecause,
+                               bool is_interrupt,
+                               uint64_t tval)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+    TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
+
+    msg_size = rv_etrace_gen_encoded_trap_msg(msg, pc, priv,
+                                              ecause, is_interrupt,
+                                              tval);
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 1801193e15..75645218ba 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -46,5 +46,9 @@ struct TraceEncoder {
 OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
 
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc);
+void trencoder_trace_trap_insn(Object *trencoder_obj,
+                               uint64_t pc, uint32_t ecause,
+                               bool is_interrupt,
+                               uint64_t tval);
 
 #endif
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 58e98e975c..8bacf0ca59 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -40,6 +40,10 @@
 #include "pmp.h"
 #include "qemu/plugin.h"
 
+#ifndef CONFIG_USER_ONLY
+#include "hw/riscv/trace-encoder.h"
+#endif
+
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
@@ -2300,6 +2304,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                   __func__, env->mhartid, async, cause, env->pc,
                   tval, riscv_cpu_get_trap_name(cause, async));
 
+    if (cpu->trencoder) {
+        TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
+
+        if (te->trace_running) {
+            trencoder_trace_trap_insn(cpu->trencoder, env->pc,
+                                      cause, async, tval);
+        }
+    }
+
     mode = env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
 
-- 
2.43.0



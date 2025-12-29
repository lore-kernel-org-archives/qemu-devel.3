Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75953E92FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIJ2-0005DZ-MX; Mon, 29 Dec 2025 13:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaII4-0003oP-BS
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:29 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHt-0008HV-71
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:22 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTARcR03647987
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XvzfCWFDr4a
 bzbb1M6NUv7XtQBTAszALPHGV9cVQx8I=; b=b+Thsjqg1F4gb2NAp4WU3ZrFUXP
 t4nVtAr+8tYeZPZFz8lvFS/M/i0gQlFdOS1U7a8bu9VD183vnN3Qlucq4P1z2pet
 thTTLXNPk2Vs8xGz+SIkbj50GVBnKLq0bqFGi3YP4k3FSNyu7+DLHqq655w321aW
 5zZjh2Vr3AhiANS0IINfEPWHMivbVwr9UR1JXQAiVrDGvTZGtHXzkLeka6YAI1St
 x8nrYHV478bEnKmQGFaJ+7T4zRS2xv+RS8Hz5btnVJlfhKpJaN47eJNr/LZ2hgSh
 bYYS4tNKx6N8syuWYakhLuSJ9+bD7WkDXX1AZe6CicGdMIUqWvJZkii6eWw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6sg5532-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29f2381ea85so199806215ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034066; x=1767638866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvzfCWFDr4abzbb1M6NUv7XtQBTAszALPHGV9cVQx8I=;
 b=MwMTGxEik//CBCjDLvieBEIbwjP6FVfcOFBjDmTev6f839PO0R9qB4JqQ89vo4f7b+
 9YQC5xsDW+Vm8jnWH3Q3CuGt5tz8aGSMmVRc7Ecenb6vGihDlP2hWfMl6iQH28f3nqC/
 N8PH1IgZZt4WZvmBznonxtliFe6XQTjQ3wgcJRw+1WbS4BUjO5rFmzwHHJr/sp+3VPkP
 d7wzRnlC9I0+KslpisUi0L2X3jqMtOQr0+qEbX+6e87CUhxk7LCWaoSGTjz6TvkhOUMc
 Mt8tXjqzgCyC+JI0FawwGYniDmamU5xBuDJAxxZVnhbZepUllqF5W9CfqpD889pUmLih
 Q9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034066; x=1767638866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XvzfCWFDr4abzbb1M6NUv7XtQBTAszALPHGV9cVQx8I=;
 b=BNQ2QTFnQxyYRiNR2mDCpYDzQR94e5XDWnZAwDx05GtPSJjQuChFv+w9vALwn24hy0
 4iIQTl/mQRy+0uYTUe4JYOS0V0YdsOlKsnV84YcVwLWt1x/Bo4hxKdtItm36Ody687SG
 8xrSlyZWDJ98TBZu6HN/ZX9goB9ZWxeCZjiNGVmCNR4YjyKygaHs/uG8y++j2R71qwMq
 GtrOCjiclpXzrowdBf4IOJnxBmcnUQAYJ9zRDUKl9sJSvyyNdwnCrWQ+3tUUeLxBdo0t
 kd/r5TGR6sO6vrmsUivReBzJW49FXt34H+6htpHSNr1Wt+0WLkIRYxSv4zKemNoK0bmw
 A7bg==
X-Gm-Message-State: AOJu0YwhJRq03+J1/eTwBMks5QcDXTtzKEJD76XbBGm1hO35W1OhIvZv
 ZjzuOOQp1hFbRlyjQ3BU6fSIRf5JLUECaPRrPnuGmO/1s8fbQmbFmzWYOPQ4xpBZrr0gyowCtkC
 GLzfdSB7kl4uJA9SWVoxHvRi9qyqa3IHA01IwPKwKkdqrUbY+sP22o7wFg5fOclQsrw==
X-Gm-Gg: AY/fxX5/Zms3B66DqprUcq+J9wZ6ttyeIBRT0XdBz5AauZGxHTNiQ9PLm43Um52MMfr
 tSgLTFC7hX+5i/4SCPo6tSbYBOw+lUnstaDqYPLmAY9UAjEYo+ack7Pj7YL6yAqa061xGR0uuYW
 kC+/5zzg/ED974aiwGWJ9mqgdZDheIteypjXDEBENVOoVO5+1bkInAFHIhp4prd0SjJUN/YOPXF
 ZW3jFaCTo01rkSeF23bokx8x6pPTuL0XhEyICA148IHRapmzCE19+Ezy/XoBZ24aFOdoSA4z4vW
 3vrGWXtr0XxolSQ0Twe+WnLMI3lzpAvMi2i/PseQkMcBzcFvNhrHblw3XlHLdbNWt5Q7VT9ilAX
 bvcFZXmNQjoAop71mdu0dvRJ+BlMSO+dNn56vEbwnmUkGBZc=
X-Received: by 2002:a17:902:ce91:b0:2a3:1b33:ae11 with SMTP id
 d9443c01a7336-2a31b33aeaamr276091295ad.53.1767034066255; 
 Mon, 29 Dec 2025 10:47:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE73OasfYPoRd5/zsBgjpmOTFGNOicU32dm4FF1WkwmNSSKQVNewMoCaNAqsh7lZSGBc8THzw==
X-Received: by 2002:a17:902:ce91:b0:2a3:1b33:ae11 with SMTP id
 d9443c01a7336-2a31b33aeaamr276091095ad.53.1767034065787; 
 Mon, 29 Dec 2025 10:47:45 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:45 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 11/17] hw/riscv, target/riscv: send trace trap messages
Date: Mon, 29 Dec 2025 15:46:50 -0300
Message-ID: <20251229184656.2224369-12-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: s3bfIKV9Gm0bwpqSYeUqsOFY4SRSaR-T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfX8h/D6FeZpTMS
 2V28XU8Ib+2+OOsqb2Px8fiX8UnxWQ3NRa4ADF10UCO2+zcoBEHiOrd6YOSCKLW1iod8iIui2wr
 K+LnJjNoF2ElznPO0QrFRtQH+zHUb9W4BCDjYbAUxN8/7IQ83a4x/4W17r2HwgJ+8uMl7S/OWgb
 vpN6ItVsOrwUPEFb5aRDrYQZbHKBMNVMonhH2ovvz6MhiJC5pcU0PqfAq+jqVah8Qro3mx44qGl
 Pu9JBxzd8ddLs+oGDv49KepMFu3VPOGV3HZjatdw3ncqZeT9WajchWriYmxoyBncPSg7zhu4zdy
 3C7IyBXuZdVVEa9kWC0l9O/s+Kz1nLVsS5ESppQ+crqF9RxHxm4lKkej/AqZnXKlfrmrnBE6O2g
 WBKanrfEYW37u76JPenRI7m4Da4JSUWL1ar4ApNyLguKAp+DN25I0qBUaxLH/5Qlha7KyVjNqMD
 uijxwr/5RgTRsvAvk8A==
X-Proofpoint-ORIG-GUID: s3bfIKV9Gm0bwpqSYeUqsOFY4SRSaR-T
X-Authority-Analysis: v=2.4 cv=Y+L1cxeN c=1 sm=1 tr=0 ts=6952ccd3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=1gIMccR7lhx1aHGv9TMA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Use the rv_etrace_gen_encoded_trap_msg() helper we added in the previous
patch to encode trap packets to be written in the RAM sink SMEM.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c  | 17 +++++++++++++++++
 hw/riscv/trace-encoder.h  |  4 ++++
 target/riscv/cpu_helper.c | 13 +++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 3ffe4dfe61..28d7b88b5c 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -403,6 +403,23 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
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
index 2b3d9437ec..c478332dc7 100644
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
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90..baf89ad5d1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -38,6 +38,10 @@
 #include "pmp.h"
 #include "qemu/plugin.h"
 
+#ifndef CONFIG_USER_ONLY
+#include "hw/riscv/trace-encoder.h"
+#endif
+
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
@@ -2285,6 +2289,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                   __func__, env->mhartid, async, cause, env->pc, tval,
                   riscv_cpu_get_trap_name(cause, async));
 
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
2.51.1



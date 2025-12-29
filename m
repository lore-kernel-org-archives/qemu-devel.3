Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37079E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIIz-0004ye-Rw; Mon, 29 Dec 2025 13:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHm-0003lA-1F
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHi-0008Hj-S4
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:48:05 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTA51SX956323
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FcXm0ZjJwGx
 2dKNn1tOaUJwDPxAY8YVzpdc4n0KpkrQ=; b=TBQHB470vLYeL6sg6xsoWpjR6SR
 MGoIO/1LHCHhdmlRWqAQNctkYbiAWBjrEdMLGk0eAgREXDyFSqeBYJi0NcFWLqAE
 y6TwCRxlvNiYJtK4NxthttaAgNFGnxEAPqwYSj9XxJzKU2hBG6XgcPaWFvwoL8OC
 zLRx8fQA1Eo7A5bXoEQpSIIIChSixD6FRVgJWBJhI2iwEA3t8Nfco3SuuZ6ejy/5
 fionwkyiZ67CObO9QqpJ3NQ2BdraS/1Hf/Hz77N6fprrMmkNagIAhL72FL7+MTaT
 gsOhpd4PqrTJpkQptt65mDWUAm2ZYnVkJf/itiUeNhCmsdprN374FdSRtPw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbqk193yn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29f8e6a5de4so127694755ad.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034069; x=1767638869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcXm0ZjJwGx2dKNn1tOaUJwDPxAY8YVzpdc4n0KpkrQ=;
 b=VUNfvHdw6qk4QfvHsKBYE6k+W1AbtvoGoYpjE2YioWwPatJa+OJUdzE7L1ecSYZ+OM
 Su14gOctl1a8YuQbdg8V+dx8BxzDohrA51pQIWpi2KkdLyENTREFpbLHMlnFNueE4bjU
 ssaf11u+0LZaIaI/T+BbQn4+/7wQLOc6S914DtnBleNxaMegnBHrjWa4pAxgeMiK2DSB
 5Qo5IYjFGe1gg+z+sEF/rdpQ578WrYBjCHydoc2CabblIe7d7uZrtx3+B1j1RFV7OhqU
 dntQ3eBT48ksFU4Wt7L6fbTlyKUrfJB8cF2pmmkMCQwHzvFvwWMr9+sLg14J21uiTdr3
 BsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034069; x=1767638869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FcXm0ZjJwGx2dKNn1tOaUJwDPxAY8YVzpdc4n0KpkrQ=;
 b=OvAC/d7w1qVepRS6L/Z6q+KCR3/WwQfG315y+jWuLxoIoehppTKakSDnAKCla1HCPZ
 i6hHzlKTlal8tEIRhCntzzg0pp79kjfHrQlrtMLG5eT/LVRUx9ZlPXZ1wOe648U227Bf
 ssStOlZhA0zfzpsJRCs5miSdT16gSQRxC3HS1v7U1tJzeusKhCZK+2porg5x9vzDQiYy
 wXBvlbrtDwb/0Cuydut5OOcHRImRWHTVMZSjGDGQ5NU2e10SFSNu825Euun32CBa+SAI
 l/B5hNoaj9lKXuuuZbvQD/rHLauVwGERPYmvMaVYkMA1GE/NUCSAYBFvBUOenXzkbqXi
 3NKA==
X-Gm-Message-State: AOJu0YwgfrebCBI3N0ktZXAus2CRc4I4fLk7lApSLBsKyPTVsFARFTAm
 UHLcfIX3Xpq6qdVWlCrpGUEYSe7OV7jYQjmYdcfInIOIk1n8TIEZNCFa44YsctWEW0Qa2L59mMs
 otjwmHMCMuV4xMRc8J9iQ2zjqY8NT7ji6yD08MZ8UsmVlJTjuVGhayZMKqeUc80/gaA==
X-Gm-Gg: AY/fxX54NwjwpDOylPsNp3dtKlIM3lPCtF+SZ81zShbKI2ZCoV4TzdAyPJngIWCmq6T
 K7FbeVY8X6DH2aR7y2tRVaSNNAo5OVGdIelhVRcQwar+dB0vkqJEs7bRpZHuZeNCIWaIC29HGe/
 QiOKzv9/tHePEE4CEkOuHht3cLaow7zROXUKI4Q7O30ZKb8eMVpBxrjF1oIDdLeCYs6+12qTxBn
 4KywbIJM+mV6pvIctws+D5dbJWQx/ldFyivwOV/CyuDqn58/azIFLrYgOu8HurZjVl2L+C8S+XU
 gdmFWs4Os7/O2nCNbX2ej7s29qUz7t0iAcImPMed+h+nIBtjRNLbpfKEpcBxweoy21apuqS9Ztx
 Z1Svmt+xYGEP8yOnX4TjV8n6RQSwcJQzrtq2Kme/wJv7ZtTQ=
X-Received: by 2002:a17:903:3b8b:b0:2a0:b461:c883 with SMTP id
 d9443c01a7336-2a2f2a354ebmr303729725ad.45.1767034069043; 
 Mon, 29 Dec 2025 10:47:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBcyWdRRDzPErAZCSJPGqJwBOD5csBzeGOJjFiBK6pYPxQHRbJJEG/1zwB7tB13Dk74KrhEQ==
X-Received: by 2002:a17:903:3b8b:b0:2a0:b461:c883 with SMTP id
 d9443c01a7336-2a2f2a354ebmr303729455ad.45.1767034068490; 
 Mon, 29 Dec 2025 10:47:48 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:48 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 12/17] target/riscv, hw/riscv: send trace ppccd packets
Date: Mon, 29 Dec 2025 15:46:51 -0300
Message-ID: <20251229184656.2224369-13-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: taxvo1Hpv2vqM_rFN1WmTJxcx9_v1ZGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfXxTdZ+TFf5hDT
 guhuplXDDK7UNHXCLTLMt3DkU1UngYzqrtWtt1Y7bES6x1LbR7EhRAMlileMtzWbO8/zIvbwdHe
 qmewUQNcLio0HGBvx3BPaL9Cjq0Q56erYTq49Mkn18fZXP0gK9Tn8AOuZHum/NoupXNXm/eE/xd
 xD+siUnKMq0onrY96EB/Cgvs3Gv7rF8iGi5vzas0YbhfQ5hWHhsnR+2eALJZEHf/APhodrCqPi0
 9AXkmKTTCsVfUoMq3MNxgaE4GQVYhxOBHFHuvLVLMjdeHGMOzK7xt6tUj+vBUct9hhIgXsi6aWY
 oGyW2ibikJ51tpzpU0tcmd6bl0MZHpRLRco8Sd9YFsKu9j3QYs5MNePr7mCXMCAnVNWNAHjvZ1C
 M7zEbjINcPuwF+bSGyQbkSTKtZ4oTN+YvbzhvbrVTZ/If0wPIf2peJ7a4t7expV1QDNhJnbGs4s
 LLBapZ+EzjlZ0EEtK7A==
X-Authority-Analysis: v=2.4 cv=Tf6bdBQh c=1 sm=1 tr=0 ts=6952ccd5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=AAlH0JvuWwwlC_hcYokA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: taxvo1Hpv2vqM_rFN1WmTJxcx9_v1ZGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
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

The ppccd (privilege change) trace packets consists of sync packets like we
already sent during trace start and resyncs.

The privilege change is being fetched via riscv_cpu_set_mode().

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c  | 18 ++++++++++++++++++
 hw/riscv/trace-encoder.h  |  1 +
 target/riscv/cpu_helper.c | 13 ++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 28d7b88b5c..7f130198a0 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -389,6 +389,19 @@ static void trencoder_send_message_smem(TraceEncoder *trencoder,
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
@@ -420,6 +433,11 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
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
index c478332dc7..13252f92b6 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -50,5 +50,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                uint64_t pc, uint32_t ecause,
                                bool is_interrupt,
                                uint64_t tval);
+void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
 
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index baf89ad5d1..3f246c388b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1034,6 +1034,8 @@ void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 {
+    CPUState *cs = env_cpu(env);
+
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
 
     if (newpriv != env->priv || env->virt_enabled != virt_en) {
@@ -1041,6 +1043,15 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
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
 
@@ -1061,7 +1072,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
     if (riscv_has_ext(env, RVH)) {
         /* Flush the TLB on all virt mode changes. */
         if (env->virt_enabled != virt_en) {
-            tlb_flush(env_cpu(env));
+            tlb_flush(cs);
         }
 
         env->virt_enabled = virt_en;
-- 
2.51.1



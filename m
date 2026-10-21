Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6E3606A328
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVqTd0UQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qn4m+Wjk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfXT-0000tq-Lr; Wed, 21 Oct 2026 19:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfWP-00080w-Md
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:15:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfWM-00053b-0F
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:15:00 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeTKk2161258
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UFvj94n64zZ
 xkP6dzgX9QegZ0y8Q8iOQPz+mMSLKNnw=; b=CVqTd0UQ+F0Ppf5X+4MxW4qoCp6
 6+n4VmTl5bG7UbRLnZfrusFkhbqm7FnCaDcVwvZD+xhCJX/T2f2CwBxNBoWL5OEs
 oSW4qZdLf4CjUNkiEOg/9ixhnFTCVLpyp9lLoWtU5VcYPCE2sa32m9l+mNGzLXOH
 kNErAeitSlOo11mW4BMOIS12xb4bDRqcoUV0hU3VkmyUa/KsXiASm2chpO2RGcH2
 MZfFeEV1Ugdr4fT2Fzr9vNEi6dJrCnv2BWBP8+2u/CZW2DBxhbOopXSzyW0cAj9S
 a1gb/ute+gU2Yej0qBVRK5HYOCUzu8B+Cg83sh/97YyTpIyhpJlBAOdNmmA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf1u3h35s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c26012cd0so24312471cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624486; x=1793229286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UFvj94n64zZxkP6dzgX9QegZ0y8Q8iOQPz+mMSLKNnw=;
 b=Qn4m+Wjk3zFRXM1rV30GvQGkBYr3unLGDc8R/HJ0Mh4KSAEtAApuT1gctVDZspsrVn
 gLVojr9wTvnDF/bXhRxWcLfFAJb+htkYyKc33LWdKSkdR3GP0gFOVWHosKmylHKpGDfe
 K+3b6ue0evQnOs/zDPsSeNYCymSFdYn4M00vB+SEK0+JQtB2UcA5/idnRA0h5PL9XDaD
 bOYg7K7m1EJ3P7ERHR2vnk4VeEZPKwuvNKDdJkeEbThJyXEJP9FM+HHNP/IV8Fv/ryeW
 wBK5I4eg1bbKagOwfOpS9dLn2yF88ilmOzQXpwC2LMlG70FFc08GMnKuNNoocdQYd/jh
 N0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624486; x=1793229286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UFvj94n64zZxkP6dzgX9QegZ0y8Q8iOQPz+mMSLKNnw=;
 b=vOAHIO3dHuIjqerSjfn2fm1uq3D69M7vXVgwOk3pFyCq+YytTQla9PSNf7DqvwYXOP
 ZVruibdry2VWXFrWqqz6dQshHdZY0E8wPILAsItlV4KpTAReKicDxNeRlCdBpLilInWs
 s1l5rizfG4kwLJTxI9qNXnQqpYyy1TyVdTbHrLcrsw0aA+E6MfYAcEomiT6GcFZnqG7v
 O8B3Pj+O9ax6ilmJ05LvYbxvMGaBJD7682P6fYjbC3FT5DXznv1ZBqZZ9u2ajC2UOOBj
 widZfh1UuFaMnfmsqfOXZcjNg7bIDgAKG27AvcQgACeOepUGCOC5NRO7lCYJPaoQ34fh
 AY6g==
X-Gm-Message-State: AFq9FYIZiONVAvWE2l9W097easrCgOK5xXQc3C7ch+tcAV/9AC08N7c9
 GShDYqKT95uuOtyzSMvXk5vNeRdwVq04k710T2tzobnHRqSaz+YGmEkjzGj4FgB1lJvuZyOcMri
 LOktC92pRYuYcGlPURRQwC1+RP+lD+Lf6hYOMOQPExgZYB81/E3chMSl5xpE9vytINw==
X-Gm-Gg: AYBFou0vEmjAdw6zL+c6IdTHdl5P6WArlohgoyYoP4f0XOo3VKT6f8FaTGL2oyK4R/8
 2z216EYwBur8lmkfYRiMEyiT3+SU9LD9nqkc7wvkKeF7GtjHR/13OTEdnoCC5sLd8bjbBm/Kl4M
 5M+fWDVaGH77a2pIpIr1mV9PeBA963wwKDm8PiZfia7SKzXixPZtxxZp/Ggyybyvo4PbgqXUspe
 B/hDae9fA7nxJ0c82OJiFwdA69SUGvIhdpA/N6ymMEIvm3k0nnRmRUln063ZdTnwRf9xFHLcnrz
 A9Z+oWqcPzcqLCTI6GLdR2hPrS6UmStYl1UBDrm04sCmAShr8h4+Sh5rdoRZyUKgHlq4PXsgDiX
 B8aQ6ddC9PGbqDGWXWAX4bRJMrBQkghWBYYdEc5TSOYpakG64aUTzPzk2dF5ZBbqWXqAlIHuryA
 ==
X-Received: by 2002:a05:622a:58e:b0:533:73b3:ab37 with SMTP id
 d75a77b69052e-5369b7d5f3bmr56803991cf.21.1792624486398; 
 Wed, 21 Oct 2026 16:14:46 -0700 (PDT)
X-Received: by 2002:a05:622a:58e:b0:533:73b3:ab37 with SMTP id
 d75a77b69052e-5369b7d5f3bmr56803761cf.21.1792624485975; 
 Wed, 21 Oct 2026 16:14:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:45 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 17/18] hw/riscv/trace: update branch bit in sync messages
Date: Wed, 21 Oct 2026 20:13:44 -0300
Message-ID: <20261021231346.2452179-18-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S8ZMU4sP c=1 sm=1 tr=0 ts=6ad94767 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=l-bS85s7JyIff80a6EEA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 6Yd2QzRkLPB2zFZ3DWDosVpcFJ6OB4C_
X-Proofpoint-GUID: 6Yd2QzRkLPB2zFZ3DWDosVpcFJ6OB4C_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX4zQu9yKV9oId
 /15pbGugkFuEmOPxPLYigycO25Ixp9Eto+qforUUhfAK054HMMYdQn2tFA9udPfi9+3sBPovm+1
 W/UwY5CKMw70pjjLnpIiwr9AhnwtaOswZugIhQAGdmMKI1iv7MDk60GN5c6oZXuov/P7C6wtOnA
 FhKLTS+EEQDxynmanraSvr9AaOHj909zShaPXgJrvAjnjl5z79vxs8Tmhgu2eUO3ZBVM7dIYOum
 DDedxwaYu4wtdz2a9KQsu3jFvIEPB5E2LhapvwCVK4wGbzaxDRbDpjKN0yPjByMBI2/FjSlFkmz
 tB16aLky3vka1GdMibhB4tKohMgXhz+fzLY7lUvXNzL6S2s5MTSsRzmOTCAOdTbbXZbKaCFUPiE
 70jQIGrq586LBaapCov2+QaVXO1fwaxL4jFSTsXvhIR/rwshHJYwg6pvTnDfUHJqdWqOW0XZhbc
 NPtuhgqDb5Fp4fuAceQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfXywIQGywTkjak
 QKF7bVQZuugakxf6Y7ijZoGst56cgIKYzOoK8uaNNBY/3D4rBT1gGCOEWq8qWVCue/Xkky5PP0D
 GqLH0U3ZETT7/No2EvhhKNudus5AtRQ=
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

Now that we have a working branch map update the branch bit in sync
messages by checking if the sync address is a branch address that was
taken (or not).

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/rv-trace-messages.c |  6 +++---
 hw/riscv/rv-trace-messages.h |  3 ++-
 hw/riscv/trace-encoder.c     | 30 ++++++++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 46445a47da..0118ca073b 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -115,11 +115,12 @@ static void rv_etrace_write_header(uint8_t *buf, RVTraceMessageHeader header)
 }
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
-                                      TracePrivLevel priv_level)
+                                      TracePrivLevel priv_level,
+                                      bool pc_is_branch)
 {
     RVTraceSyncPayload payload = {.format = 0b11,
                                   .subformat = 0b00,
-                                  .branch = 1,
+                                  .branch = pc_is_branch,
                                   .privilege = priv_level};
     RVTraceMessageHeader header = {.flow = 0, .extend = 0,
                                    .length = SYNC_PAYLOAD_SIZE_64BITS};
@@ -158,7 +159,6 @@ size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
 {
     RVTraceTrapPayload payload = {.format = 0b11,
                                   .subformat = 0b01,
-                                  .branch = 1,
                                   .privilege = priv_level,
                                   .ecause = ecause};
     RVTraceMessageHeader header = {.flow = 0, .extend = 0,
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index f8f1830852..6f700eac8e 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -20,7 +20,8 @@ typedef enum {
 } TracePrivLevel;
 
 size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
-                                      TracePrivLevel priv_level);
+                                      TracePrivLevel priv_level,
+                                      bool pc_is_branch);
 size_t rv_etrace_gen_encoded_trap_msg(uint8_t *buf, uint64_t trap_addr,
                                       TracePrivLevel priv_level,
                                       uint8_t ecause,
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 290e648083..d5d5ed9563 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -395,15 +395,38 @@ static void trencoder_send_message_smem(TraceEncoder *trencoder,
     trencoder_update_ramsink_writep(trencoder, dest, wrapped);
 }
 
+static bool trencoder_addr_is_branch_taken(TraceEncoder *te, uint64_t addr)
+{
+    uint8_t last_branch;
+
+    if (te->branches == 0) {
+        return false;
+    }
+
+    if (te->last_branch_pc == addr) {
+        last_branch = extract32(te->branches, te->branches - 1, 1);
+
+        /* 0: branch taken, 1: not taken*/
+        if (last_branch == 0) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
     TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    bool is_branch_taken;
 
     trencoder->first_pc = pc;
-    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+    is_branch_taken = trencoder_addr_is_branch_taken(trencoder, pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv,
+                                              is_branch_taken);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
@@ -441,6 +464,7 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
+    bool is_branch_taken;
 
     if (trencoder->updiscon_pending) {
         trencoder_send_updiscon(trencoder, pc);
@@ -448,7 +472,9 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
-    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+    is_branch_taken = trencoder_addr_is_branch_taken(trencoder, pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv,
+                                              is_branch_taken);
 
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
-- 
2.43.0



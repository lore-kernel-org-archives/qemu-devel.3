Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32D6CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1j-0004JY-P4; Mon, 01 Sep 2025 23:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1f-0003pb-MR
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1d-0004ew-4F
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:43 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SEhr022405
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3r9XB5ApdGl0zJJXVSs68EPti39S8JotrbofO4ZR95E=; b=N72ub1ZJp+iTiKnD
 3lVsF2XTiR2KEu9hGTqZPcUrW4gVWrqwfd08z22w0h1ZQs3tc27R9XxcrDLoaMTR
 6BvTAvsuLLMLTI0Cw3V4xaNRZ5raEa06ImzSc7fusoELhW4SvEe8ya1uv7DgaJ8T
 NuixI+iDZDXqRpLQd3tD8fP4X7uLE+SznHNp8tY6XCxZ7vDRP4TwHrZc8AkrAbMc
 KYyP/wG22HjgBjFi3exHdxEYUj/EYejBikivw1hxG5sl5u9J5WDrSZdoiuXTxNs9
 L/PY6YrQTJ7fOjxvv4jqNnJZ6Yolu1T5weCc+GfUft6olbdDdOt4OaXHotENgEHI
 r5XgUQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6hv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4c229e2a42so3573963a12.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784968; x=1757389768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3r9XB5ApdGl0zJJXVSs68EPti39S8JotrbofO4ZR95E=;
 b=qcdNsz0Q4H54KPdudjt0fLM1KaUHgxPmrGFnHpTZpQ5de07XmiSatAZfVzt6JNjN54
 lPHBT/BRxKvh3ouDg9b9MfpHD9d+9BxgPAdrUmUzdRiPpya3/2DzDV9jKUx8TV0LPIJX
 EoUcUynCgU6Wu4ldyn4vbsaFqwcVdD3rl/Lyv/QEcKiFrkEQy3fEutR4nUA0sETB3y/u
 sFP+yfkld7w+Jadxq2wy42HXCV7Zl1Gu0XgAbC5gMqm2RtLjSCR3GfDjy/6BbJuguePE
 w4LsufLEHy1eMIHdSUUIiLnUy+gK60ndPjcb1Ke1u2RatQ5e5zlo0t+tCJFxr37P2btM
 R65Q==
X-Gm-Message-State: AOJu0Yzu1dqF0GdG5httHsxRsAgoSpAQeYSQQdCo5aJE6NErA2Shxz/A
 28BDZsL+t3W5NUMTLxVqzj9cVei9PWlZBlxJGR8VEx0hffU9wbKoOSSxhw1R9HCviRdloba15Yi
 kJekgDWT+ZW5YWZ3EOtitFoIqs7zGfXHYi/SkbCl3x1gvzSfd8D0LIfy66T+HqCmCTNB8
X-Gm-Gg: ASbGncvPpWllgdEaqRIObIUrDfiN92t8Gx4As26F/yO1s7VPVApzzWV/bmtTLwfr7U0
 ZYu2rgDSFvBm+Y44UJ6anCqOlVuKtaoNYVYHY9rRF9G3QIl+ERzED8kzAq7p5Cp5C8+jDsAMX3s
 bI7Nhjq6/+IW/EBBJCD/K06qrl6AZkPJ7H/Auq7fPmdKSJy7sqMELF4yzn0pY7ORfEWLTKxe4ND
 tPadA7jq9RhEjnv454u05ujD5ZLAJ+2Peav4jUNj6jiXCBK6o9eYAGKGF9MBUNVMLSxVEj0DlE2
 DuXPXC/3d3DL78iJHDAEHqkI8TSROdBHyfXEbm98JvrFMrtdbl1n8jV00NYANBeNyvuKXPLY6IN
 QWf4vTv2hbnmS
X-Received: by 2002:a17:90b:3148:b0:328:650:4e7a with SMTP id
 98e67ed59e1d1-32815412274mr13594797a91.3.1756784968222; 
 Mon, 01 Sep 2025 20:49:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiw4IuRjfaE7GOIK3xUBxzcM85eeSUeG6gW+wxX8LF7w4Xh31xxdhN+a9W+VtaHPyi4//Ung==
X-Received: by 2002:a17:90b:3148:b0:328:650:4e7a with SMTP id
 98e67ed59e1d1-32815412274mr13594762a91.3.1756784967666; 
 Mon, 01 Sep 2025 20:49:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 29/39] target/hexagon: Add pkt_ends_tb to translation
Date: Mon,  1 Sep 2025 20:48:37 -0700
Message-Id: <20250902034847.1948010-30-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AZzqbxHC6DbTqMjAvbyyBq3ji4E9x8mx
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b66949 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=imK-vThzYG-NRbbrpigA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AZzqbxHC6DbTqMjAvbyyBq3ji4E9x8mx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX/A+LeQLfaLdJ
 Uq+THYORMD0rgaR6JTakOl/lUhHiN5RBCrREyRE8mYL3zo+uTchnFpaiLbg+i0iSgTdgszTz1k1
 l2ccCLOd79YK3+IuigIRCe3CR+mKhJXDoxPoEnGO6pKxWkXnVXexvOAVhfiNzyZvuOLmBCYxR+p
 3P3BpjX+jNWT70rSS8e898TAnBW7RRZ28VHsMOf/mQp39sifkMNzVYMmAVImvcyFHGJ/2ms9zjc
 Jei6+wkMWtMx3aU4C/EzZboQQbIa/CxqHmddFMJPu+0zERia5irpzX+STkn/TfBlODfW/pTsUzE
 FFzRysNq1bKbdJi0i1HtV8nMwn8zV7IDukCLZLMhssPW+elMqhzOND4eRIY6+/2iMD0OyB8Lpvb
 s2W/Ib9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/translate.h |   1 +
 target/hexagon/translate.c | 102 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 0bdf526a9e..08194a3309 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -84,6 +84,7 @@ typedef struct DisasContext {
     TCGv branch_taken;
     TCGv dczero_addr;
     bool pcycle_enabled;
+    bool pkt_ends_tb;
     uint32_t num_cycles;
 } DisasContext;
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index a71fa33ccf..92adc60d1a 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -258,6 +258,16 @@ static bool check_for_attrib(Packet *pkt, int attrib)
     return false;
 }
 
+static bool check_for_opcode(Packet *pkt, uint16_t opcode)
+{
+    for (int i = 0; i < pkt->num_insns; i++) {
+        if (pkt->insn[i].opcode == opcode) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static bool need_slot_cancelled(Packet *pkt)
 {
     /* We only need slot_cancelled for conditional store instructions */
@@ -271,6 +281,90 @@ static bool need_slot_cancelled(Packet *pkt)
     return false;
 }
 
+#ifndef CONFIG_USER_ONLY
+static bool sreg_write_to_global(int reg_num)
+{
+    return reg_num == HEX_SREG_SSR ||
+           reg_num == HEX_SREG_STID ||
+           reg_num == HEX_SREG_IMASK ||
+           reg_num == HEX_SREG_IPENDAD ||
+           reg_num == HEX_SREG_BESTWAIT ||
+           reg_num == HEX_SREG_SCHEDCFG;
+}
+
+static bool has_sreg_write_to_global(Packet const *pkt)
+{
+    for (int i = 0; i < pkt->num_insns; i++) {
+        Insn const *insn = &pkt->insn[i];
+        uint16_t opcode = insn->opcode;
+        if (opcode == Y2_tfrsrcr) {
+            /* Write to a single sreg */
+            int reg_num = insn->regno[0];
+            if (sreg_write_to_global(reg_num)) {
+                return true;
+            }
+        } else if (opcode == Y4_tfrspcp) {
+            /* Write to a sreg pair */
+            int reg_num = insn->regno[0];
+            if (sreg_write_to_global(reg_num)) {
+                return true;
+            }
+            if (sreg_write_to_global(reg_num + 1)) {
+                return true;
+            }
+        }
+    }
+    return false;
+}
+#endif
+
+static bool pkt_ends_tb(Packet *pkt)
+{
+    if (pkt->pkt_has_cof) {
+        return true;
+    }
+#ifndef CONFIG_USER_ONLY
+    /* System mode instructions that end TLB */
+    if (check_for_opcode(pkt, Y2_swi) ||
+        check_for_opcode(pkt, Y2_cswi) ||
+        check_for_opcode(pkt, Y2_ciad) ||
+        check_for_opcode(pkt, Y4_siad) ||
+        check_for_opcode(pkt, Y2_wait) ||
+        check_for_opcode(pkt, Y2_resume) ||
+        check_for_opcode(pkt, Y2_iassignw) ||
+        check_for_opcode(pkt, Y2_setimask) ||
+        check_for_opcode(pkt, Y4_nmi) ||
+        check_for_opcode(pkt, Y2_setprio) ||
+        check_for_opcode(pkt, Y2_start) ||
+        check_for_opcode(pkt, Y2_stop) ||
+        check_for_opcode(pkt, Y2_k0lock) ||
+        check_for_opcode(pkt, Y2_k0unlock) ||
+        check_for_opcode(pkt, Y2_tlblock) ||
+        check_for_opcode(pkt, Y2_tlbunlock) ||
+        check_for_opcode(pkt, Y2_break) ||
+        check_for_opcode(pkt, Y2_isync) ||
+        check_for_opcode(pkt, Y2_syncht) ||
+        check_for_opcode(pkt, Y2_tlbp) ||
+        check_for_opcode(pkt, Y2_tlbw) ||
+        check_for_opcode(pkt, Y5_ctlbw) ||
+        check_for_opcode(pkt, Y5_tlbasidi)) {
+        return true;
+    }
+
+    /*
+     * Check for sreg writes that would end the TB
+     */
+    if (check_for_attrib(pkt, A_IMPLICIT_WRITES_SSR)) {
+        return true;
+    }
+    if (has_sreg_write_to_global(pkt)) {
+        return true;
+    }
+#endif
+    return false;
+}
+
+
 static bool need_next_PC(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
@@ -426,7 +520,10 @@ static void analyze_packet(DisasContext *ctx)
 static void gen_start_packet(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
-    target_ulong next_PC = ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
+    target_ulong next_PC = (check_for_opcode(pkt, Y2_k0lock) ||
+                            check_for_opcode(pkt, Y2_tlblock)) ?
+                               ctx->base.pc_next :
+                               ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
     int i;
 
     /* Clear out the disassembly context */
@@ -472,6 +569,7 @@ static void gen_start_packet(DisasContext *ctx)
         tcg_gen_movi_tl(hex_slot_cancelled, 0);
     }
     ctx->branch_taken = NULL;
+    ctx->pkt_ends_tb = pkt_ends_tb(pkt);
     if (pkt->pkt_has_cof) {
         ctx->branch_taken = tcg_temp_new();
         if (pkt->pkt_has_multi_cof) {
@@ -926,7 +1024,7 @@ static void gen_commit_packet(DisasContext *ctx)
         pkt->vhist_insn->generate(ctx);
     }
 
-    if (pkt->pkt_has_cof) {
+    if (ctx->pkt_ends_tb || ctx->base.is_jmp == DISAS_NORETURN) {
         gen_end_tb(ctx);
     }
 }
-- 
2.34.1



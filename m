Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB58FECD6F6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 22:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqIZH-0005O6-UX; Wed, 11 Feb 2026 17:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqIZ6-0005LV-NH
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:20:10 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqIZ3-000584-Dj
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:20:08 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61BKsb7b519173
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yw6tKRnOp3N144RB9s7s38SD2PNdjLOlfuEnat2PGzw=; b=Kn4ZjDZyVan+vpIA
 POBxLtJdahAHRo17FDYZJPZxqr+PVcc+geR5klINchzfwB0cfZfKyzEGhG5qLBXC
 3N60WTqKfkndmA4K0h9QzRtGIVInNkPcNrLbUr43hRoBHaaeNsCDEr/NYD3dnyFT
 lURjzgkh9nxwJNvsVR9QwNTRlESsGao023nZMpgVSfE1bb+xaZuUNbM1WE1BERcz
 +CcAoxw3mMj7+YglmBbYnciSKWrOQk+13iXxVH1/e6A+ni0iqMT8Anlxml6Ht5Xq
 s27ebUOHENTy8d/3AUbG2dE2kRXinZqCAqcOMDI5sIVyLimYoItGbuy39JOYwVhq
 8qaMsw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8sup9vp5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:20:04 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1270878c3fdso7109358c88.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 14:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770848403; x=1771453203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yw6tKRnOp3N144RB9s7s38SD2PNdjLOlfuEnat2PGzw=;
 b=Hm7oJ+DxN1a+VtBVR+vnOSqTj/SzJSoAV72CujcgYNAYud4tpRXL5TGQrJ0shCfDOl
 6vhVKSCiNMzw26+XqltKw6HB+Vm7pvBGSPxwKcTQBhV5oc5rOEVEpsFZ3PxuGTM3oPMd
 yMHpYP0YmBwBVUQuqidMSrNA8WouTPhMdL+UFEHzSRsPaqUlZlrRXIl3ctDFMMLyfMER
 bR14rUZ5H5dMmNg9PwhLVzAu0S4HQq5qQYHa4fFGzw1fCSLx7n4w9mI92zD1azKzYx0t
 cKTWAnxfi0YsrbPkImoqh4Uzzbl53TrlbXZgJucz0ZUEVgr9gGDVKa5XaLVCQZPtijjq
 kCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848403; x=1771453203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yw6tKRnOp3N144RB9s7s38SD2PNdjLOlfuEnat2PGzw=;
 b=Mh68PXo76wDkY8PNgowf3e8fSd9z5YTm5zwuJnkugpaEpVa/NLPJzpUEgUsDUvCDbZ
 MpMVS3GG5c7rs2BvmDqghmuO2+nYzdrNwhkTpjtOl+N0wSWXDuB46ptCOJfdVp6pEIlu
 xxk2WaqNUQXzPG9JaKhMvO1FzifqjPoU7a6MA8KUL6hXaQSYya+hPKJlLtqC2iU0rcrO
 ZH1dH9657W+XXdp9wwjXyZMjU1o4Bab4EeBNZ2vrBaU7oGkRzeoAuYg8igpbf3fyxoq7
 56fVF7ei40R+CoF7VnhBI3lJqIdW4f0HPAPTSPyU3oCYabIeky101Znk9+LDq9AizExF
 eOnA==
X-Gm-Message-State: AOJu0Yw7wYwmmM+l8lI+sbC9gArhTY6Xp6FRFBiScM/HjyXiuc8DHLA2
 1adofKfywbxtjPzilj1f6tdXqkMJDfYPMw0c+1VfJURSwnMlGQwtVPJiANv2pxsH6Enm+BcAPGG
 8Bxj+J1M+3eMD4EJrtzLmgUPd40Zz/um3CZEeXt70UDR0FkkZt7nMLyCwyGjTLT02bA==
X-Gm-Gg: AZuq6aIV7qIvF5mfjCW8U6ZKIqk3HRIfdVM4yQ8UuKqWGykegNlWF8fPDXFbUMk6ZrP
 KZQWTv5U28qaF3M4XHJi+gKHW5TEt8rq4gm0VAo3hLIP6i0eIUgssDLjTUo6iV1Nr4n+XRXJkjr
 5svZOUf2fpD5h8Jhd3eZyrEwmksg1olh449/07Vu+WVBy1VP7o9NlY9HQvmOztTNuHZ4WlhE4sk
 KAMTfynMrVB3G9Re/FxCQe3bZeZqfNGxppJvghDgqZ1HSfgkEZSjE0KxCBeGgp+S8KJa6n2XKSO
 nyFa92vnRs0sOkEoAREoMhVY0vIuOwLMCgK745nUgDDfDwKrkSXkQgLjyfrNGhqFKGLvPiQdYeY
 DIWfIFduChqHbSJYEEynHabOaU604BPkhYw9RjiIfnpmZ44QoTEPQssQNb0vodEOHyqOvBA==
X-Received: by 2002:a05:7022:238d:b0:11f:2c9e:87f8 with SMTP id
 a92af1059eb24-1272f7a13e8mr325304c88.34.1770848403088; 
 Wed, 11 Feb 2026 14:20:03 -0800 (PST)
X-Received: by 2002:a05:7022:238d:b0:11f:2c9e:87f8 with SMTP id
 a92af1059eb24-1272f7a13e8mr325289c88.34.1770848402318; 
 Wed, 11 Feb 2026 14:20:02 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba9dbe123asm2588379eec.13.2026.02.11.14.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:20:01 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com
Subject: [PATCH v4 4/4] target/hexagon: Detect register write conflicts
Date: Wed, 11 Feb 2026 14:19:53 -0800
Message-Id: <20260211221953.4099441-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211221953.4099441-1-brian.cain@oss.qualcomm.com>
References: <20260211221953.4099441-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE3MSBTYWx0ZWRfX/v0gy2yjnwDX
 umYtMDkjhS9UyCbFtkQM4ib+Wgbzk0S0ZwM1TPavaHoSEfiHVudwQAJU0gp8PM5h7txfGiyy9ig
 1zEgJi59jY3YuEfHaQoj4Z8HcvuA4lJKtB6iozpcl3FWkbsyh6CgE3rIr+5vc5LcYhPpDBqHsMN
 tkitWZRf06nO2h+ALajKJCHlR+VPNS1tLY3k2Kd0f1vo4p1/VnKff9nmKXEZK6T6MgdyrzbgJkv
 jgXDosJaFdo0X6wSTbSkb8xnbpRZxDVKxUdMta6Z6OPwo/GYyaz9z9wQNF8/sQpZ08S2EHDIocZ
 ELqvhBMrD4cAkmPSbT+7vAL80vgTI5/zE1StmoCaJ3dJqOqq+CK/eKDkmE/UTAPb3DP9vkfJF/a
 tTSx4dd/mtZojd2szlsQORVw14g3u2P+Q1hc6/sD6kn2SxWGdF1czw4eH21Ir4Do+e51g/Q4iBW
 Y0gMH8UkIu6uALiqP7g==
X-Proofpoint-GUID: CTHuzx62QJsretE6Stx2_8Z-VyHf8sv7
X-Authority-Analysis: v=2.4 cv=Uslu9uwB c=1 sm=1 tr=0 ts=698d0094 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=y1hdNQ4epmxxkZQEW8sA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: CTHuzx62QJsretE6Stx2_8Z-VyHf8sv7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110171
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

A conflict exists when any GPR is written by multiple instructions and
at least one write is unconditional.  This catches (1) two unconditional
writes to the same GPR and (2) an unconditional write combined with a
predicated write.

Add HEX_CAUSE_REG_WRITE_CONFLICT and map it to SIGILL.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2696
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 linux-user/hexagon/cpu_loop.c       |   1 +
 target/hexagon/cpu_bits.h           |   1 +
 target/hexagon/decode.c             |  54 +++++++++
 target/hexagon/gen_trans_funcs.py   |  10 ++
 target/hexagon/insn.h               |   4 +
 target/hexagon/translate.c          |  10 +-
 tests/tcg/hexagon/Makefile.target   |   1 +
 tests/tcg/hexagon/multiple-writes.c | 169 ++++++++++++++++++++++++++++
 8 files changed, 248 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/hexagon/multiple-writes.c

diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index c0e1098e3f..5711055aff 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -65,6 +65,7 @@ void cpu_loop(CPUHexagonState *env)
                             env->gpr[HEX_REG_R31]);
             break;
         case HEX_CAUSE_INVALID_PACKET:
+        case HEX_CAUSE_REG_WRITE_CONFLICT:
             force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
                             env->gpr[HEX_REG_PC]);
             break;
diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index ff596e2a94..19beca81c0 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -34,6 +34,7 @@ enum hex_cause {
     HEX_CAUSE_FETCH_NO_UPAGE =  0x012,
     HEX_CAUSE_INVALID_PACKET =  0x015,
     HEX_CAUSE_INVALID_OPCODE =  0x015,
+    HEX_CAUSE_REG_WRITE_CONFLICT = 0x01d,
     HEX_CAUSE_PC_NOT_ALIGNED =  0x01e,
     HEX_CAUSE_PRIV_NO_UREAD  =  0x024,
     HEX_CAUSE_PRIV_NO_UWRITE =  0x025,
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 33ad60c5b4..00d4a79a95 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -655,6 +655,55 @@ decode_set_slot_number(Packet *pkt)
     return has_valid_slot_assignment(pkt);
 }
 
+/*
+ * Check for GPR write conflicts in the packet.
+ * A conflict exists when a register is written by more than one instruction
+ * and at least one of those writes is unconditional.
+ *
+ * TODO: handle the more general case of any
+ * packet w/multiple-register-write operands.
+ */
+static bool pkt_has_write_conflict(Packet *pkt)
+{
+    DECLARE_BITMAP(all_dest_gprs, 32) = { 0 };
+    DECLARE_BITMAP(wreg_mult_gprs, 32) = { 0 };
+    DECLARE_BITMAP(uncond_wreg_gprs, 32) = { 0 };
+    DECLARE_BITMAP(conflict, 32);
+
+    for (int i = 0; i < pkt->num_insns; i++) {
+        Insn *insn = &pkt->insn[i];
+        int dest = insn->dest_idx;
+
+        if (dest < 0 || !insn->dest_is_gpr) {
+            continue;
+        }
+
+        int rnum = insn->regno[dest];
+        bool is_uncond = !GET_ATTRIB(insn->opcode, A_CONDEXEC);
+
+        if (test_bit(rnum, all_dest_gprs)) {
+            set_bit(rnum, wreg_mult_gprs);
+        }
+        set_bit(rnum, all_dest_gprs);
+        if (is_uncond) {
+            set_bit(rnum, uncond_wreg_gprs);
+        }
+
+        if (insn->dest_is_pair) {
+            if (test_bit(rnum + 1, all_dest_gprs)) {
+                set_bit(rnum + 1, wreg_mult_gprs);
+            }
+            set_bit(rnum + 1, all_dest_gprs);
+            if (is_uncond) {
+                set_bit(rnum + 1, uncond_wreg_gprs);
+            }
+        }
+    }
+
+    bitmap_and(conflict, wreg_mult_gprs, uncond_wreg_gprs, 32);
+    return !bitmap_empty(conflict, 32);
+}
+
 /*
  * decode_packet
  * Decodes packet with given words
@@ -674,6 +723,10 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
 
     /* Initialize */
     memset(pkt, 0, sizeof(*pkt));
+    for (i = 0; i < INSTRUCTIONS_MAX; i++) {
+        pkt->insn[i].dest_idx = -1;
+        pkt->insn[i].new_read_idx = -1;
+    }
     /* Try to build packet */
     while (!end_of_packet && (words_read < max_words)) {
         Insn *insn = &pkt->insn[num_insns];
@@ -737,6 +790,7 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
             /* Invalid packet */
             return 0;
         }
+        pkt->pkt_has_write_conflict = pkt_has_write_conflict(pkt);
     }
     decode_fill_newvalue_regno(pkt);
 
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 45da1b7b5d..19c1f9fdea 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -91,6 +91,8 @@ def gen_trans_funcs(f):
         new_read_idx = -1
         dest_idx = -1
         dest_idx_reg_id = None
+        dest_is_pair = "false"
+        dest_is_gpr = "false"
         has_pred_dest = "false"
         for regno, (reg_type, reg_id, *_) in enumerate(regs):
             reg = hex_common.get_register(tag, reg_type, reg_id)
@@ -104,6 +106,12 @@ def gen_trans_funcs(f):
                 if dest_idx_reg_id is None or reg_id < dest_idx_reg_id:
                     dest_idx = regno
                     dest_idx_reg_id = reg_id
+                    dest_is_pair = ("true"
+                                    if isinstance(reg, hex_common.Pair)
+                                    else "false")
+                    dest_is_gpr = ("true"
+                                   if reg_type == "R"
+                                   else "false")
             if reg_type == "P" and reg.is_written() and not reg.is_read():
                 has_pred_dest = "true"
 
@@ -129,6 +137,8 @@ def gen_trans_funcs(f):
         f.write(code_fmt(f"""\
             insn->new_read_idx = {new_read_idx};
             insn->dest_idx = {dest_idx};
+            insn->dest_is_pair = {dest_is_pair};
+            insn->dest_is_gpr = {dest_is_gpr};
             insn->has_pred_dest = {has_pred_dest};
         """))
         f.write(textwrap.dedent(f"""\
diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
index 5d59430da9..835b1c954e 100644
--- a/target/hexagon/insn.h
+++ b/target/hexagon/insn.h
@@ -41,6 +41,8 @@ struct Instruction {
     uint32_t new_value_producer_slot:4;
     int32_t new_read_idx;
     int32_t dest_idx;
+    bool dest_is_pair;
+    bool dest_is_gpr;
     bool has_pred_dest;
 
     bool part1;              /*
@@ -72,6 +74,8 @@ struct Packet {
     bool pkt_has_hvx;
     Insn *vhist_insn;
 
+    bool pkt_has_write_conflict;
+
     Insn insn[INSTRUCTIONS_MAX];
 };
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 7fe8b35351..0234bbf15d 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -943,7 +943,7 @@ static void gen_commit_packet(DisasContext *ctx)
 static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
 {
     uint32_t words[PACKET_WORDS_MAX];
-    int nwords;
+    int nwords, words_read;
     Packet pkt;
     int i;
 
@@ -954,8 +954,14 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
     }
 
     ctx->pkt = &pkt;
-    if (decode_packet(ctx, nwords, words, &pkt, false) > 0) {
+    words_read = decode_packet(ctx, nwords, words, &pkt, false);
+    if (words_read > 0) {
         pkt.pc = ctx->base.pc_next;
+        if (pkt.pkt_has_write_conflict) {
+            gen_exception_decode_fail(ctx, words_read,
+                                      HEX_CAUSE_REG_WRITE_CONFLICT);
+            return;
+        }
         gen_start_packet(ctx);
         for (i = 0; i < pkt.num_insns; i++) {
             ctx->insn = &pkt.insn[i];
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index d64aeba090..f86f02bb31 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -52,6 +52,7 @@ HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += invalid-slots
 HEX_TESTS += invalid-encoding
+HEX_TESTS += multiple-writes
 HEX_TESTS += unaligned_pc
 
 HEX_TESTS += test_abs
diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
new file mode 100644
index 0000000000..8686317fdc
--- /dev/null
+++ b/tests/tcg/hexagon/multiple-writes.c
@@ -0,0 +1,169 @@
+/*
+ * Test detection of multiple writes to the same register.
+ *
+ * Ported from the system test (tests/tcg/hexagon/system/multiple_writes.c).
+ * In linux-user mode, duplicate GPR writes are detected at translate time
+ * and raise SIGILL when at least one conflicting write is unconditional.
+ * Purely predicated duplicate writes (e.g., complementary if/if-not) are
+ * legal and are not flagged statically.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void *resume_pc;
+
+static void handle_sigill(int sig, siginfo_t *info, void *puc)
+{
+    ucontext_t *uc = (ucontext_t *)puc;
+
+    if (sig != SIGILL) {
+        _exit(EXIT_FAILURE);
+    }
+
+    uc->uc_mcontext.r0 = SIGILL;
+    uc->uc_mcontext.pc = (unsigned long)resume_pc;
+}
+
+/*
+ * Unconditional pair write overlapping a single write:
+ *   { r1:0 = add(r3:2, r3:2);  r1 = add(r0, r1) }
+ * R1 is written by both instructions.  This is invalid and must raise SIGILL.
+ */
+static int test_static_pair_overlap(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0xd30242e0\n"  /* r1:0 = add(r3:2, r3:2), parse=01 */
+        ".word 0xf300c101\n"  /* r1 = add(r0, r1), parse=11 (end) */
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
+/*
+ * Two predicated writes under complementary predicates:
+ *   { if (p0) r0 = r2;  if (!p0) r0 = r3 }
+ * This is architecturally valid: only one write executes at runtime.
+ * Must NOT raise SIGILL; the result should reflect the executed branch.
+ */
+static int test_legal_predicated(void)
+{
+    int result;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        "r2 = #7\n"
+        "r3 = #13\n"
+        "p0 = cmp.eq(r2, r2)\n"
+        "{\n"
+        "    if (p0) r0 = r2\n"
+        "    if (!p0) r0 = r3\n"
+        "}\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(result)
+        : "r"(&resume_pc)
+        : "r0", "r1", "r2", "r3", "p0", "memory");
+
+    return result;
+}
+
+/*
+ * Mixed: unconditional + predicated writes to the same register:
+ *   { if (p0) r1 = add(r0, #0);  if (!p0) r1 = add(r0, #0);
+ *     r1 = add(r0, #0) }
+ * The unconditional write always conflicts with the predicated writes.
+ * Must raise SIGILL.
+ */
+static int test_mixed_writes(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        "p0 = cmp.eq(r0, r0)\n"
+        ".word 0x7e204021\n"  /* if (p0) r1 = add(r0, #0), parse=01 */
+        ".word 0x7ea04021\n"  /* if (!p0) r1 = add(r0, #0), parse=01 */
+        ".word 0x7800c021\n"  /* r1 = add(r0, #0), parse=11 (end) */
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "p0", "memory");
+
+    return sig;
+}
+
+/*
+ * Zero encoding (issue #2696):
+ * The encoding 0x00000000 decodes as a duplex with parse bits
+ * [15:14] = 0b00:
+ *   slot1: SL1_loadri_io R0 = memw(R0+#0x0)
+ *   slot0: SL1_loadri_io R0 = memw(R0+#0x0)
+ *
+ * Both sub-instructions write R0 unconditionally, which is an invalid
+ * packet.  This tests what happens when we jump to zeroed memory.
+ * Must raise SIGILL.
+ */
+static int test_zero(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x00000000\n"
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
+int main()
+{
+    struct sigaction act;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigill;
+    act.sa_flags = SA_SIGINFO;
+    assert(sigaction(SIGILL, &act, NULL) == 0);
+
+    /* Legal: complementary predicated writes must not raise SIGILL */
+    assert(test_legal_predicated() == 7);
+
+    /* Illegal: unconditional pair + single overlap must raise SIGILL */
+    assert(test_static_pair_overlap() == SIGILL);
+
+    /* Illegal: unconditional + predicated writes to same reg must SIGILL */
+    assert(test_mixed_writes() == SIGILL);
+
+    /* Illegal: zero encoding = duplex with duplicate dest R0 */
+    assert(test_zero() == SIGILL);
+
+    puts("PASS");
+    return EXIT_SUCCESS;
+}
-- 
2.34.1



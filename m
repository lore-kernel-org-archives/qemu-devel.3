Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1D1C88E7F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EZx-0003xA-Cm; Mon, 14 Sep 2026 17:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZm-0003vg-4q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:59 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1x6EZk-0001BD-8p
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:50:57 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4b381337e1fso3986842b6e.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789422655; x=1790027455; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kvjJo7XlO1sJZFOXKUy7l+awTuxFTdsrESZN/Ob/T6c=;
 b=aOyAuuJqPYWCDTk4SL3+3HwFI8txOcis9YswJxchMxLYb37EJ6IrpTEKHrS6vjGmte
 MTKF3PAxkfT3g0w8B3qtQ2A6iBuYsv6RiH1B2do2xtg+Tg+9XWtcJx1JJx2TR30k9qTc
 qRogalyGaQXIuOYAJVnyme5xJjVmfsuFaEHvK/m2N11R84dCw/vsXRfkoGBjqLdpqo7J
 P1b0Ly49rk8uVTjczLssPiuYdIoeM5uywfq6tdW/rrEIwbt/SfSR6AKrI1ANyurc5gza
 aUOaJvfFbN65M1LAipjol7CwIQzVgPBliBCatXFdB1hTcBVyLs5VCWM6OAxcbsxOZpY5
 BL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789422655; x=1790027455;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kvjJo7XlO1sJZFOXKUy7l+awTuxFTdsrESZN/Ob/T6c=;
 b=TecSB4hn+jSJUlI3iZiaf3X6FvXLuo6Yupu0Dd24tr1BmjpNp32tNY3RtU+C9KuMNA
 0TvqvEN+rBXwIOGxSWB/YbSYKUIDkp28DseNzJGM95URD6EfPSI3RVK7HGfO5FfttFrv
 7XyuPoMlsCnTO3Lmre7tSyCzcmy1a7Mq/X7DOCUT6/cIDYgUHliSFp9VGV1+WkkR49HD
 RCfY+duqvIyPv8BNiH7UDuty77Gie1Z/X1IfRixQd7z4HL13ST0OnILQMXWm6UGpbQoE
 FUWIpwEc5MdJqZ2F82lHvV42lslSLZpkRbg3DjkVQwm3EF/zdxtzHOeYkNQUeiOE5Dgu
 yn5Q==
X-Gm-Message-State: AFuF++kcRRKLjf7L/jMblXje6+YwA7Izz0wxhY78QgXUqlnOhMwwnSxf
 o99/ZUeq7GONqFE/5L9AuihgIRrMCvKL5+4YQ2w+qdLmjwy10AXdso7Z7JViNOV4
X-Gm-Gg: AYBFou0SvuqHua2V04zERmcf7bJ8J5XlMtW9TMeWWEv19EkEsx76o7oCfutFsu/O8FI
 Q2MyWUjqWO+rikJKsapZ2FcrimbgCGgRwfXiCGxJhlOqIdPEviRxFOUPiC77jR/vrUkj04jhjLg
 5k8nTNFQCPJ/ntfeoYgqksWgqPJtLaytSOrnhrgwEDKXtUGefQgwZpRCvF6yRTwdJxQf/uRbJGE
 gMikmcB2xGUqGzo/6MgZ2KEqBkp8XFkakM4w8xDHAe+6ABplAQYy7gww788M/LKPRXRoqfA9G1w
 kxdJuf51B/+MFf+HA3ZY60SPuYU/u7K9qFXFpAB3o6yXszc3E/WcGyk3xiPAiAnKmMpfc4e2F3Y
 Vt9cJ8KhaFnOyBgCUkB34rJD/TT0S6Oj8Jgm4VCX/lWtlsTz7CL/Jg9z6FGI01tZ57BbFVPOPkk
 3zTiSKR0yvXfOz33ysvFsIIuME2DsDmOEAxV1jXMoJQ/eOP/nOXZWqKYagU+MOJNKkqlRFkVf5n
 KjdhKo/m9LhDyVOiVqjxvYZBTWf9HUa/itObZ1fda8Jsoai397wcT8Mwx/LBa9F
X-Received: by 2002:a05:6808:f03:b0:4c2:dd8a:fa46 with SMTP id
 5614622812f47-4c7b2906dc3mr3786925b6e.16.1789422654935; 
 Mon, 14 Sep 2026 14:50:54 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c4a2504bc4sm8937163b6e.17.2026.09.14.14.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:50:54 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v3 10/10] Hexagon (target/hexagon) Remove old way of detecting
 register multiwrites
Date: Mon, 14 Sep 2026 15:50:36 -0600
Message-ID: <20260914215037.157879-11-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We now detect register multiwrites in packet analysis instead of
packet decoding

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/insn.h             |  4 ---
 target/hexagon/decode.c           | 54 -------------------------------
 target/hexagon/translate.c        |  6 ----
 target/hexagon/gen_trans_funcs.py | 10 ------
 4 files changed, 74 deletions(-)

diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
index 835b1c954e..5d59430da9 100644
--- a/target/hexagon/insn.h
+++ b/target/hexagon/insn.h
@@ -41,8 +41,6 @@ struct Instruction {
     uint32_t new_value_producer_slot:4;
     int32_t new_read_idx;
     int32_t dest_idx;
-    bool dest_is_pair;
-    bool dest_is_gpr;
     bool has_pred_dest;
 
     bool part1;              /*
@@ -74,8 +72,6 @@ struct Packet {
     bool pkt_has_hvx;
     Insn *vhist_insn;
 
-    bool pkt_has_write_conflict;
-
     Insn insn[INSTRUCTIONS_MAX];
 };
 
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index b12e91fe6a..89e961331f 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -691,55 +691,6 @@ bool opcode_supported(uint16_t opcode, const HexagonCPUDef *hex_def)
     return true;
 }
 
-/*
- * Check for GPR write conflicts in the packet.
- * A conflict exists when a register is written by more than one instruction
- * and at least one of those writes is unconditional.
- *
- * TODO: handle the more general case of any
- * packet w/multiple-register-write operands.
- */
-static bool pkt_has_write_conflict(Packet *pkt)
-{
-    DECLARE_BITMAP(all_dest_gprs, 32) = { 0 };
-    DECLARE_BITMAP(wreg_mult_gprs, 32) = { 0 };
-    DECLARE_BITMAP(uncond_wreg_gprs, 32) = { 0 };
-    DECLARE_BITMAP(conflict, 32);
-
-    for (int i = 0; i < pkt->num_insns; i++) {
-        Insn *insn = &pkt->insn[i];
-        int dest = insn->dest_idx;
-
-        if (dest < 0 || !insn->dest_is_gpr) {
-            continue;
-        }
-
-        int rnum = insn->regno[dest];
-        bool is_uncond = !GET_ATTRIB(insn->opcode, A_CONDEXEC);
-
-        if (test_bit(rnum, all_dest_gprs)) {
-            set_bit(rnum, wreg_mult_gprs);
-        }
-        set_bit(rnum, all_dest_gprs);
-        if (is_uncond) {
-            set_bit(rnum, uncond_wreg_gprs);
-        }
-
-        if (insn->dest_is_pair) {
-            if (test_bit(rnum + 1, all_dest_gprs)) {
-                set_bit(rnum + 1, wreg_mult_gprs);
-            }
-            set_bit(rnum + 1, all_dest_gprs);
-            if (is_uncond) {
-                set_bit(rnum + 1, uncond_wreg_gprs);
-            }
-        }
-    }
-
-    bitmap_and(conflict, wreg_mult_gprs, uncond_wreg_gprs, 32);
-    return !bitmap_empty(conflict, 32);
-}
-
 /*
  * decode_packet
  * Decodes packet with given words
@@ -759,10 +710,6 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
 
     /* Initialize */
     memset(pkt, 0, sizeof(*pkt));
-    for (i = 0; i < INSTRUCTIONS_MAX; i++) {
-        pkt->insn[i].dest_idx = -1;
-        pkt->insn[i].new_read_idx = -1;
-    }
     /* Try to build packet */
     while (!end_of_packet && (words_read < max_words)) {
         Insn *insn = &pkt->insn[num_insns];
@@ -837,7 +784,6 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
             /* Invalid packet */
             return 0;
         }
-        pkt->pkt_has_write_conflict = pkt_has_write_conflict(pkt);
     }
     decode_fill_newvalue_regno(pkt);
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index a35c6c6835..acf9407481 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1249,12 +1249,6 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         clear_pkt_ctx(ctx);
         analyze_packet(ctx);
 
-        /*
-         * Check that the new method is a superset of the old methond
-         * Remove in a later patch
-         */
-        g_assert(!ctx->pkt.pkt_has_write_conflict ||
-                 pkt_has_write_conflict(ctx));
         if (pkt_has_write_conflict(ctx)) {
             gen_exception_decode_fail(ctx, words_read,
                                       HEX_CAUSE_REG_WRITE_CONFLICT);
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 19c1f9fdea..45da1b7b5d 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -91,8 +91,6 @@ def gen_trans_funcs(f):
         new_read_idx = -1
         dest_idx = -1
         dest_idx_reg_id = None
-        dest_is_pair = "false"
-        dest_is_gpr = "false"
         has_pred_dest = "false"
         for regno, (reg_type, reg_id, *_) in enumerate(regs):
             reg = hex_common.get_register(tag, reg_type, reg_id)
@@ -106,12 +104,6 @@ def gen_trans_funcs(f):
                 if dest_idx_reg_id is None or reg_id < dest_idx_reg_id:
                     dest_idx = regno
                     dest_idx_reg_id = reg_id
-                    dest_is_pair = ("true"
-                                    if isinstance(reg, hex_common.Pair)
-                                    else "false")
-                    dest_is_gpr = ("true"
-                                   if reg_type == "R"
-                                   else "false")
             if reg_type == "P" and reg.is_written() and not reg.is_read():
                 has_pred_dest = "true"
 
@@ -137,8 +129,6 @@ def gen_trans_funcs(f):
         f.write(code_fmt(f"""\
             insn->new_read_idx = {new_read_idx};
             insn->dest_idx = {dest_idx};
-            insn->dest_is_pair = {dest_is_pair};
-            insn->dest_is_gpr = {dest_is_gpr};
             insn->has_pred_dest = {has_pred_dest};
         """))
         f.write(textwrap.dedent(f"""\
-- 
2.43.0



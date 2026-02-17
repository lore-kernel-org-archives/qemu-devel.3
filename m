Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCB4E9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSX6-0002hj-DP; Tue, 17 Feb 2026 16:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSX5-0002hH-F9
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:59 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSX3-0002Ip-N0
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:22:59 -0500
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-46398742245so1208041b6e.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771363376; x=1771968176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNHs4Sobj03r02yaX9a9D3Jb/8tlBnii4di7lAr9aUU=;
 b=AZPB/2NhI7eyRNpYn+COF0OcbV8tFX+xIKC43T7RU6Rbj8Pkx38Tw/SrbM7eKr0D0c
 noTIx5pQFrlL+Kv3meVuWhiy92HAR10ptVx/seKQyO3IhIYT43dYEjSa2qEceIG3JVAX
 dO/SYvQloA7AslopsTTX5KeCPsPsLmSbp6Oq4Y7F0PT2uce+AzvOlE4OVfQfTvqvkf1u
 zgdI8sexybn6G6wLDgzN7RgWWF/5+AbvU+DZPbtqDmoDTa6wLygomISHncSiYmfA3w4J
 eUWZKsOalEqBTu/HQ3oliNpGQNd+OPE7U3vHP2k3OvlUe3PGHfL2KcsOjb63UrwH2Eoq
 A+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771363376; x=1771968176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rNHs4Sobj03r02yaX9a9D3Jb/8tlBnii4di7lAr9aUU=;
 b=AllnYYvm5+odIoZGJTBgQSJOlzwXn6e62q+1ESEH6uD/hyRygHievVW7+vK9CQkNxo
 PkO21QExlb98tCixOHuaUPLbVmUqTOAamp/zAKPk1qjlPOkszJsGCqo+iCrD4WHrkAiW
 WGFN3L7EqGVuIK/af60Ps5yTJ+zJU9DQZfM0N2i4QHndvnUOUbRdu5ixSvS2O2BGwpM8
 76jK6wIqAvPDK1Utx4wDjn03P6eus8OM5Kbk8XG/NAHfCMhQiNwp5hWix1LyU7x16XvT
 9KNe5kTyFMVfg84NXXNzvq9wrZPiihaZz9jxhrjR7JIQEh0t2t/0gcZ9P/ruxpQ3v/17
 pX7w==
X-Gm-Message-State: AOJu0YwI5CdICNizPz1u8JlTig7PywxLjJOavUHvnrjoZ+f5SZfbdAxg
 hN5kZmZvUt7a+wXQySUlTmzzfKNqKD3eiCCjRC8ic7Tycvw++Ez+eOWA2Vse7DGd
X-Gm-Gg: AZuq6aIvGmcFJfzdIV5TXUCT8cl7PCZlmXJHHY+oyQp6Kyzs9IC6wZKaxA3BDh3ESLo
 O0u3bpKEG+XuYRc9xVVz/G2SfabRWwWjZS0M+taHY4Fc5gZrvx3m7BPEKjBcp1A0hO9shtSxFo2
 ZuiFnQWfm5EgeKUI5Z1BqTgKPGVN0Wzqd+KrC2je4DDs+zQojsWYt7dYb14I0qfRWXb5slGFlSH
 R9R0oqowZH5A9uZPx1VWiRfP5t3JObk7x3eJgfbAmF2Eu5rFMbFiH5lAhncJDfl/VYG63skV+cd
 LDILZh1R7bRpr+D6mhFqQbyhy1RtPziYukuUe7UD82nHTOTLgaM7lmleBjheiJ3XR4iYtNAMHmJ
 cdk86dnRxx+qFHlV84T9X+zwr2PSHqtZ1HLug5NgPD0TZgYPdhMAK2BSJhZfJtaDahSztUvZOqP
 kvDoRXfVQG2tq63sBLLVvYf9xC8IhljNrva2qcp+MmlJAoo2RnrsnJSxT+ZsaYqKN46740qfxXV
 Eo1mxSvgL2P/lPW
X-Received: by 2002:a05:6808:158e:b0:45f:210:4dbd with SMTP id
 5614622812f47-4639ef3137fmr6741119b6e.16.1771363376022; 
 Tue, 17 Feb 2026 13:22:56 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm12899319b6e.3.2026.02.17.13.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 13:22:55 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 6/8] Hexagon (target/hexagon) Disassembly of invalid packets
Date: Tue, 17 Feb 2026 14:22:43 -0700
Message-ID: <20260217212245.95321-7-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x243.google.com
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

We pass the Hexagon CPU definition to disassemble_hexagon.  This allows
decode_packet to know if the opcodes are supported.

Note that we print valid instructions in a packet when one or more is
invalid.  Rather than this
0x0002128c:  0x1eae4fec	{	<invalid>
0x00021290:  0x1c434c04		<invalid>
0x00021294:  0x1e03edf0		<invalid> }

We print this
0x0002128c:  0x1eae4fec	{	<invalid>
0x00021290:  0x1c434c04		V4.w = vadd(V12.w,V3.w)
0x00021294:  0x1e03edf0		V16 = V13 }

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/cpu_bits.h  |  4 +++-
 target/hexagon/printinsn.h |  3 ++-
 disas/hexagon.c            |  3 ++-
 target/hexagon/cpu.c       |  2 ++
 target/hexagon/decode.c    | 25 +++++++++++++++++++++----
 target/hexagon/printinsn.c |  9 +++++++--
 6 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index 19beca81c0..aaac6b9ea6 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -19,6 +19,7 @@
 #define HEXAGON_CPU_BITS_H
 
 #include "qemu/bitops.h"
+#include "cpu-qom.h"
 
 #define PCALIGN 4
 #define PCALIGN_MASK (PCALIGN - 1)
@@ -65,6 +66,7 @@ static inline bool is_packet_end(uint32_t endocing)
     return ((bits == 0x3) || (bits == 0x0));
 }
 
-int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GString *buf);
+int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GString *buf,
+                        const HexagonCPUDef *hex_def);
 
 #endif
diff --git a/target/hexagon/printinsn.h b/target/hexagon/printinsn.h
index 2ecd1731d0..6f84ef93c3 100644
--- a/target/hexagon/printinsn.h
+++ b/target/hexagon/printinsn.h
@@ -18,10 +18,11 @@
 #ifndef HEXAGON_PRINTINSN_H
 #define HEXAGON_PRINTINSN_H
 
+#include "cpu-qom.h"
 #include "insn.h"
 
 void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
-                         target_ulong pc);
+                         target_ulong pc, const HexagonCPUDef *hex_def);
 void snprint_a_pkt_debug(GString *buf, Packet *pkt);
 
 #endif
diff --git a/disas/hexagon.c b/disas/hexagon.c
index c1a4ffc5f6..36b8321c26 100644
--- a/disas/hexagon.c
+++ b/disas/hexagon.c
@@ -31,6 +31,7 @@
 
 int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
 {
+    const HexagonCPUDef *hex_def = (const HexagonCPUDef *)info->target_info;
     uint32_t words[PACKET_WORDS_MAX];
     bool found_end = false;
     GString *buf;
@@ -58,7 +59,7 @@ int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
     }
 
     buf = g_string_sized_new(PACKET_BUFFER_LEN);
-    len = disassemble_hexagon(words, i, memaddr, buf);
+    len = disassemble_hexagon(words, i, memaddr, buf, hex_def);
     (*info->fprintf_func)(info->stream, "%s", buf->str);
     g_string_free(buf, true);
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 949d509a15..001ea3c4ef 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -297,8 +297,10 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 static void hexagon_cpu_disas_set_info(const CPUState *cs,
                                        disassemble_info *info)
 {
+    const HexagonCPU *cpu = HEXAGON_CPU(cs);
     info->print_insn = print_insn_hexagon;
     info->endian = BFD_ENDIAN_LITTLE;
+    info->target_info = HEXAGON_CPU_GET_CLASS(cpu)->hex_def;
 }
 
 static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index b8a1cd5b12..c4cf430e5a 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -828,19 +828,36 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
 
 /* Used for "-d in_asm" logging */
 int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc,
-                        GString *buf)
+                        GString *buf, const HexagonCPUDef  *hex_def)
 {
+    HexagonCPUDef any_def = {
+        .hex_version = HEX_VER_ANY,  /* Allow decode to accept anything */
+    };
     DisasContext ctx;
     Packet pkt;
 
     memset(&ctx, 0, sizeof(DisasContext));
+    ctx.hex_def = &any_def;
     ctx.pkt = &pkt;
 
     if (decode_packet(&ctx, nwords, words, &pkt, true) > 0) {
-        snprint_a_pkt_disas(buf, &pkt, words, pc);
+        snprint_a_pkt_disas(buf, &pkt, words, pc, hex_def);
         return pkt.encod_pkt_size_in_bytes;
     } else {
-        g_string_assign(buf, "<invalid>");
-        return 0;
+        for (int i = 0; i < nwords; i++) {
+            g_string_append_printf(buf, "0x" TARGET_FMT_lx "\t", words[i]);
+            if (i == 0) {
+                g_string_append(buf, "{");
+            }
+            g_string_append(buf, "\t");
+            g_string_append(buf, "<invalid>");
+            if (i < nwords - 1) {
+                pc += 4;
+                g_string_append_printf(buf, "\n0x" TARGET_FMT_lx ":  ",
+                                       (target_ulong)pc);
+            }
+        }
+        g_string_append(buf, " }");
+        return nwords * sizeof(uint32_t);
     }
 }
diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
index 4865cdd133..22b305f018 100644
--- a/target/hexagon/printinsn.c
+++ b/target/hexagon/printinsn.c
@@ -21,6 +21,7 @@
 #include "insn.h"
 #include "reg_fields.h"
 #include "internal.h"
+#include "decode.h"
 
 static const char *sreg2str(unsigned int reg)
 {
@@ -51,7 +52,7 @@ static void snprintinsn(GString *buf, Insn *insn)
 }
 
 void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
-                         target_ulong pc)
+                         target_ulong pc, const HexagonCPUDef *hex_def)
 {
     bool has_endloop0 = false;
     bool has_endloop1 = false;
@@ -83,7 +84,11 @@ void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
         }
 
         g_string_append(buf, "\t");
-        snprintinsn(buf, &(pkt->insn[i]));
+        if (opcode_supported(pkt->insn[i].opcode, hex_def)) {
+            snprintinsn(buf, &(pkt->insn[i]));
+        } else {
+            g_string_append(buf, "<invalid>");
+        }
 
         if (i < pkt->num_insns - 1) {
             /*
-- 
2.43.0



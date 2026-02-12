Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C31FEDF020
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 03:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqNTg-0007mO-4c; Wed, 11 Feb 2026 22:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTd-0007l6-HC
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:49 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTb-0008IB-VV
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:49 -0500
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45f0b597eb4so1694842b6e.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 19:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770867286; x=1771472086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8Lq4sOSSRMCWRXjdXH1KuRIq2HriFTB8nlfBVQIPrE=;
 b=bxPc/QP8M0sjJxb0bCwNwm0SImh1bKWcmTZzcDMT4HDT/8blM5Tb6ui5W+Tey8/6+U
 4EKh9P3xjlKDyB0P56sk+JrGGsHtLsH8xNwcEE3thstVV0mTnv7TDwHvGAZqJXBJrWuV
 sG3hZe6fB3mwqJ5yuhmfSJPfYrTb3wQ7acUvV02gCtRmPWpAuQeHZgvh/qt7uQpFfTGB
 wE0hDDwcOgix4iLIHWeWB7vZU9BAP9xwcZqhvm+QZhmpZsUOe7FCYGAHKkh7w7ffzR9k
 Dx5GhM6iEB9tzPbY3WDQ6d9+aljf44NifnqkCcHJISzgCYZ9Ajvhx65CWVNYZsEUxnxS
 XkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770867286; x=1771472086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h8Lq4sOSSRMCWRXjdXH1KuRIq2HriFTB8nlfBVQIPrE=;
 b=BT16tRvm0eMMh5fD8OO1ThM4bLMxmX7vzF9itfqHRFcydQoesbEoyvDLWmpMPYuhpl
 EKL9fXi7olugNNF6exC1RpsP6p/R2u10FnMJ/8MOnNHuA8eDySs7mE8HDvFWBjVkH67N
 LARQv8mYRGOKi7vs+6k7FN/CUi465RPWOGRHP+ATll450kU2e9JPmE0Cg6phJIqVUZDy
 CtyiTZGnmOrcGbpZRk5OomFrdM0VyPle8ad3T/iJoSW5XCjqCEXxMMnSVMlmDnd1O7NB
 YgDJ9X8PpPnXys8ozIaVHlTmUs46ufts7novdfFlcMqk0Unhk3Vi9rYO7/NxDML0QnS5
 i3cQ==
X-Gm-Message-State: AOJu0YxzdYLYxd1HIt3GHGGCtKUbJDswvTHEogFZLDyL+1AVrQasAjfn
 DGj2zxzxGadCxRhxr0iEM4LX7gkWFy/o0YHHa7BN9PSvRVrsB8f0pA4IyOGkQz2L
X-Gm-Gg: AZuq6aK0y/uav1Ztdip4nTZBSj+vVttspHRIvsuDz4Ug8QpvFg/lXZusyvS4Mek6SkN
 rhc2gj4FrMg+p8UqrtmOAdTTiIDv/stq54ClSMaYyMZO+2wILbzWI/eB/YYKFrhA2SXcrrUHmqa
 TfRIMqqsLgOE4EWg0a/41b0VgbMJFEkWhxxyCkjgRSiRHATUd14PcJyLy0E2EGzgRrqS0UoItaO
 9waEgZP4VLdmQ4VdC4TVDaKhJluaQCxr7Q5Z8OxzMXGxhUAPwOV9g8jyYYtXYq3SPLnOk+Mnf6K
 0IDfZTU6ZmQ6co4aGMGRfe5YWVQOVRmOtd4BFXUDtr/3CUr9WnjFDcJAOn+AIFLrFCdokKzibVL
 buSMqSwmxP1xnZEUOt/wOMW9HgFmiNoZ1SS8TWREtUUD8b81mvyH8pgjbFGXfP9rfIEjxhTcGRe
 L0CezRhMA7VjqsXXRcWUSgt54HqUIAI1/aQKMq02BKqXWiH66qG7x+FfINcTq+cM50B86dGcq6g
 PWBGUpI5NlmM9XWo1FpMLyG1oQ=
X-Received: by 2002:a05:6808:1a02:b0:45c:7c9e:854f with SMTP id
 5614622812f47-4637fc9bae1mr446701b6e.58.1770867286435; 
 Wed, 11 Feb 2026 19:34:46 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm2682858a34.14.2026.02.11.19.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 19:34:46 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 7/8] Hexagon (target/hexagon) Disassembly of invalid packets
Date: Wed, 11 Feb 2026 20:34:34 -0700
Message-ID: <20260212033435.3598-8-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
References: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
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

We pass the Hexagon CPU version to disassemble_hexagon.  This allows
decode_packet to know if the opcodes are supported.

Fix the printing of invalid packets.

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/cpu_bits.h |  4 +++-
 disas/hexagon.c           |  3 ++-
 target/hexagon/cpu.c      |  3 +++
 target/hexagon/decode.c   | 20 +++++++++++++++++---
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index ff596e2a94..ba580df3c1 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -19,6 +19,7 @@
 #define HEXAGON_CPU_BITS_H
 
 #include "qemu/bitops.h"
+#include "cpu-qom.h"
 
 #define PCALIGN 4
 #define PCALIGN_MASK (PCALIGN - 1)
@@ -64,6 +65,7 @@ static inline bool is_packet_end(uint32_t endocing)
     return ((bits == 0x3) || (bits == 0x0));
 }
 
-int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GString *buf);
+int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GString *buf,
+                        HexagonVersion hex_version);
 
 #endif
diff --git a/disas/hexagon.c b/disas/hexagon.c
index c1a4ffc5f6..9a18f12854 100644
--- a/disas/hexagon.c
+++ b/disas/hexagon.c
@@ -31,6 +31,7 @@
 
 int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
 {
+    HexagonVersion hex_version = (HexagonVersion)info->target_info;
     uint32_t words[PACKET_WORDS_MAX];
     bool found_end = false;
     GString *buf;
@@ -58,7 +59,7 @@ int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
     }
 
     buf = g_string_sized_new(PACKET_BUFFER_LEN);
-    len = disassemble_hexagon(words, i, memaddr, buf);
+    len = disassemble_hexagon(words, i, memaddr, buf, hex_version);
     (*info->fprintf_func)(info->stream, "%s", buf->str);
     g_string_free(buf, true);
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 09a0de3c2f..4b16214ace 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -314,8 +314,11 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 static void hexagon_cpu_disas_set_info(const CPUState *cs,
                                        disassemble_info *info)
 {
+    CPUState *cs_nonconst = (CPUState *)cs;  /* so we can get hex_cpu */
+    HexagonCPU *hex_cpu = env_archcpu(cpu_env(cs_nonconst));
     info->print_insn = print_insn_hexagon;
     info->endian = BFD_ENDIAN_LITTLE;
+    info->target_info = (void *)HEXAGON_CPU_GET_CLASS(hex_cpu)->hex_version;
 }
 
 static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 0cff15e890..bfc769be62 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -768,19 +768,33 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
 
 /* Used for "-d in_asm" logging */
 int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc,
-                        GString *buf)
+                        GString *buf, HexagonVersion hex_version)
 {
     DisasContext ctx;
     Packet pkt;
 
     memset(&ctx, 0, sizeof(DisasContext));
+    ctx.hex_version = hex_version;
     ctx.pkt = &pkt;
 
     if (decode_packet(&ctx, nwords, words, &pkt, true) > 0) {
         snprint_a_pkt_disas(buf, &pkt, words, pc);
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
+                g_string_append_printf(buf, "\n0x" TARGET_FMT_lx ": ",
+                                       (target_ulong)pc);
+            }
+        }
+        g_string_append(buf, " }");
+        return nwords * sizeof(uint32_t);
     }
 }
-- 
2.43.0



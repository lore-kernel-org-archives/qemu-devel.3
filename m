Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FDEC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5s-0006oJ-Vz; Fri, 17 Jan 2025 13:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5i-0005Ly-3U
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:10 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5g-0000HA-1m
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:09 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f4409fc8fdso4037153a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138546; x=1737743346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0COR0wGsJEy/ct0+IIODnhUoa5eU9hdaT7H7ngHo7to=;
 b=JTDtJRdqcYbUYar6EUMSeQ6offECcFNVWf/i7K/JKwFQaoT/mFYhW3BqTtZeMHhgi2
 FLzfmiTJPtmEKYobI7zTHyX++im0t6s1x/Nsc1bal3plgbXSLlBbG59iHSNva6Minjzk
 /78DKiy0f5SjFZ02ENJUga/XtwjKzErqcQjg1QTYiidK21LuMnOBTwT0cQaIZjRX71Vr
 wte5qcIfcCd078DXauXSRJVAqx8saXhnmbJZw+543am7r4udDJY9/Clrsv7HH16b4DYx
 mAtXbnIxZ8RhsLzwgBwxEdA28rhOdNeEt7TMjWxJ5BPf9w6J8RmLUQjrMLGrxzu60APj
 sDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138546; x=1737743346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0COR0wGsJEy/ct0+IIODnhUoa5eU9hdaT7H7ngHo7to=;
 b=YiXy0T1vdAGA1aI673MAHVn1HUvMTJLV6tzVbF328VWdkEu9zXrB5mZ5PXgpSFpwlb
 CLgcr8f0kB9Nl7HPCncRJL7e0Xw/6Cy1cqKrykxG3QDUpPxk9wLppb7sk2dgFTzN4H4R
 WxJq47Dh4kocsGLW6VZ/BHG0m4y7LFUSeeyp4JiM3SFppEAM8hLSJChFaddCm0e735k6
 Qt5XARAYKH3vo3IdInv5KTNE0QsvdFIUTHemp2aSXfv+swjuYBV1DqiT++o0xVG6AYl0
 oHjh8vdw9khh/2CwPTeDU2aRUJZywAlBAXzhE2k6AV5I8NCdkNLHVUembmqCMjkWt027
 QBlQ==
X-Gm-Message-State: AOJu0YyH7vTmVPcVCcOL8lh8Iz5JeziUANbSL+g7Yw14zQagcONiSPBq
 /Sct+BeNQAHiPIxkaU1BO144lY92NP+7rqv6arhx3uLXUkfDibgzR9XTGwxoNrgOlx8rVtFbdVC
 2
X-Gm-Gg: ASbGnctYyGFITfpC/vL4c9TmzGF9xzNbRFSoCx4wPPerkO0qOqhxZKnQfkVBl8ycwG+
 /Cy2n+2hrm3vkiDZ4sRqdJm389TEAHSe049Dv62iyiWcMlEudE+c0tarWwgQKY44v7l5THKEiXF
 TjFjUBOo5AJI1k3lVkoqObYM736FHxVc7FufHZNEZycI7apF50313KWaahreD/4d/Mq0hJcAOFG
 2XLbHXhh5zGHWTZoEIlaiUi/ZYO73gZIb4KzFTdPfVMbV7B38pjahRiL4OwcEyH4S1821ljjwoX
 sk+zz/gw/haKlDA=
X-Google-Smtp-Source: AGHT+IGrmZj1uZZhFwXm0Nt4ZU8XahQ9yIbReHpxhnHAeRYurVXh6HVof0/w+yLxTCYK0iJFuk8dwg==
X-Received: by 2002:a17:90b:4c50:b0:2ea:61c4:a443 with SMTP id
 98e67ed59e1d1-2f728da5ff5mr17520809a91.4.1737138546198; 
 Fri, 17 Jan 2025 10:29:06 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 55/68] tcg/riscv64: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Fri, 17 Jan 2025 10:24:43 -0800
Message-ID: <20250117182456.2077110-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Accept byte and word extensions with the extract opcodes.
This is preparatory to removing the specialized extracts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-has.h | 39 ++++++++++++++++++++++++++++++++++----
 tcg/riscv/tcg-target.c.inc | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index ddc759a533..5bf62c7c7f 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -16,8 +16,8 @@
 #define TCG_TARGET_HAS_div2_i32         0
 #define TCG_TARGET_HAS_rot_i32          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i32      0
-#define TCG_TARGET_HAS_extract_i32      0
-#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
@@ -50,8 +50,8 @@
 #define TCG_TARGET_HAS_div2_i64         0
 #define TCG_TARGET_HAS_rot_i64          (cpuinfo & CPUINFO_ZBB)
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_ext8s_i64        1
@@ -109,4 +109,35 @@
 
 #define TCG_TARGET_HAS_tst_vec          0
 
+static inline bool
+tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 16:
+            return cpuinfo & CPUINFO_ZBB;
+        case 32:
+            return (cpuinfo & CPUINFO_ZBA) && type == TCG_TYPE_I64;
+        }
+    }
+    return false;
+}
+#define TCG_TARGET_extract_valid  tcg_target_extract_valid
+
+static inline bool
+tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+        case 16:
+            return cpuinfo & CPUINFO_ZBB;
+        case 32:
+            return type == TCG_TYPE_I64;
+        }
+    }
+    return false;
+}
+#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
+
 #endif
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index e381ba4e77..fc93900c6d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2343,6 +2343,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mb(s, a0);
         break;
 
+    case INDEX_op_extract_i64:
+        if (a2 == 0 && args[3] == 32) {
+            tcg_out_ext32u(s, a0, a1);
+            break;
+        }
+        /* FALLTHRU */
+    case INDEX_op_extract_i32:
+        if (a2 == 0 && args[3] == 16) {
+            tcg_out_ext16u(s, a0, a1);
+        } else {
+            g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_sextract_i64:
+        if (a2 == 0 && args[3] == 32) {
+            tcg_out_ext32s(s, a0, a1);
+            break;
+        }
+        /* FALLTHRU */
+    case INDEX_op_sextract_i32:
+        if (a2 == 0 && args[3] == 8) {
+            tcg_out_ext8s(s, TCG_TYPE_REG, a0, a1);
+        } else if (a2 == 0 && args[3] == 16) {
+            tcg_out_ext16s(s, TCG_TYPE_REG, a0, a1);
+        } else {
+            g_assert_not_reached();
+        }
+        break;
+
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
@@ -2620,6 +2650,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
+    case INDEX_op_extract_i32:
+    case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap16_i64:
-- 
2.43.0



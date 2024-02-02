Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28941C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 19:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVzWt-0002yD-F9; Fri, 02 Feb 2024 14:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rVzWs-0002y5-01
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:48:50 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rVzWq-0006oT-CQ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:48:49 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-363b2736544so2935405ab.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 11:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706903325; x=1707508125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=18V9fmHvQ/OH/dC5uhhGZl0Ybe04gURoOmNZRaFWwMA=;
 b=GLSBUgrke5m0CfaDjP67Zipptty3z+EWv0rpiw1UgBMxgFt+bsFVnPx06rdlKOX6OZ
 lmvtoDhueM7UIrgXzX2pR757Jvktvqnluzu3NVMQ0u/PzM0S5UUbGGfLgvR9cIILbpbu
 7LBTUhH8Lr+QvC62qUyrfsnBCO3r+TdP7fT+RQZFuHwMXVhUClVGkMTDwEHFVPaz891n
 nsIzyaPVi6lN990QqAafUivpgCkgE1YW9op9K3DbL4d5Fgwh9C3GA7DH52aOU6+XFKOd
 HDOsmfj+sxno1FMtd1RvF+WLclk+5N3DJjpLA2ObQJB76IpgkLhQ1kjjzvZDUDFCfkCb
 hXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706903325; x=1707508125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=18V9fmHvQ/OH/dC5uhhGZl0Ybe04gURoOmNZRaFWwMA=;
 b=hKc9ltTIGxG49Pir9y6U4vbWV3v3hJ8kj2OJAvQi9qPEHr91HvOtXFbG5KrWffpFVV
 t/gO+zrSTG3ufIbaEkFDzEvINwfJ5XKVybs6hiLBzNggcB+/D4OwUJRFWWV3n3OX2xOS
 euaRuAtvxlnnyMcjusdJJnAUGDuOraNVjSyf+eURgGju36Nah+ds8yLsIhXxl6JlD5mM
 y13FLJhI1Aw23gJOi2yhiU9+uFVCM2szoZNgIxgG1XXc2yWGhbRZtrcV5kRyTt5Cj6Df
 EFAfIazKAqgOMUdXzIhtsf8RciDoQJoo2VkOkWulsCbhxkVT0KtXKRA1O0lq7+LiATdZ
 NW2w==
X-Gm-Message-State: AOJu0Yz4I7eeoeX3dt63TVef1Jf5/b5ldIzZ2fq+woRq17PrBVIKp0Kb
 hSDvwth/zyqlCI9RRneOfrjCiGTUp53M14S3XfCztq9084QF/zLn7ptOat1/+xk=
X-Google-Smtp-Source: AGHT+IEKaGzQ3Ou/woIoQNJX6M7JYpxs+xA4PWoXuT926f4zHPg68somLpHdW3jmGB04/BbhL3Qx4w==
X-Received: by 2002:a92:d1cd:0:b0:363:b880:4d2d with SMTP id
 u13-20020a92d1cd000000b00363b8804d2dmr1251754ilg.22.1706903324804; 
 Fri, 02 Feb 2024 11:48:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWRVUeIHcXRBHhL/jA+j5ShoKTYpQ8bRC9zI3si1dIowPgMbk1arLAom3trR4I9eDOP6q+H8DpWfMp1QnaAj3+fRvs16wRK6LFfnnNkQPpAjlPBqNm9F8YiER5JDcgsAO01gaMKJdP/2D5uUSp3Kqk4QyfDeA0md+mZPv2pdDn0/O/PE/gdOi5ukMsslPN82o9A2YZBNt/BW01vhxmY8M82XVPCfwR18zxRMwN8YiKkVaHKgfosjfVXHfvKuTvt+Y+APO9jtah3FTD2do8fYYEt2mBZ821goDOKse0o
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a92d7c3000000b00363942ad88bsm764655ilq.40.2024.02.02.11.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 11:48:44 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH] Hexagon (target/hexagon) Only pass env to generated helper
 when needed
Date: Fri,  2 Feb 2024 12:48:42 -0700
Message-Id: <20240202194842.148085-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, we pass env to every generated helper.  When the semantics of
the instruction only depend on the arguments, this is unnecessary and
adds extra overhead to the helper call.

The A2_nop and SA1_setin1 instructions end up with no arguments.  This
results in a "old-style function definition" error from the compiler, so
we write overrides for them.

With this change, the number of helpers with env argument is
    idef-parser enabled:    329 total, 23 with env
    idef-parser disabled:   1543 total, 553 with env

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_tcg.h         |  3 +++
 target/hexagon/attribs_def.h.inc |  1 +
 target/hexagon/hex_common.py     | 22 +++++++++++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 1c4391b415..e9ac2e3fe0 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1369,3 +1369,6 @@
         gen_helper_raise_exception(tcg_env, excp); \
     } while (0)
 #endif
+
+#define fGEN_TCG_A2_nop(SHORTCODE) do { } while (0)
+#define fGEN_TCG_SA1_setin1(SHORTCODE) tcg_gen_movi_tl(RdV, -1)
diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.h.inc
index 87942d46f4..8949ee09cf 100644
--- a/target/hexagon/attribs_def.h.inc
+++ b/target/hexagon/attribs_def.h.inc
@@ -117,6 +117,7 @@ DEF_ATTRIB(IMPLICIT_READS_P1, "Reads the P1 register", "", "")
 DEF_ATTRIB(IMPLICIT_READS_P2, "Reads the P2 register", "", "")
 DEF_ATTRIB(IMPLICIT_READS_P3, "Reads the P3 register", "", "")
 DEF_ATTRIB(IMPLICIT_WRITES_USR, "May write USR", "", "")
+DEF_ATTRIB(IMPLICIT_READS_SP, "Reads the SP register", "", "")
 DEF_ATTRIB(COMMUTES, "The operation is communitive", "", "")
 DEF_ATTRIB(DEALLOCRET, "dealloc_return", "", "")
 DEF_ATTRIB(DEALLOCFRAME, "deallocframe", "", "")
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 195620c7ec..12bc410bb2 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -101,6 +101,7 @@ def calculate_attribs():
     add_qemu_macro_attrib('fLSBNEW1', 'A_IMPLICIT_READS_P1')
     add_qemu_macro_attrib('fLSBNEW1NOT', 'A_IMPLICIT_READS_P1')
     add_qemu_macro_attrib('fREAD_P3', 'A_IMPLICIT_READS_P3')
+    add_qemu_macro_attrib('fREAD_SP', 'A_IMPLICIT_READS_SP')
 
     # Recurse down macros, find attributes from sub-macros
     macroValues = list(macros.values())
@@ -197,6 +198,16 @@ def get_tagimms():
     return dict(zip(tags, list(map(compute_tag_immediates, tags))))
 
 
+def need_env(tag):
+    return ("A_STORE" in attribdict[tag] or
+            "A_LOAD" in attribdict[tag] or
+            "A_CVI_GATHER" in attribdict[tag] or
+            "A_CVI_SCATTER" in attribdict[tag] or
+            "A_IMPLICIT_WRITES_USR" in attribdict[tag] or
+            "A_IMPLICIT_READS_P0" in attribdict[tag] or
+            "A_IMPLICIT_READS_SP" in attribdict[tag])
+
+
 def need_slot(tag):
     if (
         "A_CVI_SCATTER" not in attribdict[tag]
@@ -1060,11 +1071,12 @@ def helper_args(tag, regs, imms):
     args = []
 
     ## First argument is the CPU state
-    args.append(HelperArg(
-        "env",
-        "tcg_env",
-        "CPUHexagonState *env"
-    ))
+    if need_env(tag):
+        args.append(HelperArg(
+            "env",
+            "tcg_env",
+            "CPUHexagonState *env"
+        ))
 
     ## For predicated instructions, we pass in the destination register
     if is_predicated(tag):
-- 
2.34.1



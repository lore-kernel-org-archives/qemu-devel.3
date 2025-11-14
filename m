Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A37CEACE4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 23:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK2nH-0007sq-VA; Fri, 14 Nov 2025 18:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vK2mK-0007Iw-3m
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:00:45 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vK2mE-0004bM-LD
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:00:24 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-4330dfb6ea3so10044655ab.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 15:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763161221; x=1763766021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKHw4xMzfLWovd+R8UsqyXMOGNCAfKK5a5TfWY8a5hI=;
 b=H5MHYu/cNgJJae7BHfHYsJvE7EaDiTxsAVrR5lbQcWDPBw1WM2z7u2yjxQ0LwOwVEa
 TaPyeq75CMpwhemRI3FFtOep4yQfvYo4QKcizzha6ToWsUsMR1g/x8cbD2tiH764grZx
 RpvpyM4hGCntLcnxbbW8C7phiRg0Gxe6M5kJvamtINREV1t+7dLusRx5lxfIlObHY0mk
 M3MK5bXZzMQk5d8mfVvwuTlqYkKtRXlInmwzVgY/2fAyDbi/fLZfVm80UDhu0YkQESiq
 FNRk5A06tsBxixQ4oWUCxzur2sryGkuLBDzvOb8AMcBa0ArgInt9MzYN00loRRgMzwZh
 OqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763161221; x=1763766021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dKHw4xMzfLWovd+R8UsqyXMOGNCAfKK5a5TfWY8a5hI=;
 b=fbgxyglxU3pmBk4Va0Zi3YVeggmnubCyHw/ZMIW0UMm9GFIk0beS3ZMP7ey1FUv0uq
 fGsEzJfI6f1WXhZKootAxpSPum1cLcBMevkgvgwjP1/UWgEfvc6t1nOESxhugoqfwinc
 E06poBIU4Mcqv9awunxJtBH6hglULP0BARzEutWG9xxy9isGLGX9rpsZ5o9lzICBe3MI
 a3O8jYkIFnwuhKp1L2gSXy4lZ/Sx2R4tbLNxl4Nc6vn3F6ocpQYPjHFJR+ntmSjt4JPE
 1vM9VUEH3htH5zqHMKI5xzlPUGI+YdKFESiVTDkcPLGZPQ7dx5sjiU3RygmXDnCeRilX
 s0Gg==
X-Gm-Message-State: AOJu0Yxv/4YaS3ZLRZkTGaJ7GjLud58KgIIvwFVyaZ6g4ON70oXKg98x
 e1aYyYydEBIwvC3cgoDOWmAbPUt8b9/Rh0pwY+ePAYeNqdj6LFe1+AHW2uCyE1bj
X-Gm-Gg: ASbGncv61ZI4F9POPktf6PhYVjwcuSkGT10fsQ4TiAvRKqwa9F7xWZJj/5Ij8/PzR+y
 JWmv4JUDlvHSJD2PnElMeTzfVhDOXCqFjuoz326QFAPeSfVQ1I/6w06vI+XDJ7er19tDI03rK0d
 vMVYkdGSrU5uHXPoQKTksLO8/NiDKqyuKhu+7pnserMEPvMEAQgEtv67bqq3LG6W3dZxIrTiMQI
 Vqd0bYO0Uuu6ETV6s4qQAHyI1c3YbPWPbvwtYx0W4qhz7WZhwgw+vS7y0KiU92NY6ttO1rPdLOI
 XSQqhuGTUk4tXBkPsZS+gYkDJMynkNM8I3qa4KEbLhAbu4idnmZ5nE0w8aLej7l4+BEEieYOmO6
 w3OpFAnhGTQ/7pFhLftTNYeroi9fAaHrA0uIghTkn79FKeiP3WjyW+XRL+JKD4POV8ZMNCR9vn6
 ZqhLVSUwbyuzuv4yDlPWEnTAb227+KacvZbCn8H4V1tUW1wxiqU5p5telybUhB4iTbiJk/aJBcp
 zhS
X-Google-Smtp-Source: AGHT+IEJt3ExxoC4LA4J0U3kxIcthKxpLAF5OfZz5iPnq5LLlOTVwMJrkT2+KxirCAVvGOcEUN5lzw==
X-Received: by 2002:a05:6e02:b4f:b0:434:7d59:cb18 with SMTP id
 e9e14a558f8ab-4348c93ed95mr64201375ab.26.1763161221065; 
 Fri, 14 Nov 2025 15:00:21 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-434838c24a1sm35673075ab.15.2025.11.14.15.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 15:00:20 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 4/4] Hexagon (target/hexagon) s/log_write/gen_write
Date: Fri, 14 Nov 2025 16:00:13 -0700
Message-ID: <20251114230013.158098-5-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x132.google.com
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

These functions don't "log" anything, they just generate the write

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_tcg_funcs.py |  2 +-
 target/hexagon/hex_common.py    | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index bd241afde1..3e531bd540 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -94,7 +94,7 @@ def gen_tcg_func(f, tag, regs, imms):
     for regtype, regid in regs:
         reg = hex_common.get_register(tag, regtype, regid)
         if reg.is_written():
-            reg.log_write(f, tag)
+            reg.gen_write(f, tag)
 
     f.write("}\n\n")
 
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 6b683487bc..c0e9f26aeb 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -451,7 +451,7 @@ def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             TCGv {self.reg_tcg()} = get_result_gpr(ctx, {self.reg_num});
         """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         ## No write needed
         return
     def analyze_write(self, f, tag, regno):
@@ -494,7 +494,7 @@ def decl_tcg(self, f, tag, regno):
             f.write(code_fmt(f"""\
                 tcg_gen_mov_tl({self.reg_tcg()}, hex_gpr[{self.reg_num}]);
             """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         ## No write needed
         return
     def analyze_read(self, f, regno):
@@ -517,7 +517,7 @@ def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             TCGv {self.reg_tcg()} = get_result_gpr(ctx, {self.reg_num});
         """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_write_ctrl_reg(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
@@ -569,7 +569,7 @@ def decl_tcg(self, f, tag, regno):
         f.write(code_fmt(f"""\
             TCGv {self.reg_tcg()} = tcg_temp_new();
         """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
@@ -606,7 +606,7 @@ def decl_tcg(self, f, tag, regno):
             TCGv {self.reg_tcg()} = tcg_temp_new();
             tcg_gen_mov_tl({self.reg_tcg()}, hex_pred[{self.reg_num}]);
         """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_pred_write(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
@@ -626,7 +626,7 @@ def decl_tcg(self, f, tag, regno):
             TCGv_i64 {self.reg_tcg()} =
                 get_result_gpr_pair(ctx, {self.reg_num});
         """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_write_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
@@ -660,7 +660,7 @@ def decl_tcg(self, f, tag, regno):
                                    hex_gpr[{self.reg_num}],
                                    hex_gpr[{self.reg_num} + 1]);
         """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_write_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
@@ -685,7 +685,7 @@ def decl_tcg(self, f, tag, regno):
             TCGv_i64 {self.reg_tcg()} =
                 get_result_gpr_pair(ctx, {self.reg_num});
         """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_write_ctrl_reg_pair(ctx, {self.reg_num}, {self.reg_tcg()});
         """))
@@ -723,7 +723,7 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         pass
     def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
@@ -789,7 +789,7 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         pass
     def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
@@ -821,7 +821,7 @@ def decl_tcg(self, f, tag, regno):
                                  vreg_src_off(ctx, {self.reg_num}),
                                  sizeof(MMVector), sizeof(MMVector));
             """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
                            {hvx_newv(tag)});
@@ -854,7 +854,7 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         pass
     def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
@@ -913,7 +913,7 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         f.write(code_fmt(f"""\
             gen_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
                                 {hvx_newv(tag)});
@@ -946,7 +946,7 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         pass
     def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
@@ -993,7 +993,7 @@ def decl_tcg(self, f, tag, regno):
                 TCGv_ptr {self.reg_tcg()} = tcg_temp_new_ptr();
                 tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});
             """))
-    def log_write(self, f, tag):
+    def gen_write(self, f, tag):
         pass
     def helper_hvx_desc(self, f):
         f.write(code_fmt(f"""\
-- 
2.43.0



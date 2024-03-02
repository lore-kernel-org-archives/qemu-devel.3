Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE501C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjr-0002WZ-S9; Sat, 02 Mar 2024 00:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjp-0002WE-GV
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:45 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjn-0007ZJ-In
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:45 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e4d48a5823so2521546b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356602; x=1709961402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RSehTc+m5oVdh1J2W1mJGpLatyJrr2v8cOzcGv/GU4=;
 b=H7AVPFBu54Q4EKBACy1E/RX4Xtd9m6X/45c44w5je1PtRM+DvS7QckCpw82YB6cIA+
 D5QBOqc4GPOtvTDhvB0VfvtsvG645a7mN13DDxLsAciIYFMKGJNliD3Sd5kppBTSwHd7
 9oLBBZYfj2Cw5/qvKMUwM+9VU/TbGC+CVz01ejeGjU6ByHjqFVfqTg/NVU5DVDEIOYMS
 YqL/Y6Ev3mh2lllZ6k8DgklhkiDqMmZT3428D231F9vVXUT/qz85gfrf7ADZRYgEPBpz
 1bNB8h8o7qYNuEiYhCFr593cirrJPfuMhkWCnh0NyAlkiExf+66BW709NGDcrs1rNgA1
 NtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356602; x=1709961402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RSehTc+m5oVdh1J2W1mJGpLatyJrr2v8cOzcGv/GU4=;
 b=gd0dG+Aomh9DHg0ecp9u/JNnQ6CBXP3HXeVj8KYy9Hxs3RI5p+JHC7A0ftIjhTUGyH
 /7kp11Za8x0/1Kq1Rf9dcQce4dfkwKRsSHjrViEwBcS5q8IrSpOK3Xn1Hy6eeZ+xwitG
 r/9dwEq4bcRWG4yxqLVzJKwlo+yC0tVJ/dt8YVWZUgjXbLKaVs0TWJm0pnypH1i2kgZC
 tCvjZke8N4oZW9/8KsV3gLHeb+rWiE4oYnmYA45cxtaFtWubu1VZjHuRo5FaEe3Gxwmw
 sjbNDUtea9ZWK3GGlgfRhoQWyF9ZcPKIygD6UiqfSlG+g1WSz0O+EaIk7AwNokehwwgS
 kp9g==
X-Gm-Message-State: AOJu0YzIkDfzimOOCYGvUIt1KNBBv49HDSljNuXVVJX4IaBRz5X5/Njk
 USn1PoAsypGSzaxAC54WjvLKODl1Wmc0gkL1gswol8l6KRoC0JsSO8JP3WSgX+HnhgRX8uOKqzg
 m
X-Google-Smtp-Source: AGHT+IGZwd7S4LBD6yV6ohLTZwQMjKDl+6ENHLB5f0buC4i/Y8Pa+KBMZEVvHssuzC1ty62XfFPESA==
X-Received: by 2002:a05:6a20:1609:b0:1a1:2092:8868 with SMTP id
 l9-20020a056a20160900b001a120928868mr3894028pzj.1.1709356602427; 
 Fri, 01 Mar 2024 21:16:42 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 22/41] target/sparc: Implement FPADDS, FPSUBS
Date: Fri,  1 Mar 2024 19:15:42 -1000
Message-Id: <20240302051601.53649-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c  | 82 +++++++++++++++++++++++++++++++++++++++
 target/sparc/insns.decode |  9 +++++
 2 files changed, 91 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9af30d8fa7..0dc02a3d6e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -707,6 +707,78 @@ static void gen_op_fpack32(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 #endif
 }
 
+static void gen_op_fpadds16s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 t[2];
+
+    for (int i = 0; i < 2; i++) {
+        TCGv_i32 u = tcg_temp_new_i32();
+        TCGv_i32 v = tcg_temp_new_i32();
+
+        tcg_gen_sextract_i32(u, src1, i * 16, 16);
+        tcg_gen_sextract_i32(v, src2, i * 16, 16);
+        tcg_gen_add_i32(u, u, v);
+        tcg_gen_smax_i32(u, u, tcg_constant_i32(INT16_MIN));
+        tcg_gen_smin_i32(u, u, tcg_constant_i32(INT16_MAX));
+        t[i] = u;
+    }
+    tcg_gen_deposit_i32(d, t[0], t[1], 16, 16);
+}
+
+static void gen_op_fpsubs16s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 t[2];
+
+    for (int i = 0; i < 2; i++) {
+        TCGv_i32 u = tcg_temp_new_i32();
+        TCGv_i32 v = tcg_temp_new_i32();
+
+        tcg_gen_sextract_i32(u, src1, i * 16, 16);
+        tcg_gen_sextract_i32(v, src2, i * 16, 16);
+        tcg_gen_sub_i32(u, u, v);
+        tcg_gen_smax_i32(u, u, tcg_constant_i32(INT16_MIN));
+        tcg_gen_smin_i32(u, u, tcg_constant_i32(INT16_MAX));
+        t[i] = u;
+    }
+    tcg_gen_deposit_i32(d, t[0], t[1], 16, 16);
+}
+
+static void gen_op_fpadds32s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 r = tcg_temp_new_i32();
+    TCGv_i32 t = tcg_temp_new_i32();
+    TCGv_i32 v = tcg_temp_new_i32();
+    TCGv_i32 z = tcg_constant_i32(0);
+
+    tcg_gen_add_i32(r, src1, src2);
+    tcg_gen_xor_i32(t, src1, src2);
+    tcg_gen_xor_i32(v, r, src2);
+    tcg_gen_andc_i32(v, v, t);
+
+    tcg_gen_setcond_i32(TCG_COND_GE, t, r, z);
+    tcg_gen_addi_i32(t, t, INT32_MAX);
+
+    tcg_gen_movcond_i32(TCG_COND_LT, d, v, z, t, r);
+}
+
+static void gen_op_fpsubs32s(TCGv_i32 d, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 r = tcg_temp_new_i32();
+    TCGv_i32 t = tcg_temp_new_i32();
+    TCGv_i32 v = tcg_temp_new_i32();
+    TCGv_i32 z = tcg_constant_i32(0);
+
+    tcg_gen_sub_i32(r, src1, src2);
+    tcg_gen_xor_i32(t, src1, src2);
+    tcg_gen_xor_i32(v, r, src2);
+    tcg_gen_and_i32(v, v, t);
+
+    tcg_gen_setcond_i32(TCG_COND_GE, t, r, z);
+    tcg_gen_addi_i32(t, t, INT32_MAX);
+
+    tcg_gen_movcond_i32(TCG_COND_LT, d, v, z, t, r);
+}
+
 static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
 {
 #ifdef TARGET_SPARC64
@@ -4785,6 +4857,11 @@ TRANS(FHSUBs, VIS3, do_fff, a, gen_op_fhsubs)
 TRANS(FNHADDs, VIS3, do_fff, a, gen_op_fnhadds)
 TRANS(FNADDs, VIS3, do_fff, a, gen_op_fnadds)
 
+TRANS(FPADDS16s, VIS3, do_fff, a, gen_op_fpadds16s)
+TRANS(FPSUBS16s, VIS3, do_fff, a, gen_op_fpsubs16s)
+TRANS(FPADDS32s, VIS3, do_fff, a, gen_op_fpadds32s)
+TRANS(FPSUBS32s, VIS3, do_fff, a, gen_op_fpsubs32s)
+
 static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
 {
@@ -4867,6 +4944,11 @@ TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
 TRANS(FCHKSM16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fchksm16)
 TRANS(FMEAN16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fmean16)
 
+TRANS(FPADDS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_ssadd)
+TRANS(FPADDS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_ssadd)
+TRANS(FPSUBS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sssub)
+TRANS(FPSUBS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sssub)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index c9dab4236d..602b4cc648 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -448,6 +448,15 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPSUB32s    10 ..... 110110 ..... 0 0101 0111 .....    @r_r_r
     FPSUB64     10 ..... 110110 ..... 0 0100 0110 .....    @d_d_d
 
+    FPADDS16    10 ..... 110110 ..... 0 0101 1000 .....    @d_d_d
+    FPADDS16s   10 ..... 110110 ..... 0 0101 1001 .....    @r_r_r
+    FPADDS32    10 ..... 110110 ..... 0 0101 1010 .....    @d_d_d
+    FPADDS32s   10 ..... 110110 ..... 0 0101 1011 .....    @r_r_r
+    FPSUBS16    10 ..... 110110 ..... 0 0101 1100 .....    @d_d_d
+    FPSUBS16s   10 ..... 110110 ..... 0 0101 1101 .....    @r_r_r
+    FPSUBS32    10 ..... 110110 ..... 0 0101 1110 .....    @d_d_d
+    FPSUBS32s   10 ..... 110110 ..... 0 0101 1111 .....    @r_r_r
+
     FNORd       10 ..... 110110 ..... 0 0110 0010 .....    @d_d_d
     FNORs       10 ..... 110110 ..... 0 0110 0011 .....    @r_r_r
     FANDNOTd    10 ..... 110110 ..... 0 0110 0100 .....    @d_d_d   # FANDNOT2d
-- 
2.34.1



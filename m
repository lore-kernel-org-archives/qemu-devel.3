Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD73C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlz-0008Nb-Uc; Sun, 26 May 2024 15:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJly-0008Jq-UG
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:14 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlx-0007gp-34
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:14 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso20630385ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752591; x=1717357391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MNpYclVGKo3PjC8reKLGIVlF1usDEXtRMs0W/qOUUA=;
 b=Mr3PHNrLodib/a4E4IVaYJISX3XdQxL+WLF8+GRVCujaKJKHmYk+7g4uhHdbN/nlQb
 kIp62ykcLMit7UY8MN641sTkKEZTVmXJoYQhNUfkLzVFKCHX0AtTVSjODtveyuRtxDGe
 TYcWjTIv4QMGbBbaaE/qSYbB7xmfJcJOUIj1Y7YZb41iGtkpnBT0k1LR38mb+qyGXriE
 NC1u41bOA0rCcXcDittFommjUcDOqpmQQ01Algk6s91rOxiQkB4oQRar1H9N9yqsIytY
 uAf6VHakCJ13FKzzrgXjapSVexwZo0Y4B9L0pHAES4lnhCwLLL70qhc+0koP0xMDwK2j
 6aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752591; x=1717357391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MNpYclVGKo3PjC8reKLGIVlF1usDEXtRMs0W/qOUUA=;
 b=pq1Z0dtHXLzLCGeeWO0ATi7KrXVBnZsk1tMudhxFpQuWO82IT8C0PYkUWsg+GqV5qm
 VUpIlKUvkQLSbof5azhQKMkObHzEsN6mIIJ/puEBAgQDChjkKM2Rq8yb8aKWpoFy7yPs
 8mHu7ucwCNgRPagWlMF2ljOPDBVq4c3DJ1s103LB+hqZuKPMiE9nxSdpQ65t06Yzx01e
 OpJ1ijmjhRoXnQnE6r/yuPQK1LpwIHTzJfVzgXv9o8W5/Xn38xk08gNoz/mdaZw6/J1Z
 YSXVI/Tjy7KpwrMxfc8v1h3tGO/BtzfDkGN8HXfd+BNIZPrfh3kTayol8oXqRANjfGE1
 NQjA==
X-Gm-Message-State: AOJu0YxEYuo2WxpO1YXJ4iuXuKOASGEcF+aO6w0+CVqR/nBxDIt2QcSK
 OPwXDMBSyOjOWZtwbM6bFJyI8VobrIlJDICcpXFu+SNFZ22jFfP9OV4Z2Ng6SA+gqSbqwa7Utcx
 Y
X-Google-Smtp-Source: AGHT+IEJ4Nhr7mLV3ndA6NcyxXVwpnBkcNA7PbqP6KaPWf+dCwQzbbCt62unSc5JADIGQUPgpSS/OA==
X-Received: by 2002:a17:903:2310:b0:1f3:cb7:b0ef with SMTP id
 d9443c01a7336-1f4494f2365mr91091325ad.51.1716752591483; 
 Sun, 26 May 2024 12:43:11 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 20/37] target/sparc: Implement FSLL, FSRL, FSRA, FSLAS
Date: Sun, 26 May 2024 12:42:37 -0700
Message-Id: <20240526194254.459395-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/sparc/helper.h     |  2 ++
 target/sparc/insns.decode |  9 +++++++++
 target/sparc/translate.c  | 11 +++++++++++
 target/sparc/vis_helper.c | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index ed295c01e0..219f0e04c7 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -119,6 +119,8 @@ DEF_HELPER_FLAGS_2(cmask16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fchksm16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmean16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fslas16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fslas32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                              \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)                                    \
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 295fc36128..a5eefebfbc 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -408,6 +408,15 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPCMPGT32   10 ..... 110110 ..... 0 0010 1100 .....    @r_d_d
     FPCMPEQ32   10 ..... 110110 ..... 0 0010 1110 .....    @r_d_d
 
+    FSLL16      10 ..... 110110 ..... 0 0010 0001 .....    @d_d_d
+    FSRL16      10 ..... 110110 ..... 0 0010 0011 .....    @d_d_d
+    FSLAS16     10 ..... 110110 ..... 0 0010 1001 .....    @d_d_d
+    FSRA16      10 ..... 110110 ..... 0 0010 1011 .....    @d_d_d
+    FSLL32      10 ..... 110110 ..... 0 0010 0101 .....    @d_d_d
+    FSRL32      10 ..... 110110 ..... 0 0010 0111 .....    @d_d_d
+    FSLAS32     10 ..... 110110 ..... 0 0010 1101 .....    @d_d_d
+    FSRA32      10 ..... 110110 ..... 0 0010 1111 .....    @d_d_d
+
     FPCMPULE8   10 ..... 110110 ..... 1 0010 0000 .....    @r_d_d
     FPCMPUGT8   10 ..... 110110 ..... 1 0010 1000 .....    @r_d_d
     FPCMPNE8    10 ..... 110110 ..... 1 0010 0010 .....    @r_d_d
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7a20e79b7e..ade9df3960 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -83,6 +83,8 @@
 # define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fslas16              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fslas32              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
@@ -4957,6 +4959,13 @@ TRANS(FPADDS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_ssadd)
 TRANS(FPSUBS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sssub)
 TRANS(FPSUBS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sssub)
 
+TRANS(FSLL16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_shlv)
+TRANS(FSLL32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_shlv)
+TRANS(FSRL16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_shrv)
+TRANS(FSRL32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_shrv)
+TRANS(FSRA16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sarv)
+TRANS(FSRA32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sarv)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -4996,6 +5005,8 @@ TRANS(FNHADDd, VIS3, do_ddd, a, gen_op_fnhaddd)
 
 TRANS(FPADD64, VIS3B, do_ddd, a, tcg_gen_add_i64)
 TRANS(FPSUB64, VIS3B, do_ddd, a, tcg_gen_sub_i64)
+TRANS(FSLAS16, VIS3, do_ddd, a, gen_helper_fslas16)
+TRANS(FSLAS32, VIS3, do_ddd, a, gen_helper_fslas32)
 
 static bool do_rdd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv, TCGv_i64, TCGv_i64))
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 5a5da17132..c21522c533 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -473,3 +473,39 @@ uint64_t helper_fmean16(uint64_t src1, uint64_t src2)
 
     return r.ll;
 }
+
+uint64_t helper_fslas16(uint64_t src1, uint64_t src2)
+{
+    VIS64 r, s1, s2;
+
+    s1.ll = src1;
+    s2.ll = src2;
+    r.ll = 0;
+
+    for (int i = 0; i < 4; ++i) {
+        int t = s1.VIS_SW64(i) << (s2.VIS_W64(i) % 16);
+        t = MIN(t, INT16_MAX);
+        t = MAX(t, INT16_MIN);
+        r.VIS_SW64(i) = t;
+    }
+
+    return r.ll;
+}
+
+uint64_t helper_fslas32(uint64_t src1, uint64_t src2)
+{
+    VIS64 r, s1, s2;
+
+    s1.ll = src1;
+    s2.ll = src2;
+    r.ll = 0;
+
+    for (int i = 0; i < 2; ++i) {
+        int64_t t = (int64_t)(int32_t)s1.VIS_L64(i) << (s2.VIS_L64(i) % 32);
+        t = MIN(t, INT32_MAX);
+        t = MAX(t, INT32_MIN);
+        r.VIS_L64(i) = t;
+    }
+
+    return r.ll;
+}
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434EDC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjw-0002vk-JC; Sat, 02 Mar 2024 00:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjv-0002mh-1d
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:51 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjr-0007Zo-9K
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:50 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-29a74c88f74so1955673a91.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356605; x=1709961405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfPuJ4tPZVWL/yf2b4Ij0h3eS67hS3Izz9+5EX1nnYU=;
 b=Dh29xP1etwvS+p5kujf00XmOjs66tLCBFu+IJOmSnCNzKBabrKqJlbuZYZ3bMJALfY
 osyq6Xb2X7p5OaIo5r6i10MqShV465fA0Y2kgjKa5V0AOeyeNWknFBe4rImh/hbOf4ih
 ShkDdJvODM2qqKfOu7/97eHF+JpTMEzGEnz0xxsmZ02CnmW99fIW1l+JtMelYLtYjRhD
 Xb38scrqh7IGRyzbIrDEffxKKXv6etFuJ9nSvxWkwry3xrfDdbuTt5IfdDDihgZTKJY+
 Wv6EsuKP0FuHWj7ALEeQMQJR1dZl0s9yTpx85678iMW4rlPgST7GxjDYJoq/0H/FggVv
 mY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356605; x=1709961405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AfPuJ4tPZVWL/yf2b4Ij0h3eS67hS3Izz9+5EX1nnYU=;
 b=JtedQVEdCLv4ZOt0U3J/VKCMU4cXV5rrvsMAZcWsnW/3dvth9YQ7mkjNLaVBqHSAR3
 sYUiuRMsOn8pi7DStrdy5QBA+oGk4PCZWQyIPsr9DO8Gg/hKaxPzCFO1ZypvTR8XVV29
 qxE1FTwKkkPt6zYOVdvUoIc41nT8UNN7WfObBPpOw4i9x/iWlkfrMPnE6+6TRxHQ779g
 f/TMpWZVhIejEjwoAjUm9VJ61So9XROFQhpLlgb8D/m41wCNrDmIHuVufaU8x25f/Fns
 YCBQZjyWtHMXK8ZAqUgKaowHqSfjvcIkpTPQ0FLsQRbAuecisZKmL8Ab156/bARP0uTa
 +qPw==
X-Gm-Message-State: AOJu0YzlhpaVUcv24DqMfrCS2ipQQjlLCHY9WcdT03JxUlU101qw1Q8Q
 XAT8iR6+KrRU0/O+puhUoeJJPjfZkkEkaBBUa/cHOL1L8YrvnYp+bYtCVhJsvwIvNoTXv7qzjC+
 0
X-Google-Smtp-Source: AGHT+IFzD5oK3Ri+DI3ZU14NezlU/W9cP8YochSK1N2PeIVXgjVaTn/zxaQOB9Ral+IJfT0dewVBCg==
X-Received: by 2002:a17:90a:7187:b0:29b:a75:9930 with SMTP id
 i7-20020a17090a718700b0029b0a759930mr3400919pjk.5.1709356605120; 
 Fri, 01 Mar 2024 21:16:45 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 24/41] target/sparc: Implement FSLL, FSRL, FSRA, FSLAS
Date: Fri,  1 Mar 2024 19:15:44 -1000
Message-Id: <20240302051601.53649-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 target/sparc/translate.c  | 11 +++++++++++
 target/sparc/vis_helper.c | 36 ++++++++++++++++++++++++++++++++++++
 target/sparc/insns.decode |  9 +++++++++
 4 files changed, 58 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index fb52f31666..331acbe8d0 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -114,6 +114,8 @@ DEF_HELPER_FLAGS_2(cmask16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(cmask32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fchksm16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmean16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fslas16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fslas32, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #define VIS_CMPHELPER(name)                                              \
     DEF_HELPER_FLAGS_2(f##name##16, TCG_CALL_NO_RWG_SE,      \
                        i64, i64, i64)                                    \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bc8c314d4c..cab177190a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -84,6 +84,8 @@
 # define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fslas16              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fslas32              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
@@ -4953,6 +4955,13 @@ TRANS(FPADDS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_ssadd)
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
@@ -4993,6 +5002,8 @@ TRANS(FNADDd, VIS3, do_ddd, a, gen_op_fnaddd)
 
 TRANS(FPADD64, VIS3B, do_ddd, a, tcg_gen_add_i64)
 TRANS(FPSUB64, VIS3B, do_ddd, a, tcg_gen_sub_i64)
+TRANS(FSLAS16, VIS3, do_ddd, a, gen_helper_fslas16)
+TRANS(FSLAS32, VIS3, do_ddd, a, gen_helper_fslas32)
 
 static bool do_rdd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv, TCGv_i64, TCGv_i64))
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 2d290a440e..8675ac64b3 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -456,3 +456,39 @@ uint64_t helper_fmean16(uint64_t src1, uint64_t src2)
 
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
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index c94007bf95..67591b7df9 100644
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
     FPCMPEQ8    10 ..... 110110 ..... 1 0010 0010 .....    @r_d_d
-- 
2.34.1



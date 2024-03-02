Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CB6C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjy-0002z6-Ra; Sat, 02 Mar 2024 00:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjw-0002vt-IF
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:52 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHju-0007aM-Tx
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:52 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5e42b4bbfa4so2055218a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356609; x=1709961409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1ra1voUNK7VumvOysSOTdB5wAQkGxh/tYoZzjk/66s=;
 b=OGW891UtAj3u/rccOtn4aiQTDI5v+Wa7RrnE8ZmKoknRjLW0AGiL4opbOxJ+8eXU9d
 4rTKLVb5q1r3x1qpBNuLUxLNHN8wWTZCJHVo5mA56NdSj7zFBaCR40q5qqzoS1j4I4P9
 /YEcdg7Q3J+sxQkJokLEhPZCTUwqUM0QfmR+nTpCJQAx87fZrSFdgRdunVr3/fhjsy99
 6PvjMxDem+wycFXf+RUapPoPQuTwlHlzgcUFX4xxibJl1eNYUE1q6CLMeC6FdvrDbe8S
 9uzHM3Dxx02g24iubqXNAGzAyMoNJlpvGrmsrW0XV1KDYpGtHl92nj3RRKJRx0VulMHS
 Sh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356609; x=1709961409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1ra1voUNK7VumvOysSOTdB5wAQkGxh/tYoZzjk/66s=;
 b=rxRywirzSNju/xhXXt+PLmqH7nq818qaRPTvAk+PBWLyecXoYID1UL0HeHItcpvgYq
 q5Auy3QETJEfdsglEfzawznVRT8TgCgyyMhPRHaXvECJN0NRgNhCaVehq6oW6Uq4PYCY
 F0u2WQFf9DYIJ7fFzvvMq34JdnaTNOUPSAFBioNodZl3mdyxSMbMQMSA4Y+YGd09k948
 KOWBaqM/hQvyPauBs2pexVWv77Pe5PMDQSd5BzcvpOpoV/scn1RHh/mpnJxK1bcpTCai
 Fr5IapNolkk3fJl4QQGecxw1n6px949xO9BMAvrDCddQ2mCsd8ajm9p04gw6OeRr4CZm
 RN3w==
X-Gm-Message-State: AOJu0YwVWiwmYqLJVtpQDrRDIM9yaN0kyTHVxCTFOVy0XcYDWKJQdAwB
 vKf4NS/I2E8LIGi4DV5RNcg2PnYdOzjkQchRke0gNjSNcHv4463nosDLkuosG7y5G/+weaD1Ehz
 J
X-Google-Smtp-Source: AGHT+IGrT2935u4vZPSTLEh0pHV2aj4Nkq1qZpIplP00flexrmHDTGNpkSy0+/f+o4+hjEr0lYK/Ww==
X-Received: by 2002:a05:6a20:4296:b0:1a1:45f1:562c with SMTP id
 o22-20020a056a20429600b001a145f1562cmr1234868pzj.6.1709356608993; 
 Fri, 01 Mar 2024 21:16:48 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 27/41] target/sparc: Implement MOVsTOw, MOVdTOx, MOVwTOs,
 MOVxTOd
Date: Fri,  1 Mar 2024 19:15:47 -1000
Message-Id: <20240302051601.53649-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 target/sparc/translate.c  | 36 ++++++++++++++++++++++++++++++++++++
 target/sparc/insns.decode |  6 ++++++
 2 files changed, 42 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 761ae204b9..70d87a68cc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5393,6 +5393,42 @@ static bool trans_FLCMPd(DisasContext *dc, arg_FLCMPd *a)
     return advance_pc(dc);
 }
 
+static bool do_movf2r(DisasContext *dc, arg_r_r *a,
+                      int (*offset)(unsigned int),
+                      void (*load)(TCGv, TCGv_ptr, tcg_target_long))
+{
+    TCGv dst;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    dst = gen_dest_gpr(dc, a->rd);
+    load(dst, tcg_env, offset(a->rs));
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(MOVsTOsw, VIS3B, do_movf2r, a, gen_offset_fpr_F, tcg_gen_ld32s_tl)
+TRANS(MOVsTOuw, VIS3B, do_movf2r, a, gen_offset_fpr_F, tcg_gen_ld32u_tl)
+TRANS(MOVdTOx, VIS3B, do_movf2r, a, gen_offset_fpr_D, tcg_gen_ld_tl)
+
+static bool do_movr2f(DisasContext *dc, arg_r_r *a,
+                      int (*offset)(unsigned int),
+                      void (*store)(TCGv, TCGv_ptr, tcg_target_long))
+{
+    TCGv src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    src = gen_load_gpr(dc, a->rs);
+    store(src, tcg_env, offset(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(MOVwTOs, VIS3B, do_movr2f, a, gen_offset_fpr_F, tcg_gen_st32_tl)
+TRANS(MOVxTOd, VIS3B, do_movr2f, a, gen_offset_fpr_D, tcg_gen_st_tl)
+
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f7f532002a..1189ad4c87 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -498,6 +498,12 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FONEd       10 ..... 110110 00000 0 0111 1110 00000    rd=%dfp_rd
     FONEs       10 rd:5  110110 00000 0 0111 1111 00000
 
+    MOVsTOuw    10 ..... 110110 00000 1 0001 0001 .....    @r_r2
+    MOVsTOsw    10 ..... 110110 00000 1 0001 0011 .....    @r_r2
+    MOVwTOs     10 ..... 110110 00000 1 0001 1001 .....    @r_r2
+    MOVdTOx     10 ..... 110110 00000 1 0001 0000 .....    @r_d2
+    MOVxTOd     10 ..... 110110 00000 1 0001 1000 .....    @d_r2
+
     FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
     FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
                 rs1=%dfp_rs1 rs2=%dfp_rs2
-- 
2.34.1



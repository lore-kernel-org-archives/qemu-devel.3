Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39618C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJm2-0008VS-LG; Sun, 26 May 2024 15:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm1-0008Rl-1H
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlz-0007iv-Av
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f4a52b94c3so622865ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752594; x=1717357394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Dbek1town6qNo1qebfL9HjPcGIqPDP0UBF51QHaqnk=;
 b=qzJXd9xPvm238Cf9wPBy+q8NpmN58tmd3HIaF6jMJFf47K9nQG/YSl+8zSHsM51Nz2
 NkDEn9TtWVEmKfiWCDbiyBryafewGSvTnRU3hFnlK0Lw6xiG3To0bJ2xplA3viclfEZc
 198+fOZanI3I4HTG9dyW8XKOP9YtTVOhpqh271/BnLDsQg6EuE4LmGZnN7oEHFdW2MwN
 wjEqyHn80lxZSFv9WxRHtQyFgh2iD/0hxlWUPDPDww2vV8x7fiBNsU+6JA2xxrrUDI3Y
 Vz2PRQxmQ1gUIwRkOcJhJDxtBubQiy1qrGa9ph0fT6RSm+TwdSmuWCczWzHZR1xISwxd
 Kfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752594; x=1717357394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Dbek1town6qNo1qebfL9HjPcGIqPDP0UBF51QHaqnk=;
 b=SXFCqI8tCDVziUvN0Wy4Vg2t+B4CFEWQ3SPkge5BII7p4gRY5oJ2jOaXmhNV7UvrTH
 1OPOI7MBytZq9yw7cBcbqG3tk9JERDbJz0SRHG/uqbBQTAYQlrTjq8vVAduifeJp8fbQ
 DBmfqThGvN36/STF0LZo18mzE8wn9xj53qT+kGI/pPWeUW+McGxls4WFVx+GUQQnpCpg
 /Ir3bW0KbTJsriyXi1k7JPV1Gug8YjYeoE1S9PEvj6SsshEFxJ4Ol/DZYttYMW9lPHOu
 Y1kYmrALECEp3Y2ILariWTcNRkaQkmPCGd6hXSUURfNywEj+Rb5VMQlo+YZHhdLueUTy
 z7Mg==
X-Gm-Message-State: AOJu0YyGM5C+0aT3e13XqQAVg75sX8UWAWPIBYZICoQOggxV4FX3jPMR
 z6REGR6LryWfRTRRJ9oTjbzi2WS7sw8mFxRW61p+aDkpkjmz8IoY+KpaOiKQbNodwc2CjaFz0/O
 d
X-Google-Smtp-Source: AGHT+IGeok5AYfWXYVy4vZeVg6UK3h7uJPo7mTUoizfzBeH9/4MmJIavxcy5n7nqIO7zumUsOAkteA==
X-Received: by 2002:a17:902:d511:b0:1f4:8358:47e1 with SMTP id
 d9443c01a7336-1f483584bbdmr35647015ad.36.1716752593877; 
 Sun, 26 May 2024 12:43:13 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 23/37] target/sparc: Implement MOVsTOw, MOVdTOx, MOVwTOs,
 MOVxTOd
Date: Sun, 26 May 2024 12:42:40 -0700
Message-Id: <20240526194254.459395-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 target/sparc/insns.decode |  6 ++++++
 target/sparc/translate.c  | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 4766964893..e0e9248982 100644
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
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 705fcb028a..d8707326ff 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5397,6 +5397,42 @@ static bool trans_FLCMPd(DisasContext *dc, arg_FLCMPd *a)
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
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E82C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJmT-0001CH-7A; Sun, 26 May 2024 15:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJmH-0000cU-2G
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:33 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJm5-0007l3-2L
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:31 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-68197de7400so2084573a12.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752600; x=1717357400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1jjOHUmg/tTAGM1DBRu1C4y8VFtwwr9VfI190aJ9Ijg=;
 b=hM/i+FXmucG7YmnscUSrPcBOxQdnIHot5YDFWDBptVcoxt3hxynoOPSj3F7uC6jAhG
 /cVdr4uKVTezB4UfuWKTqNliXXboXgNVIkJPHXA2B4OlkLSpADgX0g3b+xWr31dAJVKl
 aW5InhjkMDtGYtCfxTF0DEoOcmS7EpimIKfUSL037gyqQQ/SGZnGUQQ+MamX2Jd1E5Hh
 ip8sTaUehvgxpOCq0qa+mGNJN1F9LAjHUkkNxOsRK9yfsMJoPwDlrXldTWWyBRF7NF9W
 dipl7nFbm6kJaQ3Vy+Y49wG1QDt5Ph4KJaXzc5MbeqKByd9nrDeQ0h367l+EQhCyJdrr
 sHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752600; x=1717357400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1jjOHUmg/tTAGM1DBRu1C4y8VFtwwr9VfI190aJ9Ijg=;
 b=rA0khF+QRJvwK/E5JdHxMgJIcee3BBks+1owH+aLhmj/k5Sk6OPTKvhgfhDftU47YH
 8wmfoGm7gfHguT1ad/I96ZvruZBiNN8fbdqA+++hgo+elJOYrYsZsQEtn0TR0WM86JOE
 vryF8SwvkAc7H8U9p8BoA87rgwFPY/6XuAND70RHLYzKwV9VkEoUa656M30+G4/ND0OG
 5I7JrIkpjrGtj2MMlJdV4JL4yHBpOhyNi7DKK9CJ4mKK4yIPScHEe7fn8OJ5kG3upP6z
 H1qPYfhpy91wDNsBdr1REQYs3PpLjU6CYd5tkRZKoaX7WDbxIHogvMs1y0F+l8PTg6ao
 JR0g==
X-Gm-Message-State: AOJu0YxBY05KARD1fVcsSYTUroD2yG37/YSDfLcVRHShwJ2iUKnyDKrS
 WhiQqtIhDad9oq9eK+BTVsW2F/LYiUJNj/BYuntXjDXVXwQnDQELPdTFN3Uh1IOnVxBfOEw3f6z
 g
X-Google-Smtp-Source: AGHT+IGilv9fzovvD/0cT2zS3YjuV+/DlcpfH5Dq+1dFzMJL8oTO96Wtf4+BHpZfM8WhznhTCaHsCQ==
X-Received: by 2002:a17:903:120b:b0:1f3:695:eeda with SMTP id
 d9443c01a7336-1f4498fa6fcmr93850535ad.61.1716752599682; 
 Sun, 26 May 2024 12:43:19 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 31/37] target/sparc: Implement 8-bit FPADD, FPADDS,
 and FPADDUS
Date: Sun, 26 May 2024 12:42:48 -0700
Message-Id: <20240526194254.459395-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  9 +++++++++
 target/sparc/translate.c  | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0913fe7a86..80579642d1 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -509,6 +509,15 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     MOVdTOx     10 ..... 110110 00000 1 0001 0000 .....    @r_d2
     MOVxTOd     10 ..... 110110 00000 1 0001 1000 .....    @d_r2
 
+    FPADD8      10 ..... 110110 ..... 1 0010 0100 .....    @d_d_d
+    FPADDS8     10 ..... 110110 ..... 1 0010 0110 .....    @d_d_d
+    FPADDUS8    10 ..... 110110 ..... 1 0010 0111 .....    @d_d_d
+    FPADDUS16   10 ..... 110110 ..... 1 0010 0011 .....    @d_d_d
+    FPSUB8      10 ..... 110110 ..... 1 0101 0100 .....    @d_d_d
+    FPSUBS8     10 ..... 110110 ..... 1 0101 0110 .....    @d_d_d
+    FPSUBUS8    10 ..... 110110 ..... 1 0101 0111 .....    @d_d_d
+    FPSUBUS16   10 ..... 110110 ..... 1 0101 0011 .....    @d_d_d
+
     FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
     FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
                 rs1=%dfp_rs1 rs2=%dfp_rs2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5b6a12c81e..0f7f0260c4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5021,17 +5021,28 @@ static bool do_gvec_ddd(DisasContext *dc, arg_r_r_r *a, MemOp vece,
     return advance_pc(dc);
 }
 
+TRANS(FPADD8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_add)
 TRANS(FPADD16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_add)
 TRANS(FPADD32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_add)
+
+TRANS(FPSUB8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_sub)
 TRANS(FPSUB16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sub)
 TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
+
 TRANS(FCHKSM16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fchksm16)
 TRANS(FMEAN16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fmean16)
 
+TRANS(FPADDS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_ssadd)
 TRANS(FPADDS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_ssadd)
 TRANS(FPADDS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_ssadd)
+TRANS(FPADDUS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_usadd)
+TRANS(FPADDUS16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_usadd)
+
+TRANS(FPSUBS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_sssub)
 TRANS(FPSUBS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sssub)
 TRANS(FPSUBS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sssub)
+TRANS(FPSUBUS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_ussub)
+TRANS(FPSUBUS16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_ussub)
 
 TRANS(FSLL16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_shlv)
 TRANS(FSLL32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_shlv)
-- 
2.34.1



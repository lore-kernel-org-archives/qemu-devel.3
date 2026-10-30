Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C12606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Okeo89GX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmTP-0003R0-Nc; Fri, 30 Oct 2026 09:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSs-0002kB-Rr
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:18 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMmSm-0005Vr-P8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:16:13 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-703be215729so293901eaf.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366164; x=1793970964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9O2d7CElZ9IXGoq8YSEMQJ7ssfbfEc/q8B0mzqzGpjg=;
 b=Okeo89GXaan7g4qlY8SsfSzMkDZLq+jbHnTyHcLWfShSPzAVdhmHrToHPUnd9kB5Ty
 L1Zw/rfg041ECTR+rP9ZYg9TTvbkNqR5hCnJew8OQvFP8Wrt6YbIQIzBarTGXl9mNmvp
 QoPbGpoNX7w3btFdkrN9L8Fym3O9XyYU5w6cMFMEAbS5lNzjXWeipHR5Ulu5hEcMxfCe
 7t2z4ZnrZjjFuwldPoPq35PqOwDNMmJDFmBfgVzKpjuyA92l+vwabkfpoRpWq4vAEv2h
 tfIR395JMo9Z6NZJlRhDmi9VQRz/CWYPiIMEsh1B1gUt+dUXNixMClwqDP1zxoxv2g5E
 Ugsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366164; x=1793970964;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9O2d7CElZ9IXGoq8YSEMQJ7ssfbfEc/q8B0mzqzGpjg=;
 b=s9r+etljwgicjAL/9HICfTa8U+hAn6PDV2XVYWYwrsVP2xR6lrNzCK8YY06tCxbB4U
 SxMrKAI840xvuAup4ggy5YTblInrQPfAtlutWHqDkhtxsP/DJnx8x48kp1KOK1qRyk/L
 YyhV1LrG4tBrDqDg7GlE6n0JcL833oQ3L72+RpXHJP4q6N6sSRNjVXxvCXWWKDZlrg5S
 t978v7eAtknEJO17JpJJ0n9W+11SEkzK6TXc9lrI4KaLkNBWkzW3XvAVGwo/LtLO8na4
 NYgfkF6W/LzUvfyfsNlL9zRsxh0ZKGWqZxhBV0TxvikMUX9mXGUQ4X2xp2wmru1KxiHT
 n5dw==
X-Gm-Message-State: AFq9FYJJVkSP2tCsjDRl5qEyQ6HzxoqEFM/szBLxo+H5MRHkp3oKGl3I
 8iLQ9ieDRbNpSHRXY5rnzA57G9KcwDygkotY0Vo75/23PzN3sDQa+p43Zy+bL2ocESGF4hm9vqW
 Lpa5Z
X-Gm-Gg: AYBFou2LtKkU/wc8lqIdBlaUaB0CvB16g5yjm6nQxsecG0ue8O/OjNd7KSQw8vYiVAH
 H6c9YZYe0GZ+lPNAMpQOSK5GZglyATLlGkyUHobpNGjSEn5pRXN3K6NE5UrMFXdejjP4VVIrZ9f
 Js8MbrXLeJqFsx975Sl3QGcXdCR5zq1vey2ZZnAh7aZ634iVLx55+JXoougKpgdT/y95W8bljzc
 38+mMn4N447td069TZkmuMTRuxoY+XF/RFgqV3fAtrkw/bmjtRMtWAju6SpfFHpP3pbFX+g4ftK
 oYujlzxiE/adLi4agi++8vs8q9BVhP93H1Se3xiKxvp2rU0GImpZE15KMEoWVPggokUz53IKFbn
 a+NqFw1RVWHjB1Q8cg+miIqTeQLZLJFtYy9cKL9RkufCIkEMHHU/0a0tPwMFDrXTLvXRFghYBCy
 YoxnRr8nuTbEikxQdJDpuK8tvA3FadX+lWNcY2kBIPbkcdkdGZrWbZnaKeMPiK8tyK28rDjrcAR
 hRVoPMB513RvYUoMOSDYRgYdPJuJSO6keQ+ObJNvPDy4pciCXCP8G+7GApmnjgJsVyOkube61rm
 9lgSD6wiGMvwqGQGGqibLME3iVzqWg==
X-Received: by 2002:a05:6820:f004:b0:6f4:80f6:6ae7 with SMTP id
 006d021491bc7-714f2a34674mr1382014eaf.67.1793366164495; 
 Fri, 30 Oct 2026 06:16:04 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a90ae4e6bcsm1796812fac.3.2026.10.30.06.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:16:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matt Turner <mattst88@gmail.com>
Subject: [PULL 09/19] target/mips: Use tcg_gen_lea() for [D]LSA and MXU
 S32LD*V opcodes
Date: Fri, 30 Oct 2026 08:15:44 -0500
Message-ID: <20261030131554.41208-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030131554.41208-1-richard.henderson@linaro.org>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260831062630.58771-1-philmd@oss.qualcomm.com>
---
 target/mips/tcg/mxu_translate.c        | 3 +--
 target/mips/tcg/translate_addr_const.c | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index a38f4da12b..5361c94b34 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1596,8 +1596,7 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
 
     gen_load_gpr(t0, Rb);
     gen_load_gpr(t1, Rc);
-    tcg_gen_shli_i32(t1, t1, strd2);
-    tcg_gen_add_i32(t0, t0, t1);
+    tcg_gen_lea_i32(t0, t0, t1, strd2, 0);
 
     tcg_gen_qemu_ld_i32(t1, t0, ctx->mem_idx,
                        MO_SL | mo_endian_rev(ctx, reversed) |
diff --git a/target/mips/tcg/translate_addr_const.c b/target/mips/tcg/translate_addr_const.c
index 1d140e918d..910177e43b 100644
--- a/target/mips/tcg/translate_addr_const.c
+++ b/target/mips/tcg/translate_addr_const.c
@@ -26,8 +26,7 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa);
-    tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_lea_tl(cpu_gpr[rd], t1, t0, sa, 0);
     tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
     return true;
 }
@@ -47,7 +46,6 @@ bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa)
     t1 = tcg_temp_new();
     gen_load_gpr(t0, rs);
     gen_load_gpr(t1, rt);
-    tcg_gen_shli_tl(t0, t0, sa);
-    tcg_gen_add_tl(cpu_gpr[rd], t0, t1);
+    tcg_gen_lea_tl(cpu_gpr[rd], t1, t0, sa, 0);
     return true;
 }
-- 
2.53.0



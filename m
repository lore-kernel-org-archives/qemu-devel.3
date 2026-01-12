Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36016CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQov-00057s-P1; Mon, 12 Jan 2026 17:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQom-0004lr-Uo
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQoi-0004Dy-QG
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:24 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso34414475e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258518; x=1768863318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fz8rSn323HPhuHU1yR5/LK9VT6fqLxXlZQiQfxRIY7I=;
 b=JxGEpWFTxT0hW1gdZsD+GCEqGKolBzzgLFyDhFyKa6eV+NZvxacoKeH+GfS2oEBLo5
 uDjOIs9ysc+tgBZnFyPBbwQoTBZaeMNKUFoHYNrMGRi3cVcsOgM47jD5zqwSApnkMbqv
 r7IMiptFeYccAN1QlXuQInR6Mpklcg5QVis79PuWo+oTx1KHzkiYObcGextHOFxBRiNg
 x0EETlnMdWa1vpgafN649go46HljB5bQ6c9X13sKjWzFqfeFfDzJ6r3F4VtW75JEQRDr
 N7IIenl4CNftic0NoQgnRc+ATPoiTZG5Us9Vf0dt1zdK/eLaMDKiCPyWzuo+HDZ1JqSB
 MCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258518; x=1768863318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fz8rSn323HPhuHU1yR5/LK9VT6fqLxXlZQiQfxRIY7I=;
 b=CTV0sb/fUPXk3sW//LkeN3ojlN3wxOcXO1JOZS6aUgKwEss5BUG29t1oBZe9TOrbNj
 An94Yw/9km8kIvq7grLXQDZyQzNSukilxfPF369wQKCxmhNnEFBq/lwbLK2pHMa85TQ2
 Kek99ow7DpBHXVOAg9/T97fseyuf+djmWCZaW1mYC7NkVofok6Y5GiBmHCG+2uyuT23N
 PRk5ibpeu8RTbTE7daolR65jcqfXSDjGnNRTBkcNMjQ84ICz7ChzayN6mnMfh23H7Qe1
 e1cTluDhuD7auP0T263HLTGuCv43w3Y356CJkANXUaFCfOykt7yuMxeiIa8QtPkx7Hgp
 /lUg==
X-Gm-Message-State: AOJu0Yw/zmQmTtV8P52UFPD4+v6w1+41ijwAfxiEMmnVxMMtexIhoDgv
 20RdQE6Tj3A3Jq5MbBIsCv+E2nMcl7B7OanZ36FOApzm2YoxuoiXlvhDlpdfsY55SoBqckdhtjI
 FaNaGVV4=
X-Gm-Gg: AY/fxX5mRLw92pP0GYzGFvyoepGmmybtWcoJiMrfzJNqMaOqDCpidwH//d8p/MLoIT0
 tpq2i/4CXWRJPDZgwF3hS5rt4w8m50MWGhOtDj6p1fs7wvAI/q1BhSp/PEVKa/xO7k+6aplixJm
 JVZiBb8PWQQjSWVJBgqjq9JLXtLxw4bg1T4/b1cCRYMAINzG6N6X3yAdxhNVi5Dv54ybMygnwOV
 uj5hgsgLZIMj/rwRC3iGRJUZysdUV9saJJca0SLkOfq4xOdnvsk70gooyIcOFXQTV/yh63AJ9uQ
 aYYANFi8QK0rZ/TW+8tMkRcgXbCkoQC4+XBQtxkBEd+D8Q+4HqTGLET4ysIK29s+bFdyuHQJYEE
 bHgTJrm0emVHlvPTyNlZ6z7st0TZ8poKGLf/oNDiBQAtzCMC47GPcAB4WUo0pTD8fS/aFDYHBvv
 DHMZ58dHnTJHjg2QPLnhpy2wN/eguXcU2iGn3Df/Ez03mb7dFU21NCqKSXsV2OkPEetFdpxkw=
X-Google-Smtp-Source: AGHT+IGdnVBSusZFZtEFnGhfbkxpQyKLMeVG6j6nHqEvyxwD3wOwksRYAQkhtcnBfh70gTQAZY0CoA==
X-Received: by 2002:a05:600c:3b19:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-47d84b3b645mr241220995e9.21.1768258517630; 
 Mon, 12 Jan 2026 14:55:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41eb3bsm389038285e9.7.2026.01.12.14.55.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:55:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/61] target/tricore: Use little-endian variant of
 cpu_ld/st_data*()
Date: Mon, 12 Jan 2026 23:48:50 +0100
Message-ID: <20260112224857.42068-56-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We only build the TriCore target using little endianness order,
therefore the cpu_ld/st_data*() definitions expand to the little
endian declarations. Use the explicit little-endian variants.

Mechanical change running:

  $ tgt=tricore; \
    end=le; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Then adapting spaces style manually to pass checkpatch.pl.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251126202200.23100-6-philmd@linaro.org>
---
 target/tricore/op_helper.c | 152 ++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 2c8281a67e0..3cff5000c73 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2451,84 +2451,84 @@ static bool cdc_zero(uint32_t *psw)
 
 static void save_context_upper(CPUTriCoreState *env, uint32_t ea)
 {
-    cpu_stl_data(env, ea, env->PCXI);
-    cpu_stl_data(env, ea+4, psw_read(env));
-    cpu_stl_data(env, ea+8, env->gpr_a[10]);
-    cpu_stl_data(env, ea+12, env->gpr_a[11]);
-    cpu_stl_data(env, ea+16, env->gpr_d[8]);
-    cpu_stl_data(env, ea+20, env->gpr_d[9]);
-    cpu_stl_data(env, ea+24, env->gpr_d[10]);
-    cpu_stl_data(env, ea+28, env->gpr_d[11]);
-    cpu_stl_data(env, ea+32, env->gpr_a[12]);
-    cpu_stl_data(env, ea+36, env->gpr_a[13]);
-    cpu_stl_data(env, ea+40, env->gpr_a[14]);
-    cpu_stl_data(env, ea+44, env->gpr_a[15]);
-    cpu_stl_data(env, ea+48, env->gpr_d[12]);
-    cpu_stl_data(env, ea+52, env->gpr_d[13]);
-    cpu_stl_data(env, ea+56, env->gpr_d[14]);
-    cpu_stl_data(env, ea+60, env->gpr_d[15]);
+    cpu_stl_le_data(env, ea, env->PCXI);
+    cpu_stl_le_data(env, ea + 4, psw_read(env));
+    cpu_stl_le_data(env, ea + 8, env->gpr_a[10]);
+    cpu_stl_le_data(env, ea + 12, env->gpr_a[11]);
+    cpu_stl_le_data(env, ea + 16, env->gpr_d[8]);
+    cpu_stl_le_data(env, ea + 20, env->gpr_d[9]);
+    cpu_stl_le_data(env, ea + 24, env->gpr_d[10]);
+    cpu_stl_le_data(env, ea + 28, env->gpr_d[11]);
+    cpu_stl_le_data(env, ea + 32, env->gpr_a[12]);
+    cpu_stl_le_data(env, ea + 36, env->gpr_a[13]);
+    cpu_stl_le_data(env, ea + 40, env->gpr_a[14]);
+    cpu_stl_le_data(env, ea + 44, env->gpr_a[15]);
+    cpu_stl_le_data(env, ea + 48, env->gpr_d[12]);
+    cpu_stl_le_data(env, ea + 52, env->gpr_d[13]);
+    cpu_stl_le_data(env, ea + 56, env->gpr_d[14]);
+    cpu_stl_le_data(env, ea + 60, env->gpr_d[15]);
 }
 
 static void save_context_lower(CPUTriCoreState *env, uint32_t ea)
 {
-    cpu_stl_data(env, ea, env->PCXI);
-    cpu_stl_data(env, ea+4, env->gpr_a[11]);
-    cpu_stl_data(env, ea+8, env->gpr_a[2]);
-    cpu_stl_data(env, ea+12, env->gpr_a[3]);
-    cpu_stl_data(env, ea+16, env->gpr_d[0]);
-    cpu_stl_data(env, ea+20, env->gpr_d[1]);
-    cpu_stl_data(env, ea+24, env->gpr_d[2]);
-    cpu_stl_data(env, ea+28, env->gpr_d[3]);
-    cpu_stl_data(env, ea+32, env->gpr_a[4]);
-    cpu_stl_data(env, ea+36, env->gpr_a[5]);
-    cpu_stl_data(env, ea+40, env->gpr_a[6]);
-    cpu_stl_data(env, ea+44, env->gpr_a[7]);
-    cpu_stl_data(env, ea+48, env->gpr_d[4]);
-    cpu_stl_data(env, ea+52, env->gpr_d[5]);
-    cpu_stl_data(env, ea+56, env->gpr_d[6]);
-    cpu_stl_data(env, ea+60, env->gpr_d[7]);
+    cpu_stl_le_data(env, ea, env->PCXI);
+    cpu_stl_le_data(env, ea + 4, env->gpr_a[11]);
+    cpu_stl_le_data(env, ea + 8, env->gpr_a[2]);
+    cpu_stl_le_data(env, ea + 12, env->gpr_a[3]);
+    cpu_stl_le_data(env, ea + 16, env->gpr_d[0]);
+    cpu_stl_le_data(env, ea + 20, env->gpr_d[1]);
+    cpu_stl_le_data(env, ea + 24, env->gpr_d[2]);
+    cpu_stl_le_data(env, ea + 28, env->gpr_d[3]);
+    cpu_stl_le_data(env, ea + 32, env->gpr_a[4]);
+    cpu_stl_le_data(env, ea + 36, env->gpr_a[5]);
+    cpu_stl_le_data(env, ea + 40, env->gpr_a[6]);
+    cpu_stl_le_data(env, ea + 44, env->gpr_a[7]);
+    cpu_stl_le_data(env, ea + 48, env->gpr_d[4]);
+    cpu_stl_le_data(env, ea + 52, env->gpr_d[5]);
+    cpu_stl_le_data(env, ea + 56, env->gpr_d[6]);
+    cpu_stl_le_data(env, ea + 60, env->gpr_d[7]);
 }
 
 static void restore_context_upper(CPUTriCoreState *env, uint32_t ea,
                                   uint32_t *new_PCXI, uint32_t *new_PSW)
 {
-    *new_PCXI = cpu_ldl_data(env, ea);
-    *new_PSW = cpu_ldl_data(env, ea+4);
-    env->gpr_a[10] = cpu_ldl_data(env, ea+8);
-    env->gpr_a[11] = cpu_ldl_data(env, ea+12);
-    env->gpr_d[8]  = cpu_ldl_data(env, ea+16);
-    env->gpr_d[9]  = cpu_ldl_data(env, ea+20);
-    env->gpr_d[10] = cpu_ldl_data(env, ea+24);
-    env->gpr_d[11] = cpu_ldl_data(env, ea+28);
-    env->gpr_a[12] = cpu_ldl_data(env, ea+32);
-    env->gpr_a[13] = cpu_ldl_data(env, ea+36);
-    env->gpr_a[14] = cpu_ldl_data(env, ea+40);
-    env->gpr_a[15] = cpu_ldl_data(env, ea+44);
-    env->gpr_d[12] = cpu_ldl_data(env, ea+48);
-    env->gpr_d[13] = cpu_ldl_data(env, ea+52);
-    env->gpr_d[14] = cpu_ldl_data(env, ea+56);
-    env->gpr_d[15] = cpu_ldl_data(env, ea+60);
+    *new_PCXI = cpu_ldl_le_data(env, ea);
+    *new_PSW = cpu_ldl_le_data(env, ea + 4);
+    env->gpr_a[10] = cpu_ldl_le_data(env, ea + 8);
+    env->gpr_a[11] = cpu_ldl_le_data(env, ea + 12);
+    env->gpr_d[8]  = cpu_ldl_le_data(env, ea + 16);
+    env->gpr_d[9]  = cpu_ldl_le_data(env, ea + 20);
+    env->gpr_d[10] = cpu_ldl_le_data(env, ea + 24);
+    env->gpr_d[11] = cpu_ldl_le_data(env, ea + 28);
+    env->gpr_a[12] = cpu_ldl_le_data(env, ea + 32);
+    env->gpr_a[13] = cpu_ldl_le_data(env, ea + 36);
+    env->gpr_a[14] = cpu_ldl_le_data(env, ea + 40);
+    env->gpr_a[15] = cpu_ldl_le_data(env, ea + 44);
+    env->gpr_d[12] = cpu_ldl_le_data(env, ea + 48);
+    env->gpr_d[13] = cpu_ldl_le_data(env, ea + 52);
+    env->gpr_d[14] = cpu_ldl_le_data(env, ea + 56);
+    env->gpr_d[15] = cpu_ldl_le_data(env, ea + 60);
 }
 
 static void restore_context_lower(CPUTriCoreState *env, uint32_t ea,
                                   uint32_t *ra, uint32_t *pcxi)
 {
-    *pcxi = cpu_ldl_data(env, ea);
-    *ra = cpu_ldl_data(env, ea+4);
-    env->gpr_a[2] = cpu_ldl_data(env, ea+8);
-    env->gpr_a[3] = cpu_ldl_data(env, ea+12);
-    env->gpr_d[0] = cpu_ldl_data(env, ea+16);
-    env->gpr_d[1] = cpu_ldl_data(env, ea+20);
-    env->gpr_d[2] = cpu_ldl_data(env, ea+24);
-    env->gpr_d[3] = cpu_ldl_data(env, ea+28);
-    env->gpr_a[4] = cpu_ldl_data(env, ea+32);
-    env->gpr_a[5] = cpu_ldl_data(env, ea+36);
-    env->gpr_a[6] = cpu_ldl_data(env, ea+40);
-    env->gpr_a[7] = cpu_ldl_data(env, ea+44);
-    env->gpr_d[4] = cpu_ldl_data(env, ea+48);
-    env->gpr_d[5] = cpu_ldl_data(env, ea+52);
-    env->gpr_d[6] = cpu_ldl_data(env, ea+56);
-    env->gpr_d[7] = cpu_ldl_data(env, ea+60);
+    *pcxi = cpu_ldl_le_data(env, ea);
+    *ra = cpu_ldl_le_data(env, ea + 4);
+    env->gpr_a[2] = cpu_ldl_le_data(env, ea + 8);
+    env->gpr_a[3] = cpu_ldl_le_data(env, ea + 12);
+    env->gpr_d[0] = cpu_ldl_le_data(env, ea + 16);
+    env->gpr_d[1] = cpu_ldl_le_data(env, ea + 20);
+    env->gpr_d[2] = cpu_ldl_le_data(env, ea + 24);
+    env->gpr_d[3] = cpu_ldl_le_data(env, ea + 28);
+    env->gpr_a[4] = cpu_ldl_le_data(env, ea + 32);
+    env->gpr_a[5] = cpu_ldl_le_data(env, ea + 36);
+    env->gpr_a[6] = cpu_ldl_le_data(env, ea + 40);
+    env->gpr_a[7] = cpu_ldl_le_data(env, ea + 44);
+    env->gpr_d[4] = cpu_ldl_le_data(env, ea + 48);
+    env->gpr_d[5] = cpu_ldl_le_data(env, ea + 52);
+    env->gpr_d[6] = cpu_ldl_le_data(env, ea + 56);
+    env->gpr_d[7] = cpu_ldl_le_data(env, ea + 60);
 }
 
 void helper_call(CPUTriCoreState *env, uint32_t next_pc)
@@ -2566,7 +2566,7 @@ void helper_call(CPUTriCoreState *env, uint32_t next_pc)
     ea = ((env->FCX & MASK_FCX_FCXS) << 12) +
          ((env->FCX & MASK_FCX_FCXO) << 6);
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, PSW, A[10], A[11], D[8], D[9], D[10], D[11],
                            A[12], A[13], A[14], A[15], D[12], D[13], D[14],
                            D[15]}; */
@@ -2632,7 +2632,7 @@ void helper_ret(CPUTriCoreState *env)
         A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_upper(env, ea, &new_PCXI, &new_PSW);
     /* M(EA, word) = FCX; */
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* FCX[19: 0] = PCXI[19: 0]; */
     env->FCX = (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
     /* PCXI = new_PCXI; */
@@ -2662,7 +2662,7 @@ void helper_bisr(CPUTriCoreState *env, uint32_t const9)
     ea = ((env->FCX & 0xf0000) << 12) + ((env->FCX & 0xffff) << 6);
 
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, A[11], A[2], A[3], D[0], D[1], D[2], D[3], A[4]
                            , A[5], A[6], A[7], D[4], D[5], D[6], D[7]}; */
     save_context_lower(env, ea);
@@ -2726,7 +2726,7 @@ void helper_rfe(CPUTriCoreState *env)
       A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_upper(env, ea, &new_PCXI, &new_PSW);
     /* M(EA, word) = FCX;*/
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* FCX[19: 0] = PCXI[19: 0]; */
     env->FCX = (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
     /* PCXI = new_PCXI; */
@@ -2744,10 +2744,10 @@ void helper_rfm(CPUTriCoreState *env)
     icr_set_ccpn(env, pcxi_get_pcpn(env));
 
     /* {PCXI, PSW, A[10], A[11]} = M(DCX, 4 * word); */
-    env->PCXI = cpu_ldl_data(env, env->DCX);
-    psw_write(env, cpu_ldl_data(env, env->DCX+4));
-    env->gpr_a[10] = cpu_ldl_data(env, env->DCX+8);
-    env->gpr_a[11] = cpu_ldl_data(env, env->DCX+12);
+    env->PCXI = cpu_ldl_le_data(env, env->DCX);
+    psw_write(env, cpu_ldl_le_data(env, env->DCX + 4));
+    env->gpr_a[10] = cpu_ldl_le_data(env, env->DCX + 8);
+    env->gpr_a[11] = cpu_ldl_le_data(env, env->DCX + 12);
 
     if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
         env->DBGTCR = 0;
@@ -2794,7 +2794,7 @@ void helper_svlcx(CPUTriCoreState *env)
     ea = ((env->FCX & MASK_FCX_FCXS) << 12) +
          ((env->FCX & MASK_FCX_FCXO) << 6);
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, PSW, A[10], A[11], D[8], D[9], D[10], D[11],
                            A[12], A[13], A[14], A[15], D[12], D[13], D[14],
                            D[15]}; */
@@ -2837,7 +2837,7 @@ void helper_svucx(CPUTriCoreState *env)
     ea = ((env->FCX & MASK_FCX_FCXS) << 12) +
          ((env->FCX & MASK_FCX_FCXO) << 6);
     /* new_FCX = M(EA, word); */
-    new_FCX = cpu_ldl_data(env, ea);
+    new_FCX = cpu_ldl_le_data(env, ea);
     /* M(EA, 16 * word) = {PCXI, PSW, A[10], A[11], D[8], D[9], D[10], D[11],
                            A[12], A[13], A[14], A[15], D[12], D[13], D[14],
                            D[15]}; */
@@ -2887,9 +2887,9 @@ void helper_rslcx(CPUTriCoreState *env)
         A[13], A[14], A[15], D[12], D[13], D[14], D[15]} = M(EA, 16 * word); */
     restore_context_lower(env, ea, &env->gpr_a[11], &new_PCXI);
     /* M(EA, word) = FCX; */
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* M(EA, word) = FCX; */
-    cpu_stl_data(env, ea, env->FCX);
+    cpu_stl_le_data(env, ea, env->FCX);
     /* FCX[19: 0] = PCXI[19: 0]; */
     env->FCX = (env->FCX & 0xfff00000) + (env->PCXI & 0x000fffff);
     /* PCXI = new_PCXI; */
-- 
2.52.0



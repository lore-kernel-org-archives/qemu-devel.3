Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219E7C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbAT-0004TG-AR; Fri, 22 Mar 2024 05:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnbAS-0004Sx-9n
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:26:28 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rnbAQ-0006a6-Ny
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:26:28 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e04ac200a6so14109965ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711099585; x=1711704385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIE+jL5V4NFcGQVFSirTmvs1fIjF9x6KbRW+rLR/yNo=;
 b=RN7NB76VrbzNggcMeZu5W7doFSnNIfurYg9Jc9DFx0SeTGtlNVaIGnIAZmdrZh9rGQ
 ngi21lQ3rfsW/NbvRPg1Zjv/3MqtUhAynFs0pmtXK7qI1usB6On/Lq7oEJywqY8Q6f8O
 7+jeyfoWPzHimq9A/Fjzh2BRFwuE9O+xbLpEddNafxvkzzShgdkn/u2KTE3hmV57YlBj
 aErL+mqYJ5vYItl++fSDaLq64WPw2Xi+Rq95Z/fKAlKIhkClJOTFAyaJuJOhyeLuMkHD
 fQLu5mLfge0jIhTB6CxZEw+1kqL1z02xvGcxeoTT14BXDPwa7znRXzn/zr9AJikssGKQ
 YEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711099585; x=1711704385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIE+jL5V4NFcGQVFSirTmvs1fIjF9x6KbRW+rLR/yNo=;
 b=LWA0N3hF+ewRFZPE4TDUtlSbfSSR1WjxX1fo3fvTDhp97xjDeGpVbIg66nUSGqsKKO
 3i4SN4d1bJogZdfvxTByqqWaGid2KnPeU6oY0VMhHosKwCO1BlAI9GiJwqH526rPulGr
 Dz3FX+TNtoqHzivmPBR1or0un3iWcmnv1b8wzLc5BZAMozNaX1aEpstQXCP2XvqyVmkc
 Z7hABlAPThUOc//g/TTZTA2OhTjwxap6icC0kIHuZfQp0DGyyXCyrwn+hxsCb7rK14/Z
 gSs+bYRpnjM5gS6fmnN0vx2yg2cxbiDgb9WXSUt9h8ZzbFvTKsBuCep+eE//X5xpmdD9
 w+KA==
X-Gm-Message-State: AOJu0YxR5DxCLnBoOxxK2wuMHEKYF2rhEWfHRg5N8FXGqbzP7N9cD7Cl
 MtyeJQbBtueu6GbHD3xuvx3VcBZEfdterKCWmEfNpaDFnYUs3FjG7AfhQcV+TD3/F1gM0CBfGy/
 Z53qbJbo85rpf+bOCgqMd9qdelfc0xNyjKa+HYBDMWaePo3xC5pkZnqOu7bt/0yR5STrhJSJFIc
 OMJFNF/KryWM1e+GRWEJtr8b5kShB+PKKShLRXqA==
X-Google-Smtp-Source: AGHT+IFw7e3WoILatcfaBF/HJNBuuMaSUQvcohj0Y7vtZhXvpLFnLFMMiZGMFS/DNTTwRrGULy3xUg==
X-Received: by 2002:a17:903:244d:b0:1de:de58:2a5f with SMTP id
 l13-20020a170903244d00b001dede582a5fmr2057305pls.33.1711099585117; 
 Fri, 22 Mar 2024 02:26:25 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 z14-20020a170903018e00b001e088a9e2bcsm1380380plg.292.2024.03.22.02.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 02:26:24 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 4/4] target/riscv: rvv: Remove redudant SEW checking for
 vector fp narrow/widen instructions
Date: Fri, 22 Mar 2024 17:25:58 +0800
Message-Id: <20240322092600.1198921-5-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322092600.1198921-1-max.chou@sifive.com>
References: <20240322092600.1198921-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If the checking functions check both the single and double width
operators at the same time, then the single width operator checking
functions (require_rvf[min]) will check whether the SEW is 8.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 19059fea5f7..08c22f48cb4 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2333,7 +2333,6 @@ static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
-           (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
            vext_check_dss(s, a->rd, a->rs1, a->rs2, a->vm);
 }
@@ -2373,7 +2372,6 @@ static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
-           (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
            vext_check_ds(s, a->rd, a->rs2, a->vm);
 }
@@ -2406,7 +2404,6 @@ static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
-           (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
            vext_check_dds(s, a->rd, a->rs1, a->rs2, a->vm);
 }
@@ -2446,7 +2443,6 @@ static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
     return require_rvv(s) &&
            require_rvf(s) &&
            require_scale_rvf(s) &&
-           (s->sew != MO_8) &&
            vext_check_isa_ill(s) &&
            vext_check_dd(s, a->rd, a->rs2, a->vm);
 }
@@ -2704,8 +2700,7 @@ static bool opffv_widen_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_widen_check(s, a) &&
            require_rvfmin(s) &&
-           require_scale_rvfmin(s) &&
-           (s->sew != MO_8);
+           require_scale_rvfmin(s);
 }
 
 #define GEN_OPFV_WIDEN_TRANS(NAME, CHECK, HELPER, FRM)             \
@@ -2810,16 +2805,14 @@ static bool opffv_narrow_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_narrow_check(s, a) &&
            require_rvfmin(s) &&
-           require_scale_rvfmin(s) &&
-           (s->sew != MO_8);
+           require_scale_rvfmin(s);
 }
 
 static bool opffv_rod_narrow_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_narrow_check(s, a) &&
            require_rvf(s) &&
-           require_scale_rvf(s) &&
-           (s->sew != MO_8);
+           require_scale_rvf(s);
 }
 
 #define GEN_OPFV_NARROW_TRANS(NAME, CHECK, HELPER, FRM)            \
@@ -2947,8 +2940,7 @@ static bool freduction_widen_check(DisasContext *s, arg_rmrr *a)
 {
     return reduction_widen_check(s, a) &&
            require_rvf(s) &&
-           require_scale_rvf(s) &&
-           (s->sew != MO_8);
+           require_scale_rvf(s);
 }
 
 GEN_OPFVV_WIDEN_TRANS(vfwredusum_vs, freduction_widen_check)
-- 
2.34.1



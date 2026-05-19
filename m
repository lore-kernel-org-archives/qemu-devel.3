Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B64CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDc-0006fS-2S; Tue, 19 May 2026 12:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDV-0006cm-75
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:50 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDN-0000do-SI
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:48 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-479d85152c9so1458588b6e.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207759; x=1779812559; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a0YJCz/+Op9OtTioAKAD1sf9gr9b0ChAoB2bIjmnyqQ=;
 b=peFP067+AfOR8qGHpUwg/DVG1Umr7y3wjxaeGoRclMYXwles3QbYSrzEpmT2yveGia
 9cmXUBY967utT4BKcSWP04H8Qb8o0jlnIS+yB7Wwbj/FsukKEys7K+sqL4TXYpTXdxB+
 cRj76hdPj4ulisluYRamGkccL2q1P6fObFIK9fujkaJlWkQoKLcGO2RgozmXYYVkLSdj
 4Le38l4OOkmCEDiqJLPpROtgpMhm0L1+dX2a0bcN+wU2brv02lS4Lk1IgREWShpkMZSh
 8+JcI7uGyi32zzcVYC0AVK7iAeQJkGoRF/XkLlPY0h5G74cW6X8KKJBiHC0S4lrZSace
 5+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207759; x=1779812559;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a0YJCz/+Op9OtTioAKAD1sf9gr9b0ChAoB2bIjmnyqQ=;
 b=O2JkT31E+Ln41Ckcwp4NtQTEOrKvarrMT8AXuAfwT7rxSmxrYAIct+kU6EqO2nL3Q/
 CnGndlNdSfWoy2HiXdhrt2t/Mcs7mBMiKnskodZgjVvgF/IpvQqQCPZxCkmg30Xw8kB6
 ffSR8sn9cEzC3nrnaATtnvMd6qHsTWsSCiplCmh24cUtDphETnQrCIX2wOk04T1wsiLy
 VSgad594/XxenrNZtgRXQJtS0F4V/WmdtoRYfDB7lR11xxyT6EcUZhXQjef5f+ZV+AcO
 iRZbq+Y8f3KXHouNz4AziuAE3ZE8RcN1cv65yrA/6PLVUeB9EfofIw1K0pjs0yb9jCLO
 tFvg==
X-Gm-Message-State: AOJu0YwyKXUPLekEptoFJ50T+uGnq1N/j/7+6w+7LeuCGU65Hx6/7Bth
 bNlndFP8nCaIwiCUqMFr5uhH+crbX83g5rEvidSL4MtT4XaokRKDXVdJ
X-Gm-Gg: Acq92OEFqw1aLrYiCXzSTuV5RMK3kHbumizHvhYU68b4ZZeClm4wbeGqwS5VOv9LKS4
 u2BD6t58Y4pRf0X/X7k9IWoS1aLxHUYMX42Z6b3TGOtfkJzsKGjDZZzXOhyZNbgkvV4qt52lpup
 ZI43V9NlQn96QisayVQWJnFwUPqsI6Ycsy4uwBCOD1zgd0LUf9V1hWA+osfEq+cxaHMVKGzxtgI
 XjtMs7l0UGRqxBpmnonPoSQRRvxuUCeQJ9UkfpoJYuQCERtW2thb1CMuRahH7KnO6t5ZXOkVKqf
 5nQ11gcBA4zoz5b25YHePFiTHUW79LboeJ9pmRJpR3D8tGFrod8Y67bbQ6+P5LP4MEUhvUA1fAu
 v/oV3fbCaBpmdl5hdnTANWlfMeHo0fLT69Ws1Bl+OkO6LC3JQAZIBIM2J+bAGidpAVk9+qVdCWI
 mNuEFL2cnpT5Y+/UIk1Z8qirET1r7qg8huO6nYqNomNCRsVc6S3d/hfTjc+mZYtLxvYZIAiVAdk
 tREc7i8oKJrQ690TY6U5tpcSrydl1ZpuCtSIDgQO8vIuWzgJCZW6ERgcen/51OHwGGV
X-Received: by 2002:a05:6820:3087:b0:685:7d77:27 with SMTP id
 006d021491bc7-69c9bfd47e6mr13111495eaf.33.1779207758850; 
 Tue, 19 May 2026 09:22:38 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:06 -0600
Subject: [PATCH v9 04/40] target/mips: fix Octeon arithmetic destination
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-4-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the BADDU/DMUL destination handling fix out of the Octeon
    arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the rd == $zero fast paths and let gen_store_gpr() discard
    writes to $zero.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon_translate.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444a..4dd7626835 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 

-- 
2.54.0



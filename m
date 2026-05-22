Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BD1CD5BB4
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUaz-0004lf-55; Fri, 22 May 2026 14:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUax-0004ks-EQ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:39 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUav-0005PG-8j
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ba4efedbeaso56998075ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474456; x=1780079256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFuftV4ssvx9bSSs5jnFr2ka5o9L8dvlbwyKZe1RxvE=;
 b=Ja7jXpbbKVvkk8P5+nk1vCLkSrnwsqyE7z9PulX2d6w21jxf2kyVj94965HPj0pdc/
 NFS6btOf9DxDHuGeAoQbZa8spe2jmHpkKJPhkb8TOCrORfILnNp8VS0dush5IUa4Uqh+
 UusW7uH6ihvnrUbVNmSjyTkexIY7OKyFDUqvb70mC5Ourfm9LbRyHizWv+AufGbXDGNe
 MZqVwKTpQSi0Ogfh8JALJgUAEkZtHY3OpX/j2dF1ABBCGyV1ppGkNT4jTNyZbBaC62QK
 ISjBUzMn8em1+1OwqFqGUqxWg2qrboBbAePsxnFcEdIyesmkqC+FcMYMdhOkFO/oj3Ct
 H+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474456; x=1780079256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eFuftV4ssvx9bSSs5jnFr2ka5o9L8dvlbwyKZe1RxvE=;
 b=DGJaASaCeeWZ4FQ4yKuuENqqr6nbY1zWdKJve+AJG78koIlZxgEGg8lcd/mM54Kv7c
 kSwwiNl1xYwkBgdFdCvGzzSbCjfbcbjVHL4xJzEmekZMjYtlW4/1VuB6I3PBL15Hu6A2
 AaqDJe0V17IsJs+Jntm4LuRXF9Nuqj1y7VsQi8JXYpw9n0Xmcd1kUegdffDqpbax7QeH
 jooFzQgqxeNYS9RQoQVkjPllRgT2n9F8441p5r5LKES7QmkGu49vYc/AX+nbsGJnfTRw
 8XwVxQIrlChaSwGaLkyzYAZRu90hetMgALDOwtYLHPaCQ6/ngfxzTaCQPrWwzXuhhnjh
 MPqQ==
X-Gm-Message-State: AOJu0YxuB+qSBTBI8o4fS7cj+fus9VEMcN/8lJtN9iSpPJqvHMtIYrvi
 xZrnupeKBDf3WGxqusd+fKFAUnlDsQ9Z7MtYZiUzy9UEwulbVcCoOYdyAuiNLpMA9EHmX2F76uE
 U2Hnq
X-Gm-Gg: Acq92OEVG+epCt7kA/wxErKhfC0ejlYeUKaX/3YW1sOHLbJvLPlpKWtfbNVHIPC7/as
 +2kGGnm26v2O2+MvROgOSPCvkkAoL+xa4/eCEozuzWsh6VUiPR3bz5/Z1rKH64MjGxf9GhXr318
 km1NSR+QnACAbDT2ZCvUwruWainvd5iam4cIY9DXVqFtqi06BY9P/RpF8j/B6VCRdBE3H9EdRXp
 UJHLB+F4sShR16etF5JspSKGmSxhxLn2dl4uHbJU00KNQSAgv8UwItd+yJUzzdeQzjYkohkVDgx
 tTTfGLtySDvLtYA37RoncnOgFFS4lw1FUYbyJid/0NqHJQvVrqqmAwEuahNRZsP9xjRvNPYYxPd
 a2Evjh1ufPW4LM5wWACdHyUIP00geUnvYhCowjgMAg3VC0NCNupH2F+voovBPBBwa/DiWNIseXa
 8yRBkUZMG9aZvGjAuo48NZiHZsvL2gAkoDfuUigH2G8BDOSEXljA==
X-Received: by 2002:a17:902:e885:b0:2bc:e62a:979b with SMTP id
 d9443c01a7336-2beb0699cdemr52531995ad.30.1779474455830; 
 Fri, 22 May 2026 11:27:35 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/30] target/alpha: Remove CONFIG_SOFTFLOAT_INLINE
Date: Fri, 22 May 2026 11:26:37 -0700
Message-ID: <20260522182658.184604-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Don't peek into float_status internals.
Fix the helper calls that were missing an argument.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index d2d1467a81..c66e3f9c14 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -34,7 +34,6 @@
 #undef  HELPER_H
 
 #undef ALPHA_DEBUG_DISAS
-#define CONFIG_SOFTFLOAT_INLINE
 
 #ifdef ALPHA_DEBUG_DISAS
 #  define LOG_DISAS(...) qemu_log_mask(CPU_LOG_TB_IN_ASM, ## __VA_ARGS__)
@@ -578,15 +577,7 @@ static void gen_qual_roundmode(DisasContext *ctx, int fn11)
         break;
     }
 
-#if defined(CONFIG_SOFTFLOAT_INLINE)
-    /* ??? The "fpu/softfloat.h" interface is to call set_float_rounding_mode.
-       With CONFIG_SOFTFLOAT that expands to an out-of-line call that just
-       sets the one field.  */
-    tcg_gen_st8_i32(tmp, tcg_env,
-                    offsetof(CPUAlphaState, fp_status.float_rounding_mode));
-#else
-    gen_helper_setroundmode(tmp);
-#endif
+    gen_helper_setroundmode(tcg_env, tmp);
 }
 
 static void gen_qual_flushzero(DisasContext *ctx, int fn11)
@@ -609,12 +600,7 @@ static void gen_qual_flushzero(DisasContext *ctx, int fn11)
         tcg_gen_movi_i32(tmp, 1);
     }
 
-#if defined(CONFIG_SOFTFLOAT_INLINE)
-    tcg_gen_st8_i32(tmp, tcg_env,
-                    offsetof(CPUAlphaState, fp_status.flush_to_zero));
-#else
-    gen_helper_setflushzero(tmp);
-#endif
+    gen_helper_setflushzero(tcg_env, tmp);
 }
 
 static TCGv_i64 gen_ieee_input(DisasContext *ctx, int reg, int fn11, int is_cmp)
-- 
2.43.0



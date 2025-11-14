Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D57ACDE032
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 09:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJphI-0005ST-2x; Fri, 14 Nov 2025 04:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vJpgi-0004IX-DQ
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:01:48 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vJpgf-0007Fp-41
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:01:48 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7aab7623f42so2124966b3a.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 01:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1763110903; x=1763715703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXAFxMHlvRSnA7eqtSuOeq6X1JUPuTSkqH51774VWV8=;
 b=VEHs5vuZe4F+CzumuuaoRlIWhKZJqxxAn0zteGBiZLTOJvSQs1qYjc7irSRT8Q+Yie
 3kEACmxzxcCOq6DVC+f9rVneys2SF4Ul8FZ9qwal06sZu/qiLP+S6dybfZTE3buPuthr
 H9fO/nr2ZUttJs23Jsq7sUHovC4wbltNhA3WhithYxgUFpJWm8CvNkBwJ952LKai3UuL
 latCMtByHmZFcUwdFHFk5MaDHNSHtBy8shLat7oqGYXmtwDcbw3DTiavZQMYB2RDiwDI
 YqF0WKXl8nGEMxkSQPZaDGXTZHCKHwKYsyWfD/B3s8+gvrQ1oqZMPBxrGzzKPVMqvIwF
 Ssdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763110903; x=1763715703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UXAFxMHlvRSnA7eqtSuOeq6X1JUPuTSkqH51774VWV8=;
 b=H11kx3MzA+qI4ifaDKLIcdwYQKsYmHwmX0rDbtittIf49qTGotdWILcOFfZOCHmVE6
 2DoQRaclAEUFOUeOFrAYlxNmPqIJv0AL10ihKOuDvrtVuBE6w35xigQaKGOBN8zSNGmV
 jIOtOkwU2+cS0IeW/pSpWd6PXXFCJobzcjX00AOS40m4emTqklTS16T+0DUx82smkqtt
 vG1CcSPGIX6dl6s9lr0HXgEOVbX4THK3F+urS6RMuLrZ8d8R4PARf0a2kSv+BfpdUwRE
 CV2xMJb57uo45fddfFFr1YWqas1+YP8ONjfAjZMoKhujPXkaPcNbl+OfYKqv8ns93PSg
 g2yA==
X-Gm-Message-State: AOJu0Yy93s4Y+H7iXFzdANjTfdoPSwYTOj34t+tYHgonxrU7jEmLZSxN
 yooveOHv/Fchpb3zC7j3erqLJ2V4dA0Pi3cuUl7CtfJFf2FztPQmeWz+49iDz/UZ1sdRz0xsuhj
 mo6aOegI+IW0Yqg4u1F16/FLyOdA3ymaoqI9H6jPVRbcx5qxVBYZVwF61KDbiDvOrr1SYFOg0Up
 6iWgyjAty0PwQFbNNQrXhX5pve3y5TkBeW1chsAuLAEgE=
X-Gm-Gg: ASbGncvY4pM40+X1MN3nG0dq9LumeoARjVQfg/UgS/mLoNdIxHWCWLG/jxPs6nExJq7
 jpNgyu/qKqi0cfX0vhY5DP+MZjCj0+PMSC2RN5P9KOdKnYe520yJIDxztMeKt2ajdWUuKSNvLiS
 XgSZyIE+HUXV91+M0yc4eZns3zFf33WDqXjh9K56bWkBMum85xLn8X+j/WcB+dYXey4FUDoJHVi
 YHoIp3txPQGBy+iLWg1xKwVWu2e6ScxNmrXbu62JKlx0NwIvjDQvhbqanvGE8VOfts/uBWNUQ5d
 8WSkXMGu0+IsPT2r2YaKXQV7fQWmw8HYyu8SZJxe+VGr/Gn30GPGAseT3NQqigvNLK0awmB4LVT
 JaoUNcWmFj2hca1dgihu/Id/s7r0JSylvlSJk0oq+y9kdyPS8J1caccqZVw6iXfXg7hWcx2NEWy
 WUXYELXe4Ebc1xCZ9AusqlGkb3z8u5Z2iDOOdETykQgWxCIDDS
X-Google-Smtp-Source: AGHT+IG6JoqC+OwN+zp8veFIHYGO7Slcy0gNqgc8sKe5BBh9C+MZgw6tGQH0BeMf+8IR1yFlMFfBJQ==
X-Received: by 2002:a05:7022:ea44:b0:119:e56c:18af with SMTP id
 a92af1059eb24-11b41504ba5mr461285c88.23.1763110902375; 
 Fri, 14 Nov 2025 01:01:42 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b06088625sm8049254c88.8.2025.11.14.01.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 01:01:41 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 1/2] target/riscv: Update MISA.C for Zc* extensions
Date: Fri, 14 Nov 2025 17:01:32 +0800
Message-ID: <20251114090134.1125646-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114090134.1125646-1-frank.chang@sifive.com>
References: <20251114090134.1125646-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42e.google.com
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

From: Frank Chang <frank.chang@sifive.com>

MISA.C is set if the following extensions are selected:
  * Zca and not F.
  * Zca, Zcf and F (but not D) is specified (RV32 only).
  * Zca, Zcf and Zcd if D is specified (RV32 only).
  * Zca, Zcd if D is specified (RV64 only).

Therefore, we need to set MISA.C according to the rules for Zc*
extensions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/tcg/tcg-cpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 440626ddfad..da09a2417cc 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1150,6 +1150,36 @@ static void riscv_cpu_enable_implied_rules(RISCVCPU *cpu)
     }
 }
 
+/*
+ * MISA.C is set if the following extensions are selected:
+ *   - Zca and not F.
+ *   - Zca, Zcf and F (but not D) is specified on RV32.
+ *   - Zca, Zcf and Zcd if D is specified on RV32.
+ *   - Zca, Zcd if D is specified on RV64.
+ */
+static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
+{
+    CPURISCVState *env = &cpu->env;
+
+    if (cpu->cfg.ext_zca && !riscv_has_ext(env, RVF)) {
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+        return;
+    }
+
+    if (riscv_cpu_mxl(env) == MXL_RV32 &&
+        cpu->cfg.ext_zca && cpu->cfg.ext_zcf &&
+        riscv_has_ext(env, RVD) ? cpu->cfg.ext_zcd : riscv_has_ext(env, RVF)) {
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+        return;
+    }
+
+    if (riscv_cpu_mxl(env) == MXL_RV64 &&
+        cpu->cfg.ext_zca && cpu->cfg.ext_zcd) {
+        riscv_cpu_set_misa_ext(env, env->misa_ext | RVC);
+        return;
+    }
+}
+
 void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
@@ -1157,6 +1187,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 
     riscv_cpu_init_implied_exts_rules();
     riscv_cpu_enable_implied_rules(cpu);
+    riscv_cpu_update_misa_c(cpu);
 
     riscv_cpu_validate_misa_priv(env, &local_err);
     if (local_err != NULL) {
-- 
2.43.0



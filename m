Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01646C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvB-0002F5-8S; Sun, 04 May 2025 01:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRuz-00026C-F1
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRux-0004LE-Nb
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso2834292b3a.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336574; x=1746941374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLs0hyci0rcituyWdBDtdIR1bhX23Pfro+/0t+Mt9oA=;
 b=W+zfrH3fZ4ASUZOYqrQVBwyU85Z/N1TbV00FvjUtpw7U2+agQggary942QKPHyhebG
 3XsMCXyYp0EEIqdCJOhgcc3whKFJy2ZIpSJs3lR9MCM+Ydy58muSwZqgPW5m1pWxuWEU
 CLRklHXhOz9/KHjp8X0uksugr3xstZsa4Y03uCy72ivnt7QSmUcuvw6+55ZYmKrhVoN0
 I28c0s00fhSXrBryMNbep5DZdkGg59oEkot8UbDi0l0beYq6qy87oBlFib8RExezfAn0
 +zB4m2TT4Fuc6Xw1ToNYtJtMi1kSrBRCR6A7MelUlsAoLdfO/0LoVAeAeWfD5EkofgtX
 o4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336574; x=1746941374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aLs0hyci0rcituyWdBDtdIR1bhX23Pfro+/0t+Mt9oA=;
 b=t4EEkK4H+/B/MW2e4qwrMvdE5IgpFQNzJ0RIt2D/JcpXB6TdqoaOaANoBfIfCo1CkJ
 m7aaMBI6MnIEPoS2l0afo6e05s+hxZs2ZfImPbuSzKMcfs3j6Ln43xe4Q8aZSbKQ4o3F
 lizWTlPFSY63zalDu6Wvt8Ow3/pqr8vjbShk9UvPZ35P7oFG2T3wjZB0G7BkcTihMkoc
 iM+DVTM+iUYRX0D2hUrCMa67uGzOImjl36J4EX7ETRrm6/X/gYCGRnhZXOdUgqJEFZAP
 DIqg7b59ar5SW0gCef5CXbiqUgjVa9sfaLhOiFFgHAYCyrZ7pMAvTmbMF5sGzKNXhdVh
 Ps3g==
X-Gm-Message-State: AOJu0YzduNeHgDwAHsj26mETOQLxT8Vd1YNhw/ZWqXljicK1n3XrtW9x
 hGnw8EMMh+KFoalNhwqFn9TeIUMr9OYrC2DYv4bpDEPAmC9IEGPWchWVPvp4gSBzu2ltVdZC6Df
 wUek=
X-Gm-Gg: ASbGncvggBufCasKgxTVqOZ4xclumHG4bq4swY0k6olUZP91ZqO12mmHm/1pqsmMtKS
 YlyxF3N+sCiFwH0q1Z3XhAkoLpG/c1BfpbVMpwpccZhyTDaBHTm/8qHJKJ7v5Sk3W/lF3rR4iLP
 g3NId5L927XdrgWVH0DzQrufpF0QInfEfGqchR6iszb5ExQabuKz0w7aDKdLfBSPqiSOgZo2YEl
 I0NO8yDZL4Yd2c5rA3MvEht2RiM2mAwD/5y4Gowl60520tokVreONGhxOVTuVBcs0IY9SjUXS8s
 WRXx2MiRiwfszYm+MboGukNGI2Kk4OilzAD56xJR
X-Google-Smtp-Source: AGHT+IHqt8muxwIyNcbzrNrYudGYr25CIu8flyOznvSVMBbSVnp0yO/7Jx9BB+A2NmmCNDeJqM3yPw==
X-Received: by 2002:a05:6a00:9089:b0:736:b101:aed3 with SMTP id
 d2e1a72fcca58-7405890a880mr10396879b3a.1.1746336574322; 
 Sat, 03 May 2025 22:29:34 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 16/40] target/arm/helper: use vaddr instead of target_ulong
 for probe_access
Date: Sat,  3 May 2025 22:28:50 -0700
Message-ID: <20250504052914.3525365-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h            | 2 +-
 target/arm/tcg/op_helper.c     | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 95b9211c6f4..0a4fc90fa8b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -104,7 +104,7 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
-DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, vaddr, i32, i32, i32)
 
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 38d49cbb9d8..33bc595c992 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1222,7 +1222,7 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
     }
 }
 
-void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+void HELPER(probe_access)(CPUARMState *env, vaddr ptr,
                           uint32_t access_type, uint32_t mmu_idx,
                           uint32_t size)
 {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4f94fe179b0..395c0f5c18e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -258,7 +258,7 @@ static void gen_address_with_allocation_tag0(TCGv_i64 dst, TCGv_i64 src)
 static void gen_probe_access(DisasContext *s, TCGv_i64 ptr,
                              MMUAccessType acc, int log2_size)
 {
-    gen_helper_probe_access(tcg_env, ptr,
+    gen_helper_probe_access(tcg_env, (TCGv_vaddr) ptr,
                             tcg_constant_i32(acc),
                             tcg_constant_i32(get_mem_index(s)),
                             tcg_constant_i32(1 << log2_size));
-- 
2.47.2



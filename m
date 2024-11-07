Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50174D29FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 01:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8rFj-0006bp-Rg; Wed, 06 Nov 2024 20:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rFY-00066q-DX
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8rFW-0003Dh-Pa
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 20:23:52 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so5083455e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 17:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730942628; x=1731547428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZt7LLYaGK4gLd7N4XPj6yKOClYWTX3p+vA4olh24GE=;
 b=CRaKcrwRj4RAj+0F/2CEgcl+aT3D2pKjqJGyElq60dHOniSdP9FVZQhJlE3P1zpn1o
 5PMPlsj9PIr+qyFCYFgWeVaHhKXwdCQf5R9SemDCjrgkZuAk1PxN2VFYBBH2nz/FO98a
 oxrOVnGakfbUB1TVsjloiPzMN4/HCzdlDZ898rvxNOD/zPByDvik2wWeJrroUBQGaVX1
 JN+mGEZkxuqKsky8IZksXYkVGL9Bisqtjz/VQQI83h0IDSBK2mSAS8A86IG9k3LuHXa2
 1fdSstUULYhHn8q472zLCbmUvQQniayh50+FwUn826Za/5kRmZbTY8kyRjubu5pAl28r
 Bcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730942628; x=1731547428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZt7LLYaGK4gLd7N4XPj6yKOClYWTX3p+vA4olh24GE=;
 b=ARfCGJJFuIByW6RcU3eCawmVzKfhD4AVGujNerLK/WYumAJ3wh3N60ZHBPRJCRGe59
 OHsF7RKWSuzgdDDG3acr6bgfr1KkHRNyqd/XoFlxBM/9qF7ADJcT0yKQ05BmuzkZ34pv
 Iz7/fJpDuzsmJJvW+PlmJCbp6DU1YDOg5d9sgo7kdMfx3zrfebXs4ro5k0OpXuF6Lyqs
 5SVIHBubbFOr6qBeLR9SPbLKbQc5vQ/0EJi/THZeTEaiTfZG3Jwv/A+udbEQsycevPI4
 Y6MozKvl8736NlZOiAYQqDdnPD+Av/eqCupm9ktA5Pf/jSJclb/tdlmLKGw3aMEU8O05
 tyJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXfwkmuE5fRHetaT+aY4g1+AkWY2nIbNV18OtYdN6V+rfQI4R+xDGL5QFGHZKXHqoVpeNbJIRKuyTy@nongnu.org
X-Gm-Message-State: AOJu0YzEKhtmBPjXcqsm/Rg011ratziZDlZGlxIdEtJU0/TMNFTIP/jM
 M+mzCTsP8SnQp8NjL+u/q7e9PSqfFUuWQtjISf6h0S2TmUqBNkXPygs1eFW5neQ=
X-Google-Smtp-Source: AGHT+IFXRN6WiTFqa/Fk6PNQ8NtZ1elwOEpHVd30Gs3pwhNy0Jl534sNWnkZH71cgPByFyQl1tDOig==
X-Received: by 2002:a5d:64a7:0:b0:37c:cfdc:19ba with SMTP id
 ffacd0b85a97d-381c7a6bc70mr22195725f8f.28.1730942628446; 
 Wed, 06 Nov 2024 17:23:48 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970d05sm249897f8f.1.2024.11.06.17.23.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 17:23:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/16] target/microblaze: Consider endianness while
 translating code
Date: Thu,  7 Nov 2024 01:22:19 +0000
Message-ID: <20241107012223.94337-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107012223.94337-1-philmd@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Consider the CPU ENDI bit, swap instructions when the CPU
endianness doesn't match the binary one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       | 7 +++++++
 target/microblaze/translate.c | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3e5a3e5c60..6d540713eb 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -412,6 +412,13 @@ void mb_tcg_init(void);
 /* Ensure there is no overlap between the two masks. */
 QEMU_BUILD_BUG_ON(MSR_TB_MASK & IFLAGS_TB_MASK);
 
+static inline bool mb_cpu_is_big_endian(CPUState *cs)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+
+    return !cpu->cfg.endi;
+}
+
 static inline void cpu_get_tb_cpu_state(CPUMBState *env, vaddr *pc,
                                         uint64_t *cs_base, uint32_t *flags)
 {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0b466db694..5595ae4fad 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -709,7 +709,7 @@ static void record_unaligned_ess(DisasContext *dc, int rd,
 
 static inline MemOp mo_endian(DisasContext *dc)
 {
-    return MO_TE;
+    return dc->cfg->endi ? MO_LE : MO_BE;
 }
 
 static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
@@ -1646,7 +1646,8 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
+    ir = translator_ldl_swap(cpu_env(cs), &dc->base, dc->base.pc_next,
+                             mb_cpu_is_big_endian(cs) != TARGET_BIG_ENDIAN);
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
-- 
2.45.2



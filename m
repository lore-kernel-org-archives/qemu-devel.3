Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3472C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMs4A-0000RJ-Sx; Wed, 04 Jun 2025 13:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs48-0000Qa-Um
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:38:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uMs47-0003A6-0T
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:38:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-234bfe37cccso1609105ad.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1749058692; x=1749663492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1EvtJG5mNTqGGcNevZ83Z0Oy3cFvMJyHR4hO17x8rQ=;
 b=Wu4jROsBc2wT+vzZ9qtKr3r+TxqdoN56aGxLtTGbzXT1WDXBym0wUdHfmflQzIF1Gy
 vrXglhuPuVBcTw9GaW/jKmm00GHQwmqRrR9MzwhHLeQWvKyxQQSCkLc7IaLMBbPoaobk
 5r2+iVUamQLcfyitfhXVSeuHNq48pbnps2WmYYjitf6fgRT6sbcQEKPFTekTqR77P3XO
 0k9W8hssjfH4iIsIqXyFCJaKxl1LDmu2yyloXezMpEVFzPx67DXUcG1UKR2m6J80925Z
 W77FqTgyHEorDSE3M1ahU/9AIRS3kJbmh4m9wFwVRdrkuQmuJpN1d/qiu2HoFTx+3cTH
 yceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749058692; x=1749663492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1EvtJG5mNTqGGcNevZ83Z0Oy3cFvMJyHR4hO17x8rQ=;
 b=oeGO2ihIA5S3U74t/NCvMCGu9P55gvKXtTGzABZn7CZvg1ncQpeHp0i6JaBPNpg7mq
 +IzPC0vKWNJ473qqFMSIdMuoXaHQ6MTRImz4RmOKwhgAFaia8aW7XNwYArIWX0ddj4dP
 ba7arZlRGQOtzQF+J4lMhqWFLdt3gdaRrIqzOBwn5e3uJ6yVayoyhqUznxjgs7d2R3xa
 XbFT0nu76dsZzZjxnfEen/Z1tDz3sIXvPwQN9NjglUiH1wklz2wZ5OCY0DioRY+ednDt
 StAmU/pCC4LoTYE+h/QRb356kWdJ/CyoXXJEeCXMwJzrO1cniMHjl9UX2Xiid+8oDJwR
 8xUA==
X-Gm-Message-State: AOJu0YzoF1G2tGaYvDKC9TmrPNgiLzqSPMw/oYfZ3ZHoG3NWIDGpx5E9
 zHL3+PB9WO7C6hcT7bQUrExklbeDKrQiOYLV4xvpEd2v8X4Tis0Y1Mcsn8+/daf9uikzuPA54f4
 UkooqGgs=
X-Gm-Gg: ASbGncsE0njxz/QcKsfATkH4P/xLGorE3wrRgNBh9TF9kz1Cu64cb6UCbEa9VTibiUJ
 DaDpBIjlCenh1T8oZQBgPWWdQDizk0mp09MfZkcVVf63AQ7friYclODeUi6Hk6fq441bDhNZKZe
 diAqfquSE2zVMTjF2W3VJCwBg1Cz1tkRNGwctX4HHCBsiOmvu+qNzWLIdifG9BM7dz59bPqFX6K
 0luJz7eubdLid7Grzy1w3WwR/I/I+a0uellJ+DU4G7RzotFVD7CjB9Uto//mXBY+wYu0k6RC9zn
 6Bj7ym+Ynmjb9vBlg3pVH+u1ojbS36Me68C2kBGuWWCIJNnP4B2fb8xGVIgh5Uj3gQVtHwJ9KDI
 cR6pv
X-Google-Smtp-Source: AGHT+IGPS1f0bWfRJUqvaJHbZIcRqfojaG+q3GEpmYdOOPxpLlciRwqXYsSvnqkksYBRoRF1cUL21w==
X-Received: by 2002:a17:902:f603:b0:234:a063:e2c1 with SMTP id
 d9443c01a7336-235e11fef00mr49640615ad.42.1749058692603; 
 Wed, 04 Jun 2025 10:38:12 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cfcbb9sm106913215ad.208.2025.06.04.10.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 10:38:12 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v2 1/3] target/riscv/tcg: restrict satp_mode changes in
 cpu_set_profile
Date: Wed,  4 Jun 2025 14:37:56 -0300
Message-ID: <20250604173800.1147364-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604173800.1147364-1-dbarboza@ventanamicro.com>
References: <20250604173800.1147364-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

We're changing 'mmu' to true regardless of whether the profile is
being enabled or not, and at the same time we're changing satp_mode to
profile->enabled.

This will promote a situation where we'll set mmu=on without a virtual
memory mode, which is a mistake.

Only touch 'mmu' and satp_mode if the profile is being enabled.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Fixes: 55398025e7 ("target/riscv: add satp_mode profile support")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 target/riscv/tcg/tcg-cpu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index a84cca48fc..857c625580 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1339,16 +1339,16 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
 
     if (profile->enabled) {
         cpu->env.priv_ver = profile->priv_spec;
-    }
 
 #ifndef CONFIG_USER_ONLY
-    if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
-        object_property_set_bool(obj, "mmu", true, NULL);
-        const char *satp_prop = satp_mode_str(profile->satp_mode,
-                                              riscv_cpu_is_32bit(cpu));
-        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
-    }
+        if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+            object_property_set_bool(obj, "mmu", true, NULL);
+            const char *satp_prop = satp_mode_str(profile->satp_mode,
+                                                  riscv_cpu_is_32bit(cpu));
+            object_property_set_bool(obj, satp_prop, true, NULL);
+        }
 #endif
+    }
 
     for (i = 0; misa_bits[i] != 0; i++) {
         uint32_t bit = misa_bits[i];
-- 
2.49.0



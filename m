Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0904BE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2bs-00066r-E3; Wed, 18 Dec 2024 17:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aU-0004DF-46
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:17 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aS-0003WD-MA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:13 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216281bc30fso2368885ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561130; x=1735165930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oo9albpqZecO7rjAPj/A5+mIyg1TEhQK/19ldiN/n/Y=;
 b=IrO17hwrEep5DWHs8EO6ZvGf2ekjZb1iA+K5R4GNGFmvfPWWMHeWjMe/4Qpv9mTXLU
 IR7W4urnBPfQ9/T5IUpHc8uByf6KOUU428eEEqX0uGFy3D9kqPwTwVKUcte+q4iHAZcn
 qqMPkh/RA8wk2c+kigU3K30CYzAkj7SW5u8QP72/XXC7AoEvcxNKI05m7iDR8eU/ii1n
 BpQ9rh7yhfdExqVcKrS49rNc92e52QO29TiFThg35CZgcimhh0h1Koei6I8euOF+MlPT
 etXO2DNNYLsyLhvz5UTwEJzvs2iz6I17lJ5oyqN2uIdXHmov0x4k0nCK3fLOmtDVs8bi
 OAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561130; x=1735165930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oo9albpqZecO7rjAPj/A5+mIyg1TEhQK/19ldiN/n/Y=;
 b=i4gasoNGt0dhqDHK3kuB5/Q0aH1ysq2h8bwsJkNZ6ZIvChrmMz6llOP14sJen0p8WI
 zCg6IJPujDN7uFS4eduQ4b7yf2siWC0R/kvpkEmH+NtxenLBjaGaKZO8xqqR+JcSzzSB
 R8Dj4YI6p41BVcSBZ63zBIzxbfqr/HH4dXhL3+mCVQmBlm8J1BzQY1/cgKI3A2pKOcNe
 ReQ2JNXvajigSrg6UBuo3NhgDIFzVkqokkl9f4m3/HGMdoy/Ti9E4TD88PkxHVaNStAR
 k3bva3TdEJt9CyKoQd+gP7YbDRNEt+wHYHYqhcel2pY4e8d2X9379JPI85KC8uQzfemG
 6AMw==
X-Gm-Message-State: AOJu0Ywm4aGoK6Hke8VEDPfKLciXwaY+2lhLFGMM39t3E9C6JgpI1FfO
 9ufJnIQHY1Uo3VLZPpQGnXQBOPof6+ZnVTGDsb9MoBTF4huM1cKgrQcbKN0F
X-Gm-Gg: ASbGnct9hx7TUzztt9VSj30+ByQQtljImaGTRWmTNrOjE0jK63yVWTxV7ENsLCUXfxL
 wySNyDU6ceFyfR+h+nqYhnt+27eN1otlxS7Di2MKzoDeA2bB59K2Md1cSBq6BcoEcXnM9nTcnwt
 FfmFlTEuUBC6JxNsDUY+YY3GG50PAVo6jG3Gnn0mLxk5okotBA918vlrYTiy4h8AePTvFoR2iMD
 n7sCr/2zBp6lYY/PFuG0ofvQSVLeHKtHm5bfQnF9TOHW0nHSGzZvEIZ2AV0JkLEsE9t/mNWSLT0
 eN0L2AFfr+FB0MfuGfCdfYaIeikgWZbCZqyORsxTHNzUsN8PTV+eE/RvjJErCCg=
X-Google-Smtp-Source: AGHT+IEaMWfcwVLBOavDkl9CJ8uPRZT4bzZgsWHmSZSDslC7TITtbABKwSEAchopTEgvGHnrALWFBA==
X-Received: by 2002:a17:902:e807:b0:20b:a6f5:2768 with SMTP id
 d9443c01a7336-218d6fcc26dmr59964935ad.10.1734561129913; 
 Wed, 18 Dec 2024 14:32:09 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:32:09 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/39] target/riscv/tcg: hide warn for named feats when
 disabling via priv_ver
Date: Thu, 19 Dec 2024 08:30:07 +1000
Message-ID: <20241218223010.1931245-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit 68c9e54bea handled a situation where a warning was being shown
when using the 'sifive_e' cpu when disabling the named extension zic64b.
It makes little sense to show user warnings for named extensions that
users can't control, and the solution taken was to disable zic64b
manually in riscv_cpu_update_named_features().

This solution won't scale well when adding more named features, and can
eventually end up repeating riscv_cpu_disable_priv_spec_isa_exts().

Change riscv_cpu_disable_priv_spec_isa_exts() to not show warnings when
disabling a named feature. This will accomplish the same thing we're
doing today while avoiding having two points where we're disabling
exts via priv_ver mismatch.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241113171755.978109-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3b99c8c9e3..48a55ba1d8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -304,6 +304,15 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
             }
 
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
+
+            /*
+             * Do not show user warnings for named features that users
+             * can't enable/disable in the command line. See commit
+             * 68c9e54bea for more info.
+             */
+            if (cpu_cfg_offset_is_named_feat(edata->ext_enable_offset)) {
+                continue;
+            }
 #ifndef CONFIG_USER_ONLY
             warn_report("disabling %s extension for hart 0x" TARGET_FMT_lx
                         " because privilege spec version does not match",
@@ -331,11 +340,9 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
         cpu->cfg.has_priv_1_13 = true;
     }
 
-    /* zic64b is 1.12 or later */
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
-                          cpu->cfg.cboz_blocksize == 64 &&
-                          cpu->cfg.has_priv_1_12;
+                          cpu->cfg.cboz_blocksize == 64;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.47.1



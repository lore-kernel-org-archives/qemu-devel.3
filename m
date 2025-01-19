Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A28C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJuG-000265-Sr; Sat, 18 Jan 2025 20:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJu0-0001eh-3X
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:15:03 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJty-0003Rj-Am
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:59 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so5810846a91.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249297; x=1737854097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+JZitJ5X0eLTwWV1TxpFzX8qirOhwdqWIWi206MQik=;
 b=RG4NcCfNqnWUydRWrr2xehJhCST/ofaVTexPLfbegz+BMN6ptH44U6eqSq5aumVgTl
 6VkRe9NvEbzIgCEmZYpf1cG4VvsNQcY7AhizvOQCFi7/SzTjvjM8mcUxhTxwlQPqUQht
 ERuajTl2i5JOtbnkH2+ySi61J8WHp6Es2eRaC4MKQyoT/VLr4AtjYmV9slyvhU71hyXP
 YGENaHyGSKxamdVb8wDe97dv6LuT3f/IAbHTmer5iCiDUL9FGXI6pb1MUJ+/9623LfZo
 eJVY2MJ4BBFDfdG4ygq6dx5GhRbDdwXRXeZ2Fg/gf+xJgUXzVlAMGkF7CRbm3l4yIAQO
 rfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249297; x=1737854097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q+JZitJ5X0eLTwWV1TxpFzX8qirOhwdqWIWi206MQik=;
 b=ZUqS99SswSKZwXsKSpYNH3dxNyv9gi/V7EuYX68GelsH1eFVdOQSjarRpabgdqSWWo
 ZFxG77IkJ0Sc6y5wx7jSbRh+waI6CpvPBqu39TXelDsg40bByEuYGO+U/G2a96yl1pAM
 O7rOp/AbM/FI8fCyS+YtVqso2OzC8QiS+tgm9Lie1VMwgZMFr/rUNU5n8U5SKaIxXmB8
 oTgassbdLRde8u0nCmIiRmN01+Dc854J1sTJGCdvAF6cyDw2Wsc04ZatmcOq6WbvOXuQ
 NYm1Ysd+8FF4GydpNQXfhe2tH5+m0NDdV2naM0hp1Yv7afY7ATpj1izJKGFl4Wd6U7if
 r//w==
X-Gm-Message-State: AOJu0Yxyg/zZULxegg8nG0ZLtY1S3U+nRdxJn/D32tzK/nr1i4ggaPkd
 Z/WF0Rs9g5AYJyC+tKEL85vL6wmWZrLCqVMAoQtZsEOY7cfGhM1CYFzpo9Rn
X-Gm-Gg: ASbGncsiZrAxopoG710XrmHvbw+kC7JGxpahOFpqBDBW+pnqyZbnoftBTMGhTuFLrLW
 rbe3K2qMaL1AKfxMaIugWeTSiw3VebHw4bnbhjduox+aeiEZ6050C9m8T2S2Cy0ETrtQU0xDGui
 1/NGgjCBNbz+txa5Jj8Y4WhkhSORtTzIGOPZqV2T3URrdzeShZv/0FR3JO2mtbGOXPvYnE9v9Za
 cyzmRij8qDi/7d1kUe/M8G20LciMYKfJYyBcQDZlUW7A2d81W2fNmW3klr8hMn46QUcE4TrWNG7
 3AfwqFVPZ/xYFBNoBJvAxsrjiaxGNeWBRy82iTS5nKNoN3S/fix58ja9BzCTAiQ0z6/s33CQVA=
 =
X-Google-Smtp-Source: AGHT+IFtMqr1mtyE1U7fPUbZXhd7fPiQ7D3LpDIBFCrGUXrCmYd09bWVUdy68GXer75rhFkiGwse+A==
X-Received: by 2002:a17:90b:2cc3:b0:2ee:d193:f3d5 with SMTP id
 98e67ed59e1d1-2f782c628ddmr12912778a91.7.1737249296746; 
 Sat, 18 Jan 2025 17:14:56 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:56 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 39/50] target/riscv: Fix henvcfg potentially containing
 stale bits
Date: Sun, 19 Jan 2025 11:12:14 +1000
Message-ID: <20250119011225.11452-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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

From: Clément Léger <cleger@rivosinc.com>

With the current implementation, if we had the following scenario:
- Set bit x in menvcfg
- Set bit x in henvcfg
- Clear bit x in menvcfg
then, the internal variable env->henvcfg would still contain bit x due
to both a wrong menvcfg mask used in write_henvcfg() as well as a
missing update of henvcfg upon menvcfg update.
This can lead to some wrong interpretation of the context. In order to
update henvcfg upon menvcfg writing, call write_henvcfg() after writing
menvcfg. Clearing henvcfg upon writing the new value is also needed in
write_henvcfg() as well as clearing henvcfg upper part when writing it
with write_henvcfgh().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250110125441.3208676-2-cleger@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index eddcf5a5d0..279293b86d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2946,6 +2946,8 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
@@ -2974,6 +2976,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
         }
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
+    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
 
     return RISCV_EXCP_NONE;
 }
@@ -2985,6 +2988,8 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
@@ -2996,6 +3001,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
+    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
 
     return RISCV_EXCP_NONE;
 }
@@ -3101,7 +3107,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
         }
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
+    env->henvcfg = val & mask;
 
     return RISCV_EXCP_NONE;
 }
@@ -3134,7 +3140,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (valh & mask);
+    env->henvcfg = (env->henvcfg & 0xFFFFFFFF) | (valh & mask);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.48.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE293CD98E7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQgz-0007KE-1h; Tue, 16 Jun 2026 06:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgx-0007HK-NW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:47 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgw-0003Dw-06
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:47 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c858d69bde9so1712685a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604404; x=1782209204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekSjvEGPuaoh/5V5BG4RKyBzz+gdt7oTF9LQS+JY8Tc=;
 b=r1uoNRMZmPaEulayUC/M7gdDIO9tUTpeN32QvUHBLyhFu4iQVRx+m/J9YRRVRlA7KB
 dD2yBYE+1iyAamkdic65kTVzBFgkqALXTRl3uOVPWwGygKcGBRUm3ViQSpPlCxIWdd2U
 nDr9wL2ZxNkSewFslgB2+twAh4hLNXrym0hCU+JWLvcyWhb1/lbPXAFiUgHLYfNWcxpq
 XOhc4jDdh8BN1Jeg1W8V06Jg11AhXyo4hNSiKU2B/ngjePmU38NHgNpE4CuzlW4iYYKb
 Zbw3F4YYKcxWw71BiDDuxCwv1xqwSAQqmssTPBxs3Q/jN4watcIMumKE6mpU96OuoVR/
 O/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604404; x=1782209204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekSjvEGPuaoh/5V5BG4RKyBzz+gdt7oTF9LQS+JY8Tc=;
 b=BJki6Osx90Es1Fh/AZrGl04PC2xMfyJEkKrHbCL36S7BCApRnYOFrPTZVTR6D9U+cM
 JwYE0cUG6cP/a5J1od3IPPhHEUUyyiEYegSu5s7AbFHKbXLHzfJyirbUTlNlGdtVcAM2
 2vzbfo6joicOTbtg5Rkkk42Y3bDczv+ZFJQfUmWepL0oLtu9JXlaDrKyRXg6lEa0atF6
 deolOVE6psuhNvHSusAe1fwONHXsmAw1aGmY8vIeQwSLv35aGvOWNvRADu4XCS3dE9lO
 35vTJl7GV7ZmuRc2KM6Pkza4RtM7I85OLNnLEBp7CiFWZasAALsm0EPj4iBymBRZZ0NR
 qU4A==
X-Gm-Message-State: AOJu0YxzVa0v/8PHuOCsAWEoLxSin1r6JYC2MN6MRQQONsrfj/EohzhK
 BkL+HlC1UaMFPzMcTmJVXYXcYw/6r7FWEhvb1OK62YpR0N1mSFNeZ48G+osYh2zb
X-Gm-Gg: Acq92OEV5ePfVZ5hNGGqxB067G+wS6gKn4vxUT9Kr3tvgHrmiwEWQj1kxAQJkWzzM+G
 P7Jb3WhAMjEhjlniTvaJUxO4EZYSUPdfZZZsT7BUCPxZ2eXEQfivAP7II/CDZC0DoeX9AjZS9EX
 eBdw+wxH8fuOTQbCrtcoVC/+iNt1IjJ3VoHLhNAXm13EZKBS1suTVroK6Gbv+zKXx0IKMkeAu+U
 IImvXfMd8a8XbkGsdPLZTMj1g4mXONXpLwKUej4cOmFeeHOYdS32QLIlbtdA/jIRAUu761Lx10c
 Nd0+xwRDQQJY/qhJPTcmHOgoV/gz1SukKScQqiVS9IEqAZ+WGAp7Hu+mkXOit8rIjoWEdR+RUIa
 mfavUjz+XlUAKbbYeYLtLAbP4sV8btt3x9nR/fbWgTspTGiaLcUJziu6Lx2hS9xJIzKBuLDrN6s
 HtHuRlsw7Resnmn5AS5co8pgUrBs1ryyFcjHXSje1Q
X-Received: by 2002:a05:6300:4049:b0:3b4:736b:da45 with SMTP id
 adf61e73a8af0-3b783fea080mr20816121637.31.1781604404543; 
 Tue, 16 Jun 2026 03:06:44 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/83] target/riscv: Fix size of ssp
Date: Tue, 16 Jun 2026 20:04:23 +1000
Message-ID: <20260616100527.1939565-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

From: Anton Johansson <anjo@rev.ng>

As ssp holds a pointer, fix to 64 bits in size and make sure stores from
TCG use the correct size to avoid problems on big endian hosts.

Note, the cpu/ssp VMSTATE version is bumped, breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-10-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                            |  2 +-
 target/riscv/machine.c                        |  6 +++---
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 18 +++++++++++++-----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0a684f146f..ae75f9f33f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -257,7 +257,7 @@ struct CPUArchState {
     /* elp state for zicfilp extension */
     bool      elp;
     /* shadow stack register for zicfiss extension */
-    target_ulong ssp;
+    uint64_t ssp;
     /* env place holder for extra word 2 during unwind */
     target_ulong excp_uw2;
     /* sw check code for sw check exception */
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index b6a85ccd3e..7ab62ebc82 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -391,11 +391,11 @@ static bool ssp_needed(void *opaque)
 
 static const VMStateDescription vmstate_ssp = {
     .name = "cpu/ssp",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = ssp_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.ssp, RISCVCPU),
+        VMSTATE_UINT64(env.ssp, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 0b6ad57965..40e5a1b7df 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -32,7 +32,9 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     TCGLabel *skip = gen_new_label();
     uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
     TCGv data = tcg_temp_new();
-    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    TCGv_i64 wide_addr = tcg_temp_new_i64();
+    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_trunc_i64_tl(addr, wide_addr);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
                        mxl_memop(ctx) | MO_ALIGN);
@@ -45,7 +47,8 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
                   tcg_constant_i32(RISCV_EXCP_SW_CHECK));
     gen_set_label(skip);
     tcg_gen_addi_tl(addr, addr, tmp);
-    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_ext_tl_i64(wide_addr, addr);
+    tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
 
     return true;
 }
@@ -59,12 +62,15 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
     TCGv addr = tcg_temp_new();
     int tmp = (get_xl(ctx) == MXL_RV64) ? -8 : -4;
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv_i64 wide_addr = tcg_temp_new_i64();
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_trunc_i64_tl(addr, wide_addr);
     tcg_gen_addi_tl(addr, addr, tmp);
     tcg_gen_qemu_st_tl(data, addr, SS_MMU_INDEX(ctx),
                        mxl_memop(ctx) | MO_ALIGN);
-    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_ext_tl_i64(wide_addr, addr);
+    tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
 
     return true;
 }
@@ -76,7 +82,9 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
     }
 
     TCGv dest = dest_gpr(ctx, a->rd);
-    tcg_gen_ld_tl(dest, tcg_env, offsetof(CPURISCVState, ssp));
+    TCGv_i64 wide_addr = tcg_temp_new_i64();
+    tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_trunc_i64_tl(dest, wide_addr);
     gen_set_gpr(ctx, a->rd, dest);
 
     return true;
-- 
2.54.0



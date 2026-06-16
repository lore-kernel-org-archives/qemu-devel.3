Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4928CCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQh2-0007SW-Tt; Tue, 16 Jun 2026 06:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQh1-0007R5-3S
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:51 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgz-0003FF-HZ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:50 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c86484d35d1so1502752a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604408; x=1782209208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuqUtnH/oNoz/oNxngx7m/7U2knMSUJxAG2hrGUXVBk=;
 b=BNUC9sL5gKKcM6vK1uyha41dQj1HDZ+fqLXKrQJNLfukU10tBkZCy2v1wF4lBy6p23
 DzT+Whazo5On1CCy2w50iJoWRGxEGPyDo90yvYbesXB8MA5Vmfg+DsAswOU5bXuoNrKA
 DyZ54bPcBsTbWC+XlwVINVEa3MmN/IbpmUw01UK+HLrgGDg940UteZQquPhDtJ6B9ZiE
 tossTQFFUHBUvSWIQ4a2nG+0r4Mg3yME+KRiIbwwKQAk0HwV6rxLRYxjXHg0v1nWcCrU
 seUdngGxjwY0wstENYjtaYRc21Qr6NIscRUXaYzwcZb+lUyWjkJs87GotvEHDEloLLE+
 FqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604408; x=1782209208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uuqUtnH/oNoz/oNxngx7m/7U2knMSUJxAG2hrGUXVBk=;
 b=RIpVx7hM15D1dn04c2lvHHWT0+H7MrDKpq1cXb3Ss4dkHsin+ffo4eCXEjdL65TtkM
 98bKJBwQHWvstHIQ8zXFaldHYPVpofrID65pGlOFdugyc28Rs7wCewPfg61JHuyijiPt
 S2amjFCCGoptcCdAi3I93UA+UvHlhBkIbtjjSO6p9LbkhwdQIWNxhrIqeEHnbmnuoRPD
 CflNQSEQhtDc0UIZleecqEv+YmLFgjPfSaM1eRZqzVRo4uN3KzMHRIQ/yMTKD7HhaNni
 Pcj0rB/wfwCoBrF0Pa4ymTGUYSrp7GPOx/sP+hfCXQRtCwSurxCifDkS+OZNGzLQE+8r
 4Wuw==
X-Gm-Message-State: AOJu0YwZGjsQmkZTsR0jDuY5WRJ1XJI0Nx0YTdsRyCCUOXvsaqYKwJVU
 1mhRULHZ1Kcy3zjVlnV9+ZwEIdVvSH3mRIsm9G/Ox9LFq4Z3o2qiiKgRi/5nbUyS
X-Gm-Gg: Acq92OHVPcaf4JuUrQBeDdrZHWQYX56/YcU9dr6RBMJ0zNtprBkDOWBb0t9DaJUZMJ+
 jacvCmSY34F9Lx/mz3/rMQ5lDdde/HAflLcMUxs+vC/E31hCSGbwqe4DU7AAgaZzpY2Vi6HpV5T
 nLs0BAZ2Z+VbYhduF7rueLgLoW/QG4zxXywB+GJ6hpBq/ANWlOAHZTnTTDQ/ho8Uho528c9ZPAp
 DUj1NnT4Ic+Y2jwkyJnk+7HyOt3Z+FtjFPnZh622q5Abq4ZnqzKJvwXN7PQjfS2Wuu84QrbK2xo
 HX6VNJbEf5gH9uTyTO5eU2FA14hE5lR7jj3neY/wO3eB4eCNYWOh+1W+umLVuI52O/VqINHzULP
 E8XWz7dt+3XK6K+3LU1AH4IqwRa8p/3vrLUVlCfk2vmOYcCAcRIPWZ6LUfMsDhiiDTJwz0cqTql
 MnXsAtuR0F/ZJYweszmLwDLNnDhXUw/PPsW76ofFW5
X-Received: by 2002:a05:6a21:a88:b0:3b4:65ac:e2e6 with SMTP id
 adf61e73a8af0-3b7963f2e47mr16212843637.36.1781604408257; 
 Tue, 16 Jun 2026 03:06:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/83] target/riscv: Fix size of excp_uw2
Date: Tue, 16 Jun 2026 20:04:24 +1000
Message-ID: <20260616100527.1939565-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

Fix to 64 bits to match size of instruction start words.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-11-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h       | 2 +-
 target/riscv/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ae75f9f33f..ef21972615 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -259,7 +259,7 @@ struct CPUArchState {
     /* shadow stack register for zicfiss extension */
     uint64_t ssp;
     /* env place holder for extra word 2 during unwind */
-    target_ulong excp_uw2;
+    uint64_t excp_uw2;
     /* sw check code for sw check exception */
     target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 18a1e0ae99..9a0fd700d2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -231,7 +231,7 @@ static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
     tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
 }
 
-static void decode_save_opc(DisasContext *ctx, target_ulong excp_uw2)
+static void decode_save_opc(DisasContext *ctx, uint64_t excp_uw2)
 {
     assert(!ctx->insn_start_updated);
     ctx->insn_start_updated = true;
-- 
2.54.0



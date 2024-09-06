Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600DACE7B1D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sma28-0000c1-6C; Fri, 06 Sep 2024 10:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sma26-0000Vi-J3
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:33:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sma24-00073V-Vh
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:33:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2053a0bd0a6so22441405ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 07:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725633231; x=1726238031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaIvNRilfR6Nz+fW3b1xuwYZ22NkX4J/LvEgnShJQ0w=;
 b=XHbCVZN96Ur5212rHy3NarShsxyuaVNeerWw1zNlWrGY/WahIOfUkHncn7TW4wCwuq
 fJU86KNtP0T8XfcjLUy/SdMoOEelihQ66jl/PjBBcihhS1hCoGFGac0qTfc/WxoOP26f
 AyhLTcb//r/pQXSgQPQucsxj7d9GRM+2eETpdqVQeAC6vgE0pQEoL5TlytsdN1yyFLym
 6/QonXWeI796Zx9qgsGyAMew1mA6uj9xWEHX3Tqyv1RuzzRhXy3pHHNI9C2c7Fm3LUz3
 QCj8XPQFc3hkKvnhTzYmjPV2D48NbBd/iyhZXkuVV8mJrMctloTBYp7DSxvG1SX7H+fP
 Hohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725633231; x=1726238031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xaIvNRilfR6Nz+fW3b1xuwYZ22NkX4J/LvEgnShJQ0w=;
 b=lj2mE1XBn5LGkk0Geob3Hm65P27Uo1SEdAAxYOgr2zJtZF34/NcLusQSZCyiQoPISJ
 JgmYKgRSIOzJH5yEc+x1jXkt/cYBt0/hshnfcBvM8fzxvZX5prkHJkupq6/SE5vGmg9Z
 aHXZDVRDxhynKLHXrgw5whpp6HYKUOYfltYhGO5JPNvknxZE4m38ar8ScQaTTiO7Baem
 NQg76bwWTVAmLDiulIXRbfgkA9EEPdszV7kPunYTBJ/NxHQ9+NMMMhPJ2r/zKK+tqcba
 XZW8ViwG1GriWf5ZwpzA46+T6V01hZrG8ujN9RHqO6Cu73hX5YbvIegBZsUJ/YOdtx7s
 7XzQ==
X-Gm-Message-State: AOJu0YwyUcEclJqNKI8z/MVm6VKDl9tP7AF4Im6kVT9dMtO1dF8Xpf0X
 A7GFjOT7MTrle8ndqXb7zX33o+OiXHozq4fbqk7FU9Wkcak+tQU9hxXgs/Hj5UOniYIAwcZs0uA
 n
X-Google-Smtp-Source: AGHT+IFCmTUOuC/IWmpALilWZ/YjyD1DOO7YMHPiEZakvK0NtiTrsiup55zwClUYMoJIKWGVKoqGkQ==
X-Received: by 2002:a17:903:606:b0:206:98c8:4a71 with SMTP id
 d9443c01a7336-206f05f688cmr24194605ad.38.1725633231314; 
 Fri, 06 Sep 2024 07:33:51 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:42a1:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206ae913cf1sm43844425ad.28.2024.09.06.07.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 07:33:50 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 2/5] gdbstub: Add support for MTE in system mode
Date: Fri,  6 Sep 2024 14:33:13 +0000
Message-Id: <20240906143316.657436-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906143316.657436-1-gustavo.romero@linaro.org>
References: <20240906143316.657436-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit makes handle_q_memtag, handle_q_isaddresstagged, and
handle_Q_memtag stubs build for system mode, allowing all GDB
'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
mode.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/620
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/gdbstub64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 85a19c14c7..9462d3f560 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -430,6 +430,7 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
     return 0;
 #endif
 }
+#endif /* CONFIG_USER_ONLY */
 
 static void handle_q_memtag(GArray *params, void *user_ctx)
 {
@@ -600,12 +601,10 @@ static const GdbCmdParseEntry cmd_handler_table[NUM_CMDS] = {
         .need_cpu_context = true
     },
 };
-#endif /* CONFIG_USER_ONLY */
 
 void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
                                        GPtrArray *qtable, GPtrArray *stable)
 {
-#ifdef CONFIG_USER_ONLY
     /* MTE */
     if (cpu_isar_feature(aa64_mte, cpu)) {
         g_string_append(qsupported, ";memory-tagging+");
@@ -614,5 +613,4 @@ void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
         g_ptr_array_add(qtable, (gpointer) &cmd_handler_table[qIsAddressTagged]);
         g_ptr_array_add(stable, (gpointer) &cmd_handler_table[QMemTags]);
     }
-#endif
 }
-- 
2.34.1



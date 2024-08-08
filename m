Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66205C52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 05:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbvVO-0007aX-QJ; Thu, 08 Aug 2024 01:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvVH-00074e-C8
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:16:00 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sbvVF-0002kY-Mz
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 01:15:59 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70d28023accso561323b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 22:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723094156; x=1723698956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDvV5wCpIRgzAO2ubNmWFuQnSMmzynNkCt87fmBWnrM=;
 b=HN78YkVvRsf6ku9N38bcMkoSloqLZiyjywaiOaP6X+kd18WXERiN3KsGqrqAIMBhyJ
 sIjYSuP2DlIJXfDVL10vnFaMulmzyZRYdc4dkkhGwPUkugkMmcnqBLv5QDMf0U1qrTTd
 QbZs2ov7bXvxwCR04Io0v8atYbgFibfzvaYlIC06QdVzwVV8TSc+tps6Xrj30J4rgwH+
 +J3K2uFd1tq5heDeDbGDx/SSGdHGAPNWao2RuLszXX+3MOY2zBlgcNmkrmfueeBVhInw
 Js0aKoKSyZDoC1SmHBc77ms1ZKG9J02dbw+OShhPGECsqkfVZsFeZecXw4Fn8tYnN8k/
 54Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723094156; x=1723698956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vDvV5wCpIRgzAO2ubNmWFuQnSMmzynNkCt87fmBWnrM=;
 b=qPj6a7OxWq8Xd0L3h5tf5444YhXtrhAwcGhctdwjc8vieeQaejGGEl4IF33plClu2j
 aHDAPe+vdT0LqNpWf5CWqZhn/B6adn+mFYbvrYjjoZo9UW2y7ahdqoG+wOdRmv0I6/ih
 38GwTX5sn5fl2ikqJKrfqgJk+2pVuozhHHhTmLrswBLYDZ83JsLXMqmZ+adKRDuUxwWz
 78IZkrNtR5WzuFyfGO0wfHK1t4iU7aHn47dYACRgK3FzoeKQTLodKYkIhIz9jr5djfWz
 Q4sohU9tSZjQ5DOhj347ObVFde397nCdTuA3z79PwUJkOOwECTxn8sscg+r7D37zbgZv
 KATw==
X-Gm-Message-State: AOJu0YwawkxrUQo25nwItq/5f2MV96W1aU+B33Ax6pF+ZlpPflN9RwQ7
 LDVpvkdlF3fv/usvxudIxYlQQzm5g/Zqb1cjLjKpW4OKSWYX2ShozHUlXTjH3mW4hjfrsNePIuI
 3
X-Google-Smtp-Source: AGHT+IFj+4Asrjqf42vzjc+WPYLcV++Tmi4GPa55BcZmiV7M718mNISBDRkxth4KZMSX7/zaWvbPTg==
X-Received: by 2002:a05:6a00:22c2:b0:70b:1d77:730a with SMTP id
 d2e1a72fcca58-710cae75777mr1117034b3a.28.1723094155849; 
 Wed, 07 Aug 2024 22:15:55 -0700 (PDT)
Received: from amd.. ([2804:7f0:b403:720f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb22a455sm373484b3a.71.2024.08.07.22.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 22:15:55 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 2/4] gdbstub: Add support for MTE in system mode
Date: Thu,  8 Aug 2024 05:15:29 +0000
Message-Id: <20240808051531.3183498-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808051531.3183498-1-gustavo.romero@linaro.org>
References: <20240808051531.3183498-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x435.google.com
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

This commit makes handle_q_memtag, handle_q_isaddresstagged, and
handle_Q_memtag stubs build for system mode, allowing all GDB
'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
mode.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/gdbstub64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 26d242dd63..0f42855763 100644
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



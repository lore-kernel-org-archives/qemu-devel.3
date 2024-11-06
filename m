Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA55CD59F52
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jXR-0004r4-4J; Wed, 06 Nov 2024 12:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jXP-0004qL-VR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:09:47 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jXO-0004a6-CI
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:09:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so368215e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730912984; x=1731517784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6PRNouRIX8nn07oym8VUYNLwY1A8W1UJP1nr46hRjQ=;
 b=S/N6um8AiJUOZRiMLhkjWSxDuENORR3Ev7KGFGhSFDnNM2NakxvoB4/CAg6sMhyMj4
 hX4eYx561IfoE7v5OMgl3r5TrOiG59al2VQACNT6bN29S5byHoDRb4ddecuRACjSdlqh
 /z3vOzLU0BpcRi+FSQ8dihejddRgHTjX44Qf6oVitBtX3znd90CRu/Oh3vHomZgU60G7
 QhVF3pTli20UYzm7zivZXnJVFzbhSAFDqA0mFusFn+KXeum1JNr3d4967y5xHiPxDlXE
 ntb7WOaQOmTND+IyZ7aLhK5U1M6rQjh9MBdh3ym6FrJMk3GJI/OcPAE/I3HbdvZIDgSu
 rvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730912985; x=1731517785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6PRNouRIX8nn07oym8VUYNLwY1A8W1UJP1nr46hRjQ=;
 b=Au8S27NMtWyiRg7pB2uhxOqVzPr8tX3nVpPujxM3QR/5ClojUojnfKRRZZWpv224VZ
 zAkx6HKgOkqGCXUOpjxgTjnUEbeBYW1EvWaBWFcpNI7c9z2bP5I65BXw2EBCNlRjc5vI
 RtyRJaazQYmrsljAGdkVrxSWnFee7rHdBiXI9UJDvusTROETrmBT6nFvrnfxg3SAnppP
 CWo7Bw29/ZhgeinJedqu0o9NY7eAwZoxtwJe4oZV/KqBNXI5Z7ZroIvLQtAjMsB/tdve
 K5agxsFNivTc+LJKwLn9J/ZH0TN2bfgxMpeklJF9E3GV73pVvNzVGJ5wpk9tDS/eUBH7
 Ov3g==
X-Gm-Message-State: AOJu0YxlsndCvchltq0YqZLYaUIuCWX4BkhBJzPGdQUFaTNTpBJzwK7z
 YwQZ+VbEtmM2NNpuT4+U5gMu93RI1cbEtc1p3dxjHVFEQjnngh2/XdDPrmp8/9nc3q/4wZtZ4r2
 VRbPQUBpu
X-Google-Smtp-Source: AGHT+IEQFIvHSU0nxHMm2mMfAi/YGKixOIgfVIcACJyiU+yQNU/4i2ockNU3AUV05vQRX87lKP22Bw==
X-Received: by 2002:a05:600c:3514:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-4327b7ea586mr204699745e9.24.1730912984668; 
 Wed, 06 Nov 2024 09:09:44 -0800 (PST)
Received: from linaro.. ([193.32.126.165]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b2d13sm28918935e9.12.2024.11.06.09.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 09:09:44 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 3/3] plugins: eradicate qemu-plugins.symbols static file
Date: Wed,  6 Nov 2024 09:09:23 -0800
Message-Id: <20241106170923.2976750-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106170923.2976750-1-pierrick.bouvier@linaro.org>
References: <20241106170923.2976750-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32e.google.com
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
 plugins/qemu-plugins.symbols | 59 ------------------------------------
 1 file changed, 59 deletions(-)
 delete mode 100644 plugins/qemu-plugins.symbols

diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
deleted file mode 100644
index 032661f9ea7..00000000000
--- a/plugins/qemu-plugins.symbols
+++ /dev/null
@@ -1,59 +0,0 @@
-{
-  qemu_plugin_bool_parse;
-  qemu_plugin_end_code;
-  qemu_plugin_entry_code;
-  qemu_plugin_get_hwaddr;
-  qemu_plugin_get_registers;
-  qemu_plugin_hwaddr_device_name;
-  qemu_plugin_hwaddr_is_io;
-  qemu_plugin_hwaddr_phys_addr;
-  qemu_plugin_insn_data;
-  qemu_plugin_insn_disas;
-  qemu_plugin_insn_haddr;
-  qemu_plugin_insn_size;
-  qemu_plugin_insn_symbol;
-  qemu_plugin_insn_vaddr;
-  qemu_plugin_mem_get_value;
-  qemu_plugin_mem_is_big_endian;
-  qemu_plugin_mem_is_sign_extended;
-  qemu_plugin_mem_is_store;
-  qemu_plugin_mem_size_shift;
-  qemu_plugin_num_vcpus;
-  qemu_plugin_outs;
-  qemu_plugin_path_to_binary;
-  qemu_plugin_read_memory_vaddr;
-  qemu_plugin_read_register;
-  qemu_plugin_register_atexit_cb;
-  qemu_plugin_register_flush_cb;
-  qemu_plugin_register_vcpu_exit_cb;
-  qemu_plugin_register_vcpu_idle_cb;
-  qemu_plugin_register_vcpu_init_cb;
-  qemu_plugin_register_vcpu_insn_exec_cb;
-  qemu_plugin_register_vcpu_insn_exec_cond_cb;
-  qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu;
-  qemu_plugin_register_vcpu_mem_cb;
-  qemu_plugin_register_vcpu_mem_inline_per_vcpu;
-  qemu_plugin_register_vcpu_resume_cb;
-  qemu_plugin_register_vcpu_syscall_cb;
-  qemu_plugin_register_vcpu_syscall_ret_cb;
-  qemu_plugin_register_vcpu_tb_exec_cb;
-  qemu_plugin_register_vcpu_tb_exec_cond_cb;
-  qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
-  qemu_plugin_register_vcpu_tb_trans_cb;
-  qemu_plugin_request_time_control;
-  qemu_plugin_reset;
-  qemu_plugin_scoreboard_free;
-  qemu_plugin_scoreboard_find;
-  qemu_plugin_scoreboard_new;
-  qemu_plugin_start_code;
-  qemu_plugin_tb_get_insn;
-  qemu_plugin_tb_n_insns;
-  qemu_plugin_tb_vaddr;
-  qemu_plugin_u64_add;
-  qemu_plugin_u64_get;
-  qemu_plugin_u64_set;
-  qemu_plugin_u64_sum;
-  qemu_plugin_uninstall;
-  qemu_plugin_update_ns;
-  qemu_plugin_vcpu_for_each;
-};
-- 
2.39.5



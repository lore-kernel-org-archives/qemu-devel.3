Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443ABE68953
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQv-0003qy-VN; Thu, 31 Oct 2024 00:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQp-0003lO-O5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:12 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQn-00053v-Oy
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:11 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e2b549799eso388370a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347508; x=1730952308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6PRNouRIX8nn07oym8VUYNLwY1A8W1UJP1nr46hRjQ=;
 b=AMpCfDAkTEj6oJvuJxwzCViBuUmhDOC63RdXnyVNx/AW1Z2oUH8jJnwvYWyErbKbsp
 5700OyiYx8D2UTLbA2HORLl84eIIrkAFvk7dM4BMITfXEGAIeSQAp5Q4guatFvlDCzBV
 4V3ywzw0vuET1vibMVvcwmTssI3JjBb5RXXiQOlg4uTbARHYI850fl6EaQu4mvnUnAE4
 jteVSWA74D+leYakZcYV6d7q7mxlLYyiioLgTyxycsx6ZW1gsV6xujwR1ZHImk6NIUXi
 wYffuAcBkWqRY7mU+OcBYpIzfCSrLp48hhdsz1q/CnYEBc/l3RVSv+ZQO1SeSuf7Hji4
 evPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347508; x=1730952308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6PRNouRIX8nn07oym8VUYNLwY1A8W1UJP1nr46hRjQ=;
 b=DZ+uEAVBAFUJqv5XudobKxkPmpHk15QGOtaf82Iy4TnxpaghRontVrYs+deuO7RkJC
 0AqaDzPd7hal3rfdmhiBmHCMIScrXCV7d5ssUdQkr//QBcA4+hQip5KLkNWE39C0eJLv
 AnE/jqCJQXVWXyXddYznfFlfo0I9QmX/2v3XR3sZiiOFXgUm+By46JyQG+68qYOespqc
 eP8/KAyn60gGqXnalvOUVY0NEK4eJKrHYXP8NvIFWF9C31Ew9SMyNmocbieVeVAat9qs
 gYrQqeSIoPo3BwbnGPxzctAkk0sVV8U47XciSRMQkJ8UCLt9/fBaV5E+AupUA9OBTssi
 T8DA==
X-Gm-Message-State: AOJu0Yy0EHanhX99ZSodPU4WcDoC6bGR8+hJiX5Yrip/SxEMn+8cAnZ0
 sUxDLpSakPk8ISQnmWDfT5lMVEmqKmJIN/QVlf32JTgleE8q2fhB39jOfQxzDsYyrSeqouZTNo4
 ZXFWBrg==
X-Google-Smtp-Source: AGHT+IFNUlZ9ZCHcHNB3MpmcCxQnAmblYQ8TaSXTg8sk2Me5P+2Lv1cChtmuJHLo7ls8+N42mBewLw==
X-Received: by 2002:a17:90b:4f81:b0:2e2:cf63:224c with SMTP id
 98e67ed59e1d1-2e8f11d55b4mr17651623a91.35.1730347508125; 
 Wed, 30 Oct 2024 21:05:08 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:05:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 11/12] plugins: eradicate qemu-plugins.symbols static file
Date: Wed, 30 Oct 2024 21:04:25 -0700
Message-Id: <20241031040426.772604-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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



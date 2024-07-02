Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55299C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOiV6-0005Md-KR; Tue, 02 Jul 2024 14:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiV2-0005KC-DD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:08 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOiV0-0008He-S4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:45:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7066cba4ebbso3189802b3a.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719945903; x=1720550703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g07vBTJgnqpvris7VKdjb0Fa8+eQaw4omO7dF9AEhq4=;
 b=C532kVn2WGpAESIAhh6ooQBYpH5w76hNGOO9CRr2DAg0Op4DB5TpHSyiln41M7gZns
 trgYfEHWCNQmrOoUen88l6tzZufM815tdNl7ulL+RLHjSebllM+3cUoJ8JvEjA5Sv4dz
 QMIoBmhXf63GKrm8GYXxXaf2BaVpGWIew4+oIKiCJzmTmuQ89B6A+1gNbNSIK2cTK9dK
 jOL0lgqM5g8bPnkgYwC6jrS2NXbR/2EX1FVnG1hVcBQ+x3d8NjtlUBfI6j/DOaEMDLhW
 J/6EXWlKkFEeICi3kRfSKqIjwowLqLTI1eY0h+ElJU3H7kLuBQ/1algVRI81AOovPuGb
 tKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719945903; x=1720550703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g07vBTJgnqpvris7VKdjb0Fa8+eQaw4omO7dF9AEhq4=;
 b=GRSullZcAonukEyAex5INzRyroSiQY5ZHXtEgbk8wdkv4DO9ZUAEVKgNvkGdSDRPwX
 9cbFWOZVxlaVP+ByikGJ2oXg1+LHx159e7Y6TYN4plIhupaJMpq1dfiVo3CBDMxWTaS0
 lI5oppynRY6zjFXiUm9/rLFSqofUG6tODR0D3rDDnIfrGcoigSoony+NZnu7pVORf0oU
 ELHpq0+IKNfDMMX5HSB3BjeG4D/MBOj+WM8CeULiNsoyI2VfYyvfROh2YQkd0bE0OrPc
 BodLAwVzuvkLX4W8CtTlXSvftNcHgvg6RSuWKTlpuwpIO1mt2Itp4KUwCAO91OMifTkF
 JMzQ==
X-Gm-Message-State: AOJu0YyOCXlW5b5xGD5rMd1Y3sDr78g8iBJ35eVZbuaQ9b+5HZLQtFS9
 2gcqJKhPnnM4N1QY5BiKEKRP59TCZVxo5cQnbWfpAnOFGK6xi/ohlq14jGTQ8U2nKvd9Lfs9GKs
 a
X-Google-Smtp-Source: AGHT+IEKY/4o7ZKpS2gLUCWsv9mLhtLp+pz3RzhE8FiERbY5hOdl8kbFQl9YuVobr2zM7eMttgyzAA==
X-Received: by 2002:a05:6a21:39b:b0:1bd:2207:3f3f with SMTP id
 adf61e73a8af0-1bef6245529mr8280911637.39.1719945902829; 
 Tue, 02 Jul 2024 11:45:02 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3e8196sm9257394a91.49.2024.07.02.11.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:45:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v4 1/7] plugins: fix mem callback array size
Date: Tue,  2 Jul 2024 11:44:42 -0700
Message-Id: <20240702184448.551705-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

data was correctly copied, but size of array was not set
(g_array_sized_new only reserves memory, but does not set size).

As a result, callbacks were not called for code path relying on
plugin_register_vcpu_mem_cb().

Found when trying to trigger mem access callbacks for atomic
instructions.

Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b6bae32b997..ec89a085b43 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -85,8 +85,7 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     len = insn->mem_cbs->len;
     arr = g_array_sized_new(false, false,
                             sizeof(struct qemu_plugin_dyn_cb), len);
-    memcpy(arr->data, insn->mem_cbs->data,
-           len * sizeof(struct qemu_plugin_dyn_cb));
+    g_array_append_vals(arr, insn->mem_cbs->data, len);
     qemu_plugin_add_dyn_cb_arr(arr);
 
     tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
-- 
2.39.2



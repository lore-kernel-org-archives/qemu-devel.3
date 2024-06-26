Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E561C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMcDO-0007Rp-JX; Wed, 26 Jun 2024 19:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDH-0007RU-Di
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:07 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sMcDF-0007Fa-PY
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:38:07 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7180308e90bso3826861a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719445082; x=1720049882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zs33WUET3TwShkJZi0v92Kdx2DNNU6JjJOAyINKhk/A=;
 b=BoGaXvQl02XNNJfhRTX/38eZY8vzQH+Vnlj+PUmWLheho1Xeou5fCsE92k8ulGY3IN
 QCYHJ9gxjZR/T7Vd4Fxek+oRwuM8EcUqqExIhtG4pROlpWc2/KOOlze4EDQuswyfavKh
 nVjPyoOicUPUkifIj5IvaN5XdKCj6pJ57zcnkI1omG9cd1LCCF8DLsixN6xYwa/gzjjY
 +rjxlByMow/+fqCdgkZo0qwSwssrua8es6brHtlsAdsCpLOvLfavfhgUU3+wKiWkzh2k
 vaQ8A/CgFFkvdF0k1ZcgnroGr8B1Kmk78x6jlpscMMZk+zDF9k+uQkuFZjUXNsq6wSC8
 fzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719445082; x=1720049882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zs33WUET3TwShkJZi0v92Kdx2DNNU6JjJOAyINKhk/A=;
 b=jjD6I+PfxSgoOhOjohxMxSlKHzj2r3Pe53xjBalStw3O3i+VFKD7+S3Y+Vl0MUZ7qo
 1r1c5Sr6dR/QFwmHl6ASeD4eqDPs74rFRLNvJq8HbkIgmr7sIAMlvIyuZG0tKckBxKmv
 0oez8+ai05zBSok57xgVSE71YEnALJjTK/bFyRGae00bKhRy8n8BqeReYBgfAZacXK4a
 H1cen3UvfHsgtOt+jW1WIjbP1M8XZrKlHuaUKpqJSBEfuENMZgpor9l+2skl+14ISLty
 QJ5UynSlddgip/DYnJlCYAtH3Y+y9h18HM7bepAvcuMOuiYz3mIm5KUOmW4zR7pQrYja
 YLog==
X-Gm-Message-State: AOJu0Yx8VOFM2ab04WjEWYeXx7/WCesf+P5lwDZe8BMFJ0WaZnCLlZ1B
 adjrQvU5aRj5wQSdczcJZezRHMKhRRM9rqQQpbDmr9aVeREXQ3zvhif3d6oKbM5duwntVSV6jnJ
 0OwI=
X-Google-Smtp-Source: AGHT+IFzpej9jR7IgjG6mC41f94s9fVgfaD17kdcLCz8wFmieV336aCPT5r7KrbPl73aVOJyzMJZtg==
X-Received: by 2002:a05:6a20:7487:b0:1b7:4adb:1dc2 with SMTP id
 adf61e73a8af0-1bcf7eaf9acmr12595873637.21.1719445082474; 
 Wed, 26 Jun 2024 16:38:02 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1faac8df624sm563055ad.29.2024.06.26.16.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 16:38:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 1/7] plugins: fix mem callback array size
Date: Wed, 26 Jun 2024 16:37:51 -0700
Message-Id: <20240626233757.375083-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
References: <20240626233757.375083-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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



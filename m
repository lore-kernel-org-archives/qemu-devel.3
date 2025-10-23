Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDBCCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvXx-0003Kc-1q; Thu, 23 Oct 2025 09:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBvXm-0003IX-DY
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:39:55 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBvXj-0002US-RR
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:39:54 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b6d345d7ff7so84464666b.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761226789; x=1761831589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uu7f2cPMreAu/FEx0SmABAsEb+pXYwyUwIKtWIb8WKU=;
 b=oOKlpbd3KjL6ulbxWQC9VLn8+yi8uA8Yt8m84Kv2/WLsO9uAvYujgfja/JcjamoorU
 rpPMGBIGi3iO/ueU73G04RSZbRFF19ZD34X3U3EJklq6Pv1WkNwhTiR52Si9DwzUqMzn
 6t5qK+iZWEkLmRX2xC5uO1+lWb5P1h9vRSzaQZXn6Uam7iCrRY25lLIRqn95EmNFoz2D
 ITscc2uh4LfW4KJ8aGTUpvVuFf7jhc+jxZ+AEeYBJECZmibpn7owpTvZf576dECdMufl
 SSmLPWxxLiFeerFeKC0ojHqKAdomqrxhkbUzTSfAceXkUgbVKcl+2gGZclf3CFL2iGDe
 9ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761226789; x=1761831589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uu7f2cPMreAu/FEx0SmABAsEb+pXYwyUwIKtWIb8WKU=;
 b=sfZLgp+VJ7pPi9vqAfgWI++YNqp4LEEEd5+BH78H6TFSPs1hu290sAd59F8qIUK1Nm
 5u5Jp673NNEUFO9xrw+1FGxEY7ANJqX20moTb0XMW+QFD4uKFbwQax4EmU1AK9qXHRNF
 45RP/E0RpVNWYx9z7SVrdUSVP/C6aebxCqLwp6780LUM56eJICOgu+2jsgBDU9dXZABI
 PnhojtGjnQ9qSlR5fG/Z/H8dr7GewHt+rnmIHl3zpQ+zeXkXwByA/k9Oq3Bc1lxj9AVi
 DM2TIblKckOZRF636Xh7tZipblb4Jlvs6RWbNTyKLy+hZs5frzTVBasEMsu9ZysntQ/f
 XjUQ==
X-Gm-Message-State: AOJu0YxvSH3L0SFiaqiviuNPwK3NGP2HcijaO4prHx/eWX+DkPQMGtMj
 R6Y1zrfj8ef/VcKLrQbIa8+RhZx+ydoDIebPd5ZHc0q+wM+AUQl9ONlcuwb2g7oMc90=
X-Gm-Gg: ASbGncvTfMyURtAoe5VpH29lMSNyJKwBHp1miele/fLKqmjhE5j4PpN1TufqYvefotV
 TybIcm5XqnRnMapLiI3TQ0DV4LaixNbZfYN+8NRbRPeVLD00GCrDMYQ9wVrY76ROk5zQM57FOx+
 sXUr0NNEExpX0vhQuGK+sN/OGa28ZhI23goKXA8zaiPMXz5TvFcgBAIk8EKnkAGr75Hsk0TU/OX
 Qs/ZQzG7DiMTOAoCy7FBBol3Pvtyo6qPMte1ruB6c7NM8MlcZHC47JkE8ddmYZ05EORgVatwdRP
 8Dj7KtaigSCK8JDx8NjVbAFnXoMXf2kDtQIKA033LbTASpynsgdpLzX7rbvl3A5BsthbeJAtcwC
 +jiLC/hjMeAQ2ivwcwBvU+HRpqnc3kH+O4E+45fntfBtHOQ5m3CcCMjuw0715d8mAhUmb8mYaQB
 QO
X-Google-Smtp-Source: AGHT+IGKMRQXIzhPyDKn5b0RBHZeQ9iiLum0PmzyXO5v5tUQ/RuolL79sa74YPUUGA7SWgGBb8kNvg==
X-Received: by 2002:a17:907:96aa:b0:b38:49a6:5839 with SMTP id
 a640c23a62f3a-b6d2c7216f9mr994931766b.11.1761226789341; 
 Thu, 23 Oct 2025 06:39:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d5f019b0dsm49844866b.53.2025.10.23.06.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 06:39:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E3DE05F7F5;
 Thu, 23 Oct 2025 14:39:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH] plugins/core: add missing QEMU_DISABLE_CFI annotations
Date: Thu, 23 Oct 2025 14:39:43 +0100
Message-ID: <20251023133943.3025569-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Most of the memory callbacks come directly from the generated code
however we have do have a a direct from C callback for the slow-path
and memory helpers.

There is also a reset callback that calls out to plugins.

Like the other plugin points we need to disable CFI as we are making
function calls to dynamically linked libraries.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3175
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/core.c   | 1 +
 plugins/loader.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/plugins/core.c b/plugins/core.c
index 35a252d2729..8f8bc7219c2 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -668,6 +668,7 @@ void exec_inline_op(enum plugin_dyn_cb_type type,
     }
 }
 
+QEMU_DISABLE_CFI
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              uint64_t value_low,
                              uint64_t value_high,
diff --git a/plugins/loader.c b/plugins/loader.c
index ba10ebac993..0dbe7bea263 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -318,6 +318,7 @@ struct qemu_plugin_reset_data {
     bool reset;
 };
 
+QEMU_DISABLE_CFI
 static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
 {
     struct qemu_plugin_ctx *ctx = data->ctx;
-- 
2.47.3



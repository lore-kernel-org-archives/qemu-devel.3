Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A017C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWuW-0002qv-BF; Thu, 04 Jul 2024 20:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWuU-0002qW-UH
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:34:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPWuT-00005m-GE
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 20:34:46 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fb472eacf4so1480695ad.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720139682; x=1720744482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1iFjXkNAAiUT1/HXJR1NSUSkejcZSCzgqp885X9UqQ=;
 b=eD4XBSFpAs7y3Ufc8Gm8AsEe4iKkEAv/bkM7Dm4nn2sohe65wfajiK/PUyem1okib4
 1aKgjvgN2vir1mydEqCpE9RVEmMnqeMUbl7RxSfGM0A7n6YR9jvDKzPs8qhUYBioQBHc
 WhCXSgzSWI+MgAtH2RNTXVSg87bDTMsJsDhPmj/frnO47VrfOtfps9+nyAHmaGe9UDdx
 /yAHrAj/qAbzDO4zQrw3s1lBYVOZ9JYZGwwSuywxPpknIr8sLNBMzDnSNuChrBxyWX6m
 CO1I+iWzyP7XplcCuRgZEnsfXbpED7N/YJNHRmxdf0305+8dkVwF3RvTtigLq6fRqi6G
 XolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720139682; x=1720744482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1iFjXkNAAiUT1/HXJR1NSUSkejcZSCzgqp885X9UqQ=;
 b=u+1pRWpwu7fRW3qfpU1CRdFA4hzz4hgTJeNah77s4YC3gQGhCU8T/h2W1tcxQhqQrK
 6mnhog/19o5qvB+Qj6W/PQaounrwc3S3nPCg2Dk5WGUDrOrSiEgUPANPFylVuBlQY2FD
 IbEThNLkVdoYfCokYyd9aiA5+mOoD9DFoLVxn/KTC2XN3FrqaZw+ULi/63+PEfVeiba2
 pG4ieIV4i1E6R2UgN8IkiIjkfX7sEzNmKlH6nZgb1f3Z9BSvfFtQzCLpkNNIkv7pYeNt
 b/Izk+KqCLovThHt3XTQLmZPSuw7L6tNKzf8Jfqvh2DiFnBrJdrNcdSALPKxYxdXaQbX
 olfg==
X-Gm-Message-State: AOJu0YylzvREgywqHncK/SF8I9u6BuMPxhtS8mXaNiSVhI1kxYBxfeRq
 qFfsytB/fCegdkG2KTeUE2rm2GTZFHqQVQD7OT8Pwy05TLe2MjduUCfyG1G3q40rImTO9HlWOsd
 WKn0=
X-Google-Smtp-Source: AGHT+IG154iHBBybjVeuM2QNASFY0GJAiVkmZCOUmjByhw9qGrumwECi3PApkbLRqGXkiEQtMVo40g==
X-Received: by 2002:a17:903:244a:b0:1f7:345a:e23d with SMTP id
 d9443c01a7336-1fb33e7ef9emr26496615ad.31.1720139682084; 
 Thu, 04 Jul 2024 17:34:42 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb1a075616sm39008595ad.15.2024.07.04.17.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 17:34:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v5 1/7] plugins: fix mem callback array size
Date: Thu,  4 Jul 2024 17:34:15 -0700
Message-Id: <20240705003421.750895-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
References: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



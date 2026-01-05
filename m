Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747F6C79FB7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcp7Y-00019r-SW; Mon, 05 Jan 2026 13:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7P-00015f-6T
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:51 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp77-000353-UE
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:37 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-8888a16d243so1369766d6.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636932; x=1768241732; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BWmrXieWCSWbw5aDZUcuXmz1CVwQXvxz4s+Pt+y6UfI=;
 b=UaFzIHMNCwkGOcpnjf2PbzQvTTCTryUFFz8ZjD1UEeRHpNt106HTxqJTD3cJd9Z2df
 iA7uZ1HNmGONdGqoZf3j8RCdmNb0uIh3zHcCb2lgCpyXXEyyYs9bsPlN/C9mzXCHUhth
 FVvTUPZhylH4WW+rvSvzA+A9/8umG0SaKzqyeUThQqtoZF7QOsa5JQtjstPN9eKYrMeh
 76t25XOCH/v0qv4dcLiOHoSKKJ8qc8C6L27bk0VrauWjCn5Ft0iQkUTeEftuxswrQiRt
 ssnA92S6RSQuS6E3es3LxmiA6TFrUPiGLJn2kTHMSiXZp8VEfnyxRiSWMT0jXS4P3Mrv
 Jrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636932; x=1768241732;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BWmrXieWCSWbw5aDZUcuXmz1CVwQXvxz4s+Pt+y6UfI=;
 b=G4JIKxlYX0hwQzVJ3nQ1ZEAT0HjMumAatyNLcL84UgYc7aZe7f0VRKmw19ZxGumYgL
 WS/jASOlrnvpe0E1K8Nqk+mHeCR+3lZmhbr/WOAkQlZVSsJYZG+C9j4QUB3awCQ5hxuC
 +Z/H/CYkQxEsBuM7Nzi4PRnGNUh73KGtz2vbFFZZOhzgS+lEULyU9RbddLGIe0s6D1ea
 41vGPJlWjC+9/kEUJjIqxh94K2/jRXhT+knTK9IUOMbfLiH39MSXqvKqZQ8oU2nwy4k2
 PxKqMhBkeAhHOOrlloxlY61ZVEjBjVwEp6Nr81n4ouwEoo81vxLgCJDlCVlnzAsaw5T5
 j40A==
X-Gm-Message-State: AOJu0Yw8KjtnUevF3+FZSgLxJGlrCt6xt6WBV+0DGuconVnDVYI2b80l
 3yYii05gQUzj3+OUChhMQcYjTDuPLtdHtDrR+xEyPYiEjhmWdXpINKKh
X-Gm-Gg: AY/fxX7M523jYu8QWHAwAWVPPjtSQ0YmiCG9OsxkoX5GrAH1/NN0gxOOj681//VLlll
 xANGgrkDdcPIYxWDOR+ZwUCdol3443FbbqJ2tdGHQ+2v8Hcoz4MCX7f3TNt9k1mgGKT8wcGciOh
 EbU+zuxAYcwmbKDmtt7kaZgg83afEc0mtmjpaW0Tk4kyNqFd75GPUMktUN8FjiqE96PJckAKtb3
 10RPR1UI+O93yfhpUMaDsWSJdV8oZKbjsL4VUGLXdspo0i2YiMLYLvj4DFa1dVK/9QM9tUUJALr
 +YmP9drWqAc8IwBefm1vQQ/cXEEqKRBdCIkksiIYMkYrOWMaDGqgeAH6h9NnNFHC9osU5rFcX4Y
 vfQcmHKbrdMXfztYTCO21D6L8Vzubdd3jldfr13lw6kvbIt6ltgr+/d2CFq71axe9CCx6PSIEFP
 UthwNh1deADbxv1VfQ6WTX+06M
X-Google-Smtp-Source: AGHT+IHjF8qhvbll+f2NCJXDbsTu75jdWG8PTSweroZXAthjAwRbPR+5lN1OnZ8b6AJ7vJDwULlfQQ==
X-Received: by 2002:a05:6214:5c43:b0:88a:342f:32a with SMTP id
 6a1803df08f44-89075d1cce6mr7381786d6.14.1767636931669; 
 Mon, 05 Jan 2026 10:15:31 -0800 (PST)
Received: from [192.168.1.204] ([185.213.193.254])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907540e24csm3855706d6.25.2026.01.05.10.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:15:31 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 05 Jan 2026 11:14:53 -0700
Subject: [PATCH RFC v3 04/12] linux-user: add MTE_STORE_ONLY to prctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-feat-mte4-v3-4-86a0d99ef2e4@gmail.com>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
In-Reply-To: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767636923; l=2508;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=7iu0AGDmcowWfiZU7ESBith02k7QUQRf9isJWo39Au0=;
 b=vbCSYh9KWkv3PitmxrOhYznRIX9v4mkKzvCyvWXkCYtrno7dqUXMocBVOirwNyiocB2S9paCJ
 0T/pVVcbeOECQ62/QYnTMhUY3tDSfHddMKKP5ytKf3Uhq4AFqESbNP8
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Linux-user processes can now control whether MTE_STORE_ONLY is enabled
using the prctl syscall.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 linux-user/aarch64/mte_user_helper.h |  3 +++
 linux-user/aarch64/target_prctl.h    | 11 +++++++++++
 tests/tcg/aarch64/mte.h              |  3 +++
 3 files changed, 17 insertions(+)

diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
index 0c53abda22..afd2d6dbda 100644
--- a/linux-user/aarch64/mte_user_helper.h
+++ b/linux-user/aarch64/mte_user_helper.h
@@ -20,6 +20,9 @@
 # define PR_MTE_TAG_SHIFT       3
 # define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
 #endif
+#ifndef PR_MTE_STORE_ONLY
+# define PR_MTE_STORE_ONLY      (1UL << 19)
+#endif
 
 /**
  * arm_set_mte_tcf0 - Set TCF0 field in SCTLR_EL1 register
diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/target_prctl.h
index 621be5727f..5207580c1a 100644
--- a/linux-user/aarch64/target_prctl.h
+++ b/linux-user/aarch64/target_prctl.h
@@ -168,6 +168,9 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
     if (cpu_isar_feature(aa64_mte, cpu)) {
         valid_mask |= PR_MTE_TCF_MASK;
         valid_mask |= PR_MTE_TAG_MASK;
+        if (cpu_isar_feature(aa64_mte4, cpu)) {
+            valid_mask |= PR_MTE_STORE_ONLY;
+        }
     }
 
     if (arg2 & ~valid_mask) {
@@ -185,6 +188,14 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArchState *env, abi_long arg2)
          */
         env->cp15.gcr_el1 =
             deposit64(env->cp15.gcr_el1, 0, 16, ~arg2 >> PR_MTE_TAG_SHIFT);
+
+        /*
+         * If MTE_STORE_ONLY is enabled, set the corresponding sctlr_el1 bit
+         */
+        if (cpu_isar_feature(aa64_mte4, cpu)) {
+            env->cp15.sctlr_el[1] =
+                deposit64(env->cp15.sctlr_el[1], 58, 1, extract64(arg2, 19, 1));
+        }
         arm_rebuild_hflags(env);
     }
     return 0;
diff --git a/tests/tcg/aarch64/mte.h b/tests/tcg/aarch64/mte.h
index 0805676b11..17b932f3f1 100644
--- a/tests/tcg/aarch64/mte.h
+++ b/tests/tcg/aarch64/mte.h
@@ -20,6 +20,9 @@
 #ifndef PR_TAGGED_ADDR_ENABLE
 # define PR_TAGGED_ADDR_ENABLE    (1UL << 0)
 #endif
+#ifndef PR_MTE_STORE_ONLY
+# define PR_MTE_STORE_ONLY        (1UL << 19)
+#endif
 #ifndef PR_MTE_TCF_SHIFT
 # define PR_MTE_TCF_SHIFT         1
 # define PR_MTE_TCF_NONE          (0UL << PR_MTE_TCF_SHIFT)

-- 
2.52.0



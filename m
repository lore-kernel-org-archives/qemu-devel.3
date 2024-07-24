Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DE0C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk8H-0001eY-LK; Wed, 24 Jul 2024 18:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk8E-0001XJ-Ro
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:47 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk8D-0006eh-7i
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:46 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7f97e794f34so11561339f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858804; x=1722463604;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKGM9WxUN43+saolT8pUI05xHvMsh3XU6bG+jc3msxQ=;
 b=fj0DpHg4ax3OrtyshVGMggH2e9cZJw2LH+0ojPaVgcqKZWQE2pSA9JMy031cRpldl8
 kGXOJkLfBqAfwHKPhu0T5v+V4Cqir9Uv/JdZyIQzAySbVx66xkrLbnl3fPc2CPS0sThQ
 3dfvqi8fcPHBDzAORCixXraDV/fd5+I6usOLJXdnoFajrfl6cOOhoJ7Bqa0B5JWJHuZ5
 L4jrhQrolV1m3aUo7pqLUqoq6B9CMOpynd8vEFP7svtE0l6if7+9DxHeF4+4zeNC0nVh
 nlumkNKglAEhcsIx28l22AGS3ocZA/1FfG89mFvI6YDzq4Sh+0OqoDN4U6eusNlHDKB3
 FKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858804; x=1722463604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKGM9WxUN43+saolT8pUI05xHvMsh3XU6bG+jc3msxQ=;
 b=btlEqQ8K2fWuLUbJdilg4NNBDwOtD6PZqm+/Q/2aFk1Td4hrk1yoaAUS7hWaPjO9uX
 mVMd7R9VSsbRqVjVtGIqXAbylIIcq7F81jWY7CUEcPu5AlQzxA93HYWCrSUozVVQaliA
 W+6KAvMR2tYitYFXkdUp2AX+K9o/gtRwdSvA1ahrGWCzNIZtuRu0HIZRVRN4Mb4N2X0g
 3GyFIUvvJ5HFNPa65wLxsClW9sl6ls62X4xOjRHY/1O4sgjEOX0s63TGA7xwD2fQlQmo
 P0AuYJZCn9cppzJSY3PyZ4e7IEpT2CrsgFYTLyCGQ9NXVwPArae6Wpx+b9Qktf5fqbid
 ASmg==
X-Gm-Message-State: AOJu0YzZkQqi2OCsy7i2Ve459F4F3qkFBA3cdmn7c/g6PBSBnWNRaG9o
 an9sHCFhDFz5TlVcsmMCmClFjAVEwU4P4kgpCO+2EmgsZHBpHNuFEAQQgPPCWuR76VECTIczTFw
 gWvw=
X-Google-Smtp-Source: AGHT+IEnnOcG3amLwauDTAEsZVbqMoLajLr1bsbICTS01m0+c0LN7TKLMm9Wcy4TgoKOqRk7nYyN/A==
X-Received: by 2002:a05:6602:6417:b0:816:ec51:f415 with SMTP id
 ca18e2360f4ac-81f7ba78fb7mr165580839f.0.1721858803744; 
 Wed, 24 Jul 2024 15:06:43 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/15] bsd-user: Make compile for non-linux user-mode stuff
Date: Wed, 24 Jul 2024 16:04:46 -0600
Message-ID: <20240724220449.10398-14-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d30;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

We include the files that define PR_MTE_TCF_SHIFT only on Linux, but use
them unconditionally. Restrict its use to Linux-only.

"It's ugly, but it's not actually wrong."

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/gdbstub64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index c8cef8cbc0e..5221381cc85 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -404,6 +404,7 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
 
 int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
 {
+#if defined(CONFIG_LINUX)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
 
@@ -425,6 +426,9 @@ int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
     arm_set_mte_tcf0(env, tcf);
 
     return 1;
+#else
+    return 0;
+#endif
 }
 
 static void handle_q_memtag(GArray *params, void *user_ctx)
-- 
2.45.1



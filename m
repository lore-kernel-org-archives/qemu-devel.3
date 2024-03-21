Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83790C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKfS-0004mz-K1; Thu, 21 Mar 2024 11:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKfQ-0004dh-1r
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKf6-0001E8-3V
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:49:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41412411622so8240865e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036138; x=1711640938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Sy5z7ZUuxRw4c3lSjW3Xq5biFR0WjXf8NhA+2yd6fg=;
 b=hGGUCLk4YhgeywHrCiCGHXS0S7AA7K1n+23mB6egJKReHEUzZxpAu6/q0bKjpz4c23
 J7hp7QmWP4o775Y9SSU25qeFmYFXLNDJ9/4bf/RedcAlE5qwYM/Wwq/5OSGIDoemGmZP
 PdSiB5NYODdAOBVT42wvUrLC1k0llhR1DkmPcxFNW97D2tm5nNx+YGiZiuuvm1142m+S
 Ss+O0vQpxufpHz9ITGwrGSNiQRY7+oEgf5GWVuobxqZmKP+CWhFd0Ixumtzi58IQPQYZ
 IFqMj+jVXCDGghqjSk+ZDzUC5zHlaFjyv18jmtA98KVTMi5lHtxZSaUZvAz+qlVeuotg
 OYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036138; x=1711640938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Sy5z7ZUuxRw4c3lSjW3Xq5biFR0WjXf8NhA+2yd6fg=;
 b=EurLKRE/h821SXPdlFKP86sW0HniHc5Ea5M9ttM6pxsJoBC+fQt+HuK3WfkMcsHOt6
 LrRFB5MlxnePH4Yujza9e7ZG4N1kgJojXNfbBRekzwn+aNiUvWm+BCwvMC9MoC6CNi3G
 8dSz5xPASzy4b3KkXxi6S5l1E2tMIG4M7TemCU3P13n2cEcwqL9bGC8gUd7+kk430Sga
 rq0dgemoPREDxm+vCVNjOhJLSDns87tqIh3L2VJ35ifQZGv5Sof4SPLFlA0gM5uhIZ+X
 TDXmlsl+0JLFhw3mUa8dpBNXjEt66x3ks4WyE12G2B0UTGkjiRBQB+Xk+gO8crZhdeyt
 ldyw==
X-Gm-Message-State: AOJu0YzWK9uuX3flTLtyQ4fSxIdtp94REcqRNRwRKGgJFZ5wOcYr02kW
 J/aW/1mvxrU7LDPU0zxIyzqGB8OBTCcjbZU1b25A9U/+92RqJEhq8uh86JiHrYqmL3rAtfjU1yy
 Yg88=
X-Google-Smtp-Source: AGHT+IE8OxZ3cOSBAVlgW9eMWvEy1VRRLSZDeMRQmmPBR4vnwTQ7LCZvczOxtWcLs87HZ5ZefGlaXQ==
X-Received: by 2002:adf:ffc2:0:b0:33e:75e4:d410 with SMTP id
 x2-20020adfffc2000000b0033e75e4d410mr1795606wrs.22.1711036138214; 
 Thu, 21 Mar 2024 08:48:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 dd15-20020a0560001e8f00b0033ce727e728sm17477813wrb.94.2024.03.21.08.48.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:48:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 02/21] hw/core: Remove check on NEED_CPU_H in
 tcg-cpu-ops.h
Date: Thu, 21 Mar 2024 16:48:18 +0100
Message-ID: <20240321154838.95771-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit fd3f7d24d4 ("include/hw/core: Remove i386 conditional
on fake_user_interrupt") remove the need to check on NEED_CPU_H.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index bf8ff8e3ee..88857eb921 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -49,7 +49,6 @@ struct TCGCPUOps {
     /** @debug_excp_handler: Callback for handling debug exceptions */
     void (*debug_excp_handler)(CPUState *cpu);
 
-#ifdef NEED_CPU_H
 #ifdef CONFIG_USER_ONLY
     /**
      * @fake_user_interrupt: Callback for 'fake exception' handling.
@@ -174,7 +173,6 @@ struct TCGCPUOps {
      */
     bool (*need_replay_interrupt)(int interrupt_request);
 #endif /* !CONFIG_USER_ONLY */
-#endif /* NEED_CPU_H */
 
 };
 
-- 
2.41.0



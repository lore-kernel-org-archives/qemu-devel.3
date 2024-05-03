Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9778C25B5C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2rz9-0006lb-Pk; Fri, 03 May 2024 08:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2rz0-0006jm-BA
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:25:48 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2ryx-0000sg-8i
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:25:45 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a597de5a715so288256566b.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714739141; x=1715343941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8DwnhcqDdYLqJv6uh/ywG6qW/XlS7dFgSw/LzDaIEU=;
 b=RoA8XkUtgiMvl0vjVJ6Ie2J3kaHzCpSuMVbA7WkMLVfpR06bzEFD/GbhKCdevqvYHR
 dXhmcnO2NGk03UZW9OmsFKha0xJ5b/oNXsYOeMMtTTHxDTSPhPLxDZ8yqZAswTclipYP
 hSL8VX0+LOS1+Nyh1tYe0rC8wmfRtk519GTDChWTtxHDNdDU0USuiY13sz1lwjLRpOIh
 pQZGxWJixc8HKYX6yyxAwO8oBbI0DQLQXtxKW3WPck5kc8xE+U1zOG+8Mc9W8M+nlBzJ
 6CL5vXGblDzNmJxMnVqU7HN23POF0Pqk3NIAfXnTVM/1LiUAQgKsodFBFpZvx/+fyy4H
 tLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714739141; x=1715343941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8DwnhcqDdYLqJv6uh/ywG6qW/XlS7dFgSw/LzDaIEU=;
 b=ntvDhPwP5+vrr3i9iR0y2IUWd4/ab0JipUZZli3FdnQ5poC/tyz9b1rfruLCO3fqmT
 J5mhk0YELxqptzYorRNXDD+aF5p5jZA5Js9I3pJYQ4j+lrKUZRFtnt2p+Dg/sTNUyQhO
 UXaJ4lfh4nhxmEkHNzpOUeBSe+Cc7MsvCzHcoVrCZxNHXagH7TwpNYY+5fDKekcqvN13
 ipQj9+/+/WJg2UIzPvy9yI0ibgf51Y7Xlfkw9Db99SlHmdkqHVjCmi65mGF1vummQnGm
 v0KE7dmrB6rCNFkiSC8G0fj0hIhTVac1WCRmclvWF/RY/IMToCKTPARkxrPCjhD4prck
 Gk7w==
X-Gm-Message-State: AOJu0YxEUCdBw8BWyqBjCaxmuP2TaKxZEq7ye8bVqactHXTIeKjgOPdl
 VRPJREvyp4vu3c1aYnj+sKFNVz+2srDjU2c5Sgnm4EMudxTTtuQNcDQ4mkiby76d/hnfjvy54bE
 U
X-Google-Smtp-Source: AGHT+IE4UM7LpVAObbU5NIe7HXRa9HaSxgc7ZDPtb67gU8aAcayaGZnF5rX219YP+27Noc7y4CtUeA==
X-Received: by 2002:a50:8711:0:b0:56b:ec47:a846 with SMTP id
 i17-20020a508711000000b0056bec47a846mr1516035edb.25.1714739141326; 
 Fri, 03 May 2024 05:25:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 d25-20020aa7ce19000000b00572a7127cb0sm1637087edv.50.2024.05.03.05.25.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 05:25:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/4] accel/tcg: Do not define cpu_exec_reset_hold() as stub
Date: Fri,  3 May 2024 14:25:24 +0200
Message-ID: <20240503122526.28312-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503122526.28312-1-philmd@linaro.org>
References: <20240503122526.28312-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

In commit 1b5120d74b ("accel: Introduce cpu_exec_reset_hold()")
we defined the user emulation backend cpu_exec_reset_hold() as
a stub. This was a mistake, since common fields are set in
CPU reset, and user emulation needs these fields to be resetted.
Move cpu_exec_reset_hold() back.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/user-exec-stub.c | 4 ----
 accel/tcg/user-exec.c      | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4fbe2dbdc8..2dc6fd9c4e 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -14,10 +14,6 @@ void qemu_init_vcpu(CPUState *cpu)
 {
 }
 
-void cpu_exec_reset_hold(CPUState *cpu)
-{
-}
-
 /* User mode emulation does not support record/replay yet.  */
 
 bool replay_exception(void)
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1c621477ad..6a108eb212 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -37,6 +37,10 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
+void cpu_exec_reset_hold(CPUState *cpu)
+{
+}
+
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
-- 
2.41.0



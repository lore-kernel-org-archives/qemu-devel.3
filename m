Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB867CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQkq-0000tO-Vm; Mon, 12 Jan 2026 17:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkp-0000fo-6I
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:19 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQkn-00032t-KW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:51:18 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso34405455e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258275; x=1768863075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SYz7UJKH6JjyXBJiNuashRtWd9eJGPGNzAuYQmf6QJs=;
 b=EQDA4SEUUz2lXJvPK/+GvyiYJmBEHuyGNWymchZaHZDlrqosyavokIOu6eOuyEnjMP
 vXH9N9pyTSna7R9U2GZgZPOFygwUd4lEybMkLIg1KMbazXCAvpzZSWkX2b4aEcnMhSHp
 SYoWyL4Q8GroC8sb/FWU/55PDdYzjOGurLo9H+O5BrQdZPUVBJeboA4XggCk+NjvPfWv
 JaocTZVJl4L3kjg1cPX+DQ+ydOUUv6q9VRbpUA0L8PBGYJiwNQalndn0WUmDzYDZGePf
 jakSmPJrbAb/F97jeDSq7MPKFqegUnTvpMbCqKV0pej7Zq6hqqK34FkQy734MXFJgi3O
 ix+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258275; x=1768863075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SYz7UJKH6JjyXBJiNuashRtWd9eJGPGNzAuYQmf6QJs=;
 b=jAkwazunFv/shC6JuRDhiSRHWKK/sF49Av1JVTs3uqYbBvuGM0iZVtTPCJ33udZ/PU
 sWFakQ40dzLBmUwUn/MA6g2KD3EiG+EEvSJ72IxrVoXmf94OlS6dEempuFNLqKdD2ed6
 YiEPrfvExHE5vrRu966tk6pU+/kBsZDaMDtQMhaNpzQyW1sPjayet4RzvJBNo1iAtbBb
 O3FikI1PwqCRSnBQkGzKt2sMHe/M51BNVFKmzEM/P2JqXLeIoJYQrY3q2tfJvw/TQVwV
 HsiUgSG9RIBSswV4qkYuGZs7Ij5iWI8zd+D5s4q20aX9Hf06hnbHxGDVvNZt1/vXX8oA
 cBVw==
X-Gm-Message-State: AOJu0YxOXDZsLc2/pjseaMQNozoMoSiOogfHuMzlEAZl7F1NMNt7iF/0
 1N1N/6b6uUPAgQaQ4FLI9khC43OESeXXmlxK/n8zNgc8oWWUQiWMsDEi5Uw22Ns4KrWt0OU3wGE
 teYfX+U4=
X-Gm-Gg: AY/fxX7TgjqUs3AGfsGe8G4tx7dZt4BegikaJrvKEZb+0kj1BQt78+quFH8gNDJKOfy
 qYbLfyb+0oDqY285nUuAaN0RYCsnTEpm6TZqPAfxEpm04XRpc8yNlweNRR+3wkOhkte8tycd7Wg
 R2a7UEGeSIH8KBUZYKUVsFirifZE/iDZ04hGXe1ePGU/HJW0/jRoVmUw9Bpjm0BMvrK+2TL431E
 06fMVHks0L3XMJBKSkKPOgtFHCZcj9bIa4jw6/uzQx3QxSBdjZZPf4OgZAagGK8FlysxA0a0CPk
 kBUAdFcIedzsjbi5iXsfekBE7uFY8G8b7pWhi5NRlNFceFIDNd8WGfAnMP/XJR90MFHYtAnJ3Vk
 +/auz7vjsMMjA0fUr9Ogo4boxqm7oytUFjBGA7ymUpEGxetC3mSUnPRVW/dBqBidarpYwHxVdO0
 WogeNM8uNATqnQQXhbkPBwYaIYNv8gWf5gqDcFFvQCjcZKEUmfqnB0D8S6w1jb
X-Google-Smtp-Source: AGHT+IGm0+1eRto0U7QYFrGlmMkqc8Adq0SRSO7a2dRErhqE4+tP0obevp+Siy/FXRkS12bjLre0og==
X-Received: by 2002:a05:600c:1988:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47d84b52c14mr246114385e9.35.1768258275459; 
 Mon, 12 Jan 2026 14:51:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ecf6a5466sm91616395e9.11.2026.01.12.14.51.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:51:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/61] target/hppa: Remove unnecessary @cpu variable by using
 cpu_env()
Date: Mon, 12 Jan 2026 23:48:15 +0100
Message-ID: <20260112224857.42068-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Partly revert changes introduced by commit b2c2d00f48c ("target/hppa:
add 64 bit support to gdbstub"), restoring the cpu_env() call and
removing the unused @cpu argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251229225517.45078-3-philmd@linaro.org>
---
 target/hppa/gdbstub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 777f4a48b99..0c5e41410a0 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -33,8 +33,7 @@ static int hppa_reg_size(CPUHPPAState *env)
 
 int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
+    CPUHPPAState *env = cpu_env(cs);
     target_ulong val;
 
     if (n >= hppa_num_regs(env)) {
@@ -162,8 +161,7 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
+    CPUHPPAState *env = cpu_env(cs);
     target_ulong val;
 
     if (n >= hppa_num_regs(env)) {
-- 
2.52.0



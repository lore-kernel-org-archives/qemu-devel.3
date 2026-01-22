Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE7EC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visgl-0002Yg-GB; Thu, 22 Jan 2026 06:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visgi-0002Xp-6t
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:17:20 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visgg-0001WB-OG
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:17:19 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so8903195e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769080637; x=1769685437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gJZAa7i4iOzQTSWuw0OaoQb/3iQTzV4apeM8Tmc+fEY=;
 b=e6vyhI4354/T6QJnWheqkxM0hyscYQt+AjpEiOzoqR1YkWfPFeTBK+hQz4/O1fT0ZF
 IMc5q6jc6dyAcdFHFR6Frp1Ns6fGv8sEr6VqcTEtjjgf7ii+Nmbsci2ogHVY0M/wIsRV
 MXokpRZv+ZPkSbx9qF2wrI5OA8XUOG26N1RNgpLcLMJV8JGPcEYz+tN+ksguraQq0sAE
 nkOMaMWkSpm1q3dBluP3mfP79p+BwglyKjrKdPpli5C68I/jklukOLFSUNBqDLnUT3Hu
 0RSrA0N31pnfBJoGMMYDu+QKNqMt+mu2rvIdatV1NP4nMXgpGbt1/sqkUdUZbhfqxY9U
 cyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769080637; x=1769685437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gJZAa7i4iOzQTSWuw0OaoQb/3iQTzV4apeM8Tmc+fEY=;
 b=QlxIZf1XowC2bLlqYcUSozP77H9D65Wk25Bc7pjO5uPeIXy18Gcx+LUnAlM/Sbqt4I
 QWbv7D0k9QSrT8RqIWmRcCBTxIdtW7n9fNkAKlE3fubC9A8e+nozKov58wvWZKjj5NgN
 73uQtN128eZk07iC/2OJAWHdUSgprO1cPGuJGoP4oYqWV3aoryZVnV5vbbNf27qV4A8Z
 Qh8KyRWu5c84PKJYKJFS8Vwf+51XUzrdDEaQBdsPGyJu5LpmuB3sYHGzDZLDDwrq1FVO
 P6dPIXPNAsxqdO3PmawfBZm1xCNsywx8juYB85qD4ee9s1lGOl/HomMGOowXxDZIX2IC
 Tb3w==
X-Gm-Message-State: AOJu0YwCmr34m40UA9hualIl0sh54P6OWNGvk4Iuxu4pTe0mKXKlZ7OF
 zz0TzM4/ggcuwL98g/8S+t/JCHRumeF3V6hzHLEAv6A3OTI64kSQ4NXumzBgVob2DUgA6qfZ07L
 ETo6LlkE=
X-Gm-Gg: AZuq6aI0uJn99dqjzQb4rQR5ZOkjaN4BUsLfyJim4nLlrruyZpwE2XCLkHiLtGzReea
 syboyYJiJ6zBwCULCSE8/o3J6NzfzfbnhMkeGv082K/6LpfIsIKeRJB3+Qwy7g9McpvyKOkfke7
 lvieQpl+w2rXegq/39vBBEIcK4jfGzTSE7rCJyckbg0QF/Eaa4ff7sUx/ZFOOSb/S9tbFHRpTzD
 6F2CMyd7lv4d7VsowI3eAZEdAC7QUl382B/Cj0jOerYVrmjf7cWGYbbToB9IXPKk29+xAugbBMG
 qN3uQD3Vrs6ECCwqgpQ0EWBxNUOdwjQ7hqzA6w30CSdce3ApuKx/K5+kI9xHhDGXYHMm3tzszJj
 aNqzxigxwqXihn1msNfnlq0zMtgzpUdM4LEqQvUkVnv0TL48VJWPhchmQZaXtqKx2WMD1HF4Otb
 MfOdyRvQDg8KzESlHbc3hULro1Kepb7MbMPeETGmFYkvNY3zEr77C98LKzDMmL
X-Received: by 2002:a05:600c:1c13:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-48028a65fb7mr244018345e9.2.1769080636694; 
 Thu, 22 Jan 2026 03:17:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921df9sm45257835f8f.3.2026.01.22.03.17.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 03:17:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/37] target/sh4: Replace cpu_stl_data() call in OCBI helper
Date: Thu, 22 Jan 2026 12:16:38 +0100
Message-ID: <20260122111639.32346-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122111639.32346-1-philmd@linaro.org>
References: <20260122111639.32346-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

In preparation of removing the cpu_stl_data() call,
inline it. Set the return address argument.

See commit 852d481faf7 ("SH: Improve movca.l/ocbi
emulation") for more context on this code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251126202200.23100-11-philmd@linaro.org>
---
 target/sh4/op_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 557b1bf4972..669bc84cb64 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -136,6 +136,8 @@ void helper_discard_movcal_backup(CPUSH4State *env)
 
 void helper_ocbi(CPUSH4State *env, uint32_t address)
 {
+    unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
+    MemOpIdx oi = make_memop_idx(MO_TE | MO_UL | MO_UNALN, mmu_idx);
     memory_content **current = &(env->movcal_backup);
     while (*current)
     {
@@ -143,7 +145,8 @@ void helper_ocbi(CPUSH4State *env, uint32_t address)
         if ((a & ~0x1F) == (address & ~0x1F))
         {
             memory_content *next = (*current)->next;
-            cpu_stl_data(env, a, (*current)->value);
+
+            cpu_stl_mmu(env, a, (*current)->value, oi, GETPC());
 
             if (next == NULL)
             {
-- 
2.52.0



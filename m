Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34C9C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 17:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4jzy-0000CE-V0; Tue, 15 Apr 2025 13:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4jzx-0000Be-Em
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:23:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4jzv-0006v5-Gk
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:23:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso44404835e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744737777; x=1745342577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGss4Nxm8QOt9jRxbySq3QwZ6ueqeO46lfbRBfyFEcU=;
 b=dTUBzPUOAajl7JnH26f8DaTzY07/UPbrbadhQ9BTz2N1AfzG7AgEq/yVCv3ymb8mgi
 OwrRITy+O5pjTjZ9FrV7oCdlgtiUXjyP7+Vof4gq1PZKGNYAoSGdggPpVJqq8rfpLL2n
 ZUWgI7AAWijW+vwFsGYZ/OzWxN1oXSM1Nbc9CFGXNHuv90vuxyF58Mn5wAqUGsaG9ZaB
 nUEGOym9HQ2xXAe/4d9OgFcjhNJ1xxOXqfCuIy4Tr5xDGa4qpQScSS2F7O6vHEX5nZKz
 6vytjbklmrdK8dZYnwdcImx1V9JWWa6/Nc663qZIHnvPcq9jzkMNYbCR8Ujfm+r1fRQD
 PW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744737777; x=1745342577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGss4Nxm8QOt9jRxbySq3QwZ6ueqeO46lfbRBfyFEcU=;
 b=TloLQZejL2DjUzTLJfya/3i4N8pLiFAkbwe9gDz1fJO+LwFrYCEYXKmaF3yeBwgBZB
 dIp5v8uQzWIh3pvoBjgTLmkqMT2cBq6+QJWLpZMCCe03Us2x94e2U+kpG6Uinh+T6pD7
 l7XZAfBYlOKyilfBYHFqnoAPI0hoT146mo6Vd/lC4Rx6SglhEDRQbwbQaHsAhgbV/l5o
 2nuAsRNOQNrrwupM0/3IwvC9A3y+DAGCzrNbgfcw81bmg2h7FDN5WAn38bc4iYO+GFsi
 D2nBLw/P1hnIzV/VuzucVwNprPQ3GwCYIfJXSIjrcRJp9S0Igv8oXe1tzKqC7NU5J0W3
 IP5w==
X-Gm-Message-State: AOJu0YzRXkM3Z2MXOmXRChxl7lpIpge0gTUCGxpNLTRKSDqRbL9HUbx5
 Re7HZBXGT3PKrPFEhSaUJuPsyUJm8YQqbzwBjm+RNyXdBobGNIhJJiaS5sfY/wIzrve5PVTY3Ih
 3
X-Gm-Gg: ASbGncsMATCDyCf6XtiDbcMfGp7+fiGyQt73M1EoDqnv6at7CZxW/Swn9H3ZYfoww8s
 aXwZiBhRI+CKTQfYxg6xQG4UzAD7FPsJ8O8nwvdd1flNba06up51VfAAQySa2WGktUpuw84wBO6
 mQybsZNXaKB1FnWD4XK7SE5OFPNmuxC8oMmjUDne+V3BZsj0XhHkT6leQjVq0ZuwHcJ1XuXamZC
 JAqD/vVZASnSc/b2ObQU6mhUdwfNZh+7LLCZ/WxmQ+/a2Bxv5003GrPEvjnz2L4opqOYlh6oAJM
 AbRcMtMg3Xp0nZbrYo56Z3SOQ/wlKsDFBq2N4tnxutio+9jDibSUlvVgPPOD1Z7wTqcV2LMO8b6
 /gN6f+A2Gf4roLVcroDmnXdJ4gClfyFI=
X-Google-Smtp-Source: AGHT+IHJHIV5E3i8nsF9GkgKghJyzCLpyUEmo+KayvUrk6FBUeQEZGV8v3CUg6uMEJTbJwjlD3+KjQ==
X-Received: by 2002:a05:600c:190e:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-43f3a93fa76mr150829335e9.14.1744737777429; 
 Tue, 15 Apr 2025 10:22:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20625eeesm217223645e9.11.2025.04.15.10.22.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Apr 2025 10:22:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 2/3] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
Date: Tue, 15 Apr 2025 19:22:45 +0200
Message-ID: <20250415172246.79470-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250415172246.79470-1-philmd@linaro.org>
References: <20250415172246.79470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

CPUARMState::pc is of type uint64_t.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h   | 6 +++---
 target/arm/hyp_gdbstub.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 175fb792375..05ceb9bcf5d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1942,9 +1942,9 @@ extern GArray *hw_breakpoints, *hw_watchpoints;
 #define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
 #define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc);
-int insert_hw_breakpoint(target_ulong pc);
-int delete_hw_breakpoint(target_ulong pc);
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc);
+int insert_hw_breakpoint(uint64_t pc);
+int delete_hw_breakpoint(uint64_t pc);
 
 bool check_watchpoint_in_range(int i, target_ulong addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 1e861263b3d..4e52d37ed80 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -54,7 +54,7 @@ GArray *hw_breakpoints, *hw_watchpoints;
  * here so future PC comparisons will work properly.
  */
 
-int insert_hw_breakpoint(target_ulong addr)
+int insert_hw_breakpoint(uint64_t addr)
 {
     HWBreakpoint brk = {
         .bcr = 0x1,                             /* BCR E=1, enable */
@@ -80,7 +80,7 @@ int insert_hw_breakpoint(target_ulong addr)
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_breakpoint(target_ulong pc)
+int delete_hw_breakpoint(uint64_t pc)
 {
     int i;
     for (i = 0; i < hw_breakpoints->len; i++) {
@@ -226,7 +226,7 @@ int delete_hw_watchpoint(target_ulong addr, target_ulong len, int type)
     return -ENOENT;
 }
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc)
 {
     int i;
 
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AF2FD88D8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XV-00042X-L0; Tue, 10 Mar 2026 21:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XP-00040A-9r
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XN-0004rn-Po
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:03 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ae3a2f6007so78685155ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193140; x=1773797940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fzUhr8SvRbL908pmUNQB+xzsUVfNVZZoP6sPrZhT5k=;
 b=JFu0R3PWqAU9mZWuHRnCogJyujJEu4WWk8g04/EICSm6XkFlkn8ayLxb3RGMXZ1kB0
 f7alJdCoYQ46KKEvZ5WLANyKLPHLiVPH3PiNUEGMAwZfCpsxittpB6FX/7s6rW+5b7HD
 DtToDnTuiOPqZ7BKzlagcNsyc5SBytxyyx7pkzbk5cAfeKfBgmtLbZ/wEQP3LFjp1qwX
 0rbFCWD5twAGBkM8+3pDm4iOnRJIecG2oL4VW6AP0FUZ37XhXt+EkigYvisb1jMM3q6P
 V8NGiU1SaGZ8RVPAnmXOnhLVyiCzdP+O+DTiNsfCkxjt8BTB3mM7g3HaCOXnSs0PhlOY
 RHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193140; x=1773797940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0fzUhr8SvRbL908pmUNQB+xzsUVfNVZZoP6sPrZhT5k=;
 b=LuaV/nzdo/82xO6vrdawc8oNE7lGzGF66lvK5KLvwUM2igCUOAbBGObUl3u/4+qjqW
 6kHE5PZeFEErHA9/QxI3WgJ3dknUS88B9j7pC9IVCUTL9wAl3G+aTDtSkDXEFzNy7USe
 OaSjR/Dl3YRSgwU5oYFYDl3RoimX7beS+zsZHabYdLJejEPjqWGDaRZ47Gm9HQSjFONQ
 WAF/mKxzuE1vynQvncAggzjhOORHEEgT2PIJTolQQ2Q0PO7YTo+aLQnwldH6shg5mmWs
 FO2Dfjtlx0acB+c53Wf4hWBCC0ZgDLYiHFuKUNbzExQ09D0m/zyF4P3LZUk873c/S7e2
 zy0w==
X-Gm-Message-State: AOJu0YwyELmkZtbfqnejwhp74E8jrxy8UpWl6f0KPrWC4O6HEtfx6pQ+
 CySjfRPM6bt993tcj0rUeR8PwKuid3KUAxe90RTscHFjYic9oT6BYoSxMHhOsniapl/JLsKhe48
 GZxV3
X-Gm-Gg: ATEYQzwtpn/OvST7E0v5wTLD67+QlqcKUEaEuy0A8kMdCdqIcLPXA/AjkDC7CCMkYDK
 lJRl3tO3sgJog25/saq/27fvbxfz1s2KXbhICpI9udTuRNAq67WXsZJ70OJ9wJ8O4dZ3wy8U95L
 yC7DnlDPo03DhLTZcAwUFx/m1o0qgxiP95I53bP6C8ypK58Ugm5tZrvP2cPHI6KP/8uVwjSXyZk
 m5kYrsM2lpVhkp6AXHc8XwoJK3kdZ9IT6WsugkMVWJOpki5pfZzNmhLwpfov/UOnEohLdo5Z9jk
 LNQhOHhEyo9YjdBecTkax6l1rdaFYmlYBtzR9vDOC/ihxCI1llIvjLms8gPHXBAWV71IUsBs6qs
 JNeKVEL47Y/9n5pycgbDl85x+Z9SE/4ax130yAi/0fzWvDwsoibgFNZoMYCD8OdX4M2LNtlHyYV
 aT7Jkzuh+eNLFi0FVBKQEzRNc7s5Tm9zG7YHODutfaR/SAErjiqIIOqjEdZzhGBNplzAMi0PdQx
 Lwt
X-Received: by 2002:a17:902:ccc9:b0:2ae:698d:94a6 with SMTP id
 d9443c01a7336-2aeae78c71cmr8563335ad.2.1773193140063; 
 Tue, 10 Mar 2026 18:39:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 13/16] tests/tcg: Re-enable disabled multiarch tests for PPC
 targets
Date: Tue, 10 Mar 2026 18:38:34 -0700
Message-ID: <20260311013837.69945-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Previous patch fixed gdbstub / PPC, we can run the tests again.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-14-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/multiarch/Makefile.target | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 1b5760c2f39..508149d57bd 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -163,16 +163,12 @@ else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "need working gdb with $(patsubst -%,,$(TARGET_NAME)) support")
 endif
-# gdbstub currently broken on ppc, see:
-# https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
-ifneq ($(TARGET_NAME), ppc)
 EXTRA_RUNS += run-gdbstub-sha1 run-gdbstub-qxfer-auxv-read \
 	      run-gdbstub-proc-mappings run-gdbstub-thread-breakpoint \
 	      run-gdbstub-registers run-gdbstub-prot-none \
 	      run-gdbstub-catch-syscalls run-gdbstub-follow-fork-mode-child \
 	      run-gdbstub-follow-fork-mode-parent \
 	      run-gdbstub-qxfer-siginfo-read run-gdbstub-late-attach
-endif
 
 # ARM Compatible Semi Hosting Tests
 #
-- 
2.47.3



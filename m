Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4D7FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKckQ-0002Vd-Ny; Wed, 06 May 2026 09:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckD-000249-4L
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKck8-000839-09
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:56:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso4066337f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075809; x=1778680609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bcwpOmxDI9s9xmjmr5qH53DsN9jYAX4P5W66NxwpuT0=;
 b=ykOV1JX25vPgrrZakSh+OT66NPA6QFPLqi2k65gjYxeDShZwkY7g2dgHU0PXTzfoQM
 uc5VJUjC2OfkY/JOMnuUm4QIH8hb3Gj/AfzSlehmFAVwzYcWuNG7uGX78qtyLD3GUKHQ
 MSZOsX1CijhofSILSnRIkOtA50lZDPcNyJZDzL52EhZqJ9O7+Wy7NNH+GOrNXHI/zIj8
 R3uxUY+jpvGJ/NLbxLSZVWC+GNuaS5JP+xbVlg9yXa1usXOkLPqnyKbHF4rKxPNMYtCr
 WhsBpkXKZXE1Y1XpqUK79muYFRGnEfqSluiZFCEUYD1Dtp9ZckT2HRI9Xue+uSaqPfyL
 /slQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075809; x=1778680609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bcwpOmxDI9s9xmjmr5qH53DsN9jYAX4P5W66NxwpuT0=;
 b=l34hRStpMY8Ct5M4eebYZY0MCBIujAEwkDrbRKkmNJQ4EkvjxgYdWCYacrI/FV1di9
 ds2kZJvn6JtyXrUs2gUHgAn2iU17vVsCOavOStyMUPB+AHrWL0Sdzsl0ZoZUOVdejitH
 zWiqB6IdCz3OMcjgFSrblOPuRy9SKN1QO8PbPnCDoIMnAo/jgVbfaLtXTrIAXkfLuffQ
 C/obw/j7IW17fXoINiqEI33JjqrsbYmW5pcNsjUUJlQ3u9E5Dd/Snu34ZcSu2dA/yrOZ
 rrdvcrWDfcKJFIRoyPmxrYW0Ec34L8Rdqf02wdpnYaoZu1twfUyPgMeoTKjkNa5mMaRH
 i8Mw==
X-Gm-Message-State: AOJu0YwM1l1bBtjvQnXLH7VE6pdNcODLh8YLHn796WNLQdRjO8Jw4OKm
 CdwFjdXhujT6RtLhJQv9S42az9ZxaYtUop19u+a7Sfi4OkgWL88hvJEi7I9YI6/DPZl8JYpi4Z6
 I1e405HM=
X-Gm-Gg: AeBDiev8D0VVj/rbN09Knr2h9Et8KTnPpU7jHAjaQ3hpxDLInog5pkAM5J+fQfwpSrc
 Zj/MOYtgJsezk+gsbEcaP8bCP3zZqXBdxs7+dSLCBMXM9K+tsTXKT1zHOSqwMkLJZqLxIoD1eer
 QbYbpSDSrvgJgkelEckm8/DM+pun8zHuNrFtMoEV9Uj0ZoTnm489KDAZVTFVvF+rnn2Y501AxK3
 dtnXOW/c4z93lhbRBGKxlaXjfYTnLJpUhRAmFLktydPLqvcpz3TyC55Av2c8+GWR2stUQwFkQg+
 z/Ah31pzafqUjBZEcISJ5zF5Q6q40hkJy8gnrKQh9mMN26ZFYxgzr07vRImBuWitAksz3GZ/7FZ
 2rKUr9onFRS9RbB7GiQjwna7dScOXXOMDVuK6E8e+IxyQq6PtNIQDUjUcjxb6SY9nJCJ4gIzZrn
 2pDnMUFznu0BdhBC9PL4vGAuLVkXEbfvzeudBJ520/pF15WKgtrKHvYz0CfU8JsxzWiBOFvPp0M
 LEL1tT7HxU=
X-Received: by 2002:a05:600c:3548:b0:488:c40b:c8a4 with SMTP id
 5b1f17b1804b1-48e51e097a2mr63284135e9.1.1778075809387; 
 Wed, 06 May 2026 06:56:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a8159sm56395805e9.6.2026.05.06.06.56.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:56:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 011/110] target/sparc: Include missing 'exec/target_long.h'
 header
Date: Wed,  6 May 2026 15:53:43 +0200
Message-ID: <20260506135524.20617-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  ../target/sparc/cpu.h:615:1: error: unknown type name 'target_ulong'
    615 | target_ulong cpu_get_fsr(CPUSPARCState *);
        | ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-15-philmd@linaro.org>
---
 target/sparc/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 0139732e4cc..155aa8ec637 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -5,6 +5,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/target_long.h"
 #include "qemu/cpu-float.h"
 
 #if !defined(TARGET_SPARC64)
-- 
2.53.0



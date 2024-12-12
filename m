Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237A6E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoLM-000623-QC; Thu, 12 Dec 2024 13:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoLC-0005uW-PS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:16 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoL9-0006mW-PY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:13 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-725ea1e19f0so787914b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029710; x=1734634510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOxJYB9c/D0W9G+42lYaV6c+pfgO+zsH3Ru4s5NUUH0=;
 b=WjYAOu/IuYQ0b8Lq6mFv/fwHOIvLNWIFA5CjN0HvSkYMNT9dCF++aA/hpwP8nCsm7i
 pvCUyC4I2y2sEGXqXFATbbM88D8MTTbmzNcvcrAHOaknoD0Uw8hTX2+JalC1lcfAtv8L
 LRIg3/EerA7vCMLvEz2soWR2vVCQ1fKKUqhR7ZmE2psG7rxHA38+UKTYXJQ+s3/R2WJM
 JuFiF9k9Oc3Y8bBvzr1kEOc93AhhknUFRPN3THRe5jMPBBPPWumcAF6Cu4f3pTUKzDRJ
 C75SPMQ+ubJgc9pkvlmQQNbS/Jx4Xm4T85+fuBHdJoOD/nKpeUna2TeA8wyjYTCPTqeg
 dD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029710; x=1734634510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BOxJYB9c/D0W9G+42lYaV6c+pfgO+zsH3Ru4s5NUUH0=;
 b=dRIhh5VSD0j+vDsQesIfa3jNuRTUj2hhDG1Nd1CrNjrXWXHmbcKB4FEzOc38kLXiZn
 P35bJn935uU0hWBIOzrKhWm8PQy0xuZZPLQveYks/XSGH1opzFX77DACLD4+IPqp9Bs1
 kcLYrwsGuxAMzB7kWnzU/6INpe3Oo7T7rCZbAPN0SjmgfduRy3Oq3DIgb1ChAb+nxsrJ
 spOSMHAQ4y0bGNDmHD8ALEYvoSOGNLq4s3dAr/eYHuXVi1v4wS6pFandn7ehJRQlQmgo
 rXZLoxK0jwSO/Fd7R00J3sMuz2WcwgxrSkD27onhoFZOhUl5QiuERCVSkFFoF/Cv8g1Q
 GTcw==
X-Gm-Message-State: AOJu0YyPXViZtU3tqzVM2k0jUP8THgIgWJVaXPGLwVdb4BUHH6+oUwCH
 MVaVdWDwRUHj0ctWp1kXn1PaDZg0v6HW/Ea9BYVa6aPPFEzNg62YqaC9cSGcJ5cL/yZOgdED2VN
 x
X-Gm-Gg: ASbGnctvYqgRA4/r/477wz6hwiN82y7i2+r8mRzgYnQMLzwUye0TdaHri3hvNFjEBml
 vfx6Ca3cLCTlxSlXdsX5hUZhhw9wVr5X/SqnlYass9L9t1dDAFmK8yZ05XhMXukeMYopY5JK/A4
 6KUakn9Cy6XYtAGmpfQ9AbWmJz5MOZWyI7BpsIB/VfAylFMVNiD81HGU6auZI6aaDIRHkb5zSnB
 Lnw2PUOoQA87yzWbv9+kGkPHlhZI39ze0PU6kdebrr+3bV1a0H7OKe/T8sbSdJx3KU+qgIE8OSb
 +VRIvqVc4RxO5CE1R5ht2F1ffKdkIgM=
X-Google-Smtp-Source: AGHT+IEoVSwNUzl8qPZi3omoUTdty7I609Vw6o3Pl9bf7M6vpfdh9xdYzYC3cU3NpazF4ZsszMDDzQ==
X-Received: by 2002:a05:6a00:4404:b0:71e:e4f:3e58 with SMTP id
 d2e1a72fcca58-72906ac98ebmr1837097b3a.17.1734029710104; 
 Thu, 12 Dec 2024 10:55:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725e9f70dc8sm8283864b3a.64.2024.12.12.10.55.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:55:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/18] system: Remove unnecessary 'exec/translate-all.h'
 include
Date: Thu, 12 Dec 2024 19:53:30 +0100
Message-ID: <20241212185341.2857-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x433.google.com
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

At this point "exec/translate-all.h" only declare
tb_check_watchpoint(), which isn't used by any of
cpu-target.c or system/physmem.c, so remove its
inclusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c     | 1 -
 system/physmem.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 5a7c3290814..4a88f1c6db8 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -41,7 +41,6 @@
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-#include "exec/translate-all.h"
 #include "exec/log.h"
 #include "hw/core/accel-cpu.h"
 #include "trace/trace-root.h"
diff --git a/system/physmem.c b/system/physmem.c
index 93c0ff60eb4..0fa6c37c774 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -61,7 +61,6 @@
 
 #include "qemu/rcu_queue.h"
 #include "qemu/main-loop.h"
-#include "exec/translate-all.h"
 #include "system/replay.h"
 
 #include "exec/memory-internal.h"
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDD4C5DF7E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2as-0001I2-Si; Mon, 17 Aug 2026 15:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1ww2Zo-0006bz-VD
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:58 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1ww2Zm-0006kR-HL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:51 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66b35d2c4edso5393532d50.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786993249; x=1787598049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WM409keD7J89yEAgYdhBWa8aMMqXlnNUvLTfJiZti+8=;
 b=MX4bvP1zTni9Frr4PI+8nAPIwbOsU9E2AEb8dQMNFwjDf3qw1tiMVGNoNnVxoS1bLl
 werseKDFYDmX8A6uSzDD4bH81O0Hl2bB8OMrkr11Qn5hK+FkhGYgbGrNEN7vEYWjJgMg
 bXTyu6AVK6a8F+Lhtzl3/0jQNy+EprYAOfqhyZIVoGQ2z4n4iWbVJcHPvZmjPNvB2rLj
 zLliS3MlVkFls1Pp48Fb0W3C7tp22S8wAIoFbf5RqD18J/Lt0wDAiL8Jm+I3AeYPBwx5
 mxBXb4OyQ8jTWqyY0sRxZDlI70shg1fO3cvJ6EZPUbG0YJgAkR27+jMigza2ZCklNebw
 OdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993249; x=1787598049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WM409keD7J89yEAgYdhBWa8aMMqXlnNUvLTfJiZti+8=;
 b=OsrxnB6UmSy5GCgdfkk0m3iGdLMETXTY7LP1hLuxlZgemfnNqLcz/OKpmCr33t6cHW
 qFWTQ2M4eo+nGWrfw1BbLQFD56uDGIZ4W2Fievjsb2fCvwIXq8hVPYQsmB8ICq9gjKTF
 ajq/GSOkNETadrI9JmcMdAtkF5gLsguSETpHF2x5g0Zl+0FE0IBJZWqLhOv4uubUr3JH
 TWmHHCAstmnp7TgCnpNy0CiT0bzwkiNmQ3k/AWJYc0rjRwuefmMMZT3f0DHjOwHaHZHN
 AcgIeNR+DXGyA/FgB0HQCNMq8hg0ZYW/swhvMedCkUTUS6MH2xGg7VLbZSp+4sFOoTIu
 09yA==
X-Gm-Message-State: AOJu0Yxt8Ck2yXIdtKO/zjKbYc187R9AA/6CXP9ejq8LfyBIh6wUkarq
 6DpZT+5abPANBhQYAhdES6lY7LwNOzEXp+6pUP2dIAQkotoQVW0wX3j+RW7zHaO9kKs=
X-Gm-Gg: AR+sD13R3dC1jG1jVqWfuOWwHVMWx8kd3Yb4A9eLs4ti23XGwSuRRsHtlB9MOiaGnNL
 oZ3AAxiKT4H4VoXeeS/QbzcxNbpMlJinP883DZUBA/FtUOmxiFjhv3Hpc9QSMm4zaDPrOR9klQ/
 NgUadptld78udD72+4nXioJpmEVLgndRWDWS+4t5uUeQTReWy6LSs5ZstWnAy7aRuqPQaT9e4vv
 Br4gPu5J4FrMhtsJcKEeypMkHWVsXtVMlzxxppIq3Om5TkIgRLxQ9fZu71JaOcai2HSKvo4rBdS
 0wuY7aLmN8AjLgPu3UeR0EibkE0aan+67RolgJiLed9qmHeFc8G6m6yxwLPS7Ll885nai3JRIyc
 wMGOTqq2G/Gc9r/NwxN0UlgGMJDv6GQcL61D3xyr9RcxRX1dYMkxZl9BSZH6HvBILIl83FzCf8S
 RwjNf4UJ5I62VjFE728aSMdjgJ/dMzPnVFKNLPw72F7pu4FH4OgwMmOBiSC0xljlkq7ULAhkw=
X-Received: by 2002:a05:690e:4145:b0:669:3fb5:d084 with SMTP id
 956f58d0204a3-66c72be8f18mr9639481d50.24.1786993248797; 
 Mon, 17 Aug 2026 12:00:48 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66cb41e5d05sm1230965d50.7.2026.08.17.12.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:47 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Matt Turner <mattst88@gmail.com>
Subject: [RFC PATCH 2/8] accel/tcg: enlarge the TB jump cache to 64K entries
Date: Mon, 17 Aug 2026 15:00:32 -0400
Message-ID: <20260817190038.580257-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817190038.580257-1-mattst88@gmail.com>
References: <20260817190038.580257-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The per-CPU TB jump cache has held 4096 entries since it was introduced.
That is too small for guests running large programs: an emulated compiler
misses often enough that the fallback qht lookup shows up prominently in
a profile.

Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host. The
compile performs 34.2 billion TB executions, of which 8.4 billion take
the indirect dispatch path.

Sizing curve, on top of the preceding patch, instructions retired and
wall clock:

    12 bits (  64 KiB): 1,563,829,403,943          133.13s
    14 bits ( 256 KiB): 1,493,865,985,972  -4.47%  124.89s  -6.19%
    16 bits (   1 MiB): 1,469,729,281,442  -6.02%  120.97s  -9.13%
    18 bits (   4 MiB): 1,462,262,363,257  -6.49%  120.16s  -9.74%

16 bits is the knee. 18 buys another 0.47% of instructions for four times
the memory, and since instructions retired does not account for the data
cache pressure of a 4 MiB table, that 0.47% is probably not real: the
wall clock difference between 16 and 18 bits is 0.67%, against a
run-to-run spread of the same order.

In a perf profile the mechanism is visible directly: tb_htable_lookup(),
which is where qht_lookup_custom() lands once it is inlined in an LTO
build, falls from 5.73% of samples to 1.52%.

The cost is memory: the cache grows from 64 KiB to 1 MiB per vCPU. That
is easy to justify for a single-vCPU linux-user process and less obvious
for system emulation with many vCPUs, so this may want to be sized by
target or made tunable rather than raised unconditionally.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 accel/tcg/tb-jmp-cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git ./accel/tcg/tb-jmp-cache.h ./accel/tcg/tb-jmp-cache.h
index c3a505e394..268dacd7ba 100644
--- ./accel/tcg/tb-jmp-cache.h
+++ ./accel/tcg/tb-jmp-cache.h
@@ -12,7 +12,7 @@
 #include "qemu/rcu.h"
 #include "exec/cpu-common.h"
 
-#define TB_JMP_CACHE_BITS 12
+#define TB_JMP_CACHE_BITS 16
 #define TB_JMP_CACHE_SIZE (1 << TB_JMP_CACHE_BITS)
 
 /*
-- 
2.54.0



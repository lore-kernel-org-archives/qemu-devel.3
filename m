Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D389FC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSGX-0005pj-NR; Thu, 27 Aug 2026 01:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGS-0005od-Us
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:00 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSGR-0002I8-6D
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:03:00 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66b32bb75beso2652676d50.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806978; x=1788411778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dddZb2vZrpIrHqwA49O0MST0IY6y/BPuLvI5U4ufjcg=;
 b=FoH7vIoRz3/R4+Nu0rNV1SaR/A2/BXmU0tsDUCHXFoOnofXlumrXNx4DjvTUssn2lt
 tmKs/nSOgFbOscSc6LabJlhu1xop7FvUhOLO4XzzZRQSsJ1hFggihvfKYgAmKONJlIOs
 T8FpympBl0DVyAjdJKlwZdnF5yKeEPMt9uPYXjhbymzmASwJobPORyHnfoWvl6Vu0Y1g
 3Pz8favWZOOCjg3TFN0tLMGnviRHoqGk/VcNTFNIzAxPhGOeRpKhLz5Fu88jO+CYYw9Q
 xR4/f4B59E/pvpSm7Vi2W9SuJyxxX02VQtbDxgD81ANnVEq5KEeQezXku2TUDseVd6Gs
 nQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806978; x=1788411778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dddZb2vZrpIrHqwA49O0MST0IY6y/BPuLvI5U4ufjcg=;
 b=FMsgdHjcAKLAQijnunxqj//+RjHxvXxFpsJD23eYSRk0PjTAQraZpZA1ksdPhzAeFh
 DklsMP++Q98bQ6jSb/lsbJ5CenJD2GwfuKOwa9QB4mDvl0fG9ojvMmbNmYYevGreFwVL
 WqLBxIEwOhNLi/WEY4MIBqsGKL2dpsMVzVnYN+nf+3Y/X75z9rHcwE07ur1F+hszokqn
 MgdvRwMly+H0fqsCEHj8i+On03B6xgHQDrggdhFKRSpOL9zdOGHBpzJHimHjH6tytq8m
 CiSvJo67q63pxR0W51NcoD1mA4ilIPBdej5JhGtLdTr5ppG+BNovQVx1v2i6N8jgBJl0
 vILg==
X-Gm-Message-State: AFuF++mjOuM76yaOZdD3JzMc6NdZKouSIjgonzB98Nc+EehQzaVFuBm1
 NRwkTURTwKVO6ijKba1+4+nFnpdTgeCs74W5VT/6DT3AmmMiWQ434tO6iX0PlaUC
X-Gm-Gg: AR+sD13ULDM/qSnjUV6t5abdBbuBzt6fJMr7FDPPX/sijRajOF7LKtP2SRgo01Kk7N9
 iUiF7E67RkmeDP1woUNE4P1iHZOe5cP2t2g8QBpZhoqMMgt1PH+PRjo81pGidTkoW+FmpmxmjZg
 6iGxSiO5XGs+uqRmh2OgdQoLFvhEdSN9sNYbcYlhXMB0vy96fFg9GsRaAx0XHywaPMVkM8dHikg
 eTvNtgsVtypn/SslVhUN2+zWmLIiKPhQbIV/oKR0zuOOuF8O5j8RUkC+9eoOwZwvmHatmWp3e0S
 RQSyUtZwKvjEb6EixGfQdpAIPSmbbOGRUdZgdczNmorY1KKk5/TWvfpDRqo/2PsxhuEVjlYnwzN
 byJVQ6W3NXk7oFZ/fUOZ0NFm+KkOZ1gb6Aw6TSEl261uGQq3jT0fIMmFGqLoBTFih5IZDeyeG2W
 0C8Mjtfm1Oq2PydokLEKLv2Jr8fsD1oxU3wK/db45AoGkFcIWRK11ILieanRtPsB2Xzyufo6Fkw
 6wwv1oEcnXG6ZXoXzZtD+b60ArJ9JyHSPNXv1OD
X-Received: by 2002:a53:d5ca:0:b0:667:f400:e822 with SMTP id
 956f58d0204a3-66d256acceemr4053961d50.3.1787806977905; 
 Wed, 26 Aug 2026 22:02:57 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-85b5bc34f86sm4317827b3.8.2026.08.26.22.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:02:56 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v4 2/9] accel/tcg: enlarge the TB jump cache to 64K entries
Date: Thu, 27 Aug 2026 01:02:34 -0400
Message-ID: <20260827050241.3713332-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=mattst88@gmail.com; helo=mail-yx1-xb131.google.com
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

    12 bits (  64 KiB): 1,562,204,796,597          132.58s
    14 bits ( 256 KiB): 1,493,318,515,396  -4.41%  124.67s  -5.97%
    16 bits (   1 MiB): 1,469,772,951,575  -5.92%  121.04s  -8.71%
    18 bits (   4 MiB): 1,462,309,832,762  -6.39%  119.82s  -9.62%

16 bits is the knee. 18 buys another 0.47% of instructions for four times
the memory. It does show a further 1.01% of wall clock, which is outside
the 0.70% run-to-run spread at 16 bits, so the effect is probably real --
but paying four times the memory for it is a poor trade, and instructions
retired does not account for the data cache pressure of a 4 MiB table.

In a perf profile the mechanism is visible directly: tb_htable_lookup(),
which is where qht_lookup_custom() lands once it is inlined in an LTO
build, falls from 6.10% of samples to 1.66%.

The cost is memory: the cache grows from 64 KiB to 1 MiB, once per
CPUState. In linux-user that is per guest thread rather than per process,
so a threaded guest pays it as many times as it has threads, exactly as
system emulation pays it per vCPU. The allocation is g_new0(), so the
pages are faulted in as the cache is touched and a thread that runs a
small amount of code touches a small part of it, but the address space is
committed either way.

So this may still want to be tunable, or scaled from the number of CPUs,
rather than raised unconditionally. I do not have a threaded workload where
the smaller cache is the better trade, and would welcome one.

v4: Fix the claim that a linux-user process is a single vCPU. The cache is
    per CPUState, and linux-user creates one per guest thread. Pointed out
    by Richard Henderson.

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



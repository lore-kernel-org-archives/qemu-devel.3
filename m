Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BDDC61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1FUS-0000bK-En; Mon, 31 Aug 2026 23:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUP-0000aA-GV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:49 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x1FUN-0004L8-TZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 23:48:49 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-866e57f63a3so4904617b3.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 20:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788234526; x=1788839326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dddZb2vZrpIrHqwA49O0MST0IY6y/BPuLvI5U4ufjcg=;
 b=UQTiKLNu3EYDxM8fq74sUilbEAYkji9QDYicDIEKTuI5N9f1SttlowcTskrCt99ZD+
 ryNzn9xuAny5CjZVtRLE1xMRw8bimkBga4OKDj/cK7kZ7LV8zWng5gK4577gRrDhGNd9
 iPWXE+cPGQTGfog/TCzQJ/FQeACRq4vhzQr5jWF0AtdO1kazbbmaoh3PkAPQtGWJy6Wc
 /Qg1yUjm6XN5dmOzmd6JHQz2X681pRyPFiB3VTSB5/1nUvxzELOPZeql+tHsfgPSUCZc
 WQp5+8VNxSn7oGKj84KbXO2DF2jsQFD0ZRlz+JNh9XEj1gK0jiWCyBsKlx5L4PmLAZMN
 dHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788234526; x=1788839326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dddZb2vZrpIrHqwA49O0MST0IY6y/BPuLvI5U4ufjcg=;
 b=V6NjaiQKn2IdgBhsu/BqkJsjAHsbKaRo/U7cD3Vy3gAN2IB/8JNyxcT/8vQhlpFfcZ
 OWGWnf2eY+YvKAFd4W6Hyr7WyOJLOjmdogeV0KHBjKGmu4KV0raK0Pb7BxTuD5Hb0AcX
 Q069QWfaqKN0StlWxdF+ft/B6OAJkXdUiLUID52+TkIeDrnGT3kEhfiWxBXuiqWQGtzr
 WLdrwg8zX/rXueelAtPz5yKqop/khkClqqf9fmYqi4UqxLljoR1sFhQ1+Y+g3Az/WDZ/
 4PyozSDVjIBOZyvsDYsvkGmVsyUo9904UNVSBIIJXJ/+s8BPsVwDlovwNVMJ9aEfAvZs
 UuyA==
X-Gm-Message-State: AFuF++ms6ybVe6Ul5W8Gw5p2j9AiMoxDBAxivETYm1MFJ7FKs+ZXj0H0
 v1eG+KlHLSHXXro9Y7Rp8nJatmu9J2sDzioj4Pwi6Z80RnojNZcAqQb6ECbKbg==
X-Gm-Gg: AYBFou3aN9ilq3b1fiRvKd0xK45TvLDsE4iSQ0syDTu1BgKFvK4gwzZHknkGmIbuTAS
 ck/2u4fzXxiveI7KqeL1dsc5szCEvHDeU/L3FTpG4JhyEbRYFM2rYrCx+ogonKWtPP1fV6Fg3Mb
 Z06DInUOdbsAjm3HuEP9VfMZ6pvYDqPTJdREdrRq2DbRuFdiX3Vx2krgeyMH/SAS8wKKDRRgu3/
 HvlN6drE1oV2WrgjNUDFqpsqkOn2ycUKD0e+RqAuNo6tKK6FyZBj3x/Y242Rvxf9an7szHMgIoJ
 L/4HLqUXS/Sly8algt2Bc9v0fywjdWCU83OQiQV9JePDEzvpMAYS7jzu5G6s9B5Rk1QSqj5Zn02
 ZZ2Rrm6qkSDePqlC2mrs+LfVIj5YGj4ftFg72yQ9R65avOalk86C4A4tu4UnNbTVKilTaI1vJCc
 VLMj6mugpUIXCL8U2WCCUeZjTM0sDj8UKMMIskOcRDxhEzlZ+rHq/Np1pTUGWWkR3MNmfXEuitE
 WHVjKSAzFKuTrmQg4SMGY9heNrK5y8momCdWaoXFKI3T9Pgu0I=
X-Received: by 2002:a05:690e:801:20b0:66f:812e:5c03 with SMTP id
 956f58d0204a3-66f812e649dmr2264372d50.2.1788234526648; 
 Mon, 31 Aug 2026 20:48:46 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66e4eb56b6dsm7390775d50.7.2026.08.31.20.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 20:48:45 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v5 2/9] accel/tcg: enlarge the TB jump cache to 64K entries
Date: Mon, 31 Aug 2026 23:48:01 -0400
Message-ID: <20260901034808.3524945-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901034808.3524945-1-mattst88@gmail.com>
References: <20260827050241.3713332-1-mattst88@gmail.com>
 <20260901034808.3524945-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112e.google.com
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



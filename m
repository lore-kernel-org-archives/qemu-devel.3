Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5185AC5DF8C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 19:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxr4y-000425-5D; Sat, 22 Aug 2026 15:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr4w-00041c-Uw
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:30 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wxr4v-0005kv-Cf
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 15:08:30 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-836eac5682bso39449467b3.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 12:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787425708; x=1788030508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j3mECKD7SIh7xN5kiEZe0QA6kTy9Z31/NtbGK372goo=;
 b=tOQVW8y1FAkWWd6b4de2d6psUUWZBfyFJN7iiGPoGG3AulobRvjqILhhJFWp3Uijl8
 YG567vdg6OufGaCfjGaYnc0ceyVfJUYBbgi5F+ocUlf0HB3j/RJ429UkprHcioXZ9p8e
 PXm7BlJcOhR11MrQ7nTR1mTAhWm4bHOf+/EQpKwBGvyzoQCILzIWrHsoSv086zEUiaW5
 NwwqNBNz00KFUfeK8vWhbt+Aum5wVaHDMs/aECGgmSLBMZJvus+YbbVmwjfZ7oDJ+rMh
 45RTlBVe4Xw5/GAOOMAaA8tm9Onl5vCW1cdk88PqSbCHyL/OzBgPdDSDGREObh0eMLbv
 Hsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787425708; x=1788030508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j3mECKD7SIh7xN5kiEZe0QA6kTy9Z31/NtbGK372goo=;
 b=n+wSuXcIBB0GoQM85jpw1DC8SihiqOM3n+fjrUGmEvOr6dW8/2apPTOL0kvapSAh6A
 thQzbwre1JEqOcTkVH8xdHcROI+2Oc6R4JaecPWkuJzUERNLvs1KFJNoqD4nMfT57XSt
 BdU8vIDmAhL9r7IEA3ZLiEAdLTrGjBBu7aKu4GLtGibIPgShDHxAIqytKtxl/tvlxdua
 /9p89MN2K7Hd5Xwl4XzCvz217ZjWuF5uLIzSs8PI0PdISFRgKHozTu2x08Ii1u/4KAwB
 NUUCUeG3UQTLqCQLf2znnwVwWYY1coRIv9iFsRYAAYPvYYrzJ22UdBl0n2wWAlJyTK9h
 KR2A==
X-Gm-Message-State: AFuF++l9VJ1JSw4+sY+x0dth+4Imne/3CvZN0NreDeMkTDy051qFzujY
 fJjPdHCpArFDUScSmX8Ogj1Tfnfob4ELaoYfEgKZF5+ekOLf48CsljXD8+6JL3/zZq4=
X-Gm-Gg: AR+sD126tFkm+S3T9b6TFje5MeVxuNtwWDh0TukKQyYxpq7RyY48+LuZ8BrtH4I0XoR
 imAG2pWh+9wkDVWelPPrpuOYEjpTfDuDrT9vervtHQK4Ljy6f303K0BDJtcpXkSwhYb9MBEKMLk
 rQ/pt2jB7JUWjBPVBROpg3RwkkKc61PIMNYkRAokF/u3FH+6t05s+i38BEwsgGs+dhvpzrA83Tw
 jlG1C72MP5mQCLAE9fg1/kumWWCk7ZQ8pM4QPoi/iwuZzr4qhIhkyvv2uz2xR/6j2ZQikw2P23d
 oIITsgZm3Mv5VUaTtWYJ42Gz2t3cpK8aIrB+RbNf2AZKAGFaB9OerQIzziRGyKbR9HvPdbtfEPw
 Z5IflO/tsynOHw/TBJXFToQI8Ed0y+TF+rg+nAZFO92NRuQQpHijyh33dHytE1RVB/W9f6/ZmuK
 oz7X/kLH10VgL3nmMYshAR9NEIf7576/r9XPC9/Br3IL4xOlX+90gIy3coyJzelq3JfUZh9xnOz
 eYGkRe+oECgdba7IWtBU2xjlebAe4Aj7qjS3zD6+4n4wQ==
X-Received: by 2002:a05:690c:e142:10b0:7ef:9fd9:db07 with SMTP id
 00721157ae682-84a199d646bmr39517897b3.12.1787425708068; 
 Sat, 22 Aug 2026 12:08:28 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-84ca62f6ad5sm13393687b3.18.2026.08.22.12.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 12:08:26 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 alex.bennee@linaro.org, zhao1.liu@intel.com,
 Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 2/7] accel/tcg: enlarge the TB jump cache to 64K entries
Date: Sat, 22 Aug 2026 15:08:13 -0400
Message-ID: <20260822190818.1829249-3-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822190818.1829249-1-mattst88@gmail.com>
References: <20260822190818.1829249-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112c.google.com
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



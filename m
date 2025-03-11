Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E7C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJm-0005nP-8S; Tue, 11 Mar 2025 09:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEv-0005tv-4P; Tue, 11 Mar 2025 09:01:46 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEs-0000KV-H5; Tue, 11 Mar 2025 09:01:44 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so9032932a91.0; 
 Tue, 11 Mar 2025 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698099; x=1742302899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JY67tjfgQ34CRjW0ZGaljhvuHtNs5IgoqrFyn/RHWZc=;
 b=AWL+hf0yRuk1bQE/e1HZgJuK21sORynea7DAsLFvOxMum93xxWSccoFQcorcxSHAUy
 92Rm2BFG+3UBnLIsHWa9S09HPS/4mU1YQE1DqcV9+BhWk25UQOu3rAl5Kkrmldvwx3bL
 p+rRZmrhCXN/yGiggW2yZKsoyiQzse3Cvytx6a/nFJp9TWNatWTPOxbfV/WvKuucwTcf
 //oquu5VKTVRDt4yQkhuln5EInEruxefGaAog8wQeIrQG0pACXI6gBdEwGRmgmHLyLlw
 rA8MwWJI5ToXus6y9sb+dfz3n/y3yt8TrTpnFKb+qwrtXwF4CHpcIjBQDoUhqRrHoyUl
 MBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698099; x=1742302899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JY67tjfgQ34CRjW0ZGaljhvuHtNs5IgoqrFyn/RHWZc=;
 b=Hqx273MCUVVNLkd0cVw8Ec088Md4Lh+Xy1ecXAu+IMzI+C1XbyLTjHr1pAFHHSxxDm
 IY13Gou7ByLdNJ4Q0JnZTOQ3N52WCV0elYtucc10lresX/r7Fm35zNEn/hrj0pTALkko
 pkj/Je0XhpRZDdUPl/zom5ftWTyrGr7e/IZ5S+UAAwUQ+4qwFF3bJTsFy8bgW2pL+LbX
 DR6uzU9pHEGi2zCmVNZyLKTxv/KJqQW8Ytc2Gco1swLFPKGZUMVEFEu/zidrUOwYtwsE
 kQmbh4uT0I8K5qwjgrnm0/v33XvAjQpIjME0676nzGi5PWv5eYIZBa+YmjQGw6vnJqlN
 Z+JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyizlIIbA07NwE9lRmQxGdTtbCKe4fdDkiuuEGZJlPlKKHa+9OjqF9kwhp9KZYtoDkjxytK0oIpA==@nongnu.org
X-Gm-Message-State: AOJu0Yyv7Zmic4VTYM8rnn2T7JAaa+SkMPd71UHKLERT3MnuU29ikjtQ
 6oJ8jDN/DB2ICO8e19p9Y4ybHMCsiripcUqmBp36uOiGVmNm7n3giOeuHw==
X-Gm-Gg: ASbGncskEJYZwShg+Huym507yXEWfzug9AiEyW2kurBJkD1UFDpXQzUJfqg0i9JexbE
 nMV99DuT9keTelgHBrriDHybhPfZ0Ab7Ww1DaR1iYDcbcFMthvwyLJ/447WnoMhUttML0VK+3An
 BeAeyuC9mPbxirYTPekM90+TEROGPHWM4Z5EHDmCGWBEg6DA9hu9D9YkqW7x6qDJluWMrVJ1yZw
 +QzR+FygQW40IaH4tUBWjxy2izWUGTxRKTWurRUKAdT2ljipnqg/rFEKPydN4t93Eear0NGzd5K
 HWsg3I1MXAiAFn15AU+iWyvQPFOl792ny/waocEsqYykOWSJwyX6Qh7JvmnPyQ==
X-Google-Smtp-Source: AGHT+IHfbWkjiyhk8kgV3NYQHOuEDsaSJvC+Ced3BjtR/V255+jwgWGx78b0P9eE9vFtHLdputyg9g==
X-Received: by 2002:a17:90b:1a86:b0:2ee:9b09:7d3d with SMTP id
 98e67ed59e1d1-2ff7ce8b60amr24976057a91.19.1741698099460; 
 Tue, 11 Mar 2025 06:01:39 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 63/72] target/ppc: fix timebase register reset state
Date: Tue, 11 Mar 2025 22:57:57 +1000
Message-ID: <20250311125815.903177-64-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

(H)DEC and PURR get reset before icount does, which causes them to be
skewed and not match the init state. This can cause replay to not
match the recorded trace exactly. For DEC and HDEC this is usually not
noticable since they tend to get programmed before affecting the
target machine. PURR has been observed to cause replay bugs when
running Linux.

Fix this by resetting using a time of 0.

Message-ID: <20241219034035.1826173-2-npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 90e3db5cfe..3a80931538 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1123,16 +1123,21 @@ void cpu_ppc_tb_reset(CPUPPCState *env)
         timer_del(tb_env->hdecr_timer);
         ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
         tb_env->hdecr_next = 0;
+        _cpu_ppc_store_hdecr(cpu, 0, 0, 0, 64);
     }
 
     /*
      * There is a bug in Linux 2.4 kernels:
      * if a decrementer exception is pending when it enables msr_ee at startup,
      * it's not ready to handle it...
+     *
+     * On machine reset, this is called before icount is reset, so for
+     * icount-mode, setting TB registers using now == qemu_clock_get_ns()
+     * results in them being garbage after icount is reset. Use an
+     * explicit now == 0 to get a consistent reset state.
      */
-    cpu_ppc_store_decr(env, -1);
-    cpu_ppc_store_hdecr(env, -1);
-    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
+    _cpu_ppc_store_decr(cpu, 0, 0, -1, 64);
+    _cpu_ppc_store_purr(env, 0, 0);
 }
 
 void cpu_ppc_tb_free(CPUPPCState *env)
-- 
2.47.1



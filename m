Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47816C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjfj-0005MH-96; Mon, 11 Mar 2024 13:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjjfa-0004YZ-MH; Mon, 11 Mar 2024 13:42:38 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjjfY-0007Tr-SZ; Mon, 11 Mar 2024 13:42:38 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e64a9df6c3so3792408b3a.3; 
 Mon, 11 Mar 2024 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178955; x=1710783755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDxLWuCdYHq+0UxHzHGZvZ93wYuuHZ500ruO/QvykEw=;
 b=d4hS2BuTrkMMrc2JAmESC6/CAFonk0Zvenlutp5CXGUxBwJtSUJFKYhJXdW49m4eH1
 Sxe+JX0+eSYh5IfOciLsAl1t2Obmz0gsjKcC6w1eIuRhqhaGMnOf9j5rqxWmoxEo832J
 9e6/W2TClAzfeCk66EOiwPvN0MStT3VgJplZZNQhyx6NGlS07iDYWpqGu9nw+qkRa/zo
 Uj6mWpeArMNXZTwriNgCNn0WA7tNoKeHJW+Y35iVCFr0VPOrzAltEYXS7kh0c3bowDV3
 MbFiWlqAIHp4m2HKubD6Br73M4Xk5PuXuPpszI1IF03V3JF4nUyHsfvqonfVmKyZCCiY
 cw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178955; x=1710783755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDxLWuCdYHq+0UxHzHGZvZ93wYuuHZ500ruO/QvykEw=;
 b=reiTlCuYTOoSp3cLT27+EfmaE9aOlFVa1nrT5qh6B9Xfmy6/15Q19Xu12fjToI1B2m
 WcpZDuAWDqkA1X/GkzBpjGwAQPt7LP89PRwNokK/3z5vMZ1+J83DP5tjcjd8+HVPRuGy
 qnEqj5z1GPAyJwKFK5eIsEaWykoRugqKaPOZ7L7GENriHdMB0Zku0NPGn/IYkPlt2MLX
 gLsPQCqQuRO5rgTMDd8KAT4jTky32k9fWYje5gPkT3OIZQRQKKOD5j2sFNbW5JIxo9QQ
 8+71xlglWFCxfpSSSMVdlXKzdA34uRX03k3r077a+gE9yvz3NTLabPMib0fhj9INvKkg
 YijA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh7CWtbwELgXIF7aPNSQYA+vPOf5bBCdFqMPXoJtTp0RvfD40wP5CjgwrBz0FDgGqMNOj+DXlZ3PvmJU2UYMtVn7tQ
X-Gm-Message-State: AOJu0YwE/5nlkQUxM9gSyNv9oClzhTMNtyps23tI8zSggc7OCRyE6uQr
 KQkdoWA+YSnsuLeUhl7ClV/+9Po5cPhlx5tpyfm+5qTbsFMgRGW+cozg3OKQZkI=
X-Google-Smtp-Source: AGHT+IHLaZL2JscYhnGsK2pqMh8r6LSnh3vkWR9vWi0hxg7lKDfVoNfqVjyPzEUxES7b4ytZbGmZ9g==
X-Received: by 2002:a05:6a00:22d2:b0:6e6:800f:9f84 with SMTP id
 f18-20020a056a0022d200b006e6800f9f84mr9211371pfj.11.1710178954731; 
 Mon, 11 Mar 2024 10:42:34 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:42:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-ppc@nongnu.org
Subject: [PATCH v4 22/24] target/ppc: fix timebase register reset state
Date: Tue, 12 Mar 2024 03:40:24 +1000
Message-ID: <20240311174026.2177152-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cc: qemu-ppc@nongnu.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c         | 11 ++++++++---
 target/ppc/machine.c |  4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index fadb8f5239..f22321779e 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1112,16 +1112,21 @@ void cpu_ppc_tb_reset(CPUPPCState *env)
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
+     * On machine reset, in this is called before icount is reset, so
+     * for icount-mode, setting TB registers using now=qemu_clock_get_ns
+     * results in them being skewed when icount does get reset. Use an
+     * explicit 0 to get a consistent reset state.
      */
-    cpu_ppc_store_decr(env, -1);
-    cpu_ppc_store_hdecr(env, -1);
-    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
+    _cpu_ppc_store_decr(cpu, 0, 0, -1, 64);
+    _cpu_ppc_store_purr(env, 0, 0);
 }
 
 void cpu_ppc_tb_free(CPUPPCState *env)
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 203fe28e01..4c4294eafe 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -215,6 +215,8 @@ static int cpu_pre_save(void *opaque)
          * it here.
          */
         env->spr[SPR_DECR] = cpu_ppc_load_decr(env);
+        printf("cpu_ppc_pre_save  TB:0x%016lx\n", cpu_ppc_load_tbl(env));
+        printf("cpu_ppc_pre_save DEC:0x%016lx\n", cpu_ppc_load_decr(env));
     }
 
     return 0;
@@ -333,6 +335,8 @@ static int cpu_post_load(void *opaque, int version_id)
          * triggered types (including HDEC) would need to carry more state.
          */
         cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
+        printf("cpu_ppc_post_ld   TB:0x%016lx\n", cpu_ppc_load_tbl(env));
+        printf("cpu_ppc_post_ld  DEC:0x%016lx\n", cpu_ppc_load_decr(env));
         pmu_mmcr01_updated(env);
     }
 
-- 
2.42.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BFAC87FD3
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 00:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLur-0000JW-Gw; Sat, 02 Aug 2025 19:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoo-0006gz-7k
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:14 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLom-0006Vn-KP
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:13 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-741a5e8fa94so126888a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177951; x=1754782751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8F7bykdU84vRmZk6Tsw4VS33Ms7cDyMlR3YasKxJts=;
 b=FesdFGAB9tGBIVC85akEQV/42L/1VKN6m+KXq66lN5DwS59/P8SZWi6vHX7GXBCNjh
 kgIoJaSBD5BchEthhmNLnLQyxt8pk7II9w8fNWhy9tM7hY1MalqE2ihn4XFaEWu3gEva
 ptDHBGo6pSApRpgfiqXSOiYl3RfyXXN4cy6S2XKkd5/rUEccau1+/T45Q1fh72drHpDz
 iImSp0zJMkElXPW37SMYeFLfVqGSNE8vA/D1segjBU6ewyAZy6Kl/Xi+0y9p9F2o84Ki
 1Qsi7QHa/TR2UDqokd/w3SXCD7L0tkiMdYb5r4TmGNFq1E+Npw+AY9vtaYyLxwUABmhT
 esBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177951; x=1754782751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8F7bykdU84vRmZk6Tsw4VS33Ms7cDyMlR3YasKxJts=;
 b=hIfvbMgAmZOQmzHGQpkTqemLkVy2niFiQjOhOc5TprrNwZFywJxHX8Cb+7zrNArKW7
 F8oTUOZmZGtuMx01O07UiH3WqNJSX/QxY0diQZXtRzR0b4HtuDuA+IPZhs4pynCfxi6J
 eHLET6fV+MjUs9vKp2PfV8+wmxfHDVt6YzzW1jjEFa9Qxs3ebbExuVE+cbkqCU+Ms6NB
 6TTTxiwI0pMFCdUS9bOYXK32/K56VMCwOzNG0DQLCObK20oRqQrQa5PjN+6lgEJ+Uwp8
 2koKJcWYqDBJw7OgLlYdGoROveub6OjRnHPoCpXm/04cKCBhgV3Xr4zjKcUi/Rlh4qgB
 iHcQ==
X-Gm-Message-State: AOJu0YwL+PgGBzv3+zjq0Y+PBkzuoUBxS7npEwnl2MWntawoUWcJH3Ov
 JVHv59Rv7Jw5VOdqfW5LHGjQD9A2f63ZqGcNWBIgNWjkyzP2zzInOZNn7NNtaFGvdBcTpMJhfIT
 ZkVtx2D8=
X-Gm-Gg: ASbGnctuvQ8ddlq8T7nyBvwLEafdLz/e2iceDezLDvasxBCmqJe1B3smc53v2PN7BST
 B0ag9Ihi1QtVwUsLjKV/GwD63YFT0bK4q+/2evAvvET9mYa1VhCo9RMKEXe/GSIIHtEHLuRl54s
 z5gDXg96u+0ifmzdP/9vpPiHhmrlEX0XbOEsyFnJQQ+CLEBUq5divhM8wcyjJ57U6+whAzBTnkf
 T1/Xines9AMzGh6cgraMcC2QmWqC5AI7er2rXUdy6LFkt2tRhg69kAVQWEbqOluXhjpkrkoPyE4
 sDHcyK27pYEEZQSaQ66wVMMDEuto3ceAEejydyWBHbcizn6NYdLza7mj+Dk5wYn+9a0OJY2w2ZH
 uPJo/5L/zY7tj7X/nj/NUrouZuBrwHSvDidZ4pM5glGdPaOfTxEto
X-Google-Smtp-Source: AGHT+IHa9BMw9HS0OAMrYFi0TYiHgavg1XJPlvZn+O6noh9C4jNmWqaRZas8VfBs21o4UKewUl7HDA==
X-Received: by 2002:a05:6808:4f29:b0:401:ea7b:e535 with SMTP id
 5614622812f47-433f030038fmr2709795b6e.22.1754177951427; 
 Sat, 02 Aug 2025 16:39:11 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:39:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 79/85] linux-user/aarch64: Inject SIGSEGV for GCS faults
Date: Sun,  3 Aug 2025 09:29:47 +1000
Message-ID: <20250802232953.413294-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_signal.h | 1 +
 linux-user/aarch64/cpu_loop.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 6f66a50bfd..e509ac1032 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -7,6 +7,7 @@
 
 #define TARGET_SEGV_MTEAERR  8  /* Asynchronous ARM MTE error */
 #define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
+#define TARGET_SEGV_CPERR   10  /* Control protection fault */
 
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 7e9788abfb..00ff51c883 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -89,6 +89,11 @@ static void signal_for_exception(CPUARMState *env, vaddr addr)
         si_code = TARGET_ILL_ILLOPN;
         break;
 
+    case EC_GCS:
+        si_signo = TARGET_SIGSEGV;
+        si_code = TARGET_SEGV_CPERR;
+        break;
+
     case EC_MOP:
         /*
          * FIXME: The kernel fixes up wrong-option exceptions.
-- 
2.43.0



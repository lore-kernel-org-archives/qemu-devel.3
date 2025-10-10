Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22C6CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrN-0001V4-2t; Fri, 10 Oct 2025 09:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqq-00088y-37
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpg-000437-MJ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso16073305e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101605; x=1760706405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ynx2fDtx9E6pqKZG0s1ynkSbFV8ddwZ/T13r0+dF9Q4=;
 b=PuviHQeXYWY05SK/YUUwmi0I3eOuKikXT/BW1f5bLIM9s+Q197Oa1gqANjW9IsNG5s
 SRe+/kWQo1Z8KZgAT+VNioKTHuaD4A8PAyu8AxhFiPWLhR5tOUe9HetZ/9BguToflfjj
 bl9VP0IADDtGAH7Lkor41ro7st4v6zLCvDWayoftUDfPZGDwuu/o4nPponoqH7S5/oS1
 hM+ZDa+dRThfkTfgj8Udn43nOU/rVw2W70uYT/RPzTrATnkc6LXGHsJWAiYjwkqXB5N7
 PVLgTUDd+81aEslvLHc+wcNXvSvkxePu6w+3nBuqkeRWn6VPjVdzLdWZR9u5DC8pVxMl
 KwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101605; x=1760706405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ynx2fDtx9E6pqKZG0s1ynkSbFV8ddwZ/T13r0+dF9Q4=;
 b=v1Kyz/lxo17XD7ED4BPQO55edxSey/AA5mh+o5nHVAFZNn2WY96jYoJaeloKiJFm5U
 ATXbVubzRdZzPjjIH/a6Mb0NTFLClL+jkeD3IImKxJMJLaUry6wC1fTmv73d6Yf3CPnw
 4j7pOOP0ee00kn8Dn+xuQVn4MLRwGd5oCoEUVMuee56NhmbjNKOkk+iQLGkv38p9Ul8Z
 1lbm9bK+0NZOVX035iZe/q5G1D00ph5pv8+1/MFhOISS5fQSm/dmkdXPlllNhhe7g2Al
 8JycgTdeaIUY3hmJthvQ1s1CdY8/apC0C+ev6pOLM07ORf+c9Gg51dVpzvQHNwCsxwHB
 tWgQ==
X-Gm-Message-State: AOJu0YylcW4m454Do7eMTAZ2EtM24LliGcskh1jeqrUk3L1t3NrMdQkh
 wtmJGo4gGqLg/YUbSkNLyaqYs2Ra8uZBuEAjkWBwHfJ95i3RrVAW6b4CLIXuCLsyoNXWXntLJly
 9mkBG
X-Gm-Gg: ASbGncvTx6QAFaUz8V3i9Dn/cYkO1wJyT4qyupp7ktmgj9PVoanbvjRCZxbNxmxs6U2
 gGvRndxEI+tL06x6ehaUtYRw09TDCNdswxxUUefQQ6X9rCMDug0sg4nqHbrIBaIG83KGEO6ANZZ
 RgrsC3FoCnITphQLIaXjTOWuOWDuY4o7tczad+Rq+3yb8abX68fFXKAB0jghdhvBHEmPCj99Dau
 WnwBkhpJ0Nakf+VnPpEg2SU7YTsj/lxUrNQEeFZLpOP2EL7tkpgpY8cu+d0ElpSs28F0i0nJ7+F
 98pW5z5d+Jec7NzUcNTn3MtvtunyOF2jBDjjjGQn9iJeVKiMQzaZShAEia19qx90pVwiCuLW5OD
 /KQvvZ8BIM4Vb/7+2QtJoJNyNSSvbV1iAvtVfG4Iia4wrdqRCiHT2opFR2nZeSQ==
X-Google-Smtp-Source: AGHT+IEKI94yAZIO4W7RoBpW12x4Qw1pD/w4XQbw3IG944Ho7vky0HIGmjb9vz/N3Dxm7xbtobPePw==
X-Received: by 2002:a05:600c:a43:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-46fb32e50fcmr46660415e9.32.1760101604983; 
 Fri, 10 Oct 2025 06:06:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 68/76] linux-user/aarch64: Inject SIGSEGV for GCS faults
Date: Fri, 10 Oct 2025 14:05:19 +0100
Message-ID: <20251010130527.3921602-69-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-69-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/target_signal.h | 1 +
 linux-user/aarch64/cpu_loop.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index 6f66a50bfd2..e509ac10327 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -7,6 +7,7 @@
 
 #define TARGET_SEGV_MTEAERR  8  /* Asynchronous ARM MTE error */
 #define TARGET_SEGV_MTESERR  9  /* Synchronous ARM MTE exception */
+#define TARGET_SEGV_CPERR   10  /* Control protection fault */
 
 #define TARGET_ARCH_HAS_SETUP_FRAME
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 50a4c99535d..7f66a879ea9 100644
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398D8C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 22:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ShX-0002sT-9L; Thu, 03 Apr 2025 18:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0ShE-00024z-Gz
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:06:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0ShA-000438-Tf
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 18:05:59 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3996af42857so1720903f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743717955; x=1744322755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLiC832/142ITmF1Yvgl6ilLfBOuUrOH271pHrSjNR0=;
 b=NvoLT5R8isA25NDIg3hW5UKUZVjZIPzfp4qLrBxwkL50X7FQ5BcD2vnbUuw9PZTzu2
 5HnC//AbfpeDcgkSJIF6IQLx1TdEmi5OhiD8qQD+K94GAvTwi7d4DqgYK7x7qJDUmD9C
 0nTNPJRO0S5rJB18owJ6i3F4TkCQvH03JpDL/EDT2DQP0Mx0HXSXAun12724prlg5SMd
 PmcDDnvuwN4fcxoOJHN+ZcJZFf62Zx6NQHPNW3G+V1YB4Q4xaZSww0ZqPEQ+EP+qb2jD
 z5W3e16sQCeflW2H8Cd6W/TM51qO9TN6BzZFc1NPhEpqySpp6de8+YaFohxcoG+6plxt
 X8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743717955; x=1744322755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLiC832/142ITmF1Yvgl6ilLfBOuUrOH271pHrSjNR0=;
 b=AWSoRsQM8N8Gw70P2rKaR+bRY5xi04rLgKOGjG9puBStcw/ppt4zQ49TIhMvwOVPUI
 knJGiZ7Uo7fYM5mHZbKc/u5siHDcBIPe0IwOoevWMizywZYKm+CXgOzcsD+1OBIzs2Cy
 VikrX7sJrf1qsG4FDQ1PBT3gmFPmRT2lRosaKOHwG5wLSZXY/Mz6mbWcjmOK4QHmENX8
 E74Ko4SlMxDTVSQDfKX2Kb/oukcPv8Fn3CzAZwXsuA1Qdo/8eE25h2wfmUBa1wAY87Be
 XZk3jD2YF33guyZ9R1R8+ghprPyJHmmjvE//lwDPXfdPZz7cFgFpxdvuPVLFEMits4lc
 9b/w==
X-Gm-Message-State: AOJu0Yxg3dOEEZ1lBGNIfUkW1yxpP1NTIoYuCfFiPKa2Cjd+O75EOSlj
 f/baiuVuJGQHPC81z/S+go/wKIosFt+Ez1SdvbcWY4cvCPFZ42I1zRmutPDZxxldfBSGaP5scKw
 0
X-Gm-Gg: ASbGnct8hkGOrQ3g6+v/Gj1tlXpwE4ZWoA8ns0tTHlS4SfgcwgL3RhYuR8aT1jYAh9R
 rrb7MPq4CeZyBsUxh54C1L4HmoYKWp2XB2W1DE72KH/MnCbpx0xecFEKjmK8YRaHZEoD5+fJqNQ
 E8VPAMDZrpm58h5ZtPQ13x5ex1pfmQV1tL14l3W3u3XU5gh2n6xwJSiqJ+QxN+socGab+fGQtnl
 ePcIgmcm9BLnGmD5h2s8TUCsH+lnTv4yi4pqZu5woFUoQTlXQQTN+eyLXChyd5kz9eoAlDczeal
 d6Ylxsb8I59QTVAmOMwgkxB4+VZ4jH8CCMc4MQoxWI5MMxjiOL4I77spZsBoIICQqmq80amMsi7
 z6YSDeth/t3pVay2r9RLLiRRu
X-Google-Smtp-Source: AGHT+IG+cug/dAzyhePydZgG8rvz9J0+0SnG5F9ND7jIrqZoVBLs5JIW2JK4AaMFnjBAMbR6rWbGnA==
X-Received: by 2002:a05:6000:1869:b0:39a:c9ae:a198 with SMTP id
 ffacd0b85a97d-39c2e5f512fmr4586418f8f.1.1743717954850; 
 Thu, 03 Apr 2025 15:05:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226ecdsm2910634f8f.99.2025.04.03.15.05.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 15:05:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH-for-10.1 v3 18/19] tcg: Factor mttcg_init() out
Date: Fri,  4 Apr 2025 00:04:18 +0200
Message-ID: <20250403220420.78937-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403220420.78937-1-philmd@linaro.org>
References: <20250403220420.78937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Keep MTTCG initialization code out of tcg_init_machine().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 50 +++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 15d4e9232ae..267830658ca 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -69,29 +69,8 @@ bool qemu_tcg_mttcg_enabled(void)
     return mttcg_enabled;
 }
 
-#endif /* !CONFIG_USER_ONLY */
-
-static void tcg_accel_instance_init(Object *obj)
+static void mttcg_init(TCGState *s)
 {
-    TCGState *s = TCG_STATE(obj);
-
-    /* If debugging enabled, default "auto on", otherwise off. */
-#if defined(CONFIG_DEBUG_TCG) && !defined(CONFIG_USER_ONLY)
-    s->splitwx_enabled = -1;
-#else
-    s->splitwx_enabled = 0;
-#endif
-}
-
-bool one_insn_per_tb;
-
-static int tcg_init_machine(MachineState *ms)
-{
-    TCGState *s = TCG_STATE(current_accel());
-#ifdef CONFIG_USER_ONLY
-    unsigned max_cpus = 1;
-#else
-    unsigned max_cpus = ms->smp.max_cpus;
 #ifdef TARGET_SUPPORTS_MTTCG
     bool mttcg_supported = true;
 #else
@@ -118,6 +97,33 @@ static int tcg_init_machine(MachineState *ms)
         }
     }
     mttcg_enabled = s->mttcg_enabled;
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
+static void tcg_accel_instance_init(Object *obj)
+{
+    TCGState *s = TCG_STATE(obj);
+
+    /* If debugging enabled, default "auto on", otherwise off. */
+#if defined(CONFIG_DEBUG_TCG) && !defined(CONFIG_USER_ONLY)
+    s->splitwx_enabled = -1;
+#else
+    s->splitwx_enabled = 0;
+#endif
+}
+
+bool one_insn_per_tb;
+
+static int tcg_init_machine(MachineState *ms)
+{
+    TCGState *s = TCG_STATE(current_accel());
+#ifdef CONFIG_USER_ONLY
+    unsigned max_cpus = 1;
+#else
+    unsigned max_cpus = ms->smp.max_cpus;
+
+    mttcg_init(s);
 #endif
 
     tcg_allowed = true;
-- 
2.47.1



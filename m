Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7426DC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0O-0004lc-Rw; Sat, 27 Jan 2024 23:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0M-0004kj-SR
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:50 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0L-0004Ja-CF
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:50 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-290b9f83037so1064998a91.1
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416968; x=1707021768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1cRBtAgGqadhUih0VNs9If35/tfCXiaB3lrOMREblM=;
 b=kYnh0zd0TQiYg0Z6U6BJ80akl4v3ALjHiZGHQlJaeMIVSh3dU6mnQCFmRWQqazty0H
 hvBpeLYTF+aAt778g2KqPSNsYTKW3fIsVVfchUBan7BYxJljeGwPY1recRK2jkarsETM
 q59qVySUNJpny+HiCnWsC1RMEl5YzRM+rsXHJJsOIx3YxI3AVdKBc9jd2q/G+SIVRWa+
 q0IpG2pUkGYH48nAxfUaW/O+X1dEscrRg22t56GkctjRc8eotRl/wbu7jX+gYBtB9fGr
 VbH2rHmXeHV4zjnLniv+bhZ1SAwZUnTz6gqOt63Esv4i7OnUGt9romA511l+Aq8CM0Sj
 3VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416968; x=1707021768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1cRBtAgGqadhUih0VNs9If35/tfCXiaB3lrOMREblM=;
 b=rQ+K0s89PD5SWbD1Htrla7VjJOOvmR5CjRijPGvAIkD19YxIz9nWAkkzaIgxo1Wh0G
 9FjfXLYPrGm8u3MQaZD6uNoNccHpuQEofiV3ZJpTyG6AIenMEKbwvkEDN6jvoW5FumKG
 rJX62uPN21Ao0fvocS40Oo7dq9yX3Sg1rXjDS861lgj+J1ZERtadFkdDWoqHXgkKRqVh
 NMkfjOcobdXr8xtjhICIt5Drw1lXn6aQc8MqVX7wItTEEaB3Ys6xwjpmMcfUV0LRGRfa
 a1HoHXUwEL93fdhN9ixHfv+R5HlWJHhjY6DXOqlYYQ75badGMT/nk6KWnyDFBFiBRJ+Y
 4FYQ==
X-Gm-Message-State: AOJu0YxfsFf65wSUYBGhd5cE/Y3GkZbTc8M0Gj5ACZgG4lmfM2HDr8t3
 Bteb3Tj0CObfzWW4u34KpkVGTXJRtMmtO+/+Oc+7Qmtr5vSi8ZRfRfhC/IouIyXOW7w0p7NmPRo
 kel05tg==
X-Google-Smtp-Source: AGHT+IEijjP8ZPixMaWeIou+bNJAqOExYJCOmhVTN94HZ3VJpWf5ca85o/beBWx4yai3j2f3fsKxWw==
X-Received: by 2002:a17:90b:1e05:b0:28d:afe2:1013 with SMTP id
 pg5-20020a17090b1e0500b0028dafe21013mr2662049pjb.34.1706416968059; 
 Sat, 27 Jan 2024 20:42:48 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 12/33] include/hw/core: Remove i386 conditional on
 fake_user_interrupt
Date: Sun, 28 Jan 2024 14:41:52 +1000
Message-Id: <20240128044213.316480-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Anton Johansson <anjo@rev.ng>

Always include fake_user_interrupt in user-only build, despite
only being used for i386.  This will enable cpu-exec.c to be
compiled only once.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20240119144024.14289-18-anjo@rev.ng>
[rth: Split out of a larger patch; remove TARGET_I386 conditional.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index d6fe55d471..3ed279836f 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -50,7 +50,7 @@ struct TCGCPUOps {
     void (*debug_excp_handler)(CPUState *cpu);
 
 #ifdef NEED_CPU_H
-#if defined(CONFIG_USER_ONLY) && defined(TARGET_I386)
+#ifdef CONFIG_USER_ONLY
     /**
      * @fake_user_interrupt: Callback for 'fake exception' handling.
      *
@@ -58,8 +58,7 @@ struct TCGCPUOps {
      * cpu execution loop (hack for x86 user mode).
      */
     void (*fake_user_interrupt)(CPUState *cpu);
-#endif /* !CONFIG_USER_ONLY || !TARGET_I386 */
-#ifdef CONFIG_USER_ONLY
+
     /**
      * record_sigsegv:
      * @cpu: cpu context
-- 
2.34.1



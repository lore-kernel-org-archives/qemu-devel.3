Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A83D148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdiba-000550-5d; Thu, 08 Jan 2026 00:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibU-00053u-G4
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:36 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibS-0005IG-97
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:36 -0500
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-34ccdcbe520so756209a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850233; x=1768455033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8JFvRyTGsIm37RE+ch+aJE+dWrR4w50VyQUQYaR88k=;
 b=mfo0vti324du4eyeeygBSFsNYPo7QQkhWPr4I/lexUKQFxmDgrGNzZ4hVR7g+GhAU/
 d4OAGEObuyswhO0P5Pv29yaHz9nL32pVdtBS9dkBnx/6o+07rQJk1lJc6qoZRyJG8n6u
 sS0q4BfWiYLh8In6jjvpPw2i/Zyw39dHIy6EQ6dGkufqKCfJcg87t9jRl+jtvi/jvEBC
 bv45kCIOY+uSJarutgfuwn+Ew8fJCKwMdCzHWfZ9G8+Uh19UVVVRnp5V5J/VD1x1vkUv
 kt+HyQf92Te4f+UOWZptqBFe8v0OHW+VbIPsXz1c92CL/YcGVbRvF5keO9DgE0G1d98f
 Iaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850233; x=1768455033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K8JFvRyTGsIm37RE+ch+aJE+dWrR4w50VyQUQYaR88k=;
 b=n84AyKuh3VWishrVc9jxV3SAAQYmql/J7V0DN8jrqweKUoZ2iHabXdLAzcZbCR8xYS
 LAx5fK5adXKsijDQtnmC27qlUVHvhHlMNJJkV+83hQFGhVWjRYeGGCnGHTq7mdDYWQ7E
 /CfB+j/IwOhPo99DJ+5haYOhzxIrOvmzD6otigH2mJ3QM0uOb6eoBUaJGpTdQGlaBsmd
 UoSrSyMMDRBg87EZXpVfMTxHMpk8wA+tHeRUaStLhHjsReUz0w8My0z2wPA4W8Du84k3
 aS/LOOWcWmZUdV+ea2etJqeRGKLtI1OUXZWW2ZRhYwo4WCAxINBESWAyxcrZcIza1K0D
 Ldyw==
X-Gm-Message-State: AOJu0YzvKWkLYJ7Frj8T1eMdtUDO+3px5Lb53/fGq0XADt9GUCJYdVm7
 ZIyVqPZFjtDA8tgf7FJh6/E2+NtXQIfNkCbepuARhCuBYFdS+RcCMl474I64aCYExRrCAv7zIDC
 EpL2rJOeQzw==
X-Gm-Gg: AY/fxX5D8ftbBmEQ04qGBJxaC4DQrdkVcZW6b41+gpB6zR6cP0Tsn313us/GLlmyXcJ
 BcdmvDjPJG2WALzbfsNfoH+CE2LtyKks55VyMYQkhF1zsyrjnPKsHfn8uoYnEXJvTMduVOnyPB9
 pMnkUSeYt/B0gC7HRx9H92nu8u3HyOBpCASqEyrjaVIpiLWsculQOGq9ObWUckNZw9aRab71Quc
 0A6UgxGkqyNbMyE7ARvZrxd8+5mPtrX0AugfbPyyyjKPD1ouAeZktDD6bF7qLQencxfqPzwQCqo
 /zjyn4ClF+Twqcvk+ZaHXVhI1zhZLncFdQcXR8ECAzujV6DLfOMYolB2zFC+7pWip/RNvnFqAeC
 MYNTPdxJBk1FFqi3NVLTzgOUm4tTR5+ye6UlnlJ0sqCHeDh+I8C+UHdaSEqPpSJXNBjF8MLmyrc
 NMcS5XmkKPsWgKWCkIIg==
X-Google-Smtp-Source: AGHT+IFtrim5kmuCa9Zhwv+hzv9FGAf165gRaEBYJq7yv7ZJc6Yn7UBo1TXwglB1Y1AvQxzmWd6lKw==
X-Received: by 2002:a17:90b:2704:b0:34c:718c:5448 with SMTP id
 98e67ed59e1d1-34f5f831c8bmr7970057a91.4.1767850232759; 
 Wed, 07 Jan 2026 21:30:32 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 04/50] bsd-user: Fix __i386__ test for
 TARGET_HAS_STAT_TIME_T_EXT
Date: Thu,  8 Jan 2026 16:29:32 +1100
Message-ID: <20260108053018.626690-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

The target test is TARGET_I386, not __i386__.

Cc: Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 52f84d5dd1..68b7860e30 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -247,7 +247,7 @@ struct target_freebsd11_stat {
     unsigned int:(8 / 2) * (16 - (int)sizeof(struct target_freebsd_timespec));
 } __packed;
 
-#if defined(__i386__)
+#if TARGET_I386
 #define TARGET_HAS_STAT_TIME_T_EXT       1
 #endif
 
-- 
2.43.0



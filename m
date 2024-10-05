Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89C7CFB422
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 23:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxEHW-00069N-8F; Sat, 05 Oct 2024 19:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHU-00068h-8M
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:48 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHS-0004Cj-Nq
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:48 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e0afd945d4so2449978a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 16:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728171225; x=1728776025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+Rj8O/QK6Pa3filkPJ4FZfJms9lNPKqXWSFkDZyfyA=;
 b=qNVyiSfaRi3Y/cYV+SDPZHCAlHBCde4o0ZLjBhvCEIB0OhHrxbVuli7ks+v1F5up/Q
 y/WQSlmElVvnZ4v3dRXpS7e90A0LBfzHz6EkUljbmodOLVHl1ISEaP7yCR23663wfzpN
 fJ9uoTwyj/OWne84tFZkMyxGV49ID5zqdst4fPzMaDIrqswAhdxLXosv1cLYgj9ygpUT
 W/I4aBl5C3n4tzB64d1eMbXhOW7UU5DtdrGql4sTA+M/1dB7pTsaQIlIIsgZaTLBNPI8
 uvxX2qEAmTxsBCnUstqkhEyYraZ6WlNOPXS8FfPffdSMlJwRGwDCloKXSrJPbKqTfi3N
 KWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728171225; x=1728776025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+Rj8O/QK6Pa3filkPJ4FZfJms9lNPKqXWSFkDZyfyA=;
 b=R5jNRAviuyh4zl/fOzKT6Rlfjpqk9eVAFj/XZihplPc9zMlPneQFsXAtseSNFMKvfk
 2HTFU6MFfdPdtoQO0aUl1JPz1E03gDkDunLNOANS/smWjOmlB5nTxM6IcXOT752FN11T
 bm0UmeveQUw8k1mTm/gM08x7Xu6sePThadrucn34yjO9nA+HLuGditQqkzehylE0IaLu
 Dy78vOSkUP7wrTMhrP7pCkd92fmT3jJwNmG3NGE+pAc3ISP9MOsuntB8kPr5UrRufuFa
 IuWCX4xl4Qe0eKRSPG1uX+2m8M8hQ8A/9wOMTQ5SBL9ggpLclXAjkTqF5P2qp39Hl0Wg
 /zSg==
X-Gm-Message-State: AOJu0YxQd01g154fYgFW0r1Gwwo3gdXo4YuFCY7SPP+E1pCo/cvELZib
 4na2bXlAloicXTphXKOSwPtF8sardmMnJ9mCZTxTmDfJvxpKQwSVWJQaBtwCGU2feMh2zatsv2Y
 V
X-Google-Smtp-Source: AGHT+IFGNI/Z26syY85g+h1OOCJphecV161enpewfMn2pQrkHY2i/yZYQ0TggOQMhWb/DW6qTJFCKQ==
X-Received: by 2002:a17:90a:7c01:b0:2d8:cd04:c8f0 with SMTP id
 98e67ed59e1d1-2e1e63bf1b6mr9119509a91.39.1728171225317; 
 Sat, 05 Oct 2024 16:33:45 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b129cc2sm2394600a91.51.2024.10.05.16.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 16:33:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/10] linux-user/flatload: Take mmap_lock in load_flt_binary()
Date: Sat,  5 Oct 2024 16:33:34 -0700
Message-ID: <20241005233343.503426-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005233343.503426-1-richard.henderson@linaro.org>
References: <20241005233343.503426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

load_flt_binary() calls load_flat_file() -> page_set_flags().

page_set_flags() must be called with the mmap_lock held,
otherwise it aborts:

  $ qemu-arm -L stm32/lib/ stm32/bin/busybox
  qemu-arm: ../accel/tcg/user-exec.c:505: page_set_flags: Assertion `have_mmap_lock()' failed.
  Aborted (core dumped)

Fix by taking the lock in load_flt_binary().

Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2525
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240822095045.72643-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/flatload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 04d8138d12..0e4be5bf44 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -487,7 +487,10 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
     stack_len += (bprm->envc + 1) * 4; /* the envp array */
 
 
+    mmap_lock();
     res = load_flat_file(bprm, libinfo, 0, &stack_len);
+    mmap_unlock();
+
     if (is_error(res)) {
             return res;
     }
-- 
2.43.0



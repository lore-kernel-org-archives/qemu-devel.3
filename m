Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9723F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mK9ME2Ha
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLqHN-0001Gm-Kq; Tue, 27 Oct 2026 19:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLqHM-0001Eo-1i
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 19:08:28 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLqHK-0006cC-68
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 19:08:27 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-8439fe796ebso267458a34.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793142504; x=1793747304; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IJIhwwAJ5SzGlSqwxPayI3RZ8IqvJdbV9eWM1K61wVI=;
 b=mK9ME2Hav1g1JmmMQA4KyZcahazzoi9AgC4QnOioJM36wNIAWM7IEAvSakteX00IE2
 SW4BFPE4ByimjzVCBB8/JAIVei7rEq2a/wSfuK+KJhkR2X+D2Tf1eyVHzqXn3syX+jOp
 9YFKI8v3JHFfyOzHpVCbDuLUoRAL/OLXCjihEFxfQP1uFUeJGdKDEcRajR1Up2494irp
 eZ0YbureSlOcafLwJTrUDCsxuySLjpr7FWrX24vozV24P0KbIOhIjl+LStTsw5rZy972
 Pu/HgP71FoupGn9q9JfSOj/tvCzvkjeDXjc+zDBedTzNnY8EqV/2w6vk2gQVTlxl8nXR
 451w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793142504; x=1793747304;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IJIhwwAJ5SzGlSqwxPayI3RZ8IqvJdbV9eWM1K61wVI=;
 b=bHznAcsDkUKmwG230HJe9TByWb1PjkPE9OP3VVTjtZfWgBUfFd8HbeNFOdSIUyN30W
 pIqXn7r/w+l6nLlw/xzScx/K+EVgd5rdkJME7C36KdDYtcoSmoVmNsWuFEMsit9UHt07
 254+5E/WRk+F62EewBU7UA3SZeQWtF8Azc2IyxwPsVGEBbQ40Cga2X6SwYFM4VgOWnNC
 AMk5RtPnAS8CSCY9VQjPxWD/Y+YnW6rTu6OhbClI2a987FveRbEN7/q8myuTHIzKikb8
 +4A6HxLe2wXKRqY0sYt2GeND0DDm+KFTlIIPkxsjN1iDPK65RZAQGJel5VugUM9viawb
 Gq+g==
X-Gm-Message-State: AFq9FYISFRMgr2kTjcyOb0FNAQhEUbyxLvxHsEXY8+zvgfpyub7QXhs3
 qNx5AebYjjjxXo5XrRuaRvtNuuMPhfsD59vVsLGIF4VFJ7BiGvGI65WuYrKTB747SVTNhYvpPPy
 frA+V
X-Gm-Gg: AYBFou3KhSTYqMwYoOw/yAYp6xYRTOq313ECZZzmG4KSirqmscJvjbedRMXFvjT/slW
 0SIQunx3OVcgu0v6HjIEazEMMNQ8nl99KyQmf6h0Q7ZaUE+3qnjWf62GjO7A3GUHpuXkVKcgK8F
 TWEoq3/nL4u/ayU2PbEb++1d+Bnr+NB46tr8FgT7GhPh9/ESmHZW6RW46ORO6TyxOZuNlPfwEzz
 QF7xmrGEKXyFAO+2A5U36drRrO4SdG4eYXgqrkJ4m7hTH6OPl0ZjT8aXjqzEvQlXdnZtwwGyljk
 eQApmqdc3ps1B8QY61+pJWmloqyatvD5MwWv1K0IwbrkkaWm+oBw0thUQyluEMG75dNM64LzNxa
 DTxhrPuYBmkGIW1aM+P2pIWp6ihRY+wQvqsMvDqpiCgqYTKqd/PNEkMaeOLWreYmakQYqqc5caX
 17Q7bK+5DVn1st8of/C3/+gc3lH1t/vIY8qvyYbSsmzq3ORTqhKWMCdCGXpOYEoFaxFtqyfiE+h
 UP/zxEOewEvWi3KNlcpuUZnGyGpadUWBUcaogiuHuCn1mXrEUu6roSl
X-Received: by 2002:a05:6830:8296:b0:85b:c75:dc59 with SMTP id
 46e09a7af769-85b0c75e5e8mr117122a34.29.1793142504489; 
 Tue, 27 Oct 2026 16:08:24 -0700 (PDT)
Received: from stoup ([50.233.235.3]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fc002444sm11965882a34.23.2026.10.27.16.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:08:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] tcg: Adjust NONNULL annotation on *_diff functions
Date: Tue, 27 Oct 2026 18:08:16 -0500
Message-ID: <20261027230816.201808-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In tcg/sparc64 we use tcg_tbrel_diff with NULL as a negative
addend in a relocation.

Fixes: b0b6701a4018 ("tcg: Annotate functions in tcg.h with QEMU_*_NONNULL")
Reported-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 8f409b23b7..3dc26b919d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -881,7 +881,6 @@ static inline TCGLabel *arg_label(TCGArg i)
  * This version relies on GCC's void pointer arithmetic to get the
  * correct result.
  */
-QEMU_ARG_NONNULL
 static inline ptrdiff_t tcg_ptr_byte_diff(const void *a, const void *b)
 {
     return a - b;
@@ -895,7 +894,7 @@ static inline ptrdiff_t tcg_ptr_byte_diff(const void *a, const void *b)
  * Produce a pc-relative difference, from the current code_ptr
  * to the destination address.
  */
-QEMU_ARG_NONNULL
+QEMU_ARG_LIST_NONNULL(1)
 static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
 {
     return tcg_ptr_byte_diff(target, tcg_splitwx_to_rx(s->code_ptr));
@@ -909,7 +908,7 @@ static inline ptrdiff_t tcg_pcrel_diff(TCGContext *s, const void *target)
  * Produce a difference, from the beginning of the current TB code
  * to the destination address.
  */
-QEMU_ARG_NONNULL
+QEMU_ARG_LIST_NONNULL(1)
 static inline ptrdiff_t tcg_tbrel_diff(TCGContext *s, const void *target)
 {
     return tcg_ptr_byte_diff(target, tcg_splitwx_to_rx(s->code_buf));
-- 
2.53.0



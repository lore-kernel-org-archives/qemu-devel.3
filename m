Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE36C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LtA-0003P6-1w; Tue, 07 May 2024 10:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsk-0003BV-41
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:30 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsd-0001MR-MJ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:25 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ee0132a6f3so19265455ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092395; x=1715697195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6IIOegRVX0IRNGiRvdKLFUu17MQmdNwKORAfdJtFaw=;
 b=w1wvSFHG4ykTETQyRuC0EGd/Tz5I8DFt0v3UlPgGhliV/0ECmLa44H0BBLsZ+feegb
 DYnr7l8MR7J1+m5r+WJ0mWlCLe5LE/ZlUMB51Ul7Bw83KqMXrPf6p4DQ7R/+XdwIR0f3
 s5KfusXdMUoHhAo3lwrigHgLmwCk3Apo+/9aV2a5fUG8BGDuvIBnSUSAHl6sJpIiw6tT
 dthfx5PbJNRk7vjxpnns+EIc2w31KmJtbEpTApOMwFuVLrMoETAgnLyIN72MspSeTZpO
 5hXejSFDpddUUZxUWK+f47Qkc5NkOmNEm/FCDqKXaNQOu1yCcTeqyXo+xU+WrZyvIAK/
 gPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092395; x=1715697195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6IIOegRVX0IRNGiRvdKLFUu17MQmdNwKORAfdJtFaw=;
 b=U0RgePzhUx+RTRWBw8UWo4BrS2vhhrIzEky8yBz3N9glE2GFC5Z0OGU+kXcK2Eez1E
 n4DCEbqy0jIr/PdYh279hkD8G9y+3l2rQqbig/tMomzBggP/9GtsZFUoSxc7dEKriWAk
 TDITJg74Hl3Jf2kNzlRERSmzhrlR9vuuMOZZFslCnn3b/No1bjlOG+soQ8K/1wLsvQcH
 VH0PGD2DkiVEHtbLjbA0U0Hv4YLi7hrXAsVYfKVZrDziYqTQViaI6H2er4/N9jlcsTdg
 OgZPahND+qCS3bNzVTxcJPDgRi366j4bqf6SV0z7Npce7KMob2/1tFzPZFt7jAqwPNWc
 Nluw==
X-Gm-Message-State: AOJu0YwMt+oebVkEPohVusZ2k4v2hxlhIDmMFvv+CtEMDyd4KvKsruXQ
 aI6oR14vc8heQ2+/O6WrrjZckVOD33dytpog/dF6eePRKykhbdQbT8WxdVgN9uPCfT6GgV10LPv
 a
X-Google-Smtp-Source: AGHT+IEDQHppY2z0ZOAy0qMx4WOpq/zFMdMd/mlRoZh0GQXYK+CtARNHtfzoKpBc0W3d0bPLWPkqaw==
X-Received: by 2002:a17:903:240a:b0:1e6:40f1:93be with SMTP id
 e10-20020a170903240a00b001e640f193bemr15652254plo.27.1715092395403; 
 Tue, 07 May 2024 07:33:15 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm8690097pll.193.2024.05.07.07.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/9] accel/tcg: Introduce CF_BP_PAGE
Date: Tue,  7 May 2024 07:33:05 -0700
Message-Id: <20240507143309.5528-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507143309.5528-1-richard.henderson@linaro.org>
References: <20240507143309.5528-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Record the fact that we've found a breakpoint on the page
in which a TranslationBlock is running.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translation-block.h | 1 +
 accel/tcg/cpu-exec.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 48211c890a..a6d1af6e9b 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -77,6 +77,7 @@ struct TranslationBlock {
 #define CF_PARALLEL      0x00008000 /* Generate code for a parallel context */
 #define CF_NOIRQ         0x00010000 /* Generate an uninterruptible TB */
 #define CF_PCREL         0x00020000 /* Opcodes in TB are PC-relative */
+#define CF_BP_PAGE       0x00040000 /* Breakpoint present in code page */
 #define CF_CLUSTER_MASK  0xff000000 /* Top 8 bits are cluster ID */
 #define CF_CLUSTER_SHIFT 24
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 225e5fbd3e..6a764f527b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -371,7 +371,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
      * breakpoints are removed.
      */
     if (match_page) {
-        *cflags = (*cflags & ~CF_COUNT_MASK) | CF_NO_GOTO_TB | 1;
+        *cflags = (*cflags & ~CF_COUNT_MASK) | CF_NO_GOTO_TB | CF_BP_PAGE | 1;
     }
     return false;
 }
-- 
2.34.1



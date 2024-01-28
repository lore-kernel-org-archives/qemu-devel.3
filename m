Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1AEC47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx0h-0004q3-7x; Sat, 27 Jan 2024 23:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0f-0004pa-62
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:09 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx0d-0004Mj-I7
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:43:08 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2954b34ddd0so313513a91.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416986; x=1707021786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4bfmq9Mg4HxfU53OW0oPle9hQIH8zXg09YsWAHRVD1c=;
 b=oMOjDl1Ybii2UF44Dm/KozkbX7FzH7gGHCmdhoMEX+qVtm0heOxFuhKKJaI7+9WfnC
 lS72teZ0eoHA3J9gQF5/eI7stMwXmmO8fa5cUAuYgIqM7YSyXA3oGqM6qcL4FUvanL61
 NIgA9b95GszQW2He8pGtxkrYrY6kIHlri8W7+SmSBqzi+p8ys0zK6qa/eLXLKH5Ku7bi
 xI8BI2H0FjYjOqijbi0NppGfkNmFGnlw7+JWt8sI5u5IBp9KwW+Eq7HohP04+lZCLiZ5
 e+ISyNyY+UGV+55fBu5JozAg2ka8GEsromGvzYPSlQ+5PdQVQL05reUub5BdoMuLTXvo
 dfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416986; x=1707021786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bfmq9Mg4HxfU53OW0oPle9hQIH8zXg09YsWAHRVD1c=;
 b=ohVB4dBx5oaGGSXeehQRr2UJG+jQOlQR4pYw9ax2V/rZiKprMZiFqztv6njvhwfaZr
 S1wKbLKX/jU8XmRjKmlSBhNy9hWeP/Ty3qHOsHUQfha0ijSGN6BCTWPG/tedXB2C1zV0
 38OQog4xxn90Ln+zSl9PpbYao9SW/GytZaj2gNpNXVhafqloDZ3/GwrmkgLo2dBGnFGT
 o5QUb1gDxaxsAhZTJT8u0/miuoj9NKXS7CHUY2FrE9v4DYPeXQ9wqhdF3RMB3wbheq/G
 gopRWq6BbKa56gIppjpxN6FUV/ewXk4E6bmbea7EXw4m8wrkYl1HEGbXNVhp/yN4t2S9
 rpxA==
X-Gm-Message-State: AOJu0Yxx2jQBmp1PNxhDsYruxKUT0CaiYkTxEoGiqBjA/GowAz26k96n
 IuyLg50mJTcs/Elviin261UNckMqS2/cC30Qjqdhn1zBIJHOipi97AnPpldZ+89runCSslmkxxx
 SYWKSvA==
X-Google-Smtp-Source: AGHT+IHSxmkYaNVW+tpEbBadq3HejzPPH+5J3zGBjk1wnyNuIc2YhbpnYA07N2z1bjKPMr+aTtLaAg==
X-Received: by 2002:a17:902:b48d:b0:1d7:323e:f362 with SMTP id
 y13-20020a170902b48d00b001d7323ef362mr2525328plr.120.1706416986320; 
 Sat, 27 Jan 2024 20:43:06 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:43:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/33] tcg: Make tb_cflags() usable from target-agnostic code
Date: Sun, 28 Jan 2024 14:41:59 +1000
Message-Id: <20240128044213.316480-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently tb_cflags() is defined in exec-all.h, which is not usable
from target-agnostic code. Move it to translation-block.h, which is.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231212003837.64090-3-iii@linux.ibm.com>
Message-Id: <20240125054631.78867-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h          | 6 ------
 include/exec/translation-block.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index df3d93a2e2..ce36bb10d4 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -459,12 +459,6 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 
 #endif
 
-/* Hide the qatomic_read to make code a little easier on the eyes */
-static inline uint32_t tb_cflags(const TranslationBlock *tb)
-{
-    return qatomic_read(&tb->cflags);
-}
-
 static inline tb_page_addr_t tb_page_addr0(const TranslationBlock *tb)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index e2b26e16da..48211c890a 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -145,4 +145,10 @@ struct TranslationBlock {
 /* The alignment given to TranslationBlock during allocation. */
 #define CODE_GEN_ALIGN  16
 
+/* Hide the qatomic_read to make code a little easier on the eyes */
+static inline uint32_t tb_cflags(const TranslationBlock *tb)
+{
+    return qatomic_read(&tb->cflags);
+}
+
 #endif /* EXEC_TRANSLATION_BLOCK_H */
-- 
2.34.1



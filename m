Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581AFC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBy0-00050G-F1; Fri, 01 Mar 2024 18:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxl-0004u0-Di
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:45 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxj-0004F5-0Q
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:44 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dc75972f25so24446135ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334402; x=1709939202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bGhiDlU0H1FunNKKdUnN7eps2A5T8/N/TZO0RrbQvI=;
 b=NY+IJdWxkIpZk00NtGYSj7nMW/jeCcb9k/FtIhh0zp3+DicMWEW5wgXSRBUovkHM7e
 UtubRaEELxdHSx+y1pSpDNJoP9EVA1GJsG+WVE1SvlCkAmIDT+VhaNF6EiIUtjjSBcw8
 7dOsXWkK4U13DXwBjSojNOfx01oyuIoci8rGBw/MpzM4y4nxz6KTrMtgralv8qccvkGD
 3bKRhmPdSa7CzGNEc5gsmkBc6vvcftJKy3QfsTouLCODsGyZ51oJtYWtf9Rjq5H4SFcC
 O42SRxUkqCXzdFNkOk+ZcR8kP9FVsXGz1wvRQU++PS/NtYWwYuW7n32f6Rz+ltqugTzR
 xNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334402; x=1709939202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bGhiDlU0H1FunNKKdUnN7eps2A5T8/N/TZO0RrbQvI=;
 b=Tvz9fDSmTeWDBwsYPt4EsV18JxxUJgV9S8SeUZuFLCaFtx65ZPLBT5V6wgDnA5LihF
 tcGSF86hZLcwY22pStbfeip4ZCfDh+rKfA0dn/v81Mqh0YxlIv36xSo/3Nv6BDLOy0YB
 kLo+hzex+B9/mCkULgqlXPhSYsJqwK5JNwq7ANAu470V02iW309O4Umm1TZq6yPRH+sY
 0xJSJL67iVOAlw0RLyg6aKonf0TBMK20e/i4mwbAajYC8V7uM7PQ7oJuxo2bvSL9C3JK
 dXxYIg2Gh2wLsDfvYU84O4N9vcHc90Nw87o9ib1B+n9CY/s75Vw5WHnlZYHlo+VahpA7
 7gLQ==
X-Gm-Message-State: AOJu0YwMRDkX5QaRGbi9yr9BDayyiT+bXwY+vt2IS7UAYilZ3a7l0AX2
 5ILMcIwnD7DOa5UgEFid1l7kT88rTpDXogi7al8sRuCNtITmH6zJmHWvinCQL5X31BOverYHgbr
 2
X-Google-Smtp-Source: AGHT+IEsJ4xGUhkPQb5tE2jBfgD870mZNI5oa/1XNAhjYKDZePTzfm77z2n6xE/FkDQVeBA7OgYC7Q==
X-Received: by 2002:a17:902:a508:b0:1dc:5ae8:174c with SMTP id
 s8-20020a170902a50800b001dc5ae8174cmr2517460plq.17.1709334401791; 
 Fri, 01 Mar 2024 15:06:41 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/60] tcg/aarch64: Apple does not align __int128_t in even
 registers
Date: Fri,  1 Mar 2024 13:05:34 -1000
Message-Id: <20240301230619.661008-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From https://developer.apple.com/documentation/xcode/writing-arm64-code-for-apple-platforms

  When passing an argument with 16-byte alignment in integer registers,
  Apple platforms allow the argument to start in an odd-numbered xN
  register. The standard ABI requires it to begin in an even-numbered
  xN register.

Cc: qemu-stable@nongnu.org
Fixes: 5427a9a7604 ("tcg: Add TCG_TARGET_CALL_{RET,ARG}_I128")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2169
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <9fc0c2c7-dd57-459e-aecb-528edb74b4a7@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/aarch64/tcg-target.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index ef5ebe91bd..85d5746e47 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -55,7 +55,11 @@ typedef enum {
 #define TCG_TARGET_CALL_STACK_OFFSET    0
 #define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
 #define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
-#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_EVEN
+#ifdef CONFIG_DARWIN
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
+#else
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
+#endif
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
 #define have_lse    (cpuinfo & CPUINFO_LSE)
-- 
2.34.1



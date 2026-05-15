Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C146DCD4F48
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7R-0000kJ-GP; Fri, 15 May 2026 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7L-0000fN-Vb
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7K-0001ds-5t
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so85610665e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842204; x=1779447004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2eQjTtQcaBQuKg9JnxV2qRTB7mD4XKXUSiOD1gcVDjc=;
 b=TS65p+QH4bbSaIBMYS79QvpLMpSnG7mZWE/iscMvHAq4lNd6KXD55zKUcDBuprsZL8
 hHLAC/dWS0mQivNSvov2z+2z90kYXJcAACzAeVwzssJqpjGnkBDJWcFO/IUEpU9SN7dn
 xX9caIuvplpUyYfiQX+2Awz3LrtQX7w7vF5W6MIqrC6BnjWNQ8+WR2c6+548ABqvb2/d
 OCc3oXsMffaWQesBxD7ektqr/6nJmU/Ip+R9MqW5nei1iMBkxhC6whplEcfFd15BEDGJ
 3MSLvFoq9xrHoH8fIQQGorbFRhIZXAXSE5fwRNUhg4Lfjr/KU7pp3UrecYuXsFVSwWMy
 Z3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842204; x=1779447004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2eQjTtQcaBQuKg9JnxV2qRTB7mD4XKXUSiOD1gcVDjc=;
 b=rQ9jNWyWa7lJsDg8ZH1jSN5jv5eHGEOjebsjVFEx2tuPegv3XHIqeR86isByPtYWc1
 J9sSFjofbGZwuRc+RAAkUJbEmRObfHjONTdf6GzWdz9beH3RC4rU8jYv1xJmGyJJrZWU
 vygGOHfmj2WlmzvoxfMAQBAhF8+bcxFGKkU5sNnwlUINsWbVCu2ImRlENoLhLn0wFsx0
 WE6ke1lZXbCD5QNxi4XNEXTUifRHLn2j6F6Uwg66MXMXcZpPFqQ/bFYePk0o6wi9HaiX
 iNmfjPB61AGrek7g956jL7h0DjDfG46WSLTxO7SY71lFDQmjMnHxH6cmii/ZZdPV66yk
 NB8A==
X-Gm-Message-State: AOJu0YyrBDsJjIHLZ3mGekHtxSUqG3aIYisCHTq4MI5IG/oXPXFlCevC
 oGrBikMhE/6IwwxmpvSHqCJSxwK9pE+IXYUmW8FrJaWkD4x0sZWd7T0SK12auxYghtJJkhCMUc3
 2oKGp
X-Gm-Gg: Acq92OF24SC0FQ0qa7TqyxX7WQrYyKDLLzc5bBmLxo7vRZKeuIfGXon2jiKjgmGtZjZ
 V6An5XLnB+KVAE1qyuQfMcHkJT45mzngtzjaIxg1CBXAUCr62rwQH8PzNX8ChJlu97l0rpT2TIa
 Dj2mwv6GCgWzLC0+0Xgr6VibHxNN4F2K9xXCPLMHQ18TUWnC9s28VFgODV8Ctdd8Irqdx/px/Yc
 pSwC1wJTfx9LPbWILI78DXAoE9zsLWMYHEUnPDuNB3Su3QbsqN6XirnThcIAlzsYhkmvcmLINop
 1KTmP8J278HE1zjd3sYPMlyX+pXdMqp6foGRJ3p1LmCQN9wzKI65nxrOYwUhJzChsRO57zk6CyR
 kxEuqhmDMBOXXqh4nMC+r6Y0J9W2E3R9HdqaA2PEXIUWyTDNpTJ53+wF5rgJXloyqrz/MPb74k2
 nPTXfMQXYiEC/4NVZq+pFvbYwQn+VXDmSmncwc0W5Y8igWbh4khE54QJSBVp0otYN64OodgSXCQ
 9JwuJYdlN3J9WTstR2UfFAOzJ3vXVTceEyH0ehsyg==
X-Received: by 2002:a05:600c:848c:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-48fe60e52c1mr49603905e9.4.1778842204247; 
 Fri, 15 May 2026 03:50:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/23] hw/display/exynos4210_fimd: Use LOG_GUEST_ERROR instead
 of hw_error()
Date: Fri, 15 May 2026 11:49:36 +0100
Message-ID: <20260515104945.4145203-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The exynos4210_fimd device model uses hw_error() in several places
for "the guest set this register field to something out of range";
update to the more modern LOG_GUEST_ERROR.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3405
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260508162013.2751001-4-peter.maydell@linaro.org
---
 hw/display/exynos4210_fimd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 5133623ee2..aa94b29971 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -533,7 +533,8 @@ exynos4210_fimd_palette_format(Exynos4210fimdState *s, int window)
             ((s->wpalcon[1] >> FIMD_WPAL_W4PAL_L_SHT) & FIMD_WPAL_W4PAL_L);
         break;
     default:
-        hw_error("exynos4210.fimd: incorrect window number %d\n", window);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "exynos4210.fimd: incorrect window number %d\n", window);
         ret = 0;
         break;
     }
@@ -757,7 +758,9 @@ exynos4210_fimd_blend_pixel(Exynos4210fimdWindow *w, rgba p_bg, rgba *ret)
             blend_param[i] = FIMD_1_MINUS_COLOR(bg_color);
             break;
         default:
-            hw_error("exynos4210.fimd: blend equation coef illegal value\n");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "exynos4210.fimd: blend equation coef illegal value\n");
+            blend_param[i] = 0;
             break;
         }
     }
-- 
2.43.0



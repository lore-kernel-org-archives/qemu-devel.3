Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AD9C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWFH-0001xj-4p; Wed, 13 Mar 2024 17:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWFE-0001mN-UK
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWFB-0007qn-Td
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-413e61525c2so2147735e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365676; x=1710970476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7QKVDun1Xxye4YCDRYj878clGJ9eUXYpBHFwgHMFxg=;
 b=TKAmqZdUJEE11Gb9yaIlSEm4NaD7oZG32wKRl5W1CQHRlGha2U7T9Z3D6BwZf0Pb4f
 6VOgWnPVvrpVMy0cBsQ/WCAYv9nYbNPyCZCNYHGqhJTOfW/ifu4LG9jaMCTxz1aFkA4Z
 k32TU0FT/z/fjauyQPp3EUmWWa5t0Z/7/wM6mWfvmcwOrniTBNZhsPKpKG4LYf48Omy0
 9oByzrUyO/pedJbcJMaQWbM944Ey11e5LfehGQ9L5A2B/+9D6tETV4vVku3GNqHOURRW
 TFG5QDkgh9X0mMtovxNv5s1fVbJm2rHkuL0fFy8LsZfCRgNhQ7rv6Iuk6aJtETMzBDxi
 kxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365676; x=1710970476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7QKVDun1Xxye4YCDRYj878clGJ9eUXYpBHFwgHMFxg=;
 b=pAqmOsVC/dpxBBgRbujWLLL50kQllbd7otXRGp5sxD/fzfAZZ33CiJgs5EhClr68Lf
 i2goWalN2H+uUYSFf3SK8Rc8x2yqKA5QNKj6oXu34WUFb9xq0uT5jYxqTnnzHJ74LBbZ
 n8nrq+meQ38qLfrBiglNYAkxiXJmWB6KAjOYhTQzmjTgCH3XW5a4KDpd30zP3XYtj+/4
 EGSoUdliTonGyjTZr4kaDRqVnDlV8NO27/Gud0yw5Fm4pXy+jOHUXG+aXYAtAWp0DGjd
 cRzmYcVpezcc2wLUr3TplS5EM8C7sF8bjR9ooy0p9q9InPHrIA5Cj4D6fBrdE56dYc8B
 ke8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXARqFTSkCCjAYV9hTEsG46XL4ucUKGf0Pg3JBZfxOnhwyfqXzKx165/tFHYlaNxeUNfuhh2KEhOellYH3UJGCPByfshQ8=
X-Gm-Message-State: AOJu0Yx7aSlcGFPcLfiN/n93HtTi+WgvX7RHWpSBPZ2BYwDIgJx1EJJd
 Y2wlG5a9l9kOIwa3PdBNxQHix73YF7i2bV0SqT9S4Wb50ZR6w/33sHlh9fMhhFw=
X-Google-Smtp-Source: AGHT+IH+ZSfYe+WoJZbIdFQiDUgcZwW8XQH2GNDaXxO8FguIU0KbDmRBhsozRcnnrjcGuPo1GGFMHw==
X-Received: by 2002:adf:f905:0:b0:33e:78f7:51f7 with SMTP id
 b5-20020adff905000000b0033e78f751f7mr2510415wrr.56.1710365676126; 
 Wed, 13 Mar 2024 14:34:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c444600b00412f83e0c11sm3478553wmn.22.2024.03.13.14.34.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:34:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.0? 08/12] accel/tcg/tb-maint: Add comments around system
 emulation
Date: Wed, 13 Mar 2024 22:33:35 +0100
Message-ID: <20240313213339.82071-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-maint.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index da39a43bd8..2fef7db9e1 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -147,7 +147,8 @@ static PageForEachNext foreach_tb_next(PageForEachNext tb,
     return NULL;
 }
 
-#else
+#else /* !CONFIG_USER_ONLY */
+
 /*
  * In system mode we want L1_MAP to be based on ram offsets.
  */
@@ -1088,7 +1089,7 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
     }
     return false;
 }
-#else
+#else /* !CONFIG_USER_ONLY */
 /*
  * @p must be non-NULL.
  * Call with all @pages locked.
@@ -1226,4 +1227,4 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
     page_collection_unlock(pages);
 }
 
-#endif /* CONFIG_USER_ONLY */
+#endif /* !CONFIG_USER_ONLY */
-- 
2.41.0



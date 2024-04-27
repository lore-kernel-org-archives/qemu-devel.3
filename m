Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B7AC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kRI-00036R-LB; Sat, 27 Apr 2024 11:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRG-00035n-Vj
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRF-0005W3-9e
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:10 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34c8f392172so583805f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233487; x=1714838287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/oe4rUpvk7kXuFveLVq55aFq0Uh1L1ccHbCyLJn5f0=;
 b=eT1Y0RpLLjIavrW0+p8xcwZzFA+9MlACNB3jyO5jqKZdhBCvDC91Xd1XcT+Rj4lA13
 I10oupqo3oXOqPfKoylPWj2s10NfUbLFtULIkkSqeHJc0HMW8QEFXLDxplA3XWQc0NdT
 irfBrVC0DFFfZRN9dbCMNykgvzSR4GafzHuiHSH/oRS09EdlX9bSFP1jIBIrMa5sQwdR
 3Yk2rSbb8jQm3F7JnqpWS1vYunyFCV/sjGwKKYq4YvPt27BgyChSzUDZzDuem+JH5r30
 qzdDAp2YEkyURJRmjbQiW0f+S6rRd29VmbK2l7hUkPSq9YHrwWvN8tqhpgqvO2GowHzp
 TDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233487; x=1714838287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/oe4rUpvk7kXuFveLVq55aFq0Uh1L1ccHbCyLJn5f0=;
 b=KhTmzoALzCeGDKe0Imeo8Ff1UeDsIDp4MexV6Xx33ajemSQ5gCkoIlXQ2orCsyFXy4
 wkGWO47zZzEa434WTIz5i1grq4g8fWHWJ+zbVZ2HB+H57MBnXl/oHErmyI+r3BrJIoYg
 1c1TevUz8bSopgyCOGMYfisWlwTQ2Pi6a2NrdWy4OPsPY9g4iAnkPX1XM3YyUkmdlcno
 KZoZM1f9/xggQCqSNwGFgzLj3wSFPR7puhsRAuJOnfA/LC/5wmjLzLqdRkr+DwoHZN8k
 cR9L/W5SG5s0UCJ1pOVGOCILwZzU61eqwyZzQwkRhS5HEzDOZMrHT0LFsX2uiiMvEqQg
 vc0g==
X-Gm-Message-State: AOJu0YwQ2bFgBuUJ6a0V7HKiybr+N6ADCDdtGRDNdIiBbkgqqIhXL3jP
 iwBl8B4TtS6cLIj/f46L2LM3f3LeW3fM4L1OHemQjDxiPOufe81nJseMau8SgSk+JJQfXOHqZfn
 yIzk=
X-Google-Smtp-Source: AGHT+IHET1Jm/2YL0NdvP24uJDZxacot4NdFqwb6nksZJKW5GoTcp1r9CTW5OSgzihz+gP1hW3AXBQ==
X-Received: by 2002:adf:e44d:0:b0:349:7f87:fa20 with SMTP id
 t13-20020adfe44d000000b003497f87fa20mr4993613wrm.59.1714233487509; 
 Sat, 27 Apr 2024 08:58:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 t18-20020a5d6912000000b0034997769ae4sm25188729wru.15.2024.04.27.08.58.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:58:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 09/14] exec/cpu: Restrict user-specific page definitions
Date: Sat, 27 Apr 2024 17:57:09 +0200
Message-ID: <20240427155714.53669-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

User-specific PAGE definitions shouldn't be used on system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/page-prot-common.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/exec/page-prot-common.h b/include/exec/page-prot-common.h
index 2722ded724..b1fce45c15 100644
--- a/include/exec/page-prot-common.h
+++ b/include/exec/page-prot-common.h
@@ -17,16 +17,22 @@
 /*
  * Original state of the write flag (used when tracking self-modifying code)
  */
+#if defined(CONFIG_USER_ONLY)
 #define PAGE_WRITE_ORG 0x0010
+#endif
 /*
  * Invalidate the TLB entry immediately, helpful for s390x
  * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs()
  */
 #define PAGE_WRITE_INV 0x0020
 /* For use with page_set_flags: page is being replaced; target_data cleared. */
+#if defined(CONFIG_USER_ONLY)
 #define PAGE_RESET     0x0040
+#endif
 /* For linux-user, indicates that the page is MAP_ANON. */
+#if defined(CONFIG_USER_ONLY)
 #define PAGE_ANON      0x0080
+#endif
 
 /* Target-specific bits that will be used via page_get_flags().  */
 #define PAGE_TARGET_1  0x0200
@@ -36,6 +42,8 @@
  * For linux-user, indicates that the page is mapped with the same semantics
  * in both guest and host.
  */
+#if defined(CONFIG_USER_ONLY)
 #define PAGE_PASSTHROUGH 0x0800
+#endif
 
 #endif
-- 
2.41.0



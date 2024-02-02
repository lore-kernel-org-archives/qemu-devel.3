Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CF8C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmT5-0002o4-HQ; Fri, 02 Feb 2024 00:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmT1-0002UZ-UX
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:59 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmT0-00027i-2a
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:59 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ddfb0dac4dso1335739b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853117; x=1707457917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=enqyHM/qlHAKrvGyjKOBiar72kS5zHVgEoJYNNdlxDQ=;
 b=JXxiM572DonvC6pArZSCdO9ss2EdgaYX4Oby+VV0dfvqEkVm74IoH7KEh9wVPoS9j/
 7Ekb5ehy+NIntaYl09LA8WnbT+uQQjKoT2sjz8Q9yvqkykYqEhmV/N9h0oHgO87k3gyz
 NDvWwtsxYJN7a95y6cZYbQiXjVpOxwguSFm1/qNv0JvNXZRJSZIrtc13YwQc38QZvQax
 UEW46OzHK0117lMBDVlcZaa/UDvDX4qfl8bS8RxiWchOp4SYsBwfrZieBW5Kj3PghsOR
 AWckP7Yv6Td27j2FHeb/Rfh3HwxJFlR51gFRse025uqcB3T/4aOosIwuHbVza5CuVTsd
 drMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853117; x=1707457917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=enqyHM/qlHAKrvGyjKOBiar72kS5zHVgEoJYNNdlxDQ=;
 b=oYVWoxCVT3Vgx9bFJCWG8ztqbAil6U4w/xIa/CmZ+ll7EM/TjwQII8bgDIeaOkFBDT
 8HxPf/npsUlryTf9jG8sTCDXVHnyuQasv8ZUQSECs72TPyeFCviIms4s1EV9xtMPdXWG
 5fqzQVme/rKhVCMMR2EbrYrN34XGl8d/EyZQNBT5CDfkwgQr5yJWwZr6gJgjda5LRsr2
 WV8R7tXyPn/ONgQaPO3Z+lEMcS91OqhU5Wsj2/ZzfzkDXPKQnDHfOSEv1Wd5DbRg9P5+
 ku94uDf94Opo0/O5gnxTthc6cI2d4clLDlP7/xBtMxkkG54GAtscWN0aC4fiUFdn6OCA
 dbjQ==
X-Gm-Message-State: AOJu0Yz61p1Zg8ZECz5gTo9AUBLAE08oRAOaTdOozH776ujZWpwuPraC
 pFG4B8aFHb9MLCTrkmfZZqYqqBgfFAQPOB4p4ufya2wbX9PL6LINJxvYPS/i0Eq5zRK5zZ9TnlR
 nAV4=
X-Google-Smtp-Source: AGHT+IGWY2ek1R607E9nacg77ESi2+0UNpHrIvzu5L90MyGCd9oJ+mgsclxBBOx/BbeEkuRARZ3ZEg==
X-Received: by 2002:a05:6a00:23cb:b0:6db:d978:9047 with SMTP id
 g11-20020a056a0023cb00b006dbd9789047mr8634401pfc.1.1706853116815; 
 Thu, 01 Feb 2024 21:51:56 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVK//GlkMYx7LaQShTPiCXe/LPvnqxRn4jv2adJfhkGn5Na3Hy/8W+8VmaHIFaGC/PfEs492ETnUQkJMi9N5Pt/HVo2
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 35/57] tcg/loongarch64: Set vector registers call clobbered
Date: Fri,  2 Feb 2024 15:50:14 +1000
Message-Id: <20240202055036.684176-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Because there are more call clobbered registers than
call saved registers, we begin with all registers as
call clobbered and then reset those that are saved.

This was missed when we introduced the LSX support.

Cc: qemu-stable@nongnu.org
Fixes: 16288ded944 ("tcg/loongarch64: Lower basic tcg vec ops to LSX")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2136
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240201233414.500588-1-richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index bab0a173a3..dcf0205458 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2327,7 +2327,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
     tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
 
-    tcg_target_call_clobber_regs = ALL_GENERAL_REGS;
+    tcg_target_call_clobber_regs = ALL_GENERAL_REGS | ALL_VECTOR_REGS;
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S0);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S1);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S2);
-- 
2.34.1



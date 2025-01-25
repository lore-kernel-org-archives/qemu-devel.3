Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746D2C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbigD-0004RN-H7; Sat, 25 Jan 2025 11:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbig6-0004PC-On
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:35 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbig5-0000jg-5e
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:34 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso2715271f8f.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821190; x=1738425990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeHo9c/VM1KSl2EsYkHb7Xalf2iVdr+8YiL4SXj3SsQ=;
 b=d5mAn1bKVEbkwp4kPu97gdgc74BRWXSef3QQnCmvgEngAhxr/pCeEyCjd1a54faaWy
 JHRELIqKowjE0f0ELqF1JqVpb0nbkdbwVGAr37yXybAPIDpgrBDboU/3z7TRzKtZ7jBu
 4JbI9AMwt45iYVbjv5o4JxnmzCDFqPB75b+6z95hHgtst2T+5S7VVrLhaRD2hiaW8s3F
 SNnytA/mbz421QcE4aeRzYZXtMe75M15TYI0s0yvMfhzpvAyn1iPWnDRENiWyKTd4MpU
 OxVISO9H4slJSLIO57+mi8an8MFG2OeaksQ7qCOG2GDy6J5FXCl6o6Kn7aLFuFXqiKyG
 TDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821190; x=1738425990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeHo9c/VM1KSl2EsYkHb7Xalf2iVdr+8YiL4SXj3SsQ=;
 b=eNUTGbaAQ/SzLyyXhdse5QKc6dUOQ4NoyQ1xZ97VgJbdxH/BHdBI3Rtfnci5Fly2mE
 CgBqsvE6M88JFWKjBoq2g5IJReBcbRt5oxROwPpJ8thwvTI/EJUhRN7bvy07LDLvspAp
 /ktJ34oboy8kTTHqeBB6MP6IdRz6CMRhLmnjvM8s+3HLzrGfOe2mTgBiNUc9Qz/8/pVc
 t9zdLYoYduZfdiwppUKI6ROhcVfzMtdbwGbLc2Rze8dBabJtFaCDpq9+qW8s4ThH5Hfa
 5e+/tp5r64mcBUjdIsRKvolN8IlZfOJPn0N0CI8Xv9YIADO+LbuSA2qHATzSJD5qCGlw
 3Y0g==
X-Gm-Message-State: AOJu0YxrEk3kdKeFlarz7YduZQdErHJb7fBhTNaOEV9sYGFLuCUtuZfw
 yYGKEIW7EXaQCo3c/vZspjOw+1/3gJ9EOS3gZeyxLzWGI/f/a0P9iufmWijLNGcRSjtEQiwrRs7
 bP04=
X-Gm-Gg: ASbGncuKxzvlxsvet1HDZTP01uf7zDMzs/OYZl2uRKLXEZGtzg0bOzuIq1VDoknvcQP
 WVZgTf8u5TF07TMrBNncpL0zp6A8amGMB9YvrbE1LYQye6U0qASgAmDS7h9OQFOVg98qYK+LQ+9
 FKT72RITONiaUW4QV83h6JJ0sqKsrMk5LwCya//kSCoXOUQuW5hPwYSQdesS7MVzJs6ltqz0xjp
 4Gd+6RfjR4F75HTIL2uotpkWr6Dn/VUUZRVp2qm8AADnPndxN9qA6HORNP/fmmWnT6mcH9hPUwQ
 W11OLmMqQaxsrcZkkvvDp29jetO7AeW8mTyJkRaP0Nh1uFiXJS3m9vxnjFMr
X-Google-Smtp-Source: AGHT+IEWAWGMObMnhOy9NH+yqwA5mYdR+SJNhSUGwMdFUBsUKZBnMzeyVQ/Wktf899o39eK9KZHclA==
X-Received: by 2002:a5d:5848:0:b0:385:f527:be6d with SMTP id
 ffacd0b85a97d-38bf57b7fb2mr30390174f8f.36.1737821190451; 
 Sat, 25 Jan 2025 08:06:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764b7sm5980460f8f.10.2025.01.25.08.06.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 07/24] target/hexagon: Remove CPUClass:has_work() handler
Date: Sat, 25 Jan 2025 17:05:35 +0100
Message-ID: <20250125160552.20546-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Remove as unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 0b7fc98f6ce..f77e305d611 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -262,11 +262,6 @@ static void hexagon_cpu_synchronize_from_tb(CPUState *cs,
     cpu_env(cs)->gpr[HEX_REG_PC] = tb->pc;
 }
 
-static bool hexagon_cpu_has_work(CPUState *cs)
-{
-    return true;
-}
-
 static void hexagon_restore_state_to_opc(CPUState *cs,
                                          const TranslationBlock *tb,
                                          const uint64_t *data)
@@ -345,7 +340,6 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = hexagon_cpu_class_by_name;
-    cc->has_work = hexagon_cpu_has_work;
     cc->dump_state = hexagon_dump_state;
     cc->set_pc = hexagon_cpu_set_pc;
     cc->get_pc = hexagon_cpu_get_pc;
-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3919CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Muz-0007I1-RY; Thu, 16 Oct 2025 08:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuL-0006Ub-49
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuD-0008Ce-29
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so7343495e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616978; x=1761221778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7UKHAS8G3ZrAzCZMNdX6EEOMmZQOYpQG8SP7xCscufU=;
 b=ABYxshljxdVIgFC7Ls03Ni4UFCR6JPrJpxpfGQ2DIO6lOU0uH7wTBA9Q+Oq0yYp7Z1
 mbpOHwE4ucVHeKoL0dBLFkc2BwOpDf0kBsmTPwTMKV8jvSKyAvE6buo0nZj/UL+inM4c
 pDad0A/Tz+bVMGKFDZ6JspCOe2XH/BtTz3LtsisQKNQBI//pev8zsjATSWNhaDNnfKa8
 8yTBoiNAJC/8qgfLLrVe1wDoH66mZQgwsGERGQHhv7gFdEqgM96dv8+VceclIEGff0qd
 /c6oqpJvl+AsS/oBI77Bum0OdCbKS+X9w2yWGQAdN3623rZFSS/MtKMXKyvfHK3YFB2C
 EzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616978; x=1761221778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7UKHAS8G3ZrAzCZMNdX6EEOMmZQOYpQG8SP7xCscufU=;
 b=O50K6Ls7PqU9bWFWIorev8fVA51emvb9Xeg6dpnTvecaMoCs+MHHve6wiobmRBzr4P
 6ocfrPJgdsARPGbpM+gwRyHmFnctBGGMf20WZtGbI9elsAe1qAvxART6d2j3v2SLwPbY
 sEi7ow+SKZtrfS1bDFBBZym0BFdcDRp5M0RwcncptQRz9rxVDYESCo2AFMGyuM7CZ6Tw
 ecX3Lwvfn72Wg8GIXon4ZL9wnzDztd2U9GFPCTZ0zc0ZmzcuxtEugeVzCowLTwGVfaz/
 m9bR9Rrd9NYeDX7bC33xYjamKDGrEKOQAx9xvE0KrJlO4nfN/HSmaaqXkBVOOonV/8UF
 stdw==
X-Gm-Message-State: AOJu0YwOHEwYgqBN9nBtpp0SYlSXSoIhcdGnWxVPWwPnrXvDHSqciIRR
 6IassotVFL23lXwQ7BHNjcrJsPrNUea9Y/1/iXaaoOwy4mJfM+wOeSXuJQDY11mTVtSbkqR46ND
 igzGHXPk=
X-Gm-Gg: ASbGnct3AqQLz9rNslax4tExzPlYX3qxx6VrqjQ2GdbW4kM8wfXggbsRY5anKAjO4eB
 xM1oe01+BYWyM4MUkNCJQrgvYTUbhNRnHGP3C0rbIORlLIsR6ctICznPVeln9ZNa8BiQhisg+x+
 eyezLqU2fnv1ChPy60Fh2tkrn5tVGnyHGPAem+VX0UlAzarMMttcx6zC1Nwu5XxYRCuYpcSMQfk
 flgs17HWRS4XVZvtVxrpAnh72W4gc07cO3KZXuczx7aANQVqDp94FvAAKfTX/DEW+D2Ty4Y2hJR
 86PmXlIgKA3r3GYMxYtqWNMTgMDkN+jSK074aRuAJUWC9u90cXXdymhFEjRcz9y8taJfWR7koFS
 bmzDhHq7UsiuVQaxAu8LprIDXhdAZliu0+Yr/vdrvPVaenDAv4pFid1z3XZc0JruNu6yiTufjXs
 ZqbEfUT1xqElaC7nXLillHGwEwwZs0SU8PsCS/O0Ogcky7cL2A1UnTf2GsJYcfTJPE
X-Google-Smtp-Source: AGHT+IFt6C+zwyzPShvnuC49Ztd0jqmUWQKg2GJtb05JXGxuZKdKRz/ksbwGgjPz7Y9IHYrp3Hfscg==
X-Received: by 2002:a05:600c:6383:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-46fa9a8b48dmr254022525e9.6.1760616978076; 
 Thu, 16 Oct 2025 05:16:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cdb9d4dsm19822795e9.5.2025.10.16.05.16.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/75] target/hppa: Conceal MO_TE within do_store()
Date: Thu, 16 Oct 2025 14:14:25 +0200
Message-ID: <20251016121532.14042-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009101040.18378-7-philmd@linaro.org>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4680d826345..3f78bb2a76a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1739,7 +1739,7 @@ static bool do_store(DisasContext *ctx, unsigned rt, unsigned rb,
                      int modify, MemOp mop)
 {
     nullify_over(ctx);
-    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, mop);
+    do_store_64(ctx, load_gpr(ctx, rt), rb, 0, 0, disp, sp, modify, MO_TE | mop);
     return nullify_end(ctx);
 }
 
@@ -3313,7 +3313,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
     if (!ctx->is_pa20 && a->size > MO_32) {
         return gen_illegal(ctx);
     }
-    return do_store(ctx, a->t, a->b, a->disp, a->sp, a->m, a->size | MO_TE);
+    return do_store(ctx, a->t, a->b, a->disp, a->sp, a->m, a->size);
 }
 
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
-- 
2.51.0



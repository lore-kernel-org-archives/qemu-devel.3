Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37194C4829E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 02:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZiQW-0004if-Sp; Mon, 12 Feb 2024 21:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZiQV-0004iM-ME
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 21:21:39 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZiQU-0007yZ-6E
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 21:21:39 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e0507eb60cso2461295b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 18:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707790895; x=1708395695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BzYkBIWK10dkyqgOm0oclP6Z4Ek0OOCRcVEVAcYHx/A=;
 b=nOuQDXx5nNg+AdATNPPrBAswNVVoolbD1iiPJDFLoiycllK0DtHDV0RWZdFSK8XOkp
 s5HPWn18rSpKBUzG+4nYYQZcikFs/xwNRFSqL8YWmK63um0aqqKGqcnyCE/26ATShTw0
 Nwwgmy4UTsh5iJRuW+0NL5Cts3hArsd0zjiGrBG0/dk2EIdq25OxM7l7Dujde/+/sTYw
 iRBR0HCCpvFR42x4dChQRy+rO4W6FzM48NRQyFhY/iRb8nqaJmOFB2hXjrvWY9SOONIl
 yrMyq9B0l/jqg3dJcs0OwVZTMBVC+6FGCttzWnf6eDL7twfPYF45ptHp8v7qkhI4RNTX
 XyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707790895; x=1708395695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BzYkBIWK10dkyqgOm0oclP6Z4Ek0OOCRcVEVAcYHx/A=;
 b=rzX+qWgZTx0EjCHWAsnBqmwugQqH+uCLCgTx4Tk+NAb2OHF2HHitYsuI2W3VoyXxJF
 EO+x8w3HMoAqrN0WY57l1zsukEU39+k6muJhMy9iWSehZbmpp/uHmZJRAWXDma9zDOU4
 /ebhj1DnrCglG81iK2s6eRd1eQob8xb02gIwBbbVyjP1zZBLQkSFUefBJCUw4B4FEU0Y
 C3+qjEe3ZJx60pCFpO4hQ4zZlKRdoKD2KPeLutSNj+NNySVMoCUL5QUvJrtMm1FBWxPm
 OPVanN3AW1i9Dg8sB3arAiV4b6pvF9hpK1L7EQQJAm19Ewi/yJFQqFHl2UGG3BGnOfPW
 puBQ==
X-Gm-Message-State: AOJu0YyE1ioL1IpuTFaJqg/asQ50AiFbQj2RVh+p5UdDJZoz9vq2JQcB
 QrEmLrNNw7NY6nhoNmyiGEU5Xa+MhOKOmfVukGSxXh0wPuZ7tHGt/Ix0HgDfcQbIEubX0U1RNRV
 Z
X-Google-Smtp-Source: AGHT+IGmLu0X+kl8C/TeIx+qrbgLd6j3P+suwU7yXhDsfS6na7RcybVXgoXKM3iRke87F1+Z4ojJoA==
X-Received: by 2002:a05:6a00:1398:b0:6e0:a3ff:2079 with SMTP id
 t24-20020a056a00139800b006e0a3ff2079mr12848914pfg.20.1707790894698; 
 Mon, 12 Feb 2024 18:21:34 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 e26-20020a63745a000000b005dc26144d96sm1144354pgn.75.2024.02.12.18.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 18:21:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] tcg: Increase width of temp_subindex
Date: Mon, 12 Feb 2024 16:21:32 -1000
Message-Id: <20240213022132.116383-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

We need values 0-3 for TCG_TYPE_I128 on 32-bit hosts.

Cc: qemu-stable@nongnu.org
Fixes: 43eef72f4109 ("tcg: Add temp allocation for TCGv_i128")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2159
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

I feel certain that I made this change back when I introduced TCGv_i128.
I imagine that something went wrong with a rebase and it got lost.
Worse, we don't use temp_subindex often, and we usually handle i128
this value correctly.  It took a quirk of register allocation ordering
to make an invalid value in temp_subindex lead to a crash.

---
 include/tcg/tcg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index daf2a5bf9e..451f3fec41 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -412,7 +412,7 @@ typedef struct TCGTemp {
     unsigned int mem_coherent:1;
     unsigned int mem_allocated:1;
     unsigned int temp_allocated:1;
-    unsigned int temp_subindex:1;
+    unsigned int temp_subindex:2;
 
     int64_t val;
     struct TCGTemp *mem_base;
-- 
2.34.1



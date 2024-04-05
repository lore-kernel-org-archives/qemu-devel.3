Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F38C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgl5-0005y3-Ea; Fri, 05 Apr 2024 06:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl2-0005xU-BE
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:16 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgkx-0004Yq-88
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:16 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so832996b3a.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312708; x=1712917508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aA46PcSFh0E670CdL7fmcUflkfJ8vHcNPNbv93pOSl8=;
 b=M6F8QNT91bgsjpx8/H9g2aOoXr/88c4MU0myPftqFQaNVu0LyvVxXz2R+59x7GvFbN
 w8PQjY5jlB5t4Yxd8wnoM20PtHFi2p8/lB0IxrFoKEOz2eUJuz4YopBqHpL371eGSUvz
 UPB56xi/AUPTNm0VN9TLlGlag51uPfPbM9hQCdyl80A3Ke8wQJ6SX0E+yT5fWYvAarDq
 7btqcWLwt7vAU9I/6HerKzTzQu2u3WpZeB9Uk6mOC3ccSzxM7mRO3zyeuTQcupLR6s/6
 YOSLZ4Rm7Op6kd5/U3FeS58WiVnnYspEraGK2UgylcMGmOO615CWuMZAo34aAXmsnnBQ
 b16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312708; x=1712917508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aA46PcSFh0E670CdL7fmcUflkfJ8vHcNPNbv93pOSl8=;
 b=N0pJD3ll2+9qY2oMDip7li7QWFCeu5HSPoFq5jzG+zOmVqEAx2881/Slk+yLgveXlx
 A5nhousTyUmSsqLUsIHR3UneUJryEToWVNNJrk4TD33KqbpmDA31D/JdiRPm1G0ad1gX
 /9hjFO+9/fP5OeqYO6jR7Y21rVesuKwqtLuG9Okt8c4obIJxCDRXAJBzAc80GVp+OK2T
 CZ18tkEGd3hVr+rBEEBELvRpaqbnEPWtgvsoinWv1xkifqx7FSTfOe/DRProeA2SYBxI
 d2CMDuSDu+sIYR4ROGC55JhbTLv9gn3iZRBuzEGD4FnUNv9jdyYNoZ8TC8ViwmDUPwUg
 6EuA==
X-Gm-Message-State: AOJu0YxBqA9/l2ZURfLXFiwrdDlPkO8qifaHti/NJJDamcxOeMAhnbMI
 MZv/uRYb1w0ySTj00xdW24ZQ/76lN9/1fCb9dnhPl0KwTlaEoQIGHRfaS7bPLQEtECjxTGrlJRA
 x
X-Google-Smtp-Source: AGHT+IEqQv/QFPeaWomRW1SEKgy2Mja7GCnrnmezDj3CzABT1+CZfbcVQr4fAU0eGU2qTesK4+gsTw==
X-Received: by 2002:a05:6a21:99a1:b0:1a7:3b62:4e98 with SMTP id
 ve33-20020a056a2199a100b001a73b624e98mr1767483pzb.12.1712312708580; 
 Fri, 05 Apr 2024 03:25:08 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/32] accel/tcg: Cap the translation block when we encounter
 mmio
Date: Fri,  5 Apr 2024 00:24:32 -1000
Message-Id: <20240405102459.462551-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Do not allow translation to proceed beyond one insn with mmio,
as we will not be caching the TranslationBlock.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 42beb1c9b7..438b6d4cba 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -236,6 +236,8 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
 
     /* Use slow path if first page is MMIO. */
     if (unlikely(tb_page_addr0(tb) == -1)) {
+        /* We capped translation with first page MMIO in tb_gen_code. */
+        tcg_debug_assert(db->max_insns == 1);
         return false;
     }
 
@@ -284,6 +286,8 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
         if (unlikely(new_page1 == -1)) {
             tb_unlock_pages(tb);
             tb_set_page_addr0(tb, -1);
+            /* Require that this be the final insn. */
+            db->max_insns = db->num_insns;
             return false;
         }
 
-- 
2.34.1



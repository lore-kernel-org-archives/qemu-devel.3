Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA555606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=M13iuGYe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWC-0006FG-45; Sun, 25 Oct 2026 03:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVu-00069y-TV
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVt-0003fr-I2
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so22895135e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912768; x=1793517568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i+b03T2OQccC6mXaO5uMTtO+4kYYidvSbv1dT5bKI3g=;
 b=M13iuGYeKtgftZqn7cE24EALIWrSBw1ta3+ovjTijdGsmkWIKKzJDFOixTyS8o2V5v
 E1KJy7Rcf6moedzPTIsF9ijW3HJNG+Z2dvI1rVUSE3DrQ5Waor5NBispchq9NWG2rrFA
 kL4TBaHUzZd/I6guBoYyHn+O29bGOyOExCkUo09GZ2Rlhd+e5eQuES2trLcVURzRdr2u
 T2UzQjhh2Oa9Y8NkR5ST7hrVTns5iUdEsYuchHUESZecV54527VgUTXLROTIP9dY9r9j
 6/ShcDSg6XqKrOZHUmlTndxP9nZj1En+9G+w8xGxk/OOkB0lUn0Mty9qSUN9YtLAVNcy
 zfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912768; x=1793517568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i+b03T2OQccC6mXaO5uMTtO+4kYYidvSbv1dT5bKI3g=;
 b=Y5dRW6ui6QaKEIO3UMesu5LhQeoCZvyp/sOadfvcgWqS6BFhQ3tQ6Bm8XP8qKWA3aV
 8SeD9P/2AxzyVkaPXdczfiWQJwHh5AWWa+7Luw55yfA3p3Xv+MxKImMUmv7GJVIjWcHF
 DeQc2/Ww6AH2jzkWrn1Q8WAGbOavU2+C2Cr5ToUh2TbLMCY9O/0xSfIUjtMVQhHoY5UV
 rOjO4wK5oYSqlypgVjOb5z6oYhPhYF+3lVhgl0taYFnaGHt0rNUqgqanMjji0NcxSw+4
 Za2R5N1HFI/QM2BlLCcDZ+zaKxErLoTabW6q7yigEKCkb6YlssVt8VQ3bNnXQNxx7UFD
 g3hw==
X-Gm-Message-State: AFq9FYIKoSn468AqUEHIgmIrE1mr8aiQygFiIT6NG5x34lGrlzmix9LI
 LzN7l6gyOz4OFJqNM+9JGDsD9B5KS4qThj9F0iryOvaxAcjd8941QBtxQhosd7dHF+DAwZ8PpiP
 aKUMWPmM=
X-Gm-Gg: AYBFou0nu1xxeRa2oTGYkJ77I5TUZ8xw8cW7Vs+xRZhtEf8jawgGOJeXIaFSIFxMvd5
 lDXqXlH/tJdCyCaRocKps+d2UWTgVljZLddYc8Twl5Abk027PYdwgA9H8dAvdpFw3peWjte6gSY
 V7VC8nEFAaFoxBUpwDWyh5b5YZ6q7FfQvSg/AMza56LKveT1ZUPqCJJvzbVauTfXPlStzUnXWnQ
 qyrd7WBLI3yfyDI+q3vReHag41AkseeY9IyDNABWMev0WSPRcYhKfPIxxsyCH3D2XXm3YLUN/Fv
 TJLk1jCBE6P2tN2Esxgqc1cGUtuyepRzZRH0dKjWVoDW/mmrT+z4JPW9ssmIHyFEgcJMxu+lMav
 QETcMyFC4x12VbKuuEisA9GRMF2kxHLm2HLLZKgNJBkVtGxOlpVuY+hSfu2/EEdTaAZfnJigkvh
 xBShQ8fjcuJdEpdbHgaj90TbbZVULUxMHSGFDx6ZK5+J4g63Mp1I9gfJ8HifuFh5oIn3bgXO5f5
 RsVdIFO4jRwJnt9WE9NUvpGyVGWOMuOa1z3LyKvsN1hnnKb/lr2nFYDsQ==
X-Received: by 2002:a05:600c:870f:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4a35ac9d1cdmr56220405e9.17.1792912768049; 
 Sun, 25 Oct 2026 00:19:28 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 006/100] tcg: Enforce sign-extension for TCG_TYPE_I32 in
 tcg_constant_internal
Date: Sun, 25 Oct 2026 08:17:41 +0100
Message-ID: <20261025071915.1123867-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prepare for more direct uses of tcg_constant_internal, where
canonicalization of 32-bit constants is not already assured.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c3fdcfbe68..1cd6d41d31 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2257,6 +2257,10 @@ TCGTemp *tcg_constant_internal(TCGType type, int64_t val)
         s->const_table[type] = h;
     }
 
+    if (type == TCG_TYPE_I32) {
+        val = (int32_t)val;
+    }
+
     ts = g_hash_table_lookup(h, &val);
     if (ts == NULL) {
         ts = tcg_temp_alloc(s);
-- 
2.53.0



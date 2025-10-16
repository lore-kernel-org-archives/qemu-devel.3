Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB3ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mwj-0002hC-O9; Thu, 16 Oct 2025 08:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwD-0001yA-9t
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mw1-0008Qd-HB
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so5260685e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617093; x=1761221893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QKlPI3ov2zKDjg+H+lRfVRTIAPBQ97moXk/w8EreFfk=;
 b=mZDDvl8tU+ituIW3RxBf7lRhVAg5zX/2XMJuS1c9mt/5sw8njbZ+5EtI/Z2AKTkwkn
 pU6SFeYes8FmBddnQmVmFK68FhY8uMrDVJFZPOipXnLQHP/4e8GEXAASJvDA/ZvVtlWn
 rXGU4Z98dzv9AZ+TrCSDABtuZNWihjA7jXj97eNGh40N0cU2+pB1wc/x1cBYqKyFfaV6
 la1YraJedbG8TcWE6mzzifnkptuDPXFihypT4HBUpn0rgaOOA2U+RulXW/pFTJz7gvlZ
 hwRoCLLmr8nujA6hRBQNEyhTzZ4UHY5p2wMJfymVDaDlRmaOYyQgy5BkAJWRUSbKsGMn
 AjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617093; x=1761221893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKlPI3ov2zKDjg+H+lRfVRTIAPBQ97moXk/w8EreFfk=;
 b=OzCT0zsHtwGA+x+TXs0kSR3Pk1XWRjfl0DCm1ADkcw1JJj4I3X8jnUZnloTI7pqDBh
 x4HB0E+VmkGR6L9Yk+RZUA4G4F5byhoTPIWOlj4CmB1JlipwVc8q/9GgAhWAy0WAZlcj
 2rMbg7RVfVcw6FIFLWmTS4wQfVALZ2d1BQU/g9biK1gbV5eUfxsyBPao1q/eOGXASYSA
 t9uKf30zJyraiWUVBNgbbwJyqy6fZiZAkcLixpfS975n2Nm1K7cX8YPdx6g7H/pUD9V0
 Ooe8qnczJmbsEmUGzk5TEcep89/ZXVkQww2tpZpapSyM2KuTBYOTEYU0tIO8UwtL3YfA
 a4kw==
X-Gm-Message-State: AOJu0YzFVn4BOkJmiFm+iSKrMFrERWq6vvhxmJMPE5SnhHFxfiqJ12ca
 OKrqmzo/3LR8bkWKR/K3jh9cQShkjzd9Ikzpc1CIVcOQN3dzYSi07BxNpcY/uM3UtyvWklS96nT
 i+Ir97kk=
X-Gm-Gg: ASbGncu2dv+eH1A0Z+Gl10e/s3xrLY2g7stbDF9AwGzRLsBbm60PEyopE6eKNIGzVGF
 2QUTTBdO9sKMAZUsN230RmBQ/HSKqUvX0MZ/8OcsSSJpYnbCBNrW6wCsRer2RKtFKvVzlAgsoMg
 GdGf0ZYb1XJt8YxPBaa9IsFTGOp63dW7ZpaiNmEYtPFu9lUNb8WdMdge2kzB8WnFqLkClLA9j8o
 Q1cByWVde6ammr/Js59wG1cEP6TGAqxOytH4WcxQRQRhCHTxOpmMIYPchZTFZ9EbCaTHsM1tZzC
 hNqj4XUHzna+n8omQ+3Lp7J4WH5TMg/sv9T8WfCGf9WgFznI+Tuk4jGbTGxNnU/RQpK6lXlbWaH
 InG+2UVn7b1zQ1W9/1zJIXnW3zw7F/UW52xmWB7YrL88/8hI3kOU1pDNa116vHpGp8t55DOe2Wj
 reNwx/L1HNPcDsy1JAWINgNnhoVCQQY3Vx/IaN5nrq8Kd5y6BuIx3/uRpF5xcjQiZChZpFLs7Tq
 8c=
X-Google-Smtp-Source: AGHT+IGwG89WEEDM648cuyGyUjjjEQw/QnL8SdfBr5orXxwXhqYBt1racytbALbyGzHj37c0NHOzGw==
X-Received: by 2002:a05:600c:c4a8:b0:46e:4921:9443 with SMTP id
 5b1f17b1804b1-46fa9b1b277mr249264025e9.37.1760617092675; 
 Thu, 16 Oct 2025 05:18:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47114461debsm26833445e9.18.2025.10.16.05.18.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/75] target/openrisc: Conceal MO_TE within do_load()
Date: Thu, 16 Oct 2025 14:14:50 +0200
Message-ID: <20251016121532.14042-35-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
Message-Id: <20251010070702.51484-9-philmd@linaro.org>
---
 target/openrisc/translate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 52d51313f77..a6ba1747eca 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -632,6 +632,8 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 {
     TCGv ea;
 
+    mop |= MO_TE;
+
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
@@ -640,13 +642,13 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 
 static bool trans_l_lwz(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_UL);
+    do_load(dc, a, MO_UL);
     return true;
 }
 
 static bool trans_l_lws(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_SL);
+    do_load(dc, a, MO_SL);
     return true;
 }
 
@@ -664,13 +666,13 @@ static bool trans_l_lbs(DisasContext *dc, arg_load *a)
 
 static bool trans_l_lhz(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_UW);
+    do_load(dc, a, MO_UW);
     return true;
 }
 
 static bool trans_l_lhs(DisasContext *dc, arg_load *a)
 {
-    do_load(dc, a, MO_TE | MO_SW);
+    do_load(dc, a, MO_SW);
     return true;
 }
 
-- 
2.51.0



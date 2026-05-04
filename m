Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588AECD343A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJslG-0003q5-Dc; Mon, 04 May 2026 08:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJslA-0003pE-Lq
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:50:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJsl8-0005Fw-0J
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:50:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso35706515e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777899048; x=1778503848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyCerkevd5fLusxemDhNp9DXuzTkC5/vVdAFKcTSRn8=;
 b=YfElmShbeEHzUAGDwCWrmY/XWBsf80fA44MjBdIaXrOzlkJWfNuM3iEZ1ZwnXGakdj
 DbWlMYAlmM0pfJpXgt0GtGX8czNl3hb08BFGNDei4beQ7KF2Tkuh0vahCIOh5IynyfQX
 5l0lSkQuxM2cCIYi6oS3MOz7XXAq2vOK4alPkpMOsSV66RZG3j1t6GwdXa6FDP78eHvB
 Yk+/NIbnmBHdUoH+yeUzS2mYT/E0q/L3BzGe0ggTISE6L1AADq7lPOA7YTbbcTZjzWlh
 dQSg+JkakXyCvXrU2F31G8qWsxC767sYdoNiAv+LRgs8jGQoV61B4U5rr5CKUIhNxoI/
 mE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777899048; x=1778503848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hyCerkevd5fLusxemDhNp9DXuzTkC5/vVdAFKcTSRn8=;
 b=KPIqSyOe6Gndiid3qVptUIsW1IjzCyIlyHC++IVoe3+Owy0TJEbA8bQjnIXV/edj1i
 fTv8ecDzEQC5b4QiSfal37HdS+CLFcuG26aQXW6Cl8l+xwsTzJ4aG44BR9WdotoNP/wV
 gNtZD17LsfznH6kNRU38PObYPM4HWQeAbnGFt9XyP08k41+eUsZ2r8VHm+CXplOYRdk7
 +YNArp6BsQqGrFZFVjjBhKPwrjiFY/jxMHlxK24AGtuSvKffyvNIUfTHLJrlFj+ySSjK
 wX1XNB3KkM7CgBV0cwqW3+LUvH+dB1OT/l6j8qBhjjPOdIe8fbNcV+V8lVdFjIpOghST
 0qtg==
X-Gm-Message-State: AOJu0YyTlSunMXaEThFJHSFmJ676AY9fTo4/49Iofp5lkCpUrwWAMNHH
 LIoOOs8gFj1IYS/ARMAerruC6yBnED8EB46q1lSUJicod9jmIPlUjr2D7/Ay9ezYWCHNgALO8lr
 TU1s2om0=
X-Gm-Gg: AeBDiestk6B1MP/YdH1FoNnsdABpbsM9ZDxAtsHINIwm8K9CYCJDwSHepa6JpPss0ji
 4A7t7/7XmZbo/uTkyGY3wbuXtwk7vA2EdfqY7Li+UQvQuPlTeU2Yb5rLHQ1UXo1+Z+/LiblPKDQ
 P0JjY1cu6DKVzRTkPaC/m10hd6Vr7c1Tw1EDK2kfffiobCjH2e88UFgjYyg6c40bP1QfCn2pmkb
 /7o9odeKYTqmLrRHlel8KDFTX/4rnFNKh5MOvY4i1Nx/BbhrYM7078VfrULjWitDLmtdcCSKje+
 ewcvfNYckI+dl/i1/PRa6nG3KwQtHlj+JGUPzj/FhezEg48NH4T5OczSqEmf5idlBsTIIYCDcje
 LqsRJ3JoCgbImS2dnob/2ujwpCws32hfBpxZNSdvATqV2Q79W9fPjGRjccuKyti6fR7OpbyGA9a
 olA1V9yiY6e1byuGrLCS7PzjvLMJQjfKUlePnOT5x3tuOd+GTNoHG6cy+rCsu+LL8+zI//1Kx7C
 czX5DhJjZs=
X-Received: by 2002:a05:600c:a30e:b0:48a:557e:6b4f with SMTP id
 5b1f17b1804b1-48a9866e918mr130775865e9.23.1777899047708; 
 Mon, 04 May 2026 05:50:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8feb0cbfsm116444505e9.2.2026.05.04.05.50.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 May 2026 05:50:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] docs/devel/tcg-ops: List more vector opcodes
Date: Mon,  4 May 2026 14:50:30 +0200
Message-ID: <20260504125032.35465-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504125032.35465-1-philmd@linaro.org>
References: <20260504125032.35465-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Few logical and arithmetic vector opcodes are missing, list them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/tcg-ops.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index c417ebe65a8..56c0b0bd3de 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -816,10 +816,16 @@ specifies the length of the element (if applicable) in log2 8-bit units.
 
    * - and_vec *v0*, *v1*, *v2*
 
+       nand_vec *v0*, *v1*, *v2*
+
        or_vec *v0*, *v1*, *v2*
 
+       nor_vec *v0*, *v1*, *v2*
+
        xor_vec *v0*, *v1*, *v2*
 
+       eqv_vec *v0*, *v1*, *v2*
+
        andc_vec *v0*, *v1*, *v2*
 
        orc_vec *v0*, *v1*, *v2*
@@ -852,6 +858,8 @@ specifies the length of the element (if applicable) in log2 8-bit units.
 
        sars_vec *v0*, *v1*, *s2*
 
+       rotls_vec *v0*, *v1*, *s2*
+
      - | Similarly for logical and arithmetic right shift, and left rotate.
 
    * - shlv_vec *v0*, *v1*, *v2*
-- 
2.53.0



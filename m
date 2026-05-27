Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB9BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBak-00013Z-JI; Wed, 27 May 2026 06:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBaJ-0000kJ-Gf
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:34:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBaI-0001YY-22
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:59 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so7333207f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779878036; x=1780482836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oSxUUOnjiAxfT93OaoyxUXEHMBW0TB4q/jHVjnYZEBE=;
 b=pcRG/uP5u00zEm8jlzOriMtZCMw9GLv9Q65CeG+FmzGIDgRb6QwgwC4ot+qmVq9DEC
 VJ7l7+ernBPjVy/VBtLNTYu9ZN/u3yhpI4rc/530GpQr6IYZODtEYDPBO13Z8McVLyWd
 DZVCoOp0q3z5DHGcKgIx/0TSWETj23YPKWjA0Gz6756hKlALIodQwTAsZ5FVThwg+XQb
 Tc1LLkCLrtYv5wat1CxLbLlWUBAyJviHLU4J3SegjVgHRJeFWWDaxJKgv75AnnXYMlwE
 9GBJ0KRBsfhOkVWKqtV0UvmgyLBWsYEtzO6KKZKSTTXyTAB7cvjSI9S50jDgm1MJ4oyI
 i3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779878036; x=1780482836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oSxUUOnjiAxfT93OaoyxUXEHMBW0TB4q/jHVjnYZEBE=;
 b=nNJI6inPJd//9ErJ/o+KNO2fOANLMZ1LZfvpOTrjHIALX+8LSEdrYFqHjGjtcu3kWv
 5WXruqLdsiZo7JT+0hRET5P2sEGDUP0fT5uTLazLVrErxPlrkpTgRDa53SqV0w6ZfbaE
 ZeAfY6Nt4JFmjbNpCUeIQ7z6CHZoz+8phz76CfY2KbNDB1fyJiDd9pij6tnRmSOJ670q
 ynQC2LqJqRlSgyKXDpOl3y6SgemWKqf4TdF7qC1yHgtAOJFJUyu6OqAs8+qBMQE4SdZU
 ikHcREN/VID2oqo3J7CyzAxK5fWwSF2JpRc5ne+h3jxPiCLTwPzV55OaN2B3HiFkxGuT
 zaVQ==
X-Gm-Message-State: AOJu0YyPmixqVUV/faSM2XeNTMHREsZNxbSc28REtXgudmuNGDPXTVZ6
 jThuGCC5ryGuXibSO4hHQGrcEROGBqEzbUd85AtQsBjRLdEt2oMkpEeFIEnVwMvXpL7AEsZHgFa
 UPV2lmbdyig==
X-Gm-Gg: Acq92OHODee5RmODxi8H9lDKcr2VWspIYBBZETlhB/QBOj99jdOyaevK7TAJ/e/GDzL
 dRPptj4znleCpzFTDIKlUpKGpHd4A/ZclP2oSixw7xdauZSu/NlFKKFHTA9DOC1XlIv3RxcoJR3
 PXyXaM9Mr3iBS1zmfDTrRxp6IQOW/5if7R5m/XfRRpZffFwgvVZ9BJN5O3WZBQ6gKYBv+bCKu7Q
 56tI0zuNXxeydS1/78BGhCrxgMTZeyWBESeuZwnhePejlzhMxaNnC0+D3AKMwkslQKNoUnCadkv
 XTDFtdPTSkhCX0oGyA5VwAXCUf/VzYp52OcvsoJSwC0vHPYhOfB/vNfdMgW9ZsX4fdQpNu3k/cu
 tky0NfCoPrrWZSbPw1DbO1xy3++pSA77mJ2fyBfzI2EyCEW4spc/n8h0TI64Afx/1AeAKAAAbh6
 t5h30P7bpl2FTluuNCNFT7CrqLyvtcPd4wbbHpDx47GLCXWRUKWuo9CGaXxUtL7FLRroVjRb6lM
 xgJ
X-Received: by 2002:a05:6000:1acd:b0:448:69c0:8da0 with SMTP id
 ffacd0b85a97d-45eb3692456mr37198079f8f.7.1779878036043; 
 Wed, 27 May 2026 03:33:56 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557545sm5701043f8f.12.2026.05.27.03.33.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:33:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/32] tests/tcg: Explicitly check for 64-bit z/Architecture
Date: Wed, 27 May 2026 12:30:33 +0200
Message-ID: <20260527103037.4461-30-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
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

We do not support the 32-bit ESA/390 target, only the
64-bit z/Architecture.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260519171240.97420-5-philmd@linaro.org>
---
 tests/tcg/multiarch/nop_func.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/nop_func.h b/tests/tcg/multiarch/nop_func.h
index f714d210000..26d3a76eb62 100644
--- a/tests/tcg/multiarch/nop_func.h
+++ b/tests/tcg/multiarch/nop_func.h
@@ -15,7 +15,7 @@ static const char nop_func[] = {
     0x1e, 0xff, 0x2f, 0xe1,     /* bx lr */
 #elif defined(__riscv)
     0x67, 0x80, 0x00, 0x00,     /* ret */
-#elif defined(__s390__)
+#elif defined(__s390x__)
     0x07, 0xfe,                 /* br %r14 */
 #elif defined(__i386__) || defined(__x86_64__)
     0xc3,                       /* ret */
-- 
2.53.0



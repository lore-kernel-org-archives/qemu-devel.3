Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A30FF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABQp-0002bT-Dv; Tue, 07 Apr 2026 14:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wABQn-0002LR-NN
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:45:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAAdY-0000e8-Sg
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 13:54:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so34918685e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775584491; x=1776189291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2KGHP5v2yNEOwagStXunWSxy9hrNInKYu2tbmJjWZg4=;
 b=SWcTLejU1BfbkUvEkmutNtJkDaRaSC6m4tyQyvXisljb1miYZzPgcGdZGQuVekbq8p
 qB/uQCkIbP/Rkuq/beTxcq4WJ2NqRsebIwzRErsxD53VuGdLVBxj1haIu08LzqiMM63W
 dX04Acb5yxZS12k96troTTKIUf7IenozikVZvMGxDqOiIUMZXolbvodEfa5aN1wCcJAP
 DgzmFUG1NVHSwzfuz/xRG/h1U7z/DsNNMT/P8OLvH+UJjX8FZrT/2LZ5cr/jPKsA6Fvo
 NvjbMAj1SMgH9u5nJv3AqpiwsVCqQU9ec34L+xDga9NizHAWS9AD6iIA6ZO+O0XnXrNy
 WIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775584491; x=1776189291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2KGHP5v2yNEOwagStXunWSxy9hrNInKYu2tbmJjWZg4=;
 b=asCkQ8hzW6BfygocEtQqc+hfSduW8SDts1bTfCQbOFMZctI3VzvM4+3xDl/VmVV2tz
 ysLJodHkwB6IcHjZE0kyr/mNti3BUsOElgSQw8+E++DOa+P6wcZy0MId/d47rpuUiCcF
 +pE3XUDM+l8xNaHZpy9pmcDLN2cWtlmG1S0ZqEv3BbuzSJSuh+kOKfz29AjFFKQw+qji
 HzxxGdK1Zo5EKYSZ3hcZe6qtS7EarLObX6/vUj/K6fHEdxnlSUEHdrSq5dJeWF4846BO
 OIG0RLA1QVC8HITk37G0PrXAPNR3FdOuRcoaUnzcF7BqyoHd/2mJIAdKGHxZD+EFDH39
 p2vQ==
X-Gm-Message-State: AOJu0YzpGGMkmh4XOSKvKJzqCldZ1F9DtXVG0z4nLTL2HkCzmvF8eImk
 UfQBpYJ/BQK3n+S7VZmF1e1qTa6DhLU0Qi6coKb0Rn7NypdTbsoQ0pMy0OMNlM8m9FCuxMXIQzL
 5KUJjBy0=
X-Gm-Gg: AeBDievg/9jymnoMGsWIGKSAzzwAz7sH07wYg4o23yKIXpJbFz6OnWENsWAbuieATZT
 5ipDW4FkPBV2kTicp4doYbZ4uDXq0C7mP8PdPe6Nux9FS+TUqJvb2QlDOCjr55gDgGNv1Vj1i6S
 PpGk6B3Y0ABmoalnXzMRm2Fitgywgmib/EW70cg1x9uUa+4t5/KAwJxe9gmsi05D1bE0us9qYiv
 AydTaUcscY3MMUoRe6LW8Vn9aF9jH3rzote1EQbELPc6bfzmJToW5+KgZ7XA8nvZm77hBhWFCo3
 NqxCbPgA8akeLoFkL437xx065Rp1QeJX/Csj0uFethb+IGxra+feds4odgc/oZ3Hs1n+V4Xahdp
 a+qDf5n1Yj+6pDpxgnHK3rqSeDLQgwU3+W3W6kXSAt5YBKCvyoif6QkLkws4sT0//b+uijjXa3X
 cG8H27bjhEP39rnHiT0cdjMMg4Cxp4y0Qvfq1BdKXYnlUTDujv3K3LOMUNjxFwb8MMtzWg41qW1
 /DjinfXqeVqYt0yzGsg22EIWIEi9Fk=
X-Received: by 2002:a05:600c:1508:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-488a9770d34mr91235375e9.19.1775584491080; 
 Tue, 07 Apr 2026 10:54:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488c5308b3esm1615525e9.1.2026.04.07.10.54.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 10:54:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] target/arm: do_ats_write(): avoid assertion when ptw failed
Date: Tue,  7 Apr 2026 18:54:46 +0100
Message-ID: <20260407175448.3329196-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407175448.3329196-1-peter.maydell@linaro.org>
References: <20260407175448.3329196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In do_ats_write() we try to assert that the cacheattrs from
get_phys_addr_for_at() are in the form we expect:

    /*
     * ATS operations only do S1 or S1+S2 translations, so we never
     * have to deal with the ARMCacheAttrs format for S2 only.
     */
    assert(!res.cacheattrs.is_s2_format);

However, the GetPhysAddrResult struct documents that its fields are
only valid when the page table walk succeeded.  For a two stage page
table walk which fails during stage two, we will return early from
get_phys_addr_twostage() and depending on the fault type the
res.cacheattrs may have been initialized with the stage 2 cache attr
information in stage 2 format.  In this case we will incorrectly
assert here.

Fix the assertion to not look at the res fields if the lookup failed.

Note for stable backports: the do_ats_write() function is in
target/arm/helper.c in older QEMU versions, but the change to the
assert line is the same.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3328
Fixes: 9f225e607f21 ("target/arm: Postpone interpretation of stage 2 descriptor attribute bits")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260331092305.2062580-1-peter.maydell@linaro.org
---
 target/arm/tcg/cpregs-at.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 0e8f229aa7..53dd67375d 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -37,8 +37,9 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
      * have to deal with the ARMCacheAttrs format for S2 only.
+     * (Note that res fields are only valid on ptw success.)
      */
-    assert(!res.cacheattrs.is_s2_format);
+    assert(ret || !res.cacheattrs.is_s2_format);
 
     if (ret) {
         /*
-- 
2.43.0



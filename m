Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81522CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL128-0005yC-JA; Thu, 07 May 2026 11:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL126-0005sy-QI
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:53:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL125-00044P-1x
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:53:02 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso12810155e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169180; x=1778773980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jvs97UJqpkItC+Flr/HO+1YZEx5wGbwu0BJu/UWvSl4=;
 b=AoEiqFLJZXovxS8yjHp/Y6wwqzEyYkWkQU0U7GCN33ECOleaiDpp7vC8Ff51/a9ZMf
 Mr/rKXithTAp0AXpLj1wE7KNZigT+sNFbCM74BHGA4lGKvMaFQMHigxjE5bxvsSaSJvJ
 Ghl6OSA4U6FPZz4C60CAK2Wzi6Cy1ZwlUhdgz44ruBPW8xN2Zb0T4sSr/wwmknyQn8gq
 BFGs9NzN2Bi+m30WLjXvk7yzLSNTYospDqwvaNl9G+nb4D49+EdffpM5KbON+1Wbprbx
 fH0qRQHY26YF00mLwdpAKw6a7mdY+FeyrPgyEgvrNyXOXeDd9zg8Infk2Z1YWBAqrQT2
 etyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169180; x=1778773980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jvs97UJqpkItC+Flr/HO+1YZEx5wGbwu0BJu/UWvSl4=;
 b=HCVJSZ5UhfTad9BrIGw6OpeReGqlpPRu7KO5ybhxU9WDccN4oFDYy1dmy7xWR+EgBc
 xwUjHSGSi+6abHk8CtPMEoWuhYezQYG62g8AAroFQOg5RJruP/KfeyKXP8oula9k0F7h
 cUPBlYH2XmxEup0+eTLaQ55D6dklEVBRMfAxGMwH13hX0CxTol7616zAspnrZhob90zA
 UPH5FrOdfJYSKuLmeH2hrKZmXebSUXzvH+xbFpRLvkYeUNq+KpcKDhsjfbhzE082mzRM
 yNvhAaJuAnPa26neAwpb0tUzHyGQrMMwFxBv3kTcTA8VRTOgM9/UFaBzCVn42mOgMCBQ
 z/Og==
X-Gm-Message-State: AOJu0YyibWmG+k2qZCYRt9en3POKP20rn+zIclg2+GLZdZQ/N1IodVZA
 JAckRAYyHocrH4iY5dxNX84xZ8HiPr10PCB6sHi6QT1irhb7m6jD7zAZlDyxcQ+tN5o2UaqB9fF
 U06xU
X-Gm-Gg: AeBDiev+O3IbEf62lEIloP6gRoTpuDNQEj5ns02cbNDHYL47CAE7FbZt9fv3NUGahVU
 Xr0+LP3meNFw1LX7KiFjLwfXrG1QOhfWbjgYB0fEEG8g1V0+EOn1cgcmQAHLKyM7RvzTgkWh42L
 Qq1NE7Ujg2oa0RB5gsnVFsfjL/4k+zCSRXi22PPesNq4Al9D5iS343c2dh/SxkRhTbCAFK2s54N
 VHduR1uH+BkfF2aAR33tCa8LZ+iPJARHgDw80uiK4IBoxBOh5ZIqGNVX8jQXM80e4iEhkEpBwTI
 9AGh5nUa2LQFRzETahxioicmBcd95Wrabyh0q0l+Z1HZ6FgNOLTRX/e88EWLTfUlZP2zpjTplkW
 mqFrUnuCcxBqFLil03bDa6xtK8FxBBaY/M74o2LHOdJGVKxACuoNXCBugEooCesCz7y4iDFXx4d
 VkYQwytE6LnTfG78fOdZSHoD2IDh1gTuORc3acEu0q7g9dr0a3N49gjKgI520Efg+KWZxpIYsAb
 jUsbf8DH9ajfxvXtdnUcWk8FvJZxgA=
X-Received: by 2002:a05:600c:3b17:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48e51e15718mr126809725e9.10.1778169179450; 
 Thu, 07 May 2026 08:52:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 66/67] target/arm: Report IL=0 for Thumb 16-bit BKPT insn
Date: Thu,  7 May 2026 16:51:53 +0100
Message-ID: <20260507155154.1886557-67-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The Thumb BKPT insn is 16-bit, and the ESR_ELx syndrome register
definition requires that we set the IL bit to 0 for this, and 1 for
the 32-bit A32 and A64 BKPT/BRK.

We used to do this correctly, but accidentally lost it in the
conversion to decodetree, because we converted the A32 BKPT first,
and then when we converted the T16 BKPT we forgot that trans_BKPT()
was unconditionally setting IL=1.

Pass the right value for syn_aa32_bkpt()'s is_16bit argument.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3474
Fixes: 43f7e42c7d515f ("target/arm: Convert T16, Miscellaneous 16-bit instructions")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260505103726.419195-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index ce427c5a3c..c744b16345 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3580,7 +3580,7 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
         (a->imm == 0xab)) {
         gen_exception_internal_insn(s, EXCP_SEMIHOST);
     } else {
-        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
+        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, curr_insn_len(s) == 2));
     }
     return true;
 }
-- 
2.43.0



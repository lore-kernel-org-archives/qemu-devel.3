Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1CFCD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBZl-0007gR-Af; Wed, 27 May 2026 06:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZe-0007AW-IP
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZc-0001Jk-Pt
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44a14580111so8541651f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877995; x=1780482795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qvwcWrKq7K2sNaKbDobNaBQOUGv9jBhDkzOQwDfCzLU=;
 b=L8AK8lRNLu17ScIKURFL3dsp+exJE/lH/qEjmxMi+sT7vvwaTAisxr/voEOzgnWTz2
 kMiTClQRpQT//XgiX1X/t9/Ni9GrYObJk60F9wrjltxphahFOMLnctZeNxR8bwQJoBWX
 hnmV96Xvec0cNdLTfMeeze6k+4UxCca/g4KJGzjmoW4/U26cC+HcmNWLYm5NAI04O5r9
 UnuIf7RQJ4i4d1O0+FfpAy0ACqLdk/7/VZTYH/R8gjJd/p18dbbkCCagRLbgAQt212FY
 Nj+lnIt3gn+xXrmuaLR2SVlQr0l0W0xp8+VIhwUcSwoKTqP+xpsZJUeCQ1/jx0kGELtM
 TlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877995; x=1780482795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qvwcWrKq7K2sNaKbDobNaBQOUGv9jBhDkzOQwDfCzLU=;
 b=nQOhbgFiwIiGnAjIHaosQzlZMUW0oU0P4PRYS0Rngpp3u1wJGPcTkvtAXYuWol+7gL
 h/2CZv3TJFu4xlPMdytQcZjkX8HH1Ut3TTxbY8peX2K8xkbCge9XAG+bGhRKBRb6q1II
 JT6WNON6L1Za84gCFZR5iyYYrhtegeIC8bWVXMWp6yjtzqY2X/ZubIl1P3qYb69hpKyh
 TQWJE3vF0HjDUXWGJwm+9CehCqDKgmpHl9ZYPN/9jAeSd05aAF2+y2oIDOMRuU1AQEn1
 ARMJI+hobdqJLSZGG6iBDF/32Oo3JBdqIUIiO7UM5UbNFdw1MGUnybej18eOppoYdoEh
 iW7Q==
X-Gm-Message-State: AOJu0YzjMGTk771ZKdbQ2R9aXBDlH19tKX7SZAmNUjnrBwl6FB8nBY0G
 56Wc3B+0t90uv70nRntSUnMgc2HN7qT4ueqAvXiclfpNC9CQoxoxEcFDiBWo7h/y2mFVMrUTe/f
 7ZNAfsT/8lQ==
X-Gm-Gg: Acq92OE+4Xb02bXWQxZQWzrHIGTUTL2gnbQajmsCLkenQL80t5UPrTdt7rPH965UzPo
 8jE0RqlF6XYaCU7bv1unFd/h7/COBpfbBDHpaZrzrePxwdJ8BOE4V30zsSFM2luFtD+jFrz4nam
 WMCsta1ykMZCERp9VGvUGq9fJMxjb/e9NDaBBaE6a8CvjeNgaHuKpJhQ3kydL+FD2ugZZ82CXGH
 Myn0biERPY7gelBWQ7Sogta5DnqR2EGbR3LtXynl5JBwoM+7L567JGQ9+RoKf9diEo+jypze5QU
 3CBoxUYTnd1uZ1k/33t2TVKZ9IvYUCjz8Mh6WMtLALLcCaKi7jPECqVAc0uj2GxomN6uqBYeFXZ
 /bZoGBVb2pgM4ga8jvLcSnjn8F33br86gBPUrelQs8XkcMthOLfXb7Oa6n4o2u9WZO155v17N6n
 h/jiCbiykV1hqn39TP7ZRuk1ba+urUcswX8eGnNyLQg7AV/nYM4buWCd8lV1Tng2IxwQ==
X-Received: by 2002:a05:6000:25f5:b0:43d:6fb7:fedb with SMTP id
 ffacd0b85a97d-45eb38be0d7mr33768919f8f.36.1779877995162; 
 Wed, 27 May 2026 03:33:15 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5579b8sm4980642f8f.9.2026.05.27.03.33.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:33:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/32] target/arm: Only set %kvm_target when KVM is enabled
Date: Wed, 27 May 2026 12:30:27 +0200
Message-ID: <20260527103037.4461-24-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-13-philmd@linaro.org>
---
 target/arm/cpu64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index b38a78aac3f..7b2f09cf8ec 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -701,7 +701,9 @@ static void aarch64_a57_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
-    cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
+    if (kvm_enabled()) {
+        cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
+    }
     cpu->midr = 0x411fd070;
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034070;
-- 
2.53.0



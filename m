Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E976CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLjY-0001k7-5n; Tue, 19 May 2026 10:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLjM-0000wo-Ni
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:47:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLjI-0007xY-1d
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:47:35 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d73422431so2525336f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779202045; x=1779806845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RNRxHUIKIoHhD2L2k2Kf0WRpvOKC9u30TJYtxRtPNw=;
 b=HFU9fuvSYr0yRESLSFAl1u9Ep9gY3+oE/CdqI6cS0L3IX7XJEn14Zq5GbBdnR/jRBd
 d9YPRf98JiVCPmJPCqt7Fyzq6kdHpfSlnlv03XO/nIctb2B/kGB438iqP/Fd2y7d57Fd
 8d8BFl42rkfiS97NoY40znIku3RpbTR0s47lZGozqVBhUVAISDcZWQdSqW/LU6t5Ns9C
 8y2NeAj1JTrf0g6d8mKm8cFzz8WcFiCPtvTHCQjSEA98pNoaw4oSQ9TCRlCPbAL3QfnW
 CRZcssEFsIczPEZWCTDYQ3nmL8KdszetLClYFW47EOGh5Rk3LxeLyT85ekB/MR5mYVOb
 3HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202045; x=1779806845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1RNRxHUIKIoHhD2L2k2Kf0WRpvOKC9u30TJYtxRtPNw=;
 b=PPEjyhv+oQIspYOTkxbw7enrPcn3WGs9bZ0oCzdA4V1UtjNnUoGrcAu/n1errI1xrL
 WgEg1xutPubIlKIQiQjGAtTxGVd/VE5Y0YlexFbc+IWGWjqVupKSxNwNDWLpfOiLp5Ud
 T1Xm/GISw3qPGGjlbibUyDkiPZ6ZJEXG4QSE/VgK26fHwssNSAUoZZE6qFrS8tl4R6vP
 cYQjDG434tksrVlMw3JSkw7m2vSKAm/ZMe9H2xFUYDaFthfoxxMvsK0Dv2008JQoUUyR
 6SvOSWJPi/EFvMmTNcFD/xPxjqW9Fy7FzW+kqOsH1nk2MyGSYPbqq/zMe+GbyYtAe0dx
 GjoQ==
X-Gm-Message-State: AOJu0YxeVGmltgggKny0xEEQOsNebwsDx8+ifbNgwixwlBRTqWmM27vt
 oUgFJY55DziMtL2RWmAneyrrhxkUhvQRYQ9wnU3Mfu/PoYzRi+r9nobXPfKde7LUF/URdVyfa69
 lu8lR1kg=
X-Gm-Gg: Acq92OHVemwRS9pbuqtvMotG3K9uW7iTep4M7rt9t2XJvsPYQhmZTKzLc345gde3Uaj
 y/dVkJBEaFdX5VxYfOi9VYi/lgnL0qPdwa2y89zofTFxZkaifWiIXZ9gmdM/dCFcstIGqa3+zQB
 Qz9Mc7NMtrbLotpJNn+SS93z8/wQ57Sx1Ei39NBtgj4NMyrc04bfixS+ceuYD0Hq5+cSXVxlpht
 lCWiCm3rECTT0s/ypVPLriJLmL1HIZ1HIQTX2BMvZiCHoPDt7q8IMER/OT54tRqLU7mZZ7yOSZW
 e2CxKXgn1trniKE1PZyOAraKuuA3o+d4bq6w9rC60tEmgl8NW8EnidajQbAkiZXf22kS/rtbTSv
 OpPQ9svaORIYFB/wwsUTANATgS7EOi2D3ZaayaU8IyGbbNRAroN4v0rjQuXinLAN5zh0lqsjlBY
 rUoZaKcHbS2HF9cp1QvqbklhzdwfMz+GSy4eNQ37QR+cY+1HVTeDpKh7fgJUfMZe/g1O2yP1Rvg
 e5WofJkwDQ=
X-Received: by 2002:a05:6000:2304:b0:44b:e349:e6bc with SMTP id
 ffacd0b85a97d-45e5c5bbd76mr30216412f8f.3.1779202044162; 
 Tue, 19 May 2026 07:47:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm42595487f8f.26.2026.05.19.07.47.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:47:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 13/18] target/arm: Only set %kvm_target when KVM is enabled
Date: Tue, 19 May 2026 16:45:48 +0200
Message-ID: <20260519144553.91483-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
References: <20260519144553.91483-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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



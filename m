Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39623106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vxU-0004KG-AO; Fri, 13 Mar 2026 02:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vxR-00040h-E1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:25:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vxP-0007Y1-KI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:25:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso20682745e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383110; x=1773987910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEay3sILt/5hyp2tHSrBKeM5TVUSOl5C0JQ6kEvmpI8=;
 b=e5Pas3Vh94IjUjzKQiotWeDaMUbgA3HNh66Udip8iKxFBixcFNsOw3Inli5qbha2Ci
 Raqgax9bm47RCf0A0FKfQYNNcs70q0z8BTpktvh96dCKS1MHWGr4bngSAZHQGC0+HrfH
 2Iv3r3kGZHy9LDcuG2D0TtrTEEIUdn5hGO4WkIVreT3L/XJuWOT8JzE359Rj7WrlkVCh
 3FGrLrQbCzLunYHAhqiZI1mXLKyxABxnDI49V101AqNIZFwTEii/nbjAPXoOdDmH/0Se
 x3gbr2lGSIS/SlHs2WISgoqpZT0hXTApDE9G9nHflUFcYXB8+f/FcoPaxrpUQEw79+q1
 QFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383110; x=1773987910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VEay3sILt/5hyp2tHSrBKeM5TVUSOl5C0JQ6kEvmpI8=;
 b=Xi7QMHFwDLFgY1VQ/cfJ6/UjN+atcFSUnWdiRlEkwdAPxjU7ZHJ8Zpqvt4a/APyTB+
 Oex2lW5xGmclZAI4De+KANAl6XWMd+RyWVARoj6ERZVmhhMYoZkknVjfAwZ3ZjndS+k0
 mPfkFxE1o55winiQ87nTgKgDcFZnUremHhF5QxqfORD5l4y9jUEYK5TE/zM25n9Pw1Sz
 4u3fHATndMrVbA88sQRx2fiWFPX7hjQ7Ae+63pZnEr8H2vl9sSlRG4pnHeXDRWB0U12/
 f0mZNIH8b6VuNVwQhXHqISNCDlZfbseUKPdgSIm3iEcZ/NijegZUuz/EyefjimkwHRXW
 GyuA==
X-Gm-Message-State: AOJu0YzYYTOQ+MY2LwUZxtPKHOS/g0c6wHmPSmBz0yveIzaj9NJ5vVjJ
 dH8eOBuo/UpVYzfiFtRrnMbAcBS/q4RAsTTKFiFBHoTusqfaerQZkxvGsz5lM/XY8fCCI7meNM+
 LWQWH4I0=
X-Gm-Gg: ATEYQzy8UR6xNzMAqwSUACR8k1mHzPeh3kAyW9iVefiRqQlrV/UH7GyTlDpNo6UUzJD
 BWB7mANFVTAQ7w2nNi8j7PqYB7mVg1N9D7ezuoVxv/BlaVAaMezI/biGALNLQEVvILc+ynq+FyY
 r5jyCMp0yqbwE0C1to4uvABzEetrL4uH5Wb3aQ0Uuml+VdpPWXynBKZrGRcqGHCBp6ev5PL4Vzt
 pCDLsZpAd7nDimbskQ60662alT4dcORa4lkvBrMCUOIxZJgOy46BYFEYQo11otxyfWX+UPSGyty
 pF8MbyJlZZVQNxVCDu8rhA2pHRKdf+3n6k5/dkQps2i1YD+LmVsYhM5RGilfIuFm3bMMILOqNAA
 pcE3A2zJ5VE99EJ+xfTMRf993whSm4wKa50K5rzTL6kjNTM3BKViKQzErucALATMbSwSfixR4LX
 3HvggSuCghFWMi+wNXLpl+PptgUatUu2xnlsHjtqGwHCgAaZIEuPcL/mjfxloO670VyP0fR+8zS
 a+UtT/iJnB+BABB
X-Received: by 2002:a05:600c:8b45:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48556702853mr30205965e9.21.1773383109705; 
 Thu, 12 Mar 2026 23:25:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a73a75sm12730885e9.15.2026.03.12.23.25.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:25:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 37/38] hw/avr: Build as common unit files
Date: Fri, 13 Mar 2026 07:20:53 +0100
Message-ID: <20260313062055.2188-38-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Nothing there is target-specific anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/meson.build  | 2 +-
 hw/timer/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 392d30b1423..a2601e1c433 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -152,7 +152,7 @@ system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_ahb_apb_pnp.c'))
 
 system_ss.add(when: 'CONFIG_I2C_ECHO', if_true: files('i2c-echo.c'))
 
-specific_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
+system_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
 
 specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
 
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 178321c029c..201b5d8316d 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -33,4 +33,4 @@ system_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_timer.c'))
 specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
 
-specific_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
+system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
-- 
2.53.0



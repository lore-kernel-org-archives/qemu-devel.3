Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DEDFCA166
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzekC-0001iJ-TE; Mon, 09 Mar 2026 13:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzejy-0001Tv-Pl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:50:08 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzejx-00031z-6s
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:50:02 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso4048575e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773078599; x=1773683399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEfzPl78wZZuVCLa3XMkoO1IguwbQ5TCjrRQOGRXJK0=;
 b=B3uzsittSiyxIDmsxVvsQzYaA7FR4GAKsex/NRGGxPRyRfuq4+/FvoJOhFZs+Iyrol
 lvRRqzIfXHOKHCNifjcbEF4RHMr0h36Fgl43YHTutB4IBXUoAzfGWbrqsVH2bBZO02Os
 7JQdzcWYEgducbd5ShnarSsEEzl+XDy31Md7eZGqogFtXLC9jVaOq0Gope4KINKp3F7V
 RUTp/EDEglUg6FLe88QM7aaeSeW5PtgT5De1jyLL4hTi2V/PuwP3HVjtRcadQtqONRyb
 QF0dPGyS8sDBGsQq3tTcNNv9jevTB9XPPmXBXuRP7NNRlxLxWU0adOQCI5SKGMPHb5So
 rf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078599; x=1773683399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EEfzPl78wZZuVCLa3XMkoO1IguwbQ5TCjrRQOGRXJK0=;
 b=kmbrFqRskgMVPwGc6L6hcrUFCvwLIqClXfWT2pVRtDUrdVsY9dAlEVmRrMo7bRkbNT
 nnd8Up+j9NvIuKAUWzt+t+PVG3221RwA6KdREjD2hU2xcVeDA9YNlJk9yThLJyRutf2v
 v6rOhcCRKlI+zwyiuRGbjiDiGy99A4hDAgVrLo6U5yUKJYAXaYbmgMTxPCaP8kljKtKs
 zxkV13nCz1nGx/lPL6yVksXp1MtFOAcVagA+JL+TasOQzaRBnBvxUUMBJPHzuJSoLyi4
 FRREgP34vrAyESjaRWKEmLT5S0GubwaKemxZmY6RHdhiSIflzEZDkEDaI8dmgE36K+fe
 7VUA==
X-Gm-Message-State: AOJu0YybhxWihyTrexoniflhE+7JJ8jvNK/2lbO2+M/laCHT2nEQWKGJ
 K7Eu+dx2+dzFgV1Y5BAISH5Js5dOk5skQ6vLNuz6UP4nRadpYQXWpvb9AlU9BoIReHwsLIufs38
 5Rqn9md8=
X-Gm-Gg: ATEYQzwFgwjZX04NlDOLLfKjyfDp0Bt4+TV9a1v1OE96/oE9D9niDRkIuPAwQTNVknF
 FXLqYOMX+5o4gAI9brnTzX30YMHBuVmWGbVVwIPVZ+C2YTtLHDtLX6i8MlSwDPnP8eXYwGTiWpn
 83rJx5nEYHcTT1cKAH3HTUpAUaPHchJmKYk8NFeIr8I1Bhpd4lXQQ3taO3F2woyrV1gleTZQ6GA
 HUUxEd70jCWt1weuFOAHjbWF2dqQjUaoRd9cHiX0BvjV7WPsnE/Xu47lHIpGasVOSEONTYNjzkS
 hbh1YEh7QQjA0M6PG+NKlRLtvh3WJflJvek/WE8VL7tuYO5deUTuMCZ+Gzhe9Tm1O/Q/BE077X0
 YTnlbyF8puLXlcFfVpkElFyeTDyZm4OY1jCz5DrlAQi7edeYFTTRidzkV4XNLIoj0+HC6TOZEvg
 34hER4rDwfzUDDM8+9dsed2rEbdNsAREgIDenX//UJ8hkYydU3ECW//hdCGsxl2nVgiy8K6ZAg
X-Received: by 2002:a05:600c:4591:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-48526978664mr196326655e9.34.1773078599343; 
 Mon, 09 Mar 2026 10:49:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a9e549sm6747245e9.12.2026.03.09.10.49.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 10:49:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] accel: Build stubs once
Date: Mon,  9 Mar 2026 18:49:41 +0100
Message-ID: <20260309174941.67624-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174941.67624-1-philmd@linaro.org>
References: <20260309174941.67624-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/meson.build | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 5de4a279ff9..ccad583e647 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -1,11 +1,10 @@
-system_stubs_ss = ss.source_set()
-system_stubs_ss.add(when: 'CONFIG_XEN', if_false: files('xen-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_NITRO', if_false: files('nitro-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
-system_stubs_ss.add(when: 'CONFIG_MSHV', if_false: files('mshv-stub.c'))
-
-specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
+stub_ss.add(files(
+  'hvf-stub.c',
+  'kvm-stub.c',
+  'nitro-stub.c',
+  'mshv-stub.c',
+  'nvmm-stub.c',
+  'tcg-stub.c',
+  'whpx-stub.c',
+  'xen-stub.c',
+))
-- 
2.53.0



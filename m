Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0B2EB1049
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzucF-0001md-3V; Tue, 10 Mar 2026 06:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzucD-0001go-8m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:47:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzucB-0005xJ-MY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:47:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so24825765e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139622; x=1773744422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VUfqTi0kH3OcUOH11PK1YSauOQXYkimq8lUmNTZ0Yc8=;
 b=BPR/6571lMAr6BgOxPNl0JwwO4QnM7AI4Ii5HymHqDX4piP0haSFuzBRH20kDlkm1M
 pxYlgV43on8leaPRZAk9YkQdDnpiuljYuiSXvc43Q/xb7qgNfKVWvb9hzpeKMNzr/4se
 6JehpkAaQx7j3xcNnZspdiIQdc6Q44yAFyhD0AyLnNXkqWISlSp6qrHR+oChkmHGg8M+
 h0odcLsUIYBx0Zpi1zcxH++7oLTbTcMGPwQyGfsU474bNEIDtQNibxGLu/gi2BQm/Z+3
 8hpHF8JVB+RshfekkLeYYZZ8dEwkZcNblGBwMgMPbEbMpZ4MQtGleiISitcdB5lZk56C
 wilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139622; x=1773744422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VUfqTi0kH3OcUOH11PK1YSauOQXYkimq8lUmNTZ0Yc8=;
 b=roDqvnLrQZyo4IXzrWMtaUgBm3i2BNI2NmRVnWMYbGQtm6iZ9lTjjzoLyr1U55OgyV
 PHy3AQwQz1nDWBiIG3V5PGqZ+EBsxAxyypAH1vS/7/O07Ix/AO2R3p2363/lpeglQrK3
 l1oGayczC8rF5Nk0ZaVDfut+lgU7+xmC488S43XkqiNROrdA2MFFMjIsppFW8eAL9kRp
 Tn/bwrHP0+07Sx0bakKiotvse8pyJCJ94bEFLskI4iZfAHOavynf+9DaLscJA2+yfJkT
 YhiZysjXbDiASy+CmfisFM5Y+O2hfkNvndMbPjN0aPII8y6e/5+J41VoFVAUPdJvynQB
 6QdQ==
X-Gm-Message-State: AOJu0YzoGBxHGGme7RTSrssd+J9z7hsUyDxTcuRZwBibb0QuIK5Yjruh
 bQji8v/r1Se82k9hbsekNfsgHyeWk443iytBaIa2NqE0dek/KHaYPcYsP0BTsWeR0PYelJAK+Iw
 jTNnlBfI=
X-Gm-Gg: ATEYQzy7LNf2b2MMawwvw0tAngBSrKLRgwjzAOlIYSO155Byuoc6McnYTUFzpuPbtK+
 p+yAtr1IjxTOhnV9Q5OGiH/f893H85Se+IHrlqPhqiJFCuqPWfjEd5EUugGeSkF/3H8ZoP/E/9n
 PS7C9qzmUSuKExugV1iV604s9EcBRmJUrfdUCkYUkzIbQmy2BX6BrlDlbIQuQ98jl2pzHT5Fez4
 Y1Ra94oeBI99yizW3K/1TDyMePY77Kt+dHIAVY+vttfRput+5uexd+hiuqlogE0BfFSXsxLid0f
 o1abwAwEi5JqF4Wgb9bA4TVYCZyb4BZdejxWdLX+F4+9Vy1MHNnVnuWZPKp48rvUAOL8SWvJ/5v
 71pY1aXSUUvDeni5O9OO80B63kQKsltdBGMk/6hCZuPKtxKoA+qEknu8laHglr/NFa4eei1rKa/
 TBKZ+5HXYEf2EQkPs/el4j52JollGMOBErHeHyVYRercqzpLSDDete7vymgCm77Z4fuGFzvXQB
X-Received: by 2002:a05:600c:6090:b0:485:303b:c50a with SMTP id
 5b1f17b1804b1-485303bc6c8mr174484835e9.13.1773139621817; 
 Tue, 10 Mar 2026 03:47:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485354f96fesm68165155e9.30.2026.03.10.03.47.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:47:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] accel/qtest: Build once as common object
Date: Tue, 10 Mar 2026 11:45:11 +0100
Message-ID: <20260310104511.12670-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

No code within qtest.c uses target-specific knowledge:
build it once as target-agnostic common unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260225053408.18426-1-philmd@linaro.org>
---
 meson.build             | 3 ---
 accel/qtest/meson.build | 5 ++++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index f45885f05a1..1867560da63 100644
--- a/meson.build
+++ b/meson.build
@@ -3897,9 +3897,6 @@ subdir('linux-user')
 subdir('tests/qtest/libqos')
 subdir('tests/qtest/fuzz')
 
-# accel modules
-target_modules += { 'accel' : { 'qtest': qtest_module_ss }}
-
 ##############################################
 # Internal static_libraries and dependencies #
 ##############################################
diff --git a/accel/qtest/meson.build b/accel/qtest/meson.build
index 2018de8a05d..e1b089e02c7 100644
--- a/accel/qtest/meson.build
+++ b/accel/qtest/meson.build
@@ -1 +1,4 @@
-qtest_module_ss.add(when: ['CONFIG_SYSTEM_ONLY'], if_true: files('qtest.c'))
+qtest_module_ss = ss.source_set()
+qtest_module_ss.add(files('qtest.c'))
+
+modules += {'accel': {'qtest': qtest_module_ss}}
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A30EA8543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMmk-0007XO-QE; Sun, 08 Mar 2026 18:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmi-0007T4-GQ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmg-0003m7-G5
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48534e9076fso4362445e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009575; x=1773614375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nFoSu2Lso6VlGIPAH1rthi5SRiSZdN8KLe/bg6opams=;
 b=YXz8jnYHUaVeVQTfIyjtDhycvWdR2s5aArc8ymLCwYpZgbjmp5dx6xYCuAHhhR8cO6
 Nl05D3st4O1x7889wPmnbreWAkUHERIluw1qaP7Gf3weiSgTAJFU770Ug+znkrdgWi8F
 KP4QZUDR+pnbcWTVv+khq1dgAhrMfLAT9B8udokVIQd1HFcPic0IUltOos/2uzO4gQDq
 /VnB7E5TtNmmGgtWVoMXNGxlK48BmSuC/1ZEIDWqzeIr2T9BWDDjgR73cK5ywS4y0WHT
 TiHzbC2j7k8qwcYL2LY5EYOvH/qNhxrNXwc1ZvDSIeTgjBMQR70rmzG6MUW85FPZG14N
 1f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009575; x=1773614375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nFoSu2Lso6VlGIPAH1rthi5SRiSZdN8KLe/bg6opams=;
 b=w5Usx1gZwhxY/rnADaaltkUfiVtO8v+PtGXJNMGd3bbOA/WNpMu8X8i9CIloCZQOU0
 YPLHDo2Huq+aVdkqRq6DMIOI5MHinoIgjjeXdfzWOutzUX/j1q5jPx99L6yNY6OGnvyA
 8yUnWvCxmx9/GV1PX3f2h0EhPugnX+yhOtctZFwn8MtstVSz2y5ayeNfCPWhFIOkDhzZ
 CYMjGVvdS1n9FkPw0vXqkkQhIz+PTFWgCkzGnZFQXsD7G2G3k/fk6N4ElwAwDZW3dEmt
 wmlE0KI5WRliTmY98VY1Lwr86DCN8JHK4HXo+zizUvOVTIE+xwJusOA+4Rg/5bFlwtJk
 xlew==
X-Gm-Message-State: AOJu0Yyjm2YJcIa2mvWUWsp4pDvyAdiDHApX5t0sqvik/ziXjWtdjxo1
 eyjbtW8bVobUT8n0UiBve9WnUBB3Gul3OPoNW1PH/zamOXUCSi55Ky/e7OfWqOuUJQo1qTyZEPI
 mVWH+org=
X-Gm-Gg: ATEYQzxKaulAONQdTxu65PgJ6xHPzvmHDyTRaGAllgDiHU6j0sjeo/jT3bqTDR3s1y/
 2QDNRRWNqEsXbVza4k8zrVxjMVQCK079Hoz1WEkBq+GAL5jtyjoMAKsWpV0KKAaanOrNSOaZ+qC
 JIGdYzgc4C4aoZNGtaquGISFDPGbWVCn+LYbkA+zXCggcXvEpv4IVsjPrQJN9F+yCI+/cwgAfi2
 ni0HLwDj/ugb+f7a9asx08ubOfDydCx00F0CAJeO2K4YPBtfpOLOxJCohUlkgW8d8nJ6CzGverg
 M1tvI7S2j2PnncgoQm+J7DSzlOG9IXB6e7hhs5QwuIYMnAKLebcVI21kxh7yucHEg0VG1lDzmz4
 9rd6oQ+E6esk03gNaQRBLFtQ0eHq+mxS/ieUXBdlbs1zjn32+p1gP2xvVuONKrQVPWiJIJMrJGL
 4DPxEAGswEAc0Cy/2ShBsWRpMsJ5na2eCaysEYW0CiOGF1T7r5YLpe+9J0EumP+yXTMfF7svS75
 My8/A==
X-Received: by 2002:a05:600c:c11c:b0:483:c12b:fe3c with SMTP id
 5b1f17b1804b1-485269188damr110302115e9.4.1773009575395; 
 Sun, 08 Mar 2026 15:39:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae538bsm361560895e9.7.2026.03.08.15.39.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:39:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/49] hppa: Use 44 bit physical addresses for PA-8700
Date: Sun,  8 Mar 2026 23:34:28 +0100
Message-ID: <20260308223433.25503-45-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
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

From: Anton Johansson <anjo@rev.ng>

This is in line with the PA-8700 specification which demands 44 bits.

However, this change breaks the SeaBIOS functional tests as the firmware
assumes 40 bit physical addresses.  Therefore, change the functional
tests to instead run on an A400 which has the expected physical address
space size.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20260305-hppa-c3600-v6-3-d51526e5269c@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.c                     | 2 +-
 tests/functional/hppa/test_seabios.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 5895b9d7c09..92027d129a7 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -349,7 +349,7 @@ static const TypeInfo hppa_cpu_type_infos[] = {
         .name = TYPE_HPPA_CPU_PA_8700,
         .parent = TYPE_HPPA_CPU,
         .class_data = &(const HPPACPUDef) {
-            .phys_addr_bits = 40,
+            .phys_addr_bits = 44,
             .is_pa20 = true,
         },
     },
diff --git a/tests/functional/hppa/test_seabios.py b/tests/functional/hppa/test_seabios.py
index 661b2464e13..bdb9d534efe 100755
--- a/tests/functional/hppa/test_seabios.py
+++ b/tests/functional/hppa/test_seabios.py
@@ -12,7 +12,7 @@
 class HppaSeabios(QemuSystemTest):
 
     timeout = 5
-    MACH_BITS = {'B160L': 32, 'C3700': 64}
+    MACH_BITS = {'B160L': 32, 'A400': 64}
 
     def boot_seabios(self):
         mach = self.machine
@@ -28,7 +28,7 @@ def test_hppa_32(self):
         self.boot_seabios()
 
     def test_hppa_64(self):
-        self.set_machine('C3700')
+        self.set_machine('A400')
         self.boot_seabios()
 
 if __name__ == '__main__':
-- 
2.53.0



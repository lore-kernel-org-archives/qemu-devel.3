Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CC1EE6B6B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh7-0001ys-PM; Fri, 06 Feb 2026 16:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTgN-0000RW-EW
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:48:20 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTgL-0002pI-LA
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:48:06 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so10030185e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414484; x=1771019284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbMjRnug+OPPrkK5xLx81UGaNUfrzIm4i5zHFkBaCN8=;
 b=FKew3fxyeFmPTAQzS0FQX0XP/QkZjLore4OwrQOdlAJ29/wBDQjTcVgXgMEtcxipAn
 fbkzkelXqhZw3TaBLeEp4yVYNIleyMUkoWE4+PMLqL/cy4NwLkn3+uvo601FFe0RrSUk
 fL0NJDe/8kIit9Gv1hdCFSI7+peIQ5oxUd/GPXNceCSGyS9Cayl8UucuKioVL6F97Bz8
 jYQWChG7jwdt8835zS/bcOiGzznKvGo6RifsJt13FQJ9KnVSzrbd3FMWIGmcWA9UF4ZT
 7v3Jfa13Ppbz0JFXo/27uqcqc/VzPyhgk0o0dNgc5QxOS8NibmtDqTtp3yttYBOPf8ok
 YB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414484; x=1771019284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mbMjRnug+OPPrkK5xLx81UGaNUfrzIm4i5zHFkBaCN8=;
 b=vG8xHw46n26HK5jfl/pGlC6B6GDfcdKv3sSVYDCh0Tr+0gjxfOdccGAjlqFcl3hCiN
 ONq7SyRXsCAQorlprcSo07aK6YYdonz2V8G7SnB1eI4h8ULbHm6i+Yck37ft7isDDxaV
 Y2bBQgBbCkDCEbP4C8/SyMzgXsIM4qDDrIS9n1ED0O/vWeCzNv+gf4ew3+P60UbVddhb
 ZmQ/4bj1Y+2zhYo93kcaeIdTG/81JSt8g5CnIz5VgxcrC3NHGuhFFugoPGRVxFX9dcwe
 Panv+8g6GW2SGLYnS907lsKLwjN5D4M/3WPMI8dLmLdRLzyUzZ7V5QoWCMoxOCtdN71w
 oSsg==
X-Gm-Message-State: AOJu0YxmmufSWmYptcJUAnhinQV5iWM7m1iC0t2c8VSD3xjY0myvYDNG
 pww3KF5PzriyF0P3DNDOG0cqvh6xVg7neojkYQuc/fRUgWT6ccGKhGY0JQIOLcdDH0gwj5YXdPo
 iHg4Ki1Q=
X-Gm-Gg: AZuq6aJetXLBOREB/LxKU8lrcqR+JaCJT5COyRqhu3/ZAc9z2SL9l/OFPpaV8k6B1+K
 ucNfNiVRV4piPyPOOkRmQ1okd1mwzv3pRFvdGrVRvk+eQoZQB/UV5atEfqMVwEpEGKyz4pBUy+V
 OzZQ57fSDjuVk3t/TVjb7acRYYAJPhEVPEvpfR5bzXg2PQvtOAdomIF++jamHSPe75SxmSoPx9A
 0PSWpVe5iLdUsPNuhDRn5fiu2/Qe1TBuvpiEFNE2P8RmYvCZIKSJPmD4qZ3htHoT/atd6vGO1W8
 0e8qwq/qJSSiv1VgQQsTe36vahWSxHRwrqtl1L04WL4nxxela4mW/HfIVFoC+I5q7ISgI6pnhFs
 VK4NfE4/JYTCcPd1F2a+Eh3jgomi381m0V3LPDOYrQBh9a1U7z+JLcN7VdcNbjCXdXJwJHex9KC
 QC8CxzG6KyMnhGE6wlSS78Z26V16zNxIk98RRLPNMntOmUQLhT43MXRXKE9TTR
X-Received: by 2002:a05:600c:6290:b0:47e:e78a:c834 with SMTP id
 5b1f17b1804b1-48320226676mr61118435e9.34.1770414483901; 
 Fri, 06 Feb 2026 13:48:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483179dbdcfsm192309675e9.0.2026.02.06.13.48.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:48:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 29/30] meson: Add TARGET_ARCH to config_target_data
Date: Fri,  6 Feb 2026 22:44:47 +0100
Message-ID: <20260206214448.22008-30-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260205030617.266625-3-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8c6c0a9a32f..2d114e90184 100644
--- a/meson.build
+++ b/meson.build
@@ -3263,7 +3263,7 @@ host_kconfig = \
   (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
   (have_rust ? ['CONFIG_HAVE_RUST=y'] : [])
 
-ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
+ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
 
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
@@ -3353,6 +3353,8 @@ foreach target : target_dirs
       # do nothing
     elif ignored.contains(k)
       # do nothing
+    elif k == 'TARGET_ARCH'
+      config_target_data.set(k, v.to_upper())
     elif k == 'TARGET_BASE_ARCH'
       # Note that TARGET_BASE_ARCH ends up in config-target.h but it is
       # not used to select files from sourcesets.
-- 
2.52.0



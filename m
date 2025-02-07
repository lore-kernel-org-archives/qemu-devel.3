Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E301C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVZR-0008MS-CE; Fri, 07 Feb 2025 16:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ9-0007no-9F
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:11 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVZ4-00023x-CI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:08 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21f464b9a27so37592115ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 13:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738962425; x=1739567225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vn1shkzQyA8tl35At/zndAM9YWk74Q9p22uLELQ70Wg=;
 b=D/EDYy9DRMG8CzOLL25c3F3R+4LDZy81b/d9xZdJ86pabW70PdhnheohIp9PMcDNZG
 CEVYnmvXWL+tU3DRV51UcJyBknCGGI9ry2h6cT/BascdJyufk4IusLT18S4e+TMg3kZL
 eskk0z8Kt8UJ2wcNPZmD1fioUH2Y6RCT0pN/DpHIxU9C/byxn6GugmO2Bdv2sJxh9ih9
 apLOO4thN+kD+rfxCsHBAsAxuCOy4cs1rRxyZvB/m9RhntxU7QWFzk2fimAROch/ZHQH
 BVHWnhHm2IaaQhgSYs0cFScFlDu48dAy+6SMdZyxZVnoFNUWGHqG3gddsUUKL9D6RJx+
 OpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738962425; x=1739567225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vn1shkzQyA8tl35At/zndAM9YWk74Q9p22uLELQ70Wg=;
 b=YZZ1ARIY00v5k1BJGbFIuqTb1BOVsNnDhuy7ctSwO+CpL+NAs4y6ERoWAl1A7BMwrQ
 5X3nAo3Sqp8tVC/fvXT09+liS1K/6YeAv4EaxkFqPh2TA6ijxV41dTAYP+3CvmY1ylJ4
 taiITADf5ZQTSH7nbl9nOP28+KxPl/RTWzmsLaXK0JHvd9GnTzzIWbOzGlE5uFEMaxEy
 bcq4MUFlClylDbGrUUQ1TKeVgaLRXPCAFhaQYAPW2Zql+1KR8gSCkUDBo/B68YF3HvJB
 Pn4Pj6W1mYf6R+g+m43fFfNc8FnwtETxvCGveybcJw3+pK665nA7Rf1naIVsJ5/Ih/3T
 bBOw==
X-Gm-Message-State: AOJu0Yxe2Nra8NxWwyz6fzZcT7Gc6faJ7EQBE/vN79bA4JW8F4fAuC43
 bTYa0thNoTAHyQPmZA/mr9IixHe69rjC31KQVETQ7oCBVB5sinGUTD3mpyB0Onw0xdA97uZ5fs9
 d
X-Gm-Gg: ASbGncverfoWmecypaXLcibUa68PsI0j6dP4bPACBHBvkIY3+nA0jw0FdwAlQj3Bffl
 Dd1pYRPMoshlkPeXTxjeSj4FS5Luv9YuPVBlP9yLRSRHsEigFVN9mjjpBUXECqPCEOHelpAU4dA
 sDJJ3dX7FG8IB5ktONXgVp/HytH2JxcrMDKFtPtbL4zRhJa2iR6coEsNE3kGSvvFRG9e1zJzpii
 PPXtIqIU3URPD9JAM2Qq6eUIrBo5+FQRpurPBEzGvcCBg1Uvpeh+73qBq9LFBjbTT9lC3JUZnSW
 vWTI6PVL98c/4NjEg3WulOS4Q93X7R6dCoZW19BmB/LRe3U=
X-Google-Smtp-Source: AGHT+IFuOOqaK16eGxCxAjt9PgXL18JjtlcNaSMiaEWwCTYXIffJ371e/T8P7h+a5XxJn7RDc4Ug/g==
X-Received: by 2002:a05:6a00:4215:b0:725:b201:2353 with SMTP id
 d2e1a72fcca58-7305d480700mr7451603b3a.13.1738962424864; 
 Fri, 07 Feb 2025 13:07:04 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af64c1dsm3539043a12.52.2025.02.07.13.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 13:07:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v4 8/9] meson: Disallow 64-bit on 32-bit emulation
Date: Fri,  7 Feb 2025 13:06:54 -0800
Message-ID: <20250207210655.16717-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207210655.16717-1-richard.henderson@linaro.org>
References: <20250207210655.16717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For system mode, we can rarely support the amount of RAM that
the guest requires. TCG emulation is restricted to round-robin
mode, which solves many of the atomicity issues, but not those
associated with virtio.  In any case, round-robin does nothing
to help the speed of emulation.

For user mode, most emulation does not succeed at all.  Most
of the time we cannot even load 64-bit non-PIE binaries due
to lack of a 64-bit address space.  Threads are run in
parallel, not round-robin, which means that atomicity
is not handled.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 85317cd63f..ec51827f40 100644
--- a/meson.build
+++ b/meson.build
@@ -3185,6 +3185,9 @@ if host_os == 'windows'
   endif
 endif
 
+# Detect host pointer size for the target configuration loop.
+host_long_bits = cc.sizeof('void *') * 8
+
 ########################
 # Target configuration #
 ########################
@@ -3277,8 +3280,14 @@ foreach target : target_dirs
     }
   endif
 
+  config_target += keyval.load('configs/targets' / target + '.mak')
+
   target_kconfig = []
   foreach sym: accelerators
+    # Disallow 64-bit on 32-bit emulation and virtualization
+    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
+      continue
+    endif
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
       config_all_accel += { sym: 'y' }
@@ -3292,9 +3301,6 @@ foreach target : target_dirs
     error('No accelerator available for target @0@'.format(target))
   endif
 
-  config_target += keyval.load('configs/targets' / target + '.mak')
-  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
-
   if 'TARGET_NEED_FDT' in config_target and not fdt.found()
     if default_targets
       warning('Disabling ' + target + ' due to missing libfdt')
@@ -3307,6 +3313,7 @@ foreach target : target_dirs
   actual_target_dirs += target
 
   # Add default keys
+  config_target += { 'TARGET_' + config_target['TARGET_ARCH'].to_upper(): 'y' }
   if 'TARGET_BASE_ARCH' not in config_target
     config_target += {'TARGET_BASE_ARCH': config_target['TARGET_ARCH']}
   endif
-- 
2.43.0



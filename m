Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BA4F31E26
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAqGu-0003Nd-EY; Thu, 09 Apr 2026 10:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAqGn-0003Md-Fz
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:22:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAqGl-0003AS-TV
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:22:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488c21c636dso5748615e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775744526; x=1776349326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/+7Bj8ldsjqzb2+6rLdLpbTAiNwT8MkgbfOWGkcJ7k=;
 b=aV4HDEq9jxUAQyemc9PIftsbkieqGJkmoelmDA4bkcPR0O3FveP84cHnOQNY4DoUxj
 ARO52QBy3GsHB5ERR1hhG+Al4cOdK5bO48/ezphLOeCu6/Jux0OPcPC0sQFe1RRWCkMr
 1+wcBU4joIw3vvri95HZUYkmP1E2fVU05EVQt65EABpxsapsgwYkJU6NMajpLF5eR/3j
 Fm+IWbYvxVZGliQpkgYUpX8EfCImCX7AD2sN5TBpnHqInaoH9crLZBcTweRhe8H5WWoQ
 vBArZhzPNdbicNgMh3W4IbWlNrb701GkNgqcVD19rCDnvgDH+dO2BLAI/VCDhlXfMj+d
 lWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775744526; x=1776349326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L/+7Bj8ldsjqzb2+6rLdLpbTAiNwT8MkgbfOWGkcJ7k=;
 b=HAnKL5hwR5UKEhufH0mOg1sZ9iLAcu0QLiP804r/mASxckKz2tBT7THtIYzM52fbW1
 WnoaFNxjg8gBTRqkECjYn247V4E3Jb66rgCAKV1llIWpMfR3xYu9yTRPUc9GojtCyZp8
 EsiuseGC2E1IrODYPoLlJQOtEihAtS3jK1tR+5uTYICXemDYl2GSbuAkOSFg/8rAppV0
 fkYk6iUEjXz0gpBSl0evnX0W5+8FDKGectzCJd5RPz0pAr+lx1O+sHgw8N9izNbodxe4
 PNQDUebUa6NWp1lRgGTs83VTVBD1hi/9eoRx+vypr2Q50Z11c2XWW8dpNtXtqExCMbjv
 YyyQ==
X-Gm-Message-State: AOJu0Yyp1QCf2UmBOSXslIkxq9xnvyYk86+FnFo9xKcLEUfc6M+MHYq/
 PFG82rOKJQfZ831aQ3W8BxEHOOFUKMvuD55nrPSCxTISb/RaD7mXGH82ZEjjbvhZFv2YALfQ4+w
 dOVQ2whM=
X-Gm-Gg: AeBDieuXzpc6LYatezoJn4uelLBtz09H7yT2/XShdch3Rz+qIi2KH106QQVCkoX114a
 4BFwjK69ViMciPD47xCknUR2a5V57Yl1Jw/k0kRtK7soTr+FN4AF9HLi1zTR5OvcdgZ+KrxIzJ6
 WDOIABj33ipYVWVnt8YUGPQLeM81l1R/y4CNWK7LD6TeLmabNt+HZq/xVzdLXLn27Tx/OawPNYr
 27DYaCjsGBSz5g/NDNTW8dwKa+iUJZ5aNfwiFb34XXhcSQS+AJi6WYbT0Ivvbg0nCXvDJUnTvM1
 Ky2Z65Rj3HIKSu3xGscgrgqGD4QsB3+UVJ8vxhjVc5AOZ++rjuCULwQ/LF+vimA20EU5EJAnMTs
 7OZP00cZCAqWYP78WOetJ04S9X77sUu/5U+4efLOkSsR4X9Sy4DW7naRBbqOwCW5QcZ1uL8sv2e
 5Ne38402je1/slKpeyMXYc7/2TWspTbbfl6TJHYmxiON97CGchAhCxPRJ9EXFtv1GvuuYmaK4j
X-Received: by 2002:a05:600c:6305:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-4889978c561mr345190425e9.14.1775744525849; 
 Thu, 09 Apr 2026 07:22:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd2492e8sm77222315e9.15.2026.04.09.07.22.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 07:22:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/4] qemu-keymap: fix altgr modifier lookup for newer
 xkeyboard-config
Date: Thu,  9 Apr 2026 16:21:36 +0200
Message-ID: <20260409142137.58349-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409142137.58349-1-philmd@linaro.org>
References: <20260409142137.58349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Dietmar Maurer <dietmar@proxmox.com>

xkeyboard-config 2.37 removed the "AltGr" virtual modifier in favor
of mapping upper groups directly to Mod5. Since then,
xkb_keymap_mod_get_index(map, "AltGr") returns XKB_MOD_INVALID, so
AltGr-based keysyms were never generated.

See: https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/473f9bc32f9ba869829cc0d06a75cd1f2560aa60

Try "AltGr" first, and fall back to "Mod5" for compatibility with
both old and new xkeyboard-config versions.

Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260408091459.4001711-1-dietmar@proxmox.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qemu-keymap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 1c081db2870..d4dccf456ef 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -230,6 +230,9 @@ int main(int argc, char *argv[])
     shift = get_mod(map, "Shift");
     ctrl = get_mod(map, "Control");
     altgr = get_mod(map, "AltGr");
+    if (!altgr) {
+        altgr = get_mod(map, "Mod5");
+    }
     numlock = get_mod(map, "NumLock");
 
     state = xkb_state_new(map);
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9422CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DPV-0002LY-Du; Fri, 10 Oct 2025 09:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DPB-0002Gy-Bb
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7DOl-0007wl-VF
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:43:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso11681465e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760103776; x=1760708576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgHI5TW5wRLub5UB51c3C5+CkIARcYS3PKLqV1Iqios=;
 b=IltQhRWvYpt0+OGIqM6wz4NAEs6czEH0QA7n9e6vNbdyJdS25vfx1dvxYbS4VBSwRk
 /Pq+je/jX3L/CGq5Ahbb/PSS6+Ixa4p+mNqJ74PlVlVP1F+mXK/Dkzi5mxTUVIvjWOYJ
 8mXe7koqfUyBeor9Hhl2W1GvA4CJKrQurjpz9iMuJ9fzzkWOg1MJS854n3r0n6J85kn7
 z6xn0AcMvUNOx9Y87v0zqL2EovQYvSs54n3wzuDIvp5W+78TojN72qWx9focgSAeuZ3/
 1/GeK2QcvIGnA3Oe2H6sR1nEJrgd5GjEDA2bj+KYPRYnlXZ0IjSaEYPxVvy+39TNC2cl
 dFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760103776; x=1760708576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgHI5TW5wRLub5UB51c3C5+CkIARcYS3PKLqV1Iqios=;
 b=jeoP7Y6/vQJ/jQyDjri4YkNhFLdn2cJtTcoiE8ubhSF4Ud9hnmA25yDbCTs9rmzaT3
 dIw3f8lewfnEKcD+2KpG+PLBhU2qNBrAPrgTAZKM4jDyEhhbf5AjEK93XyyISGCm3URN
 DkOOLQucXldYzgXQgzeCLNg95fo1f0Ztzz0XMTK5NUA1/g/uw2mgNBVMauaV1rkDVFeg
 ZO/DaEvACSs2B3xukS8TYW29DWX8gaLzVZ/ZZTYY6vok2wK4Gd3PBc5MkQCAHkNlYGt5
 reQRyKfP63Eb7AipZAWz5StttpWRLfTQSm3i0PtIrKwHZvLl9qAMLaqyqCBKyyGIS2El
 YeIQ==
X-Gm-Message-State: AOJu0YyvWMaAk3TLugSHPM2RnpSa+k9/eHRQEQPQs6IEpfeugK+9Ybk/
 olkuY5QwX3OajuaUoEwMAck5udfCOW9LYSPtF00wn24QUVDZ2+w9BLTnalfYypnEDqR9KWm1r/+
 KM2KgYFvEhQ==
X-Gm-Gg: ASbGncs0C/Zu/lZ9n1gNFq9YnB8BpYSiJYZcw/53wFBqCsQz57j6DNopRn+JvNKETxT
 s1l0HEO4onU0w3bRLuZDJQCBbtWkLbjxhjj8gf4YSaqQ87i56botIbehhZs9llLS8NZs1fkLMOJ
 XmDzpM0ctGxoG7MGeNp2FtoT+BtRcHwq04Hq/A9KuWeJ5NG0MzdeuRTemwGMnMzu3V080cwXRLY
 TSSumIW+FC+f0/d1QKGGw547t3U0ZoM4Wc19irV0r9NsqhLjX1EhFy5xRyX6g2Dd613byA5u9c1
 K2ZbjL/pTEHTV2hzXXbm3gTqRrkZhXxr/XElw/W2dpAEaJ9F7eFVZsFKdch6/xNoEnxa+qDckL2
 9G7f+hhcbE2MxtYvbQ9qXM6xeoiwjQ4m0f0HldoIZtQHldanWItSVDiOnOm8ouYh63V17Lb9Avj
 uncbc0ctGYkLOx7Off3mY=
X-Google-Smtp-Source: AGHT+IGJIe3UiNIYTyhOEp3oDaTG0ipq8utQ5sMTJPXtgT8ePs3zSizNPMCFuwtMpE4+/UxIGkxGWw==
X-Received: by 2002:a05:600c:1d18:b0:46e:3901:4a25 with SMTP id
 5b1f17b1804b1-46fa9aef67bmr77368985e9.20.1760103775971; 
 Fri, 10 Oct 2025 06:42:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3703adsm59917755e9.0.2025.10.10.06.42.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 06:42:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/16] disas: Replace HOST_BIG_ENDIAN #ifdef with runtime if()
 check
Date: Fri, 10 Oct 2025 15:42:14 +0200
Message-ID: <20251010134226.72221-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134226.72221-1-philmd@linaro.org>
References: <20251010134226.72221-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Replace compile-time #ifdef with a runtime check to ensure all code
paths are built and tested. This reduces build-time configuration
complexity and improves maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 disas/disas-host.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/disas/disas-host.c b/disas/disas-host.c
index 8146fafe804..54be5ef18e4 100644
--- a/disas/disas-host.c
+++ b/disas/disas-host.c
@@ -37,11 +37,7 @@ static void initialize_debug_host(CPUDebug *s)
 
     s->info.read_memory_func = host_read_memory;
     s->info.print_address_func = host_print_address;
-#if HOST_BIG_ENDIAN
-    s->info.endian = BFD_ENDIAN_BIG;
-#else
-    s->info.endian = BFD_ENDIAN_LITTLE;
-#endif
+    s->info.endian = HOST_BIG_ENDIAN ? BFD_ENDIAN_BIG : BFD_ENDIAN_LITTLE;
 #if defined(CONFIG_TCG_INTERPRETER)
     s->info.print_insn = print_insn_tci;
 #elif defined(__i386__)
-- 
2.51.0



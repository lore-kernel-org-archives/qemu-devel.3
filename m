Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415A2CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 16:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Sg0-0003X0-Vm; Wed, 24 Sep 2025 12:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1Sfh-0003UD-Tl
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:48:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1SfR-0002Gr-St
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 12:48:45 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso81858f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758732506; x=1759337306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6tq+nh+sntqWd0fpK0kG+Pk2Y1l1ft3wDBnlkiBKn/0=;
 b=X3fvmQCt5UiRMJppsvwrqXl1uVQMoKZRbDo9h9IdAdO2j/MvkzKb8kGX0rr4188Zy2
 1oaYkEDi1WstQqVzXVRCB2woXVk81vJN5qNEzm7mYsolNZ2YZU4Iy63VALrAww7zUXZO
 AuU+J4pF2clS7Ir82l4+L4SXcYaw8YyBARZcgypVjTZQDm7Fqa78uBq5nvof/2qe7gCn
 OgmxZYE4olzFINkHsFhoXSk5fqX4MXFYAmCgM0pA9FpF3WHfqphuBnNNJG9E2LIWBJtQ
 /spogrnnFKP8OmEU+NMNv0Db98AsmfvWX0En2GVsNswytipBIcNZw+O4b89yUs4CdwwP
 RRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732506; x=1759337306;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6tq+nh+sntqWd0fpK0kG+Pk2Y1l1ft3wDBnlkiBKn/0=;
 b=SxXsStBH3mFufmJAPARNM3ctt3NJ35zzxu0J7M40YKFsWwrKR0KaQ2C98ST/IwFgnq
 bgvHDluZq4qGGLS2iZCHhIpnWE+Ffc04n8U8dTRLWGEjgT094US0Vo4uYazUavudJJN8
 bQnDDzdmiUhNQZwrDFZR7pnxMRlSDbTlc84jMSP6HMIFTHVTc1Plk8iZK+T1MyqP3g8Z
 x8MtXK7XDEFeYZ5Q6XwAnqNVyGWS8DUiKAxpaDPht8+RIPa4xCqvUtYQr8hmgYlE3qCq
 DvDkibSqVyXD/6MenCEFl8TCuE0ILlODAFuzT5NshsHLLgbcc0iLmnBgFwk80bwGk2o1
 kNIg==
X-Gm-Message-State: AOJu0YwlWdGvk6F0rfMQ1PTeHaZ0RXsVYLVA08K1rj9hH2P3IKEaBNfC
 2TpmW0zZsvgJw+/18UpuKEfvewHY7OPoFSkjk3G/SWlB/Xm12r2a6v2FquQ7v53PltGkeWA+rwS
 7hQmB5GYxHQ==
X-Gm-Gg: ASbGncu6mWu2EMt0vGB2ttAa41gR/96lKTIKRbpx94lLiMMbpRKZ702INiXoZYIUcL+
 aNvdsavKMwceH2EcdLzNagWz8zGAf8ABYLEzl1RALxNJ43XWJokCxa8nz6rnixmPIVvpE8tWDge
 6ciYJ+co2/Fw1sLZTOPWnHQOS5TBYgDrzN1h7xL4pujuVwrFB/Rz9hXhnarcsoq5y0GuPlaYEy9
 qTX/hR93TCnhZH5zK1B5VyJx8QEsiHYSfVx/yLTV2+SpiR7kDC6fP1ZvlYIw24NsKZ+aSa1Y85m
 mzFhzDU7W9S1e6k6+ubkgtSMBbOD1OMiwxOvu8ERZUp7IWxJayI2SqPg7Ck6k/j/Q+D+ZsaRQ9c
 uEL4oFv7SmbCCdv+XYmqok9OrTuldOE5X7Of7Ij2mO2GALaxqyR3Bqr++MCDnnvZtcfx8fHhM
X-Google-Smtp-Source: AGHT+IH/0bwxYTtx9LRrDU0RcVuRrO63nckCq2bfq7KHlk2EeHcGGjqRceMWmjq6ZDT3K7ure7Sd8Q==
X-Received: by 2002:a05:6000:2c01:b0:407:23f7:22 with SMTP id
 ffacd0b85a97d-40e42502e8fmr502213f8f.9.1758732506394; 
 Wed, 24 Sep 2025 09:48:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f829e01a15sm17167400f8f.57.2025.09.24.09.48.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 09:48:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel/tcg: Remove dead mmap_unlock() call in
 invalidate_phys_page_range
Date: Wed, 24 Sep 2025 18:48:24 +0200
Message-ID: <20250924164824.51971-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Since commit a97d5d2c8be ("accel/tcg: Use interval tree for TBs in
user-only mode") this code is guarded with #ifdef'ry and only build
for system emulation where mmap_unlock() is meaningless. Remove the
call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tb-maint.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0048316f99a..913dbea6d24 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1154,7 +1154,6 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
         cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
-        mmap_unlock();
         cpu_loop_exit_noexc(cpu);
     }
 }
-- 
2.51.0



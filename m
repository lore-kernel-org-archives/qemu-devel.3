Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41DDCAC5B1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Uqs-0002wG-L4; Wed, 24 Sep 2025 15:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmD-000726-Nw
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:44 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UkC-0007wC-IG
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:40 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-33226dc4fc9so196508a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740491; x=1759345291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWpjv9GI/QcYKrSXjmbz+gtPiqHOCxvaKaD3QdcWnls=;
 b=J6UXil8crpJc7TvE4CwIEJoOn5aSFzG0Rqk9qMlE3V3j2fV5llfqTVnEU1DFgGFOxs
 rbjyukRAhTdJjv/BxOF/Eul7bYcoW7QZM3In5IIaHbWcfyF4d1B5A0mqAgX1eyeFgK6u
 ewarpT4ZF9A9a7TwCTkkc5MUc1qWYlCOc/0xvBfdHorxKSb9FDUFF26TTyvaEAUl+a1z
 lV3Y034/DPAjjQgAutBAHl/b6YZQPDeg2s5bnpeJpnI7Y+NQKjp7YDndIS/lP8tC/OQ7
 q85ySuFZt15jKgn2qNqgMRP/gzKilUVsZeQbZoJYZrEl4z2a3wqMK3QVpn2OaYF4M2+G
 fpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740491; x=1759345291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWpjv9GI/QcYKrSXjmbz+gtPiqHOCxvaKaD3QdcWnls=;
 b=lsIX3opvTJwsAcmWwDZwPUcF6zV14p4PIcz78zNsaJVq1ndZPS9TnA725CgiNMpCFY
 tDmgBvxRTdKr/QPBCDu9gJ3JMrmVXRbZdt4cfgJcVssrIhDZLs8Qid8WqoA3pJEi0c16
 vex0w15cavqAVXHPy5XT3ixPEIQuE8jCizDG98kF0O58vPh8myWRIA0ksIF1QsMxLuoF
 d6TDAKA30X/l3KUeRVftAfnin5M1kEQwl1PJHqAQByP3/z3Gw/h3/HCgpBLtCd0YBPuF
 nbo4GnDcVJqm6GaUWh8no4NuR62bAgsANbNtfXbPFhEvvojgI5sW+yQQeuBFMMElZiY1
 ptDA==
X-Gm-Message-State: AOJu0YwUBhXiuL5GebJ8BiQZ2p9V7lox1iQG+sXgTVPltvv5TZKyX4ka
 6pc45e4ua5AoFWi7+t/CNiUbvhuZI5kh4vBHv7OsVwM0cez3W6g+aVnhyEPIAXRiS6wiLulPiSV
 fwznc
X-Gm-Gg: ASbGncsro4YMrBwRrJYNAr+xjOQwpXKaSycoxVe4k32e1J9/GovIEMgWaVItLQMXb7j
 fpZ9lRj1qvz4PdL4P1QPV+ZCEFKR3MPPkhnAI0KGb9wv1NTAUxXG4m7EC88uwKOpxehEPVej0DR
 NJfA90oxDzNF+OINiGMx0kQnbzZ1SG4xDerDmls3zIur1KjN+ioq09SBURa7ugZrAiyB6rrRzDD
 UTuDwuojlsrCN1oqeqde0HeDNFFzaRsmz/NVGXg+KFNegR3uAE27452n67G90NNiqKhij5qD7U4
 5r+wDOrftUK34aTPXzi7+mbu/0ewyRFrOdtM4x3JkyPNeRqxL1V8hLhHArxjvllH2hSEvblOgs+
 H9yucedtivnQX+2jHj6gDxetflMnT
X-Google-Smtp-Source: AGHT+IH4t1l1FxD7en8CT8OaB7noklm8NxOja7qPpYc1iibcr5gEjxntXMYJvMW33xP7b+eyuOX+0w==
X-Received: by 2002:a17:90b:2249:b0:32e:59e7:c37f with SMTP id
 98e67ed59e1d1-3342a24778bmr957160a91.12.1758740490760; 
 Wed, 24 Sep 2025 12:01:30 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/32] accel/tcg: Remove dead mmap_unlock() call in
 invalidate_phys_page_range
Date: Wed, 24 Sep 2025 12:01:04 -0700
Message-ID: <20250924190106.7089-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit a97d5d2c8be ("accel/tcg: Use interval tree for TBs in
user-only mode") this code is guarded with #ifdef'ry and only build
for system emulation where mmap_unlock() is meaningless. Remove the
call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250924164824.51971-1-philmd@linaro.org>
---
 accel/tcg/tb-maint.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index c45fd42366..5a8d0784e7 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1168,7 +1168,6 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
         cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
-        mmap_unlock();
         cpu_loop_exit_noexc(cpu);
     }
 }
-- 
2.43.0



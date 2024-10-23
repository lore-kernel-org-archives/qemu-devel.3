Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3CAD2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9a-0007QN-Ku; Tue, 22 Oct 2024 23:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S9B-00071r-4r
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:58 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S95-0008ND-CR
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71ec997ad06so2082910b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654489; x=1730259289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXgRGYLD5DO85xg4FbmPiyGSDoHjlvuvoOOqF/G5VC4=;
 b=Uz4DSpfdGTNQMVZXnWiD6oSS4YRjVRrZC9mvhRZFws8yEOPekN80/97wSl0aLUrGjC
 Bt/1bt6NaqjXxIq5QILqWAwH1A+4atQrg2AkHg35rz6icDlPGPQfbjrEWW6WBGjolaIN
 qUZz6ocAWZbSDzmNASwtCRCrKJXo8dykDAdAKhBEA1Gxvm4k26RUiSb5pBSU8s+G8i7D
 WE7V8VeVhZZc36oVQAhatvqQk+kjOCfUGVS2mNbslejid/eGtD31Z8eOatS/hbyXo8TT
 XHD69+MODMfgYv2whaFvJVrqr9Als/L0z4h+EYie7O+3CboafgjAcCkY9NV5/wmsRTm0
 W3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654489; x=1730259289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXgRGYLD5DO85xg4FbmPiyGSDoHjlvuvoOOqF/G5VC4=;
 b=QIP5Lfxw4qqdfPKkbqNwPwyTw6Rqiz7GCCPJrlkfk9EjGKHsaQEDyFpILv8KVTe3bG
 MoQ1wLPLrSyuYe98oQ/OgR0rNefQtU3f+47GLhzpROCZm5HW3jAYCQdAKL466Hs6E20N
 fPiUFSGSq6O9X3EMK6/eEVYDe8HZ029xbSRWCeQJXbsSsFh07X8PKEe8KloZTWra7oZT
 zIJvTRW/euubkPSmPgVh9R6HPT0HgfAIwh2umd47Neai+5J2AoVVhwlJqDZd1KPARUpM
 RqWfp9qDeVDlUoDZED9voSQ5klJXRSyO9ukAHXMIrfHYIAi09soY59SZVi/IwL56JsrJ
 6A1A==
X-Gm-Message-State: AOJu0YynEp35jQ0ov8Qihd4afni6Tvv8ddid3EOzjO3DKjKiDPXeZ1dJ
 xIiomhBDmPHcwZRbhEuN2R2iauZK1IJUbZTbklvCDIVdeSaBB7oVVCY/IUrmoNehaGgcDpiUdmI
 n
X-Google-Smtp-Source: AGHT+IGcchl4cEFESDFvUj8YQkHFBzh/eVg0X6YCuIgE1us0fMVexFuxLsZa5h+JqwTP0FEe2KdHvQ==
X-Received: by 2002:a05:6a00:180a:b0:71d:feb7:37f4 with SMTP id
 d2e1a72fcca58-72030a0853amr1991789b3a.6.1729654489436; 
 Tue, 22 Oct 2024 20:34:49 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 20/24] linux-user: Emulate /proc/self/maps under mmap_lock
Date: Tue, 22 Oct 2024 20:34:28 -0700
Message-ID: <20241023033432.1353830-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

If one thread modifies the mappings and another thread prints them,
a situation may occur that the printer thread sees a guest mapping
without a corresponding host mapping, leading to a crash in
open_self_maps_2().

Cc: qemu-stable@nongnu.org
Fixes: 7b7a3366e142 ("linux-user: Use walk_memory_regions for open_self_maps")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241014203441.387560-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1354e75694..dd2ec0712b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8151,17 +8151,19 @@ static int open_self_maps_1(CPUArchState *env, int fd, bool smaps)
 {
     struct open_self_maps_data d = {
         .ts = get_task_state(env_cpu(env)),
-        .host_maps = read_self_maps(),
         .fd = fd,
         .smaps = smaps
     };
 
+    mmap_lock();
+    d.host_maps = read_self_maps();
     if (d.host_maps) {
         walk_memory_regions(&d, open_self_maps_2);
         free_self_maps(d.host_maps);
     } else {
         walk_memory_regions(&d, open_self_maps_3);
     }
+    mmap_unlock();
     return 0;
 }
 
-- 
2.43.0



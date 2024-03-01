Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1869EC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByV-0006Ae-88; Fri, 01 Mar 2024 18:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByH-0005j0-Tc
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:18 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByF-0004OF-AN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:16 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc5d0162bcso25439775ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334434; x=1709939234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJy5WaQ99ApNqzP+t8EteVWeLJYZZHFF49xziucGjOo=;
 b=lyCLax+gDlGPVfi3jiwndKhyvqSEaQNDyT6MpvMaf6R5A9EQ79GY1vWRXmz7tA9Bzv
 itvC19UUjduovvpof7FfQX0gzJLIlwauZVJSDmR5vvlt3ya2j4d5tQL4zls4xID6gSsQ
 d3kDeuJW8LEHNsODtnbg6XRGmkY/Q8AQPWLVnG5q5bVCtqBucNpUCsNnC8dnWQ4OrUZi
 ynBiWUXPOjOyoqCBpS5uN+Jg0OOIt2J08FIEiucR7G+EhpiErPmAYq2pb40uUv2BVAr1
 A6edzkZm0zJNImJnTLos9BXn7EwQxC5QbGvLhfPcR56RNq2e2zdKibJmLHT806qLoQqD
 6MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334434; x=1709939234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJy5WaQ99ApNqzP+t8EteVWeLJYZZHFF49xziucGjOo=;
 b=dPiAxLkXfZiF1OZZQ/FNqU1Z/gRaT16+VkAiHzg0q0hBXFPr5ISfFinFFnQT/uJ88Q
 baa0YwkvW+v+SUREinLzuuYS2dhSFf+0GXGWpCUtCf0suM4k0SMN/a4fxhXlj5Qb+7k3
 JwHVsEf6MuXTvmsHNkwq1XLwZnY6FXP21VLwTpvIaQ87ugTj+yM5rETVfu97oE6GeRRv
 i8JeoQgWJD+aXEgXLAHzhNd/m9JIpBxo5Q0UpGHSVZl5Vmx/Ng5tP+vm33oiZ9M/bNHr
 srgZrpyNVpYZygL8JS/hiQksDSmAhBPXioo1spsV4YfG5hmJAU9hJkWdbkAJT/+4FuHH
 0qfw==
X-Gm-Message-State: AOJu0YwNHyR4rUdNABcSGXrKLyfEsmgP3L+DwwC7Dr0gNWgwoeVZF6RO
 CL3GRdPfdqYnQNFdQJCeBs0ERos4Ur40iRjzkMg3U/4wi41FnxwJE6BdmU3S0C3Uo6180lEy3BG
 i
X-Google-Smtp-Source: AGHT+IGFOVjojGScGl9/Qj1VBUMqB6hzZDoW+bEpMtjcv2ox1glFNGXJpMrTTtOlD2UYaOMYk36QWA==
X-Received: by 2002:a17:903:1251:b0:1dc:f157:51ba with SMTP id
 u17-20020a170903125100b001dcf15751bamr2405471plh.35.1709334434131; 
 Fri, 01 Mar 2024 15:07:14 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 36/60] linux-user: Fix sub-host-page mmap
Date: Fri,  1 Mar 2024 13:05:55 -1000
Message-Id: <20240301230619.661008-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We cannot skip over the_end1 to the_end, because we fail to
record the validity of the guest page with the interval tree.
Remove "the_end" and rename "the_end1" to "the_end".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-19-richard.henderson@linaro.org>
---
 linux-user/mmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index fbaea832c5..48fcdd4a32 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -643,7 +643,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
                                target_prot, flags, fd, offset)) {
                     return -1;
                 }
-                goto the_end1;
+                goto the_end;
             }
             if (!mmap_frag(real_start, start,
                            real_start + host_page_size - 1,
@@ -690,7 +690,7 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
             passthrough_last = real_last;
         }
     }
- the_end1:
+ the_end:
     if (flags & MAP_ANONYMOUS) {
         page_flags |= PAGE_ANON;
     }
@@ -708,7 +708,6 @@ static abi_long target_mmap__locked(abi_ulong start, abi_ulong len,
         }
     }
     shm_region_rm_complete(start, last);
- the_end:
     trace_target_mmap_complete(start);
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         FILE *f = qemu_log_trylock();
-- 
2.34.1



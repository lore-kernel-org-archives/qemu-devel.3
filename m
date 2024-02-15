Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4047C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV73-0002MJ-T1; Thu, 15 Feb 2024 01:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6w-0002KC-PK
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:43 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6v-0005U5-7d
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:42 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso4049215ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978040; x=1708582840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wG9KSOs67vbPNFTw70Lf+VF+Rn5tDSL+goWS2BCj7Lk=;
 b=kXTSRTuI6o2qStHv1sX7oBbUcD3km1U2ZKlxRiJXf+TJ7o28pZ9Sg0OT1+poWJH6I4
 ZvwBVYE2LtO3SDU+C5EmaMsXjsD9BONrylWEp65XdLoaM+CP8hm3zj0bWCr7YF3OEiwk
 2cmEazCVd9VDhuwk52/hV2kfe6l7Ds5U6GFMRm0NHJnlJQgZtnu2r9E9VpkLE4XYMB1K
 Qx5w9aNl2M2dsraGoPtRB9Tn7z20W69yAmwrAsKnilYd9KDBuVOVbJBomC2z6Jkm0Yk6
 JE7rQSvarkiMmXAXFeC41VmKVZKJkBv/Plrloy/dbiOPx1pDsojHxhVrEOK3Q/BzBjqU
 IE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978040; x=1708582840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wG9KSOs67vbPNFTw70Lf+VF+Rn5tDSL+goWS2BCj7Lk=;
 b=E++tJJCE5u3wrKxmqLXiAThuLfVyWZjrGdzJv/bLdQtUv2FuOvOJm9MsSJUsrFj/Ts
 dHn42Lt+z0uYymaGDTrv9raj+zLN1BaMeYMjvl8r7t7Gc2QjoDrYmSVF+Eox3Mlrhqai
 AmP97wmDYUDm8U0g0tjHUEd4ddRk+ok1Dt+wbyo4Aa6wqzGSZESPmc9VET/XWbK84A8R
 HRGpgbjOF44BAQXcvhYxIEZAF/6WaEZtwXgfGThpZulOcVh5WZbAY4w8+gnLK7BOYx9/
 7GmNpQgWiSj913dNOxgSpHmPLC/SfWDMJdieXF2+6MKVlJlTiAmMAvD44Da+fjUWjPtf
 AfZg==
X-Gm-Message-State: AOJu0Yy2L63zNWBnL8B3WwRuxKC4NjHVrC2AoQDwmBKvACpq9wdrsHMW
 DuIsHBHeUmm+tGpFaPQytzUgF2Zd+PipA24/h8ZpMRiRgYjYiot0SqknxwnJFHesEkWYOQAhH+P
 E
X-Google-Smtp-Source: AGHT+IEFxXMXJqOPeOdZ4wmJgRxi1hXTCwI7yV6NnbxfibDur6HhXWtHGiT8SgN9xz5UmmbQ7uuO7g==
X-Received: by 2002:a17:903:183:b0:1db:6a20:24ca with SMTP id
 z3-20020a170903018300b001db6a2024camr1062036plg.5.1707978039823; 
 Wed, 14 Feb 2024 22:20:39 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 13/36] softmmu/physmem: Remove qemu_host_page_size
Date: Wed, 14 Feb 2024 20:19:55 -1000
Message-Id: <20240215062018.795056-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Use qemu_real_host_page_size() instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-14-richard.henderson@linaro.org>
---
 system/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 5e66d9ae36..508dcb7494 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3515,7 +3515,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
          *    fallocate works on hugepages and shmem
          *    shared anonymous memory requires madvise REMOVE
          */
-        need_madvise = (rb->page_size == qemu_host_page_size);
+        need_madvise = (rb->page_size == qemu_real_host_page_size());
         need_fallocate = rb->fd != -1;
         if (need_fallocate) {
             /* For a file, this causes the area of the file to be zero'd
-- 
2.34.1



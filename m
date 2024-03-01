Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15253C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgByd-0006ZF-MB; Fri, 01 Mar 2024 18:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByW-0006Jg-Rt
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:32 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgByK-0004RP-Cy
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:07:32 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dc29f1956cso23797255ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334439; x=1709939239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5K1zjw+5Oj4rrjx8HADPxYdAwsCVv3T9uofL+YVvOaU=;
 b=CK234zOUflO5hGuofTmOE4SXh0GZ0yenbjYm3JgX2WgnmINR5gqIDVeLytPXr1wf2P
 lwyBw9lwRoHAsdA1mwAJCk9WTktTt4fWvA1CP6Ew3zluZePdQHGE6Ik7wH277nJQrVZW
 v5Bl1UVLHwnZRbhvSRQgv5UjH3QQ8cemmpmFfLz2xILdGBO/CU+rspc4BRbn3esc48QS
 3VI6Ta6aq93jVcM2na3QK2SmpyPZJ9kn6A68NqnVxKuAi4hicuPkHL8plqjnDHRIfNIK
 RYZJEpmlNDTICmRRRunhhGLMi4z4ZOADpWdwqXKcAKfxISXxipeZGjIL38O6n/9RaSbP
 gANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334439; x=1709939239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5K1zjw+5Oj4rrjx8HADPxYdAwsCVv3T9uofL+YVvOaU=;
 b=R6P6PKUfrl3f/1ec0oEqe87TmCD0AWHY7nRIstgRz1sZGpyBdII9al/B8xl5cI27sT
 +Y5PRZkdiNW3l7Kl2hHzeNYgnrLe6tzy5x3qB5ObsToL5dFvs/j4BmoUkEZQBgLv5/0T
 MxgDhym6NpM866nxHEmt+Qm0XIzLuou4SCOdLBiYoK+EHmXvTNWeIw+yX4cXk4F143Ao
 rtaxBSTLqvtMFf3PhzG3DNI4OukmFUgXZHhxKiw5pF6TeDDiXssiSAr3OIM18IHwGiGR
 5y0BBZK6zAl/YGEEdU2gA5Vy8AqSkqDAQehDKzAT93rQseC8BVGty4EQ9FPbCWoe6KxF
 dH9g==
X-Gm-Message-State: AOJu0YwX5e4si6FclzvWss/G4kZWQ5XzF6h21dn2t+cCMr/6/LHpBdcc
 snNiG1a3gHQ8MthrzcMzo3xpNWEVkJ+mYk9TQao0jNPDIlqWVb6OxRtDzDS18g05ds11TDkbt2c
 i
X-Google-Smtp-Source: AGHT+IFWBNccjFCfvts0qzD5+tdA7EbR8AAlrOq1rqTj1pP43Bv23Z7Loj8hUs53OISSObD+kF2ASg==
X-Received: by 2002:a17:902:d4c8:b0:1db:edb8:35d8 with SMTP id
 o8-20020a170902d4c800b001dbedb835d8mr3636482plg.34.1709334438803; 
 Fri, 01 Mar 2024 15:07:18 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:07:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 39/60] linux-user: Split out do_munmap
Date: Fri,  1 Mar 2024 13:05:58 -1000
Message-Id: <20240301230619.661008-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 1bbfeb25b1..8ebcca4444 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -267,6 +267,21 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
     return ret;
 }
 
+/*
+ * Perform munmap on behalf of the target, with host parameters.
+ * If reserved_va, we must replace the memory reservation.
+ */
+static int do_munmap(void *addr, size_t len)
+{
+    if (reserved_va) {
+        void *ptr = mmap(addr, len, PROT_NONE,
+                         MAP_FIXED | MAP_ANONYMOUS
+                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
+        return ptr == addr ? 0 : -1;
+    }
+    return munmap(addr, len);
+}
+
 /* map an incomplete host page */
 static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
                       int prot, int flags, int fd, off_t offset)
@@ -854,13 +869,7 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
     real_len = real_last - real_start + 1;
     host_start = g2h_untagged(real_start);
 
-    if (reserved_va) {
-        void *ptr = mmap(host_start, real_len, PROT_NONE,
-                         MAP_FIXED | MAP_ANONYMOUS
-                         | MAP_PRIVATE | MAP_NORESERVE, -1, 0);
-        return ptr == host_start ? 0 : -1;
-    }
-    return munmap(host_start, real_len);
+    return do_munmap(host_start, real_len);
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
-- 
2.34.1



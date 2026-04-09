Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D136E98FA6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 03:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAgPW-0000ce-4e; Wed, 08 Apr 2026 23:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAgPU-0000cA-SA
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:50:28 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAgPT-0003rm-6g
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:50:28 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so3094695ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 20:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775706625; x=1776311425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55UsHfoXIZJX5HDmSBm+VBjP3s+ERxMT5nq/26CP9kU=;
 b=RD99PV9g0LzthUwLwTpqqi+Edb8AMRZGCc445XLKwAqC5Z6hi3gI4CD8ZEByUNBdMM
 XJd+Mz2+LqOcNGjwHAdEkOynlbx1qkS8lvzLwICTIHwwpHovV/lK7iSeLhW8vXiPK5Ye
 Y+I+gdgv/kHFb3iZCm2sON9a2QkZHLs0qthqcY5vBXD7NTupzSsLMSAPKQ9ZnS3Zq+/f
 TiuKxAJ8Mlg9VRjK1leWgJoUMf4fMwc67Or4ScJhFZiTWQGz3y4yFfvq7gJCW3cMpnaN
 2ofLmT6ClGSCmo+pqqS6XPYIksGElE9qQcHRTNJxjdcmPtllgUiwP2MQi891+O4x3YKD
 OdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775706625; x=1776311425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=55UsHfoXIZJX5HDmSBm+VBjP3s+ERxMT5nq/26CP9kU=;
 b=o8f2CT7FXhMHa1+6kOLlmwtmehm29USA9JXvQrIj0Uh4Ph/BBxVMTxLWhv0Hy+h8di
 e1HXmSKW9RkgwGWLoRfSVsj4I0fHjGACpCqzAv4q0nyUH0ID9gMq6bRW8IWiFjMahDCr
 s54aqZnQZ48gCRG4vHX/2hYWaCONSGeYKIJwP2tNGWUf/SyELI1Q4G5x1799fLb2IHak
 J5s6pwXwN4qpPHqGWlvwgYYzF2MX6v0Mh1ojtMH6dkygDE1E7xNAUcp12tg/nmwAeWg/
 FLVwYHZK5gKTYAj5rVBkLbbuOWDgTzfCP4mwYKUroeHNCgABp34gkSWQbZDzo2fWJ8Cp
 ItEg==
X-Gm-Message-State: AOJu0YwyS8+IVzUssjefGmnaHZETqPssm7FDrWp0EmQz1ULh6ANDzoTD
 nhAh4iu9zkCMg2kxTkT4VeYZvC9KgHaGYB+IUzvnLpYzzgC3i0gxNuC0OhYSzWq4w5E5ujS1BHV
 JcpMjfsg=
X-Gm-Gg: AeBDiesWnQ3czYtkIuZTdBEvF5aYFRh9DiU0z71mr3NwRyD3cxTZ13ukwCy0hjtqL37
 11AwT4Pu8cVzDDeg4cKjcv/qEZKuIjgO4T2c1Tpz5GY05SAF6L0SrUtvWr3fFh7/Bsfvxd63HIR
 58ceF506+RX3SldBryDKwcIMdLudmc93SToIHqxOTRV/m/KJplBMsWrZqlCDcx0UyfIxoKS32Lc
 nRyGIC/K0axhsmbMRFvsSRPUAga2/yHAUxKU8G4F1movTMwJ+lfIN3/jk3ZINZn2ibhWI17BgHv
 Dr0P5MH82U2u5BFeSg9ne0Izxc/rBUgUc8YTBIbEnBnAhtOoKOWAUYK8fdh72BFwP973OSAVDem
 sjPIeW1vhxyQGHnv1fqij14/YEcoBdp/fiSnz9nUm2QbtQBKRI5w+0PyrHu5jHiP6+MStVP3sh7
 ODGAv0S1a7UoJ+EuHdn3MANoEvB2UbgIUdN2qdiTHKy0bPsxONVHQEynIr
X-Received: by 2002:a17:903:4b28:b0:2b0:52b7:e82 with SMTP id
 d9443c01a7336-2b281867dc8mr217618225ad.16.1775706625521; 
 Wed, 08 Apr 2026 20:50:25 -0700 (PDT)
Received: from stoup.. (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2745c480dsm277830605ad.0.2026.04.08.20.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 20:50:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
Subject: [PATCH v2 1/7] linux-user/arm: Restrict regpairs_aligned
Date: Thu,  9 Apr 2026 13:50:09 +1000
Message-ID: <20260409035015.132370-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409035015.132370-1-richard.henderson@linaro.org>
References: <20260409035015.132370-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

The function regpairs_aligned is for extracting a 64-bit
quantity from a pair of 32-bit registers and does not
apply to AArch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 24d35998f0..e65373b204 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -136,7 +136,7 @@ void print_termios2(void *arg);
 #endif
 
 /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
-#ifdef TARGET_ARM
+#if defined(TARGET_ARM) && !defined(TARGET_AARCH64)
 static inline int regpairs_aligned(CPUArchState *cpu_env, int num)
 {
     return cpu_env->eabi;
-- 
2.43.0



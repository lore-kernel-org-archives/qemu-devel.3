Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C75C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxW-0000QP-G3; Sun, 18 Jan 2026 17:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxO-000060-Bu
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:16 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxM-0001cG-6q
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:14 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a081c163b0so19920105ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774149; x=1769378949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rU1RTCNNq4TKsOcqp8cLlT2o5D/A3g+nlZpIvpHSpXU=;
 b=Zf7PIPMSULXQjbgk1xbz0XHWBGhtHxaE8SXAEvR7GX38f5uXttFcROWlqtKbBuPEZf
 eSHq144BRhKMt9L0pmHy2NRdzOWChIdAltFpZmZFPf9XjW1xGCVKCU3802f8uzI7IGBb
 Bs5GkgaoCrbOqK15eSCTzycwSLNGtj4CMnBBu4DteEGGu42IN/IIMPeEQrlE7xHi8cVD
 ol3NB7CUSsXIGjAaynodcJcCp+ZgceAgRwdR0oayl/728pcRlgqLeIWxkmgZQfcu5UmX
 n1RRum2IP9ZKWtI8tRQrX7bXUosPc6p8nAkFMWqVHYnFrp5Y2NZ1v7xQu3K0nSegMZsY
 46Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774149; x=1769378949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rU1RTCNNq4TKsOcqp8cLlT2o5D/A3g+nlZpIvpHSpXU=;
 b=bdz5duK7f5jz7V8p9aImrWto4WI78EWTmPkR5DkUuPuy27aWRuNjCczFDCPEldsNjU
 Nfoen3V+juxw5O5bR43u1QJDtieBqhnxeI2UdI57jEtEWHBiLFJHZ2AWf0PX9dhPtYyr
 6xFa5E8JtjGUH2CjM9/N2FSteEeRrmc5f1KE2FuTycet6L78lZSH9vkpM46W1njBLRH+
 OOd0BTV25UOK7oI9kia2OgsJmRXJixuts376fpLY2sPa0msGnVdKimOEJjq9eUCXVcol
 bV0klA8mSu1x0aVu6ucw0exBRzQu6IsCkCN1XeyTlwu0+G9wK78go182rTsG9uJLVnki
 gMJA==
X-Gm-Message-State: AOJu0YzFzT/sj9V6ophW/v4KPOwbinAZyA2Tv4pkCKvypvmwVdFOp+20
 OLkNyh5jRWyta6R0fwGwqN8JkNWJarVHg4HKCH0EIOPCyJCInfk3I5KmeJbaT/01ZN+u1E6Ba5u
 u/mSIGzqBYQ==
X-Gm-Gg: AY/fxX5gogD2dD24rvk+Sby6jEOVBB1GmWcsWyD4z0BmnWXWdxdbI2lKeeolILiDNzz
 ZVL+7FryXTMnXryc7WMMxWLVdmu4FHAkJwdRQ4zJZc2a4bXvmTCDudKdFQBbK20hxyEr0vbBM6H
 VksalbZepa+UlY/kdw8Dg5PUyWl3KUzrTEVHtLKqOU1lSS89D5WQNyr2yDAMgGOKhnuXFhBzZfm
 pV+FJHMiddYXnZExWN8N+nNva4/ITWTd/Yg6drs96iPxlWCZ9zLjfEB9KF0lmHl1YKRAOyZ0HSP
 4y2cMom6xQI4md2QR1r8yZ6UUHg3Yv1zDbe9eAN3YEoM2kF2AzVd8m+ogw2fk041PiEKEBh4mJN
 5/JS5kw9v/z/MsCmbEDdOSena9ZgCH36+WjIE+mrkCiQlvUCpvwmida3wEXo76ZGTEVTxJ9zaMP
 uK6N68B9y9mvuHDjbTTg==
X-Received: by 2002:a17:903:1a8b:b0:2a2:d2e8:9f25 with SMTP id
 d9443c01a7336-2a7175cdaacmr85090705ad.33.1768774149382; 
 Sun, 18 Jan 2026 14:09:09 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 45/54] target/hppa: Drop CONFIG_ATOMIC64 test
Date: Mon, 19 Jan 2026 09:04:05 +1100
Message-ID: <20260118220414.8177-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 65faf03cd0..f961046e4c 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -74,7 +74,6 @@ static void atomic_store_mask64(CPUHPPAState *env, target_ulong addr,
                                 uint64_t val, uint64_t mask,
                                 int size, uintptr_t ra)
 {
-#ifdef CONFIG_ATOMIC64
     int mmu_idx = cpu_mmu_index(env_cpu(env), 0);
     uint64_t old, new, cmp, *haddr;
     void *vaddr;
@@ -88,15 +87,12 @@ static void atomic_store_mask64(CPUHPPAState *env, target_ulong addr,
     old = *haddr;
     while (1) {
         new = be32_to_cpu((cpu_to_be32(old) & ~mask) | (val & mask));
-        cmp = qatomic_cmpxchg__nocheck(haddr, old, new);
+        cmp = qatomic_cmpxchg(haddr, old, new);
         if (cmp == old) {
             return;
         }
         old = cmp;
     }
-#else
-    cpu_loop_exit_atomic(env_cpu(env), ra);
-#endif
 }
 
 static void do_stby_b(CPUHPPAState *env, target_ulong addr, target_ulong val,
-- 
2.43.0



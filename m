Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B406C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTc-0000Pg-G4; Thu, 06 Mar 2025 10:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSx-0008VC-V8
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:00 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDSv-0006KZ-3D
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:55 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so7158935e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276131; x=1741880931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vBqWCN5asMJDU7YX+TXWWAjMjDHkesNYFUgdbjXa4FQ=;
 b=sHTDxQxQPjXc9yb4PAYZY3TcCQK9Z56h0FO/Ke8l2jZt1fNyOQNngnH3NJak4hSiez
 B8rLFC6ZrVTXQzKotTVihmle/3H6Ekj+lRv6fk7hFj/xXux+/seGWnhY4y/LmJUTiACC
 DXBXXyNL1rg5UYttFHonoSzKbk40QRNLDeQav5vNEpBUVOCDQwD+Tc+uA+tcduGfSf/b
 vlI8lsfpjWTYWzvPqz2XQoPtpDDSvFyACz6oWAoh//e7XPsZoZaYC/8G/CzTdNzY0c+R
 aO+nMpQ48iRHuLAL2xIUsNtsdKCJMf8LwvExl61VaBYAtCmJ51HAcDqvlU1U5KDZ/dDU
 wwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276131; x=1741880931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBqWCN5asMJDU7YX+TXWWAjMjDHkesNYFUgdbjXa4FQ=;
 b=H0Jl+6VtmyuY6yL0c/2zp9PrPvx7HRZW8ULzvK3/H53pq8neAvnGYk/EwmqQU17Eoh
 l/sU3+38YUr9v9tmy8H8ECDyc08P7f8RxI9XXzOU0fjsrGi6lry1TSEEBqMGtYW74WI2
 HF6s+Abu4vyrhyijnN+mjqVFnnyjkPH/HCHK6EVUzyJLAmN99A41THB2VBOEDLt5C7Bw
 ceoJEt3PkYkyP91nMLDcrNYrpZCuhLB+zNlHNXvBx1nKAjLCA67CBxKljcXQG1oR72Qg
 fwTP5MLH/oa7iwXblKYjkyY2qMMqjaInCEkD5g30X2AbzmaUuQM17QPcNO1yK4RzjMQT
 XiXQ==
X-Gm-Message-State: AOJu0YzTGGCoBDuLnumKeM5+LaCz1taKhNa8of4r/dbks/3baFvJbYAm
 L4oiSmG+ucvSBsMyuarpaHp9ihzEzVAHbWzAcB7NY5Z33owlGypUdjlsMxTzm0g1gvx/6x/BfIs
 +Tvc=
X-Gm-Gg: ASbGnctn0kRLaKuseiEEawv0NHsVS15a2g+ENipqYfhQcUKNcx4DH8V/iRbQch8IxYq
 BgmjPrQAF3ADtLMtCB+kFCTGKCgQnvSnTchkJMcWAedNotlLaDcqmXqoRTlh28PoAFH7lisE+Bo
 vOjdqi1PHtSK9CMzHg2G1hFNlran3aOZuQtiogw5wxL9VONB0E5Sp4MF+4H0AIbAZMKG9Hvhrr5
 LV+SrRxOfi9SlO8qY1FYUXDoi2pyCvJNXiujiSbizO1x4A8OL12J+IOjo6DwMhDTvHNhnxwaeVP
 BAQe5+SrwX+IQQ5Bwx0NtuU3srOEl97rEzDM6lzfxh9VNgdTwevw6R6LAnojyQn6urWl66H+Ch7
 EjDfHKvCGI262sDxivp0=
X-Google-Smtp-Source: AGHT+IHNHylW2x1xoSvNcv4hKXXLsqXgqg3y/D+97YDyrBBz54Zifs1tDtU1oYVH4Y1dMklTcJyglA==
X-Received: by 2002:a05:600c:474b:b0:439:9e13:2dd7 with SMTP id
 5b1f17b1804b1-43bd2948911mr61887925e9.2.1741276130936; 
 Thu, 06 Mar 2025 07:48:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292b06sm53431265e9.14.2025.03.06.07.48.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/54] accel/tcg: Take mmap lock in the whole
 cpu_memory_rw_debug() function
Date: Thu,  6 Mar 2025 16:46:58 +0100
Message-ID: <20250306154737.70886-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Simplify user implementation of cpu_memory_rw_debug() by
taking the mmap lock globally. See commit 87ab2704296
("linux-user: Allow gdbstub to ignore page protection")
for why this lock is necessary.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250217130610.18313-4-philmd@linaro.org>
---
 cpu-target.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 20933bde7d4..b5230ce1837 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -380,6 +380,8 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     int ret = -1;
     int fd = -1;
 
+    mmap_lock();
+
     while (len > 0) {
         page = addr & TARGET_PAGE_MASK;
         l = (page + TARGET_PAGE_SIZE) - addr;
@@ -414,11 +416,9 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                  * be under mmap_lock() in order to prevent the creation of
                  * another TranslationBlock in between.
                  */
-                mmap_lock();
                 tb_invalidate_phys_range(addr, addr + l - 1);
                 written = pwrite(fd, buf, l,
                                  (off_t)(uintptr_t)g2h_untagged(addr));
-                mmap_unlock();
                 if (written != l) {
                     goto out_close;
                 }
@@ -454,6 +454,8 @@ out_close:
         close(fd);
     }
 out:
+    mmap_unlock();
+
     return ret;
 }
 #endif
-- 
2.47.1



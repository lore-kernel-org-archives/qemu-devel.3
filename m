Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74288CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4T-00033O-U3; Tue, 16 Sep 2025 14:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4R-0002yL-7y
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4O-0001Zv-IY
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45f2fa8a1adso1012455e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045983; x=1758650783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=048D1PM0KI7bmfl5+HZw1hE5YzcYQNnw30YAurkEvnI=;
 b=Crl16rrhZMD5JxjqpBGYYx+VQ7KqITT0fTYbI/akL8yKjgIJX/oHcyO1EXMCTNhPld
 557345aNF1XgSMU2is0ZK7Cn/8TZuDwqw2X6j9UaQqGHjE3840l/Fj5oKeOcG2uMr1Ew
 IOYO3WJ9Dggric5i+rEK7HqOxdXoYdWw9tfpFoWUznAUeLS9Zp+819MRfo0FphLneG+X
 qRoWBrDDIrmKhAq/0TgPL+8uHRIOktd4rlhQEzAUb/9GDlRu35NP++1FE25e9XE2mLRj
 dxNXDh+G+t5PNoOyHCtQL4AtD2FMDseI425hLDEadDhgb5uPCJ2sjo0KmZgHhxQzXwA1
 K/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045983; x=1758650783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=048D1PM0KI7bmfl5+HZw1hE5YzcYQNnw30YAurkEvnI=;
 b=fKv/ZCrpAJSON0+RgCZEL9BKshuW3rXtqw/RfqS+mYEqSfV/xiIzhCOI6bZMFe9b5v
 Abqf+mqyApkmq0GljuqabH8I9KDjSD5Pn9aQvKUnLrvd7zJh37/vGr3p56SXNStW9Asz
 tEGETk0W/ubikTcl1bIvy9YiNPXnOSvIefW9rnMKe444BAUcD4NYKrBId9iZYFQquEJz
 +pOSneH9YN9aS2uSWF6Do4Prf9nxKotEPqcYzb769Qm/+PPFIyEjsFFYp2cICPcBwjdr
 7/PVd8NRnfDfTtc/uqSr++FdlnvIB0bkuBjpkoTRjfJ/+TYqkl556e/H5pRLtm8V+CZQ
 IxcA==
X-Gm-Message-State: AOJu0YwO+e6ZCGw6nnQvOx93SzTsk4ry3uen6qdIXS0Nw+AqRYA/YFMc
 3WOOHurDvcBWZ+erHPDhXthV3BGKTlLS3nX/d2t1HhHXci/s9uZMXqZRuBEi3tWVc3AOi77x/lq
 GjQiV
X-Gm-Gg: ASbGnct8gRiQSwPOu5nzIiru80qQhM7cwU4zNfQA0K0V3reTAG3KVnIKustctq/vDTa
 oCkx1VhUT/3Gm8XsaWzGG6I18np0U7TSvP6DT5S/M239T8/2BDrFyEh0cFZS15+MdcZCtw4AweL
 yNvUVhQebK6oyEEkCDLyveCRGaMcIA0tGJgm5Zwh7H66KOsM/tGpKcipTyyrZBcCKwrZeWzdkhz
 ONcQnB0dOg9pIfCCZ7XaETQDoLWXVvxC8bIF6hwB+SHoaJZt0Tx7OfxHOTdKGmyN5SPsUSAWATc
 xx68DNRHw+HoEzf0XoCSr1Pq2VjX0JYWcMv5jqFrjGxnMIUQitKw2de/Yi02hpfOtLHwmukrCaZ
 kfxpW8YZfJhQz25HuwEfoOjS96xRVXqgNIC5SbBk=
X-Google-Smtp-Source: AGHT+IEI2FCAGHb1dMQTbXfr87wSxe2EYSTvxghKK3tCl109z5J3rxGsI7vRz1ZcGdYJjHNbwrzvoA==
X-Received: by 2002:a05:600c:4fd1:b0:45f:31b6:5c49 with SMTP id
 5b1f17b1804b1-45f32d4ea12mr39676305e9.11.1758045982807; 
 Tue, 16 Sep 2025 11:06:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/36] target/arm: Skip AF and DB updates for AccessType_AT
Date: Tue, 16 Sep 2025 19:05:43 +0100
Message-ID: <20250916180611.1481266-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We are required to skip DB update for AT instructions, and
we are allowed to skip AF updates.  Choose to skip both.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8925c9a6100..089eeff845c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -58,6 +58,12 @@ typedef struct S1Translate {
      * and will not change the state of the softmmu TLBs.
      */
     bool in_debug;
+    /*
+     * in_at: is this AccessType_AT?
+     * This is also set for debug, because at heart that is also
+     * an address translation, and simplifies a test.
+     */
+    bool in_at;
     /*
      * If this is stage 2 of a stage 1+2 page table walk, then this must
      * be true if stage 1 is an EL0 access; otherwise this is ignored.
@@ -1929,7 +1935,12 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     descaddr &= ~(hwaddr)(page_size - 1);
     descaddr |= (address & (page_size - 1));
 
-    if (likely(!ptw->in_debug)) {
+    /*
+     * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
+     * and it is IMPLEMENTATION DEFINED whether AF is updated
+     * (AArch64.SetAccessFlag; qemu chooses to not update).
+     */
+    if (likely(!ptw->in_at)) {
         /*
          * Access flag.
          * If HA is enabled, prepare to update the descriptor below.
@@ -3553,6 +3564,7 @@ bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = space,
+        .in_at = true,
         .in_prot_check = prot_check,
     };
     /*
@@ -3653,6 +3665,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
+        .in_at = true,
         .in_prot_check = 0,
     };
     GetPhysAddrResult res = {};
-- 
2.43.0



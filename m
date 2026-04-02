Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571B4D6AAE8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 15:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8KHd-0001Do-Oc; Thu, 02 Apr 2026 11:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w8KHb-0001Bu-KX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:48:36 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w8KHW-0002Yn-Mh
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:48:33 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6618bc129acso1392306a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775144908; x=1775749708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iDzFEMX8K+NDhqiWj9hSCAAXAnoaBn1FE6fzq/wKPdk=;
 b=QqPPKBrhxVSKXxzGiVLqRBJV6Xg6PzVBuRXyOkaueR90mUKL0Ye9t0K0fRVm67UUaT
 uUzQ2+or1w4H118L3P7snPJ4IrhcxLxmSBypIYDxToTlkTKMXCKpj+qWqOMmKjrIjlUc
 cNeL2LWxHr/nTV5ZG6eIZYEHhASZlawvW7gqfTgnxkbyjFOr9BVMmSWYb462uAngHyxB
 BHN+5tbtpazej18o9anbcYMraJjaFALjKcHMTL+GgrBhSK5EuGJm9oCFgG4ylMsZorBt
 rxd//USXKbwvVceoq6vmfglzHQ27bTiI7JOLljjCqZbMyjEdpoK3BK2/S9TasT42gJug
 ZWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775144908; x=1775749708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDzFEMX8K+NDhqiWj9hSCAAXAnoaBn1FE6fzq/wKPdk=;
 b=cFyWF78is3cBvfut7FOI4VFC/IpdSWaiRSHTuMCYE/XOf/6c1MKkrV029VJNK/aKdQ
 fKDCvOR+joPwt4WHNzn5NGQ7f5st7juMNDwuTtNNP80E/rS7CVnyAWTD3LsL0cYmIgyE
 XEvq8SCcBEP2TjN7jNCngh0fjuacgSxLdp2OqMQ/rpeNKay/G1SpDEmHxMRwZbmehNTL
 hNcYukpAkhXWlwYUbgoOkG5+3w8tlnalanqwz59/YYp+2MIjF7cjyEe7l5BjONuFA0PB
 IO04F3NMI8p3j3YTyXG/pgRHmga7NDkvMsMFQK/m1tYai1/C/mOqU4sNKXIamOlv74Ow
 tsVA==
X-Gm-Message-State: AOJu0YzXmR8nmXcaI8/WvP3hELMuuSUHT4e3H0OrV6MffGnGx9epbtaT
 yKk7HgIxDrLRoAJiZGH7Na8m5t7tkzWLE60Kik26lAn3Iwsc5vC3WHal6wVzFkOXGTwd1I39MUO
 WHTRv5n0=
X-Gm-Gg: ATEYQzyKjFZmkriB7lowgpi95TwfgWtLUE9By4EQ9tdgGYEGzblErFxKRLA/pXLflGf
 L4Dpeo5T/CgjItmlMrwsZYkF2O5SMx68UG5FduZNsU6ywl2yKGEjeXKvA1LD26Flkm+F6PH+pUZ
 mWWc2Npl5p/UpiwaI9KUhMDlivK6fvA+jzebwZc00sPiUb+9b+SNbCWMZ6IWfa4Bw1WLV6O0Ww7
 3AjyB7JoH1NHjXdjFvFaH2MYrpn1PLra9eX0fFRbfIksunLtnGiLG7i58JLnNrxMSiAjGxQXB18
 3VRg2j9yi6CYktkjYx2XcGjtf8r0ho/jwNX891YrPEpzEz5L42cwa3RDiwNaUkMVpFBCnJusIvS
 rONk2BX2/dwroNZ/evNWUjHD389bBCPcEjsmh800ymOgmiD5Oa7ng7iBv/pLIKUm0mWveS0iHRw
 ufRqqa11WCPFmkPXbpW2KS3wU=
X-Received: by 2002:a17:906:f58d:b0:b9c:5cf3:50a6 with SMTP id
 a640c23a62f3a-b9c5cf3a94fmr54391266b.30.1775144908073; 
 Thu, 02 Apr 2026 08:48:28 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c97218esm104055266b.9.2026.04.02.08.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:48:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F1C15F8F7;
 Thu, 02 Apr 2026 16:48:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] target/arm: always propagate s1ns state on faults
Date: Thu,  2 Apr 2026 16:48:21 +0100
Message-ID: <20260402154821.2340594-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

According to our mmuidx documentation:

  we fold together most secure and non-secure regimes for A-profile,
  because there are no banked system registers for aarch64

So we don't hold quite enough information during the table walk to
infer we are in secure mode. When we are trying to access a
none-secure page we get a stage 1 translation like:

  (rr) p ptw
  $1 = (S1Translate *) 0x7f07479f93a0
  (rr) p *ptw
  $2 = {in_mmu_idx = ARMMMUIdx_Stage2, in_ptw_idx = ARMMMUIdx_Phys_S, in_space = ARMSS_NonSecure, cur_space = ARMSS_NonSecure, in_debug = false, in_at = false,
    in_s1_is_el0 = false, in_prot_check = 1 '\001', in_nv1 = false, out_rw = true, out_be = false, out_space = ARMSS_Secure, out_virt = 1075929104, out_phys = 1075929104,
    out_host = 0x7f0750016010}

However as we only write HFPAR_EL2.NS when
arm_is_secure_below_el3(env) && fi.s1ns we can afford to relax the
check in fault_s1ns.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2568
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/ptw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index d5b2ed6c99c..ccdc1ef9916 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -634,9 +634,11 @@ static bool fault_s1ns(ARMSecuritySpace space, ARMMMUIdx s2_mmu_idx)
      * For stage 2 faults in Secure EL22, S1NS indicates
      * whether the faulting IPA is in the Secure or NonSecure
      * IPA space. For all other kinds of fault, it is false.
+     *
+     * At this point we can't actually tell we are in SEL[012] but the
+     * actual setting of HPFAR_EL2.NS is gated by arm_is_secure_below_el3(env).
      */
-    return space == ARMSS_Secure && regime_is_stage2(s2_mmu_idx)
-        && s2_mmu_idx == ARMMMUIdx_Stage2_S;
+    return space == ARMSS_NonSecure && regime_is_stage2(s2_mmu_idx);
 }
 
 /* Translate a S1 pagetable walk through S2 if needed.  */
-- 
2.47.3



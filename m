Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839DEFF5139
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABQo-0002ak-MS; Tue, 07 Apr 2026 14:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wABQn-0002LR-82
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:45:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAAdZ-0000eE-UX
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 13:54:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so32185145e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 10:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775584492; x=1776189292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u0aK3f25z8NBglHeEqx+HS4Y9twf4O2z0745LTDOqts=;
 b=NGPOO18xwBEGR10ppKtWl1gq74+RVh0p1eD1JgiKykjj4U/xOzbRMWnoVkE12llZKc
 tpgGfh2QuKAhGj/YhEJ+Qwla9COxaD+FCznlT/SqB/e5sQuErepZ5quMSGxS5AO9soUV
 rkAKmpJmmkzhtMGDey9k16L9O6ZWHJFSrxzeHBczaj1nuwEdLHfECD6P7iCJrrOrah9I
 6Q3n+aehorLft3hJ1/nTBK7ZgWk6pQ478PzOLJBZKu+0DJBkyOIFJQwZCmhkQSynk84x
 MOSkWzST8ZNoj+Ygc+lrkWJBZIC22KE7TZ5KCAAc6SrkdeUyfZ0+jjL8wl+yt56iVc0L
 tSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775584492; x=1776189292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u0aK3f25z8NBglHeEqx+HS4Y9twf4O2z0745LTDOqts=;
 b=eiZhjUQRaefgIJJwcO4H/QdbKUe68Il4sMSkIjIpyBwyleia8Ffr9Dmubph51bQQHN
 tmsQ3bqbcnzpMXD1gp4Ft/XvtRWy9Cip366Uwh1n4GnwTf07nuzvOEWOHMf3YtZm4yTj
 OxYU1W4xn4laC9Ogb+eYuWd62mPtPLeMpQQ0Ao9WHGsJ82+NcyVdxHb/HJYZakfuJrjr
 dFcjj38NYZVWVKaZd/Q9LEbgnK2+yYx+vZ4/3rnW8sm2cEw//hoyDG5E2lugVHBaFKcH
 BoShSNPyzhKlyuGsGeP9FusDrFyGLbHfZyFBBqP0F8ohZU+FtebBBi1bYJ76nSjdPGpF
 WxPg==
X-Gm-Message-State: AOJu0Yx4dnwa15k0550+siqnHfPjKSdBujba8cISXYnW4UjqH8SEtbki
 L0OX6joJiRSSWQJln7zepH6hMWjghUY3wTlNMuP1WSZVUQYcsJNqHfxVBkK7tBIO6dTX2cUzHVh
 I/oxLOL4=
X-Gm-Gg: AeBDietQla3OzQ7WhkB02sxTHmlvq/6Uy7skXEr7K/4s38IVy4Mg2KC/HAqfsGMarNr
 vB6i84I+T3qSjN/p1xys6mR9rvX1HW/HS7x2mrGQpNX2IekPVQo4Y3wWfE13iDD8WCIQ9/mcjPD
 /L/FDtk0GpB8HB/A5V60ZElkley0+a/a/KOrPo91Tgb1dwGiEUwYL0pAp7+IaYhZo5Ch6oATaYC
 jX64AJhN0wyiBcBckvOwpIjPjoQQA70xpFKp6hZ5ns/qL60glmCjwro0D/4WqNH5YPVJvqLuJ7g
 Jw9Fg7T4BOKHJg1bGa0SYxtusSF91KoWsFW8/6zZgGPjW47CxUJ29pwunPa1cZ+BOi/eIPOPtzi
 ogD3RuS50XePtaphuvzjTEFWzeiAsBuocR0prxxugaF0/1q1kfbCiKNq8ea+Y3SdAledDG4IAO9
 tkD+906mk+WwEdYMPiwibxBV5A58rQJWIrbIAPWplTcbic6Q76PUgRHs9wMsZhXYfd/16Q4UfLN
 MIl+AOMHpPqtDfrl2FQZkDc0na5hw4=
X-Received: by 2002:a05:600c:2d8c:b0:488:a2ac:a34a with SMTP id
 5b1f17b1804b1-488a2aca4ecmr115961285e9.10.1775584492379; 
 Tue, 07 Apr 2026 10:54:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488c5308b3esm1615525e9.1.2026.04.07.10.54.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 10:54:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] target/arm: fix fault_s1ns for stage 2 faults
Date: Tue,  7 Apr 2026 18:54:47 +0100
Message-ID: <20260407175448.3329196-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407175448.3329196-1-peter.maydell@linaro.org>
References: <20260407175448.3329196-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The computation of s1ns was simply wrong. For Stage 2 faults, it
should indicate whether the faulting IPA is in the Non-Secure IPA
space. Correct the logic to check for ARMSS_NonSecure and drop the
extraneous s2_mmu_idx test.

This is effectively a change in the intended semantics of the
ARMMMUFaultInfo::s1ns field, so that we no longer try to make it
exactly match HPFAR_EL2.NS but instead set it for any stage 2 fault
on an NS IPA, relying on users of the field to check whether the
fault is to be taken to Secure EL2 before propagating the field to
the HPFAR_EL2.NS bit.  Since the actual writing of HPFAR_EL2.NS is
already gated by arm_is_secure_below_el3(env), we only need to update
the comments to document this change of semantics.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2568
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260405112410.603223-1-alex.bennee@linaro.org
[PMM: also update comments about the s1ns field]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  5 ++++-
 target/arm/ptw.c       | 12 +++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 8ec2750847..85980f0e69 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -740,7 +740,10 @@ typedef enum ARMGPCF {
  * @paddr_space: physical address space that caused a fault for gpc
  * @stage2: True if we faulted at stage 2
  * @s1ptw: True if we faulted at stage 2 while doing a stage 1 page-table walk
- * @s1ns: True if we faulted on a non-secure IPA while in secure state
+ * @s1ns: True if we faulted on a non-secure IPA. Note that (unlike the
+ * HPFAR_EL2.NS bit) this is set for any stage 2 fault for an NS IPA, so
+ * code must check that this is for a fault taken to Secure EL2 before
+ * propagating s1ns to HPFAR_EL2.NS.
  * @ea: True if we should set the EA (external abort type) bit in syndrome
  */
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 08a76bd3f1..7b993bb5b3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -611,12 +611,14 @@ static ARMSecuritySpace S2_security_space(ARMSecuritySpace s1_space,
 static bool fault_s1ns(ARMSecuritySpace space, ARMMMUIdx s2_mmu_idx)
 {
     /*
-     * For stage 2 faults in Secure EL22, S1NS indicates
-     * whether the faulting IPA is in the Secure or NonSecure
-     * IPA space. For all other kinds of fault, it is false.
+     * For stage 2 faults, S1NS indicates whether the faulting IPA is
+     * in the Non-Secure (true) or Secure (false) IPA space. For all
+     * other kinds of fault, it is false. Note that we do not
+     * distinguish "s2 fault on NS IPA taken to Secure EL2" from
+     * "s2 fault on NS IPA taken to NS EL2 or Realm EL2" here, but
+     * instead do that when setting HPFAR_EL2.NS.
      */
-    return space == ARMSS_Secure && regime_is_stage2(s2_mmu_idx)
-        && s2_mmu_idx == ARMMMUIdx_Stage2_S;
+    return space == ARMSS_NonSecure && regime_is_stage2(s2_mmu_idx);
 }
 
 /* Translate a S1 pagetable walk through S2 if needed.  */
-- 
2.43.0



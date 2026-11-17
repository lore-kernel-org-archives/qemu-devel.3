Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EED606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P+w9xpy+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJI7-0002Ka-VS; Tue, 17 Nov 2026 08:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJI0-0002H0-G8
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:32:02 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTJHx-0000WN-8H
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:31:59 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so2608952f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 05:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794922314; x=1795527114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pSa7ptreDk5dKB5WmKzb47P1wr9NhX2Iyt0QzoUiRNQ=;
 b=P+w9xpy+LsI2G5tOPQ5mq/b2tSoXM964OGQ+LdENE7avwEgPuHK0CcMbuYRtSGuc7G
 RBwPJfPdZcpVBkibnhlUxshiPGh4xuDu325ZjjDzODTFlVlIZu2J5wTlLEpc/5YkJVTF
 DIhedfKVSrcTzmrgTNJeBtnMxsCbDou1pLgNcd3JHXq5jJrOvNlBDe/tAb0Gi1l6Z1tz
 rMcakzPcf/ojTgGpzBmy6virxeLcIZHP30uFYV68zPi/7jI0X2yoqBChUg9GLtMJt1b8
 n0XCJcs7JvxZjWJ0+oAwDNTeGH6e602ZRKVLiNfee9HpzNjb1qzc17FcqYlBTUa2wyl2
 qZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922314; x=1795527114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pSa7ptreDk5dKB5WmKzb47P1wr9NhX2Iyt0QzoUiRNQ=;
 b=eKdSri5bRxNq615u0O7Y+yAou8/Oyfb9WyB6Z4LqgwY1qWG+FxlEkJ6vvJFYZFylFT
 4jx4R+GTFGhv098cKcrJHBAamMz1nHrdODc0XR04T+9LMKQl5yReSUw7irkPxkK9yFkz
 JZ53f4CboJSGfgKmMRfyj4XwGMCroLNwiM3djwUsI6RlJ3oBc8vWkcmfS+cgbdS+n76N
 ZBKyDMvglgNfWpoKougkUEEwEfRETek4lA8vcjnaOg+sgh6BtQ+A9HnTHR11/ysvZsf+
 cwC+9M9OipoZqSwTyuwTxcm5jE0P9M5TRJgxYayr5yn2XQmJLTB4A9ctwPlAt4aEauWg
 GQ5A==
X-Gm-Message-State: APuU4Z+snUsM0IVdThNZ0SQwkYA/8k10TPNl+6BlLqIi6+pCjKzwFgr5
 NG7Q/NKCMvng7oE65FO5J8xwYXiParDsZMroJ9WpaX3Xn2fcu57L+KbrWSObN4xeQUNSEXzlJRM
 qFXwd4Nw=
X-Gm-Gg: AZFdTZfhKsn7WUjKgRVfjQKGx1n/uKtS1PTo3X+LbavF1f/6DYamYuRtkY5RyxBZah5
 o7NmALy6wQ7r0a0CkTZlqeYDvQ/mQ7eFQfgzfEcEzIuxIOqbKb7C0Oz79QsUdg1cz39AQmQUQqr
 1umaM+op0vIjyTYSxzAmEvfpUDr/BUzobtezr1c602jo0SOKcNn2UKuMkdPp2nJXh4QPNKPkY8r
 mAeOfMtWBv0D9utkx0kGPBaRnLKE5h3gJQkihwGayjKMRlI8xLEwzn95zaN3GEKbRisFl4otgfI
 jGOYPzXiDUoWkGM60OzVL+M0ut7IMFcrw0VxRltkR8I9C5T4puBIVwgTaGLWL1/prbqQvnePWil
 55hsNgdx74JZkK82R99Mb9TX0neueXV/TVxciebkavFjW0eMTeqUI3KC/ITY86a+uuuPU4BVTJJ
 4urAd8mJg8JLkNB924A0Sq/9GoNvLTA5QP9N1VasT84lMRLcdfiTi6kIuVdf9t/bHxrFVswlrfJ
 OeuQQxJawUQUgHILuJV/lvNWRPThoqJtR0CRjfRWS6ynIcuQJIaMWtgl/irK8Q88A6q3fmILYEb
 aj7+cR1f2Iq54tWELrlMgMiFcGxh7htQbt6wvWrDmmqVYze7t4IiytIa1V2PAbpRfrNC86R6w5l
 5AQ1dosKd/1mdh2/h0fgUts9uuAKs12HR01pxOTAGTGdVWFdFro4Uuy4=
X-Received: by 2002:a05:6000:2010:b0:4a3:836d:6f61 with SMTP id
 ffacd0b85a97d-4a3836d7039mr5745228f8f.12.1794922314026; 
 Tue, 17 Nov 2026 05:31:54 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c8a77sm28516886f8f.49.2026.11.17.05.31.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:31:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] target/arm: Get HVC UNDEF cases for Secure mode right
Date: Tue, 17 Nov 2026 13:31:44 +0000
Message-ID: <20261117133149.2108068-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117133149.2108068-1-peter.maydell@linaro.org>
References: <20261117133149.2108068-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the pre_hvc helper, we have a "bool secure = false" and a FIXME
comment that we should use the actual Secure state. This is a
signpost to the fact that we're not getting the UNDEF cases right.
Specifically, we get most of them correct but are missing the ones
related to Secure state:

 * For A64: HVC must UNDEF at EL1 if EL2 is not enabled in the
   current Security state

 * For v8 A32/T32, HVC must UNDEF in Secure state, if EL2 is not
   enabled in the current Security state

 * For v7, HVC must UNDEF in Secure state

The v7 requirement is identical to the v8 A32/T32 one, since
there is no Secure EL2 in v7.

This fixes a bug where HVC should have UNDEFed but instead trapped
when in Secure state with Secure EL2 disabled.  The bug is unlikely
to affect real-world code, because only test code puts itself in a
situation where HVC should UNDEF and then executes HVC and requires
it to UNDEF.

This was noticed by Coverity, because the "if (secure && ...)"
check was dead code.

CID: 1689834
Cc: qemu-stable@nongnu.org
Fixes: 35979d71c401 ("target-arm: A64: Emulate the HVC insn")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261030092815.573973-1-peter.maydell@linaro.org
---
 target/arm/tcg/op_helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 22f47f7450a..b6113096b53 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1302,8 +1302,6 @@ void HELPER(pre_hvc)(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
     int cur_el = arm_current_el(env);
-    /* FIXME: Use actual secure state.  */
-    bool secure = false;
     bool undef;
 
     if (arm_is_psci_call(cpu, EXCP_HVC)) {
@@ -1313,6 +1311,8 @@ void HELPER(pre_hvc)(CPUARMState *env)
         return;
     }
 
+    /* Note that we have already UNDEFed HVC from EL0 at translation time */
+
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
         /* If EL2 doesn't exist, HVC always UNDEFs */
         undef = true;
@@ -1323,12 +1323,19 @@ void HELPER(pre_hvc)(CPUARMState *env)
         undef = env->cp15.hcr_el2 & HCR_HCD;
     }
 
-    /* In ARMv7 and ARMv8/AArch32, HVC is undef in secure state.
-     * For ARMv8/AArch64, HVC is allowed in EL3.
-     * Note that we've already trapped HVC from EL0 at translation
-     * time.
+    /*
+     * In ARMv7 and ARMv8/AArch32, HVC is undef in Secure state if
+     * EL2 is not enabled in the current security state (which is
+     * always for Secure in v7, as Secure EL2 doesn't exist there).
+     *
+     * For ARMv8/AArch64, HVC is undef at EL1 if EL2 is not enabled in
+     * the current security state.
+     *
+     * Because we've already dealt with "EL2 not implemented" above,
+     * arm_is_el2_enabled() is effectively always true here in NonSecure,
+     * and we don't need to explicitly also check for secure/non-secure.
      */
-    if (secure && (!is_a64(env) || cur_el == 1)) {
+    if (!arm_is_el2_enabled(env) && (!is_a64(env) || cur_el == 1)) {
         undef = true;
     }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F25AC79FAF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 18:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcp7Z-0001A4-Kj; Mon, 05 Jan 2026 13:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp7P-00015g-6v
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:51 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vcp78-00035H-BG
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 13:15:38 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8c0f13e4424so17283985a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767636933; x=1768241733; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jHcTA6gvDp/xKck7gSYynyMsBMw427kEreNJmMaWlCI=;
 b=iDTlJo3/9tS3IbxYHvfZz7/Cs618fRjF1PMDUdTZuIyydWgZ+1zzUwbzdrTaSM1M0b
 e6e2ImcNG7Zn8VJOiu9g+5zfuAgdvfyvHON2HSkg3MkdrGplM7aiCHMFHm6lnEGke7q/
 1XnMxyfdB4mdjUfGfa026X3u2FnCGssW0c6L3kODXjNbv8rT0RoMgQKURfPpk0J3TbZU
 oIhRkRtqpV0MlsotvOH/GiJHOvbbMFxydrfaWdoECwgmoTZfkYDQWqFKDIGWlndYlvY4
 zwrVmyBIQt6JTknAKu9qUR7onH24r+BemmscI9s19cSLdWOjRh8kSwRFhFZjXegIqlHs
 x4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767636933; x=1768241733;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jHcTA6gvDp/xKck7gSYynyMsBMw427kEreNJmMaWlCI=;
 b=YBHXANkoi+kf3DRNPBV+do+0qqqGojodTw2YxYC0vH2bUBiQAI8Ia9sws2UD2NXd15
 8XGBTP20bOhhbgzSEa2+fPrFQJbC/d6qAEalScFRFp3qgz35XtAoGE35e4FuDUgz3OsC
 DlEVw5medW/K/i+gyu+3ZEJy0NOrdHvt79AKtmJ6S5ldWpRGpU2ygMRtpU0Uu8naGaPS
 VVTGOfRCyVttS815MGs1k10tLp+L50JPL2d0tmfxkuctMA89sAqym4VVVkGCkiclWIBt
 cCRiq9iBhvfDpUmOcK1tZRsiI6juMMHVW2M7niG1lBwPV50+kMVgn0xL3TyUscMk0zDm
 9z4w==
X-Gm-Message-State: AOJu0Yz9Eoja3tF4hjiDX7PbdOi5t+B4VcyW3Rogbrkavk87tqdgY4vT
 HBelfi1pFWletVL0AASt7lf7sTzr5qeKGLcM44yX0ub6m3KKxJ0rqAUE
X-Gm-Gg: AY/fxX5CrYjU02ZXzhhJLtXZfF+4lXMgHfY4GSoz22g3rHRNVn7KIf9uA5A07N02XfL
 XE9r21DD9KDdcrsZtx2LXTsUDdVDMAp9qm68dbaz0iDtorVnWTkjXs6XDnvofpH8tHe0B9HQAii
 2OQ9CGwUhMpWgk4y/RGpkEorxFu8WpjhbD2kAb6WIX9DWU6D9UtEzff7crabWKbRAvzipaoRBEM
 zrMPeJZJFDNtTD7eXnoRd3gzx5Qi7g4m4K9p7UrwuFRJ3nO4yHIMBQjk/bg+qI1aWW/3rtEydMf
 /YfZbG+R0H5tUsbGmNFsgfhUzJZwRcufhqor6SCQCn1GoyHl2+qnEtH1Wa0hbL5U9s1v4oqL3S2
 h49D1Foo/X1xj4Ja04ivsPIAJV5Dl0bAxoNl+MVjBzqnhdcruwO4nfJ9ZYYhZC6VeZL5ipkzRx8
 4FfXRslyQ8ihcW+k1m7HHD83DN
X-Google-Smtp-Source: AGHT+IGIubFrjaDstDhy2HP0AvVgIuVu6sOCYDgkatRaaxDLLIIQsVe/1hGcWjayX1w34wXl5JnI9Q==
X-Received: by 2002:a05:6214:2d42:b0:888:8088:209e with SMTP id
 6a1803df08f44-89075e29387mr8275936d6.16.1767636933005; 
 Mon, 05 Jan 2026 10:15:33 -0800 (PST)
Received: from [192.168.1.204] ([185.213.193.254])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8907540e24csm3855706d6.25.2026.01.05.10.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 10:15:32 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 05 Jan 2026 11:14:54 -0700
Subject: [PATCH RFC v3 05/12] target/arm: removed TBI bits from MTE check logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-feat-mte4-v3-5-86a0d99ef2e4@gmail.com>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
In-Reply-To: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767636923; l=4186;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=vOLU69w4oknJyo6gD2D8xBaLfCFyetC8olb1OJPcJpo=;
 b=2kr95j6I9M2WDVhFoE/v1Eu39vFnmhb5EFZ1ctSdedVzZl+ncM6v7GecktttoQPjVvIFXX3Dc
 K7NbWvpiZCcBAEtqhMfdzuA8cZdFDyKJhhifLZeJZsn2H2s0lM3uN2z
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Previously, the TBI bit was used to mediate whether MTE checks happened.
This dependency isn't described in the ARM ARM. See D10.4.1, Tag Checked
Memory Accesses, specifically.

Decoupling tag checking from TBI is required to correctly implement
canonical tag checking, which must function even when TBI is disabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/tcg/helper-a64.c |  9 +--------
 target/arm/tcg/hflags.c     | 11 ++++-------
 target/arm/tcg/mte_helper.c | 10 ----------
 3 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ba1d775d81..f64025925d 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1050,20 +1050,13 @@ static int mops_sizereg(uint32_t syndrome)
 }
 
 /*
- * Return true if TCMA and TBI bits mean we need to do MTE checks.
+ * Return true if the TCMA bit means we need to do MTE checks.
  * We only need to do this once per MOPS insn, not for every page.
  */
 static bool mte_checks_needed(uint64_t ptr, uint32_t desc)
 {
     int bit55 = extract64(ptr, 55, 1);
 
-    /*
-     * Note that tbi_check() returns true for "access checked" but
-     * tcma_check() returns true for "access unchecked".
-     */
-    if (!tbi_check(desc, bit55)) {
-        return false;
-    }
     return !tcma_check(desc, bit55, allocation_tag_from_addr(ptr));
 }
 
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index c4696af5d8..80d7ea9349 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -405,15 +405,13 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         /*
          * Set MTE_ACTIVE if any access may be Checked, and leave clear
          * if all accesses must be Unchecked:
-         * 1) If no TBI, then there are no tags in the address to check,
-         * 2) If Tag Check Override, then all accesses are Unchecked,
-         * 3) If Tag Check Fail == 0, then Checked access have no effect,
-         * 4) If no Allocation Tag Access, then all accesses are Unchecked.
+         * 1) If Tag Check Override, then all accesses are Unchecked,
+         * 2) If Tag Check Fail == 0, then Checked access have no effect,
+         * 3) If no Allocation Tag Access, then all accesses are Unchecked.
          */
         if (allocation_tag_access_enabled(env, el, sctlr)) {
             DP_TBFLAG_A64(flags, ATA, 1);
-            if (tbid
-                && !(env->pstate & PSTATE_TCO)
+            if (!(env->pstate & PSTATE_TCO)
                 && (sctlr & (el == 0 ? SCTLR_TCF0 : SCTLR_TCF))) {
                 DP_TBFLAG_A64(flags, MTE_ACTIVE, 1);
                 if (!EX_TBFLAG_A64(flags, UNPRIV)) {
@@ -439,7 +437,6 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
         /* And again for unprivileged accesses, if required.  */
         if (EX_TBFLAG_A64(flags, UNPRIV)
-            && tbid
             && !(env->pstate & PSTATE_TCO)
             && (sctlr & SCTLR_TCF0)
             && allocation_tag_access_enabled(env, 0, sctlr)) {
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 942bd4103d..f0880991b6 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -819,11 +819,6 @@ static int mte_probe_int(CPUARMState *env, uint32_t desc, uint64_t ptr,
     bit55 = extract64(ptr, 55, 1);
     *fault = ptr;
 
-    /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
-    if (unlikely(!tbi_check(desc, bit55))) {
-        return -1;
-    }
-
     ptr_tag = allocation_tag_from_addr(ptr);
 
     if (tcma_check(desc, bit55, ptr_tag)) {
@@ -960,11 +955,6 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
 
     bit55 = extract64(ptr, 55, 1);
 
-    /* If TBI is disabled, the access is unchecked, and ptr is not dirty. */
-    if (unlikely(!tbi_check(desc, bit55))) {
-        return ptr;
-    }
-
     ptr_tag = allocation_tag_from_addr(ptr);
 
     if (tcma_check(desc, bit55, ptr_tag)) {

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3333CCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL72Q-0000v7-TV; Thu, 07 May 2026 18:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72N-0000tn-OB
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:43 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL72L-0003Fs-96
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:43 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-40423dbe98bso768036fac.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192259; x=1778797059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KUxov8RzTJ3rWeBI2h10aJQ4FcxGcG5WyfWqnxlNA08=;
 b=uw8gpPnNK9UL7BOoWSx01G9WNb0IH1ZItrsch0VQhxELEjMBQCdzBnRFIUDAYmOeR6
 xlCucgwW+n3WO71eS4PStiQsG3YJpWwWfQ5YXtNFAL+OR4tilHVSV+mTHcbh2TPF/dO6
 tspH3Z35tUQFqux0UBAgMC6pdpytZEAZH8Lo/07KuEChK8BChOVsrSqrwJ0lCJX3hcUP
 Ta5UDqwj0Q75LJAEdjramNvHMTGHLJ7O9q2+96LzGp+BlWPKsL5DLqzGVgsQawskaOiE
 t9Co8G7h5uGbClncB7m1yMxvtSLdRldESO7NxGGvryOcFNEv5z0D6g6ASeaOcSTkCNM9
 Pbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192259; x=1778797059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KUxov8RzTJ3rWeBI2h10aJQ4FcxGcG5WyfWqnxlNA08=;
 b=M98uTLxlH+uIQkdtiH2LcSgkErlDkRzuUOE2wzXW4Cllk9C8jIIabUDe+SfVT3VOtx
 mfcBjdLc+eYlPZiOw1eZAkZ7mw6Qn0qInVWym3/Qx4Zg4Q2dqSa7xmg8nkyhi4Wtuimn
 rbEq35mr+9mFAihSkaE+8qM4L1QYiuPK4EMJ2i/BV6ZYSSnYAjChQEFO+SE5FFSb6LeL
 sZto+qiAUOgDg0FCYiP2GJlWLkneERTCamPNqfzbsYc6CgW5S9pDMxFK6aRLKkggWyIT
 JCVyTmYsKQNmhBtuuyF/R+M/J26tfdh58nfAzpEbTJ0wtI8O4hoNEho1CI9y59jSOObg
 WQGQ==
X-Gm-Message-State: AOJu0YwiChkVCIAh5FSdpHkmrs6c6BS2FSoSLZKtQYRvO/jSBsboZpfi
 ke8a0cdI/4PQ0y66pyDhlUuiO7/xPMUk1uVsH1w4o4ICANeBR10/rf6XWFa3jJDdqHhfuqovsii
 3Z3sE
X-Gm-Gg: AeBDievTRgF8HFyTf6cZNkRG1XCBdZpqNqD3TeDgqc0NYeLRVeM95n4xSSi70s9lhlH
 R2I00i4tgnON6SQ5u/+6T2TStM2LrA8B3i8IIP3d+6O6JvhDxnk7KoOjfBvrcqHH6bWahlF7qBK
 OqRa5s1Ggwxt1Xgc8EtdzCSRvyugeQLP5Nwb0Q3hTjXeU7QhPn3POTBL1eFhvnoXj3EhMlRoJf5
 /kDl/k+CF+D2GXkPigiiT2kH1ECuBQlL7swtOHr6GOrxMXzGZdQU+x3mgGnGt/2kj5dhvNz9dxR
 7zhPMTgkuJxRMBJcqIPNdxiYvHGeN3b1KKQ5xzL7axAlvFzXRB/M35aHQsW59Cw93sZq1PlwdvO
 tqCV+cbEF/su4/G4DcekYiZyddfpMwdPhSA53AfgDXZ9W96g14fSJ9zUpF/WDzYWbtAJfp3QlLJ
 ho1Rh7J5Qn7QHTKMIaA/dqJf4HHG8ay+4KY9yHOTdE54pOkA==
X-Received: by 2002:a05:6820:2014:b0:696:6585:a51 with SMTP id
 006d021491bc7-69998cbe152mr5228110eaf.13.1778192259398; 
 Thu, 07 May 2026 15:17:39 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/18] fpu: Use get_float_default_nan_pattern in
 partsN_default_nan
Date: Thu,  7 May 2026 17:17:15 -0500
Message-ID: <20260507221717.486023-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

Move get_float_default_nan_pattern to softfloat-specialize.c.inc,
since there are no external users.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 5 -----
 fpu/softfloat-specialize.c.inc  | 7 ++++++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index d36e3a24b1..49e04ffee9 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -172,11 +172,6 @@ get_float_infzeronan_rule(const float_status *status)
     return status->float_infzeronan_rule;
 }
 
-static inline uint8_t get_float_default_nan_pattern(const float_status *status)
-{
-    return status->default_nan_pattern;
-}
-
 static inline bool get_flush_to_zero(const float_status *status)
 {
     return status->flush_to_zero;
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index bde68aa0ec..fe56cb7c7a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -89,6 +89,11 @@ static inline bool get_ftz_before_rounding(const float_status *status)
     return status->ftz_before_rounding;
 }
 
+static inline uint8_t get_float_default_nan_pattern(const float_status *status)
+{
+    return status->default_nan_pattern;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
@@ -122,7 +127,7 @@ FloatParts64 parts64_default_nan(float_status *status)
 {
     bool sign = 0;
     uint64_t frac;
-    uint8_t dnan_pattern = status->default_nan_pattern;
+    uint8_t dnan_pattern = get_float_default_nan_pattern(status);
 
     assert(dnan_pattern != 0);
 
-- 
2.43.0



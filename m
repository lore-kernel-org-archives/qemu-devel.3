Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4B4D3C525
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 17:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1UDt-0006pt-86; Thu, 17 Oct 2024 13:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1UDq-0006nS-9t
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:23:38 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1UDn-00082w-C3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:23:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-431481433bdso12438595e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729185813; x=1729790613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qz3v+9Z2w3tFod8iKILXk4rM9BDOry0+5vRT/wn8qqI=;
 b=dmqDajDiWalTlCq7vR61B+IWJ4d8qK2OnsVuZkShJp87s5K80P08zqBu0JpGKQa4eM
 AU4WC7MICiOmFhZrcbZ8o0F3l0iour2bH5/HcfYEAWI/36wQ6mwOJmf954CRvZnL1cXZ
 5dsdttFeMYdrFSNMRoFcZntoI3ApBPx7VUTO0423G8mvGkOY4cxEfWVC/lcaiA5TeCgd
 +zxy9OetU0dPGl7TREOkWEn9hT5P5hzVQLlboTrbbFC19O6GrxkcioVVfQA0BGgd0gs9
 IAfAg7aIUwzWBOoo4x4eAqgOTXB3N18jWVfVGPm582Dbq52dJcMRnZoELEC8oM/jK+nr
 biSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729185813; x=1729790613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qz3v+9Z2w3tFod8iKILXk4rM9BDOry0+5vRT/wn8qqI=;
 b=tRNFRMc+RcTLLtTAtPSZXdW5mvtc+LPJwUDGFnTK35BY+ykPBdkcwBOeXtwAXDv0Ms
 TTHFpPl97Hw0Smm6/IQSZ0vnOBkmk7KRq9xoXoMzIyvYA0T4IDydKJEltgVFF560ywdo
 rqgsH3SJsoQmDBOOTs6L4EBGHZTWSA4TqRqVKcOFiaeY5MB6yJx2JmDYwcTDBrqinmsU
 fu4+JQnxcK2uvZrJQyqT4ediFTzGGN8ANA5mXfk078NxOQCNzsZtEFqkX0B/YWoJ1O7U
 qkURNhXczXwCVdH2u5pLW9uvlTSv84G7Xfl3SGDtwNooE6O9W1bCW8pc7oKjsVq79VDk
 QoIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcq29owPtv0ulZm7nPNFzOXlEdt8ZzrWw/kgcGDg3Oa1lUUSJGzBybnkiQ4RNFqRgMI3ughb9yZgkn@nongnu.org
X-Gm-Message-State: AOJu0YziiOZxBD43V1fYBnY9rl0jIVlwqT68dv+avMg/f4B+IH6gEzEg
 cjgmzHWZHDSTNFRRlvT2s+NLiGERQL0dEAN1fVxxyCd05PMA54BRlDgk4MU/sK8=
X-Google-Smtp-Source: AGHT+IEgXLXDt78/GJ4XZXflNh1zC40dpYOEDy28CiKv9HwbZNmcb0lXvP1UV6SgSH1u/OtfQ0r+bA==
X-Received: by 2002:a05:600c:1c2a:b0:431:53db:3d29 with SMTP id
 5b1f17b1804b1-43153db4041mr45641395e9.18.1729185813130; 
 Thu, 17 Oct 2024 10:23:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43160692d8esm1709895e9.13.2024.10.17.10.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 10:23:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Don't assert in regime_is_user() for E10 mmuidx
 values
Date: Thu, 17 Oct 2024 18:23:31 +0100
Message-Id: <20241017172331.822587-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In regime_is_user() we assert if we're passed an ARMMMUIdx_E10_*
mmuidx value. This used to make sense because we only used this
function in ptw.c and would never use it on this kind of stage 1+2
mmuidx, only for an individual stage 1 or stage 2 mmuidx.

However, when we implemented FEAT_E0PD we added a callsite in
aa64_va_parameters(), which means this can now be called for
stage 1+2 mmuidx values if the guest sets the TCG_ELX.{E0PD0,E0PD1}
bits to enable use of the feature. This will then result in
an assertion failure later, for instance on a TLBI operation:

#6  0x00007ffff6d0e70f in g_assertion_message_expr
    (domain=0x0, file=0x55555676eeba "../../target/arm/internals.h", line=978, func=0x555556771d48 <__func__.5> "regime_is_user", expr=<optimised out>)
    at ../../../glib/gtestutils.c:3279
#7  0x0000555555f286d2 in regime_is_user (env=0x555557f2fe00, mmu_idx=ARMMMUIdx_E10_0) at ../../target/arm/internals.h:978
#8  0x0000555555f3e31c in aa64_va_parameters (env=0x555557f2fe00, va=18446744073709551615, mmu_idx=ARMMMUIdx_E10_0, data=true, el1_is_aa32=false)
    at ../../target/arm/helper.c:12048
#9  0x0000555555f3163b in tlbi_aa64_get_range (env=0x555557f2fe00, mmuidx=ARMMMUIdx_E10_0, value=106721347371041) at ../../target/arm/helper.c:5214
#10 0x0000555555f317e8 in do_rvae_write (env=0x555557f2fe00, value=106721347371041, idxmap=21, synced=true) at ../../target/arm/helper.c:5260
#11 0x0000555555f31925 in tlbi_aa64_rvae1is_write (env=0x555557f2fe00, ri=0x555557fbeae0, value=106721347371041) at ../../target/arm/helper.c:5302
#12 0x0000555556036f8f in helper_set_cp_reg64 (env=0x555557f2fe00, rip=0x555557fbeae0, value=106721347371041) at ../../target/arm/tcg/op_helper.c:965

Since we do know whether these mmuidx values are for usermode
or not, we can easily make regime_is_user() handle them:
ARMMMUIdx_E10_0 is user, and the other two are not.

Cc: qemu-stable@nongnu.org
Fixes: e4c93e44ab103f ("target/arm: Implement FEAT_E0PD")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 299a96a81a7..fd8f7c82aa3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -963,6 +963,7 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
+    case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
@@ -972,10 +973,6 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
         return true;
     default:
         return false;
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-        g_assert_not_reached();
     }
 }
 
-- 
2.34.1



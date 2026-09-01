Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33810C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ON6-00010Y-9H; Tue, 01 Sep 2026 09:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON4-0000zX-86
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:50 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON2-000797-8U
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:49 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15e592da74so567692166b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268667; x=1788873467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V53Rb25nHYpLt74htQ81hutLVHNLXyZvQF/s+NqbH70=;
 b=VWF7HjpwoXGZLx6pue3wYzcezWcMLKw2wHZJyVQN3y1Q6b7lOKuG18mjG+geMjRIMw
 YWHSrgi6qqsngSCkpwa9IR/GKQowl6SpbyXmijyyfDr7tag0PsY720adX2tp2Fhn/rRr
 dP4SKq8+XxDrsaG0ftLsIZiue6xFB8U2K5pF4AZEgqMa9wmiV2u8yjHH7TSAKciz17eS
 4xWyn1JcNCwO2RbYMIT3jzIvJT+lWA1YASHwoVRYNRi/OgrWNbXDVc9JID+8h2VhK5+N
 4Qmywf8EBi3qg8Lp8YVxiE/das0XrVtqK8VWSsUQubKYtDcRCSdHQy1duR1kFZe3kErb
 OLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268667; x=1788873467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=V53Rb25nHYpLt74htQ81hutLVHNLXyZvQF/s+NqbH70=;
 b=jMjPL57lLqUXUO537OBB6bLCPU03elr799l1AIeTR08LExAo3euZTjNgz+YX+vzp21
 gxN9lWi4GXSxscCoMUSiP8xvsLRJcqR1441vhvcgX/xM1GNhFuV/KjWf2Usz1im2CXYR
 cmzys7zb6yArZsb7zzWWVP8v+svIle5o+a+T6+nPcgjH72D1BP8eYBH5ZdCRlSxxNcse
 cVVIaYuk5R3MYfnKM42C4tGKgrQ3qpvTgXnWXYfGkjmhBKdbWNbkIc4QjnZPZsALLRk5
 VT9yzkO3UQX77T7fj8XhLnxvXYEAMrEEckIJs5rYHp8M1KvBsmzDMUhYuJX6Bdfppk85
 PWbg==
X-Gm-Message-State: AFuF++n/0nOa7Ia+wvdfpGWiU/M8CjxCaXA9ZP2XDacel4OGoU6mDESe
 Ff+4ihzu9O/OoZdXIMGfCOIIqyc796uw3ONa2R/hNegtFVY1BfdDvT4mHFq824OfAEB65AeFZd1
 +Xjjg1Mg=
X-Gm-Gg: AYBFou2VKWNIuRuTKb+RCF7V8G1SKqDw+y3XkL5c3vT9086R20n49dhHgATmMmWy13X
 Cd2X3YsFa9IOMEA6kHms+usm4egMnyP1yfdWeynhHbXs/dpEjv2gjJrsyl/Doz0Cbbq9RJR7AzB
 B9GLF1GCZecnXqODns08pTQzI8HAYKViRZFBzaxc/AsjFB2M5IpOE0vdtpPQJgGYMinZHwhbgM3
 JpzLh+yx4i8Jo4NWrPgiaeTqUibQMNqn8dSkaD7MHwh41HZz97MxmOw56tfu2PsVfPx9708HZEj
 OqVnMR9EuDoBH3T1xHBDvsATRekHdNrEjasBxec32VOxI0aR0tn4ErO/Ufbn1ekWSbNsyz43PB1
 pLWchp9vAml+SbaXuAZo7sYBia0/vHQMaeYnVaytbn+1/JQJ5yA82CR3LWpGGht3O8GrQVxeXpp
 kk/g0Iq95um2Wm8VY3ZzCyWTofe1dsFYBz6IN3/llav7oGMsXImBInasfmY9GiuOaKObESJL7Av
 2yW8s1xr+/D5Gyp2QWgWuU1dskD/203CbVFOD7/wOwMhP8KFxAYe38LweDB+Sgp70XL2r8brll9
 m5BQ
X-Received: by 2002:a17:907:72d3:b0:c21:450d:cd88 with SMTP id
 a640c23a62f3a-c2556da336emr2126751166b.6.1788268666601; 
 Tue, 01 Sep 2026 06:17:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/58] target/arm: Make IT insn undef when not present
Date: Tue,  1 Sep 2026 14:16:46 +0100
Message-ID: <20260901131732.2263947-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

The IT insn is introduced for A-profile starting in v6T2; for
M-profile it is present when the Main Extension is implemented (which
includes v7M and excludes v6M).  We were missing the feature-check,
so fail to UNDEF on earlier cores.

Add the missing check.

Cc: qemu-stable@nongnu.org
Fixes: 9ee6e8bb853bde ("ARMv7 support.")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260821132550.168896-3-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 1a7dd77a9c8..f013f94b217 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1,3 +1,4 @@
+
 /*
  *  ARM translation
  *
@@ -6038,6 +6039,16 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
 {
     int cond_mask = a->cond_mask;
 
+    /*
+     * IT insn introduced in v6T2 for A-profile; it is only present
+     * on M-profile if the Main Extension is implemented.
+     */
+    if (!(arm_dc_feature(s, ARM_FEATURE_M)
+          ? arm_dc_feature(s, ARM_FEATURE_M_MAIN)
+          : arm_dc_feature(s, ARM_FEATURE_THUMB2))) {
+        return false;
+    }
+
     /*
      * No actual code generated for this insn, just setup state.
      *
-- 
2.43.0



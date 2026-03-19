Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBCC1088E63
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w335z-0003oE-5t; Wed, 18 Mar 2026 22:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335y-0003n7-7Z
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:46 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w335w-0002uO-NZ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 22:26:45 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-79885f4a8ffso5278947b3.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 19:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773887203; x=1774492003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztIVCrrmqBuhnm6JGGEUa3bN+o69ButyUhpjXpcaOJo=;
 b=TUFzhQBxivaTfWcSRBZE+79d3X7HeZ0rnMBGBvapAMlTvoKOfjKNAaGkRSd8CVY67i
 zsF6t1MnIoUbjR3fvZFFOfk1g/9jcvn7IeF4V7NSIinZOi5weeFLXpl/dGTx2HSRJJcO
 qXseks3Mcd+63Sifh3PXqUpdpecB2gaC3yeT1v6yunwuUvfgW9v99ZEIBOr+6iJLAs2h
 P4iQKPXSJHpSSCb9peVCOMTdY9tYjlqSW5oAGffIHdOq5AN3uqHQ+IWnMZm6g9rgMKR/
 DBUEnYEqS3zAlNSR++MRDEULh70UH8YYe7vOiwMg3SeJbc+wnfsE9wdr1o+Q5SReiRmW
 HTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773887203; x=1774492003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ztIVCrrmqBuhnm6JGGEUa3bN+o69ButyUhpjXpcaOJo=;
 b=h3LI1aEZubGNZsUYySNDl5C97BRM9fsh/CjG/nS4gEXC5Z8d6WebeGgSg+tpIb+Hpt
 l73MaPJTK+t2V7Qb4k2rThqG8uOyxukaz9CJ7ix0Uipzuc958hcdy6EP8ZZAgW8HAgls
 jOt1QM02ncG1PYEOfro5JL+vS2ZTVPi1N7sdQMKlgG8bljYBWIRh0CIFnbWh7MrAAXzc
 v+U00IGiD0+jWIWmeaVEo1lplnc4j46d0JhRUI0vO8d1d0KWoykTYA63JsGszjLc49mo
 IHHbHH6rLetWuoG9lLnNNvF2zPVwiDc75gz64zPhSDgw2gV73CDijqKxwxo43SI12RXJ
 9jVw==
X-Gm-Message-State: AOJu0Yw8gEs9nI8bnRgZxRan7fyXfXB2S/Nmb/MT3Dscvmyfgx48tawH
 2Mg4zuFuDb/KWU+PdG/VaFX9oEiPwBjRcIxHx86z02SBJo95olx/EB+x896W0MvEgWHhskW+iMf
 JxstbZmY=
X-Gm-Gg: ATEYQzy7Z8fsn7YdK3ec5FUL3/vBPz8l4qeespmU3Px3EhalMkabeQJHBLFp3t8IPYI
 MaM15wkURcmUudsyIdxBnrb1ovg7Xt0Otf9eXuCzspLL29tXS8FVwLQrHs53Opg+JR5bHuFMao0
 fllN3h50L/K66z/maQ1S5kCLey6EOErq8x3d4i8GeLJAOddRTKRIjVLH0wfDO5TRouXZEpouxKJ
 DQ1XgHrNfzN66f9bGZhem6fHVb7IGIcK4ApOehEgid3a/l+QTxY2x4MPzIvur9e/pyNq69iBWgi
 8ExgB26j5sQkrHEidQK/aWDDegdidQDleh4A22Zpet1dgIopgV6xsiqwgEz3AvjRFKoy8Sx3515
 IPXoHceEKAB/yFAr0foa+H/7BunYkm8d32FtxYL5pmCCP3s7lYJ/LD+Fg5OsW2ptUYWxAbfFDs4
 ZJ8x235yLFRZwbqRVBj2PQdAJSacSdLQ==
X-Received: by 2002:a05:690c:e3ce:b0:799:a3b:37d5 with SMTP id
 00721157ae682-79a71c701d9mr57545017b3.46.1773887203566; 
 Wed, 18 Mar 2026 19:26:43 -0700 (PDT)
Received: from gromero0.. ([177.146.137.168]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-79a7141eb65sm28159417b3.21.2026.03.18.19.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 19:26:43 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, gustavo.romero@linaro.org
Subject: [RFC PATCH 7/7] target/arm/ptw: Print MECID if not zero [TO BE
 DISCARDED]
Date: Wed, 18 Mar 2026 23:23:35 -0300
Message-Id: <20260319022335.22523-8-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319022335.22523-1-gustavo.romero@linaro.org>
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yw1-x112c.google.com
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

It's easy to get the sw stack wrongly configured and end up having no
MECIDs being setup different from zero. If this happens FEAT_MEC isn't
stressed because a MECID 0 won't cause mismatches. This commit is just
a printf to allow double checking that MECIDs being provided by TF-RMM
are not zero.

This commit is just for debugging purposes and will be discarded.

Please uncomment the line to make it effective.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/ptw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index aacc32ba33..bf58ac656f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3939,6 +3939,9 @@ static bool mecid_check(CPUARMState *env, S1Translate *ptw, hwaddr va,
      */
     if (access_type == MMU_DATA_STORE) {
        /* Store MECID for physical address 'pa'. */
+       if (mecid != 0) {
+           // printf("MECID (in register) stored for va = %lx pa= %lx is %d | s1_mmu_idx = %d and ptw->in_mmu_idx = %d\n", va, pa, mecid, s1_mmu_idx, ptw_mmu_idx);
+       }
        set_mecid(env, pa, mecid);
        return true;
     } else {
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3455FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTjj-0003Qb-I6; Wed, 08 Jul 2026 10:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTji-0003NU-1P
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whTjd-0002zB-Iu
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:58:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-474303f3c72so544323f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783522728; x=1784127528; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tX9tNaONRpwROPfaGRbaYL2F+YY9wX+A4+ycI95THDA=;
 b=RIYi2m6/zJiUYF3phlUjZYtJ8dfB5PuYp1rKpMegfU2IKINk49eREE4LTmtSXrxK65
 O8SmDTBW1Npm0PDoYzteqUT9R6CG0XiCfPTqa4sMla2hAact2gbbL656tFaDtf8d7rKG
 78T+z9/VJDU7v3RL+nrmEcGHUMlUvds6oQ7ODUM1em6tiYv1ltgrV507XBxs4W3iiKCJ
 9ot2hppRKzI/Yu4VRH49b/1a6vjLwt15JjFA7FHJi0rmEjA6CCUZv+E5laWIZ7+bcrsD
 WTdRAX2m0skGEwPjWN1jP96dx8iuypywaQjgwyrmbgHoCtRwAl71ZpQ15Yad5y5tGydm
 jo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522728; x=1784127528;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tX9tNaONRpwROPfaGRbaYL2F+YY9wX+A4+ycI95THDA=;
 b=r4BR4fyfq5qnMwt0azIqWaN6LG4gZN+MkB6qK+2qc96JUuS+QQ1McBW/qhoBRed7Y5
 O5RHCA+25odeDn0ajm5u6u0HxFCyYiPWgu4RpPOGCMNE5WU4BkDrE4EwSgd7og5F6SdG
 o/rRvFSBvrrmgM2mFIGeYZGUtlD4lzA+quTVfwHLxPcxz33mYTlfe//XLTJCC/dz51md
 STXOaRWRHJxdk6iTsE8c4OTi4K/16GesBGNOoNkpITic0sfdRoLJSCqnQhuXh3s+/7aw
 ZQYTg2GhQjUFv85ArUWontyq5XK+MlFY5xXu3PC673aPwdaUTPR9z+azFlAlCxTrbo8m
 gi9g==
X-Gm-Message-State: AOJu0YzTf5K0vXMSXwamzZT0U2x+rqU7LAb2UiLi1s5maQrTPYykk2le
 4POujaa4+YMpt/14VVEMdCt2+rxG46Rk8snqm1PSSngyibII/gEPcMuVdMI8cesxeho=
X-Gm-Gg: AfdE7cmjhTQxxa72mLOepjEKYANsqXr+m+f2YT4VNBxz+B3wMFz7Mp4VMYnrSt7ha84
 qrW/ImtQuAg0sYkYktXgmB8MH2evry9IPrAFMXRqwvCJJ5UAnMp3p8UE6LJeeEKDSXXrVsj+5Dw
 t10hIYNYYrEFh7WJj7127qrJGdg77TFX7S6hnCkwsKADxq9kuiI5NsNHfeFZ3hes3iqEOBDSNO6
 15v4QXuytbahlu3vBFRvY7lIvffedSkC1p5V0+VbIZsuWiMndNsyaVstPSnpQJV1LP5i+KBGd9K
 Gc5eLHfystzC22Bt9V2Oc0Tto2jyhkN5LqGJ1UlJHtRruROjnjfRihcfTuPcCgzEQebJN565fA4
 9E4HYrOspycoVbarigOh4Ten3fKpGdAT5Hr52q3qNz2bgzogLNBerVEmWn53Kn1rAl1GcWLmv8o
 jE9G7pSoz2+/kq
X-Received: by 2002:a05:6000:4715:b0:466:6ed8:1e1b with SMTP id
 ffacd0b85a97d-47df07be343mr3437445f8f.21.1783522727635; 
 Wed, 08 Jul 2026 07:58:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm43987482f8f.15.2026.07.08.07.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 07:58:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 48CF66007A;
 Wed, 08 Jul 2026 15:58:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 5/8] docs/system: document FEAT_IVIPT
Date: Wed,  8 Jul 2026 15:58:38 +0100
Message-ID: <20260708145841.3032079-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708145841.3032079-1-alex.bennee@linaro.org>
References: <20260708145841.3032079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

This is for documentation completeness - a system implements
FEAT_IVIPT if it implements any permitted instruction cache
implementation. QEMU doesn't model caches which is a
permitted (non)implementation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 05e85d7a367..7806982e0d6 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -104,6 +104,7 @@ the following architecture extensions:
 - FEAT_I8MM (AArch64 Int8 matrix multiplication instructions)
 - FEAT_IDST (ID space trap handling)
 - FEAT_IESB (Implicit error synchronization event)
+- FEAT_IVIPT (The IVIPT Extension)
 - FEAT_JSCVT (JavaScript conversion instructions)
 - FEAT_LittleEnd (Support for little-endian at EL1 and above)
 - FEAT_LittleEndEL0 (Support for little-endian at EL0)
-- 
2.47.3



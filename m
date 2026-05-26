Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF896CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmZ-0000CF-C0; Tue, 26 May 2026 10:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmL-0008Kh-7o
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:11 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmH-0001EY-Ve
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:08 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d73422431so7551456f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805744; x=1780410544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NlHvCg0punP2/RxJsoNMqmUBc8JZ2RfyNnqU1bG19ag=;
 b=rN35CAW2MhOH0WKLyO0HyJ0Rkm69PRwSb4KN8QIhcSyrekTtbhr/q/EOE8yA8TipSC
 ezzcm0iYpxdT65ccrFU7z90z2fMF5171YRofYW1PezEJ5IzKunacVunTZ8zQcGIZv4TF
 0ose7annnsr0JkJoEv5wr4qRyiCMlZWG01RMqdW2AqNw2df22MjWR1Wd/Kh16seyPqLw
 K7sMQb1yo6uEE+mODyDoDpou9U9qnTNM0rfPWeRAyFofgkmv3Ou1MusBFTJ2Eogbxs6M
 NqcyprUMuRlrFEwphAb6uO/na/eauOc6Cn1xx1o6xGtkKzvEh7MgYSDscpv5b5ub8ECO
 CC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805744; x=1780410544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NlHvCg0punP2/RxJsoNMqmUBc8JZ2RfyNnqU1bG19ag=;
 b=rj5/TN5KrTh4UOZKH8Tb75cdXUbBsM5eztfo44mCR4DAe+Y5sPME6yRIJVnEFYFhsV
 nOTcD9ZwRBR2lXRSeDHv3AlDzfshefCHykwobq/D2LY7nbHMfANSqFOYG/ePWe9kWSNP
 xFH0IDylDoRi8cXHgx0Dx0jWFjRN79x7XPGgyPZOzYkEY4lX8fnHql7ecvisYRh7Tesb
 5+qTNTPUYH9GC+JYwclEEvOo9513L9XyCx/XWnW69w8kuhbINEY0htoyA6TEDh0bc5oQ
 uENr0ekomsExcA4ErPigqr6Yk/Q31zh8zpoq1uzcEzFjPjBFy9I7iDKSORBe3RnqLQ9f
 JYHA==
X-Gm-Message-State: AOJu0YyvY9rz2KApBbI3x0lIdhYDOoH1ii+3S6FxyzqdUKOK0NQXqzjZ
 GUVGhf6zSvFxIQqZXy5h1IET/BICHpgiY3ygU+8yScf+D4Psc8xeSGx65Hzh1OPE9b5ZwJb6UPD
 yfE0M
X-Gm-Gg: Acq92OE+zJDqVN9wQh1Kb4AEVYGG/FqjNfhoIXu2Nl9+MLu7AUYOE5AaAlwQdeR10eH
 ezvjw604AaczIo27MvA8P8OecUoXaE+JsAFp6QYCumk0iS8UyMKouyIprNM53/xZUiKSKUDLlmu
 sI1kPQYe5zeuIOL0JDHPvfVJD+kp3EWnSPhL4iQbOt0jdCNXa16MNmqEKXYUWZF9YTHlT4Cbc7K
 bwuDGKawH370WcrBQ/YPVU/HvEUwjeVhT9Cj8PQ9AcVX6y/DmIzoWxv/b7VZNida2zbr3R5cPtz
 bcaoNUDqkErcQNkY5b+qus77Edg8uWTysXBEKVUiTeI+I6U7K0Zj0P1LQ+5+6p/dfSQFDisjUvL
 JkAYe9A4MAClRPIWXJE6yX5q7g4Pg1mlaL73CPyvgqMasJuu7MjoL01/Zcz33ucNANudpPyPsg9
 Aj9zJUty75WDbvDmOTWfh4+9esEHo+8QfHjyZrTxqmCIaSe9wv85rcdlJiFaC1ELpXfnvLO0qwz
 +U9SSLrm5KoXXLmEYaQ3Vb1iHPS3LQ=
X-Received: by 2002:a05:6000:4306:b0:45e:ce28:666a with SMTP id
 ffacd0b85a97d-45ece286684mr9094395f8f.1.1779805744525; 
 Tue, 26 May 2026 07:29:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/54] target/arm: Set debug in attrs in translate_for_debug()
Date: Tue, 26 May 2026 15:28:09 +0100
Message-ID: <20260526142850.2326589-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The translate_for_debug method is supposed to return attributes
that include the debug flag being set. We forgot this when
implementing the method for Arm.

Fixes: abefca8e7f957 ("target/arm: Implement translate_for_debug")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515131245.366240-1-peter.maydell@linaro.org
---
 target/arm/ptw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a4842a4b62..7cc1d5884d 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3961,6 +3961,7 @@ static bool arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
         /* translation succeeded */
         result->physaddr = res.f.phys_addr;
         result->attrs = res.f.attrs;
+        result->attrs.debug = 1;
         result->lg_page_size = res.f.lg_page_size;
     }
     return fault;
-- 
2.43.0



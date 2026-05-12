Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC20CCD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 09:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMja1-0008M3-JS; Tue, 12 May 2026 05:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMjZz-0008K9-CD
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMjZw-0004oj-Ae
 for qemu-devel@nongnu.org; Tue, 12 May 2026 05:39:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b150559bso41104505e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778578742; x=1779183542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OnY/BWGcNqO9qjtPpU5g66srFDOxGnE7YQ7EIiD8zhE=;
 b=GvSoABLFiJkL5Yri5oKYIaBHn09eI8m24DPLlDKCayGWAzfXMw/iAFsmv4GOyPQWZO
 jdZ+gjjRWB6M7XgL1gk3zF3K0NzsaiwORj76hirS/f6VYLRBpsQhaMt/yjOBg4aLo+hO
 JwfGfpOx2nSWtuUAIGaPNP9GnQOKiQJiuwyNvpPRt0czZNgj2nEZv+lf+BOHPmJpPghN
 MPgojjVt4ktiv0TojTIavyVtGNO9E7q4Nyeh7/4WNqvDwafMli6DgncABdFnvRKtr26J
 whqX2xOmoFfuQf0DCDDSNuWls6PL0wx2XjN7cUdvNdHhjQ8SDRefLvEsI/T31AF40osG
 eyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578742; x=1779183542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OnY/BWGcNqO9qjtPpU5g66srFDOxGnE7YQ7EIiD8zhE=;
 b=iYoU+yxgtGUzWiYyO/iatX0R5bdriL/uJifKLEZE4NQKcnloNDe8ajmRc4pU7J1+61
 b0cpv4WdmGXmvPw67mxUQ1rvBJwqWXpAj78U6Y72w8jG4miXvCuMzqO73XznS7HqjvYb
 cjT1HJiMRlrEWB7xuKrzDgFT6FOvvQF35MDaXcDfWxS4PR8h032gulRcPTnfDWjEYkLA
 Amz78fTm9K19pVll6SzFGJaH4MD7nACfeSiX8uJrpfu7O9q3V4gpE82guZeZhQIuXYrs
 mnD0QB0hnsW20hfok2ZP15STYy1xsSfjfPbTGdYKqHSQXsQbJZ/Szh3zvFpAUWYmytVD
 UtKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WQ9h30s4DndRibH59IlSmjX2bc82VVVtaUpLXUG0RTOiCX0xavxElTHwAB8AtAcNvpPhW6JNsqB/s@nongnu.org
X-Gm-Message-State: AOJu0YxoTZ7TRWs7qoE3pANHNYJ5EXeafqYoiPAQospFvWKM7gNIX9aU
 4SRVGnoY2i+uN2+RYb6Y/87n1qCNc/7jWY4px2NiYptgAMrUA/LFVoj3n4z5L6GTWYSISNMMaHm
 5f7Qv
X-Gm-Gg: Acq92OGTyPVdiBv8DH2exSVWOu9bIZSf4YknQAb2yMMVS6BFhG97nwtRbkWJ2fX86CF
 qVvB11P4nX7zyH83/D+d7ybozZcnOrm5ZxpbmL0oLdzpgdg2vfjOaf7PqjGEdn8dXZACfrhfrff
 LHgWWQpuYIm01j2WEgMrF8DdMVQOkYslA8qnLCYEJVkB3ntc4j8HK99hI6kmQfZ/78Xfw5EnIHf
 KXAYoSm6UnRE2QaCHuUWcQWGdULcbXwuCvzqkI26A6MPM1//dhKLNJOgJSbe+5K7sS2gysaEr1f
 zfUqsw4TPJfcpBvtmFVx8SKG0Uv+J+ZdjLtR/w41EGPFPFI1KyN/Wr+NcsGjEBJf6usp1J7kiUq
 TSyPSgU/bKsNwJXog1Ife6kDyb3aIkcYGSLYe5H/L+bxKViicLpkQ8feg4G1FWw9SZX/sWq3JwO
 M3AL+/C1xL2Cd1sqTAFs6bgdvhZdnNVFkMwWP/2+QQ+N931wnCTYfiqOvPJFOHQaaQSfYuPLdJL
 CZtiOt6jgbj2egO/o1wtTmiEg4N/+8o8POBcBQaBw==
X-Received: by 2002:a05:600c:6099:b0:48e:6262:3df7 with SMTP id
 5b1f17b1804b1-48e70811e67mr203168975e9.28.1778578742463; 
 Tue, 12 May 2026 02:39:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a6a64sm32805208f8f.6.2026.05.12.02.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:39:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/4] hw/intc/arm_gicv5: Add missing early return in
 gicv5_set_handling()
Date: Tue, 12 May 2026 10:38:56 +0100
Message-ID: <20260512093856.3197700-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512093856.3197700-1-peter.maydell@linaro.org>
References: <20260512093856.3197700-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In gicv5_set_handling(), if the guest tried to set the handling mode
on a nonexistent SPI then we print a GUEST_ERROR log message.
However, we forgot to then return, so execution continues into a NULL
pointer dereference.

Add the missing "return", bringing the code structure in to line with
the equivalent parts in other functions like gicv5_set_pending() and
gicv5_set_target().

CID: 1659596
Fixes: 5beb48ab53d ("hw/intc/arm_gicv5: Make gicv5_set_* update SPI state")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 7ad274e369..6b1dd04991 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -926,6 +926,7 @@ void gicv5_set_handling(GICv5Common *cs, uint32_t id,
         if (!spi) {
             qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_handling: tried to set "
                           "priority of unreachable SPI %d\n", id);
+            return;
         }
 
         spi->hm = handling;
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FCD10ED65E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65C5-0006pc-0M; Fri, 27 Mar 2026 07:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C2-0006m4-4h
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65C0-00081i-62
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso24721295e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610251; x=1775215051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xoRGta1aZeQteYUJwBZiFNsYjMFLQaWe8l3517JXolw=;
 b=gZws7ldrZOgt/fiKrjUZTsOBGyzFv+j0h4B/rleILE/svzuv8Yj2+xXE4uUMkw0fC1
 HvdX45hHQsGqT9TNMqDQxx0vm/H6mc8tF7m4iXOTmwoGDpDM4DjTpywguFc0LSl8/gwc
 WqxFdVkwsfQzJc4U31wJOuhu0Qa2OzZecQDEgRP+zWAs/yYYnZmkIfEL2IPWu/6XPAy8
 lj02SmRisptogSZf14xdiVa6O5fzvzoRE8irX6nVxlOiqYztJP4XynY2VTpdRXfog0I+
 dqE1u/31hA3Lo4L9jFyWW5QvZ4fMGN7yarhXaepKKPfvpCxhkmytwbcPanOmwUZL/fVD
 OAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610251; x=1775215051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xoRGta1aZeQteYUJwBZiFNsYjMFLQaWe8l3517JXolw=;
 b=dvAwHQYj7PI8ykfDH+FkDQR/K4JHB39qf+IXwdqTojMrw3jIz85eTYSxKSv76mIXE4
 Tdp/EF474G2+HXex7ojyPmf2Ubltjq8qAuZZ6iWaBs3zYF4KkxzLuGt067W7qfke5Zu4
 9+XmTPoTZmoJm1TyGHXJvucC2tpa7jX6lSR6Gn/3ji+NfyWNvKEmoBQ7nEvzgyYL3mlb
 mf2z1tc1jspHsP6ZxHdcAvdKxFqA2AgNoDhyE6VLzhEo/AH1HMxfrr4NmYIJvEZf7+AP
 33TVI0M3DAYkmK6lvSRaPS2ADYE4OwYuRTY8TkqwK92Nc5EPjWryyWYJnJzAEQQ7akAN
 cS4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVoZqRZkFXXKm0MeEgCEQvc2FSobxX6Dbye4CKaBa3/Am/23oFSrwTHIbTLc7Iqx1J/37gBm0Wpn6+@nongnu.org
X-Gm-Message-State: AOJu0Yw1jebvqD8BzKv01d21fV8rQlGEQg9E1TomWGBlr5EB8nKBh/VS
 IG48OOgTQt3i0smN+b15IuYWqWBwH71te0YjJXvUu2B+8ZekqmDWVpcMUkErhLiOSuI=
X-Gm-Gg: ATEYQzyzXNNILLP62jtf7560R7jiUQooRllLfmqCMehHmOGOU00TXDU91IrH6392tLS
 OGJ4SRtigma4sZF+xcLHno8i5wt7doviNn4ZP3jbLvY3ITKtyj/nEHq6ne17sbQte0k2qSGxyzE
 zfaGXLijGWRWXxGRWw8UXYuOp9bjH6ChlJ2pS+Er8zttjzHdzMtS019wKMqTMNc/OHpKBS4OcP8
 ahvQkAkGLZ+XR4dbEthKx0E12mOkg49uG2kTSVer/iW9vBaS6dWr+ZUp4z9EHNGAUvxApiFbaMV
 TBi0PZ0/kxu8zQfDDwhw+h84x6ttxwG3NCog5s9Q2V+hzlCTZS02y0rIwL1OIaEyqnUn0wnLFyz
 LnTqMaYtS32OumhoxsqtBojEeIwVX8CITmBDq+VS0pA4D3jv/6exmR9c9Yq7/f60qe9rbXih7Tu
 G2gV3+mfqHFj0lfnpJyZPIbE/wEmxv54XMQkx6yl5KF3MpBhDLbJC7w/k4hOeoVQqaRQfrL/mnB
 47VsvoRXU8efqh092c7nXpKj3D1J9s=
X-Received: by 2002:a05:600c:1e8c:b0:485:304a:58cd with SMTP id
 5b1f17b1804b1-48727d5a25dmr34381805e9.4.1774610250547; 
 Fri, 27 Mar 2026 04:17:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 30/65] hw/intc/arm_gicv5: Implement IRS_SYNCR and
 IRS_SYNC_STATUSR
Date: Fri, 27 Mar 2026 11:16:25 +0000
Message-ID: <20260327111700.795099-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
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

The IRS_SYNCR register is used by software to request synchronization
of interrupt events.  This means that in-flight interrupt events are
guaranteed to have been delivered.

Since QEMU's implementation is entirely synchronous, syncs are a
no-op for us.  This means we can ignore writes to IRS_SYNCR and
always report "sync complete" via the IDLE bit in IRS_SYNC_STATUSR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 3f397d9115..7b0d9e16c4 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1087,6 +1087,10 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_CR1:
         *data = cs->irs_cr1[domain];
         return true;
+    case A_IRS_SYNC_STATUSR:
+        /* Sync is a no-op for QEMU: we are always IDLE */
+        *data = R_IRS_SYNC_STATUSR_IDLE_MASK;
+        return true;
     }
 
     return false;
@@ -1172,6 +1176,9 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_CR1:
         cs->irs_cr1[domain] = data;
         return true;
+    case A_IRS_SYNCR:
+        /* Sync is a no-op for QEMU: ignore write */
+        return true;
     }
 
     return false;
-- 
2.43.0



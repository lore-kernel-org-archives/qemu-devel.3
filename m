Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C0606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Mq6LdzXP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsEN-00064T-OP; Mon, 02 Nov 2026 08:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDI-0003Z4-Tp
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:41 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDH-0002Lg-9m
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:40 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c4c9abc1824so462327566b.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626598; x=1794231398; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0cdn64WeUW3Way1jjCtIVpAHZi4hV73QPVPO/GKMz0Q=;
 b=Mq6LdzXP7w7JDom75GGHxEUpPhH0LtacEOkOO8FAO4HcEPlp3EpvMF9mFCpYM7tF14
 Z3mLZQXnuGQtM6/KCF9fsgJVCXjZbFVFwu2F+jcC8rnRoll+yoEO8o+EHS8awO/wMQrc
 kGZUGFRmb6AnQ6Mf+WTFEz9duFs+ett9ueIZpJM0qGzsqtcLUN8AmaPrkBpj/jnOjuLw
 g7GT2ollthdFpo+jHUCsiM06LfcxvkZm7SDDqaI4EdVZAXNgiKbv8u7/6ngNECT2Rmc+
 k+zDNg53SNJWwIf53Jw/3pY+BPqbHIUFPiGqf+OVJeSVH883LMQrB5aYD4lQ5CUSYcqS
 3yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626598; x=1794231398;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0cdn64WeUW3Way1jjCtIVpAHZi4hV73QPVPO/GKMz0Q=;
 b=DcxUYxSISQn2kH5imLGKtQ1A8XiEazfg5fklNT2xRK7080OcEa6chOhhXig7ePgTdH
 WeeTBRRmo5bGizfuLvzt88TsQehDgKx5+mrCoQV4AsGyLtdAZhLAk2Ype502LAiRen4E
 IzavAB2yb4SczybAIXOvKIwbY/84OM20LGxURFcAH/D1dCAvIOiURSsA+1zesiEn/4hh
 Yu/waIhQgqZVwJJyQ+CQ8xYVxMFW8R/5dbKXoujnOtf6c2ostQy8TcOSdbUpbYCI99nv
 v47AAPiEU7Y8fDMek6tHu2ZSvRWWdOs/zUaTchBCYvEOgWtlAaX6tY0VFtVT8ymsGZ2E
 QKOQ==
X-Gm-Message-State: APuU4Z/S6QV/YH1L2tX/l+X7GS71rLat2eA5LXYUQyov4bG8KPNDBgwR
 AmszJ11MeAkaJ5s6U+bOiuNthlrhrQTXyzd9TlFia4KeZjQt5B4SzlQF6Zd98EspkUy6Xe2lKKW
 AhANHYjk=
X-Gm-Gg: AYBFou0F5mv3Wl5fbWP05cO+KUyjZrclyqQsynOvqCyXlPJk96ZXpTb6Lh4lOO0/BL1
 ffnZuzO/Ntu2wQ+qwrAnOd9kYw3mdH9u2KYMQrJI3aa2TEEQHeZdgaKxrHMJC61XPJnZjtXsC30
 AxlXSCmy1q0oLLawcHBbnqia097xJWkD9kFZDG98z/pixJdU+xtmchK7GB65xPQFAXF/fxWOdZY
 +U51aKux3AyrlMjo2w+mdbtdmpR1tIZGtAp7aFPY3NPaGCoKCR9N84kf1oIWwbLqwBeTtzlJj0r
 7T7tkNxd0vJiEkYoyZkWSq1z51eZiuiQCqPNSkwwS/zoXFoQnMZcJB5qanO76dMj3ySQHz5KpEW
 jE4Flqwq4IJLxfrmiCmgg2uVhng0uhf6g5+DUVOs4O5njrfBrGOjiNo5/NgOkIx3iq00r6tGlJq
 bH34neLiEz/LT26nePLWZ+x9B12U0A7V4gyFTm8TEpMYtxaf231mH5Ebhj9HaIm5ZF5gxCbVX1W
 FGQcNXGm9tvmYW7tWJrP+2pMKskfuvvD1exhlrL3mRb3nv5HdBc2CMR9Mf8HAhsvNr1H51Ez7h8
 MAqgI24VWgv2LN8Ttq9A5/Jmhji/UKpB6vdI+t+pTgEi74VBa8euALH4/fWuup1UAwWnRitti2C
 a/7iV6OV5aSqy6/iJxnCSkvra6h8UUQ5yCg==
X-Received: by 2002:a17:907:a785:b0:c46:ca3a:10d5 with SMTP id
 a640c23a62f3a-c4ca7ae14cdmr867954766b.45.1793626597632; 
 Mon, 02 Nov 2026 05:36:37 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/47] hw/intc/arm_gicv5: Pass cpuidx rather than iaffid in
 gicv5_get_hppi()
Date: Mon,  2 Nov 2026 13:35:43 +0000
Message-ID: <20261102133547.1375701-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

Now the CPU interface knows its own cpuidx, we can pass that to
gicv5_get_hppi() and avoid the IAFFID->cpuidx lookup in the IRS.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/intc/arm_gicv5_stream.h | 4 ++--
 hw/intc/arm_gicv5.c                | 5 ++---
 target/arm/tcg/gicv5-cpuif.c       | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/hw/intc/arm_gicv5_stream.h b/include/hw/intc/arm_gicv5_stream.h
index f45072d8c57..641f3d0f499 100644
--- a/include/hw/intc/arm_gicv5_stream.h
+++ b/include/hw/intc/arm_gicv5_stream.h
@@ -204,14 +204,14 @@ void gicv5_forward_interrupt(ARMCPU *cpu, GICv5Domain domain);
  * gicv5_get_hppi
  * @cs: GIC IRS to query
  * @domain: interrupt domain to act on
- * @iaffid: IAFFID of this CPU interface
+ * @cpuidx: IRS CPU index of this CPU interface
  *
  * Ask the IRS for the highest priority pending interrupt that it has
  * for this CPU. This returns the equivalent of what in the stream
  * protocol is the outstanding interrupt sent with a Forward packet.
  */
 GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
-                               uint32_t iaffid);
+                               uint32_t cpuidx);
 
 /**
  * gicv5_deactivate
diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index d354ac6b992..5d0a50ab6aa 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -531,12 +531,11 @@ static void irs_recall_hppis(GICv5 *s, GICv5Domain domain)
 }
 
 GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
-                               uint32_t iaffid)
+                               uint32_t cpuidx)
 {
     GICv5 *s = ARM_GICV5(cs);
-    int cpuidx = irs_cpuidx_from_iaffid(cs, iaffid);
 
-    assert(cpuidx >= 0);
+    assert(cpuidx < cs->num_cpus);
     return s->hppi[domain][cpuidx];
 }
 
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 74c456f60c6..46039fe4a4c 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -147,7 +147,7 @@ static GICv5PendingIrq gic_hppi(CPUARMState *env, GICv5Domain domain)
         return GICV5_PENDING_IRQ_NONE;
     }
 
-    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5.iaffid);
+    irs_hppi = gicv5_get_hppi(gic, domain, env->gicv5.cpuidx);
 
     /*
      * If the best PPI and the best interrupt from the IRS have the
-- 
2.43.0



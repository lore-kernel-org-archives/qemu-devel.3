Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD991CD3427
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuG-00041G-MC; Fri, 01 May 2026 06:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktz-0003wP-Du
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktw-0008Kc-VI
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so15950445e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630515; x=1778235315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1SqFziae8xxmF2dq3qr29rHFjOIsHc7vyCdhmtS47b0=;
 b=mqbWFg0fzkAJ2v07KxM1MdPhmvkeAI+zoPxUMCYR7Ev9quDKzMa1o9JL/rLwPSW3bT
 QTtBjN1wsrNiWwj5DoDYuacR2pLNuX7YgaFsEjLRiLBNYNl/D/lnwQx4qPIU+DKY5YvB
 h/XB4WqK8HLyM9iHc7z9ApbvAl+xzu50WcYhqpVLJBAS+lkdhLBnaBlH0kpSk+TjVwY8
 G8wgS7BsXGsoroi5uIK66JfN4+eqzVyrQE2ibnYS0IkzT4IxkTbjNs7opg2WMwz+b7Yk
 ExLUu7ahKPsdE9atBU/Pv6HlZm8pvE47ke/+k8NMyQrtCiVcmtpHQsAQVpqnLraF/sRe
 Nvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630515; x=1778235315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1SqFziae8xxmF2dq3qr29rHFjOIsHc7vyCdhmtS47b0=;
 b=JMBSSsMRD+1NzwCHhqaT2iYe1xBCmuV7fyI/iaDsJpn/RWYAPMaOq3x5DInr0VRr0e
 qqe2764Z7pzSFQ0z9MCd9x80QaD45lDE4LJ4hQFodTMYnbOnngA9W11+HhFw1vXuFZEp
 qzHh5oRNmDOcohtFI39mwPXcDQIwuwxrMfUZI2ArxTSTkdw9Ubkv2teiB/ANdCallqK1
 aJ0lRNAnBDvHln5LUVcI+CvTrv+K8XD8FiM0DCNgvlIGWpJBzEO4+6hnROcqYgTDo0SB
 Ck62K/90QMNo64xX/UfVA/6VJgui1DnfC7+PKfwMeYCieO8cgqsfZy4zRgM0pherDSO+
 /5Pg==
X-Gm-Message-State: AOJu0YxS9kDTYx26HDAdeILjbSDmSU5+s51j6v1dvZdKuoSDkVgA01NT
 iiarRADITus8jOa0WbXewur2w14BZ/rnH+z7H52DWYbR/73qg9HeHyQz+sSJnydoVHTQs0pHQ0P
 wjFIL
X-Gm-Gg: AeBDieuV8E/fudq0QXccJRaiwIZ92OHuVAB8vX9jWFwHXxhiYeiFfMXk2hstSJa7p7f
 i6VN9wLfpRj3lXCgFlpXXOEDOLs1WHJpMEP18G0pgDyKIPHtJ30bZTDF8oKXGeqUiDizYZcJeOQ
 ozGnKUrCAZ2+ase89ebir+BWky5W6ghCUKVtknUmg1ozFXU0QKDQOeQddvFqpN9vxU/95inqX8S
 fTqeJ9Qyjcr4K7bJYbxOMtWF1RxMuU4/4UcdwrJ8D6hDGi3jmQ44dNeD2EfWmiKsCpNqea08j6j
 2+NgqugDAHD7gDhBW6RIkCEpdnCAAXY/hcqhyfUUYv8Bi5jClYKWf0oM8vfobBkPNE6zn0EHVV0
 ZnDy+D8emIwmAuf3L6wXXYd2Cyv49xCKrvD3ynf35ZvJsTRDWyoxM7P6hs9ikYI28wqk3dgmLrz
 jxNIjenS/cGWC8k7P2Tgbtdk0O19macW26/9MpV3SiGWFEgXu/0QsgXK0uBnmN5esDsILJMQSD2
 3HHMRfBX0DCVjHGkbB07Mf4u4vUDmG5nb/83kWQCw==
X-Received: by 2002:a05:600c:a416:b0:48a:568f:ae6b with SMTP id
 5b1f17b1804b1-48a83d6ec59mr92232585e9.7.1777630515499; 
 Fri, 01 May 2026 03:15:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/28] target/arm/cpu.h: New GPCCR fields
Date: Fri,  1 May 2026 11:14:44 +0100
Message-ID: <20260501101505.3485916-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Add SA, NSP, NA6, NA7 for GDI and GPCBW for good measure.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260421-jmac-feat_rme_gdi-v3-2-ecd20c77eae1@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index be14a47c35..5e4f12f1e7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2091,6 +2091,11 @@ FIELD(GPCCR, TBGPCD, 18, 1)
 FIELD(GPCCR, NSO, 19, 1)
 FIELD(GPCCR, L0GPTSZ, 20, 4)
 FIELD(GPCCR, APPSAA, 24, 1)
+FIELD(GPCCR, SA, 25, 1)
+FIELD(GPCCR, NSP, 26, 1)
+FIELD(GPCCR, NA6, 27, 1)
+FIELD(GPCCR, NA7, 28, 1)
+FIELD(GPCCR, GPCBW, 29, 1)
 
 FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDAFCCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvi-0001fF-V7; Thu, 15 Oct 2026 14:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvf-0001Yi-FB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:47 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvd-0001X5-Ag
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:47 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-53440816851so19666931cf.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087904; x=1792692704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QE4U9ew2o98ttAUkAHBNIvgA7JA6fCm0GzdYQK3cqP4=;
 b=q4lwdorUZygvnyG9SxCeeVYr30NUkAGXNAqvDEg4FDzo+GRXjLxrJ70+mUab19xf7Z
 je0Mfm74wgSWED3af/BmGRYuXiqNTs/95yTF1kct5EYU3KB6nt2+jCrbD48EHTBnaMSZ
 YVtSygdJohAZTW35CFwnAynVCqg9YgWgusEzP1N6jgJO0audw9aJ+vKim6MkhJ1cDAuK
 kaCl3LZJ0ZL5qiMqxs4e4+je6RQCk9n97VHOznCEtV7WaeUOcwZ6Ycfa1PwfpYO9GWWK
 m0bjluuZOHDcwzpSFwGFQlkaE1y3gATu9nbC1L3fa98KTlW2NsDysxd0icao5kcxJTdy
 Inqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087904; x=1792692704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QE4U9ew2o98ttAUkAHBNIvgA7JA6fCm0GzdYQK3cqP4=;
 b=vJGCPEj4g6lG/hwueSt01j4l7TNVuPOcY9X35xv5/ETJ3AXIILO5TNx2WW9ZmMfSH5
 sjpaqQh/n6SLbo6ABAmSFADyhLbd+0n+rTLaeY6zT7S4ohzJDmywWcKlbcOw+VepzIxU
 /9ZzkU9NuOMz/yzG+Ht4+VbY/gvZqudbt9sQl1I+ANvPI4QSO5UR/cjzH8sFllY8tYuq
 6LnVcEhkXR3VZVJpVkP68cN4qZ/94GMHP5wRTF8QAuT3jnU2pNphh6E4qjAppuN2uj6L
 pCDWVK6n4zM5idThz3INYoFYUS0jUG3UZvCqC0/CnMY2UNkof7fmORlF262q6x8Dcc2V
 1XYg==
X-Gm-Message-State: AFq9FYLFDPaENmMliqYG4btFg/GhGH4LoxxH0O+ijhtd07Goszv4+Ny4
 Z0fKXKO4CBhZ4j7Ao7Xjhg224doTE6Kw2zZiIAHfQI5Ais6zExovVODlcnei4gpe
X-Gm-Gg: AYBFou3s827uvhCf/3KrmM0xg/xpkupmvW05HsYfawhVNTxJdnTorMWfAeCLyQriRCA
 odF9SlwxFOHVITqOUNy1dZ5Ji9pX8dC8Hz9aYlrbDnqW88ssRFWsVS7LCagCYxSzsrpL4kI75/k
 32Q+a/nArmQb0JEw7CSPHYfzHzA0mRdDIVpdprmodaCouNO+t+l4mQVT9Imot31hOL5rqV32laS
 tJn8/VywfDp38fjdYZg4FPOTXZcWHPzt1yIN2WK/utEEblepomKQKXKphWxZnDY5k2KQ2lG9GNg
 WPE2fYTvo3pLtengUPcdgmsaSeygGMkYfuSM/T/SQ/i20W1b5fTjgkfwN8U+8n7zlq3b4MRP3YS
 KoxbN8oe6Bx9xpueNhh1ivivLqy81JwoyrJ/lB3VKppCUyCcNXm/xfzbJtgasS9H69PpnOJzWQa
 Sc4NP9ub52gHGim4kPZZ0PkI2er/X2JU0HslzVrp3Sqfyhj44B2qWAyy3WDI8HouCZ7/nNWA2TU
 jxQnx1w7eVmO3LoDKBCUw8iENJnT7179qsUwTBwspFbUqopIC0BB2Sj48GSspbpGvnVazo=
X-Received: by 2002:a05:622a:1343:b0:535:a5f9:7520 with SMTP id
 d75a77b69052e-535a5f9780cmr323157561cf.63.1792087903949; 
 Thu, 15 Oct 2026 11:11:43 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127efe4asm32130611cf.19.2026.10.15.11.11.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:43 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 15/16] docs/system/arm/raspi: move PCIe/GENET from missing
 to implemented
Date: Thu, 15 Oct 2026 14:11:20 -0400
Message-ID: <20261015181122.60608-16-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181122.60608-1-marcelomanzo@gmail.com>
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

raspi4b now has a working PCIe Root Complex and GENET Ethernet
controller (added in the preceding patches); move them out of the
"Missing devices" list and into "Implemented devices".

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 docs/system/arm/raspi.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index 44eec3f1c3..a8fc37e920 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -36,10 +36,12 @@ Implemented devices
  * VideoCore firmware (property)
  * Peripheral SPI controller (SPI)
  * Broadcom Serial Controller (I2C)
+ * PCIe Root Complex (raspi4b)
+ * GENET Ethernet Controller (raspi4b)
 
 Missing devices
 ---------------
 
  * Pulse Width Modulation (PWM)
- * PCIE Root Port (raspi4b)
- * GENET Ethernet Controller (raspi4b)
+ * PCIe MSI/MSI-X interrupt delivery (raspi4b) -- INTx works; a PCIe
+   device that only signals via MSI/MSI-X needs ``msi=off,msix=off``
-- 
2.55.0



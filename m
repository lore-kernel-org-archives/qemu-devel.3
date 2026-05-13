Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA019CD4F35
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7H2-0003oQ-3q; Wed, 13 May 2026 06:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7Fe-0003BD-JN
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FY-0001S3-Si
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso75840505e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 03:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778669735; x=1779274535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pF8Avu0vc4X7fk20J7cLa1Br/gq+YuCxe6Pf3cPpIE=;
 b=a65f97hWhfCcXBMkRE9jRRLZeP3EvCiH8HYB7ImclGdxDS7ubwPVR+Ar27ogm/eC49
 e10G2x1/x6eswmkfqU1E3HJdnEM9ojIj1cGUoFWkdKwremsio85p0TpFpZLzAF6+u5A2
 oiPbzMIEBCN828+zsqGCSyDE8aLwoJrEmSKdaifMgEzsaMXgfhU/SPbNAVhjKz8IFIRv
 tD48GFibDd+lqY+je5JvnL2kkF1VGw0TAEmCb/4jgOrdYGZQrBHOVIjf2N4hnuNRHrxM
 DB0zeDMMhhY2IIyYoXa+lGFADLZIRnQ9pe2vzqhclcS90KBDrfBw2ECOv5MVjo6nj41f
 GCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778669735; x=1779274535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4pF8Avu0vc4X7fk20J7cLa1Br/gq+YuCxe6Pf3cPpIE=;
 b=PyjxVDHerQz2/tMmVq8AWMHsEisxGtV6aGW1y4gdwdv624FGSB5L7qxpVKuMDZ1I/W
 ZQDUp+lEPZ6bkwKHKgRr7V53bgbwGozC0q6TpsGu3BTgeysR0R1tpnW3BzCG+3F3/rEC
 XRb4Md9M3Gs19JAVq9NqGDpqU53vBvl44/I6drwUVo8OP/WDanV61TXpcf6f+Iz6qEin
 idhsWGi/cI5V5eQ/w7wPcDne/u083rN3Ng9o+77Cdm67r9gLXHzf+mq7WaP4gfedgKyx
 uET3ZKy5dGovdg/0PAGAVrzEp8jdTDUAeZKswr/fcITFFPrWQv7X7zn7gLridENgv1wP
 UzhQ==
X-Gm-Message-State: AOJu0Yy+qC+TXwPCizgiUjItgwiWKWtVGdCcs8qyTAuO1Rgv/Ke7p5t4
 GO8c/8vIHu5BYPX0okjNztVmkHk16OjTv7PGYLZPNN5eYJZC5QkQwpIZWKLeYFJ3
X-Gm-Gg: Acq92OHyvSIuF6WPsWi+vLZi2bt8H2b/iQC57/x0Vfj7A8JuJBUKw72wIEhlblw4L0V
 6GknjOwW+NMRYgIuMQhSLL2hY1SMncBRB2WOe5f5zFe4vh3wWBHpadA1p9ofKaNMqILxKCcPmrO
 tp9dRIi3aZ+10D4M14xlntWqtpDfHWbH76VfSOpe+oxfSSGgo1/jG9ppDvk2TgNbvhH3PPlFocl
 8lsPNipQiAO1FG6Gb08ZRbp7OhzQBn5ZlWS5JrV+XHudlyjkJ0k0Aget6KHMeHEfIlEv+RzZH69
 fZwDrWUGpt50TbMc7X3oA7S0oKMATDicnW9EM10/w9eWnQZ+FESiK6hsmjb0WmPhRIFmO3h6EA+
 yYETbzymsOhFaWxsH2q4dnPKSTWOXZ3udzoSHIrPOAso/BrTgXniN+6ztkbh/oPFgwzIHgmvkkq
 cUEEqwGp/uKilBzqA9ugBWiUe1aR392u0LmxTsJMU770pY
X-Received: by 2002:a05:600c:458a:b0:48d:35e:82cb with SMTP id
 5b1f17b1804b1-48fcea00b19mr26649975e9.28.1778669734664; 
 Wed, 13 May 2026 03:55:34 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410d9fsm56062295e9.6.2026.05.13.03.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:55:34 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v6 11/15] hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
Date: Wed, 13 May 2026 12:55:13 +0200
Message-ID: <20260513105517.146706-12-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513105517.146706-1-corvin.koehne@gmail.com>
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32d.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

The is25lp016d has 4 Block Write Protect Bits. BP3 specifies
whether the upper or lower range should be protected. Therefore,
we add the HAS_SR_TB flag to the is25lp016d flags.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/block/m25p80.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b8a2543c0b..4a4cda6602 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -217,7 +217,8 @@ static const FlashPartInfo known_devices[] = {
     /* ISSI */
     { INFO("is25lq040b",  0x9d4013,      0,  64 << 10,   8, ER_4K) },
     { INFO("is25lp080d",  0x9d6014,      0,  64 << 10,  16, ER_4K) },
-    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32, ER_4K) },
+    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32,
+           ER_4K | HAS_SR_TB) },
     { INFO("is25lp032",   0x9d6016,      0,  64 << 10,  64, ER_4K) },
     { INFO("is25lp064",   0x9d6017,      0,  64 << 10, 128, ER_4K) },
     { INFO("is25lp128",   0x9d6018,      0,  64 << 10, 256, ER_4K) },
-- 
2.47.3



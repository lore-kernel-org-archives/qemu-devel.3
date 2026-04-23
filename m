Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78672F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqum-0000Lz-LM; Thu, 23 Apr 2026 06:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquJ-0006n0-92
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquH-0002UT-Cc
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483487335c2so63379725e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938616; x=1777543416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rdwwawiR0FXaLxRIH+hmzlhv7jRlEW/KPTZ/pEJfBfA=;
 b=TuPLKQoJczCuxNSFbs/zXp+F/UKcrVAz4beYy5ZstuNNtbd2QKaMTyRpWNUHkU+y3l
 rmtjRV/BU+5mdOcPL6lIgzGjOeLVD00GezNl4uDnpPvkIFHwRAOSRWNTB6uD+5S3TJZs
 +HeHr0imeg8u54HvjMGuAyRvo8lc+U4TtGvEaT106nx+sbCWKcWvK/Iv1oRRGpBSCPWs
 7qEFus5utJ0pK6Gpf308h10Nl5etXQ+1JXlfrzeM57rfLtmoxv5ePu2AchH+YExqyQ/8
 in6sRipL4LZ2olzbl4viVp0nHiOoJgjcy9duN1NYLtXDRYWaAB1Tl2dGtgOCzS76oFTT
 ar3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938616; x=1777543416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rdwwawiR0FXaLxRIH+hmzlhv7jRlEW/KPTZ/pEJfBfA=;
 b=g52WJ2y1ZWJEWg2ZPAfaFlGlB4I32A2c1Ff6jeDEZrV0lwvj86vdf4Lzg65QgGnh5I
 CldBrKBhxsiZsUErRN1Skk08+BiLl+YulqCQtL8dFqYpWO/sHEz9lqxnU2xNHQ4ANG4c
 0U0PtToJMibz7eOrbGMESEMDTJpeTeGPIt1EcBKIUuqz2gO/YvlqHD3WCwCmul+puZ4s
 aC8XUApapNpGYN8ufMQ9TiXq16x4AUoEQowdM77H56qAflTe6GpGOvq2bZH6Bpo5H9dE
 rAnJJU6C501iBDsIacFU8sUTR2u932Jg+DmDjIeZqw/2iuV6mlToC0xM9muVTQW354fd
 NKxw==
X-Gm-Message-State: AOJu0Yx2R/vr3ulj/RFgdDXmTfXGb28aM23k8VeMwc0ut+8D7ZDtEBvT
 O8aR0dAIF1QNAfTKwIYDXPC3SqCo3GbiTqifD+vuOayXRVonQizfyr2szziCvcH+6bAqia7KRzi
 CwB+w
X-Gm-Gg: AeBDievdiolY6/9J5H0HFt3TetanTp7SaZaU7m9Mr5EglNG2DzXHVR56T1DvOuCaZRw
 QS730WxNSA0p5d3I77YW+lch+MJnH47JIxCoAN9NkIf+qvnjtnCL9C1Inn5aUl+3SPQJxlO3OMB
 QsYavUFYpVJdaGFLkPsQogHHKMx0CwNe6WIBdLnwsmEoU2L/aExFiXRDLaOigZrrlFP9MCnCAlx
 u2avhiRFg4Q0/nDScBmBMBuKgf0owUa2nU4PpdlJqGJudV5izyrmiCHWjWblwJhByH65QcFLGap
 5NmfPLfTbwwYFHskPTCA9DJCW1j/ircsn23zFfteRxMxr2u2tI82svwCko5G1uqqX+ojIOemrPM
 aUolG4WHo82ckHHqrGiL8tFM2sICZAfNUAG4ia+BuYTVNUdi8knI9IV/JjVa0+ZEqs6ynb9E87I
 SyaHa7mlvpERg5abWBlJrI+hszL/MKB3uKXQkpcd8N1MNnquN/bh3tJsSUlMRU1GgqvJzJbwtcG
 VScVtu3/HZMTuaY2OZtKEMFoXBRV4i2KOj9ZHOhKw==
X-Received: by 2002:a05:600c:a404:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-488fb73b2a3mr314608675e9.5.1776938615701; 
 Thu, 23 Apr 2026 03:03:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/59] MAINTAINERS: Remove Xiao Guangrong
Date: Thu, 23 Apr 2026 11:02:28 +0100
Message-ID: <20260423100229.2941820-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Xiao Guangrong has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-28-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55fc63d298..ed77b28c2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3319,7 +3319,6 @@ F: scripts/coccinelle/memory-region-housekeeping.cocci
 Memory devices
 M: David Hildenbrand <david@kernel.org>
 M: Igor Mammedov <imammedo@redhat.com>
-R: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
 S: Supported
 F: hw/mem/memory-device*.c
 F: hw/mem/nvdimm.c
-- 
2.43.0



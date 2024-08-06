Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EDDC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJi2-0001Ym-2g; Tue, 06 Aug 2024 08:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhg-0000F4-Oa
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:24 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhb-0000MA-TZ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:13 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef32fea28dso6962461fa.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948849; x=1723553649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gv+R0AOxTRNRr/YYta1DbILbzN2/ozjvln37VG+akqw=;
 b=pMqQlNuhvjAjZ/LZtahOeUPMpwtwcsQFzPfPSHOwHYr8IkA18U5kfNmpnN2Hs9I2Ef
 fr/v13JgebmIAV/bw843V47ESuhVkL12S4hxqUwtWbAssE0ywieUrlHQaq6HCzf5el2e
 cRXzgVkOoOwhbP916+veJqzy+OU1gSZWeDyoZfBGrbCGFy58R33bIFDghUpbiwX63SkC
 9Y6jgtdUOLDF7ySuw8RCpx/BfO8pwNKfEo9hFExBAomWwQA7foD8s+W1ZhgaqOMQTgYV
 37Z+hoDKoxyl1s9V1cuhAmQQdWa+crysZ5qP0NaKYYBNsDNrGDPxgz4hOHXlZ0xAdseU
 H4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948849; x=1723553649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gv+R0AOxTRNRr/YYta1DbILbzN2/ozjvln37VG+akqw=;
 b=n01DbxhFfyrmFQpo/prEma1sy7EMVZvkRNcrqOHXPq1WOdEHomwIg+gZzy+anNeSLp
 qA5AZsIeE97j0GQeIyWWcJLgtJA1kNlYkYfxnq8llA16OLlCdHulvDnWvqAeZDWTFB7w
 9unmV2kubi2nX/i3T7zWEe8URs6QxDA7sqj+WJbVNeQOCzbgH5Imdy+rhN0Ub1DAaA+E
 qAU89IQAGPdhp2ybRzdYsY3GHmwPePek2gmwC+sZeR5ZQI4WTpocgRJe/X1drpDjurev
 IbTsw7DIBOeSo/IOMdZGszDAfMke/GBC1Xy2gxvuRF8IBrpkqEZVOB+ItxfhNht36Jjy
 5MHQ==
X-Gm-Message-State: AOJu0Yydo86uBHraLbzIH4r7b1wbciCrtXTOLMorZ+JDTO5sitOsIefq
 sx3p0XdzhF7S/GgvTdEMx6Kx9yCONDV74N8MHMpIIXOP1vMMYh8czuWQ0UmAtP6S5QqLSY+4rVR
 S
X-Google-Smtp-Source: AGHT+IEjUA7XHVQZQ9IKvGvDk1ZhAIr83KVOzxwR2ijFBWm9ba6PraKB14zqi/sY1NsIg+m0hfzMvA==
X-Received: by 2002:a2e:98c3:0:b0:2ef:2b06:e554 with SMTP id
 38308e7fff4ca-2f15aa87375mr99364231fa.15.1722948849227; 
 Tue, 06 Aug 2024 05:54:09 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bb88d1d9a3sm2558061a12.26.2024.08.06.05.54.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:54:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/28] hw/ide/pci: Remove dead code from bmdma_prepare_buf()
Date: Tue,  6 Aug 2024 14:51:49 +0200
Message-ID: <20240806125157.91185-22-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Coverity notes that the code at the end of the loop in
bmdma_prepare_buf() is unreachable.  This is because in commit
9fbf0fa81fca8f527 ("ide: remove hardcoded 2GiB transactional limit")
we removed the only codepath in the loop which could "break" out of
it, but didn't notice that this meant we should also remove the code
at the end of the loop.

Remove the dead code.

Resolves: Coverity CID 1547772
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMD: Break and return once at EOF]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240805182419.22239-1-philmd@linaro.org>
---
 hw/ide/pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 4675d079a1..a008fe7316 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -237,7 +237,7 @@ static int32_t bmdma_prepare_buf(const IDEDMA *dma, int32_t limit)
             /* end of table (with a fail safe of one page) */
             if (bm->cur_prd_last ||
                 (bm->cur_addr - bm->addr) >= BMDMA_PAGE_SIZE) {
-                return s->sg.size;
+                break;
             }
             pci_dma_read(pci_dev, bm->cur_addr, &prd, 8);
             bm->cur_addr += 8;
@@ -266,10 +266,7 @@ static int32_t bmdma_prepare_buf(const IDEDMA *dma, int32_t limit)
             s->io_buffer_size += l;
         }
     }
-
-    qemu_sglist_destroy(&s->sg);
-    s->io_buffer_size = 0;
-    return -1;
+    return s->sg.size;
 }
 
 /* return 0 if buffer completed */
-- 
2.45.2



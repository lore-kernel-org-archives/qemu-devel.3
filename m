Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22848C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb2Ng-0000w4-DA; Mon, 05 Aug 2024 14:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb2Ne-0000pp-Sh
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:24:26 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb2Nc-0000d1-VS
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:24:26 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a156556fb4so14797338a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722882263; x=1723487063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DTDKOs4NblzwzJ0N5OOLOoi8TReGq40cu1V5/g5GREQ=;
 b=ZY9LvPke0ecpx6BcKaOkUSRpyYgFZpAMF2kM5ndqt3bDQmUnWzOwGqqDZnw2DyKPqZ
 8ueg8jqqE3CxpH5iGiR8AzKWh3k5Tf7l4pUnIDBccVh9e7Nd28yGsKUC5NjirRkLN4Fp
 1NDQdWSbuPJLdQNFwrLcQ3g6BIQ8oFV4DYAaV4ZUtzYNfFNK75/t2EBaofiHMiSXGXQJ
 m/CcggF1IuOgOWdhKCXsIpKH7dKAKgLXJ1cDtZsLNSEGnw6uW4O3HDz8OLEPET67ZNEY
 Z1RIiNPghD4oyz1zJDxyjKAuDKua4nu7QOBo71wHwXyDeD401fT21F6inw91Ko7tq7L+
 P2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722882263; x=1723487063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DTDKOs4NblzwzJ0N5OOLOoi8TReGq40cu1V5/g5GREQ=;
 b=vPC/sxZm3bI7jyg6HwqcTqZSeyPesFTOHTVV1S4YV62njo8vMMYR8RnzGs3l56sTiA
 CWCVIHstdEuPbMkyzNEv7i1+1eGH2qt5AcuB0SN4Kr0JWrLbqyOB9wY3bQhY3NlIHorn
 G6El7zPMu44XgXgzf/91sOpO4UjJ41UUwSrjGWsBzsGx0xU1zfDqXGf1vy095Q17lGDn
 lohWfxn33Cn+dn8cAztrWTEsv1u+EwTFvfyvuzQY76EQUXE4PwUxvyFebmxA7ytfRNJ2
 EZ8Hiub9Mpo+/s7/R1Z2Hnqwm/32IEL6ql+htcoHfFu1yT7jX2zopYaRlVWB+eqLgx6z
 m5Rw==
X-Gm-Message-State: AOJu0YwTCTipkZZA19btAGa7xHwFVW9EpyZKpmBXX4KYzC1kX6PnnuhO
 vCoHAy9+RrYHAiiJ3qGlVnyY2flSinSTLJGRjsd+PJAeRbEUb2lvU9AL4sUBuvjmtlhLZ5azP6H
 N
X-Google-Smtp-Source: AGHT+IEj+wzw32YBLKgTjPm5Y9HvnkWwvyRoq+WH2afLUcMqIW/Zz1y2lNoIenYh2bWRRHeWZUk79w==
X-Received: by 2002:a17:907:9492:b0:a7d:3ce8:131c with SMTP id
 a640c23a62f3a-a7dc50fd837mr735801566b.62.1722882262744; 
 Mon, 05 Aug 2024 11:24:22 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c12ff1sm478583666b.58.2024.08.05.11.24.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:24:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2] hw/ide/pci.c: Remove dead code from
 bmdma_prepare_buf()
Date: Mon,  5 Aug 2024 20:24:19 +0200
Message-ID: <20240805182419.22239-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: Break and return once at EOF
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B525EC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggir-0007Xf-KI; Mon, 06 Jul 2026 06:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiS-00073R-Ab
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiQ-0003R0-S5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so20659005e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334297; x=1783939097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mEqVNkIeQWef5D3Dm101yBk+cfniIq8WOWmVgto3zPU=;
 b=nBOkPEV/yqREBAabv5wrhPDheCOHObOEJMflpR271CTc5o1mutU9vHKCPRsoYlpNv7
 6yhCCJPdai2GYSri9dkO3en8QRbn7szEkgo9Z7ybKm+Bg1GzLRl7dniMIPLZz4ocI4ri
 Dr/o8oNdDzYd0oaj6dImIv38FSaoiTG17z6wZix1PnwS8ruYbWQ0kdPhNGTIKFviEPwe
 sbR6lmzDwcYBeCyOCioPKgdTXSuhBcgONm/hk+q4B6eB8apVSZfJzHHzjk+kXhsFPtMY
 8y0QN/0cdbbNhRDd8Uvmj3p25ydt5niebQxFnWLtkv3JARYVsRu2FCQTedInCUmrfVsV
 YE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334297; x=1783939097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mEqVNkIeQWef5D3Dm101yBk+cfniIq8WOWmVgto3zPU=;
 b=CVaO2AwHlpWCpGM80qEayPgg1sTi9dFJSKBZKndh0gBPNa4kLbHmgoVcsHezfewxSF
 LqTRZ2SB6A1gzwKKPNKc0kdYIN97uEZMlzfWE53jyKUCLuOFmBqxaPE0MHc5GZ7G4zOV
 BsP+uDqRTNNCD4QeZz0MrQ5JUatk7LbJ935LStEIgid+oCAXeDqAmqjQcQXXokINibdy
 DTqMG1jk9jmIFQ3ONpUl3kRnz432nW6Lt5b4NB3MtHP07myk3r4ulfTo/1aWMyImoG5w
 cDwD+IIv9G+E6S4WUrUoNLMREgJ7qg1Tc8sYMGyS4s1QWRSIReLP9O17UqdD7HVnbPK9
 MKiw==
X-Gm-Message-State: AOJu0YwRKxV9Lk9VGBtwuthZ5EoHBwhikVYtZO9oBqEzc1c3CSdWGUL/
 HEwO8NSfwMvbpwEymolNR2K/Q2H6/parZfz96GKyHncnE6TdLMCr4ay9uliEN2Pq5MD/EApwdLL
 Rtf4d8dQs8g==
X-Gm-Gg: AfdE7cnGDAYejeWd6CQVkThacLZ3uQQp0pC+PFzo0PlYIKaHxthPfa3riMtlMeP0zsU
 6w94Sg42gEixjArGRAWCOq1cnggJMwatBLLGCIM0oi29k83lkdvAy4Xm1Tiow7CF791wqOhRqFs
 sFVKj/9kL+nDagXfOIenzCLp52hx/dSIs+KIC83pEe2gedBP5zdeBhBVL0dNCxULmnco3VN+FUy
 7UoiZ6yt8swbhV6MQ0BPtlXdd/qZhK+OCyxN6aTsNArQFyrUiQKRBnMTpzF7laOmrlqdwak9JDm
 b+BSBgzNagyuvVTwg9yIIccqcVTTCwPwaBjvJs02CAaCxhJdlzTEfp/HawdjrvnTQvbaOIIzpTO
 UgZyi6CvJv7zDtbTEVeVi9lRrJpDtfHmi8EIoG0Qs2QJhczs1jeUQSG1H5PhQffqmFrYFe8OPry
 FPyWdYFQDnnij9MvdaQmfhUO4qOq+GjsiKnWMaZM5Ee+ZvgDMKzUYrM+PBSobi/2IlrOUyCKy/r
 CykXKQ1I4rWtA1Cowdguw==
X-Received: by 2002:a05:600c:628b:b0:492:3237:ddf with SMTP id
 5b1f17b1804b1-493d162bb31mr99509525e9.28.1783334296829; 
 Mon, 06 Jul 2026 03:38:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/49] hw/nvram/fw_cfg: Remove support for I/O port fw_cfg
 without DMA
Date: Mon,  6 Jul 2026 11:37:24 +0100
Message-ID: <20260706103752.320511-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Currently fw_cfg_init_io_dma() allows the caller to pass a NULL
dma_as argument, which causes it to create a fw_cfg without
the DMA port or DMA support. None of the callers use this
capability: they all pass &address_space_memory.

We don't really want to leave the door open for some future x86
machine type which doesn't support DMA for the fw_cfg device, so
remove this, and instead make the function assert that it has a
non-NULL dma_as argument, like fw_cfg_init_mem_dma().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Message-id: 20260529174639.451353-5-peter.maydell@linaro.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/nvram/fw_cfg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index f68191553b..a9d45adb2d 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1026,12 +1026,10 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, AddressSpace *dma_as)
     FWCfgIoState *ios;
     FWCfgState *s;
     MemoryRegion *iomem = get_system_io();
-    bool dma_requested = dma_as;
+
+    assert(dma_as);
 
     dev = qdev_new(TYPE_FW_CFG_IO);
-    if (!dma_requested) {
-        qdev_prop_set_bit(dev, "dma_enabled", false);
-    }
 
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(dev));
-- 
2.43.0



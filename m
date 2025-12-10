Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CD5D3E76E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTP3p-00013J-Lk; Wed, 10 Dec 2025 13:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3n-00011E-DD
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:11 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3l-0002R5-PP
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:11 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42e2e628f8aso30724f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765391828; x=1765996628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Na4A9EVrRfdr3jYLfoHtm27o0F9yOsabtMSqgfRALf8=;
 b=sNtb4w5L4zVo1nElXk1TK1ItRYQF0KSNvl1Jb3tLHBi9jOCxk+GJFbw8NCzGy530Qv
 qVRMOocNLxKNJf1f70njk6wG3WXNwNAUOVB3/KTmh6GNXFUgdkWyqydGOALlz0B7qxdT
 qi6e/SdVuMHNQpMOehnvDu/jI9UYlBQeFmP4xuuYpsJG/AMqa74cdl7As4Yxp2nCj7SS
 txm7VXF9FkzIXV7f/o9CnKz5RBXXDqYhyNfR2UFmTAj6IQJKzYTdu0CICSkav6Kl0J1e
 3p9P+GTloNMSIer+5refy4079BekJPKeSGF1LoHvEjQREZdjoaLveBhyXx3N2znI5h10
 h2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765391828; x=1765996628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Na4A9EVrRfdr3jYLfoHtm27o0F9yOsabtMSqgfRALf8=;
 b=HktdvsUfttsjem5b3EQaTuAvNOgZsfzW43QDoisco5YR/sNV9fTY3U1Z4nQwcdmIQ5
 xdiRYVRho6nnNXkMgQyrJzbf0iJwPWhBOWOF9GMDYlxJ77FRz5odbuMKT8ocYz9AOoVV
 wF62r0ZFKzXExNLeMU2d3+YK64RnJ8LCqCeB6n7zqSPUMMaUTcCgo8itdlLvihtORJNH
 SG7bzw/gRJe84JM5hiKP5pRCk0C4cXSKuILbxVyoIwV2qQOjIiaj8tuBNJNVBAfVvdCU
 xXBVuqb8SWwMUb8WvwblZ54TJwR3zItG//SsGrtOeq54fUaHXVQG+RbbZYOaLVWz9kQd
 FSSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnOdL4vSQ97+XXWqfYEgnXaFguqZJTBa9Qpcz6dWcdEqlYO1k7+xyYVFcZgU3y2lnCcbtoZX9OXzaP@nongnu.org
X-Gm-Message-State: AOJu0YxGS5xRDa9qwYaEVsIYfDmDemKtPesTB7jP6pCRvTrQZ+DHDltW
 HoNYjCLP0I1qJ32pKQfNaHX09igVEfmArJvM1kOhopKAOM7uIdNcHyLSVZ3pB0VL4n/THBd1WAD
 BQlYL
X-Gm-Gg: AY/fxX4JTFj2RzHxmqjPBGX7Rgks7NMj/4qV7mxXySv9TvVTJFqHz93NBHY6rcoV9aj
 n3MGsso9bu/vW5TUMhkA/hun0ZMxoHxjPnD0XH1SgpjlgFbroKp2xEaiaGWki8WeUFuAoQZL2RF
 jAEkwr/4eeFzR6VafqQeoyLOT3pAgOVbPkkC17ohJAT9WwDpBuWZFGT7cus5jC9ER7bcorgK5cL
 CPLQmnZPlaML3wze7T6CDIl7Q8YxK3Ud1JBA5o5MV4MXTN3GaaYQXGtHZlUbAbYaRCb6cHwsdL/
 YvujXELz/zIOoAaATu7GqoRqVYcDOqSQVRxh+lkyjTgHUmINTv4kI5t16waUQirAkzf4dCCMd83
 OvZUoyZL1q+CEKcIl83CKQE0/WsRQpUHnzPoOrrJPY0sYhGSvqfnC83aE3B0J5SaM+bHYi54DoY
 o4M1xYfRYzxyQzkTO9
X-Google-Smtp-Source: AGHT+IFHX0TyibFMSZXaK4hYbmFYXdOe2vDbl4o4QgkSvWN7Bz1sH9BErRPyiSmVmIkmLOICj8j8kA==
X-Received: by 2002:a05:6000:2c08:b0:42b:389a:b49 with SMTP id
 ffacd0b85a97d-42fa39d7eefmr3716134f8f.28.1765391828137; 
 Wed, 10 Dec 2025 10:37:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a7044csm477702f8f.15.2025.12.10.10.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 10:37:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.0 4/7] hw/dma/omap_dma: Remove omap_badwidth_* calls
Date: Wed, 10 Dec 2025 18:36:57 +0000
Message-ID: <20251210183700.3446237-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210183700.3446237-1-peter.maydell@linaro.org>
References: <20251210183700.3446237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The omap_badwidth_read* and omap_badwidth_write* functions are
used by various OMAP devices when the guest makes an access
to registers with an invalid width; they do two things:
 - log a GUEST_ERROR for the access
 - call cpu_physical_memory_read() or cpu_physical_memory_write()
   with the offset they are passed in

The first of these produces an unhelpful log message because the
function name that is printed is that of the omap-badwidth_*
function, not that of the read or write function of the device that
called it; this means you can't tell what device is involved.

The second is wrong because the offset is an offset into the device
but we use it as an absolute physical address, so we will access
whatever is at low memory.  That happens to be the boot ROM, so we
will ignore a write and return random garbage on a read.  This bug
has been present since 2011, when we did the conversions to the
MemoryRegion APIs, which involved changing all devices from working
with absolute physical addresses to working with offsets within their
MemoryRegions.  We must have missed updating these functions.

Replace the uses of these functions in omap_dma.c with an
open-coded call to qemu_log_mask() and RAZ/WI behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/omap_dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 101f91f4a33..ba0a70d84bd 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -1454,7 +1454,9 @@ static uint64_t omap_dma_read(void *opaque, hwaddr addr, unsigned size)
     uint16_t ret;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -1501,7 +1503,8 @@ static void omap_dma_write(void *opaque, hwaddr addr,
     int reg, ch;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
-- 
2.43.0



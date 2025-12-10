Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585E8D3E771
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTP3m-00010S-MN; Wed, 10 Dec 2025 13:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3k-0000yn-Qm
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:08 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3i-0002Pt-C1
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:08 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42f9ed40b8fso42649f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765391824; x=1765996624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OO+cLH1Fn44N6BJ+Ju5C9CU5XD8M5vZpp8/zUAFjH0k=;
 b=y5P8rpNUYPCxoI42ITwGKEOZRr/ZeMMnZfWYJt7eF+xQOP/vvSpqr2ctMWEFaGvzbH
 JkIcmzqxJqXXlYJ8ikTjmmzck3eaPOIee54jRQK6LRUdndb3R7s6Th41ayUySPRG3kDV
 tLjU4uLnamaJdwqktFTMNGJxzScPqpptCFBYwSFAMqJQ4HlQD4OFc55aZamT/bosHIt7
 hxs/71EpjMCnomY/gHPPSN/r+Ht9cU5Gl4vJ6+sAO9vEn7SQBgqkNOBM1cQGqURjSmXD
 mQEYEGJmU7twSKOGX7UB1CUvTzVEJkHLVlno2WHTv+lSc9pPOhpeEJGlDk4wmVHdGZCL
 aXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765391824; x=1765996624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OO+cLH1Fn44N6BJ+Ju5C9CU5XD8M5vZpp8/zUAFjH0k=;
 b=tAJe0PodVvwm2Wo8htzR5FvgcNfFjf3mgz89kuKjqQffhOafADyFeEjZl1ij7+WKn5
 7aNsEabXuHP+fVLOqwsZ8U7RI/1x0B6vVMfMiGKwH5Fz90uVrHr5ZF2SJ5E5ag2DJVPH
 Gso6ulwmIyDYiXb3yKQo/m4hlJ7f4Q0SMA6bjXnFU8ImlRXbLKtMvOhsSm3gWPVPU2ik
 1IL5RQwkoeR1R5wKDluAxuwUDJ6i66JYZyJ6d6S1cqxlKHHIDAMLyv++kgwfREmRI0+p
 VKCCBuhCdblDWyVELEES3ufXo81dMNiuxUvDJYA6pNdatkAJAcL2E2MKirPTug/r9YaJ
 JI2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0kgyPa3yp9pwpRSC1Kn9E5cdagNE1SqPArAtp0LI+hun+zQghodgjqM42qsThVtXlv+DYigb4tzpv@nongnu.org
X-Gm-Message-State: AOJu0YxXs5f/0CmyDtjpB9U8scZ0wsh3ZEJIviHATLiY/BMsyaNuqs7t
 vQ3o8bYeC+aiX0oRXffQbWaUGxDrcNnHQoUm12UYjoCwVA6+oGNcconWug9kBvNrH/8=
X-Gm-Gg: AY/fxX6uuKbgK7urFy9mXMNSRngBwFBzOVqiJfs0SR2JZNgyi+SkaIxyc2Fle6KuISO
 Inva4As0JoRsLO0Xz6TSUeW2AmTVnSKvI+hInm3zL39oGNUY6R+gSaxGH/8WhQCFTl7nxYp8tCv
 7EY3UbaR7emvd44l2lyMBPMyjPny5Pz8AvNfupELkS6PydjEN6ijyp0DoAOYk0yo27rNwsqu66r
 wNoFkUTRpNaobBSM129x2QUbD2g0krXU9qqF0redM2mjHkMxjqoycgDS9NUobMc57UNlV5n3XdX
 KfVYbm4tkmkvp+29TP7paA23aOigvpydjgYOLAF876RDdR4cugoNFl5+rd2vSSao5hUydQYu836
 dh48lJKd+pdJTzrTe3QskvOh8rn5Zf6/ufYyXyHH4BwVyd0n4nFzpRguNDafEl8paRxtMtS/hXV
 wzG+80/AvKaOhHe+jd
X-Google-Smtp-Source: AGHT+IE3bolWOmvs2CMbvn221/S+x1oSCLq8dvScR2LMq1m7Off0r9p2KzEfsES25RlI+dek+JSabg==
X-Received: by 2002:a5d:64e6:0:b0:42f:8816:a507 with SMTP id
 ffacd0b85a97d-42fa3b1ef97mr3775327f8f.60.1765391824332; 
 Wed, 10 Dec 2025 10:37:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a7044csm477702f8f.15.2025.12.10.10.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 10:37:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.0 1/7] hw/sd/omap_mmc: Remove omap_badwidth_* calls
Date: Wed, 10 Dec 2025 18:36:54 +0000
Message-ID: <20251210183700.3446237-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210183700.3446237-1-peter.maydell@linaro.org>
References: <20251210183700.3446237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Replace the uses of these functions in omap_mmc.c with an
open-coded call to qemu_log_mask() and RAZ/WI behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/omap_mmc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 5a1d25defaa..98c1c376ee1 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -335,7 +335,9 @@ static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
     OMAPMMCState *s = opaque;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, offset, size);
+        return 0;
     }
 
     switch (offset) {
@@ -428,7 +430,8 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
     OMAPMMCState *s = opaque;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, offset, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, offset, size);
         return;
     }
 
-- 
2.43.0



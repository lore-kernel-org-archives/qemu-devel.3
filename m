Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50218109B468
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YxJ-0006a1-Pu; Tue, 31 Mar 2026 09:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YxI-0006Ya-0E
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:28 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YxG-0004CO-D5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so48074245e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962984; x=1775567784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iBOEKdnNX+UB0CEMFgda2sLylOVtVPePP1bIf9KL7R8=;
 b=vmuKhUA2UnDShT3tCb0+kgsb5uFMnA8jCoaeNF+Lnh3nOsSUxeBWftcdpVyTC0i9jT
 PBDNDB7l+fFXKL3VG+sR16lBPGnHRjXc6/Rs2ylbgYgBwPi8TMY12uqGW3jkrgZzxnD7
 yFTXAffmVHDN9ewtDYs2qJ+2f0tl5sfDXSdCx/9b4WVsFVagU7X2ZKomTnKQkZS9AVR2
 zAt7GlvtwhtCMJdI5tU389kGpnttT4FBV3ZtKMoNXVGI1G9qXh3TNCPrByLnNhjWBJm+
 twngo4gJrKo5Efgy68UAVexwlqWk7p3+esLaG1gz2z7pFxTVX9uYqmLtV4Ex1hHe2Evx
 EH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962984; x=1775567784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iBOEKdnNX+UB0CEMFgda2sLylOVtVPePP1bIf9KL7R8=;
 b=qqP5ht08d583sZ5GKWJbtzi83xy7qWCNwml41052vCWsYXYlodktMHTYf115kRugzx
 s256ShJnBhOZ6PBTVVUpyFd8V6DIseIolsr7ktkqScb14WCfhEdAz1yRCBwqvkYUEfBl
 Wsn0mJ58tYhnOdI/lCF1nkeJ7goHctC9rZ9EtxzyiY66iRpwzYAYldOOGfsiT8LY0XxT
 3auJQ4eBoMOTMKQ1+3cqAu5MmHRBhWxj4vmsniczstD19k7vszSxOtvrj/2e1lnb99oT
 AvSb+mhAlNbpvpDLe6UPgbofP+bmj8s8i9EINi/5VrqxPODb8fwKLJ3kDezGTnNtyp2R
 h1dA==
X-Gm-Message-State: AOJu0YxlU0c3NFBUKVfH7MQ7E1PJirx8DGrsf1y4K7ONg3Mk0BgyLtl2
 f0mMlFF1p/trGmUoV3T1O0AFzJZ+dTtSDzBF3vvy42NQ2M2XYNjg0s9KBCSD8lwP+rOnhuIwX/F
 +8RLpcDw=
X-Gm-Gg: ATEYQzyuvNsR7ciM+z8Sbj42UX5DwW79oEH9CWcn+lXnrKiLkAoQC43mrfCO9holvb5
 OyfLDP6duENIF5ebFMyVi0RKZrERdu9xC81Wnza9sqdDFl7dRqpg3Q4k5wn0BhAaojYbyM9cMTP
 Ray37PCX1kmqTDt3WHuMeHOv8b3xvAVALLKGIpXDb//F0QVyzy0JXvmGZPlHBlPZXbozeIKyBZr
 J4ItqE9bveETLmy871RtmUtGFGPggj0rb8eF2RRESEWkpzKjDNxa48mVKYILLrbrHTrUD9wC5MA
 FF0EAMRd8RTR5VGA2IpiLqLWTpkwE2DPGJUWMrVnvE9B0/hOq4qPHw1INK73mfeWJHpdcSdiwwX
 XvAquVYl3wBniLLF9ILwODa46CHBL1G96oewEszEF+MgbwDLO8iyRUe9y0Hskp/9fEiLE9t7m+J
 usQLh6NA2tgR7c1Gbp5UGCmcLKowoHeJC86HoJOM9ZNwlaPjTFpnzRU3FxwnmmxTjc4zc=
X-Received: by 2002:a05:600c:c493:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-48727efca4emr269419895e9.14.1774962983937; 
 Tue, 31 Mar 2026 06:16:23 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48880946cc5sm16401325e9.13.2026.03.31.06.16.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:16:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] ati-vga: Add upper limit to x-linear-aper-size property
Date: Tue, 31 Mar 2026 15:15:10 +0200
Message-ID: <20260331131514.21152-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Coverity warns in CID 1645968 about possible integer overflow. This
should never happen but to ensure that, add an upper limit on the
x-linear-aper-size. This may not silence the warning but makes sure
users cannot cause an overflow.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <541ffffdaa4c67b9dcbca6c2498e69b137bce95d.1774904832.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index fc19737d1f0..97d871b1e22 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1130,6 +1130,10 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
             s->linear_aper_sz = ATI_R100_LINEAR_APER_SIZE;
         }
     }
+    if (s->linear_aper_sz > 256 * MiB) {
+        error_setg(errp, "x-linear-aper-size is too large (maximum 256 MiB)");
+        return;
+    }
     if (s->linear_aper_sz < 16 * MiB) {
         error_setg(errp, "x-linear-aper-size is too small (minimum 16 MiB)");
         return;
-- 
2.53.0



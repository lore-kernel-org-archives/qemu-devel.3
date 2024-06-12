Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C194C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNzG-0003tb-Jh; Wed, 12 Jun 2024 09:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNzD-0003kA-Tf
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:26:00 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNzB-0004zW-VH
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:25:59 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57c68682d1aso5283857a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718198756; x=1718803556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnsmHcs0edIXhpdRXi0WlorEVmnbvVWBV0YISj9sdg8=;
 b=FF/VLiolOt7umJdAJnG9nIyhOuerq7aSQ1nzNnYvEB55sGGE7EyyiJeH0PZBWTr8cQ
 nFcdczuRkua8sSW///iX95AnBSwV0o0DeXbZjJqYSodzylmZG5rok9sRDyRafLb4fDTN
 3QKwlEQD+UtfWgBLF6Z3Mt8kymioKufQtgPMzAGjUQgFLY5vnxuTIhM3SqbrCtnGdiGr
 1p7eKRhcRmZgXp2DA8fKe/XSGO+VY0u7yXU+S+vIjCMnKoHvAy6G4pBzbvUVlOoc5sLg
 oUMlvXBf1cHLkm9KpW60LaAvvX/CoJ1b63YmoH5rayAuX1MGVJYTEHC1+R/jccUoFGdp
 QcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718198756; x=1718803556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnsmHcs0edIXhpdRXi0WlorEVmnbvVWBV0YISj9sdg8=;
 b=tPHjLMq7DGslx+HP36WSVmAz6mCATC5PaT95MLhpbQ4wgqkweKNC2aK0KfRhhhBlAM
 +26E9331CRVWCrqfTxIvVBj8F7NqDAmiSRSsN14yVAJfudjxCwbYqDp34kYqH5DmJyDX
 g9/WOpr4XM8h8CbFNZvr/MKodCtyshgY7wYopesUUX27sfyOwONWJtC7rhYLMslJPG2q
 gEJr3PCdQYbtR7OIZ9GNZ1kzvk0vZI+5LnTDV7P49iOYC/qTHBFsaIBWhF2uLRwAuF0w
 /lytY6i6Mh8vp9fM3ZsS0rLgTSyKCsI3+mnBeVVbINgS7zpZu4GDS3zUIj66JoBNMOyO
 Lyaw==
X-Gm-Message-State: AOJu0Yz/kiZsMGgxLN2ME9x0pJ3B6PzHhPqywGSv19oJydKOsNM0tz+o
 qrPm6Yld/vURkelCZ1uKFPrTZAh0JXGfcLGrhdCl+ByBCM2hAE8KCo7GikM4vJi1qnrkXYTgnls
 t
X-Google-Smtp-Source: AGHT+IEjnYQmgoSg9yRCTD+ugrt5MBCMkUmL5XOWoLq8wZcXv4pWxHQULcaRTwU8B5iqScLM3o8S5A==
X-Received: by 2002:a50:8713:0:b0:57c:740b:c87f with SMTP id
 4fb4d7f45d1cf-57ca9743dfamr1049802a12.9.1718198756075; 
 Wed, 12 Jun 2024 06:25:56 -0700 (PDT)
Received: from m1x-phil.lan (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c92901b05sm3193394a12.73.2024.06.12.06.25.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jun 2024 06:25:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/3] hw/i386/iommu: Constify IOMMUTLBEvent in
 vtd_page_walk_hook prototype
Date: Wed, 12 Jun 2024 15:25:31 +0200
Message-ID: <20240612132532.85928-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240612132532.85928-1-philmd@linaro.org>
References: <20240612132532.85928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

@event access is read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/intel_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cc8e59674e..c4350e0ff0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1170,7 +1170,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
     }
 }
 
-typedef int (*vtd_page_walk_hook)(IOMMUTLBEvent *event, void *private);
+typedef int (*vtd_page_walk_hook)(const IOMMUTLBEvent *event, void *private);
 
 /**
  * Constant information used during page walking
@@ -1533,7 +1533,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     return 0;
 }
 
-static int vtd_sync_shadow_page_hook(IOMMUTLBEvent *event,
+static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
                                      void *private)
 {
     memory_region_notify_iommu(private, 0, *event);
@@ -2219,7 +2219,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                  * page tables.  We just deliver the PSI down to
                  * invalidate caches.
                  */
-                IOMMUTLBEvent event = {
+                const IOMMUTLBEvent event = {
                     .type = IOMMU_NOTIFIER_UNMAP,
                     .entry = {
                         .target_as = &address_space_memory,
@@ -3889,7 +3889,7 @@ static void vtd_address_space_refresh_all(IntelIOMMUState *s)
     vtd_switch_address_space_all(s);
 }
 
-static int vtd_replay_hook(IOMMUTLBEvent *event, void *private)
+static int vtd_replay_hook(const IOMMUTLBEvent *event, void *private)
 {
     memory_region_notify_iommu_one(private, event);
     return 0;
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA59DC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNz7-0003ZI-IK; Wed, 12 Jun 2024 09:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNz6-0003Z5-9A
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:25:52 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNz4-0004ym-N4
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:25:52 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57c8353d8d0so4419097a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718198749; x=1718803549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/V34NJr+rWIWxDjERHJ009gIapl2SiDYy6zj1sgQb8=;
 b=WI02i4AU9dNJCmZrGXPUOBgOUyZD5xV2NNhS45BF94K6tGxO55FAgyTLe7vihbSZwa
 IVpWE3P3pvYYb1zDwbk9TF9imjR5GBjH5Ud+TVvD/tBNfKqyX6lHVlsn7pkCjeJDaMfG
 PePuyN5TqPBBOPiK7fkRcC7GTcM2KOps8eni2GY9gT+mtOX/gsvEffe1HxdkICeWjC0i
 xftNrYn2/zZPks3RlZVBuLpkJm39AKbdfVqaUjFuEuCMLS7r4eJ2koYjef9XpbNhe/wg
 aBwJgNE3manV1bwu50kBFIlwr6uycbOwrBWRtLsEzzlyvr5F27lMMV6iCsHkkKH0adny
 uBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718198749; x=1718803549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/V34NJr+rWIWxDjERHJ009gIapl2SiDYy6zj1sgQb8=;
 b=PsKqUru2NTwniZPUxd31ULUrTczezR77HNGa+OuXRU43gpsoMe9C6CJJNW0OIOGOBs
 zWOQE8DIiadKw6YMc3PE3R8+fDTbszjfovHPAkFV7GID0Zm5jXbB7zgZbq5DzBFO9fXl
 LwB74yrg3HthzeucnZsENYoJ9XlsYY7oO8sxKa75w03RqI19H3b15ndKb+9G+AkABTMC
 ZfSyiHcTJPMfUZq550t+1tag2An6Ca1RnmEpUV1OaaFoU2gNv4URK3ESd5kGQ0Tol6b6
 ommA+Th7A52fABvcQmxgB3Vp/K3itEyCHx0uitxtJVcBS8Gp9fdqXiK6E+kF+8B0HWRq
 NfXg==
X-Gm-Message-State: AOJu0Yyiq3WHGtCX1sf4H6YiWloiTmtdIAdqZf5K9ZQrrN/3fkldhUac
 Oy5hch6XLka/zqvq3AJX/6MfVFaQcjH1asM1tRsLrcO3wk4IJlZsB+XMwDwiXfCR4D0Pow+lDWw
 V
X-Google-Smtp-Source: AGHT+IF5UcTOhK48XehKiFNeVtISUlu3+0IymCXwmYyckaqAS/FP3WkMmHJ0KJa8qld5BRmAjZrEAg==
X-Received: by 2002:a50:a6db:0:b0:57a:2f68:fe7b with SMTP id
 4fb4d7f45d1cf-57caaad8c50mr1375473a12.31.1718198748924; 
 Wed, 12 Jun 2024 06:25:48 -0700 (PDT)
Received: from m1x-phil.lan (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c741b0581sm7036325a12.57.2024.06.12.06.25.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Jun 2024 06:25:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/3] memory: Constify IOMMUTLBEvent in
 memory_region_notify_iommu()
Date: Wed, 12 Jun 2024 15:25:30 +0200
Message-ID: <20240612132532.85928-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240612132532.85928-1-philmd@linaro.org>
References: <20240612132532.85928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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
 include/exec/memory.h | 2 +-
 system/memory.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2bf5e23b6a..2d7c278b9f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1837,7 +1837,7 @@ uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_mr);
  */
 void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
                                 int iommu_idx,
-                                IOMMUTLBEvent event);
+                                const IOMMUTLBEvent event);
 
 /**
  * memory_region_notify_iommu_one: notify a change in an IOMMU translation
diff --git a/system/memory.c b/system/memory.c
index f3a37c97c1..47c600df63 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2052,7 +2052,7 @@ void memory_region_unmap_iommu_notifier_range(IOMMUNotifier *notifier)
 
 void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
                                 int iommu_idx,
-                                IOMMUTLBEvent event)
+                                const IOMMUTLBEvent event)
 {
     IOMMUNotifier *iommu_notifier;
 
-- 
2.41.0



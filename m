Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAAFC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbLh-0007At-Jk; Tue, 18 Jun 2024 12:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLd-0006v5-LN
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:17 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLa-0007kX-Q5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:17 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ec0f3b9cfeso51060771fa.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726773; x=1719331573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtmX+S2yK/Vz8/u+qz4/0UFgu+q37Y7br+Oj/kr8kUw=;
 b=gRVUg5s53KnJZxK1be+9I6jBVj5BXXJT2lzVkc/g4F34OB4u7ltoblPZ8T3QydS8Ks
 rGc520bYIv7QegJPI4fjFZm4USKp+fAo/BFmcVRsi13XX3uwHVJFvpG7ZBZzIoFp1byp
 Sjfzd40iP4onk9I0qymIgbEc6sv4XrzKYfl/navj05D8nEdp8GKcuT06IDKc6+5lw6pU
 NSa6FZkoqwbnCVXzdiOk/SrTKTdfyn71BzQ3ACLWRAxcKy96eEGIP0gs4Q4l4TVu5jOY
 QRmTBz0gb++qwqvA/fcqSRYYKW3nFuEbsVeqpfKjyu3ySpi49XTpFEizHfo/g1vzFH8i
 m8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726773; x=1719331573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtmX+S2yK/Vz8/u+qz4/0UFgu+q37Y7br+Oj/kr8kUw=;
 b=USpCl9k0lcGiD/+lur6KHHVGrfFgFbPDPI5tXsWEaUjk9K169OOyW+i/tbGj4QQ1jX
 P+EMq9UuF46SsTv6wUYJMgXZT1blpqtLNhCi4JrNQ/VRp8inMzn8zl7UeUHP+1xTDVft
 LUqR3iq1YUsZXwI8DxjDOPr0YeUEuKbhfjfCkK/KM47ljl3nizeumiad6twRqJ127PzH
 PqM3sGmgYixDnW7Bux3ghyAgM3wEFoE4+oz1fuS6MztikhS2OQtFC+todJ5/01bspfvx
 MYWQ82OG5iWXAUPPoNSW5auKSXktEDlBkGOUBBaOdZ5p9FUyinR8H9Oc0eQ6MHtrUwy8
 Xscg==
X-Gm-Message-State: AOJu0Yya14Korn/FMIiY4xDb3rc8cywIA34828ds47jtCAwZExxSvPZJ
 mPmwHQUh9fCJyXKtWXAOcs2y8xM3WdR68DNutHGkcOplRW6LWhivMZUBUX1maIvqT4AZdN5dSop
 P
X-Google-Smtp-Source: AGHT+IEe8oYfAdlFyt5kVJ7sBV/Lue6VT8XWBolDxnqQ7WCgjkFS8bWYgt1UxlgmE38en2OxBPajkQ==
X-Received: by 2002:a2e:9694:0:b0:2ea:91cf:a5f0 with SMTP id
 38308e7fff4ca-2ec3ceb6a0cmr1879591fa.19.1718726772788; 
 Tue, 18 Jun 2024 09:06:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6320bd8sm191966715e9.32.2024.06.18.09.06.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 57/76] memory: Constify IOMMUTLBEvent in
 memory_region_notify_iommu_one()
Date: Tue, 18 Jun 2024 18:00:19 +0200
Message-ID: <20240618160039.36108-58-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20240612132532.85928-2-philmd@linaro.org>
---
 include/exec/memory.h | 2 +-
 system/memory.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1be58f694c..2bf5e23b6a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1852,7 +1852,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
  *         range.
  */
 void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
-                                    IOMMUTLBEvent *event);
+                                    const IOMMUTLBEvent *event);
 
 /**
  * memory_region_unmap_iommu_notifier_range: notify a unmap for an IOMMU
diff --git a/system/memory.c b/system/memory.c
index 74cd73ebc7..f3a37c97c1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2006,9 +2006,9 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
 }
 
 void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
-                                    IOMMUTLBEvent *event)
+                                    const IOMMUTLBEvent *event)
 {
-    IOMMUTLBEntry *entry = &event->entry;
+    const IOMMUTLBEntry *entry = &event->entry;
     hwaddr entry_end = entry->iova + entry->addr_mask;
     IOMMUTLBEntry tmp = *entry;
 
-- 
2.41.0



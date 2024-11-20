Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E422D711C1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 16:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDnTG-0005IG-PS; Wed, 20 Nov 2024 11:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xndchn@gmail.com>) id 1tDmQx-00081d-Ue
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 10:16:01 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xndchn@gmail.com>) id 1tDmQw-0007HG-Ei
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 10:15:59 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso788672a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 07:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732115756; x=1732720556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzVlMmUDCPIXjIQbgRccJwhv6qCFgui1V2oLDukdq90=;
 b=a2sAsmLcPBAcP+/tWnpyiVTs4kMVxIwcVIvVrrFZ/uvMOyqgKf4NK9wWGk6w9eYORi
 Kb3/AtzhxLZ6MotWm1wvJKOUiWxdOvkgXOfrWkuDB2isV2saSP5B1erRpAaAWliJqi4h
 tAjYxOoDqaMU1zWySpCqTdg1B5J7pgo3xnvTtaZgizY8wHdxXnejoCeJ0QNvhXXm2v7Y
 wTJIQTl6Ge+51y0tu1/rCOTyy1yOIFhwFyu7L37UEUqScVien8YgbBcS5Y9q3DiJMdn1
 yjMWzed9j/vV3EniV2MabUkEKcC+pyTED+aZnn7P4i07fL5QlP/+jqJw9lfaAkskGIVe
 AuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732115756; x=1732720556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzVlMmUDCPIXjIQbgRccJwhv6qCFgui1V2oLDukdq90=;
 b=XH8Fdslh3r9Lq5e9tsPnfxNG6SyUZs/zU2XuXZJC9YPQqgIRrXJcbY1O2oj1d3rLP9
 MHVMcoUSBadmheZFzgyuRu0lt26ZCsa4fVmIGoyt8uVRSvBLEv929cGSt//QMurJA1kR
 aPJ6Dm9f/xQ2t/6fEFV/MNdauXiW54zasHFDl74FEPo080Ny9J2mqNjDCPVte8SMhAtU
 PtOHm3IdVU1HJM2cDkLNJlKyAfOr1Hcv/3Y6tqbEcQykciExYI3hQ8OCQhyV1/NNOpJh
 9hE4WI35zP1jLgwBup0Tq7rQcpeTIun39qGxduw/AGk2pnEHkRLe8z9tYA1XGCXNthzA
 5Waw==
X-Gm-Message-State: AOJu0YyxxiS3o7tZM8VCcOedslnwrM3Cxrc9rnGwAp0YWnSjj/aYA73q
 7EKIHNsW9DMTgBWXl+J+ekQjWw4bMnDvkgUAtLPlzHP1+TNeIXYAGpLZgUAalWr9PQ==
X-Google-Smtp-Source: AGHT+IETk/kFnwmKWsm9TC+Ih9P1k5qTuXgKYpQwg0MrqhQKNn1fQ6JYmV9+UNOJp5ysAANMRrHiQA==
X-Received: by 2002:a17:90a:dfc4:b0:2ea:28bc:8b55 with SMTP id
 98e67ed59e1d1-2eac83d7bdemr5138063a91.9.1732115755950; 
 Wed, 20 Nov 2024 07:15:55 -0800 (PST)
Received: from localhost.localdomain ([114.254.47.99])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-212583fccc5sm29352465ad.278.2024.11.20.07.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:15:55 -0800 (PST)
From: Xiong Nandi <xndchn@gmail.com>
To: qemu-devel@nongnu.org
Cc: Xiong Nandi <xndchn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] system/physmem: Fix cpu_memory_rw_debug for armv7m MPU
Date: Wed, 20 Nov 2024 23:15:15 +0800
Message-Id: <20241120151515.56884-2-xndchn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241120151515.56884-1-xndchn@gmail.com>
References: <20241120151515.56884-1-xndchn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=xndchn@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 20 Nov 2024 11:22:25 -0500
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

The actual page size (region size for MPU) of armv7m may
smaller than TARGET_PAGE_SIZE (2^5 vs 2^10). So we should
use the actual virtual address to get the phys page address.

Signed-off-by: Xiong Nandi <xndchn@gmail.com>
---
 system/physmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a384..a76b305130 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3564,11 +3564,12 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
         MemTxResult res;
 
         page = addr & TARGET_PAGE_MASK;
-        phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
+        phys_addr = cpu_get_phys_page_attrs_debug(cpu, addr, &attrs);
         asidx = cpu_asidx_from_attrs(cpu, attrs);
         /* if no physical page mapped, return an error */
         if (phys_addr == -1)
             return -1;
+        phys_addr &= TARGET_PAGE_MASK;
         l = (page + TARGET_PAGE_SIZE) - addr;
         if (l > len)
             l = len;
-- 
2.25.1



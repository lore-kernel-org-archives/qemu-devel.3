Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ABCE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 12:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhva-0004kB-Pz; Thu, 12 Dec 2024 07:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLhvU-0004cy-SW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:04:16 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLhvS-0004Yi-PT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:04:16 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-728f1525565so593467b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 04:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734005052; x=1734609852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bLxk+wyW7auej15J4fCkvVb8H1kqD+g0eYAh679uWfI=;
 b=aiGngk69FfaEdtVs63Utq04YvlID+JeSGpyeqk9HU2XCRs8ERKFtNb8CUz2yHNuu/R
 fSwuyv84PmusHaDz12nllkT3HlBnvL5L0TlX33rhvtI5iL69EtmguU6lVe2j1PxjIEWQ
 e5w95sYT22RzwpkVThFztbvLEzhAoFKwcJ8GzNsHdoVIvhrDbwpORNo1P5y3lguoPlRw
 7grdR+4LNrgTK01rf/x44+PJ+MltW/J92GLduY87IAS0Qz/z0bFJm/2NIDgJVTmU7w97
 IK+d/NTX/slp34/RUSiATpgGFQBKm7rGsyn53XUPPOVgf1/RDU8Z2eoY6zQ7PhAGi9T5
 tEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734005052; x=1734609852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bLxk+wyW7auej15J4fCkvVb8H1kqD+g0eYAh679uWfI=;
 b=qGC7G/h9JlO4+3s4bQb61erzSS+8Xf4Az23DsH4/SMCRKL/hPR2aySJuoFPqTEAiTi
 NXQt206VwURN4iigSbvTGbvhsTDyZ7qKT4VQbkK4crz3L1o4k3YqVvRj6oC08F2LOCOy
 98rNWOjAOip+nMxSwLAnuWBKgONqcqDwh4wRPt7Be7qoGRWcUtdTDnexTzak/kvTgNXm
 XKXDROZ5xxNoLZLnEgXohL5GAzRjvuQaGS6cCISaGda/O1ueWxbcvCNF/NIxKDjJKAS8
 bsTYuBKwUYTu8tuNw4ZYuy1poLfDvCK6MUknHcijpVK+Jq4RtWjdYE12ZxvjE23kXzzD
 /yEA==
X-Gm-Message-State: AOJu0Yxb4nqFEj/SNczmeaQkdsZZpwzSbx9KMIn0cNoQcGpghicHz3Pc
 rFZol3Qf6I2dqfPgbfI3UqSe7dD1BY0syM9SiBL1O9tARu/FSlXj8dTdRg==
X-Gm-Gg: ASbGnct0+vjN1XrwKlDv5gG4Y2hy93X+0zBFfAnczROv1GqXPtxcjhS0Qfq5WVktwrY
 s3j5/Wx3e6GvwlJIxqaJnnWvK9f12mPfiR0SXEZ7H2bIQYB0CJUp0VMVo6TUoyP3dQTHm3gsNzb
 9ru/2cyP8CfYOCRRvJJLoJMpxFSIp/ud+mqL/38f/Lcczbkjmql7iIiRiF4fdjOE1nFUwIUS83U
 +lvin00vUxZnky5TnKSVHYv+HYBPGh1BorearVfI3R7SQPFNV1vqFvvxnQ=
X-Google-Smtp-Source: AGHT+IEZ69TZaFkJnEfa6lfB9bWcaMHu0iZamv5eyAzRfNCCAH9Kjl/c8oCE3LcUARjxvpANm1FyVg==
X-Received: by 2002:a05:6a21:1190:b0:1e0:dc34:2e7d with SMTP id
 adf61e73a8af0-1e1daaf4f38mr26145637.5.1734005052194; 
 Thu, 12 Dec 2024 04:04:12 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725da7e0114sm8920213b3a.2.2024.12.12.04.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 04:04:11 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH] pci/msix: Fix msix pba read vector poll end calculation
Date: Thu, 12 Dec 2024 22:04:02 +1000
Message-ID: <20241212120402.1475053-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The end vector calculation has a bug that results in polling fewer
than required vectors when reading at a non-zero offset in PBA memory.

Fixes: bbef882cc193 ("msi: add API to get notified about pending bit poll")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Taking closer look at my msix pba mmio write patch, it looks like there
might be a bug in the calculation from the code I copied? I haven't
looked into how to test these poll notifiers though.

Thanks,
Nick

 hw/pci/msix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 487e49834ee..cc6e79ec678 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -250,7 +250,7 @@ static uint64_t msix_pba_mmio_read(void *opaque, hwaddr addr,
     PCIDevice *dev = opaque;
     if (dev->msix_vector_poll_notifier) {
         unsigned vector_start = addr * 8;
-        unsigned vector_end = MIN(addr + size * 8, dev->msix_entries_nr);
+        unsigned vector_end = MIN((addr + size) * 8, dev->msix_entries_nr);
         dev->msix_vector_poll_notifier(dev, vector_start, vector_end);
     }
 
-- 
2.45.2



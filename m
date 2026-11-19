Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3888606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SDovjV7l;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JczQMu0i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTyk7-0005uv-N3; Thu, 19 Nov 2026 04:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjf-0005dZ-82
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTyjd-0006Lg-Cz
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 04:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795081636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qh/ls5L13zT6JtqDG8fZCix25/+j6FbpU2ngFykyr9E=;
 b=SDovjV7lDNJEog4xFRv6bixuC4FyL00OZ3p266Oz6fSjcN68WCP4HXD21MkGWZ5idmiWZ4
 9fOVxWL+dmhnU/6cSpmuL+PkGvWAEccQ0nItExXq+nIJQQ3iYR39eOPaeT/Rx6yij8Af1G
 6QOtEFLnkZjfcWucylPO68IfE2vGbpE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-B6yGk9amNM6sn4EnFCqDPg-1; Thu, 19 Nov 2026 04:47:13 -0500
X-MC-Unique: B6yGk9amNM6sn4EnFCqDPg-1
X-Mimecast-MFC-AGG-ID: B6yGk9amNM6sn4EnFCqDPg_1795081632
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a2065a2ef9so17820435e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 01:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795081632; x=1795686432; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qh/ls5L13zT6JtqDG8fZCix25/+j6FbpU2ngFykyr9E=;
 b=JczQMu0ifMYc/ssMCpNv2+Ln7tBqIPRAn4G3jXHzxJplhi36y1g2xtgTr5A0z7dfD5
 z2212+40Xcesugc3t17xPOf6ehcDGZjubpwGv+OIJlvd4LY4NXfEQihNbAWpP0U9jbUQ
 dnEfCnoVJx0j7d/NH7ndscvvMZ60cNfAGBbj2N4w0cKClkuo+KBP1QsxwnFkGRX9ieWo
 o4cXl+QgUr9JqGncjqX2TCDLtTKw4CpAxsm415Mz6d9/DzZqV318ybRbjUcVUD2wWkh2
 WLpU9wQyHwloGSilyj3oqH9tafdNVj2dA5RwmXuPvGuksZpR7WcYeNEhD97z5uvZwK6K
 QrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795081632; x=1795686432;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qh/ls5L13zT6JtqDG8fZCix25/+j6FbpU2ngFykyr9E=;
 b=N84kRFnUUHfR45Yvre3mhN+LjQ8q6K7RY7+dlq7gNZ7HEVmTlumod9dhTGsdappZtx
 9T4RSgownp/I8MyWXWEeO0zT7niQbnBGdsNDS4s7CNaBlXiGLGseM3ugy0AUuxP5tOuG
 imb7cV9SECOE5HRDHUmLmsWo0/tCCz2mgkeNVmRdMGxcE6Z3f9ygyfMd1o7zGCgjDgrL
 4ss2GxsjEOBY75aUCM0JcEEu/GpFkAN/GAhT9/WWjN4W7yPyohDMHuvqLq3h9qvjADTO
 dYdXAkCAhSmN4ZggBZlg8Inf/Sl/wSSuB5YZq4cU3fbznszM1OMFHTO4pZRKajsCzgNb
 lbwg==
X-Gm-Message-State: APuU4Z/gdb1fpjHz1WDz9gNeBkH2lmIkFCbtS7ADMufdntUupyKIzVas
 hXBuDHy/KPmCyCqUs3rdVgiYqR0hzGXYqcFRSbAPLmqVNe7XOTsnbXUUb6yx6DmHGo2k0QR9G8B
 aGfhXcQocQl15arqiMsYujzmAi5vrl4c9S/GKVnxkBLbcdwK11hqgn6o95iCYVdG9RwOFUGaGKR
 kPNntfSjCVJ4arn3GunYK2c67ZPOK3VEACSg==
X-Gm-Gg: AYBFou0mZGTB7T+9OHtExy9EcFMfIC+GT5GP0SucPsnRFedrVU2v+bV9ZvcgZeixeRx
 /tuh9BO0yX0Mja7o3roJnsBpexg2qRK8EcEOywETO+UHhyHtGJKykSa1otIKgcXLVZNTgvhhwyw
 26vFBXi1v4sZLjMJuRVUxXZwWPp4eS1OQH1zW0dztZUttt+rBGLQ7o2nUxNSKwSl7Jmu6UdUhzq
 9T4ix94IIMgBlycn6atSjsZtlUnvfC46brZqcJ1x2ad0peljkua/h6L4lWzDMylUK1oumXulyXU
 ipvA0TmlWqt0/Da+5zUxMayJzYATr/6CS7Wv1HJKNRLFt3oy4v/DrxaH39zK2FciaxGp6Xj41qF
 9KwNaZmy4tARtiewaSnc0fV2BBB26Pmte3JzQvfMeAJU=
X-Received: by 2002:a05:600c:4e4d:b0:4bb:69b2:d3df with SMTP id
 5b1f17b1804b1-4bb7da362e1mr108004205e9.25.1795081632022; 
 Thu, 19 Nov 2026 01:47:12 -0800 (PST)
X-Received: by 2002:a05:600c:4e4d:b0:4bb:69b2:d3df with SMTP id
 5b1f17b1804b1-4bb7da362e1mr108003655e9.25.1795081631462; 
 Thu, 19 Nov 2026 01:47:11 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85372d15sm27359425e9.14.2026.11.19.01.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 01:47:09 -0800 (PST)
Date: Thu, 19 Nov 2026 04:47:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/8] hw/i386/amd_iommu: Mask address when calculating large
 PTE page size
Message-ID: <f818dc0165af1ceccf004bc9a50c1d31fad1f87a.1795081539.git.mst@redhat.com>
References: <cover.1795081539.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1795081539.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The amd_iommu handling of the "large PTE page size" (where Next Level
bits are 0b111) case is not correct.  We calculate the page size
using the address in the descriptor (as per table 14 of the spec),
but we don't explicitly pick out the Page Address field, instead
passing the whole PTE word to cto64().  This means that a PTE which
incorrectly sets all the reserved high bits can cause cto64() to
return 63 or 64, and we will try to shift by an out of range amount,
which is undefined behaviour.

Mask the PTE with AMDVI_DEV_PT_ROOT_MASK to get the page address
(matching how we do it to get the address for the next page table
level in NEXT_PTE_ADDR).

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3618
Reported-by: huntr bubble <https://gitlab.com/bubblehuntr>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: a74bb3110a5b ("amd_iommu: Add helpers to walk AMD v1 Page Table format")
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Sairaj kodilkar <sarunkod@amd.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261105105816.3012283-1-peter.maydell@linaro.org>
---
 hw/i386/amd_iommu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 948d8611b15..008e882724c 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -216,7 +216,8 @@
 /*
  * Take a PTE value with mode=0x07 and return the page size it encodes.
  */
-#define PTE_LARGE_PAGE_SIZE(pte)    (1ULL << (1 + cto64(((pte) | 0xfffULL))))
+#define PTE_LARGE_PAGE_SIZE(pte) \
+    (1ULL << (1 + cto64((((pte) & AMDVI_DEV_PT_ROOT_MASK) | 0xfffULL))))
 
 /* Return number of PTEs to use for a given page size (expected power of 2) */
 #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
-- 
MST



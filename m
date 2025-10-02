Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC72CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Euy-0007fX-NI; Thu, 02 Oct 2025 04:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Euu-0007Ya-OI
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:44:01 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EuW-00010A-Uc
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:59 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso422995f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394602; x=1759999402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9bjNs8nbmPHtqp1O3nLNnIUYP6MFEbM89LgRhzC8Oo=;
 b=kXu1aoWdJ1Hel2QIgP2/JVAyTaehtoGZAPuODmnQblyVvRnQeUQInoH6O8XfYAB96j
 2K9xuN1X9fR+wiHVD61PtxiWZSoekgkOa4aqASUEPhy45q7Dvv6M6Phrto0OmZjxnWx2
 b1PpI9fFH5kFDtvUJih413S0ur3oxK2mAtpEoBDA2xxHhCX5rjZL3HRCdUk6bS38ZlX5
 eQ99pPMHszcvrLeW6HS88Z4W2G0BmfpMOW66JUVfl/WtOTRK5+TPBUx4XAa15a+cAjz6
 LF4O3oJ0G1QPB+cR9KGW0NuOIZpJ8RJ4TU/EkMn+6E55BdZKlkEtsFCfogTLsVV0cYrM
 Gmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394602; x=1759999402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9bjNs8nbmPHtqp1O3nLNnIUYP6MFEbM89LgRhzC8Oo=;
 b=mf0IpTPyHNEg5jCtNLMS90283mwjhB62sWhpd2jg+MTiQc0a5hWITgYHb8WCYKOBU0
 koyh9oWxCy5ArvJWoZAwyUFE9eRvzld+QVobowFVT8bO+rhBN3FeF1lpz0zFJqxYDi+N
 LBPYLtSAgW7ivnhpAq8U/ryOzSSPHBwCP9tm3/86k5E/VDO0xnD7LjWd8CORND3ynmSq
 026/uDr5u+VyxsRCmCqza//Gb5ABQkTYHq0K6apKnMGmaHGAS6YbMwJJLgtWYPWt+DOL
 Z0QTVWLwSnfwyjq9t+NGIdX2pSj2uA4U/f8ci/TYYV4CT5Qwzgl5WWpm7B5kZfNv5vt2
 pkvQ==
X-Gm-Message-State: AOJu0Yy3YYXJJKlvt4hUTtfQKbxHxCitpOPcfoBH5DcsvQ+3wCilxsP1
 q25wV5djbcR7F3/0N9HbEN2YGUyrM3jymmR1TC7LzuP8G6TcETxsxpChHpl65i6FHT6u3lt7udt
 xod9JbIiGpQ==
X-Gm-Gg: ASbGncsXLj7sLgRWQd/xWqcGvUGKsfc3ls4wvFWRmgFJmklcFIgH48HNnKnJEdw0cX0
 603myD0Stmsrx8qCo2TdGEhUjbiNLWZtlFQ2wMFCPfjfZ+nVZvP+1+1iaOQ5NnHB8ollFGbI5fi
 XMYKi0u0dNG7HVHc2Q89csy6SJ2jgv0LChiawtLjQHdPWV2tJO79iqgxwrfrfidyWh0Tp+IxlV6
 SVM8JU98GVyEaqlXVYUyhfnpITEAeB1UHXuh+SwWFN5xEId5Ucnzkbi46/RbmRDRZEHoHmF3hW1
 YIzkBVHL/quyz422ikapnzQ/5tZNeV6Ku3GI7yDj5ScAheW6gVLNWFt3vKo5+MQCbg4GYGFillq
 xMzGUBqFX2EfpIZmNSA6Z7LoPJMq1qUzDn+Ft+3QSqytlLctdt+ZtSvzr914xwfqyXTzPDLdOsT
 CJBQRKiZXmhHV4JMMgJiIDgIBDDKKvBw==
X-Google-Smtp-Source: AGHT+IGyb5rK3wU2eYffbepInpQ5nRpyDFkLvUQpXIwaKbJPhsQ9zk9+/o3WwrGqdXtMXrkY9srT5g==
X-Received: by 2002:a05:6000:40cc:b0:3fd:eb15:77a with SMTP id
 ffacd0b85a97d-425577ee891mr3832972f8f.6.1759394602152; 
 Thu, 02 Oct 2025 01:43:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c3eca22sm54562995e9.4.2025.10.02.01.43.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:43:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 16/17] hw/virtio/vhost: Replace legacy
 cpu_physical_memory_*map() calls
Date: Thu,  2 Oct 2025 10:42:01 +0200
Message-ID: <20251002084203.63899-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Use VirtIODevice::dma_as address space to convert the legacy
cpu_physical_memory_[un]map() calls to address_space_[un]map().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/virtio/vhost.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6557c58d12a..efa24aee609 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -27,6 +27,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
+#include "system/memory.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -455,7 +456,8 @@ static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                               hwaddr *plen, bool is_write)
 {
     if (!vhost_dev_has_iommu(dev)) {
-        return cpu_physical_memory_map(addr, plen, is_write);
+        return address_space_map(dev->vdev->dma_as, addr, plen, is_write,
+                                 MEMTXATTRS_UNSPECIFIED);
     } else {
         return (void *)(uintptr_t)addr;
     }
@@ -466,7 +468,8 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
                                hwaddr access_len)
 {
     if (!vhost_dev_has_iommu(dev)) {
-        cpu_physical_memory_unmap(buffer, len, is_write, access_len);
+        address_space_unmap(dev->vdev->dma_as, buffer, len, is_write,
+                            access_len);
     }
 }
 
-- 
2.51.0



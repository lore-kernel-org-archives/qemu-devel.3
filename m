Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C94C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbM7S-0000e6-AH; Fri, 24 Jan 2025 11:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbM7Q-0000do-D4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:01:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tbM7O-00087x-UY
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737734473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zSzhRdn4C5TQknUumN+J2fY4iQC6DedwUvkKqDEpUYM=;
 b=Y7c0DVPZ/O6im4vbjY6Jk0knMoppYexQM0a2i9rkdWJYhwl7sppPcTtbOnnrxdKlCmtjYI
 C588xLmKHALt+i05Vyujh1HPTsYG6Kc7yyArfuIoVSEwLjXcOQw6eafH4cw5PMceVhG7OK
 SK4bc4B80HDGQV1qvoHeSva/tT4C4cQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-anVxmih_N7KiM3qXq8QP3g-1; Fri, 24 Jan 2025 10:45:46 -0500
X-MC-Unique: anVxmih_N7KiM3qXq8QP3g-1
X-Mimecast-MFC-AGG-ID: anVxmih_N7KiM3qXq8QP3g
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43646b453bcso11101485e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 07:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737733544; x=1738338344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zSzhRdn4C5TQknUumN+J2fY4iQC6DedwUvkKqDEpUYM=;
 b=ejb/x1NekakxQ+sakRjWVTHZYz5c0sE71ADeKaNLt0GMnRAeo49cSg+AOsoL2qmos8
 /Wn5aMJzXzWJLbKM6R73ukx19sdxFnNvKCCAUntSEmeqCazoGV5Xl/5Ok3TK7PrHohjz
 z3HpfBIW7X02+bWUbdVzqMEKIAnwfrRX8+aUgeS2DDA/CW3UeIYsY2mQUv8D/HCtsoRU
 Ot0RjSv3UCyPFOYuUMzdmmIiIX9rhrrQmtHKQc5Eim/tkJb3MU31jgZ5I9t2GzyxWfju
 MPWFvpqrVgaRX+YTdcWY8V0/olQfDl39885pPpijzut2mCaMcHsez81Xo/xzngw8cuAe
 w8Rg==
X-Gm-Message-State: AOJu0YzGFGsDdCs8hdCPH5b5OkecwsNHxVNnacMKVkxipOf9rWe9cr6M
 GIYvWzcSYLYwGAv76zcyHTTbfbVVnscypLSi5Jui8kJPjpI2Fa15cB6Nx9ijjpTlWlLuJtDuR8b
 xvha+/BIMW0U5uGjKc0gYpHu/fBTT3nl/xd4RPzZOoh9hOYDpDwQE+2qQjl3ThYJOHT/KGWc8u6
 YcTcmnWDwQ/XNLSGXHFnfgbYKGmwVn/I2Tldk6VQ==
X-Gm-Gg: ASbGncvXPtVSY3wC3ky5jGbP7eQRL/jmgfg4SLjOSDjI6QVlrrO5HXMb31hca1Owpad
 ME8UvWkwMDhpsP8D5OIwqGHyUhwc0FCQtCNtFKVtsoXo6tRWa6Y7PV1y6l/wJFD5I/sEZQ2/q2Z
 Qqg+XNgds28baxiepj44xj/H0Fo/AGu3FsKkQoSANuos2mO5K0Fe8V7LCQ5iEZV+OgyB7uuIIkK
 dh3vWFLxhoTEMb0vRAnrFEkg3olZyr0rsyvwzAmyb9uyx3f7G3tFjZso7khG5V5l25axBo4DOEe
 xbpOHdNs7HFprlGtzvrYRDqCTu7RJSJMvYRHljn1bssGRZHfjwtR2kI=
X-Received: by 2002:a05:600c:63d5:b0:438:a46b:1a6 with SMTP id
 5b1f17b1804b1-438a46b0388mr226246645e9.18.1737733544518; 
 Fri, 24 Jan 2025 07:45:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfev3uAK2i1mnL/YJSd4Cd8F5Oo5ZtUyZyr1LKsC5SY/9ZgQWrvz9QqAqq6os4oHkNx3IZ6g==
X-Received: by 2002:a05:600c:63d5:b0:438:a46b:1a6 with SMTP id
 5b1f17b1804b1-438a46b0388mr226246235e9.18.1737733544022; 
 Fri, 24 Jan 2025 07:45:44 -0800 (PST)
Received: from localhost
 (p200300cbc719e000ca2c77c5de7dce89.dip0.t-ipconnect.de.
 [2003:cb:c719:e000:ca2c:77c5:de7d:ce89])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-438bd4d2c0esm30382625e9.33.2025.01.24.07.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 07:45:42 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Stefan Zabka <git@zabka.it>
Subject: [PATCH v2 3/7] physmem: factor out direct access check into
 memory_region_supports_direct_access()
Date: Fri, 24 Jan 2025 16:45:28 +0100
Message-ID: <20250124154533.3534250-4-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124154533.3534250-1-david@redhat.com>
References: <20250124154533.3534250-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Let's factor the complete "directly accessible" check independent of
the "write" condition out so we can reuse it next.

We can now split up the checks RAM and ROMD check, so we really only check
for RAM DEVICE in case of RAM -- ROM DEVICE is neither RAM not RAM DEVICE.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 086dec5086..3b4449e847 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2985,10 +2985,13 @@ MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
 bool prepare_mmio_access(MemoryRegion *mr);
 
-static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
+static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
 {
     /* ROM DEVICE regions only allow direct access if in ROMD mode. */
-    if (!memory_region_is_ram(mr) && !memory_region_is_romd(mr)) {
+    if (memory_region_is_romd(mr)) {
+        return true;
+    }
+    if (!memory_region_is_ram(mr)) {
         return false;
     }
     /*
@@ -2996,7 +2999,12 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
      * be MMIO and access using mempy can be wrong (e.g., using instructions not
      * intended for MMIO access). So we treat this as IO.
      */
-    if (memory_region_is_ram_device(mr)) {
+    return !memory_region_is_ram_device(mr);
+}
+
+static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
+{
+    if (!memory_region_supports_direct_access(mr)) {
         return false;
     }
     if (is_write) {
-- 
2.47.1



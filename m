Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C1BC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPRj-0006Hb-Pc; Mon, 10 Feb 2025 03:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRY-0006F9-1K
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1thPRW-00045u-HA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739177221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTOvCrN4mZxccS1AJtceqMgg7d6ocLtBCsm8pA3bnfA=;
 b=cqc6/kO9x4IRHL9qOp5yQs++bJWcDpwXEbsb1JEkM0IU4ENSo8jUpuNr6D40l+/6rRBDNo
 nWobPWaZ5kAoPhb8T4BsuRSdZpKYGY+ssOzmnGGrgw0s/koQ4OMw44rWfVpXLVE3zNhDj+
 S/m5qKPijI5PrfSndGSDb1r6MDFFx58=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-AvxX1k65MnKje5Jw5LPSYg-1; Mon, 10 Feb 2025 03:46:59 -0500
X-MC-Unique: AvxX1k65MnKje5Jw5LPSYg-1
X-Mimecast-MFC-AGG-ID: AvxX1k65MnKje5Jw5LPSYg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43626224274so24146725e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739177218; x=1739782018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xTOvCrN4mZxccS1AJtceqMgg7d6ocLtBCsm8pA3bnfA=;
 b=FUr7zneDURqg29YHZ/FHDQfNDuTEtLs/OFEJfrJBp29AqUbPDhH5zlvObnV5S3dF1F
 gv8Bh+E9ttI2+881zn/wij8zjxFqOnwq4Vz9QUVlHILTnhu50Ru75UQ9ixJmeUTvjFnf
 EgAK9nPV4EMq0Ayh9ZfK+dZ0U3Koqw3HPbq8vjcoikI6FhqYxODDR6sDUwqvLi1UWRfq
 saIgbqtUfQ7BpVGKC83/ngq7IlISAv4iTWPIL4x8qHb37+08HkoqVqI2XufeyMKe+wC0
 8zGeVyBSBukL6znGCOAoEwWief9FlF6ZIJN5LNlz66yg4Zs6L2e6WhPwKAtfYszUeWzF
 N2Gw==
X-Gm-Message-State: AOJu0YyP8zVAvv8vpbU+3CNg4wKjxyQh5inZj+a/NfJ7dO1D1UWN9r8z
 joi4i5GYFAvHpHn+41+Umuh9ssSdnsDwU/YjHdWf2vUnmqJabiPXGIJVYYG5HyVzEEXKVXabDh/
 cUzatdr5iNweiIBHL4FL6BJB+JPYWkpIeVlVpS50JBkOGx+czF3OCtgbjYEk0E7Ffgwxdqsy/B0
 eOCJ9O4RU/OGUrIjSITfYeMxCIz9Kwn7qL
X-Gm-Gg: ASbGncsYDyCgTxEuyzUrHq31ts+lu945t5mSlG5b3kWt6iu7Pzp82ySce86QhWJHNwV
 xubpdhle8hHWQbtl1wq/EKfj8t6rbhK7gSX26r/nUppyccIx1TNIgIB4SmzOJGuwh6c/L8RtA2n
 ku0TpUBdUNTQ8BJXNHOlYpTsH5BZZHZzb2Z5Vv3MqVg++N/+TxcacofDjGc9SWyhm1on8ZwpEWB
 0HHGY22o5FSahxdjHDOWTmbSOALal8PODdGx+2C7mJkXVKs1HBru2zfbenziXorVbMDj/5fVWu7
 mteVF8tfYmTpsbkLKGMaXSo99FYND9vl9DXWnZQSHKO4wi+PCpJkNvqoerLAKO9UKw==
X-Received: by 2002:a05:600c:5105:b0:439:386e:9859 with SMTP id
 5b1f17b1804b1-439386e98d1mr51120625e9.4.1739177218686; 
 Mon, 10 Feb 2025 00:46:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPjDiL5pZBi9owqpm+TapF2OF2MjbbZOLDJ+wjvZztM7NQQaKqaaMRpgxCR1zkkKMTKOL0Cw==
X-Received: by 2002:a05:600c:5105:b0:439:386e:9859 with SMTP id
 5b1f17b1804b1-439386e98d1mr51120265e9.4.1739177218222; 
 Mon, 10 Feb 2025 00:46:58 -0800 (PST)
Received: from localhost
 (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de.
 [2003:cb:c734:b800:12c4:65cd:348a:aee6])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4391da964e2sm140093095e9.4.2025.02.10.00.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:46:57 -0800 (PST)
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
Subject: [PATCH v3 2/7] physmem: factor out RAM/ROMD check in
 memory_access_is_direct()
Date: Mon, 10 Feb 2025 09:46:43 +0100
Message-ID: <20250210084648.33798-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210084648.33798-1-david@redhat.com>
References: <20250210084648.33798-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let's factor more of the generic "is this directly accessible" check,
independent of the "write" condition out.

Note that the "!mr->rom_device" check in the write case essentially
disallows the memory_region_is_romd() condition again. Further note that
RAM DEVICE regions are also RAM regions, so we can check for RAM+ROMD
first.

This is a preparation for further changes.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5cd7574c60..cb35c38402 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2997,6 +2997,10 @@ bool prepare_mmio_access(MemoryRegion *mr);
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
+    /* ROM DEVICE regions only allow direct access if in ROMD mode. */
+    if (!memory_region_is_ram(mr) && !memory_region_is_romd(mr)) {
+        return false;
+    }
     /*
      * RAM DEVICE regions can be accessed directly using memcpy, but it might
      * be MMIO and access using mempy can be wrong (e.g., using instructions not
@@ -3006,11 +3010,9 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
         return false;
     }
     if (is_write) {
-        return memory_region_is_ram(mr) && !mr->readonly &&
-               !mr->rom_device;
-    } else {
-        return memory_region_is_ram(mr) || memory_region_is_romd(mr);
+        return !mr->readonly && !mr->rom_device;
     }
+    return true;
 }
 
 /**
-- 
2.48.1



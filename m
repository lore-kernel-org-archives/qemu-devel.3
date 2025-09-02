Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2036ACA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 21:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utYjh-0002Of-F0; Tue, 02 Sep 2025 17:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1utYjf-0002O2-PX
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 17:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1utYjc-0003Fe-Po
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 17:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756849210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8/AZsWJV3PvkJt4oVdod4Ydf8bV0b5EAA3J0l0E6vx8=;
 b=XOG9gbd8+FCM7WP7iA9/RFleyySpTs/eLrUAfjF2aK8u9Z+s8DoJTYCGpuc4k+GfmTbXmO
 iwTcEkX4RIAJMKACkMRk5nrcfR1uu4tpPpI5jVsU8jTXlVFJwZQQg0eYkoHNhGyZrkUKwF
 wrql7jo15/p0kMLALNzrQVel6AnxMPU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-UwIBzLj2PY6bx3_c0pINow-1; Tue, 02 Sep 2025 17:40:08 -0400
X-MC-Unique: UwIBzLj2PY6bx3_c0pINow-1
X-Mimecast-MFC-AGG-ID: UwIBzLj2PY6bx3_c0pINow_1756849208
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70de0bdb600so96944286d6.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 14:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756849207; x=1757454007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/AZsWJV3PvkJt4oVdod4Ydf8bV0b5EAA3J0l0E6vx8=;
 b=DI4zXQ0pe2o+bPr8cmJ0rXiNNZ9uz5j6Ko27xUD5hYekEOQ2FW0ifH5lRSMgoe48Ui
 z2XX8yfEn1H6T7AaxpPrpbBoyR284ZFtAq8xBAXAGauv/Qh5PnSAQY22QsV4F2qmHcLL
 wQbIwmCHFcnVaOoKAcHrRJdEl26DW1jVJPuhBqqUjONFG49suOArWDSNN44Bat9FF1LQ
 XlS+nDkyzkLV9zHUUlud9dtix0jUkzYE7khi0AX5sMuzPkR+uES3tCW2nTX0fpE6SmtS
 coO5d3fJRoxKZ1o230OkoNxr884bOGvwuM93p1efeb6ovoWcYBx5GM7jGixEH1Akbu8B
 9RjA==
X-Gm-Message-State: AOJu0YxLCh4mdbsGvLITqHm9B4rEtvFT+USdV7+wI0emCj6eMei6FYv9
 5257dwDiAsiIvJBQmLDL7b0vADsku3opTG78l8XKo4Ft7e7RFqzrQa2rOOns06x7qiPLtzNNNE5
 gNj708Pw6RjJtnbOwQzApFvL6JtfL4HP2yMJXhxe+zplWhJWSHuTfRwnM+yfNWSJ7Zho8c3juuA
 Vxcmy3L8djXJvGoziEat8ubd2TkET4qmxjySv6Lw==
X-Gm-Gg: ASbGnctO6G08wRXZLerDS5URbc80lKZJxa+l0//Rcm53RWjwLjTGReoNTDE4ZiwuFFo
 9Kf0aq6Z0sOt7T555Swl0KL1W+lhPidBESUPe8f3HtvshcnTdQrB/C/Al1iVnxT0z6gzTCs0PlR
 ABpNYMiWMgqgDlVgcN939F6BeEjJ+mYb3BBWbgUG5i/BUOs5p+3s6W9BZbVVON5V04GcFPlQDR6
 +EUSNMYxutRpzcoVwRKaNszatSoXQoLxWVrTYy9ybpdiqItNrSBknnlAO2vPOepAF4VLTlC4FPy
 jDqyasTi9t4+0dRVF6I5Ys2lkLbdJFkj5wRJQguBfH0KDo29nb4GsonFQpk/H1Eiu3bEbAAfpzH
 5/eZc4Qk44CB2RXcJgNM=
X-Received: by 2002:a05:6214:268a:b0:720:21b5:a696 with SMTP id
 6a1803df08f44-72021b5dd63mr50361376d6.39.1756849207636; 
 Tue, 02 Sep 2025 14:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzF0n3gWz2VIoIV1vg1eLTocu6B6Lwp9duH/zacVVZ8nl9DiFdzUY97LYAg9FL82hqRWiRHg==
X-Received: by 2002:a05:6214:268a:b0:720:21b5:a696 with SMTP id
 6a1803df08f44-72021b5dd63mr50361146d6.39.1756849207210; 
 Tue, 02 Sep 2025 14:40:07 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-720ac262a4fsm18619106d6.11.2025.09.02.14.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 14:40:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] memory: Fix addr for flatview_access_allowed()
Date: Tue,  2 Sep 2025 17:40:05 -0400
Message-ID: <20250902214005.730358-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

flatview_access_allowed() should pass in the address offset of the memory
region, rather than the global address space.

Shouldn't be a major issue yet, since the addr is only used in an error
log.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: 3ab6fdc91b ("softmmu/physmem: Introduce MemTxAttrs::memory field and MEMTX_ACCESS_ERROR")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/physmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index f498572fc8..019118cf75 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3027,7 +3027,7 @@ static MemTxResult flatview_write(FlatView *fv, hwaddr addr, MemTxAttrs attrs,
 
     l = len;
     mr = flatview_translate(fv, addr, &mr_addr, &l, true, attrs);
-    if (!flatview_access_allowed(mr, attrs, addr, len)) {
+    if (!flatview_access_allowed(mr, attrs, mr_addr, len)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_write_continue(fv, addr, attrs, buf, len,
@@ -3118,7 +3118,7 @@ static MemTxResult flatview_read(FlatView *fv, hwaddr addr,
 
     l = len;
     mr = flatview_translate(fv, addr, &mr_addr, &l, false, attrs);
-    if (!flatview_access_allowed(mr, attrs, addr, len)) {
+    if (!flatview_access_allowed(mr, attrs, mr_addr, len)) {
         return MEMTX_ACCESS_ERROR;
     }
     return flatview_read_continue(fv, addr, attrs, buf, len,
-- 
2.50.1



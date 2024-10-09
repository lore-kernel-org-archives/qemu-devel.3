Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B27CEDD89
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1v-0004lD-IX; Wed, 09 Oct 2024 08:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1t-0004kn-HV
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1r-0005U7-J6
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+wIGbgV5H0wjlK7GrUwKudWkLFcFUw55bTCvhh/IyA=;
 b=OeECgINOBEHukLpBZBGmGq9xBylweEku3whtTflK3TMbVmVy63QHfQOZGBgZbpu83Qmg/E
 M1wYodYO2KjC6yVGtTWYkOuhg1Pun9Q9ob+EnlJ5hzqpNgdTCNTUylL/zQz65myiFbncm4
 DOw6LjtDRdXoR2YHscaGv+OWJaYBlNo=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-_7Urry08ONKawkh4quHZ4A-1; Wed, 09 Oct 2024 08:42:58 -0400
X-MC-Unique: _7Urry08ONKawkh4quHZ4A-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-8324396d0abso592609739f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477777; x=1729082577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+wIGbgV5H0wjlK7GrUwKudWkLFcFUw55bTCvhh/IyA=;
 b=RiV6zkCjPqDhy9eqTB4g1G8Mb4QOU6X4l7xSKOzQTtulAr0nG0y7i0H1ux2zMQ/VWE
 ZrXb1R9aTsu/EIJ42K1nAVTCNYEpZUPT8vmJi0XW4nza6xUe60nd6G7gfdlQBqPbbC8o
 bfl0mpS3eLRAWGSq9pEK7YiLBx1g4bBTpJzNp8aWNtQzay093QSBLiFzVUg+JvqafEAa
 lQ+ieXFUEc5KQFSCdwu445Mq+SmgycJhA3CtQFapR7gm8QZJQuo/UghsNIRo/wttqYn1
 ko4WaRY+yTSoCsqYzUHBBw3A3fHKPZHxOUDbJrTCFlUseZ2H5q2TCRMrVK5SpACL3Pay
 s2bA==
X-Gm-Message-State: AOJu0YzC+LKazoaOBChPJSZlBm5fwRmqQeR9i35WaUkHzf/0XrC5w6zt
 RE9w5nD/6b+vJh+bH8mthYPySofW1tvW2rw7c32jwcn9V1vFvwd5BgVrbkkOzbTXC2pC5GuuNey
 M1mrbZYkmZEOyxf+v1msu4ifmmrdi3wcSkFXdDuNYnI6Gl5YVVaYJ3zdCDOdBlLG5qmJDDMm54C
 suY/kyk89vatM5JEvHI5W16bPGKgkTg0GtWA==
X-Received: by 2002:a05:6602:60c7:b0:82a:2a67:9429 with SMTP id
 ca18e2360f4ac-8353d48688cmr215067439f.5.1728477776712; 
 Wed, 09 Oct 2024 05:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGazowKqpzjvhCxeW3v0isqd/4xcwvSuhYSh1LvffTX72nD7KdgCm5y9YpeHx1kngccXPv51A==
X-Received: by 2002:a05:6602:60c7:b0:82a:2a67:9429 with SMTP id
 ca18e2360f4ac-8353d48688cmr215063839f.5.1728477776154; 
 Wed, 09 Oct 2024 05:42:56 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 08/12] migration/postcopy: Use uffd helpers
Date: Wed,  9 Oct 2024 08:42:34 -0400
Message-ID: <20241009124238.371084-9-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

Use the uffd_copy_page, uffd_zero_page and uffd_wakeup helpers
rather than calling ioctl ourselves.

They return -errno on error, and print an error_report themselves.
I think this actually makes postcopy_place_page actually more
consistent in it's callers.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240919134626.166183-7-dave@treblig.org
[peterx: fix i386 build]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 48 ++++++++++++----------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 0fe9d83d44..83f6160a36 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -746,18 +746,10 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
                          RAMBlock *rb)
 {
     size_t pagesize = qemu_ram_pagesize(rb);
-    struct uffdio_range range;
-    int ret;
     trace_postcopy_wake_shared(client_addr, qemu_ram_get_idstr(rb));
-    range.start = ROUND_DOWN(client_addr, pagesize);
-    range.len = pagesize;
-    ret = ioctl(pcfd->fd, UFFDIO_WAKE, &range);
-    if (ret) {
-        error_report("%s: Failed to wake: %zx in %s (%s)",
-                     __func__, (size_t)client_addr, qemu_ram_get_idstr(rb),
-                     strerror(errno));
-    }
-    return ret;
+    return uffd_wakeup(pcfd->fd,
+                       (void *)(uintptr_t)ROUND_DOWN(client_addr, pagesize),
+                       pagesize);
 }
 
 static int postcopy_request_page(MigrationIncomingState *mis, RAMBlock *rb,
@@ -1275,18 +1267,10 @@ static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
     int ret;
 
     if (from_addr) {
-        struct uffdio_copy copy_struct;
-        copy_struct.dst = (uint64_t)(uintptr_t)host_addr;
-        copy_struct.src = (uint64_t)(uintptr_t)from_addr;
-        copy_struct.len = pagesize;
-        copy_struct.mode = 0;
-        ret = ioctl(userfault_fd, UFFDIO_COPY, &copy_struct);
+        ret = uffd_copy_page(userfault_fd, host_addr, from_addr, pagesize,
+                             false);
     } else {
-        struct uffdio_zeropage zero_struct;
-        zero_struct.range.start = (uint64_t)(uintptr_t)host_addr;
-        zero_struct.range.len = pagesize;
-        zero_struct.mode = 0;
-        ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
+        ret = uffd_zero_page(userfault_fd, host_addr, pagesize, false);
     }
     if (!ret) {
         qemu_mutex_lock(&mis->page_request_mutex);
@@ -1343,18 +1327,16 @@ int postcopy_place_page(MigrationIncomingState *mis, void *host, void *from,
                         RAMBlock *rb)
 {
     size_t pagesize = qemu_ram_pagesize(rb);
+    int e;
 
     /* copy also acks to the kernel waking the stalled thread up
      * TODO: We can inhibit that ack and only do it if it was requested
      * which would be slightly cheaper, but we'd have to be careful
      * of the order of updating our page state.
      */
-    if (qemu_ufd_copy_ioctl(mis, host, from, pagesize, rb)) {
-        int e = errno;
-        error_report("%s: %s copy host: %p from: %p (size: %zd)",
-                     __func__, strerror(e), host, from, pagesize);
-
-        return -e;
+    e = qemu_ufd_copy_ioctl(mis, host, from, pagesize, rb);
+    if (e) {
+        return e;
     }
 
     trace_postcopy_place_page(host);
@@ -1376,12 +1358,10 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
      * but it's not available for everything (e.g. hugetlbpages)
      */
     if (qemu_ram_is_uf_zeroable(rb)) {
-        if (qemu_ufd_copy_ioctl(mis, host, NULL, pagesize, rb)) {
-            int e = errno;
-            error_report("%s: %s zero host: %p",
-                         __func__, strerror(e), host);
-
-            return -e;
+        int e;
+        e = qemu_ufd_copy_ioctl(mis, host, NULL, pagesize, rb);
+        if (e) {
+            return e;
         }
         return postcopy_notify_shared_wake(rb,
                                            qemu_ram_block_host_offset(rb,
-- 
2.45.0



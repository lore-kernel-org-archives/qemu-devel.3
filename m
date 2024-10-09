Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9332CEDD8F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW1u-0004kw-GI; Wed, 09 Oct 2024 08:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1r-0004kB-Up
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW1q-0005TU-52
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EPwjO7n6gAxf8tb/k3NaSmBNEtRkZrTncHigcs6P44U=;
 b=c0zplawT36t1l84y/EZFVWLT4cUp6KUebMMkh60N140gcjPFS+m6jlJqpSn5aXGkSiKCyY
 AAawi3+kpRjrPYo5TGkzEGYGmqeV5MwDah09zOg7ugacZlgsLfW9lVEY3YrBTvYHozk/ja
 9Xnf7dKJJxNCsTX0eIfe4z7AIUsbzUg=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-vRqT1UQSMoCRoKoz0ZaA1Q-1; Wed, 09 Oct 2024 08:42:56 -0400
X-MC-Unique: vRqT1UQSMoCRoKoz0ZaA1Q-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83544f524ebso33396839f.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477774; x=1729082574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPwjO7n6gAxf8tb/k3NaSmBNEtRkZrTncHigcs6P44U=;
 b=GQYAhRU7EEU5aZpTAk0JB6FyVFOuqcZ300AKNzdAvBYBwHhWv3GmxKhs0TGb8bnMkw
 pZj+HYbtCGQOnxORJkcuqrsPsXGyV2IuVDSjcC/m5VgONH6Eb1G1gwDIoxyRx8HrQiS8
 fOGBaAXz0ci61bUsDh4LwHYeYp2NQknPBF8gYlplRGFKFWqoFV/wG4pg/koZrm3ImJaS
 kQmvgRbWsMfmoM9vqfyhXlFZSpuGkTfsVIkpFzRt7CCih0ZFZDK8iX25wluG8uYqP5zA
 YNtxlMW3qLbfMyzgChDVdCwztwg9hXkxg1Azl+casMqZ9QeSUedkelyi3eu5LI6LpvVd
 PttQ==
X-Gm-Message-State: AOJu0YxZEHPRS6DoP2XVipUkWKeQlign7QUEQKpcv7eKYDhfnM0QWZiQ
 Ox6L4AxgX66mekpYFkxzcMNjh84CzTczAKZstbDK+uoh/46eQlzt54eT8NIwkcB3WQEQA6X5DAd
 2LKMhTq/AHZnJQVIJgkhYfaqmJU5TL6tGkVPIVLrlOEYhDpxK36eON/6pa/FfnWFvLj8FcPMlRJ
 ERrsZxkPQfwRgahX5v6MCAZ2rTmmmxWGzHpQ==
X-Received: by 2002:a05:6602:1554:b0:82c:f30d:fc72 with SMTP id
 ca18e2360f4ac-8353d4824demr181280239f.2.1728477774476; 
 Wed, 09 Oct 2024 05:42:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtG12tdST9qX1w8USus5SfYTeOHD396wropQBAOzggQ9fkcTVcO4uKZYA6o/8ZcLVJV5WS3A==
X-Received: by 2002:a05:6602:1554:b0:82c:f30d:fc72 with SMTP id
 ca18e2360f4ac-8353d4824demr181276639f.2.1728477773863; 
 Wed, 09 Oct 2024 05:42:53 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aacb18sm220272039f.30.2024.10.09.05.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:42:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 07/12] util/userfaultfd: Return -errno on error
Date: Wed,  9 Oct 2024 08:42:33 -0400
Message-ID: <20241009124238.371084-8-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241009124238.371084-1-peterx@redhat.com>
References: <20241009124238.371084-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Convert (the currently unused) uffd_wakeup, uffd_copy_page and
uffd_zero_page to return -errno on error rather than -1.

That will make it easier to reuse in postcopy.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240919134626.166183-6-dave@treblig.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/userfaultfd.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/util/userfaultfd.c b/util/userfaultfd.c
index 1b2fa949d4..518d5c3586 100644
--- a/util/userfaultfd.c
+++ b/util/userfaultfd.c
@@ -240,7 +240,7 @@ int uffd_change_protection(int uffd_fd, void *addr, uint64_t length,
  * Copy range of source pages to the destination to resolve
  * missing page fault somewhere in the destination range.
  *
- * Returns 0 on success, negative value in case of an error
+ * Returns 0 on success, -errno in case of an error
  *
  * @uffd_fd: UFFD file descriptor
  * @dst_addr: destination base address
@@ -259,10 +259,11 @@ int uffd_copy_page(int uffd_fd, void *dst_addr, void *src_addr,
     uffd_copy.mode = dont_wake ? UFFDIO_COPY_MODE_DONTWAKE : 0;
 
     if (ioctl(uffd_fd, UFFDIO_COPY, &uffd_copy)) {
+        int e = errno;
         error_report("uffd_copy_page() failed: dst_addr=%p src_addr=%p length=%" PRIu64
                 " mode=%" PRIx64 " errno=%i", dst_addr, src_addr,
-                length, (uint64_t) uffd_copy.mode, errno);
-        return -1;
+                length, (uint64_t) uffd_copy.mode, e);
+        return -e;
     }
 
     return 0;
@@ -273,7 +274,7 @@ int uffd_copy_page(int uffd_fd, void *dst_addr, void *src_addr,
  *
  * Fill range pages with zeroes to resolve missing page fault within the range.
  *
- * Returns 0 on success, negative value in case of an error
+ * Returns 0 on success, -errno in case of an error
  *
  * @uffd_fd: UFFD file descriptor
  * @addr: base address
@@ -289,10 +290,11 @@ int uffd_zero_page(int uffd_fd, void *addr, uint64_t length, bool dont_wake)
     uffd_zeropage.mode = dont_wake ? UFFDIO_ZEROPAGE_MODE_DONTWAKE : 0;
 
     if (ioctl(uffd_fd, UFFDIO_ZEROPAGE, &uffd_zeropage)) {
+        int e = errno;
         error_report("uffd_zero_page() failed: addr=%p length=%" PRIu64
                 " mode=%" PRIx64 " errno=%i", addr, length,
-                (uint64_t) uffd_zeropage.mode, errno);
-        return -1;
+                (uint64_t) uffd_zeropage.mode, e);
+        return -e;
     }
 
     return 0;
@@ -306,7 +308,7 @@ int uffd_zero_page(int uffd_fd, void *addr, uint64_t length, bool dont_wake)
  * via UFFD-IO IOCTLs with MODE_DONTWAKE flag set, then after that all waits
  * for the whole memory range are satisfied in a single call to uffd_wakeup().
  *
- * Returns 0 on success, negative value in case of an error
+ * Returns 0 on success, -errno in case of an error
  *
  * @uffd_fd: UFFD file descriptor
  * @addr: base address
@@ -320,9 +322,10 @@ int uffd_wakeup(int uffd_fd, void *addr, uint64_t length)
     uffd_range.len = length;
 
     if (ioctl(uffd_fd, UFFDIO_WAKE, &uffd_range)) {
+        int e = errno;
         error_report("uffd_wakeup() failed: addr=%p length=%" PRIu64 " errno=%i",
-                addr, length, errno);
-        return -1;
+                addr, length, e);
+        return -e;
     }
 
     return 0;
-- 
2.45.0



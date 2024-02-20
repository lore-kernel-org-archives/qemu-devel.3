Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F404C54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcL9J-0002k8-0l; Tue, 20 Feb 2024 03:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL9G-0002jV-VV
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcL9F-0000QG-9U
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCJF7iMGMoLJv/RXZyxeTLRASb/UgT/sAKL+7AcIFUs=;
 b=AneRW4C9zh5JGFXvE25AStcBA8sXb3KBgPWfToNZrVmWr6J4qqDzAg3GvN1mq1DTRWdBU7
 CAcvl4bZmQEVfBis+00tt3I1/+wL30opEXMWwDlxITCqD4OWXERnqdfywTrtmp32gB4cTw
 Sxc1Cqv2ohSvPwdhWudrvs3Q/v6qwzM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-7AZopYIcNmy_Vuj2lVseSw-1; Tue, 20 Feb 2024 03:06:39 -0500
X-MC-Unique: 7AZopYIcNmy_Vuj2lVseSw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5640681bc11so1963949a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416397; x=1709021197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCJF7iMGMoLJv/RXZyxeTLRASb/UgT/sAKL+7AcIFUs=;
 b=JVdZwmrLmKV4Gwslyc1/xhfILiBLL8K6AKy5kpPgdfTG7nCrTcfI6K85Vuvrp82nfj
 guhnFNr8LGSXu9jQoKWtPhFuY3QMWMv2dTEyYquGtvZzaCI6DD/tTaHiJZAGHX8/2sFk
 Zw1N+mLFCabKQuyPlnLmDZ1ct92Yxz+plw/7Kox3ZV+iAW/FinU/NI1P/STs5nzi26hj
 jKngRyNdUlR3kM/vyMO9puJo5BfqDqDykoYGKDqKLi/QKtEsPvY+tLcMbEidaSfFj3A2
 NBKbdBQeHLI0np0CjqCR7yuXbX0iyfP5Ob8cwwByblgU2lK5aesj3ihAbFruBarWLY85
 5A+g==
X-Gm-Message-State: AOJu0YwairWROpzm0uM6MmrzsPSda3nZ0i1uD3kBCWVDKxeTn0HFKmPK
 i0zbDAQOPYT+eDGCqSizNUyYpJv5/9vn6nR9YS9hijh4lAIJ+uzi9Zu5c1YffNpSLQqXvVSCPGl
 iu1u2ui4pKFAghsZdW9PDTu+DoLt/h/tr8vlxJUcAA35AiTwiC7hPyKgTT7I3Acv8deEBHHFW+A
 pN13FpckjjZL2vMGgW7S+ICDtC2FuU+bggfIHE
X-Received: by 2002:aa7:ca52:0:b0:563:ea79:fccd with SMTP id
 j18-20020aa7ca52000000b00563ea79fccdmr8044867edt.11.1708416397181; 
 Tue, 20 Feb 2024 00:06:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaQTb6glt3K+r9vYFLfurLWMB1Aw7fpFhS4FXlRLIZAiBZMMtaQ9Gv2Tfv2xUss11SIJ9HfQ==
X-Received: by 2002:aa7:ca52:0:b0:563:ea79:fccd with SMTP id
 j18-20020aa7ca52000000b00563ea79fccdmr8044853edt.11.1708416396844; 
 Tue, 20 Feb 2024 00:06:36 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 p27-20020a056402501b00b00562d908daf4sm3501996eda.84.2024.02.20.00.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:06:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/17] physmem: replace function name with __func__ in
 ram_block_discard_range()
Date: Tue, 20 Feb 2024 09:05:46 +0100
Message-ID: <20240220080558.365903-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Use __func__ to avoid hard-coded function name.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240125023328.2520888-1-xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/physmem.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 5e66d9ae361..5e054650b88 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3495,16 +3495,15 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
     uint8_t *host_startaddr = rb->host + start;
 
     if (!QEMU_PTR_IS_ALIGNED(host_startaddr, rb->page_size)) {
-        error_report("ram_block_discard_range: Unaligned start address: %p",
-                     host_startaddr);
+        error_report("%s: Unaligned start address: %p",
+                     __func__, host_startaddr);
         goto err;
     }
 
     if ((start + length) <= rb->max_length) {
         bool need_madvise, need_fallocate;
         if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
-            error_report("ram_block_discard_range: Unaligned length: %zx",
-                         length);
+            error_report("%s: Unaligned length: %zx", __func__, length);
             goto err;
         }
 
@@ -3528,8 +3527,8 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
              * proper error message.
              */
             if (rb->flags & RAM_READONLY_FD) {
-                error_report("ram_block_discard_range: Discarding RAM"
-                             " with readonly files is not supported");
+                error_report("%s: Discarding RAM with readonly files is not"
+                             " supported", __func__);
                 goto err;
 
             }
@@ -3544,27 +3543,26 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
              * file.
              */
             if (!qemu_ram_is_shared(rb)) {
-                warn_report_once("ram_block_discard_range: Discarding RAM"
+                warn_report_once("%s: Discarding RAM"
                                  " in private file mappings is possibly"
                                  " dangerous, because it will modify the"
                                  " underlying file and will affect other"
-                                 " users of the file");
+                                 " users of the file", __func__);
             }
 
             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                             start, length);
             if (ret) {
                 ret = -errno;
-                error_report("ram_block_discard_range: Failed to fallocate "
-                             "%s:%" PRIx64 " +%zx (%d)",
-                             rb->idstr, start, length, ret);
+                error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
+                             __func__, rb->idstr, start, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
-            error_report("ram_block_discard_range: fallocate not available/file"
+            error_report("%s: fallocate not available/file"
                          "%s:%" PRIx64 " +%zx (%d)",
-                         rb->idstr, start, length, ret);
+                         __func__, rb->idstr, start, length, ret);
             goto err;
 #endif
         }
@@ -3582,25 +3580,23 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             }
             if (ret) {
                 ret = -errno;
-                error_report("ram_block_discard_range: Failed to discard range "
+                error_report("%s: Failed to discard range "
                              "%s:%" PRIx64 " +%zx (%d)",
-                             rb->idstr, start, length, ret);
+                             __func__, rb->idstr, start, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
-            error_report("ram_block_discard_range: MADVISE not available"
-                         "%s:%" PRIx64 " +%zx (%d)",
-                         rb->idstr, start, length, ret);
+            error_report("%s: MADVISE not available %s:%" PRIx64 " +%zx (%d)",
+                         __func__, rb->idstr, start, length, ret);
             goto err;
 #endif
         }
         trace_ram_block_discard_range(rb->idstr, host_startaddr, length,
                                       need_madvise, need_fallocate, ret);
     } else {
-        error_report("ram_block_discard_range: Overrun block '%s' (%" PRIu64
-                     "/%zx/" RAM_ADDR_FMT")",
-                     rb->idstr, start, length, rb->max_length);
+        error_report("%s: Overrun block '%s' (%" PRIu64 "/%zx/" RAM_ADDR_FMT")",
+                     __func__, rb->idstr, start, length, rb->max_length);
     }
 
 err:
-- 
2.43.0



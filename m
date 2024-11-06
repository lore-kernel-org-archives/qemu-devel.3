Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F73D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8k5O-00063i-80; Wed, 06 Nov 2024 12:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8k5N-00063Y-5T
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8k5L-0006Zu-71
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730915088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=39444N7AmsbquVXwjsvn5uyPIbnntcIOfcpvI/XvMRo=;
 b=WpTPqXEpFhooxD0sCigPzKo2AE4UOCuhfmi/34P5kY+EMOoqgLjhOO5abBGmDubHor3dQS
 rLhmRdcOdREi+xUy9VuEhSDt6g1uglO25UZ8l52lqAKLuemZEcYSFaMoCRAoG3onMU+Hqo
 jG0Tatcxjg31jbe1GtfpH/2Ze6OGwk4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-RWZl2iJtOEemgU6rS1EJiw-1; Wed, 06 Nov 2024 12:44:47 -0500
X-MC-Unique: RWZl2iJtOEemgU6rS1EJiw-1
X-Mimecast-MFC-AGG-ID: RWZl2iJtOEemgU6rS1EJiw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43164f21063so356885e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915086; x=1731519886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=39444N7AmsbquVXwjsvn5uyPIbnntcIOfcpvI/XvMRo=;
 b=Ai2okeiVgdvvepLM/0nAx/i1TeWw/3B8SVYTBx99VcsxmsJdGD1l7ngKJUZMjzJsnR
 vTuazsE6C+Qe9IdiWWe/zBG0lLN0qw1holwENCPG41RN6ex01FKvsLFDigZmGnKfiKNp
 ZWbg5D/cDA3lpAsyQRtCh2sHo1t/ZdCS6HV4dd6veJVSwNdbZiNtgDZKFeHyHQtmOj8g
 pmOZdLRgQ464fkDiIj3P0R1Mj0XTHBlGiSNFxj3rNmcS3jQyWWhdpHcjwYJAUQ999QIg
 ndsEsqt+diG9Rn853hrMjXKcj7xTpypNibALxXcvuB8f0MbwA7d3eJ0vrvdy/BITfbiZ
 zuUQ==
X-Gm-Message-State: AOJu0Yzy+TGql7FwarYIzEIq86uZZevYv8kLGdMQRoPAClfE+oTll/u1
 zjL/KGj2YSflJ6ArHSS8TiXBcvGCLgpEj2AgEmizE9eWSTkFfhY8D5TgPbBHD3YGNjQ7LPqGAXl
 amPHkxccAIHurDvqFcCGaYe3jH0pgoO9yAUFhJOvbQ2v4oDA43jaDVtzZzyosXgsqz1RBnteqey
 uip/TXkVUtJ3hVTlAKMJILku8A3F5emQt7qFebiWc=
X-Received: by 2002:a05:600c:4215:b0:431:55af:a230 with SMTP id
 5b1f17b1804b1-431bb9e6031mr247314545e9.33.1730915085690; 
 Wed, 06 Nov 2024 09:44:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtoW7iq/+qgVJK26E79LHRiw1Aq1k5YVB3HyMbDh097FGaMnxaDv6YIIS2MvgwvEzBjwxbVw==
X-Received: by 2002:a05:600c:4215:b0:431:55af:a230 with SMTP id
 5b1f17b1804b1-431bb9e6031mr247314375e9.33.1730915085231; 
 Wed, 06 Nov 2024 09:44:45 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7f80sm19805881f8f.20.2024.11.06.09.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 09:44:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dorjoychy111@gmail.com
Subject: [PATCH] eif: cope with huge section sizes
Date: Wed,  6 Nov 2024 18:44:43 +0100
Message-ID: <20241106174443.557557-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Check for overflow as well as allocation failure.  Resolves Coverity CID 1564859.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/eif.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/hw/core/eif.c b/hw/core/eif.c
index cbcd80de58b..25f2aedf3fa 100644
--- a/hw/core/eif.c
+++ b/hw/core/eif.c
@@ -123,6 +123,10 @@ static bool read_eif_header(FILE *f, EifHeader *header, uint32_t *crc,
 
     for (int i = 0; i < MAX_SECTIONS; ++i) {
         header->section_sizes[i] = be64_to_cpu(header->section_sizes[i]);
+        if (header->section_sizes[i] > SSIZE_MAX) {
+            error_setg(errp, "Invalid EIF image. Section size out of bounds");
+            return false;
+        }
     }
 
     header->unused = be32_to_cpu(header->unused);
@@ -282,7 +286,12 @@ static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
     struct cbor_load_result result;
     bool ret = false;
 
-    sig = g_malloc(size);
+    sig = g_try_malloc(size);
+    if (!sig) {
+        error_setg(errp, "Out of memory reading signature section");
+        goto cleanup;
+    }
+
     got = fread(sig, 1, size, eif);
     if ((uint64_t) got != size) {
         error_setg(errp, "Failed to read EIF signature section data");
@@ -324,7 +333,12 @@ static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
         error_setg(errp, "Invalid signature CBOR");
         goto cleanup;
     }
-    cert = g_malloc(len);
+    cert = g_try_malloc(len);
+    if (!cert) {
+        error_setg(errp, "Out of memory reading signature section");
+        goto cleanup;
+    }
+
     for (int i = 0; i < len; ++i) {
         cbor_item_t *tmp = cbor_array_get(pair->value, i);
         if (!tmp) {
@@ -503,7 +517,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 goto cleanup;
             }
 
-            ptr = g_malloc(hdr.section_size);
+            ptr = g_try_malloc(hdr.section_size);
+            if (!ptr) {
+                error_setg(errp, "Out of memory reading kernel section");
+                goto cleanup;
+            }
 
             iov_ptr = g_malloc(sizeof(struct iovec));
             iov_ptr->iov_base = ptr;
@@ -528,7 +546,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 goto cleanup;
             }
             size = hdr.section_size;
-            *cmdline = g_malloc(size + 1);
+            *cmdline = g_try_malloc(size + 1);
+            if (!cmdline) {
+                error_setg(errp, "Out of memory reading command line section");
+                goto cleanup;
+            }
             if (!read_eif_cmdline(f, size, *cmdline, &crc, errp)) {
                 goto cleanup;
             }
@@ -567,7 +589,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 }
             }
 
-            ptr = g_malloc(hdr.section_size);
+            ptr = g_try_malloc(hdr.section_size);
+            if (!ptr) {
+                error_setg(errp, "Out of memory reading initrd section");
+                goto cleanup;
+            }
 
             iov_ptr = g_malloc(sizeof(struct iovec));
             iov_ptr->iov_base = ptr;
@@ -606,7 +632,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
             uint8_t *buf;
             size_t got;
             uint64_t size = hdr.section_size;
-            buf = g_malloc(size);
+            buf = g_try_malloc(size);
+            if (!buf) {
+                error_setg(errp, "Out of memory reading unknown section");
+                goto cleanup;
+            }
             got = fread(buf, 1, size, f);
             if ((uint64_t) got != size) {
                 g_free(buf);
@@ -662,7 +692,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
             goto cleanup;
         }
 
-        ptr = g_malloc(machine_initrd_size);
+        ptr = g_try_malloc(machine_initrd_size);
+        if (!ptr) {
+            error_setg(errp, "Out of memory reading initrd file");
+            goto cleanup;
+        }
 
         iov_ptr = g_malloc(sizeof(struct iovec));
         iov_ptr->iov_base = ptr;
-- 
2.47.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E515ED5E122
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 07:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9g0u-0002rW-Up; Sat, 09 Nov 2024 02:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9g0s-0002qw-7S
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:36:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9g0q-0007xo-IE
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 02:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731137763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WRuK40LMZj1NJAkHcaeGZ1FjZgqUlgui1vlChnBcd/E=;
 b=ZJSeXdAZDoagNMtBYm6V/LY7hDra1HtFsA6zZ5VcZqR7BGDBc68B/rlV0YmFPRqLr8dNtG
 l9j+GhJHRhutodPSkVhUfz2tDyyCDsHs4iee+XTOgVxi1xDRF8RaabKk/daxdGPBHHy3ju
 hiPX1byHP1ZVBmMJS2wq0P7nE3Nqy+4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-iZubK3ntNsSutoPcgSL45A-1; Sat, 09 Nov 2024 02:36:01 -0500
X-MC-Unique: iZubK3ntNsSutoPcgSL45A-1
X-Mimecast-MFC-AGG-ID: iZubK3ntNsSutoPcgSL45A
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d432f9f5eso1458641f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 23:36:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731137760; x=1731742560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRuK40LMZj1NJAkHcaeGZ1FjZgqUlgui1vlChnBcd/E=;
 b=G5X5C8purUplXVRqvypryMoWglRhLVNwAYcfNPh3UKdOtG7Aoq/K8IMib6I7RLZh+c
 uY8+U8q0CgkE3hp1cgPPO91vlrEruZE23A27/tAJyqNbxei5z29V21KPl75AihA320VE
 T5Q4yiMb4vSmWindVSLylm7vCo2vOzXznjUl2nsBTfPmMv2/PzFdQGtgNDj5b5FyZCYE
 bfsxH1/kn5qRmlDbD8e2Z3a5hzLoJXb279VgHauAnZUvFYFFa4RgkjV4kS48hPliQVeo
 MOAX1l7H53guBTLb/QIPWL10BuR+1pceClKnGgrMwJHn+dSkasTlNPWTC90B7LAUwtoO
 j0JA==
X-Gm-Message-State: AOJu0YwWBaDSECoPOPeL9ReC3BP9BF/QW3oN2kRhrlQCqluxGo6PNmVC
 2gPI6Dx8cuts5hA128rOv2gjTGFyjl3NF9lO/gHysu3+SWxmBkW/VOEf2L5fNx3hYpcEQQ53cDV
 kLrSdZge2kq1sx7CuzaVgw0w96eC7JnvcT9AQrZHkIRpFZF/Z9jrWtLMCN//nAWJ4nS9bnIHR6L
 rOrAQSId1Lu7S1xEZYGv5j56yoGk4zYJKhD+dBHRQ=
X-Received: by 2002:a5d:6c6d:0:b0:37d:3280:203a with SMTP id
 ffacd0b85a97d-381f18270f9mr4623669f8f.10.1731137759855; 
 Fri, 08 Nov 2024 23:35:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1KBVODrFoFoXkpcQ0g1/KA7Rn7dtlgkCsBCCKrJwSu4yMBoVXJL0MR/G4T1lXOA+PQHfQUA==
X-Received: by 2002:a5d:6c6d:0:b0:37d:3280:203a with SMTP id
 ffacd0b85a97d-381f18270f9mr4623644f8f.10.1731137759396; 
 Fri, 08 Nov 2024 23:35:59 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea6b5sm7065063f8f.84.2024.11.08.23.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 23:35:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PULL v2 06/13] eif: cope with huge section sizes
Date: Sat,  9 Nov 2024 08:35:55 +0100
Message-ID: <20241109073555.162151-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241109073555.162151-1-pbonzini@redhat.com>
References: <20241109073555.162151-1-pbonzini@redhat.com>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/eif.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/hw/core/eif.c b/hw/core/eif.c
index 61329aacfe1..a7128b71cec 100644
--- a/hw/core/eif.c
+++ b/hw/core/eif.c
@@ -119,6 +119,10 @@ static bool read_eif_header(FILE *f, EifHeader *header, uint32_t *crc,
 
     for (int i = 0; i < MAX_SECTIONS; ++i) {
         header->section_sizes[i] = be64_to_cpu(header->section_sizes[i]);
+        if (header->section_sizes[i] > SSIZE_MAX) {
+            error_setg(errp, "Invalid EIF image. Section size out of bounds");
+            return false;
+        }
     }
 
     header->unused = be32_to_cpu(header->unused);
@@ -278,7 +282,12 @@ static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
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
@@ -320,7 +329,12 @@ static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
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
+            if (!*cmdline) {
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



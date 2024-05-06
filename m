Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F1BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9a-00074v-Ut; Mon, 06 May 2024 03:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9R-0006eH-0l
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9P-0001js-GU
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXL8u/WSR5nc+uR+16Rj/aOdLSI5R+KIVqaTq5s6rWg=;
 b=Z6VOMPKRfCjj3GlSte1IVNSwtkEw/MZdFotUhz2eBrvyddV7/f6l+toI8yX79m78BvNqmE
 56f9WF5Mk+8q6QgA6vvc6yOKVo6VKXx+zxHTAWbhUaF3Z3pbXShiTMOqrZW8C++835GZSj
 jqKN42GPXq8onFXliAyConFYiALpkwM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-RoqkaXvLOXy9WnaoCv2vUw-1; Mon, 06 May 2024 03:52:41 -0400
X-MC-Unique: RoqkaXvLOXy9WnaoCv2vUw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56c3dc8d331so625861a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981959; x=1715586759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXL8u/WSR5nc+uR+16Rj/aOdLSI5R+KIVqaTq5s6rWg=;
 b=ZMhsXgrcz0QCVPgqsNZsea1VdylH9MTZ40LxWZ5KphdOnmT3R+J1cTq6M2IkG/zei1
 zVb5knGupA7ydQ19V2JMCtjGLXEWvApZUBMB/XhQeZnB0o+UO5ZNfNh7FPUaQyFxt6qT
 7jkYvVbODOw+N8EkN43aWhiCBTnMj5/8tNw79ZZOMFwejwleoI7YNq+RVnjGlPYYYlDc
 v4v7eRASdGgXlZVNH9vouHnlWl9D/8yV2e84L7MdztNatMtn7oEmgaVxJZ5lDY8beBNt
 VEglEuJYE6GcdTsz3g7kM9WbFuhtDixi5Eph/D2VRV+ecMS6p2Mr32ncc125OSSdWTJf
 92Tg==
X-Gm-Message-State: AOJu0YxXaMyv95yUDVaLUHmbNKBMqytJi1AbtKvi6cnP86lp038oGPjd
 j17s6gGne3I5JlyGSNsZuJW7o1APcMFfpegT6nD2MYlQNkXPZotGfhRBei8eMxa82+gVN4qE5j1
 zNVU8zoSs95U+TGUqgLQR1XQCWHTSPBZbvokUw38sBj1G6+YP8JOMHpiMmqMOozqe0c+1VVFd5q
 3iVZUzyoXzv/7WzocjKbuU1r2f8pU0+XyBU+Gr
X-Received: by 2002:a50:f603:0:b0:56f:e609:743 with SMTP id
 c3-20020a50f603000000b0056fe6090743mr6411162edn.35.1714981959652; 
 Mon, 06 May 2024 00:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW7mNMPoufFYIMPya8+3wvyUjp23TPTuknlUZKaYSt3Dzg8dCqJS1KRWCY760t42Nr00ENzA==
X-Received: by 2002:a50:f603:0:b0:56f:e609:743 with SMTP id
 c3-20020a50f603000000b0056fe6090743mr6411150edn.35.1714981959285; 
 Mon, 06 May 2024 00:52:39 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 fj20-20020a0564022b9400b00572336c900asm4840451edb.74.2024.05.06.00.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Roman Kiryanov <rkir@google.com>,
 Daniel Berrange <berrange@redhat.com>
Subject: [PULL 29/46] bitmap: Use g_try_new0/g_new0/g_renew
Date: Mon,  6 May 2024 09:51:08 +0200
Message-ID: <20240506075125.8238-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Avoids an explicit use of sizeof().  The GLib allocation macros
ensure that the multiplication by the size of the element
uses the right type and does not overflow.

While at it, change bitmap_new() to use g_new0 directly.  Its current
impl of calling bitmap_try_new() followed by a plain abort() has
worse diagnostics than g_new0, which uses g_error to report the actual
allocation size that failed.

Cc: qemu-trivial@nongnu.org
Cc: Roman Kiryanov <rkir@google.com>
Reviewed-by: Daniel Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/bitmap.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 97806811eeb..1cf288445f3 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -92,17 +92,14 @@ long slow_bitmap_count_one(const unsigned long *bitmap, long nbits);
 
 static inline unsigned long *bitmap_try_new(long nbits)
 {
-    long len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-    return g_try_malloc0(len);
+    long nelem = BITS_TO_LONGS(nbits);
+    return g_try_new0(unsigned long, nelem);
 }
 
 static inline unsigned long *bitmap_new(long nbits)
 {
-    unsigned long *ptr = bitmap_try_new(nbits);
-    if (ptr == NULL) {
-        abort();
-    }
-    return ptr;
+    long nelem = BITS_TO_LONGS(nbits);
+    return g_new0(unsigned long, nelem);
 }
 
 static inline void bitmap_zero(unsigned long *dst, long nbits)
@@ -265,10 +262,10 @@ unsigned long bitmap_find_next_zero_area(unsigned long *map,
 static inline unsigned long *bitmap_zero_extend(unsigned long *old,
                                                 long old_nbits, long new_nbits)
 {
-    long new_len = BITS_TO_LONGS(new_nbits) * sizeof(unsigned long);
-    unsigned long *new = g_realloc(old, new_len);
-    bitmap_clear(new, old_nbits, new_nbits - old_nbits);
-    return new;
+    long new_nelem = BITS_TO_LONGS(new_nbits);
+    unsigned long *ptr = g_renew(unsigned long, old, new_nelem);
+    bitmap_clear(ptr, old_nbits, new_nbits - old_nbits);
+    return ptr;
 }
 
 void bitmap_to_le(unsigned long *dst, const unsigned long *src,
-- 
2.44.0



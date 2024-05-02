Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D917C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YGo-0001Ft-D4; Thu, 02 May 2024 11:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2YGn-0001Fc-KM
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2YGm-0004uQ-1t
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714663366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nf2rzIkR+FaL/rs+/EeFo6/nss3sW8O16iG5/mhIl3A=;
 b=BFfpcuaE2IwDzueR91sTGx+nm6zsY/nCG7LAiB87LC5iMsXs8Eyxs2In04mqedkpHwnmvi
 MCzSrOQ3pPjLKCMune9RlUhPPPRBG38k5bW6sOHXcaMUhcTRqcD3Hxp1XIW2asAV930eoC
 r4CT1ARyLQdFlEZILhwSzuITNitbuZw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-V_GMpb7tNZGpMPGdWuXHzg-1; Thu, 02 May 2024 11:22:45 -0400
X-MC-Unique: V_GMpb7tNZGpMPGdWuXHzg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a5190b1453fso535612266b.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714663364; x=1715268164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nf2rzIkR+FaL/rs+/EeFo6/nss3sW8O16iG5/mhIl3A=;
 b=TWBaQJDkphQUlPNMjRhMrmNxdfuHE8JTSBkmM/5j+655Uw4VtxiNsX0C1AAyO0dfhX
 PGxxp7OhWq6XRi5FeFC2ywmyKl4+0tzrWEu8cv8Fntdy5gOGZLCi+MkDkwLLz8hV03/O
 LoxMswKQnCdChGikywX6a+OhhrP0TVa3mPIjtlQh2GyDj7F/AB30gJh214v5hEyXuOrq
 TVFyV2SyojJKOVEay0qyrxeqH/fduxihINVgZaTWL9EP0oCyD51WcF0RsQTU6xKDKi2x
 gFY62cn41VfBqUKo+sG3X7CbIOgU6AAyc4bqSi7JjP3QimNcbt1ZpR0EC3MVIhu6YKv6
 l/cA==
X-Gm-Message-State: AOJu0YzabowvCZRhIDc/9t2/UKcOD+P6Jd2scjQ2dShMmSBaW/6TllhB
 VSD/fbsJEhl8/23lVilr1mYnXikchptYbEMJShAqeXhMGXP5KmCobrnmqAGbYIa03xXSRd0aMIC
 8ePyeazLvU2BoGvzEGK+h7PjGwpoRkyF5bZWrjPLLsmt+ypUvLBMHi0DG/DLxhRDEBhsoGFREM7
 BBwzi8QDaFrwDW2wZNy6aDm849djDlFQEnZiOh
X-Received: by 2002:a17:906:2ad2:b0:a52:6fcb:564a with SMTP id
 m18-20020a1709062ad200b00a526fcb564amr3848947eje.9.1714663364091; 
 Thu, 02 May 2024 08:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFOwVxoLUnKbi2kbsFsMq0YgXnwuUQWhXBSV0+eHaOOwTRjCQ370wGAVv89gefF1D5pyZb+A==
X-Received: by 2002:a17:906:2ad2:b0:a52:6fcb:564a with SMTP id
 m18-20020a1709062ad200b00a526fcb564amr3848934eje.9.1714663363599; 
 Thu, 02 May 2024 08:22:43 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a170906408500b00a53c746b499sm665937ejj.137.2024.05.02.08.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:22:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Roman Kiryanov <rkir@google.com>,
 Daniel Berrange <berrange@redhat.com>
Subject: [PATCH v2] bitmap: Use g_try_new0/g_renew
Date: Thu,  2 May 2024 17:22:42 +0200
Message-ID: <20240502152242.101181-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Avoids an explicit use of sizeof().  The GLib allocation macros
ensure that the multiplication by the size of the element
uses the right type and does not overflow.

While at it, change bitmap_new() to use g_new0 directly.  Its current
impl of calling bitmap_try_new() followed by a plain abort() has
worse diagnostics than g_new0, which uses g_error to report the actual
allocation size that failed.

Cc: qemu-trivial@nongnu.org
Cc: Roman Kiryanov <rkir@google.com>
Cc: Daniel Berrange <berrange@redhat.com>
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



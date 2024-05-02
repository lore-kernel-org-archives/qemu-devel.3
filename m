Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E66DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 14:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2XLL-0005Qs-IL; Thu, 02 May 2024 10:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2XLK-0005Qj-8U
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2XLI-0000Si-R1
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714659803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B2npMCPC3kw1vod5yhIIQEQeXn1drBrxUNH/LbqaxFA=;
 b=cPvWKbHQzzwT9+KvVkQirxTwV7lYbe6nj5N5AI/3TK3w26kXRxLUDOHe9Om9iw+kiIjqJS
 URwkBWMf2x1QGnTtvrQ/dqLl27Qv1I8iK1sVQP+Vu3c/RYA5fkBgfVgGXI4PovT3f/IDu9
 bhx7HeJyaXP2GaoZ5qWth0e9blakDiM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-6bkYm8DiMyym2nLtmL3yNg-1; Thu, 02 May 2024 10:23:20 -0400
X-MC-Unique: 6bkYm8DiMyym2nLtmL3yNg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a598111be0fso1712966b.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 07:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714659799; x=1715264599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B2npMCPC3kw1vod5yhIIQEQeXn1drBrxUNH/LbqaxFA=;
 b=uEfLdy2vp/NLIZBIus+SToRIU4eAbiatZ6GuOTnlKlgV9m5IZ6MYF9vtZRqEn0gT40
 YWSMDj0kfl3a0XwoMT9e9alEw2sBdin7h7E+81+piMBxXXhZksfKH3RAjPSgdF3wqnfu
 bFNt2Jo7TCWLSb/VnJxOTHR9rQBfpeMC8GH025I+6bCRr73dg1OUpqMtjAR2MFZ+nZ6L
 GxrzmS+LMQRB7SxEg6T5Ut7jBMoWcyFmEtimUb8tXBhvsZvJ1EZAULGOk/ZBwzPsX4ER
 htmOaCXA/rIOhCT+2D4df9sh4CqBJ5NnHNUi2VP9liSsDLCG1nK+gvRI9wv3PFghGyVS
 JS5g==
X-Gm-Message-State: AOJu0Yxbwqjqs7AW/uYQhQBNQQB/TdfYcMnyFB1ANxDCvGRQH5Rmol9p
 GfNa97p2yxYr8oPHvTSXBRMo267wQfd84WqPkfPn/dn5jyJ63iND1RsoF1bEdtuk7ro+o1dOpUU
 /C9QJkI14xhIIPmYzfHFbW1SV0ws5uYYFExAfFgKOJoH8hWIQ9c3v2U7QZCTGOI1LUVUd4UIA95
 vHei09PtpVCvDVP7u2Hc/5oe+Oh4lw0Hf+pdAg
X-Received: by 2002:a17:906:7c50:b0:a55:b2da:3e92 with SMTP id
 g16-20020a1709067c5000b00a55b2da3e92mr1755685ejp.68.1714659798753; 
 Thu, 02 May 2024 07:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGURnWOGjReh1DsJYEXi1hQjcfjokkHtgdL93hhIAU+jZ2Xi8TsR31tsf9wPM0w0knjQdv76Q==
X-Received: by 2002:a17:906:7c50:b0:a55:b2da:3e92 with SMTP id
 g16-20020a1709067c5000b00a55b2da3e92mr1755666ejp.68.1714659798314; 
 Thu, 02 May 2024 07:23:18 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 fx24-20020a170906b75800b00a5910978816sm605835ejb.121.2024.05.02.07.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 07:23:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Roman Kiryanov <rkir@google.com>,
 Daniel Berrange <berrange@redhat.com>
Subject: [PATCH] bitmap: Use g_try_new0/g_renew
Date: Thu,  2 May 2024 16:23:16 +0200
Message-ID: <20240502142316.44012-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Cc: qemu-trivial@nongnu.org
Cc: Roman Kiryanov <rkir@google.com>
Cc: Daniel Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/bitmap.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
index 97806811eeb..c4363b1d324 100644
--- a/include/qemu/bitmap.h
+++ b/include/qemu/bitmap.h
@@ -92,8 +92,8 @@ long slow_bitmap_count_one(const unsigned long *bitmap, long nbits);
 
 static inline unsigned long *bitmap_try_new(long nbits)
 {
-    long len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-    return g_try_malloc0(len);
+    long nelem = BITS_TO_LONGS(nbits);
+    return g_try_new0(unsigned long, nelem);
 }
 
 static inline unsigned long *bitmap_new(long nbits)
@@ -265,10 +265,10 @@ unsigned long bitmap_find_next_zero_area(unsigned long *map,
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CF4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOnU-0002ho-AX; Tue, 23 Apr 2024 18:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmo-0001fF-Gc
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmm-0006FS-Bh
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBH9vlRDE9s8yf0Yn2wt5fnZ4BiZFAP+66WnLwkh6uM=;
 b=YqGi6kRzwaTs65fxmm4a/nPvG+r8ERhCf5zyQCBg5VImBdvGB995wdJPG0aUmpMzZYhby+
 jcQXX2x3Pmvmi29rFHneXHuLk9s0Y1co2DybNydT3xfQUxwCQZVz9XKMvm+rUb1ZIR48yN
 zHbtYRM7yflgqiY16nnnojzWrS7EYoE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-yH6EaSlSOIuNryvGXkM_Nw-1; Tue, 23 Apr 2024 18:38:46 -0400
X-MC-Unique: yH6EaSlSOIuNryvGXkM_Nw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a01116b273so18947896d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911925; x=1714516725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBH9vlRDE9s8yf0Yn2wt5fnZ4BiZFAP+66WnLwkh6uM=;
 b=HXJEbvtSZLeLJdNQUVxVaWGmpoLJ+uAksd13n0cpTpcBBWeOg4CLVUCA6bwiUkxwA9
 IWkOENo0ntGQMfczt5M3b6G3fmuAvgF8C2zSsndtXtK/B/0W3U0GnYWydK9bZ1OdYHKz
 MzLrK6lqxFBHX1CTAG4T0u0WvliuQRTkqQSs+c7QYrHueM+72La3XFSzVkZxqEv2Aspr
 8Wq0BqqcGfigmlinID08k4njDi8h++C/dr4RhFekG11ssOgFej566uh1OD32DqxLbAst
 +4EmrDJcnJJ5ToXtVU37fTB5tzXlEVhIGW0xr8N8VcspPvkSFil6Ff1gj/GX5homxX4d
 lnqA==
X-Gm-Message-State: AOJu0Yxk/uWHYkygheFLuPxYepPYnv71kDwqcPL4UWkEdo29Bz/QmjKa
 gqsl1o8Vn7++IjFjDXWasQ96Ak6/ns64zwLOVM97NC2rWQVptDSnCFFCc+kqEvwMWNnqP51gYxE
 tATDc6vDJEQ4DA3v7wsikPFEnJS4nSAhYzXhJeebuwyDuCke6fYfQQusrmvRvFnca3bXSBi0ivq
 QoskdMeX5oP7vmeCHCHpHhcN/ha55xbsab0g==
X-Received: by 2002:a05:620a:4723:b0:790:8734:1d0b with SMTP id
 bs35-20020a05620a472300b0079087341d0bmr992764qkb.4.1713911925356; 
 Tue, 23 Apr 2024 15:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBqQslsiE9hNp962eZWJ5FVJBhEAQDWWuGn9sBSMzftlH15RZPSy6avahVqNCMAufGZOjNag==
X-Received: by 2002:a05:620a:4723:b0:790:8734:1d0b with SMTP id
 bs35-20020a05620a472300b0079087341d0bmr992729qkb.4.1713911924463; 
 Tue, 23 Apr 2024 15:38:44 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Yuan Liu <yuan1.liu@intel.com>
Subject: [PULL 25/26] migration/multifd: solve zero page causing multiple page
 faults
Date: Tue, 23 Apr 2024 18:38:12 -0400
Message-ID: <20240423223813.3237060-26-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

From: Yuan Liu <yuan1.liu@intel.com>

Implemented recvbitmap tracking of received pages in multifd.

If the zero page appears for the first time in the recvbitmap, this
page is not checked and set.

If the zero page has already appeared in the recvbitmap, there is no
need to check the data but directly set the data to 0, because it is
unlikely that the zero page will be migrated multiple times.

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240401154110.2028453-2-yuan1.liu@intel.com
[peterx: touch up the comment, as the bitmap is used outside postcopy now]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/ramblock.h       | 2 +-
 migration/ram.h               | 1 +
 migration/multifd-zero-page.c | 4 +++-
 migration/multifd-zlib.c      | 1 +
 migration/multifd-zstd.c      | 1 +
 migration/multifd.c           | 1 +
 migration/ram.c               | 4 ++++
 7 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 848915ea5b..7062da380b 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -57,7 +57,7 @@ struct RAMBlock {
     off_t bitmap_offset;
     uint64_t pages_offset;
 
-    /* bitmap of already received pages in postcopy */
+    /* Bitmap of already received pages.  Only used on destination side. */
     unsigned long *receivedmap;
 
     /*
diff --git a/migration/ram.h b/migration/ram.h
index 08feecaf51..bc0318b834 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -69,6 +69,7 @@ int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
 bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
 void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
+void ramblock_recv_bitmap_set_offset(RAMBlock *rb, uint64_t byte_offset);
 int64_t ramblock_recv_bitmap_send(QEMUFile *file,
                                   const char *block_name);
 bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index 1ba38be636..e1b8370f88 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -80,8 +80,10 @@ void multifd_recv_zero_page_process(MultiFDRecvParams *p)
 {
     for (int i = 0; i < p->zero_num; i++) {
         void *page = p->host + p->zero[i];
-        if (!buffer_is_zero(page, p->page_size)) {
+        if (ramblock_recv_bitmap_test_byte_offset(p->block, p->zero[i])) {
             memset(page, 0, p->page_size);
+        } else {
+            ramblock_recv_bitmap_set_offset(p->block, p->zero[i]);
         }
     }
 }
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 99821cd4d5..737a9645d2 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -284,6 +284,7 @@ static int zlib_recv(MultiFDRecvParams *p, Error **errp)
         int flush = Z_NO_FLUSH;
         unsigned long start = zs->total_out;
 
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
         if (i == p->normal_num - 1) {
             flush = Z_SYNC_FLUSH;
         }
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 02112255ad..256858df0a 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -278,6 +278,7 @@ static int zstd_recv(MultiFDRecvParams *p, Error **errp)
     z->in.pos = 0;
 
     for (i = 0; i < p->normal_num; i++) {
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
         z->out.dst = p->host + p->normal[i];
         z->out.size = p->page_size;
         z->out.pos = 0;
diff --git a/migration/multifd.c b/migration/multifd.c
index 2802afe79d..f317bff077 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -277,6 +277,7 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
     for (int i = 0; i < p->normal_num; i++) {
         p->iov[i].iov_base = p->host + p->normal[i];
         p->iov[i].iov_len = p->page_size;
+        ramblock_recv_bitmap_set_offset(p->block, p->normal[i]);
     }
     return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
 }
diff --git a/migration/ram.c b/migration/ram.c
index daffcd82d4..a975c5af16 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -275,6 +275,10 @@ void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr,
                       nr);
 }
 
+void ramblock_recv_bitmap_set_offset(RAMBlock *rb, uint64_t byte_offset)
+{
+    set_bit_atomic(byte_offset >> TARGET_PAGE_BITS, rb->receivedmap);
+}
 #define  RAMBLOCK_RECV_BITMAP_ENDING  (0x0123456789abcdefULL)
 
 /*
-- 
2.44.0



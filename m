Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225C2C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtT1-0007zr-72; Fri, 02 May 2025 12:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSi-0007ni-Hs
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSg-0006Uc-9m
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KYwm/MwdS+WEwVvT8ZltgPHE/zV2f/JvznZHRlv4PP4=;
 b=e3eg6NkQX/CaiOhbJYxTLCngggpkmoSPRt2wuALZbt+xxHFEIMvFED+gGCMsjKAxkc1FnR
 psv2zEHbn4gmBtFFu2VRZunXlrHnzYY7bvdsBXjkxRgKthp+kJ/tPhvVGJiknjAY10045s
 +t1jA4PqUTHFS9zXpZouOlm9jw+Y7wc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-HasCnh74ODWniGYQq9V_uw-1; Fri, 02 May 2025 12:42:04 -0400
X-MC-Unique: HasCnh74ODWniGYQq9V_uw-1
X-Mimecast-MFC-AGG-ID: HasCnh74ODWniGYQq9V_uw_1746204124
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c3c8f8ab79so342609885a.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204123; x=1746808923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYwm/MwdS+WEwVvT8ZltgPHE/zV2f/JvznZHRlv4PP4=;
 b=A3N5SqwXXpU+pxestO0aw9+0LuWrF2gqUPwIw48YwZw62jgCAXa+daxfrTTL/x8fPd
 R+uldKQX6ayFC+skkEBvZj46zzcRy6cexIfL5E8itIog7WPTGW5KvYNq25LVCHJdnjbT
 zycCGnW3+Fj+txJ6a72qof1ef8n6W6XtWl658jzXQ6F+AADW5xyCfoep8R1b9BOPKFD1
 HC9JCx8F+So00uB3Xspc2Ucr3qxZutlwvxRtoCymOGCKmzVZmw55VMIvpF7IdmQDFLfz
 CW9zKhjSeg/hTEHMFGLWzMsWPtB1VKRpTnNcZze8he3I9pI2j6vJB4606iTIQlwTzMq/
 akHg==
X-Gm-Message-State: AOJu0YxWuz6SEwBgdEYS5VOcZQSitZXmo6jN6OQyseHjSWs77JivzxXd
 rGdaQ4TwgSoUcT4t0N12qkE5pmDAukxMNYHo6CkAlAERImwOOkK8Qk92x4fU2XFCs9QjH930ZOk
 5K2c65hmshxi1Thbswzo2+2MwHpHKtvV6zkbzEbslK09g1F67NO22hxvibTy8TLMyUoLKak6smB
 GeKWPyKC8m6WnBCyReILyZ0OIWq/7630OCQg==
X-Gm-Gg: ASbGncvJOjn7Z13ma1611NdgozEmOVRn+9X7qvSr0LRoyx2+sQ46bRrJhLFnsZ2wa5C
 Xe6UAk0RyzO0wCi5FkTMlXTM6SxYtK9S5c1Rs9xOHsGiP8kRg/1GR1Tf2TBRM3Nq3dIGApkhGIQ
 MPwjcRNM7kvWUDVNaau8r4NQeEMpIOUdZ1cqFYba575+uS5xUQeWaPA0npPOOREqNeqsHJ4YiPd
 7CU008h2cYXdNJc6WTx1VF9i75FDo2vqTjnv6lHpPqOBmMOsXlDtzCTuIIIfgptMIMaciJt4/5v
X-Received: by 2002:a05:620a:19a6:b0:7c7:93ae:fe56 with SMTP id
 af79cd13be357-7cad5bc0a1dmr500726785a.51.1746204122792; 
 Fri, 02 May 2025 09:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiu3LgihU8stdZhmxLqzpzMm0DhsIEMmRTHTRV76IeMlKh5vLc6WWhd1F6obUdpJnvnw7LVA==
X-Received: by 2002:a05:620a:19a6:b0:7c7:93ae:fe56 with SMTP id
 af79cd13be357-7cad5bc0a1dmr500721985a.51.1746204122154; 
 Fri, 02 May 2025 09:42:02 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:42:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Xiaohui Li <xiaohli@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 12/14] migration/postcopy: Spatial locality page hint for
 preempt mode
Date: Fri,  2 May 2025 12:41:39 -0400
Message-ID: <20250502164141.747202-13-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

The preempt mode postcopy has been introduced for a while.  From latency
POV, it should always win the vanilla postcopy.

However there's one thing missing when preempt mode is enabled right now,
which is the spatial locality hint when there're page requests from the
destination side.

In vanilla postcopy, as long as a page request was unqueued, it will update
the PSS of the precopy background stream, so that after a page request the
background thread will move the pages after whatever was requested.  It's
pretty much a natural behavior when there's only one channel anyway, and
one scanner to send the pages.

Preempt mode didn't follow that, because preempt mode has its own channel
and its own PSS (which doesn't linearly scan the guest memory, but
dedicated to resolve page requested from destination).  So the page request
process and the background migration process are completely separate.

This patch adds the hint explicitly for preempt mode.  With that, whenever
the preempt mode receives a page request on the source, it will service the
remote page fault in the return path, then it'll provide a hint to the
background thread so that we'll start sending the pages right after the
requested ones in the background, assuming the follow up pages have a
higher chance to be accessed later.

NOTE: since the background migration thread and return path thread run
completely concurrently, it doesn't always mean the hint will be applied
every single time.  For example, it's possible that the return path thread
receives multiple page requests in a row without the background thread
getting the chance to consume one.  In such case, the preempt thread only
provide the hint if the previous hint has been consumed.  After all,
there's no point queuing hints when we only have one linear scanner.

This could measureably improve the simple sequential memory access pattern
during postcopy (when preempt is on).  For random accesses, I can measure a
slight increase of remote page fault latency from ~500us -> ~600us, that
could be a trade-off to have such hint mechanism, and after all that's
still greatly improved comparing to vanilla postcopy on random (~10ms).

The patch is verified by our QE team in a video streaming test case, to
reduce the pause of the video from ~1min to a few seconds when switching
over to postcopy with preempt mode.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Tested-by: Xiaohui Li <xiaohli@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250424220705.195544-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index a749e4a421..e12913b43e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -91,6 +91,36 @@
 
 XBZRLECacheStats xbzrle_counters;
 
+/*
+ * This structure locates a specific location of a guest page.  In QEMU,
+ * it's described in a tuple of (ramblock, offset).
+ */
+struct PageLocation {
+    RAMBlock *block;
+    unsigned long offset;
+};
+typedef struct PageLocation PageLocation;
+
+/**
+ * PageLocationHint: describes a hint to a page location
+ *
+ * @valid     set if the hint is vaild and to be consumed
+ * @location: the hint content
+ *
+ * In postcopy preempt mode, the urgent channel may provide hints to the
+ * background channel, so that QEMU source can try to migrate whatever is
+ * right after the requested urgent pages.
+ *
+ * This is based on the assumption that the VM (already running on the
+ * destination side) tends to access the memory with spatial locality.
+ * This is also the default behavior of vanilla postcopy (preempt off).
+ */
+struct PageLocationHint {
+    bool valid;
+    PageLocation location;
+};
+typedef struct PageLocationHint PageLocationHint;
+
 /* used by the search for pages to send */
 struct PageSearchStatus {
     /* The migration channel used for a specific host page */
@@ -395,6 +425,13 @@ struct RAMState {
      * RAM migration.
      */
     unsigned int postcopy_bmap_sync_requested;
+    /*
+     * Page hint during postcopy when preempt mode is on.  Return path
+     * thread sets it, while background migration thread consumes it.
+     *
+     * Protected by @bitmap_mutex.
+     */
+    PageLocationHint page_hint;
 };
 typedef struct RAMState RAMState;
 
@@ -2019,6 +2056,21 @@ static void pss_host_page_finish(PageSearchStatus *pss)
     pss->host_page_start = pss->host_page_end = 0;
 }
 
+static void ram_page_hint_update(RAMState *rs, PageSearchStatus *pss)
+{
+    PageLocationHint *hint = &rs->page_hint;
+
+    /* If there's a pending hint not consumed, don't bother */
+    if (hint->valid) {
+        return;
+    }
+
+    /* Provide a hint to the background stream otherwise */
+    hint->location.block = pss->block;
+    hint->location.offset = pss->page;
+    hint->valid = true;
+}
+
 /*
  * Send an urgent host page specified by `pss'.  Need to be called with
  * bitmap_mutex held.
@@ -2064,6 +2116,7 @@ out:
     /* For urgent requests, flush immediately if sent */
     if (sent) {
         qemu_fflush(pss->pss_channel);
+        ram_page_hint_update(rs, pss);
     }
     return ret;
 }
@@ -2151,6 +2204,30 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
     return (res < 0 ? res : pages);
 }
 
+static bool ram_page_hint_valid(RAMState *rs)
+{
+    /* There's only page hint during postcopy preempt mode */
+    if (!postcopy_preempt_active()) {
+        return false;
+    }
+
+    return rs->page_hint.valid;
+}
+
+static void ram_page_hint_collect(RAMState *rs, RAMBlock **block,
+                                  unsigned long *page)
+{
+    PageLocationHint *hint = &rs->page_hint;
+
+    assert(hint->valid);
+
+    *block = hint->location.block;
+    *page = hint->location.offset;
+
+    /* Mark the hint consumed */
+    hint->valid = false;
+}
+
 /**
  * ram_find_and_save_block: finds a dirty page and sends it to f
  *
@@ -2167,6 +2244,8 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
 static int ram_find_and_save_block(RAMState *rs)
 {
     PageSearchStatus *pss = &rs->pss[RAM_CHANNEL_PRECOPY];
+    unsigned long next_page;
+    RAMBlock *next_block;
     int pages = 0;
 
     /* No dirty page as there is zero RAM */
@@ -2186,7 +2265,14 @@ static int ram_find_and_save_block(RAMState *rs)
         rs->last_page = 0;
     }
 
-    pss_init(pss, rs->last_seen_block, rs->last_page);
+    if (ram_page_hint_valid(rs)) {
+        ram_page_hint_collect(rs, &next_block, &next_page);
+    } else {
+        next_block = rs->last_seen_block;
+        next_page = rs->last_page;
+    }
+
+    pss_init(pss, next_block, next_page);
 
     while (true){
         if (!get_queued_page(rs, pss)) {
@@ -2319,6 +2405,13 @@ static void ram_save_cleanup(void *opaque)
     ram_state_cleanup(rsp);
 }
 
+static void ram_page_hint_reset(PageLocationHint *hint)
+{
+    hint->location.block = NULL;
+    hint->location.offset = 0;
+    hint->valid = false;
+}
+
 static void ram_state_reset(RAMState *rs)
 {
     int i;
@@ -2331,6 +2424,8 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page = 0;
     rs->last_version = ram_list.version;
     rs->xbzrle_started = false;
+
+    ram_page_hint_reset(&rs->page_hint);
 }
 
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
-- 
2.48.1



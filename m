Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B49C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOoT-00056Y-N1; Tue, 23 Apr 2024 18:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmh-0001UH-NI
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmf-00069x-IA
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bW78RG1Xz7Qwrxw7nsNV5JYMn8yoAE/WnG0eLZpmsvY=;
 b=aAJqyktIhdoILLamLtbWqoCMhzrShXJmdDwnuwvsa+D8FN8zeoym7VpcuSRmKiw+2UlyMy
 InTbA02mjXhtSemmE5O6st4krPTZInBboYt7dxoevfhWC71xes0+tzK6l+gxk0A2loyQ99
 9AuTOwoGcg/ltyASwt43Eo6gjcu2Xyc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-0S_EEoYlOGGXcGg-hbrxBg-1; Tue, 23 Apr 2024 18:38:39 -0400
X-MC-Unique: 0S_EEoYlOGGXcGg-hbrxBg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-69b37bbded3so17221556d6.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911919; x=1714516719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bW78RG1Xz7Qwrxw7nsNV5JYMn8yoAE/WnG0eLZpmsvY=;
 b=Dgu4JmTnYoDARF2mA5vVPd03XoKS9vywkncV69O8Cd6EPRlNFXOJO838Fdw4UvrtVj
 epTzyndA7pSnADH1Gqxrkwwmv7MQ2KJpw72PwEXkq1mUnPBVuTfoAsmOCe7DbV6laj9r
 o546wI+fbxjLaKTyuYI5EM9cwx0McW45wvmNt+eSTwQX2YW7J7yK0JNU9hRcu6kB1eLd
 JcUTsxpDG7m6qoCd5uj0aFTsv81dQ0LZhBA1WNA1ARu5PNtuJQOJMRpukfFfbBjesMYh
 v071teyWJdl1K+vC6xdEbG1bOMXzVFz7S5ZlnhtWKm7HziU8wNP+gzsivKowX+y/cTRT
 Dw+w==
X-Gm-Message-State: AOJu0Yxk85sOxAx6m0bDsobr4o2BtkyM6MAyVLKHXTEj8ZRScwWOf0Zb
 eucvzb/VAPBKYIO9ZJK5Zqx1LHlRXnotqFtu9zIXoykDy4HTL5TG8MVrpoTwmX+8ht37zGwVi8R
 /yed8Ith+Q0Fp0kM61K2i/oghFV17ajVCFNP+NlvvvTMG7YGB0MAWvAqvNrzOu8WWzz1dgAshta
 ZLvY7fDFrFb3u4Xf/9tpgRWgMf5OjTY0FkqA==
X-Received: by 2002:a05:620a:468b:b0:790:862a:75c with SMTP id
 bq11-20020a05620a468b00b00790862a075cmr1024746qkb.1.1713911918555; 
 Tue, 23 Apr 2024 15:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIBiIs0ShpZGitBOoZo0bQf//OkollaYfQioYIFAylC7RkpLuPbtBR+vJuz/xNyo9LasHwbA==
X-Received: by 2002:a05:620a:468b:b0:790:862a:75c with SMTP id
 bq11-20020a05620a468b00b00790862a075cmr1024718qkb.1.1713911917896; 
 Tue, 23 Apr 2024 15:38:37 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 18/26] memory: Add Error** argument to .log_global_start()
 handler
Date: Tue, 23 Apr 2024 18:38:05 -0400
Message-ID: <20240423223813.3237060-19-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Cédric Le Goater <clg@redhat.com>

Modify all .log_global_start() handlers to take an Error** parameter
and return a bool. Adapt memory_global_dirty_log_start() to interrupt
on the first error the loop on handlers. In such case, a rollback is
performed to stop dirty logging on all listeners where it was
previously enabled.

Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240320064911.545001-10-clg@redhat.com
[peterx: modify & enrich the comment for listener_add_address_space() ]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h |  5 ++++-
 hw/i386/xen/xen-hvm.c |  3 ++-
 hw/vfio/common.c      |  4 +++-
 hw/virtio/vhost.c     |  3 ++-
 system/memory.c       | 41 +++++++++++++++++++++++++++++++++++++++--
 5 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8626a355b3..5555567bc4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -998,8 +998,11 @@ struct MemoryListener {
      * active at that time.
      *
      * @listener: The #MemoryListener.
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Return: true on success, else false setting @errp with error.
      */
-    void (*log_global_start)(MemoryListener *listener);
+    bool (*log_global_start)(MemoryListener *listener, Error **errp);
 
     /**
      * @log_global_stop:
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 7745cb3963..f6e9a1bc86 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -457,11 +457,12 @@ static void xen_log_sync(MemoryListener *listener, MemoryRegionSection *section)
                           int128_get64(section->size));
 }
 
-static void xen_log_global_start(MemoryListener *listener)
+static bool xen_log_global_start(MemoryListener *listener, Error **errp)
 {
     if (xen_enabled()) {
         xen_in_migration = true;
     }
+    return true;
 }
 
 static void xen_log_global_stop(MemoryListener *listener)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 011ceaab89..8f9cbdc026 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1066,7 +1066,8 @@ out:
     return ret;
 }
 
-static void vfio_listener_log_global_start(MemoryListener *listener)
+static bool vfio_listener_log_global_start(MemoryListener *listener,
+                                           Error **errp)
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
@@ -1083,6 +1084,7 @@ static void vfio_listener_log_global_start(MemoryListener *listener)
                      ret, strerror(-ret));
         vfio_set_migration_error(ret);
     }
+    return !ret;
 }
 
 static void vfio_listener_log_global_stop(MemoryListener *listener)
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f50180e60e..4acd77e890 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1044,7 +1044,7 @@ check_dev_state:
     return r;
 }
 
-static void vhost_log_global_start(MemoryListener *listener)
+static bool vhost_log_global_start(MemoryListener *listener, Error **errp)
 {
     int r;
 
@@ -1052,6 +1052,7 @@ static void vhost_log_global_start(MemoryListener *listener)
     if (r < 0) {
         abort();
     }
+    return true;
 }
 
 static void vhost_log_global_stop(MemoryListener *listener)
diff --git a/system/memory.c b/system/memory.c
index a229a79988..86d6c33180 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2914,9 +2914,33 @@ static unsigned int postponed_stop_flags;
 static VMChangeStateEntry *vmstate_change;
 static void memory_global_dirty_log_stop_postponed_run(void);
 
+static bool memory_global_dirty_log_do_start(Error **errp)
+{
+    MemoryListener *listener;
+
+    QTAILQ_FOREACH(listener, &memory_listeners, link) {
+        if (listener->log_global_start) {
+            if (!listener->log_global_start(listener, errp)) {
+                goto err;
+            }
+        }
+    }
+    return true;
+
+err:
+    while ((listener = QTAILQ_PREV(listener, link)) != NULL) {
+        if (listener->log_global_stop) {
+            listener->log_global_stop(listener);
+        }
+    }
+
+    return false;
+}
+
 void memory_global_dirty_log_start(unsigned int flags)
 {
     unsigned int old_flags;
+    Error *local_err = NULL;
 
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
 
@@ -2936,7 +2960,13 @@ void memory_global_dirty_log_start(unsigned int flags)
     trace_global_dirty_changed(global_dirty_tracking);
 
     if (!old_flags) {
-        MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
+        if (!memory_global_dirty_log_do_start(&local_err)) {
+            global_dirty_tracking &= ~flags;
+            trace_global_dirty_changed(global_dirty_tracking);
+            error_report_err(local_err);
+            return;
+        }
+
         memory_region_transaction_begin();
         memory_region_update_pending = true;
         memory_region_transaction_commit();
@@ -3014,8 +3044,15 @@ static void listener_add_address_space(MemoryListener *listener,
         listener->begin(listener);
     }
     if (global_dirty_tracking) {
+        /*
+         * Currently only VFIO can fail log_global_start(), and it's not
+         * yet allowed to hotplug any PCI device during migration. So this
+         * should never fail when invoked, guard it with error_abort.  If
+         * it can start to fail in the future, we need to be able to fail
+         * the whole listener_add_address_space() and its callers.
+         */
         if (listener->log_global_start) {
-            listener->log_global_start(listener);
+            listener->log_global_start(listener, &error_abort);
         }
     }
 
-- 
2.44.0



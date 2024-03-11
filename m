Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358A8C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 22:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjngO-0000HS-NE; Mon, 11 Mar 2024 17:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngN-0000Ff-Cm
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjngL-0003ys-0Q
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710194380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTOPAhre4/h24RN4Ps85iFFxvGXIdSpDYg+k8LNyGXk=;
 b=U+5vpQoKq48hJjvd5FGscmUda9+68N7eNuu9ukIF+nKe6W+Q42L3bF3oSRSqDVZ1ZeeCfx
 uL0bWJx3hYmyHU5ZTuCuqkyMFvSzgT4FE7QUN3XWNGCnZhKldggww0kNNML7B0HAFNOXRE
 haP/8sdofKDM64d1QhrIEvYmjnpBQy8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-xPre58MTM_OvzebphgXQwQ-1; Mon, 11 Mar 2024 17:59:38 -0400
X-MC-Unique: xPre58MTM_OvzebphgXQwQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6818b8cb840so15026776d6.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 14:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710194377; x=1710799177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTOPAhre4/h24RN4Ps85iFFxvGXIdSpDYg+k8LNyGXk=;
 b=UrrLcWbCTWJcQ0lJwxkS/xK7lYZureGvOHmlnaba7d4oyZ2MgoUaovHx3/tylDnkvb
 E/uU+qpYc4xoN9+61hW/63sQr5iFx1nPdjm0xHTX7F3pn2xD8YuUupu2ZVxAQnvVRb5X
 nQjpkPlYegFErJyceoiabIblXpKcS/AI8mvLoOAJ+Y6cLSvnQ8ZKCCKd3tEWNs5WiPIL
 yyI+iB0NBlFvC4bWyBt7tY8tyP0tZTzv/3WTq6OkdSldK2QgQCp9ndS7A6AfUEnyhEpE
 8x14vqes9RGfshEj5tAf0Apu5ZsUZUSvNSjPxQBMr4cttJhRiHtJa8pyCc//R4B4Z+TQ
 6Nlw==
X-Gm-Message-State: AOJu0YyjK1dBf/fr+v5g/7fNkDA67LH7SBBWYFrx/MDEAfVW2FpHDXEL
 pjQJBMu+j+HtsxsIMYWVCMIhtii7AyJwWl5xn8xUNvMQDbKvgMCcfm8JeV3BesBu/+ievNtpxZA
 jjuMJZyqu/6Cwm0Y3SYRm870bBD+QaxA7kBMg8oPZK881kgLiO3aNwOoP0ljjbQqCpHuXFmoDo2
 7GYioPeQ8QQYxbZRVr3zIyHvBjL+ZBq48zvQ==
X-Received: by 2002:a05:6214:4c11:b0:690:de72:316f with SMTP id
 qh17-20020a0562144c1100b00690de72316fmr1714606qvb.1.1710194377360; 
 Mon, 11 Mar 2024 14:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNtB+2W+/wSVwhrhyjB3itKHPIe5bq0bZXHHJoYBcnKpKOrnoRH9xtHqEjdLSrC2mbDmJcTA==
X-Received: by 2002:a05:6214:4c11:b0:690:de72:316f with SMTP id
 qh17-20020a0562144c1100b00690de72316fmr1714580qvb.1.1710194376873; 
 Mon, 11 Mar 2024 14:59:36 -0700 (PDT)
Received: from x1n.. (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d6-20020a0ce446000000b00690cec16254sm1541932qvm.68.2024.03.11.14.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 14:59:36 -0700 (PDT)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/34] migration: Add documentation for SaveVMHandlers
Date: Mon, 11 Mar 2024 17:58:58 -0400
Message-ID: <20240311215925.40618-8-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311215925.40618-1-peterx@redhat.com>
References: <20240311215925.40618-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The SaveVMHandlers structure is still in use for complex subsystems
and devices. Document the handlers since we are going to modify a few
later.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240304122844.1888308-9-clg@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h | 263 +++++++++++++++++++++++++++++++----
 1 file changed, 237 insertions(+), 26 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 2e6a7d766e..d7b70a8be6 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -16,30 +16,130 @@
 
 #include "hw/vmstate-if.h"
 
+/**
+ * struct SaveVMHandlers: handler structure to finely control
+ * migration of complex subsystems and devices, such as RAM, block and
+ * VFIO.
+ */
 typedef struct SaveVMHandlers {
-    /* This runs inside the BQL.  */
+
+    /* The following handlers run inside the BQL. */
+
+    /**
+     * @save_state
+     *
+     * Saves state section on the source using the latest state format
+     * version.
+     *
+     * Legacy method. Should be deprecated when all users are ported
+     * to VMStateDescription.
+     *
+     * @f: QEMUFile where to send the data
+     * @opaque: data pointer passed to register_savevm_live()
+     */
     void (*save_state)(QEMUFile *f, void *opaque);
 
-    /*
-     * save_prepare is called early, even before migration starts, and can be
-     * used to perform early checks.
+    /**
+     * @save_prepare
+     *
+     * Called early, even before migration starts, and can be used to
+     * perform early checks.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns zero to indicate success and negative for error
      */
     int (*save_prepare)(void *opaque, Error **errp);
+
+    /**
+     * @save_setup
+     *
+     * Initializes the data structures on the source and transmits
+     * first section containing information on the device
+     *
+     * @f: QEMUFile where to send the data
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*save_setup)(QEMUFile *f, void *opaque);
+
+    /**
+     * @save_cleanup
+     *
+     * Uninitializes the data structures on the source
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     */
     void (*save_cleanup)(void *opaque);
+
+    /**
+     * @save_live_complete_postcopy
+     *
+     * Called at the end of postcopy for all postcopyable devices.
+     *
+     * @f: QEMUFile where to send the data
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
+
+    /**
+     * @save_live_complete_precopy
+     *
+     * Transmits the last section for the device containing any
+     * remaining data at the end of a precopy phase. When postcopy is
+     * enabled, devices that support postcopy will skip this step,
+     * where the final data will be flushed at the end of postcopy via
+     * @save_live_complete_postcopy instead.
+     *
+     * @f: QEMUFile where to send the data
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
 
     /* This runs both outside and inside the BQL.  */
+
+    /**
+     * @is_active
+     *
+     * Will skip a state section if not active
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns true if state section is active else false
+     */
     bool (*is_active)(void *opaque);
+
+    /**
+     * @has_postcopy
+     *
+     * Checks if a device supports postcopy
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns true for postcopy support else false
+     */
     bool (*has_postcopy)(void *opaque);
 
-    /* is_active_iterate
-     * If it is not NULL then qemu_savevm_state_iterate will skip iteration if
-     * it returns false. For example, it is needed for only-postcopy-states,
-     * which needs to be handled by qemu_savevm_state_setup and
-     * qemu_savevm_state_pending, but do not need iterations until not in
-     * postcopy stage.
+    /**
+     * @is_active_iterate
+     *
+     * As #SaveVMHandlers.is_active(), will skip an inactive state
+     * section in qemu_savevm_state_iterate.
+     *
+     * For example, it is needed for only-postcopy-states, which needs
+     * to be handled by qemu_savevm_state_setup() and
+     * qemu_savevm_state_pending(), but do not need iterations until
+     * not in postcopy stage.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns true if state section is active else false
      */
     bool (*is_active_iterate)(void *opaque);
 
@@ -48,44 +148,155 @@ typedef struct SaveVMHandlers {
      * use data that is local to the migration thread or protected
      * by other locks.
      */
+
+    /**
+     * @save_live_iterate
+     *
+     * Should send a chunk of data until the point that stream
+     * bandwidth limits tell it to stop. Each call generates one
+     * section.
+     *
+     * @f: QEMUFile where to send the data
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns 0 to indicate that there is still more data to send,
+     *         1 that there is no more data to send and
+     *         negative to indicate an error.
+     */
     int (*save_live_iterate)(QEMUFile *f, void *opaque);
 
     /* This runs outside the BQL!  */
-    /* Note for save_live_pending:
-     * must_precopy:
-     * - must be migrated in precopy or in stopped state
-     * - i.e. must be migrated before target start
-     *
-     * can_postcopy:
-     * - can migrate in postcopy or in stopped state
-     * - i.e. can migrate after target start
-     * - some can also be migrated during precopy (RAM)
-     * - some must be migrated after source stops (block-dirty-bitmap)
-     *
-     * Sum of can_postcopy and must_postcopy is the whole amount of
+
+    /**
+     * @state_pending_estimate
+     *
+     * This estimates the remaining data to transfer
+     *
+     * Sum of @can_postcopy and @must_postcopy is the whole amount of
      * pending data.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @must_precopy: amount of data that must be migrated in precopy
+     *                or in stopped state, i.e. that must be migrated
+     *                before target start.
+     * @can_postcopy: amount of data that can be migrated in postcopy
+     *                or in stopped state, i.e. after target start.
+     *                Some can also be migrated during precopy (RAM).
+     *                Some must be migrated after source stops
+     *                (block-dirty-bitmap)
      */
-    /* This estimates the remaining data to transfer */
     void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
                                    uint64_t *can_postcopy);
-    /* This calculate the exact remaining data to transfer */
+
+    /**
+     * @state_pending_exact
+     *
+     * This calculates the exact remaining data to transfer
+     *
+     * Sum of @can_postcopy and @must_postcopy is the whole amount of
+     * pending data.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @must_precopy: amount of data that must be migrated in precopy
+     *                or in stopped state, i.e. that must be migrated
+     *                before target start.
+     * @can_postcopy: amount of data that can be migrated in postcopy
+     *                or in stopped state, i.e. after target start.
+     *                Some can also be migrated during precopy (RAM).
+     *                Some must be migrated after source stops
+     *                (block-dirty-bitmap)
+     */
     void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
                                 uint64_t *can_postcopy);
+
+    /**
+     * @load_state
+     *
+     * Load sections generated by any of the save functions that
+     * generate sections.
+     *
+     * Legacy method. Should be deprecated when all users are ported
+     * to VMStateDescription.
+     *
+     * @f: QEMUFile where to receive the data
+     * @opaque: data pointer passed to register_savevm_live()
+     * @version_id: the maximum version_id supported
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*load_state)(QEMUFile *f, void *opaque, int version_id);
+
+    /**
+     * @load_setup
+     *
+     * Initializes the data structures on the destination.
+     *
+     * @f: QEMUFile where to receive the data
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*load_setup)(QEMUFile *f, void *opaque);
+
+    /**
+     * @load_cleanup
+     *
+     * Uninitializes the data structures on the destination.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*load_cleanup)(void *opaque);
-    /* Called when postcopy migration wants to resume from failure */
+
+    /**
+     * @resume_prepare
+     *
+     * Called when postcopy migration wants to resume from failure
+     *
+     * @s: Current migration state
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*resume_prepare)(MigrationState *s, void *opaque);
-    /* Checks if switchover ack should be used. Called only in dest */
+
+    /**
+     * @switchover_ack_needed
+     *
+     * Checks if switchover ack should be used. Called only on
+     * destination.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns true if switchover ack should be used and false
+     * otherwise
+     */
     bool (*switchover_ack_needed)(void *opaque);
 } SaveVMHandlers;
 
+/**
+ * register_savevm_live: Register a set of custom migration handlers
+ *
+ * @idstr: state section identifier
+ * @instance_id: instance id
+ * @version_id: version id supported
+ * @ops: SaveVMHandlers structure
+ * @opaque: data pointer passed to SaveVMHandlers handlers
+ */
 int register_savevm_live(const char *idstr,
                          uint32_t instance_id,
                          int version_id,
                          const SaveVMHandlers *ops,
                          void *opaque);
 
+/**
+ * unregister_savevm: Unregister custom migration handlers
+ *
+ * @obj: object associated with state section
+ * @idstr:  state section identifier
+ * @opaque: data pointer passed to register_savevm_live()
+ */
 void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque);
 
 #endif
-- 
2.44.0



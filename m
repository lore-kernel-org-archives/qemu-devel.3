Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A93C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqW9a-0000Zc-A6; Fri, 07 Mar 2025 06:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tqW8w-0000Yb-DO
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:45:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tqW8u-00066f-Hu
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741347923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+Kjv6mjehz9lKtHsEbTuTDcdCsrBkDSSdcbIZCifCQ=;
 b=hxe3pYcoR+e3m5Fn4bfR4QJqK+gKteGHo1l1oYTDOCHfitJufy3bmfY7IGMjqyTFasiXxO
 J2HB9JL9u4Bcz6bzciv1E53I92wl70FYL0njZUftqqjNFM+rWjSxiLOfybNiSoCdhCwNLq
 NdRO7Mg60x2pFvLhpbwEuPM6j5YCKWc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-sLPQPY-WOlesZ76lbdwg-g-1; Fri, 07 Mar 2025 06:45:21 -0500
X-MC-Unique: sLPQPY-WOlesZ76lbdwg-g-1
X-Mimecast-MFC-AGG-ID: sLPQPY-WOlesZ76lbdwg-g_1741347920
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so8030145e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 03:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741347920; x=1741952720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8+Kjv6mjehz9lKtHsEbTuTDcdCsrBkDSSdcbIZCifCQ=;
 b=Crlz1AzCQyYdyY92NDl9p0naK+eFkOtbGOpsT5V8ns5uNk3hLnWykIEzWO3XpF4tI6
 G8+zUFTW8DSBzM9LBcYzeqtX2wwIjLySdVptkCZkA/AGvCfXJZfXzv5iqHFOiFQhyYSL
 idWRSV8sn/XvUj3xX3XK0waJ+dD26z9HX9b8YrVcah3tKHm30lxGd6z0o69wa4iiTtjb
 OzbYc2qPPtX+39pQVz/nAxjIq7sIPvp8Z2m/B1vDZ221bDw0PDUnwf5t/VUskF0Xjl44
 /saGZnZHy5JgO/j/NmLoI7/p6wXhKDEPn/UjtlheKXPirziu215PO1LZ2+i4zvWc1Xhd
 SBiw==
X-Gm-Message-State: AOJu0Yx92imzeehubCqj5ZjgI/DP4EoU3i8Bb1IgAIxNXyC4TdClRsl2
 Tke9DO2/mS27mdlIsekKcmwOYI1Kph1FGvX8o4x7kzAIe8b68ionC3hQzWK+cwPAEpxQUZB3zvZ
 rdjI8iiN7bPtr0epCcqwHRCrBmQDpnIM/HTjiY6Uh7uQoeVkvE97poyzmvM0B8mRwknBeMX7FIw
 wiTUoG9uS2VsB6GjbEpJZXkxYrTRQ=
X-Gm-Gg: ASbGncs8P/nCgAyex5/N6NQQ18teR6FxGv2Ueptfum7aQF6wzGSW7nDH+ODHnUrGvyH
 EZNU0PqOxQFzOq95Ad0GRQROkFPhOaTAkRW/bztbxmjqKtjSmF37L1UKWzEqH5rigdPGKu9UDcM
 o=
X-Received: by 2002:a05:600c:5248:b0:43b:d0fe:b8e5 with SMTP id
 5b1f17b1804b1-43c686f4f88mr17264785e9.25.1741347920336; 
 Fri, 07 Mar 2025 03:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2/d83QMVWcRghfcmPQNqFj9dBwAJgS7SqkI0f/NWjb7W6cl1HkvnUa0R1wHCrI7o9S0+v0tkGxBWzthdpmQc=
X-Received: by 2002:a05:600c:5248:b0:43b:d0fe:b8e5 with SMTP id
 5b1f17b1804b1-43c686f4f88mr17264665e9.25.1741347919992; Fri, 07 Mar 2025
 03:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
In-Reply-To: <Z8hJeneeuKqD1i8Q@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 7 Mar 2025 17:15:03 +0530
X-Gm-Features: AQ5f1JqS1guYOQFRqLJV7q2nnhtUJpbcXH3qVP9cBpNixwuov-nkwaMeecIvUzg
Message-ID: <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Peter,

On Wed, 5 Mar 2025 at 18:24, Peter Xu <peterx@redhat.com> wrote:
> > On Tue, 4 Mar 2025 at 20:05, Peter Xu <peterx@redhat.com> wrote:
> > > I think we need the header, the ram is a module.
> > > Do similarly like qemu_savevm_state_complete_precopy_iterable() but do
> > > whatever a vmstate hander wants, so it'll be with a header.
> >
===
diff --git a/migration/migration.c b/migration/migration.c
index 65fc4f5eed..da2c49c303 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3401,9 +3401,10 @@ static MigIterateState
migration_iteration_run(MigrationState *s)
     if (!in_postcopy && must_precopy <= s->threshold_size
         && can_switchover && qatomic_read(&s->start_postcopy)) {
         if (migrate_multifd()) {
-            multifd_send_flush();
-            multifd_send_sync_main(MULTIFD_SYNC_LOCAL);
-            qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
+/*          multifd_send_flush();
+ *          multifd_send_sync_main(MULTIFD_SYNC_ALL);
+ *          qemu_savevm_send_multifd_recv_sync(s->to_dst_file);
+ */
+            qemu_savevm_state_complete_multifd(s->to_dst_file);
             multifd_send_shutdown();
         }
         if (postcopy_start(s, &local_err)) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 0b71e988ba..c2b181b0cc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1602,6 +1602,37 @@ int qemu_savevm_state_complete_precopy(QEMUFile
*f, bool iterable_only)
     return qemu_fflush(f);
 }

+int qemu_savevm_state_complete_multifd(QEMUFile *f)
+{
+    int ret;
+    SaveStateEntry *se;
+    int64_t start_ts_each, end_ts_each;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (strcmp(se->idstr, "ram")) {
+            continue;
+        }
+
+        start_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+        trace_savevm_section_start(se->idstr, se->section_id);
+
+        save_section_header(f, se, QEMU_VM_SECTION_END);
+
+        ret = se->ops->save_live_complete_precopy(f, se->opaque);
+        trace_savevm_section_end(se->idstr, se->section_id, ret);
+        save_section_footer(f, se);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            return -1;
+        }
+        end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
+        trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
+                                    end_ts_each - start_ts_each);
+    }
+
+    return ret;
+}
+
 /* Give an estimate of the amount left to be transferred,
  * the result is split into the amount for units that can and
  * for units that can't do postcopy.
diff --git a/migration/savevm.h b/migration/savevm.h
index 91ae703925..e3789984a1 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -70,5 +70,6 @@ int qemu_load_device_state(QEMUFile *f);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);
+int qemu_savevm_state_complete_multifd(QEMUFile *f);

 #endif
====

63/63 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
     OK             164.02s   79 subtests passed
63/63 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
     OK             164.99s   79 subtests passed
====

* Does the above patch look okay?

====
Guest not dirtying RAM:
===================
2025-03-07 10:57:28.740+0000: initiating migration
2025-03-07T10:57:28.823166Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07T10:58:04.450758Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07T10:58:04.711523Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07 10:58:05.078+0000: shutting down, reason=migrated

2025-03-07 10:59:44.322+0000: initiating migration
2025-03-07T10:59:44.394714Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07T11:00:20.198360Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07T11:00:20.279135Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07 11:00:20.571+0000: shutting down, reason=migrated
====

Guest dirtying RAM: $ dd if=/dev/urandom of=/tmp/random.bin bs=256M count=32 ...
================
2025-03-07 11:04:00.281+0000: initiating migration
2025-03-07T11:04:00.359426Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07T11:05:51.406988Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07T11:06:56.899920Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07 11:08:02.376+0000: shutting down, reason=migrated

2025-03-07 11:09:19.295+0000: initiating migration
2025-03-07T11:09:19.372012Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07T11:11:24.217610Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07T11:12:35.342709Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called
2025-03-07 11:13:48.947+0000: shutting down, reason=migrated
====

* When a guest is running some workload (dirtying memory), it seems to
take a little more time before switching to the Postcopy phase.

> Let me know if you want me to write the patches.  That's almost the only
> thing left to make it clearer..

* If the above patch is not okay,  it'll help if you share your
version of it. Meanwhile I'll split the patch-2 and re-arrange other
patches.

Thank you.
---
  - Prasad



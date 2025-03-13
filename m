Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4A1C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 12:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tshv3-00033B-Mn; Thu, 13 Mar 2025 08:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tshun-0002zw-Fp
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tshuf-0003iE-N1
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 08:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741869824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSDRGVvx59w/O9YYetfpLvIOuEgN5r6R34YojX8WGW0=;
 b=B4dyZptMBxbAn4xudDq7Gww+zuBlC3wuAJi7/1UGgZ1L4FfIR1dt7/s/ne+LiilHxjz7Vw
 SorzWcwDMz9wYoYertl2U38UG8h6GuRs9PEbWzcCgNfruXw7jxitx6SqswP5gwmM4XmlZc
 2lML69wgj0PPIAKP7d6RyulIsA20Pe0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-4A0CMc84P0qzNyl073LI-g-1; Thu, 13 Mar 2025 08:43:43 -0400
X-MC-Unique: 4A0CMc84P0qzNyl073LI-g-1
X-Mimecast-MFC-AGG-ID: 4A0CMc84P0qzNyl073LI-g_1741869822
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso4705805e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 05:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741869822; x=1742474622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YSDRGVvx59w/O9YYetfpLvIOuEgN5r6R34YojX8WGW0=;
 b=A2GPpOXXwqhJ4pdSqy4sW0/i1H31w+a8O0lQ8VRM8J9V3WgDqtQ0IWZIbl28zcWrAN
 +EQm2NbUfl76y0mNHjtPN6oZUQbuRB7O4RaN2yNO/u1vgA4SjbpoHDVrz/FFENS0uetL
 f1QYIHuxJTdaslHYdkQsvf+1/hSJpoD/ykDTTM55iPSIaOhA8sUQ6Y1PhvWL/+1u2gRv
 FLWaE/D/n+fbB7g/SgCbf+A0VmyKn5SnPB/5y78OUGMx+lywzdxGSwQTYIoEprHt8XqD
 NtLVHbYAbQHbx2nIV7QLrk9bBhHY+I5lwD893ZEDsdk332zItDQM8E1CzJd9hP1Ghk+A
 V+GQ==
X-Gm-Message-State: AOJu0Yzn9CJ1hiDPEI0WcKhbQ15eGWL3FBE5EOvLVHujx6aEyQD/8NGc
 bds4hv3QZwQ3wyxEOj/vplvvFTTkeLTg2Eza+27X0l9Q0Hi4TN1XmCeIQnt75+kvwb7LwGqTRq+
 6VjfdL29jBAAUlTP4y4Rxsm37kIZCxWtzbe3RCpzL9mcy/hRdiE+mjw2OwR16nvVZC28hVIHuMb
 nUTFPnoo3kS7gBw03SceztWWvOB2c=
X-Gm-Gg: ASbGncvEIkl6R7KWvtcdE1IzNCdGS9+HjY891/dLsFs3dzuPLGpjdVOQFW5bTDsoQgj
 WQ2fkHcR3taAa/O+zbgeKQz/NGQt0yfKTVFa6JoPvlcm1mENXN0GcWV28CLMFfScQj8CDiW4Xpw
 c=
X-Received: by 2002:a7b:ca4c:0:b0:43c:eb00:50eb with SMTP id
 5b1f17b1804b1-43ceb0054a9mr179481865e9.5.1741869821877; 
 Thu, 13 Mar 2025 05:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbeoBJ50XoHjLz6bQzvk1LTxZErM+9ALHYl4AUSNkzo4YbXByCtVJwNB/4RmSPEIlpu6UlQX4gN7CzSOBYg0Q=
X-Received: by 2002:a7b:ca4c:0:b0:43c:eb00:50eb with SMTP id
 5b1f17b1804b1-43ceb0054a9mr179481645e9.5.1741869821541; Thu, 13 Mar 2025
 05:43:41 -0700 (PDT)
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
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
 <Z8t3uKo54T_Xls_O@x1.local>
In-Reply-To: <Z8t3uKo54T_Xls_O@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 13 Mar 2025 18:13:24 +0530
X-Gm-Features: AQ5f1JoVV3VhiTX2i3B2X_Y3Pbjcr3TGRIbSor8ILKKJQG9fUA6m_V12GyTg8Q4
Message-ID: <CAE8KmOwdLk4oZg8TAt0z6rd27f0MpbSS54TWNDshZFU7WPxk-Q@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat, 8 Mar 2025 at 04:18, Peter Xu <peterx@redhat.com> wrote:
> [1]
> Please move all of them at the entry of postcopy_start().
> I still like the name I provided because it's more generic, above [1].
> Maybe it should be SECTION_PART.   So we provide all iterator a chance to
> do something right before switching to postcopy but before VM stop.  RAM
> can register.
> Maybe we don't want to run the whole iteration but only flush.  I think for
> simplicity we can make a new hook.
> We do not need to account
> Please see above, if that doesn't help you come up with a final version,
> I'll write it.

===
diff --git a/migration/migration.c b/migration/migration.c
index f97bb2777f..9ef8e8ee1d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2700,6 +2700,10 @@ static int postcopy_start(MigrationState *ms,
Error **errp)
     QIOChannelBuffer *bioc;
     QEMUFile *fb;

+    if (migrate_multifd()) {
+        qemu_savevm_state_postcopy_prepare(ms->to_dst_file);
+    }
+
     /*
      * Now we're 100% sure to switch to postcopy, so JSON writer won't be
      * useful anymore.  Free the resources early if it is there.  Clearing

diff --git a/migration/ram.c b/migration/ram.c
index 6fd88cbf2a..13a8c63660 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1143,6 +1143,15 @@ static int save_zero_page(RAMState *rs,
PageSearchStatus *pss,
     return len;
 }

+int ram_save_zero_page(QEMUFile *f, void *opaque)
+{
+    RAMState *rs = *(RAMState **)opaque;
+    PageSearchStatus *pss = &rs->pss[RAM_CHANNEL_PRECOPY];
+    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
+
+    return save_zero_page(rs, pss, offset);
+}
+
 /*
  * @pages: the number of pages written by the control path,
  *        < 0 - error
diff --git a/migration/ram.h b/migration/ram.h
index 921c39a2c5..425c9ad9fd 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -122,4 +122,5 @@ void ram_write_tracking_prepare(void);
 int ram_write_tracking_start(void);
 void ram_write_tracking_stop(void);

+int ram_save_zero_page(QEMUFile *f, void *opaque);
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index ce158c3512..9bb0f03942 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1676,6 +1676,36 @@ int qemu_savevm_state_complete_precopy(QEMUFile
*f, bool iterable_only)
     return qemu_fflush(f);
 }

+int qemu_savevm_state_postcopy_prepare(QEMUFile *f)
+{
+    int ret = 0;
+    SaveStateEntry *se;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (strcmp(se->idstr, "ram")) {
+            continue;
+        }
+
+        save_section_header(f, se, QEMU_VM_SECTION_PART);
+
+        ram_save_zero_page(f, se->opaque);
+        if ((ret = multifd_ram_flush_and_sync(f)) < 0) {
+            return ret;
+        }
+        qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+
+        trace_savevm_section_end(se->idstr, se->section_id, ret);
+        save_section_footer(f, se);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            return -1;
+        }
+    }
+
+    return ret;
+}
+
+
 /* Give an estimate of the amount left to be transferred,
  * the result is split into the amount for units that can and
  * for units that can't do postcopy.
diff --git a/migration/savevm.h b/migration/savevm.h
index 138c39a7f9..7d4ff25ca3 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -74,4 +74,5 @@ int
qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
 bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
                                    char *buf, size_t len, Error **errp);

+int qemu_savevm_state_postcopy_prepare(QEMUFile *f);
 #endif
===

host-1] 63/63 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
             OK             139.87s   79 subtests passed
host-2] 63/63 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
             OK             137.52s   79 subtests passed

2025-03-13 12:11:01.653+0000: initiating migration
2025-03-13T12:11:01.690247Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called: 1, 0
2025-03-13T12:12:05.342194Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called: 1, 0
2025-03-13 12:12:54.688+0000: shutting down, reason=migrated

2025-03-13 12:21:10.967+0000: initiating migration
2025-03-13T12:21:10.994878Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called: 1, 0
2025-03-13T12:22:15.955266Z qemu-system-x86_64: info:
multifd_ram_flush_and_sync: called: 1, 0
2025-03-13 12:23:02.107+0000: shutting down, reason=migrated
===

* Does this patch look okay?

Thank you.
---
  - Prasad



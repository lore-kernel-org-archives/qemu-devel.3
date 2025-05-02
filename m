Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BE3C3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAtSz-0007wW-Aj; Fri, 02 May 2025 12:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSd-0007nG-Cr
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uAtSb-0006TO-Cq
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746204120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjUEY/w6aKXWMnaO1KafHdGD7uLuFBPM5WJk9qOv8BE=;
 b=K51Pkk1cXCX6Jg7z6UzAa7pameKrRle60Jhn1s3+SiNTX+8R8E0OSCp1/aQcflU4LxGeQj
 BEc8Ri7uYzYVtBFxTNDaaV23m+7a6zBc2BW8GS7JydJrTZS7/vWy9N37DPiI+/YXWspquX
 8D34FHHO5qQJwxX7PugKjrKysayuGnk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-_p-wMnkfO52IH9ZPJh368w-1; Fri, 02 May 2025 12:41:59 -0400
X-MC-Unique: _p-wMnkfO52IH9ZPJh368w-1
X-Mimecast-MFC-AGG-ID: _p-wMnkfO52IH9ZPJh368w_1746204119
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c793d573b2so293222685a.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204118; x=1746808918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjUEY/w6aKXWMnaO1KafHdGD7uLuFBPM5WJk9qOv8BE=;
 b=ZYpCC7dDJ73WL4KLW2+cCRz7+ceUZpiLrqxsd9fYgRP679LzQ6jiNS4fbvb69Z5J4q
 rpBx/wHxaw+nyAJm7UsZR13BojI8ILGthpQNgmsF01BJrW3FZTwr6Yz3ulE4VDMv6r91
 DtBKKkBACqR7xrsRcvRw2JkMa9xbDAjnWQWzCvCHF4pY1gHM5IzRVDuXpYqkivTB04Ru
 Wr17MkEqdapjpWb7zxdV2i0NZ7JAlEXzSGMZgINRdSRIl1GuTS8KTLbiLWDrq/QRAQsW
 S07x1P0S/vJCyjNT0opBrjdeigG+6Y56bRRnGcLU48SnykMoGTjgKmyA9b7Cs6a2Ti9t
 B/jw==
X-Gm-Message-State: AOJu0YymK+ClHDdS4JrULcZr3UVdQtonMkyv1VB2lfnaLbT7TZmwIMZt
 BZKN1GLbFId5+oNfrJilQ8e86WGkDp/ux1jnr7Jp05Rb+RooZKayUtAxgn2EY7ufISiB/qqpSNT
 zDKlYYNXQOMjzSVVFqaogQ7yEiPRlflZZ+1OZvhsnyFTMIC1dqD/LB7avHiRlEa/nhQFpuDXZwq
 Px5MSsAA1HheXswPAFqxVOvbFDHhBITGlWPw==
X-Gm-Gg: ASbGncs4cwMNMq5eMh8wQUqSoAAZNa2oHfF/pjOZe2kPLwfimk5XjkDsBb6lHEwZd9h
 C6eaZfK4aUXsztH50DdiDoqRx7ZXhrcO0zjbsMIGgVb2YfMwOtSPNA6nIqEhLNvOjDpMy+HmVOx
 xu2fZ1w39LZJVADC1LA4IptTmSfhwKhV2S2P9jy5BIWgw8xjnTw3lHASnNg1x5lIum32ze8F39D
 eUM7Kt240j5TsJknA+XNHqdyIsUb3jdaLMjMNLt2Wg4RfCibFpuQoqV3buF7DWch6Nqlg8XD423
X-Received: by 2002:a05:620a:800b:b0:7c5:e92a:cba3 with SMTP id
 af79cd13be357-7cad5bb47ccmr630869185a.49.1746204118581; 
 Fri, 02 May 2025 09:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqd1xypvE09vYjdZuoKFUbFo3gcCurOhzbT9FU4Mab/hK37fP4SBk3dAX3nsLyeDIMei3X3A==
X-Received: by 2002:a05:620a:800b:b0:7c5:e92a:cba3 with SMTP id
 af79cd13be357-7cad5bb47ccmr630863985a.49.1746204118056; 
 Fri, 02 May 2025 09:41:58 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cad23d1c8dsm203108385a.60.2025.05.02.09.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 09:41:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 peterx@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 09/14] migration: Add save_postcopy_prepare() savevm handler
Date: Fri,  2 May 2025 12:41:36 -0400
Message-ID: <20250502164141.747202-10-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502164141.747202-1-peterx@redhat.com>
References: <20250502164141.747202-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a savevm handler for a module to opt-in sending extra sections right
before postcopy starts, and before VM is stopped.

RAM will start to use this new savevm handler in the next patch to do flush
and sync for multifd pages.

Note that we choose to do it before VM stopped because the current only
potential user is not sensitive to VM status, so doing it before VM is
stopped is preferred to enlarge any postcopy downtime.

It is still a bit unfortunate that we need to introduce such a new savevm
handler just for the only use case, however it's so far the cleanest.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250411114534.3370816-4-ppandit@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/register.h | 15 +++++++++++++++
 migration/savevm.h           |  1 +
 migration/migration.c        |  4 ++++
 migration/savevm.c           | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index c041ce32f2..b79dc81b8d 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -189,6 +189,21 @@ typedef struct SaveVMHandlers {
 
     /* This runs outside the BQL!  */
 
+    /**
+     * @save_postcopy_prepare
+     *
+     * This hook will be invoked on the source side right before switching
+     * to postcopy (before VM stopped).
+     *
+     * @f:      QEMUFile where to send the data
+     * @opaque: Data pointer passed to register_savevm_live()
+     * @errp:   Error** used to report error message
+     *
+     * Returns: true if succeeded, false if error occured.  When false is
+     * returned, @errp must be set.
+     */
+    bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
+
     /**
      * @state_pending_estimate
      *
diff --git a/migration/savevm.h b/migration/savevm.h
index 138c39a7f9..2d5e9c7166 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -45,6 +45,7 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
                                         uint64_t *can_postcopy);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
+bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
diff --git a/migration/migration.c b/migration/migration.c
index f18cadcc5e..4697732bef 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2727,6 +2727,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         }
     }
 
+    if (!qemu_savevm_state_postcopy_prepare(ms->to_dst_file, errp)) {
+        return -1;
+    }
+
     trace_postcopy_start();
     bql_lock();
     trace_postcopy_start_set_run();
diff --git a/migration/savevm.c b/migration/savevm.c
index 0c12e373b4..006514c3e3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1523,6 +1523,39 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     qemu_fflush(f);
 }
 
+bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp)
+{
+    SaveStateEntry *se;
+    bool ret;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->save_postcopy_prepare) {
+            continue;
+        }
+
+        if (se->ops->is_active) {
+            if (!se->ops->is_active(se->opaque)) {
+                continue;
+            }
+        }
+
+        trace_savevm_section_start(se->idstr, se->section_id);
+
+        save_section_header(f, se, QEMU_VM_SECTION_PART);
+        ret = se->ops->save_postcopy_prepare(f, se->opaque, errp);
+        save_section_footer(f, se);
+
+        trace_savevm_section_end(se->idstr, se->section_id, ret);
+
+        if (!ret) {
+            assert(*errp);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
     int64_t start_ts_each, end_ts_each;
-- 
2.48.1



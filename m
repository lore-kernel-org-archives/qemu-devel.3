Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7E7D1D88D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 17:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0kyc-0005pB-D3; Tue, 15 Oct 2024 13:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1t0kyZ-0005j9-M2
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 13:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1t0kyX-0002LV-RM
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 13:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729011887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Jrb/0uMLqZHYTAHN4atajS/ryKUEyxy2luVY5BUsLJM=;
 b=H+pXJoSwKAE/EbQjrPDLIQ3HDZ6vmHKW2Zzl2GFa8xcBKUNKt8pkpNWoSzFoLFRonsCaP6
 mYrGZ8mzTFfhp4lgzVceXz4Vz2d9TbXjoX0ee5GwCs6W4FXEOg7swBQhuafbdiPxc2JbEa
 B6t31g96SqxPgMq8v6swqohN9T84+Wg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-VqodJGCIO52msR6t51_NEg-1; Tue, 15 Oct 2024 13:04:46 -0400
X-MC-Unique: VqodJGCIO52msR6t51_NEg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4311db0f3f1so29141405e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 10:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729011885; x=1729616685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jrb/0uMLqZHYTAHN4atajS/ryKUEyxy2luVY5BUsLJM=;
 b=GYAfkFxTw7JNb1oi+MOMWQAgiIu6pgdqdaQUfD0juYfZYaUpNeljXRVHzeqliaRP/F
 MblQ8d4wlnX06j+WnADCofoR9arwLff9j8CLjU9KkETpMgpr5y+Vf8jDhYEM32DGhL3K
 P9uTcSa82qt5Ot1IbkNO4mthdN8Xw/vFJikSV57NSO9yTFHo0baulAyf2sDAdyXwWnCD
 lKeTHLeTOma1Gu4TCVipS17KE3lVE4pCTfnv17WDn38gupDeIWJKFuHTkgEfg6Xq3Uni
 tCIq+36p+/uFmZ1zTnW71Qmu11RShYpgMHto4T9XEgG0tTx+5u1OMCarDkSZpX+mBJyw
 SFTQ==
X-Gm-Message-State: AOJu0Yw7NQaKoIb605n3KULIxon5ruMsUVchBb9Bb6YmqB0iQk/1WdLs
 06B6SJpW1yaIwFyIBkuxVgaROvne5x0DpAfLyfQcaPi1OgKK0zc55Y4baf8NpcSr5dzaa2SC6Wy
 eHG8X57nlE96lG1Ex8rlU74OzrMz+d0evwDohlEA8xjE9CFuD00O8JeyMdjpjkg4P6kaIqDTNid
 ETg4V0Y1NtfCfKOLWePZAj76MkJcbIQtVDVQ==
X-Received: by 2002:a05:600c:a0f:b0:42c:ac9f:b528 with SMTP id
 5b1f17b1804b1-4311df5c600mr124540615e9.35.1729011884601; 
 Tue, 15 Oct 2024 10:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHkMDNycAq4NmFnEjeuBGP2H5vlIYRAjHYhpXoY55UpBwB7/exCRvhSWWvhi8NfARkag16nQ==
X-Received: by 2002:a05:600c:a0f:b0:42c:ac9f:b528 with SMTP id
 5b1f17b1804b1-4311df5c600mr124540215e9.35.1729011884116; 
 Tue, 15 Oct 2024 10:04:44 -0700 (PDT)
Received: from localhost
 (p200300cfd7232e319b54c0c720fee73c.dip0.t-ipconnect.de.
 [2003:cf:d723:2e31:9b54:c0c7:20fe:e73c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56eab2sm23250825e9.26.2024.10.15.10.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 10:04:42 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-stable@nongnu.org
Subject: [PATCH v2] migration: Ensure vmstate_save() sets errp
Date: Tue, 15 Oct 2024 19:04:37 +0200
Message-ID: <20241015170437.310358-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

migration/savevm.c contains some calls to vmstate_save() that are
followed by migrate_set_error() if the integer return value indicates an
error.  migrate_set_error() requires that the `Error *` object passed to
it is set.  Therefore, vmstate_save() is assumed to always set *errp on
error.

Right now, that assumption is not met: vmstate_save_state_v() (called
internally by vmstate_save()) will not set *errp if
vmstate_subsection_save() or vmsd->post_save() fail.  Fix that by adding
an *errp parameter to vmstate_subsection_save(), and by generating a
generic error in case post_save() fails (as is already done for
pre_save()).

Without this patch, qemu will crash after vmstate_subsection_save() or
post_save() have failed inside of a vmstate_save() call (unless
migrate_set_error() then happen to discard the new error because
s->error is already set).  This happens e.g. when receiving the state
from a virtio-fs back-end (virtiofsd) fails.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
v2: As suggested by Peter, after vmsd->post_save(), change the condition
    from `if (!ret)` to `if (!ret && ps_ret)` so we will not create an
    error object in case of success (that would then be leaked, most
    likely).
---
 migration/vmstate.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index ff5d589a6d..fa002b24e8 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -22,7 +22,8 @@
 #include "trace.h"
 
 static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, JSONWriter *vmdesc);
+                                   void *opaque, JSONWriter *vmdesc,
+                                   Error **errp);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque);
 
@@ -441,12 +442,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         json_writer_end_array(vmdesc);
     }
 
-    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc);
+    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
     if (vmsd->post_save) {
         int ps_ret = vmsd->post_save(opaque);
-        if (!ret) {
+        if (!ret && ps_ret) {
             ret = ps_ret;
+            error_setg(errp, "post-save failed: %s", vmsd->name);
         }
     }
     return ret;
@@ -518,7 +520,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
 }
 
 static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, JSONWriter *vmdesc)
+                                   void *opaque, JSONWriter *vmdesc,
+                                   Error **errp)
 {
     const VMStateDescription * const *sub = vmsd->subsections;
     bool vmdesc_has_subsections = false;
@@ -546,7 +549,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc);
+            ret = vmstate_save_state_with_err(f, vmsdsub, opaque, vmdesc, errp);
             if (ret) {
                 return ret;
             }
-- 
2.45.2



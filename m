Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADC4D216AC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iMI-0005Go-A7; Tue, 15 Oct 2024 10:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1t0iMH-0005GW-AQ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1t0iMF-0003Gy-LE
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lVTn/CTTmMGzPRNZmr1gqbTCZpVpsZcI+grphSKu7/c=;
 b=C+wdYqRggfK+2VYpdcO4BsPZMynO6oJZJWnf9l75AB3sl9kiSWk9HyG6EwoJKW0484rWoH
 GFlvS5+i+g7Sp0iExk+qw9+noUGPiZnosX+ypjgmSD7uzOP7WwINsaj+vus56vc2UM+8LI
 IRNDnSVgQWktnuK7e9MPhGD7pgePsAs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-dVW-YZMpPOm-RHYghjBvng-1; Tue, 15 Oct 2024 10:15:59 -0400
X-MC-Unique: dVW-YZMpPOm-RHYghjBvng-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4312b53256cso17595685e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001757; x=1729606557;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lVTn/CTTmMGzPRNZmr1gqbTCZpVpsZcI+grphSKu7/c=;
 b=YDaZcDDE7Ecu9WHGqvO74VZzwDu7T4HbHGwpZfToWT6PZ/wDLucVqs3JUwL4LUbB4y
 zxIayg7IeagiWuU4PBapNLaxlZ+8OzSBN7cto79wacY6l2mYbgI2PGp4Le8rBHPl3tRj
 uvRvC4kwrbOg4zNZ9fZ64uL4UeLqrZ8EdOSY3HsXm8zQCOg7xTGHMacF9hsqg6UUDqTV
 akiBejZquT8KB1qMVUMab5o93RLUn1O1lKniisMQrrpnU4k8BUl5asrwC9npPuM8XGzx
 rQl50rcBDw9MHdOcXSBP7+zcwTUifWZsOLEh8vBoUye5vUGwzQnRrVsJb/vjFu1HWrrA
 qmAg==
X-Gm-Message-State: AOJu0YyLbSzT1HZxO/1zcBaYNF4YshdWEatIsTCR+htmg033hGxb3RAa
 AIgTKoivLKGLPq6R6I2xOZgliiYNNX9vQJUdeAgCLdXGnaKA8vD6IaX2aLdMfesFZj1323ASbEC
 KwVPHp4TzD6zmPz22MzGBVc38tiP61M3bXT5W1mJsFCp6UmQL+xYE9nfSpcSTRwSCS5NCdW8AB3
 0XD09Gs79iD8fJLoe6VB09DQmQmzJAXLOLGg==
X-Received: by 2002:a05:600c:384c:b0:42c:c1f6:6ded with SMTP id
 5b1f17b1804b1-4311df55df7mr132158275e9.29.1729001757128; 
 Tue, 15 Oct 2024 07:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpkSsxegbMDhcBgNyC3l5hMY5bH8s19KnXe5RzFtVXScAI3uhopVNgYojShbSEFic6+yZIeA==
X-Received: by 2002:a05:600c:384c:b0:42c:c1f6:6ded with SMTP id
 5b1f17b1804b1-4311df55df7mr132157935e9.29.1729001756654; 
 Tue, 15 Oct 2024 07:15:56 -0700 (PDT)
Received: from localhost
 (p200300cfd7232e319b54c0c720fee73c.dip0.t-ipconnect.de.
 [2003:cf:d723:2e31:9b54:c0c7:20fe:e73c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f55dfa8sm19636305e9.6.2024.10.15.07.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:15:55 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-stable@nongnu.org
Subject: [PATCH] migration: Ensure vmstate_save() sets errp
Date: Tue, 15 Oct 2024 16:15:15 +0200
Message-ID: <20241015141515.150754-1-hreitz@redhat.com>
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
 migration/vmstate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index ff5d589a6d..13532f2807 100644
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
         if (!ret) {
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



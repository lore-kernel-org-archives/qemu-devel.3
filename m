Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D516D5B86D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B4v-0003XA-Q1; Wed, 30 Oct 2024 11:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4t-0003WI-6J
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B4r-0007lL-Df
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLmfXxT/DLKKNW5bJqVMU68mP3Y9rc7URGbbAHO3xiw=;
 b=XHh6A3BgcpGpjOG9zCU2YO5Qnjr6FReMSecwhpbnkTqCc+wep+lp5xFvfypyusvsgQ/hZv
 T76m4CrR8t2Tf73n0y0KR43B28rrgtAPYI0WiccW9aLSO9aKyux2p4Iv8lnBq6HxB7mJkZ
 xbHCzhFmqJujV2mDDmGofa4MJdrUItY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-daP6YJLGPoS1nr4zShGGbw-1; Wed, 30 Oct 2024 11:57:43 -0400
X-MC-Unique: daP6YJLGPoS1nr4zShGGbw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbe933e877so166076d6.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303862; x=1730908662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLmfXxT/DLKKNW5bJqVMU68mP3Y9rc7URGbbAHO3xiw=;
 b=Pc/xCueM5uNw0Q/iHb+oh0BmCO3BKVt7SJEPzLvuEZS1X96/QvZP/dJHzhwvpqXAZx
 LGwMvPkgK49suxUP7SrxXyVnGqaAdYZi/vmFWW8M9bsMKx9QU9qgr6IOk4H6s1L7mSGD
 aISSPGhdbIdKiKVHjf+U295A1xqukf39RkT5gMY7NfIb6fxQDXp5/W3lyoGss8hkorQW
 24clm/JR1leyH6WQAwcZYGjn7//FpP0JJuniri0qoyhoWkNHZkU0k8AWekBuO/5Q4eCL
 JSoL+DJIHOHBm8vV796s0V2Mn4aH7lYVoh78cfXSqPnH/vb0Ne6/6FQc/tlNs8F5k5iR
 uCbA==
X-Gm-Message-State: AOJu0Yxs+KpKI90j+ruAebhzSLaic4++D1EJ4seytMQu0AzjzcTWVZUQ
 zTgCNto1jVNJjXaxHsSCzUxvlrVU4kzZCXRdftKFFawhQM4cMKTqrP/g14ojaedTnTropUsySjv
 WLmqTBk/KmAF9iGlOnWG2B070SPVwO22PpC/5ouvjpUZjayeHJd6WncmHDMCEhYlE1d2rTdP4dD
 lsDKD2E3yTktdzpMYwRbTRfPQ9lVhYVz4xRw==
X-Received: by 2002:a05:6214:4305:b0:6cb:e53d:dd7 with SMTP id
 6a1803df08f44-6d1856e6b8bmr179609066d6.19.1730303861969; 
 Wed, 30 Oct 2024 08:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnviHexEz2UeiXDo12oy/A+rfrNlg3wuIuaqp6JVOyBblkIp8xqc67ZFRVY8/vY6arTtYzWg==
X-Received: by 2002:a05:6214:4305:b0:6cb:e53d:dd7 with SMTP id
 6a1803df08f44-6d1856e6b8bmr179608876d6.19.1730303861565; 
 Wed, 30 Oct 2024 08:57:41 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 03/18] migration: Ensure vmstate_save() sets errp
Date: Wed, 30 Oct 2024 11:57:19 -0400
Message-ID: <20241030155734.2141398-4-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

From: Hanna Czenczek <hreitz@redhat.com>

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
Link: https://lore.kernel.org/r/20241015170437.310358-1-hreitz@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
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
2.45.0



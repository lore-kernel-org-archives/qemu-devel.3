Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83178C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDab-0001If-Vq; Fri, 24 Jul 2026 06:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnDaa-0001ID-Ag
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 06:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnDaX-0007bh-Pf
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 06:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784890628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=KH6aWeF1c67fLZ3o2ZQP8FTWMVmlU4gnSflp0Jc/snU=;
 b=D2Yy1VaQ9NDarvZQOTq7Z+YkPkXnSgb9Mp/rjTM1DzoSPmKSGOpi1+6v9cVnnx813fxjMT
 xBRdiEaM1KI/Xs1PFjBsC5ujZqT8FkCqhFwhTdx+sbxN8L6u2JjnYcxjPFb5edn04QN00V
 VIqrsXuiIkOclcrBS33UZ3z2XCCGqho=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-hp6q3fCNPeSXUKNexHSBvQ-1; Fri, 24 Jul 2026 06:57:06 -0400
X-MC-Unique: hp6q3fCNPeSXUKNexHSBvQ-1
X-Mimecast-MFC-AGG-ID: hp6q3fCNPeSXUKNexHSBvQ_1784890626
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955e865174so2241245e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 03:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784890626; x=1785495426; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KH6aWeF1c67fLZ3o2ZQP8FTWMVmlU4gnSflp0Jc/snU=;
 b=SsLdd9JPtmIG08DAET8IUo9PmvY2WShslHgXSTJoJD9JvkgFWDzODgjFvlm0rv7Gmi
 vvbfd7SMp9aFqNbdFY7ffRVxT3SltXZoXc5HsfGeD2DgqrnfxKnl4UF2iTYmlvXdjAxw
 sLGwa3X0GylFABgqHKrUERgtpN/YSEYHdXfqA5Vo5Ak+OFR6WFr+EqDGfQdri+aeXju6
 w+rXXGmLXXTwPwswYdmFkm4nh/pgGAuhMH4do5madDjjNbeUsMq6PPzO0IcVH5q/YIRJ
 WBlIW1AufiFlY3U1uFG2fpyVW+gspix2+vlspwtaR8g0ZAhu0BtBDiksKl5Ze9dhA0Sa
 bWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784890626; x=1785495426;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KH6aWeF1c67fLZ3o2ZQP8FTWMVmlU4gnSflp0Jc/snU=;
 b=RgJv5hJg4UhHZFq0XZk3zg72JR+px3xGAd0nLnaIY2VXOtoJzk0uklFWzD2bO2mCzr
 T4CNGeRrFBLIQ6m1HIOSx2TbwqIxT1wqiC0d5IyRbiE3V7aRax4gCG5bQa3xk3O4e03q
 iim1wuf1Ra3/VrCz4/8CZzra4c6mETZVnpdaKbDI47nm4+FKPtMKpng1jyOgwqFI0Yqn
 J72Z6bdLYcIzgP6WbHh4CV5zRQusXrPV1HPXCcT41i73eHqKg6CF9B8mHwjPRSZv2r1g
 c5NHanTPM25aotK3EdOohW0AJfnvgsamK/1ugdMorsfm3j3fxj0ySWxfLgC40zCZ1xYH
 HvLQ==
X-Gm-Message-State: AOJu0YyMWqx1IAGHiiYAoguzTzHFnprFK+HjsuTHGvMGYL8Em2OQuNal
 WBmNsSvdYZWUaPPUvN7CbaXIzXs9QtNKeokK664KjtgJXm1UsTmUQ9BZp+3+sZN3hIpPLcssTZE
 rZjoa0P55F5F+A10WYM4T+E1ZF3vL9A8wM0OEPOYFI6OJT00I6m75m+o6Bn+Fl1EV7MVRdFJhYz
 w4RbnkTqS+XopCqYBBXLKV0bc0RfI1/bcOMg==
X-Gm-Gg: AR+sD12+Qoyhgb+8A05Kaw0RxLJu5BIMVJiBE8gc6pr1+4Qt5KuUTf2y/Sxz/JwcmNW
 9Nmjs/OQnSH3Hy38MqBOoHj+gK+3A45j2jO6HKB+N7Jq3aO82YtdoY/DCxAvLwg6JOw4ETcixFX
 H0s3b2y4GccG8YOUy/WVvkhhZemzqMLJl21PearyoPBzOiMfRYEzTTCQGga7WGG/NughIdaIW7r
 iGaFx6KMffbHG7Guy/0vEy7mCq+z7zMjvvJLw/I4q7zx9JOr9GQl8Li2y2rvMF9haxjbWVJlvKL
 ASCvNLPme2jfs6IW+N/IlmGRiktviVhnbJ7h10R+LxYLwVOFbLhLVDRPBW/UvRqYJCLmTtMbaRf
 5jx/f3JXtzLZoND3NxgLM/g==
X-Received: by 2002:a05:600c:584e:b0:495:8a1:7670 with SMTP id
 5b1f17b1804b1-49573d20739mr56862975e9.35.1784890625585; 
 Fri, 24 Jul 2026 03:57:05 -0700 (PDT)
X-Received: by 2002:a05:600c:584e:b0:495:8a1:7670 with SMTP id
 5b1f17b1804b1-49573d20739mr56862685e9.35.1784890625009; 
 Fri, 24 Jul 2026 03:57:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af79365sm73789875e9.9.2026.07.24.03.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:57:04 -0700 (PDT)
Date: Fri, 24 Jul 2026 06:57:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] vmstate: fix type confusion in vmstate_size() for
 VMSTATE_VBUFFER_UINT64
Message-ID: <801b1501ee10241f7ac49a10570d548352b36347.1784890517.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

vhost user currently saves the inflight buffer to the migration stream
using VMSTATE_VBUFFER_UINT64. The size is controlled by the vhost-user
backend.

But the implementation of that is broken if size is >2G: it stores the
buffer size in a uint64_t field, but vmstate_size() always reads the
size field as int32_t regardless of the macro used. This, in turn,
causes negative or truncated lengths on load, leading to undersized
allocations and down the road out-of-bounds buffer access.

There's no practical reason to support such large sizes, so it's enough
to validate: read the field as uint64_t when VMS_VBUFFER_UINT64 is set,
reject negative or oversized values, and propagate errors to
vmstate_load_vmsd().

Note: the large value is coming from the backend, not guest, so this
shouldn't be considered a security issue. The CVE was assigned before
the qemu security policy was updated to exclude this class of bugs.

Fixes: CVE-2026-6426
Fixes: f6fdd8b2bd ("vmstate: introduce VMSTATE_VBUFFER_UINT64")
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/migration/vmstate.h |  5 ++++-
 migration/vmstate.c         | 31 ++++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1b7f295417..e7095cd977 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -168,6 +168,9 @@ enum VMStateFlags {
      */
     VMS_ARRAY_OF_POINTER_AUTO_ALLOC = 0x10000,
 
+    /* Use a uint64_t size field for VMS_VBUFFER instead of int32_t. */
+    VMS_VBUFFER_UINT64              = 0x40000,
+
     /* Marker for end of list */
     VMS_END                         = 0x20000,
 };
@@ -788,7 +791,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
     .field_exists = (_test),                                         \
     .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
     .info         = &vmstate_info_buffer,                            \
-    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
+    .flags        = VMS_VBUFFER | VMS_VBUFFER_UINT64 | VMS_POINTER,  \
     .offset       = offsetof(_state, _field),                        \
 }
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 50ebe37845..d7f03a9f5b 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -103,10 +103,24 @@ static int vmstate_size(void *opaque, const VMStateField *field)
     int size;
 
     if (field->flags & VMS_VBUFFER) {
-        size = *(int32_t *)(opaque + field->size_offset);
-        if (field->flags & VMS_MULTIPLY) {
-            size *= field->size;
+        uint64_t usize64;
+
+        if (field->flags & VMS_VBUFFER_UINT64) {
+            usize64 = *(uint64_t *)(opaque + field->size_offset);
+        } else {
+            int32_t ssize32 = *(int32_t *)(opaque + field->size_offset);
+            if (ssize32 < 0) {
+                return -1;
+            }
+            usize64 = ssize32;
         }
+        if (field->flags & VMS_MULTIPLY) {
+            usize64 *= field->size;
+        }
+        if (usize64 > INT_MAX) {
+            return -1;
+        }
+        size = usize64;
     } else if (field->flags & VMS_ARRAY_OF_POINTER) {
         /*
          * For an array of pointer, the each element is always size of a
@@ -337,6 +351,11 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
+            if (size < 0) {
+                error_setg(errp, "VMState field '%s': invalid size",
+                           field->name);
+                return false;
+            }
 
             vmstate_handle_alloc(first_elem, field, opaque);
             if (field->flags & VMS_POINTER) {
@@ -661,6 +680,12 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
             bool use_dynamic_array =
                 field->flags & VMS_ARRAY_OF_POINTER_AUTO_ALLOC;
 
+            if (size < 0) {
+                error_setg(errp, "VMState field '%s': invalid size",
+                           field->name);
+                ok = false;
+                goto out;
+            }
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
-- 
MST



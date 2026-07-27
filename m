Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD920C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQri-00005a-J5; Mon, 27 Jul 2026 15:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQrg-0008WR-Gp
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQre-0000LY-MT
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785179990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5xEgcXduIKUS+efKpR6fC7s/haat8kW+FyLhnuY1/MM=;
 b=AzYI2kv4XwmqttRp2hZ1WU/3zBj4Afd3v70vDaglFKNXQpQP+17yD6W+LFfIvmUoUIvnx8
 Gzje4xMsEBCJR1e1+l7Gtsk2lBd/gp9ZbU2Rpw0RW8kHeC2nqvlVBphHdutD8af5QCWmi1
 LxPrjQT8aSaH/kbKmOwBKLY1BJC3XbU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-zb2lgnO_PACqcGKH2tVlbA-1; Mon, 27 Jul 2026 15:19:48 -0400
X-MC-Unique: zb2lgnO_PACqcGKH2tVlbA-1
X-Mimecast-MFC-AGG-ID: zb2lgnO_PACqcGKH2tVlbA_1785179987
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493bfc3b84aso17325845e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785179987; x=1785784787; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5xEgcXduIKUS+efKpR6fC7s/haat8kW+FyLhnuY1/MM=;
 b=m/Iv13VPjDXTLs5sYE5PGtPIujZM4twMoNPYswpYK3DdNSHbb4hBjIY7RorfRJo4Vk
 7YYTuiiK35sK+WKINxwQ8uNoGgAWBMEd1ozb4Lq7nYO6CekStgCZKygC9notqcPYy4Eb
 LiZx1Jp9deLC7yRsXHkprLGOw75lurgOB4HtmKRHy3GaTnOIdipSMNJp8Tke0+/Ypt6E
 idmTFaT5cNPJTVP7cVghtRq1fUy6bSh4X+99MebDBFz1X4c3d0oMkE3hjfWPv3kI9RTd
 j/cMxuuvf4jBIPsW149ywupRLxFHjLZGRzYGLIDGbZyfwbtqOVp7npzDJCnVDvVCHjlr
 ndxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785179987; x=1785784787;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5xEgcXduIKUS+efKpR6fC7s/haat8kW+FyLhnuY1/MM=;
 b=YCsaF2urI1bnTxDoMJzz3bMDHneFQOLQbQX+xubh/zKRwWA9OFVoz0t4NTJA9im5U/
 7XLOjk4eeXKwSw2jlwkDHbdsKoi+5GheYAPoIAVirPdb5aayGWcg1vdGFeewO6dv/+sO
 DomOESW1sKkNRQy+wRohqaSzaeml8JVRQ3CvvHT+ES4xAEkheKczG4Wqdc4D2fp5PZ2/
 czZKDdOwSebUEOXbziawvePCfc/LdRHPmPEkh/2si2eyrvriAxg3nHhxtJ/YEzeLP8LX
 WjKbxzb/HhW4M+FezqOicdh78kSBER4h+GM/x11I+9Tcs61uGbatAyBs0fMtFn3J388+
 IFsw==
X-Gm-Message-State: AOJu0YxV1EEuNOCMNoiSu+Q6rYzam93tkp4KKyX2QHsdKcZZTFNP9Ssd
 Lacms2wM2qPK+HgQt4RZ9b4gnGUwiBkAgBe95FJWz2h6klO1XsYzy57yr7Sdjxo2j36n4cvbhR/
 fgSQAYz7RjroXqPJA09Lw4VBm+9tCNlA/2fApP5v4CCK83fvGyjVn2YfVctxuT9xZmrEKQdSc3r
 /CfzSlaQKkhqCJq1QzELBQkyeVF8uWFuGFTA==
X-Gm-Gg: AR+sD12VZn6kTm3cSFWnpfjncH0n8RH6OKufyWy1mWLjeHCzXBuk5i1SSb9avAyRRNO
 pbW5fQ1mIHcIUR2X0jnVWAcdEEHTGCNv+Z7lZo0JOyUYJKGOHViL93Uy6s7PvorhqB0A+4CPFkY
 x9c1ccKViASX+CNhnXyVmh44Z4Q1nEIEebZUMl4IWcj933pgQ1ElEKp+tvgshYpOQivJp13wvjQ
 MJt+VUebjfqvUUNW+rb3FOsO74BopNm1TW+TU2xQHjhrBRWfFvDO4iXNM36BJMYVxipB4dfJM/u
 2deyo4vrbsYwaQ8upyLh6JNU7xf/4RNqEZrT6TD/JH+++HR6GizF8Jo/30tI9jvynhdZlsIYJIi
 x7bLfgs+PkGRAQc4F4ODHLg==
X-Received: by 2002:a05:600c:5253:b0:495:4732:1eb9 with SMTP id
 5b1f17b1804b1-496c4fce74dmr4251295e9.21.1785179987343; 
 Mon, 27 Jul 2026 12:19:47 -0700 (PDT)
X-Received: by 2002:a05:600c:5253:b0:495:4732:1eb9 with SMTP id
 5b1f17b1804b1-496c4fce74dmr4250865e9.21.1785179986671; 
 Mon, 27 Jul 2026 12:19:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b388d5b4sm178961985e9.3.2026.07.27.12.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:19:46 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:19:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xlabai <xlabai@tencent.com>
Subject: [PULL v2 04/30] libvhost-user: protect against OOB writes in
 vu_set_inflight_fd
Message-ID: <fbdfdbb9920cb69408d53cb86a8e079a2054581e.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

vu_set_inflight_fd() trusts the num_queues value from the
VHOST_USER_SET_INFLIGHT_FD message without checking it against
dev->max_queues, so an oversized value causes out-of-bounds writes to
dev->vq.

Front end is generally trusted so not a security problem, but OOB isn't
a nice way to handle frontend bugs.  Let's harden this a bit:
check num_queues and panic if it's invalid.

Fixes: 5f9ff1eff3 ("libvhost-user: Support tracking inflight I/O in shared memory")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3740
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reported-by: xlabai <xlabai@tencent.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <23b3f12388c1035f208550df9de9944c22d8d534.1784899127.git.mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 2c35bddd6f..8208265588 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1998,6 +1998,8 @@ vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
 
     if (vmsg->size != sizeof(vmsg->payload.inflight)) {
         vu_panic(dev, "Invalid get_inflight_fd message:%d", vmsg->size);
+        vmsg_close_fds(vmsg);
+        vmsg->fd_num = 0;
         vmsg->payload.inflight.mmap_size = 0;
         return true;
     }
@@ -2005,6 +2007,15 @@ vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
     num_queues = vmsg->payload.inflight.num_queues;
     queue_size = vmsg->payload.inflight.queue_size;
 
+    if (num_queues > dev->max_queues) {
+        vu_panic(dev, "Invalid get_inflight_fd num_queues: %"PRId16,
+                 num_queues);
+        vmsg_close_fds(vmsg);
+        vmsg->fd_num = 0;
+        vmsg->payload.inflight.mmap_size = 0;
+        return true;
+    }
+
     DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
     DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
 
@@ -2052,6 +2063,7 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
         vmsg->size != sizeof(vmsg->payload.inflight)) {
         vu_panic(dev, "Invalid set_inflight_fd message size:%d fds:%d",
                  vmsg->size, vmsg->fd_num);
+        vmsg_close_fds(vmsg);
         return false;
     }
 
@@ -2061,6 +2073,13 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
     num_queues = vmsg->payload.inflight.num_queues;
     queue_size = vmsg->payload.inflight.queue_size;
 
+    if (num_queues > dev->max_queues) {
+        vu_panic(dev, "Invalid set_inflight_fd num_queues: %"PRId16,
+                 num_queues);
+        close(fd);
+        return false;
+    }
+
     DPRINT("set_inflight_fd mmap_size: %"PRId64"\n", mmap_size);
     DPRINT("set_inflight_fd mmap_offset: %"PRId64"\n", mmap_offset);
     DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
@@ -2071,6 +2090,7 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
 
     if (rc == MAP_FAILED) {
         vu_panic(dev, "set_inflight_fd mmap error: %s", strerror(errno));
+        close(fd);
         return false;
     }
 
-- 
MST



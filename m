Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911AA606A68D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LCbwCFvR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUZZ4-0004sb-L9; Fri, 20 Nov 2026 20:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3b-cAawoKCqACHANGYUANLGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--changyuanl.bounces.google.com>)
 id 1xUZ5K-0007hO-3S
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 19:36:06 -0500
Received: from mail-dy1-x1345.google.com ([2607:f8b0:4864:20::1345])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3b-cAawoKCqACHANGYUANLGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--changyuanl.bounces.google.com>)
 id 1xUZ5I-0001os-89
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 19:36:05 -0500
Received: by mail-dy1-x1345.google.com with SMTP id
 5a478bee46e88-375bac6bd21so1576381eec.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 16:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795221361; x=1795826161; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mcVi9So+lH+nOcKf3r97gXmNVWTDvOb3ZDH44hgBVpQ=;
 b=LCbwCFvRIfBoV3TJdNWSMmnUxhT7qfk08fK3pmf+JtBiLrl4Oo+urnh+02EAoZ0oEg
 0rhc7UGFl/vDqe/mwn8pJehbscgwRlClf48KujjHKOyLNMkE2hcwWDJ6pP+mU+V46LcL
 BHobiRRHZbLemJckAYphVcvnrGHEft24zdvNqC8g4zFGM+VUp2Erfb8f+ZCus85NFeMx
 HxghhCZOzl/FkND7BjrxcJG8tRVO9oPOedcVnlzRQPTaGwZ0PI06m1z6waib0D4+Mp3p
 GbCxcmgoDVvKkejSqwTstoLm5iLi+kn6R7O5WN/Gyds0ZkOHp9EvlPZBa3y+T08SKcFr
 ncHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795221361; x=1795826161;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mcVi9So+lH+nOcKf3r97gXmNVWTDvOb3ZDH44hgBVpQ=;
 b=0d+lcfST0rmGANI+4++s8Own3Y+LAcjSYkOOzilhj0TkW5FV2+339AE2tw228CaEuL
 Hkn1Q/mBNhAcIA1qXiPdQow56GYtTUxa9yk4D+9W3Nzt3EAtnhvmWglrMlAK71gHTbS5
 WKpno07MluogmNnM5qxideSIJcG/mMQ3Jl/c0UjnQqrGtRq3JTGIyQpJGAJY4bgWWOhv
 1wJ8NhMgTOf87XoJFNKFB8jxmKY67h3hNYrgDOlXXUfeYq9rs2fBffxpIJraALXoKROo
 XgdRL65086VUUJ4MtD59eVIh7gSCC6S4uOAGzB0poduMLatlHS21BFVCgg3olB7ZlGUY
 v4/A==
X-Gm-Message-State: APuU4Z8Qpq5Qw0a3j4zTk9cLITXqKba05ttB0IySAtQSwwTKS3g1yl0E
 xG20wzdnyGu5rY8srbivap1G8r1YLHcTv48Td5o4bM/6F11N1C4TX2H2VXfPiJhXdEyn3npY7u1
 VpVYzZ1GtonqEM+Wva2UAXaSzu+4r2bmza5aytbEGij4I+1bKY2OkyVzf/6zS7tu+Y2wrCHQOUa
 BNxyUh2welJnFu854ajTf1Y38nXEpMEoHo4r0qWUvCaidI0Bj1eQKNPE1M
X-Received: from dybmw18.prod.google.com
 ([2002:a05:7300:cd92:b0:380:c63f:6b75])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:68dc:b0:384:244b:12ed with SMTP id
 5a478bee46e88-384b11ec95amr6473729eec.3.1795221359870; 
 Fri, 20 Nov 2026 16:35:59 -0800 (PST)
Date: Fri, 20 Nov 2026 16:35:56 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261121003556.2270798-1-changyuanl@google.com>
Subject: [PATCH] libvhost-user: honor the offset of VHOST_USER_GET_CONFIG
From: Changyuan Lyu <changyuanl@google.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, vhost-user@lists.linux.dev, 
 Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1345;
 envelope-from=3b-cAawoKCqACHANGYUANLGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--changyuanl.bounces.google.com;
 helo=mail-dy1-x1345.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Nov 2026 20:06:47 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the vhost-user specification, the payload of VHOST_USER_GET_CONFIG
carries an offset into the config space of the virtio device, an access
size in bytes, and a byte array of that size with the contents of the
config space (see "Virtio device config space" in
docs/interop/vhost-user.rst). So a front-end may read any part of the
config space.

vu_get_config() hands the payload buffer and the size of the request to
the get_config() callback of the device, and ignores the offset. The
callback takes no offset and fills in the config space from its start,
so the reply always carries the first bytes of the config space,
whatever offset the front-end asked for.

QEMU does not notice, because it always reads the whole config space
from offset 0. A front-end that forwards each config space access of
the guest driver gets wrong data for every access at a non-zero offset.
For example, with a vhost-user-blk export of qemu-storage-daemon, a
Linux guest gets the low bytes of the capacity in place of num_queues
and fails to probe the device:

  virtio_blk virtio0: MQ advertised but zero queues reported
  virtio_blk virtio0: probe with driver virtio_blk failed with error -22

Ask the callback for the config space up to the end of the requested
range, and move the range to the start of the reply. This keeps the
callback as it is, so no device has to change. Reply with an error, a
zero-length payload as the specification says, if the range does not
fit in VHOST_USER_MAX_CONFIG_SIZE. The callbacks already reject a
length beyond the end of their config space.

Fixes: 0bc24d831e49 ("contrib/libvhost-user: enable virtio config space messages")
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 subprojects/libvhost-user/libvhost-user.c | 17 ++++++++++++++---
 subprojects/libvhost-user/libvhost-user.h |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 52817cc733..a55899919c 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1902,16 +1902,27 @@ vu_set_backend_req_fd(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_get_config(VuDev *dev, VhostUserMsg *vmsg)
 {
+    uint32_t offset = vmsg->payload.config.offset;
+    uint32_t size = vmsg->payload.config.size;
+    uint8_t *region = vmsg->payload.config.region;
     int ret = -1;
 
-    if (dev->iface->get_config) {
-        ret = dev->iface->get_config(dev, vmsg->payload.config.region,
-                                     vmsg->payload.config.size);
+    /*
+     * The get_config() callback takes no offset and fills in the config
+     * space from its start. So get everything up to the end of the
+     * requested range, and move the range to the start of the reply.
+     */
+    if (dev->iface->get_config &&
+        offset <= VHOST_USER_MAX_CONFIG_SIZE &&
+        size <= VHOST_USER_MAX_CONFIG_SIZE - offset) {
+        ret = dev->iface->get_config(dev, region, offset + size);
     }
 
     if (ret) {
         /* resize to zero to indicate an error to frontend */
         vmsg->size = 0;
+    } else if (offset > 0) {
+        memmove(region, region + offset, size);
     }
 
     return true;
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index a534d70771..163adad719 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -290,7 +290,7 @@ typedef struct VuDevIface {
      * on unmanaged exit/crash.
      */
     vu_queue_is_processed_in_order_cb queue_is_processed_in_order;
-    /* get the config space of the device */
+    /* get the first len bytes of the config space of the device */
     vu_get_config_cb get_config;
     /* set the config space of the device */
     vu_set_config_cb set_config;
-- 
2.56.1.750.gf70dc682cf-goog



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE847C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1xr-000629-CR; Thu, 23 Jul 2026 18:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wy-000579-6m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:34 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wt-0001Tx-Nv
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:30 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-81ec29f1d07so9905927b3.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845885; x=1785450685; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7g695DoaNeoeNqj+3zVdxB0K+XyGWJGyI59c0QJ8p1g=;
 b=dq7XHKfua4R+QgGcx8uZ1Z1HQKdwA2Zgunh7lBqwonIgtF63viIsHuInqQwBobac4x
 Ooh9RdH0kg4rvt8aaR6m5p76vZ+PANyj00Ywg1N+5ncBFJLevPMWKUbcsqXPoPH6ZCa0
 eWdicdum757OfqRQnVlDBC6uY5YJT5u4DhJHH7ngix6TiGAwPvVo+X0aW76eSiKRxg0K
 YJjoxmSxleZlwwsVlBzQBoemThc11M3S9MiZr32HDBOvyqNfCOIQwS8XU+6u+iRezB8z
 Wfv3Pk6fBxsN0/7XfwARn/O9dnSYRa1NChlvGaXIVWTLkdXe+2M8KFCzrPodTGk4D9xs
 E7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845885; x=1785450685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7g695DoaNeoeNqj+3zVdxB0K+XyGWJGyI59c0QJ8p1g=;
 b=IqQXl+luTO3uxWVEaSlD5aEOVICgqd+ghvs9cyKxH2zZhRSr6AMdOE3h6lIHvel2q4
 g8lje6yY/acthjliKZvAhCImBF0HHcudS73U96gFdE+Jjl5ua75k2U5podI2YvJiYjrS
 kAgDowG7U0bA+Yi/x39UURlQLUOTBwXIa5PwT+fFfEaFd/vfFI94yQso8eOv6C6A2kw7
 a7DABZTTQoha5nufAj2dTElDHiZiwLiYe9WUNTQoZRfDmt+uScKw0X8/77PGZ5EIrA3g
 oHIDuT7cjtUQK1ZZgdfT/bzAhWGJ9fr/QyY/MB31huPWhJr6Lk176a1lXYAIvARuwqoZ
 UwXA==
X-Gm-Message-State: AOJu0Yy7+goBaV8hOB0wSyKrSJIB7vIPBY+A3J9kD8b2nkFPpJZM+yV6
 A/DaFj8If3zuJiA7qttBWtQXqb5SpLw6RcE8MRPnVuvyGLwujJpgK2IK
X-Gm-Gg: AR+sD10UJM/pXSd455Q4N6e+Zb7xLRmUBNoA3qfka7JU2M/XFMzir84JhpLlyzBZRKZ
 WrB31OFvjfnUw7WGa3E9wXIwg16dZT4rSnNS7xXZ0XpjRfc4n6Zet6OlsNrotpZe36G/R4EGq5S
 jfccd5DKpAmdGsjD0b3hfPbQPCRJ+VvYtPFTJhMYxiojNzkwTCfuM9GxDCOH72T5OWRDQFcn8uo
 ydGhZf8AsgB3H4KH+3rk8lxqaYiZHsW+URllwGyMXSN1syrq5OgW1eO5+x4WvS+AtXjwDW9LLTP
 Cd0caKuev0AED59dkzRXyTpiZj88LBm+TsPtfANL6vqe3PQPM0sjbSWtKXq0uXqR2bOJDbyjcGC
 fU0+KE6kxL7bqG4gaJbCwDOc3E4dTnKCDz2qcaIy8zXH8vo7GsqXMcDLdBUWFE3AOU0h7bbht+C
 ntxUJZ/Zw=
X-Received: by 2002:a05:690c:278a:b0:81f:2825:dfe with SMTP id
 00721157ae682-81f4c2f355emr15747807b3.36.1784845884775; 
 Thu, 23 Jul 2026 15:31:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:31:24 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:11 -0700
Subject: [PATCH RFC 12/15] hw/virtio/vhost-user: send isolation regions to
 device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-12-6b97c439eb28@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=4517;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=z+Lm2PsZk3LkweDB1zsNiYheTgHWbAa+oQgnW46zMuo=;
 b=pAp4Enx1zJP2EmdbaCYBM7rhebwhPIOXdD1Yc0E2HneL3odB9pvotznN3IuY7YEaMfZ6Z4Xvw
 SENASOV6t7FB6hpNXkSnX5kK1VCIllzRwx1gCdT9gw6vMRQYk77jHMP
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Adds features to fill a vhost_user_set_mem_table message with the
addresses of isolation memory regions corresponding to bounce buffers
and vrings.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-user.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 710cf966f8..acabfb7f1c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -625,6 +625,21 @@ static void vhost_user_fill_msg_region(struct vhost_dev *dev,
     dst->mmap_offset = mmap_offset;
 }
 
+static void vhost_user_fill_msg_region_iso(VhostUserMemoryRegion *dst,
+                                           const struct vhost_user *u,
+                                           const struct vhost_memory_region
+                                           *iova_reg)
+{
+    assert(u != NULL && dst != NULL && iova_reg != NULL);
+    uint64_t offset;
+
+    offset = iova_reg->userspace_addr - u->iso_memory.base_addr;
+    dst->userspace_addr = iova_reg->userspace_addr;
+    dst->memory_size = iova_reg->memory_size;
+    dst->guest_phys_addr = iova_reg->userspace_addr;
+    dst->mmap_offset = offset;
+}
+
 static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
                                              struct vhost_dev *dev,
                                              VhostUserMsg *msg,
@@ -1136,7 +1151,33 @@ static void cleanup_isolation_regions(struct vhost_dev *dev)
     }
 }
 
-__attribute__((unused))
+struct iova_tree_traversal_args {
+    VhostUserMsg *msg;
+    struct vhost_user *u;
+    int *fds;
+    size_t *fd_num;
+};
+
+static gboolean vhost_user_iova_tree_traverse_funct(gpointer key,
+                                                    gpointer value,
+                                                    gpointer data)
+{
+    struct iova_tree_traversal_args *args = data;
+    struct vhost_memory_region msg_region;
+    VhostUserMemoryRegion region_buffer;
+    DMAMap *map = key;
+    args->fds[*args->fd_num] = args->u->iso_memory.iso_fd;
+
+    msg_region.guest_phys_addr = map->iova;
+    msg_region.memory_size = map->size + 1;
+    msg_region.userspace_addr = map->iova;
+    vhost_user_fill_msg_region_iso(&region_buffer, args->u, &msg_region);
+    args->msg->payload.memory.regions[*args->fd_num] = region_buffer;
+    (*args->fd_num)++;
+
+    return false;
+}
+
 static int init_isolation_regions(struct vhost_dev *dev,
                                   VhostUserMsg *msg,
                                   int *fds, size_t *fd_num)
@@ -1234,6 +1275,24 @@ static int init_isolation_regions(struct vhost_dev *dev,
                                       map->translated_addr);
     }
 
+    struct iova_tree_traversal_args args = {
+        .fd_num = fd_num,
+        .fds = fds,
+        .msg = msg,
+        .u = u
+    };
+
+    vhost_iova_tree_foreach(u->iso_iova_tree,
+                            vhost_user_iova_tree_traverse_funct, &args);
+
+    msg->payload.memory.nregions = *fd_num;
+
+    assert(*fd_num != 0);
+
+    msg->hdr.size = sizeof(msg->payload.memory.nregions);
+    msg->hdr.size += sizeof(msg->payload.memory.padding);
+    msg->hdr.size += *fd_num * sizeof(VhostUserMemoryRegion);
+
     return 0;
 }
 
@@ -1241,6 +1300,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
     struct vhost_user *u = dev->opaque;
+    bool memory_isolation = u->user->memory_isolation;
     int fds[VHOST_MEMORY_BASELINE_NREGIONS];
     size_t fd_num = 0;
     bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
@@ -1268,6 +1328,24 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
+    if (memory_isolation) {
+        ret = init_isolation_regions(dev, &msg, fds, &fd_num);
+        if (ret < 0) {
+            return ret;
+        }
+
+        ret = vhost_user_write(dev, &msg, fds, fd_num);
+        if (ret < 0) {
+            return ret;
+        }
+
+        if (reply_supported) {
+            return process_message_reply(dev, &msg);
+        }
+
+        return 0;
+    }
+
     if (config_mem_slots) {
         ret = vhost_user_add_remove_regions(dev, &msg, reply_supported, false);
         if (ret < 0) {

-- 
2.43.0



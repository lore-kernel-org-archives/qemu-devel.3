Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AAD606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=tM6zZVup
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQ9g-0003Be-SU; Fri, 06 Nov 2026 15:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xPQ9f-0003Aj-2i
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:03:19 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xPQ9c-0004mi-Ne
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:03:18 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so7026765e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 12:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793995395; x=1794600195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0A4sVlENlNU1c//EuQKD+X3QRpd1z9onjZ/ZxRfdywM=;
 b=tM6zZVupBeZTuYnhd6hleje9OPVVhBO6OuhWPsS8Cr8AoEP5S9vfJhmyki6KDCkAsq
 F7FeES3aSfoVhmAfgq06MJXuE34+OHwETdDkz4KAE3YUNi2nqHfjXHusQSNmDmr4Zp2F
 LADq/EJ9N/3flj/RcgY1Pf/7iSRVM7sdHIA44HhnE46XO2HxjlriWJ8+LCKg29z1GQSf
 YI9SiGcahns3TFcRdFykABQdMuZjXeSHfwyWW4+mkOvAl38v4W55NwxLV7JyHqrlS53Q
 fbZt1PhYoIDmGChkTJ4pSy3+haJT1I5wGmSww1RGlrPF48dp5A0M5qUA9iBLpkHwlKEt
 /e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793995395; x=1794600195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0A4sVlENlNU1c//EuQKD+X3QRpd1z9onjZ/ZxRfdywM=;
 b=YXgIKH7sKf8JosGISaqDx8pNsZSVzF7yRjiXxx7oKmhaw6DYgIeEMnf4AxrRK3D7Nf
 dMioKsu5u6xT8K2Lxcsy5iyOb6UHdznZ/XaPioUJN8Cso9yhx8kpNAQPSUxmubuZtoeq
 15s6z+WHf6PNZPBBoDJOgX7jkfoqaskO+44LJOkHLxBhE/ZYcc3n0DdQNRQBVXCzuOhE
 yCKIwt03umpmFNbgeuRDbL32AZnMDsfz/llnOdK99nV0z6vGfdcuaj5xRPu285ZGc0Nc
 Vmx5oLn9XNZbbW0XxRM2Qxa3RMAoPbkig+XTF3sWQlWPkP2v1q2E4GSl+B9LKWX0FpnB
 U8SQ==
X-Gm-Message-State: APuU4Z81AsStXrPu35WB83EiBwIWGxsaiKapj8/yNea5mJOMl8N4pktt
 ektw7ipf6an6aJ3iQyVtMGx2GhOrfDw7NlPC3RpUE7+fojq6De1z+J7RvjH0jlgk1aG5saoZF2Z
 zXcU5
X-Gm-Gg: AYBFou00NTGccLxUbxUJNroPp2kDRGHgiGCYzUZ4omveIiG4UGCoPaudZZWH6MrQc4U
 LJi/0F7fzqjBI8DT2XGksKxEBZDRivzemyrv8BS/wZpyfjNSgRTMQMOeV0exINx6REDQz7Yp6Bc
 iq7FxfLzIk9+Dy/tUVXTCZJjuGGuqo2npOHL7QR8pNrhYzZKx1S0vVsSzp21+5RhKLZqsxp0j6u
 kqENhQiR4oo2+69wlcZrhu4qZOCvm4t/Pp8IS7kaXaIb+Ud2gbD1fsZBJsRUWdypcTrWBzh2IZ1
 sj6KiDUcj56JshCxjEwifKvkgFxZmEIjleyaukG1sqfSq+LTGjjMz1zqK6K0tvR4hChE6z9Gk/6
 1zuUnTJOfvFHBsqxtk3vHymF9MCvWAPbPpUSk/qtT1yh+5Uao8rMZSsTsGIMEIkznTeWmGxK6cB
 7ZecSrpnyUCKZIOGmPqu2d5MOzq4DD0W31HvtBYxnSFyjaSQtMjR9EZEkQW0m5x1cF5IwlA0NnG
 Atjp3YkbE8S48q6I1m6JKEznMPxxktITugrRugiD02HwmNMcK805p8y96MSMVLoGDtIt0x4tZy2
 ZGNo6KVgW3iVW8J+KHuBVvgh9Q==
X-Received: by 2002:a05:600c:4704:b0:4a1:faa1:3813 with SMTP id
 5b1f17b1804b1-4b6e035edbamr72047315e9.27.1793995394905; 
 Fri, 06 Nov 2026 12:03:14 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1983:68c3:80e8:4ae2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e3271867sm4660995e9.6.2026.11.06.12.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 12:03:14 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/2] virtio-net: fix abort in virtio_net_set_queue_pairs() on
 a deleted tap
Date: Fri,  6 Nov 2026 21:03:08 +0100
Message-ID: <20261106200309.122830-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106200309.122830-1-den@openvz.org>
References: <20261106200309.122830-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

Once the tap device behind a multiqueue netdev is deleted on the host,
the queue fds QEMU holds are no longer bound to any device and
TUNSETQUEUE fails with EINVAL, for attach and detach alike. Management
can delete the device under a running VM, e.g. OpenStack unplugs the
VIF of an instance it is deleting. The next
VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET from the guest then kills QEMU:

  could not enable queue
  virtio_net_set_queue_pairs: Assertion `!r' failed.

A guest reset aborts the same way through set_features(): clearing the
features detaches the extra queues and the detach fails too.

Commit a1708203b583 ("net/tap-linux.c: avoid abort when setting invalid
fd") removed the earlier abort on the same path in
tap_set_vnet_hdr_len(); this is the next one.

tap_fd_enable() and tap_fd_disable() already report the error. Walk the
remaining queues anyway, return the failure and let the callers decide:
- the control command restores the previous number of queue pairs and
  returns VIRTIO_NET_ERR, so the device matches the guest, which keeps
  its old setting on error. The rollback cannot fail in turn: tap
  tracks which queues are attached and skips the ioctl for a queue
  whose attach or detach already failed;
- post-load fails the migration, so the source keeps running instead
  of the destination aborting;
- set_features() has no way to report it and carries on with a dead
  link, as a single queue NIC on a deleted tap already does.

The test attaches its own copy of the second queue fd before the guest
asks for two queue pairs, so the attach from QEMU fails with EINVAL on
a live device. Creating the tap needs CAP_NET_ADMIN, so the test is
skipped without it.

Fixes: fed699f9ca6a ("virtio-net: multiqueue support")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/virtio-net.c           |  25 +++++---
 tests/qtest/virtio-net-test.c | 104 ++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 54e42cfec9..82e3c22ca3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -766,24 +766,27 @@ static int peer_detach(VirtIONet *n, int index)
     return tap_disable(nc->peer);
 }
 
-static void virtio_net_set_queue_pairs(VirtIONet *n)
+static int virtio_net_set_queue_pairs(VirtIONet *n)
 {
     int i;
     int r;
+    int ret = 0;
 
     if (n->nic->peer_deleted) {
-        return;
+        return 0;
     }
 
     for (i = 0; i < n->max_queue_pairs; i++) {
         if (i < n->curr_queue_pairs) {
             r = peer_attach(n, i);
-            assert(!r);
         } else {
             r = peer_detach(n, i);
-            assert(!r);
+        }
+        if (r < 0) {
+            ret = r;
         }
     }
+    return ret;
 }
 
 static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
@@ -1499,7 +1502,7 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
                                 struct iovec *iov, unsigned int iov_cnt)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
-    uint16_t queue_pairs;
+    uint16_t queue_pairs, old_queue_pairs;
     NetClientState *nc = qemu_get_queue(n->nic);
 
     virtio_net_disable_rss(n);
@@ -1532,6 +1535,7 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
         return VIRTIO_NET_ERR;
     }
 
+    old_queue_pairs = n->curr_queue_pairs;
     n->curr_queue_pairs = queue_pairs;
     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
         /*
@@ -1543,7 +1547,12 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
     /* stop the backend before changing the number of queue_pairs to avoid handling a
      * disabled queue */
     virtio_net_set_status(vdev, vdev->status);
-    virtio_net_set_queue_pairs(n);
+    if (virtio_net_set_queue_pairs(n) < 0) {
+        n->curr_queue_pairs = old_queue_pairs;
+        virtio_net_set_status(vdev, vdev->status);
+        virtio_net_set_queue_pairs(n);
+        return VIRTIO_NET_ERR;
+    }
 
     return VIRTIO_NET_OK;
 }
@@ -3298,7 +3307,9 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
      */
     n->saved_guest_offloads = n->curr_guest_offloads;
 
-    virtio_net_set_queue_pairs(n);
+    if (virtio_net_set_queue_pairs(n) < 0) {
+        return -EINVAL;
+    }
 
     /* Find the first multicast entry in the saved MAC filter */
     for (i = 0; i < n->mac_table.in_use; i++) {
diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
index 60e5229a3d..9224ee05d9 100644
--- a/tests/qtest/virtio-net-test.c
+++ b/tests/qtest/virtio-net-test.c
@@ -16,6 +16,12 @@
 #include "libqos/qgraph.h"
 #include "libqos/virtio-net.h"
 
+#ifdef CONFIG_LINUX
+#include <net/if.h>
+#include <sys/ioctl.h>
+#include <linux/if_tun.h>
+#endif
+
 #ifndef ETH_P_RARP
 #define ETH_P_RARP 0x8035
 #endif
@@ -285,6 +291,97 @@ static void *virtio_net_test_setup(GString *cmd_line, void *arg)
     return sv;
 }
 
+#ifdef CONFIG_LINUX
+static void virtio_net_test_cleanup_tap(void *opaque)
+{
+    int *fds = opaque;
+    int i;
+
+    qos_invalidate_command_line();
+    for (i = 0; i < 2; i++) {
+        if (fds[i] >= 0) {
+            close(fds[i]);
+        }
+    }
+    g_free(fds);
+}
+
+/* arg is the number of tap queues, 1 or 2 */
+static void *virtio_net_test_setup_tap(GString *cmd_line, void *arg)
+{
+    struct ifreq ifr = {
+        .ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR | IFF_MULTI_QUEUE,
+    };
+    int queues = GPOINTER_TO_INT(arg);
+    int *fds = g_new(int, 2);
+    int i;
+
+    fds[0] = fds[1] = -1;
+    /* TUNSETIFF returns the device name in ifr, the next call attaches to it */
+    for (i = 0; i < queues; i++) {
+        fds[i] = open("/dev/net/tun", O_RDWR);
+        if (fds[i] < 0 || ioctl(fds[i], TUNSETIFF, &ifr) < 0) {
+            break;
+        }
+    }
+
+    if (i < queues) {
+        for (i = 0; i < 2; i++) {
+            if (fds[i] >= 0) {
+                close(fds[i]);
+                fds[i] = -1;
+            }
+        }
+        g_string_append(cmd_line, " -netdev hubport,hubid=0,id=hs0 ");
+    } else if (queues == 1) {
+        g_string_append_printf(cmd_line, " -netdev tap,fd=%d,id=hs0 ",
+                               fds[0]);
+    } else {
+        g_string_append_printf(cmd_line, " -netdev tap,fds=%d:%d,id=hs0 ",
+                               fds[0], fds[1]);
+    }
+
+    g_test_queue_destroy(virtio_net_test_cleanup_tap, fds);
+    return fds;
+}
+
+static void mq_tap_attach_fail(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtioNet *net = obj;
+    int *fds = data;
+    QTestState *qts = global_qtest;
+    QVirtQueue *vq = net->queues[net->n_queues - 1];
+    struct ifreq ifr = { .ifr_flags = IFF_ATTACH_QUEUE };
+    uint8_t cmd[4] = { VIRTIO_NET_CTRL_MQ, VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET };
+    uint64_t addr;
+    uint32_t head;
+
+    if (fds[0] < 0) {
+        g_test_skip("cannot create a multiqueue tap device");
+        return;
+    }
+
+    if (qvirtio_is_big_endian(net->vdev)) {
+        stw_be_p(cmd + 2, 2);
+    } else {
+        stw_le_p(cmd + 2, 2);
+    }
+
+    /* Grab queue 1 so that QEMU fails to attach it */
+    g_assert_cmpint(ioctl(fds[1], TUNSETQUEUE, &ifr), ==, 0);
+
+    addr = guest_alloc(t_alloc, sizeof(cmd) + 1);
+    memwrite(addr, cmd, sizeof(cmd));
+    head = qvirtqueue_add(qts, vq, addr, sizeof(cmd), false, true);
+    qvirtqueue_add(qts, vq, addr + sizeof(cmd), 1, true, false);
+    qvirtqueue_kick(qts, net->vdev, vq, head);
+    qvirtio_wait_used_elem(qts, net->vdev, vq, head, NULL,
+                           QVIRTIO_NET_TIMEOUT_US);
+    g_assert_cmpint(readb(addr + sizeof(cmd)), ==, VIRTIO_NET_ERR);
+    guest_free(t_alloc, addr);
+}
+#endif /* CONFIG_LINUX */
+
 #endif /* _WIN32 */
 
 static void large_tx(void *obj, void *data, QGuestAllocator *t_alloc)
@@ -328,6 +425,13 @@ static void register_virtio_net_test(void)
     qos_add_test("basic", "virtio-net", send_recv_test, &opts);
     qos_add_test("rx_stop_cont", "virtio-net", stop_cont_test, &opts);
     qos_add_test("announce-self", "virtio-net", announce_self, &opts);
+#ifdef CONFIG_LINUX
+    opts.before = virtio_net_test_setup_tap;
+    opts.arg = GINT_TO_POINTER(2);
+    opts.edge.extra_device_opts = "mq=on";
+    qos_add_test("mq-tap-attach-fail", "virtio-net", mq_tap_attach_fail, &opts);
+    opts.edge.extra_device_opts = NULL;
+#endif
 #endif
 
     /* These tests do not need a loopback backend.  */

base-commit: 76fdb3373c9a27b3f50ecc9e012cbdeb90af7151
-- 
2.53.0



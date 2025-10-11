Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96310CCA476
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 23:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ixA-0006KV-Gj; Sat, 11 Oct 2025 19:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7ix9-0006KG-Fb
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:43 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7ix2-0000vM-Mk
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 19:24:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 40328C01DB;
 Sun, 12 Oct 2025 02:24:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6OWMXt1FjqM0-I8Sta8FG; Sun, 12 Oct 2025 02:24:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760225064;
 bh=mv1f7ZZ2zJbNKP6/QSP2QCtxNPErA8wy445npUZiAX8=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=JbTtPRckx7LXn+3mhOU1SNk1jyBQKG8AdqhzVnm8BTLu38RZ7wkgVPzGpSnlxWhkC
 pEZkPYFCsGH2tY2V/jsq8KsJbhSFanyn/uNMdoTFtbTXrv4LDDsp35w9qEOtx4QE71
 gHfW/MW0d6BFuv9GNz+tixU21fjOiKjvoGbLfEiM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 raphael.s.norwitz@gmail.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 21/23] vhost-user: make trace events more readable
Date: Sun, 12 Oct 2025 02:24:00 +0300
Message-ID: <20251011232404.561024-22-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011232404.561024-1-vsementsov@yandex-team.ru>
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/trace-events |  4 +-
 hw/virtio/vhost-user.c | 94 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 658cc365e7..aa1ffa5e94 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -25,8 +25,8 @@ vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_siz
 vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
 vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
 vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
-vhost_user_read(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
-vhost_user_write(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
+vhost_user_read(uint32_t req, const char *req_name, uint32_t flags) "req:%d (%s) flags:0x%"PRIx32""
+vhost_user_write(uint32_t req, const char *req_name, uint32_t flags) "req:%d (%s) flags:0x%"PRIx32""
 vhost_user_create_notifier(int idx, void *n) "idx:%d n:%p"
 
 # vhost-vdpa.c
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 23e7c12b16..e45b74eddd 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -119,6 +119,94 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
+static const char *vhost_req_name(VhostUserRequest req)
+{
+    switch (req) {
+    case VHOST_USER_NONE:
+        return "NONE";
+    case VHOST_USER_GET_FEATURES:
+        return "GET_FEATURES";
+    case VHOST_USER_SET_FEATURES:
+        return "SET_FEATURES";
+    case VHOST_USER_SET_OWNER:
+        return "SET_OWNER";
+    case VHOST_USER_RESET_OWNER:
+        return "RESET_OWNER";
+    case VHOST_USER_SET_MEM_TABLE:
+        return "SET_MEM_TABLE";
+    case VHOST_USER_SET_LOG_BASE:
+        return "SET_LOG_BASE";
+    case VHOST_USER_SET_LOG_FD:
+        return "SET_LOG_FD";
+    case VHOST_USER_SET_VRING_NUM:
+        return "SET_VRING_NUM";
+    case VHOST_USER_SET_VRING_ADDR:
+        return "SET_VRING_ADDR";
+    case VHOST_USER_SET_VRING_BASE:
+        return "SET_VRING_BASE";
+    case VHOST_USER_GET_VRING_BASE:
+        return "GET_VRING_BASE";
+    case VHOST_USER_SET_VRING_KICK:
+        return "SET_VRING_KICK";
+    case VHOST_USER_SET_VRING_CALL:
+        return "SET_VRING_CALL";
+    case VHOST_USER_SET_VRING_ERR:
+        return "SET_VRING_ERR";
+    case VHOST_USER_GET_PROTOCOL_FEATURES:
+        return "GET_PROTOCOL_FEATURES";
+    case VHOST_USER_SET_PROTOCOL_FEATURES:
+        return "SET_PROTOCOL_FEATURES";
+    case VHOST_USER_GET_QUEUE_NUM:
+        return "GET_QUEUE_NUM";
+    case VHOST_USER_SET_VRING_ENABLE:
+        return "SET_VRING_ENABLE";
+    case VHOST_USER_SEND_RARP:
+        return "SEND_RARP";
+    case VHOST_USER_NET_SET_MTU:
+        return "NET_SET_MTU";
+    case VHOST_USER_SET_BACKEND_REQ_FD:
+        return "SET_BACKEND_REQ_FD";
+    case VHOST_USER_IOTLB_MSG:
+        return "IOTLB_MSG";
+    case VHOST_USER_SET_VRING_ENDIAN:
+        return "SET_VRING_ENDIAN";
+    case VHOST_USER_GET_CONFIG:
+        return "GET_CONFIG";
+    case VHOST_USER_SET_CONFIG:
+        return "SET_CONFIG";
+    case VHOST_USER_CREATE_CRYPTO_SESSION:
+        return "CREATE_CRYPTO_SESSION";
+    case VHOST_USER_CLOSE_CRYPTO_SESSION:
+        return "CLOSE_CRYPTO_SESSION";
+    case VHOST_USER_POSTCOPY_ADVISE:
+        return "POSTCOPY_ADVISE";
+    case VHOST_USER_POSTCOPY_LISTEN:
+        return "POSTCOPY_LISTEN";
+    case VHOST_USER_POSTCOPY_END:
+        return "POSTCOPY_END";
+    case VHOST_USER_GET_INFLIGHT_FD:
+        return "GET_INFLIGHT_FD";
+    case VHOST_USER_SET_INFLIGHT_FD:
+        return "SET_INFLIGHT_FD";
+    case VHOST_USER_GPU_SET_SOCKET:
+        return "GPU_SET_SOCKET";
+    case VHOST_USER_RESET_DEVICE:
+        return "RESET_DEVICE";
+    case VHOST_USER_GET_MAX_MEM_SLOTS:
+        return "GET_MAX_MEM_SLOTS";
+    case VHOST_USER_ADD_MEM_REG:
+        return "ADD_MEM_REG";
+    case VHOST_USER_REM_MEM_REG:
+        return "REM_MEM_REG";
+    case VHOST_USER_SET_STATUS:
+        return "SET_STATUS";
+    case VHOST_USER_GET_STATUS:
+        return "GET_STATUS";
+    default:
+        return "<unknown>";
+    }
+}
+
 typedef struct VhostUserMemoryRegion {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
@@ -311,7 +399,8 @@ static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
         return -EPROTO;
     }
 
-    trace_vhost_user_read(msg->hdr.request, msg->hdr.flags);
+    trace_vhost_user_read(msg->hdr.request,
+                          vhost_req_name(msg->hdr.request), msg->hdr.flags);
 
     return 0;
 }
@@ -431,7 +520,8 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
         return ret < 0 ? -saved_errno : -EIO;
     }
 
-    trace_vhost_user_write(msg->hdr.request, msg->hdr.flags);
+    trace_vhost_user_write(msg->hdr.request, vhost_req_name(msg->hdr.request),
+                           msg->hdr.flags);
 
     return 0;
 }
-- 
2.48.1



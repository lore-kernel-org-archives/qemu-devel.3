Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52003CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7Zo-0004Ep-8l; Wed, 27 May 2026 02:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZW-00042X-F5
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:55 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS7ZP-0004Ay-Tf
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:16:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 21F1BC01F0;
 Wed, 27 May 2026 09:16:46 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QGSCNG0ZtGk0-QsKZ4p08; Wed, 27 May 2026 09:16:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779862605;
 bh=dU9wUhXlCE3BAJRpC9u2OYkNwoLoZDEIRrhVKwfUBGc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=B1vuMp75BPo2ZdEt2LJHHKqfbFO1jtHdNjY8g+HGJQQvRi94Qs2YK/HKA35m8RYNR
 yLd7IECKYtUsLqlSxungw08TEslQ94zktQmNDik7cNpAIBDnzIckd7bmcqyoTlvsUv
 F2Zm5SVXW64cRdBFUMsm4tcTXDKksk+qIPmwqJvA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v7 20/22] vhost-user: make trace events more readable
Date: Wed, 27 May 2026 09:16:21 +0300
Message-ID: <20260527061625.11167-21-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527061625.11167-1-vsementsov@yandex-team.ru>
References: <20260527061625.11167-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/trace-events |  4 +--
 hw/virtio/vhost-user.c | 63 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 658cc365e70..aa1ffa5e949 100644
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
index 31eaf65430e..4fb136b7b37 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -114,6 +114,63 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
+#define VHOST_USER_CASE(name) \
+    case VHOST_USER_##name: \
+        return #name;
+
+static const char *vhost_req_name(VhostUserRequest req)
+{
+    switch (req) {
+    VHOST_USER_CASE(NONE)
+    VHOST_USER_CASE(GET_FEATURES)
+    VHOST_USER_CASE(SET_FEATURES)
+    VHOST_USER_CASE(SET_OWNER)
+    VHOST_USER_CASE(RESET_OWNER)
+    VHOST_USER_CASE(SET_MEM_TABLE)
+    VHOST_USER_CASE(SET_LOG_BASE)
+    VHOST_USER_CASE(SET_LOG_FD)
+    VHOST_USER_CASE(SET_VRING_NUM)
+    VHOST_USER_CASE(SET_VRING_ADDR)
+    VHOST_USER_CASE(SET_VRING_BASE)
+    VHOST_USER_CASE(GET_VRING_BASE)
+    VHOST_USER_CASE(SET_VRING_KICK)
+    VHOST_USER_CASE(SET_VRING_CALL)
+    VHOST_USER_CASE(SET_VRING_ERR)
+    VHOST_USER_CASE(GET_PROTOCOL_FEATURES)
+    VHOST_USER_CASE(SET_PROTOCOL_FEATURES)
+    VHOST_USER_CASE(GET_QUEUE_NUM)
+    VHOST_USER_CASE(SET_VRING_ENABLE)
+    VHOST_USER_CASE(SEND_RARP)
+    VHOST_USER_CASE(NET_SET_MTU)
+    VHOST_USER_CASE(SET_BACKEND_REQ_FD)
+    VHOST_USER_CASE(IOTLB_MSG)
+    VHOST_USER_CASE(SET_VRING_ENDIAN)
+    VHOST_USER_CASE(GET_CONFIG)
+    VHOST_USER_CASE(SET_CONFIG)
+    VHOST_USER_CASE(CREATE_CRYPTO_SESSION)
+    VHOST_USER_CASE(CLOSE_CRYPTO_SESSION)
+    VHOST_USER_CASE(POSTCOPY_ADVISE)
+    VHOST_USER_CASE(POSTCOPY_LISTEN)
+    VHOST_USER_CASE(POSTCOPY_END)
+    VHOST_USER_CASE(GET_INFLIGHT_FD)
+    VHOST_USER_CASE(SET_INFLIGHT_FD)
+    VHOST_USER_CASE(GPU_SET_SOCKET)
+    VHOST_USER_CASE(RESET_DEVICE)
+    VHOST_USER_CASE(GET_MAX_MEM_SLOTS)
+    VHOST_USER_CASE(ADD_MEM_REG)
+    VHOST_USER_CASE(REM_MEM_REG)
+    VHOST_USER_CASE(SET_STATUS)
+    VHOST_USER_CASE(GET_STATUS)
+    VHOST_USER_CASE(GET_SHARED_OBJECT)
+    VHOST_USER_CASE(SET_DEVICE_STATE_FD)
+    VHOST_USER_CASE(CHECK_DEVICE_STATE)
+    default:
+        return "<unknown>";
+    }
+}
+
+#undef VHOST_USER_CASE
+
 typedef struct VhostUserMemoryRegion {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
@@ -308,7 +365,8 @@ static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
         return -EPROTO;
     }
 
-    trace_vhost_user_read(msg->hdr.request, msg->hdr.flags);
+    trace_vhost_user_read(msg->hdr.request,
+                          vhost_req_name(msg->hdr.request), msg->hdr.flags);
 
     return 0;
 }
@@ -428,7 +486,8 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
         return ret < 0 ? -saved_errno : -EIO;
     }
 
-    trace_vhost_user_write(msg->hdr.request, msg->hdr.flags);
+    trace_vhost_user_write(msg->hdr.request, vhost_req_name(msg->hdr.request),
+                           msg->hdr.flags);
 
     return 0;
 }
-- 
2.52.0



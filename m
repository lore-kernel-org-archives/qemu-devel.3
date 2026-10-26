Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB360606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=VwPXlt6m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOib-0004ty-2T; Mon, 26 Oct 2026 13:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiQ-0004j1-OT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xLOiN-0001Yg-RE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:42:34 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1487184f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793036549; x=1793641349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uZn/EMqMa666UPeFWQz50HZmUfGIOQIWKT3RRdEEDHo=;
 b=VwPXlt6mCWHpdO5O1SStP8bkfmhdoV7i+HLgLiElU/lEK15EjfFVRyOiH+7dhQdUcs
 AjxgAYUD+6oOUZQCWtTrCr+Y7+Zb3Fted06vuyFMh9uU+7JUPdPgAf/dNw7diZ2BE/jm
 i1QUonA8mIgfyg+KjOsPUjjDGuC+zdb4t1rl/JLxjqrQ43Adew5O8gcMsZ+cDLmdS5Xt
 LfRM/28NbCZQnkUMoboYenINQTRRg+w8EghxwEvneW7gAdPF11xoFan+Q9dbbr/Z+Ort
 OMWL+we8K7yXqn0+nFHVDn2uIseD/4t7oWcc5ODjs+gky0Eugm3JaAZhN1OHWJUciMCU
 Qo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793036549; x=1793641349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uZn/EMqMa666UPeFWQz50HZmUfGIOQIWKT3RRdEEDHo=;
 b=l9a0IOhAB6AFE2FZ/hm0UtToEZ4WnJT2rflVUVc6vXKXY2YESFmD9uwPnWSv8gpth9
 ndqhFq2Bzt1DZrg9EJ5oBq39/sWc1+eOYHFqMJcxgDdg/1KR6NAiRZ+1Q2v+GSCDtU+S
 xObZ1r5jxn0rPes2PtNV1GsmyEgM/jWiSqyDiUbhoqbw1fP8qmdUfEXprfhnNb2703vZ
 w+wr8h6SunYlN96a25vTJKBlwu2j4TT52NUwNwcvEfK5ZKv667p6qMWuvZNJGIS3iyW5
 +2noGFkAdwpNKglrzmO+7c+eZu6Y14gZhhwwyVgfMvc71rz6pjpkzh1FHoZ1skJjTPoD
 H07A==
X-Gm-Message-State: AFq9FYKvSqJsCSPqcZ4Kobps+6J1XMwKXHJ+BprpqVsDTqx8L/uD1AQN
 xTLu7zgxbliX4a+88dalueoaevb00LxZUnzAwMsIv73tzrCGQUkEhK69eVXMmYKxaTQ+DzSOOgd
 4Pk15
X-Gm-Gg: AYBFou2txOfUhkOsyXnmJgKxOk3JmENVhtobWar7hdQTXhq3W2o+UCImu7criB+hUGZ
 jjSbEY2+WIC7S/IQGIXeJBAn/fUwym/dLWkL+OWoAnaIQqgjNFJukanUrOnMK+MASAmfT0pkM8J
 kOAaXYv5z/6JaGQzRWEZOT8+y95MWvwg2EOBTr2tcpy6fjxXYOW638WCMq4RC7HHfv4ODPBfIDU
 MWYsjwK/HRHSs3IBVH4d9McawD+j6xB/s67Jzze5xWWJCF3Pxn/1ytNup1Fq88u1mOlXv2StP++
 VJSM5nPhJrQ1mQ/V2sKscUQJeKoY/tM4FidVYkLnpyijxE98S81FuaOqaP5IwDjK2/bXA0bIwjj
 qr5bry+A7QPoH/jA8Vi+vdkb8T/C720vi2HBQwi8QVGVqRz8zXyyNbqNMcoyQWKhychkhF/+zAu
 iZ+tUPZOdUOrcCHqJqxjcaYRr7aPcOm9kmbzXA7lI6oB+4R1JUZtDr2FmvfmwWGrswxM+LWW3l+
 Xjv7dMq14rcud6LvGOG2kLjhM4zEbm1y9fWZhd9rmlqja32MuY=
X-Received: by 2002:a5d:43ce:0:b0:48c:77ad:d52d with SMTP id
 ffacd0b85a97d-48e3eb9fdfcmr10590615f8f.43.1793036548977; 
 Mon, 26 Oct 2026 10:42:28 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1a6:7f7f:f573:ba9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm16169111f8f.22.2026.10.26.10.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:42:28 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 4/5] virtio-scsi-test: split virtio_scsi_do_command() into
 submit and wait
Date: Mon, 26 Oct 2026 18:42:18 +0100
Message-ID: <20261026174220.674460-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026174220.674460-1-den@openvz.org>
References: <20261026174220.674460-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=den@openvz.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add virtio_scsi_submit_command() and virtio_scsi_wait_command() so that
a test can act on the device while a command is still in flight.
virtio_scsi_do_command() becomes a wrapper around the two and its
callers are unchanged.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
---
 tests/qtest/virtio-scsi-test.c | 85 +++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/tests/qtest/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
index e2350c52f6..40f1d569d8 100644
--- a/tests/qtest/virtio-scsi-test.c
+++ b/tests/qtest/virtio-scsi-test.c
@@ -59,22 +59,28 @@ static uint64_t qvirtio_scsi_alloc(QVirtioSCSIQueues *vs, size_t alloc_size,
     return addr;
 }
 
-static uint8_t virtio_scsi_do_command(QVirtioSCSIQueues *vs,
-                                      const uint8_t *cdb,
-                                      const uint8_t *data_in,
-                                      size_t data_in_len,
-                                      uint8_t *data_out, size_t data_out_len,
-                                      struct virtio_scsi_cmd_resp *resp_out)
+typedef struct {
+    uint32_t free_head;
+    uint64_t req_addr;
+    uint64_t resp_addr;
+    uint64_t data_in_addr;
+    uint64_t data_out_addr;
+} VirtioSCSICmd;
+
+static void virtio_scsi_submit_command(QVirtioSCSIQueues *vs,
+                                       const uint8_t *cdb,
+                                       const uint8_t *data_in,
+                                       size_t data_in_len,
+                                       uint8_t *data_out, size_t data_out_len,
+                                       VirtioSCSICmd *cmd)
 {
     QVirtQueue *vq;
     struct virtio_scsi_cmd_req req = { { 0 } };
     struct virtio_scsi_cmd_resp resp = { .response = 0xff, .status = 0xff };
-    uint64_t req_addr, resp_addr, data_in_addr = 0, data_out_addr = 0;
-    uint8_t response;
-    uint32_t free_head;
     QTestState *qts = global_qtest;
 
     vq = vs->vq[2];
+    *cmd = (VirtioSCSICmd) { 0 };
 
     req.lun[0] = 1; /* Select LUN */
     req.lun[1] = 1; /* Select target 1 */
@@ -83,41 +89,68 @@ static uint8_t virtio_scsi_do_command(QVirtioSCSIQueues *vs,
     /* XXX: Fix endian if any multi-byte field in req/resp is used */
 
     /* Add request header */
-    req_addr = qvirtio_scsi_alloc(vs, sizeof(req), &req);
-    free_head = qvirtqueue_add(qts, vq, req_addr, sizeof(req), false, true);
+    cmd->req_addr = qvirtio_scsi_alloc(vs, sizeof(req), &req);
+    cmd->free_head = qvirtqueue_add(qts, vq, cmd->req_addr, sizeof(req),
+                                    false, true);
 
     if (data_out_len) {
-        data_out_addr = qvirtio_scsi_alloc(vs, data_out_len, data_out);
-        qvirtqueue_add(qts, vq, data_out_addr, data_out_len, false, true);
+        cmd->data_out_addr = qvirtio_scsi_alloc(vs, data_out_len, data_out);
+        qvirtqueue_add(qts, vq, cmd->data_out_addr, data_out_len, false, true);
     }
 
     /* Add response header */
-    resp_addr = qvirtio_scsi_alloc(vs, sizeof(resp), &resp);
-    qvirtqueue_add(qts, vq, resp_addr, sizeof(resp), true, !!data_in_len);
+    cmd->resp_addr = qvirtio_scsi_alloc(vs, sizeof(resp), &resp);
+    qvirtqueue_add(qts, vq, cmd->resp_addr, sizeof(resp), true,
+                   !!data_in_len);
 
     if (data_in_len) {
-        data_in_addr = qvirtio_scsi_alloc(vs, data_in_len, data_in);
-        qvirtqueue_add(qts, vq, data_in_addr, data_in_len, true, false);
+        cmd->data_in_addr = qvirtio_scsi_alloc(vs, data_in_len, data_in);
+        qvirtqueue_add(qts, vq, cmd->data_in_addr, data_in_len, true, false);
     }
 
-    qvirtqueue_kick(qts, vs->dev, vq, free_head);
-    qvirtio_wait_used_elem(qts, vs->dev, vq, free_head, NULL,
-                           QVIRTIO_SCSI_TIMEOUT_US);
+    qvirtqueue_kick(qts, vs->dev, vq, cmd->free_head);
+}
+
+static uint8_t virtio_scsi_wait_command(QVirtioSCSIQueues *vs,
+                                        VirtioSCSICmd *cmd,
+                                        struct virtio_scsi_cmd_resp *resp_out,
+                                        gint64 timeout_us)
+{
+    uint8_t response;
+    QTestState *qts = global_qtest;
+
+    qvirtio_wait_used_elem(qts, vs->dev, vs->vq[2], cmd->free_head, NULL,
+                           timeout_us);
 
-    response = readb(resp_addr +
+    response = readb(cmd->resp_addr +
                      offsetof(struct virtio_scsi_cmd_resp, response));
 
     if (resp_out) {
-        memread(resp_addr, resp_out, sizeof(*resp_out));
+        memread(cmd->resp_addr, resp_out, sizeof(*resp_out));
     }
 
-    guest_free(alloc, req_addr);
-    guest_free(alloc, resp_addr);
-    guest_free(alloc, data_in_addr);
-    guest_free(alloc, data_out_addr);
+    guest_free(alloc, cmd->req_addr);
+    guest_free(alloc, cmd->resp_addr);
+    guest_free(alloc, cmd->data_in_addr);
+    guest_free(alloc, cmd->data_out_addr);
     return response;
 }
 
+static uint8_t virtio_scsi_do_command(QVirtioSCSIQueues *vs,
+                                      const uint8_t *cdb,
+                                      const uint8_t *data_in,
+                                      size_t data_in_len,
+                                      uint8_t *data_out, size_t data_out_len,
+                                      struct virtio_scsi_cmd_resp *resp_out)
+{
+    VirtioSCSICmd cmd;
+
+    virtio_scsi_submit_command(vs, cdb, data_in, data_in_len,
+                               data_out, data_out_len, &cmd);
+    return virtio_scsi_wait_command(vs, &cmd, resp_out,
+                                    QVIRTIO_SCSI_TIMEOUT_US);
+}
+
 static QVirtioSCSIQueues *qvirtio_scsi_init(QVirtioDevice *dev)
 {
     QVirtioSCSIQueues *vs;
-- 
2.53.0



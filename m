Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C854CE7A8E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 09:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJqGG-0005KK-Fr; Fri, 14 Nov 2025 04:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>) id 1vJqGE-0005K7-EC
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:38:30 -0500
Received: from xmbghk7.mail.qq.com ([43.163.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yfliu2008@qq.com>) id 1vJqGB-0001Jg-BE
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 04:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1763113101; bh=yFmgW3/NHzvyuVAr5Qr73wDI5PMEeyjibflL2bj7sYw=;
 h=From:To:Cc:Subject:Date;
 b=AvHql7cZC0F1YV6+YWmesCHItzXKgFvM282JH7PXH4iATnZ9c7R2AJtzQDoNFG2rx
 OBDa7uf34DlJJmgVDC5kBHG5UP9Pnzaq6Rn0lsWgGYrZWCOpSXvt85cnvd1drD0Hbx
 1WPGFCy+Pxs5Woo4XLQ06HBVPYjCRgdHuf7PWYNk=
Received: from qq.com ([221.237.17.17])
 by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
 id 8C5B3284; Fri, 14 Nov 2025 17:35:05 +0800
X-QQ-mid: xmsmtpt1763112905t96mp5p53
Message-ID: <tencent_66E8C146EA79CD00E966DEDAEF8CACD97D05@qq.com>
X-QQ-XMAILINFO: NoN45VbJ/ow6YPboy+1tvz//+LBJFXPTjPioxTL2Zc3mJsK/mmbYq2Yj/XO7O2
 Xh7/mxVxwngBzaa/x1H+8iHWKcNKCx7XD5SJ5tWk41gNn54iy9w/fiW87ZuSoHeXqHBIORXuXtdZ
 3N2CiNT2HIML6xStg1/5LL1DgJe/NE/jUIV6FLsI4m3Kv7ZhuhXWZ6GERvaicVs3UhSyGI8BbeC7
 TsD0J/H0qp/Lpyl9hhnzHVKHdLx1mW0txmCLppYpSMOWJ0b977QxH8PE66fiY/yNA28VCEmgvdte
 ZJMtuu4yPa5F7Z8ps9l3WW6iPkcpSsalsNPUVB29VO4FNmAC+LZdaycxXF1CwNMIPoRDpGZ8ry9S
 Dcp5UTrnXcL4WBjFrTPxmGywycsa1d7dpe4jM8NgUfe5dIFfXsdlXEMFe+0lKOjdu+XLDeF2SDdd
 43aTBARfAJBjDUtug6q2ew1j9deAG/JSgeYk2UTZtih2MkzYnHztamiDZQKub/+wJihdK2yiyFCG
 PM0IvTQqKKD51IarCV2bpcwjnH6995WEEcmGyAElREzsOHQF2DDt4ajqvlcWh+uJs4jN5UL4sIME
 Nw9ebkeggHLrjzy+A494XWt+OfRylXkPamEmIq3gumG2yXT6f/pByvDnWvJy6QWT5/YQCSLc6W4S
 QGbOG+qV7adyvBxHeDsg1B75RKz8mOkVvgYLUjtG0Rvz4vG/i6bkfAA2Ba86C36CY6V8iENG8JfE
 chARnwLX8dD3UOQU2k6AgXLUylw86DcXtrS4bTygudU2bIqp59VpCZ7oSjsKv4hKgAdQcz8k4Nk5
 nDQHEb21/NzC2J9uOYU8DAS2LT/n66hwb3RKo74JlMtLLyO9C7Y4CEEFtCwSKZQJxcKP8Dz33Snf
 Bu+sQ8yJwbthG5U6gf2iFYV0lAJpQX7kFudJefoWL5RxIuUz7jZplQSvvYsK+Q2OBvNrbp+Pd6gT
 kwcPq7RN9t/5J7yIGhJzG+ioARDFnb0S1j7QOY2JqRiAL4/VRxwfw2WE0lce85Po09CauVmwsbnM
 2jUhXnYA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yanfeng Liu <yfliu2008@qq.com>
To: kraxel@redhat.com,
	manos.pitsidianakis@linaro.org,
	mst@redhat.com
Cc: qemu-devel@nongnu.org, Yanfeng Liu <yfliu2008@qq.com>,
 Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
Subject: [PATCH v1] audio/virtio-snd: fix latency calc
Date: Fri, 14 Nov 2025 17:34:46 +0800
X-OQ-MSGID: <20251114093446.115990-1-yfliu2008@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=43.163.128.47; envelope-from=yfliu2008@qq.com;
 helo=xmbghk7.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Media players needs meaningful latency_bytes update but it is
zero now most of the time. This adds stream-wise latency_bytes
calculation so that to improve the situation.

Signed-off-by: Yanfeng Liu <p-liuyanfeng9@xiaomi.com>
---
 hw/audio/virtio-snd.c         | 12 +++++++++++-
 include/hw/audio/virtio-snd.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 9101560f38..ed0422b45a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -431,6 +431,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream->id = stream_id;
         stream->pcm = s->pcm;
         stream->s = s;
+        stream->latency_bytes = 0;
         qemu_mutex_init(&stream->queue_mutex);
         QSIMPLEQ_INIT(&stream->queue);
 
@@ -899,6 +900,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
             buffer->vq = vq;
             buffer->size = size;
             buffer->offset = 0;
+            stream->latency_bytes += size;
 
             QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
         }
@@ -1112,12 +1114,19 @@ error_cleanup:
     virtio_snd_unrealize(dev);
 }
 
+static inline void update_latency(VirtIOSoundPCMStream *s, size_t used)
+{
+    s->latency_bytes = s->latency_bytes > used ?
+                       s->latency_bytes - used : 0;
+}
+
 static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
                                     VirtIOSoundPCMBuffer *buffer)
 {
     virtio_snd_pcm_status resp = { 0 };
     resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
-    resp.latency_bytes = cpu_to_le32((uint32_t)buffer->size);
+    update_latency(stream, buffer->size);
+    resp.latency_bytes = cpu_to_le32(stream->latency_bytes);
     iov_from_buf(buffer->elem->in_sg,
                  buffer->elem->in_num,
                  0,
@@ -1178,6 +1187,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
                 buffer->size -= size;
                 buffer->offset += size;
                 available -= size;
+                update_latency(stream, size);
                 if (buffer->size < 1) {
                     return_tx_buffer(stream, buffer);
                     break;
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index c176066584..9560bac8b1 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -150,6 +150,7 @@ struct VirtIOSoundPCMStream {
     } voice;
     QemuMutex queue_mutex;
     bool active;
+    uint32_t latency_bytes;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
 };
 
-- 
2.34.1



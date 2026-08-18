Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FA6C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC7q-0005AS-2V; Tue, 18 Aug 2026 01:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7o-0005A4-70
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:36 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7k-0003kc-4p
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so576408b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029950; x=1787634750; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SplFjpyfUIiEmMlzq9z3b58IchCXTHYO6ngIxMF/AIo=;
 b=mSC4cpH5+jIFd1KpNZb7A9CEA/tZ0WF3De8+XO5uD4Z/L12BKRzYpKDiqnm66NWlQa
 7ghYh+oy8qhw3X9V3Bi3ije3osu5DaUgq2bj0vX6txyr7V58G+2Z7VoF5YexJ74uMKxA
 NNrcviEV38oAkX9m4Xiic1q9vytoC7UbChrAfVI3ZSi3ZyCRW5KgoTCND2du54wuGbdR
 y5YhI1BIL6mDypCP+BZtEfTrzWL9SXh+Ajnv4oi0HMJTRRFhNY0wqrXnTddaOLU/6Tex
 ZsqdtHH00Mmt8ABfqAxpVwfFsDqw52L/wA8y9/22/zeDM0UMlpV3Tm7FnsEIhZqACfL8
 4J/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029950; x=1787634750;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SplFjpyfUIiEmMlzq9z3b58IchCXTHYO6ngIxMF/AIo=;
 b=dk2PgeOztSXNi/gSN5cmf7oZuaPxwpkscnfci52N3tLviIXy+LakxggRt8UOae3Yds
 +ybbHInfIo89E9njPsRmYIKHROb5uTBPNseZ74SfvfF3Ma7fnotJfcdZW6zXgnyT86In
 2Jl17xac0Etjcvln+VkePZMYCVqsUOgmMpAZBpp/l3fb7fsVeUmym8FIBFqucF+RwX3A
 /Hk4D8ZgBEImdw3nuJrt1a8NIzE3FHIrJQN5nXqD2wFH/Eb2DztPw3i/Hdv1V/Uuv08l
 6F/xY2cmFaZ8aMoRKYBzmKg+Zpwz1u/JWHeJJrwN6ppqBvBFQeAC3cgPNjbzqe8lyts0
 qMpQ==
X-Gm-Message-State: AOJu0YwQGiUZiJP7PqCaWyQelwZ3Zk2n/1aMZn6pdgjbzeDpZZGor0Ew
 zxAbvC6t0RrQ23DkRwTcXKTagka3uHmow4XUwngIBjBlI78iLwe+vuXN
X-Gm-Gg: AR+sD11oMTw0wsfZGo5ZKPOdPnNO82JygSC7Ktulm/C681F5pVUXBLvkR0RpiVszYiL
 VBm4O/pMA69CdLCTnrBC/8WcaUb4Kih2MUG0s9FsWqtxlT6Wnsu2UCLHRzzjohB2wz7e2kA/dRu
 xP0MmtY/VCdXpCre4ub/71v9LWV1jT4Z6bMH2akBYTgTyRb4pC2UdzgH0WCo6zWnIm1rLr7cSeD
 2/kvL1bF5rIboZLPI7//yyXMlQ95yw3eIwo8ce/sbkVRqGtAKT23GE/oqsOgStDTI+ERjSTb2Tc
 LodtqXK5IFa1QpBAMn0UoX4dqpzc+w3P7oM8bmHxSuVL6AmkNUD6fJtR55TR0iq87ra5+XFm5xp
 vJJ0lHR+PJbfgp4yveITeLMn4BXMRg6mx9/K9XpsZqXYfQ26Akz7OBo9Z6gt+wEoX5OMhx9+YuB
 NtUb+dN93CE9E1MGZDtM+zw8ebYhrQZy1/PWINvNFemvYwAbcGNYRiY1pQsJCtGKSYV2lxa7sX7
 Mqe
X-Received: by 2002:a05:6a21:3a96:b0:3bf:bbad:500e with SMTP id
 adf61e73a8af0-3cce24fc3bamr3353906637.5.1787029950143; 
 Mon, 17 Aug 2026 22:12:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:29 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:19 -0700
Subject: [PATCH RFC v2 04/13] hw/virtio/vhost-shadow-virtqueue: used callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-4-948aae960abb@gmail.com>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
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
 Connor Kite <connorkite@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=2434;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=HH0SlSvH+q+3nGir6vgptvnX9Dx9KLnOIY0C19/JvF0=;
 b=4pu5D0cnp4xmAOKz3RDWU/Xos+GwI2mPfbnmu6yDH3gb9L0MxXGupZxCloz5NW3k23uRSdoVi
 DOmLtpxDokJB5SnhdWlEtuB9sI0MvC9+Jv6t5oUtBm8+S/MOO015cy3
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=connorkite@gmail.com; helo=mail-pf1-x430.google.com
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

Adds a callback to shadow virtqueues in order to enable
non-default processing of used vring elements from the device.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-shadow-virtqueue.c |  9 +++++++++
 hw/virtio/vhost-shadow-virtqueue.h | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index c8831d52be..496e7e58a3 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -675,6 +675,15 @@ static void vhost_svq_flush(VhostShadowVirtqueue *svq,
                 break;
             }
 
+            if (svq->ops && svq->ops->used_callback) {
+                int r = svq->ops->used_callback(svq, elem, svq->ops_opaque);
+
+                if (r < 0) {
+                    /* VQ or handler is broken. Do not set guest notifier */
+                    return;
+                }
+            }
+
             if (unlikely(i >= svq->vring.num)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                          "More than %u used buffers obtained in a %u size SVQ",
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index ec16a1e838..fd68319fb7 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -56,8 +56,24 @@ typedef int (*VirtQueueAvailCallback)(VhostShadowVirtqueue *svq,
                                       VirtQueueElement *elem,
                                       void *vq_callback_opaque);
 
+/**
+ * Callback to handle a used buffer
+ *
+ * @svq: Shadow virtqueue
+ * @elem: Element placed in the queue by the device
+ * @vq_callback_opaque: Used to pass arguments to callback
+ *
+ * Returns 0 if the vq is running as expected. Returns a negative errno on
+ * failure.  The callback should not add used elements to the vq shadowed
+ * by the svq as that is done separately after the callback returns.
+ */
+typedef int (*VirtQueueUsedCallback)(VhostShadowVirtqueue *svq,
+                                      VirtQueueElement *elem,
+                                      void *vq_callback_opaque);
+
 typedef struct VhostShadowVirtqueueOps {
     VirtQueueAvailCallback avail_handler;
+    VirtQueueUsedCallback used_callback;
 } VhostShadowVirtqueueOps;
 
 /* Shadow virtqueue to relay notifications */

-- 
2.43.0



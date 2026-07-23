Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C16C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1wl-0004u1-4u; Thu, 23 Jul 2026 18:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1wh-0004qu-FJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:15 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wn1we-0001Sg-UD
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 18:31:15 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81ea0b7d137so7036457b3.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784845872; x=1785450672; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ylndD1RfSjtAui3jJeAFAbrXgRT2PYj5papIJW82wSE=;
 b=IX4yY04mMDb9HDofWBog6hBtvAA6SxwunYrqTyBo/yRfxp+ut/hWWIldUkISyIiGtn
 minZPTzpyX/6iG8Ijp0vYb2IUipxlJDMo+4MfFZEpax6KLZ792onnVoqDtOeaD1iJGRZ
 lHCHnib427xxdmcxVwzIu4AC3t+MrSzBxxH6tOxMO5J+90mCBHpxFdbelUFdmmXQwJSB
 HxduME+0dSouLeF9+mAaCnuwNQda4pww2xF5txhyQxWpDeGHNaeJqzjaKkhL0g8xVgp9
 iwrmFSvj+EFPMxpyUh52+FIhtZQyPMhM+FqsFqEwnRCW+c4SILHxjRozgq/s9SsNerh6
 aPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784845872; x=1785450672;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ylndD1RfSjtAui3jJeAFAbrXgRT2PYj5papIJW82wSE=;
 b=LeIE7tNffQT2SAyE9V1bcrlDOS7VktfNH+B2XphLbS7oaq4d2U3wFzeKKsaL61KmOp
 AEfVAJ90UEd2kO4Nu3WsIq5Dh/OOMUAJn3QF+XsfFsMbZbRyoyTmjdHp0GE7GGdWMnnl
 FJ9A6txC+zdE6bG7hGsJ5QgzH2UsasDv3HBitqOQjqG087rieqxoLaWg7xdZrcBPAPLv
 89ZjKgqJG3s99qnmrz4+N70fzVLmxdunxRB5dPnaaIlAkEwxBPKMuykXt+2RH+D9RbL3
 +Hxbe5l++Bk2bh8hcBfnuF7j2N0rpDx8kARKaZcV/Unsx0Vos08AFQGwpajVKhe4rFTo
 sIww==
X-Gm-Message-State: AOJu0Yyrsjs+bB8WUX1NMlJ4FAbPfkMz6HVylXrAJNrPTSUjILbKJpjv
 eABGsfvkbzamSUdBwFh+wUyLf+EBj63EuyE7yx6keusAqNT5ystcDLNr
X-Gm-Gg: AR+sD12p8fNEEY+mlhaXD816w66FB1IBY9KuSjt0hAJtA4WGPQkI4d922gZ2wUMtaWm
 evvAPYA0PJQa/fXULQ5rt2YTQplB3B7EdId5TnifM5k2jpn/dY4FjDWJ7gbAwbtvw4hyoHQVCVx
 cG7SCxD+uReoidXCoiMacjykgTxEYFiSK2yRWdoHjacM6uu89b/OHvIV13uc2pYItrno8b9AM7C
 Hb8gUtm+v8Nm2cXekJkJ0CVMgvdCjUtstUM5ZyEbBcyQP/ux8LEBT16hfexUBiqZBjnuU8FrbvA
 fTwnv3qLIu9qyTr6EYYpBbKnfWu6a5VQmDc0kXQd7Hzn7GisgouXpLSopg/pEmjdYCu43Z3ddXq
 Z+YFSw0GUtn/Xn087x8OBBFMfwvVTELsWM067qdkLcurpBDKMYTDvzEICwjgNL4lFMsb343l+pr
 +Nox4R0rXAz8yaFm1bLw==
X-Received: by 2002:a05:690c:4b0d:b0:81c:c77b:3546 with SMTP id
 00721157ae682-81f4c20e739mr14265437b3.21.1784845871777; 
 Thu, 23 Jul 2026 15:31:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:446f:49ff:37bd:d45a])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33c3c1c5sm35766777b3.17.2026.07.23.15.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 15:31:11 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 23 Jul 2026 15:30:07 -0700
Subject: [PATCH RFC 08/15] hw/virtio/vhost-shadow-virtqueue: used handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-vhost-user-isolated-memory-v1-8-6b97c439eb28@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784845839; l=2085;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=BA6x/hUTVMBTeCNDEULOcGlNa3xXcwfyjSTX82F/bvE=;
 b=7VfH4IA82HBRppUZ24zMa8oz1EFKQW87j2JcXhb+DAvu5J9rymFlCfor8xdKNfIFK5cl2i6Ds
 uyK7/eO1cXHDFKikVsmgO5gLq1g741DLSV+rBgLH3+eJYxsNttpni4o
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x112d.google.com
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

Adds a handler callback to shadow virtqueues in order to enable
non-default processing of used vring elements from the device.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-shadow-virtqueue.c |  4 ++++
 hw/virtio/vhost-shadow-virtqueue.h | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index bcb7f2ffc7..eb86c1ee37 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -669,6 +669,10 @@ static void vhost_svq_flush(VhostShadowVirtqueue *svq,
                 break;
             }
 
+            if (svq->ops && svq->ops->used_handler) {
+                svq->ops->used_handler(svq, elem, svq->ops_opaque);
+            }
+
             if (unlikely(i >= svq->vring.num)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                          "More than %u used buffers obtained in a %u size SVQ",
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index ec16a1e838..ccfeee36d7 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -56,8 +56,22 @@ typedef int (*VirtQueueAvailCallback)(VhostShadowVirtqueue *svq,
                                       VirtQueueElement *elem,
                                       void *vq_callback_opaque);
 
+/**
+ * Callback to handle a used buffer
+ *
+ * @svq: Shadow virtqueue
+ * @elem: Element placed in the queue by the device
+ * @vq_callback_opaque: Used to pass arguments to callback
+ *
+ * Returns 0 if the vq is running as expected
+ */
+typedef int (*VirtQueueUsedCallback)(VhostShadowVirtqueue *svq,
+                                      VirtQueueElement *elem,
+                                      void *vq_callback_opaque);
+
 typedef struct VhostShadowVirtqueueOps {
     VirtQueueAvailCallback avail_handler;
+    VirtQueueUsedCallback used_handler;
 } VhostShadowVirtqueueOps;
 
 /* Shadow virtqueue to relay notifications */

-- 
2.43.0



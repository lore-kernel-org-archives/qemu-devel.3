Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08433606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zdYGM7XO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkgG-0001Tm-2i; Fri, 30 Oct 2026 07:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfy-0001M5-HC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:39 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfw-0002lR-Lx
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so485332f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793359295; x=1793964095; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OKx3WZoWzdD1zHUS1BNUvEzkmCP6IQtxBC0V6HuRO1M=;
 b=zdYGM7XOB01AoZTtP+NckydOJxGTLCNikYTKdHnO1q+IapTgTJDTyN21DbqpOa+aJW
 gku8gfn1IfCkIRS4mpIbgmlRKHFjmkVlLh8Rb0KDmHhgb3mObsP2lslkv9iHS4W0c2/T
 obmryozoWwNBOJXYKft2olY84lFfNAaIHpMUooyOXkvWuPuFJmZ3Eul3S2TKL6QUvAnY
 9h7Q5VkVIh73TuIqYeyqsE5ch9QwS2Il9fuXwe7agqDvqJfHZZsuYHE+4ama+EeJe7F1
 /kfYp5z/YNjqcLabhHIBtFFAcLvaOZM1moPC6+H5HnCT8UraeIIL2Y6MBJK9StSjSKyh
 3IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359295; x=1793964095;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OKx3WZoWzdD1zHUS1BNUvEzkmCP6IQtxBC0V6HuRO1M=;
 b=fBlzqe1E24wrdm596xpak94e51/XTCsrBrylcWW04qvASM9znmYmNUxTMpT4QxMD/I
 IOBIs5UIjoyFbvAzLQH015Tipvdesylhwd1+yS2K6jZ0gFaolmmKrtl1KZfsKHiIxRx+
 1nfxl9QxSdidzF3unfQTiNmQQWjr2VZtw0U9ZKNURedrBxSFAKaJrv0kU+bja7SUa8UO
 B9tCZzo+3MOgdi+nBvQ4mOpx6tyqUT2liLq6qdWcsV6TbAWBEKnO+/cpQhxmnslqxsvO
 4QSjYirg7UMHNxlbJmT8jqNpKWGwjOJTMmRF0KPb6mCHMwvrhhjLL+DPEedXLb3m1PNL
 vNfA==
X-Gm-Message-State: AFq9FYI9/MLbcTPj0rSLXeQ1V3m2fINDGYfveusqd3o5mTy2jeixpjhW
 06V2BK7fJzwDt2Tam/ffSB44DHBGnnV+F31LiuDrBO/7Fc06tK1pMXmn
X-Gm-Gg: AYBFou3/g4HgXlnHQrs3xcv/asd4GLOFc+jU/QxKXYD06f+ByFF7Fr6XamKwX0rtfSv
 8gdhtgpX3KHQq2CrOfQa/+VEsOiNXVKP664zwTdDoRq2oHOmDwuy5vSfzM03bXMmhdvt+4f3ILW
 p6UvLpcKTxcez8t2oH84z+f99aHDKCrH13G8p+h6cOu2bFu6yyGR6YWLCAuD8i6Eka1VSdO6Cq2
 SsorvEDkNwv93SZq3rDEZGjoPKRbi/O5etjf5TUCT5/5X216h6Zh38rSSnj4BOaKHRsRMYfa9lR
 /oWSk1ChJ0nCKjPlJO6jt0M74aZpH9miwHZKW0XEOVkgh6f4ls5NkQkZ+6Z49xY3qHYeEsdeGt+
 FfI+hKlFqQc8FZ26Ja/hCU0I9FuvdOnNgd+klXeQSKvbN5OBcdYWvbFsmR8KYvGa8T7CD/kt3Zq
 jIzfXIDKAbtcb3k4UDxYK5GEqZJyxnbj2ENzj2W5c17eZddk+IhCZucgRBJOIRylaSV936JQ1Fj
 7c2hwkZaUUvlYGHd93mTejhR72Iy1uMN8AGUpEGN+HW9Psb+xbdU35ubAqt0ST3OzxPHwa7F4fH
 +3/TmaurkgTGoyAS4T1pT8tuFZkGDuScPd5eki6pKTvH0e7L1jYir8PVSl+WglXawe4gcAcDH9j
 K8+l8RXwCAlwnsSFVGmU5gownNwTYR75yoJyq0XuDLg4y8vjawzLE+m2294hiHg==
X-Received: by 2002:a5d:5f85:0:b0:48e:20ed:27b1 with SMTP id
 ffacd0b85a97d-48e6e2625fcmr4697030f8f.0.1793359295061; 
 Fri, 30 Oct 2026 04:21:35 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-61d8-3600-98fd-cd98-7ae6-cb49.310.pool.telefonica.de.
 [2a02:3100:61d8:3600:98fd:cd98:7ae6:cb49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm2893608f8f.6.2026.10.30.04.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:34 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Fri, 30 Oct 2026 12:20:57 +0100
Subject: [PATCH v2 4/9] libvhost-user: run handlers of started rings after
 the reply
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-vhost-user-posix-v2-4-cda7c17aad13@gmail.com>
References: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
In-Reply-To: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 vhost-user@lists.linux.dev, Tim Pambor <timpambor@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a ring is started, it may already hold requests: ones the driver
queued while the back-end was away and ones the previous instance left
in flight. libvhost-user handled them by writing to the kick fd it had
just received, which only works when that fd is an eventfd. With pipes
it is the read end, so the back-end was left relying on the front-end
sending a kick after SET_VRING_KICK.

Instead, flag the ring in vu_set_vring_kick_exec() and run the handler
of every flagged ring at the end of vu_dispatch(), once the reply has
gone out. This needs no writable fd and works the same with eventfds
and pipes.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 subprojects/libvhost-user/libvhost-user.c | 44 ++++++++++++++++++++++---------
 subprojects/libvhost-user/libvhost-user.h |  1 +
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index ece2bfcdd7..5f649a3d52 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1320,6 +1320,7 @@ vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
     vmsg->size = sizeof(vmsg->payload.state);
 
     dev->vq[index].started = false;
+    dev->vq[index].kick_pending = false;
     if (dev->iface->queue_set_started) {
         dev->iface->queue_set_started(dev, index, false);
     }
@@ -1493,19 +1494,12 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
         vu_panic(dev, "Failed to check inflights for vq: %d\n", index);
     }
 
-    /* Inject a kick to look for available vq buffers */
-    if (dev->vq[index].kick_fd != -1) {
-        int ret;
-
-        do {
-            ret = eventfd_write(dev->vq[index].kick_fd, 1);
-        } while (ret != 0 && errno == EINTR);
-
-        if (ret != 0 && errno != EAGAIN /* already readable */) {
-            vu_panic(dev, "Failed to inject kick during SET_VRING_KICK "
-                     "on vq: %d with error: %m\n", index);
-        }
-    }
+    /*
+     * The ring may already hold requests: ones the driver queued while the
+     * back-end was away and ones the previous instance left in flight. Run
+     * the handler once the reply to this message has gone out.
+     */
+    dev->vq[index].kick_pending = true;
 
     return false;
 }
@@ -2313,6 +2307,25 @@ vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
     return false;
 }
 
+static void
+vu_run_pending_handlers(VuDev *dev)
+{
+    unsigned int i;
+
+    for (i = 0; i < dev->max_queues && !dev->broken; i++) {
+        VuVirtq *vq = &dev->vq[i];
+
+        /* Without a handler the request stays pending until one is set */
+        if (!vq->kick_pending || !vq->handler) {
+            continue;
+        }
+        vq->kick_pending = false;
+
+        DPRINT("Running handler for pending requests on vq: %u\n", i);
+        vq->handler(dev, i);
+    }
+}
+
 bool
 vu_dispatch(VuDev *dev)
 {
@@ -2345,6 +2358,11 @@ vu_dispatch(VuDev *dev)
 
 end:
     free(vmsg.data);
+
+    if (success) {
+        vu_run_pending_handlers(dev);
+    }
+
     return success;
 }
 
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index a534d70771..aedb1da96d 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -392,6 +392,7 @@ typedef struct VuVirtq {
     int err_fd;
     unsigned int enable;
     bool started;
+    bool kick_pending;
 
     /* Guest addresses of our ring */
     struct vhost_vring_addr vra;

-- 
2.55.0



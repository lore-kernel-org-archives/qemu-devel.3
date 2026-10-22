Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3560A5BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RtBUsdOA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt9e-0000gp-Gh; Thu, 22 Oct 2026 09:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9L-0000Ob-Sp
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9H-00056F-8B
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:06 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1414103f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676880; x=1793281680; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X1CKsFpWJu90qMtUVt/4L+rQag9fOlCL2flGbbnU4Og=;
 b=RtBUsdOAmmIObVlhfTgfMzQAlil+ai57J+iwRevMqIetmcYkt+VYFlFD/IfoenLXyk
 WJW1qAY76DKw3ys1VMAM47oWgra2AFMCuJC+OhqC290YHtvfi3PhB2abRwCZ7VDJBQRh
 s+K6fk1JQlkNjdHnjYSPpUHyfpev3cohZhQlodNDczb8eK9AJ1KXc/A6oVWzo1QVbN86
 bs5lgkLd3tv6Tfovmt9PeuWyeEyOV9QptprJEfF6kHPhRBOB2NBkZD4+hyeGFuKlMHdF
 5mxoi2Q4/gQaerR6guuvMsDFT2OGerV9E6iASFeT3KG4skNMp6NbKyP9dOPsYrwTDVTC
 6t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676880; x=1793281680;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X1CKsFpWJu90qMtUVt/4L+rQag9fOlCL2flGbbnU4Og=;
 b=S5/fitKqHHgqwEvUVKuVyRQH84Fo4prqD0KU0wILeDuvOzqQ+vIwFpQfS4Fhk56jIz
 8Os3xUhfPODkkMyG9HrJ+bX6pZWzAj+wggmxX833CQF0KuNERi2c/ZQ7kQO39ZpwUNB0
 0eT2kfgX9ZqCm90bRAtiAX0XaPscpQVLAYVQ5MTdSI+bj/30LQtIb62RvCDeyjwgNiov
 bv+KhxDiaWfT9RRM0XJLRyyZL+4JjEi+EVng8orunexbRq3p8arQnvLPNVSOQB9009qj
 pUJDzJZd6Bn9cC1r6/KVaYxH3hdMEaJs8s2lJBrTlZ4hk4jUV6zRy+/jRzZS1xBtKm79
 5X2A==
X-Gm-Message-State: AFq9FYITuttiz6tSJiXqzXpBHGYvDUAbcstsUH1A9oMCX/AR2l2OEQ5Q
 zxq2AlxwdVOjSvD71Q0es+fWX/ET3YM6Tv/E1bYRs5hcSoN6gR3Ee+YJ
X-Gm-Gg: AYBFou0x8xYM40DnaCtLLQWLABB2Pni3OKHPSTgsyS9zVWXOsxzWJtuYhhNx0UaUzDT
 +RtJCydgZ2pGPNKBvfWu4u+kM4aVhfG/iSnKy8EgDx8fKhef0dg2hyVYfxZvBxYLFoszfaebkwU
 rDiyz7v0IaYAZAoMgDs4bWUD/l5iV0lAwUbrYL9dbbmZ6Ceg3ueQ2pmVhg1r30r8FdypfChmYfV
 Uei/TqeWG8ZjeDqd6xtHdTaQzycxk4k4Fs/sO1mTuqY+p9CC2VysOg0AFAkBnMwTQCzI0a/hO0G
 aa1sUVi1X7T8XuXCjnTtUWtuN01imNO9paor2hNniwRYk6GOctukISByAKyey17OkOPjmLgY+/P
 j3dsNkfxBVMNMriWvF5lJEJw4NJb/aV/I6XRVKe+roBQrTQP+Bf2nkStFRzmkx97xn1TfYsWfSQ
 g0W3yllut8aAADGKz6o7/WygINKtL+DzlyOM05Znd8sCfuDCtaML3QADFWv3vsggvtnULo/BXEp
 Dd4MyoVFl+5ySsmUX6OkSpaHR1zrqBg+ZHgUC3s5vd/GyiKSV/UCNxcWFLBGjbXOLB/BdJ7ONQj
 oEJX85I+HUo5Cfd36dLHsArax8ikdNRC1q7iTklsMO1yWkBmgLrUc981XFHQ7LdenBUvmHaeTRK
 Nrq5ypcocLA==
X-Received: by 2002:a5d:50d2:0:b0:48e:20f9:8d75 with SMTP id
 ffacd0b85a97d-48e264e290dmr8695718f8f.48.1792676879759; 
 Thu, 22 Oct 2026 06:47:59 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-5a78-7100-00df-217a-667a-8b0a.310.pool.telefonica.de.
 [2a02:3100:5a78:7100:df:217a:667a:8b0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm13120414f8f.6.2026.10.22.06.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:47:59 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Thu, 22 Oct 2026 15:47:22 +0200
Subject: [PATCH 1/8] vhost-user: kick via event_notifier_set()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-vhost-user-posix-v1-1-0bd4d450d23c@gmail.com>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
In-Reply-To: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 Tim Pambor <timpambor@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x42d.google.com
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

vhost-user injects a kick by writing to the fd it has just passed to the
back-end. With an eventfd that fd is writable, but when pipes are used
it is the read end and the write fails.

Instead, kick via event_notifier_set() on the queue's host notifier,
which writes to the correct end in both cases.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 hw/virtio/vhost-user.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 65889b0776..b817b15d0b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1527,16 +1527,9 @@ static int vhost_user_set_vring_kick(struct vhost_dev *dev,
      * receiving a kick. The spec suggests this to improve compatibility.
      */
     if (file->fd != -1) {
-        uint64_t val = 1;
-        ssize_t nwritten;
+        VirtQueue *vq = virtio_get_queue(dev->vdev, file->index);
 
-        do {
-            nwritten = write(file->fd, &val, sizeof(val));
-        } while (nwritten < 0 && errno == EINTR);
-
-        if (nwritten < 0 && errno != EAGAIN /* back-end can already read */) {
-            return -errno;
-        }
+        return event_notifier_set(virtio_queue_get_host_notifier(vq));
     }
 
     return 0;

-- 
2.55.0



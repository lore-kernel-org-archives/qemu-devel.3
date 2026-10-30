Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58905606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OFcuf2+u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkg3-0001Nq-S5; Fri, 30 Oct 2026 07:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfx-0001LD-NW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfw-0002lC-6s
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso4758595e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793359294; x=1793964094; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EEwSVgmgSkQ5ZAKDlh9daWSH5HudgGHgylwl/5eaU1k=;
 b=OFcuf2+uLMy8cvqYlbdGkmn1szWgqjSCBaUPVu6YLSpUhjjqJqQDThNOB3aqjYFpd+
 HPXfv9aAhfJS/ik1vntKyrN2UxZP3SXCZCNOhkcacc61zFbn9GBsTMxUE0Xx7FkeFBS1
 AlGse/Xwm57+onjxcUtRSSfQ0xNPSiOkT8h5o7Sfg1mdfAaSCbNr4M/JJcHlSFPL16Jh
 4wD2NJDSPV2iAR1it4iIMVw7jOMsiXgoXOxVZrZO/WQrRnTSkzkEuQ1mVupV6esAqGuW
 FwKSerOQtKENM6KtUkIq4hdtANz1HTZg2bgsW4i777Mddf3jBds3FNtlxMPj0Fv6QYXw
 l4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359294; x=1793964094;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EEwSVgmgSkQ5ZAKDlh9daWSH5HudgGHgylwl/5eaU1k=;
 b=B48f2tzVjE8FWpbnaKKqtAFm4lyi8UHqxfa7zEmds6PfkUIEoPUsr2f2MtqKfw0SJj
 s2BXpaj02jXzunVWeyK0rlGaivMQnxoHjqUJA1n2fL7ic1M7yV7bWnLAKKrsNklVZhcj
 xkkuLfEBNOdGOHNaBKEkc+MgJ+3XGVHXsMYnPXkG2PLwS2VtSN/8yaEhokfpRcO/TfhZ
 NfNsDE0y1x7rYGXH/eDbBzl0h4yej8XbJjMdObpcLmdLLApBWJGIWp9vphQH94e7DxzF
 NNAAbjyLr8I+RlExdTqDfXHxQ04vIcxAD4m+sILmlb8PFKecsx2L4eXNT7Yf5wRHyoho
 ibRQ==
X-Gm-Message-State: AFq9FYKtCylmDX7sCs6GTlb2/TuHBPbzkc7S8SHxTWmtNWvK54zX65VT
 tgfGyCF+Q0RfE+pGRBOWLWkDnmBJtq9BirzwmqqPBKXyE1Di6mZzjiFx
X-Gm-Gg: AYBFou2hi+N4ruORblfR0aPNU6q8ZBy4+jl1Bbq8EMOIhSCU1mgSt0Q5iYLeNGm16RJ
 xWCC/OxlDvWqAr6mU+ZVaKeHnPxwU/VGwTGeC0YbFz2Mwuisz8EQVOVZTZqi6P6XIGdFNWalans
 gHEbAKYnYo24aBoxL3ENviG3HEn0ixQ38+STossjnfkdgkf3wlsMv/cJZGa2dqbU2KAZjy93sGc
 4StyVBgVlJBNyeRS3pIP5ul/hYbzCoOP6G17VmtLwOHhrTNQV1tsp6qebyyVKpDDklYPbwLi8iB
 5T9gl9648iHcli0x7UTngPIDcrz1GBxti1JAgpvnY0zQj8ASSsLmnbHFaMVee22CaydUKxdRtUc
 AAs5TKPwTOOlW7Qwys0MZjEajMSO19yMNRGsXawQ9N/Gcn3xNfb/brZj1DpAShrww12TZ9N15ql
 xuttIMOGbpNDG9ePAXaNYW3Xgc3xRaSGqWDB3rsQRfYTly6t/Mvpo94WvRy1i/WDTQNcnN/xiLl
 q4llvmTazXLntDX1Ye2MSawZeMzbCnmIL2s8qHpw3MmhLCrPdxigOfHeWLqmGqRXyR6fP6CjElB
 skkEGgiNY8WNgHUp7kjddEp4GUdwlduHdT+c8PlxBHNzRCPlUEiulRU9qVv+N3PpM/rK5GARgYV
 WjccHbcSDVlufgm/X6IP7i2+ZJHA2+0MGgubMaA4q80XdjfEntAJuOdMmGCG3Xt4=
X-Received: by 2002:a05:600c:6087:b0:4a1:fe26:24f0 with SMTP id
 5b1f17b1804b1-4ac1765ce52mr40569815e9.20.1793359293737; 
 Fri, 30 Oct 2026 04:21:33 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-61d8-3600-98fd-cd98-7ae6-cb49.310.pool.telefonica.de.
 [2a02:3100:61d8:3600:98fd:cd98:7ae6:cb49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm2893608f8f.6.2026.10.30.04.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:33 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Fri, 30 Oct 2026 12:20:56 +0100
Subject: [PATCH v2 3/9] vhost-user: kick via event_notifier_set()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-vhost-user-posix-v2-3-cda7c17aad13@gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=timpambor@gmail.com; helo=mail-wm1-x32b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vhost-user injects a kick by writing to the fd it has just passed to the
back-end. With an eventfd that fd is writable, but when pipes are used
it is the read end and the write fails.

Instead, kick via event_notifier_set() on the queue's host notifier,
which writes to the correct end in both cases.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
Changes in v2:
- Add comment about eventfd vs pipe
- Add assert file->fd == event_notifier_get_fd()
---
 hw/virtio/vhost-user.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 65889b0776..868b3d25ca 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1527,16 +1527,17 @@ static int vhost_user_set_vring_kick(struct vhost_dev *dev,
      * receiving a kick. The spec suggests this to improve compatibility.
      */
     if (file->fd != -1) {
-        uint64_t val = 1;
-        ssize_t nwritten;
-
-        do {
-            nwritten = write(file->fd, &val, sizeof(val));
-        } while (nwritten < 0 && errno == EINTR);
+        /*
+         * With an eventfd that fd is writable, but when pipes are used it is
+         * the read end and the write fails. Instead, kick via
+         * event_notifier_set() on the queue's host notifier, which writes
+         * to the correct end in both cases.
+         */
+        VirtQueue *vq = virtio_get_queue(dev->vdev, file->index);
+        EventNotifier *n = virtio_queue_get_host_notifier(vq);
 
-        if (nwritten < 0 && errno != EAGAIN /* back-end can already read */) {
-            return -errno;
-        }
+        assert(file->fd == event_notifier_get_fd(n));
+        return event_notifier_set(n);
     }
 
     return 0;

-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C433C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyI0-0000ul-EX; Tue, 13 Feb 2024 14:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyHy-0000tz-MM
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:17:54 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rZyHx-0001r1-6e
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:17:54 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d731314e67so9148055ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707851871; x=1708456671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NfV0ZdO4ska8d0dsnAqTwhguIzOtODkIfXJtGYHdT8=;
 b=ik/B70AN9bslhIOtlYkkWD4xYBPxtn0ZwRQx0BNjZWOkQRKChSArhYnb/UF47CVFUY
 EezRgnMMLKQnRhdBIEWd23VZHJG6j20ICHUGS9hjHrpWmRxlXe70nJ9jkhtHAc/bTIpC
 +2bl9GwBCNiUp+Sju8VuMgJUXhYo/KefJRNGB+/PtV+djs1EGSXbpQKr0I9sbkXVIomB
 QU/qzlXyCvZhBIVf5qBdPxVe1IKMW2p9rdCyTfs1JJTW3c8oFt/p87jYKe7yA+VvJQR2
 ncommGTusUpRz80VyPGqmA5ePtl38a8XOJgX1LJY8+6GpbT7BZkjbfowJ7mMkZh7SUgL
 rFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707851871; x=1708456671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NfV0ZdO4ska8d0dsnAqTwhguIzOtODkIfXJtGYHdT8=;
 b=ca7u6/GvUJJ0CRol4C6A5fFL99H+NzjRtYyDhUEdiS0jcnhdB/e7ZYa5oh2gXxBk6f
 zFVSIvOLTuS+k59n+fIvo75uFXQ7ivUvIuKnEiAnRtn8s1gMSzcytaceuABYpyen3hf/
 fHSTQkP4oQ9raONqdBe8HchYMIv+B93o3JTD3R5QVqOdz0UxynPgw7K6V3xPB+2PwtSM
 6CAl5fh74ZxW7X4JfUeHsYn/tZAG1oPPm5Uu238MEC0Hh9V7Yhg61XsYd5cfu8MzHpA0
 ncWJUozpDsRwbcvQYmNJ7o1EIJqwQtardPPBGNxabFtFuIL2uozX7gx6m6PNxzZET0GR
 N3UA==
X-Gm-Message-State: AOJu0YxOWeYjLMP30qCmFVUZS7pnJr7QfmMvXxKs7nHKbsTYVaPr3Owy
 SaeHD/3gwB1CwmVRwU+r9uuIsF7caHYnya2T5GKNDJlF0L/hN1dFif20FurBpOUMC4VNymStmaj
 P
X-Google-Smtp-Source: AGHT+IGp/JLczilwROpQt2HN2opbWXubTj0QtQCISnw2mKbHLE5TBD5mispS6L6yFZe6aerFy1NmEA==
X-Received: by 2002:a17:903:1211:b0:1d9:fc3f:5081 with SMTP id
 l17-20020a170903121100b001d9fc3f5081mr597638plh.33.1707851870960; 
 Tue, 13 Feb 2024 11:17:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVk4Lp/HtZQs71C8KTcWkksSToD+9Geq3ZSiuIXR83KvKkeXYfd1Sh+Pib3fv9Eo9qn3JBf7CN8fq29rDjKKhXeZS083U9wIw8rCgtB8QKz5gez25gxXjxrznOMTencChU2kdJ7yOe3PBzWaV5yelFQOsbwFAH4soLVnXPiuvullB8KXoTeiMuO/a5ePdDkb/KBq/b7F97GBCaBsZKyXTwbZ6i+jgkP72NbRBp7f6rkMugNHIs+oDuE5Mjrwi+zdUsFulR8imQ/hNA6C88KZ9PsqAId5A8qyY/aZ0KPmtZdIgokNrQuOEOFRpmC9Ufz/n7U0I1hDTjp8XGxuFxaVEnzTSab+gUETnqPAqpsv2agIR8qFvbBQ2fQD+Ywd0JmCH4G/0ffHaoSc/do
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d60500b001d8f81ecea1sm2416335plp.172.2024.02.13.11.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 11:17:50 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 ajones@ventanamicro.com, alex.bennee@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/6] libqos/virtio.c: fix 'avail_event' offset in qvring_init()
Date: Tue, 13 Feb 2024 16:17:32 -0300
Message-ID: <20240213191736.733334-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213191736.733334-1-dbarboza@ventanamicro.com>
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In qvring_init() we're writing vq->used->avail_event at "vq->used + 2 +
array_size".  The struct pointed by vq->used is, from virtio_ring.h
Linux header):

 *	// A ring of used descriptor heads with free-running index.
 *	__virtio16 used_flags;
 *	__virtio16 used_idx;
 *	struct vring_used_elem used[num];
 *	__virtio16 avail_event_idx;

So 'flags' is the word right at vq->used. 'idx' is vq->used + 2. We need
to skip 'used_idx' by adding + 2 bytes, and then sum the vector size, to
reach avail_event_idx. An example on how to properly access this field
can be found in qvirtqueue_kick():

avail_event = qvirtio_readw(d, qts, vq->used + 4 +
                            sizeof(struct vring_used_elem) * vq->size);

This error was detected when enabling the RISC-V 'virt' libqos machine.
The 'idx' test from vhost-user-blk-test.c errors out with a timeout in
qvirtio_wait_used_elem(). The timeout happens because when processing
the first element, 'avail_event' is read in qvirtqueue_kick() as non-zero
because we didn't initialize it properly (and the memory at that point
happened to be non-zero). 'idx' is 0.

All of this makes this condition fail because "idx - avail_event" will
overflow and be non-zero:

/* < 1 because we add elements to avail queue one by one */
if ((flags & VRING_USED_F_NO_NOTIFY) == 0 &&
                        (!vq->event || (uint16_t)(idx-avail_event) < 1)) {
    d->bus->virtqueue_kick(d, vq);
}

As a result the virtqueue is never kicked and we'll timeout waiting for it.

Fixes: 1053587c3f ("libqos: Added EVENT_IDX support")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/libqos/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 4f39124eba..82a6e122bf 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -265,7 +265,7 @@ void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQueue *vq,
     /* vq->used->idx */
     qvirtio_writew(vq->vdev, qts, vq->used + 2, 0);
     /* vq->used->avail_event */
-    qvirtio_writew(vq->vdev, qts, vq->used + 2 +
+    qvirtio_writew(vq->vdev, qts, vq->used + 4 +
                    sizeof(struct vring_used_elem) * vq->size, 0);
 }
 
-- 
2.43.0



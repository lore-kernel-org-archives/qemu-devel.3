Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92182CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFa-000328-Af; Sun, 05 Oct 2025 15:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFB-0000uA-4M
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEx-0006Zn-3t
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUkGCRfY+3KGS8RLvcJBTE15uJQeumysIiIS7R/VTY4=;
 b=ZAsjjbbKvft5+9qBQjfkxCO6Ad38mRPnrpu0gPKsC/Xdh/TIN7cVumr/G7u/99LKLWOfhZ
 xZof/kgRSBo797eTqRdw2Y2RMq6iZ0PIXHY324bqKjZaIkQU9lC4VGUbA30q7SL/Z8UtKs
 zomIE+qTKWyNjTJttebjf8kNyCIjgLw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-vq57Lx3pMpq19lJ0ffWJrQ-1; Sun, 05 Oct 2025 15:17:49 -0400
X-MC-Unique: vq57Lx3pMpq19lJ0ffWJrQ-1
X-Mimecast-MFC-AGG-ID: vq57Lx3pMpq19lJ0ffWJrQ_1759691868
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ecdfe971abso3387895f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691867; x=1760296667;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aUkGCRfY+3KGS8RLvcJBTE15uJQeumysIiIS7R/VTY4=;
 b=jMkE1Wq+rP9u5btwey7Gh7pQZjJIqb1ZYfxixFmKCbwfoVOsbocPx2/Uwb88ofNzjC
 Yi/QVI163wz0Y6dm8atQH3B9UtWgl35IfNULiSpf1eqOTz4t8HCYC9KrRm4YL2HEnxz/
 ZcPny7p0cP0qfviL6on7iM2iqgno7q2foP4ri2vcR817hK0mB7bj+nmCGstUP5TVKMQP
 qF/EO5ml3fZGXC826F6YRLD1wPr8SiU6uLuVNXAdkS5O/pIbz4NqU+JpTI3W+edProfm
 4VC0Mfj5I+TvuZXwb9UXbzbouygbNgjb2thRdz481yREIModSeP9zzlmopFHUEpG9WL3
 fJuA==
X-Gm-Message-State: AOJu0YxtP+tr0M2MlzH41mh1CxrxqWCY3aQUEaPPE4jJAprNLC/cEzQh
 b5zbl2Vz5DPZ5di0rXpD2W1ixYFkJyAznHt9N0AUVsnm16B+uDJ8CrOuhdlU58D5EKIPN40c3GA
 PzpWtj/buX8n7ZBo1aBBiqnwDW7ZdRdJ+A+Dn5QKufcbE8ov9m+Y5RGUwOGe46oi6hCL4u1dXq3
 bBcjslWBHhwzJ5cR1wMxu8xq2Uz3ISiDR+BA==
X-Gm-Gg: ASbGncuJjrYwHfZgnSOMCmSlR6V/45wHmSIpqcXhd3KkQPQEt0u+qMID+GGwXCSuXEi
 v0na+Gm2nzFYraoqFCvGjqKyYWSJ1nU9D26TpScfSOmtGAzkz7xHDxt7W6+2QlMy6cCVPmJMqxY
 n3VTCYV5qdxi9hPd/PfW18a3LB0q5mjVpCY42eVjW4qFuoD7TNnHNE5TxM34A/1wXZoQK2zFmow
 LwQm9McJw1bT+EIAmjbqsMGeHTv9FZDK2d/6rNYzePuglWcsVYdJet32Vgc9LQ2XH1GLxqClFE6
 1kkVVNRiCNheS53ekMVjA0vsMMnUUNF77jM9GFw=
X-Received: by 2002:a05:6000:43d4:20b0:425:75bd:7748 with SMTP id
 ffacd0b85a97d-42575bd77b6mr2050085f8f.58.1759691867570; 
 Sun, 05 Oct 2025 12:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESWqAM17weSRz6tNkuFOcXoHoGAXaaXqYqFFeWKQ+3m4H3+KLBOo1qy5v5MbtlXDYpBvGvFA==
X-Received: by 2002:a05:6000:43d4:20b0:425:75bd:7748 with SMTP id
 ffacd0b85a97d-42575bd77b6mr2050076f8f.58.1759691867058; 
 Sun, 05 Oct 2025 12:17:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8acc4csm17211783f8f.16.2025.10.05.12.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:46 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 46/75] tests/libqos: extract qvirtqueue_set_avail_idx()
Message-ID: <e06d96d5a9f81608ede08576445ac20ac2e73dcc.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Setting the vring's avail.idx can be useful for low-level VIRTIO tests,
especially for testing error scenarios with invalid vrings. Extract it
into a new function so that the next commit can add a test that uses
this new test API.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250922220149.498967-5-stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/libqos/virtio.h |  2 ++
 tests/qtest/libqos/virtio.c | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqos/virtio.h b/tests/qtest/libqos/virtio.h
index 7adc7cbd10..e238f1726f 100644
--- a/tests/qtest/libqos/virtio.h
+++ b/tests/qtest/libqos/virtio.h
@@ -143,6 +143,8 @@ uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue *vq, uint64_t data,
                         uint32_t len, bool write, bool next);
 uint32_t qvirtqueue_add_indirect(QTestState *qts, QVirtQueue *vq,
                                  QVRingIndirectDesc *indirect);
+void qvirtqueue_set_avail_idx(QTestState *qts, QVirtioDevice *d,
+                              QVirtQueue *vq, uint16_t idx);
 void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
                      uint32_t free_head);
 bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *vq, uint32_t *desc_idx,
diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 5a709d0bc5..010ff40834 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -265,8 +265,9 @@ void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQueue *vq,
 
     /* vq->avail->flags */
     qvirtio_writew(vq->vdev, qts, vq->avail, 0);
-    /* vq->avail->idx */
-    qvirtio_writew(vq->vdev, qts, vq->avail + 2, 0);
+
+    qvirtqueue_set_avail_idx(qts, vq->vdev, vq, 0);
+
     /* vq->avail->used_event */
     qvirtio_writew(vq->vdev, qts, vq->avail + 4 + (2 * vq->size), 0);
 
@@ -388,6 +389,13 @@ uint32_t qvirtqueue_add_indirect(QTestState *qts, QVirtQueue *vq,
     return vq->free_head++; /* Return and increase, in this order */
 }
 
+void qvirtqueue_set_avail_idx(QTestState *qts, QVirtioDevice *d,
+                              QVirtQueue *vq, uint16_t idx)
+{
+    /* vq->avail->idx */
+    qvirtio_writew(d, qts, vq->avail + 2, idx);
+}
+
 void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
                      uint32_t free_head)
 {
@@ -400,8 +408,8 @@ void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
 
     /* vq->avail->ring[idx % vq->size] */
     qvirtio_writew(d, qts, vq->avail + 4 + (2 * (idx % vq->size)), free_head);
-    /* vq->avail->idx */
-    qvirtio_writew(d, qts, vq->avail + 2, idx + 1);
+
+    qvirtqueue_set_avail_idx(qts, d, vq, idx + 1);
 
     /* Must read after idx is updated */
     flags = qvirtio_readw(d, qts, vq->used);
-- 
MST



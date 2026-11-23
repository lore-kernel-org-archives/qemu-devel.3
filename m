Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC18606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lN+5eWvH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVdMP-00037c-Cu; Mon, 23 Nov 2026 18:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1xVdDx-0000XY-VK
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 18:13:25 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1xVdDw-0008Gp-8b
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 18:13:25 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b51389f58cso41751057b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 15:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795475602; x=1796080402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tjeI3keb5sQ5d5kgtADiM2w4zsKeUjMW3Hq8QAJWbLk=;
 b=lN+5eWvHlHZzVI9FgCuQEa1aN46CRXrBws42g7yzvWTt9XqMsnpWWICL3LiltRrg+b
 JqPgZ+QR0QpvFsknW+/Cq1idr4dDmyGZLROReOtPYyCp0O6mvgZ1sXI9AfQAvEde5jXF
 gGtF+E82tR8j84jSd29fGQkr3/acTGfjfEinpHNsOoq5PKq8AiPwuqsk4Mbm2Nl2mmeR
 tLUdqQihulENzJ4MPakrDCFjJL2fDA/gtqzHcdsEtJ4N7IvdOuA1ryX6RnVuoC426LW2
 uPBBvjvnCYs6WCq95Ec/nKWxOlejeV8NUqFZ4XaExtB0ZfKMfWgsiMXYA4Sv2ETvSOHM
 xbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795475602; x=1796080402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tjeI3keb5sQ5d5kgtADiM2w4zsKeUjMW3Hq8QAJWbLk=;
 b=qnLEvIWx7WVIq0u3yY+gIRQAL3TOGDsCuxFnJiMcWYWxm2t7orDsSj23wAIGzKieDt
 SlsoG3UHZZn9C6yL+8mVlwrwkoUKNcgIsbytR6LHH5vuRptsjFclqYFqkzTw71szZARo
 Fp89Ye5x1WBIgzQn4AIleTgPsWAGCNNno3Fbslt1qHsEHK63XAMaSdDQuvNvJVDX/Zla
 qTa8LZa7avfjTUyxss7VHSkkJP4ZFkZNYNsGPatdSZKcGcU/EKref1KSwpw+6/+ZtH7v
 z82C7gzbSzmaNBptp3gDlsD/DOAgkQ4iZoUqVFeoszakuqe60+7DIMSk9f2d8eMZinfe
 m0NA==
X-Gm-Message-State: APuU4Z9jfvHA8vzqdXxNvh7puijCHhjric7cA6lff1cbOiS1WNKHApjs
 IUU+QZfwZ0zPnjZuqreyavZU/tvajUOvUJr57v/mxTrpCIuY0kwwG3O55tnykQ==
X-Gm-Gg: AZFdTZcpKNO6rL+mSlNAiFQ1R9RpKmSNAgJJwfaXpv+5YuWvKvl0WTaSTh/D80RN42e
 ub1zXesSy8TURL/kJkIIPLhx5RUTDqajKQHz3AMJxCWgZb6r1exB9/7x4VuopRyF535yK61Hq0J
 B+RkOynKifzJ1YPZr8Io45B8B83nDBQBG0qcqEmxkmOaLSRzWVgAHr0EvOILlNSEUtwamUKEVCy
 0nCgYztn1sPDf03mq8Kc3/cI6wRhLuj3aTy397UxIr0oWVDeSQvP5Vb1TnTlEGidmKnyEaUl2DO
 8vfKV8rvjD0NwSysqA7Cpl8f82V84aZ5DJz2o7J+xaUkwjBEE4qP+WEXLIUSjd1N8Gr+6Lc7qeu
 3x0aBS8I77WG7lF32+npzJ+XsvRYOB9cmiyGpVqaw9iF1u+Pu9Ve6exH8/P5pcQocsFiIw954rA
 vTta32zd+zU5Q6nzEAuyjiWZ3CkduIk7uxnYDI6ySGX90YSTjCVEnVCnPSeqmOuWC9R2k6us7g0
 sQ31WLvqdFH/tl9dNvD1bOUhk1V7LyJ7iT8vpt5iO52zOPpvOBw2KlUSZgBuFL0EFglnVjQW8C8
 U5TKkL0CS7VlQYdl1RCzDISnuCpqA1AJk3Er0iOh5aHvGcgCcU8x4QF5ro5xvukbwXFyr/4MZv2
 RoQ==
X-Received: by 2002:a05:690c:9683:b0:8b4:d66a:1fec with SMTP id
 00721157ae682-8b5204c11d1mr40926047b3.62.1795475602424; 
 Mon, 23 Nov 2026 15:13:22 -0800 (PST)
Received: from MacLin.attlocal.net ([2600:1700:4271:1970:db88:ce2e:93fd:2d96])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b52028d628sm50814707b3.8.2026.11.23.15.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 15:13:22 -0800 (PST)
From: Connor Kite <connorkite@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Connor Kite <connorkite@gmail.com>
Subject: [PATCH] hw/virtio/vhost-shadow-virtqueue: clear ndescs after use
Date: Mon, 23 Nov 2026 15:13:19 -0800
Message-ID: <20261123231319.377104-1-connorkite@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=connorkite@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Nov 2026 18:22:06 -0500
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

When a shadow virtqueue detaches the buffer associated with a used element,
it adds the descriptor chain to the head of the free-elements list. However,
this currently happens after svq->desc_state[last_used].ndescs is set to 0
in vhost_svq_get_buf, introducing a bug.  Only the first element in the used
descriptor chain is added back into the free-elements list, with subsequent
elements being potentially orphaned.

Zero out ndescs only after the buffer is detached.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 462c86dc1e..1afd3edf87 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -604,6 +604,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
                                            uint32_t *len)
 {
     uint16_t last_used;
+    VirtQueueElement *detached_buf;
 
     if (!vhost_svq_more_used(svq)) {
         return NULL;
@@ -637,9 +638,10 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
         return NULL;
     }
 
+    detached_buf = vhost_svq_detach_buf(svq, last_used);
     svq->num_free += svq->desc_state[last_used].ndescs;
     svq->desc_state[last_used].ndescs = 0;
-    return vhost_svq_detach_buf(svq, last_used);
+    return detached_buf;
 }
 
 /**
-- 
2.43.0



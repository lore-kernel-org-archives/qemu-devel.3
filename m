Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CABC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnDAA-0000LC-OX; Fri, 24 Jul 2026 06:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnDA8-0000Kd-JI
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 06:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnDA6-0002oy-MQ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 06:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784888989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=iSs6CPp552YxV/2AsV+6koEA1wJ+b55ymEdPdU+1CIM=;
 b=e8RAKM9kZTtQKVc6N9b+NB1aNiJzjGQ2aTBLBUilbZJbuoN3peS49MSBgVWJf9tLaASY6+
 GvHBHAMrxOseGHBfUxQyZm1pk181LuerIRtclYojn9e9maToHMVVJvobHNNitEbhXyHupF
 eIsBuWOOezFZafKoIKu3URxCWQRTni8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-t-DhUI8SOIeKWWAHNvRHhg-1; Fri, 24 Jul 2026 06:29:47 -0400
X-MC-Unique: t-DhUI8SOIeKWWAHNvRHhg-1
X-Mimecast-MFC-AGG-ID: t-DhUI8SOIeKWWAHNvRHhg_1784888986
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4955ce558d8so2844595e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784888986; x=1785493786; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iSs6CPp552YxV/2AsV+6koEA1wJ+b55ymEdPdU+1CIM=;
 b=QMWERzTb7jidNAzLGkmVYsERML3XhzaaEZjaap1pmRQwoL9bzfohf2uM2LLzkRfzE9
 hbELQRBoD2irh785V7FOJrHtWllEUbctfAdHYMriGfDxfWMPzvpp3wVRn1RStvnjYxj2
 f6THzJIXHD6XM56rwpQDv8/jCJwCo0v1zFfXzXCLa4OpyJSR4rL1CArr28wGipJ4eGp2
 blA6nAZMwZ3keRpK86ZmOLlTqaCzRrYdGpyShcIhbKd4KeO9nwGVT0iQbTX9Cw6iPGDT
 2949cihvemgV+G2DU9rze1GIRdTkBnKFJTHLXgLtAXEXTxVhF7WDpIHkSfwRKOZqtDh6
 jfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784888986; x=1785493786;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iSs6CPp552YxV/2AsV+6koEA1wJ+b55ymEdPdU+1CIM=;
 b=ZNMXTRw75pg48qZl/cm/95ktI/0GKt4eHunrncCkKRX9H2UM4Xx1OZYbSRzg+7eSdc
 iEw7KiCiUJ1Xoa8dJLqwpWN0S0O/Iw+jNzHseTENl/c1IsjaaWLOR8ni6CzWtAkxFxxU
 zQ/bO/vNh5GeRrKu89Y2N5oqQHqW+SiA9/LW01Ie2agRhI54C3gZaoCGIk5UYeM1Jzhk
 KhmC6L8ifNpq9iQZT1lT8yz0bYBBSnlObi9ARxlPD6hba4NHHFesrt8Wrt0s9CEVS+1X
 c6sxTFIm6rPTe8f4NnqOLs36WZJBXS89b+vy687pFhQKTaiEBZpDEKDy8LHgES/hrQJb
 S28w==
X-Gm-Message-State: AOJu0Yzmi4qklYR5D2oPFR2tQBPKwJjF0QqkisTAIYX3SuV21PaHunSN
 oIeiDh1b9Eqk6cwvfZaJMA19EhZzpcb4O85ZJ+qzTolU3rJDUt3KorDM7gotJkNoZoL4KQY7VaH
 mDvKS+2Mq1vjKRXkeps9YY7zpi+sBVXJ136yZHhCsBfzP/i8ZbJXeda0obeutymRxEh/+IbqQ5C
 Jv8Qg0wqL1mjzS54NZ0ouJvNJJ9RGfRB64lw==
X-Gm-Gg: AR+sD12TAx9a2p7mVGF6jHgS8a0oJ/wVGzHq/2ZLjOxCrDmxcFhzbpAB0le8zwhE3Q8
 jh/F6zOxN7H1/+Tiih9xRUEZDnte4mBbyHlz+fnNk8G42NncnbzNsRkLsVshsBcb4UCkMj2fMFt
 mL6Q2u+b/NkQvitA5g8PGNbNwLvDvenm1GK4qx/BaSvEauIMIhI+Q9S8uNN5nTh7fiVL+wVxFIm
 Bd2+65nVoxOrsOSTQcSSu4RzzrN/FSY6E90t2JqKSlKx+aZICd+nFRPlIQXhVaTPKOewe0V4LH2
 6u/XU3k9DdlswWYY0qqonSb0one7am61VX5DNMbRUOplVobj02NvoSD5ApdtI3qTKGPt4+a4N1N
 /bG8UtJn2zv613znlL9PCrA==
X-Received: by 2002:a05:600c:1914:b0:495:4d00:2fc0 with SMTP id
 5b1f17b1804b1-49573ccb598mr81711805e9.12.1784888986176; 
 Fri, 24 Jul 2026 03:29:46 -0700 (PDT)
X-Received: by 2002:a05:600c:1914:b0:495:4d00:2fc0 with SMTP id
 5b1f17b1804b1-49573ccb598mr81711275e9.12.1784888985536; 
 Fri, 24 Jul 2026 03:29:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af16f72sm66489215e9.0.2026.07.24.03.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:29:45 -0700 (PDT)
Date: Fri, 24 Jul 2026 06:29:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jia Jia <physicalmtea@gmail.com>, Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH] libvduse: validate vq size
Message-ID: <bf7e71b3139875e5e00fd53970c772d6c90dc2a1.1784888961.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

libvduse assumes that vq size (aka vq num) is below VIRTQUEUE_MAX_SIZE
and maps logs large enough based on this assumption.

However, vduse_queue_enable() accepts the vq size returned through
VDUSE_VQ_GET_INFO without validation, so a value above
VIRTQUEUE_MAX_SIZE (1024) overruns the inflight log and causes
out-of-bounds writes in vduse_queue_inflight_get().

According to the virtio spec, vq size can only be reduced, not
increased, so vq size must not exceed the previously configured
max_size, but the kernel vduse module does not validate this for us, and
we should not trust another process to follow the spec.

Validate and reject vq size values above VIRTQUEUE_MAX_SIZE.

Fixes: CVE-2026-61402
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3652
Reported-by: Jia Jia <physicalmtea@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvduse/libvduse.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/subprojects/libvduse/libvduse.c b/subprojects/libvduse/libvduse.c
index df9ca5e56f..712b97b4c3 100644
--- a/subprojects/libvduse/libvduse.c
+++ b/subprojects/libvduse/libvduse.c
@@ -902,6 +902,11 @@ static void vduse_queue_enable(VduseVirtq *vq)
         return;
     }
 
+    if (vq_info.num > VIRTQUEUE_MAX_SIZE) {
+        fprintf(stderr, "vq[%d] vring num %u exceeds max %u\n",
+                vq->index, vq_info.num, VIRTQUEUE_MAX_SIZE);
+        return;
+    }
     vq->vring.num = vq_info.num;
     vq->vring.desc_addr = vq_info.desc_addr;
     vq->vring.avail_addr = vq_info.driver_addr;
-- 
MST



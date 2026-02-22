Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E6FC636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuAT0-000114-Pw; Sun, 22 Feb 2026 09:29:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASq-0000ge-Me
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASp-000732-8U
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5W+WCYaPcjw+DbTWpVRSi4jP+J/l9WZesscDdkfYgWk=;
 b=ZMx7xHUXCzv//kyVH59gD2H/PS0g8lWp7/aQVEL08UcHnx+mbAPgLey3cFjk4VTBnNhZIG
 XxOIUhtxLuCk8aden3sWFVYxGcLyC8j3Oa++8m8nnMya9NahdI3M/Tz8cWvI4qKZSXE8Br
 THf6CdyGJm7wn2W/bW19JFLNTttaxsU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-147nBn5tOau-7jd7FsfDRQ-1; Sun, 22 Feb 2026 09:29:37 -0500
X-MC-Unique: 147nBn5tOau-7jd7FsfDRQ-1
X-Mimecast-MFC-AGG-ID: 147nBn5tOau-7jd7FsfDRQ_1771770576
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-482d8e6e13aso30577915e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770576; x=1772375376; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5W+WCYaPcjw+DbTWpVRSi4jP+J/l9WZesscDdkfYgWk=;
 b=I2D+bgV7MAHX9NdwX/Y+YBNZ/qlMM6DyxU8zd9W2Nb9zfbJwe0xBuLDra/DFRAmQo0
 vGidOkpaMO/3kQg8ApjQPoxC7PkZ+ckS6loXQ2vjDveaetv0VFFlOp76QfMqsYSvFzV9
 Oc0bUvA7d/PQ9s2V7WOB9xctxWeozPzsoNgVrmvfqV7SCvewm/5t0iClKl36BzvmeIpR
 1hBRL5isPY90hrdxblqgW/CYE2e5HmKg7oipqh1QCK/f6wwoy2NW1yu1UPwUy190/0c+
 y/rZCch0Ukt6f4iFH+B0CWkCOM1IRMX6sMrqNAZo/Gn1kfF6C7HJefXZat6OtZmYvq4O
 3MdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770576; x=1772375376;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5W+WCYaPcjw+DbTWpVRSi4jP+J/l9WZesscDdkfYgWk=;
 b=urzkWptJpGiKPL2kOB6bYhSW5qIR+3aKNbMf21M4HMtn1F4lOzPstRrBzenn+sazVL
 gF6Ul0NNezm7G+y2KkjlJK7y42VXloGE31YrvTjSezFFjYNbFldKt+9HSzmA+a7b5KKm
 HAX4dTRyZYEc3eBDeXgL02mSjyiMwmiXKwGs1S6KXGjK9msTg64T2WmzT+HvXyYQsCwi
 3SgGwQtiH5PUIpJGBZUEUA9GMkumpTiWNCuvuCY/ohFP+r2UPKHThz8kWI9o6yfQvFpg
 MdHie3XPaXsF2OYc9cxDqifWCRcD95IqY2zltpRxKycVLK6YeZ9camJleh8TkbB11IWf
 8S1A==
X-Gm-Message-State: AOJu0Yxr1Ju4oOsJ8eRWULeV5Gy8vm9UU8XCwUhmMgdQEZurjskRcqMY
 66HhNSBAVYY3fQv6DX95P6aw5btDW9xldEAm96Ld1/AAdK1DmHMLKSs9LzEPq8iNXBn0Du32t88
 CTvxJFfxY6Y70aY0HFdwXxpzGEowcd0/5Q0TmAL5WdIndyekn+F6Xye88VcxTT00s6B3c1jr8g2
 CsehNMSBseNYuZ/NnJVwo/uQUJwkfN95vARw==
X-Gm-Gg: AZuq6aIGRB2n8lq2gZuCcQYSI8fATBD70F3p2tz9rAC3AL9MHI8Wsu0/aWFc/fHRLEs
 FOZYuwnt/BioI+PPElXs7jhUxvX6yuov/9iCevO75mHuTVWH854y5nlqaCIiHt2UJt7d/ra2Un3
 f49qoRq77PTlVFG2naqtvOlQfAvpYcck1cLwgsWFdF75zY3LCzKpnH3yapS/j4FVL1MOU8/1oh0
 ATsafxbDPj2z8Grbs0JZrZnb8Yl6hy6Nq1kZCploNmCnCmg4XKIrK3VQAsIuiCsgYCSaRF4Of09
 l7n2OMOzaM6H64jMsrUQkf+wttPK1CppMqtMcicwKkBcYrdW6Zo43PwSb7fLh/3d8bEkW8GifnX
 pZjvXquGA3KQ886x5oBIII9GYFRD87vFGWOWUgEKndRbQYQ==
X-Received: by 2002:a05:600c:314a:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-483a95b3e62mr103736695e9.5.1771770575677; 
 Sun, 22 Feb 2026 06:29:35 -0800 (PST)
X-Received: by 2002:a05:600c:314a:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-483a95b3e62mr103736255e9.5.1771770575113; 
 Sun, 22 Feb 2026 06:29:35 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4c626sm13729659f8f.28.2026.02.22.06.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:34 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org, DARKNAVY <vr@darknavy.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 32/33] virtio-snd: tighten read amount in in_cb
Message-ID: <7994203bb1b83a6604f3ab00fe9598909bb66164.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The amount of bytes to read passed to AUD_read() should never surpass
the maximum available buffer length. Tighten the current amount by
MIN(<amount>, max_size - <existing size>).

Cc: qemu-stable@nongnu.org
Fixes: 98e77e3dd8dd6e7aa9a7dffa60f49c8c8a49d4e3 ("virtio-snd: add max size bounds check in input cb")
Reported-by: DARKNAVY <vr@darknavy.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260220-virtio-snd-series-v1-5-207c4f7200a2@linaro.org>
---
 hw/audio/virtio-snd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index d1a46d47bc..d5d430ad65 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1250,7 +1250,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
 {
     VirtIOSoundPCMStream *stream = data;
     VirtIOSoundPCMBuffer *buffer;
-    size_t size, max_size;
+    size_t size, max_size, to_read;
 
     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
         while (!QSIMPLEQ_EMPTY(&stream->queue)) {
@@ -1276,10 +1276,12 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
                     return_rx_buffer(stream, buffer);
                     break;
                 }
+                to_read = stream->params.period_bytes - buffer->size;
+                to_read = MIN(to_read, available);
+                to_read = MIN(to_read, max_size - buffer->size);
                 size = AUD_read(stream->voice.in,
-                        buffer->data + buffer->size,
-                        MIN(available, (stream->params.period_bytes -
-                                        buffer->size)));
+                                buffer->data + buffer->size,
+                                to_read);
                 if (!size) {
                     available = 0;
                     break;
-- 
MST



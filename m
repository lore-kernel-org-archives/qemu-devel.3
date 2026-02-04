Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F96EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniBc-0002yi-HO; Wed, 04 Feb 2026 14:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniB0-0002s8-NS
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAz-0008AT-4N
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=240llcH1KOsRD5XX9QQlOGkvt40lI+orhfBCWyP5XqQ=;
 b=Et09Ypx49lgbnGVKhAfN0VqjI+O5Lq4NRohyT2OTd8KuLMoyFRdwnvlP09cYC2KFbIPmGi
 zSwjwoS67HqFaSMWWvzYD8YXJq2+0A0zm7CD8qe24IF5I/VfdC7/t/6DI9DhtaRRGdwAVm
 cR1iiD7NSw4Q38RofPEj4TRqdRw6PT8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-Y7LmGiV8NMSOJrF-6O5mwA-1; Wed, 04 Feb 2026 14:04:30 -0500
X-MC-Unique: Y7LmGiV8NMSOJrF-6O5mwA-1
X-Mimecast-MFC-AGG-ID: Y7LmGiV8NMSOJrF-6O5mwA_1770231868
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435ab907109so103593f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231868; x=1770836668; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=240llcH1KOsRD5XX9QQlOGkvt40lI+orhfBCWyP5XqQ=;
 b=SRWbqZCEArh/qbqpjtgkShhjWckjHHZtnOT/1zmV1XEloQstlWttQBXLqKHWTrsWmp
 M6AvjuJpuwKgJ5ej2Ei4aLTq/fL9EezwiCrNLPdPOcuox4QSlTs3MKH8ZmSyQBDIChYL
 Ax+wJ27LjQuuvg6vdynxGiSDkSne25YQ9E2D9vHzPIbs6VvSKvdQttTDiAqznqpa+4fp
 21ldPsJTLBBeSrBxwnT+L23zoRZqXPXzuqR82HlTrka9TtzWAKg+rROaOtpR5g83EBnf
 rE3YCqI380G60vq4mSe8ef4pQs6b2f9THUUueIPqT8YUad5VIYSbWTzWJmEZEtZEMGvy
 0uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231868; x=1770836668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=240llcH1KOsRD5XX9QQlOGkvt40lI+orhfBCWyP5XqQ=;
 b=d4pAI0RlJdraGey+dLvrFgAe4p26Jb2KccQjK0fJQYbsjHU7OdPYoAc3FDrZFeeamv
 YnqwOCdCNulNYtYSZxCqWE5n1uFpDvhkyUdQRK9EOwj+K61qbIFkQf8OPEbmoHzxgszy
 w5gsnsCa5iqWKYqmOliE+tDB31QyKEXISEz4rxxT5wUBUjC8KHZJ22nYofdl1JhDNnM2
 P4ml04s+rNMVASvFLeY5EC1aspye2Iz6Xzr5s3sTG0DYTjCO6VQhGZlejA6vpU5/eB+Q
 lkcbIJYW/+64viuq5a3R4u6h6JdxDWOy+kKI3vCZZOwTjics282I+yLiFXT3ULCrWYaQ
 ux3A==
X-Gm-Message-State: AOJu0Yz5XoUK/DSBUNDgfLKfmMxhAoP06TSztZ5KcZPrYOyGAGBf84Jv
 2uCEWUcJuV5x+8tzi1vYi6pFXXLHxHBk/h0LuY+UfkezrtEcSvqeKPq1G2co+AYIWL5+pP9M07L
 YqaexMg4s/ideTQ479clKzk+9v6sapKZ/yF+is3ds6TRLL1ukUBrJ+z7eOYG6ceMwASUBq0C5+6
 F2355LgD2NQ6tu5QATYMfLnqKEG+CY9Q6N5g==
X-Gm-Gg: AZuq6aIvpM9+0pgseFox7pz0uYhB+XPNXWXbeykdAMYNFHPn+8c/1Z/HBELA32P8lPx
 dAv2vL0Ys9/AfIKlM75B1NvI4EZGC8ZDJow0vTtnPCO9PGgc6uZM12UTosxZIGz0tefaRRq/oj+
 mhoFsTwyAk4gTKjfFzdlfRzA12fDHNhsfVU39ZCF6kwv4cKUiDYSn7BfZbcX1LDq80wOv1PM3S+
 ncUfnHpVarczuvi5WVuVPUwTjv6OGXn+m8133r4kVhq9uwu0dNWDRN3+6sLnRBrjMTzd9BGIped
 ppZbJJJv6N14r223SpQoxifnpz4Gb00j7hpTu2cgK60a04QE5cYKgVS6cwspziROnEbN9S9TvWq
 hHB/gxzCc4ZAc2lgbIEnTA3XaLmNrrGmKQQ==
X-Received: by 2002:a05:6000:240e:b0:432:8651:4071 with SMTP id
 ffacd0b85a97d-43617e3c672mr5591315f8f.18.1770231867695; 
 Wed, 04 Feb 2026 11:04:27 -0800 (PST)
X-Received: by 2002:a05:6000:240e:b0:432:8651:4071 with SMTP id
 ffacd0b85a97d-43617e3c672mr5591257f8f.18.1770231867191; 
 Wed, 04 Feb 2026 11:04:27 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e25683sm8191167f8f.6.2026.02.04.11.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:26 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Chen <chenl311@chinatelecom.cn>, Li Chen <me@linux.beauty>
Subject: [PULL 42/51] virtio-pmem: ignore empty queue notifications
Message-ID: <7d3d3fa20b856b3a13b44c0d0824e3bf8bfd9219.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Li Chen <chenl311@chinatelecom.cn>

virtio_pmem_flush() treats a NULL return from virtqueue_pop() as a fatal
error and calls virtio_error(), which puts the device into NEEDS_RESET.

However, virtqueue handlers can be invoked when no element is available,
so an empty queue should be handled as a benign no-op.

With a Linux guest this avoids spurious NEEDS_RESET and the resulting
-EIO propagation (e.g. EXT4 journal abort and remount-ro).

Signed-off-by: Li Chen <me@linux.beauty>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260106083859.380338-1-me@linux.beauty>
---
 hw/virtio/virtio-pmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 5381d59282..c3b3299c9c 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -73,7 +73,6 @@ static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
     trace_virtio_pmem_flush_request();
     req_data = virtqueue_pop(vq, sizeof(VirtIODeviceRequest));
     if (!req_data) {
-        virtio_error(vdev, "virtio-pmem missing request data");
         return;
     }
 
-- 
MST



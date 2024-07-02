Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACF2C3271E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjy9-0007hl-2n; Tue, 02 Jul 2024 16:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxS-0005MC-5A
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxB-0000AD-HI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pgJQy7t094Dms9DBv10pUkz+7onKHwqzjJeEHsSRcQk=;
 b=izrG62yMPWT+n3zPBRX0GB0YnXJir4YpiF07XMZAahk7NDdTHqd6VCvM246GRsgs+IjaId
 UVUX2Fw//vzLYRYqYtUK0ZMoes5xXywuh4id0V+q+qI38tFlnqNME3ist54IUCJ+GOyZry
 7JcQ10uwd9TMh9DkcJJAFybLTBVuE90=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-_PGx2LFyP2yOYOPPQwD4eg-1; Tue, 02 Jul 2024 16:18:14 -0400
X-MC-Unique: _PGx2LFyP2yOYOPPQwD4eg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4256569a4faso28960815e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951493; x=1720556293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgJQy7t094Dms9DBv10pUkz+7onKHwqzjJeEHsSRcQk=;
 b=HBlsHOPMu5MYyjO4U8yDis+gtStih0MNKUMftWvFZtDYTGma0xHgkCjTQgTbM88lq2
 prLbJzrzgwDB4URjlufgtbwxRZbpeaB4kKPxqL2LXwSNNuVkFx2D3NI7BQAcpxUJOsk5
 Roagqc9v0s+fDDcUEZwTovXuiHcZqb36vOilrAzmNqWvVdl/PnlpYCa8rIF9XgyutPYM
 P6fxiVTGgmaoInxgxxsX2uTqrfv5UqARmWG2ND922MfgE4SV/caMtRoJ00hwjWset2pl
 gw+dJCrGh43dHNaq6A8Xs7ZalGhCAMAJKs/kej9IcHCnWHVkLxDELv8kpMwEH4N3Rax1
 6JBg==
X-Gm-Message-State: AOJu0YyKy7ycPlitN4YShcDXLKna4wbLTQYCYoqhC1JysY7uoUZSWsHq
 CdljWvmiCK7w24y/M6iVD15VISDwG9JxhNQJUPV7y1CHWI+hMLNJ5SHufUOTFe0vRTRGy6emjvs
 nc/i7EAOfV9U8hN5zEEq2YuVmFERvb9AR2s1Sxt0HpQ56d3hPBdKER8n1PKu+QLm89ucIIyRVV7
 nFhDUZ/LwdX3luqh2tLbSjNIUp6xYzDA==
X-Received: by 2002:a05:600c:1604:b0:421:8234:9bb4 with SMTP id
 5b1f17b1804b1-425798ae183mr92819775e9.19.1719951493035; 
 Tue, 02 Jul 2024 13:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyhKS1Xerc3N66kHJXACvab5R3OUf8iLssDvOPHHvBmgIluriRbc0Antgx8I3C6eof+ZqAPg==
X-Received: by 2002:a05:600c:1604:b0:421:8234:9bb4 with SMTP id
 5b1f17b1804b1-425798ae183mr92819455e9.19.1719951492265; 
 Tue, 02 Jul 2024 13:18:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c19eesm216293895e9.45.2024.07.02.13.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:11 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Frolov <frolov@swemel.ru>, Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 45/88] hw/net/virtio-net.c: fix crash in iov_copy()
Message-ID: <d4f471eb7e562c2cc398448a1c1e7ee838ec30bd.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dmitry Frolov <frolov@swemel.ru>

A crash found while fuzzing device virtio-net-socket-check-used.
Assertion "offset == 0" in iov_copy() fails if less than guest_hdr_len bytes
were transmited.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Message-Id: <20240613143529.602591-2-frolov@swemel.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9c7e85caea..8f30972708 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2735,6 +2735,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
          */
         assert(n->host_hdr_len <= n->guest_hdr_len);
         if (n->host_hdr_len != n->guest_hdr_len) {
+            if (iov_size(out_sg, out_num) < n->guest_hdr_len) {
+                virtio_error(vdev, "virtio-net header is invalid");
+                goto detach;
+            }
             unsigned sg_num = iov_copy(sg, ARRAY_SIZE(sg),
                                        out_sg, out_num,
                                        0, n->host_hdr_len);
-- 
MST



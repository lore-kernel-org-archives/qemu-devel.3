Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD70C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCZ-0000WU-8n; Tue, 02 Jul 2024 10:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCR-0008Ho-4y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCB-0008Li-1l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pgJQy7t094Dms9DBv10pUkz+7onKHwqzjJeEHsSRcQk=;
 b=b9Jp9lo0hUm++0MuFRzpSoThxRT3VvuxtUSb9sL+bSLKragceM9FT+dvcSrp371Ya8+git
 9riNXrJk+LsF0YqS/c6dr6/k+BENyCyUwO8r0hj6UPTzgkvrQYSgDHugAIGgpJSRAdmomW
 AiG1Msasuh6vH1XjLQUuUhfGxOAbUaU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-TZL2ob9zNeONuqC2p20Osw-1; Tue, 02 Jul 2024 10:09:20 -0400
X-MC-Unique: TZL2ob9zNeONuqC2p20Osw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4256569a4faso27263465e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929358; x=1720534158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgJQy7t094Dms9DBv10pUkz+7onKHwqzjJeEHsSRcQk=;
 b=KR/Qjt8xLNJGys1fEb0TepYHZp0NmqAqH7dDHppmjr6E2UUopHUBunX16sZtrRADef
 Y7agemK80ceMk8rVVVpzwL5c+jxIAUhujSIpSNTMsjfYlC6HtuZ7QbJ8NylH1QIDdFE+
 MRrqgVs07wIvVV5jZG7FgbR04cuo9NmArisDYhz1ENu7D/ftExtO4aQWwhHJaaa0XVL1
 hq10bemClISBRDDc5cZ2XmSYdQ6T5cWFermywxCP2BVb2tN7FOO8a6pw85Vy/ehhH1JT
 i58zKZ2/92ZmAKQkFEhp/jx6D6pwuCop7t6MPorkB/Mg/5EqG/YNiuq2bYEcG92Xyrgq
 +X+w==
X-Gm-Message-State: AOJu0YxJcdbl0jtqFFeLHTque/SUBkK6t7qivUNNg0U8py4YNVJOxMIg
 hYidhKZPObF6N5V48+eCZFVQ4yyvdEWDTrfgcIfgOhlWy7DOkYRr4H0ogGyYkEcTMbYshVKCsOe
 JP1kzL3sDsy0CYy+To2j3Pj3zB/Pb/iYyFtULkSd35n/pydStsLS4NOtykCl+4u8oROVil5bTBl
 8UFNTMalAjVjBrRxwP95ai3M1CoOxNiQ==
X-Received: by 2002:a05:600c:4f13:b0:425:6290:b11b with SMTP id
 5b1f17b1804b1-4256d58dc93mr107235165e9.18.1719929358538; 
 Tue, 02 Jul 2024 07:09:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHbFq1qkUi1fZdglcJIPPyGd1pO8r2TtH/fMhcS06wamh8zkt0pz65ViGTQJUh9rWesjxoPg==
X-Received: by 2002:a05:600c:4f13:b0:425:6290:b11b with SMTP id
 5b1f17b1804b1-4256d58dc93mr107234875e9.18.1719929357982; 
 Tue, 02 Jul 2024 07:09:17 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257bc89832sm128332435e9.42.2024.07.02.07.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:17 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Frolov <frolov@swemel.ru>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 45/91] hw/net/virtio-net.c: fix crash in iov_copy()
Message-ID: <7bc77e8972cb30f5278ab1746ea962684b92f4ca.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



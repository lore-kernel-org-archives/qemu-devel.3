Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD98CC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8lZ-0006Zj-6a; Wed, 03 Jul 2024 18:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lX-0006Ym-3D
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lU-0002Zq-HN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pgJQy7t094Dms9DBv10pUkz+7onKHwqzjJeEHsSRcQk=;
 b=KhZClW9J6+9nCmPdk/xPbzcSyR32Oqwhwacyy03IgCWayqFxiGMzfSZdnykmHr604s8h6A
 EoICniw77InRAcizGslq3uuXqcQ8Ta08dtEJCIRLVlmy4IVakKta9oO5HF5zafjHX/6xQ/
 iCEyPMTxR5hym08t9WvUPETKRQ0ACTg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-bGFmHej4M--So3VSl5Z7mA-1; Wed, 03 Jul 2024 18:47:50 -0400
X-MC-Unique: bGFmHej4M--So3VSl5Z7mA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a77b2edfe06so1684266b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046869; x=1720651669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgJQy7t094Dms9DBv10pUkz+7onKHwqzjJeEHsSRcQk=;
 b=dtjYMh/bVOYIdiqmcBJ2wtoBLvgQrf8Yi5tqNtC1ZwcGY6DwmvXx0Q/e/VLQL28W9W
 WZ6D7A0vVub2xnd/pkYRPkbHVo7Lj3wRezFxBEq8FKmy1BYr//k6kUlio4+tTF0S+skn
 nOqP/vdjvsjQ6Nzw4xvltsIj+7MGMgVzc8XkzhlNDng5+El6sm5AHwrYzsTSzZYXAmz8
 Bh4HvHwsBOMmZaL0C5qf3m87iX2iluvy7LaeQwb2wgbAJhm4DdfUT2U50fXg6xDMhHY3
 IfAZxXzc7TvvYobgTOoY83nh1FHpw7JdgDkkrd5EQvRvvCdFGwbfJKZgeCEc9srS4BjN
 N99g==
X-Gm-Message-State: AOJu0Yw5HjE/qtGp/XXg99QzY3QdapPq26srPcqBjyjX9lJDbGsBr2xw
 xJbmPG1ada2HdzGn3bHrdOt089YrwvtpwNVqi9/NLCBsuPmPUjlnOXTRwqCuz+e6rilOQ3Jg0AZ
 kG4vehgFZFsYN8LaQ6n2CGmE4kUlMs0IBrrh8s8dX8/1A05uMRFI0GySd5MvaS6FFOSH7hNtUhh
 jqecifzBfcngWaV+Xz+49anJCKrKfb7g==
X-Received: by 2002:a17:906:bc90:b0:a72:8296:ca1f with SMTP id
 a640c23a62f3a-a75144a916emr746671566b.50.1720046869324; 
 Wed, 03 Jul 2024 15:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgRJSMC3QzbTGARJ91rozWLwkA96WxT8m3Vv/tE7ScxrC2cOGvnaGMeO55TC+uXiA3FPtyaA==
X-Received: by 2002:a17:906:bc90:b0:a72:8296:ca1f with SMTP id
 a640c23a62f3a-a75144a916emr746670566b.50.1720046868774; 
 Wed, 03 Jul 2024 15:47:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0652c6sm546779866b.109.2024.07.03.15.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:48 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Frolov <frolov@swemel.ru>, Jason Wang <jasowang@redhat.com>
Subject: [PULL v3 45/85] hw/net/virtio-net.c: fix crash in iov_copy()
Message-ID: <d4f471eb7e562c2cc398448a1c1e7ee838ec30bd.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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



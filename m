Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31F5C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8lx-0008HR-IH; Wed, 03 Jul 2024 18:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lt-0007ob-Pa
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lq-0003Um-Ho
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrTyYgO+P/l4LBdE4jQm9EUMOljixFZgw03WGI4si6s=;
 b=e0afm35x2Dh5wCFs+8mzfmPJcwwN0K7uQBeGnr3lBitBqx+Iyk9/rxyOeAY3VO/PqO4Uw/
 CN/LQ/RukjkQf8QqzJZk5/Rlq2VkEyM+LSOxSo6MIpEw2Qq70rlJeOT/7/TVa/o9d6CF9v
 LrIMPUpUjiziBMvJAjvC4RrxmVGcAQY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-KcfLPtAVMDeyexIL6xLxGw-1; Wed, 03 Jul 2024 18:48:12 -0400
X-MC-Unique: KcfLPtAVMDeyexIL6xLxGw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6fe837c066so9030066b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046890; x=1720651690;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QrTyYgO+P/l4LBdE4jQm9EUMOljixFZgw03WGI4si6s=;
 b=KY6w+IOcdcF8J05o+2SzrjaCyNb2qFoMP68z23htHTuPINsihowipBAWr8oPhpuVnr
 WSsXKQIbNof6j8N4TxirJcNhBTFKvhu/faF4fBs/3UOi3OcyURB/m/la//6V8RA0Tp97
 NFbcDtG6V8Cpq69sj64GZb2F7+KxiNBStXpMsgy1wAJaix6h1VBtTWzLef3dFmz9CQmb
 H0qF7Afl7ZZKbHuXdGqW7EruO0azzGKrhpEtdvY2DgJS6CKjHZYzRqqXkMOsMXV0Y1+8
 N4tyBR28AYlE1cf9YBAZ3jn67hlxvr0UqqnktSTc3XavET+2Ko6J3n0L6OI49+YAWXAb
 hdbw==
X-Gm-Message-State: AOJu0YwNE/Utbt85rkeePDThmrF5RFIw0sObAFB0wCr5w8c0fOHFqpe4
 qgHpV0l0qtTjGBcSpiT4DAIOw8jfHWMdBkQkYo9yEUpv6lWIMiZB48KQ6mIyEtqfpK3aqZiTjqV
 9SqiWCzWHfbW6J8/9XmxdT/tWedNGSrv3zlRxajRH7otam47eItNBfLHRjzY6VJqmDOu2CAGIrv
 cJZEd6P8mbo6/Di9noW+G1eoiJbPHxUg==
X-Received: by 2002:a17:906:a259:b0:a6f:dd93:7ffb with SMTP id
 a640c23a62f3a-a77a2404383mr193536566b.1.1720046890242; 
 Wed, 03 Jul 2024 15:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHig2bzfs8B101b6zoi98QMSZGI61PWTDRQjv0sU+bCjptEC+Uu7uhrnDLaOdxxA241+roeXA==
X-Received: by 2002:a17:906:a259:b0:a6f:dd93:7ffb with SMTP id
 a640c23a62f3a-a77a2404383mr193534866b.1.1720046889731; 
 Wed, 03 Jul 2024 15:48:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c835cfsm7582950a12.14.2024.07.03.15.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:48:09 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:48:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL v3 49/85] libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not
 supported
Message-ID: <ebdede644bbf5744f91dbe0d39742f17b03c4e10.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Stefano Garzarella <sgarzare@redhat.com>

libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
message if MFD_ALLOW_SEALING is not defined, since it's not able
to create a memfd.

VHOST_USER_GET_INFLIGHT_FD is used only if
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
that feature if the backend is not able to properly handle these
messages.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-5-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index ea27683dac..9c630c2170 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1674,6 +1674,17 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
         features |= dev->iface->get_protocol_features(dev);
     }
 
+#ifndef MFD_ALLOW_SEALING
+    /*
+     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
+     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
+     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
+     * is negotiated. A device implementation can enable it, so let's mask
+     * it to avoid a runtime panic.
+     */
+    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
+#endif
+
     vmsg_set_reply_u64(vmsg, features);
     return true;
 }
-- 
MST



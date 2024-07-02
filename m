Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D0BC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCd-00018Y-Fl; Tue, 02 Jul 2024 10:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCa-0000aE-1F
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCS-0008Pc-VH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrTyYgO+P/l4LBdE4jQm9EUMOljixFZgw03WGI4si6s=;
 b=X+DNTLi4huI7O93NSnkM5d+A+t8eKgeCaYUFIY9x6hbdzBCtOxUixWE24/qwgqBV7V8iGm
 O+XCM7XTrIYNli/e2+kJqKOGYVpy4ZWh/Fp5aVMHnFNQynifdFCT92eskieNzoUienlGmx
 pL/4DsiDWvomWgz8kab/nCBw+iDW2ug=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-uV7Kkrv1M76gqMa6dUA0SA-1; Tue, 02 Jul 2024 10:09:31 -0400
X-MC-Unique: uV7Kkrv1M76gqMa6dUA0SA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42565672e0aso27276195e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929370; x=1720534170;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QrTyYgO+P/l4LBdE4jQm9EUMOljixFZgw03WGI4si6s=;
 b=nT5RXS2aGGWXV92GmA1UGUvDfGxLeACy8KS4mUYMHepyhnN1WU6xXK6fougVUQOHrJ
 qIq+NAY3+HmeoA8HPyz5WdU3nXtsKMWieGQS1BOXCdrOL9B3TQ1Bs36c3jdo5cC81RyH
 CQ3jAYxFktebABeiO8NnMyvM5XF6FERkhesZ50hfX1Uj7Zq7iTs+bJMT3fp1hy3r5EZh
 3/B8BUSUbz2WGbrvOiUXi4zsBQ5N8ZYFBlxQ/7OIy5gRHHqmPylHhj5sgW6c6ff2KjjP
 z00UhcuVeLTUHVmz5knJpe1DSaBjgKxeb7DhAQxsTFaApXybHRhtcGM1tOExM6CfvE9J
 cHOA==
X-Gm-Message-State: AOJu0YxIH+60BNEdMf0WVhVb68xfuW1I7cUCtk8sPAp8THrFPDAU7xyB
 +F2NFK+FoviQ3tKMuFaAQfX2zHBT/eJ8Z4k6orRrPGjYofSpUd/INr504on2zxYrNKieAEKku/p
 tg7l2Z8aCVTzGrnIfBG0UfbGBhj/O6vJxsRTfi/zqZjFC5zHviwoCoBy3qLIcXF7gMv3+r9t/+O
 LeoSxLh0kjnnxrTm5vZ3PTzPVR1IXtDQ==
X-Received: by 2002:a05:600c:1c96:b0:421:811b:b83e with SMTP id
 5b1f17b1804b1-4256d56407amr111523105e9.13.1719929370072; 
 Tue, 02 Jul 2024 07:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4OPgvZVZcIYo27rd3bS8ZNHLEpXs7Hy/Raqo8Ne6lR2A5Fh10UcZjZSzAX8jCNCinDWET4w==
X-Received: by 2002:a05:600c:1c96:b0:421:811b:b83e with SMTP id
 5b1f17b1804b1-4256d56407amr111522735e9.13.1719929369506; 
 Tue, 02 Jul 2024 07:09:29 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fba2dsm13358613f8f.73.2024.07.02.07.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:29 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 49/91] libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not
 supported
Message-ID: <ac55a1bc25f0b7af40218eafac88be0e5ed6e92d.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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



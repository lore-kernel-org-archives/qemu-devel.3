Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA8DEF8FE0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxm1q-0001hP-M2; Wed, 04 Mar 2026 08:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxm1o-0001Y0-9M
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:12:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxm1m-0006ym-KR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772629957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jZ3DZwWjlXKrMSvfHPfpJOwLofANBMVgYFcMLsX/WHc=;
 b=UZl9glnG5niFnnYioZtbFfwUlSyVQ30I0T7BuvPpnEoXM9FJFgPsJlkdgviIDp/TiTulEU
 x3R/aG4wMtQGdq5wSDLGYYAOjQp4gbWQZGvLcoRYLWxfQb5YsFobCCXmoLUIylyx3kZ3ob
 Do1FPsOcvYP6LqMwJL9lFyg+ntBq9NA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-6rHWkJ0LO1Stour2W6nO9A-1; Wed, 04 Mar 2026 08:12:36 -0500
X-MC-Unique: 6rHWkJ0LO1Stour2W6nO9A-1
X-Mimecast-MFC-AGG-ID: 6rHWkJ0LO1Stour2W6nO9A_1772629955
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48379489438so65132705e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772629955; x=1773234755; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jZ3DZwWjlXKrMSvfHPfpJOwLofANBMVgYFcMLsX/WHc=;
 b=i/ZHQIohY5If/a1giPKaXSeRx20uFR6kC+ZTw0UJlW3aHg4xIniZOFEqCPZo+/F7zU
 oVS1/Kz8WkLO7/TjXKgCZ/EQukNkfwjWtmfeQwggCFIK9btaljIoLZkGlI9/SfsTQRdt
 r7kHX2x9Ra62MRSj0PmMzoSmpwn7NhnsUTeESDooPxKPgsvlWaCG0Z2ZnkzN029caLPJ
 Fy1lP6wrb1c7nitxoFj2HY1ThkTPVfJ3P/6Kp/tsGyy30QmneEylqjo7vm5Fzf6BVyyX
 JsH1f9rhGUFJz4lA6jH6p9oNSHqh6vpgiUasc7jb8WYfIxXl8xknf48LwoMZbcm5tEXf
 YXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772629955; x=1773234755;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZ3DZwWjlXKrMSvfHPfpJOwLofANBMVgYFcMLsX/WHc=;
 b=OigklZk0dBVbAA0VE1XvbjcrvcnBZON86xFc/GzsDK/9rWlwASEOWpqO5t21ppPH0b
 RRJ5u7fmbXA7s1OgxBckMp2m4TIuU7dsqYeuS1CK81WC71YUgjzZj9z/YMOO89B0+6VX
 jSdhh3Ki4XO5+UbmlbU3ib28LcCHTttE3i5mlPcBfJlw8uMh5U0q04YK2hbZhxze4LAS
 bWkXHSEH5J3IyLNcTGa1JbZpqMBpZlq02PPsyNHkXT67QCJQYzQCUjAp5MkndyFs+Oej
 /1O6Puvd/FEJVcHxf1bUWAjvmCkPHRpJQo59VIkptPjRVeCsW5QfhuJajhV594qTHLhm
 8h/Q==
X-Gm-Message-State: AOJu0YxenL6q/W10LnOWMcW1jMCSuBop9nUB8TqEsJoxEb12dj7Sq2Xh
 gCOoh2eDk9a1Br+DgUd0dDZh2X3YrOqxGZRe9vONuOk/WpogYbKtFG6m+wS1yKp0UYwwcDEu1+0
 z4G6S0OX/7PQ5/djczKJ/O3EC5y1Kc6zFTTMGQE+TTzitwRZOPaJJ0D+a
X-Gm-Gg: ATEYQzwgkixSVW7+9qB3uR5mMepDM74QefQlLsUmx74wwcP26MYLQsXKd32p1YlWwhl
 QMC0Xl/JI3Awu2JpPSYtQJ0cHuPSdXcEe4P3patM0854rqj2aEX0BxBbFyhyY0fCMmZP+yNMEex
 gXQIKwf+by7nHSUSpUe43aWKrA8dhsZ8lN+NP5Lt6wSSMpFM162Km6MrioYD2Dv0Fa9An/Ml7N6
 5iY5dTRHt7PWMarKbctwhG9TK4cq4Kn5+Fegady0RK0IMfE3q2VvO2InUZnTrcZApIARhXL5CV3
 BqdWlS4zsYxwUpeJ4NktqGJ9btMibIj/IB/3f1IKmRrGpOy8aIrFVJ5B2IoPCIG9dPptittK7cB
 wUGkEvyzjcV9M4LGZcJfUUnX+XTWpdb/JRoSDThTIqA+Hk4sQa86A2M97iqG4A8RW3mHlULY=
X-Received: by 2002:a05:600c:1e2a:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-48519848388mr28850235e9.6.1772629955406; 
 Wed, 04 Mar 2026 05:12:35 -0800 (PST)
X-Received: by 2002:a05:600c:1e2a:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-48519848388mr28849705e9.6.1772629954938; 
 Wed, 04 Mar 2026 05:12:34 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it.
 [82.53.134.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851887fc54sm57899885e9.10.2026.03.04.05.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:12:34 -0800 (PST)
Date: Wed, 4 Mar 2026 14:12:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org, jasowang@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, 
 slp@redhat.com, hi@alyssa.is, stevensd@chromium.org
Subject: Re: [PATCH v13 4/7] vhost_user: Add frontend get_shmem_config command
Message-ID: <aagvt31Of3MhAl95@sgarzare-redhat>
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-5-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260219130334.787858-5-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Thu, Feb 19, 2026 at 02:03:31PM +0100, Albert Esteve wrote:
>The frontend can use this command to retrieve
>VirtIO Shared Memory Regions configuration from
>the backend. The response contains the number of
>shared memory regions, their size, and shmid.
>
>This is useful when the frontend is unaware of
>specific backend type and configuration,
>for example, in the `vhost-user-device` case.
>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Albert Esteve <aesteve@redhat.com>
>---
> include/hw/virtio/vhost-backend.h | 10 ++++++++++
> include/hw/virtio/vhost-user.h    |  1 +
> include/hw/virtio/virtio.h        |  2 ++
> 3 files changed, 13 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
>index ff94fa1734..ce58b4d2d6 100644
>--- a/include/hw/virtio/vhost-backend.h
>+++ b/include/hw/virtio/vhost-backend.h
>@@ -163,6 +163,15 @@ typedef int (*vhost_set_device_state_fd_op)(struct vhost_dev *dev,
>                                             int *reply_fd,
>                                             Error **errp);
> typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Error **errp);
>+/*
>+ * Max regions is VIRTIO_MAX_SHMEM_REGIONS, so that is the maximum
>+ * number of memory_sizes that will be accepted.
>+ */
>+typedef int (*vhost_get_shmem_config_op)(struct vhost_dev *dev,
>+                                         int *nregions,
>+                                         uint64_t *memory_sizes,
>+                                         Error **errp);
>+
>
> typedef struct VhostOps {
>     VhostBackendType backend_type;
>@@ -220,6 +229,7 @@ typedef struct VhostOps {
>     vhost_supports_device_state_op vhost_supports_device_state;
>     vhost_set_device_state_fd_op vhost_set_device_state_fd;
>     vhost_check_device_state_op vhost_check_device_state;
>+    vhost_get_shmem_config_op vhost_get_shmem_config;
> } VhostOps;
>
> int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
>diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
>index 55d5725ef8..8ac2120cfd 100644
>--- a/include/hw/virtio/vhost-user.h
>+++ b/include/hw/virtio/vhost-user.h
>@@ -32,6 +32,7 @@ enum VhostUserProtocolFeature {
>     /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>     VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
>     VHOST_USER_PROTOCOL_F_DEVICE_STATE = 19,
>+    VHOST_USER_PROTOCOL_F_SHMEM = 20,
>     VHOST_USER_PROTOCOL_F_MAX
> };
>
>diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>index 40d881ca09..9aef913af0 100644
>--- a/include/hw/virtio/virtio.h
>+++ b/include/hw/virtio/virtio.h
>@@ -82,6 +82,8 @@ typedef struct VirtQueueElement
>
> #define VIRTIO_NO_VECTOR 0xffff
>
>+#define VIRTIO_MAX_SHMEM_REGIONS 256
>+
> /* special index value used internally for config irqs */
> #define VIRTIO_CONFIG_IRQ_IDX -1
>
>-- 
>2.52.0
>



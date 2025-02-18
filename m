Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D08FC02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 12:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkMJq-0008Pq-La; Tue, 18 Feb 2025 07:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tkMJg-0008PE-C7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 07:03:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tkMJd-0003Jz-U5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 07:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739880183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kI6Cdb8dsyB+uBwxL3PL4l9H+PYw5qPBCUssBZ5E+SY=;
 b=Fab3Nz/EY37Tawy4VO5e2a7eL/mHaRKcc1KF9rugYEeCx/ab1mjyl8qS0qo+W5DruyNDHN
 iBL60a3+HKOs5Am0MPbpztwd+V1nniC/h5iy1zeSkbzH/itZ6sbCuK2DoW6Kb7B1/AR0PU
 QCHYZsF41mwjPNdXiANi/sWNILB9L/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-1MlbML5cNn60UtqiVBFqOQ-1; Tue, 18 Feb 2025 07:03:02 -0500
X-MC-Unique: 1MlbML5cNn60UtqiVBFqOQ-1
X-Mimecast-MFC-AGG-ID: 1MlbML5cNn60UtqiVBFqOQ_1739880181
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f36fcf4b3so1926561f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 04:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739880181; x=1740484981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kI6Cdb8dsyB+uBwxL3PL4l9H+PYw5qPBCUssBZ5E+SY=;
 b=Coj8XWqRmplmCisZ6Iisp3efpE6vagoCegP0Q+lKmVWz0ZmqmZ4iHY2sTK4uvKgu0b
 QZENqJsAHbUNwBlr6vOeOR4QOkhOoKhVevRYI84Gh72/nbagsT3bVzKvBLI9M6XZbg5J
 ZeZqDPdXSEdq9/Ss93ZLZCQdM2rpWkutPIc4xnqFdjoeefru17QbXtsCc+QksaLOtemF
 A7Pa5hb//fvS1I75cL0QVlYczNuIaCOcUQfDYJ0RJ+gPWPCi2MUCznLjB09rLReszKjB
 l/GB0DezH6ow5EJEYp6xypDOTNjEEfre/3OLlN0hGfOxWSd1L4jOTno4lgm6ljGYQod2
 Cc8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx0t86xt7LGhX+LA/9AllH9Q4zEFvVynlMwRWl9/gNNb25x9mSY2dN5ckUwij9Zb7bZCo3ViDbJMU1@nongnu.org
X-Gm-Message-State: AOJu0Yz14cAeqErREiD6nt1NkGwkKY8tbkC4HhndJyqj5ipjf6uw0kvb
 DP3+Eokssx7kcTZx3uXIQVwmNDHx88O5Ljhwolw4UY76rKN9vfXVxRPrp6ra4b2kmS4Ym9WxYB2
 Me2Wf1fYkg21jOGgLrA0npnrLjlJC4+k1VbrpCQ3jtHXY9U2+SucX0pi7OkS7
X-Gm-Gg: ASbGnctBGBFD96VEY8uSbYBuEtXIrAf46WVVD7uvkUJOOcUeAF3ECXIg/u6OqOW6u+D
 jgtIFhBOBEnP04MaAmw+ewxAbXwapYnKvCYBRy31pBvrRzw8Q6nca+8h4MOf5SXElFlfvFKSbM8
 0iQOEhxUD1E+d6Pn3CAb2hEswsAlE3i/7y56iJ2u8vj1Um7GO6UJ/p2Vf2sNBEVN+I2EeQeIfZU
 OmAwrr0uItAwPP69HdJk8s8YIYpgSB6sV6NhF1CqlO2RNnWnjYWZFvk1d7uYpcFPzviE4juAkj2
 aMexQdwMnCdFVUhP0majzQJIMFvfRGTVL+YjTihKdJM4eqiR30Tw8w==
X-Received: by 2002:adf:fed1:0:b0:38f:229a:b4d with SMTP id
 ffacd0b85a97d-38f33f4b81cmr12187025f8f.35.1739880181060; 
 Tue, 18 Feb 2025 04:03:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLc8Oi1OVVQeDQbgKMKzA4vXjmDxatpKFCBjhIrYFrzQY5sAa4YEs1MXxqJj2stFJENOhRrA==
X-Received: by 2002:adf:fed1:0:b0:38f:229a:b4d with SMTP id
 ffacd0b85a97d-38f33f4b81cmr12186958f8f.35.1739880180356; 
 Tue, 18 Feb 2025 04:03:00 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it.
 [79.46.200.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259fdb19sm15189493f8f.95.2025.02.18.04.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 04:02:59 -0800 (PST)
Date: Tue, 18 Feb 2025 13:02:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: oenhan@gmail.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
Subject: Re: [PATCH] vhost: Don't set vring call if guest notifier is disabled
Message-ID: <ebhceh2uzlpf3cr6gxnojt36i4vl5cvrputuhq62irbgb2ew4q@t7qxhpkvqmy5>
References: <20250218083208.78465-1-hanht2@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250218083208.78465-1-hanht2@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 18, 2025 at 04:32:08PM +0800, oenhan@gmail.com wrote:
>From: Huaitong Han <hanht2@chinatelecom.cn>
>
>The vring call fd is set even when the guest does not use MSIX (e.g., virtio
>PMD). This results in unnecessary CPU overhead for handling virtio interrupts.
>The previous patch only optimized the condition when query_queue_notifier was

Which patch/commit are you referring to?

The last commit touching that check is commit 96a3d98d2c ("vhost: don't
set vring call if no vector"), but I'm not sure if you are referring to
it. If it's the case, please add it in that form in the description.

It would also be better to add the Fixes tag as well and Cc stable if we 
would like to have this fix in the stable branch.

Thanks,
Stefano

>enabled and the vector was unset. However, if query_queue_notifier is disabled,
>the vring call FD should also be unset to avoid this inefficiency.
>
>Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
>Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
>---
> hw/virtio/vhost.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 6aa72fd434..d17e7cc6fe 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1342,8 +1342,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>     }
>
>     if (k->query_guest_notifiers &&
>-        k->query_guest_notifiers(qbus->parent) &&
>-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
>+        (!k->query_guest_notifiers(qbus->parent) ||
>+            virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR)) {
>         file.fd = -1;
>         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
>         if (r) {
>-- 
>2.43.5
>



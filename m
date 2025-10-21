Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300A9CCD1AB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBI2y-0005SQ-Q2; Tue, 21 Oct 2025 15:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBI2w-0005SF-2D
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBI2r-0003WP-KP
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761074958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ixacuwCkCKqdqOHzSXsw8PhEGE3LuuGi4CoIQhqx/o=;
 b=VE2zrcbhkDX501V/jklRk8p9nOd4cIWCg4zqaEj8b3VM6s4BMFrVey6qjyysYXOtUv8MXI
 Rp4tbnoGsAppypu/V5FBKH7Tn5m9vfMmKXOFq6Fhoh0xAAqyUZdZCURXpqB9+uAh40VTxj
 yaipV7p/ILdk7GANJXN2qF+7N+pn1zc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-uJGnzwB5OcyaN3SBDcws3Q-1; Tue, 21 Oct 2025 15:29:17 -0400
X-MC-Unique: uJGnzwB5OcyaN3SBDcws3Q-1
X-Mimecast-MFC-AGG-ID: uJGnzwB5OcyaN3SBDcws3Q_1761074956
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4e88947a773so13410961cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761074956; x=1761679756;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ixacuwCkCKqdqOHzSXsw8PhEGE3LuuGi4CoIQhqx/o=;
 b=MI8KzH7LTfJlAy2L8THzuW3XDLDTLWpXeKdqEC+ISTjLA3/+yQjJe/4M1rDFXV8Coi
 MpX+E7SFq8xUcHfjLm/xaI07jVL/Duv5jcNciybK0N2eQONAa8bkfWtauTfEu4j7VPY8
 3+dWyA08pzqtshG8FL7993auQLGCx1LtH2pdIN2ZtTpCCfY1d2jKqYE5fAmSrA9ckNdH
 GU583PCg5uOheyXLHl51ydEB36WdPntWDWiFaaS98hJdkpyPcvWhifkVRiVFtbLKyl1j
 AQPzuMlvA2tQnmU+0+JQR8iFxVzBDuzJfrZaL+agSeZNk5g6cGb9qDnjV7TxzHXWRb0c
 C1Sg==
X-Gm-Message-State: AOJu0YwGvlnJxwsNBkhGcfMcT53FehT3FW6cqcQ9M93TgGgXM536WLLu
 xrcZzaJCc+IBsF7aKGh336ovv4dsBopEXNodD2gMAlQW3mWuL/HggeB2W4q4fBk8vs/2Uc07kdV
 HX8wZYtBfXelJvwJpsxiFhcB4A7jJXaIVQJ0HErVbyAb3D6Bu/lVuCACZNpHTmvIp
X-Gm-Gg: ASbGncstrxtLNvriQZs23x9GIBIxrMR5J3kCLgL+Ygvpve6tWa5ki9Low4BnqkXvO2h
 WjfFmp/bzEMuGMUWcazEXC9lnrFfFCEbnR0bKIKP2fAfaz+0pflrBO7H0piGPHINpOF/5Jt24sA
 WGZBjooeVvU9LCn0Q87Bq6zyGnBzA4fj+SK+wchGHUiebdXU82xyFegKe9swoeZxAQJwDN6jzuu
 67Nfg82mEhvFLwpvqUYQu04coXMhZ6jVikKZVOBbtASLG8eqzuAhBWXaWKubaEWGYdcb1X6kBSW
 ofrf0a/EqlKe2h4hZemNcx4HLD0vUg2Uu8cUz8Za/rJLQLS9S6egXnaUaSJJPSDPPBg=
X-Received: by 2002:ac8:7d4a:0:b0:4e8:b9fd:59ee with SMTP id
 d75a77b69052e-4e8b9fd5d13mr124593171cf.74.1761074955974; 
 Tue, 21 Oct 2025 12:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFReXzI2gn+wwy7V2J+YL3iNDj+UGo9Bo1JhvkhGj0AF+Vxg+BHeO4DWfTp0GufwcalRAMFsg==
X-Received: by 2002:ac8:7d4a:0:b0:4e8:b9fd:59ee with SMTP id
 d75a77b69052e-4e8b9fd5d13mr124592841cf.74.1761074955480; 
 Tue, 21 Oct 2025 12:29:15 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cc8d5edasm826949285a.7.2025.10.21.12.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 12:29:14 -0700 (PDT)
Date: Tue, 21 Oct 2025 15:29:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/2] vhost: support inflight save/load
Message-ID: <aPffCBqvNKmOE-CG@x1.local>
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <20251020054413.2614932-2-dtalexundeer@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020054413.2614932-2-dtalexundeer@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 20, 2025 at 10:44:14AM +0500, Alexandr Moshkov wrote:
> vhost_dev_load_inflight and vhost_dev_save_inflight have been deleted
> by:
> 
> abe9ff2 ("vhost: Remove unused vhost_dev_{load|save}_inflight")
> 
> So, now they are needed for future commit.
> Return them, and their helper vhost_dev_resize_inflight.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>  hw/virtio/vhost.c         | 56 +++++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/vhost.h |  2 ++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 266a11514a..16ce9a6037 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2013,6 +2013,62 @@ int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
>      return 0;
>  }
>  
> +static int vhost_dev_resize_inflight(struct vhost_inflight *inflight,
> +                                     uint64_t new_size)
> +{
> +    Error *err = NULL;
> +    int fd = -1;
> +    void *addr = qemu_memfd_alloc("vhost-inflight", new_size,
> +                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> +                                  &fd, &err);
> +    if (err) {
> +        error_report_err(err);
> +        return -ENOMEM;
> +    }
> +
> +    vhost_dev_free_inflight(inflight);
> +    inflight->offset = 0;
> +    inflight->addr = addr;
> +    inflight->fd = fd;
> +    inflight->size = new_size;
> +
> +    return 0;
> +}
> +
> +void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f)
> +{
> +    if (inflight->addr) {
> +        qemu_put_be64(f, inflight->size);
> +        qemu_put_be16(f, inflight->queue_size);
> +        qemu_put_buffer(f, inflight->addr, inflight->size);
> +    } else {
> +        qemu_put_be64(f, 0);
> +    }

Can we use VMSD (extra fields, or subsections) to describe any new data for
migration?

In general, we want to avoid using qemufile API as much as possible in the
future.  Hard-coded VMStateInfo is not suggested.

Thanks,

> +}
> +
> +int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
> +{
> +    uint64_t size;
> +
> +    size = qemu_get_be64(f);
> +    if (!size) {
> +        return 0;
> +    }
> +
> +    if (inflight->size != size) {
> +        int ret = vhost_dev_resize_inflight(inflight, size);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    inflight->queue_size = qemu_get_be16(f);
> +
> +    qemu_get_buffer(f, inflight->addr, size);
> +
> +    return 0;
> +}
> +
>  static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
>  {
>      if (!hdev->vhost_ops->vhost_set_vring_enable) {
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 08bbb4dfe9..da1f0c2361 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -402,6 +402,8 @@ int vhost_virtqueue_stop(struct vhost_dev *dev, struct VirtIODevice *vdev,
>  
>  void vhost_dev_reset_inflight(struct vhost_inflight *inflight);
>  void vhost_dev_free_inflight(struct vhost_inflight *inflight);
> +void vhost_dev_save_inflight(struct vhost_inflight *inflight, QEMUFile *f);
> +int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f);
>  int vhost_dev_prepare_inflight(struct vhost_dev *hdev, VirtIODevice *vdev);
>  int vhost_dev_set_inflight(struct vhost_dev *dev,
>                             struct vhost_inflight *inflight);
> -- 
> 2.34.1
> 

-- 
Peter Xu



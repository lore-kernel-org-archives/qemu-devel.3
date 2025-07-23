Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71422C83F25
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 06:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueTOL-0001do-Cr; Wed, 23 Jul 2025 02:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ueTKB-0006r3-8J
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 02:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ueTK5-0001IZ-26
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 02:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753253483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bz/Ej/MknY0jxtI/Xy5gekZ15vWZt6pfloiKdmMfPlA=;
 b=isWxyyYZgpI7i8EOMPOQ+zOkjPJ+DnDT6cx1bF5Wi0FpbjNIiXqdu7qLA/8spHvtqFoeV+
 jz7MkFs+pktd53sfU89M3eSiGrvBxMPXgRXAsoT1YeXIzLMUYbiU/0US8IHndWtaK6sGis
 IjFMfvOctqQrImL/cnW2H7oaWeAOC8o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-5wSVdphHPfiSlciT3NSzog-1; Wed, 23 Jul 2025 02:51:20 -0400
X-MC-Unique: 5wSVdphHPfiSlciT3NSzog-1
X-Mimecast-MFC-AGG-ID: 5wSVdphHPfiSlciT3NSzog_1753253479
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f7f1b932so4180591f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 23:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753253479; x=1753858279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bz/Ej/MknY0jxtI/Xy5gekZ15vWZt6pfloiKdmMfPlA=;
 b=tbmuVt/NZD6qQ3Yu9MXHK9LJqDyc4EjuNMytxHwkg0yA75X77P0Lq/ju6H2dIj5xq7
 30IJcmz7uWlvHFBEi+J7DM+kK2gLMLAWqoB1f8cmPP4zPDpyQ46z7ODzhwiCb04Fs8EX
 jVu1tw103UBQoaGNu33ZhbjB/aFB1yOV5gLt2Kgu7XXFjqAfLz+FZhS1cxTL+tOAyMj9
 f05votG5zDGCAmb9dGhdamfCM2hdc5FLESgCqQonSZ+8fTBLTNk+OmLuhP9eqYoM+SqY
 KIix+abEh+V7CkGFdsKbv55SSF2aQ6NpdGePqLvKI5xaNyvlzkVseJA9+WCltUWvrw2n
 yGeQ==
X-Gm-Message-State: AOJu0YwADze2f7GD9AROPJ0q1KIQ5acz/P94ajzFT1IaV+hfRw6rFKVR
 3ibjUHhc6kBXFk1rt4B/oYmmx0Al0KdOfjg3eTvoXrYq1DzwaOUx7nBQlRlz8pFHGUPfD/7n4oE
 kWdqnCEzTZMhU4hphk2KsAw9PuQnjS6X2sRmwfK9zBeMl0tIWw4eoFbTW
X-Gm-Gg: ASbGncvpMSRYsuHXzY/ZUkc1h/QWL+i834zKuKhaFcFcW2dR4gkB0W1MUPeQ+BPZNI8
 NqOS4PnuFy+PqKVUNjZPrg50+QQ4f7HNcrl70yN6q/QAknXH9rb1VWhNR169zQSerdn2aMEeHHr
 +jaS9+FEjLFJeH9ICdQqe5uvXXutfDMZyn2TZMsPDP01bYee6z6ggBek7pxdWCX4dn09LrXJzTL
 m/PY6ZnHvZjKWxUbFvfiqdaz9Wv88jE8ofXqlkWKAicLbfyX8n+5B8Pjpjykrage/tiUZpcoqmh
 4hWQN3IPPBwAvUAwDmL4fkEMNDtM3fdza7M=
X-Received: by 2002:a05:6000:24c9:b0:3a3:7baf:f06a with SMTP id
 ffacd0b85a97d-3b768ef3615mr1176826f8f.37.1753253479029; 
 Tue, 22 Jul 2025 23:51:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGorfapT+r2kUdMLcyRjeLx35WbvJVwIFv66jXQj5KJSEpYNU2Nski7dT+JiQs0Gkj+AlKVzw==
X-Received: by 2002:a05:6000:24c9:b0:3a3:7baf:f06a with SMTP id
 ffacd0b85a97d-3b768ef3615mr1176799f8f.37.1753253478489; 
 Tue, 22 Jul 2025 23:51:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c88dsm15405756f8f.60.2025.07.22.23.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 23:51:17 -0700 (PDT)
Date: Wed, 23 Jul 2025 02:51:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC 4/6] virtio-net: iter live migration - migrate vmstate
Message-ID: <20250723024406-mutt-send-email-mst@kernel.org>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-5-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722124127.2497406-5-jonah.palmer@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jul 22, 2025 at 12:41:25PM +0000, Jonah Palmer wrote:
> Lays out the initial groundwork for iteratively migrating the state of a
> virtio-net device, starting with its vmstate (via vmstate_save_state &
> vmstate_load_state).
> 
> The original non-iterative vmstate framework still runs during the
> stop-and-copy phase when the guest is paused, which is still necessary
> to migrate over the final state of the virtqueues once the sourced has
> been paused.
> 
> Although the vmstate framework is used twice (once during the iterative
> portion and once during the stop-and-copy phase), it appears that
> there's some modest improvement in guest-visible downtime when using a
> virtio-net device.
> 
> When tracing the vmstate_downtime_save and vmstate_downtime_load
> tracepoints, for a virtio-net device using iterative live migration, the
> non-iterative downtime portion improved modestly, going from ~3.2ms to
> ~1.4ms:
> 
> Before:
> -------
> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>   instance_id=0 downtime=3594
> 
> After:
> ------
> vmstate_downtime_load type=non-iterable idstr=0000:00:03.0/virtio-net
>   instance_id=0 downtime=1607
> 
> This improvement is likely due to the initial vmstate_load_state call
> (while the guest is still running) "warming up" all related pages and
> structures on the destination. In other words, by the time the final
> stop-and-copy phase starts, the heavy allocations and page-fault
> latencies are reduced, making the device re-loads slightly faster and
> the guest-visible downtime window slightly smaller.

did I get it right it's just the vmstate load for this single device?
If the theory is right, is it not possible that while the
tracepoints are now closer together, you have pushed something
else out of the cache, making the effect on guest visible downtime
unpredictable? how about the total vmstate load time?

> Future patches could improve upon this by skipping the second
> vmstate_save/load_state calls (during the stop-and-copy phase) and
> instead only send deltas right before/after the source is stopped.
> 
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/net/virtio-net.c            | 37 ++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-net.h |  8 ++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 19aa5b5936..86a6fe5b91 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3808,16 +3808,31 @@ static bool virtio_net_is_active(void *opaque)
>  
>  static int virtio_net_save_setup(QEMUFile *f, void *opaque, Error **errp)
>  {
> +    VirtIONet *n = opaque;
> +
> +    qemu_put_be64(f, VNET_MIG_F_INIT_STATE);
> +    vmstate_save_state(f, &vmstate_virtio_net, n, NULL);
> +    qemu_put_be64(f, VNET_MIG_F_END_DATA);
> +
>      return 0;
>  }
>  
>  static int virtio_net_save_live_iterate(QEMUFile *f, void *opaque)
>  {
> +    bool new_data = false;
> +
> +    if (!new_data) {
> +        qemu_put_be64(f, VNET_MIG_F_NO_DATA);
> +        return 1;
> +    }
> +
> +    qemu_put_be64(f, VNET_MIG_F_END_DATA);
>      return 1;
>  }
>  
>  static int virtio_net_save_live_complete_precopy(QEMUFile *f, void *opaque)
>  {
> +    qemu_put_be64(f, VNET_MIG_F_NO_DATA);
>      return 0;
>  }
>  
> @@ -3833,6 +3848,28 @@ static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **errp)
>  
>  static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
>  {
> +    VirtIONet *n = opaque;
> +    uint64_t flag;
> +
> +    flag = qemu_get_be64(f);
> +    if (flag == VNET_MIG_F_NO_DATA) {
> +        return 0;
> +    }
> +
> +    while (flag != VNET_MIG_F_END_DATA) {
> +        switch (flag) {
> +        case VNET_MIG_F_INIT_STATE:
> +        {
> +            vmstate_load_state(f, &vmstate_virtio_net, n, VIRTIO_NET_VM_VERSION);
> +            break;
> +        }
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Uknown flag 0x%"PRIx64, __func__, flag);
> +            return -EINVAL;
> +        }
> +
> +        flag = qemu_get_be64(f);
> +    }
>      return 0;
>  }
>  
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index b9ea9e824e..d6c7619053 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -163,6 +163,14 @@ typedef struct VirtIONetQueue {
>      struct VirtIONet *n;
>  } VirtIONetQueue;
>  
> +/*
> + * Flags to be used as unique delimiters for virtio-net devices in the
> + * migration stream.
> + */
> +#define VNET_MIG_F_INIT_STATE          (0xffffffffef200000ULL)
> +#define VNET_MIG_F_END_DATA            (0xffffffffef200001ULL)
> +#define VNET_MIG_F_NO_DATA             (0xffffffffef200002ULL)
> +
>  struct VirtIONet {
>      VirtIODevice parent_obj;
>      uint8_t mac[ETH_ALEN];
> -- 
> 2.47.1



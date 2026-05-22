Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E7ECD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 06:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQJYm-0000B6-0C; Fri, 22 May 2026 02:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wQJYc-0000AY-OB
 for qemu-devel@nongnu.org; Fri, 22 May 2026 02:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wQJYY-0002xp-GQ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 02:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779432024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QYOM3Z6mWCYWpjWptyu+tC334fXzwYTOrTkErzu5zp4=;
 b=bJjYsHOY+UmNBUqSTiU5z0rZFobAgj0/9Uey1XE9vpOHe0Q2V81rv2D4XGQ7ZdAVXG+BKG
 9rM8vEZMMnVq5yg3E0AvrNDK3DBM5iZjqwMnCPjD9JJM6JayWVEWwIXjtYuQ3yCdUBH2L+
 L3n9qLoDNLbM06c1ZFhN8i8ElfXq6BQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-UgcxlsILNSODtW20vIj9eg-1; Fri, 22 May 2026 02:40:22 -0400
X-MC-Unique: UgcxlsILNSODtW20vIj9eg-1
X-Mimecast-MFC-AGG-ID: UgcxlsILNSODtW20vIj9eg_1779432021
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-bceb2b8bc2bso485890166b.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 23:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779432021; x=1780036821; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QYOM3Z6mWCYWpjWptyu+tC334fXzwYTOrTkErzu5zp4=;
 b=oogMfugmxMkREJx2rhQxirPteA5hrmoz6hGsoKktdTy5I68nJEqKOMocX3HFGgGXRt
 zlQIqtQzGhoWSrQ0AU8fp+IX9SR4YUw6X+c43I3xe7dAc0NAJEEqqslV859dB4RmkZRK
 nZemQLRw2u2dqtabQL7oxn1+hYgoToY9aif+C2p7r737OsVmfALzTy5qaoWc+HIanF4p
 nAF3hnmArRtoRCp02CoGBRpW1bcDVaX/dcResLvxh9IuOKKYqCGWICsc3PFoU/b+iqkw
 N/To5U+cBMOjIh6psb0l+igKS+Dt/eAzr1DHu3WnjvnWwLJbCCuAlXT5Khs9QoouBper
 8nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779432021; x=1780036821;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYOM3Z6mWCYWpjWptyu+tC334fXzwYTOrTkErzu5zp4=;
 b=MjUUAWmfK4QczS0akOYsSbftB1P39J7jpxna6kslIRMLC3+wC0xMmpX+Ye1Zheci07
 u5HS6s3BSqPHJBAypQZkkVNaw7wIhhk7qvYx3KyNXY33N/vkpiag8zFPVjiliBol3Vpk
 FImMbXf63gF59SQP3J12D5empGdIJ5ffEGemqGenjzAaPD8mGkodqmqABfxfgzat+EJX
 1owWgBOaAiGwWx89fPmPq+473PNNTVhoAmGFABAh2iEWBA7V37DrBYycFDmiQxpQxo6h
 2EPJ686c8ge8QthveoxR3sCFq9d8GrMpsRTiy4Q05XRHOQKO9A/RT5dtQzfBTpWi2+e1
 FvkQ==
X-Gm-Message-State: AOJu0Yyf4LJkGgdYWeIB8i4t5diWTxidVYtMH744jpptrdHc07vRfPQw
 XjbmRrMg04zf6H3jX9EJ3OX3ruDng5ika/+fC2y6m86rmxEsRDRaeISiklxUma9afSO0K5R1H7Z
 Zh9wkLJFmA1AHDfMOc8tcRnzK4Ke1VdT7N8zNQx6wBSF4lNoXJNrs9EJy
X-Gm-Gg: Acq92OGWWC285GxEP0/MBRCt8c/3PAqBP/PClbSqz0NBxHlRPA4pWJUz7YARI2HSxng
 wIza/fgMbXLR+mjNfoqjppKDOUmUxKAYnB8gswTRZzOfsqA5i6Ko3ceUW7FJHVCslAOkYifd53z
 MRFyXTkhu829EthMrRJbHv3VlLVXNU6tw9TrbXkjTcsp56foscXz/aBgKwlnshHqSkNvuO0GrzP
 BU0FyBX0m3YdYxOF7AZFfpH1YKFJEFwxpBx0+D/JYfS/WVinpuIw0IPKjr+CEa1HMXxtxLyNf+Z
 jAL0dV3vBBvHLj2D+iLbb00LjnFfrW5DrInc8T4jaPK+u4NTyrOfwiJ1g8S1UuPvX8/PH08UQox
 54kc57JZUKw==
X-Received: by 2002:a17:907:7f94:b0:bd4:a839:9065 with SMTP id
 a640c23a62f3a-bdd27cc8467mr122209266b.37.1779432020433; 
 Thu, 21 May 2026 23:40:20 -0700 (PDT)
X-Received: by 2002:a17:907:7f94:b0:bd4:a839:9065 with SMTP id
 a640c23a62f3a-bdd27cc8467mr122206466b.37.1779432019637; 
 Thu, 21 May 2026 23:40:19 -0700 (PDT)
Received: from redhat.com ([31.187.78.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc2c4e3d5sm19786466b.15.2026.05.21.23.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:40:19 -0700 (PDT)
Date: Fri, 22 May 2026 02:40:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-qmp: use stringification in FEATURE_ENTRY to
 prevent copy-paste bugs
Message-ID: <20260522022726-mutt-send-email-mst@kernel.org>
References: <20260320193746.242704-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320193746.242704-1-jinpu.wang@ionos.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Mar 20, 2026 at 08:37:46PM +0100, Jack Wang wrote:
> The FEATURE_ENTRY macro required manually repeating the feature name
> in the description string, which led to copy-paste bugs:
>   - VIRTIO_NET_F_GUEST_USO6 had "VIRTIO_NET_F_GUEST_USO4:" prefix
>   - VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM had wrong prefix
>   - VIRTIO_I2C_F_ZERO_LENGTH_REQUEST had typo "LEGNTH"
>   - VIRTIO_MEM_F_PERSISTENT_SUSPEND had typo "SUSPND"

this mixes issues already fixed previously and issues this patch is
fixing.

no es bueno

> 
> Use C preprocessor stringification (#name) to auto-generate the
> "NAME: " prefix, eliminating this entire class of bugs. The
> description strings now contain only the human-readable part.

It's all human-readable? You just mean "now don't need to duplicate
the feature name".

> 
> The output is identical: the preprocessor concatenates #name ": "
> with the description string at compile time.

identical to what? code without the patch? no it's not? try running
the preprocessor and check the diff, and tell us in the commit log how
you did it.

And add Fixes tags please.

> 
> Link: https://lore.kernel.org/qemu-devel/20251021085833-mutt-send-email-mst@kernel.org/
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>

Sadly, I have to reject it, see docs/devel/code-provenance.rst

But maybe if you make the 1st change by hand, and ask Claude
to write a script to do the rest, then it's ok because the
output of claude is then not included in the patch.

Don't ask me why.

And please rewrite the commit log in your own words, checking
each thing to say. Because claude did a hatchet job on this.


> ---
>  hw/virtio/virtio-qmp.c | 280 ++++++++++++++++++++---------------------
>  1 file changed, 140 insertions(+), 140 deletions(-)
> 
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index f9cdca50d990..e654a59b49fe 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -34,94 +34,94 @@
>  #include "standard-headers/linux/virtio_gpio.h"
>  
>  #define FEATURE_ENTRY(name, desc) (qmp_virtio_feature_map_t) \
> -    { .virtio_bit = name, .feature_desc = desc }
> +    { .virtio_bit = name, .feature_desc = #name ": " desc }
>  
>  /* Virtio transport features mapping */
>  static const qmp_virtio_feature_map_t virtio_transport_map[] = {
>      /* Virtio device transport features */
>      FEATURE_ENTRY(VIRTIO_F_NOTIFY_ON_EMPTY, \
> -            "VIRTIO_F_NOTIFY_ON_EMPTY: Notify when device runs out of avail. "
> +            "Notify when device runs out of avail. "
>              "descs. on VQ"),
>      FEATURE_ENTRY(VIRTIO_F_ANY_LAYOUT, \
> -            "VIRTIO_F_ANY_LAYOUT: Device accepts arbitrary desc. layouts"),
> +            "Device accepts arbitrary desc. layouts"),
>      FEATURE_ENTRY(VIRTIO_F_VERSION_1, \
> -            "VIRTIO_F_VERSION_1: Device compliant for v1 spec (legacy)"),
> +            "Device compliant for v1 spec (legacy)"),
>      FEATURE_ENTRY(VIRTIO_F_IOMMU_PLATFORM, \
> -            "VIRTIO_F_IOMMU_PLATFORM: Device can be used on IOMMU platform"),
> +            "Device can be used on IOMMU platform"),
>      FEATURE_ENTRY(VIRTIO_F_RING_PACKED, \
> -            "VIRTIO_F_RING_PACKED: Device supports packed VQ layout"),
> +            "Device supports packed VQ layout"),
>      FEATURE_ENTRY(VIRTIO_F_IN_ORDER, \
> -            "VIRTIO_F_IN_ORDER: Device uses buffers in same order as made "
> +            "Device uses buffers in same order as made "
>              "available by driver"),
>      FEATURE_ENTRY(VIRTIO_F_ORDER_PLATFORM, \
> -            "VIRTIO_F_ORDER_PLATFORM: Memory accesses ordered by platform"),
> +            "Memory accesses ordered by platform"),
>      FEATURE_ENTRY(VIRTIO_F_SR_IOV, \
> -            "VIRTIO_F_SR_IOV: Device supports single root I/O virtualization"),
> +            "Device supports single root I/O virtualization"),
>      FEATURE_ENTRY(VIRTIO_F_RING_RESET, \
> -            "VIRTIO_F_RING_RESET: Driver can reset a queue individually"),
> +            "Driver can reset a queue individually"),
>      /* Virtio ring transport features */
>      FEATURE_ENTRY(VIRTIO_RING_F_INDIRECT_DESC, \
> -            "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported"),
> +            "Indirect descriptors supported"),
>      FEATURE_ENTRY(VIRTIO_RING_F_EVENT_IDX, \
> -            "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled"),
> +            "Used & avail. event fields enabled"),
>      { -1, "" }
>  };
>  
>  /* Vhost-user protocol features mapping */
>  static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_MQ, \
> -            "VHOST_USER_PROTOCOL_F_MQ: Multiqueue protocol supported"),
> +            "Multiqueue protocol supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_LOG_SHMFD, \
> -            "VHOST_USER_PROTOCOL_F_LOG_SHMFD: Shared log memory fd supported"),
> +            "Shared log memory fd supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_RARP, \
> -            "VHOST_USER_PROTOCOL_F_RARP: Vhost-user back-end RARP broadcasting "
> +            "Vhost-user back-end RARP broadcasting "
>              "supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_REPLY_ACK, \
> -            "VHOST_USER_PROTOCOL_F_REPLY_ACK: Requested operation status ack. "
> +            "Requested operation status ack. "
>              "supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_NET_MTU, \
> -            "VHOST_USER_PROTOCOL_F_NET_MTU: Expose host MTU to guest supported"),
> +            "Expose host MTU to guest supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_REQ, \
> -            "VHOST_USER_PROTOCOL_F_BACKEND_REQ: Socket fd for back-end initiated "
> +            "Socket fd for back-end initiated "
>              "requests supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CROSS_ENDIAN, \
> -            "VHOST_USER_PROTOCOL_F_CROSS_ENDIAN: Endianness of VQs for legacy "
> +            "Endianness of VQs for legacy "
>              "devices supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CRYPTO_SESSION, \
> -            "VHOST_USER_PROTOCOL_F_CRYPTO_SESSION: Session creation for crypto "
> +            "Session creation for crypto "
>              "operations supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_PAGEFAULT, \
> -            "VHOST_USER_PROTOCOL_F_PAGEFAULT: Request servicing on userfaultfd "
> +            "Request servicing on userfaultfd "
>              "for accessed pages supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIG, \
> -            "VHOST_USER_PROTOCOL_F_CONFIG: Vhost-user messaging for virtio "
> +            "Vhost-user messaging for virtio "
>              "device configuration space supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD, \
> -            "VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD: Backend fd communication "
> +            "Backend fd communication "
>              "channel supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_HOST_NOTIFIER, \
> -            "VHOST_USER_PROTOCOL_F_HOST_NOTIFIER: Host notifiers for specified "
> +            "Host notifiers for specified "
>              "VQs supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD, \
> -            "VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD: Shared inflight I/O buffers "
> +            "Shared inflight I/O buffers "
>              "supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_RESET_DEVICE, \
> -            "VHOST_USER_PROTOCOL_F_RESET_DEVICE: Disabling all rings and "
> +            "Disabling all rings and "
>              "resetting internal device state supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS, \
> -            "VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS: In-band messaging "
> +            "In-band messaging "
>              "supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS, \
> -            "VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS: Configuration for "
> +            "Configuration for "
>              "memory slots supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_STATUS, \
> -            "VHOST_USER_PROTOCOL_F_STATUS: Querying and notifying back-end "
> +            "Querying and notifying back-end "
>              "device status supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_SHARED_OBJECT, \
> -            "VHOST_USER_PROTOCOL_F_SHARED_OBJECT: Backend shared object "
> +            "Backend shared object "
>              "supported"),
>      FEATURE_ENTRY(VHOST_USER_PROTOCOL_F_DEVICE_STATE, \
> -            "VHOST_USER_PROTOCOL_F_DEVICE_STATE: Backend device state transfer "
> +            "Backend device state transfer "
>              "supported"),
>      { -1, "" }
>  };
> @@ -129,58 +129,58 @@ static const qmp_virtio_feature_map_t vhost_user_protocol_map[] = {
>  /* virtio device configuration statuses */
>  static const qmp_virtio_feature_map_t virtio_config_status_map[] = {
>      FEATURE_ENTRY(VIRTIO_CONFIG_S_DRIVER_OK, \
> -            "VIRTIO_CONFIG_S_DRIVER_OK: Driver setup and ready"),
> +            "Driver setup and ready"),
>      FEATURE_ENTRY(VIRTIO_CONFIG_S_FEATURES_OK, \
> -            "VIRTIO_CONFIG_S_FEATURES_OK: Feature negotiation complete"),
> +            "Feature negotiation complete"),
>      FEATURE_ENTRY(VIRTIO_CONFIG_S_DRIVER, \
> -            "VIRTIO_CONFIG_S_DRIVER: Guest OS compatible with device"),
> +            "Guest OS compatible with device"),
>      FEATURE_ENTRY(VIRTIO_CONFIG_S_NEEDS_RESET, \
> -            "VIRTIO_CONFIG_S_NEEDS_RESET: Irrecoverable error, device needs "
> +            "Irrecoverable error, device needs "
>              "reset"),
>      FEATURE_ENTRY(VIRTIO_CONFIG_S_FAILED, \
> -            "VIRTIO_CONFIG_S_FAILED: Error in guest, device failed"),
> +            "Error in guest, device failed"),
>      FEATURE_ENTRY(VIRTIO_CONFIG_S_ACKNOWLEDGE, \
> -            "VIRTIO_CONFIG_S_ACKNOWLEDGE: Valid virtio device found"),
> +            "Valid virtio device found"),
>      { -1, "" }
>  };
>  
>  /* virtio-blk features mapping */
>  static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_BLK_F_SIZE_MAX, \
> -            "VIRTIO_BLK_F_SIZE_MAX: Max segment size is size_max"),
> +            "Max segment size is size_max"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_SEG_MAX, \
> -            "VIRTIO_BLK_F_SEG_MAX: Max segments in a request is seg_max"),
> +            "Max segments in a request is seg_max"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_GEOMETRY, \
> -            "VIRTIO_BLK_F_GEOMETRY: Legacy geometry available"),
> +            "Legacy geometry available"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_RO, \
> -            "VIRTIO_BLK_F_RO: Device is read-only"),
> +            "Device is read-only"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_BLK_SIZE, \
> -            "VIRTIO_BLK_F_BLK_SIZE: Block size of disk available"),
> +            "Block size of disk available"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_TOPOLOGY, \
> -            "VIRTIO_BLK_F_TOPOLOGY: Topology information available"),
> +            "Topology information available"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_MQ, \
> -            "VIRTIO_BLK_F_MQ: Multiqueue supported"),
> +            "Multiqueue supported"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_DISCARD, \
> -            "VIRTIO_BLK_F_DISCARD: Discard command supported"),
> +            "Discard command supported"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_WRITE_ZEROES, \
> -            "VIRTIO_BLK_F_WRITE_ZEROES: Write zeroes command supported"),
> +            "Write zeroes command supported"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_SECURE_ERASE, \
> -            "VIRTIO_BLK_F_SECURE_ERASE: Secure erase supported"),
> +            "Secure erase supported"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_ZONED, \
> -            "VIRTIO_BLK_F_ZONED: Zoned block devices"),
> +            "Zoned block devices"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_BARRIER, \
> -            "VIRTIO_BLK_F_BARRIER: Request barriers supported"),
> +            "Request barriers supported"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_SCSI, \
> -            "VIRTIO_BLK_F_SCSI: SCSI packet commands supported"),
> +            "SCSI packet commands supported"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_FLUSH, \
> -            "VIRTIO_BLK_F_FLUSH: Flush command supported"),
> +            "Flush command supported"),
>      FEATURE_ENTRY(VIRTIO_BLK_F_CONFIG_WCE, \
> -            "VIRTIO_BLK_F_CONFIG_WCE: Cache writeback and writethrough modes "
> +            "Cache writeback and writethrough modes "
>              "supported"),
>      FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> -            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +            "Logging write descriptors supported"),
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> -            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "Vhost-user protocol features "
>              "negotiation supported"),
>      { -1, "" }
>  };
> @@ -188,31 +188,31 @@ static const qmp_virtio_feature_map_t virtio_blk_feature_map[] = {
>  /* virtio-serial features mapping */
>  static const qmp_virtio_feature_map_t virtio_serial_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_CONSOLE_F_SIZE, \
> -            "VIRTIO_CONSOLE_F_SIZE: Host providing console size"),
> +            "Host providing console size"),
>      FEATURE_ENTRY(VIRTIO_CONSOLE_F_MULTIPORT, \
> -            "VIRTIO_CONSOLE_F_MULTIPORT: Multiple ports for device supported"),
> +            "Multiple ports for device supported"),
>      FEATURE_ENTRY(VIRTIO_CONSOLE_F_EMERG_WRITE, \
> -            "VIRTIO_CONSOLE_F_EMERG_WRITE: Emergency write supported"),
> +            "Emergency write supported"),
>      { -1, "" }
>  };
>  
>  /* virtio-gpu features mapping */
>  static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_GPU_F_VIRGL, \
> -            "VIRTIO_GPU_F_VIRGL: Virgl 3D mode supported"),
> +            "Virgl 3D mode supported"),
>      FEATURE_ENTRY(VIRTIO_GPU_F_EDID, \
> -            "VIRTIO_GPU_F_EDID: EDID metadata supported"),
> +            "EDID metadata supported"),
>      FEATURE_ENTRY(VIRTIO_GPU_F_RESOURCE_UUID, \
> -            "VIRTIO_GPU_F_RESOURCE_UUID: Resource UUID assigning supported"),
> +            "Resource UUID assigning supported"),
>      FEATURE_ENTRY(VIRTIO_GPU_F_RESOURCE_BLOB, \
> -            "VIRTIO_GPU_F_RESOURCE_BLOB: Size-based blob resources supported"),
> +            "Size-based blob resources supported"),
>      FEATURE_ENTRY(VIRTIO_GPU_F_CONTEXT_INIT, \
> -            "VIRTIO_GPU_F_CONTEXT_INIT: Context types and synchronization "
> +            "Context types and synchronization "
>              "timelines supported"),
>      FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> -            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +            "Logging write descriptors supported"),
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> -            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "Vhost-user protocol features "
>              "negotiation supported"),
>      { -1, "" }
>  };
> @@ -220,9 +220,9 @@ static const qmp_virtio_feature_map_t virtio_gpu_feature_map[] = {
>  /* virtio-input features mapping */
>  static const qmp_virtio_feature_map_t virtio_input_feature_map[] = {
>      FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> -            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +            "Logging write descriptors supported"),
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> -            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "Vhost-user protocol features "
>              "negotiation supported"),
>      { -1, "" }
>  };
> @@ -230,96 +230,96 @@ static const qmp_virtio_feature_map_t virtio_input_feature_map[] = {
>  /* virtio-net features mapping */
>  static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_NET_F_CSUM, \
> -            "VIRTIO_NET_F_CSUM: Device handling packets with partial checksum "
> +            "Device handling packets with partial checksum "
>              "supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_CSUM, \
> -            "VIRTIO_NET_F_GUEST_CSUM: Driver handling packets with partial "
> +            "Driver handling packets with partial "
>              "checksum supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> -            "VIRTIO_NET_F_CTRL_GUEST_OFFLOADS: Control channel offloading "
> +            "Control channel offloading "
>              "reconfig. supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_MTU, \
> -            "VIRTIO_NET_F_MTU: Device max MTU reporting supported"),
> +            "Device max MTU reporting supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_MAC, \
> -            "VIRTIO_NET_F_MAC: Device has given MAC address"),
> +            "Device has given MAC address"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_TSO4, \
> -            "VIRTIO_NET_F_GUEST_TSO4: Driver can receive TSOv4"),
> +            "Driver can receive TSOv4"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_TSO6, \
> -            "VIRTIO_NET_F_GUEST_TSO6: Driver can receive TSOv6"),
> +            "Driver can receive TSOv6"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_ECN, \
> -            "VIRTIO_NET_F_GUEST_ECN: Driver can receive TSO with ECN"),
> +            "Driver can receive TSO with ECN"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UFO, \
> -            "VIRTIO_NET_F_GUEST_UFO: Driver can receive UFO"),
> +            "Driver can receive UFO"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HOST_TSO4, \
> -            "VIRTIO_NET_F_HOST_TSO4: Device can receive TSOv4"),
> +            "Device can receive TSOv4"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HOST_TSO6, \
> -            "VIRTIO_NET_F_HOST_TSO6: Device can receive TSOv6"),
> +            "Device can receive TSOv6"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HOST_ECN, \
> -            "VIRTIO_NET_F_HOST_ECN: Device can receive TSO with ECN"),
> +            "Device can receive TSO with ECN"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HOST_UFO, \
> -            "VIRTIO_NET_F_HOST_UFO: Device can receive UFO"),
> +            "Device can receive UFO"),
>      FEATURE_ENTRY(VIRTIO_NET_F_MRG_RXBUF, \
> -            "VIRTIO_NET_F_MRG_RXBUF: Driver can merge receive buffers"),
> +            "Driver can merge receive buffers"),
>      FEATURE_ENTRY(VIRTIO_NET_F_STATUS, \
> -            "VIRTIO_NET_F_STATUS: Configuration status field available"),
> +            "Configuration status field available"),
>      FEATURE_ENTRY(VIRTIO_NET_F_CTRL_VQ, \
> -            "VIRTIO_NET_F_CTRL_VQ: Control channel available"),
> +            "Control channel available"),
>      FEATURE_ENTRY(VIRTIO_NET_F_CTRL_RX, \
> -            "VIRTIO_NET_F_CTRL_RX: Control channel RX mode supported"),
> +            "Control channel RX mode supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_CTRL_VLAN, \
> -            "VIRTIO_NET_F_CTRL_VLAN: Control channel VLAN filtering supported"),
> +            "Control channel VLAN filtering supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_CTRL_RX_EXTRA, \
> -            "VIRTIO_NET_F_CTRL_RX_EXTRA: Extra RX mode control supported"),
> +            "Extra RX mode control supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_ANNOUNCE, \
> -            "VIRTIO_NET_F_GUEST_ANNOUNCE: Driver sending gratuitous packets "
> +            "Driver sending gratuitous packets "
>              "supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_MQ, \
> -            "VIRTIO_NET_F_MQ: Multiqueue with automatic receive steering "
> +            "Multiqueue with automatic receive steering "
>              "supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_CTRL_MAC_ADDR, \
> -            "VIRTIO_NET_F_CTRL_MAC_ADDR: MAC address set through control "
> +            "MAC address set through control "
>              "channel"),
>      FEATURE_ENTRY(VIRTIO_NET_F_NOTF_COAL, \
> -            "VIRTIO_NET_F_NOTF_COAL: Device supports coalescing notifications"),
> +            "Device supports coalescing notifications"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO4, \
> -            "VIRTIO_NET_F_GUEST_USO4: Driver can receive USOv4"),
> +            "Driver can receive USOv4"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_USO6, \
> -            "VIRTIO_NET_F_GUEST_USO6: Driver can receive USOv6"),
> +            "Driver can receive USOv6"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HOST_USO, \
> -            "VIRTIO_NET_F_HOST_USO: Device can receive USO"),
> +            "Device can receive USO"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HASH_REPORT, \
> -            "VIRTIO_NET_F_HASH_REPORT: Hash reporting supported"),
> +            "Hash reporting supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_RSS, \
> -            "VIRTIO_NET_F_RSS: RSS RX steering supported"),
> +            "RSS RX steering supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_RSC_EXT, \
> -            "VIRTIO_NET_F_RSC_EXT: Extended coalescing info supported"),
> +            "Extended coalescing info supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_STANDBY, \
> -            "VIRTIO_NET_F_STANDBY: Device acting as standby for primary "
> +            "Device acting as standby for primary "
>              "device with same MAC addr. supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_SPEED_DUPLEX, \
> -            "VIRTIO_NET_F_SPEED_DUPLEX: Device set linkspeed and duplex"),
> +            "Device set linkspeed and duplex"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GSO, \
> -            "VIRTIO_NET_F_GSO: Handling GSO-type packets supported"),
> +            "Handling GSO-type packets supported"),
>      FEATURE_ENTRY(VHOST_NET_F_VIRTIO_NET_HDR, \
> -            "VHOST_NET_F_VIRTIO_NET_HDR: Virtio-net headers for RX and TX "
> +            "Virtio-net headers for RX and TX "
>              "packets supported"),
>      FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> -            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +            "Logging write descriptors supported"),
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> -            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "Vhost-user protocol features "
>              "negotiation supported"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
> -            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
> +            "Driver can receive GSO over "
>              "UDP tunnel packets"),
>      FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
> -            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
> +            "Driver can receive GSO over "
>              "UDP tunnel packets requiring checksum offload for the outer "
>              "header"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \
> -            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
> +            "Device can receive GSO over "
>              "UDP tunnel packets"),
>      FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, \
> -            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM: Device can receive GSO over "
> +            "Device can receive GSO over "
>              "UDP tunnel packets requiring checksum offload for the outer "
>              "header"),
>      { -1, "" }
> @@ -328,20 +328,20 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>  /* virtio-scsi features mapping */
>  static const qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_SCSI_F_INOUT, \
> -            "VIRTIO_SCSI_F_INOUT: Requests including read and writable data "
> +            "Requests including read and writable data "
>              "buffers supported"),
>      FEATURE_ENTRY(VIRTIO_SCSI_F_HOTPLUG, \
> -            "VIRTIO_SCSI_F_HOTPLUG: Reporting and handling hot-plug events "
> +            "Reporting and handling hot-plug events "
>              "supported"),
>      FEATURE_ENTRY(VIRTIO_SCSI_F_CHANGE, \
> -            "VIRTIO_SCSI_F_CHANGE: Reporting and handling LUN changes "
> +            "Reporting and handling LUN changes "
>              "supported"),
>      FEATURE_ENTRY(VIRTIO_SCSI_F_T10_PI, \
> -            "VIRTIO_SCSI_F_T10_PI: T10 info included in request header"),
> +            "T10 info included in request header"),
>      FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> -            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +            "Logging write descriptors supported"),
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> -            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "Vhost-user protocol features "
>              "negotiation supported"),
>      { -1, "" }
>  };
> @@ -349,9 +349,9 @@ static const qmp_virtio_feature_map_t virtio_scsi_feature_map[] = {
>  /* virtio/vhost-user-fs features mapping */
>  static const qmp_virtio_feature_map_t virtio_fs_feature_map[] = {
>      FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> -            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +            "Logging write descriptors supported"),
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> -            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "Vhost-user protocol features "
>              "negotiation supported"),
>      { -1, "" }
>  };
> @@ -359,11 +359,11 @@ static const qmp_virtio_feature_map_t virtio_fs_feature_map[] = {
>  /* virtio/vhost-user-i2c features mapping */
>  static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_I2C_F_ZERO_LENGTH_REQUEST, \
> -            "VIRTIO_I2C_F_ZERO_LEGNTH_REQUEST: Zero length requests supported"),
> +            "Zero length requests supported"),
>      FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> -            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +            "Logging write descriptors supported"),
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> -            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "Vhost-user protocol features "
>              "negotiation supported"),
>      { -1, "" }
>  };
> @@ -371,11 +371,11 @@ static const qmp_virtio_feature_map_t virtio_i2c_feature_map[] = {
>  /* virtio/vhost-vsock features mapping */
>  static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_VSOCK_F_SEQPACKET, \
> -            "VIRTIO_VSOCK_F_SEQPACKET: SOCK_SEQPACKET supported"),
> +            "SOCK_SEQPACKET supported"),
>      FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> -            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +            "Logging write descriptors supported"),
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> -            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "Vhost-user protocol features "
>              "negotiation supported"),
>      { -1, "" }
>  };
> @@ -383,47 +383,47 @@ static const qmp_virtio_feature_map_t virtio_vsock_feature_map[] = {
>  /* virtio-balloon features mapping */
>  static const qmp_virtio_feature_map_t virtio_balloon_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_BALLOON_F_MUST_TELL_HOST, \
> -            "VIRTIO_BALLOON_F_MUST_TELL_HOST: Tell host before reclaiming "
> +            "Tell host before reclaiming "
>              "pages"),
>      FEATURE_ENTRY(VIRTIO_BALLOON_F_STATS_VQ, \
> -            "VIRTIO_BALLOON_F_STATS_VQ: Guest memory stats VQ available"),
> +            "Guest memory stats VQ available"),
>      FEATURE_ENTRY(VIRTIO_BALLOON_F_DEFLATE_ON_OOM, \
> -            "VIRTIO_BALLOON_F_DEFLATE_ON_OOM: Deflate balloon when guest OOM"),
> +            "Deflate balloon when guest OOM"),
>      FEATURE_ENTRY(VIRTIO_BALLOON_F_FREE_PAGE_HINT, \
> -            "VIRTIO_BALLOON_F_FREE_PAGE_HINT: VQ reporting free pages enabled"),
> +            "VQ reporting free pages enabled"),
>      FEATURE_ENTRY(VIRTIO_BALLOON_F_PAGE_POISON, \
> -            "VIRTIO_BALLOON_F_PAGE_POISON: Guest page poisoning enabled"),
> +            "Guest page poisoning enabled"),
>      FEATURE_ENTRY(VIRTIO_BALLOON_F_REPORTING, \
> -            "VIRTIO_BALLOON_F_REPORTING: Page reporting VQ enabled"),
> +            "Page reporting VQ enabled"),
>      { -1, "" }
>  };
>  
>  /* virtio-crypto features mapping */
>  static const qmp_virtio_feature_map_t virtio_crypto_feature_map[] = {
>      FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> -            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +            "Logging write descriptors supported"),
>      { -1, "" }
>  };
>  
>  /* virtio-iommu features mapping */
>  static const qmp_virtio_feature_map_t virtio_iommu_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_IOMMU_F_INPUT_RANGE, \
> -            "VIRTIO_IOMMU_F_INPUT_RANGE: Range of available virtual addrs. "
> +            "Range of available virtual addrs. "
>              "available"),
>      FEATURE_ENTRY(VIRTIO_IOMMU_F_DOMAIN_RANGE, \
> -            "VIRTIO_IOMMU_F_DOMAIN_RANGE: Number of supported domains "
> +            "Number of supported domains "
>              "available"),
>      FEATURE_ENTRY(VIRTIO_IOMMU_F_MAP_UNMAP, \
> -            "VIRTIO_IOMMU_F_MAP_UNMAP: Map and unmap requests available"),
> +            "Map and unmap requests available"),
>      FEATURE_ENTRY(VIRTIO_IOMMU_F_BYPASS, \
> -            "VIRTIO_IOMMU_F_BYPASS: Endpoints not attached to domains are in "
> +            "Endpoints not attached to domains are in "
>              "bypass mode"),
>      FEATURE_ENTRY(VIRTIO_IOMMU_F_PROBE, \
> -            "VIRTIO_IOMMU_F_PROBE: Probe requests available"),
> +            "Probe requests available"),
>      FEATURE_ENTRY(VIRTIO_IOMMU_F_MMIO, \
> -            "VIRTIO_IOMMU_F_MMIO: VIRTIO_IOMMU_MAP_F_MMIO flag available"),
> +            "VIRTIO_IOMMU_MAP_F_MMIO flag available"),
>      FEATURE_ENTRY(VIRTIO_IOMMU_F_BYPASS_CONFIG, \
> -            "VIRTIO_IOMMU_F_BYPASS_CONFIG: Bypass field of IOMMU config "
> +            "Bypass field of IOMMU config "
>              "available"),
>      { -1, "" }
>  };
> @@ -431,12 +431,12 @@ static const qmp_virtio_feature_map_t virtio_iommu_feature_map[] = {
>  /* virtio-mem features mapping */
>  static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_MEM_F_ACPI_PXM, \
> -            "VIRTIO_MEM_F_ACPI_PXM: node_id is an ACPI PXM and is valid"),
> +            "node_id is an ACPI PXM and is valid"),
>      FEATURE_ENTRY(VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, \
> -            "VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE: Unplugged memory cannot be "
> +            "Unplugged memory cannot be "
>              "accessed"),
>      FEATURE_ENTRY(VIRTIO_MEM_F_PERSISTENT_SUSPEND, \
> -            "VIRTIO_MEM_F_PERSISTENT_SUSPND: Plugged memory will remain "
> +            "Plugged memory will remain "
>              "plugged when suspending+resuming"),
>      { -1, "" }
>  };
> @@ -444,9 +444,9 @@ static const qmp_virtio_feature_map_t virtio_mem_feature_map[] = {
>  /* virtio-rng features mapping */
>  static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
>      FEATURE_ENTRY(VHOST_F_LOG_ALL, \
> -            "VHOST_F_LOG_ALL: Logging write descriptors supported"),
> +            "Logging write descriptors supported"),
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> -            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "Vhost-user protocol features "
>              "negotiation supported"),
>      { -1, "" }
>  };
> @@ -454,9 +454,9 @@ static const qmp_virtio_feature_map_t virtio_rng_feature_map[] = {
>  /* virtio/vhost-gpio features mapping */
>  static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
>      FEATURE_ENTRY(VIRTIO_GPIO_F_IRQ, \
> -            "VIRTIO_GPIO_F_IRQ: Device supports interrupts on GPIO lines"),
> +            "Device supports interrupts on GPIO lines"),
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
> -            "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
> +            "Vhost-user protocol features "
>              "negotiation supported"),
>      { -1, "" }
>  };
> -- 
> 2.43.0



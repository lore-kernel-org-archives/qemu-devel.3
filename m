Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F44C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWQm-0008AU-T5; Fri, 07 Mar 2025 07:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqWQe-00081y-Bi
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:03:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqWQX-0001mX-Gw
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741349007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+bvdG/8c8QLv7doLgRj+bx8NIl5Nb9YX2WDMuGGDCkI=;
 b=ArSGBC34gUCJRmXAgNfyvaXKFR9ecKgmYCdLGsc/n0bDsNpcZeTqlWyA5i7bhaCcGgr3z3
 aBUUI+vPiNGTQLW0DrLprZYhbcM29+1JzldOkxpuue7JctUOB1tc+rLkc28TLK2NWn1UqO
 K3s7/P9nhXVCXcNIhZESl2s7LLVBKE8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-lvC7fCheM_Gj90KKpmoxyQ-1; Fri, 07 Mar 2025 07:03:25 -0500
X-MC-Unique: lvC7fCheM_Gj90KKpmoxyQ-1
X-Mimecast-MFC-AGG-ID: lvC7fCheM_Gj90KKpmoxyQ_1741349005
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390eefb2913so1238937f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741349005; x=1741953805;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bvdG/8c8QLv7doLgRj+bx8NIl5Nb9YX2WDMuGGDCkI=;
 b=GoCUKpp+7QIb69ujIFHk6OIQJ6TCiSgMKr1ojKh6DZLkixsZJUm3InhEMdRAwB7wSq
 SSmP1l0oWooO52l13v8iMph0HJJOCRtqbNBso45LqpWpmxouSJ+m01ltNaa6+9Xq/pya
 PbYtp0bmdWJSSvG2Y8A2T8fyKn6pTdAjicRYOi3tnkp3TjhTS77tSDfXnfNqx7GziQi3
 JCA7lB1nAjAasb3opTe3C3idmov27fompzF+YCi3VpHIyt5c0Nd7wrPo7nt/epgLqZIB
 04aQVx1ECOnSrCuMWetGjBIxvUQSfMNENawNJkDeJdXH91I8nc6wwBrO8r5fGuBXYFUF
 yCNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeBSTMiZzxHVap/5Emn1F1XCQTpXIqMe5iGmAf7UI4UaB1pmqMhB2F1PGNeqaGam+5HThhhGZXjEkj@nongnu.org
X-Gm-Message-State: AOJu0Yw0PzItb484uIPHuQbE5wD6y7vVZ0v2S9OZYwI5gXtDNn0l6BaC
 TVwpMY5Zq2yLwviCof0c26ZvDyzzWMdMakn/Rzh85A8zAovLLQHYGyNN9qgFqxLc8pbSsWQkKJY
 NSZgd+BXgKPAQMl27O4adoSXn12NhZbklvfsIW+CFQkj29EhXbyll
X-Gm-Gg: ASbGncv0+ctMKK8DtMhNrBapi6KPCoyWijd7QXMVNaHSeNgpUFTNz0Ra05xzDoe6fTk
 c14Qw3P9ybx4lLYnnJG3PRovmSE1XjoC9bbrIsu9uSiSo4LKQtT0mKzFsDu77abS4ZlWFKjwsyA
 pTj/LjAm9XMx5PHjT7oPgbeAsxLhtvzm2gzUiOcJGUnnngvSnzWW0hw3khAWZ0M48WkXEbpYVaP
 mLyJEGbRlw6SvKLLUvBgE26RVGXmGh6AvtpyJQfH7MtA+aulkv6zErMHkaonA/DHCVB9dR41kRv
 uR3nTu5HaaFrNw7vumQlKCYQGECceC4atst1zZPMX+04jhDoVsvu6w==
X-Received: by 2002:adf:ab15:0:b0:391:3406:b4e1 with SMTP id
 ffacd0b85a97d-3913406b6admr1295018f8f.15.1741349004603; 
 Fri, 07 Mar 2025 04:03:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJq65yV5QtG6rLOLOSXOHkBamfYDBcEHyFWNsX/fcqR6cimzxmLK//N4j3G+eoRLviJlF17w==
X-Received: by 2002:adf:ab15:0:b0:391:3406:b4e1 with SMTP id
 ffacd0b85a97d-3913406b6admr1294973f8f.15.1741349004074; 
 Fri, 07 Mar 2025 04:03:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfe0004sm5025862f8f.40.2025.03.07.04.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 04:03:22 -0800 (PST)
Message-ID: <abc049f2-3497-4557-89c8-74bcfaea221c@redhat.com>
Date: Fri, 7 Mar 2025 13:03:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/migration: Add also max in-flight VFIO device
 state buffers size limit
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <2b2469939198c2f31dba33b284576d2df22697b7.1741344976.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <2b2469939198c2f31dba33b284576d2df22697b7.1741344976.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 3/7/25 11:57, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> There's already a max in-flight VFIO device state buffers *count* limit,

no. there isn't. Do we need both ?

> add also max queued buffers *size* limit.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   docs/devel/migration/vfio.rst |  8 +++++---
>   hw/vfio/migration-multifd.c   | 21 +++++++++++++++++++--
>   hw/vfio/pci.c                 |  9 +++++++++
>   include/hw/vfio/vfio-common.h |  1 +
>   4 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> index 7c9cb7bdbf87..127a1db35949 100644
> --- a/docs/devel/migration/vfio.rst
> +++ b/docs/devel/migration/vfio.rst
> @@ -254,12 +254,14 @@ This means that a malicious QEMU source could theoretically cause the target
>   QEMU to allocate unlimited amounts of memory for such buffers-in-flight.
>   
>   The "x-migration-max-queued-buffers" property allows capping the maximum count
> -of these VFIO device state buffers queued at the destination.
> +of these VFIO device state buffers queued at the destination while
> +"x-migration-max-queued-buffers-size" property allows capping their total queued
> +size.
>   
>   Because a malicious QEMU source causing OOM on the target is not expected to be
>   a realistic threat in most of VFIO live migration use cases and the right value
> -depends on the particular setup by default this queued buffers limit is
> -disabled by setting it to UINT64_MAX.
> +depends on the particular setup by default these queued buffers limits are
> +disabled by setting them to UINT64_MAX.
>   
>   Some host platforms (like ARM64) require that VFIO device config is loaded only
>   after all iterables were loaded.
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index dccd763d7c39..a9d41b9f1cb1 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -83,6 +83,7 @@ typedef struct VFIOMultifd {
>       uint32_t load_buf_idx;
>       uint32_t load_buf_idx_last;
>       uint32_t load_buf_queued_pending_buffers;

'load_buf_queued_pending_buffers' is not in mainline. Please rebase.


Thanks,

C.



> +    size_t load_buf_queued_pending_buffers_size;
>   } VFIOMultifd;
>   
>   static void vfio_state_buffer_clear(gpointer data)
> @@ -139,6 +140,7 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>       VFIOMigration *migration = vbasedev->migration;
>       VFIOMultifd *multifd = migration->multifd;
>       VFIOStateBuffer *lb;
> +    size_t data_size = packet_total_size - sizeof(*packet);
>   
>       vfio_state_buffers_assert_init(&multifd->load_bufs);
>       if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
> @@ -165,8 +167,19 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>           return false;
>       }
>   
> -    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
> -    lb->len = packet_total_size - sizeof(*packet);
> +    multifd->load_buf_queued_pending_buffers_size += data_size;
> +    if (multifd->load_buf_queued_pending_buffers_size >
> +        vbasedev->migration_max_queued_buffers_size) {
> +        error_setg(errp,
> +                   "%s: queuing state buffer %" PRIu32
> +                   " would exceed the size max of %" PRIu64,
> +                   vbasedev->name, packet->idx,
> +                   vbasedev->migration_max_queued_buffers_size);
> +        return false;
> +    }
> +
> +    lb->data = g_memdup2(&packet->data, data_size);
> +    lb->len = data_size;
>       lb->is_present = true;
>   
>       return true;
> @@ -346,6 +359,9 @@ static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
>           assert(wr_ret <= buf_len);
>           buf_len -= wr_ret;
>           buf_cur += wr_ret;
> +
> +        assert(multifd->load_buf_queued_pending_buffers_size >= wr_ret);
> +        multifd->load_buf_queued_pending_buffers_size -= wr_ret;
>       }
>   
>       trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
> @@ -519,6 +535,7 @@ static VFIOMultifd *vfio_multifd_new(void)
>       multifd->load_buf_idx = 0;
>       multifd->load_buf_idx_last = UINT32_MAX;
>       multifd->load_buf_queued_pending_buffers = 0;
> +    multifd->load_buf_queued_pending_buffers_size = 0;
>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>   
>       multifd->load_bufs_iter_done = false;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 02f784c1b2a3..8abf73f810ee 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3392,6 +3392,8 @@ static const Property vfio_pci_dev_properties[] = {
>                               ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
>                          vbasedev.migration_max_queued_buffers, UINT64_MAX),
> +    DEFINE_PROP_SIZE("x-migration-max-queued-buffers-size", VFIOPCIDevice,
> +                     vbasedev.migration_max_queued_buffers_size, UINT64_MAX),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> @@ -3581,6 +3583,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>                                             "destination when doing live "
>                                             "migration of device state via "
>                                             "multifd channels");
> +    object_class_property_set_description(klass, /* 10.0 */
> +                                          "x-migration-max-queued-buffers-size",
> +                                          "Maximum size of in-flight VFIO "
> +                                          "device state buffers queued at the "
> +                                          "destination when doing live "
> +                                          "migration of device state via "
> +                                          "multifd channels");
>   }
>   
>   static const TypeInfo vfio_pci_dev_info = {
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c8ff4252e24a..fff2f35754b2 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -158,6 +158,7 @@ typedef struct VFIODevice {
>       OnOffAuto migration_multifd_transfer;
>       OnOffAuto migration_load_config_after_iter;
>       uint64_t migration_max_queued_buffers;
> +    uint64_t migration_max_queued_buffers_size;
>       bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
> 



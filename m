Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E52C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpkv1-0004Aj-RQ; Wed, 05 Mar 2025 04:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkv0-0004AT-5T
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpkux-0008Pz-DO
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741166393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+jvAaEKEOT/bFVJGcqRekiKRc04zqrCansVkdphujfw=;
 b=Wuych4iI+HuZwrSiNmRG/5q0n1bWsO9hXlRlFQY0FpFLvVCiaBve5Znycxr0dUpw0Adt49
 aHHBD4qdJf3atc2f52L/Bke7zTeZTdaZsP4nQNAPfDnf2vTSsVsu4Jn5frTQxVXHqWZ9Sb
 n2uh1B2JbpBiNYv5+gRPbufOj+rkL6Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-3nwlRqdlO3ePgMf9zyxv2w-1; Wed, 05 Mar 2025 04:19:46 -0500
X-MC-Unique: 3nwlRqdlO3ePgMf9zyxv2w-1
X-Mimecast-MFC-AGG-ID: 3nwlRqdlO3ePgMf9zyxv2w_1741166385
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43bcddbe609so12573375e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 01:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741166385; x=1741771185;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jvAaEKEOT/bFVJGcqRekiKRc04zqrCansVkdphujfw=;
 b=E76xSNRv+z5Gzoi5N6FD7aPeTxP1xvCxHVmUneb9upEf3Ug4deEqtacdPKresQqwi8
 +XxrcQD5Kxvtp4gzdYpKiBOp701kOFZaSDXGWeuDvz8fYQVFmR2AE5Z8oQ3j5qjqJYk7
 DSBShdzlWTtajW6iIXPaC9Gfkjz36dDXAkWOYjHa0Vq1SpMplx3xjm8OwWxvhCRB4Vp1
 8/9LUmZMG+aN4YK+64kDiS64nbYHLjxBwAiij70Yq8Z0rxazPLzx0pqopOzzsP/bCjE+
 ziKSq9Vh1tY/GSAnOhMt6odLB8ritIgL4+K2Y75Rzg1+2oGKhUFyUu/Fy1P/+8X05kYR
 NETA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKNmXMCqNmGX/scHHA70E/J9QZ/tYdD3lYqgnmunLR7xEhSZjxqehbsP5bWM72UJ/19TeYBF4HHfNT@nongnu.org
X-Gm-Message-State: AOJu0Yw//tf7w2Q1ZVR9e/aLSX4FKF5imEmCnrhxokrMz/1KPInSehTa
 yNyr6GagPGZ/zYcaoOjlgaKvLmzEPBJCBsP8u5PqRX6Kh04nANoondvLmnaPfOM+cijaOyiA3nq
 oJ2NOzyv6N0h7H90glutvIJg2vbFBFTBphPcP41hcj4hx6H4EKBN5
X-Gm-Gg: ASbGnctdsNNmqaZ/32rd4HFY45ASDUK+YrT1NEEvXBQp//1r2OEfwqig3TukUocn+NO
 PXRiMtzZc9QsTzghbXSUtWU2NttvXICVSi/muhFvY9Phut89rZ7qEKd2L3wNIiAWOwGtFeCqXuf
 3ebotzlXAxYkeY3BYrbj6A3q1S3OPftwybqWZYzHTwPNYeE1TLpAnVXgCctAY7AU6ED6y8hGJjB
 MSSPOH62YUY0nGSpuozYuA9s5uMD4orc/0wtu0d7ltRUCmekfgLbabo0C2tV6Ycwa9+yxJI/qDZ
 cKZ4bJrm9LdEYNl4HRj2hICvdE0efTckSLPbzzO3XJhwouYWPq0lUw==
X-Received: by 2002:a05:600c:1c07:b0:439:9a40:aa0b with SMTP id
 5b1f17b1804b1-43bd29d0474mr14818935e9.25.1741166385069; 
 Wed, 05 Mar 2025 01:19:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9kkLo0enzvlc3UuOFapPysVR+ICiOT7IweMM5F0tvYTGXnRQJpgdoljhrMHPazsJJI6yFYw==
X-Received: by 2002:a05:600c:1c07:b0:439:9a40:aa0b with SMTP id
 5b1f17b1804b1-43bd29d0474mr14818645e9.25.1741166384681; 
 Wed, 05 Mar 2025 01:19:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42b7478sm11499425e9.17.2025.03.05.01.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 01:19:43 -0800 (PST)
Message-ID: <3f7bc3ad-20eb-447c-ae1c-14d6e2072206@redhat.com>
Date: Wed, 5 Mar 2025 10:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 34/36] vfio/migration: Max in-flight VFIO device state
 buffer count limit
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <09463235e0aa30e48e40bd6c89d07f56f4140a93.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <09463235e0aa30e48e40bd6c89d07f56f4140a93.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/4/25 23:04, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Allow capping the maximum count of in-flight VFIO device state buffers
> queued at the destination, otherwise a malicious QEMU source could
> theoretically cause the target QEMU to allocate unlimited amounts of memory
> for buffers-in-flight.
> 
> Since this is not expected to be a realistic threat in most of VFIO live
> migration use cases and the right value depends on the particular setup
> disable the limit by default by setting it to UINT64_MAX.

I agree with Avihai that a limit on bytes would make more sense.
-rc0 is in ~2w. We have time to prepare a patch for this.


Should there be a correlation with :

     /*
      * This is an arbitrary size based on migration of mlx5 devices, where typically
      * total device migration size is on the order of 100s of MB. Testing with
      * larger values, e.g. 128MB and 1GB, did not show a performance improvement.
      */
     #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
     
Thanks,

C.





> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c   | 16 ++++++++++++++++
>   hw/vfio/pci.c                 |  9 +++++++++
>   include/hw/vfio/vfio-common.h |  1 +
>   3 files changed, 26 insertions(+)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 233724710b37..d6dabaf869ca 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -54,6 +54,7 @@ typedef struct VFIOMultifd {
>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>       uint32_t load_buf_idx;
>       uint32_t load_buf_idx_last;
> +    uint32_t load_buf_queued_pending_buffers;
>   } VFIOMultifd;
>   
>   static void vfio_state_buffer_clear(gpointer data)
> @@ -125,6 +126,17 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>   
>       assert(packet->idx >= multifd->load_buf_idx);
>   
> +    multifd->load_buf_queued_pending_buffers++;
> +    if (multifd->load_buf_queued_pending_buffers >
> +        vbasedev->migration_max_queued_buffers) {
> +        error_setg(errp,
> +                   "%s: queuing state buffer %" PRIu32
> +                   " would exceed the max of %" PRIu64,
> +                   vbasedev->name, packet->idx,
> +                   vbasedev->migration_max_queued_buffers);
> +        return false;
> +    }
> +
>       lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
>       lb->len = packet_total_size - sizeof(*packet);
>       lb->is_present = true;
> @@ -381,6 +393,9 @@ static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
>               goto thread_exit;
>           }
>   
> +        assert(multifd->load_buf_queued_pending_buffers > 0);
> +        multifd->load_buf_queued_pending_buffers--;
> +
>           if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
>               trace_vfio_load_state_device_buffer_end(vbasedev->name);
>           }
> @@ -417,6 +432,7 @@ static VFIOMultifd *vfio_multifd_new(void)
>   
>       multifd->load_buf_idx = 0;
>       multifd->load_buf_idx_last = UINT32_MAX;
> +    multifd->load_buf_queued_pending_buffers = 0;
>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>   
>       multifd->load_bufs_thread_running = false;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 21605bac2fb0..ce407f971000 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3383,6 +3383,8 @@ static const Property vfio_pci_dev_properties[] = {
>                   vbasedev.migration_multifd_transfer,
>                   vfio_pci_migration_multifd_transfer_prop, OnOffAuto,
>                   .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
> +                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> @@ -3444,6 +3446,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>                                             "x-migration-multifd-transfer",
>                                             "Transfer this device state via "
>                                             "multifd channels when live migrating it");
> +    object_class_property_set_description(klass, /* 10.0 */
> +                                          "x-migration-max-queued-buffers",
> +                                          "Maximum count of in-flight VFIO "
> +                                          "device state buffers queued at the "
> +                                          "destination when doing live "
> +                                          "migration of device state via "
> +                                          "multifd channels");
>   }
>   
>   static const TypeInfo vfio_pci_dev_info = {
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 04b123a6c929..c033c3c5134f 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -155,6 +155,7 @@ typedef struct VFIODevice {
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
> +    uint64_t migration_max_queued_buffers;
>       bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;
> 



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61771C19F38
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 06:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXhU-0003p9-4z; Thu, 27 Feb 2025 01:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnXhS-0003ok-H8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnXhP-00047d-J8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 01:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740638926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YDRgC2r4qvEOH5M7dh2YeBXmzdJP9fxpZ7qkSbBZgEY=;
 b=I+qfD7IJAcq80JVuUcQJL6ADhmeJ9oD2loqRDed/zS7zNMg+OfzCOkSGiBkWSPdAPlU6Ug
 LK3rcQJvvoOoaRN6nsy3ESAocAO5Jbsu0hDhz+ivUGYYU3/8dRzV41lxx1Mh9I311akMdP
 HshiTXde5EkHBXoepAMOWl629JLd3X8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-JMBPRr7YM1myLoVNQeNUxg-1; Thu, 27 Feb 2025 01:48:43 -0500
X-MC-Unique: JMBPRr7YM1myLoVNQeNUxg-1
X-Mimecast-MFC-AGG-ID: JMBPRr7YM1myLoVNQeNUxg_1740638922
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so4706985e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 22:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740638922; x=1741243722;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YDRgC2r4qvEOH5M7dh2YeBXmzdJP9fxpZ7qkSbBZgEY=;
 b=VrVbAEfwmstKn7CFQWSu6zOiO1F1SjYy5UfcPUq9tBDQo3KEJhCdRXoeMwVNYD0nWR
 A2lUDBDdUeZLK9XOi1p5b05vNNyHCEGbIg6J3hJYKkHDd2B8ellT8z4G17hth4+HCjcf
 MJIbf+AGNkT/X/HGYMtaneWS+kDMsT1V/SMiCaSlzTTCHZlatnICFQU8MI+0i5kQm4hF
 R2hgyFTEE6kA3F3dcMga7fJU/oLNkP00Kn4iv1dSkdvNiu8fpjpBtkHImoQ1wmaCJFNQ
 ktaegmsrum8YQvl8MJ+skHnUXjnVUzyFxeTiNofgaMRi38/J/Hze/Jh/1ND5z++nDzPO
 u0Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1pi5VsHNsOWRsllDjLykSp98uuFGGLfuizOO+0PrG0dEmKfw+3hwWpFOA4ZP0inp5rBlmo0doR/2Z@nongnu.org
X-Gm-Message-State: AOJu0Yz92x2c+tPg2Hhz//ZdUu/N+DUiDAf5Z49AYk1OuOWyuBeSb4tj
 Fv3kviJy9hjO2nUlmmTVMr0AuS2sgIhhAmf297Rrrq3YiwsvYlpBNFFAkLjk6jibBP4X0DCi+ZX
 vXpbvBK6yEhvYJ2OTREODoryw4JW3DSUqLky43tjaiCjloGbGFt0K
X-Gm-Gg: ASbGncsGzhfdF2MLKUucD5McTL9kvyWa5aP+p5YJ2l/7HQqggMkIuLjALj0/fdQJVkS
 j8jOZwvWDZRhTGgxHxgsR5rN8vRyPWHXijU9RDhtNoHynpokjlGfbXXXoGPOfh+mAp+ZtBKaxad
 ++l0CIz8mDAlUYNiL3aAZe8dCAE7CC7iYJAY/a5QPVooeLssVke5YYBHGQQFMwY5sVKg4YDEjZU
 YiL7Ry2H3emDHrcAblTtFr2z4BafitXNl76DruH1UbxtwleR2n9gk+KAwXzIgaS52bYhYKQ9X0d
 i29ryExvdvTYRa4CHbiYbBzG6JAAlVCcjqJgdAJmFvlfQv0DpA/TaxTJ7i4=
X-Received: by 2002:a05:600c:4f0b:b0:439:95b9:91fc with SMTP id
 5b1f17b1804b1-43ab8fd8c93mr50349075e9.12.1740638922449; 
 Wed, 26 Feb 2025 22:48:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZDsAs9ou/DgimHlAc7eX8KpBMrzNCHF//ShyaUm8rwySbs1zk36X55POaPuN5aMWKcSe6ow==
X-Received: by 2002:a05:600c:4f0b:b0:439:95b9:91fc with SMTP id
 5b1f17b1804b1-43ab8fd8c93mr50348925e9.12.1740638922034; 
 Wed, 26 Feb 2025 22:48:42 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795d30sm1048245f8f.10.2025.02.26.22.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 22:48:41 -0800 (PST)
Message-ID: <11ecf7fb-55f6-4606-b635-e53dbcc71dbc@redhat.com>
Date: Thu, 27 Feb 2025 07:48:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 34/36] vfio/migration: Max in-flight VFIO device state
 buffer count limit
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <719b309bb7bc13542d14e6ce0026cb9bb67e9f31.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <719b309bb7bc13542d14e6ce0026cb9bb67e9f31.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
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
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c   | 14 ++++++++++++++
>   hw/vfio/pci.c                 |  2 ++
>   include/hw/vfio/vfio-common.h |  1 +
>   3 files changed, 17 insertions(+)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 18a5ff964a37..04aa3f4a6596 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -53,6 +53,7 @@ typedef struct VFIOMultifd {
>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>       uint32_t load_buf_idx;
>       uint32_t load_buf_idx_last;
> +    uint32_t load_buf_queued_pending_buffers;
>   } VFIOMultifd;
>   
>   static void vfio_state_buffer_clear(gpointer data)
> @@ -121,6 +122,15 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>   
>       assert(packet->idx >= multifd->load_buf_idx);
>   
> +    multifd->load_buf_queued_pending_buffers++;
> +    if (multifd->load_buf_queued_pending_buffers >
> +        vbasedev->migration_max_queued_buffers) {
> +        error_setg(errp,
> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
> +                   packet->idx, vbasedev->migration_max_queued_buffers);
> +        return false;
> +    }
> +
>       lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
>       lb->len = packet_total_size - sizeof(*packet);
>       lb->is_present = true;
> @@ -374,6 +384,9 @@ static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
>               goto ret_signal;
>           }
>   
> +        assert(multifd->load_buf_queued_pending_buffers > 0);
> +        multifd->load_buf_queued_pending_buffers--;
> +
>           if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
>               trace_vfio_load_state_device_buffer_end(vbasedev->name);
>           }
> @@ -408,6 +421,7 @@ VFIOMultifd *vfio_multifd_new(void)
>   
>       multifd->load_buf_idx = 0;
>       multifd->load_buf_idx_last = UINT32_MAX;
> +    multifd->load_buf_queued_pending_buffers = 0;
>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>   
>       multifd->load_bufs_thread_running = false;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9111805ae06c..247418f0fce2 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3383,6 +3383,8 @@ static const Property vfio_pci_dev_properties[] = {
>                   vbasedev.migration_multifd_transfer,
>                   qdev_prop_on_off_auto_mutable, OnOffAuto,
>                   .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
> +                       vbasedev.migration_max_queued_buffers, UINT64_MAX),

UINT64_MAX doesn't make sense to me. What would be a reasonable value ?

Have you monitored the max ? Should we collect some statistics on this
value and raise a warning if a high water mark is reached ? I think
this would more useful.

>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),


Please add property documentation in vfio_pci_dev_class_init()


Thanks,

C.


> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 3006931accf6..30a5bb9af61b 100644
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


